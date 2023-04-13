local mining = Action()

local config = {
maxmininglevel = 100,
storagemining = 100000,
expperlevel = 1000,
experiencemining = 125
}

local stone = {
	blue = {8637, 8633, 35072, 35273}, 
	green = {8640, 8636, 1353, 11534},
	lightblue = {8638, 8634, 1354, 35263},
	red = {8639, 8635, 1355, 25820},
}

local stones = {
	crystal = {stone.blue[1], stone.green[1], stone.lightblue[1], stone.red[1]},
	lcrystal = {stone.blue[2], stone.green[2], stone.lightblue[2], stone.red[2]},
	pcrystal = {stone.blue[3], stone.green[3], stone.lightblue[3], stone.red[3]},
	scrystal = {stone.blue[4], stone.green[4], stone.lightblue[4], stone.red[4]},
}

local ore = {
	blue = {2154, 2153, 34818, 34697},
	green = {2155, 2158, 37457, 37458}, 
	lightblue = {2156, 37604, 34699, 34698}, 
	red = {9980, 37606, 37605, 38615},
}

local ores = { ore.blue[1], ore.blue[2], ore.blue[3], ore.blue[4], ore.green[1], ore.green[2], ore.green[3], ore.green[4], ore.lightblue[1], ore.lightblue[2], ore.lightblue[3], ore.lightblue[4], ore.red[1], ore.red[2], ore.red[3], ore.red[4]}

local levels = {
    {
    level = {0,19},
    stone = {stones.crystal[1], stones.crystal[2], stones.crystal[3], stones.crystal[4]},
    items = {ores[1],ores[5], ores[9], ores[13]},
    iselect = 0,
    bstart = 1,
    gstart = 2,
    lbstart = 3,
    rstart = 4,
    chance = 10, -- 30
    qtdmax = 1,
    expgainmin = 15, --15
    expgainmax = 50 --50
    },
    {
    level = {20,49},
    stone = {stones.crystal[1], stones.crystal[2], stones.crystal[3], stones.crystal[4], stones.lcrystal[1], stones.lcrystal[2], stones.lcrystal[3], stones.lcrystal[4]},
    items = {ores[1],ores[2], ores[5], ores[6], ores[9],ores[10], ores[13], ores[14]},
    iselect = 1,
    bstart = 1,
    gstart = 3,
    lbstart = 5,
    rstart = 7,
    chance = 10,
    qtdmax = 1,
    expgainmin = 25,
    expgainmax = 75
    },
    {
    level = {50,69},
    stone = {stones.crystal[1], stones.crystal[2], stones.crystal[3], stones.crystal[4], stones.lcrystal[1], stones.lcrystal[2], stones.lcrystal[3], stones.lcrystal[4], stones.pcrystal[1], stones.pcrystal[2], stones.pcrystal[3], stones.pcrystal[4]},
    items = {ores[1],ores[2], ores[3], ores[5], ores[6], ores[7], ores[9],ores[10], ores[11], ores[13], ores[14], ores[15]},
    iselect = 2,
    bstart = 1,
    gstart = 4,
    lbstart = 7,
    rstart = 10,
    chance = 10,
    qtdmax = 1,
    expgainmin = 35,
    expgainmax = 95
    },
    {
    level = {70,89},
    stone = {stones.crystal[1], stones.crystal[2], stones.crystal[3], stones.crystal[4], stones.lcrystal[1], stones.lcrystal[2], stones.lcrystal[3], stones.lcrystal[4], stones.pcrystal[1], stones.pcrystal[2], stones.pcrystal[3], stones.pcrystal[4], stones.scrystal[1], stones.scrystal[2], stones.scrystal[3], stones.scrystal[4]},
    items = {ores[1],ores[2], ores[3], ores[4], ores[5], ores[6], ores[7], ores[8], ores[9],ores[10], ores[11], ores[12], ores[13], ores[14], ores[15], ores[16]},
    iselect = 3,
    bstart = 1,
    gstart = 5,
    lbstart = 9,
    rstart = 13,
    chance = 10,
    qtdmax = 1,
    expgainmin = 55,
    expgainmax = 125
    },
    {
    level = {90,100},
    stone = {stones.crystal[1], stones.crystal[2], stones.crystal[3], stones.crystal[4], stones.lcrystal[1], stones.lcrystal[2], stones.lcrystal[3], stones.lcrystal[4], stones.pcrystal[1], stones.pcrystal[2], stones.pcrystal[3], stones.pcrystal[4], stones.scrystal[1], stones.scrystal[2], stones.scrystal[3], stones.scrystal[4]},
    items = {ores[1],ores[2], ores[3], ores[4], ores[5], ores[6], ores[7], ores[8], ores[9],ores[10], ores[11], ores[12], ores[13], ores[14], ores[15], ores[16]},
    iselect = 3,
    bstart = 1,
    gstart = 5,
    lbstart = 9,
    rstart = 13,
    chance = 10,
    qtdmax = 1,
    expgainmin = 125,
    expgainmax = 180
    }
}

