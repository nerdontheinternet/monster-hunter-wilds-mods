local variousDataManager = sdk.get_managed_singleton("app.VariousDataManager")
u = require('monster-hunter-wilds-mods/util/nerd-util')

-- LBG ammo mod
local lbgData = variousDataManager._Setting._EquipDatas._WeaponLightBowgun._Values
local ShellLvEnum1 = u.generate_enum('app.BowgunShellLv.SHELL_LV_Fixed')
local mainShellEnum = u.generate_enum('app.MainShellType.TYPE_Fixed')

for _, entry in pairs(lbgData) do
    -- remove spread ammo if not main
    if entry._MainShell._Value ~= mainShellEnum.MST_002 then
        entry._ShellLv[2] = ShellLvEnum1.NONE
        entry._RapidShellNum[2] = 0
        entry._IsRappid[2] = false
    end
end
