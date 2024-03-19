#include <ysilib\YSI_Coding\y_hooks>

static
    player_Leader[MAX_PLAYERS],
    player_Team[MAX_PLAYERS];

new IsPlayerInvited[MAX_PLAYERS];
new PlayerTakeTeamVehicle[MAX_PLAYERS];

hook Account_Load(playerid, const string: name[], const string: value[])
{
    INI_Int("Leader", player_Leader[playerid]);
    INI_Int("Team", player_Team[playerid]);
	return 1;
}

hook OnGameModeInit()
{
    AddStaticPickup(19197, 0, -1390.0066, 2638.8303, 54.9844, 0); //sheriff enter
    AddStaticPickup(19197, 0, 246.8432, 63.0917, 1002.6406, 0); //sheriff exit

    AddStaticPickup(19197, 0, -1400.0360, 2640.6885, 54.6875, 0); //sheriff vehicle
    AddStaticPickup(19197, 0, -1400.0360, 2644.0408, 54.6875, 0); //sheriff vehicle
    AddStaticPickup(19197, 0, -1400.0360, 2647.1194, 54.6875, 0); //sheriff vehicle
    AddStaticPickup(19197, 0, -1400.0360, 2659.5974, 54.6875, 0); //sheriff vehicle

    AddStaticPickup(19197, 0, -910.9723, 2685.9023, 41.3703, 0); //lafamilia enter
    AddStaticPickup(19197, 0, 2365.2339, -1135.5983, 1049.8826, 0); //lafamilia exit

    AddStaticPickup(19197, 0, -901.5115, 2695.4634, 41.3703, 0); //lafamilia vehicle



    Create3DTextLabel("If you want to enter press "color_server"'N'", -1, -1390.0066, 2638.8303, 55.9844, 5.0, 0, true); //sheriff enter
    Create3DTextLabel("If you want to exit press "color_server"'N'", -1, 246.8432, 63.0917, 1003.6406, 5.0, 0, true); //sheriff exit

    Create3DTextLabel("Get Sheriff vehicle from garage press "color_server"'Y'", -1, -1400.0360, 2640.6885, 55.6875, 5.0, 0, true); //sheriff vehicle
    Create3DTextLabel("Get Sheriff vehicle from garage press "color_server"'Y'", -1, -1400.0360, 2644.0408, 55.6875, 5.0, 0, true); //sheriff vehicle
    Create3DTextLabel("Get Sheriff vehicle from garage press "color_server"'Y'", -1, -1400.0360, 2647.1194, 55.6875, 5.0, 0, true); //sheriff vehicle
    Create3DTextLabel("Get Sheriff vehicle back to garage "color_server"'Just Leave Vehicle'", -1, -1400.0360, 2659.5974, 55.6875, 5.0, 0, true); //sheriff vehicle

    Create3DTextLabel("Get LaFamilia vehicle from garage press "color_server"'Y'\n"color_white"Get LaFamilia vehicle back to garage "color_server"'Just Leave Vehicle'", -1, -901.5115, 2695.4634, 42.3703, 5.0, 0, true); //lafamilia enter


    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Leader", player_Leader[playerid]);
    INI_WriteInt(File, "Team", player_Team[playerid]);
    INI_Close(File);

	return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if (newkeys & KEY_NO)
        { 
            if (IsPlayerInTeam(playerid, 0)) 
            {       
                if (IsPlayerInRangeOfPoint(playerid, 1.0, -1390.0066, 2638.8303, 55.9844))
                {        
                        SetPlayerInterior(playerid, 6);
                        SetPlayerPos(playerid, 246.8432, 63.0917, 1003.6406);
                }

                if (IsPlayerInRangeOfPoint(playerid, 1.0, 246.8432, 63.0917, 1003.6406))           
                {

                    SetPlayerInterior(playerid, 0);
                    SetPlayerPos(playerid, -1390.0066, 2638.8303, 55.9844);

                }
            }

            if (IsPlayerInTeam(playerid, 1))
            {
                if (IsPlayerInRangeOfPoint(playerid, 1.0, -910.9723, 2685.9023, 42.3703))
                {          
                        SetPlayerInterior(playerid, 8);
                        SetPlayerPos(playerid, 2365.2339, -1135.5983, 1050.8826);
                }

                if (IsPlayerInRangeOfPoint(playerid, 1.0, 2365.2339, -1135.5983, 1050.8826))
                {
                        SetPlayerInterior(playerid, 0);
                        SetPlayerPos(playerid, -910.9723, 2685.9023, 42.3703);
                }
            }
        }
        
        if (newkeys & KEY_YES)
        { 
            if (IsPlayerInTeam(playerid, 0)) 
            {
                new bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;
                new vehicleid = GetPlayerVehicleID(playerid);

                if (IsPlayerInRangeOfPoint(playerid, 1.0, -1400.0360, 2640.6885, 55.6875))
                {        
                    vehicleid = CreateVehicle(523, -1400.0360, 2640.6885, 55.6875, 90, 0, 1, -1, true);
                    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleNumberPlate(vehicleid, "SD");
                    PutPlayerInVehicle(playerid, vehicleid, 0);
                    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);

                    PlayerTakeTeamVehicle[playerid] = 1;
                }

                if (IsPlayerInRangeOfPoint(playerid, 1.0, -1400.0360, 2644.0408, 55.6875))           
                {
                    vehicleid = CreateVehicle(598, -1400.0360, 2644.0408, 55.6875, 90, 0, 1, -1, true);
                    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleNumberPlate(vehicleid, "SD");
                    PutPlayerInVehicle(playerid, vehicleid, 0);
                    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
                    PlayerTakeTeamVehicle[playerid] = 1;
                }

                if (IsPlayerInRangeOfPoint(playerid, 1.0, -1400.0360, 2647.1194, 55.6875))           
                {
                    vehicleid = CreateVehicle(599, -1400.0360, 2647.1194, 55.6875, 90, 0, 1, -1, true);
                    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleNumberPlate(vehicleid, "SD");
                    PutPlayerInVehicle(playerid, vehicleid, 0);
                    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
                    PlayerTakeTeamVehicle[playerid] = 1;
                }
            }
            
            if (IsPlayerInTeam(playerid, 1))
            {
                new bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;
                new vehicleid = GetPlayerVehicleID(playerid);

                if (IsPlayerInRangeOfPoint(playerid, 1.0, -901.5115, 2695.4634, 42.3703))
                {          
                    vehicleid = CreateVehicle(560, -901.9523,2687.4414,42.0864, 45, 0, 1, -1, true);
                    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleNumberPlate(vehicleid, "LF");
                    PutPlayerInVehicle(playerid, vehicleid, 0);
                    SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
                    PlayerTakeTeamVehicle[playerid] = 1;
                }
            }
        }
    }
    return 1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if (IsPlayerInRangeOfPoint(playerid, 1.0, -1400.0360, 2659.5974, 55.6875))
    {        
        GetPlayerVehicleID(playerid);
        DestroyVehicle(vehicleid);
    }

    if (IsPlayerInRangeOfPoint(playerid, 1.0, -901.5115, 2695.4634, 42.3703))
    {        
        GetPlayerVehicleID(playerid);
        DestroyVehicle(vehicleid);
    }

    return 1;
}

