// script_6937470d4686c6d1  (hash_6937470d4686c6d1.gscc) (size: 18243 Bytes / 0x4743 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2d9545d (4074329181)
// size ...... 18243 (0x4743)
// includes .. 12  (offset: 0x4147)
// strings ... 48  (offset: 0x41a7)
// dev strs .. 8   (offset: 0x456b)
// exports ... 31  (offset: 0x2edf)
// cseg ...... 0x5d5 + 0x290a (0x2edf)
// imports ... 106 (offset: 0x33b7)
// animtree1 . 1   (offset: 0x45cb)
// animtree2 . 18  (offset: 0x45d7)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;

#namespace dmz_infils;

#using_animtree( "script_model" );

// Namespace dmz_infils
// Params 0
// Checksum 0x8a4492fe, Offset: 0x5f3
// Size: 0x2a5
function dmzinfil_init()
{
    if ( getdvarint( @"hash_ff65c25889692db8", 0 ) == 1 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_9c43b60485fbd92e", 0 ) == 1 )
    {
        if ( !level.var_fd20745a67b1343c )
        {
            level thread function_96564d36ad8ce6e7();
        }
        
        return;
    }
    
    level.dmzinfil_enabled = 1;
    lui_game_event_aggregator::registeronluieventcallback( &function_ae183ad3a1fd5786 );
    level.var_f431229b6f925b02 = getdvarint( @"hash_b4dd40c7e16f3a0d", 1 );
    level.var_1fe251a0816de48a = getdvarint( @"hash_4788d52ad8b0d95b", 3 );
    level.var_6bdcf34a4ea35e8a = getdvarint( @"hash_bc48245cbef08083", 10 );
    level.var_3b1cc9b4d59d7d99 = getdvarint( @"hash_966200778cf1b8aa", 0 );
    level.var_f38c267552b027a2 = getdvarint( @"hash_1e69ef33b46f5773", 400 );
    level.var_2b44c115f17a013c = getdvarint( @"hash_403f394c8232fdb1", 0 );
    level.dmzinfil_bonustime = getdvarint( @"hash_b6a86be8437bb573", 5 );
    level.var_34e09e6649b268 = getdvarint( @"hash_f5a76c762ab2ad27", -1 );
    level.var_4eb03954d393a16e = [];
    level.var_65957518390e3d2a = &function_1850a9749b8a371a;
    
    foreach ( team in level.teamnamelist )
    {
        level.requiredplayercount[ team ] = 0;
    }
    
    level.prematchperiod = getdvarint( @"scr_game_graceperiod", 60 );
    infilduration = getanimlength( %iw9_mp_dmz_infil_player1_cam );
    level.matchcountdowntime = infilduration + level.dmzinfil_bonustime;
    level.prematchperiodend = infilduration + level.dmzinfil_bonustime;
    level.var_32c259410c9fde3f = getanimlength( %iw9_mp_dmz_infil_player1_intro );
    level.var_32c259410c9fde3f += getanimlength( %iw9_mp_dmz_infil_player1_exit );
    level.var_32c259410c9fde3f += level.dmzinfil_bonustime;
    thread gamelogic_mp::matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
    
    /#
        if ( getdvarint( @"hash_617f9fc340dd3ac6", 0 ) == 1 )
        {
            level thread dmzinfil_drawdebug();
        }
    #/
    
    function_f9754f76b70a31f2();
    level thread function_9f7aa1a12ade6d14();
}

// Namespace dmz_infils
// Params 2
// Checksum 0x1bc9035, Offset: 0x8a0
// Size: 0x2b
function function_ae183ad3a1fd5786( channel, val )
{
    if ( channel == "ui_dmz_mission_overlay" )
    {
        self.var_bd7fff5fc65bde1c = 1;
    }
}

// Namespace dmz_infils
// Params 0
// Checksum 0xd1a4a41, Offset: 0x8d3
// Size: 0x22
function function_96564d36ad8ce6e7()
{
    level.infilcompleted = 1;
    level waittill( #"match_start_real_countdown" );
    level thread function_4893b52515f3303e();
}

// Namespace dmz_infils
// Params 0
// Checksum 0x63bc1b39, Offset: 0x8fd
// Size: 0x104
function dmzinfil_drawdebug()
{
    wait 10;
    
    foreach ( point in level.startpoints )
    {
        level thread function_7d67bf55c507b79a( point.origin );
        
        if ( isdefined( point.target ) )
        {
            ent = utility::getstruct( point.target, "targetname" );
            level thread function_7d67bf55c507b79a( ent.origin );
            
            if ( isdefined( ent.target ) )
            {
                ent = utility::getstruct( ent.target, "targetname" );
                level thread function_7d67bf55c507b79a( ent.origin );
            }
        }
    }
}

// Namespace dmz_infils
// Params 1
// Checksum 0x21607e87, Offset: 0xa09
// Size: 0x51
function function_7d67bf55c507b79a( pos )
{
    color = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
    interval = 1;
    
    while ( true )
    {
        level thread debug::drawsphere( pos, 32, interval, color );
        wait interval;
    }
}

// Namespace dmz_infils
// Params 0
// Checksum 0x8cf31a1b, Offset: 0xa62
// Size: 0x298
function function_1850a9749b8a371a()
{
    var_5b44f7327973c534 = getdvarint( @"hash_753d5d5f25ef4ef3", 1 ) == 1;
    
    if ( !isdefined( level.var_59938a4fb959d157 ) )
    {
        level.var_59938a4fb959d157 = gettime();
    }
    
    if ( !isdefined( level.var_6bf3e7b03a6894be ) )
    {
        level.var_6bf3e7b03a6894be = gettime();
    }
    else
    {
        level.var_69790ceda947aa2b = gettime();
    }
    
    streamcomplete = 0;
    lobbysize = function_e2939bfa2e5a9527();
    
    if ( level.players.size < lobbysize )
    {
        level.var_59938a4fb959d157 = gettime();
        return 0;
    }
    
    if ( gettime() - level.var_59938a4fb959d157 < level.var_f38c267552b027a2 )
    {
        return 0;
    }
    
    if ( level.players.size > 0 )
    {
        streamcomplete = 1;
        
        foreach ( team in level.teamnamelist )
        {
            players = teams::getteamdata( team, "players" );
            
            foreach ( player in players )
            {
                if ( var_5b44f7327973c534 && !player ispredictedstreamposready() )
                {
                    streamcomplete = 0;
                    break;
                }
                
                if ( !player.pers[ "streamSyncComplete" ] || player.model == "" )
                {
                    if ( !player.pers[ "streamSyncComplete" ] )
                    {
                        if ( !isdefined( player.var_6b016f3c25b5aa46 ) )
                        {
                            player.var_6b016f3c25b5aa46 = gettime();
                        }
                        else
                        {
                            player.var_344d246a87b8c103 = gettime();
                        }
                    }
                    
                    if ( player.model == "" )
                    {
                        if ( !isdefined( player.var_788c96dd615b6f58 ) )
                        {
                            player.var_788c96dd615b6f58 = gettime();
                        }
                        else
                        {
                            player.var_d6a5994e9a5f1da9 = gettime();
                        }
                    }
                    
                    streamcomplete = 0;
                    break;
                }
            }
            
            if ( !streamcomplete )
            {
                break;
            }
        }
    }
    
    return streamcomplete;
}

// Namespace dmz_infils
// Params 0
// Checksum 0x4ad57e9f, Offset: 0xd03
// Size: 0x258
function function_9f7aa1a12ade6d14()
{
    level waittill( #"match_start_real_countdown" );
    level thread function_4893b52515f3303e();
    
    /#
        if ( isdefined( level.var_6bf3e7b03a6894be ) )
        {
            logstring( "<dev string:x24>" + level.var_6bf3e7b03a6894be );
        }
        
        if ( isdefined( level.var_69790ceda947aa2b ) )
        {
            logstring( "<dev string:x51>" + level.var_69790ceda947aa2b );
        }
    #/
    
    foreach ( teamname in level.teamnamelist )
    {
        teamcount = teams::getteamdata( teamname, "teamCount" );
        
        if ( teamcount )
        {
            level thread function_a3758aeadae30aab( teamname, "dmz_infil_" );
        }
    }
    
    /#
        while ( true )
        {
            if ( getdvarint( @"scr_test_dmzinfil", 0 ) == 1 )
            {
                foreach ( teamname in level.teamswithplayers )
                {
                    function_a3758aeadae30aab( teamname, "<dev string:x7c>" );
                }
                
                setdvar( @"scr_test_dmzinfil", 0 );
            }
            
            if ( getdvarint( @"hash_5265d7653ffa2075", 0 ) == 1 )
            {
                level thread function_48f3ddc8d5579d98();
                setdvar( @"hash_5265d7653ffa2075", 0 );
            }
            
            if ( getdvarint( @"hash_36d8fafa1638eac", 0 ) == 1 )
            {
                level thread function_68cee76353f2a170();
                setdvar( @"hash_36d8fafa1638eac", 0 );
            }
            
            if ( getdvarint( @"hash_449f5bb718a70589", 0 ) != 0 )
            {
                level thread function_fc76abeee9919e4e( getdvarint( @"hash_449f5bb718a70589", 0 ) );
                setdvar( @"hash_449f5bb718a70589", 0 );
            }
            
            if ( getdvarint( @"hash_59ece44a02195133", 0 ) == 1 )
            {
                level.var_e2d86942743acd5 = 1;
                setdvar( @"hash_59ece44a02195133", 0 );
            }
            
            wait 1;
        }
    #/
}

// Namespace dmz_infils
// Params 0
// Checksum 0xf628d25c, Offset: 0xf63
// Size: 0x67
function function_4893b52515f3303e()
{
    level notify( #"dmzinfil_start" );
    setomnvar( "ui_in_infil", 1 );
    wait level.prematchperiodend - 4;
    setomnvar( "ui_in_infil", 2 );
    level notify( #"hash_8dad50f3fb34ae22" );
    level waittill( #"prematch_done" );
    setomnvar( "ui_in_infil", -1 );
    level notify( #"dmzinfil_start" );
}

// Namespace dmz_infils
// Params 0
// Checksum 0xb3fb35c2, Offset: 0xfd2
// Size: 0x209
function function_e0e5b04c43cff19d()
{
    timer = 0;
    
    if ( level.var_3b1cc9b4d59d7d99 )
    {
        maxplayers = getdvarint( @"party_maxplayers", 0 );
        
        while ( level.players.size < maxplayers )
        {
            timer += level.framedurationseconds;
            
            if ( timer > level.var_6bdcf34a4ea35e8a )
            {
                return timer;
            }
            
            waitframe();
        }
    }
    
    if ( level.var_1fe251a0816de48a > 0 )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( teams::getteamdata( team, "teamCount" ) )
            {
                streamcomplete = 0;
                
                for ( players = teams::getteamdata( team, "players" ); players.size < level.var_1fe251a0816de48a || !streamcomplete ; players = teams::getteamdata( team, "players" ) )
                {
                    timer += level.framedurationseconds;
                    
                    if ( players.size >= level.var_1fe251a0816de48a )
                    {
                        streamcomplete = 1;
                        
                        foreach ( player in players )
                        {
                            if ( !player.pers[ "streamSyncComplete" ] || player.model == "" )
                            {
                                streamcomplete = 0;
                            }
                        }
                    }
                    
                    if ( timer > level.var_6bdcf34a4ea35e8a )
                    {
                        return timer;
                    }
                    
                    waitframe();
                }
            }
        }
    }
    
    return timer;
}

// Namespace dmz_infils
// Params 0
// Checksum 0xcff19e91, Offset: 0x11e4
// Size: 0x423
function function_f9754f76b70a31f2()
{
    level.scr_anim[ "dmzExfil_player0" ][ "dmz_infil_proto_a" ] = %iw9_mp_infil_proto_a_guy_a;
    level.scr_eventanim[ "dmzExfil_player0" ][ "dmz_infil_proto_a" ] = getanimname( %iw9_mp_infil_proto_a_guy_a );
    level.scr_anim[ "dmzExfil_player1" ][ "dmz_infil_proto_a" ] = %iw9_mp_infil_proto_a_guy_b;
    level.scr_eventanim[ "dmzExfil_player1" ][ "dmz_infil_proto_a" ] = getanimname( %iw9_mp_infil_proto_a_guy_b );
    level.scr_anim[ "dmzExfil_player2" ][ "dmz_infil_proto_a" ] = %iw9_mp_infil_proto_a_guy_c;
    level.scr_eventanim[ "dmzExfil_player2" ][ "dmz_infil_proto_a" ] = getanimname( %iw9_mp_infil_proto_a_guy_c );
    level.scr_anim[ "dmzExfil_player0" ][ "dmz_infil_intro" ] = %iw9_mp_dmz_infil_player1_intro;
    level.scr_eventanim[ "dmzExfil_player0" ][ "dmz_infil_intro" ] = getanimname( %iw9_mp_dmz_infil_player1_intro );
    level.scr_anim[ "dmzExfil_player0" ][ "dmz_infil_idle" ] = %iw9_mp_dmz_infil_player1_idle;
    level.scr_eventanim[ "dmzExfil_player0" ][ "dmz_infil_idle" ] = getanimname( %iw9_mp_dmz_infil_player1_idle );
    level.scr_anim[ "dmzExfil_player0" ][ "dmz_infil_exit" ] = %iw9_mp_dmz_infil_player1_exit;
    level.scr_eventanim[ "dmzExfil_player0" ][ "dmz_infil_exit" ] = getanimname( %iw9_mp_dmz_infil_player1_exit );
    level.scr_anim[ "dmzExfil_player1" ][ "dmz_infil_intro" ] = %iw9_mp_dmz_infil_player2_intro;
    level.scr_eventanim[ "dmzExfil_player1" ][ "dmz_infil_intro" ] = getanimname( %iw9_mp_dmz_infil_player2_intro );
    level.scr_anim[ "dmzExfil_player1" ][ "dmz_infil_idle" ] = %iw9_mp_dmz_infil_player2_idle;
    level.scr_eventanim[ "dmzExfil_player1" ][ "dmz_infil_idle" ] = getanimname( %iw9_mp_dmz_infil_player2_idle );
    level.scr_anim[ "dmzExfil_player1" ][ "dmz_infil_exit" ] = %iw9_mp_dmz_infil_player2_exit;
    level.scr_eventanim[ "dmzExfil_player1" ][ "dmz_infil_exit" ] = getanimname( %iw9_mp_dmz_infil_player2_exit );
    level.scr_anim[ "dmzExfil_player2" ][ "dmz_infil_intro" ] = %iw9_mp_dmz_infil_player3_intro;
    level.scr_eventanim[ "dmzExfil_player2" ][ "dmz_infil_intro" ] = getanimname( %iw9_mp_dmz_infil_player3_intro );
    level.scr_anim[ "dmzExfil_player2" ][ "dmz_infil_idle" ] = %iw9_mp_dmz_infil_player3_idle;
    level.scr_eventanim[ "dmzExfil_player2" ][ "dmz_infil_idle" ] = getanimname( %iw9_mp_dmz_infil_player3_idle );
    level.scr_anim[ "dmzExfil_player2" ][ "dmz_infil_exit" ] = %iw9_mp_dmz_infil_player3_exit;
    level.scr_eventanim[ "dmzExfil_player2" ][ "dmz_infil_exit" ] = getanimname( %iw9_mp_dmz_infil_player3_exit );
    
    if ( getdvarint( @"hash_947a9b74fcbd8126", 1 ) == 1 )
    {
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_" ] = %iw9_mp_dmz_infil_player1_cam;
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_1" ] = %iw9_mp_dmz_infil_player1_cam;
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_2" ] = %iw9_mp_dmz_infil_player2_cam;
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_3" ] = %iw9_mp_dmz_infil_player3_cam;
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_low" ] = %iw9_mp_dmz_infil_player1_lowcam_test;
        return;
    }
    
    if ( getdvarint( @"hash_d38ab35efdb1a60d", 1 ) == 1 )
    {
        level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_proto_a" ] = %iw9_mp_infil_proto_a_guy_cam_alt;
        return;
    }
    
    level.scr_anim[ "dmzExfil_cam" ][ "dmz_infil_proto_a" ] = %iw9_mp_infil_proto_a_guy_cam;
}

// Namespace dmz_infils
// Params 2
// Checksum 0x1014d59c, Offset: 0x160f
// Size: 0x68
function dmzinfil_spawncamera( pos, angles )
{
    cameraent = spawn( "script_model", pos );
    
    if ( isdefined( angles ) )
    {
        cameraent.angles = angles;
    }
    
    cameraent setmodel( "tag_origin" );
    cameraent.animname = "dmzExfil_cam";
    cameraent useanimtree( #animtree );
    return cameraent;
}

// Namespace dmz_infils
// Params 3
// Checksum 0x10789598, Offset: 0x1680
// Size: 0x5e9
function function_a3758aeadae30aab( teamname, animref, overridespawnpoint )
{
    if ( level.mapname == "mp_dmz_hydro" )
    {
        setglobalsoundcontext( "wind", "heavy", 0.05 );
    }
    
    players = teams::getteamdata( teamname, "players" );
    spawnpoint = overridespawnpoint ?? level.teamdata[ teamname ][ "startPoint" ];
    
    foreach ( player in players )
    {
        if ( isdefined( player.var_788c96dd615b6f58 ) )
        {
            logstring( "Player " + player.name + " Model Load Time Start: " + player.var_788c96dd615b6f58 );
        }
        
        if ( isdefined( player.var_d6a5994e9a5f1da9 ) )
        {
            logstring( "Player " + player.name + " Model Load Time End: " + player.var_d6a5994e9a5f1da9 );
        }
        
        if ( isdefined( player.var_6b016f3c25b5aa46 ) )
        {
            logstring( "Player " + player.name + " Stream Sync Time Start: " + player.var_6b016f3c25b5aa46 );
        }
        
        if ( isdefined( player.var_344d246a87b8c103 ) )
        {
            logstring( "Player " + player.name + " Stream Sync Time End: " + player.var_344d246a87b8c103 );
        }
        
        logstring( "Player " + player.name + " Infil Started: " + gettime() );
    }
    
    if ( getdvarint( @"hash_696cc1e380833ac0", 0 ) == 1 )
    {
        players = arrayrandomize( players );
    }
    
    assert( players.size <= 3, "<dev string:x8e>" );
    assert( players.size > 0, "<dev string:xc9>" );
    players = teams::getteamdata( teamname, "players" );
    
    if ( players.size < 1 )
    {
        return;
    }
    
    level.infilcompleted = 1;
    
    if ( isdefined( level.var_3aa9646314b3783c ) )
    {
        spawnpoint = players[ 0 ] [[ level.var_3aa9646314b3783c ]]();
    }
    
    animstructcam = dmzinfil_spawncamera( spawnpoint.origin, spawnpoint.angles );
    animstruct = function_e7e733c4992c3ad8( players[ 0 ], animstructcam, undefined, spawnpoint );
    animstructmain = animstruct;
    
    if ( isdefined( players[ 0 ] ) && players[ 0 ].model != "" )
    {
        players[ 0 ] animation::anim_first_frame_solo( animstruct.cam, animref, "tag_origin" );
    }
    
    teamsize = min( players.size, 3 );
    
    if ( players.size > 3 )
    {
        for ( i = int( teamsize ); i < players.size ; i++ )
        {
            players[ i ] player::_freezecontrols( 0 );
            players[ i ] player::_freezelookcontrols( 0 );
        }
    }
    
    for ( i = 0; i < teamsize ; i++ )
    {
        if ( !isdefined( players[ i ] ) || players[ i ].model == "" )
        {
            continue;
        }
        
        camerastructstart = undefined;
        players[ i ].dmzinfilanimname = "dmzExfil_player" + i;
        
        if ( isdefined( spawnpoint ) && isdefined( spawnpoint.target ) )
        {
            structs = utility::getstructarray( spawnpoint.target, "targetname" );
            
            foreach ( struct in structs )
            {
                if ( struct.script_noteworthy == "infil_camera" )
                {
                    camerastructstart = struct;
                }
            }
        }
        
        if ( i > 0 )
        {
            if ( isdefined( spawnpoint ) && isdefined( spawnpoint.target ) )
            {
                structs = utility::getstructarray( spawnpoint.target, "targetname" );
                
                foreach ( struct in structs )
                {
                    if ( struct.script_noteworthy == "infil_camera" )
                    {
                        camerastructstart = struct;
                        continue;
                    }
                    
                    spawnpoint = struct;
                }
            }
            else
            {
                spawnpoint = undefined;
            }
            
            if ( isdefined( level.var_3aa9646314b3783c ) )
            {
                spawnpoint = players[ i ] [[ level.var_3aa9646314b3783c ]]();
            }
            
            if ( level.var_f431229b6f925b02 == 1 )
            {
                animstructcam = dmzinfil_spawncamera( players[ i ].origin );
                animstruct = function_e7e733c4992c3ad8( players[ i ], animstructcam, animstructmain, spawnpoint, animref );
                
                if ( isdefined( players[ i ] ) && players[ i ].model != "" )
                {
                    players[ i ] animation::anim_first_frame_solo( animstruct.cam, animref + i + 1, "tag_origin" );
                }
            }
            else
            {
                animstruct = function_e7e733c4992c3ad8( players[ i ], animstructcam, animstructmain, spawnpoint, animref );
            }
        }
        
        players[ i ] thread function_cb497c784f06ff8b( animstruct, animref, camerastructstart );
    }
    
    if ( level.var_f431229b6f925b02 == 0 )
    {
        players[ 0 ] thread animation::anim_single_solo( animstruct.cam, animref, "tag_origin" );
    }
    
    level thread dmzinfil_playinfilvo( teamname );
}

// Namespace dmz_infils
// Params 5
// Checksum 0x150ac0c2, Offset: 0x1c71
// Size: 0x34a
function function_e7e733c4992c3ad8( player, cam, relativeto, spawnpoint, animref )
{
    startpoint = undefined;
    
    if ( level.var_2b44c115f17a013c == 1 && isdefined( level.var_4eb03954d393a16e[ player.team ] ) )
    {
        startpoint = level.var_4eb03954d393a16e[ player.team ];
    }
    else if ( isdefined( spawnpoint ) )
    {
        startpoint = spawnpoint;
    }
    else
    {
        startpoint = level.teamdata[ player.team ][ "startPoint" ];
    }
    
    assert( isdefined( startpoint ), "<dev string:xf4>" );
    animstruct = spawnstruct();
    animstruct.origin = utility::player_drop_to_ground( startpoint.origin, 32, undefined, undefined, ( 0, 0, 1 ) );
    animstruct.angles = startpoint.angles;
    animstruct.cam = cam;
    
    if ( isdefined( startpoint.script_parameters ) )
    {
        animstruct.script_parameters = startpoint.script_parameters;
    }
    
    if ( isdefined( relativeto ) )
    {
        animstart = getoriginforanimtime( relativeto.origin, relativeto.angles, level.scr_anim[ player.dmzinfilanimname ][ animref + "intro" ], 1 );
        zpos = utility::player_drop_to_ground( animstart, 32, undefined, undefined, ( 0, 0, 1 ) );
        targetpos = relativeto.origin;
        
        if ( isdefined( spawnpoint ) )
        {
            animstart = getoriginforanimtime( spawnpoint.origin, spawnpoint.angles, level.scr_anim[ player.dmzinfilanimname ][ animref + "intro" ], 1 );
            zpos = utility::player_drop_to_ground( spawnpoint.origin, 32, undefined, undefined, ( 0, 0, 1 ) );
            targetpos = spawnpoint.origin + spawnpoint.origin - animstart;
        }
        
        relativez = relativeto.origin[ 2 ];
        
        if ( isdefined( spawnpoint ) )
        {
            relativez = spawnpoint.origin[ 2 ];
        }
        
        animstruct.origin = ( targetpos[ 0 ], targetpos[ 1 ], relativez + zpos[ 2 ] - animstart[ 2 ] );
        animstruct.angles = relativeto.angles;
        animstruct.campos = spawnstruct();
        animstruct.campos.origin = zpos;
        animstruct.campos.angles = animstruct.angles;
    }
    else
    {
        animstruct.campos = spawnstruct();
        animstruct.campos.origin = animstruct.origin;
        animstruct.campos.angles = animstruct.angles;
    }
    
    return animstruct;
}

// Namespace dmz_infils
// Params 1
// Checksum 0x6a0cb204, Offset: 0x1fc4
// Size: 0x92
function dmzinfil_playinfilvo( team )
{
    wait 2;
    
    if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"match_intro_generic", team );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"match_intro", team );
    }
    
    wait 15;
    
    if ( !level.var_4bdc367855270ff8 )
    {
        br_gametype_dmz::showdmzsplash( "dmz_contract_reminder", teams::getteamdata( team, "players" ) );
    }
}

// Namespace dmz_infils
// Params 3
// Checksum 0xf4841d2, Offset: 0x205e
// Size: 0x18e
function function_7cf9124e5797c1db( cament, path, time )
{
    starttime = gettime();
    totaldist = 0;
    
    for ( i = path.size - 1; i > 0 ; i-- )
    {
        path[ i ].dist = distance( path[ i ].origin, path[ i - 1 ].origin );
        totaldist += path[ i ].dist;
    }
    
    var_492d2f444de0287a = 0;
    var_d6a77bf4410de7d = 0;
    
    for ( i = path.size - 1; i > 0 ; i-- )
    {
        segmentsize = path[ i ].dist / totaldist;
        var_492d2f444de0287a = var_d6a77bf4410de7d;
        var_d6a77bf4410de7d += segmentsize;
        timepercent = ( gettime() - starttime ) / 1000 / time;
        
        while ( timepercent < var_d6a77bf4410de7d )
        {
            timepercent = ( gettime() - starttime ) / 1000 / time;
            segpercent = ( timepercent - var_492d2f444de0287a ) / segmentsize;
            cament.angles = anglelerpquatfrac( path[ i ].angles, path[ i - 1 ].angles, segpercent );
            cament.origin = vectorlerp( path[ i ].origin, path[ i - 1 ].origin, segpercent );
            waitframe();
        }
    }
}

// Namespace dmz_infils
// Params 3
// Checksum 0x5952f103, Offset: 0x21f4
// Size: 0x382
function function_cb497c784f06ff8b( animstruct, animref, camerastructstart )
{
    assert( isdefined( animstruct ), "<dev string:x11a>" );
    self notify( #"hash_63d05112350ef7bf" );
    self endon( #"disconnect" );
    thread function_3bb035d637e99015();
    thread inventory_utility::givegunlessweapon();
    thread infilexfil::infil_player_rig_updated( self.dmzinfilanimname, self.origin, self.angles );
    self cameraunlink();
    animstruct animation::anim_first_frame_solo( self.player_rig, animref + "intro" );
    self cameralinkto( animstruct.cam, "tag_origin", 1, 1 );
    self setclientdvar( @"cg_fov", 40 );
    
    if ( isdefined( camerastructstart ) && getdvarint( @"hash_5bda28fa688a245c", 0 ) == 1 )
    {
        campath = [ camerastructstart ];
        curnode = camerastructstart;
        
        while ( isdefined( curnode.target ) )
        {
            curnode = utility::getstruct( curnode.target, "targetname" );
            campath[ campath.size ] = curnode;
        }
        
        animstruct thread function_7cf9124e5797c1db( animstruct.cam, campath, getanimlength( %iw9_mp_dmz_infil_player1_intro ) );
    }
    else if ( level.var_f431229b6f925b02 == 1 )
    {
        camanimref = animref;
        
        if ( isdefined( animstruct.script_parameters ) )
        {
            camanimref = animstruct.script_parameters;
        }
        
        animstruct.campos thread animation::anim_single_solo( animstruct.cam, camanimref );
    }
    
    self attach( "offhand2h_wm_tablet_dmz", "tag_accessory_left" );
    animstruct thread anim_mp::anim_player_solo( self, self.player_rig, animref + "intro" );
    self playlocalsound( "dmz_camera_zoom_in" );
    introdur = getanimlength( %iw9_mp_dmz_infil_player1_intro );
    wait introdur - 1.8;
    
    if ( isdefined( self.hidehudenabled ) )
    {
        utility::hidehuddisable();
    }
    
    if ( getdvarint( @"hash_8da4a5e690432cd0", 1 ) == 1 )
    {
        thread function_b19636d57581b868();
        player::_freezecontrols( 0, 1 );
    }
    
    wait 1.8;
    
    if ( level.var_34e09e6649b268 == -1 )
    {
        thread function_de23fc983ca745df();
    }
    else
    {
        thread function_11bd52c6b9331570( level.var_34e09e6649b268 );
    }
    
    self clearadditionalstreampos();
    function_363c47b81e18b2f2( animstruct, animref, 1 );
    animstruct thread anim_mp::anim_player_solo( self, self.player_rig, animref + "exit" );
    
    if ( getdvarint( @"hash_e985d309e4bf9569", 0 ) == 1 )
    {
        thread function_55bf782cab95894f( animstruct.cam );
    }
    else
    {
        thread function_dc1769b5614a15eb( animstruct );
    }
    
    enddur = getanimlength( %iw9_mp_dmz_infil_player1_exit );
    wait enddur;
    attachsize = self getattachsize();
    
    for ( i = 0; i < attachsize ; i++ )
    {
        attached = self getattachmodelname( i );
        
        if ( attached == "offhand2h_wm_tablet_dmz" )
        {
            self detach( "offhand2h_wm_tablet_dmz", "tag_accessory_left" );
        }
    }
    
    if ( getdvarint( @"hash_8da4a5e690432cd0", 1 ) == 0 )
    {
        player::_freezecontrols( 0 );
    }
    
    player::_freezelookcontrols( 0 );
    
    if ( level.var_f431229b6f925b02 == 1 )
    {
        animstruct.cam delete();
    }
    
    self notify( #"dmzInfil_complete" );
}

// Namespace dmz_infils
// Params 0
// Checksum 0xf82db9c5, Offset: 0x257e
// Size: 0x59
function function_3bb035d637e99015()
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 30, "dmzInfil_complete" );
    wait 5;
    
    if ( self getclientomnvar( "ui_world_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayerkeepui( self, 0, 0.5 );
    }
    
    if ( self getclientomnvar( "ui_total_fade" ) > 0 )
    {
        game_utility::fadetoblackforplayer( self, 0, 0.5 );
    }
}

// Namespace dmz_infils
// Params 0
// Checksum 0x565a314d, Offset: 0x25df
// Size: 0x3f
function function_de23fc983ca745df()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3223bbd0c9660601" );
    level waittill( #"prematch_done" );
    self setclientomnvar( "ui_dmz_mission_overlay", 0 );
    self notify( #"hash_3223bbd0c9660601" );
}

// Namespace dmz_infils
// Params 1
// Checksum 0x8048f1ba, Offset: 0x2626
// Size: 0x3f
function function_11bd52c6b9331570( maxtime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3223bbd0c9660601" );
    wait maxtime;
    self setclientomnvar( "ui_dmz_mission_overlay", 0 );
    self notify( #"hash_3223bbd0c9660601" );
}

// Namespace dmz_infils
// Params 3
// Checksum 0xd6d8b1f7, Offset: 0x266d
// Size: 0x60
function function_363c47b81e18b2f2( animstruct, animref, minimumtime )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3223bbd0c9660601" );
    thread function_2a45756902834b7( animstruct, animref );
    wait minimumtime;
    
    while ( !self.var_bd7fff5fc65bde1c )
    {
        waitframe();
    }
    
    self notify( #"hash_3223bbd0c9660601" );
}

// Namespace dmz_infils
// Params 2
// Checksum 0xf9efabd9, Offset: 0x26d5
// Size: 0xcd
function function_2a45756902834b7( animstruct, animref )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3223bbd0c9660601" );
    animlength = getanimlength( level.scr_anim[ self.player_rig.animname ][ animref + "idle" ] );
    
    if ( animlength < 0.1 )
    {
        return;
    }
    
    while ( true )
    {
        if ( !( isdefined( self ) && isdefined( self.player_rig ) ) || !player::isreallyalive( self ) || !isdefined( animstruct ) )
        {
            println( "<dev string:x13a>" );
            return;
        }
        
        animstruct thread anim_mp::anim_player_solo( self, self.player_rig, animref + "idle" );
        wait animlength;
    }
}

// Namespace dmz_infils
// Params 0
// Checksum 0xe33e99e2, Offset: 0x27aa
// Size: 0xf
function function_b19636d57581b868()
{
    self setclientomnvar( "ui_dmz_mission_overlay", 1 );
}

// Namespace dmz_infils
// Params 1
// Checksum 0x5be7f27, Offset: 0x27c1
// Size: 0xed
function function_9faef6a10cba7930( teamname )
{
    timer = 0;
    players = teams::getteamdata( teamname, "players" );
    
    while ( true )
    {
        timer += level.framedurationseconds;
        streamcomplete = 1;
        
        foreach ( player in players )
        {
            if ( !player.pers[ "streamSyncComplete" ] || player.model == "" )
            {
                streamcomplete = 0;
            }
        }
        
        if ( streamcomplete )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace dmz_infils
// Params 0
// Checksum 0xcf805e54, Offset: 0x28b6
// Size: 0x2a
function function_fb04b52af2c2af8a()
{
    player::_freezecontrols( 1 );
    player::_freezelookcontrols( 1 );
    
    while ( self.model == "" )
    {
        waitframe();
    }
}

// Namespace dmz_infils
// Params 1
// Checksum 0x4309427d, Offset: 0x28e8
// Size: 0xca
function function_dc1769b5614a15eb( animstruct )
{
    self endon( #"disconnect" );
    game_utility::fadetoblackforplayerkeepui( self, 1, 0.5 );
    self lerpfovbypreset( "default" );
    self cameraunlink();
    
    if ( player::isreallyalive( self ) )
    {
        if ( isdefined( self.player_rig ) )
        {
            self.player_rig infilexfil::handleweaponstatenotetrack( "drop" );
        }
        
        wait 0.2;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( self.player_rig ) )
        {
            self.player_rig infilexfil::handleweaponstatenotetrack( "raise" );
        }
    }
    
    self setplayerangles( animstruct.angles );
    self notify( #"remove_rig" );
    self notify( #"hash_e5e3bd276d973376" );
    game_utility::fadetoblackforplayerkeepui( self, 0, 0.5 );
}

// Namespace dmz_infils
// Params 1
// Checksum 0x38b528e2, Offset: 0x29ba
// Size: 0xa7
function function_55bf782cab95894f( cam )
{
    newcam = dmzinfil_spawncamera( cam.origin, cam.angles );
    targetpos = self geteye();
    targetangles = self.angles;
    self cameralinkto( newcam, "tag_origin", 1, 1 );
    newcam moveto( targetpos, 1 );
    newcam rotateto( targetangles, 1, 0.5 );
    wait 1;
    self lerpfovbypreset( "default" );
    self cameraunlink();
    self notify( #"remove_rig" );
    newcam delete();
}

// Namespace dmz_infils
// Params 2
// Checksum 0xba9e6c7a, Offset: 0x2a69
// Size: 0x3e
function function_767275ec19a48c9( teamname, node )
{
    level.var_2b44c115f17a013c = 1;
    level.var_4eb03954d393a16e[ teamname ] = node;
    function_a3758aeadae30aab( teamname, "dmz_infil_", node );
}

// Namespace dmz_infils
// Params 0
// Checksum 0x4c490bba, Offset: 0x2aaf
// Size: 0x22a
function function_48f3ddc8d5579d98()
{
    if ( !isdefined( level.playerteams ) )
    {
        level.playerteams = [];
        
        foreach ( player in level.players )
        {
            if ( arraycontains( level.playerteams, player.team ) )
            {
                continue;
            }
            
            level.playerteams[ level.playerteams.size ] = player.team;
        }
    }
    
    level.var_e2d86942743acd5 = 0;
    player = level.players[ 0 ];
    level.allstartpoint = arraycombine( level.startpoints[ 0 ].points, level.startpoints[ 1 ].points );
    
    for ( i = 0; i < level.allstartpoint.size ; i++ )
    {
        offset = 0;
        
        foreach ( team in level.playerteams )
        {
            index = i + offset;
            
            if ( index > level.allstartpoint.size )
            {
                index -= level.allstartpoint.size;
            }
            
            function_767275ec19a48c9( team, level.allstartpoint[ index ] );
            offset += 1;
        }
        
        waitdur = level.var_32c259410c9fde3f;
        
        if ( level.var_e2d86942743acd5 )
        {
            return;
        }
        
        wait waitdur;
        
        if ( level.var_e2d86942743acd5 )
        {
            return;
        }
    }
}

// Namespace dmz_infils
// Params 1
// Checksum 0x3d918c20, Offset: 0x2ce1
// Size: 0x56
function function_fc76abeee9919e4e( index )
{
    player = level.players[ 0 ];
    level.var_e2d86942743acd5 = 1;
    function_767275ec19a48c9( player.team, level.startpoints.points[ index ] );
}

// Namespace dmz_infils
// Params 0
// Checksum 0xdb4a76a, Offset: 0x2d3f
// Size: 0x1a0
function function_68cee76353f2a170()
{
    player = level.players[ 0 ];
    level.var_e2d86942743acd5 = 1;
    closestdist = distancesquared( level.startpoints[ 0 ].points[ 0 ].origin, player.origin );
    targetnode = level.startpoints[ 0 ].points[ 0 ];
    
    foreach ( pointgroup in level.startpoints )
    {
        foreach ( point in pointgroup.points )
        {
            dist = distancesquared( point.origin, player.origin );
            
            if ( closestdist > dist )
            {
                targetnode = point;
            }
        }
    }
    
    function_767275ec19a48c9( player.team, targetnode );
}

