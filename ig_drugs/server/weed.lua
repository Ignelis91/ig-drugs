local playersProcessingCannabis = {}

RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('cannabis')
	if xPlayer.getInventoryItem('cannabis').count < 30 then
		if xPlayer.canCarryItem('cannabis', 1) then	
			xPlayer.addInventoryItem(xItem.name, 1)
		else
			TriggerClientEvent('esx:showNotification', source, _U('weed_inventoryfull'))
		end
	else
	TriggerClientEvent('esx:showNotification', source, _U('weed_inventoryfull'))
	end
end)

RegisterServerEvent('esx_illegal:processCannabis')
AddEventHandler('esx_illegal:processCannabis', function()
	if not playersProcessingCannabis[source] then
		local _source = source

		playersProcessingCannabis[_source] = ESX.SetTimeout(Config.Delays.WeedProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCannabis, xMarijuana = xPlayer.getInventoryItem('cannabis'), xPlayer.getInventoryItem('marijuana')
		if xPlayer.getInventoryItem('cannabis').count > 2 then
			if xPlayer.canCarryItem('marijuana', 1) then
				xPlayer.removeInventoryItem('cannabis', 3)
				xPlayer.addInventoryItem('marijuana', 1)
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processed'))

			else
				TriggerClientEvent('esx:showNotification', _source, _U('weed_processingfull'))
			end
				
		else
			TriggerClientEvent('esx:showNotification', _source, _U('weed_processingenough'))
		end

			playersProcessingCannabis[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit weed processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

RegisterServerEvent('esx_illegal:cancelProcessing')
AddEventHandler('esx_illegal:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
