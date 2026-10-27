// script_1317d37afd74f83b  (hash_1317d37afd74f83b.gscc) (size: 17590 Bytes / 0x44b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27611ae2 (660675298)
// size ...... 17590 (0x44b6)
// includes .. 24  (offset: 0x40f6)
// strings ... 43  (offset: 0x41b6)
// dev strs .. 14  (offset: 0x4402)
// exports ... 36  (offset: 0x2b4a)
// cseg ...... 0x46e + 0x26dc (0x2b4a)
// imports ... 133 (offset: 0x30ea)
// animtree1 . 0   (offset: 0x44b6)
// animtree2 . 0   (offset: 0x44b6)
#using script_10f6fed49001c470;
#using script_5218f92aaa1d8675;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_lootchopper;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace namespace_a51eacc5f33e2ef7;

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x5
// Checksum 0x8b6fbdfd, Offset: 0x48c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c326b8c166bd5219", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0x1600cb7e, Offset: 0x4b5
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE", &activity_type_init );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0xa755aa3f, Offset: 0x4d0
// Size: 0x28c
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entered_gulag, "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &function_e96fbdc2693d698d, "WZ_CONTRACT_IRONCLAD_CHOPPER_PHASE" );
    level.elitechopper = {};
    level.elitechopper.var_d2958f8f05865d78 = utility::function_48f723fdc612ec65( @"scr_br_quest_bonus_multiplier", 0.2, level.gametypebundle.var_d2958f8f05865d78 );
    level.elitechopper.var_ffa2c5fe1c38cb78 = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_enabled", 1, level.gametypebundle.var_ffa2c5fe1c38cb78 );
    level.elitechopper.var_1900cf632676172b = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_max", 5, level.gametypebundle.var_1900cf632676172b );
    level.elitechopper.var_286863dc363b45d0 = utility::function_edc4cc03e9e60b3e( @"hash_868a4514edae1c1d", 1, level.gametypebundle.var_286863dc363b45d0 );
    level.elitechopper.var_e83b3fcdc1140057 = utility::function_edc4cc03e9e60b3e( @"hash_204a8db4e2568b1a", 1, level.gametypebundle.var_e83b3fcdc1140057 );
    level.elitechopper.var_9939a6cfcebfbb3b = utility::function_edc4cc03e9e60b3e( @"hash_199d84d3cc607999", 1, level.gametypebundle.var_9939a6cfcebfbb3b );
    level.elitechopper.var_20505960f9ad627c = utility::function_edc4cc03e9e60b3e( @"hash_b2afac77f34710f2", 1, level.gametypebundle.var_20505960f9ad627c );
    level.elitechopper.var_5e5cf709bf9e63fe = utility::function_edc4cc03e9e60b3e( @"hash_a5140d137c41afac", 1, level.gametypebundle.var_5e5cf709bf9e63fe );
    level.elitechopper.var_b537b9201a25433 = utility::function_edc4cc03e9e60b3e( @"hash_789080dab16431b1", 1, level.gametypebundle.var_b537b9201a25433 );
    init_choppers();
    init_dev_gui();
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0xc283c0d, Offset: 0x764
// Size: 0x101
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    activity_instance.analytics = {};
    activity_instance.item_pickup_callback_params = { #force_resume:0, #activity_instance:activity_instance };
    activity_instance.item_drop_callback_params = { #force_resume:1, #activity_instance:activity_instance };
    squad_size = br_public::function_ab5e009b1898c081();
    activity_instance.var_a346cbd10878dc33 = utility::function_edc4cc03e9e60b3e( @"hash_313eeb8da499ed5a", 10000, activity_instance.var_332f929de1894b2b.var_8f588d88e244c51e[ squad_size ].var_a346cbd10878dc33 );
    
    /#
        level.elite_ironclad.dev_activity_instance = activity_instance;
    #/
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x6f272dd8, Offset: 0x86d
// Size: 0x11e
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.analytics.start_time = gettime();
    hud_util::showsplashtoteam( activity_instance.team, "elite_ironclad_chopper_start", undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    activity_instance br_activity_util::function_4e9e312232df58ab( "elite_ironclad_chopper_hunt" );
    level.elite_ironclad.team_info.state = 3;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
    function_881b6729969b3c19();
    level callback::add( #"player_item_pickup", &function_c27b3e8cc537cbec, activity_instance.item_pickup_callback_params );
    level callback::add( #"player_item_drop", &function_c27b3e8cc537cbec, activity_instance.item_drop_callback_params );
    level callback::add( #"hash_6be17d27fe58c7b1", &function_c27b3e8cc537cbec, activity_instance.item_drop_callback_params );
    activity_instance thread function_6b9f6bd3769cf431();
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x7b09353c, Offset: 0x993
// Size: 0x13e
function activity_ended()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance.analytics.end_time = gettime();
    
    if ( isdefined( activity_instance.chopper ) )
    {
        if ( !isdefined( activity_instance.analytics.chopper_damage_taken ) )
        {
            activity_instance.analytics.chopper_damage_taken = activity_instance.chopper.maxhealth - activity_instance.chopper.health;
        }
    }
    
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( activity_instance );
    
    if ( activity_succeeded && activity_instance.var_332f929de1894b2b.var_1ff3ac3b7136a04d )
    {
        hud_util::showsplashtoallexceptteam( activity_instance.team, activity_instance.var_332f929de1894b2b.var_1ff3ac3b7136a04d, undefined, undefined, undefined, undefined, "splash_list_br_contract_elite_ironclad" );
    }
    
    activity_instance function_893d27ff9f4a36b2( -1 );
    setomnvar( "ui_br_show_objective_path", 0 );
    
    if ( isdefined( activity_instance.chopper_collision_proxy ) )
    {
        activity_instance.chopper_collision_proxy delete();
        activity_instance.chopper_collision_proxy = undefined;
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x3a181dbc, Offset: 0xad9
// Size: 0x185
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level callback::remove( #"player_item_pickup", &function_c27b3e8cc537cbec, activity_instance.item_pickup_callback_params );
    level callback::remove( #"player_item_drop", &function_c27b3e8cc537cbec, activity_instance.item_drop_callback_params );
    level callback::remove( #"hash_6be17d27fe58c7b1", &function_c27b3e8cc537cbec, activity_instance.item_drop_callback_params );
    activity_instance function_893d27ff9f4a36b2( -1 );
    setomnvar( "ui_br_show_objective_path", 0 );
    a = activity_instance.analytics;
    dlog_recordevent( "dlog_event_br_elite_ironclad_chopper", [ "start_time", a.start_time ?? 0, "end_time", a.end_time ?? 0, "end_reason", a.end_reason ?? "unknown", "damage_taken", a.chopper_damage_taken ?? 0, "crate_x", a.var_5c90bbc9c717ca30[ 0 ] ?? 0, "crate_y", a.var_5c90bbc9c717ca30[ 1 ] ?? 0, "crate_z", a.var_5c90bbc9c717ca30[ 2 ] ?? 0 ] );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0x32f02e1d, Offset: 0xc66
// Size: 0xaf
function private function_6b9f6bd3769cf431()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity endon( #"hash_7f56f456d1553778" );
    
    while ( !isdefined( activity.crate ) || !br_circle::function_6bf5d4e680297398( activity.crate.origin, br_circle::getdangercircleorigin(), max( 0, br_circle::getdangercircleradius() + 500 ) ) )
    {
        wait 1;
    }
    
    wait 5;
    activity.analytics.end_reason = "Gas";
    activity_instance_common::endactivity( activity, 0 );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1
// Checksum 0x612f4c1a, Offset: 0xd1d
// Size: 0x2ee
function function_217720e28a0d9d73( chopper )
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    activity endon( #"chopper_dead" );
    chopper.progress = 0;
    activity function_893d27ff9f4a36b2( chopper.progress );
    max_distance = distance2d( ( chopper.spawn_info.var_4c93b37547ba809b.origin[ 0 ], chopper.spawn_info.var_4c93b37547ba809b.origin[ 1 ], 0 ), ( chopper.spawn_info.end_location.origin[ 0 ], chopper.spawn_info.end_location.origin[ 1 ], 0 ) );
    distance = distance2d( ( chopper.origin[ 0 ], chopper.origin[ 1 ], 0 ), ( chopper.spawn_info.end_location.origin[ 0 ], chopper.spawn_info.end_location.origin[ 1 ], 0 ) );
    
    while ( isdefined( chopper ) && distance > 1000 )
    {
        wait 0.1;
        
        if ( isdefined( chopper.var_f924da9eea96f5b8 ) || !chopper.var_611debc92887a848 )
        {
            continue;
        }
        
        distance = distance2d( ( chopper.origin[ 0 ], chopper.origin[ 1 ], 0 ), ( chopper.spawn_info.end_location.origin[ 0 ], chopper.spawn_info.end_location.origin[ 1 ], 0 ) );
        progress = distance > 0 ? int( 100 - distance * 100 / max_distance ) : 0;
        
        if ( progress > chopper.progress )
        {
            chopper.progress = clamp( progress, 0, 100 );
            activity function_893d27ff9f4a36b2( chopper.progress );
        }
    }
    
    activity notify( #"chopper_left" );
    activity function_893d27ff9f4a36b2( -1 );
    setomnvar( "ui_br_show_objective_path", 0 );
    
    if ( isdefined( chopper ) )
    {
        activity.analytics.chopper_damage_taken = chopper.maxhealth - chopper.health;
        chopper chopper_support::choppersupport_cleanup();
    }
    
    activity.analytics.end_reason = "Flew Away";
    activity_instance_common::endactivity( activity, 0 );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x2bb0bc00, Offset: 0x1013
// Size: 0x32
function init_choppers()
{
    namespace_1999aeb00a58bdf6::init();
    level.var_b4c8dcabb0437344 = 1;
    utility::registersharedfunc( #"br_elitechopper", #"elitechopper_oncrateuse", &on_crate_use );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x9ae3301a, Offset: 0x104d
// Size: 0x50b
function function_881b6729969b3c19()
{
    activity_instance = self;
    spawn_info = activity_instance get_chopper_spawn_info();
    overwrite_parameters = { #clustercooldown:utility::function_edc4cc03e9e60b3e( @"hash_7e79213f381510ae", 20, activity_instance.var_332f929de1894b2b.clustercooldown ), #var_63ccbd180a0cb0e5:utility::function_edc4cc03e9e60b3e( @"hash_8eb030e9323082b9", 0, activity_instance.var_332f929de1894b2b.var_63ccbd180a0cb0e5 ), #model:"veh9_mil_air_heli_hind_nuke_weapons", #vehicletype:"veh9_mil_air_heli_hind_nophysics_br_cq", #lifetime:activity_instance.var_332f929de1894b2b.patroltimer, #endposition:spawn_info.end_location, #startingposition:spawn_info.start_location, #accel:activity_instance.var_332f929de1894b2b.var_db8e9a38ce1d2bf1, #speed:activity_instance.var_332f929de1894b2b.var_279abac14446c08a };
    setomnvar( "ui_br_objective_path_start_x", int( spawn_info.start_location.origin[ 0 ] ) );
    setomnvar( "ui_br_objective_path_start_y", int( spawn_info.start_location.origin[ 1 ] ) );
    setomnvar( "ui_br_objective_path_end_x", int( spawn_info.end_location.origin[ 0 ] ) );
    setomnvar( "ui_br_objective_path_end_y", int( spawn_info.end_location.origin[ 1 ] ) );
    setomnvar( "ui_br_show_objective_path", 1 );
    chopper = br_lootchopper::lootchopper_spawn( spawn_info.var_4c93b37547ba809b, overwrite_parameters );
    chopper.spawn_info = spawn_info;
    chopper.var_f03e89372b1412a0 = "hitvehicle";
    
    if ( level.elitechopper.var_e83b3fcdc1140057 )
    {
        activity_instance.chopper_collision_proxy = spawn_chopper_collision_proxy( chopper );
    }
    
    /#
        if ( getdvarint( @"hash_ff1331225be623d0", 0 ) )
        {
            objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( objectiveiconid != -1 )
            {
                objidpoolmanager::objective_add_objective( objectiveiconid, "<dev string:x24>", spawn_info.start_location.origin, "<dev string:x2b>", "<dev string:x4e>" );
                objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
            }
            
            objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( objectiveiconid != -1 )
            {
                objidpoolmanager::objective_add_objective( objectiveiconid, "<dev string:x24>", spawn_info.end_location.origin, "<dev string:x2b>", "<dev string:x4e>" );
                objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
            }
        }
    #/
    
    if ( isdefined( chopper ) )
    {
        activity_instance.chopper = chopper;
        chopper.activity = activity_instance;
        
        if ( !getdvarint( @"hash_4905985d9a3997f", 0 ) )
        {
            chopper.patrolfunc = &chopper_fly_path;
            chopper.var_7eff079c201c90b9 = &function_51c541daff62b8f;
        }
        
        chopper.lootfunc = &chopper_drop_crate;
        chopper.gettargetfunc = &chopper_get_targets;
        chopper.leavefunc = &chopper_leave;
        chopper.var_5087068ea6aa76fa = &function_fab70accd9b7aa5a;
        chopper.health = activity_instance.var_a346cbd10878dc33;
        chopper.maxhealth = activity_instance.var_a346cbd10878dc33;
        objidpoolmanager::update_objective_icon( chopper.objectiveiconid, "ui_map_icon_elite_attack_chopper_cq" );
        objidpoolmanager::update_objective_description( chopper.objectiveiconid, &"vehicles/nuclear_chopper" );
        objidpoolmanager::update_objective_setbackground( chopper.objectiveiconid, 1 );
        objidpoolmanager::update_objective_setzoffset( chopper.objectiveiconid, 200 );
        objidpoolmanager::function_373aaf492aabde6f( chopper.objectiveiconid, 246, 192, 72 );
        chopper.scriptedobjid = chopper.objectiveiconid;
        activity_instance.objectiveiconid = chopper.objectiveiconid;
        function_fd9ed552c76d6299( chopper.objectiveiconid );
        objective_showtoplayersinmask( chopper.objectiveiconid );
        
        if ( getdvarint( @"hash_25134c98936f6c13", 1 ) )
        {
            objidpoolmanager::update_objective_state( chopper.objectiveiconid, "current" );
        }
        
        activity_instance thread chopper_death_watcher( chopper );
        activity_instance thread function_217720e28a0d9d73( chopper );
        return;
    }
    
    logstring( "br_elite_chopper_quest::spawn_chopper - no chopper was spawned!" );
    
    if ( getdvarint( @"hash_7200b73568c19e2", 1 ) )
    {
        var_12224e01d73eba98 = spawnstruct();
        circle_center = br_circle::getnextsafecircleorigin();
        var_12224e01d73eba98.origin = ( circle_center[ 0 ], circle_center[ 1 ], 10000 );
        var_12224e01d73eba98.activity = activity_instance;
        var_12224e01d73eba98 chopper_drop_crate();
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0xd2743707, Offset: 0x1560
// Size: 0x3f
function private player_entered_gulag( params )
{
    if ( self.objectiveiconid )
    {
        objective_removeclientfrommask( self.objectiveiconid, params.player );
        objective_showtoplayersinmask( self.objectiveiconid );
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0xdca86d6d, Offset: 0x15a7
// Size: 0x3f
function private function_e96fbdc2693d698d( params )
{
    if ( self.objectiveiconid )
    {
        objective_addclienttomask( self.objectiveiconid, params.player );
        objective_showtoplayersinmask( self.objectiveiconid );
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0x9986700d, Offset: 0x15ee
// Size: 0x9e
function private get_chopper_spawn_info()
{
    circle_info = get_circle_info();
    spawn_position = get_chopper_spawn_position( circle_info );
    start_patrol_position = function_cb32e560869f7a96( circle_info );
    end_position = get_chopper_end_position( circle_info );
    return { #aim_point:circle_info.aim_point, #end_location:{ #origin:end_position }, #var_4c93b37547ba809b:{ #origin:start_patrol_position }, #start_location:{ #origin:spawn_position } };
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0x2c21b71a, Offset: 0x1695
// Size: 0x120
function private get_circle_info()
{
    current_center = br_circle::getsafecircleorigin();
    current_radius = br_circle::getsafecircleradius();
    next_center = br_circle::getnextsafecircleorigin() ?? current_center;
    next_radius = br_circle::getnextsafecircleradius() ?? current_radius;
    var_4b7050ae8991ac5f = br_circle::getrandompointinboundscircle( current_center, current_radius, 1, 1 ) * ( 1, 1, 0 );
    aim_point = br_circle::getrandompointinboundscircle( next_center, next_radius * self.var_332f929de1894b2b.var_cd6afba03638d3d7, 0, 1 ) * ( 1, 1, 0 );
    direction = vectornormalize( aim_point - var_4b7050ae8991ac5f );
    return { #aim_point:aim_point, #direction:direction, #var_4b7050ae8991ac5f:var_4b7050ae8991ac5f, #next:{ #radius:next_radius, #center:next_center }, #current:{ #radius:current_radius, #center:current_center } };
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0xcf114a6d, Offset: 0x17be
// Size: 0x78
function private get_chopper_spawn_position( circle_info )
{
    horizontal_spawn_offset = utility::function_edc4cc03e9e60b3e( @"hash_e61953b7e3732736", 0, self.var_332f929de1894b2b.var_573fddaa4e616ed6 );
    spawn_position = circle_info.var_4b7050ae8991ac5f - circle_info.direction * horizontal_spawn_offset;
    spawn_position = br::getoffsetspawnoriginmultitrace( spawn_position, ( 0, 0, 10000 ) );
    return spawn_position;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0xdf149f0b, Offset: 0x183f
// Size: 0xeb
function private get_chopper_end_position( circle_info )
{
    start_distance = circle_info.current.radius * 2 * 0.75;
    offset_distance = 0;
    end_location = circle_info.var_4b7050ae8991ac5f;
    
    while ( offset_distance < circle_info.current.radius )
    {
        end_location = circle_info.var_4b7050ae8991ac5f + circle_info.direction * ( start_distance + offset_distance );
        end_location *= ( 1, 1, 0 );
        end_location = br::getoffsetspawnoriginmultitrace( end_location, ( 0, 0, 10000 ) );
        
        if ( outofbounds::ispointinoutofbounds( end_location ) || br_circle::function_6bf5d4e680297398( end_location, br_circle::getdangercircleorigin(), br_circle::getdangercircleradius() ) )
        {
            break;
        }
        
        offset_distance += 500;
    }
    
    return end_location;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0xa621a8e8, Offset: 0x1933
// Size: 0x38
function private function_cb32e560869f7a96( circle_info )
{
    var_4c93b37547ba809b = br::getoffsetspawnoriginmultitrace( circle_info.var_4b7050ae8991ac5f, ( 0, 0, 10000 ) );
    return var_4c93b37547ba809b;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 3
// Checksum 0x73506c98, Offset: 0x1974
// Size: 0x1ed
function function_fab70accd9b7aa5a( targ, targetvehicle, searchfortarget )
{
    ang = 0;
    
    if ( level.elite_ironclad.cq_team )
    {
        players = teams::getteamdata( level.elite_ironclad.cq_team, "players" );
        
        foreach ( player in players )
        {
            if ( player == targ.player )
            {
                ang += self.activity.var_332f929de1894b2b.var_8b9098f4fa3c77a0;
            }
        }
    }
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( attackerinfo in self.attackers )
        {
            if ( attackerinfo.player == targ.player )
            {
                if ( gettime() - attackerinfo.lastdamagetime < self.activity.var_332f929de1894b2b.var_d71573ed399bf9db )
                {
                    ang += self.activity.var_332f929de1894b2b.var_bd6272a5dcf4bfe6;
                }
            }
        }
    }
    
    return ang;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 2, eflags: 0x4
// Checksum 0xdf7f6fce, Offset: 0x1b6a
// Size: 0x1d4
function private function_c27b3e8cc537cbec( params, var_b19ce51dfc12b7f8 )
{
    if ( !getdvarint( @"hash_ee5b7469e62f2b7d", 0 ) )
    {
        return;
    }
    
    if ( params.itembundlename != %"hash_18bbe4ece9b75940" && params.itembundlename != %"hash_5fb15d7c2a806cf5" )
    {
        return;
    }
    
    activity_instance = var_b19ce51dfc12b7f8.activity_instance;
    chopper = activity_instance.chopper;
    
    if ( !var_b19ce51dfc12b7f8.force_resume && params.player.team != activity_instance.team )
    {
        /#
            if ( getdvarint( @"hash_839c23829c79a457", 0 ) )
            {
                println( "<dev string:x5a>" + activity_instance.var_332f929de1894b2b.chopperaccel );
            }
        #/
        
        chopper vehicle_setspeed( 0, activity_instance.var_332f929de1894b2b.chopperaccel );
        return;
    }
    
    chopper_speed_override = getdvarint( @"scr_elite_ironclad_chopper_speed" );
    resume_speed = chopper_speed_override ? chopper_speed_override : activity_instance.var_332f929de1894b2b.chopperspeed;
    reason = var_b19ce51dfc12b7f8.force_resume ? "item_dropped_or_removed_resume" : "owner_item_pickup_resume";
    
    /#
        if ( getdvarint( @"hash_839c23829c79a457", 0 ) )
        {
            println( "<dev string:xb3>" + reason + "<dev string:xe6>" + resume_speed + "<dev string:xef>" + activity_instance.var_332f929de1894b2b.chopperaccel );
        }
    #/
    
    chopper vehicle_setspeed( resume_speed, activity_instance.var_332f929de1894b2b.chopperaccel );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x94e6acdb, Offset: 0x1d46
// Size: 0x12b
function chopper_get_targets()
{
    targets = [];
    
    if ( level.elite_ironclad.cq_team )
    {
        players = teams::getteamdata( level.elite_ironclad.cq_team, "players" );
        targets = arraycombine( targets, players );
    }
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( attackerinfo in self.attackers )
        {
            if ( isdefined( attackerinfo.player ) )
            {
                if ( gettime() - attackerinfo.lastdamagetime < self.activity.var_332f929de1894b2b.var_d71573ed399bf9db )
                {
                    targets = arraycombineunique( targets, [ attackerinfo.player ] );
                }
            }
        }
    }
    
    return targets;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1
// Checksum 0xce16384c, Offset: 0x1e7a
// Size: 0x3be
function chopper_fly_path( initial_patrol )
{
    var_f50d248ef7a1bb2d = self.currentaction;
    
    if ( self.currentaction != "patrol" )
    {
        if ( var_f50d248ef7a1bb2d == "attacking" )
        {
            self.var_407c4370d6a87679 = gettime();
        }
        
        self.currentaction = "patrol";
    }
    else if ( self.currentaction == "patrol" && !initial_patrol )
    {
        return;
    }
    
    self clearlookatent();
    self setneargoalnotifydist( 300 );
    chopper_speed_override = getdvarint( @"scr_elite_ironclad_chopper_speed" );
    
    while ( true )
    {
        if ( self.currentaction == "attacking" )
        {
            self.var_407c4370d6a87679 = gettime();
            waitframe();
            continue;
        }
        
        if ( initial_patrol )
        {
            var_f3b24900dcebb7bd = chopper_speed_override ? chopper_speed_override : self.activity.var_332f929de1894b2b.chopperspeed;
            self vehicle_setspeed( var_f3b24900dcebb7bd, self.activity.var_332f929de1894b2b.chopperaccel );
            self.var_611debc92887a848 = 1;
            chopper_support::choppersupport_movetolocation( self.spawn_info.end_location, 0 );
        }
        else
        {
            if ( chopper_support::choppersupport_checkifactivetargets() )
            {
                self.var_407c4370d6a87679 = gettime();
            }
            
            if ( isdefined( self.var_407c4370d6a87679 ) && gettime() - self.var_407c4370d6a87679 > self.activity.var_332f929de1894b2b.var_7a7f4dc94b34e202 )
            {
                if ( isdefined( self.var_f924da9eea96f5b8 ) )
                {
                    self vehicle_setspeed( self.activity.var_332f929de1894b2b.var_3869bfd005e598d3, self.activity.var_332f929de1894b2b.var_31102ae4ce6a01f0 );
                    chopper_support::choppersupport_movetolocation( self.var_f924da9eea96f5b8, 0 );
                    self.var_f924da9eea96f5b8 = undefined;
                }
                
                var_f3b24900dcebb7bd = chopper_speed_override ? chopper_speed_override : self.activity.var_332f929de1894b2b.chopperspeed;
                self vehicle_setspeed( var_f3b24900dcebb7bd, self.activity.var_332f929de1894b2b.chopperaccel );
                chopper_support::choppersupport_movetolocation( self.spawn_info.end_location, 0 );
            }
            else
            {
                allenemies = [];
                sumvectors = ( 0, 0, 0 );
                
                foreach ( player in chopper_get_targets() )
                {
                    if ( player == self.owner )
                    {
                        continue;
                    }
                    
                    if ( level.teambased && player.team == self.owner.team )
                    {
                        continue;
                    }
                    
                    if ( !player player::isreallyalive() )
                    {
                        continue;
                    }
                    
                    sumvectors += player.origin;
                    allenemies[ allenemies.size ] = player;
                }
                
                if ( isdefined( sumvectors ) && allenemies.size > 0 )
                {
                    newlocation = sumvectors / allenemies.size;
                    newlocation = br::getoffsetspawnoriginmultitrace( newlocation, ( 0, 0, 10000 ) );
                    self.pathgoal = newlocation;
                    chopper_support::choppersupport_movetolocation( newlocation );
                }
            }
        }
        
        hostmigration::waitlongdurationwithpause( 0.1 );
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0xa63d4b0f, Offset: 0x2240
// Size: 0x102
function chopper_drop_crate()
{
    chopper = self;
    droplocation = br_lootchopper::lootchopper_finddroplocation( chopper.origin + ( 0, 0, 500 ) );
    crate = airdrop::function_30f0e86320b9c8cc( chopper.origin, droplocation );
    
    if ( isdefined( crate ) )
    {
        activity = chopper.activity;
        crate.activity = activity;
        activity.crate = crate;
        level.elite_ironclad.chopper_origin = chopper.origin;
    }
    
    wait 2;
    chopper.activity br_activity_util::function_4e9e312232df58ab( "elite_ironclad_chopper_loot" );
    level.elite_ironclad.team_info.state = 4;
    level.elite_ironclad.team_info namespace_59f63cf8cb6ba727::function_d8f0bed02cdc016();
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1
// Checksum 0xf15cba4, Offset: 0x234a
// Size: 0x13c
function on_crate_use( player )
{
    activity = self.activity;
    common_item::function_45c338c4003d5f13( self, 0 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    spawnoptions.critical = 1;
    spawnoptions.spawnoptions = 1;
    spawnoptions.spawnoptions = [ self ];
    harddrive = common_item::function_61c2c0251e742ffd( %"hash_18bbe4ece9b75940", 1, spawnoptions );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_elite_ironclad_chopper_crate" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount, spawnoptions );
    }
    
    activity.keyitemtype = harddrive.type;
    activity.analytics.var_5c90bbc9c717ca30 = self.origin;
    airdrop::makecrateunusable();
    waitframe();
    self setscriptablepartstate( #"capture_effect", #"land_fade", 0 );
    activity notify( #"hash_7f56f456d1553778" );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1
// Checksum 0xc59f1d30, Offset: 0x248e
// Size: 0xd3
function chopper_death_watcher( newchopper )
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"chopper_left" );
    activity_instance = self;
    newchopper waittill( #"death" );
    self notify( #"chopper_dead" );
    activity_instance function_893d27ff9f4a36b2( -1 );
    setomnvar( "ui_br_show_objective_path", 0 );
    activity_instance.analytics.chopper_damage_taken = newchopper.maxhealth - newchopper.health;
    activity_instance.analytics.end_reason = "Shot Down";
    level thread br_public::brleaderdialogteam( "mission_elite_chopper_heli_destroy", self.teams[ 0 ], undefined, 8.5 );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x8842657b, Offset: 0x2569
// Size: 0x42
function chopper_leave()
{
    self vehicle_setspeed( self.activity.var_332f929de1894b2b.var_bb088ea825edf21f, self.activity.var_332f929de1894b2b.var_8ca31ed8b0eab824 );
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0
// Checksum 0x72b9fb03, Offset: 0x25b3
// Size: 0x37
function function_51c541daff62b8f()
{
    self.var_407c4370d6a87679 = gettime();
    
    if ( !isdefined( self.var_f924da9eea96f5b8 ) )
    {
        self.var_f924da9eea96f5b8 = { #origin:self.origin };
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1
// Checksum 0xf2a1595a, Offset: 0x25f2
// Size: 0xae
function function_893d27ff9f4a36b2( progress )
{
    activity_instance = self;
    team_players = teams::getteamdata( activity_instance.team, "players" );
    
    foreach ( player in team_players )
    {
        player setclientomnvar( "ui_chopper_progress", progress );
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 1, eflags: 0x4
// Checksum 0x603f0ce4, Offset: 0x26a8
// Size: 0x97
function private spawn_chopper_collision_proxy( chopper )
{
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    halfsize = chopper getboundshalfsize();
    halfsize = ( min( halfsize[ 0 ], 350 ), min( halfsize[ 1 ], 320 ), min( halfsize[ 2 ], 150 ) );
    proxy = spawn( "trigger_box", chopper.origin, 0, halfsize, halfsize );
    proxy enablelinkto();
    proxy linkto( chopper, "tag_origin" );
    proxy.chopper = chopper;
    proxy thread function_a955679cb9da2cee();
    return proxy;
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0x21189913, Offset: 0x2748
// Size: 0x270
function private function_a955679cb9da2cee()
{
    level endon( #"game_ended" );
    self.chopper endon( #"death" );
    proxy = self;
    chopper = proxy.chopper;
    var_3f4f6f4e52021b44 = level.elitechopper.var_5e5cf709bf9e63fe;
    var_ac4e98a0c25cab63 = level.elitechopper.var_b537b9201a25433;
    var_bf9bcf92c37f2991 = level.elitechopper.var_9939a6cfcebfbb3b;
    var_91183ef389263cc = level.elitechopper.var_20505960f9ad627c;
    
    while ( isdefined( proxy ) && isdefined( chopper ) )
    {
        proxy waittill( #"trigger", hitent );
        
        if ( !isdefined( hitent ) || hitent == chopper )
        {
            continue;
        }
        
        targetent = hitent;
        
        if ( isplayer( hitent ) && isdefined( hitent.vehicle ) )
        {
            targetent = hitent.vehicle;
        }
        
        if ( !isdefined( targetent ) || targetent == chopper )
        {
            continue;
        }
        
        now = gettime();
        
        if ( isdefined( targetent.var_de1bbc1dfaa9134e ) && now < targetent.var_de1bbc1dfaa9134e )
        {
            continue;
        }
        
        targetent.var_de1bbc1dfaa9134e = now + 300;
        pushorigin = targetent.origin;
        pushdir = vectornormalize( pushorigin - chopper.origin );
        
        if ( !isdefined( pushdir ) )
        {
            pushdir = ( 0, 0, 0 );
        }
        
        if ( targetent.classname == "script_vehicle" )
        {
            if ( var_3f4f6f4e52021b44 )
            {
                targetent dodamage( 150, targetent.origin, chopper, chopper, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
            
            if ( var_ac4e98a0c25cab63 )
            {
                targetent vehicle_setvelocity( pushdir * 650 + ( 0, 0, 120 ) );
            }
            
            continue;
        }
        
        if ( isplayer( targetent ) )
        {
            if ( var_bf9bcf92c37f2991 )
            {
                targetent dodamage( 100, targetent.origin, chopper, chopper, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
            
            if ( var_91183ef389263cc )
            {
                targetent setvelocity( pushdir * 500 + ( 0, 0, 180 ) );
            }
            
            continue;
        }
    }
}

// Namespace namespace_a51eacc5f33e2ef7
// Params 0, eflags: 0x4
// Checksum 0xa88a3fbd, Offset: 0x29c0
// Size: 0x5a
function private init_dev_gui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:xf7>" );
        devgui::add_devgui_func( "<dev string:x13f>", "<dev string:x14c>", &kill_chopper );
        devgui::add_devgui_func( "<dev string:x159>", "<dev string:x16f>", &function_a75f22f579e636ae );
        devgui::add_devgui_func( "<dev string:x185>", "<dev string:x19a>", &function_5b6d86f99d867021 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace namespace_a51eacc5f33e2ef7
    // Params 0
    // Checksum 0x5c46fe13, Offset: 0x2a22
    // Size: 0x97, Type: dev
    function kill_chopper()
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( isdefined( activity_instance.chopper ) )
        {
            activity_instance.chopper dodamage( activity_instance.chopper.maxhealth, activity_instance.chopper.origin );
        }
        
        if ( isdefined( activity_instance.chopper_collision_proxy ) )
        {
            activity_instance.chopper_collision_proxy delete();
            activity_instance.chopper_collision_proxy = undefined;
        }
    }

    // Namespace namespace_a51eacc5f33e2ef7
    // Params 0
    // Checksum 0x4be795aa, Offset: 0x2ac1
    // Size: 0x10, Type: dev
    function function_a75f22f579e636ae()
    {
        set_chopper_speed( 100, 50 );
    }

    // Namespace namespace_a51eacc5f33e2ef7
    // Params 0
    // Checksum 0x176bce94, Offset: 0x2ad9
    // Size: 0x10, Type: dev
    function function_5b6d86f99d867021()
    {
        set_chopper_speed( 20, 10 );
    }

    // Namespace namespace_a51eacc5f33e2ef7
    // Params 2
    // Checksum 0x62d76d6e, Offset: 0x2af1
    // Size: 0x59, Type: dev
    function set_chopper_speed( speed, accel )
    {
        activity_instance = level.elite_ironclad.dev_activity_instance;
        
        if ( isdefined( activity_instance.chopper ) )
        {
            activity_instance.chopper vehicle_setspeed( speed, accel );
        }
    }

#/
