// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio.gsc  (hash_649acf13139d8d50.gscc) (size: 11516 Bytes / 0x2cfc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90d8922e (2430112302)
// size ...... 11516 (0x2cfc)
// includes .. 7   (offset: 0x28e4)
// strings ... 71  (offset: 0x291c)
// dev strs .. 5   (offset: 0x2cbc)
// exports ... 47  (offset: 0x1b4c)
// cseg ...... 0xc01 + 0xf4b (0x1b4c)
// imports ... 46  (offset: 0x22a4)
// animtree1 . 0   (offset: 0x2cfc)
// animtree2 . 0   (offset: 0x2cfc)
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\snd\snd_ob;

#namespace capricorn_audio;

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0xdf85a6e2, Offset: 0xc1f
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 0
// Checksum 0xdd8fce1, Offset: 0xc36
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xd36e968c, Offset: 0xc48
// Size: 0x1c
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
    function_ffd9703f7faa0b76();
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x59f79350, Offset: 0xc6c
// Size: 0x1b2
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_525bc73e3e444835":
        case #"hash_549d1d5505de2c52":
        case #"hash_81d8b8dafba06929":
        case #"hash_8720a935265d0d5f":
            level thread hijack();
            break;
        case #"hash_4f98713871a79664":
        case #"hash_5ca0050b592acd9b":
        case #"hash_5ca0060b592acf2e":
        case #"hash_6f01176b6b24737a":
        case #"hash_8b3c8ca43cfb331c":
        case #"hash_b56e4ee817ff7b0c":
        case #"hash_d1556795f64d8f5b":
        case #"hash_dda68f0ca89dccbc":
            level thread forge();
            break;
        case #"hash_471b81705f3a6ae1":
            level thread chase();
            break;
        case #"hash_1e424b137ea94b25":
        case #"hash_6d0cf6e06145d40b":
        case #"hash_7f5d1c930c951cf4":
        case #"hash_8f798b6ea2c0c2de":
            level thread roji();
            break;
        case #"hash_6d1d25e06152e9fb":
        case #"hash_889749ce037e1c86":
            level thread roof( start_point );
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

