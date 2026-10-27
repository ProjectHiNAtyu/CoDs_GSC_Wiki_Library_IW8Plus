// scripts\mp\ob\systems\ob_exfil_trans.gsc  (hash_048f5e14d6e16ff6.gscc) (size: 6162 Bytes / 0x1812 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76b8566c (1991792236)
// size ...... 6162 (0x1812)
// includes .. 10  (offset: 0x165e)
// strings ... 28  (offset: 0x16ae)
// dev strs .. 0   (offset: 0x1812)
// exports ... 14  (offset: 0xd26)
// cseg ...... 0x200 + 0xb26 (0xd26)
// imports ... 58  (offset: 0xf56)
// animtree1 . 0   (offset: 0x1812)
// animtree2 . 0   (offset: 0x1812)
#using script_16ea1b94f0f381b3;
#using script_3edd59d0d3fc3262;
#using scripts\common\save;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gametypes\ob;
#using scripts\mp\ob\systems\ob_exfil;

#namespace ob_exfil_trans;

// Namespace ob_exfil_trans
// Params 0, eflags: 0x1
// Checksum 0x32059124, Offset: 0x21e
// Size: 0x58
function autoexec main()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
    {
        return;
    }
    
    level utility::delaythread( 0.1, &namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb, #"play_again", &function_f4a02073ec59c7bb );
    level utility::delaythread( 0.1, &ui::lui_registercallback, "play_again", &function_f4a02073ec59c7bb );
    thread function_9ab149c88e532556();
}

