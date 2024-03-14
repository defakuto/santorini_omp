#include <ysilib\YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid)
{
    // Garage Trash
    RemoveBuildingForPlayer(playerid, 1227, -2527.2422, 2353.1250, 4.7578, 0.25); 
    RemoveBuildingForPlayer(playerid, 1227, -2520.7188, 2353.1250, 4.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, -2524.0625, 2353.1250, 4.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 9314, -2493.8594, 2363.4297, 14.8750, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, -2503.0703, 2364.2188, 4.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 1227, -2503.0469, 2368.0469, 4.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 1440, -2506.6953, 2369.6641, 4.3906, 0.25);
    RemoveBuildingForPlayer(playerid, 1440, -2503.3125, 2341.3672, 4.4531, 0.25);

    return 1;
}