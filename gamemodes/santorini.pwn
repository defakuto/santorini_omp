/**
TODO : Score System (get and lose score, economy...)
TODO : Economy System (based on Score, get what u can have or dont can have, buy or do...)
TODO : Superpower System (pick two or three superpower u can use, driving skill, jump, speedrun, etc...)
TODO : Weather (random weather, rain, sunny, dust, etc...)
TODO : Superarea (random zones on map get change of gravity or something else, idk now, i will see...)
TODO : Gunpack (create your gunpack, just type command and select, get your guns (must pay every time))
TODO : Tunepack (create your tunepack, just type command and select tune u created for vehicle)
TODO : vcall (get vehicle from garage you want, in location near you)
TODO : Garage (buy garage to get all vehicles in use)
TODO : Airstike (buy airstrike and activate with "Satchel Explosives" or "Camera" where u activate/shoot)
TODO : Missions (create unicate missions for players to be fun...)

Critical
//! Last Position (when you been kicked on login, coordinate going to reset, also the skin...)
//! Shoot Move (when you shoot, you get teleported ((can be stuck underground or in object)(works but not the whole idea), need to find a_math or write math for that and create to move it smooth)
//! 
//!
//!
//!
//!

Progress
//? Advanced Register and Login (maybe textdraw if i find somebody to make it for free...)
//? Advanced Staff (integration with discord or something, i dont have idea...)
//? Advanced Wanted (more bribe points and more wanted points, completing arrest and economy)
//? Advanced Racewars (more checkpoints, add rockets to cars, some additional stuff like flying combo or slowing cars in radius)
//? Advanced Shoot Move (make it smooth and give amount of time how often can use it)
//?

Done
//* Simple Register and Login
//* Simple Staff
//* Simple Wanted
//* Simple Racewars
//* Simple Shoot Move
//*

*/

//? Compiler Settings
#pragma option -d3
//? Pre-Defined
#define YSI_YES_HEAP_MALLOC
#define YSI_NO_VERSION_CHECK
#define YSI_NO_MODE_CACHE
#define YSI_NO_OPTIMISATION_MESSAGE
//? Code Generation for hooks
#define CGEN_MEMORY 60000
//? Main Library
#include <open.mp>
//? YSI Library
#include <ysilib\YSI_Coding\y_hooks>
#include <ysilib\YSI_Core\y_utils.inc>
#include <ysilib\YSI_Storage\y_ini>
#include <ysilib\YSI_Coding\y_timers>
#include <ysilib\YSI_Visual\y_commands>
#include <ysilib\YSI_Data\y_foreach>
#include <ysilib\YSI_Coding\y_va>
//? Other Library
#include <sscanf2>
#include <streamer>
#include <mapfix>
#include <easyDialog>
#include <distance>

#define     color_server        "{0099ff}"
#define     color_red           "{ff1100}"
#define     color_blue          "{0099cc}"
#define     color_white         "{ffffff}"
#define     color_yellow        "{f2ff00}"
#define     color_green         "{009933}"
#define     color_pink          "{ff00bb}"
#define     color_ltblue        "{00f2ff}"
#define     color_orange        "{ffa200}"
#define     color_greey         "{787878}"

static stock const USER_PATH[64] = "/Users/%s.ini";

const MAX_PASSWORD_LENGTH = 64;
const MIN_PASSWORD_LENGTH = 6;
const MAX_LOGIN_ATTEMPTS = 	3;
const MAX_NAME_LENGTH = 20;

enum
{
	e_SPAWN_TYPE_REGISTER = 1,
    e_SPAWN_TYPE_LOGIN
};

const MAX_CHECKPOINTS = 6;

static  
    player_Password[MAX_PLAYERS][MAX_PASSWORD_LENGTH],
    player_Sex[MAX_PLAYERS][2],
    player_Score[MAX_PLAYERS],
	player_Skin[MAX_PLAYERS],
    player_Money[MAX_PLAYERS],
    player_Ages[MAX_PLAYERS],
    player_LoginAttempts[MAX_PLAYERS],
	player_Staff[MAX_PLAYERS],
	player_Wanted[MAX_PLAYERS];

