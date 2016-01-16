AddCSLuaFile()

if SERVER then
	resource.AddFile("materials/particles/ttt_molotov_smoke.vmt")
end

ENT.Type = "anim"
ENT.Base = "ttt_basegrenade_proj"
ENT.Model = Model("models/weapons/w_eq_flashbang_thrown.mdl")


AccessorFunc(ENT, "radius", "Radius", FORCE_NUMBER)
AccessorFunc(ENT, "dmg", "Dmg", FORCE_NUMBER)

function ENT:Initialize()
	if not self:GetRadius() then self:SetRadius(256) end
	if not self:GetDmg() then self:SetDmg(25) end

	if CLIENT then
		util.PrecacheSound("explode_3")
	else
		local zfire = ents.Create("env_fire_trail")
		zfire:SetPos(self:GetPos())
		zfire:SetParent(self)
		zfire:Spawn()
		zfire:Activate()
	end

	return self.BaseClass.Initialize(self)
end

function ENT:Explode(tr, onCollide)
	if onCollide then
		if SERVER then
			util.Decal("Scorch", tr.HitPos + tr.HitNormal , tr.HitPos - tr.HitNormal) -- Mark on the ground
			util.BlastDamage(self, self:GetOwner(), self:GetPos(), self:GetRadius(), self:GetDmg())  -- Damage players
			self:EmitSound("explode_3") -- Sound
			
			-- Explosion effect
			local effectdata = EffectData()
			effectdata:SetOrigin(self:GetPos())
			util.Effect("ttt_molotov_explosion", effectdata)

			-- Spawn sparks
			for i = 1, 16 do
				local sparks = ents.Create("env_spark")
				sparks:SetPos(self:GetPos() + Vector(math.random(-150, 150), math.random(-150, 150), math.random(-150, 200)))
				sparks:SetKeyValue("MaxDelay", "0")
				sparks:SetKeyValue("Magnitude", "2")
				sparks:SetKeyValue("TrailLength", "3")
				sparks:SetKeyValue("spawnflags", "0")
				sparks:Spawn()
				sparks:Fire("SparkOnce", "", 0)
			end

			-- Spawn Fire

			local i = 1
			while i <= 25 do -- The molly Zach found had 25, the kbz one had 60?!
				local pos = self:GetPos() + Vector(math.random(-300, 300), math.random(-300, 300))
				local roomTr = util.TraceLine({start=self:GetPos(), endpos=pos, filter = function() return false end})

				-- Only start fires in the room of the explosion
				if not roomTr.HitWorld then
					i = i + 1

					StartFires(pos, tr, 1, 30, false, self:GetOwner())
				end
			end

			-- Light players on fire
			for _, ent in pairs(ents.FindInSphere(self:GetPos(), self:GetRadius())) do
				if ent:IsPlayer() and ent:Alive() and not ent:IsSpec() then

					local roomTr = util.TraceLine({start=self:GetPos(), endpos=ent:GetPos(), filter=function(hitEnt)
						return false
					end})

					-- Only ignite players in the room of the explosion
					if not roomTr.HitWorld then
						ent:Ignite(6)
						ent.ignite_info = {att=self:GetOwner(), infl=self}
						timer.Remove("ignite_molotov_" .. ent:UserID())
			         	timer.Create("ignite_molotov_" .. ent:UserID(), 6.1, 1, function()
							if IsValid(ent) then
								ent.ignite_info = nil
							end
						end)
					end
				end
			end

			self:Remove()
		end
	end
end

function ENT:PhysicsCollide(data, physobj) 
	self:Explode(data, true)
end