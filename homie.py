# Import modules and packaages
import discord
import os
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

# Dictionary to track previous processing messages to delete after
bot_command_messages = {}  

# Split text into 1010 or less size accounting for spacing
# This is for discords 1024 embed limit. 14 Charaters are left for error correction and title
def chunk_text(text, limit=1010):
    chunks = []
    while len(text) > limit:
        split_point = text.rfind('\n\n', 0, limit)
        if split_point == -1:
            split_point = text.rfind('\n', 0, limit)  # Fallback to single newline
        chunks.append(text[:split_point].strip())
        text = text[split_point:].strip()
    if text:
        chunks.append(text)
    return chunks

@bot.command()
async def ai(ctx, *, prompt: str):
    guild_id = ctx.guild.id

    # Send the Processing Embedded Message
    embed = discord.Embed(color=discord.Color.yellow())
    embed.add_field(name="Prompt", value=prompt, inline=False)
    embed.add_field(name="Status", value="Processing", inline=False)
    message = await ctx.send(embed=embed)
    bot_command_messages[guild_id] = message

    # Send chat
    try:
        res = await chat(prompt + " --no-markdown")
    except Exception as e:
        # Send the Error Embedded Message
        embed = discord.Embed(color=discord.Color.red())
        embed.add_field(name="Prompt", value=prompt, inline=False)
        embed.add_field(name="Status", value="Failed", inline=False)
        message = await ctx.send(embed=embed)
        await ctx.send("ERROR: " + e)

    if guild_id in bot_command_messages:
        try: 
            await bot_command_messages[guild_id].delete()
        except discord.NotFound:
            pass
    
    # Send Success Embedded Message
    embed = discord.Embed(color=discord.Color.green())
    embed.add_field(name="Prompt", value=prompt, inline=False)
    embed.add_field(name="Status", value="Success", inline=False)
    message = await ctx.send(embed=embed)

    # Send embeded messages with the response
    chunks = chunk_text(res)
    for i, chunk in enumerate(chunks, 1):
        embed = discord.Embed(color=discord.Color.blue())
        if i == 1:
            embed.add_field(name=f"Response", value=chunk, inline=False)
        else:
            embed.add_field(name="", value=chunk, inline=False)
        await ctx.send(embed=embed)

bot.run(DISCORD_BOT_TOKEN)