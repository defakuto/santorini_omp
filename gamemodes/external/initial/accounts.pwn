#include <ysilib\YSI_Coding\y_hooks>

static stock const USER_PATH[64] = "/Users/%s.ini";

const MAX_PASSWORD_LENGTH = 64;
const MIN_PASSWORD_LENGTH = 6;
const MAX_LOGIN_ATTEMPTS = 	3;

enum
{
	e_SPAWN_TYPE_REGISTER = 1,
    e_SPAWN_TYPE_LOGIN
};

static  
    player_Password[MAX_PLAYERS][MAX_PASSWORD_LENGTH],
    player_Sex[MAX_PLAYERS][2],
    player_Score[MAX_PLAYERS],
	player_Skin[MAX_PLAYERS],
    player_Money[MAX_PLAYERS],
    player_Ages[MAX_PLAYERS],
    player_LoginAttempts[MAX_PLAYERS];

new 
    Float:player_PosX[MAX_PLAYERS],
    Float:player_PosY[MAX_PLAYERS],
    Float:player_PosZ[MAX_PLAYERS];

hook Account_Load(playerid, const string: name[], const string: value[])
{
    INI_String("Password", player_Password[playerid]);
	INI_String("Sex", player_Sex[playerid]);
	INI_Int("Level", player_Score[playerid]);
	INI_Int("Skin", player_Skin[playerid]);
	INI_Int("Money", player_Money[playerid]);
	INI_Float("positionX", player_PosX[playerid]);
	INI_Float("positionY", player_PosY[playerid]);
	INI_Float("positionZ", player_PosZ[playerid]);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	if (fexist(Account_Path(playerid)))
	{
		INI_ParseFile(Account_Path(playerid), "Account_Load", true, true, playerid);
		Dialog_Show(playerid, "dialog_login", DIALOG_STYLE_PASSWORD,
			"Login",
			"%s, type your password: ",
			"Ok", "Exit", ReturnPlayerName(playerid)
		);

		return 1;
	}

	Dialog_Show(playerid, "dialog_regpassword", DIALOG_STYLE_INPUT,
		"Register",
		"%s, type your password: ",
		"Ok", "Exit", ReturnPlayerName(playerid)
	);

	SetPlayerPos(playerid, player_PosX[playerid], player_PosY[playerid], player_PosZ[playerid]);

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	GetPlayerPos(playerid, player_PosX[playerid], player_PosY[playerid], player_PosZ[playerid]);

	new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File, "Level",GetPlayerScore(playerid));
    INI_WriteInt(File, "Skin",GetPlayerSkin(playerid));
    INI_WriteInt(File, "Money", GetPlayerMoney(playerid));
	INI_WriteFloat(File, "positionX", player_PosX[playerid]);
    INI_WriteFloat(File, "positionY", player_PosY[playerid]);
    INI_WriteFloat(File, "positionZ", player_PosZ[playerid]);
    INI_Close(File);

	return 1;
}

timer Spawn_Player[100](playerid, type)
{
	if (type == e_SPAWN_TYPE_REGISTER)
		{
			SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"Welcome to the server!");
			SetSpawnInfo(playerid, NO_TEAM, player_Skin[playerid],
				-2117.0735, 2596.7383, 905.1039, 292.1759,
				WEAPON_PARACHUTE, 10, WEAPON_SILENCED, 10, 	WEAPON_TEARGAS, 10
			);
			SpawnPlayer(playerid);

			SetPlayerScore(playerid, player_Score[playerid]);
			GivePlayerMoney(playerid, player_Money[playerid]);
			SetPlayerSkin(playerid, player_Skin[playerid]);
		}

		else if (type == e_SPAWN_TYPE_LOGIN)
		{
			SendClientMessage(playerid, -1,""color_server"Santorini // "color_white"Welcome to the server!");
			SetSpawnInfo(playerid, 0, player_Skin[playerid],
				player_PosX[playerid], player_PosY[playerid], player_PosZ[playerid], 0,
				WEAPON_PARACHUTE, 10, WEAPON_SILENCED, 10, 	WEAPON_TEARGAS, 10
			);
			SpawnPlayer(playerid);

			SetPlayerScore(playerid, player_Score[playerid]);
			GivePlayerMoney(playerid, player_Money[playerid]);
			SetPlayerSkin(playerid, player_Skin[playerid]);
		}

}

Dialog: dialog_regpassword(playerid, response, listitem, string: inputtext[])
{
	if (!response)
		return Kick(playerid);

	Dialog_Show(playerid, "dialog_regpassword", DIALOG_STYLE_INPUT,
			"Register",
			"%s, type your password: ",
			"Ok", "Exit", ReturnPlayerName(playerid)
		);

	strcopy(player_Password[playerid], inputtext);

	Dialog_Show(playerid, "dialog_regages", DIALOG_STYLE_INPUT,
		"Age",
		"What is your age: ",
		"Ok", "Exit"
	);

	return 1;
}

Dialog: dialog_regages(const playerid, response, listitem, string: inputtext[])
{
	if (!response)
		return Kick(playerid);

	if (!(12 <= strval(inputtext) <= 50))
		return Dialog_Show(playerid, "dialog_regages", DIALOG_STYLE_INPUT,
			"Age",
			"What is your age: ",
			"Ok", "Exit"
		);

	player_Ages[playerid] = strval(inputtext);

	Dialog_Show(playerid, "dialog_regsex", DIALOG_STYLE_LIST,
	"Gender",
	"Male\nFemale",
	"Ok", "Exit"
	);

	return 1;
}

Dialog: dialog_regsex(const playerid, response, listitem, string: inputtext[])
{
	if (!response)
		return Kick(playerid);

	new tmp_int = listitem + 1;

	new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag(File,"data");
	INI_WriteString(File, "Password", player_Password[playerid]);
	INI_WriteString(File, "Sex", (tmp_int == 1 ? ("Male") : ("Female")));
	INI_WriteInt(File, "Age", player_Ages[playerid]);
	INI_WriteInt(File, "Level", 0);
	INI_WriteInt(File, "Skin", 240);
	INI_WriteInt(File, "Money", 1000);
	INI_Close(File);

	player_Money[playerid] = 1000;
	player_Skin[playerid] = 240;
	player_Score[playerid] = 0;

	defer Spawn_Player(playerid, 1);
	
	return 1;
}

Dialog: dialog_login(const playerid, response, listitem, string: inputtext[])
{
	if (!response)
		return Kick(playerid);

	if (!strcmp(player_Password[playerid], inputtext, false))
		defer Spawn_Player(playerid, 2);
	else
	{
		if (player_LoginAttempts[playerid] == MAX_LOGIN_ATTEMPTS)
			return Kick(playerid);

		++player_LoginAttempts[playerid];
		Dialog_Show(playerid, "dialog_login", DIALOG_STYLE_PASSWORD,
			"Login",
			"%s, wrong password, try again: ",
			"Ok", "Exit", ReturnPlayerName(playerid)
		);
	}

	return 1;
}

Account_Path(const playerid)
{
	new tmp_fmt[64];
	format(tmp_fmt, sizeof(tmp_fmt), USER_PATH, ReturnPlayerName(playerid));

	return tmp_fmt;
}