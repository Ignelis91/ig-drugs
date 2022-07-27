local playersProcessingCocaLeaf = {}

RegisterServerEvent('esx_illegal:pickedUpCocaLeaf')
AddEventHandler('esx_illegal:pickedUpCocaLeaf', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('coca_leaf')
	if xPlayer.getInventoryItem('coca_leaf').count < 30 then
		if xPlayer.canCarryItem('coca_leaf', 1) then
			xPlayer.addInventoryItem(xItem.name, 1)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('coca_leaf_inventoryfull'))
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('coca_leaf_inventoryfull'))
	end
end)

RegisterServerEvent('esx_illegal:processCocaLeaf')
AddEventHandler('esx_illegal:processCocaLeaf', function()
	if not playersProcessingCocaLeaf[source] then
		local _source = source

		playersProcessingCocaLeaf[_source] = ESX.SetTimeout(Config.Delays.CokeProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCocaLeaf, xCoke = xPlayer.getInventoryItem('coca_leaf'), xPlayer.getInventoryItem('coke')
		if xPlayer.getInventoryItem('coca_leaf').count > 2 then
			if xPlayer.canCarryItem('coke', 1) then
				xPlayer.removeInventoryItem('coca_leaf', 3)
				xPlayer.addInventoryItem('coke', 1)
				TriggerClientEvent('esx:showNotification', _source, _U('coke_processed'))
			else
				TriggerClientEvent('esx:showNotification', _source, _U('coke_processingfull'))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('coke_processingenough'))
		end

			playersProcessingCocaLeaf[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit coke processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingCocaLeaf[playerID] then
		ESX.ClearTimeout(playersProcessingCocaLeaf[playerID])
		playersProcessingCocaLeaf[playerID] = nil
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
