-- wip

local variousDataManager = sdk.get_managed_singleton("app.VariousDataManager")

local updateEvery = 480

local lastCollectionUpdate = 0

-- get nata and villages to be useful

local function facilityCollection_UpdatePre(args)

  -- @TODO probably should be using in game clock instead of system clock...

  local test = os.time(os.date("!*t"))

  if test - lastCollectionUpdate > updateEvery then
    local x = sdk.to_managed_object(args[2])

    x:call('lotItem')

    lastCollectionUpdate = os.time(os.date("!*t"))
  end

  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end

sdk.hook(sdk.find_type_definition("app.FacilityCollection"):get_method("update"), facilityCollection_UpdatePre, nil)


local lastBarterUpdate = 0

local function facilityBarter_update_pre(args)
  local test = os.time(os.date("!*t"))

  if test - lastBarterUpdate > updateEvery then
    local x = sdk.to_managed_object(args[2])

    x:call('setupBarter')

    lastBarterUpdate = os.time(os.date("!*t"))
  end

  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end

sdk.hook(sdk.find_type_definition("app.FacilityBarter"):get_method("update"), facilityBarter_update_pre, nil)


-- Poogie
variousDataManager._Setting._FacilitySetting._Pugee._PugeeCoolTime = 10
