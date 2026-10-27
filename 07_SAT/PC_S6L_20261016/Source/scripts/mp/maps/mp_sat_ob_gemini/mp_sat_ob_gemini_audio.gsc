// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio.gsc  (hash_43c85300b8ed694e.gscc) (size: 12066 Bytes / 0x2f22 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dd8c25e (2111357534)
// size ...... 12066 (0x2f22)
// includes .. 6   (offset: 0x2be6)
// strings ... 56  (offset: 0x2c16)
// dev strs .. 5   (offset: 0x2ee2)
// exports ... 57  (offset: 0x1abe)
// cseg ...... 0x970 + 0x114e (0x1abe)
// imports ... 67  (offset: 0x23a6)
// animtree1 . 0   (offset: 0x2f22)
// animtree2 . 0   (offset: 0x2f22)
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\snd\snd_ob;

#namespace gemini_audio;

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x47961e42, Offset: 0x98e
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xdc69e770, Offset: 0x9a5
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace gemini_audio
// Params 0
// Checksum 0x32a925fd, Offset: 0x9b7
// Size: 0x15
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
}

// Namespace gemini_audio
// Params 1
// Checksum 0x76f55a13, Offset: 0x9d4
// Size: 0x262
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_9c65a4dd72d8abc7":
            level thread tunnels_intro();
            break;
        case #"hash_7f3722ddacccc104":
            level thread tunnels_solitary();
            break;
        case #"hash_f3c55591d5ce90e4":
            level thread tunnels_prison();
            break;
        case #"hash_70c2615e22888bc":
            level thread tunnels_anteroom();
            break;
        case #"hash_e8adb619a75b4779":
            level thread tunnels_elevator();
            break;
        case #"hash_c2ad6e3455f95b8":
            level thread tunnels_mine();
            break;
        case #"hash_d944201f8498b214":
            level thread tunnels_pit();
            break;
        case #"hash_bf6341dbf0bba0e5":
            level thread cabin_intro();
            break;
        case #"hash_295d13929306aac1":
            level thread cabin_wilderness();
            break;
        case #"hash_4831369bbc1b460":
            level thread cabin_initialmemory();
            break;
        case #"hash_5baac7a341f0daa0":
            level thread cabin_memorycapture();
            break;
        case #"hash_f33114ae65b0826f":
            level thread cabin_barrage();
            break;
        case #"hash_1c00b95475691e21":
            level thread prison_intro();
            break;
        case #"hash_1d4ed3fc22611bb6":
            level thread prison_underground();
            break;
        case #"hash_48ba79e311336ed5":
            level thread prison_minecarts();
            break;
        case #"hash_1a49a358476a24a7":
            level thread prison_armory();
            break;
        case #"hash_f58d7e51fd19f307":
            level thread prison_topside();
            break;
        case #"hash_3c64121041b523f3":
            level thread prison_finalpush();
            break;
        case #"hash_6d0acfecca386654":
        case #"hash_6d0ad0ecca3867e7":
        case #"hash_6d0ad1ecca38697a":
            level thread prison_finalpush();
            break;
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_6d961012822f635":
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x67>" + start_point + "<dev string:x86>" );
            #/
            
            break;
    }
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x61ee1cdc, Offset: 0xc3e
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 2
// Checksum 0x391f7965, Offset: 0xc55
// Size: 0x71
function function_bae83c99ccccedec( player, music_state_name )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    snd::init_obj( player );
    
    if ( player.snd.music != music_state_name )
    {
        player.snd.music = music_state_name;
        player setplayermusicstate( music_state_name );
    }
    
    player notify( #"music_stop_for_player" );
}

// Namespace gemini_audio
// Params 1
// Checksum 0x9cb54d91, Offset: 0xcce
// Size: 0x5a
function music_stop_for_player( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"disconnect", #"music_stop_for_player" );
    player utility::delaythreadendon( 0.35, [ "disconnect", "music_stop_for_player" ], &function_bae83c99ccccedec, player, "" );
}

