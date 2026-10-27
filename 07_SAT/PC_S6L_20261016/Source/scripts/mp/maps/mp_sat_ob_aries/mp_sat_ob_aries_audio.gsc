// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio.gsc  (hash_57a8ee9bbeadd634.gscc) (size: 10779 Bytes / 0x2a1b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4dea2bd0 (1307192272)
// size ...... 10779 (0x2a1b)
// includes .. 6   (offset: 0x267b)
// strings ... 66  (offset: 0x26ab)
// dev strs .. 5   (offset: 0x29db)
// exports ... 30  (offset: 0x1bc3)
// cseg ...... 0xc4d + 0xf76 (0x1bc3)
// imports ... 42  (offset: 0x2073)
// animtree1 . 0   (offset: 0x2a1b)
// animtree2 . 0   (offset: 0x2a1b)
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\snd\snd_ob;

#namespace aries_audio;

/#

    // Namespace aries_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8ee3c09f, Offset: 0xc6b
    // Size: 0xf, Type: dev
    function private function_b840cf6bb7f160dc( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace aries_audio
// Params 0
// Checksum 0xa13cbd98, Offset: 0xc82
// Size: 0xa
function main()
{
    level thread _audio_init();
}

// Namespace aries_audio
// Params 0
// Checksum 0x4ffc7f15, Offset: 0xc94
// Size: 0x15
function _audio_init()
{
    snd::start_init( &_start );
    snd::wait_init();
}

// Namespace aries_audio
// Params 1
// Checksum 0x74a76826, Offset: 0xcb1
// Size: 0x191
function _start( start_point )
{
    assert( start_point == level.current_activity.dataobjects[ "<dev string:x24>" ].value, "<dev string:x35>" );
    level thread music( start_point );
    
    switch ( start_point )
    {
        case #"hash_3938c4cdd4f05e0a":
        case #"hash_9786430c59a9218d":
        case #"hash_aef6f8182a5bdf18":
        case #"hash_ca5e4960c19b904e":
        case #"hash_d49f68a476061d2d":
            level thread river();
            break;
        case #"hash_70325e5531003b6e":
        case #"hash_922a3f6047094a28":
        case #"hash_9636030ca4f50443":
        case #"hash_a85612170100cc5e":
        case #"hash_cbbffcf7074053ec":
            level thread nightmare();
            break;
        case #"hash_36e452d7b752a103":
        case #"hash_40127f13f3b695c9":
        case #"hash_4791d3f2c7e01b33":
        case #"hash_7e8dbaf25e517919":
        case #"hash_8cb19dc7c4a32e66":
            level thread boss();
            break;
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_2f4bc8a8112c4b4d":
        case #"hash_72c4cd57a6f55f65":
        case #"hash_eecca2d05b7cb055":
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

    // Namespace aries_audio
    // Params 1, eflags: 0x4
    // Checksum 0xa89bc201, Offset: 0xe4a
    // Size: 0xf, Type: dev
    function private function_2f8bab071e3e576a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace aries_audio
// Params 1, eflags: 0x4
// Checksum 0xca48da3f, Offset: 0xe61
// Size: 0x16e, Type: bool
function private function_8925e8da38e14a77( squad )
{
    if ( snd::issquad( squad ) )
    {
        ai_in_range = [];
        ai_attacking = [];
        
        foreach ( player in squad.players )
        {
            var_4d5ae7fc5f30fc6b = getaiarrayinradius( player.origin, 1500 );
            ai_in_range = arraycombineunique( ai_in_range, var_4d5ae7fc5f30fc6b );
        }
        
        foreach ( ent in ai_in_range )
        {
            if ( isent( ent.enemy ) && arraycontains( squad.players, ent.enemy ) )
            {
                ai_attacking[ ai_attacking.size ] = ent;
            }
        }
        
        if ( ai_attacking.size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace aries_audio
// Params 2, eflags: 0x4
// Checksum 0x92d51d4a, Offset: 0xfd8
// Size: 0x80
function private function_2a7c47727d7d1507( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music( squad, "mx_aries_angola_idle_lp" );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music( squad, "mx_aries_angola_combat_lp" );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace aries_audio
// Params 1
// Checksum 0xb7288067, Offset: 0x1060
// Size: 0x46f
function music( start )
{
    level endon( #"game_ended" );
    
    if ( snd::did_once( "aries_audio::music" ) )
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
        case #"hash_9786430c59a9218d":
        case #"hash_aef6f8182a5bdf18":
        case #"hash_ca5e4960c19b904e":
        case #"hash_d49f68a476061d2d":
            wait 2;
            snd_ob::squad_music_with_boost( squad, "mx_aries_angola_idle_lp", 6, 115, 0, 8, 24 );
            wait 3;
            snd_ob::squad_combat_state( squad, &function_2a7c47727d7d1507 );
        case #"hash_3938c4cdd4f05e0a":
            utility::flag_wait( "flag_river_barge_activity_begin" );
            snd_ob::squad_combat_state( squad, &function_2a7c47727d7d1507 );
            squad.snd.ai_callback = &function_8925e8da38e14a77;
            utility::flag_wait( "flag_barge_vines_cleared" );
            utility::flag_wait( "flag_river_village_finalwave_spawned" );
            snd::function_c401f0837df862eb();
            snd_ob::squad_combat_state_stop( squad );
            squad.snd.ai_callback = undefined;
            snd_ob::squad_music( squad, "mx_aries_angola_combat_lp" );
            utility::flag_wait( "flag_river_village_finalwave_defeated" );
            snd_ob::squad_music_stop( squad );
        case #"hash_70325e5531003b6e":
            utility::flag_wait( "flag_aries_nightmare_intro_start" );
            utility::flag_wait( "flag_aries_nightmare_intro_complete" );
        case #"hash_a85612170100cc5e":
            snd::function_c401f0837df862eb( squad );
            wait 3;
            snd_ob::squad_music_with_boost( squad, "mx_aries_fresh_hell_lp", 0, 120, 4, 8, 12 );
            utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_complete" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flg_nmr_woods_memory_1_starting" );
            wait 1.5;
            snd_ob::squad_music_with_boost( squad, "mx_aries_exposition", 6, 80, 1, 4, 16 );
            utility::flag_wait( "flg_nmr_woods_memory_1_complete" );
            wait 2;
            snd_ob::squad_music_stop( squad );
        case #"hash_9636030ca4f50443":
            snd_ob::squad_music_with_boost( squad, "mx_aries_fresh_hell_lp", 0, 120, 4, 8, 12 );
            utility::flag_wait( "flag_aries_nightmare_maze_complete" );
            utility::flag_wait( "flag_aries_nightmare_tower_entered" );
            snd_ob::squad_music_stop( squad );
        case #"hash_922a3f6047094a28":
            utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
            wait 0.1;
            snd_ob::squad_music_with_boost( squad, "mx_aries_exposition", 6, 80, 1, 4, 16 );
            utility::flag_wait( "flag_nm_tower_woods_memory_02_narration_complete" );
            wait 5;
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_aries_nightmare_tower_water_raise_start" );
            snd_ob::squad_music_with_boost( squad, "mx_aries_rising_tide_lp", 6, 80, 4, 16, 24 );
            utility::flag_wait( "flag_nm_tower_weakpoints_set_a_complete" );
            snd_ob::squad_music_stop( squad );
            utility::flag_wait( "flag_aries_nightmare_tower_complete" );
        case #"hash_cbbffcf7074053ec":
            snd_ob::squad_music_with_boost( squad, "mx_aries_to_the_box_lp", 3, 95, 0, 32, 32 );
            utility::flag_wait( "flag_aries_nightmare_crashsite_complete" );
            snd_ob::squad_music_stop( squad );
        case #"hash_8cb19dc7c4a32e66":
            utility::flag_wait( "flag_aries_boss_intro_start" );
            utility::flag_wait( "flag_aries_boss_intro_end" );
        case #"hash_40127f13f3b695c9":
        case #"hash_4791d3f2c7e01b33":
        case #"hash_7e8dbaf25e517919":
            snd_ob::squad_music_with_boost( squad, "mx_aries_boss_flower_lp", 7, 105, 2, 32, 32 );
            utility::flag_wait( "aries_boss_phasethree_complete" );
            snd_ob::squad_music_stop( squad );
        case #"hash_36e452d7b752a103":
            utility::flag_wait( "flag_aries_boss_outro_start" );
            utility::flag_wait( "flag_aries_boss_outro_end" );
        case #"hash_6d961012822f635":
        case #"hash_3dd1b0578ff495b1":
            break;
        case #"hash_2f4bc8a8112c4b4d":
        case #"hash_72c4cd57a6f55f65":
        case #"hash_eecca2d05b7cb055":
            snd_ob::squad_music_with_boost( squad, "mx_aries_boss_flower_lp", 7, 105, 2, 32, 32 );
            break;
    }
}

/#

    // Namespace aries_audio
    // Params 1, eflags: 0x4
    // Checksum 0x8944a213, Offset: 0x14d7
    // Size: 0xf, Type: dev
    function private function_b52971d807b65870( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace aries_audio
// Params 0
// Checksum 0x9fd49a0e, Offset: 0x14ee
// Size: 0x2
function river()
{
    
}

// Namespace aries_audio
// Params 0
// Checksum 0x67dd8909, Offset: 0x14f8
// Size: 0x94
function function_b0501522ce363884()
{
    var_8e929b413f4a5fe9 = snd::play( "evt_aries_jungle_intro_dist_gunfire_01", ( -8170, -6893, 1525 ) );
    snd::await( var_8e929b413f4a5fe9 );
    wait 2;
    var_8e9298413f4a5950 = snd::play( "evt_aries_jungle_intro_dist_gunfire_02_lp", ( -8170, -6893, 1525 ) );
    level utility::flag_wait( "flag_jungle_audio_ambient_gunfire_stop" );
    snd::stop( var_8e9298413f4a5950, 1.5 );
    var_472b6964c0678e56 = snd::play( "evt_aries_jungle_intro_dist_gunfire_03", ( -7139, -4166, 1890 ) );
}

// Namespace aries_audio
// Params 1
// Checksum 0xd524f13b, Offset: 0x1594
// Size: 0x94
function function_6e2c9dd3c2a93378( var_be8ba0881d6c60d7 )
{
    if ( isdefined( var_be8ba0881d6c60d7 ) )
    {
        switch ( var_be8ba0881d6c60d7 )
        {
            case #"hash_4b092a5f936cb351":
                snd::play( "evt_aries_room_01_rumble_lr", ( 4234, 1011, 3178 ) );
                break;
            case #"hash_4b09275f936cae98":
                snd::play( "evt_aries_room_02_rumble_lr", ( 1844, -4200, 2320 ) );
                break;
            case #"hash_4b09285f936cb02b":
                snd::play( "evt_aries_room_03_rumble_lr", ( 5075, -3719, 2968 ) );
                break;
        }
    }
}

/#

    // Namespace aries_audio
    // Params 1, eflags: 0x4
    // Checksum 0xecbe0937, Offset: 0x1630
    // Size: 0xf, Type: dev
    function private function_6b6b4e933e175987( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace aries_audio
// Params 0
// Checksum 0xd157b114, Offset: 0x1647
// Size: 0x2
function nightmare()
{
    
}

// Namespace aries_audio
// Params 0
// Checksum 0xedba02eb, Offset: 0x1651
// Size: 0x1b
function function_ee01595d02ff5e1f()
{
    snd::play( "evt_aries_container_maze_intro", ( -26394, 15390, 249 ) );
}

// Namespace aries_audio
// Params 0
// Checksum 0x9399df00, Offset: 0x1674
// Size: 0x66
function function_6a50d2fd579ff2db()
{
    snd::play( "evt_aries_container_constrict_left_far", ( -26275, 14066, 238 ) );
    snd::play( "evt_aries_container_constrict_left_close", ( -26282, 13450, 498 ) );
    snd::play( "evt_aries_container_constrict_right_close", ( -26545, 13678, 273 ) );
    snd::play( "evt_aries_container_constrict_right_far", ( -26527, 13450, 154 ) );
}

// Namespace aries_audio
// Params 0
// Checksum 0xfd4d9f64, Offset: 0x16e2
// Size: 0x1b
function function_8b9d91955461101d()
{
    snd::play( "evt_aries_encounter_containers_move", ( -26424, 12202, 163 ) );
}

// Namespace aries_audio
// Params 0
// Checksum 0x712a0146, Offset: 0x1705
// Size: 0x1b
function function_8c0738b67a9c7cf4()
{
    snd::play( "evt_aries_container_sequence_b_open", ( -26531, 12511, 148 ) );
}

// Namespace aries_audio
// Params 0
// Checksum 0x9eb7fdbb, Offset: 0x1728
// Size: 0x1b
function function_344308701ab3439b()
{
    snd::play( "evt_aries_container_tower_transition_close", ( -32910, 12719, 442 ) );
}

// Namespace aries_audio
// Params 0
// Checksum 0x542d69e2, Offset: 0x174b
// Size: 0x1b
function function_650914567ca4936f()
{
    snd::play( "evt_gem_memory_gunshot", ( -34218, 13204, 668 ) );
}

// Namespace aries_audio
// Params 1
// Checksum 0x12bf6ba3, Offset: 0x176e
// Size: 0xd6
function function_29eb8215bdbb044d( var_3c6e4a0c8a5d936e )
{
    snd::play( "evt_aries_container_barge_start", var_3c6e4a0c8a5d936e );
    wtr_rising_lp_01 = snd::play( "evt_aries_container_wtr_rising_lp_01", var_3c6e4a0c8a5d936e );
    wtr_rising_lp_02 = snd::play( "evt_aries_container_wtr_rising_lp_02", var_3c6e4a0c8a5d936e );
    wtr_rising_lp_03 = snd::play( "evt_aries_container_wtr_rising_lp_03", var_3c6e4a0c8a5d936e );
    wtr_rising_lp_04 = snd::play( "evt_aries_container_wtr_rising_lp_04", var_3c6e4a0c8a5d936e );
    wtr_rising_lp_05 = snd::play( "evt_aries_container_wtr_rising_lp_05", var_3c6e4a0c8a5d936e );
    utility::flag_wait( "flag_aries_nightmare_tower_water_raise_complete" );
    snd::play( "evt_aries_container_barge_stop", var_3c6e4a0c8a5d936e );
    snd::stop( wtr_rising_lp_01 );
    snd::stop( wtr_rising_lp_02 );
    snd::stop( wtr_rising_lp_03 );
    snd::stop( wtr_rising_lp_04 );
    snd::stop( wtr_rising_lp_05 );
}

// Namespace aries_audio
// Params 0
// Checksum 0x10ff7e10, Offset: 0x184c
// Size: 0x1f6
function function_6b17b966d7327acd()
{
    utility::flag_wait( "flag_nm_audio_waterfalls_start" );
    waterfall_01 = snd::play( "amb_emt_aries_nm_waterfall_cont_01", ( -34934, 12950, 765 ) );
    snd::line_attach( waterfall_01, self, ( -34934, 12950, 765 ), ( -34842, 12943, 456 ) );
    waterfall_02 = snd::play( "amb_emt_aries_nm_waterfall_cont_02", ( -34455, 13249, 466 ) );
    snd::line_attach( waterfall_02, self, ( -34455, 13249, 466 ), ( -34615, 13362, 2050 ) );
    waterfall_03 = snd::play( "amb_emt_aries_nm_waterfall_cont_03", ( -34108, 13721, 571 ) );
    snd::line_attach( waterfall_03, self, ( -34108, 13721, 571 ), ( -34098, 13867, 2199 ) );
    waterfall_04 = snd::play( "amb_emt_aries_nm_waterfall_cont_04", ( -33691, 12624, 456 ) );
    snd::line_attach( waterfall_04, self, ( -33691, 12624, 456 ), ( -33550, 12485, 2938 ) );
    waterfall_05 = snd::play( "amb_emt_aries_nm_waterfall_cont_05", ( -34196, 12249, 477 ) );
    snd::line_attach( waterfall_05, self, ( -34196, 12249, 477 ), ( -34231, 12134, 1295 ) );
    waterfall_06 = snd::play( "amb_emt_aries_nm_waterfall_cont_06", ( -34378, 12640, 438 ) );
    snd::line_attach( waterfall_06, self, ( -34378, 12640, 438 ), ( -34553, 12446, 2005 ) );
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_90" );
    snd::stop( waterfall_01 );
    snd::stop( waterfall_02 );
    snd::stop( waterfall_03 );
    snd::stop( waterfall_04 );
    snd::stop( waterfall_05 );
    snd::stop( waterfall_06 );
}

// Namespace aries_audio
// Params 0
// Checksum 0x67bb705e, Offset: 0x1a4a
// Size: 0xe
function function_f6cbf058f9afe425()
{
    snd::play( "evt_aries_container_combat_start_indicator" );
}

// Namespace aries_audio
// Params 0
// Checksum 0xb4da3e23, Offset: 0x1a60
// Size: 0xe
function function_6da7cb25be5201da()
{
    snd::play( "evt_aries_container_combat_indicator" );
}

// Namespace aries_audio
// Params 0
// Checksum 0x953ae6d6, Offset: 0x1a76
// Size: 0x1b
function function_29eb5c1d2739622a()
{
    snd::play( "evt_aries_crashsite_transition_close", ( -35431, 13218, 4615 ) );
}

/#

    // Namespace aries_audio
    // Params 1, eflags: 0x4
    // Checksum 0x65932a90, Offset: 0x1a99
    // Size: 0xf, Type: dev
    function private function_ba8021505edb3d1f( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace aries_audio
// Params 0
// Checksum 0x54c99b1f, Offset: 0x1ab0
// Size: 0x2
function boss()
{
    
}

// Namespace aries_audio
// Params 0
// Checksum 0xf8dac18a, Offset: 0x1aba
// Size: 0x7e
function function_4c710b4033251aae()
{
    foreach ( player in level.players )
    {
        player setsoundsubmix( "mp_sat_ob_aries_boss_phase_scream_intro" );
    }
}

// Namespace aries_audio
// Params 0
// Checksum 0x3d704ef5, Offset: 0x1b40
// Size: 0x83
function function_6ccd783a813a8dde()
{
    foreach ( player in level.players )
    {
        player clearsoundsubmix( "mp_sat_ob_aries_boss_phase_scream_intro", 0.5 );
    }
}

