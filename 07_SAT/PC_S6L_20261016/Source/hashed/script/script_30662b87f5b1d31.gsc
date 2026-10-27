// script_30662b87f5b1d31  (hash_030662b87f5b1d31.gscc) (size: 1843 Bytes / 0x733 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x740e956f (1947112815)
// size ...... 1843 (0x733)
// includes .. 5   (offset: 0x6c7)
// strings ... 4   (offset: 0x6ef)
// dev strs .. 0   (offset: 0x733)
// exports ... 7   (offset: 0x403)
// cseg ...... 0xbd + 0x346 (0x403)
// imports ... 15  (offset: 0x51b)
// animtree1 . 0   (offset: 0x733)
// animtree2 . 0   (offset: 0x733)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace specialty_nearby_movement_buff;

// Namespace specialty_nearby_movement_buff
// Params 0, eflags: 0x5
// Checksum 0xf0b6aca3, Offset: 0xdb
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_96dc08f4e8f2d042 );
}

// Namespace specialty_nearby_movement_buff
// Params 1, eflags: 0x4
// Checksum 0x8f4ad9c7, Offset: 0xfb
// Size: 0x3a
function private function_96dc08f4e8f2d042( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_nearby_movement_buff", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_nearby_movement_buff
// Params 0, eflags: 0x4
// Checksum 0x65ca9e08, Offset: 0x13d
// Size: 0x5a
function private setspecialty()
{
    player = self;
    player.var_512a49870e8b106f = player.var_9842326056fd7207.var_512a49870e8b106f;
    player.var_759e2f5442be7ff7 = player.var_9842326056fd7207.var_759e2f5442be7ff7;
    player thread function_2945835091d33ab2();
}

// Namespace specialty_nearby_movement_buff
// Params 0, eflags: 0x4
// Checksum 0x91f150ea, Offset: 0x19f
// Size: 0x32
function private unsetspecialty()
{
    player = self;
    player.var_512a49870e8b106f = undefined;
    player.var_759e2f5442be7ff7 = undefined;
    player notify( #"hash_2ee4118fe786e9ef" );
}

// Namespace specialty_nearby_movement_buff
// Params 0
// Checksum 0xd1d0eec0, Offset: 0x1d9
// Size: 0x156
function function_2945835091d33ab2()
{
    player = self;
    player endon( #"hash_2ee4118fe786e9ef" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.perks[ "specialty_nearby_movement_buff" ] ) )
    {
        return;
    }
    
    pingradius = 985;
    var_91d716ba2635c5b8 = pingradius * pingradius;
    
    while ( true )
    {
        playerallies = [];
        
        if ( teams::function_b00ab7e503f33379( player.team, "alivePlayers" ) )
        {
            playerallies = teams::getteamdata( player.team, "alivePlayers" );
        }
        
        foreach ( player_nearby in playerallies )
        {
            if ( distance2dsquared( player.origin, player_nearby.origin ) <= var_91d716ba2635c5b8 )
            {
                player_nearby thread function_924a2727bb54e481( player.var_512a49870e8b106f, player.var_759e2f5442be7ff7 );
            }
        }
        
        wait 1;
    }
}

// Namespace specialty_nearby_movement_buff
// Params 2
// Checksum 0x4a9811eb, Offset: 0x337
// Size: 0xcc
function function_924a2727bb54e481( var_207c20826bdc099c, var_86e98d863571c950 )
{
    player = self;
    player notify( #"hash_986e84b2c92548f9" );
    player endon( #"hash_986e84b2c92548f9" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player ) || !isdefined( var_207c20826bdc099c ) || !isdefined( var_86e98d863571c950 ) )
    {
        return;
    }
    
    if ( !player common::function_8ff835bf23198a0( "nearbyMovBuffSpeedScalar" ) )
    {
        player common::function_ac4bf3256b2545e3( "nearbyMovBuffSpeedScalar", var_207c20826bdc099c );
        player weapons::updatemovespeedscale();
        player namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_grenadier" );
    }
    
    wait var_86e98d863571c950;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !player common::function_8ff835bf23198a0( "nearbyMovBuffSpeedScalar" ) )
    {
        return;
    }
    
    player common::function_d85a92c557ea5a52( "nearbyMovBuffSpeedScalar" );
    player weapons::updatemovespeedscale();
}