// Namespace capricorn_audio
// Params 0
// Checksum 0x68089164, Offset: 0xe26
// Size: 0x2
function function_ffd9703f7faa0b76()
{
    
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0xf9fda47c, Offset: 0xe30
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 2, eflags: 0x4
// Checksum 0x904f0c93, Offset: 0xe47
// Size: 0x80
function private function_a800759e29404fb3( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music( squad, "mx_capricorn_yacht_stealth_lp" );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music( squad, "mx_capricorn_yacht_combat_lp" );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x82c1f66f, Offset: 0xecf
// Size: 0x377
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "capricorn_audio::music" ) )
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
        case #"hash_170d85383e7762b5":
            utility::flag_wait( "flag_capricorn_infil_completed" );
        case #"hash_525bc73e3e444835":
        case #"hash_81d8b8dafba06929":
            snd_ob::squad_combat_state( squad, &function_a800759e29404fb3 );
            utility::waittill_any( "cap_igc_started" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_igc_music( squad, "mx_capricorn_dead_escort" );
        case #"hash_8720a935265d0d5f":
            while ( !isdefined( level.var_cfabb5f5e2963e56 ) )
            {
                waitframe();
            }
            
            snd_ob::squad_music( squad, "mx_capricorn_yacht_combat_lp" );
        case #"hash_549d1d5505de2c52":
            snd_ob::squad_music( squad, "mx_capricorn_miniboss_lp" );
            utility::flag_wait( "flag_computer_throttle_begin" );
            wait 1;
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "forge_crash_cinematic_completed" );
        case #"hash_5ca0050b592acd9b":
        case #"hash_5ca0060b592acf2e":
        case #"hash_8b3c8ca43cfb331c":
        case #"hash_b56e4ee817ff7b0c":
            snd_ob::squad_music( squad, "mx_capricorn_lockdown_combat_lp" );
            utility::flag_wait( "flag_forge_restricted_elevator" );
        case #"hash_4f98713871a79664":
        case #"hash_d1556795f64d8f5b":
            snd_ob::squad_music( squad, "mx_capricorn_reach_the_computer_lp" );
            utility::flag_wait( "flag_restricted_quantum_computer_interact_completed" );
            snd_ob::squad_music( squad, "mx_capricorn_objective_complete" );
            utility::flag_wait( "flag_restricted_area_twin_drive_acquired" );
        case #"hash_1e424b137ea94b25":
        case #"hash_471b81705f3a6ae1":
        case #"hash_6d0cf6e06145d40b":
        case #"hash_6f01176b6b24737a":
        case #"hash_7f5d1c930c951cf4":
        case #"hash_8f798b6ea2c0c2de":
        case #"hash_dda68f0ca89dccbc":
            snd_ob::squad_music( squad, "mx_capricorn_garage_escape_lp" );
            utility::flag_wait( "roji_roof_elevator_interact_inside_done" );
            snd_ob::squad_music_stop( squad );
        case #"hash_6d1d25e06152e9fb":
            utility::flag_wait( "elevator_reached_roof" );
            utility::flag_wait( "flag_roof_gunship_first_appearance" );
            wait 8;
        case #"hash_889749ce037e1c86":
            snd_ob::squad_music_with_boost( squad, "mx_capricorn_skyline_combat_lp", 3, 118, 4, 16, 32 );
            utility::flag_wait( "flag_vo_emp_planting" );
            snd_ob::squad_music_with_boost( squad, "mx_capricorn_skyline_emp_defend_lp", 3, 118, 2, 4, 16 );
            utility::flag_wait( "flag_audio_emp_explode" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_start_crash_anim" );
            wait 1.8;
            snd_ob::squad_music_with_boost( squad, "mx_capricorn_skyline_exfil_lp", 4, 118, 4, 4, 16 );
            utility::flag_wait( "flag_vo_roof_exfil" );
            wait 4.5;
            snd_ob::squad_music_stop( squad );
        case #"hash_6d961012822f635":
        case #"hash_3dd1b0578ff495b1":
            break;
    }
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xc2013162, Offset: 0x124e
// Size: 0x6b
function function_959c14409cd93823( alias )
{
    level notify( #"cap_igc_started" );
    audiostruct = spawnstruct();
    audiostruct.audioobj = snd::play( alias, audiostruct.entity );
    level utility::waittill_any( "flag_igc_ended", "scene_skip_fade_start" );
    snd::stop( audiostruct.audioobj );
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0xbca7130, Offset: 0x12c1
    // Size: 0xf, Type: dev
    function private function_aff84df1540f582e( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 0
// Checksum 0x73289434, Offset: 0x12d8
// Size: 0x2
function hijack()
{
    
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xb7793ee, Offset: 0x12e2
// Size: 0x4a
function function_b259141b5aa7eeee()
{
    level endon( #"game_ended" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_hijack_start_music_duck" );
    level utility::waittill_any( "hijack_stealth_lost", "flag_hijack_hatch_opened" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_hijack_start_music_duck" );
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8426101e, Offset: 0x1334
    // Size: 0xf, Type: dev
    function private function_86fa82510710c7d9( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 0
// Checksum 0xc855dd74, Offset: 0x134b
// Size: 0x2
function forge()
{
    
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x8487c65e, Offset: 0x1355
// Size: 0xd4
function function_651013b66eeaa979()
{
    level endon( #"hash_e9d8f99b4699a0e2" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 4;
        snd::play( "emt_forge_alarm_indu", ( -6837, -25377, 939 ) );
        snd::play( "emt_forge_alarm_indu", ( -7515, -26288, 783 ) );
        snd::play( "emt_forge_alarm_indu", ( -7483, -24528, 761 ) );
        snd::play( "emt_forge_alarm_corp", ( -7877, -23277, 851 ) );
        snd::play( "emt_forge_alarm_corp", ( -6730, -23720, 833 ) );
        snd::play( "emt_forge_alarm_corp", ( -5970, -22666, 825 ) );
        snd::play( "emt_forge_alarm_corp", ( -5702, -23302, 914 ) );
    }
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xfa6c3f39, Offset: 0x1431
// Size: 0x54
function function_7a41d84cc84c11e2()
{
    level endon( #"game_ended" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_restricted_area_start_music_duck", 6 );
    level utility::waittill_any( "flag_restricted_enter_cooling_room", "vo_restricted_area_cooling_room_started" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_restricted_area_start_music_duck", 3 );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xccd0b79b, Offset: 0x148d
// Size: 0x50
function function_ed847a2000673574( struct )
{
    decodesource = snd::play( "emt_security_area_decode_lp", struct );
    level waittill( #"flag_restricted_computer_encounter_done" );
    decodesource = snd::stop( decodesource, 0 );
    decodesource = snd::play( "emt_security_area_decode_stop", struct );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x400b15cc, Offset: 0x14e5
// Size: 0x1a
function function_2ddf9442133d01ae( origin )
{
    snd::play( "emt_forge_robot_attack_warn", origin );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x18f74737, Offset: 0x1507
// Size: 0x1b
function function_9e5691439028c657()
{
    snd::play( "dx_wc_corn_cfrg_gpa1_elevatorunavailables", ( -6720, -25402, 680 ) );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x253c63fa, Offset: 0x152a
// Size: 0x1b
function function_43582e4ab39b18d9()
{
    snd::play( "dx_wc_corn_cfrg_gpa1_turretshieldingtestr", ( -6772, -23813, 894 ) );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x325f4d0a, Offset: 0x154d
// Size: 0x1b
function function_38dad91c7a2f349e()
{
    snd::play( "dx_wc_corn_crst_gpa1_2048bitkeydetectedde", ( -13215, -63284, 140 ) );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xb326198d, Offset: 0x1570
// Size: 0x1b
function function_2ff8989577abc3ce()
{
    snd::play( "dx_wc_corn_crst_gpa1_2048bitkeydecryption", ( -13215, -63284, 140 ) );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xbbe70131, Offset: 0x1593
// Size: 0x1b
function function_f91f4c7051e3eb95()
{
    snd::play( "dx_wc_corn_cgar_tsub_japaneseshelterinpla", ( -12149, -59088, 87 ) );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x84651954, Offset: 0x15b6
// Size: 0x94
function function_25940a9db64c5ef9()
{
    level endon( #"flag_vo_emp_charged" );
    level endon( #"game_ended" );
    time = 60;
    
    while ( time >= 31 )
    {
        snd::play( "evt_emp_timer2_60s" );
        wait 1;
        time -= 1;
    }
    
    while ( time >= 16 && time <= 30 )
    {
        snd::play( "evt_emp_timer2_30s" );
        wait 1;
        time -= 1;
    }
    
    while ( time <= 15 )
    {
        snd::play( "evt_emp_timer2_10s" );
        wait 1;
        time -= 1;
    }
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0xa059a96, Offset: 0x1652
    // Size: 0xf, Type: dev
    function private function_7cb5dba78e3fca28( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 0
// Checksum 0xadaca0c1, Offset: 0x1669
// Size: 0x2
function chase()
{
    
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0x46c7a1b6, Offset: 0x1673
    // Size: 0xf, Type: dev
    function private function_afd65107fdc9d4d8( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 0
// Checksum 0x33d4fa9f, Offset: 0x168a
// Size: 0x2
function roji()
{
    
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x4c01840b, Offset: 0x1694
// Size: 0x1a
function function_51804a8f7fa5669f( origin )
{
    snd::play( "emt_roji_office_elevator", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x1f8213ab, Offset: 0x16b6
// Size: 0x1a
function function_a7b5b55c35ddcc4( origin )
{
    snd::play( "emt_roji_office_elevator_arrive", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x1f8213ab, Offset: 0x16d8
// Size: 0x1a
function function_b6af3d091facf18d( origin )
{
    snd::play( "emt_roji_office_elevator_ascend", origin );
}

/#

    // Namespace capricorn_audio
    // Params 1, eflags: 0x4
    // Checksum 0x945aa7d4, Offset: 0x16fa
    // Size: 0xf, Type: dev
    function private function_304cd2aaf72a17a4( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace capricorn_audio
// Params 1
// Checksum 0x2f0b1107, Offset: 0x1711
// Size: 0x14b
function roof( start )
{
    assert( isstring( start ) );
    
    switch ( start )
    {
        case #"hash_6d1d25e06152e9fb":
        default:
            utility::flag_wait( "flag_roof_gunship_first_appearance" );
            assert( isent( level.var_3d9fc7aa7b25b565.roof_boss ) );
            wait 0.9;
            snd::play( "veh_vtol_warship_takeoff", level.var_3d9fc7aa7b25b565.roof_boss );
            wait 5;
        case #"hash_889749ce037e1c86":
            audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_roof", 20 );
            
            if ( start == "OB_CAPRICORN_ROOF" )
            {
                return;
            }
            
            utility::flag_wait( "flag_vtol_crash_done" );
            audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_roof", 3 );
            utility::flag_wait( "flag_vo_roof_exfil" );
            wait 5;
            audio_utility::function_f8fa1bfbdb18edb5( level.players, "solo_cin_igc_music_voiceover", 5, 0.75 );
            level utility::flag_wait( "flag_exfil_vo_complete" );
            wait 2;
            audio_utility::function_5b885ff87a1180d4( level.players, "solo_cin_igc_music_voiceover", 1 );
            break;
    }
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x2e459ed2, Offset: 0x1864
// Size: 0x4a
function function_8ba0df2dc7d45480()
{
    level endon( #"game_ended" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_vtol_deafen" );
    level utility::flag_wait( "flag_roof_gunship_first_appearance" );
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_vtol_deafen", 0.8 );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0xee536336, Offset: 0x18b6
// Size: 0x5e
function function_1759d7be335cfc85()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level utility::flag_wait( "flag_reinforcement_spawn_completed" );
        audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_roof_reinforcements", 2 );
        level utility::flag_wait( "flag_reinforcement_over" );
        audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_roof_reinforcements", 2 );
    }
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x904cfd8c, Offset: 0x191c
// Size: 0x5e
function function_a788173f443fabc2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"flag_vo_emp_planting" );
        audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_roof_reinforcements", 2 );
        level waittill( #"flag_vtol_crash_done" );
        audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_roof_reinforcements", 2 );
    }
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xcb8335c9, Offset: 0x1982
// Size: 0x68
function function_9abff8fa716db965( player )
{
    assert( isplayer( player ) );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait 0.5;
    player setsoundsubmix( "mp_sat_ob_capricorn_emp_explode", 0.01 );
    wait 5;
    player clearsoundsubmix( "mp_sat_ob_capricorn_emp_explode", 3 );
    level utility::flag_set( "flag_audio_emp_finished" );
}

// Namespace capricorn_audio
// Params 0
// Checksum 0x2b4cb1d, Offset: 0x19f2
// Size: 0x4a
function function_4189698a498d8703()
{
    level endon( #"game_ended" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_sat_ob_capricorn_roof_vtol_crash" );
    level waittill( #"flag_vtol_crash_done" );
    wait 3;
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_sat_ob_capricorn_roof_vtol_crash", 3 );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xc46995fe, Offset: 0x1a44
// Size: 0x1a
function function_fd50fb5f7c965eb( origin )
{
    snd::play( "emt_cap_hatch_open", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xd1e76d9, Offset: 0x1a66
// Size: 0x1a
function function_4c1fa399f9b361f3( origin )
{
    snd::play( "emt_forge_elevator_button_deny", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x9a0bf78f, Offset: 0x1a88
// Size: 0x1a
function function_fe35739e161d0c5d( origin )
{
    snd::play( "emt_forge_elevator_button_accept", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xda236a04, Offset: 0x1aaa
// Size: 0x1a
function function_4537eb28a10b8825( origin )
{
    snd::play( "emt_forge_elevator_approach", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xb66a3119, Offset: 0x1acc
// Size: 0x1a
function function_3ed9b3c2d81f1d99( origin )
{
    snd::play( "emt_forge_elevator_descend", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xebab3835, Offset: 0x1aee
// Size: 0x1a
function function_6575cf46ebbefa5( origin )
{
    snd::play( "emt_forge_elevator_open", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0xc0b8c96f, Offset: 0x1b10
// Size: 0x1a
function function_e5ef3603af687f1b( origin )
{
    snd::play( "emt_forge_computer_interact", origin );
}

// Namespace capricorn_audio
// Params 1
// Checksum 0x3473cc88, Offset: 0x1b32
// Size: 0x1a
function function_670936664ad677aa( origin )
{
    snd::play( "emt_forge_security_shutter", origin );
}

