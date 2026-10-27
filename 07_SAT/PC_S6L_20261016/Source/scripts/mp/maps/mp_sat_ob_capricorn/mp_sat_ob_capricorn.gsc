// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn.gsc  (hash_1a8652eb26d9f1b1.gscc) (size: 8818 Bytes / 0x2272 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80d91e37 (2161712695)
// size ...... 8818 (0x2272)
// includes .. 19  (offset: 0x1e62)
// strings ... 40  (offset: 0x1efa)
// dev strs .. 31  (offset: 0x20fa)
// exports ... 22  (offset: 0x12ae)
// cseg ...... 0x3db + 0xed3 (0x12ae)
// imports ... 68  (offset: 0x161e)
// animtree1 . 0   (offset: 0x2272)
// animtree2 . 0   (offset: 0x2272)
#using script_16ea1b94f0f381b3;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\compass;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_starts;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\overlord;

#namespace mp_sat_ob_capricorn;

// Namespace mp_sat_ob_capricorn
// Params 0
// Checksum 0xba3f64bb, Offset: 0x3f9
// Size: 0x27a
function main()
{
    level.is_quest_story_mission = 1;
    capricorn_audio::main();
    load::main();
    set_minimap( "restricted_area" );
    level._effect[ "capricorn_boat_lights" ] = loadfxasset( "vfx_sat_ob_capricorn_patrol_boat_lights" );
    level._effect[ "vfx_sat_core_weapons_muz_ar" ] = loadfxasset( "vfx_sat_core_weapons_muz_ar" );
    level._effect[ "vfx_sat_core_weapons_muz_sm" ] = loadfxasset( "vfx_sat_core_weapons_muz_sm" );
    level._effect[ "vfx_sat_core_weapons_muz_sn" ] = loadfxasset( "vfx_sat_core_weapons_muz_sn" );
    level._effect[ "vfx_sat_core_weapons_muz_ar" ] = loadfxasset( "vfx_sat_core_weapons_muz_ar" );
    level._effect[ "vfx_sat_core_weapons_muz_la_stisaac" ] = loadfxasset( "vfx_sat_core_weapons_muz_la_stisaac" );
    level._effect[ "vfx_sat_ob_capricorn_turret_destroy" ] = loadfxasset( "vfx_sat_ob_capricorn_turret_destroy" );
    level.var_5a7959a6b7acf7fd = 1;
    register_region_difficulties();
    setdvarifuninitialized( @"hash_ca08f59b64628422", "sat_capricorn_outro" );
    level overlord::function_ddcc4b96977bcf4a( [ "ob/overlord_ob.csv", "ob/overlord_ob_capricorn.csv" ] );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.var_409cf34875e21eb5 = 0.5;
    level.var_75d8bf80bd40a615 = 175;
    level.var_6dd339a918cc7198 = 64;
    level.var_5ac924e35a6a476 = 0.3;
    level.var_3d9fc7aa7b25b565 = spawnstruct();
    level.var_3d9fc7aa7b25b565.stealthy_hijack = 0;
    utility::registersharedfunc( #"gametype", #"onplayerentervehicle", &function_3385d47d2aba9417 );
    utility::registersharedfunc( #"gametype", #"hash_b64530c1428fda8", &function_e953c5deb1ba19e8 );
    utility::registersharedfunc( #"ai", #"get_aitype_default_spawn_team_SharedFunc", &function_4d67f4920eab933d );
    level thread ob::function_26fd7480f329bfda( [ "sat_usa_pl_cyan", "sat_chn_pl_gold", "sat_zaf_pl_peach", "sat_usa_pl_orange" ] );
    setdvarifuninitialized( @"hash_ea04b56bf0ddb214", 0 );
    
    if ( getdvarint( @"hash_6a18e4fcb76092c6" ) )
    {
        /#
            level.onplayerconnect = &function_2113903fa2678482;
        #/
        
        return;
    }
    
    init_capricorn_activities();
}

// Namespace mp_sat_ob_capricorn
// Params 2, eflags: 0x4
// Checksum 0xd726a7ee, Offset: 0x67b
// Size: 0x39
function private function_3385d47d2aba9417( vehicle, player )
{
    if ( isdefined( vehicle ) )
    {
        vehicle notify( #"player_enter", player );
        player notify( #"player_enter", vehicle );
    }
}

// Namespace mp_sat_ob_capricorn
// Params 0
// Checksum 0xf8beb596, Offset: 0x6bc
// Size: 0x11
function function_c89c8c8e27d1c8ec()
{
    setdvar( @"hash_1d03444cd52cc348", 0 );
}

// Namespace mp_sat_ob_capricorn
// Params 1, eflags: 0x4
// Checksum 0x1082ee, Offset: 0x6d5
// Size: 0x18
function private function_e953c5deb1ba19e8( player )
{
    player setsoundsubmix( "mp_sat_ob_capricorn_default" );
}

// Namespace mp_sat_ob_capricorn
// Params 0, eflags: 0x4
// Checksum 0x86be603c, Offset: 0x6f5
// Size: 0x25
function private register_region_difficulties()
{
    if ( level.var_bb86f77304f193c4.regiondifficultyenabled )
    {
        level callback::callback( "region_difficulties_registered" );
    }
}

// Namespace mp_sat_ob_capricorn
// Params 0, eflags: 0x4
// Checksum 0xa6dd0c3e, Offset: 0x722
// Size: 0x26
function private init_capricorn_activities()
{
    callback::add( #"player_spawned", &function_6dc804f1c45d763d );
    ob_capricorn_startpoint::init_capricorn_activities();
    level thread ob_gametype_story_mission::function_a535ecaaab8427b7();
}

// Namespace mp_sat_ob_capricorn
// Params 1, eflags: 0x4
// Checksum 0x3b02c768, Offset: 0x750
// Size: 0x3f
function private function_6dc804f1c45d763d( params )
{
    params.player clearsoundsubmix( "mp_sat_ob_capricorn_emp_explode", 0 );
    params.player ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_defaultsuit_ob_no_skydiving", 1 );
}

// Namespace mp_sat_ob_capricorn
// Params 1
// Checksum 0x9164320b, Offset: 0x797
// Size: 0x3e
function set_minimap( zone_name )
{
    volume = getnoentvolumearray( "minimap_volume_" + zone_name, "targetname" )[ 0 ];
    compass::setupminimap( "compass_map_mp_sat_ob_capricorn_" + zone_name, undefined, undefined, volume );
}

// Namespace mp_sat_ob_capricorn
// Params 3
// Checksum 0x968ca218, Offset: 0x7dd
// Size: 0x3a
function function_776ea74dd9e92d46( waitflag, structtargetname, var_1288e7582a6bdb5 = undefined )
{
    level utility::flag_wait( waitflag );
    cancel_waypoint_objective_handler( structtargetname, var_1288e7582a6bdb5 );
}

// Namespace mp_sat_ob_capricorn
// Params 2
// Checksum 0x381b1198, Offset: 0x81f
// Size: 0x27
function cancel_waypoint_objective_handler( structtargetname, var_1288e7582a6bdb5 = undefined )
{
    waypoint_objective_handler::waypoint_objective_handler_cancel( structtargetname, var_1288e7582a6bdb5 );
}

// Namespace mp_sat_ob_capricorn
// Params 0
// Checksum 0x37012cb5, Offset: 0x84e
// Size: 0x7
function function_4d67f4920eab933d()
{
    return "team_hundred_ninety";
}

// Namespace mp_sat_ob_capricorn
// Params 3
// Checksum 0x8d1112e5, Offset: 0x85e
// Size: 0x147
function spawn_turret_drone( activityinstance, var_a7e3f21b2148116e, droneoptions )
{
    if ( getdvarint( @"hash_8d15b5b3f90ff719", 0 ) == 1 )
    {
        return;
    }
    
    var_b3daf67a5a5ba863 = utility::getstructarray( var_a7e3f21b2148116e, "targetname" );
    
    if ( !activityinstance.var_41f9287c4987add7 )
    {
        activityinstance.var_41f9287c4987add7 = [];
    }
    
    if ( !activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ] )
    {
        activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ] = {};
    }
    
    spawneddrones = [];
    
    foreach ( node in var_b3daf67a5a5ba863 )
    {
        drone = ob_flying_drone::spawn_helper_drone( node.script_noteworthy, level.players[ 0 ], undefined, node, droneoptions );
        spawneddrones[ spawneddrones.size ] = drone;
    }
    
    activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ].spawneddrones = spawneddrones;
}

// Namespace mp_sat_ob_capricorn
// Params 2
// Checksum 0xb1a7ebd1, Offset: 0x9ad
// Size: 0x5d
function function_36a2524eb4edf91a( activityinstance, encounter_name )
{
    level waittill( #"hash_a90894fda4feb874" );
    encounterid = activityinstance activity_ai_encounters::function_306a1676777f93e2( encounter_name );
    
    if ( activityinstance.var_9c4a0b2cae577c1b[ encounterid ] )
    {
        activityinstance activity_ai_encounters::function_46dadc3aca2ffac0( encounterid, 0 );
    }
    
    despawn_turret_drone( activityinstance, encounter_name );
}

// Namespace mp_sat_ob_capricorn
// Params 2
// Checksum 0xa17d782e, Offset: 0xa12
// Size: 0xf5
function despawn_turret_drone( activityinstance, var_a7e3f21b2148116e )
{
    if ( !activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ].spawneddrones )
    {
        return;
    }
    
    spawneddrones = activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ].spawneddrones;
    
    if ( spawneddrones.size > 0 )
    {
        foreach ( drone in spawneddrones )
        {
            if ( drone && isalive( drone ) )
            {
                drone delete();
            }
        }
    }
    
    activityinstance.var_41f9287c4987add7[ var_a7e3f21b2148116e ].spawneddrones = [];
}

// Namespace mp_sat_ob_capricorn
// Params 1
// Checksum 0x2e36d0cf, Offset: 0xb0f
// Size: 0x16c
function function_d1e2187515b5099f( targetname )
{
    level utility::flag_wait( "scriptables_ready" );
    force_fields = getentarray( targetname, #targetname );
    
    foreach ( ff in force_fields )
    {
        ff.targetscriptables = getscriptablearray( ff.target, #targetname );
        
        if ( isdefined( ff.targetscriptables ) )
        {
            foreach ( scriptable in ff.targetscriptables )
            {
                if ( scriptable.script_noteworthy == "power_supply" )
                {
                    scriptable setscriptablepartstate( "force_field_power_supply", "destroyed" );
                }
            }
        }
        
        ff mp_sat_ob_libra_util::force_field_setup();
    }
}

// Namespace mp_sat_ob_capricorn
// Params 0
// Checksum 0x5a5522d, Offset: 0xc83
// Size: 0xae
function function_4fb7fff71f7b9c03()
{
    allstreamed = 0;
    
    while ( !allstreamed )
    {
        allstreamed = 1;
        
        foreach ( player in level.players )
        {
            if ( player utility::ent_flag( "player_additional_stream_pos_waiting" ) )
            {
                allstreamed = 0;
                break;
            }
        }
        
        if ( allstreamed )
        {
            break;
        }
        
        wait 0.25;
    }
}

/#

    // Namespace mp_sat_ob_capricorn
    // Params 1, eflags: 0x4
    // Checksum 0xeed174f3, Offset: 0xd39
    // Size: 0x39, Type: dev
    function private function_2113903fa2678482( player )
    {
        player utility::ent_flag_wait( "<dev string:x24>" );
        thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 0 );
        adddebugcommand( "<dev string:x35>" );
        thread function_a354f2ba6890269();
    }

    // Namespace mp_sat_ob_capricorn
    // Params 0, eflags: 0x4
    // Checksum 0xfa3ac587, Offset: 0xd7a
    // Size: 0x168, Type: dev
    function private function_a354f2ba6890269()
    {
        var_ca9cbc82281c6790 = utility::getstruct( "<dev string:x3a>" );
        forge_crash_scene_struct = utility::getstruct( "<dev string:x54>" );
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x70>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x76>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x7a>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x7f>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x84>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x91>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:x9e>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:xab>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:xb8>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:xc5>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:xd2>" );
        forge_crash_scene_struct scene::add_spawn_function( &fire_custom, "<dev string:xe0>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_70c49851c8525226" ) )
            {
                var_ca9cbc82281c6790 thread scene::pre_stream_play( 2 );
                wait 90;
                var_ca9cbc82281c6790 scene::stop();
            }
            
            if ( getdvarint( @"hash_d86f226668944013" ) )
            {
                forge_crash_scene_struct scene::pre_stream_play( 2 );
            }
        }
    }

    // Namespace mp_sat_ob_capricorn
    // Params 0
    // Checksum 0xfb324572, Offset: 0xeea
    // Size: 0xb4, Type: dev
    function fire_custom()
    {
        self endon( #"death" );
        tag = "<dev string:xee>";
        
        while ( true )
        {
            self waittill( #"fire" );
            linked_ents = self getlinkedchildren();
            
            if ( isdefined( linked_ents[ 0 ] ) )
            {
                gun = linked_ents[ 0 ];
                data = gun function_7ca48b456a70eda7();
                start = gun gettagorigin( tag );
                playfxontag( data.muzzle_fx, gun, tag );
                
                if ( soundexists( data.var_7049eff624cd105a ) )
                {
                    playsoundatpos( start, data.var_7049eff624cd105a );
                }
            }
        }
    }

    // Namespace mp_sat_ob_capricorn
    // Params 0
    // Checksum 0x643609e8, Offset: 0xfa6
    // Size: 0x186, Type: dev
    function function_7ca48b456a70eda7()
    {
        if ( isdefined( self.model ) )
        {
            if ( issubstr( self.model, "<dev string:xf8>" ) )
            {
                data = spawnstruct();
                data.muzzle_fx = utility::getfx( "<dev string:xfe>" );
                data.var_7049eff624cd105a = "<dev string:x11a>";
                return data;
            }
            
            if ( issubstr( self.model, "<dev string:x12c>" ) )
            {
                data = spawnstruct();
                data.muzzle_fx = utility::getfx( "<dev string:x132>" );
                data.var_7049eff624cd105a = "<dev string:x14e>";
                return data;
            }
            
            if ( issubstr( self.model, "<dev string:x164>" ) )
            {
                data = spawnstruct();
                data.muzzle_fx = utility::getfx( "<dev string:x16a>" );
                data.var_7049eff624cd105a = "<dev string:x186>";
                return data;
            }
            
            if ( issubstr( self.model, "<dev string:x19c>" ) )
            {
                data = spawnstruct();
                data.muzzle_fx = utility::getfx( "<dev string:xfe>" );
                data.var_7049eff624cd105a = "<dev string:x1a3>";
                return data;
            }
            
            if ( issubstr( self.model, "<dev string:x1ba>" ) )
            {
                data = spawnstruct();
                data.muzzle_fx = utility::getfx( "<dev string:x1bf>" );
                data.var_7049eff624cd105a = "<dev string:x1e3>";
                return data;
            }
        }
    }

#/

// Namespace mp_sat_ob_capricorn
// Params 2
// Checksum 0x2a82d8b9, Offset: 0x1134
// Size: 0x17a
function encounter_create_squad( encounter_targetname, suffix = "01" )
{
    if ( !getdvarint( @"hash_66175c5ff0964741", 1 ) )
    {
        return 0;
    }
    
    requestid = ai_spawn_director::lookup_spawn_request( encounter_targetname );
    
    while ( true )
    {
        data = ai_spawn_director::get_encounter_data( requestid );
        
        if ( data.ai.size == data.var_f05db2e05804484d )
        {
            enemies = data.ai;
            break;
        }
        
        waitframe();
    }
    
    tether_ai = [];
    
    foreach ( enemy in enemies )
    {
        if ( enemy.script_noteworthy == "anchor_" + suffix )
        {
            anchor_ai = enemy;
        }
        
        if ( enemy.script_noteworthy == "tether_" + suffix )
        {
            tether_ai[ tether_ai.size ] = enemy;
        }
    }
    
    if ( !isdefined( anchor_ai ) || !tether_ai.size )
    {
        return 0;
    }
    
    while ( !isdefined( anchor_ai.enemy ) )
    {
        waitframe();
    }
    
    ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
}

