# Import modules and packaages
import discord
import os
import asyncio
from discord.ext import commands
from llamaAi import chat
from dotenv import load_dotenv

# Load secrets
load_dotenv() 
DISCORD_BOT_TOKEN = os.getenv("DISCORD_BOT_TOKEN")

# Configure Discord bot
intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix="-", intents=intents)

@bot.command()
async def chatbot(ctx, *, prompt: str):
    res = await chat(prompt)
    print(res)
    await ctx.send(res)

bot.run(DISCORD_BOT_TOKEN)