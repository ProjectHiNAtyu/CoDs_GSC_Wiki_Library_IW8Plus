// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_pap.gsc  (hash_30d4209b5b4c964a.gscc) (size: 32622 Bytes / 0x7f6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6c76779 (3603392377)
// size ...... 32622 (0x7f6e)
// includes .. 20  (offset: 0x7556)
// strings ... 142 (offset: 0x75f6)
// dev strs .. 1   (offset: 0x7f62)
// exports ... 70  (offset: 0x4ece)
// cseg ...... 0xc5b + 0x4273 (0x4ece)
// imports ... 214 (offset: 0x59be)
// animtree1 . 0   (offset: 0x7f6e)
// animtree2 . 0   (offset: 0x7f6e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\loot\common_item;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_quest_pap;

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xd3904a63, Offset: 0xc79
// Size: 0x1e4
function init()
{
    if ( !( isusingmatchrulesdata() && getmatchrulesdata( "zmData", "papQuest" ) ) )
    {
        return;
    }
    
    logstring( "zm_quest_initialize start" );
    function_9bc1265b1ebf0aaf();
    level.var_5a5d8193365abd09 = [];
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_ruby_quest_pap_cs_completed" );
    logstring( "zm_quest_initialize flag_wait Complete" );
    level.pap_quest = zm_quest::get_quest( #"ruby_pap" );
    level.pap_quest.n_pieces_collected = 0;
    zm_quest::register_quest_step( #"ruby_pap", #"reach_observatory", &setup_reach_observatory, &cleanup_reach_observatory );
    zm_quest::register_quest_step( #"ruby_pap", #"head_to_power_station", &setup_head_to_power_station, &cleanup_head_to_power_station );
    zm_quest::register_quest_step( #"ruby_pap", #"hash_7e5df252f2978add", &function_9cface0930f8cea6, &function_797af6526caec313 );
    zm_quest::register_quest_step( #"ruby_pap", #"repair_device", &setup_repair_device, &cleanup_repair_device );
    zm_quest::register_quest_step( #"ruby_pap", #"holdout_fight_start", &setup_holdout_fight_start, &cleanup_holdout_fight_start );
    zm_quest::register_quest_step( #"ruby_pap", #"ending", &function_8e49baf5d7cfb38f, &cleanup_ending );
    utility::registersharedfunc( #"zm_quest", #"hash_9b839bc2ba7777ff", &is_pap_quest_complete );
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"ruby_pap" );
    
    if ( !utility::flag( "ruby_papq_complete" ) )
    {
        level val::set( "trial_ruby_pap", "task_logic_activate", 0 );
    }
    
    logstring( "zm_quest_initialize start_quest" );
    setup_pap_machine();
    setup_clips();
    level thread watch_open_sesame();
    
    /#
        level thread init_ruby_pap_debug();
    #/
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xcc64ef2e, Offset: 0xe65
// Size: 0x5f
function function_9bc1265b1ebf0aaf()
{
    utility::add_fx( "mq_blast", "vfx_t10_gameplay_zm_device_blast_clean" );
    utility::add_fx( "power_station_spark", "vfx_t10_levels_zm_quartz_machine_amp_zombie_hit_elec_spark_set" );
    utility::add_fx( "pap_move_in", "vfx_t10_levels_zm_opal_pap_move_land" );
    utility::add_fx( "pap_move_away", "vfx_t10_levels_zm_opal_pap_move_away" );
    level._effect[ "cooldown_smoke" ] = loadfxasset( "vfx_sat_core_vehicle_dmg_pgb_prop_smoke_med" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xb1ab540f, Offset: 0xecc
// Size: 0x14e
function private setup_reach_observatory( b_skipped, b_save_restored )
{
    var_cfe58a2b73b6dfbd = zm_quest::function_73720cdf21c3cfd7( #"ruby_pap", #"piece_1" );
    
    if ( var_cfe58a2b73b6dfbd )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_pap", 0, #"piece_1", 1 );
        level.pap_quest.n_pieces_collected++;
        level utility::flag_set( "papq_have_piece_1" );
    }
    
    var_cfe5872b73b6d924 = zm_quest::function_73720cdf21c3cfd7( #"ruby_pap", #"piece_2" );
    
    if ( var_cfe5872b73b6d924 )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_pap", 0, #"piece_2", 1 );
        level.pap_quest.n_pieces_collected++;
        level utility::flag_set( "papq_have_piece_2" );
    }
    
    init_papq_objects();
    path_a_structs = utility::getstructarray( "pap_path_a", "targetname" );
    path_b_structs = utility::getstructarray( "pap_path_b", "targetname" );
    var_e54bde9d4a4b06f = arraycombine( path_a_structs, path_b_structs );
    level thread function_ec00029c19cbcb83( var_e54bde9d4a4b06f );
    level utility::flag_wait_any( "papq_near_telescope", "papq_player_reach_observatory" );
    function_bc09e387bd9ef978();
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x769047ed, Offset: 0x1022
// Size: 0x41
function private cleanup_reach_observatory( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "papq_near_telescope" );
        level utility::flag_set( "papq_player_reach_observatory" );
    }
    
    function_bc09e387bd9ef978();
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x2787ce01, Offset: 0x106b
// Size: 0x2ab
function private init_papq_objects()
{
    level utility::flag_wait( "scriptables_ready" );
    s_loc = utility::getstruct( "papq_power_device_interact", "script_noteworthy" );
    level.power_device_interact = zm_quest::function_91f9590e98d57ff6( s_loc.origin, &function_3cec73edd9edbb4a, &function_319a395a9a43d43e, "extrasmallnohint" );
    e_power_station = getent( "power_station", "script_noteworthy" );
    level.power_station = e_power_station;
    s_loc = utility::getstruct( "papq_power_station_interact", "script_noteworthy" );
    level.power_station_interact = zm_quest::function_91f9590e98d57ff6( s_loc.origin, &use_power_station, &use_power_station_hint, "extrasmallnohint" );
    var_45b96cc128a2c9bf = utility::getstructarray( "pap_corpse_1", "targetname" );
    var_37c0e4c6b1996465 = randomint( 3 );
    var_92f3dc731288ca58 = var_45b96cc128a2c9bf[ var_37c0e4c6b1996465 ];
    var_e453192374603181 = utility::spawn_model( "c_sat_zmb_zombie_male_robed_corpse_1", var_92f3dc731288ca58.origin, var_92f3dc731288ca58.angles );
    
    if ( !level utility::flag( "papq_have_piece_1" ) )
    {
        var_760bd4d0bea9d8c2 = utility::getstruct( var_92f3dc731288ca58.script_noteworthy, "targetname" );
        spawnoptions = common_item::function_bc5ff2958b71a708( var_760bd4d0bea9d8c2.origin, var_760bd4d0bea9d8c2.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.critical = 1;
        level.var_4c1ad485606cfd7 = common_item::items_spawnitemfromscriptable( %"ruby_pap_component_scriptable", 1, spawnoptions );
    }
    
    var_c435b489ea1691c0 = utility::getstructarray( "pap_corpse_2", "targetname" );
    var_af4066532de92324 = randomint( 3 );
    var_92f3df731288d0f1 = var_c435b489ea1691c0[ var_af4066532de92324 ];
    var_e453162374602ae8 = utility::spawn_model( "c_sat_zmb_zombie_male_robed_corpse_3", var_92f3df731288d0f1.origin, var_92f3df731288d0f1.angles );
    
    if ( !level utility::flag( "papq_have_piece_2" ) )
    {
        var_760bd3d0bea9d68f = utility::getstruct( var_92f3df731288d0f1.script_noteworthy, "targetname" );
        spawnoptions = common_item::function_bc5ff2958b71a708( var_760bd3d0bea9d68f.origin, var_760bd3d0bea9d68f.angles );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.critical = 1;
        level.var_4c1ae485606d20a = common_item::items_spawnitemfromscriptable( %"ruby_pap_component_scriptable_2", 1, spawnoptions );
    }
    
    level callback::add( "quest_item_used", &function_4013629fe1ab7416 );
    level utility::flag_set( "papq_objects_init_complete" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x7ebc281b, Offset: 0x131e
// Size: 0x9f
function function_2f895c9137d2534()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    s_loc = utility::getstruct( "reach_observatory_loc", "script_noteworthy" );
    function_b3ad0f548ba2607c( "reach_observatory", s_loc.origin );
    
    while ( true )
    {
        a_players = getplayersinradius( s_loc.origin, s_loc.radius, undefined, undefined );
        
        if ( a_players && a_players.size > 0 )
        {
            level utility::flag_set( "papq_player_reach_observatory" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x4afb35cf, Offset: 0x13c5
// Size: 0x5b
function private setup_head_to_power_station( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_b3ad0f548ba2607c( "head_to_power_station", level.power_station_interact.origin + ( 0, 0, 24 ) );
    level utility::flag_wait( "papq_first_use_power_station" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x546e6359, Offset: 0x1428
// Size: 0x34
function private cleanup_head_to_power_station( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "papq_first_use_power_station" );
    }
    
    function_bc09e387bd9ef978();
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0xc1e29cc0, Offset: 0x1464
// Size: 0x10a
function function_3cec73edd9edbb4a( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( zm_quest::is_pap_quest_complete() || level utility::flag( "actively_repairing_pap_station" ) )
    {
        return;
    }
    
    if ( level utility::flag( "papq_first_use_power_station" ) )
    {
        if ( level utility::flag( "papq_have_piece_1" ) && level utility::flag( "papq_have_piece_2" ) )
        {
            level utility::flag_set( "actively_repairing_pap_station" );
            params = { #hud_description:&"zm_sat_ruby/papq_repairing", #var_b35caf93a1ae502d:self, #hold_time:2.5, #craft_reason:#"ruby_pap" };
            result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
            level utility::flag_clear( "actively_repairing_pap_station" );
            
            if ( result )
            {
                self freescriptable();
                level utility::flag_set( "papq_pieces_are_returned" );
                battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0x6133afb, Offset: 0x1576
// Size: 0xfb
function function_319a395a9a43d43e( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "papq_have_piece_1" ) && level utility::flag( "papq_have_piece_2" ) && level utility::flag( "papq_first_use_power_station" ) )
    {
        return { #interactable:1, #icon:"sat_ui_icon_zm_oculus", #buttoncallout:&"zm_sat_ruby/return_pieces", #description:&"zm_sat_ruby/papq_power_desc", #title:&"zm_sat_ruby/papq_power_title", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0xe57273a1, Offset: 0x167a
// Size: 0x121
function use_power_station( player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( zm_quest::is_pap_quest_complete() )
    {
        return;
    }
    
    if ( !level utility::flag( "papq_first_use_power_station" ) )
    {
        level utility::flag_set( "papq_first_use_power_station" );
        playsoundatpos( self.origin, "evt_papq_device_turn_on_fail" );
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_7718fcad919caf90", #"bc_flavor_player_negative" );
        return;
    }
    
    if ( level utility::flag( "papq_second_use_power_station" ) )
    {
        if ( level utility::flag( "papq_in_holdout" ) || level utility::flag( "papq_holdout_failed" ) )
        {
            return;
        }
        else if ( !level utility::flag( "papq_holdout_failed" ) )
        {
            level utility::flag_set( "papq_holdout_killoff" );
        }
        
        return;
    }
    
    if ( level utility::flag( "papq_pieces_are_returned" ) && !level utility::flag( "papq_holdout_killoff" ) )
    {
        level utility::flag_set( "papq_second_use_power_station" );
        level utility::flag_set( "papq_holdout_killoff" );
        player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_1dd9dd8e8ceaebcc", #"hash_5212ed7ec42f115a" );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0xcc893e3c, Offset: 0x17a3
// Size: 0x1d3
function use_power_station_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( level utility::flag( "papq_have_piece_1" ) && level utility::flag( "papq_have_piece_2" ) && level utility::flag( "papq_first_use_power_station" ) && !level utility::flag( "papq_pieces_are_returned" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hintstring_obj = { #interactable:1, #icon:"sat_ui_icon_zm_oculus", #buttoncallout:&"zm_sat_ruby/papq_turn_on_power", #description:&"zm_sat_ruby/papq_power_desc", #title:&"zm_sat_ruby/papq_power_title", #type:"HINT_BUTTON" };
    
    if ( level utility::flag( "papq_in_holdout" ) || level utility::flag( "papq_holdout_succeed" ) )
    {
        hintstring_obj.type = "HINT_NOBUTTON";
        hintstring_obj.interactable = 0;
    }
    else if ( level utility::flag( "papq_holdout_failed" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_ruby/papq_power_cooldown";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    if ( !level utility::flag( "papq_pieces_are_returned" ) && level utility::flag( "papq_first_use_power_station" ) )
    {
        hintstring_obj.aux_text = &"zm_sat_ruby/papq_power_need_fix";
        hintstring_obj.interactable = 0;
        return hintstring_obj;
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xd55b9dad, Offset: 0x197f
// Size: 0x1c1
function private function_9cface0930f8cea6( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( !level utility::flag( "papq_have_piece_1" ) )
    {
        s_loc_1 = utility::getstruct( "papq_piece_1_circle", "script_noteworthy" );
        function_b3ad0f548ba2607c( "found_pieces_1", s_loc_1.origin, 0 );
        s_loc_1 game_utility::questcircle_create( "zm_sat_ruby_papq", s_loc_1.origin, s_loc_1.radius );
        s_loc_1 game_utility::questcircle_showtoall();
        level.var_4c1ad485606cfd7 thread function_3c07f2f3711691e4( "search_for_pieces_1", "found_pieces_1" );
        level thread function_26a4bed5c119ee4e( "found_pieces_1", s_loc_1, [ "zone_planetarium_hallway_01_active", "zone_planetarium_hallway_02_active", "zone_planetarium_hallway_03_active" ] );
    }
    
    if ( !level utility::flag( "papq_have_piece_2" ) )
    {
        s_loc_2 = utility::getstruct( "papq_piece_2_circle", "script_noteworthy" );
        function_b3ad0f548ba2607c( "found_pieces_2", s_loc_2.origin, 0 );
        s_loc_2 game_utility::questcircle_create( "zm_sat_ruby_papq", s_loc_2.origin, s_loc_2.radius );
        s_loc_2 game_utility::questcircle_showtoall();
        level.var_4c1ae485606d20a thread function_3c07f2f3711691e4( "search_for_pieces_2", "found_pieces_2" );
        level thread function_26a4bed5c119ee4e( "found_pieces_2", s_loc_2, [ "zone_orrery_active", "zone_orrery_upper_floor_active", "zone_orrery_close_to_courtyard_active" ] );
    }
    
    zm_quest::function_9f49b2a045ece8ae( level.pap_quest.n_pieces_collected, 1, #"ruby_pap", #"hash_7e5df252f2978add" );
    level watch_pickup_pieces();
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x62acad35, Offset: 0x1b48
// Size: 0x90
function private function_797af6526caec313( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "papq_have_piece_1" );
        level utility::flag_set( "papq_have_piece_2" );
        
        if ( isdefined( level.var_4c1ad485606cfd7 ) )
        {
            level.var_4c1ad485606cfd7 freescriptable();
        }
        
        if ( isdefined( level.var_4c1ae485606d20a ) )
        {
            level.var_4c1ae485606d20a freescriptable();
        }
        
        function_3ee5d8e12db60f30();
    }
    
    function_bc09e387bd9ef978();
    level callback::remove( "quest_item_used", &function_4013629fe1ab7416 );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0x46c84842, Offset: 0x1be0
// Size: 0x146
function function_3c07f2f3711691e4( var_430b2250c968430a, use_flag )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    self endon( #"death" );
    radiussq = 40000;
    
    while ( true )
    {
        /#
            sphere( self.origin, 64, ( 1, 0, 0 ), 0, 180 );
        #/
        
        foreach ( player in level.players )
        {
            distancesq = distance2dsquared( self.origin, player.origin );
            
            if ( distancesq <= radiussq )
            {
                if ( var_430b2250c968430a )
                {
                    function_b3ad0f548ba2607c( var_430b2250c968430a, self.origin + ( 0, 0, 24 ), 0 );
                }
                
                if ( use_flag )
                {
                    level utility::flag_set( use_flag );
                }
                
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 3
// Checksum 0x1fdc6701, Offset: 0x1d2e
// Size: 0x88
function function_26a4bed5c119ee4e( use_flag, s_circle, zone_names )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    
    if ( !level.quest_circles )
    {
        level.quest_circles = [];
    }
    
    level.quest_circles[ level.quest_circles.size ] = s_circle;
    level thread function_72b78a50cff02814( use_flag, s_circle, zone_names );
    level utility::flag_wait( use_flag );
    
    if ( s_circle )
    {
        s_circle game_utility::questcircle_delete();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 3
// Checksum 0xa53182c7, Offset: 0x1dbe
// Size: 0x16c
function function_72b78a50cff02814( use_flag, s_circle, zone_names )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( use_flag );
    var_c1dcd5cd17e4baf6 = 0;
    
    while ( true )
    {
        foreach ( zone in zone_names )
        {
            foreach ( player in level.players )
            {
                if ( zone_manager::is_touching_zone( zone, player ) )
                {
                    var_c1dcd5cd17e4baf6 = 1;
                    break;
                }
            }
        }
        
        if ( !var_c1dcd5cd17e4baf6 )
        {
            function_b3ad0f548ba2607c( use_flag, s_circle.origin, 0 );
        }
        
        level utility::flag_wait_any_array( zone_names );
        function_c0cf34da0bb458db( use_flag );
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x8db846dd, Offset: 0x1f32
// Size: 0x68
function private setup_repair_device( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( isdefined( level.power_device_interact ) )
    {
        function_b3ad0f548ba2607c( "repair_power_device", level.power_device_interact.origin + ( 0, 0, 24 ) );
    }
    
    level utility::flag_wait( "papq_pieces_are_returned" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x81aeebb, Offset: 0x1fa2
// Size: 0x4c
function private cleanup_repair_device( b_skipped, b_save_restored )
{
    level.power_station setscriptablepartstate( "fx", "repaired" );
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "papq_pieces_are_returned" );
    }
    
    function_bc09e387bd9ef978();
}

// Namespace zm_sat_ruby_quest_pap
// Params 1, eflags: 0x4
// Checksum 0x2a505cba, Offset: 0x1ff6
// Size: 0x1ed
function private function_4013629fe1ab7416( params )
{
    switch ( params.bundle.scriptable )
    {
        case %"ruby_pap_component_scriptable":
            level utility::flag_set( "papq_have_piece_1" );
            function_c0cf34da0bb458db( "search_for_pieces_1" );
            zm_quest::function_b57dfe9625966b0b( #"ruby_pap", 0, #"piece_1", 1 );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_pap", #"piece_1", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_pap", #"piece_1", 1, params.player );
            break;
        case %"ruby_pap_component_scriptable_2":
            level utility::flag_set( "papq_have_piece_2" );
            function_c0cf34da0bb458db( "search_for_pieces_2" );
            zm_quest::function_b57dfe9625966b0b( #"ruby_pap", 0, #"piece_2", 1 );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_pap", #"piece_2", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_pap", #"piece_2", 1, params.player );
            break;
        default:
            return;
    }
    
    level.pap_quest.n_pieces_collected++;
    zm_quest::function_9f49b2a045ece8ae( level.pap_quest.n_pieces_collected, 1, #"ruby_pap", #"hash_7e5df252f2978add" );
    
    if ( level.pap_quest.n_pieces_collected >= 2 && level utility::flag( "papq_first_use_power_station" ) )
    {
        params.player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b11eca0d0f250b54", #"bc_flavor_player_positive" );
        return;
    }
    
    battlechatter_mp::trysaylocalsound( params.player, #"bc_flavor_player_positive" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xf28240e5, Offset: 0x21eb
// Size: 0x2c
function watch_pickup_pieces()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level utility::flag_wait_all( "papq_have_piece_1", "papq_have_piece_2" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x26b14a9f, Offset: 0x221f
// Size: 0x21
function private setup_holdout_fight( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x396820c, Offset: 0x2248
// Size: 0x15
function private cleanup_holdout_fight( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xfdd39998, Offset: 0x2265
// Size: 0x162
function private setup_holdout_fight_start( b_skipped, b_save_restored )
{
    level.var_d4d3b5b9c13ddd56 = utility::spawn_model( "tag_origin", utility::getstruct( "smoke_vfx", "targetname" ).origin );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_pap", #"holdout_fight_start" );
    zm_quest::function_fb3af5600f6a9441( 2, 1, #"ruby_pap", #"holdout_fight_start" );
    function_b3ad0f548ba2607c( "holdout_fight", level.power_station_interact.origin );
    wait 2;
    level.power_station_interact function_e203bba36cfb19d0();
    level utility::flag_wait( "papq_second_use_power_station" );
    function_bc09e387bd9ef978();
    zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_pap", #"holdout_fight_defending" );
    zm_quest::function_fb3af5600f6a9441( 2, 1, #"ruby_pap", #"holdout_fight_defending" );
    s_loc = utility::getstruct( "papq_power_device_interact", "script_noteworthy" );
    function_b3ad0f548ba2607c( "defend_power_device", s_loc.origin + ( 0, 0, 24 ) );
    level callback::add( "on_round_start", &on_round_start );
    level function_e1265700e2da9cee();
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x48c76c8c, Offset: 0x23cf
// Size: 0xb8
function private cleanup_holdout_fight_start( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( !level utility::flag( "papq_first_use_power_station" ) )
        {
            level utility::flag_set( "papq_first_use_power_station" );
        }
        
        if ( !level utility::flag( "papq_second_use_power_station" ) )
        {
            level utility::flag_set( "papq_second_use_power_station" );
        }
        
        if ( !level utility::flag( "papq_holdout_succeed" ) )
        {
            level utility::flag_set( "papq_holdout_succeed" );
        }
    }
    
    level.power_station blast_nearby_zombies( 2000 );
    
    if ( isdefined( level.papq_beam ) )
    {
        level.papq_beam utility::function_7c10ea82c1e305b8( "base", "init" );
    }
    
    function_bc09e387bd9ef978();
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x4806f1df, Offset: 0x248f
// Size: 0x2a2
function function_e1265700e2da9cee()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    var_5a59e4113644766b = 0;
    
    while ( !level utility::flag( "papq_holdout_succeed" ) )
    {
        if ( var_5a59e4113644766b > 0 )
        {
            level waittill( #"on_round_start" );
            level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"ruby_pap", #"holdout_fight_failed" );
            level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_pap", #"holdout_fight_start" );
            level zm_quest::function_fb3af5600f6a9441( 2, 1, #"ruby_pap", #"holdout_fight_start" );
            level utility::flag_wait( "papq_holdout_killoff" );
            function_bc09e387bd9ef978();
            s_loc = getent( "power_station", "script_noteworthy" );
            function_b3ad0f548ba2607c( "defend_power_device", s_loc.origin + ( 0, 0, 72 ) );
        }
        
        zm_round_spawning::pause_round_spawning( 1, "ruby_pap" );
        level.power_station blast_nearby_zombies( 2000, 1 );
        level thread flash_all_players( level.power_station, 2000 );
        level utility::flag_set( "papq_in_holdout" );
        set_attractor();
        level thread function_df5f7929401c3b31( 1 );
        level thread function_e49a06d63e479f2a();
        level thread function_9547a5e8cb3e6380();
        level thread function_6b50b5fefafe57b3();
        level thread function_49778f003aedaa56();
        level thread function_a7fedfa2938ee25e();
        level.power_station thread function_205a34f89287f822();
        level.ruby_telescope.scriptable utility::function_7c10ea82c1e305b8( "beam", "pap_beam_start" );
        level.ruby_pap_ghost utility::function_7c10ea82c1e305b8( "fx", "start" );
        level.power_station setscriptablepartstate( "fx", "charging" );
        level thread function_5d1aec8f97da7f2a();
        level utility::waittill_any( "papq_holdout_succeed", "papq_holdout_failed" );
        level.ruby_telescope.scriptable utility::function_7c10ea82c1e305b8( "beam", "pap_beam_end" );
        
        if ( level utility::flag( "papq_holdout_failed" ) )
        {
            playfxontag( utility::getfx( "cooldown_smoke" ), level.var_d4d3b5b9c13ddd56, "tag_origin" );
        }
        
        remove_attractor();
        level thread function_df5f7929401c3b31( 0 );
        level.power_station blast_nearby_zombies( 2000 );
        level thread flash_all_players( level.power_station, 2000 );
        var_5a59e4113644766b++;
        level utility::flag_clear( "papq_in_holdout" );
        zm_round_spawning::pause_round_spawning( 0, "ruby_pap" );
        level thread function_bc09e387bd9ef978();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x6215aa88, Offset: 0x2739
// Size: 0x16d
function function_5d1aec8f97da7f2a()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( #"papq_holdout_succeed" );
    level endon( #"papq_holdout_failed" );
    v_beam_end = utility::getstruct( "papq_beam_end", "targetname" ).origin;
    
    while ( true )
    {
        foreach ( holdout_player in level.players )
        {
            if ( distance2dsquared( holdout_player.origin, v_beam_end ) < 10000 )
            {
                holdout_player earthquakeforplayer( 0.3, 0.5, v_beam_end, 100 );
                
                if ( !holdout_player.in_beam )
                {
                    holdout_player.in_beam = 1;
                    holdout_player playrumblelooponentity( "damage_light" );
                }
                
                continue;
            }
            
            if ( holdout_player.in_beam && distance2dsquared( holdout_player.origin, v_beam_end ) > 10000 )
            {
                holdout_player.in_beam = 0;
                holdout_player stoprumble( "damage_light" );
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x522865d9, Offset: 0x28ae
// Size: 0x85
function function_a7fedfa2938ee25e()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( #"papq_holdout_failed" );
    wait 20;
    defending_players = getplayersinradius( level.power_station.origin, 700 );
    
    if ( defending_players.size > 0 && utility::cointoss() )
    {
        vo_player = utility::array_random( defending_players );
        vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_231314b47113f00a" );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x77b5d1bf, Offset: 0x293b
// Size: 0x72
function function_b3ab671e3c531a1e()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    wait 5.5;
    defending_players = getplayersinradius( level.power_station.origin, 700 );
    
    if ( defending_players.size > 0 )
    {
        vo_player = utility::array_random( defending_players );
        vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_2cc33d5fcc4fe373" );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x73b316c6, Offset: 0x29b5
// Size: 0xf4
function set_attractor()
{
    attractor = zombie_attractor_manager::add_attractor( level.power_station, 1, 1024, 1, undefined, &function_cc6605aa869c9c71 );
    var_a4828c4150e9c8df = utility::getstructarray( "papq_attractor" );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( attractor, 240 );
    zombie_attractor_manager::set_attractor_slots( attractor, var_a4828c4150e9c8df );
    zombie_attractor_manager::function_a2aab3762aaa055f( attractor, level.power_station.origin + ( 0, 0, 50 ), ( 35, 60, 50 ), level.power_station.angles );
    level.power_station setcandamage( 1 );
    level.power_station.health = 100000;
    level.power_station.var_cce7c67ea2da8902 = 1000;
    level.power_station.attractor = attractor;
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x88f4e24, Offset: 0x2ab1
// Size: 0x1c
function remove_attractor()
{
    zombie_attractor_manager::remove_attractor( level.power_station.attractor );
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0xc8a01b1c, Offset: 0x2ad5
// Size: 0x16f
function function_df5f7929401c3b31( b_on_off )
{
    if ( b_on_off )
    {
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_pap", #"holdout_fight_defending" );
        level zm_quest::function_fb3af5600f6a9441( 1, 1, #"ruby_pap", #"holdout_fight_defending" );
        level zm_quest::function_9f49b2a045ece8ae( level.power_station.var_cce7c67ea2da8902, 1, #"ruby_pap", #"holdout_fight_defending" );
        return;
    }
    
    if ( level utility::flag( "papq_holdout_failed" ) )
    {
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"ruby_pap", #"holdout_fight_defending" );
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"ruby_pap", #"holdout_fight_failed" );
        level zm_quest::function_fb3af5600f6a9441( 2, 1, #"ruby_pap", #"holdout_fight_failed" );
        return;
    }
    
    if ( level utility::flag( "papq_holdout_succeed" ) )
    {
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"ruby_pap", #"holdout_fight_start" );
        level zm_quest::function_fb3af5600f6a9441( 4, 1, #"ruby_pap", #"holdout_fight_defending" );
        waitframe();
        level zm_quest::function_fb3af5600f6a9441( 0, 1, #"ruby_pap", #"holdout_fight_defending" );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"ruby_pap", #"holdout_fight_defending" );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xbba5b359, Offset: 0x2c4c
// Size: 0x30f
function function_205a34f89287f822()
{
    level endon( #"game_ended" );
    level endon( #"papq_holdout_failed" );
    level endon( #"papq_holdout_succeed" );
    level endon( #"open_sesame" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        
        if ( level.power_station.attractor.var_fc48cc6608c8d82c )
        {
            foreach ( slot in level.power_station.attractor.var_fc48cc6608c8d82c )
            {
                if ( eattacker == slot.var_80be1da0fa595ce1 && slot.script_noteworthy )
                {
                    deactivateworldevent( "we_ruby_papq_oculus_hit_" + slot.script_noteworthy );
                    activateworldevent( "we_ruby_papq_oculus_hit_" + slot.script_noteworthy );
                    playsoundatpos( vpoint, "dst_papq_device_impact_zombie" );
                    break;
                }
            }
        }
        
        self.health = 100000;
        
        if ( isai( eattacker ) && eattacker.team == "team_two_hundred" )
        {
            self.var_cce7c67ea2da8902 -= 66.6667;
        }
        
        if ( self.var_cce7c67ea2da8902 < 0 )
        {
            self.var_cce7c67ea2da8902 = 0;
        }
        
        level zm_quest::function_9f49b2a045ece8ae( self.var_cce7c67ea2da8902, 1, #"ruby_pap", #"holdout_fight_defending" );
        
        if ( self.var_cce7c67ea2da8902 == 0 )
        {
            playsoundatpos( self.origin, "evt_papq_telescope_defend_fail_lr" );
            
            if ( !level utility::flag( "holdout_fail_vo_played" ) )
            {
                level utility::flag_set( "holdout_fail_vo_played" );
                level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_efd72060728c3574" ] );
            }
            
            level.ruby_pap_ghost utility::function_7c10ea82c1e305b8( "fx", "off" );
            level.power_station setscriptablepartstate( "fx", "cooldown" );
            playrumbleonposition( "heavy_1s", self.origin );
            level utility::flag_set( "papq_holdout_failed" );
            level notify( #"papq_holdout_failed" );
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x44f41976, Offset: 0x2f63
// Size: 0xb9
function function_49778f003aedaa56()
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( #"papq_holdout_failed" );
    level endon( #"papq_holdout_succeed" );
    
    if ( zm_quest::function_209ca091001f4c64( #"ruby_pap" ) )
    {
        step = zm_quest::get_quest_step( #"ruby_pap", #"holdout_fight_defending" );
        step thread function_28b04cb647ca8631();
        step utility::waittill_any( "zm_quest_step_tracker_showing", "splash_before_tracker_timeout" );
    }
    
    wait 44.4;
    level.ruby_pap_ghost utility::function_7c10ea82c1e305b8( "fx", "off" );
    level thread function_b3ab671e3c531a1e();
    level utility::flag_set( "papq_holdout_succeed" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x75c955c0, Offset: 0x3024
// Size: 0x29
function private function_28b04cb647ca8631()
{
    level endon( #"game_ended" );
    self endon( #"zm_quest_step_tracker_showing" );
    wait 10;
    self notify( #"splash_before_tracker_timeout" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xea10ff7, Offset: 0x3055
// Size: 0xf1
function function_e49a06d63e479f2a()
{
    level endon( #"game_ended" );
    level endon( #"papq_holdout_failed" );
    level endon( #"papq_holdout_succeed" );
    level endon( #"open_sesame" );
    var_a65a556e144e8c0b = utility::getstructarray( "papq_holdout_spawner", "script_noteworthy" );
    n_current_amt = 0;
    n_max_amt = 0;
    
    switch ( level.players.size )
    {
        case 1:
            n_max_amt = 3;
            break;
        case 2:
            n_max_amt = 4;
            break;
        case 3:
            n_max_amt = 5;
            break;
        case 4:
            n_max_amt = 6;
            break;
    }
    
    while ( n_current_amt < n_max_amt )
    {
        s_spawn_loc = var_a65a556e144e8c0b[ randomint( var_a65a556e144e8c0b.size ) ];
        spawn_base_zombie( s_spawn_loc, "run" );
        n_current_amt++;
        waitframe();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x157da467, Offset: 0x314e
// Size: 0x10c
function function_9547a5e8cb3e6380()
{
    level endon( #"game_ended" );
    level endon( #"papq_holdout_failed" );
    level endon( #"papq_holdout_succeed" );
    level endon( #"open_sesame" );
    var_a65a556e144e8c0b = utility::getstructarray( "papq_holdout_spawner", "script_noteworthy" );
    var_8571e26402db38ba = [];
    var_2067e9fef6f2f083 = 0;
    
    switch ( level.players.size )
    {
        case 1:
            var_2067e9fef6f2f083 = 3;
            break;
        case 2:
            var_2067e9fef6f2f083 = 5;
            break;
        case 3:
            var_2067e9fef6f2f083 = 7;
            break;
        case 4:
            var_2067e9fef6f2f083 = 9;
            break;
    }
    
    while ( true )
    {
        var_8571e26402db38ba = function_46f9072493651dc9( var_8571e26402db38ba );
        
        if ( var_8571e26402db38ba.size < var_2067e9fef6f2f083 )
        {
            s_spawn_loc = var_a65a556e144e8c0b[ randomint( var_a65a556e144e8c0b.size ) ];
            
            if ( !isdefined( var_8571e26402db38ba ) )
            {
                var_8571e26402db38ba = [];
            }
            
            var_8571e26402db38ba[ var_8571e26402db38ba.size ] = spawn_base_zombie( s_spawn_loc, "run" );
        }
        
        wait 2;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xd22a2066, Offset: 0x3262
// Size: 0x125
function function_6b50b5fefafe57b3()
{
    level endon( #"game_ended" );
    level endon( #"papq_holdout_failed" );
    level endon( #"papq_holdout_succeed" );
    level endon( #"open_sesame" );
    var_a65a556e144e8c0b = utility::getstructarray( "papq_holdout_spawner", "script_noteworthy" );
    var_98163ce8d71babf1 = [];
    var_9875b8bfe04e3c45 = 0;
    
    switch ( level.players.size )
    {
        case 1:
            var_9875b8bfe04e3c45 = 3;
            break;
        case 2:
            var_9875b8bfe04e3c45 = 3;
            break;
        case 3:
            var_9875b8bfe04e3c45 = 4;
            break;
        case 4:
            var_9875b8bfe04e3c45 = 5;
            break;
    }
    
    while ( true )
    {
        var_98163ce8d71babf1 = function_46f9072493651dc9( var_98163ce8d71babf1 );
        
        if ( var_98163ce8d71babf1.size < var_9875b8bfe04e3c45 )
        {
            s_spawn_loc = var_a65a556e144e8c0b[ randomint( var_a65a556e144e8c0b.size ) ];
            agent = spawn_base_zombie( s_spawn_loc, "sprint" );
            agent.is_attractor_zmb = 1;
            
            if ( !isdefined( var_98163ce8d71babf1 ) )
            {
                var_98163ce8d71babf1 = [];
            }
            
            var_98163ce8d71babf1[ var_98163ce8d71babf1.size ] = agent;
        }
        
        wait 4;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0x7b1da210, Offset: 0x338f
// Size: 0x27, Type: bool
function function_cc6605aa869c9c71( attractor, zombie )
{
    if ( zombie.is_attractor_zmb )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x74ef6c68, Offset: 0x33bf
// Size: 0x89
function private function_8e49baf5d7cfb38f( b_skipped, b_save_restored )
{
    level thread show_pap_machine();
    level utility::flag_set( "power_on" );
    level thread doorbuy::function_f036c23977df35fc( 1 );
    level.power_station utility::function_32b24db3127bff40( "fx", "active" );
    level.power_station utility::function_32b24db3127bff40( "telescope_screens", "on" );
    zm_round_spawning::pause_round_spawning( 0, "ruby_pap" );
    activateworldevent( "we_vfx_coil_ambient" );
    activateworldevent( "we_lgt_teleporter" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xe2413e86, Offset: 0x3450
// Size: 0x10d
function private cleanup_ending( b_skipped, b_save_restored )
{
    level callback::remove( "on_round_start", &on_round_start );
    function_bc09e387bd9ef978();
    
    if ( level.power_device_interact )
    {
        level.power_device_interact zm_quest::function_9170db4686f796e2();
    }
    
    if ( level.power_station_interact )
    {
        level.power_station_interact zm_quest::function_9170db4686f796e2();
    }
    
    if ( level.ruby_pap_ghost )
    {
        level.ruby_pap_ghost freescriptable();
    }
    
    level utility::flag_set( "ruby_papq_complete" );
    level val::reset( "trial_ruby_pap", "task_logic_activate" );
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"ruby_pap";
    params.var_be82617e5e8087bd = level.players;
    params.event = #"zm_sq_quest_complete";
    level callback::callback( "zm_sq_quest_complete", params );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xcd58fcc1, Offset: 0x3565
// Size: 0x45
function setup_fast_travel()
{
    s_portal = utility::getstruct( "portal_temple_a", "script_noteworthy" );
    e_trigger = getent( "portal_temple_a_trigger", "script_noteworthy" );
    
    if ( s_portal )
    {
        s_portal thread function_b9559ccd6eef0293( e_trigger );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0xa97d6f96, Offset: 0x35b2
// Size: 0x6b
function function_b9559ccd6eef0293( e_trigger )
{
    self endon( #"death" );
    
    if ( !e_trigger )
    {
        return;
    }
    
    while ( true )
    {
        e_trigger waittill( #"trigger", player );
        
        while ( isalive( player ) && player istouching( e_trigger ) )
        {
            waitframe();
        }
        
        self.interact function_b017430474bd77a7( player );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0x128f8394, Offset: 0x3625
// Size: 0x16a
function function_b017430474bd77a7( player )
{
    level endon( #"game_ended" );
    
    if ( isdefined( player ) && player.interactions_disabled )
    {
        return;
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.power_on_flag ) )
    {
        if ( !level utility::flag( self.var_7899dd4d8ac31d1a.power_on_flag ) )
        {
            return;
        }
    }
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.var_f0e4330fc19232d3 ) )
    {
        if ( !level utility::flag( self.var_7899dd4d8ac31d1a.var_f0e4330fc19232d3 ) )
        {
            return;
        }
    }
    
    player.var_d1c4c78b9fb7d153 = 1;
    
    if ( isdefined( self.var_7899dd4d8ac31d1a.activator_set_flag ) )
    {
        level utility::flag_set( self.var_7899dd4d8ac31d1a.activator_set_flag );
    }
    
    str_destination_loc = self.var_7899dd4d8ac31d1a.var_57c31258748ae730;
    
    if ( !isdefined( str_destination_loc ) )
    {
        str_destination_loc = self.var_7899dd4d8ac31d1a.str_destination_loc;
    }
    
    s_destination = player zm_fasttravel::get_destination_struct( str_destination_loc );
    self.var_7899dd4d8ac31d1a.var_5a5626a7d4b2feb = player;
    
    if ( isent( self ) )
    {
        self playsoundevent( %"sndevent_teleportation_begin_3d", player );
    }
    
    level thread zm_fasttravel::function_cbb08198e7c84adf( s_destination, player );
    player thread zm_fasttravel::fasttravel_cooldown_timer( self );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xdc82b05d, Offset: 0x3797
// Size: 0x14e
function private blast_nearby_zombies( var_2a9029c4dff4dca, var_74292dbfd1a437c0 )
{
    playfx( level._effect[ "mq_blast" ], self.origin );
    a_zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in a_zombies )
    {
        if ( distance( zombie.origin, self.origin ) < var_2a9029c4dff4dca )
        {
            if ( zombie.var_448e341eabe9a3f5 )
            {
                continue;
            }
            
            if ( zombie.magic_bullet_shield || zombie.damageshield )
            {
                if ( !zombie val::get( "damageshield_allow_delete" ) )
                {
                    continue;
                }
                
                zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
            }
            
            zombie.var_a13bed1ac47e1b2c = 1;
            
            if ( var_74292dbfd1a437c0 )
            {
                zombie zm_cleanup_manager::function_dd62e2042418b7e5( 0 );
            }
            
            zombie kill();
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xb5af478b, Offset: 0x38ed
// Size: 0xba
function private flash_all_players( var_74e5ff44bcadcf72, n_radius )
{
    foreach ( player in level.players )
    {
        if ( distance( player.origin, var_74e5ff44bcadcf72.origin ) < n_radius )
        {
            player thread function_c473ef2ca3032767();
            player stoprumble( "damage_light" );
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xa837f1cb, Offset: 0x39af
// Size: 0x1d2
function private function_c473ef2ca3032767()
{
    self notify( #"play_nuke_screen_flash" );
    self endon( #"death_or_disconnect" );
    self endon( #"play_nuke_screen_flash" );
    
    if ( !isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay = newclienthudelem( self );
        self.white_screen_overlay.x = 0;
        self.white_screen_overlay.y = 0;
        self.white_screen_overlay setshader( "white", 640, 480 );
        self.white_screen_overlay.alignx = "left";
        self.white_screen_overlay.aligny = "top";
        self.white_screen_overlay.sort = 1;
        self.white_screen_overlay.horzalign = "fullscreen";
        self.white_screen_overlay.vertalign = "fullscreen";
        self.white_screen_overlay.alpha = 0;
        self.white_screen_overlay.foreground = 1;
        self.white_screen_overlay.archived = 0;
    }
    
    var_24c3037417857a23 = 0.2;
    n_target_alpha = 0.8;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = n_target_alpha;
    wait 1;
    var_24c3037417857a23 = 0.5;
    self.white_screen_overlay fadeovertime( var_24c3037417857a23 );
    self.white_screen_overlay.alpha = 0;
    wait var_24c3037417857a23;
    
    if ( isdefined( self.white_screen_overlay ) )
    {
        self.white_screen_overlay destroy();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0xdaec148f, Offset: 0x3b89
// Size: 0x18b
function spawn_base_zombie( spawner, var_be10289044c6269d )
{
    zone = zone_manager::function_90e5c3e2272b0130( spawner.origin );
    zombie_type = function_b3988325430ce242( "zombie_base" );
    agent = zone_spawner::spawn_agent( zombie_type, { #zones:[ zone ] } );
    agent.var_36a117d7034025b8 = 1;
    agent val::set( "ruby_pap", "ignore_cleanup", 1 );
    agent.no_powerups = 1;
    agent.kiastring = #"zombie_kia_mission_kill";
    
    if ( zm_round_logic::get_rb_round_number() < 8 )
    {
        agent zombie_utils::set_zombie_round_difficulty( 8 );
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( var_be10289044c6269d == "super_sprint" || var_be10289044c6269d == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && var_be10289044c6269d == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && var_be10289044c6269d == "sprint" ? "run" : var_be10289044c6269d, "opal_mq", 6 );
    agent setscriptablepartstate( "base", "base_purple_eyes" );
    return agent;
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xcb0858f2, Offset: 0x3d1d
// Size: 0x1d8
function setup_pap_machine()
{
    if ( level utility::flag( "ruby_papq_complete" ) )
    {
        return;
    }
    
    level.ruby_pap_ghost = spawnscriptable( "ruby_pap_ghost", level.var_db52bcfd04d45a7a[ 0 ].origin, level.var_db52bcfd04d45a7a[ 0 ].angles );
    
    foreach ( loc in level.var_db52bcfd04d45a7a )
    {
        loc.var_72ee3a4eceafc252 = utility::spawn_model( "tag_origin", loc.var_370acb837a3a86c3.origin, loc.var_370acb837a3a86c3.angles );
        
        if ( isdefined( loc.var_72ee3a4eceafc252 ) )
        {
            loc.var_370acb837a3a86c3 pack_a_punch::function_d38459448f4fef64( loc.var_72ee3a4eceafc252 );
            
            if ( loc.var_370acb837a3a86c3 )
            {
                loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "off" );
            }
        }
        
        if ( loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
        {
            loc.var_72ee3a4eceafc252 moveto( loc.origin + ( 0, 0, -9999 ), 0.1 );
            loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "idle" );
            loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_out" );
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0x1436c08d, Offset: 0x3efd
// Size: 0x4dc
function show_pap_machine( bvisible = 1 )
{
    if ( isarray( level.var_db52bcfd04d45a7a ) )
    {
        if ( bvisible )
        {
            foreach ( loc in level.var_db52bcfd04d45a7a )
            {
                if ( loc && loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
                {
                    s_pap_knockback = utility::getstruct( "pap_knockback_pos" );
                    a_players = getplayersinradius( s_pap_knockback.origin, s_pap_knockback.radius );
                    
                    foreach ( player in a_players )
                    {
                        v_knockback = vectornormalize( player.origin - s_pap_knockback.origin );
                        d_knockback = distance2d( player.origin, s_pap_knockback.origin );
                        player setorigin( getclosestpointonnavmesh( player.origin + v_knockback * ( 120 - d_knockback ) + ( 0, 0, 20 ) ), 0 );
                    }
                    
                    loc.var_72ee3a4eceafc252 moveto( loc.origin, 0.01 );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "active" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_in" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "on" );
                    loc.var_370acb837a3a86c3 thread function_43c227800e848176();
                    playfx( level._effect[ "pap_move_in" ], loc.origin, anglestoforward( loc.var_370acb837a3a86c3.angles ) );
                    playsoundatpos( loc.origin + ( 0, 0, 30 ), #"evt_zm_sat_pap_teleport_in" );
                    wait 0.1;
                    
                    if ( level.pap_quest.clip_pap )
                    {
                        level.pap_quest.clip_pap solid();
                        level.pap_quest.clip_pap moveto( level.pap_quest.clip_pap.origin + ( 0, 0, 9999 ), 0.01 );
                        wait 0.1;
                        level.pap_quest.clip_pap disconnectpaths();
                    }
                }
            }
            
            return;
        }
        
        foreach ( loc in level.var_db52bcfd04d45a7a )
        {
            if ( loc && loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
            {
                loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "off" );
                loc.var_72ee3a4eceafc252 moveto( loc.origin + ( 0, 0, -9999 ), 0.1 );
                loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "idle" );
                loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_out" );
                loc.var_370acb837a3a86c3 thread function_967524c1c124a7c2();
                playfx( level._effect[ "pap_move_away" ], loc.var_370acb837a3a86c3.origin, anglestoforward( loc.var_370acb837a3a86c3.angles ) );
                playsoundatpos( loc.origin + ( 0, 0, 30 ), #"evt_zm_sat_pap_teleport_out" );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x42c39c86, Offset: 0x43e1
// Size: 0x87
function setup_clips()
{
    clp_power_device = getent( "papq_clp_power_device", "script_noteworthy" );
    
    if ( clp_power_device )
    {
        clp_power_device solid();
        clp_power_device disconnectpaths();
    }
    
    clip_pap = getent( "papq_pap_clip", "script_noteworthy" );
    
    if ( clip_pap )
    {
        clip_pap moveto( clip_pap.origin + ( 0, 0, -9999 ), 0.1 );
        level.pap_quest.clip_pap = clip_pap;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0xf3921fac, Offset: 0x4470
// Size: 0xc6
function on_round_start( params )
{
    if ( level utility::flag( "papq_holdout_failed" ) )
    {
        level utility::flag_clear( "papq_holdout_failed" );
    }
    
    if ( level utility::flag( "papq_holdout_killoff" ) )
    {
        level utility::flag_clear( "papq_holdout_killoff" );
    }
    
    if ( level utility::flag( "papq_second_use_power_station" ) && !level utility::flag( "papq_in_holdout" ) && level.power_station_interact )
    {
        function_b3ad0f548ba2607c( "holdout_fight_start", level.power_station_interact.origin );
        stopfxontag( utility::getfx( "cooldown_smoke" ), level.var_d4d3b5b9c13ddd56, "tag_origin" );
        level.power_station setscriptablepartstate( "fx", "repaired" );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 1
// Checksum 0x8a927082, Offset: 0x453e
// Size: 0x284
function function_ec00029c19cbcb83( var_b3a3b3ac8ebccb6 )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    level endon( #"papq_near_telescope" );
    level endon( #"papq_player_reach_observatory" );
    path_a_doors_open = 0;
    path_b_doors_open = 0;
    var_db8a8c411c535cd = [];
    
    foreach ( struct in var_b3a3b3ac8ebccb6 )
    {
        var_db8a8c411c535cd[ var_db8a8c411c535cd.size ] = struct.script_parameters;
    }
    
    while ( maxint( path_a_doors_open, path_b_doors_open ) < 3 )
    {
        if ( path_a_doors_open == path_b_doors_open )
        {
            breadcrumb_structs = utility::getstructarray( "breadcrumb" + path_a_doors_open, "script_noteworthy" );
            function_b3ad0f548ba2607c( "pap_path_a", breadcrumb_structs[ 0 ].origin, !path_a_doors_open );
            function_b3ad0f548ba2607c( "pap_path_b", breadcrumb_structs[ 1 ].origin, !path_a_doors_open );
        }
        else
        {
            var_67b73be22ca38972 = utility::getstructarray( "breadcrumb" + maxint( path_a_doors_open, path_b_doors_open ), "script_noteworthy" );
            
            foreach ( breadcrumb_struct in var_67b73be22ca38972 )
            {
                if ( path_a_doors_open > path_b_doors_open && breadcrumb_struct.targetname == "pap_path_a" || path_b_doors_open > path_a_doors_open && breadcrumb_struct.targetname == "pap_path_b" )
                {
                    waypoint_pos = breadcrumb_struct.origin;
                }
            }
            
            function_b3ad0f548ba2607c( "pap_path", waypoint_pos, 0 );
        }
        
        door_opened = level utility::flag_wait_any_array( var_db8a8c411c535cd );
        var_db8a8c411c535cd = arrayremove( var_db8a8c411c535cd, door_opened );
        
        if ( door_opened == "doorbuy_landing_to_planetarium_bought" || door_opened == "doorbuy_planetarium_to_cliff_bought" || door_opened == "zone_telescope_enabled_left" )
        {
            path_a_doors_open++;
        }
        else
        {
            path_b_doors_open++;
        }
        
        function_bc09e387bd9ef978();
    }
    
    level thread function_2f895c9137d2534();
}

// Namespace zm_sat_ruby_quest_pap
// Params 3, eflags: 0x4
// Checksum 0xbd93f1b9, Offset: 0x47ca
// Size: 0x16e
function private function_b3ad0f548ba2607c( quest, var_10902a11e78437dc, var_4379bac2f2824e94 = 1 )
{
    if ( isarray( var_10902a11e78437dc ) )
    {
        foreach ( loc in var_10902a11e78437dc )
        {
            objectiveindex = zm_quest::function_b98d4144845ffc13( quest, 1, "ui_icon_zm_objective", "icon_small_medium", "current", loc, undefined, undefined, undefined, 1, var_4379bac2f2824e94 );
            wp = spawnstruct();
            wp.objectiveindex = objectiveindex;
            wp.quest = quest;
            level.var_5a5d8193365abd09[ wp.quest ] = wp;
        }
        
        return;
    }
    
    if ( level.var_5a5d8193365abd09[ quest ] )
    {
        return;
    }
    
    objectiveindex = zm_quest::function_b98d4144845ffc13( quest, 1, "ui_icon_zm_objective", "icon_small_medium", "current", var_10902a11e78437dc, undefined, undefined, undefined, 1, var_4379bac2f2824e94 );
    wp = spawnstruct();
    wp.objectiveindex = objectiveindex;
    wp.quest = quest;
    level.var_5a5d8193365abd09[ quest ] = wp;
}

// Namespace zm_sat_ruby_quest_pap
// Params 1, eflags: 0x4
// Checksum 0xa39dfd6d, Offset: 0x4940
// Size: 0x30
function private function_c0cf34da0bb458db( quest )
{
    if ( level.var_5a5d8193365abd09[ quest ] )
    {
        zm_quest::complete_objective_waypoints( quest );
        level.var_5a5d8193365abd09[ quest ] = undefined;
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x1e0d7caf, Offset: 0x4978
// Size: 0xa8
function private function_bc09e387bd9ef978()
{
    if ( level.var_5a5d8193365abd09.size > 0 )
    {
        foreach ( wp in level.var_5a5d8193365abd09 )
        {
            zm_quest::complete_objective_waypoints( wp.objectiveindex );
            level.var_5a5d8193365abd09[ wp.quest ] = undefined;
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0xf77017bd, Offset: 0x4a28
// Size: 0x8a
function private function_3ee5d8e12db60f30()
{
    foreach ( s_circle in level.quest_circles )
    {
        if ( s_circle )
        {
            s_circle game_utility::questcircle_delete();
        }
    }
    
    level.quest_circles = undefined;
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x2c7b6514, Offset: 0x4aba
// Size: 0x11
function is_pap_quest_complete()
{
    return zm_quest::is_quest_complete( #"ruby_pap" );
}

// Namespace zm_sat_ruby_quest_pap
// Params 2
// Checksum 0xb8911dd2, Offset: 0x4ad4
// Size: 0x50
function function_63796209d730453f( a_flags, var_cdb665c03b873a33 )
{
    level endon( #"game_ended" );
    level endon( #"open_sesame" );
    
    if ( isarray( a_flags ) )
    {
        level utility::flag_wait_any_array( a_flags );
    }
    
    if ( isdefined( var_cdb665c03b873a33 ) )
    {
        level utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x186e7a5, Offset: 0x4b2c
// Size: 0xa3
function private watch_open_sesame()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "open_sesame" );
    wait 3;
    
    foreach ( step in level.pap_quest.steps )
    {
        level zm_quest::function_e65609834444650c( step, 0 );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x69e543cd, Offset: 0x4bd7
// Size: 0xf
function private function_43c227800e848176()
{
    wait 0.2;
    thread function_5b5d259380f19b29();
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x623dabc, Offset: 0x4bee
// Size: 0x1f
function private function_967524c1c124a7c2()
{
    if ( isdefined( self.jingle_trigger ) )
    {
        self.jingle_trigger function_bdb3cd9488bdadd2();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0xc34b41db, Offset: 0x4c15
// Size: 0x9b
function function_5b5d259380f19b29()
{
    trigger = spawn( "noent_volume_trigger_radius", self.origin - 400, 0, 1500, 800 );
    trigger.var_9f9432741e058419 = self;
    trigger.watcheractive = 0;
    self.jingle_trigger = trigger;
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( trigger, &function_649a2bdbddbbbd58, &function_d3a78ff7491224f6, undefined, undefined, &function_534b782ad8a9c04f );
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xf8049bd7, Offset: 0x4cb8
// Size: 0x45
function private function_649a2bdbddbbbd58( player, trigger )
{
    waitframe();
    
    if ( !trigger.watcheractive )
    {
        trigger.watcheractive = 1;
        trigger.var_9f9432741e058419 thread function_14f9586eb59f5550();
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0x3b946dee, Offset: 0x4d05
// Size: 0x7c
function private function_d3a78ff7491224f6( player, trigger )
{
    waitframe();
    
    if ( isdefined( trigger ) )
    {
        if ( trigger.triggerenterents.size <= 0 )
        {
            trigger.watcheractive = 0;
            trigger.var_9f9432741e058419 notify( #"hash_fd1062382b3d7c69" );
            
            if ( trigger.var_9f9432741e058419 isscriptableinstance() )
            {
                trigger.var_9f9432741e058419 setscriptablepartstate( "music", "off" );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_pap
// Params 2, eflags: 0x4
// Checksum 0xde435bf5, Offset: 0x4d89
// Size: 0x24, Type: bool
function private function_534b782ad8a9c04f( enteringentity, trigger )
{
    return !isplayer( enteringentity ) || !isdefined( trigger );
}

// Namespace zm_sat_ruby_quest_pap
// Params 0, eflags: 0x4
// Checksum 0x9f109dfc, Offset: 0x4db6
// Size: 0x44
function private function_bdb3cd9488bdadd2()
{
    self.var_9f9432741e058419 notify( #"hash_fd1062382b3d7c69" );
    
    if ( self.var_9f9432741e058419 isscriptableinstance() )
    {
        self.var_9f9432741e058419 setscriptablepartstate( "music", "off" );
    }
    
    self delete();
}

// Namespace zm_sat_ruby_quest_pap
// Params 0
// Checksum 0x1eb401ac, Offset: 0x4e02
// Size: 0xac
function function_14f9586eb59f5550()
{
    self endon( #"death" );
    self endon( #"hash_fd1062382b3d7c69" );
    
    if ( !self isscriptableinstance() )
    {
        return;
    }
    
    if ( self getscriptablepartstate( "music" ) != "off" )
    {
        wait 30;
    }
    
    while ( self.jingle_trigger.triggerenterents.size > 0 )
    {
        wait randomintrange( 10, 20 );
        
        if ( self getscriptablehaspart( "music" ) )
        {
            if ( self getscriptablepartstate( "music" ) == "off" )
            {
                self setscriptablepartstate( "music", "specialty_pap_jingle", 0 );
                
                while ( self getscriptablepartstate( "music" ) != "off" )
                {
                    wait 2;
                }
                
                wait 60;
            }
        }
    }
}

/#

    // Namespace zm_sat_ruby_quest_pap
    // Params 0
    // Checksum 0x60845579, Offset: 0x4eb6
    // Size: 0x18, Type: dev
    function init_ruby_pap_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_77df7fe7dd273e10();
    }

#/
