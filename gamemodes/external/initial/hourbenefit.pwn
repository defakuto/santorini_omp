#include <ysilib\YSI_Coding\y_hooks>

static  
    player_Score[MAX_PLAYERS],
    player_Money[MAX_PLAYERS];

hook Account_Load(playerid, const string: name[], const string: value[])
{
	INI_Int("Score", player_Score[playerid]);
	INI_Int("Money", player_Money[playerid]);

	return 1;
}

hook OnGameModeInit()
{
	SetTimer("HourBenefit", 3600000, true);

	return 1;
}

forward HourBenefit(playerid);
public HourBenefit(playerid)
{
    SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You get hour bonus $500 and 1 score!");

    SetPlayerScore(playerid, 1);
    GivePlayerMoney(playerid, 500);

	new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag( File, "data" );
    INI_WriteInt(File, "Score", player_Score[playerid]);
    INI_WriteInt(File, "Money", GetPlayerMoney(playerid));
    INI_Close(File);

    return 1;
}