function mining.onUse(cid, item, fromPosition, itemEx, toPosition)


local getMiningLevel = getPlayerStorageValue(cid, config.storagemining)
local getMiningExp = getPlayerStorageValue(cid, config.experiencemining)

    if getMiningLevel == -1 then
        setPlayerStorageValue(cid, config.storagemining, 0)
    end
    if getMiningExp < 0 then
        setPlayerStorageValue(cid, config.experiencemining, 0)
    end

    if (isInArray(stones.crystal, itemEx.itemid) or isInArray(stones.lcrystal, itemEx.itemid) or isInArray(stones.pcrystal, itemEx.itemid) or isInArray(stones.scrystal, itemEx.itemid))  then
       
        for a = 1, #levels do
            min = levels[a].level[1]; max = levels[a].level[2]

            if (getMiningLevel >= min and getMiningLevel <= max) then
                if isInArray(levels[a].stone, itemEx.itemid) then
                        if (math.random(1, 100) <= levels[a].chance) then
                            quantity = math.random(1, levels[a].qtdmax)
                            experience = math.random(levels[a].expgainmin, levels[a].expgainmax)
                                if isInArray(stone.blue, itemEx.itemid) then
                                    iselection = math.random(levels[a].bstart, levels[a].bstart + levels[a].iselect)
                                    collect = levels[a].items[iselection]
                                end
                                if isInArray(stone.green, itemEx.itemid) then
                                    iselection = math.random(levels[a].gstart, levels[a].gstart + levels[a].iselect)
                                    collect = levels[a].items[iselection]
                                end
                                if isInArray(stone.lightblue, itemEx.itemid) then
                                    iselection = math.random(levels[a].lbstart, levels[a].lbstart + levels[a].iselect)
                                    collect = levels[a].items[iselection]
                                end
                                if isInArray(stone.red, itemEx.itemid) then
                                    iselection = math.random(levels[a].rstart, levels[a].rstart + levels[a].iselect)
                                    collect = levels[a].items[iselection]
                                end
                           
                            if getMiningLevel == 100 then
                            doSendMagicEffect(toPosition, 9)
                            doPlayerSendTextMessage(cid, 22, text)
                            doPlayerAddItem(cid, collect, quantity)
                           
                            elseif getMiningLevel <= 99 then
                           
                                if getMiningExp >= config.expperlevel then
                                    doSendMagicEffect(getCreaturePosition(cid), 49)
                                    setPlayerStorageValue(cid, config.storagemining, getMiningLevel + 1)
                                    setPlayerStorageValue(cid, config.experiencemining, getMiningExp - config.expperlevel)
                                    text = "You collected " ..quantity.. " matter" ..(quantity > 1 and "s" or "").. ". \n You have gained " ..experience.. " experience points in Mining. \n You advanced from mining skill level " ..getMiningLevel.. " to mining skill level " ..(getMiningLevel + 1).. "."
                                else
                                    setPlayerStorageValue(cid, config.experiencemining, getMiningExp + experience)
                                    text = "You collected " ..quantity.. " matter" ..(quantity > 1 and "s" or "").. ". \n You have gained " ..experience.. " experience points in Mining. \n" ..(config.expperlevel - getMiningExp - experience).. " experience points left to next level. \nCurrent Mining Skill: " ..getMiningLevel.. "."
                                end
                                doSendMagicEffect(toPosition, 9)
                                doPlayerSendTextMessage(cid, 22, text)
                                doPlayerAddItem(cid, collect, quantity)
                            end
                           
                        else
                            doPlayerSendTextMessage(cid, 22, "You are mining...")
                        end
                else
                    doPlayerSendTextMessage(cid, 22, "You need to get better in Mining to mining this.")
                end
            end

        end

    else
        doSendMagicEffect(getCreaturePosition(cid), 2)
        doPlayerSendTextMessage(cid, 22, "You can't mining this.")
    end

   
end

mining:id(37546)
mining:register()