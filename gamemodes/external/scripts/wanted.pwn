#include <ysilib\YSI_Coding\y_hooks>

static  
	player_Wanted[MAX_PLAYERS];

new Float:camera_Locations[][3] = {

    {-2204.0217,-2309.4954,31.3750  },
    { -2169.8269,-2319.3391,30.6325 }, 
    { -2165.7629,-2416.6877,30.8280 }  
};

new
	actor_Bribe;

hook OnGameModeInit()
{
	actor_Bribe = CreateActor(266, -1370.4532, 2052.9966, 52.5156, 106.4529);

	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(player_Wanted[playerid] != 0) 
	{
	    SetPlayerWantedLevel(playerid, player_Wanted[playerid]);
        PlayCrimeReportForPlayer(playerid, 0, 16);
	}

	return 1;
}

hook OnPlayerUpdate(playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 1.0, -1370.4532, 2052.9966, 52.5156))
	{
		ApplyActorAnimation(actor_Bribe, "ped", "IDLE_chat", 4.1, false, false, false, false, 0);
		SendClientMessage(playerid, -1, "Shh. - if you want to get your wanted record free, get me $5000.");
	}

	return 1;
}

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID && bodypart == 9)
    {
        SetPlayerHealth(playerid, 0.0);
    }

	if(player_Wanted[issuerid] == 6) return 1;
    for(new i = 0; i < sizeof camera_Locations; i++) 
	{
        if(IsPlayerInRangeOfPoint(issuerid, 40.0, camera_Locations[i][0], camera_Locations[i][1], camera_Locations[i][2])) 
		{
            player_Wanted[issuerid]++;
            SetPlayerWantedLevel(issuerid, player_Wanted[issuerid]);
            PlayCrimeReportForPlayer(issuerid, 0, 16);

            new INI:File = INI_Open(Account_Path(issuerid));
            INI_SetTag(File,"data");
            INI_WriteInt(File, "Wanted", player_Wanted[issuerid]);
            INI_Close(File);

            break;
        }
    }

	return 1;
}


YCMD:bribe(playerid, const string: params[], help)
{
	if (IsPlayerInRangeOfPoint(playerid, 5.0, -1370.4532, 2052.9966, 52.5156))
	{
		SetPlayerWantedLevel(playerid, 0);
		ApplyAnimation(playerid, "DEALER", "shop_pay", 4.1, false, false, false, false, 1);
		ClearActorAnimations(actor_Bribe);
		SendClientMessage(playerid, -1, "You give $5000 to your wanted record be stored.");
	}

	player_Wanted[playerid] = 0;

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