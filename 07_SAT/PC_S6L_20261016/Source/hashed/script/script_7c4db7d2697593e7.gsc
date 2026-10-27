// script_7c4db7d2697593e7  (hash_7c4db7d2697593e7.gscc) (size: 6665 Bytes / 0x1a09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18fc370f (419182351)
// size ...... 6665 (0x1a09)
// includes .. 7   (offset: 0x189d)
// strings ... 12  (offset: 0x18d5)
// dev strs .. 11  (offset: 0x1985)
// exports ... 26  (offset: 0xf01)
// cseg ...... 0x18a + 0xd77 (0xf01)
// imports ... 47  (offset: 0x1311)
// animtree1 . 0   (offset: 0x1a09)
// animtree2 . 0   (offset: 0x1a09)
#using script_70fa7df687b2e3bf;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gamelogic;

#namespace clash_ops_punish;

// Namespace clash_ops_punish
// Params 0
// Checksum 0x4f80860f, Offset: 0x1a8
// Size: 0xf1
function init()
{
    level.var_c715d0a12b9a0958 = { #zombieteam:"team_two_hundred", #var_e56710341ebfef22:undefined, #var_115b188ae1107e75:undefined, #var_980a78f6f7d89939:undefined, #var_93183510b1ab8a1c:0, #var_a804208c732c21bf:0, #targetteam:undefined, #pool:[], #var_5c0554b2c4a040e7:[] };
    level.var_c715d0a12b9a0958.var_5c0554b2c4a040e7[ #"zombies" ] = &punishzombies;
    level.var_c715d0a12b9a0958.var_5c0554b2c4a040e7[ #"special_zombies" ] = &function_c9109555c3511021;
    callback::add( "on_agent_spawned", &function_c8085c6263ef36bf );
    namespace_3047dff6a502386b::function_6c0fdc0c23f23397();
    loadpool();
    level thread function_dd5af5b3e3367f39();
    function_a89e816c88836e8b();
    level thread function_629ca01c9ef6213f();
    
    /#
        level thread initdebug();
    #/
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0x3ef76470, Offset: 0x2a1
// Size: 0x4b
function private function_629ca01c9ef6213f()
{
    level endon( #"game_ended" );
    
    while ( !level.var_1304fc1c8fb51e7b.active )
    {
        waitframe();
    }
    
    namespace_3047dff6a502386b::function_c48ec991a151d7ca( undefined, level.var_c715d0a12b9a0958.zombieteam );
    function_73c631f002ae8eb8();
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0x30b79275, Offset: 0x2f4
// Size: 0xa6
function private function_a89e816c88836e8b()
{
    createthreatbiasgroup( "clash_ops_zombie" );
    createthreatbiasgroup( "clash_ops_player_allies" );
    createthreatbiasgroup( "clash_ops_player_axis" );
    setteamthreatbias( 500, 500 );
    
    foreach ( player in level.players )
    {
        function_419ebef1469e43a6( player );
    }
}

// Namespace clash_ops_punish
// Params 1, eflags: 0x4
// Checksum 0xc4973ef1, Offset: 0x3a2
// Size: 0x4f
function private function_419ebef1469e43a6( player )
{
    if ( player.team == "allies" )
    {
        player setthreatbiasgroup( "clash_ops_player_allies" );
        return;
    }
    
    if ( player.team == "axis" )
    {
        player setthreatbiasgroup( "clash_ops_player_axis" );
    }
}

// Namespace clash_ops_punish
// Params 1
// Checksum 0x53531965, Offset: 0x3f9
// Size: 0x21
function function_e6818e80bb145acc( agent )
{
    if ( isagent( agent ) )
    {
        agent setthreatbiasgroup( "clash_ops_zombie" );
    }
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0x842369f2, Offset: 0x422
// Size: 0x234
function private loadpool()
{
    if ( level.var_4e147a96a4a5740d.punishmentpool )
    {
        foreach ( entry in level.var_4e147a96a4a5740d.punishmentpool )
        {
            punishentry = { #continuous:entry.continuous ?? 0, #quantity:entry.quantity ?? 1, #weight:entry.weight ?? 1, #assetreference:entry.assetreference, #zombietype:entry.zombietype, #type:entry.type };
            level.var_c715d0a12b9a0958.pool[ level.var_c715d0a12b9a0958.pool.size ] = punishentry;
        }
        
        return;
    }
    
    foreach ( type, handler in level.var_c715d0a12b9a0958.var_5c0554b2c4a040e7 )
    {
        punishentry = { #continuous:0, #quantity:1, #weight:1, #assetreference:undefined, #zombietype:undefined, #type:type };
        level.var_c715d0a12b9a0958.pool[ level.var_c715d0a12b9a0958.pool.size ] = punishentry;
    }
}

// Namespace clash_ops_punish
// Params 1
// Checksum 0x15895461, Offset: 0x65e
// Size: 0x4e
function punish_team( loserteam )
{
    if ( !loserteam )
    {
        return;
    }
    
    setteamthreatbias( 500, 500 );
    namespace_3047dff6a502386b::function_c48ec991a151d7ca( undefined, level.var_c715d0a12b9a0958.zombieteam );
    
    if ( function_73c631f002ae8eb8() )
    {
        return;
    }
    
    function_bef116f62c20e2d6( loserteam );
}

// Namespace clash_ops_punish
// Params 1, eflags: 0x4
// Checksum 0xd62d8ab9, Offset: 0x6b4
// Size: 0x7b
function private function_bef116f62c20e2d6( loserteam )
{
    punishment = function_4cb0189ec192a14a();
    
    if ( !punishment )
    {
        return;
    }
    
    punishment.targetteam = loserteam;
    handler = level.var_c715d0a12b9a0958.var_5c0554b2c4a040e7[ punishment.type ];
    
    if ( !handler )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    level thread [[ handler ]]( punishment );
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0xad07d671, Offset: 0x737
// Size: 0xb6
function private function_4cb0189ec192a14a()
{
    pool = level.var_c715d0a12b9a0958.pool;
    
    if ( pool.size == 0 )
    {
        return;
    }
    
    weights = [];
    
    foreach ( entry in pool )
    {
        weights[ weights.size ] = entry.weight;
    }
    
    return utility::random_weighted( pool, weights );
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0xe1f72c23, Offset: 0x7f6
// Size: 0x2a
function private function_dd5af5b3e3367f39()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_974fecacc94e1b75" );
        function_f30572ec28a61ee6();
    }
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0x960fc6e0, Offset: 0x828
// Size: 0xae
function private function_f30572ec28a61ee6()
{
    zombietypes = level.var_c715d0a12b9a0958.var_e56710341ebfef22;
    
    if ( !isdefined( zombietypes ) )
    {
        return;
    }
    
    foreach ( zombietype in zombietypes )
    {
        level notify( "stop_zombie_spawns_" + zombietype );
    }
    
    level.var_c715d0a12b9a0958.var_e56710341ebfef22 = undefined;
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0xad04dfeb, Offset: 0x8de
// Size: 0x73, Type: bool
function private function_73c631f002ae8eb8()
{
    zombietype = function_b53a496d6d241505();
    
    if ( !zombietype || level.var_c715d0a12b9a0958.var_93183510b1ab8a1c )
    {
        return false;
    }
    
    level.var_c715d0a12b9a0958.var_93183510b1ab8a1c = 1;
    level.var_c715d0a12b9a0958.var_115b188ae1107e75 = zombietype;
    level thread function_3932176607b7d81d();
    logstring( "clash_ops: base zombies active at first trial start" );
    return true;
}

// Namespace clash_ops_punish
// Params 0
// Checksum 0x1ac454ef, Offset: 0x95a
// Size: 0x3b
function function_b53a496d6d241505()
{
    if ( !level.var_4e147a96a4a5740d.var_115b188ae1107e75 )
    {
        return;
    }
    
    return getscriptbundle( level.var_4e147a96a4a5740d.var_115b188ae1107e75 ).name;
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0x1663e2f0, Offset: 0x99e
// Size: 0x2a
function private function_7fb97f013ba6308c()
{
    if ( !level.var_4e147a96a4a5740d )
    {
        return 6;
    }
    
    return level.var_4e147a96a4a5740d.var_15953b33113044bc ?? 6;
}

// Namespace clash_ops_punish
// Params 0, eflags: 0x4
// Checksum 0xae9ab7dc, Offset: 0x9d1
// Size: 0x86
function private function_3932176607b7d81d()
{
    level endon( #"game_ended" );
    zombietype = level.var_c715d0a12b9a0958.var_115b188ae1107e75;
    targetcount = function_7fb97f013ba6308c();
    spawnsettings = function_500f112b2e08c12a();
    
    while ( true )
    {
        deficit = targetcount - agent_utility::getnumactiveagents( zombietype );
        
        if ( deficit > 0 )
        {
            level thread namespace_3047dff6a502386b::function_352e5eb80d317f9e( deficit, zombietype, "team_two_hundred", spawnsettings );
        }
        
        wait 10;
    }
}

// Namespace clash_ops_punish
// Params 5, eflags: 0x4
// Checksum 0xa7ae0c94, Offset: 0xa5f
// Size: 0xf5
function private zombiespawner( targetteam, zombietype, count, continuous, var_6f9a65a0246db547 = 0 )
{
    assert( count > 0, "<dev string:x59>" );
    zombieteam = level.var_c715d0a12b9a0958.zombieteam;
    spawnsettings = function_500f112b2e08c12a( var_6f9a65a0246db547, targetteam );
    
    if ( continuous )
    {
        level thread namespace_3047dff6a502386b::function_6d5b2d2dd94015f6( zombietype, count, zombieteam, spawnsettings );
        
        if ( !isdefined( level.var_c715d0a12b9a0958.var_e56710341ebfef22 ) )
        {
            level.var_c715d0a12b9a0958.var_e56710341ebfef22 = [];
        }
        
        level.var_c715d0a12b9a0958.var_e56710341ebfef22[ level.var_c715d0a12b9a0958.var_e56710341ebfef22.size ] = zombietype;
        return;
    }
    
    level thread namespace_3047dff6a502386b::function_352e5eb80d317f9e( count, zombietype, zombieteam, spawnsettings );
}

// Namespace clash_ops_punish
// Params 1
// Checksum 0x92a49124, Offset: 0xb5c
// Size: 0x37
function function_c8085c6263ef36bf( params )
{
    agent = params.agent;
    function_e6818e80bb145acc( agent );
    waitframe();
    namespace_3047dff6a502386b::function_44808593c36bbd6a( agent, undefined );
}

// Namespace clash_ops_punish
// Params 1
// Checksum 0xc3a83728, Offset: 0xb9b
// Size: 0x1f
function function_db8e8ff846f8004b( player )
{
    namespace_3047dff6a502386b::function_281fbcb10cdce0df( player, undefined );
    function_419ebef1469e43a6( player );
}

// Namespace clash_ops_punish
// Params 2, eflags: 0x4
// Checksum 0x9bddebf4, Offset: 0xbc2
// Size: 0x37
function private setteamthreatbias( var_b26b176dd4ab9abd, var_8038ab5ecd52eb26 )
{
    setthreatbias( "clash_ops_player_allies", "clash_ops_zombie", var_b26b176dd4ab9abd );
    setthreatbias( "clash_ops_player_axis", "clash_ops_zombie", var_8038ab5ecd52eb26 );
}

// Namespace clash_ops_punish
// Params 2, eflags: 0x4
// Checksum 0x802adae7, Offset: 0xc01
// Size: 0x62
function private function_500f112b2e08c12a( var_6f9a65a0246db547 = 0, var_1e5fb935f44474a3 )
{
    return { #specialproperties:{ #var_7957a5f65931aaea:var_6f9a65a0246db547 }, #var_583144a97cdaecf6:1, #awarenessradius:5000, #movespeed:"sprint", #stealthenabled:0 };
}

// Namespace clash_ops_punish
// Params 1, eflags: 0x4
// Checksum 0xadb6d4c, Offset: 0xc6c
// Size: 0xd3
function private punishzombies( punishment )
{
    if ( !punishment.zombietype )
    {
        assertmsg( "<dev string:x92>" );
        return;
    }
    
    if ( punishment.quantity <= 0 )
    {
        return;
    }
    
    zombietype = getscriptbundle( punishment.zombietype ).name;
    
    if ( !zombietype )
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    level.var_c715d0a12b9a0958.targetteam = punishment.targetteam;
    zombiespawner( punishment.targetteam, zombietype, punishment.quantity, punishment.continuous, 0 );
    logstring( "clash_ops: punish zombies targeting " + punishment.targetteam );
}

// Namespace clash_ops_punish
// Params 1, eflags: 0x4
// Checksum 0xa7b0ec10, Offset: 0xd47
// Size: 0xd4
function private function_c9109555c3511021( punishment )
{
    if ( !punishment.zombietype )
    {
        assertmsg( "<dev string:x11a>" );
        return;
    }
    
    if ( punishment.quantity <= 0 )
    {
        return;
    }
    
    var_911bcd902824e9f = getscriptbundle( punishment.zombietype ).name;
    
    if ( !var_911bcd902824e9f )
    {
        assertmsg( "<dev string:x160>" );
        return;
    }
    
    level.var_c715d0a12b9a0958.targetteam = punishment.targetteam;
    zombiespawner( punishment.targetteam, var_911bcd902824e9f, punishment.quantity, punishment.continuous, 1 );
    logstring( "clash_ops: punish special zombies targeting " + punishment.targetteam );
}

/#

    // Namespace clash_ops_punish
    // Params 0, eflags: 0x4
    // Checksum 0xddd1a155, Offset: 0xe23
    // Size: 0x4a, Type: dev
    function private initdebug()
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x1b2>" );
        devgui::add_devgui_func( "<dev string:x1d0>", "<dev string:x1e2>", &function_5f25285a26a2af0e );
        devgui::add_devgui_func( "<dev string:x1f1>", "<dev string:x204>", &function_73b7cb37acd6a88a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace clash_ops_punish
    // Params 1, eflags: 0x4
    // Checksum 0x8b40ffd1, Offset: 0xe75
    // Size: 0x3f, Type: dev
    function private function_5f25285a26a2af0e( params )
    {
        host = gamelogic_mp::gethostplayer();
        allyteam = host.team;
        punish_team( allyteam );
    }

    // Namespace clash_ops_punish
    // Params 1, eflags: 0x4
    // Checksum 0x30546dc4, Offset: 0xebc
    // Size: 0x45, Type: dev
    function private function_73b7cb37acd6a88a( params )
    {
        host = gamelogic_mp::gethostplayer();
        enemyteam = team_utility::getotherteam( host.team );
        punish_team( enemyteam );
    }

#/
