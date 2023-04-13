local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "brings") then
		npcHandler:say("Ah, you have heard about my search for experienced help. And indeed your reputation for solving certain {problems} has preceded you.", cid)
	elseif msgcontains(msg, "problems") then
		npcHandler:say(" I have problems in the south-east, do you see these watches blowing fire everywhere! Can you help me in this {mission} ?", cid)
	elseif msgcontains(msg, "mission") then
		npcHandler:say("My studies indicate that dragons are everywhere near the mountains where the minerals abound. We have to stop him. ...", cid)
		npcHandler:say("Therefore I need you to go kill them and catch me 10 {Dragon's Tail}. Are you willing to help me in this dire mission?", cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 2 and player:getStorageValue(Storage.Factions) < 1 then
		npcHandler:say("Good!, but I need 10 {Dragon's Tail} before exchange my Luminescent crystal pickaxe.", cid)
	elseif msgcontains(msg, "Dragon's Tail") or msgcontains(msg, "Dragons tail") then
		npcHandler:say("Do you have 10 {Dragon's Tail} to bring me?", cid)
		npcHandler.topic[cid] = 3
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 3 then
		if player:removeItem(12413, 10) then
			npcHandler:say("Excellent! You become now a Veritable Minner. You can start Minning on Small crystals, and when you get the highest level maybe you can found a tons of golds! ", cid)
			player:addItem(37546, 1)
			player:setStorageValue(Storage.Factions, 1)
		else
			npcHandler:say("You don\'t have the 10 {Dragon's Tail}  back here when you get it.", cid)
			npcHandler:releaseFocus(cid)
		end
	end

end
npcHandler:setMessage(MESSAGE_GREET, "Greetings, dear citizen of Mordragor. Please tell me what {brings} you here, to my humble adobe.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Oh well.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
