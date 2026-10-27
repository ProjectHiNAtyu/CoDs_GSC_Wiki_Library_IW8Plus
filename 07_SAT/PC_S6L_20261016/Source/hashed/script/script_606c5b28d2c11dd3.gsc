// script_606c5b28d2c11dd3  (hash_606c5b28d2c11dd3.gscc) (size: 44759 Bytes / 0xaed7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xece0a481 (3974145153)
// size ...... 44759 (0xaed7)
// includes .. 28  (offset: 0xa62b)
// strings ... 85  (offset: 0xa70b)
// dev strs .. 52  (offset: 0xac4b)
// exports ... 102 (offset: 0x7193)
// cseg ...... 0x7fd + 0x6996 (0x7193)
// imports ... 285 (offset: 0x8183)
// animtree1 . 0   (offset: 0xaed7)
// animtree2 . 0   (offset: 0xaed7)
#using script_10f6fed49001c470;
#using script_294e8d1ebcb1de03;
#using script_48a5b607db42e429;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\common\killstreaks\isotope_core;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\final_killcam;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace namespace_66d2304510c46347;

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x5
// Checksum 0x355cb019, Offset: 0x81b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_660b8b25ad0b3389", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x5e1e7824, Offset: 0x844
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_IRONCLAD_TRUCK_PHASE", &activity_type_init );
}

// Namespace namespace_66d2304510c46347
// Params 0
// Checksum 0xd39f0f2, Offset: 0x85f
// Size: 0xdf
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TRUCK_PHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TRUCK_PHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TRUCK_PHASE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_TRUCK_PHASE", 3, &function_d4acef179eb9f9b2 );
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_3ec6415954bbb346", "ELITE_JAILBREAK_VARIANT" );
    function_e561987fac5310a8();
    init_dev_gui();
    level.elite_ironclad.var_dc2d8c66e9fbafd7 = getdvarint( @"hash_c2fddb1d24e09833", 1 );
    level.elite_ironclad.var_e93bbac657881858 = getdvarfloat( @"hash_e748bf5c79002880", 600 );
    level.elite_ironclad.var_88c711f4240b7059 = getdvarfloat( @"hash_503f460804a16921", 200 );
}

// Namespace namespace_66d2304510c46347
// Params 0
// Checksum 0x3b4a0548, Offset: 0x946
// Size: 0x6c
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    activity_instance.analytics = {};
    
    /#
        level.elite_ironclad.dev_activity_instance = activity_instance;
    #/
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_66d2304510c46347
// Params 0
// Checksum 0xd154a558, Offset: 0x9ba
// Size: 0x4c
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.analytics.start_time = gettime();
    activity_instance truck_phase_flow();
}

