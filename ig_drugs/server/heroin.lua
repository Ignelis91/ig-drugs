local playersProcessingPoppyResin = {}

RegisterServerEvent('esx_illegal:pickedUpPoppy')
AddEventHandler('esx_illegal:pickedUpPoppy', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('poppyresin')
	if xPlayer.getInventoryItem('poppyresin').count < 81 then
		if xPlayer.canCarryItem('poppyresin', 1) then
			xPlayer.addInventoryItem(xItem.name, 1)		
		else
			TriggerClientEvent('esx:showNotification', _source, _U('poppy_inventoryfull'))	
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('poppy_inventoryfull'))
	end
end)

RegisterServerEvent('esx_illegal:processPoppyResin')
AddEventHandler('esx_illegal:processPoppyResin', function()
	if not playersProcessingPoppyResin[source] then
		local _source = source

		playersProcessingPoppyResin[_source] = ESX.SetTimeout(Config.Delays.HeroinProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xPoppyResin, xHeroin = xPlayer.getInventoryItem('poppyresin'), xPlayer.getInventoryItem('heroin')
		if xPlayer.getInventoryItem('poppyresin').count > 2 then
			if xPlayer.canCarryItem('heroin', 1) then
				
					xPlayer.removeInventoryItem('poppyresin', 2)
					xPlayer.addInventoryItem('heroin', 1)

					TriggerClientEvent('esx:showNotification', _source, _U('heroin_processed'))
			else
				TriggerClientEvent('esx:showNotification', _source, _U('heroin_processingfull'))
			end				
		else
			TriggerClientEvent('esx:showNotification', _source, _U('heroin_processingenough'))	
		end

			playersProcessingPoppyResin[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit heroin processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingPoppyResin[playerID] then
		ESX.ClearTimeout(playersProcessingPoppyResin[playerID])
		playersProcessingPoppyResin[playerID] = nil
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
