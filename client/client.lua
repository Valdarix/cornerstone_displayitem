local displayTime = Config.displayTime or 10

local function displayItemImage(item)
    if item then
        SendNUIMessage({
            action = 'displayImage',
            imagePath = string.format(Config.InventoryImagePath, item)
        })

        SetNuiFocus(true, false)
        Citizen.Wait(displayTime * 1000)
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'hideImage' })
    end
end

local function tryDisplay(item)       
    local hasItem = lib.callback.await('vg_displayItem:server:displayItemImage', false, item)
    print(hasItem)
    if hasItem then
        displayItemImage(item)    
    end
end

RegisterNetEvent('vg_displayItem:methGathering', function()
    local item = 'meth_gathering_hint'   
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:weedGathering', function()
    local item = 'weed_gathering_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:cokeGathering', function()
    local item = 'coke_gathering_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:crackGathering', function()
    local item = 'crack_gathering_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:weedProcessing', function()
    local item = 'weed_processing_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:methProcessing', function()
    local item = 'meth_processing_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:cokeProcessing', function()
    local item = 'coke_processing_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:crackProcessing', function()
    local item = 'crack_processing_hint'
    tryDisplay(item)
end)

RegisterNetEvent('vg_displayItem:wwVipMenu', function()
    local item = 'white_widow_vip_menu'
    tryDisplay(item)
end)


