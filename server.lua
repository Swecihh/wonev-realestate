local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("wonev:CheckMiktar")
AddEventHandler("wonev:CheckMiktar", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    if not Player then return end 

    local HasItem = Player.Functions.GetItemByName("markedbills") 

    if HasItem and HasItem.amount and HasItem.amount >= amount then 
        Player.Functions.RemoveItem("markedbills", amount) 
        Player.Functions.AddMoney("cash", amount, "Parayı Bozdunuz") 

        TriggerClientEvent('QBCore:Notify', src, amount .. " işaretli para bozduruldu!", "success", 4000)
    else
        TriggerClientEvent('QBCore:Notify', src, "Yeterli miktarda işaretli paranız yok!", "error", 4000)
    end
end)
