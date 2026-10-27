// scripts\mp\gametypes\landgrab.gsc  (hash_40b49bcd8cd7d959.gscc) (size: 29544 Bytes / 0x7368 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d35ca88 (758499976)
// size ...... 29544 (0x7368)
// includes .. 30  (offset: 0x686c)
// strings ... 146 (offset: 0x695c)
// dev strs .. 11  (offset: 0x72c4)
// exports ... 49  (offset: 0x4948)
// cseg ...... 0xbc5 + 0x3d83 (0x4948)
// imports ... 187 (offset: 0x50f0)
// animtree1 . 0   (offset: 0x7368)
// animtree2 . 0   (offset: 0x7368)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace landgrab;

// Namespace landgrab
// Params 0
// Checksum 0x5e837e21, Offset: 0xbe3
// Size: 0x18d
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.var_8ce2ed92af5d8b64 = 5;
    level.disablebuddyspawn = 1;
    level.pausemodetimer = 0;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerjoinedteam = &obj_zonecapture::onplayerjoinedteam;
    level.ontimelimit = &ontimelimit;
    level.var_5c43edbf9ac329aa = &function_a8623a99a10c6ce3;
    level.var_1e1962e4a4e8622 = &zonecaptured;
    level.var_5578c6cd6f2db7dd = &function_32118838a90bc2bb;
    level.var_c18eb83275e643e7 = &function_c18eb83275e643e7;
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    setomnvar( "ui_hq_num_alive", 0 );
    setomnvar( "ui_hq_ownerteam", -1 );
    setomnvar( "ui_hq_status", -1 );
}

// Namespace landgrab
// Params 0
// Checksum 0x25ee7428, Offset: 0xd78
// Size: 0x128
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.zoneduration = getmatchrulesdata( "kothData", "zoneLifetime" );
    level.zonecapturetime = getmatchrulesdata( "kothData", "zoneCaptureTime" );
    level.captureLockTime = getmatchrulesdata( "landgrabData", "captureLockTime" );
    level.firstzoneactivationdelay = getmatchrulesdata( "kothData", "firstZoneActivationDelay" );
    level.zoneactivationdelay = getmatchrulesdata( "kothData", "zoneActivationDelay" );
    level.zonemajoritycapture = getmatchrulesdata( "kothData", "zoneMajorityCapture" );
    level.randomLocationOrder = getmatchrulesdata( "kothData", "randomLocationOrder" );
    level.objectivescaler = getmatchrulesdata( "domData", "objScalar" );
    level.flagsrequiredtoscore = getmatchrulesdata( "domData", "flagsRequiredToScore" );
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagblockcapdisabled" );
    level.disablemajoritycapprogress = getmatchrulesdata( "controlData", "disableMajorityCapProgress" );
    level.zonecapturetimemin = getmatchrulesdata( "domData", "flagcapturetimemin" );
    level.var_e31729b3e52a9eab = 1;
}

// Namespace landgrab
// Params 0
// Checksum 0x53a0b7dc, Offset: 0xea8
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace landgrab
// Params 0
// Checksum 0xe584e8e0, Offset: 0xeb9
// Size: 0x173
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"hash_55e92b5196095562" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_55e92b5196095562" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"hash_6fcdf57ce336bdc6" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_6fcdf57ce336bdc6" );
    }
    
    level.var_4979f7dec57b922d = [];
    level thread setupzones();
    level.zones = [];
    level.inovertime = 0;
    initspawns();
    setwaypoints();
    seticonnames();
    
    /#
        thread function_684df5bae7fd2a8b();
    #/
    
    level thread function_5a8d050fd865a55e();
}

// Namespace landgrab
// Params 0
// Checksum 0xa8bc958f, Offset: 0x1034
// Size: 0xce
function function_5a8d050fd865a55e()
{
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    level function_9cec8c01e9b5901a();
    level.var_4cd00e18e84d297e = 0;
    
    while ( true )
    {
        level utility::waittill_any( "zones_scored", "zones_moved" );
        setomnvar( "ui_hq_status", -1 );
        index = function_fbab110211350819();
        function_b9ded27c6d596e96( index );
        
        if ( !level.randomLocationOrder )
        {
            level.futurezoneindex = function_fbab110211350819();
        }
        
        spawnlogic::clearlastteamspawns();
        function_96d428777c00ac45( level.zoneactivationdelay, 0 );
        level.var_4cd00e18e84d297e = 0;
        spawnlogic::clearlastteamspawns();
        function_fbbba6e1c745812d();
    }
}

// Namespace landgrab
// Params 0
// Checksum 0xf3783003, Offset: 0x110a
// Size: 0x40
function function_9cec8c01e9b5901a()
{
    function_b9ded27c6d596e96( 0, 1 );
    
    if ( !level.randomLocationOrder )
    {
        level.futurezoneindex = function_fbab110211350819();
    }
    
    function_96d428777c00ac45( level.firstzoneactivationdelay, 0 );
    function_fbbba6e1c745812d();
}

