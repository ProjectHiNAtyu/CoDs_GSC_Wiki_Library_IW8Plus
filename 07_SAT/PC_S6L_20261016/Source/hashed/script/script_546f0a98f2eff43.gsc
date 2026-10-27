// script_546f0a98f2eff43  (hash_0546f0a98f2eff43.gscc) (size: 1352 Bytes / 0x548 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x358aca93 (898288275)
// size ...... 1352 (0x548)
// includes .. 1   (offset: 0x524)
// strings ... 2   (offset: 0x52c)
// dev strs .. 0   (offset: 0x548)
// exports ... 7   (offset: 0x2b4)
// cseg ...... 0x95 + 0x21f (0x2b4)
// imports ... 12  (offset: 0x3cc)
// animtree1 . 0   (offset: 0x548)
// animtree2 . 0   (offset: 0x548)
#using scripts\common\callbacks;

#namespace specialty_see_red_dot_grapple;

// Namespace specialty_see_red_dot_grapple
// Params 0, eflags: 0x1
// Checksum 0xface0247, Offset: 0xb3
// Size: 0x3d
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    
    if ( getdvarint( @"hash_654fd242084be777", 0 ) == 0 )
    {
        level callback::add( "on_grapple_pulling_start", &function_17da84fdf0008ba6 );
    }
}

// Namespace specialty_see_red_dot_grapple
// Params 1
// Checksum 0x16611ac2, Offset: 0xf8
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_see_red_dot_grapple", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_see_red_dot_grapple
// Params 0
// Checksum 0xe4915fa8, Offset: 0x13a
// Size: 0x2
function setspecialty()
{
    
}

// Namespace specialty_see_red_dot_grapple
// Params 0
// Checksum 0xd426ebc6, Offset: 0x144
// Size: 0x2
function unsetspecialty()
{
    
}

// Namespace specialty_see_red_dot_grapple
// Params 1
// Checksum 0xd2f6f767, Offset: 0x14e
// Size: 0x22
function function_17da84fdf0008ba6( params )
{
    player = self;
    player thread function_746b6971f76c8a0d();
}

// Namespace specialty_see_red_dot_grapple
// Params 0
// Checksum 0xddd7cc7e, Offset: 0x178
// Size: 0x13c
function function_746b6971f76c8a0d()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    players_nearby = getplayersinradius( player.origin, 1400, 1400, 0, player );
    teams_nearby = [];
    
    foreach ( player_nearby in players_nearby )
    {
        if ( player.team == player_nearby.team )
        {
            continue;
        }
        
        if ( !isdefined( player_nearby.perks[ "specialty_see_red_dot_grapple" ] ) )
        {
            continue;
        }
        
        teams_nearby = arraycombineunique( teams_nearby, [ player_nearby.team ] );
    }
    
    if ( teams_nearby.size <= 0 )
    {
        return;
    }
    
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 1 );
    waitframe();
    player function_71c7c5be98d11198( teams_nearby, 1000, 1 );
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 0 );
}

