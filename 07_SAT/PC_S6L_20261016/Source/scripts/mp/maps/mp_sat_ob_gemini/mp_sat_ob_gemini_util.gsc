// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util.gsc  (hash_21f6168ac622f17e.gscc) (size: 168231 Bytes / 0x29127 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1ef77af (3790567343)
// size ...... 168231 (0x29127)
// includes .. 61  (offset: 0x26c5b)
// strings ... 489 (offset: 0x26e43)
// dev strs .. 70  (offset: 0x28daf)
// exports ... 401 (offset: 0x1b503)
// cseg ...... 0x2c20 + 0x188e3 (0x1b503)
// imports ... 873 (offset: 0x1f3ab)
// animtree1 . 1   (offset: 0x2911b)
// animtree2 . 0   (offset: 0x29127)
#using script_2399696a9d953451;
#using script_30152080457bb762;
#using script_3016732d4c7eef02;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\stealth\player;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\ai\stealth\threat_sight_sw;
#using scripts\common\ai\stealth\utility;
#using scripts\common\ai_lookat;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\save;
#using scripts\common\scene;
#using scripts\common\screens;
#using scripts\common\scriptable;
#using scripts\common\scripted_widgets;
#using scripts\common\snd\snd;
#using scripts\common\swim_common;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\radiation;
#using scripts\mp\weapons;

#namespace gemini_util;

// Namespace gemini_util
// Params 1
// Checksum 0x9638690c, Offset: 0x2c3e
// Size: 0x3a
function player_setup( params )
{
    ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm", 1 );
    knife = makeweapon( "sat_me_knife_mp" );
    item_weapon::function_40e1cbd0e1f47d1a( knife, 2 );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x7d8f0f16, Offset: 0x2c80
    // Size: 0x5, Type: dev
    function function_6580b97e11295b79()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0x69461bdd, Offset: 0x2c8d
// Size: 0xdb
function function_34a3d0cff5de2d7d()
{
    if ( utility::flag( "flag_area_denial_zone_init_complete" ) && isarray( level.var_117f58399f256fb6.radiation_array ) )
    {
        foreach ( radiation in level.var_117f58399f256fb6.radiation_array )
        {
            level.var_117f58399f256fb6.radiation_array = arrayremove( level.var_117f58399f256fb6.radiation_array, radiation );
            radiation radiation::destroy();
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xe49489fb, Offset: 0x2d70
// Size: 0x108
function function_fe0b04783865b1e7( radiation_instance )
{
    self notify( #"hash_6addeb8d17960e65" );
    self endon( #"hash_6addeb8d17960e65" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    while ( isdefined( radiation_instance ) )
    {
        a_players = ob_story_mission_utils::get_playing_players();
        var_c82e00cb432f0666 = sortbydistancecullbyradius( a_players, radiation_instance.origin, radiation_instance.radius );
        
        foreach ( player in a_players )
        {
            if ( !arraycontains( var_c82e00cb432f0666, player ) )
            {
                player notify( #"hash_3e3a4c0ff24d6c0" );
            }
        }
        
        wait 1;
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xb795b920, Offset: 0x2e80
// Size: 0xd6
function function_7da3d7491a75f0a8( a_structs, cradle_state, var_5c81841369a17676 = 0.2 )
{
    level endon( #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    player = self;
    
    if ( !isdefined( a_structs ) || a_structs.size <= 0 )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( !isarray( a_structs ) )
    {
        a_structs = [ a_structs ];
    }
    
    while ( !isdefined( level.cradle_clip_state ) )
    {
        wait 0.1;
    }
    
    while ( true )
    {
        if ( player utility::ent_flag( "player_in_adz" ) && player function_bfc100cd304ce8d2() )
        {
            wait var_5c81841369a17676;
            i = randomint( a_structs.size );
            coop::teleport_player( player, a_structs[ i ] );
        }
        
        wait 0.5;
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x3181d597, Offset: 0x2f5e
// Size: 0xee, Type: bool
function function_bfc100cd304ce8d2()
{
    player = self;
    var_dac75f4116c98678 = undefined;
    var_f1d15ddbe0d00619 = undefined;
    
    switch ( level.cradle_clip_state )
    {
        case #"hash_ed156e54800b5a8e":
            var_dac75f4116c98678 = level.var_3fda6558f07648ce.origin;
            var_f1d15ddbe0d00619 = 3111696;
            break;
        case #"hash_3e51565afccd6946":
            var_dac75f4116c98678 = level.var_8eaf623a9c2bee66.origin;
            var_f1d15ddbe0d00619 = 14776336;
            break;
        case #"hash_a8b4265e671b26e3":
            var_dac75f4116c98678 = level.var_b2bfddd3241c7b59.origin;
            var_f1d15ddbe0d00619 = 7311616;
            break;
    }
    
    if ( !isdefined( var_dac75f4116c98678 ) || !isdefined( var_f1d15ddbe0d00619 ) )
    {
        return false;
    }
    
    dist = distance2dsquared( player.origin, var_dac75f4116c98678 );
    
    if ( dist >= var_f1d15ddbe0d00619 )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x5986cc13, Offset: 0x3055
    // Size: 0x5, Type: dev
    function function_493684a608913f17()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xf59aeecf, Offset: 0x3062
// Size: 0x8a
function function_e9681bbfa6c91f07()
{
    activity_instance = self;
    s_ability_case = utility::getstruct( "s_tunnels_anteroom_ability_case_01", "targetname" );
    
    if ( isdefined( s_ability_case ) )
    {
        if ( !isdefined( s_ability_case.angles ) )
        {
            s_ability_case.angles = ( 0, 0, 0 );
        }
        
        if ( isdefined( s_ability_case ) )
        {
            activity_instance thread ob_story_mission_utils::function_516cfe2bb1eed11f( s_ability_case.origin, "super_survival_life_drain", "super_drone_launcher", "default", s_ability_case.angles );
        }
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x6bb46e51, Offset: 0x30f4
// Size: 0x80
function function_501b62568cd67932()
{
    activity_instance = self;
    s_ability_case = utility::getstruct( "s_tunnels_mine_ability_case_01", "targetname" );
    
    if ( isdefined( s_ability_case ) )
    {
        if ( !isdefined( s_ability_case.angles ) )
        {
            s_ability_case.angles = ( 0, 0, 0 );
        }
        
        activity_instance thread ob_story_mission_utils::function_516cfe2bb1eed11f( s_ability_case.origin, "super_teleport", undefined, "tactical", s_ability_case.angles );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xff9980e9, Offset: 0x317c
// Size: 0xec
function function_139e7e4c5feaaa9d()
{
    activity_instance = self;
    s_ability_case = utility::getstruct( "s_ability_case_underground", "targetname" );
    
    if ( isdefined( s_ability_case ) )
    {
        if ( !isdefined( s_ability_case.angles ) )
        {
            s_ability_case.angles = ( 0, 0, 0 );
        }
        
        var_4f5ed47fac4c0f11 = { #delay:2, #endon_string:"flag_underground_completed", #var_a9496e34ebda5db:&"sat_ob/hint_bubble_shield_gamepad", #var_b53628100ef29954:&"sat_ob/hint_bubble_shield_kbm", #hint_ref_name:"hint_bubble_shield", #equipment_ref:"super_bubble_shield" };
        activity_instance thread ob_story_mission_utils::function_516cfe2bb1eed11f( s_ability_case.origin, "super_survival_life_drain", "super_bubble_shield", "default", s_ability_case.angles, undefined, undefined, var_4f5ed47fac4c0f11 );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x8e7578fb, Offset: 0x3270
    // Size: 0x5, Type: dev
    function function_2566c2c723955fa5()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0x6d185b56, Offset: 0x327d
// Size: 0x237
function function_a91d3ea2a794cb12( struct_noteworthy )
{
    level endon( #"game_ended" );
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    
    if ( isdefined( player.prison_objective ) )
    {
        return;
    }
    
    player.prison_objective = spawnstruct();
    player.prison_objective.b_forward = 1;
    waitframe();
    player.prison_objective.struct_array = function_dcbcae7678809479( struct_noteworthy );
    player.prison_objective.obj_id = player function_bd37bec66d719885( player.prison_objective.struct_array[ 0 ].origin );
    waitframe();
    player childthread function_a4dd5afd504581af();
    player childthread tunnels_prison_objective_end();
    player childthread function_99c88251b79b9058();
    player childthread function_9002581ee8a91e98();
    z_offset = 48;
    var_c7b1aae8162d8b58 = 0;
    var_a86c88c7c43c1148 = "flag_tunnels_anteroom_located";
    
    while ( var_c7b1aae8162d8b58 < player.prison_objective.struct_array.size )
    {
        if ( level utility::flag( "flag_tunnels_solitary_complete" ) )
        {
            var_9cb9f3eadb9fffe0 = 30;
        }
        else
        {
            var_9cb9f3eadb9fffe0 = 20;
        }
        
        objidpoolmanager::update_objective_position( player.prison_objective.obj_id, player.prison_objective.struct_array[ var_c7b1aae8162d8b58 ].origin + ( 0, 0, z_offset ) );
        player childthread function_7a19f3b18cf7118f( var_9cb9f3eadb9fffe0, var_a86c88c7c43c1148, "notify_gemini_tunnels_nag_player" );
        
        if ( var_c7b1aae8162d8b58 - 2 >= 0 )
        {
            level childthread function_2fc6e000cdb0e31e( player.prison_objective, player, var_c7b1aae8162d8b58 - 2 );
        }
        
        level childthread function_1f4a1bb61fd7c3de( player.prison_objective, player, var_c7b1aae8162d8b58 );
        player.prison_objective waittill( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
        var_c7b1aae8162d8b58++;
    }
    
    if ( isdefined( player.prison_objective ) )
    {
        player function_18430f521ce49eca();
        player.prison_objective = undefined;
    }
    
    player notify( #"hash_5394c05476669f37" );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x4a1a41ae, Offset: 0x34bc
// Size: 0x8c
function private function_bd37bec66d719885( obj_origin )
{
    player = self;
    player endon( #"death_or_disconnect" );
    z_offset = 48;
    obj_id = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( %"objectivemarker:sat_ob_objectivemarker_location" );
    objidpoolmanager::objective_set_play_intro( obj_id, 0 );
    objidpoolmanager::objective_set_play_outro( obj_id, 0 );
    objidpoolmanager::update_objective_position( obj_id, obj_origin + ( 0, 0, z_offset ) );
    objidpoolmanager::objective_playermask_hidefromallplayers( obj_id );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    player thread function_1090e73af055171c( obj_id );
    return obj_id;
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xd8815716, Offset: 0x3551
// Size: 0x49
function private function_1090e73af055171c( obj_id )
{
    player = self;
    player endon( #"hash_f532810665d10e07" );
    player waittill( #"death_or_disconnect" );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
    {
        objidpoolmanager::returnobjectiveid( obj_id );
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x2656812e, Offset: 0x35a2
// Size: 0xa5
function private function_b8875dd873572315()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( player.prison_objective ) || !isdefined( player.prison_objective.obj_id ) )
    {
        return;
    }
    
    objidpoolmanager::objective_playermask_hidefromallplayers( player.prison_objective.obj_id );
    function_2b8e3d3ae2a6414a( player.prison_objective.obj_id, 1 );
    ob_story_mission_utils::function_e7dea8423bedc2b6( player.prison_objective.obj_id, level.players );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xf0cacb92, Offset: 0x364f
// Size: 0x81
function private function_706ced214bbe6fc4()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( player.prison_objective ) || !isdefined( player.prison_objective.obj_id ) )
    {
        return;
    }
    
    objidpoolmanager::objective_playermask_addshowplayer( player.prison_objective.obj_id, player );
    function_2b8e3d3ae2a6414a( player.prison_objective.obj_id, 0 );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x4139abad, Offset: 0x36d8
// Size: 0xb3
function private function_18430f521ce49eca()
{
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( player.prison_objective ) || !isdefined( player.prison_objective.obj_id ) )
    {
        return;
    }
    
    ob_story_mission_utils::function_6c52650cb36dd9d3( player.prison_objective.obj_id, [ player ] );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( player.prison_objective.obj_id ) )
    {
        objidpoolmanager::returnobjectiveid( player.prison_objective.obj_id );
    }
    
    player notify( #"hash_f532810665d10e07" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x3f4b2bda, Offset: 0x3793
// Size: 0x85
function private function_a4dd5afd504581af()
{
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    level utility::flag_wait( "flag_tunnels_anteroom_located" );
    
    if ( isdefined( player.prison_objective ) )
    {
        objidpoolmanager::objective_set_play_intro( player.prison_objective.obj_id, 0 );
        objidpoolmanager::objective_set_play_outro( player.prison_objective.obj_id, 0 );
        waitframe();
        player function_706ced214bbe6fc4();
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x377cd30c, Offset: 0x3820
// Size: 0x6f
function private function_99c88251b79b9058()
{
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    level endon( #"flag_tunnels_anteroom_complete" );
    player utility::ent_flag_wait( "flag_ent_tunnels_prison_player_died" );
    
    if ( isdefined( player.prison_objective ) )
    {
        player function_18430f521ce49eca();
        player.prison_objective = undefined;
    }
    
    player notify( #"hash_5394c05476669f37" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xe66f3b30, Offset: 0x3897
// Size: 0x62
function private function_9002581ee8a91e98()
{
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    level utility::flag_wait( "flag_tunnels_anteroom_catchup_complete" );
    
    if ( isdefined( player.prison_objective ) )
    {
        player function_18430f521ce49eca();
        player.prison_objective = undefined;
    }
    
    player notify( #"hash_5394c05476669f37" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xdcf88762, Offset: 0x3901
// Size: 0x68
function private tunnels_prison_objective_end()
{
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    player utility::ent_flag_wait_any( "flag_trig_tunnels_prison_transition_complete", "flag_ent_tunnels_anteroom_player_entered" );
    
    if ( isdefined( player.prison_objective ) )
    {
        player function_18430f521ce49eca();
        player.prison_objective = undefined;
    }
    
    player notify( #"hash_5394c05476669f37" );
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x29ac79c5, Offset: 0x3971
// Size: 0x169
function private function_7a19f3b18cf7118f( var_9cb9f3eadb9fffe0 = 30, var_a86c88c7c43c1148, str_notify_nag )
{
    player = self;
    player endon( #"disconnect", #"hash_5394c05476669f37" );
    player.prison_objective endon( #"hash_2fa867d939a34fc6" );
    
    if ( isdefined( player.prison_objective ) )
    {
        player function_b8875dd873572315();
    }
    
    if ( player.prison_objective.b_forward )
    {
        if ( getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
        {
            var_9cb9f3eadb9fffe0 = 1;
        }
        else if ( isdefined( var_a86c88c7c43c1148 ) && utility::flag( var_a86c88c7c43c1148 ) )
        {
            if ( var_9cb9f3eadb9fffe0 > 1 )
            {
                var_9cb9f3eadb9fffe0 *= 0.5;
            }
        }
        
        wait var_9cb9f3eadb9fffe0;
        
        if ( isdefined( str_notify_nag ) )
        {
            player notify( str_notify_nag );
        }
    }
    else if ( isdefined( var_a86c88c7c43c1148 ) && utility::flag( var_a86c88c7c43c1148 ) || getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
    {
        wait 1;
    }
    else
    {
        wait 3;
    }
    
    if ( isdefined( player.prison_objective ) )
    {
        objidpoolmanager::objective_set_play_intro( player.prison_objective.obj_id, 0 );
        objidpoolmanager::objective_set_play_outro( player.prison_objective.obj_id, 0 );
        waitframe();
        player function_706ced214bbe6fc4();
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x9cb25d66, Offset: 0x3ae2
    // Size: 0x5, Type: dev
    function function_1e590b97eb1115f()
    {
        
    }

#/

// Namespace gemini_util
// Params 5
// Checksum 0xe108db2e, Offset: 0x3aef
// Size: 0x226
function function_508164fb69acf840( struct_noteworthy, player, z_offset = 48, var_9cb9f3eadb9fffe0 = 0, str_notify_nag )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.player_objective ) )
    {
        player.player_objective = spawnstruct();
    }
    
    player.player_objective.b_forward = 1;
    player.player_objective.struct_array = function_dcbcae7678809479( struct_noteworthy );
    player.player_objective.obj_id = function_70fecc661764c00a( player.player_objective.struct_array[ 0 ].origin, [ player ], z_offset, undefined, undefined, "active" );
    ob_story_mission_utils::objective_marker_hide( player.player_objective.obj_id, level.players );
    var_c7b1aae8162d8b58 = 0;
    waitframe();
    
    while ( var_c7b1aae8162d8b58 < player.player_objective.struct_array.size )
    {
        objidpoolmanager::update_objective_position( player.player_objective.obj_id, player.player_objective.struct_array[ var_c7b1aae8162d8b58 ].origin + ( 0, 0, z_offset ) );
        activity_instance childthread function_f4c235c4db66fd34( player, var_9cb9f3eadb9fffe0, undefined, undefined, str_notify_nag );
        
        if ( var_c7b1aae8162d8b58 - 2 >= 0 )
        {
            level childthread function_2fc6e000cdb0e31e( player.player_objective, player, var_c7b1aae8162d8b58 - 2 );
        }
        
        level childthread function_1f4a1bb61fd7c3de( player.player_objective, player, var_c7b1aae8162d8b58 );
        player.player_objective waittill( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
        var_c7b1aae8162d8b58++;
    }
    
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
}

// Namespace gemini_util
// Params 7
// Checksum 0xb2b8662b, Offset: 0x3d1d
// Size: 0x185
function function_70fecc661764c00a( obj_struct, player, z_offset = 48, str_key = "script_noteworthy", obj_marker_bundle = "sat_ob_objectivemarker_location", obj_marker_state = "current", b_intro_outro = 0 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    v_obj_pos = undefined;
    
    if ( isvector( obj_struct ) )
    {
        v_obj_pos = obj_struct;
    }
    else if ( isstruct( obj_struct ) )
    {
        var_f5594f9951890a3d = obj_struct;
        v_obj_pos = var_f5594f9951890a3d.origin;
    }
    else
    {
        var_f5594f9951890a3d = utility::getstruct( obj_struct, str_key );
        v_obj_pos = var_f5594f9951890a3d.origin;
        
        if ( !isdefined( var_f5594f9951890a3d ) )
        {
            assertmsg( "<dev string:x5c>" + str_key + "<dev string:x72>" + obj_struct );
        }
    }
    
    a_players = undefined;
    
    if ( isdefined( player ) )
    {
        if ( isarray( player ) )
        {
            a_players = player;
        }
        else
        {
            a_players = [ player ];
        }
    }
    
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( v_obj_pos, z_offset, a_players, obj_marker_bundle, b_intro_outro, 0, 0 );
    objective_state( obj_id, obj_marker_state );
    
    if ( player && !isarray( player ) )
    {
        player thread function_9c749c3cb88a743c( obj_id );
    }
    
    return obj_id;
}

// Namespace gemini_util
// Params 8
// Checksum 0x1e8fc9d7, Offset: 0x3eab
// Size: 0x21a
function function_b811ad4b7f403c2c( obj_struct, player, z_offset = 48, str_key = "script_noteworthy", var_9cb9f3eadb9fffe0 = 30, ent_flag_endon, str_notify_nag, b_intro_outro = 0 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( isdefined( ent_flag_endon ) )
    {
        if ( isarray( ent_flag_endon ) )
        {
            foreach ( ent_flag in ent_flag_endon )
            {
                if ( player utility::ent_flag( ent_flag ) )
                {
                    return;
                }
                
                player endon( ent_flag );
            }
        }
        else
        {
            if ( player utility::ent_flag( ent_flag_endon ) )
            {
                return;
            }
            
            player endon( ent_flag_endon );
        }
    }
    
    player_objective = player.player_objective;
    player_objective.obj_id = function_70fecc661764c00a( obj_struct, player, z_offset, str_key, undefined, "active" );
    
    if ( isdefined( player_objective ) )
    {
        activity_instance ob_story_mission_utils::objective_marker_hide( player_objective.obj_id, level.players );
    }
    
    wait var_9cb9f3eadb9fffe0;
    
    if ( isdefined( str_notify_nag ) )
    {
        player notify( str_notify_nag );
    }
    
    if ( isdefined( player_objective ) )
    {
        if ( b_intro_outro )
        {
            objidpoolmanager::objective_set_play_intro( player_objective.obj_id, 1 );
            objidpoolmanager::objective_set_play_outro( player_objective.obj_id, 1 );
        }
        else
        {
            objidpoolmanager::objective_set_play_intro( player_objective.obj_id, 0 );
            objidpoolmanager::objective_set_play_outro( player_objective.obj_id, 0 );
        }
        
        waitframe();
        ob_story_mission_utils::objective_marker_show( player_objective.obj_id, [ player ] );
    }
}

// Namespace gemini_util
// Params 5, eflags: 0x4
// Checksum 0xaba1f676, Offset: 0x40cd
// Size: 0x166
function private function_f4c235c4db66fd34( player, var_9cb9f3eadb9fffe0 = 30, var_a86c88c7c43c1148, flag_endon, str_notify_nag )
{
    player_objective = player.player_objective;
    player_objective endon( #"hash_2fa867d939a34fc6" );
    
    if ( isdefined( flag_endon ) )
    {
        if ( utility::flag( flag_endon ) )
        {
            return;
        }
        
        level endon( flag_endon );
    }
    
    if ( isdefined( player_objective ) )
    {
        ob_story_mission_utils::objective_marker_hide( player_objective.obj_id, level.players );
    }
    
    if ( player_objective.b_forward )
    {
        if ( isdefined( var_a86c88c7c43c1148 ) && utility::flag( var_a86c88c7c43c1148 ) || getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
        {
            if ( var_9cb9f3eadb9fffe0 > 1 )
            {
                var_9cb9f3eadb9fffe0 *= 0.5;
            }
        }
        
        wait var_9cb9f3eadb9fffe0;
        
        if ( isdefined( str_notify_nag ) )
        {
            player notify( str_notify_nag );
        }
    }
    else if ( isdefined( var_a86c88c7c43c1148 ) && utility::flag( var_a86c88c7c43c1148 ) || getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
    {
        wait 1;
    }
    else
    {
        wait 3;
    }
    
    if ( isdefined( player_objective ) )
    {
        objidpoolmanager::objective_set_play_intro( player_objective.obj_id, 0 );
        objidpoolmanager::objective_set_play_outro( player_objective.obj_id, 0 );
        waitframe();
        ob_story_mission_utils::objective_marker_show( player_objective.obj_id, [ player ] );
    }
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x91a43493, Offset: 0x423b
// Size: 0xd1
function private function_2fc6e000cdb0e31e( player_objective, player, var_c7b1aae8162d8b58 )
{
    player notify( #"hash_1e9ed8c6dc4e8a3b" );
    player endon( #"hash_1e9ed8c6dc4e8a3b" );
    var_7ae605d773736268 = squared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].radius );
    
    while ( distancesquared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].origin, player.origin ) > var_7ae605d773736268 )
    {
        waitframe();
    }
    
    if ( isdefined( player_objective ) )
    {
        /#
            if ( getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
            {
                iprintlnbold( "<dev string:x75>" );
            }
        #/
        
        player_objective notify( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
        player_objective.b_forward = 0;
    }
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x4d884c59, Offset: 0x4314
// Size: 0x150
function private function_1f4a1bb61fd7c3de( player_objective, player, var_c7b1aae8162d8b58 )
{
    player notify( #"hash_995d51abce8498f9" );
    player endon( #"hash_995d51abce8498f9" );
    player endon( #"death_or_disconnect" );
    
    if ( isdefined( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag_wait ) )
    {
        level utility::flag_wait( player_objective.struct_array[ var_c7b1aae8162d8b58 ].script_flag_wait );
    }
    else
    {
        var_7ae605d773736268 = squared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].radius );
        
        if ( !isdefined( player ) || !isdefined( player.origin ) )
        {
            return;
        }
        
        while ( distancesquared( player_objective.struct_array[ var_c7b1aae8162d8b58 ].origin, player.origin ) > var_7ae605d773736268 )
        {
            if ( !isdefined( player ) || !isdefined( player.origin ) )
            {
                return;
            }
            
            waitframe();
        }
    }
    
    if ( isdefined( player_objective ) )
    {
        /#
            if ( getdvarint( @"hash_ba456a5b60ed68f8", 0 ) )
            {
                iprintlnbold( "<dev string:xa0>" );
            }
        #/
        
        player_objective notify( #"hash_2fa867d939a34fc6", var_c7b1aae8162d8b58 );
        player_objective.b_forward = 1;
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xfd2357bd, Offset: 0x446c
// Size: 0x81
function private function_dcbcae7678809479( var_3ca8aff3d1e9fc14 )
{
    struct_array = [];
    s_obj_current = utility::getstruct( var_3ca8aff3d1e9fc14, "script_noteworthy" );
    
    while ( true )
    {
        struct_array[ struct_array.size ] = s_obj_current;
        
        if ( !isdefined( s_obj_current.target ) )
        {
            break;
        }
        
        s_obj_next = utility::getstruct( s_obj_current.target, "targetname" );
        
        if ( !isdefined( s_obj_next ) )
        {
            return;
        }
        
        s_obj_current = s_obj_next;
        waitframe();
    }
    
    return struct_array;
}

// Namespace gemini_util
// Params 4
// Checksum 0x6e2e3452, Offset: 0x44f6
// Size: 0xbb
function function_7a621dc87829fa67( obj_entity, z_offset = 80, a_players, obj_marker_bundle = "sat_ob_objectivemarker_storymissionmain" )
{
    if ( !self.a_obj_id )
    {
        self.a_obj_id = [];
    }
    
    obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( obj_marker_bundle );
    self.a_obj_id[ self.a_obj_id.size ] = obj_id;
    objidpoolmanager::objective_set_play_intro( obj_id, 0 );
    objidpoolmanager::objective_set_play_outro( obj_id, 0 );
    waitframe();
    objidpoolmanager::update_objective_onentity( obj_id, obj_entity );
    objidpoolmanager::update_objective_setzoffset( obj_id, z_offset );
    ob_story_mission_utils::objective_marker_show( obj_id, a_players );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    return obj_id;
}

// Namespace gemini_util
// Params 1
// Checksum 0x218dcb5f, Offset: 0x45ba
// Size: 0x5a
function function_9c749c3cb88a743c( obj_id )
{
    self notify( #"hash_b96c0fba871cf02f" );
    self endon( #"hash_b96c0fba871cf02f" );
    player = self;
    player waittill( #"disconnect" );
    
    if ( obj_id && !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
    {
        objidpoolmanager::returnobjectiveid( obj_id );
    }
}

// Namespace gemini_util
// Params 4
// Checksum 0x27d35bc6, Offset: 0x461c
// Size: 0x1cd
function function_c346435ed6d8395e( flag_toset, var_bd2b115cd32ceec8, radius_around = 256, timeout = 15 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( a_players_detected ) )
    {
        a_players_detected = [];
    }
    
    check_radius = radius_around;
    timer = timeout;
    b_enable_timer = 0;
    
    if ( isdefined( var_bd2b115cd32ceec8.radius ) )
    {
        check_radius = var_bd2b115cd32ceec8.radius;
    }
    
    if ( isdefined( var_bd2b115cd32ceec8 ) )
    {
        if ( isstruct( var_bd2b115cd32ceec8 ) || isent( var_bd2b115cd32ceec8 ) )
        {
            while ( true )
            {
                var_dce79ddf9e318abd = ob_story_mission_utils::get_playing_players();
                a_players_detected = getplayersinradius( var_bd2b115cd32ceec8.origin, check_radius, undefined, 1 );
                
                switch ( a_players_detected.size )
                {
                    case 0:
                        timer = timeout;
                        b_enable_timer = 0;
                        break;
                    case 1:
                        if ( a_players_detected.size < var_dce79ddf9e318abd.size )
                        {
                            b_enable_timer = 1;
                        }
                        else if ( a_players_detected.size == var_dce79ddf9e318abd.size )
                        {
                            utility::flag_set( flag_toset );
                            return;
                        }
                        
                        break;
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                        utility::flag_set( flag_toset );
                        return;
                    default:
                        /#
                            iprintlnbold( "<dev string:xca>" );
                        #/
                        
                        break;
                }
                
                wait 1;
                
                if ( b_enable_timer == 1 )
                {
                    timer -= 1;
                }
                
                if ( timer <= 0 )
                {
                    /#
                        iprintlnbold( "<dev string:xfd>" );
                    #/
                    
                    utility::flag_set( flag_toset );
                    b_enable_timer = 0;
                    return;
                }
            }
        }
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x12b>" );
    #/
    
    return;
}

// Namespace gemini_util
// Params 9
// Checksum 0x7db40a20, Offset: 0x47f1
// Size: 0x171
function function_8ff6409d7606f259( player, position_entity, z_offset, obj_marker_bundle, var_ac2c0371b649d62e, flag_endon, timeout, distance_threshold = 1000, b_intro_anim = 0 )
{
    player endon( #"disconnect" );
    activity_instance = self;
    
    if ( !isdefined( position_entity ) )
    {
        /#
            iprintln( "<dev string:x150>" );
        #/
        
        return;
    }
    
    var_ac2c0371b649d62e = var_ac2c0371b649d62e ?? player;
    var_ac2c0371b649d62e endon( flag_endon );
    
    if ( isvector( position_entity ) )
    {
        activity_instance thread function_d70a05f5303797f( player, position_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout, b_intro_anim );
    }
    else
    {
        activity_instance thread function_9bc337e1709b11a3( player, position_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout );
        position_entity = position_entity.origin;
    }
    
    waypoint_active = 0;
    
    if ( distance_threshold >= 0 )
    {
        while ( true )
        {
            if ( !waypoint_active && distance2dsquared( player.origin, position_entity ) < squared( distance_threshold ) )
            {
                player notify( #"show_objective_waypoint" );
                waypoint_active = 1;
            }
            else if ( waypoint_active && distance2dsquared( player.origin, position_entity ) >= squared( distance_threshold ) )
            {
                player notify( #"hide_objective_waypoint" );
                waypoint_active = 0;
            }
            
            waitframe();
        }
        
        return;
    }
    
    player notify( #"show_objective_waypoint" );
}

// Namespace gemini_util
// Params 7
// Checksum 0xd8209673, Offset: 0x496a
// Size: 0x18c
function function_d70a05f5303797f( player, obj_origin, z_offset, var_ac2c0371b649d62e, flag_endon, timeout, b_intro_anim )
{
    if ( isdefined( timeout ) )
    {
        player endon( #"disconnect" );
    }
    
    activity_instance = self;
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( obj_origin, z_offset, [ player ], undefined, b_intro_anim );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    objective_state( obj_id, "active" );
    
    while ( true )
    {
        if ( !isent( player ) || !isent( var_ac2c0371b649d62e ) )
        {
            break;
        }
        
        msg = utility::waittill_any_ents_return( player, "show_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        
        if ( !arraycontains( activity_instance.a_obj_id, obj_id ) )
        {
            break;
        }
        
        if ( msg == flag_endon )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
        
        objective_state( obj_id, "current" );
        
        if ( isdefined( timeout ) )
        {
            result = utility::function_22939e0bc589604e( timeout, player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        else
        {
            result = utility::waittill_any_ents_return_params( player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        
        objective_state( obj_id, "active" );
        
        if ( result[ "message" ] == flag_endon || result[ "message" ] == "timeout" )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
    }
}

// Namespace gemini_util
// Params 6
// Checksum 0xabd4a7d9, Offset: 0x4afe
// Size: 0x13e
function function_9bc337e1709b11a3( player, obj_entity, z_offset, var_ac2c0371b649d62e, flag_endon, timeout )
{
    activity_instance = self;
    obj_id = player ob_story_mission_utils::function_804834359f20ef5a( obj_entity, z_offset, [ player ] );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    objective_state( obj_id, "active" );
    
    while ( true )
    {
        msg = utility::waittill_any_ents_return( player, "show_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        
        if ( msg == flag_endon )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
        
        objective_state( obj_id, "current" );
        
        if ( isdefined( timeout ) )
        {
            result = utility::function_22939e0bc589604e( timeout, player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        else
        {
            result = utility::waittill_any_ents_return_params( player, "death", player, "hide_objective_waypoint", var_ac2c0371b649d62e, flag_endon );
        }
        
        objective_state( obj_id, "active" );
        
        if ( result[ "message" ] == flag_endon || result[ "message" ] == "timeout" )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id, [ player ] );
            break;
        }
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xf8273ca3, Offset: 0x4c44
    // Size: 0x5, Type: dev
    function function_51abe74c06f0d1de()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0xa0744c7a, Offset: 0x4c51
// Size: 0xc5
function function_cb22040a105c067c( initialize_all = 0 )
{
    var_dd0de8be86c399a4 = getentarray( "cabin_breakable_wall_scr", #targetname );
    
    foreach ( breakable_wall in var_dd0de8be86c399a4 )
    {
        if ( initialize_all )
        {
            function_1b58e4f70c369583( breakable_wall );
            continue;
        }
        
        if ( !breakable_wall.var_6d2261292da7de78 )
        {
            function_1b58e4f70c369583( breakable_wall );
            break;
        }
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x6265e38b, Offset: 0x4d1e
// Size: 0x1a2
function private function_1b58e4f70c369583( breakable_wall )
{
    if ( !breakable_wall.var_6d2261292da7de78 )
    {
        breakable_wall.var_6d2261292da7de78 = 1;
        attackpoints = utility::getstructarray( breakable_wall.script_noteworthy + "_attackpoint", "targetname" );
        attractor = utility::getstruct( breakable_wall.script_noteworthy + "_attractor", "targetname" );
        breakable_wall.var_c05deaa057ac4a91 = getent( breakable_wall.script_noteworthy + "_barrier", #targetname );
        breakable_wall setcandamage( 1 );
        breakable_wall.health = 140;
        player_team = player_get_team();
        
        if ( !isdefined( attractor ) )
        {
            attractor = breakable_wall;
        }
        
        if ( !isdefined( attractor.angles ) )
        {
            attractor.angles = ( 0, 0, 0 );
        }
        
        breakable_wall.attractor = zombie_attractor_manager::add_attractor( attractor, 2, 450, 1, undefined, &function_168a50a87de78300, undefined, player_team );
        zombie_attractor_manager::set_attractor_slots( breakable_wall.attractor, attackpoints );
        zombie_attractor_manager::function_a2aab3762aaa055f( breakable_wall.attractor, attractor.origin + ( 0, 0, 32 ), ( 16, 32, 32 ), attractor.angles );
        breakable_wall.attractor.var_9aaae8ef943ddb6a = breakable_wall;
        breakable_wall childthread function_a12771d68d12c2d7( breakable_wall.attractor, attackpoints, 0 );
    }
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0xb21504f5, Offset: 0x4ec8
// Size: 0x258
function private function_a12771d68d12c2d7( attractor, attackpoints, var_6af945c8e95c7e11 = 0 )
{
    self endon( #"destroyed" );
    self.count = 0;
    min_hits = 3;
    self.var_57b23dfe8b243c52 = 0;
    self.wall_destr = 0;
    function_6635be19a7c4ff1b( self.script_noteworthy + "_portal", 0 );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, damage_type, modelname, tagname, partname, idflags, objweapon );
        
        if ( !ob::nightmare() )
        {
            if ( arraycontains( level.players, attacker ) || attacker.classname == "script_vehicle" )
            {
                self.health += amount;
                
                /#
                    iprintln( "<dev string:x19d>" + string( self.health ) );
                #/
                
                continue;
            }
        }
        
        if ( self.health <= 98 && self.var_57b23dfe8b243c52 == 0 )
        {
            self.var_57b23dfe8b243c52 = 1;
            self setscriptablepartstate( "main", "damaged" );
            function_6635be19a7c4ff1b( self.script_noteworthy + "_portal", 1 );
        }
        
        if ( self.health <= 0 )
        {
            if ( self.count < min_hits )
            {
                self.health = 1;
            }
            else if ( var_6af945c8e95c7e11 )
            {
                var_78ea831d67ecf720 = zombie_attractor_manager::function_c9e40c55fa068d00( attractor ).size == attackpoints.size;
                
                if ( var_78ea831d67ecf720 )
                {
                    break;
                }
            }
            else
            {
                break;
            }
        }
        
        /#
            iprintln( "<dev string:x19d>" + string( self.health ) );
        #/
        
        self notify( #"damage_modify" );
        self.count++;
    }
    
    self.wall_destr = 1;
    self setscriptablepartstate( "main", "dead" );
    self.var_c05deaa057ac4a91 hide();
    function_3df71e728f6a208e();
}

// Namespace gemini_util
// Params 1
// Checksum 0x73cf71f, Offset: 0x5128
// Size: 0xff
function function_3df71e728f6a208e( shouldrumble = 1 )
{
    if ( !isdefined( self.var_c05deaa057ac4a91 ) )
    {
        self.var_c05deaa057ac4a91 = getent( self.script_noteworthy + "_barrier", #targetname );
    }
    
    if ( !self.var_57b23dfe8b243c52 )
    {
        self.var_57b23dfe8b243c52 = 1;
        self setscriptablepartstate( "main", "damaged" );
    }
    
    if ( !self.wall_destr )
    {
        self.wall_destr = 1;
        self setscriptablepartstate( "main", "dead" );
        self.var_c05deaa057ac4a91 hide();
    }
    
    self.var_c05deaa057ac4a91 connectpaths();
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    if ( shouldrumble )
    {
        earthquake( 0.5, 1, self.origin, 550 );
        playrumbleonposition( "grenade_rumble", self.origin );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x7471e264, Offset: 0x522f
// Size: 0x9d
function function_cf2cc5972c63bd9e()
{
    var_dd0de8be86c399a4 = getentarray( "cabin_breakable_wall_scr", #targetname );
    
    foreach ( scriptable_breakwall in var_dd0de8be86c399a4 )
    {
        scriptable_breakwall notify( #"destroyed" );
        scriptable_breakwall function_3df71e728f6a208e();
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x92c3a0aa, Offset: 0x52d4
// Size: 0x11f
function private function_168a50a87de78300( attractor, zombie )
{
    low_classname = tolower( zombie.classname );
    
    if ( ob::nightmare() )
    {
        return 0;
    }
    
    if ( !issubstr( low_classname, "zombie_base" ) )
    {
        return 0;
    }
    
    if ( zombie utility::ent_flag_exist( "flag_cabin_barrage_zombie_inside" ) && zombie utility::ent_flag( "flag_cabin_barrage_zombie_inside" ) )
    {
        return 0;
    }
    
    if ( isdefined( zombie.var_bd22ba6c600a23a3 ) )
    {
        return 0;
    }
    
    if ( isdefined( level.players ) )
    {
        player = function_47c86977a18df38b( level.players, zombie.origin, 3500 );
        buffer_dist = 100;
        
        if ( isdefined( player ) && distance2dsquared( zombie.origin, player.origin ) + buffer_dist < distance2dsquared( zombie.origin, attractor.source.origin ) )
        {
            return 0;
        }
    }
    
    if ( isalive( zombie ) && isdefined( attractor ) )
    {
        return 1;
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xcf10d28, Offset: 0x53fb
    // Size: 0x5, Type: dev
    function function_91a5640e9f6d6e59()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0x874bda5a, Offset: 0x5408
// Size: 0xf4
function function_66a11cbbae4031e6()
{
    var_c985c388cd1e8af7 = utility::getstruct( "cabin_center_struct", "targetname" );
    cabin_front_doors = function_d5f3a036e837913( "cabin_front_door" );
    cabin_back_doors = function_d5f3a036e837913( "cabin_back_door" );
    cabin_south_doors = function_d5f3a036e837913( "cabin_south_door" );
    cabin_north_doors = function_d5f3a036e837913( "cabin_north_door" );
    cabin_all_doors = arraycombine( cabin_front_doors, cabin_back_doors, cabin_south_doors, cabin_north_doors );
    
    foreach ( cabin_door in cabin_all_doors )
    {
        cabin_door scriptabledoorlock();
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xd9e5e0d6, Offset: 0x5504
    // Size: 0x5, Type: dev
    function function_9e815acb231e58dd()
    {
        
    }

#/

// Namespace gemini_util
// Params 9
// Checksum 0xd7c01b34, Offset: 0x5511
// Size: 0x3d3
function init_cabin_mcz( targetname, var_5bd3b17ec72408da, max_time = 72, checkpoint_count = 12, var_2c303adb6cfb3b2c = 0, var_93b19c02650f1e6a = 1.1, var_7b8f10ef20e988a4 = 1.2, var_8f04646f7f1bd1da = "ob_capture_zone_ring_1", var_dc9e2e7abca8f787 )
{
    activity_instance = self;
    
    if ( !isdefined( activity_instance.var_30371edbcd339720 ) )
    {
        activity_instance.var_30371edbcd339720 = 0;
    }
    
    if ( isarray( save::mission_get_data().var_7f2fe4e9154d0b22 ) && arraycontains( save::mission_get_data().var_7f2fe4e9154d0b22, targetname ) )
    {
        capture_zone = ob_capture_zone::function_40df18d63bc4331a( targetname, activity_instance );
        capture_zone.complete = 1;
        capture_zone.var_d13a4a43def7fc02 = 1;
        capture_zone function_a016dd4d32872aad( capture_zone );
        capture_zone.additional_data = spawnstruct();
        capture_zone.additional_data.var_dc9e2e7abca8f787 = var_dc9e2e7abca8f787 ?? 1;
        return capture_zone;
    }
    
    scriptable = getscriptablearray( targetname + "_interact", #targetname )[ 0 ];
    
    if ( arraycontains( level.interacts, scriptable ) )
    {
        /#
            iprintlnbold( "<dev string:x1ac>" + targetname + "<dev string:x1c9>" );
        #/
        
        return;
    }
    
    additional_data = spawnstruct();
    additional_data.var_8531c30e39a18759 = utility::getstructarray( targetname + "_extra_spawns" );
    additional_data.env_models = getentitylessscriptablearray( targetname + "_env_model", #targetname );
    additional_data.var_5bd3b17ec72408da = var_5bd3b17ec72408da;
    additional_data.var_fc86768f71aa63d1 = 400;
    additional_data.var_2c303adb6cfb3b2c = var_2c303adb6cfb3b2c;
    additional_data.var_8f04646f7f1bd1da = var_8f04646f7f1bd1da;
    additional_data.var_dc9e2e7abca8f787 = var_dc9e2e7abca8f787 ?? 1;
    capture_zone = ob_capture_zone::function_40df18d63bc4331a( targetname, activity_instance, &"sat_ob_story_missions_gemini/activity_cabin_memory_capture_interact", max_time, var_93b19c02650f1e6a, var_7b8f10ef20e988a4, var_7b8f10ef20e988a4, 1, checkpoint_count, additional_data );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_ACTIVATED", &function_8dde030581aeaaeb );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_PROGRESS_CHECKPOINT_REACHED", &function_bc51fb4d893a0ec7 );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_COMPLETE", &function_a016dd4d32872aad );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_PLAYER_ENTER", &function_a59f2b725d97274d );
    capture_zone ob_capture_zone::function_732739bf2b9ef79f( "CALLBACK_CAPTURE_ZONE_PLAYER_EXIT", &function_79e80515887de785 );
    scriptable.var_b48007062d04e4a4 = getent( targetname + "_interact_clip_pillar", #targetname );
    
    if ( scriptable.var_b48007062d04e4a4 )
    {
        scriptable.var_b48007062d04e4a4 show();
    }
    
    scriptable_instance = scriptable getlinkedscriptableinstance();
    scriptable_instance.capture_zone = capture_zone;
    scriptable_instance.scriptable_ent = scriptable;
    scriptable_instance.interact_time = gettime();
    interact = interaction::register_scriptable_interact( scriptable_instance, &function_19475f97cfc264ad );
    wait 0.5;
    
    switch ( targetname )
    {
        case #"hash_7f0ad6f4f7e88ae6":
            namespace_60d9b3cbf41663fe::function_e69924b8c42425bd( "memory04" );
            break;
        case #"hash_c7c751cbb09ff5a0":
            namespace_60d9b3cbf41663fe::function_e69924b8c42425bd( "memory03" );
            break;
        case #"hash_7cdddb128adaf9b":
            namespace_60d9b3cbf41663fe::function_e69924b8c42425bd( "memory02" );
            break;
        case #"hash_2bf3c88eec2d5219":
            namespace_60d9b3cbf41663fe::function_e69924b8c42425bd( "memory01" );
            break;
    }
    
    waitframe();
    scriptable setscriptablepartstate( "base", "usable" );
    return capture_zone;
}

// Namespace gemini_util
// Params 1
// Checksum 0x791c2f4b, Offset: 0x58ed
// Size: 0x2a3
function function_19475f97cfc264ad( player )
{
    wait_time = 0.5 - ( gettime() - self.interact_time ) / 1000;
    
    if ( wait_time > 0 )
    {
        wait wait_time;
    }
    
    self setscriptablepartstate( "base", "active" );
    capture_zone = self.capture_zone;
    memory_id = toupper( capture_zone.id );
    
    if ( self.scriptable_ent.var_b48007062d04e4a4 )
    {
        self.scriptable_ent.var_b48007062d04e4a4 hide();
    }
    
    if ( utility::cointoss() )
    {
        monitor_center_struct = "cabin_monitor_a_center_struct";
    }
    else
    {
        monitor_center_struct = "cabin_monitor_b_center_struct";
    }
    
    switch ( memory_id )
    {
        case #"hash_35861a505531e326":
            level utility::flag_set( "flag_cabin_initialmemory_activated" );
            a_vfx_waypoints = [ monitor_center_struct ];
            self.scriptable_ent thread function_c7a14fa875ed527b( a_vfx_waypoints, 3.5, "flag_mcz_initial_essence_return" );
            self.scriptable_ent function_7c837ecf65df2e45( "memory04", "mcz_initial_tv_lookat", "OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE", "flag_mcz_initial_essence_return" );
            break;
        case #"hash_f803ad0f0063453b":
            level utility::flag_set( "flag_cabin_memorycapture_basement_activated" );
            a_vfx_waypoints = [ "basement_monitor_essence_struct_1", "basement_monitor_essence_struct_2", "basement_monitor_essence_struct_3", monitor_center_struct ];
            self.scriptable_ent thread function_c7a14fa875ed527b( a_vfx_waypoints, 11, "flag_mcz_basement_essence_return" );
            self.scriptable_ent function_7c837ecf65df2e45( "memory02", "mcz_basement_tv_lookat", "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_COMPLETE", "flag_mcz_basement_essence_return" );
            break;
        case #"hash_79aed645c0e19679":
            level utility::flag_set( "flag_cabin_memorycapture_cliffs_activated" );
            a_vfx_waypoints = [ "cliffs_monitor_essence_struct_1", monitor_center_struct ];
            self.scriptable_ent thread function_c7a14fa875ed527b( a_vfx_waypoints, 11, "flag_mcz_cliffs_essence_return" );
            self.scriptable_ent function_7c837ecf65df2e45( "memory01", "mcz_cliffs_tv_lookat", "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_COMPLETE", "flag_mcz_cliffs_essence_return" );
            break;
        case #"hash_f3c89e4046164320":
            level utility::flag_set( "flag_cabin_memorycapture_woods_activated" );
            a_vfx_waypoints = [ "woods_monitor_essence_struct_1", "woods_monitor_essence_struct_2", monitor_center_struct ];
            self.scriptable_ent thread function_c7a14fa875ed527b( a_vfx_waypoints, 11, "flag_mcz_woods_essence_return" );
            self.scriptable_ent function_7c837ecf65df2e45( "memory03", "mcz_woods_tv_lookat", "OB_GEMINI_MCZ_CHECKPOINT_WOODS_COMPLETE", "flag_mcz_woods_essence_return" );
            break;
    }
    
    capture_zone = ob_capture_zone::function_bafcb5a390b6ed72( capture_zone );
}

// Namespace gemini_util
// Params 2
// Checksum 0x66a4fd38, Offset: 0x5b98
// Size: 0x75
function function_a59f2b725d97274d( capture_zone, player )
{
    if ( isdefined( player ) )
    {
        pbgpostfxbundlestart( player, %"mp_sat_gemini_p2_mcz_inside" );
        
        if ( !isdefined( capture_zone.players ) )
        {
            capture_zone.players = [];
        }
        
        capture_zone.players = arraycombineunique( capture_zone.players, [ player ] );
        player notify( #"notify_cabin_memorycapture_player_entered_mcz" );
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xf14ffb0, Offset: 0x5c15
// Size: 0x55
function function_79e80515887de785( capture_zone, player )
{
    if ( isdefined( player ) )
    {
        pbgpostfxbundleend( player, %"mp_sat_gemini_p2_mcz_inside" );
        capture_zone.players = arrayremove( capture_zone.players, player );
        player notify( #"hash_cae4511ea71b033" );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xb7fae117, Offset: 0x5c72
// Size: 0x9f
function function_ecf533b4a16fe272()
{
    if ( isdefined( self.players ) && self.players.size > 0 )
    {
        foreach ( player in self.players )
        {
            pbgpostfxbundleend( player, %"mp_sat_gemini_p2_mcz_inside" );
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x4c6f9791, Offset: 0x5d19
// Size: 0x353
function function_8dde030581aeaaeb( capture_zone )
{
    capture_zone notify( #"capture_zone_activated" );
    earthquake( 0.2, 1.5, capture_zone.origin, 900 );
    playrumbleonposition( "damage_heavy", capture_zone.origin );
    memory_id = toupper( capture_zone.id );
    
    switch ( memory_id )
    {
        case #"hash_35861a505531e326":
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_INITIAL_START" );
            scene_name = "sat_cin_gem_cabin_capture_point_memory04";
            break;
        case #"hash_f803ad0f0063453b":
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_START" );
            scene_name = "sat_cin_gem_cabin_capture_point_memory02";
            break;
        case #"hash_79aed645c0e19679":
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_START" );
            scene_name = "sat_cin_gem_cabin_capture_point_memory01";
            break;
        case #"hash_f3c89e4046164320":
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_WOODS_START" );
            scene_name = "sat_cin_gem_cabin_capture_point_memory03";
            break;
        default:
            break;
    }
    
    if ( memory_id == "MCZ_BASEMENT" || memory_id == "MCZ_CLIFFS" || memory_id == "MCZ_WOODS" )
    {
        capture_zone function_847200098d0bb915();
        capture_zone function_29296f53e6c18c8b();
    }
    
    animnode = utility::getstruct( scene_name, "targetname" );
    createnavrepulsor( scene_name + "_repulsor", 0, animnode.origin, 50 );
    playsoundatpos( capture_zone.origin, "evt_gem_memcap_filter_start" );
    capture_zone.ent_speaker = utility::spawn_tag_origin();
    capture_zone.ent_speaker.origin = animnode.origin + ( 0, 0, 48 );
    capture_zone thread gemini_vo::function_7fc4d9dfaf9993f0();
    var_27bf0df4b680334a = function_7d88f737f0e066a3( capture_zone );
    
    foreach ( player in var_27bf0df4b680334a )
    {
        player notify( #"hash_522ea1c41db4a71c", memory_id );
    }
    
    if ( !isdefined( level.cabin_repulsors ) )
    {
        level.cabin_repulsors = [];
    }
    
    level.cabin_repulsors[ level.cabin_repulsors.size ] = scene_name + "_repulsor";
    capture_zone thread show_next_scene( 1 );
    
    if ( capture_zone.checkpoint_encounter )
    {
        capture_zone thread function_4e8787d4ec5dc204( 0 );
    }
    
    capture_zone.activity_instance notify( #"capture_zone_checkpoint_reached" );
    capture_zone waittill( #"hash_f42a3f89f73bc0ae" );
    var_27bf0df4b680334a = function_7d88f737f0e066a3( capture_zone );
    
    foreach ( player in var_27bf0df4b680334a )
    {
        player notify( #"hash_eaef87aa8affee95", memory_id );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xa664eb7c, Offset: 0x6074
// Size: 0x26c
function function_a016dd4d32872aad( capture_zone )
{
    if ( !capture_zone.var_d13a4a43def7fc02 )
    {
        thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 1.5 );
        capture_zone thread gemini_vo::function_5de781158ddc93b6();
        capture_zone thread function_82b367177d421085( 0.2, 1 );
        capture_zone thread function_ecf533b4a16fe272();
        
        if ( isdefined( save::mission_get_data().var_7f2fe4e9154d0b22 ) )
        {
            save::mission_get_data().var_7f2fe4e9154d0b22[ save::mission_get_data().var_7f2fe4e9154d0b22.size ] = capture_zone.id;
        }
        else
        {
            save::mission_get_data().var_7f2fe4e9154d0b22 = [ capture_zone.id ];
        }
        
        playsoundatpos( capture_zone.origin, "evt_gem_memcap_filter_end" );
    }
    
    capture_zone.activity_instance notify( #"capture_zone_completed" );
    capture_zone notify( #"capture_zone_completed" );
    capture_zone.activity_instance.var_30371edbcd339720++;
    capture_zone thread show_next_scene( 3 );
    capture_zone thread function_1bfc6444c1834dd1();
    memory_id = toupper( capture_zone.id );
    var_27bf0df4b680334a = function_7d88f737f0e066a3( capture_zone );
    
    foreach ( player in var_27bf0df4b680334a )
    {
        player notify( #"notify_mcz_defend_complete", memory_id );
    }
    
    if ( !capture_zone.var_d13a4a43def7fc02 )
    {
        foreach ( mcz in self.activity_instance.capture_zone_array )
        {
            if ( !mcz.complete )
            {
                return;
            }
        }
        
        utility::flag_set( capture_zone.additional_data.var_5bd3b17ec72408da );
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xb614254e, Offset: 0x62e8
// Size: 0x1bb
function function_bc51fb4d893a0ec7( capture_zone, checkpoint_num )
{
    capture_zone notify( #"capture_zone_checkpoint_reached" );
    capture_zone.activity_instance notify( #"capture_zone_checkpoint_reached" );
    
    if ( checkpoint_num == 1 )
    {
        memory_id = toupper( capture_zone.id );
        
        if ( memory_id == "MCZ_INITIAL" )
        {
            capture_zone thread show_next_scene( 2 );
        }
    }
    
    waitframe();
    
    if ( capture_zone.checkpoint_encounter )
    {
        switch ( checkpoint_num )
        {
            case 3:
                capture_zone thread function_4e8787d4ec5dc204( 1 );
                capture_zone notify( #"hash_ced4edcde07ab79e" );
                break;
            case 6:
                capture_zone.var_ae616d2093c0318f = 1;
                capture_zone thread function_82b367177d421085( 0.2, 1, 1, 7.5 );
                capture_zone thread show_next_scene( 2 );
                var_17f63f0393c42063 = "OB_GEMINI_MCZ_CHECKPOINT_WAVE_REACHED_" + toupper( getsubstr( capture_zone.id, 4 ) ) + "_1";
                level utility::flag_set( var_17f63f0393c42063 );
                capture_zone notify( #"hash_13d97123076283fa" );
                break;
            case 7:
                capture_zone.checkpoint_wave_num = 1;
                capture_zone.var_ae616d2093c0318f = 0;
                break;
            case 8:
                capture_zone thread function_4e8787d4ec5dc204( 2 );
                break;
            case 9:
                capture_zone notify( #"hash_af4ae76e97ea7ced" );
                break;
            default:
                capture_zone.checkpoint_wave_num = 0;
                capture_zone notify( #"capture_zone_checkpoint_complete" );
                break;
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x1cb7e941, Offset: 0x64ab
// Size: 0x3d
function function_7d88f737f0e066a3( capture_zone )
{
    if ( !isdefined( capture_zone ) )
    {
        return;
    }
    
    var_27bf0df4b680334a = function_6a293b884c444a20( level.players, capture_zone.origin, 550 );
    return var_27bf0df4b680334a;
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xf66ded9d, Offset: 0x64f1
// Size: 0x176
function private function_1bfc6444c1834dd1()
{
    capture_zone = self;
    thread ob_story_mission_utils::item_spawn_equipment( capture_zone.targetname + "_equipment", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    thread ob_story_mission_utils::item_spawn_weapon( capture_zone.targetname + "_weapon", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    
    if ( !level.is_squad_size_small )
    {
        thread ob_story_mission_utils::item_spawn_equipment( capture_zone.targetname + "_equipment_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        thread ob_story_mission_utils::item_spawn_weapon( capture_zone.targetname + "_weapon_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    }
    
    memory_id = toupper( capture_zone.id );
    
    switch ( memory_id )
    {
        case #"hash_f803ad0f0063453b":
            spawn_items = [ %"hash_483c1904e1e455b" ];
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_COMPLETE" );
            break;
        case #"hash_79aed645c0e19679":
            spawn_items = [ %"hash_44d84403b73c0099" ];
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_COMPLETE" );
            break;
        case #"hash_f3c89e4046164320":
            spawn_items = [ %"hash_1c385375ee6fac5b" ];
            level utility::flag_set( "OB_GEMINI_MCZ_CHECKPOINT_WOODS_COMPLETE" );
            break;
        default:
            break;
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xb9aeae5a, Offset: 0x666f
// Size: 0x191
function private show_next_scene( shot_num )
{
    capture_zone = self;
    memory_id = toupper( capture_zone.id );
    
    if ( capture_zone.additional_data.var_2c303adb6cfb3b2c )
    {
        capture_zone waittill( #"capture_zone_checkpoint_complete" );
    }
    
    capture_vfx_tag = utility::spawn_tag_origin();
    capture_vfx_tag show();
    var_1653a56429809018 = ( 0, 0, 0 );
    
    switch ( memory_id )
    {
        case #"hash_f803ad0f0063453b":
            memory_name = "memory02";
            break;
        case #"hash_79aed645c0e19679":
            memory_name = "memory01";
            var_1653a56429809018 = ( -30, 0, 45 );
            break;
        case #"hash_f3c89e4046164320":
            memory_name = "memory03";
            break;
        case #"hash_35861a505531e326":
            memory_name = "memory04";
            break;
        default:
            break;
    }
    
    capture_zone thread namespace_60d9b3cbf41663fe::function_ebedec484bba1d7e( memory_name, shot_num );
    scene_name = "sat_cin_gem_cabin_capture_point_" + memory_name;
    capture_vfx_tag.origin = utility::getstruct( scene_name, "targetname" ).origin + var_1653a56429809018;
    waitframe();
    
    if ( shot_num == 3 )
    {
        capture_zone thread memory_pulse_heavy( capture_zone.origin, capture_vfx_tag );
        return;
    }
    
    if ( shot_num > 1 )
    {
        capture_zone thread memory_pulse_light( capture_zone.origin, capture_vfx_tag );
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x3e48d5c6, Offset: 0x6808
// Size: 0xfb
function private memory_pulse_light( position, capture_vfx_tag )
{
    playfxontag( level._effect[ "memory_pulse" ], capture_vfx_tag, "tag_origin" );
    shakeduration = 1;
    var_39bbe706cd34d2ec = 0.15;
    var_39deeb06cd5b2370 = 0.1;
    var_39def506cd5b396e = 0.05;
    radiusscalemax = 300;
    radiusscalemid = 600;
    radiusscalemin = 900;
    
    if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
    {
        [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( position, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
        return;
    }
    
    earthquake( 0.2, 1, position, 900 );
    playrumbleonposition( "damage_light", position );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x42c8d465, Offset: 0x690b
// Size: 0xfb
function private memory_pulse_heavy( position, capture_vfx_tag )
{
    playfxontag( level._effect[ "memory_pulse" ], capture_vfx_tag, "tag_origin" );
    shakeduration = 2;
    var_39bbe706cd34d2ec = 0.3;
    var_39deeb06cd5b2370 = 0.2;
    var_39def506cd5b396e = 0.1;
    radiusscalemax = 500;
    radiusscalemid = 800;
    radiusscalemin = 1200;
    
    if ( utility::issharedfuncdefined( #"shellshock", #"artillery_earthquake" ) )
    {
        [[ utility::getsharedfunc( #"shellshock", #"artillery_earthquake" ) ]]( position, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
        return;
    }
    
    earthquake( 0.4, 2, position, 1200 );
    playrumbleonposition( "damage_heavy", position );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x23291a48, Offset: 0x6a0e
// Size: 0x8e
function private function_47341e42682e7cb3( checkpoint_num )
{
    capture_zone = self;
    memory_prop = capture_zone.additional_data.env_models[ checkpoint_num ];
    
    if ( capture_zone.additional_data.var_2c303adb6cfb3b2c )
    {
        capture_zone waittill( #"capture_zone_checkpoint_complete" );
    }
    
    if ( !isdefined( memory_prop ) )
    {
        return;
    }
    
    if ( memory_prop getscriptablepartstate( "base" ) == "hidden" )
    {
        memory_prop setscriptablepartstate( "base", "visible" );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xe5fc0f18, Offset: 0x6aa4
    // Size: 0x5, Type: dev
    function function_e85c61fc7fd5f651()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xb45ff1f2, Offset: 0x6ab1
// Size: 0xb1
function function_847200098d0bb915()
{
    capture_zone = self;
    capture_zone.checkpoint_encounter = 1;
    capture_zone.should_spawn = 0;
    capture_zone.var_66a818966f37272 = [];
    request_id = ai_spawn_director::lookup_spawn_request( capture_zone.id + "_ai_enc_checkpoints" );
    function_ef57f478f96b050c( request_id, 1 );
    ai_spawn_director::function_53289c032f506bb1( request_id, &function_a05b8aefef18ad36, capture_zone );
    ai_spawn_director::function_c99d360d62c49a9c( request_id, &function_22dfdcc52cdbe643, capture_zone );
    ai_spawn_director::function_5ee28426adb3b64b( request_id, &function_1529521535a213d9, capture_zone );
    ai_spawn_director::function_5a08798970350207( request_id, &function_f38fb569130ec856, capture_zone );
    ai_spawn_director::add_spawned_callback( request_id, &function_ffa2cca74927b61e, capture_zone );
}

// Namespace gemini_util
// Params 0
// Checksum 0xf3331d55, Offset: 0x6b6a
// Size: 0xa7
function function_29296f53e6c18c8b()
{
    capture_zone = self;
    capture_zone.floodfill_encounter = 1;
    capture_zone.should_spawn_floodfill = 0;
    capture_zone.var_ae616d2093c0318f = 0;
    capture_zone.var_65d38712dbee6b1b = [];
    request_id = ai_spawn_director::lookup_spawn_request( capture_zone.id + "_ai_enc_floodfill" );
    function_ef57f478f96b050c( request_id, 1 );
    ai_spawn_director::function_53289c032f506bb1( request_id, &function_d11d77bfbe89fe74, capture_zone );
    ai_spawn_director::function_c99d360d62c49a9c( request_id, &function_e6f6d80b59d418a1, capture_zone );
    ai_spawn_director::add_spawned_callback( request_id, &function_80a46fd1983a368c, capture_zone );
    capture_zone thread function_5749e83ec4242541();
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xd7813dc5, Offset: 0x6c19
// Size: 0x13c
function private function_4e8787d4ec5dc204( checkpoint_wave_num, shouldrumble = 1 )
{
    capture_zone = self;
    var_f6b06c48314e829f = 0;
    
    if ( checkpoint_wave_num == 0 && !var_f6b06c48314e829f )
    {
        return;
    }
    
    request_id = ai_spawn_director::lookup_spawn_request( capture_zone.id + "_ai_enc_checkpoints" );
    
    if ( isdefined( capture_zone.buckettag ) )
    {
        function_1a9d724a960fa19d( request_id, capture_zone.buckettag, 0 );
    }
    
    buckettag = "Checkpoint" + checkpoint_wave_num;
    capture_zone.buckettag = buckettag;
    function_1a9d724a960fa19d( request_id, buckettag, 1 );
    
    if ( shouldrumble )
    {
        earthquake( 0.1, 0.75, capture_zone.origin, 900 );
        playrumbleonposition( "damage_light", capture_zone.origin );
    }
    
    capture_zone.should_spawn = 1;
    var_17f63f0393c42063 = "OB_GEMINI_MCZ_CHECKPOINT_WAVE_REACHED_" + toupper( getsubstr( capture_zone.id, 4 ) ) + "_" + checkpoint_wave_num;
    level utility::flag_set( var_17f63f0393c42063 );
    capture_zone notify( #"capture_zone_checkpoint_wave_paused" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x52990c44, Offset: 0x6d5d
// Size: 0xe7
function private function_db6d58018faeddae()
{
    capture_zone = self;
    capture_zone endon( #"capture_zone_complete" );
    remaining_threshold = 1;
    safety_timeout = 35;
    
    if ( true )
    {
        capture_zone.var_ae616d2093c0318f = 1;
    }
    
    childthread function_11de3e65b979532e( remaining_threshold );
    
    if ( safety_timeout > 0 )
    {
        msg = capture_zone utility::waittill_notify_or_timeout_return( "capture_zone_checkpoint_wave_cleared", safety_timeout );
        
        if ( msg == "timeout" )
        {
            /#
                iprintln( "<dev string:x233>" );
            #/
        }
    }
    else
    {
        capture_zone waittill( #"capture_zone_checkpoint_wave_cleared" );
    }
    
    while ( capture_zone.trigger.containsplayer != 1 )
    {
        wait 0.1;
    }
    
    capture_zone thread function_82b367177d421085( undefined );
    wait 3.5;
    capture_zone notify( #"capture_zone_checkpoint_complete" );
    capture_zone.var_ae616d2093c0318f = 0;
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x46db3ca9, Offset: 0x6e4c
// Size: 0x85
function private function_11de3e65b979532e( remaining_threshold )
{
    capture_zone = self;
    capture_zone endon( #"capture_zone_checkpoint_complete" );
    request_id = ai_spawn_director::lookup_spawn_request( capture_zone.id + "_ai_enc_checkpoints" );
    
    for ( remaining = ai_spawn_director::function_5d069e637e2d0a05( request_id ); remaining.size > remaining_threshold ; remaining = utility::array_removedead_or_dying( remaining ) )
    {
        wait 0.1;
    }
    
    wait 1;
    capture_zone notify( #"capture_zone_checkpoint_wave_cleared" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x436cb551, Offset: 0x6ed9
// Size: 0x3d8
function private function_5749e83ec4242541()
{
    capture_zone = self;
    capture_zone endon( #"capture_zone_complete" );
    request_id = ai_spawn_director::lookup_spawn_request( capture_zone.id + "_ai_enc_floodfill" );
    var_8980e8758ee7bcfe = 0;
    flip_tag = randomintrange( 0, 2 );
    var_f91a8d0be944c4d2 = 6;
    
    if ( level.is_squad_size_small )
    {
        var_717b3f58721bb2c4 = 0.5;
    }
    else
    {
        var_717b3f58721bb2c4 = 0;
    }
    
    memory_id = toupper( capture_zone.id );
    
    switch ( memory_id )
    {
        case #"hash_f803ad0f0063453b":
            var_717b3f58721bb2c4 += 1;
            break;
    }
    
    while ( !capture_zone.complete )
    {
        if ( isdefined( capture_zone.var_22169abe48f1f7ee ) && capture_zone.checkpoint_encounter )
        {
            function_1a9d724a960fa19d( request_id, capture_zone.var_22169abe48f1f7ee, 0 );
        }
        
        memory_id = toupper( capture_zone.id );
        spawn_cadence = 2 + var_717b3f58721bb2c4;
        
        if ( !isdefined( capture_zone.checkpoint_wave_num ) )
        {
            capture_zone.checkpoint_wave_num = 0;
        }
        
        switch ( capture_zone.checkpoint_wave_num )
        {
            case 1:
                spawn_cadence = 1.5 + var_717b3f58721bb2c4;
                
                if ( utility::cointoss() )
                {
                    if ( flip_tag != 0 )
                    {
                        function_5651cc131c04666( capture_zone, request_id, [ "vent_northwest", "east_cliffs", "north" ] );
                    }
                    else
                    {
                        function_5651cc131c04666( capture_zone, request_id, [ "vent_southeast", "east_cliffs", "north" ] );
                    }
                }
                else if ( flip_tag != 0 )
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "mcz_basement_northwest", "east_cliffs", "south" ] );
                }
                else
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "mcz_basement_southeast", "east_cliffs", "south" ] );
                }
                
                break;
            case 2:
                spawn_cadence = 1 + var_717b3f58721bb2c4;
                
                if ( utility::cointoss() )
                {
                    if ( flip_tag != 0 )
                    {
                        function_5651cc131c04666( capture_zone, request_id, [ "vent_northwest", "east_cliffs", "south" ] );
                    }
                    else
                    {
                        function_5651cc131c04666( capture_zone, request_id, [ "vent_southeast", "east_cliffs", "south" ] );
                    }
                }
                else if ( flip_tag != 0 )
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "mcz_basement_northwest", "east_cliffs", "south" ] );
                }
                else
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "mcz_basement_southeast", "east_cliffs", "south" ] );
                }
                
                break;
            default:
                if ( flip_tag != 0 )
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "mcz_basement_northwest", "south_cliffs", "west" ] );
                }
                else
                {
                    function_5651cc131c04666( capture_zone, request_id, [ "vent_northwest", "south_cliffs", "west" ] );
                }
                
                break;
        }
        
        if ( !capture_zone.checkpoint_encounter )
        {
            function_1a9d724a960fa19d( request_id, capture_zone.id, 1 );
        }
        
        if ( capture_zone.var_ae616d2093c0318f || !capture_zone.var_8327890ff4f1a28 )
        {
            capture_zone.should_spawn_floodfill = 0;
        }
        else
        {
            capture_zone.should_spawn_floodfill = 1;
        }
        
        if ( var_8980e8758ee7bcfe >= var_f91a8d0be944c4d2 )
        {
            var_8980e8758ee7bcfe = 0;
            flip_tag = randomintrange( 0, 2 );
            wait spawn_cadence * 2;
        }
        else
        {
            var_8980e8758ee7bcfe++;
        }
        
        wait spawn_cadence;
    }
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x907f2e21, Offset: 0x72b9
// Size: 0xdb
function private function_5651cc131c04666( capture_zone, request_id, var_a16811a742ca0143 )
{
    memory_id = toupper( capture_zone.id );
    
    switch ( memory_id )
    {
        case #"hash_f803ad0f0063453b":
            capture_zone.var_22169abe48f1f7ee = var_a16811a742ca0143[ 0 ];
            function_1a9d724a960fa19d( request_id, capture_zone.var_22169abe48f1f7ee, 1 );
            break;
        case #"hash_79aed645c0e19679":
            capture_zone.var_22169abe48f1f7ee = var_a16811a742ca0143[ 1 ];
            function_1a9d724a960fa19d( request_id, capture_zone.var_22169abe48f1f7ee, 1 );
            break;
        case #"hash_f3c89e4046164320":
            capture_zone.var_22169abe48f1f7ee = var_a16811a742ca0143[ 2 ];
            function_1a9d724a960fa19d( request_id, capture_zone.var_22169abe48f1f7ee, 1 );
            break;
    }
}

// Namespace gemini_util
// Params 4
// Checksum 0x3cff3815, Offset: 0x739c
// Size: 0x147
function function_82b367177d421085( staggered_delay = 0.2, shouldrumble = 0, shouldstun = 0, stun_duration )
{
    capture_zone = self;
    var_ce96f226b96916de = [];
    capture_zone.var_66a818966f37272 = utility::array_removedead_or_dying( capture_zone.var_66a818966f37272 );
    capture_zone.var_65d38712dbee6b1b = utility::array_removedead_or_dying( capture_zone.var_65d38712dbee6b1b );
    var_ce96f226b96916de = arraycombine( var_ce96f226b96916de, capture_zone.var_66a818966f37272 );
    var_ce96f226b96916de = arraycombine( var_ce96f226b96916de, capture_zone.var_65d38712dbee6b1b );
    thread function_b95c324c7b2d9f63( capture_zone.origin, 900, staggered_delay, var_ce96f226b96916de, shouldstun, stun_duration );
    
    if ( shouldrumble )
    {
        if ( shouldstun )
        {
            earthquake( 0.1, 0.5, capture_zone.origin, 900 );
            playrumbleonposition( "damage_light", capture_zone.origin );
            return;
        }
        
        earthquake( 0.2, 1.5, capture_zone.origin, 1800 );
        playrumbleonposition( "damage_heavy", capture_zone.origin );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x89887586, Offset: 0x74eb
// Size: 0x97
function function_390e79cb196862c6()
{
    agent = self;
    agent endon( #"death" );
    var_a8e8b7b08c3d7f84 = 0;
    
    while ( true )
    {
        if ( agent utility::ent_flag( "adz_active" ) && !var_a8e8b7b08c3d7f84 )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "ADZ", 20 );
            var_a8e8b7b08c3d7f84 = 1;
        }
        else if ( !agent utility::ent_flag( "adz_active" ) && var_a8e8b7b08c3d7f84 )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "ADZ", -1 );
            var_a8e8b7b08c3d7f84 = 0;
        }
        
        wait 1;
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x223b7eff, Offset: 0x758a
// Size: 0xfd
function private function_9a038c29f2e23108( capture_zone )
{
    agent = self;
    agent forcethreatupdate();
    agent function_fa32376aaa88a7a2( capture_zone.origin, capture_zone.additional_data.var_fc86768f71aa63d1 );
    agent namespace_659599414270bd0a::function_80623a2279a4d888();
    agent val::set( "mcz_spawn", "dont_evolve" );
    agent utility::ent_flag_set( "ghoul_evolve_disabled" );
    agent zombie_utils::function_a8ce00e0448cb6f0( "run", "Capture", 10 );
    memory_id = toupper( capture_zone.id );
    
    switch ( memory_id )
    {
        case #"hash_35861a505531e326":
            break;
        case #"hash_f803ad0f0063453b":
            agent thread namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
            break;
        case #"hash_79aed645c0e19679":
            break;
        case #"hash_f3c89e4046164320":
            break;
        default:
            break;
    }
}

// Namespace gemini_util
// Params 4, eflags: 0x4
// Checksum 0x797f7997, Offset: 0x768f
// Size: 0x74
function private function_ffa2cca74927b61e( requestid, userdata, agent, data )
{
    capture_zone = userdata;
    agent endon( #"death" );
    agent function_9a038c29f2e23108( userdata );
    capture_zone.should_spawn = 0;
    capture_zone.var_66a818966f37272[ capture_zone.var_66a818966f37272.size ] = agent;
}

// Namespace gemini_util
// Params 4, eflags: 0x4
// Checksum 0x7055790d, Offset: 0x770b
// Size: 0x74
function private function_80a46fd1983a368c( requestid, userdata, agent, data )
{
    capture_zone = userdata;
    agent endon( #"death" );
    agent function_9a038c29f2e23108( userdata );
    capture_zone.should_spawn_floodfill = 0;
    capture_zone.var_65d38712dbee6b1b[ capture_zone.var_65d38712dbee6b1b.size ] = agent;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x66aa4376, Offset: 0x7787
    // Size: 0x5, Type: dev
    function function_9638781994177575()
    {
        
    }

#/

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x19797bed, Offset: 0x7794
// Size: 0x20
function private function_22dfdcc52cdbe643( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xd09e4d4f, Offset: 0x77bd
// Size: 0x38
function private function_a05b8aefef18ad36( requestid, userdata )
{
    if ( userdata.complete )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
    }
    
    return userdata.complete;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xf0defa75, Offset: 0x77fe
// Size: 0x29
function private function_1529521535a213d9( requestid, userdata )
{
    userdata.should_spawn = 0;
    function_fbe9bb47edbe2d7c( requestid );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x36477ac, Offset: 0x782f
// Size: 0x43
function private function_f38fb569130ec856( requestid, userdata )
{
    userdata notify( #"finished_spawning_checkpoint" );
    
    if ( userdata.additional_data.var_2c303adb6cfb3b2c )
    {
        userdata thread function_db6d58018faeddae();
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x67985052, Offset: 0x787a
// Size: 0x20
function private function_e6f6d80b59d418a1( requestid, userdata )
{
    return userdata.should_spawn_floodfill;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x35612426, Offset: 0x78a3
// Size: 0x38
function private function_d11d77bfbe89fe74( requestid, userdata )
{
    if ( userdata.complete )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
    }
    
    return userdata.complete;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xd930acf2, Offset: 0x78e4
    // Size: 0x5, Type: dev
    function function_b63fbbb63ab79da6()
    {
        
    }

#/

// Namespace gemini_util
// Params 4
// Checksum 0x8a383d49, Offset: 0x78f1
// Size: 0x209
function function_7c837ecf65df2e45( memory_name, var_5320909f912ec31b, flag_endon, flag_completed )
{
    ent_scriptable = self;
    
    if ( !isdefined( flag_endon ) )
    {
        flag_endon = "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE";
    }
    
    if ( !isdefined( flag_completed ) )
    {
        flag_completed = "mcz_interact_object_cleaned_up";
    }
    
    if ( !isdefined( ent_scriptable.angles ) )
    {
        ent_scriptable.angles = ( 0, 0, 0 );
    }
    
    animnode = utility::getstruct( "sat_cin_gem_cabin_capture_point_monitors_" + memory_name, "targetname" );
    monitor_clip = getent( memory_name + "_interact_clip", #targetname );
    thread function_47b01a9986d87e94( animnode, memory_name, ent_scriptable, monitor_clip );
    animnode scene::play( undefined, "path" );
    animnode thread scene::play( undefined, "idle_end" );
    
    if ( isdefined( monitor_clip ) )
    {
        monitor_clip hide();
    }
    
    var_78f510479a8117f4 = animnode.scenedata.sceneroot scene::get_entity( memory_name + "_white" );
    var_78f510479a8117f4 notify( #"hash_c29a0f3aea9ce92" );
    playfxontag( level._effect[ "memory_projection" ], var_78f510479a8117f4, "tag_full" );
    ent_scriptable unlink();
    ent_scriptable.origin = var_78f510479a8117f4.origin;
    ent_scriptable.angles = var_78f510479a8117f4.angles;
    
    switch ( var_5320909f912ec31b )
    {
        case #"hash_ef4afdcfa1fa3f24":
            ent_scriptable setscriptablepartstate( "base", "monitoring_initial" );
            break;
        case #"hash_3d2443674a3756e":
            ent_scriptable setscriptablepartstate( "base", "monitoring_woods" );
            break;
        case #"hash_c1cadbc8b9a8e7f1":
            ent_scriptable setscriptablepartstate( "base", "monitoring_basement" );
            break;
        case #"hash_6e4570dbf9adc7e7":
            ent_scriptable setscriptablepartstate( "base", "monitoring_cliffs" );
            break;
    }
    
    var_78f510479a8117f4 thread function_e195ed6a458b26e( memory_name, flag_endon, ent_scriptable, flag_completed );
}

// Namespace gemini_util
// Params 4
// Checksum 0x897d1838, Offset: 0x7b02
// Size: 0x9d
function function_47b01a9986d87e94( animnode, memory_name, ent_scriptable, monitor_clip )
{
    waitframe();
    monitor_ent = animnode.scenedata.sceneroot scene::get_entity( memory_name );
    
    if ( isdefined( monitor_ent ) )
    {
        ent_scriptable enablelinkto();
        ent_scriptable linkto( monitor_ent );
        playfxontag( level._effect[ "memory_tv_trail" ], monitor_ent, "tag_origin" );
        
        if ( isdefined( monitor_clip ) )
        {
            monitor_clip show();
            monitor_clip enablelinkto();
            monitor_clip linkto( ent_scriptable );
        }
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0x17a72abb, Offset: 0x7ba7
// Size: 0x44
function function_b0cf42c9ef53f8a8( v_look_at, final_waypoint, f_lerp_time )
{
    self endon( #"hash_c29a0f3aea9ce92" );
    self rotateto( vectortoangles( v_look_at - final_waypoint ), f_lerp_time, f_lerp_time / 4, f_lerp_time / 4 );
}

// Namespace gemini_util
// Params 4
// Checksum 0xa6f594de, Offset: 0x7bf3
// Size: 0x122
function function_e195ed6a458b26e( memory_name, flag_endon, ent_scriptable, flag_completed )
{
    if ( isdefined( flag_endon ) )
    {
        level utility::flag_wait( flag_endon );
        
        if ( isdefined( ent_scriptable ) && isdefined( self ) )
        {
            if ( memory_name == "memory01" )
            {
                var_57b3fa4eb64deb8c = utility::getstruct( "sat_cin_gem_cabin_capture_point_monitors_memory01", "targetname" );
                var_57b3fa4eb64deb8c scene::play( undefined, "path_3" );
                var_57b3fa4eb64deb8c thread scene::play( undefined, "idle_end_4" );
            }
            
            if ( isdefined( ent_scriptable ) && isdefined( self ) )
            {
                ent_scriptable.origin = self.origin;
                ent_scriptable.angles = self.angles;
                ent_scriptable setscriptablepartstate( "base", "dead" );
                stopfxontag( level._effect[ "memory_projection" ], self, "tag_full" );
                namespace_60d9b3cbf41663fe::function_5896811a3fcd56ae( memory_name );
                wait 2.5;
                ent_scriptable setscriptablepartstate( "base", "finished" );
            }
        }
        
        if ( isdefined( flag_completed ) )
        {
            level utility::flag_set( flag_completed );
        }
        
        if ( isdefined( self ) )
        {
            self delete();
        }
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xed5cad78, Offset: 0x7d1d
// Size: 0x1e0
function function_c7a14fa875ed527b( a_vfx_waypoints, f_lerp_time, var_2fd0edb6659aeddb )
{
    ent_scriptable = self;
    
    if ( !isdefined( a_vfx_waypoints ) )
    {
        /#
            iprintln( "<dev string:x24e>" );
        #/
        
        return;
    }
    
    level endon( #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    
    if ( !isdefined( f_lerp_time ) )
    {
        f_lerp_time = 10;
    }
    
    if ( !isdefined( var_2fd0edb6659aeddb ) )
    {
        var_2fd0edb6659aeddb = "mcz_interact_object_cleaned_up";
    }
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    level utility::flag_wait( var_2fd0edb6659aeddb );
    var_4b47655c33f51e24 = utility::spawn_tag_origin();
    var_4b47655c33f51e24.origin = self.origin;
    var_4b47655c33f51e24.angles = self.angles;
    var_4b47655c33f51e24 show();
    waitframe();
    playfxontag( level._effect[ "memory_tv_trail" ], var_4b47655c33f51e24, "tag_origin" );
    
    if ( a_vfx_waypoints.size > 1 )
    {
        var_c825b792756a2787 = f_lerp_time / a_vfx_waypoints.size;
    }
    else
    {
        var_c825b792756a2787 = f_lerp_time;
    }
    
    foreach ( waypoint in a_vfx_waypoints )
    {
        if ( isvector( waypoint ) )
        {
            waypoint_pos = waypoint;
        }
        else
        {
            waypoint_struct = utility::getstruct( waypoint, "targetname" );
            waypoint_pos = waypoint_struct.origin;
        }
        
        var_4b47655c33f51e24 moveto( waypoint_pos, var_c825b792756a2787, var_c825b792756a2787 / 4, var_c825b792756a2787 / 4 );
        wait var_c825b792756a2787;
    }
    
    stopfxontag( level._effect[ "memory_tv_trail" ], var_4b47655c33f51e24, "tag_origin" );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xd987db63, Offset: 0x7f05
    // Size: 0x5, Type: dev
    function function_4a87bf4cdd442b5a()
    {
        
    }

#/

// Namespace gemini_util
// Params 5
// Checksum 0x1a84df6, Offset: 0x7f12
// Size: 0x1d1
function function_44166e34e7081b17( a_capture_zone, missionasset, players, options, var_b60496d5b429ae0f )
{
    activity_instance = self;
    
    if ( !isdefined( missionasset ) || !isdefined( players ) || !isdefined( options ) )
    {
        return 0;
    }
    
    activity_instance namespace_b451b5202140ccde::function_bb923ce693c606f9( missionasset, players, options );
    activity_instance mission_ui::function_6065da0279993033( 2, players );
    options.zone_count = a_capture_zone.size;
    activity_instance mission_ui::function_759924b87215156b( 0, options.zone_count, players );
    
    foreach ( capture_zone in a_capture_zone )
    {
        if ( capture_zone.complete )
        {
            activity_instance mission_ui::function_759924b87215156b( capture_zone.activity_instance.var_30371edbcd339720, options.zone_count, players );
            activity_instance mission_ui::function_d84701041f6f95c2( capture_zone.additional_data.var_dc9e2e7abca8f787, options.var_e866adf65a6cef87, options.var_e866adf65a6cef87, players );
            continue;
        }
        
        activity_instance mission_ui::function_d84701041f6f95c2( capture_zone.additional_data.var_dc9e2e7abca8f787, 0, options.var_e866adf65a6cef87, players );
        activity_instance thread function_d201cef61ebaf08f( capture_zone, players, options );
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        utility::flag_wait( var_b60496d5b429ae0f );
        activity_instance mission_ui::function_759924b87215156b( 0, 1, players );
        activity_instance mission_ui::function_6065da0279993033( 0, players );
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xf27f83b9, Offset: 0x80eb
// Size: 0x19c
function function_d201cef61ebaf08f( capture_zone, players, options )
{
    activity_instance = self;
    end_flag = "OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE";
    
    if ( options.a_end_flag.size > 1 )
    {
        end_flag = "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_COMPLETE";
        
        if ( capture_zone == level.capture_zone_basement )
        {
            end_flag = "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_COMPLETE";
        }
        else if ( capture_zone == level.capture_zone_dock )
        {
            end_flag = "OB_GEMINI_MCZ_CHECKPOINT_WOODS_COMPLETE";
        }
    }
    
    while ( !utility::flag( end_flag ) )
    {
        if ( isdefined( capture_zone.var_62e46f7d044c1a4f ) )
        {
            cur_progress = int( floor( capture_zone.var_62e46f7d044c1a4f * 100 ) );
            var_bb45229f38ea98b7 = capture_zone.activity_instance.var_30371edbcd339720;
            activity_instance mission_ui::function_759924b87215156b( var_bb45229f38ea98b7, options.zone_count, players );
            activity_instance mission_ui::function_d84701041f6f95c2( capture_zone.additional_data.var_dc9e2e7abca8f787, cur_progress, options.var_e866adf65a6cef87, players );
        }
        
        wait 1;
    }
    
    var_bb45229f38ea98b7 = capture_zone.activity_instance.var_30371edbcd339720;
    activity_instance mission_ui::function_759924b87215156b( var_bb45229f38ea98b7, options.zone_count, players );
    
    if ( options.a_end_flag.size > 1 )
    {
        activity_instance mission_ui::function_d84701041f6f95c2( capture_zone.additional_data.var_dc9e2e7abca8f787, options.var_e866adf65a6cef87, options.var_e866adf65a6cef87, players );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xefd28ef8, Offset: 0x828f
    // Size: 0x5, Type: dev
    function function_901626a845998c13()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0x5536ad9f, Offset: 0x829c
// Size: 0xfa
function function_401a0ddccdf00715( screen_noteworthy )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    level.screens_think_func = &screens::screens_think;
    screens::init();
    var_a631634dbbb93ca5 = getscriptablearray( screen_noteworthy, #script_noteworthy );
    var_4e210c59337060c = getentitylessscriptablearray( screen_noteworthy, #script_noteworthy );
    a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    
    if ( a_screens.size > 0 )
    {
        foreach ( screen in a_screens )
        {
            screen function_99c1d8f91f01aa95();
            waitframe();
        }
    }
    
    return a_screens;
}

// Namespace gemini_util
// Params 0
// Checksum 0xbe0fb705, Offset: 0x839f
// Size: 0x96
function function_99c1d8f91f01aa95()
{
    self endon( #"death" );
    
    if ( !isdefined( self.script_parameters ) )
    {
        return;
    }
    
    if ( self getscriptablehaspart( "screen" ) )
    {
        state = self getscriptablepartstate( "screen" );
        
        if ( !isdefined( state ) || state == "dead" || state == "dead2" || state == "dead3" )
        {
            return;
        }
        
        if ( self getscriptableparthasstate( "screen", self.script_parameters ) )
        {
            self setscriptablepartstate( "screen", self.script_parameters );
        }
    }
}

// Namespace gemini_util
// Params 9
// Checksum 0x2044ef8e, Offset: 0x843d
// Size: 0x167
function function_1a2dee7491815110( flag_wait_trigger, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    activity_instance = self;
    waitframe();
    var_a631634dbbb93ca5 = getscriptablearray( screen_noteworthy, #script_noteworthy );
    var_4e210c59337060c = getentitylessscriptablearray( screen_noteworthy, #script_noteworthy );
    a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    
    if ( isdefined( flag_wait_trigger ) )
    {
        level utility::flag_wait( flag_wait_trigger );
    }
    
    playing_players = ob_story_mission_utils::get_playing_players();
    
    foreach ( player in playing_players )
    {
        activity_instance thread function_9ba79a3132ce54d3( player, a_screens, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted );
    }
    
    level thread function_6d14505a3345bc44( a_screens, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_end, flag_force_end );
}

// Namespace gemini_util
// Params 10
// Checksum 0xc7eb65ad, Offset: 0x85ac
// Size: 0x1e7
function function_216caa29c9603d8e( trigger_name, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_start, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    activity_instance = self;
    waitframe();
    var_a631634dbbb93ca5 = getscriptablearray( screen_noteworthy, #script_noteworthy );
    var_4e210c59337060c = getentitylessscriptablearray( screen_noteworthy, #script_noteworthy );
    a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    trigger = getnoentvolumearray( trigger_name, #targetname )[ 0 ];
    
    if ( isdefined( trigger ) )
    {
        while ( true )
        {
            trigger waittill( #"trigger", ent );
            
            if ( isplayer( ent ) )
            {
                break;
            }
            
            waitframe();
        }
        
        if ( isdefined( trigger.script_flag_set ) )
        {
            level utility::flag_set( trigger.script_flag_set );
        }
    }
    
    if ( isdefined( flag_set_on_start ) )
    {
        utility::flag_set( flag_set_on_start );
    }
    
    if ( a_screens.size > 0 )
    {
        playing_players = ob_story_mission_utils::get_playing_players();
        
        foreach ( player in playing_players )
        {
            activity_instance thread function_9ba79a3132ce54d3( player, a_screens, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted );
        }
        
        level thread function_6d14505a3345bc44( a_screens, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_end, flag_force_end );
    }
}

// Namespace gemini_util
// Params 9
// Checksum 0xcbd43e09, Offset: 0x879b
// Size: 0x1b6
function function_60475284edbb43a8( var_814ba4e0b8f4dec4 = 1.5, bink_name, bink_state, b_looping, screen_noteworthy, flag_wait_to_start, ob_objective_original, ob_objective_twisted, var_539d7ecab403c70 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    activity_instance = self;
    waitframe();
    var_a631634dbbb93ca5 = getscriptablearray( screen_noteworthy, #script_noteworthy );
    var_4e210c59337060c = getentitylessscriptablearray( screen_noteworthy, #script_noteworthy );
    a_screens = arraycombine( var_a631634dbbb93ca5, var_4e210c59337060c );
    
    if ( isdefined( flag_wait_to_start ) )
    {
        utility::flag_wait( flag_wait_to_start );
    }
    
    flag_set_on_end = "flag_" + screen_noteworthy + "_end";
    flag_force_end = "flag_" + screen_noteworthy + "_stop";
    level thread utility::flag_set_delayed( flag_force_end, var_814ba4e0b8f4dec4 );
    
    if ( a_screens.size > 0 )
    {
        playing_players = ob_story_mission_utils::get_playing_players();
        
        foreach ( player in playing_players )
        {
            activity_instance thread function_9ba79a3132ce54d3( player, a_screens, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted, var_539d7ecab403c70 );
        }
        
        level thread function_6d14505a3345bc44( a_screens, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_end, flag_force_end );
    }
}

// Namespace gemini_util
// Params 7
// Checksum 0xd10e3072, Offset: 0x8959
// Size: 0x275
function function_9ba79a3132ce54d3( player, a_screens, flag_set_on_end, flag_force_end, ob_objective_original, ob_objective_twisted, var_539d7ecab403c70 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    activity_instance = self;
    var_674ee0abdfa99fed = 80;
    far_dist = 160;
    near_dist_sq = squared( var_674ee0abdfa99fed );
    var_68683cd0fec692e1 = squared( far_dist );
    b_fov_change = 0;
    var_1b551bc3c85b5736 = 0;
    b_objective_twisted = 0;
    var_7639cacc79b5c662 = [];
    
    if ( isdefined( var_539d7ecab403c70 ) && player utility::ent_flag( var_539d7ecab403c70 ) )
    {
        return;
    }
    
    if ( isdefined( flag_force_end ) && utility::flag( flag_force_end ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( isdefined( var_539d7ecab403c70 ) && player utility::ent_flag( var_539d7ecab403c70 ) )
        {
            break;
        }
        
        if ( isdefined( flag_force_end ) && level utility::flag( flag_force_end ) )
        {
            break;
        }
        
        if ( activity_instance.state != "Active" )
        {
            break;
        }
        
        var_7639cacc79b5c662 = sortbydistancecullbyradius( a_screens, player.origin, far_dist );
        
        if ( isdefined( var_7639cacc79b5c662[ 0 ] ) )
        {
            if ( isdefined( ob_objective_twisted ) && !b_objective_twisted )
            {
                activity_instance function_1ccf2c772a3b527e( player, ob_objective_twisted, 1 );
                b_objective_twisted = 1;
            }
            
            player_dist_sq = distancesquared( player.origin, var_7639cacc79b5c662[ 0 ].origin );
            
            if ( player_dist_sq < near_dist_sq )
            {
                player emp_debuff::play_emp_scramble( 2 );
                var_1b551bc3c85b5736 = 1;
                
                if ( !b_fov_change )
                {
                    player function_1cdd28af12b71f9c( -5, 1 );
                    b_fov_change = 1;
                }
            }
            else
            {
                if ( var_1b551bc3c85b5736 )
                {
                    player emp_debuff::stop_emp_scramble( 2 );
                    var_1b551bc3c85b5736 = 0;
                }
                
                player emp_debuff::play_emp_scramble( 1 );
                
                if ( b_fov_change )
                {
                    player player_fov_restore( 1 );
                    b_fov_change = 0;
                }
            }
        }
        else
        {
            if ( isdefined( ob_objective_original ) && b_objective_twisted )
            {
                activity_instance function_1ccf2c772a3b527e( player, ob_objective_original, 0 );
                b_objective_twisted = 0;
            }
            
            player emp_debuff::clear_emp_scramble();
            var_1b551bc3c85b5736 = 0;
        }
        
        wait 1;
    }
    
    wait 1;
    player emp_debuff::clear_emp_scramble();
    player player_fov_restore();
    
    if ( isdefined( flag_set_on_end ) )
    {
        level utility::flag_set( flag_set_on_end );
    }
    
    if ( isdefined( ob_objective_original ) && b_objective_twisted )
    {
        activity_instance function_1ccf2c772a3b527e( player, ob_objective_original, 0 );
    }
}

// Namespace gemini_util
// Params 7
// Checksum 0xe67058c8, Offset: 0x8bd6
// Size: 0xfc
function function_6d14505a3345bc44( var_efbc8c5a72fcd7d2, bink_name, bink_state, b_looping, screen_noteworthy, flag_set_on_end, flag_force_end )
{
    utility::flag_wait( "scriptables_ready" );
    level notify( #"hash_ef8ffaff5154f13" );
    
    foreach ( screen in var_efbc8c5a72fcd7d2 )
    {
        if ( screen getscriptableparthasstate( "screen", bink_state ) )
        {
            screen setscriptablepartstate( "screen", bink_state );
        }
        
        waitframe();
    }
    
    waitframe();
    function_3d2da654f996174d( var_efbc8c5a72fcd7d2, flag_force_end );
    
    if ( isdefined( flag_set_on_end ) )
    {
        utility::flag_set( flag_set_on_end );
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x9df3023e, Offset: 0x8cda
// Size: 0xee
function function_3d2da654f996174d( var_efbc8c5a72fcd7d2, flag_force_end )
{
    level endon( #"game_ended", #"bink_complete", #"hash_ef8ffaff5154f13" );
    level lui_game_event_aggregator::registeronluieventcallback( &function_b23a53b5824fc944 );
    a_flag_endon = [];
    
    if ( isdefined( flag_force_end ) )
    {
        if ( isarray( flag_force_end ) )
        {
            a_flag_endon = arraycombine( a_flag_endon, flag_force_end );
        }
        else
        {
            a_flag_endon[ a_flag_endon.size ] = flag_force_end;
        }
    }
    
    utility::flag_wait_any_array( a_flag_endon );
    
    foreach ( screen in var_efbc8c5a72fcd7d2 )
    {
        screen function_99c1d8f91f01aa95();
        waitframe();
    }
    
    stopcinematicforall();
}

// Namespace gemini_util
// Params 2
// Checksum 0x54968f93, Offset: 0x8dd0
// Size: 0x2c
function function_b23a53b5824fc944( channel, val )
{
    if ( channel == "bink_complete" )
    {
        level notify( #"bink_complete" );
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xfb205743, Offset: 0x8e04
// Size: 0x90
function function_1ccf2c772a3b527e( player, obj_string_ref, b_twisted )
{
    activity_instance = self;
    
    if ( utility::flag( "flag_player_show_minimap" ) || utility::flag( "flag_tunnels_prison_complete" ) )
    {
        return;
    }
    
    /#
        if ( b_twisted )
        {
            iprintlnbold( "<dev string:x290>" + obj_string_ref );
        }
        else
        {
            iprintlnbold( "<dev string:x2a3>" + obj_string_ref );
        }
    #/
    
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ player ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( obj_string_ref, [ player ] );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xbf91a9e2, Offset: 0x8e9c
    // Size: 0x5, Type: dev
    function function_ba1eb1b1d8ba8490()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xdad14d36, Offset: 0x8ea9
// Size: 0x186
function function_b2a7298af063a503()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    var_9f3191ed671fca85 = 225;
    
    if ( isent( level.players[ 0 ] ) )
    {
        var_9f3191ed671fca85 = squared( level.players[ 0 ] getboundshalfsize()[ 0 ] );
    }
    
    n_radius = 32;
    
    while ( true )
    {
        if ( !isalive( self ) )
        {
            return;
        }
        
        playing_players = ob_story_mission_utils::get_playing_players();
        
        if ( !isarray( playing_players ) )
        {
            return;
        }
        
        var_147f36b70a2f8293 = sortbydistancecullbyradius( playing_players, self.origin, n_radius );
        
        if ( var_147f36b70a2f8293.size > 0 )
        {
            player = var_147f36b70a2f8293[ 0 ];
            player_center_point = player getcentroid();
            zombie_center_point = self getcentroid();
            playerforward = anglestoforward( player.angles );
            var_c51215b779b5fe59 = vectornormalize( player.origin - self.origin );
            
            if ( distancesquared( player_center_point, zombie_center_point ) <= var_9f3191ed671fca85 )
            {
                self function_7f8988ce63c1623d( 0 );
                wait 3;
            }
            else if ( vectordot( playerforward, var_c51215b779b5fe59 ) < 0 && distancesquared( player_center_point, zombie_center_point ) >= 22500 )
            {
                self function_7f8988ce63c1623d( 0 );
                wait 3;
            }
            else if ( length( player getvelocity() ) < 430 && vectordot( playerforward, var_c51215b779b5fe59 ) > 0 )
            {
                self function_7f8988ce63c1623d( 0 );
                wait 3;
            }
            else
            {
                self function_7f8988ce63c1623d( 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xedc017d3, Offset: 0x9037
// Size: 0xee
function function_376f4cf6d212ef9b( var_47a9a3a3a762b48d, var_14b04447cc02d5a9 )
{
    self endon( #"death" );
    ob_story_mission_utils::function_ac2a2440f56b2342( "difficulty_low" );
    function_677a023b1546ec8( level.players[ 0 ] );
    self.dontdroploot = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_914a5379b8e8fd3 = 1;
    self.var_91442a0c87df2f49 = 32;
    val::set( "zombie_friendly", "allow_unreachable_attack", 0 );
    speed = "sprint";
    
    if ( utility::cointoss() )
    {
        speed = "super_sprint";
    }
    
    thread function_b2a7298af063a503();
    thread function_321a59001f7e61f();
    thread zombie_utils::function_a8ce00e0448cb6f0( speed, "difficulty_region", 1 );
    
    if ( var_47a9a3a3a762b48d )
    {
        self.var_73d79b5219b914a7 = self.maxhealth;
        self.maxhealth = var_47a9a3a3a762b48d;
    }
    
    self disableaimassist();
    thread function_d2e963e3d9fd1a0e( 5000 );
}

// Namespace gemini_util
// Params 0
// Checksum 0xca6ed3ef, Offset: 0x912d
// Size: 0x154
function function_321a59001f7e61f()
{
    level endon( #"game_ended" );
    waypointid = undefined;
    
    while ( true )
    {
        if ( !isalive( self ) || !isagent( self ) || self.health <= 0 || self.type != "zombie" )
        {
            break;
        }
        
        a_players = getplayersinradius( self.origin, 1024 );
        
        if ( a_players.size > 0 && !isdefined( waypointid ) )
        {
            if ( isdefined( level.objectiveidpool.active ) && level.objectiveidpool.active.size > 20 )
            {
                wait 1;
                continue;
            }
            
            waypointid = objidpoolmanager::requestobjectiveid();
            
            if ( isdefined( waypointid ) )
            {
                objidpoolmanager::objective_add_objective( waypointid, "active", self.origin, "hud_icon_minimap_player_enemy_ai", "icon_small" );
                objidpoolmanager::update_objective_onentity( waypointid, self );
                objidpoolmanager::update_objective_setbackground( waypointid, 1 );
                objidpoolmanager::function_373aaf492aabde6f( waypointid, 0, 255, 0 );
                objidpoolmanager::function_586b631e7bbb592a( waypointid, 1 );
            }
        }
        else if ( isdefined( waypointid ) )
        {
            if ( !objidpoolmanager::function_fb05d646a96ed99e( waypointid ) )
            {
                objidpoolmanager::returnobjectiveid( waypointid );
            }
            
            waypointid = undefined;
        }
        
        wait 1;
    }
    
    if ( isdefined( waypointid ) )
    {
        objidpoolmanager::returnobjectiveid( waypointid );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x950e9d4e, Offset: 0x9289
// Size: 0x2ee
function function_11266ff8ae084f14( var_725fccb7a39c4d9e )
{
    self endon( #"death", #"hash_755d26458a238372" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isdefined( var_725fccb7a39c4d9e ) && !utility::flag( var_725fccb7a39c4d9e ) )
        {
            if ( !level.is_squad_size_small || level.players.size > 2 )
            {
                n_lethality = 80;
            }
            else
            {
                n_lethality = 60;
            }
        }
        else if ( !level.is_squad_size_small || level.players.size > 2 )
        {
            n_lethality = 30;
        }
        else
        {
            n_lethality = 20;
        }
        
        if ( isdefined( attacker.directorspawndata.script_noteworthy ) && isalive( attacker ) )
        {
            switch ( attacker.directorspawndata.script_noteworthy )
            {
                case #"hash_4ad475e6e15635bd":
                    n_lethality += randomintrange( 40, 80 );
                    break;
                case #"hash_c9ce32066612c729":
                    n_lethality += randomintrange( 20, 80 );
                    break;
                case #"hash_953decc7f31226d1":
                    n_lethality += randomintrange( 20, 60 );
                    break;
                case #"hash_5750d6ce52be2eda":
                    n_lethality += randomint( 60 );
                    break;
                default:
                    break;
            }
        }
        else if ( isdefined( objweapon ) && isdefined( objweapon.basename ) )
        {
            if ( objweapon.basename == "sat_vtol_warship_proj_ob" )
            {
                n_lethality += randomintrange( 40, 80 );
            }
            else if ( objweapon.basename == "vtol_warship_turret_ob" )
            {
                n_lethality += randomintrange( 20, 80 );
            }
        }
        
        if ( n_lethality > 75 )
        {
            namespace_b76ff2659823e89d::function_61b75f09c6601780();
            self kill();
        }
        else if ( n_lethality > 50 )
        {
            var_51ef870503967f06 = point[ 2 ] - self.origin[ 2 ];
            
            if ( var_51ef870503967f06 > 48 )
            {
                namespace_b76ff2659823e89d::function_6c318bca7bb326e7();
            }
            else
            {
                switch ( randomint( 5 ) )
                {
                    case 0:
                        namespace_b76ff2659823e89d::dismember_left_arm();
                        break;
                    case 1:
                        namespace_b76ff2659823e89d::dismember_right_arm();
                        break;
                    default:
                        namespace_b76ff2659823e89d::function_14463e39cc414bab( 1 );
                        break;
                }
            }
        }
        else if ( utility::cointoss() )
        {
            zombie_knockdown::function_a113e6ee43535d37( attacker.origin, damage * 2 );
        }
        
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xd46716cc, Offset: 0x957f
// Size: 0x320
function prison_ai_corpse_cleanup( var_d965d0d3bc6eec0b = "flag_gemini_exfil_igc_begin", var_b5c3d0fdb66bae01 = 1 )
{
    self notify( #"hash_e49b2e8bb6ed37ce" );
    self endon( #"hash_e49b2e8bb6ed37ce" );
    level endon( #"game_ended", var_d965d0d3bc6eec0b );
    self endon( #"death" );
    player = self;
    n_max_corpses = undefined;
    var_70c51be3d4733f5a = 0;
    
    if ( utility::ent_flag( "flag_prison_ai_corpse_cleanup" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "flag_prison_ai_corpse_cleanup" );
    
    while ( true )
    {
        if ( !isdefined( self.origin ) )
        {
            return;
        }
        
        var_847d084dec62c9ef = function_955f614470e71cb2( player.origin, 2048 );
        var_847d084dec62c9ef = function_628bac9faa9d1e86( var_847d084dec62c9ef, player.origin, 1 );
        
        if ( getdvarint( @"hash_8b88126412195b30", 0 ) == 1 )
        {
            /#
                iprintlnbold( "<dev string:x2b7>" + var_847d084dec62c9ef.size );
            #/
        }
        
        if ( var_847d084dec62c9ef.size == 0 )
        {
            wait 1;
            continue;
        }
        
        count_all_ai = getaicount();
        
        if ( count_all_ai > 20 )
        {
            switch ( level.players.size )
            {
                case 3:
                case 4:
                    n_max_corpses = 3;
                    break;
                case 2:
                    n_max_corpses = 4;
                    break;
                case 1:
                default:
                    n_max_corpses = 6;
                    break;
            }
        }
        else
        {
            switch ( level.players.size )
            {
                case 3:
                case 4:
                    n_max_corpses = 4;
                    break;
                case 2:
                    n_max_corpses = 5;
                    break;
                case 1:
                default:
                    n_max_corpses = 8;
                    break;
            }
        }
        
        if ( var_847d084dec62c9ef.size > n_max_corpses )
        {
            if ( count_all_ai > 30 || var_847d084dec62c9ef.size > 12 )
            {
                var_70c51be3d4733f5a = 1;
            }
            else if ( count_all_ai > 20 && var_847d084dec62c9ef.size > 8 )
            {
                var_70c51be3d4733f5a = 1;
            }
            
            var_e9ddb51fe25d20b0 = var_847d084dec62c9ef.size - n_max_corpses;
            var_492921b20a7aa385 = var_e9ddb51fe25d20b0;
            var_ab73f7134f0b8e1c = 0;
            var_fb34d7681fe65fd9 = 0;
            var_ab73f7134f0b8e1c = function_441142be438ef9e1( var_847d084dec62c9ef, var_e9ddb51fe25d20b0, 0, 0 );
            var_fb34d7681fe65fd9 += var_ab73f7134f0b8e1c;
            
            if ( var_70c51be3d4733f5a && var_ab73f7134f0b8e1c < var_e9ddb51fe25d20b0 )
            {
                var_e9ddb51fe25d20b0 -= var_ab73f7134f0b8e1c;
                var_847d084dec62c9ef = function_5713d46873b29625( var_847d084dec62c9ef );
                
                if ( var_847d084dec62c9ef.size > 0 )
                {
                    var_ab73f7134f0b8e1c = function_441142be438ef9e1( var_847d084dec62c9ef, var_e9ddb51fe25d20b0, var_b5c3d0fdb66bae01, 1, 1 );
                    var_fb34d7681fe65fd9 += var_ab73f7134f0b8e1c;
                    
                    if ( var_ab73f7134f0b8e1c < var_e9ddb51fe25d20b0 )
                    {
                        var_e9ddb51fe25d20b0 -= var_ab73f7134f0b8e1c;
                        var_847d084dec62c9ef = function_5713d46873b29625( var_847d084dec62c9ef );
                        
                        if ( var_847d084dec62c9ef.size > 0 )
                        {
                            var_ab73f7134f0b8e1c = function_441142be438ef9e1( var_847d084dec62c9ef, var_e9ddb51fe25d20b0, var_b5c3d0fdb66bae01, 1 );
                            var_fb34d7681fe65fd9 += var_ab73f7134f0b8e1c;
                        }
                    }
                }
            }
        }
        
        if ( getdvarint( @"hash_8b88126412195b30", 0 ) == 1 )
        {
            wait 1;
            
            /#
                iprintlnbold( "<dev string:x2c1>" + var_fb34d7681fe65fd9 + "<dev string:x2d3>" + var_492921b20a7aa385 );
            #/
        }
        
        wait randomfloatrange( 2, 4 );
    }
}

// Namespace gemini_util
// Params 6, eflags: 0x4
// Checksum 0x5cb867d3, Offset: 0x98a7
// Size: 0x236
function private function_441142be438ef9e1( var_847d084dec62c9ef, var_e9ddb51fe25d20b0, var_b5c3d0fdb66bae01 = 1, b_ignore_fov = 0, var_d161cdef1eaba5a8 = 0, b_delete_fx = 1 )
{
    level endon( #"game_ended" );
    var_ab73f7134f0b8e1c = 0;
    fov = cos( 45 );
    
    if ( b_delete_fx )
    {
        var_dbe23f4abfd54b1a = utility::getfx( "vfx_sat_wc_ai_cradle_soldier_death_01" );
        var_50e41ead1858f772 = utility::getfx( "memory_cradle_dissipate_1" );
    }
    
    for ( i = 0; i < var_847d084dec62c9ef.size ; i++ )
    {
        if ( var_ab73f7134f0b8e1c >= var_e9ddb51fe25d20b0 )
        {
            return 1;
        }
        
        corpse_to_remove = var_847d084dec62c9ef[ i ];
        
        if ( isdefined( corpse_to_remove ) )
        {
            if ( var_b5c3d0fdb66bae01 && isdefined( corpse_to_remove.team ) && corpse_to_remove.team != level.players[ 0 ].team )
            {
                continue;
            }
            
            b_within_fov = within_fov_of_players( corpse_to_remove.origin, fov, var_d161cdef1eaba5a8 );
            
            if ( b_ignore_fov || !b_within_fov )
            {
                if ( getdvarint( @"hash_8b88126412195b30", 0 ) == 1 )
                {
                    if ( b_within_fov )
                    {
                        if ( var_d161cdef1eaba5a8 )
                        {
                            color = ( 1, 1, 0 );
                        }
                        else
                        {
                            color = ( 1, 0, 0 );
                        }
                    }
                    else
                    {
                        color = ( 0, 0, 1 );
                    }
                    
                    /#
                        level thread debug_draw_sphere( corpse_to_remove.origin, 32, 10, color );
                    #/
                }
                
                if ( b_within_fov && b_delete_fx )
                {
                    if ( corpse_to_remove.team == level.players[ 0 ].team )
                    {
                        playfx( var_50e41ead1858f772, corpse_to_remove.origin );
                    }
                    else
                    {
                        playfx( var_dbe23f4abfd54b1a, corpse_to_remove.origin );
                    }
                    
                    waitframe();
                }
                
                if ( isdefined( corpse_to_remove ) )
                {
                    corpse_to_remove delete();
                    var_ab73f7134f0b8e1c++;
                }
            }
        }
        
        waitframe();
    }
    
    return var_ab73f7134f0b8e1c;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x19f60646, Offset: 0x9ae6
    // Size: 0x5, Type: dev
    function function_17b823f23d4249e3()
    {
        
    }

#/

// Namespace gemini_util
// Params 6
// Checksum 0xcb9273e2, Offset: 0x9af3
// Size: 0x180
function function_b95c324c7b2d9f63( origin, radius, staggered_delay = 0.05, var_d8d89c6a1e17cfff, shouldstun = 0, stun_duration = 5 )
{
    if ( !isvector( origin ) )
    {
        return 0;
    }
    
    ai_in_radius = getaiarrayinradius( origin, radius, [ "team_hundred_ninety", "team_two_hundred" ] );
    
    if ( isarray( var_d8d89c6a1e17cfff ) )
    {
        foreach ( agent in var_d8d89c6a1e17cfff )
        {
            if ( isai( agent ) )
            {
                ai_in_radius = arraycombineunique( ai_in_radius, [ agent ] );
            }
        }
    }
    
    if ( ai_in_radius.size > 0 )
    {
        ai_in_radius = sortbydistance( ai_in_radius, origin );
        
        for ( i = 0; i < ai_in_radius.size ; i++ )
        {
            if ( isdefined( ai_in_radius[ i ] ) )
            {
                agent = ai_in_radius[ i ];
                
                if ( shouldstun )
                {
                    agent zombie_stun::stun_ai( stun_duration + randomfloatrange( 0.5, 1.5 ) );
                }
                else
                {
                    agent namespace_b76ff2659823e89d::function_61b75f09c6601780();
                    agent kill();
                }
                
                wait staggered_delay;
            }
        }
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xde5e5c6, Offset: 0x9c7b
// Size: 0x74
function function_202b14bcd4140292( b_brainrot = 1, b_slow = 0 )
{
    self endon( #"death" );
    a_players = utility::get_alive_players();
    
    if ( b_brainrot )
    {
        if ( a_players.size > 0 )
        {
            if ( b_slow )
            {
                thread function_993b1192fd926235( a_players[ 0 ] );
            }
            else
            {
                zombie_utils::function_c2cee1190760989c();
            }
        }
        
        return;
    }
    
    thread function_1640ddf216db95ab();
}

// Namespace gemini_util
// Params 1
// Checksum 0x1736c6ef, Offset: 0x9cf7
// Size: 0xa6
function function_52f0905d3e087555( b_bound = 1 )
{
    self endon( #"death" );
    
    if ( b_bound )
    {
        ai::set_ai_max_health( int( self.maxhealth * 2 ) );
        self.health = self.maxhealth;
        utility::function_32b24db3127bff40( "bound", "bound_on" );
        return;
    }
    
    var_fb2f98f9e8f799fa = self.health;
    
    if ( var_fb2f98f9e8f799fa < self.max_health )
    {
        self.health = var_fb2f98f9e8f799fa;
    }
    
    utility::function_32b24db3127bff40( "bound", "bound_off" );
}

// Namespace gemini_util
// Params 1
// Checksum 0x9080e78b, Offset: 0x9da5
// Size: 0xad
function function_993b1192fd926235( attacker )
{
    if ( zombie_utils::function_dd3887f0e9e7ff79() )
    {
        return;
    }
    
    utility::ent_flag_set( "turned" );
    params = spawnstruct();
    params.attacker = attacker;
    utility::function_32b24db3127bff40( "base", "base_off" );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    self.health = self.maxhealth;
    self.allowpain = 0;
    
    if ( isdefined( attacker ) && isdefined( attacker.team ) )
    {
        self.team = attacker.team;
    }
    
    self clearpath();
}

// Namespace gemini_util
// Params 0
// Checksum 0x9d58c6a6, Offset: 0x9e5a
// Size: 0x62
function function_1640ddf216db95ab()
{
    if ( !zombie_utils::function_dd3887f0e9e7ff79() )
    {
        return;
    }
    
    utility::ent_flag_clear( "turned" );
    params = spawnstruct();
    callback::callback( "on_brainrot_end", params );
    self.health = self.maxhealth;
    self.allowpain = 1;
    self.team = "neutral";
}

// Namespace gemini_util
// Params 2
// Checksum 0xfa7b394a, Offset: 0x9ec4
// Size: 0x53
function function_54a189c04c75a149( b_aware = 1, n_radius = 1024 )
{
    self endon( #"death" );
    
    if ( b_aware )
    {
        thread function_d2e963e3d9fd1a0e( n_radius );
        return;
    }
    
    self notify( #"hash_b46e22e1b2e1a04b" );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xc68714b1, Offset: 0x9f1f
// Size: 0x3d
function private function_d2e963e3d9fd1a0e( n_radius )
{
    self endon( #"death", #"hash_b46e22e1b2e1a04b" );
    
    while ( true )
    {
        self function_fa32376aaa88a7a2( self.origin, n_radius );
        wait 1;
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xed8bfa2a, Offset: 0x9f64
// Size: 0x78
function ai_zombie_headless()
{
    self notify( #"on_dismembered" );
    utility::function_7c10ea82c1e305b8( "gib_head", "gibbed_alive" );
    utility::function_7c10ea82c1e305b8( "base", "base_off" );
    utility::function_7c10ea82c1e305b8( "ambient", "off" );
    self._blackboard.var_5692974bb0dd3579 = 0;
    
    if ( !asm_bb::bb_movetyperequested( "walk" ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "walk", "zombie_base_headless", 28 );
    }
}

// Namespace gemini_util
// Params 4
// Checksum 0x382c4c88, Offset: 0x9fe4
// Size: 0x65
function function_e22d837e46a7216e( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent utility::function_7c10ea82c1e305b8( "gib_leg_right", "gibbed" );
    agent utility::function_7c10ea82c1e305b8( "gib_leg_left", "gibbed" );
    agent namespace_b76ff2659823e89d::function_7c84cd973f7925ea( 1 );
}

// Namespace gemini_util
// Params 4
// Checksum 0xd63a1b63, Offset: 0xa051
// Size: 0x60
function function_f5811231f7438b8d( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent function_54a189c04c75a149( 1 );
    
    if ( isplayer( data ) )
    {
        player_target = data;
        agent zombie_utils::set_ai_target_priority( player_target );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xf7b8502e, Offset: 0xa0b9
// Size: 0x7d
function function_75a1d247c9b08952( host_data_params )
{
    if ( self.subclass != "zombie_base" )
    {
        return;
    }
    
    if ( isdefined( host_data_params ) )
    {
        namespace_659599414270bd0a::register_emergence_spawning_host_data( "script_evolution", host_data_params );
    }
    
    self._blackboard.var_30ab8ffc06e38f0a = 1;
    self._blackboard.var_a7ac06c0829177ee = 1;
    namespace_659599414270bd0a::enable_emergence_spawning( 1 );
    namespace_659599414270bd0a::set_emergence_spawning_through_death_percentage( 100 );
    namespace_659599414270bd0a::force_emergence_spawning( 1, undefined, 1 );
}

// Namespace gemini_util
// Params 0
// Checksum 0xcaef69b1, Offset: 0xa13e
// Size: 0x28
function function_c8cbee5fb3b870c3()
{
    if ( issubstr( self.subclass, "zombie_vermin" ) )
    {
        return;
    }
    
    if ( namespace_659599414270bd0a::function_7922b2bb1359d329() )
    {
        namespace_659599414270bd0a::disable_emergence_spawning_on_death();
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x96b20661, Offset: 0xa16e
// Size: 0x64
function private function_5b477c1abb5d672f( subclass )
{
    if ( issubstr( subclass, "zombie_vermin" ) )
    {
        time = 4;
    }
    else if ( issubstr( subclass, "zombie_parasite" ) )
    {
        time = 10;
    }
    else if ( issubstr( subclass, "zombie_ghoul" ) )
    {
        time = 35;
    }
    else
    {
        time = 0;
    }
    
    return int( utility::function_4b74c15943231980( time ) );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x48c36d3b, Offset: 0xa1db
// Size: 0x92
function private function_203afe23edb9d304()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "transform", "transform_tell" );
    wait 3;
    namespace_659599414270bd0a::enable_emergence_spawning( 1 );
    namespace_659599414270bd0a::force_emergence_spawning( 1 );
    self._blackboard.var_5f2c4e295aea3c41 = 1;
    
    if ( self._blackboard.var_397bfb4ed7256a7a )
    {
        self._blackboard.var_89af3e0b1e21175 = 1;
    }
    
    self.var_a13bed1ac47e1b2c = 1;
    self.noragdoll = 1;
    self kill();
}

// Namespace gemini_util
// Params 2
// Checksum 0x69af3a5c, Offset: 0xa275
// Size: 0xbd
function function_a9376b156b863dd4( trig_targetname, flag_endon )
{
    if ( isdefined( flag_endon ) )
    {
        if ( level utility::flag( flag_endon ) )
        {
            return;
        }
    }
    
    a_trig_noent = getnoentvolumearray( trig_targetname, #targetname );
    
    if ( a_trig_noent.size == 0 )
    {
        return;
    }
    
    foreach ( trig in a_trig_noent )
    {
        thread function_35357ee1c28da6f9( trig, flag_endon );
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x8181dbc5, Offset: 0xa33a
// Size: 0x199
function private function_35357ee1c28da6f9( trig, flag_endon )
{
    level endon( #"game_ended", flag_endon );
    
    if ( isdefined( flag_endon ) )
    {
        level endon( flag_endon );
    }
    
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        trig waittill( #"trigger", data );
        
        if ( isagent( data ) && data.type == "zombie" )
        {
            break;
        }
    }
    
    a_vent_ent = getscriptablearray( trig.target, #targetname );
    var_abb5932782e5da66 = getentitylessscriptablearray( trig.target, #targetname );
    a_vent = arraycombine( a_vent_ent, var_abb5932782e5da66 );
    
    if ( a_vent.size == 0 )
    {
        return;
    }
    
    if ( isdefined( a_vent[ 0 ].script_index ) )
    {
        a_vent = utility::array_sort_by_script_index( a_vent );
    }
    else
    {
        a_vent = arrayrandomize( a_vent );
    }
    
    for ( i = 0; i < a_vent.size ; i++ )
    {
        if ( isdefined( a_vent[ i ] ) )
        {
            a_vent[ i ] setscriptablepartstate( "base", #"hash_f713291b93f03127" );
            earthquake( 0.1, 0.1, a_vent[ i ].origin, 512 );
            playrumbleonposition( "damage_light", a_vent[ i ].origin );
            wait randomfloatrange( 0.5, 1.5 );
        }
    }
}

// Namespace gemini_util
// Params 4
// Checksum 0x53bf69ec, Offset: 0xa4db
// Size: 0x70
function function_938edcc75e2bb90f( idamage, eattacker, objweapon, smeansofdeath )
{
    if ( isdefined( eattacker.ranged_grenade_damage ) && isdefined( eattacker.grenadeweapon ) && objweapon == eattacker.grenadeweapon )
    {
        idamage = int( eattacker.ranged_grenade_damage * 0.1 );
    }
    
    return idamage;
}

// Namespace gemini_util
// Params 1
// Checksum 0xc75f0c84, Offset: 0xa554
// Size: 0x7d
function function_677a023b1546ec8( player )
{
    if ( zombie_utils::function_dd3887f0e9e7ff79() )
    {
        return;
    }
    
    utility::ent_flag_set( "turned" );
    self.health = self.maxhealth;
    self.allowpain = 0;
    
    if ( isdefined( player ) && isdefined( player.team ) )
    {
        self.team = player.team;
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x2ea>" );
        #/
    }
    
    self clearpath();
}

// Namespace gemini_util
// Params 0
// Checksum 0xd0bd361a, Offset: 0xa5d9
// Size: 0x41
function function_6bcecbb730bbec68()
{
    utility::ent_flag_wait( "stealth_enabled" );
    wait 1;
    self.var_2f17175b25d497ef = function_45725eed211aafdf();
    
    if ( isdefined( self.var_2f17175b25d497ef ) )
    {
        utility::function_a5691d86c41d07b6( &function_6907628b3e8e5965, "all" );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x16c1cca5, Offset: 0xa622
// Size: 0xbe
function function_45725eed211aafdf( v_origin )
{
    if ( isdefined( v_origin ) )
    {
        origin = v_origin;
    }
    else
    {
        origin = self.origin;
    }
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        foreach ( trig in level.var_5a646ea8e8b153df )
        {
            if ( ispointinvolume( origin, trig ) )
            {
                return trig;
            }
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x3253faa0, Offset: 0xa6e9
// Size: 0xe5
function function_bad3d752e10eebc( v_origin )
{
    if ( isdefined( v_origin ) )
    {
        origin = v_origin;
    }
    else
    {
        origin = self.origin;
    }
    
    player_count = 0;
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = function_45725eed211aafdf( origin );
        
        if ( isdefined( var_2f17175b25d497ef ) )
        {
            foreach ( player in level.players )
            {
                if ( ispointinvolume( player.origin, var_2f17175b25d497ef ) )
                {
                    player_count++;
                }
            }
        }
    }
    
    return player_count;
}

// Namespace gemini_util
// Params 1
// Checksum 0x6ced388a, Offset: 0xa7d7
// Size: 0x58, Type: bool
function function_6907628b3e8e5965( event )
{
    if ( !isdefined( self.var_2f17175b25d497ef ) )
    {
        return false;
    }
    
    if ( !ispointinvolume( self.origin, self.var_2f17175b25d497ef ) )
    {
        return false;
    }
    
    if ( !ispointinvolume( event.origin, self.var_2f17175b25d497ef ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gemini_util
// Params 4
// Checksum 0x98adc42b, Offset: 0xa838
// Size: 0x1b9
function function_a8d4d78033f6456d( requestid, forward_pos, var_68b32a8bafee7061, distance_buffer = 512 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        if ( utility::flag( var_68b32a8bafee7061 ) )
        {
            return;
        }
        
        level endon( var_68b32a8bafee7061 );
    }
    
    while ( true )
    {
        if ( !isvector( forward_pos ) )
        {
            return;
        }
        
        var_22b65f6dbdf06919 = utility::function_4325398d215ecda5( forward_pos, level.players );
        
        if ( !isdefined( var_22b65f6dbdf06919 ) )
        {
            return;
        }
        
        function_b417a9d813542c31( requestid, [ var_22b65f6dbdf06919 ] );
        var_1f30ece26f79f525 = distance2d( forward_pos, var_22b65f6dbdf06919.origin ) + distance_buffer;
        data = function_9b649316adcccbaa( requestid );
        
        foreach ( ai in data.ai )
        {
            if ( isdefined( ai ) )
            {
                players = getplayersinradius( ai.origin, 512 );
                
                if ( players.size > 0 )
                {
                    waitframe();
                    continue;
                }
                
                var_778463950afa2a8e = distance2d( forward_pos, ai.origin );
                
                if ( var_778463950afa2a8e > var_1f30ece26f79f525 )
                {
                    ai ai_zombie_despawn();
                    wait randomfloatrange( 0.5, 1.5 );
                }
            }
            
            waitframe();
        }
        
        wait 2;
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xb99af6b, Offset: 0xa9f9
// Size: 0x58
function ai_zombie_despawn( b_forcekill = 1 )
{
    despawn_success = zombie_utils::try_despawn_zombie();
    
    if ( isdefined( self ) && b_forcekill && !despawn_success )
    {
        self.dontdroploot = 1;
        self.var_a13bed1ac47e1b2c = 1;
        ai::function_dd7b3233e5b07718( 1 );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x1a6e86c1, Offset: 0xaa59
// Size: 0x17a
function function_6fd9eb6c8ad80bbc( params )
{
    if ( isdefined( params.objweapon ) && isplayer( params.eattacker ) )
    {
        if ( params.objweapon.basename == "sat_me_knife_mp" )
        {
            if ( params.biscritical )
            {
                var_1972ec364a0cf63a = self.maxhealth * 0.6;
            }
            else
            {
                var_1972ec364a0cf63a = self.maxhealth * 0.3;
            }
            
            if ( !math::within_fov_2d( self.origin, self.angles, params.eattacker.origin, cos( 95 ) ) )
            {
                var_1972ec364a0cf63a *= 3;
            }
            
            return int( var_1972ec364a0cf63a );
        }
        else if ( params.objweapon.basename == "sat_combataxe_ob" )
        {
            if ( params.biscritical )
            {
                var_baa380a3657e4139 = self.maxhealth * 1.5;
            }
            else
            {
                var_baa380a3657e4139 = self.maxhealth * 0.8;
            }
            
            if ( !math::within_fov_2d( self.origin, self.angles, params.eattacker.origin, cos( 95 ) ) )
            {
                var_baa380a3657e4139 *= 2;
            }
            
            return int( var_baa380a3657e4139 );
        }
    }
    
    return params.idamage;
}

// Namespace gemini_util
// Params 4
// Checksum 0x6447913d, Offset: 0xabdc
// Size: 0x1b9
function function_f53463c3213de6a1( source_targetname, var_f8e7dcf370abd35a, ai_count_high, ai_count_low )
{
    self notify( #"hash_42d27bf3a9e26800" );
    self endon( #"hash_42d27bf3a9e26800" );
    self endon( #"death", #"hash_755d26458a238372" );
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    var_e3a01336ae2f9dfd = undefined;
    
    if ( isdefined( source_targetname ) )
    {
        var_e3a01336ae2f9dfd = utility::getstruct( source_targetname, "targetname" );
    }
    
    n_chance = randomint( 26 );
    count_all_ai = getaicount();
    
    if ( count_all_ai > ai_count_high )
    {
        n_chance += 25;
    }
    else if ( count_all_ai < ai_count_low )
    {
        n_chance -= 25;
    }
    
    if ( isdefined( var_f8e7dcf370abd35a ) && utility::flag( var_f8e7dcf370abd35a ) )
    {
        n_chance += 25;
    }
    
    if ( isdefined( self.enemy ) && self.enemy.directorspawndata.script_noteworthy == "juggernaut" )
    {
        n_chance += 25;
    }
    else
    {
        var_f912c3050ae9e947 = function_d4451e723cacc364( cos( 45 ), 0, 0, 1, 512, 1024 );
        
        if ( var_f912c3050ae9e947 )
        {
            n_chance -= 25;
        }
    }
    
    if ( n_chance > 50 )
    {
        if ( isdefined( var_e3a01336ae2f9dfd ) )
        {
            magicbullet( "sat_ar_eagle_mp", self geteye() + anglestoforward( vectortoangles( self geteye() - var_e3a01336ae2f9dfd.origin + ( 0, 0, 512 ) ) * 100 ), self geteye() );
            return;
        }
        
        magicbullet( "sat_ar_eagle_mp", self geteye() + anglestoforward( self.angles ) * 100, self geteye() );
    }
}

// Namespace gemini_util
// Params 4
// Checksum 0x99c82990, Offset: 0xad9d
// Size: 0x100
function function_b8a6e5d594fbfcc3( struct_targetname, flag_attractor, flag_endon, b_delete_out_of_sight = 0 )
{
    level endon( #"game_ended" );
    s_attractor = utility::getstruct( struct_targetname, "targetname" );
    
    if ( !isdefined( s_attractor ) )
    {
        return;
    }
    
    n_radius = 512;
    
    if ( isdefined( s_attractor.radius ) )
    {
        n_radius = s_attractor.radius;
    }
    
    if ( isdefined( flag_attractor ) )
    {
        utility::flag_wait( flag_attractor );
    }
    
    attractor = zombie_attractor_manager::add_attractor( s_attractor, 0, 6000, 0, undefined, &function_d6d3cf48c4c17f4d, 0, "team_hundred_ninety" );
    function_331b0b435327b77e( attractor, s_attractor.origin, n_radius );
    
    if ( b_delete_out_of_sight )
    {
        thread function_aa737f46d1bac4bd( attractor, s_attractor );
    }
    
    function_72e7e4ec443bd555( s_attractor, flag_endon, n_radius );
    s_attractor utility::ent_flag_set( "flag_remove_noncombat_attractor" );
    zombie_attractor_manager::remove_attractor( attractor );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xceac6e51, Offset: 0xaea5
// Size: 0x3d, Type: bool
function private function_d6d3cf48c4c17f4d( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x4d92599c, Offset: 0xaeeb
// Size: 0x74
function private function_72e7e4ec443bd555( s_attractor, flag_endon, n_radius )
{
    level endon( flag_endon );
    n_radius_check = n_radius * 2;
    
    while ( !utility::flag( flag_endon ) )
    {
        var_6f5c0bece5deb66e = getaiarrayinradius( s_attractor.origin, n_radius_check, "team_hundred_ninety" );
        
        if ( var_6f5c0bece5deb66e.size > 0 )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 4, eflags: 0x4
// Checksum 0x1f3a59ba, Offset: 0xaf67
// Size: 0xc1
function private function_331b0b435327b77e( attractor, origin, radius, var_50d7d36595e1100c = 20 )
{
    level endon( #"game_ended" );
    a_slots = [];
    a_nav_points = getrandomnavpoints( origin, radius, var_50d7d36595e1100c );
    
    for ( i = 0; i < a_nav_points.size ; i++ )
    {
        pos = a_nav_points[ i ];
        var_75319c5420c61a27 = getclosestpointonnavmesh( a_nav_points[ i ] );
        slot = spawnstruct();
        slot.origin = var_75319c5420c61a27;
        a_slots[ a_slots.size ] = slot;
    }
    
    zombie_attractor_manager::set_attractor_slots( attractor, a_slots );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xbb9ee0f6, Offset: 0xb030
// Size: 0x19c
function private function_aa737f46d1bac4bd( attractor, s_attractor )
{
    level endon( #"game_ended" );
    a_zombie_delete = [];
    
    while ( !utility::ent_flag( "flag_remove_noncombat_attractor" ) )
    {
        var_255232a5c5895cf6 = getaispeciesarray( "all", "zombie" );
        
        if ( isdefined( var_255232a5c5895cf6 ) && var_255232a5c5895cf6.size > 0 )
        {
            foreach ( zombie in var_255232a5c5895cf6 )
            {
                if ( isalive( zombie ) && !arraycontains( a_zombie_delete, zombie ) )
                {
                    if ( zombie.target_attractor == attractor )
                    {
                        a_zombie_delete = arraycombineunique( a_zombie_delete, [ zombie ] );
                        zombie thread ai_delete_when_out_of_sight( 512, 1024 );
                    }
                }
                
                waitframe();
            }
        }
        
        wait 1;
    }
    
    waitframe();
    
    if ( a_zombie_delete.size > 0 )
    {
        foreach ( zombie in a_zombie_delete )
        {
            if ( isalive( zombie ) )
            {
                zombie notify( #"hash_fc42fb143ecc3617" );
            }
            
            waitframe();
        }
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xe3efa34a, Offset: 0xb1d4
    // Size: 0x5, Type: dev
    function function_871f8c9e25b9a076()
    {
        
    }

#/

// Namespace gemini_util
// Params 4
// Checksum 0xde9051fb, Offset: 0xb1e1
// Size: 0x11c
function function_4408fb951c105cb4( trigger_targetname, var_4cc0d6c492112ce5, var_68b32a8bafee7061, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        if ( level utility::flag( var_68b32a8bafee7061 ) )
        {
            return;
        }
        
        level endon( var_68b32a8bafee7061 );
    }
    
    a_trig_ent = getentarray( trigger_targetname, #targetname );
    a_trig_noent = getnoentvolumearray( trigger_targetname, #targetname );
    var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        assertmsg( "<dev string:x31e>" + trigger_targetname );
        return;
    }
    
    var_f8178163be04ed2 = spawnstruct();
    var_f8178163be04ed2.var_66983e9b7f1e4f98 = var_66983e9b7f1e4f98;
    
    if ( isdefined( var_68b32a8bafee7061 ) )
    {
        var_f8178163be04ed2.var_68b32a8bafee7061 = var_68b32a8bafee7061;
    }
    
    thread utility::array_thread( var_5cba3aa7cba1a93c, &function_86f26ea0ba29b10, var_f8178163be04ed2 );
    var_f8178163be04ed2 waittill( #"player_trigger", player );
    
    if ( isdefined( var_4cc0d6c492112ce5 ) )
    {
        level utility::flag_set( var_4cc0d6c492112ce5 );
    }
    
    return player;
}

// Namespace gemini_util
// Params 1
// Checksum 0x2d3514f6, Offset: 0xb306
// Size: 0xaf
function function_86f26ea0ba29b10( var_f8178163be04ed2 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_f8178163be04ed2.var_68b32a8bafee7061 ) )
    {
        if ( level utility::flag( var_f8178163be04ed2.var_68b32a8bafee7061 ) )
        {
            return;
        }
        
        level endon( var_f8178163be04ed2.var_68b32a8bafee7061 );
    }
    
    while ( true )
    {
        self waittill( #"trigger", data );
        
        if ( var_f8178163be04ed2.var_66983e9b7f1e4f98 )
        {
            if ( isplayer( data ) && !isbot( data ) )
            {
                break;
            }
            
            continue;
        }
        
        if ( isplayer( data ) )
        {
            break;
        }
    }
    
    var_f8178163be04ed2 notify( #"player_trigger", data );
}

// Namespace gemini_util
// Params 4
// Checksum 0xb01de501, Offset: 0xb3bd
// Size: 0x11a
function function_c9ef16e04fc11b50( trigger_targetname, var_4cc0d6c492112ce5, n_timeout = 10, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended" );
    a_trig_ent = getentarray( trigger_targetname, #targetname );
    a_trig_noent = getnoentvolumearray( trigger_targetname, #targetname );
    var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        assertmsg( "<dev string:x31e>" + trigger_targetname );
        return;
    }
    
    var_f8178163be04ed2 = spawnstruct();
    var_f8178163be04ed2.var_66983e9b7f1e4f98 = var_66983e9b7f1e4f98;
    var_f8178163be04ed2.a_players = [];
    thread utility::array_thread( var_5cba3aa7cba1a93c, &function_86f26ea0ba29b10, var_f8178163be04ed2 );
    thread function_b589dfb78a3e00a3( var_f8178163be04ed2, n_timeout );
    var_8049135caf426c1d = function_1e99baeb42611a06( var_f8178163be04ed2 );
    var_f8178163be04ed2 notify( #"hash_96038e5b7938b4de" );
    
    if ( isdefined( var_4cc0d6c492112ce5 ) )
    {
        level utility::flag_set( var_4cc0d6c492112ce5 );
    }
    
    return var_8049135caf426c1d;
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x6fc976a, Offset: 0xb4e0
// Size: 0x137, Type: bool
function private function_1e99baeb42611a06( var_f8178163be04ed2 )
{
    level endon( #"game_ended" );
    var_f8178163be04ed2 endon( #"hash_96038e5b7938b4de" );
    var_f43eb6e734c44585 = level.players;
    
    if ( var_f8178163be04ed2.var_66983e9b7f1e4f98 )
    {
        foreach ( player in var_f43eb6e734c44585 )
        {
            if ( isbot( player ) )
            {
                var_f43eb6e734c44585 = arrayremove( var_f43eb6e734c44585, player );
            }
        }
    }
    
    while ( true )
    {
        var_f8178163be04ed2 waittill( #"player_trigger", player );
        
        if ( !arraycontains( var_f8178163be04ed2.a_players, player ) )
        {
            var_f8178163be04ed2.a_players = arraycombineunique( var_f8178163be04ed2.a_players, [ player ] );
        }
        
        if ( var_f8178163be04ed2.a_players.size >= var_f43eb6e734c44585.size )
        {
            break;
        }
        
        waitframe();
    }
    
    return var_f8178163be04ed2.a_players.size >= var_f43eb6e734c44585.size;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xc21f9c43, Offset: 0xb620
// Size: 0x5e
function private function_b589dfb78a3e00a3( var_f8178163be04ed2, n_timeout )
{
    level endon( #"game_ended" );
    var_f8178163be04ed2 endon( #"hash_96038e5b7938b4de" );
    var_f8178163be04ed2 waittill( #"player_trigger", player );
    wait utility::function_4b74c15943231980( n_timeout );
    var_f8178163be04ed2 notify( #"hash_96038e5b7938b4de" );
}

// Namespace gemini_util
// Params 5
// Checksum 0xba41ac36, Offset: 0xb686
// Size: 0x1c0
function function_9509e2570ae46265( trigger_targetname, var_4cc0d6c492112ce5, flag_endon, n_timeout = 10, var_66983e9b7f1e4f98 = 1 )
{
    level endon( #"game_ended" );
    a_trig_ent = getentarray( trigger_targetname, #targetname );
    a_trig_noent = getnoentvolumearray( trigger_targetname, #targetname );
    var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
    
    if ( var_5cba3aa7cba1a93c.size == 0 )
    {
        assertmsg( "<dev string:x31e>" + trigger_targetname );
        return;
    }
    
    if ( var_5cba3aa7cba1a93c.size > 1 )
    {
        assertmsg( "<dev string:x341>" + trigger_targetname );
        return;
    }
    
    trig = var_5cba3aa7cba1a93c[ 0 ];
    var_f8178163be04ed2 = spawnstruct();
    var_f8178163be04ed2.a_players = [];
    var_f43eb6e734c44585 = level.players;
    
    if ( var_66983e9b7f1e4f98 )
    {
        foreach ( player in var_f43eb6e734c44585 )
        {
            if ( isbot( player ) )
            {
                var_f43eb6e734c44585 = arrayremove( var_f43eb6e734c44585, player );
            }
        }
    }
    
    trig thread function_78d324e7c1a9e7d( var_f8178163be04ed2, var_f43eb6e734c44585 );
    var_8049135caf426c1d = function_65e2b4659eb7e39d( var_f8178163be04ed2, var_f43eb6e734c44585, n_timeout );
    var_f8178163be04ed2 notify( #"hash_29512dea4e516697" );
    
    if ( isdefined( var_4cc0d6c492112ce5 ) )
    {
        level utility::flag_set( var_4cc0d6c492112ce5 );
    }
    
    return var_8049135caf426c1d;
}

// Namespace gemini_util
// Params 2
// Checksum 0xed42843d, Offset: 0xb84f
// Size: 0x15a
function function_c00e724156609769( trigger, var_66983e9b7f1e4f98 )
{
    level endon( #"game_ended" );
    a_players_inside = [];
    
    if ( isstring( trigger ) )
    {
        a_trig_ent = getentarray( trigger, #targetname );
        a_trig_noent = getnoentvolumearray( trigger, #targetname );
        var_5cba3aa7cba1a93c = arraycombine( a_trig_ent, a_trig_noent );
        
        if ( var_5cba3aa7cba1a93c.size == 0 )
        {
            assertmsg( "<dev string:x31e>" + trigger );
            return a_players_inside;
        }
        else if ( var_5cba3aa7cba1a93c.size > 1 )
        {
            assertmsg( "<dev string:x341>" + trigger );
            return a_players_inside;
        }
        
        trig = var_5cba3aa7cba1a93c[ 0 ];
    }
    else
    {
        trig = trigger;
    }
    
    a_players = ob_story_mission_utils::get_playing_players();
    
    foreach ( player in a_players )
    {
        if ( player istouching( trig ) )
        {
            a_players_inside = arraycombineunique( a_players_inside, [ player ] );
        }
    }
    
    return a_players_inside;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x3f2159d0, Offset: 0xb9b2
// Size: 0x115
function private function_78d324e7c1a9e7d( var_f8178163be04ed2, var_f43eb6e734c44585 )
{
    level endon( #"game_ended" );
    var_f8178163be04ed2 endon( #"hash_29512dea4e516697" );
    
    while ( true )
    {
        foreach ( player in var_f43eb6e734c44585 )
        {
            if ( player istouching( self ) )
            {
                if ( !arraycontains( var_f8178163be04ed2.a_players, player ) )
                {
                    var_f8178163be04ed2.a_players = arraycombineunique( var_f8178163be04ed2.a_players, [ player ] );
                }
                
                continue;
            }
            
            if ( arraycontains( var_f8178163be04ed2.a_players, player ) )
            {
                var_f8178163be04ed2.a_players = arrayremove( var_f8178163be04ed2.a_players, player );
            }
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x6b0e3ad2, Offset: 0xbacf
// Size: 0xc7, Type: bool
function private function_65e2b4659eb7e39d( var_f8178163be04ed2, var_f43eb6e734c44585, n_timeout )
{
    level endon( #"game_ended" );
    var_f8178163be04ed2 endon( #"hash_29512dea4e516697" );
    var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( n_timeout );
    
    while ( true )
    {
        if ( var_f8178163be04ed2.a_players.size == 0 )
        {
            var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( n_timeout );
            waitframe();
            continue;
        }
        
        if ( var_f8178163be04ed2.a_players.size == var_f43eb6e734c44585.size || n_timeout > 0 && gettime() >= var_dd40cf6520d59892 )
        {
            if ( var_f8178163be04ed2.a_players.size > 0 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    return var_f8178163be04ed2.a_players.size == var_f43eb6e734c44585.size;
}

// Namespace gemini_util
// Params 2
// Checksum 0xfc0b3833, Offset: 0xbb9f
// Size: 0xa3, Type: bool
function function_e28ab256acac0688( var_5cba3aa7cba1a93c, var_e841d6518c4f7916 = 1 )
{
    foreach ( trig in var_5cba3aa7cba1a93c )
    {
        var_e318a553d1d911e0 = trig function_73bd7925ab7e8a36( var_e841d6518c4f7916 );
        
        if ( var_e318a553d1d911e0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gemini_util
// Params 1
// Checksum 0xdca56916, Offset: 0xbc4b
// Size: 0xaf, Type: bool
function function_73bd7925ab7e8a36( var_e841d6518c4f7916 = 1 )
{
    if ( var_e841d6518c4f7916 )
    {
        a_players = ob_story_mission_utils::get_playing_players();
    }
    else
    {
        a_players = level.players;
    }
    
    foreach ( player in a_players )
    {
        if ( player istouching( self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gemini_util
// Params 2
// Checksum 0x55f317f1, Offset: 0xbd03
// Size: 0xa4, Type: bool
function function_639cb13b89345618( a_players, trig_ent_flag )
{
    count = 0;
    
    foreach ( player in a_players )
    {
        if ( player utility::ent_flag( trig_ent_flag ) )
        {
            count++;
        }
    }
    
    if ( count < a_players.size )
    {
        return false;
    }
    
    return true;
}

// Namespace gemini_util
// Params 2
// Checksum 0xdf0e4f3f, Offset: 0xbdb0
// Size: 0x62
function function_57180a47f178d6d6( trigger_name, trigger_ent_flag )
{
    player = self;
    trigger = getnoentvolumearray( trigger_name, #targetname )[ 0 ];
    
    if ( trigger )
    {
        while ( true )
        {
            if ( player istouching( trigger ) )
            {
                break;
            }
            
            waitframe();
        }
        
        player utility::ent_flag_set( trigger_ent_flag );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x2a0519b3, Offset: 0xbe1a
// Size: 0x7e
function trigger_stealth_shadow_setup()
{
    if ( !isdefined( level.trigger_stealth_shadow ) )
    {
        level.trigger_stealth_shadow = [];
    }
    
    level.trigger_stealth_shadow = getentarray( "trig_tunnels_prison_stealth_shadow", #targetname );
    
    if ( level.trigger_stealth_shadow.size > 0 )
    {
        thread utility::array_thread( level.trigger_stealth_shadow, &_trigger_stealth_shadow_handler );
    }
    
    level utility::flag_wait( "flag_tunnels_anteroom_doors_locked" );
    utility::array_delete( level.trigger_stealth_shadow );
    level.trigger_stealth_shadow = undefined;
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x5764d1c1, Offset: 0xbea0
// Size: 0x70
function private _trigger_stealth_shadow_handler()
{
    self endon( #"death" );
    registerstealthshadowtrigger( self );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player utility::ent_flag_exist( "stealth_in_shadow" ) && player utility::ent_flag( "stealth_in_shadow" ) )
        {
            continue;
        }
        
        player thread function_6db05cb6dddb3d62( self );
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x146dc4a6, Offset: 0xbf18
// Size: 0x59
function private function_6db05cb6dddb3d62( trigger )
{
    self endon( #"death" );
    player::setplayervisibilityflag( "stealth_in_shadow" );
    setplayerobscured( self, 1 );
    
    while ( isdefined( trigger ) && self istouching( trigger ) )
    {
        wait 0.1;
    }
    
    player::function_dc59df84a8dcb0e0( "stealth_in_shadow" );
    setplayerobscured( self, 0 );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x29be33c8, Offset: 0xbf79
    // Size: 0x5, Type: dev
    function function_da056ed98444d295()
    {
        
    }

#/

// Namespace gemini_util
// Params 3
// Checksum 0x86d11450, Offset: 0xbf86
// Size: 0xc7
function function_1ff93f2b1149dd76( origin, radius = 512, var_af9066e32cc4e172 = 1 )
{
    a_players = ob_story_mission_utils::get_playing_players();
    
    if ( isdefined( origin ) )
    {
        if ( !isdefined( radius ) || radius <= 0 )
        {
            a_players = sortbydistance( a_players, origin );
        }
        else
        {
            a_players = sortbydistancecullbyradius( a_players, origin, radius );
        }
    }
    
    if ( a_players.size > 0 )
    {
        if ( var_af9066e32cc4e172 )
        {
            a_players = arrayrandomize( a_players );
        }
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            if ( !isbot( a_players[ i ] ) && a_players[ i ].sessionstate == "playing" )
            {
                return a_players[ i ];
            }
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x9e03da91, Offset: 0xc056
// Size: 0x60
function function_22bc129d80ed2fc7( n_weapon_rarity )
{
    self notify( #"hash_b8c601214387d42" );
    self endon( #"hash_b8c601214387d42" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"pickedupweapon" );
        function_5f0c7542d0b467df( n_weapon_rarity );
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xd3fd6b39, Offset: 0xc0be
// Size: 0x99
function function_eac36da555a7ceb4()
{
    self notify( #"hash_da4d13247fe0e5c3" );
    self endon( #"hash_da4d13247fe0e5c3" );
    player = self;
    player endon( #"disconnect" );
    
    while ( true )
    {
        player utility::waittill_any( "pickedupweapon", "weapon_change" );
        
        if ( player.currentprimaryweapon.basename != "sat_me_knife_mp" )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", "hint_gemini_tertiary", &"sat_ob/hint_gemini_tertiary_knife", 10 );
            return;
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x5d4b243f, Offset: 0xc15f
// Size: 0x9d
function function_5f0c7542d0b467df( n_weapon_rarity )
{
    foreach ( weapon in self.meleeweapons )
    {
        if ( weapon.basename == "sat_me_knife_mp" )
        {
            item_weapon::function_40e1cbd0e1f47d1a( weapon, n_weapon_rarity );
            break;
        }
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xc9a076df, Offset: 0xc204
// Size: 0x69
function function_84a5d81fa8784f4f()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self forceweaponinspect();
    waitframe();
    
    while ( self function_985124b0e1e74f2e() )
    {
        if ( self usebuttonpressed() || self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            break;
        }
        
        waitframe();
    }
    
    self function_60e112d2e106b00a();
    waitframe();
    self function_7d73d6786e51ae1f();
}

// Namespace gemini_util
// Params 0
// Checksum 0xb405141c, Offset: 0xc275
// Size: 0x49
function player_get_team()
{
    players = ob_story_mission_utils::get_playing_players();
    
    if ( !isdefined( players[ 0 ] ) )
    {
        players = level.players;
    }
    
    /#
        if ( !isdefined( players[ 0 ] ) )
        {
            iprintln( "<dev string:x36f>" );
        }
    #/
    
    return players[ 0 ].team;
}

// Namespace gemini_util
// Params 0
// Checksum 0x894414eb, Offset: 0xc2c7
// Size: 0xb6, Type: bool
function function_1bb5685e6471069d()
{
    a_players = ob_story_mission_utils::get_playing_players();
    var_6f5c0bece5deb66e = getaiarray();
    
    if ( var_6f5c0bece5deb66e.size == 0 )
    {
        return false;
    }
    
    foreach ( enemy in var_6f5c0bece5deb66e )
    {
        if ( !isalive( enemy ) )
        {
            continue;
        }
        
        if ( isplayer( enemy.enemy ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gemini_util
// Params 6
// Checksum 0x1e52de14, Offset: 0xc386
// Size: 0x97
function function_b89408bec75f5c14( flag_endon, var_ff7969d4eb2f286e, sway_multiplier = 1, b_cinematic_motion = 1, shock_intensity, player_speed )
{
    thread player_camera_sway_setup( sway_multiplier, flag_endon, var_ff7969d4eb2f286e );
    
    if ( b_cinematic_motion )
    {
        player_utility::function_99d180c3f0ca93b8( self, "iw9_swimming", 2 );
    }
    
    if ( isdefined( shock_intensity ) )
    {
        thread function_4d2db5d7026cb93f( shock_intensity, flag_endon );
    }
    
    if ( isdefined( player_speed ) )
    {
        player_set_speed( player_speed );
    }
    
    self.is_disoriented = 1;
}

// Namespace gemini_util
// Params 4
// Checksum 0xcacc1f43, Offset: 0xc425
// Size: 0x184
function function_9623f1811bc192b4( intensity = "low", duration = 1, flag_endon, ent_flag_endon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( flag_endon ) && level utility::flag( flag_endon ) )
    {
        return;
    }
    
    if ( isdefined( ent_flag_endon ) && utility::ent_flag( ent_flag_endon ) )
    {
        return;
    }
    
    if ( intensity == "low" )
    {
        shakeoverride = "player_soundveil_shake_reduced_mp";
        var_1d38d06d1b0dc98 = 3;
        earthquakeintensity = 0.2;
        rumble = "artillery_rumble_light";
    }
    else if ( intensity == "vlow" )
    {
        shakeoverride = "player_soundveil_shake_reduced_mp";
        var_1d38d06d1b0dc98 = 1;
        earthquakeintensity = 0.1;
        rumble = undefined;
    }
    else
    {
        shakeoverride = "player_soundveil_shake_mp";
        var_1d38d06d1b0dc98 = 5;
        earthquakeintensity = 0.5;
        rumble = "artillery_rumble_heavy";
    }
    
    player_utility::function_99d180c3f0ca93b8( self, shakeoverride, 1 );
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 1.5, flag_endon, [ self ] );
    earthquake( earthquakeintensity, duration, self.origin, 512 );
    
    if ( isdefined( rumble ) )
    {
        playrumbleonposition( rumble, self.origin );
    }
    
    if ( isdefined( flag_endon ) )
    {
        level utility::flag_wait_or_timeout( flag_endon, duration );
    }
    else
    {
        wait duration;
    }
    
    player_utility::function_c14762bb6e0b4edb( self );
    emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
}

// Namespace gemini_util
// Params 2
// Checksum 0x3e8516ee, Offset: 0xc5b1
// Size: 0x62
function function_16357e04a0cbe73d( b_fast_disable, speed_lerp_duration = 2 )
{
    self notify( #"cancel_disorientation" );
    player_utility::function_c14762bb6e0b4edb( self );
    self notify( #"cancel_change_speed" );
    thread player_change_speed( 1, speed_lerp_duration );
    utility::ent_flag_clear( "player_camera_sway" );
    self.is_disoriented = 0;
}

// Namespace gemini_util
// Params 4
// Checksum 0x82868cb1, Offset: 0xc61b
// Size: 0x69
function player_camera_sway_setup( base_multiplier = 1, flag_endon, var_ff7969d4eb2f286e = 1, var_4114bccfd16215bf = 0 )
{
    player_camera_sway_settings( base_multiplier );
    
    if ( var_4114bccfd16215bf )
    {
        thread function_d3628e3a5e8b1088( flag_endon, var_ff7969d4eb2f286e );
        return;
    }
    
    thread player_camera_sway_thread( flag_endon, var_ff7969d4eb2f286e );
}

// Namespace gemini_util
// Params 0
// Checksum 0x9f9d55e4, Offset: 0xc68c
// Size: 0x51
function player_camera_sway_init()
{
    utility::ent_flag_set( "player_camera_sway" );
    self.var_c7b6c9bfdbf8d9fc = spawn( "script_model", self.origin );
    self.var_c7b6c9bfdbf8d9fc.angles = self getplayerangles();
    self playersetgroundreferenceent( self.var_c7b6c9bfdbf8d9fc );
}

// Namespace gemini_util
// Params 8
// Checksum 0x28f4a3c8, Offset: 0xc6e5
// Size: 0x1ce
function player_camera_sway_settings( base_multiplier = 1, base_duration = 5, duration_variance = 1, base_yaw = 2, base_pitch = 2, base_roll = 4, low_variance = 0.5, high_variance = 1 )
{
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_init();
    }
    
    if ( getdvarint( @"hash_ccecb2781660d0fc" ) == 1 )
    {
        base_duration *= 4;
        base_multiplier *= 0.25;
    }
    
    if ( base_multiplier >= 1 )
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance;
    }
    else
    {
        self.var_c7b6c9bfdbf8d9fc.base_duration = base_duration * 1 / base_multiplier;
        self.var_c7b6c9bfdbf8d9fc.duration_variance = duration_variance * 1 / base_multiplier;
    }
    
    self.var_c7b6c9bfdbf8d9fc.base_yaw = base_yaw * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_pitch = base_pitch * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.base_roll = base_roll * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.low_variance = low_variance * base_multiplier;
    self.var_c7b6c9bfdbf8d9fc.high_variance = high_variance * base_multiplier;
}

// Namespace gemini_util
// Params 0
// Checksum 0x33a4ac37, Offset: 0xc8bb
// Size: 0x26
function function_2bba09510ee8823d()
{
    if ( isdefined( self.var_550963bbb003c756 ) )
    {
        return self.var_550963bbb003c756;
    }
    
    return ( 0, 0, 0 );
}

// Namespace gemini_util
// Params 2
// Checksum 0xf6d524cd, Offset: 0xc8ea
// Size: 0x549
function player_camera_sway_thread( flag_endon, var_ff7969d4eb2f286e = 1 )
{
    self notify( #"hash_7f790220e3ad35e7" );
    self endon( #"hash_7f790220e3ad35e7" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_settings();
    }
    
    if ( var_ff7969d4eb2f286e )
    {
        self.var_c7b6c9bfdbf8d9fc.angles = function_2bba09510ee8823d();
    }
    else
    {
        self.var_c7b6c9bfdbf8d9fc.angles = ( 0, 0, 0 );
        duration = self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance;
        self.var_c7b6c9bfdbf8d9fc rotateto( function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration;
    }
    
    while ( utility::ent_flag( "player_camera_sway" ) && !level utility::flag( flag_endon ) )
    {
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_yaw );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1 - self.var_c7b6c9bfdbf8d9fc.low_variance, self.var_c7b6c9bfdbf8d9fc.base_pitch );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1 - self.var_c7b6c9bfdbf8d9fc.high_variance, self.var_c7b6c9bfdbf8d9fc.base_roll );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
        
        if ( !utility::ent_flag( "player_camera_sway" ) || level utility::flag( flag_endon ) )
        {
            break;
        }
        
        duration = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_duration - self.var_c7b6c9bfdbf8d9fc.duration_variance, self.var_c7b6c9bfdbf8d9fc.base_duration + self.var_c7b6c9bfdbf8d9fc.duration_variance );
        yaw = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_yaw * -1, self.var_c7b6c9bfdbf8d9fc.base_yaw + self.var_c7b6c9bfdbf8d9fc.low_variance );
        pitch = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_pitch * -1, self.var_c7b6c9bfdbf8d9fc.base_pitch + self.var_c7b6c9bfdbf8d9fc.low_variance );
        roll = randomfloatrange( self.var_c7b6c9bfdbf8d9fc.base_roll * -1, self.var_c7b6c9bfdbf8d9fc.base_roll + self.var_c7b6c9bfdbf8d9fc.high_variance );
        self.var_c7b6c9bfdbf8d9fc rotateto( ( yaw, pitch, roll ) + function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        wait duration + randomfloat( self.var_c7b6c9bfdbf8d9fc.duration_variance );
    }
    
    if ( !level utility::flag( flag_endon ) )
    {
        duration = min( 30, self.var_c7b6c9bfdbf8d9fc.base_duration * 2 );
        self.var_c7b6c9bfdbf8d9fc rotateto( function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
        level utility::flag_wait_or_timeout( flag_endon, duration );
    }
    
    if ( !level utility::flag( flag_endon ) )
    {
        duration = min( 60, self.var_c7b6c9bfdbf8d9fc.base_duration * 4 );
    }
    else
    {
        duration = min( 3, self.var_c7b6c9bfdbf8d9fc.base_duration );
    }
    
    self.var_c7b6c9bfdbf8d9fc rotateto( ( 0, 0, 0 ), duration, duration * 0.2, duration * 0.4 );
    wait duration;
    wait 0.2;
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self playersetgroundreferenceent( undefined );
        self.var_550963bbb003c756 = ( 0, 0, 0 );
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc delete();
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc = undefined;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x69ff6b05, Offset: 0xce3b
// Size: 0x195
function function_d3628e3a5e8b1088( flag_endon, var_ff7969d4eb2f286e = 1 )
{
    self notify( #"hash_55196d40770c490a" );
    self endon( #"hash_55196d40770c490a" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        player_camera_sway_settings();
    }
    
    if ( var_ff7969d4eb2f286e )
    {
        self.var_c7b6c9bfdbf8d9fc.angles = function_2bba09510ee8823d();
    }
    
    duration = min( 3, self.var_c7b6c9bfdbf8d9fc.base_duration );
    self.var_c7b6c9bfdbf8d9fc rotateto( function_2bba09510ee8823d(), duration, duration * 0.2, duration * 0.4 );
    level utility::flag_wait_or_timeout( flag_endon, duration );
    
    if ( !level utility::flag( flag_endon ) )
    {
        duration = min( 30, self.var_c7b6c9bfdbf8d9fc.base_duration * 4 );
    }
    else
    {
        duration = min( 3, self.var_c7b6c9bfdbf8d9fc.base_duration );
    }
    
    self.var_c7b6c9bfdbf8d9fc rotateto( ( 0, 0, 0 ), duration, duration * 0.2, duration * 0.4 );
    wait duration;
    wait 0.2;
    
    if ( isdefined( self.var_c7b6c9bfdbf8d9fc ) )
    {
        self playersetgroundreferenceent( undefined );
        self.var_550963bbb003c756 = ( 0, 0, 0 );
        wait 0.2;
        self.var_c7b6c9bfdbf8d9fc delete();
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xe722ed0d, Offset: 0xcfd8
// Size: 0xc8
function function_4d2db5d7026cb93f( intensity = "low", flag_endon )
{
    self notify( #"hash_8bb6acba39a2659c" );
    self endon( #"hash_8bb6acba39a2659c" );
    self endon( #"death_or_disconnect", #"cancel_disorientation", #"cancel_shellshock" );
    level endon( #"flag_tunnels_prison_complete" );
    
    if ( intensity == "low" )
    {
        shockfile = %"sound_veil_reduced_mp";
    }
    else
    {
        shockfile = %"sound_veil_mp";
    }
    
    while ( isdefined( self ) && !level utility::flag( "flag_tunnels_prison_complete" ) )
    {
        shellshock_utility_cpmp::_shellshock( shockfile, #"stun", 0.5, 0 );
        wait 0.5;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x407f687a, Offset: 0xd0a8
// Size: 0xa0
function function_1cdd28af12b71f9c( fov_change, fov_time )
{
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    if ( !isdefined( fov_change ) )
    {
        fov_value = self.defaultbasefov;
    }
    else if ( self ispcplayer() )
    {
        fov_value = clamp( self.defaultbasefov + fov_change, 30, 110 );
    }
    else
    {
        fov_value = clamp( self.defaultbasefov + fov_change, 30, 170 );
    }
    
    if ( !isdefined( fov_time ) )
    {
        fov_time = 0;
    }
    
    self modifybasefov( fov_value, fov_time );
}

// Namespace gemini_util
// Params 1
// Checksum 0xe4b3c49b, Offset: 0xd150
// Size: 0x2c
function player_fov_restore( fov_time = 0.5 )
{
    function_1cdd28af12b71f9c( undefined, fov_time );
    self.defaultbasefov = undefined;
}

// Namespace gemini_util
// Params 2
// Checksum 0x86a35a0b, Offset: 0xd184
// Size: 0x3e
function player_set_speed( speed_scale = 0.65, speed_id = "modified_speed" )
{
    weapons::function_4512b7715789e4cf( speed_id, speed_scale );
    weapons::updatemovespeedscale();
}

// Namespace gemini_util
// Params 3
// Checksum 0xcaf182fa, Offset: 0xd1ca
// Size: 0x107
function player_change_speed( end_speed_scale = 0.8, total_duration = 1, speed_id = "modified_speed" )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"cancel_change_speed" );
    start_speed_scale = 0;
    
    if ( isdefined( self.var_e5996377e9a13e32[ speed_id ] ) )
    {
        start_speed_scale = self.var_e5996377e9a13e32[ speed_id ];
    }
    
    var_1c83185125fa8090 = utility::function_4b74c15943231980( total_duration );
    timeelapsed = 0;
    starttime = gettime();
    
    while ( true )
    {
        timeelapsed = gettime() - starttime;
        frac = min( 1, timeelapsed / var_1c83185125fa8090 );
        scalar = math::lerp( start_speed_scale, end_speed_scale, frac );
        weapons::function_4512b7715789e4cf( speed_id, scalar );
        weapons::updatemovespeedscale();
        waitframe();
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x29a4290e, Offset: 0xd2d9
// Size: 0x56
function player_reset_speed( speed_id = "modified_speed" )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self notify( #"cancel_change_speed" );
    waitframe();
    
    if ( isdefined( self.var_e5996377e9a13e32[ speed_id ] ) )
    {
        weapons::function_986fc44dada307f4( speed_id );
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xfb8dc9dc, Offset: 0xd337
// Size: 0x80
function function_2f67757085a7d964( ent_flag_endon, level_flag_endon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    thread function_558aa04fa245313();
    
    if ( isdefined( ent_flag_endon ) || isdefined( level_flag_endon ) )
    {
        if ( isdefined( ent_flag_endon ) && isdefined( level_flag_endon ) )
        {
            utility::waittill_any_ents( level, level_flag_endon, self, ent_flag_endon );
        }
        else if ( isdefined( level_flag_endon ) )
        {
            level utility::flag_wait( level_flag_endon );
        }
        else
        {
            utility::ent_flag_wait( ent_flag_endon );
        }
        
        thread function_4812f9b646bab98d();
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x3b4921e7, Offset: 0xd3bf
// Size: 0xf9
function function_558aa04fa245313()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"hash_3635881c11c7eff2" );
    var_6965ef9712a0fc8d = 2;
    self.oobtype = var_6965ef9712a0fc8d;
    oobtimeleft = 10;
    self.oobtimeleft = oobtimeleft * 1000;
    self.oobendtime = int( gettime() + self.oobtimeleft );
    self setclientomnvar( "ui_out_of_bounds_type", var_6965ef9712a0fc8d );
    self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    val::group_set( "enterOOB", 0 );
    
    while ( true )
    {
        wait oobtimeleft;
        oobtimeleft = randomfloatrange( 5, 29 );
        self.oobtimeleft = oobtimeleft * 1000;
        self.oobendtime = int( gettime() + self.oobtimeleft );
        self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xa4bcfaf2, Offset: 0xd4c0
// Size: 0x32
function function_4812f9b646bab98d()
{
    self notify( #"hash_3635881c11c7eff2" );
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    val::group_reset( "enterOOB" );
}

// Namespace gemini_util
// Params 0
// Checksum 0x9f357900, Offset: 0xd4fa
// Size: 0x8f
function function_178de2439c77b626()
{
    foreach ( player in level.players )
    {
        player armor::function_164c824617d7e8d7( 3 );
        player item_ammo::function_5b3e00ec8cebdbea( undefined, 1, 1, 0 );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x7d0f131c, Offset: 0xd591
// Size: 0x1e
function function_56cd13284dc5e2d9()
{
    utility::add_fx( "player_cold_breath", "vfx_sat_mp_ob_gem_cold_breath_chd_1" );
    level.init_player_cold_breath = 1;
}

// Namespace gemini_util
// Params 1
// Checksum 0x50b507fa, Offset: 0xd5b7
// Size: 0x11f
function player_cold_breath_toggle( var_14edd12998ee8ae6 = "flag_gemini_exfil_igc_begin" )
{
    self notify( #"hash_3ce7194a587d813a" );
    self endon( #"hash_3ce7194a587d813a" );
    self endon( #"death" );
    
    if ( !isdefined( level.init_player_cold_breath ) )
    {
        function_56cd13284dc5e2d9();
    }
    
    if ( !isdefined( self.cold_breath_tag ) )
    {
        v_eye = self geteye();
        v_mouth = v_eye - ( 0, 0, 5 );
        var_8c21b829b51b0cb8 = v_mouth + anglestoforward( self.angles ) * 14;
        self.cold_breath_tag = utility::spawn_tag_origin( var_8c21b829b51b0cb8, self.angles );
        self.cold_breath_tag show();
        self.cold_breath_tag linkto( self );
    }
    
    waitframe();
    
    while ( !utility::flag( var_14edd12998ee8ae6 ) )
    {
        playfxontag( level._effect[ "player_cold_breath" ], self.cold_breath_tag, "tag_origin" );
        wait randomfloatrange( 8, 12 );
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x3fea6733, Offset: 0xd6de
// Size: 0xc4
function function_8f5ecb74b92331c( n_timeout = 5, ent_flag_endon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self setdemeanorviewmodel( "relaxed", "sat_ges_demeanor_relaxed_gundown_gem" );
    waitframe();
    timeout = gettime() + utility::function_4b74c15943231980( n_timeout );
    
    while ( gettime() < timeout )
    {
        if ( isdefined( ent_flag_endon ) && utility::ent_flag( ent_flag_endon ) )
        {
            break;
        }
        
        if ( self attackbuttonpressed() )
        {
            break;
        }
        
        if ( self playerads() > 0.5 )
        {
            break;
        }
        
        if ( length( self getvelocity() ) > 10 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    self setdemeanorviewmodel( "normal" );
}

// Namespace gemini_util
// Params 2
// Checksum 0x59c8e887, Offset: 0xd7aa
// Size: 0x73
function function_5e0ec074b46e6e09( flg_wait, var_610a8cdc6d5cf8f4 = 1.8 )
{
    player = self;
    level thread namespace_60d9b3cbf41663fe::function_d90053228ff20554( var_610a8cdc6d5cf8f4 );
    id_reference = "gemini_prison_underground_start";
    player thread ob_story_mission_utils::set_player_frozen_vars( 1, id_reference );
    
    if ( isdefined( flg_wait ) )
    {
        level utility::flag_wait( flg_wait );
    }
    
    wait var_610a8cdc6d5cf8f4;
    player thread ob_story_mission_utils::set_player_frozen_vars( 0, id_reference );
}

// Namespace gemini_util
// Params 1
// Checksum 0x56a3b095, Offset: 0xd825
// Size: 0xa9
function function_bbf656a0b4c64354( var_68b32a8bafee7061 = "flag_prison_blockade_defeated" )
{
    level endon( #"game_ended" );
    self notify( #"player_zombie_helper" );
    self endon( #"death", #"player_zombie_helper" );
    
    while ( !utility::flag( var_68b32a8bafee7061 ) )
    {
        self waittill( #"zombie_helper_summon", eattacker );
        
        if ( isdefined( eattacker ) )
        {
            if ( !isdefined( self.player_attacker ) || eattacker != self.player_attacker )
            {
                function_38eac3bbcb473e50( eattacker );
            }
        }
        
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace gemini_util
// Params 15
// Checksum 0x9dcb11b, Offset: 0xd8d6
// Size: 0xec
function function_24410a0d29b3ba36( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( isagent( eattacker ) && !eattacker utility::ent_flag( "zombie_helper_target" ) && eattacker.unittype == "soldier" && eattacker.classname != "actor_sat_ob_enemy_specialist_sniper" )
    {
        eattacker utility::ent_flag_set( "zombie_helper_target" );
        victim notify( #"zombie_helper_summon", eattacker );
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x4a01abe7, Offset: 0xd9ca
// Size: 0x1c7
function private function_38eac3bbcb473e50( player_attacker )
{
    self endon( #"death", #"player_attacker_dead", #"player_zombie_helper" );
    
    if ( !isdefined( player_attacker ) || player_attacker.team != "team_hundred_ninety" )
    {
        return;
    }
    
    childthread function_27b91c371e387d5f( player_attacker );
    a_players = ob_story_mission_utils::get_playing_players();
    n_max_helpers = 1;
    
    if ( a_players.size < 3 )
    {
        n_max_helpers = 2;
    }
    
    self.player_attacker = player_attacker;
    
    if ( !isdefined( self.zombie_follower ) )
    {
        self.zombie_follower = undefined;
    }
    
    if ( !isdefined( self.zombie_helper ) )
    {
        self.zombie_helper = spawnstruct();
    }
    else if ( isdefined( self.zombie_helper.ai_array ) && self.zombie_helper.ai_array.size > 0 )
    {
        return;
    }
    
    if ( !isdefined( self.zombie_helper.ai_array ) )
    {
        self.zombie_helper.ai_array = [];
    }
    
    while ( isdefined( player_attacker ) )
    {
        self.zombie_helper ai_array_cleanup( "zombie_base" );
        var_aceca2b20af2d03f = n_max_helpers - self.zombie_helper.ai_array.size;
        
        if ( var_aceca2b20af2d03f > 0 )
        {
            for ( i = 0; i < var_aceca2b20af2d03f ; i++ )
            {
                zombie_helper = function_6f1d246d579bca5e( player_attacker );
                
                if ( isdefined( zombie_helper ) )
                {
                    assert( player_attacker.team == "<dev string:x38d>", "<dev string:x3a1>" );
                    childthread function_ec95c5b3bd90bef8( zombie_helper, player_attacker );
                }
                
                wait 1;
            }
            
            wait 1;
        }
        
        wait 1;
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xd398f69e, Offset: 0xdb99
// Size: 0x1fe
function private function_6f1d246d579bca5e( player_attacker )
{
    level endon( #"game_ended" );
    self endon( #"death", #"player_zombie_helper" );
    
    if ( !isdefined( player_attacker ) )
    {
        return;
    }
    
    player_attacker endon( #"death" );
    zombie_helper = undefined;
    a_zombies = getaiarray( self.team );
    a_zombies = sortbydistancecullbyradius( a_zombies, self.origin, 2048 );
    
    if ( a_zombies.size > 0 )
    {
        foreach ( zombie in a_zombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( zombie namespace_b76ff2659823e89d::is_crawling() )
            {
                continue;
            }
            
            if ( zombie utility::ent_flag( "ai_nerf" ) )
            {
                continue;
            }
            
            if ( zombie.team == "team_hundred_ninety" )
            {
                continue;
            }
            
            if ( zombie utility::ent_flag( "scene_active" ) )
            {
                continue;
            }
            
            if ( isdefined( zombie.target_attractor ) )
            {
                continue;
            }
            
            if ( zombie == self.zombie_follower )
            {
                return zombie;
            }
            
            if ( zombie utility::ent_flag( "zombie_helper" ) || zombie utility::ent_flag( "zombie_follower" ) )
            {
                continue;
            }
            
            if ( isalive( zombie.enemy ) )
            {
                var_eb14336c93af04e7 = distance2dsquared( zombie.origin, zombie.enemy.origin );
                var_fa283f0a884fef70 = distance2dsquared( zombie.origin, self.origin );
                
                if ( var_eb14336c93af04e7 < var_fa283f0a884fef70 )
                {
                    continue;
                }
            }
            
            zombie_helper = zombie;
            break;
        }
    }
    
    return zombie_helper;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x2a1bdf6a, Offset: 0xdda0
// Size: 0x104
function private function_ec95c5b3bd90bef8( zombie_helper, player_attacker )
{
    if ( !isdefined( zombie_helper ) )
    {
        return;
    }
    
    zombie_helper utility::ent_flag_set( "zombie_helper" );
    self.zombie_helper.ai_array = arraycombineunique( self.zombie_helper.ai_array, [ zombie_helper ] );
    thread function_7534109ecb00056d( zombie_helper, player_attacker );
    zombie_helper function_fa32376aaa88a7a2( player_attacker.origin, 1024 );
    
    if ( isdefined( player_attacker ) )
    {
        zombie_helper val::set( "zombie_friendly", "allow_unreachable_attack", 1 );
        
        if ( !level utility::flag( "flag_prison_topside_completed" ) )
        {
            zombie_helper.attackeraccuracy = 0.5;
        }
        
        zombie_helper forcethreatupdate();
        zombie_helper getenemyinfo( player_attacker );
        zombie_helper zombie_utils::function_a8ce00e0448cb6f0( "sprint", "zombie_helper", 25 );
        zombie_helper function_f2fdf8ef124744e8( 0, player_attacker );
        
        /#
            if ( getdvarint( @"scr_zombie_helper_debug", 0 ) )
            {
                childthread function_963a01935b23ce1b( zombie_helper, player_attacker );
            }
        #/
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xd5527f05, Offset: 0xdeac
// Size: 0x26
function private function_27b91c371e387d5f( player_attacker )
{
    player_attacker waittill( #"death" );
    self notify( #"player_attacker_dead" );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x6bee56c9, Offset: 0xdeda
// Size: 0xa3
function private function_7534109ecb00056d( zombie_helper, player_attacker )
{
    utility::waittill_any_ents( zombie_helper, "death", player_attacker, "death" );
    
    if ( isdefined( zombie_helper ) && isdefined( zombie_helper._blackboard ) )
    {
        zombie_helper utility::ent_flag_clear( "zombie_helper" );
        zombie_helper val::set( "zombie_friendly", "allow_unreachable_attack", 0 );
        zombie_helper thread ai_nerf( 4, "run" );
    }
    
    if ( isdefined( self ) )
    {
        self.zombie_helper.ai_array = arrayremove( self.zombie_helper.ai_array, zombie_helper );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xf040ff75, Offset: 0xdf85
// Size: 0x30
function function_d2b84d79fdae4fb7( zombie_follower )
{
    self endon( #"death" );
    zombie_follower waittill( #"death" );
    self.zombie_follower = undefined;
}

// Namespace gemini_util
// Params 1
// Checksum 0xcd33a2fc, Offset: 0xdfbd
// Size: 0x39
function function_ee6076d043cfa4d7( zombie_follower )
{
    self endon( #"death" );
    zombie_follower endon( #"death" );
    level utility::flag_wait( "flag_prison_blockade_defeated" );
    zombie_follower function_54d3d4ceb3d0bc90();
}

/#

    // Namespace gemini_util
    // Params 2
    // Checksum 0xf7400461, Offset: 0xdffe
    // Size: 0xe1, Type: dev
    function function_963a01935b23ce1b( zombie_helper, player_attacker )
    {
        self endon( #"death" );
        
        while ( isdefined( zombie_helper ) && isdefined( player_attacker ) )
        {
            if ( !isalive( zombie_helper ) || !isalive( player_attacker ) )
            {
                return;
            }
            
            print3d( player_attacker.origin + ( 0, 0, 72 ), "<dev string:x3d9>", ( 1, 0, 0 ), 1, 1, 2 );
            print3d( zombie_helper.origin + ( 0, 0, 72 ), "<dev string:x3e9>", ( 0, 1, 0 ), 1, 1, 2 );
            thread utility::draw_line_for_time( zombie_helper.origin, player_attacker.origin, 0, 0, 1, 0.1 );
            wait 0.1;
        }
    }

    // Namespace gemini_util
    // Params 1
    // Checksum 0x989b25a4, Offset: 0xe0e7
    // Size: 0xcb, Type: dev
    function function_c8160479b6b7649( zombie_follower )
    {
        self endon( #"death" );
        
        while ( isalive( zombie_follower ) )
        {
            print3d( zombie_follower.origin + ( 0, 0, 72 ), "<dev string:x3f7>", ( 1, 1, 0 ), 1, 1.5, 2 );
            thread utility::draw_line_for_time( zombie_follower.origin, self.origin, 0, 1, 1, 0.1 );
            
            if ( isdefined( zombie_follower.enemy ) )
            {
                thread utility::draw_line_for_time( zombie_follower.origin, zombie_follower.enemy.origin, 1, 0, 1, 0.1 );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace gemini_util
// Params 3
// Checksum 0xeb54630d, Offset: 0xe1ba
// Size: 0xc5, Type: bool
function within_fov_of_players( end_origin, fov = 0.707106, var_d161cdef1eaba5a8 = 0 )
{
    var_250be8e150cff222 = undefined;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        playereye = level.players[ i ] geteye();
        var_250be8e150cff222 = utility::within_fov( playereye, level.players[ i ] getplayerangles(), end_origin, fov );
        
        if ( var_250be8e150cff222 )
        {
            if ( var_d161cdef1eaba5a8 )
            {
                if ( sighttracepassed( playereye, end_origin, 0, level.players[ i ] ) )
                {
                    return true;
                }
                else
                {
                    continue;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xecfc93e3, Offset: 0xe288
    // Size: 0x5, Type: dev
    function function_420568b6541ce511()
    {
        
    }

#/

// Namespace gemini_util
// Params 8
// Checksum 0xfb6233ab, Offset: 0xe295
// Size: 0xf9
function function_51e3aaef58423855( enc_targetname, fnspawncallback, userdata = undefined, var_b60496d5b429ae0f, cleanuptype = 2, var_c60a13eba6baced = 0, var_26c2bffa1edee104, var_2a35c135810dbe22 )
{
    request_id = activity_ai_encounters::function_92b671064b0b1ce2( enc_targetname, 0, 1, 1, cleanuptype );
    
    if ( isdefined( fnspawncallback ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( request_id, fnspawncallback, userdata );
    }
    
    if ( !isdefined( var_26c2bffa1edee104 ) )
    {
        var_26c2bffa1edee104 = &function_1d57a24d43e5f893;
    }
    
    activity_ai_encounters::function_16b0131751c4fb39( request_id, var_26c2bffa1edee104 );
    
    if ( isdefined( var_2a35c135810dbe22 ) )
    {
        ai_spawn_director::function_5a08798970350207( request_id, var_2a35c135810dbe22, userdata );
    }
    
    activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    
    if ( self.var_9c4a0b2cae577c1b )
    {
        self.var_9c4a0b2cae577c1b[ request_id ].cleanuptype = cleanuptype;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        thread function_6fa3b0c5823726f3( var_b60496d5b429ae0f, request_id, var_c60a13eba6baced );
    }
    
    return request_id;
}

// Namespace gemini_util
// Params 3
// Checksum 0x5522f5fb, Offset: 0xe397
// Size: 0x20, Type: bool
function function_1d57a24d43e5f893( request_id, user_data, var_62a6b384c0358219 )
{
    return true;
}

// Namespace gemini_util
// Params 3
// Checksum 0xbdde3c9d, Offset: 0xe3c0
// Size: 0x5b
function function_6fa3b0c5823726f3( var_b60496d5b429ae0f, request_id, var_c60a13eba6baced = 0 )
{
    level utility::flag_wait( var_b60496d5b429ae0f );
    
    if ( isdefined( self.var_9c4a0b2cae577c1b[ request_id ] ) )
    {
        if ( var_c60a13eba6baced )
        {
            activity_ai_encounters::function_46dadc3aca2ffac0( request_id, var_c60a13eba6baced );
            return;
        }
        
        cleanup_activity_encounter( request_id );
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xf23f51ed, Offset: 0xe423
// Size: 0x108
function cleanup_activity_encounter( request_id, var_c60a13eba6baced = 0, var_8c0b9efa3145cbb4 = 1 )
{
    activityinstance = self;
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    encounterrequest = var_9c4a0b2cae577c1b[ request_id ];
    
    if ( isdefined( encounterrequest ) )
    {
        if ( encounterrequest.spawntype == 0 && encounterrequest.var_9a413db82b180c81 )
        {
            activity_instance_common::function_32302285cf865c56( activityinstance, undefined, "Active", "AI Director spawn approval for encounter: " + request_id + " was granted" );
            encounterrequest.var_9a413db82b180c81 = 0;
        }
        
        if ( isdefined( encounterrequest.cleanuptype ) )
        {
            var_8c0b9efa3145cbb4 = encounterrequest.cleanuptype == 2;
        }
        
        if ( var_8c0b9efa3145cbb4 )
        {
            function_a8c7910253bb1f28( request_id );
        }
        else
        {
            ai_spawn_director::cancel_spawn_request( request_id, 0, var_c60a13eba6baced );
        }
        
        if ( activityinstance.var_9c4a0b2cae577c1b )
        {
            activityinstance.var_9c4a0b2cae577c1b[ request_id ] = undefined;
        }
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xe95b1068, Offset: 0xe533
// Size: 0xc0
function function_97b700689f1e4cbd( var_c60a13eba6baced = 0, var_8c0b9efa3145cbb4 = 1 )
{
    activityinstance = self;
    var_9c4a0b2cae577c1b = activityinstance.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( requestid, encounterrequest in var_9c4a0b2cae577c1b )
    {
        activityinstance cleanup_activity_encounter( requestid, var_c60a13eba6baced, var_8c0b9efa3145cbb4 );
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0x806ff487, Offset: 0xe5fb
// Size: 0x96
function function_64f308173dd1484c( request_id, var_cdb665c03b873a33, ai_count = 0 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        enc_data = function_9b649316adcccbaa( request_id );
        
        if ( !isdefined( enc_data.ai ) || enc_data.ai.size <= ai_count )
        {
            break;
        }
        
        waitframe();
    }
    
    level utility::flag_set( var_cdb665c03b873a33 );
}

// Namespace gemini_util
// Params 1
// Checksum 0x28e1ef4c, Offset: 0xe699
// Size: 0xd8
function delete_all_ai( n_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    ai_array = getaiarray();
    
    if ( ai_array.size > 0 )
    {
        foreach ( ai in ai_array )
        {
            if ( isdefined( ai ) )
            {
                if ( ai.magic_bullet_shield || ai.damageshield )
                {
                    continue;
                }
                
                ai ai::function_dd7b3233e5b07718( 1 );
                waitframe();
            }
        }
    }
    
    waitframe();
    removeallcorpses();
}

// Namespace gemini_util
// Params 7
// Checksum 0xd714bc38, Offset: 0xe779
// Size: 0xff
function ai_delete_when_out_of_sight( n_close_dist = 1024, n_far_dist = 4096, within_fov = 0.766, var_7792cfd89b3d1495 = 1, b_ai_nerf = 1, latency = 0, var_eb569220497c3457 = 1 )
{
    self notify( #"hash_ac44bd766fc00a48" );
    self endon( #"hash_ac44bd766fc00a48" );
    self endon( #"death", #"hash_fc42fb143ecc3617" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        var_f912c3050ae9e947 = function_d4451e723cacc364( within_fov, var_7792cfd89b3d1495, latency, var_eb569220497c3457, n_close_dist, n_far_dist );
        
        if ( var_f912c3050ae9e947 )
        {
            if ( b_ai_nerf )
            {
                thread ai_nerf();
            }
        }
        else
        {
            break;
        }
        
        wait 1;
    }
    
    function_6db88e9571f4e393();
}

// Namespace gemini_util
// Params 6
// Checksum 0x43e52cd8, Offset: 0xe880
// Size: 0x1a0
function function_d4451e723cacc364( within_fov = 0.766, var_7792cfd89b3d1495 = 1, latency = 0, var_eb569220497c3457 = 1, n_close_dist, n_far_dist )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    var_b6ed8b80bf860e51 = undefined;
    
    if ( isdefined( n_close_dist ) )
    {
        var_b6ed8b80bf860e51 = squared( n_close_dist );
    }
    
    n_far_dist_sq = undefined;
    
    if ( isdefined( n_far_dist ) )
    {
        n_far_dist_sq = squared( n_far_dist );
    }
    
    playerseesme = undefined;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( !isalive( player ) )
        {
            waitframe();
            continue;
        }
        
        if ( var_eb569220497c3457 && function_1126734ff63ac79c() )
        {
            if ( player.sessionstate != "playing" )
            {
                waitframe();
                continue;
            }
            else if ( player::isinlaststand( player ) )
            {
                waitframe();
                continue;
            }
        }
        
        n_player_dist_sq = undefined;
        
        if ( isdefined( n_far_dist_sq ) || isdefined( var_b6ed8b80bf860e51 ) )
        {
            n_player_dist_sq = distancesquared( player.origin, self.origin );
            
            if ( isdefined( n_far_dist_sq ) && n_player_dist_sq > n_far_dist_sq )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( var_b6ed8b80bf860e51 ) && n_player_dist_sq < var_b6ed8b80bf860e51 )
            {
                return 1;
            }
        }
        
        playerseesme = function_3387994d8a0fd69a( player, within_fov, var_7792cfd89b3d1495, latency, var_eb569220497c3457 );
        
        if ( playerseesme )
        {
            return playerseesme;
        }
        
        waitframe();
    }
    
    return 0;
}

// Namespace gemini_util
// Params 5, eflags: 0x4
// Checksum 0x9e6c8ea7, Offset: 0xea29
// Size: 0x1fe
function private function_3387994d8a0fd69a( player, within_fov = 0.766, var_7792cfd89b3d1495 = 1, latency = 0, var_eb569220497c3457 = 1 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( var_eb569220497c3457 && function_1126734ff63ac79c() )
    {
        if ( player.sessionstate != "playing" )
        {
            return 0;
        }
        else if ( player::isinlaststand( player ) )
        {
            return 0;
        }
    }
    
    self endon( #"death" );
    currenttime = gettime();
    
    if ( isdefined( self.playerseesme ) && isdefined( self.playerseesmetime ) && self.playerseesmetime + latency >= currenttime )
    {
        assert( isdefined( self.playerseesme ) );
        return self.playerseesme;
    }
    
    self.playerseesmetime = currenttime;
    self.playerseesme = undefined;
    playereye = player geteye();
    
    if ( utility::within_fov( playereye, player.angles, self.origin, within_fov ) )
    {
        if ( var_7792cfd89b3d1495 )
        {
            feetorigin = self.origin;
            
            if ( sighttracepassed( playereye, feetorigin, 1, player, self ) )
            {
                self.playerseesme = player;
                return self.playerseesme;
            }
            
            eyeorigin = self getapproxeyepos();
            
            if ( sighttracepassed( playereye, eyeorigin, 1, player, self ) )
            {
                self.playerseesme = player;
                return self.playerseesme;
            }
            
            midorigin = ( eyeorigin + feetorigin ) * 0.5;
            
            if ( sighttracepassed( playereye, midorigin, 1, player, self ) )
            {
                self.playerseesme = player;
                return self.playerseesme;
            }
        }
        else
        {
            self.playerseesme = player;
        }
    }
    
    return self.playerseesme;
}

// Namespace gemini_util
// Params 0
// Checksum 0x9c492fc2, Offset: 0xec30
// Size: 0x8d
function function_6db88e9571f4e393()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
    {
        ai::stop_magic_bullet_shield();
    }
    
    function_c8cbee5fb3b870c3();
    
    if ( !utility::ent_flag( "scene_active" ) && self.type == "zombie" )
    {
        despawn_success = zombie_utils::try_despawn_zombie();
        
        if ( despawn_success )
        {
            return;
        }
    }
    
    self.dontdroploot = 1;
    self.var_a13bed1ac47e1b2c = 1;
    ai::function_dd7b3233e5b07718( 1 );
}

// Namespace gemini_util
// Params 0
// Checksum 0x5ad18128, Offset: 0xecc5
// Size: 0x5c, Type: bool
function function_1126734ff63ac79c()
{
    if ( !isdefined( self.asmname ) || !self asmhasstate( self.asmname, "despawn_in" ) )
    {
        return false;
    }
    
    aliases = archetypegetaliases( self.animsetname, "despawn" );
    
    if ( !isdefined( aliases ) || aliases.size == 0 )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xe73b447b, Offset: 0xed2a
    // Size: 0x5, Type: dev
    function function_36dac947a6f0444c()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0x14295d4a, Offset: 0xed37
// Size: 0xd1
function function_87124b79a77abfe2( flag_endon )
{
    if ( utility::ent_flag( "tunnels_prison_zombie_stealth" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "tunnels_prison_zombie_stealth" );
    self.stealth_manager = spawnstruct();
    self.stealth_manager.var_d81967536c133f4a = 0;
    self.stealth_manager.var_d0bf10f61a87b364 = [];
    
    if ( getdvarint( @"hash_3946792eb0b185df", 1 ) )
    {
        thread function_40b326d9f4b11a84( flag_endon );
    }
    
    thread function_96607614cc0fd574( flag_endon );
    level utility::flag_wait( flag_endon );
    level callback::callback( #"hash_c692dcb8a92d659c", { #player:self } );
    
    if ( utility::ent_flag_exist( "tunnels_prison_zombie_stealth" ) && utility::ent_flag( "tunnels_prison_zombie_stealth" ) )
    {
        utility::ent_flag_clear( "tunnels_prison_zombie_stealth" );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xa67b22d3, Offset: 0xee10
    // Size: 0x5, Type: dev
    function function_f3ccd56c8ffb732c()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0xe9411ea8, Offset: 0xee1d
// Size: 0x16e
function function_40b326d9f4b11a84( flag_endon )
{
    self notify( #"hash_39543266646088b0" );
    self endon( #"hash_39543266646088b0" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    utility::ent_flag_init( "stealth_heartbeat_on" );
    waitframe();
    
    while ( true )
    {
        time = gettime();
        var_3690a5ceb18541f8 = function_38bae62785e389c0();
        
        if ( isdefined( var_3690a5ceb18541f8 ) )
        {
            if ( !utility::ent_flag( "stealth_heartbeat_on" ) )
            {
                function_2646ec7687ec6190();
            }
            
            pulsesoundalias = var_3690a5ceb18541f8[ 0 ];
            childthread function_afb9fbff5d5c50b2( pulsesoundalias );
            var_43e47531d549e6a5 = 1;
            pulsedurationms = var_3690a5ceb18541f8[ 1 ] * 1000 * 1 / var_43e47531d549e6a5;
            
            while ( var_43e47531d549e6a5 > 0 )
            {
                pulsestarttime = time;
                childthread _pulse_rumble( pulsedurationms );
                self.stealth_manager notify( #"heartbeat", self.stealth_manager.var_c44bd3007878e64 );
                
                while ( time < pulsestarttime + pulsedurationms )
                {
                    function_84bea06a6870618c( time, pulsestarttime, pulsedurationms );
                    waitframe();
                    time = gettime();
                }
                
                var_43e47531d549e6a5--;
            }
            
            continue;
        }
        
        childthread function_c0b71286d23cbd35();
        childthread function_467bd4e484775387();
        
        if ( level utility::flag( flag_endon ) )
        {
            break;
        }
        
        self waittill( #"hash_146e3f5c8ed38c83" );
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xd0a3cc67, Offset: 0xef93
// Size: 0x1a
function private function_2646ec7687ec6190()
{
    utility::ent_flag_set( "stealth_heartbeat_on" );
    self notify( #"hash_146e3f5c8ed38c83" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xbe83bb74, Offset: 0xefb5
// Size: 0x2b
function private function_aa2d2234f9d31161()
{
    if ( utility::ent_flag_exist( "stealth_heartbeat_on" ) && utility::ent_flag( "stealth_heartbeat_on" ) )
    {
        utility::ent_flag_clear( "stealth_heartbeat_on" );
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x882bddee, Offset: 0xefe8
// Size: 0x38
function private function_afb9fbff5d5c50b2( pulsesoundalias )
{
    if ( !function_b9ad404983b329fe() )
    {
        return;
    }
    
    self playlocalsound( pulsesoundalias, undefined, 1 );
    self.stealth_manager.heartbeat_alias = pulsesoundalias;
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x9d457654, Offset: 0xf028
// Size: 0xd, Type: bool
function private function_b9ad404983b329fe()
{
    return !isdefined( self.usingremote );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x83a0e018, Offset: 0xf03e
// Size: 0x53
function private _pulse_rumble( pulsedurationms )
{
    if ( swim_common::isbreathcritical() || !function_d2c7b55ea0caadec() || !damage_effects::isdeathsdoor() )
    {
        return;
    }
    
    pulseduration = pulsedurationms / 1000;
    wait pulseduration * 0.1;
    childthread function_df023c7ee4259c31( "heartbeatSuperLight" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x2f10b1db, Offset: 0xf099
// Size: 0xd, Type: bool
function private function_d2c7b55ea0caadec()
{
    return !isdefined( self.usingremote );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x69e4e0d, Offset: 0xf0af
// Size: 0x2f
function private function_df023c7ee4259c31( heartbeat )
{
    self setscriptablepartstate( "heartbeat", heartbeat );
    wait 0.05;
    self setscriptablepartstate( "heartbeat", "neutral" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x12fc6992, Offset: 0xf0e6
// Size: 0xf5
function private function_38bae62785e389c0()
{
    intensityindex = function_efd175ff2dbdcf0f();
    
    if ( isdefined( intensityindex ) )
    {
        if ( intensityindex > self.stealth_manager.var_c44bd3007878e64 )
        {
            intensityindex = self.stealth_manager.var_c44bd3007878e64 + 1;
        }
        
        /#
            if ( getdvarint( @"zombie_stealth_sound_debug", 0 ) )
            {
                if ( !isdefined( self.stealth_manager.var_c44bd3007878e64 ) || intensityindex != self.stealth_manager.var_c44bd3007878e64 )
                {
                    iprintlnbold( "<dev string:x407>" + intensityindex + "<dev string:x434>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x439>" + intensityindex );
                }
            }
        #/
        
        self.stealth_manager.var_e507f83d34fc1f70 = intensityindex;
        self.stealth_manager.var_c44bd3007878e64 = intensityindex;
        var_23c77a201f62ac58 = function_598cf2c568f27e5();
        return var_23c77a201f62ac58[ intensityindex ];
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x71ad1123, Offset: 0xf1e3
// Size: 0x4ab
function private function_efd175ff2dbdcf0f()
{
    var_d0bf10f61a87b364 = getaiarrayinradius( self.origin, 768 );
    var_7af08cf7865e5287 = 0;
    intensityinc = 0;
    intensityindex = undefined;
    var_2f17175b25d497ef = undefined;
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = function_45725eed211aafdf();
    }
    
    if ( var_d0bf10f61a87b364.size > 0 )
    {
        foreach ( var_ea616919227739f in var_d0bf10f61a87b364 )
        {
            if ( !isalive( var_ea616919227739f ) )
            {
                var_d0bf10f61a87b364 = arrayremove( var_d0bf10f61a87b364, var_ea616919227739f );
                continue;
            }
            
            if ( var_ea616919227739f utility::ent_flag( "scene_active" ) && !var_ea616919227739f utility::ent_flag( "scene_zombie_action" ) && !var_ea616919227739f utility::ent_flag( "scene_zombie_stealth" ) || var_ea616919227739f utility::ent_flag( "zombie_no_heartbeat" ) )
            {
                var_d0bf10f61a87b364 = arrayremove( var_d0bf10f61a87b364, var_ea616919227739f );
                continue;
            }
            
            if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( var_ea616919227739f.origin, var_2f17175b25d497ef ) )
            {
                var_d0bf10f61a87b364 = arrayremove( var_d0bf10f61a87b364, var_ea616919227739f );
                continue;
            }
            
            if ( var_ea616919227739f.stealth_bsmstate == 3 )
            {
                if ( var_ea616919227739f.enemy == self )
                {
                    self notify( #"hash_df30480e8c432a92" );
                    self.stealth_manager.var_d0bf10f61a87b364 = [];
                    return intensityindex;
                }
                
                var_7af08cf7865e5287 = 1;
            }
            
            waitframe();
        }
    }
    
    if ( var_d0bf10f61a87b364.size > 0 )
    {
        self.stealth_manager.var_d0bf10f61a87b364 = var_d0bf10f61a87b364;
        
        foreach ( var_ea616919227739f in var_d0bf10f61a87b364 )
        {
            if ( !isalive( var_ea616919227739f ) )
            {
                var_d0bf10f61a87b364 = arrayremove( var_d0bf10f61a87b364, var_ea616919227739f );
                continue;
            }
            
            myintensity = undefined;
            var_92b21ca8efb6aef2 = distancesquared( var_ea616919227739f.origin, self.origin );
            
            if ( var_92b21ca8efb6aef2 < squared( 150 ) )
            {
                myintensity = 1;
            }
            else if ( var_92b21ca8efb6aef2 < squared( 250 ) )
            {
                myintensity = 2;
            }
            else if ( var_92b21ca8efb6aef2 < squared( 400 ) )
            {
                myintensity = 3;
            }
            else if ( var_92b21ca8efb6aef2 < squared( 512 ) )
            {
                myintensity = 4;
            }
            
            if ( var_ea616919227739f utility::ent_flag( "scene_active" ) )
            {
                if ( isdefined( myintensity ) )
                {
                    myintensity = minint( 4, myintensity + 1 );
                }
                else
                {
                    myintensity = 4;
                }
            }
            else if ( var_ea616919227739f.stealth_bsmstate == 1 || var_ea616919227739f.stealth_bsmstate == 2 )
            {
                if ( isdefined( myintensity ) )
                {
                    myintensity = maxint( 0, myintensity - 1 );
                }
                else
                {
                    myintensity = 4;
                }
            }
            
            if ( var_7af08cf7865e5287 )
            {
                if ( isdefined( myintensity ) )
                {
                    myintensity = maxint( 0, myintensity - 1 );
                }
                else
                {
                    myintensity = 4;
                }
            }
            
            /#
                if ( getdvarint( @"zombie_stealth_sound_debug", 0 ) )
                {
                    if ( isdefined( myintensity ) && isdefined( var_ea616919227739f ) )
                    {
                        r = 1;
                        g = 1;
                        b = 1;
                        
                        switch ( var_ea616919227739f.stealth_bsmstate )
                        {
                            case 1:
                                r = 1;
                                g = 1;
                                b = 0;
                                break;
                            case 2:
                                r = 1;
                                g = 0.5;
                                b = 0;
                                break;
                            case 3:
                                r = 1;
                                g = 0;
                                b = 0;
                                break;
                            case 0:
                            default:
                                r = 0;
                                g = 1;
                                b = 0;
                                break;
                        }
                        
                        level thread utility::function_95445a6684f51c52( "<dev string:x45e>" + intensityindex, var_ea616919227739f.origin + ( 0, 0, 80 ), ( r, g, b ), 0.5, 1, 1 );
                        level thread utility::draw_line_for_time( self.origin, var_ea616919227739f.origin, r, g, b, 1 );
                        var_ea616919227739f hudoutlineenable( "<dev string:x471>" );
                        var_ea616919227739f thread function_bcfaa671b262530f( self, 5 );
                    }
                }
            #/
            
            if ( isdefined( myintensity ) )
            {
                if ( !isdefined( intensityindex ) || myintensity < intensityindex )
                {
                    intensityindex = myintensity;
                }
            }
            
            waitframe();
        }
    }
    else
    {
        self.stealth_manager.var_d0bf10f61a87b364 = [];
    }
    
    return intensityindex;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xaced0acc, Offset: 0xf697
// Size: 0x5f
function private function_bcfaa671b262530f( player, timeout )
{
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( isdefined( self ) && self getthreatsight( player ) > 0 )
    {
        waitframe();
    }
    
    if ( isdefined( timeout ) )
    {
        wait timeout;
    }
    
    self hudoutlinedisable();
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x201309cf, Offset: 0xf6fe
// Size: 0x4, Type: bool
function private function_b77f2292b9d41748()
{
    return true;
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x5b707ed3, Offset: 0xf70b
// Size: 0x76
function private function_598cf2c568f27e5()
{
    return [ [ "evt_gem_heartbeat_plr_superfast", 1.3 ], [ "evt_gem_heartbeat_plr_fast", 1.721 ], [ "evt_gem_heartbeat_plr_med", 1.973 ], [ "evt_gem_heartbeat_plr_slow", 2.321 ], [ "evt_gem_heartbeat_plr_superslow", 2.86 ] ];
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0xe18a5a58, Offset: 0xf78a
// Size: 0x5f
function private function_84bea06a6870618c( time, pulsestarttime, pulsedurationms )
{
    pulsenormalized = ( time - pulsestarttime ) / pulsedurationms;
    pulsenormalized = math::normalized_offset( pulsenormalized, 0.65 );
    self.stealth_manager.var_d81967536c133f4a = 1 - math::normalized_parabola( pulsenormalized );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x8ffef36b, Offset: 0xf7f1
// Size: 0x78
function private function_c0b71286d23cbd35()
{
    self endon( #"hash_146e3f5c8ed38c83" );
    
    while ( self.stealth_manager.var_c44bd3007878e64 < 5 )
    {
        wait 1;
        self.stealth_manager.var_c44bd3007878e64++;
    }
    
    self.stealth_manager.var_c44bd3007878e64 = undefined;
    wait 1;
    self notify( #"hash_81ca0f4cef336f55" );
    
    if ( utility::ent_flag( "stealth_heartbeat_on" ) )
    {
        function_aa2d2234f9d31161();
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x47cf6899, Offset: 0xf871
// Size: 0x6a
function private function_467bd4e484775387()
{
    self endon( #"hash_146e3f5c8ed38c83" );
    
    while ( true )
    {
        intensityindex = function_efd175ff2dbdcf0f();
        
        if ( isdefined( intensityindex ) )
        {
            if ( !isdefined( self.stealth_manager.var_c44bd3007878e64 ) || intensityindex < self.stealth_manager.var_c44bd3007878e64 )
            {
                function_2646ec7687ec6190();
            }
        }
        
        wait 1;
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xd9576e59, Offset: 0xf8e3
    // Size: 0x5, Type: dev
    function function_4eb5eb56aeed92c9()
    {
        
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0xdd9760da, Offset: 0xf8f0
// Size: 0x188
function function_ed27c47ead3f108a( params )
{
    agent = self;
    a_players = sortbydistancecullbyradius( level.players, agent.origin, 768 );
    
    if ( a_players.size == 0 )
    {
        return;
    }
    
    if ( isstruct( params ) )
    {
        if ( params.tostate == params.fromstate )
        {
            return;
        }
        
        tostate = params.tostate;
    }
    else
    {
        tostate = params;
    }
    
    foreach ( player in a_players )
    {
        if ( !player utility::ent_flag( "zombie_stealth_sound_" + tostate ) )
        {
            var_2f17175b25d497ef = undefined;
            
            if ( isdefined( level.var_5a646ea8e8b153df ) )
            {
                var_2f17175b25d497ef = agent function_45725eed211aafdf();
                
                if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( player.origin, var_2f17175b25d497ef ) )
                {
                    waitframe();
                    continue;
                }
            }
            
            if ( agent function_eb4cf662c470fb0e( player, tostate ) )
            {
                waitframe();
                continue;
            }
            
            player utility::ent_flag_set( "zombie_stealth_sound_" + tostate );
            player thread utility::ent_flag_clear_delayed( "zombie_stealth_sound_" + tostate, 10 );
            agent thread function_de35eea65afa890( tostate, player );
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x7e51c2fa, Offset: 0xfa80
// Size: 0x15c, Type: bool
function private function_eb4cf662c470fb0e( player, tostate )
{
    switch ( tostate )
    {
        case 1:
        case 2:
            var_75de983982817e37 = [ 3 ];
            break;
        case 0:
            var_75de983982817e37 = [ 1, 2, 3 ];
            break;
        case 3:
        default:
            var_75de983982817e37 = [];
            break;
    }
    
    var_d0bf10f61a87b364 = getaiarrayinradius( player.origin, 768 );
    
    if ( var_d0bf10f61a87b364.size > 0 )
    {
        foreach ( var_ea616919227739f in var_d0bf10f61a87b364 )
        {
            if ( !isalive( var_ea616919227739f ) )
            {
                continue;
            }
            
            if ( var_ea616919227739f utility::ent_flag( "scene_active" ) )
            {
                continue;
            }
            
            if ( self == var_ea616919227739f )
            {
                continue;
            }
            
            if ( arraycontains( var_75de983982817e37, var_ea616919227739f.stealth_bsmstate ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x4f9b351c, Offset: 0xfbe5
// Size: 0x20a
function private function_de35eea65afa890( stealth_state, player )
{
    self endon( #"death" );
    sound_alias = undefined;
    var_2077c7a7a985e44 = undefined;
    var_8018a64dcc82967d = 0;
    
    switch ( stealth_state )
    {
        case 0:
            sound_alias = "evt_zombie_stealth_idle";
            var_2077c7a7a985e44 = "damage_light";
            break;
        case 1:
            sound_alias = "uin_stealth_sighted";
            var_2077c7a7a985e44 = "damage_light";
            var_8018a64dcc82967d = 1;
            break;
        case 2:
            sound_alias = "evt_zombie_stealth_hunt";
            var_2077c7a7a985e44 = "damage_light";
            break;
        case 3:
            sound_alias = "uin_stealth_broken";
            var_2077c7a7a985e44 = "damage_heavy";
            var_8018a64dcc82967d = 1;
            break;
        default:
            break;
    }
    
    if ( !isdefined( sound_alias ) )
    {
        return;
    }
    
    if ( getdvarint( @"zombie_stealth_sound_debug", 0 ) )
    {
        /#
            iprintlnbold( "<dev string:x485>" + sound_alias );
            r = 1;
            g = 1;
            b = 1;
            
            switch ( stealth_state )
            {
                case 1:
                    r = 1;
                    g = 1;
                    b = 0;
                    break;
                case 2:
                    r = 1;
                    g = 0.5;
                    b = 0;
                    break;
                case 3:
                    r = 1;
                    g = 0;
                    b = 0;
                    break;
                case 0:
                default:
                    r = 0;
                    g = 1;
                    b = 0;
                    break;
            }
            
            level thread utility::draw_line_for_time( self.origin, self.origin + ( 0, 0, 64 ), r, g, b, 10 );
        #/
    }
    
    if ( var_8018a64dcc82967d && !utility::ent_flag( "scene_active" ) )
    {
        return;
    }
    
    if ( isdefined( var_2077c7a7a985e44 ) )
    {
        player playrumbleonentity( var_2077c7a7a985e44 );
    }
    
    player notify( sound_alias );
    player playlocalsound( sound_alias, undefined, 1 );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xccd6f120, Offset: 0xfdf7
    // Size: 0x5, Type: dev
    function function_27c00b2ed09f045b()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0x8547e4bb, Offset: 0xfe04
// Size: 0x33
function function_f991a3381bf3ace9()
{
    utility::flag_wait( "stealth_enabled" );
    
    if ( utility::flag( "stealth_threat_sight_setup" ) )
    {
        return;
    }
    
    level utility::flag_set( "stealth_threat_sight_setup" );
    threat_sight::threat_sight_set_enabled( 1 );
}

// Namespace gemini_util
// Params 0
// Checksum 0x3422ad84, Offset: 0xfe3f
// Size: 0x35
function function_dfcbf5f9b3b2e6a0()
{
    if ( utility::flag( "stealth_threat_sight_cleanup" ) )
    {
        return;
    }
    
    level utility::flag_set( "stealth_threat_sight_cleanup" );
    threat_sight::threat_sight_set_enabled( 0 );
    setsaveddvar( @"ai_threatsightnotify", 0 );
}

// Namespace gemini_util
// Params 1
// Checksum 0xbbeefd01, Offset: 0xfe7c
// Size: 0xf2
function function_96607614cc0fd574( flag_endon )
{
    self notify( #"hash_54a2b9726436f6b4" );
    self endon( #"hash_54a2b9726436f6b4" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    function_f991a3381bf3ace9();
    self.threat_sight_data = spawnstruct();
    self.threat_sight_data.active = [];
    self.threat_sight_data.var_385fd038d2016eb9 = undefined;
    self.threat_sight_data.var_4a7d87299f4df0b7 = undefined;
    self.threat_sight_data.var_bbab49237ffbc44d = undefined;
    self.threat_sight_data.var_82dd0de366d7fe8a = [];
    val::set( "show_stealth_indicator", 1 );
    level utility::flag_wait( flag_endon );
    function_dfcbf5f9b3b2e6a0();
    val::set( "show_stealth_indicator", 0 );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xc33ac62, Offset: 0xff76
    // Size: 0x5, Type: dev
    function function_e7bb622d01c6b540()
    {
        
    }

#/

// Namespace gemini_util
// Params 6
// Checksum 0xc868bde8, Offset: 0xff83
// Size: 0x2f9
function function_b2e3b9ccdce5ec87( struct_targetname, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, var_ab4c49769a763880 )
{
    var_704f37bf85217934 = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        if ( isdefined( var_ab4c49769a763880 ) && var_704f37bf85217934.size > var_ab4c49769a763880 )
        {
            if ( isdefined( var_704f37bf85217934[ 0 ].script_index ) )
            {
                var_704f37bf85217934 = utility::array_sort_by_script_index( var_704f37bf85217934 );
                var_704f37bf85217934 = utility::array_slice( var_704f37bf85217934, var_ab4c49769a763880 );
            }
            else
            {
                var_704f37bf85217934 = utility::array_random_slice( var_704f37bf85217934, var_ab4c49769a763880 );
            }
        }
        
        n_delay = undefined;
        
        foreach ( index, s_scene in var_704f37bf85217934 )
        {
            if ( var_704f37bf85217934.size > 1 )
            {
                n_delay = index * randomfloatrange( 0.5, 1.5 );
            }
            
            if ( isdefined( s_scene.script_flag_wait ) )
            {
                flag_wait_action = s_scene.script_flag_wait;
            }
            
            if ( isdefined( s_scene.script_flag_set ) )
            {
                flag_set_action = s_scene.script_flag_set;
            }
            
            if ( isdefined( flag_set_death ) )
            {
                s_scene.flag_set_death = flag_set_death;
            }
            
            switch ( s_scene.script_scenescriptbundle )
            {
                case #"hash_ade665100dfcf865":
                    s_scene thread function_dc1fe98b2ae81f42( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_beb6254b424fff40":
                    s_scene thread function_dc1fe98b2ae81f42( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay, 1 );
                    break;
                case #"hash_1da6dfe31e12faae":
                    s_scene thread function_7d9764238d9c5401( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_92ffeaad2bba0bf8":
                case #"hash_a83f766dcc79c9bb":
                case #"hash_e7d99fba56c9fa3a":
                case #"hash_f0024e66efacac0c":
                case #"hash_f0024f66efacad9f":
                case #"hash_f0025066efacaf32":
                    s_scene thread function_cdd368c95024c04f( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_4a0e0b29fcf166d6":
                    s_scene thread function_b2756775cf47c934( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_52fd9f148121c988":
                    s_scene thread function_10003b09dfd1463b( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_cfe3cfa8e6a1626a":
                    s_scene thread function_cb83c9da238555e9( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_9476279e94ab8baf":
                    s_scene thread function_4848ed56c271729e( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                case #"hash_a5d60201596c9592":
                    s_scene thread function_f7cc57005c8a6db9( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
                    break;
                default:
                    break;
            }
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 6
// Checksum 0x9ab38ccb, Offset: 0x10284
// Size: 0x1f0
function function_4848ed56c271729e( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_df0ac467eebfe550, "_object_all_" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    thread scene::init();
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        return;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            return;
        }
    }
    
    thread function_eda1e12edab140ec( flag_wait_action );
    self waittill( #"scene_action" );
    thread function_de6c9f2575fca410( "scene_zombie_action" );
    
    if ( isdefined( flag_set_action ) )
    {
        level utility::flag_set( flag_set_action );
    }
    
    action_shot = "action_forward";
    
    if ( isdefined( self.player_target ) || isdefined( self.target ) )
    {
        breakout_target = undefined;
        
        if ( isdefined( self.player_target ) )
        {
            breakout_target = self.player_target;
        }
        else
        {
            breakout_target = utility::getstruct( self.target, "targetname" );
        }
        
        if ( isdefined( breakout_target ) )
        {
            right = anglestoright( self.angles );
            totarget = vectornormalize( breakout_target.origin - self.origin );
            dot = vectordot( totarget, right );
            
            if ( dot > 0.5 )
            {
                action_shot = "action_right";
            }
            else if ( dot < -0.5 )
            {
                action_shot = "action_left";
            }
        }
    }
    
    scene::play( undefined, action_shot );
    self notify( #"scene_release" );
}

// Namespace gemini_util
// Params 0
// Checksum 0x689fdd4c, Offset: 0x1047c
// Size: 0xd1
function function_df0ac467eebfe550()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_f993de7ccd5ef57a( scene_struct );
    thread function_7a36df810a6c96be( scene_struct );
    thread function_bd2ea71fed267bc7( scene_struct );
    thread function_bcaff6518851cb8e( scene_struct );
    thread function_5994ddcc80dfdf80( scene_struct );
    excluded_dismemberment = [ "both_arms", "right_arm", "left_arm" ];
    function_c7a6146a0c58a1e8( scene_struct, 100, 30, excluded_dismemberment );
    scene_struct waittill( #"scene_action" );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 6
// Checksum 0xaafc3fd6, Offset: 0x10555
// Size: 0x26e
function function_cb83c9da238555e9( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_a562d124b90c646b, "_object_all_" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    thread scene::init();
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        return;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            return;
        }
    }
    
    thread function_eda1e12edab140ec( flag_wait_action );
    self waittill( #"scene_action" );
    thread function_de6c9f2575fca410( "scene_zombie_action" );
    
    if ( isdefined( flag_set_action ) )
    {
        level utility::flag_set( flag_set_action );
    }
    
    scene::play( undefined, "idle" );
    
    if ( self.script_noteworthy == "scene_zombie_no_release" )
    {
        thread scene::play( undefined, [ "action_a", "action_b" ] );
        self waittill( #"scene_death" );
        scene::play( undefined, "death" );
        return;
    }
    
    var_d28547a81bb5b713 = "breakout_action_forward";
    var_776a238690f6b882 = "breakout_end_forward";
    
    if ( isdefined( self.player_target ) || isdefined( self.target ) )
    {
        breakout_target = undefined;
        
        if ( isdefined( self.player_target ) )
        {
            breakout_target = self.player_target;
        }
        else
        {
            breakout_target = utility::getstruct( self.target, "targetname" );
        }
        
        if ( isdefined( breakout_target ) )
        {
            right = anglestoright( self.angles );
            totarget = vectornormalize( breakout_target.origin - self.origin );
            dot = vectordot( totarget, right );
            
            if ( dot > 0.5 )
            {
                var_d28547a81bb5b713 = "breakout_action_right";
                var_776a238690f6b882 = "breakout_end_right";
            }
            else if ( dot < -0.5 )
            {
                var_d28547a81bb5b713 = "breakout_action_left";
                var_776a238690f6b882 = "breakout_end_left";
            }
        }
    }
    
    scene::play( undefined, var_d28547a81bb5b713 );
    scene::play( undefined, var_776a238690f6b882 );
    self notify( #"scene_release" );
}

// Namespace gemini_util
// Params 0
// Checksum 0xf52d7e21, Offset: 0x107cb
// Size: 0xc9
function function_a562d124b90c646b()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_7a36df810a6c96be( scene_struct );
    thread function_bd2ea71fed267bc7( scene_struct );
    thread function_bcaff6518851cb8e( scene_struct );
    thread scene_zombie_no_release_handler( scene_struct, 0 );
    excluded_dismemberment = [ "both_arms", "right_arm", "left_arm" ];
    function_c7a6146a0c58a1e8( scene_struct, 100, 30, excluded_dismemberment );
    scene_struct waittill( #"scene_action" );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 6
// Checksum 0xf92892f2, Offset: 0x1089c
// Size: 0x147
function function_10003b09dfd1463b( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_11b93caa8e122a15, "_object_all_" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    thread scene::init();
    b_no_action = 0;
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        b_no_action = 1;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            b_no_action = 1;
        }
    }
    
    if ( !b_no_action )
    {
        thread function_eda1e12edab140ec( flag_wait_action );
        self waittill( #"scene_action" );
        thread function_de6c9f2575fca410( "scene_zombie_action" );
        
        if ( isdefined( flag_set_action ) )
        {
            level utility::flag_set( flag_set_action );
        }
        
        scene::play( undefined, "idle" );
        thread scene::play( undefined, "action" );
    }
    
    self waittill( #"scene_death" );
    scene::play( undefined, "death" );
}

// Namespace gemini_util
// Params 0
// Checksum 0xd75d4b70, Offset: 0x109eb
// Size: 0x9d
function function_11b93caa8e122a15()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_f993de7ccd5ef57a( scene_struct );
    thread function_7a36df810a6c96be( scene_struct );
    thread function_bd2ea71fed267bc7( scene_struct );
    thread function_bcaff6518851cb8e( scene_struct );
    thread scene_zombie_no_release_handler( scene_struct, 0 );
    scene_struct waittill( #"scene_action" );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 7
// Checksum 0x103d6e0, Offset: 0x10a90
// Size: 0x25e
function function_dc1fe98b2ae81f42( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay, var_d84720722df29ada )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) && level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_4e0771c9a6ff1074, "_object_all_" );
    thread scene::play( undefined, "looping_idle" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    waitframe();
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        return;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            return;
        }
    }
    
    thread function_eda1e12edab140ec( flag_wait_action );
    self waittill( #"scene_action" );
    ents = scene::get_entities();
    waitframe();
    thread function_de6c9f2575fca410( "scene_zombie_action" );
    
    if ( isdefined( flag_set_action ) )
    {
        level utility::flag_set( flag_set_action );
    }
    
    scene::play( ents, "action" );
    self notify( #"scene_release" );
    
    if ( isdefined( flag_set_death ) )
    {
        activity_instance.s_scene_zombies = spawnstruct();
        
        if ( !isdefined( activity_instance.s_scene_zombies.ai_array ) )
        {
            activity_instance.s_scene_zombies.ai_array = [];
        }
        
        foreach ( ent in ents )
        {
            if ( isai( ent ) && isalive( ent ) )
            {
                ent thread function_7653e4bbe774fb50( activity_instance.s_scene_zombies );
            }
        }
        
        while ( activity_instance.s_scene_zombies.ai_array.size > 0 )
        {
            waitframe();
        }
        
        level utility::flag_set( flag_set_death );
        activity_instance.s_scene_zombies = undefined;
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x603c4468, Offset: 0x10cf6
// Size: 0x236
function function_4e0771c9a6ff1074()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    b_no_action = 0;
    
    if ( scene_struct.script_noteworthy == "scene_zombie_no_action" )
    {
        b_no_action = 1;
    }
    
    if ( self.sceneobjectdata.sceneobject.variant_object.name == "Actor 3" )
    {
        utility::ent_flag_set( "scene_zombie_no_stealth" );
        
        if ( scene_struct.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_ally_multi_eating_corpse" )
        {
            self setmodel( "c_sat_ava_opforce_grunt_guild_body_1" );
            
            if ( isdefined( self.headmodel ) )
            {
                self detach( self.headmodel );
            }
            
            self.headmodel = "c_sat_ava_opforce_grunt_guild_head_1";
            self attach( self.headmodel );
            self.team = "team_hundred_ninety";
        }
        else
        {
            thread function_bcaff6518851cb8e( scene_struct );
            excluded_dismemberment = [ "both_arms", "both_legs", "right_leg", "left_arm" ];
            function_c7a6146a0c58a1e8( scene_struct, 80, 20, excluded_dismemberment );
        }
        
        if ( b_no_action )
        {
            val::set_allow_death( 0 );
            self setcandamage( 0 );
            thread ai::magic_bullet_shield( 1 );
        }
        else
        {
            self.health = int( max( self.maxhealth * 0.05, 1 ) );
            thread function_7a36df810a6c96be( scene_struct );
        }
        
        thread function_55e2576e4aa30b5b( scene_struct );
    }
    else
    {
        if ( b_no_action )
        {
            val::set_allow_death( 0 );
            self setcandamage( 0 );
            thread ai::magic_bullet_shield( 1 );
        }
        else if ( scene_struct.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_ally_multi_eating_corpse" )
        {
            thread function_7a36df810a6c96be( scene_struct, 1 );
            function_376f4cf6d212ef9b();
        }
        else
        {
            thread function_7a36df810a6c96be( scene_struct );
        }
        
        thread function_5994ddcc80dfdf80( scene_struct );
    }
    
    if ( !b_no_action )
    {
        scene_struct waittill( #"scene_action" );
        utility::ent_flag_set( "zombie_scene_action" );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x3cb93c94, Offset: 0x10f34
// Size: 0x81
function function_55e2576e4aa30b5b( scene_struct )
{
    self endon( #"death" );
    val::set( "zombie_scene", "ignoreall", 1 );
    val::set( "zombie_scene", "ignoreme", 1 );
    self.var_fd5c989cd241b6c4 = 1;
    utility::ent_flag_wait( "scene_active" );
    waitframe();
    utility::ent_flag_waitopen_any( "scene_active" );
    utility::ent_flag_set( "scene_anim_ended" );
    self notify( #"scene_anim_ended" );
    function_607c1fe28fcb87cd();
}

// Namespace gemini_util
// Params 6
// Checksum 0xc60fd36b, Offset: 0x10fbd
// Size: 0xae
function function_7d9764238d9c5401( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_45a9f79614aca483, "_object_all_" );
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    thread function_1a0594617045595b( flag_wait_action, flag_set_action );
    self waittill( #"scene_death" );
    scene::play( undefined, "death" );
}

// Namespace gemini_util
// Params 0
// Checksum 0xaa92f3d6, Offset: 0x11073
// Size: 0x9e
function function_45a9f79614aca483()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_7a36df810a6c96be( scene_struct );
    thread scene_zombie_no_release_handler( scene_struct );
    val::set( "zombie_scene", "toggle_eye_glow", 0 );
    self.var_b5ee399a718d6a57 = 1;
    scene_struct waittill( #"scene_action" );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 2
// Checksum 0x2c625658, Offset: 0x11119
// Size: 0x95
function function_1a0594617045595b( flag_wait_action, flag_set_action )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup", #"scene_death" );
    
    if ( self.script_noteworthy != "scene_zombie_no_action" )
    {
        thread function_eda1e12edab140ec( flag_wait_action );
        self waittill( #"scene_action" );
        thread function_de6c9f2575fca410( "scene_zombie_action" );
        
        if ( isdefined( flag_set_action ) )
        {
            level utility::flag_set( flag_set_action );
        }
    }
    
    thread scene::play( undefined, [ "action_a", "action_b" ] );
}

// Namespace gemini_util
// Params 7
// Checksum 0xb11ad0b8, Offset: 0x111b6
// Size: 0x197
function function_cdd368c95024c04f( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay, var_7cac3bdf6cebaab3 )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) && level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_75c14efd52dde499, "_object_all_" );
    var_5d373ce3d6540a3 = scene::get_shot_names();
    
    if ( arraycontains( var_5d373ce3d6540a3, "death2" ) )
    {
        death_shot = "death2";
    }
    else
    {
        death_shot = "death";
    }
    
    thread scene::play();
    waitframe();
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    b_no_action = 0;
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        b_no_action = 1;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            b_no_action = 1;
        }
    }
    
    if ( !b_no_action )
    {
        thread function_eda1e12edab140ec( flag_wait_action );
        self waittill( #"scene_action" );
        
        if ( isdefined( var_7cac3bdf6cebaab3 ) )
        {
            wait var_7cac3bdf6cebaab3;
        }
        
        thread function_de6c9f2575fca410( "scene_zombie_action" );
        
        if ( isdefined( flag_set_action ) )
        {
            level utility::flag_set( flag_set_action );
        }
        
        scene::play( undefined, "idle" );
        thread scene::play( undefined, "action" );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0xf74b155b, Offset: 0x11355
// Size: 0xd2
function function_75c14efd52dde499()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    scene_struct thread scene::set_notify_note( self, "melee_swipe", "Actor 1", 1 );
    thread function_f993de7ccd5ef57a( scene_struct );
    thread function_7a36df810a6c96be( scene_struct );
    thread scene_zombie_no_release_handler( scene_struct, 0 );
    self.dontdroploot = 1;
    self.var_a13bed1ac47e1b2c = 1;
    val::set( "zombie_scene", "allow_dismember", 0 );
    scene_struct waittill( #"scene_action" );
    thread function_3339a0d0b20cd234( scene_struct );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 1
// Checksum 0xc042813d, Offset: 0x1142f
// Size: 0x1ec
function function_3339a0d0b20cd234( scene_struct )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"melee_swipe", intensity );
        
        if ( !isdefined( intensity ) )
        {
            intensity = "light";
        }
        
        playing_players = ob_story_mission_utils::get_playing_players();
        var_147f36b70a2f8293 = sortbydistancecullbyradius( playing_players, self.origin, 64 );
        
        if ( var_147f36b70a2f8293.size == 0 )
        {
            waitframe();
            continue;
        }
        
        fwd = anglestoforward( self.angles );
        
        for ( i = 0; i < var_147f36b70a2f8293.size ; i++ )
        {
            player = var_147f36b70a2f8293[ i ];
            
            if ( isdefined( player ) )
            {
                if ( intensity == "heavy" )
                {
                    player playsoundtoplayer( "fly_ai_zombie_melee_swipe_heavy", player );
                    player dodamage( int( min( 25, player.maxhealth * 0.15 ) ), self.origin, self, self, "MOD_MELEE" );
                    player earthquakeforplayer( 0.3, 0.3, player.origin, 1000 );
                    player playrumbleonentity( "damage_heavy" );
                    player viewkick( 50, self.origin );
                    player utility::knockback_flat( player.origin - self.origin, 100 );
                    continue;
                }
                
                player playsoundtoplayer( "fly_ai_zombie_melee_swipe_light", player );
                player dodamage( int( min( 20, player.maxhealth * 0.1 ) ), self.origin, self, self, "MOD_MELEE" );
                player earthquakeforplayer( 0.25, 0.25, player.origin, 1000 );
                player playrumbleonentity( "damage_light" );
                player viewkick( 30, self.origin );
            }
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 6
// Checksum 0x76fdfe59, Offset: 0x11623
// Size: 0x145
function function_b2756775cf47c934( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) && level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    thread function_a811341faff8de3();
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_16be7c291cfdc776, "_object_all_" );
    thread scene::play( undefined, [ "looping_idle" ] );
    
    if ( self.script_noteworthy == "scene_zombie_no_action" )
    {
        return;
    }
    else if ( self.script_count > 0 )
    {
        if ( utility::percent_chance( self.script_count ) )
        {
            return;
        }
    }
    
    thread function_eda1e12edab140ec( flag_wait_action );
    self waittill( #"scene_action" );
    thread function_de6c9f2575fca410( "scene_zombie_action" );
    
    if ( isdefined( flag_set_action ) )
    {
        level utility::flag_set( flag_set_action );
    }
    
    scene::play( undefined, "action_forward" );
    self notify( #"scene_release" );
}

// Namespace gemini_util
// Params 0
// Checksum 0x5380d20b, Offset: 0x11770
// Size: 0x9c
function function_16be7c291cfdc776()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_f993de7ccd5ef57a( scene_struct );
    thread function_7a36df810a6c96be( scene_struct );
    thread function_bd2ea71fed267bc7( scene_struct );
    thread function_bcaff6518851cb8e( scene_struct );
    thread function_5994ddcc80dfdf80( scene_struct );
    scene_struct waittill( #"scene_action" );
    utility::ent_flag_set( "zombie_scene_action" );
}

// Namespace gemini_util
// Params 0
// Checksum 0x32166d0d, Offset: 0x11814
// Size: 0x3d
function function_a811341faff8de3()
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup", #"scene_release" );
    self waittill( #"scene_death" );
    scene::play( undefined, "death" );
}

// Namespace gemini_util
// Params 6
// Checksum 0xed8da945, Offset: 0x11859
// Size: 0xba
function function_f7cc57005c8a6db9( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_aa49c403681321db, "_object_all_" );
    thread scene::play( undefined, [ "looping_idle_b", "looping_idle_l", "looping_idle_r" ] );
}

// Namespace gemini_util
// Params 0
// Checksum 0x58b0abf2, Offset: 0x1191b
// Size: 0x96
function function_aa49c403681321db()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_2bfee50ee7f73863( scene_struct );
    zombie_vox::function_2373b7dab1283d18();
    val::set( "zombie_scene", "show_healthbar", 0 );
    val::set( "zombie_scene", "toggle_eye_glow", 0 );
    function_c7a6146a0c58a1e8( scene_struct, 80, 30 );
}

// Namespace gemini_util
// Params 1
// Checksum 0x6e5eb2e0, Offset: 0x119b9
// Size: 0xbc
function function_2bfee50ee7f73863( scene_struct )
{
    self endon( #"death" );
    val::set( "zombie_scene", "ignoreall", 1 );
    val::set( "zombie_scene", "ignoreme", 1 );
    ai::set_ai_max_health( 999999 );
    self waittill( #"damage", amount, attacker );
    
    if ( isdefined( scene_struct.flag_set_death ) && ( isplayer( attacker ) || isplayer( attacker.owner ) ) )
    {
        level utility::flag_set( scene_struct.flag_set_death );
    }
    
    thread function_607c1fe28fcb87cd( self.origin );
}

// Namespace gemini_util
// Params 6
// Checksum 0x9c2b9e09, Offset: 0x11a7d
// Size: 0xc3
function function_8c2375146fdf468( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_688f907534f12a4a, "_object_all_" );
    thread scene::play( undefined, [ "looping_idle_b", "looping_idle_l", "looping_idle_r", "looping_idle_f" ] );
}

// Namespace gemini_util
// Params 0
// Checksum 0xeee0654b, Offset: 0x11b48
// Size: 0x89
function function_688f907534f12a4a()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    thread function_c864d54978ff94ea( scene_struct );
    zombie_vox::function_2373b7dab1283d18();
    val::set( "zombie_scene", "show_healthbar", 0 );
    val::set( "zombie_scene", "toggle_eye_glow", 0 );
}

// Namespace gemini_util
// Params 1
// Checksum 0x688a0a03, Offset: 0x11bd9
// Size: 0xbc
function function_c864d54978ff94ea( scene_struct )
{
    self endon( #"death" );
    val::set( "zombie_scene", "ignoreall", 1 );
    val::set( "zombie_scene", "ignoreme", 1 );
    ai::set_ai_max_health( 999999 );
    self waittill( #"damage", amount, attacker );
    
    if ( isdefined( scene_struct.flag_set_death ) && ( isplayer( attacker ) || isplayer( attacker.owner ) ) )
    {
        level utility::flag_set( scene_struct.flag_set_death );
    }
    
    thread function_607c1fe28fcb87cd( self.origin );
}

// Namespace gemini_util
// Params 1
// Checksum 0xdf7a2747, Offset: 0x11c9d
// Size: 0x1bf
function function_f993de7ccd5ef57a( scene_struct )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup", #"scene_release" );
    scene_struct waittill( #"scene_action" );
    lookat_dist = 384;
    
    if ( isdefined( scene_struct.radius ) )
    {
        lookat_dist = scene_struct.radius;
    }
    
    self.lookattrigger = spawn( "noent_volume_trigger_radius", self.origin, 0, lookat_dist, lookat_dist );
    self function_28b54d425ee6f778( "player, enemy, random_directions", "prohibit" );
    self function_f90a9bf2ca30fdea( "player, enemy, random_directions", "prohibit" );
    self waittill( #"lookat" );
    var_19282c47393405be = undefined;
    
    while ( isalive( self ) && isdefined( self.lookattrigger ) )
    {
        self.lookattrigger waittill( #"trigger", triggerent );
        
        if ( isplayer( triggerent ) )
        {
            closest_player = function_47c86977a18df38b( level.players, self.origin, lookat_dist );
            
            if ( isdefined( closest_player ) )
            {
                if ( isdefined( var_19282c47393405be ) )
                {
                    ai_lookat::disablelookatentity( var_19282c47393405be );
                }
                
                ai_lookat::enablelookatentity( closest_player );
                var_19282c47393405be = closest_player;
                self function_28b54d425ee6f778( "player, enemy, random_directions", "neutral" );
                self function_f90a9bf2ca30fdea( "player, enemy, random_directions", "neutral" );
            }
            
            wait 1;
            continue;
        }
        
        if ( isdefined( var_19282c47393405be ) && distancesquared( var_19282c47393405be.origin, self.origin ) > squared( lookat_dist ) )
        {
            ai_lookat::disablelookatentity( var_19282c47393405be );
            var_19282c47393405be = undefined;
            self function_28b54d425ee6f778( "player, enemy, random_directions", "prohibit" );
            self function_f90a9bf2ca30fdea( "player, enemy, random_directions", "prohibit" );
        }
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x5ae57c8, Offset: 0x11e64
// Size: 0xd9
function scene_zombie_no_release_handler( scene_struct, var_2e93a3c0cf5f3626 )
{
    self endon( #"death" );
    val::set( "zombie_scene", "ignoreall", 1 );
    val::set( "zombie_scene", "ignoreme", 1 );
    
    if ( var_2e93a3c0cf5f3626 )
    {
        val::set( "zombie_scene", "show_healthbar", 0 );
        ai::set_ai_max_health( 999999 );
    }
    
    self waittill( #"damage", amount, attacker );
    
    if ( isdefined( scene_struct.flag_set_death ) && ( isplayer( attacker ) || isplayer( attacker.owner ) ) )
    {
        level utility::flag_set( scene_struct.flag_set_death );
    }
    
    scene_struct notify( #"scene_death" );
}

// Namespace gemini_util
// Params 2
// Checksum 0x1cd00a74, Offset: 0x11f45
// Size: 0x1fa
function function_5994ddcc80dfdf80( scene_struct, var_84287278605f1667 )
{
    self endon( #"death" );
    val::set( "zombie_scene", "ignoreall", 1 );
    val::set( "zombie_scene", "ignoreme", 1 );
    zombie_difficulty = "difficulty_med";
    
    if ( isdefined( scene_struct.script_parameters ) )
    {
        release_settings = strtok( scene_struct.script_parameters, "," );
        
        if ( isdefined( release_settings[ 0 ] ) )
        {
            var_84287278605f1667 = release_settings[ 0 ];
        }
        
        if ( isdefined( release_settings[ 1 ] ) )
        {
            zombie_difficulty = release_settings[ 1 ];
        }
    }
    
    if ( self.type == "zombie" )
    {
        ob_story_mission_utils::function_ac2a2440f56b2342( zombie_difficulty );
    }
    
    utility::ent_flag_wait( "scene_active" );
    waitframe();
    utility::ent_flag_waitopen_any( "scene_active" );
    utility::ent_flag_set( "scene_anim_ended" );
    self notify( #"scene_anim_ended" );
    self.dontdroploot = 0;
    
    if ( self.var_fd5c989cd241b6c4 )
    {
        return;
    }
    
    val::set( "zombie_scene", "ignoreall", 0 );
    val::set( "zombie_scene", "ignoreme", 0 );
    waitframe();
    
    if ( isdefined( self.var_73d79b5219b914a7 ) )
    {
        ai::set_ai_max_health( self.var_73d79b5219b914a7 );
    }
    
    if ( self.type == "zombie" )
    {
        val::set( "zombie_scene", "toggle_eye_glow", 1 );
        val::reset( "zombie_scene", "allow_dismember" );
        
        if ( isdefined( scene_struct.player_target ) )
        {
            zombie_utils::set_ai_target_priority( scene_struct.player_target );
        }
        else
        {
            thread function_54a189c04c75a149( 1, 512 );
        }
        
        if ( isdefined( var_84287278605f1667 ) )
        {
            zombie_utils::function_a8ce00e0448cb6f0( var_84287278605f1667, "scene_zombie_speed", 25 );
        }
        
        return;
    }
    
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self setgoalpos( self.origin, 1024 );
    self.goalradius = 1024;
    self.dontevershoot = 0;
}

// Namespace gemini_util
// Params 1
// Checksum 0xdc9e78f5, Offset: 0x12147
// Size: 0x4b
function function_bd2ea71fed267bc7( scene_struct )
{
    self endon( #"death" );
    val::set( "zombie_scene", "collide_with_ai_allies", 0 );
    scene_struct waittill( #"scene_action" );
    val::set( "zombie_scene", "collide_with_ai_allies", 1 );
}

// Namespace gemini_util
// Params 1
// Checksum 0x4535d45f, Offset: 0x1219a
// Size: 0x64
function function_bcaff6518851cb8e( scene_struct )
{
    self endon( #"death" );
    val::set( "zombie_scene", "toggle_eye_glow", 0 );
    val::set( "zombie_scene", "show_healthbar", 0 );
    zombie_vox::function_2373b7dab1283d18();
    scene_struct waittill( #"scene_action" );
    zombie_vox::function_21120aecc1ba904b();
    val::reset_all( "zombie_scene" );
}

// Namespace gemini_util
// Params 2
// Checksum 0xadf95237, Offset: 0x12206
// Size: 0x31f
function function_eda1e12edab140ec( flag_wait_action, var_1dadec86cf0cbb73 = 0 )
{
    level endon( #"game_ended" );
    self endon( #"scene_action", #"scene_cleanup" );
    
    if ( self.script_noteworthy == "scene_zombie_no_distance" )
    {
        return;
    }
    
    dist_struct = self;
    
    if ( isdefined( self.target ) && isdefined( utility::getstruct( self.target, "targetname" ) ) )
    {
        dist_struct = utility::getstruct( self.target, "targetname" );
    }
    
    n_radius = 384;
    
    if ( isdefined( dist_struct.radius ) )
    {
        n_radius = dist_struct.radius;
    }
    
    if ( var_1dadec86cf0cbb73 && utility::cointoss() )
    {
        n_radius = randomfloatrange( n_radius * 0.5, n_radius );
    }
    
    if ( isdefined( level.var_5a646ea8e8b153df ) )
    {
        var_2f17175b25d497ef = function_45725eed211aafdf( dist_struct.origin );
    }
    
    if ( self.script_noteworthy == "scene_zombie_stealth" )
    {
        dist_struct.var_472047af058e0ae8 = squared( n_radius * 1.5 );
        dist_struct.var_f38b67248f0dad0e = squared( n_radius );
        dist_struct.var_5f703f5e530a5bfb = squared( n_radius * 0.6 );
        dist_struct.var_ef2a156ac24b0e45 = squared( n_radius * 0.3 );
        self.var_97a30df6a30845d6 = utility::spawn_tag_origin();
        self.var_97a30df6a30845d6.origin = self.origin + ( 0, 0, 64 );
        self.var_97a30df6a30845d6.angles = ( 0, 0, 0 );
        self.var_97a30df6a30845d6 show();
        self.var_97a30df6a30845d6.threat_sight_data = [];
        self.var_97a30df6a30845d6.queue_pending = undefined;
        self.var_97a30df6a30845d6.scene_struct = self;
        
        if ( !isdefined( level.var_44c957d89048d940 ) )
        {
            level.var_44c957d89048d940 = spawnstruct();
        }
        
        thread function_e33d78a1eb250890( n_radius );
    }
    
    player_target = undefined;
    
    while ( true )
    {
        if ( isdefined( flag_wait_action ) && level utility::flag( flag_wait_action ) )
        {
            [ player_target ] = sortbydistance( level.players, dist_struct.origin );
            break;
        }
        
        if ( isdefined( self.var_97a30df6a30845d6 ) )
        {
            player_target = function_36962c8ef48a1afa( dist_struct, n_radius, var_2f17175b25d497ef );
        }
        else
        {
            player_target = function_6014c274a043b925( dist_struct, n_radius, var_2f17175b25d497ef );
        }
        
        if ( isdefined( player_target ) )
        {
            break;
        }
        
        n_wait = 0.2;
        
        if ( var_1dadec86cf0cbb73 )
        {
            n_wait = randomfloatrange( 0.5, 1.5 );
        }
        
        wait n_wait;
    }
    
    if ( isdefined( self.var_97a30df6a30845d6 ) )
    {
        self.var_97a30df6a30845d6 thread utility::delete_after_delay( 3 );
    }
    
    self.player_target = player_target;
    self notify( #"scene_action" );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x92b48ab1, Offset: 0x1252d
// Size: 0x369
function private function_e33d78a1eb250890( n_radius )
{
    level endon( #"game_ended" );
    scene_struct = self;
    scene_struct endon( #"death", #"scene_action", #"scene_death", #"scene_cleanup" );
    wait 1;
    
    if ( scene_struct.a_ai_scene.size > 0 )
    {
        foreach ( ai in scene_struct.a_ai_scene )
        {
            ai notify( #"hash_4daa813e845207a4" );
            
            if ( ai utility::ent_flag_exist( "scene_zombie_no_stealth" ) && ai utility::ent_flag( "scene_zombie_no_stealth" ) )
            {
                continue;
            }
            
            ai utility::ent_flag_set( "scene_zombie_stealth" );
        }
        
        if ( scene_struct.a_ai_scene.size == 1 )
        {
            ai = scene_struct.a_ai_scene[ 0 ];
            scene_struct.var_97a30df6a30845d6.origin = ai geteye() + ( 0, 0, 32 );
        }
    }
    
    entity = scene_struct.var_97a30df6a30845d6;
    entity thread function_9ab4fe6764c20b8c( scene_struct );
    entity endon( #"death" );
    currentstate = 0;
    previousstate = 0;
    threat_sight_data = undefined;
    var_124b6d2fb975ddc9 = 0;
    
    /#
        if ( getdvarint( @"hash_ce51cba662c8156f", 0 ) )
        {
            entity thread function_ff5f3272ed011897( n_radius );
        }
    #/
    
    while ( true )
    {
        entity function_19e426f8e09115b();
        
        foreach ( player in level.players )
        {
            threat_sight_data = entity function_82293ef264bd0aeb( player );
            
            if ( threat_sight_data.visible )
            {
                threat_sight_data.sight += threat_sight_data.rate * level.framedurationseconds;
                
                if ( threat_sight_data.sight >= 1 )
                {
                    break;
                }
            }
            else
            {
                threat_sight_data.sight -= threat_sight_data.rate * level.framedurationseconds * 2;
            }
            
            threat_sight_data.sight = clamp( threat_sight_data.sight, 0, 1 );
            
            if ( threat_sight_data.sight > 0 )
            {
                if ( previousstate != 1 )
                {
                    entity thread function_ed27c47ead3f108a( 1 );
                    previousstate = 1;
                }
            }
            else if ( previousstate != 0 )
            {
                entity thread function_ed27c47ead3f108a( 0 );
                previousstate = 0;
            }
            
            entity threat_sight_sw::function_ce93864cf2b9db09( threat_sight_data );
        }
        
        waitframe();
    }
    
    entity thread function_ed27c47ead3f108a( 3 );
    entity threat_sight_sw::function_ce93864cf2b9db09( threat_sight_data );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x8994793c, Offset: 0x1289e
// Size: 0x140
function private function_9ab4fe6764c20b8c( scene_struct )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    msg = scene_struct utility::waittill_any_return( "death", "scene_action", "scene_death", "scene_cleanup" );
    
    if ( msg == "scene_action" )
    {
        wait 1.5;
    }
    
    foreach ( player in level.players )
    {
        entnum = self getentitynumber();
        refname = "overhead_stealth_display";
        
        if ( player scripted_widgets::anchored_is_active( self, refname ) )
        {
            player scripted_widgets::anchored_remove( self, refname );
        }
        
        if ( isdefined( player.threat_sight_data ) )
        {
            player.threat_sight_data.active[ entnum ] = undefined;
        }
        
        /#
            self notify( #"hash_6591aaa3669da424" );
        #/
    }
    
    waitframe();
    self delete();
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x409c9392, Offset: 0x129e6
// Size: 0x1da
function private function_ff5f3272ed011897( n_radius )
{
    self endon( #"death" );
    
    while ( true )
    {
        threat_sight_data = function_82293ef264bd0aeb( level.players[ 0 ] );
        
        switch ( threat_sight_data.state )
        {
            case #"hash_53c68c9d5acbb6b0":
            case #"hash_9e02cd4a0f3ca981":
                color = ( 1, 0, 0 );
                break;
            case #"hash_45b504aaac1d0acf":
            case #"hash_5ee535013b151894":
            case #"hash_e21b072df2b47f94":
                color = ( 1, 1, 0 );
                break;
            case #"hash_213c15af1ed1a3bc":
            default:
                color = ( 1, 1, 1 );
                break;
        }
        
        /#
            sphere( self.origin, n_radius );
            sphere( self.origin, 16, color );
            print3d( self.origin + ( 0, 0, 20 ), "<dev string:x49c>" + threat_sight_data.sight, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( self.origin + ( 0, 0, 15 ), "<dev string:x4a5>" + threat_sight_data.visible, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( self.origin + ( 0, 0, 10 ), "<dev string:x4af>" + threat_sight_data.state, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
        #/
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x16318551, Offset: 0x12bc8
// Size: 0x4a
function private function_19e426f8e09115b()
{
    entity = self;
    
    if ( entity.queue_pending )
    {
        return;
    }
    
    level.var_44c957d89048d940 utility::fifo_enqueue( entity );
    entity.queue_pending = 1;
    level notify( #"hash_a5e085f6cdd521a4" );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0xced49b8a, Offset: 0x12c1a
// Size: 0xca
function private function_82293ef264bd0aeb( player )
{
    threat_sight_data = threat_sight_sw::function_24984f755625d84b( player );
    
    if ( !isdefined( threat_sight_data.sight ) )
    {
        threat_sight_data.sight = 0;
    }
    
    if ( !isdefined( threat_sight_data.visible ) )
    {
        threat_sight_data.visible = 0;
    }
    
    if ( !isdefined( threat_sight_data.combat ) )
    {
        threat_sight_data.combat = 0;
    }
    
    if ( !isdefined( threat_sight_data.var_584547698236b56d ) )
    {
        threat_sight_data.var_584547698236b56d = undefined;
    }
    
    if ( !isdefined( threat_sight_data.rate ) )
    {
        threat_sight_data.rate = 0.1;
    }
    
    if ( !isdefined( threat_sight_data.state ) )
    {
        threat_sight_data.state = "unaware";
    }
    
    return threat_sight_data;
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0xba33fc7c, Offset: 0x12ced
// Size: 0x11b
function private function_6014c274a043b925( dist_struct, n_radius, var_2f17175b25d497ef )
{
    level endon( #"game_ended" );
    scene_struct = self;
    scene_struct endon( #"scene_action", #"scene_cleanup" );
    player_target = undefined;
    playing_players = ob_story_mission_utils::get_playing_players();
    var_147f36b70a2f8293 = sortbydistancecullbyradius( playing_players, dist_struct.origin, n_radius );
    
    if ( var_147f36b70a2f8293.size > 0 )
    {
        for ( i = 0; i < var_147f36b70a2f8293.size ; i++ )
        {
            player = var_147f36b70a2f8293[ i ];
            
            if ( isdefined( dist_struct.height ) && player.origin[ 2 ] - dist_struct.origin[ 2 ] > dist_struct.height )
            {
                continue;
            }
            
            if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( player.origin, var_2f17175b25d497ef ) )
            {
                continue;
            }
            
            player_target = player;
            break;
        }
    }
    
    return player_target;
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0xf817a00f, Offset: 0x12e11
// Size: 0x442
function private function_36962c8ef48a1afa( dist_struct, n_radius, var_2f17175b25d497ef )
{
    level endon( #"game_ended" );
    scene_struct = self;
    scene_struct endon( #"death", #"scene_action", #"scene_cleanup" );
    
    while ( true )
    {
        entity = level.var_44c957d89048d940 utility::fifo_dequeue();
        
        if ( isdefined( entity ) )
        {
            break;
        }
        
        waitframe();
    }
    
    entity = scene_struct.var_97a30df6a30845d6;
    player_target = undefined;
    var_c0e8e79feb79b04b = undefined;
    playing_players = ob_story_mission_utils::get_playing_players();
    a_players = sortbydistance( playing_players, dist_struct.origin );
    
    if ( a_players.size > 0 )
    {
        for ( i = 0; i < a_players.size ; i++ )
        {
            player = a_players[ i ];
            threat_sight_data = entity function_82293ef264bd0aeb( player );
            
            if ( isdefined( dist_struct.height ) && player.origin[ 2 ] - dist_struct.origin[ 2 ] > dist_struct.height )
            {
                threat_sight_data.visible = 0;
                threat_sight_data.var_584547698236b56d = player;
                threat_sight_data.state = "unaware";
                continue;
            }
            
            if ( isdefined( var_2f17175b25d497ef ) && !ispointinvolume( player.origin, var_2f17175b25d497ef ) )
            {
                threat_sight_data.visible = 0;
                threat_sight_data.var_584547698236b56d = player;
                threat_sight_data.state = "unaware";
                continue;
            }
            
            player_distance = distancesquared( dist_struct.origin, player.origin );
            bsprinting = player issprinting();
            stance = player getstance();
            
            if ( player_distance > dist_struct.var_472047af058e0ae8 )
            {
                threat_sight_data.visible = 0;
                threat_sight_data.var_584547698236b56d = player;
                threat_sight_data.state = "unaware";
                continue;
            }
            else if ( player_distance > dist_struct.var_f38b67248f0dad0e )
            {
                if ( bsprinting )
                {
                    threat_sight_data.visible = 1;
                    threat_sight_data.var_584547698236b56d = player;
                    threat_sight_data.state = "investigate";
                }
                else
                {
                    threat_sight_data.visible = 0;
                    threat_sight_data.var_584547698236b56d = player;
                    threat_sight_data.state = "unaware";
                }
                
                continue;
            }
            else if ( !bsprinting )
            {
                var_52de6b331d390591 = sighttracepassed( player geteye(), entity.origin, 0, player );
                
                if ( !var_52de6b331d390591 )
                {
                    threat_sight_data.visible = 0;
                    threat_sight_data.var_584547698236b56d = player;
                    threat_sight_data.state = "unaware";
                    continue;
                }
                
                if ( player_distance > dist_struct.var_5f703f5e530a5bfb )
                {
                    if ( stance == "stand" )
                    {
                        threat_sight_data.visible = 1;
                        threat_sight_data.var_584547698236b56d = player;
                        threat_sight_data.state = "investigate";
                    }
                    else
                    {
                        threat_sight_data.visible = 0;
                        threat_sight_data.var_584547698236b56d = player;
                        threat_sight_data.state = "unaware";
                    }
                    
                    continue;
                }
                else if ( player_distance > dist_struct.var_ef2a156ac24b0e45 )
                {
                    if ( stance != "stand" )
                    {
                        threat_sight_data.visible = 1;
                        threat_sight_data.var_584547698236b56d = player;
                        threat_sight_data.state = "investigate";
                        continue;
                    }
                }
            }
            
            if ( !isdefined( player_target ) )
            {
                player_target = player;
                var_c0e8e79feb79b04b = threat_sight_data;
            }
        }
    }
    
    if ( isdefined( player_target ) && isdefined( var_c0e8e79feb79b04b ) )
    {
        var_c0e8e79feb79b04b.visible = 1;
        var_c0e8e79feb79b04b.var_584547698236b56d = player_target;
        var_c0e8e79feb79b04b.state = "alerted";
    }
    
    entity.queue_pending = undefined;
    return player_target;
}

// Namespace gemini_util
// Params 2
// Checksum 0xae46ae49, Offset: 0x1325c
// Size: 0x17c
function function_7a36df810a6c96be( scene_struct, var_d84720722df29ada = 0 )
{
    level endon( #"game_ended" );
    scene_struct endon( #"scene_action", #"scene_cleanup" );
    
    if ( !var_d84720722df29ada )
    {
        self.team = "team_two_hundred";
    }
    
    self.dontdroploot = 1;
    thread scene_zombie_death_monitor( scene_struct );
    zombie_utils::function_dfae6a5bd222c586( &function_6fd9eb6c8ad80bbc );
    
    if ( var_d84720722df29ada )
    {
        self waittill( #"damage", amount, attacker );
    }
    else
    {
        while ( isdefined( self ) )
        {
            self waittill( #"damage", amount, attacker );
            
            if ( isplayer( attacker ) || isplayer( attacker.owner ) )
            {
                break;
            }
            
            if ( isdefined( self ) && isdefined( amount ) )
            {
                self.health += amount;
            }
            
            waitframe();
        }
    }
    
    if ( !isdefined( self ) || amount >= self.health )
    {
        return;
    }
    
    if ( isplayer( attacker ) || isplayer( attacker.owner ) )
    {
        scene_struct.player_target = attacker;
    }
    else
    {
        [ scene_struct.player_target ] = sortbydistance( level.players, scene_struct.origin );
    }
    
    scene_struct notify( #"scene_action" );
}

// Namespace gemini_util
// Params 1
// Checksum 0x627334de, Offset: 0x133e0
// Size: 0x71
function scene_zombie_death_monitor( scene_struct )
{
    self waittill( #"death", attacker );
    scene_struct notify( #"scene_zombie_death" );
    
    if ( isdefined( scene_struct.flag_set_death ) && ( isplayer( attacker ) || isplayer( attacker.owner ) ) )
    {
        level utility::flag_set( scene_struct.flag_set_death );
    }
}

// Namespace gemini_util
// Params 5
// Checksum 0x7b9041b7, Offset: 0x13459
// Size: 0x197
function function_c7a6146a0c58a1e8( scene_struct, n_chance_dismember, var_c23a2bef26438963, var_77fa987b6b84d1b2 = [], var_624dfccf2cb92d56 = 2 )
{
    if ( !scene_struct.isplaying )
    {
        wait 1;
    }
    
    var_9847455af91d0354 = [ "both_legs", "both_arms", "left_leg", "right_leg", "left_arm", "right_arm" ];
    
    for ( i = 0; i < var_624dfccf2cb92d56 + 1 ; i++ )
    {
        chance = i == 0 ? n_chance_dismember : var_c23a2bef26438963;
        
        if ( !utility::percent_chance( chance ) )
        {
            return;
        }
        
        dismember_part = var_9847455af91d0354[ i ];
        
        if ( var_77fa987b6b84d1b2.size > 0 && arraycontains( var_77fa987b6b84d1b2, dismember_part ) )
        {
            continue;
        }
        
        switch ( dismember_part )
        {
            case #"hash_e98e93069693d456":
                namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
                break;
            case #"hash_6d5dcfe6977decec":
                namespace_b76ff2659823e89d::function_ea9f5a702fae84ee();
                break;
            case #"hash_12529c46ee2fd68f":
                namespace_b76ff2659823e89d::dismember_left_leg();
                break;
            case #"hash_3341ee903158263a":
                namespace_b76ff2659823e89d::dismember_right_leg();
                break;
            case #"hash_657829471a2d778d":
                namespace_b76ff2659823e89d::dismember_left_arm();
                break;
            case #"hash_948f3990649345f0":
                namespace_b76ff2659823e89d::dismember_right_arm();
                break;
            default:
                break;
        }
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xf0dd71e3, Offset: 0x135f8
// Size: 0x183
function scene_zombie_cleanup( var_b60496d5b429ae0f )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( !utility::flag( var_b60496d5b429ae0f ) )
    {
        level utility::waittill_any_ents( level, var_b60496d5b429ae0f, self, "scene_force_cleanup" );
    }
    
    if ( isdefined( self.scenedata ) && self.scenedata.sceneobjectdata.size > 0 )
    {
        foreach ( struct in self.scenedata.sceneobjectdata )
        {
            if ( isagent( struct.entity ) )
            {
                struct.entity val::reset( "scene_shot", "non_deletable" );
                struct.entity.var_a13bed1ac47e1b2c = 1;
                struct.entity.nocorpse = 1;
                struct.entity thread function_f365b604b2d3544a();
            }
            
            waitframe();
        }
    }
    
    scene::cleanup( 1 );
    
    if ( isdefined( self.var_97a30df6a30845d6 ) )
    {
        self.var_97a30df6a30845d6 delete();
    }
    
    self notify( #"scene_cleanup" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xe1d99bc9, Offset: 0x13783
// Size: 0x3b
function private function_f365b604b2d3544a()
{
    self endon( #"death" );
    
    if ( self.birthtime >= gettime() )
    {
        waitframe();
    }
    
    if ( utility::ent_flag( "flag_scene_zombie" ) )
    {
        thread ai_delete_when_out_of_sight( 512, 768 );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xcbff2a50, Offset: 0x137c6
// Size: 0x4e
function function_607c1fe28fcb87cd( source_pos )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    val::set_allow_death( 1 );
    self setcandamage( 1 );
    
    if ( !isdefined( source_pos ) )
    {
        source_pos = self.origin;
    }
    
    self dodamage( self.health + 999999, source_pos );
}

// Namespace gemini_util
// Params 2
// Checksum 0x29b3a295, Offset: 0x1381c
// Size: 0x35
function function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f )
{
    if ( !isdefined( self.a_ai_scene ) )
    {
        self.a_ai_scene = [];
    }
    
    thread function_20271b2247dee99f( activity_instance, var_b60496d5b429ae0f );
}

// Namespace gemini_util
// Params 1
// Checksum 0x1efe4ae7, Offset: 0x13859
// Size: 0x56
function function_d65cdd8f6bd452b( agent )
{
    if ( !isdefined( self.a_ai_scene ) )
    {
        self.a_ai_scene = [];
    }
    
    agent utility::ent_flag_set( "flag_scene_zombie" );
    self.a_ai_scene = arraycombineunique( self.a_ai_scene, [ agent ] );
    thread function_15f8c0243471a3be( agent );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x20829bf0, Offset: 0x138b7
// Size: 0x32
function private function_15f8c0243471a3be( agent )
{
    agent waittill( #"death" );
    self.a_ai_scene = arrayremove( self.a_ai_scene, agent );
}

// Namespace gemini_util
// Params 1
// Checksum 0x1e483f92, Offset: 0x138f1
// Size: 0x47
function scene_zombie_stealth_disable( agent )
{
    agent endon( #"death" );
    wait 1;
    agent.stealth_enabled = 0;
    agent utility::ent_flag_clear( "stealth_enabled" );
    agent notify( #"hash_4daa813e845207a4" );
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x1718794f, Offset: 0x13940
// Size: 0xf9
function private function_20271b2247dee99f( activity_instance, var_b60496d5b429ae0f )
{
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        level utility::flag_wait( var_b60496d5b429ae0f );
    }
    else if ( isdefined( activity_instance ) )
    {
        activity_instance utility::waittill_any( "activity_ended", "instance_destroyed" );
    }
    else
    {
        return;
    }
    
    if ( isdefined( self.a_ai_scene ) && self.a_ai_scene.size > 0 )
    {
        foreach ( ai in self.a_ai_scene )
        {
            if ( isdefined( ai ) && ai utility::ent_flag( "flag_scene_zombie" ) )
            {
                ai thread ai_delete_when_out_of_sight( 512, 1024 );
                waitframe();
            }
        }
    }
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x55634371, Offset: 0x13a41
// Size: 0x116
function private function_de6c9f2575fca410( set_ent_flag )
{
    if ( !isdefined( self.scenedata ) )
    {
        /#
            iprintlnbold( "<dev string:x4b7>" + self.targetname );
        #/
        
        return;
    }
    
    if ( !isdefined( self.scenedata.sceneroot ) )
    {
        /#
            iprintlnbold( "<dev string:x4f3>" + self.targetname );
        #/
        
        return;
    }
    
    ents = self.scenedata.sceneroot scene::get_entities();
    
    if ( ents.size > 0 )
    {
        foreach ( ent in ents )
        {
            if ( !isalive( ent ) )
            {
                continue;
            }
            
            ent utility::ent_flag_set( set_ent_flag );
        }
    }
    
    utility::ent_flag_set( set_ent_flag );
}

// Namespace gemini_util
// Params 1
// Checksum 0xc8302154, Offset: 0x13b5f
// Size: 0x6d
function function_1f3f685c332568e2( entity_name = "Prop 1" )
{
    wait 1;
    prop = scene::get_entity( entity_name );
    
    if ( isdefined( prop ) )
    {
        var_2a345ab3ef50328c = [ "c_sat_gem_zombie_cradle_prisoner1_body_anim", "c_sat_gem_zombie_cradle_prisoner2_body_anim", "c_sat_gem_zombie_cradle_prisoner3_body_anim" ];
        prop setmodel( utility::array_random( var_2a345ab3ef50328c ) );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xdd6d23d1, Offset: 0x13bd4
    // Size: 0x5, Type: dev
    function function_cdbba7ff079e4eca()
    {
        
    }

#/

// Namespace gemini_util
// Params 6
// Checksum 0x16f30c72, Offset: 0x13be1
// Size: 0x180
function function_5ec3a7bb059e81bb( struct_targetname, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, var_ab4c49769a763880 )
{
    var_704f37bf85217934 = utility::getstructarray( struct_targetname, "targetname" );
    
    if ( var_704f37bf85217934.size > 0 )
    {
        if ( isdefined( var_ab4c49769a763880 ) )
        {
            if ( isdefined( var_704f37bf85217934[ 0 ].script_index ) )
            {
                var_704f37bf85217934 = utility::array_sort_by_script_index( var_704f37bf85217934 );
                var_704f37bf85217934 = utility::array_slice( var_704f37bf85217934, var_ab4c49769a763880 );
            }
            else
            {
                var_704f37bf85217934 = utility::array_random_slice( var_704f37bf85217934, var_ab4c49769a763880 );
            }
        }
        
        n_delay = undefined;
        
        foreach ( index, s_scene in var_704f37bf85217934 )
        {
            if ( var_704f37bf85217934.size > 1 )
            {
                n_delay = index * randomfloatrange( 0.5, 1.5 );
            }
            
            if ( isdefined( s_scene.script_flag_wait ) )
            {
                flag_wait_action = s_scene.script_flag_wait;
            }
            
            if ( isdefined( s_scene.script_flag_set ) )
            {
                flag_set_action = s_scene.script_flag_set;
            }
            
            if ( isdefined( flag_set_death ) )
            {
                s_scene.flag_set_death = flag_set_death;
            }
            
            s_scene thread function_f532aad7600ae04a( self, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay );
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 6
// Checksum 0xf063c553, Offset: 0x13d69
// Size: 0x19c
function function_f532aad7600ae04a( activity_instance, flag_wait_action, flag_set_action, flag_set_death, var_b60496d5b429ae0f, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) && level utility::flag( var_b60496d5b429ae0f ) )
    {
        return;
    }
    
    if ( isdefined( var_b60496d5b429ae0f ) )
    {
        if ( level utility::flag( var_b60496d5b429ae0f ) )
        {
            return;
        }
        
        level endon( var_b60496d5b429ae0f );
        thread scene_zombie_cleanup( var_b60496d5b429ae0f );
    }
    
    function_7240d161be9ac7b4( activity_instance, var_b60496d5b429ae0f );
    scene::add_spawn_function( &function_3a123d214509a66d, "_object_all_" );
    
    if ( !isdefined( self.script_noteworthy ) )
    {
        var_e32757d0c29da9ee = scene::get_shot_names();
        
        if ( var_e32757d0c29da9ee.size == 0 )
        {
            return;
        }
        
        shotname = utility::array_random( var_e32757d0c29da9ee );
    }
    else
    {
        shotname = self.script_noteworthy;
    }
    
    thread scene::init( undefined, [ shotname ] );
    
    while ( true )
    {
        a_ents = scene::get_entities();
        
        if ( a_ents.size > 1 )
        {
            a_ents[ 0 ].var_432e2c419fdbb6b4 = a_ents[ 1 ];
            a_ents[ 1 ].var_432e2c419fdbb6b4 = a_ents[ 0 ];
            break;
        }
        
        waitframe();
    }
    
    thread function_eda1e12edab140ec( flag_wait_action );
    self waittill( #"scene_action" );
    thread function_de6c9f2575fca410( "scene_zombie_action" );
    
    if ( isdefined( flag_set_action ) )
    {
        level utility::flag_set( flag_set_action );
    }
    
    function_9e5def9ac88325f7( a_ents );
    scene::play( undefined, shotname );
    self notify( #"scene_release" );
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xd934a6cc, Offset: 0x13f0d
// Size: 0x164
function private function_3a123d214509a66d()
{
    self endon( #"death" );
    scene_struct = self.sceneobjectdata.sceneroot;
    scene_struct function_d65cdd8f6bd452b( self );
    scene_struct thread scene_zombie_stealth_disable( self );
    statename = self asmgetcurrentstate( self.asmname );
    asmname = self.asmname;
    
    if ( self.type == "zombie" )
    {
        utility::ent_flag_set( "scene_aivsai_zombie" );
        
        if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].team ) )
        {
            self.team = level.players[ 0 ].team;
        }
    }
    else
    {
        utility::ent_flag_set( "scene_aivsai_soldier" );
        self.team = "team_hundred_ninety";
    }
    
    function_473adab84a08d60f( scene_struct, 1 );
    
    while ( !isdefined( self.var_432e2c419fdbb6b4 ) )
    {
        waitframe();
    }
    
    thread function_e67544915925db09( asmname, statename, scene_struct );
    thread function_5994ddcc80dfdf80( scene_struct );
    thread asm::asm_donotetracks( asmname, statename, &function_64e84c2701332bf3, scene_struct );
    utility::ent_flag_wait( "scene_anim_ended" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    function_473adab84a08d60f( scene_struct, 0 );
    
    if ( utility::ent_flag( "scene_aivsai_soldier" ) )
    {
        thread function_fa90281665b4f3a4();
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xb70dfed0, Offset: 0x14079
// Size: 0x1a0
function private function_473adab84a08d60f( scene_struct, var_b84028f2a0141008 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( var_b84028f2a0141008 )
    {
        if ( utility::ent_flag( "scene_aivsai_soldier" ) )
        {
            self animmode( "nogravity" );
        }
        else
        {
            self animmode( "zonly_physics" );
        }
        
        val::set( "zombie_scene", "ignoreme", 1 );
        self.noragdoll = undefined;
        self.script_noragdoll = undefined;
        return;
    }
    
    self unlink();
    val::reset( "zombie_scene", "death" );
    val::reset( "zombie_scene", "damage" );
    val::reset( "zombie_scene", "ignoreme" );
    self.noragdoll = undefined;
    self.script_noragdoll = undefined;
    
    if ( utility::ent_flag( "scene_aivsai_soldier" ) && asm::asm_eventfired( self.asmname, "weapon_drop" ) )
    {
        shared::default_weaponsetup();
        weaponname = self.primaryweapon.basename ?? self.lastweapon.basename;
        weapon = weapon_utility::function_d2c8356dc369d9ce( weaponname );
        shared::forceuseweapon( weapon, "primary" );
        
        if ( isdefined( self.droppedweapon ) )
        {
            self.droppedweapon notify( #"death" );
            
            if ( self.droppedweapon utility::function_de1f80d93273abf5() )
            {
                self.droppedweapon freescriptable();
            }
            else
            {
                self.droppedweapon delete();
            }
            
            self.droppedweapon = undefined;
        }
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0x70d47435, Offset: 0x14221
// Size: 0x63
function private function_fa90281665b4f3a4()
{
    val::reset( "zombie_scene", "death" );
    val::reset( "zombie_scene", "damage" );
    
    if ( utility::ent_flag( "scene_aivsai_soldier" ) )
    {
        function_607c1fe28fcb87cd( self.origin + anglestoforward( self.angles ) );
        return;
    }
    
    function_607c1fe28fcb87cd( self.origin );
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0xaeb0ff6a, Offset: 0x1428c
// Size: 0xb8
function private function_e67544915925db09( asmname, statename, scene_struct )
{
    self endon( #"death", #"scene_anim_ended" );
    scene_struct endon( #"scene_cleanup" );
    self.var_432e2c419fdbb6b4 utility::waittill_any( "death", "entitydeleted" );
    self unlink();
    
    if ( utility::ent_flag( "scene_aivsai_soldier" ) )
    {
        var_bd397b6d595257d9 = asm::asm_eventfired( asmname, "melee_interact" );
        
        if ( var_bd397b6d595257d9 )
        {
            if ( !asm::asm_eventfired( asmname, "death_ragdoll_delayed" ) )
            {
                thread function_fa90281665b4f3a4();
            }
            
            return;
        }
    }
    
    function_473adab84a08d60f( scene_struct, 0 );
    scene_struct scene::cleanup();
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xb82bb098, Offset: 0x1434c
// Size: 0x1c3
function private function_64e84c2701332bf3( note, scene_struct )
{
    self endon( #"death", #"scene_anim_ended" );
    scene_struct endon( #"scene_cleanup" );
    
    if ( note == "sync" )
    {
        if ( !utility::ent_flag( "scene_anim_ended" ) && isalive( self.var_432e2c419fdbb6b4 ) )
        {
            self unlink();
            self.var_432e2c419fdbb6b4 unlink();
            self linktoblendtotag( self.var_432e2c419fdbb6b4, "tag_sync", 1, 1 );
        }
        
        return;
    }
    
    if ( note == "unsync" )
    {
        self unlink();
        
        if ( isalive( self.var_432e2c419fdbb6b4 ) )
        {
            self.var_432e2c419fdbb6b4 unlink();
            self.var_432e2c419fdbb6b4 animmode( "zonly_physics" );
        }
        
        self animmode( "zonly_physics" );
        
        if ( utility::ent_flag( "scene_aivsai_zombie" ) )
        {
            self notify( #"hash_b18bfc100d1db042" );
            self endon( #"hash_b18bfc100d1db042" );
            utility::ent_flag_wait( "scene_anim_ended" );
            return note;
        }
        
        return;
    }
    
    if ( note == "melee_interact" )
    {
        val::set( "zombie_scene", "death", 0 );
        val::set( "zombie_scene", "damage", 0 );
        self function_7f8988ce63c1623d( 0 );
        val::set( "zombie_scene", "collide_with_ai_allies", 0 );
        utility::ent_flag_set( "scene_aivsai_soldier" );
        self.var_fd5c989cd241b6c4 = 1;
        self dodamage( self.health - 1, self.origin, self );
        waitframe();
        function_473adab84a08d60f( scene_struct, 1 );
        return;
    }
    
    if ( note == "weapon_drop" )
    {
        function_dde14923c8eeb8d4();
        return;
    }
    
    if ( note == "melee_death" )
    {
        return note;
    }
}

// Namespace gemini_util
// Params 0, eflags: 0x4
// Checksum 0xb381c2c7, Offset: 0x14517
// Size: 0x3e
function private function_dde14923c8eeb8d4()
{
    if ( self.type == "zombie" || !isalive( self ) )
    {
        return;
    }
    
    shared::dropallaiweapons();
    
    if ( !self.alreadydroppedweapon )
    {
        self.alreadydroppedweapon = 1;
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x34b18088, Offset: 0x1455d
// Size: 0x119
function private function_9e5def9ac88325f7( a_ents, var_7792cfd89b3d1495 )
{
    level endon( #"game_ended" );
    self endon( #"scene_cleanup" );
    n_within_fov = 50;
    
    if ( self.script_count > 0 )
    {
        n_within_fov = self.script_count;
    }
    
    var_80f283118107abb7 = 0;
    
    while ( !var_80f283118107abb7 )
    {
        var_80f283118107abb7 = 0;
        var_3a3fdd16ab7f92da = undefined;
        ent_seen = undefined;
        a_ents = function_5713d46873b29625( a_ents );
        
        if ( a_ents.size == 0 )
        {
            return var_80f283118107abb7;
        }
        
        foreach ( ent in a_ents )
        {
            var_3a3fdd16ab7f92da = function_dac8997488888f23( ent, n_within_fov );
            
            if ( isdefined( var_3a3fdd16ab7f92da ) )
            {
                var_80f283118107abb7 = 1;
                return var_80f283118107abb7;
            }
        }
        
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x444f8c85, Offset: 0x1467e
// Size: 0x69
function private function_dac8997488888f23( ent, fov )
{
    playerseesme = undefined;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        playerseesme = ent function_3387994d8a0fd69a( level.players[ i ], cos( fov ) );
        
        if ( isdefined( playerseesme ) )
        {
            return playerseesme;
        }
        
        waitframe();
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xdef4c1e8, Offset: 0x146f0
    // Size: 0x5, Type: dev
    function function_f434d21435b55fb3()
    {
        
    }

#/

// Namespace gemini_util
// Params 3
// Checksum 0x545ae796, Offset: 0x146fd
// Size: 0x149
function function_b04c2801b2760aff( struct_targetname, flag_endon, n_dist_cleanup = 128 )
{
    activity_instance = self;
    s_start = utility::getstruct( struct_targetname, "targetname" );
    
    if ( !isdefined( s_start ) )
    {
        return;
    }
    
    if ( !isdefined( flag_endon ) )
    {
        flag_endon = "flag_forever";
        activity_instance endon( #"activity_ended", #"instance_destroyed" );
    }
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    level endon( #"game_ended", flag_endon );
    s_start.flag_endon = flag_endon;
    s_start.b_force_cleanup = 0;
    s_start.n_dist_cleanup = n_dist_cleanup;
    level utility::flag_wait( "ai_spawn_director_initialized" );
    groupid = ai_spawn_director::function_e19f6a00c4bb7490( struct_targetname, 0, 1, 1, 3 );
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", groupid, &function_89c1b528257f5fb8, s_start );
    ai_spawn_director::function_9893a28f1d682a28( groupid, "sat_civilian", s_start.origin, s_start.angles, undefined, undefined, undefined, "team_hundred_ninety" );
    level utility::flag_wait( flag_endon );
    s_start.b_force_cleanup = 1;
    wait 1;
    ai_spawn_director::function_d15a5427eec4ebe3( groupid );
}

// Namespace gemini_util
// Params 4
// Checksum 0xf907ffb7, Offset: 0x1484e
// Size: 0x271
function function_89c1b528257f5fb8( groupid, data, agent, ai_data )
{
    agent endon( #"death" );
    s_start = data;
    state = "relaxed";
    
    if ( isdefined( s_start.script_parameters ) )
    {
        state = s_start.script_parameters;
    }
    
    agent function_2bb28ccf461c72ce( "script", 0 );
    agent setcivstate( state );
    agent setsolid( 0 );
    agent setcandamage( 0 );
    agent disableaimassist();
    agent enabletraversals( 0 );
    agent.gender = "male";
    agent.maystumble = 0;
    agent.team = "neutral";
    agent ai::set_ignoreme( 1 );
    agent ai::set_forcegoal();
    agent setcanusecover( 0 );
    agent setperk( "specialty_no_target", 1 );
    agent setperk( "specialty_gpsjammer", 1 );
    agent setperk( "specialty_heartbreaker", 1 );
    agent setplayerghost( 1 );
    agent val::set( "ghost_mason", "allow_vo", 0 );
    agent val::set( "ghost_mason", "show_healthbar", 0 );
    agent val::set( "ghost_mason", "toggle_eye_glow", 0 );
    b_eye_glow = 0;
    
    if ( isdefined( s_start.script_noteworthy ) )
    {
        switch ( s_start.script_noteworthy )
        {
            case #"hash_78f5011b23d3e8fa":
                model = "c_sat_npc_amason_tac_body_gem_mem_merged";
                headmodel = "head_c_sat_usa_pl_amason_proto_mem";
                b_vfx_lrg = 1;
                b_eye_glow = 1;
                break;
            case #"hash_27977798b5f50b0f":
            default:
                model = "c_sat_npc_dmason_child_gem_memory_rig_merged";
                headmodel = "head_c_sat_npc_dmason_child_gem_base_mem";
                b_vfx_lrg = 0;
                b_eye_glow = 0;
                break;
        }
        
        if ( isdefined( agent.headmodel ) )
        {
            agent detach( agent.headmodel );
        }
        
        agent.headmodel = headmodel;
        agent attach( agent.headmodel );
        agent setmodel( model );
    }
    
    waitframe();
    agent thread function_fc3a1e3be0465039( b_vfx_lrg, b_eye_glow );
    agent thread function_297e0ace7ca060bd( s_start );
    agent thread function_fd5d4ce7cdb9d63d( s_start );
    agent thread function_8650b075bc289cb4( s_start );
    agent thread function_91f009e668e8eff6( s_start );
}

// Namespace gemini_util
// Params 1
// Checksum 0x7942b9af, Offset: 0x14ac7
// Size: 0xd1
function function_fd5d4ce7cdb9d63d( s_start )
{
    level endon( #"game_ended" );
    self endon( #"death", #"ghost_mason_cleanup" );
    player_focus = undefined;
    
    while ( !level utility::flag( s_start.flag_endon ) )
    {
        if ( utility::ent_flag( "ghost_mason_moving" ) )
        {
            break;
        }
        
        closest_player = function_47c86977a18df38b( level.players, self.origin, 3072 );
        
        if ( isdefined( closest_player ) )
        {
            self orientmode( "face angle", vectortoyaw( closest_player.origin - self.origin ) );
        }
        else
        {
            self orientmode( "face current" );
        }
        
        wait 1;
    }
    
    waitframe();
    self orientmode( "face current" );
}

// Namespace gemini_util
// Params 1
// Checksum 0x854a9c18, Offset: 0x14ba0
// Size: 0x2d6
function function_297e0ace7ca060bd( s_start )
{
    level endon( #"game_ended" );
    self endon( #"death", #"ghost_mason_cleanup" );
    flag_endon = s_start.flag_endon;
    utility::ent_flag_init( "ghost_mason_moving" );
    var_be17fae8e83d6e7b = utility::getstruct( s_start.target, "targetname" );
    self setgoalpos( s_start.origin, 32 );
    self.goalradius = 32;
    waitframe();
    
    if ( isdefined( s_start.script_flag_wait ) )
    {
        level utility::flag_wait( s_start.script_flag_wait );
    }
    else
    {
        self waittill( #"ghost_mason_move" );
    }
    
    var_be17fae8e83d6e7b = utility::getstruct( s_start.target, "targetname" );
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( isdefined( var_be17fae8e83d6e7b.script_parameters ) )
        {
            state = var_be17fae8e83d6e7b.script_parameters;
            self setcivstate( state );
            waitframe();
        }
        
        self setgoalpos( var_be17fae8e83d6e7b.origin, 32 );
        utility::ent_flag_set( "ghost_mason_moving" );
        waitframe();
        function_c6f5e3f9af4da6d6( var_be17fae8e83d6e7b.origin, flag_endon );
        utility::ent_flag_clear( "ghost_mason_moving" );
        
        if ( var_be17fae8e83d6e7b.script_delete )
        {
            break;
        }
        
        if ( isdefined( var_be17fae8e83d6e7b.script_flag_wait ) )
        {
            level utility::flag_wait( var_be17fae8e83d6e7b.script_flag_wait );
        }
        
        n_delay = undefined;
        
        if ( isdefined( var_be17fae8e83d6e7b.script_delay ) || isdefined( var_be17fae8e83d6e7b.script_delay_min ) || isdefined( var_be17fae8e83d6e7b.script_delay_max ) )
        {
            if ( isdefined( var_be17fae8e83d6e7b.script_delay ) )
            {
                n_delay = var_be17fae8e83d6e7b.script_delay;
            }
            else if ( isdefined( var_be17fae8e83d6e7b.script_delay_max ) )
            {
                if ( isdefined( var_be17fae8e83d6e7b.script_delay_min ) )
                {
                    n_delay = randomfloatrange( var_be17fae8e83d6e7b.script_delay_min, var_be17fae8e83d6e7b.script_delay_max );
                }
                else
                {
                    n_delay = randomfloat( var_be17fae8e83d6e7b.script_delay_max );
                }
            }
        }
        
        var_b6adc505acdaec0e = undefined;
        
        if ( isdefined( var_be17fae8e83d6e7b.script_flag_wait ) )
        {
            var_b6adc505acdaec0e = var_be17fae8e83d6e7b.script_flag_wait;
        }
        
        function_a860d21c8d8d2938( flag_endon, var_b6adc505acdaec0e, n_delay );
        
        if ( isdefined( var_be17fae8e83d6e7b.target ) )
        {
            var_be17fae8e83d6e7b = utility::getstruct( var_be17fae8e83d6e7b.target, "targetname" );
            
            if ( isdefined( var_be17fae8e83d6e7b.script_index ) )
            {
                utility::set_movement_speed( var_be17fae8e83d6e7b.script_index );
            }
        }
        else
        {
            level utility::flag_wait( flag_endon );
            break;
        }
        
        wait 0.5;
    }
    
    wait 0.5;
    thread function_69a22e9763e48c2a();
}

// Namespace gemini_util
// Params 3
// Checksum 0x747e9ba, Offset: 0x14e7e
// Size: 0xc4
function function_c6f5e3f9af4da6d6( var_44616205278e62f2, flag_endon, n_timeout = 30 )
{
    level endon( #"game_ended" );
    self endon( #"death", #"ghost_mason_cleanup" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    var_7ae605d773736268 = squared( self.goalradius );
    start_time = gettime();
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( distance2dsquared( self.origin, var_44616205278e62f2 ) <= var_7ae605d773736268 )
        {
            break;
        }
        
        if ( gettime() - start_time > utility::function_4b74c15943231980( n_timeout ) )
        {
            break;
        }
        
        wait 0.5;
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0x9bd02b98, Offset: 0x14f4a
// Size: 0xea
function function_a860d21c8d8d2938( flag_endon, var_b6adc505acdaec0e, n_delay )
{
    level endon( #"game_ended" );
    self endon( #"death", #"ghost_mason_move", #"ghost_mason_cleanup" );
    
    if ( level utility::flag( flag_endon ) )
    {
        return;
    }
    
    waitframe();
    start_time = gettime();
    b_reset_start_time = 0;
    
    while ( !level utility::flag( flag_endon ) )
    {
        if ( isdefined( var_b6adc505acdaec0e ) )
        {
            if ( level utility::flag( var_b6adc505acdaec0e ) )
            {
                if ( isdefined( n_delay ) )
                {
                    if ( !b_reset_start_time )
                    {
                        start_time = gettime();
                        b_reset_start_time = 1;
                    }
                    
                    if ( gettime() - start_time > utility::function_4b74c15943231980( n_delay ) )
                    {
                        break;
                    }
                }
                else
                {
                    break;
                }
            }
        }
        else if ( isdefined( n_delay ) )
        {
            if ( gettime() - start_time > utility::function_4b74c15943231980( n_delay ) )
            {
                break;
            }
        }
        
        wait 0.5;
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xb2af2d91, Offset: 0x1503c
// Size: 0x88
function function_91f009e668e8eff6( s_start )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) )
        {
            self notify( #"ghost_mason_move" );
            continue;
        }
        
        if ( isdefined( self ) && isdefined( amount ) )
        {
            self.health += amount;
        }
        
        waitframe();
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xc25c18de, Offset: 0x150cc
// Size: 0x13a
function function_8650b075bc289cb4( s_start )
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_45b1db2650b15719" );
    n_dist_move_default = 256;
    var_7ece44131a8443a4 = s_start.n_dist_cleanup;
    var_f8d8dfaa7c1b2ca5 = squared( var_7ece44131a8443a4 );
    
    while ( !s_start.b_force_cleanup )
    {
        if ( isdefined( self.s_goal_radius ) )
        {
            n_dist_move = self.s_goal_radius;
        }
        else
        {
            n_dist_move = n_dist_move_default;
        }
        
        n_dist_move = max( var_7ece44131a8443a4, n_dist_move );
        a_players = getplayersinradius( self.origin, n_dist_move, 128 );
        
        if ( a_players.size > 0 )
        {
            if ( isdefined( s_start.script_flag_wait ) && !level utility::flag( s_start.script_flag_wait ) )
            {
                wait 1;
                continue;
            }
            
            if ( distance2dsquared( a_players[ 0 ].origin, self.origin ) < var_f8d8dfaa7c1b2ca5 )
            {
                break;
            }
            else
            {
                self notify( #"ghost_mason_move" );
            }
        }
        
        wait 0.5;
    }
    
    waitframe();
    thread function_69a22e9763e48c2a();
}

// Namespace gemini_util
// Params 0
// Checksum 0x392af512, Offset: 0x1520e
// Size: 0x8f
function function_69a22e9763e48c2a()
{
    self notify( #"hash_8a09e950ed2ad91f" );
    self endon( #"hash_8a09e950ed2ad91f" );
    self endon( #"death" );
    self notify( #"ghost_mason_cleanup" );
    var_afb881460a65a72d = self gettagorigin( "J_SpineUpper" );
    waitframe();
    playfx( level._effect[ "memory_cradle_dissipate_1" ], var_afb881460a65a72d );
    
    if ( isdefined( self.e_vfx_eyes ) )
    {
        self.e_vfx_eyes unlink();
        self.e_vfx_eyes delete();
    }
    
    function_6db88e9571f4e393();
}

// Namespace gemini_util
// Params 2
// Checksum 0x41425784, Offset: 0x152a5
// Size: 0x17d
function function_fc3a1e3be0465039( b_vfx_lrg = 0, b_eye_glow = 0 )
{
    playfxontag( utility::getfx( "memory_cradle_joint_1" ), self, "j_spine4" );
    playfxontag( utility::getfx( "memory_cradle_joint_2" ), self, "j_knee_le" );
    playfxontag( utility::getfx( "memory_cradle_joint_3" ), self, "j_ankle_ri" );
    playfxontag( utility::getfx( "memory_cradle_joint_3" ), self, "j_wrist_le" );
    
    if ( b_vfx_lrg )
    {
        playfxontag( utility::getfx( "memory_cradle_joint_2" ), self, "j_elbow_ri" );
        playfxontag( utility::getfx( "memory_cradle_joint_3" ), self, "j_wrist_ri" );
        playfxontag( utility::getfx( "memory_cradle_joint_3" ), self, "j_ankle_le" );
    }
    
    if ( b_eye_glow && self tagexists( "tag_eye" ) )
    {
        self.e_vfx_eyes = utility::spawn_tag_origin();
        self.e_vfx_eyes.origin = self gettagorigin( "tag_eye" );
        self.e_vfx_eyes.angles = self gettagangles( "tag_eye" );
        self.e_vfx_eyes linkto( self, "tag_eye", ( -0.8, 0.2, -3.2 ), ( 0, 0, 0 ) );
        self.e_vfx_eyes show();
        waitframe();
        playfxontag( utility::getfx( "memory_eye_glow" ), self.e_vfx_eyes, "tag_origin" );
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x5f68aa72, Offset: 0x1542a
    // Size: 0x5, Type: dev
    function function_67d35ba6fd66bcbc()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xf555a0f4, Offset: 0x15437
// Size: 0x15
function function_85abe3355f8a3cce()
{
    utility::flag_wait( "scriptables_ready" );
    namespace_2745d12b842cc671::function_264d6df31b55827();
}

// Namespace gemini_util
// Params 3
// Checksum 0x5cfbc30d, Offset: 0x15454
// Size: 0x10f
function function_c961de572d334f4a( ajar_dir, b_open_wide = 0, away_org )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( ajar_dir == "away" )
    {
        assert( isdefined( away_org ), "<dev string:x52f>" );
        right = anglestoleft( self.angles );
        dot = vectordot( away_org - self.origin, right );
        
        if ( dot > 0 )
        {
            ajar_dir = "right";
        }
        else if ( dot < -0.5 )
        {
            ajar_dir = "left";
        }
    }
    
    switch ( ajar_dir )
    {
        case #"hash_96815ce4f2a3dbc5":
            if ( b_open_wide )
            {
                ajar_state = "right_50";
            }
            else
            {
                ajar_state = "right_30";
            }
            
            break;
        default:
            if ( b_open_wide )
            {
                ajar_state = "left_50";
            }
            else
            {
                ajar_state = "left_30";
            }
            
            break;
    }
    
    utility::function_7c10ea82c1e305b8( "door", ajar_state );
}

// Namespace gemini_util
// Params 2
// Checksum 0xa0fa1125, Offset: 0x1556b
// Size: 0x6c
function function_d5f3a036e837913( door_name, key = #targetname )
{
    level utility::flag_wait( "scriptables_ready" );
    a_doors = [];
    var_c1a3c26ecaef9d01 = getscriptablearray( door_name, key );
    a_noent_doors = getentitylessscriptablearray( door_name, key );
    a_doors = arraycombine( var_c1a3c26ecaef9d01, a_noent_doors );
    return a_doors;
}

// Namespace gemini_util
// Params 1
// Checksum 0x391c4b58, Offset: 0x155e0
// Size: 0x58
function scriptable_door_lock( b_freeze = 0 )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !self scriptabledoorisclosed() )
    {
        self scriptabledoorclose();
        waitframe();
        
        while ( true )
        {
            if ( self scriptabledoorisclosed() )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    waitframe();
    self scriptabledoorlock();
    
    if ( b_freeze )
    {
        waitframe();
        self scriptabledoorfreeze();
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x2240e227, Offset: 0x15640
    // Size: 0x5, Type: dev
    function function_ad3c1830db4a83f6()
    {
        
    }

#/

// Namespace gemini_util
// Params 3
// Checksum 0x3326166f, Offset: 0x1564d
// Size: 0x5b
function get_scriptable( name, key, b_assert )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !isdefined( key ) )
    {
        key = #targetname;
    }
    
    scriptables = get_scriptable_array( name, key );
    
    if ( !isdefined( scriptables ) )
    {
        return;
    }
    
    return scriptables[ 0 ];
}

// Namespace gemini_util
// Params 3
// Checksum 0x7a9ae394, Offset: 0x156b1
// Size: 0xc2
function get_scriptable_array( name, key, b_assert = 0 )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !isdefined( key ) )
    {
        key = #targetname;
    }
    
    scriptables_entityless = getentitylessscriptablearray( name, key );
    scriptables_entity = getscriptablearray( name, key );
    scriptables = arraycombineunique( scriptables_entityless, scriptables_entity );
    
    if ( b_assert )
    {
        assert( scriptables.size > 0, "<dev string:x570>" + key + "<dev string:x599>" + name );
    }
    else if ( scriptables.size == 0 )
    {
        /#
            iprintln( "<dev string:x570>" + key + "<dev string:x599>" + name );
        #/
        
        return;
    }
    
    return scriptables;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x28d66bdc, Offset: 0x1577c
    // Size: 0x5, Type: dev
    function function_31f993aaaf98e9f()
    {
        
    }

#/

// Namespace gemini_util
// Params 2
// Checksum 0xf9960194, Offset: 0x15789
// Size: 0x49
function function_2f77a111b3a27dcb( gate_targetname, flag_wait_open )
{
    level endon( #"game_ended" );
    var_12dad7deb9f58051 = security_gate_init( gate_targetname );
    waitframe();
    level utility::flag_wait( flag_wait_open );
    var_12dad7deb9f58051 security_gate_open();
}

// Namespace gemini_util
// Params 6
// Checksum 0x8b9e70be, Offset: 0x157da
// Size: 0x1f0
function function_bad374b9f21345b( gate_targetname, flag_set_open, flag_set_interact, flag_endon, flag_wait_close, b_all_interacts = 1 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( flag_endon ) )
    {
        if ( level utility::flag( flag_endon ) )
        {
            return;
        }
        
        level endon( flag_endon );
    }
    
    var_12dad7deb9f58051 = security_gate_init( gate_targetname );
    
    if ( isdefined( flag_wait_close ) )
    {
        var_12dad7deb9f58051 thread security_gate_close( undefined, flag_wait_close );
    }
    
    var_12dad7deb9f58051.a_gate_interact = var_12dad7deb9f58051 utility::function_e1bb0bf82dab729e();
    
    foreach ( var_e4f6af52b1c0ae7c in var_12dad7deb9f58051.a_gate_interact )
    {
        interaction::register_scriptable_interact( var_e4f6af52b1c0ae7c, &function_3904aa25cbff1b99 );
        var_e4f6af52b1c0ae7c thread function_48742f1029c7bf98();
        var_e4f6af52b1c0ae7c.var_12dad7deb9f58051 = var_12dad7deb9f58051;
        
        if ( isdefined( flag_endon ) )
        {
            var_e4f6af52b1c0ae7c.flag_endon = flag_endon;
            var_e4f6af52b1c0ae7c thread security_gate_cleanup( flag_endon );
        }
    }
    
    if ( b_all_interacts )
    {
        n_interacts = var_12dad7deb9f58051.a_gate_interact.size;
        
        for ( n_count = 0; n_count < n_interacts ; n_count++ )
        {
            var_12dad7deb9f58051 waittill( #"security_gate_interact" );
            
            if ( isdefined( flag_set_interact ) )
            {
                utility::flag_set( flag_set_interact );
            }
        }
    }
    else
    {
        var_12dad7deb9f58051 waittill( #"security_gate_interact" );
        
        if ( isdefined( flag_set_interact ) )
        {
            utility::flag_set( flag_set_interact );
        }
    }
    
    waitframe();
    
    if ( gate_targetname == "e_tunnels_mine_gate_03" )
    {
        var_12dad7deb9f58051 function_8957d627566dd5ec( flag_set_open, "flag_tunnels_mine_gate_03_stuck", "flag_tunnels_mine_gate_03_unstick" );
        return;
    }
    
    var_12dad7deb9f58051 security_gate_open( flag_set_open );
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x432a9647, Offset: 0x159d2
// Size: 0x1b
function private security_gate_cleanup( flag_endon )
{
    utility::flag_wait( flag_endon );
    self function_7653c765b6c7b815();
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x14e64dfe, Offset: 0x159f5
// Size: 0x15
function private function_3904aa25cbff1b99( player )
{
    thread function_6edab78a86612ee7( player );
}

// Namespace gemini_util
// Params 1
// Checksum 0x488ed0db, Offset: 0x15a12
// Size: 0x75
function function_6edab78a86612ee7( player )
{
    if ( isdefined( self.flag_endon ) && utility::flag( self.flag_endon ) )
    {
        return;
    }
    
    player function_bee9a4fd918f536d( self );
    utility::function_7c10ea82c1e305b8( "base", "console_on" );
    wait 0.5;
    self notify( #"hash_93d4ae4acdfc3ef5" );
    self.var_12dad7deb9f58051 notify( #"security_gate_interact" );
    thread function_5e8819aede1d0d5();
}

// Namespace gemini_util
// Params 1
// Checksum 0xd08d73f8, Offset: 0x15a8f
// Size: 0x135
function security_gate_init( gate_targetname )
{
    level utility::flag_wait( "scriptables_ready" );
    var_12dad7deb9f58051 = get_scriptable( gate_targetname );
    e_gate_clips = getentarray( gate_targetname + "_clip", #targetname );
    
    if ( isdefined( e_gate_clips ) )
    {
        var_12dad7deb9f58051.clip = e_gate_clips;
        
        foreach ( egc in e_gate_clips )
        {
            egc disconnectpaths();
        }
    }
    
    if ( isdefined( var_12dad7deb9f58051.target ) )
    {
        var_12dad7deb9f58051.light = get_scriptable( var_12dad7deb9f58051.target );
    }
    else
    {
        light = get_scriptable( gate_targetname + "_light", #targetname, 0 );
        
        if ( isdefined( light ) )
        {
            var_12dad7deb9f58051.light = light;
        }
    }
    
    return var_12dad7deb9f58051;
}

// Namespace gemini_util
// Params 1
// Checksum 0x649cbdb, Offset: 0x15bcd
// Size: 0x277
function security_gate_open( flag_open )
{
    if ( isdefined( self.clip ) )
    {
        state = "open_fast";
        var_f1be77dc9d0b94af = 3;
        var_ae740a76f0c8ef99 = 1;
        wait 0.5;
        self setscriptablepartstate( "main", state );
        
        if ( isdefined( self.light ) )
        {
            if ( utility::cointoss() )
            {
                self.light setscriptablepartstate( "main", "on" );
            }
            else
            {
                self.light setscriptablepartstate( "main", "flicker_on" );
            }
        }
        
        time = 0;
        var_2cbe909d48c80c8b = var_f1be77dc9d0b94af / 10 * 4.5;
        var_bc119fe0efb76a2e = [ "_combo_left", "_combo_right" ];
        
        while ( time <= var_f1be77dc9d0b94af )
        {
            for ( i = 0; i < self.clip.size ; i++ )
            {
                if ( self.clip.size == 1 )
                {
                    door_tag_origin = self gettagorigin( "tag_door" );
                }
                else
                {
                    door_tag_origin = self gettagorigin( "tag_door" + var_bc119fe0efb76a2e[ i ] );
                }
                
                self.clip[ i ] moveto( door_tag_origin, 0.1 );
                
                if ( time >= var_2cbe909d48c80c8b && var_ae740a76f0c8ef99 && isdefined( self.clip[ i ].spawnflags ) && self.clip[ i ].spawnflags == 1 )
                {
                    self.clip[ i ] connectpaths();
                }
            }
            
            time += 0.1;
            wait 0.1;
        }
        
        foreach ( egc in self.clip )
        {
            if ( var_ae740a76f0c8ef99 && isdefined( egc.spawnflags ) && egc.spawnflags == 1 )
            {
                egc connectpaths();
            }
        }
    }
    
    if ( var_ae740a76f0c8ef99 && isdefined( flag_open ) )
    {
        level utility::flag_set( flag_open );
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0x92ed98d1, Offset: 0x15e4c
// Size: 0x280
function function_8957d627566dd5ec( flag_open, flag_set_stuck, var_1a35de9ca8f0475e )
{
    if ( isdefined( self.clip ) )
    {
        wait 0.5;
        self setscriptablepartstate( "main", "open_slow_partial" );
        wait 1.5;
        self setscriptablepartstate( "main", "open_slow_stuck" );
        
        if ( isdefined( flag_set_stuck ) )
        {
            level utility::flag_set( flag_set_stuck );
        }
        
        if ( isdefined( var_1a35de9ca8f0475e ) )
        {
            level utility::flag_wait( var_1a35de9ca8f0475e );
        }
        
        var_f1be77dc9d0b94af = 4.3;
        var_2cbe909d48c80c8b = var_f1be77dc9d0b94af / 10 * 5.5;
        time = 0;
        var_bc119fe0efb76a2e = [ "_combo_left", "_combo_right" ];
        var_ae740a76f0c8ef99 = 1;
        self setscriptablepartstate( "main", "open_slow_final" );
        
        if ( isdefined( self.light ) )
        {
            self.light setscriptablepartstate( "main", "flicker_on" );
        }
        
        while ( time <= var_f1be77dc9d0b94af )
        {
            for ( i = 0; i < self.clip.size ; i++ )
            {
                door_tag_origin = self gettagorigin( "tag_door" + var_bc119fe0efb76a2e[ i ] );
                self.clip[ i ] moveto( door_tag_origin, 0.1 );
                
                if ( time >= var_2cbe909d48c80c8b && var_ae740a76f0c8ef99 && isdefined( self.clip[ i ].spawnflags ) && self.clip[ i ].spawnflags == 1 )
                {
                    self.clip[ i ] connectpaths();
                }
            }
            
            time += 0.1;
            wait 0.1;
        }
        
        foreach ( egc in self.clip )
        {
            if ( var_ae740a76f0c8ef99 && isdefined( egc.spawnflags ) && egc.spawnflags == 1 )
            {
                egc connectpaths();
            }
        }
    }
    
    if ( var_ae740a76f0c8ef99 && isdefined( flag_open ) )
    {
        level utility::flag_set( flag_open );
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x84ef4578, Offset: 0x160d4
// Size: 0x2
function security_gate_light_on()
{
    
}

// Namespace gemini_util
// Params 2
// Checksum 0x201dba9d, Offset: 0x160de
// Size: 0x2cd
function security_gate_close( flag_close, flag_wait_close )
{
    if ( isdefined( flag_wait_close ) )
    {
        level utility::flag_wait( flag_wait_close );
    }
    
    if ( !utility::function_9f2c41c1dcc8c94( "main", "open_fast" ) )
    {
        return;
    }
    
    if ( isdefined( self.clip ) )
    {
        state = "close_fast";
        n_close_time = 3;
        var_4dcff7b91f7ed893 = 1;
        wait 0.5;
        self setscriptablepartstate( "main", state );
        time = 0;
        disconnect = n_close_time / 10 * 4.5;
        var_bc119fe0efb76a2e = [ "_combo_left", "_combo_right" ];
        
        while ( time <= n_close_time )
        {
            for ( i = 0; i < self.clip.size ; i++ )
            {
                if ( self.clip.size == 1 )
                {
                    door_tag_origin = self gettagorigin( "tag_door" );
                }
                else
                {
                    door_tag_origin = self gettagorigin( "tag_door" + var_bc119fe0efb76a2e[ i ] );
                }
                
                self.clip[ i ] moveto( door_tag_origin, 0.1 );
                
                if ( time >= disconnect && var_4dcff7b91f7ed893 && isdefined( self.clip[ i ].spawnflags ) && self.clip[ i ].spawnflags == 1 )
                {
                    self.clip[ i ] disconnectpaths();
                }
            }
            
            time += 0.1;
            wait 0.1;
        }
        
        foreach ( egc in self.clip )
        {
            if ( var_4dcff7b91f7ed893 && isdefined( egc.spawnflags ) && egc.spawnflags == 1 )
            {
                egc disconnectpaths();
            }
        }
    }
    
    if ( isdefined( flag_close ) )
    {
        level utility::flag_set( flag_close );
    }
    
    foreach ( var_e4f6af52b1c0ae7c in self.a_gate_interact )
    {
        var_e4f6af52b1c0ae7c thread function_bfd9527bf6fdca81();
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x77c99c7f, Offset: 0x163b3
// Size: 0xce
function function_48742f1029c7bf98( b_start_red = 1 )
{
    level utility::flag_wait( "scriptables_ready" );
    interact = self;
    interact.var_7db9f2b3f965a94 = get_scriptable_array( interact.targetname + "_light", #targetname );
    interact.var_7ff3377610be4955 = get_scriptable_array( interact.targetname + "_light_red", #targetname );
    interact.var_5655a647de41a309 = get_scriptable_array( interact.targetname + "_light_green", #targetname );
    waitframe();
    
    if ( b_start_red )
    {
        interact thread function_bfd9527bf6fdca81();
        return;
    }
    
    interact thread function_5e8819aede1d0d5();
}

// Namespace gemini_util
// Params 1
// Checksum 0x77099a17, Offset: 0x16489
// Size: 0x14a
function function_bfd9527bf6fdca81( b_flashing = 0 )
{
    interact = self;
    
    if ( interact.var_7db9f2b3f965a94.size > 0 )
    {
        foreach ( lightprop in interact.var_7db9f2b3f965a94 )
        {
            part = undefined;
            
            if ( lightprop getscriptablehaspart( "elevator_light" ) )
            {
                part = "elevator_light";
            }
            else if ( lightprop getscriptablehaspart( "gate_light" ) )
            {
                part = "gate_light";
            }
            else if ( lightprop getscriptablehaspart( "bunkerdoor_light" ) )
            {
                part = "bunkerdoor_light";
            }
            
            if ( isdefined( part ) )
            {
                if ( b_flashing )
                {
                    lightprop utility::function_7c10ea82c1e305b8( part, "opening" );
                    continue;
                }
                
                lightprop utility::function_7c10ea82c1e305b8( part, "activated" );
            }
        }
    }
    
    interact function_a7c95e32438889ea( interact.var_5655a647de41a309, 0 );
    waitframe();
    interact function_a7c95e32438889ea( interact.var_7ff3377610be4955, 1 );
}

// Namespace gemini_util
// Params 0
// Checksum 0x51c5d40, Offset: 0x165db
// Size: 0x121
function function_5e8819aede1d0d5()
{
    interact = self;
    
    if ( interact.var_7db9f2b3f965a94.size > 0 )
    {
        foreach ( lightprop in interact.var_7db9f2b3f965a94 )
        {
            part = undefined;
            
            if ( lightprop getscriptablehaspart( "elevator_light" ) )
            {
                part = "elevator_light";
            }
            else if ( lightprop getscriptablehaspart( "gate_light" ) )
            {
                part = "gate_light";
            }
            else if ( lightprop getscriptablehaspart( "bunkerdoor_light" ) )
            {
                part = "bunkerdoor_light";
            }
            
            if ( isdefined( part ) )
            {
                lightprop utility::function_7c10ea82c1e305b8( part, "open" );
            }
        }
    }
    
    interact function_a7c95e32438889ea( interact.var_7ff3377610be4955, 0 );
    waitframe();
    interact function_a7c95e32438889ea( interact.var_5655a647de41a309, 1 );
}

// Namespace gemini_util
// Params 2
// Checksum 0x54ffc1cb, Offset: 0x16704
// Size: 0xf6
function function_a7c95e32438889ea( var_f6b0d948330fd524, b_light_on = 1 )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( var_f6b0d948330fd524.size == 0 )
    {
        return;
    }
    
    foreach ( light_controller in var_f6b0d948330fd524 )
    {
        if ( b_light_on )
        {
            if ( isdefined( light_controller.script_noteworthy ) )
            {
                light_controller utility::function_7c10ea82c1e305b8( "light_controller", light_controller.script_noteworthy );
            }
            else
            {
                light_controller utility::function_7c10ea82c1e305b8( "light_controller", "on" );
            }
            
            continue;
        }
        
        light_controller utility::function_7c10ea82c1e305b8( "light_controller", "off" );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x192d8a3d, Offset: 0x16802
// Size: 0x54
function function_bee9a4fd918f536d( e_scriptable )
{
    if ( isdefined( self.flag_endon ) && utility::flag( e_scriptable.flag_endon ) )
    {
        return;
    }
    
    player = self;
    
    if ( player isonground() )
    {
        player function_874ae377c3340ecc( e_scriptable, "sat_ges_button_press_01" );
    }
}

#using_animtree( "script_model" );

// Namespace gemini_util
// Params 2
// Checksum 0x6bd6d395, Offset: 0x1685e
// Size: 0x445
function function_874ae377c3340ecc( e_scriptable, str_gesture )
{
    player = self;
    
    if ( player isgestureplaying() )
    {
        return 0;
    }
    
    if ( player usinggamepad() == 0 && player getstance() == "crouch" )
    {
        return 0;
    }
    
    level endon( #"game_ended" );
    player endon( #"death" );
    player val::set( "button_press", "damageshield", 1 );
    player val::set( "button_press", "damage", 0 );
    
    if ( player getstance() == "prone" )
    {
        var_2521f6cde484f0f0 = 0;
        var_fa8f5be62fc0f09d = 0.2;
    }
    else
    {
        var_2521f6cde484f0f0 = 0.1;
        var_fa8f5be62fc0f09d = 0.3;
    }
    
    currentweapon = player getcurrentweapon();
    
    if ( !isdefined( currentweapon ) || isnullweapon( currentweapon ) )
    {
        player inventory_utility::_switchtoweaponimmediate( player.primaryweapons[ 0 ] );
    }
    
    blendintime = 0.2;
    gesturetime = 1;
    blendouttime = 0.2;
    player setstance( "stand", 1, 1 );
    player freezecontrols( 1 );
    waitframe();
    scriptable_left_dir = anglestoleft( e_scriptable.angles );
    scriptable_up_dir = anglestoup( e_scriptable.angles );
    var_199bf5088250e455 = anglestoforward( e_scriptable.angles );
    button_loc = e_scriptable.origin;
    button_loc += scriptable_left_dir * 7.5;
    button_loc += scriptable_up_dir * 47;
    button_loc += var_199bf5088250e455 * 1.5;
    var_10f50841c4b80477 = player.origin[ 2 ];
    var_a0fdf33906c8070 = button_loc + var_199bf5088250e455 * 50;
    var_a0fdf33906c8070 = ( var_a0fdf33906c8070[ 0 ], var_a0fdf33906c8070[ 1 ], var_10f50841c4b80477 );
    
    if ( !isdefined( player.temp_rig ) )
    {
        player.temp_rig = spawn( "script_arms", var_a0fdf33906c8070, 0, 0, player );
        player.temp_rig.animname = player.animname;
        player.temp_rig useanimtree( #animtree );
        player.temp_rig hide();
    }
    
    player thread player_gesture_disconnect_watcher();
    
    if ( !isdefined( player.temp_rig ) || !isdefined( player.temp_rig.model ) )
    {
        return 0;
    }
    
    var_29b6a15fd5ee6b1d = vectortoyaw( button_loc - var_a0fdf33906c8070 );
    
    if ( ( player.temp_rig.model ?? "" ) != "" && modelhastag( player.temp_rig.model, "tag_view" ) )
    {
        player_eye = player.temp_rig gettagorigin( "tag_view", 0, 1 );
    }
    else
    {
        player_eye = player.temp_rig.origin + ( 0, 0, player getplayerviewheight() );
    }
    
    pitch = vectortopitch( button_loc - ( var_a0fdf33906c8070[ 0 ], var_a0fdf33906c8070[ 1 ], player_eye[ 2 ] ) );
    var_ce375c32aa1eb857 = ( pitch, var_29b6a15fd5ee6b1d, player.angles[ 2 ] );
    player.temp_rig.angles = var_ce375c32aa1eb857;
    player endon( #"death_or_disconnect" );
    player playerlinktoblend( player.temp_rig, "tag_player", blendintime );
    wait blendintime - var_2521f6cde484f0f0;
    curweapon = utility::function_64003742d8f5c781( player getcurrentweapon() );
    
    if ( isdefined( curweapon ) && curweapon.basenamehash != %"none" )
    {
        player forceplaygestureviewmodel( str_gesture );
    }
    
    wait gesturetime - var_fa8f5be62fc0f09d;
    player playerunlinkblend( blendouttime );
    wait blendouttime;
    player freezecontrols( 0 );
    player notify( #"hash_e1983b910585c395" );
    
    if ( isdefined( player.temp_rig ) )
    {
        player.temp_rig delete();
    }
    
    player val::reset_all( "button_press" );
}

// Namespace gemini_util
// Params 0
// Checksum 0x49857cf6, Offset: 0x16cab
// Size: 0x6f
function player_gesture_disconnect_watcher()
{
    self notify( #"hash_893edcb0e476072d" );
    self endon( #"hash_893edcb0e476072d" );
    player = self;
    player endon( #"hash_e1983b910585c395" );
    player waittill( #"death_or_disconnect" );
    
    if ( isdefined( player.temp_rig ) )
    {
        player.temp_rig delete();
    }
    
    player val::reset_all( "button_press" );
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x84338b56, Offset: 0x16d22
    // Size: 0x5, Type: dev
    function function_e2b23025ab92d48b()
    {
        
    }

#/

// Namespace gemini_util
// Params 2
// Checksum 0x64dbac8d, Offset: 0x16d2f
// Size: 0x149
function ai_nerf( var_c93772d0d8fd27c4 = 2, var_361a087ab08adc1c = "walk" )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( utility::ent_flag( "ai_nerf" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "ai_nerf" );
    
    if ( isdefined( self.attackeraccuracy ) )
    {
        self.attackeraccuracy *= var_c93772d0d8fd27c4;
    }
    
    if ( self.type == "zombie" )
    {
        zombie_utils::function_a8ce00e0448cb6f0( var_361a087ab08adc1c, "nerf_zombie_speed", 50 );
        return;
    }
    
    self.baseaccuracy *= 0.5;
    ai::set_ai_max_health( int( self.health * 0.5 ) + 1 );
    
    if ( isdefined( self.armorhealth ) )
    {
        self.armorhealth = int( self.armorhealth * 0.5 ) + 1;
    }
    
    self.ignoresuppression = 1;
    self setcoverstate( "exposed" );
    self.balwayscoverexposed = 1;
    self.defaultcoverselector = %"cover_exposed_nodes";
    self requestcoverfind( 1, 1, %"cover_exposed_nodes" );
}

// Namespace gemini_util
// Params 1
// Checksum 0x8fa7dd1c, Offset: 0x16e80
// Size: 0x14c
function function_41bc1c00b63773ec( enc_name )
{
    if ( enc_name )
    {
        requestid = ai_spawn_director::lookup_spawn_request( enc_name );
        requestdata = function_9b649316adcccbaa( requestid );
        a_ai_soldier = requestdata.ai;
        
        if ( !a_ai_soldier || a_ai_soldier.size < 1 )
        {
            return;
        }
        
        if ( !isdefined( level.players ) || level.players.size < 1 )
        {
            return;
        }
        
        a_players_sorted = function_628bac9faa9d1e86( level.players, a_ai_soldier[ 0 ].origin );
        var_29f845a3122b4c0f = function_628bac9faa9d1e86( a_ai_soldier, a_players_sorted[ 0 ].origin );
    }
    else
    {
        if ( !isdefined( level.players ) || level.players.size < 1 )
        {
            return;
        }
        
        player_rand = utility::array_random( level.players );
        
        if ( !isdefined( player_rand ) )
        {
            return;
        }
        
        a_ai_soldier = getaiarrayinradius( player_rand.origin, 1500, "team_hundred_ninety" );
        
        if ( !a_ai_soldier || a_ai_soldier.size < 1 )
        {
            return;
        }
        
        var_29f845a3122b4c0f = function_628bac9faa9d1e86( a_ai_soldier, player_rand.origin );
    }
    
    ai_soldier_closest = var_29f845a3122b4c0f[ 0 ];
    return ai_soldier_closest;
}

// Namespace gemini_util
// Params 1
// Checksum 0x2c604cfe, Offset: 0x16fd5
// Size: 0x125
function function_cb3d5af3567a0360( dmg_struct )
{
    self endon( #"death" );
    idamage = dmg_struct.idamage;
    
    if ( !isdefined( self.zombie_dmg_multiplier ) )
    {
        self.zombie_dmg_multiplier = 2;
    }
    
    if ( !isdefined( self.var_dd8bd74f035284e2 ) )
    {
        self.var_dd8bd74f035284e2 = [];
    }
    
    if ( isdefined( dmg_struct.eattacker ) && dmg_struct.eattacker.type == "zombie" )
    {
        if ( !isdefined( self.zombie_hit_count ) )
        {
            self.zombie_hit_count = 1;
        }
        else
        {
            self.zombie_hit_count++;
        }
        
        self.var_dd8bd74f035284e2 = arraycombineunique( self.var_dd8bd74f035284e2, [ dmg_struct.eattacker ] );
        zombie_dmg_multiplier = self.zombie_dmg_multiplier * self.zombie_hit_count * self.var_dd8bd74f035284e2.size;
        idamage *= zombie_dmg_multiplier;
    }
    
    idamage = minint( int( self.maxhealth * 2 ), int( idamage ) );
    return idamage;
}

// Namespace gemini_util
// Params 0
// Checksum 0xa0244e19, Offset: 0x17103
// Size: 0x3c
function function_efa147552d0f3726()
{
    guild_soldier = self;
    guild_soldier.noragdoll = 1;
    guild_soldier.var_7bd2fc702f01b407 = 1;
    guild_soldier.var_ea900b480a55e803 = &function_197992c74bde9df3;
}

// Namespace gemini_util
// Params 1
// Checksum 0x33606ba4, Offset: 0x17147
// Size: 0x59
function function_197992c74bde9df3( corpseent )
{
    corpseent endon( #"death" );
    wait 0.9;
    var_dbe23f4abfd54b1a = utility::getfx( "vfx_sat_wc_ai_cradle_soldier_death_01" );
    
    if ( var_dbe23f4abfd54b1a )
    {
        playfx( var_dbe23f4abfd54b1a, corpseent.origin );
    }
    
    if ( corpseent )
    {
        corpseent delete();
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0x95a5f2a4, Offset: 0x171a8
// Size: 0x70
function function_7653e4bbe774fb50( struct )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    struct.ai_array = arraycombineunique( struct.ai_array, [ self ] );
    self waittill( #"death" );
    
    if ( arraycontains( struct.ai_array, self ) )
    {
        struct.ai_array = arrayremove( struct.ai_array, self );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xc226e4d1, Offset: 0x17220
// Size: 0x10c
function ai_array_cleanup( str_aitype_filter )
{
    assert( isstruct( self ), "<dev string:x59c>" );
    assert( isdefined( self.ai_array ), "<dev string:x5d1>" );
    self.ai_array = utility::array_removedead_or_dying( self.ai_array );
    
    if ( self.ai_array.size > 0 && isdefined( str_aitype_filter ) )
    {
        foreach ( ai in self.ai_array )
        {
            if ( isdefined( ai.basearchetype ) && ai.basearchetype != str_aitype_filter )
            {
                self.ai_array = arrayremove( self.ai_array, ai );
            }
        }
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x39c6cfce, Offset: 0x17334
    // Size: 0x5, Type: dev
    function function_49efd7275d8ca31f()
    {
        
    }

#/

// Namespace gemini_util
// Params 5
// Checksum 0xa475a702, Offset: 0x17341
// Size: 0x2a7
function setup_murderhole_shared_data( var_68b32a8bafee7061 = "game_ended", var_eb00f0a0f47446de, str_idle_structs, str_trig_close, str_trig_safe )
{
    if ( !isdefined( a_cover_objects ) )
    {
        a_cover_objects = [];
    }
    
    murderhole_data = spawnstruct();
    murderhole_data.var_68b32a8bafee7061 = var_68b32a8bafee7061;
    murderhole_data.cover_objects = getentarray( var_eb00f0a0f47446de, #script_noteworthy );
    murderhole_data.turret_weapon = "sat_ob_turret_gemini";
    murderhole_data.turret_model = "sat_ob_invis_turret";
    murderhole_data.firing_mode = "manual";
    murderhole_data.fire_rate = 0.2;
    murderhole_data.var_15668cb175b97ea3 = squared( 420 );
    murderhole_data.var_aa2fdeb985d20efd = squared( 2816 );
    murderhole_data.var_d5e8629c8341c9b3 = 0.1;
    murderhole_data.lerp_factor_slow = 0.2;
    murderhole_data.lerp_factor_med = 0.4;
    murderhole_data.lerp_factor_fast = 0.6;
    murderhole_data.var_bb908d6e9d233e08 = 0.7;
    murderhole_data.player_team = player_get_team();
    murderhole_data.var_61b2171dfe09b772 = utility::function_4b74c15943231980( 4 );
    murderhole_data.var_618f211dfde385b8 = utility::function_4b74c15943231980( 6 );
    murderhole_data.var_7f24f21dbe8a7e25 = squared( 32 );
    murderhole_data.var_ba6da73ae06d56a6 = 1;
    murderhole_data.var_4ccadad193c7f228 = 3;
    
    if ( isdefined( str_idle_structs ) )
    {
        a_idle_structs = utility::getstructarray( str_idle_structs, "targetname" );
        murderhole_data.var_b0ed9a16564536fd = a_idle_structs;
    }
    else
    {
        murderhole_data.var_b0ed9a16564536fd = [];
    }
    
    if ( isdefined( str_trig_close ) )
    {
        trig_close = getnoentvolumearray( str_trig_close, #targetname )[ 0 ];
        murderhole_data.trig_close = trig_close;
    }
    else
    {
        murderhole_data.trig_close = undefined;
    }
    
    if ( isdefined( str_trig_safe ) )
    {
        trig_safe = getnoentvolumearray( str_trig_safe, #targetname )[ 0 ];
        murderhole_data.trig_safe = trig_safe;
    }
    else
    {
        murderhole_data.trig_safe = undefined;
    }
    
    murderhole_data.var_ecd654f5cb5c92d2 = 5;
    murderhole_data.var_ecb25ef5cb342e18 = 25;
    murderhole_data.burst_delay_min = 2;
    murderhole_data.burst_delay_max = 4;
    return murderhole_data;
}

// Namespace gemini_util
// Params 3
// Checksum 0xf0e1916d, Offset: 0x175f1
// Size: 0x116
function function_c8fde0e84ad9d3( str_source_structs, murderhole_data, flag_endon )
{
    activity_instance = self;
    turret_spawn_structs = utility::getstructarray( str_source_structs, "targetname" );
    
    if ( !isdefined( turret_spawn_structs ) )
    {
        println( "<dev string:x5fa>" );
        return;
    }
    
    var_563c84cd7c4fb595 = [];
    
    foreach ( turret_spawn_struct in turret_spawn_structs )
    {
        turret_owner = spawn_turret_aim_ent( turret_spawn_struct );
        turret = spawn_turret( turret_spawn_struct, murderhole_data, turret_owner );
        turret thread function_a3c7b07a669615df( turret_spawn_struct, murderhole_data, turret_owner, flag_endon );
        turret thread function_91a64db2cf8239f3( turret_spawn_struct, murderhole_data, turret_owner, 1 );
        var_563c84cd7c4fb595[ var_563c84cd7c4fb595.size ] = turret;
        waitframe();
    }
    
    return var_563c84cd7c4fb595;
}

// Namespace gemini_util
// Params 2
// Checksum 0x4b82e556, Offset: 0x17710
// Size: 0x25c
function setup_murderhole_turrets( str_source_structs, murderhole_data )
{
    activity_instance = self;
    turret_spawn_structs = utility::getstructarray( str_source_structs, "targetname" );
    
    if ( !isdefined( turret_spawn_structs ) )
    {
        println( "<dev string:x63b>" );
        return;
    }
    
    level.onplayerdamaged = &function_f6e1830e5e2f98f5;
    players = ob_story_mission_utils::get_playing_players();
    
    foreach ( player in players )
    {
        player thread function_a1bd31165a77989( murderhole_data.var_68b32a8bafee7061 );
    }
    
    var_a32d264e723d415 = getentarray( "trig_damage_minecarts_murderhole", #targetname );
    
    foreach ( trig_damage in var_a32d264e723d415 )
    {
        trig_damage thread function_be53fdbe21e558c9( murderhole_data.var_68b32a8bafee7061 );
    }
    
    if ( players.size < 3 || level.is_squad_size_small )
    {
        turret_spawn_structs = utility::array_slice_random( turret_spawn_structs, 1 );
    }
    
    var_563c84cd7c4fb595 = [];
    
    foreach ( turret_spawn_struct in turret_spawn_structs )
    {
        turret_owner = spawn_turret_aim_ent( turret_spawn_struct );
        turret = spawn_turret( turret_spawn_struct, murderhole_data, turret_owner );
        turret thread turret_target_think( turret_spawn_struct, murderhole_data, turret_owner );
        turret thread function_91a64db2cf8239f3( turret_spawn_struct, murderhole_data, turret_owner );
        var_563c84cd7c4fb595[ var_563c84cd7c4fb595.size ] = turret;
        waitframe();
    }
    
    return var_563c84cd7c4fb595;
}

// Namespace gemini_util
// Params 1
// Checksum 0xd8fb2384, Offset: 0x17975
// Size: 0x91
function spawn_turret_aim_ent( turret_spawn_struct )
{
    var_a648afea39238b85 = utility::spawn_script_origin( turret_spawn_struct.origin );
    var_ed92d3edd3eded9 = utility::getstruct( turret_spawn_struct.target, "targetname" );
    
    if ( isdefined( var_ed92d3edd3eded9 ) )
    {
        var_a648afea39238b85.origin = var_ed92d3edd3eded9.origin;
    }
    
    var_a648afea39238b85.health = 9999;
    var_a648afea39238b85 makeentitysentient( "team_hundred_ninety" );
    var_a648afea39238b85.ignoreme = 1;
    return var_a648afea39238b85;
}

// Namespace gemini_util
// Params 3
// Checksum 0xb8f50ba8, Offset: 0x17a0f
// Size: 0x156
function spawn_turret( turret_spawn_struct, murderhole_data, turret_owner )
{
    weaponorigin = spawn( "script_model", turret_spawn_struct.origin );
    weaponorigin setmodel( "tag_origin" );
    weaponorigin.angles = turret_spawn_struct.angles;
    turretweapon = spawnturret( "misc_turret", turret_spawn_struct.origin, murderhole_data.turret_weapon );
    turretweapon setmodel( murderhole_data.turret_model );
    turretweapon.angles = weaponorigin.angles;
    turretweapon linkto( weaponorigin );
    turretweapon turretfireenable();
    turretweapon setmode( murderhole_data.firing_mode );
    turretweapon setnodeploy( 1 );
    turretweapon maketurretinoperable();
    turretweapon setusableenabled( 0 );
    turretweapon.script_model = weaponorigin;
    turretweapon.owner = turret_owner;
    turretweapon.player_target = undefined;
    turretweapon.current_target = undefined;
    turretweapon.laser_active = 0;
    turretweapon.target_ent = turretweapon.owner;
    turretweapon settargetentity( turretweapon.target_ent );
    return turretweapon;
}

// Namespace gemini_util
// Params 4
// Checksum 0xb30f6549, Offset: 0x17b6e
// Size: 0x37f
function function_a3c7b07a669615df( turret_spawn_struct, murderhole_data, turret_owner, flag_endon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( murderhole_data.activity_instance ) )
    {
        murderhole_data.activity_instance endon( #"activity_ended", #"instance_destroyed" );
    }
    
    /#
        iprintln( "<dev string:x677>" );
    #/
    
    turret = self;
    turret.var_e03c32786aacfda = [];
    shutdown_delay = randomintrange( 1, 3 );
    current_target = undefined;
    var_52a695d87aec927c = undefined;
    idle_struct_move_time = undefined;
    idle_struct_move_delay = randomfloatrange( 2, 4 );
    turret.idle_count = 0;
    turret.var_4ce2be89357100be = 0;
    b_stop_turret = 0;
    
    if ( !turret.laser_active )
    {
        turret laseron();
        turret laserforceon();
        turret.laser_active = 1;
    }
    
    while ( shutdown_delay > 0 )
    {
        var_60ab41322253e19f = 0.9;
        best_target = turret function_238f93c0d4f6439a( murderhole_data, turret_owner );
        
        if ( isdefined( best_target ) )
        {
            turret.idle_count = 0;
            
            if ( best_target != turret.current_target )
            {
                turret.current_target = undefined;
                
                if ( turret.current_target.var_f9ef82ee1c700ead == turret )
                {
                    turret.current_target.var_f9ef82ee1c700ead = undefined;
                }
                
                turret.current_target = best_target;
                best_target.var_f9ef82ee1c700ead = turret;
                best_target thread function_88a8ea663eac6b6c( turret, murderhole_data.var_68b32a8bafee7061 );
            }
            
            var_60ab41322253e19f = murderhole_data.var_bb908d6e9d233e08;
        }
        else
        {
            turret.current_target = undefined;
            var_60ab41322253e19f = murderhole_data.lerp_factor_med;
            
            if ( turret.current_target.var_f9ef82ee1c700ead == turret )
            {
                turret.current_target.var_f9ef82ee1c700ead = undefined;
            }
        }
        
        if ( isdefined( turret.current_target ) )
        {
            target_pos = turret function_d470ce0000c3c770( turret.current_target, murderhole_data, var_60ab41322253e19f );
            turret.target_ent moveto( target_pos, murderhole_data.fire_rate );
        }
        else
        {
            turret.idle_count++;
        }
        
        wait murderhole_data.fire_rate;
        
        if ( turret.var_4ce2be89357100be > 1 && turret.idle_count > 12 || turret.var_4ce2be89357100be > 12 )
        {
            b_stop_turret = 1;
        }
        
        if ( utility::flag( murderhole_data.var_68b32a8bafee7061 ) || utility::flag( flag_endon ) || b_stop_turret )
        {
            shutdown_delay--;
        }
    }
    
    /#
        iprintln( "<dev string:x694>" );
    #/
    
    if ( turret.laser_active )
    {
        turret laseroff();
        turret laserforceoff();
    }
    
    turret cleartargetentity();
    turret notify( #"turret_stop_shooting" );
    waitframe();
    
    if ( isdefined( turret_owner ) )
    {
        turret_owner delete();
    }
    
    if ( isdefined( turret.script_model ) )
    {
        turret.script_model delete();
    }
    
    waitframe();
    turret delete();
}

// Namespace gemini_util
// Params 3
// Checksum 0x1c6d60eb, Offset: 0x17ef5
// Size: 0x5ca
function turret_target_think( turret_spawn_struct, murderhole_data, turret_owner )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( murderhole_data.activity_instance ) )
    {
        murderhole_data.activity_instance endon( #"activity_ended", #"instance_destroyed" );
    }
    
    turret = self;
    turret_spawn_struct.turret = turret;
    turret_spawn_struct.var_b6d07bd629f855 = 0;
    
    /#
        iprintln( "<dev string:x6b3>" );
    #/
    
    turret.var_e03c32786aacfda = [];
    shutdown_delay = randomintrange( 4, 10 );
    current_target = undefined;
    var_52a695d87aec927c = undefined;
    idle_struct_move_time = undefined;
    idle_struct_move_delay = randomfloatrange( 3, 8 );
    
    if ( !turret.laser_active )
    {
        turret laseron();
        turret laserforceon();
        turret.laser_active = 1;
    }
    
    while ( shutdown_delay > 0 )
    {
        var_60ab41322253e19f = 0.1;
        best_target = turret turret_get_best_target( murderhole_data, turret_owner );
        
        if ( isdefined( best_target ) )
        {
            if ( best_target != turret.current_target )
            {
                turret.current_target = undefined;
                
                if ( turret.current_target.var_f9ef82ee1c700ead == turret )
                {
                    turret.current_target.var_f9ef82ee1c700ead = undefined;
                }
                
                if ( isplayer( best_target ) )
                {
                    best_target thread function_a1bd31165a77989( murderhole_data.var_68b32a8bafee7061 );
                    turret.player_target = best_target;
                    turret notify( #"new_player_target" );
                }
                else
                {
                    turret.var_7fa368bdb330f23 = undefined;
                    turret.var_46df510634c65870 = undefined;
                    turret.player_target = undefined;
                }
                
                turret.current_target = best_target;
                best_target.var_f9ef82ee1c700ead = turret;
            }
            
            a_guild_enemies = getaiarray( "team_hundred_ninety" );
            
            if ( level utility::flag( "flag_prison_minecarts_side_cart_end" ) || utility::flag( "flag_minecarts_armory_entrance" ) || a_guild_enemies.size <= 0 )
            {
                var_60ab41322253e19f = murderhole_data.var_d5e8629c8341c9b3;
            }
            else if ( isdefined( murderhole_data.trig_close ) && turret.current_target istouching( murderhole_data.trig_close ) )
            {
                if ( isplayer( turret.current_target ) )
                {
                    var_60ab41322253e19f = murderhole_data.lerp_factor_fast;
                }
                else
                {
                    var_60ab41322253e19f = murderhole_data.lerp_factor_med;
                }
            }
            else if ( isplayer( turret.current_target ) )
            {
                var_60ab41322253e19f = murderhole_data.lerp_factor_med;
            }
            else
            {
                var_60ab41322253e19f = murderhole_data.lerp_factor_slow;
            }
        }
        else
        {
            turret.current_target = undefined;
            turret.var_7fa368bdb330f23 = undefined;
            turret.var_46df510634c65870 = undefined;
            turret.player_target = undefined;
            var_60ab41322253e19f = murderhole_data.lerp_factor_slow;
            
            if ( turret.current_target.var_f9ef82ee1c700ead == turret )
            {
                turret.current_target.var_f9ef82ee1c700ead = undefined;
            }
        }
        
        if ( isdefined( turret.current_target ) )
        {
            if ( isdefined( turret.var_46df510634c65870 ) && isdefined( turret.var_7fa368bdb330f23 ) && isplayer( turret.current_target ) )
            {
                if ( isdefined( turret.var_d084b5a41635d73d ) && gettime() - turret.var_46df510634c65870 > turret.var_d084b5a41635d73d * 0.5 )
                {
                    var_60ab41322253e19f = murderhole_data.lerp_factor_slow;
                    target_pos = turret.var_7fa368bdb330f23 + ( randomfloatrange( -128, 128 ), randomfloatrange( -128, 128 ), 0 );
                }
                else
                {
                    var_60ab41322253e19f = murderhole_data.lerp_factor_med;
                    target_pos = turret.var_7fa368bdb330f23;
                }
                
                target_pos = turret function_d470ce0000c3c770( turret.var_7fa368bdb330f23, murderhole_data, var_60ab41322253e19f );
            }
            else
            {
                target_pos = turret function_d470ce0000c3c770( turret.current_target, murderhole_data, var_60ab41322253e19f );
            }
            
            turret.target_ent moveto( target_pos, murderhole_data.fire_rate );
        }
        else if ( isdefined( murderhole_data.var_b0ed9a16564536fd ) && murderhole_data.var_b0ed9a16564536fd.size > 0 )
        {
            if ( !isdefined( var_52a695d87aec927c ) || !isdefined( idle_struct_move_time ) || gettime() - idle_struct_move_time > idle_struct_move_delay )
            {
                var_52a695d87aec927c = utility::array_random( murderhole_data.var_b0ed9a16564536fd );
                idle_struct_move_time = gettime();
                idle_struct_move_delay = randomfloatrange( 3, 8 );
            }
            
            var_60ab41322253e19f = murderhole_data.lerp_factor_slow;
            target_pos = turret function_d470ce0000c3c770( var_52a695d87aec927c.origin, murderhole_data, var_60ab41322253e19f );
            turret.target_ent moveto( target_pos, murderhole_data.fire_rate );
        }
        
        wait murderhole_data.fire_rate;
        
        if ( utility::flag( murderhole_data.var_68b32a8bafee7061 ) )
        {
            shutdown_delay--;
        }
    }
    
    /#
        iprintln( "<dev string:x6cb>" );
    #/
    
    turret_spawn_struct.var_b6d07bd629f855 = 1;
    
    if ( turret.laser_active )
    {
        turret laseroff();
        turret laserforceoff();
        turret.laser_active = 0;
    }
    
    turret cleartargetentity();
    turret notify( #"turret_stop_shooting" );
    waitframe();
    
    if ( isdefined( turret_owner ) )
    {
        turret_owner delete();
    }
    
    if ( isdefined( turret.script_model ) )
    {
        turret.script_model delete();
    }
    
    waitframe();
    turret delete();
}

// Namespace gemini_util
// Params 2
// Checksum 0x359807a2, Offset: 0x184c7
// Size: 0x78
function function_238f93c0d4f6439a( murderhole_data, turret_owner )
{
    turret = self;
    
    if ( isdefined( turret.current_target ) && turret function_9e08c3510c901db0( turret.current_target, murderhole_data ) )
    {
        return turret.current_target;
    }
    
    var_f792509d72a84f58 = turret function_d6c1991057afc823( murderhole_data, turret_owner, 1 );
    
    if ( isdefined( var_f792509d72a84f58 ) )
    {
        return var_f792509d72a84f58;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0xf3ce2a7b, Offset: 0x18548
// Size: 0x101
function turret_get_best_target( murderhole_data, turret_owner )
{
    turret = self;
    
    if ( isdefined( turret.current_target ) && isplayer( turret.current_target ) && !level utility::flag( "flag_prison_minecarts_side_cart_end" ) && turret function_9e08c3510c901db0( turret.current_target, murderhole_data ) )
    {
        return turret.current_target;
    }
    else
    {
        player_target = turret function_4afec70abea0a832( murderhole_data );
        
        if ( isdefined( player_target ) )
        {
            return player_target;
        }
    }
    
    if ( isdefined( turret.current_target ) && !isplayer( turret.current_target ) && turret function_9e08c3510c901db0( turret.current_target, murderhole_data ) )
    {
        return turret.current_target;
    }
    
    var_f792509d72a84f58 = turret function_d6c1991057afc823( murderhole_data, turret_owner );
    
    if ( isdefined( var_f792509d72a84f58 ) )
    {
        return var_f792509d72a84f58;
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0xc8fddf13, Offset: 0x18652
// Size: 0xfb
function function_d470ce0000c3c770( current_target, murderhole_data, var_60ab41322253e19f )
{
    turret = self;
    
    if ( isvector( current_target ) )
    {
        origin = current_target;
    }
    else
    {
        origin = function_32a445b7c3c42bc2( current_target );
    }
    
    dist = distancesquared( self.target_ent.origin, origin );
    
    if ( dist < murderhole_data.var_7f24f21dbe8a7e25 )
    {
        return origin;
    }
    
    target_pos = ( math::lerp( turret.target_ent.origin[ 0 ], origin[ 0 ], var_60ab41322253e19f ), math::lerp( turret.target_ent.origin[ 1 ], origin[ 1 ], var_60ab41322253e19f ), math::lerp( turret.target_ent.origin[ 2 ], origin[ 2 ], var_60ab41322253e19f ) );
    return target_pos;
}

// Namespace gemini_util
// Params 1, eflags: 0x4
// Checksum 0x61aacb5d, Offset: 0x18756
// Size: 0x111
function private function_32a445b7c3c42bc2( current_target )
{
    origin = current_target.origin;
    
    if ( isplayer( current_target ) )
    {
        if ( isdefined( self.trig_close ) && current_target istouching( self.trig_close ) && !level utility::flag( "flag_prison_minecarts_side_cart_end" ) )
        {
            tag = "tag_eye";
        }
        else
        {
            tag = "j_spine4";
        }
        
        if ( current_target tagexists( tag ) )
        {
            origin = current_target gettagorigin( tag );
        }
        else
        {
            origin += ( 0, 0, 32 );
        }
    }
    else if ( isai( current_target ) )
    {
        if ( current_target tagexists( "j_spine4" ) )
        {
            origin = current_target gettagorigin( "j_spine4" );
        }
        else
        {
            origin += ( 0, 0, 32 );
        }
    }
    else if ( isdefined( self.cover_objects ) && arraycontains( self.cover_objects, current_target ) )
    {
        origin += ( 0, 0, 48 );
    }
    
    return origin;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0xf63c04b5, Offset: 0x18870
// Size: 0x108
function private function_4afec70abea0a832( murderhole_data, targetrange )
{
    turret = self;
    potentialplayertargets = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( potentialplayertargets.size > 0 )
    {
        potentialplayertargets = sortbydistance( potentialplayertargets, turret.origin );
        
        foreach ( player in potentialplayertargets )
        {
            if ( isdefined( player.var_f9ef82ee1c700ead ) && player.var_f9ef82ee1c700ead != turret )
            {
                continue;
            }
            
            can_shoot = turret function_7dc1437e2c6bf207( player, murderhole_data );
            
            if ( !can_shoot )
            {
                continue;
            }
            
            besttarget = player;
            break;
        }
    }
    
    return besttarget;
}

// Namespace gemini_util
// Params 3, eflags: 0x4
// Checksum 0x4dc6ca2a, Offset: 0x18981
// Size: 0x17a
function private function_d6c1991057afc823( murderhole_data, turret_owner, b_fake = 0 )
{
    turret = self;
    var_6cb9200a36f75518 = getaiarray( murderhole_data.player_team );
    
    if ( isdefined( murderhole_data.cover_objects ) )
    {
        var_6cb9200a36f75518 = arraycombineunique( var_6cb9200a36f75518, murderhole_data.cover_objects );
    }
    
    if ( var_6cb9200a36f75518.size > 0 )
    {
        var_6cb9200a36f75518 = sortbydistance( var_6cb9200a36f75518, turret_owner.origin );
        
        foreach ( zombie in var_6cb9200a36f75518 )
        {
            if ( isdefined( zombie.var_f9ef82ee1c700ead ) && zombie.var_f9ef82ee1c700ead != turret )
            {
                continue;
            }
            
            if ( zombie utility::ent_flag( "scene_active" ) || zombie utility::ent_flag( "spawn_animating" ) )
            {
                continue;
            }
            
            if ( b_fake )
            {
                can_shoot = turret function_a1dcfa3a1ac3f403( zombie, murderhole_data );
            }
            else
            {
                can_shoot = turret function_7dc1437e2c6bf207( zombie, murderhole_data );
            }
            
            if ( !can_shoot )
            {
                continue;
            }
            
            besttarget = zombie;
            break;
        }
    }
    
    return besttarget;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x8c600bb8, Offset: 0x18b04
// Size: 0x151, Type: bool
function private function_9e08c3510c901db0( target, murderhole_data )
{
    turret = self;
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        if ( player::isinlaststand( target ) || target.murderhole_protection )
        {
            turret.var_7fa368bdb330f23 = undefined;
            turret.var_46df510634c65870 = undefined;
            return false;
        }
        
        if ( turret function_7dc1437e2c6bf207( target, murderhole_data ) )
        {
            turret.var_7fa368bdb330f23 = target.origin;
            turret.var_46df510634c65870 = undefined;
            return true;
        }
        else if ( !isdefined( turret.var_46df510634c65870 ) )
        {
            turret.var_46df510634c65870 = gettime();
            turret.var_d084b5a41635d73d = randomfloatrange( murderhole_data.var_61b2171dfe09b772, murderhole_data.var_618f211dfde385b8 );
            return true;
        }
        else if ( gettime() - turret.var_46df510634c65870 > turret.var_d084b5a41635d73d )
        {
            turret.var_7fa368bdb330f23 = undefined;
            turret.var_46df510634c65870 = undefined;
            return false;
        }
        else
        {
            return true;
        }
    }
    else if ( turret function_7dc1437e2c6bf207( target, murderhole_data ) )
    {
        return true;
    }
    
    turret.var_7fa368bdb330f23 = undefined;
    turret.var_46df510634c65870 = undefined;
    return false;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x70104b2b, Offset: 0x18c5e
// Size: 0x7e, Type: bool
function private function_a1dcfa3a1ac3f403( target, murderhole_data )
{
    turret = self;
    turret_origin = turret gettagorigin( "tag_flash" );
    target_origin = function_32a445b7c3c42bc2( target );
    trace = trace::ray_trace( turret_origin, target_origin, turret.var_e03c32786aacfda, undefined, 0, 1, 1 );
    
    if ( trace[ "entity" ] == target )
    {
        return true;
    }
    
    return false;
}

// Namespace gemini_util
// Params 2, eflags: 0x4
// Checksum 0x2b497818, Offset: 0x18ce5
// Size: 0x138, Type: bool
function private function_7dc1437e2c6bf207( target, murderhole_data )
{
    turret = self;
    
    if ( isplayer( target ) )
    {
        if ( !isdefined( target ) || player::isinlaststand( target ) || target.murderhole_protection )
        {
            return false;
        }
    }
    
    if ( isdefined( murderhole_data.trig_safe ) && target istouching( murderhole_data.trig_safe ) )
    {
        return false;
    }
    
    turret_origin = turret gettagorigin( "tag_flash" );
    target_origin = function_32a445b7c3c42bc2( target );
    trace = trace::ray_trace( turret_origin, target_origin, turret.var_e03c32786aacfda, undefined, 0, 1, 1 );
    
    if ( trace[ "entity" ] == target )
    {
        dist = distancesquared( target.origin, turret.origin );
        
        if ( isplayer( target ) )
        {
            if ( dist > murderhole_data.var_15668cb175b97ea3 && dist < murderhole_data.var_aa2fdeb985d20efd )
            {
                return true;
            }
        }
        else if ( dist > murderhole_data.var_15668cb175b97ea3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gemini_util
// Params 4
// Checksum 0x291b19d9, Offset: 0x18e26
// Size: 0x521
function function_91a64db2cf8239f3( turret_spawn_struct, murderhole_data, turret_owner, var_4b71d830b72d5bb3 = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death", #"turret_stop_shooting" );
    
    if ( isdefined( murderhole_data.activity_instance ) )
    {
        murderhole_data.activity_instance endon( #"activity_ended", #"instance_destroyed" );
    }
    
    turret = self;
    n_shots = 0;
    var_7d2c16cf6935c87f = randomintrange( murderhole_data.var_ecd654f5cb5c92d2, murderhole_data.var_ecb25ef5cb342e18 );
    
    while ( true )
    {
        if ( turret_spawn_struct utility::ent_flag( "flag_minecarts_murderhole_pause" ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( turret.current_target ) )
        {
            if ( var_4b71d830b72d5bb3 || isdefined( murderhole_data.trig_close ) && turret.current_target istouching( murderhole_data.trig_close ) && !utility::flag( "flag_minecarts_armory_entrance" ) )
            {
                turret shootturret( undefined, murderhole_data.var_4ccadad193c7f228 );
            }
            else
            {
                turret shootturret( undefined, murderhole_data.var_ba6da73ae06d56a6 );
            }
            
            n_shots++;
        }
        
        /#
            if ( getdvarint( @"scr_murderhole_debug", 0 ) )
            {
                color = ( 0, 1, 0 );
                
                if ( isdefined( turret.current_target ) )
                {
                    if ( isent( turret.current_target ) )
                    {
                        ent_num = turret.current_target getentitynumber();
                    }
                    else
                    {
                        ent_num = "<dev string:x6e5>";
                    }
                    
                    if ( isplayer( turret.current_target ) )
                    {
                        if ( isdefined( turret.var_46df510634c65870 ) )
                        {
                            color = ( 1, 0.5, 0 );
                            turret thread function_fb2d2ce798d613b2( "<dev string:x6e9>" + ent_num, turret.origin + ( 0, 0, 64 ), color, 1, 2, murderhole_data.fire_rate );
                        }
                        else
                        {
                            color = ( 1, 0, 0 );
                            turret thread function_fb2d2ce798d613b2( "<dev string:x703>" + ent_num, turret.origin + ( 0, 0, 64 ), color, 1, 2, murderhole_data.fire_rate );
                        }
                    }
                    else if ( arraycontains( murderhole_data.cover_objects, turret.current_target ) )
                    {
                        color = ( 1, 0, 1 );
                        turret thread function_fb2d2ce798d613b2( "<dev string:x716>" + ent_num, turret.origin + ( 0, 0, 64 ), color, 1, 2, murderhole_data.fire_rate );
                    }
                    else
                    {
                        color = ( 1, 1, 0 );
                        turret thread function_fb2d2ce798d613b2( "<dev string:x72b>" + ent_num, turret.origin + ( 0, 0, 64 ), color, 1, 2, murderhole_data.fire_rate );
                    }
                }
                else
                {
                    color = ( 0, 1, 0 );
                    turret thread function_fb2d2ce798d613b2( "<dev string:x73e>", turret.origin + ( 0, 0, 64 ), color, 1, 2, murderhole_data.fire_rate );
                }
                
                level thread debug_utility::drawsphere( turret.origin, 8, murderhole_data.fire_rate, color );
                
                if ( isdefined( turret.target_ent ) )
                {
                    turret thread function_b3849c2107fe5869( turret.target_ent.origin, 4, murderhole_data.fire_rate, color );
                    turret thread function_387f34b54f5db86( turret.origin, turret.target_ent.origin, murderhole_data.fire_rate, color );
                }
            }
        #/
        
        var_7d2c16cf6935c87f = randomintrange( murderhole_data.var_ecd654f5cb5c92d2, murderhole_data.var_ecb25ef5cb342e18 );
        
        if ( !isdefined( turret.current_target ) || n_shots > var_7d2c16cf6935c87f && !isdefined( turret.player_target ) )
        {
            n_burst_delay = randomfloatrange( murderhole_data.burst_delay_min, murderhole_data.burst_delay_max );
            
            if ( var_4b71d830b72d5bb3 )
            {
                n_burst_delay *= 0.1;
            }
            
            /#
                if ( getdvarint( @"scr_murderhole_debug", 0 ) )
                {
                    color = ( 0, 0, 1 );
                    turret thread function_fb2d2ce798d613b2( "<dev string:x74d>", turret.origin + ( 0, 0, 64 ), color, 1, 2, n_burst_delay, "<dev string:x757>" );
                    turret thread function_b3849c2107fe5869( turret.origin, 8, n_burst_delay, color, "<dev string:x757>" );
                }
            #/
            
            turret utility::waittill_notify_or_timeout( "new_player_target", n_burst_delay );
            n_shots = 0;
        }
        
        wait murderhole_data.fire_rate;
    }
}

/#

    // Namespace gemini_util
    // Params 8
    // Checksum 0xc332f787, Offset: 0x1934f
    // Size: 0xb8, Type: dev
    function function_fb2d2ce798d613b2( text, origin, color, alpha, scale, duration, endonevent, var_5bf65afe54040850 )
    {
        if ( !isdefined( var_5bf65afe54040850 ) )
        {
            var_5bf65afe54040850 = 1;
        }
        
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        endtime = gettime() + duration * 1000;
        
        while ( gettime() < endtime )
        {
            print3d( origin, text, color, alpha, scale, var_5bf65afe54040850 );
            timesec = var_5bf65afe54040850 * level.framedurationseconds;
            wait timesec;
        }
    }

    // Namespace gemini_util
    // Params 5
    // Checksum 0x3c950df8, Offset: 0x1940f
    // Size: 0x88, Type: dev
    function function_b3849c2107fe5869( origin, radius, drawtimeseconds, color, endonevent )
    {
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            waitframe();
        }
    }

    // Namespace gemini_util
    // Params 5
    // Checksum 0xde53ded3, Offset: 0x1949f
    // Size: 0x88, Type: dev
    function function_387f34b54f5db86( start, end, drawtimeseconds, color, endonevent )
    {
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            line( start, end, color );
            waitframe();
        }
    }

#/

// Namespace gemini_util
// Params 1
// Checksum 0x24a3101f, Offset: 0x1952f
// Size: 0xf8
function function_be53fdbe21e558c9( flag_endon = "game_ended" )
{
    level endon( flag_endon );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction, point, damagetype, modelname, tagname, partname, idflags, objweapon );
        
        if ( damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_EXPLOSIVE_BULLET" || damagetype == "MOD_GRENADE" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_PROJECTILE_SPLASH" )
        {
            wait 0.1;
            continue;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker notify( #"hash_8724f8903a5db254" );
        }
        
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 15, eflags: 0x4
// Checksum 0xa110cc7b, Offset: 0x1962f
// Size: 0xaa
function private function_f6e1830e5e2f98f5( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, lightarmordamage )
{
    if ( objweapon.basename == "sat_ob_turret_gemini" )
    {
        self notify( #"hash_f856e9f9429f45c1" );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xa436f1f7, Offset: 0x196e1
// Size: 0xa9
function function_a1bd31165a77989( flag_endon = "game_ended" )
{
    level endon( flag_endon );
    
    if ( utility::ent_flag( "player_murderhole_killed_monitor" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "player_murderhole_killed_monitor" );
    self.murderhole_protection = 0;
    
    while ( true )
    {
        self waittill( #"death", attacker, meansofdeath, objweapon );
        
        if ( isdefined( objweapon ) && getweaponbasename( objweapon ) == "sat_ob_turret_gemini" )
        {
            if ( !self.murderhole_protection )
            {
                thread function_6adada98a96a5881( flag_endon );
            }
        }
        
        wait 0.1;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x25fa1415, Offset: 0x19792
// Size: 0x75
function function_88a8ea663eac6b6c( turret, flag_endon = "game_ended" )
{
    level endon( flag_endon );
    self waittill( #"death", attacker, meansofdeath, objweapon );
    
    if ( isdefined( objweapon ) && getweaponbasename( objweapon ) == "sat_ob_turret_gemini" )
    {
        turret.var_4ce2be89357100be++;
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x4dc38182, Offset: 0x1980f
// Size: 0x61
function function_6adada98a96a5881( flag_endon = "game_ended", f_time = 3 )
{
    level endon( flag_endon );
    self.murderhole_protection = 1;
    
    while ( f_time >= 0 )
    {
        f_time -= 1;
        wait 1;
    }
    
    self.murderhole_protection = 0;
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x7e840e66, Offset: 0x19878
    // Size: 0x5, Type: dev
    function function_b3d28d8950d59eb3()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0x4f8d64aa, Offset: 0x19885
// Size: 0xec
function gemini_hide_minimap()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player thread function_f6dfff807c87079();
    }
    
    if ( !callback::exists( #"player_spawned", &function_f6dfff807c87079 ) )
    {
        callback::add( #"player_spawned", &function_f6dfff807c87079 );
    }
    
    utility::flag_wait( "flag_player_show_minimap" );
    
    if ( callback::exists( #"player_spawned", &function_f6dfff807c87079 ) )
    {
        callback::remove( #"player_spawned", &function_f6dfff807c87079 );
    }
}

// Namespace gemini_util
// Params 1
// Checksum 0xcbcadab7, Offset: 0x19979
// Size: 0x3c
function function_f6dfff807c87079( params )
{
    self endon( #"death_or_disconnect" );
    player::showminimap();
    player::hideminimap( 1 );
    level waittill( #"flag_player_show_minimap" );
    player::showminimap();
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0x6feaf8e6, Offset: 0x199bd
    // Size: 0x5, Type: dev
    function function_2d8173b29358884()
    {
        
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xab11dbc8, Offset: 0x199ca
// Size: 0x17d
function function_6ba38d8e858007a9()
{
    if ( level utility::flag( "flag_tunnels_cradle_vfx" ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_tunnels_cradle_vfx" );
    vfx_vertical_offset = 120;
    
    while ( !isdefined( level.tunnels_mine_adz ) )
    {
        vfx_vertical_offset = 100;
        wait 0.5;
    }
    
    debug = 0;
    loop = 0;
    frost_spline = { #fx_name:"frost_wall", #targetname:"frost_spline_r_m" };
    cradle_mist = { #fx_name:"cradle_vapor_1", #targetname:"frost_spline_red_mist_aa" };
    fx_tag_obj = spawn( "script_model", ( 0, 0, 0 ) );
    fx_tag_obj setmodel( "vfx_energy_beam_core" );
    wait 0.5;
    thread function_4726fa67a6953dea( fx_tag_obj, vfx_vertical_offset, debug );
    fx_tag_obj hide();
    
    if ( !level utility::flag_exist( "cradle_edge_vfx_position_set" ) )
    {
        level utility::flag_init( "cradle_edge_vfx_position_set" );
    }
    
    level utility::flag_wait( "cradle_edge_vfx_position_set" );
    playfxontag( level._effect[ cradle_mist.fx_name ], fx_tag_obj, "TAG_ORIGIN" );
    wait 2;
    fx_tag_obj show();
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    stopfxontag( level._effect[ cradle_mist.fx_name ], fx_tag_obj, "TAG_ORIGIN" );
    wait 1;
    fx_tag_obj delete();
}

// Namespace gemini_util
// Params 3
// Checksum 0x46acbb5, Offset: 0x19b4f
// Size: 0x247
function function_4726fa67a6953dea( fx_object, vfx_vertical_offset, debug )
{
    level endon( #"game_ended" );
    fx_object endon( #"death" );
    wait_time = 2;
    fx_vertical_offset = vfx_vertical_offset;
    var_69c50b2b1f491631 = fx_vertical_offset;
    var_85a523b369936a20 = 170;
    var_3153f36e631607c0 = 0;
    var_676500a27b16b344 = 200;
    
    while ( !level utility::flag( "flag_tunnels_pit_complete" ) )
    {
        a_players = ob_story_mission_utils::get_playing_players();
        
        if ( a_players.size == 0 )
        {
            break;
        }
        
        radius = level.tunnels_mine_adz.radius;
        origin = level.tunnels_mine_adz.origin;
        a_players = function_628bac9faa9d1e86( a_players, origin );
        origin = ( origin[ 0 ], origin[ 1 ], a_players[ 0 ].origin[ 2 ] );
        direction = a_players[ 0 ].origin + ( 0, 0, var_69c50b2b1f491631 ) - origin;
        normal = vectornormalize( direction );
        var_afb881460a65a72d = origin + normal * radius + normal * var_676500a27b16b344;
        fx_object moveto( var_afb881460a65a72d, wait_time );
        fx_object.angles = vectortoangles( normal );
        level utility::flag_set( "cradle_edge_vfx_position_set" );
        
        /#
            if ( debug )
            {
                sphere( var_afb881460a65a72d, 32, ( 0, 0, 1 ), 0, 30 );
                line( origin, var_afb881460a65a72d, ( 0, 0, 1 ), 1, 0, 30 );
            }
        #/
        
        if ( level utility::flag( "flag_tunnels_elevator_descend_start" ) )
        {
            if ( var_3153f36e631607c0 < 30 )
            {
                elevator_vertical_offset = ( pow( var_3153f36e631607c0 * 0.095 - 1, 2 ) * -1 + 1 ) * var_85a523b369936a20;
                elevator_vertical_offset = max( elevator_vertical_offset, -40 );
                var_69c50b2b1f491631 = fx_vertical_offset + elevator_vertical_offset;
                var_3153f36e631607c0 += 1;
            }
        }
        
        if ( level utility::flag( "flag_trig_tunnels_mine_begin" ) )
        {
            var_69c50b2b1f491631 = 100;
        }
        
        if ( level utility::flag( "flag_trig_tunnels_mine_adz_02_begin" ) )
        {
            var_69c50b2b1f491631 = 100;
        }
        
        if ( level utility::flag( "flag_trig_tunnels_mine_progress_09" ) )
        {
            var_69c50b2b1f491631 = 100;
        }
        
        wait wait_time;
    }
}

// Namespace gemini_util
// Params 3
// Checksum 0x718e5329, Offset: 0x19d9e
// Size: 0x240
function loop_frost_fx( fxtag, fx_id_name, debug = 0 )
{
    level endon( #"game_ended" );
    fxid = level._effect[ fx_id_name ];
    var_bd0970b826f3ea06 = 16;
    waittime = 2;
    
    while ( !level utility::flag( "flag_tunnels_pit_complete" ) )
    {
        for ( i = 0; i < var_bd0970b826f3ea06 ; i++ )
        {
            forward = vectornormalize( anglestoforward( fxtag.angles ) );
            cross_y = vectornormalize( vectorcross( forward, ( 0, 0, 1 ) ) );
            cross_y = rotatevector( cross_y, ( 360 / var_bd0970b826f3ea06 * i, 0, 0 ) );
            trace_end = fxtag.origin + cross_y * 640;
            trace_dir = vectornormalize( trace_end - fxtag.origin );
            dotvalue = vectordot( ( 0, 0, -1 ), trace_dir );
            
            if ( dotvalue > 0.25 )
            {
                end = physicstrace( fxtag.origin, trace_end );
                start = end + cross_y * -1 * 10;
                
                if ( distance( end, start ) < 32 )
                {
                    playfx( fxid, start, forward, cross_y * -1 );
                    
                    /#
                        if ( debug )
                        {
                            line( fxtag.origin, trace_end + ( 0, 0, 5 ), ( 1, 0, 1 ), 1, 0, 60 );
                            line( start, end, ( 0, 1, 1 ), 1, 0, 60 );
                            sphere( start, 3, ( 0, 1, 1 ), 0, 60 );
                            sphere( end, 3, ( 1, 0, 1 ), 0, 60 );
                        }
                    #/
                }
            }
        }
        
        a_players = ob_story_mission_utils::get_playing_players();
        
        if ( a_players.size == 0 )
        {
            level utility::flag_clear( "elevator_cradle_start_vfx" );
            break;
        }
        
        wait waittime;
    }
}

// Namespace gemini_util
// Params 5
// Checksum 0x3f1b35c7, Offset: 0x19fe6
// Size: 0xbf
function function_3d7cfc8277ec2f55( splineobject, var_1c6fa73542dcdf0d, travel_time, loop, debug = 0 )
{
    splineidarray = getcsplineidarray( var_1c6fa73542dcdf0d );
    
    foreach ( splineid in splineidarray )
    {
        thread function_205300cc86ff0230( splineobject, splineid, travel_time, loop, debug );
    }
}

// Namespace gemini_util
// Params 5
// Checksum 0x6b0aeb5b, Offset: 0x1a0ad
// Size: 0x2e9
function function_205300cc86ff0230( splineobject, splineid, travel_time, loop, debug = 0 )
{
    assert( isdefined( splineid ) && isdefined( splineobject ) );
    var_c775aae795524cd6 = function_f98522888759e9fb( splineid );
    splinelength = function_85aab3016ede4b26( splineid );
    pos = function_73867b4f369b65ee( splineid, 0, 0 );
    angles = vectortoangles( function_60ab44df77792b6e( splineid, 0, 0 ) );
    waittime = 0.05;
    var_b1f2364bc7091d3 = travel_time / waittime;
    tick = ( var_c775aae795524cd6 - 1 ) / var_b1f2364bc7091d3;
    splineobject moveto( pos, 1e-05, 0, 0 );
    splineobject.angles = angles;
    play = 1;
    
    while ( play )
    {
        play = loop;
        var_3c86888976ab6d9d = 0;
        delta = 0;
        
        for ( i = 0; i < var_c775aae795524cd6 - 1 ; i++ )
        {
            var_3c86888976ab6d9d = abs( 0 + delta );
            
            while ( var_3c86888976ab6d9d <= 1 )
            {
                position = function_73867b4f369b65ee( splineid, i, var_3c86888976ab6d9d );
                forward = vectornormalize( function_60ab44df77792b6e( splineid, i, var_3c86888976ab6d9d ) );
                assert( isdefined( forward ) && isdefined( position ) );
                splineobject.origin = position;
                splineobject.angles = vectortoangles( forward );
                var_3c86888976ab6d9d += tick;
                
                /#
                    if ( debug )
                    {
                        cross_y = vectornormalize( vectorcross( forward, ( 0, 0, 1 ) ) );
                        cross_z = vectornormalize( vectorcross( forward, cross_y ) );
                        line( splineobject.origin, splineobject.origin + forward * 15, ( 1, 0, 0 ), 1, 0, 15 );
                        line( splineobject.origin, splineobject.origin + cross_z * 15, ( 0, 1, 0 ), 1, 0, 15 );
                        line( splineobject.origin, splineobject.origin + cross_y * 15 * -1, ( 0, 0, 1 ), 1, 0, 15 );
                        sphere( splineobject.origin, 6, ( 1, 0, 0 ), 0, 60 );
                    }
                #/
                
                wait waittime;
            }
            
            delta = var_3c86888976ab6d9d - 1;
        }
        
        if ( loop )
        {
            splineobject moveto( pos, 1e-05, 0, 0 );
        }
    }
}

/#

    // Namespace gemini_util
    // Params 0
    // Checksum 0xfd7ebdca, Offset: 0x1a39e
    // Size: 0x5, Type: dev
    function function_3e092c4093945972()
    {
        
    }

    // Namespace gemini_util
    // Params 3
    // Checksum 0x7f5e2926, Offset: 0x1a3ab
    // Size: 0x1c2, Type: dev
    function function_d6c199899ef5b468( var_f6cb1fa961da261e, var_68b32a8bafee7061, checkpoint_ent_name )
    {
        level endon( #"game_ended" );
        
        if ( activity_instance_common::isactivityinstance() )
        {
            self waittill( #"player_joined_activity" );
            waitframe();
        }
        
        while ( !isdefined( level.players[ 0 ].origin ) )
        {
            waitframe();
        }
        
        start_time = gettime();
        start_pos = level.players[ 0 ].origin;
        level utility::flag_wait( var_68b32a8bafee7061 );
        wait 2;
        end_time = gettime();
        total_time = end_time - start_time;
        seconds = floor( utility::function_6f5d2e1f1ff70482( total_time ) );
        checkpoint_ent = undefined;
        
        if ( isdefined( checkpoint_ent_name ) )
        {
            checkpoint_ent = getent( checkpoint_ent_name, #targetname );
            
            if ( !isdefined( checkpoint_ent ) )
            {
                checkpoint_ent = utility::getstruct( checkpoint_ent_name, "<dev string:x769>" );
                
                if ( !isdefined( checkpoint_ent ) )
                {
                    var_a3df3ba7c330a3ae = getnoentvolumearray( checkpoint_ent_name, #targetname );
                    
                    if ( isdefined( var_a3df3ba7c330a3ae ) )
                    {
                        checkpoint_ent = var_a3df3ba7c330a3ae[ 0 ];
                    }
                }
            }
        }
        
        if ( isdefined( checkpoint_ent ) )
        {
            checkpoint_player = function_1ff93f2b1149dd76( checkpoint_ent.origin, undefined, 0 );
        }
        else
        {
            checkpoint_player = function_1ff93f2b1149dd76();
        }
        
        if ( isdefined( checkpoint_player ) && isdefined( start_pos ) )
        {
            end_pos = checkpoint_player.origin;
            total_dist = distance2d( start_pos, end_pos );
        }
        else
        {
            total_dist = "<dev string:x774>";
        }
        
        iprintlnbold( var_f6cb1fa961da261e + "<dev string:x77c>" + function_f759c030bd34a60( seconds ) + "<dev string:x784>" + total_dist + "<dev string:x790>" );
    }

    // Namespace gemini_util
    // Params 1, eflags: 0x4
    // Checksum 0x2f07400c, Offset: 0x1a575
    // Size: 0x8d, Type: dev
    function private function_f759c030bd34a60( time )
    {
        var_ee54aa0310355301 = "<dev string:x797>";
        mins = int( time / 60 );
        var_ad3ff314c1292464 = int( time ) % 60;
        
        if ( mins < 10 )
        {
            var_ee54aa0310355301 += "<dev string:x79b>";
        }
        
        var_ee54aa0310355301 += string( mins );
        var_ee54aa0310355301 += "<dev string:x79d>";
        
        if ( var_ad3ff314c1292464 < 10 )
        {
            var_ee54aa0310355301 += "<dev string:x79b>";
        }
        
        var_ee54aa0310355301 += string( var_ad3ff314c1292464 );
        return var_ee54aa0310355301;
    }

    // Namespace gemini_util
    // Params 8
    // Checksum 0x1b3a852d, Offset: 0x1a60a
    // Size: 0xb8, Type: dev
    function function_c00e991359ce19d9( text, origin, color, alpha, scale, duration, endonevent, var_5bf65afe54040850 )
    {
        if ( !isdefined( var_5bf65afe54040850 ) )
        {
            var_5bf65afe54040850 = 1;
        }
        
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        endtime = gettime() + duration * 1000;
        
        while ( gettime() < endtime )
        {
            print3d( origin, text, color, alpha, scale, var_5bf65afe54040850 );
            timesec = var_5bf65afe54040850 * level.framedurationseconds;
            wait timesec;
        }
    }

    // Namespace gemini_util
    // Params 5
    // Checksum 0xfba846d0, Offset: 0x1a6ca
    // Size: 0x88, Type: dev
    function debug_draw_sphere( origin, radius, drawtimeseconds, color, endonevent )
    {
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            sphere( origin, radius, color );
            waitframe();
        }
    }

    // Namespace gemini_util
    // Params 6
    // Checksum 0x379d3685, Offset: 0x1a75a
    // Size: 0x99, Type: dev
    function debug_draw_cylinder( origin, height, radius, drawtimeseconds, color, endonevent )
    {
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            cylinder( origin, origin + ( 0, 0, height ), radius, color );
            waitframe();
        }
    }

    // Namespace gemini_util
    // Params 5
    // Checksum 0xe8889c57, Offset: 0x1a7fb
    // Size: 0x88, Type: dev
    function debug_draw_line( start, end, drawtimeseconds, color, endonevent )
    {
        self endon( #"death" );
        
        if ( isdefined( endonevent ) )
        {
            self endon( endonevent );
        }
        
        drawframes = int( drawtimeseconds / level.framedurationseconds );
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            line( start, end, color );
            waitframe();
        }
    }

    // Namespace gemini_util
    // Params 3
    // Checksum 0x5987cd7a, Offset: 0x1a88b
    // Size: 0x68, Type: dev
    function debug_draw_nocorpse( agent, requestid, data )
    {
        agent endon( #"death" );
        
        while ( isdefined( agent ) )
        {
            print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x79f>" + istrue( agent.nocorpse ) );
            waitframe();
        }
    }

    // Namespace gemini_util
    // Params 3
    // Checksum 0x6457ead9, Offset: 0x1a8fb
    // Size: 0xa9, Type: dev
    function debug_draw_teams( agent, requestid, data )
    {
        agent endon( #"death" );
        
        while ( isdefined( agent ) )
        {
            if ( agent utility::ent_flag( "<dev string:x7a9>" ) )
            {
                print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x7b0>" + agent.team );
            }
            else
            {
                print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x7bf>" + agent.team );
            }
            
            waitframe();
        }
    }

#/

// Namespace gemini_util
// Params 0
// Checksum 0xff42de2e, Offset: 0x1a9ac
// Size: 0x62
function function_20e8be1de4cdc304()
{
    level thread nightmare_transition( "flag_tunnels_solitary_complete", 1, 1, 1 );
    level thread nightmare_transition_off( "flag_tunnels_elevator_descend_end" );
    level thread nightmare_transition( "flag_cabin_barrage_check_on_alex_start", 1, 1, 1 );
    level thread nightmare_transition_off( "flag_cabin_barrage_flood_complete" );
    level thread nightmare_transition( "flag_trig_prison_minecarts_player_entered", 1, 1, 1 );
    level thread nightmare_transition_off( "flag_prison_finalpush_outro_vo_end" );
}

// Namespace gemini_util
// Params 5
// Checksum 0x2c3dd73a, Offset: 0x1aa16
// Size: 0x70
function nightmare_transition( flag_name, index = 1, do_transition = 1, var_ad30c944bbd232d7 = 1, delay )
{
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread ob_story_mission_utils::function_ecbb860d6714e9f3( index, do_transition, var_ad30c944bbd232d7 );
}

// Namespace gemini_util
// Params 1
// Checksum 0xc09ee737, Offset: 0x1aa8e
// Size: 0x23
function nightmare_transition_off( flag_name )
{
    level utility::flag_wait( flag_name );
    level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 1, 1 );
}

// Namespace gemini_util
// Params 2
// Checksum 0x310490fa, Offset: 0x1aab9
// Size: 0x13f
function function_539f246069fd0fa( force_field_name, key = #targetname )
{
    level utility::flag_wait( "scriptables_ready" );
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff thread force_field_off( 1, 1 );
    }
    
    var_b2d1d4fb8bbbac95 = getentarray( "nm_shield_part", "script_noteworthy" );
    
    foreach ( part in var_b2d1d4fb8bbbac95 )
    {
        part delete();
    }
}

// Namespace gemini_util
// Params 2
// Checksum 0x6ad8d621, Offset: 0x1ac00
// Size: 0xde
function turn_on_force_field( force_field_name, key = #targetname )
{
    level utility::flag_wait( "scriptables_ready" );
    
    if ( !level.var_ad5a2bd25598da74 )
    {
        scriptable::scriptable_addnotifycallback( "force_field_death", &force_field_power_supply_death );
        level.var_ad5a2bd25598da74 = 1;
    }
    
    force_fields = getentarray( force_field_name, key );
    
    foreach ( ff in force_fields )
    {
        ff thread force_field_on();
    }
}

// Namespace gemini_util
// Params 0
// Checksum 0x15b8311e, Offset: 0x1ace6
// Size: 0x458
function force_field_setup()
{
    ff = self;
    ff hide( 1 );
    ff notsolid();
    
    if ( ff.inited )
    {
        return;
    }
    
    ff.targetscriptables = getscriptablearray( ff.target, #targetname );
    isdestroyed = 0;
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                ff.power_supply = scriptable;
                
                if ( !isdefined( scriptable.ff ) )
                {
                    scriptable.ff = [];
                }
                
                isdestroyed = scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed";
                scriptable.ff[ scriptable.ff.size ] = ff;
            }
        }
    }
    
    if ( isdefined( ff.script_linkto ) )
    {
        ff.var_7c4a63493e09272c = ff utility::function_e1bb0bf82dab729e();
        
        if ( isdefined( ff.var_7c4a63493e09272c[ 0 ] ) )
        {
            ff.ff_scriptable = ff.var_7c4a63493e09272c[ 0 ];
        }
    }
    
    ff.targetents = getentarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetents ) )
    {
        foreach ( ent in ff.targetents )
        {
            if ( ent.script_noteworthy == "power_cable" )
            {
                ff.power_cable = ent;
                
                if ( !isdefined( ff.power_supply.power_cable ) )
                {
                    tokens = strtok( ent.model, "::" );
                    
                    if ( isdefined( tokens[ 1 ] ) )
                    {
                        ent.base_model_name = tokens[ 1 ];
                    }
                    
                    ff.power_supply.power_cable = ent;
                }
            }
        }
    }
    
    if ( isdestroyed )
    {
        ff.inited = 1;
        ff force_field_off();
        return;
    }
    
    ff.targetstructs = utility::getstructarray( ff.target, "targetname" );
    
    if ( isdefined( ff.targetstructs ) )
    {
        foreach ( struct in ff.targetstructs )
        {
            if ( struct.script_noteworthy == "interact" )
            {
                ff.interact_struct = struct;
                
                if ( !isdefined( struct.ff ) )
                {
                    struct.ff = [];
                }
                
                struct.ff[ struct.ff.size ] = ff;
                
                if ( !isdefined( struct.interact.ff ) )
                {
                    struct.interact.ff = [];
                }
                
                struct.interact.ff[ struct.interact.ff.size ] = ff;
                ff.interact = struct.interact;
            }
        }
    }
    
    ff.inited = 1;
}

// Namespace gemini_util
// Params 0
// Checksum 0xe8fd83b4, Offset: 0x1b146
// Size: 0x194
function force_field_on()
{
    ff = self;
    ff force_field_setup();
    
    if ( isdefined( ff.on ) )
    {
        return;
    }
    
    if ( isdefined( ff.targetscriptables ) )
    {
        foreach ( scriptable in ff.targetscriptables )
        {
            if ( scriptable.script_noteworthy == "power_supply" )
            {
                if ( scriptable getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" )
                {
                    return;
                }
            }
        }
    }
    
    ff show();
    ff solid();
    ff.ff_scriptable setscriptablepartstate( "main", "startup" );
    nav_ent = getent( ff.script_parameters, #script_noteworthy );
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::exploder( ff.script_fxid );
    }
    
    if ( !isdefined( ff.var_dd51eb58519b3df ) )
    {
        ff.var_dd51eb58519b3df = snd::play( "amb_force_field_lp", ff.origin );
        snd::play( "amb_force_field_switch_on", ff.origin );
    }
    
    ff.on = 1;
}

// Namespace gemini_util
// Params 2
// Checksum 0x34645e51, Offset: 0x1b2e2
// Size: 0x135
function force_field_off( scripted_off, remove_power_supply = 0 )
{
    ff = self;
    ff force_field_setup();
    
    if ( remove_power_supply )
    {
        ff.power_supply setscriptablepartstate( "force_field_power_supply", "off" );
    }
    
    ff notsolid();
    ff hide( 1 );
    
    if ( scripted_off )
    {
        ff.ff_scriptable setscriptablepartstate( "main", "off" );
    }
    else
    {
        ff.ff_scriptable setscriptablepartstate( "main", "shut down" );
    }
    
    if ( isdefined( ff.script_fxid ) )
    {
        utility::stop_exploder( ff.script_fxid );
    }
    
    if ( isdefined( ff.var_dd51eb58519b3df ) )
    {
        snd::stop( ff.var_dd51eb58519b3df );
        ff.var_dd51eb58519b3df = undefined;
        snd::play( "amb_force_field_switch_off", ff.origin );
    }
    
    if ( !scripted_off )
    {
        if ( isdefined( ff.script_flag_set ) )
        {
            level utility::flag_set( ff.script_flag_set );
        }
    }
    
    ff.on = undefined;
}

// Namespace gemini_util
// Params 4
// Checksum 0x87e77387, Offset: 0x1b41f
// Size: 0xe4
function force_field_power_supply_death( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance.entity.ff ) )
    {
        foreach ( ff in instance.entity.ff )
        {
            if ( isdefined( ff.interact ) )
            {
                ff.interact delete();
            }
            
            ff force_field_off();
        }
    }
}