// Namespace gemini_audio
// Params 3, eflags: 0x4
// Checksum 0x38f29ada, Offset: 0xd30
// Size: 0x29d
function private function_9fca8438793eeefe( music_state_name, radius, radius_max )
{
    level endon( #"game_ended" );
    
    if ( isnumber( self.radius ) )
    {
        if ( !isdefined( radius ) )
        {
            radius = self.radius * 1.333;
        }
    }
    
    if ( !isdefined( radius_max ) )
    {
        radius_max = radius * 1.999;
    }
    
    players = [];
    
    while ( !self.complete )
    {
        var_b0d168f65ceabb62 = getplayersinradius( self.origin, radius, 120 );
        var_b0ae52f65cc44348 = getplayersinradius( self.origin, radius_max, 120 );
        new_players_inside = arrayremove( var_b0d168f65ceabb62, players );
        var_23715131718c8c61 = arrayremove( players, var_b0ae52f65cc44348 );
        
        foreach ( player in var_23715131718c8c61 )
        {
            music_stop_for_player( player );
        }
        
        foreach ( player in new_players_inside )
        {
            function_bae83c99ccccedec( player, music_state_name );
        }
        
        if ( new_players_inside.size > 0 || var_23715131718c8c61.size > 0 )
        {
            players = arraycombineunique( var_b0d168f65ceabb62, var_b0ae52f65cc44348 );
        }
        
        /#
            if ( snd::function_542b9fda0c23d8f4() > 0 )
            {
                if ( isnumber( radius ) )
                {
                    utility::draw_circle( self.origin, radius, ( 1, 1, 1 ), 1, 0, 1 );
                }
                
                if ( isnumber( radius_max ) )
                {
                    utility::draw_circle( self.origin, radius_max, ( 0.72974, 0.72974, 0.72974 ), 1, 0, 1 );
                }
            }
        #/
        
        waitframe();
    }
    
    foreach ( player in players )
    {
        function_bae83c99ccccedec( player, "" );
    }
}

// Namespace gemini_audio
// Params 4
// Checksum 0xbf7ba44f, Offset: 0xfd5
// Size: 0x53
function function_81c0c12f5aeeb3da( music_state_name, targetname, radius, radius_max )
{
    capture_zone = utility::getstruct( targetname );
    
    if ( !isstruct( capture_zone ) )
    {
        return;
    }
    
    capture_zone thread function_9fca8438793eeefe( music_state_name, radius, radius_max );
}

// Namespace gemini_audio
// Params 0
// Checksum 0x351c9d4b, Offset: 0x1030
// Size: 0x11d
function music_cabin_memorycapture()
{
    level endon( #"music_cabin_memorycapture" );
    
    if ( snd::did_once( "gemini_audio::music_cabin_memorycapture" ) )
    {
        return;
    }
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        msg = level utility::waittill_any_return( "OB_GEMINI_MCZ_CHECKPOINT_INITIAL_START", "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_START", "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_START", "OB_GEMINI_MCZ_CHECKPOINT_WOODS_START", "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
        
        if ( isstring( msg ) )
        {
            switch ( msg )
            {
                case #"hash_2810d42ae690f9a2":
                    function_81c0c12f5aeeb3da( "mx_gemini_firewood", "mcz_initial" );
                    break;
                case #"hash_792342144eb522a1":
                    function_81c0c12f5aeeb3da( "mx_gemini_firearms", "mcz_basement", 320, 640 );
                    break;
                case #"hash_9bfa86e34e9e0623":
                    function_81c0c12f5aeeb3da( "mx_gemini_climb_tree_lp", "mcz_cliffs", 480, 960 );
                    break;
                case #"hash_aa29e72c88fddac8":
                    function_81c0c12f5aeeb3da( "mx_gemini_fishing_lp", "mcz_woods", 224, 540 );
                    break;
                case #"hash_dfcdcef81729b0da":
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace gemini_audio
// Params 1
// Checksum 0xb7d5f655, Offset: 0x1155
// Size: 0x385
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "gemini_audio::music" ) )
    {
        return;
    }
    
    current_activity = snd_ob::get_active_current_activity();
    activity_players = snd::function_7a86238ee2359651( current_activity );
    squad = teams::function_72b89edf6b47c40a( activity_players[ 0 ] );
    start = current_activity.type;
    assert( isplayer( activity_players[ 0 ] ) );
    assert( snd::issquad( squad ) );
    
    switch ( start )
    {
        default:
            /#
                snd::function_7a77574e2157fbce( "<dev string:x88>" + start + "<dev string:x86>" );
            #/
        case #"hash_70c2615e22888bc":
        case #"hash_7f3722ddacccc104":
        case #"hash_9c65a4dd72d8abc7":
        case #"hash_e8adb619a75b4779":
        case #"hash_f3c55591d5ce90e4":
            snd_ob::squad_music_with_boost( squad, "mx_gemini_inmates_lp", 3, 95, 4, 16, 16 );
            utility::flag_wait( "flag_tunnels_elevator_descend_start" );
            snd_ob::squad_music_stop( squad );
            wait 2.08696;
        case #"hash_c2ad6e3455f95b8":
        case #"hash_d944201f8498b214":
            snd_ob::squad_music_with_boost( squad, "mx_gemini_hellevator_lp", 3, 115, 4, 16, 16 );
            utility::flag_wait( "flag_tunnels_pit_complete" );
            snd_ob::squad_music_stop( squad );
        case #"hash_295d13929306aac1":
        case #"hash_bf6341dbf0bba0e5":
            utility::flag_wait( "OB_GEMINI_CABIN_WILDERNESS_COMPLETE" );
        case #"hash_4831369bbc1b460":
        case #"hash_5baac7a341f0daa0":
            level thread music_cabin_memorycapture();
            utility::flag_wait( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
            level notify( #"music_cabin_memorycapture" );
        case #"hash_f33114ae65b0826f":
            utility::flag_wait( "flag_cabin_barrage_survive_start" );
            assert( isent( level.var_e4f5cda99101f31a ) );
            
            while ( true )
            {
                level.var_e4f5cda99101f31a waittill( #"started_saying", alias );
                
                if ( alias == "dx_wc_mini_gwar_papa_escapeisimpossible" )
                {
                    break;
                }
            }
            
            wait 3.80952;
            snd_ob::squad_music_with_boost( squad, "mx_gemini_escape_is_impossible_lp", 3, 126, 4, 16, 16 );
            utility::flag_wait( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
            snd_ob::squad_music_stop( squad );
        case #"hash_1c00b95475691e21":
            level utility::flag_wait( "flag_gemini_cabin_exit_igc_complete" );
        case #"hash_1a49a358476a24a7":
        case #"hash_1d4ed3fc22611bb6":
        case #"hash_48ba79e311336ed5":
        case #"hash_f58d7e51fd19f307":
            snd_ob::squad_music_with_boost( squad, "mx_gemini_prison_break_lp", 6, 150, 8, 16, 48 );
            utility::flag_wait( "flag_prison_topside_completed" );
            snd_ob::squad_music_stop( squad );
            wait 1.2;
        case #"hash_3c64121041b523f3":
            snd_ob::squad_music_with_boost( squad, "mx_gemini_raise_hell_lp", 3, 110, 2, 20, 40 );
            utility::flag_wait( "flag_gemini_exfil_igc_begin" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_gemini_exfil_igc_complete" );
        case #"hash_6d961012822f635":
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_6d0acfecca386654":
        case #"hash_6d0ad0ecca3867e7":
        case #"hash_6d0ad1ecca38697a":
            snd_ob::squad_music_with_boost( squad, "mx_gemini_raise_hell_lp", 3, 110, 2, 20, 40 );
            level utility::flag_wait( "flag_gemini_nm_complete" );
            break;
    }
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xc7695aec, Offset: 0x14e2
    // Size: 0xf, Type: dev
    function private function_ad2a58b2936d7994( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xcad13fc7, Offset: 0x14f9
// Size: 0x2
function tunnels_intro()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xc90b23e3, Offset: 0x1503
    // Size: 0xf, Type: dev
    function private function_8c8c128b7193d859( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xb52164da, Offset: 0x151a
// Size: 0x2
function tunnels_solitary()
{
    
}

// Namespace gemini_audio
// Params 1
// Checksum 0x299818b9, Offset: 0x1524
// Size: 0x105
function vortex_drone_audio( str_wing )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level.var_e7d791cad068265b = undefined;
    level.var_e81592cad0accc50 = undefined;
    
    if ( str_wing == "grn" )
    {
        if ( !isdefined( level.var_e7d791cad068265b ) )
        {
            level.var_e7d791cad068265b = snd::play( "amb_emt_gem_nm_horror_drone_lp", ( 11374, -8706, 183 ) );
        }
    }
    else if ( !isdefined( level.var_e81592cad0accc50 ) )
    {
        level.var_e81592cad0accc50 = snd::play( "amb_emt_gem_nm_horror_drone_lp", ( 5143, -8174, 219 ) );
    }
    
    level utility::flag_wait( "flag_tunnels_elevator_descend_start" );
    
    if ( isdefined( level.var_e7d791cad068265b ) )
    {
        snd::stop( level.var_e7d791cad068265b, 1 );
        level.var_e7d791cad068265b = undefined;
    }
    
    if ( isdefined( level.var_e81592cad0accc50 ) )
    {
        snd::stop( level.var_e81592cad0accc50, 1 );
        level.var_e81592cad0accc50 = undefined;
    }
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x7905ab43, Offset: 0x1631
    // Size: 0xf, Type: dev
    function private function_74f18539998286f5( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x4f3df2ae, Offset: 0x1648
// Size: 0x2
function tunnels_prison()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8693ef95, Offset: 0x1652
    // Size: 0xf, Type: dev
    function private function_817c4a0251c740e9( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xcdfefe78, Offset: 0x1669
// Size: 0x2
function tunnels_anteroom()
{
    
}

// Namespace gemini_audio
// Params 1
// Checksum 0x7258a03f, Offset: 0x1673
// Size: 0x23
function play_zombie_vox( scene_flag_wait )
{
    level utility::flag_wait( scene_flag_wait );
    snd::play( "evt_gem_stalker_vox", self );
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xf58507e6, Offset: 0x169e
    // Size: 0xf, Type: dev
    function private function_bf24f2c65a70d380( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xee3664d2, Offset: 0x16b5
// Size: 0x2
function tunnels_elevator()
{
    
}

// Namespace gemini_audio
// Params 0
// Checksum 0x1323346f, Offset: 0x16bf
// Size: 0x3d
function function_9adf1cb798d0abfa()
{
    thread tunnels_elevator_ride();
    self playsound( "evt_gem_elevator_approach" );
    utility::flag_wait( "flag_audio_tunnels_elevator_buzzer" );
    wait 0.5;
    playsoundatpos( ( 3925, -2337, 124 ), "evt_gem_elevator_start_buzzer" );
}

// Namespace gemini_audio
// Params 0
// Checksum 0xbd93e52e, Offset: 0x1704
// Size: 0xd
function function_e00d321a9acc907e()
{
    self playsound( "evt_gem_elevator_outer_door_open" );
}

// Namespace gemini_audio
// Params 0
// Checksum 0xc913d452, Offset: 0x1719
// Size: 0xd
function function_3699c6ca13116af3()
{
    self playsound( "evt_gem_elevator_inner_door_open" );
}

// Namespace gemini_audio
// Params 0
// Checksum 0x1f93730e, Offset: 0x172e
// Size: 0x43
function tunnels_elevator_ride()
{
    level utility::flag_wait( "flag_tunnels_elevator_descend_start" );
    wait 1;
    self playsound( "evt_gem_elevator_ride_lr" );
    utility::flag_wait( "flag_tunnels_elevator_descend_end" );
    playsoundatpos( ( 3923, -721, -520 ), "evt_gem_elevator_start_buzzer" );
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xcf762605, Offset: 0x1779
    // Size: 0xf, Type: dev
    function private function_ea0672613932eaa9( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x80256cec, Offset: 0x1790
// Size: 0x2
function tunnels_mine()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xcfb32a1a, Offset: 0x179a
    // Size: 0xf, Type: dev
    function private function_605b376ef8bc4303( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xfb9c3115, Offset: 0x17b1
// Size: 0x2
function tunnels_pit()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x6dc56d61, Offset: 0x17bb
    // Size: 0xf, Type: dev
    function private function_e50f27cdffd1d24a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x7891a076, Offset: 0x17d2
// Size: 0x2
function cabin_intro()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x1bb7f530, Offset: 0x17dc
    // Size: 0xf, Type: dev
    function private function_2b6d09c343d5a7cc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xf57d1807, Offset: 0x17f3
// Size: 0x2
function cabin_wilderness()
{
    
}

// Namespace gemini_audio
// Params 1
// Checksum 0xedd0188f, Offset: 0x17fd
// Size: 0x1a
function function_51520bf7b4d235e2( e_vtol )
{
    snd::play( "evt_chi_gem_vtol_takeoff", e_vtol );
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xab1a5d0a, Offset: 0x181f
    // Size: 0xf, Type: dev
    function private function_c54f30cb954e38af( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x433e28fc, Offset: 0x1836
// Size: 0x2
function cabin_initialmemory()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x123c3194, Offset: 0x1840
    // Size: 0xf, Type: dev
    function private function_2e5c05efa215ee43( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x1d62d357, Offset: 0x1857
// Size: 0x2
function cabin_memorycapture()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x1182430, Offset: 0x1861
    // Size: 0xf, Type: dev
    function private function_6ba8fa117527135c( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x52c1dbb9, Offset: 0x1878
// Size: 0x2
function cabin_barrage()
{
    
}

// Namespace gemini_audio
// Params 0
// Checksum 0xd64a32e3, Offset: 0x1882
// Size: 0xcb
function cabin_barrage_vox()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "flag_cabin_barrage_wave1_begin" );
    snd::play( "evt_gem_cabin_barrage_wave1_vox", ( 49057, 1678, 414 ) );
    level utility::flag_wait( "flag_cabin_barrage_wave2_begin" );
    snd::play( "evt_gem_cabin_barrage_wave2_vox", ( 49976, -4260, 193 ) );
    level utility::flag_wait( "flag_cabin_barrage_flood_begin" );
    snd::play( "evt_gem_cabin_barrage_flood_vox", ( 49057, 1678, 414 ) );
    snd::play( "evt_gem_cabin_barrage_flood_vox", ( 49976, -4260, 193 ) );
    snd::play( "evt_gem_cabin_barrage_flood_vox", ( 46710, -722, 604 ) );
    snd::play( "evt_gem_cabin_barrage_flood_vox", ( 51120, -1065, 392 ) );
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xd73fa385, Offset: 0x1955
    // Size: 0xf, Type: dev
    function private function_b59d6231aa7850e4( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x4df2524b, Offset: 0x196c
// Size: 0x2
function prison_intro()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xdb63d3f5, Offset: 0x1976
    // Size: 0xf, Type: dev
    function private function_e6dc720f2bc445df( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x9a046a45, Offset: 0x198d
// Size: 0x2
function prison_underground()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x3b9cc352, Offset: 0x1997
    // Size: 0xf, Type: dev
    function private function_82fd60aee5aec708( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x62918aab, Offset: 0x19ae
// Size: 0x2
function prison_minecarts()
{
    
}

// Namespace gemini_audio
// Params 0
// Checksum 0xf98045a4, Offset: 0x19b8
// Size: 0xa3
function minecart_audio()
{
    while ( !isdefined( self.mover_object ) || !isdefined( self.zombie ) )
    {
        wait 0.1;
    }
    
    snd::play( "evt_sat_gem_minecart_start", self.mover_object );
    minecart_sfx = snd::play( "evt_sat_gem_minecart_lp", self.mover_object );
    self.zombie utility::waittill_any( "NOTIFY_PRISON_MINECARTS_ANIMATION_COMPLETE", "NOTIFY_PRISON_MINECARTS_CANCEL_MINECART_ANIMATION" );
    snd::play( "evt_sat_gem_minecart_stop", self.mover_object );
    snd::stop( minecart_sfx, 0.25 );
    wait 0.5;
    minecart_sfx = undefined;
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0xccab6c07, Offset: 0x1a63
    // Size: 0xf, Type: dev
    function private function_40792acdbe3baaf8( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0x85dfeb6e, Offset: 0x1a7a
// Size: 0x2
function prison_armory()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x487b6d7f, Offset: 0x1a84
    // Size: 0xf, Type: dev
    function private function_9920a988bf7ec54e( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xb2dccbae, Offset: 0x1a9b
// Size: 0x2
function prison_topside()
{
    
}

/#

    // Namespace gemini_audio
    // Params 1, eflags: 0x4
    // Checksum 0x75848a4a, Offset: 0x1aa5
    // Size: 0xf, Type: dev
    function private function_9101423ea84bde16( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace gemini_audio
// Params 0
// Checksum 0xd1cbb8e5, Offset: 0x1abc
// Size: 0x2
function prison_finalpush()
{
    
}

