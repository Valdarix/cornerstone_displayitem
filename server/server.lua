
lib.callback.register('vg_displayItem:server:displayItemImage', function(source, item)    
    if item then
        if exports.ox_inventory:GetItemCount(source, item) >= 1 then
            return true
        end
    else
        if Config.UseOxLibLogging then
            lib.logger(source, 'PRIORITY', 'Player triggered event without the item in their inventory.')
        end
        return false
    end
end)

