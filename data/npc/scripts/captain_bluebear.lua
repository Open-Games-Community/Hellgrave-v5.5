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

local voices = { {text = 'Passages to Mordragor, Dolwatha, Asrock, Falanaar, Mistfall or Freewind.'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Travel
local function addTravelKeyword(keyword, cost, destination, action, condition)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
	travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
	travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('dolwatha', 240, Position(32020, 32441, 6),
function(player)
	if player:getStorageValue(Storage.Postman.Mission01) == 1 then
		player:setStorageValue(Storage.Postman.Mission01, 2)
	end
end)

addTravelKeyword('asrock', 290, Position(31737, 32317, 5))
addTravelKeyword('falanaar', 195, Position(32219, 32584, 6))
addTravelKeyword('mordragor', 195, Position(32299, 32279, 6))
addTravelKeyword('mistfall', 170, Position(32374, 31937, 6))
addTravelKeyword('freewind', 220, Position(32539, 32936, 6))
addTravelKeyword('death valley', 320, Position(32593, 32475, 7))



-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Captain Bluebear from the Royal Ship Line.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = 'I am the captain of this sailing-ship.'})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = 'We can transport everything you want.'})
keywordHandler:addKeyword({'passenger'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to welcome you on board.'})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Dolwatha}, {Asrock}, {Falanaar}, {Mistfall}, {Freewind} or {Death Valley}'})
keywordHandler:addKeyword({'ghost'}, StdModule.say, {npcHandler = npcHandler, text = 'Many people who sailed to Dolwatha never returned because they were attacked by a huge Monsters! I\'ll never sail there!'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Mordragor. Where do you want to go?'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where can I {sail} you today ? Browse the moors of Hellgrave?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:addModule(FocusModule:new())
