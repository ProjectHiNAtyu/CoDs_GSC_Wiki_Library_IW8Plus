// script_1d1fdc6e29194ea2  (hash_1d1fdc6e29194ea2.gscc) (size: 1520 Bytes / 0x5f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9df9c1d1 (2650390993)
// size ...... 1520 (0x5f0)
// includes .. 3   (offset: 0x598)
// strings ... 2   (offset: 0x5b0)
// dev strs .. 0   (offset: 0x5f0)
// exports ... 6   (offset: 0x2c4)
// cseg ...... 0x8a + 0x23a (0x2c4)
// imports ... 17  (offset: 0x3b4)
// animtree1 . 0   (offset: 0x5f0)
// animtree2 . 0   (offset: 0x5f0)
#using scripts\common\callbacks;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_speed_boost_on_kill;

// Namespace specialty_speed_boost_on_kill
// Params 0, eflags: 0x1
// Checksum 0xb8ebb371, Offset: 0xa8
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_speed_boost_on_kill
// Params 1
// Checksum 0x193d750e, Offset: 0xc8
// Size: 0x4b
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_speed_boost_on_kill", undefined, &function_50291db250ca502c );
        level callback::add( #"on_ai_killed", &function_5c16900141eac7c1 );
    }
}

// Namespace specialty_speed_boost_on_kill
// Params 0, eflags: 0x4
// Checksum 0x1d0e6d1, Offset: 0x11b
// Size: 0x1d
function private function_50291db250ca502c()
{
    if ( isplayer( self ) )
    {
        self notify( #"speed_on_kill_end" );
        remove_speed_scale();
    }
}

// Namespace specialty_speed_boost_on_kill
// Params 1, eflags: 0x4
// Checksum 0x3afe4361, Offset: 0x140
// Size: 0x13f
function private function_5c16900141eac7c1( params )
{
    if ( isplayer( params.eattacker ) && isdefined( params.eattacker.perks[ "specialty_speed_boost_on_kill" ] ) )
    {
        params.eattacker endon( #"death" );
        params.eattacker endon( #"speed_on_kill_end" );
        var_8b75d0fc1cbe0996 = level.perkbundles[ "specialty_speed_boost_on_kill" ].var_1550bd9e5939ae67;
        var_a6ed241596794a47 = level.perkbundles[ "specialty_speed_boost_on_kill" ].var_453ed96e884de01e;
        
        if ( !params.eattacker common::function_8ff835bf23198a0( "speed_on_kill" ) )
        {
            params.eattacker common::function_ac4bf3256b2545e3( "speed_on_kill", var_8b75d0fc1cbe0996 );
        }
        
        if ( !params.eattacker weapons::function_67041fa03f87323c( "speed_on_kill" ) )
        {
            params.eattacker weapons::addextramovespeed( "speed_on_kill", var_8b75d0fc1cbe0996 );
        }
        
        params.eattacker weapons::updatemovespeedscale();
        wait var_a6ed241596794a47;
        params.eattacker remove_speed_scale();
    }
}

// Namespace specialty_speed_boost_on_kill
// Params 0, eflags: 0x4
// Checksum 0xd87fa398, Offset: 0x287
// Size: 0x3d
function private remove_speed_scale()
{
    if ( common::function_8ff835bf23198a0( "speed_on_kill" ) )
    {
        common::function_d85a92c557ea5a52( "speed_on_kill" );
    }
    
    if ( weapons::function_67041fa03f87323c( "speed_on_kill" ) )
    {
        weapons::removeextramovespeed( "speed_on_kill" );
    }
    
    weapons::updatemovespeedscale();
}

