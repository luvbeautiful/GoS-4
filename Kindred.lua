if GetObjectName(myHero) ~= "Kindred" then return end

KindredM = Menu("Kindred", "Kindred")
KindredM:SubMenu("Combo", "Combo")
KindredM.Combo:Boolean("Q", "Use Q", true)
KindredM.Combo:Boolean("QM", "Use Q to mouse", true)
KindredM.Combo:Boolean("W", "Use W", true)
KindredM.Combo:Boolean("E", "Use E", true)
KindredM.Combo:Boolean("R", "Use R", true)

KindredM:SubMenu("JungleClear", "JungleClear")
KindredM.JungleClear:Boolean("Q", "Use Q", true)
KindredM.JungleClear:Boolean("QM", "Use Q to mouse", true)
KindredM.JungleClear:Boolean("W", "Use W", true)
KindredM.JungleClear:Boolean("E", "Use E", true)

KindredM:SubMenu("LaneClear", "LaneClear")
KindredM.LaneClear:Boolean("Q", "Use Q", false)
KindredM.LaneClear:Boolean("QM", "Use Q to mouse", false)
KindredM.LaneClear:Boolean("E", "Use E", false)
KindredM:SubMenu("Drawings", "Drawings")

KindredM.Drawings:Boolean("Q", "Draw Q Range", true)

KindredM:SubMenu("Misc", "Misc")
KindredM.Misc:Boolean("Autolvl", "Auto level", true)
KindredM.Misc:Boolean("AR", "Auto R", false)

OnLoop(function(myHero)
   local target = GetCurrentTarget()
-----Auto R------
	if KindredM.Misc.AR then
		for _, ally in pairs(GoS:GetAllyHeroes()) do
			if KindredM.Misc.AR:Value() then
				if (GetCurrentHP(ally)/GetMaxHP(ally))<0.10 and CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
					CastTargetSpell(ally,_R)
				end
			end	
		end
	end
			
---COMBO---
	if IOW:Mode() == "Combo" then
	--CAST W
		if GoS:ValidTarget(target, 700) and KindredM.Combo.W:Value() then
			if CanUseSpell(myHero, _W) == READY then
				CastSpell(_W)
			end			
		end
--CAST Q
		if GoS:ValidTarget(target, 550) then
			if GetCastName(myHero, _Q) == "KindredQ" then
				local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1700,250,750,50,false,true)
				if KindredM.Combo.Q:Value() then
					if KindredM.Combo.QM:Value() then
						QPred.PredPos=GetMousePos()
					end
					if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 then
						CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
					end
				end
			end
		end
	--CAST E	          							  
		if KindredM.Combo.E:Value() then
			if CanUseSpell(myHero, _E) == READY and GoS:ValidTarget(target,GetCastRange(myHero,_E)) then
			   CastTargetSpell(target,_E)
			end
		end
		 --CAST R
		for _, ally in pairs(GoS:GetAllyHeroes()) do
			if KindredM.Combo.R then
				if GoS:ValidTarget(target, 650) and (GetCurrentHP(ally)/GetMaxHP(ally))<0.15 and CanUseSpell(myHero, _R) == READY and IsObjectAlive(ally) then
					CastTargetSpell(ally,_R)
				end
			end	
		end
	end
		
---JUNGLECLEAR---- Thanks Deftsu <3
	if IOW:Mode() == "LaneClear" then
			
		for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		
		
			if CanUseSpell(myHero, _W) == READY and KindredM.JungleClear.W:Value() and GoS:ValidTarget(mob, 450) then
				local mobPos=GetOrigin(mob)
				CastSpell(_W)
			end
			
			if CanUseSpell(myHero, _Q) == READY and KindredM.JungleClear.Q:Value() and GoS:ValidTarget(mob, 450) then
				local mobPos=GetOrigin(mob)
				if KindredM.JungleClear.QM:Value() then
					mobPos=GetMousePos()
				end
				CastSkillShot(_Q,mobPos.x,mobPos.y,mobPos.z)
			end
			
			
			if CanUseSpell(myHero, _E) == READY and KindredM.JungleClear.E:Value() and GoS:ValidTarget(mob, 450) then
				CastTargetSpell(mob, _E)
			end
			
		end
	end



---LANECLEAR----
	if IOW:Mode() == "LaneClear" then


		for _,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
			if CanUseSpell(myHero, _Q) == READY and KindredM.LaneClear.Q:Value() and GoS:ValidTarget(minion, 450) then
				local minionPos=GetOrigin(minion)
				if KindredM.LaneClear.Q:Value() then
					minionPos=GetMousePos()
				end
				CastSkillShot(_Q,minionPos.x,minionPos.y,minionPos.z)
			end
			
			
			if CanUseSpell(myHero, _E) == READY and KindredM.LaneClear.E:Value() and GoS:ValidTarget(minion, 450) then
				CastTargetSpell(minion, _E)
			end
			

			
		end
	end

---DRAWINGS----
	if KindredM.Drawings.Q:Value() then 
		DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,550,1,128,0xff00ff00)
	 end


----AUTOLVL-----
local leveltable = {_W, _Q, _E, _Q, _Q, _R, _E, _E, _E, _Q, _R, _E, _Q, _W, _W, _R, _W, _W}
	if KindredM.Misc.Autolvl:Value() then  
		if GetLevel(myHero) == 3 then
			LevelSpell(leveltable[3])
			LevelSpell(leveltable[2])
			LevelSpell(leveltable[1])
		else
			LevelSpell(leveltable[GetLevel(myHero)]) 
		end
	end
end)

PrintChat("Shadowfire Kindred by Musti")
