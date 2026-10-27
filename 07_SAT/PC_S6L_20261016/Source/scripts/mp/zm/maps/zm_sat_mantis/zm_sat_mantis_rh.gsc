// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_rh.gsc  (hash_3c80724d9e91765e.gscc) (size: 23774 Bytes / 0x5cde / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e2fa15f (1580179807)
// size ...... 23774 (0x5cde)
// includes .. 15  (offset: 0x5642)
// strings ... 89  (offset: 0x56ba)
// dev strs .. 13  (offset: 0x5c2e)
// exports ... 61  (offset: 0x391a)
// cseg ...... 0x825 + 0x30f5 (0x391a)
// imports ... 151 (offset: 0x42a2)
// animtree1 . 0   (offset: 0x5cde)
// animtree2 . 0   (offset: 0x5cde)
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_rh;

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x5
// Checksum 0xab7a63a8, Offset: 0x843
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mantis_rh", #"zm_quest", undefined, &postmain_init );
}

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x4
// Checksum 0x5f13dc5a, Offset: 0x86c
// Size: 0x244
function private postmain_init()
{
    level thread zm_rabbithole::function_1c6c02f0af873754();
    
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
    level.mantis_rh = zm_quest::get_quest( #"mantis_rh" );
    level._effect[ "bear_game_intro" ] = loadfxasset( "vfx_sat_mantis_bunny_spawn_in_blue" );
    level._effect[ "bear_game_idle" ] = loadfxasset( "vfx_sat_mantis_bunny_glow_blue" );
    level._effect[ "bear_game_grabbed" ] = loadfxasset( "vfx_sat_mantis_bunny_glow_blue_grab" );
    level._effect[ "bear_pieces_glow" ] = loadfxasset( "vfx_sat_mantis_toy_pieces_glow" );
    level._effect[ "bear_disappear" ] = loadfxasset( "vfx_t10_levels_zm_quartz_animal_hunt_interaction_ee" );
    level._effect[ "bear_combine" ] = loadfxasset( "vfx_t10_levels_zm_quartz_animal_hunt_puff_big_ee" );
    level._effect[ "wallbuy_1_to_2" ] = loadfxasset( "vfx_sat_zm_mantis_wall_buy_sketch_dissolve_transition_1_to_2" );
    level._effect[ "wallbuy_2_to_3" ] = loadfxasset( "vfx_sat_zm_mantis_wall_buy_sketch_dissolve_transition_2_to_3" );
    level._effect[ "question_to_key" ] = loadfxasset( "vfx_sat_zm_mantis_wall_buy_sketch_dissolve_transition_4_to_5" );
    level._effect[ "key_to_nothing" ] = loadfxasset( "vfx_sat_zm_mantis_wall_buy_sketch_dissolve_transition_5_to_nothing" );
    level._effect[ "lock_disappear" ] = loadfxasset( "vfx_sat_mantis_wallbuy_lock_disappear" );
    zm_quest::register_quest_step( #"mantis_rh", #"hash_f397e88a8297bc42", &setup_step_1, &function_61e5b348e99af311 );
    level utility::flag_wait( "super_ee_save_check" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level thread function_6f7e2f544f9e0860();
    level thread function_c5251e46efb50068();
    level callback::add( "zm_exfil_success", &on_exfil_success );
    
    /#
        level thread init_mantis_rh_debug();
    #/
}

/#

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0x39a87cf2, Offset: 0xab8
    // Size: 0x5, Type: dev
    function private function_3b3939c23f957c26()
    {
        
    }

#/

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0x1493bf0b, Offset: 0xac5
// Size: 0x2d
function setup_step_1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
    
    level utility::flag_wait( "rh_mantis_complete" );
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0xe257d435, Offset: 0xafa
// Size: 0x20
function function_61e5b348e99af311( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_mantis_rh
// Params 1, eflags: 0x4
// Checksum 0x7421b17d, Offset: 0xb22
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

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x7caee341, Offset: 0xb63
// Size: 0x115
function function_6f7e2f544f9e0860()
{
    level endon( #"game_ended" );
    var_cd334f10192877a1 = utility::getstruct( "piano", "targetname" );
    var_cb604c7ea19b3454 = spawnscriptable( %"hash_2b5ee14532d8209c", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    var_cb604c7ea19b3454 utility::function_7c10ea82c1e305b8( "model", "1" );
    var_cb604c7ea19b3454.interact = interaction::register_interact( var_cd334f10192877a1.origin - ( 0, 0, 5 ), 70, &function_cfe3a85e531eb190, &function_732f09a1ca1c96e0 );
    var_cb604c7ea19b3454.interact.var_5407670c3d5c194d = var_cb604c7ea19b3454;
    level utility::flag_wait( "rh_scrib_del" );
    var_cb604c7ea19b3454.interact = interaction::register_interact( var_cd334f10192877a1.origin + ( -15, 0, -20 ), 80, &interact_unlock_box, &function_b87662a0b13ca369 );
    var_cb604c7ea19b3454.interact.var_5407670c3d5c194d = var_cb604c7ea19b3454;
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x8bc67757, Offset: 0xc80
// Size: 0x62
function function_cfe3a85e531eb190( player )
{
    level utility::flag_set( "rh_scrib_del" );
    level thread function_5c9ec256f19d5b77();
    playworldsound( self.var_5407670c3d5c194d.origin, #"hash_6ce2f458f812318d" );
    self.var_5407670c3d5c194d utility::function_7c10ea82c1e305b8( "model", "2" );
    self delete();
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0x73071b6, Offset: 0xcea
// Size: 0x36
function function_732f09a1ca1c96e0( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x2c054743, Offset: 0xd29
// Size: 0xf6
function interact_unlock_box( player )
{
    if ( level utility::flag( "rh_key_ob" ) && !level utility::flag( "rh_b_unlocked" ) )
    {
        level utility::flag_set( "rh_b_unlocked" );
        level utility::flag_set( "rh_b_ob" );
        var_cd334f10192877a1 = utility::getstruct( "piano", "targetname" );
        
        if ( isdefined( var_cd334f10192877a1 ) )
        {
            playworldsound( var_cd334f10192877a1.origin, #"hash_904eb5f962cb8eaa" );
        }
        
        level thread function_27fd9f6c0efa3834( self.var_5407670c3d5c194d );
        var_6c980fe869d70d50 = spawnscriptable( %"hash_55d399db0b3046d1", self.var_5407670c3d5c194d.origin, self.var_5407670c3d5c194d.angles );
        var_6c980fe869d70d50 utility::function_7c10ea82c1e305b8( "model_2", "1" );
        wait 2.3;
        level thread spawn_toy_box();
        self delete();
    }
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0xeb813c15, Offset: 0xe27
// Size: 0x3e
function function_27fd9f6c0efa3834( scriptable )
{
    wait 0.2;
    scriptable utility::function_7c10ea82c1e305b8( "model", "3" );
    wait 2.6;
    scriptable utility::function_7c10ea82c1e305b8( "model", "off" );
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0x77b12218, Offset: 0xe6d
// Size: 0x36
function function_b87662a0b13ca369( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x4017e52, Offset: 0xeac
// Size: 0x22f
function spawn_toy_box()
{
    level.rh_toy_box = zm_rabbithole::spawn_toybox( "bb_gun_1" );
    s_move_loc = utility::getstruct( "bb_gun_2", "targetname" );
    s_final_loc = utility::getstruct( "bb_gun_3", "targetname" );
    wait 1;
    a_players = getplayersinradius( s_final_loc.origin, 80 );
    
    foreach ( player in a_players )
    {
        v_knockback = vectornormalize( player.origin - s_final_loc.origin );
        player knockback( v_knockback, 100, 1 );
    }
    
    level.rh_toy_box moveto( s_move_loc.origin, 1.5, 0.5, 0.5 );
    level.rh_toy_box waittill( #"movedone" );
    level.rh_toy_box moveto( s_final_loc.origin, 1.5, 0.5, 0.5 );
    level.rh_toy_box waittill( #"movedone" );
    a_players = getplayersinradius( s_final_loc.origin, 70 );
    
    foreach ( player in a_players )
    {
        v_knockback = vectornormalize( player.origin - s_final_loc.origin );
        player knockback( v_knockback, 50, 1 );
    }
    
    level thread zm_rabbithole::function_b422525417f4cda2();
    level.rh_toy_box zm_rabbithole::toybox_open();
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xe5e721fb, Offset: 0x10e3
// Size: 0x146
function function_5c9ec256f19d5b77()
{
    var_cd334f10192877a1 = utility::getstruct( "phone", "targetname" );
    playworldsound( var_cd334f10192877a1.origin, #"hash_6ce2f458f812318d" );
    level.var_2aff4d3cf1b56139 = utility::spawn_model( "sat_zm_toy_chest_wallbuy_04", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    level.var_b4b834e2a70ca118 = utility::spawn_model( "sat_zm_toy_chest_wallbuy_05", var_cd334f10192877a1.origin, var_cd334f10192877a1.angles );
    level.var_e7403fb559710eb = interaction::register_interact( var_cd334f10192877a1.origin + ( 15, 0, 15 ), 70, &interact_key, &function_dec199faf872dd00 );
    
    foreach ( player in level.players )
    {
        level.var_b4b834e2a70ca118 hidefromplayer( player );
        player thread monitor_player_trigger();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x15cadc2c, Offset: 0x1231
// Size: 0x164
function monitor_player_trigger()
{
    level endon( #"game_ended" );
    level endon( #"rh_key_ob" );
    trigger = getent( "rh_t_1", "targetname" );
    
    while ( true )
    {
        trigger waittill( #"trigger" );
        
        if ( isplayer( self ) && isdefined( self.var_955518e3fd692fbd ) )
        {
            if ( isdefined( level.var_b4b834e2a70ca118 ) && isdefined( level.var_2aff4d3cf1b56139 ) )
            {
                level.var_2aff4d3cf1b56139 hidefromplayer( self );
                level.var_b4b834e2a70ca118 showtoplayer( self );
            }
            
            if ( !utility::ent_flag( "rh_can_see_k" ) )
            {
                playworldsound( level.var_b4b834e2a70ca118.origin, #"hash_6ce2f458f812318d", self );
                utility::ent_flag_set( "rh_can_see_k" );
            }
        }
        else if ( isplayer( self ) && !isdefined( self.var_955518e3fd692fbd ) )
        {
            if ( isdefined( level.var_b4b834e2a70ca118 ) && isdefined( level.var_2aff4d3cf1b56139 ) )
            {
                level.var_b4b834e2a70ca118 hidefromplayer( self );
                level.var_2aff4d3cf1b56139 showtoplayer( self );
            }
            
            if ( utility::ent_flag( "rh_can_see_k" ) )
            {
                playworldsound( level.var_2aff4d3cf1b56139.origin, #"hash_6ce2f458f812318d", self );
                utility::ent_flag_clear( "rh_can_see_k" );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x479dafee, Offset: 0x139d
// Size: 0xd3
function interact_key( player )
{
    if ( level utility::flag( "rh_key_ob" ) )
    {
        return;
    }
    
    if ( player utility::ent_flag( "rh_can_see_k" ) )
    {
        level notify( #"rh_key_ob" );
        level utility::flag_set( "rh_key_ob" );
        playworldsound( level.var_b4b834e2a70ca118.origin, #"hash_80695bc33e1db591" );
        playfx( utility::getfx( "key_to_nothing" ), level.var_2aff4d3cf1b56139.origin, anglestoforward( level.var_2aff4d3cf1b56139.angles ) );
        level.var_b4b834e2a70ca118 delete();
        wait 1;
        level.var_2aff4d3cf1b56139 delete();
        player utility::ent_flag_clear( "rh_can_see_k" );
        self delete();
    }
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0x3c09ff45, Offset: 0x1478
// Size: 0x36
function function_dec199faf872dd00( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

/#

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0xa823a35e, Offset: 0x14b7
    // Size: 0x5, Type: dev
    function private function_d58fcfa7d4dcce79()
    {
        
    }

#/

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xf5d441cb, Offset: 0x14c4
// Size: 0x3de
function function_c5251e46efb50068()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "rh_b_ob" );
    level.var_27febd437e92e592 = utility::getstructarray( "tiger", "targetname" );
    var_a1ecc253c1ddca05 = utility::getstructarray( "lion", "targetname" );
    
    if ( !isdefined( var_a1ecc253c1ddca05 ) || var_a1ecc253c1ddca05.size == 0 )
    {
        return;
    }
    
    var_a1ecc253c1ddca05 = arrayrandomize( var_a1ecc253c1ddca05 );
    spawn_count = 3;
    level.var_fc8b96c8046cc07b = [];
    level.var_a9cf4d38ebeea6cd = 0;
    level.var_e766fedb34dc3a40 = [];
    var_6ed88596d5541378 = [ "pink::t10_zm_magic_box_bunny_leg_rt", "pink::t10_zm_magic_box_bunny_head", "pink::t10_zm_magic_box_bunny_torso" ];
    
    for ( i = 0; i < spawn_count ; i++ )
    {
        spawn_struct = var_a1ecc253c1ddca05[ i ];
        toy_piece = utility::spawn_model( var_6ed88596d5541378[ i ], spawn_struct.origin, spawn_struct.angles );
        toy_piece.mdl_name = var_6ed88596d5541378[ i ];
        level thread function_aa5660b12328a4f2( toy_piece );
        
        if ( isdefined( toy_piece ) )
        {
            toy_piece.script_noteworthy = spawn_struct.script_noteworthy;
            toy_piece.spawn_struct = spawn_struct;
            level.var_fc8b96c8046cc07b[ level.var_fc8b96c8046cc07b.size ] = toy_piece;
        }
    }
    
    trigger_array = getentarray( "t_lion", #targetname );
    
    if ( isdefined( trigger_array ) )
    {
        foreach ( trigger in trigger_array )
        {
            foreach ( toy in level.var_fc8b96c8046cc07b )
            {
                if ( toy.script_noteworthy == trigger.script_noteworthy )
                {
                    trigger thread function_4c4e0274e520a0fb();
                }
            }
        }
    }
    
    level.var_31c1f72e160872d8 = [];
    var_4fb5c9fb70b8f956 = utility::getstructarray( "cat", "targetname" );
    
    foreach ( struct in var_4fb5c9fb70b8f956 )
    {
        if ( struct.script_noteworthy == "arm_l" )
        {
            mdl_toy = utility::spawn_model( "pink::t10_zm_magic_box_bunny_arm_lft", struct.origin, struct.angles );
        }
        else if ( struct.script_noteworthy == "arm_r" )
        {
            mdl_toy = utility::spawn_model( "pink::t10_zm_magic_box_bunny_arm_rt", struct.origin, struct.angles );
        }
        else if ( struct.script_noteworthy == "leg_l" )
        {
            mdl_toy = utility::spawn_model( "pink::t10_zm_magic_box_bunny_leg_lft", struct.origin, struct.angles );
        }
        
        level thread function_aa5660b12328a4f2( mdl_toy );
        level.var_31c1f72e160872d8[ level.var_31c1f72e160872d8.size ] = mdl_toy;
    }
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0xab91ff9c, Offset: 0x18aa
// Size: 0x5b
function function_aa5660b12328a4f2( ent )
{
    scr_vfx = spawnscriptable( %"hash_108e3e6b1aab692d", ent.origin, ent.angles );
    scr_vfx utility::function_7c10ea82c1e305b8( "base", "on" );
    wait 2.5;
    scr_vfx freescriptable();
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x36f29dfa, Offset: 0x190d
// Size: 0x1db
function function_4c4e0274e520a0fb()
{
    self endon( #"death" );
    level endon( #"hash_dfe40d3924f1848" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( !isdefined( self.script_noteworthy ) )
        {
            continue;
        }
        
        if ( !isdefined( level.var_fc8b96c8046cc07b ) )
        {
            continue;
        }
        
        foreach ( toy_piece in level.var_fc8b96c8046cc07b )
        {
            if ( isdefined( toy_piece ) && toy_piece.script_noteworthy == self.script_noteworthy )
            {
                level.var_a9cf4d38ebeea6cd++;
                toy_to_spawn = toy_piece.mdl_name;
                level.var_fc8b96c8046cc07b = arrayremove( level.var_fc8b96c8046cc07b, toy_piece );
                level thread play_hit_fx( toy_piece );
                function_c727335302a48211( toy_to_spawn );
                
                if ( level.var_a9cf4d38ebeea6cd == 1 )
                {
                    level thread overlord::playconversation( hashcat( #"hash_d4f711ddcb5b6adb", randomintrange( 1, 4 ) ) );
                }
                else if ( level.var_a9cf4d38ebeea6cd == 3 )
                {
                    level notify( #"hash_dfe40d3924f1848" );
                }
                
                break;
            }
        }
    }
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x87c718fc, Offset: 0x1af0
// Size: 0x80
function play_hit_fx( var_3e3af87a7ff52d2a )
{
    if ( isdefined( var_3e3af87a7ff52d2a ) )
    {
        hit_fx = utility::getfx( "bear_disappear" );
        var_ff344c83521a9a4e = utility::spawn_model( "tag_origin", var_3e3af87a7ff52d2a.origin );
        playfxontag( hit_fx, var_ff344c83521a9a4e, "tag_origin" );
        playworldsound( var_ff344c83521a9a4e.origin, #"hash_54a6013bf28b75f7" );
        var_3e3af87a7ff52d2a delete();
        wait 1;
        var_ff344c83521a9a4e delete();
    }
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x760ce8c7, Offset: 0x1b78
// Size: 0xd2
function function_c727335302a48211( toy )
{
    if ( level.var_a9cf4d38ebeea6cd < 4 )
    {
        if ( !isdefined( level.var_27febd437e92e592 ) || level.var_27febd437e92e592.size == 0 )
        {
            return;
        }
        
        bus_spawn_struct = level.var_27febd437e92e592[ 0 ];
        toy_piece = utility::spawn_model( toy, bus_spawn_struct.origin, bus_spawn_struct.angles );
        level.var_e766fedb34dc3a40[ level.var_e766fedb34dc3a40.size ] = toy_piece;
        
        if ( isdefined( toy_piece ) )
        {
            level.var_27febd437e92e592 = arrayremove( level.var_27febd437e92e592, bus_spawn_struct );
        }
        
        if ( level.var_a9cf4d38ebeea6cd == 3 )
        {
            level thread setup_minigame_interact();
            level utility::flag_set( "rh_minigame_ready" );
        }
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xdf03ff9c, Offset: 0x1c52
// Size: 0x1bf
function function_c62bb27f7150d4f5()
{
    audio_location = utility::getstruct( "tiger_cub", "targetname" );
    level.var_9de3262fe6187924 = utility::play_loopsound_in_space( #"hash_e15e489c149b4689", audio_location.origin );
    
    foreach ( mdl in level.var_e766fedb34dc3a40 )
    {
        glow_fx = utility::getfx( "bear_pieces_glow" );
        var_ff344c83521a9a4e = utility::spawn_model( "tag_origin", mdl.origin, ( 0, 0, -3 ) );
        playfxontag( glow_fx, var_ff344c83521a9a4e, "tag_origin" );
        mdl.glow_fx = var_ff344c83521a9a4e;
    }
    
    foreach ( mdl in level.var_31c1f72e160872d8 )
    {
        glow_fx = utility::getfx( "bear_pieces_glow" );
        var_ff344c83521a9a4e = utility::spawn_model( "tag_origin", mdl.origin, ( 0, 0, -3 ) );
        playfxontag( glow_fx, var_ff344c83521a9a4e, "tag_origin" );
        mdl.glow_fx = var_ff344c83521a9a4e;
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xa0745ebb, Offset: 0x1e19
// Size: 0x162
function function_617eb04cbec79987()
{
    if ( level.var_9de3262fe6187924 )
    {
        level.var_9de3262fe6187924 delete();
    }
    
    foreach ( mdl in level.var_e766fedb34dc3a40 )
    {
        glow_fx = utility::getfx( "bear_pieces_glow" );
        killfxontag( glow_fx, mdl.glow_fx, "tag_origin" );
        mdl.glow_fx delete();
    }
    
    foreach ( mdl in level.var_31c1f72e160872d8 )
    {
        glow_fx = utility::getfx( "bear_pieces_glow" );
        killfxontag( glow_fx, mdl.glow_fx, "tag_origin" );
        mdl.glow_fx delete();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x5a244c1a, Offset: 0x1f83
// Size: 0x5a
function setup_minigame_interact()
{
    s_interact_loc = utility::getstruct( "tiger_cub", "targetname" );
    level thread function_c62bb27f7150d4f5();
    level.var_34159e1af1e15e17 = interaction::register_interact( s_interact_loc.origin + ( 15, 0, 15 ), 70, &function_57e59fdb24400efb, &minigame_interact_hint );
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0xdb64eab, Offset: 0x1fe5
// Size: 0x62
function function_57e59fdb24400efb( player )
{
    if ( level utility::flag( "rh_minigame_ready" ) )
    {
        if ( !istrue( level.var_9b6bb56fd25381c4 ) )
        {
            level.var_9b6bb56fd25381c4 = 1;
            level thread overlord::playconversation( #"hash_f04c5d901cbc636f" );
        }
        
        level thread function_617eb04cbec79987();
        level thread function_4e458412869c15ec();
        level utility::flag_clear( "rh_minigame_ready" );
    }
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0xa9688018, Offset: 0x204f
// Size: 0x36
function minigame_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x8a44ae62, Offset: 0x208e
// Size: 0x188
function function_4e458412869c15ec()
{
    level endon( #"game_ended" );
    level.var_7c502762bd9220ba = utility::getstructarray( "goat", "targetname" );
    
    if ( !isdefined( level.var_7c502762bd9220ba ) || level.var_7c502762bd9220ba.size == 0 )
    {
        return;
    }
    
    level.var_4a9f79fdc8d4c43a = [];
    
    foreach ( bear_struct in level.var_7c502762bd9220ba )
    {
        level.var_4a9f79fdc8d4c43a[ level.var_4a9f79fdc8d4c43a.size ] = bear_struct;
    }
    
    level.var_f99d6f001b5905d6 = 1;
    level.var_e9d1d09647d126ec = 0;
    level.var_d42ba5a6dc33a16c = undefined;
    level thread function_9eba76c5821a19c2();
    level thread function_5a13cf89e973542e();
    level thread function_ea1f338d10e88415();
    
    foreach ( player in level.players )
    {
        player playlocalsound( "evt_mq_game_start_stinger" );
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x26d05bb6, Offset: 0x221e
// Size: 0x32f
function function_9eba76c5821a19c2()
{
    if ( !isdefined( level.var_4a9f79fdc8d4c43a ) || level.var_4a9f79fdc8d4c43a.size == 0 )
    {
        return;
    }
    
    if ( level.var_f99d6f001b5905d6 == 1 )
    {
        var_ed92d3edd3eded9 = undefined;
        
        foreach ( bear_struct in level.var_4a9f79fdc8d4c43a )
        {
            if ( bear_struct.script_noteworthy == "1" )
            {
                var_ed92d3edd3eded9 = bear_struct;
                break;
            }
        }
        
        if ( !isdefined( var_ed92d3edd3eded9 ) )
        {
            var_ed92d3edd3eded9 = level.var_4a9f79fdc8d4c43a[ 0 ];
        }
    }
    else if ( level.var_f99d6f001b5905d6 == 2 )
    {
        var_ed92d3edd3eded9 = undefined;
        
        foreach ( bear_struct in level.var_4a9f79fdc8d4c43a )
        {
            if ( bear_struct.script_noteworthy == "2" )
            {
                var_ed92d3edd3eded9 = bear_struct;
                break;
            }
        }
        
        if ( !isdefined( var_ed92d3edd3eded9 ) )
        {
            var_ed92d3edd3eded9 = level.var_4a9f79fdc8d4c43a[ 0 ];
        }
    }
    else
    {
        level.var_4a9f79fdc8d4c43a = arrayrandomize( level.var_4a9f79fdc8d4c43a );
        var_ed92d3edd3eded9 = level.var_4a9f79fdc8d4c43a[ 0 ];
        
        if ( var_ed92d3edd3eded9 == level.var_d42ba5a6dc33a16c && level.var_4a9f79fdc8d4c43a.size > 1 )
        {
            var_ed92d3edd3eded9 = level.var_4a9f79fdc8d4c43a[ 1 ];
        }
    }
    
    if ( !isdefined( var_ed92d3edd3eded9 ) )
    {
        return;
    }
    
    vfx_tag_origin = utility::spawn_model( "tag_origin", var_ed92d3edd3eded9.origin, var_ed92d3edd3eded9.angles );
    model_entity = spawn( "script_model", var_ed92d3edd3eded9.origin );
    model_entity.var_3e98315ce519724d = vfx_tag_origin;
    model_entity.angles = var_ed92d3edd3eded9.angles;
    model_entity setscale( 4 );
    model_entity playsound( #"hash_f33254f71234dcbc" );
    model_entity playloopsound( #"hash_ebae56de5d395785" );
    model_entity.var_3e98315ce519724d function_6e4e31a49eb93680();
    model_entity setmodel( "jup_toy_plane_passenger_stuffed_toy_01_mantis_rh" );
    
    if ( !isdefined( model_entity ) )
    {
        return;
    }
    
    model_entity thread function_9de7e5c82318f28a();
    model_entity.var_3e98315ce519724d function_742114b00d551dd0();
    level.var_4a9f79fdc8d4c43a = arrayremove( level.var_4a9f79fdc8d4c43a, var_ed92d3edd3eded9 );
    level.var_d42ba5a6dc33a16c = var_ed92d3edd3eded9;
    trigger = spawn( "trigger_radius", var_ed92d3edd3eded9.origin, 0, 70, 60 );
    trigger.model_entity = model_entity;
    trigger.spawn_step = level.var_f99d6f001b5905d6;
    trigger thread bear_cleanup_watcher();
    trigger thread function_46db4cedf367028c();
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x9b0ea5c0, Offset: 0x2555
// Size: 0xaa
function function_9de7e5c82318f28a()
{
    self endon( #"death" );
    base_origin = self.origin;
    base_angles = self.angles;
    bob_phase = randomint( 360 );
    rotation_yaw = base_angles[ 1 ];
    
    while ( isdefined( self ) )
    {
        bob_offset = sin( bob_phase ) * 4;
        self.origin = ( base_origin[ 0 ], base_origin[ 1 ], base_origin[ 2 ] + bob_offset );
        rotation_yaw += 2;
        self.angles = ( base_angles[ 0 ], rotation_yaw, base_angles[ 2 ] );
        bob_phase += 5;
        waitframe();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xf32627b6, Offset: 0x2607
// Size: 0x21a
function function_46db4cedf367028c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"rh_timer_end" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", e_ent );
        
        if ( !isplayer( e_ent ) )
        {
            continue;
        }
        
        playworldsound( self.model_entity.origin, #"hash_4728687dd6334103" );
        self.model_entity.var_3e98315ce519724d function_ed9347e24455462b();
        
        if ( isdefined( self.model_entity ) )
        {
            self.model_entity.var_3e98315ce519724d function_78987c4a6aff7973();
            self.model_entity.var_3e98315ce519724d delete();
            self.model_entity delete();
        }
        
        if ( isdefined( level.var_90848e55b7621950 ) )
        {
            n_bonus_timer = bonus_time( level.players.size );
            level.var_90848e55b7621950 += n_bonus_timer * 1000;
        }
        
        level.var_f99d6f001b5905d6++;
        level.var_e9d1d09647d126ec++;
        
        /#
            iprintlnbold( "<dev string:x24>" + level.var_e9d1d09647d126ec );
        #/
        
        if ( level.var_e9d1d09647d126ec == 11 )
        {
            level notify( #"hash_11d2f59efe8e3353" );
            
            /#
                iprintlnbold( "<dev string:x2c>" );
            #/
            
            foreach ( player in level.players )
            {
                player playlocalsound( "evt_mq_game_success" );
            }
            
            setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
            level thread function_f266182b962a11da();
            level thread function_80cc92876dfcad2a();
            self delete();
            return;
        }
        
        level thread function_9eba76c5821a19c2();
        self delete();
        return;
    }
}

// Namespace zm_sat_mantis_rh
// Params 1, eflags: 0x4
// Checksum 0x78234405, Offset: 0x2829
// Size: 0x61
function private bonus_time( player_size )
{
    switch ( player_size )
    {
        case 4:
            return 3;
        case 3:
            return 3;
        case 2:
            return 4;
        case 1:
            return 5;
        default:
            return 5;
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xdcb3f8f9, Offset: 0x2892
// Size: 0x7f
function bear_cleanup_watcher()
{
    self notify( #"hash_eb0f878eb7ba64ae" );
    self endon( #"hash_eb0f878eb7ba64ae" );
    level waittill( #"rh_timer_end" );
    
    if ( isdefined( self.model_entity ) && isdefined( self ) )
    {
        self.model_entity.var_3e98315ce519724d function_78987c4a6aff7973();
        self.model_entity.var_3e98315ce519724d delete();
        self.model_entity delete();
        self delete();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x44eb1c22, Offset: 0x2919
// Size: 0x2c
function function_6e4e31a49eb93680()
{
    intro_fx = utility::getfx( "bear_game_intro" );
    playfxontag( intro_fx, self, "tag_origin" );
    wait 0.2;
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x6edb987f, Offset: 0x294d
// Size: 0x26
function function_742114b00d551dd0()
{
    idle_fx = utility::getfx( "bear_game_idle" );
    playfxontag( idle_fx, self, "tag_origin" );
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x950ca1d1, Offset: 0x297b
// Size: 0x2c
function function_ed9347e24455462b()
{
    grabbed_fx = utility::getfx( "bear_game_grabbed" );
    playfxontag( grabbed_fx, self, "tag_origin" );
    wait 0.2;
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x5164f04a, Offset: 0x29af
// Size: 0x40
function function_78987c4a6aff7973()
{
    idle_fx = utility::getfx( "bear_game_idle" );
    stopfxontag( idle_fx, self, "tag_origin" );
    idle_fx = utility::getfx( "bear_game_intro" );
    stopfxontag( idle_fx, self, "tag_origin" );
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xb305c788, Offset: 0x29f7
// Size: 0x4f
function function_772ab9c9615ff4d1()
{
    player_count = 0;
    
    if ( isdefined( level.players ) )
    {
        player_count = level.players.size;
    }
    
    if ( player_count <= 1 )
    {
        return 34000;
    }
    
    if ( player_count == 2 )
    {
        return 17000;
    }
    
    if ( player_count == 3 )
    {
        return 14000;
    }
    
    return 12000;
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x2dee6a05, Offset: 0x2a4f
// Size: 0x26f
function function_5a13cf89e973542e()
{
    level endon( #"game_ended" );
    level endon( #"rh_timer_end" );
    level endon( #"hash_11d2f59efe8e3353" );
    level.var_c370c6525764656c = 0;
    n_time_start_ms = gettime();
    level.var_90848e55b7621950 = function_772ab9c9615ff4d1();
    n_time_taken = gettime() - n_time_start_ms;
    level.var_c370c6525764656c = level.var_90848e55b7621950 - n_time_taken;
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 1 );
    setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + level.var_c370c6525764656c );
    setomnvarforallclients( "ui_zm_echo_portal_timer_string_index", getlocstringindex( &"hash_297854017b29d439" ) );
    
    foreach ( player in level.players )
    {
        player gameplay_sound_fx::playlocalsoundfx( #"hash_d61f0ffe6b1d6d80" );
    }
    
    while ( isdefined( level.var_c370c6525764656c ) )
    {
        n_time_taken = gettime() - n_time_start_ms;
        level.var_c370c6525764656c = level.var_90848e55b7621950 - n_time_taken;
        setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + level.var_c370c6525764656c );
        function_4122782ebe9a30d0();
        
        if ( level.var_c370c6525764656c <= 0 )
        {
            foreach ( player in level.players )
            {
                player playlocalsound( "evt_mq_game_failure" );
            }
            
            /#
                iprintlnbold( "<dev string:x34>" );
            #/
            
            level thread function_aee3eb9306149db4();
            setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
            level thread function_f266182b962a11da();
            
            if ( !istrue( level.var_cb9adf3f82589153 ) )
            {
                level.var_cb9adf3f82589153 = 1;
                level thread overlord::playconversation( hashcat( #"hash_9e1256a3eb9e8b3d", randomintrange( 1, 9 ) ) );
            }
            
            level notify( #"rh_timer_end" );
            wait 0.6;
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0xed85f4c7, Offset: 0x2cc6
// Size: 0x1aa
function function_4122782ebe9a30d0()
{
    if ( level.var_c370c6525764656c == 1000 )
    {
        foreach ( player in level.players )
        {
            player gameplay_sound_fx::playlocalsoundfx( #"hash_81e87b292d17fbbe" );
        }
        
        return;
    }
    
    if ( level.var_c370c6525764656c <= 5000 )
    {
        foreach ( player in level.players )
        {
            player gameplay_sound_fx::playlocalsoundfx( #"hash_d705f30699bf2927" );
        }
        
        return;
    }
    
    if ( level.var_c370c6525764656c < 15000 )
    {
        foreach ( player in level.players )
        {
            player gameplay_sound_fx::playlocalsoundfx( #"hash_cfc761fb5bffa621" );
        }
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x8dd86879, Offset: 0x2e78
// Size: 0x24
function function_aee3eb9306149db4()
{
    level waittill( #"on_round_end" );
    level thread function_c62bb27f7150d4f5();
    level utility::flag_set( "rh_minigame_ready" );
}

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x4
// Checksum 0x1ec2405, Offset: 0x2ea4
// Size: 0x5f
function private function_ea1f338d10e88415()
{
    level endon( #"game_ended" );
    level endon( #"rh_timer_end" );
    level endon( #"hash_11d2f59efe8e3353" );
    level.var_6bea37213af656d8 = [];
    
    while ( true )
    {
        spawn_delay_sec = function_d2dea1eb5c269d79( level.players.size );
        level thread function_c0cbc4ef38baedf6();
        wait spawn_delay_sec;
    }
}

// Namespace zm_sat_mantis_rh
// Params 1, eflags: 0x4
// Checksum 0xca0f6c9f, Offset: 0x2f0b
// Size: 0x64
function private function_d2dea1eb5c269d79( player_size )
{
    switch ( player_size )
    {
        case 4:
            return 2;
        case 3:
            return 2.25;
        case 2:
            return 3;
        case 1:
            return 4;
        default:
            return 4;
    }
}

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x4
// Checksum 0x976a8976, Offset: 0x2f77
// Size: 0xe4
function private function_c0cbc4ef38baedf6()
{
    max_zombie_count = 40;
    active_zombie_count = zm_utility::get_active_zombies_count();
    
    if ( active_zombie_count >= max_zombie_count )
    {
        return;
    }
    
    zombie_type = function_b3988325430ce242( "zombie_base" );
    zone_spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_street_2_f", "zone_culdesac_4_f", "zone_culdesac_1_f", "zone_culdesac_3_f", "zone_street_5_f" ], zombie_type );
    zmb_spawner = utility::array_random( zone_spawners );
    zombie = agent_manager::spawn_agent( zombie_type, zmb_spawner.origin, zmb_spawner.angles, "team_two_hundred" );
    zombie zm_utility::setup_quest_ai();
    level.var_6bea37213af656d8[ level.var_6bea37213af656d8.size ] = zombie;
    zombie agent_spawner::function_ce10e453e7f7bb8e( zmb_spawner );
}

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x4
// Checksum 0xb47ceac7, Offset: 0x3063
// Size: 0x8e
function private function_f266182b962a11da()
{
    foreach ( zombie in level.var_6bea37213af656d8 )
    {
        if ( isalive( zombie ) )
        {
            zombie thread function_5bbd540197e3fd();
        }
    }
    
    level.var_6bea37213af656d8 = undefined;
}

// Namespace zm_sat_mantis_rh
// Params 0, eflags: 0x4
// Checksum 0xb1921f72, Offset: 0x30f9
// Size: 0x108
function private function_5bbd540197e3fd()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait randomfloatrange( 1, 1.25 );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    zombie_stun::stun_ai( 100 );
    var_d8c7a0fac844e6b = utility::getfx( "zombie_impact" );
    var_b0a812f37b404b6e = utility::getfx( "zombie_impact_blood" );
    
    if ( isdefined( var_d8c7a0fac844e6b ) && isdefined( var_b0a812f37b404b6e ) )
    {
        if ( self tagexists( "j_spine4" ) )
        {
            playfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
        }
        
        wait randomfloatrange( 0.5, 1 );
        
        if ( isalive( self ) && self tagexists( "j_spine4" ) )
        {
            stopfxontag( var_d8c7a0fac844e6b, self, "j_spine4" );
            playfxontag( var_b0a812f37b404b6e, self, "j_spine4" );
        }
    }
    
    wait 0.25;
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x496ef963, Offset: 0x3209
// Size: 0x2de
function function_80cc92876dfcad2a()
{
    s_interact_loc = utility::getstruct( "tiger_cub", "targetname" );
    
    if ( isdefined( level.var_e766fedb34dc3a40 ) )
    {
        moved_pieces = [];
        
        foreach ( toy_piece in level.var_31c1f72e160872d8 )
        {
            if ( isdefined( toy_piece ) )
            {
                moved_pieces[ moved_pieces.size ] = toy_piece;
                toy_piece moveto( s_interact_loc.origin, 1.5 );
            }
        }
        
        foreach ( toy_piece in level.var_e766fedb34dc3a40 )
        {
            if ( isdefined( toy_piece ) )
            {
                moved_pieces[ moved_pieces.size ] = toy_piece;
                toy_piece moveto( s_interact_loc.origin, 1.5 );
            }
        }
        
        wait 1.4;
        fx = utility::getfx( "bear_combine" );
        var_3e98315ce519724d = utility::spawn_model( "tag_origin", s_interact_loc.origin, s_interact_loc.angles );
        playfxontag( fx, var_3e98315ce519724d, "tag_origin" );
        playworldsound( var_3e98315ce519724d.origin, #"hash_f3dc5e89d9d29de6" );
        wait 0.6;
        
        foreach ( toy_piece in moved_pieces )
        {
            if ( isdefined( toy_piece ) )
            {
                toy_piece delete();
            }
        }
        
        var_3e98315ce519724d delete();
    }
    
    if ( isdefined( level.var_34159e1af1e15e17 ) )
    {
        level.var_34159e1af1e15e17 delete();
    }
    
    waitframe();
    var_34e2da0d3f0f8b22 = spawn( "script_model", s_interact_loc.origin );
    var_34e2da0d3f0f8b22 setscale( 2 );
    var_34e2da0d3f0f8b22 setmodel( "jup_toy_plane_passenger_stuffed_toy_01_mantis_rh" );
    var_34e2da0d3f0f8b22 thread function_9de7e5c82318f28a();
    var_34e2da0d3f0f8b22.interact = interaction::register_interact( var_34e2da0d3f0f8b22.origin + ( 0, 0, 20 ), 80, &pick_up_item, &function_6f54b3e0c81c720b );
    var_34e2da0d3f0f8b22.interact.var_34e2da0d3f0f8b22 = var_34e2da0d3f0f8b22;
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x4990e89d, Offset: 0x34ef
// Size: 0x56
function pick_up_item( player )
{
    level utility::flag_set( "rh_it_don" );
    level thread spawn_box_interact();
    playworldsound( self.var_34e2da0d3f0f8b22.origin, #"hash_d8047720d352b10f" );
    self.var_34e2da0d3f0f8b22 delete();
    self delete();
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0xb8fda2f2, Offset: 0x354d
// Size: 0x36
function function_6f54b3e0c81c720b( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_rh
// Params 0
// Checksum 0x9847f0b4, Offset: 0x358c
// Size: 0x61
function spawn_box_interact()
{
    pos = utility::getstruct( "bb_gun_3", "targetname" );
    box_interact = interaction::register_interact( pos.origin + ( 0, 0, 25 ), 60, &box_interact_func, &box_interact_hint );
    box_interact.pos = pos;
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0x98210ffc, Offset: 0x35f5
// Size: 0x67
function box_interact_func( player )
{
    if ( level utility::flag( "rh_it_don" ) )
    {
        level utility::flag_set( "rh_mantis_complete" );
        self delete();
        level.rh_toy_box zm_rabbithole::toybox_give_reward( "jup_toy_plane_passenger_stuffed_toy_01_mantis_rh", ( 0, -115, 0 ) );
        wait 1.5;
        level thread overlord::playconversation( #"hash_497296b5515123b7" );
    }
}

// Namespace zm_sat_mantis_rh
// Params 2
// Checksum 0x4834af4b, Offset: 0x3664
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_mantis_rh
// Params 1
// Checksum 0xecd9de9d, Offset: 0x36a3
// Size: 0x14d
function on_exfil_success( params )
{
    if ( level utility::flag( "rh_to_pic" ) )
    {
        level.var_e8b776e9698cb857 = 1;
        event_str = zm_rabbithole::function_85eaee7552aadd2e();
        
        foreach ( player in params.a_exfil_players )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
                
                if ( player.var_11f0a190160021dd && player.var_1bf107e8638f5574 && player.var_4ad88eeba60b1ac && player.var_7fe31db612cd941a && player.var_27501a6cf23a6c06 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                }
            }
        }
    }
}

/#

    // Namespace zm_sat_mantis_rh
    // Params 0
    // Checksum 0xcf7c3c25, Offset: 0x37f8
    // Size: 0x86, Type: dev
    function init_mantis_rh_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3b>" );
        devgui::add_devgui_func( "<dev string:x55>", "<dev string:x55>", &function_e4bccd750016735d );
        devgui::add_devgui_func( "<dev string:x5f>", "<dev string:x5f>", &function_b571c53579c37834 );
        devgui::add_devgui_func( "<dev string:x70>", "<dev string:x70>", &function_582a7e5532835d19 );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x7c>", &function_a146f4dfa8dda4e8 );
        devgui::add_devgui_func( "<dev string:x8c>", "<dev string:x8c>", &function_e41ef24cbba212f8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0x150c964e, Offset: 0x3886
    // Size: 0x12, Type: dev
    function private function_e4bccd750016735d()
    {
        level utility::flag_set( "<dev string:x9b>" );
    }

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0x3f1ebc46, Offset: 0x38a0
    // Size: 0x12, Type: dev
    function private function_b571c53579c37834()
    {
        level utility::flag_set( "<dev string:xa5>" );
    }

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0x85ce42fb, Offset: 0x38ba
    // Size: 0xd, Type: dev
    function private function_582a7e5532835d19()
    {
        level thread function_4e458412869c15ec();
    }

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0x2ee0af28, Offset: 0x38cf
    // Size: 0x31, Type: dev
    function private function_a146f4dfa8dda4e8()
    {
        level.rh_toy_box = zm_rabbithole::spawn_toybox( "<dev string:xad>" );
        level.rh_toy_box zm_rabbithole::toybox_open();
        level thread function_80cc92876dfcad2a();
    }

    // Namespace zm_sat_mantis_rh
    // Params 0, eflags: 0x4
    // Checksum 0xf5986245, Offset: 0x3908
    // Size: 0x12, Type: dev
    function private function_e41ef24cbba212f8()
    {
        level utility::flag_set( "<dev string:xb6>" );
    }

#/
