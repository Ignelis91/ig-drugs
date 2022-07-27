Config = {}

Config.UseTarget = true

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.DrugDealerItems = {
	heroin = 260,
	meth = 300,
	weed = 200,
	coke = 260,
}

Config.Barygos = {
	{
		pos = {x = -3181.4780, y = 1253.2495, z = 5.7005, h = 176.2496}, -- 1 Baryga
		model = 'a_m_m_og_boss_01',
		spawned = false,
		seller = true,
	},
	{
		pos = {x = 374.6591, y = 3574.8137, z = 32.2922, h = 204.0453}, -- 2 Baryga
		model = 'a_m_y_stbla_01',
		spawned = false,
		seller = true,
	},
	{
		pos = {x = 2191.8291, y = 5596.0039, z = 52.7661, h = 256.2791}, -- 3 Baryga
		model = 'a_m_y_musclbeac_02',
		spawned = false,
		seller = true,
	},
	{
		pos = {x = -287.8379, y = 2535.5835, z = 74.6890, h = 277.9637}, -- 2 Baryga
		model = 'a_m_y_vindouche_01',
		spawned = false,
		seller = true,
	},
	{
		pos = {x = 473.2459, y =  -2184.0151, z = 4.9177, h = 68.8085}, -- Plovimas
		model  = 'a_m_y_musclbeac_02',
		spawned = false,
		seller = true,
	},
}

Config.GiveBlack = true 

Config.CircleZones = {
	WeedField = {coords = vector3(3362.4768, 2758.5049, 24.0518), blimpcoords = vector3(48.83, 6305.34, 31.36), name = _U('blip_moneywash'), color = 1, sprite = 500, radius = 0.0, enabled = false},
	MoneyWash = {coords = vector3(473.2459, -2184.0151, 5.9177), blimpcoords = vector3(48.83, 6305.34, 31.36), name = _U('blip_moneywash'), color = 1, sprite = 500, radius = 0.0, enabled = false},
	HeroinProcessing = {coords = vector3(374.6921, 3574.7703, 33.2922), blimpcoords = vector3(358.9792, 3562.6536, 22.7843), name = _U('blip_heroinprocessing'), color = 7, sprite = 497, radius = 0.0, enabled = true},
	WeedProcessing = {coords = vector3(-3177.7502, 1251.2363, 5.6280), blimpcoords = vector3(1974.9766, 3818.4744, 32.4363), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 0.0, enabled = true},
	CokeProcessing = {coords = vector3(2191.7561, 5595.7700, 53.7691), blimpcoords = vector3(2191.7561, 5595.7700, 53.7691), name = _U('blip_Cokeprocessing'),color = 4, sprite = 501, radius = 0.0, enabled = true},
	CokeField = {coords = vector3(2526.7825, -1223.3091, 2.2997), blimpcoords = vector3(241.9946, 3584.0212, 33.8924), name = _U('blip_CokeFarm'), color = 4, sprite = 501, radius = 0.0, enabled = true},
	HeroinField = {coords = vector3(-1953.4255, 4534.0977, 8.5323), blimpcoords = vector3(-490.2259, 1566.5798, 376.2160), name = _U('blip_heroinfield'), color = 7, sprite = 497, radius = 0, enabled = true},
	DrugDealer = {coords = vector3(-287.6381, 2535.4434, 75.6924), blimpcoords = vector3(1415.4403, 1163.2677, 114.3342), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 0.0, enabled = true},
}
