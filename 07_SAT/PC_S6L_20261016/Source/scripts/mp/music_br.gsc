// scripts\mp\music_br.gsc  (hash_43a8093656c84856.gscc) (size: 7455 Bytes / 0x1d1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2872e23f (678617663)
// size ...... 7455 (0x1d1f)
// includes .. 8   (offset: 0x1b4b)
// strings ... 11  (offset: 0x1b8b)
// dev strs .. 18  (offset: 0x1c13)
// exports ... 38  (offset: 0xec3)
// cseg ...... 0xf6 + 0xdcd (0xec3)
// imports ... 50  (offset: 0x14b3)
// animtree1 . 0   (offset: 0x1d1f)
// animtree2 . 0   (offset: 0x1d1f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\gamescore;

#namespace music_br;

// Namespace music_br
// Params 0
// Checksum 0x2183576a, Offset: 0x114
// Size: 0x47
function init()
{
    level.nosuspensemusic = 1;
    musicbank_utility::init_musicbanks();
    utility::registersharedfunc( #"br", #"hash_6273eabc6f3c9c58", &function_cf834448db92f66a );
    callback::add( #"player_connect", &onplayerconnect );
}

// Namespace music_br
// Params 1
// Checksum 0x74a1a592, Offset: 0x163
// Size: 0x47
function onplayerconnect( params )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    musicpack = self getplayerdata( "common", "commonCustomization", "musicbox" );
    self.musicpack = musicpack;
    musicbank_utility::function_c5abc550e9f75f30();
}

/#

    // Namespace music_br
    // Params 0, eflags: 0x4
    // Checksum 0xcbd4e84c, Offset: 0x1b2
    // Size: 0x5, Type: dev
    function private function_2f8bab071e3e576a()
    {
        
    }

#/

// Namespace music_br
// Params 1
// Checksum 0x995ed2e7, Offset: 0x1bf
// Size: 0x12a
function function_b470fe57c3fc9749( players = level.players )
{
    br_players = [];
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            var_6dcaff7a6b1fdf18 = player namespace_9d8e359c3b1041e5::isplayerinorgoingtogulagsharedfunc();
            var_48eb0d752fcb7698 = istrue( player.var_d91b23b8f5ff99d6 );
            var_9e12fbacf0be5b04 = istrue( player.brwinnerscircle );
            
            if ( isplayer( player ) && !isagent( player ) && !isbot( player ) && !var_6dcaff7a6b1fdf18 && !var_48eb0d752fcb7698 && !var_9e12fbacf0be5b04 )
            {
                br_players[ br_players.size ] = player;
            }
        }
    }
    else
    {
        assertmsg( "<dev string:x24>" + "<dev string:x40>" );
    }
    
    return br_players;
}

/#

    // Namespace music_br
    // Params 0, eflags: 0x4
    // Checksum 0xdefe562b, Offset: 0x2f2
    // Size: 0x5, Type: dev
    function private function_4f9a6ca901f77293()
    {
        
    }

#/

