// scripts\mp\ob\activities\ob_activity_supply_drop.gsc  (hash_03d92a7d1d91c8e9.gscc) (size: 8759 Bytes / 0x2237 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6fa15b1 (2801407409)
// size ...... 8759 (0x2237)
// includes .. 22  (offset: 0x1feb)
// strings ... 30  (offset: 0x209b)
// dev strs .. 1   (offset: 0x222b)
// exports ... 23  (offset: 0x1303)
// cseg ...... 0x321 + 0xfe2 (0x1303)
// imports ... 82  (offset: 0x169b)
// animtree1 . 0   (offset: 0x2237)
// animtree2 . 0   (offset: 0x2237)
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_composite_utils;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_supply_drops;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\uav_tower;

#namespace ob_activity_supply_drop;

// Namespace ob_activity_supply_drop
// Params 0, eflags: 0x5
// Checksum 0xf8051bb1, Offset: 0x33f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_supply_drop", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x7394cf1c, Offset: 0x368
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_SUPPLY_DROP", &supply_drop_activity_type_init );
}

// Namespace ob_activity_supply_drop
// Params 0
// Checksum 0x1b7c2a11, Offset: 0x383
// Size: 0xbb
function supply_drop_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_DROP", 0, &activity_supply_drop_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_DROP", 3, &activity_supply_drop_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_SUPPLY_DROP", 2, &activity_supply_drop_end );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_SUPPLY_DROP" );
    level.towerusetime = getdvarfloat( @"scr_uav_tower_use_time", 5 );
    uav_tower::scriptmodelanims();
    utility::registersharedfunc( "ob_supply_drop_computer_station", #"hack", &function_33098cdba53c5f16 );
    utility::registersharedfunc( "ob_supply_drop_computer_station", #"start_hacking", &function_ad481f061d06b322 );
    scriptable::scriptable_addusedcallbackbypart( "supply_drop_computer_station_usable", &function_a5e5a8e5e605833 );
    thread function_1d7810a0393e4c99();
}

// Namespace ob_activity_supply_drop
// Params 1
// Checksum 0x6910a9, Offset: 0x446
// Size: 0x43
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
}

