// scripts\mp\zm\ztron\ztron_challenge.gsc  (hash_13e6c475d9c90085.gscc) (size: 2240 Bytes / 0x8c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc181e0bb (3246514363)
// size ...... 2240 (0x8c0)
// includes .. 3   (offset: 0x884)
// strings ... 1   (offset: 0x89c)
// dev strs .. 2   (offset: 0x8a8)
// exports ... 9   (offset: 0x5c0)
// cseg ...... 0x7a + 0x546 (0x5c0)
// imports ... 12  (offset: 0x728)
// animtree1 . 0   (offset: 0x8c0)
// animtree2 . 0   (offset: 0x8c0)
#using script_31ee2a173f3499b7;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_enemy;

#namespace ztron_challenge;

// Namespace ztron_challenge
// Params 0
// Checksum 0x8971a02b, Offset: 0x98
// Size: 0x1f
function init()
{
    level.ztron.challenges = [];
    level thread function_e8e9b762a6535cf0();
}

// Namespace ztron_challenge
// Params 7
// Checksum 0xf04caa67, Offset: 0xbf
// Size: 0x12c
function registerchallenge( name, arenaname, challengef, var_76de5662df546e5, arena_round = 1, var_183d7d35288c47c6 = undefined, var_9025ca374ee87f39 = undefined )
{
    assert( isdefined( name ), "<dev string:x24>" );
    assert( !isdefined( level.ztron.challenges[ name ] ), "<dev string:x4b>" );
    
    if ( isdefined( name ) )
    {
        struct = spawnstruct();
        struct.name = name;
        struct.challengef = challengef;
        struct.var_acd2c234854dbe93 = var_76de5662df546e5;
        struct.arenaname = arenaname;
        struct.arena_round = arena_round;
        struct.var_6000157c88b5cdfd = var_183d7d35288c47c6;
        struct.var_cd6baaff724ae07d = var_9025ca374ee87f39;
        level.ztron.challenges[ name ] = struct;
        
        /#
            ztron_ui::function_b13bf7aa05e282b4( name );
        #/
    }
}

// Namespace ztron_challenge
// Params 1
// Checksum 0x50fc96b1, Offset: 0x1f3
// Size: 0x22
function function_7955c2c9c2ac986f( name )
{
    return level.ztron.challenges[ name ];
}

// Namespace ztron_challenge
// Params 1
// Checksum 0x1d7ec179, Offset: 0x21e
// Size: 0x9a
function function_d013ebdd9c2ce720( name )
{
    foreach ( challenge in level.ztron.challenges )
    {
        if ( challenge.arenaname == name )
        {
            return challenge;
        }
    }
}

// Namespace ztron_challenge
// Params 2
// Checksum 0xe792b609, Offset: 0x2c1
// Size: 0x6b, Type: bool
function function_d6dad472bec7f9cd( name, arena_round )
{
    challenge = function_d013ebdd9c2ce720( name );
    
    if ( !isdefined( challenge ) )
    {
        return false;
    }
    
    if ( challenge.istriggered )
    {
        return false;
    }
    
    if ( challenge.arena_round != arena_round )
    {
        return false;
    }
    
    level thread function_8fee4e90e97aec7a( challenge );
    level thread challenge_cleanup( challenge );
    return true;
}

// Namespace ztron_challenge
// Params 1, eflags: 0x4
// Checksum 0x209cdf8c, Offset: 0x335
// Size: 0xd9
function private function_8fee4e90e97aec7a( challenge )
{
    challenge.istriggered = 1;
    level utility::flag_clear( "ztron_challenge_round_spawning" );
    level.ztron.currentchallenge = challenge;
    level.ztron.var_1cf13cded1683a4e = challenge.var_6000157c88b5cdfd;
    level.ztron.var_cd6baaff724ae07d = challenge.var_cd6baaff724ae07d;
    challenge thread [[ challenge.challengef ]]();
    wait 0.1;
    level notify( #"challenge_ready", challenge.name );
    
    if ( isdefined( level.ztron.var_cd3b78b45db638d8 ) )
    {
        ztron_enemy::function_13596b7af6f5a4b5( level.ztron.var_cd3b78b45db638d8 );
    }
}

// Namespace ztron_challenge
// Params 1
// Checksum 0xfcbddd6b, Offset: 0x416
// Size: 0xc1
function challenge_cleanup( challenge )
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"round_over" );
    
    if ( isdefined( level.ztron.var_cd3b78b45db638d8 ) )
    {
        ztron_enemy::function_16b9e1ff92e4fb4( level.ztron.var_cd3b78b45db638d8 );
    }
    
    if ( isdefined( challenge.var_acd2c234854dbe93 ) )
    {
        challenge thread [[ challenge.var_acd2c234854dbe93 ]]();
    }
    
    level.ztron.var_1cf13cded1683a4e = undefined;
    level.ztron.var_cd6baaff724ae07d = undefined;
    level.ztron.currentchallenge = undefined;
    level.ztron.var_cd3b78b45db638d8 = undefined;
}

// Namespace ztron_challenge
// Params 0
// Checksum 0xfc783d9d, Offset: 0x4df
// Size: 0xe1
function function_e8e9b762a6535cf0()
{
    self notify( #"hash_fe2a7c6fe449c899" );
    self endon( #"hash_fe2a7c6fe449c899" );
    
    if ( !getdvarint( @"hash_be920986e116ec4", 1 ) || level.ztron.var_371903e5801e0e08 )
    {
        return;
    }
    
    level waittill( #"game_lap" );
    
    foreach ( challenge in level.ztron.challenges )
    {
        challenge.istriggered = 0;
    }
    
    level thread function_e8e9b762a6535cf0();
}

