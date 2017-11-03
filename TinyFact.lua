-- TinyFact by Znat@Stormscale (EU) & Steinp@Stormscale
-- Version 1.3.6
-- www.mindfields.no


print('TinyFact v1.3.6 loaded!')

local TinyFact_EventFrame = CreateFrame("Frame")
local orig_SetText

local function ReadableNumber(num, places)
    local ret
    -- local placeValue = ("%%.%df"):format(places or 0)
    local placeValue = ("%%.1f"):format(places or 0)
    if not num then
        return 0
    elseif num >= 2000000000 then
    	local placeValue = ("%%.2f"):format(places or 0)
        ret = placeValue:format(num / 1000000000) .. "bn" -- billion
    elseif num >= 2000000 then
        ret = placeValue:format(num / 1000000) .. "m" -- million
    elseif num >= 200000 then
        ret = placeValue:format(num / 1000) .. "k" -- thousand
    else
        ret = BreakUpLargeNumbers(num) -- hundreds
    end
    return ret
end

SLASH_TINYFACT1, SLASH_TINYFACT2 = '/tf', '/tinyfact'; 
function SlashCmdList.TINYFACT(msg, editbox) 
        local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactTier = select(13,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(TinyFactRank,TinyFactTier)
        if TinyFactPoints < TinyFactNeededPoints then
                print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. ReadableNumber(TinyFactPoints) ..'\124r/\124c1188FF88' .. ReadableNumber(TinyFactNeededPoints) .. '\124r for the next trait.')
        elseif TinyFactPoints >= TinyFactNeededPoints then
                print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. ReadableNumber(TinyFactPoints) ..'\124r/\124c1188FF88' .. ReadableNumber(TinyFactNeededPoints) .. '\124r. New \124c11FF8888trait\124r available!')
        end
end

TinyFact_EventFrame:RegisterEvent("ARTIFACT_XP_UPDATE")
TinyFact_EventFrame:SetScript("OnEvent",
  function(self, event, ...)
    local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
    local TinyFactTier = select(13,C_ArtifactUI.GetEquippedArtifactInfo())
    local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
    local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(TinyFactRank,TinyFactTier)
    if TinyFactPoints < TinyFactNeededPoints then
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. ReadableNumber(TinyFactPoints) ..'\124r/\124c1188FF88' .. ReadableNumber(TinyFactNeededPoints) .. '\124r for the next trait.')
    elseif TinyFactPoints >= TinyFactNeededPoints then
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. ReadableNumber(TinyFactPoints) ..'\124r/\124c1188FF88' .. ReadableNumber(TinyFactNeededPoints) .. '\124r. New \124c11FF8888trait\124r available!')
    end
end)

local TinyFactPerk = CreateFrame"Frame"
local SetText
TinyFactPerk:Hide()

TinyFactPerk:RegisterEvent"ADDON_LOADED"
TinyFactPerk:SetScript("OnEvent", function(self, event, arg1)
  if event == "ARTIFACT_XP_UPDATE" and ArtifactFrame and ArtifactFrame:IsShown() then _SetText() end
  if event == "ADDON_LOADED" and arg1 == "Blizzard_ArtifactUI" then
    self:UnregisterEvent"ADDON_LOADED"
    TinyFactPerk:RegisterEvent"ARTIFACT_XP_UPDATE"
    SetText = ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel.SetText
    ArtifactFrame.PerksTab.TitleContainer:SetScript("OnUpdate", nil)
    _SetText()
    hooksecurefunc(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel,"SetText", _SetText)
  end
end)

function _SetText()
  local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, tier = C_ArtifactUI.GetArtifactInfo()
  local numPoints, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, tier)
  if numPoints > 0 then
    SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, ReadableNumber(xp) .. " \124c1188FF88(+" .. ReadableNumber(xpForNextPoint-xp) ..") +" .. numPoints .."\124r")
  else
    SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, ReadableNumber(xp) .. " \124c11FF8888(+" .. ReadableNumber(xpForNextPoint-xp) ..")\124r")
  end
end