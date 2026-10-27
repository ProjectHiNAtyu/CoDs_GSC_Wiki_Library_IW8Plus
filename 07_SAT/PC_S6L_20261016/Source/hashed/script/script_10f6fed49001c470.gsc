// script_10f6fed49001c470  (hash_10f6fed49001c470.gscc) (size: 3448 Bytes / 0xd78 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ae44e7a (1256476282)
// size ...... 3448 (0xd78)
// includes .. 2   (offset: 0xd20)
// strings ... 3   (offset: 0xd30)
// dev strs .. 0   (offset: 0xd78)
// exports ... 11  (offset: 0x9c4)
// cseg ...... 0xb0 + 0x914 (0x9c4)
// imports ... 10  (offset: 0xb7c)
// animtree1 . 0   (offset: 0xd78)
// animtree2 . 0   (offset: 0xd78)
#using scripts\common\omnvar_utility;
#using scripts\mp\common\utility\teams;

#namespace namespace_59f63cf8cb6ba727;

// Namespace namespace_59f63cf8cb6ba727
// Params 2
// Checksum 0xc8df83ff, Offset: 0xce
// Size: 0x12b
function function_37ae6307d0ac97e3( timer = 0, progress_percentage = 0 )
{
    team_info = self;
    tracker_data = { #progress_percentage:progress_percentage, #timer:timer, #state:team_info function_1ff0d9e9d3365773(), #enabled:team_info function_9646d91740047c87() };
    
    foreach ( player in level.players )
    {
        tracker_data.is_enemy = 0;
        
        if ( player.team != team_info.team )
        {
            tracker_data.is_enemy = 1;
        }
        
        player function_91af022d0a1bf722( tracker_data );
    }
    
    team_info function_da12e30b443225d0();
}

// Namespace namespace_59f63cf8cb6ba727
// Params 2
// Checksum 0xf7ec3c27, Offset: 0x201
// Size: 0x12d
function function_d8f0bed02cdc016( timer = 0, progress_percentage = 0 )
{
    team_info = self;
    tracker_data = { #progress_percentage:progress_percentage, #timer:timer, #state:team_info function_1ff0d9e9d3365773(), #is_enemy:0, #enabled:team_info function_9646d91740047c87() };
    team_info function_da12e30b443225d0();
    teammates = teams::getteamdata( team_info.team, "players" );
    
    foreach ( player in teammates )
    {
        player function_91af022d0a1bf722( tracker_data );
        player function_55a8519aae4d0ba8( team_info.squad_players_data );
    }
}

// Namespace namespace_59f63cf8cb6ba727
// Params 0
// Checksum 0xb503819d, Offset: 0x336
// Size: 0xb9
function function_da12e30b443225d0()
{
    team_info = self;
    
    if ( isdefined( team_info.squad_players_data ) )
    {
        teammates = teams::getteamdata( team_info.team, "players" );
        
        foreach ( player in teammates )
        {
            player function_55a8519aae4d0ba8( team_info.squad_players_data );
        }
    }
}

// Namespace namespace_59f63cf8cb6ba727
// Params 3
// Checksum 0x72bd870b, Offset: 0x3f7
// Size: 0xc4
function function_da5de86e82247545( player, item_bundle, pickup )
{
    team_info = self;
    
    if ( player.team == team_info.team )
    {
        slot = int( player.sessionuimemberindex ) & 3;
        
        if ( item_bundle == %"hash_5fb15d7c2a806cf5" )
        {
            team_info.squad_players_data[ slot ].has_isotope = pickup ? 1 : 0;
        }
        else
        {
            team_info.squad_players_data[ slot ].has_hard_drive = pickup ? 1 : 0;
        }
        
        team_info function_da12e30b443225d0();
    }
}

// Namespace namespace_59f63cf8cb6ba727
// Params 3
// Checksum 0x9ee126a1, Offset: 0x4c3
// Size: 0xab
function function_282f2cca3997a1f2( player, zone_index, var_a88f34d38839a510 )
{
    team_info = self;
    slot = int( player.sessionuimemberindex ) & 3;
    
    if ( zone_index == 1 )
    {
        team_info.squad_players_data[ slot ].var_ec964e3496c62793 = var_a88f34d38839a510 ? 1 : 0;
    }
    else if ( zone_index == 2 )
    {
        team_info.squad_players_data[ slot ].var_ec964f3496c629c6 = var_a88f34d38839a510 ? 1 : 0;
    }
    
    team_info function_da12e30b443225d0();
}

// Namespace namespace_59f63cf8cb6ba727
// Params 0
// Checksum 0xe7282fb7, Offset: 0x576
// Size: 0x111
function function_fe5bec2ab8fe0bbc()
{
    team_info = self;
    item_status = {};
    teammates = teams::getteamdata( team_info.team, "players" );
    
    foreach ( player in teammates )
    {
        slot = int( player.sessionuimemberindex ) & 3;
        
        if ( team_info.squad_players_data[ slot ].has_isotope )
        {
            item_status.has_isotope = 1;
        }
        
        if ( team_info.squad_players_data[ slot ].has_hard_drive )
        {
            item_status.has_hard_drive = 1;
        }
    }
    
    return item_status;
}

// Namespace namespace_59f63cf8cb6ba727
// Params 0, eflags: 0x4
// Checksum 0x40918d33, Offset: 0x690
// Size: 0x1c, Type: bool
function private function_9646d91740047c87()
{
    team_info = self;
    return team_info.state > 0;
}

// Namespace namespace_59f63cf8cb6ba727
// Params 0, eflags: 0x4
// Checksum 0x4e5997de, Offset: 0x6b5
// Size: 0x1a
function private function_1ff0d9e9d3365773()
{
    team_info = self;
    return team_info.state;
}

// Namespace namespace_59f63cf8cb6ba727
// Params 1, eflags: 0x4
// Checksum 0x7b2ce390, Offset: 0x6d8
// Size: 0x1b7
function private function_91af022d0a1bf722( data )
{
    enabled_max = 1;
    is_enemy_max = 1;
    state_max = 15;
    var_45cf6b7605c79d5e = 511;
    progress_percentage_max = 127;
    assert( data.enabled >= 0 && data.enabled <= enabled_max );
    assert( data.is_enemy >= 0 && data.is_enemy <= is_enemy_max );
    assert( data.state >= 0 && data.state <= state_max );
    assert( data.timer >= 0 && data.timer <= var_45cf6b7605c79d5e );
    assert( data.progress_percentage >= 0 && data.progress_percentage <= progress_percentage_max );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_data", 0, 1, int( data.enabled ) & enabled_max );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_data", 1, 1, int( data.is_enemy ) & is_enemy_max );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_data", 2, 4, int( data.state ) & state_max );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_data", 6, 9, int( data.timer ) & var_45cf6b7605c79d5e );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_data", 15, 7, int( data.progress_percentage ) & progress_percentage_max );
}

