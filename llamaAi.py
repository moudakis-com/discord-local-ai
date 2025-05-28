import asyncio
from ollama import AsyncClient

async def chat(usrInput):
  message = {'role': 'user', 'content': usrInput}
  response = await AsyncClient().chat(model='llama3.2', messages=[message])
  return response['message']['content']

# asyncio.run(chat("Test Prompt")))