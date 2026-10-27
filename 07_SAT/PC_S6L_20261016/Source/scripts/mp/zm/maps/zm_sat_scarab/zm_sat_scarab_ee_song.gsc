// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_song.gsc  (hash_40b01ed5386ff6f8.gscc) (size: 2619 Bytes / 0xa3b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf39f6d78 (4087311736)
// size ...... 2619 (0xa3b)
// includes .. 4   (offset: 0x96b)
// strings ... 12  (offset: 0x98b)
// dev strs .. 0   (offset: 0xa3b)
// exports ... 9   (offset: 0x567)
// cseg ...... 0x187 + 0x3e0 (0x567)
// imports ... 23  (offset: 0x6cf)
// animtree1 . 0   (offset: 0xa3b)
// animtree2 . 0   (offset: 0xa3b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_scarab_ee_song;

// Namespace zm_sat_scarab_ee_song
// Params 0, eflags: 0x5
// Checksum 0x9ba7a379, Offset: 0x1a5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_8dbaf69f85bdb98c", undefined, undefined, &postmain_init );
}

// Namespace zm_sat_scarab_ee_song
// Params 0, eflags: 0x4
// Checksum 0xfd7f1a70, Offset: 0x1c6
// Size: 0x93
function private postmain_init()
{
    if ( !getdvarint( @"hash_1389eb7dad9f9d83", 0 ) && !level.var_73a9d94b186eeab5 )
    {
        return;
    }
    
    level.song_ee = zm_quest::get_quest( #"scarab_ee_song" );
    zm_quest::register_quest_step( #"scarab_ee_song", #"step_1", &setup_step_1, &function_61e5b348e99af311 );
    level utility::flag_wait_all( "zm_sat_scarab_ee_song_cs_completed", "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"scarab_ee_song" );
}

// Namespace zm_sat_scarab_ee_song
// Params 2, eflags: 0x4
// Checksum 0xb3d38498, Offset: 0x261
// Size: 0x125
function private setup_step_1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    var_a7a67b26da8b709d = utility::getstruct( "ee_song_gramophone", "script_noteworthy" );
    
    if ( var_a7a67b26da8b709d )
    {
        level.song_ee.mdl_gramophone = utility::spawn_model( "t10_zm_gramophone", var_a7a67b26da8b709d.origin, var_a7a67b26da8b709d.angles );
        level.song_ee.interaction = zm_quest::function_91f9590e98d57ff6( var_a7a67b26da8b709d.origin + ( 0, 0, 0 ), &use_gramophone, &gramophone_hint );
        level.song_ee.var_a897304b0b75679 = 0;
        var_dfe156b1a8246ea0 = utility::getstruct( "ee_song_gramophone_record", "script_noteworthy" );
        level.song_ee.mdl_record = utility::spawn_model( "t10_zm_gramophone_record", var_dfe156b1a8246ea0.origin, var_dfe156b1a8246ea0.angles );
        level utility::flag_wait( "ee_song_music_played" );
    }
}

// Namespace zm_sat_scarab_ee_song
// Params 2, eflags: 0x4
// Checksum 0xc5f80af, Offset: 0x38e
// Size: 0x9a
function private function_61e5b348e99af311( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        var_a7a67b26da8b709d = utility::getstruct( "ee_song_gramophone", "script_noteworthy" );
        utility::spawn_model( "t10_zm_gramophone", var_a7a67b26da8b709d.origin, var_a7a67b26da8b709d.angles );
        var_dfe156b1a8246ea0 = utility::getstruct( "ee_song_gramophone_record", "script_noteworthy" );
        utility::spawn_model( "t10_zm_gramophone_record", var_dfe156b1a8246ea0.origin, var_dfe156b1a8246ea0.angles );
    }
}

// Namespace zm_sat_scarab_ee_song
// Params 1, eflags: 0x4
// Checksum 0x954449b, Offset: 0x430
// Size: 0x69
function private use_gramophone( player )
{
    level utility::flag_set( "ee_song_music_played" );
    playsoundatpos( level.song_ee.mdl_gramophone.origin, "mus_scarab_phonography_sams_dream" );
    level.song_ee.mdl_record thread record_playing();
    level thread finish_watcher();
    waitframe();
    self freescriptable();
}

// Namespace zm_sat_scarab_ee_song
// Params 2, eflags: 0x4
// Checksum 0x2382f057, Offset: 0x4a1
// Size: 0x36
function private gramophone_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ee_song
// Params 0
// Checksum 0xc504f906, Offset: 0x4e0
// Size: 0x62
function record_playing()
{
    level endon( #"game_ended" );
    level endon( #"hash_6dd9c024b675eef8" );
    
    while ( true )
    {
        newangles = combineangles( self.angles, ( 0, -45, 0 ) );
        self rotateto( newangles, 0.625 );
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_scarab_ee_song
// Params 0
// Checksum 0xa20ff301, Offset: 0x54a
// Size: 0x1d
function finish_watcher()
{
    level endon( #"game_ended" );
    wait 30;
    level notify( #"hash_6dd9c024b675eef8" );
}

