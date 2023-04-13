local tibiaCoin = Action()

function tibiaCoin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
local coins = 1 -- quantidade de coins que o item vai dar
  db.query("UPDATE `accounts` SET `coins` = `coins` + '" .. coins .. "' WHERE `id` = '" .. player:getAccountId() .. "';")
  player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You received "..coins.." Tibia Coin")
  item:remove(1)
  return true
end

tibiaCoin:id(24774)
tibiaCoin:register()