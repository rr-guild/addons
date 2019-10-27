SLASH_ITEMS1 = "/update"
SlashCmdList["ITEMS"]=function()
  if GuildLogData == nil then
    GuildLogData = {}
  end

  for k in pairs (GuildLogData) do
    GuildLogData[k] = nil
  end

  for i = 1,GetNumGuildMembers() do
    local name, rank, rankIndex, level, class, zone, note, 
      officernote, online, status, classFileName, 
      achievementPoints, achievementRank, isMobile, isSoREligible, standingID = GetGuildRosterInfo(i)
    
    tinsert(GuildLogData, format("%s,%s,%s,%s", name, class, level, rank))
  end

  if ItemInfoData == nil then
    ItemInfoData = {}
  end
  for k in pairs (ItemInfoData) do
    ItemInfoData[k] = nil
  end
  
  for bag = 0,4 do
    for slot = 1,GetContainerNumSlots(bag) do
      local texture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag,slot)
      if texture == nil then
      else
        tinsert(ItemInfoData, format("%s,%s,%s", itemLink, itemCount, texture))
      end
    end
  end
  print("Items updated")
end