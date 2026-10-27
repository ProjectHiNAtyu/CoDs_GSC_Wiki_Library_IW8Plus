// scripts\mp\br\music_and_dialog.gsc  (hash_1afe14cccd8bbeff.gscc) (size: 4711 Bytes / 0x1267 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc396491b (3281406235)
// size ...... 4711 (0x1267)
// includes .. 4   (offset: 0x1057)
// strings ... 26  (offset: 0x1077)
// dev strs .. 0   (offset: 0x1267)
// exports ... 11  (offset: 0xb4b)
// cseg ...... 0x239 + 0x912 (0xb4b)
// imports ... 25  (offset: 0xd03)
// animtree1 . 0   (offset: 0x1267)
// animtree2 . 0   (offset: 0x1267)
#using script_16ea1b94f0f381b3;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\gamescore;

#namespace music_and_dialog_br;

// Namespace music_and_dialog_br
// Params 3
// Checksum 0x2c66091c, Offset: 0x257
// Size: 0x316
function br_circle_music( circleindex, circletotal, var_2687aca5dc3c5f0e )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_2687aca5dc3c5f0e ) )
    {
        var_2687aca5dc3c5f0e = 0.05;
    }
    
    assert( isnumber( circleindex ) );
    assert( isnumber( circletotal ) );
    
    if ( isstruct( level.br_circle ) )
    {
        if ( isnumber( level.br_circle.var_5250f41412e1fb53 ) && level.br_circle.var_5250f41412e1fb53 == circleindex )
        {
            return;
        }
        else
        {
            level.br_circle.var_5250f41412e1fb53 = circleindex;
        }
    }
    
    var_3379f9556c1b34a7 = int( circletotal - 1 );
    var_642cc23c551931e6 = var_3379f9556c1b34a7 / 3;
    var_588f2cc8afa138a1 = int( floor( var_642cc23c551931e6 ) );
    var_aae9e9363c9ab326 = int( var_588f2cc8afa138a1 * 3 );
    var_4228de8e1ee38763 = int( max( 0, var_3379f9556c1b34a7 - var_aae9e9363c9ab326 ) );
    lowindex = int( var_588f2cc8afa138a1 ) - 1;
    medindex = int( var_588f2cc8afa138a1 * 2 + var_4228de8e1ee38763 ) - 1;
    highindex = int( var_588f2cc8afa138a1 * 3 );
    finalindex = int( max( 1, circletotal - 1 ) );
    waittime = max( 0.05, var_2687aca5dc3c5f0e );
    wait waittime;
    br_circle_state = "";
    br_circle_state_classic = "";
    
    if ( circleindex <= lowindex )
    {
        br_circle_state = audio_utility::function_d4d265f3dcd0a13c( "br_ring_low" );
        br_circle_state_classic = audio_utility::function_d4d265f3dcd0a13c( "br_ring_low_classic" );
    }
    else if ( circleindex <= medindex )
    {
        br_circle_state = audio_utility::function_d4d265f3dcd0a13c( "br_ring_med" );
        br_circle_state_classic = audio_utility::function_d4d265f3dcd0a13c( "br_ring_med_classic" );
    }
    else if ( circleindex <= highindex )
    {
        br_circle_state = audio_utility::function_d4d265f3dcd0a13c( "br_ring_high" );
        br_circle_state_classic = audio_utility::function_d4d265f3dcd0a13c( "br_ring_high_classic" );
    }
    else if ( circleindex == finalindex )
    {
        br_circle_state = audio_utility::function_d4d265f3dcd0a13c( "br_ring_final" );
        br_circle_state_classic = audio_utility::function_d4d265f3dcd0a13c( "br_ring_final_classic" );
    }
    
    players = function_8d3db877aaccbd2e();
    exfil_players = [];
    
    foreach ( player in players )
    {
        if ( isplayer( player ) && player.var_d91b23b8f5ff99d6 )
        {
            exfil_players[ exfil_players.size ] = player;
        }
    }
    
    players = arrayremove( players, exfil_players );
    audio_utility::function_6a0ed3b9fb942369( players, br_circle_state, undefined, undefined, br_circle_state_classic );
    
    if ( circleindex != finalindex )
    {
        wait 30;
        audio_utility::function_6a0ed3b9fb942369( players, "", undefined, "wartracks" );
    }
}

// Namespace music_and_dialog_br
// Params 1
// Checksum 0x5fa34270, Offset: 0x575
// Size: 0xda
function function_8d3db877aaccbd2e( players = level.players )
{
    br_players = [];
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            var_6dcaff7a6b1fdf18 = player namespace_9d8e359c3b1041e5::isplayerinorgoingtogulagsharedfunc();
            
            if ( isplayer( player ) && !isagent( player ) && !isbot( player ) && !var_6dcaff7a6b1fdf18 )
            {
                br_players[ br_players.size ] = player;
            }
        }
    }
    
    return br_players;
}

