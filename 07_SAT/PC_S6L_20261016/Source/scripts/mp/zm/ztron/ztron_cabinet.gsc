// scripts\mp\zm\ztron\ztron_cabinet.gsc  (hash_67a9708d4bdb8c80.gscc) (size: 5409 Bytes / 0x1521 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a3b0caf (2587561135)
// size ...... 5409 (0x1521)
// includes .. 12  (offset: 0x138d)
// strings ... 20  (offset: 0x13ed)
// dev strs .. 1   (offset: 0x1515)
// exports ... 10  (offset: 0xcd1)
// cseg ...... 0x205 + 0xacc (0xcd1)
// imports ... 42  (offset: 0xe61)
// animtree1 . 0   (offset: 0x1521)
// animtree2 . 0   (offset: 0x1521)
#using script_31ee2a173f3499b7;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_cabinet;

// Namespace ztron_cabinet
// Params 0, eflags: 0x5
// Checksum 0x424c1d4d, Offset: 0x223
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_cabinet", undefined, undefined, &init );
}

// Namespace ztron_cabinet
// Params 0
// Checksum 0xe8386a4a, Offset: 0x244
// Size: 0x42
function init()
{
    if ( !level.ztron.cabinetmode )
    {
        return;
    }
    
    level waittill( #"ztron_game_reset_completed" );
    ui::lui_registercallback( "bink_complete", &binkcomplete );
    
    /#
        initdevgui();
    #/
}

// Namespace ztron_cabinet
// Params 1
// Checksum 0x5861baba, Offset: 0x28e
// Size: 0x2c
function function_3c6629de7583260c( note )
{
    level endon( note );
    
    while ( true )
    {
        self waittill( #"cabinet_player_input" );
        level notify( note );
        return;
    }
}

// Namespace ztron_cabinet
// Params 1
// Checksum 0xfc97b12c, Offset: 0x2c2
// Size: 0x18
function binkcomplete( params )
{
    level notify( #"stop_cinematic" );
}

// Namespace ztron_cabinet
// Params 0
// Checksum 0x4abe8524, Offset: 0x2e2
// Size: 0x4ce
function function_9b14a60ad872f44e()
{
    ztron_ui::function_f5177e090dadd8f4( 2 );
    ztron_util::function_9ecee6f38c56d30f( 0 );
    clearmusicstate();
    
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_out( 0, 1, 0.5 );
    }
    
    wait 0.5;
    setomnvar( "ui_ztron_cabinet_post_game_state", 3 );
    setomnvar( "ui_ztron_cabinet_cine_state", 1 );
    playcinematicforall( "sat_ztron_intro_cabinet", 1 );
    
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_in( 0, 0, 0.5 );
        player playlocalsound( "cin_ztron_intro_cabinet_pt1" );
    }
    
    wait 9;
    setmusicstate( "ztron_cabinet_attract" );
    setomnvar( "ui_ztron_cabinet_cine_state", 2 );
    playcinematicforall( "", 1, 0, 16 );
    
    foreach ( player in level.players )
    {
        player notifyonplayercommand( "cabinet_player_input", "+gostand" );
    }
    
    foreach ( player in level.players )
    {
        player thread function_3c6629de7583260c( "unpause_cinematic" );
    }
    
    level waittill( #"unpause_cinematic" );
    setomnvar( "ui_ztron_cabinet_cine_state", 1 );
    playcinematicforall( "", 1 );
    clearmusicstate();
    
    foreach ( player in level.players )
    {
        player playlocalsound( "cin_ztron_press_start" );
        player playlocalsound( "cin_ztron_intro_cabinet_pt2" );
    }
    
    wait 10;
    setomnvar( "ui_ztron_cabinet_cine_state", 3 );
    
    foreach ( player in level.players )
    {
        player thread function_3c6629de7583260c( "stop_cinematic" );
    }
    
    level utility::waittill_any_timeout( 60, "stop_cinematic" );
    setomnvar( "ui_ztron_cabinet_cine_state", 0 );
    ztron_util::function_9ecee6f38c56d30f( 0.5 );
    
    foreach ( player in level.players )
    {
        player stoplocalsound( "cin_ztron_intro_cabinet_pt2" );
        player thread ztron_util::fade_in( 0, 1, 0.5 );
    }
    
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player notifyonplayercommandremove( "cabinet_player_input", "+gostand" );
    }
    
    ztron_ui::function_bddb5fe817c432f1();
    ztron_ui::function_f5177e090dadd8f4( 0 );
    setomnvar( "ui_ztron_cabinet_post_game_state", 0 );
    setomnvarforallclients( "ui_ztron_disable_scoreboard", 0 );
}

// Namespace ztron_cabinet
// Params 0
// Checksum 0xbff061eb, Offset: 0x7b8
// Size: 0xaa
function function_8547df1f1f3d594b()
{
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player notify( #"ztron_exit_taken" );
        player notify( #"clear_active_item" );
    }
    
    level notify( #"ztron_exit_taken" );
    level notify( #"clear_active_item" );
}

// Namespace ztron_cabinet
// Params 1
// Checksum 0x41858fc6, Offset: 0x86a
// Size: 0x1ec
function function_8163e85b3da986a3( endreason )
{
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_out( 1, 1, 0.5 );
    }
    
    wait 0.5;
    setomnvarforallclients( "post_game_state", 8 );
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_in( 0, 0, 0.5 );
    }
    
    setomnvar( "ui_ztron_cabinet_post_game_state", 1 );
    wait 10;
    
    if ( endreason == game[ "end_reason" ][ "mp_faction_eliminated" ] )
    {
        setomnvar( "ui_ztron_cabinet_post_game_state", 0 );
        ztron_ui::function_37aad40e39a9fdfe( "game_over", ztron_main::function_d0ec00d4cc5debc7() );
        wait 3;
    }
    
    setomnvarforallclients( "post_game_state", 5 );
    wait 8;
    ztron_util::function_9ecee6f38c56d30f( 0.5 );
    
    foreach ( player in level.players )
    {
        player thread ztron_util::fade_in( 0, 1, 0 );
    }
}

// Namespace ztron_cabinet
// Params 1
// Checksum 0x630a6509, Offset: 0xa5e
// Size: 0x253
function endgame( endreason )
{
    ztron_util::function_9ecee6f38c56d30f( 2 );
    level notify( #"arena_completed" );
    level notify( #"arena_deactivated" );
    level notify( #"round_over" );
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "gameOver" );
    
    foreach ( player in level.players )
    {
        player thread playerlogic::spawnintermission();
        
        if ( !player.ztron.dead )
        {
            player playerlogic::decrementalivecount( player.team );
        }
    }
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
    {
        ztron_ui::function_ce7fbecb1ea8d56f();
        level notify( #"bonus_room_expired" );
        level notify( #"deactivate_bonus_room" );
        level thread ztron_bonus_room::function_f7a8bdcd439072ca( level.ztron.var_8a9067aa4cd65369 );
    }
    
    setomnvarforallclients( "ui_ztron_disable_scoreboard", 1 );
    waitframe();
    level notify( #"hash_1cf1c429bb1c9a07" );
    ztron_util::function_d54d1c1fe00833d6();
    ztron_util::function_4430e75095fb2a8();
    ztron_item::function_25f69b2b896fd56();
    ztron_util::killallenemies();
    ztron_util::function_494e6b73ea596cc7();
    thread function_8547df1f1f3d594b();
    function_8163e85b3da986a3( endreason );
    ztron_weather::resetlightstate();
    
    foreach ( player in level.players )
    {
        player.var_14955bc056bab547 = 1;
        player.ztron = undefined;
        player thread playerlogic::spawnclient();
    }
    
    wait 2;
    level.ztron.cabinetstart = 1;
    level.ztron.var_352a36a9f912c62f = endreason;
    level thread ztron_main::game_reset();
}

/#

    // Namespace ztron_cabinet
    // Params 0, eflags: 0x4
    // Checksum 0x58bb65b9, Offset: 0xcb9
    // Size: 0x18, Type: dev
    function private initdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_77df7fe7dd273e10();
    }

#/
