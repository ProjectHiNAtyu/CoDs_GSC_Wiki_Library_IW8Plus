// script_29871df07c78c83d  (hash_29871df07c78c83d.gscc) (size: 22623 Bytes / 0x585f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcca4f05a (3433361498)
// size ...... 22623 (0x585f)
// includes .. 23  (offset: 0x4eeb)
// strings ... 76  (offset: 0x4fa3)
// dev strs .. 77  (offset: 0x5483)
// exports ... 38  (offset: 0x3653)
// cseg ...... 0x5b0 + 0x30a3 (0x3653)
// imports ... 146 (offset: 0x3c43)
// animtree1 . 0   (offset: 0x585f)
// animtree2 . 0   (offset: 0x585f)
#using script_2528fc84e11f3e4b;
#using scripts\anim\utility;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;

#namespace activity_blight_finale;

// Namespace activity_blight_finale
// Params 0, eflags: 0x5
// Checksum 0x19387c1, Offset: 0x5ce
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_blight_finale", #"activity_common", &function_2e8a5c986bf29933, undefined );
}

// Namespace activity_blight_finale
// Params 0, eflags: 0x4
// Checksum 0x3fe2711, Offset: 0x5f7
// Size: 0x13
function private function_2e8a5c986bf29933()
{
    activity_common::registeractivitytype( "BLIGHT_FINALE", &activity_type_init );
}

// Namespace activity_blight_finale
// Params 0
// Checksum 0xe1fcef2b, Offset: 0x612
// Size: 0x96
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BLIGHT_FINALE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BLIGHT_FINALE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BLIGHT_FINALE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BLIGHT_FINALE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BLIGHT_FINALE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BLIGHT_FINALE" );
    scriptable::scriptable_addusedcallbackbypart( "usable", &function_898b3d850622a79b );
    scriptable::scriptable_adddamagedcallback( &function_418e7b91bcce5309 );
}

