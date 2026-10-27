// script_4430149d1f8d79d9  (hash_4430149d1f8d79d9.gscc) (size: 1721 Bytes / 0x6b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96927d55 (2526182741)
// size ...... 1721 (0x6b9)
// includes .. 2   (offset: 0x651)
// strings ... 6   (offset: 0x661)
// dev strs .. 0   (offset: 0x6b9)
// exports ... 8   (offset: 0x3cd)
// cseg ...... 0x134 + 0x299 (0x3cd)
// imports ... 11  (offset: 0x50d)
// animtree1 . 0   (offset: 0x6b9)
// animtree2 . 0   (offset: 0x6b9)
#using scripts\common\callbacks;
#using scripts\mp\common\equipment\emp_grenade;

#namespace specialty_broken_plate_emp;

// Namespace specialty_broken_plate_emp
// Params 0, eflags: 0x5
// Checksum 0x28deff43, Offset: 0x152
// Size: 0x76
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_6ec1a00c845a662c );
    level callback::add( #"hash_aa7c0dbef3e86ee4", &onarmorbreak );
    level callback::add( #"armor_health_full", &function_1c3bfa51c490a977 );
    level._effect[ "vfx_sat_specialty_broken_plate_smoke_emp" ] = loadfxasset( "vfx_sat_core_equip_emp_grenade_explo_smoke_default" );
    level._effect[ "vfx_sat_specialty_broken_plate_emp" ] = loadfxasset( "vfx_sat_core_equip_emp_grenade_explo" );
}

// Namespace specialty_broken_plate_emp
// Params 1, eflags: 0x4
// Checksum 0x1ab79ad1, Offset: 0x1d0
// Size: 0x3a
function private function_6ec1a00c845a662c( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_broken_plate_emp", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_broken_plate_emp
// Params 0, eflags: 0x4
// Checksum 0x9e389813, Offset: 0x212
// Size: 0x46
function private setspecialty()
{
    player = self;
    
    if ( player.armorhealth && player.armorhealth < player.maxarmorhealth )
    {
        player.var_c0536da2a4f6f670 = 1;
    }
}

// Namespace specialty_broken_plate_emp
// Params 0, eflags: 0x4
// Checksum 0xeec7af7f, Offset: 0x260
// Size: 0x1a
function private unsetspecialty()
{
    player = self;
    player.var_c0536da2a4f6f670 = undefined;
}

// Namespace specialty_broken_plate_emp
// Params 1, eflags: 0x4
// Checksum 0x9a930240, Offset: 0x282
// Size: 0xd9
function private onarmorbreak( params )
{
    player = self;
    
    if ( !isdefined( player.perks[ "specialty_broken_plate_emp" ] ) )
    {
        return;
    }
    
    if ( 1 && isdefined( params.attacker ) && params.attacker == player )
    {
        return;
    }
    
    if ( !player function_6fdcaa7278a49c24() )
    {
        return;
    }
    
    grenade = undefined;
    position = player.origin;
    playfxontag( level._effect[ "vfx_sat_specialty_broken_plate_emp" ], player, "tag_origin" );
    playfxontag( level._effect[ "vfx_sat_specialty_broken_plate_smoke_emp" ], player, "tag_origin" );
    player emp_grenade::emp_apply_effect( grenade, position, 0, 1 );
    player playsoundonmovingent( #"hash_6bd3eb05e5e0c2e8" );
}

// Namespace specialty_broken_plate_emp
// Params 0, eflags: 0x4
// Checksum 0x4be31aef, Offset: 0x363
// Size: 0x2f, Type: bool
function private function_6fdcaa7278a49c24()
{
    player = self;
    
    if ( player.var_c0536da2a4f6f670 )
    {
        return false;
    }
    
    player.var_c0536da2a4f6f670 = 1;
    return true;
}

// Namespace specialty_broken_plate_emp
// Params 1, eflags: 0x4
// Checksum 0xf8c32b4d, Offset: 0x39b
// Size: 0x32
function private function_1c3bfa51c490a977( params )
{
    player = self;
    
    if ( player.var_c0536da2a4f6f670 )
    {
        player.var_c0536da2a4f6f670 = undefined;
    }
}

