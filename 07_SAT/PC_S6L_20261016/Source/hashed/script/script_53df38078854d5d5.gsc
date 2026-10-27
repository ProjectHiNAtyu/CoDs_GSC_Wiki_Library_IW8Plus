// script_53df38078854d5d5  (hash_53df38078854d5d5.gscc) (size: 1223 Bytes / 0x4c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x857f5c4a (2239716426)
// size ...... 1223 (0x4c7)
// includes .. 1   (offset: 0x4ab)
// strings ... 1   (offset: 0x4b3)
// dev strs .. 0   (offset: 0x4c7)
// exports ... 6   (offset: 0x263)
// cseg ...... 0x72 + 0x1f1 (0x263)
// imports ... 12  (offset: 0x353)
// animtree1 . 0   (offset: 0x4c7)
// animtree2 . 0   (offset: 0x4c7)
#using scripts\common\callbacks;

#namespace specialty_ammo_on_kill;

// Namespace specialty_ammo_on_kill
// Params 0, eflags: 0x1
// Checksum 0x1024a8ab, Offset: 0x90
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_ammo_on_kill
// Params 1
// Checksum 0x1dc88ea4, Offset: 0xb0
// Size: 0x4a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_ammo_on_kill", &function_c3ab919af19042b8 );
        level callback::add( #"on_ai_killed", &function_48ca7485cd41b9e3 );
    }
}

// Namespace specialty_ammo_on_kill
// Params 1, eflags: 0x4
// Checksum 0x1df1066a, Offset: 0x102
// Size: 0x8f
function private function_48ca7485cd41b9e3( params )
{
    if ( isplayer( params.eattacker ) && isdefined( params.eattacker.perks[ "specialty_ammo_on_kill" ] ) )
    {
        params.eattacker endon( #"death" );
        params.eattacker endon( #"hash_255a14471cab1008" );
        weaponobj = params.eattacker getcurrentweapon();
        giveextraammo( params, weaponobj );
    }
}

// Namespace specialty_ammo_on_kill
// Params 2, eflags: 0x4
// Checksum 0xc6306d48, Offset: 0x199
// Size: 0xac
function private giveextraammo( params, weaponobj )
{
    var_b11feea92c35d08e = weaponclipsize( weaponobj );
    var_83e55048826dcd05 = params.eattacker getweaponammoclip( weaponobj );
    var_15ac9e3e7f01d917 = level.perkbundles[ "specialty_ammo_on_kill" ].ammoonkill;
    amount_ammo_give = var_b11feea92c35d08e * var_15ac9e3e7f01d917;
    current_ammo_difference = var_b11feea92c35d08e - var_83e55048826dcd05;
    total_ammo_give = min( amount_ammo_give + var_83e55048826dcd05, var_b11feea92c35d08e );
    params.eattacker setweaponammoclip( weaponobj, int( total_ammo_give ) );
}

// Namespace specialty_ammo_on_kill
// Params 0
// Checksum 0xe0e44f05, Offset: 0x24d
// Size: 0x16
function function_c3ab919af19042b8()
{
    if ( isplayer( self ) )
    {
        self notify( #"hash_255a14471cab1008" );
    }
}

