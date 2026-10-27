// script_d4163b9045d4348  (hash_0d4163b9045d4348.gscc) (size: 1598 Bytes / 0x63e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x393d0f7 (60018935)
// size ...... 1598 (0x63e)
// includes .. 3   (offset: 0x60a)
// strings ... 1   (offset: 0x622)
// dev strs .. 0   (offset: 0x63e)
// exports ... 6   (offset: 0x382)
// cseg ...... 0x93 + 0x2ef (0x382)
// imports ... 13  (offset: 0x472)
// animtree1 . 0   (offset: 0x63e)
// animtree2 . 0   (offset: 0x63e)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;

#namespace specialty_stance_speed_mods;

// Namespace specialty_stance_speed_mods
// Params 0, eflags: 0x1
// Checksum 0xa991813, Offset: 0xb1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_stance_speed_mods
// Params 1
// Checksum 0x45e38f2f, Offset: 0xd1
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_stance_speed_mods", &function_ce629c8794f006fa, &function_5179a41d4815073b, [] );
    }
}

// Namespace specialty_stance_speed_mods
// Params 0
// Checksum 0x9e60a2b7, Offset: 0x113
// Size: 0x10c
function function_ce629c8794f006fa()
{
    callback::add( #"stance_changed", &function_26bae873823febe9 );
    callback::add( #"sprint_begin", &function_26bae873823febe9 );
    callback::add( #"sprint_end", &function_26bae873823febe9 );
    bundle = self.var_9842326056fd7207;
    self.var_76f0be58c38da2a8 = { #stancespeedmod:bundle.standspeedmod ?? 0, #pronespeedmod:bundle.pronespeedmod ?? 0.3, #crouchspeedmod:bundle.crouchspeedmod ?? 0.3 };
    
    if ( !common::function_8ff835bf23198a0( "specialty_stance_speed_mods" ) )
    {
        common::function_983eeeeb432f3d8( "specialty_stance_speed_mods", bundle.standspeedmod ?? 0, bundle.crouchspeedmod ?? 0.3, bundle.pronespeedmod ?? 0.3, 0 );
    }
    
    function_26bae873823febe9();
}

// Namespace specialty_stance_speed_mods
// Params 0
// Checksum 0x508fab36, Offset: 0x227
// Size: 0x88
function function_5179a41d4815073b()
{
    callback::remove( #"stance_changed", &function_26bae873823febe9 );
    callback::remove( #"sprint_begin", &function_26bae873823febe9 );
    callback::remove( #"sprint_end", &function_26bae873823febe9 );
    self.var_76f0be58c38da2a8 = undefined;
    self.stancespeedmod = undefined;
    utility::callsharedfunc( #"player", #"updatemovespeed" );
    
    if ( common::function_8ff835bf23198a0( "specialty_stance_speed_mods" ) )
    {
        common::function_d85a92c557ea5a52( "specialty_stance_speed_mods" );
    }
}

// Namespace specialty_stance_speed_mods
// Params 1
// Checksum 0x4520a095, Offset: 0x2b7
// Size: 0xcb
function function_26bae873823febe9( params )
{
    switch ( self getstance() )
    {
        case #"hash_3fed0cbd303639eb":
            self.stancespeedmod = self.var_76f0be58c38da2a8.crouchspeedmod;
            break;
        case #"hash_d91940431ed7c605":
            self.stancespeedmod = self.var_76f0be58c38da2a8.pronespeedmod;
            break;
        case #"hash_c6775c88e38f7803":
            self.stancespeedmod = self.var_76f0be58c38da2a8.standspeedmod;
            break;
    }
    
    if ( self.stancespeedmod == 0 )
    {
        self.stancespeedmod = undefined;
    }
    
    utility::callsharedfunc( #"player", #"updatemovespeed" );
}

