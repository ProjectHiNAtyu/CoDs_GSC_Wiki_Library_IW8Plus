// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope.gsc  (hash_1ff57d66a05aaa52.gscc) (size: 10286 Bytes / 0x282e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1d80d001 (494981121)
// size ...... 10286 (0x282e)
// includes .. 7   (offset: 0x2472)
// strings ... 60  (offset: 0x24aa)
// dev strs .. 2   (offset: 0x2816)
// exports ... 19  (offset: 0x1832)
// cseg ...... 0x494 + 0x139e (0x1832)
// imports ... 74  (offset: 0x1b2a)
// animtree1 . 0   (offset: 0x282e)
// animtree2 . 0   (offset: 0x282e)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_quest;

#namespace zm_sat_ruby_telescope;

// Namespace zm_sat_ruby_telescope
// Params 0
// Checksum 0xc0ad1e, Offset: 0x4b2
// Size: 0x17
function init()
{
    level utility::flag_wait( "zm_init_done" );
    level thread setup_telescope();
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0xf830ad9f, Offset: 0x4d1
// Size: 0x234
function private setup_telescope()
{
    level utility::flag_wait( "zm_sat_ruby_quest_wwq_cs_completed" );
    level utility::flag_wait( "zm_sat_ruby_telescope_cs_completed" );
    level.ruby_telescope = spawnstruct();
    level.ruby_telescope.var_320758f2946bf86 = [];
    level.ruby_telescope.scriptable = utility::function_30dbabe3200518b( "ruby_telescope", #targetname );
    level.ruby_telescope.base_scriptable = utility::function_30dbabe3200518b( "ruby_telescope_base", #targetname );
    level.ruby_telescope.a_target_positions = utility::getstructarray( "telescope_target_positions", "targetname" );
    
    if ( !getdvarint( @"hash_6e1acf80a28a210b", 0 ) )
    {
        level utility::flag_wait( "wwq_step_1_complete" );
    }
    
    level.ruby_telescope.scriptable setscriptablepartstate( "angle", "unlocked" );
    level.ruby_telescope.base_scriptable setscriptablepartstate( "anim", "unlocked" );
    wait 5;
    s_telescope_interact = utility::getstruct( "telescope_interact", "targetname" );
    level.ruby_telescope.telescope_interact = spawnscriptable( "ruby_scriptable_interact", s_telescope_interact.origin );
    level.ruby_telescope.telescope_interact = interaction::register_scriptable_interact( level.ruby_telescope.telescope_interact, &on_telescope_interact );
    level.ruby_telescope.telescope_interact interaction::set_interact_hint_callback( &telescope_interact_hint );
    level.ruby_telescope.starting_angles = utility::getstruct( "telescope_view_pos", "targetname" ).angles;
    level.ruby_telescope.s_viewpoint = utility::getstruct( "telescope_view_pos", "targetname" );
    level.ruby_telescope.uses_left = 3;
    level callback::add( "on_round_start", &function_a35706e6ce2c736f );
    level utility::flag_set( "ruby_telescope_setup_complete" );
}

// Namespace zm_sat_ruby_telescope
// Params 2, eflags: 0x4
// Checksum 0x3f92d83d, Offset: 0x70d
// Size: 0xa2
function private telescope_interact_hint( usable, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled && level.ruby_telescope.uses_left > 0 )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/use_telescope", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_telescope
// Params 1, eflags: 0x4
// Checksum 0xdfa0a7c8, Offset: 0x7b7
// Size: 0x4f6
function private on_telescope_interact( user )
{
    if ( !isplayer( user ) || user.ismutantinjection || level.ruby_telescope.uses_left <= 0 )
    {
        return;
    }
    
    level endon( #"telescope_finish" );
    disable_telescope();
    user val::set( "telescope", "ignoreme", 1 );
    user val::set( "telescope", "death", 0 );
    user val::set( "telescope", "damage", 0 );
    user val::set( "telescope", "melee", 0 );
    user val::set( "telescope", "allow_movement", 0 );
    user val::set( "telescope", "crouch", 0 );
    user val::set( "telescope", "prone", 0 );
    user val::set( "telescope", "sprint", 0 );
    user val::set( "telescope", "weapon", 0 );
    user val::set( "telescope", "killstreaks", 0 );
    user val::set( "telescope", "gesture", 0 );
    user setcinematicmotionoverride( "disabled" );
    level.ruby_telescope.uses_left--;
    level.ruby_telescope.defaultbasefov = user.defaultbasefov ?? getdvarfloat( @"cg_targetbasefov", 65 );
    user.v_starting_angles = user getplayerangles();
    level.ruby_telescope.mdl_viewpoint = utility::spawn_model( "tag_player", level.ruby_telescope.s_viewpoint.origin, level.ruby_telescope.s_viewpoint.angles );
    
    if ( isdefined( user ) )
    {
        level callback::add( #"player_disconnect", &function_a9cc832acf68890b );
        user capturnrate( 0.01, 0.01 );
        user playsoundtoplayer( "evt_wwq_telescope_use", user );
        user setscriptablepartstate( "ruby_telescope_use_sfx", "on_no_movement" );
    }
    
    namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( user, 1, 0.5 );
    user setplayerangles( level.ruby_telescope.s_viewpoint.angles );
    var_598dd515f27d4bb = anglesdelta( ( 0, level.ruby_telescope.s_viewpoint.angles[ 1 ], 0 ), ( 0, level.ruby_telescope.starting_angles[ 1 ] - 18, 0 ) );
    var_36e8926dae26b22e = anglesdelta( ( 0, level.ruby_telescope.s_viewpoint.angles[ 1 ], 0 ), ( 0, level.ruby_telescope.starting_angles[ 1 ] + 18, 0 ) );
    var_92c91d636fad6f56 = anglesdelta( ( level.ruby_telescope.s_viewpoint.angles[ 0 ], 0, 0 ), ( level.ruby_telescope.starting_angles[ 0 ] - 9, 0, 0 ) );
    var_b946747aff82eee3 = anglesdelta( ( level.ruby_telescope.s_viewpoint.angles[ 0 ], 0, 0 ), ( level.ruby_telescope.starting_angles[ 0 ] + 9, 0, 0 ) );
    user playerlinkweaponviewtodelta( level.ruby_telescope.mdl_viewpoint, "tag_player", 0, var_598dd515f27d4bb, var_36e8926dae26b22e, var_92c91d636fad6f56, var_b946747aff82eee3 );
    user modifybasefov( 12 );
    user lerpfovscalefactor( 0, 0 );
    user function_f3f05a362d4b7712( 1 );
    user capturnrate( 2.3, 2.3 );
    pbgpostfxbundlestart( user, %"cer_zm_hidden_smoke_vignette" );
    namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( user, 0, 0 );
    user setclientomnvar( "ui_telescope_countdown_timer", 30 );
    user setclientomnvar( "ui_is_in_telescope", 1 );
    level.ruby_telescope.user = user;
    user thread function_b3c7dca7b26142e7();
    user thread function_168f9d358e0ec87f();
    user thread function_bf335ac608021dcf();
    user thread telescope_exit_watcher();
    
    foreach ( player in level.players )
    {
        if ( player != user )
        {
            player thread function_1544f97c9c445887();
        }
    }
    
    wait 30;
    function_72b79a760dd653d6( user );
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0x844d9131, Offset: 0xcb5
// Size: 0x16e
function private function_bf335ac608021dcf()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( level.ruby_telescope.user ) )
    {
        prev_player_angles = self getplayerangles();
        input = self getnormalizedmovement();
        
        if ( input[ 0 ] != 0 || input[ 1 ] != 0 )
        {
            self setplayerangles( prev_player_angles + ( input[ 0 ] * -0.07, input[ 1 ] * -0.07, 0 ) );
        }
        
        waitframe();
        cur_angle = self getplayerangles();
        move_mag = abs( prev_player_angles[ 0 ] - cur_angle[ 0 ] ) + abs( prev_player_angles[ 1 ] - cur_angle[ 1 ] );
        self.telescope_moving = move_mag > 0.01;
        
        if ( self.telescope_moving == 1 )
        {
            if ( self.telescope_rumble != 1 )
            {
                self.telescope_rumble = 1;
                self playrumblelooponentity( "damage_light" );
                self setscriptablepartstate( "ruby_telescope_use_sfx", "on_movement", 1 );
            }
            
            continue;
        }
        
        if ( self.telescope_rumble == 1 )
        {
            self.telescope_rumble = 0;
            self stoprumble( "damage_light" );
            self setscriptablepartstate( "ruby_telescope_use_sfx", "on_no_movement", 1 );
        }
    }
    
    self.telescope_rumble = 0;
    self stoprumble( "damage_light" );
    self setscriptablepartstate( "ruby_telescope_use_sfx", "off", 1 );
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0xf1af7f7a, Offset: 0xe2b
// Size: 0x197
function private function_b3c7dca7b26142e7()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( isdefined( level.ruby_telescope.user ) )
    {
        user_angles = self getplayerangles();
        
        if ( user_angles[ 1 ] < 0 )
        {
            var_eeb1d8ff86c0045b = 2.4 - abs( user_angles[ 1 ] + 162 ) / 15;
        }
        else
        {
            var_eeb1d8ff86c0045b = 2.4 - ( 18 + 180 - user_angles[ 1 ] ) / 15;
        }
        
        ra_h = maxint( int( var_eeb1d8ff86c0045b ), 0 );
        ra_min = clampint( int( ( var_eeb1d8ff86c0045b - ra_h ) * 60 ), 0, 59 );
        self setclientomnvar( "ui_telescope_right_ascension_hours", ra_h );
        self setclientomnvar( "ui_telescope_right_ascension_minutes", ra_min );
        
        if ( level.var_dfedda3c993ff77e )
        {
            if ( isdefined( level.ruby_mq.mdl_telescope_mars ) )
            {
                dec = level.ruby_mq.mdl_telescope_mars.dec;
                dec_min = level.ruby_mq.mdl_telescope_mars.dec_min;
            }
        }
        else
        {
            dec = clampint( int( abs( user_angles[ 0 ] ) ), 0, 90 );
            dec_min = clampint( int( ( abs( user_angles[ 0 ] ) - dec ) * 60 ), 0, 59 );
        }
        
        self setclientomnvar( "ui_telescope_declination_degrees", dec );
        self setclientomnvar( "ui_telescope_declination_minutes", dec_min );
        wait 0.2;
    }
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0x6a135dc4, Offset: 0xfca
// Size: 0x32
function private function_168f9d358e0ec87f()
{
    level endon( #"game_ended" );
    
    while ( isdefined( level.ruby_telescope.user ) )
    {
        function_3ab500e5ce6eeec3();
        wait 1;
    }
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0xd826e94a, Offset: 0x1004
// Size: 0x19c
function private function_3ab500e5ce6eeec3()
{
    if ( level.ruby_telescope.mdl_viewpoint && level.ruby_telescope.var_320758f2946bf86 && level.ruby_telescope.user )
    {
        a_trace = trace::ray_trace_ents( level.ruby_telescope.mdl_viewpoint.origin, level.ruby_telescope.mdl_viewpoint.origin + anglestoforward( level.ruby_telescope.user getplayerangles() ) * 10000, level.ruby_telescope.var_320758f2946bf86, undefined, undefined, undefined, 1 );
        
        if ( a_trace[ "entity" ].info != "mars" )
        {
            level.var_dfedda3c993ff77e = 0;
        }
        
        if ( a_trace[ "hittype" ] == "hittype_entity" )
        {
            /#
                iprintlnbold( "<dev string:x24>" + a_trace[ "<dev string:x38>" ].model );
            #/
            
            params = spawnstruct();
            params.ent = a_trace[ "entity" ];
            params.spotter = self;
            level callback::callback( "telescope_target_acquired", params );
            
            if ( params.ent.var_23d07a260ea5e8a8 )
            {
                level.ruby_telescope.telescope_interact function_72b79a760dd653d6( self );
            }
            
            return;
        }
        
        level notify( #"hash_6c9d582df1401e3d" );
    }
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0x7f3ded81, Offset: 0x11a8
// Size: 0x74
function private function_1544f97c9c445887()
{
    level endon( #"game_ended" );
    level endon( #"telescope_finish" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self getspectatingplayer() == level.ruby_telescope.user )
        {
            self modifybasefov( 12 );
        }
        else
        {
            self modifybasefov( level.ruby_telescope.defaultbasefov );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_telescope
// Params 0, eflags: 0x4
// Checksum 0xdfab8810, Offset: 0x1224
// Size: 0x7e
function private telescope_exit_watcher()
{
    level endon( #"game_ended" );
    level endon( #"telescope_finish" );
    self endon( #"death_or_disconnect" );
    self notifyonplayercommand( "telescope_exit", "+stance" );
    self notifyonplayercommand( "telescope_exit", "+prone" );
    self notifyonplayercommand( "telescope_exit", "+movedown" );
    self waittill( #"telescope_exit" );
    level.ruby_telescope.telescope_interact function_72b79a760dd653d6( self );
}

// Namespace zm_sat_ruby_telescope
// Params 1
// Checksum 0x508dff49, Offset: 0x12aa
// Size: 0x294
function function_72b79a760dd653d6( user )
{
    if ( !isdefined( level.ruby_telescope.user ) )
    {
        return;
    }
    
    if ( level utility::flag( "ruby_js_active" ) )
    {
        return;
    }
    
    if ( user )
    {
        user notifyonplayercommandremove( "telescope_exit", "+stance" );
        user notifyonplayercommandremove( "telescope_exit", "+prone" );
        user notifyonplayercommandremove( "telescope_exit", "+movedown" );
        user setscriptablepartstate( "ruby_telescope_use_sfx", "off", 1 );
        user playsoundtoplayer( "evt_wwq_telescope_leave", user );
        user capturnrate( 0.01, 0.01 );
        namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( user, 1, 0.5 );
        level.ruby_telescope.s_viewpoint.angles = user getplayerangles();
        user setclientomnvar( "ui_is_in_telescope", 0 );
        user modifybasefov( level.ruby_telescope.defaultbasefov );
        user lerpfovscalefactor( 1, 0 );
        user function_f3f05a362d4b7712( 0 );
        user unlink( 1 );
        user setplayerangles( user.v_starting_angles );
        user clearcinematicmotionoverride();
        user capturnrate( 999, 999 );
        pbgpostfxbundleend( user, %"cer_zm_hidden_smoke_vignette" );
        namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( user, 0, 0 );
        user val::reset_all( "telescope" );
        
        foreach ( player in level.players )
        {
            if ( player getspectatingplayer() == user )
            {
                player modifybasefov( level.ruby_telescope.defaultbasefov );
            }
        }
    }
    
    level.ruby_telescope.user = undefined;
    
    if ( level.ruby_telescope.mdl_viewpoint )
    {
        level.ruby_telescope.mdl_viewpoint delete();
    }
    
    enable_telescope();
    level callback::remove( #"player_disconnect", &function_a9cc832acf68890b );
    
    if ( level.ruby_telescope.uses_left <= 0 )
    {
        level.power_station setscriptablepartstate( "telescope_screens", "off" );
    }
    
    level notify( #"telescope_finish" );
}

// Namespace zm_sat_ruby_telescope
// Params 1, eflags: 0x4
// Checksum 0x707e8783, Offset: 0x1546
// Size: 0x3a
function private function_a35706e6ce2c736f( params )
{
    level.ruby_telescope.uses_left = 3;
    level.power_station setscriptablepartstate( "telescope_screens", "on" );
}

// Namespace zm_sat_ruby_telescope
// Params 3
// Checksum 0x974c170b, Offset: 0x1588
// Size: 0x10f
function function_b095db21aed570fe( target_ent, var_81fa525069d75529, var_ed100f9a07836d02 )
{
    target_ent.var_23d07a260ea5e8a8 = var_81fa525069d75529;
    level.ruby_telescope.var_320758f2946bf86[ level.ruby_telescope.var_320758f2946bf86.size ] = target_ent;
    
    if ( !isdefined( var_ed100f9a07836d02 ) )
    {
        do
        {
            s_target_pos = utility::array_random( level.ruby_telescope.a_target_positions );
        }
        while ( target_ent == level.ruby_wwq.m_sun && s_target_pos.script_noteworthy == "no_sun" );
        
        level.ruby_telescope.a_target_positions = arrayremove( level.ruby_telescope.a_target_positions, s_target_pos );
        target_ent.origin = s_target_pos.origin;
        target_ent.angles = s_target_pos.angles;
        return s_target_pos;
    }
}

// Namespace zm_sat_ruby_telescope
// Params 1
// Checksum 0x1b377fe1, Offset: 0x169f
// Size: 0x39
function function_b28785f5286548e3( target_ent )
{
    level.ruby_telescope.var_320758f2946bf86 = arrayremove( level.ruby_telescope.var_320758f2946bf86, target_ent );
}

// Namespace zm_sat_ruby_telescope
// Params 0
// Checksum 0xc0025cc8, Offset: 0x16e0
// Size: 0x3c
function enable_telescope()
{
    level.ruby_telescope.telescope_interact function_e203bba36cfb19d0();
    level.ruby_telescope.telescope_interact setscriptablepartstate( "base", "small" );
}

// Namespace zm_sat_ruby_telescope
// Params 0
// Checksum 0x238b329c, Offset: 0x1724
// Size: 0x3c
function disable_telescope()
{
    level.ruby_telescope.telescope_interact function_7653c765b6c7b815();
    level.ruby_telescope.telescope_interact setscriptablepartstate( "base", "off" );
}

// Namespace zm_sat_ruby_telescope
// Params 2
// Checksum 0x9aefb797, Offset: 0x1768
// Size: 0x9c
function function_e31deed3aaa2f253( horizontal_offset_range = 18, vertical_offset_range = 9 )
{
    horiz_offset = randomfloat( horizontal_offset_range * 2 ) - horizontal_offset_range;
    vert_offset = randomfloat( vertical_offset_range * 2 ) - vertical_offset_range;
    level.ruby_telescope.s_viewpoint.angles += ( vert_offset, horiz_offset, 0 );
}

// Namespace zm_sat_ruby_telescope
// Params 1, eflags: 0x4
// Checksum 0x4e4e154b, Offset: 0x180c
// Size: 0x26
function private function_a9cc832acf68890b( params )
{
    level.ruby_telescope.telescope_interact function_72b79a760dd653d6();
}

