-- wip

local variousDataManager = sdk.get_managed_singleton("app.VariousDataManager")

local updateEvery = 900

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
    -- log.debug("facilityBarter_update_pre")
    x:call('setupBarter')

    lastBarterUpdate = os.time(os.date("!*t"))
  end

  return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
end

sdk.hook(sdk.find_type_definition("app.FacilityBarter"):get_method("update"), facilityBarter_update_pre, nil)


-- Poogie
variousDataManager._Setting._FacilitySetting._Pugee._PugeeCoolTime = 10


-- azuz materials

-- app.savedata.cLargeWorkshopParam.addRewardItem(app.ItemDef.ID, System.Int16)
-- local azuzMult = 10

-- local function cLargeWorkshopParam_addRewardItem_pre(args)

--   log.debug("az" .. sdk.to_int64(args[3]) .. " " .. sdk.to_int64(args[4]) .. " " .. sdk.to_int64(args[5]))

--   return sdk.PreHookResult.CALL_ORIGINAL -- calls the original function, same as not returning anything
-- end

-- sdk.hook(sdk.find_type_definition("app.savedata.cLargeWorkshopParam"):get_method("addRewardItem"), cLargeWorkshopParam_addRewardItem_pre, nil)
