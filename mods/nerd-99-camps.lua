-- app.user_data.CampManagerSetting.cCampMaxNum.getMaxNum(app.FieldDef.STAGE)



local function getCampMaxNum(retval)
    -- we get 3 extra camps at the end of the story.
    -- so we max out at 99.
    local max = 96
    return sdk.to_ptr(max)
end

sdk.hook(sdk.find_type_definition("app.user_data.CampManagerSetting.cCampMaxNum"):get_method("getMaxNum"), nil, getCampMaxNum)
