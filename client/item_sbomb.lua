local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
local import = LoadResourceFile('ox_core', file)
local chunk = assert(load(import, ('@@ox_core/%s'):format(file)))
chunk()

-- local variables
local trap = nil

RegisterCommand('testsmoke', function()
    TriggerEvent('smoketrap_place')
end)

RegisterNetEvent('smoketrap_place')
AddEventHandler('smoketrap_place', function()
    local playercoords = GetEntityCoords(GetPlayerPed(-1))
    local player = GetPlayerPed(-1)
    local time = 10

    -- Anim to place item
    exports.scully_emotemenu:PlayByCommand('mechanic4')
    if lib.progressCircle({
        duration = 2000,
        position = 'middle',
        useWhileDead = false,
        canCancel = false,
        }) 
        then exports.scully_emotemenu:CancelAnimation()
    end
    -- Place item on ground
    trap = CreateObject('h4_prop_h4_ld_bomb_02a', playercoords, false, false, false)
    PlaceObjectOnGroundProperly(trap)
    FreezeEntityPosition(trap, true)
    local smokebombcoords = GetEntityCoords(trap)

    Citizen.Wait(10000)

	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1 = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", 
        smokebombcoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
end)

RegisterNetEvent('smoketrap_trigger', function()
end)