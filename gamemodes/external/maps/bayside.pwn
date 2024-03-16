#include <ysilib\YSI_Coding\y_hooks>

hook OnGameModeInit()
{
//construction
	CreateDynamicObject(3502, -2379.37866, 2383.64160, 6.06800,   0.00000, 0.00000, 193.00000);
	CreateDynamicObject(3502, -2377.60083, 2375.81372, 4.29200,   -25.00000, 33.00000, 193.00000);
	CreateDynamicObject(3502, -2375.75024, 2367.61938, 2.81200,   -178.00000, 5.00000, 193.00000);
	CreateDynamicObject(2983, -2378.06689, 2371.78369, 3.43710,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(18248, -2374.20605, 2370.46924, 11.86010,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(3864, -2384.15820, 2365.10596, 8.80750,   0.00000, 0.00000, 207.00000);
	CreateDynamicObject(3864, -2380.87109, 2390.65381, 13.80750,   0.00000, 0.00000, 113.00000);
	CreateDynamicObject(16599, -2403.30078, 2369.74780, 8.10302,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3675, -2383.66235, 2369.92212, 3.29690,   -90.00000, 90.00000, 222.00000);
	CreateDynamicObject(843, -2376.72754, 2397.39258, 7.96500,   0.00000, 0.00000, 62.00000);

	return 1;
}

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
    
    //construction
    RemoveBuildingForPlayer(playerid, 715, -2360.0469, 2372.2266, 12.1328, 0.25);

	return 1;
}