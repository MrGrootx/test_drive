ESX = exports["es_extended"]:getSharedObject()

local testVehicle
local remainingsec = 0
RegisterCommand('testdrive', function(source, args, rawCommand)
   local modelName = args[1]

   if modelName ~= nil then
      spawnVehicle(modelName)
   end
   startTimer()
end, false)


Citizen.CreateThread(function()
   while true do
      if testVehicle ~= nil and remainingsec >= 0 then
         remainingsec = remainingsec - 1

         -- print(remainingsec)

         -- if remainingsec == 15 or remainingsec == 10 or remainingsec == 5 or remainingsec == 3 or remainingsec == 2 or remainingsec == 1 then
         --    ShowNotification('~g~' .. remainingsec .. 'Sec')
         -- end

         if remainingsec <= 0 then
            DeleteVehicle(testVehicle)
         end
      end

      Citizen.Wait(1000)
   end
end)


function disp_time(time)
   local minutes = math.floor((time % 3600 / 60))
   local seconds = math.floor((time % 60))
   return string.format("%02dm %02ds", minutes, seconds)
end
-- startTimer()
function startTimer()
   Citizen.CreateThread(function()

      Citizen.CreateThread(function()
         while remainingsec > 0 do
            remainingsec = remainingsec - 1
            Citizen.Wait(1000)
         end
      end)

      while remainingsec > 0 do
         Citizen.Wait(0)
         SetTextFont(4)
         SetTextScale(0.45, 0.45)
         SetTextColour(185, 185, 185, 255)
         SetTextDropshadow(0, 0, 0, 0, 255)
         SetTextEdge(1, 0, 0, 0, 255)
         SetTextDropShadow()
         SetTextOutline()
         BeginTextCommandDisplayText('STRING')
         AddTextComponentSubstringPlayerName(disp_time(remainingsec) .. " - Time Remaining")
         EndTextCommandDisplayText(0.05, 0.55)
      end
      
   end)
end

function spawnVehicle(model)
   remainingsec = 300
   local vehicleHash = GetHashKey(model)
   RequestModel(vehicleHash)

   while not HasModelLoaded(vehicleHash) do
      Citizen.Wait(1)
   end

   local pPed = PlayerPedId()
   local pos = GetEntityCoords(pPed)
   testVehicle = CreateVehicle(vehicleHash, pos.x, pos.y, pos.z, GetEntityHeading(pPed), true, false)
   SetVehicleOnGroundProperly(testVehicle)
   SetPedIntoVehicle(pPed, testVehicle, -1)
   SetVehicleNumberPlateText(testVehicle, 'GROOT')
   SetModelAsNoLongerNeeded(testVehicle)
end

function ShowNotification(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, true)
end
