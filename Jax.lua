if GetObjectName(myHero) ~= "Jax" then return end

JaxM = Menu("Jax", "Jax")
JaxM:SubMenu("Combo", "Combo")
JaxM.Combo:Boolean("Q", "Use Q", true)
JaxM.Combo:Boolean("W", "Use W", true)
JaxM.Combo:Boolean("E", "Use E", true)
JaxM.Combo:Boolean("R", "Use R", true)

JaxM:SubMenu("JungleClear", "JungleClear")
JaxM.JungleClear:Boolean("Q", "Use Q", true)
JaxM.JungleClear:Boolean("W", "Use W", true)
JaxM.JungleClear:Boolean("E", "Use E", true)

JaxM:SubMenu("LaneClear", "LaneClear")
JaxM.LaneClear:Boolean("Q", "Use Q", false)
JaxM.LaneClear:Boolean("W", "Use W", false)
JaxM.LaneClear:Boolean("E", "Use E", false)

OnLoop(function(myHero)
   local target = GetCurrentTarget()
   
---COMBO---
if IOW:Mode() == "Combo" then

	if JaxM.Combo.Q:Value() then
		if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target,GetCastRange(myHero,_Q)) then
		   CastTargetSpell(target,_Q)
		end
	end

	if JaxM.Combo.W:Value() then
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 200) then
		   CastSpell(_W)
		end
	end
end

if JaxM.Combo.E:Value() then
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target, 190) then
		   CastSpell(_E)
		end
	end

if JaxM.Combo.R:Value() then
			if GoS:ValidTarget(target, 550) then
			if GetCurrentHP(myHero)/GetMaxHP(myHero)<0.30 then return end
			CastSpell(_R)
		end
	end

	
----JungleClear----
if IOW:Mode() == "LaneClear" then
		
	for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	
	
	    if CanUseSpell(myHero, _W) == READY and JaxM.JungleClear.W:Value() and GoS:ValidTarget(mob, 200) then
			CastSpell(_W)
		end
		
		if CanUseSpell(myHero, _Q) == READY and JaxM.JungleClear.Q:Value() and GoS:ValidTarget(mob, 200) then
			CastTargetSpell(_Q)
		end
		
		
	    if CanUseSpell(myHero, _E) == READY and JaxM.JungleClear.E:Value() and GoS:ValidTarget(mob, 200) then
			CastSpell(_E)
		end
	end
end
---LANECLEAR----
if IOW:Mode() == "LaneClear" then


	for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	
		if CanUseSpell(myHero, _Q) == READY and JaxM.LaneClear.Q:Value() and GoS:ValidTarget(minion, 200) then
		   CastTargetSpell(minion, _Q)
		end
		
		if CanUseSpell(myHero, _W) == READY and JaxM.LaneClear.W:Value() and GoS:ValidTarget(minion, 200) then
		   CastTargetSpell(minion, _W)
		end
		
	    if CanUseSpell(myHero, _E) == READY and JaxM.LaneClear.E:Value() and GoS:ValidTarget(minion, 200) then
			CastTargetSpell(minion, _E)
		end
	end
end
end)
PrintChat("Nemesis Jax by Musti")
