local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = exports['es_extended']:getSharedObject()

local LastCar

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)
		if CurrentAction then
			exports['j-textui']:Help(CurrentActionMsg)
		end
	end
end)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = false

	exports['j-textui']:Help('Gaminimo procesas sustabdytas...')
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	exports['j-textui']:Help('Pradedama gamyba')
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Pradeta narkotiku gamyba')
	ESX.ShowNotification("Amfetamino gaminimo procesas prasidejo")
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(5000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('esx_methcar:drugged')
AddEventHandler('esx_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(250000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								exports['j-textui']:Help('Spauskite ~INPUT_DETONATE~ kad pradetumete gamyba')
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y <= 5250 and pos.y >= 1000 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('esx_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									exports['j-textui']:Help('Mašina jau užimta')
								end
							else
								ESX.ShowNotification('Jus per daug arti miesto, važiuokite i šiaure, arciau kalnu')
							end
							
							
							
							
		
						end
					end
					
				
				
			
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Narkotiku gamyba sustabdyta')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(5000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('Amfetamino gaminimo procesas: ' .. progress .. '%')
					Citizen.Wait(5000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Duju balionas prateka, ka darote?')	
						ESX.ShowNotification('~o~1. Panaudojate lipnia juosta')
						ESX.ShowNotification('~o~2. Paliekate kaip yra ')
						ESX.ShowNotification('~o~3. Pakeiciate i nauja')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Šiek tiek padejo')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Duju balionas sprogo, sugadinote produkcija...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Gamybos procesas sustabdytas')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Šaunuolis, taip ir toliau')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Išpylete acetono ant žemes, ka darote?')	
						ESX.ShowNotification('~o~1. Atidarote langus noredama(s) panaikinti kvapa')
						ESX.ShowNotification('~o~2. Paliekate kaip yra')
						ESX.ShowNotification('~o~3. Užsidesite kauke su oro filtru')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Atidarete langus')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Jus apsvaigote nuo acetono kvapo')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Lengvas ir veiksmingas problemos sprendimas')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Narkotikai pradeda kieteti per greitai, ka darote? ')	
						ESX.ShowNotification('~o~1. Padidinate slegi')
						ESX.ShowNotification('~o~2. Padidinate temperatura')
						ESX.ShowNotification('~o~3. Sumažinate slegi')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Pakelus slegi atsirado duju nuotekis, tad tu spaudima sumazini atgal')
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Temperaturos didinimas padejo...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Sumažinus slegi padarete dar blogiau negu buvo...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Jus netycia ipylete per daug acetono, ka darote?')	
						ESX.ShowNotification('~o~1. Nieko')
						ESX.ShowNotification('~o~2. Bandote ji išsiurbti su švirkštu')
						ESX.ShowNotification('~o~3. Imetate daugiau bateriju bandydamas viska balansuoti')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('ReligionRPN arkotikai turi svelnu acetono kvapa')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Tai suveike, bet acetono vis tiek per daug')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Jus sekmingai ivedete chemini balansa, kuris duos puikius rezultatus!')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Prakiuro megintuvelis, ka darote?')	
						ESX.ShowNotification('~o~1. Panaudojate lipnia juosta')
						ESX.ShowNotification('~o~2. Paliekate kaip yra ')
						ESX.ShowNotification('~o~3. Pakeiciate i nauja')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Šiek tiek padejo')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Megintuvelis sprogo, sugadinote produkcija...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Gamybos procesas sustabdytas')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Šaunuolis, taip ir toliau')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Užsikimšo filtas, ka darote?')	
						ESX.ShowNotification('~o~1. Išvalote naudodamas kompresoriu')
						ESX.ShowNotification('~o~2. Pakeiciate i nauja filtra')
						ESX.ShowNotification('~o~3. Išvalote su dantu šepetuku')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Kompresoriaus spaudziamas oras padare netvarka, apsitaskete narkotikais')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Pakeitimas buvo vienas geriausiu sprendimu')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Tai suveike, bet like dalis nesvarumu')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				if progress > 58 and progress < 60 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Ispylete buteliuka acetono ant zemes, ka darote?')	
						ESX.ShowNotification('~o~1. Atidarote langus noredama(s) panaikinti kvapa')
						ESX.ShowNotification('~o~2. Nieko')
						ESX.ShowNotification('~o~3. Užsidedate kauke su oro filtru')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Atidarete langus noredama(s) panaikinti kvapa')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Jus prisikvepavote nuo acetono kvapo')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Lengvas ir veiksmingas problemos sprendimas')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 1 - 6
				--
				if progress > 63 and progress < 65 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Duju balionas prateka, ka darote?')	
						ESX.ShowNotification('~o~1. Panaudojate lipnia juosta')
						ESX.ShowNotification('~o~2. Paliekate kaip yra ')
						ESX.ShowNotification('~o~3. Pakeiciate i nauja')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Lipni juosta nuoteki susilpnino')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Duju balionas sprogo, jums nepavyko...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Narkotiku gamyba sustabdyta')
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Geras sprendimas, iranga jau buvo pasenusi')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 4 - 7
				--
				if progress > 71 and progress < 73 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Užsikimšo filtas, ka darote?')	
						ESX.ShowNotification('~o~1. Isvalote naudodamas kompresoriu')
						ESX.ShowNotification('~o~2. Pakeiciate i nauja filtra')
						ESX.ShowNotification('~o~3. Isvalote naudodamas dantu sepeteli')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Kompresoriaus spaudziamas oras padare netvarka, apsitaskete narkotikais')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Pakeitimas buvo vienas geriausiu sprendimu')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Tai suveike, bet like dalis nesvarumu')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 8
				--
				if progress > 76 and progress < 78 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Per klaida ipylete per daug acetono, ka darote?')	
						ESX.ShowNotification('~o~1. Nieko')
						ESX.ShowNotification('~o~2. Bandote ji istraukti naudodamas svirksta')
						ESX.ShowNotification('~o~3. Imetate daugiau bateriju bandydamas viska balansuoti')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Narkotikai turi svelnu acetono kvapa')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Tai suveike, bet acetono vis tiek per daug')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Jus sekmingai ivedete chemini balansa, kuris duos puikiu rezultatu!')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Tave baisiai prispaude "prie reikalo", ka darai?')	
						ESX.ShowNotification('~o~1. Bandote sulaikyti kol gaminimas vyksta')
						ESX.ShowNotification('~o~2. Iseinate i lauka ir atliekate gamtinius reikalus')
						ESX.ShowNotification('~o~3. Atliekate gamtinius reikalus viduje')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Sveikinu, darbas = pinigai! Pasiksi grizes')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Kol buvote lauke, stikline nukrito ant zemes ir viskas issipyle....')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Viskas smirda, jus smirdate, net ir narkotikai smirda..')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Ar norite prideti stiklo gabaleliu i savo narkotikus?')	
						ESX.ShowNotification('~o~1. Taip!')
						ESX.ShowNotification('~o~2. Ne!')
						ESX.ShowNotification('~o~3. Ar nusprendziate daryti atvirksciai?')
						ESX.ShowNotification('~c~Spauskite klaviaturos skaicius')
					end
					if selection == 1 then
						print("Pasirinkote varianta 1")
						ESX.ShowNotification('Pridejus stiklo gavosi keleta maisiuku daugiau')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Pasirinkote varianta 2")
						ESX.ShowNotification('Jus esate saziningas virejas, aukstos kokybes narkotikai')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Pasirinkote varianta 3")
						ESX.ShowNotification('Geriau taip nedarykite, lengva atskirti, jog narkotikai netikri')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('Gamybos procesas: ' .. progress .. '%')
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				ESX.ShowNotification('Gamybos procesas: ' .. progress .. '%')
				ESX.ShowNotification('Gamyba baigta!')
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('Pasirinkote skaiciu 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('Pasirinkote skaiciu 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('Pasirinkote skaiciu 3')
			end
		end

	end
end)




