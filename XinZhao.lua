if GetObjectName(myHero) ~= "XinZhao" then return end

XinM = Menu("XinZhao", "XinZhao")
XinM:SubMenu("Combo", "Combo")
XinM.Combo:Boolean("Q", "Use Q", true)
XinM.Combo:Boolean("W", "Use W", true)
XinM.Combo:Boolean("E", "Use E", true)

XinM:SubMenu("JungleClear", "JungleClear")
XinM.JungleClear:Boolean("Q", "Use Q", true)
XinM.JungleClear:Boolean("W", "Use W", true)
XinM.JungleClear:Boolean("E", "Use E", true)

XinM:SubMenu("LaneClear", "LaneClear")
XinM.LaneClear:Boolean("Q", "Use Q", false)
XinM.LaneClear:Boolean("W", "Use W", false)
XinM.LaneClear:Boolean("E", "Use E", false)

XinM:SubMenu("Misc", "Misc")
XinM.Misc:Boolean("Autolvl", "Auto level", true)

OnLoop(function(myHero)
   local target = GetCurrentTarget()
   ----COMBO----
   if IOW:Mode() == "Combo" then
   
   if GoS:ValidTarget(target, 225) then
		if XinM.Combo.Q:Value() then
			if CanUseSpell(myHero, _Q) == READY and GoS:ValidTarget(target, 225) then
			   CastSpell(_Q)
		end
	end
end

if GoS:ValidTarget(target, 225) then
		if XinM.Combo.W:Value() then
			if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 225) then
			   CastSpell(_W)
		end
	end
end

if XinM.Combo.E:Value() then
		if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target,GetCastRange(myHero,_E)) then
		   CastTargetSpell(target,_E)
		end
	end
end

----JungleClear----
if IOW:Mode() == "LaneClear" then
		
	for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
	
	
	    if CanUseSpell(myHero, _W) == READY and XinM.JungleClear.W:Value() and GoS:ValidTarget(mob, 200) then
			CastSpell(_W)
		end
		
		if CanUseSpell(myHero, _Q) == READY and XinM.JungleClear.Q:Value() and GoS:ValidTarget(mob, 200) then
			CastSpell(_Q)
		end
		
		
	    if CanUseSpell(myHero, _E) == READY and XinM.JungleClear.E:Value() and GoS:ValidTarget(mob, 200) then
			CastTargetSpell(mob, _E)
		end
		
	end
end

---LANECLEAR----
if IOW:Mode() == "LaneClear" then


	for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
	
		if CanUseSpell(myHero, _Q) == READY and XinM.LaneClear.Q:Value() and GoS:ValidTarget(minion, 200) then
		   CastSpell(_Q)
		end
		
		
	    if CanUseSpell(myHero, _E) == READY and XinM.LaneClear.E:Value() and GoS:ValidTarget(minion, 200) then
			CastTargetSpell(minion, _E)
		end

	
	----AUTOLVL-----
local leveltable = {_W, _Q, _E, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
if XinM.Misc.Autolvl:Value() then 
		LevelSpell(leveltable[GetLevel(myHero)]) 
	end
end
end
end)

PrintChat("Secret Agent Xin Zhao by Musti")
