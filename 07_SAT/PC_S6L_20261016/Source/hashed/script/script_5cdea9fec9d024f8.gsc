// script_5cdea9fec9d024f8  (hash_5cdea9fec9d024f8.gscc) (size: 8777 Bytes / 0x2249 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4adf4a6a (1256147562)
// size ...... 8777 (0x2249)
// includes .. 8   (offset: 0x2045)
// strings ... 26  (offset: 0x2085)
// dev strs .. 6   (offset: 0x21ed)
// exports ... 16  (offset: 0x1581)
// cseg ...... 0x257 + 0x132a (0x1581)
// imports ... 71  (offset: 0x1801)
// animtree1 . 0   (offset: 0x2249)
// animtree2 . 0   (offset: 0x2249)
#using script_4382611bb6bbf2a0;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_6f62bde560f47748;

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0xcee724fd, Offset: 0x275
// Size: 0x174
function init_hopscotch_game()
{
    if ( !isdefined( level.s_hopscotch_game ) )
    {
        level.s_hopscotch_game = spawnstruct();
    }
    
    if ( !isdefined( level.s_hopscotch_game.var_d7471cf7f600bf44 ) )
    {
        level.s_hopscotch_game.var_d7471cf7f600bf44 = utility::getstruct( "hopscotch_start_pos", "targetname" );
    }
    
    if ( !isdefined( level.s_hopscotch_game.var_fa795a9c34416db2 ) )
    {
        level.s_hopscotch_game.var_fa795a9c34416db2 = utility::getstruct( "hopscotch_center", "targetname" );
    }
    
    level.s_hopscotch_game.interaction = zm_quest::function_91f9590e98d57ff6( level.s_hopscotch_game.var_d7471cf7f600bf44.origin, &on_start_hopscotch_game, &hint_start_hopscotch_game );
    level.s_hopscotch_game.sbl = spawnscriptable( level.s_hopscotch_game.var_d7471cf7f600bf44.script_noteworthy, level.s_hopscotch_game.var_d7471cf7f600bf44.origin, level.s_hopscotch_game.var_d7471cf7f600bf44.angles );
    level.s_hopscotch_game.sbl utility::function_7c10ea82c1e305b8( "base", "play" );
    function_6354ff37229896d7();
    
    /#
        function_802388fa3789fd79();
    #/
}

