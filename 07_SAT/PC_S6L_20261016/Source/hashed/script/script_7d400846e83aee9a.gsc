// script_7d400846e83aee9a  (hash_7d400846e83aee9a.gscc) (size: 1835 Bytes / 0x72b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac8c732f (2894885679)
// size ...... 1835 (0x72b)
// includes .. 3   (offset: 0x6f3)
// strings ... 2   (offset: 0x70b)
// dev strs .. 0   (offset: 0x72b)
// exports ... 8   (offset: 0x3d7)
// cseg ...... 0x85 + 0x352 (0x3d7)
// imports ... 16  (offset: 0x517)
// animtree1 . 0   (offset: 0x72b)
// animtree2 . 0   (offset: 0x72b)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\teams;
#using scripts\mp\parachute;

#namespace specialty_detect_enemy_use_dot;

// Namespace specialty_detect_enemy_use_dot
// Params 0, eflags: 0x5
// Checksum 0xb1992f7e, Offset: 0xa3
// Size: 0x5a
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_56977b5743e294b6 );
    level callback::add( #"hash_8daeabb90e45c6bc", &onkioskpurchase );
    level callback::add( #"hash_906ce08d1b0ca8ce", &onkioskpurchase );
    level callback::add( #"on_contract_start", &oncontractstart );
}

// Namespace specialty_detect_enemy_use_dot
// Params 1, eflags: 0x4
// Checksum 0x42ddabb, Offset: 0x105
// Size: 0x3a
function private function_56977b5743e294b6( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_detect_enemy_use_dot", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_detect_enemy_use_dot
// Params 0, eflags: 0x4
// Checksum 0x98e13aba, Offset: 0x147
// Size: 0x1d
function private setspecialty()
{
    player = self;
    player.var_35f71c7947d83fa1 = 1;
}

// Namespace specialty_detect_enemy_use_dot
// Params 0, eflags: 0x4
// Checksum 0xa8568eee, Offset: 0x16c
// Size: 0x1a
function private unsetspecialty()
{
    player = self;
    player.var_35f71c7947d83fa1 = undefined;
}

// Namespace specialty_detect_enemy_use_dot
// Params 1, eflags: 0x4
// Checksum 0x248c064, Offset: 0x18e
// Size: 0x2d
function private onkioskpurchase( params )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player function_609e9d6d7f9935ff();
}

// Namespace specialty_detect_enemy_use_dot
// Params 1, eflags: 0x4
// Checksum 0x4a35b50b, Offset: 0x1c3
// Size: 0x41
function private oncontractstart( params )
{
    player = params.task.var_ca369031b554da2f;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player function_609e9d6d7f9935ff();
}

// Namespace specialty_detect_enemy_use_dot
// Params 0
// Checksum 0x740545cb, Offset: 0x20c
// Size: 0x1cb
function function_609e9d6d7f9935ff()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    pingradius = 4724;
    pingheight = parachute::getc130height();
    pingduration = level.br_circle.var_218f8c7ea7365164 ?? 1000;
    playerallies = [];
    
    if ( teams::function_b00ab7e503f33379( player.team, "players" ) )
    {
        playerallies = teams::getteamdata( player.team, "players" );
    }
    
    pingorigin = ( player.origin[ 0 ], player.origin[ 1 ], level.br_level.var_cd92896f34e2d8ef ?? -100 );
    players_nearby = getplayersinradius( pingorigin, pingradius, pingheight, 0, playerallies );
    teams_nearby = [];
    
    foreach ( player_nearby in players_nearby )
    {
        if ( isdefined( player_nearby.perks[ "specialty_detect_enemy_use_dot" ] ) )
        {
            teams_nearby = arraycombineunique( teams_nearby, [ player_nearby.team ] );
        }
    }
    
    if ( teams_nearby.size <= 0 )
    {
        return;
    }
    
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 1 );
    waitframe();
    player function_71c7c5be98d11198( teams_nearby, pingduration, 1 );
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 0 );
}

