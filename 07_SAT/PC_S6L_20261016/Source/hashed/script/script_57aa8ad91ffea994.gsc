// script_57aa8ad91ffea994  (hash_57aa8ad91ffea994.gscc) (size: 1629 Bytes / 0x65d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d4a1ca (114598346)
// size ...... 1629 (0x65d)
// includes .. 3   (offset: 0x609)
// strings ... 3   (offset: 0x621)
// dev strs .. 0   (offset: 0x65d)
// exports ... 7   (offset: 0x385)
// cseg ...... 0xb3 + 0x2d2 (0x385)
// imports ... 13  (offset: 0x49d)
// animtree1 . 0   (offset: 0x65d)
// animtree2 . 0   (offset: 0x65d)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\teams;

#namespace specialty_faster_mantle_scalar_spread;

// Namespace specialty_faster_mantle_scalar_spread
// Params 0, eflags: 0x5
// Checksum 0x391c49ab, Offset: 0xd1
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_a10eeba48fafb34f );
}

// Namespace specialty_faster_mantle_scalar_spread
// Params 1, eflags: 0x4
// Checksum 0xc9424f41, Offset: 0xf1
// Size: 0x3a
function private function_a10eeba48fafb34f( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_faster_mantle_scalar_spread", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_faster_mantle_scalar_spread
// Params 0, eflags: 0x4
// Checksum 0xfc8de26, Offset: 0x133
// Size: 0x23
function private setspecialty()
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread function_6f87e0ffaa9422ae();
}

// Namespace specialty_faster_mantle_scalar_spread
// Params 0
// Checksum 0x82ee2b9, Offset: 0x15e
// Size: 0x14b
function function_6f87e0ffaa9422ae()
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"hash_401de37a89871b4a" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.perks[ "specialty_faster_mantle_scalar_spread" ] ) )
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
            if ( player_nearby == player )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, player_nearby.origin ) <= var_91d716ba2635c5b8 )
            {
                player_nearby thread function_287935357d4e429b( player );
            }
        }
        
        wait 1;
    }
}

// Namespace specialty_faster_mantle_scalar_spread
// Params 1
// Checksum 0xa5d41504, Offset: 0x2b1
// Size: 0xb0
function function_287935357d4e429b( var_1745d520afa98051 )
{
    player = self;
    player notify( #"hash_e1a59a8dfbc6a5a" );
    player endon( #"hash_e1a59a8dfbc6a5a" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( var_1745d520afa98051.perks[ "specialty_faster_mantle_scalar_spread" ] ) )
    {
        if ( !isdefined( player.perks[ "specialty_faster_mantle_scalar" ] ) )
        {
            player perk::giveperk( "specialty_faster_mantle_scalar" );
        }
    }
    
    wait 10;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.perks[ "specialty_faster_mantle_scalar" ] ) )
    {
        return;
    }
    
    player perk::removeperk( "specialty_faster_mantle_scalar" );
}

// Namespace specialty_faster_mantle_scalar_spread
// Params 0, eflags: 0x4
// Checksum 0xf241fbe7, Offset: 0x369
// Size: 0x1c
function private unsetspecialty()
{
    player = self;
    player notify( #"hash_401de37a89871b4a" );
}

