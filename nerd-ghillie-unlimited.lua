
local u = require('nerd-util')


-- Unlimited Ghillie

-- app.mcActiveSkillController.cActiveSkill
-- app.mcActiveSkillController
local hunterSkillEnum = u.generate_enum('app.HunterDef.ACTIVE_SKILL')
-- ["A_SKILL_002"] = 1, Ghillie
-- ["A_SKILL_001"] = 0,
-- ["A_SKILL_004"] = 3,
-- ["A_SKILL_003"] = 2,
-- ["A_SKILL_005"] = 4,
-- ["MAX"] = 5,
-- ["NONE"] = -1, }

local activeSkillsTimers = {}

local function activeSkillTimer(args)
  local x = sdk.to_managed_object(args[2])

  activeSkillsTimers[x._CurrentSkillType] = x._ActiveSkills[x._CurrentSkillType]:call('maxTime')

  log.debug('start' .. u.dump(x._CurrentSkillType) .. u.dump(activeSkillsTimers))
  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end

sdk.hook(sdk.find_type_definition("app.mcActiveSkillController"):get_method("startASkillEffectiveTimer"), activeSkillTimer, nil)

--app.mcActiveSkillController.askillEndFrameProcess(app.HunterDef.ACTIVE_SKILL)
local function askillEndFrameProcess(args)
  local x = sdk.to_managed_object(args[2])
  log.debug('end ' .. u.dump(x._CurrentSkillType))

  -- reset cooldown on unequip
  if hunterSkillEnum.A_SKILL_001 == x._CurrentSkillType then
    x._ActiveSkills[x._CurrentSkillType]:call('setCoolTime', 0.0)
  end
  activeSkillsTimers[x._CurrentSkillType] = nil
  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end
sdk.hook(sdk.find_type_definition("app.mcActiveSkillController"):get_method("askillEndFrameProcess"), askillEndFrameProcess, nil)

-- disable timer change
local function updateSkillTimer(args)
  local x = sdk.to_managed_object(args[2])

  if
      hunterSkillEnum.A_SKILL_001 == x._CurrentSkillType
      and activeSkillsTimers[x._CurrentSkillType]
  then
    -- log.debug('update ' .. GhilleActive .. ':  ' .. sdk.to_float(args[4]) .. ' ' .. sdk.to_float(args[5]) .. ' '  .. sdk.to_float(args[6]) .. ' ')
    x._ActiveSkills[x._CurrentSkillType]:call('setTime', activeSkillsTimers[x._CurrentSkillType])
  end

  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end
sdk.hook(sdk.find_type_definition("app.mcActiveSkillController"):get_method("updateASkill"), updateSkillTimer, nil)
