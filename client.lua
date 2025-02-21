local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

function EmlakMenusu()
    local mainMenu = {
        {
            header = "İşaretli Para Bozma Menüsü",
            isMenuHeader = true
        },
        {
            header = "Kara Para Boz",
            params = {
                event = "custom:openInput"
            }
        }
    }
    TriggerEvent('qb-menu:client:openMenu', mainMenu)
end

RegisterNetEvent('custom:openInput', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Miktarı Girin",
        submitText = "Kaydet",
        inputs = {
            {
                type = "number",
                isRequired = true,
                name = "KaraParaMiktar",
                text = "Miktarı Girin"
            }
        }
    })
    if dialog then
        local amount = tonumber(dialog.KaraParaMiktar)
        if amount and amount > 0 then
            TriggerServerEvent("wonev:CheckMiktar", amount)
        end
    else
        QBCore.Functions.Notify("Geçersiz Miktar Girdiniz", "error", 2000)
    end
end)


CreateThread(function()
    while true do
        local sleep = 2000
        if PlayerData.job and PlayerData.job.name == Config.Emlak1 or PlayerData.job and PlayerData.job.name == Config.Emlak2 or PlayerData.job and PlayerData.job.name == Config.Emlak3   then
            local Player = PlayerPedId()
            local coords = GetEntityCoords(Player)
            for k, v in pairs(Config.Coords) do
                local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, false)
                if distance < 5 then
                    sleep = 0
                    QBCore.Functions.DrawText3D(v.x, v.y, v.z, '[E] Emlak Menüsü')
                    if distance < 1.5 then
                        if IsControlJustPressed(0, 38) then
                            EmlakMenusu()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)
