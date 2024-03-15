#include <ysilib\YSI_Coding\y_hooks>

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

hook OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, false);
	SetPlayerColor(playerid, -1);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, NO_TEAM);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

