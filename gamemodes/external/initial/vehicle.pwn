#include <ysilib\YSI_Coding\y_hooks>

hook OnVehicleSpawn(vehicleid)
{
	new
		bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

    if (IsVehicleBicycle(GetVehicleModel(vehicleid)))
    {
        SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
    }
    else 
    {
        SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
    }

	return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        if(newkeys & KEY_NO)
        {
            new veh = GetPlayerVehicleID(playerid),
                bool:engine,
                bool:lights,
                bool:alarm,
                bool:doors,
                bool:bonnet,
                bool:boot,
                bool:objective;
            
            if(IsVehicleBicycle(GetVehicleModel(veh)))
            {
                return true;
            }
            
            GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

            if(engine == VEHICLE_PARAMS_OFF)
            {
                SetVehicleParamsEx(veh, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
            }
            else
            {
                SetVehicleParamsEx(veh, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
            }

            new str[60];
            format(str, sizeof(str),""color_server"Santorini // "color_white"Engine State : %s", (engine == VEHICLE_PARAMS_OFF) ? "on" : "off");
            SendClientMessage(playerid, -1, str);

            return true;
        }
        if(newkeys & KEY_YES)
        {
            new veh = GetPlayerVehicleID(playerid),
                bool:engine,
                bool:lights,
                bool:alarm,
                bool:doors,
                bool:bonnet,
                bool:boot,
                bool:objective;
            
            if(IsVehicleBicycle(GetVehicleModel(veh)))
            {
                return true;
            }
            
			GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

            if(lights == VEHICLE_PARAMS_OFF)
            {
                SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
            }
            else
            {
                SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
            }
            new str[60];
            format(str, sizeof(str),""color_server"Santorini // "color_white"Lights State : %s", (lights == VEHICLE_PARAMS_OFF) ? "on" : "off");
            SendClientMessage(playerid, -1, str);

            return true;
        }
    }

	return 1;
}

hook OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	new veh = GetPlayerVehicleID(playerid),
            	bool:engine,
            	bool:lights,
            	bool:alarm,
            	bool:doors,
            	bool:bonnet,
                bool:boot,
                bool:objective;

    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

	if (newstate == PLAYER_STATE_DRIVER) 
    {
        if(engine == VEHICLE_PARAMS_OFF)
        {   
            SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"To start engine press 'N'");
        }
	}

	return 1;
}

IsVehicleBicycle(m)
{
    if (m == 481 || m == 509 || m == 510) return true;
    
    return false;
}

stock GetVehicleSpeed(vehicleid)
{
	new Float:xPos[3];

	GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);

	return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}