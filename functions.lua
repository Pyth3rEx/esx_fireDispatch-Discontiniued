local fireHornLocation = {
    { x = 1194.27, y = -1464.01, z = 36.65, name = "El Burro Station"},
    { x = 206.5, y = -1339.75, z = 31.59, name = "Davis Station"},
}

function fireAlarm(stationNum) --Make use of stationNum!!

    TriggerEvent("chatMessage", "[Dispatch]", {255,0,0}, "Alarm is going off!")

    for i = 1, #fireHornLocation do
        TriggerEvent("chatMessage", "[Dispatch]", {255,0,0}, fireHornLocation[i].name.." responding!")
        PlaySoundFromCoord(-1, "silo_alarm_loop", fireHornLocation[i].x, fireHornLocation[i].y, fireHornLocation[i].z, "dlc_xm_silo_finale_sounds", 1, 500, 0)
    end
end