/#

    // Namespace namespace_6f62bde560f47748
    // Params 0
    // Checksum 0x263e4604, Offset: 0x3f1
    // Size: 0xde, Type: dev
    function function_802388fa3789fd79()
    {
        level endon( #"game_ended" );
        level endon( #"hopscotch_game_start" );
        
        while ( true )
        {
            if ( isdefined( level.s_hopscotch_game.obb_info ) )
            {
                foreach ( var_6271e36734e22cd3 in level.s_hopscotch_game.obb_info )
                {
                    level thread utility::draw_circle( var_6271e36734e22cd3.center, 10, ( 1, 0, 0 ), 1, 0, 100 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_6f62bde560f47748
    // Params 0
    // Checksum 0x98958078, Offset: 0x4d7
    // Size: 0xf2, Type: dev
    function function_e76515b906525ba7()
    {
        level endon( #"game_ended" );
        level endon( #"hopscotch_game_completed" );
        
        while ( true )
        {
            foreach ( aabb_center in level.s_hopscotch_game.obb_info )
            {
                level thread function_6996ff7fb25c9b41( aabb_center.center, 37.5 );
                print3d( aabb_center.center, string( aabb_center.index ), ( 1, 0, 0 ), 1, 0.3, 50, 1 );
                waitframe();
            }
            
            wait 1;
        }
    }

    // Namespace namespace_6f62bde560f47748
    // Params 2
    // Checksum 0x3a61a69e, Offset: 0x5d1
    // Size: 0x147, Type: dev
    function function_6996ff7fb25c9b41( aabb_center, var_23db0ba90da1297c )
    {
        v_forward = anglestoforward( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
        var_1797ef2d4e032c54 = anglestoleft( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
        v_right = anglestoright( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
        vector1 = aabb_center + v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c;
        vector2 = aabb_center + v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c;
        vector3 = aabb_center - v_forward * var_23db0ba90da1297c + var_1797ef2d4e032c54 * var_23db0ba90da1297c;
        var_581ea6790791c7c7 = aabb_center - v_forward * var_23db0ba90da1297c + v_right * var_23db0ba90da1297c;
        level thread utility::draw_line_for_time( vector1, vector2, 1, 0, 0, 50, "<dev string:x24>" );
        level thread utility::draw_line_for_time( vector2, vector3, 1, 0, 0, 50, "<dev string:x24>" );
        level thread utility::draw_line_for_time( var_581ea6790791c7c7, vector3, 1, 0, 0, 50, "<dev string:x24>" );
        level thread utility::draw_line_for_time( vector1, var_581ea6790791c7c7, 1, 0, 0, 50, "<dev string:x24>" );
    }

#/

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0x84d9512a, Offset: 0x720
// Size: 0x26f
function function_6354ff37229896d7()
{
    if ( isdefined( level.s_hopscotch_game.obb_info ) )
    {
        return;
    }
    
    if ( !isdefined( level.s_hopscotch_game.obb_info ) )
    {
        level.s_hopscotch_game.obb_info = [];
    }
    
    obb_info = level.s_hopscotch_game.obb_info;
    v_forward = anglestoforward( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
    var_1797ef2d4e032c54 = anglestoleft( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
    v_right = anglestoright( level.s_hopscotch_game.var_fa795a9c34416db2.angles );
    
    for ( i = 1; i <= 12 ; i++ )
    {
        if ( !isdefined( level.s_hopscotch_game.obb_info[ i ] ) )
        {
            level.s_hopscotch_game.obb_info[ i ] = spawnstruct();
        }
        
        if ( i == 1 )
        {
            obb_info[ i ].center = level.s_hopscotch_game.var_fa795a9c34416db2.origin + v_forward * 75 * ( i - 1 );
        }
        else if ( i == 12 )
        {
            obb_info[ i ].center = level.s_hopscotch_game.var_fa795a9c34416db2.origin + v_forward * 75 * int( i / 2 );
        }
        else if ( i % 2 == 0 )
        {
            obb_info[ i ].center = level.s_hopscotch_game.var_fa795a9c34416db2.origin + v_forward * 75 * int( i / 2 ) + var_1797ef2d4e032c54 * 37.5;
        }
        else if ( i % 2 == 1 )
        {
            obb_info[ i ].center = level.s_hopscotch_game.var_fa795a9c34416db2.origin + v_forward * 75 * int( i / 2 ) + v_right * 37.5;
        }
        
        obb_info[ i ].index = i;
    }
}

// Namespace namespace_6f62bde560f47748
// Params 2
// Checksum 0x3f5d5df0, Offset: 0x997
// Size: 0xbd
function hint_start_hopscotch_game( instance, player )
{
    if ( !zm_quest::function_f98968f17772726c() || player get_obb_index() != 1 || !zm_quest::function_b0a5181ebe7bb905() || player.ismutantinjection )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_mantis/maintis_minigame_btn", #description:&"zm_sat_mantis/maintis_minigame_des", #title:&"zm_sat_mantis/maintis_minigame_tile", #type:"HINT_BUTTON" };
}

// Namespace namespace_6f62bde560f47748
// Params 1
// Checksum 0x9192f8aa, Offset: 0xa5d
// Size: 0xb1
function on_start_hopscotch_game( player )
{
    if ( !zm_quest::function_f98968f17772726c() )
    {
        return;
    }
    
    if ( player get_obb_index() != 1 )
    {
        return;
    }
    
    if ( player.ismutantinjection )
    {
        return;
    }
    
    level.s_hopscotch_game.activator = player;
    
    if ( !level.s_hopscotch_game.b_played_banter )
    {
        level.s_hopscotch_game.b_played_banter = 1;
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"start_hopscotch", #"bc_flavor_player_positive" );
    }
    
    level utility::flag_set( "progressing_mini_games" );
    zm_sat_mantis_quest_mq::function_4ef47d3c5c627fb6();
    level thread start_hopscotch_game( player );
}

// Namespace namespace_6f62bde560f47748
// Params 1
// Checksum 0x68ad1fdb, Offset: 0xb16
// Size: 0x211
function start_hopscotch_game( player )
{
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"disable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"disable" );
    }
    
    level val::set( "tasks_hopscotch", "task_logic_activate", 0 );
    level.s_hopscotch_game.interaction zm_quest::function_9170db4686f796e2();
    level.s_hopscotch_game.sound_sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_mq_child_game_sound", level.s_hopscotch_game.var_fa795a9c34416db2.origin );
    level notify( #"hopscotch_game_start" );
    level thread zm_music::start_zone_music_watcher( "hop_game_music", [ "zone_street_3_p", "zone_street_4_p", "zone_street_6_p", "zone_street_1_p" ], #"hash_45407f5a18fefe7" );
    
    if ( player getcamerathirdperson() )
    {
        player.var_1ce3a5123b8daa9d = 1;
    }
    else
    {
        player.var_1ce3a5123b8daa9d = 0;
        player setcamerathirdperson( 1 );
    }
    
    player val::set( "hopscotch_active", "allow_toggle_third_person", 0 );
    level thread function_69af76e7678a2c30();
    level.s_hopscotch_game.navobstacle = createnavbadplacebybounds( ( 76566, -31870, -124 ), ( 250, 75, 0 ), ( 0, 135, 0 ) );
    
    /#
        level thread function_e76515b906525ba7();
    #/
    
    player val::set( "hopscotch_active", "ignoreme", 1 );
    
    if ( isdefined( level.s_hopscotch_game.sbl ) )
    {
        level.s_hopscotch_game.sbl freescriptable();
    }
    
    level.s_hopscotch_game.sound_sbl utility::function_7c10ea82c1e305b8( "laughter_sound", "playing" );
    player thread function_f0c45cd0a1e81afc();
    level thread hopscotch_game_timeout();
    level thread function_c68281967309573( player );
    level thread function_566b7c9c9f9b536f( player );
}

// Namespace namespace_6f62bde560f47748
// Params 1
// Checksum 0x739df4c3, Offset: 0xd2f
// Size: 0x202
function function_566b7c9c9f9b536f( player )
{
    level endon( #"game_ended" );
    level waittill( #"hopscotch_game_completed", b_success );
    level thread zm_music::function_e9fd14ede793ef0d( "hop_game_music" );
    level.s_hopscotch_game.sound_sbl freescriptable();
    
    if ( !b_success )
    {
        if ( !level.s_hopscotch_game.var_6f783d42b80c3b4b )
        {
            level.s_hopscotch_game.var_6f783d42b80c3b4b = 1;
            level utility::delaythread( 0.5, &zm_quest::function_d5ef98341fd6a057, [ #"hash_bcbc98e533ed8e8b", #"hash_bcbc99e533ed903e", #"hash_bcbc9ae533ed91f1" ] );
        }
    }
    
    if ( isdefined( level.s_hopscotch_game.var_908d337ab4e37f2e ) )
    {
        level.s_hopscotch_game.var_908d337ab4e37f2e delete();
    }
    
    if ( utility::issharedfuncdefined( #"sat_timetravel", #"enable" ) )
    {
        utility::callsharedfunc( #"sat_timetravel", #"enable" );
    }
    
    if ( level.s_hopscotch_game.navobstacle )
    {
        destroynavobstacle( level.s_hopscotch_game.navobstacle );
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player utility::delaythread( 2, &val::reset, "hopscotch_active", "ignoreme" );
    level val::reset( "tasks_hopscotch", "task_logic_activate" );
    player val::reset( "hopscotch_active", "allow_toggle_third_person" );
    
    if ( !player.var_1ce3a5123b8daa9d )
    {
        if ( player.disable_third_person_toggle )
        {
            if ( player.ismutantinjection && player.micontext )
            {
                player.micontext.var_5828aa3111d7fa78 = 0;
            }
        }
        else
        {
            player setcamerathirdperson( 0 );
        }
    }
    
    player.var_1ce3a5123b8daa9d = undefined;
}

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0xb9505b7f, Offset: 0xf39
// Size: 0x2a
function hopscotch_game_timeout()
{
    level endon( #"game_ended" );
    level endon( #"hopscotch_game_completed" );
    wait 120;
    level notify( #"hopscotch_game_completed", 0 );
}

// Namespace namespace_6f62bde560f47748
// Params 1
// Checksum 0xd8eca4e2, Offset: 0xf6b
// Size: 0x211
function function_c68281967309573( player )
{
    level endon( #"game_ended" );
    level endon( #"hopscotch_game_completed" );
    
    if ( !isdefined( level.s_hopscotch_game.obb_info ) )
    {
        return;
    }
    
    level.s_hopscotch_game.var_73453026cc0d5e49 = level.s_hopscotch_game.obb_info.size;
    
    if ( isdefined( level.s_hopscotch_game.var_908d337ab4e37f2e ) )
    {
        level.s_hopscotch_game.var_908d337ab4e37f2e delete();
    }
    
    level.s_hopscotch_game.var_8b22718377607e46 = gettime();
    
    while ( true )
    {
        if ( isdefined( player ) )
        {
            player playrumbleonentity( "damage_light" );
        }
        
        var_3ca0b5660abea2a0 = level.s_hopscotch_game.obb_info[ level.s_hopscotch_game.var_73453026cc0d5e49 ].center;
        level.s_hopscotch_game.var_908d337ab4e37f2e = utility::spawn_model( "tag_origin", var_3ca0b5660abea2a0, ( 0, 45, 0 ) );
        playfxontag( level._effect[ "hopscotch_bad_cell" ], level.s_hopscotch_game.var_908d337ab4e37f2e, "tag_origin" );
        wait 1;
        stopfxontag( level._effect[ "hopscotch_bad_cell" ], level.s_hopscotch_game.var_908d337ab4e37f2e, "tag_origin" );
        level.s_hopscotch_game.var_908d337ab4e37f2e delete();
        
        if ( level.s_hopscotch_game.var_73453026cc0d5e49 == 1 )
        {
            level.s_hopscotch_game.var_73453026cc0d5e49 = level.s_hopscotch_game.obb_info.size;
        }
        
        level.s_hopscotch_game.var_73453026cc0d5e49--;
        level.s_hopscotch_game.var_8b22718377607e46 = gettime();
    }
}

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0x34d0639b, Offset: 0x1184
// Size: 0x235
function function_f0c45cd0a1e81afc()
{
    level endon( #"game_ended" );
    level endon( #"hopscotch_game_completed" );
    self endon( #"death_or_disconnect" );
    var_f15d6fca52776008 = get_obb_index();
    self.var_a982f5f9bfb8cad4 = 0;
    var_a95527904ce5e02f = 0;
    
    while ( true )
    {
        if ( !self.var_a982f5f9bfb8cad4 )
        {
            var_ea7532e1a9196547 = get_obb_index();
            
            if ( var_ea7532e1a9196547 != -1 && var_ea7532e1a9196547 == 1 )
            {
                self.var_a982f5f9bfb8cad4 = 1;
                var_f15d6fca52776008 = 1;
                
                /#
                    iprintlnbold( "<dev string:x2f>" );
                #/
            }
            
            waitframe();
            continue;
        }
        else
        {
            var_1d9b95212777dc32 = get_obb_index();
            
            if ( var_1d9b95212777dc32 == -1 )
            {
                /#
                    iprintlnbold( "<dev string:x44>" + var_1d9b95212777dc32 );
                #/
                
                level notify( #"hopscotch_game_completed", 0 );
                break;
            }
            
            if ( var_1d9b95212777dc32 == level.s_hopscotch_game.var_73453026cc0d5e49 && self isonground() )
            {
                var_f3a87081845b3c3e = utility::time_has_passed( level.s_hopscotch_game.var_8b22718377607e46, 0.5 );
                
                if ( var_f3a87081845b3c3e )
                {
                    /#
                        iprintlnbold( "<dev string:x44>" + var_1d9b95212777dc32 );
                    #/
                    
                    level notify( #"hopscotch_game_completed", 0 );
                    break;
                }
            }
        }
        
        if ( self isjumping() )
        {
            while ( !self isonground() )
            {
                waitframe();
            }
            
            var_ea7532e1a9196547 = get_obb_index();
            
            if ( var_ea7532e1a9196547 != var_f15d6fca52776008 )
            {
                if ( abs( var_ea7532e1a9196547 - var_f15d6fca52776008 ) == 1 && function_10f1d9f658b65c31( var_a95527904ce5e02f, var_ea7532e1a9196547, var_f15d6fca52776008 ) )
                {
                    var_f15d6fca52776008 = var_ea7532e1a9196547;
                    
                    /#
                        iprintlnbold( "<dev string:x5a>" + var_ea7532e1a9196547 );
                    #/
                    
                    if ( var_ea7532e1a9196547 == 1 && var_a95527904ce5e02f )
                    {
                        /#
                            iprintlnbold( "<dev string:x63>" );
                        #/
                        
                        level notify( #"hopscotch_game_completed", 1 );
                        break;
                    }
                    
                    if ( var_ea7532e1a9196547 == 12 )
                    {
                        var_a95527904ce5e02f = 1;
                    }
                }
                else
                {
                    /#
                        iprintlnbold( "<dev string:x44>" + var_ea7532e1a9196547 );
                    #/
                    
                    level notify( #"hopscotch_game_completed", 0 );
                    break;
                }
            }
        }
        else if ( var_ea7532e1a9196547 != get_obb_index() )
        {
            /#
                iprintlnbold( "<dev string:x7c>" + get_obb_index() );
            #/
            
            level notify( #"hopscotch_game_completed", 0 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_6f62bde560f47748
// Params 3
// Checksum 0x19ec67, Offset: 0x13c1
// Size: 0x30
function function_10f1d9f658b65c31( var_a95527904ce5e02f, var_ea7532e1a9196547, var_f15d6fca52776008 )
{
    if ( var_a95527904ce5e02f )
    {
        return ( var_f15d6fca52776008 > var_ea7532e1a9196547 );
    }
    
    return var_f15d6fca52776008 < var_ea7532e1a9196547;
}

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0x72f0d3b1, Offset: 0x13f9
// Size: 0xcc
function get_obb_index()
{
    foreach ( obb_info in level.s_hopscotch_game.obb_info )
    {
        if ( namespace_3424894d82205bda::function_cd0ac729c8f775e1( self.origin, obb_info.center, 37.5, level.s_hopscotch_game.var_fa795a9c34416db2.angles[ 1 ] ) )
        {
            return obb_info.index;
        }
    }
    
    return -1;
}

// Namespace namespace_6f62bde560f47748
// Params 0
// Checksum 0x86f857e8, Offset: 0x14ce
// Size: 0xb3
function function_69af76e7678a2c30()
{
    level endon( #"game_ended" );
    a_zombies = getaiarrayinradius( ( 76566, -31870, -124 ), 150, "team_two_hundred" );
    
    foreach ( zombie in a_zombies )
    {
        zombie thread zombie_knockdown::function_6fc167d4a3590991( ( 76566, -31870, -124 ), 300 );
        waitframe();
    }
}

