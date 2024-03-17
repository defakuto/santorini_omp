#include <ysilib\YSI_Coding\y_hooks>

static  player_Team[MAX_PLAYERS],
        player_TeamLeader[MAX_PLAYERS],
        player_InvitedToTeam[MAX_PLAYERS];

hook Account_Load(playerid, const string: name[], const string: value[])
{
	INI_Int("Team", player_Team[playerid]);
    INI_Int("Leader", player_TeamLeader[playerid]);
	return 1;
}

hook OnGameModeInit()
{
    AddStaticPickup(19197, 0, -1390.0066, 2638.8303, 54.9844, 0); //sheriff enter
    AddStaticPickup(19197, 0, 246.8432, 63.0917, 1002.6406, 0); //sheriff exit
    AddStaticPickup(19197, 0, 246.4005, 88.0093, 1002.6406, 0); //sheriff jointeam

    AddStaticPickup(19197, 0, -910.9723, 2685.9023, 41.3703, 0); //lafamilia enter
    AddStaticPickup(19197, 0, 2365.2339, -1135.5983, 1049.8826, 0); //lafamilia exit
    AddStaticPickup(19197, 0, 2363.7676, -1127.4271, 1049.8826, 0); //lafamilia jointeam

    Create3DTextLabel("If you want to enter press "color_server"'N'", -1, -1390.0066, 2638.8303, 55.9844, 5.0, 0, true); //sheriff enter
    Create3DTextLabel("If you want to exit press "color_server"'N'", -1, 246.8432, 63.0917, 1003.6406, 5.0, 0, true); //sheriff exit
    Create3DTextLabel("If you want to be a part of Team type "color_server"/jointeam", -1, 246.4005, 88.0093, 1003.6406, 5.0, 0, true); //sheriff jointeam

    Create3DTextLabel("If you want to enter press "color_server"'N'", -1,  -910.9723, 2685.9023, 42.3703, 5.0, 0, true); //lafamilia enter
    Create3DTextLabel("If you want to exit press "color_server"'N'", -1, 2365.2339, -1135.5983, 1050.8826, 5.0, 0, true); //lafamilia exit
    Create3DTextLabel("If you want to be a part of Team type "color_server"/jointeam", -1, 2363.7676, -1127.4271, 1050.8826, 5.0, 0, true); //lafamilia jointeam

    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Team", player_Team[playerid]);
    INI_WriteInt(File, "Leader", player_TeamLeader[playerid]);
    INI_Close(File);

	return 1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if (newkeys & KEY_NO)
        {
            if (player_InvitedToTeam[playerid] == 1)
            {
                //sheriff
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
            else if (player_InvitedToTeam[playerid] == 2)
            {
                if (IsPlayerInRangeOfPoint(playerid, 1.0, -910.9723, 2685.9023, 42.3703))
                {
                    SetPlayerInterior(playerid, 8);
                    SetPlayerPos(playerid, 2365.2146, -1135.5959, 1050.8826);
                }
                if (IsPlayerInRangeOfPoint(playerid, 1.0, 2365.2146, -1135.5959, 1050.8826))
                {
                    SetPlayerInterior(playerid, 0);
                    SetPlayerPos(playerid, -910.9723, 2685.9023, 42.3703);
                }
            }

            if (player_Team[playerid] == 255 || player_Team[playerid] == 1)
            {
                SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are not allowed to enter here.");
            }
            else
            {
                //sheriff
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

            if (player_Team[playerid] == 255 || player_Team[playerid] == 0)
            {
                SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are not allowed to enter here.");
            }
            else
            {
                if (IsPlayerInRangeOfPoint(playerid, 1.0, -910.9723, 2685.9023, 42.3703))
                {
                    SetPlayerInterior(playerid, 8);
                    SetPlayerPos(playerid, 2365.2146, -1135.5959, 1050.8826);
                }
                if (IsPlayerInRangeOfPoint(playerid, 1.0, 2365.2146, -1135.5959, 1050.8826))
                {
                    SetPlayerInterior(playerid, 0);
                    SetPlayerPos(playerid, -910.9723, 2685.9023, 42.3703);
                }
            }
        }   
    }
    return 1;
}

YCMD:setleader(playerid, params[],help)
{  
    if (help)
        return SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_server"0 - Revoke Leader | 1. Sheriff | 2. LaFamilia");

	if (!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You Must Be RCON!");

    static
		targetid,
		level;

	if (sscanf(params, "ri", targetid, level))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/setleader [targetid] [0/2]");

	if (!level && !player_TeamLeader[targetid])
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"That player is not a part of "color_server"Leader Team.");

	if (level == player_TeamLeader[targetid])
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"That player is alredy part of "color_server"Leader Team.");

	player_TeamLeader[targetid] = level;
	
	if (!level)
	{
		SendClientMessage(targetid, -1, ""color_server"Santorini // "color_server"%s "color_white"demote you from Leader Team.", ReturnPlayerName(playerid));

		SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You demote "color_server"%s "color_white"from Leader Team.", ReturnPlayerName(targetid));
	}
	else if (level < 1 || level > 2) return SendClientMessage(playerid, -1, ""color_white"Santorini // "color_white"Please use "color_server"-/help setLeader- "color_white"to see all Leader levels.");
	{
        if (level == 1)
		    return SendClientMessage(targetid, -1, ""color_server"Santorini // "color_server"%s "color_white"promote you to Sheriff Leader.", ReturnPlayerName(playerid));

        if (level == 2)
		    return SendClientMessage(targetid, -1, ""color_server"Santorini // "color_server"%s "color_white"promote you to LaFamilia Leader.", ReturnPlayerName(playerid));
	}

    player_TeamLeader[playerid] = level; 
    player_Team[playerid] = level;

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Leader", player_TeamLeader[playerid]);
	INI_Close(File);
	
    return 1;
}

