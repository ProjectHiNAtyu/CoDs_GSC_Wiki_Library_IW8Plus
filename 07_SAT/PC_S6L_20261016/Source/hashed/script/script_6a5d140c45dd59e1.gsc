// script_6a5d140c45dd59e1  (hash_6a5d140c45dd59e1.gscc) (size: 15873 Bytes / 0x3e01 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x367445e5 (913589733)
// size ...... 15873 (0x3e01)
// includes .. 17  (offset: 0x3981)
// strings ... 52  (offset: 0x3a09)
// dev strs .. 16  (offset: 0x3d15)
// exports ... 35  (offset: 0x2485)
// cseg ...... 0x52e + 0x1f57 (0x2485)
// imports ... 128 (offset: 0x29fd)
// animtree1 . 0   (offset: 0x3e01)
// animtree2 . 0   (offset: 0x3e01)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_aea5a1566beb211f;

// Namespace namespace_aea5a1566beb211f
// Params 0, eflags: 0x5
// Checksum 0xddd6da86, Offset: 0x54c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_1b4fd7272e3d32a4", undefined, undefined, &post_main );
}

// Namespace namespace_aea5a1566beb211f
// Params 0, eflags: 0x4
// Checksum 0x10cb3008, Offset: 0x56d
// Size: 0xf2
function private post_main()
{
    if ( !getdvarint( @"hash_bb9c6e9d56b8b577", 0 ) )
    {
        return;
    }
    
    level._effect[ "bunker_vfx_break" ] = loadfxasset( "vfx_sat_levels_zm_mantis_doorbuy_debris_aether_window_unlock" );
    level._effect[ "vfx_meat_cooked" ] = loadfxasset( "vfx_t10_levels_zm_quartz_smoke_light_ee" );
    zm_quest::register_quest_step( #"hash_3fd38e49a0c0f36d", #"hash_e38462977157a9c2", &function_8e1f229fbe8d8c38, &function_c7eb5cec3ff9bcc1 );
    zm_quest::register_quest_step( #"hash_3fd38e49a0c0f36d", #"cook_food", &function_ef12daf13094f4f1, &function_b9f27c8654d64a68 );
    zm_quest::register_quest_step( #"hash_3fd38e49a0c0f36d", #"hash_50d2c9243b1f0ce0", &function_a1c30eab64be5090, &function_e42f8691df155a39 );
    zm_quest::register_quest_step( #"hash_3fd38e49a0c0f36d", #"open_bunker", &function_3927cc7f806715e6, &function_cde1e22001b576c3 );
    level utility::flag_wait( "begin_round_logic" );
    level thread function_881455e938264871();
    
    /#
        function_2e521f175c1b7f2e();
    #/
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xed459724, Offset: 0x667
// Size: 0x45
function function_881455e938264871()
{
    level endon( #"game_ended" );
    
    while ( wwq_is_active() )
    {
        /#
            if ( getdvarint( @"hash_4b4e34f5a1bb8d1", 0 ) )
            {
                break;
            }
        #/
        
        wait 1;
    }
    
    level thread zm_quest::start_quest( #"hash_3fd38e49a0c0f36d" );
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xe0b6893a, Offset: 0x6b4
// Size: 0x33, Type: bool
function wwq_is_active()
{
    wwq = level.zm_quests[ #"mantis_ww_quest" ];
    return wwq && !wwq.completed;
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xf7252e48, Offset: 0x6f0
// Size: 0x16d
function function_8e1f229fbe8d8c38( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_5fc7b1ff93191543 ) )
    {
        level.var_5fc7b1ff93191543 = spawnstruct();
    }
    
    if ( b_save_restored )
    {
        var_661a432ea925a1b0 = utility::getstruct( "mannequin_first_meet_loc", "script_noteworthy" );
        stand_mannequin = spawnscriptable( "sat_zm_mantis_mannequin_wish_ee_mannequin", var_661a432ea925a1b0.origin, var_661a432ea925a1b0.angles );
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0 = stand_mannequin;
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip = getent( var_661a432ea925a1b0.targetname, "target" );
        
        if ( level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip )
        {
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip solid();
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip show();
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip disconnectpaths();
        }
        
        return;
    }
    
    function_8a2f38bbbdc7d0ff( "past" );
    function_aa111474553aeb11();
    cook_food_progress();
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xc1b29c2, Offset: 0x865
// Size: 0x151
function function_aa111474553aeb11()
{
    level endon( #"game_ended" );
    var_661a432ea925a1b0 = utility::getstruct( "mannequin_first_meet_loc", "script_noteworthy" );
    stand_mannequin = spawnscriptable( "sat_zm_mantis_mannequin_wish_ee_mannequin", var_661a432ea925a1b0.origin, var_661a432ea925a1b0.angles );
    level.var_5fc7b1ff93191543.var_db405a3c00a166d0 = stand_mannequin;
    level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip = getent( var_661a432ea925a1b0.targetname, "target" );
    
    if ( level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip )
    {
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip solid();
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip show();
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip disconnectpaths();
    }
    
    var_cf09701b7d8d69c4 = [ "zone_house2_downstairs_f" ];
    level thread function_e37b458522446d43( var_cf09701b7d8d69c4, "mannequin_uncovered" );
    level waittill( #"mannequin_uncovered" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xfa2ebcb7, Offset: 0x9be
// Size: 0xac
function function_e37b458522446d43( var_cfdcb332178e0755, notify_message )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( zone in var_cfdcb332178e0755 )
        {
            if ( zone_manager::get_zone_occupants( zone ).size > 0 )
            {
                level notify( notify_message );
                return;
            }
            
            wait 0.5;
        }
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0x14b403e7, Offset: 0xa72
// Size: 0x8c
function spawn_pan()
{
    pan_loc = utility::getstruct( "mw_pan_loc", "script_noteworthy" );
    level.var_5fc7b1ff93191543.var_691ad10148a80cc = spawn( "script_model", pan_loc.origin );
    level.var_5fc7b1ff93191543.var_691ad10148a80cc.angles = pan_loc.angles;
    level.var_5fc7b1ff93191543.var_691ad10148a80cc setmodel( "kitchen_cookware_pan_01" );
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xdf44ffeb, Offset: 0xb06
// Size: 0x49
function cook_food_progress()
{
    level endon( #"game_ended" );
    spawn_pan();
    level.var_5fc7b1ff93191543.var_cbf009dd78df9771 = 0;
    level callback::add( "on_zombie_ai_killed", &function_50c65c1f87e18296 );
    level waittill( #"hash_c8d66ee50e2f69e1" );
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0xd855d8, Offset: 0xb57
// Size: 0x26b
function function_50c65c1f87e18296( params )
{
    check_loc = utility::getstruct( "pan_kill_distance_check", "script_noteworthy" );
    
    if ( distancesquared( params.origin, check_loc.origin ) < 3600 )
    {
        level.var_5fc7b1ff93191543.var_cbf009dd78df9771 += 1;
        
        if ( level.var_5fc7b1ff93191543.var_cbf009dd78df9771 >= 3 )
        {
            meat_target_pos = utility::getstruct( "pan_meat_loc", "script_noteworthy" );
            meat_spawn_height = min( params.origin[ 2 ] + 40, -60 );
            meat_spawn_loc = ( params.origin[ 0 ], params.origin[ 1 ], meat_spawn_height );
            level.var_5fc7b1ff93191543.var_21ae15d47851e43a = spawn( "script_model", meat_spawn_loc );
            level.var_5fc7b1ff93191543.var_21ae15d47851e43a.angles = meat_target_pos.angles;
            level.var_5fc7b1ff93191543.var_21ae15d47851e43a setmodel( "food_meat_01" );
            playfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), level.var_5fc7b1ff93191543.var_21ae15d47851e43a, "tag_origin" );
            playsoundatpos( level.var_5fc7b1ff93191543.var_21ae15d47851e43a.origin, #"evt_zm_cyst_loot_soul_wisp" );
            var_d524330523e6df2d = level.var_5fc7b1ff93191543.var_21ae15d47851e43a zm_quest::fake_physicslaunch( meat_target_pos.origin, 150 );
            level callback::remove( "on_zombie_ai_killed", &function_50c65c1f87e18296 );
            wait var_d524330523e6df2d;
            playsoundatpos( level.var_5fc7b1ff93191543.var_21ae15d47851e43a.origin, #"evt_zm_cyst_loot_soul_impact" );
            stopfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), level.var_5fc7b1ff93191543.var_21ae15d47851e43a, "tag_origin" );
            level.var_5fc7b1ff93191543.var_21ae15d47851e43a delete();
            level notify( #"hash_c8d66ee50e2f69e1" );
        }
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0x5dc68bf1, Offset: 0xdca
// Size: 0xd6
function function_c7eb5cec3ff9bcc1( b_skipped, b_save_restored )
{
    if ( !isdefined( level.var_5fc7b1ff93191543 ) )
    {
        level.var_5fc7b1ff93191543 = spawnstruct();
    }
    
    if ( !level.var_5fc7b1ff93191543.var_691ad10148a80cc )
    {
        spawn_pan();
    }
    
    meat_target_pos = utility::getstruct( "pan_meat_loc", "script_noteworthy" );
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a = spawn( "script_model", meat_target_pos.origin );
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a.angles = meat_target_pos.angles;
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a setmodel( "food_meat_01" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xa56bf017, Offset: 0xea8
// Size: 0x87
function function_ef12daf13094f4f1( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        level.var_5fc7b1ff93191543.var_21ae15d47851e43a setmodel( "cooked::" + "food_meat_01" );
        level thread function_31523a990e603bbf();
        return;
    }
    
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a setcandamage( 1 );
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a thread function_f3e974ff79733b51();
    level waittill( #"hash_85bf2f28114b1ba8" );
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xf56e88de, Offset: 0xf37
// Size: 0x10c
function function_f3e974ff79733b51()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isplayer( attacker ) )
        {
            if ( utility::shouldburnfromdamage( objweapon ) )
            {
                level.var_5fc7b1ff93191543.var_21ae15d47851e43a setcandamage( 0 );
                wait 1;
                level.var_5fc7b1ff93191543.var_21ae15d47851e43a setmodel( "cooked::" + "food_meat_01" );
                level thread function_31523a990e603bbf();
                attacker thread zm_vo::function_8c1a12974bd11f01( #"hash_523560dbeee001f7", #"bc_flavor_player_positive" );
                level notify( #"hash_85bf2f28114b1ba8" );
                return;
            }
        }
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xcbb6b1d9, Offset: 0x104b
// Size: 0x9a
function function_31523a990e603bbf()
{
    level endon( #"game_ended" );
    level.var_5fc7b1ff93191543.var_21ae15d47851e43a endon( #"death" );
    waitframe();
    
    if ( level.var_5fc7b1ff93191543.var_21ae15d47851e43a )
    {
        playsoundatpos( level.var_5fc7b1ff93191543.var_21ae15d47851e43a.origin, #"hash_4921ffb199428d4f" );
        playfxontag( level._effect[ "vfx_meat_cooked" ], level.var_5fc7b1ff93191543.var_21ae15d47851e43a, "tag_origin" );
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xf8854ba6, Offset: 0x10ed
// Size: 0x11e
function function_b9f27c8654d64a68( b_skipped, b_save_restored )
{
    if ( !isdefined( level.var_5fc7b1ff93191543 ) )
    {
        level.var_5fc7b1ff93191543 = spawnstruct();
    }
    
    level thread function_9a2e74043e071dac( [ level.var_5fc7b1ff93191543.var_21ae15d47851e43a, level.var_5fc7b1ff93191543.var_691ad10148a80cc ], "future" );
    
    if ( level.var_5fc7b1ff93191543.var_db405a3c00a166d0 )
    {
        level.var_5fc7b1ff93191543.var_db405a3c00a166d0 freescriptable();
        
        if ( level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip )
        {
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip notsolid();
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip connectpaths();
            level.var_5fc7b1ff93191543.var_db405a3c00a166d0.clip delete();
        }
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xcfcd8999, Offset: 0x1213
// Size: 0x298
function function_a1c30eab64be5090( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_save_restored )
    {
        return;
    }
    
    sit_mannequin_loc = utility::getstruct( "mannequin_eat_food_loc", "script_noteworthy" );
    level.var_5fc7b1ff93191543.var_835d4472b199c02 = spawnscriptable( "sat_zm_mantis_mannequin_wish_ee_mannequin_sit", sit_mannequin_loc.origin, sit_mannequin_loc.angles );
    plate_loc = utility::getstruct( "food_plate_loc", "script_noteworthy" );
    steak_loc = utility::getstruct( "steak_loc", "script_noteworthy" );
    fork_loc = utility::getstruct( "fork_loc", "script_noteworthy" );
    glasses_loc = utility::getstruct( "glasses_loc", "script_noteworthy" );
    level.var_5fc7b1ff93191543.var_2fd009835393ced8 = utility::spawn_model( "accessory_table_vintage_plate_metal", plate_loc.origin, plate_loc.angles );
    level.var_5fc7b1ff93191543.var_f9d2c7f819b3251f = utility::spawn_model( "cooked::food_meat_01", steak_loc.origin, steak_loc.angles );
    level.var_5fc7b1ff93191543.var_2319c57e8a496287 = utility::spawn_model( "t10_tableware_cutlery_fork_dinner_01_silver", fork_loc.origin, fork_loc.angles );
    level.var_5fc7b1ff93191543.var_8d0fc4ebf8051ee5 = utility::spawn_model( "c_t10_gear_aviator_sunglasses_02_brown", glasses_loc.origin, glasses_loc.angles );
    var_7854a4fcf8b7da9c = [ "zone_house2_downstairs_f" ];
    level thread function_e37b458522446d43( var_7854a4fcf8b7da9c, "sit_mannequin_uncovered" );
    level waittill( #"sit_mannequin_uncovered" );
    function_8a2f38bbbdc7d0ff( "past" );
    level.var_5fc7b1ff93191543.var_835d4472b199c02 freescriptable();
    level.var_5fc7b1ff93191543.var_f9d2c7f819b3251f delete();
    level.var_5fc7b1ff93191543.var_2319c57e8a496287 delete();
    level.var_5fc7b1ff93191543.var_8d0fc4ebf8051ee5 delete();
    level thread function_e37b458522446d43( var_7854a4fcf8b7da9c, "return_to_sit_mannequin" );
    level waittill( #"return_to_sit_mannequin" );
    powerups::force_powerup_drop( "bonus_points_team", level.var_5fc7b1ff93191543.var_2fd009835393ced8.origin, "quest" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xb27b2d5b, Offset: 0x14b3
// Size: 0xf0
function function_9a2e74043e071dac( var_f0110ccab3f4a8a6, timeline )
{
    level endon( #"game_ended" );
    function_8a2f38bbbdc7d0ff( timeline );
    
    foreach ( item in var_f0110ccab3f4a8a6 )
    {
        if ( item )
        {
            if ( item.clip )
            {
                item.clip notsolid();
                item.clip connectpaths();
                item.clip delete();
            }
            
            if ( item isscriptableinstance() )
            {
                item freescriptable();
                continue;
            }
            
            item delete();
        }
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0xe2654569, Offset: 0x15ab
// Size: 0x80
function function_8a2f38bbbdc7d0ff( timeline )
{
    level endon( #"game_ended" );
    utility::flag_wait( "timetravel_system_ready" );
    
    if ( utility::flag( "timetravel_ongoing" ) )
    {
        utility::flag_waitopen( "timetravel_ongoing" );
    }
    
    while ( isstruct( time_travel::get_current_timeline() ) && isstring( time_travel::get_current_timeline().name ) && time_travel::get_current_timeline().name != timeline )
    {
        wait 1;
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0x14511c0f, Offset: 0x1633
// Size: 0x3a
function function_e42f8691df155a39( b_skipped, b_save_restored )
{
    level thread function_9a2e74043e071dac( [ level.var_5fc7b1ff93191543.var_2fd009835393ced8 ], "past" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xdddb2396, Offset: 0x1675
// Size: 0x3b6
function function_3927cc7f806715e6( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    var_2cfc2bcc7e162cc1 = utility::getstruct( "mannequin_bunker_meet_loc", "script_noteworthy" );
    level.var_5fc7b1ff93191543.var_3377088708509c1b = spawnscriptable( "sat_zm_mantis_mannequin_wish_ee_mannequin", var_2cfc2bcc7e162cc1.origin, var_2cfc2bcc7e162cc1.angles );
    level.var_5fc7b1ff93191543.var_3377088708509c1b.clip = getent( var_2cfc2bcc7e162cc1.targetname, "target" );
    
    if ( level.var_5fc7b1ff93191543.var_3377088708509c1b.clip )
    {
        level.var_5fc7b1ff93191543.var_3377088708509c1b.clip solid();
        level.var_5fc7b1ff93191543.var_3377088708509c1b.clip show();
        level.var_5fc7b1ff93191543.var_3377088708509c1b.clip disconnectpaths();
    }
    
    if ( !isdefined( level.var_5fc7b1ff93191543.bunker_hit_count ) )
    {
        level.var_5fc7b1ff93191543.bunker_hit_count = 0;
    }
    
    var_5d86c4d5d0e7bc94 = utility::getstruct( "mw_zombie_attaractor", "script_noteworthy" );
    var_c1fa958f38d7bd3 = [ utility::getstruct( "lure_zombie_attack_location", "script_noteworthy" ) ];
    ent = utility::spawn_tag_origin( var_5d86c4d5d0e7bc94.origin, var_5d86c4d5d0e7bc94.angles );
    ent setcandamage( 1 );
    ent.health = 10000;
    attractor = zombie_attractor_manager::add_attractor( ent, 0, 600, 1, undefined, &function_2c23b36115b721ca, undefined, zm_utility::get_zombie_team() );
    zombie_attractor_manager::set_attractor_slots( attractor, var_c1fa958f38d7bd3 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( attractor, 360 );
    zombie_attractor_manager::function_a2aab3762aaa055f( attractor, var_5d86c4d5d0e7bc94.origin, ( 30, 30, 30 ), ( 0, 30, 0 ) );
    level thread attractor_damage_monitor( ent );
    level waittill( #"break_bunker" );
    playsoundatpos( ent.origin, #"hash_bedf18cc982ec02d" );
    playfx( level._effect[ "bunker_vfx_break" ], ent.origin );
    bunker_door = getent( "bunker_door", "script_noteworthy" );
    original_angles = bunker_door.angles;
    
    if ( bunker_door )
    {
        des_struct = utility::getstruct( bunker_door.target, "targetname" );
        bunker_door rotateto( des_struct.angles, 0.5 );
        bunker_door thread function_3f846fa9b4b605ea( original_angles );
    }
    
    a_nearby_players = utility::get_array_of_closest( var_5d86c4d5d0e7bc94.origin, level.players, undefined, undefined, 300 );
    
    foreach ( player in a_nearby_players )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_2aafeb998b41c784", #"bc_flavor_player_positive" );
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
    
    ent delete();
    generate_reward();
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0xe9360f6, Offset: 0x1a33
// Size: 0x41
function function_3f846fa9b4b605ea( angles )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    function_8a2f38bbbdc7d0ff( "future" );
    
    if ( self )
    {
        self rotateto( angles, 0.5 );
    }
}

// Namespace namespace_aea5a1566beb211f
// Params 0
// Checksum 0xf08a2fcf, Offset: 0x1a7c
// Size: 0x2f6
function generate_reward()
{
    inventory_group = %"hash_30d1f71d3877d096";
    reward_cache_loc = utility::getstruct( "final_reward_cache", "script_noteworthy" );
    level.var_5fc7b1ff93191543.reward_cache = utility::spawn_model( "decor_christmas_gift_04_big", reward_cache_loc.origin, reward_cache_loc.angles );
    var_da6fb44cbe49338d = [];
    
    foreach ( player in level.players )
    {
        var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_manngeuqin_wish_ee_rewards", "Default" );
        interact = common_cache::function_74364c32a1e82886( inventory_group, reward_cache_loc.origin, 50, &function_20c57d37ed73018a );
        interact sethintonobstruction( "show" );
        common_cache::function_61ef9e0b74e10aaf( interact.cache, var_8b5270de14dff72e );
        
        for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
        {
            item_name = var_8b5270de14dff72e[ i ];
            weapondata = undefined;
            
            if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
            {
                scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
                weaponname = scriptbundlestruct.baseweapon;
                rarity = scriptbundlestruct.rarity;
                favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
                
                if ( isdefined( favoriteweapon ) )
                {
                    item_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                    weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                    weapondata.rarity = rarity;
                    weapondata.weaponobj = favoriteweapon;
                }
            }
            
            skipomnvars = !isdefined( weapondata );
            common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, skipomnvars, undefined, weapondata );
        }
        
        interact enableplayeruse( player );
        var_da6fb44cbe49338d[ var_da6fb44cbe49338d.size ] = interact;
        interact.owner = player;
        
        foreach ( otherplayer in level.players )
        {
            if ( otherplayer != player )
            {
                interact disableplayeruse( otherplayer );
            }
        }
    }
    
    level thread function_fdf18b61df226cc3( var_da6fb44cbe49338d );
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0xba7f917f, Offset: 0x1d7a
// Size: 0x111
function function_fdf18b61df226cc3( var_da6fb44cbe49338d )
{
    level endon( #"game_ended" );
    
    while ( var_da6fb44cbe49338d.size > 0 )
    {
        var_42f35ac52d984286 = [];
        
        foreach ( cache_interact in var_da6fb44cbe49338d )
        {
            if ( cache_interact )
            {
                if ( common_cache::iscontainerempty( cache_interact.cache ) || !isplayer( cache_interact.owner ) )
                {
                    cache_interact notify( #"death" );
                    cache_interact delete();
                    continue;
                }
                
                var_42f35ac52d984286[ var_42f35ac52d984286.size ] = cache_interact;
            }
        }
        
        var_da6fb44cbe49338d = var_42f35ac52d984286;
        wait 0.5;
    }
    
    level thread function_9a2e74043e071dac( [ level.var_5fc7b1ff93191543.reward_cache ], "past" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0xe581687d, Offset: 0x1e93
// Size: 0x40
function function_20c57d37ed73018a( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0x4f9be04f, Offset: 0x1edc
// Size: 0x3a
function function_cde1e22001b576c3( b_skipped, b_save_restored )
{
    level thread function_9a2e74043e071dac( [ level.var_5fc7b1ff93191543.var_3377088708509c1b ], "future" );
}

// Namespace namespace_aea5a1566beb211f
// Params 2
// Checksum 0x7714c76b, Offset: 0x1f1e
// Size: 0x1d
function function_2c23b36115b721ca( attractor, zombie )
{
    return function_649077c2f6188850( zombie );
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0x1d39bdf5, Offset: 0x1f44
// Size: 0x36, Type: bool
function function_649077c2f6188850( zombie )
{
    return isalive( zombie ) && zombie zombie_utils::function_bf1464d09f4e4b40() && issubstr( zombie.subclass, "zombie_base" );
}

// Namespace namespace_aea5a1566beb211f
// Params 1
// Checksum 0x696a0a79, Offset: 0x1f83
// Size: 0x11d
function attractor_damage_monitor( source )
{
    level endon( #"death" );
    
    if ( !isdefined( level.var_5fc7b1ff93191543.bunker_hit_count ) )
    {
        level.var_5fc7b1ff93191543.bunker_hit_count = 0;
    }
    
    while ( true )
    {
        source waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( function_649077c2f6188850( attacker ) )
        {
            playsoundatpos( source.origin, #"hash_aaa1119e29f964bc" );
            level.var_5fc7b1ff93191543.bunker_hit_count++;
            
            if ( level.var_5fc7b1ff93191543.bunker_hit_count >= 7 )
            {
                level notify( #"break_bunker" );
                return;
            }
        }
    }
}

/#

    // Namespace namespace_aea5a1566beb211f
    // Params 0
    // Checksum 0x4dd092f, Offset: 0x20a8
    // Size: 0x86, Type: dev
    function function_2e521f175c1b7f2e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x41>", "<dev string:x41>", &function_e328ed74e37f63c2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x52>", "<dev string:x52>", &function_610e8e62af632aff );
        devgui::function_cd4e263c1f3018ae( "<dev string:x64>", "<dev string:x64>", &function_90e8c4291531fb95 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x73>", "<dev string:x73>", &function_19afb910a766b0c1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x83>", "<dev string:x83>", &function_b9edf1d7eba11488 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_aea5a1566beb211f
    // Params 1
    // Checksum 0x7e4021ad, Offset: 0x2136
    // Size: 0x141, Type: dev
    function function_e328ed74e37f63c2( params )
    {
        meat = spawn( "<dev string:x96>", ( 79043, -31671, -81 ) );
        meat setmodel( "<dev string:xa3>" );
        circle( meat.origin, 10, undefined, ( 1, 0, 0 ), undefined, 20 );
        meat_target_pos = utility::getstruct( "<dev string:xb0>", "<dev string:xbd>" );
        meat.angles = meat_target_pos.angles;
        playfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), meat, "<dev string:xcf>" );
        var_d524330523e6df2d = meat zm_quest::fake_physicslaunch( meat_target_pos.origin, 150 );
        wait var_d524330523e6df2d;
        stopfxontag( utility::getfx( #"hash_88f6d1ad054f367a" ), meat, "<dev string:xcf>" );
        meat delete();
        meat = spawn( "<dev string:x96>", meat_target_pos.origin );
        meat.angles = meat_target_pos.angles;
        meat setmodel( "<dev string:xda>" + "<dev string:xa3>" );
        meat setcandamage( 1 );
        meat function_f3e974ff79733b51();
    }

    // Namespace namespace_aea5a1566beb211f
    // Params 1
    // Checksum 0x3f885251, Offset: 0x227f
    // Size: 0xfb, Type: dev
    function function_610e8e62af632aff( params )
    {
        var_5d86c4d5d0e7bc94 = utility::getstruct( "<dev string:xe3>", "<dev string:xbd>" );
        var_c1fa958f38d7bd3 = [ utility::getstruct( "<dev string:xf8>", "<dev string:xbd>" ) ];
        ent = utility::spawn_tag_origin( var_5d86c4d5d0e7bc94.origin, var_5d86c4d5d0e7bc94.angles );
        ent setcandamage( 1 );
        ent.health = 10000;
        attractor = zombie_attractor_manager::add_attractor( ent, 0, 600, 1, undefined, &function_2c23b36115b721ca, undefined, zm_utility::get_zombie_team() );
        zombie_attractor_manager::set_attractor_slots( attractor, var_c1fa958f38d7bd3 );
        zombie_attractor_manager::function_4c34b0f066a9d9fe( attractor, 360 );
        zombie_attractor_manager::function_a2aab3762aaa055f( attractor, var_5d86c4d5d0e7bc94.origin, ( 30, 30, 30 ), ( 0, 30, 0 ) );
        level thread attractor_damage_monitor( ent );
    }

    // Namespace namespace_aea5a1566beb211f
    // Params 1
    // Checksum 0x6219fe7f, Offset: 0x2382
    // Size: 0x4e, Type: dev
    function function_90e8c4291531fb95( params )
    {
        if ( !isdefined( level.var_5fc7b1ff93191543.bunker_hit_count ) )
        {
            level.var_5fc7b1ff93191543.bunker_hit_count = 0;
        }
        
        level.var_5fc7b1ff93191543.bunker_hit_count++;
    }

    // Namespace namespace_aea5a1566beb211f
    // Params 1
    // Checksum 0xb0b353dd, Offset: 0x23d8
    // Size: 0x16, Type: dev
    function function_19afb910a766b0c1( params )
    {
        generate_reward();
    }

    // Namespace namespace_aea5a1566beb211f
    // Params 1
    // Checksum 0x88a79d09, Offset: 0x23f6
    // Size: 0x8f, Type: dev
    function function_b9edf1d7eba11488( params )
    {
        bunker_door = getent( "<dev string:x114>", "<dev string:xbd>" );
        original_angles = bunker_door.angles;
        des_struct = utility::getstruct( bunker_door.target, "<dev string:x120>" );
        bunker_door rotateto( des_struct.angles, 0.5 );
        wait 5;
        bunker_door rotateto( bunker_door.angles, 0.5 );
    }

#/
