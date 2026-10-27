// scripts\mp\common\perks\engineer_minimap.gsc  (hash_04d43ef4a76203dd.gscc) (size: 1438 Bytes / 0x59e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc82288f9 (3357706489)
// size ...... 1438 (0x59e)
// includes .. 3   (offset: 0x56a)
// strings ... 2   (offset: 0x582)
// dev strs .. 0   (offset: 0x59e)
// exports ... 8   (offset: 0x2f2)
// cseg ...... 0x8c + 0x266 (0x2f2)
// imports ... 11  (offset: 0x432)
// animtree1 . 0   (offset: 0x59e)
// animtree2 . 0   (offset: 0x59e)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\objidpoolmanager;

#namespace engineer_minimap;

// Namespace engineer_minimap
// Params 0, eflags: 0x1
// Checksum 0x71b22d26, Offset: 0xaa
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_83d319ef300bc6c5 );
}

// Namespace engineer_minimap
// Params 1
// Checksum 0x98f68904, Offset: 0xca
// Size: 0x6b
function function_83d319ef300bc6c5( params )
{
    bundle = level.perkbundles[ "specialty_engineer_minimap" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_engineer_minimap", &function_f90b02b092ad28ea, &function_c9fa0dc49a0d5059, [ "specialty_engineer" ], &function_984ce7bbb928d664 );
    }
}

// Namespace engineer_minimap
// Params 0
// Checksum 0x825ca0da, Offset: 0x13d
// Size: 0x18
function function_984ce7bbb928d664()
{
    if ( !isdefined( level.var_9b088d39aebb092d ) )
    {
        level.var_9b088d39aebb092d = [];
    }
}

// Namespace engineer_minimap
// Params 0
// Checksum 0x281ebef1, Offset: 0x15d
// Size: 0xb
function function_f90b02b092ad28ea()
{
    level function_2c9e075be8c78b1c( self );
}

// Namespace engineer_minimap
// Params 0
// Checksum 0x2ccb0b62, Offset: 0x170
// Size: 0xb
function function_c9fa0dc49a0d5059()
{
    level function_65e3cb7c6ab8ac73( self );
}

// Namespace engineer_minimap
// Params 1
// Checksum 0xb1391afe, Offset: 0x183
// Size: 0xcc
function function_2c9e075be8c78b1c( player )
{
    if ( !isdefined( level.var_9b088d39aebb092d[ player.name ] ) )
    {
        level.var_9b088d39aebb092d[ player.name ] = player;
    }
    
    foreach ( killstreakobjid, killstreakobj in level.var_2a5b98496d5d09a1 )
    {
        if ( player_utility::playersareenemies( player, killstreakobj.owner ) )
        {
            objidpoolmanager::objective_playermask_addshowplayer( killstreakobjid, player );
        }
    }
}

// Namespace engineer_minimap
// Params 1
// Checksum 0xbd028647, Offset: 0x257
// Size: 0x9b
function function_65e3cb7c6ab8ac73( player )
{
    level.var_9b088d39aebb092d[ player.name ] = undefined;
    
    foreach ( killstreakobjid, killstreakobj in level.var_2a5b98496d5d09a1 )
    {
        objidpoolmanager::objective_playermask_hidefrom( killstreakobjid, player );
    }
}