// Namespace namespace_66d2304510c46347
// Params 0
// Checksum 0xbf5d553c, Offset: 0xa0e
// Size: 0xaf
function activity_ended()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance activity_cleanup();
    activity_instance.analytics.ended_time = gettime();
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( activity_instance );
    
    if ( activity_succeeded )
    {
        level.elite_ironclad.endingdetonated = 1;
        return;
    }
    
    if ( activity_instance.var_fb30b66e38f251b7 )
    {
        level.elite_ironclad.var_1f3bb3cf02895b4e = activity_instance.var_5bfc66666c61d99f;
        function_752b0a26ef315196( activity_instance.var_5bfc66666c61d99f[ 1 ] );
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xae245dec, Offset: 0xac5
// Size: 0x98
function private function_752b0a26ef315196( saviors_team )
{
    level.elite_ironclad.endingdisarmed = 1;
    level.shownonspectatingwinnersplash = 1;
    
    if ( getdvarint( @"hash_3ed094168951c6b0", 0 ) )
    {
        level.br_ending_delay = 8.5;
        setomnvar( "ui_br_use_bink_for_post_game_results", 1 );
    }
    else
    {
        level.br_ending_delay = 11;
        setomnvar( "ui_br_use_bink_for_post_game_results", 0 );
    }
    
    setomnvar( "ui_br_elite_ironclad_show_endgame_splash_to_losers", 1 );
    level thread gamelogic_mp::endgame( saviors_team, game[ "end_reason" ][ "nuke_end" ], undefined, 0, 1 );
}

// Namespace namespace_66d2304510c46347
// Params 0
// Checksum 0x22bd9393, Offset: 0xb65
// Size: 0x20b
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance activity_cleanup();
    a = activity_instance.analytics;
    truck_origin_final = level.elite_ironclad.truck.origin;
    dlog_recordevent( "dlog_event_br_elite_ironclad_truck", [ "start_time", a.start_time ?? 0, "isotope_inserted_time", a.isotope_inserted_time ?? 0, "isotope_inserted_player", a.isotope_inserted_player ?? 0, "escort_finished_time", a.escort_finished_time ?? 0, "missile_armed_time", a.missile_armed_time ?? 0, "sabotage_player_1", a.sabotage_players[ 0 ] ?? 0, "sabotage_player_2", a.sabotage_players[ 1 ] ?? 0, "ended_time", a.ended_time ?? 0, "ended_reason", a.ended_reason ?? "unknown", "truck_x_initial", a.truck_origin_initial[ 0 ] ?? 0, "truck_y_initial", a.truck_origin_initial[ 1 ] ?? 0, "truck_z_initial", a.truck_origin_initial[ 2 ] ?? 0, "truck_x_final", truck_origin_final[ 0 ] ?? 0, "truck_y_final", truck_origin_final[ 1 ] ?? 0, "truck_z_final", truck_origin_final[ 2 ] ?? 0 ] );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xd74a8727, Offset: 0xd78
// Size: 0x56
function private activity_cleanup()
{
    activity_instance = self;
    remove_all_interacts();
    function_a854cc6f5d5224d1();
    
    if ( level.elite_ironclad.truck )
    {
        level.elite_ironclad.truck elite_ironclad_truck::function_d96ad411c7647a7d();
    }
    
    activity_instance game_utility::questcircle_delete();
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xf8a008d3, Offset: 0xdd6
// Size: 0x34
function private function_e561987fac5310a8()
{
    level._effect[ "vfx_cq_scud_isotope_insertion" ] = loadfxasset( "vfx_saw_gameplay_scud_launcher_isotope_insertion" );
    level._effect[ "vfx_cq_scud_launcher_fail" ] = loadfxasset( "vfx_saw_gameplay_cq_scud_launcher_fail_aftermath" );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xe6699c29, Offset: 0xe12
// Size: 0xd0
function private truck_phase_flow()
{
    activity_instance = self;
    quest_circle_id = activity_instance.var_332f929de1894b2b.var_cd559e8dec966d18 ?? "elite_ironclad_truck";
    quest_circle_radius = activity_instance.var_332f929de1894b2b.var_ead42b00abc2922b ?? 1000;
    level.elite_ironclad.team_info.state = 9;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    activity_instance game_utility::questcircle_create( quest_circle_id, level.elite_ironclad.truck.origin, quest_circle_radius );
    activity_instance game_utility::questcircle_showtoall();
    activity_instance function_f3b3230525b790e0();
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x14c7adbe, Offset: 0xeea
// Size: 0xb3
function private function_f3b3230525b790e0()
{
    activity_instance = self;
    activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_scud_arm" );
    
    if ( activity_instance.var_332f929de1894b2b.var_8a8b1c9a6ef08ccb )
    {
        hud_util::showsplashtoteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_8a8b1c9a6ef08ccb, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    if ( getdvarint( @"hash_7f616782009d1ded", 1 ) == 1 )
    {
        activity_instance function_d169b4b2c7b5bb6f( get_allowed_players( activity_instance.team, 0 ) );
        return;
    }
    
    activity_instance function_9423d0e55acbecbd( get_allowed_players( activity_instance.team, 0 ) );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x356c8254, Offset: 0xfa5
// Size: 0x17f
function private function_9423d0e55acbecbd( allowed_players )
{
    truck = level.elite_ironclad.truck;
    activity_instance = self;
    var_da5b5ecdf31f537e = activity_instance.var_332f929de1894b2b.isotopeinteraction;
    var_a89bc83f15301e7 = var_da5b5ecdf31f537e.var_134d66b48760a417 ?? "tag_isotope";
    assert( isdefined( truck ), "<dev string:x24>" );
    assert( truck tagexists( var_a89bc83f15301e7 ), "<dev string:x6d>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    var_ea425a4d8a6949eb = { #activity_instance:activity_instance, #hint_string_callback:&function_238ec49363d014e7, #callback:&function_b4b1e1962eef29f4, #tag_angle_offset:( 0, -90, 0 ), #var_a89bc83f15301e7:var_a89bc83f15301e7, #angles:truck.angles + ( 0, -90, 0 ), #origin:truck gettagorigin( var_a89bc83f15301e7 ) };
    isotope_interact = create_interaction( var_ea425a4d8a6949eb, var_da5b5ecdf31f537e, allowed_players );
    level.elite_ironclad.isotope_interacts = [ isotope_interact ];
    function_ff00cbf5d28eb319( isotope_interact, var_da5b5ecdf31f537e.interactionobjectivemarker, activity_instance.team, 0 );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x8c84e2c2, Offset: 0x112c
// Size: 0x187
function private function_d169b4b2c7b5bb6f( allowed_players )
{
    truck = level.elite_ironclad.truck;
    activity_instance = self;
    var_da5b5ecdf31f537e = activity_instance.var_332f929de1894b2b.isotopeinteraction;
    var_a89bc83f15301e7 = "tag_missile_hatch_animate";
    assert( isdefined( truck ), "<dev string:xf1>" );
    assert( truck tagexists( var_a89bc83f15301e7 ), "<dev string:x140>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    var_ea425a4d8a6949eb = { #activity_instance:activity_instance, #hint_string_callback:&function_238ec49363d014e7, #callback:&function_84bb46bead62a27b, #tag_angle_offset:( 0, 0, 0 ), #var_6723ba7fdd3a97b0:( -15, 0, 0 ), #var_a89bc83f15301e7:var_a89bc83f15301e7, #angles:truck.angles + ( 0, 0, 0 ), #origin:truck gettagorigin( var_a89bc83f15301e7 ) };
    isotope_interact = create_interaction( var_ea425a4d8a6949eb, var_da5b5ecdf31f537e, allowed_players );
    level.elite_ironclad.isotope_interacts = [ isotope_interact ];
    function_ff00cbf5d28eb319( isotope_interact, var_da5b5ecdf31f537e.interactionobjectivemarker, activity_instance.team, 0 );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x4f793e05, Offset: 0x12bb
// Size: 0x120
function private function_238ec49363d014e7( interact, player )
{
    if ( player.team != level.elite_ironclad.cq_team )
    {
        return { #interactable:0, #string:&"", #type:"HINT_NODISPLAY" };
    }
    
    var_4f37fc1b0c79ec2f = !player function_7f926062a103a6c0();
    
    /#
        if ( level.elite_ironclad.var_a9c6204649207507 )
        {
            var_4f37fc1b0c79ec2f = 0;
        }
    #/
    
    if ( var_4f37fc1b0c79ec2f )
    {
        return { #interactable:0, #string:&"hash_a23d17530bacdf0", #type:"HINT_NOBUTTON" };
    }
    
    level.elite_ironclad.team_info.state = 10;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    return { #string:&"hash_6f4065eefae9f740", #type:"HINT_BUTTON" };
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xe7c8a6e3, Offset: 0x13e4
// Size: 0x1ff
function private function_b4b1e1962eef29f4( player )
{
    interact = self;
    activity_instance = interact.activity_instance;
    isotope_data = player function_7f926062a103a6c0();
    var_9b3e71f56964da23 = 0;
    
    /#
        if ( level.elite_ironclad.var_a9c6204649207507 )
        {
            var_9b3e71f56964da23 = 1;
        }
    #/
    
    if ( !isotope_data && !var_9b3e71f56964da23 )
    {
        return;
    }
    
    level.elite_ironclad.team_info.state = 11;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    
    if ( !var_9b3e71f56964da23 )
    {
        player consume_isotope_core( isotope_data );
    }
    
    player thread isotope_core::function_a30381907703515c();
    activity_instance.analytics.isotope_inserted_time = gettime();
    activity_instance.analytics.isotope_inserted_player = player getplayerunoid();
    activity_instance.analytics.truck_origin_initial = level.elite_ironclad.truck.origin;
    playfxontag( utility::getfx( "vfx_cq_scud_isotope_insertion" ), level.elite_ironclad.truck, "tag_keypad" );
    wait 2;
    remove_interacts( level.elite_ironclad.isotope_interacts );
    level.elite_ironclad.isotope_interacts = undefined;
    level.elite_ironclad.truck setscriptablepartstate( #"keypad_material", #"ready" );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_payload_isotope_delivered", #scope:1 } );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_payload_enemy_isotope_delivered", #scope:2 } );
    activity_instance function_d4b353bda298fa5c();
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x5b655f60, Offset: 0x15eb
// Size: 0x281
function private function_84bb46bead62a27b( player )
{
    interact = self;
    activity_instance = interact.activity_instance;
    truck = level.elite_ironclad.truck;
    isotope_data = player function_7f926062a103a6c0();
    var_9b3e71f56964da23 = 0;
    
    /#
        if ( level.elite_ironclad.var_a9c6204649207507 )
        {
            var_9b3e71f56964da23 = 1;
        }
    #/
    
    if ( !isotope_data && !var_9b3e71f56964da23 )
    {
        return;
    }
    
    level.elite_ironclad.team_info.state = 11;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    
    if ( !var_9b3e71f56964da23 )
    {
        player consume_isotope_core( isotope_data );
    }
    
    player thread isotope_core::function_a30381907703515c();
    activity_instance.analytics.isotope_inserted_time = gettime();
    activity_instance.analytics.isotope_inserted_player = player getplayerunoid();
    activity_instance.analytics.truck_origin_initial = level.elite_ironclad.truck.origin;
    truck thread elite_ironclad_truck::function_24717faf99601fae();
    truck playsound( "evt_br_portable_nuke_device_open" );
    wait 1;
    scriptable = spawnscriptable( "brloot_killstreak_isotope_core", ( -57, 1, 120 ), ( 90, 0, 0 ), truck );
    scriptable setscriptablepartstate( "brloot_killstreak_isotope_core", "visible_outline_unusable" );
    playfx( utility::getfx( "vfx_cq_scud_isotope_insertion" ), scriptable.origin, ( 0, 0, 1 ) );
    remove_interacts( level.elite_ironclad.isotope_interacts );
    level.elite_ironclad.isotope_interacts = undefined;
    level.elite_ironclad.truck setscriptablepartstate( #"keypad_material", #"ready" );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_payload_isotope_delivered", #scope:1 } );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:"elite_ironclad_payload_enemy_isotope_delivered", #scope:2 } );
    wait 2;
    scriptable freescriptable();
    activity_instance function_d4b353bda298fa5c();
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xa49df8f7, Offset: 0x1874
// Size: 0x1e2
function private function_d4b353bda298fa5c()
{
    activity_instance = self;
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( activity_instance );
    
    if ( additional_spawn_data.parent_activity && getdvarint( @"hash_8223aac299f08def", 1 ) == 1 )
    {
        additional_spawn_data.parent_activity notify( #"hash_712bc7b5bc2fdeb7" );
    }
    
    activity_instance.var_fb30b66e38f251b7 = activity_instance.var_332f929de1894b2b.var_3f09dc804fa2eff9 ?? 600000;
    level.elite_ironclad.team_info.state = 11;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    var_c4c75c26c8d585ee = utility::function_edc4cc03e9e60b3e( @"hash_505a93f0eb14b949", 10000, activity_instance.var_332f929de1894b2b.var_6be671db9fb83e70 ) / 1000;
    activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_scud_defend" );
    
    if ( activity_instance.var_332f929de1894b2b.var_542a08aac4b07c0d )
    {
        hud_util::showsplashtoteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_542a08aac4b07c0d, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    activity_instance function_eccd3fb2fad9eb83();
    activity_instance function_30a9abd926c91cdb( activity_instance.team );
    activity_instance function_99846750895b045e( activity_instance.team );
    activity_instance function_7892c5f3a9bac7ad();
    activity_instance function_77b0f57e589bb2c0();
    activity_instance function_709f40d6f5f083cd();
    level.elite_ironclad.truck setscriptablepartstate( #"hash_b81dff843532a6b8", #"show" );
    level.elite_ironclad.truck setcandamage( 0 );
    activity_instance function_3c081279290c0482( var_c4c75c26c8d585ee );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x7419054f, Offset: 0x1a5e
// Size: 0x167
function private function_709f40d6f5f083cd()
{
    if ( !level.elite_ironclad.var_dc2d8c66e9fbafd7 )
    {
        return;
    }
    
    foreach ( interact in level.elite_ironclad.sabotage_interacts )
    {
        function_a658977639e11f16( interact, level.elite_ironclad.truck );
    }
    
    function_41d37c016b583ab0( level.elite_ironclad.truck.angles[ 1 ], level.elite_ironclad.truck );
    function_41d37c016b583ab0( level.elite_ironclad.truck.angles[ 1 ] + 180, level.elite_ironclad.truck );
    function_41d37c016b583ab0( level.elite_ironclad.truck.angles[ 1 ], level.elite_ironclad.truck, 400, 800 );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x46a8947c, Offset: 0x1bcd
// Size: 0x141
function private function_179a95e96746de03()
{
    /#
        if ( getdvarint( @"hash_4929d31d5362f179", -1 ) >= 0 )
        {
            return level.elite_ironclad.killcaments[ getdvarint( @"hash_4929d31d5362f179" ) ];
        }
    #/
    
    truck = level.elite_ironclad.truck;
    contentoverride = trace::create_contents( 0, 1, 0, 1, 1, 1, 1 );
    
    for ( i = 0; i < level.elite_ironclad.killcaments.size ; i++ )
    {
        ent = level.elite_ironclad.killcaments[ i ];
        trace = trace::ray_trace( ent gettagorigin( "tag_flash" ), level.elite_ironclad.var_8986f2401df91150 + ( 0, 0, 30 ), [ truck ], contentoverride );
        
        if ( trace[ "fraction" ] == 1 )
        {
            return ent;
        }
    }
    
    return level.elite_ironclad.killcaments[ level.elite_ironclad.killcaments.size - 1 ];
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xab198870, Offset: 0x1d17
// Size: 0x99
function private function_eccd3fb2fad9eb83()
{
    triggerjailbreak = utility::function_edc4cc03e9e60b3e( @"scr_elite_ironclad_truck_jailbreak", 1, self.var_332f929de1894b2b.triggerjailbreak );
    
    if ( !triggerjailbreak )
    {
        return;
    }
    
    jailbreakwaittime = utility::function_48f723fdc612ec65( @"hash_2fbd37e8c5b0d29b", 3, self.var_332f929de1894b2b.jailbreakdelay );
    
    if ( jailbreakwaittime > 0 )
    {
        wait jailbreakwaittime;
    }
    
    activity_instance_common::function_9b387cb1af0d5b4b( "ELITE_JAILBREAK_VARIANT", undefined, { #block_team_list:[ self.team ] } );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xe7089b9, Offset: 0x1db8
// Size: 0x25a
function private function_30a9abd926c91cdb( cq_team )
{
    truck = level.elite_ironclad.truck;
    activity_instance = self;
    var_85d7fce451f6a760 = activity_instance.var_332f929de1894b2b.var_514613d89a85e81;
    var_a89bc83f15301e7 = var_85d7fce451f6a760.var_134d66b48760a417 ?? "tag_door_front_left";
    assert( isdefined( truck ), "<dev string:x1bb>" );
    assert( utility::hastag( truck.model, var_a89bc83f15301e7 ), "<dev string:x202>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    initial_cooldown_ms = utility::function_edc4cc03e9e60b3e( @"hash_2cff37cd5d08e40c", 0, activity_instance.var_332f929de1894b2b.var_bd5b6d3017bc28b6.var_547c6f7863c07aee );
    truck.var_1cb645692f33f854 = gettime() + initial_cooldown_ms;
    interaction_data = { #activity_instance:activity_instance, #hint_string_callback:&"hash_2688fc7976609f7d", #callback:&function_4cfcc1fde63ced9e, #tag_angle_offset:( 0, 90, 0 ), #var_6723ba7fdd3a97b0:( 0, 8, -2 ), #var_a89bc83f15301e7:var_a89bc83f15301e7, #angles:truck.angles + ( 0, 90, 0 ), #origin:truck gettagorigin( var_a89bc83f15301e7 ) };
    allowed_players = get_allowed_players( cq_team, 0 );
    smoke_interact = create_interaction( interaction_data, var_85d7fce451f6a760, allowed_players );
    smoke_interact thread function_a02cf11e62d1a7cb();
    level.elite_ironclad.smoke_interacts = [ smoke_interact ];
    
    if ( var_85d7fce451f6a760.interactionobjectivemarker )
    {
        function_ff00cbf5d28eb319( smoke_interact, var_85d7fce451f6a760.interactionobjectivemarker, activity_instance.team, 0 );
    }
    
    smoke_interact function_b6e03794bbf4e38e( truck elite_ironclad_truck::function_18603e0eb7d8bb55() );
    elite_ironclad_truck::init_smoke_vfx( activity_instance.var_332f929de1894b2b.var_bd5b6d3017bc28b6.var_2b0d8b8e36dadf31 ?? "vfx_iw8_mp_equip_smoke_grenade_gren_ch" );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x694c7d4f, Offset: 0x201a
// Size: 0x111
function private function_4cfcc1fde63ced9e( player )
{
    truck = level.elite_ironclad.truck;
    
    if ( !truck || !truck elite_ironclad_truck::function_18603e0eb7d8bb55() )
    {
        return;
    }
    
    smoke_interaction = self;
    var_4ce4251ea5a77569 = smoke_interaction.activity_instance.var_332f929de1894b2b.var_bd5b6d3017bc28b6;
    cooldown_time = utility::function_edc4cc03e9e60b3e( @"hash_6a6475f5e8b18abf", 0, var_4ce4251ea5a77569.cooldowntime );
    duration_ms = utility::function_edc4cc03e9e60b3e( @"hash_da82137b98adf010", 30000, var_4ce4251ea5a77569.duration );
    assert( cooldown_time >= duration_ms, "<dev string:x273>" + cooldown_time + "<dev string:x332>" + duration_ms );
    
    if ( cooldown_time < duration_ms )
    {
        cooldown_time = duration_ms;
    }
    
    truck.var_1cb645692f33f854 = gettime() + cooldown_time;
    smoke_interaction function_b6e03794bbf4e38e( 0 );
    truck thread elite_ironclad_truck::function_2b0962ff066f1ca4( var_4ce4251ea5a77569, duration_ms, player );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x5a25fa41, Offset: 0x2133
// Size: 0x84
function private function_a02cf11e62d1a7cb()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    truck = level.elite_ironclad.truck;
    smoke_interaction = self;
    currently_usable = 0;
    
    while ( isdefined( self ) )
    {
        var_ec248cf79437ccaf = truck elite_ironclad_truck::function_18603e0eb7d8bb55();
        
        if ( var_ec248cf79437ccaf != currently_usable )
        {
            currently_usable = var_ec248cf79437ccaf;
            smoke_interaction function_b6e03794bbf4e38e( var_ec248cf79437ccaf );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x3f695432, Offset: 0x21bf
// Size: 0x69
function private function_b6e03794bbf4e38e( var_ec248cf79437ccaf )
{
    smoke_interaction = self;
    smoke_interaction function_3c3f6cea61874f43( var_ec248cf79437ccaf, smoke_interaction.activity_instance.team );
    smoke_interaction disableplayeruseforallplayers();
    
    if ( var_ec248cf79437ccaf )
    {
        smoke_interaction enable_interaction( get_allowed_players( smoke_interaction.activity_instance.team, 0 ) );
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xef1d6430, Offset: 0x2230
// Size: 0x333
function private function_99846750895b045e( cq_team )
{
    truck = level.elite_ironclad.truck;
    activity_instance = self;
    level.elite_ironclad.sabotage_interacts = [];
    assert( isdefined( truck ), "<dev string:x344>" );
    callback = &function_39d4eed12332f770;
    interaction_data = { #hint_string_callback:&"hash_749d2b9eb3490f47", #activity_instance:activity_instance, #callback:callback };
    var_1f2177f7df874910 = activity_instance.var_332f929de1894b2b.var_e84107a41dbd40e8;
    var_a89bc83f15301e7 = var_1f2177f7df874910.var_134d66b48760a417 ?? "tag_sabotage02";
    assert( utility::hastag( truck.model, var_a89bc83f15301e7 ), "<dev string:x385>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    interaction_data.origin = truck gettagorigin( var_a89bc83f15301e7 );
    interaction_data.angles = truck.angles + ( 0, -90, 0 );
    interaction_data.var_a89bc83f15301e7 = var_a89bc83f15301e7;
    interaction_data.var_6723ba7fdd3a97b0 = ( 0, 10, 0 );
    interaction_data.tag_angle_offset = ( 0, -90, 0 );
    allowed_players = get_allowed_players( cq_team, 1 );
    interact = create_interaction( interaction_data, var_1f2177f7df874910, allowed_players );
    level.elite_ironclad.sabotage_interacts[ level.elite_ironclad.sabotage_interacts.size ] = interact;
    function_ff00cbf5d28eb319( interact, var_1f2177f7df874910.interactionobjectivemarker, activity_instance.team, 1 );
    var_e225f5d8821f38d7 = activity_instance.var_332f929de1894b2b.var_e8410aa41dbd4781;
    var_a89bc83f15301e7 = var_e225f5d8821f38d7.var_134d66b48760a417 ?? "tag_sabotage01";
    assert( utility::hastag( truck.model, var_a89bc83f15301e7 ), "<dev string:x385>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    interaction_data.origin = truck gettagorigin( var_a89bc83f15301e7 );
    interaction_data.angles = truck.angles + ( 0, 90, 0 );
    interaction_data.var_a89bc83f15301e7 = var_a89bc83f15301e7;
    interaction_data.var_6723ba7fdd3a97b0 = ( 0, -10, 0 );
    interaction_data.tag_angle_offset = ( 0, 90, 0 );
    interact = create_interaction( interaction_data, var_e225f5d8821f38d7, allowed_players );
    level.elite_ironclad.sabotage_interacts[ level.elite_ironclad.sabotage_interacts.size ] = interact;
    function_ff00cbf5d28eb319( interact, var_e225f5d8821f38d7.interactionobjectivemarker, activity_instance.team, 1 );
}

// Namespace namespace_66d2304510c46347
// Params 4, eflags: 0x4
// Checksum 0x3b66dfc, Offset: 0x256b
// Size: 0x10f
function private function_41d37c016b583ab0( yaw, truck, var_f58774f820380bdc, overrideheight )
{
    if ( !level.elite_ironclad.var_dc2d8c66e9fbafd7 )
    {
        return;
    }
    
    org = truck.origin + ( 0, 0, 30 );
    radius = var_f58774f820380bdc ?? level.elite_ironclad.var_e93bbac657881858;
    height = overrideheight ?? level.elite_ironclad.var_88c711f4240b7059;
    angle = yaw;
    offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
    killcamorg = org + offset + ( 0, 0, height );
    dir = org - killcamorg;
    killcamang = vectortoangles( dir );
    function_db64258bc8fbeeaf( killcamorg, killcamang, truck );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x2d7b7d3, Offset: 0x2682
// Size: 0xf1
function private function_a658977639e11f16( interact, truck )
{
    if ( !level.elite_ironclad.var_dc2d8c66e9fbafd7 )
    {
        return;
    }
    
    interactorg = interact.origin;
    radius = level.elite_ironclad.var_e93bbac657881858;
    height = level.elite_ironclad.var_88c711f4240b7059;
    angle = interact.angles[ 1 ];
    offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
    killcamorg = interactorg + offset + ( 0, 0, height );
    dir = interactorg - killcamorg;
    killcamang = vectortoangles( dir );
    function_db64258bc8fbeeaf( killcamorg, killcamang, truck );
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0x64bb0f60, Offset: 0x277b
// Size: 0x119
function private function_db64258bc8fbeeaf( killcamorg, killcamang, truck )
{
    if ( !level.elite_ironclad.var_dc2d8c66e9fbafd7 )
    {
        return;
    }
    
    spawndata = { #angles:killcamang, #targetname:"veh_sat_mini_sentry", #vehicletype:"veh_mini_sentry_sat_wz", #origin:killcamorg, #modelname:"tag_turret" };
    faildata = spawnstruct();
    killcament = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    killcament hide( 1 );
    killcament.angles = killcamang;
    
    if ( !isdefined( level.elite_ironclad.killcaments ) )
    {
        level.elite_ironclad.killcaments = [];
    }
    
    level.elite_ironclad.killcaments[ level.elite_ironclad.killcaments.size ] = killcament;
    killcament linkto( truck );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x7f73e803, Offset: 0x289c
// Size: 0x425
function private function_39d4eed12332f770( player )
{
    truck = level.elite_ironclad.truck;
    assert( isdefined( truck ), "<dev string:x3f3>" );
    sabotage_interaction = self;
    
    if ( !isdefined( self.activity_instance.var_5bfc66666c61d99f ) )
    {
        self.activity_instance.var_5bfc66666c61d99f = [];
    }
    
    self.activity_instance.var_5bfc66666c61d99f[ self.activity_instance.var_5bfc66666c61d99f.size ] = player.team;
    
    if ( !isdefined( self.activity_instance.analytics.sabotage_players ) )
    {
        self.activity_instance.analytics.sabotage_players = [];
    }
    
    self.activity_instance.analytics.sabotage_players[ self.activity_instance.analytics.sabotage_players.size ] = player getplayerunoid();
    tag_angle_offset = sabotage_interaction.tag_angle_offset ?? ( 0, 0, 0 );
    var_6723ba7fdd3a97b0 = sabotage_interaction.var_6723ba7fdd3a97b0 ?? ( 0, 0, 0 );
    bomb_direction = vectornormalize( var_6723ba7fdd3a97b0 );
    bomb_origin = truck gettagorigin( sabotage_interaction.tag_linked ) + bomb_direction * 4;
    bomb_tag_offset = bomb_direction * 4;
    var_9117aa4392fbbe95 = tag_angle_offset + ( 0, 90, 0 );
    bomb = spawn( "script_model", bomb_origin );
    bomb setmodel( "offhand_wm_c4_br_safe" );
    bomb.angles = truck.angles + var_9117aa4392fbbe95;
    bomb linkto( truck, sabotage_interaction.tag_linked, bomb_tag_offset, var_9117aa4392fbbe95 );
    
    if ( !isdefined( level.elite_ironclad.sabotage_bombs ) )
    {
        level.elite_ironclad.sabotage_bombs = [];
    }
    
    level.elite_ironclad.sabotage_bombs[ level.elite_ironclad.sabotage_bombs.size ] = bomb;
    splash_name = self.activity_instance function_4679864001e48dbf();
    
    if ( splash_name )
    {
        hud_util::showsplashtoteam( self.activity_instance.team, splash_name, undefined, player, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    level.elite_ironclad.sabotage_interacts = arrayremove( level.elite_ironclad.sabotage_interacts, self );
    remove_interacts( [ self ] );
    
    if ( !level.elite_ironclad.sabotage_interacts || level.elite_ironclad.sabotage_interacts.size == 0 )
    {
        level.elite_ironclad.sabotage_interacts = undefined;
        self.activity_instance function_a854cc6f5d5224d1();
        self.activity_instance.savior_player_id = player getentitynumber();
        remove_interacts( level.elite_ironclad.smoke_interacts );
        level.elite_ironclad.smoke_interacts = undefined;
        self.activity_instance function_9c82804953b9326f( player );
        playfxontag( utility::getfx( "vfx_cq_scud_launcher_fail" ), level.elite_ironclad.truck, "tag_sabotage01_vfx" );
        playfxontag( utility::getfx( "vfx_cq_scud_launcher_fail" ), level.elite_ironclad.truck, "tag_sabotage02_vfx" );
        
        if ( self.activity_instance.analytics )
        {
            self.activity_instance.analytics.ended_reason = "sabotage";
        }
    }
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x155e987c, Offset: 0x2cc9
// Size: 0x55
function private function_4679864001e48dbf()
{
    var_5174ac76a44dc2ab = self.var_332f929de1894b2b.var_1031868a166f4d60;
    
    if ( !var_5174ac76a44dc2ab )
    {
        return;
    }
    
    planted_bomb_count = level.elite_ironclad.sabotage_bombs.size ?? 0;
    return var_5174ac76a44dc2ab + "_" + planted_bomb_count;
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xa188e629, Offset: 0x2d27
// Size: 0x3d7
function private function_9c82804953b9326f( player )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    
    foreach ( bomb in level.elite_ironclad.sabotage_bombs )
    {
        bomb thread function_49682768a4469560( activity_instance );
    }
    
    while ( level.elite_ironclad.sabotage_bombs && level.elite_ironclad.sabotage_bombs.size > 0 )
    {
        waitframe();
    }
    
    if ( level.elite_ironclad.var_dc2d8c66e9fbafd7 && level.elite_ironclad.var_8986f2401df91150 && level.elite_ironclad.killcaments && level.elite_ironclad.killcaments.size > 0 )
    {
        killcament = function_179a95e96746de03();
        player.deathtime = gettime();
        level.elite_ironclad.truck.deathtime = gettime();
        final_killcam::recordfinalkillcam( 5, player, player, player getentitynumber(), player, killcament getentitynumber(), 0, 0, player getcurrentprimaryweapon(), 0, "MOD_EXPLOSIVE", 1 );
        setomnvar( "ui_br_elite_ironclad_destroy_cam", 1 );
    }
    else
    {
        setomnvar( "ui_br_elite_ironclad_destroy_cam", 0 );
    }
    
    level notify( #"truck_sabotaged" );
    
    if ( activity_instance.var_332f929de1894b2b.var_60aeb86cfc1ebd93 )
    {
        var_1f3bb3cf02895b4e = activity_instance.var_5bfc66666c61d99f;
        elite_ironclad_dialogs::function_86e69830b4062c31( { #team:var_1f3bb3cf02895b4e[ 0 ], #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_60aeb86cfc1ebd93, #scope:3 } );
        
        if ( var_1f3bb3cf02895b4e[ 0 ] != var_1f3bb3cf02895b4e[ 1 ] )
        {
            elite_ironclad_dialogs::function_86e69830b4062c31( { #team:var_1f3bb3cf02895b4e[ 1 ], #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_60aeb86cfc1ebd93, #scope:3 } );
        }
    }
    
    if ( activity_instance.var_332f929de1894b2b.var_59a56f208ee4daa5 )
    {
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_59a56f208ee4daa5, #scope:2 } );
    }
    
    client_id = activity_instance.savior_player_id;
    
    if ( activity_instance.var_332f929de1894b2b.var_9365f40ba5fb23e )
    {
        hud_util::showsplashtoteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_9365f40ba5fb23e, client_id, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    if ( activity_instance.var_332f929de1894b2b.var_993320debf4209b1 )
    {
        hud_util::showsplashtoallexceptteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_993320debf4209b1, client_id, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    level.elite_ironclad.truck elite_ironclad_truck::function_8c4af3992f36d9a4();
    level.elite_ironclad.truck vehicle_turnengineoff();
    wait getdvarfloat( @"hash_ac08a1af3a5a2de7", 2 );
    activity_instance_common::endactivity( activity_instance, 0 );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x9ad31a3a, Offset: 0x3106
// Size: 0xf4
function private function_49682768a4469560( activity_instance )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self setscriptablepartstate( "effects", "plant" );
    fuse_time = activity_instance.var_332f929de1894b2b.var_482e9b0841b4ead2 ?? 10000;
    thread bomb_sounds( fuse_time );
    wait fuse_time / 1000;
    self setscriptablepartstate( "effects", "explodeWall" );
    level.elite_ironclad.truck utility::playsoundontag( "evt_elite_ironclad_scud_explosion", "tag_sabotage01_vfx" );
    wait 0.2;
    level.elite_ironclad.var_8986f2401df91150 = self.origin;
    level.elite_ironclad.sabotage_bombs = arrayremove( level.elite_ironclad.sabotage_bombs, self );
    self delete();
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x6ba94722, Offset: 0x3202
// Size: 0x162
function private bomb_sounds( time_in_ms )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    bomb = self;
    
    if ( soundexists( "breach_c4_plant_05" ) )
    {
        bomb playsound( "breach_c4_plant_05" );
    }
    
    ticktime = 0.5;
    starttime = gettime();
    endtime = starttime + time_in_ms;
    now = starttime;
    
    while ( now < endtime )
    {
        now = gettime();
        var_f4f3f0356fef8102 = endtime - now;
        
        if ( var_f4f3f0356fef8102 <= 1000 && soundexists( "breach_warning_beep_05" ) )
        {
            bomb playsound( "breach_warning_beep_05" );
            ticktime = 0.05;
        }
        else if ( var_f4f3f0356fef8102 <= 2000 && soundexists( "breach_warning_beep_04" ) )
        {
            bomb playsound( "breach_warning_beep_04" );
            ticktime = 0.25;
        }
        else if ( var_f4f3f0356fef8102 <= 3000 && soundexists( "breach_warning_beep_03" ) )
        {
            bomb playsound( "breach_warning_beep_03" );
            ticktime = 0.5;
        }
        else if ( var_f4f3f0356fef8102 <= 4000 && soundexists( "breach_warning_beep_02" ) )
        {
            bomb playsound( "breach_warning_beep_02" );
        }
        else if ( soundexists( "breach_warning_beep_01" ) )
        {
            bomb playsound( "breach_warning_beep_01" );
        }
        
        wait ticktime;
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x2fa1f7d4, Offset: 0x336c
// Size: 0x16b
function private function_11da7715f213e225( var_c4c75c26c8d585ee )
{
    waypoints = [];
    
    if ( getdvarint( @"hash_139cba7ab3acacf5", 0 ) == 1 )
    {
        /#
            waypoints = function_d7e0979094ff2e8c();
        #/
    }
    else if ( level.elite_ironclad.var_53863d27d68e9a31 )
    {
        waypoints = elite_ironclad_truck::function_e081d140efbeb2b4( level.elite_ironclad.var_53863d27d68e9a31 );
    }
    else
    {
        waypoints = elite_ironclad_truck::function_4e3cabfb53aa6261( self.origin );
    }
    
    smoothness = 0.5;
    path_accuracy = 0.5;
    total_dist = 0;
    point_i = 1;
    
    while ( point_i < waypoints.size )
    {
        total_dist += distance( waypoints[ point_i - 1 ], waypoints[ point_i ] );
        point_i += 1;
    }
    
    times = [];
    point_i = 1;
    
    while ( point_i < waypoints.size )
    {
        times[ times.size ] = distance( waypoints[ point_i - 1 ], waypoints[ point_i ] ) / total_dist * var_c4c75c26c8d585ee;
        point_i += 1;
    }
    
    times[ times.size ] = level.framedurationseconds;
    tension = clamp( 1 - smoothness, 0.01, 1 );
    alpha = clamp( path_accuracy, 0, 1 );
    splineid = function_53253e8ea222ed60( waypoints, times, 0, tension, alpha, 0 );
    return splineid;
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x70bbfc41, Offset: 0x34e0
// Size: 0x1e1
function private calculate_speed_multiplier()
{
    activity_instance = self;
    
    if ( !isdefined( level.elite_ironclad.var_2b795fe07af24bc8 ) )
    {
        return 0;
    }
    
    /#
        if ( getdvarint( @"hash_438f0dd08b2bcfc3", 0 ) == 1 )
        {
            return 0;
        }
    #/
    
    var_5f7dafe5c5cf302 = getdvarfloat( @"hash_3c9f35ca8eca2ac2", 2 );
    var_de6d6205aa146911 = getdvarfloat( @"hash_a573aa65bfc1242b", 1 );
    allowcontest = getdvarint( @"hash_d00f3c7508ffb21", 1 );
    var_a6ba9993fcf11798 = level.elite_ironclad.var_2b795fe07af24bc8.size;
    var_5cbd6270fffb41fe = level.elite_ironclad.var_8e5a1f1880e15da2.size;
    
    if ( level.elite_ironclad.var_9a8c3a80c80ddf18 === 1 )
    {
        var_5cbd6270fffb41fe += 1;
    }
    
    if ( allowcontest && var_5cbd6270fffb41fe > 0 )
    {
        return 0;
    }
    
    if ( var_a6ba9993fcf11798 == 0 && var_de6d6205aa146911 > 0 )
    {
        return var_de6d6205aa146911;
    }
    
    if ( var_a6ba9993fcf11798 == 0 )
    {
        return 0;
    }
    
    if ( var_a6ba9993fcf11798 >= 1 && var_5f7dafe5c5cf302 > 0 )
    {
        return var_5f7dafe5c5cf302;
    }
    
    if ( var_a6ba9993fcf11798 == 1 )
    {
        return activity_instance.var_332f929de1894b2b.var_e2d93827ae5af8b8.oneplayer;
    }
    
    if ( var_a6ba9993fcf11798 == 2 )
    {
        return activity_instance.var_332f929de1894b2b.var_e2d93827ae5af8b8.twoplayers;
    }
    
    if ( var_a6ba9993fcf11798 == 3 )
    {
        return activity_instance.var_332f929de1894b2b.var_e2d93827ae5af8b8.threeplayers;
    }
    
    if ( var_a6ba9993fcf11798 >= 4 )
    {
        return activity_instance.var_332f929de1894b2b.var_e2d93827ae5af8b8.fourplayers;
    }
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0xf550b03c, Offset: 0x36c9
// Size: 0x187
function private function_6d71824eb19a4abc( spline_id, var_c4c75c26c8d585ee, sample_interval )
{
    waypoints = [];
    current_time = 0;
    
    while ( current_time <= var_c4c75c26c8d585ee )
    {
        waypoint = { #time:current_time, #angles:function_7062a9ae37ef4c8b( spline_id, current_time ), #origin:function_2bf2352736fc6ac8( spline_id, current_time ) };
        
        if ( waypoints.size > 0 )
        {
            waypoint.accumulated_distance = distance( waypoint.origin, waypoints[ waypoints.size - 1 ].origin ) + waypoints[ waypoints.size - 1 ].accumulated_distance;
        }
        else
        {
            waypoint.accumulated_distance = 0;
        }
        
        waypoints[ waypoints.size ] = waypoint;
        current_time += sample_interval;
    }
    
    if ( waypoints.size == 0 || waypoints[ waypoints.size - 1 ].time < var_c4c75c26c8d585ee )
    {
        final_waypoint = { #time:var_c4c75c26c8d585ee, #angles:function_7062a9ae37ef4c8b( spline_id, var_c4c75c26c8d585ee ), #origin:function_2bf2352736fc6ac8( spline_id, var_c4c75c26c8d585ee ) };
        final_waypoint.accumulated_distance = distance( final_waypoint.origin, waypoints[ waypoints.size - 1 ].origin ) + ( waypoints.size > 0 ? waypoints[ waypoints.size - 1 ].accumulated_distance : 0 );
        waypoints[ waypoints.size ] = final_waypoint;
    }
    
    return waypoints;
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0xb0aaea6c, Offset: 0x3859
// Size: 0x56
function private function_bf38edb021b9559e( waypoints, var_c4c75c26c8d585ee )
{
    if ( waypoints.size < 2 || var_c4c75c26c8d585ee <= 0 )
    {
        return 0;
    }
    
    total_distance = waypoints[ waypoints.size - 1 ].accumulated_distance;
    var_f75dc213ffcc88d9 = total_distance / var_c4c75c26c8d585ee;
    return var_f75dc213ffcc88d9;
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0xe4aaf41, Offset: 0x38b8
// Size: 0x1ea
function private function_a9da58370629565b( truck, var_c4c75c26c8d585ee, spline_id )
{
    activity_instance = self;
    
    /#
        if ( getdvarint( @"hash_4ed3d12b9974d7a0", 0 ) == 1 )
        {
            activity_instance childthread utility::function_9f777c9a7fffb9fc( spline_id, var_c4c75c26c8d585ee, "<dev string:x42c>" );
        }
    #/
    
    var_4734771fdb4ddd0 = 10;
    waypoints = function_6d71824eb19a4abc( spline_id, var_c4c75c26c8d585ee, var_4734771fdb4ddd0 );
    
    if ( waypoints.size == 0 )
    {
        activity_instance notify( #"hash_3a67688599d723ea" );
        return;
    }
    
    var_665da0eb80fef582 = function_bf38edb021b9559e( waypoints, var_c4c75c26c8d585ee );
    var_665da0eb80fef582 = max( var_665da0eb80fef582, getdvarfloat( @"hash_accd33200ebdc3f6", 44 ) );
    total_distance = waypoints[ waypoints.size - 1 ].accumulated_distance;
    truck vehicle_turnengineon();
    truck vehicle_paths::function_53e592e2d38c05ca( 1, 0, 1, 0, 50, getdvarfloat( @"hash_f808d8eaf94350ab", 0.5 ), getdvarfloat( @"hash_9a14d46b38f94480", 52.8 ), 1, getdvarfloat( @"hash_5213a21386020fb0", 1 ), getdvarfloat( @"hash_fd0f7c9ee48f6c90", 1 ) );
    truck.escort_last_node = 0;
    truck.escort_current_node = 1;
    truck function_eb88c4e66edbc855( "p2p", "goalPoint", waypoints[ 1 ].origin );
    truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
    truck function_eb88c4e66edbc855( "p2p", "pause", 1 );
    activity_instance childthread function_9d9a9e374921d898( truck, waypoints );
    activity_instance childthread function_c9bb06b452b66f77( truck, var_665da0eb80fef582, waypoints, total_distance );
    activity_instance waittill( #"hash_866d31ec6d55f303" );
    truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
    truck removecomponent( "p2p" );
    activity_instance notify( #"hash_3a67688599d723ea" );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0xb61e9803, Offset: 0x3aaa
// Size: 0xd3
function private function_9d9a9e374921d898( truck, waypoints )
{
    activity_instance = self;
    activity_instance endon( #"hash_866d31ec6d55f303" );
    
    while ( truck.escort_current_node < waypoints.size - 1 )
    {
        truck thread function_8efbb1965b3d271c( waypoints );
        truck waittill( #"near_goal" );
        truck.escort_last_node = truck.escort_current_node;
        truck.escort_current_node += 1;
        truck function_eb88c4e66edbc855( "p2p", "goalPoint", waypoints[ truck.escort_current_node ].origin );
    }
    
    truck waittill( #"near_goal" );
    activity_instance notify( #"hash_866d31ec6d55f303" );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x9d1866c0, Offset: 0x3b85
// Size: 0x237
function private function_8efbb1965b3d271c( waypoints )
{
    self endon( #"near_goal" );
    
    if ( getdvarint( @"hash_a5f07fcd19e4b243", 1 ) == 0 )
    {
        return;
    }
    
    current_node = waypoints[ self.escort_current_node ].origin;
    last_node = waypoints[ self.escort_last_node ].origin;
    target_dir = vectornormalize2( current_node - last_node );
    
    while ( true )
    {
        too_far_cos = cos( getdvarfloat( @"hash_f762273140d2cf0e", 80 ) );
        var_f37181a0b7197bb = cos( getdvarfloat( @"hash_ca39a696e79048f3", 80 ) );
        dir = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
        to_node = vectornormalize2( current_node - self.origin );
        dot = vectordot( dir, target_dir );
        dot_to_node = vectordot( to_node, target_dir );
        
        /#
            color = ( 0, 1, 0 );
        #/
        
        if ( dot < too_far_cos )
        {
            if ( getdvarint( @"hash_762dcb3b2b1af4d9", 0 ) )
            {
                self vehicle_teleport( last_node, vectortoangles( target_dir ) );
            }
            
            /#
                color = ( 1, 0, 0 );
            #/
        }
        
        if ( dot_to_node < var_f37181a0b7197bb )
        {
            if ( getdvarint( @"hash_7d411328bef47b30", 1 ) )
            {
                self vehicle_teleport( last_node, vectortoangles( target_dir ) );
            }
            
            /#
                color = ( 1, 0, 0 );
            #/
        }
        
        if ( !function_8d2b54e3df5e24e( self.origin, self.angles[ 1 ], current_node ) )
        {
            if ( getdvarint( @"hash_6c0106b5feadfb3c", 1 ) )
            {
                self vehicle_teleport( last_node, vectortoangles( target_dir ) );
            }
            
            /#
                color = ( 1, 0, 0 );
            #/
        }
        
        /#
            circle( current_node, 50, ( 0, 0, 1 ), color );
            circle( last_node, 50, ( 0, 0, 1 ), ( 1, 1, 0 ) );
        #/
        
        waitframe();
    }
}

// Namespace namespace_66d2304510c46347
// Params 3
// Checksum 0x24c26fda, Offset: 0x3dc4
// Size: 0x16c, Type: bool
function function_8d2b54e3df5e24e( startpoint, startangle, destinationpoint )
{
    goal_radius = 50;
    minradius = getdvarint( @"hash_a1ba67cb792698a1", 550 );
    xa = startpoint[ 0 ];
    ya = startpoint[ 1 ];
    xb = destinationpoint[ 0 ];
    yb = destinationpoint[ 1 ];
    
    /#
        circle( destinationpoint, minradius - goal_radius );
    #/
    
    xcl = xa - minradius * sin( startangle );
    ycl = ya + minradius * cos( startangle );
    xcr = xa + minradius * sin( startangle );
    ycr = ya - minradius * cos( startangle );
    
    /#
        line( destinationpoint, ( xcl, ycl, startpoint[ 2 ] ), ( 1, 1, 0 ) );
        line( destinationpoint, ( xcr, ycr, startpoint[ 2 ] ), ( 0, 1, 1 ) );
    #/
    
    var_dd016ba15f2aed00 = function_c4d1fb3e0ccd2ef0( xb - xcl, yb - ycl );
    var_dd0189a15f2b2efa = function_c4d1fb3e0ccd2ef0( xb - xcr, yb - ycr );
    
    if ( var_dd016ba15f2aed00 < minradius - goal_radius - 0.1 || var_dd0189a15f2b2efa < minradius - goal_radius - 0.1 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0xe7966da3, Offset: 0x3f39
// Size: 0x22
function private function_c4d1fb3e0ccd2ef0( a, b )
{
    return sqrt( a * a + b * b );
}

// Namespace namespace_66d2304510c46347
// Params 4, eflags: 0x4
// Checksum 0x4400c314, Offset: 0x3f64
// Size: 0x319
function private function_c9bb06b452b66f77( truck, var_665da0eb80fef582, waypoints, total_distance )
{
    activity_instance = self;
    activity_instance endon( #"hash_866d31ec6d55f303" );
    last_progress_percent = 0;
    var_2946fe88a25581f5 = gettime();
    last_distance = 0;
    
    while ( true )
    {
        if ( getdvarint( @"hash_a12fb79fbe2fe79e", 0 ) == 1 )
        {
            activity_instance notify( #"hash_866d31ec6d55f303" );
            return;
        }
        
        var_3c6e807ed3e7d6cd = activity_instance calculate_speed_multiplier();
        
        if ( var_3c6e807ed3e7d6cd > 0 )
        {
            truck function_eb88c4e66edbc855( "p2p", "resume", 1 );
            truck function_eb88c4e66edbc855( "p2p", "manualSpeed", var_665da0eb80fef582 * var_3c6e807ed3e7d6cd );
        }
        else
        {
            truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
            truck function_eb88c4e66edbc855( "p2p", "pause", 1 );
        }
        
        last_node = truck.escort_last_node;
        current_node = truck.escort_current_node;
        current_distance = waypoints[ last_node ].accumulated_distance;
        
        if ( current_node < waypoints.size )
        {
            segment_start = waypoints[ last_node ].origin;
            segment_end = waypoints[ current_node ].origin;
            segment_vector = segment_end - segment_start;
            segment_length = length( segment_vector );
            
            if ( segment_length > 0 )
            {
                truck_vector = truck.origin - segment_start;
                segment_direction = vectornormalize( segment_vector );
                projection_length = vectordot( truck_vector, segment_direction );
                segment_progress = clamp( projection_length / segment_length, 0, 1 );
                segment_distance = waypoints[ current_node ].accumulated_distance - waypoints[ last_node ].accumulated_distance;
                current_distance += segment_progress * segment_distance;
            }
        }
        
        if ( var_3c6e807ed3e7d6cd > 0 )
        {
            if ( current_distance - last_distance > 1 )
            {
                var_2946fe88a25581f5 = gettime();
            }
            else if ( gettime() - var_2946fe88a25581f5 > getdvarfloat( @"hash_8eac7ec93b426499", 3 ) * 1000 )
            {
                truck function_eb88c4e66edbc855( "p2p", "resume", 1 );
                truck function_eb88c4e66edbc855( "p2p", "manualSpeed", var_665da0eb80fef582 * getdvarfloat( @"hash_50bac522400db7de", 2 ) );
                truck vehphys_force( ( getdvarfloat( @"hash_2722e50f29c0773d", 100000 ), 0, 0 ), ( 0, 0, 0 ) );
            }
        }
        else
        {
            var_2946fe88a25581f5 = gettime();
        }
        
        last_distance = current_distance;
        var_b7d53c6e2ec52c8b = int( clamp( current_distance / total_distance, 0, 1 ) * 100 );
        var_b7d53c6e2ec52c8b = max( var_b7d53c6e2ec52c8b, last_progress_percent );
        last_progress_percent = var_b7d53c6e2ec52c8b;
        activity_instance game_utility::questcircle_move( truck.origin );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_37ae6307d0ac97e3( 0, var_b7d53c6e2ec52c8b );
        waitframe();
    }
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x59bb9580, Offset: 0x4285
// Size: 0x136
function private function_69825929fb79b9b3()
{
    activity_instance = self;
    truck = level.elite_ironclad.truck;
    assert( isdefined( truck ), "<dev string:x43f>" );
    trigger_radius = activity_instance.var_332f929de1894b2b.var_5f66f066b115119f.radius ?? 500;
    trigger_height = activity_instance.var_332f929de1894b2b.var_5f66f066b115119f.height ?? 200;
    trigger = spawn( "trigger_radius", truck.origin, 0, trigger_radius, trigger_height );
    trigger enablelinkto();
    trigger linkto( truck );
    level.elite_ironclad.var_9fd296e7dea2ca74 = trigger;
    level.elite_ironclad.var_2b795fe07af24bc8 = [];
    level.elite_ironclad.var_8e5a1f1880e15da2 = [];
    
    /#
        if ( getdvarint( @"hash_f7a88888a56abf5f", 0 ) == 1 )
        {
            trigger childthread function_6efd8c9e87815593( trigger_radius, trigger_height );
        }
    #/
    
    activity_instance childthread function_32c858505f23f43c( trigger );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x7b2eb041, Offset: 0x43c3
// Size: 0x130
function private function_7892c5f3a9bac7ad()
{
    activity_instance = self;
    truck = level.elite_ironclad.truck;
    assert( isdefined( truck ), "<dev string:x480>" );
    activity_instance function_bde762c03af9a959();
    marker = activity_instance.var_332f929de1894b2b.var_89c07aa6989a3bb0 ?? activity_instance.var_332f929de1894b2b.var_e8410aa41dbd4781.interactionobjectivemarker;
    var_3eb895bbf3efb660 = activity_instance.var_332f929de1894b2b.var_c1a4aadaa6b3b8a6 ?? 150;
    objective = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_add_objective( objective, "current", truck.origin, marker, "icon_large" );
    objidpoolmanager::update_objective_setzoffset( objective, var_3eb895bbf3efb660 );
    objidpoolmanager::update_objective_onentity( objective, truck );
    function_3c746b7761c313f6( objective );
    
    if ( !level.elite_ironclad.var_1ac9081036be7ca4 )
    {
        function_edb089d68b6da18f( objective, activity_instance.team );
    }
    
    activity_instance.var_606cf710727bbc6e = objective;
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x74ecb40c, Offset: 0x44fb
// Size: 0x135
function private function_77b0f57e589bb2c0()
{
    activity_instance = self;
    truck = level.elite_ironclad.truck;
    assert( isdefined( truck ), "<dev string:x4c9>" );
    
    if ( isdefined( activity_instance.var_ee6c25c868205305 ) )
    {
        activity_instance.var_ee6c25c868205305 delete();
    }
    
    trigger_settings = activity_instance.var_332f929de1894b2b.var_12cc6bee5ee2be5b ?? activity_instance.var_332f929de1894b2b.var_5f66f066b115119f;
    trigger_radius = trigger_settings.radius ?? 500;
    trigger_height = trigger_settings.height ?? 200;
    trigger = spawn( "trigger_radius", truck.origin, 0, trigger_radius, trigger_height );
    trigger enablelinkto();
    trigger linkto( truck );
    activity_instance.var_ee6c25c868205305 = trigger;
    activity_instance.var_53d2b57332231baa = [];
    activity_instance function_f0d0b5cbe3d523a8( trigger );
    trigger::makeenterexittrigger( trigger, &function_ae10974390bf7f52, &function_ea830db70bc03bc4, undefined, undefined, undefined, activity_instance );
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0x871e6e49, Offset: 0x4638
// Size: 0x98
function private function_ae10974390bf7f52( player, trigger, activity_instance )
{
    if ( !isplayer( player ) || player.team == activity_instance.team && !level.elite_ironclad.var_1ac9081036be7ca4 )
    {
        return;
    }
    
    if ( !arraycontains( activity_instance.var_53d2b57332231baa, player ) )
    {
        activity_instance.var_53d2b57332231baa[ activity_instance.var_53d2b57332231baa.size ] = player;
    }
    
    activity_instance function_126d54f994956f36( player, 1 );
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0x5a69d4da, Offset: 0x46d8
// Size: 0x98
function private function_ea830db70bc03bc4( player, trigger, activity_instance )
{
    if ( !isplayer( player ) || player.team == activity_instance.team && !level.elite_ironclad.var_1ac9081036be7ca4 )
    {
        return;
    }
    
    if ( arraycontains( activity_instance.var_53d2b57332231baa, player ) )
    {
        activity_instance.var_53d2b57332231baa = arrayremove( activity_instance.var_53d2b57332231baa, player );
    }
    
    activity_instance function_126d54f994956f36( player, 0 );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x1c67c6aa, Offset: 0x4778
// Size: 0x14c
function private function_f0d0b5cbe3d523a8( trigger )
{
    activity_instance = self;
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || player.team == activity_instance.team && !level.elite_ironclad.var_1ac9081036be7ca4 )
        {
            continue;
        }
        
        is_inside_trigger = player istouching( trigger );
        
        if ( is_inside_trigger )
        {
            if ( !arraycontains( activity_instance.var_53d2b57332231baa, player ) )
            {
                activity_instance.var_53d2b57332231baa[ activity_instance.var_53d2b57332231baa.size ] = player;
            }
        }
        else if ( arraycontains( activity_instance.var_53d2b57332231baa, player ) )
        {
            activity_instance.var_53d2b57332231baa = arrayremove( activity_instance.var_53d2b57332231baa, player );
        }
        
        activity_instance function_126d54f994956f36( player, is_inside_trigger );
    }
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x3bb66fce, Offset: 0x48cc
// Size: 0x13f
function private function_126d54f994956f36( player, var_992bb5df0e166d0c )
{
    activity_instance = self;
    
    if ( !isplayer( player ) || player.team == activity_instance.team && !level.elite_ironclad.var_1ac9081036be7ca4 )
    {
        return;
    }
    
    center_objective = activity_instance.var_606cf710727bbc6e;
    
    if ( isdefined( center_objective ) )
    {
        if ( var_992bb5df0e166d0c )
        {
            function_8fc5b69f2286a194( center_objective, player );
        }
        else
        {
            objective_add_client( center_objective, player );
        }
    }
    
    foreach ( interact in level.elite_ironclad.sabotage_interacts )
    {
        if ( var_992bb5df0e166d0c )
        {
            objective_add_client( interact.objective, player );
            continue;
        }
        
        function_8fc5b69f2286a194( interact.objective, player );
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xf407b62d, Offset: 0x4a13
// Size: 0x1a
function private function_3c746b7761c313f6( objective )
{
    function_fd9ed552c76d6299( objective );
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x69c5daa0, Offset: 0x4a35
// Size: 0x1a
function private function_61e2e973fa3ed054( objective )
{
    function_38b84cb3d4357dd7( objective );
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0xff8e3e6c, Offset: 0x4a57
// Size: 0x24
function private objective_add_client( objective, player )
{
    objective_addclienttomask( objective, player );
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x7bde2ab4, Offset: 0x4a83
// Size: 0x24
function private function_8fc5b69f2286a194( objective, player )
{
    objective_removeclientfrommask( objective, player );
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x911026f2, Offset: 0x4aaf
// Size: 0xa6
function private function_6a001f103fc1d5c6( objective, team )
{
    function_38b84cb3d4357dd7( objective );
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_addclienttomask( objective, player );
    }
    
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x9eb220d8, Offset: 0x4b5d
// Size: 0xa6
function private function_edb089d68b6da18f( objective, team )
{
    function_fd9ed552c76d6299( objective );
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_removeclientfrommask( objective, player );
    }
    
    objective_showtoplayersinmask( objective );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x3bf1dc22, Offset: 0x4c0b
// Size: 0xb2
function private function_32c858505f23f43c( trigger )
{
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", var_1ac125f24db12fc8 );
        ent_list = get_enter_players( var_1ac125f24db12fc8 );
        
        foreach ( ent in ent_list )
        {
            function_9bcde0e06fd9894e( trigger, ent );
        }
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x6ebc24ea, Offset: 0x4cc5
// Size: 0x43
function private get_enter_players( var_1ac125f24db12fc8 )
{
    var_5f07592ed8683f1f = [];
    
    if ( isplayer( var_1ac125f24db12fc8 ) )
    {
        var_5f07592ed8683f1f[ var_5f07592ed8683f1f.size ] = var_1ac125f24db12fc8;
    }
    else if ( var_1ac125f24db12fc8 vehicle::is_vehicle() )
    {
        var_5f07592ed8683f1f = vehicle_occupancy::function_8ed9bcd8e9ea74f5( var_1ac125f24db12fc8 );
    }
    
    return var_5f07592ed8683f1f;
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0xdf2e2975, Offset: 0x4d11
// Size: 0x12a
function private function_9bcde0e06fd9894e( trigger, ent )
{
    activity_instance = self;
    
    if ( ent.team != activity_instance.team )
    {
        if ( !arraycontains( level.elite_ironclad.var_8e5a1f1880e15da2, ent ) )
        {
            if ( level.elite_ironclad.var_8e5a1f1880e15da2.size == 0 )
            {
                setomnvar( "ui_br_elite_contract_payload_contested", 1 );
            }
            
            level.elite_ironclad.var_8e5a1f1880e15da2[ level.elite_ironclad.var_8e5a1f1880e15da2.size ] = ent;
            activity_instance childthread function_bcfad2cdd73e8a0a( ent, trigger );
        }
        
        return;
    }
    
    if ( !arraycontains( level.elite_ironclad.var_2b795fe07af24bc8, ent ) )
    {
        level.elite_ironclad.var_2b795fe07af24bc8[ level.elite_ironclad.var_2b795fe07af24bc8.size ] = ent;
        activity_instance childthread function_d952965b3f89e463( ent, trigger );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( ent, 1, 1 );
    }
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x1271a413, Offset: 0x4e43
// Size: 0xd2
function private function_bcfad2cdd73e8a0a( player, trigger )
{
    self endon( #"hash_3a67688599d723ea" );
    
    while ( isdefined( trigger ) && isdefined( player ) && player player::isreallyalive() && player istouching( trigger ) )
    {
        wait 0.1;
    }
    
    if ( isdefined( player ) )
    {
        level.elite_ironclad.var_8e5a1f1880e15da2 = arrayremove( level.elite_ironclad.var_8e5a1f1880e15da2, player );
    }
    else
    {
        level.elite_ironclad.var_8e5a1f1880e15da2 = function_5713d46873b29625( level.elite_ironclad.var_8e5a1f1880e15da2 );
    }
    
    if ( level.elite_ironclad.var_8e5a1f1880e15da2.size == 0 )
    {
        setomnvar( "ui_br_elite_contract_payload_contested", 0 );
    }
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x86159cda, Offset: 0x4f1d
// Size: 0xcd
function private function_d952965b3f89e463( player, trigger )
{
    self endon( #"hash_3a67688599d723ea" );
    
    while ( isdefined( trigger ) && isdefined( player ) && player player::isreallyalive() && player istouching( trigger ) )
    {
        wait 0.1;
    }
    
    if ( isdefined( player ) )
    {
        level.elite_ironclad.var_2b795fe07af24bc8 = arrayremove( level.elite_ironclad.var_2b795fe07af24bc8, player );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( player, 1, 0 );
        return;
    }
    
    level.elite_ironclad.var_2b795fe07af24bc8 = function_5713d46873b29625( level.elite_ironclad.var_2b795fe07af24bc8 );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xea64b443, Offset: 0x4ff2
// Size: 0x12f
function private function_5aaf56208ce5bdce( params )
{
    if ( params.player && arraycontains( level.elite_ironclad.var_2b795fe07af24bc8, params.player ) )
    {
        level.elite_ironclad.var_2b795fe07af24bc8 = arrayremove( level.elite_ironclad.var_2b795fe07af24bc8, params.player );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_282f2cca3997a1f2( params.player, 1, 0 );
        return;
    }
    
    if ( params.player && arraycontains( level.elite_ironclad.var_8e5a1f1880e15da2, params.player ) )
    {
        level.elite_ironclad.var_8e5a1f1880e15da2 = arrayremove( level.elite_ironclad.var_8e5a1f1880e15da2, params.player );
        
        if ( level.elite_ironclad.var_8e5a1f1880e15da2.size == 0 )
        {
            setomnvar( "ui_br_elite_contract_payload_contested", 0 );
        }
    }
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x8e842930, Offset: 0x5129
// Size: 0x77
function private function_a854cc6f5d5224d1()
{
    activity_instance = self;
    
    if ( isdefined( activity_instance.var_ee6c25c868205305 ) )
    {
        activity_instance.var_ee6c25c868205305 delete();
        activity_instance.var_ee6c25c868205305 = undefined;
    }
    
    activity_instance function_bde762c03af9a959();
    activity_instance.var_53d2b57332231baa = undefined;
    level.elite_ironclad.truck setscriptablepartstate( #"hash_b81dff843532a6b8", #"hide" );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xcaf526f9, Offset: 0x51a8
// Size: 0x40
function private function_bde762c03af9a959()
{
    activity_instance = self;
    center_objective = activity_instance.var_606cf710727bbc6e;
    
    if ( !isdefined( center_objective ) )
    {
        return;
    }
    
    objidpoolmanager::returnobjectiveid( center_objective );
    activity_instance.var_606cf710727bbc6e = undefined;
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x904886c3, Offset: 0x51f0
// Size: 0x115
function private function_2b9f33e409b5720b()
{
    remove_interacts( level.elite_ironclad.smoke_interacts );
    level.elite_ironclad.smoke_interacts = undefined;
    function_a854cc6f5d5224d1();
    
    if ( isdefined( level.elite_ironclad.var_9fd296e7dea2ca74 ) )
    {
        level.elite_ironclad.var_9fd296e7dea2ca74 delete();
        level.elite_ironclad.var_9fd296e7dea2ca74 = undefined;
    }
    
    level.elite_ironclad.truck setscriptablepartstate( #"hash_b81dff843532a6b8", #"hide" );
    level.elite_ironclad.var_2b795fe07af24bc8 = undefined;
    level.elite_ironclad.var_8e5a1f1880e15da2 = undefined;
    
    if ( isdefined( level.elite_ironclad.var_1be81e6961128189 ) )
    {
        spline_destroy( level.elite_ironclad.var_1be81e6961128189 );
    }
    
    level.elite_ironclad.var_1be81e6961128189 = undefined;
    setomnvar( "ui_br_elite_contract_payload_contested", 0 );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x1b927369, Offset: 0x530d
// Size: 0x145
function private function_3c081279290c0482( var_7ee37f0b606f2544 )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    truck = level.elite_ironclad.truck;
    level.elite_ironclad.var_1be81e6961128189 = truck function_11da7715f213e225( var_7ee37f0b606f2544 );
    
    if ( !level callback::exists( #"player_disconnect", &function_5aaf56208ce5bdce ) )
    {
        level callback::add( #"player_disconnect", &function_5aaf56208ce5bdce );
    }
    
    activity_instance function_69825929fb79b9b3();
    
    if ( getdvarint( @"hash_67b1eaa3247d660d", 1 ) == 1 )
    {
        activity_instance function_a9da58370629565b( truck, var_7ee37f0b606f2544, level.elite_ironclad.var_1be81e6961128189 );
    }
    else
    {
        activity_instance function_7fbf90f1a1fa6b84( truck, var_7ee37f0b606f2544, level.elite_ironclad.var_1be81e6961128189 );
    }
    
    level callback::remove( #"player_disconnect", &function_5aaf56208ce5bdce );
    function_2b9f33e409b5720b();
    activity_instance.analytics.escort_finished_time = gettime();
    activity_instance function_716610140eac0bfa();
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x6c6b8d80, Offset: 0x545a
// Size: 0x105
function private function_716610140eac0bfa()
{
    activity_instance = self;
    var_c8cc79af333256d7 = activity_instance.var_332f929de1894b2b.var_eb0ff52e315a914.interactiontime;
    
    if ( var_c8cc79af333256d7 > 0 )
    {
        activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_scud_launch" );
        level.elite_ironclad.team_info.state = 12;
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016( 0, 100 );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_37ae6307d0ac97e3( 0, 100 );
        
        if ( activity_instance.var_332f929de1894b2b.var_8a8b1c9a6ef08ccb )
        {
            hud_util::showsplashtoteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_8a8b1c9a6ef08ccb, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
        }
        
        activity_instance function_a97fa7207e1f197e();
        return;
    }
    
    activity_instance on_keypad_used( undefined );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x99256adf, Offset: 0x5567
// Size: 0x1ed
function private function_a97fa7207e1f197e()
{
    truck = level.elite_ironclad.truck;
    activity_instance = self;
    var_343254140fe8c7a3 = activity_instance.var_332f929de1894b2b.var_eb0ff52e315a914;
    var_a89bc83f15301e7 = var_343254140fe8c7a3.var_134d66b48760a417 ?? "tag_isotope";
    remove_interacts( level.elite_ironclad.var_dc8ced33eea5b3f7 );
    level.elite_ironclad.var_dc8ced33eea5b3f7 = undefined;
    assert( isdefined( truck ), "<dev string:x513>" );
    assert( utility::hastag( truck.model, var_a89bc83f15301e7 ), "<dev string:x548>" + truck.model + "<dev string:xe2>" + var_a89bc83f15301e7 );
    interaction_data = { #hint_string_callback:&"hash_32a88abe247943f0", #activity_instance:activity_instance, #callback:&on_keypad_used, #tag_angle_offset:( 0, -90, 0 ), #var_a89bc83f15301e7:var_a89bc83f15301e7, #angles:truck.angles + ( 0, -90, 0 ), #origin:truck gettagorigin( var_a89bc83f15301e7 ) };
    var_ae818561664ab925 = create_interaction( interaction_data, var_343254140fe8c7a3, get_allowed_players( activity_instance.team, 0 ) );
    function_ff00cbf5d28eb319( var_ae818561664ab925, var_343254140fe8c7a3.interactionobjectivemarker, activity_instance.team, 0 );
    level.elite_ironclad.var_dc8ced33eea5b3f7 = [ var_ae818561664ab925 ];
    level.elite_ironclad.truck setscriptablepartstate( #"keypad_material", #"launch" );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xe19d17d0, Offset: 0x575c
// Size: 0xcf
function private on_keypad_used( player )
{
    if ( !isdefined( player ) || player::isinlaststand( player ) )
    {
        return;
    }
    
    interact = self;
    activity_instance = interact.activity_instance;
    remove_interacts( level.elite_ironclad.var_dc8ced33eea5b3f7 );
    level.elite_ironclad.var_dc8ced33eea5b3f7 = undefined;
    
    if ( activity_instance.var_332f929de1894b2b.var_4eb28fe92645d24a )
    {
        hud_util::showsplashtoall( activity_instance.var_332f929de1894b2b.var_4eb28fe92645d24a, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    activity_instance.analytics.missile_armed_time = gettime();
    activity_instance function_127c3402cb4c2cc5();
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0x63f5df24, Offset: 0x5833
// Size: 0x19c
function private function_127c3402cb4c2cc5()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_ended" );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_262729a77914fde7, #scope:1 } );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:activity_instance.var_332f929de1894b2b.var_398f25f5d76736e8, #scope:2 } );
    level.elite_ironclad.truck thread elite_ironclad_truck::function_4b7f47dea0a5b722();
    var_79b2386441ab64ae = int( ( activity_instance.var_332f929de1894b2b.var_b6fa84881ef5cd4 ?? 10000 ) / 1000 );
    level.elite_ironclad.team_info.state = 13;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016( var_79b2386441ab64ae );
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_37ae6307d0ac97e3( var_79b2386441ab64ae );
    wait var_79b2386441ab64ae;
    
    if ( activity_instance.var_332f929de1894b2b.var_f906ee8730a2960f )
    {
        hud_util::showsplashtoall( activity_instance.var_332f929de1894b2b.var_f906ee8730a2960f, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    activity_instance.analytics.ended_reason = "nuke_launched";
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0xa1e2d451, Offset: 0x59d7
// Size: 0x1fc
function private create_interaction( var_1ce878498c641855, interaction_settings, allowed_players )
{
    truck = level.elite_ironclad.truck;
    anchor = spawn( "script_origin", var_1ce878498c641855.origin );
    anchor.angles = var_1ce878498c641855.angles;
    var_6723ba7fdd3a97b0 = var_1ce878498c641855.var_6723ba7fdd3a97b0 ?? ( 0, 0, 0 );
    tag_angle_offset = var_1ce878498c641855.tag_angle_offset ?? ( 0, 0, 0 );
    anchor linkto( truck, var_1ce878498c641855.var_a89bc83f15301e7, var_6723ba7fdd3a97b0, tag_angle_offset );
    interact = interaction::register_interact( anchor, interaction_settings.interactionradius, var_1ce878498c641855.callback, var_1ce878498c641855.hint_string_callback, undefined, undefined, 1 );
    interact.angles = var_1ce878498c641855.angles;
    interact.tag_linked = var_1ce878498c641855.var_a89bc83f15301e7;
    interact.var_6723ba7fdd3a97b0 = var_6723ba7fdd3a97b0;
    interact.tag_angle_offset = tag_angle_offset;
    interact.objective_anchor = anchor;
    interact.activity_instance = var_1ce878498c641855.activity_instance;
    
    if ( !isdefined( level.elite_ironclad.all_interacts ) )
    {
        level.elite_ironclad.all_interacts = [];
    }
    
    level.elite_ironclad.all_interacts[ level.elite_ironclad.all_interacts.size ] = interact;
    
    /#
        if ( getdvarint( @"hash_bf2e7370689de6a1", 0 ) == 1 )
        {
            interact thread debug_draw_interact( interact );
        }
    #/
    
    interact configure_interaction( interaction_settings, allowed_players );
    return interact;
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x6d580122, Offset: 0x5bdc
// Size: 0xaa
function private configure_interaction( interaction_settings, allowed_players )
{
    self setcursorhint( "HINT_BUTTON" );
    
    if ( interaction_settings.interactiontime > 0 )
    {
        self setuseholdduration( interaction_settings.interactiontime );
    }
    
    self setuserange( interaction_settings.interactionradius );
    self setusefov( interaction_settings.interactionfov );
    self setusepriority( -2 );
    self sethintdisplayrange( interaction_settings.var_7a3ca8513c161ac4 );
    
    if ( interaction_settings.interactionicon )
    {
        self sethinticon( interaction_settings.interactionicon );
    }
    
    self disableplayeruseforallplayers();
    thread enable_interaction( allowed_players );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x3878355b, Offset: 0x5c8e
// Size: 0x7d
function private enable_interaction( allowed_players )
{
    foreach ( player in allowed_players )
    {
        self enableplayeruse( player );
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xa2b500da, Offset: 0x5d13
// Size: 0x10d
function private remove_interacts( interacts )
{
    if ( !isdefined( interacts ) )
    {
        return;
    }
    
    interacts_to_remove = arraycopy( interacts );
    
    foreach ( interact in interacts_to_remove )
    {
        remove_interact_objective( interact );
        level.elite_ironclad.all_interacts = arrayremove( level.elite_ironclad.all_interacts, interact );
        interact delete();
    }
    
    if ( level.elite_ironclad.all_interacts && level.elite_ironclad.all_interacts.size == 0 )
    {
        level.elite_ironclad.all_interacts = undefined;
    }
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xcd234311, Offset: 0x5e28
// Size: 0x7b
function private remove_all_interacts()
{
    remove_interacts( level.elite_ironclad.all_interacts );
    level.elite_ironclad.isotope_interacts = undefined;
    level.elite_ironclad.smoke_interacts = undefined;
    level.elite_ironclad.sabotage_interacts = undefined;
    level.elite_ironclad.var_dc8ced33eea5b3f7 = undefined;
    level.elite_ironclad.all_interacts = undefined;
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xb211362a, Offset: 0x5eab
// Size: 0xc3
function private function_7f926062a103a6c0()
{
    player = self;
    isotope_data = {};
    
    if ( player common_inventory::function_383caa18a4383073( 139837 ) )
    {
        isotope_data.var_c6c0aa445411f617 = 1;
        return isotope_data;
    }
    
    itemtype = common_item::function_9deb822f286163b1( 139837 );
    var_8fb8e1fb220cca48 = player common_item::function_c4c43ebb7aa636dc( itemtype, spawnstruct(), 0 );
    hasequipped = 0;
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && isdefined( var_8fb8e1fb220cca48.name ) )
    {
        currentlootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        hasequipped = currentlootid == 139837;
        
        if ( hasequipped )
        {
            isotope_data.itemtype = itemtype;
            return isotope_data;
        }
    }
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0x381caf4c, Offset: 0x5f77
// Size: 0x71
function private consume_isotope_core( isotope_data )
{
    player = self;
    
    if ( isotope_data.var_c6c0aa445411f617 )
    {
        player common_inventory::function_d1993196b2bcf62d( 139837, 1 );
        return;
    }
    
    assert( isotope_data.itemtype, "<dev string:x5af>" );
    player common_item::function_bbba261e6fdc7e52( isotope_data.itemtype, { #count:1 }, 0 );
}

// Namespace namespace_66d2304510c46347
// Params 2, eflags: 0x4
// Checksum 0x829d1e08, Offset: 0x5ff0
// Size: 0x90
function private get_allowed_players( team, exclude_team )
{
    if ( !isdefined( team ) )
    {
        return level.players;
    }
    
    /#
        if ( level.elite_ironclad.var_1ac9081036be7ca4 === 1 )
        {
            return level.players;
        }
    #/
    
    teammates = teams::getteamdata( team, "players" );
    allowed_players = teammates;
    
    if ( exclude_team )
    {
        allowed_players = arraycopy( level.players );
        allowed_players = arrayremove( allowed_players, teammates );
    }
    
    return allowed_players;
}

// Namespace namespace_66d2304510c46347
// Params 4, eflags: 0x4
// Checksum 0x34c7590d, Offset: 0x6089
// Size: 0xbb
function private function_ff00cbf5d28eb319( interact, marker, team, hidefromteam )
{
    if ( !interact.objective )
    {
        interact.objective = objidpoolmanager::requestobjectiveid();
        objidpoolmanager::objective_add_objective( interact.objective, "current", interact.origin, marker, "icon_large" );
        objidpoolmanager::function_373aaf492aabde6f( interact.objective, 246, 192, 72, 1 );
        objidpoolmanager::update_objective_onentity( interact.objective, interact.objective_anchor ?? interact );
    }
    
    interact function_3c3f6cea61874f43( 1, team, hidefromteam );
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0xc5963d17, Offset: 0x614c
// Size: 0xb7
function private function_3c3f6cea61874f43( is_visible, team, hidefromteam )
{
    interact = self;
    
    if ( !interact.objective )
    {
        return;
    }
    
    if ( !is_visible )
    {
        function_61e2e973fa3ed054( interact.objective );
        return;
    }
    
    show_to_all = level.elite_ironclad.var_1ac9081036be7ca4;
    
    if ( show_to_all )
    {
        function_3c746b7761c313f6( interact.objective );
        return;
    }
    
    if ( hidefromteam )
    {
        function_edb089d68b6da18f( interact.objective, team );
        return;
    }
    
    function_6a001f103fc1d5c6( interact.objective, team );
}

// Namespace namespace_66d2304510c46347
// Params 1, eflags: 0x4
// Checksum 0xcb8449bd, Offset: 0x620b
// Size: 0x37
function private remove_interact_objective( interact )
{
    if ( interact.objective )
    {
        objidpoolmanager::returnobjectiveid( interact.objective );
        interact.objective = undefined;
    }
}

// Namespace namespace_66d2304510c46347
// Params 3, eflags: 0x4
// Checksum 0xf0209565, Offset: 0x624a
// Size: 0x4a1
function private function_7fbf90f1a1fa6b84( truck, var_c4c75c26c8d585ee, spline_id )
{
    activity_instance = self;
    
    /#
        if ( getdvarint( @"hash_4ed3d12b9974d7a0", 0 ) == 1 )
        {
            activity_instance childthread utility::function_9f777c9a7fffb9fc( spline_id, var_c4c75c26c8d585ee, "<dev string:x42c>" );
        }
    #/
    
    var_4734771fdb4ddd0 = 10;
    waypoints = function_6d71824eb19a4abc( spline_id, var_c4c75c26c8d585ee, var_4734771fdb4ddd0 );
    
    if ( waypoints.size == 0 )
    {
        activity_instance notify( #"hash_3a67688599d723ea" );
        return;
    }
    
    var_665da0eb80fef582 = function_bf38edb021b9559e( waypoints, var_c4c75c26c8d585ee );
    var_665da0eb80fef582 = max( var_665da0eb80fef582, getdvarfloat( @"hash_accd33200ebdc3f6", 44 ) );
    total_distance = waypoints[ waypoints.size - 1 ].accumulated_distance;
    current_waypoint_index = 1;
    last_waypoint_index = 0;
    last_progress_percent = 0;
    truck vehicle_turnengineon();
    truck vehicle_paths::function_53e592e2d38c05ca( 1, 0, 1, 0, 50 );
    
    if ( waypoints.size > 1 )
    {
        truck function_eb88c4e66edbc855( "p2p", "goalPoint", waypoints[ current_waypoint_index ].origin );
    }
    
    truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
    truck function_eb88c4e66edbc855( "p2p", "pause", 1 );
    truck function_eb88c4e66edbc855( "p2p", "stuckTime", 5 );
    truck function_eb88c4e66edbc855( "p2p", "stuckSpeedThreshold", 0 );
    truck function_eb88c4e66edbc855( "p2p", "stuckDistanceThreshold", 0 );
    var_2946fe88a25581f5 = gettime();
    last_distance = 0;
    
    while ( last_waypoint_index < waypoints.size - 1 )
    {
        if ( getdvarint( @"hash_a12fb79fbe2fe79e", 0 ) == 1 )
        {
            last_waypoint_index = waypoints.size - 1;
            break;
        }
        
        var_3c6e807ed3e7d6cd = activity_instance calculate_speed_multiplier();
        
        if ( var_3c6e807ed3e7d6cd > 0 )
        {
            truck function_eb88c4e66edbc855( "p2p", "resume", 1 );
            truck function_eb88c4e66edbc855( "p2p", "manualSpeed", var_665da0eb80fef582 * var_3c6e807ed3e7d6cd );
        }
        else
        {
            truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
            truck function_eb88c4e66edbc855( "p2p", "pause", 1 );
        }
        
        current_distance = waypoints[ last_waypoint_index ].accumulated_distance;
        
        if ( current_waypoint_index < waypoints.size )
        {
            segment_start = waypoints[ last_waypoint_index ].origin;
            segment_end = waypoints[ current_waypoint_index ].origin;
            segment_vector = segment_end - segment_start;
            segment_length = length( segment_vector );
            
            if ( segment_length > 0 )
            {
                truck_vector = truck.origin - segment_start;
                segment_direction = vectornormalize( segment_vector );
                projection_length = vectordot( truck_vector, segment_direction );
                segment_progress = clamp( projection_length / segment_length, 0, 1 );
                segment_distance = waypoints[ current_waypoint_index ].accumulated_distance - waypoints[ last_waypoint_index ].accumulated_distance;
                current_distance += segment_progress * segment_distance;
                
                if ( projection_length > segment_length - 50 )
                {
                    last_waypoint_index = current_waypoint_index;
                    current_waypoint_index++;
                    
                    if ( current_waypoint_index < waypoints.size )
                    {
                        truck function_eb88c4e66edbc855( "p2p", "goalPoint", waypoints[ current_waypoint_index ].origin );
                    }
                }
            }
        }
        
        if ( var_3c6e807ed3e7d6cd > 0 )
        {
            if ( current_distance - last_distance > 1 )
            {
                var_2946fe88a25581f5 = gettime();
            }
            else if ( gettime() - var_2946fe88a25581f5 > getdvarfloat( @"hash_8eac7ec93b426499", 1 ) * 1000 )
            {
                truck function_eb88c4e66edbc855( "p2p", "resume", 1 );
                truck function_eb88c4e66edbc855( "p2p", "manualSpeed", var_665da0eb80fef582 * getdvarfloat( @"hash_50bac522400db7de", 3 ) );
                truck vehphys_force( ( getdvarfloat( @"hash_2722e50f29c0773d", 100000 ), 0, 0 ), ( 0, 0, 0 ) );
            }
        }
        else
        {
            var_2946fe88a25581f5 = gettime();
        }
        
        last_distance = current_distance;
        var_b7d53c6e2ec52c8b = int( clamp( current_distance / total_distance, 0, 1 ) * 100 );
        var_b7d53c6e2ec52c8b = max( var_b7d53c6e2ec52c8b, last_progress_percent );
        last_progress_percent = var_b7d53c6e2ec52c8b;
        activity_instance game_utility::questcircle_move( truck.origin );
        level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_37ae6307d0ac97e3( 0, var_b7d53c6e2ec52c8b );
        waitframe();
    }
    
    truck function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
    truck removecomponent( "p2p" );
    activity_instance notify( #"hash_3a67688599d723ea" );
}

// Namespace namespace_66d2304510c46347
// Params 0, eflags: 0x4
// Checksum 0xa3decd44, Offset: 0x66f3
// Size: 0x17d
function private init_dev_gui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x619>" );
        devgui::add_devgui_func( "<dev string:x662>", "<dev string:x67f>", &function_18aa432716c7d1b0, 0, 1 );
        devgui::add_devgui_func( "<dev string:x68b>", "<dev string:x6a5>", &function_9b3e71f56964da23, 0, 1 );
        devgui::add_devgui_func( "<dev string:x6bf>", "<dev string:x6d0>", &function_c504e8363240b41a, 0, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x6e1>" );
        devgui::add_devgui_func( "<dev string:x72f>", "<dev string:x757>", &function_c6f4c390cfd8ff2c, 0, 2 );
        devgui::add_devgui_func( "<dev string:x776>", "<dev string:x793>", &function_1869776f10a94802, 0, 4 );
        devgui::add_devgui_func( "<dev string:x7b0>", "<dev string:x7d0>", &function_e08c281f6aa4c565, 0, 5 );
        devgui::add_devgui_func( "<dev string:x7f0>", "<dev string:x805>", &function_598afbb7a4fd762a, 0, 6 );
        devgui::add_devgui_func( "<dev string:x81a>", "<dev string:x82e>", &function_d44eebe1517ed7f1, 0, 7 );
        devgui::add_devgui_func( "<dev string:x842>", "<dev string:x85b>", &function_bc25f2db761781bf, 0, 8 );
        devgui::add_devgui_func( "<dev string:x86a>", "<dev string:x883>", &function_bc25f3db761783f2, 0, 9 );
        devgui::add_devgui_func( "<dev string:x892>", "<dev string:x8a4>", &function_c2d0e4caac316b7d, 0, 10 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x8b6>" );
        devgui::add_devgui_func( "<dev string:x8e4>", "<dev string:x8f6>", &function_692f127980101c29 );
        devgui::add_devgui_func( "<dev string:x908>", "<dev string:x91d>", &function_f7792ad2765a7e20 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x3c3ab7d6, Offset: 0x6878
    // Size: 0x23, Type: dev
    function private spawn_launcher()
    {
        if ( level.elite_ironclad.truck )
        {
            return;
        }
        
        elite_ironclad_truck::function_ead720925ab4cf83();
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x4d859270, Offset: 0x68a3
    // Size: 0xc3, Type: dev
    function private function_18aa432716c7d1b0()
    {
        level.elite_ironclad.var_1ac9081036be7ca4 = 1;
        interactions = level.elite_ironclad.all_interacts ?? [];
        
        foreach ( interact in interactions )
        {
            interact enable_interaction( level.players );
            function_ff00cbf5d28eb319( interact, undefined, undefined, 0 );
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x5ffa3293, Offset: 0x696e
    // Size: 0x1b, Type: dev
    function private function_9b3e71f56964da23()
    {
        level.elite_ironclad.var_a9c6204649207507 = 1;
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xbef64a21, Offset: 0x6991
    // Size: 0x3e, Type: dev
    function private function_c504e8363240b41a()
    {
        current_value = level.elite_ironclad.var_9a8c3a80c80ddf18 === 1;
        level.elite_ironclad.var_9a8c3a80c80ddf18 = !current_value;
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xa738dca, Offset: 0x69d7
    // Size: 0xc1, Type: dev
    function private function_598afbb7a4fd762a()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( !activity_instance )
        {
            return;
        }
        
        activity_instance function_99846750895b045e( activity_instance.team );
        
        foreach ( interact in level.elite_ironclad.sabotage_interacts )
        {
            interact function_39d4eed12332f770( undefined );
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xdbe755e7, Offset: 0x6aa0
    // Size: 0xb6, Type: dev
    function private function_d44eebe1517ed7f1()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( !activity_instance )
        {
            return;
        }
        
        activity_instance function_a97fa7207e1f197e();
        
        foreach ( interact in level.elite_ironclad.var_dc8ced33eea5b3f7 )
        {
            interact on_keypad_used( undefined );
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xf47ed548, Offset: 0x6b5e
    // Size: 0x7f, Type: dev
    function private function_bc25f2db761781bf()
    {
        if ( !isdefined( level.var_6944daf01c00102b ) )
        {
            level.var_6944daf01c00102b = 0;
        }
        
        level.elite_ironclad.truck elite_ironclad_truck::function_a79bb4cd2c983fb9( "<dev string:x932>", level.var_6944daf01c00102b );
        level.var_6944daf01c00102b += 0.2;
        
        if ( level.var_6944daf01c00102b >= 1 )
        {
            level.var_6944daf01c00102b = 0;
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x6d7784f2, Offset: 0x6be5
    // Size: 0x7f, Type: dev
    function private function_bc25f3db761783f2()
    {
        if ( !isdefined( level.var_6944daf01c00102b ) )
        {
            level.var_6944daf01c00102b = 0;
        }
        
        level.elite_ironclad.truck elite_ironclad_truck::function_a79bb4cd2c983fb9( "<dev string:x944>", level.var_6944daf01c00102b );
        level.var_6944daf01c00102b += 0.2;
        
        if ( level.var_6944daf01c00102b >= 1 )
        {
            level.var_6944daf01c00102b = 0;
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xf9aa8923, Offset: 0x6c6c
    // Size: 0x24, Type: dev
    function private function_c2d0e4caac316b7d()
    {
        level.elite_ironclad.truck elite_ironclad_truck::function_a79bb4cd2c983fb9( "<dev string:x956>" );
    }

    // Namespace namespace_66d2304510c46347
    // Params 0
    // Checksum 0x9b35982, Offset: 0x6c98
    // Size: 0x3b, Type: dev
    function function_c6f4c390cfd8ff2c()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( !activity_instance )
        {
            return;
        }
        
        remove_all_interacts();
        activity_instance function_d4b353bda298fa5c();
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x88a06757, Offset: 0x6cdb
    // Size: 0x4b, Type: dev
    function private function_1869776f10a94802()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( !activity_instance )
        {
            return;
        }
        
        setdvar( @"hash_a12fb79fbe2fe79e", 1 );
        remove_all_interacts();
        activity_instance function_716610140eac0bfa();
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0xa6be8a71, Offset: 0x6d2e
    // Size: 0x3b, Type: dev
    function private function_e08c281f6aa4c565()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( !activity_instance )
        {
            return;
        }
        
        remove_all_interacts();
        activity_instance function_127c3402cb4c2cc5();
    }

    // Namespace namespace_66d2304510c46347
    // Params 2, eflags: 0x4
    // Checksum 0xe30be83, Offset: 0x6d71
    // Size: 0xa3, Type: dev
    function private function_6efd8c9e87815593( trigger_radius, trigger_height )
    {
        self endon( #"hash_3a67688599d723ea" );
        upvector = vectornormalize( anglestoup( self.angles ) ) * trigger_height;
        
        while ( true )
        {
            if ( !level.elite_ironclad.var_9fd296e7dea2ca74 )
            {
                return;
            }
            
            if ( getdvarint( @"hash_f7a88888a56abf5f", 0 ) == 1 )
            {
                cylinder( self.origin, self.origin + upvector, trigger_radius, ( 1, 1, 0 ), 0 );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 1, eflags: 0x4
    // Checksum 0x78d60625, Offset: 0x6e1c
    // Size: 0xe2, Type: dev
    function private debug_draw_interact( interact )
    {
        if ( !isdefined( interact ) )
        {
            return;
        }
        
        drawframes = 15;
        color = ( 0, 1, 0 );
        
        while ( isdefined( interact ) )
        {
            origin = interact.origin;
            cylinder( origin, origin + ( 0, 0, interact.interact_use_range ), interact.interact_use_range, color, 0, drawframes );
            forward = anglestoforward( interact.angles );
            arrowend = origin + forward * interact.interact_use_range * 1.5;
            line( origin, arrowend, ( 1, 0, 0 ), 1, 0, drawframes );
            wait level.framedurationseconds * drawframes;
        }
    }

    // Namespace namespace_66d2304510c46347
    // Params 0, eflags: 0x4
    // Checksum 0x31d0d4b4, Offset: 0x6f06
    // Size: 0xcf, Type: dev
    function private function_d7e0979094ff2e8c()
    {
        num_points = 10;
        start_pos = getclosestpointonnavmesh( self.origin );
        start_angles = self.angles;
        forward = anglestoforward( start_angles );
        path_size = 10000;
        end_pos = start_pos + forward * path_size;
        path_size = distance( start_pos, end_pos );
        waypoints = [];
        
        for ( i = 0; i < num_points ; i++ )
        {
            t = i / ( num_points - 1 );
            point = start_pos + forward * path_size * t;
            point = getclosestpointonnavmesh( point );
            waypoints[ waypoints.size ] = point;
        }
        
        return waypoints;
    }

    // Namespace namespace_66d2304510c46347
    // Params 0
    // Checksum 0x72506b67, Offset: 0x6fdd
    // Size: 0xdb, Type: dev
    function function_f7792ad2765a7e20()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.ignoredeathsdoor = 1;
            player player::_freezecontrols( 1, undefined, "<dev string:x95c>" );
            player utility::hidehudenable();
        }
        
        function_752b0a26ef315196( level.players[ 0 ].team );
    }

    // Namespace namespace_66d2304510c46347
    // Params 0
    // Checksum 0x363de4a5, Offset: 0x70c0
    // Size: 0xd3, Type: dev
    function function_692f127980101c29()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        owner = undefined;
        
        foreach ( player in level.players )
        {
            if ( player.team != host.team )
            {
                owner = player;
                break;
            }
        }
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        function_752b0a26ef315196( owner.team );
    }

#/
