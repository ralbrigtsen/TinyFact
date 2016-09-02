-- TinyFact by Znat
-- local TinyFact = CreateFrame("frame","TinyFact","UIParent")

print('TinyFact v0.1 loaded!')

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
