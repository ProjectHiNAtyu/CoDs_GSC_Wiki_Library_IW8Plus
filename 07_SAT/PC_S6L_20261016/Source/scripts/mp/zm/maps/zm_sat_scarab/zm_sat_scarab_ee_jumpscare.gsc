// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_jumpscare.gsc  (hash_166e29fad5c440bd.gscc) (size: 32500 Bytes / 0x7ef4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc59c30ff (3315347711)
// size ...... 32500 (0x7ef4)
// includes .. 24  (offset: 0x7688)
// strings ... 109 (offset: 0x7748)
// dev strs .. 19  (offset: 0x7dc8)
// exports ... 63  (offset: 0x5468)
// cseg ...... 0x989 + 0x4adf (0x5468)
// imports ... 185 (offset: 0x5e40)
// animtree1 . 2   (offset: 0x7eac)
// animtree2 . 3   (offset: 0x7ec4)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\intel;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim_scene;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zombie_intel;

#namespace zm_sat_scarab_ee_jumpscare;

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0, eflags: 0x5
// Checksum 0x5a08fc7, Offset: 0x9a7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_566ab33b3b3236dd", undefined, undefined, &function_81afec97dc186aee );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x89408844, Offset: 0x9c8
// Size: 0x1be
function private function_81afec97dc186aee()
{
    if ( getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        level.var_18d1829c141638f = 0;
    }
    else
    {
        level.var_18d1829c141638f = 1;
    }
    
    level.var_dab84f36260cdff2 = getscriptbundle( "diggingmound:zm_sat_scarab_digging_mound_bundle" );
    level.var_9e9c7ceb31a667b5 = getscriptbundle( "diggingmound:zm_sat_scarab_digging_mound_bundle_bonus" );
    zm_quest::register_quest_step( #"hash_566ab33b3b3236dd", #"hash_7fb996657258ff6d", &function_b078bcb12b7df80e, &function_13eb341f7b141e3b );
    zm_quest::register_quest_step( #"hash_566ab33b3b3236dd", #"trigger_jumpscare", &setup_wait_jumpscare, &cleanup_wait_jumpscare );
    zm_quest::register_quest_step( #"hash_566ab33b3b3236dd", #"hash_22b0925082038245", &setup_loop_spawn, &cleanup_loop_spawn );
    level utility::flag_wait( "scriptables_ready" );
    scriptable::scriptable_addnotifycallback( "digging_mound_dug", &digging_mound_dug );
    scriptable::scriptable_addnotifycallback( "cocoon_opened", &cocoon_opened );
    level scriptable::scriptable_adddamagedcallback( &on_scriptable_damaged );
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    setup_animations();
    setup_loom_minion_animations();
    level thread function_7120011bd3b5690b();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_8cbea16343f67960", &function_44a180cfe04405f4 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_e4c0f7d02623bf6", &function_f2b6930234a28322 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_d89aa769d4f55906", &function_616e6752054d8daa );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_998cfd109fc32672", &function_231fd15d824ed046 );
    equipment_mp::function_2e4e9b7492b36578( "equip_grappling_hook_dreadspinner_ee" );
    
    /#
        level thread function_2ccb0b6655b4d693();
        level thread dev_watcher();
        setup_jumpscare_devgui();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_49cab710674bd762", &function_4b1262aed9a9bc26 );
    level thread zm_quest::start_quest( #"hash_566ab33b3b3236dd" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 11, eflags: 0x4
// Checksum 0xb5933163, Offset: 0xb8e
// Size: 0x2de
function private on_scriptable_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    var_910215362da0dbbf = instance.type == "zm_sat_scarab_loot_digging_mound";
    var_3e314b689923a1b3 = instance.type == "zm_sat_scarab_loot_cocoon_1" || instance.type == "zm_sat_scarab_loot_cocoon_2" || instance.type == "zm_sat_scarab_loot_cocoon_3";
    
    if ( !var_910215362da0dbbf && !var_3e314b689923a1b3 )
    {
        return;
    }
    
    effective_attacker = eattacker;
    
    if ( !isplayer( effective_attacker ) && isdefined( einflictor ) && isplayer( einflictor.owner ) )
    {
        effective_attacker = einflictor.owner;
    }
    
    var_12029d7af64a97 = isplayer( effective_attacker ) && isdefined( einflictor ) && einflictor.equipmentref && ( einflictor.equipmentref == "equip_grappling_hook" || einflictor.equipmentref == "equip_grappling_hook_upgraded" || einflictor.equipmentref == "equip_grappling_hook_dreadspinner_ee" );
    var_b45625f092fcf844 = isplayer( effective_attacker ) && ( smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_FIRE_BULLET" || smeansofdeath == "MOD_ELEMENTAL_FIRE" || smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_FIRE_BULLET" || smeansofdeath == "MOD_ELEMENTAL_FIRE" || smeansofdeath == "MOD_BURNED" || smeansofdeath == "MOD_FIRE_DAMAGE" );
    var_487b77ce52a3f01b = isplayer( effective_attacker ) && isdefined( objweapon ) && isdefined( objweapon.weaponblueprint ) && isdefined( objweapon.weaponblueprint.var_9a7975cd0d0f0d6 ) && objweapon.weaponblueprint.var_9a7975cd0d0f0d6 == "fire";
    var_f8dbceef2edc0872 = isplayer( effective_attacker ) && isdefined( smeansofdeath ) && issubstr( smeansofdeath, "BULLET" ) && isdefined( objweapon ) && effective_attacker namespace_9d8e359c3b1041e5::function_f3b72bf1c0b8c737( objweapon ) && effective_attacker namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( objweapon ) == "napalmburst";
    var_b45625f092fcf844 = var_b45625f092fcf844 || var_487b77ce52a3f01b || var_f8dbceef2edc0872;
    var_f3dd8945ed1a9cbc = var_3e314b689923a1b3 && var_b45625f092fcf844;
    
    if ( var_12029d7af64a97 || var_f3dd8945ed1a9cbc )
    {
        effective_attacker damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
        instance thread attempt_dig_used( effective_attacker );
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 4
// Checksum 0x783b801f, Offset: 0xe74
// Size: 0x344
function digging_mound_dug( instance, note, param, var_64ffacba090c91be )
{
    thread set_digging_mound_dug_vfx( instance );
    instance notify( #"dig" );
    utility::flag_set( "player_dig_piles" );
    player = instance.var_f5b3ab91263b062e;
    loot_weight = getdvarfloat( @"hash_da4b7c92d8a43d64", 70 );
    zombie_weight = getdvarfloat( @"hash_b4835deecba41914", 25 );
    jumpscare_weight = getdvarfloat( @"hash_9a97c82f6d189680", 5 );
    
    if ( level.var_18d1829c141638f )
    {
        jumpscare_weight = 0;
    }
    
    total_weight = max( loot_weight + zombie_weight + jumpscare_weight, 1 );
    loot_rate = loot_weight / total_weight;
    zombie_rate = zombie_weight / total_weight;
    
    if ( isdefined( player ) )
    {
        rate = randomfloat( 1 );
        
        if ( !level.var_18d1829c141638f && isdefined( player.should_play_jumpscare ) && player.should_play_jumpscare )
        {
            level thread function_6885e3d5e5d48514( instance.origin, instance.var_f5b3ab91263b062e, instance.digging_mound_loc, instance );
            rate = 2;
        }
        
        if ( rate < loot_rate )
        {
            if ( !instance.var_9b1d149d27bb0245 )
            {
                iprintlnbold( "drop loot" );
                instance thread digging_mound_spawn_item();
                
                if ( player intel::player_has_intel( "zmintel_sat_scarab_document_4" ) == 0 && !isdefined( level.scarab_intel.doc4 ) && randomint( 6 ) == 1 )
                {
                    level.scarab_intel.doc4 = intel::spawn_intel_at_location( undefined, undefined, getclosestpointonnavmesh( instance.origin ) + ( 0, 0, 2 ), instance.angles, "zmintel_sat_scarab_document_4" );
                    level notify( #"hash_99f6b99b9864a443" );
                }
            }
        }
        else if ( rate < loot_rate + zombie_rate )
        {
            iprintlnbold( "spawn zombies" );
            level thread spawn_zombies_directly( instance.origin, instance.var_f5b3ab91263b062e, instance.digging_mound_loc );
        }
        else if ( rate <= 1 && !level.var_18d1829c141638f )
        {
            level thread function_6885e3d5e5d48514( instance.origin, instance.var_f5b3ab91263b062e, instance.digging_mound_loc, instance );
        }
        
        if ( isdefined( instance.digging_mound_loc.script_count ) )
        {
            index = instance.digging_mound_loc.script_count;
            location = instance.digging_mound_loc.script_noteworthy;
            save_key = hashcat( #"hash_a2bd1c26c97e0c54", location );
            storage_int = zm_quest::function_73720cdf21c3cfd7( #"hash_566ab33b3b3236dd", save_key ) ?? 0;
            storage_int = utility::set_bit_flag( storage_int, index );
            zm_quest::function_4eefe6de31f5ddab( #"hash_566ab33b3b3236dd", save_key, storage_int );
        }
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 4
// Checksum 0xbac74dce, Offset: 0x11c0
// Size: 0x232
function cocoon_opened( instance, note, param, var_64ffacba090c91be )
{
    thread function_c9acfa5fbe1c1c60( instance );
    instance notify( #"dig" );
    utility::flag_set( "player_dig_piles" );
    player = instance.var_f5b3ab91263b062e;
    loot_rate = getdvarfloat( @"hash_8bed45cb513fa486", 70 );
    zombie_rate = getdvarfloat( @"hash_702dbf6e5b441b6", 25 );
    total_weight = max( loot_rate + zombie_rate, 1 );
    loot_rate /= total_weight;
    zombie_rate /= total_weight;
    
    if ( isdefined( player ) )
    {
        rate = randomfloat( 1 );
        
        if ( rate < loot_rate )
        {
            if ( !instance.var_9b1d149d27bb0245 )
            {
                var_452a32d13853953e = isdefined( instance.cocoon_loc.item_pos_struct ) ? instance.cocoon_loc.item_pos_struct.origin : undefined;
                iprintlnbold( "drop loot" );
                instance thread digging_mound_spawn_item( var_452a32d13853953e );
            }
        }
        else if ( rate < loot_rate + zombie_rate )
        {
            iprintlnbold( "spawn zombies" );
            level thread spawn_zombies_directly( instance.origin, instance.var_f5b3ab91263b062e, instance.cocoon_loc );
        }
        
        if ( isdefined( instance.cocoon_loc.script_count ) )
        {
            index = instance.cocoon_loc.script_count;
            location = instance.cocoon_loc.script_noteworthy;
            save_key = hashcat( #"hash_eb570444d2985427", location );
            storage_int = zm_quest::function_73720cdf21c3cfd7( #"hash_566ab33b3b3236dd", save_key ) ?? 0;
            storage_int = utility::set_bit_flag( storage_int, index );
            zm_quest::function_4eefe6de31f5ddab( #"hash_566ab33b3b3236dd", save_key, storage_int );
        }
    }
    
    instance utility::ent_flag_set( "can_spawn" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xd6b00575, Offset: 0x13fa
// Size: 0x35
function set_digging_mound_dug_vfx( instance )
{
    instance utility::function_7c10ea82c1e305b8( "digging_mound_fx", "piles_fx" );
    wait 5;
    instance utility::function_7c10ea82c1e305b8( "digging_mound_fx", "off" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xa31e73c9, Offset: 0x1437
// Size: 0x35
function function_c9acfa5fbe1c1c60( instance )
{
    instance utility::function_7c10ea82c1e305b8( "cocoon_fx", "cocoon_fx" );
    wait 5;
    instance utility::function_7c10ea82c1e305b8( "cocoon_fx", "off" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 3
// Checksum 0xc15fc0c3, Offset: 0x1474
// Size: 0x1a1
function spawn_zombies_directly( origin_position, player, digging_mound_loc )
{
    level endon( #"game_ended" );
    scene_node = spawnstruct();
    scene_node.origin = player.origin;
    scene_node.angles = player.angles;
    face_angles = vectortoangles( ( player.origin[ 0 ], player.origin[ 1 ], 0 ) - ( origin_position[ 0 ], origin_position[ 1 ], 0 ) );
    var_ed92d3edd3eded9 = digging_mound_loc.zombie_pos_struct ?? utility::getstruct( digging_mound_loc.target, "targetname" );
    zombie = agent_manager::spawn_agent( "zombie_loom_minion", var_ed92d3edd3eded9.origin, face_angles, "team_two_hundred" );
    launch_velocity = ( 0, 0, 0 );
    zombie thread function_756fa264b833c01a( launch_velocity );
    prop_actor = anim_scene::anim_scene_create_actor( zombie, "scare_jump_loom_minion" );
    scene_node.origin = var_ed92d3edd3eded9.origin;
    scene_node.angles = face_angles;
    scene_node anim_scene::anim_scene( [ prop_actor ], "scare_jump_01", undefined, undefined, undefined, 0, 0 );
    zombie val::reset_all( "ww_scare_jump" );
    
    if ( isalive( zombie ) )
    {
        movespeed = zm_round_spawning::function_6211dbc10409aa10();
        zombie zombie_utils::function_a8ce00e0448cb6f0( movespeed, "default", 1 );
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xbfd0d791, Offset: 0x161d
// Size: 0x99, Type: bool
function is_player_touching_ground( player )
{
    collisioncontents = trace::create_default_contents( 1 );
    raytrace = trace::ray_trace( player.origin + ( 0, 0, 5 ), player.origin + ( 0, 0, -40 ), player.mdl, collisioncontents );
    
    if ( isdefined( raytrace ) && raytrace != player.origin + ( 0, 0, -40 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 4
// Checksum 0xf41be162, Offset: 0x16bf
// Size: 0x26a
function function_6885e3d5e5d48514( origin_position, player, digging_mound_loc, pile_instance )
{
    level endon( #"game_ended" );
    
    if ( player.b_jumpscare_triggered && !level.var_158d47c0fe257d75 )
    {
        if ( randomfloat( 1 ) < 0.5 )
        {
            if ( !pile_instance.var_9b1d149d27bb0245 )
            {
                pile_instance thread digging_mound_spawn_item();
                iprintlnbold( "jumpscare skipped \xe2\x80\x94 player already triggered jumpscare this game, dropping loot instead" );
            }
            
            return;
        }
        
        iprintlnbold( "jumpscare skipped \xe2\x80\x94 player already triggered jumpscare this game, spawning zombie instead" );
        level thread spawn_zombies_directly( origin_position, player, digging_mound_loc );
        return;
    }
    
    var_92b21ca8efb6aef2 = distance2dsquared( origin_position, player.origin );
    var_b6081b1b6ba5e8b5 = sqrt( var_92b21ca8efb6aef2 );
    var_e356b6c51eb4ed14 = sqrt( 16384 );
    b_close_enough = var_92b21ca8efb6aef2 < 16384;
    b_on_ground = player isonground();
    
    if ( b_close_enough && b_on_ground )
    {
        scene_node = spawnstruct();
        scene_node.origin = player.origin;
        scene_node.angles = player.angles;
        zombie = function_d609b995a364404d( scene_node, origin_position, player );
        
        if ( isalive( zombie ) )
        {
            movespeed = zm_round_spawning::function_6211dbc10409aa10();
            zombie zombie_utils::function_a8ce00e0448cb6f0( movespeed, "default", 1 );
        }
        
        player.should_play_jumpscare = 0;
        
        if ( !level.var_158d47c0fe257d75 )
        {
            player.b_jumpscare_triggered = 1;
        }
        
        player play_vo();
        utility::flag_set( "player_jumpscare_triggered" );
        iprintlnbold( " Jumpscare played!" );
        return;
    }
    
    if ( randomfloat( 1 ) < 0.5 )
    {
        if ( !pile_instance.var_9b1d149d27bb0245 )
        {
            pile_instance thread digging_mound_spawn_item();
        }
        
        str_fallback = "dropping loot";
    }
    else
    {
        level thread spawn_zombies_directly( origin_position, player, digging_mound_loc );
        str_fallback = "spawn zombie";
    }
    
    if ( !b_on_ground )
    {
        iprintlnbold( "jumpscare skipped \xe2\x80\x94 player is not on ground, " + str_fallback + " instead" );
    }
    else
    {
        iprintlnbold( "jumpscare skipped \xe2\x80\x94 player is too far, " + "dist=" + int( var_b6081b1b6ba5e8b5 ) + " thresh=" + int( var_e356b6c51eb4ed14 ) + str_fallback + " instead" );
    }
    
    player.should_play_jumpscare = 1;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x4da9cff5, Offset: 0x1931
// Size: 0x43
function play_vo()
{
    if ( self.jumpscare_vo_played )
    {
        return;
    }
    
    var_db75d3de862ce072 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_58b99410ead708c5", #"bc_flavor_player_negative" );
    
    if ( var_db75d3de862ce072 )
    {
        self.jumpscare_vo_played = 1;
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xbad0e606, Offset: 0x197c
// Size: 0xf6
function function_756fa264b833c01a( launch_velocity )
{
    level endon( #"game_ended" );
    zombie = self;
    gravity = getgravity() / 1.5;
    vel = launch_velocity;
    prev_pos = zombie.origin;
    
    while ( true )
    {
        dt = getframeduration() / 1000;
        vel += ( 0, 0, gravity * -1 * dt );
        var_f370b69d0d8846ba = prev_pos + vel * dt;
        trace = physicstrace( prev_pos, var_f370b69d0d8846ba );
        
        if ( trace != var_f370b69d0d8846ba )
        {
            nav_pos = getclosestpointonnavmesh( trace );
            
            if ( isdefined( nav_pos ) )
            {
                zombie.origin = nav_pos;
            }
            else
            {
                zombie.origin = trace;
            }
            
            break;
        }
        
        zombie.origin = var_f370b69d0d8846ba;
        prev_pos = var_f370b69d0d8846ba;
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x19e736a1, Offset: 0x1a7a
// Size: 0x6d
function get_round_position()
{
    collisioncontents = trace::create_default_contents( 1 );
    raytrace = trace::ray_trace( self.origin + ( 0, 0, 40 ), self.origin + ( 0, 0, -40 ), self.mdl, collisioncontents );
    
    if ( isdefined( raytrace ) )
    {
        return raytrace[ "position" ];
    }
}

#using_animtree( "script_model" );

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x6272a2f7, Offset: 0x1aef
// Size: 0x90
function setup_animations()
{
    level.scr_animtree[ "scare_jump" ] = #animtree;
    level.scr_anim[ "scare_jump" ][ "scare_jump_02" ] = %ai_cer_zm_vermin_scare_jump_02;
    level.scr_eventanim[ "scare_jump" ][ "scare_jump_02" ] = %"ai_cer_zm_vermin_scare_jump_02";
    level.scr_anim[ "player_rig" ][ "scare_jump_02" ] = %ai_cer_zm_player_scare_jump_02;
    level.scr_eventanim[ "player_rig" ][ "scare_jump_02" ] = %"ai_cer_zm_player_scare_jump_02";
}

#using_animtree( "zombie_vermin" );

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x65d51dc7, Offset: 0x1b87
// Size: 0x52
function setup_loom_minion_animations()
{
    level.scr_animtree[ "scare_jump_loom_minion" ] = #animtree;
    level.scr_anim[ "scare_jump_loom_minion" ][ "scare_jump_01" ] = %ai_t10_zm_vermin_scare_jump_01;
    level.scr_eventanim[ "scare_jump_loom_minion" ][ "scare_jump_01" ] = %"ai_t10_zm_vermin_scare_jump_01";
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 3
// Checksum 0x479be9b3, Offset: 0x1be1
// Size: 0x1c3
function function_d609b995a364404d( scene_node, origin_position, player )
{
    if ( getdvarint( @"hash_26b57ca52217a74a", 0 ) )
    {
        if ( !isalive( level.var_434a989217ebcb19 ) )
        {
            level.var_434a989217ebcb19 = agent_manager::spawn_agent( "zombie_loom_minion", origin_position + ( 0, 0, -50 ), player.angles, "team_two_hundred" );
        }
        
        zombie = level.var_434a989217ebcb19;
        zombie.animname = "vermin";
        scene_node scene::play( [ player, zombie ], "shot_020", "cin_vermin_scare_jump" );
        return;
    }
    
    player val::set( "ww_scare_jump_player", "ignoreme", 1 );
    player_actor = anim_scene::anim_scene_create_actor( player, "player_rig", 1, 1, 1 );
    face_angles = vectortoangles( ( player.origin[ 0 ], player.origin[ 1 ], 0 ) - ( origin_position[ 0 ], origin_position[ 1 ], 0 ) );
    zombie = agent_manager::spawn_agent( "zombie_loom_minion", origin_position, face_angles, "team_two_hundred" );
    zombie val::set( "ww_scare_jump", "damage", 0 );
    player playsoundtoplayer( "evt_vermin_jump_scare_stinger", player );
    prop_actor = anim_scene::anim_scene_create_actor( zombie, "scare_jump" );
    scene_node anim_scene::anim_scene( [ player_actor, prop_actor ], "scare_jump_02", undefined, undefined, undefined, 0, 0 );
    zombie val::set( "ww_scare_jump", "damage", 1 );
    player val::reset_all( "ww_scare_jump_player" );
    level thread function_b95f9cf96036636b( zombie, player );
    return zombie;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x961ea516, Offset: 0x1dac
// Size: 0xe3
function private function_b95f9cf96036636b( zombie, player )
{
    level endon( #"game_ended" );
    zombie waittill( #"death" );
    wait 1;
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    player playsoundtoplayer( "evt_success_stinger", player );
    n_round = zm_round_logic::get_rb_round_number();
    
    if ( n_round <= 10 )
    {
        var_d9906d678f78a3fa = %"hash_177df22075e8c456";
    }
    else if ( n_round <= 20 )
    {
        var_d9906d678f78a3fa = %"hash_177df12075e8c2a3";
    }
    else if ( n_round <= 30 )
    {
        var_d9906d678f78a3fa = %"hash_177df02075e8c0f0";
    }
    else
    {
        var_d9906d678f78a3fa = %"hash_177df72075e8ccd5";
    }
    
    if ( !isdefined( var_d9906d678f78a3fa ) )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( zombie.origin );
    level common_item::function_38cde6a6acb68ea6( var_d9906d678f78a3fa, 9, spawnoptions );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0xec48980c, Offset: 0x1e97
// Size: 0x4a
function get_subsequent_rounds()
{
    switch ( level.players.size )
    {
        case 1:
        case 2:
            return 3;
        case 3:
        case 4:
            return 6;
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0x4c25a159, Offset: 0x1ee9
// Size: 0x318
function digging_mound_spawn_item( var_6f7fbace8d36ac37 )
{
    self endon( #"death" );
    waitframe();
    n_round = zm_round_logic::get_rb_round_number();
    
    if ( self.var_6d3fb2276d93187f )
    {
        if ( n_round > 0 && n_round < 15 )
        {
            digging_mound_item_list = level.var_9e9c7ceb31a667b5.var_73b01f25eb647a35;
        }
        else if ( n_round >= 15 )
        {
            digging_mound_item_list = level.var_9e9c7ceb31a667b5.var_e909debff4b84462;
        }
        else if ( n_round >= 35 && n_round < 55 )
        {
            digging_mound_item_list = level.var_9e9c7ceb31a667b5.var_30c4cd07b94fe37c;
        }
        else if ( n_round >= 55 )
        {
            digging_mound_item_list = level.var_9e9c7ceb31a667b5.var_286037f4793c2de1;
        }
    }
    else if ( n_round > 0 && n_round < 15 )
    {
        digging_mound_item_list = level.var_dab84f36260cdff2.var_73b01f25eb647a35;
    }
    else if ( n_round >= 15 && n_round < 35 )
    {
        digging_mound_item_list = level.var_dab84f36260cdff2.var_e909debff4b84462;
    }
    else if ( n_round >= 35 && n_round < 55 )
    {
        digging_mound_item_list = level.var_dab84f36260cdff2.var_30c4cd07b94fe37c;
    }
    else if ( n_round >= 55 )
    {
        digging_mound_item_list = level.var_dab84f36260cdff2.var_286037f4793c2de1;
    }
    
    if ( isdefined( var_6f7fbace8d36ac37 ) )
    {
        v_loot_spawn_loc = var_6f7fbace8d36ac37;
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( v_loot_spawn_loc, self.origin );
    }
    else
    {
        upvec = anglestoup( self.angles ) * 4;
        v_loot_spawn_loc = self.origin + upvec;
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_loot_spawn_loc );
    }
    
    itemcount = randomintrange( 2, 3 );
    spawnoptions.var_c580c0e8b49f1fcc = 1;
    spawnoptions.var_4a4b419f66681601 = [];
    nearbyplayers = getplayersinradius( self.origin, 512 );
    
    foreach ( player in nearbyplayers )
    {
        level thread utility::callsharedfunc( #"zombie", #"hash_26befc250486510c", v_loot_spawn_loc, self.angles, player );
        spawnoptions.var_4a4b419f66681601[ spawnoptions.var_4a4b419f66681601.size ] = player;
    }
    
    if ( self.type == "zm_sat_scarab_loot_digging_mound" && utility::issharedfuncdefined( #"scarab_ee_dance_off", #"hash_c2b80a5f77ac7b24" ) )
    {
        level utility::callsharedfunc( #"scarab_ee_dance_off", #"hash_c2b80a5f77ac7b24", v_loot_spawn_loc );
    }
    
    itemsspawned = level common_item::function_38cde6a6acb68ea6( digging_mound_item_list, itemcount, spawnoptions );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0x5fdf2101, Offset: 0x2209
// Size: 0x10e
function check_can_spawn( sparams, instance )
{
    round_number = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( instance ) && instance.respawn_round === round_number )
    {
        instance utility::ent_flag_set( "can_spawn" );
        level callback::remove( "on_round_end", &check_can_spawn, instance );
        
        if ( isdefined( instance.digging_mound_loc.script_count ) )
        {
            index = instance.digging_mound_loc.script_count;
            location = instance.digging_mound_loc.script_noteworthy;
            save_key = hashcat( #"hash_a2bd1c26c97e0c54", location );
            storage_int = zm_quest::function_73720cdf21c3cfd7( #"hash_566ab33b3b3236dd", save_key ) ?? 0;
            storage_int = utility::function_911d2d3c6d773726( storage_int, index );
            zm_quest::function_4eefe6de31f5ddab( #"hash_566ab33b3b3236dd", save_key, storage_int );
        }
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x85b87cf5, Offset: 0x231f
// Size: 0x328
function init_piles()
{
    var_4c4db1fc01e4deaa = utility::getstructarray( "digging_mound", "targetname" );
    var_45394b2b5d20107f = [];
    
    foreach ( cocoon_targetname in [ "cocoon_1", "cocoon_2", "cocoon_3" ] )
    {
        foreach ( cocoon_loc in utility::getstructarray( cocoon_targetname, "targetname" ) )
        {
            var_45394b2b5d20107f[ var_45394b2b5d20107f.size ] = cocoon_loc;
        }
    }
    
    var_a2e071ac9ce73ca6 = isarray( var_4c4db1fc01e4deaa ) && var_4c4db1fc01e4deaa.size > 0;
    var_1efc6a70758d6536 = isarray( var_45394b2b5d20107f ) && var_45394b2b5d20107f.size > 0;
    
    if ( !var_a2e071ac9ce73ca6 && !var_1efc6a70758d6536 )
    {
        return;
    }
    
    if ( var_a2e071ac9ce73ca6 )
    {
        level.var_4c4db1fc01e4deaa = [];
        
        foreach ( loc in var_4c4db1fc01e4deaa )
        {
            if ( !isdefined( level.var_4c4db1fc01e4deaa[ loc.script_noteworthy ] ) )
            {
                level.var_4c4db1fc01e4deaa[ loc.script_noteworthy ] = [];
            }
            
            level.var_4c4db1fc01e4deaa[ loc.script_noteworthy ][ level.var_4c4db1fc01e4deaa[ loc.script_noteworthy ].size ] = loc;
        }
    }
    
    if ( var_1efc6a70758d6536 )
    {
        level.var_45394b2b5d20107f = [];
        
        foreach ( loc in var_45394b2b5d20107f )
        {
            if ( !isdefined( level.var_45394b2b5d20107f[ loc.script_noteworthy ] ) )
            {
                level.var_45394b2b5d20107f[ loc.script_noteworthy ] = [];
            }
            
            level.var_45394b2b5d20107f[ loc.script_noteworthy ][ level.var_45394b2b5d20107f[ loc.script_noteworthy ].size ] = loc;
        }
    }
    
    level thread function_41b967a45fa905bd();
    wait 1;
    level utility::flag_set( "digging_initialized" );
    level utility::flag_wait( "never" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xf55f39e3, Offset: 0x264f
// Size: 0xbc
function on_item_pickup( params )
{
    player = params.player;
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    var_ad430148a3718ad6 = randomfloat( 1 );
    
    if ( var_ad430148a3718ad6 < 0.2 )
    {
        scene_node = spawnstruct();
        scene_node.origin = player.origin;
        scene_node.angles = player.angles;
        setup_animations();
        setup_loom_minion_animations();
        zombie = function_d609b995a364404d( scene_node, params.item.origin, player );
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x38370597, Offset: 0x2713
// Size: 0x4d9
function function_41b967a45fa905bd()
{
    if ( isdefined( level.var_4c4db1fc01e4deaa ) )
    {
        foreach ( var_514ad48ced161cf8 in level.var_4c4db1fc01e4deaa )
        {
            foreach ( index, digging_mound_loc in var_514ad48ced161cf8 )
            {
                digging_mound_loc.mound = spawnscriptable( "zm_sat_scarab_loot_digging_mound", digging_mound_loc.origin, digging_mound_loc.angles );
                digging_mound_loc.mound.interact = interaction::register_scriptable_interact( digging_mound_loc.mound, undefined, undefined, undefined, &function_ad87a39d9ad82e1 );
                digging_mound_loc.mound.digging_mound_loc = digging_mound_loc;
                digging_mound_loc.mound.digging_mound_loc.script_count = index;
                digging_mound_loc.mound.var_9b1d149d27bb0245 = 1;
                digging_mound_loc.mound setscriptablepartstate( "digging_mound", "dug" );
                digging_mound_loc.mound.var_9b1d149d27bb0245 = undefined;
                digging_mound_loc.mound utility::ent_flag_set( "can_spawn" );
            }
        }
    }
    
    if ( isdefined( level.var_45394b2b5d20107f ) )
    {
        foreach ( var_50c93f307caa0d62 in level.var_45394b2b5d20107f )
        {
            foreach ( index, cocoon_loc in var_50c93f307caa0d62 )
            {
                scriptable_name = "zm_sat_scarab_loot_" + cocoon_loc.targetname;
                cocoon_loc.mound = spawnscriptable( scriptable_name, cocoon_loc.origin, cocoon_loc.angles );
                cocoon_loc.mound.interact = interaction::register_scriptable_interact( cocoon_loc.mound, undefined, undefined, undefined, &function_8fb57ed441c7e965 );
                cocoon_loc.mound.cocoon_loc = cocoon_loc;
                cocoon_loc.mound.cocoon_loc.script_count = index;
                
                if ( isdefined( cocoon_loc.target ) )
                {
                    var_a42b398c8c7ededc = utility::getstructarray( cocoon_loc.target, "targetname" );
                    
                    foreach ( var_5990ce3727e634d1 in var_a42b398c8c7ededc )
                    {
                        if ( var_5990ce3727e634d1.script_noteworthy == "zombie_pos" )
                        {
                            cocoon_loc.zombie_pos_struct = var_5990ce3727e634d1;
                            continue;
                        }
                        
                        if ( var_5990ce3727e634d1.script_noteworthy == "mote_pos" )
                        {
                            cocoon_loc.mote_pos_struct = var_5990ce3727e634d1;
                            continue;
                        }
                        
                        if ( var_5990ce3727e634d1.script_noteworthy == "item_pos" )
                        {
                            cocoon_loc.item_pos_struct = var_5990ce3727e634d1;
                        }
                    }
                }
                
                cocoon_loc.mound.var_9b1d149d27bb0245 = 1;
                cocoon_loc.mound setscriptablepartstate( "cocoon", "broken" );
                cocoon_loc.mound.var_9b1d149d27bb0245 = undefined;
                cocoon_loc.mound utility::ent_flag_set( "can_spawn" );
            }
        }
    }
    
    level thread function_e9b79d7b619efbe0( undefined );
    level callback::add( "on_round_end", &function_e9b79d7b619efbe0 );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0x2eb1ff8a, Offset: 0x2bf4
// Size: 0xd4
function attempt_dig_used( player )
{
    function_ed1f39a6fcb2e77f( "attempt_dig_used", self, "attempt_dig_used", undefined, player );
    self.var_f5b3ab91263b062e = player;
    
    if ( self.type == "zm_sat_scarab_loot_cocoon_1" || self.type == "zm_sat_scarab_loot_cocoon_2" || self.type == "zm_sat_scarab_loot_cocoon_3" )
    {
        utility::function_7c10ea82c1e305b8( "cocoon", "broken" );
        utility::function_7c10ea82c1e305b8( "model", "empty" );
        function_ed1f39a6fcb2e77f( "cocoon_opened", self, "cocoon_opened", undefined, player );
        return;
    }
    
    self setscriptablepartstate( "absorb_mote_fx", "off" );
    utility::function_7c10ea82c1e305b8( "digging_mound", "dug" );
    function_ed1f39a6fcb2e77f( "digging_mound_dug", self, "digging_mound_dug", undefined, player );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0x104a5c0b, Offset: 0x2cd0
// Size: 0x8d9
function function_e9b79d7b619efbe0( params )
{
    if ( !isdefined( level.var_4c4db1fc01e4deaa ) && !isdefined( level.var_45394b2b5d20107f ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_ddbbde4034c6ebd7 ) )
    {
        level.var_ddbbde4034c6ebd7 = [];
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    var_125dbee5c231a9ee = !level.var_902e9004b8a0a245;
    var_4ee6cb5b8307d0 = getdvarint( @"hash_125c9ffe9505a9b2", 2 );
    var_d04a26c345f0f239 = 0;
    
    if ( round_number >= 15 && round_number < 35 )
    {
        var_d04a26c345f0f239 = 1;
    }
    else if ( round_number >= 35 && round_number < 55 )
    {
        var_d04a26c345f0f239 = 2;
    }
    else if ( round_number >= 55 )
    {
        var_d04a26c345f0f239 = 3;
    }
    
    var_c55ece3ed079b4ba = var_4ee6cb5b8307d0 + var_d04a26c345f0f239;
    var_c9c6b6e3d2ac2d23 = getdvarint( @"hash_40bbfdd5b8e81be5", 0 );
    
    if ( isdefined( level.var_4c4db1fc01e4deaa ) )
    {
        foreach ( var_514ad48ced161cf8 in level.var_4c4db1fc01e4deaa )
        {
            if ( !isdefined( var_514ad48ced161cf8 ) || var_514ad48ced161cf8.size <= 0 )
            {
                continue;
            }
            
            var_570a26cf7e5061b8 = var_514ad48ced161cf8[ 0 ].script_noteworthy;
            var_93f0ba585ff21689 = function_5c99f07b9f5eba69( var_514ad48ced161cf8 );
            var_e001f312269c1d57 = var_514ad48ced161cf8.size - var_93f0ba585ff21689.size;
            var_bef4b52a69d0e147 = 0;
            
            if ( isdefined( level.var_45394b2b5d20107f ) && isdefined( level.var_45394b2b5d20107f[ var_570a26cf7e5061b8 ] ) )
            {
                var_da00bd1d75ed71ce = function_676affebd39047b8( level.var_45394b2b5d20107f[ var_570a26cf7e5061b8 ] );
                var_bef4b52a69d0e147 = level.var_45394b2b5d20107f[ var_570a26cf7e5061b8 ].size - var_da00bd1d75ed71ce.size;
            }
            
            var_8f8e3a0de6bdb96f = var_c55ece3ed079b4ba - var_e001f312269c1d57 + var_bef4b52a69d0e147;
            
            if ( var_8f8e3a0de6bdb96f <= 0 && !var_c9c6b6e3d2ac2d23 )
            {
                if ( !var_125dbee5c231a9ee && !isdefined( level.var_ddbbde4034c6ebd7[ var_570a26cf7e5061b8 ] ) )
                {
                    level.var_ddbbde4034c6ebd7[ var_570a26cf7e5061b8 ] = round_number + function_46e360e8daf50cb4();
                }
                
                continue;
            }
            
            if ( var_c9c6b6e3d2ac2d23 )
            {
                var_27f4f558f3267a19 = var_93f0ba585ff21689.size;
            }
            else if ( var_125dbee5c231a9ee )
            {
                var_27f4f558f3267a19 = 2;
            }
            else
            {
                next_respawn_round = level.var_ddbbde4034c6ebd7[ var_570a26cf7e5061b8 ];
                
                if ( !isdefined( next_respawn_round ) )
                {
                    next_respawn_round = round_number + function_46e360e8daf50cb4();
                    level.var_ddbbde4034c6ebd7[ var_570a26cf7e5061b8 ] = next_respawn_round;
                }
                
                if ( round_number < next_respawn_round )
                {
                    continue;
                }
                
                var_27f4f558f3267a19 = randomint( 3 );
                level.var_ddbbde4034c6ebd7[ var_570a26cf7e5061b8 ] = round_number + function_46e360e8daf50cb4();
            }
            
            if ( !var_c9c6b6e3d2ac2d23 )
            {
                var_27f4f558f3267a19 = min( var_27f4f558f3267a19, var_8f8e3a0de6bdb96f );
            }
            
            var_27f4f558f3267a19 = min( var_27f4f558f3267a19, var_93f0ba585ff21689.size );
            
            if ( var_27f4f558f3267a19 < 1 )
            {
                continue;
            }
            
            for ( i = 0; i < var_27f4f558f3267a19 ; i++ )
            {
                mound_to_spawn = utility::array_random( var_93f0ba585ff21689 );
                
                if ( !isdefined( mound_to_spawn ) )
                {
                    continue;
                }
                
                location = mound_to_spawn.script_noteworthy;
                save_key = hashcat( #"hash_a2bd1c26c97e0c54", location );
                storage_int = zm_quest::function_73720cdf21c3cfd7( #"hash_566ab33b3b3236dd", save_key ) ?? 0;
                
                if ( isdefined( storage_int ) && isdefined( mound_to_spawn.script_count ) )
                {
                    index = mound_to_spawn.script_count;
                    is_dug = utility::get_bit_flag( storage_int, index );
                    
                    if ( level.var_9286dfceac05819c && var_125dbee5c231a9ee && is_dug )
                    {
                        var_93f0ba585ff21689 = arrayremove( var_93f0ba585ff21689, mound_to_spawn );
                        
                        if ( var_93f0ba585ff21689.size <= 0 )
                        {
                            break;
                        }
                        
                        i--;
                        continue;
                    }
                }
                
                if ( isdefined( mound_to_spawn.script_count ) )
                {
                    index = mound_to_spawn.script_count;
                    storage_int = utility::function_911d2d3c6d773726( storage_int, index );
                    zm_quest::function_4eefe6de31f5ddab( #"hash_566ab33b3b3236dd", save_key, storage_int );
                }
                
                mound_to_spawn.mound utility::function_7c10ea82c1e305b8( "digging_mound", "diggable" );
                mound_to_spawn.mound setscriptablepartstate( "absorb_mote_fx", "off" );
                flyfx_state = mound_to_spawn.script_fxgroup ?? "normal";
                mound_to_spawn.mound utility::function_7c10ea82c1e305b8( "fly_fx", flyfx_state );
                model_state = mound_to_spawn.script_parameters ?? "dirt";
                mound_to_spawn.mound utility::function_7c10ea82c1e305b8( "digging_mound_model", model_state );
                var_93f0ba585ff21689 = arrayremove( var_93f0ba585ff21689, mound_to_spawn );
                mound_to_spawn.mound utility::ent_flag_clear( "can_spawn" );
                mound_to_spawn.mound thread function_ff8bd1755114482a();
                mound_to_spawn.mound thread function_b069c5e7073e2089();
            }
        }
    }
    
    if ( isdefined( level.var_45394b2b5d20107f ) )
    {
        if ( !isdefined( level.var_8bb02c00f1abc7ab ) )
        {
            level.var_8bb02c00f1abc7ab = [];
        }
        
        var_1cb654a92ad6f4b5 = !level.var_79ee10f043d51b21;
        
        foreach ( var_50c93f307caa0d62 in level.var_45394b2b5d20107f )
        {
            if ( !isdefined( var_50c93f307caa0d62 ) || var_50c93f307caa0d62.size <= 0 )
            {
                continue;
            }
            
            var_570a26cf7e5061b8 = var_50c93f307caa0d62[ 0 ].script_noteworthy;
            var_da00bd1d75ed71ce = function_676affebd39047b8( var_50c93f307caa0d62 );
            var_33844fc9fd2e2696 = var_50c93f307caa0d62.size - var_da00bd1d75ed71ce.size;
            var_e001f312269c1d57 = 0;
            
            if ( isdefined( level.var_4c4db1fc01e4deaa ) && isdefined( level.var_4c4db1fc01e4deaa[ var_570a26cf7e5061b8 ] ) )
            {
                var_93f0ba585ff21689 = function_5c99f07b9f5eba69( level.var_4c4db1fc01e4deaa[ var_570a26cf7e5061b8 ] );
                var_e001f312269c1d57 = level.var_4c4db1fc01e4deaa[ var_570a26cf7e5061b8 ].size - var_93f0ba585ff21689.size;
            }
            
            var_b9266667595513af = var_c55ece3ed079b4ba - var_33844fc9fd2e2696 + var_e001f312269c1d57;
            
            if ( var_b9266667595513af <= 0 && !var_c9c6b6e3d2ac2d23 )
            {
                if ( !var_1cb654a92ad6f4b5 && !isdefined( level.var_8bb02c00f1abc7ab[ var_570a26cf7e5061b8 ] ) )
                {
                    level.var_8bb02c00f1abc7ab[ var_570a26cf7e5061b8 ] = round_number + function_46e360e8daf50cb4();
                }
                
                continue;
            }
            
            if ( var_c9c6b6e3d2ac2d23 )
            {
                var_9520c6ac8bfeec27 = var_da00bd1d75ed71ce.size;
            }
            else if ( var_1cb654a92ad6f4b5 )
            {
                var_9520c6ac8bfeec27 = 1;
            }
            else
            {
                next_respawn_round = level.var_8bb02c00f1abc7ab[ var_570a26cf7e5061b8 ];
                
                if ( !isdefined( next_respawn_round ) )
                {
                    next_respawn_round = round_number + function_46e360e8daf50cb4();
                    level.var_8bb02c00f1abc7ab[ var_570a26cf7e5061b8 ] = next_respawn_round;
                }
                
                if ( round_number < next_respawn_round )
                {
                    continue;
                }
                
                var_9520c6ac8bfeec27 = randomint( 3 );
                level.var_8bb02c00f1abc7ab[ var_570a26cf7e5061b8 ] = round_number + function_46e360e8daf50cb4();
            }
            
            if ( !var_c9c6b6e3d2ac2d23 )
            {
                var_9520c6ac8bfeec27 = min( var_9520c6ac8bfeec27, var_b9266667595513af );
            }
            
            var_9520c6ac8bfeec27 = min( var_9520c6ac8bfeec27, var_da00bd1d75ed71ce.size );
            
            if ( var_9520c6ac8bfeec27 < 1 )
            {
                continue;
            }
            
            for ( i = 0; i < var_9520c6ac8bfeec27 ; i++ )
            {
                cocoon_to_spawn = utility::array_random( var_da00bd1d75ed71ce );
                
                if ( !isdefined( cocoon_to_spawn ) )
                {
                    continue;
                }
                
                location = cocoon_to_spawn.script_noteworthy;
                save_key = hashcat( #"hash_eb570444d2985427", location );
                storage_int = zm_quest::function_73720cdf21c3cfd7( #"hash_566ab33b3b3236dd", save_key ) ?? 0;
                
                if ( isdefined( storage_int ) && isdefined( cocoon_to_spawn.script_count ) )
                {
                    index = cocoon_to_spawn.script_count;
                    is_broken = utility::get_bit_flag( storage_int, index );
                    
                    if ( level.var_9286dfceac05819c && var_1cb654a92ad6f4b5 && is_broken )
                    {
                        var_da00bd1d75ed71ce = arrayremove( var_da00bd1d75ed71ce, cocoon_to_spawn );
                        
                        if ( var_da00bd1d75ed71ce.size <= 0 )
                        {
                            break;
                        }
                        
                        i--;
                        continue;
                    }
                }
                
                if ( isdefined( cocoon_to_spawn.script_count ) )
                {
                    index = cocoon_to_spawn.script_count;
                    storage_int = utility::function_911d2d3c6d773726( storage_int, index );
                    zm_quest::function_4eefe6de31f5ddab( #"hash_566ab33b3b3236dd", save_key, storage_int );
                }
                
                cocoon_to_spawn.mound utility::function_7c10ea82c1e305b8( "cocoon", "active" );
                cocoon_to_spawn.mound utility::function_7c10ea82c1e305b8( "model", "normal" );
                cocoon_to_spawn.mound.var_6d3fb2276d93187f = 0;
                cocoon_to_spawn.mound thread function_ff8bd1755114482a();
                cocoon_to_spawn.mound thread function_b069c5e7073e2089();
                var_da00bd1d75ed71ce = arrayremove( var_da00bd1d75ed71ce, cocoon_to_spawn );
                cocoon_to_spawn.mound utility::ent_flag_clear( "can_spawn" );
            }
        }
        
        level.var_79ee10f043d51b21 = 1;
    }
    
    level.var_902e9004b8a0a245 = 1;
    level.var_9286dfceac05819c = 0;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0xa5ee9f9c, Offset: 0x35b1
// Size: 0x28f
function function_ff8bd1755114482a()
{
    level endon( #"game_ended" );
    self endon( #"dig" );
    self.var_6d3fb2276d93187f = 0;
    
    while ( !self.var_6d3fb2276d93187f )
    {
        foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
        {
            if ( mote.var_648eef0ab0822c74 || !mote.e_mover )
            {
                continue;
            }
            
            if ( mote utility::ent_flag( "mote_in_use" ) )
            {
                continue;
            }
            
            if ( distance2dsquared( self.origin, mote.origin ) < 4096 )
            {
                mote utility::ent_flag_set( "mote_moving" );
                move_to_origin = ( self.type == "zm_sat_scarab_loot_cocoon_1" || self.type == "zm_sat_scarab_loot_cocoon_2" || self.type == "zm_sat_scarab_loot_cocoon_3" ) && isdefined( self.cocoon_loc.mote_pos_struct ) ? self.cocoon_loc.mote_pos_struct.origin : self.origin;
                distance = distance( mote.e_mover.origin, move_to_origin );
                move_time = distance / 400;
                mote thread function_a8c7ca90ecfc06c5( move_time );
                mote.e_mover moveto( move_to_origin, move_time );
                mote.e_mover waittill( #"movedone" );
                mote utility::ent_flag_set( "mote_in_dig_pile" );
                mote utility::ent_flag_clear( "mote_moving" );
                mote.e_mover notify( #"death" );
                self.var_6d3fb2276d93187f = 1;
                self setscriptablepartstate( "absorb_mote_fx", "absorbed" );
                level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = arrayremove( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, mote );
                utility::delaythread( 1, &function_2781c54af3103968, mote );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0xf6e62f39, Offset: 0x3848
// Size: 0xe9, Type: bool
function private function_9995435da50af4f3( mound )
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( distance2dsquared( player.origin, mound.origin ) > 3136 )
        {
            continue;
        }
        
        z_delta = player.origin[ 2 ] - mound.origin[ 2 ];
        
        if ( z_delta >= -10 && z_delta <= 80 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x9b3ef222, Offset: 0x393a
// Size: 0x6d
function private function_2781c54af3103968( mote )
{
    if ( isdefined( mote ) )
    {
        if ( isdefined( mote.var_a956dd9dc52c323c ) )
        {
            mote utility::scriptable_clearparententity();
            mote.var_a956dd9dc52c323c delete();
            mote.var_a956dd9dc52c323c = undefined;
        }
        
        mote setscriptablepartstate( "body", "despawn" );
        mote.e_mover delete();
        mote freescriptable();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x5ffd6b45, Offset: 0x39af
// Size: 0x1b9
function private function_a8c7ca90ecfc06c5( move_time )
{
    self.e_mover endon( #"death" );
    utility::scriptable_clearparententity();
    self.var_a956dd9dc52c323c = utility::spawn_model( "tag_origin", self.e_mover.origin, self.e_mover.angles );
    utility::scriptable_setparententity( self.var_a956dd9dc52c323c );
    self.var_a956dd9dc52c323c linkto( self.e_mover );
    start_time = gettime();
    
    while ( true )
    {
        if ( gettime() - start_time >= utility::function_4b74c15943231980( move_time ) )
        {
            utility::scriptable_clearparententity();
            
            if ( isdefined( self.var_a956dd9dc52c323c ) )
            {
                self.var_a956dd9dc52c323c delete();
                self.var_a956dd9dc52c323c = undefined;
            }
            
            utility::scriptable_setparententity( self.e_mover );
            return;
        }
        
        if ( !isdefined( self.var_a956dd9dc52c323c ) )
        {
            return;
        }
        
        random_offset_x = randomintrange( -5, 5 );
        random_offset_y = randomintrange( -5, 5 );
        random_offset_z = randomintrange( -5, 5 );
        new_origin = ( self.e_mover.origin[ 0 ] + random_offset_x, self.e_mover.origin[ 1 ] + random_offset_y, self.e_mover.origin[ 2 ] + random_offset_z );
        self.var_a956dd9dc52c323c movetolinked( new_origin - self.e_mover.origin, 0.05 );
        wait 0.05;
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0xb4999eb6, Offset: 0x3b70
// Size: 0xd1
function private function_ad87a39d9ad82e1( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        mound = usable;
        z_dist = abs( mound.origin[ 2 ] - player.origin[ 2 ] );
        
        if ( z_dist > 50 )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 5
// Checksum 0xde6924a3, Offset: 0x3c4a
// Size: 0x82
function function_ed1f39a6fcb2e77f( event, instance, note, param, var_64ffacba090c91be )
{
    sparams = spawnstruct();
    sparams.instance = instance;
    sparams.note = note;
    sparams.param = param;
    sparams.var_64ffacba090c91be = var_64ffacba090c91be;
    callback::callback( event, sparams );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xea723aab, Offset: 0x3cd4
// Size: 0xd0
function function_5c99f07b9f5eba69( var_514ad48ced161cf8 )
{
    var_93f0ba585ff21689 = [];
    
    foreach ( digging_mound_loc in var_514ad48ced161cf8 )
    {
        if ( isdefined( digging_mound_loc.mound ) && digging_mound_loc.mound utility::ent_flag( "can_spawn" ) && digging_mound_loc.mound getscriptablepartstate( "digging_mound" ) == "dug" )
        {
            var_93f0ba585ff21689[ var_93f0ba585ff21689.size ] = digging_mound_loc;
        }
    }
    
    return var_93f0ba585ff21689;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xa205bf2b, Offset: 0x3dad
// Size: 0xd0
function function_676affebd39047b8( var_50c93f307caa0d62 )
{
    var_da00bd1d75ed71ce = [];
    
    foreach ( cocoon_loc in var_50c93f307caa0d62 )
    {
        if ( isdefined( cocoon_loc.mound ) && cocoon_loc.mound utility::ent_flag( "can_spawn" ) && cocoon_loc.mound getscriptablepartstate( "cocoon" ) == "broken" )
        {
            var_da00bd1d75ed71ce[ var_da00bd1d75ed71ce.size ] = cocoon_loc;
        }
    }
    
    return var_da00bd1d75ed71ce;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0xff6cbb1e, Offset: 0x3e86
// Size: 0xb
function function_46e360e8daf50cb4()
{
    return 2 + randomint( 3 );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x7ee68089, Offset: 0x3e9a
// Size: 0x59
function function_b069c5e7073e2089()
{
    level endon( #"game_ended" );
    self endon( #"dig" );
    
    while ( true )
    {
        if ( istrue( level.var_b4dda33ddfa10498 ) )
        {
            utility::draw_circle( self.origin, sqrt( 16384 ), ( 1, 0, 0 ), 1, 0, 1 );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x49a6d498, Offset: 0x3efb
// Size: 0xd1
function private function_8fb57ed441c7e965( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        cocoon = usable;
        z_dist = abs( cocoon.origin[ 2 ] - player.origin[ 2 ] );
        
        if ( z_dist > 200 )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0xfa6e61b9, Offset: 0x3fd5
// Size: 0x53
function function_b078bcb12b7df80e( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped && !b_save_restored )
    {
        return;
    }
    
    level.var_9286dfceac05819c = b_save_restored;
    level thread init_piles();
    
    if ( b_save_restored )
    {
        return;
    }
    
    utility::flag_wait( "player_dig_piles" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0xf8449e69, Offset: 0x4030
// Size: 0x20
function function_13eb341f7b141e3b( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0x7d2b2d15, Offset: 0x4058
// Size: 0x2d
function setup_wait_jumpscare( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    utility::flag_wait( "player_jumpscare_triggered" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0xe78ba7b6, Offset: 0x408d
// Size: 0x20
function cleanup_wait_jumpscare( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0x98ef761a, Offset: 0x40b5
// Size: 0x21
function setup_loop_spawn( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2
// Checksum 0x73b00ce2, Offset: 0x40de
// Size: 0x20
function cleanup_loop_spawn( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

/#

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0
    // Checksum 0xa5ca3707, Offset: 0x4106
    // Size: 0x50, Type: dev
    function function_2ccb0b6655b4d693()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarint( @"hash_8bb186c2dd4bc06f", 0 ) )
            {
                player = level.players[ 0 ];
                use_np( player );
            }
        }
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0x7e44d583, Offset: 0x415e
    // Size: 0x727, Type: dev
    function private dev_watcher()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            wait 0.1;
            
            if ( getdvarint( @"hash_18e45d9295580b36", 0 ) )
            {
                setdvar( @"hash_18e45d9295580b36", 0 );
                
                foreach ( p in level.players )
                {
                    if ( !isalive( p ) )
                    {
                        continue;
                    }
                    
                    scene_node = spawnstruct();
                    scene_node.origin = p.origin;
                    scene_node.angles = p.angles;
                    spawn_origin = p.origin + anglestoforward( p.angles ) * 64;
                    thread function_d609b995a364404d( scene_node, spawn_origin, p );
                }
            }
            
            if ( getdvarint( @"hash_ac880d293f9eb691", 0 ) )
            {
                setdvar( @"hash_ac880d293f9eb691", 0 );
                
                foreach ( p in level.players )
                {
                    if ( !isalive( p ) )
                    {
                        continue;
                    }
                    
                    spawn_origin = p.origin + anglestoforward( p.angles ) * 128;
                    zombie = agent_manager::spawn_agent( "<dev string:x24>", spawn_origin, p.angles, "<dev string:x37>" );
                    movespeed = zm_round_spawning::function_6211dbc10409aa10();
                    zombie zombie_utils::function_a8ce00e0448cb6f0( movespeed, "<dev string:x48>", 1 );
                }
            }
            
            if ( getdvarint( @"hash_f97c702d29b67331", 0 ) )
            {
                setdvar( @"hash_f97c702d29b67331", 0 );
                n_round = zm_round_logic::get_rb_round_number();
                
                if ( isdefined( level.var_dab84f36260cdff2 ) )
                {
                    if ( n_round < 15 )
                    {
                        digging_mound_item_list = level.var_dab84f36260cdff2.var_73b01f25eb647a35;
                    }
                    else if ( n_round < 35 )
                    {
                        digging_mound_item_list = level.var_dab84f36260cdff2.var_e909debff4b84462;
                    }
                    else if ( n_round < 55 )
                    {
                        digging_mound_item_list = level.var_dab84f36260cdff2.var_30c4cd07b94fe37c;
                    }
                    else
                    {
                        digging_mound_item_list = level.var_dab84f36260cdff2.var_286037f4793c2de1;
                    }
                    
                    foreach ( p in level.players )
                    {
                        if ( !isalive( p ) )
                        {
                            continue;
                        }
                        
                        v_loot_spawn_loc = p.origin + ( 0, 0, 32 );
                        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_loot_spawn_loc );
                        level common_item::function_38cde6a6acb68ea6( digging_mound_item_list, 2, spawnoptions );
                    }
                    
                    iprintlnbold( "<dev string:x50>" );
                }
            }
            
            if ( getdvarint( @"hash_761153dac6b6d385", 0 ) && !level.var_158d47c0fe257d75 )
            {
                level.var_158d47c0fe257d75 = 1;
                setdvar( @"hash_9a97c82f6d189680", 100 );
                setdvar( @"hash_b4835deecba41914", 0 );
                setdvar( @"hash_da4b7c92d8a43d64", 0 );
                
                foreach ( p in level.players )
                {
                    p zm_ncfdpedestal::give_grappling_hook();
                }
                
                iprintlnbold( "<dev string:x5a>" );
            }
            else if ( !getdvarint( @"hash_761153dac6b6d385", 0 ) && level.var_158d47c0fe257d75 )
            {
                level.var_158d47c0fe257d75 = 0;
                setdvar( @"hash_9a97c82f6d189680", 5 );
                setdvar( @"hash_b4835deecba41914", 25 );
                setdvar( @"hash_da4b7c92d8a43d64", 70 );
            }
            
            if ( getdvarint( @"hash_854a8ee83b41499", 0 ) && !level.var_641e4759cd3d0ee3 )
            {
                level.var_641e4759cd3d0ee3 = 1;
                setdvar( @"hash_9a97c82f6d189680", 0 );
                setdvar( @"hash_b4835deecba41914", 100 );
                setdvar( @"hash_da4b7c92d8a43d64", 0 );
                
                foreach ( p in level.players )
                {
                    p zm_ncfdpedestal::give_grappling_hook();
                }
                
                iprintlnbold( "<dev string:x77>" );
            }
            else if ( !getdvarint( @"hash_854a8ee83b41499", 0 ) && level.var_641e4759cd3d0ee3 )
            {
                level.var_641e4759cd3d0ee3 = 0;
                setdvar( @"hash_9a97c82f6d189680", 5 );
                setdvar( @"hash_b4835deecba41914", 25 );
                setdvar( @"hash_da4b7c92d8a43d64", 70 );
            }
            
            if ( getdvarint( @"hash_c7c30b0f5a3c5cd5", 0 ) && !level.var_a6086acdfd8d6d9f )
            {
                level.var_a6086acdfd8d6d9f = 1;
                setdvar( @"hash_9a97c82f6d189680", 0 );
                setdvar( @"hash_b4835deecba41914", 0 );
                setdvar( @"hash_da4b7c92d8a43d64", 100 );
                
                foreach ( p in level.players )
                {
                    p zm_ncfdpedestal::give_grappling_hook();
                }
                
                iprintlnbold( "<dev string:x97>" );
                continue;
            }
            
            if ( !getdvarint( @"hash_c7c30b0f5a3c5cd5", 0 ) && level.var_a6086acdfd8d6d9f )
            {
                level.var_a6086acdfd8d6d9f = 0;
                setdvar( @"hash_9a97c82f6d189680", 5 );
                setdvar( @"hash_b4835deecba41914", 25 );
                setdvar( @"hash_da4b7c92d8a43d64", 70 );
            }
        }
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0x731b8a64, Offset: 0x488d
    // Size: 0x70, Type: dev
    function private setup_jumpscare_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:xb4>" );
        devgui::add_devgui_func( "<dev string:xd1>", "<dev string:xe2>", &function_7b78d2fee4138f9e );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x10a>", &function_67ac0e9883651c );
        devgui::add_devgui_func( "<dev string:x121>", "<dev string:x12d>", &function_41c9e5efbf25dd20 );
        devgui::add_devgui_func( "<dev string:x142>", "<dev string:x154>", &function_a9283fd829b8c230 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0x8c4d4cfc, Offset: 0x4905
    // Size: 0x22, Type: dev
    function private function_7b78d2fee4138f9e()
    {
        setdvar( @"hash_761153dac6b6d385", !getdvarint( @"hash_761153dac6b6d385", 0 ) );
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0xe14bc34d, Offset: 0x492f
    // Size: 0x22, Type: dev
    function private function_67ac0e9883651c()
    {
        setdvar( @"hash_854a8ee83b41499", !getdvarint( @"hash_854a8ee83b41499", 0 ) );
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0x813afe30, Offset: 0x4959
    // Size: 0x22, Type: dev
    function private function_41c9e5efbf25dd20()
    {
        setdvar( @"hash_c7c30b0f5a3c5cd5", !getdvarint( @"hash_c7c30b0f5a3c5cd5", 0 ) );
    }

    // Namespace zm_sat_scarab_ee_jumpscare
    // Params 0, eflags: 0x4
    // Checksum 0x122c89, Offset: 0x4983
    // Size: 0x3d, Type: dev
    function private function_a9283fd829b8c230()
    {
        level.var_b4dda33ddfa10498 = !istrue( level.var_b4dda33ddfa10498 );
        iprintlnbold( "<dev string:x170>" + ( level.var_b4dda33ddfa10498 ? "<dev string:x17f>" : "<dev string:x182>" ) );
    }

#/

// Namespace zm_sat_scarab_ee_jumpscare
// Params 3, eflags: 0x4
// Checksum 0x62bf8601, Offset: 0x49c8
// Size: 0x4e
function private function_bec21efdcf12a64e( jumpscareweight, zombieweight, lootweight )
{
    setdvar( @"hash_9a97c82f6d189680", jumpscareweight );
    setdvar( @"hash_b4835deecba41914", zombieweight );
    setdvar( @"hash_da4b7c92d8a43d64", lootweight );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x2533029d, Offset: 0x4a1e
// Size: 0x2d
function private function_8cecd35787e749a1()
{
    level.var_158d47c0fe257d75 = 0;
    level.var_641e4759cd3d0ee3 = 0;
    level.var_a6086acdfd8d6d9f = 0;
    function_bec21efdcf12a64e( 5, 25, 70 );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x748a3cc2, Offset: 0x4a53
// Size: 0x60
function private function_231fd15d824ed046( params )
{
    if ( isdefined( params[ 0 ] ) )
    {
        level.var_b4dda33ddfa10498 = int( params[ 0 ] ) != 0;
    }
    else
    {
        level.var_b4dda33ddfa10498 = !istrue( level.var_b4dda33ddfa10498 );
    }
    
    iprintlnbold( "Mound radius: " + ( level.var_b4dda33ddfa10498 ? "ON" : "OFF" ) );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x62ff9def, Offset: 0x4abb
// Size: 0x37
function private function_dfc4927231b47259( params, defaultvalue )
{
    var_f1fbc291f2430b1e = defaultvalue;
    
    if ( isdefined( params[ 0 ] ) )
    {
        var_f1fbc291f2430b1e = int( params[ 0 ] ) != 0;
    }
    
    return var_f1fbc291f2430b1e;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x7a648495, Offset: 0x4afb
// Size: 0xeb
function private function_44a180cfe04405f4( params )
{
    var_f1fbc291f2430b1e = function_dfc4927231b47259( params, 1 );
    
    if ( !var_f1fbc291f2430b1e )
    {
        function_8cecd35787e749a1();
        return;
    }
    
    level.var_158d47c0fe257d75 = 1;
    level.var_641e4759cd3d0ee3 = 0;
    level.var_a6086acdfd8d6d9f = 0;
    function_bec21efdcf12a64e( 100, 0, 0 );
    
    foreach ( p in level.players )
    {
        p.b_jumpscare_triggered = 0;
        p.should_play_jumpscare = 0;
        p zm_ncfdpedestal::give_grappling_hook();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x7e17345b, Offset: 0x4bee
// Size: 0xeb
function private function_f2b6930234a28322( params )
{
    var_f1fbc291f2430b1e = function_dfc4927231b47259( params, 1 );
    
    if ( !var_f1fbc291f2430b1e )
    {
        function_8cecd35787e749a1();
        return;
    }
    
    level.var_158d47c0fe257d75 = 0;
    level.var_641e4759cd3d0ee3 = 1;
    level.var_a6086acdfd8d6d9f = 0;
    function_bec21efdcf12a64e( 0, 100, 0 );
    
    foreach ( p in level.players )
    {
        p.b_jumpscare_triggered = 0;
        p.should_play_jumpscare = 0;
        p zm_ncfdpedestal::give_grappling_hook();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x2e151230, Offset: 0x4ce1
// Size: 0xeb
function private function_616e6752054d8daa( params )
{
    var_f1fbc291f2430b1e = function_dfc4927231b47259( params, 1 );
    
    if ( !var_f1fbc291f2430b1e )
    {
        function_8cecd35787e749a1();
        return;
    }
    
    level.var_158d47c0fe257d75 = 0;
    level.var_641e4759cd3d0ee3 = 0;
    level.var_a6086acdfd8d6d9f = 1;
    function_bec21efdcf12a64e( 0, 0, 100 );
    
    foreach ( p in level.players )
    {
        p.b_jumpscare_triggered = 0;
        p.should_play_jumpscare = 0;
        p zm_ncfdpedestal::give_grappling_hook();
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0x472fd9f9, Offset: 0x4dd4
// Size: 0x54
function private function_4b1262aed9a9bc26( params )
{
    if ( !isdefined( level.players ) || level.players.size <= 0 )
    {
        return;
    }
    
    player = level.players[ 0 ];
    
    if ( isalive( player ) )
    {
        use_np( player );
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xeb882bc, Offset: 0x4e30
// Size: 0x8d
function use_np( player )
{
    if ( player.var_819dfee5ff9a56d6 )
    {
        return;
    }
    
    if ( player.n_charge_times >= level.var_b6a4b93f9f863428 )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"ncfd", #"hash_81eb587ae514df01" ) && ![[ utility::getsharedfunc( #"ncfd", #"hash_81eb587ae514df01" ) ]]() )
    {
        return;
    }
    
    player thread zm_ncfdpedestal::function_8e1671683c63ebb6();
    player zm_ncfdpedestal::give_grappling_hook();
    player.n_charge_times++;
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1
// Checksum 0xb2f5c232, Offset: 0x4ec5
// Size: 0x26
function function_51f847aef825ec26( player )
{
    player enableoffhandweapons();
    player equipment_mp::giveequipment( "equip_grappling_hook_dreadspinner_ee", "secondary" );
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0
// Checksum 0x28717463, Offset: 0x4ef3
// Size: 0x1dc
function function_a6c65ee7c44b6c6a()
{
    level endon( #"game_ended" );
    var_711f0743c5d60606 = getnoentvolumearray( "give_near_grapple_zone", "script_noteworthy" );
    
    foreach ( player in level.players )
    {
        player.var_d8c18af2d45dcd94 = 0;
    }
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                is_equip_grapple = player getscriptablepartstate( "ncfd_pedestal_charge" ) == "on";
                
                if ( !is_equip_grapple )
                {
                    continue;
                }
                
                foreach ( volume in var_711f0743c5d60606 )
                {
                    if ( player istouching( volume ) && !player.var_d8c18af2d45dcd94 )
                    {
                        function_51f847aef825ec26( player );
                        player.var_d8c18af2d45dcd94 = 1;
                        break;
                    }
                }
            }
        }
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x93135c27, Offset: 0x50d7
// Size: 0x2bc
function private function_7120011bd3b5690b()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "digging_initialized" );
    
    while ( true )
    {
        if ( isdefined( level.var_45394b2b5d20107f ) )
        {
            foreach ( var_50c93f307caa0d62 in level.var_45394b2b5d20107f )
            {
                foreach ( cocoon_loc in var_50c93f307caa0d62 )
                {
                    cocoon = cocoon_loc.mound;
                    
                    if ( !isdefined( cocoon ) )
                    {
                        continue;
                    }
                    
                    if ( cocoon getscriptablepartstate( "cocoon" ) != "active" )
                    {
                        continue;
                    }
                    
                    nearby_scriptables = getentitylessscriptablearray( undefined, undefined, cocoon.origin, 72 );
                    
                    foreach ( nearby_entity in nearby_scriptables )
                    {
                        if ( !isdefined( nearby_entity ) || nearby_entity == cocoon )
                        {
                            continue;
                        }
                        
                        var_1646ecec8f0b5f9d = nearby_entity.type == "equip_combat_bow_fire_pool_mp" || nearby_entity.type == "equip_molotov_pool_sat_mp_p" || nearby_entity.type == "equip_thermobaric_pool_mp_p" || nearby_entity.type == "equip_oil_slick_pool_mp_p" || nearby_entity.type == "equip_propane_tank_pool_br" || nearby_entity.type == "napalmburst_augment_pool" || nearby_entity.type == "equip_thermite_shot_pool_mp_p" || nearby_entity.type == "rex_white_phos_pool_mp";
                        
                        if ( !var_1646ecec8f0b5f9d )
                        {
                            continue;
                        }
                        
                        var_172b9b7d177fec6f = function_308103dff44b654e( nearby_entity );
                        
                        if ( !isplayer( var_172b9b7d177fec6f ) )
                        {
                            continue;
                        }
                        
                        cocoon thread attempt_dig_used( var_172b9b7d177fec6f );
                        break;
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_scarab_ee_jumpscare
// Params 1, eflags: 0x4
// Checksum 0xff223b3, Offset: 0x539b
// Size: 0xcc
function private function_308103dff44b654e( fire_pool_entity )
{
    if ( isdefined( fire_pool_entity.var_7f406cb56e4d92a4 ) && isplayer( fire_pool_entity.var_7f406cb56e4d92a4.owner ) )
    {
        return fire_pool_entity.var_7f406cb56e4d92a4.owner;
    }
    
    if ( isplayer( fire_pool_entity.owner ) )
    {
        return fire_pool_entity.owner;
    }
    
    if ( isdefined( fire_pool_entity.inflictor ) && isplayer( fire_pool_entity.inflictor.owner ) )
    {
        return fire_pool_entity.inflictor.owner;
    }
    
    if ( isplayer( fire_pool_entity.inflictor ) )
    {
        return fire_pool_entity.inflictor;
    }
}

