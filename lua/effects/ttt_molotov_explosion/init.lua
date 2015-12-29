function EFFECT:Init(data)
	self.Position = data:GetOrigin()

	local Pos = self.Position
	local Norm = Vector(0,0,1)
	
	Pos = Pos + Norm * 2
	
	local emitter = ParticleEmitter(Pos)

	/*
	for i=1, 40 do		
		local particle = emitter:Add("sprites/flamelet"..tostring(math.random(1, 5)), Pos + Vector(math.random(-50, 50), math.random(-50, 50), math.random(10, 150)))
			
		particle:SetVelocity(Vector(math.random(-50, 50), math.random(-50, 50), math.random(5, 10)))
		particle:SetDieTime(math.random(8, 10))
		particle:SetStartAlpha(math.random(100, 200))
		particle:SetStartSize(math.random(40, 60))
		particle:SetEndSize(math.random(60, 90))
		particle:SetRoll(math.random(-360, 360))
		particle:SetRollDelta(math.random(-0.6, 0.6))
		particle:SetColor(255, 255, 255)
	end*/
			
	for i=1, 60 do
		local particle = emitter:Add("particles/ttt_molotov_smoke", Pos + Vector(math.random(-150, 150), math.random(-150, 150), math.random(20, 100)))
				
		particle:SetVelocity(Vector(math.random(-100, 100), math.random(-100, 100), math.random(50, 100)))
		particle:SetDieTime(math.random(8, 15))
		particle:SetStartAlpha(math.random(150, 255))
		particle:SetStartSize(math.random(40, 80))
		particle:SetEndSize(math.random(100, 350))
		particle:SetRoll(math.random(-360, 360))
		particle:SetRollDelta(math.random(-0.8, 0.8))
		particle:SetColor(255, 255, 255)
	end
end

function EFFECT:Think()
	return false	
end

function EFFECT:Render()
end