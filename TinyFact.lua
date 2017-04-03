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

TinyFactPerk:Hide()
TinyFactPerk:RegisterEvent("ARTIFACT_XP_UPDATE")
TinyFactPerk:RegisterEvent("ADDON_LOADED")
TinyFactPerk:SetScript("OnEvent", function(self, event, ...)
      if event == "ARTIFACT_XP_UPDATE" then
         if ArtifactFrame and ArtifactFrame.PerksTab.TitleContainer:IsShown() then
            local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, tier = C_ArtifactUI.GetArtifactInfo()
            local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, tier)            
            
            orig_SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")
         end
      end
      if event == "ADDON_LOADED" then
         local addon = ...
         if addon == "Blizzard_ArtifactUI" then
            self:UnregisterEvent("ADDON_LOADED")
            orig_SetText = ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel.SetText
            ArtifactFrame.PerksTab.TitleContainer:SetScript("OnUpdate", nil) 
            local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, tier = C_ArtifactUI.GetArtifactInfo()
            local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, tier) 
            if(numPoints > 0) then
               orig_SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c1188FF88(".. numPoints .." UPGRADE!)\124r")
            else 
               orig_SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")   
            end
            hooksecurefunc(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel,"SetText",function()
            local _, _, _, _, totalXP, pointsSpent, _, _, _, _, _, _, tier = C_ArtifactUI.GetArtifactInfo()
            local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP, tier) 
               if(numPoints > 0) then
                  orig_SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c1188FF88(".. numPoints .." UPGRADE!)\124r")
               else 
                  orig_SetText(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel, xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")   
               end
            end)
         end
      end
end)