// Namespace landgrab
// Params 0
// Checksum 0x9867bccb, Offset: 0x1152
// Size: 0x118
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    var_56fbfa11eebaa164 = istrue( getdvarint( @"hash_d19dacb355491b5c", 0 ) );
    
    if ( var_56fbfa11eebaa164 )
    {
        spawnkey = "ctf";
    }
    else
    {
        spawnkey = spawnlogic::function_d5c160a4110b573e();
    }
    
    level.var_f1086140706e9fff = spawnlogic::function_5cf82e30c52a895d( spawnkey );
    
    if ( level.var_f1086140706e9fff )
    {
        if ( var_56fbfa11eebaa164 )
        {
            spawnlogic::function_c87bd865d7b44cd0( spawnkey );
        }
        else
        {
            spawnlogic::function_3cdbb94b81729d5f( spawnkey );
        }
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", "allies" );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", "axis" );
        spawnlogic::function_9bd2654564d3372d( #"primary", "normal_attackers", "mp_ctf_spawn_allies", "allies" );
        spawnlogic::function_9bd2654564d3372d( #"primary", "normal_defenders", "mp_ctf_spawn_axis", "axis" );
    }
    
    spawnlogic::finalizemap();
}

// Namespace landgrab
// Params 0
// Checksum 0x851f29c8, Offset: 0x1272
// Size: 0xaa
function seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
    level.iconnext = "waypoint_locked";
    level.icontarget = "waypoint_dom_target";
    level.var_d989914b5369bec4 = "waypoint_capture_locked_enemy";
    level.var_e19266d741bd6487 = "waypoint_capture_locked_friendly";
}

// Namespace landgrab
// Params 0
// Checksum 0x4f8822fe, Offset: 0x1324
// Size: 0x4d6
function setwaypoints()
{
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_a", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_b", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_taking_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "icon_waypoint_dom_c", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defend_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_defending_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_a", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_b", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_losing_c", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_a", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_b", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_captureneutral_c", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_a", 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_b", 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_contested_c", 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_clearing_a", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_clearing_b", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_clearing_c", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_a", 0, "neutral", &"MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_b", 0, "neutral", &"MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_locked_c", 0, "neutral", &"MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target_a", 0, "neutral", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target_b", 0, "neutral", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_dom_target_c", 0, "neutral", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_enemy_a", 0, "enemy", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_enemy_b", 0, "enemy", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_enemy_c", 0, "enemy", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_c", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_friendly_a", 0, "friendly", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_a", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_friendly_b", 0, "friendly", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_b", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( "waypoint_capture_locked_friendly_c", 0, "friendly", &"t10_mp_ingame_only/landgrab_capture_locked", "icon_waypoint_dom_c", 0, undefined );
}

// Namespace landgrab
// Params 0
// Checksum 0x937dc0a4, Offset: 0x1802
// Size: 0xb4
function getspawnpoint()
{
    if ( level.var_f1086140706e9fff )
    {
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, "start_attackers", "normal_attackers" );
        }
        else
        {
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, "start_defenders", "normal_defenders" );
        }
    }
    else if ( spawnteam == game[ "attackers" ] )
    {
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, "normal_attackers" );
    }
    else
    {
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, "normal_defenders" );
    }
    
    return spawnpoint;
}

