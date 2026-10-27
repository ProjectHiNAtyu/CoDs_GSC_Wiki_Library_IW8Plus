// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rh.gsc  (hash_1d949d4330c2d1fe.gscc) (size: 35289 Bytes / 0x89d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78133d63 (2014526819)
// size ...... 35289 (0x89d9)
// includes .. 14  (offset: 0x7d05)
// strings ... 141 (offset: 0x7d75)
// dev strs .. 42  (offset: 0x8769)
// exports ... 71  (offset: 0x58c5)
// cseg ...... 0x8f5 + 0x4fd0 (0x58c5)
// imports ... 177 (offset: 0x63dd)
// animtree1 . 0   (offset: 0x89d9)
// animtree2 . 0   (offset: 0x89d9)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_ruby_rh;

// Namespace zm_sat_ruby_rh
// Params 0, eflags: 0x5
// Checksum 0x19d236a, Offset: 0x913
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ruby_rh", #"zm_quest", undefined, &postmain_init );
}

// Namespace zm_sat_ruby_rh
// Params 0, eflags: 0x4
// Checksum 0xa6e8cad0, Offset: 0x93c
// Size: 0x1ca
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
    level utility::flag_wait( "super_ee_save_check" );
    level utility::flag_wait( "scriptables_ready" );
    
    if ( level.var_e8b776e9698cb857 )
    {
        level utility::flag_set( "rh_to_pic" );
        return;
    }
    
    level._effect[ "ufo_laser_spawn" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_ufo_thruster" );
    level._effect[ "ufo_beam" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_ufo_abduction_beam" );
    level._effect[ "ufo_signal" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_ufo_blinking_light_flash" );
    level._effect[ "ufo_reward_code" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_ufo_glowing_orb" );
    level._effect[ "disc_light" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_disc_light_flash" );
    level._effect[ "ufo_reward_blast" ] = loadfxasset( "vfx_sat_levels_zm_ruby_super_ee_ufo_abduction_beam_explo" );
    utility::add_fx( "spawn_smoke", "vfx_sat_mp_ob_gem_cradle_tornado_rot_1" );
    level thread spawn_box();
    level thread function_22b340f91a23a8cb();
    level thread function_f6c4f8d59c457440();
    level thread function_3fddce0b3fb15830();
    level thread function_41c78553b3ccc8e6();
    level callback::add( "zm_exfil_success", &on_exfil_success );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"rh_ruby_mq_complete", &function_a0acf366c827d693 );
    
    /#
        level thread init_ruby_rh_debug();
    #/
}

/#

    // Namespace zm_sat_ruby_rh
    // Params 0, eflags: 0x4
    // Checksum 0x4094e3f6, Offset: 0xb0e
    // Size: 0x5, Type: dev
    function private function_3b3939c23f957c26()
    {
        
    }

#/

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0xd1d2e79, Offset: 0xb1b
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

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xe48f0e88, Offset: 0xb5c
// Size: 0x1ba
function spawn_box()
{
    level.rh_box = zm_rabbithole::spawn_toybox( "deadbeat_p1" );
    
    if ( isdefined( level.rh_box ) )
    {
        level.rh_box thread function_ba5fc1fa4c9ee130();
        a_targets = [ [ "deadbeat_s1", "deadbeat_s2", "deadbeat_s3", "deadbeat_p2" ], [ "deadbeat_s4", "deadbeat_s5", "deadbeat_p3" ] ];
        var_bc700251006d54ae = [ "t1", "t2" ];
        i = 0;
        
        while ( true )
        {
            trigger = getent( var_bc700251006d54ae[ i ], #targetname );
            
            if ( isdefined( trigger ) )
            {
                trigger waittill( #"damage", idamage, eattacker, vhitdir, var_8bc0ee7f93665fd1, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
                
                if ( isplayer( eattacker ) && zombie_damage::is_explosive_damage( smeansofdeath ) )
                {
                    if ( i == 0 )
                    {
                        level thread overlord::playconversation( hashcat( #"hash_204c89e744fa1961", randomintrange( 1, 4 ) ) );
                    }
                    
                    level.rh_box function_5ff625129cb1e1fe( a_targets[ i ] );
                    i++;
                    
                    if ( i == 2 )
                    {
                        level callback::add( "blackhole_bomb_start", &on_blackhole_bomb );
                        break;
                    }
                }
            }
            
            waitframe();
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0, eflags: 0x4
// Checksum 0x61e774ea, Offset: 0xd1e
// Size: 0x88
function private function_ba5fc1fa4c9ee130()
{
    self endon( #"death" );
    self endon( #"final" );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            spin_change = ( randomfloatrange( 10, 35 ), randomfloatrange( 20, 70 ), randomfloatrange( 10, 35 ) );
            rotate_time = randomfloatrange( 1, 2 );
            self rotateto( self.angles + spin_change, rotate_time, 0, 0 );
            self waittill( #"rotatedone" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0xdcab5d82, Offset: 0xdae
// Size: 0xd9
function private function_5ff625129cb1e1fe( a_targets )
{
    self endon( #"death" );
    
    foreach ( target_name in a_targets )
    {
        var_ed92d3edd3eded9 = utility::getstruct( target_name, "targetname" );
        
        if ( isdefined( var_ed92d3edd3eded9 ) && isdefined( self ) )
        {
            self moveto( var_ed92d3edd3eded9.origin, float( var_ed92d3edd3eded9.script_noteworthy ), 1, 0.75 );
            self waittill( #"movedone" );
            waitframe();
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0x2e5f00e, Offset: 0xe8f
// Size: 0x226
function private on_blackhole_bomb( params )
{
    trigger = getent( "cas", "targetname" );
    
    if ( params.grenade istouching( trigger ) )
    {
        level callback::remove( "blackhole_bomb_start", &on_blackhole_bomb );
        target_struct_1 = utility::getstruct( "deadbeat_s6", "targetname" );
        target_struct_final = utility::getstruct( "deadbeat_final", "targetname" );
        level.rh_box moveto( target_struct_1.origin, 0.8, 0.3 );
        level.rh_box waittill( #"movedone" );
        level.rh_box thread rotate_to_final_angles( target_struct_final );
        level.rh_box moveto( target_struct_final.origin, 1.4, 0.5 );
        level.rh_box waittill( #"movedone" );
        level.rh_box utility::function_7c10ea82c1e305b8( "ruby_fx_dust", "on" );
        a_players = getplayersinradius( target_struct_final.origin, 100 );
        
        foreach ( player in a_players )
        {
            v_knockback = vectornormalize( player.origin - target_struct_final.origin );
            player knockback( v_knockback, 200, 1 );
        }
        
        level thread zm_rabbithole::function_b422525417f4cda2();
        
        if ( !level callback::exists( #"on_ai_killed", &function_7f85de86774a6c03 ) )
        {
            level callback::add( #"on_ai_killed", &function_7f85de86774a6c03 );
        }
        
        wait 0.8;
        level.rh_box utility::function_7c10ea82c1e305b8( "ruby_fx", "on" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0x7f71fc82, Offset: 0x10bd
// Size: 0x49
function rotate_to_final_angles( struct )
{
    self endon( #"death" );
    
    if ( isdefined( self ) )
    {
        self notify( #"final" );
        self rotateto( struct.angles, 1 );
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0x5ddcc71f, Offset: 0x110e
// Size: 0x266
function function_7f85de86774a6c03( params )
{
    level endon( #"game_ended" );
    
    if ( params.victim.subclass == "zombie_galileo" && params.sweapon.basename == "sat_pluto_zm_ee_ruby_turret" )
    {
        wait 2;
        offset = ( 0, 0, 15 );
        mover = utility::spawn_model( "tag_origin", params.victim.origin + offset, params.victim.angles );
        var_251c8521dea3bc6c = spawnscriptable( %"hash_21b096f21adff11a", params.victim.origin + offset, params.victim.angles );
        var_251c8521dea3bc6c utility::function_7c10ea82c1e305b8( "vfx", "on" );
        var_251c8521dea3bc6c scriptablesetparententity( mover );
        distance = distance2dsquared( params.victim.origin, level.rh_box.origin );
        speed = 125;
        travel_time = sqrt( distance ) / speed;
        mover moveto( level.rh_box.origin + ( 0, 0, 5 ), travel_time );
        mover waittill( #"movedone" );
        var_251c8521dea3bc6c utility::function_7c10ea82c1e305b8( "vfx", "off" );
        waitframe();
        mover delete();
        playworldsound( level.rh_box.origin + ( 0, 0, 20 ), #"hash_f690b967d7c16a2b" );
        level.rh_box utility::function_7c10ea82c1e305b8( "ruby_fx", "off" );
        level utility::flag_set( "rh_sauce_arambam" );
        level.var_4a75d6f667fe29b1 = 1;
        level.var_d10ffa3495170564 = 0;
        
        if ( level callback::exists( #"on_ai_killed", &function_7f85de86774a6c03 ) )
        {
            level callback::remove( #"on_ai_killed", &function_7f85de86774a6c03 );
        }
        
        wait 2;
        level.rh_box zm_rabbithole::toybox_open();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x8d17badf, Offset: 0x137c
// Size: 0x1aa
function function_22b340f91a23a8cb()
{
    level.var_bf32046fb0aedcb8 = [];
    var_e9cfb17640f39d0e = utility::getstructarray( "m_vfx", "targetname" );
    
    if ( !isdefined( var_e9cfb17640f39d0e ) || var_e9cfb17640f39d0e.size <= 0 )
    {
        return;
    }
    
    activateworldevent( "we_vfx_statue_glow_l" );
    activateworldevent( "we_vfx_statue_glow_s" );
    activateworldevent( "we_vfx_statue_glow_t" );
    activateworldevent( "we_vfx_statue_glow_f" );
    
    foreach ( exhibit_struct in var_e9cfb17640f39d0e )
    {
        if ( !isdefined( exhibit_struct ) || !isdefined( exhibit_struct.script_noteworthy ) )
        {
            continue;
        }
        
        if ( exhibit_struct.script_noteworthy == "t" || exhibit_struct.script_noteworthy == "f" || exhibit_struct.script_noteworthy == "s" || exhibit_struct.script_noteworthy == "l" )
        {
            exhibit_fx = spawnscriptable( %"hash_5fb3167c6b233adf", exhibit_struct.origin, exhibit_struct.angles );
            exhibit_fx.name = exhibit_struct.script_noteworthy;
            
            if ( isdefined( exhibit_fx ) )
            {
                exhibit_fx utility::function_7c10ea82c1e305b8( "vfx", "off" );
                level.var_bf32046fb0aedcb8[ level.var_bf32046fb0aedcb8.size ] = exhibit_fx;
            }
        }
    }
}

/#

    // Namespace zm_sat_ruby_rh
    // Params 0, eflags: 0x4
    // Checksum 0xe16ab5ef, Offset: 0x152e
    // Size: 0x5, Type: dev
    function private function_7e189091e8d09a48()
    {
        
    }

#/

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x43c1b528, Offset: 0x153b
// Size: 0x14e
function function_f6c4f8d59c457440()
{
    level endon( #"game_ended" );
    level endon( #"hash_ba0c4f7a3da27356" );
    level utility::flag_wait( "rh_sauce_arambam" );
    level thread function_74ae017309647149();
    var_bd5c3009de5e40bd = utility::getstruct( "rh_kite_1", "targetname" );
    var_bd5c2d09de5e3a24 = utility::getstruct( "rh_kite_2", "targetname" );
    
    while ( true )
    {
        if ( isdefined( var_bd5c3009de5e40bd ) && isdefined( var_bd5c2d09de5e3a24 ) && level.var_4a75d6f667fe29b1 == 1 )
        {
            level.var_294c40f760d512b5 = utility::spawn_model( "tag_origin", var_bd5c3009de5e40bd.origin, var_bd5c3009de5e40bd.angles );
            ufo_fx = spawnscriptable( %"hash_5a8fe789944df5e", var_bd5c3009de5e40bd.origin, var_bd5c3009de5e40bd.angles );
            ufo_fx utility::function_7c10ea82c1e305b8( "vfx", "on" );
            ufo_fx scriptablesetparententity( level.var_294c40f760d512b5 );
            level.var_294c40f760d512b5 moveto( var_bd5c2d09de5e3a24.origin, 6 );
            level.var_294c40f760d512b5 waittill( #"movedone" );
            ufo_fx freescriptable();
            level.var_294c40f760d512b5 delete();
        }
        
        wait 7;
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x8efdd68b, Offset: 0x1691
// Size: 0xb1
function function_74ae017309647149()
{
    level endon( #"game_ended" );
    level endon( #"hash_fad5f9cae006630c" );
    
    while ( true )
    {
        var_b39211a02e6399a9 = function_50f40ccac88f47f8( level.var_294c40f760d512b5 );
        
        if ( isdefined( level.ruby_telescope.user ) && isdefined( level.var_294c40f760d512b5 ) && level.var_4a75d6f667fe29b1 == 1 && var_b39211a02e6399a9 == 1 )
        {
            if ( !level utility::flag( "rh_vo_sight" ) )
            {
                level utility::flag_set( "rh_vo_sight" );
                wait 1.5;
                level overlord::playconversation( #"hash_b5053083b76c51e8" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x53363598, Offset: 0x174a
// Size: 0xa1
function function_e5640ed5e4eb6f06()
{
    level endon( #"game_ended" );
    level endon( #"hash_fad5f9cae006630c" );
    
    while ( true )
    {
        var_b39211a02e6399a9 = function_50f40ccac88f47f8( level.var_7c354b5a3d713918 );
        
        if ( isdefined( level.ruby_telescope.user ) && isdefined( level.var_7c354b5a3d713918 ) && var_b39211a02e6399a9 == 1 )
        {
            if ( !level utility::flag( "rh_vo_sight" ) )
            {
                level utility::flag_set( "rh_vo_sight" );
                wait 1.75;
                level overlord::playconversation( #"hash_b5053083b76c51e8" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0xd2d80aaa, Offset: 0x17f3
// Size: 0xac, Type: bool
function function_50f40ccac88f47f8( target )
{
    level endon( #"game_ended" );
    level endon( #"hash_fad5f9cae006630c" );
    
    if ( isdefined( level.ruby_telescope.user ) && isdefined( target ) && isdefined( level.ruby_telescope.mdl_viewpoint ) )
    {
        if ( utility::within_fov( level.ruby_telescope.mdl_viewpoint.origin, level.ruby_telescope.user getplayerangles(), target.origin, cos( 6 ) ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xe757881c, Offset: 0x18a8
// Size: 0x179
function function_3fddce0b3fb15830()
{
    level endon( #"game_ended" );
    level endon( #"hash_e796c15fd2e1ad6" );
    level utility::flag_wait( "rh_sauce_arambam" );
    level thread function_e5640ed5e4eb6f06();
    
    while ( true )
    {
        var_bd5c3009de5e40bd = utility::getstruct( "rh_kite_1", "targetname" );
        var_bd5c2d09de5e3a24 = utility::getstruct( "rh_kite_2", "targetname" );
        
        if ( isdefined( var_bd5c3009de5e40bd ) && isdefined( var_bd5c2d09de5e3a24 ) && level.var_d10ffa3495170564 == 1 )
        {
            level notify( #"hash_ba0c4f7a3da27356" );
            mdl_ufo = spawn( "script_model", var_bd5c3009de5e40bd.origin );
            mdl_ufo.angles = var_bd5c3009de5e40bd.angles;
            mdl_ufo setscale( 0.1 );
            mdl_ufo setmodel( "c_sat_zmb_galileo_drone_mq_prototype" );
            level.var_7c354b5a3d713918 = mdl_ufo;
            zm_sat_ruby_telescope::function_b095db21aed570fe( mdl_ufo, 0, var_bd5c3009de5e40bd.origin );
            level callback::add( "telescope_target_acquired", &function_5894d81266439939, { #mdl_ufo:mdl_ufo } );
            mdl_ufo thread function_9e444d9147620492();
            mdl_ufo moveto( var_bd5c2d09de5e3a24.origin, 16, 1, 0 );
            mdl_ufo waittill( #"movedone" );
            waitframe();
            
            if ( isdefined( mdl_ufo ) )
            {
                zm_sat_ruby_telescope::function_b28785f5286548e3( mdl_ufo );
                waitframe();
                mdl_ufo delete();
                level.var_7c354b5a3d713918 = undefined;
                mdl_ufo = undefined;
            }
        }
        
        wait 2;
    }
}

// Namespace zm_sat_ruby_rh
// Params 0, eflags: 0x4
// Checksum 0x273db144, Offset: 0x1a29
// Size: 0x48
function private function_9e444d9147620492()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self rotateto( self.angles + ( -1, 0, 0 ), 0.1, 0, 0 );
        self waittill( #"rotatedone" );
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 2, eflags: 0x4
// Checksum 0xe98be5b3, Offset: 0x1a79
// Size: 0x1cf
function private function_5894d81266439939( params, info )
{
    if ( params.ent != info.mdl_ufo )
    {
        return;
    }
    
    if ( level utility::flag( "look_at_sauce" ) )
    {
        return;
    }
    
    level utility::flag_set( "look_at_sauce" );
    level notify( #"hash_e796c15fd2e1ad6" );
    info.mdl_ufo moveto( info.mdl_ufo.origin + ( 0, 0, 0 ), 0.1 );
    function_279031f3ca0ba373( info.mdl_ufo, 0, 0 );
    wait 0.8;
    player = level.ruby_telescope.user;
    
    if ( isdefined( player ) && isalive( player ) )
    {
        player thread function_c473ef2ca3032767( 0.5, 1 );
    }
    
    level notify( #"hash_fad5f9cae006630c" );
    
    if ( isalive( player ) && level.ruby_telescope.mdl_viewpoint )
    {
        player notifyonplayercommandremove( "telescope_exit", "+stance" );
        player notifyonplayercommandremove( "telescope_exit", "+prone" );
        player notifyonplayercommandremove( "telescope_exit", "+movedown" );
        level.ruby_telescope.telescope_interact thread zm_sat_ruby_telescope::function_72b79a760dd653d6( player );
    }
    
    if ( info.mdl_ufo )
    {
        zm_sat_ruby_telescope::function_b28785f5286548e3( info.mdl_ufo );
    }
    
    level thread function_649298d98daf553a();
    level thread overlord::playconversation( #"hash_a4e91518616c45ac" );
    wait 0.9;
    
    if ( info.mdl_ufo )
    {
        info.mdl_ufo delete();
        level.var_7c354b5a3d713918 = undefined;
    }
}

// Namespace zm_sat_ruby_rh
// Params 3, eflags: 0x4
// Checksum 0x8a668e37, Offset: 0x1c50
// Size: 0x4a
function private function_c473ef2ca3032767( fade_out_time, fade_in_time, var_280fc6a5f41ac78 = "white" )
{
    self playsoundtoplayer( "evt_mq_white_out", self );
    hud_util::fade_out( fade_out_time, var_280fc6a5f41ac78 );
    hud_util::fade_in( fade_in_time, var_280fc6a5f41ac78 );
}

// Namespace zm_sat_ruby_rh
// Params 3
// Checksum 0x3f774f01, Offset: 0x1ca2
// Size: 0xbf
function function_279031f3ca0ba373( ufo, var_911c975943879adb, var_66c46b586799c823 )
{
    level endon( #"game_ended" );
    self endon( #"hash_fd5c21e94218cc58" );
    
    while ( true )
    {
        if ( var_66c46b586799c823 == 1 )
        {
            fx = utility::getfx( "disc_light" );
        }
        else
        {
            fx = utility::getfx( "ufo_signal" );
        }
        
        for ( i = 0; i < 3 ; i++ )
        {
            playfxontag( fx, ufo, "tag_origin" );
            wait 0.75;
            killfxontag( fx, ufo, "tag_origin" );
            
            if ( i < 2 )
            {
                wait 0.75;
            }
        }
        
        if ( var_911c975943879adb == 0 )
        {
            return;
        }
        
        wait 2;
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xb529e964, Offset: 0x1d69
// Size: 0x11f
function function_649298d98daf553a()
{
    var_8fb44f170bdd1d75 = utility::getstruct( "metro_fx_1", "targetname" );
    var_8fb44c170bdd16dc = utility::getstruct( "metro_fx_2", "targetname" );
    level.var_a05fcd225aa6717f = utility::spawn_model( "tag_origin", var_8fb44f170bdd1d75.origin, var_8fb44f170bdd1d75.angles );
    level.var_a05fce225aa673b2 = utility::spawn_model( "tag_origin", var_8fb44c170bdd16dc.origin, var_8fb44c170bdd16dc.angles );
    trigger_1 = getent( "eel_1", "targetname" );
    trigger_2 = getent( "eel_2", "targetname" );
    trigger_1 thread function_279031f3ca0ba373( level.var_a05fcd225aa6717f, 1, 1 );
    trigger_2 thread function_279031f3ca0ba373( level.var_a05fce225aa673b2, 1, 1 );
    level.var_2e6672537f950f0b = 0;
    level callback::add( #"shock_stick_landed", &function_d1c8ecf5a70b0015, { #trigger_2:trigger_2, #trigger_1:trigger_1 } );
}

// Namespace zm_sat_ruby_rh
// Params 2
// Checksum 0xfff4ffb6, Offset: 0x1e90
// Size: 0x17b
function function_d1c8ecf5a70b0015( params, info )
{
    if ( level utility::flag( "ruby_mq_all_5_melody_pillars_on" ) )
    {
        trigger_1 = info.trigger_1;
        trigger_2 = info.trigger_2;
        
        if ( params.var_a4af6d34cd071836 istouching( trigger_1 ) && !level utility::flag( "rh_stick_hit_detected_t1" ) )
        {
            level utility::flag_set( "rh_stick_hit_detected_t1" );
            trigger_1 notify( #"hash_fd5c21e94218cc58" );
            fx = utility::getfx( "ufo_signal" );
            killfxontag( fx, level.var_a05fcd225aa6717f, "tag_origin" );
            level thread function_64d9a6aea15afc6b();
            level.var_2e6672537f950f0b++;
        }
        else if ( params.var_a4af6d34cd071836 istouching( trigger_2 ) && !level utility::flag( "rh_stick_hit_detected_t2" ) )
        {
            level utility::flag_set( "rh_stick_hit_detected_t2" );
            trigger_2 notify( #"hash_fd5c21e94218cc58" );
            fx = utility::getfx( "ufo_signal" );
            killfxontag( fx, level.var_a05fce225aa673b2, "tag_origin" );
            level thread function_64d9a6aea15afc6b();
            level.var_2e6672537f950f0b++;
        }
        
        if ( level.var_2e6672537f950f0b == 2 )
        {
            level callback::remove( #"shock_stick_landed", &function_d1c8ecf5a70b0015 );
            level thread function_1403dddb0ef63453();
            level utility::flag_set( "rh_sauce_kandip" );
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x9d907d99, Offset: 0x2013
// Size: 0x25
function function_1403dddb0ef63453()
{
    level endon( #"game_ended" );
    wait 3;
    level thread overlord::playconversation( #"hash_2650bc717b30b0c9" );
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x2cc3149d, Offset: 0x2040
// Size: 0x25d
function function_64d9a6aea15afc6b()
{
    var_dc0ffb582ecb84cf = [ "step4_pillar_1", "step4_pillar_2", "step4_pillar_3", "step4_pillar_4", "step4_pillar_5" ];
    var_e791177c642a71bb = [];
    
    for ( i = 0; i < var_dc0ffb582ecb84cf.size ; i++ )
    {
        s_pillar = utility::getstruct( var_dc0ffb582ecb84cf[ i ], "targetname" );
        var_e791177c642a71bb[ i ] = spawnscriptable( %"sat_zm_ruby_mars_pillar_fx", s_pillar.origin );
    }
    
    if ( isdefined( var_e791177c642a71bb ) )
    {
        var_e791177c642a71bb[ 0 ] utility::function_7c10ea82c1e305b8( "trigger_1", "on" );
        wait 0.1;
        var_e791177c642a71bb[ 1 ] utility::function_7c10ea82c1e305b8( "trigger_2", "on" );
        wait 0.1;
        var_e791177c642a71bb[ 2 ] utility::function_7c10ea82c1e305b8( "trigger_3", "on" );
        wait 0.1;
        var_e791177c642a71bb[ 3 ] utility::function_7c10ea82c1e305b8( "trigger_4", "on" );
        wait 0.1;
        var_e791177c642a71bb[ 4 ] utility::function_7c10ea82c1e305b8( "trigger_5", "on" );
    }
    
    wait 3;
    
    if ( isdefined( var_e791177c642a71bb ) )
    {
        foreach ( trigger in var_e791177c642a71bb )
        {
            if ( isdefined( trigger ) )
            {
                trigger utility::function_7c10ea82c1e305b8( "trigger_1", "off" );
                trigger utility::function_7c10ea82c1e305b8( "trigger_2", "off" );
                trigger utility::function_7c10ea82c1e305b8( "trigger_3", "off" );
                trigger utility::function_7c10ea82c1e305b8( "trigger_4", "off" );
                trigger utility::function_7c10ea82c1e305b8( "trigger_5", "off" );
            }
        }
    }
    
    foreach ( trigger in var_e791177c642a71bb )
    {
        if ( isdefined( trigger ) )
        {
            trigger freescriptable();
        }
    }
}

/#

    // Namespace zm_sat_ruby_rh
    // Params 0, eflags: 0x4
    // Checksum 0xe0f47b75, Offset: 0x22a5
    // Size: 0x5, Type: dev
    function private function_2b2f7b4a77e2736c()
    {
        
    }

#/

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x1a133f1a, Offset: 0x22b2
// Size: 0x1fb
function function_41c78553b3ccc8e6()
{
    level endon( #"game_ended" );
    level endon( #"hash_83d54c1b3ae49531" );
    level utility::flag_wait( "rh_sauce_kandip" );
    level.var_89ccb7533940f0aa = { #move_four:0, #move_three:0, #move_two:0, #move_one:0, #count:0 };
    level.var_b6fb1789eda91bc9 = [];
    level.var_680bbc76d58fbc18 = [];
    level.var_3efed015736ad2f6 = 0;
    
    if ( !level callback::exists( #"hash_b61059e638cec9a3", &assign_light_ent ) )
    {
        level callback::add( #"hash_b61059e638cec9a3", &assign_light_ent );
    }
    
    level thread function_842128ea425f960f();
    var_b6f870b1487bb0ec = utility::getstruct( "angel_spawn", "targetname" );
    
    if ( isdefined( var_b6f870b1487bb0ec ) )
    {
        var_97b28ab23fae8af4 = spawn( "script_model", var_b6f870b1487bb0ec.origin );
        var_97b28ab23fae8af4.angles = var_b6f870b1487bb0ec.angles;
        var_97b28ab23fae8af4 setmodel( "mgl_ufo_large_zm" );
        var_97b28ab23fae8af4 thread spin_ufo();
        var_8591591d876774f7 = utility::getstruct( "angel_takeoff_1", "targetname" );
        
        if ( isdefined( var_8591591d876774f7 ) )
        {
            var_97b28ab23fae8af4 moveto( var_8591591d876774f7.origin, 1 );
            var_97b28ab23fae8af4 waittill( #"movedone" );
        }
        
        var_97b28ab23fae8af4 playsoundonmovingent( #"hash_4d0857aba6363967" );
        var_97b28ab23fae8af4 playloopsound( #"hash_51ef13f4014fc424" );
        var_c9eef348ba2cbfa8 = utility::getstruct( "angel_1", "targetname" );
        
        if ( isdefined( var_c9eef348ba2cbfa8 ) )
        {
            var_97b28ab23fae8af4 moveto( var_c9eef348ba2cbfa8.origin, 7.5, 0.75, 0.75 );
            var_97b28ab23fae8af4 waittill( #"movedone" );
        }
        
        level.var_96dd96e5b7d318ef = var_97b28ab23fae8af4;
        level thread function_1ea777f8e175b5df();
        level thread function_49265605386984e2();
        level thread function_289f50c4898d1b2a();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xa0837eb0, Offset: 0x24b5
// Size: 0xb2
function function_49265605386984e2()
{
    fx = utility::getfx( "ufo_reward_code" );
    level.var_826d0f960e00f593 = utility::spawn_model( "tag_origin", level.var_96dd96e5b7d318ef.origin + ( 0, 0, -55 ), level.var_96dd96e5b7d318ef.angles );
    level.morse_code_sequence = function_3f7a5a3ca7219458( [ "S", "L", "F", "T" ] );
    level.var_39e3204ce1ee2dc8 = [];
    level thread function_9b5bb08338acd3e7( fx, level.morse_code_sequence );
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0x15955449, Offset: 0x256f
// Size: 0x59
function private function_3f7a5a3ca7219458( var_e5a2f1b3222012cf )
{
    shuffled = [];
    
    while ( var_e5a2f1b3222012cf.size > 0 )
    {
        idx = randomintrange( 0, var_e5a2f1b3222012cf.size - 1 );
        letter = var_e5a2f1b3222012cf[ idx ];
        shuffled[ shuffled.size ] = letter;
        var_e5a2f1b3222012cf = arrayremove( var_e5a2f1b3222012cf, letter );
    }
    
    return shuffled;
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0xca3baea0, Offset: 0x25d1
// Size: 0x5e
function private get_morse_pattern( letter )
{
    if ( letter == "S" )
    {
        return "...";
    }
    else if ( letter == "L" )
    {
        return ".-..";
    }
    else if ( letter == "F" )
    {
        return "..-.";
    }
    else if ( letter == "T" )
    {
        return "-";
    }
    
    return "";
}

// Namespace zm_sat_ruby_rh
// Params 2, eflags: 0x4
// Checksum 0x9c0adc22, Offset: 0x2638
// Size: 0xdf
function private function_9b5bb08338acd3e7( fx, a_sequence )
{
    level endon( #"game_ended" );
    level endon( #"hash_9b87f20237f8f218" );
    level endon( #"hash_83d54c1b3ae49531" );
    
    if ( !( isdefined( fx ) && isdefined( a_sequence ) && isdefined( level.var_826d0f960e00f593 ) ) )
    {
        return;
    }
    
    while ( true )
    {
        for ( i = 0; i < a_sequence.size ; i++ )
        {
            letter = a_sequence[ i ];
            pattern = get_morse_pattern( letter );
            function_b84b7ef990e0099e( fx, pattern );
            
            if ( i < a_sequence.size - 1 )
            {
                wait 4.25;
            }
        }
        
        stopfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
        wait 10;
        stopfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 2, eflags: 0x4
// Checksum 0x259bad7a, Offset: 0x271f
// Size: 0xf5
function private function_b84b7ef990e0099e( fx, pattern )
{
    if ( !( isdefined( fx ) && isdefined( pattern ) && isdefined( level.var_826d0f960e00f593 ) ) )
    {
        return;
    }
    
    for ( i = 0; i < pattern.size ; i++ )
    {
        var_825261bedb0065e6 = pattern[ i ];
        
        if ( var_825261bedb0065e6 == "." )
        {
            playfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
            wait 0.65;
            stopfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
        }
        else if ( var_825261bedb0065e6 == "-" )
        {
            playfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
            wait 3;
            stopfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
        }
        
        if ( i < pattern.size - 1 )
        {
            stopfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
            wait 1.5;
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0, eflags: 0x4
// Checksum 0x5781b230, Offset: 0x281c
// Size: 0x3b
function private spin_ufo()
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self rotateto( self.angles + ( 0, 5, 0 ), 0.1, 0, 0 );
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xca459fb, Offset: 0x285f
// Size: 0x69
function function_88038adedb83a28c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_c9eef648ba2cc641 = utility::getstruct( "angel_2", "targetname" );
    
    if ( isdefined( var_c9eef648ba2cc641 ) )
    {
        self moveto( var_c9eef648ba2cc641.origin, 3.5, 0.5, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xec11b0e5, Offset: 0x28d0
// Size: 0x69
function function_88038bdedb83a4bf()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_c9eef548ba2cc40e = utility::getstruct( "angel_8", "targetname" );
    
    if ( isdefined( var_c9eef548ba2cc40e ) )
    {
        self moveto( var_c9eef548ba2cc40e.origin, 2, 0.5, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x1626cc99, Offset: 0x2941
// Size: 0x137
function function_6af3e77142143766()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"stop_revolve" );
    level endon( #"hash_83d54c1b3ae49531" );
    s_mars_center_loc = utility::getstruct( "angel_center", "targetname" );
    var_f14918325569465d = s_mars_center_loc.origin + ( -6600, 500, 0 );
    
    if ( isdefined( var_f14918325569465d ) )
    {
        self moveto( var_f14918325569465d, 3, 0.25, 0.25 );
        self waittill( #"movedone" );
    }
    
    self.var_4d9eee75dfab990e = 0;
    self.v_up = anglestoup( s_mars_center_loc.angles );
    self.var_a155468e55c61326 = 0;
    
    while ( true )
    {
        self.var_a155468e55c61326 += 0.7;
        newoffset = rotatepointaroundvector( self.v_up, ( -6600, 500, 0 ), self.var_a155468e55c61326 );
        newposition = s_mars_center_loc.origin + newoffset;
        self moveto( newposition, 0.1 );
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x954fe45b, Offset: 0x2a80
// Size: 0x2df
function function_86736d4be11abbae()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_83d54c1b3ae49531" );
    self notify( #"stop_revolve" );
    var_c9eef548ba2cc40e = utility::getstruct( "angel_3", "targetname" );
    
    if ( isdefined( var_c9eef548ba2cc40e ) )
    {
        self moveto( var_c9eef548ba2cc40e.origin, 5, 1, 1 );
        self waittill( #"movedone" );
    }
    
    wait 1.8;
    var_73ba4a5d351f5560 = utility::getfx( "ufo_laser_spawn" );
    var_8572982e37f6c36 = utility::getfx( "ufo_beam" );
    waitframe();
    playworldsound( self.origin - ( 0, 0, 100 ), #"hash_5828baa197619874" );
    
    if ( !self.var_e06a5125d6e50f0f )
    {
        self.var_e06a5125d6e50f0f = utility::play_loopsound_in_space( #"hash_88d214fffdb904d4", self.origin - ( 0, 0, 100 ) );
    }
    
    playfxontag( var_73ba4a5d351f5560, self, "tag_origin" );
    waitframe();
    playfxontag( var_8572982e37f6c36, self, "tag_origin" );
    wait 0.85;
    
    if ( isdefined( level.var_b6fb1789eda91bc9 ) )
    {
        foreach ( mover in level.var_b6fb1789eda91bc9 )
        {
            mover function_ccb1904a437b9ebf( var_c9eef548ba2cc40e.origin, self );
        }
    }
    
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        fx = utility::getfx( "ufo_reward_blast" );
        playfxontag( fx, self, "tag_origin" );
    }
    
    foreach ( scriptable in level.var_680bbc76d58fbc18 )
    {
        level.var_680bbc76d58fbc18 = arrayremove( level.var_680bbc76d58fbc18, scriptable );
        scriptable freescriptable();
    }
    
    level function_dff8e580b6c0286c();
    
    if ( self.var_e06a5125d6e50f0f )
    {
        self.var_e06a5125d6e50f0f delete();
    }
    
    playworldsound( self.origin - ( 0, 0, 100 ), #"hash_8210e5fc4bf08b2d" );
    stopfxontag( var_73ba4a5d351f5560, self, "tag_origin" );
    stopfxontag( var_8572982e37f6c36, self, "tag_origin" );
    wait 1.3;
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xbda9f1d9, Offset: 0x2d67
// Size: 0x3cf
function function_880388dedb839e26()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_83d54c1b3ae49531" );
    self notify( #"stop_revolve" );
    var_c9eef548ba2cc40e = utility::getstruct( "angel_3", "targetname" );
    
    if ( isdefined( var_c9eef548ba2cc40e ) )
    {
        self moveto( var_c9eef548ba2cc40e.origin, 5, 1, 1 );
        self waittill( #"movedone" );
    }
    
    wait 2;
    playworldsound( self.origin - ( 0, 0, 100 ), #"hash_5828baa197619874" );
    
    if ( !self.var_e06a5125d6e50f0f )
    {
        self.var_e06a5125d6e50f0f = utility::play_loopsound_in_space( #"hash_88d214fffdb904d4", self.origin - ( 0, 0, 100 ) );
    }
    
    var_73ba4a5d351f5560 = utility::getfx( "ufo_laser_spawn" );
    var_8572982e37f6c36 = utility::getfx( "ufo_beam" );
    waitframe();
    playfxontag( var_73ba4a5d351f5560, self, "tag_origin" );
    waitframe();
    playfxontag( var_8572982e37f6c36, self, "tag_origin" );
    wait 0.85;
    
    if ( isdefined( level.var_b6fb1789eda91bc9 ) )
    {
        foreach ( mover in level.var_b6fb1789eda91bc9 )
        {
            mover function_ccb1904a437b9ebf( var_c9eef548ba2cc40e.origin );
        }
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        fx = utility::getfx( "ufo_reward_blast" );
        playfxontag( fx, self, "tag_origin" );
    }
    
    foreach ( scriptable in level.var_680bbc76d58fbc18 )
    {
        scriptable freescriptable();
    }
    
    mdl_alien = spawn( "script_model", var_c9eef548ba2cc40e.origin );
    mdl_alien setscale( 5 );
    mdl_alien setmodel( "sat_zm_alien_body_ruby" );
    var_bb062e45bde8f8ae = utility::getstruct( "ali", "targetname" );
    mdl_alien moveto( var_bb062e45bde8f8ae.origin, 5 );
    mdl_alien rotateto( var_bb062e45bde8f8ae.angles, 5 );
    mdl_alien waittill( #"movedone" );
    playworldsound( mdl_alien.origin + ( 0, 0, 15 ), #"hash_f3dc5e89d9d29de6" );
    mdl_alien.interact = interaction::register_interact( mdl_alien.origin + ( 0, 0, 25 ), 80, &pick_up_item, &function_6f54b3e0c81c720b );
    mdl_alien.interact.mdl_alien = mdl_alien;
    
    if ( self.var_e06a5125d6e50f0f )
    {
        self.var_e06a5125d6e50f0f delete();
    }
    
    playworldsound( self.origin - ( 0, 0, 100 ), #"hash_8210e5fc4bf08b2d" );
    stopfxontag( var_73ba4a5d351f5560, self, "tag_origin" );
    stopfxontag( var_8572982e37f6c36, self, "tag_origin" );
    wait 1.3;
    level thread overlord::playconversation( #"ruby_alien" );
    thread function_5e4e9cceb4aee54f();
}

// Namespace zm_sat_ruby_rh
// Params 2
// Checksum 0xfd8d0c6c, Offset: 0x313e
// Size: 0x151
function function_ccb1904a437b9ebf( origin, ufo )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_83d54c1b3ae49531" );
    
    if ( level.var_89ccb7533940f0aa.count == 1 )
    {
        level thread overlord::playconversation( hashcat( #"hash_af70c25335cac675", randomintrange( 1, 4 ) ) );
    }
    
    self moveto( origin + ( 0, 0, -200 ), 3 );
    self rotateto( self.angles + ( 0, 720, 0 ), 3 );
    self waittill( #"movedone" );
    
    foreach ( var_b3053b25c717315a in level.var_680bbc76d58fbc18 )
    {
        var_b3053b25c717315a utility::function_7c10ea82c1e305b8( "dissolve", "dissolve" );
    }
    
    wait 1;
    level notify( #"hash_e212f2ca269cdadc" );
    self delete();
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xb1b2d2c0, Offset: 0x3297
// Size: 0x102
function function_dff8e580b6c0286c()
{
    if ( !( isdefined( level.morse_code_sequence ) && isdefined( level.var_39e3204ce1ee2dc8 ) && isdefined( level.var_96dd96e5b7d318ef ) ) )
    {
        return;
    }
    
    idx = level.var_39e3204ce1ee2dc8.size - 1;
    
    if ( idx < 0 || idx >= level.morse_code_sequence.size )
    {
        return;
    }
    
    var_8d0a9a7366274401 = 1;
    
    for ( i = 0; i <= idx ; i++ )
    {
        if ( !isdefined( level.var_39e3204ce1ee2dc8[ i ] ) || !isdefined( level.morse_code_sequence[ i ] ) )
        {
            var_8d0a9a7366274401 = 0;
            break;
        }
        
        if ( level.var_39e3204ce1ee2dc8[ i ] != level.morse_code_sequence[ i ] )
        {
            var_8d0a9a7366274401 = 0;
            break;
        }
    }
    
    reward_bundle = function_3ed4d422591d18ea( var_8d0a9a7366274401 );
    
    if ( !isdefined( reward_bundle ) )
    {
        return;
    }
    
    count = function_2765712cd1dbd45e( reward_bundle );
    item_spawn_entry( reward_bundle, count );
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0x83b4e0fd, Offset: 0x33a1
// Size: 0x82
function private function_2765712cd1dbd45e( reward_bundle )
{
    switch ( reward_bundle )
    {
        case %"itemspawnentry:zm_t10_item_aether_tool_4":
            return 1;
        case %"hash_5ccd4ffef24f2106":
            return 1;
        case %"itemspawnentry:zm_t10_item_aether_crystal_3":
            return 1;
        case %"itemspawnentry:zm_t10_item_essence_large":
            return 600;
        case %"itemspawnentry:zm_t10_item_trials_salvage_green_500":
            return 500;
        case %"itemspawnentry:zm_t10_item_essence_large_700":
            return 700;
        default:
            return 1;
    }
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0x7ea9e9af, Offset: 0x342b
// Size: 0xfb
function private function_3ed4d422591d18ea( var_8d0a9a7366274401 )
{
    if ( var_8d0a9a7366274401 )
    {
        if ( level.var_89ccb7533940f0aa.count == 1 )
        {
            return %"itemspawnentry:zm_t10_item_aether_tool_4";
        }
        else if ( level.var_89ccb7533940f0aa.count == 2 )
        {
            return %"hash_5ccd4ffef24f2106";
        }
        else if ( level.var_89ccb7533940f0aa.count == 3 )
        {
            return %"itemspawnentry:zm_t10_item_aether_crystal_3";
        }
    }
    else if ( level.var_89ccb7533940f0aa.count == 1 )
    {
        return %"itemspawnentry:zm_t10_item_essence_large";
    }
    else if ( level.var_89ccb7533940f0aa.count == 2 )
    {
        return %"itemspawnentry:zm_t10_item_trials_salvage_green_500";
    }
    else if ( level.var_89ccb7533940f0aa.count == 3 )
    {
        return %"itemspawnentry:zm_t10_item_essence_large_700";
    }
    
    return %"itemspawnentry:zm_t10_item_essence_large";
}

// Namespace zm_sat_ruby_rh
// Params 2, eflags: 0x4
// Checksum 0x8f3eb0d6, Offset: 0x352f
// Size: 0x1e8
function private item_spawn_entry( item_bundle, count )
{
    if ( !( isdefined( item_bundle ) && isdefined( count ) && isdefined( level.var_96dd96e5b7d318ef ) ) )
    {
        return;
    }
    
    spawn_options = common_item::function_bc5ff2958b71a708( level.var_96dd96e5b7d318ef.origin, level.var_96dd96e5b7d318ef.angles );
    spawn_options.critical = 1;
    spawn_options.var_fd47e835523b473f = 1;
    reward_item = common_item::function_61c2c0251e742ffd( item_bundle, count, spawn_options );
    
    if ( isdefined( reward_item ) )
    {
        reward_item.mover = utility::spawn_model( "tag_origin", reward_item.origin, reward_item.angles );
        reward_item utility::scriptable_setparententity( reward_item.mover );
        
        if ( !isdefined( level.var_321a2a60b94e8813 ) || level.var_321a2a60b94e8813.size == 0 )
        {
            level.var_321a2a60b94e8813 = utility::getstructarray( "rev", "targetname" );
        }
        
        if ( !isdefined( level.var_321a2a60b94e8813 ) || level.var_321a2a60b94e8813.size <= 0 )
        {
            s_reward_loc = utility::getstruct( "rev", "targetname" );
        }
        else
        {
            idx = randomintrange( 0, level.var_321a2a60b94e8813.size - 1 );
            s_reward_loc = level.var_321a2a60b94e8813[ idx ];
            level.var_321a2a60b94e8813 = arrayremove( level.var_321a2a60b94e8813, s_reward_loc );
        }
        
        offset = function_6732463d04a25fb8( item_bundle );
        
        if ( isdefined( s_reward_loc ) )
        {
            reward_item.mover moveto( s_reward_loc.origin + ( 0, 0, offset ), 5 );
            reward_item.mover waittill( #"movedone" );
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 1, eflags: 0x4
// Checksum 0x8684594f, Offset: 0x371f
// Size: 0x7b
function private function_6732463d04a25fb8( reward_bundle )
{
    switch ( reward_bundle )
    {
        case %"itemspawnentry:zm_t10_item_aether_tool_4":
            return 0;
        case %"hash_5ccd4ffef24f2106":
            return 0;
        case %"itemspawnentry:zm_t10_item_aether_crystal_3":
            return 0;
        case %"itemspawnentry:zm_t10_item_essence_large":
            return -6;
        case %"itemspawnentry:zm_t10_item_trials_salvage_green_500":
            return -6;
        case %"itemspawnentry:zm_t10_item_essence_large_700":
            return -6;
        default:
            return 0;
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xdac22db8, Offset: 0x37a2
// Size: 0x153
function function_5e4e9cceb4aee54f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level endon( #"hash_83d54c1b3ae49531" );
    
    if ( self.var_e06a5125d6e50f0f )
    {
        self.var_e06a5125d6e50f0f delete();
    }
    
    var_c70762b488857e22 = utility::getstruct( "angel_4", "targetname" );
    var_c70761b488857bef = utility::getstruct( "angel_5", "targetname" );
    var_c70760b4888579bc = utility::getstruct( "angel_6", "targetname" );
    var_c7075fb488857789 = utility::getstruct( "angel_7", "targetname" );
    self moveto( var_c70762b488857e22.origin, 3, 0.5, 1 );
    self waittill( #"movedone" );
    self moveto( var_c70761b488857bef.origin, 1.8, 0.5, 0.5 );
    self waittill( #"movedone" );
    self moveto( var_c70760b4888579bc.origin, 1.8, 0.5, 0.5 );
    self waittill( #"movedone" );
    self moveto( var_c7075fb488857789.origin, 15, 7 );
    self waittill( #"movedone" );
    self delete();
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0x24867167, Offset: 0x38fd
// Size: 0x20
function assign_light_ent( params )
{
    level.var_3143bafa8162c924 = params.ent;
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x9c573c03, Offset: 0x3925
// Size: 0x92
function function_842128ea425f960f()
{
    a_triggers = getentarray( "t", "targetname" );
    
    foreach ( trigger in a_triggers )
    {
        if ( isdefined( trigger ) )
        {
            trigger thread check_trigger_contact();
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xea2a5a20, Offset: 0x39bf
// Size: 0x966
function check_trigger_contact()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.var_3143bafa8162c924 ) && level.var_3143bafa8162c924 istouching( self ) && !level utility::flag( "rh_block_exibit" ) )
        {
            if ( self.script_noteworthy == "f_go" )
            {
                if ( utility::flag( "rh_f_go" ) )
                {
                    return;
                }
                
                e_go = getent( "rh_go", "targetname" );
                e_go hide();
                
                if ( isdefined( level.var_bf32046fb0aedcb8 ) )
                {
                    foreach ( exhibit in level.var_bf32046fb0aedcb8 )
                    {
                        if ( exhibit.name == "f" )
                        {
                            exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                        }
                    }
                }
                
                level utility::flag_set( "rh_f_go" );
                var_7db80bd0af60eb99 = utility::getstruct( "go_sp", "targetname" );
                var_b32b98bad6006ab8 = utility::getstruct( "go_md", "targetname" );
                var_298add0dbd41c8c7 = utility::getstruct( "go_ld", "targetname" );
                scr_flamingo = spawnscriptable( %"hash_3a65bd50463f9c7", var_7db80bd0af60eb99.origin, var_7db80bd0af60eb99.angles );
                waitframe();
                mover = utility::spawn_model( "tag_origin", scr_flamingo.origin, scr_flamingo.angles );
                scr_flamingo scriptablesetparententity( mover );
                waitframe();
                level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
                level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_flamingo;
                mover thread utility::function_8001268940441423( var_7db80bd0af60eb99.origin, var_298add0dbd41c8c7.origin, var_b32b98bad6006ab8.origin, 0.6, 1, 1 );
                mover rotateto( var_298add0dbd41c8c7.angles, 0.55 );
                wait 0.75;
                code = "F";
                level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
                level.var_89ccb7533940f0aa.count++;
            }
            else if ( self.script_noteworthy == "to_t" )
            {
                if ( utility::flag( "rh_to_t" ) )
                {
                    return;
                }
                
                var_32e0310b7c9ee403 = getent( "rh_to", "targetname" );
                var_32e0310b7c9ee403 hide();
                level utility::flag_set( "rh_to_t" );
                
                if ( isdefined( level.var_bf32046fb0aedcb8 ) )
                {
                    foreach ( exhibit in level.var_bf32046fb0aedcb8 )
                    {
                        if ( exhibit.name == "t" )
                        {
                            exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                        }
                    }
                }
                
                var_a6e9ca053ee148a5 = utility::getstruct( "to_sp", "targetname" );
                var_b60b80bb319425e4 = utility::getstruct( "to_md", "targetname" );
                var_293051d67ac810bb = utility::getstruct( "to_ld", "targetname" );
                scr_toilet = spawnscriptable( %"hash_2a4c494b5f57a57", var_a6e9ca053ee148a5.origin, var_a6e9ca053ee148a5.angles );
                waitframe();
                mover = utility::spawn_model( "tag_origin", scr_toilet.origin, scr_toilet.angles );
                scr_toilet scriptablesetparententity( mover );
                waitframe();
                level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
                level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_toilet;
                mover thread utility::function_8001268940441423( var_a6e9ca053ee148a5.origin, var_293051d67ac810bb.origin, var_b60b80bb319425e4.origin, 0.6, 1, 1 );
                mover rotateto( var_293051d67ac810bb.angles, 0.55 );
                wait 0.75;
                code = "T";
                level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
                level.var_89ccb7533940f0aa.count++;
            }
            else if ( self.script_noteworthy == "as_to" )
            {
                if ( utility::flag( "rh_as_to" ) )
                {
                    return;
                }
                
                e_as = getent( "rh_sp", "targetname" );
                e_as hide();
                
                if ( isdefined( level.var_bf32046fb0aedcb8 ) )
                {
                    foreach ( exhibit in level.var_bf32046fb0aedcb8 )
                    {
                        if ( exhibit.name == "s" )
                        {
                            exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                        }
                    }
                }
                
                level utility::flag_set( "rh_as_to" );
                var_b95783c013165695 = utility::getstruct( "sp_sp", "targetname" );
                var_a05a46badfe2ea74 = utility::getstruct( "sp_md", "targetname" );
                var_9381532426610bab = utility::getstruct( "sp_ld", "targetname" );
                scr_helmet = spawnscriptable( %"hash_4957c386c8f7ff77", var_b95783c013165695.origin, var_b95783c013165695.angles );
                waitframe();
                mover = utility::spawn_model( "tag_origin", scr_helmet.origin, scr_helmet.angles );
                scr_helmet scriptablesetparententity( mover );
                waitframe();
                level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
                level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_helmet;
                mover thread utility::function_8001268940441423( var_b95783c013165695.origin, var_9381532426610bab.origin, var_a05a46badfe2ea74.origin, 0.6, 1, 1 );
                mover rotateto( var_9381532426610bab.angles, 0.55 );
                wait 0.75;
                code = "S";
                level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
                level.var_89ccb7533940f0aa.count++;
            }
            else if ( self.script_noteworthy == "lv_lp" )
            {
                if ( utility::flag( "rh_lv_lp" ) )
                {
                    return;
                }
                
                e_lv = getent( "rh_lv", "targetname" );
                e_lv hide();
                
                if ( isdefined( level.var_bf32046fb0aedcb8 ) )
                {
                    foreach ( exhibit in level.var_bf32046fb0aedcb8 )
                    {
                        if ( exhibit.name == "l" )
                        {
                            exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                        }
                    }
                }
                
                level utility::flag_set( "rh_lv_lp" );
                var_448f3c4aca6d837a = utility::getstruct( "lv_sp", "targetname" );
                var_c9fe560f1197588b = utility::getstruct( "lv_md", "targetname" );
                var_e05ee3f9404aa8e6 = utility::getstruct( "lv_ld", "targetname" );
                scr_lamp = spawnscriptable( %"hash_2de62758bd5e6853", var_448f3c4aca6d837a.origin, var_448f3c4aca6d837a.angles );
                waitframe();
                mover = utility::spawn_model( "tag_origin", scr_lamp.origin, scr_lamp.angles );
                scr_lamp scriptablesetparententity( mover );
                waitframe();
                level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
                level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_lamp;
                mover thread utility::function_8001268940441423( var_448f3c4aca6d837a.origin, var_e05ee3f9404aa8e6.origin, var_c9fe560f1197588b.origin, 0.6, 1, 1 );
                mover rotateto( var_e05ee3f9404aa8e6.angles, 0.55 );
                wait 0.75;
                code = "L";
                level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
                level.var_89ccb7533940f0aa.count++;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x97f4e207, Offset: 0x432d
// Size: 0x2d1
function function_1ea777f8e175b5df()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.var_89ccb7533940f0aa.count == 1 && level.var_89ccb7533940f0aa.move_one == 0 && isdefined( level.var_96dd96e5b7d318ef ) )
        {
            level notify( #"hash_9b87f20237f8f218" );
            fx = utility::getfx( "ufo_reward_code" );
            killfxontag( fx, level.var_826d0f960e00f593, "tag_origin" );
            level.var_89ccb7533940f0aa.move_one = 1;
            level utility::flag_set( "rh_block_exibit" );
            level function_de78939d840cc483();
            level.var_96dd96e5b7d318ef function_86736d4be11abbae();
            level.var_96dd96e5b7d318ef thread function_88038adedb83a28c();
            wait 2;
            level utility::flag_clear( "rh_block_exibit" );
            level function_ea6f65d35ae7272c();
        }
        else if ( level.var_89ccb7533940f0aa.count == 2 && level.var_89ccb7533940f0aa.move_two == 0 && isdefined( level.var_96dd96e5b7d318ef ) )
        {
            level.var_89ccb7533940f0aa.move_two = 1;
            level utility::flag_set( "rh_block_exibit" );
            level function_de78939d840cc483();
            level.var_96dd96e5b7d318ef function_86736d4be11abbae();
            level.var_96dd96e5b7d318ef thread function_88038bdedb83a4bf();
            level utility::flag_clear( "rh_block_exibit" );
            wait 2;
            level function_ea6f65d35ae7272c();
        }
        else if ( level.var_89ccb7533940f0aa.count == 3 && level.var_89ccb7533940f0aa.move_three == 0 && isdefined( level.var_96dd96e5b7d318ef ) )
        {
            level.var_89ccb7533940f0aa.move_three = 1;
            level utility::flag_set( "rh_block_exibit" );
            level function_de78939d840cc483();
            level.var_96dd96e5b7d318ef function_86736d4be11abbae();
            level.var_96dd96e5b7d318ef thread function_6af3e77142143766();
            level utility::flag_clear( "rh_block_exibit" );
            level function_ea6f65d35ae7272c();
        }
        else if ( level.var_89ccb7533940f0aa.count == 4 && level.var_89ccb7533940f0aa.move_four == 0 && isdefined( level.var_96dd96e5b7d318ef ) )
        {
            level.var_89ccb7533940f0aa.move_four = 1;
            level utility::flag_set( "rh_block_exibit" );
            level function_de78939d840cc483();
            level.var_96dd96e5b7d318ef thread function_880388dedb839e26();
            level utility::flag_clear( "rh_block_exibit" );
            level function_ea6f65d35ae7272c();
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x57e0a864, Offset: 0x4606
// Size: 0xba
function function_de78939d840cc483()
{
    if ( isdefined( level.var_bf32046fb0aedcb8 ) )
    {
        deactivateworldevent( "we_vfx_statue_glow_s" );
        deactivateworldevent( "we_vfx_statue_glow_f" );
        deactivateworldevent( "we_vfx_statue_glow_t" );
        deactivateworldevent( "we_vfx_statue_glow_l" );
        
        foreach ( exhibit in level.var_bf32046fb0aedcb8 )
        {
            exhibit utility::function_7c10ea82c1e305b8( "vfx", "red" );
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0xe6ac5969, Offset: 0x46c8
// Size: 0x548
function function_ea6f65d35ae7272c()
{
    if ( utility::flag( "rh_f_go" ) )
    {
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "f" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                }
            }
        }
    }
    else
    {
        activateworldevent( "we_vfx_statue_glow_f" );
        
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "f" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "off" );
                }
            }
        }
    }
    
    if ( utility::flag( "rh_to_t" ) )
    {
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "t" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                }
            }
        }
    }
    else
    {
        activateworldevent( "we_vfx_statue_glow_t" );
        
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "t" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "off" );
                }
            }
        }
    }
    
    if ( utility::flag( "rh_as_to" ) )
    {
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "s" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                }
            }
        }
    }
    else
    {
        activateworldevent( "we_vfx_statue_glow_s" );
        
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "s" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "off" );
                }
            }
        }
    }
    
    if ( utility::flag( "rh_lv_lp" ) )
    {
        if ( isdefined( level.var_bf32046fb0aedcb8 ) )
        {
            foreach ( exhibit in level.var_bf32046fb0aedcb8 )
            {
                if ( exhibit.name == "l" )
                {
                    exhibit utility::function_7c10ea82c1e305b8( "vfx", "purple" );
                }
            }
        }
        
        return;
    }
    
    activateworldevent( "we_vfx_statue_glow_l" );
    
    if ( isdefined( level.var_bf32046fb0aedcb8 ) )
    {
        foreach ( exhibit in level.var_bf32046fb0aedcb8 )
        {
            if ( exhibit.name == "l" )
            {
                exhibit utility::function_7c10ea82c1e305b8( "vfx", "off" );
            }
        }
    }
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x796774ae, Offset: 0x4c18
// Size: 0xfa
function function_289f50c4898d1b2a()
{
    level endon( #"game_ended" );
    level endon( #"death" );
    utility::flag_wait( "ruby_boss_triggered" );
    
    foreach ( exhibit in level.var_bf32046fb0aedcb8 )
    {
        exhibit utility::function_7c10ea82c1e305b8( "vfx", "off" );
    }
    
    activateworldevent( "we_vfx_statue_glow_s" );
    activateworldevent( "we_vfx_statue_glow_f" );
    activateworldevent( "we_vfx_statue_glow_t" );
    activateworldevent( "we_vfx_statue_glow_l" );
    
    if ( isdefined( level.var_96dd96e5b7d318ef ) )
    {
        level.var_96dd96e5b7d318ef function_5e4e9cceb4aee54f();
        level notify( #"hash_83d54c1b3ae49531" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0xbec20202, Offset: 0x4d1a
// Size: 0x5a
function pick_up_item( player )
{
    playworldsound( self.origin + ( 0, 0, 15 ), #"hash_d8047720d352b10f" );
    level utility::flag_set( "rh_it_don" );
    level thread spawn_box_interact();
    self.mdl_alien delete();
    self delete();
}

// Namespace zm_sat_ruby_rh
// Params 2
// Checksum 0xc1c13df6, Offset: 0x4d7c
// Size: 0x36
function function_6f54b3e0c81c720b( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_rh
// Params 0
// Checksum 0x883408b9, Offset: 0x4dbb
// Size: 0x5c
function spawn_box_interact()
{
    pos = utility::getstruct( "deadbeat_final" );
    box_interact = interaction::register_interact( pos.origin + ( 0, 0, 25 ), 60, &box_interact_func, &box_interact_hint );
    box_interact.pos = pos;
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0xec289ce2, Offset: 0x4e1f
// Size: 0x5a
function box_interact_func( player )
{
    if ( level utility::flag( "rh_it_don" ) )
    {
        self delete();
        level.rh_box zm_rabbithole::toybox_give_reward( "sat_zm_alien_body_ruby", ( 0, -35, 0 ) );
        wait 0.5;
        level thread overlord::playconversation( #"hash_ecde13e287044093" );
    }
}

// Namespace zm_sat_ruby_rh
// Params 2
// Checksum 0x3108304f, Offset: 0x4e81
// Size: 0x36
function box_interact_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0x6022870e, Offset: 0x4ec0
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
                
                if ( player.var_11f0a190160021dd && player.var_4ad88eeba60b1ac && player.var_5388587ed7a9f314 && player.var_7fe31db612cd941a && player.var_27501a6cf23a6c06 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                }
            }
        }
    }
}

/#

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0x13a54707, Offset: 0x5015
    // Size: 0xf4, Type: dev
    function init_ruby_rh_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x3c>", &function_e4bccd750016735d );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x46>", &function_eabe43d4e5a75a41 );
        devgui::add_devgui_func( "<dev string:x5a>", "<dev string:x5a>", &function_44f599737e353f32 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x69>", &function_e41ef24cbba212f8 );
        devgui::add_devgui_func( "<dev string:x78>", "<dev string:x78>", &spawn_lamp );
        devgui::add_devgui_func( "<dev string:x83>", "<dev string:x83>", &spawn_suit );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:x8e>", &spawn_toilet );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:x9b>", &spawn_flamingo );
        devgui::add_devgui_func( "<dev string:xaa>", "<dev string:xaa>", &function_e1dc40ab50f65ca8 );
        devgui::add_devgui_func( "<dev string:xba>", "<dev string:xba>", &quick_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0xcd7ce927, Offset: 0x5111
    // Size: 0x27, Type: dev
    function function_e4bccd750016735d()
    {
        level utility::flag_set( "<dev string:xc6>" );
        level.var_4a75d6f667fe29b1 = 1;
        level.var_d10ffa3495170564 = 0;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0xf57287e2, Offset: 0x5140
    // Size: 0x27, Type: dev
    function function_eabe43d4e5a75a41()
    {
        level utility::flag_set( "<dev string:xc6>" );
        level.var_4a75d6f667fe29b1 = 0;
        level.var_d10ffa3495170564 = 1;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0x7a45858c, Offset: 0x516f
    // Size: 0x12, Type: dev
    function function_44f599737e353f32()
    {
        level utility::flag_set( "<dev string:xd7>" );
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0xde4d8814, Offset: 0x5189
    // Size: 0x19a, Type: dev
    function spawn_toilet()
    {
        level utility::flag_set( "<dev string:xe7>" );
        var_32e0310b7c9ee403 = getent( "<dev string:xef>", "<dev string:xf5>" );
        var_32e0310b7c9ee403 hide();
        var_a6e9ca053ee148a5 = utility::getstruct( "<dev string:x100>", "<dev string:xf5>" );
        var_b60b80bb319425e4 = utility::getstruct( "<dev string:x106>", "<dev string:xf5>" );
        var_293051d67ac810bb = utility::getstruct( "<dev string:x10c>", "<dev string:xf5>" );
        scr_toilet = spawnscriptable( %"hash_2a4c494b5f57a57", var_a6e9ca053ee148a5.origin, var_a6e9ca053ee148a5.angles );
        waitframe();
        mover = utility::spawn_model( "<dev string:x112>", scr_toilet.origin, scr_toilet.angles );
        scr_toilet scriptablesetparententity( mover );
        level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
        level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_toilet;
        mover thread utility::function_8001268940441423( var_a6e9ca053ee148a5.origin, var_293051d67ac810bb.origin, var_b60b80bb319425e4.origin, 0.6, 1, 1 );
        mover rotateto( var_293051d67ac810bb.angles, 0.55 );
        wait 0.75;
        code = "<dev string:x11d>";
        level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
        level.var_89ccb7533940f0aa.count++;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0x4a6fc1cf, Offset: 0x532b
    // Size: 0x19b, Type: dev
    function spawn_suit()
    {
        level utility::flag_set( "<dev string:x11f>" );
        e_as = getent( "<dev string:x128>", "<dev string:xf5>" );
        e_as hide();
        var_b95783c013165695 = utility::getstruct( "<dev string:x12e>", "<dev string:xf5>" );
        var_a05a46badfe2ea74 = utility::getstruct( "<dev string:x134>", "<dev string:xf5>" );
        var_9381532426610bab = utility::getstruct( "<dev string:x13a>", "<dev string:xf5>" );
        scr_helmet = spawnscriptable( %"hash_4957c386c8f7ff77", var_b95783c013165695.origin, var_b95783c013165695.angles );
        waitframe();
        mover = utility::spawn_model( "<dev string:x112>", scr_helmet.origin, scr_helmet.angles );
        scr_helmet scriptablesetparententity( mover );
        waitframe();
        level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
        level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_helmet;
        mover thread utility::function_8001268940441423( var_b95783c013165695.origin, var_9381532426610bab.origin, var_a05a46badfe2ea74.origin, 0.6, 1, 1 );
        mover rotateto( var_9381532426610bab.angles, 0.55 );
        wait 0.75;
        code = "<dev string:x140>";
        level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
        level.var_89ccb7533940f0aa.count++;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0xbd44bc78, Offset: 0x54ce
    // Size: 0x19b, Type: dev
    function spawn_lamp()
    {
        level utility::flag_set( "<dev string:x142>" );
        e_lv = getent( "<dev string:x14b>", "<dev string:xf5>" );
        e_lv hide();
        var_448f3c4aca6d837a = utility::getstruct( "<dev string:x151>", "<dev string:xf5>" );
        var_c9fe560f1197588b = utility::getstruct( "<dev string:x157>", "<dev string:xf5>" );
        var_e05ee3f9404aa8e6 = utility::getstruct( "<dev string:x15d>", "<dev string:xf5>" );
        scr_lamp = spawnscriptable( %"hash_2de62758bd5e6853", var_448f3c4aca6d837a.origin, var_448f3c4aca6d837a.angles );
        waitframe();
        mover = utility::spawn_model( "<dev string:x112>", scr_lamp.origin, scr_lamp.angles );
        scr_lamp scriptablesetparententity( mover );
        waitframe();
        level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
        level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_lamp;
        mover thread utility::function_8001268940441423( var_448f3c4aca6d837a.origin, var_e05ee3f9404aa8e6.origin, var_c9fe560f1197588b.origin, 0.6, 1, 1 );
        mover rotateto( var_e05ee3f9404aa8e6.angles, 0.55 );
        wait 0.75;
        code = "<dev string:x163>";
        level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
        level.var_89ccb7533940f0aa.count++;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0xdb826615, Offset: 0x5671
    // Size: 0x1a7, Type: dev
    function spawn_flamingo()
    {
        level utility::flag_set( "<dev string:x165>" );
        e_go = getent( "<dev string:x16d>", "<dev string:xf5>" );
        e_go hide();
        level utility::flag_set( "<dev string:x165>" );
        var_7db80bd0af60eb99 = utility::getstruct( "<dev string:x173>", "<dev string:xf5>" );
        var_b32b98bad6006ab8 = utility::getstruct( "<dev string:x179>", "<dev string:xf5>" );
        var_298add0dbd41c8c7 = utility::getstruct( "<dev string:x17f>", "<dev string:xf5>" );
        scr_flamingo = spawnscriptable( %"hash_3a65bd50463f9c7", var_7db80bd0af60eb99.origin, var_7db80bd0af60eb99.angles );
        waitframe();
        mover = utility::spawn_model( "<dev string:x112>", scr_flamingo.origin, scr_flamingo.angles );
        scr_flamingo scriptablesetparententity( mover );
        level.var_b6fb1789eda91bc9[ level.var_b6fb1789eda91bc9.size ] = mover;
        level.var_680bbc76d58fbc18[ level.var_680bbc76d58fbc18.size ] = scr_flamingo;
        mover thread utility::function_8001268940441423( var_7db80bd0af60eb99.origin, var_298add0dbd41c8c7.origin, var_b32b98bad6006ab8.origin, 0.6, 1, 1 );
        mover rotateto( var_298add0dbd41c8c7.angles, 0.55 );
        wait 0.75;
        code = "<dev string:x185>";
        level.var_39e3204ce1ee2dc8[ level.var_39e3204ce1ee2dc8.size ] = code;
        level.var_89ccb7533940f0aa.count++;
    }

    // Namespace zm_sat_ruby_rh
    // Params 0, eflags: 0x4
    // Checksum 0x8ca4fd41, Offset: 0x5820
    // Size: 0x12, Type: dev
    function private function_e41ef24cbba212f8()
    {
        level utility::flag_set( "<dev string:x187>" );
    }

    // Namespace zm_sat_ruby_rh
    // Params 0, eflags: 0x4
    // Checksum 0xba4a7fee, Offset: 0x583a
    // Size: 0x49, Type: dev
    function private function_e1dc40ab50f65ca8()
    {
        level utility::flag_set( "<dev string:x191>" );
        level thread zm_rabbithole::function_b422525417f4cda2();
        level.rh_box = zm_rabbithole::spawn_toybox( "<dev string:x19b>" );
        level thread spawn_box_interact();
        wait 4;
        level.rh_box zm_rabbithole::toybox_open();
    }

    // Namespace zm_sat_ruby_rh
    // Params 0
    // Checksum 0x895bda1d, Offset: 0x588b
    // Size: 0xc, Type: dev
    function quick_debug()
    {
        function_5e4e9cceb4aee54f();
    }

#/

// Namespace zm_sat_ruby_rh
// Params 1
// Checksum 0xbf905347, Offset: 0x589f
// Size: 0x26
function function_a0acf366c827d693( params )
{
    level utility::flag_set( "ruby_mq_all_5_melody_pillars_on" );
    level utility::flag_set( "wwq_step_1_complete" );
}