// Namespace ob_activity_supply_drop
// Params 0
// Checksum 0xe289b34, Offset: 0x491
// Size: 0x2bf
function activity_supply_drop_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    self.difficulty_tier = namespace_4a69edc3725e741::function_ee700758cb24d61f( self.varianttag );
    self.var_2020d87ab8c5f43 = self.var_91c91f4a631c481d.requireblackhat;
    supply_drop_options = spawnstruct();
    supply_drop_options.var_7ea9cd2acef9a15a = self.var_91c91f4a631c481d.var_14de30929d791f66;
    supply_drop_options.scriptkey = "activity_supply_drop";
    supply_drop_options.activity_instance = self;
    supply_drop_options.var_ef6f80c6b8c978b0 = &function_6a8629a1a322550;
    supply_drop_options.usetimeoverride = 6;
    supply_drop_options.drop_loot = "sat_ob_activity_supply_drops";
    self.supply_drop_options = supply_drop_options;
    computer_spawn_point = utility::getstruct( self.varianttag, "script_noteworthy" );
    origin = ob_activity_utility::function_fd8fc0e0d2300792( computer_spawn_point.origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( computer_spawn_point.angles );
    computer_station = spawnscriptable( "sat_ob_supply_drop_computer_station", origin, angles );
    self.computer_station = computer_station;
    self.computer_station interaction::set_interact_hint_callback( &function_ca23e17ef100653b );
    computer_station.activity_instance = self;
    var_6780714ae7fff864 = utility::getstructarray( computer_spawn_point.target, "targetname" );
    
    if ( var_6780714ae7fff864.size > 0 )
    {
        computer_station.supply_drop_loc = utility::array_random( var_6780714ae7fff864 );
    }
    
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( computer_station.supply_drop_loc.origin );
    self.computer_station.disabled = 1;
    self.computer_station setscriptablepartstate( #"objective", #"hide" );
    namespace_d6b7e33ec877018f::function_934ca6cc64ad906d();
    self.computer_station.disabled = 0;
    self.computer_station setscriptablepartstate( #"objective", #"show" );
    ob_activity_instance_common::function_9c6b2d04234d7b5e( self, self.computer_station );
    
    /#
    #/
    
    computer_station utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_supply_drop_computer_station" );
    self.computer_station setscriptablepartstate( #"supply_drop_computer_station_usable", #"usable" );
    setup_supply_drop_cover();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_supply_drop
// Params 0
// Checksum 0xd82c8a21, Offset: 0x758
// Size: 0x116
function activity_supply_drop_end()
{
    namespace_d6b7e33ec877018f::function_36bad4a225ab3edb();
    
    if ( self.computer_station )
    {
        self.computer_station setscriptablepartstate( #"supply_drop_computer_station_usable", #"unusable" );
    }
    
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( !activity_succeeded )
    {
        if ( self.supply_drop_plane )
        {
            function_6b04d28c8d639ddd( self.supply_drop_plane );
            self.supply_drop_plane setscriptablepartstate( "objective", "inactive", 0 );
            thread function_10b44ada12dd3ab7( self.supply_drop_plane );
        }
        
        if ( self.supply_drop_crates )
        {
            foreach ( crate in self.supply_drop_crates )
            {
                crate thread function_246396b3ffe0f5a9();
            }
        }
    }
}

// Namespace ob_activity_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x786ff183, Offset: 0x876
// Size: 0x145
function private function_1d7810a0393e4c99()
{
    utility::flag_wait( "airdrop_init_crate_data" );
    leveldata = airdrop::getleveldata( "sat_ob_activity_supply_drops" );
    leveldata.capturestring = &"sat_ob_activities/activity_supply_drop_capture";
    leveldata.basemodel = "sat_ava_storage_lootbox_01_fxanim_ob_supply_activity";
    leveldata.mountmantlemodel = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.headicon = undefined;
    leveldata.minimapicon = "ui_map_icon_jugg_drop";
    leveldata.usepriority = -1;
    leveldata.usefov = 180;
    leveldata.friendlyuseonly = 0;
    leveldata.ownerusetime = 2.5;
    leveldata.otherusetime = 2.5;
    leveldata.var_58f58ae1d854e3e4 = 1;
    leveldata.activatecallback = &ob_supply_drops::function_fb6c3479f030388c;
    leveldata.capturecallback = &ob_supply_drops::function_485a75456c8c1ba7;
    leveldata.destroycallback = &ob_supply_drops::function_ac7efea98467d107;
    leveldata.destroyoncapture = 0;
    leveldata.isdropcrate = 1;
    leveldata.nevertimeout = 1;
    leveldata.objectid = "override_locks";
}

// Namespace ob_activity_supply_drop
// Params 1, eflags: 0x4
// Checksum 0xce953e77, Offset: 0x9c3
// Size: 0x43
function private function_10b44ada12dd3ab7( plane )
{
    plane endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ob_supply_drop_crate_dropped", crate );
        crate thread function_246396b3ffe0f5a9();
    }
}

// Namespace ob_activity_supply_drop
// Params 0, eflags: 0xc
// Checksum 0xfc16513b, Offset: 0xa0e
// Size: 0xad
function private function_246396b3ffe0f5a9()
{
    self notify( #"hash_55dc19d10900e5e0" );
    self endon( #"hash_55dc19d10900e5e0" );
    self endon( #"death" );
    function_6b04d28c8d639ddd( self );
    self setscriptablepartstate( "ob_supply_drop", "usable_with_no_objective_and_ping" );
    
    if ( isdefined( self.smoke_signal_scriptable ) )
    {
        self.smoke_signal_scriptable setscriptablepartstate( #"smoke_signal", #"off", 0 );
        self.smoke_signal_scriptable freescriptable();
    }
    
    if ( !self.isusable )
    {
        self waittill( #"hash_32f4fd596d538aad" );
    }
    
    airdrop::deactivatecrate( 1 );
    airdrop::monitorimpactend();
    thread ob_supply_drops::function_ef1b5c1ce4991a7c( 180 );
}

// Namespace ob_activity_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x44cc303c, Offset: 0xac3
// Size: 0xe3
function private function_6b04d28c8d639ddd( scriptable )
{
    if ( scriptable.var_d26c6dba74c8a179 )
    {
        foreach ( player in scriptable.var_d26c6dba74c8a179 )
        {
            ping_id = scriptable.var_58cc57d664322d1d[ player getentitynumber() ];
            player.recordedpings[ ping_id ] = undefined;
            scriptable.var_58cc57d664322d1d[ player getentitynumber() ] = undefined;
            scriptable.var_d26c6dba74c8a179[ player getentitynumber() ] = undefined;
        }
    }
    
    scriptable calloutmarkerping::function_608710c894185549();
}

// Namespace ob_activity_supply_drop
// Params 0
// Checksum 0xb47b3fcf, Offset: 0xbae
// Size: 0x71
function activity_supply_drop_destroy()
{
    if ( isdefined( self.computer_station.anim_node ) )
    {
        self.computer_station.anim_node delete();
    }
    
    if ( self.computer_station )
    {
        self.computer_station freescriptable();
    }
    
    if ( self.scriptable_covers.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.scriptable_covers );
    }
    
    ob_activity_utility::ob_disable_cover_nodes();
}

// Namespace ob_activity_supply_drop
// Params 2
// Checksum 0x103b7b9a, Offset: 0xc27
// Size: 0x9e
function function_33098cdba53c5f16( hack_effect, attacker )
{
    self.activity_instance notify( #"terminal_activated", "by_black_hat" );
    utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
    thread do_supply_drop( attacker );
    self setscriptablepartstate( #"supply_drop_computer_station_usable", #"unusable" );
    thread spawn_guards( self.activity_instance, self.supply_drop_loc.origin, self.supply_drop_loc.radius );
}

// Namespace ob_activity_supply_drop
// Params 6
// Checksum 0xfbc3e669, Offset: 0xccd
// Size: 0x43
function function_a5e5a8e5e605833( instance, part, state, player, bautouse, usestring )
{
    instance thread function_c81c163bc4541024( player );
}

// Namespace ob_activity_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x727c6029, Offset: 0xd18
// Size: 0x12c
function private function_c81c163bc4541024( player )
{
    if ( self.var_1674515c4a4c0655.size || self.disabled )
    {
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        self.activity_instance notify( #"terminal_activated", "by_black_hat" );
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        thread do_supply_drop( player );
        self setscriptablepartstate( #"supply_drop_computer_station_usable", #"unusable" );
        thread spawn_guards( self.activity_instance, self.supply_drop_loc.origin, self.supply_drop_loc.radius );
        level callback::callback( #"hash_91f2a0e70afebfe1", { #activity_instance:self.activity_instance, #interactionevent:#"hash_b083169c6da221d9", #player:player } );
    }
}

// Namespace ob_activity_supply_drop
// Params 1
// Checksum 0xcaaa94d1, Offset: 0xe4c
// Size: 0x9a
function function_ad481f061d06b322( params )
{
    player = params.hacker;
    black_hat_data = params.black_hat_data;
    assert( isdefined( player ) && isdefined( black_hat_data ) );
    player endon( #"death_or_disconnect" );
    computer_station = self;
    
    while ( black_hat_data.state == "hacking" )
    {
        wait 0.2;
    }
    
    if ( isdefined( black_hat_data.var_aa778d21f7d75252 ) )
    {
        black_hat_data.var_aa778d21f7d75252 = 0;
    }
}

// Namespace ob_activity_supply_drop
// Params 2
// Checksum 0x424344ad, Offset: 0xeee
// Size: 0xd7
function function_ca23e17ef100653b( usable, player )
{
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/interaction_hacking_in_progress", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    if ( usable.disabled )
    {
        return { #string:&"sat_ob_activities/activity_supply_drop_disabled", #type:"HINT_NOBUTTON" };
    }
    
    return { #string:&"sat_ob_activities/activity_supply_drop_call", #type:"HINT_NOICON" };
}

// Namespace ob_activity_supply_drop
// Params 1
// Checksum 0x2a3d075e, Offset: 0xfcd
// Size: 0xeb
function do_supply_drop( player )
{
    self endon( #"death" );
    self.activity_instance.var_a4350e73a4097c74 = 1;
    squad = player squad_utility::getsquadmembers( undefined, 0 );
    self.activity_instance ob_activity_utility::function_894ac80e038636c5( "wcasupplydropbrief", squad );
    
    if ( isdefined( self.supply_drop_loc ) )
    {
        valid_pos = self.supply_drop_loc.origin;
    }
    else
    {
        valid_pos = getclosestpointonnavmesh( self.origin + vectornormalize( anglestoforward( self.angles ) ) * -350 );
    }
    
    self.activity_instance notify( #"start_supply_drop" );
    thread ob_supply_drops::function_989989bf968b8c87( valid_pos, undefined, 1, self.activity_instance.supply_drop_options, self.activity_instance, squad );
}

// Namespace ob_activity_supply_drop
// Params 1
// Checksum 0xc2d1c35, Offset: 0x10c0
// Size: 0x85
function function_6a8629a1a322550( player )
{
    activity_instance = self.crate_options.activity_instance;
    activity_participation::function_bc67362dace4370c( activity_instance, player, "PlayerJoinedInteract" );
    namespace_9085ae059032a84f::updateprogress( 1, activity_instance );
    
    if ( self.cradle_leak )
    {
        activity_instance ob_activity_utility::function_894ac80e038636c5( "wcasupplydropcradle", [ player ] );
        wait 3;
    }
    
    wait 1;
    activity_instance thread ob_activity_utility::function_894ac80e038636c5( "wcasupplydropsuccess" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace ob_activity_supply_drop
// Params 3
// Checksum 0x522cd641, Offset: 0x114d
// Size: 0x41
function spawn_guards( activityinstance, origin, radius = 5000 )
{
    activityinstance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_supply_drop_guards", origin, radius, 1, 1, 1, 2 );
}

// Namespace ob_activity_supply_drop
// Params 0
// Checksum 0xb8dac2b8, Offset: 0x1196
// Size: 0x94
function setup_supply_drop_cover()
{
    self endon( #"activity_ended" );
    
    if ( isdefined( self.varianttag ) && isdefined( self.computer_station.supply_drop_loc.script_noteworthy ) )
    {
        var_edd0cb6e9ee724e9 = "supply_drop_cover_" + self.varianttag + "_" + self.computer_station.supply_drop_loc.script_noteworthy;
        self.scriptable_covers = ob_soldier_util::function_a315cc5d1dee425a( var_edd0cb6e9ee724e9 );
        waitframe();
        ob_activity_utility::ob_enable_cover_nodes();
    }
}

/#

    // Namespace ob_activity_supply_drop
    // Params 0
    // Checksum 0x7264e3b1, Offset: 0x1232
    // Size: 0x4c, Type: dev
    function function_4f26a430a459c9c1()
    {
        self endon( #"interact_finished" );
        
        if ( getdvarint( @"hash_88139d8050929519", 0 ) != 12345678 )
        {
            return;
        }
        
        wait level.towerusetime * 0.6;
        setdvar( @"hash_f2ad6e3c99187b3d", "<dev string:x24>" );
    }

    // Namespace ob_activity_supply_drop
    // Params 2
    // Checksum 0xbe4f3965, Offset: 0x1286
    // Size: 0x7d, Type: dev
    function function_85416d5e40ce3dbb( original_origin, hack_node_origin_offset )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            sphere( original_origin + ( 0, 0, 35 ), 5, ( 1, 0, 1 ), 0, level.frameduration );
            sphere( original_origin + hack_node_origin_offset, 5, ( 0, 0, 1 ), 0, level.frameduration );
            waitframe();
        }
    }

#/
