#include <ysilib\YSI_Coding\y_hooks>

static player_Team[MAX_PLAYERS];

enum
{
    TEAM_SHERIFF = 1,
    TEAM_LAFAMILIA
};

hook Account_Load(playerid, const string: name[], const string: value[])
{
	INI_Int("Team", player_Team[playerid]);

	return 1;
}

YCMD:jointeam(playerid, params[],help)
{
	if (help)
        return SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"The command allow you to kick player from server.");

    if (GetPlayerTeam(playerid) == NO_TEAM)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -1390.0123,2638.8311,55.9844))
        {
            SetPlayerTeam(playerid, TEAM_SHERIFF)
        }
        else if (IsPlayerInRangeOfPoint(playerid, 1.0, -1390.0123,2638.8311,55.9844))
        {
            
        }
    }

    if (GetPlayerTeam(playerid) == TEAM_SHERIFF)
    {

    }

        return SendClientMessage(playerid, -1, "You are a member of LaFamilia Mafia.")
    
    if (GetPlayerTeam(playerid) == TEAM_LAFAMILIA)


        return SendClientMessage(playerid, -1, "You are a memeber of Sheriff Department.")
	


    return 1;
}