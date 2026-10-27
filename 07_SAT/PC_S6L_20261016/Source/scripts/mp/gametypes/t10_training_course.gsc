// scripts\mp\gametypes\t10_training_course.gsc  (hash_0eaf05a0beebb7d4.gscc) (size: 113264 Bytes / 0x1ba70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x960289fd (2516748797)
// size ...... 113264 (0x1ba70)
// includes .. 43  (offset: 0x1a6a8)
// strings ... 249 (offset: 0x1a800)
// dev strs .. 40  (offset: 0x1b878)
// exports ... 289 (offset: 0x121cc)
// cseg ...... 0x17c0 + 0x10a0c (0x121cc)
// imports ... 638 (offset: 0x14ef4)
// animtree1 . 0   (offset: 0x1ba70)
// animtree2 . 0   (offset: 0x1ba70)
#using script_16ea1b94f0f381b3;
#using script_18c2f6d91cbc576a;
#using script_3cb3908b3094b567;
#using script_4f7cbc7a2a2ba890;
#using script_6bfbb3133de71bd5;
#using scripts\anim\battlechatter;
#using scripts\anim\dialogue;
#using scripts\common\ae_utility;
#using scripts\common\ai_lookat;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common_training_course;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_dialogue;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace t10_training_course;

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x480d9705, Offset: 0x17de
// Size: 0x5b4
function private function_4ec8216adb4330fc()
{
    return [ [ [ "wildcard_target" ], 2, ( -31489, -57882, 410 ), ( 0, -145, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -31121, -57755, 410 ), ( 0, -175, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -32204, -57542, 373 ), ( 0, -21, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -31975, -57912, 444 ), ( 0, -10, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -31973, -57492, 440 ), ( 0, -17, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -31836, -57218, 426 ), ( 0, -108, 0 ), 1 ], [ [ "wildcard_target" ], 2, ( -31148, -57202, 696 ), ( 0, -108, 0 ), 1 ], [ [ "hip_fire_target" ], 1, ( -31625, -57175, 368 ), ( 0, -15, 0 ), 1 ], [ [ "hip_fire_target" ], 1, ( -31518, -57296, 368 ), ( 0, 0, 0 ), 1 ], [ [ "hip_fire_target" ], 1, ( -31435, -57132, 368 ), ( 0, -40, 0 ), 1 ], [ [ "ads_fire_target", "wildcard_target" ], 1, ( -31727, -58059, 278 ), ( 0, 70, 0 ), 1 ], [ [ "ads_fire_target", "wildcard_target" ], 1, ( -31916, -58127, 274 ), ( 0, 35, 0 ), 1 ], [ [ "ads_fire_target", "wildcard_target" ], 1, ( -31574, -58067, 277 ), ( 0, 115, 0 ), 1 ], [ [ "grenade_target" ], 1, ( -31987, -56501, 273 ), ( 0, -105, 0 ), 0 ], [ [ "grenade_target" ], 1, ( -32061, -56422, 271 ), ( 0, -105, 0 ), 0 ], [ [ "grenade_target", "tactical_target" ], 1, ( -32038, -56543, 275 ), ( 0, -105, 0 ), 0 ], [ [ "killstreak_target" ], 1, ( -32071, -55382, 112 ), ( 0, -100, 0 ), 0 ], [ [ "omnisprint_target" ], 1, ( -30924, -54859, 431 ), ( 0, -105, 0 ), 0 ], [ [ "omnisprint_target" ], 1, ( -31036, -54825, 431 ), ( 0, -105, 0 ), 0 ], [ [ "omnisprint_target" ], 1, ( -31156, -54796, 431 ), ( 0, -105, 0 ), 0 ], [ [ "omnisprint_target" ], 1, ( -31034, -54656, 431 ), ( 0, -105, 0 ), 0 ], [ [ "omnisprint_target" ], 1, ( -30912, -54687, 431 ), ( 0, -105, 0 ), 0 ] ];
}