//? PlayerLastPosition
new 
    Float:player_PosX[MAX_PLAYERS],
    Float:player_PosY[MAX_PLAYERS],
    Float:player_PosZ[MAX_PLAYERS];

new stfveh[MAX_PLAYERS] = { INVALID_VEHICLE_ID, ... };

forward Account_Load(const playerid, const string: name[], const string: value[]);
public Account_Load(const playerid, const string: name[], const string: value[])
{
	INI_String("Password", player_Password[playerid]);
	INI_String("Sex", player_Sex[playerid]);
	INI_Int("Level", player_Score[playerid]);
	INI_Int("Skin", player_Skin[playerid]);
	INI_Int("Money", player_Money[playerid]);
	INI_Int("Staff", player_Staff[playerid]);
	INI_Int("Wanted", player_Wanted[playerid]);
	INI_Float("positionX", player_PosX[playerid]);
	INI_Float("positionY", player_PosY[playerid]);
	INI_Float("positionZ", player_PosZ[playerid]);

	return 1;
}

new Float:camera_Locations[][3] = {

    {-2204.0217,-2309.4954,31.3750  }, //
    { -2169.8269,-2319.3391,30.6325 }, //
    { -2165.7629,-2416.6877,30.8280 }  //
};

new 
	Float:checkpoints[MAX_CHECKPOINTS][3],
	Float:player_checkpoints[MAX_PLAYERS][3];

new
	actor_Bribe;

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//? Gamemode Load
main()
{
    print("-                                     -");
	print(" Founder : defakuto");
	print(" Version : 0.0.1");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Santorini Gamemode Started");
    print("-                                     -");
}

public OnGameModeInit()
{
	//? racewars checkpoints
	AddCheckpoint(-797.1331, 1437.6632, 13.4590);
    AddCheckpoint(-691.6770, 2063.8733, 60.0516);
    AddCheckpoint(-2087.2461, 2315.1165, 25.9141);
    AddCheckpoint(-1111.9960, 2699.2837, 45.5422);
    AddCheckpoint(-1296.5348, 2497.5652, 86.6384);
    AddCheckpoint(-1067.0332, 2196.3735, 87.4105);

	//?
	actor_Bribe = CreateActor(266, -1370.4532, 2052.9966, 52.5156, 106.4529);

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, false);
	SetPlayerColor(playerid, -1);

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

	stfveh[playerid] = INVALID_VEHICLE_ID;

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	GetPlayerPos(playerid, player_PosX[playerid], player_PosY[playerid], player_PosZ[playerid]);

	new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag(File,"data");
    INI_WriteInt(File, "Level",GetPlayerScore(playerid));
    INI_WriteInt(File, "Skin",GetPlayerSkin(playerid));
    INI_WriteInt(File, "Money", GetPlayerMoney(playerid));
	INI_WriteInt(File, "Staff", player_Staff[playerid]);
    INI_WriteInt(File, "Wanted", player_Wanted[playerid]);
	INI_WriteFloat(File, "positionX", player_PosX[playerid]);
    INI_WriteFloat(File, "positionY", player_PosY[playerid]);
    INI_WriteFloat(File, "positionZ", player_PosZ[playerid]);
    INI_Close(File);

	DestroyVehicle(stfveh[playerid]);
	stfveh[playerid] = INVALID_PLAYER_ID;

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);

	if(player_Wanted[playerid] != 0) 
	{
	    SetPlayerWantedLevel(playerid, player_Wanted[playerid]);
        PlayCrimeReportForPlayer(playerid, 0, 16);
	}

	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	DestroyVehicle(stfveh[playerid]);
	stfveh[playerid] = INVALID_PLAYER_ID;

	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
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

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}
public OnPlayerUpdate(playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 1.0, -1370.4532, 2052.9966, 52.5156))
	{
		ApplyActorAnimation(actor_Bribe, "ped", "IDLE_chat", 4.1, false, false, false, false, 0);
		SendClientMessage(playerid, -1, "Shh. - if you want to get your wanted record free, get me $5000.");
	}

	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
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

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
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

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
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

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (weaponid == WEAPON_SILENCED) 
	{
		SetPlayerPos(playerid, fX, fY, fZ);
    }

	return 1;
}

