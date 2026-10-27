// scripts\mp\common\killstreaks\supply_sweep.gsc  (hash_048f7971d29c18fe.gscc) (size: 6910 Bytes / 0x1afe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0965637 (2962642487)
// size ...... 6910 (0x1afe)
// includes .. 11  (offset: 0x18d2)
// strings ... 19  (offset: 0x192a)
// dev strs .. 10  (offset: 0x1a86)
// exports ... 18  (offset: 0xf9e)
// cseg ...... 0x1dc + 0xdc2 (0xf9e)
// imports ... 54  (offset: 0x126e)
// animtree1 . 0   (offset: 0x1afe)
// animtree2 . 0   (offset: 0x1afe)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace supply_sweep;

// Namespace supply_sweep
// Params 0, eflags: 0x1
// Checksum 0x1af6b69, Offset: 0x1fa
// Size: 0xa
function autoexec main()
{
    level thread init();
}

// Namespace supply_sweep
// Params 0, eflags: 0x4
// Checksum 0xa59c67b9, Offset: 0x20c
// Size: 0x11
function private function_db4f13cb198b13c8()
{
    return getdvarint( @"scr_supply_sweep_duration", 20 );
}

// Namespace supply_sweep
// Params 0
// Checksum 0x8843f71f, Offset: 0x226
// Size: 0x68
function init()
{
    while ( !isdefined( level.killstreaksetups ) )
    {
        wait 1;
    }
    
    waitframe();
    killstreaks::registerkillstreak( "supply_sweep", &function_c50b6b09e6f6a4ae );
    initdialog();
    level thread initteamdata();
    level.var_a2d3f4cb7c0e8b18 = &function_93a459169f856ead;
    level.var_89f506c557c1f41b = throttle::throttle_initialize( "supply_sweep", getdvarint( @"hash_835fa7d7058630f5", 15 ) );
}

// Namespace supply_sweep
// Params 0
// Checksum 0x82e5e2ae, Offset: 0x296
// Size: 0x28
function initdialog()
{
    game[ "dialog" ][ "supply_sweep_start" ] = "spsw_empp_ssst";
    game[ "dialog" ][ "supply_sweep_end" ] = "spsw_empp_ssen";
}

// Namespace supply_sweep
// Params 0
// Checksum 0x7cb70525, Offset: 0x2c6
// Size: 0x8c
function initteamdata()
{
    waitframe();
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        level.teamdata[ level.teamnamelist[ i ] ][ "activeSupplySweeps" ] = [];
        level.teamdata[ level.teamnamelist[ i ] ][ "supplySweepEndTime" ] = 0;
        level.teamdata[ level.teamnamelist[ i ] ][ "numSupplySweepKillstreakStarted" ] = 0;
    }
}

// Namespace supply_sweep
// Params 1
// Checksum 0x47272f56, Offset: 0x35a
// Size: 0xf3, Type: bool
function function_c50b6b09e6f6a4ae( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    bundle = level.streakglobals.streakbundles[ "supply_sweep" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.deployweaponname ) )
    {
        playgestureresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( bundle.deployweaponname ) );
    }
    else
    {
        playgestureresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( "ks_gesture_phone_mp" ) );
    }
    
    if ( !playgestureresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    level thread function_e089a310c4261cde( self, streakinfo, undefined, function_db4f13cb198b13c8() );
    return true;
}

