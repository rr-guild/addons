local Ragnarok = CreateFrame('Frame', 'Ragnarok')
Ragnarok:RegisterEvent('BANKFRAME_OPENED')
Ragnarok:RegisterEvent('PLAYER_LEAVING_WORLD')
Ragnarok:RegisterEvent('BANKFRAME_CLOSED')
Ragnarok:SetScript('OnEvent', 
  function(self, event, ...)
    if event == 'BANKFRAME_OPENED' then
      self.bankOpen = true
    end
    if event == 'BANKFRAME_CLOSED' then
      self:Update()
      self.bankOpen = false
    end
    if event == 'PLAYER_LEAVING_WORLD' then
      self:Update()
    end
  end
)

function Ragnarok:Update()
  if GuildInfoData == nil then
    GuildInfoData = {}
  end

  for k in pairs (GuildInfoData) do
    GuildInfoData[k] = nil
  end

  for i = 1,GetNumGuildMembers() do
    local name, rank, rankIndex, level, class, zone, note, 
      officernote, online, status, classFileName, 
      achievementPoints, achievementRank, isMobile, isSoREligible, standingID = GetGuildRosterInfo(i)
    
    tinsert(GuildInfoData, format("%s,%s,%s,%s", name, class, level, rank))
  end


  self.bankSlot = {-1,5,6,7,8,9,10,11}
  if ItemInfoData == nil then
    ItemInfoData = {}
  end 
  if ItemList == nil then
    ItemList = {}
  end
  
  for bag = 0,4 do
    ItemInfoData[bag] = {}
    for slot = 1,GetContainerNumSlots(bag) do
      local texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag,slot)
      if texture == nil then
      else
        tinsert(ItemInfoData[bag], format("%s,%s,%s", itemLink, itemCount, texture))
      end
    end
  end
  print("Items updated")
  
  if self.bankOpen then
    for i = 1,8 do
      ItemInfoData[self.bankSlot[i]] = {}
      for slot = 1,GetContainerNumSlots(self.bankSlot[i]) do
        local texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(self.bankSlot[i],slot)
        if texture == nil then
        else
          tinsert(ItemInfoData[self.bankSlot[i]], format("%s,%s,%s", itemLink, itemCount, texture))
        end
      end
    end
    print("Bank items updated")
  end
  
  local k = 0
  for i in pairs (ItemList) do
    ItemList[i] = nil
  end
  for i = -1,table.getn(ItemInfoData) do
    if ItemInfoData[i] == nil then
    else
      for j = 1,table.getn(ItemInfoData[i]) do
        if ItemInfoData[i][j] == nil then
        else
          tinsert(ItemList, ItemInfoData[i][j])
        end
      end
    end
  end
end

SLASH_ITEMS1 = "/update"
SlashCmdList["ITEMS"] = function()
  Ragnarok:Update()
end