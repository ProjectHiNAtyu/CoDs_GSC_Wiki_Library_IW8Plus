// scripts\mp\br\gametypes\br_publicevent_dataheist.gsc  (hash_10b0035c00df94bb.gscc) (size: 37529 Bytes / 0x9299 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96b00a1f (2528119327)
// size ...... 37529 (0x9299)
// includes .. 28  (offset: 0x8951)
// strings ... 87  (offset: 0x8a31)
// dev strs .. 68  (offset: 0x8f5d)
// exports ... 92  (offset: 0x5eb5)
// cseg ...... 0x7b6 + 0x56ff (0x5eb5)
// imports ... 225 (offset: 0x6d15)
// animtree1 . 0   (offset: 0x9299)
// animtree2 . 0   (offset: 0x9299)
#using script_16ea1b94f0f381b3;
#using script_70ac8a06d80020b0;
#using script_be7da0439d09064;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\agents\br_agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;

#namespace br_publicevent_dataheist;

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x1eab440f, Offset: 0x7d4
// Size: 0x2
function __init()
{
    
}

// Namespace br_publicevent_dataheist
// Params 0, eflags: 0x1
// Checksum 0xfe4db582, Offset: 0x7de
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"dataheist", &init );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x29d3717c, Offset: 0x7fd
// Size: 0x5c
function init( event_info )
{
    event_info.waitfunc = &event_wait;
    event_info.activatefunc = &event_activate;
    event_info.postinitfunc = &event_post_init;
    event_info.deactivatefunc = &event_deactivate;
    audio_utility::snd_transient_load( "wz_pe_dataheist" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x386ef283, Offset: 0x861
// Size: 0xcd
function event_post_init()
{
    init_dvars( self );
    init_uplink_points( self );
    level thread init_ai( self );
    init_dialog();
    scriptable::scriptable_addusedcallbackbypart( "br_pe_dataheist_uplink_useable", &uplink_scriptable_used );
    rank::registerscoreinfo( #"br_pe_capnode", #"value", 1000 );
    self.screen_states = [];
    self.screen_states[ 0 ] = "default";
    self.screen_states[ 1 ] = "downloading";
    self.screen_states[ 2 ] = "interference";
    self.screen_states[ 3 ] = "blocked";
    
    /#
        level thread debug_init();
        setdvarifuninitialized( @"hash_31426ea35497080f", 0 );
        setdvarifuninitialized( @"hash_8326c0fb793ffe45", "<dev string:x24>" );
    #/
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xddccf9c, Offset: 0x936
// Size: 0x4bd
function init_dvars( event_data )
{
    team_size = game_utility::function_f24780eadd3fb772();
    
    switch ( team_size )
    {
        case 1:
            event_data.var_c3fa379f3e1d5114 = 50;
            event_data.var_2a1e1c8695b7ed79 = 3;
            event_data.var_5fee829c202ed866 = 4;
            break;
        case 2:
            event_data.var_c3fa379f3e1d5114 = 50;
            event_data.var_2a1e1c8695b7ed79 = 3;
            event_data.var_5fee829c202ed866 = 4;
            break;
        case 3:
            event_data.var_c3fa379f3e1d5114 = 60;
            event_data.var_2a1e1c8695b7ed79 = 4;
            event_data.var_5fee829c202ed866 = 3;
            break;
        case 4:
        default:
            event_data.var_c3fa379f3e1d5114 = 60;
            event_data.var_2a1e1c8695b7ed79 = 4;
            event_data.var_5fee829c202ed866 = 3;
            break;
    }
    
    var_3c8adbe694ddfa6a = getdvarint( @"hash_193a2e0ce733e6d1", 0 );
    
    if ( var_3c8adbe694ddfa6a > -1 )
    {
        event_data.var_2a1e1c8695b7ed79 = var_3c8adbe694ddfa6a;
    }
    
    event_data.var_c3fa379f3e1d5114 = getdvarint( @"hash_dc4cb3509e8702a4", event_data.var_c3fa379f3e1d5114 );
    event_data.var_5fee829c202ed866 = getdvarint( @"hash_6b8529ae11c8c7f6", event_data.var_5fee829c202ed866 );
    event_data.var_fa79fdf59931e175 = [ 0.25 ];
    function_98d8e4274f798ae();
    event_data.var_727ef3b10e30b4 = getdvarint( @"hash_f1bec911a034dce4", 1500 );
    event_data.var_255bee1cd75c18f5 = squared( event_data.var_727ef3b10e30b4 );
    event_data.var_4c4b98faf5134c3e = getdvarint( @"hash_3fe660588b6f40ce", 5000 );
    event_data.var_33bf8c9847d7f863 = squared( event_data.var_4c4b98faf5134c3e );
    event_data.var_1e46a595500a537c = getdvarint( @"hash_63a6751a902ecaec", 750 );
    event_data.var_e11138a30c20d625 = getdvarint( @"hash_ebb538de66a9395", 500 );
    event_data.var_eceaea2d05fd8cb5 = getdvarint( @"hash_c70440c743bc72f1", 1 ) == 1;
    event_data.var_5ad467601489fce9 = getdvarint( @"hash_36db07fd99bb9b31", 1 ) == 1;
    event_data.var_9db700184e765b31 = getdvarint( @"hash_9ec61cfa337dc3e1", 1000 );
    event_data.event_duration_seconds = int( max( 1, getdvarint( @"hash_3b2ad4cc6d705455", 300 ) ) );
    event_data.var_74ef8947c418def9 = event_data.event_duration_seconds + event_data.var_c3fa379f3e1d5114;
    event_data.map_circle_min_radius = getdvarint( @"hash_86aca5c7cdaf36b5", 4000 );
    event_data.var_71b42be63cc105b5 = int( max( 1, getdvarint( @"hash_f33906ab457ed275", 3 ) ) );
    event_data.var_dd13505b52ca51fd = int( max( 1, getdvarint( @"hash_e87df641ad60dfbd", 3 ) ) );
    event_data.var_8a388b8f9721e802 = 1 / event_data.var_dd13505b52ca51fd;
    event_data.var_4f21c4b0ec894c6b = getdvarint( @"hash_c70caafa18fe870f", 240 );
    event_data.ai_budget = getdvarint( @"hash_ae3ec08cd03905e0", 50 );
    event_data.var_2fa8fd4ac8f0a354 = getdvarint( @"hash_f63bb46f84687aac", 500 );
    event_data.var_cef6aa54b40dae7f = getdvarint( @"hash_8dbf9e06474b2ba7", 1 ) == 1;
    event_data.var_ca88da390cc665e7 = getdvarint( @"hash_17b8716c1c9ca6ff", 1 );
    event_data.var_639e4a2f54067e65 = getdvarint( @"hash_9e246216c8ab73cd", 2 );
    event_data.var_d1e5e20dbe8ef34b = getdvarint( @"hash_d1254cb3a6456cd3", 3 );
    event_data.ai_rusher_tier = getdvarint( @"hash_6f20a3b0bc339fcb", 2 );
    event_data.agent_accuracy = getdvarfloat( @"hash_743f2aafce01b00d", 0.4 );
    event_data.var_4e57efc9b783e5bc = getdvarint( @"hash_8a328fc0a8b887e4", 8 );
    event_data.var_c67748f877c9ddca = getdvarint( @"hash_89e40bcff5370f82", 120 );
    event_data.ftue_enabled = getdvarint( @"hash_5b21ed44f9d400", 1 ) == 1;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x20171627, Offset: 0xdfb
// Size: 0xf5
function function_98d8e4274f798ae()
{
    var_e0656d0516a7e251 = getdvar( @"hash_4675782a74d204dc" );
    
    if ( var_e0656d0516a7e251 )
    {
        valid_thresholds = [];
        tokens = strtok( var_e0656d0516a7e251, ",", 0 );
        
        foreach ( token in tokens )
        {
            threshold = float( token );
            
            if ( !isfloat( threshold ) )
            {
                println( "<dev string:x25>" + token + "<dev string:x42>" );
                continue;
            }
            
            valid_thresholds[ valid_thresholds.size ] = threshold;
        }
        
        if ( valid_thresholds.size > 0 )
        {
            self.var_fa79fdf59931e175 = valid_thresholds;
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x82413ab2, Offset: 0xef8
// Size: 0x26a
function init_uplink_points( event_data )
{
    uplink_points = [];
    id = 0;
    uplink_structs = utility::getstructarray( "dataheist_uplink_location", "script_noteworthy" );
    
    foreach ( struct in uplink_structs )
    {
        uplink_points[ uplink_points.size ] = init_make_uplink_point( struct.origin, struct.angles, struct.group, id );
        id++;
    }
    
    if ( uplink_points.size <= 0 )
    {
        switch ( level.mapname )
        {
            case #"hash_71c69de1abae3a2":
            case #"hash_4aa5d6e97851bdbd":
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( -471, -1886, 25 ), ( 0, 180, 0 ), "none", 0 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( -367, -811, 25 ), ( 0, 180, 0 ), "none", 1 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( 704, -2767, 25 ), ( 0, 270, 0 ), "none", 2 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( 1970, -4096, 25 ), ( 0, 270, 0 ), "none", 3 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( 3077, -2300, 25 ), ( 0, 180, 0 ), "none", 4 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( 2935, 59, 25 ), ( 0, 0, 0 ), "none", 5 );
                uplink_points[ uplink_points.size ] = init_make_uplink_point( ( 5015, -674, 25 ), ( 0, 0, 0 ), "none", 6 );
                break;
        }
    }
    
    event_data.uplink_points = uplink_points;
    
    /#
        event_data function_bfb2434155e89118( event_data.event_duration_seconds );
    #/
}

// Namespace br_publicevent_dataheist
// Params 4
// Checksum 0xdae5921b, Offset: 0x116a
// Size: 0xb9
function init_make_uplink_point( origin, angles, group, id )
{
    point = spawnstruct();
    point.origin = origin;
    point.angles = angles;
    point.group = group;
    point.id = id;
    
    if ( !isdefined( group ) )
    {
        point.group = "none";
    }
    
    if ( !isdefined( id ) )
    {
        id = -1;
    }
    
    point.used = 0;
    point.is_valid = 0;
    point.valid_neighbors = [];
    return point;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x3876fbf0, Offset: 0x122c
// Size: 0x54
function init_ai( event_data )
{
    level endon( #"game_ended" );
    
    if ( event_data.var_2a1e1c8695b7ed79 < 1 )
    {
        return;
    }
    
    ai_mp_controller::function_7f833bacb64445a6();
    ai_mp_controller::aibudget_registercategory( "dataheist", event_data.ai_budget );
    br_agent_utils::function_b9a0e8dab46ee1bb( "dataheist" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x52bab07e, Offset: 0x1288
// Size: 0x10c
function init_dialog()
{
    game[ "dialog" ][ "dataheist_event_start" ] = "dths_wzan_dhes";
    game[ "dialog" ][ "dataheist_comp_success" ] = "dths_wzan_dhcs";
    game[ "dialog" ][ "dataheist_comp_failure" ] = "dths_wzan_dhcf";
    game[ "dialog" ][ "dataheist_team_act_uplink" ] = "dths_wzan_dtap";
    game[ "dialog" ][ "dataheist_enemy_act_uplink" ] = "dths_wzan_dhnp";
    game[ "dialog" ][ "dataheist_enemy_cap_uplink" ] = "dths_wzan_dhnc";
    game[ "dialog" ][ "dataheist_team_cap_uplink" ] = "dths_wzan_dhtc";
    game[ "dialog" ][ "dataheist_ai_spawn" ] = "dths_wzan_dhas";
    game[ "dialog" ][ "dataheist_enemy_block_down" ] = "dths_wzan_debd";
    game[ "dialog" ][ "dataheist_out_range" ] = "dths_wzan_dhtr";
    game[ "dialog" ][ "dataheist_team_comp_uplink" ] = "dths_wzan_dhtp";
    game[ "dialog" ][ "dataheist_enemy_comp_uplink" ] = "dths_wzan_nmsn";
    game[ "dialog" ][ "dataheist_enemy_comp_lost_uplink" ] = "dths_wzan_dhnl";
    game[ "dialog" ][ "dataheist_time_warn" ] = "dths_wzan_dhtw";
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x47673d44, Offset: 0x139c
// Size: 0x2
function __event()
{
    
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x6de7f3b2, Offset: 0x13a6
// Size: 0x2
function event_wait()
{
    
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x25b7254f, Offset: 0x13b0
// Size: 0x5ef
function event_activate()
{
    assert( self.var_c3fa379f3e1d5114 > 0, "<dev string:x86>" );
    self endon( #"event_deactivated" );
    
    /#
        function_db94439ed60145a0();
    #/
    
    self.uplinks = [];
    self.team_scores = [];
    thread function_c52925d7c3475601();
    br_publicevents::showsplashtoall( "br_pe_dataheist_start", "splash_list_br_pe_dataheist" );
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 6 );
    event_duration_seconds = self.event_duration_seconds;
    
    if ( !level.br_circle_disabled )
    {
        event_duration_seconds = min( self.event_duration_seconds, br_circle::function_f30ad5eda1a16d44() - 5 );
    }
    
    self.end_time = gettime() + event_duration_seconds * 1000;
    self.warning_time = self.end_time - 30000;
    setomnvar( "ui_publicevent_timer", self.end_time );
    function_bfb2434155e89118( event_duration_seconds );
    force_points_string = getdvar( @"hash_8326c0fb793ffe45", "" );
    force_points = function_e5d66397948cf0e8( force_points_string );
    points = [];
    
    if ( force_points.size > 0 )
    {
        foreach ( point_index in force_points )
        {
            points[ points.size ] = self.uplink_points[ point_index ];
        }
    }
    else
    {
        valid_start_points = function_17148716995cc5c7();
        
        if ( valid_start_points.size <= 0 )
        {
            /#
                iprintlnbold( "<dev string:xbb>" );
            #/
            
            level thread br_publicevents::function_a1af4e372c2ecc3( %"dataheist" );
            return;
        }
        
        points[ 0 ] = utility::array_random( valid_start_points );
        nearby_points = arrayrandomize( points[ 0 ].valid_neighbors );
        
        for ( i = 0; i < self.var_71b42be63cc105b5 - 1 ; i++ )
        {
            points[ i + 1 ] = nearby_points[ i ];
        }
    }
    
    foreach ( point in points )
    {
        thread uplink_start( point );
    }
    
    self.midpoint = ( 0, 0, 0 );
    
    foreach ( point in points )
    {
        self.midpoint += point.origin;
    }
    
    self.midpoint /= points.size;
    max_distance_sq = 0;
    
    foreach ( point in points )
    {
        dist_sq = distance2dsquared( self.midpoint, point.origin );
        
        if ( dist_sq > max_distance_sq )
        {
            max_distance_sq = dist_sq;
        }
    }
    
    self.var_f36f8df94fbdbd2c = sqrt( max_distance_sq ) + self.var_9db700184e765b31;
    
    if ( self.var_eceaea2d05fd8cb5 )
    {
        circle_radius = max( sqrt( max_distance_sq ) + 250, self.map_circle_min_radius );
        self.map_circle = spawnquestcircle( "Dataheist_Br", self.midpoint[ 0 ], self.midpoint[ 1 ], circle_radius, undefined );
        self.map_circle show();
        
        if ( self.var_9db700184e765b31 > self.var_1e46a595500a537c )
        {
            thread function_860d0cc4078480bf();
        }
        
        if ( self.var_5ad467601489fce9 )
        {
            thread function_a4ba5533f3dae152();
        }
    }
    
    /#
        if ( getdvarint( @"hash_31426ea35497080f", 0 ) == 1 )
        {
            function_58216cd834be61bd();
        }
    #/
    
    ai_mp_controller::function_2b1cc53b284373( &function_9cd7e918ea7b4055, self );
    thread function_72fa15adc2ee8ffc();
    thread function_cc0078a72ae6b0eb( event_duration_seconds - 30 );
    
    if ( self.ftue_enabled )
    {
        thread function_a55cb450f8cff93();
    }
    
    dialog_play_all( "dataheist_event_start", 1 );
    utility::waittill_any_timeout( event_duration_seconds, "all_uplinks_complete" );
    winners = [];
    losers = [];
    
    foreach ( player in level.players )
    {
        if ( function_a3eb3ebe56566484( player.team ) > 0 )
        {
            winners[ winners.size ] = player;
            continue;
        }
        
        losers[ losers.size ] = player;
    }
    
    function_c438ab0a4b2c95f0( "dataheist_comp_success", winners, 0.5 );
    function_c438ab0a4b2c95f0( "dataheist_comp_failure", losers, 0.5 );
    level thread br_publicevents::function_a1af4e372c2ecc3( %"dataheist" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x9cdba066, Offset: 0x19a7
// Size: 0xf3
function event_deactivate()
{
    /#
        function_fc241791fbab5584();
    #/
    
    br_publicevents::showsplashtoall( "br_pe_dataheist_end", "splash_list_br_pe_dataheist" );
    ai_mp_controller::function_52ec288d11c14408( &function_9cd7e918ea7b4055 );
    
    if ( isdefined( self.map_circle ) )
    {
        self.map_circle delete();
    }
    
    foreach ( uplink in self.uplinks )
    {
        uplink uplink_cleanup();
    }
    
    self.uplinks = undefined;
    self.team_scores = undefined;
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    self notify( #"event_deactivated" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x706d05fd, Offset: 0x1aa2
// Size: 0x56
function function_72fa15adc2ee8ffc()
{
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    
    for ( i = 0; i < self.uplinks.size ; i++ )
    {
        self waittill( #"uplink_complete" );
    }
    
    self notify( #"all_uplinks_complete" );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x2b31e26a, Offset: 0x1b00
// Size: 0x59
function function_cc0078a72ae6b0eb( time )
{
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    wait time;
    nearby_players = player_utility::script_getplayersinradius( self.midpoint, self.var_f36f8df94fbdbd2c );
    function_c438ab0a4b2c95f0( "dataheist_time_warn", nearby_players );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xbd0318c9, Offset: 0x1b61
// Size: 0x164
function function_860d0cc4078480bf()
{
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    
    while ( true )
    {
        for ( i = 0; i < self.uplinks.size ; i++ )
        {
            uplink = self.uplinks[ i ];
            uplink.nearby_players = player_utility::script_getplayersinradius( uplink.origin, self.var_9db700184e765b31 );
            
            foreach ( player in uplink.nearby_players )
            {
                if ( isdefined( player.team ) && !isdefined( uplink.seen_teams[ player.team ] ) )
                {
                    uplink.seen_teams[ player.team ] = 1;
                    
                    if ( isdefined( uplink.obj_id ) )
                    {
                        objective_addteamtomask( uplink.obj_id, player.team );
                    }
                }
            }
            
            wait 1;
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xd70d3358, Offset: 0x1ccd
// Size: 0x119
function function_a4ba5533f3dae152()
{
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    revealed_count = 0;
    
    while ( revealed_count < self.uplinks.size )
    {
        self waittill( #"uplink_reveal", uplink );
        revealed_count++;
        
        foreach ( team, data in level.teamdata )
        {
            if ( isdefined( team ) && !isdefined( uplink.seen_teams[ team ] ) )
            {
                uplink.seen_teams[ team ] = 1;
                
                if ( isdefined( uplink.obj_id ) )
                {
                    objective_addteamtomask( uplink.obj_id, team );
                }
            }
        }
    }
    
    self.var_7bc99be691d47ce1 = 1;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xf2f94bd6, Offset: 0x1dee
// Size: 0xce
function function_7bc9dcd485ff8173( team )
{
    if ( self.var_7bc99be691d47ce1 )
    {
        return;
    }
    
    foreach ( uplink in self.uplinks )
    {
        if ( !isdefined( uplink.seen_teams[ team ] ) )
        {
            uplink.seen_teams[ team ] = 1;
            
            if ( isdefined( uplink.obj_id ) )
            {
                objective_addteamtomask( uplink.obj_id, team );
            }
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x6a7379de, Offset: 0x1ec4
// Size: 0x2e
function function_c52925d7c3475601()
{
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    level waittill( #"cancel_public_event" );
    event_deactivate();
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xcfb9fcd6, Offset: 0x1efa
// Size: 0x172
function event_add_score( team )
{
    if ( isdefined( self.team_scores[ team ] ) )
    {
        self.team_scores[ team ]++;
    }
    else
    {
        self.team_scores[ team ] = 1;
    }
    
    xp_event_name = "";
    
    switch ( self.team_scores[ team ] )
    {
        case 1:
            xp_event_name = #"hash_cfddc35e5f58e75";
            break;
        case 2:
            xp_event_name = #"hash_cfdd935e5f5895c";
            break;
        case 3:
        default:
            xp_event_name = #"hash_cfdda35e5f58b0f";
            break;
    }
    
    team_players = teams::getteamdata( team, "players" );
    var_4367c4fb37707e87 = 0;
    
    foreach ( player in team_players )
    {
        if ( !player br_public::isplayerinorgoingtogulag() )
        {
            if ( !var_4367c4fb37707e87 )
            {
                player thread points::doscoreevent( #"br_pe_capnode" );
                var_4367c4fb37707e87 = 1;
            }
            
            player thread points::doscoreevent( xp_event_name );
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x1af37c80, Offset: 0x2074
// Size: 0x2e
function function_a3eb3ebe56566484( team )
{
    if ( isdefined( self.team_scores[ team ] ) )
    {
        return self.team_scores[ team ];
    }
    
    return 0;
}

// Namespace br_publicevent_dataheist
// Params 2
// Checksum 0x129e1b88, Offset: 0x20aa
// Size: 0x135
function function_9cd7e918ea7b4055( params, event )
{
    event endon( #"event_deactivated" );
    category = self.category;
    
    if ( "dataheist" != category )
    {
        return;
    }
    
    attacker = params.eattacker;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( isdefined( event.uplinks ) )
    {
        foreach ( uplink in event.uplinks )
        {
            if ( uplink.is_complete )
            {
                continue;
            }
            
            if ( attacker.team == uplink.controlling_team && arraycontains( uplink.agents, self ) )
            {
                uplink function_1053af7df2915763( event.var_5fee829c202ed866 );
            }
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x73930b2e, Offset: 0x21e7
// Size: 0xa8
function function_a55cb450f8cff93()
{
    level endon( #"game_ended" );
    wait 5;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player br_public::isplayeringulag() )
        {
            player br_ftue_popups::ftue_triggertip( "br_ftue_dataheist" );
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x86aea1f1, Offset: 0x2297
// Size: 0x2
function __uplink()
{
    
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x8ebd62b5, Offset: 0x22a1
// Size: 0xbff
function uplink_start( uplink_point )
{
    assert( isdefined( uplink_point ), "<dev string:xf4>" );
    level endon( #"game_ended" );
    self endon( #"event_deactivated" );
    uplink_point.used = 1;
    uplink = spawnstruct();
    uplink.event = self;
    self.uplinks[ self.uplinks.size ] = uplink;
    uplink.is_complete = 0;
    uplink.is_active = 0;
    uplink.num_blockers = 0;
    uplink.is_team_present = 0;
    uplink.time = 0;
    uplink.progress = 0;
    uplink.controlling_team = "None";
    uplink.origin = uplink_point.origin;
    uplink.angles = uplink_point.angles;
    uplink.agents = [];
    uplink.seen_teams = [];
    uplink.capture_state = 0;
    uplink.is_team_present = 0;
    uplink.num_blockers = 0;
    uplink.loc_name = "Uplink #" + uplink_point.id + " @ " + uplink_point.group;
    uplink.capture_time_seconds = self.var_c3fa379f3e1d5114;
    uplink.previous_owners = [];
    uplink.obj_id = objidpoolmanager::requestobjectiveid( 1 );
    uplink.trigger = spawn( "trigger_radius", uplink.origin - ( 0, 0, self.var_e11138a30c20d625 * 0.5 ), 0, self.var_1e46a595500a537c, self.var_e11138a30c20d625 );
    uplink.trigger.uplink = uplink;
    uplink.trigger_ents = [];
    uplink thread function_9534aaab7e83d0e8();
    uplink.is_emp_applied = 0;
    emp_debuff::add_emp_ent( uplink.trigger );
    uplink.trigger emp_debuff::set_start_emp_callback( &function_9de110ff608c6e51 );
    uplink.trigger emp_debuff::set_clear_emp_callback( &function_5f467687121699ac );
    uplink.scriptable = spawnscriptable( "br_pe_dataheist_uplink", uplink.origin, uplink.angles );
    uplink.scriptable.uplink = uplink;
    
    if ( self.var_2a1e1c8695b7ed79 > 0 )
    {
        requests = function_bbd30f5fdf3cade7( self.var_2a1e1c8695b7ed79 );
        uplink thread agents_spawn_group( requests, [ "heli", "para", "safe" ], function_a20a92a8727958a2( 1 ) );
    }
    
    assert( uplink.obj_id != -1, "<dev string:x133>" );
    objidpoolmanager::objective_add_objective( uplink.obj_id, "current", uplink.origin + ( 0, 0, 15 ), "ui_map_icon_obj_dataheist_uplink" );
    
    if ( self.var_eceaea2d05fd8cb5 )
    {
        objective_removeallfrommask( uplink.obj_id );
        objective_showtoplayersinmask( uplink.obj_id );
    }
    
    objective_setdescription( uplink.obj_id, &"mp_br_pe_dataheist/name" );
    objective_setbackground( uplink.obj_id, 6 );
    uplink waittill( #"activated", team );
    self notify( #"uplink_reveal", uplink );
    uplink.scriptable setscriptablepartstate( "br_pe_dataheist_uplink_useable", "active" );
    uplink.is_active = 1;
    objective_setshowprogress( uplink.obj_id, 1 );
    
    foreach ( player in level.players )
    {
        objective_showprogressforclient( uplink.obj_id, player );
    }
    
    foreach ( ent in uplink.trigger_ents )
    {
        if ( isplayer( ent ) )
        {
            objective_hideprogressforclient( uplink.obj_id, ent );
        }
    }
    
    uplink function_7fb5642b42f6e992( team );
    nearby_players = function_a3a2be374004371c( uplink.controlling_team );
    function_c438ab0a4b2c95f0( "dataheist_team_act_uplink", nearby_players, 2 );
    nearby_players = function_c049fcff41fc54d3( uplink.controlling_team );
    function_c438ab0a4b2c95f0( "dataheist_enemy_act_uplink", nearby_players, 2 );
    nearby_players = undefined;
    uplink childthread function_860b616b99164e73();
    uplink childthread function_383f6437686fe44a();
    
    if ( self.var_2a1e1c8695b7ed79 > 0 )
    {
        uplink childthread function_9c44b6c0c354cba8( self.var_fa79fdf59931e175 );
    }
    
    last_state = uplink.capture_state;
    uplink.scriptable setscriptablepartstate( "br_pe_dataheist_uplink_screen", self.screen_states[ uplink.capture_state ] );
    var_6438c94358b161fd = 0.25;
    var_cfaf79bed8c2336e = gettime() + 5000;
    var_b264af1dddb11ea9 = -1;
    var_26d7c31fcf04111 = gettime() + 5000;
    var_42e5bb0a6c0695c4 = -1;
    
    while ( uplink.time < uplink.capture_time_seconds )
    {
        time = gettime();
        
        if ( !uplink.is_team_present )
        {
            uplink.capture_state = 0;
        }
        else if ( uplink.is_emp_applied || uplink.num_blockers >= self.var_dd13505b52ca51fd )
        {
            uplink.capture_state = 3;
        }
        else if ( uplink.num_blockers > 0 )
        {
            uplink.capture_state = 2;
        }
        else
        {
            uplink.capture_state = 1;
        }
        
        if ( uplink.capture_state != last_state )
        {
            foreach ( ent in uplink.trigger_ents )
            {
                if ( isplayer( ent ) )
                {
                    ent setclientomnvar( "ui_publicevent_dataheist_state", uplink.capture_state );
                }
            }
            
            if ( uplink.capture_state == 0 )
            {
                var_b264af1dddb11ea9 = gettime() + 10000;
            }
            else
            {
                var_b264af1dddb11ea9 = -1;
            }
            
            if ( uplink.capture_state > 1 )
            {
                var_42e5bb0a6c0695c4 = gettime() + 6000;
            }
            else
            {
                var_42e5bb0a6c0695c4 = -1;
            }
            
            last_state = uplink.capture_state;
            uplink.scriptable setscriptablepartstate( "br_pe_dataheist_uplink_screen", self.screen_states[ uplink.capture_state ] );
        }
        
        if ( var_b264af1dddb11ea9 > 0 )
        {
            if ( time > var_b264af1dddb11ea9 && time > var_cfaf79bed8c2336e )
            {
                var_cfaf79bed8c2336e = time + 30000;
                nearby_team = uplink function_7fa1ce4adffc7cfe( uplink.controlling_team );
                function_c438ab0a4b2c95f0( "dataheist_out_range", nearby_team );
                var_b264af1dddb11ea9 = -1;
            }
        }
        else if ( var_42e5bb0a6c0695c4 > 0 )
        {
            if ( time > var_42e5bb0a6c0695c4 && time > var_26d7c31fcf04111 )
            {
                var_26d7c31fcf04111 = time + 30000;
                nearby_team = uplink function_7fa1ce4adffc7cfe( uplink.controlling_team );
                function_c438ab0a4b2c95f0( "dataheist_enemy_block_down", nearby_team );
            }
        }
        
        if ( uplink.is_team_present && !uplink.is_emp_applied )
        {
            scale = ( time - self.warning_time ) / ( self.end_time - self.warning_time );
            scale = clamp( scale, 0, 1 );
            time_scalar = 3 * scale + 1;
            increment = var_6438c94358b161fd * time_scalar;
            uplink function_1053af7df2915763( ( 1 - min( 1, self.var_8a388b8f9721e802 * uplink.num_blockers ) ) * increment );
        }
        
        wait var_6438c94358b161fd;
    }
    
    uplink.scriptable setscriptablepartstate( "br_pe_dataheist_uplink_screen", "complete" );
    uplink.scriptable setscriptablepartstate( "br_pe_dataheist_uplink_useable", "complete" );
    event_add_score( uplink.controlling_team );
    uplink.scriptable function_f2a6dba6dd91c9ac();
    
    foreach ( player in uplink.controlling_players )
    {
        player thread function_eb7a97aa6ebe4899();
    }
    
    if ( uplink.obj_id != -1 )
    {
        objidpoolmanager::returnobjectiveid( uplink.obj_id );
        uplink.obj_id = undefined;
    }
    
    nearby_players = function_c276ebb859fbaf35();
    winners = [];
    losers = [];
    neutrals = [];
    
    foreach ( player in nearby_players )
    {
        if ( player.team == uplink.controlling_team )
        {
            winners[ winners.size ] = player;
            continue;
        }
        
        if ( isdefined( uplink.previous_owners[ player.team ] ) )
        {
            losers[ losers.size ] = player;
            continue;
        }
        
        neutrals[ neutrals.size ] = player;
    }
    
    uplink.scriptable thread function_afc8851f18de0ba3( winners );
    uplink.is_complete = 1;
    uplink notify( #"complete" );
    self notify( #"uplink_complete" );
    function_7bc9dcd485ff8173( uplink.controlling_team );
    wait 1;
    function_c438ab0a4b2c95f0( "dataheist_team_comp_uplink", winners, 2 );
    
    foreach ( player in winners )
    {
        player hud_message::showsplash( "br_pe_dataheist_success", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist" );
    }
    
    function_c438ab0a4b2c95f0( "dataheist_enemy_comp_lost_uplink", losers, 2 );
    function_c438ab0a4b2c95f0( "dataheist_enemy_comp_uplink", neutrals, 2 );
    uplink uplink_cleanup();
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xaf88399, Offset: 0x2ea8
// Size: 0xf8
function function_1053af7df2915763( increment )
{
    self.time += increment;
    self.progress = min( 1, self.time / self.capture_time_seconds );
    
    if ( isdefined( self.obj_id ) )
    {
        objective_setprogress( self.obj_id, self.progress );
    }
    
    foreach ( ent in self.trigger_ents )
    {
        if ( isplayer( ent ) )
        {
            ent setclientomnvar( "ui_publicevent_dataheist_progress", self.progress );
        }
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xab5df28d, Offset: 0x2fa8
// Size: 0x124
function function_860b616b99164e73()
{
    self endon( #"complete" );
    
    while ( true )
    {
        self waittill( #"activated", team );
        
        if ( team == self.controlling_team )
        {
            continue;
        }
        
        nearby_players = self.event function_a3a2be374004371c( self.controlling_team );
        function_c438ab0a4b2c95f0( "dataheist_enemy_cap_uplink", nearby_players, 2 );
        
        foreach ( player in nearby_players )
        {
            player hud_message::showsplash( "br_pe_dataheist_stolen", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist" );
        }
        
        function_7fb5642b42f6e992( team );
        nearby_players = self.event function_a3a2be374004371c( self.controlling_team );
        function_c438ab0a4b2c95f0( "dataheist_team_cap_uplink", nearby_players, 2 );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x51d02a0c, Offset: 0x30d4
// Size: 0x4f
function function_9de110ff608c6e51( data )
{
    if ( data.attacker.team == self.uplink.controlling_team )
    {
        return;
    }
    
    self.uplink.is_emp_applied = 1;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x588e6b4f, Offset: 0x312b
// Size: 0x21
function function_5f467687121699ac( from_death )
{
    self.uplink.is_emp_applied = 0;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xe0f631d2, Offset: 0x3154
// Size: 0xd9
function function_383f6437686fe44a()
{
    self endon( #"complete" );
    
    while ( true )
    {
        self.is_team_present = 0;
        self.num_blockers = 0;
        
        foreach ( ent in self.trigger_ents )
        {
            if ( ent vehicle::is_vehicle() )
            {
                continue;
            }
            
            if ( ent.team == self.controlling_team )
            {
                self.is_team_present = 1;
                continue;
            }
            
            self.num_blockers++;
        }
        
        waitframe();
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x219d821f, Offset: 0x3235
// Size: 0x188
function function_9c44b6c0c354cba8( progress_thresholds )
{
    event = self.event;
    
    foreach ( progress in progress_thresholds )
    {
        while ( self.progress < progress )
        {
            wait 1;
        }
        
        requests = undefined;
        rushersalive = function_69556b082b8eca1f();
        
        if ( event.var_cef6aa54b40dae7f && rushersalive < event.var_d1e5e20dbe8ef34b )
        {
            max_rushers = int( min( event.var_d1e5e20dbe8ef34b - rushersalive, event.var_639e4a2f54067e65 ) ) + 1;
            requests = function_867511513b84664b( event.var_2a1e1c8695b7ed79, randomintrange( event.var_ca88da390cc665e7, max_rushers ), event.ai_rusher_tier );
        }
        else
        {
            requests = function_bbd30f5fdf3cade7( event.var_2a1e1c8695b7ed79 );
        }
        
        thread agents_spawn_group( requests, [ "safe", "para" ], function_a20a92a8727958a2( 0 ) );
        function_c438ab0a4b2c95f0( "dataheist_ai_spawn", self.nearby_players, 5 );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xe75d3baf, Offset: 0x33c5
// Size: 0x1ac
function function_7fb5642b42f6e992( team )
{
    self.scriptable function_39e11fed38ead6ec( team );
    self.controlling_team = team;
    self.controlling_players = teams::getteamdata( team, "players" );
    
    if ( !isdefined( self.previous_owners[ team ] ) )
    {
        self.previous_owners[ team ] = 1;
    }
    
    foreach ( player in self.controlling_players )
    {
        player hud_message::showsplash( "br_pe_dataheist_defend", undefined, undefined, undefined, undefined, "splash_list_br_pe_dataheist" );
    }
    
    foreach ( ent in self.trigger_ents )
    {
        if ( isplayer( ent ) )
        {
            if ( ent.team == self.controlling_team )
            {
                function_d50c91a5711a6b9e( ent );
                continue;
            }
            
            function_6adf5b4ea51517( ent );
        }
    }
    
    if ( isdefined( self.obj_id ) )
    {
        objective_setprogressteam( self.obj_id, self.controlling_team );
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xa0dbe877, Offset: 0x3579
// Size: 0x141
function uplink_cleanup()
{
    foreach ( ent in self.trigger_ents )
    {
        if ( isplayer( ent ) )
        {
            ent setclientomnvar( "ui_publicevent_dataheist_state", 0 );
            ent setclientomnvar( "ui_publicevent_dataheist_progress", 0 );
        }
    }
    
    if ( isdefined( self.map_circle ) )
    {
        self.map_circle delete();
    }
    
    if ( !self.is_complete && isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    if ( isdefined( self.obj_id ) && self.obj_id != -1 )
    {
        objidpoolmanager::returnobjectiveid( self.obj_id );
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger notify( #"destroy" );
        self.trigger delete();
    }
    
    self notify( #"cleanup" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xd7b1da5, Offset: 0x36c2
// Size: 0x180
function function_9534aaab7e83d0e8()
{
    level endon( #"game_ended" );
    self endon( #"cleanup" );
    
    while ( isdefined( self.trigger ) )
    {
        self.trigger waittill( #"trigger", ent );
        ent_id = ent getentitynumber();
        
        if ( isdefined( self.trigger_ents[ ent_id ] ) )
        {
            continue;
        }
        
        if ( !isplayer( ent ) && !isagent( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::get_all_occupants( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) || isagent( occupant ) )
                {
                    occupant_id = occupant getentitynumber();
                    
                    if ( isdefined( self.trigger_ents[ occupant_id ] ) )
                    {
                        continue;
                    }
                    
                    self.trigger_ents[ occupant_id ] = occupant;
                    occupant thread uplink_trigger_touch_think( self );
                }
            }
            
            continue;
        }
        
        self.trigger_ents[ ent_id ] = ent;
        ent thread uplink_trigger_touch_think( self );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xb6d3cba9, Offset: 0x384a
// Size: 0xbc
function uplink_trigger_touch_think( uplink )
{
    level endon( #"game_ended" );
    uplink endon( #"cleanup" );
    
    if ( isplayer( self ) )
    {
        uplink function_6c92ccb15faf94c7( self );
    }
    
    while ( player::isreallyalive( self ) )
    {
        if ( isdefined( self.vehicle ) )
        {
            if ( !self.vehicle istouching( uplink.trigger ) )
            {
                break;
            }
        }
        else if ( !self istouching( uplink.trigger ) )
        {
            break;
        }
        
        waitframe();
    }
    
    ent_id = self getentitynumber();
    uplink.trigger_ents[ ent_id ] = undefined;
    
    if ( isplayer( self ) )
    {
        uplink function_b410010623ce3006( self );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xe4b08b8f, Offset: 0x390e
// Size: 0xa2
function function_6c92ccb15faf94c7( player )
{
    if ( isdefined( player.team ) && !isdefined( self.seen_teams[ player.team ] ) )
    {
        self.seen_teams[ player.team ] = 1;
        
        if ( isdefined( self.obj_id ) )
        {
            objective_addteamtomask( self.obj_id, player.team );
        }
    }
    
    if ( self.is_active && player.team == self.controlling_team )
    {
        function_d50c91a5711a6b9e( player );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x53845264, Offset: 0x39b8
// Size: 0x15
function function_b410010623ce3006( player )
{
    function_6adf5b4ea51517( player );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xc6435b94, Offset: 0x39d5
// Size: 0x53
function function_d50c91a5711a6b9e( player )
{
    if ( isdefined( self.obj_id ) )
    {
        objective_hideprogressforclient( self.obj_id, player );
    }
    
    player setclientomnvar( "ui_publicevent_dataheist_state", self.capture_state );
    player setclientomnvar( "ui_publicevent_dataheist_progress", self.progress );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xe148dcb9, Offset: 0x3a30
// Size: 0x36
function function_6adf5b4ea51517( player )
{
    if ( isdefined( self.obj_id ) )
    {
        objective_showprogressforclient( self.obj_id, player );
    }
    
    player setclientomnvar( "ui_publicevent_dataheist_state", 0 );
}

// Namespace br_publicevent_dataheist
// Params 6
// Checksum 0xbf426f23, Offset: 0x3a6e
// Size: 0xa7
function uplink_scriptable_used( instance, part, state, player, bautouse, usestring )
{
    if ( instance.var_62089e4862e22b3b )
    {
        if ( getdvarint( @"hash_ed4efe8df2b29df0", 1 ) )
        {
            br_circle_peek::function_6de0d379275546d1( player.team );
        }
        
        instance thread function_5141637bcee95bec();
        return;
    }
    
    if ( isdefined( instance.uplink ) )
    {
        instance.uplink notify( #"activated", player.team );
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xb2651bcb, Offset: 0x3b1d
// Size: 0xa0
function function_39e11fed38ead6ec( team )
{
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            self disablescriptableplayeruse( player );
            continue;
        }
        
        self enablescriptableplayeruse( player );
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x4472dc59, Offset: 0x3bc5
// Size: 0x2
function __uplink_rewards()
{
    
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x48f4ccb3, Offset: 0x3bcf
// Size: 0x11c
function function_f2a6dba6dd91c9ac()
{
    self.var_62089e4862e22b3b = 1;
    uplink = self.uplink;
    event = uplink.event;
    score = event function_a3eb3ebe56566484( uplink.controlling_team );
    team_size = game_utility::function_f24780eadd3fb772();
    self.loot = [];
    self.loot = function_44ef880a0b4877f3( event, score, team_size );
    
    foreach ( player in level.players )
    {
        if ( player.team != uplink.controlling_team )
        {
            self disablescriptableplayeruse( player );
            continue;
        }
        
        self enablescriptableplayeruse( player );
    }
}

// Namespace br_publicevent_dataheist
// Params 3
// Checksum 0xdd869c6b, Offset: 0x3cf3
// Size: 0x1cc
function function_44ef880a0b4877f3( event, score, team_size )
{
    a_loot = [];
    
    switch ( score )
    {
        case 3:
            a_loot[ a_loot.size ] = [ "brloot_killstreak_auav", 1 ];
            
            if ( utility::cointoss() && getdvarint( @"hash_9264f8f1143934c6", 0 ) && namespace_5ab67a14d18bea3f::function_cdd20dc4a098f17() )
            {
                perkpacks = [ "brloot_perkpack_beret_br", "brloot_perkpack_insurgent_br", "brloot_perkpack_demolitionist_br", "brloot_perkpack_reserves_br", "brloot_perkpack_swat_br" ];
                a_loot[ a_loot.size ] = [ utility::array_random( perkpacks ), 1 ];
            }
            else if ( getdvarint( @"hash_368ea569c1a6a4e4", 1 ) )
            {
                var_57d422f5d5e45f = [ "brloot_plate_carrier_tempered" ];
                a_loot[ a_loot.size ] = [ utility::array_random( var_57d422f5d5e45f ), 1 ];
            }
        case 2:
            assertmsg( "<dev string:x15f>" );
        case 1:
            if ( score == 1 || score == 2 )
            {
                a_loot[ a_loot.size ] = [ "brloot_killstreak_uav", 1 ];
            }
            
            plunder_name = br_plunder::getplundernamebyamount( event.var_4f21c4b0ec894c6b );
            
            for ( i = 0; i < team_size ; i++ )
            {
                a_loot[ a_loot.size ] = [ plunder_name, event.var_4f21c4b0ec894c6b ];
            }
            
            a_loot[ a_loot.size ] = [ "brloot_super_armorbox" ];
            a_loot[ a_loot.size ] = [ "brloot_super_munitionsbox" ];
            break;
    }
    
    return a_loot;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x46de2c34, Offset: 0x3ec8
// Size: 0x127
function function_5141637bcee95bec()
{
    foreach ( item in self.loot )
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( item[ 0 ], item[ 1 ], spawnoptions );
    }
    
    if ( isdefined( self.uplink.reward_obj_id ) && self.uplink.reward_obj_id != -1 )
    {
        objidpoolmanager::returnobjectiveid( self.uplink.reward_obj_id );
    }
    
    self setscriptablepartstate( "br_pe_dataheist_uplink_useable", "pickup" );
    self setscriptablepartstate( "br_pe_dataheist_uplink_screen", "hidden" );
    self notify( #"uplink_looted" );
    wait 1;
    self freescriptable();
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x16ad349d, Offset: 0x3ff7
// Size: 0x22c
function function_afc8851f18de0ba3( winners )
{
    level endon( #"game_ended" );
    self endon( #"uplink_looted" );
    self.uplink.reward_obj_id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.uplink.reward_obj_id > -1 )
    {
        objidpoolmanager::objective_add_objective( self.uplink.reward_obj_id, "current", self.uplink.origin, "ui_map_icon_obj_sealion_sidequest_reward" );
        objective_removeallfrommask( self.uplink.reward_obj_id );
        objective_showtoplayersinmask( self.uplink.reward_obj_id );
        objective_setbackground( self.uplink.reward_obj_id, 1 );
        objective_setplayintro( self.uplink.reward_obj_id, 0 );
        objective_position( self.uplink.reward_obj_id, self.uplink.origin + ( 0, 0, 20 ) );
        objective_setdescription( self.uplink.reward_obj_id, &"mp_br_ingame/reward_icon_name_dataheist" );
    }
    
    foreach ( player in winners )
    {
        objective_addclienttomask( self.uplink.reward_obj_id, player );
    }
    
    thread function_e1c45e2d69245838();
    objidpoolmanager::objective_set_pulsate( self.uplink.reward_obj_id, 1 );
    wait self.uplink.event.var_4e57efc9b783e5bc;
    objidpoolmanager::objective_set_pulsate( self.uplink.reward_obj_id, 0 );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xe16f9a42, Offset: 0x422b
// Size: 0xc8
function function_e1c45e2d69245838()
{
    level endon( #"game_ended" );
    self endon( #"uplink_looted" );
    uplink_timeline = br_circle_util::function_472c93858e491e0a( self.origin );
    reward_id = self.uplink.reward_obj_id;
    time_to_wait = self.uplink.event.var_c67748f877c9ddca;
    self.uplink.event waittill( #"event_deactivated" );
    uplink_hit_time = br_circle_util::function_b880c0f9998fdd69( uplink_timeline );
    
    if ( uplink_hit_time < time_to_wait )
    {
        wait uplink_hit_time;
    }
    else
    {
        wait time_to_wait;
    }
    
    objidpoolmanager::update_objective_state( reward_id, "active" );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x172f916c, Offset: 0x42fb
// Size: 0x2
function __agents()
{
    
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x327913e8, Offset: 0x4305
// Size: 0x55
function function_bbd30f5fdf3cade7( num_agents )
{
    requests = [];
    
    for ( i = 0; i < num_agents ; i++ )
    {
        ai_type = ai_mp_controller::function_e0390bd2e60129e2( "guard" );
        requests[ i ] = ai_reinforcements::function_f5e5b01238f335a0( ai_type );
    }
    
    return requests;
}

// Namespace br_publicevent_dataheist
// Params 3
// Checksum 0xcb5fe416, Offset: 0x4363
// Size: 0x8d
function function_867511513b84664b( num_agents, num_rushers, rusher_tier )
{
    requests = [];
    tier = 1;
    
    for ( i = 0; i < num_agents ; i++ )
    {
        if ( i >= num_rushers )
        {
            ai_type = ai_mp_controller::function_e0390bd2e60129e2( "guard" );
            tier = 1;
        }
        else
        {
            ai_type = "rusher";
            tier = rusher_tier;
        }
        
        requests[ i ] = ai_reinforcements::function_f5e5b01238f335a0( ai_type, tier );
    }
    
    return requests;
}

// Namespace br_publicevent_dataheist
// Params 3
// Checksum 0x4b7da3c8, Offset: 0x43f9
// Size: 0x182
function agents_spawn_group( requests, reinforcement_types, params )
{
    if ( requests.size < 1 )
    {
        return;
    }
    
    agents = br_agent_utils::spawn_reinforcements( self.origin, requests, reinforcement_types, params );
    assert( agents.size > 0, "<dev string:x1bf>" );
    waitframe();
    
    foreach ( agent in agents )
    {
        assert( isdefined( agent ), "<dev string:x1f0>" );
        assert( !isint( agent ), "<dev string:x230>" );
        
        if ( issubstr( agent.agent_type, "rusher" ) || agent.animsetname == "rusher" )
        {
            agent.pathenemyfightdist = 0;
            
            if ( isdefined( agent.var_723fc92f02f8190f ) )
            {
                [[ agent.var_723fc92f02f8190f ]]( self.origin, 1000 );
            }
        }
        
        agent.dropweapon = 0;
        agent.dropgrenade = 0;
    }
    
    self.agents = arraycombine( self.agents, agents );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0xbc53218d, Offset: 0x4583
// Size: 0x7e
function function_a20a92a8727958a2( force_closest )
{
    params = spawnstruct();
    params.ai_category = "dataheist";
    params.ai_priority = "high";
    params.safe_spawn_distance = 1500;
    params.safe_spawn_radius = 500;
    params.safe_spawn_squad_size = 5;
    params.force_closest = force_closest ?? 0;
    return params;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xa961779a, Offset: 0x460a
// Size: 0xf1
function function_69556b082b8eca1f()
{
    rushercount = 0;
    agents = self.agents;
    
    if ( !isdefined( agents ) || agents.size <= 0 )
    {
        println( "<dev string:x266>" + self.loc_name );
    }
    else
    {
        foreach ( agent in agents )
        {
            if ( !utility::is_dead_or_dying( agent ) && ( issubstr( agent.agent_type, "rusher" ) || agent.animsetname == "rusher" ) )
            {
                rushercount++;
            }
        }
    }
    
    return rushercount;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xc7d8e260, Offset: 0x4704
// Size: 0x2
function __dialog()
{
    
}

// Namespace br_publicevent_dataheist
// Params 2
// Checksum 0xdb0fd0f3, Offset: 0x470e
// Size: 0x29
function dialog_play_all( dialog, delay )
{
    function_c438ab0a4b2c95f0( dialog, level.players, delay );
}

// Namespace br_publicevent_dataheist
// Params 3
// Checksum 0x6cad3c1e, Offset: 0x473f
// Size: 0xbe
function function_c438ab0a4b2c95f0( dialog, players, delay )
{
    sound_name = game[ "dialog" ][ dialog ];
    assert( isdefined( sound_name ), "<dev string:x296>" + dialog );
    
    foreach ( player in players )
    {
        level thread br_public::brleaderdialogplayer( dialog, player, undefined, undefined, delay, undefined );
    }
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x6b912d8, Offset: 0x4805
// Size: 0x2
function __util()
{
    
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x35f002ce, Offset: 0x480f
// Size: 0xd5
function function_a3a2be374004371c( team )
{
    players = teams::getteamdata( team, "players" );
    nearby_players = [];
    dist_sq = squared( self.var_f36f8df94fbdbd2c );
    
    foreach ( player in players )
    {
        if ( distance2dsquared( player.origin, self.midpoint ) <= dist_sq )
        {
            nearby_players[ nearby_players.size ] = player;
        }
    }
    
    return nearby_players;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x969857ea, Offset: 0x48ed
// Size: 0x40
function function_c049fcff41fc54d3( team )
{
    team_players = teams::getteamdata( team, "players" );
    return player_utility::script_getplayersinradius( self.midpoint, self.var_f36f8df94fbdbd2c, undefined, team_players );
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xc2d97885, Offset: 0x4936
// Size: 0x1a
function function_c276ebb859fbaf35()
{
    return player_utility::script_getplayersinradius( self.midpoint, self.var_f36f8df94fbdbd2c );
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x4b1df76b, Offset: 0x4959
// Size: 0xa1
function function_7fa1ce4adffc7cfe( team )
{
    members = [];
    
    foreach ( player in self.nearby_players )
    {
        if ( player.team == team )
        {
            members[ members.size ] = player;
        }
    }
    
    return members;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x7cb0078b, Offset: 0x4a03
// Size: 0x34, Type: bool
function function_b31080d6b9826a85( point )
{
    return point.is_valid && point.valid_neighbors.size >= self.var_71b42be63cc105b5 - 1;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0xe34509a8, Offset: 0x4a40
// Size: 0x91
function function_17148716995cc5c7()
{
    valid_points = [];
    
    foreach ( point in self.uplink_points )
    {
        if ( function_b31080d6b9826a85( point ) )
        {
            valid_points[ valid_points.size ] = point;
        }
    }
    
    return valid_points;
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x3e9b3a5f, Offset: 0x4ada
// Size: 0x452
function function_bfb2434155e89118( event_duration )
{
    foreach ( point in self.uplink_points )
    {
        point.valid_neighbors = [];
        point.is_valid = 1;
        
        if ( point.used )
        {
            point.is_valid = 0;
            
            /#
                point.status = "<dev string:x2ce>";
            #/
            
            continue;
        }
        
        if ( !level.br_circle_disabled && isdefined( level.br_circle ) )
        {
            circle_timeline = br_circle_util::function_472c93858e491e0a( point.origin );
            hit_time = br_circle_util::function_b880c0f9998fdd69( circle_timeline );
            
            if ( hit_time < event_duration )
            {
                point.is_valid = 0;
                
                /#
                    point.status = "<dev string:x2f5>" + hit_time + "<dev string:x316>";
                #/
                
                continue;
            }
        }
        
        /#
            point.status = "<dev string:x31f>";
        #/
    }
    
    for ( i = 0; i < self.uplink_points.size ; i++ )
    {
        point_i = self.uplink_points[ i ];
        
        if ( !point_i.is_valid )
        {
            continue;
        }
        
        for ( j = i + 1; j < self.uplink_points.size ; j++ )
        {
            point_j = self.uplink_points[ j ];
            
            if ( !point_j.is_valid )
            {
                continue;
            }
            
            dist = distance2dsquared( point_i.origin, point_j.origin );
            
            if ( dist > self.var_255bee1cd75c18f5 && dist < self.var_33bf8c9847d7f863 )
            {
                point_i.valid_neighbors[ point_i.valid_neighbors.size ] = point_j;
                point_j.valid_neighbors[ point_j.valid_neighbors.size ] = point_i;
            }
        }
    }
    
    /#
        dump = dump_new( "<dev string:x326>" );
        dump dump_add_line( "<dev string:x345>" + event_duration + "<dev string:x316>" );
        dump dump_add_line( "<dev string:x356>" );
        good_starts = [];
        
        foreach ( index, point in self.uplink_points )
        {
            if ( !isdefined( good_starts[ point.group ] ) )
            {
                good_starts[ point.group ] = 0;
            }
            
            if ( function_b31080d6b9826a85( point ) )
            {
                good_starts[ point.group ] += 1;
            }
            
            dump dump_add_line( "<dev string:x36c>" + index + "<dev string:x36e>" + point.group + "<dev string:x372>" + point.status );
            
            if ( point.is_valid )
            {
                dump dump_add( "<dev string:x37e>" + point.valid_neighbors.size );
            }
        }
        
        keys = getarraykeys( good_starts );
        
        foreach ( key in keys )
        {
            dump dump_add_line( key + "<dev string:x393>" + good_starts[ key ] );
        }
        
        dump dump_print();
    #/
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x19e2c10f, Offset: 0x4f34
// Size: 0x6a
function function_540599e5b88a00c3( state )
{
    switch ( state )
    {
        case 1:
            return &"mp_br_pe_dataheist/capture_state_downloading";
        case 2:
            return &"mp_br_pe_dataheist/capture_state_interference";
        case 3:
            return &"mp_br_pe_dataheist/capture_state_blocked";
        default:
            return "!! INVALID STATE !!";
    }
}

// Namespace br_publicevent_dataheist
// Params 1
// Checksum 0x79beaa13, Offset: 0x4fa6
// Size: 0x101
function function_e5d66397948cf0e8( points_string )
{
    points = [];
    
    if ( !isdefined( points_string ) )
    {
        return points;
    }
    
    point_string_array = strtok( points_string, "," );
    
    foreach ( point_string in point_string_array )
    {
        point_int = int( point_string );
        
        if ( isint( point_int ) && point_int >= 0 && point_int < self.uplink_points.size )
        {
            points[ points.size ] = point_int;
            continue;
        }
        
        /#
            iprintlnbold( "<dev string:x397>" + point_string + "<dev string:x3bb>" + self.uplink_points.size - 1 );
        #/
    }
    
    return points;
}

// Namespace br_publicevent_dataheist
// Params 0
// Checksum 0x74329cb7, Offset: 0x50b0
// Size: 0x11
function function_eb7a97aa6ebe4899()
{
    challenges::function_37e945722d6497f3( self, "dataheist_uplink_complete", 1 );
}

/#

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x106c7044, Offset: 0x50c9
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x6403dc09, Offset: 0x50d6
    // Size: 0x120, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3e9>" );
        devgui::add_devgui_func( "<dev string:x405>", "<dev string:x411>", &debug_start_event );
        devgui::add_devgui_func( "<dev string:x427>", "<dev string:x432>", &debug_stop_event );
        devgui::add_devgui_func( "<dev string:x447>", "<dev string:x457>", &debug_spawn_scriptable );
        devgui::add_devgui_func( "<dev string:x477>", "<dev string:x48a>", &debug_reload_dvars );
        devgui::add_devgui_func( "<dev string:x4a7>", "<dev string:x4bd>", &function_b22d976ab4eb50dc );
        devgui::add_devgui_func( "<dev string:x4e3>", "<dev string:x4f7>", &function_67216335fe00ca53 );
        devgui::add_devgui_func( "<dev string:x51b>", "<dev string:x535>", &function_10cacd1d44d54953 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x555>", "<dev string:x56c>", &function_e76c3d861e12818 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x599>", "<dev string:x5b0>", &function_e76c3d861e12818 );
        devgui::add_devgui_func( "<dev string:x5dd>", "<dev string:x5f7>", &function_17972a5fbe1e5927 );
        devgui::add_devgui_func( "<dev string:x61b>", "<dev string:x634>", &function_bc5671de41d8560 );
        devgui::add_devgui_func( "<dev string:x658>", "<dev string:x66c>", &function_d558c3d7ae830589 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x2e49ce08, Offset: 0x51fe
    // Size: 0x35, Type: dev
    function debug_reload_dvars()
    {
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        init_dvars( event_data );
    }

    // Namespace br_publicevent_dataheist
    // Params 1
    // Checksum 0xd271266a, Offset: 0x523b
    // Size: 0x56, Type: dev
    function function_e76c3d861e12818( params )
    {
        if ( !( isdefined( params[ 0 ] ) && isdefined( params[ 1 ] ) ) )
        {
            return;
        }
        
        value = int( params[ 1 ] );
        
        if ( !isint( value ) )
        {
            return;
        }
        
        setdvar( hashcat( @"hash_7805fcacedd1cf62", params[ 0 ] ), value );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xd7b7897f, Offset: 0x5299
    // Size: 0x16, Type: dev
    function debug_start_event()
    {
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"dataheist" );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xe4522b62, Offset: 0x52b7
    // Size: 0x16, Type: dev
    function debug_stop_event()
    {
        level thread br_publicevents::function_a1af4e372c2ecc3( %"dataheist" );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x79c3ee91, Offset: 0x52d5
    // Size: 0x35, Type: dev
    function debug_spawn_scriptable()
    {
        spawnscriptable( "<dev string:x690>", level.player.origin, level.player.angles );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x27592879, Offset: 0x5312
    // Size: 0x19, Type: dev
    function function_58216cd834be61bd()
    {
        level notify( #"hash_b68d91e3900c9cc" );
        level thread function_ccbeadebfcaafd7c();
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x3d763036, Offset: 0x5333
    // Size: 0x11, Type: dev
    function function_fc241791fbab5584()
    {
        level notify( #"hash_b68d91e3900c9cc" );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x7221fd66, Offset: 0x534c
    // Size: 0x2d6, Type: dev
    function function_ccbeadebfcaafd7c()
    {
        level endon( #"game_ended" );
        level endon( #"hash_b68d91e3900c9cc" );
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        position_offset = ( 0, 0, 40 );
        position_offset_decrement = ( 0, 0, 4 );
        scale = 0.25;
        color_active = ( 0, 1, 0 );
        color_blocked = ( 1, 0.65, 0 );
        color_range = ( 0.25, 0.25, 0.25 );
        color = undefined;
        print_duration = 1;
        print_duration_frames = int( print_duration / level.framedurationseconds );
        
        while ( true )
        {
            if ( !event_data.active )
            {
                function_fc241791fbab5584();
            }
            
            foreach ( uplink in event_data.uplinks )
            {
                if ( !uplink.is_team_present )
                {
                    color = color_range;
                }
                else if ( uplink.num_blockers > 0 )
                {
                    color = color_blocked;
                }
                else
                {
                    color = color_active;
                }
                
                print3d( uplink.origin + position_offset - position_offset_decrement * 0, "<dev string:x6a7>" + uplink.origin, color, 1, scale, print_duration_frames, 1 );
                print3d( uplink.origin + position_offset - position_offset_decrement * 1, "<dev string:x6b0>" + uplink.angles, color, 1, scale, print_duration_frames, 1 );
                print3d( uplink.origin + position_offset - position_offset_decrement * 2, "<dev string:x6b9>" + uplink.controlling_team, color, 1, scale, print_duration_frames, 1 );
                print3d( uplink.origin + position_offset - position_offset_decrement * 3, "<dev string:x6c0>" + uplink.progress * 100 + "<dev string:x6cb>", color, 1, scale, print_duration_frames, 1 );
                
                if ( uplink.num_blockers > 0 )
                {
                    print3d( uplink.origin + position_offset - position_offset_decrement * 4, "<dev string:x6cd>" + uplink.num_blockers + "<dev string:x6d9>", color, 1, scale, print_duration_frames, 1 );
                }
            }
            
            wait print_duration;
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xb72cfe93, Offset: 0x562a
    // Size: 0x1d8, Type: dev
    function function_d558c3d7ae830589()
    {
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        event_duration_seconds = event_data.event_duration_seconds;
        
        if ( !level.br_circle_disabled )
        {
            event_duration_seconds = min( event_data.event_duration_seconds, br_circle::function_f30ad5eda1a16d44() - 5 );
        }
        
        event_data function_bfb2434155e89118( event_duration_seconds );
        points = [];
        valid_start_points = event_data function_17148716995cc5c7();
        points[ 0 ] = utility::array_random( valid_start_points );
        nearby_points = arrayrandomize( points[ 0 ].valid_neighbors );
        
        for ( i = 0; i < event_data.var_71b42be63cc105b5 - 1 ; i++ )
        {
            points[ i + 1 ] = nearby_points[ i ];
        }
        
        print_duration = 5;
        print_duration_frames = int( print_duration / level.framedurationseconds );
        last_point = undefined;
        
        foreach ( point in points )
        {
            sphere( point.origin, 100, ( 0, 1, 0 ), 0, print_duration_frames );
            
            if ( isdefined( last_point ) )
            {
                line( point.origin, last_point.origin, ( 0, 1, 0 ), 1, 0, print_duration_frames );
            }
            
            last_point = point;
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x8cc4cb13, Offset: 0x580a
    // Size: 0x19, Type: dev
    function function_17972a5fbe1e5927()
    {
        level notify( #"hash_4e4f1689aab8c90e" );
        level thread function_c11fe4cf4c390f02();
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x4a18efdf, Offset: 0x582b
    // Size: 0x11, Type: dev
    function function_bc5671de41d8560()
    {
        level notify( #"hash_4e4f1689aab8c90e" );
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xd862244b, Offset: 0x5844
    // Size: 0x281, Type: dev
    function function_c11fe4cf4c390f02()
    {
        level endon( #"game_ended" );
        level endon( #"hash_4e4f1689aab8c90e" );
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        position_offset = ( 0, 0, 40 );
        position_offset_increment = ( 0, 0, 4 );
        scale = 0.25;
        valid_color = ( 0, 1, 0 );
        invalid_color = ( 1, 0, 0 );
        color = undefined;
        print_duration = 5;
        print_duration_frames = int( print_duration / level.framedurationseconds );
        halfheight = event_data.var_e11138a30c20d625 * 0.5;
        
        while ( true )
        {
            foreach ( point in event_data.uplink_points )
            {
                color = point.is_valid ? valid_color : invalid_color;
                print3d( point.origin + position_offset + position_offset_increment * 3, "<dev string:x6e2>" + point.id, color, 1, scale, print_duration_frames, 1 );
                print3d( point.origin + position_offset + position_offset_increment * 2, "<dev string:x6f4>" + point.group, color, 1, scale, print_duration_frames, 1 );
                print3d( point.origin + position_offset + position_offset_increment * 1, "<dev string:x6fc>" + point.status, color, 1, scale, print_duration_frames, 1 );
                cylinder( point.origin - ( 0, 0, halfheight ), point.origin + ( 0, 0, halfheight ), event_data.var_1e46a595500a537c, color, 0, print_duration_frames );
                utility::draw_circle( point.origin, event_data.var_9db700184e765b31, color, 1, 0, print_duration_frames );
            }
            
            wait print_duration;
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xa22aabc1, Offset: 0x5acd
    // Size: 0xae, Type: dev
    function function_b22d976ab4eb50dc()
    {
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        foreach ( uplink in event_data.uplinks )
        {
            uplink notify( #"activated", "<dev string:x70d>" );
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x7c791640, Offset: 0x5b83
    // Size: 0xc8, Type: dev
    function function_67216335fe00ca53()
    {
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        team = level.player.team;
        
        foreach ( uplink in event_data.uplinks )
        {
            uplink notify( #"activated", team );
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x7a460961, Offset: 0x5c53
    // Size: 0xea, Type: dev
    function function_10cacd1d44d54953()
    {
        event_data = level.br_pe_data[ %"dataheist" ];
        
        if ( !isdefined( event_data ) )
        {
            return;
        }
        
        event_data function_db94439ed60145a0();
        event_data.var_5738c8d1ca0f0f8 = [];
        
        foreach ( point in event_data.uplink_points )
        {
            event_data.var_5738c8d1ca0f0f8[ event_data.var_5738c8d1ca0f0f8.size ] = spawnscriptable( "<dev string:x690>", point.origin, point.angles );
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0xa735cbe0, Offset: 0x5d45
    // Size: 0x89, Type: dev
    function function_db94439ed60145a0()
    {
        if ( isdefined( self.var_5738c8d1ca0f0f8 ) )
        {
            foreach ( scriptable in self.var_5738c8d1ca0f0f8 )
            {
                scriptable freescriptable();
            }
        }
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x9fb3d15e, Offset: 0x5dd6
    // Size: 0x5, Type: dev
    function __dump()
    {
        
    }

    // Namespace br_publicevent_dataheist
    // Params 1
    // Checksum 0x52068703, Offset: 0x5de3
    // Size: 0x41, Type: dev
    function dump_new( title )
    {
        dump = spawnstruct();
        dump.title = title;
        dump.msg = "<dev string:x24>";
        return dump;
    }

    // Namespace br_publicevent_dataheist
    // Params 0
    // Checksum 0x106cbbf0, Offset: 0x5e2c
    // Size: 0x37, Type: dev
    function dump_print()
    {
        println( "<dev string:x726>" + self.title + "<dev string:x737>" );
        println( self.msg );
        println( "<dev string:x747>" );
    }

    // Namespace br_publicevent_dataheist
    // Params 1
    // Checksum 0x3416a4d5, Offset: 0x5e6b
    // Size: 0x24, Type: dev
    function dump_add( text )
    {
        self.msg += text;
    }

    // Namespace br_publicevent_dataheist
    // Params 1
    // Checksum 0x47e2bd3e, Offset: 0x5e97
    // Size: 0x1e, Type: dev
    function dump_add_line( text )
    {
        dump_add( "<dev string:x76a>" + text );
    }

#/
