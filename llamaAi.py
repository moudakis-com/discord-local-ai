from ollama import AsyncClient
import sqlite3
import os

DB_FILE = "preferences.db"

# Set up database for prompt, response and user id for history
def init_db():
  conn = sqlite3.connect(DB_FILE)
  cursor = conn.cursor()
  cursor.execute("""
      CREATE TABLE IF NOT EXISTS user_preferences (
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
                 user_id TEXT,
                 prompt TEXT,
                 response TEXT
                 )
  """)
  conn.commit()
  conn.close()

init_db()

# Function to update prompt and response
async def updatePreferences(prompt, response, uid):
  conn = sqlite3.connect(DB_FILE)
  cursor = conn.cursor()
  cursor.execute("""
      INSERT INTO user_preferences (user_id, prompt, response)
      VALUES (?, ?, ?) 
  """, (uid, prompt, response))
  conn.commit()
  conn.close()

# Function to get preferences
def getPreferences(uid):
    conn = sqlite3.connect(DB_FILE)
    cursor = conn.cursor()
    cursor.execute("SELECT prompt, response FROM user_preferences WHERE user_id = ? ORDER BY id ASC", (uid,))
    rows = cursor.fetchall()
    conn.close()
    return [{'prompt': row[0], 'response': row[1]} for row in rows]

# Calling the llama3.2 model to with access to users past prompts and responses
async def chat(usrInput, uid):
  messages = []
  prefs = getPreferences(uid)
  for pair in prefs:
      messages.append({'role': 'user', 'content': pair['prompt']})
      messages.append({'role': 'user', 'content': pair['response']})
  messages.append({'role': 'user', 'content': usrInput})
  response = await AsyncClient().chat(model='llama3.2', messages=messages)
  await updatePreferences(str(usrInput), str(response), uid)
  return response['message']['content']