// Namespace t10_training_course
// Params 0
// Checksum 0xcbc14296, Offset: 0x1d9b
// Size: 0xd0b
function trainingcourse_init()
{
    /#
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) == 1 )
        {
            setdevdvar( @"scr_devchangetimelimit", 0 );
        }
    #/
    
    setdvar( @"scr_game_matchstarttime", 0 );
    out_of_bounds_time = 2;
    setdvar( @"scr_outofboundstime", out_of_bounds_time );
    level.outofboundstime = out_of_bounds_time;
    setdvar( @"scr_game_forceuav", 1 );
    setdvar( @"hash_7bdf6d033065ef17", 0 );
    setdvarifuninitialized( @"hash_5bb18d4eb7794e87", 1 );
    setdvarifuninitialized( @"hash_a8d60dcb66f59524", 0 );
    setdvarifuninitialized( @"hash_82feb18c2130951a", 1 );
    setdvarifuninitialized( @"hash_fb237c32ec4de2b9", 1 );
    setdvarifuninitialized( @"hash_49befb9786f9fda", 1 );
    setdvarifuninitialized( @"hash_8e70563bddaf0da", 1 );
    setdvarifuninitialized( @"hash_49ee092bdec92e4e", 1 );
    setdvarifuninitialized( @"hash_8d82e300c99f95b0", 1 );
    setdvarifuninitialized( @"hash_a414be2abcef64ba", 1 );
    level._effect[ "vfx_muzzle_flash" ] = loadfxasset( "vfx_t10_core_weapons_muz_ar_able18" );
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.modespawnclient = &onplayerrespawn;
    level.endgame = &function_9cc26a2c4cf82d07;
    level.var_5cda5e5f3aa0d6cb = &getwinningteam;
    callback::add( #"hash_57a74c8771bf7e7", &function_5e1ae482077473ff );
    level.var_c03063b5f4fc2dde = [];
    level.var_2e61ab2b37d9ba6f = [];
    level.world_target_array = [];
    level.bot_pool = [];
    level.var_e104d2f44c811043 = 0;
    level.var_f5062c36d13e920c = 1;
    
    /#
        setdvar( @"scr_disable_forfeit", 1 );
    #/
    
    utility::registersharedfunc( #"killstreak", #"hash_d8307e54206525a9", &rcxd_begin );
    utility::registersharedfunc( #"killstreak", #"rcxdendfunc", &rcxd_end );
    utility::registersharedfunc( #"killstreak", #"hash_d3cd9f41839cace8", &function_8998b7ea159335f3 );
    utility::registersharedfunc( #"support_box", #"supportboxused", &supportbox_used );
    utility::registersharedfunc( #"support_box", #"supportboxdeleted", &supportbox_deleted );
    callback::add( #"reload_start", &function_aa4c8736e7957afd );
    
    if ( getdvarint( @"hash_49befb9786f9fda" ) )
    {
        level thread cp01_tent_a_centered_cs::main();
    }
    
    level.var_714c7ea0347def6a = [];
    level.var_67361f68db6dcf34 = [];
    intro_world_event = [];
    intro_world_event[ "instance_1" ] = "Intro_cinematic";
    intro_world_event[ "instance_2" ] = "Intro_cinematic_02";
    intro_world_event[ "instance_3" ] = "Intro_cinematic_03";
    intro_world_event[ "instance_4" ] = "Intro_cinematic_04";
    intro_world_event[ "instance_5" ] = "Intro_cinematic_05";
    intro_world_event[ "instance_6" ] = "Intro_cinematic_06";
    intro_world_event[ "instance_7" ] = "Intro_cinematic_07";
    intro_world_event[ "instance_8" ] = "Intro_cinematic_08";
    intro_world_event[ "instance_9" ] = "Intro_cinematic_09";
    outro_world_event = [];
    outro_world_event[ "instance_1" ] = "Outro_cinematic";
    outro_world_event[ "instance_2" ] = "Outro_cinematic_02";
    outro_world_event[ "instance_3" ] = "Outro_cinematic_03";
    outro_world_event[ "instance_4" ] = "Outro_cinematic_04";
    outro_world_event[ "instance_5" ] = "Outro_cinematic_05";
    outro_world_event[ "instance_6" ] = "Outro_cinematic_06";
    outro_world_event[ "instance_7" ] = "Outro_cinematic_07";
    outro_world_event[ "instance_8" ] = "Outro_cinematic_08";
    outro_world_event[ "instance_9" ] = "Outro_cinematic_09";
    var_afb33f4119b4b3fa = 0;
    var_975b946eeefcaa34 = [];
    
    do
    {
        instance_array = utility::getent_or_struct_array( "instance_" + var_afb33f4119b4b3fa + 1, "script_noteworthy" );
        
        if ( instance_array.size == 0 )
        {
            break;
        }
        
        var_975b946eeefcaa34[ var_975b946eeefcaa34.size ] = instance_array;
        var_afb33f4119b4b3fa++;
    }
    while ( instance_array.size > 0 );
    
    for ( i = 0; i < var_975b946eeefcaa34.size ; i++ )
    {
        instance_array = var_975b946eeefcaa34[ i ];
        var_d664bae99cba4e14 = [];
        
        foreach ( ent in instance_array )
        {
            if ( isdefined( ent.targetname ) && ent.targetname.size > 0 )
            {
                var_d664bae99cba4e14[ ent.targetname ] = ent;
            }
        }
        
        level.var_714c7ea0347def6a[ level.var_714c7ea0347def6a.size ] = var_d664bae99cba4e14;
    }
    
    foreach ( ent_map in level.var_714c7ea0347def6a )
    {
        scene_struct_array = [];
        intro_struct = ent_map[ "training_course_scene_intro" ];
        outro_struct = ent_map[ "training_course_scene_outro" ];
        var_52a695d87aec927c = ent_map[ "training_course_scene_idle" ];
        intro_struct.world_event_name = intro_world_event[ intro_struct.script_noteworthy ];
        intro_struct.var_ddb502ad28f6362d = 1;
        outro_struct.world_event_name = outro_world_event[ outro_struct.script_noteworthy ];
        outro_struct.var_ddb502ad28f6362d = 1;
        var_52a695d87aec927c.var_ddb502ad28f6362d = 1;
        scene_struct_array[ scene_struct_array.size ] = intro_struct;
        scene_struct_array[ scene_struct_array.size ] = outro_struct;
        scene_struct_array[ scene_struct_array.size ] = var_52a695d87aec927c;
        ent_map[ "scene_struct_array" ] = scene_struct_array;
    }
    
    if ( level.var_714c7ea0347def6a.size == 0 )
    {
        level.var_714c7ea0347def6a[ 0 ][ "instance_offset" ] = { #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        scene_struct = { #angles:( 0, -121.329, 0 ), #origin:( -30482.1, -57256.3, 266.972 ) };
        level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_intro" ] = scene_struct;
        level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_outro" ] = structcopy( scene_struct, 1 );
        level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_idle" ] = structcopy( scene_struct, 1 );
        level.var_714c7ea0347def6a[ 0 ][ "scene_struct_array" ] = [ level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_intro" ], level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_outro" ], level.var_714c7ea0347def6a[ 0 ][ "training_course_scene_idle" ] ];
        var_afb33f4119b4b3fa = 1;
    }
    
    world_targets = function_4ec8216adb4330fc();
    
    for ( i = 0; i < var_afb33f4119b4b3fa ; i++ )
    {
        function_5bda2610dad9e6e9( "180_dive", i, ( -30999.2, -54440.5, 508.575 ), ( 0, 166, 0 ), ( 1166, 968, 460 ), ( 702, 64, 100 ) );
        function_5bda2610dad9e6e9( "180_dive", i, ( -30956.8, -55164.4, 431.052 ), ( 0, 76, 0 ), ( 1288, 378, 332 ), ( 68, 1266, 186 ) );
        function_5bda2610dad9e6e9( "180_dive", i, ( -30452.5, -55173.6, 431.358 ), ( 0, 166, 0 ), ( 704, 642, 32 ), ( 306, 980, 150 ) );
        function_5bda2610dad9e6e9( "slide_or_dive", i, ( -31127.5, -56743.3, 457.933 ), ( 0, 335.999, 0 ), ( 1130, 1060, 192 ), ( 830, 90, 158 ) );
        function_5bda2610dad9e6e9( "slide_or_dive", i, ( -30753.3, -56198.8, 621.805 ), ( 0, 153.999, 0 ), ( 132, 148, 42 ), ( 848, 60, 154 ) );
        function_5bda2610dad9e6e9( "slide_or_dive", i, ( -31445.9, -56268.5, 482.158 ), ( 0, 333.999, 0 ), ( 804, 504, 362 ), ( 32, 440, 74 ) );
        function_5bda2610dad9e6e9( "slide_or_dive", i, ( -30624.1, -56528.3, 461.843 ), ( 0, 63.9981, 0 ), ( 470, 548, 196 ), ( 334, 88, 146 ) );
        function_5bda2610dad9e6e9( "slide_or_dive", i, ( -30861.7, -56720.8, 461.482 ), ( 0, 291.999, 0 ), ( 32, 108, 32 ), ( 232, 148, 138 ) );
        function_5bda2610dad9e6e9( "meatshield", i, ( -30873.3, -53757.9, 440 ), ( 0, 0, 0 ), ( 1028, 1030, 404 ), ( 164, 1368, 166 ) );
        function_5bda2610dad9e6e9( "meatshield", i, ( -30288.7, -54181.6, 432.507 ), ( 0, 74, 0 ), ( 1686, 1226, 168 ), ( 94, 748, 192 ) );
        function_5bda2610dad9e6e9( "meatshield", i, ( -29985, -53306.5, 240.018 ), ( 0, 256, 0 ), ( 1116, 1924, 248 ), ( 254, 952, 424 ) );
        function_5bda2610dad9e6e9( "meatshield", i, ( -30736.2, -53972.5, 471.119 ), ( 0, 0, 0 ), ( 232, 172, 32 ), ( 300, 182, 104 ) );
        function_5bda2610dad9e6e9( "supine", i, ( -31339.1, -55314, 144.8 ), ( 0, 166, 0 ), ( 554, 256, 32 ), ( 32, 298, 84 ) );
        function_5bda2610dad9e6e9( "supine", i, ( -32059.5, -54803.7, 179.672 ), ( 30, 256, 0 ), ( 300, 92, 32 ), ( 32, 92, 80 ) );
        function_5bda2610dad9e6e9( "supine", i, ( -31868, -55434.1, 138.96 ), ( 0, 82, 0 ), ( 438, 388, 96 ), ( 32, 568, 148 ) );
        function_b2c44c2beeec92ac( world_targets, i );
        level.var_67361f68db6dcf34[ i ] = 0;
    }
    
    if ( getdvarint( @"hash_a963f82cc98375e8", 1 ) == 1 )
    {
        level.var_5bbfdd7562b793 = &training_afkcheck;
    }
    
    /#
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) )
        {
            thread function_db8250f88b742582( [ [ ( -30899, -55101, 112 ), ( -31284, -55262, 112 ), 1, 5, 200 ], [ ( -31645, -56029, 608 ), ( -31754, -55972, 608 ), 3, 5, 150 ], [ ( -32079, -55781, 127 ), ( -32168, -55542, 112 ), 3, 5, 150 ], [ ( -31166, -55005, 431 ), ( -31398, -55253, 434 ), 2, 5, 150 ], [ ( -31430, -54762, 288 ), ( -31465, -54953, 288 ), 3, 5, 150 ], [ ( -31984, -54705, 249 ), ( -32050, -54823, 162 ), 1, 5, 300 ] ] );
            
            if ( isdefined( level.world_target_array ) && level.world_target_array.size > 0 )
            {
                thread function_7464143c7de6c610( level.world_target_array[ 0 ] );
            }
        }
    #/
    
    battlechatter::init_battlechatter();
    mp_dialogue::main();
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x8378820, Offset: 0x2aae
// Size: 0x18, Type: bool
function private function_f0999c39797a8308()
{
    return isbrgamemode() || getdvarint( @"hash_83b81973446a1575", 0 );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x8c9ba09b, Offset: 0x2acf
// Size: 0x39
function private function_52ff81cfdbb3f234( original_origin, original_angles, map_instance_index )
{
    return [ function_d58310d0f1d16d43( original_origin, map_instance_index ), function_2e52e3ebd7fff7bd( original_angles, map_instance_index ) ];
}

// Namespace t10_training_course
// Params 2
// Checksum 0xf48ad22e, Offset: 0x2b11
// Size: 0x5b
function function_d58310d0f1d16d43( original_origin, map_instance_index )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( isdefined( instance_map ) )
    {
        offset_struct = instance_map[ "instance_offset" ];
        
        if ( isdefined( offset_struct ) )
        {
            return ( original_origin + offset_struct.origin );
        }
    }
    
    return original_origin;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x2a7b841d, Offset: 0x2b75
// Size: 0x64
function private function_2e52e3ebd7fff7bd( original_angles, map_instance_index )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( isdefined( instance_map ) )
    {
        offset_struct = instance_map[ "instance_offset" ];
        
        if ( isdefined( offset_struct.angles ) )
        {
            return ( original_angles + offset_struct.angles );
        }
    }
    
    return original_angles;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x355f951f, Offset: 0x2be2
// Size: 0x19
function private function_7b785364ecb1775c( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_intro" );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf400e074, Offset: 0x2c04
// Size: 0x19
function private function_d18dd74017e9db87( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_outro" );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x36ed8c41, Offset: 0x2c26
// Size: 0x19
function private function_acd7b230b1df93c1( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_idle" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x977205bd, Offset: 0x2c48
// Size: 0x38
function private function_dc97518781842988( map_instance_index, struct_targetname )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( isdefined( instance_map ) )
    {
        return instance_map[ struct_targetname ];
    }
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0xff0408de, Offset: 0x2c89
// Size: 0xb0
function private function_753a55cf69adc665()
{
    order_array = [];
    
    if ( getdvarint( @"hash_fb237c32ec4de2b9" ) )
    {
        order_array[ order_array.size ] = 5;
        order_array[ order_array.size ] = 6;
    }
    
    if ( getdvarint( @"hash_49ee092bdec92e4e" ) )
    {
        order_array[ order_array.size ] = 0;
    }
    
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        order_array[ order_array.size ] = 2;
    }
    
    order_array[ order_array.size ] = 3;
    
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        order_array[ order_array.size ] = 1;
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        order_array[ order_array.size ] = 4;
    }
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        order_array[ order_array.size ] = 7;
    }
    
    return order_array;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x9df17ec4, Offset: 0x2d42
// Size: 0x71
function private function_6427cfa4077010bd( cinematic_root_struct, map_instance_index )
{
    if ( isdefined( cinematic_root_struct.world_event_name ) )
    {
        activateworldevent( cinematic_root_struct.world_event_name, 1 );
    }
    
    if ( isdefined( level.var_714c7ea0347def6a[ map_instance_index ] ) )
    {
        var_ed1cfa23b1cef2c6 = level.var_714c7ea0347def6a[ map_instance_index ][ "cinematic_shadowcaster" ];
        
        if ( isdefined( var_ed1cfa23b1cef2c6 ) )
        {
            var_ed1cfa23b1cef2c6 show();
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x41a80559, Offset: 0x2dbb
// Size: 0x71
function private function_b6d7c2e57831f94d( cinematic_root_struct, map_instance_index )
{
    if ( isdefined( cinematic_root_struct.world_event_name ) )
    {
        deactivateworldevent( cinematic_root_struct.world_event_name, 1 );
    }
    
    if ( isdefined( level.var_714c7ea0347def6a[ map_instance_index ] ) )
    {
        var_ed1cfa23b1cef2c6 = level.var_714c7ea0347def6a[ map_instance_index ][ "cinematic_shadowcaster" ];
        
        if ( isdefined( var_ed1cfa23b1cef2c6 ) )
        {
            var_ed1cfa23b1cef2c6 hide();
        }
    }
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0xfc14d2ee, Offset: 0x2e34
// Size: 0x10
function private shouldspawnbots()
{
    return getdvarint( @"online_is_devmapping", 0 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xb5f472a0, Offset: 0x2e4d
// Size: 0x61
function private function_92dd64e788a3774e( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, value );
        
        if ( msg == "versus_done" )
        {
            player utility::ent_flag_set( "loading_over" );
            break;
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1613b84e, Offset: 0x2eb6
// Size: 0x46f
function private onplayerconnect( player )
{
    player endon( #"disconnect" );
    
    if ( !isbot( player ) )
    {
        thread function_92dd64e788a3774e( player );
        thread function_95583a45b8caaba9( player );
    }
    
    player waittill( #"spawned" );
    
    if ( isbot( player ) )
    {
        botplayerconnect( player );
        return;
    }
    
    player function_a565dafac620d68e( %"hw_cer_trainingcourse" );
    player.disablepingvo = 1;
    player.var_968376be0223dc14 = 1;
    player.skin_on_respawn = function_224cad2522f7a2c2();
    
    for ( i = 0; i < level.var_67361f68db6dcf34.size ; i++ )
    {
        if ( level.var_67361f68db6dcf34[ i ] == 0 )
        {
            player.map_instance_index = i;
            level.var_67361f68db6dcf34[ i ] = 1;
            break;
        }
    }
    
    assert( isdefined( player.map_instance_index ), "<dev string:x24>" );
    player.training_course_completed = 0;
    player.var_c9f47db434eca171 = 0;
    player.training_course_completed_vo_played = 0;
    player.tutorial_dictionary = [];
    player.registered_triggers = [];
    player.var_80e907d847fdb68c = [];
    [ player.first_spawn_origin, player.first_spawn_angles ] = function_52ff81cfdbb3f234( ( -30482.1, -57256.3, 266.972 ), ( 0, -135, 0 ), player.map_instance_index );
    player.var_bb4f4ac000751f63 = 0;
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, "ui_icon_waypoint_generic" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, function_fb000aeabac687eb() );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    hideobjectivemarker( marker );
    player.global_objective_marker = marker;
    createtutorials( player );
    player utility::ent_flag_set( "training_course_tutorials_created" );
    function_89df6b3aced6d8cd( player );
    
    if ( shouldspawnbots() )
    {
        thread function_3dd874a3e7acaa50( player.map_instance_index );
    }
    
    thread luinotifylistener( player );
    player utility::ent_flag_wait( "player_active" );
    
    /#
        thread function_833acbbe64353915();
        thread function_893ed490f765fc47();
        
        if ( getdvarint( @"hash_cc23353bb35352e", 0 ) == 1 )
        {
            thread function_347c90461fb33c06( player );
        }
    #/
    
    thread function_fb78e7c7ad8e2157( player );
    [ npc_origin, npc_angles ] = function_52ff81cfdbb3f234( ( -30411, -57290, 272 ), ( 0, 50, 0 ), player.map_instance_index );
    
    if ( getdvarint( @"hash_49befb9786f9fda" ) )
    {
        player.npc_agent = spawnnpc( player, npc_origin, npc_angles );
    }
    else
    {
        player.npc_agent = spawn( "script_origin", npc_origin );
        player.npc_agent.angles = npc_angles;
    }
    
    player.npc_agent.vo_audience = player;
    player.script_animname = "Player 1";
    setglobalsoundcontext( "gametype", "training_course" );
    
    if ( getdvarint( @"hash_49befb9786f9fda" ) )
    {
        if ( function_1c1d2c09775c2bea() )
        {
            thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 0 );
            player utility::ent_flag_wait( "loading_over" );
            thread function_61061c166ccecf71( player, player.npc_agent, function_7b785364ecb1775c( player.map_instance_index ) );
            return;
        }
        
        function_acd7b230b1df93c1( player.map_instance_index ) thread function_904e69c6ea7095f1( player.npc_agent, 0 );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf74b8198, Offset: 0x332d
// Size: 0x4e, Type: bool
function private function_5e1ae482077473ff( params )
{
    if ( function_faa438d8de9a4dc9( self ) || function_abaed5b5b01f5e28( self.current_tutorial ) || self.var_a7207ed3c6b7e0b6 || self.var_c9f47db434eca171 )
    {
        playerlogic::playerhasmoved();
        return true;
    }
    
    return false;
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x41be4743, Offset: 0x3384
// Size: 0x173
function private training_afkcheck()
{
    if ( mp_afk::dontconsiderafk() )
    {
        mp_afk::function_a710eba86b2e3782( self, "default", 0, 0 );
        return;
    }
    
    if ( !isdefined( self.pers[ "timePlayedOnFirstSpawn" ] ) )
    {
        return;
    }
    
    afkstate = 0;
    afkmaxtime = level.afkthresholds.var_f21903a24e3d5816;
    var_2c85c490d93da8ef = level.var_4dd914bb587df856;
    afkreason = "default";
    
    if ( self iscommandinputstale() && self.sessionstate == "playing" )
    {
        afkstate = 2;
        afkreason = "training_afkCheck() TRUE, IsCommandInputStale() - " + self.name;
        mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
        return;
    }
    
    if ( self iscommandinputrepetitive() )
    {
        afkstate = 2;
        afkreason = "training_afkCheck() TRUE, IsCommandInputRepetitive() - " + self.name;
        mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
        return;
    }
    
    lastdisttrackingpassedtime = self.pers[ "distTrackingPassedOrResetTime" ] ?? 0;
    timesincelastpasseddistcheck = mp_afk::function_a10af3f5e26c28da() - lastdisttrackingpassedtime;
    afkstate = mp_afk::function_3a77ec8a437459f( timesincelastpasseddistcheck, afkmaxtime, var_2c85c490d93da8ef );
    
    if ( afkstate == 2 )
    {
        afkreason = "training_afkCheck() TRUE, getAFKCheckState() " + timesincelastpasseddistcheck;
    }
    
    mp_afk::function_a710eba86b2e3782( self, afkreason, afkstate, level.afkthresholds.var_66603405b103d2da );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x53cfb2fd, Offset: 0x34ff
// Size: 0x18
function private function_8658dfb45f6b84c8( map_instance_index )
{
    return level.bot_pool[ map_instance_index ];
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x3bfd8c74, Offset: 0x3520
// Size: 0x190
function private botplayerconnect( bot )
{
    if ( !isbot( bot ) )
    {
        return;
    }
    
    if ( !isdefined( level.bot_pool[ level.var_e104d2f44c811043 ] ) )
    {
        level.bot_pool[ level.var_e104d2f44c811043 ] = [];
    }
    
    current_pool_size = level.bot_pool[ level.var_e104d2f44c811043 ].size;
    level.bot_pool[ level.var_e104d2f44c811043 ][ current_pool_size ] = bot;
    current_pool_size = level.bot_pool[ level.var_e104d2f44c811043 ].size;
    
    if ( current_pool_size <= 1 )
    {
        bot.first_spawn_origin = function_d58310d0f1d16d43( ( -30556, -57117, 51 ), level.var_e104d2f44c811043 );
        bot.skin_on_respawn = function_224cad2522f7a2c2();
    }
    else
    {
        bot.is_meatshield_bot = 1;
        bot disableexecutionattack();
        bot.first_spawn_origin = function_d58310d0f1d16d43( ( -30542, -57270, 52 ), level.var_e104d2f44c811043 );
        bot.skin_on_respawn = %"t10_gbr_pl_stone_sable_skin";
    }
    
    bot.map_instance_index = level.var_e104d2f44c811043;
    bot.first_spawn_angles = ( 0, 90, 0 );
    bot playerhide();
    function_f84dc38c3e66bb65( bot );
    var_d7a03fd5431c6962 = function_ba1324c1fe3aa6c6();
    
    if ( var_d7a03fd5431c6962 != 0 && current_pool_size % var_d7a03fd5431c6962 == 0 )
    {
        level.var_e104d2f44c811043++;
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xa78bf4bd, Offset: 0x36b8
// Size: 0x285
function private function_61061c166ccecf71( player, npc_agent, cinematic_root_struct )
{
    player endon( #"disconnect" );
    
    if ( !getdvarint( @"hash_49befb9786f9fda" ) )
    {
        return;
    }
    
    player.var_a7207ed3c6b7e0b6 = 1;
    childthread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 0 );
    player.npc_agent.var_5c11ace5ae14ad8 show();
    
    if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) )
    {
        player.npc_agent.var_31a461ef76afc85b scene::stop();
    }
    
    player.npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    cinematic_root_struct scene::function_b95eab90f9ebc981( [ player ] );
    cinematic_root_struct thread scene::play( [ player, player.npc_agent, player.npc_agent.wheelchair, player.npc_agent.var_5c11ace5ae14ad8 ], undefined, "t10_mp_training_course_intro_scripted_scene" );
    function_3f46a4fd28a17454( player, undefined );
    function_6427cfa4077010bd( cinematic_root_struct, player.map_instance_index );
    player waittill( #"intro_fade" );
    childthread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 2 );
    player waittill( #"intro_playercontrol" );
    
    foreach ( weap in player.primaryweapons )
    {
        if ( weaponclass( weap ) == "rifle" )
        {
            player switchtoweaponimmediate( weap );
            break;
        }
    }
    
    function_b6d7c2e57831f94d( cinematic_root_struct, player.map_instance_index );
    function_649644d8af5d56f( player, undefined );
    player.npc_agent.var_5c11ace5ae14ad8 hide();
    thread function_991489897b68327f( player, function_acd7b230b1df93c1( player.map_instance_index ), player.npc_agent );
    function_acd7b230b1df93c1( player.map_instance_index ) thread function_904e69c6ea7095f1( player.npc_agent, 0 );
    player.var_a7207ed3c6b7e0b6 = 0;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x9757f88d, Offset: 0x3945
// Size: 0xab
function private function_991489897b68327f( player, cinematic_root_struct, npc_agent )
{
    level endon( #"game_ended" );
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    timer = 0;
    
    while ( true )
    {
        if ( player getvelocity() != 0 )
        {
            timer = 0;
            waitframe();
            continue;
        }
        
        timer += level.framedurationseconds;
        
        if ( timer >= 10 )
        {
            cinematic_root_struct thread function_904e69c6ea7095f1( npc_agent, 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0xc
// Checksum 0x4582e6f1, Offset: 0x39f8
// Size: 0xf0
function private function_904e69c6ea7095f1( npc_agent, var_c4e052625118bfa0 )
{
    self notify( #"hash_7591af72db46a45b" );
    self endon( #"hash_7591af72db46a45b" );
    cinematic_root_struct = self;
    level endon( #"game_ended" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_12c1fdad821de6c0" );
    npc_agent notify( #"hash_a252f3f036d289b1" );
    npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    
    if ( var_c4e052625118bfa0 )
    {
        cinematic_root_struct scene::stop();
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_020", "t10_mp_training_course_intro_woods_idle_nag" );
    }
    
    while ( true )
    {
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_010", "t10_mp_training_course_intro_woods_idle_nag" );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0xc
// Checksum 0x4b8b1ac4, Offset: 0x3af0
// Size: 0xb0
function private function_f16a23237304761a( npc_agent )
{
    self notify( #"hash_56a4a6ff611c3914" );
    self endon( #"hash_56a4a6ff611c3914" );
    cinematic_root_struct = self;
    level endon( #"game_ended" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_a252f3f036d289b1" );
    npc_agent notify( #"hash_12c1fdad821de6c0" );
    
    while ( true )
    {
        npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_030", "t10_mp_training_course_intro_woods_idle_nag" );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x7ab8ea33, Offset: 0x3ba8
// Size: 0x114
function private function_5b3639edf841fc69( player, npc_agent, cinematic_root_struct )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_a252f3f036d289b1" );
    
    while ( true )
    {
        if ( distancesquared( player.origin, npc_agent.origin ) > 250000 )
        {
            trace = trace::ray_trace( player geteye(), npc_agent.origin + ( 0, 0, 50 ), player, undefined );
            
            if ( !withinfov( player.origin, player.angles, npc_agent.origin, 0.9 ) || !isdefined( trace[ "entity" ] ) || trace[ "entity" ] != npc_agent )
            {
                cinematic_root_struct thread function_f16a23237304761a( npc_agent );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x9853ea04, Offset: 0x3cc4
// Size: 0x40f
function private onplayerdisconnect( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isbot( player ) )
    {
        return;
    }
    
    player common_training_course::function_ae1b81443a485a25( 0, 1 );
    function_c06c98d7da9ead59( player );
    player function_72cf2eee8e035013( %"hw_cer_trainingcourse" );
    
    foreach ( tutorial in player.tutorial_dictionary )
    {
        deletetutorial( player, tutorial, 1 );
    }
    
    player.tutorial_dictionary = undefined;
    player.var_80e907d847fdb68c = undefined;
    
    foreach ( trigger in player.registered_triggers )
    {
        if ( isdefined( trigger ) )
        {
            trigger delete();
        }
    }
    
    player.registered_triggers = undefined;
    
    if ( isdefined( player.global_objective_marker ) )
    {
        objidpoolmanager::returnobjectiveid( player.global_objective_marker.objidnum );
        player.global_objective_marker = undefined;
    }
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable delete();
        player.leave_training_course_interactable = undefined;
    }
    
    if ( isdefined( player.npc_agent ) )
    {
        if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) && isdefined( player.map_instance_index ) )
        {
            function_b6d7c2e57831f94d( player.npc_agent.var_31a461ef76afc85b, player.map_instance_index );
        }
        
        if ( isdefined( player.npc_agent.wheelchair ) )
        {
            player.npc_agent.wheelchair delete();
        }
        
        if ( isdefined( player.npc_agent.var_5c11ace5ae14ad8 ) )
        {
            player.npc_agent.var_5c11ace5ae14ad8 delete();
        }
        
        player.npc_agent delete();
        player.npc_agent = undefined;
    }
    
    if ( isdefined( player.map_instance_index ) )
    {
        level.var_67361f68db6dcf34[ player.map_instance_index ] = 0;
        bots = function_8658dfb45f6b84c8( player.map_instance_index );
        
        foreach ( bot in bots )
        {
            if ( isdefined( bot ) )
            {
                bot setorigin( bot.first_spawn_origin );
                function_f84dc38c3e66bb65( bot );
                bot playerhide();
            }
        }
        
        ent_map_array = level.var_714c7ea0347def6a[ player.map_instance_index ];
        
        if ( isdefined( ent_map_array[ "scene_struct_array" ] ) )
        {
            foreach ( scene_struct in ent_map_array[ "scene_struct_array" ] )
            {
                scene_struct scene::cleanup( 1 );
            }
        }
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xa83262, Offset: 0x40db
// Size: 0x17d
function private function_9cc26a2c4cf82d07( winner, endreasontext, nukedetonated )
{
    winner = getwinningteam( winner );
    
    foreach ( player in level.players )
    {
        player common_training_course::function_ae1b81443a485a25( 0, 1 );
    }
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        var_c146bd9b0929cc58 = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isbot( player ) )
            {
                var_c146bd9b0929cc58 = player;
                break;
            }
        }
        
        if ( isdefined( var_c146bd9b0929cc58 ) && function_d39dfc7ac04716ef( var_c146bd9b0929cc58 ) )
        {
            function_816ecee4d7db0c68( var_c146bd9b0929cc58, function_d18dd74017e9db87( var_c146bd9b0929cc58.map_instance_index ), 0 );
            level notify( #"exitlevel_called" );
            exitlevel( 0 );
            return;
        }
    }
    
    gamelogic_mp::endgame_regularmp( winner, endreasontext, undefined, undefined, undefined );
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x7dabdc0c, Offset: 0x4260
// Size: 0x22, Type: bool
function private function_1c1d2c09775c2bea()
{
    return getdvarint( @"hash_49befb9786f9fda" ) && !getdvarint( @"hash_5008d1a95886a95d", 0 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xdac120ed, Offset: 0x428b
// Size: 0x4a, Type: bool
function private function_d39dfc7ac04716ef( player )
{
    return getdvarint( @"hash_49befb9786f9fda" ) && !player.var_c9f47db434eca171 && ( getdvarint( @"hash_f44d74c5114354c1", 0 ) || player.training_course_completed );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x49a702ea, Offset: 0x42de
// Size: 0x283
function private function_816ecee4d7db0c68( player, cinematic_root_struct, var_d3a838736eab42ad = 1 )
{
    if ( !getdvarint( @"hash_49befb9786f9fda" ) )
    {
        return;
    }
    
    player.var_c9f47db434eca171 = 1;
    
    if ( isdefined( player.current_tutorial ) )
    {
        exittutorial( player, player.current_tutorial, 0, undefined, 0 );
    }
    
    if ( outofbounds::isoob( player ) )
    {
        outofbounds::clearoob( player, 0 );
    }
    
    player.npc_agent notify( #"hash_5bd6fd3710aeca33" );
    function_48b7033aa12c2f72( player, 1 );
    wait 1;
    player.npc_agent dialogue::stop_dialogue();
    player.npc_agent notify( #"hash_6643ac25fca32e44" );
    function_3f46a4fd28a17454( player, undefined );
    player.npc_agent.var_5c11ace5ae14ad8 show();
    
    if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) )
    {
        player.npc_agent.var_31a461ef76afc85b scene::stop();
    }
    
    function_6427cfa4077010bd( cinematic_root_struct, player.map_instance_index );
    function_471eaf1a49ed9cc9( player, 3 );
    player.npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    cinematic_root_struct scene::function_b95eab90f9ebc981( [ player ] );
    cinematic_root_struct thread scene::play( [ player, player.npc_agent, player.npc_agent.wheelchair, player.npc_agent.var_5c11ace5ae14ad8 ], undefined, "t10_mp_training_course_outro_scripted_scene" );
    player waittill( #"outro_fade" );
    function_48b7033aa12c2f72( player, 1.5 );
    function_b6d7c2e57831f94d( cinematic_root_struct, player.map_instance_index );
    player disableweapons();
    player.npc_agent hidefromplayer( player );
    player.npc_agent.wheelchair hidefromplayer( player );
    wait 3;
    
    if ( var_d3a838736eab42ad )
    {
        if ( game_utility_mp::matchmakinggame() )
        {
            current_value = player getclientomnvar( "training_course_leave_game_request" );
            player setclientomnvar( "training_course_leave_game_request", !current_value );
        }
        else
        {
            level notify( #"exitlevel_called" );
            exitlevel( 0 );
        }
    }
    
    player.var_c9f47db434eca171 = 0;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x4a5b5818, Offset: 0x4569
// Size: 0xf8
function private getwinningteam( current_winner )
{
    if ( !game_utility_mp::matchmakinggame() && isdefined( level.players[ 0 ].tutorial_dictionary ) )
    {
        var_4e0fc2dbd25cba8b = 1;
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !function_faefa119842f585b( tutorial ) )
            {
                var_4e0fc2dbd25cba8b = 0;
                break;
            }
        }
        
        if ( var_4e0fc2dbd25cba8b && isdefined( level.players[ 0 ] ) )
        {
            current_winner = level.players[ 0 ].team;
        }
    }
    
    return current_winner;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x97d8d3a3, Offset: 0x466a
// Size: 0x198
function private function_e6c0ed093a236b20( player, initial_wait_time, tutorial_dictionary )
{
    wait initial_wait_time;
    tutorial_array = [];
    
    foreach ( tutorial in tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    var_889beba20932b29b = arraysort( tutorial_array, undefined, &function_c25960b107824fa7 );
    assert( var_889beba20932b29b.size <= 15, "<dev string:x51>" );
    var_1bee7348e8012def = int( ceil( var_889beba20932b29b.size / 6 ) );
    
    for ( i = 0; i < var_1bee7348e8012def ; i++ )
    {
        right_side = int( min( var_889beba20932b29b.size, 6 * ( i + 1 ) ) );
        left_side = 1 + 6 * i;
        sent_size = right_side - left_side + 1;
        packed_number = function_8b878dec24bedc0e( var_889beba20932b29b[ left_side - 1 ] );
        
        for ( j = left_side; j < right_side ; j++ )
        {
            packed_number = packed_number << 4 | function_8b878dec24bedc0e( var_889beba20932b29b[ j ] );
        }
        
        packed_number = packed_number << 4 | sent_size;
        player setclientomnvar( "training_course_update_tutorial_list", packed_number );
        wait 1.5;
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x1cbd700b, Offset: 0x480a
// Size: 0x2c, Type: bool
function private function_c25960b107824fa7( leftelement, rightelement )
{
    return leftelement.order_number < rightelement.order_number;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x4c007fe2, Offset: 0x483f
// Size: 0x18
function private function_ff3e3429587d5f3b( value )
{
    utility::ent_flag_set( "training_course_hud_ready" );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf0636b2d, Offset: 0x485f
// Size: 0xfe
function private function_95583a45b8caaba9( player )
{
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "loading_over" );
    player utility::ent_flag_wait( "training_course_tutorials_created" );
    var_85ea2813ba4c6456 = [];
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        foreach ( id_string, tutorial in player.tutorial_dictionary )
        {
            if ( id_string != "emote" )
            {
                var_85ea2813ba4c6456[ id_string ] = tutorial;
            }
        }
    }
    else
    {
        var_85ea2813ba4c6456 = player.tutorial_dictionary;
    }
    
    function_e6c0ed093a236b20( player, function_1c1d2c09775c2bea() ? 15 : 1, var_85ea2813ba4c6456 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xacfd34ff, Offset: 0x4965
// Size: 0xc7
function private function_3dd874a3e7acaa50( map_instance_index )
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) )
    {
        preview_bot_position = function_d58310d0f1d16d43( ( -30556, -57117, 51 ), map_instance_index );
        spawnbot( preview_bot_position, ( 0, 0, 0 ), "allies" );
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        for ( i = 0; i < 2 ; i++ )
        {
            meatshield_bot_position = function_d58310d0f1d16d43( ( -30542, -57270, 52 ), map_instance_index );
            spawnbot( meatshield_bot_position, ( 0, 0, 0 ), "axis" );
        }
    }
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x9c491d02, Offset: 0x4a34
// Size: 0x3b
function private function_ba1324c1fe3aa6c6()
{
    var_6912e11add540d80 = 0;
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) )
    {
        var_6912e11add540d80++;
    }
    
    if ( getdvarint( @"hash_82feb18c2130951a" ) )
    {
        var_6912e11add540d80 += 2;
    }
    
    return var_6912e11add540d80;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xc622bdd4, Offset: 0x4a78
// Size: 0xb0a
function private createtutorials( player )
{
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        slide_or_dive_tutorial = createtutorial( player, "slide_or_dive", 1, 1, 1, &function_ae016fbb20adb105, &function_55af82327485d2e4, &function_23db93ff6b44493c, undefined, undefined, &function_bcbedc2c163b2e23, &function_c5d8bcb7c892ea86, &function_d241a4a189571057, ( -31263, -56356, 448 ), ( 0, 65, 0 ), 1, 1, 1, ( -31180, -56175, 448 ), 0.5, 1, 0.3 );
        slide_or_dive_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts4slidediveintro_wood" ];
        slide_or_dive_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        slide_or_dive_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts4slidedivesuccess_wood" ];
        slide_or_dive_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
        function_871cc06a4aaadaf5( slide_or_dive_tutorial, 150, [ function_d58310d0f1d16d43( ( -31494, -56444, 450 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31353, -56153, 450 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, -25, 0 ), player.map_instance_index ), 0 );
        function_871cc06a4aaadaf5( slide_or_dive_tutorial, 150, [ function_d58310d0f1d16d43( ( -30750, -56261, 568 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30650, -56307, 568 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, -120, 0 ), player.map_instance_index ), 0 );
        function_871cc06a4aaadaf5( slide_or_dive_tutorial, 150, [ function_d58310d0f1d16d43( ( -31133, -56617, 448 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31047, -56655, 448 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, 62, 0 ), player.map_instance_index ), 0 );
    }
    
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        var_7ee22c9ad2e558ff = createtutorial( player, "180_dive", 2, 1, 1, &function_631045c1a2853fba, &function_84a52c739235b76f, &function_486d9ca550880281, undefined, &function_2f5e16214c686e52, &function_7c994beb5fedb5a0, &function_7bfc484c8ee7b93f, &function_bff8805add7b8bde, ( -30888, -54887, 431 ), ( 0, 160, 0 ), 1, 1, 1, ( -30993, -54849, 430 ), 0.5, 1, 0.3 );
        var_7ee22c9ad2e558ff.var_47eb83743fd1597 = [ "dx_mp_mptc_ts5dive180intro_wood" ];
        var_7ee22c9ad2e558ff.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        var_7ee22c9ad2e558ff.var_366e9014d86d580a = [ "dx_mp_mptc_ts5dive180success_wood" ];
        var_7ee22c9ad2e558ff.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
        function_871cc06a4aaadaf5( var_7ee22c9ad2e558ff, 150, [ function_d58310d0f1d16d43( ( -31061, -54484, 431 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30801, -54562, 476 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, -100, 0 ), player.map_instance_index ), 0 );
        function_871cc06a4aaadaf5( var_7ee22c9ad2e558ff, 150, [ function_d58310d0f1d16d43( ( -30717, -54976, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30765, -55136, 431 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31275, -55015, 432 ), player.map_instance_index ) ], undefined, 0 );
    }
    
    supine_tutorial = createtutorial( player, "supine", 3, 1, 1, &function_9899af1f5993873d, &function_6f5ee852e56ce6dc, undefined, &function_2c3c3e319054f3d0, &function_46a08ab7bcfeafb3, &function_ac7709ce2d18a66b, &function_1c77b5856a5e2eee, &function_c1c34569d90ffb3f, ( -31870, -55196, 112 ), ( 0, -10, 0 ), 1, 1, 2, ( -31698, -55239, 110 ), 0.5, 0.5, 2.5 );
    supine_tutorial.var_98cec33d0b4e8c5 = 1;
    supine_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts6suppineintro_wood" ];
    supine_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
    supine_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts6suppinesuccess_wood" ];
    supine_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
    
    if ( getdvarint( @"hash_49ee092bdec92e4e" ) )
    {
        omnisprint_tutorial = createtutorial( player, "omnisprint", 0, 2, 0, &function_3b9c0f927794c87e, &function_8a06fe6b22498dfb, undefined, undefined, &function_3d90c6080a706c4b, undefined, undefined, undefined, ( -31178, -55009, 431 ), ( 0, 75, 0 ), 1, 1, 2, ( -30628, -55677, 432 ), 0.5, 0.5, 0.3 );
        omnisprint_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts3omniintro_wood" ];
        omnisprint_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        omnisprint_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts3omnisuccess_wood" ];
        omnisprint_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
    }
    
    if ( getdvarint( @"meatshield_enabled" ) == 1 && getdvarint( @"hash_82feb18c2130951a" ) )
    {
        meatshield_tutorial = createtutorial( player, "meatshield", 4, 1, 1, &function_eb3ea60bb4e2122d, &function_eef95cf422ee90cc, &function_7b0997d222bd6ed4, undefined, &function_543c2f2f36cba326, &function_ba41b7a10219ef3b, &function_7d1d9a69f497ce3e, &function_13e58d96d5b1042f, ( -30385, -53730, 304 ), ( 0, -18, 0 ), 1, 1, 2, ( -30303, -54176, 400 ), 0.5, 0.5, 0 );
        meatshield_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts7bodyshieldintro_wood" ];
        meatshield_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        meatshield_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts7bodyshieldsucces_wood" ];
        meatshield_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
        meatshield_tutorial.var_e7e7977f1d016e4c = getdvarfloat( @"hash_a414be2abcef64ba", 1 );
        function_871cc06a4aaadaf5( meatshield_tutorial, 150, [ function_d58310d0f1d16d43( ( -30198, -54114, 400 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30397, -54062, 399 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, 70, 0 ), player.map_instance_index ), 0 );
        function_871cc06a4aaadaf5( meatshield_tutorial, 150, [ function_d58310d0f1d16d43( ( -30127, -53521, 304 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -29927, -53579, 304 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, -108, 0 ), player.map_instance_index ), 0 );
        function_871cc06a4aaadaf5( meatshield_tutorial, 150, [ function_d58310d0f1d16d43( ( -30688, -53760, 344 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30694, -53679, 344 ), player.map_instance_index ) ], function_2e52e3ebd7fff7bd( ( 0, 0, 0 ), player.map_instance_index ), 0 );
    }
    
    if ( getdvarint( @"hash_fb237c32ec4de2b9" ) )
    {
        basic_movement_tutorial = createtutorial( player, "basic_movement", 5, 2, 0, &function_c0b7d169e34f2418, &function_453ce916fba291a1, undefined, undefined, &function_36f64d6bee634a9, undefined, undefined, undefined, ( -30400, -57210, 272 ), ( 0, -150, 0 ), 1, 1, 2, ( -30641, -57361, 272 ), 0.5, 0.5, 0.3 );
        basic_movement_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts1moveintro_wood" ];
        basic_movement_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        basic_movement_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts1movesuccess_wood" ];
        basic_movement_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
        basic_equipment_tutorial = createtutorial( player, "basic_equipment", 6, 2, 0, &function_1399331f1092d5fd, &function_436c4b277d74899c, undefined, undefined, &function_c986e0685a1ba96, undefined, undefined, undefined, ( -32205, -57300, 231 ), ( 0, 75, 0 ), 1, 1, 2, ( -32052, -57354, 235 ), 0.7, 0.7, 0.3 );
        basic_equipment_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts2equipmentintro_wood" ];
        basic_equipment_tutorial.var_8c2623b27b71c6bd = [ "dx_mp_mptc_trnobjectivefail_wood" ];
        basic_equipment_tutorial.var_366e9014d86d580a = [ "dx_mp_mptc_ts2equipmentsuccess_wood" ];
        basic_equipment_tutorial.var_6caae9f87149260b = [ "dx_mp_mptc_trnobjectivesuccess_wood" ];
        basic_equipment_tutorial.var_85a7b95bc3de3767 = &function_3ac947bc433d7e3c;
    }
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        emote_tutorial = createtutorial( player, "emote", 7, 2, 0, &function_a76af4aa2bc4b71f, &function_6573c78f12412c4a, undefined, undefined, &function_2bea643b5dba5bdc, undefined, undefined, undefined, ( -29666, -53953, 302 ), ( 0, -15, 0 ), 1, 1, 2, ( -29451, -54059, 303 ), 0.5, 0.5, 0.3 );
        emote_tutorial.var_47eb83743fd1597 = [ "dx_mp_mptc_ts8emoteovrvwintro_wood" ];
        function_bfa865dfd7b9bfd6( player, emote_tutorial, 1 );
    }
    
    tutorial_array = [];
    
    foreach ( tutorial in player.tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    player.var_80e907d847fdb68c = arraysort( tutorial_array, undefined, &function_c25960b107824fa7 );
    
    /#
        initdevgui( player.tutorial_dictionary );
    #/
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe9ab1c55, Offset: 0x558a
// Size: 0x21d
function private function_2cb67c7fc6e3fed5( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( isdefined( player.secondaryweaponobj ) && player.secondaryweaponobj.basename != "none" )
    {
        player takeweapon( player.secondaryweaponobj );
    }
    
    if ( isdefined( player.primaryweaponobj ) && player.primaryweaponobj.basename != "none" )
    {
        player takeweapon( player.primaryweaponobj );
    }
    
    player equipment_mp::giveequipment( "equip_frag", "primary" );
    player equipment_mp::giveequipment( "equip_flash", "secondary" );
    
    if ( isdefined( player.current_tutorial.var_85a7b95bc3de3767 ) )
    {
        [[ player.current_tutorial.var_85a7b95bc3de3767 ]]( player, player.current_tutorial );
    }
    else
    {
        player equipment_mp::setequipmentslotammo( "primary", 0 );
        player equipment_mp::setequipmentslotammo( "secondary", 0 );
        player perkpackage::perkpackage_giveimmediate( "super_ammo_drop", undefined, undefined, undefined, 0 );
        player supers_mp::clearsuper();
        player equipment_mp::takeequipment( "super" );
    }
    
    player class::loadout_clearperks();
    waitframe();
    attachments = [ "t10_microreflex02_ar", "t10_ammo_556n", "t10_underbarrel_recoil_ar_coslo", "t10_grips_quickdraw2_ar_coslo", "t10_selectsemi_coslo723", "t10_mags_extclip_ar_coslo", "t10_stock_ar_p01", "t10_bar_ar_p01", "t10_rec_coslo723" ];
    primary_weapon = weapon::buildweapon( "t10_ar_p01_coslo723_mp", attachments );
    player givemaxammo( primary_weapon );
    player setweaponammostock( primary_weapon, weaponmaxammo( primary_weapon ) );
    player giveweapon( primary_weapon, 0, 0, 0, 1 );
    secondary_weapon = weapon::buildweapon( "t10_pi_p14_mable_mp", [ "t10_mags_extclip2_pi_mable" ] );
    player giveweapon( secondary_weapon, 0, 0, 0, 1 );
    player switchtoweapon( primary_weapon );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x7b374b14, Offset: 0x57af
// Size: 0xb7
function private setplayerviewmodel( player, operator_skin )
{
    if ( !function_f0999c39797a8308() )
    {
        operator = operator::function_30f20ce375c4ee40( operator_skin );
        models = operator::function_fb2ad6ca3c6b708d( operator_skin );
        player clearcustomization( 1 );
        player setoperatorcustomization( operator, operator_skin );
        player teams::setcharactermodels( models[ 0 ], models[ 1 ], models[ 2 ] );
        
        if ( !isdefined( player.operatorcustomization ) )
        {
            player operator::createoperatorcustomization();
        }
        
        player.operatorcustomization.body = models[ 0 ];
        player.operatorcustomization.head = models[ 1 ];
    }
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x36eed5c, Offset: 0x586e
// Size: 0x6a
function private function_224cad2522f7a2c2()
{
    if ( !isxhashasset( %"t10_pak_nazir_rogue_skin" ) )
    {
        return getxhashasset( getdvar( @"hash_37a6f04d4b24d7be", %"t10_pak_nazir_rogue_skin" ) );
    }
    
    operator_skin = getdvar( @"hash_37a6f04d4b24d7be" );
    
    if ( !isdefined( operator_skin ) || operator_skin == "" )
    {
        return %"t10_pak_nazir_rogue_skin";
    }
    
    return getxhashasset( operator_skin );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe7aa0758, Offset: 0x58e1
// Size: 0x7a
function private function_aa4c8736e7957afd( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    weapon = player getcurrentweapon();
    
    while ( player isreloading() )
    {
        waitframe();
    }
    
    player givemaxammo( weapon );
    player setweaponammostock( weapon, weaponmaxammo( weapon ) );
}

// Namespace t10_training_course
// Params 26, eflags: 0x4
// Checksum 0x26d327b9, Offset: 0x5963
// Size: 0x4b4
function private createtutorial( player, id_string, var_81173965ad64569, tutorial_type, var_96e5beb113f41311, onsetup, oncleanup, onfail, onexit, startlogic, var_3dcac807aca26fce, var_fe1e173811f47789, var_47f8fc3de4a91658, respawn_position, respawn_angles, var_b8abd6e1783d0f45, var_daae47f54aee1cc3, respawn_delay, init_trigger_position, transition_fade_in_time, transition_fade_out_time, var_11b386f1f1fd262a, var_c7da30c496405c56 = 1, var_5953c9ce8530c19a = 110, start_trigger_radius = 100, var_d67fbb77e4f2e2b5 = 1.2 )
{
    [ respawn_position, respawn_angles ] = function_52ff81cfdbb3f234( respawn_position, respawn_angles, player.map_instance_index );
    tutorial_struct = { #fail_state:-1, #is_completed:0, #is_locked:0, #var_11b386f1f1fd262a:var_11b386f1f1fd262a, #transition_fade_out_time:transition_fade_out_time, #transition_fade_in_time:transition_fade_in_time, #respawn_delay:respawn_delay, #respawn_angles:respawn_angles, #respawn_position:respawn_position, #var_daae47f54aee1cc3:var_daae47f54aee1cc3, #var_b8abd6e1783d0f45:var_b8abd6e1783d0f45, #startlogic:startlogic, #var_47f8fc3de4a91658:var_47f8fc3de4a91658, #var_fe1e173811f47789:var_fe1e173811f47789, #var_3dcac807aca26fce:var_3dcac807aca26fce, #onexit:onexit, #onfail:onfail, #oncleanup:oncleanup, #onsetup:onsetup, #oob_chevrons:[], #var_a5fd41050e0ceb34:0, #var_98cec33d0b4e8c5:0, #var_5a63045faffa8fee:0, #state:3, #var_96e5beb113f41311:var_96e5beb113f41311, #tutorial_type:tutorial_type, #var_81173965ad64569:var_81173965ad64569, #id_string:id_string };
    var_b3e7a6423912e4b7 = function_753a55cf69adc665();
    tutorial_struct.order_number = -1;
    
    for ( i = 0; i < var_b3e7a6423912e4b7.size ; i++ )
    {
        if ( var_b3e7a6423912e4b7[ i ] == var_81173965ad64569 )
        {
            tutorial_struct.order_number = i;
            break;
        }
    }
    
    assert( tutorial_struct.order_number != -1, id_string + "<dev string:x9a>" );
    init_trigger_position = function_d58310d0f1d16d43( init_trigger_position, player.map_instance_index );
    init_trigger = function_4c7f1d74ec378cc9( tutorial_struct, init_trigger_position, start_trigger_radius, &function_3a0aec7f1e9988a3, &function_5c1689103ca32d82 );
    init_trigger.is_init_trigger = 1;
    tutorial_struct.init_trigger = init_trigger;
    registertrigger( player, init_trigger );
    flag = spawn( "script_model", init_trigger_position );
    
    if ( var_c7da30c496405c56 )
    {
        flag setmodel( function_68d39c6b75e01593( "neutral" ) );
    }
    
    tutorial_struct.init_trigger.flag = flag;
    flag makeusable();
    flag setuserange( start_trigger_radius * var_d67fbb77e4f2e2b5 );
    flag sethintstring( &"t10_training_course/enter_station_hint" );
    flag setcursorhint( "HINT_NOICON" );
    thread function_78ed747911e430e7( flag, tutorial_struct );
    marker = gameobjects::createobjidobject( init_trigger_position, "neutral", ( 0, 0, var_5953c9ce8530c19a ), undefined, "any", 1, "icon_regular" );
    objidpoolmanager::update_objective_icon( marker.objidnum, function_de3c47a67959c59e( tutorial_struct.order_number ) );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, function_fb000aeabac687eb() );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::function_586b631e7bbb592a( marker.objidnum, 1 );
    objective_setlabel( marker.objidnum, function_e2157f3642beec77( tutorial_struct.order_number ) );
    objidpoolmanager::objective_playermask_hidefromallplayers( marker.objidnum );
    tutorial_struct.init_trigger.objective_marker = marker;
    player.tutorial_dictionary[ id_string ] = tutorial_struct;
    function_bb59f9b0bdf2d248( player, tutorial_struct, 0 );
    return tutorial_struct;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x4ae7ea60, Offset: 0x5e20
// Size: 0xde
function private deletetutorial( player, tutorial, is_disconnecting )
{
    if ( !function_7bc1290560032d39( tutorial ) )
    {
        exittutorial( player, tutorial, 0, undefined, 0, is_disconnecting );
    }
    
    objidpoolmanager::returnobjectiveid( tutorial.init_trigger.objective_marker.objidnum );
    tutorial.init_trigger.objective_marker = undefined;
    function_bfd317f43b3fe8e3( tutorial.init_trigger.flag );
    tutorial.init_trigger.flag delete();
    tutorial.init_trigger delete();
    
    if ( isdefined( tutorial.oob_chevrons ) )
    {
        deletechevrons( tutorial.oob_chevrons );
    }
    
    tutorial = {};
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xd345f067, Offset: 0x5f07
// Size: 0x56
function private function_de3c47a67959c59e( tutorial_order_number )
{
    icon_name = "ui_icon_waypoint_training_station_";
    
    if ( tutorial_order_number < 0 || tutorial_order_number > 7 )
    {
        iprintlnbold( "Icon { " + icon_name + tutorial_order_number + 1 + " } does not exist. We would need to create one." );
        return ( icon_name + "1" );
    }
    
    return icon_name + tutorial_order_number + 1;
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x9a453d45, Offset: 0x5f66
// Size: 0x11
function private function_fb000aeabac687eb()
{
    return function_f0999c39797a8308() ? 9 : 0;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xbfdb19e8, Offset: 0x5f80
// Size: 0xa3
function private function_e2157f3642beec77( tutorial_order_number )
{
    labels = [ &"t10_training_course/station_1_label", &"t10_training_course/station_2_label", &"t10_training_course/station_3_label", &"t10_training_course/station_4_label", &"t10_training_course/station_5_label", &"t10_training_course/station_6_label", &"t10_training_course/station_7_label", &"t10_training_course/station_8_label" ];
    assert( tutorial_order_number < labels.size, "<dev string:xc4>" + tutorial_order_number + "<dev string:x110>" );
    return labels[ tutorial_order_number ];
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf8bdaf5b, Offset: 0x602c
// Size: 0x5e
function private function_68d39c6b75e01593( flag_type )
{
    switch ( flag_type )
    {
        case #"hash_a571cacc018623b8":
            return "t10_decor_gunfight_flag_01";
        case #"hash_5f54b9bf7583687f":
            return "t10_decor_gunfight_flag_01";
        case #"hash_7c2d091e6337bf54":
            return "t10_decor_gunfight_flag_01";
        default:
            return "t10_decor_gunfight_flag_01";
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe80f8b47, Offset: 0x6092
// Size: 0x44
function private function_f1ec08cd8f74da12( player, tutorial )
{
    if ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        function_5c1689103ca32d82( player, tutorial );
        thread starttutorial( player, tutorial, 1, tutorial.var_b8abd6e1783d0f45, 0, 0 );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x92ab30a8, Offset: 0x60de
// Size: 0x73
function private function_78ed747911e430e7( interactable, tutorial )
{
    level endon( #"game_ended" );
    interactable endon( #"delete" );
    interactable endon( #"hash_23f15c705d374165" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        interactable sethintinoperable( 1 );
        function_f1ec08cd8f74da12( player, tutorial );
        break;
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x46c0b4bc, Offset: 0x6159
// Size: 0x7a
function private function_312ad34cc38979e4( interactable, player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    interactable endon( #"delete" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        
        if ( function_d39dfc7ac04716ef( player ) )
        {
            function_816ecee4d7db0c68( player, function_d18dd74017e9db87( player.map_instance_index ), 1 );
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xd11f30b3, Offset: 0x61db
// Size: 0x19
function private function_bfd317f43b3fe8e3( interactable )
{
    interactable notify( #"hash_23f15c705d374165" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x6fb7d17d, Offset: 0x61fc
// Size: 0xa9
function private function_cc9a85feed9c8e34( player, tutorial )
{
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 0 );
            function_8becb86703380fc7( player, other_tutorial, 0, 0 );
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x401ba5f7, Offset: 0x62ad
// Size: 0xda
function private function_89df6b3aced6d8cd( player )
{
    var_826a597648a0c05a = undefined;
    
    if ( player.var_bb4f4ac000751f63 != -1 )
    {
        var_826a597648a0c05a = player.var_80e907d847fdb68c[ player.var_bb4f4ac000751f63 ];
    }
    
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 1 );
            function_8becb86703380fc7( player, other_tutorial, var_826a597648a0c05a === other_tutorial, 1 );
        }
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x31197f5f, Offset: 0x638f
// Size: 0x48
function private function_bfa865dfd7b9bfd6( player, tutorial, value )
{
    tutorial.is_locked = value;
    function_a49fc858e731dcdb( tutorial, !value );
    function_8becb86703380fc7( player, tutorial, !value, !value );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x540caec9, Offset: 0x63df
// Size: 0x4c
function private function_3f46a4fd28a17454( player, tutorial )
{
    if ( !isdefined( player.ishudhidden ) )
    {
        player.ishudhidden = 0;
    }
    
    player setclientomnvar( "ui_hide_hud", 1 );
    player.ishudhidden = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x1c09ec6a, Offset: 0x6433
// Size: 0x58
function private function_649644d8af5d56f( player, tutorial )
{
    if ( !isdefined( player.ishudhidden ) )
    {
        player.ishudhidden = 0;
    }
    
    if ( player.ishudhidden )
    {
        player setclientomnvar( "ui_hide_hud", 0 );
        player.ishudhidden = 0;
    }
}

// Namespace t10_training_course
// Params 7
// Checksum 0x84307196, Offset: 0x6493
// Size: 0x6be
function starttutorial( player, new_tutorial_struct, var_67d56ce428f7a6f9, var_21904a198ae4f24e = 0, var_2b4b07109454f1e4 = 0, was_failed = 0, var_1511c5590534bc27 = undefined )
{
    assert( isdefined( new_tutorial_struct ), "<dev string:x112>" );
    player endon( #"disconnect" );
    player notify( #"tutorial_changed" );
    player endon( #"tutorial_changed" );
    
    if ( function_abaed5b5b01f5e28( player.current_tutorial ) )
    {
        function_729244fb63340d85( player ) notify( #"tutorial_changed" );
    }
    
    thread function_ee1d3936eb6e1e03( player, new_tutorial_struct );
    
    if ( var_21904a198ae4f24e )
    {
        player allowmovement( 0 );
        function_3f46a4fd28a17454( player, new_tutorial_struct );
        function_48b7033aa12c2f72( function_abaed5b5b01f5e28( player.current_tutorial ) ? function_729244fb63340d85( player ) : player, new_tutorial_struct.transition_fade_in_time );
        wait new_tutorial_struct.transition_fade_in_time;
        player setvelocity( ( 0, 0, 0 ) );
    }
    
    var_73d6e8949482c08c = function_abaed5b5b01f5e28( new_tutorial_struct );
    
    if ( isdefined( player.current_tutorial ) )
    {
        profilestart();
        function_bb59f9b0bdf2d248( player, player.current_tutorial, 0 );
        [[ player.current_tutorial.oncleanup ]]( function_abaed5b5b01f5e28( player.current_tutorial ) ? function_729244fb63340d85( player ) : player, player.current_tutorial );
        profilestop();
        
        if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && function_abaed5b5b01f5e28( player.current_tutorial ) )
        {
            should_spawn_player = !var_2b4b07109454f1e4;
            function_1df2d986a2f9e167( function_729244fb63340d85( player ), player.current_tutorial, should_spawn_player, 0 );
            
            if ( should_spawn_player )
            {
                waitforplayerspawned( player );
            }
        }
        
        /#
            iprintln( "<dev string:x13a>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
        #/
    }
    
    /#
        iprintln( "<dev string:x144>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
    #/
    
    function_c06c98d7da9ead59( player );
    player setclientomnvar( "training_course_current_station_unique_id", function_8b878dec24bedc0e( new_tutorial_struct ) );
    player setclientomnvar( "training_course_current_station_type", function_87ff4a0d38e17094( new_tutorial_struct ) );
    player setclientomnvar( "is_in_training_course_tutorial_station", 1 );
    player setclientomnvar( "current_tutorial_has_preview", getdvarint( @"hash_5bb18d4eb7794e87" ) && isdefined( new_tutorial_struct.var_fe1e173811f47789 ) );
    player setclientomnvar( "training_course_station_supports_instructions", function_655349246b97b3a1( new_tutorial_struct ) );
    function_cc9a85feed9c8e34( player, new_tutorial_struct );
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable hide();
    }
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && var_2b4b07109454f1e4 )
    {
        preview_bot = function_729244fb63340d85( player );
        function_d7da7bef32a55e59( player, preview_bot, new_tutorial_struct );
        player = preview_bot;
    }
    
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapon.basename != "none" )
        {
            player setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
    }
    
    player.health = player.maxhealth;
    player freezecontrols( 1 );
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, new_tutorial_struct );
    }
    
    if ( isdefined( new_tutorial_struct.var_e7e7977f1d016e4c ) )
    {
        wait new_tutorial_struct.var_e7e7977f1d016e4c;
    }
    
    [[ new_tutorial_struct.onsetup ]]( player, new_tutorial_struct );
    
    if ( var_21904a198ae4f24e )
    {
        wait new_tutorial_struct.var_11b386f1f1fd262a;
        player setorigin( new_tutorial_struct.respawn_position );
        player setplayerangles( new_tutorial_struct.respawn_angles );
        outofbounds::enableoobimmunity( player );
        
        if ( !new_tutorial_struct.var_98cec33d0b4e8c5 )
        {
            player setstance( "stand", 1, 1 );
        }
    }
    
    function_bb59f9b0bdf2d248( player, new_tutorial_struct, 1 );
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && var_2b4b07109454f1e4 )
    {
        function_275e97f81427089d( new_tutorial_struct, player ) player::updatesessionstate( "spectator" );
    }
    
    if ( var_21904a198ae4f24e )
    {
        function_471eaf1a49ed9cc9( player, new_tutorial_struct.transition_fade_out_time );
        wait new_tutorial_struct.transition_fade_out_time;
    }
    
    outofbounds::function_9aa3ce7806e04201( player );
    player.current_tutorial = new_tutorial_struct;
    var_773e146ef834850 = !function_faefa119842f585b( new_tutorial_struct ) && isdefined( new_tutorial_struct.var_47eb83743fd1597 ) && !was_failed && !var_2b4b07109454f1e4 && !var_73d6e8949482c08c;
    
    if ( var_773e146ef834850 )
    {
        thread function_e79357e1bec9adad( player.npc_agent, new_tutorial_struct.var_47eb83743fd1597, 1 );
    }
    
    if ( var_67d56ce428f7a6f9 && function_655349246b97b3a1( new_tutorial_struct ) )
    {
        var_c387f9f8e6ada71d = function_275e97f81427089d( new_tutorial_struct, player );
        function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 1, !var_773e146ef834850 );
        new_tutorial_struct waittill( #"triptychs_training_course_station_start" );
        function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 0, 0 );
    }
    
    function_649644d8af5d56f( player, new_tutorial_struct );
    player freezecontrols( 0 );
    
    if ( !new_tutorial_struct.var_5a63045faffa8fee )
    {
        player allowmovement( 1 );
    }
    
    function_696273ac9d3bea25( new_tutorial_struct, 0, player );
    
    if ( isdefined( new_tutorial_struct.startlogic ) )
    {
        thread [[ new_tutorial_struct.startlogic ]]( player, new_tutorial_struct );
    }
    
    if ( !new_tutorial_struct.var_a5fd41050e0ceb34 && !was_failed )
    {
        player common_training_course::function_ae1b81443a485a25();
        player common_training_course::function_21095a8908de4687();
    }
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && var_2b4b07109454f1e4 )
    {
        function_a2935575b5b51ed6( player, new_tutorial_struct );
        
        if ( getdvarint( @"hash_a8d60dcb66f59524" ) )
        {
            thread function_b26daaaa9debed6e( player.spectating_player, new_tutorial_struct );
        }
    }
    
    if ( was_failed && !isbot( player ) && function_32d334aad6bf0ad3( new_tutorial_struct ) )
    {
        thread showfailhint( player, new_tutorial_struct );
    }
    
    if ( isbot( player ) )
    {
        thread function_fb78e7c7ad8e2157( player );
    }
    
    new_tutorial_struct notify( #"tutorial_started" );
    player playlocalsound( "uin_t10_training_course_tutorial_start" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x19d2376, Offset: 0x6b59
// Size: 0x7f
function private function_ee1d3936eb6e1e03( player, tutorial )
{
    player endon( #"tutorial_changed" );
    tutorial endon( #"tutorial_started" );
    player endon( #"disconnect" );
    
    if ( player::isreallyalive( player ) )
    {
        player waittill( #"death" );
    }
    
    while ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        if ( function_faa438d8de9a4dc9( player ) )
        {
            break;
        }
        
        waitframe();
    }
    
    thread exittutorial( player, tutorial, 1 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf72562e1, Offset: 0x6be0
// Size: 0x22a
function private onplayerrespawn( reviverespawn )
{
    player = self;
    thread giveloadoutonspawn( player );
    var_b138c7c63944889f = !isbot( player ) || function_abaed5b5b01f5e28( player.current_tutorial );
    
    if ( var_b138c7c63944889f && function_cbcead310c3cf8bd( player.current_tutorial ) )
    {
        wait player.current_tutorial.respawn_delay;
        
        if ( player.current_tutorial.fail_state == 1 )
        {
            thread exittutorial( player, player.current_tutorial, 1, &function_bf9f86692b45ce4 );
        }
        else
        {
            is_fail_state_spectate = player.current_tutorial.fail_state == 0;
            thread restarttutorial( isbot( player ) ? player.spectating_player : player, player.current_tutorial, is_fail_state_spectate, player.current_tutorial.fail_state == 2 || isbot( player ), 1, !is_fail_state_spectate && !isbot( player ) ? &function_bf9f86692b45ce4 : undefined );
            
            if ( isbot( player ) )
            {
                player playerlogic::spawnplayer( undefined, 0 );
            }
        }
        
        player.current_tutorial.fail_state = -1;
    }
    else
    {
        player playerlogic::spawnplayer( undefined, 0 );
        
        if ( !player.var_dc692e41504a9076 )
        {
            thread function_ddbdcc7435c44319( player, player.first_spawn_origin, player.first_spawn_angles );
            player.var_dc692e41504a9076 = 1;
        }
        else if ( isbot( player ) )
        {
            player setorigin( player.first_spawn_origin );
            function_f84dc38c3e66bb65( player );
            player playerhide();
        }
        
        if ( isdefined( player.skin_on_respawn ) )
        {
            setplayerviewmodel( player, player.skin_on_respawn );
        }
        
        if ( !isbot( player ) )
        {
            function_c06c98d7da9ead59( player );
        }
    }
    
    if ( !isbot( player ) )
    {
        thread function_fb78e7c7ad8e2157( player );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xdc38fd3d, Offset: 0x6e12
// Size: 0x31
function private giveloadoutonspawn( player )
{
    player endon( #"death_or_disconnect" );
    player waittill( #"giveloadout" );
    waitframe();
    thread function_2cb67c7fc6e3fed5( player );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xa152cc8b, Offset: 0x6e4b
// Size: 0x5a
function private function_ddbdcc7435c44319( player, origin, angles )
{
    player endon( #"death_or_disconnect" );
    wait 0.5;
    player setorigin( origin );
    player setplayerangles( angles );
    
    if ( isbot( player ) )
    {
        function_f84dc38c3e66bb65( player );
        player playerhide();
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe36d5d3f, Offset: 0x6ead
// Size: 0x6a
function private function_bf9f86692b45ce4( player, tutorial )
{
    assert( isdefined( tutorial ), "<dev string:x14e>" );
    player playerlogic::spawnplayer( undefined, 0 );
    player freezecontrols( 1 );
    function_3f46a4fd28a17454( player, tutorial );
    player setorigin( tutorial.respawn_position );
    player setplayerangles( tutorial.respawn_angles );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xa264567b, Offset: 0x6f1f
// Size: 0x81
function private trainingcourse_watchforplayerdeath( player, tutorial, var_b0168b4849ac579b )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player waittill( #"death", attacker );
    var_e1f0ee5f702d4e4f = isdefined( attacker ) && ( isagent( attacker ) || isbot( attacker ) );
    player failtutorial( player, tutorial, var_e1f0ee5f702d4e4f, var_b0168b4849ac579b );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x7c7bfafa, Offset: 0x6fa8
// Size: 0x30
function private function_275e97f81427089d( tutorial, player )
{
    return function_abaed5b5b01f5e28( tutorial ) ? player.spectating_player : player;
}

// Namespace t10_training_course
// Params 6, eflags: 0x4
// Checksum 0x46662158, Offset: 0x6fe1
// Size: 0xc2
function private restarttutorial( player, tutorial, var_2b4b07109454f1e4, var_67d56ce428f7a6f9, was_failed, var_1511c5590534bc27 = undefined )
{
    /#
        iprintln( "<dev string:x177>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    player notify( #"restart_tutorial" );
    player endon( #"restart_tutorial" );
    player endon( #"disconnect" );
    
    if ( outofbounds::isoob( player ) )
    {
        outofbounds::clearoob( player );
        outofbounds::enableoobimmunity( player );
    }
    
    function_696273ac9d3bea25( tutorial, 4, player );
    thread starttutorial( player, tutorial, var_67d56ce428f7a6f9, tutorial.var_daae47f54aee1cc3, var_2b4b07109454f1e4, was_failed, var_1511c5590534bc27 );
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0x754c3e2e, Offset: 0x70ab
// Size: 0x12a
function private failtutorial( player, tutorial, var_e1f0ee5f702d4e4f, var_b0168b4849ac579b )
{
    player notify( #"fail_tutorial" );
    player endon( #"fail_tutorial" );
    player endon( #"disconnect" );
    
    /#
        iprintln( "<dev string:x183>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_failed" );
    function_696273ac9d3bea25( tutorial, 1, player );
    
    if ( true )
    {
        function_3f46a4fd28a17454( player, tutorial );
    }
    
    if ( isdefined( tutorial.onfail ) )
    {
        thread [[ tutorial.onfail ]]( player, tutorial );
    }
    
    player.failed_attempts++;
    
    if ( isdefined( tutorial.var_8c2623b27b71c6bd ) )
    {
        thread function_e79357e1bec9adad( player.npc_agent, tutorial.var_8c2623b27b71c6bd, 1, 1 );
    }
    
    if ( var_e1f0ee5f702d4e4f && !function_32d334aad6bf0ad3( tutorial ) )
    {
        function_6c0ff087784b7b0( tutorial, var_b0168b4849ac579b ? &"t10_training_course/failhint_elimination_multiple_enemies" : &"t10_training_course/failhint_elimination_single_enemy" );
    }
    
    player playlocalsound( "uin_t10_training_course_tutorial_fail" );
}

// Namespace t10_training_course
// Params 6
// Checksum 0xf8e582bf, Offset: 0x71dd
// Size: 0x336
function exittutorial( player, tutorial, should_play_transition, var_1511c5590534bc27 = undefined, was_completed = 0, is_disconnecting = 0 )
{
    player endon( #"disconnect" );
    player notify( #"tutorial_changed" );
    player endon( #"tutorial_changed" );
    
    if ( function_abaed5b5b01f5e28( tutorial ) )
    {
        function_729244fb63340d85( player ) notify( #"tutorial_changed" );
    }
    
    player setclientomnvar( "is_in_training_course_tutorial_station", 0 );
    player setclientomnvar( "current_tutorial_has_preview", 0 );
    player setclientomnvar( "training_course_station_supports_instructions", 0 );
    function_696273ac9d3bea25( tutorial, 3, player );
    
    if ( should_play_transition )
    {
        function_3f46a4fd28a17454( player );
        player freezecontrols( 1 );
        function_48b7033aa12c2f72( function_abaed5b5b01f5e28( tutorial ) ? function_729244fb63340d85( player ) : player, tutorial.transition_fade_in_time );
        wait tutorial.transition_fade_in_time;
    }
    
    if ( function_faa438d8de9a4dc9( player ) )
    {
        function_dfb331efe033ac6c( player, tutorial, 0, 0 );
    }
    
    /#
        iprintln( "<dev string:x18c>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    profilestart();
    [[ tutorial.oncleanup ]]( function_abaed5b5b01f5e28( tutorial ) ? function_729244fb63340d85( player ) : player, tutorial );
    profilestop();
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && function_abaed5b5b01f5e28( tutorial ) )
    {
        function_1df2d986a2f9e167( function_729244fb63340d85( player ), tutorial, !is_disconnecting, is_disconnecting );
        
        if ( !is_disconnecting )
        {
            waitforplayerspawned( player );
        }
    }
    
    if ( isdefined( tutorial.onexit ) )
    {
        [[ tutorial.onexit ]]( function_abaed5b5b01f5e28( tutorial ) ? function_729244fb63340d85( player ) : player, tutorial );
    }
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, tutorial );
    }
    
    function_89df6b3aced6d8cd( player );
    function_bb59f9b0bdf2d248( player, tutorial, 0 );
    function_a028ec2a35d56827( player.map_instance_index );
    function_6c0ff087784b7b0( tutorial, undefined );
    
    if ( isdefined( player.leave_training_course_interactable ) )
    {
        player.leave_training_course_interactable show();
    }
    
    if ( should_play_transition )
    {
        function_c06c98d7da9ead59( player );
    }
    else if ( !is_disconnecting )
    {
        var_f9c5d2ee69430bbb = 202500;
        thread function_62c78e4f80649282( player, var_f9c5d2ee69430bbb );
    }
    
    if ( should_play_transition )
    {
        player setorigin( tutorial.respawn_position );
        player setplayerangles( tutorial.respawn_angles );
        player setstance( "stand", 1, 1 );
        function_471eaf1a49ed9cc9( player, tutorial.transition_fade_out_time );
        wait tutorial.transition_fade_out_time;
    }
    
    function_649644d8af5d56f( player );
    player freezecontrols( 0 );
    player allowmovement( 1 );
    outofbounds::function_9aa3ce7806e04201( player );
    player common_training_course::function_ae1b81443a485a25( was_completed, 0 );
    
    if ( player.current_tutorial === tutorial )
    {
        player.current_tutorial = undefined;
    }
    
    if ( player.training_course_completed )
    {
        function_ac53a17fd5b74658( player, &"t10_training_course/leave_training_course_hint" );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xd5f3847d, Offset: 0x751b
// Size: 0x47a
function private completetutorial( player, tutorial, var_cb54f480ed623755 = 1 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player notify( #"complete_tutorial" );
    player endon( #"complete_tutorial" );
    
    /#
        iprintln( "<dev string:x195>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_completed" );
    function_696273ac9d3bea25( tutorial, 2, player );
    
    if ( function_abaed5b5b01f5e28( tutorial ) )
    {
        wait 1;
        thread restarttutorial( function_275e97f81427089d( tutorial, player ), tutorial, 0, 1, 0, undefined );
        return;
    }
    
    if ( !function_faefa119842f585b( tutorial ) && isdefined( tutorial.var_366e9014d86d580a ) )
    {
        thread function_e79357e1bec9adad( player.npc_agent, tutorial.var_366e9014d86d580a, 1, 1.5 );
    }
    else if ( isdefined( tutorial.var_6caae9f87149260b ) )
    {
        thread function_e79357e1bec9adad( player.npc_agent, tutorial.var_6caae9f87149260b, 1, 1.5 );
    }
    
    tutorial.is_completed = 1;
    player setclientomnvar( "training_course_tutorial_completed", function_8b878dec24bedc0e( tutorial ) );
    
    if ( var_cb54f480ed623755 )
    {
        player hud_message::function_ccbbac80e736b9f9( "training_tutorial_completed", undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    var_3ef8077d0bfd5d0f = 0;
    var_d4ac22c68ea6d8c9 = 0;
    
    foreach ( other_tutorial in player.tutorial_dictionary )
    {
        if ( function_faefa119842f585b( other_tutorial ) )
        {
            var_3ef8077d0bfd5d0f++;
        }
    }
    
    if ( var_3ef8077d0bfd5d0f == player.tutorial_dictionary.size )
    {
        level callback::callback( #"hash_6c71d319dc089c27", { #player:player, #event:#"on_tutorial_completed" } );
        var_d4ac22c68ea6d8c9 = 1;
    }
    
    player.training_course_completed = var_d4ac22c68ea6d8c9;
    
    if ( getdvarint( @"hash_8e70563bddaf0da" ) )
    {
        emote_tutorial = player.tutorial_dictionary[ "emote" ];
        
        if ( function_3c77ed00cac74efe( emote_tutorial ) && !function_faefa119842f585b( emote_tutorial ) )
        {
            if ( var_3ef8077d0bfd5d0f == player.tutorial_dictionary.size - 1 )
            {
                function_bfa865dfd7b9bfd6( player, emote_tutorial, 0 );
                tutorials_to_add[ "emote" ] = emote_tutorial;
                thread function_dc85cd6a6bf80d4b( player, "bonus_tutorial_unlocked", 2 );
                thread function_e6c0ed093a236b20( player, 0, tutorials_to_add );
            }
        }
    }
    
    if ( player.var_bb4f4ac000751f63 == tutorial.order_number && !var_d4ac22c68ea6d8c9 )
    {
        for ( i = player.var_bb4f4ac000751f63 + 1; i < player.var_80e907d847fdb68c.size ; i++ )
        {
            if ( !function_faefa119842f585b( player.var_80e907d847fdb68c[ i ] ) )
            {
                player.var_bb4f4ac000751f63 = player.var_80e907d847fdb68c[ i ].order_number;
                break;
            }
        }
    }
    else if ( var_d4ac22c68ea6d8c9 )
    {
        player.var_bb4f4ac000751f63 = -1;
    }
    
    if ( var_d4ac22c68ea6d8c9 && !player.training_course_completed_vo_played )
    {
        var_d2eca20e13d16605 = 2;
        vos_aliases = [ "dx_mp_mptc_tiallcompleteln1_wood", "dx_mp_mptc_tiallcompleteln2_wood", "dx_mp_mptc_tiallcompletebetaln3_wood" ];
        thread function_e79357e1bec9adad( player.npc_agent, vos_aliases, 1, var_d2eca20e13d16605, 0.4 );
        thread function_dc85cd6a6bf80d4b( player, "training_course_completed", var_d2eca20e13d16605 );
        player.training_course_completed_vo_played = 1;
    }
    
    if ( getdvarint( @"hash_49befb9786f9fda" ) && !isdefined( player.leave_training_course_interactable ) && var_d4ac22c68ea6d8c9 )
    {
        thread function_5b3639edf841fc69( player, player.npc_agent, function_acd7b230b1df93c1( player.map_instance_index ) );
        function_f5f4ddfbfd8dee71( player );
    }
    
    thread exittutorial( player, tutorial, 0, undefined, 1 );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x548709c8, Offset: 0x799d
// Size: 0x5b
function private function_dc85cd6a6bf80d4b( player, splash_ref, delay )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait delay;
    player hud_message::function_ccbbac80e736b9f9( splash_ref, undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xeff168c8, Offset: 0x7a00
// Size: 0x145
function private function_d7da7bef32a55e59( player, bot, tutorial )
{
    tutorial.var_a5fd41050e0ceb34 = 1;
    bot playershow();
    
    if ( getdvarint( @"hash_27519d16bffbc440", 0 ) == 1 )
    {
        player freezecontrols( 0 );
        player allowmovement( 1 );
        player setclientomnvar( "ui_hide_hud", 1 );
        
        /#
            if ( !player isnoclip() )
            {
                player noclip();
            }
        #/
        
        player notify( #"enter_spectator_mode" );
    }
    else
    {
        spectatetargetentnum = bot getentitynumber();
        player.forcespectatorclient = spectatetargetentnum;
        player notify( #"enter_spectator_mode" );
    }
    
    bot.spectating_player = player;
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "dont_path_to_enemy", 1 );
    bot botsetflag( "disable_random_goal", 1 );
    bot botsetflag( "no_enemy_search", 1 );
    bot botsetflag( "disable_automatic_sprint", 1 );
    
    if ( isdefined( tutorial.var_3dcac807aca26fce ) )
    {
        profilestart();
        [[ tutorial.var_3dcac807aca26fce ]]( bot, tutorial );
        profilestop();
    }
    
    player thread function_193ffe26151ddf4c( tutorial );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x50b493d4, Offset: 0x7b4d
// Size: 0x35
function private function_a2935575b5b51ed6( bot, tutorial )
{
    if ( isdefined( tutorial.var_fe1e173811f47789 ) )
    {
        thread [[ tutorial.var_fe1e173811f47789 ]]( bot, tutorial );
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xd53768e3, Offset: 0x7b8a
// Size: 0x12f
function private function_1df2d986a2f9e167( bot, tutorial, should_spawn_player, is_disconnecting = 0 )
{
    bot notify( #"hash_27620d5c2e30b764" );
    tutorial.var_a5fd41050e0ceb34 = 0;
    
    if ( isdefined( tutorial.var_47f8fc3de4a91658 ) )
    {
        profilestart();
        [[ tutorial.var_47f8fc3de4a91658 ]]( bot, tutorial );
        profilestop();
    }
    
    spectating_player = bot.spectating_player;
    
    if ( !is_disconnecting )
    {
        bot botsetstance( "stand" );
        
        while ( ( function_ea0c6158d187ce84( bot ) || bot getstance() != "stand" ) && isalive( bot ) )
        {
            waitframe();
        }
        
        function_f84dc38c3e66bb65( bot );
        bot setorigin( function_d58310d0f1d16d43( ( -30556, -57117, 51 ), bot.map_instance_index ) );
        bot.spectating_player = undefined;
        bot playerhide();
    }
    
    if ( should_spawn_player && isdefined( spectating_player ) )
    {
        spectating_player playerlogic::removefromalivecount( 0 );
        thread giveloadoutonspawn( spectating_player );
        thread function_bf9f86692b45ce4( spectating_player, tutorial );
        thread function_fb78e7c7ad8e2157( spectating_player );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0xc
// Checksum 0x344a942a, Offset: 0x7cc1
// Size: 0x5b
function private function_193ffe26151ddf4c( tutorial )
{
    self notify( #"hash_c3cff4132630d520" );
    self endon( #"hash_c3cff4132630d520" );
    player = self;
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 45;
    player failtutorial( player, tutorial, 0, 0 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x38c349e0, Offset: 0x7d24
// Size: 0x15a
function private function_62c78e4f80649282( player, var_e3a1280cc76fafc8 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    corpses = function_955f614470e71cb2( player.origin, 4000, 1 );
    
    if ( corpses.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( index, corpse in corpses )
        {
            if ( !isdefined( corpse ) )
            {
                continue;
            }
            
            var_4a1e4cdbe9485a48 = vectornormalize( corpse.origin - player geteye() );
            dotproduct = vectordot( vectornormalize( anglestoforward( player.angles ) ), var_4a1e4cdbe9485a48 );
            
            if ( dotproduct < 0.5 && distancesquared( player.origin, corpse.origin ) >= var_e3a1280cc76fafc8 )
            {
                corpse delete();
                corpses[ index ] = undefined;
            }
        }
        
        if ( corpses.size == 0 )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x3b1d44b9, Offset: 0x7e86
// Size: 0x21
function private function_c06c98d7da9ead59( player )
{
    function_a62e9fb7be9ff0a6( player.origin, 4000, 1 );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xb13325ba, Offset: 0x7eaf
// Size: 0x71
function private function_696273ac9d3bea25( tutorial, new_state, player )
{
    function_df581661be9ca5c5( player );
    
    if ( function_1c1639bf73457e80( player ) )
    {
        function_5e3e773127f754db( player );
    }
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    if ( function_ce08700870078f55( player ) )
    {
        function_c58312077098c9c8( player );
    }
    
    tutorial.state = new_state;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x9abeb0e5, Offset: 0x7f28
// Size: 0x19, Type: bool
function private function_d1d2cf69e63f6596( tutorial )
{
    return tutorial.state == 0;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1a289cde, Offset: 0x7f4a
// Size: 0x1a, Type: bool
function private function_cbcead310c3cf8bd( tutorial )
{
    return tutorial.state == 1;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x8430d721, Offset: 0x7f6d
// Size: 0x1a, Type: bool
function private function_7bc1290560032d39( tutorial )
{
    return tutorial.state == 3;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x54aca8e2, Offset: 0x7f90
// Size: 0x2b, Type: bool
function private function_abaed5b5b01f5e28( tutorial )
{
    if ( !getdvarint( @"hash_5bb18d4eb7794e87" ) )
    {
        return false;
    }
    
    return istrue( tutorial.var_a5fd41050e0ceb34 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x777960be, Offset: 0x7fc4
// Size: 0x17
function private function_3c77ed00cac74efe( tutorial )
{
    return tutorial.is_locked;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x8f90df24, Offset: 0x7fe4
// Size: 0x17
function private function_faefa119842f585b( tutorial )
{
    return tutorial.is_completed;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe84f4c22, Offset: 0x8004
// Size: 0x17
function private function_655349246b97b3a1( tutorial )
{
    return tutorial.var_96e5beb113f41311;
}

// Namespace t10_training_course
// Params 1
// Checksum 0xfde3f3d4, Offset: 0x8024
// Size: 0x17
function function_399e310dabe4c2cc( tutorial )
{
    return tutorial.id_string;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1f1da75e, Offset: 0x8044
// Size: 0x17
function private function_87ff4a0d38e17094( tutorial )
{
    return tutorial.tutorial_type;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x24206912, Offset: 0x8064
// Size: 0x17
function private function_8b878dec24bedc0e( tutorial )
{
    return tutorial.var_81173965ad64569;
}

// Namespace t10_training_course
// Params 8, eflags: 0x4
// Checksum 0x84c26688, Offset: 0x8084
// Size: 0x252
function private spawnagent( origin, angles, health, team, add_outline = 0, body_model = %"c_t10_gbl_opforce_pantheon_body_3", head_model = %"head_sc_m_colvin", hat_model = %"c_t10_gbl_opforce_pantheon_ast_head_2" )
{
    agent = mp_agent::spawnnewagentaitype( "enemy_mp_benchmark_base", origin, angles );
    agent.team = team;
    agent.health = health;
    agent.cannotmelee = 1;
    agent.disablebulletwhizbyreaction = 1;
    agent setcanusecover( 0 );
    agent.runngunenabled = 0;
    agent.disabledodge = 1;
    agent.aggressivemode = 0;
    agent.var_63f1ffef1eafa4e4 = 1;
    agent.allowlongdeath = 0;
    agent.agent_damage_callback = &function_2d459ce49ce8b45e;
    agent.var_1bf926518b0cb33 = 1;
    agent.allowpain = 0;
    agent.agentdamagefeedback = 1;
    agent enabletraversals( 0 );
    agent utility::set_movement_speed( 0 );
    agent.scripted_mode = 1;
    agent.ignoreme = 1;
    agent agent_utils::ai_blockexecution( 1 );
    
    if ( add_outline )
    {
        outline::outlineenableforall( agent, "outline_nodepth_red", "level_script" );
    }
    
    if ( isdefined( agent.headmodel ) )
    {
        agent detach( agent.headmodel );
        agent.headmodel = undefined;
    }
    
    if ( isdefined( agent.hatmodel ) )
    {
        agent detach( agent.hatmodel );
        agent.hatmodel = undefined;
    }
    
    agent setmodel( body_model );
    agent attach( head_model, "", 1 );
    agent.headmodel = head_model;
    
    if ( hat_model != "" )
    {
        agent attach( hat_model, "", 1 );
        agent.hatmodel = hat_model;
    }
    
    return agent;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xa6387acb, Offset: 0x82df
// Size: 0x1e
function private despawnagent( agent )
{
    if ( isalive( agent ) )
    {
        agent agent_utils::despawnagent();
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x8d2e0e11, Offset: 0x8305
// Size: 0x14c
function private spawnnpc( player, origin, angles )
{
    woods_model = spawn( "script_model", origin );
    woods_model setmodel( "fullbody_mp_hero_wood_training_course" );
    woods_model.targetname = "yanim_Woods";
    woods_model solid();
    woods_model.script_animname = woods_model.targetname;
    woods_model.team = player.team;
    wheelchair = spawn( "script_model", origin );
    wheelchair setmodel( "c_t10_usa_hero_woods_safehouse_wheelchair_01_anim" );
    wheelchair.targetname = "yanim_Wheelchair";
    wheelchair.script_animname = wheelchair.targetname;
    wheelchair solid();
    woods_model.wheelchair = wheelchair;
    var_5c11ace5ae14ad8 = spawn( "script_model", origin );
    var_5c11ace5ae14ad8 setmodel( "wpn_wm_p01_ar_coslo723_training_course" );
    var_5c11ace5ae14ad8.targetname = "yanim_Gun";
    var_5c11ace5ae14ad8.script_animname = var_5c11ace5ae14ad8.targetname;
    var_5c11ace5ae14ad8 solid();
    var_5c11ace5ae14ad8 hide();
    woods_model.var_5c11ace5ae14ad8 = var_5c11ace5ae14ad8;
    return woods_model;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x56c60437, Offset: 0x845a
// Size: 0xa4
function private function_f5f4ddfbfd8dee71( player )
{
    if ( getdvarint( @"hash_49befb9786f9fda" ) && !isdefined( player.leave_training_course_interactable ) )
    {
        leave_training_course_interactable = spawn( "script_model", function_d58310d0f1d16d43( ( -30411, -57290, 272 ), player.map_instance_index ) );
        leave_training_course_interactable makeusable();
        leave_training_course_interactable setuserange( 100 );
        leave_training_course_interactable sethintstring( &"t10_training_course/leave_training_course" );
        leave_training_course_interactable setcursorhint( "HINT_NOICON" );
        player.leave_training_course_interactable = leave_training_course_interactable;
        thread function_312ad34cc38979e4( leave_training_course_interactable, player );
    }
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x873188d, Offset: 0x8506
// Size: 0x8a
function private function_cf5c6d1b5b216a8e()
{
    return [ "dx_bc_panc_tcac_pan1_moving", "dx_bc_panc_tcac_pan2_moving", "dx_bc_panc_tcac_pan3_moving", "dx_bc_panc_tcac_pan1_immoving", "dx_bc_panc_tcac_pan2_immoving", "dx_bc_panc_tcac_pan3_immoving", "dx_bc_panc_tcac_pan1_pushingup", "dx_bc_panc_tcac_pan2_pushingup", "dx_bc_panc_tcac_pan3_pushingup", "dx_bc_panc_tcac_pan1_pushingforward", "dx_bc_panc_tcac_pan2_pushingforward", "dx_bc_panc_tcac_pan3_pushingforward", "dx_bc_panc_tcac_pan1_movingup", "dx_bc_panc_tcac_pan2_movingup", "dx_bc_panc_tcac_pan3_movingup" ];
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x27c88832, Offset: 0x8599
// Size: 0x97
function private function_f7e26bf874373e37( player, entity, shader, alpha = 1, y_offset = 0 )
{
    pingmarker = newclienthudelem( player );
    pingmarker.alpha = alpha;
    pingmarker setshader( shader, 128, 128 );
    pingmarker setwaypoint( 1, 1, 0, 0 );
    pingmarker linkwaypointtotargetwithoffset( entity, ( 0, 0, y_offset ) );
    entity.pingmarker = pingmarker;
    return pingmarker;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x3a05a121, Offset: 0x8639
// Size: 0x23
function private function_b3d358f2f43b564c( agent, value )
{
    agent.magicbulletshield = value;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xa5b41d74, Offset: 0x8664
// Size: 0x8c
function private function_d42a29e61dd9e610( agent, player, damage_amount )
{
    player endon( #"tutorial_changed" );
    agent endon( #"death" );
    player endon( #"death_or_disconnect" );
    
    if ( !agent tagexists( "tag_flash" ) )
    {
        return;
    }
    
    function_bc2d17578622fd93( agent, player, 0 );
    wait 0.2;
    player dodamage( damage_amount, agent.origin, agent, undefined, "MOD_RIFLE_BULLET", agent.primaryweapon );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x9f234019, Offset: 0x86f8
// Size: 0xa9
function private function_bc2d17578622fd93( agent, player, var_c970e33ca7a31862 )
{
    start = agent gettagorigin( "tag_flash" );
    var_47da99db0bfbb09c = agent gettagangles( "tag_flash" );
    playfx( utility::getfx( "vfx_muzzle_flash" ), start, anglestoforward( var_47da99db0bfbb09c ), anglestoup( var_47da99db0bfbb09c ) );
    agent shoot( 0, player, 1, 0, 1 );
    
    if ( var_c970e33ca7a31862 )
    {
        magicbullet( agent.primaryweapon, start, player.origin + ( 0, 0, 15 ), agent );
    }
}

// Namespace t10_training_course
// Params 14, eflags: 0x4
// Checksum 0xe4f361fe, Offset: 0x87a9
// Size: 0xb2
function private function_2d459ce49ce8b45e( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( !utility::isbulletdamage( smeansofdeath ) )
    {
        return 0;
    }
    
    if ( self.magicbulletshield )
    {
        return 0;
    }
    
    if ( isdefined( eattacker ) && !isalive( eattacker ) )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x6029b5bb, Offset: 0x8864
// Size: 0x3b3
function private function_ae016fbb20adb105( player, tutorial )
{
    check_trigger = createboxtrigger( tutorial, function_d58310d0f1d16d43( ( -30930, -55714, 550 ), player.map_instance_index ), ( 500, 700, 300 ), function_2e52e3ebd7fff7bd( ( 0, 63, 0 ), player.map_instance_index ), &function_97b4b72d99c66553, &function_3bc0be874c9ed24b );
    registertrigger( player, check_trigger );
    tutorial.check_trigger = check_trigger;
    safe_zone_trigger = createboxtrigger( tutorial, function_d58310d0f1d16d43( ( -31095, -55965, 500 ), player.map_instance_index ), ( 150, 200, 200 ), function_2e52e3ebd7fff7bd( ( 0, 63, 0 ), player.map_instance_index ), &function_ed92bfe1e67f461e, &function_23456c4df141a2c6 );
    registertrigger( player, safe_zone_trigger );
    tutorial.safe_zone_trigger = safe_zone_trigger;
    var_a60d52ae60ebda9d = [ [ ( -30606, -55982, 432 ), ( 0, -158, 0 ) ], [ ( -31305, -55647, 431 ), ( 0, -25, 0 ) ] ];
    tutorial.agents = [];
    
    foreach ( agent_info in var_a60d52ae60ebda9d )
    {
        [ agent_origin, agent_angles ] = function_52ff81cfdbb3f234( agent_info[ 0 ], agent_info[ 1 ], player.map_instance_index );
        agent = spawnagent( agent_origin, agent_angles, 100, team_utility::getotherteam( player.team ), 1 );
        agent.favoriteenemy = player;
        function_b3d358f2f43b564c( agent, 1 );
        tutorial.agents[ tutorial.agents.size ] = agent;
    }
    
    tutorial.var_5ddd4633563c955f = 0;
    var_8a267dc1015aba9 = [ function_d58310d0f1d16d43( ( -30972, -55926, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30722, -56040, 440 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30618, -55813, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -30880, -55719, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31239, -55563, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31333, -55753, 432 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31145, -55844, 432 ), player.map_instance_index ) ];
    tutorial.chevrons = function_c2bdaa68bf39d803( "cer_gamemode_chevron", 150, var_8a267dc1015aba9, 0 );
    thread trainingcourse_watchforplayerdeath( player, tutorial, tutorial.agents.size > 1 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xfa8020c6, Offset: 0x8c1f
// Size: 0xf9
function private function_55af82327485d2e4( player, tutorial )
{
    deregistertrigger( player, tutorial.check_trigger );
    tutorial.check_trigger = undefined;
    deregistertrigger( player, tutorial.safe_zone_trigger );
    tutorial.safe_zone_trigger = undefined;
    
    foreach ( agent in tutorial.agents )
    {
        despawnagent( agent );
        agent = undefined;
    }
    
    tutorial.agents = undefined;
    deletechevrons( tutorial.chevrons );
    tutorial.chevrons = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xfd387863, Offset: 0x8d20
// Size: 0x38
function private function_23db93ff6b44493c( player, tutorial )
{
    function_1ba47b7678db87c3( tutorial.chevrons, function_74fb2b19273b495a( player.team ) );
}

// Namespace t10_training_course
// Params 2, eflags: 0xc
// Checksum 0xe438af3a, Offset: 0x8d60
// Size: 0x173
function private function_97b4b72d99c66553( player, tutorial )
{
    self notify( #"hash_d0eaa45a985000c8" );
    self endon( #"hash_d0eaa45a985000c8" );
    player endon( #"disconnect" );
    var_390167bbd00e2014 = player issprintsliding() || player isdiving();
    is_sprinting = player issprinting();
    
    foreach ( agent in tutorial.agents )
    {
        if ( var_390167bbd00e2014 )
        {
            function_b3d358f2f43b564c( agent, 0 );
        }
        
        agent thread function_8828f43defef11cf( player, var_390167bbd00e2014, tutorial );
        agent thread function_ca553e3a5021e06( player, tutorial );
    }
    
    if ( !is_sprinting && !var_390167bbd00e2014 )
    {
        function_6c0ff087784b7b0( tutorial, &"t10_training_course/slide_or_dive_failhint_need_sprint" );
    }
    else if ( !var_390167bbd00e2014 )
    {
        function_6c0ff087784b7b0( tutorial, &"t10_training_course/slide_or_dive_failhint_need_slide_dive" );
    }
    
    thread function_1ba47b7678db87c3( tutorial.chevrons, var_390167bbd00e2014 ? function_d7e4d4b8d06945ac( player.team ) : function_74fb2b19273b495a( player.team ) );
}

// Namespace t10_training_course
// Params 2, eflags: 0xc
// Checksum 0x45318a67, Offset: 0x8edb
// Size: 0x106
function private function_3bc0be874c9ed24b( player, tutorial )
{
    self notify( #"hash_a8aa56010a4eda29" );
    self endon( #"hash_a8aa56010a4eda29" );
    player endon( #"disconnect" );
    
    if ( !tutorial.var_5ddd4633563c955f )
    {
        player kill( undefined, undefined, undefined, "MOD_SUICIDE" );
    }
    else
    {
        thread function_1ba47b7678db87c3( tutorial.chevrons, "idle" );
    }
    
    foreach ( agent in tutorial.agents )
    {
        function_b3d358f2f43b564c( agent, 1 );
    }
    
    function_6c0ff087784b7b0( tutorial, undefined );
    player notify( #"hash_12243425dc4fe422" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x10096a53, Offset: 0x8fe9
// Size: 0x23
function private function_ed92bfe1e67f461e( player, tutorial )
{
    tutorial.var_5ddd4633563c955f = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xd633558b, Offset: 0x9014
// Size: 0x22
function private function_23456c4df141a2c6( player, tutorial )
{
    tutorial.var_5ddd4633563c955f = 0;
}

// Namespace t10_training_course
// Params 3, eflags: 0xc
// Checksum 0x9c54a99e, Offset: 0x903e
// Size: 0x8e
function private function_8828f43defef11cf( player, success, tutorial )
{
    self notify( #"hash_9f3832391dc78ba4" );
    self endon( #"hash_9f3832391dc78ba4" );
    player endon( #"hash_12243425dc4fe422" );
    player endon( #"tutorial_changed" );
    self endon( #"death" );
    player endon( #"disconnect" );
    childthread function_2e48a30dec1b5d77( player, self, success, 4.5, 0.5, 40, 300, 0.2, 0.4 );
}

// Namespace t10_training_course
// Params 9, eflags: 0x4
// Checksum 0x2571ca2e, Offset: 0x90d4
// Size: 0xf1
function private function_2e48a30dec1b5d77( player, agent, success, success_wait_time, fail_wait_time, success_damage, fail_damage, var_526b354c2ff59e1, var_54aa554c327b5cf )
{
    player endon( #"tutorial_changed" );
    agent endon( #"death" );
    player endon( #"disconnect" );
    wait success ? success_wait_time : fail_wait_time;
    
    while ( true )
    {
        trace = trace::ray_trace( agent geteye(), player geteye(), agent, undefined );
        
        if ( trace[ "entity" ] === player )
        {
            var_65c55325765f1984 = success ? success_damage : fail_damage;
            thread function_d42a29e61dd9e610( agent, player, var_65c55325765f1984 );
            
            if ( isalive( player ) )
            {
                wait randomfloatrange( var_526b354c2ff59e1, var_54aa554c327b5cf );
            }
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xa9fa5892, Offset: 0x91cd
// Size: 0x80
function private function_ca553e3a5021e06( player, tutorial )
{
    player endon( #"hash_12243425dc4fe422" );
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    self waittill( #"death" );
    tutorial.agents = arrayremove( tutorial.agents, self );
    
    if ( tutorial.agents.size == 0 )
    {
        thread completetutorial( player, tutorial );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x5b2b44af, Offset: 0x9255
// Size: 0x8f
function private function_bcbedc2c163b2e23( bot, tutorial )
{
    tutorial.var_78b3e67d2b80f6f3 = function_d58310d0f1d16d43( ( -30958, -55645, 450 ), bot.map_instance_index );
    bot botsetflag( "force_sprint", 1 );
    bot setinfiniteammo( 1 );
    bot allowstand( 1 );
    bot allowcrouch( 1 );
    bot botsetflag( "disable_rotation", 0 );
    bot botlookatpoint( tutorial.var_78b3e67d2b80f6f3, 9999, "script_forced" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x6feb8dca, Offset: 0x92ec
// Size: 0x58
function private function_d241a4a189571057( bot, tutorial )
{
    bot setinfiniteammo( 0 );
    bot botclearbutton( "ads" );
    bot botclearbutton( "sprint" );
    bot botclearbutton( "dtp" );
    bot botsetstance( "stand" );
    tutorial.var_78b3e67d2b80f6f3 = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x564a214f, Offset: 0x934c
// Size: 0x204
function private function_c5d8bcb7c892ea86( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    var_1e5b8aecbf5112ab = vectortoangles( tutorial.var_78b3e67d2b80f6f3 - bot.origin )[ 1 ];
    wait 0.5;
    bot botsetflag( "disable_movement", 0 );
    bot botsetscriptmove( var_1e5b8aecbf5112ab, 9999, 1 );
    bot botpressbutton( "sprint" );
    wait 0.1;
    bot botpressbutton( "sprint", 2 );
    wait 1;
    bot botlookatpoint( tutorial.agents[ 0 ] getorigin() + ( 0, 0, 50 ), 9999, "script_forced" );
    bot botpressbutton( getdvarint( @"hash_8d82e300c99f95b0" ) ? "dtp" : "slide", 1.5 );
    wait 0.3;
    bot botpressbutton( "ads", 9999 );
    wait 0.7;
    bot botsetflag( "disable_movement", 1 );
    bot botsetstance( getdvarint( @"hash_8d82e300c99f95b0" ) ? "prone" : "crouch" );
    
    foreach ( agent in tutorial.agents )
    {
        bot botlookatpoint( agent getorigin() + ( 0, 0, 50 ), 9999, "script_forced" );
        wait 1.3;
        thread function_bf3e729263fcc10( bot, agent, 0 );
        agent waittill( #"death" );
    }
    
    wait 0.5;
    bot botclearbutton( "ads" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x7bd14e08, Offset: 0x9558
// Size: 0x43f
function private function_631045c1a2853fba( player, tutorial )
{
    dive_trigger = createboxtrigger( tutorial, function_d58310d0f1d16d43( ( -31358, -54727, 430 ), player.map_instance_index ), ( 100, 650, 120 ), function_2e52e3ebd7fff7bd( ( 0, 160, 0 ), player.map_instance_index ), &function_fd14b80c6cdc8a15 );
    registertrigger( player, dive_trigger );
    tutorial.dive_trigger = dive_trigger;
    land_trigger = createboxtrigger( tutorial, function_d58310d0f1d16d43( ( -31630, -54655, 350 ), player.map_instance_index ), ( 650, 650, 200 ), function_2e52e3ebd7fff7bd( ( 0, 160, 0 ), player.map_instance_index ), &function_d7253506fda56512, &function_16a890d64b505684 );
    registertrigger( player, land_trigger );
    tutorial.land_trigger = land_trigger;
    tutorial.var_1c2909d1156f1116 = 0;
    tutorial.forward_vector = vectornormalize( anglestoforward( function_2e52e3ebd7fff7bd( ( 0, 160, 0 ), player.map_instance_index ) ) );
    tutorial.is_diving_forward = 0;
    tutorial.var_cd046470a943fa22 = 0;
    [ enemy_origin, enemy_angles ] = function_52ff81cfdbb3f234( ( -31348, -54897, 433 ), ( 0, 132, 0 ), player.map_instance_index );
    agent = spawnagent( enemy_origin, enemy_angles, 100, team_utility::getotherteam( player.team ), 1 );
    agent.favoriteenemy = player;
    agent.ignoreall = 1;
    function_b3d358f2f43b564c( agent, 1 );
    tutorial.agent = agent;
    var_8a267dc1015aba9 = [ function_d58310d0f1d16d43( ( -31441, -54950, 293 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31687, -54895, 289 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31869, -54801, 288 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31820, -54473, 288 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31762, -54248, 293 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31690, -54393, 296 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31563, -54433, 304 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31502, -54527, 290 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31379, -54560, 291 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31396, -54679, 288 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31335, -54709, 288 ), player.map_instance_index ) ];
    tutorial.chevrons = function_c2bdaa68bf39d803( "cer_gamemode_chevron", 150, var_8a267dc1015aba9, 1 );
    chevron_line = function_81f25287b76e02b2( "cer_gamemode_chevron", 150, function_d58310d0f1d16d43( ( -31213, -54642, 434 ), player.map_instance_index ), function_d58310d0f1d16d43( ( -31273, -54862, 434 ), player.map_instance_index ), function_2e52e3ebd7fff7bd( ( 0, 160, 0 ), player.map_instance_index ) );
    tutorial.chevrons = arraycombine( tutorial.chevrons, chevron_line );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xf6971fe0, Offset: 0x999f
// Size: 0x40
function private function_2f5e16214c686e52( player, tutorial )
{
    thread function_2e8b107b3527be5a( player, tutorial );
    thread function_c0da044128a303ff( player, tutorial.agent, tutorial );
    thread trainingcourse_watchforplayerdeath( player, tutorial, 0 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x826fb2d3, Offset: 0x99e7
// Size: 0x8d
function private function_84a52c739235b76f( player, tutorial )
{
    deregistertrigger( player, tutorial.dive_trigger );
    tutorial.dive_trigger = undefined;
    deregistertrigger( player, tutorial.land_trigger );
    tutorial.land_trigger = undefined;
    despawnagent( tutorial.agent );
    tutorial.agent = undefined;
    deletechevrons( tutorial.chevrons );
    tutorial.chevrons = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x59042610, Offset: 0x9a7c
// Size: 0x38
function private function_486d9ca550880281( player, tutorial )
{
    function_1ba47b7678db87c3( tutorial.chevrons, function_74fb2b19273b495a( player.team ) );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe9e4ae5c, Offset: 0x9abc
// Size: 0xca
function private function_2e8b107b3527be5a( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    var_fbf1b93284f6f86b = 0;
    isdiving = 0;
    
    while ( true )
    {
        isdiving = player isdiving();
        
        if ( isdiving )
        {
            if ( !var_fbf1b93284f6f86b )
            {
                var_21c78747c1375c9b = vectornormalize( anglestoforward( player getplayerangles() ) );
                vector_difference = vectordot( tutorial.forward_vector, var_21c78747c1375c9b );
                tutorial.is_diving_forward = vector_difference > 0.4;
                var_fbf1b93284f6f86b = 1;
            }
        }
        
        if ( var_fbf1b93284f6f86b && !isdiving )
        {
            var_fbf1b93284f6f86b = 0;
            tutorial.is_diving_forward = 0;
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xcd12e0fd, Offset: 0x9b8e
// Size: 0x5b
function private function_fd14b80c6cdc8a15( player, tutorial )
{
    player endon( #"disconnect" );
    tutorial.var_1c2909d1156f1116 = player isdiving() && tutorial.is_diving_forward;
    
    if ( tutorial.var_1c2909d1156f1116 )
    {
        thread function_9be310fb7d8f256b( player, tutorial );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x32aa153e, Offset: 0x9bf1
// Size: 0x112
function private function_9be310fb7d8f256b( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"hash_690325f9e97e43c2" );
    player endon( #"death_or_disconnect" );
    tutorial.agent endon( #"death" );
    
    while ( true )
    {
        var_21c78747c1375c9b = vectornormalize( anglestoforward( player getplayerangles() ) );
        vector_difference = vectordot( tutorial.forward_vector, var_21c78747c1375c9b );
        var_cd046470a943fa22 = vector_difference < -0.65;
        
        if ( var_cd046470a943fa22 != tutorial.var_cd046470a943fa22 )
        {
            function_b3d358f2f43b564c( tutorial.agent, !var_cd046470a943fa22 );
            function_1ba47b7678db87c3( tutorial.chevrons, var_cd046470a943fa22 ? function_d7e4d4b8d06945ac( player.team ) : function_74fb2b19273b495a( player.team ) );
            tutorial.var_cd046470a943fa22 = var_cd046470a943fa22;
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb75d8214, Offset: 0x9d0b
// Size: 0x149
function private function_d7253506fda56512( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_27620d5c2e30b764" );
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    player notify( #"hash_690325f9e97e43c2" );
    agent = tutorial.agent;
    agent.ignoreall = 0;
    agent.favoriteenemy = player;
    agent ai_lookat::enablelookatentity( player, 0, 1 );
    success = tutorial.var_1c2909d1156f1116 && tutorial.var_cd046470a943fa22;
    thread function_2e48a30dec1b5d77( player, agent, success, 3, 0.5, 40, 300, 0.2, 0.4 );
    
    if ( !success )
    {
        function_1ba47b7678db87c3( tutorial.chevrons, function_74fb2b19273b495a( player.team ) );
        
        if ( !tutorial.var_1c2909d1156f1116 )
        {
            function_6c0ff087784b7b0( tutorial, &"t10_training_course/180_dive_failhint_need_dive" );
            return;
        }
        
        if ( !tutorial.var_cd046470a943fa22 )
        {
            function_6c0ff087784b7b0( tutorial, &"t10_training_course/180_dive_failhint_need_180" );
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x35d4bc21, Offset: 0x9e5c
// Size: 0x3c
function private function_16a890d64b505684( player, tutorial )
{
    player endon( #"disconnect" );
    
    if ( function_d1d2cf69e63f6596( tutorial ) )
    {
        player kill( undefined, undefined, undefined, "MOD_SUICIDE" );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x3cf4d1c5, Offset: 0x9ea0
// Size: 0x50
function private function_c0da044128a303ff( player, agent, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    agent waittill( #"death" );
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xfa5d4775, Offset: 0x9ef8
// Size: 0x95
function private function_7c994beb5fedb5a0( bot, tutorial )
{
    bot setorigin( tutorial.respawn_position );
    bot setplayerangles( tutorial.respawn_angles );
    bot botsetstance( "stand" );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "force_sprint", 1 );
    bot botsetflag( "disable_attack", 0 );
    bot setinfiniteammo( 1 );
    bot allowreload( 0 );
    bot allowjump( 0 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x8789ffb0, Offset: 0x9f95
// Size: 0x163
function private function_7bfc484c8ee7b93f( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    wait 1;
    forward = vectornormalize( anglestoforward( tutorial.respawn_angles ) );
    look_at_point = tutorial.respawn_position + forward * 500;
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botlookatpoint( look_at_point, 9999, "script_forced" );
    bot botsetscriptmove( tutorial.respawn_angles[ 1 ], 9999, 1 );
    bot botpressbutton( "sprint" );
    wait 0.1;
    bot botpressbutton( "sprint" );
    wait 0.9;
    bot botpressbutton( "dtp" );
    wait 0.1;
    bot botlookatpoint( tutorial.agent.origin + ( 0, 0, 50 ), 9999, "script_forced" );
    wait 0.6;
    bot botsetflag( "disable_movement", 1 );
    bot botsetstance( "prone" );
    wait 0.5;
    bot botpressbutton( "ads", 2 );
    thread function_bf3e729263fcc10( bot, tutorial.agent, 1 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe5f86cb2, Offset: 0xa100
// Size: 0x47
function private function_bff8805add7b8bde( bot, tutorial )
{
    bot allowreload( 1 );
    bot allowjump( 1 );
    bot setstance( "stand" );
    bot setinfiniteammo( 0 );
    bot botclearbutton( "ads" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x22721ac, Offset: 0xa14f
// Size: 0xf3
function private function_f13c6bd826756699( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player freezecontrols( 0 );
    player setvelocity( ( 0, 0, 0 ) );
    player allowfire( 0 );
    player allowjump( 0 );
    player freezelookcontrols( 1 );
    player setstance( "stand", 1, 1 );
    wait 1;
    player setplayerangles( tutorial.respawn_angles + ( 0, 180, 0 ), 1 );
    player allowstand( 0 );
    player allowcrouch( 0 );
    player setstance( "prone", 1, 1 );
    wait 1;
    player setplayerangles( tutorial.respawn_angles, 1 );
    player setorigin( tutorial.respawn_position );
    player freezelookcontrols( 0 );
    player allowfire( 1 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x734de3b2, Offset: 0xa24a
// Size: 0x2c6
function private function_9899af1f5993873d( player, tutorial )
{
    thread function_f13c6bd826756699( player, tutorial );
    var_fa1682f37c16669 = [ [ ( -30899, -55101, 112 ), ( -31284, -55262, 112 ), 1, 5, 200 ], [ ( -31645, -56029, 608 ), ( -31754, -55972, 608 ), 3, 5, 150 ], [ ( -32079, -55781, 127 ), ( -32168, -55542, 112 ), 3, 5, 150 ], [ ( -31166, -55005, 431 ), ( -31398, -55253, 434 ), 2, 5, 150 ], [ ( -31430, -54762, 288 ), ( -31465, -54953, 288 ), 3, 5, 150 ], [ ( -31984, -54705, 249 ), ( -32050, -54823, 162 ), 1, 5, 300 ] ];
    tutorial.currently_spawned_agents = [];
    tutorial.enemy_waypoint_markers = [];
    tutorial.enemy_spawner_structs = [];
    
    for ( i = 0; i < var_fa1682f37c16669.size ; i++ )
    {
        spawn_origin = function_d58310d0f1d16d43( var_fa1682f37c16669[ i ][ 0 ], player.map_instance_index );
        destination_origin = function_d58310d0f1d16d43( var_fa1682f37c16669[ i ][ 1 ], player.map_instance_index );
        time_to_spawn = var_fa1682f37c16669[ i ][ 2 ];
        var_5d6d97b7627a3c45 = var_fa1682f37c16669[ i ][ 3 ];
        movement_speed = var_fa1682f37c16669[ i ][ 4 ];
        spawn_angles = ( 0, vectortoangles( destination_origin - spawn_origin )[ 1 ], 0 );
        struct = { #movement_speed:movement_speed, #var_5d6d97b7627a3c45:var_5d6d97b7627a3c45, #time_to_spawn:time_to_spawn, #spawn_angles:spawn_angles, #destination_origin:destination_origin, #spawn_origin:spawn_origin };
        tutorial.enemy_spawner_structs[ tutorial.enemy_spawner_structs.size ] = struct;
    }
    
    tutorial.var_52d61057297d7e25 = 0;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x80d5fd87, Offset: 0xa518
// Size: 0x166
function private function_6f5ee852e56ce6dc( player, tutorial )
{
    foreach ( agent in tutorial.currently_spawned_agents )
    {
        despawnagent( agent );
        agent = undefined;
    }
    
    foreach ( marker in tutorial.enemy_waypoint_markers )
    {
        if ( isdefined( marker ) )
        {
            marker destroy();
            marker = undefined;
        }
    }
    
    tutorial.enemy_waypoint_markers = [];
    tutorial.enemy_waypoint_markers = undefined;
    tutorial.currently_spawned_agents = [];
    tutorial.currently_spawned_agents = undefined;
    tutorial.enemy_spawner_structs = [];
    tutorial.enemy_spawner_structs = undefined;
    tutorial.var_52d61057297d7e25 = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x42898242, Offset: 0xa686
// Size: 0x4a
function private function_2c3c3e319054f3d0( player, tutorial )
{
    player allowmovement( 1 );
    player allowstand( 1 );
    player allowcrouch( 1 );
    player allowjump( 1 );
    player allowfire( 1 );
    player freezelookcontrols( 0 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x55f63569, Offset: 0xa6d8
// Size: 0x344
function private function_46a08ab7bcfeafb3( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    thread trainingcourse_watchforplayerdeath( player, tutorial, tutorial.enemy_spawner_structs.size > 1 );
    
    if ( tutorial.enemy_spawner_structs.size > 1 )
    {
        function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, tutorial.enemy_spawner_structs.size );
    }
    
    var_1c81fac47ccaadb3 = function_3f5c1e59764b640d( function_cf5c6d1b5b216a8e() );
    var_6b11c4561a62886c = function_3f5c1e59764b640d( [ [ %"c_t10_gbl_opforce_pantheon_body_1", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_body_2", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_body_3", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_ast_body_1", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ] ] );
    
    for ( i = 0; i < tutorial.enemy_spawner_structs.size ; i++ )
    {
        info_struct = tutorial.enemy_spawner_structs[ i ];
        wait info_struct.time_to_spawn;
        spawn_origin = info_struct.spawn_origin;
        
        if ( !ispointonnavmesh( info_struct.destination_origin ) || !ispointonnavmesh( info_struct.spawn_origin ) )
        {
            spawn_origin = info_struct.destination_origin;
        }
        
        var_59d2d323e9ca09c9 = function_402d34de715b6a70( var_6b11c4561a62886c );
        agent = spawnagent( spawn_origin, info_struct.spawn_angles, 50, team_utility::getotherteam( player.team ), 1, var_59d2d323e9ca09c9[ 0 ], var_59d2d323e9ca09c9[ 1 ], var_59d2d323e9ca09c9[ 2 ] );
        agent enabletraversals( 1 );
        agent utility::set_movement_speed( info_struct.movement_speed );
        agent setgoalpos( info_struct.destination_origin, 32 );
        thread function_cf41e3734f3163de( player, agent, info_struct.var_5d6d97b7627a3c45 );
        thread function_bd4a1fa04e2102cd( player, agent, tutorial, tutorial.enemy_spawner_structs.size );
        pingmarker = function_f7e26bf874373e37( player, agent, "icon_waypoint_enemy_marker", 1, 72 );
        tutorial.enemy_waypoint_markers[ tutorial.enemy_waypoint_markers.size ] = pingmarker;
        randomsound = function_402d34de715b6a70( var_1c81fac47ccaadb3 );
        thread benchmark_mp_utils::function_8cc9c9da58868fb2( player, agent, randomsound, 0, 0.5 );
        tutorial.currently_spawned_agents[ tutorial.currently_spawned_agents.size ] = agent;
    }
    
    tutorial waittill( #"all_enemies_dead" );
    wait isbot( player ) ? 0.5 : 1.5;
    
    if ( function_ce08700870078f55( player ) )
    {
        function_c58312077098c9c8( player );
    }
    
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xbfaff437, Offset: 0xaa24
// Size: 0xb3
function private function_bd4a1fa04e2102cd( player, enemy, tutorial, var_3585171bd7e4c1a )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy waittill( #"death" );
    tutorial.var_52d61057297d7e25++;
    tutorial.currently_spawned_agents = arrayremove( tutorial.currently_spawned_agents, enemy );
    function_baee265bb13dd11e( function_275e97f81427089d( tutorial, player ), tutorial.var_52d61057297d7e25, var_3585171bd7e4c1a );
    
    if ( tutorial.var_52d61057297d7e25 == var_3585171bd7e4c1a )
    {
        tutorial notify( #"all_enemies_dead" );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xcbd95658, Offset: 0xaadf
// Size: 0x7d
function private function_cf41e3734f3163de( player, enemy, var_1c0418e5a5707c5f )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy endon( #"death" );
    enemy waittill( #"goal" );
    enemy.favoriteenemy = player;
    thread function_2e48a30dec1b5d77( player, enemy, 1, var_1c0418e5a5707c5f, 0, 40, 0, 0.2, 0.4 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x3c7e3158, Offset: 0xab64
// Size: 0x4a
function private function_ac7709ce2d18a66b( bot, tutorial )
{
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_rotation", 1 );
    bot allowjump( 0 );
    bot allowreload( 0 );
    bot setinfiniteammo( 1 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x47c7a13a, Offset: 0xabb6
// Size: 0x59
function private function_c1c34569d90ffb3f( bot, tutorial )
{
    bot allowreload( 1 );
    bot allowjump( 1 );
    bot setinfiniteammo( 0 );
    bot botclearbutton( "ads" );
    bot allowstand( 1 );
    bot allowcrouch( 1 );
    bot botsetstance( "stand" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x2c1dbe2c, Offset: 0xac17
// Size: 0x10a
function private function_1c77b5856a5e2eee( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    
    while ( true )
    {
        foreach ( agent in tutorial.currently_spawned_agents )
        {
            bot botsetflag( "disable_rotation", 0 );
            bot botpressbutton( "ads", 9999 );
            
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            childthread function_fd6bf4c76734b916( bot, agent );
            bot waittill( #"entity_in_view" );
            wait 1.5;
            thread function_bf3e729263fcc10( bot, agent, 0 );
            agent waittill( #"death" );
        }
        
        waitframe();
    }
}

/#

    // Namespace t10_training_course
    // Params 1, eflags: 0x4
    // Checksum 0xc5c1cbe9, Offset: 0xad29
    // Size: 0xd0, Type: dev
    function private function_db8250f88b742582( var_760f4b2cb6e5d912 )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            for ( i = 0; i < var_760f4b2cb6e5d912.size ; i++ )
            {
                spawn_origin = var_760f4b2cb6e5d912[ i ][ 0 ];
                destination_origin = var_760f4b2cb6e5d912[ i ][ 1 ];
                sphere( spawn_origin, 10, ( 0, 1, 0 ), 0, 1 );
                sphere( destination_origin, 10, ( 0, 1, 0 ), 0, 1 );
                line( spawn_origin, destination_origin, ( 0, 0, 1 ), 1, 0, 1 );
                print3d( destination_origin, "<dev string:x1a1>" + i, ( 1, 0, 0 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x4dcdec7e, Offset: 0xae01
// Size: 0x2c
function private function_3b9c0f927794c87e( player, tutorial )
{
    function_bdd8b3c85cece6b4( player.map_instance_index, "omnisprint_target" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xfb55193d, Offset: 0xae35
// Size: 0x3b
function private function_8a06fe6b22498dfb( player, tutorial )
{
    hideobjectivemarker( function_49422e31150c2fc9( player ) );
    function_db5dd1759303d766( player.map_instance_index, "omnisprint_target" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x430310cb, Offset: 0xae78
// Size: 0x3be
function private function_3d90c6080a706c4b( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    function_ac53a17fd5b74658( player, &"t10_training_course/omnimovement_hint" );
    function_a6e8c085165e0898( player, &"t10_training_course/sprint_right", 0 );
    function_5310120afb8b29a0( player, &issprinting, &function_cd38eb9937fdb136, 0.8 );
    function_5e3e773127f754db( player );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/sprint_left", 0 );
    function_5310120afb8b29a0( player, &issprinting, &function_e7096335df6c927d, 0.8 );
    function_5e3e773127f754db( player );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/sprint_backward", 0 );
    function_5310120afb8b29a0( player, &issprinting, &function_a6e3df72999a3b25, 0.8 );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    wait 0.7;
    targets_information = [ [ &"t10_training_course/dive_right_shoot_target_kbm", &"t10_training_course/dive_right_shoot_target_gamepad", &function_a2d8f930d2fa75a3 ], [ &"t10_training_course/dive_left_shoot_target_kbm", &"t10_training_course/dive_left_shoot_target_gamepad", &function_62aac7cf482ebf2e ], [ &"t10_training_course/dive_backward_shoot_target_kbm", &"t10_training_course/dive_backward_shoot_target_gamepad", &function_c61be9781ccb0a1a ] ];
    function_7107038b2232bbb2( player, function_49422e31150c2fc9( player ), function_d58310d0f1d16d43( ( -31178, -55009, 431 ), player.map_instance_index ) );
    wait 0.7;
    omnisprint_targets = function_1852fc4473135ca4( player.map_instance_index, "omnisprint_target" );
    
    if ( !player usinggamepad() )
    {
        function_ac53a17fd5b74658( player, &"t10_training_course/slide_dive_hint_kbm" );
    }
    
    for ( i = 0; i < targets_information.size ; i++ )
    {
        var_9f9fa288f266192 = targets_information[ i ][ 0 ];
        var_afd9cbf266865df5 = targets_information[ i ][ 1 ];
        var_1929b48012adaa88 = targets_information[ i ][ 2 ];
        function_a6e8c085165e0898( player, player usinggamepad() ? var_afd9cbf266865df5 : var_9f9fa288f266192, 0 );
        
        foreach ( targetdata in omnisprint_targets )
        {
            function_dfda46466478db2a( targetdata.target, var_1929b48012adaa88 );
        }
        
        function_dd238173cc767f87( player, "omnisprint_target", 1 );
        
        foreach ( targetdata in omnisprint_targets )
        {
            function_dfda46466478db2a( targetdata.target, &function_469c0a99e6ef3c84 );
        }
        
        function_5e3e773127f754db( player );
        player playlocalsound( "uin_t10_training_course_objective_success" );
        
        if ( i != targets_information.size - 1 )
        {
            wait 0.7;
        }
    }
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    wait 0.5;
    function_70bfc41268e6eb1d( player.map_instance_index, "omnisprint_target" );
    wait 1;
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x8ab95157, Offset: 0xb23e
// Size: 0xae
function private function_5310120afb8b29a0( player, var_1eb21c6c806c259c, var_3c25ca2a247a6dee = undefined, amount_time = undefined, var_9525fa9f700d8874 = 1 )
{
    timer = 0;
    
    while ( true )
    {
        if ( [[ var_1eb21c6c806c259c ]]( player ) )
        {
            if ( !isdefined( var_3c25ca2a247a6dee ) || [[ var_3c25ca2a247a6dee ]]( player ) )
            {
                timer += level.framedurationseconds;
                
                if ( !isdefined( amount_time ) || timer > amount_time )
                {
                    break;
                }
            }
        }
        else
        {
            timer = 0;
        }
        
        waitframe();
    }
    
    if ( var_9525fa9f700d8874 )
    {
        player playlocalsound( "uin_t10_training_course_objective_success" );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe8626841, Offset: 0xb2f4
// Size: 0x12
function private issprinting( player )
{
    return player issprinting();
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1d69282f, Offset: 0xb30f
// Size: 0x1c, Type: bool
function private function_ea0c6158d187ce84( player )
{
    return player issprintsliding() || player isdiving();
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x873721f1, Offset: 0xb334
// Size: 0x47, Type: bool
function private function_cd38eb9937fdb136( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoright( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xfccbbfc9, Offset: 0xb384
// Size: 0x47, Type: bool
function private function_e7096335df6c927d( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoleft( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xbcb28b82, Offset: 0xb3d4
// Size: 0x47, Type: bool
function private function_a6e3df72999a3b25( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoforward( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) <= -0.8;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x7f991e5c, Offset: 0xb424
// Size: 0x32, Type: bool
function private function_a2d8f930d2fa75a3( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_cd38eb9937fdb136( attacker );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x61c8a7be, Offset: 0xb45f
// Size: 0x32, Type: bool
function private function_62aac7cf482ebf2e( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_e7096335df6c927d( attacker );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x6c7b38e5, Offset: 0xb49a
// Size: 0x32, Type: bool
function private function_c61be9781ccb0a1a( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_a6e3df72999a3b25( attacker );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xbdf8d6c1, Offset: 0xb4d5
// Size: 0x1f, Type: bool
function private function_469c0a99e6ef3c84( attacker, meansofdeath, weapon )
{
    return false;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x96d984ef, Offset: 0xb4fd
// Size: 0x133
function private function_eb3ea60bb4e2122d( player, tutorial )
{
    bot = function_c8702ddd4540ea28( function_275e97f81427089d( tutorial, player ) );
    assert( isdefined( bot ), "<dev string:x1a9>" );
    
    while ( !isdefined( bot ) )
    {
        wait 0.2;
        bot = function_c8702ddd4540ea28( function_275e97f81427089d( tutorial, player ) );
    }
    
    bot playershow();
    bot setorigin( function_d58310d0f1d16d43( ( -30231, -53774, 303 ), player.map_instance_index ) );
    bot setplayerangles( function_2e52e3ebd7fff7bd( ( 0, -18, 0 ), player.map_instance_index ) );
    outofbounds::enableoobimmunity( bot );
    bot setinfiniteammo( 1 );
    bot botsetflag( "force_sprint", 0 );
    bot botsetflag( "disable_automatic_sprint", 1 );
    bot.health = bot.maxhealth;
    bot.takedamage = 1;
    player disableexecutionattack();
    tutorial.bot = bot;
    tutorial.enemy_array = [];
    tutorial.var_52d61057297d7e25 = 0;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xadfa6016, Offset: 0xb638
// Size: 0x1ad
function private function_eef95cf422ee90cc( player, tutorial )
{
    if ( player ismeatshieldactive() || player ismeatshieldattacker() )
    {
        player stopmeatshield( 13 );
    }
    
    if ( isalive( tutorial.bot ) )
    {
        tutorial.bot setorigin( function_d58310d0f1d16d43( ( -30542, -57270, 52 ), player.map_instance_index ) );
        function_f84dc38c3e66bb65( tutorial.bot );
        tutorial.bot.takedamage = 0;
        tutorial.bot playerhide();
    }
    
    outofbounds::function_9aa3ce7806e04201( tutorial.bot );
    
    if ( outofbounds::isoob( tutorial.bot ) )
    {
        outofbounds::clearoob( tutorial.bot, 0 );
    }
    
    tutorial.bot.is_dead = undefined;
    tutorial.bot = undefined;
    
    if ( isdefined( tutorial.enemy_array ) )
    {
        foreach ( enemy in tutorial.enemy_array )
        {
            despawnagent( enemy );
            enemy = undefined;
        }
        
        tutorial.enemy_array = undefined;
    }
    
    player enableexecutionattack();
    tutorial.var_52d61057297d7e25 = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xd8759c78, Offset: 0xb7ed
// Size: 0xa2
function private function_7b0997d222bd6ed4( player, tutorial )
{
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( isalive( enemy ) )
        {
            enemy enabletraversals( 0 );
            enemy utility::set_movement_speed( 0 );
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb9aad27e, Offset: 0xb897
// Size: 0x520
function private function_543c2f2f36cba326( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    enemy_spawn_infos = [ [ ( -29318, -54405, 304 ), 1, 125 ], [ ( -29481, -53837, 336 ), 1, 100 ], [ ( -29439, -54031, 304 ), 1, 125 ], [ ( -29784, -54127, 353 ), 1, 125 ] ];
    thread trainingcourse_watchforplayerdeath( player, tutorial, enemy_spawn_infos.size > 1 );
    thread function_aeafa117a848bcfe( tutorial, player, tutorial.bot );
    
    while ( !player ismeatshieldattacker() )
    {
        waitframe();
    }
    
    player enableexecutionattack();
    tutorial notify( #"meatshield_initiated" );
    
    if ( enemy_spawn_infos.size > 1 )
    {
        function_98702f770499bea1( function_275e97f81427089d( tutorial, player ), 0, enemy_spawn_infos.size );
    }
    
    var_6b11c4561a62886c = function_3f5c1e59764b640d( [ [ %"c_t10_gbl_opforce_pantheon_body_1", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_body_2", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_body_3", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ], [ %"c_t10_gbl_opforce_pantheon_ast_body_1", %"head_sc_m_colvin", %"c_t10_gbl_opforce_pantheon_ast_head_2" ] ] );
    var_1bfb4983b04de4d0 = 9999;
    
    foreach ( enemy_spawn_info in enemy_spawn_infos )
    {
        spawn_point = function_d58310d0f1d16d43( enemy_spawn_info[ 0 ], player.map_instance_index );
        movement_delay = enemy_spawn_info[ 1 ];
        speed = !function_abaed5b5b01f5e28( tutorial ) ? enemy_spawn_info[ 2 ] : 70;
        angles = vectortoangles( player.origin - spawn_point );
        var_59d2d323e9ca09c9 = function_402d34de715b6a70( var_6b11c4561a62886c );
        enemy = spawnagent( spawn_point, angles, 100, team_utility::getotherteam( player.team ), 1, var_59d2d323e9ca09c9[ 0 ], var_59d2d323e9ca09c9[ 1 ], var_59d2d323e9ca09c9[ 2 ] );
        enemy.favoriteenemy = player;
        thread function_67f98dc0911f51c9( player, enemy, movement_delay, speed );
        var_5d742401d8f13aaa = randomfloatrange( 2, 4 );
        thread function_8fb8aa45f72b2af( player, enemy, var_5d742401d8f13aaa, 0.3, 0.6 );
        tutorial.enemy_array[ tutorial.enemy_array.size ] = enemy;
        thread function_5f9c8959f158543d( player, enemy, tutorial, enemy_spawn_infos.size );
        
        if ( var_5d742401d8f13aaa < var_1bfb4983b04de4d0 )
        {
            var_1bfb4983b04de4d0 = var_5d742401d8f13aaa;
        }
    }
    
    thread function_e130e0f4e6610f2( player, tutorial, var_1bfb4983b04de4d0 );
    childthread function_b7e85cbe2b2017cb( tutorial.bot );
    
    while ( tutorial.bot ismeatshieldvictim() || tutorial.bot isinexecutionvictim() )
    {
        waitframe();
    }
    
    alive_enemies = [];
    
    foreach ( enemy in tutorial.enemy_array )
    {
        if ( isalive( enemy ) )
        {
            function_b3d358f2f43b564c( enemy, 1 );
            enemy utility::set_movement_speed( 200 );
            alive_enemies[ alive_enemies.size ] = enemy;
        }
    }
    
    if ( function_ce08700870078f55( player ) )
    {
        function_c58312077098c9c8( player );
    }
    
    if ( alive_enemies.size == 0 )
    {
        waitframe();
        
        if ( !tutorial.bot.is_dead )
        {
            tutorial.bot.ignoreall = 0;
            tutorial.bot botsetflag( "disable_movement", 0 );
            tutorial.bot botsetflag( "disable_rotation", 0 );
            thread function_b0481593100b7378( player, tutorial.bot );
            tutorial.bot waittill( #"death" );
        }
        
        thread completetutorial( player, tutorial );
        return;
    }
    
    wait 2;
    thread restarttutorial( player, tutorial, 0, 1, 0 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1a42ff45, Offset: 0xbdbf
// Size: 0x35
function private function_b7e85cbe2b2017cb( bot )
{
    bot endon( #"disconnect" );
    bot waittill( #"death" );
    bot.is_dead = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x539f4047, Offset: 0xbdfc
// Size: 0xc9
function private function_b0481593100b7378( player, meatshield_bot )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    meatshield_bot endon( #"death_or_disconnect" );
    childthread function_fd6bf4c76734b916( meatshield_bot, player );
    fire_time = weaponfiretime( meatshield_bot getcurrentweapon() );
    wait 2;
    cos_fov_angle = cos( 35 );
    
    while ( true )
    {
        if ( function_7517ebd4fc6719f0( meatshield_bot, player, cos_fov_angle ) )
        {
            meatshield_bot botpressbutton( "attack" );
            wait fire_time;
            continue;
        }
        
        meatshield_bot botsetscriptgoal( player.origin, 32, "critical" );
        meatshield_bot utility::waittill_any_return( "goal", "entity_in_view" );
        meatshield_bot botclearscriptgoal();
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0x4612cbf1, Offset: 0xbecd
// Size: 0x95
function private function_5f9c8959f158543d( player, enemy, tutorial, var_3585171bd7e4c1a )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy waittill( #"death" );
    tutorial.var_52d61057297d7e25++;
    tutorial.enemy_array = arrayremove( tutorial.enemy_array, enemy );
    function_baee265bb13dd11e( function_275e97f81427089d( tutorial, player ), tutorial.var_52d61057297d7e25, var_3585171bd7e4c1a );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xe1803c97, Offset: 0xbf6a
// Size: 0xd7
function private function_aeafa117a848bcfe( tutorial, player, bot )
{
    player endon( #"tutorial_changed" );
    tutorial endon( #"meatshield_initiated" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        bot waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        
        if ( attacker == player && utility::isbulletdamage( meansofdeath ) || !isalive( bot ) )
        {
            bot.takedamage = 0;
            player playlocalsound( "uin_t10_training_course_target_fail" );
            thread restarttutorial( player, tutorial, 0, 0, 1 );
            break;
        }
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xf2e3c7d7, Offset: 0xc049
// Size: 0x6f
function private function_67f98dc0911f51c9( player, enemy, seconds, speed )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    enemy endon( #"death" );
    wait seconds;
    enemy enabletraversals( 1 );
    enemy utility::set_movement_speed( speed );
    enemy setgoalentity( player, 500 );
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0xe25e8e15, Offset: 0xc0c0
// Size: 0x117
function private function_8fb8aa45f72b2af( player, enemy, initial_delay, fire_rate_min, fire_rate_max )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    enemy endon( #"death" );
    wait initial_delay;
    
    while ( true )
    {
        trace = trace::ray_trace( enemy geteye(), player geteye(), enemy, undefined );
        player_forward = vectornormalize( anglestoforward( player.angles ) );
        enemy_forward = vectornormalize( anglestoforward( enemy.angles ) );
        dot_product = vectordot( player_forward, enemy_forward );
        should_damage_player = dot_product > -0.1 && isdefined( trace[ "entity" ] );
        function_bc2d17578622fd93( enemy, player, should_damage_player );
        
        if ( isdefined( trace[ "entity" ] ) )
        {
            enemy notify( #"shoot_player" );
        }
        
        wait randomfloatrange( fire_rate_min, fire_rate_max );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x731a53a2, Offset: 0xc1df
// Size: 0x11a
function private function_e130e0f4e6610f2( player, tutorial, initial_wait_time )
{
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    wait initial_wait_time;
    
    do
    {
        var_8be15f16f56ed326 = undefined;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                var_8be15f16f56ed326 = enemy;
                break;
            }
        }
        
        if ( !isdefined( var_8be15f16f56ed326 ) )
        {
            break;
        }
        
        var_8be15f16f56ed326 utility::waittill_any( "shoot_player", "death" );
        player dodamage( 10, player.origin, var_8be15f16f56ed326, undefined, "MOD_RIFLE_BULLET", var_8be15f16f56ed326.primaryweapon );
        wait randomfloatrange( 1, 2 );
    }
    while ( true );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb18801ce, Offset: 0xc301
// Size: 0x2b
function private function_ba41b7a10219ef3b( bot, tutorial )
{
    bot setinfiniteammo( 1 );
    bot.takedamage = 0;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x67ac96f7, Offset: 0xc334
// Size: 0x5a
function private function_13e58d96d5b1042f( bot, tutorial )
{
    bot setinfiniteammo( 0 );
    bot botclearscriptgoal();
    bot botclearbutton( "ads" );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot.takedamage = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x2a8d868f, Offset: 0xc396
// Size: 0x3aa
function private function_7d1d9a69f497ce3e( bot, tutorial )
{
    bot endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    wait 1;
    bot botsetflag( "disable_movement", 0 );
    bot botsetflag( "disable_rotation", 0 );
    bot botsetflag( "disable_avoidance", 1 );
    direction_vector = vectornormalize( tutorial.bot.origin - bot.origin );
    offset_scaler = 15;
    bot botsetscriptgoal( tutorial.bot.origin - direction_vector * offset_scaler, 32, "critical" );
    bot waittill( #"goal" );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_avoidance", 0 );
    bot botclearscriptgoal();
    bot botpressbutton( "melee" );
    wait 0.35;
    tutorial.bot startmeatshield( bot );
    wait 1.5;
    bot botsetflag( "disable_movement", 0 );
    bot botsetscriptmove( function_2e52e3ebd7fff7bd( ( 0, -18, 0 ), bot.map_instance_index )[ 1 ], 9999, 0.3 );
    
    while ( true )
    {
        closest_visible_enemy = undefined;
        current_closest_distance = undefined;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            trace = trace::ray_trace( bot geteye(), enemy geteye(), [ bot, tutorial.bot ], undefined );
            
            if ( trace[ "entity" ] != enemy )
            {
                continue;
            }
            
            var_3c5820f8b063463d = distancesquared( bot.origin, enemy.origin );
            
            if ( !isdefined( current_closest_distance ) || var_3c5820f8b063463d < current_closest_distance )
            {
                closest_visible_enemy = enemy;
                current_closest_distance = var_3c5820f8b063463d;
            }
        }
        
        if ( !isdefined( closest_visible_enemy ) )
        {
            waitframe();
            continue;
        }
        
        bot botsetflag( "disable_rotation", 0 );
        childthread function_fd6bf4c76734b916( bot, closest_visible_enemy );
        wait 1;
        bot botpressbutton( "ads", 9999 );
        thread function_bf3e729263fcc10( bot, closest_visible_enemy, 0.5 );
        closest_visible_enemy waittill( #"death" );
        wait 0.3;
        bot botclearbutton( "ads" );
        all_enemies_dead = 1;
        
        foreach ( enemy in tutorial.enemy_array )
        {
            if ( isalive( enemy ) )
            {
                all_enemies_dead = 0;
                break;
            }
        }
        
        if ( all_enemies_dead )
        {
            break;
        }
    }
    
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetscriptmove( 0, 0, 1 );
    
    if ( bot ismeatshieldactive() )
    {
        wait 0.5;
        bot stopmeatshield( 9 );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x6ba9dc33, Offset: 0xc748
// Size: 0xf0
function private function_c0b7d169e34f2418( player, tutorial )
{
    tutorial.objective_marker = function_49422e31150c2fc9( player );
    
    foreach ( weap in player.primaryweapons )
    {
        if ( weaponclass( weap ) == "pistol" && !weapon::isbackuppistol( weap ) )
        {
            player switchtoweaponimmediate( weap );
            break;
        }
    }
    
    function_bdd8b3c85cece6b4( player.map_instance_index, "hip_fire_target" );
    function_bdd8b3c85cece6b4( player.map_instance_index, "wildcard_target" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x2b07d0d2, Offset: 0xc840
// Size: 0x60
function private function_453ce916fba291a1( player, tutorial )
{
    hideobjectivemarker( tutorial.objective_marker );
    tutorial.objective_marker = undefined;
    function_db5dd1759303d766( player.map_instance_index, "hip_fire_target" );
    function_db5dd1759303d766( player.map_instance_index, "wildcard_target" );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xcc37c499, Offset: 0xc8a8
// Size: 0x55e
function private function_36f64d6bee634a9( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    function_a6e8c085165e0898( player, &"t10_training_course/sprint", 3 );
    function_5310120afb8b29a0( player, &issprinting, undefined, 1, 0 );
    function_5e3e773127f754db( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    function_7107038b2232bbb2( player, tutorial.objective_marker, function_d58310d0f1d16d43( ( -31220, -57284, 360 ), player.map_instance_index ) );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/shoot_hip_fire", 1 );
    function_ac53a17fd5b74658( player, &"t10_training_course/reload_hint" );
    function_1852fc4473135ca4( player.map_instance_index, "hip_fire_target", &function_d77cbbfc99789ed );
    function_dd238173cc767f87( player, "hip_fire_target" );
    function_70bfc41268e6eb1d( player.map_instance_index, "hip_fire_target" );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    function_7107038b2232bbb2( player, tutorial.objective_marker, function_d58310d0f1d16d43( ( -31494, -57390, 368 ), player.map_instance_index ) );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/swap_weapon", 0 );
    function_ac53a17fd5b74658( player, &"t10_training_course/cycle_weapons_hint" );
    player waittill( #"weapon_change" );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/shoot_ads_fire", 1 );
    function_ac53a17fd5b74658( player, &"t10_training_course/ads_hint" );
    ads_targets = function_1852fc4473135ca4( player.map_instance_index, "wildcard_target", &function_d492e313412afcee );
    function_dd238173cc767f87( player, "wildcard_target", 3 );
    function_70bfc41268e6eb1d( player.map_instance_index, "wildcard_target" );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/crouch", 0 );
    function_ac53a17fd5b74658( player, &"t10_training_course/crouch_hint" );
    
    if ( !player usinggamepad() )
    {
        while ( player getstance() != "crouch" )
        {
            waitframe();
        }
    }
    else
    {
        function_5310120afb8b29a0( player, &iscrouching, undefined, 0.4, 0 );
    }
    
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    
    if ( player usinggamepad() )
    {
        function_a6e8c085165e0898( player, &"t10_training_course/prone_shoot_gamepad", 2 );
    }
    else
    {
        function_a6e8c085165e0898( player, &"t10_training_course/prone_shoot_kbm", 2 );
    }
    
    function_ac53a17fd5b74658( player, &"t10_training_course/prone_hint" );
    function_1852fc4473135ca4( player.map_instance_index, "wildcard_target", &function_47a8618216dcc012 );
    function_dd238173cc767f87( player, "wildcard_target", 3 );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.5;
    function_70bfc41268e6eb1d( player.map_instance_index, "wildcard_target" );
    wait 0.7;
    function_7107038b2232bbb2( player, tutorial.objective_marker, function_d58310d0f1d16d43( ( -31658, -57878, 275 ), player.map_instance_index ), &"t10_training_course/stand_up_next_objective" );
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/slide_objective", 0 );
    
    if ( !player usinggamepad() )
    {
        function_ac53a17fd5b74658( player, &"t10_training_course/slide_dive_hint_kbm" );
    }
    
    while ( !player issprintsliding() )
    {
        waitframe();
    }
    
    function_5e3e773127f754db( player );
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 0.7;
    
    if ( getdvarint( @"hash_8d82e300c99f95b0" ) )
    {
        if ( player usinggamepad() )
        {
            function_a6e8c085165e0898( player, &"t10_training_course/dive_objective_gamepad", 0 );
        }
        else
        {
            function_a6e8c085165e0898( player, &"t10_training_course/dive_objective_kbm", 0 );
        }
        
        function_ac53a17fd5b74658( player, &"t10_training_course/dive_slide_hint" );
        
        while ( !player isdiving() )
        {
            waitframe();
        }
        
        function_5e3e773127f754db( player );
        function_55099ffa73b4eff1( player );
        player playlocalsound( "uin_t10_training_course_objective_success" );
    }
    
    wait 0.7;
    function_a6e8c085165e0898( player, &"t10_training_course/slide_shoot", 2 );
    function_ac53a17fd5b74658( player, &"t10_training_course/dive_slide_shoot_hint" );
    function_1852fc4473135ca4( player.map_instance_index, "wildcard_target", &function_b3c46dc14c991111 );
    function_dd238173cc767f87( player, "wildcard_target", 3 );
    function_70bfc41268e6eb1d( player.map_instance_index, "wildcard_target" );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 1;
    wait 0.7;
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xba48e7c4, Offset: 0xce0e
// Size: 0x18, Type: bool
function private iscrouching( player )
{
    return player getstance() == "crouch";
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x320f9084, Offset: 0xce2f
// Size: 0x33, Type: bool
function private function_d77cbbfc99789ed( attacker, meansofdeath, weapon )
{
    return !attacker player::isplayerads() && utility::isbulletdamage( meansofdeath );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x3f46dd19, Offset: 0xce6b
// Size: 0x32, Type: bool
function private function_d492e313412afcee( attacker, meansofdeath, weapon )
{
    return attacker player::isplayerads() && utility::isbulletdamage( meansofdeath );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x8aefb4d0, Offset: 0xcea6
// Size: 0x36, Type: bool
function private function_47a8618216dcc012( attacker, meansofdeath, weapon )
{
    return attacker getstance() == "prone" && utility::isbulletdamage( meansofdeath );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x1df91d7f, Offset: 0xcee5
// Size: 0x30, Type: bool
function private function_b3c46dc14c991111( attacker, meansofdeath, weapon )
{
    return attacker issprintsliding() && utility::isbulletdamage( meansofdeath );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xa210f6d7, Offset: 0xcf1e
// Size: 0x26
function private function_1399331f1092d5fd( player, tutorial )
{
    tutorial.equipment_state = "";
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb23ec53e, Offset: 0xcf4c
// Size: 0xc5
function private function_436c4b277d74899c( player, tutorial )
{
    player killstreaks::clearkillstreaks();
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    hideobjectivemarker( function_49422e31150c2fc9( player ) );
    
    if ( isdefined( player.rcxd_vehicle ) )
    {
        player.rcxd_vehicle thread rcxd_shared::rcxd_explode();
    }
    
    if ( isdefined( player.support_box ) )
    {
        player.support_box thread support_box::supportbox_destroy( 0 );
    }
    
    player val::set( "deploy", "crate_use", 1 );
    tutorial.equipment_state = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x4814bc9a, Offset: 0xd019
// Size: 0xe3
function private function_3ac947bc433d7e3c( player, tutorial )
{
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    player val::set( "deploy", "crate_use", 0 );
    
    if ( tutorial.equipment_state == "super" )
    {
        player val::set( "deploy", "crate_use", 1 );
        player perkpackage::perkpackage_giveimmediate( "super_ammo_drop" );
        return;
    }
    
    if ( tutorial.equipment_state == "lethal" )
    {
        player equipment_mp::setequipmentslotammo( "primary", 1 );
        return;
    }
    
    if ( tutorial.equipment_state == "tactical" )
    {
        player equipment_mp::setequipmentslotammo( "secondary", 1 );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x29f11266, Offset: 0xd104
// Size: 0x704
function private function_c986e0685a1ba96( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    tutorial.equipment_state = "super";
    
    if ( player usinggamepad() )
    {
        function_a6e8c085165e0898( player, &"t10_training_course/field_upgrade_gamepad", 0 );
    }
    else
    {
        function_a6e8c085165e0898( player, &"t10_training_course/field_upgrade_kbm", 0 );
    }
    
    if ( !function_f0999c39797a8308() )
    {
        function_ac53a17fd5b74658( player, &"t10_training_course/field_upgrade_hint" );
    }
    
    player perkpackage::perkpackage_giveimmediate( "super_ammo_drop" );
    player waittill( #"grenade_fire", grenade );
    player supers_mp::clearsuper();
    player equipment_mp::takeequipment( "super" );
    function_5e3e773127f754db( player );
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 1.5;
    tutorial.equipment_state = "lethal";
    function_a6e8c085165e0898( player, &"t10_training_course/lethal_objective", 2 );
    
    if ( !function_f0999c39797a8308() )
    {
        function_ac53a17fd5b74658( player, &"t10_training_course/equipment_hint" );
    }
    
    player equipment_mp::setequipmentslotammo( "primary", 1 );
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    function_bdd8b3c85cece6b4( player.map_instance_index, "grenade_target" );
    function_1852fc4473135ca4( player.map_instance_index, "grenade_target", &function_9083a2f8cd56771e );
    childthread function_9117e58608e7d98d( player );
    function_dd238173cc767f87( player, "grenade_target", 1 );
    player notify( #"grenade_targets_dead" );
    function_db5dd1759303d766( player.map_instance_index, "grenade_target" );
    player equipment_mp::setequipmentslotammo( "primary", 0 );
    function_5e3e773127f754db( player );
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    player playlocalsound( "uin_t10_training_course_objective_success" );
    wait 1.5;
    tutorial.equipment_state = "tactical";
    function_a6e8c085165e0898( player, &"t10_training_course/tactical_objective", 2 );
    function_ac53a17fd5b74658( player, &"t10_training_course/tactical_equipment_hint" );
    function_bdd8b3c85cece6b4( player.map_instance_index, "tactical_target" );
    tactical_targets = function_1852fc4473135ca4( player.map_instance_index, "tactical_target", &function_33311a59064c1f1 );
    
    do
    {
        player equipment_mp::setequipmentslotammo( "secondary", 1 );
        player waittill( #"grenade_fire", grenade );
        grenade waittill( #"explode", var_8b3d373f18c07103 );
        
        if ( isdefined( grenade.equipmentref ) && grenade.equipmentref != "equip_flash" )
        {
            continue;
        }
        
        var_6b9fe9b34d868db7 = 0;
        
        foreach ( targetdata in tactical_targets )
        {
            target = targetdata.target;
            
            if ( distance( target.origin, var_8b3d373f18c07103 ) < 250 )
            {
                var_6b9fe9b34d868db7 = 1;
                break;
            }
        }
        
        if ( var_6b9fe9b34d868db7 )
        {
            break;
        }
    }
    while ( true );
    
    player equipment_mp::setequipmentslotammo( "secondary", 0 );
    function_db5dd1759303d766( player.map_instance_index, "tactical_target" );
    function_5e3e773127f754db( player );
    function_55099ffa73b4eff1( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
    
    if ( !function_f0999c39797a8308() )
    {
        wait 1.5;
        targetsspawned = 0;
        tutorial.equipment_state = "killstreak";
        
        do
        {
            function_a6e8c085165e0898( player, &"t10_training_course/activate_killstreak_objective", 0 );
            player killstreaks::awardkillstreak( "rcxd" );
            player waittill( #"streak_activated", streak_name );
            function_5e3e773127f754db( player );
            function_a6e8c085165e0898( player, &"t10_training_course/killstreak_objective", 0 );
            function_ac53a17fd5b74658( player, &"t10_training_course/scorestreaks_hint" );
            
            if ( !targetsspawned )
            {
                function_bdd8b3c85cece6b4( player.map_instance_index, "killstreak_target" );
                targetsspawned = 1;
            }
            
            killstreak_targets = function_1852fc4473135ca4( player.map_instance_index, "killstreak_target", &function_ea91c864e6fa597b );
            
            foreach ( targetdata in killstreak_targets )
            {
                target = targetdata.target;
                
                if ( isdefined( target ) && !isdefined( target.pingmarker ) )
                {
                    function_f7e26bf874373e37( player, target, "icon_waypoint_overlay_marker_enemy", 0, 20 );
                }
            }
            
            player childthread function_dd238173cc767f87( player, "killstreak_target", 1 );
            childthread function_ed052c528d719ee6( player );
            
            foreach ( targetdata in killstreak_targets )
            {
                target = targetdata.target;
                
                if ( isdefined( target.pingmarker ) )
                {
                    target.pingmarker.alpha = 1;
                }
            }
            
            msg = player utility::waittill_any_return( "rcxd_death", "targets_dead" );
            function_5e3e773127f754db( player );
            function_55099ffa73b4eff1( player );
            
            foreach ( targetdata in killstreak_targets )
            {
                target = targetdata.target;
                
                if ( isdefined( target.pingmarker ) )
                {
                    target.pingmarker.alpha = 0;
                }
            }
            
            if ( msg == "targets_dead" )
            {
                break;
            }
            
            wait 2;
        }
        while ( true );
        
        if ( targetsspawned )
        {
            function_db5dd1759303d766( player.map_instance_index, "killstreak_target" );
        }
        
        player playlocalsound( "uin_t10_training_course_objective_success" );
    }
    
    wait 1.5;
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x167eaf34, Offset: 0xd810
// Size: 0x4d
function private function_ed052c528d719ee6( player )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player.rcxd_vehicle waittill( #"death" );
    wait 1;
    player notify( #"rcxd_death" );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x4e0ec0e6, Offset: 0xd865
// Size: 0x6b
function private function_9117e58608e7d98d( player )
{
    player endon( #"tutorial_changed" );
    player endon( #"grenade_targets_dead" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"grenade_fire", grenade );
        wait 3.5;
        player equipment_mp::setequipmentslotammo( "primary", 1 );
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x89b5acb3, Offset: 0xd8d8
// Size: 0x42, Type: bool
function private function_9083a2f8cd56771e( attacker, meansofdeath, weapon )
{
    return isdefined( weapon ) && weapon.type == "grenade" && damage_effects::function_ae27c589e09c3181( meansofdeath );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xcd085d00, Offset: 0xd923
// Size: 0x1f, Type: bool
function private function_33311a59064c1f1( attacker, meansofdeath, weapon )
{
    return false;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x3103993, Offset: 0xd94b
// Size: 0x42, Type: bool
function private function_ea91c864e6fa597b( attacker, meansofdeath, weapon )
{
    return isdefined( weapon ) && weapon.basename == "rcxd" && damage_effects::function_ae27c589e09c3181( meansofdeath );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x2dd25419, Offset: 0xd996
// Size: 0x27
function private rcxd_begin( rcxd )
{
    player = self;
    player.rcxd_vehicle = rcxd;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x3bb70cbd, Offset: 0xd9c5
// Size: 0x24
function private rcxd_end( rcxd )
{
    player = self;
    player.rcxd_vehicle = undefined;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x27afee9b, Offset: 0xd9f1
// Size: 0x1a
function private function_8998b7ea159335f3( streakinfo )
{
    streakinfo.disablemarker = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x323d093b, Offset: 0xda13
// Size: 0x23
function private supportbox_used( player, grenade )
{
    player.support_box = grenade;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x686335c2, Offset: 0xda3e
// Size: 0x20
function private supportbox_deleted( player, grenade )
{
    player.support_box = undefined;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xf590f694, Offset: 0xda66
// Size: 0x15
function private function_a76af4aa2bc4b71f( player, tutorial )
{
    
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xc68cbf1e, Offset: 0xda83
// Size: 0x15
function private function_6573c78f12412c4a( player, tutorial )
{
    
}

// Namespace t10_training_course
// Params 0, eflags: 0x4
// Checksum 0x5d1387b0, Offset: 0xdaa0
// Size: 0xab
function private function_759b1273ca979ce8()
{
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    gamemode = challenges::getchallengegamemode();
    gametype = challenges::function_9edd00e9e48c0821();
    aeeventname = #"cer_training_emote_complete";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    eventparams = [];
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    self function_2e45314624fdfdb8( self, aeeventid, eventparams );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xa4a08984, Offset: 0xdb53
// Size: 0xbb
function private function_2bea643b5dba5bdc( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait 0.5;
    
    if ( player usinggamepad() )
    {
        function_a6e8c085165e0898( player, &"t10_training_course/emote_objective_gamepad", 0 );
    }
    else
    {
        function_a6e8c085165e0898( player, &"t10_training_course/emote_objective_kbm", 0 );
    }
    
    while ( !player isemoteactive() && !player function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    function_5e3e773127f754db( player );
    
    while ( player isemoteactive() || player function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    if ( true )
    {
        function_bfa865dfd7b9bfd6( player, tutorial, 1 );
    }
    
    thread completetutorial( player, tutorial );
}

// Namespace t10_training_course
// Params 6, eflags: 0x4
// Checksum 0xf9881baa, Offset: 0xdc16
// Size: 0x9c
function private createboxtrigger( owning_tutorial, origin, size, angles, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_box", origin, 0, size * 0.5, size * 0.5 );
    trigger.trigger_size = size;
    trigger.angles = angles;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x49504443, Offset: 0xdcbb
// Size: 0x78
function private function_4c7f1d74ec378cc9( owning_tutorial, origin, radius, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_radius", origin, 0, radius, radius );
    trigger.radius = radius;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xbf5a1a73, Offset: 0xdd3c
// Size: 0x6c
function private function_2bc6e455359ea3f2( trigger, owning_tutorial, var_79d0387098c2d96a, var_42322f2afdbd8587 )
{
    trigger.var_cad029c2ab7a4f73 = var_79d0387098c2d96a;
    trigger.var_42322f2afdbd8587 = var_42322f2afdbd8587;
    trigger.owning_tutorial = owning_tutorial;
    trigger.debug_draw = 1;
    trigger.is_init_trigger = 0;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x8ab55cb6, Offset: 0xddb0
// Size: 0xe9
function private function_a49fc858e731dcdb( tutorial, value )
{
    trigger = tutorial.init_trigger;
    function_44278d13f2543f10( trigger, value );
    
    if ( isdefined( trigger.chevrons ) )
    {
        function_1ba47b7678db87c3( trigger.chevrons, value ? "contested" : "off" );
    }
    
    if ( isdefined( trigger.flag ) )
    {
        if ( value )
        {
            trigger.flag show();
            trigger.flag sethintinoperable( 0 );
            thread function_78ed747911e430e7( trigger.flag, tutorial );
            return;
        }
        
        function_bfd317f43b3fe8e3( trigger.flag );
        trigger.flag sethintinoperable( 1 );
        trigger.flag hide();
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xc8e3c2cc, Offset: 0xdea1
// Size: 0x101
function private function_8becb86703380fc7( player, tutorial, var_bc057f2eb5601c58, var_3d8b9a40a0d8353b )
{
    trigger = tutorial.init_trigger;
    
    if ( isdefined( trigger.objective_marker ) )
    {
        if ( var_bc057f2eb5601c58 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( trigger.objective_marker.objidnum, player );
            objective_state( trigger.objective_marker.objidnum, var_3d8b9a40a0d8353b ? "current" : "invisible" );
            return;
        }
        
        if ( !var_3d8b9a40a0d8353b )
        {
            objidpoolmanager::objective_playermask_hidefromallplayers( trigger.objective_marker.objidnum );
            return;
        }
        
        objidpoolmanager::objective_playermask_addshowplayer( trigger.objective_marker.objidnum, player );
        objective_state( trigger.objective_marker.objidnum, "active" );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x4997e777, Offset: 0xdfaa
// Size: 0x48
function private function_44278d13f2543f10( trigger, value )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    /#
        trigger.debug_draw = value;
    #/
    
    if ( value )
    {
        trigger utility::trigger_on_proc();
        return;
    }
    
    trigger utility::trigger_off_proc();
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xc3afb9e8, Offset: 0xdffa
// Size: 0x4b
function private registertrigger( player, trigger )
{
    if ( !isdefined( player.registered_triggers ) )
    {
        player.registered_triggers = [];
    }
    
    player.registered_triggers[ player.registered_triggers.size ] = trigger;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xda4f19f9, Offset: 0xe04d
// Size: 0xc2
function private deregistertrigger( player, trigger_to_remove )
{
    foreach ( index, trigger in player.registered_triggers )
    {
        if ( trigger == trigger_to_remove )
        {
            trigger delete();
            trigger = undefined;
            player.registered_triggers[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( player.registered_triggers );
            }
            
            break;
        }
    }
}

// Namespace t10_training_course
// Params 6, eflags: 0x4
// Checksum 0x74da8a00, Offset: 0xe117
// Size: 0xee
function private function_5bda2610dad9e6e9( tutorial_name, map_instance_index, origin, angles, size_min, size_max )
{
    [ origin, angles ] = function_52ff81cfdbb3f234( origin, angles, map_instance_index );
    var_4ecf01568e38e4b2 = spawnstruct();
    var_4ecf01568e38e4b2.angles = angles;
    var_4ecf01568e38e4b2.origin = origin;
    var_4ecf01568e38e4b2.sizemin = size_min;
    var_4ecf01568e38e4b2.sizemax = size_max;
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ] ) )
    {
        level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ] = [];
    }
    
    oob_array_size = level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ].size;
    level.var_c03063b5f4fc2dde[ map_instance_index ][ tutorial_name ][ oob_array_size ] = var_4ecf01568e38e4b2;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x7499ee67, Offset: 0xe20d
// Size: 0x1e2
function private function_bb59f9b0bdf2d248( player, tutorial, value )
{
    tutorial_name = function_399e310dabe4c2cc( tutorial );
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ player.map_instance_index ][ tutorial_name ] ) )
    {
        return;
    }
    
    foreach ( var_4ecf01568e38e4b2 in level.var_c03063b5f4fc2dde[ player.map_instance_index ][ tutorial_name ] )
    {
        if ( value )
        {
            if ( !isdefined( var_4ecf01568e38e4b2.trigger ) )
            {
                trigger = spawn( "trigger_box", var_4ecf01568e38e4b2.origin, 0, var_4ecf01568e38e4b2.sizemin, var_4ecf01568e38e4b2.sizemax );
                trigger.angles = var_4ecf01568e38e4b2.angles;
                trigger.disabled = 0;
                var_4ecf01568e38e4b2.trigger = trigger;
                outofbounds::function_ea64b5c2bd16e0f5( trigger );
            }
            
            continue;
        }
        
        if ( isdefined( var_4ecf01568e38e4b2.trigger ) )
        {
            outofbounds::function_73faa310ef29036a( var_4ecf01568e38e4b2.trigger );
            var_4ecf01568e38e4b2.trigger delete();
            var_4ecf01568e38e4b2.trigger = undefined;
        }
    }
    
    if ( isdefined( tutorial.oob_chevrons ) && tutorial.oob_chevrons.size > 0 )
    {
        function_1ba47b7678db87c3( tutorial.oob_chevrons, value ? function_74fb2b19273b495a( player.team ) : "off" );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x324f6a1a, Offset: 0xe3f7
// Size: 0x1bf
function private function_fb78e7c7ad8e2157( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_spectator_mode" );
    
    if ( isbot( player ) )
    {
        player endon( #"hash_27620d5c2e30b764" );
    }
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( player.registered_triggers ) )
        {
            continue;
        }
        
        foreach ( trigger in player.registered_triggers )
        {
            if ( !isdefined( trigger ) || trigger.trigger_off )
            {
                continue;
            }
            
            tutorial = trigger.owning_tutorial;
            
            if ( player istouching( trigger ) )
            {
                if ( !trigger.player_in_trigger )
                {
                    if ( isdefined( trigger.var_cad029c2ab7a4f73 ) )
                    {
                        if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                        {
                            player thread [[ trigger.var_cad029c2ab7a4f73 ]]( player, tutorial );
                        }
                    }
                }
                
                trigger.player_in_trigger = 1;
                continue;
            }
            
            if ( trigger.player_in_trigger )
            {
                trigger.player_in_trigger = 0;
                
                if ( isdefined( trigger.var_42322f2afdbd8587 ) )
                {
                    if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                    {
                        player thread [[ trigger.var_42322f2afdbd8587 ]]( player, tutorial );
                    }
                }
            }
        }
    }
}

/#

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0x2f91aed4, Offset: 0xe5be
    // Size: 0xe9, Type: dev
    function private function_833acbbe64353915()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( level.players[ 0 ].registered_triggers ) )
            {
                foreach ( trigger in level.players[ 0 ].registered_triggers )
                {
                    if ( trigger.debug_draw )
                    {
                        if ( getdvarint( @"hash_c01ca8e4931f5a75", 0 ) == 1 )
                        {
                            drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 0 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0xbcb448ce, Offset: 0xe6af
    // Size: 0x1ae, Type: dev
    function private function_893ed490f765fc47()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_f9119320cacb3f8c", 0 ) == 0 )
            {
                continue;
            }
            
            if ( !isdefined( level.var_c03063b5f4fc2dde ) )
            {
                continue;
            }
            
            foreach ( var_2147e11a2bc2fc64 in level.var_c03063b5f4fc2dde )
            {
                foreach ( trigger_array in var_2147e11a2bc2fc64 )
                {
                    foreach ( triggerdata in trigger_array )
                    {
                        if ( triggerdata.trigger )
                        {
                            drawtrigger( triggerdata.trigger, ( 1, 0, 0 ), 0, 1, 0 );
                        }
                    }
                }
            }
        }
    }

#/

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xaa98d3a, Offset: 0xe865
// Size: 0x285, Type: bool
function private function_b2c44c2beeec92ac( targets_to_spawn, map_instance_index )
{
    if ( !isdefined( level.world_target_array ) )
    {
        level.world_target_array = [];
    }
    
    if ( !isdefined( level.var_2e61ab2b37d9ba6f ) )
    {
        level.var_2e61ab2b37d9ba6f = [];
    }
    
    foreach ( target_array in targets_to_spawn )
    {
        var_95f80e24c6f710b0 = target_array[ 0 ];
        target_type = target_array[ 1 ];
        origin = target_array[ 2 ];
        angles = target_array[ 3 ];
        var_8ec6c61df26369da = target_array[ 4 ];
        
        if ( target_type == 2 )
        {
            continue;
        }
        
        [ origin, angles ] = function_52ff81cfdbb3f234( origin, angles, map_instance_index );
        targetdata = spawnstruct();
        targetdata.target_type = target_type;
        targetdata.origin = origin;
        targetdata.angles = angles;
        targetdata.var_8ec6c61df26369da = var_8ec6c61df26369da;
        targetdata.target = undefined;
        
        if ( target_type == 1 )
        {
            targetdata.health = 300;
        }
        else if ( target_type == 2 )
        {
            targetdata.health = 300;
        }
        
        if ( isdefined( targetdata ) )
        {
            foreach ( group_name in var_95f80e24c6f710b0 )
            {
                if ( !isdefined( level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ] ) )
                {
                    level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ] = [];
                }
                
                if ( !isdefined( level.world_target_array[ map_instance_index ] ) )
                {
                    level.world_target_array[ map_instance_index ] = [];
                }
                
                level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ][ level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ].size ] = targetdata;
                level.world_target_array[ map_instance_index ][ level.world_target_array[ map_instance_index ].size ] = targetdata;
            }
        }
    }
    
    return true;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xf11c36b6, Offset: 0xeaf3
// Size: 0x15b
function private function_bdd8b3c85cece6b4( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        if ( targetdata.target_type == 1 )
        {
            targetdata.target = function_139b993fdeb62430( targetdata.origin, targetdata.angles, targetdata.health, targetdata.var_8ec6c61df26369da );
        }
        else if ( targetdata.target_type == 2 )
        {
            targetdata.target = function_bc605a7bf950fe4( targetdata.origin, targetdata.angles, -40, targetdata.health, targetdata.var_8ec6c61df26369da );
        }
        
        if ( isdefined( targetdata.target ) )
        {
            function_ed7e4e390edfa669( targetdata.target, 0 );
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x97e3dc54, Offset: 0xec56
// Size: 0x7e
function private deletetarget( targetdata )
{
    if ( isdefined( targetdata.target ) )
    {
        if ( isdefined( targetdata.target.pingmarker ) )
        {
            targetdata.target.pingmarker destroy();
            targetdata.target.pingmarker = undefined;
        }
        
        targetdata.target delete();
        targetdata.target = undefined;
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xbbf8cd78, Offset: 0xecdc
// Size: 0x9f
function private function_db5dd1759303d766( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        deletetarget( targetdata );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xa979eec3, Offset: 0xed83
// Size: 0x88
function private function_a028ec2a35d56827( map_instance_index )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        deletetarget( targetdata );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x15a1dc19, Offset: 0xee13
// Size: 0xad
function private function_2125c1ceca157ae2( map_instance_index, var_71f08fd2cf853161 )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_ed7e4e390edfa669( target, var_71f08fd2cf853161 );
        }
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xe4379ea4, Offset: 0xeec8
// Size: 0xc5
function private function_2d02218ae92b9b9a( map_instance_index, var_90f374dcdee2f09e, var_5fba7026c242c338 )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_374d87d39fc4b28f( target, var_5fba7026c242c338 );
            
            if ( var_90f374dcdee2f09e )
            {
                function_dfda46466478db2a( target, undefined );
            }
        }
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xfec9f50f, Offset: 0xef95
// Size: 0x59
function private function_6bd2fbc188d8c004( player, var_90f374dcdee2f09e, delay_time, var_5fba7026c242c338 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait delay_time;
    thread function_2d02218ae92b9b9a( player.map_instance_index, var_90f374dcdee2f09e, var_5fba7026c242c338 );
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xc273b3a3, Offset: 0xeff6
// Size: 0xfb
function private function_1852fc4473135ca4( map_instance_index, targetgroup_name, var_9360681aa67fb3d9 = undefined, var_a60e535b918b61cc = undefined )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            target_goup( target );
            target_enableoutline( target, var_a60e535b918b61cc );
            target setcandamage( 1 );
            function_dfda46466478db2a( target, var_9360681aa67fb3d9 );
        }
    }
    
    return targets;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x40305590, Offset: 0xf0fa
// Size: 0xd7
function private function_70bfc41268e6eb1d( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_42c5592ce8a29c26( target );
            target_disableoutline( target );
            target setcandamage( 0 );
            function_dfda46466478db2a( target, undefined );
        }
    }
    
    return targets;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xdcacedf, Offset: 0xf1da
// Size: 0x18d
function private function_dd238173cc767f87( player, targetgroup_name, amount = undefined )
{
    level endon( #"game_ended" );
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    targets = level.var_2e61ab2b37d9ba6f[ player.map_instance_index ][ targetgroup_name ];
    var_d998843bd69bb6ff = [];
    
    for ( i = 0; i < targets.size ; i++ )
    {
        target = targets[ i ].target;
        
        if ( isdefined( target ) && !target getcandamage() )
        {
            var_d998843bd69bb6ff[ i ] = 1;
        }
    }
    
    if ( var_d998843bd69bb6ff.size == targets.size )
    {
        self notify( #"targets_dead" );
        return;
    }
    
    if ( !isdefined( amount ) )
    {
        amount = targets.size - var_d998843bd69bb6ff.size;
    }
    
    if ( amount > 1 )
    {
        function_98702f770499bea1( player, 0, amount );
    }
    
    targets_dead = 0;
    
    while ( true )
    {
        for ( i = 0; i < targets.size ; i++ )
        {
            target = targets[ i ].target;
            
            if ( isdefined( target ) && !var_d998843bd69bb6ff[ i ] && !target getcandamage() )
            {
                targets_dead++;
                var_d998843bd69bb6ff[ i ] = 1;
                function_baee265bb13dd11e( player, targets_dead, amount );
            }
        }
        
        if ( targets_dead >= amount )
        {
            self notify( #"targets_dead" );
            
            if ( function_ce08700870078f55( player ) )
            {
                function_c58312077098c9c8( player, 1 );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xfd053ee1, Offset: 0xf36f
// Size: 0x1a8
function private function_139b993fdeb62430( origin, angles, health = 300, var_8ec6c61df26369da = 1 )
{
    target = spawn( "script_model", origin );
    target function_b398682b38f521f5( 1 );
    target.angles = angles;
    target setmodel( "t10_machinery_shooting_target" );
    target.health = health;
    target.maxhealth = health;
    target.type = 1;
    target.var_7972880ea8fb5b4c = 1;
    target.var_8ec6c61df26369da = var_8ec6c61df26369da;
    target.attached_models = [];
    target.standing_state = 1;
    
    if ( "" != "" )
    {
        arm = spawn( "script_model", origin );
        arm notsolid();
        target function_b398682b38f521f5( 1 );
        arm.angles = angles;
        arm setmodel( "" );
        arm linkto( target );
        target.attached_models[ target.attached_models.size ] = arm;
    }
    
    target.down_backward_angles = target.angles + ( -90, 0, 0 );
    target.down_forward_angles = target.angles + ( 90, 0, 0 );
    target.up_angles = target.angles;
    return target;
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x759f9331, Offset: 0xf520
// Size: 0xd5
function private function_bc605a7bf950fe4( origin, angles, z_offset = 0, health = 300, var_8ec6c61df26369da = 1 )
{
    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + z_offset );
    target = spawn( "script_model", origin );
    target.angles = angles;
    target setmodel( "ee_military_shooting_range_target_clay_circle" );
    target.health = health;
    target.maxhealth = health;
    target.type = 2;
    target.var_7972880ea8fb5b4c = 1;
    target.var_8ec6c61df26369da = var_8ec6c61df26369da;
    return target;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x9b35e0df, Offset: 0xf5fe
// Size: 0x99
function private target_delete( target )
{
    foreach ( model in target.attached_models )
    {
        model delete();
    }
    
    target.attached_models = [];
    target delete();
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0x5a7be0a3, Offset: 0xf69f
// Size: 0x125
function private function_42c5592ce8a29c26( target, backwards = 1, var_71f08fd2cf853161 = 1, instant = 0 )
{
    if ( isdefined( target.pingmarker ) )
    {
        target.pingmarker.alpha = 0;
    }
    
    if ( target.type == 2 )
    {
        return 0;
    }
    
    anim_time = 0;
    
    if ( target.standing_state === 1 )
    {
        anim_time = 0.2;
        down_angles = backwards ? target.down_backward_angles : target.down_forward_angles;
        
        if ( instant )
        {
            target.angles = down_angles;
        }
        else
        {
            target rotateto( down_angles, anim_time );
            
            if ( var_71f08fd2cf853161 )
            {
                playsoundatpos( target.origin + ( 0, 0, 10 ), "amb_emt_t10_training_course_target_down" );
            }
        }
    }
    
    target disableaimassist();
    target.standing_state = 2;
    return anim_time;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xf6da998b, Offset: 0xf7cd
// Size: 0xd0
function private target_goup( target, var_5fba7026c242c338 = 1 )
{
    if ( isdefined( target.pingmarker ) )
    {
        target.pingmarker.alpha = 1;
    }
    
    if ( target.type == 2 )
    {
        return 0;
    }
    
    anim_time = 0;
    
    if ( target.standing_state === 2 )
    {
        anim_time = 0.3;
        target rotateto( target.up_angles, anim_time );
        
        if ( var_5fba7026c242c338 )
        {
            playsoundatpos( target.origin + ( 0, 0, 10 ), "amb_emt_t10_training_course_target_up" );
        }
    }
    
    target enableaimassist();
    target.standing_state = 1;
    return anim_time;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x9e8ab611, Offset: 0xf8a6
// Size: 0x4e
function private target_enableoutline( target, var_a60e535b918b61cc = undefined )
{
    if ( !isdefined( target.outline_id ) )
    {
        target.outline_id = outline::outlineenableforall( target, var_a60e535b918b61cc ?? "outline_nodepth_red", "level_script" );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x1f7723e4, Offset: 0xf8fc
// Size: 0x3a
function private target_disableoutline( target )
{
    if ( isdefined( target.outline_id ) )
    {
        outline::outlinedisable( target.outline_id, target );
        target.outline_id = undefined;
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x12229c5c, Offset: 0xf93e
// Size: 0x23
function private function_dfda46466478db2a( target, var_78a357bb27545fd4 )
{
    target.ondamagevalidation = var_78a357bb27545fd4;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe2a1ef44, Offset: 0xf969
// Size: 0x8c
function private function_374d87d39fc4b28f( target, var_5fba7026c242c338 )
{
    target notify( #"hash_4f194e6fc0613101" );
    
    if ( !target.var_8ec6c61df26369da )
    {
        function_42c5592ce8a29c26( target, 1, var_5fba7026c242c338 );
        target_disableoutline( target );
        target setcandamage( 0 );
        return;
    }
    
    target_goup( target, var_5fba7026c242c338 );
    target_disableoutline( target );
    target setcandamage( 1 );
    target.health = target.maxhealth;
    thread function_71a7c54086f9cd2c( target );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xad8e86ac, Offset: 0xf9fd
// Size: 0x65
function private function_ed7e4e390edfa669( target, var_71f08fd2cf853161 )
{
    target notify( #"enter_tutorial_mode" );
    target setcandamage( 0 );
    function_42c5592ce8a29c26( target, 0, var_71f08fd2cf853161, 1 );
    target_disableoutline( target );
    target.var_79a79be0f58aae7f = 1;
    target.var_6615e137ca2bc970 = 0;
    thread function_1980abc5d9a71f67( target );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x5ee67063, Offset: 0xfa6a
// Size: 0x169
function private function_71a7c54086f9cd2c( target )
{
    level endon( #"game_ended" );
    target endon( #"delete" );
    target endon( #"enter_tutorial_mode" );
    
    while ( true )
    {
        target waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        var_cb531b3fd6432802 = function_7cef94a8490b6371( attacker.angles, target.angles );
        
        if ( !target.var_7972880ea8fb5b4c && var_cb531b3fd6432802 && utility::getdamagetype( meansofdeath ) == "bullet" )
        {
            continue;
        }
        
        target.health -= damage;
        is_dead = target.health <= 0;
        showhitmarker( attacker, target, is_dead );
        
        if ( is_dead )
        {
            target notify( #"death" );
            target setcandamage( 0 );
            function_42c5592ce8a29c26( target, !var_cb531b3fd6432802 );
            wait 1.5;
            anim_time = target_goup( target );
            wait anim_time;
            target setcandamage( 1 );
            target.health = target.maxhealth;
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x2c2248f4, Offset: 0xfbdb
// Size: 0x23e
function private function_1980abc5d9a71f67( target )
{
    level endon( #"game_ended" );
    target endon( #"delete" );
    target endon( #"hash_4f194e6fc0613101" );
    
    while ( true )
    {
        target waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, var_7edd83e15d43a9b0 );
        
        if ( weapon.offhandtype == "secondary" && isdefined( attacker ) )
        {
            equipment_ref = attacker equipment_mp::getcurrentequipment( "secondary" );
            
            if ( equipment_ref === "equip_flash" )
            {
                continue;
            }
        }
        
        if ( damage_effects::function_1e948faff668cf2( meansofdeath ) )
        {
            continue;
        }
        
        if ( isdefined( target.ondamagevalidation ) && ![[ target.ondamagevalidation ]]( attacker, meansofdeath, weapon ) )
        {
            if ( isplayer( attacker ) )
            {
                target playsoundtoplayer( "uin_t10_training_course_target_fail", attacker );
            }
            
            continue;
        }
        
        var_cb531b3fd6432802 = function_7cef94a8490b6371( attacker.angles, target.angles );
        
        if ( !target.var_7972880ea8fb5b4c && var_cb531b3fd6432802 && utility::getdamagetype( meansofdeath ) == "bullet" )
        {
            continue;
        }
        
        target.var_6615e137ca2bc970++;
        is_dead = target.var_6615e137ca2bc970 >= target.var_79a79be0f58aae7f;
        showhitmarker( attacker, target, is_dead );
        
        if ( is_dead )
        {
            target notify( #"death" );
            target setcandamage( 0 );
            function_42c5592ce8a29c26( target, !var_cb531b3fd6432802 );
            target_disableoutline( target );
            
            if ( isplayer( attacker ) )
            {
                target playsoundtoplayer( "uin_t10_training_course_target_success", attacker );
            }
            
            target.var_6615e137ca2bc970 = 0;
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x683526fa, Offset: 0xfe21
// Size: 0x60
function private function_7cef94a8490b6371( attacker_angles, target_angles )
{
    attacker_forward = vectornormalize( anglestoforward( attacker_angles ) );
    target_forward = vectornormalize( anglestoforward( target_angles ) );
    damage_dot_product = vectordot( attacker_forward, target_forward );
    is_behind_target = damage_dot_product >= 0;
    return is_behind_target;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x64959a5b, Offset: 0xfe8a
// Size: 0x6b
function private showhitmarker( attacker, victim, is_dead )
{
    attacker damagefeedback::updatehitmarker( "standard", is_dead, 0, 0, undefined, undefined, undefined, undefined, 1, undefined, 1 );
    attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", is_dead ? 1 : 0, { #victimentity:victim } );
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x11a612a5, Offset: 0xfefd
// Size: 0x156
function private function_c2bdaa68bf39d803( chevron_type, var_fb035a7b0ad53750, perimeter_vertices, var_7e40d40f67122c1b = 1, var_73d12631951e4c7b = 0 )
{
    if ( perimeter_vertices.size < 3 )
    {
        assertmsg( "<dev string:x1d1>" );
        return [];
    }
    
    inward_normals = function_bfd4538e73b78d19( perimeter_vertices, 1 );
    chevrons = [];
    
    for ( i = 0; i < perimeter_vertices.size ; i++ )
    {
        if ( !var_7e40d40f67122c1b && i == perimeter_vertices.size - 1 )
        {
            break;
        }
        
        middle_vector = ( inward_normals[ i ] + inward_normals[ ( i + 1 ) % inward_normals.size ] ) * 0.5;
        var_200af70048253636 = ( 0, vectortoangles( middle_vector )[ 1 ], 0 );
        var_9dfd5783fe0e619b = !var_7e40d40f67122c1b && i == 0 ? 0 : 1;
        chevron_line = function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, perimeter_vertices[ i ], perimeter_vertices[ ( i + 1 ) % perimeter_vertices.size ], vectortoangles( inward_normals[ i ] ), var_200af70048253636, var_73d12631951e4c7b, var_9dfd5783fe0e619b );
        chevrons = arraycombine( chevrons, chevron_line );
    }
    
    /#
        if ( getdvarint( @"hash_116be81c99e1c527", 0 ) == 1 )
        {
            thread function_5510c4ea1694380d( perimeter_vertices, inward_normals );
        }
    #/
    
    return chevrons;
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x91a3e87c, Offset: 0x1005c
// Size: 0xd5
function private function_a017d1ec37595fa( chevron_type, circle_origin, radius, step_size, var_ef43d1064d479fdd = 0 )
{
    circle_vertices = plotcircle( circle_origin, radius, step_size );
    chevrons = [];
    
    for ( i = 0; i < circle_vertices.size ; i++ )
    {
        direction = undefined;
        
        if ( var_ef43d1064d479fdd )
        {
            direction = circle_origin - circle_vertices[ i ];
        }
        else
        {
            direction = circle_vertices[ i ] - circle_origin;
        }
        
        angles = vectortoangles( direction );
        chevron = spawnscriptable( chevron_type, circle_vertices[ i ], angles );
        chevron setscriptablepartstate( "chevron_0", "contested" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace t10_training_course
// Params 8, eflags: 0x4
// Checksum 0xe8a250e1, Offset: 0x1013a
// Size: 0x180
function private function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, start_origin, end_origin, angles, var_9d537a9ea9d659bf = undefined, heightaboveground = 0, var_9dfd5783fe0e619b = 0 )
{
    if ( !isdefined( var_9d537a9ea9d659bf ) )
    {
        var_9d537a9ea9d659bf = angles;
    }
    
    direction = vectornormalize( end_origin - start_origin );
    point_distance = distance( end_origin, start_origin );
    var_599cbf71370a2947 = int( ceil( point_distance / var_fb035a7b0ad53750 ) );
    var_c413de20b2897373 = point_distance / var_599cbf71370a2947;
    chevrons = [];
    
    for ( i = var_9dfd5783fe0e619b ? 1 : 0; i < var_599cbf71370a2947 + 1 ; i++ )
    {
        x = start_origin[ 0 ] + var_c413de20b2897373 * i * direction[ 0 ];
        y = start_origin[ 1 ] + var_c413de20b2897373 * i * direction[ 1 ];
        z = start_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + heightaboveground );
        chevron = spawnscriptable( chevron_type, origin, i == var_599cbf71370a2947 ? var_9d537a9ea9d659bf : angles );
        chevron setscriptablepartstate( "chevron_0", "idle" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x8bdbfdaf, Offset: 0x102c3
// Size: 0xee
function private function_871cc06a4aaadaf5( tutorial, var_fb035a7b0ad53750, chevrons_vertices, angles = ( 0, 0, 0 ), var_7e40d40f67122c1b = 0 )
{
    if ( chevrons_vertices.size < 2 )
    {
        assertmsg( "<dev string:x20b>" );
        return;
    }
    
    chevrons = undefined;
    
    if ( chevrons_vertices.size == 2 )
    {
        chevrons = function_81f25287b76e02b2( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices[ 0 ], chevrons_vertices[ 1 ], angles );
    }
    else
    {
        chevrons = function_c2bdaa68bf39d803( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices, var_7e40d40f67122c1b );
    }
    
    function_1ba47b7678db87c3( chevrons, "off" );
    
    if ( !isdefined( tutorial.oob_chevrons ) )
    {
        tutorial.oob_chevrons = [];
    }
    
    tutorial.oob_chevrons = arraycombine( tutorial.oob_chevrons, chevrons );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe54acdad, Offset: 0x103b9
// Size: 0x81
function private deletechevrons( chevron_array )
{
    foreach ( chevron in chevron_array )
    {
        chevron freescriptable();
    }
    
    chevron_array = [];
    return chevron_array;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xca50154c, Offset: 0x10443
// Size: 0xb0
function private function_1ba47b7678db87c3( chevron_array, state )
{
    if ( !isdefined( chevron_array ) )
    {
        return;
    }
    
    if ( chevron_array.size > 0 && chevron_array[ 0 ] getscriptablepartstate( "chevron_0" ) == state )
    {
        return;
    }
    
    foreach ( chevron in chevron_array )
    {
        chevron setscriptablepartstate( "chevron_0", state );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x97aa3778, Offset: 0x104fb
// Size: 0x24
function private function_d7e4d4b8d06945ac( player_team )
{
    return player_team == "axis" ? "axis" : "contested";
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe8cdfd2e, Offset: 0x10528
// Size: 0x24
function private function_74fb2b19273b495a( player_team )
{
    return player_team == "axis" ? "allies" : "axis";
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xe7c589c8, Offset: 0x10555
// Size: 0x131
function private function_bfd4538e73b78d19( vertices, var_5dbb6ff207c17611 )
{
    normals = [];
    centroid = ( 0, 0, 0 );
    
    foreach ( vertex in vertices )
    {
        centroid += vertex;
    }
    
    centroid /= vertices.size;
    
    for ( i = 0; i < vertices.size ; i++ )
    {
        edgevector = vertices[ ( i + 1 ) % vertices.size ] - vertices[ i ];
        normal = ( edgevector[ 1 ] * -1, edgevector[ 0 ], 0 );
        toedge = vertices[ i ] - centroid;
        
        if ( var_5dbb6ff207c17611 && vectordot( toedge, normal ) > 0 )
        {
            normal *= -1;
        }
        
        normal = vectornormalize2( normal );
        normals[ normals.size ] = normal;
    }
    
    return normals;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xf312a605, Offset: 0x1068f
// Size: 0xe4
function private plotcircle( center_origin, radius, step_size )
{
    pi = 3.14159;
    centerx = center_origin[ 0 ];
    centery = center_origin[ 1 ];
    circle_vertices = [];
    theta = 0;
    
    while ( theta <= 2 * pi )
    {
        radians = theta * 180 / pi;
        x = round( centerx + radius * cos( radians ) );
        y = round( centery + radius * sin( radians ) );
        z = center_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        circle_vertices[ circle_vertices.size ] = origin;
        theta += step_size;
    }
    
    return circle_vertices;
}

/#

    // Namespace t10_training_course
    // Params 2, eflags: 0x4
    // Checksum 0xebdc9987, Offset: 0x1077c
    // Size: 0x114, Type: dev
    function private function_5510c4ea1694380d( perimeter_vertices, normals )
    {
        while ( true )
        {
            for ( i = 0; i < perimeter_vertices.size ; i++ )
            {
                sphere( perimeter_vertices[ i ], 5, ( 0, 1, 0 ), 0, 1 );
                print3d( perimeter_vertices[ i ], string( i ), ( 1, 0, 0 ), 1, 1, 1, 1 );
                
                if ( i < perimeter_vertices.size - 1 )
                {
                    line( perimeter_vertices[ i ], perimeter_vertices[ i + 1 ], ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            if ( perimeter_vertices.size > 1 )
            {
                line( perimeter_vertices[ perimeter_vertices.size - 1 ], perimeter_vertices[ 0 ], ( 1, 0, 0 ), 1, 0, 1 );
            }
            
            for ( i = 0; i < normals.size ; i++ )
            {
                normal = normals[ i ];
                utility::draw_arrow( perimeter_vertices[ i ], perimeter_vertices[ i ] + normal * 50, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace t10_training_course
    // Params 1, eflags: 0x4
    // Checksum 0x93b6aa09, Offset: 0x10898
    // Size: 0xd9, Type: dev
    function private function_347c90461fb33c06( player )
    {
        thread namespace_a4e869218d89862b::function_18eb5a324873d647( player, 0 );
        thread namespace_6826532b84b72321::function_eccd82ae06166efe( player, 1 );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x24b>", "<dev string:x257>", &maprestart, [ "<dev string:x26d>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x270>", "<dev string:x257>", &benchmark_mp_utils::function_6f4cc32a47b35564, [ "<dev string:x27e>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x280>", "<dev string:x257>", &benchmark_mp_utils::function_6d90b52e7f66709a, [ "<dev string:x29b>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x2a2>", "<dev string:x257>", &benchmark_mp_utils::function_6cf247353c5bcf3, [ "<dev string:x2c2>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x2c8>", "<dev string:x257>", &benchmark_mp_utils::function_a7dd34380de169ca );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x2dc>", "<dev string:x257>", &benchmark_mp_utils::function_6d778e3befe26811 );
        benchmark_mp_utils::function_abeeb86ec4c08184( player );
    }

    // Namespace t10_training_course
    // Params 1, eflags: 0x4
    // Checksum 0xd2c988cc, Offset: 0x10979
    // Size: 0x10b, Type: dev
    function private initdevgui( tutorial_dictionary )
    {
        devgui::function_9082edeb5db93280( "<dev string:x2ec>" );
        
        foreach ( tutorial in tutorial_dictionary )
        {
            tutorial_name = function_399e310dabe4c2cc( tutorial );
            devgui::function_cd4e263c1f3018ae( "<dev string:x305>" + tutorial_name, "<dev string:x312>" + tutorial_name, &function_97c3481032bc4794 );
        }
        
        devgui::add_devgui_func( "<dev string:x31c>", "<dev string:x335>", &function_e0bc9800d93004d9 );
        devgui::add_devgui_func( "<dev string:x34e>", "<dev string:x364>", &function_ea7141d81b8cd774 );
        
        if ( getdvarint( @"hash_8e70563bddaf0da" ) )
        {
            devgui::add_devgui_func( "<dev string:x37a>", "<dev string:x38f>", &function_941a5eef5ac77191 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace t10_training_course
    // Params 1, eflags: 0x4
    // Checksum 0xb66e0d8f, Offset: 0x10a8c
    // Size: 0x91, Type: dev
    function private function_97c3481032bc4794( params )
    {
        if ( !isdefined( level.players[ 0 ] ) )
        {
            return;
        }
        
        tutorial_name = string( params[ 0 ] );
        tutorial = level.players[ 0 ].tutorial_dictionary[ tutorial_name ];
        
        if ( isdefined( tutorial ) )
        {
            level.players[ 0 ] setorigin( tutorial.respawn_position );
            level.players[ 0 ] setplayerangles( tutorial.respawn_angles );
        }
    }

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0xa766c9a, Offset: 0x10b25
    // Size: 0x54, Type: dev
    function private function_e0bc9800d93004d9()
    {
        if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].current_tutorial ) )
        {
            thread completetutorial( level.players[ 0 ], level.players[ 0 ].current_tutorial );
        }
    }

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0x7e2311f6, Offset: 0x10b81
    // Size: 0x147, Type: dev
    function private function_941a5eef5ac77191()
    {
        if ( !isdefined( level.players[ 0 ] ) )
        {
            return;
        }
        
        if ( !getdvarint( @"hash_8e70563bddaf0da" ) || !function_3c77ed00cac74efe( level.players[ 0 ].tutorial_dictionary[ "<dev string:x3a4>" ] ) )
        {
            return;
        }
        
        if ( isdefined( level.players[ 0 ].current_tutorial ) )
        {
            function_e0bc9800d93004d9();
            waitframe();
        }
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !function_faefa119842f585b( tutorial ) && function_8b878dec24bedc0e( tutorial ) != 7 )
            {
                thread starttutorial( level.players[ 0 ], tutorial, 0, 0, 0, 0, undefined );
                waitframe();
                thread completetutorial( level.players[ 0 ], tutorial, 0 );
                waitframe();
            }
        }
        
        function_97c3481032bc4794( [ "<dev string:x3a4>" ] );
    }

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0xd18ea8b2, Offset: 0x10cd0
    // Size: 0xde, Type: dev
    function private function_ea7141d81b8cd774()
    {
        if ( isdefined( level.players[ 0 ].current_tutorial ) )
        {
            function_e0bc9800d93004d9();
            waitframe();
        }
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !function_faefa119842f585b( tutorial ) )
            {
                thread starttutorial( level.players[ 0 ], tutorial, 0, 0, 0, 0, undefined );
                waitframe();
                thread completetutorial( level.players[ 0 ], tutorial, 0 );
                waitframe();
            }
        }
    }

    // Namespace t10_training_course
    // Params 0, eflags: 0x4
    // Checksum 0xedf5cf79, Offset: 0x10db6
    // Size: 0xf, Type: dev
    function private maprestart()
    {
        adddebugcommand( "<dev string:x3aa>" );
    }

    // Namespace t10_training_course
    // Params 1, eflags: 0x4
    // Checksum 0x2085f91a, Offset: 0x10dcd
    // Size: 0xd8, Type: dev
    function private function_7464143c7de6c610( targets )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( index, targetdata in targets )
            {
                target = targetdata.target;
                
                if ( isdefined( target ) )
                {
                    print3d( target.origin, "<dev string:x3b7>" + index + 1, ( 0, 1, 0 ), 1, 1, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace t10_training_course
// Params 0
// Checksum 0xd24782eb, Offset: 0x10ead
// Size: 0xa1
function function_10cc2b82142318c3()
{
    tutorials = [];
    
    foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
    {
        if ( isdefined( tutorial.var_fe1e173811f47789 ) )
        {
            tutorials[ tutorials.size ] = tutorial;
        }
    }
    
    return tutorials;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xd7c3eaff, Offset: 0x10f57
// Size: 0xb5
function private function_bf3e729263fcc10( bot, agent, initial_wait_time )
{
    bot.spectating_player endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    agent endon( #"death" );
    wait initial_wait_time;
    
    if ( isdefined( bot ) )
    {
        weapon = bot getcurrentweapon();
        
        if ( isdefined( weapon ) )
        {
            wait_time = 0.05;
            weap_fire_time = weaponfiretime( weapon );
            
            if ( isdefined( weap_fire_time ) )
            {
                wait_time = max( wait_time, weap_fire_time );
            }
            
            while ( isdefined( bot ) )
            {
                bot botpressbutton( "attack" );
                wait wait_time;
            }
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x665e61ce, Offset: 0x11014
// Size: 0x89
function private function_fd6bf4c76734b916( bot, entity )
{
    bot endon( #"death_or_disconnect" );
    entity endon( #"death" );
    cos_fov_angle = cos( 45 );
    
    while ( true )
    {
        bot botlookatpoint( entity geteye() - ( 0, 0, 15 ), 0.1, "script_forced" );
        
        if ( function_7517ebd4fc6719f0( bot, entity, cos_fov_angle ) )
        {
            bot notify( #"entity_in_view" );
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xabf868c, Offset: 0x110a5
// Size: 0x75
function private function_7517ebd4fc6719f0( bot, entity, cos_fov_angle )
{
    trace = trace::ray_trace( bot geteye(), entity geteye(), bot, undefined );
    
    if ( trace[ "entity" ] === entity )
    {
        return withinfov( bot.origin, bot.angles, entity.origin, cos_fov_angle );
    }
    
    return 0;
}

// Namespace t10_training_course
// Params 1
// Checksum 0xb62f590d, Offset: 0x11123
// Size: 0x9f
function function_729244fb63340d85( player )
{
    bots = function_8658dfb45f6b84c8( player.map_instance_index );
    
    foreach ( bot in bots )
    {
        if ( !function_1acdd48d868bc909( bot ) )
        {
            return bot;
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x200b0351, Offset: 0x111cb
// Size: 0xa8
function private function_c8702ddd4540ea28( player )
{
    bots = function_8658dfb45f6b84c8( player.map_instance_index );
    
    foreach ( bot in bots )
    {
        if ( function_1acdd48d868bc909( bot ) && isalive( bot ) )
        {
            return bot;
        }
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x3c7bee97, Offset: 0x1127c
// Size: 0xaf
function private spawnbot( origin, angles, team = "allies" )
{
    fixedspawndata = spawnstruct();
    fixedspawndata.origin = origin;
    fixedspawndata.angles = angles;
    level thread [[ level.bot_funcs[ "bots_spawn" ] ]]( 1, team, undefined, undefined, undefined, undefined, fixedspawndata );
    
    do
    {
        level waittill( #"player_spawned", newai );
    }
    while ( !isbot( newai ) );
    
    function_f84dc38c3e66bb65( newai );
    newai setorigin( origin );
    newai setplayerangles( angles );
    return newai;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xb23995fd, Offset: 0x11334
// Size: 0xde
function private function_f84dc38c3e66bb65( bot )
{
    bot sethidenameplate( 1 );
    bot botsetpathingstyle( "scripted" );
    bot botsetawareness( 0 );
    bot botsetstance( "stand" );
    bot botsetflag( "force_sprint", 1 );
    bot.custom_personality_update_function = &utility::empty_init_func;
    bot.sessionstate = "playing";
    bot.skipspawncamera = 1;
    bot.ignoreall = 1;
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "dont_path_to_enemy", 1 );
    bot botsetflag( "disable_random_goal", 1 );
    bot botsetflag( "no_enemy_search", 1 );
    bot botsetscriptmove( 0, 0, 1 );
    bot botlookatpoint( undefined );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x7d07bcdb, Offset: 0x1141a
// Size: 0x18, Type: bool
function private function_1acdd48d868bc909( bot )
{
    return istrue( bot.is_meatshield_bot );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe3e59cdd, Offset: 0x1143b
// Size: 0x45
function private waitforplayerspawned( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    do
    {
        level waittill( #"player_spawned", spawned_player );
    }
    while ( player != spawned_player );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xd9ff58cd, Offset: 0x11488
// Size: 0x5c
function private function_b26daaaa9debed6e( player, tutorial )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player notifyonplayercommand( "exit_tutorial_preview", "+gostand" );
    player waittill( #"exit_tutorial_preview" );
    thread restarttutorial( player, tutorial, 0, 0, 0, undefined );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xd5101ab2, Offset: 0x114ec
// Size: 0x1fc
function private luinotifylistener( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, arg );
        
        if ( msg == "training_course_leave_game" )
        {
            if ( function_d39dfc7ac04716ef( player ) )
            {
                function_816ecee4d7db0c68( player, function_d18dd74017e9db87( player.map_instance_index ), 1 );
            }
            else
            {
                current_value = player getclientomnvar( "training_course_leave_game_request" );
                player setclientomnvar( "training_course_leave_game_request", !current_value );
            }
            
            continue;
        }
        
        tutorial = player.current_tutorial;
        
        if ( !isdefined( tutorial ) )
        {
            continue;
        }
        
        while ( player isinexecutionvictim() || player isinexecutionattack() )
        {
            waitframe();
        }
        
        if ( msg == "exit_current_training_course_station" && ( function_d1d2cf69e63f6596( tutorial ) || function_cbcead310c3cf8bd( tutorial ) || function_faa438d8de9a4dc9( player ) ) )
        {
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 1;
            }
            else
            {
                thread exittutorial( player, tutorial, 1 );
            }
            
            continue;
        }
        
        if ( msg == "triptychs_training_course_station_start" )
        {
            tutorial notify( #"triptychs_training_course_station_start" );
            continue;
        }
        
        if ( msg == "tutorial_station_instructions_training_course" && ( function_d1d2cf69e63f6596( tutorial ) || function_cbcead310c3cf8bd( tutorial ) ) )
        {
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 2;
            }
            else
            {
                thread restarttutorial( player, tutorial, 0, 1, 0, undefined );
            }
            
            continue;
        }
        
        if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && msg == "training_course_preview_station" )
        {
            if ( function_faa438d8de9a4dc9( player ) )
            {
                function_dfb331efe033ac6c( player, tutorial, 0, 0 );
            }
            
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 0;
                continue;
            }
            
            thread starttutorial( player, tutorial, 0, 1, 1, 0, undefined );
        }
    }
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0x5e08cfeb, Offset: 0x116f0
// Size: 0x73
function private function_dfb331efe033ac6c( player, tutorial, should_show, play_sound )
{
    packed_index = function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number;
    player setclientomnvar( "show_training_course_triptychs", should_show ? packed_index : -1 );
    
    if ( play_sound )
    {
        player playlocalsound( "uin_t10_training_course_triptych_screen" );
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x68f06b2e, Offset: 0x1176b
// Size: 0x1a, Type: bool
function private function_faa438d8de9a4dc9( player )
{
    return player getclientomnvar( "show_training_course_triptychs" ) != -1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xa70bf2ab, Offset: 0x1178e
// Size: 0x71
function private function_3a0aec7f1e9988a3( player, tutorial )
{
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( player.var_bb4f4ac000751f63 == tutorial.order_number )
    {
        function_8becb86703380fc7( player, tutorial, 0, 1 );
    }
    
    player setclientomnvar( "training_course_in_station_range", function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xedf9ed6, Offset: 0x11807
// Size: 0x5c
function private function_5c1689103ca32d82( player, tutorial )
{
    if ( player getclientomnvar( "training_course_in_station_range" ) != -1 )
    {
        player setclientomnvar( "training_course_in_station_range", -1 );
        
        if ( player.var_bb4f4ac000751f63 == tutorial.order_number )
        {
            function_8becb86703380fc7( player, tutorial, 1, 1 );
        }
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x3aff0eb2, Offset: 0x1186b
// Size: 0x65
function private showfailhint( player, tutorial )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !function_32d334aad6bf0ad3( tutorial ) )
    {
        return;
    }
    
    player setclientomnvar( "training_course_fail_hint_string_index", function_d654ebca885f4644( tutorial ) );
    function_6c0ff087784b7b0( tutorial, undefined );
    wait 5;
    function_df581661be9ca5c5( player );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x85a20e43, Offset: 0x118d8
// Size: 0x2b
function private function_df581661be9ca5c5( player )
{
    if ( player getclientomnvar( "training_course_fail_hint_string_index" ) != -1 )
    {
        player setclientomnvar( "training_course_fail_hint_string_index", -1 );
    }
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x4e9d4983, Offset: 0x1190b
// Size: 0x3b
function private function_6c0ff087784b7b0( tutorial, string_reference )
{
    if ( isdefined( string_reference ) )
    {
        tutorial.var_a9ecb0261b0cf3cf = getlocstringindex( string_reference );
        return;
    }
    
    tutorial.var_a9ecb0261b0cf3cf = undefined;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xd5864a09, Offset: 0x1194e
// Size: 0x17
function private function_d654ebca885f4644( tutorial )
{
    return tutorial.var_a9ecb0261b0cf3cf;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xf3953c57, Offset: 0x1196e
// Size: 0x15, Type: bool
function private function_32d334aad6bf0ad3( tutorial )
{
    return isdefined( function_d654ebca885f4644( tutorial ) );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xab3a7a95, Offset: 0x1198c
// Size: 0x3e
function private function_a6e8c085165e0898( player, cached_string_ref, objective_type )
{
    player setclientomnvar( "training_course_current_objective_string_index", getlocstringindex( cached_string_ref ) );
    player setclientomnvar( "training_course_current_objective_type", objective_type );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x8451af14, Offset: 0x119d2
// Size: 0x28
function private function_5e3e773127f754db( player )
{
    player setclientomnvar( "training_course_current_objective_string_index", -1 );
    player setclientomnvar( "training_course_current_objective_type", -1 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x4c2a40a4, Offset: 0x11a02
// Size: 0x1a, Type: bool
function private function_1c1639bf73457e80( player )
{
    return player getclientomnvar( "training_course_current_objective_string_index" ) != -1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb34e7b39, Offset: 0x11a25
// Size: 0x1f
function private function_ac53a17fd5b74658( player, cached_string_ref )
{
    thread function_b06367ba6447e8f9( player, cached_string_ref );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x187a2313, Offset: 0x11a4c
// Size: 0x44
function private function_b06367ba6447e8f9( player, cached_string_ref )
{
    player endon( #"disconnect" );
    player endon( #"hash_47e8102cc99b102a" );
    wait 1;
    player setclientomnvar( "training_course_current_hint_string_index", getlocstringindex( cached_string_ref ) );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x16dcd606, Offset: 0x11a98
// Size: 0x27
function private function_55099ffa73b4eff1( player )
{
    player notify( #"hash_47e8102cc99b102a" );
    player setclientomnvar( "training_course_current_hint_string_index", -1 );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xe0bad403, Offset: 0x11ac7
// Size: 0x1a, Type: bool
function private function_33427acbfd53222( player )
{
    return player getclientomnvar( "training_course_current_hint_string_index" ) != -1;
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xe800359, Offset: 0x11aea
// Size: 0x37
function private function_98702f770499bea1( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d );
    player setclientomnvar( "training_course_show_target_counter", 1 );
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0xb296b4ee, Offset: 0x11b29
// Size: 0x34
function private function_c58312077098c9c8( player, delay = 0 )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    player setclientomnvar( "training_course_show_target_counter", 0 );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x4c18b596, Offset: 0x11b65
// Size: 0x40
function private function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    packed_index = current_targets_hit << 8 | var_3e798f5e5d58dd8d;
    player setclientomnvar( "training_course_current_targets_hit", packed_index );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x89e5d7eb, Offset: 0x11bad
// Size: 0x17
function private function_ce08700870078f55( player )
{
    return player getclientomnvar( "training_course_show_target_counter" );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xec1180df, Offset: 0x11bcd
// Size: 0x5e
function private showobjectivemarker( player, objective_marker, origin )
{
    objidpoolmanager::update_objective_position( objective_marker.objidnum, origin );
    objidpoolmanager::objective_playermask_addshowplayer( objective_marker.objidnum, player );
    objective_marker.origin = origin;
    thread function_9099e762beedc948( player, objective_marker );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x5ed185ca, Offset: 0x11c33
// Size: 0x2b
function private hideobjectivemarker( objective_marker )
{
    objidpoolmanager::objective_playermask_hidefromallplayers( objective_marker.objidnum );
    objective_marker notify( #"hidden" );
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x818a37b9, Offset: 0x11c66
// Size: 0x17
function private function_49422e31150c2fc9( player )
{
    return player.global_objective_marker;
}

// Namespace t10_training_course
// Params 4, eflags: 0x4
// Checksum 0xcb5b7e41, Offset: 0x11c86
// Size: 0x8c
function private function_7107038b2232bbb2( player, objective_marker, waypoint_position, var_2194257a90af9f5c = undefined )
{
    if ( function_124de228f3c03556( player, waypoint_position ) )
    {
        return;
    }
    
    function_a6e8c085165e0898( player, var_2194257a90af9f5c ?? &"t10_training_course/next_objective", 3 );
    showobjectivemarker( player, objective_marker, waypoint_position );
    objective_marker waittill( #"hash_fc0d26dcd2b34574" );
    hideobjectivemarker( objective_marker );
    function_5e3e773127f754db( player );
    player playlocalsound( "uin_t10_training_course_objective_success" );
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0x9575e0b6, Offset: 0x11d1a
// Size: 0x95
function private function_9099e762beedc948( player, objective_marker, var_e620d5604e2870d = 150 )
{
    level endon( #"game_ended" );
    objective_marker endon( #"hidden" );
    player endon( #"disconnect" );
    objective_marker notify( #"end" );
    objective_marker endon( #"end" );
    
    while ( true )
    {
        if ( function_124de228f3c03556( player, objective_marker.origin, var_e620d5604e2870d ) )
        {
            objective_marker notify( #"hash_fc0d26dcd2b34574" );
        }
        
        waitframe();
    }
}

// Namespace t10_training_course
// Params 3, eflags: 0x4
// Checksum 0xdb85f26b, Offset: 0x11db7
// Size: 0x3b, Type: bool
function private function_124de228f3c03556( player, marker_position, var_e620d5604e2870d = 150 )
{
    return distance( player.origin, marker_position ) <= var_e620d5604e2870d;
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xff815202, Offset: 0x11dfb
// Size: 0x22
function private function_3f5c1e59764b640d( var_2c240cccdbc45e6f )
{
    return { #var_49411d93b2ea3681:[], #var_b6b6603ac7a33cd1:var_2c240cccdbc45e6f };
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0x7c77af2, Offset: 0x11e26
// Size: 0x12f
function private function_402d34de715b6a70( var_37fbd8ffcf5239db )
{
    if ( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size == 0 )
    {
        var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1 = var_37fbd8ffcf5239db.var_49411d93b2ea3681;
        var_37fbd8ffcf5239db.var_49411d93b2ea3681 = [];
    }
    
    var_e0582ca146e9dcc1 = randomintrange( 0, var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size );
    random_element = var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_e0582ca146e9dcc1 ];
    
    if ( isdefined( var_37fbd8ffcf5239db.var_9987219c72fa8017 ) )
    {
        var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size ] = var_37fbd8ffcf5239db.var_9987219c72fa8017;
        var_37fbd8ffcf5239db.var_9987219c72fa8017 = undefined;
    }
    
    if ( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size - 1 == 0 && var_37fbd8ffcf5239db.var_49411d93b2ea3681.size > 0 )
    {
        var_37fbd8ffcf5239db.var_9987219c72fa8017 = random_element;
    }
    else
    {
        var_37fbd8ffcf5239db.var_49411d93b2ea3681[ var_37fbd8ffcf5239db.var_49411d93b2ea3681.size ] = random_element;
    }
    
    var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_e0582ca146e9dcc1 ] = undefined;
    
    if ( isint( var_e0582ca146e9dcc1 ) )
    {
        function_cdc669dbc8ea2101( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1 );
    }
    
    return random_element;
}

// Namespace t10_training_course
// Params 5, eflags: 0x4
// Checksum 0x96fc63cd, Offset: 0x11f5e
// Size: 0xb4
function private function_e79357e1bec9adad( entity, var_29691d75e54312f0, should_interrupt = 1, var_6060be762a9e08e6 = undefined, var_81626ca7ebc7e102 = undefined )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( isplayer( entity ) )
    {
        entity endon( #"disconnect" );
    }
    
    entity endon( #"hash_6643ac25fca32e44" );
    
    if ( isdefined( var_6060be762a9e08e6 ) )
    {
        wait var_6060be762a9e08e6;
    }
    
    for ( i = 0; i < var_29691d75e54312f0.size ; i++ )
    {
        if ( isdefined( entity ) )
        {
            entity dialogue::say( var_29691d75e54312f0[ i ], should_interrupt, 2.5, 0, var_81626ca7ebc7e102 );
        }
    }
}

// Namespace t10_training_course
// Params 1, eflags: 0x4
// Checksum 0xbb604442, Offset: 0x1201a
// Size: 0xde
function private function_7adb5b9ebd7540c3( player )
{
    if ( isdefined( player.black_overlay ) )
    {
        return player.black_overlay;
    }
    
    black_overlay = newclienthudelem( player );
    black_overlay.x = 0;
    black_overlay.y = 0;
    black_overlay setshader( "black", 640, 480 );
    black_overlay.alignx = "left";
    black_overlay.aligny = "top";
    black_overlay.sort = 1;
    black_overlay.horzalign = "fullscreen";
    black_overlay.vertalign = "fullscreen";
    black_overlay.foreground = 1;
    player.black_overlay = black_overlay;
    return player.black_overlay;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x77b4b35e, Offset: 0x12101
// Size: 0x62
function private function_48b7033aa12c2f72( player, time_seconds )
{
    black_overlay = function_7adb5b9ebd7540c3( player );
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 1;
        return;
    }
    
    black_overlay.alpha = 0;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 1;
}

// Namespace t10_training_course
// Params 2, eflags: 0x4
// Checksum 0x1c6ccbe2, Offset: 0x1216b
// Size: 0x61
function private function_471eaf1a49ed9cc9( player, time_seconds )
{
    black_overlay = function_7adb5b9ebd7540c3( player );
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 0;
        return;
    }
    
    black_overlay.alpha = 1;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 0;
}

