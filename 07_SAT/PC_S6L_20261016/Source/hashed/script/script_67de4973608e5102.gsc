// script_67de4973608e5102  (hash_67de4973608e5102.gscc) (size: 1327 Bytes / 0x52f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d53bcc8 (492027080)
// size ...... 1327 (0x52f)
// includes .. 5   (offset: 0x4c3)
// strings ... 5   (offset: 0x4eb)
// dev strs .. 0   (offset: 0x52f)
// exports ... 6   (offset: 0x27f)
// cseg ...... 0xbc + 0x1c3 (0x27f)
// imports ... 12  (offset: 0x36f)
// animtree1 . 0   (offset: 0x52f)
// animtree2 . 0   (offset: 0x52f)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_exfil_sat;

#namespace zm_bgb_exit_strategy;

// Namespace zm_bgb_exit_strategy
// Params 0, eflags: 0x5
// Checksum 0x8475db55, Offset: 0xda
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( "exit_strategy_sat", "exit_strategy", &__init__, undefined );
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0xfd54b3e3, Offset: 0xfb
// Size: 0x47
function __init__()
{
    utility::registersharedfunc( "exit_strategy", #"hash_c2ad3b622a5c3d9a", &validation );
    utility::registersharedfunc( "exit_strategy", #"activation", &activation );
    callback::add( "zm_sat_exfil_declined", &function_e0d977663f8f0542 );
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0x589b83d5, Offset: 0x14a
// Size: 0xc2, Type: bool
function validation()
{
    if ( !isarray( level.s_zm_exfil.var_c7cfc464905e7bcd ) )
    {
        return false;
    }
    
    if ( level.var_9075568a1189c7c9 )
    {
        return false;
    }
    
    foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
    {
        if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0x2903c6c1, Offset: 0x215
// Size: 0x25
function activation()
{
    val::set( "bgb_exit_strategy", "interactions", 0 );
    wait 0.5;
    level thread zm_exfil_sat::function_29042ff5bd626104( self, 1 );
}

// Namespace zm_bgb_exit_strategy
// Params 1
// Checksum 0xafb7569a, Offset: 0x242
// Size: 0x3d
function function_e0d977663f8f0542( params )
{
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1 thread zm_exfil_sat::function_952ebe590ae54bac();
    }
}