IsPlayerInTeam(playerid, teamid)
{
    return (player_Team[playerid] == teamid);
}

YCMD:setleader(playerid, params[], help) 
{
    if (help)
        return SendClientMessage(playerid, -1, ""color_server"HELP >> "color_white"0 - Revoke Leader | 1. Sheriff | 2. LaFamilia");

	if (!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You Must Be RCON!");

    static
		targetid,
		teamid;

	if (sscanf(params, "ri", targetid, teamid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/setleader [targetid] [teamid]");

    if (teamid == 0)
    {
        SetPlayerTeam(playerid, 255);
        player_Leader[targetid] = 255;
        player_Team[targetid] = 255;
    }

    if (teamid == 1)
    {
        SetPlayerTeam(playerid, 0);
        player_Leader[targetid] = 0;
        player_Team[targetid] = 0;
    }

    if (teamid == 2)
    {
        SetPlayerTeam(playerid, 1);
        player_Leader[targetid] = 1;
        player_Team[targetid] = 1;
    }

    player_Leader[playerid] = GetPlayerTeam(playerid);
    player_Team[playerid] = GetPlayerTeam(playerid);

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Leader", player_Leader[playerid]);
    INI_WriteInt(File, "Team", player_Team[playerid]);
	INI_Close(File);

    return 1;
}

YCMD:invitetoteam(playerid, params[], help) 
{
    static targetid;

    if (sscanf(params, "u", targetid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 10, -1390.0066, 2638.8303, 54.9844))
        {
            SendClientMessage(targetid, -1, ""color_server"Santorini // "color_white"You are invited to be part of Sheriff Team.");
            IsPlayerInvited[targetid] = 1;

        }
        
        if (IsPlayerInRangeOfPoint(playerid, 10, -910.9723, 2685.9023, 42.3703))
        {
            SendClientMessage(targetid, -1, ""color_server"Santorini // "color_white"You are invited to be part of LaFamilia Team.");
            IsPlayerInvited[targetid] = 1;
        }
            
    }

    return 1;
}

YCMD:jointeam(playerid, params[], help) 
{
    if (IsPlayerInvited[playerid] == 1)
    {
        if (IsPlayerInRangeOfPoint(playerid, 10, -1390.0066, 2638.8303, 54.9844))
        {
            SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are now part of Sheriff Team.");
            player_Team[playerid] = 0;

        }
        
        if (IsPlayerInRangeOfPoint(playerid, 10, -910.9723, 2685.9023, 42.3703))
        {
            SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are now part of LaFamilia Team.");
            player_Team[playerid] = 1;
        }
    }

    IsPlayerInvited[playerid] = 0;

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Team", player_Team[playerid]);
	INI_Close(File);

    return 1;
}

YCMD:leaveteam(playerid, params[], help) 
{
    SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You left your Team.");

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Team", 255);
	INI_Close(File);
    
    return 1;
}