// Namespace ob_exfil_trans
// Params 3
// Checksum 0xbe1591e3, Offset: 0x27e
// Size: 0x84
function exfiltrans( player, playlistid, binkcinematic )
{
    self notify( #"hash_68365e293d252e43" );
    self endon( #"hash_68365e293d252e43" );
    
    if ( isarray( player ) )
    {
        firstkey = getfirstarraykey( player );
        player = player[ firstkey ];
    }
    
    assert( isplayer( player ) );
    assert( isint( playlistid ) );
    level function_a1a9299cbf0c71e9( player, playlistid, binkcinematic, "save" );
}

// Namespace ob_exfil_trans
// Params 2
// Checksum 0xf2c24b3, Offset: 0x30a
// Size: 0x1b7
function exfilreplay( player, binkcinematic )
{
    self notify( #"hash_d9c8b48b5885849" );
    self endon( #"hash_d9c8b48b5885849" );
    
    if ( isarray( player ) )
    {
        firstkey = getfirstarraykey( player );
        player = player[ firstkey ];
    }
    
    assert( isplayer( player ) );
    
    if ( !level.onlinegame )
    {
        squad = teams::function_72b89edf6b47c40a( player );
        
        foreach ( squadmember in squad.players )
        {
            level thread game_utility::fadetoblackforplayer( squadmember, 1, 0.5 );
        }
        
        wait 0.6;
        setdvar( @"start", "default" );
        setdvar( @"hash_364afa6c813448af", "default" );
        setdvar( @"ob_sm_reload", 2 );
        setdvar( @"hash_d5d17ffd60db08fc", level.players.size );
        setdvar( @"hash_10a81f3d3159dfd6", level.players.size );
        map_restart();
        return;
    }
    
    if ( !isdefined( binkcinematic ) )
    {
        mapinfo = getmapscriptbundle();
        binkcinematic = mapinfo.var_3b3d5e9c999d96ec ?? mapinfo.var_27ceb9081ce7fe53;
    }
    
    level function_a1a9299cbf0c71e9( player, getplaylistid(), binkcinematic, "save", 1 );
}

// Namespace ob_exfil_trans
// Params 2
// Checksum 0x6a93898, Offset: 0x4c9
// Size: 0x142
function function_5f3a1579cbc6ac1e( player, binkcinematic )
{
    self notify( #"hash_928fa89eb67f28af" );
    self endon( #"hash_928fa89eb67f28af" );
    assert( level.var_91466c5be0885e53 );
    
    if ( isarray( player ) )
    {
        firstkey = getfirstarraykey( player );
        player = player[ firstkey ];
    }
    
    if ( !isplayer( player ) )
    {
        foreach ( otherplayer in level.players )
        {
            if ( !isplayer( otherplayer ) )
            {
                continue;
            }
            
            player = otherplayer;
            break;
        }
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_4958c50f292216ed = getdvarint( @"hash_5da9edaa18195155", 255 );
    var_bfeb025a42adb343 = getdvarint( @"ob_map_transition_playlist_return", var_4958c50f292216ed );
    var_bfeb025a42adb343 = var_bfeb025a42adb343 ? var_bfeb025a42adb343 : var_4958c50f292216ed;
    level function_a1a9299cbf0c71e9( player, var_bfeb025a42adb343, binkcinematic );
}

// Namespace ob_exfil_trans
// Params 1, eflags: 0x4
// Checksum 0x86162a05, Offset: 0x613
// Size: 0x42
function private function_f4a02073ec59c7bb( param )
{
    if ( isplayer( self ) )
    {
        level thread exfilreplay( self );
        return;
    }
    
    if ( level.players.size > 0 )
    {
        level thread exfilreplay( level.players[ 0 ] );
    }
}

// Namespace ob_exfil_trans
// Params 1
// Checksum 0x1e7c13e0, Offset: 0x65d
// Size: 0xac
function function_de34b08af866fc29( requireplayed = 1 )
{
    self notify( #"hash_bda2284a5c2d5dde" );
    self endon( #"hash_bda2284a5c2d5dde" );
    assert( self == level );
    assert( isthreaded() );
    
    if ( !level.onlinegame )
    {
        return;
    }
    
    if ( requireplayed )
    {
        level utility::flag_wait( "squad_play_begin" );
    }
    
    wait 5;
    
    if ( function_79a4880f8afcb151() )
    {
        level utility::delaythread( getdvarint( @"hash_674208de5fa35ea6", 60 ), &function_de34b08af866fc29, 0 );
        return;
    }
    
    function_a19af5e33ad1e493();
    save::clear_all();
    
    if ( !function_9ff5a5ba55728756() )
    {
        exitlevel();
    }
    
    endlobby();
}

// Namespace ob_exfil_trans
// Params 0
// Checksum 0xad124740, Offset: 0x711
// Size: 0x1e
function function_a19af5e33ad1e493()
{
    deregisterdvar( @"start" );
    deregisterdvar( @"hash_364afa6c813448af" );
}

// Namespace ob_exfil_trans
// Params 0, eflags: 0x4
// Checksum 0x1e4e3e83, Offset: 0x737
// Size: 0x4e
function private function_9ab149c88e532556()
{
    level utility::waittill_any( "prematch_started", "prematch_done", "start_mode_setup", "infil_started", "player_ready_check" );
    level utility::delaythread( getdvarint( @"hash_674208de5fa35ea6", 60 ), &function_de34b08af866fc29, 0 );
    function_b5380364f56f10a6();
    thread function_af85edf8ad007596();
}

// Namespace ob_exfil_trans
// Params 0, eflags: 0x4
// Checksum 0x3931ff1e, Offset: 0x78d
// Size: 0x12f
function private function_b5380364f56f10a6()
{
    if ( !isdefined( level.var_c810704b6854c788 ) )
    {
        level.var_c810704b6854c788 = [];
    }
    
    if ( !isdefined( level.var_c0872a1a92751920 ) )
    {
        level.var_c0872a1a92751920 = [];
    }
    
    var_1eb048ce41430987 = utility::getstructarray( "content_struct", "variantname" );
    
    foreach ( s_content in var_1eb048ce41430987 )
    {
        if ( s_content.content_key == "exfil_interact_trans" && !arraycontains( level.var_c810704b6854c788, s_content ) )
        {
            level.var_c810704b6854c788[ level.var_c810704b6854c788.size ] = s_content;
        }
        
        if ( s_content.content_key == "exfil_interact_return" && !arraycontains( level.var_c0872a1a92751920, s_content ) )
        {
            level.var_c0872a1a92751920[ level.var_c0872a1a92751920.size ] = s_content;
        }
    }
}

// Namespace ob_exfil_trans
// Params 0, eflags: 0x4
// Checksum 0x9047857b, Offset: 0x8c4
// Size: 0xea
function private function_af85edf8ad007596()
{
    foreach ( location in level.var_c810704b6854c788 )
    {
        thread function_e41ac30774d63f63( location );
    }
    
    foreach ( location in level.var_c0872a1a92751920 )
    {
        thread function_e41ac30774d63f63( location );
    }
}

// Namespace ob_exfil_trans
// Params 1, eflags: 0x4
// Checksum 0xa0ccdf00, Offset: 0x9b6
// Size: 0xcf
function private function_e41ac30774d63f63( location )
{
    if ( isdefined( location.target ) )
    {
        scriptables = getentitylessscriptablearray( location.target, "targetname" );
        scriptables = arraycombine( scriptables, getscriptablearray( location.target, "targetname" ) );
        
        foreach ( exfildoor in scriptables )
        {
            exfildoor setscriptablepartstate( "door", "invisible" );
        }
    }
}

// Namespace ob_exfil_trans
// Params 5, eflags: 0x4
// Checksum 0x9aff0291, Offset: 0xa8d
// Size: 0x21c
function private function_a1a9299cbf0c71e9( player, playlistid, binkcinematic, var_205c545a5e2d10b3, playagain )
{
    assert( isplayer( player ) );
    assert( self == level );
    
    if ( !isplayer( player ) )
    {
        return function_9f66dedba533f39( player, "Invalid instigating player." );
    }
    
    var_26c7fe44e2669ceb = getplaylistname( playlistid );
    
    if ( ( var_26c7fe44e2669ceb ?? "" ) == "" )
    {
        return function_9f66dedba533f39( player, "Playlist " + playlistid + " not valid." );
    }
    
    if ( isdefined( player.var_4c0bb12fd24cde2 ) )
    {
        return function_9f66dedba533f39( player, "Player " + player getentitynumber() + " ignored." );
    }
    
    if ( !namespace_3a2a361a08f89b78::function_e2a674af714aea99( playlistid ) )
    {
        return function_9f66dedba533f39( player, "Playlist " + playlistid + " not allowed." );
    }
    
    squad = player squad_utility::getsquadmembers();
    squadmembers = player squad_utility::getsquadmembers( player.team, 0 );
    
    foreach ( squadmember in squadmembers )
    {
        if ( !isplayer( squadmember ) )
        {
            continue;
        }
        
        squadmember.var_4c0bb12fd24cde2 = playlistid;
        
        if ( !ob::nightmare() )
        {
            consoleactivity = level.var_8ff57499f0d46359 ?? squadmember.var_f8d7f497f4294257;
            
            if ( isdefined( consoleactivity ) )
            {
                squadmember story_contract_util::function_55a89609490d06a0( consoleactivity );
            }
        }
        
        level thread game_utility::fadetoblackforplayer( squadmember, 1, 0.5 );
    }
    
    objective = utility::callsharedfunc( #"ob_story", #"get_active_mission_index", player );
    level thread namespace_3a2a361a08f89b78::map_to_map_start( squadmembers, playlistid, var_205c545a5e2d10b3, binkcinematic, objective, playagain );
}

// Namespace ob_exfil_trans
// Params 2, eflags: 0x4
// Checksum 0x348c392f, Offset: 0xcb1
// Size: 0x74
function private function_9f66dedba533f39( var_64ffacba090c91be, msg )
{
    selfmsg = "unknown";
    
    if ( var_64ffacba090c91be == level )
    {
        selfmsg = "level";
    }
    else if ( isent( var_64ffacba090c91be ) )
    {
        selfmsg = "e" + var_64ffacba090c91be getentitynumber();
    }
    
    msg = "exfilTransMsg() <" + selfmsg + "> - " + msg;
    logprint( msg );
    
    /#
        iprintln( msg );
    #/
    
    return msg;
}

