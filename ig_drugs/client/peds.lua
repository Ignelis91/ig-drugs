local npc = {}
local npcThreadas = 3000
local barygos = {}
CreateThread(function() 
	while true do
		Wait(npcThreadas)
		local pos = GetEntityCoords(PlayerPedId())
		local dist = 0
		for k,v in pairs(Config.Barygos) do
			dist = #(vec3(v.pos.x, v.pos.y, v.pos.z) - pos)
			if dist < 100 and not v.spawned then
				local hash = GetHashKey(v.model)
				-- Modelio uzkrovimas
				if not HasModelLoaded(hash) then
					RequestModel(hash)
					Wait(10)
				end
				while not HasModelLoaded(hash) do 
					Wait(10)
				end

				local pedas = CreatePed(1, hash, v.pos.x, v.pos.y, v.pos.z, v.pos.h, false, false)
				FreezeEntityPosition(pedas, true)
                TaskStartScenarioInPlace(pedas, "WORLD_HUMAN_COP_IDLES", 0, true)
                SetBlockingOfNonTemporaryEvents(pedas, true)
				SetEntityInvincible(pedas, true)
				SetBlockingOfNonTemporaryEvents(illegpedasalFishSeller, true)
				SetModelAsNoLongerNeeded(hash)
				v.spawned = true
				barygos[k] = pedas
			elseif v.spawned and dist > 100 then
				v.spawned = false
				DeleteEntity(barygos[k])
			end
		end
	
	end
end)


