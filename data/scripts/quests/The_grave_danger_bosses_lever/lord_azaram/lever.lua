local config = {
    cooldown = 60 * 60 * 4, -- in seconds - (Make it 'seconds * minutes * hours' - its will be '60 * 60 * 20' for 20 hours) (player cooldown)
    cooldown_storage = 808862,
    duration = 20, -- time till reset, in minutes (lever cooldown)
    level_req = 100, -- minimum level to do quest
    min_players = 1, -- minimum players to join quest
    lever_id = 1945, -- id of lever before pulled
    pulled_id = 1946, -- id of lever after pulled
}

local player_positions = {
    [1] = {fromPos = Position(32311, 31546, 8), toPos = Position(32312, 31529, 8)},
    [2] = {fromPos = Position(32312, 31547, 8), toPos = Position(33313, 31529, 8)},
    [3] = {fromPos = Position(32313, 31548, 8), toPos = Position(33314, 31529, 8)},
    [4] = {fromPos = Position(33314, 31549, 8), toPos = Position(33315, 31529, 8)},
	[5] = {fromPos = Position(33315, 31550, 8), toPos = Position(33316, 31529, 8)}
}

local monsters = {
    [1] = {pos = Position(32314, 31524, 8), name = "Lord Azaram"}
}
local quest_range = {fromPos = Position(32309, 31518, 8), toPos = Position(32318, 31532, 8)} -- see image in thread for explanation

local exit_position = Position(32312, 31551, 8) -- Position completely outside the quest area

local lever = Action()

function doResetTheBossDukeKrule(position, cid_array)
 
    local tile = Tile(position)
 
    local item = tile and tile:getItemById(config.pulled_id)
    if not item then
        return
    end
 
    local monster_names = {}
    for key, value in pairs(monsters) do
        if not isInArray(monster_names, value.name) then
            monster_names[#monster_names + 1] = value.name
        end
    end
 
    for i = 1, #monsters do
        local creatures = Tile(monsters[i].pos):getCreatures()
        for key, creature in pairs(creatures) do
            if isInArray(monster_names, creature:getName()) then
                creature:remove()
            end
        end
    end
 
    for i = 1, #player_positions do
        local creatures = Tile(player_positions[i].toPos):getCreatures()
        for key, creature in pairs(creatures) do
            if isInArray(monster_names, creature:getName()) then
                creature:remove()
            end
        end
    end
 
    for key, cid in pairs(cid_array) do
        local participant = Player(cid)
    if participant and isInRange(participant:getPosition(), quest_range.fromPos, quest_range.toPos) then
            participant:teleportTo(exit_position)
            exit_position:sendMagicEffect(CONST_ME_TELEPORT)
        end
    end
 
    item:transform(config.lever_id)
end

local function removeBoss()
local specs, spec = Game.getSpectators(Position(33919, 31646, 8), false, false, 18, 18, 18, 18)
    for j = 1, #specs do
        spec = specs[j]
        if spec:getName():lower() == 'Lord Azaram' then
            spec:remove()
        end
    end
end

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(config.cooldown_storage) >= os.time() then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Try Again in 4 Hours.")
        return true
    end
 
 
    local participants, pull_player = {}, false
    for i = 1, #player_positions do
        local fromPos = player_positions[i].fromPos
        local tile = Tile(fromPos)
        if not tile then
            print(">> ERROR: Lord Azaram tile does not exist for Position(" .. fromPos.x .. ", " .. fromPos.y .. ", " .. fromPos.z .. ").")
            return player:sendCancelMessage("There is an issue with this quest. Please contact an administrator.")
        end
 
        local creature = tile:getBottomCreature()
        if creature then
            local participant = creature:getPlayer()
            if not participant then
                return player:sendCancelMessage(participant:getName() .. " is not a valid participant.")
            end
 
            if participant:getLevel() < config.level_req then
                return player:sendCancelMessage(participant:getName() .. " is not the required level.")
            end
 
            if participant.uid == player.uid then
                pull_player = true
            end
 
            participants[#participants + 1] = {participant = participant, toPos = player_positions[i].toPos}
        end
    end
 
    if #participants < config.min_players then
        return player:sendCancelMessage("You do not have the required amount of participants.")
    end
 
    if not pull_player then
        return player:sendCancelMessage("You are in the wrong position.")
    end
 
    for i = 1, #monsters do
        local toPos = monsters[i].pos
        if not Tile(toPos) then
            print(">> ERROR: Lord Azaram tile does not exist for Position(" .. toPos.x .. ", " .. toPos.y .. ", " .. toPos.z .. ").")
            return player:sendCancelMessage("There is an issue with this quest. Please contact an administrator.")
        end
        removeBoss()
        Game.createMonster(monsters[i].name, monsters[i].pos, false, true)
    end
 
    local cid_array = {}
    for i = 1, #participants do
        participants[i].participant:teleportTo(participants[i].toPos)
        participants[i].toPos:sendMagicEffect(CONST_ME_TELEPORT)
        cid_array[#cid_array + 1] = participants[i].participant.uid
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have 20 minutes to kill and loot this boss. Otherwise you will lose that chance and will be kicked out.")
    end
 
    item:transform(config.pulled_id)
    player:setStorageValue(config.cooldown_storage, os.time() + config.cooldown)
    addEvent(doResetTheBossDukeKrule, config.duration * 60 * 2000,  toPosition, cid_array)
    return true
end

lever:uid(42580)
lever:register()