// Namespace music_br
// Params 1
// Checksum 0x585241da, Offset: 0x2ff
// Size: 0xdc
function function_1a27a248097165ef( players )
{
    assert( isarray( players ), "<dev string:x63>" + "<dev string:x40>" );
    
    if ( game_utility::getgametype() == "dmz" )
    {
        return;
    }
    
    lead_in_time = 9;
    map_name = game_utility::getmapname();
    
    if ( isstring( map_name ) && isstartstr( map_name, "mp_wz2_sierra" ) )
    {
        lead_in_time = 13;
    }
    
    if ( level.matchcountdowntime > lead_in_time )
    {
        waittime = level.matchcountdowntime - lead_in_time;
        wait waittime;
        musicbank_utility::function_5aca66c390aa347d( players, #"br_lobby_outro" );
        audio_utility::function_f8fa1bfbdb18edb5( players, "mp_br_lobby_fade", 8 );
        return;
    }
    
    println( "<dev string:x7f>" + level.matchcountdowntime );
}

// Namespace music_br
// Params 1
// Checksum 0x42f59507, Offset: 0x3e3
// Size: 0x40
function function_af7220102b36ae29( players )
{
    assert( isarray( players ), "<dev string:xae>" + "<dev string:x40>" );
    musicbank_utility::function_4f253fd35ec68cbc( players );
    musicbank_utility::function_5aca66c390aa347d( players, #"br_infil" );
}

// Namespace music_br
// Params 1
// Checksum 0xf8f312a5, Offset: 0x42b
// Size: 0x45
function function_68293509b7c0bc7( player )
{
    assert( isplayer( player ), "<dev string:xc7>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_infil_jump" );
    player.jump_music = 1;
}

// Namespace music_br
// Params 1
// Checksum 0x36849f3d, Offset: 0x478
// Size: 0x93
function function_cf834448db92f66a( player )
{
    assert( isplayer( player ), "<dev string:x101>" + "<dev string:xdf>" );
    
    if ( player.jump_music == 1 )
    {
        var_25948400f7a49343 = 0;
        map_name = game_utility::getmapname();
        
        if ( isstring( map_name ) && isstartstr( map_name, "mp_wz2_sierra" ) )
        {
            var_25948400f7a49343 = 1;
        }
        
        if ( var_25948400f7a49343 )
        {
            musicbank_utility::function_5aca66c390aa347d( player, #"br_infil_jump_parachute" );
        }
        
        player.jump_music = 0;
    }
}

// Namespace music_br
// Params 1
// Checksum 0x35549e27, Offset: 0x513
// Size: 0x37
function function_a7fb040e884f8833( players )
{
    assert( isarray( players ), "<dev string:x122>" + "<dev string:x40>" );
    musicbank_utility::function_5aca66c390aa347d( players, #"br_exfil" );
}

// Namespace music_br
// Params 1
// Checksum 0xe0bae2e0, Offset: 0x552
// Size: 0x37
function function_7373b0c330e6519( player )
{
    assert( isplayer( player ), "<dev string:x13b>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_gulag_intro" );
}

// Namespace music_br
// Params 1
// Checksum 0xbf722a02, Offset: 0x591
// Size: 0x37
function function_4a82360c26e13c11( player )
{
    assert( isplayer( player ), "<dev string:x154>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_gulag_win" );
}

// Namespace music_br
// Params 1
// Checksum 0xc350c83f, Offset: 0x5d0
// Size: 0x37
function function_f9d258715af63e80( player )
{
    assert( isplayer( player ), "<dev string:x16b>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_gulag_lose" );
}

// Namespace music_br
// Params 1
// Checksum 0xf818d8b7, Offset: 0x60f
// Size: 0x37
function function_9b0c03ce19bdfe20( player )
{
    assert( isplayer( player ), "<dev string:x183>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_gulag_outro" );
}

// Namespace music_br
// Params 1
// Checksum 0xe48cead, Offset: 0x64e
// Size: 0x57
function function_800a641abdbdca63( musicbankevent )
{
    if ( isxhash( musicbankevent ) && musicbankevent != #"" )
    {
        players = function_b470fe57c3fc9749();
        audio_utility::function_6a0ed3b9fb942369( players, "", undefined, "wartracks" );
        waitframe();
        waitframe();
        musicbank_utility::function_5aca66c390aa347d( players, musicbankevent );
    }
}

// Namespace music_br
// Params 3
// Checksum 0x87dcdbab, Offset: 0x6ad
// Size: 0x226
function function_fe87426d6e01e1a5( circleindex, circletotal, delaytime )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0.05;
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
    highindex = int( var_588f2cc8afa138a1 * 3 ) - 1;
    finalindex = int( max( 1, circletotal - 1 ) );
    waittime = max( 0.05, delaytime );
    wait waittime;
    musicbankevent = #"";
    
    if ( circleindex <= lowindex )
    {
        musicbankevent = #"br_circle_close_low";
    }
    else if ( circleindex <= medindex )
    {
        musicbankevent = #"br_circle_close_med";
    }
    else if ( circleindex <= highindex )
    {
        musicbankevent = #"br_circle_close_high";
    }
    else if ( circleindex == finalindex )
    {
        function_800a641abdbdca63( #"br_circle_close_high" );
        
        while ( !level.circleclosing )
        {
            waitframe();
        }
        
        musicbankevent = #"br_circle_close_final";
    }
    
    function_800a641abdbdca63( musicbankevent );
}

// Namespace music_br
// Params 1
// Checksum 0xed7527a, Offset: 0x8db
// Size: 0x37
function function_3f8afb44656937d7( player )
{
    assert( isplayer( player ), "<dev string:x19c>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_winners_circle" );
}

// Namespace music_br
// Params 1
// Checksum 0x2b52e07c, Offset: 0x91a
// Size: 0x2e
function function_f3392105d8ec1ad2( player )
{
    assert( isplayer( player ), "<dev string:x1bd>" + "<dev string:xdf>" );
    musicbank_utility::function_4f253fd35ec68cbc( player );
}

/#

    // Namespace music_br
    // Params 0, eflags: 0x4
    // Checksum 0xe81529ab, Offset: 0x950
    // Size: 0x5, Type: dev
    function private function_ec975b83e077a8c3()
    {
        
    }

#/

// Namespace music_br
// Params 0
// Checksum 0xb4e9adb1, Offset: 0x95d
// Size: 0x39
function function_80eb8d35f2f8013()
{
    players = function_b470fe57c3fc9749( level.players );
    utility::delaythread( 0.8, &musicbank_utility::function_5aca66c390aa347d, players, #"br_cq_elementfound" );
}

// Namespace music_br
// Params 0
// Checksum 0xbfc51694, Offset: 0x99e
// Size: 0x2f
function function_93cd8f6274d9a5fe()
{
    players = function_b470fe57c3fc9749( level.players );
    musicbank_utility::function_5aca66c390aa347d( players, #"hash_7867526b5db5120e" );
}

// Namespace music_br
// Params 0
// Checksum 0x2fe108dc, Offset: 0x9d5
// Size: 0x2f
function function_f0d88829286f07de()
{
    players = function_b470fe57c3fc9749( level.players );
    musicbank_utility::function_5aca66c390aa347d( players, #"hash_3c2feeca8e78b16e" );
}

// Namespace music_br
// Params 0
// Checksum 0x1d801557, Offset: 0xa0c
// Size: 0x2f
function function_736c3fc77a5028e9()
{
    players = function_b470fe57c3fc9749( level.players );
    musicbank_utility::function_5aca66c390aa347d( players, #"hash_ec267930b0560bb9" );
}

// Namespace music_br
// Params 0
// Checksum 0xdece194, Offset: 0xa43
// Size: 0x2f
function function_eed73b628c03adc1()
{
    players = function_b470fe57c3fc9749( level.players );
    musicbank_utility::function_5aca66c390aa347d( players, #"br_cq_exfil" );
}

// Namespace music_br
// Params 0
// Checksum 0x6c8d1c73, Offset: 0xa7a
// Size: 0x2f
function function_202a2c9c7f440549()
{
    players = function_b470fe57c3fc9749( level.players );
    musicbank_utility::function_5aca66c390aa347d( players, #"hash_f6d042774d9cae83" );
}

/#

    // Namespace music_br
    // Params 0, eflags: 0x4
    // Checksum 0x673d8b7c, Offset: 0xab1
    // Size: 0x5, Type: dev
    function private function_26d421c8b830cacd()
    {
        
    }

#/

// Namespace music_br
// Params 1
// Checksum 0xf2943caa, Offset: 0xabe
// Size: 0x37
function function_a690c87bd8c0197f( player )
{
    assert( isplayer( player ), "<dev string:x1dc>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_sv_exfil_loop" );
}

// Namespace music_br
// Params 1
// Checksum 0xbd7435a3, Offset: 0xafd
// Size: 0x37
function function_e037ff88764c5c4d( player )
{
    assert( isplayer( player ), "<dev string:x204>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_sv_exfil_abort" );
}

// Namespace music_br
// Params 1
// Checksum 0xa84197a0, Offset: 0xb3c
// Size: 0x37
function function_1a1e8952968743f4( player )
{
    assert( isplayer( player ), "<dev string:x22d>" + "<dev string:xdf>" );
    musicbank_utility::function_5aca66c390aa347d( player, #"br_sv_exfil_success" );
}

/#

    // Namespace music_br
    // Params 0, eflags: 0x4
    // Checksum 0x58a6b2e5, Offset: 0xb7b
    // Size: 0x5, Type: dev
    function private function_74bd7e84b6dca84c()
    {
        
    }

#/

// Namespace music_br
// Params 2
// Checksum 0x4202ef70, Offset: 0xb88
// Size: 0x94
function function_62cd7abed575c794( total, wincost )
{
    if ( br_public::function_379fb7b09f4ef13e() )
    {
        return;
    }
    
    level notify( #"hash_94e235a6ed948fda" );
    
    if ( total >= wincost * level.plundermusicfourth )
    {
        thread function_2ea5d76018c5d51b();
        return;
    }
    
    if ( total >= wincost * level.plundermusicthird )
    {
        thread function_e75e63359a6b1a86();
        return;
    }
    
    if ( total >= wincost * level.plundermusicsecond )
    {
        thread function_78b8e843dfcf5f42();
        return;
    }
    
    if ( total >= wincost * level.plundermusicfirst )
    {
        thread function_26146b107077245e();
    }
}

// Namespace music_br
// Params 0
// Checksum 0xd5144fd6, Offset: 0xc24
// Size: 0x42
function function_26146b107077245e()
{
    level endon( #"hash_c4a3e7c6737a489e" );
    
    if ( level.thirtypercent_music == 1 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( level.players, #"br_plunder_tenpercent" );
    level.thirtypercent_music = 1;
}

// Namespace music_br
// Params 0
// Checksum 0x17bd9565, Offset: 0xc6e
// Size: 0x4e
function function_78b8e843dfcf5f42()
{
    level endon( #"hash_8d52a506c3923ef2" );
    
    if ( level.fiftypercent_music == 1 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( level.players, #"br_plunder_thirtypercent" );
    level.fiftypercent_music = 1;
    level notify( #"hash_c4a3e7c6737a489e" );
}

// Namespace music_br
// Params 1
// Checksum 0x26c12620, Offset: 0xcc4
// Size: 0x58
function function_e75e63359a6b1a86( team )
{
    level endon( #"hash_fae709abc94cf42b" );
    
    if ( level.seventyfivepercent_music == 1 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( level.players, #"br_plunder_fiftypercent" );
    level.seventyfivepercent_music = 1;
    level notify( #"hash_8d52a506c3923ef2" );
}

// Namespace music_br
// Params 1
// Checksum 0x454c60f7, Offset: 0xd24
// Size: 0x4c
function function_2ea5d76018c5d51b( team )
{
    if ( level.ninetypercent_music == 1 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( level.players, #"br_plunder_seventyfivepercent" );
    level.ninetypercent_music = 1;
    level notify( #"hash_fae709abc94cf42b" );
}

// Namespace music_br
// Params 0
// Checksum 0xd260deea, Offset: 0xd78
// Size: 0x36
function function_2b95e02fa518a0cb()
{
    if ( level.overtime_music == 1 )
    {
        return;
    }
    
    musicbank_utility::function_5aca66c390aa347d( level.players, #"br_plunder_bonustime" );
    level.overtime_music = 1;
}

// Namespace music_br
// Params 0
// Checksum 0x2cd52fd2, Offset: 0xdb6
// Size: 0x10d
function function_7bb770e8a850621e()
{
    if ( isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
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

