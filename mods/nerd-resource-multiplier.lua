
-- more items

local variousDataManager = sdk.get_managed_singleton("app.VariousDataManager")

local barterMax = 99
local mult = 2;

local Data = {}

--local itemData = variousDataManager._Setting._ItemSetting._ItemData._Values
--local iconTypeEnum = u.generate_enum('app.IconDef.ITEM_Fixed')
--local itemTypeEnum = u.generate_enum('app.ItemDef.Type')

Data = variousDataManager._Setting._FacilitySetting._BarterData._Values
for _, v in pairs(Data) do
  local entryIndex = v._Index
  v._RequestNum = math.ceil(v._RequestNum / mult)
  v._MaxCount = v._MaxCount * mult

  for i, j in pairs(v._RewardNum) do
    -- log.debug('j1 '..j.m_value)
    if nil ~= j and j.m_value < barterMax then
      v._RewardNum[i] = math.min(barterMax, j.m_value * mult)
      --   log.debug('j2 '..v._RewardNum[i].m_value)
    end
  end
  for i, j in pairs(v._BonusAddNum) do
    -- log.debug('bj1 '..j.m_value)
    if nil ~= j and j.m_value < barterMax then
      v._BonusAddNum[i] = math.min(barterMax, j.m_value * mult)
      -- log.debug('b '..v._BonusAddNum[i].m_value)
    end
  end
end

--base collection Bonus
Data = variousDataManager._Setting._FacilitySetting._CollectionData._BonusItemData._Values
for _, v in pairs(Data) do
  local entryIndex = v._Index

  for i, j in pairs(v._ItemNum) do
    if nil ~= j and j.m_value < barterMax then
      v._ItemNum[i] = math.min(barterMax, j.m_value * mult)
      -- v._Probability[i] = math.min(barterMax, 100-v._Probability[i].m_value)
    end
  end
end

Data = variousDataManager._Setting._EnemyRewardSettingData._RewardTable._items
for _, v in pairs(Data) do
  -- v EnemyRewardData
  for i, j in pairs(v._Values) do
    v._Values[i]._RewardNumStory = v._Values[i]._RewardNumStory * mult
    for k, l in pairs(v._Values[i]._RewardNumEx) do
      v._Values[i]._RewardNumEx[k] = l.m_value * mult
    end
  end
end

Data = variousDataManager._Setting._GimmickRewardSettingData._Values
for _, v in pairs(Data) do
  for i, j in pairs(v._normalRewardNum) do
    if j.m_value > 0 and j.m_value < barterMax then
      v._normalRewardNum[i] = math.min(barterMax, j.m_value * mult)
      v._normalProbability[i] = math.min(barterMax, v._normalProbability[i].m_value * mult)
    end
  end

  for i, j in pairs(v._rareRewardNum) do
    if j.m_value > 0 and j.m_value < barterMax then
      v._rareRewardNum[i] = math.min(barterMax, j.m_value * mult)
      v._rareProbability[i] = math.min(barterMax, v._rareProbability[i].m_value * mult)
    end
  end
end

Data = variousDataManager._Setting._GimmickAddRewardSettingData._Values
for _, v in pairs(Data) do
  for i, j in pairs(v._normalRewardNum) do
    if j.m_value > 0 and j.m_value < barterMax then
      v._normalRewardNum[i] = math.min(barterMax, j.m_value * mult)
      v._normalProbability[i] = math.min(barterMax, v._normalProbability[i].m_value * mult)
    end
  end
end


Data = variousDataManager._Setting._GimmickCollectNumTable._Values
for _, v in pairs(Data) do
  v._collectNum = v._collectNum * mult
end

-- Gimmick
local gimmickControlData = variousDataManager._Setting._GimmickControlData._Values
for _, entry in pairs(gimmickControlData) do
  if nil ~= entry._RepopTime then
    entry._RepopTime = entry._RepopTime / 5
  end
end

-- quest reward
Data = variousDataManager._Setting._CommonQuestRewardData._Values
for _, entry in pairs(Data) do
  if entry._num > 0 then
    entry._num = entry._num * mult
    entry._probability = entry._probability * mult
  end
end

Data = variousDataManager._Setting._AddQuestRewardData._Values
for _, entry in pairs(Data) do
  if entry._num > 0 then
    entry._num = entry._num * mult
    entry._probability = entry._probability * mult
  end
end

