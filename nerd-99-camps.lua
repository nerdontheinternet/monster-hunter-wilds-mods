-- app.user_data.CampManagerSetting.cCampMaxNum.getMaxNum(app.FieldDef.STAGE)



local function getCampMaxNum(retval)
    -- we get 3 extra camps at the end of the story.
    -- so we max out at 99.
    return sdk.to_ptr(96)
end

sdk.hook(sdk.find_type_definition("app.user_data.CampManagerSetting.cCampMaxNum"):get_method("getCampMaxNum"), nil, getCampMaxNum)
