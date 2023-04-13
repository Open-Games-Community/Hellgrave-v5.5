local textFloat = GlobalEvent("textFloat")

local effects = {
      {position = Position(32368, 32239, 5), text = 'First Items!', effect = CONST_ME_GROUNDSHAKER},
    {position = Position(32368, 32242, 5), text = 'Welcome to Hellgrave RPG Server!', effect = CONST_ME_THUNDER},
	{position = Position(32365, 32260, 7), text = 'Trainers!', effect = CONST_ME_STUN},
	{position = Position(32369, 32239, 7), text = 'Trinity Island!', effect = CONST_ME_HOLYDAMAGE},

}

function textFloat.onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end

textFloat:interval(12000)
textFloat:register()
