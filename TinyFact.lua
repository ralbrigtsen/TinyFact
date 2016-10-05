-- TinyFact by Znat@Stormscale (EU)
-- Version 1.3
-- Changes: Added needed xp to forgeframe.
-- Codeninja from Steinp@Stormscale

print('TinyFact v1.3.3 loaded!')

local TinyFact_EventFrame = CreateFrame("Frame")

SLASH_TINYFACT1, SLASH_TINYFACT2 = '/tf', '/tinyfact'; 
function SlashCmdList.TINYFACT(msg, editbox) 
        local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
        local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(select(6,C_ArtifactUI.GetEquippedArtifactInfo()))
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
    local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
    local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(select(6,C_ArtifactUI.GetEquippedArtifactInfo()))
    if TinyFactPoints < TinyFactNeededPoints then
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r for the next trait.')
    elseif TinyFactPoints >= TinyFactNeededPoints then
      print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r. New \124c11FF8888trait\124r available!')
    end
end)

local TinyFactPerk = CreateFrame"Frame"

TinyFactPerk:Hide()
TinyFactPerk:RegisterEvent"ARTIFACT_XP_UPDATE"
TinyFactPerk:RegisterEvent"ARTIFACT_UPDATE"
TinyFactPerk:RegisterEvent"ADDON_LOADED"
TinyFactPerk:SetScript("OnEvent", function(self, event, ...)
      if event == "ARTIFACT_XP_UPDATE" then
         if ArtifactFrame and ArtifactFrame.PerksTab.TitleContainer:IsShown() then
            local _, _, _, _, totalXP, pointsSpent = C_ArtifactUI.GetArtifactInfo()
            local _, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP);
            
            ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")
         end
      end
      if event == "ADDON_LOADED" then
         local addon = ...
         if addon == "Blizzard_ArtifactUI" then
            self:UnregisterEvent"ADDON_LOADED"
            hooksecurefunc(ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel,"SetText",function()
               local _, _, _, _, totalXP, pointsSpent = C_ArtifactUI.GetArtifactInfo()
               local numPoints, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP)
               if(numPoints > 0) then
                  ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c1188FF88(".. numPoints .." UPGRADE!)\124r")
               else 
                  ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")   
               end
            end)
            ArtifactFrame.PerksTab.TitleContainer:SetScript("OnUpdate", nil) 
               local _, _, _, _, totalXP, pointsSpent = C_ArtifactUI.GetArtifactInfo()
               local numPoints, xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP)
               if(numPoints > 0) then
                  ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c1188FF88(".. numPoints .." UPGRADE!)\124r")
               else 
                  ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r")   
               end
         end
      end
end)





