#include <ysilib\YSI_Coding\y_hooks>

hook OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if (weaponid == WEAPON_SILENCED) 
	{
		SetPlayerPos(playerid, fX, fY, fZ);
    }

	return 1;
}