u = require('monster-hunter-wilds-mods/util/nerd-util')

local variousDataManager = sdk.get_managed_singleton("app.VariousDataManager")

-- carry more

local itemData = variousDataManager._Setting._ItemSetting._ItemData._Values

local iconTypeEnum = u.generate_enum('app.IconDef.ITEM_Fixed')
-- log.debug(json.dump_string(iconTypeEnum))
for _, entry in pairs(itemData) do
  local itemIndex = entry._Index

  -- skip spread ammo
  if 110 == itemIndex then
    --   entry._Infinit = false
  end

  if
      entry._MaxCount > 1
      and entry._IconType ~= iconTypeEnum.ITEM_0061
  then
    entry._MaxCount = 999
    entry._OtomoMax = 999
  end
end

-- item pouch
-- doesn't work 
-- app.ItemPouchUtil getPouchSize(app.ItemUtil.POUCH_TYPE)
local function getPouchSizePost(retval)
  -- multiply pouch sizes
  log.debug('getPouchSizePost '+retval)
  return sdk.to_ptr(retval * 3)
end

sdk.hook(sdk.find_type_definition("app.ItemPouchUtil"):get_method("getPouchSize"), nil, getPouchSizePost)

