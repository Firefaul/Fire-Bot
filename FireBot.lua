local discordia = require('discordia')
local client = discordia.Client()
local FireId = "287768986878214144"

client:on('ready', function()
	print('Logged in as '.. client.user.username)
	client:setGame("!fire help")
end)

local Insult1 = {"hair", "face", "arm", "leg", "head"}
local Insult2 = {"stupid", "ugly", "skinny", "thicc", "invisible", "short", "long"}
local Insult3 = {"you can't ride a bike", "your mirror breaks when you look at it", "it's nonexistant", "you're stupid", "you look like Peter Pan"}

function RandomFromTable(Table)
	return Table[math.random(1, #Table)]
end
client:on('messageCreate', function(message)
	if message.content:lower() == '!fire ping' then
		message.channel:send('Pong!')
	elseif message.content:lower() == "!fire help" then
		message.author:send {
			embed = {
				title = "Hey there, "..message.author.username.."! Here's a list of commands you can try!",
				fields = {
					{name = "!fire ping", value = "I'll reply with 'Pong' after I register what you said!", inline = true},
					{name = "!fire help", value = "I'll message you with what you're seeing right here!", inline = true},
					{name = "!fire roastme", value = "I'll attempt to roast you with some lit insults, fam!", inline = true},
					{name = "!fire roast @user", value = "I'll attempt to roast another user, similarly to !fire roastme!", inline = true},
				},
				color = discordia.Color.fromRGB(255, 105, 97).value
			}
		}
	elseif message.content:lower() == "!fire reload" and message.author.username == "Jeta // Festivefaul" then
		print('Restarting')
		message.channel:send("Restarting...")
		os.execute("luvit FireBot.lua")
		message.channel:send("Done!")
	elseif message.content:lower() == "!fire constantreload" and message.channel.name == "firebotconstantreloadnoonecouldgetthisnameeverleeeel" then
		while true do
			message.channel:send('Reloading!')
		end
	elseif message.content:lower() == "!fire roastme" then
		message:reply(message.author.mentionString..", your "..RandomFromTable(Insult1).." is so "..RandomFromTable(Insult2)..", "..RandomFromTable(Insult3)..".")
	elseif message.content:lower():match("!fire roast") and message.content:lower() ~= "!fire roastme" then
		if message.mentionedUsers and #message.mentionedUsers > 0 then
			for i, v in pairs(message.mentionedUsers) do
				message:reply(v.mentionString..", your "..RandomFromTable(Insult1).." is so "..RandomFromTable(Insult2)..", "..RandomFromTable(Insult3)..".")
			end
		else
			message:reply(message.author.mentionString..", please provide a user in your command.")
		end
	elseif message.content:lower() == "!fire time" then
		message:reply("The current date and time is "..discordia.Date():toISO(' ', '.'))
	else
		if message.content:lower():match("!fire") and message.author.id ~= FireId then
			message:reply("Sorry, "..message.author.mentionString..", that command was not found. Try saying !fire help for a full list of commands.")
		end
	end
end)

client:run(Bot process.env.BOT_TOKEN)