// Namespace landgrab
// Params 6
// Checksum 0xc7c432a0, Offset: 0x18bf
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace landgrab
// Params 1
// Checksum 0xc0dc6d72, Offset: 0x190f
// Size: 0x442
function function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    
    if ( attacker.var_20fb6d9e02a1d35 )
    {
        return;
    }
    
    victim = deathdata.victim;
    
    if ( !isplayer( attacker ) || !isplayer( victim ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( isdefined( deathdata.objweapon ) && weapon::iskillstreakweapon( deathdata.objweapon.basename ) )
    {
        return;
    }
    
    if ( !isdefined( level.zones ) )
    {
        return;
    }
    
    var_3585c67984f0d918 = 0;
    var_cb2aefcee6355c94 = 0;
    var_9b43c11c6592a807 = 0;
    zoneindex = -1;
    
    foreach ( zone in level.zones )
    {
        var_3585c67984f0d918 = attacker istouching( zone.trigger );
        var_9b43c11c6592a807 = victim istouching( zone.trigger );
        
        if ( var_3585c67984f0d918 && attacker.team === zone.ownerteam )
        {
            var_cb2aefcee6355c94 = 1;
            break;
        }
        
        if ( var_3585c67984f0d918 || var_9b43c11c6592a807 )
        {
            zoneindex = zone.objectivekey;
            break;
        }
    }
    
    if ( var_cb2aefcee6355c94 && isdefined( attacker.var_c36e159445e2a48b ) )
    {
        attacker.var_c36e159445e2a48b++;
        
        if ( attacker.var_c36e159445e2a48b == 5 )
        {
            attacker thread events::function_d4fd7d540188e407();
        }
    }
    
    if ( zoneindex < 0 )
    {
        return;
    }
    
    ownerteam = level.zones[ zoneindex ].ownerteam;
    
    if ( !isdefined( ownerteam ) )
    {
        return;
    }
    
    if ( attacker.team != ownerteam )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && level.zonecapturetime > 0 && var_3585c67984f0d918 )
        {
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        }
        else if ( var_9b43c11c6592a807 )
        {
            attacker thread rank::function_d2aa8986c506e985( #"assault" );
            attacker events::function_58da673c1c3fc9f2();
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
            attacker stats::setextrascore3( attacker.pers[ "extrascore3" ] + 1, "assaults" );
        }
        
        return;
    }
    
    if ( var_3585c67984f0d918 )
    {
        attacker thread rank::function_d2aa8986c506e985( #"defend" );
        attacker events::function_20a5f572df6afd43();
        attacker stats::setextrascore3( attacker.pers[ "extrascore3" ] + 1 );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker stats::setextrascore1( attacker.pers[ "defends" ], "defends" );
    }
}

// Namespace landgrab
// Params 1
// Checksum 0x7c493c5e, Offset: 0x1d59
// Size: 0x52
function onplayerconnect( player )
{
    player stats::setextrascore0( player.pers[ "objTime" ] ?? 0, "objTime" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
}

// Namespace landgrab
// Params 0
// Checksum 0x4f340629, Offset: 0x1db3
// Size: 0x2e8
function function_9610db1acedaf856()
{
    level endon( #"game_ended" );
    level endon( #"zones_scored" );
    level endon( #"zones_moved" );
    zone = self;
    zone endon( #"zone_unoccupied" );
    zone notify( #"hash_70257632589090c" );
    zone endon( #"hash_70257632589090c" );
    seconds = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds && !level.gameended ; waittime = 0 )
        {
            wait level.framedurationseconds;
            hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( zone.stalemate )
            {
            }
        }
        
        team = zone gameobjects::getownerteam();
        
        foreach ( object in zone.touchlist[ team ] )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( object.player ) ) )
            {
                if ( isdefined( object.player.leaderboarddata[ "objTime" ] ) )
                {
                    object.player.leaderboarddata[ "objTime" ] = object.player.leaderboarddata[ "objTime" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                {
                    [[ level.leaderboardfunc[ "objTime" ] ]]( object.player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                
                if ( isdefined( object.player.pers[ "objTime" ] ) )
                {
                    object.player.pers[ "objTime" ] = object.player.pers[ "objTime" ] + 1;
                }
            }
            
            object.player persistence::statsetchild( "round", "objTime", object.player.pers[ "objTime" ] );
            object.player stats::setextrascore0( object.player.pers[ "objTime" ] );
        }
    }
}

// Namespace landgrab
// Params 0
// Checksum 0x4915a31d, Offset: 0x20a3
// Size: 0x31
function updatematchstatushintonspawn()
{
    if ( level.zoneislocked )
    {
        hud_message::function_ef4318a0090caa0f( #"hash_c5f1725df5d0bc91" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"hash_18da61004d0ed6ad" );
}

// Namespace landgrab
// Params 1
// Checksum 0x26d0e3f2, Offset: 0x20dc
// Size: 0x1f
function onspawnplayer( spawndata )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    updatematchstatushintonspawn();
}

// Namespace landgrab
// Params 0
// Checksum 0x8b59317a, Offset: 0x2103
// Size: 0x9b
function ontimelimit()
{
    winningteam = gamescore::calculatewinningteam();
    
    if ( winningteam != "none" )
    {
        thread gamelogic_mp::endgame( winningteam, game[ "end_reason" ][ "time_limit_reached" ] );
    }
    else if ( winningteam == "none" && !level.inovertime )
    {
        level.inovertime = 1;
        thread function_6fcb3b30cda8dc8e( 60 );
        function_cfd81b36e931d377( 60 );
        function_49311a96c6612b89();
        return;
    }
    
    if ( level.inovertime )
    {
        thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "tie" ] );
    }
}

// Namespace landgrab
// Params 0
// Checksum 0x95b94cab, Offset: 0x21a6
// Size: 0x97, Type: bool
function function_32118838a90bc2bb()
{
    foreach ( zone in level.zones )
    {
        team = zone gameobjects::getownerteam();
        
        if ( !zone.stalemate )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace landgrab
// Params 1
// Checksum 0x6f3ce661, Offset: 0x2246
// Size: 0x9d
function function_e89a3af721a89d94( team )
{
    score = 0;
    
    foreach ( zone in level.zones )
    {
        if ( zone.ownerteam == team )
        {
            score++;
        }
    }
    
    return score;
}

// Namespace landgrab
// Params 4
// Checksum 0x9d6063b0, Offset: 0x22ec
// Size: 0x402
function zonecaptured( zone, credit_player, touchlist, capturetime )
{
    if ( credit_player.owner )
    {
        if ( gameobjects::function_e17a356e69f57699( credit_player ) && !arraycontains( touchlist, credit_player.owner ) )
        {
            credit_player callback::callback( #"hash_a4b2d4dcbb4cda95", { #capturebot:credit_player } );
        }
        
        credit_player = credit_player.owner;
    }
    
    ownerteam = zone gameobjects::getownerteam();
    enemyteam = team_utility::getotherteam( ownerteam );
    zone thread function_9610db1acedaf856();
    zone thread capturelock();
    gamescore::giveteamscoreforobjective( ownerteam, 1, 0, undefined, 1, credit_player.team );
    var_27836a09f9688985 = gamescore::gethighestscoringteam();
    istied = var_27836a09f9688985 == "tie";
    
    if ( var_27836a09f9688985 == "tie" )
    {
        var_27836a09f9688985 = "allies";
    }
    
    var_88ef6e861743d9ae = int( game[ "teamScores" ][ var_27836a09f9688985 ] );
    ismatchpoint = var_88ef6e861743d9ae == level.scorelimit - 1;
    level.var_bb1c2c73a70095d8 = ismatchpoint && istied;
    level.var_4cd00e18e84d297e++;
    level function_b434347a2d26e62f( ownerteam, "landgrab_friendly_score", "landgrab_friendly_match_score", "landgrab_enemy_score", "landgrab_enemy_match_score" );
    var_f745acf21448ff2f = function_e89a3af721a89d94( ownerteam );
    
    if ( var_f745acf21448ff2f == level.flagsrequiredtoscore )
    {
        soundalias = #"hash_2a141df11cf07460";
    }
    else
    {
        soundalias = #"landgrab_zone_captured";
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( soundalias, teams::getteamdata( ownerteam, "players" ) );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"landgrab_zone_lost", teams::getteamdata( enemyteam, "players" ) );
    credit_player points::doscoreevent( #"zone_capture" );
    level thread function_e2ed2c4451b0450a( zone, ownerteam, credit_player, #"zone_capture" );
    var_82e9960834e40703 = level.var_bb1c2c73a70095d8 && level.var_4cd00e18e84d297e == 1 || level.var_4cd00e18e84d297e >= level.flagsrequiredtoscore;
    
    if ( var_82e9960834e40703 )
    {
        level notify( #"zones_scored" );
    }
    
    dialog::statusdialog( "secured" + zone.iconname, ownerteam );
    dialog::statusdialog( "lost" + zone.iconname, enemyteam );
    
    if ( level.var_4cd00e18e84d297e == 1 )
    {
        utility::delaycall( 2, &dialog::statusdialog, #"hash_3eb715822be25d4", ownerteam );
        utility::delaycall( 2, &dialog::statusdialog, #"hash_3eb715822be25d4", enemyteam );
    }
    else if ( level.var_4cd00e18e84d297e == 2 )
    {
        utility::delaycall( 2, &dialog::statusdialog, #"hash_42a1b2452b6afbb2", ownerteam );
        utility::delaycall( 2, &dialog::statusdialog, #"hash_42a1b2452b6afbb2", enemyteam );
    }
    else if ( level.var_bb1c2c73a70095d8 )
    {
        utility::delaycall( 2, &dialog::statusdialog, #"hash_84207c7738f9a099", ownerteam );
        utility::delaycall( 2, &dialog::statusdialog, #"hash_84207c7738f9a099", enemyteam );
    }
    else
    {
        utility::delaycall( 2, &dialog::statusdialog, #"hash_605d6f003fdfb0de", ownerteam );
        utility::delaycall( 2, &dialog::statusdialog, #"hash_605d6f003fdfb0de", enemyteam );
    }
    
    credit_player thread smoke_grenade::function_99543ad5d551cdb5();
    zone.didstatusnotify = 0;
    
    if ( gettime() - level.var_d5df6d553f504add + level.zonecapturetime * 1000 <= 1000 )
    {
        credit_player thread points::doscoreevent( #"landgrab_quick_cap" );
    }
    
    if ( level.inovertime )
    {
        level thread gamelogic_mp::endgame( ownerteam, game[ "end_reason" ][ "lg_tiebreaker_zonesheld_win" ], game[ "end_reason" ][ "lg_tiebreaker_zonesheld_loss" ] );
    }
}

// Namespace landgrab
// Params 4
// Checksum 0x75ed4084, Offset: 0x26f6
// Size: 0x27e
function function_e2ed2c4451b0450a( zone, ownerteam, credit_player, scoreevent )
{
    level endon( #"game_ended" );
    
    if ( credit_player.var_20fb6d9e02a1d35 )
    {
        credit_player = credit_player.owner;
    }
    
    foreach ( var_ff4a417f0f5572a in zone.assisttouchlist[ ownerteam ] )
    {
        player = var_ff4a417f0f5572a.player;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player == credit_player )
        {
            continue;
        }
        
        if ( level.gamemodebundle.var_9a091b8fbf3b4e70 )
        {
            player thread points::doscoreevent( scoreevent );
        }
        else
        {
            player thread points::doscoreevent( #"capture_assist" );
        }
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "captures" ] ) )
            {
                player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
            {
                [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( player.pers[ "captures" ] ) )
            {
                player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
            }
        }
        
        player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player stats::setextrascore0( player.pers[ "captures" ], "captures" );
        waitframe();
    }
    
    zone.assisttouchlist[ ownerteam ] = [];
}

// Namespace landgrab
// Params 0
// Checksum 0x93d39081, Offset: 0x297c
// Size: 0x9b
function capturelock()
{
    self endon( #"hash_29e6bedbd39696fd" );
    zone = self;
    luaindex = zone.index + 1;
    waitframe();
    zone gameobjects::setobjectivestatusicons( level.var_e19266d741bd6487, level.var_d989914b5369bec4 );
    zone gameobjects::allowuse( "none" );
    zone.lockupdatingicons = 1;
    zone.capturelocked = 1;
    setomnvar( "ui_capture_locked_zone_" + luaindex, 1 );
    function_4c534b07a296d944( zone, 0 );
    zone gameobjects::disableobject();
}

// Namespace landgrab
// Params 2
// Checksum 0x11b41152, Offset: 0x2a1f
// Size: 0xf8
function function_4c534b07a296d944( zone, var_97bb47d90e34787 )
{
    var_411d883c9d0f58b1 = var_97bb47d90e34787 ? zone.ownerteam : "off";
    
    foreach ( chevron in zone.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), var_411d883c9d0f58b1 );
        }
    }
}

// Namespace landgrab
// Params 0
// Checksum 0x42c870c5, Offset: 0x2b1f
// Size: 0x526
function function_fbab110211350819()
{
    index = 0;
    
    if ( isdefined( level.futurezoneindex ) )
    {
        function_3f2c14af41dbaa4c( level.futurezoneindex );
        index = level.futurezoneindex;
        level.futurezoneindex = undefined;
    }
    else if ( level.randomLocationOrder )
    {
        var_8493e175a66447ea = [];
        
        foreach ( entry in level.teamnamelist )
        {
            var_8493e175a66447ea[ entry ] = ( 0, 0, 0 );
        }
        
        livingplayers = game_utility_mp::getpotentiallivingplayers();
        
        foreach ( player in livingplayers )
        {
            if ( player.team == "spectator" )
            {
                continue;
            }
            
            var_8493e175a66447ea[ player.team ] += player.origin;
        }
        
        avgpos = [];
        
        foreach ( entry in level.teamnamelist )
        {
            players = teams::getteamdata( entry, "players" );
            teamsize = max( players.size, 1 );
            avgpos[ entry ] = var_8493e175a66447ea[ entry ] / teamsize;
        }
        
        if ( !isdefined( level.var_b2d215c849273987 ) || isdefined( level.var_b2d215c849273987 ) && level.var_b2d215c849273987.size == level.var_4979f7dec57b922d.size - 1 )
        {
            level.var_b2d215c849273987 = [];
        }
        
        if ( isdefined( level.prevzoneindex ) )
        {
            level.var_b2d215c849273987[ level.var_b2d215c849273987.size ] = level.prevzoneindex;
        }
        
        playerweight = 0.7;
        zoneweight = 0.3;
        bestzoneindex = undefined;
        bestcost = undefined;
        
        foreach ( zoneset in level.var_4979f7dec57b922d )
        {
            skip = 0;
            
            foreach ( zoneindex in level.var_b2d215c849273987 )
            {
                if ( zoneset.objectivekey == zoneindex )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            playercost = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                playercost += distance2dsquared( zoneset.averageorigin, avgpos[ entry ] );
            }
            
            var_e728386febb436a4 = level.var_4979f7dec57b922d[ level.zones[ 0 ].objectivekey ].averageorigin;
            zonecost = distance2dsquared( zoneset.averageorigin, var_e728386febb436a4 );
            totalcost = playercost * playerweight + zonecost * zoneweight;
            
            if ( !isdefined( bestcost ) || totalcost > bestcost )
            {
                bestcost = totalcost;
                bestzoneindex = zoneset.objectivekey;
            }
        }
        
        index = bestzoneindex;
    }
    else if ( isdefined( level.prevzoneindex ) )
    {
        index = level.prevzoneindex + 1;
        
        if ( index == level.var_4979f7dec57b922d.size )
        {
            index = 0;
        }
    }
    else
    {
        index = 0;
    }
    
    return index;
}

// Namespace landgrab
// Params 0
// Checksum 0x618cd7c4, Offset: 0x304e
// Size: 0x157
function function_a8623a99a10c6ce3()
{
    if ( !isdefined( level.futurezoneindex ) )
    {
        return;
    }
    
    futurezones = [];
    
    foreach ( objective in level.objectives )
    {
        if ( objective.objectivekey == level.futurezoneindex )
        {
            futurezones[ futurezones.size ] = objective;
        }
    }
    
    for ( index = 0; index < futurezones.size ; index++ )
    {
        zone = futurezones[ index ];
        zone.trigger utility::trigger_on();
        objidpoolmanager::update_objective_state( 3 + index, "current" );
        objidpoolmanager::update_objective_position( 3 + index, zone.visuals[ 0 ].origin + zone.offset3d );
        zone gameobjects::setvisibleteam( "any", 3 + index );
        zone gameobjects::setobjectivestatusicons( level.iconnext, level.iconnext, 3 + index );
    }
}

// Namespace landgrab
// Params 1
// Checksum 0xa1e575e4, Offset: 0x31ad
// Size: 0x114
function function_3f2c14af41dbaa4c( zoneindex )
{
    futurezones = [];
    
    foreach ( objective in level.objectives )
    {
        if ( objective.objectivekey == zoneindex )
        {
            futurezones[ futurezones.size ] = objective;
        }
    }
    
    for ( index = 0; index < futurezones.size ; index++ )
    {
        zone = futurezones[ index ];
        level objidpoolmanager::returnreservedobjectiveid( 3 + index, 0 );
        objidpoolmanager::update_objective_state( 3 + index, "done" );
        objidpoolmanager::update_objective_position( 3 + index, zone.visuals[ 0 ].origin + zone.offset3d );
    }
}

// Namespace landgrab
// Params 1
// Checksum 0x30a3481d, Offset: 0x32c9
// Size: 0x87
function movezoneaftertime( time )
{
    level endon( #"game_ended" );
    level endon( #"zones_scored" );
    level endon( #"hash_a5281c9480b32767" );
    level.zonemovetime = time;
    level.var_9d2a58c02f01bb16 = 0;
    index = level.futurezoneindex;
    obj_zonecapture::zonetimerwait();
    
    if ( isdefined( index ) )
    {
        function_3f2c14af41dbaa4c( index );
    }
    
    level.var_9d2a58c02f01bb16 = 1;
    level notify( #"zones_moved" );
}

// Namespace landgrab
// Params 2
// Checksum 0xdbd5bae6, Offset: 0x3358
// Size: 0x240
function function_96d428777c00ac45( zoneactivationdelay, firstzone )
{
    if ( zoneactivationdelay > 0 )
    {
        foreach ( zone in level.zones )
        {
            if ( !zone.active )
            {
                continue;
            }
            
            zone gameobjects::setobjectivestatusicons( level.icontarget );
            luaindex = zone.index + 1;
            setomnvar( "ui_capture_locked_zone_" + luaindex, 1 );
            objidpoolmanager::function_4c19b2a4563b489( zone.objidnum, 1 );
        }
        
        level obj_zonecapture::updateservericons( "zone_activation_delay", 0 );
        level.zoneendtime = int( gettime() + 1000 * zoneactivationdelay );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 12 );
        level.zoneislocked = 1;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hash_c5f1725df5d0bc91", #"hash_c5f1725df5d0bc91" );
        wait zoneactivationdelay;
        level.zoneislocked = 0;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hash_18da61004d0ed6ad", #"hash_18da61004d0ed6ad" );
    }
    
    sound::playsoundonplayers( "mp_hq_activate_sfx" );
    
    foreach ( zone in level.zones )
    {
        if ( !zone.active )
        {
            continue;
        }
        
        luaindex = zone.index + 1;
        setomnvar( "ui_capture_locked_zone_" + luaindex, 0 );
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    level obj_zonecapture::updateservericons( "neutral", 0 );
}

// Namespace landgrab
// Params 1
// Checksum 0x33be6a0d, Offset: 0x35a0
// Size: 0xbc
function getzonearray( targetname )
{
    zones = getentarray( targetname, #targetname );
    
    foreach ( z in zones )
    {
        z.objectivekey = int( z.script_noteworthy );
    }
    
    if ( !isdefined( zones ) || zones.size == 0 )
    {
        return;
    }
    
    return zones;
}

// Namespace landgrab
// Params 0
// Checksum 0xaf06663d, Offset: 0x3665
// Size: 0x372
function setupzones()
{
    primaryzones = getzonearray( "landgrab_zone" );
    assert( isdefined( primaryzones.size > 3 ) );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    level.objectives = [];
    
    foreach ( trigger in triggers )
    {
        zone = obj_zonecapture::setupobjective( trigger );
        zone gameobjects::mustmaintainclaim( 0 );
        zone.onplayerenter = &onplayerenter;
        zone.onplayerexit = &onplayerexit;
        zone.onuseupdate = &function_9d203a9a89eb4c9d;
        zone.capturecount = 0;
        zone.capturelocked = 0;
        zone.var_3083acd20c6bd609 = &"t10_mp_ingame_only/landgrab_capture_locked";
        
        if ( isdefined( trigger.iconname ) )
        {
            zone.iconname = trigger.iconname;
        }
        else
        {
            zone.iconname = zone gameobjects::getlabel();
        }
        
        level.objectives[ level.objectives.size ] = zone;
        
        if ( !isdefined( level.var_4979f7dec57b922d[ trigger.objectivekey ] ) )
        {
            level.var_4979f7dec57b922d[ trigger.objectivekey ] = spawnstruct();
            level.var_4979f7dec57b922d[ trigger.objectivekey ].averageorigin = ( 0, 0, 0 );
            level.var_4979f7dec57b922d[ trigger.objectivekey ].objectivekey = trigger.objectivekey;
        }
        
        level.var_4979f7dec57b922d[ trigger.objectivekey ].averageorigin += zone.curorigin;
    }
    
    foreach ( zoneset in level.var_4979f7dec57b922d )
    {
        zoneset.averageorigin /= 3;
    }
    
    setomnvar( "ui_hardpoint_active_zone_count", 3 );
    
    if ( !level.randomLocationOrder )
    {
        for ( index = 0; index < 3 ; index++ )
        {
            objidpoolmanager::requestreservedid( 3 + index );
            objidpoolmanager::objective_set_play_intro( 3 + index, 0 );
            objidpoolmanager::objective_set_play_outro( 3 + index, 0 );
            objidpoolmanager::objective_add_objective( 3 + index, "done", ( 0, 0, 0 ) );
            objidpoolmanager::objective_playermask_showtoall( 3 + index );
        }
    }
}

// Namespace landgrab
// Params 1
// Checksum 0xe2593c46, Offset: 0x39df
// Size: 0x101
function resetzone( zone )
{
    zone notify( #"hash_29e6bedbd39696fd" );
    zone.lastclaimteam = "none";
    zone.lastprogressteam = "none";
    zone.ownerteam = "neutral";
    zone.prevownerteam = "neutral";
    zone.curprogress = 0;
    zone.capturelocked = 0;
    zone.lockupdatingicons = 0;
    zone gameobjects::resetcaptureprogress();
    objidpoolmanager::update_objective_ownerteam( zone.objidnum, undefined );
    objidpoolmanager::objective_set_progress( zone.objidnum, 0 );
    zone gameobjects::disableobject();
    zone gameobjects::allowuse( "none" );
    zone gameobjects::setownerteam( "neutral" );
    objidpoolmanager::objective_set_progress( zone.objidnum, 0 );
    zone obj_zonecapture::deactivatezone();
    zone.active = 0;
}

// Namespace landgrab
// Params 2
// Checksum 0x5f69ec07, Offset: 0x3ae8
// Size: 0x2f1
function function_b9ded27c6d596e96( zoneindex, firstsetup )
{
    level obj_zonecapture::updateservericons( "zone_shift", 0 );
    level.prevzoneindex = zoneindex;
    
    if ( level.zones.size > 0 )
    {
        foreach ( zone in level.zones )
        {
            if ( level.var_bb1c2c73a70095d8 && ( zone.iconname == "_a" || zone.iconname == "_c" ) )
            {
                continue;
            }
            
            resetzone( zone );
            objidpoolmanager::objective_show_progress( zone.objidnum, 0 );
        }
    }
    
    zones = [];
    
    foreach ( objective in level.objectives )
    {
        if ( objective.objectivekey == zoneindex )
        {
            zones[ zones.size ] = objective;
        }
    }
    
    sortedzones = [];
    
    for ( i = 0; i < zones.size ; i++ )
    {
        switch ( zones[ i ].iconname )
        {
            case #"hash_fac2c5f6bddd49bd":
                sortedzones[ 0 ] = zones[ i ];
                break;
            case #"hash_fac2c2f6bddd4504":
                sortedzones[ 1 ] = zones[ i ];
                break;
            case #"hash_fac2c3f6bddd4697":
                sortedzones[ 2 ] = zones[ i ];
                break;
            default:
                assertmsg( "<dev string:x4a>" + zone.iconname );
                break;
        }
    }
    
    /#
        assert( isdefined( sortedzones[ 0 ] ), "<dev string:x74>" );
        assert( isdefined( sortedzones[ 1 ] ), "<dev string:xa0>" );
        assert( isdefined( sortedzones[ 2 ] ), "<dev string:xcb>" );
    #/
    
    if ( !firstsetup )
    {
        function_7e76bd627c38231d();
    }
    
    hostmigration::waitlongdurationwithgameendtimeupdate( level.var_8ce2ed92af5d8b64 );
    
    if ( level.var_bb1c2c73a70095d8 )
    {
        setupzone( sortedzones, 1 );
    }
    else
    {
        for ( index = 0; index < sortedzones.size ; index++ )
        {
            setupzone( sortedzones, index );
        }
    }
    
    level.zones = sortedzones;
    assert( level.zones.size == 3 );
}

// Namespace landgrab
// Params 2
// Checksum 0xc2476e45, Offset: 0x3de1
// Size: 0xf5
function setupzone( sortedzones, index )
{
    zone = sortedzones[ index ];
    zone.index = index;
    zone obj_zonecapture::activatezone( 3 + index );
    zone.stompeenemyprogressupdate = &function_b868698ec2c83f43;
    zone.onuse = &zoneonuse;
    zone.onuseupdate = &function_9d203a9a89eb4c9d;
    zone.stompprogressreward = &function_fcd30a5dda46dd12;
    zone gameobjects::enableobject();
    zone thread obj_zonecapture::hardpoint_setneutral();
    zone gameobjects::allowuse( "none" );
    zone.active = 1;
    zone.didstatusnotify = 0;
    
    if ( level.zoneactivationdelay > 0 )
    {
        zone gameobjects::setobjectivestatusicons( level.icontarget );
        return;
    }
    
    zone gameobjects::setobjectivestatusicons( level.iconneutral );
}

// Namespace landgrab
// Params 0
// Checksum 0x3242039d, Offset: 0x3ede
// Size: 0x17f
function function_fbbba6e1c745812d()
{
    sound::playsoundonplayers( "mp_hq_activate_sfx" );
    
    for ( index = 0; index < level.zones.size ; index++ )
    {
        zone = level.zones[ index ];
        zone gameobjects::enableobject();
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
        zone thread obj_zonecapture::hardpoint_setneutral();
        zone gameobjects::allowuse( "enemy" );
        zone gameobjects::cancontestclaim( 1 );
        zone gameobjects::setvisibleteam( "any" );
        zone gameobjects::setusetext( &"mp/securing_position" );
        zone gameobjects::setusetime( level.zonecapturetime );
        zone gameobjects::function_f4b9c2e87f1364b4( level.zonecapturetimemin );
        objidpoolmanager::objective_show_progress( zone.objidnum, 1 );
        objidpoolmanager::function_4c19b2a4563b489( zone.objidnum, 0 );
    }
    
    if ( level.zoneduration > 0 )
    {
        level obj_zonecapture::updateservericons( "neutral", 0 );
        thread movezoneaftertime( level.zoneduration );
        level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 10 );
    }
    else
    {
        setomnvar( "ui_hq_status", -1 );
        level.var_9d2a58c02f01bb16 = 0;
    }
    
    level.var_d5df6d553f504add = gettime();
}

// Namespace landgrab
// Params 1
// Checksum 0xcf9538fa, Offset: 0x4065
// Size: 0x4d
function zoneonuse( credit_player )
{
    obj_zonecapture::zone_onuse( credit_player );
    
    if ( credit_player.var_20fb6d9e02a1d35 )
    {
        credit_player = credit_player.owner;
    }
    
    credit_player stats::setextrascore4( credit_player.pers[ "extrascore4" ] + 1 );
}

// Namespace landgrab
// Params 1
// Checksum 0x969a00ba, Offset: 0x40ba
// Size: 0x52
function function_fcd30a5dda46dd12( player )
{
    if ( player.var_20fb6d9e02a1d35 )
    {
        player = player.owner;
    }
    
    obj_zonecapture::zone_stompprogressreward( player );
    player stats::setextrascore2( player.pers[ "extrascore2" ] + 1, "blockCapture" );
}

// Namespace landgrab
// Params 1
// Checksum 0x55e4f3ff, Offset: 0x4114
// Size: 0x21
function function_b868698ec2c83f43( team )
{
    self.userate *= 2;
}

// Namespace landgrab
// Params 1
// Checksum 0x156d89a, Offset: 0x413d
// Size: 0x19
function onplayerenter( player )
{
    player.var_c36e159445e2a48b = 0;
}

// Namespace landgrab
// Params 1
// Checksum 0x7404f40, Offset: 0x415e
// Size: 0x17
function onplayerexit( player )
{
    player.var_c36e159445e2a48b = undefined;
}

// Namespace landgrab
// Params 4
// Checksum 0x3cc73b12, Offset: 0x417d
// Size: 0x19a
function function_9d203a9a89eb4c9d( team, progress, change, capplayer )
{
    zone = self;
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, team );
    
    if ( self.statusnotifytime > self.statusnotifytime + 5000 )
    {
        self.didstatusnotify = 0;
    }
    
    if ( progress > 0.005 && change && !zone.didstatusnotify )
    {
        otherteam = team_utility::getotherteam( team );
        
        if ( obj_dom::function_3e4359c70d90ca13( team ) )
        {
            dialog::statusdialog( #"hash_2c21297e7650d68c", otherteam );
            dialog::statusdialog( #"hash_7141bb476a58b2be", team );
            
            foreach ( flag in level.objectives )
            {
                flag.didstatusnotify = 1;
            }
        }
        else
        {
            dialog::statusdialog( "losing" + zone.iconname, otherteam );
            dialog::statusdialog( "securing" + zone.iconname, team );
        }
        
        zone.didstatusnotify = 1;
    }
    
    zone function_c18eb83275e643e7();
}

// Namespace landgrab
// Params 0
// Checksum 0xf5ef5165, Offset: 0x431f
// Size: 0x63
function function_c18eb83275e643e7()
{
    zone = self;
    luaindex = zone.index + 1;
    setomnvar( "ui_axis_player_count_zone_" + luaindex, zone.numtouching[ "axis" ] );
    setomnvar( "ui_allies_player_count_zone_" + luaindex, zone.numtouching[ "allies" ] );
}

// Namespace landgrab
// Params 1
// Checksum 0xade8c74b, Offset: 0x438a
// Size: 0x46
function function_6fcb3b30cda8dc8e( time )
{
    if ( level.timelimit == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.extratime ) )
    {
        level.extratime = 0;
    }
    
    level.extratime += time;
}

// Namespace landgrab
// Params 5
// Checksum 0xce3d2d8, Offset: 0x43d8
// Size: 0x15a
function function_b434347a2d26e62f( ownerteam, friendlyref, var_116d2ae4375997f3, enemyref, var_6dddc7199f6ecfee )
{
    score = gamescore::getteamscore( ownerteam );
    matchPoint = level.scorelimit - 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            ismatchpoint = score == matchPoint;
            
            if ( player.team == ownerteam )
            {
                var_95097aad3fa56ce5 = ismatchpoint ? "landgrab_friendly_match_score" : "landgrab_friendly_score";
                player hud_message::function_78fedf6f526825f4( var_95097aad3fa56ce5, level.gametypebundle.var_e662dd7f27d462eb );
                continue;
            }
            
            var_95097aad3fa56ce5 = ismatchpoint ? "landgrab_enemy_match_score" : "landgrab_enemy_score";
            player hud_message::function_78fedf6f526825f4( var_95097aad3fa56ce5, level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
}

// Namespace landgrab
// Params 0
// Checksum 0xe7e3c3e6, Offset: 0x453a
// Size: 0x99
function function_7e76bd627c38231d()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player hud_message::function_78fedf6f526825f4( "landgrab_new_zones", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
}

// Namespace landgrab
// Params 0
// Checksum 0x7779c4e6, Offset: 0x45db
// Size: 0xa7
function function_49311a96c6612b89()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player hud_message::function_78fedf6f526825f4( "landgrab_sudden_death", level.gametypebundle.var_e662dd7f27d462eb );
            player dialog::leaderdialogonplayer( "overtime" );
        }
    }
}

// Namespace landgrab
// Params 1
// Checksum 0xfd160f3d, Offset: 0x468a
// Size: 0xc7
function function_d69125784a36d697( defendingteam )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            var_95097aad3fa56ce5 = player.team == defendingteam ? "landgrab_clear_occupied_zones" : "landgrab_occupy_enemy_zones";
            player hud_message::function_78fedf6f526825f4( var_95097aad3fa56ce5, level.gametypebundle.var_e662dd7f27d462eb );
        }
    }
}

// Namespace landgrab
// Params 1
// Checksum 0xa066748b, Offset: 0x4759
// Size: 0xa5
function function_cfd81b36e931d377( time )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player hud_message::function_78fedf6f526825f4( "landgrab_time_added", level.gametypebundle.var_e662dd7f27d462eb, time );
        }
    }
}

/#

    // Namespace landgrab
    // Params 0
    // Checksum 0xd2369688, Offset: 0x4806
    // Size: 0x142, Type: dev
    function function_684df5bae7fd2a8b()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_allies" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_war_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:xf6>", points, 0 );
                level function_b434347a2d26e62f( "<dev string:xf6>", "<dev string:xfd>", "<dev string:x115>", "<dev string:x133>", "<dev string:x148>" );
                level notify( #"zones_scored" );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_axis" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_war_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x163>", points, 0 );
                level function_b434347a2d26e62f( "<dev string:x163>", "<dev string:xfd>", "<dev string:x115>", "<dev string:x133>", "<dev string:x148>" );
                level notify( #"zones_scored" );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_684df5bae7fd2a8b();
    }

#/