// Namespace supply_sweep
// Params 1
// Checksum 0xd426fe5c, Offset: 0x456
// Size: 0x66, Type: bool
function function_65cf3414fb39a57e( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !streakinfo.var_cb18b511dd986f1 )
    {
        deployweapon = "ks_gesture_generic_mp";
        deployresult = killstreakdeploy::streakdeploy_dogesturedeploy( streakinfo, makeweapon( deployweapon ) );
        
        if ( !deployresult )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace supply_sweep
// Params 1
// Checksum 0x6d838d7c, Offset: 0x4c5
// Size: 0x48
function isactive( team )
{
    var_dae2887d7f2f3ff7 = 0;
    
    if ( isdefined( level.teamdata[ team ][ "activeSupplySweeps" ] ) )
    {
        var_dae2887d7f2f3ff7 = level.teamdata[ team ][ "activeSupplySweeps" ].size > 0;
    }
    
    return var_dae2887d7f2f3ff7;
}

// Namespace supply_sweep
// Params 5
// Checksum 0x87e9a126, Offset: 0x516
// Size: 0x3e0
function function_e089a310c4261cde( owner, streakinfo, isnonkillstreak, var_8a8911058f010d5b, combinedurations = &utility::sum )
{
    team = owner.team;
    throttle::throttle_wait_in_queue( level.var_89f506c557c1f41b, {} );
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    assert( arraycontains( level.teamnamelist, team ), "<dev string:x24>" + team + "<dev string:x2a>" );
    assert( isdefined( level.teamdata[ team ][ "<dev string:x43>" ] ), "<dev string:x56>" + team + "<dev string:x69>" );
    function_691cf1a30defbe91( team );
    
    if ( !isnonkillstreak )
    {
        function_79ce5b545e5e2cc2( owner, team, streakinfo );
    }
    
    var_dae2887d7f2f3ff7 = isactive( team );
    effectendtime = undefined;
    
    if ( var_dae2887d7f2f3ff7 )
    {
        remainingduration = level.teamdata[ team ][ "supplySweepEndTime" ] - gettime();
        effectendtime = gettime() + [[ combinedurations ]]( remainingduration, var_8a8911058f010d5b * 1000 );
    }
    else
    {
        effectendtime = gettime() + var_8a8911058f010d5b * 1000;
    }
    
    level.teamdata[ team ][ "activeSupplySweeps" ][ level.teamdata[ team ][ "activeSupplySweeps" ].size ] = streakinfo;
    level.teamdata[ team ][ "supplySweepEndTime" ] = effectendtime;
    allteammembers = teams::getteamdata( team, "players" );
    
    foreach ( player in allteammembers )
    {
        if ( isdefined( player ) && !player br_public::playeriszombie() )
        {
            player function_7c4e2042ed34369b( 1 );
            player playsoundtoplayer( "activate_supply_sweep", player );
        }
    }
    
    var_6a1e165483a96239 = level.teamdata[ team ][ "activeSupplySweeps" ].size >= 3;
    function_f3b0904f7083cbd0( var_6a1e165483a96239, team );
    secondstowait = max( ( effectendtime - gettime() ) / 1000, 0.1 );
    utility::waittill_any_timeout( secondstowait, "game_ended" );
    level.teamdata[ team ][ "activeSupplySweeps" ] = arrayremove( level.teamdata[ team ][ "activeSupplySweeps" ], streakinfo );
    var_6a1e165483a96239 = level.teamdata[ team ][ "activeSupplySweeps" ].size >= 3;
    function_f3b0904f7083cbd0( var_6a1e165483a96239, team );
    var_81ea780357577bb = level.teamdata[ team ][ "activeSupplySweeps" ].size == 0;
    
    if ( var_81ea780357577bb )
    {
        allteammembers = teams::getteamdata( team, "players" );
        
        foreach ( player in allteammembers )
        {
            if ( isdefined( player ) )
            {
                player function_7c4e2042ed34369b( 0 );
            }
        }
    }
    else
    {
        while ( !var_81ea780357577bb && !level.gameended )
        {
            effectendtime = level.teamdata[ team ][ "supplySweepEndTime" ];
            secondstowait = max( ( effectendtime - gettime() ) / 1000, 0.1 );
            utility::waittill_any_timeout( secondstowait, "game_ended" );
            var_81ea780357577bb = level.teamdata[ team ][ "activeSupplySweeps" ].size == 0;
        }
    }
    
    if ( !isnonkillstreak )
    {
        function_aa1cc60eef341c21( owner, team, streakinfo );
    }
}

// Namespace supply_sweep
// Params 3
// Checksum 0xcd043b36, Offset: 0x8fe
// Size: 0xf9
function function_79ce5b545e5e2cc2( owner, team, streakinfo )
{
    assert( isdefined( team ), "<dev string:x99>" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.streakname, owner.origin );
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_supply_sweep", owner );
    }
    
    owner thread points::doscoreevent( #"hash_4364420a73e868da" );
    
    if ( !level.gameended )
    {
        function_e6891cad65df5b49( team, "supply_sweep_start" );
    }
    
    level.teamdata[ team ][ "numSupplySweepKillstreakStarted" ]++;
}

// Namespace supply_sweep
// Params 3
// Checksum 0x58cd7f85, Offset: 0x9ff
// Size: 0xf2
function function_aa1cc60eef341c21( owner, team, streakinfo )
{
    assert( isdefined( team ), "<dev string:xc7>" );
    level.teamdata[ team ][ "numSupplySweepKillstreakStarted" ]--;
    
    if ( level.teamdata[ team ][ "numSupplySweepKillstreakStarted" ] == 0 && !level.gameended )
    {
        function_e6891cad65df5b49( team, "supply_sweep_end" );
    }
    
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( owner && streakinfo )
    {
        owner killstreak_utility::recordkillstreakendstats( streakinfo );
    }
    
    /#
        if ( utility::issharedfuncdefined( #"player", #"printgameaction" ) )
        {
            [[ utility::getsharedfunc( #"player", #"printgameaction" ) ]]( "<dev string:xf3>" + streakinfo.streakname, owner );
        }
    #/
}

// Namespace supply_sweep
// Params 1
// Checksum 0xc8080266, Offset: 0xaf9
// Size: 0x3a, Type: bool
function function_7250f59fc23b7f97( player )
{
    streakinfo = killstreak_utility::createstreakinfo( "supply_sweep", player );
    level thread function_e089a310c4261cde( player, streakinfo, 1, function_db4f13cb198b13c8() );
    return true;
}

// Namespace supply_sweep
// Params 1
// Checksum 0xeeeee8ad, Offset: 0xb3c
// Size: 0x139
function function_93a459169f856ead( var_e7c7d40e4d4c81c2 )
{
    foreach ( name, team in level.teamdata )
    {
        foreach ( teammate in level.teamdata[ name ][ "alivePlayers" ] )
        {
            if ( player::isreallyalive( teammate ) && !teammate br_public::isplayerinorgoingtogulag() )
            {
                streakinfo = killstreak_utility::createstreakinfo( "supply_sweep", teammate );
                level thread function_e089a310c4261cde( teammate, streakinfo, 1, var_e7c7d40e4d4c81c2, &utility::maximum );
                break;
            }
        }
    }
}

// Namespace supply_sweep
// Params 2
// Checksum 0x3d7ab15a, Offset: 0xc7d
// Size: 0xb0
function function_f3b0904f7083cbd0( isenabled, team )
{
    allteammembers = teams::getteamdata( team, "players" );
    
    foreach ( player in allteammembers )
    {
        if ( isdefined( player ) && !player br_public::playeriszombie() )
        {
            player function_30eb58c92fa063f0( isenabled );
        }
    }
}

// Namespace supply_sweep
// Params 1
// Checksum 0xef60272, Offset: 0xd35
// Size: 0xa5
function function_691cf1a30defbe91( team )
{
    level notify( "jump_master_supply_sweep_stop" + team );
    allteammembers = teams::getteamdata( team, "players" );
    
    foreach ( player in allteammembers )
    {
        if ( isdefined( player ) )
        {
            player function_60bef132ba2bfe60( 0 );
        }
    }
}

// Namespace supply_sweep
// Params 2
// Checksum 0xd76d795d, Offset: 0xde2
// Size: 0xf5
function function_e6891cad65df5b49( team, dialog )
{
    if ( level.disableannouncer )
    {
        return;
    }
    
    if ( !isdefined( game[ "dialog" ][ dialog ] ) )
    {
        println( "<dev string:x107>" + dialog + "<dev string:x10f>" );
        return;
    }
    
    soundname = "dx_br_brdm_" + game[ "dialog" ][ dialog ];
    teamplayers = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teamplayers )
    {
        thread function_52e013add1a37cae( soundname, dialog, player, 1, 0 );
    }
}

// Namespace supply_sweep
// Params 6
// Checksum 0x6c71e8a6, Offset: 0xedf
// Size: 0xbf
function function_52e013add1a37cae( soundname, dialog, player, excludegulag, allowdead, delay )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    
    if ( !isalive( player ) && !allowdead )
    {
        return;
    }
    
    if ( player br_public::modeplayerskipdialog( dialog, excludegulag ) )
    {
        return;
    }
    
    if ( isdefined( soundname ) )
    {
        soundname = tolower( soundname );
        soundlength = lookupsoundlength( soundname, 1 ) / 1000;
        
        if ( isdefined( delay ) )
        {
            wait delay;
        }
        
        player queuedialogforplayer( #"queue1", soundname, dialog, soundlength );
    }
}