// Namespace activity_blight_finale
// Params 0
// Checksum 0x6b3198f, Offset: 0x6b0
// Size: 0x257
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.reference_clip = getent( "blight_bomb_collision", #targetname );
    self.bomb_structs = activity_instance_common::function_c78d8509d1f980d4( self, 0, "blight_finale_bomb" );
    self.bomb_structs = utility::array_sort_by_script_index( self.bomb_structs );
    self.bomb_health_max = getdvarint( @"hash_1da7f28f9ee6f758", 3000 );
    self.var_6b962bbdb9bd737b = getdvarfloat( @"hash_a72769e86abc4293", 90 );
    self.bomb_search_type = getdvarfloat( @"hash_6d7b8ccf453f64dc", 1 );
    self.var_fdcf83b5c199cd72 = getdvarfloat( @"hash_214404b5f656ee2a", 30 );
    game[ "dialog" ][ "dna_bomb_armed_survivors" ] = "dx_br_msmt_giin_haan_dbas";
    game[ "dialog" ][ "dna_bomb_armed_zombies" ] = "dx_br_msmt_giin_haan_dbaz";
    game[ "dialog" ][ "dna_bomb_protect_nag" ] = "dx_br_msmt_giin_haan_dbpn";
    game[ "dialog" ][ "dna_bomb_destroyed" ] = "dx_br_msmt_giin_haan_dbde";
    game[ "dialog" ][ "dna_bomb_detonated" ] = "dx_br_msmt_giin_haan_dbdt";
    level val::group_register( #"hash_87eae70de8f72d2b", [ "usability", "weapon_pickup", "supers", "allow_scripted_bgb_use", "gesture", "killstreaks", "equipment_primary", "equipment_secondary", "damage", "fire", "ads", "allow_battlechatter_vo", "breath_system", "allow_wall_jump", "death" ] );
    level val::group_register( #"hash_be92df7bff51ba4", [ "usability", "weapon_pickup", "supers", "allow_scripted_bgb_use", "gesture", "killstreaks", "equipment_primary", "equipment_secondary", "fire", "ads", "allow_battlechatter_vo", "breath_system", "allow_wall_jump" ] );
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    
    /#
        init_debug();
    #/
}

// Namespace activity_blight_finale
// Params 0
// Checksum 0xdfdf455b, Offset: 0x90f
// Size: 0x3d7
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    activity_definition_utils::function_16b3cfd89a1669f7( 1, self );
    self.best_bomb = function_9ccce02a17ab2820();
    
    if ( !self.best_bomb )
    {
        self.best_bomb = utility::array_random( self.bomb_structs );
    }
    
    /#
        if ( level.debug_blight_finale.var_41b73193fc6a949d )
        {
            self.best_bomb = level.debug_blight_finale.var_41b73193fc6a949d;
        }
    #/
    
    bomb = spawnscriptable( "saw_blight_finale_bomb", self.best_bomb.origin, self.best_bomb.angles );
    bomb.activity_instance = self;
    bomb.health = self.bomb_health_max;
    bomb.activated = 0;
    bomb.destroyed = 0;
    self.active_bomb = bomb;
    bomb setscriptablepartstate( "fx", "spawned" );
    bomb setscriptablepartstate( "anim", "closed" );
    bomb setscriptablepartstate( "health", "health" );
    bomb setscriptablepartstate( "usable", "unusable" );
    bomb.navbounds = createnavobstaclebybounds( bomb.origin, ( 1, 1, 1 ) * 0, bomb.angles );
    bomb.var_2aea2067472b8bd1 = utility::spawn_model( "tag_origin", bomb.origin, bomb.angles );
    icon_params = { #player_list:teams::getteamdata( "allies", "players" ), #set_tint:1, #origin:bomb.origin + ( 0, 0, 20 ), #image:"sat_ui_icon_zm_haunting_dna_bomb_available" };
    bomb.usable_marker_id = function_d59ef2d25c1b4d99( icon_params );
    activity_scriptables::function_114d59757e8d7bd9( self, self.active_bomb );
    function_733c6ff94344b9c( self );
    namespace_80082437c22b4d6e::function_dab60f070f92291e( self );
    level notify( #"blight_finale_triggered" );
    
    if ( !level callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::add( #"player_spawned", &on_player_spawned );
    }
    
    if ( self.reference_clip )
    {
        veh_clip = spawn( "script_model", bomb.origin + ( 0, 0, 30 ) );
        veh_clip.angles = bomb.angles;
        veh_clip clonebrushmodeltoscriptmodel( self.reference_clip );
        veh_clip disconnectpaths();
        veh_clip.moverdoesnotkill = 0;
        bomb.veh_clip = veh_clip;
    }
    
    foreach ( player in teams::getteamdata( "allies", "players" ) )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( bomb.usable_marker_id );
    }
    
    thread function_c543b097996b24a();
    
    /#
        level.debug_blight_finale.activity = self;
    #/
    
    msg = utility::waittill_any_return( "bomb_detonated", "all_bombs_destroyed" );
    activity_instance_common::endactivity( self, msg == "bomb_detonated" );
}

// Namespace activity_blight_finale
// Params 1
// Checksum 0x5a5f209c, Offset: 0xcee
// Size: 0x2a
function activity_ended( activity_succeeded )
{
    namespace_80082437c22b4d6e::function_36af27abcca0df47( self );
    level callback::remove( #"player_spawned", &on_player_spawned );
}

// Namespace activity_blight_finale
// Params 0
// Checksum 0x6f845643, Offset: 0xd20
// Size: 0x2
function function_d4acef179eb9f9b2()
{
    
}

// Namespace activity_blight_finale
// Params 0, eflags: 0x4
// Checksum 0x248e454b, Offset: 0xd2a
// Size: 0x1ce
function private function_9ccce02a17ab2820()
{
    var_a5260edaa45bfabb = getdvarint( @"hash_21c87788d885b9f8", 0 );
    
    if ( var_a5260edaa45bfabb > 0 )
    {
        forced_bomb = self.bomb_structs[ var_a5260edaa45bfabb - 1 ];
        return forced_bomb;
    }
    
    var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
    
    foreach ( player in var_557d41c1e4ba8fc9 )
    {
        sorted_bombs = function_628bac9faa9d1e86( self.bomb_structs, player.origin );
        closest_bomb = sorted_bombs[ 0 ];
        
        if ( !isdefined( closest_bomb.var_162b570e3d558ae0 ) )
        {
            closest_bomb.var_162b570e3d558ae0 = 0;
        }
        
        closest_bomb.var_162b570e3d558ae0++;
        
        if ( sorted_bombs[ 1 ] )
        {
            second_bomb = sorted_bombs[ 1 ];
            
            if ( !isdefined( second_bomb.var_3aefd35dde1077d3 ) )
            {
                second_bomb.var_3aefd35dde1077d3 = 0;
            }
            
            second_bomb.var_3aefd35dde1077d3++;
        }
    }
    
    if ( self.bomb_search_type == 0 )
    {
        self.var_4bf20e5158909524 = arraysort( self.bomb_structs, undefined, &function_98085e5bc754f27a );
    }
    else if ( self.bomb_search_type == 1 )
    {
        self.var_4bf20e5158909524 = arraysort( self.bomb_structs, undefined, &function_67250118d739fd9 );
    }
    else
    {
        self.var_4bf20e5158909524 = arrayrandomize( self.bomb_structs );
    }
    
    return self.var_4bf20e5158909524[ 0 ];
}

// Namespace activity_blight_finale
// Params 2, eflags: 0x4
// Checksum 0x67df9c97, Offset: 0xf01
// Size: 0x62, Type: bool
function private function_98085e5bc754f27a( bomb_a, bomb_b )
{
    if ( !isdefined( bomb_a.var_162b570e3d558ae0 ) )
    {
        bomb_a.var_162b570e3d558ae0 = 0;
    }
    
    if ( !isdefined( bomb_b.var_162b570e3d558ae0 ) )
    {
        bomb_b.var_162b570e3d558ae0 = 0;
    }
    
    return bomb_a.var_162b570e3d558ae0 > bomb_b.var_162b570e3d558ae0;
}

// Namespace activity_blight_finale
// Params 2, eflags: 0x4
// Checksum 0x53f2197, Offset: 0xf6c
// Size: 0x62, Type: bool
function private function_67250118d739fd9( bomb_a, bomb_b )
{
    if ( !isdefined( bomb_a.var_3aefd35dde1077d3 ) )
    {
        bomb_a.var_3aefd35dde1077d3 = 0;
    }
    
    if ( !isdefined( bomb_b.var_3aefd35dde1077d3 ) )
    {
        bomb_b.var_3aefd35dde1077d3 = 0;
    }
    
    return bomb_a.var_3aefd35dde1077d3 > bomb_b.var_3aefd35dde1077d3;
}

// Namespace activity_blight_finale
// Params 1, eflags: 0x4
// Checksum 0x644d0f74, Offset: 0xfd7
// Size: 0xce
function private function_733c6ff94344b9c( activity_instance )
{
    if ( !activity_instance.active_bomb || activity_instance.active_bomb.activated )
    {
        return;
    }
    
    activity_instance.active_bomb function_7653c765b6c7b815();
    
    foreach ( player in teams::getteamdata( "allies", "players" ) )
    {
        activity_instance.active_bomb enablescriptableplayeruse( player );
    }
}

// Namespace activity_blight_finale
// Params 1, eflags: 0x4
// Checksum 0x90219dae, Offset: 0x10ad
// Size: 0x1ec
function private on_player_spawned( params )
{
    activity = level.blight_data.finale_instance;
    
    if ( !activity || !activity.active_bomb )
    {
        return;
    }
    
    player = params.player;
    
    if ( player.team && player.team == "axis" )
    {
        activity.active_bomb disablescriptableplayeruse( player );
        
        if ( activity.active_bomb.activated )
        {
            widget_params = { #players:[ player ], #step_index:2 };
            namespace_80082437c22b4d6e::function_5cdac4ed52d48636( activity, widget_params );
            utility::delaythread( level.framedurationseconds, &activity_definition_utils::function_16b3cfd89a1669f7, 3, activity, { #players:[ player ] } );
            
            if ( activity.active_bomb.countdown_marker_id )
            {
                objidpoolmanager::objective_playermask_hidefrom( activity.active_bomb.countdown_marker_id, player );
            }
            
            if ( activity.active_bomb.var_924268a1d481a51d )
            {
                objidpoolmanager::objective_playermask_addshowplayer( activity.active_bomb.var_924268a1d481a51d, player );
                player calloutmarkerping::function_5d7b7302e94b97c2( activity.active_bomb.var_924268a1d481a51d );
            }
            
            return;
        }
        
        namespace_80082437c22b4d6e::function_36af27abcca0df47( activity, [ player ] );
        activity_definition_utils::function_16b3cfd89a1669f7( 0, activity, { #players:[ player ] } );
        
        if ( activity.active_bomb.usable_marker_id )
        {
            objidpoolmanager::objective_playermask_hidefrom( activity.active_bomb.usable_marker_id, player );
        }
    }
}

// Namespace activity_blight_finale
// Params 1
// Checksum 0xa8762827, Offset: 0x12a1
// Size: 0xbc
function player_joined_activity( relevant_info_struct )
{
    if ( !isdefined( self.active_bomb ) || self.active_bomb.activated )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        self.active_bomb enablescriptableplayeruse( player );
    }
    
    namespace_80082437c22b4d6e::function_dab60f070f92291e( self );
}

// Namespace activity_blight_finale
// Params 1
// Checksum 0x49e56975, Offset: 0x1365
// Size: 0x9d
function player_left_activity( relevant_info_struct )
{
    if ( !isdefined( self.active_bomb ) )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        self.active_bomb disablescriptableplayeruse( player );
    }
}

// Namespace activity_blight_finale
// Params 0
// Checksum 0x6b9d82dd, Offset: 0x140a
// Size: 0xc7
function function_c543b097996b24a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
    widget_params = { #players:var_557d41c1e4ba8fc9, #timer:self.var_fdcf83b5c199cd72 };
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( self, widget_params );
    infected = teams::getteamdata( "axis", "players" );
    activity_player_broadcasting::function_cb4750c84882dd07( "finale_start", var_557d41c1e4ba8fc9 );
    activity_player_broadcasting::function_cb4750c84882dd07( "finale_start_infected", infected );
    
    if ( self.var_fdcf83b5c199cd72 > 0 )
    {
        wait self.var_fdcf83b5c199cd72;
    }
    
    level thread function_fbbb6f764ca68b01( self.active_bomb );
}

// Namespace activity_blight_finale
// Params 6
// Checksum 0xd4a1cd76, Offset: 0x14d9
// Size: 0x82
function function_898b3d850622a79b( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.activity_instance ) )
    {
        return;
    }
    
    if ( instance.activated || instance.destroyed )
    {
        return;
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    level thread function_fbbb6f764ca68b01( instance );
}

// Namespace activity_blight_finale
// Params 1
// Checksum 0x5324a883, Offset: 0x1563
// Size: 0x52f
function function_fbbb6f764ca68b01( bomb_scriptable )
{
    activity_instance = bomb_scriptable.activity_instance;
    bomb_scriptable.activated = 1;
    bomb_scriptable.destroyed = 0;
    bomb_scriptable.health = activity_instance.bomb_health_max;
    bomb_scriptable setscriptablepartstate( "saw_blight_finale_bomb", "default" );
    bomb_scriptable setscriptablepartstate( "health", "health" );
    bomb_scriptable setscriptablepartstate( "fx", "activated" );
    bomb_scriptable setscriptablepartstate( "usable", "unusable" );
    bomb_scriptable function_7653c765b6c7b815();
    activity_participation::function_fb0ec90aaf6d4c61( activity_instance, level.players );
    namespace_80082437c22b4d6e::function_dab60f070f92291e( activity_instance );
    activity_definition_utils::function_16b3cfd89a1669f7( 1, activity_instance );
    utility::callsharedfunc( #"blight", #"hash_372b7765497d3ec4", "dna_bomb_armed_survivors", "allies", 2 );
    utility::callsharedfunc( #"blight", #"hash_372b7765497d3ec4", "dna_bomb_armed_zombies", "axis", 2 );
    function_33d631c751c15d2d( bomb_scriptable.usable_marker_id );
    bomb_scriptable.usable_marker_id = undefined;
    current_progress = int( math::normalize_value( 0, activity_instance.bomb_health_max, activity_instance.bomb_health_max ) * 100 );
    var_cf684f09b6c37c3a = int( math::normalize_value( 0, activity_instance.bomb_health_max, activity_instance.bomb_health_max ) * 100 );
    var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
    widget_params = { #players:var_557d41c1e4ba8fc9, #timer:activity_instance.var_6b962bbdb9bd737b - 3.5, #var_cf684f09b6c37c3a:var_cf684f09b6c37c3a, #current_progress:current_progress, #step_index:1 };
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( activity_instance, widget_params );
    icon_params = { #player_list:var_557d41c1e4ba8fc9, #origin:bomb_scriptable.origin + ( 0, 0, 20 ), #image:"sat_ui_icon_zm_haunting_dna_bomb_armed" };
    bomb_scriptable.countdown_marker_id = function_d59ef2d25c1b4d99( icon_params );
    objective_settint( bomb_scriptable.countdown_marker_id, 45, 255, 119 );
    activity_instance activity_player_broadcasting::function_cb4750c84882dd07( "bomb_activated", var_557d41c1e4ba8fc9 );
    current_progress = int( math::normalize_value( 0, activity_instance.bomb_health_max, activity_instance.bomb_health_max ) * 100 );
    var_cf684f09b6c37c3a = int( math::normalize_value( 0, activity_instance.bomb_health_max, activity_instance.bomb_health_max ) * 100 );
    zombies = teams::getteamdata( "axis", "players" );
    widget_params = { #players:zombies, #timer:activity_instance.var_6b962bbdb9bd737b - 3.5, #var_cf684f09b6c37c3a:var_cf684f09b6c37c3a, #current_progress:current_progress, #step_index:2 };
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( activity_instance, widget_params );
    utility::delaythread( level.framedurationseconds, &activity_definition_utils::function_16b3cfd89a1669f7, 3, activity_instance, { #players:zombies } );
    icon_params = { #player_list:zombies, #origin:bomb_scriptable.origin + ( 0, 0, 20 ), #image:"sat_ui_icon_zm_haunting_dna_bomb_armed" };
    bomb_scriptable.var_924268a1d481a51d = function_d59ef2d25c1b4d99( icon_params );
    objective_settint( bomb_scriptable.var_924268a1d481a51d, 255, 0, 0 );
    
    foreach ( player in var_557d41c1e4ba8fc9 )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( bomb_scriptable.countdown_marker_id );
    }
    
    foreach ( player in zombies )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( bomb_scriptable.var_924268a1d481a51d );
    }
    
    activity_instance activity_player_broadcasting::function_cb4750c84882dd07( "bomb_activated_infected", zombies );
    activity_instance childthread function_4317365a508f51ec( bomb_scriptable );
    bomb_scriptable.var_f7e049347883d1ee = activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:saw_blight_ai_encounter_finale", bomb_scriptable.origin, 1000, 1, 0, 1, 1 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( bomb_scriptable.var_f7e049347883d1ee, &namespace_80082437c22b4d6e::function_77688a5e67bd527f, { #activity_instance:activity_instance } );
    level notify( #"finale_bomb_armed" );
}

// Namespace activity_blight_finale
// Params 1, eflags: 0xc
// Checksum 0x53b95f9c, Offset: 0x1a9a
// Size: 0x126
function private function_4317365a508f51ec( bomb )
{
    self notify( #"hash_e8bc324ae4960fa2" );
    self endon( #"hash_e8bc324ae4960fa2" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    bomb endon( #"bomb_destroyed" );
    elapsed = 0;
    duration = self.var_6b962bbdb9bd737b;
    self.end_time = gettime() + duration * 1000;
    thread bomb_thumper( bomb );
    thread function_ab80caeb90565a9e( bomb );
    imminent_time = duration - 10;
    imminent_splash = 0;
    
    while ( elapsed < duration )
    {
        wait 0.5;
        elapsed += 0.5;
        
        if ( elapsed >= imminent_time && !imminent_splash )
        {
            imminent_splash = 1;
            function_e218996ab9858e0e();
        }
    }
    
    utility::callsharedfunc( #"blight", #"hash_372b7765497d3ec4", "dna_bomb_detonated", level.players, 2 );
    function_33d631c751c15d2d( bomb.countdown_marker_id );
    bomb.countdown_marker_id = undefined;
}

// Namespace activity_blight_finale
// Params 0, eflags: 0x4
// Checksum 0xc00c235a, Offset: 0x1bc8
// Size: 0x54
function private function_e218996ab9858e0e()
{
    var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
    activity_player_broadcasting::function_cb4750c84882dd07( "bomb_imminent_survivors", var_557d41c1e4ba8fc9 );
    zombies = teams::getteamdata( "axis", "players" );
    activity_player_broadcasting::function_cb4750c84882dd07( "bomb_imminent_infected", zombies );
}

// Namespace activity_blight_finale
// Params 1, eflags: 0x4
// Checksum 0xa2b5de37, Offset: 0x1c24
// Size: 0x138
function private bomb_thumper( bomb )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    bomb endon( #"bomb_destroyed" );
    var_e2c055bacda523ee = self.var_6b962bbdb9bd737b / 12;
    time_up = 3.5;
    time_down = 0.15;
    var_9ff5508313cb6e31 = var_e2c055bacda523ee - time_up - time_down;
    
    for ( i = 0; i < 10 ; i++ )
    {
        wait var_9ff5508313cb6e31;
        bomb setscriptablepartstate( "anim", "opening_slow" );
        wait time_up;
        bomb setscriptablepartstate( "anim", "closing_quick" );
        wait time_down;
        earthquake( 0.3, 0.5, bomb.origin, 1000 );
    }
    
    time_left = ( self.end_time - gettime() ) * 0.001;
    var_9ff5508313cb6e31 = time_left - time_up * 2 - time_down;
    wait var_9ff5508313cb6e31;
    bomb setscriptablepartstate( "anim", "opening_slow" );
    wait time_up;
    bomb setscriptablepartstate( "anim", "closing_quick" );
    wait time_down;
    bomb thread function_52234c4101999057( self );
}

// Namespace activity_blight_finale
// Params 1, eflags: 0xc
// Checksum 0xba6f5111, Offset: 0x1d64
// Size: 0x19f
function private function_ab80caeb90565a9e( bomb )
{
    self notify( #"hash_c1f2dd21812548f7" );
    self endon( #"hash_c1f2dd21812548f7" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"bomb_detonated" );
    bomb endon( #"bomb_destroyed" );
    
    while ( true )
    {
        nearby_vehicles = vehicle_getarrayinradius( bomb.origin, 200 );
        
        if ( nearby_vehicles.size > 0 )
        {
            foreach ( veh in nearby_vehicles )
            {
                if ( issubstr( veh.vehiclename, "truck" ) || issubstr( veh.vehiclename, "jltv" ) )
                {
                    impulse_strength = 225;
                }
                else if ( issubstr( veh.vehiclename, "bike" ) )
                {
                    impulse_strength = 40;
                }
                else
                {
                    impulse_strength = 15;
                }
                
                veh vehphys_impulse( vectornormalize( veh.origin - bomb.origin ), impulse_strength, 1 );
                veh dodamage( 50, veh.origin, bomb.var_2aea2067472b8bd1, bomb.var_2aea2067472b8bd1 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace activity_blight_finale
// Params 2, eflags: 0xc
// Checksum 0x378025e5, Offset: 0x1f0b
// Size: 0x326
function private function_52234c4101999057( activity_instance, skip_damage = 0 )
{
    self notify( #"hash_e3fb2ab93309b49a" );
    self endon( #"hash_e3fb2ab93309b49a" );
    self endon( #"death" );
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_506251a01caeb897 = 2;
    var_8eb462983119734d = var_506251a01caeb897 * 1000;
    var_d0da9bd70a13b68 = [ [ 0, 0 ], [ 0.105, 0.7 ], [ 0.27, 0.883 ], [ 0.35, 1 ], [ 1, 1 ] ];
    self.radiationradius = 0;
    largestradius = 1550;
    self setscriptablepartstate( "saw_blight_finale_bomb", "exploded" );
    var_defe2d0089c0ddeb = gettime();
    endtime = var_defe2d0089c0ddeb + var_8eb462983119734d;
    earthquake( 0.4, 2, self.origin, 1550 );
    set_endgame_states();
    
    while ( gettime() < endtime )
    {
        if ( self.var_7568cab78e4268cc > 0 )
        {
            self.radiationradius = 0;
            var_defe2d0089c0ddeb = gettime();
            endtime = var_defe2d0089c0ddeb + var_8eb462983119734d;
        }
        else
        {
            currenttime = gettime();
            completedratio = ( currenttime - var_defe2d0089c0ddeb ) / var_8eb462983119734d;
            radiuspercent = function_edbdbcee2a4a42c9( var_d0da9bd70a13b68, completedratio );
            self.radiationradius = radiuspercent * largestradius;
        }
        
        function_d3abff7c5b0f7f5a();
        
        if ( !skip_damage )
        {
            foreach ( target in self.validtargets )
            {
                target dodamage( target.health, target.origin, self.var_2aea2067472b8bd1, self.var_2aea2067472b8bd1, "MOD_TRIGGER_HURT" );
            }
        }
        
        /#
            if ( level.debug_blight_finale.test_explosion )
            {
                debug::sphere( self.origin, self.radiationradius, ( 1, 0, 0 ), level.framedurationseconds );
            }
        #/
        
        waitframe();
    }
    
    utility::delaycall( 4, &setscriptablepartstate, "saw_blight_finale_bomb", "default_no_sfx" );
    
    if ( !level.debug_blight_finale.test_sequence )
    {
        activity_instance notify( #"bomb_detonated" );
    }
    
    /#
        level.debug_blight_finale.test_sequence = 0;
        level.debug_blight_finale.test_explosion = 0;
    #/
}

// Namespace activity_blight_finale
// Params 0, eflags: 0x4
// Checksum 0xeafe18a9, Offset: 0x2239
// Size: 0x142
function private set_endgame_states()
{
    var_557d41c1e4ba8fc9 = teams::getteamdata( "allies", "players" );
    
    foreach ( player in var_557d41c1e4ba8fc9 )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player val::group_set( #"hash_87eae70de8f72d2b", 0 );
    }
    
    infected = teams::getteamdata( "axis", "players" );
    
    foreach ( player in infected )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player val::group_set( #"hash_be92df7bff51ba4", 0 );
    }
}

// Namespace activity_blight_finale
// Params 0, eflags: 0x4
// Checksum 0xe58a5b02, Offset: 0x2383
// Size: 0x60
function private function_d3abff7c5b0f7f5a()
{
    if ( !self || self.stopupdating )
    {
        return;
    }
    
    if ( !isdefined( self.validtargets ) )
    {
        self.validtargets = [];
    }
    
    newtargets = [];
    newtargets = getplayersandaiarrayinradius( self.origin, self.radiationradius, "axis" );
    self.validtargets = newtargets;
}

// Namespace activity_blight_finale
// Params 2, eflags: 0x4
// Checksum 0xe103da8f, Offset: 0x23eb
// Size: 0x118
function private function_edbdbcee2a4a42c9( points, completedratio )
{
    if ( !isdefined( points ) || !points.size )
    {
        return 0;
    }
    
    firstx = points[ 0 ][ 0 ];
    firsty = points[ 0 ][ 1 ];
    lastx = points[ points.size - 1 ][ 0 ];
    lasty = points[ points.size - 1 ][ 1 ];
    
    if ( completedratio <= firstx )
    {
        return firsty;
    }
    
    if ( completedratio >= lastx )
    {
        return lasty;
    }
    
    for ( i = 0; i < points.size - 1 ; i++ )
    {
        var_e84dbb253d793c86 = points[ i ][ 0 ];
        y0 = points[ i ][ 1 ];
        x1 = points[ i + 1 ][ 0 ];
        y1 = points[ i + 1 ][ 1 ];
        
        if ( completedratio <= x1 )
        {
            if ( x1 == var_e84dbb253d793c86 )
            {
                return y1;
            }
            
            t = ( completedratio - var_e84dbb253d793c86 ) / ( x1 - var_e84dbb253d793c86 );
            return ( y0 + ( y1 - y0 ) * t );
        }
    }
    
    return lasty;
}

// Namespace activity_blight_finale
// Params 11
// Checksum 0x87cac4a9, Offset: 0x250c
// Size: 0x3e8
function function_418e7b91bcce5309( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.activity_instance.type != "BLIGHT_FINALE" || instance.destroyed || eattacker.team != "axis" && !level.debug_blight_finale.bomb_damageable )
    {
        return;
    }
    
    if ( !instance.activated )
    {
        eattacker damagefeedback::updatedamagefeedback( "hitspawnprotect", 0, 0, undefined, 0, 1 );
        return;
    }
    
    instance.health -= idamage;
    eattacker damagefeedback::updatedamagefeedback( "standard", instance.health <= 0 );
    current_progress = int( math::normalize_value( 0, instance.activity_instance.bomb_health_max, instance.health ) * 100 );
    var_cf684f09b6c37c3a = int( math::normalize_value( 0, instance.activity_instance.bomb_health_max, instance.activity_instance.bomb_health_max ) * 100 );
    widget_params = { #var_cf684f09b6c37c3a:var_cf684f09b6c37c3a, #current_progress:current_progress };
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( instance.activity_instance, widget_params );
    
    if ( instance.health > 0 )
    {
        if ( instance.health <= instance.activity_instance.bomb_health_max * 0.66 && instance getscriptablepartstate( "damaged_fx" ) == "default" )
        {
            instance setscriptablepartstate( "damaged_fx", "damaged_light" );
            return;
        }
        
        if ( instance.health <= instance.activity_instance.bomb_health_max * 0.33 && instance getscriptablepartstate( "damaged_fx" ) == "damaged_light" )
        {
            instance setscriptablepartstate( "damaged_fx", "damaged_heavy" );
        }
        
        return;
    }
    
    instance.destroyed = 1;
    instance notify( #"bomb_destroyed" );
    instance setscriptablepartstate( "saw_blight_finale_bomb", "destroyed" );
    instance setscriptablepartstate( "fx", "off" );
    instance setscriptablepartstate( "anim", "neutral" );
    instance setscriptablepartstate( "damaged_fx", "default" );
    instance.activity_instance activity_player_broadcasting::function_cb4750c84882dd07( "bomb_destroyed" );
    utility::callsharedfunc( #"blight", #"hash_372b7765497d3ec4", "dna_bomb_destroyed", level.players, 2 );
    
    if ( instance.var_f7e049347883d1ee )
    {
        instance.activity_instance activity_ai_encounters::function_2574b40bde3bd456();
        instance.var_f7e049347883d1ee = undefined;
    }
    
    activity_instance = instance.activity_instance;
    
    if ( instance.activated )
    {
        function_33d631c751c15d2d( instance.countdown_marker_id );
        instance.countdown_marker_id = undefined;
    }
    else
    {
        function_33d631c751c15d2d( instance.usable_marker_id );
        instance.usable_marker_id = undefined;
    }
    
    if ( !level.debug_blight_finale.test_sequence )
    {
        activity_instance notify( #"all_bombs_destroyed" );
    }
    
    /#
        level.debug_blight_finale.test_sequence = 0;
    #/
}

// Namespace activity_blight_finale
// Params 1, eflags: 0x4
// Checksum 0xe42c93b9, Offset: 0x28fc
// Size: 0x199
function private function_d59ef2d25c1b4d99( params )
{
    image_type = params.image;
    origin = params.origin;
    owner_team = params.team;
    player_list = params.player_list ?? level.players;
    obj_id = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( obj_id != -1 )
    {
        objidpoolmanager::objective_add_objective( obj_id, "current", origin, image_type );
        objidpoolmanager::update_objective_setbackground( obj_id, 1 );
        objidpoolmanager::function_586b631e7bbb592a( obj_id, 0 );
        objidpoolmanager::objective_set_play_intro( obj_id, 1 );
        objidpoolmanager::update_objective_setzoffset( obj_id, 50 );
        objidpoolmanager::function_5ebf6b201daf1c5( obj_id, 1 );
        objidpoolmanager::update_objective_description( obj_id, &"hash_67880b3a67c69cc3" );
        objective_settint( obj_id, 237, 203, 86 );
        
        if ( owner_team == "allies" )
        {
            objective_settint( obj_id, 45, 255, 119 );
        }
        else if ( owner_team == "axis" )
        {
            objective_settint( obj_id, 255, 0, 0 );
        }
        
        function_38b84cb3d4357dd7( obj_id );
        
        foreach ( player in player_list )
        {
            objidpoolmanager::objective_playermask_addshowplayer( obj_id, player );
        }
    }
    
    return obj_id;
}

// Namespace activity_blight_finale
// Params 1, eflags: 0x4
// Checksum 0x237fdbe3, Offset: 0x2a9e
// Size: 0x2d
function private function_33d631c751c15d2d( obj_id )
{
    if ( isdefined( obj_id ) && obj_id != -1 )
    {
        objidpoolmanager::objective_playermask_hidefromall( obj_id );
        objidpoolmanager::returnobjectiveid( obj_id );
    }
}

/#

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0x6d1a5946, Offset: 0x2ad3
    // Size: 0x248, Type: dev
    function private init_debug()
    {
        level.debug_blight_finale = {};
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x45>", "<dev string:x61>", &debug_show_all );
        devgui::function_cd4e263c1f3018ae( "<dev string:x78>", "<dev string:x88>", &function_de4397813204a0aa );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9d>", "<dev string:xbd>", &function_de4397813204a0aa );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd2>", "<dev string:xdf>", &function_de4397813204a0aa );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf4>", "<dev string:x111>", &function_de4397813204a0aa );
        devgui::add_devgui_func( "<dev string:x126>", "<dev string:x13a>", &function_531fb2cf61273df9 );
        devgui::add_devgui_func( "<dev string:x158>", "<dev string:x167>", &function_e389d4ee27d9ee0d );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17b>", "<dev string:x193>", &function_1741effc03ab3a5c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b2>", "<dev string:x1c9>", &function_1741effc03ab3a5c );
        devgui::add_devgui_func( "<dev string:x1e7>", "<dev string:x1fb>", &debug_bomb_explosion );
        devgui::function_cd4e263c1f3018ae( "<dev string:x218>", "<dev string:x22c>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x25d>", "<dev string:x271>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2ab>", "<dev string:x2c1>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fc>", "<dev string:x30d>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x331>", "<dev string:x34a>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x376>", "<dev string:x391>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3bf>", "<dev string:x3d8>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x405>", "<dev string:x418>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43e>", "<dev string:x457>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x483>", "<dev string:x49e>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4cc>", "<dev string:x4e5>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x512>", "<dev string:x524>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x54b>", "<dev string:x55f>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x584>", "<dev string:x59e>", &function_6653d4f9b58893a4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5d1>", "<dev string:x5eb>", &function_6653d4f9b58893a4 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0xa7a21e72, Offset: 0x2d23
    // Size: 0x162, Type: dev
    function private debug_show_all()
    {
        if ( !level.debug_blight_finale.activity )
        {
            function_ee617aec9b9f998e();
            
            if ( !level.debug_blight_finale.activity )
            {
                return;
            }
        }
        
        if ( level.debug_blight_finale.show_loc )
        {
            level.debug_blight_finale.show_loc = 0;
            level notify( #"hash_9b142880dbb1b2be" );
            return;
        }
        
        level.debug_blight_finale.show_loc = 1;
        
        foreach ( bomb_struct in level.debug_blight_finale.activity.bomb_structs )
        {
            debug::line( bomb_struct, bomb_struct.origin + ( 0, 0, 3000 ), ( 0, 1, 0 ), undefined, "<dev string:x61e>" );
            debug::sphere( bomb_struct, 10, ( 0, 1, 0 ), undefined, "<dev string:x61e>" );
        }
    }

    // Namespace activity_blight_finale
    // Params 1, eflags: 0x4
    // Checksum 0x4fb8b71, Offset: 0x2e8d
    // Size: 0x2f1, Type: dev
    function private function_de4397813204a0aa( params )
    {
        if ( !level.debug_blight_finale.activity )
        {
            function_ee617aec9b9f998e();
            
            if ( !level.debug_blight_finale.activity )
            {
                return;
            }
        }
        
        level.debug_blight_finale.var_41b73193fc6a949d = undefined;
        
        if ( params[ 0 ] == "<dev string:x630>" || params[ 0 ] == "<dev string:x632>" )
        {
            closest_bomb = function_628bac9faa9d1e86( level.debug_blight_finale.activity.bomb_structs, level.player.origin )[ 0 ];
            level.debug_blight_finale.var_41b73193fc6a949d = closest_bomb;
        }
        
        if ( activity_instance_common::getactivitystate( level.debug_blight_finale.activity ) != "<dev string:x634>" )
        {
            activity_instance_common::function_46135a69bddfec2c( level.debug_blight_finale.activity );
        }
        
        activity_participation::function_fb0ec90aaf6d4c61( level.debug_blight_finale.activity, teams::getteamdata( "<dev string:x63b>", "<dev string:x642>" ) );
        level.debug_blight_finale.test_sequence = 1;
        bomb = level.debug_blight_finale.activity.active_bomb;
        bomb notify( #"bomb_destroyed" );
        
        if ( bomb.var_f7e049347883d1ee )
        {
            level.debug_blight_finale.activity activity_ai_encounters::function_2574b40bde3bd456();
            bomb.var_f7e049347883d1ee = undefined;
        }
        
        if ( bomb.activated )
        {
            function_33d631c751c15d2d( bomb.countdown_marker_id );
            bomb.countdown_marker_id = undefined;
        }
        else
        {
            function_33d631c751c15d2d( bomb.usable_marker_id );
            bomb.usable_marker_id = undefined;
        }
        
        bomb.activated = 0;
        bomb.destroyed = 0;
        bomb setscriptablepartstate( "<dev string:x64a>", "<dev string:x661>" );
        bomb setscriptablepartstate( "<dev string:x669>", "<dev string:x66c>" );
        bomb setscriptablepartstate( "<dev string:x674>", "<dev string:x679>" );
        bomb setscriptablepartstate( "<dev string:x680>", "<dev string:x661>" );
        function_733c6ff94344b9c( level.debug_blight_finale.activity );
        
        if ( params[ 0 ] == "<dev string:x630>" || params[ 0 ] == "<dev string:x687>" )
        {
            icon_params = { #team:"<dev string:x63b>", #origin:bomb.origin + ( 0, 0, 20 ), #image:"<dev string:x689>" };
            bomb.usable_marker_id = function_d59ef2d25c1b4d99( icon_params );
            return;
        }
        
        function_fbbb6f764ca68b01( bomb );
    }

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0xa06fc5a9, Offset: 0x3186
    // Size: 0xfe, Type: dev
    function private function_e389d4ee27d9ee0d()
    {
        if ( level.debug_blight_finale.activity )
        {
            if ( level.debug_blight_finale.activity.active_bomb )
            {
                bomb = level.debug_blight_finale.activity.active_bomb;
                bomb notify( #"bomb_destroyed" );
                level.debug_blight_finale.activity activity_ai_encounters::function_2574b40bde3bd456();
                function_33d631c751c15d2d( bomb.countdown_marker_id );
                function_33d631c751c15d2d( bomb.usable_marker_id );
                level.debug_blight_finale.activity.active_bomb freescriptable();
            }
            
            activity_instance_common::function_9aeeabe50fc9cc3e( level.debug_blight_finale.activity );
            level.debug_blight_finale.activity = undefined;
        }
    }

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0xdb9ef794, Offset: 0x328c
    // Size: 0x5d, Type: dev
    function private function_531fb2cf61273df9()
    {
        if ( level.debug_blight_finale.bomb_damageable )
        {
            level.debug_blight_finale.bomb_damageable = 0;
            iprintlnbold( "<dev string:x6b4>" );
            return;
        }
        
        level.debug_blight_finale.bomb_damageable = 1;
        iprintlnbold( "<dev string:x6dc>" );
    }

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0xc893241e, Offset: 0x32f1
    // Size: 0xe7, Type: dev
    function private function_ee617aec9b9f998e()
    {
        foreach ( instance in level.activities.instances )
        {
            if ( instance.activitydefinitiontag == "<dev string:x6fe>" )
            {
                level.debug_blight_finale.activity = instance;
                break;
            }
        }
        
        if ( !level.debug_blight_finale.activity )
        {
            level.debug_blight_finale.activity = activity_instance_common::createactivityinstance( "<dev string:x705>", "<dev string:x6fe>" );
        }
    }

    // Namespace activity_blight_finale
    // Params 1, eflags: 0x4
    // Checksum 0x744c6a35, Offset: 0x33e0
    // Size: 0x31, Type: dev
    function private function_1741effc03ab3a5c( params )
    {
        level.player hud_message::showsplash( "<dev string:x713>" + params[ 0 ], undefined, undefined, undefined, undefined, "<dev string:x729>" );
    }

    // Namespace activity_blight_finale
    // Params 0, eflags: 0x4
    // Checksum 0xac4b145c, Offset: 0x3419
    // Size: 0xd9, Type: dev
    function private debug_bomb_explosion()
    {
        if ( !level.debug_blight_finale.activity )
        {
            function_ee617aec9b9f998e();
            
            if ( !level.debug_blight_finale.activity )
            {
                return;
            }
        }
        
        level.debug_blight_finale.test_sequence = 1;
        level.debug_blight_finale.test_explosion = 1;
        bomb = level.debug_blight_finale.activity.active_bomb;
        level notify( #"bomb_explosion_test" );
        debug::sphere( bomb, 1550, ( 0, 1, 0 ), undefined, "<dev string:x748>" );
        bomb thread function_52234c4101999057( level.debug_blight_finale.activity, 1 );
    }

    // Namespace activity_blight_finale
    // Params 1, eflags: 0x4
    // Checksum 0xdd9c0aa9, Offset: 0x34fa
    // Size: 0x159, Type: dev
    function private function_6653d4f9b58893a4( params )
    {
        if ( !level.debug_blight_finale.activity )
        {
            function_ee617aec9b9f998e();
            
            if ( !level.debug_blight_finale.activity )
            {
                return;
            }
        }
        
        if ( activity_instance_common::getactivitystate( level.debug_blight_finale.activity ) != "<dev string:x634>" )
        {
            activity_instance_common::function_46135a69bddfec2c( level.debug_blight_finale.activity );
            activity_participation::function_fb0ec90aaf6d4c61( level.debug_blight_finale.activity, teams::getteamdata( "<dev string:x63b>", "<dev string:x642>" ) );
        }
        
        bomb = level.debug_blight_finale.activity.active_bomb;
        
        if ( params[ 0 ] && params[ 1 ] )
        {
            bomb setscriptablepartstate( params[ 0 ], params[ 1 ] );
            return;
        }
        
        bomb setscriptablepartstate( "<dev string:x64a>", "<dev string:x661>" );
        bomb setscriptablepartstate( "<dev string:x680>", "<dev string:x661>" );
        bomb setscriptablepartstate( "<dev string:x75c>", "<dev string:x75c>" );
        bomb setscriptablepartstate( "<dev string:x674>", "<dev string:x763>" );
        bomb setscriptablepartstate( "<dev string:x669>", "<dev string:x76b>" );
        bomb setscriptablepartstate( "<dev string:x76f>", "<dev string:x661>" );
    }

#/
