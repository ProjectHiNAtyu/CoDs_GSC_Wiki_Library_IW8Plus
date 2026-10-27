// script_c31a91c9bc0e9a1  (hash_0c31a91c9bc0e9a1.gscc) (size: 2924 Bytes / 0xb6c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4fbcd4e (3573271886)
// size ...... 2924 (0xb6c)
// includes .. 8   (offset: 0xacc)
// strings ... 5   (offset: 0xb0c)
// dev strs .. 2   (offset: 0xb54)
// exports ... 11  (offset: 0x5d4)
// cseg ...... 0xe2 + 0x4f2 (0x5d4)
// imports ... 28  (offset: 0x78c)
// animtree1 . 0   (offset: 0xb6c)
// animtree2 . 0   (offset: 0xb6c)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace namespace_dac04870182a72d9;

// Namespace namespace_dac04870182a72d9
// Params 0, eflags: 0x5
// Checksum 0xe437e6d7, Offset: 0x100
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_da6f6a80d88c95a4", undefined, &function_5b333b319e92e764, undefined );
}

// Namespace namespace_dac04870182a72d9
// Params 0
// Checksum 0xf882bf3e, Offset: 0x121
// Size: 0xa
function function_5b333b319e92e764()
{
    level thread function_5dc567afe2da8565();
}

// Namespace namespace_dac04870182a72d9
// Params 0
// Checksum 0xec6eee2b, Offset: 0x133
// Size: 0x1c
function function_5dc567afe2da8565()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_fc67bbd10c9059d", &function_1f4d06d96f6d9ad5, &function_1541e9ac4042a7c8 );
}

// Namespace namespace_dac04870182a72d9
// Params 0
// Checksum 0xb1f259d8, Offset: 0x157
// Size: 0x38
function function_1f4d06d96f6d9ad5()
{
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_relic_challenge_objective_updated", &function_90fbd895de4e36d6 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_dac04870182a72d9
// Params 0
// Checksum 0xe1ee4ca6, Offset: 0x197
// Size: 0xba
function function_1541e9ac4042a7c8()
{
    callback::remove( #"player_spawned", &on_player_spawned );
    callback::remove( "on_relic_challenge_objective_updated", &function_90fbd895de4e36d6 );
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            player thread function_2d939e1662c7312e();
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x5e>" );
    #/
}

// Namespace namespace_dac04870182a72d9
// Params 1, eflags: 0xc
// Checksum 0xe4b9596d, Offset: 0x259
// Size: 0x3d
function private on_player_spawned( params )
{
    self notify( #"hash_b436acf76ce67b96" );
    self endon( #"hash_b436acf76ce67b96" );
    self endon( #"disconnect" );
    wait 0.5;
    thread function_347b9b0d161d82a8();
}

// Namespace namespace_dac04870182a72d9
// Params 1, eflags: 0x4
// Checksum 0x10a48f7d, Offset: 0x29e
// Size: 0x1b7
function private function_90fbd895de4e36d6( params )
{
    if ( level.active_relic_challenge.var_189abf4197963d87 == 1 )
    {
        return;
    }
    else if ( level.active_relic_challenge.var_189abf4197963d87 == 2 )
    {
        foreach ( player in level.players )
        {
            if ( isplayer( player ) )
            {
                player function_347b9b0d161d82a8();
            }
        }
        
        if ( level.players[ 0 ] )
        {
            level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
        }
        
        return;
    }
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 <= level.active_relic_challenge.max_waves )
    {
        foreach ( player in level.players )
        {
            if ( isplayer( player ) )
            {
                player thread take_player_loadout();
            }
        }
        
        if ( level.players[ 0 ] )
        {
            level.players[ 0 ] playsoundtoteam( "evt_plr_oob_impact_laugh", "allies" );
        }
    }
}

// Namespace namespace_dac04870182a72d9
// Params 0, eflags: 0xc
// Checksum 0xa72542df, Offset: 0x45d
// Size: 0x6f
function private function_347b9b0d161d82a8()
{
    self notify( #"hash_d364921417866c96" );
    self endon( #"hash_d364921417866c96" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"disconnect" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
        wait 1;
    }
    
    if ( self )
    {
        zm_utility::function_d47920bb0d5fa327( "relicchallenge_allweaponstakenperwave" );
        thread take_player_loadout();
    }
}

// Namespace namespace_dac04870182a72d9
// Params 0, eflags: 0x4
// Checksum 0xa7c47705, Offset: 0x4d4
// Size: 0x98
function private take_player_loadout()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"disconnect" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
        wait 1;
    }
    
    if ( self )
    {
        zm_utility::function_92275a9d3969d91d( undefined, undefined, undefined, 1, 1 );
        weaponname = "sat_me_knife_mp";
        forcedweapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
        self giveweapon( forcedweapon );
        weapon::function_b4c9549dee5d0fc5( forcedweapon );
        item_weapon::function_40e1cbd0e1f47d1a( forcedweapon, 0 );
        self switchtoweaponimmediate( forcedweapon );
    }
}

// Namespace namespace_dac04870182a72d9
// Params 0, eflags: 0xc
// Checksum 0xc4db0c35, Offset: 0x574
// Size: 0x60
function private function_2d939e1662c7312e()
{
    self notify( #"hash_f9ba519cdd5333d3" );
    self endon( #"hash_f9ba519cdd5333d3" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
        wait 1;
    }
    
    if ( self )
    {
        zm_utility::function_663d59490abc834f( undefined, 1, 1, 1, undefined, undefined );
    }
}

