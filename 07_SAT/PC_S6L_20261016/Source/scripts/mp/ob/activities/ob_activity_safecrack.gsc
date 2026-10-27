// scripts\mp\ob\activities\ob_activity_safecrack.gsc  (hash_229094c8c4e888ed.gscc) (size: 17197 Bytes / 0x432d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79f26cd1 (2045930705)
// size ...... 17197 (0x432d)
// includes .. 23  (offset: 0x3fa1)
// strings ... 38  (offset: 0x4059)
// dev strs .. 18  (offset: 0x4255)
// exports ... 45  (offset: 0x2849)
// cseg ...... 0x3a3 + 0x24a6 (0x2849)
// imports ... 136 (offset: 0x2f51)
// animtree1 . 0   (offset: 0x432d)
// animtree2 . 0   (offset: 0x432d)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\entity;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_safecrack;

// Namespace ob_activity_safecrack
// Params 0, eflags: 0x5
// Checksum 0x3b9ca06b, Offset: 0x3c1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_safecrack", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_safecrack
// Params 0, eflags: 0x4
// Checksum 0xc4cdbf92, Offset: 0x3ea
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_SAFECRACK", &safecrack_activity_type_init );
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x50d70a12, Offset: 0x405
// Size: 0x136
function safecrack_activity_type_init()
{
    level.var_63a7c842afe0c9c3 = spawnstruct();
    level.var_63a7c842afe0c9c3.revealradius = getdvarint( @"hash_de0487f3e5f484a3", 24000 );
    level.var_63a7c842afe0c9c3.enabledefenders = getdvarint( @"hash_d69ece7d8e88eaad", 1 );
    level.var_63a7c842afe0c9c3.revealradiussq = squared( level.var_63a7c842afe0c9c3.revealradius );
    
    /#
        level thread function_15c3b0e05cedcd17();
        level thread function_76b1a0e0fd10330f();
    #/
    
    activity_common::function_944074f3079c1d4e( "REV_OB_SAFECRACK", 0, &safecrack_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SAFECRACK", 1, &safecrack_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_SAFECRACK", 2, &safecrack_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_SAFECRACK", 3, &safecrack_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_e0f00b697069364a, "REV_OB_SAFECRACK" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_daa35cb39708004f, "REV_OB_SAFECRACK" );
    utility::registersharedfunc( "ob_safe", #"hack", &function_c04c6601349868d3 );
    scriptable::scriptable_addusedcallbackbypart( "safecrack_body", &function_379c55ca02f6afc7 );
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0xcb4a006f, Offset: 0x543
// Size: 0x3b
function function_daa35cb39708004f( relevant_info_struct )
{
    if ( isdefined( self ) && self.state != "Ended" )
    {
        ob_activity_utility::function_894ac80e038636c5( "wcasafefail", relevant_info_struct.playerlist );
    }
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x184cac6a, Offset: 0x586
// Size: 0x650
function safecrack_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_837a0c8626c9b419();
    self.var_8a5f3e13cb58e019 = activity_definition_utils::function_9129cd8075c85c09( self );
    self.capture_radius = self.var_8a5f3e13cb58e019.captureradius ?? 800;
    self.var_c81a917552049716 = self.var_8a5f3e13cb58e019.attractradius ?? 2048;
    self.var_260c21764f5eeb65 = self.var_8a5f3e13cb58e019.var_28ac127dce8c6d85 ?? 1;
    self.var_a4c086caa1cbfd68 = self.var_8a5f3e13cb58e019.encounter ?? "jup_ob_safecrack_encounter";
    self.capture_height = self.var_8a5f3e13cb58e019.captureheight ?? 256;
    var_1be24234bf288e29 = utility::getstruct( self.varianttag, "target" );
    assert( isdefined( var_1be24234bf288e29 ), "<dev string:x24>" + self.varianttag );
    self.origin = var_1be24234bf288e29.origin;
    self.angles = var_1be24234bf288e29.angles;
    self.script_poi = var_1be24234bf288e29.script_poi;
    self.var_546e4eb5269dbafa = region_difficulty_manager::get_region_difficulty( self.origin );
    
    switch ( self.var_546e4eb5269dbafa )
    {
        default:
            self.var_546e4eb5269dbafa = "difficulty_easy";
        case #"hash_7bb2cd766703d463":
            self.var_fadb2dc0da30d15b = self.var_8a5f3e13cb58e019.var_872ac21eea2eea99.capturetime ?? 90;
            self.lootlist_bundle = self.var_8a5f3e13cb58e019.var_872ac21eea2eea99.lootlist ?? "wc_sat_items_activity_safecrack";
            self.success_score_event = #"ob_minor_activity_complete_green";
            break;
        case #"hash_af83e47edfa8900a":
            self.var_fadb2dc0da30d15b = self.var_8a5f3e13cb58e019.var_af20af95bacaf226.capturetime ?? 90;
            self.lootlist_bundle = self.var_8a5f3e13cb58e019.var_af20af95bacaf226.lootlist ?? "wc_sat_items_activity_safecrack";
            self.success_score_event = #"ob_minor_activity_complete_yellow";
            break;
        case #"hash_5343b465e56ec9a4":
            self.var_fadb2dc0da30d15b = self.var_8a5f3e13cb58e019.var_64cef80d60717670.capturetime ?? 90;
            self.lootlist_bundle = self.var_8a5f3e13cb58e019.var_64cef80d60717670.lootlist ?? "wc_sat_items_activity_safecrack";
            self.success_score_event = #"ob_minor_activity_complete_orange";
            break;
        case #"hash_651f76c0ad6741ec":
        case #"hash_c0250ffc2e87f2ff":
            self.var_fadb2dc0da30d15b = self.var_8a5f3e13cb58e019.var_5286f38ae823e769.capturetime ?? 90;
            self.lootlist_bundle = self.var_8a5f3e13cb58e019.var_5286f38ae823e769.lootlist ?? "wc_sat_items_activity_safecrack";
            self.success_score_event = #"ob_minor_activity_complete_red";
            break;
    }
    
    self.capture_radius = getdvarint( hashcat( @"hash_f72308758abea239", self.varianttag ), self.capture_radius );
    self.capture_height = getdvarint( hashcat( @"hash_6ebbafbfeb721c26", self.varianttag ), self.capture_height );
    self.var_c81a917552049716 = getdvarint( hashcat( @"hash_c4827b6b41a3159e", self.varianttag ), self.var_c81a917552049716 );
    self.var_260c21764f5eeb65 = getdvarint( hashcat( @"hash_406af6bb3dff6667", self.varianttag ), self.var_260c21764f5eeb65 );
    self.var_fadb2dc0da30d15b = getdvarint( hashcat( @"hash_4795d743464e3550", self.varianttag ), self.var_fadb2dc0da30d15b );
    self.lootlist_bundle = getdvar( hashcat( @"hash_66f7a80db137f8e9", self.varianttag ), self.lootlist_bundle );
    self.var_a4c086caa1cbfd68 = getdvar( hashcat( @"hash_1c069aa79535cca4", self.varianttag ), self.var_a4c086caa1cbfd68 );
    self.var_fadb2dc0da30d15b = float( self.var_fadb2dc0da30d15b );
    self.capture_radius_sq = squared( self.capture_radius );
    self.attract_radius_sq = squared( self.var_c81a917552049716 );
    self.var_d92ef581fc6402d = getdvarint( @"hash_538068dd04d11f04", 12 );
    safe = function_dbf9fc6567a8e762( "ob_safecrack_safe_hackable", self.origin, self.angles );
    safe setscriptablepartstate( #"safecrack_body", #"usable_not_open" );
    safe_origin_offset = anglestoforward( safe.angles ) * 20 + ( 0, 0, 30 );
    safe utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_safe" );
    self.safe = safe;
    self notify( #"safe_spawned" );
    function_f6ddcade348cfca9();
    
    if ( !isdefined( level.safes ) )
    {
        level.safes = [];
    }
    
    level.safes[ level.safes.size ] = self.safe;
    var_e3149b5f4f3301c7 = getnoentvolumearray( self.varianttag, "targetname" )[ 0 ];
    
    if ( isdefined( var_e3149b5f4f3301c7 ) )
    {
        thread function_2fa369b54be73334( var_e3149b5f4f3301c7 );
    }
    
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
    self.safe waittill( #"safe_unlocking" );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0xd7348670, Offset: 0xbde
// Size: 0x99
function function_2fa369b54be73334( notice_trigger )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.safe endon( #"safe_unlocking" );
    var_c04533e67204c2c0 = [];
    
    while ( true )
    {
        notice_trigger waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( arraycontains( var_c04533e67204c2c0, ent ) )
        {
            continue;
        }
        
        ob_activity_utility::function_894ac80e038636c5( "wcasafebrief", [ ent ] );
        var_c04533e67204c2c0[ var_c04533e67204c2c0.size ] = ent;
    }
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0xf737afc1, Offset: 0xc7f
// Size: 0x45
function safecrack_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.safe waittill( #"safe_unlocked" );
    ob_activity_utility::function_894ac80e038636c5( "wcasafesuccess" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0x3cd54b93, Offset: 0xccc
// Size: 0x4b
function safecrack_activity_end( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    
    if ( !self.safe.unlocked )
    {
        self.safe setscriptablepartstate( #"safecrack_body", "waiting" );
    }
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x75ccde02, Offset: 0xd1f
// Size: 0x1c
function safecrack_activity_destroy()
{
    self.safe freescriptable();
    self endon( #"instance_destroyed" );
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0x5d71aace, Offset: 0xd43
// Size: 0xc
function function_e0f00b697069364a( relevant_info_struct )
{
    
}

// Namespace ob_activity_safecrack
// Params 4
// Checksum 0xed9420bf, Offset: 0xd57
// Size: 0x27
function function_c17622fe3216c0a4( safe, part, state, player )
{
    
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x6aa0b055, Offset: 0xd86
// Size: 0x9f
function function_f6ddcade348cfca9()
{
    var_1be24234bf288e29 = utility::getstruct( self.varianttag, "target" );
    
    if ( !isdefined( var_1be24234bf288e29.var_e05fe85000437d0c ) || int( var_1be24234bf288e29.var_e05fe85000437d0c ) == 0 )
    {
        return;
    }
    
    enc_targetname = "guard_enc_" + self.varianttag;
    self.var_24346738f0fdf761 = activity_ai_encounters::function_92b671064b0b1ce2( enc_targetname, 1, 0, 1, 2 );
    
    if ( isdefined( self.var_24346738f0fdf761 ) )
    {
        function_1a9d724a960fa19d( self.var_24346738f0fdf761, self.var_546e4eb5269dbafa, 1 );
    }
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x6f831f17, Offset: 0xe2d
// Size: 0x8f
function function_c4364df61c0f1d60()
{
    activity_instance = self.activity;
    self.agents = [];
    encounterid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag, 1, 0, 1, 2 );
    
    if ( isdefined( encounterid ) )
    {
        function_1a9d724a960fa19d( encounterid, self.activity.var_546e4eb5269dbafa, 1 );
        ai_spawn_director::function_ee0b7976619e1cb8( encounterid, &function_385e0606ab5605e4, [ self ] );
        ai_spawn_director::function_5c8b22954b3bfa37( encounterid, &function_c4aeb6aca62ed73, [ self ] );
    }
}

// Namespace ob_activity_safecrack
// Params 4
// Checksum 0x90d5b9d9, Offset: 0xec4
// Size: 0x71
function function_385e0606ab5605e4( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    safe = userdata[ 0 ];
    
    if ( isalive( agent ) )
    {
        safe.agents[ safe.agents.size ] = agent;
        agent function_fee664c56442c995( safe );
    }
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0x78344b0e, Offset: 0xf3d
// Size: 0x105
function function_fee664c56442c995( safe )
{
    self endon( #"death" );
    availableplayers = [];
    
    foreach ( _player in safe.var_6a16d65744e61715 )
    {
        if ( isplayer( _player ) && isalive( _player ) )
        {
            availableplayers[ availableplayers.size ] = _player;
        }
    }
    
    if ( availableplayers.size > 0 )
    {
        random_safe_cracker = utility::array_random( availableplayers );
        self getenemyinfo( random_safe_cracker );
        self.favoriteenemy = random_safe_cracker;
        self forcethreatupdate();
    }
    
    waitframe();
    thread ai_behavior::behavior_combatRushOrigin( self, safe.origin, 128, 256 );
    thread function_3c2fe0e228e18e5( 8192 );
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0xe9f38357, Offset: 0x104a
// Size: 0xce
function function_3c2fe0e228e18e5( validtargetdist )
{
    self endon( #"death" );
    self notify( #"hash_f6a8ce3d44c98a7c" );
    self endon( #"hash_f6a8ce3d44c98a7c" );
    
    if ( !isdefined( validtargetdist ) )
    {
        validtargetdist = 1024;
    }
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( self.combatrushing )
        {
            thread ai_behavior::function_b72d8af48880734d( validtargetdist, self.scriptgoalpos );
            self.combatrushing = 0;
            self notify( #"hash_7078c4bdb4d4c709" );
            
            /#
                if ( getdvarint( @"hash_ed4743622c486038", 0 ) )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x9d>", ( 1, 1, 1 ), 1, 2, 300, 1 );
                }
            #/
        }
    }
}

// Namespace ob_activity_safecrack
// Params 3
// Checksum 0x4102f7a8, Offset: 0x1120
// Size: 0x75, Type: bool
function function_c4aeb6aca62ed73( requestid, userdata, wavenumber )
{
    safe = userdata[ 0 ];
    
    if ( safe.progress_percentage >= 0.25 )
    {
        ai_spawn_director::function_baa5d26d8804d5da( requestid, &function_385e0606ab5605e4, [ safe ] );
        safe.activity thread ob_activity_utility::function_894ac80e038636c5( "wcasafereinforce", undefined, undefined, 10 );
        return true;
    }
    
    return false;
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0xa5ca0c17, Offset: 0x119e
// Size: 0x1f
function function_b20b278b5e936d97()
{
    if ( level.var_63a7c842afe0c9c3.enabledefenders )
    {
        thread function_c4364df61c0f1d60();
    }
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x6d9639dd, Offset: 0x11c5
// Size: 0x2
function function_b81d9aee00d8f643()
{
    
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0x5d7c926d, Offset: 0x11cf
// Size: 0x174
function function_33a340601c8fcbf4()
{
    agents = entity::function_cd55d7a649cb9c44( self.origin, self.activity.var_c81a917552049716, "team_hundred_ninety" );
    var_386ca8f5974e4ce = [];
    
    foreach ( agent in agents )
    {
        if ( !isplayer( agent ) )
        {
            var_386ca8f5974e4ce[ var_386ca8f5974e4ce.size ] = agent;
        }
    }
    
    agents = var_386ca8f5974e4ce;
    
    foreach ( agent in agents )
    {
        agent thread ai_behavior::behavior_combatRushOrigin( agent, self.origin, 128, 64, undefined, 1, agents, 0 );
        agent utility::ent_flag_init( "activity_safe_attracted" );
    }
    
    if ( !isdefined( self.agents ) )
    {
        self.agents = [];
    }
    
    self.agents = arraycombineunique( self.agents, agents );
}

// Namespace ob_activity_safecrack
// Params 2
// Checksum 0x3a0614af, Offset: 0x134b
// Size: 0xb4, Type: bool
function function_6223ed24fb2ea728( attractor, zombie )
{
    safe = attractor.source.safe;
    
    if ( zombie.aicategory == "normal" && distance( zombie.origin, safe.origin ) > safe.activity.capture_radius / 2 )
    {
        if ( zombie.team == "team_two_hundred" )
        {
            safe.agents[ safe.agents.size ] = zombie;
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0x9460de3e, Offset: 0x1408
// Size: 0xc
function function_22a6f0af3ffd8010( params )
{
    
}

// Namespace ob_activity_safecrack
// Params 2
// Checksum 0x77d341e8, Offset: 0x141c
// Size: 0x47
function function_c04c6601349868d3( hack_effect, attacker )
{
    if ( isdefined( attacker ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        self.activity thread function_c999ec35984b9893( self, attacker );
    }
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0x894c828f, Offset: 0x146b
// Size: 0xd1
function function_beb844fa8f8659ba( player )
{
    wait 4;
    player thread hud_message::showsplash( "safecrack_revealed", undefined, undefined, undefined, 1, "splash_list_jup_ob" );
    
    foreach ( safe in level.safes )
    {
        if ( distance2dsquared( safe.origin, player.origin ) <= level.var_63a7c842afe0c9c3.revealradiussq )
        {
            function_4df03c4205ddd701( safe );
        }
    }
}

// Namespace ob_activity_safecrack
// Params 1
// Checksum 0xc161d263, Offset: 0x1544
// Size: 0x25
function function_4df03c4205ddd701( safe )
{
    safe setscriptablepartstate( #"icon", #"shown" );
}

// Namespace ob_activity_safecrack
// Params 3, eflags: 0x4
// Checksum 0x7661ba6f, Offset: 0x1571
// Size: 0x83
function private function_dbf9fc6567a8e762( safe_scriptable, origin, angles )
{
    origin = ob_activity_utility::function_fd8fc0e0d2300792( origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( angles );
    safe = spawnscriptable( safe_scriptable, origin, angles );
    safe setscriptablepartstate( #"safecrack_body", "usable_not_open" );
    safe setscriptablepartstate( #"icon", #"shown" );
    safe.activity = self;
    return safe;
}

// Namespace ob_activity_safecrack
// Params 1, eflags: 0x4
// Checksum 0xde1a1f6e, Offset: 0x15fd
// Size: 0xb6
function private init_safe_objective_marker( safe )
{
    safe.obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_safecrack_marker", 0, 0 );
    objidpoolmanager::update_objective_state( self.safe.obj_id, "active" );
    objidpoolmanager::update_objective_position( safe.obj_id, safe.origin + ( 0, 0, 60 ) );
    objidpoolmanager::function_eb808b97701a4793( safe.obj_id );
    objidpoolmanager::function_daf59ee8ea2cb071( safe.obj_id );
    objective_sethideelevation( safe.obj_id, 0 );
    function_461834c350793158( safe.obj_id, 1 );
}

// Namespace ob_activity_safecrack
// Params 2
// Checksum 0x6a13e395, Offset: 0x16bb
// Size: 0x17e
function function_c999ec35984b9893( safe, player )
{
    if ( safe.cracking_started )
    {
        return;
    }
    
    safe.cracking_started = 1;
    safe.trigger = spawn( "noent_volume_trigger_radius", safe.origin, 0, self.capture_radius, self.capture_height );
    safe thread function_9c4ad71e4713d397();
    var_e3149b5f4f3301c7 = getnoentvolumearray( self.varianttag, "targetname" )[ 0 ];
    
    foreach ( p in level.players )
    {
        if ( ispointinvolume( p.origin, var_e3149b5f4f3301c7 ) )
        {
            activity_participation::function_bc67362dace4370c( self, p, p == player ? "PlayerJoinedInteract" : "PlayerJoinedProximity" );
        }
    }
    
    ob_activity_utility::function_894ac80e038636c5( "wcasafealarm" );
    safe function_b20b278b5e936d97();
    safe setscriptablepartstate( #"safecrack_body", "unusable_intro_drilling" );
    safe notify( #"safe_unlocking" );
    safe thread function_91fb77db771b0afd( self.var_fadb2dc0da30d15b );
    thread safe_alarm();
}

// Namespace ob_activity_safecrack
// Params 0
// Checksum 0xfb13d632, Offset: 0x1841
// Size: 0x95
function safe_alarm()
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    alarm_alias = "sat_ob_activity_stronghold_alarm";
    awareness_zone_origin = self.safe.origin;
    alarm_origin = ( awareness_zone_origin[ 0 ], awareness_zone_origin[ 1 ], awareness_zone_origin[ 2 ] + 200 );
    var_4a7e50a07112c158 = max( level.framedurationseconds, lookupsoundlength( alarm_alias ) / 1000 );
    
    while ( true )
    {
        playsoundatpos( alarm_origin, alarm_alias );
        wait var_4a7e50a07112c158;
    }
}

// Namespace ob_activity_safecrack
// Params 1, eflags: 0x4
// Checksum 0xfdf84caa, Offset: 0x18de
// Size: 0x159
function private function_91fb77db771b0afd( var_4fb00ccb3d299051 )
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.activity endon( #"activity_ended" );
    self.activity endon( #"instance_destroyed" );
    self.progress_percentage = 0;
    var_d3de89249989197c = 0;
    var_d256703a2ee0cbce = [];
    activity_definition_utils::updateprogress( 0, self.activity, 100 );
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( self.var_6a16d65744e61715.size > 0 )
            {
                var_d3de89249989197c = min( var_4fb00ccb3d299051, var_d3de89249989197c + level.framedurationseconds );
            }
            else if ( self.activity.var_260c21764f5eeb65 && var_d3de89249989197c > 0 )
            {
                var_d3de89249989197c = max( 0, var_d3de89249989197c - level.framedurationseconds * 0.5 );
            }
            
            self.progress_percentage = var_d3de89249989197c / var_4fb00ccb3d299051;
            activity_definition_utils::updateprogress( int( self.progress_percentage * 100 ), self.activity );
            
            if ( self.progress_percentage >= 1 )
            {
                thread unlock_safe();
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_safecrack
// Params 0, eflags: 0x4
// Checksum 0x84320662, Offset: 0x1a3f
// Size: 0x110
function private unlock_safe()
{
    if ( !self.unlocked )
    {
        self.unlocked = 1;
    }
    
    self setscriptablepartstate( #"safecrack_body", "opening" );
    self setscriptablepartstate( #"icon", #"hidden" );
    calloutmarkerping::function_608710c894185549();
    function_b81d9aee00d8f643();
    self.trigger delete();
    self notify( #"safe_unlocked" );
    sparams = spawnstruct();
    sparams.safe = self;
    
    foreach ( player in self.var_6a16d65744e61715 )
    {
        player callback::callback( "safe_opened_nearby", sparams );
    }
    
    function_7bb9d6a4e74170ac();
}

// Namespace ob_activity_safecrack
// Params 0, eflags: 0x4
// Checksum 0xf211e488, Offset: 0x1b57
// Size: 0xb8
function private function_9c4ad71e4713d397()
{
    level endon( #"game_ended" );
    self endon( #"safe_unlocked" );
    self.activity endon( #"instance_destroyed" );
    self.var_6a16d65744e61715 = [];
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.var_6a16d65744e61715, player ) )
        {
            continue;
        }
        
        activity_participation::function_bc67362dace4370c( self.activity, player, "PlayerJoinedProximity" );
        self.var_6a16d65744e61715[ self.var_6a16d65744e61715.size ] = player;
        childthread function_9392a51a8014544e( player );
    }
}

// Namespace ob_activity_safecrack
// Params 1, eflags: 0x4
// Checksum 0x8d54df2d, Offset: 0x1c17
// Size: 0x57
function private function_9392a51a8014544e( player )
{
    while ( isdefined( self.trigger ) && isalive( player ) && player istouching( self.trigger ) )
    {
        wait 0.2;
    }
    
    self.var_6a16d65744e61715 = arrayremove( self.var_6a16d65744e61715, player );
}

// Namespace ob_activity_safecrack
// Params 0, eflags: 0x4
// Checksum 0xcdfe3ae6, Offset: 0x1c76
// Size: 0x71
function private function_7bb9d6a4e74170ac()
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin + ( 0, 0, 60 ) );
    spawnoptions.spawnpositionindex = 5;
    items = common_item::function_38cde6a6acb68ea6( self.activity.lootlist_bundle, self.activity.var_d92ef581fc6402d, spawnoptions );
}

// Namespace ob_activity_safecrack
// Params 6, eflags: 0x4
// Checksum 0x900dce91, Offset: 0x1cef
// Size: 0x82
function private function_379c55ca02f6afc7( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.activity )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    if ( player isgestureplaying() )
    {
        return;
    }
    
    instance thread function_8ded8703c4d4048c( player );
}

// Namespace ob_activity_safecrack
// Params 1, eflags: 0x4
// Checksum 0xbb9a1beb, Offset: 0x1d79
// Size: 0xc8
function private function_8ded8703c4d4048c( player )
{
    player endon( #"disconnect" );
    
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    if ( !isdefined( self.noticed_player ) )
    {
        self.noticed_player = [];
    }
    
    if ( !arraycontains( self.noticed_player, player ) )
    {
        self.activity ob_activity_utility::function_894ac80e038636c5( "wcasafetry", [ player ] );
        self.noticed_player[ self.noticed_player.size ] = player;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        function_c04c6601349868d3( undefined, player );
    }
}

/#

    // Namespace ob_activity_safecrack
    // Params 0, eflags: 0x4
    // Checksum 0x3a3ae60e, Offset: 0x1e49
    // Size: 0xd5, Type: dev
    function private function_15c3b0e05cedcd17()
    {
        devgui::function_9082edeb5db93280( "<dev string:xb1>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xce>", @"scr_safes_reveal" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xdc>", @"hash_4f2cd88d61f31a05" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xe7>", @"hash_7bba049efb029baa" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xf5>", @"hash_3ec6799528b8c3a3" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x10b>", @"hash_e80ff5758ab695aa" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x11d>", @"hash_ecc9f2ec79830d8" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x128>", @"hash_3cf803c8fb8e7b16" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x13f>", @"hash_95bcb70ae8cbe4cf" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x157>", @"hash_1902f346336c9d19" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_safecrack
    // Params 0, eflags: 0x4
    // Checksum 0xb5da436c, Offset: 0x1f26
    // Size: 0x767, Type: dev
    function private function_76b1a0e0fd10330f()
    {
        timer = 0;
        drawframeduration = 10;
        
        while ( true )
        {
            if ( !( isdefined( level.safes ) && isdefined( level.players ) ) )
            {
                wait 5;
                continue;
            }
            
            if ( getdvarint( @"scr_safes_reveal", 0 ) )
            {
                setdvar( @"scr_safes_reveal", 0 );
                
                foreach ( player in level.players )
                {
                    thread function_beb844fa8f8659ba( player );
                }
            }
            
            if ( getdvarint( @"hash_4f2cd88d61f31a05", 0 ) )
            {
                setdvar( @"hash_4f2cd88d61f31a05", 0 );
                
                foreach ( safe in level.safes )
                {
                    function_4df03c4205ddd701( safe );
                }
            }
            
            if ( getdvarint( @"hash_7bba049efb029baa", 0 ) )
            {
                foreach ( safe in level.safes )
                {
                    function_7913f71c4b798102( safe, drawframeduration );
                    function_3847f8d4f20c04f( safe, drawframeduration );
                    function_b9daea4484ced277( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_3ec6799528b8c3a3", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_7913f71c4b798102( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_e80ff5758ab695aa", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_3847f8d4f20c04f( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_ecc9f2ec79830d8", 0 ) && timer == 0 )
            {
                foreach ( safe in level.safes )
                {
                    function_b9daea4484ced277( safe, drawframeduration );
                }
            }
            
            if ( getdvarint( @"hash_3cf803c8fb8e7b16", 0 ) )
            {
                setdvar( @"hash_3cf803c8fb8e7b16", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( !isdefined( safe.progress_percentage ) )
                        {
                            safe function_bce8bd380a53046( player );
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x16f>" );
                }
            }
            
            if ( getdvarint( @"hash_95bcb70ae8cbe4cf", 0 ) )
            {
                setdvar( @"hash_95bcb70ae8cbe4cf", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( isdefined( safe.progress_percentage ) && !safe.unlocked )
                        {
                            safe function_e8bf1dc5561b43cd();
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x1b6>" );
                }
            }
            
            if ( getdvarint( @"hash_1902f346336c9d19", 0 ) )
            {
                setdvar( @"hash_1902f346336c9d19", 0 );
                var_d95cd5cf93852980 = 0;
                
                foreach ( player in level.players )
                {
                    var_f387f39cdc09099a = sortbydistance( level.safes, player.origin );
                    
                    foreach ( safe in var_f387f39cdc09099a )
                    {
                        if ( safe.unlocked )
                        {
                            safe function_569ec4ae1c552be9();
                            var_d95cd5cf93852980 = 1;
                            break;
                        }
                    }
                }
                
                if ( !var_d95cd5cf93852980 )
                {
                    iprintln( "<dev string:x1fb>" );
                }
            }
            
            waitframe();
            timer++;
            
            if ( timer >= drawframeduration )
            {
                timer = 0;
            }
        }
    }

    // Namespace ob_activity_safecrack
    // Params 2
    // Checksum 0x12a64e75, Offset: 0x2695
    // Size: 0x53, Type: dev
    function function_7913f71c4b798102( safe, drawframeduration )
    {
        line( safe.origin, safe.origin + ( 0, 0, 3000 ), ( 1, 0, 1 ), 1, 0, drawframeduration );
    }

    // Namespace ob_activity_safecrack
    // Params 2
    // Checksum 0xbf51bd1e, Offset: 0x26f0
    // Size: 0x4a, Type: dev
    function function_3847f8d4f20c04f( safe, drawframeduration )
    {
        orientedbox( safe scriptablegetmidpoint(), 2 * function_decb653c5689e4ca( "<dev string:x24a>" ), safe.angles, ( 1, 1, 1 ), 0, drawframeduration );
    }

    // Namespace ob_activity_safecrack
    // Params 2
    // Checksum 0x311ebd8b, Offset: 0x2742
    // Size: 0x82, Type: dev
    function function_b9daea4484ced277( safe, drawframeduration )
    {
        sphere( safe.origin, safe.activity.capture_radius, ( 0, 1, 0 ), 0, drawframeduration );
        sphere( safe.origin, safe.activity.var_c81a917552049716, ( 1, 1, 0 ), 0, drawframeduration );
    }

    // Namespace ob_activity_safecrack
    // Params 1
    // Checksum 0x301739b1, Offset: 0x27cc
    // Size: 0x24, Type: dev
    function function_bce8bd380a53046( player )
    {
        level thread function_c17622fe3216c0a4( self, "<dev string:x27d>", "<dev string:x282>", player );
    }

    // Namespace ob_activity_safecrack
    // Params 0
    // Checksum 0xfa03b7ee, Offset: 0x27f8
    // Size: 0x13, Type: dev
    function function_e8bf1dc5561b43cd()
    {
        self.progress_percentage = 1;
    }

    // Namespace ob_activity_safecrack
    // Params 0
    // Checksum 0x3861cbe5, Offset: 0x2813
    // Size: 0x36, Type: dev
    function function_569ec4ae1c552be9()
    {
        self.contents = [];
        self.weaponslotcontents = undefined;
        common_cache::fillcontentsfromlist( self, self.activity.lootlist_bundle, 5 );
    }

#/