public OnScriptCash(playerid, amount, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
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
	INI_WriteInt(File, "Staff", 0);
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

//? Custom Functions

Account_Path(const playerid)
{
	new tmp_fmt[64];
	format(tmp_fmt, sizeof(tmp_fmt), USER_PATH, ReturnPlayerName(playerid));

	return tmp_fmt;
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

AddCheckpoint(Float:x, Float:y, Float:z)
{
    for (new i = 0; i < MAX_CHECKPOINTS; i++)
    {
        if (checkpoints[i][0] == 0.0 && checkpoints[i][1] == 0.0 && checkpoints[i][2] == 0.0)
        {
            checkpoints[i][0] = x;
            checkpoints[i][1] = y;
            checkpoints[i][2] = z;
            break;
        }
    }
}

GetRandomCheckpoint(playerid)
{
    new random_checkpoint = random(MAX_CHECKPOINTS);
    player_checkpoints[playerid][0] = checkpoints[random_checkpoint][0];
    player_checkpoints[playerid][1] = checkpoints[random_checkpoint][1];
    player_checkpoints[playerid][2] = checkpoints[random_checkpoint][2];
}

StartRace(player1, player2)
{
    SetPlayerCheckpoint(player1, player_checkpoints[player1][0], player_checkpoints[player1][1], player_checkpoints[player1][2], 5.0);
    SetPlayerCheckpoint(player2, player_checkpoints[player1][0], player_checkpoints[player1][1], player_checkpoints[player1][2], 5.0);

    return 1;
}

//? Commands

YCMD:help(playerid, params[], help)
{
	if (help)
	{
		SendClientMessage(playerid, -1, "Use `/help <command>` to get information about the command.");
	}
	else if (IsNull(params))
	{
		SendClientMessage(playerid, -1, "Please enter a command.");
	}
	else
	{
		Command_ReProcess(playerid, params, true);
	}
	return 1;
}


YCMD:staffcmd(playerid, const string: params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command show you all staff commands.");
        return 1;
    }

	if(!player_Staff[playerid])
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	Dialog_Show(playerid, "dialog_staffcmd", DIALOG_STYLE_MSGBOX,
	""color_server"Santorini // "color_white"Staff Commands",
	""color_white"%s, Vi ste deo naseg "color_server"staff "color_white"tima!\n\
	"color_server"SLVL1 >> "color_white"/sduty\n\
	"color_server"SLVL1 >> "color_white"/sc\n\
	"color_server"SLVL1 >> "color_white"/staffcmd\n\
	"color_server"SLVL1 >> "color_white"/sveh\n\
	"color_server"SLVL1 >> "color_white"/goto\n\
	"color_server"SLVL1 >> "color_white"/cc\n\
	"color_server"SLVL1 >> "color_white"/fv\n\
	"color_server"SLVL2 >> "color_white"/gethere\n\
	"color_server"SLVL3 >> "color_white"/nitro\n\
	"color_server"SLVL4 >> "color_white"/jetpack\n\
	"color_server"SLVL4 >> "color_white"/setskin\n\
	"color_server"SLVL4 >> "color_white"/xgoto\n\
	"color_server"SLVL4 >> "color_white"/spanel\n\
	"color_server"SLVL4 >> "color_white"/setstaff",
	"OK", "", ReturnPlayerName(playerid)
	);

    return 1;
}

YCMD:sc(playerid, const string: params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This is command for Staff Chat.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	if (isnull(params))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/sc [text]");

	static tmp_str[128];

	format(tmp_str, sizeof(tmp_str), "Staff - %s(%d): "color_white"%s", ReturnPlayerName(playerid), playerid, params);

	foreach (new i: Player)
		if (player_Staff[i])
			SendClientMessage(i, -1, tmp_str);
	
    return 1;
}

YCMD:sveh(playerid, params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command create your staff vehicle.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	if (stfveh[playerid] == INVALID_VEHICLE_ID) 
	{
		if (isnull(params))
			return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/sveh [Model ID]");

		new modelid = strval(params);

		if (400 > modelid > 611)
			return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"* Valid models from 400 to 611.");

		new vehicleid = stfveh[playerid] = CreateVehicle(modelid, x, y, z, 0.0, 1, 0, -1);

		SetVehicleNumberPlate(vehicleid, "STAFF");
		PutPlayerInVehicle(playerid, vehicleid, 0);
		
	    new bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:objective;
	    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

	    if (IsVehicleBicycle(GetVehicleModel(vehicleid)))
	    {
	        SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
	    }
	    else
	    {
	        SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, doors, bonnet, boot, objective);
	    }
		SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You created a vehicle, to destroy type '/sveh'.");
	}
	else 
	{
		DestroyVehicle(stfveh[playerid]);
		stfveh[playerid] = INVALID_PLAYER_ID;
		SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You destroy a vehicle, to create type '/veh [Model ID]'.");
	}
	
    return 1;
}