// Namespace music_and_dialog_br
// Params 0
// Checksum 0xa999e3cc, Offset: 0x658
// Size: 0x7e
function plunder_thirtypercent_music()
{
    level endon( #"hash_c4a3e7c6737a489e" );
    
    if ( level.thirtypercent_music == 1 )
    {
        return;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    level notify( #"hash_94e235a6ed948fda" );
    numtracks = game[ "music" ][ "plunder_tenpercent" ].size;
    tracknum = randomint( numtracks );
    setmusicstate( game[ "music" ][ "plunder_tenpercent" ][ tracknum ] );
    level.thirtypercent_music = 1;
}

// Namespace music_and_dialog_br
// Params 1
// Checksum 0x9436db3a, Offset: 0x6de
// Size: 0x88
function plunder_fiftypercent_music( team )
{
    level endon( #"hash_8d52a506c3923ef2" );
    
    if ( level.fiftypercent_music == 1 )
    {
        return;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    numtracks = game[ "music" ][ "plunder_thirtypercent" ].size;
    tracknum = randomint( numtracks );
    setmusicstate( game[ "music" ][ "plunder_thirtypercent" ][ tracknum ] );
    level.fiftypercent_music = 1;
    level notify( #"hash_c4a3e7c6737a489e" );
}

// Namespace music_and_dialog_br
// Params 1
// Checksum 0x5b98c6b2, Offset: 0x76e
// Size: 0x88
function plunder_seventyfivepercent_music( team )
{
    level endon( #"hash_fae709abc94cf42b" );
    
    if ( level.seventyfivepercent_music == 1 )
    {
        return;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    numtracks = game[ "music" ][ "plunder_fiftypercent" ].size;
    tracknum = randomint( numtracks );
    setmusicstate( game[ "music" ][ "plunder_fiftypercent" ][ tracknum ] );
    level.seventyfivepercent_music = 1;
    level notify( #"hash_8d52a506c3923ef2" );
}

// Namespace music_and_dialog_br
// Params 1
// Checksum 0x80925a4c, Offset: 0x7fe
// Size: 0x7c
function plunder_ninetypercent_music( team )
{
    if ( level.ninetypercent_music == 1 )
    {
        return;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    numtracks = game[ "music" ][ "plunder_seventyfivepercent" ].size;
    tracknum = randomint( numtracks );
    setmusicstate( game[ "music" ][ "plunder_seventyfivepercent" ][ tracknum ] );
    level.ninetypercent_music = 1;
    level notify( #"hash_fae709abc94cf42b" );
}

// Namespace music_and_dialog_br
// Params 0
// Checksum 0x950da0b7, Offset: 0x882
// Size: 0x66
function plunder_overtime_music()
{
    if ( level.overtime_music == 1 )
    {
        return;
    }
    
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    numtracks = game[ "music" ][ "plunder_ninetypercent" ].size;
    tracknum = randomint( numtracks );
    setmusicstate( game[ "music" ][ "plunder_ninetypercent" ][ tracknum ] );
    level.overtime_music = 1;
}

// Namespace music_and_dialog_br
// Params 0
// Checksum 0xe35ca083, Offset: 0x8f0
// Size: 0x1f7
function plunder_endgame_music()
{
    if ( isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
    game[ "music" ][ "payback_lose" ] = [];
    game[ "music" ][ "payback_lose" ][ game[ "music" ][ "payback_lose" ].size ] = "mp_lose_1";
    game[ "music" ][ "payback_lose" ][ game[ "music" ][ "payback_lose" ].size ] = "mp_draw_1";
    game[ "music" ][ "payback_lose" ][ game[ "music" ][ "payback_lose" ].size ] = "mp_lose_2";
    game[ "music" ][ "payback_lose" ][ game[ "music" ][ "payback_lose" ].size ] = "mp_draw_1";
    game[ "music" ][ "payback_win" ] = [];
    game[ "music" ][ "payback_win" ][ game[ "music" ][ "payback_win" ].size ] = "mp_win_1";
    game[ "music" ][ "payback_win" ][ game[ "music" ][ "payback_win" ].size ] = "mp_win_2";
    placements = gamescore::getteamscoreplacements();
    level.endmusicplayed = 1;
    
    foreach ( player in level.players )
    {
        placement = placements[ player.team ];
        
        if ( placement <= 10 )
        {
            payback_win = audio_utility::function_d4d265f3dcd0a13c( "payback_win" );
            player setplayermusicstate( payback_win );
        }
        else
        {
            payback_lose = audio_utility::function_d4d265f3dcd0a13c( "payback_lose" );
            player setplayermusicstate( payback_lose );
        }
        
        player setsoundsubmix( "mp_matchend_music", 2 );
        player enableplayerbreathsystem( 0 );
    }
}

// Namespace music_and_dialog_br
// Params 0
// Checksum 0x2dc560fe, Offset: 0xaef
// Size: 0x2e
function function_5fe360849893c300()
{
    if ( level.overtime_music )
    {
        return;
    }
    
    setmusicstate( game[ "music" ][ "plunder_bonustime_long" ][ 0 ] );
    level.overtime_music = 1;
}

// Namespace music_and_dialog_br
// Params 0
// Checksum 0x8fa7e6a2, Offset: 0xb25
// Size: 0x26
function function_ddacd2c9bc24f87e()
{
    if ( !isdefined( self.warp_music ) )
    {
        self.warp_music = 1;
        self setplayermusicstate( "iw9_mp_dmz_biobunker_enter" );
    }
}

