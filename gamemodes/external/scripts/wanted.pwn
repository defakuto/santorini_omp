#include <ysilib\YSI_Coding\y_hooks>

static  
	player_Wanted[MAX_PLAYERS],
	PlayerInRange[MAX_PLAYERS];

new Float:camera_Locations[][7] = {

    {-1516.1118,2534.7170,55.6875}, //medical camera
    {-1407.9493,2638.5881,55.6875}, //sheriff camera
	{-2263.8115,2324.1563,4.8125}, //bayside heli parking camera
    {-2516.8274,2361.1323,4.9856}, //main garage camera
	{-2465.6968,2236.4619,4.7969}, //bayside second parking camera
    {-1507.3467,1963.1437,48.4171}, //weedhouse camera
    {-828.1052,1504.5996,19.8530}  //bank camera
};

new
	actor_Bribe;

hook OnGameModeInit()
{
	actor_Bribe = CreateActor(217, -1370.4532, 2052.9966, 52.5156, 106.4529);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
	if (player_Wanted[playerid] != 0) 
	{
	    SetPlayerWantedLevel(playerid, player_Wanted[playerid]);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerUpdate(playerid)
{
 	if (!PlayerInRange[playerid] && IsPlayerInRangeOfPoint(playerid, 1.0, -1370.4532, 2052.9966, 52.5156))
    {
        PlayerInRange[playerid] = 1;
        
        ApplyActorAnimation(actor_Bribe, "ped", "IDLE_chat", 4.1, false, false, false, false, 0);
        SendClientMessage(playerid, -1, "Shh. - if you want to get your wanted record free, get me $5000. "color_yellow"/bribe");
    }

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	if (issuerid != INVALID_PLAYER_ID && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0.0);
    }

	if (player_Wanted[issuerid] == 6) return Y_HOOKS_CONTINUE_RETURN_1;
    for(new i = 0; i < sizeof camera_Locations; i++) 
	{
        if (IsPlayerInRangeOfPoint(issuerid, 40.0, camera_Locations[i][0], camera_Locations[i][1], camera_Locations[i][2])) 
		{
            player_Wanted[issuerid]++;
            SetPlayerWantedLevel(issuerid, player_Wanted[issuerid]);

            new INI:File = INI_Open(Account_Path(issuerid));
            INI_SetTag(File,"data");
            INI_WriteInt(File, "Wanted", player_Wanted[issuerid]);
            INI_Close(File);

            break;
        }
    }

	return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:bribe(playerid, const string: params[], help)
{
	if (IsPlayerInRangeOfPoint(playerid, 5.0, -1370.4532, 2052.9966, 52.5156))
	{
		if (player_Wanted[playerid] == 0)
		{
			SendClientMessage(playerid, -1, "You are in wrong place, pal.");
		}
		else
		{
			SetPlayerWantedLevel(playerid, 0);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 1);
			ClearActorAnimations(actor_Bribe);
			SendClientMessage(playerid, -1, "You give $5000, your wanted record is stored.");

			player_Wanted[playerid] = 0;
		}
	}

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag(File,"data");
    INI_WriteInt(File, "Wanted", player_Wanted[playerid]);
    INI_Close(File);

	return 1;
}

YCMD:clearwl(playerid, const string: params[], help)
{
	SetPlayerWantedLevel(playerid, 0);

	player_Wanted[playerid] = 0;

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag(File,"data");
    INI_WriteInt(File, "Wanted", player_Wanted[playerid]);
    INI_Close(File);

	return 1;
}