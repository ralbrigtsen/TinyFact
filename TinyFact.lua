-- TinyFact by Znat
-- Version 1.1 
-- Changes: Added needed xp to forgeframe.
-- Codeninja from Steinop@Stormscale

print('TinyFact v1.1 loaded!')

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
TinyFact_EventFrame:RegisterEvent("ADDON_LOADED")

TinyFact_EventFrame:SetScript("OnEvent",
        function(self, event, ...)
            if event == "ARTIFACT_XP_UPDATE" then
            if ArtifactFrame.PerksTab.TitleContainer:IsShown() then
                local _, _, _, _, totalXP, pointsSpent = C_ArtifactUI.GetEquippedArtifactInfo();
                local _,xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP);
                if xpForNextPoint > 0 then
                   ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r");
                elseif xpForNextPoint < 0 then
                   ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c1188FF88(Upgrade!)\124r");
                end
            end
                local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
                local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
                local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(select(6,C_ArtifactUI.GetEquippedArtifactInfo()))
                if TinyFactPoints < TinyFactNeededPoints then
                        print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c11FF8888' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r for the next trait.')
                elseif TinyFactPoints >= TinyFactNeededPoints then
                        print('Artifact: L\124c1188FF88' .. TinyFactRank ..'\124r, Points \124c1188FF88' .. TinyFactPoints ..'\124r/\124c1188FF88' .. TinyFactNeededPoints .. '\124r. New \124c11FF8888trait\124r available!')
                end
            end
    if event == "ADDON_LOADED" then
         local addon = ...
         if addon == "Blizzard_ArtifactUI" then
            self:UnregisterEvent"ADDON_LOADED"
            print"Hook that shit"
            ArtifactFrame.PerksTab.TitleContainer:HookScript("OnShow",
        function (self, event, ...)
                local _, _, _, _, totalXP, pointsSpent = C_ArtifactUI.GetEquippedArtifactInfo();
                local _,xp, xpForNextPoint = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, totalXP);
                if xpForNextPoint > 0 then
                   ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c11FF8888(+" .. xpForNextPoint-xp ..")\124r");
                elseif xpForNextPoint < 0 then
                   ArtifactFrame.PerksTab.TitleContainer.PointsRemainingLabel:SetText(xp .. " \124c1188FF88(Upgrade!)\124r");
                end
end)
            ArtifactFrame.PerksTab.TitleContainer:SetScript("OnUpdate", nil)
         end
      end
end)





