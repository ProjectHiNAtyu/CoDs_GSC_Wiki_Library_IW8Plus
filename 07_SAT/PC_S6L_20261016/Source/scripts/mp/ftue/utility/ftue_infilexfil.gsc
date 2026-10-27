// scripts\mp\ftue\utility\ftue_infilexfil.gsc  (hash_53fe1a91461cecb9.gscc) (size: 3051 Bytes / 0xbeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfc8579ce (4236605902)
// size ...... 3051 (0xbeb)
// includes .. 6   (offset: 0xb1f)
// strings ... 12  (offset: 0xb4f)
// dev strs .. 0   (offset: 0xbeb)
// exports ... 5   (offset: 0x6f3)
// cseg ...... 0x17c + 0x577 (0x6f3)
// imports ... 29  (offset: 0x7bb)
// animtree1 . 0   (offset: 0xbeb)
// animtree2 . 0   (offset: 0xbeb)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\ftue\utility\ftue_utility;
#using scripts\mp\gamelogic;

#namespace ftue_infilexfil;

// Namespace ftue_infilexfil
// Params 0
// Checksum 0xa0340ae8, Offset: 0x19a
// Size: 0x1fe
function function_d497210b108c1b30()
{
    if ( !( isdefined( level.player ) && isdefined( level.allybot ) ) )
    {
        return;
    }
    
    level.blackoverlay = ftue_utility::function_843d41bc87b22e7f( "black", 0 );
    level.blackoverlay.alpha = 1;
    level.player setstance( "stand" );
    level.allybot setstance( "stand" );
    level.blackoverlay fadeovertime( 0.5 );
    level.blackoverlay.alpha = 0;
    level.player setplayerangles( ( 0, 50, 0 ) );
    level.player playxcam( "wz_gulag_player_acknowledge_r_xcam", 0, level.player.origin, ( 0, 55, 0 ) );
    level.player playanimscriptsceneevent( "scripted_scene", "wz_gulag_player_acknowledge_r_pistol" );
    level.allybot playanimscriptsceneevent( "scripted_scene", "wz_gulag_player_acknowledge_l" );
    wait 4;
    level.blackoverlay fadeovertime( 0.5 );
    level.blackoverlay.alpha = 1;
    wait 0.5;
    level.player stopxcam();
    level.player stopanimscriptsceneevent();
    level.player setplayerangles( level.ftuedata.var_4dde55a6c96044a3 );
    level.player setstance( level.ftuedata.var_4437967a27518457 );
    level.allybot stopanimscriptsceneevent();
    level.allybot setstance( level.ftuedata.var_1e9ad18cc1dd3b9c );
    waitframe();
    level.blackoverlay fadeovertime( 0.5 );
    level.blackoverlay.alpha = 0;
}

// Namespace ftue_infilexfil
// Params 0
// Checksum 0x8fb4f3b1, Offset: 0x3a0
// Size: 0x155
function ftue_exfillaunch()
{
    level endon( #"endingSceneStop" );
    
    if ( level.playingexfil )
    {
        return;
    }
    
    level.playingexfil = 1;
    level thread function_ef43efb395e84f2c();
    
    foreach ( operator in level.players )
    {
        if ( operator != level.players[ 0 ] )
        {
            operator player_utility::function_dbe5a52a6654a982();
            operator player_utility::function_9d378d725bb4831e( "ftue_infilexfil::ftue_exfilLaunch()" );
        }
    }
    
    level thread br::handleendgamesplash( level.player.team, 0 );
    level.player setclientomnvar( "ui_br_player_position", 1 );
    wait 2;
    winners = [ level.player ];
    level.var_572d9d46430e6e25 = spawnstruct();
    level.var_572d9d46430e6e25.var_cb34d2b743970ba5 = "mgl_ftue_tutorial";
    br_ending::play_ending( winners );
    waitframe();
    function_488b3360ba7f6153();
    level notify( #"hash_2a09686c8b5c893e" );
}

// Namespace ftue_infilexfil
// Params 0
// Checksum 0x223d484b, Offset: 0x4fd
// Size: 0x70
function function_ef43efb395e84f2c()
{
    level endon( #"hash_2a09686c8b5c893e" );
    hostplayer = gamelogic_mp::gethostplayer();
    
    if ( !isdefined( hostplayer ) )
    {
        return;
    }
    
    while ( hostplayer buttonpressed( "DPAD_LEFT" ) )
    {
        waitframe();
    }
    
    while ( !hostplayer buttonpressed( "DPAD_LEFT" ) )
    {
        waitframe();
    }
    
    level notify( #"endingSceneStop" );
    br_ending::cleanup_ending( level.br_ending );
    function_488b3360ba7f6153();
}

// Namespace ftue_infilexfil
// Params 0
// Checksum 0x7943e008, Offset: 0x575
// Size: 0x17e
function function_488b3360ba7f6153()
{
    setomnvarforallclients( "ui_world_fade", 1 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 0 );
    br_ending::update_winning_players( [] );
    
    foreach ( player in level.players )
    {
        if ( player.hidehudenabled > 0 )
        {
            player utility::hidehuddisable();
        }
        
        player cameraunlink();
        player stopxcam();
        player unlink();
        
        if ( isdefined( player.player_rig ) )
        {
            player.player_rig delete();
        }
        
        if ( isdefined( player.__ending_origin ) )
        {
            player setorigin( player.__ending_origin );
        }
        
        player br_ending::player_abilities_enable();
        player.plotarmor = undefined;
        player.oobimmunity = undefined;
    }
    
    if ( isdefined( level.br_ending ) )
    {
        if ( isdefined( level.br_ending.transientname ) )
        {
            unloadinfiltransient( level.br_ending.transientname );
        }
        
        br_ending::cleanup_ending( level.br_ending );
        level.br_ending = undefined;
    }
    
    level.playingexfil = 0;
}

