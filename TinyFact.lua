-- TinyFact by Znat@Stormscale (EU) & Steinp@Stormscale
-- Version 1.3.5
-- www.mindfields.no


print('TinyFact v1.3.5 loaded!')

local TinyFact_EventFrame = CreateFrame("Frame")
local orig_SetText

SLASH_TINYFACT1, SLASH_TINYFACT2 = '/tf', '/tinyfact'; 
function SlashCmdList.TINYFACT(msg, editbox) 
        local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactTier = select(13,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(TinyFactRank,TinyFactTier)
        if TinyFactPoints < TinyFactNeededPoints then
                print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r for the next trait.')
        elseif TinyFactPoints >= TinyFactNeededPoints then
                print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r. New \124c11FF8888trait\124r available!')
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
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r for the next trait.')
    elseif TinyFactPoints >= TinyFactNeededPoints then
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r. New \124c11FF8888trait\124r available!')
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
    SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c1188FF88(+" .. xpForNextPoint-xp ..") +" .. numPoints .."\124r")
  else
    SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")
  end
end