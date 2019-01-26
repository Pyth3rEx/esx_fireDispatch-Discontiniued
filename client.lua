RegisterCommand("fireAlarm",
  function(source, args, rawCommand)
		fireAlarm(stationNum)
  end,
false)

Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/fireAlarm', 'send the fireDispatch main function', { {name='station number', help="the station's number"} })
end)