YCMD:goto(playerid, params[],help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command allow you teleport to player.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	new giveplayerid, giveplayer[MAX_PLAYER_NAME];

	new Float:plx,Float:ply,Float:plz;

	GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));

	if(!sscanf(params, "u", giveplayerid))
	{	
		GetPlayerPos(giveplayerid, plx, ply, plz);
			
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new tmpcar = GetPlayerVehicleID(playerid);
			SetVehiclePos(tmpcar, plx, ply+4, plz);
		}
		else
		{
			SetPlayerPos(playerid,plx,ply+2, plz);
		}
		SetPlayerInterior(playerid, GetPlayerInterior(giveplayerid));
	}
    return 1;
}

YCMD:cc(playerid, params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command will clear chat to all.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	for(new cc; cc < 110; cc++)
	{
		SendClientMessageToAll(-1, "");
	}

	if(player_Staff[playerid] < 1)
	{
		static fmt_string[120];
		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"chat is cleared by"color_server" %s", ReturnPlayerName(playerid));
		SendClientMessageToAll(-1, fmt_string);
	}
    return 1;
}

YCMD:fv(playerid, params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command fix your vehicle.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	new vehicleid = GetPlayerVehicleID(playerid);

	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You are not in vehicle!");

	RepairVehicle(vehicleid);

	SetVehicleHealth(vehicleid, 999.0);

	return 1;
}

YCMD:gethere(playerid, const params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command teleport player to you.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	new targetid = INVALID_PLAYER_ID;

	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/gethere [id]");

	if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"That ID is not connected.");

	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	SetPlayerPos(targetid, x+1, y, z+1);

	SetPlayerInterior(targetid, GetPlayerInterior(playerid));

	SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));

	new name[MAX_PLAYER_NAME];
	GetPlayerName(targetid, name, sizeof(name));

	static fmt_string[60];

	format(fmt_string, sizeof(fmt_string),""color_server"Santorini // "color_white"You teleported player %s to you.", name);
	SendClientMessage(playerid, -1, fmt_string);

	GetPlayerName(playerid, name, sizeof(name));

	format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"Staff %s teleported you to him.", name);
	SendClientMessage(targetid, -1, fmt_string);

    return 1;
}

YCMD:nitro(playerid, params[], help)
{
	if(help)
    {
		SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command give you a nitro.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);

	SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You put nitro in your vehicle.");

	return 1;
}

YCMD:jetpack(playerid, params[], help)
{
	if(help)
    {
		SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command give you jetpack.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);

	SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You take a jetpack.");

	return 1;
}

YCMD:setskin(playerid, const string: params[], help)
{
	if(help)
    {
		SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command allow you to put skin from 1 to 311.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	static
		targetid,
		skinid;

	if (sscanf(params, "ri", targetid, skinid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/setskin [targetid] [skinid]");

	if (!(1 <= skinid <= 311))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"Wrong skinid!");

	if (GetPlayerSkin(targetid) == skinid)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"Player have that skinid!");

	SetPlayerSkin(targetid, skinid);

	player_Skin[targetid] = skinid;

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Skin", GetPlayerSkin(playerid));
	INI_Close( File );

    return 1;
}

YCMD:xgoto(playerid, params[], help)
{
	if(help)
    {
		SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"This command teleport you to coordinate.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	new Float:x, Float:y, Float:z;

	static fmt_string[100];

	if (sscanf(params, "fff", x, y, z)) SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"xgoto <X Float> <Y Float> <Z Float>");
	else
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    SetVehiclePos(GetPlayerVehicleID(playerid), x,y,z);
		}
		else
		{
		    SetPlayerPos(playerid, x, y, z);
		}
		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"You set coordinate to %f, %f, %f", x, y, z);
		SendClientMessage(playerid, -1, fmt_string);
	}
 	return 1;
}

