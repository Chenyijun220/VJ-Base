/*--------------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/

-- Localized static values
local isnumber = isnumber
local vj_animdur = VJ.AnimDuration

local metaEntity = FindMetaTable("Entity")
local metaNPC = FindMetaTable("NPC")
//local Player_MetaTable = FindMetaTable("Player")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Meta Edits ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !metaNPC.IsVJBaseEdited then
	metaNPC.IsVJBaseEdited = true
	---------------------------------------------------------------------------------------------------------------------------------------------
	local orgSetMaxLookDistance = metaNPC.SetMaxLookDistance
	-- Override to make sure all 3 values are on par at all times!
	function metaNPC:SetMaxLookDistance(dist)
		//self:Fire("SetMaxLookDistance", dist) -- Original "SetMaxLookDistance" handles it now (below)
		orgSetMaxLookDistance(self, dist) -- For Source sight & sensing distance
		self:SetSaveValue("m_flDistTooFar", dist) -- For certain Source attack, weapon, and condition distances
		self.SightDistance = dist -- For VJ Base
	end
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Meta Additions ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[---------------------------------------------------------
	Helper function to get the movement velocity of various different entities (Useful to get the move speed of an entity!)
	Returns
		- Vector, the best movement velocity it found
-----------------------------------------------------------]]
function metaEntity:GetMovementVelocity()
	-- NPCs
	if self:IsNPC() then
		-- Ground nav uses walk frames based move velocity, while all other nav types use pure velocity
		if self:GetNavType() == NAV_GROUND then
			return self:GetMoveVelocity()
		end
	-- Players
	elseif self:IsPlayer() then
		return self:GetInternalVariable("m_vecSmoothedVelocity")
	end
	return self:GetVelocity() -- If no overrides above then just return pure velocity
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- override = Used internally by the base, overrides the result and returns Val instead (Useful for variables that allow "false" to let the base decide the time)
function metaNPC:DecideAnimationLength(anim, override, decrease)
	if isbool(anim) then return 0 end
	if !override then -- Base decides
		return (vj_animdur(self, anim) - (decrease or 0)) / self:GetPlaybackRate()
	elseif isnumber(override) then -- User decides
		return override / self:GetPlaybackRate()
	else
		return 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- !!!!!!!!!!!!!! DO NOT USE !!!!!!!!!!!!!! [Backwards Compatibility!]
function metaEntity:CalculateProjectile(algorithmType, startPos, targetPos, strength)
	if algorithmType == "Line" then
		return VJ.CalculateTrajectory(self, (self.IsVJBaseSNPC and IsValid(self:GetEnemy())) and self:GetEnemy() or NULL, "Line", startPos, self.IsVJBaseSNPC and 1 or targetPos, strength)
	elseif algorithmType == "Curve" then
		return VJ.CalculateTrajectory(self, (self.IsVJBaseSNPC and IsValid(self:GetEnemy())) and self:GetEnemy() or NULL, "CurveOld", startPos, targetPos, strength)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
/* Disabled for now as it causes significant performance loss, its purpose was to fix the same-model relationship bug in Garry's Mod
--
local AddEntityRelationship = metaNPC.AddEntityRelationship
function metaNPC:AddEntityRelationship(...)
	local args = {...}
	local ent = args[1]
	local disp = args[2]

	self.StoredDispositions = self.StoredDispositions or {}
	self.StoredDispositions[ent] = disp
	return AddEntityRelationship(self,...)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local Disposition = metaNPC.Disposition
function metaNPC:Disposition(...)
	local args = {...}
	local ent = args[1]

	self.StoredDispositions = self.StoredDispositions or {}
	if IsValid(ent) && self:GetModel() == ent:GetModel() then
		return self.StoredDispositions[ent] or D_ER
	end
	return Disposition(self,...)
end
*/
---------------------------------------------------------------------------------------------------------------------------------------------
/* Disabled as this has now been replaced with a faster system
--
VJ_TAG_HEALING = 1 -- Ent is healing (either itself or by another ent)
VJ_TAG_EATING = 2 -- Ent is eating something (Ex: a corpse)
VJ_TAG_BEING_EATEN = 3 -- Ent is being eaten by something
VJ_TAG_VJ_FRIENDLY = 4 -- Friendly to VJ NPCs
VJ_TAG_SD_PLAYING_MUSIC = 10 -- Ent is playing a sound track
VJ_TAG_HEADCRAB = 20
VJ_TAG_POLICE = 21
VJ_TAG_CIVILIAN = 22
VJ_TAG_TURRET = 23
VJ_TAG_VEHICLE = 24
VJ_TAG_AIRCRAFT = 25
--
-- Variable:		self.VJTags
-- Access: 			self.VJTags[VJ_TAG_X]
-- Remove: 			self.VJTags[VJ_TAG_X] = nil
-- Add: 			self:VJTags_Add(VJ_TAG_X, VJ_TAG_Y, ...)
--
function metaEntity:VJTags_Add(...)
	if !self.VJTags then self.VJTags = {} end
	//PrintTable({...})
	for _, tag in ipairs({...}) do
		self.VJTags[tag] = true
	end
end
*/