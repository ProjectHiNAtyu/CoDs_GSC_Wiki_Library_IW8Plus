// scripts\mp\ob\activities\ob_activity_drone_hunt.gsc  (hash_546245edd0440248.gscc) (size: 7126 Bytes / 0x1bd6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf0e03d0 (3742237648)
// size ...... 7126 (0x1bd6)
// includes .. 16  (offset: 0x19d6)
// strings ... 28  (offset: 0x1a56)
// dev strs .. 0   (offset: 0x1bd6)
// exports ... 23  (offset: 0xef2)
// cseg ...... 0x2c0 + 0xc32 (0xef2)
// imports ... 64  (offset: 0x128a)
// animtree1 . 0   (offset: 0x1bd6)
// animtree2 . 0   (offset: 0x1bd6)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_resource_manager;

#namespace ob_activity_drone_hunt;

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0x5
// Checksum 0x3b59fb42, Offset: 0x2de
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_95679db67905b88a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0x5a1e3cbf, Offset: 0x307
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HARVESTERORB", &harvesterorb_activity_type_init );
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0xd711594d, Offset: 0x322
// Size: 0x144
function harvesterorb_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 0, &drone_hunt_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 1, &drone_hunt_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 2, &drone_hunt_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 3, &drone_hunt_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 4, &function_cfb6aea44c7a6e15 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &drone_hunt_player_joined_activity, "REV_OB_HARVESTERORB" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &drone_hunt_player_left_activity, "REV_OB_HARVESTERORB" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &player_entered_awareness_zone, "REV_OB_HARVESTERORB" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_c7871b7129e9c0c8, "REV_OB_HARVESTERORB" );
    activity_common::function_944074f3079c1d4e( "REV_OB_HARVESTERORB", 5, &function_7b6a5d5efa2fd4d );
    utility::add_fx( "drone_damaged_smoke_vfx", "vfx_sat_drone_damage_trail_smk" );
    utility::add_fx( "drone_scan_vfx", "vfx_jup_gameplay_spy_drones_scan" );
    utility::add_fx( "helper_drone_explode", "vfx_sat_drone_hit_damage_explo" );
    level.ob_drone_throttle = throttle::throttle_initialize( "ob_drone_move", 1, level.framedurationseconds ?? 0.1 );
    level.var_248484aa7e0c4178 = getdvarint( @"scr_activity_drone_hunt_quest", 1 );
    ob_flying_drone::setup_helper_drones();
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x84c225ad, Offset: 0x46e
// Size: 0x82
function drone_hunt_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance.var_91c91f4a631c481d = activityvariantdefinition;
    activity_instance.difficulty_region = get_difficulty_region_string();
    activity_instance.handler_list = [ "marshall", "karma" ];
    activity_instance thread setup_drone_hunt();
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x8f394391, Offset: 0x4f8
// Size: 0x2c0
function setup_drone_hunt()
{
    self.var_4531031c457be57b = utility::getstructarray( "harvesterorb_exclusion_area", "targetname" );
    thread function_ea8cc13e77d6c4d1();
    self.settings = self.var_91c91f4a631c481d;
    dronesettings = self.settings.var_2858c1d9ffae3f84.var_3af1960784817aa8;
    self.location = activity_instance_common::function_776ee11e7acc64a5( self );
    self.spawn_pos = getgroundposition( self.location, 300 );
    spawnposheight = self.spawn_pos[ 2 ] + randomfloatrange( dronesettings.var_9d4b464f832c27d3, dronesettings.var_9d6e5c4f83529fed );
    self.spawn_pos = ( self.spawn_pos[ 0 ], self.spawn_pos[ 1 ], spawnposheight );
    spawnoptions = { #goal:#"hash_6573e43fb6b70d11", #canlootdrop:1, #canmove:1, #spawnpos:self.spawn_pos, #enableaimassist:1, #candamage:1 };
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    spawnoptions.var_2858c1d9ffae3f84 = activityvariantdefinition.var_2858c1d9ffae3f84;
    spawnoptions.difficulty_region = self.difficulty_region;
    
    if ( level.var_248484aa7e0c4178 )
    {
        spawnoptions.canlootdrop = 0;
        spawnoptions.var_d2239bfa942af92e = 1;
    }
    
    ent_drone = ob_resource_manager::activity_spawn_entity( "script_model", spawnoptions.spawnpos );
    ent_drone.activity_instance = self;
    leaderdrone = ob_flying_drone::function_d664e23d9508b462( spawnoptions, ent_drone );
    turret::function_6697525b8034338a( leaderdrone );
    leaderdrone ob_flying_drone::function_e0de4dce57ae487();
    leaderdrone callback::add( #"on_ping", &function_27a18c325b9b3bc2 );
    self.drone = leaderdrone;
    leaderdrone thread ob_flying_drone::function_dbc3536438aea5e0();
    leaderdrone thread ob_flying_drone::drone_movebehavior();
    leaderdrone setscriptablepartstate( #"drone", #"activity" );
    ob_activity_instance_common::function_9c6b2d04234d7b5e( self, leaderdrone );
    
    if ( !isdefined( level.ob.drones ) )
    {
        level.ob.drones = [];
    }
    
    level.ob.drones[ level.ob.drones.size ] = leaderdrone;
    
    /#
        leaderdrone thread ob_flying_drone::function_5fc6b44c9edd444a();
    #/
    
    if ( level.var_248484aa7e0c4178 )
    {
        thread function_658567df9da2275c( leaderdrone );
    }
    
    thread function_9d78f32e0efd5642();
}

// Namespace ob_activity_drone_hunt
// Params 1, eflags: 0xc
// Checksum 0x40b1eb22, Offset: 0x7c0
// Size: 0xc0
function private function_658567df9da2275c( leaderdrone )
{
    self notify( #"hash_74dab86a840a71bc" );
    self endon( #"hash_74dab86a840a71bc" );
    activity_instance = self;
    leaderdrone waittill( #"hash_c5b00d1f474077b8" );
    var_52225d70e4b5552b = {};
    var_52225d70e4b5552b.participants = activity_instance.playerparticipants;
    var_52225d70e4b5552b.startorigin = leaderdrone.origin;
    var_52225d70e4b5552b.startangles = leaderdrone.angles;
    var_194dbb2d345ed36b = activity_instance_common::createactivityinstance( "REV_OB_TARGET_ELIMINATION", "activity_target_elimination", var_52225d70e4b5552b.startorigin, var_52225d70e4b5552b );
    assert( var_194dbb2d345ed36b );
}

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0xfe3c9d08, Offset: 0x888
// Size: 0xc0
function private function_9d78f32e0efd5642()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        isactive = activity_instance_common::getactivitystate( self ) == "Active";
        var_2293ac0c3b458baa = self.drone && self.drone.origin;
        circleexist = self.questcircleconfig && self.questcircleconfig game_utility::questcircle_exists();
        
        if ( isactive && var_2293ac0c3b458baa && circleexist )
        {
            self.questcircleconfig game_utility::questcircle_move( self.drone.origin );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x33c198b6, Offset: 0x950
// Size: 0xf3
function function_ea8cc13e77d6c4d1()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        self.var_4531031c457be57b = utility::getstructarray( "harvesterorb_exclusion_area", "targetname" );
        
        if ( getdvarint( @"hash_ef7e4ad0ee928ae4", 1 ) )
        {
            foreach ( area in self.var_4531031c457be57b )
            {
                thread utility::draw_circle( area.origin, area.radius, ( 0, 0, 0 ), 1, 0, 300 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_drone_hunt
// Params 1
// Checksum 0x9dee58b9, Offset: 0xa4b
// Size: 0x34
function function_27a18c325b9b3bc2( params )
{
    thread calloutmarkerping::function_3c501da3379eca0a( params.player, params.pingindex, undefined, undefined, self.pingtimeout );
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x33d461a1, Offset: 0xa87
// Size: 0x4b
function get_difficulty_region_string()
{
    difficulty_region = undefined;
    
    if ( isdefined( level.var_bd706167fc97713c ) )
    {
        difficulty_region = [[ level.var_bd706167fc97713c ]]( activity_instance_common::function_776ee11e7acc64a5( self ) );
    }
    
    if ( !isdefined( difficulty_region ) || difficulty_region == "difficulty_undefined" )
    {
        return "difficulty_easy";
    }
    
    return difficulty_region;
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x28162e66, Offset: 0xadb
// Size: 0x17
function drone_hunt_activity_begin()
{
    thread function_626c84bb868d8100();
    thread function_710f0a9a49728d51();
    thread function_5cbb75887a45e42c();
}

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0x4
// Checksum 0x24855526, Offset: 0xafa
// Size: 0x53
function private function_626c84bb868d8100()
{
    drone = self.drone;
    drone endon( #"main_drone_destroyed" );
    drone utility::waittill_any_timeout( drone.var_4922a62c04b53c20, "engage_phase" );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcadronehuntreinforce" );
    thread ob_flying_drone::function_6395a1838cd983f5( drone );
}

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0xc
// Checksum 0x8a65b648, Offset: 0xb55
// Size: 0x8e
function private function_710f0a9a49728d51()
{
    self notify( #"hash_de96cd01898255a1" );
    self endon( #"hash_de96cd01898255a1" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( level.var_248484aa7e0c4178 )
    {
        self.drone waittill( #"hash_c5b00d1f474077b8" );
    }
    else
    {
        self.drone waittill( #"main_drone_destroyed" );
    }
    
    activity_player_broadcasting::function_cb4750c84882dd07( "scripted_success_splash" );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcadronehuntsuccess" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_drone_hunt
// Params 0, eflags: 0xc
// Checksum 0xf3f7e0b7, Offset: 0xbeb
// Size: 0x67
function private function_5cbb75887a45e42c()
{
    self notify( #"hash_3e5f18516b463591" );
    self endon( #"hash_3e5f18516b463591" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.playerparticipants.size <= 0 )
        {
            self.drone ob_flying_drone::function_50b8681675cdb7f6( 500 );
            activity_instance_common::endactivity( self, 0 );
            return;
        }
    }
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x55da574a, Offset: 0xc5a
// Size: 0x61
function function_cfb6aea44c7a6e15()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( self.drone && self.drone.origin )
    {
        centerpoint = self.drone.origin;
    }
    
    return centerpoint;
}

// Namespace ob_activity_drone_hunt
// Params 1, eflags: 0x4
// Checksum 0x3e71977, Offset: 0xcc4
// Size: 0x32
function private player_entered_awareness_zone( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcadronehuntbrief", player_list );
}

// Namespace ob_activity_drone_hunt
// Params 1, eflags: 0x4
// Checksum 0x6491ddfa, Offset: 0xcfe
// Size: 0x32
function private function_c7871b7129e9c0c8( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcadronehuntfail", player_list );
}

// Namespace ob_activity_drone_hunt
// Params 1
// Checksum 0x8a13120b, Offset: 0xd38
// Size: 0x43
function drone_hunt_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
}

// Namespace ob_activity_drone_hunt
// Params 1
// Checksum 0xeca4e1e3, Offset: 0xd83
// Size: 0xe9
function drone_hunt_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( self.drone.targetplayer && self.drone.targetplayer == player )
            {
                self.drone ob_flying_drone::function_c2373db857efa03( self.playerparticipants );
            }
            
            player notify( #"left_harvesterorb" );
        }
    }
}

// Namespace ob_activity_drone_hunt
// Params 1
// Checksum 0x2ab1dea3, Offset: 0xe74
// Size: 0x5a
function function_7b6a5d5efa2fd4d( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = getgroundposition( self.drone.origin, 100 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0xecaeee66, Offset: 0xed6
// Size: 0x2
function drone_hunt_activity_end()
{
    
}

// Namespace ob_activity_drone_hunt
// Params 0
// Checksum 0x579f4f3b, Offset: 0xee0
// Size: 0x12
function drone_hunt_activity_destroy()
{
    thread ob_flying_drone::entity_cleanup( self.drone );
}