YCMD:invitetoteam(playerid, params[],help)
{
    if (help)
		return SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"Invite player yo HQ.");

	static
		targetid;

	if (sscanf(params, "ri", targetid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/setskin [targetid]");
    
    if (player_TeamLeader[playerid] == 1)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -1390.0066, 2638.8303, 55.9844))
        {
            player_InvitedToTeam[targetid] = 1;
        }
    }
    else if (player_TeamLeader[playerid] == 2)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -910.9723, 2685.9023, 42.3703))
        {
            player_InvitedToTeam[targetid] = 2;
        }
    }

    return 1;
}

YCMD:jointeam(playerid, params[],help)
{
	if (help)
        return SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"The command allow you to join on team.");

    if (player_Team[playerid] == 0 || player_Team[playerid] == 1)
        return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are already part of a Team.");

    if (player_Team[playerid] == 255)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 246.4005, 88.0093, 1003.6406))
        {
            SetPlayerTeam(playerid, 0);
            SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are now part of Sheriff Team.");
        }
        else if (IsPlayerInRangeOfPoint(playerid, 1.0, 2363.7676, -1127.4271, 1050.8826))
        {
            SetPlayerTeam(playerid, 1);
            SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are now a part of LaFamilia Team.");
        }
    }

    player_Team[playerid] = GetPlayerTeam(playerid);

    new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag( File, "data" );
    INI_WriteInt(File, "Team", player_Team[playerid]);
    INI_Close(File);

    return 1;
}

YCMD:leaveteam(playerid, params[],help)
{
	if (help)
        return SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"The command allow you to leave current team.");

    if (player_Team[playerid] == 0 || player_Team[playerid] == 1)    
    {
        SetPlayerTeam(playerid, 255);
        SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You leave current Team.");
    }

    player_Team[playerid] = GetPlayerTeam(playerid);

    new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag( File, "data" );
    INI_WriteInt(File, "Team", player_Team[playerid]);
    INI_Close(File);

    return 1;
}