// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rh.gsc  (hash_0637baa6cf662c42.gscc) (size: 14695 Bytes / 0x3967 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6b0ba39 (3065035321)
// size ...... 14695 (0x3967)
// includes .. 18  (offset: 0x34c3)
// strings ... 64  (offset: 0x3553)
// dev strs .. 11  (offset: 0x38e3)
// exports ... 34  (offset: 0x202f)
// cseg ...... 0x542 + 0x1aed (0x202f)
// imports ... 125 (offset: 0x257f)
// animtree1 . 0   (offset: 0x3967)
// animtree2 . 0   (offset: 0x3967)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\field_upgrades\field_upgrades_wiley_fox;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_rh;

// Namespace zm_sat_locust_rh
// Params 0, eflags: 0x5
// Checksum 0xe5a6d06d, Offset: 0x560
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"locust_rh", undefined, undefined, &init );
}

// Namespace zm_sat_locust_rh
// Params 0, eflags: 0x4
// Checksum 0xe0ee8187, Offset: 0x581
// Size: 0xb6
function private init()
{
    if ( !getdvarint( @"enable_rh", 0 ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    
    if ( !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        level utility::flag_wait_or_timeout( "rh_validation_set", 120 );
    }
    
    if ( !level.rh_enabled && !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        return;
    }
    
    level thread zm_rabbithole::function_5b9514e060bb4725();
    level utility::flag_wait( "zm_quest_initialized" );
    level callback::add( #"item_weapon_picked_up", &crossbow_collected );
    level thread set_up_quest();
    
    /#
        level thread init_rh_debug();
    #/
}

// Namespace zm_sat_locust_rh
// Params 1, eflags: 0x4
// Checksum 0x3129c40f, Offset: 0x63f
// Size: 0x39
function private on_player_connect( params )
{
    if ( zm_save::function_1dda3554974a999e() )
    {
        if ( self.var_e8b776e9698cb857 )
        {
            level.var_e8b776e9698cb857 = 1;
        }
    }
    
    level utility::flag_set( "super_ee_save_check" );
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x6f4bf321, Offset: 0x680
// Size: 0x29e
function set_up_quest()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "super_ee_save_check" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level._effect[ #"zombie_trail" ] = loadfxasset( "vfx_sat_gameplay_zm_cr_sc_trail_red" );
    level._effect[ #"hash_603276abaa39e8d8" ] = loadfxasset( "vfx_sat_levels_zm_locust_melting" );
    level._effect[ #"failed_soul" ] = loadfxasset( "vfx_sat_mantis_loot_cyst_trail" );
    level._effect[ #"king_soul" ] = loadfxasset( "vfx_sat_gameplay_zm_ww_mantis2_soul_out_base" );
    level._effect[ #"rod_charged" ] = loadfxasset( "vfx_sat_levels_zm_locust_mq_fish_float_amb_orange" );
    spawn_toybox();
    level callback::add( "fergus_rod_placed", &watch_fishing_spot );
    level.rod_trigger = getent( "wf_dc", "targetname" );
    
    if ( level.rod_trigger )
    {
        level.rod_trigger setcandamage( 1 );
        level.rod_trigger field_upgrades_wiley_fox::add_manual_target( level.rod_trigger );
    }
    
    var_327389ae91e32d2e = utility::getstruct( "kk_sp" );
    s_weapon_spawn = getscriptbundle( %"hash_66f1f88e4a37a48" );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_327389ae91e32d2e.origin, var_327389ae91e32d2e.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.var_5fa61841e327b2c8 = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    crossbowref = utility::get_scripted_weapon_name( #"crossbow" );
    crossbow_weapon = item_weapon::function_477bf1207c6672a5( s_weapon_spawn, spawnoptions );
    
    if ( isweapon( crossbow_weapon ) && crossbow_weapon.basename == crossbowref && !crossbow_weapon hasattachment( "sat_named_sl_crossbow" ) && crossbow_weapon canuseattachment( "sat_named_sl_crossbow" ) )
    {
        crossbow_weapon = crossbow_weapon withattachment( "sat_named_sl_crossbow" );
    }
    
    spawnoptions.weapon = crossbow_weapon;
    item_weapon = item_weapon::function_b960bc85ea91de14( s_weapon_spawn, spawnoptions );
    
    if ( isdefined( item_weapon.var_6828becb300b1c44 ) )
    {
        item_weapon.var_6828becb300b1c44.weaponobj = crossbow_weapon;
    }
    
    zm_rabbithole::function_1c6c02f0af873754();
    item_weapon setscriptablepartstate( "obloot_custom_weapon", "visible_no_outline_no_stem" );
    level utility::flag_wait( "rh_col_set" );
    zm_rabbithole::function_b422525417f4cda2();
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x85ef8bf, Offset: 0x926
// Size: 0x79
function crossbow_collected( params )
{
    level endon( #"game_ended" );
    weapon = params.newweaponobj;
    
    if ( weapon.other == "sat_named_sl_crossbow" )
    {
        level callback::remove( #"item_weapon_picked_up", &crossbow_collected );
        wait 2;
        level thread overlord::playconversation( hashcat( #"hash_5d65dc1c6847945", randomintrange( 1, 4 ) ) );
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x5959fcd1, Offset: 0x9a7
// Size: 0x8c
function spawn_toybox()
{
    level endon( #"game_ended" );
    level.tbox = zm_rabbithole::spawn_toybox( "tb_wat" );
    level.ice_tb = spawnscriptable( "sat_zm_ice_rh", utility::getstruct( "tb_wat" ).origin, utility::getstruct( "tb_wat" ).angles );
    level.ice_tb scriptablesetparententity( level.tbox );
    wait 2;
    level.tbox thread bob_item( 1, 5 );
}

// Namespace zm_sat_locust_rh
// Params 2
// Checksum 0xb69b23be, Offset: 0xa3b
// Size: 0x9d
function bob_item( bobspeed, height )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"hash_60b7b50de68e5b14" );
    self movez( height, 0.1 );
    self waittill( #"movedone" );
    move_dir = 1;
    acceleration_const = bobspeed * 0.25;
    
    while ( isdefined( self ) )
    {
        self movez( height * move_dir, bobspeed, acceleration_const, acceleration_const );
        self waittill( #"movedone" );
        move_dir *= -1;
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x5c6606cc, Offset: 0xae0
// Size: 0x7d
function watch_fishing_spot( params )
{
    if ( params.fishing_hole.groupid != "fishing_spot_10" )
    {
        return;
    }
    
    if ( params.fishing_hole.groupid == "fishing_spot_10" )
    {
        var_b11b64f5583f0be3 = params.rod_model;
        level.rod_trigger thread rod_watcher( params.fishing_hole, var_b11b64f5583f0be3 );
    }
}

// Namespace zm_sat_locust_rh
// Params 2
// Checksum 0x2fccb39a, Offset: 0xb65
// Size: 0x1af
function rod_watcher( scriptable, var_b11b64f5583f0be3 )
{
    scriptable endon( #"hash_4b069fb0a7cf1081" );
    scriptable endon( #"catch_fail" );
    scriptable endon( #"catch_success" );
    level endon( #"hash_9b04c48191f2fee5" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_ELEMENTAL_FIRE" && objweapon.basename == "wiley_fox_zm" && !level utility::flag( "rod_charged" ) )
            {
                level utility::flag_set( "rod_charged" );
                
                if ( var_b11b64f5583f0be3 )
                {
                    playfxontag( level._effect[ #"rod_charged" ], var_b11b64f5583f0be3, "j_butt_01" );
                }
                
                level callback::add( "fergus_general_catch_success", &function_6f9276211c674be0 );
                level callback::remove( "fergus_rod_placed", &watch_fishing_spot );
                level thread function_8aad81c9a99917e1();
                wait 3;
                level thread overlord::playconversation( hashcat( #"hash_75c75d977185847f", randomintrange( 1, 4 ) ) );
                return;
            }
        }
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x6b751cc9, Offset: 0xd1c
// Size: 0x19d
function function_6f9276211c674be0( params )
{
    if ( level utility::flag( "rod_charged" ) )
    {
        level notify( #"hash_db7e9b0d349f1651" );
        var_c23a8cb334b43f16 = utility::getstruct( "tb_wat_final" );
        mid_point = utility::getstruct( "tb_wat_mid" ).origin;
        level callback::remove( "fergus_general_catch_success", &function_6f9276211c674be0 );
        playfxontag( level._effect[ #"zombie_trail" ], level.tbox, "tag_origin" );
        level.tbox utility::function_8001268940441423( level.tbox.origin, var_c23a8cb334b43f16.origin + ( 0, 0, -10 ), mid_point, 0.5, undefined, 1 );
        level.tbox rotateto( var_c23a8cb334b43f16.angles, 0.1 );
        stopfxontag( level._effect[ #"zombie_trail" ], level.tbox, "tag_origin" );
        level thread overlord::playconversation( hashcat( #"hash_4480b2d59e32cd95", randomintrange( 1, 9 ) ) );
        level.tbox field_upgrades_wiley_fox::add_manual_target( level.tbox );
        level.tbox thread heat_watcher();
        level.tbox notify( #"hash_60b7b50de68e5b14" );
        
        if ( level.ice_tb )
        {
            level.ice_tb setscriptablepartstate( "audio", "onland" );
        }
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x6bef1d91, Offset: 0xec1
// Size: 0x8a
function function_8aad81c9a99917e1()
{
    level endon( #"game_end" );
    level endon( #"hash_db7e9b0d349f1651" );
    level waittill( #"hash_9b04c48191f2fee5" );
    level utility::flag_clear( "rod_charged" );
    level thread overlord::playconversation( hashcat( #"hash_9e1256a3eb9e8b3d", randomintrange( 1, 9 ) ) );
    level callback::remove( "fergus_general_catch_success", &function_6f9276211c674be0 );
    
    if ( !level callback::exists( "fergus_rod_placed", &watch_fishing_spot ) )
    {
        level callback::add( "fergus_rod_placed", &watch_fishing_spot );
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0xc6650956, Offset: 0xf53
// Size: 0x19f
function heat_watcher()
{
    self endon( #"death" );
    val::set( "toybox", "damage", 1 );
    self.health = 99999;
    
    while ( true )
    {
        self waittill( #"damage", damage, eattacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( eattacker ) )
        {
            if ( smeansofdeath == "MOD_ELEMENTAL_FIRE" || objweapon.basename == "sat_molotov_zm" || inflictor.ammo_mod[ 0 ].ammomodname == "napalmburst" || objweapon.basename == "sat_ww_locust_zm" )
            {
                if ( level.ice_tb )
                {
                    level.ice_tb setscriptablepartstate( "base", "melt" );
                    level.ice_tb setscriptablepartstate( "audio", "off" );
                    wait 2;
                    level.ice_tb freescriptable();
                }
                
                level thread open_box();
                return;
            }
            
            self.health += damage;
        }
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x99fb597f, Offset: 0x10fa
// Size: 0x46
function open_box()
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( level.tbox )
    {
        level.tbox thread zm_rabbithole::toybox_open();
        level callback::add( "zone_changed", &function_e9a948b80a87621b );
        spawn_king();
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x8864feae, Offset: 0x1148
// Size: 0x272
function spawn_king()
{
    level.var_8d5f814da056a597 = utility::getstructarray( "fk_sp" );
    king_spawn_loc = utility::array_random( level.var_8d5f814da056a597 );
    level.frost_king = agent_manager::spawn_agent( "zombie_base_luna_hvt", king_spawn_loc.origin );
    level.frost_king zombie_utils::set_zombie_round_difficulty( 30 );
    level.frost_king.b_ignore_cleanup = 1;
    level.frost_king.b_cleanup_no_respawn = 1;
    level.frost_king.var_a13bed1ac47e1b2c = 1;
    level.frost_king.no_powerups = 1;
    level.frost_king.var_15598d8e493afe88 = 1;
    level.frost_king.ignore_enemy_count = 1;
    level.frost_king.var_7ee152b43c7188e1 = 1;
    level.frost_king.disable_brain_rot = 1;
    level.frost_king.var_be5ccf6d16f6b59e = 1;
    level.frost_king.forceannihilate = 1;
    level.frost_king.var_3807d4363cfee498 = 1;
    level.frost_king val::set( "rh_ee", "ignoreall", 1 );
    level.frost_king zombie_utils::function_a8ce00e0448cb6f0( "wander", undefined, 20 );
    level.frost_king thread function_41c3cbfc31ff8cdd( level.var_8d5f814da056a597 );
    
    if ( !level callback::exists( #"on_ai_killed", &function_6f87a3cdd98c2f55 ) )
    {
        level callback::add( #"on_ai_killed", &function_6f87a3cdd98c2f55 );
    }
    
    level.frost_king.trackhat = 1;
    level.frost_king.var_597d3d7b2f685c74 = 1;
    level.frost_king.var_508e987d3198ea88 = "rh_king_hat";
    level.frost_king.spawn_start_time = undefined;
    level.frost_king.var_7df6a590dfd9d111 = 0.05;
    level.var_74eb77c5325a0f62 = 1;
    level.frost_king.var_786c9fa7547cf486 = 1;
    level.frost_king thread watch_enemy_health_regen();
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x49ff193e, Offset: 0x13c2
// Size: 0x81
function function_41c3cbfc31ff8cdd( struct_array )
{
    self endon( #"death" );
    self endon( #"force_end_current_goal" );
    
    if ( !isdefined( current_move_target ) )
    {
        current_move_target = utility::array_random( struct_array );
    }
    
    next_target = undefined;
    zm_quest::force_zombie_goal( current_move_target, 50 );
    
    while ( true )
    {
        next_target = utility::array_random( struct_array );
        
        if ( next_target != current_move_target )
        {
            current_move_target = next_target;
            zm_quest::force_zombie_goal( current_move_target, 50 );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0xe1f7014b, Offset: 0x144b
// Size: 0x19e
function function_e9a948b80a87621b( params )
{
    level endon( #"game_ended" );
    
    if ( params.zone_struct.zone_name == "zone_village_church_grounds" && !utility::ent_flag( "player_in_graveyard" ) )
    {
        utility::ent_flag_set( "player_in_graveyard" );
        
        if ( level.frost_king )
        {
            level.frost_king notify( #"force_end_current_goal" );
            
            if ( isdefined( level.frost_king.active_attractors ) )
            {
                foreach ( attractor in level.frost_king.active_attractors )
                {
                    level.frost_king zombie_attractor_manager::function_dcfb4c31f1d97cd2( attractor );
                }
            }
            
            level.frost_king val::set( "rh_ee", "ignoreall", 0 );
            level.frost_king utility::ent_flag_wait( "ai_init_complete" );
            level.frost_king zombie_utils::function_a8ce00e0448cb6f0( "sprint", "zm_quest", 999 );
        }
        
        return;
    }
    
    if ( params.zone_struct.zone_name != "zone_village_church_grounds" && utility::ent_flag( "player_in_graveyard" ) )
    {
        utility::ent_flag_clear( "player_in_graveyard" );
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x61f156f8, Offset: 0x15f1
// Size: 0xc0
function get_tracking_hat( purpose )
{
    if ( !isdefined( level.var_f970e1782c73d8ef ) )
    {
        return;
    }
    
    foreach ( entry in level.var_f970e1782c73d8ef )
    {
        if ( entry.tracking_purpose == purpose )
        {
            level.var_f970e1782c73d8ef = arrayremove( level.var_f970e1782c73d8ef, entry );
            return entry.tracking_hat;
        }
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x8c0a5df1, Offset: 0x16ba
// Size: 0x277
function function_6f87a3cdd98c2f55( params )
{
    level endon( #"game_ended" );
    
    if ( params.victim.classname == "actor_sat_spawner_zombie_base_luna_hvt" )
    {
        b_valid_death = zone_manager::get_current_zone();
        level.crown_luna = get_tracking_hat( self.var_508e987d3198ea88 );
        
        if ( params.sweapon.other == "sat_named_sl_crossbow" && b_valid_death )
        {
            e_fx = utility::spawn_model( "tag_origin", self getcentroid() );
            playfxontag( level._effect[ #"king_soul" ], e_fx, "tag_origin" );
            self.forceannihilate = 1;
            self.var_508e987d3198ea88 = undefined;
            level.crown_luna hudoutlineenable( "outline_depth_orange" );
            playworldsound( level.crown_luna.origin, #"hash_f3dc5e89d9d29de6" );
            level utility::flag_set( "fz_crown_spawned" );
            level callback::remove( "on_zombie_ai_killed", &function_6f87a3cdd98c2f55 );
            level callback::remove( "zone_changed", &function_e9a948b80a87621b );
            wait 1;
            e_fx delete();
            crown_interact = zm_quest::function_91f9590e98d57ff6( level.crown_luna.origin, &crown_pickedup, &hidden_hint, "medium_anyanglefov" );
            crown_interact thread function_c82d238996297776();
            return;
        }
        
        level.crown_luna delete();
        self.var_508e987d3198ea88 = undefined;
        end_point = utility::array_random( level.var_8d5f814da056a597 );
        soul_sfx = { #endalias:#"hash_f690b967d7c16a2b", #var_8bee59e397c66fa0:#"hash_6ce4ae84a719a787", #var_deac89db5aa6990a:#"hash_ba98b31b21b9adf6" };
        utility::function_24215250530eaebc( self getcentroid(), end_point.origin, level._effect[ #"failed_soul" ], undefined, soul_sfx );
        self.forceannihilate = 0;
        
        if ( !level utility::flag( "failed_crown_vo" ) )
        {
            level utility::flag_set( "failed_crown_vo" );
            wait 3;
            level thread overlord::playconversation( hashcat( #"hash_c4de5399a14d8803", randomintrange( 1, 5 ) ) );
        }
        
        level callback::add( "on_round_start", &function_bab91804f384c4c1 );
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0xf23e2640, Offset: 0x1939
// Size: 0x81
function function_c82d238996297776()
{
    level endon( #"game_ended" );
    level endon( #"fz_crown_picked_up" );
    wait 20;
    
    if ( level.crown_luna )
    {
        self freescriptable();
        level.crown_luna delete();
        wait 3;
        level thread overlord::playconversation( hashcat( #"hash_9e1256a3eb9e8b3d", randomintrange( 1, 9 ) ) );
        level callback::add( "on_round_start", &function_bab91804f384c4c1 );
        level callback::add( "zone_changed", &function_e9a948b80a87621b );
    }
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x57808e52, Offset: 0x19c2
// Size: 0x30
function function_bab91804f384c4c1( params )
{
    if ( utility::percent_chance( 50 ) )
    {
        level callback::remove( "on_round_start", &function_bab91804f384c4c1 );
        respawn_king();
    }
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0x79be2043, Offset: 0x19fa
// Size: 0x40
function respawn_king()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_c1907c050ca26d59 = zm_quest::function_33e20bfbb976c774( "zone_village_church_grounds" );
        
        if ( !var_c1907c050ca26d59 )
        {
            break;
        }
        
        wait 60;
    }
    
    spawn_king();
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x96745682, Offset: 0x1a42
// Size: 0x184
function watch_enemy_health_regen( params )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( level.var_74eb77c5325a0f62 )
    {
        if ( !isdefined( level.zmModeEnemyRegen_throttle ) )
        {
            level.zmModeEnemyRegen_throttle = throttle::throttle_initialize( "zmModeEnemyRegen_throttle", 1 );
        }
        
        level throttle::throttle_wait_in_queue( level.zmModeEnemyRegen_throttle, self );
        
        if ( isalive( self ) && self.health < self.maxhealth )
        {
            health_regen_cap = int( self.var_d200801f77f0de0 ?? self.maxhealth );
            regen_start_time = 5000;
            
            if ( isdefined( regen_start_time ) && self.health < health_regen_cap && self.damagetime && gettime() > self.damagetime + regen_start_time )
            {
                health_regen_perc = self.var_7df6a590dfd9d111;
                var_fb2f98f9e8f799fa = self.health;
                new_health = minint( health_regen_cap, self.health + int( self.maxhealth * health_regen_perc ) );
                self.health = new_health ?? self.health;
                callback::callback( "health_regenerated", { #new_health:new_health, #var_fb2f98f9e8f799fa:var_fb2f98f9e8f799fa } );
            }
        }
        
        wait self.var_786c9fa7547cf486;
    }
}

// Namespace zm_sat_locust_rh
// Params 2
// Checksum 0xa71e2626, Offset: 0x1bce
// Size: 0x36
function hidden_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x8e1c612b, Offset: 0x1c0d
// Size: 0x9b
function crown_pickedup( player )
{
    level endon( #"game_ended" );
    playworldsound( level.crown_luna.origin + ( 0, 0, 25 ), #"hash_d8047720d352b10f" );
    self freescriptable();
    level.crown_luna delete();
    level utility::flag_set( "fz_crown_picked_up" );
    level notify( #"fz_crown_picked_up" );
    spawn_box_interact();
    wait 2;
    level thread overlord::playconversation( hashcat( #"hash_4deee1c16ef6e939", randomintrange( 1, 4 ) ) );
}

// Namespace zm_sat_locust_rh
// Params 0
// Checksum 0xfbf6078c, Offset: 0x1cb0
// Size: 0x5c
function spawn_box_interact()
{
    pos = utility::getstruct( "tb_wat_final" );
    box_interact = interaction::register_interact( pos.origin + ( 0, 0, 25 ), 120, &box_interact_func, &box_interact_hint );
    box_interact.pos = pos;
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0xfda43de7, Offset: 0x1d14
// Size: 0x50
function box_interact_func( player )
{
    self delete();
    level.tbox thread zm_rabbithole::toybox_give_reward( "zm_sat_bloodstone_crown", ( -90, 0, 0 ) );
    level callback::add( "zm_exfil_success", &function_cf25da101db108b3 );
    level thread function_af7c0169a8e958dd( player );
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0xbd5f1627, Offset: 0x1d6c
// Size: 0x4f
function function_af7c0169a8e958dd( player )
{
    level endon( #"game_ended" );
    level waittill( #"rh_to_pic" );
    wait 2;
    level thread overlord::playconversation( hashcat( #"hash_24834de441ffd034", randomintrange( 1, 3 ) ) );
    wait 20;
    zm_rabbithole::function_1c6c02f0af873754();
}

// Namespace zm_sat_locust_rh
// Params 2
// Checksum 0xd3cda39, Offset: 0x1dc3
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_locust_rh
// Params 1
// Checksum 0x425668b0, Offset: 0x1e02
// Size: 0x141
function function_cf25da101db108b3( params )
{
    if ( utility::flag( "rh_to_pic" ) )
    {
        event_str = zm_rabbithole::function_85eaee7552aadd2e();
        
        foreach ( player in params.a_exfil_players )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
                
                if ( player.var_11f0a190160021dd && player.var_1bf107e8638f5574 && player.var_5388587ed7a9f314 && player.var_4ad88eeba60b1ac && player.var_27501a6cf23a6c06 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                }
            }
        }
    }
}

/#

    // Namespace zm_sat_locust_rh
    // Params 0
    // Checksum 0xe411469d, Offset: 0x1f4b
    // Size: 0x5a, Type: dev
    function init_rh_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x4d>", &function_a2cbf5df7d0233ff );
        devgui::add_devgui_func( "<dev string:x60>", "<dev string:x6b>", &debug_spawn_king );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x82>", &debug_chest );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_rh
    // Params 0
    // Checksum 0xf52d4382, Offset: 0x1fad
    // Size: 0x24, Type: dev
    function function_a2cbf5df7d0233ff()
    {
        level utility::flag_set( "<dev string:x8e>" );
        level callback::add( "<dev string:x9f>", &function_cf25da101db108b3 );
    }

    // Namespace zm_sat_locust_rh
    // Params 0
    // Checksum 0x8e3f1073, Offset: 0x1fd9
    // Size: 0x1e, Type: dev
    function debug_spawn_king()
    {
        level callback::add( "<dev string:xad>", &function_e9a948b80a87621b );
        spawn_king();
    }

    // Namespace zm_sat_locust_rh
    // Params 0
    // Checksum 0x85237eb3, Offset: 0x1fff
    // Size: 0x30, Type: dev
    function debug_chest()
    {
        level.tbox = zm_rabbithole::spawn_toybox( "<dev string:xba>" );
        level.tbox thread zm_rabbithole::toybox_open();
        spawn_box_interact();
    }

#/
