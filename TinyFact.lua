-- TinyFact by Znat
-- local TinyFact = CreateFrame("frame","TinyFact","UIParent")

print('TinyFact v0.00001b loaded!')

local TinyFact_EventFrame = CreateFrame("Frame")

SLASH_TINYFACT1, SLASH_TINYFACT2 = '/tf', '/tinyfact'; 
function SlashCmdList.TINYFACT(msg, editbox) 
  local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
  local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
  local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(select(6,C_ArtifactUI.GetEquippedArtifactInfo()))
  print('Artifact is level ' .. TinyFactRank ..', You got ' .. TinyFactPoints ..'/'.. TinyFactNeededPoints ..' for the next level.' )
end

TinyFact_EventFrame:RegisterEvent("ARTIFACT_XP_UPDATE")
TinyFact_EventFrame:SetScript("OnEvent",
	function(self, event, ...)
		local TinyFactRank = select(6,C_ArtifactUI.GetEquippedArtifactInfo())
		local TinyFactPoints = select(5,C_ArtifactUI.GetEquippedArtifactInfo())
		local TinyFactNeededPoints = C_ArtifactUI.GetCostForPointAtRank(select(6,C_ArtifactUI.GetEquippedArtifactInfo()))
		print('Artifact: L' .. TinyFactRank ..', Points ' .. TinyFactPoints ..'/'.. TinyFactNeededPoints ..' for the next level.' )
end)