// Namespace namespace_59f63cf8cb6ba727
// Params 1
// Checksum 0x1db4e4e7, Offset: 0x897
// Size: 0x12d
function function_55a8519aae4d0ba8( players_data )
{
    if ( !isdefined( players_data ) )
    {
        return;
    }
    
    bit_max = 1;
    
    for ( slot = 0; slot < 4 ; slot++ )
    {
        var_c1b0af8862ae5d74 = slot * 4;
        var_ec964e3496c62793 = 0;
        var_ec964f3496c629c6 = 0;
        has_isotope = 0;
        has_hard_drive = 0;
        
        if ( isdefined( players_data[ slot ] ) )
        {
            var_ec964e3496c62793 = int( players_data[ slot ].var_ec964e3496c62793 ) & bit_max;
            var_ec964f3496c629c6 = int( players_data[ slot ].var_ec964f3496c629c6 ) & bit_max;
            has_isotope = int( players_data[ slot ].has_isotope ) & bit_max;
            has_hard_drive = int( players_data[ slot ].has_hard_drive ) & bit_max;
        }
        
        omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_players", var_c1b0af8862ae5d74 + 0, 1, var_ec964e3496c62793 );
        omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_players", var_c1b0af8862ae5d74 + 1, 1, var_ec964f3496c629c6 );
        omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_players", var_c1b0af8862ae5d74 + 2, 1, has_isotope );
        omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_contract_mission_players", var_c1b0af8862ae5d74 + 3, 1, has_hard_drive );
    }
}

