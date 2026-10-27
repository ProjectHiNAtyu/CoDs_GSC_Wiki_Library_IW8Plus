// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rh.gsc  (hash_06676d13bfa27d4e.gscc) (size: 25654 Bytes / 0x6436 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3677f2d4 (913830612)
// size ...... 25654 (0x6436)
// includes .. 19  (offset: 0x5d2e)
// strings ... 84  (offset: 0x5dc6)
// dev strs .. 24  (offset: 0x62fa)
// exports ... 51  (offset: 0x3e2a)
// cseg ...... 0x6aa + 0x3780 (0x3e2a)
// imports ... 175 (offset: 0x4622)
// animtree1 . 0   (offset: 0x6436)
// animtree2 . 0   (offset: 0x6436)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\augments\aether_shroud_augments;
#using scripts\mp\common\equipment\c4;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_phone;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_ncfdpedestal;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_scarab_rh;

// Namespace zm_sat_scarab_rh
// Params 0, eflags: 0x5
// Checksum 0xd63b2b92, Offset: 0x6c8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"scarab_rh", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_rh
// Params 0, eflags: 0x4
// Checksum 0xa2eca0c3, Offset: 0x6e9
// Size: 0xe0
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
    level._effect[ #"toy_trail" ] = loadfxasset( "vfx_t10_gameplay_zm_loot_trail_rare" );
    level._effect[ #"platform_spawn" ] = loadfxasset( "vfx_sat_zm_scarab_float_platform_spawn" );
    
    /#
        init_rh_debug();
    #/
    
    level utility::flag_wait( "zm_quest_initialized" );
    level thread setup_platforms();
    set_up_quest();
}

// Namespace zm_sat_scarab_rh
// Params 1, eflags: 0x4
// Checksum 0xc69d031f, Offset: 0x7d1
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

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x28eb1744, Offset: 0x812
// Size: 0xfc
function set_up_quest()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "super_ee_save_check" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level utility::flag_wait( "wanna_wingo_eh" );
    level callback::add( "on_grapple_pulling_start", &function_273d8d28b94453a7 );
    level.s_lock_location = utility::getstructarray( "ll_rh", "targetname" );
    random_lock = utility::array_random( level.s_lock_location );
    level.rh_lock = spawn( "script_model", random_lock.origin );
    level.rh_lock.angles = random_lock.angles;
    level.rh_lock setscale( 5 );
    level.rh_lock setmodel( "t10_debris_rusty_metal_lock_01" );
    level.rh_lock thread lock_bob( 1, 5 );
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0x5768fea6, Offset: 0x916
// Size: 0x9d
function lock_bob( bobspeed, height )
{
    self endon( #"death" );
    self endon( #"tb_triggered" );
    level endon( #"game_ended" );
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

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x5655ba8e, Offset: 0x9bb
// Size: 0x690
function setup_platforms()
{
    level.zm_moving_platforms_rh = [];
    level.zm_moving_platforms_rh = getentarray( "zm_movplat_rh", #targetname );
    level.var_1e72ecfc5f237e3d = getentarray( "zm_vert_movplat_rh", #targetname );
    
    if ( level.zm_moving_platforms_rh.size == 0 )
    {
        return;
    }
    
    foreach ( platform in level.zm_moving_platforms_rh )
    {
        platform hide();
        platform.starting_origin = platform.origin;
        
        if ( platform.script_noteworthy == "final_plat" )
        {
            level.final_plat = platform;
            platform.final_plat_rh = 1;
            level.final_plat.start_origin = level.final_plat.origin;
        }
    }
    
    foreach ( platform in level.var_1e72ecfc5f237e3d )
    {
        platform hide();
    }
    
    level thread set_platform_angles();
    level.var_91bed5636f5f050d = getentarray( "m_pltfm_vlm_rh", "targetname" );
    var_bc45d2d32752059 = getentarray( "movplat_rh_clip", "targetname" );
    var_850a68fff4bebd40 = getent( "movplat_rh_slipclip", "targetname" );
    var_c4ba279d40141d5b = getentarray( "wb_rh_clip", "targetname" );
    var_4d322962cfc6c74d = getentarray( "vertplat_rh_clip", "targetname" );
    
    foreach ( v in level.var_91bed5636f5f050d )
    {
        owner = function_47c86977a18df38b( level.zm_moving_platforms_rh, v.origin, 200 );
        
        if ( !owner )
        {
            owner = function_47c86977a18df38b( level.var_1e72ecfc5f237e3d, v.origin, 200 );
        }
        
        v enablelinkto();
        v linkto( owner );
        v.my_owner = owner;
        owner.my_volume = v;
        owner.v_highest = owner.origin + ( 0, 0, 20 );
        owner.v_lowest = owner.origin - ( 0, 0, 20 );
    }
    
    foreach ( clip in var_bc45d2d32752059 )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms_rh, clip.origin, 1000 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_59f931d3a85c740f = clip;
        clip notsolid();
    }
    
    foreach ( clip in var_c4ba279d40141d5b )
    {
        owner = function_b21056d585c710d( level.var_1e72ecfc5f237e3d, clip.origin, 1000 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_7bde685b17de0685 = clip;
        owner.v_highest = owner.origin + ( 0, 0, 40 );
        owner.v_lowest = owner.origin - ( 0, 0, 40 );
        clip notsolid();
    }
    
    foreach ( clip in var_4d322962cfc6c74d )
    {
        owner = function_b21056d585c710d( level.var_1e72ecfc5f237e3d, clip.origin, 1000 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_fb9875a359640c31 = clip;
        clip notsolid();
    }
    
    owner = function_b21056d585c710d( level.zm_moving_platforms_rh, var_850a68fff4bebd40.origin, 1000 );
    var_850a68fff4bebd40 enablelinkto();
    var_850a68fff4bebd40 linkto( owner );
    var_850a68fff4bebd40.my_owner = owner;
    owner.var_954e28ef2b10ad82 = var_850a68fff4bebd40;
    var_850a68fff4bebd40 notsolid();
    
    foreach ( v in level.var_91bed5636f5f050d )
    {
        if ( v.my_owner.targetname == "zm_vert_movplat_rh" )
        {
            level.var_91bed5636f5f050d = arrayremove( level.var_91bed5636f5f050d, v );
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x71eac21b, Offset: 0x1053
// Size: 0x173
function function_7a10f9b8873021e9()
{
    level endon( #"game_ended" );
    level endon( #"platform_stop" );
    self endon( #"drop_triggered" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                player.b_on_platform = 1;
                player.var_12c0f0837fb9c7bb = self;
                break;
            }
        }
        
        if ( self.b_is_busy )
        {
            if ( !self.my_owner.var_6f94844477c699f1 )
            {
                function_8d748791ae0942c();
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player.var_12c0f0837fb9c7bb == self )
                {
                    thread function_9bbe800f4324198d( player );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x2c4dd9a3, Offset: 0x11ce
// Size: 0x15b
function function_9bbe800f4324198d( player )
{
    level endon( #"game_ended" );
    self endon( #"no_players_touching" );
    player.b_on_platform = 1;
    player.var_12c0f0837fb9c7bb = self;
    self.b_is_busy = 1;
    
    if ( player.b_on_platform && self.my_owner.final_plat_rh && !level utility::flag( "final_plat_rotated" ) )
    {
        wait 3;
        self.my_owner notify( #"quit_bob" );
        self.my_owner thread do_lean();
        player.b_on_platform = 0;
        player.var_12c0f0837fb9c7bb = undefined;
        level utility::flag_set( "final_plat_rotated" );
        self.b_is_busy = 0;
        return;
    }
    
    if ( !self.my_owner.dropping && !self.my_owner.final_plat_rh )
    {
        wait 5;
        self.my_owner notify( #"quit_bob" );
        self notify( #"drop_triggered" );
        self.my_owner thread do_drop();
        player.b_on_platform = 0;
        player.var_12c0f0837fb9c7bb = undefined;
        self.b_is_busy = 0;
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xfd3bfb21, Offset: 0x1331
// Size: 0x13a
function do_drop()
{
    level endon( #"game_ended" );
    self endon( #"reset_lean" );
    utility::do_jitter( 5, 5, 1, 1, 1 );
    self.dropping = 1;
    self movez( -500, 0.5 );
    self playsound( #"hash_2c41f1d3ee843cfd" );
    self playloopsound( #"hash_ef0b96815c4acd43" );
    self.var_6f94844477c699f1 = 1;
    self waittill( #"movedone" );
    self.dropping = 0;
    playfxontag( level._effect[ #"platform_spawn" ], self, "tag_origin" );
    self hide();
    self.var_59f931d3a85c740f notsolid();
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
    wait 6;
    thread reset_drop();
    self playsound( #"hash_2c41f1d3ee843cfd" );
    self playloopsound( #"hash_ef0b96815c4acd43" );
    wait 1;
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
    self.my_volume.b_is_busy = 0;
    self.var_6f94844477c699f1 = 0;
    self.my_volume thread function_7a10f9b8873021e9();
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x438f43b0, Offset: 0x1473
// Size: 0xa5
function reset_drop()
{
    level endon( #"game_ended" );
    self notify( #"reset_drop" );
    self.my_volume.b_is_busy = 0;
    self movez( -500, 0.5 );
    self waittill( #"movedone" );
    
    if ( !self.hide )
    {
        playfxontag( level._effect[ #"platform_spawn" ], self, "tag_origin" );
        self show();
        self.var_59f931d3a85c740f solid();
        thread do_bob();
        self stoploopsound();
        self playsound( #"hash_2c7f7dcfa6116ec4" );
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xec4c6c0e, Offset: 0x1521
// Size: 0xf3
function do_lean()
{
    level endon( #"game_ended" );
    self endon( #"reset_lean" );
    wait 2;
    self.starting_angles = self.angles;
    self rotateby( ( 75, 0, 0 ), 1 );
    thread set_slick_clip( 1 );
    self playsound( #"hash_2c41f1d3ee843cfd" );
    self playloopsound( #"hash_ef0b96815c4acd43" );
    wait 0.5;
    
    if ( level.var_9db4d679c2330f54 )
    {
        level.var_9db4d679c2330f54 unlink();
        level thread drop_box();
    }
    
    self.var_6f94844477c699f1 = 1;
    self waittill( #"rotatedone" );
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
    self.my_volume.b_is_busy = 0;
    self.var_6f94844477c699f1 = 0;
    level waittill( #"reset_lean" );
    thread reset_lean();
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x472e973a, Offset: 0x161c
// Size: 0x54
function set_slick_clip( var_5bd9b6a6a6a5d2a0 )
{
    level endon( #"game_ended" );
    
    if ( var_5bd9b6a6a6a5d2a0 )
    {
        if ( self.var_954e28ef2b10ad82 )
        {
            self.var_954e28ef2b10ad82 solid();
        }
        
        return;
    }
    
    if ( self.var_954e28ef2b10ad82 )
    {
        self.var_954e28ef2b10ad82 notsolid();
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x794a68ce, Offset: 0x1678
// Size: 0x6d
function do_bob()
{
    level endon( #"game_ended" );
    self endon( #"quit_bob" );
    wait randomfloat( 2 );
    
    while ( true )
    {
        self moveto( self.v_highest, 5, 1, 1 );
        self waittill( #"movedone" );
        self moveto( self.v_lowest, 5, 1, 1 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xbba8aef7, Offset: 0x16ed
// Size: 0x7f
function set_platform_angles()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.zm_moving_platforms_rh.size ; i++ )
    {
        level.zm_moving_platforms_rh[ i ] rotateyaw( 15 * i, 0.05 );
        wait 0.1;
        level.zm_moving_platforms_rh[ i ].start_angles = level.zm_moving_platforms_rh[ i ].angles;
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x39d97073, Offset: 0x1774
// Size: 0xd3
function function_8d748791ae0942c()
{
    b_players_touching = 0;
    
    foreach ( player in level.players )
    {
        if ( player istouching( self ) )
        {
            b_players_touching = 1;
            break;
        }
        
        if ( self == player.var_12c0f0837fb9c7bb )
        {
            player.b_on_platform = 0;
            player.var_12c0f0837fb9c7bb = undefined;
        }
    }
    
    if ( b_players_touching == 0 )
    {
        self.b_is_busy = 0;
        self notify( #"no_players_touching" );
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x7df9df3e, Offset: 0x184f
// Size: 0x8a
function reset_lean()
{
    level endon( #"game_ended" );
    self notify( #"reset_lean" );
    self.my_volume.b_is_busy = 0;
    self rotateto( self.starting_angles, 1 );
    wait 1;
    self hide();
    self moveto( level.final_plat.start_origin, 0.1 );
    self.var_59f931d3a85c740f notsolid();
    thread set_slick_clip( 0 );
    level utility::flag_clear( "final_plat_rotated" );
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0xa7a1bf3a, Offset: 0x18e1
// Size: 0x91
function bob_item( bobspeed, height )
{
    self endon( #"death" );
    level endon( #"game_ended" );
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

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x64c7a7a4, Offset: 0x197a
// Size: 0x2f7
function function_273d8d28b94453a7( params )
{
    if ( level utility::flag( "dance_vote_in_progress" ) || level utility::flag( "dance_off_in_progress" ) || level utility::flag( "start_br_vote" ) )
    {
        return;
    }
    
    grapple_ent = self getgrappletargetentity();
    
    if ( grapple_ent.model == "t10_debris_rusty_metal_lock_01" )
    {
        level callback::remove( "on_grapple_pulling_start", &function_273d8d28b94453a7 );
        warp_loc = utility::getstruct( "portal_1a", "script_noteworthy" );
        function_38ea40802d9e7436();
        
        foreach ( player in level.var_4d2b72d87bc67e03 )
        {
            player playlocalsound( #"hash_f2d861cf39962c61" );
            level thread utility::fadetoblackforplayer( player, 1, 3 );
            level thread zm_fasttravel::function_cbb08198e7c84adf( warp_loc, player, undefined, undefined, 1 );
            player val::set( "rh_trial_active", "killstreaks", 0 );
            level thread zm_sat_scarab_phone::function_e31fd04f8a18de90();
            wait 1;
            level thread utility::fadetoblackforplayer( player, 0 );
            ref = player equipment_mp::getcurrentequipment( "secondary" );
            
            if ( ref == "equip_grappling_hook" || ref == "equip_grappling_hook_upgraded" )
            {
                player equipment_mp::takeequipment( "secondary" );
            }
            
            utility::function_32b24db3127bff40( "grappling_hook_speed_cam", "off" );
            player thread zm_ncfdpedestal::force_end_grapple();
        }
        
        level utility::flag_set( "rh_trial_active" );
        level.var_9db4d679c2330f54 = zm_rabbithole::spawn_toybox( "tb_roll" );
        level.var_9db4d679c2330f54.aether = 1;
        level.var_5b515ea304ec3599 = spawn( "script_model", utility::getstruct( "tb_roll", "targetname" ).origin );
        level.var_5b515ea304ec3599.angles = utility::getstruct( "tb_roll", "targetname" ).angles;
        level.var_5b515ea304ec3599 setmodel( "reveal::sat_zm_toy_chest_rh_fxanim_at" );
        level.var_5b515ea304ec3599 utility::function_7c10ea82c1e305b8( "anim", "close_fast" );
        level.var_5b515ea304ec3599 utility::function_7c10ea82c1e305b8( "fx", "off" );
        wait 0.5;
        level.rh_lock delete();
        level.var_5b515ea304ec3599 linkto( level.var_9db4d679c2330f54, "tag_origin" );
        level.var_9db4d679c2330f54 linkto( level.final_plat, "tag_origin" );
        level thread spawn_platforms();
        level waittill( #"hash_99bc34be2e1591a7" );
        level thread defend_timer();
        setup_trial();
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xd1d1c375, Offset: 0x1c79
// Size: 0xe9
function function_38ea40802d9e7436()
{
    level.var_4d2b72d87bc67e03 = level.players;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player utility::ent_flag( "consume_fruit_scene_in_prog" ) || player utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) || istrue( player.var_c6d48777fc700ed8 ) || player utility::ent_flag( "black_room_visited" ) )
        {
            level.var_4d2b72d87bc67e03 = arrayremove( level.var_4d2b72d87bc67e03, player );
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x6c9129da, Offset: 0x1d6a
// Size: 0x77
function drop_box()
{
    var_cba7166ff7bf9646 = utility::getstruct( "tb_final", "script_noteworthy" );
    level thread rotate_box( var_cba7166ff7bf9646 );
    level.var_9db4d679c2330f54 moveto( var_cba7166ff7bf9646.origin, 1 );
    wait 2;
    level.aether_box_interact = zm_quest::function_91f9590e98d57ff6( level.var_9db4d679c2330f54.origin, &box_open, &hidden_hint, "small" );
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x7541c229, Offset: 0x1de9
// Size: 0x27
function rotate_box( struct )
{
    level.var_9db4d679c2330f54 rotateto( struct.angles, 1 );
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x22c60753, Offset: 0x1e18
// Size: 0x1b9
function spawn_platforms()
{
    foreach ( platform in level.zm_moving_platforms_rh )
    {
        platform.hide = 0;
        platform.var_59f931d3a85c740f solid();
        platform show();
        platform thread do_bob();
    }
    
    foreach ( platform in level.var_1e72ecfc5f237e3d )
    {
        platform.hide = 0;
        platform.var_7bde685b17de0685 solid();
        platform.var_fb9875a359640c31 solid();
        platform show();
        platform thread do_bob();
    }
    
    foreach ( v in level.var_91bed5636f5f050d )
    {
        v thread function_7a10f9b8873021e9();
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x319fd1f, Offset: 0x1fd9
// Size: 0x107
function setup_trial()
{
    zm_round_spawning::pause_round_spawning( 1, "rh_trial began" );
    level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 0, 1, 1, 0, undefined );
    level.rh_trial_time = gettime() + get_timer_required() * 1000;
    
    foreach ( player in level.var_4d2b72d87bc67e03 )
    {
        player setclientomnvar( "ui_zm_echo_portal_timer_vis", 1 );
        player setclientomnvar( "ui_zm_echo_portal_time", level.rh_trial_time );
        player setclientomnvar( "ui_zm_echo_portal_timer_string_index", getlocstringindex( &"hash_792891bda862ef3e" ) );
    }
    
    wait 3;
    level thread overlord::playconversation( hashcat( #"hash_ac9ee62f96303823", randomintrange( 1, 4 ) ) );
}

// Namespace zm_sat_scarab_rh
// Params 0, eflags: 0x4
// Checksum 0xb0fbe70e, Offset: 0x20e8
// Size: 0x424
function private defend_timer()
{
    level endon( #"rh_trial_complete" );
    level endon( #"game_ended" );
    var_e97ea6667652ae08 = get_timer_required() * 1000;
    var_427b3d2c2f8fb546 = gettime();
    
    do
    {
        time_passed = gettime() - var_427b3d2c2f8fb546;
        wait 1;
    }
    while ( time_passed < var_e97ea6667652ae08 );
    
    foreach ( player in level.var_4d2b72d87bc67e03 )
    {
        player setclientomnvar( "ui_zm_echo_portal_timer_vis", 0 );
        player setclientomnvar( "ui_zm_echo_portal_time", 0 );
    }
    
    level notify( #"rh_trial_failed" );
    
    if ( !level utility::flag( "rh_trial_complete" ) )
    {
        zm_round_spawning::pause_round_spawning( 0, "rh_trial began" );
        warp_loc = utility::getstruct( "portal_1b", "script_noteworthy" );
        
        foreach ( player in level.var_4d2b72d87bc67e03 )
        {
            level thread zm_fasttravel::function_cbb08198e7c84adf( warp_loc, player );
            player val::set( "rh_trial_active", "killstreaks", 1 );
        }
        
        wait 1;
        
        foreach ( platform in level.zm_moving_platforms_rh )
        {
            platform.hide = 1;
            platform moveto( platform.starting_origin, 0.1 );
            platform hide();
            platform.var_59f931d3a85c740f notsolid();
            
            if ( platform.my_volume )
            {
                platform.my_volume.b_is_busy = 0;
            }
            
            level notify( #"platform_stop" );
            platform notify( #"quit_bob" );
        }
        
        foreach ( platform in level.var_1e72ecfc5f237e3d )
        {
            platform.hide = 1;
            platform hide();
            platform.var_7bde685b17de0685 notsolid();
            platform.var_fb9875a359640c31 notsolid();
            
            if ( platform.my_volume )
            {
                platform.my_volume.b_is_busy = 0;
            }
            
            level notify( #"platform_stop" );
            platform notify( #"quit_bob" );
        }
        
        if ( level.aether_box_interact )
        {
            level.aether_box_interact freescriptable();
        }
        
        if ( level.var_9db4d679c2330f54.aether )
        {
            level.var_9db4d679c2330f54 delete();
        }
        
        if ( level.var_5b515ea304ec3599 )
        {
            level.var_5b515ea304ec3599 delete();
        }
        
        trial_cleanup();
        level utility::flag_clear( "rh_trial_active" );
        level notify( #"reset_lean" );
        level.var_81c1a55ab56b11a4 = zm_round_logic::get_rb_round_number();
        level callback::add( "on_round_start", &respawn_lock );
        level thread overlord::playconversation( hashcat( #"hash_9e1256a3eb9e8b3d", randomintrange( 1, 9 ) ) );
    }
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0xc7474b48, Offset: 0x2514
// Size: 0x24d
function box_open( player )
{
    level endon( #"game_ended" );
    
    if ( !player.aether_shroud_active )
    {
        return;
    }
    
    if ( level utility::flag( "rh_trial_complete" ) )
    {
        return;
    }
    
    level utility::flag_set( "rh_trial_complete" );
    level notify( #"rh_trial_complete" );
    level.aether_box_interact freescriptable();
    
    foreach ( player in level.var_4d2b72d87bc67e03 )
    {
        player setclientomnvar( "ui_zm_echo_portal_timer_vis", 0 );
    }
    
    zm_rabbithole::function_b422525417f4cda2();
    level.var_9db4d679c2330f54.aether = 0;
    level.var_a901ac4ab2672c87 = utility::getstructarray( "pn_rh", "targetname" );
    playworldsound( level.var_9db4d679c2330f54.origin + ( 0, 0, 25 ), #"hash_8c71f13bd10a0b48" );
    level.var_9db4d679c2330f54 utility::function_7c10ea82c1e305b8( "material", "transform" );
    level.var_5b515ea304ec3599 utility::function_7c10ea82c1e305b8( "material", "transform" );
    wait 2;
    
    if ( level.var_5b515ea304ec3599 )
    {
        level.var_5b515ea304ec3599 delete();
    }
    
    if ( level.var_9db4d679c2330f54 )
    {
        level.var_9db4d679c2330f54 thread zm_rabbithole::toybox_open();
    }
    
    wait 2.5;
    level thread spawn_wisps( level.var_a901ac4ab2672c87[ 0 ].origin, utility::getstruct( "pin_1_m" ).origin );
    level thread spawn_wisps( level.var_a901ac4ab2672c87[ 1 ].origin, utility::getstruct( "pin_2_m" ).origin );
    level thread spawn_wisps( level.var_a901ac4ab2672c87[ 2 ].origin, utility::getstruct( "pin_3_m" ).origin );
    wait 10;
    function_62f1445c48e996ca();
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0xe9fdf201, Offset: 0x2769
// Size: 0xc1
function spawn_wisps( start_origin, mid_origin )
{
    carrier_1 = utility::spawn_model( "tag_origin", level.var_9db4d679c2330f54.origin, level.var_9db4d679c2330f54.angles );
    playworldsound( level.var_9db4d679c2330f54.origin + ( 0, 0, 30 ), #"hash_ba98b31b21b9adf6" );
    playfxontag( level._effect[ #"toy_trail" ], carrier_1, "tag_origin" );
    carrier_1 thread utility::function_8001268940441423( level.var_9db4d679c2330f54.origin, start_origin, mid_origin, 3 );
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x2feb06d6, Offset: 0x2832
// Size: 0x212
function function_62f1445c48e996ca()
{
    zm_round_spawning::pause_round_spawning( 0, "rh_trial began" );
    level thread trial_cleanup();
    level thread function_687cec034b9e75fb();
    s_warp = utility::getstruct( "portal_1b", "script_noteworthy" );
    
    foreach ( player in level.var_4d2b72d87bc67e03 )
    {
        level thread zm_fasttravel::function_cbb08198e7c84adf( s_warp, player );
        player val::set( "rh_trial_active", "killstreaks", 1 );
    }
    
    wait 0.5;
    level notify( #"reset_lean" );
    level utility::flag_clear( "rh_trial_active" );
    
    foreach ( platform in level.zm_moving_platforms_rh )
    {
        platform hide();
        platform.var_59f931d3a85c740f notsolid();
        level notify( #"platform_stop" );
    }
    
    foreach ( platform in level.var_1e72ecfc5f237e3d )
    {
        platform hide();
        platform.var_7bde685b17de0685 notsolid();
        platform.var_fb9875a359640c31 notsolid();
        level notify( #"platform_stop" );
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xd68d63ef, Offset: 0x2a4c
// Size: 0x1a2
function trial_cleanup()
{
    foreach ( growth in level.var_80ec21e17cb08bce )
    {
        growth utility::callsharedfunc( #"zm_toxic_growth", #"delete_toxic_growth" );
    }
    
    foreach ( ball in level.mdl_ball_array )
    {
        ball utility::callsharedfunc( #"zm_energy_mine", #"delete_energy_mine" );
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_11a8ef77fa83ab5c )
        {
            aether_shroud_augments::function_3d49312028a8aacd();
        }
        
        player thread c4::c4_detonateall();
    }
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x43133f4a, Offset: 0x2bf6
// Size: 0xf5
function respawn_lock( params )
{
    if ( utility::percent_chance( 50 ) || level.var_81c1a55ab56b11a4 + 2 < zm_round_logic::get_rb_round_number() )
    {
        level callback::remove( "on_round_start", &respawn_lock );
        random_lock = utility::array_random( level.s_lock_location );
        level.rh_lock = spawn( "script_model", random_lock.origin );
        level.rh_lock.angles = random_lock.angles;
        level.rh_lock setscale( 5 );
        level.rh_lock setmodel( "t10_debris_rusty_metal_lock_01" );
        level.rh_lock thread lock_bob( 1, 5 );
        
        if ( !level callback::exists( "on_grapple_pulling_start", &function_273d8d28b94453a7 ) )
        {
            level callback::add( "on_grapple_pulling_start", &function_273d8d28b94453a7 );
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0xcaceaabd, Offset: 0x2cf3
// Size: 0x213
function function_687cec034b9e75fb()
{
    level.var_a901ac4ab2672c87 = utility::getstructarray( "pn_rh", "targetname" );
    level.var_4652a7ab324705b7 = [];
    level.var_5f51a72b3cef4a88 = 0;
    
    foreach ( pinata_def in level.var_a901ac4ab2672c87 )
    {
        pinata_instance = spawnscriptable( "sat_zm_pin_rh", pinata_def.origin, pinata_def.angles );
        pinata_instance.var_8f48dcf87111ab99 = pinata_def.target;
        pinata_instance.middle = pinata_def.script_noteworthy;
        pinata_instance.number = int( pinata_def.string_int );
        pinata_instance.ent = utility::spawn_model( "tag_origin", pinata_def.origin, pinata_def.angles );
        pinata_instance scriptablesetparententity( pinata_instance.ent );
        pinata_instance.ent thread bob_item( 1, 10 );
        level.var_4652a7ab324705b7[ level.var_4652a7ab324705b7.size ] = pinata_instance;
    }
    
    foreach ( pinata_instance in level.var_4652a7ab324705b7 )
    {
        if ( pinata_instance.number == 0 )
        {
            pinata_instance setscriptablepartstate( "base", "pristine" );
            break;
        }
    }
    
    scriptable::scriptable_adddamagedcallback( &function_c224e1fab028dd11 );
}

// Namespace zm_sat_scarab_rh
// Params 11, eflags: 0x4
// Checksum 0x88734362, Offset: 0x2f0e
// Size: 0x2ac
function private function_c224e1fab028dd11( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( instance.type != "sat_zm_pin_rh" )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        instance setscriptablepartstate( "base", "dead" );
        var_8f48dcf87111ab99 = utility::getstruct( instance.var_8f48dcf87111ab99, "targetname" );
        middle = utility::getstruct( instance.middle, "targetname" );
        
        if ( instance.number == 0 && !level utility::flag( "shoes_spawned" ) )
        {
            level utility::flag_set( "shoes_spawned" );
            object = spawnscriptable( "sat_zm_sh_pin", instance.origin, instance.angles );
            object.toy = "shoes";
            level.var_4803875fb29f8031 = 0;
            function_3e0da5c55c92f07b( instance.number );
            level thread overlord::playconversation( hashcat( #"pin_alt", randomintrange( 1, 3 ) ) );
            instance thread pinata_cleanup( object, var_8f48dcf87111ab99, middle );
            return;
        }
        
        if ( instance.number == 1 && !level utility::flag( "wheels_spawned" ) )
        {
            level utility::flag_set( "wheels_spawned" );
            object = spawnscriptable( "sat_zm_wh_pin", instance.origin, instance.angles );
            object.toy = "wheels";
            level.var_54542f671d87535f = 0;
            function_3e0da5c55c92f07b( instance.number );
            level thread overlord::playconversation( hashcat( #"hash_4480b2d59e32cd95", randomintrange( 1, 9 ) ) );
            instance thread pinata_cleanup( object, var_8f48dcf87111ab99, middle );
            return;
        }
        
        if ( instance.number == 2 && !level utility::flag( "laces_spawned" ) )
        {
            level utility::flag_set( "laces_spawned" );
            object = spawnscriptable( "sat_zm_lc_pin", instance.origin, instance.angles );
            level.var_16bd1b19f2126055 = 0;
            object.toy = "laces";
            instance thread pinata_cleanup( object, var_8f48dcf87111ab99, middle );
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 3
// Checksum 0x79cfd81e, Offset: 0x31c2
// Size: 0x1ba
function pinata_cleanup( object, var_8f48dcf87111ab99, middle )
{
    if ( self.ent )
    {
        self.ent delete();
        self scriptableclearparententity();
    }
    
    if ( self )
    {
        carrier = utility::spawn_model( "tag_origin", self.origin, self.angles );
        playfxontag( level._effect[ #"toy_trail" ], carrier, "tag_origin" );
        
        if ( object && carrier )
        {
            object scriptablesetparententity( carrier );
            object.parent = carrier;
            carrier utility::function_8001268940441423( self.origin, var_8f48dcf87111ab99.origin, middle.origin, 1.5 );
            stopfxontag( level._effect[ #"toy_trail" ], carrier, "tag_origin" );
            carrier thread bob_item( 2, 5 );
        }
        
        self freescriptable();
    }
    
    struct_params = spawnstruct();
    struct_params.origin = object.origin;
    struct_params.toy_name = object.toy;
    struct_params.toy = object;
    struct_params.soulsfx = { #endalias:#"hash_f690b967d7c16a2b", #var_8bee59e397c66fa0:#"hash_6ce4ae84a719a787", #var_deac89db5aa6990a:#"hash_ba98b31b21b9adf6" };
    level.var_8d5ac9d9dfc16679 = function_e09b04e0d437487();
    level callback::add( "on_zombie_ai_killed", &function_d7541e3069b36c3c, struct_params );
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0xfa162e7a, Offset: 0x3384
// Size: 0x390
function function_d7541e3069b36c3c( params, struct_params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( !struct_params.toy )
        {
            return;
        }
        
        switch ( struct_params.toy_name )
        {
            case #"hash_1f30833efcc73833":
                if ( !level utility::flag( "shoes_collected" ) && distancesquared( self.origin, struct_params.origin ) <= 250000 && !params.eattacker isonground() )
                {
                    utility::function_24215250530eaebc( self getcentroid(), struct_params.origin, level._effect[ #"toy_trail" ], undefined, struct_params.soulsfx );
                    level.var_4803875fb29f8031++;
                    
                    if ( level.var_4803875fb29f8031 >= level.var_8d5ac9d9dfc16679 )
                    {
                        struct_params.toy setscriptablepartstate( "material", "base" );
                        interact = zm_quest::function_91f9590e98d57ff6( struct_params.origin, &toy_pickedup, &hidden_hint, "small" );
                        interact.toy = struct_params.toy;
                        level utility::flag_set( "shoes_collected" );
                    }
                }
                
                break;
            case #"hash_3495e6d7e7c8647d":
                if ( !level utility::flag( "wheels_collected" ) && distancesquared( self.origin, struct_params.origin ) <= 250000 && params.eattacker utility::ent_flag( "is_phd_flopping" ) )
                {
                    utility::function_24215250530eaebc( self getcentroid(), struct_params.origin, level._effect[ #"toy_trail" ], undefined, struct_params.soulsfx );
                    level.var_54542f671d87535f++;
                    
                    if ( level.var_54542f671d87535f >= level.var_8d5ac9d9dfc16679 )
                    {
                        struct_params.toy setscriptablepartstate( "material", "base" );
                        interact = zm_quest::function_91f9590e98d57ff6( struct_params.origin, &toy_pickedup, &hidden_hint, "small" );
                        interact.toy = struct_params.toy;
                        level utility::flag_set( "wheels_collected" );
                    }
                }
                
                break;
            case #"hash_c8b71c599e9aeecf":
                if ( !level utility::flag( "laces_collected" ) && distancesquared( self.origin, struct_params.origin ) <= 250000 && params.eattacker utility::ent_flag( "frenzied_guard_active" ) )
                {
                    utility::function_24215250530eaebc( self getcentroid(), struct_params.origin, level._effect[ #"toy_trail" ], undefined, struct_params.soulsfx );
                    level.var_16bd1b19f2126055++;
                    
                    if ( level.var_16bd1b19f2126055 >= level.var_8d5ac9d9dfc16679 )
                    {
                        struct_params.toy setscriptablepartstate( "material", "base" );
                        interact = zm_quest::function_91f9590e98d57ff6( struct_params.origin, &toy_pickedup, &hidden_hint, "small" );
                        interact.toy = struct_params.toy;
                        level utility::flag_set( "laces_collected" );
                    }
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x789c7447, Offset: 0x371c
// Size: 0xb0
function function_3e0da5c55c92f07b( number )
{
    next_pinata = number + 1;
    
    foreach ( pinata_instance in level.var_4652a7ab324705b7 )
    {
        if ( pinata_instance.number == next_pinata )
        {
            pinata_instance setscriptablepartstate( "base", "pristine" );
            break;
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0x50aae136, Offset: 0x37d4
// Size: 0x36
function hidden_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x5046bb5d, Offset: 0x3813
// Size: 0xc2
function toy_pickedup( player )
{
    self freescriptable();
    
    if ( isdefined( self.toy ) )
    {
        self.toy scriptableclearparententity();
        self.toy.parent delete();
        self.toy freescriptable();
    }
    
    level.var_5f51a72b3cef4a88++;
    
    if ( level.var_5f51a72b3cef4a88 >= 3 )
    {
        spawn_box_interact();
        level thread function_21bb257fb63b59ee();
        
        if ( !level callback::exists( "on_zombie_ai_killed", &function_d7541e3069b36c3c ) )
        {
            level callback::remove( "on_zombie_ai_killed", &function_d7541e3069b36c3c );
        }
        
        wait 3;
        level thread overlord::playconversation( hashcat( #"roller_alt", randomintrange( 1, 4 ) ) );
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x46f808a8, Offset: 0x38dd
// Size: 0x1c
function function_21bb257fb63b59ee()
{
    level utility::flag_wait( "wanna_wingo_eh" );
    level utility::flag_set( "rh_sees_complete" );
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x2f79768f, Offset: 0x3901
// Size: 0x60
function spawn_box_interact()
{
    box_interact = interaction::register_interact( level.var_9db4d679c2330f54.origin + ( 0, 0, 25 ), 120, &box_interact_func, &box_interact_hint );
    box_interact.pos = level.var_9db4d679c2330f54.origin;
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x382067d6, Offset: 0x3969
// Size: 0x50
function box_interact_func( player )
{
    level.var_9db4d679c2330f54 thread zm_rabbithole::toybox_give_reward( "ee_reveal::zmb_roller_skates_female_02_rh", ( 0, 20, 0 ) );
    level callback::add( "zm_exfil_success", &function_cf25da101db108b3 );
    self delete();
    level thread function_af7c0169a8e958dd( player );
}

// Namespace zm_sat_scarab_rh
// Params 2
// Checksum 0xfa881d29, Offset: 0x39c1
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x2302177f, Offset: 0x3a00
// Size: 0x3f
function function_af7c0169a8e958dd( player )
{
    level endon( #"game_over" );
    level waittill( #"rh_to_pic" );
    wait 2;
    level thread overlord::playconversation( "scarab_toy" );
    wait 20;
    zm_rabbithole::function_1c6c02f0af873754();
}

// Namespace zm_sat_scarab_rh
// Params 1
// Checksum 0x3663a6f6, Offset: 0x3a47
// Size: 0xd7
function function_cf25da101db108b3( params )
{
    if ( utility::flag( "rh_to_pic" ) )
    {
        iprintlnbold( "Player extracted with the toy, grant reward!" );
        event_str = zm_rabbithole::function_85eaee7552aadd2e();
        
        foreach ( player in params.a_exfil_players )
        {
            if ( player.var_e8b776e9698cb857 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
            }
        }
    }
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x64a1cd1c, Offset: 0x3b26
// Size: 0x52
function function_e09b04e0d437487()
{
    switch ( level.players.size )
    {
        case 1:
            return 25;
        case 2:
            return 30;
        case 3:
            return 35;
        case 4:
            return 40;
    }
    
    return 25;
}

// Namespace zm_sat_scarab_rh
// Params 0
// Checksum 0x5b411e79, Offset: 0x3b81
// Size: 0x4c
function get_timer_required()
{
    switch ( level.players.size )
    {
        case 1:
        case 2:
            return 121;
        case 3:
        case 4:
            return 91;
    }
    
    return 121;
}

/#

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0x915ee4a8, Offset: 0x3bd6
    // Size: 0x86, Type: dev
    function init_rh_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x35>", &function_d13536e949ac2748 );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x5d>", &debug_chest );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x78>", &debug_toy );
        devgui::add_devgui_func( "<dev string:x87>", "<dev string:x87>", &function_fade3446ab0c044b );
        devgui::add_devgui_func( "<dev string:x91>", "<dev string:x91>", &debug_teleporter );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0x7183ac19, Offset: 0x3c64
    // Size: 0x12, Type: dev
    function function_d13536e949ac2748()
    {
        level utility::flag_set( "<dev string:x9c>" );
    }

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0x374cf66e, Offset: 0x3c7e
    // Size: 0xee, Type: dev
    function debug_chest()
    {
        level.var_9db4d679c2330f54 = zm_rabbithole::spawn_toybox( "<dev string:xab>" );
        level.var_5b515ea304ec3599 = spawn( "<dev string:xb3>", utility::getstruct( "<dev string:xab>", "<dev string:xc0>" ).origin );
        level.var_5b515ea304ec3599.angles = utility::getstruct( "<dev string:xab>", "<dev string:xc0>" ).angles;
        level.var_5b515ea304ec3599 setmodel( "<dev string:xcb>" );
        level.var_5b515ea304ec3599 utility::function_7c10ea82c1e305b8( "<dev string:xf1>", "<dev string:xf6>" );
        level.var_5b515ea304ec3599 utility::function_7c10ea82c1e305b8( "<dev string:x101>", "<dev string:x104>" );
        interact = zm_quest::function_91f9590e98d57ff6( level.var_9db4d679c2330f54.origin, &box_open, &hidden_hint, "<dev string:x108>" );
    }

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0xcc49e824, Offset: 0x3d74
    // Size: 0x4a, Type: dev
    function debug_toy()
    {
        level.var_9db4d679c2330f54 = zm_rabbithole::spawn_toybox( "<dev string:x10e>" );
        level.var_9db4d679c2330f54 utility::function_7c10ea82c1e305b8( "<dev string:x117>", "<dev string:x120>" );
        level.var_9db4d679c2330f54 thread zm_rabbithole::toybox_open();
        spawn_box_interact();
    }

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0xa98751e1, Offset: 0x3dc6
    // Size: 0x43, Type: dev
    function function_fade3446ab0c044b()
    {
        var_cba7166ff7bf9646 = utility::getstruct( "<dev string:x10e>", "<dev string:x12a>" );
        utility::spawn_model( "<dev string:x13c>", var_cba7166ff7bf9646.origin, var_cba7166ff7bf9646.angles );
    }

    // Namespace zm_sat_scarab_rh
    // Params 0
    // Checksum 0x1b1a38a0, Offset: 0x3e11
    // Size: 0x19, Type: dev
    function debug_teleporter()
    {
        function_21bb257fb63b59ee();
        level utility::flag_set( "<dev string:x166>" );
    }

#/