YCMD:setstaff(playerid, const string: params[], help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"0 - Revoke Staff | 1. Assistent | 2. Admin | 3. Manager | 4. High Command.");
        return 1;
    }

	if(!IsPlayerAdmin(playerid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"You Must Be RCON!");

	static
		targetid,
		level;

	if (sscanf(params, "ri", targetid, level))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/setstaff [targetid] [0/1]");

	if (!level && !player_Staff[targetid])
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"That player is not a part of Staff Team.");

	if (level == player_Staff[targetid])
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"That player is alredy part of Staff Team.");

	player_Staff[targetid] = level;
	
	if (!level)
	{
		static fmt_string[128];

		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"%s demote you from Staff Team.", ReturnPlayerName(playerid));
		SendClientMessage(targetid, -1, fmt_string);

		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"Izbacili ste %s iz staff-a.", ReturnPlayerName(targetid));
		SendClientMessage(playerid, -1, fmt_string);
	}
	else if(level < 0 || level > 4) return SendClientMessage(playerid, -1, ""color_white"Santorini // "color_white"Please use "color_blue"-/help setstaff- "color_white"to see all staff levels.");
	{
		static fmt_string[128];

		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"%s promote you to Staff Team.", ReturnPlayerName(playerid));
		SendClientMessage(targetid, -1, fmt_string);

		format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"You promoted %s to Staff Team.", ReturnPlayerName(targetid));
		SendClientMessage(playerid, -1, fmt_string);
	}

    new INI:File = INI_Open(Account_Path(playerid));
	INI_SetTag( File, "data" );
    INI_WriteInt(File, "Staff", player_Staff[playerid]);
	INI_Close( File );
	
    return 1;
}

YCMD:kick(playerid, params[],help)
{
	if(help)
    {
        SendClientMessage(playerid, -1, ""color_yellow"HELP >> "color_white"The command allow you to kick player from server.");
        return 1;
    }

	if (player_Staff[playerid] < 1)
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_red"Only Staff Team!");

	static 
		targetid;

	if (sscanf(params, "ri", targetid))
		return SendClientMessage(playerid, -1, ""color_server"Santorini // "color_white"/kick [targetid]");

	static fmt_string[128];

	format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"%s kick you from the server.", ReturnPlayerName(playerid));
	SendClientMessage(targetid, -1, fmt_string);

	format(fmt_string, sizeof(fmt_string), ""color_server"Santorini // "color_white"You kick %s from server.", ReturnPlayerName(targetid));
	SendClientMessage(playerid, -1, fmt_string);

	SetTimerEx("DelayedKick", 1000, false, "i", targetid);

    return 1;
}

YCMD:racewar(playerid, const string: params[], help)
{
    static 
        racerid;

    if (sscanf(params, "u", racerid))
        return SendClientMessage(playerid, -1, "Usage: /race [racerid]");

    GetRandomCheckpoint(playerid);

    static fmt_string[100];

    if (IsPlayerConnected(racerid))
    {
        format(fmt_string, sizeof(fmt_string), "Race started with player %d", racerid);
        SendClientMessage(playerid, -1, fmt_string);

        StartRace(playerid, racerid);
    }
    else
    {
        format(fmt_string, sizeof(fmt_string), "Player %d is not connected.", racerid);
        SendClientMessage(playerid, -1, fmt_string);
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

//? additional

forward DelayedKick(targetid);
public DelayedKick(targetid)
{
    Kick(targetid);
    return 1;
}

//? testcmd

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

YCMD:restart(playerid, const string: params[], help)
{
	GetPlayerPos(playerid, player_PosX[playerid], player_PosY[playerid], player_PosZ[playerid]);

	new INI:File = INI_Open(Account_Path(playerid));
    INI_SetTag(File,"data");
	INI_WriteFloat(File, "positionX", player_PosX[playerid]);
    INI_WriteFloat(File, "positionY", player_PosY[playerid]);
    INI_WriteFloat(File, "positionZ", player_PosZ[playerid]);
    INI_Close(File);

	SendRconCommand("gmx 1");
    return 1;
}

