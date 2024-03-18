#include <ysilib\YSI_Coding\y_hooks>

static
    player_Leader[MAX_PLAYERS],
    player_Team[MAX_PLAYERS];

new IsPlayerInvited[MAX_PLAYERS];

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

    AddStaticPickup(19197, 0, -910.9723, 2685.9023, 41.3703, 0); //lafamilia enter
    AddStaticPickup(19197, 0, 2365.2339, -1135.5983, 1049.8826, 0); //lafamilia exit

    Create3DTextLabel("If you want to enter press "color_server"'N'", -1, -1390.0066, 2638.8303, 55.9844, 5.0, 0, true); //sheriff enter
    Create3DTextLabel("If you want to exit press "color_server"'N'", -1, 246.8432, 63.0917, 1003.6406, 5.0, 0, true); //sheriff exit

    Create3DTextLabel("If you want to enter press "color_server"'N'", -1, -910.9723, 2685.9023, 42.3703, 5.0, 0, true); //lafamilia enter
    Create3DTextLabel("If you want to exit press "color_server"'N'", -1, 2365.2339, -1135.5983, 1050.8826, 5.0, 0, true); //lafamilia exit

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
    return 1;
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

    if (IsPlayerInRangeOfPoint(playerid, 10, -1390.0066, 2638.8303, 54.9844))
    {
        SendClientMessage(targetid, -1, ""color_server"Santorini // "color_white"You are invited to be part of Sheriff Team.");
        player_Team[targetid] = 0;

    }
    else if (IsPlayerInRangeOfPoint(playerid, 10, -910.9723, 2685.9023, 42.3703))
    {
        SendClientMessage(targetid, -1, ""color_server"Santorini // "color_white"You are invited to be part of LaFamilia Team.");
        player_Team[targetid] = 1;
    }

    IsPlayerInvited[playerid] = 1;

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
        else if (IsPlayerInRangeOfPoint(playerid, 10, -910.9723, 2685.9023, 42.3703))
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