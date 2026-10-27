// scripts\mp\gametypes\escort.gsc  (hash_0373619943a24f6e.gscc) (size: 34735 Bytes / 0x87af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8cd5203 (147673603)
// size ...... 34735 (0x87af)
// includes .. 27  (offset: 0x7e27)
// strings ... 102 (offset: 0x7eff)
// dev strs .. 14  (offset: 0x86eb)
// exports ... 77  (offset: 0x5513)
// cseg ...... 0x7e4 + 0x4d2f (0x5513)
// imports ... 233 (offset: 0x611b)
// animtree1 . 0   (offset: 0x87af)
// animtree2 . 0   (offset: 0x87af)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace escort;

// Namespace escort
// Params 0
// Checksum 0x6ad3557a, Offset: 0x802
// Size: 0x141
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
    callback::add( #"hash_44831cd44167723d", &function_1c7063b35ca44873 );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.ontimelimit = &ontimelimit;
    level.var_40cd999d911308e0 = &game_utility_mp::function_24298f56712800ff;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_84968d430abf1672;
    level.var_34db6683265d4f7d = 0;
    level.var_1bd10eaa1dd9259e = 0;
    level.var_1986243d14bbbca6 = 0;
    level.var_dbeaf99627787f48 = 0;
    level.override_unresolved_collision = &override_unresolved_collision;
}

// Namespace escort
// Params 0
// Checksum 0xd8de1dc6, Offset: 0x94b
// Size: 0x93
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.var_344d08786e6b5b2a = getmatchrulesdata( "escortData", "robotCaptureRadius" );
    level.var_291f3c19f5fae0ee = getmatchrulesdata( "escortData", "robotMoveSpeed" );
    level.var_1d6217b3b4dbb341 = getmatchrulesdata( "escortData", "robotMoveCheckpointScalar" );
    level.var_595af9da9052a32c = getmatchrulesdata( "escortData", "robotMoveOTScalar" );
    level.var_15e64db4b0aeb596 = getmatchrulesdata( "escortData", "robotRebootTime" );
    level.blockcapdisabled = getmatchrulesdata( "domData", "flagblockcapdisabled" );
}

// Namespace escort
// Params 0
// Checksum 0x99048753, Offset: 0x9e6
// Size: 0x22
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.overtime = dvars::dvarfloatvalue( "overtimeLimit", 60, 0, 180 );
}

// Namespace escort
// Params 0
// Checksum 0x4aa39ff5, Offset: 0xa10
// Size: 0x17f
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
        game_utility_mp::setobjectivetext( entry, &"objectives/escort" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/escort" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/escort_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/escort_hint" );
    }
    
    initspawns();
    level.escortroute = function_f2efd6bd1de96d8b();
    function_cd6bf34ba99ab3ae();
    seticonnames();
    function_20623c564a4cf882();
    thread initescortent();
    function_26397c6ee431d817();
    function_91c104451e6cff86();
    
    /#
        thread function_7337d4d409cea654();
    #/
    
    level.timelimit = function_d1945197493201a6();
}

// Namespace escort
// Params 0
// Checksum 0x227f2439, Offset: 0xb97
// Size: 0x6e
function function_d1945197493201a6()
{
    if ( !isdefined( game[ "safeguard_data" ] ) )
    {
        return level.timelimit;
    }
    
    defenders = game[ "defenders" ];
    data = game[ "safeguard_data" ];
    assert( isdefined( data[ defenders ] ), "<dev string:x24>" );
    timelimit = data[ defenders ].time * 0.001;
    return timelimit;
}

// Namespace escort
// Params 2
// Checksum 0x47e143b2, Offset: 0xc0e
// Size: 0x15
function override_unresolved_collision( player, ballowsuicide )
{
    
}

// Namespace escort
// Params 1
// Checksum 0x2b4d36a5, Offset: 0xc2b
// Size: 0x1b8
function spawnescortvehicle( startnode )
{
    spawndata = spawnstruct();
    spawndata.angles = ( 0, 0, 0 );
    spawndata.origin = level.escortroute[ startnode ];
    spawndata.targetname = "tank_drone";
    spawndata.vehicletype = "veh_cer_escort_tank_drone";
    escortent = vehicle_tracking::spawn_vehicle( spawndata );
    escortent addcomponent( "c2p" );
    escortent addcomponent( "path" );
    var_c39e2db90533cbff = 10;
    level.var_3bc2123299ba4b0b = [];
    
    foreach ( point in level.escortroute )
    {
        level.var_3bc2123299ba4b0b[ level.var_3bc2123299ba4b0b.size ] = var_c39e2db90533cbff;
    }
    
    current_spline_id = function_53253e8ea222ed60( level.escortroute, level.var_3bc2123299ba4b0b, 0, 0.23 );
    escortent function_eb88c4e66edbc855( "path", "catmullRomId", current_spline_id );
    escortent function_eb88c4e66edbc855( "path", "yawHelper", 0 );
    escortent function_eb88c4e66edbc855( "path", "instantaneousTime", function_c9565056ec6a55d5() * var_c39e2db90533cbff + 0.1 );
    escortent function_eb88c4e66edbc855( "path", "useManualSpeed", 1 );
    return escortent;
}

// Namespace escort
// Params 0
// Checksum 0x1ea91015, Offset: 0xdec
// Size: 0x11a
function function_99019d9221f37ff8()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    
    while ( isdefined( self ) )
    {
        if ( self vehicle_getspeed() > 1 )
        {
            vel = self vehicle_getvelocity();
            velnormal = vectornormalize( vel );
            frontpos = self.origin + velnormal * 30;
            frontleft = frontpos + anglestoleft( self.angles ) * 25;
            frontright = frontpos + anglestoright( self.angles ) * 25;
            door = function_6cf720856f2ecd74( frontleft, 50 );
            
            if ( isdefined( door ) && door isscriptableinstance() )
            {
                if ( door scriptabledoorisclosed() )
                {
                    door scriptabledooropen( "away", self.origin );
                }
            }
            
            door = function_6cf720856f2ecd74( frontright, 50 );
            
            if ( isdefined( door ) && door isscriptableinstance() )
            {
                if ( door scriptabledoorisclosed() )
                {
                    door scriptabledooropen( "away", self.origin );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace escort
// Params 0
// Checksum 0x4e0e59d8, Offset: 0xf0e
// Size: 0x19b
function function_cd2315b04f99e681()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    self.forcegameparticipant = 1;
    self.var_f8f3389a826c5d19 = 1;
    self.allowfriendlyfire = 1;
    
    while ( isdefined( self ) )
    {
        if ( level.gametypebundle.var_595376917423a9af )
        {
            if ( !level.zone.isunoccupied && !level.zone.stalemate )
            {
                if ( utility::issharedfuncdefined( #"escort", #"hash_b26b29f31e71b27a" ) )
                {
                    var_fc0855fa2437a745 = level.escortent utility::callsharedfunc( #"escort", #"hash_b26b29f31e71b27a" );
                    targetnode = level.escortroute[ var_fc0855fa2437a745 ];
                    
                    if ( targetnode )
                    {
                        forward = vectornormalize( targetnode - self.origin );
                        frontpos = self.origin + forward * 25;
                        function_11791b121923c99e( frontpos, 40, 65, 40 );
                        function_8d233018eebb800e( self.origin, 40, 65, 40 );
                    }
                }
            }
        }
        else if ( self vehicle_getspeed() > 1 )
        {
            velforward = vectornormalize( self vehicle_getvelocity() );
            frontpos = self.origin + velforward * 25;
            function_11791b121923c99e( frontpos, 40, 65, 40 );
            function_8d233018eebb800e( self.origin, 40, 65, 40 );
        }
        
        waitframe();
    }
}

// Namespace escort
// Params 4
// Checksum 0x831be4c5, Offset: 0x10b1
// Size: 0x2a7
function function_11791b121923c99e( pos, radius, height, depth )
{
    var_9f9da6058af759c3 = [[ level.getactiveequipmentarray ]]();
    
    foreach ( ent in var_9f9da6058af759c3 )
    {
        if ( utility::function_148a680721859842( ent.origin, pos, radius, height, depth ) )
        {
            ent dodamage( 10000, ent.origin, self, self, "MOD_CRUSH" );
        }
    }
    
    vehicles = vehicle_tracking::function_5820a38c9873992e();
    
    foreach ( ent in vehicles )
    {
        if ( utility::function_148a680721859842( ent.origin, pos, radius, height, depth ) )
        {
            ent dodamage( 10000, ent.origin, self, self, "MOD_CRUSH" );
        }
    }
    
    killstreaks = level.activekillstreaks;
    
    foreach ( ent in killstreaks )
    {
        var_fadad56ce2662034 = function_b018fce38e7508aa( ent );
        
        foreach ( corner in var_fadad56ce2662034 )
        {
            if ( utility::function_148a680721859842( corner, pos, radius, height, depth ) )
            {
                ent dodamage( 10000, ent.origin, self, self, "MOD_CRUSH" );
                break;
            }
        }
    }
    
    function_8d233018eebb800e( pos, radius, height, depth );
}

// Namespace escort
// Params 4
// Checksum 0x60e798c6, Offset: 0x1360
// Size: 0x161
function function_8d233018eebb800e( pos, radius, height, depth )
{
    crates = level.cratedata.crates;
    
    foreach ( ent in crates )
    {
        var_fadad56ce2662034 = function_b018fce38e7508aa( ent.mountmantlemodel ?? ent );
        var_fadad56ce2662034[ var_fadad56ce2662034.size ] = ent.origin;
        
        foreach ( corner in var_fadad56ce2662034 )
        {
            if ( utility::function_148a680721859842( corner, pos, radius, height, depth ) )
            {
                ent thread airdrop::destroycrate();
                break;
            }
        }
    }
}

// Namespace escort
// Params 1
// Checksum 0xacaec398, Offset: 0x14c9
// Size: 0x9d
function function_b018fce38e7508aa( ent )
{
    boundcorners = ent getboundscorners();
    
    if ( !boundcorners.size || boundcorners.size < 2 )
    {
        return;
    }
    
    var_fadad56ce2662034 = [ ( boundcorners[ 0 ][ 0 ], boundcorners[ 0 ][ 1 ], boundcorners[ 1 ][ 2 ] ), ( boundcorners[ 0 ][ 0 ], boundcorners[ 1 ][ 1 ], boundcorners[ 1 ][ 2 ] ), ( boundcorners[ 1 ][ 0 ], boundcorners[ 0 ][ 1 ], boundcorners[ 1 ][ 2 ] ), ( boundcorners[ 1 ][ 0 ], boundcorners[ 1 ][ 1 ], boundcorners[ 1 ][ 2 ] ) ];
    return var_fadad56ce2662034;
}

// Namespace escort
// Params 0
// Checksum 0x2a2c8bda, Offset: 0x156f
// Size: 0x209
function function_37e38958e141f5fd()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    self endon( #"death" );
    
    while ( self )
    {
        self waittill( #"escort_disabled", attackerlist );
        thread function_4c4f4c85610f6e22();
        
        foreach ( attacker in attackerlist )
        {
            if ( isplayer( attacker ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
                {
                    if ( isdefined( attacker.leaderboarddata[ "escortEnt_kills" ] ) )
                    {
                        attacker.leaderboarddata[ "escortEnt_kills" ] = attacker.leaderboarddata[ "escortEnt_kills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "escortEnt_kills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "escortEnt_kills" ] ]]( attacker, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x4e>" );
                    
                    if ( isdefined( attacker.pers[ "escortEnt_kills" ] ) )
                    {
                        attacker.pers[ "escortEnt_kills" ] = attacker.pers[ "escortEnt_kills" ] + 1;
                    }
                }
                
                attacker stats::setextrascore3( attacker.pers[ "escortEnt_kills" ], "escortEnt_kills" );
                attacker thread points::doscoreevent( #"disabled_escort_robot" );
            }
        }
        
        dialog::statusdialog( #"robot_disabled_attacker", game[ "attackers" ] );
        dialog::statusdialog( #"robot_disabled_defender", game[ "defenders" ] );
        self waittill( #"rebooting_complete" );
    }
}

// Namespace escort
// Params 0
// Checksum 0xea1412ee, Offset: 0x1780
// Size: 0x18d
function function_4c4f4c85610f6e22()
{
    utility::flag_set( "rebooting" );
    escortzone = level.escortent.zone;
    objidpoolmanager::objective_set_progress_team( escortzone.objidnum, "neutral" );
    objidpoolmanager::function_84651f3f2873ee19( escortzone.objidnum, "neutral" );
    escortzone gameobjects::setownerteam( level.attackersteam );
    escortzone gameobjects::setobjectivestatusicons( level.var_5160b107823f7779, level.var_65ff2e433d96c4da );
    var_16e3cfc31bafda69 = level.var_15e64db4b0aeb596;
    var_fd115eee849b42fe = gettime() * 0.001;
    
    while ( var_16e3cfc31bafda69 > 0 )
    {
        var_fd115eee849b42fe += 0.1;
        var_3c1a754ee4aa37ba = var_fd115eee849b42fe - gettime() * 0.001;
        wait var_3c1a754ee4aa37ba;
        var_a6ddf6d8942bfc8a = max( var_16e3cfc31bafda69 - 0.1, 0 );
        objectivesetprogress( var_a6ddf6d8942bfc8a / level.var_15e64db4b0aeb596 );
        var_16e3cfc31bafda69 -= 0.1;
    }
    
    utility::flag_clear( "rebooting" );
    escortzone resetzone();
    
    if ( escortzone.stalemate )
    {
        escortzone gameobjects::setownerteam( "neutral" );
        escortzone zoneoncontested();
    }
    else if ( function_8ea371dae66464a8() )
    {
        escortzone capturezone( level.attackersteam );
    }
    
    level.escortent function_3527f662c0f4d682();
    self notify( #"rebooting_complete" );
}

// Namespace escort
// Params 1
// Checksum 0x2fd30c39, Offset: 0x1915
// Size: 0x19e
function function_f54b61ac445b15d7( startnode )
{
    aitype = "sat_dawg_safeguard";
    nextnode = startnode == 0 ? startnode + 1 : startnode - 1;
    origin = level.escortroute[ startnode ];
    angles = level.gametypebundle.var_d2fca88d4aa40040 ? vectortoangles( level.escortroute[ nextnode ] - level.escortroute[ startnode ] ) : ( 0, 0, 0 );
    team = level.gametypebundle.var_d2fca88d4aa40040 ? game[ "attackers" ] : undefined;
    
    if ( utility::issharedfuncdefined( #"escort", #"escort_ai_spawn" ) )
    {
        escortai = utility::callsharedfunc( #"escort", #"escort_ai_spawn", origin, angles, team );
    }
    else
    {
        escortai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, origin, angles, team );
    }
    
    if ( utility::issharedfuncdefined( #"escort", #"hash_1416e3f64b880e8d" ) )
    {
        escortai utility::callsharedfunc( #"escort", #"hash_1416e3f64b880e8d", level.escortroute, startnode, 0 );
    }
    
    if ( utility::issharedfuncdefined( #"escort", #"hash_20041b95f95e7b68" ) )
    {
        escortai utility::callsharedfunc( #"escort", #"hash_20041b95f95e7b68", level.var_15e64db4b0aeb596 );
    }
    
    return escortai;
}

// Namespace escort
// Params 3
// Checksum 0xa5a9dc3f, Offset: 0x1abc
// Size: 0xe2
function function_52fbc842641bb63( centerpoint, radius, numflares )
{
    flarestruct = {};
    flarestruct.list = [];
    angleincrement = 360 / numflares;
    
    for ( i = 0; i < numflares ; i++ )
    {
        angle = i * angleincrement;
        flarepos = ( centerpoint[ 0 ] + cos( angle ) * radius, centerpoint[ 1 ] + sin( angle ) * radius, centerpoint[ 2 ] );
        randomrotation = ( 0, randomint( 360 ), 0 );
        flarestruct.list[ i ] = spawnscriptable( "cer_gamemode_chevron", utility::drop_to_ground( flarepos, 32, -32 ) + ( 0, 0, 0 ), randomrotation );
    }
    
    return flarestruct;
}

// Namespace escort
// Params 0
// Checksum 0x85624017, Offset: 0x1ba7
// Size: 0x1b0
function function_26397c6ee431d817()
{
    if ( level.gametypebundle.var_11545e7601780f3d )
    {
        return;
    }
    
    pathstartteam = level.var_b8d670531a345f93[ "start" ];
    pathendteam = level.var_b8d670531a345f93[ "end" ];
    pathindex25 = level.var_b8d670531a345f93[ pathstartteam + "Half" ];
    pathindex75 = level.var_b8d670531a345f93[ pathendteam + "Half" ];
    var_18d412bdb56b4ea7 = level.escortroute[ pathindex25 ];
    var_18ea06bdb5836776 = level.escortroute[ pathindex75 ];
    level.var_7afe14c349d25596 = function_52fbc842641bb63( var_18d412bdb56b4ea7, 50, 8 );
    level.var_7225fdc5578bc9f5 = function_52fbc842641bb63( var_18ea06bdb5836776, 50, 8 );
    
    if ( level.gametypebundle.var_d2fca88d4aa40040 )
    {
        level.var_7afe14c349d25596.team = game[ "attackers" ];
        level.var_7225fdc5578bc9f5.team = game[ "attackers" ];
        function_86dc6b7976de0998( level.var_7afe14c349d25596, game[ "attackers" ] );
        function_86dc6b7976de0998( level.var_7225fdc5578bc9f5, game[ "attackers" ] );
        return;
    }
    
    level.var_7afe14c349d25596.team = game[ pathstartteam ];
    level.var_7225fdc5578bc9f5.team = game[ pathendteam ];
    function_86dc6b7976de0998( level.var_7afe14c349d25596, game[ pathstartteam ] );
    function_86dc6b7976de0998( level.var_7225fdc5578bc9f5, game[ pathendteam ] );
}

// Namespace escort
// Params 0
// Checksum 0xf7298923, Offset: 0x1d5f
// Size: 0x139
function function_91c104451e6cff86()
{
    if ( !level.gametypebundle.var_944ed38eaad7d37b )
    {
        return;
    }
    
    var_95d4b9e72801b56c = level.escortroute[ level.var_b8d670531a345f93[ "attackersEnd" ] ];
    level.var_6cd17e473c254f77 = spawn( "script_model", var_95d4b9e72801b56c );
    level.var_6cd17e473c254f77.team = game[ "attackers" ];
    level.var_6cd17e473c254f77 setmodel( "sabattack_zone_script_fx_origin" );
    level.var_6cd17e473c254f77 setscriptablepartstate( #"main", game[ "attackers" ] );
    
    if ( !level.gametypebundle.var_d2fca88d4aa40040 )
    {
        var_90581e3c04efdb18 = level.escortroute[ level.var_b8d670531a345f93[ "defendersEnd" ] ];
        level.var_46588aa888a9a64b = spawn( "script_model", var_90581e3c04efdb18 );
        level.var_46588aa888a9a64b.team = game[ "defenders" ];
        level.var_46588aa888a9a64b setmodel( "sabattack_zone_script_fx_origin" );
        level.var_46588aa888a9a64b setscriptablepartstate( #"main", game[ "defenders" ] );
    }
}

// Namespace escort
// Params 0
// Checksum 0x6c38df19, Offset: 0x1ea0
// Size: 0x53d
function initescortent()
{
    level endon( #"game_ended" );
    startnode = function_c9565056ec6a55d5();
    var_d2fca88d4aa40040 = level.gametypebundle.var_d2fca88d4aa40040;
    
    if ( level.gametypebundle.var_595376917423a9af )
    {
        while ( !level.var_f334a2aa4deb0aeb )
        {
            waitframe();
        }
        
        escortent = function_f54b61ac445b15d7( startnode );
        escortent.var_69b04c32b196fa43 = startnode;
    }
    else
    {
        escortent = spawnescortvehicle( startnode );
        escortent.var_69b04c32b196fa43 = startnode;
    }
    
    if ( var_d2fca88d4aa40040 )
    {
        escortent.var_2e49280c75a5326e = level.var_b8d670531a345f93[ "start" ] == "attackers" ? 1 : 0;
        escortent.smallcheckpoint = startnode;
        escortent.largecheckpoint = level.var_b8d670531a345f93[ "defendersHalf" ];
    }
    else
    {
        escortent.var_2e49280c75a5326e = 0.5;
        escortent.smallcheckpoint = startnode;
        escortent.largecheckpoint = level.var_b8d670531a345f93[ level.var_b8d670531a345f93[ "end" ] + "Half" ];
    }
    
    setomnvar( "ui_escort_goal_percent", escortent.var_2e49280c75a5326e );
    escortent.speedmultiplier = 1;
    level.attackersteam = game[ level.var_b8d670531a345f93[ "start" ] ];
    level.defendersteam = game[ level.var_b8d670531a345f93[ "end" ] ];
    useobjectowner = "neutral";
    var_9eebec6dac41b758 = "enemy";
    
    if ( var_d2fca88d4aa40040 )
    {
        escortent.var_ab177ee3be93b505 = namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"hash_3a7187cdb4df8a34", escortent.origin, game[ "attackers" ], undefined, escortent );
        escortent.var_1c3be0271eb66a3c = namespace_9d8e359c3b1041e5::addspawninfluencersharedfunc( #"gametype_flag_cancel", escortent.origin, undefined, undefined, escortent );
        useobjectowner = level.attackersteam;
        var_9583a57394c260e4 = "any";
    }
    
    trigger = spawn( "trigger_radius", level.escortroute[ startnode ], 0, level.var_344d08786e6b5b2a, 96 );
    zone = gameobjects::createuseobject( useobjectowner, trigger, [], ( 0, 0, 70 ), 0, 0, 1 );
    zone gameobjects::allowuse( var_9583a57394c260e4 );
    zone gameobjects::setvisibleteam( "any" );
    
    if ( !var_d2fca88d4aa40040 )
    {
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    zone gameobjects::cancontestclaim( 1 );
    zone gameobjects::pinobjiconontriggertouch();
    zone gameobjects::setusetime( 0 );
    objidpoolmanager::objective_set_show_progress( zone.objidnum, 1 );
    objidpoolmanager::update_objective_onentity( zone.objidnum, escortent );
    objidpoolmanager::update_objective_setzoffset( zone.objidnum, 70 );
    objidpoolmanager::function_b1d5cb1069461e4f( zone.objidnum, 0 );
    setomnvar( "ui_wm_escort_objective_id", zone.objidnum );
    zone.var_e83b66c96cc29c17 = &"mp_ingame_only/obj_escorting_caps";
    zone.var_dca8426b95acfcc0 = 1;
    zone.alwaysstalemate = 0;
    zone.id = "hardpoint";
    zone.checkuseconditioninthink = 1;
    zone.onplayerenter = &function_af81e135ffb1b37e;
    zone.onplayerexit = &function_ae39f76007065ca8;
    zone.usecondition = &zoneusecondition;
    
    if ( !var_d2fca88d4aa40040 )
    {
        zone.onuse = &zoneonuse;
    }
    
    zone.oncontested = &zoneoncontested;
    zone.onuncontested = &zoneonuncontested;
    zone.onunoccupied = &zoneonunoccupied;
    tracestart = level.escortroute[ startnode ] + ( 0, 0, 32 );
    traceend = level.escortroute[ startnode ] + ( 0, 0, -32 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    zone.trigger enablelinkto();
    zone.trigger linkto( escortent );
    zone.escortent = escortent;
    escortent.zone = zone;
    level.zone = zone;
    level.escortent = escortent;
    escortent function_3527f662c0f4d682();
    zone thread function_99e81ba4fffe0c4d();
    zone thread function_c2d9708abb5f0706();
    
    if ( !level.gametypebundle.var_595376917423a9af )
    {
        escortent thread function_99019d9221f37ff8();
    }
    
    escortent thread function_cd2315b04f99e681();
    escortent thread function_37e38958e141f5fd();
    utility::flag_init( "rebooting" );
}

// Namespace escort
// Params 0
// Checksum 0x52a8fd63, Offset: 0x23e5
// Size: 0x3b
function function_c9565056ec6a55d5()
{
    if ( level.gametypebundle.var_d2fca88d4aa40040 )
    {
        return level.var_b8d670531a345f93[ "defendersEnd" ];
    }
    
    return level.var_b8d670531a345f93[ "escortStart" ];
}

// Namespace escort
// Params 0
// Checksum 0xe52181a7, Offset: 0x2428
// Size: 0xa7
function function_99e81ba4fffe0c4d()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    level.escortent utility::waittill_any( "reached_end_node", "escort_ai_reached_end_node" );
    winningteam = game[ level.var_b8d670531a345f93[ "end" ] ];
    gamescore::giveteamscoreforobjective( winningteam, level.gametypebundle.var_22d6a8c3e407eb14 ?? 0 );
    function_90091f45f4039638( winningteam, level.gametypebundle.var_22d6a8c3e407eb14 ?? 0 );
    thread endgame( winningteam, game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace escort
// Params 0
// Checksum 0x970952ed, Offset: 0x24d7
// Size: 0xa7
function function_c2d9708abb5f0706()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    level.escortent utility::waittill_any( "reached_start_node", "escort_ai_reached_start_node" );
    winningteam = game[ level.var_b8d670531a345f93[ "start" ] ];
    gamescore::giveteamscoreforobjective( winningteam, level.gametypebundle.var_22d6a8c3e407eb14 ?? 0 );
    function_90091f45f4039638( winningteam, level.gametypebundle.var_22d6a8c3e407eb14 ?? 0 );
    thread endgame( winningteam, game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace escort
// Params 2
// Checksum 0x273b926e, Offset: 0x2586
// Size: 0x274
function endgame( winner, endreasontext )
{
    attackers = game[ "attackers" ];
    defenders = game[ "defenders" ];
    
    if ( level.gametypebundle.var_d2fca88d4aa40040 )
    {
        if ( !isdefined( game[ "safeguard_data" ] ) )
        {
            game[ "safeguard_data" ] = [];
        }
        
        data = game[ "safeguard_data" ];
        
        if ( !isdefined( data[ attackers ] ) )
        {
            data[ attackers ] = {};
        }
        
        data[ attackers ].progress = function_5a45289f7329a7da();
        data[ attackers ].time = gettime() - level.starttime;
        
        if ( !isdefined( data[ attackers ].escorted ) )
        {
            data[ attackers ].escorted = 0;
        }
        
        escortsuccess = endreasontext == game[ "end_reason" ][ "objective_completed" ] || endreasontext == game[ "end_reason" ][ "score_limit_reached" ];
        
        if ( escortsuccess )
        {
            data[ attackers ].escorted++;
            endreasontext = game[ "end_reason" ][ "escort_entity_delivered_in" ];
            setomnvar( "ui_escort_ent_delivered_time", int( data[ attackers ].time * 0.001 ) );
        }
        
        if ( game[ "finalRound" ] == 1 && gamescore::gethighestscoringteam() == "tie" )
        {
            if ( data[ attackers ].escorted > 0 )
            {
                if ( data[ attackers ].time < data[ defenders ].time )
                {
                    winner = attackers;
                }
                else
                {
                    winner = defenders;
                }
                
                endreasontext = game[ "end_reason" ][ "escort_add_point_fastest_win" ];
            }
            else if ( data[ attackers ].escorted == 0 )
            {
                pathdirection = level.var_b8d670531a345f93[ "attackersEnd" ] == 0 ? -1 : 1;
                endreasontext = game[ "end_reason" ][ "escort_add_point_distance_win" ];
                
                if ( pathdirection == -1 )
                {
                    winner = data[ attackers ].progress < data[ defenders ].progress ? attackers : defenders;
                }
                else if ( pathdirection == 1 )
                {
                    winner = data[ attackers ].progress > data[ defenders ].progress ? attackers : defenders;
                }
            }
            
            gamescore::giveteamscoreforobjective( winner, 1 );
        }
    }
    
    gamelogic_mp::endgame( winner, endreasontext );
}

// Namespace escort
// Params 0
// Checksum 0x86c56547, Offset: 0x2802
// Size: 0x97
function seticonnames()
{
    if ( !level.gametypebundle.var_d2fca88d4aa40040 )
    {
        level.iconneutral = "waypoint_captureneutral";
    }
    
    level.iconfriendlyend = "waypoint_friendlyEnd";
    level.iconenemyend = "waypoint_enemyEnd";
    level.iconcontested = "waypoint_contested";
    level.var_3321fde719805e13 = "waypoint_friendlyEscortStill";
    level.var_27eb3ae8eb35c539 = "waypoint_friendlyEscortMoving";
    level.icondestroy = "waypoint_enemyDestroy";
    level.var_5160b107823f7779 = "waypoint_friendlyRebooting";
    level.var_65ff2e433d96c4da = "waypoint_enemyRebooting";
}

// Namespace escort
// Params 0
// Checksum 0xf4c62abc, Offset: 0x28a1
// Size: 0x1f3
function function_20623c564a4cf882()
{
    var_d2fca88d4aa40040 = level.gametypebundle.var_d2fca88d4aa40040;
    
    if ( !var_d2fca88d4aa40040 )
    {
        gamelogic_mp::setwaypointiconinfo( level.iconneutral, 0, "neutral", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "ui_icon_waypoint_safeguard", 0, undefined );
    }
    
    gamelogic_mp::setwaypointiconinfo( level.iconenemyend, 0, "enemy", &"mp_ingame_only/obj_goal_caps", "ui_icon_waypoint_goal", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.iconfriendlyend, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_icon_waypoint_goal", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.iconcontested, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_icon_waypoint_safeguard", 1, undefined );
    gamelogic_mp::setwaypointiconinfo( level.var_3321fde719805e13, 0, "friendly", &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "ui_icon_waypoint_safeguard", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.var_27eb3ae8eb35c539, 0, "friendly", &"mp_ingame_only/obj_escorting_caps", "ui_icon_waypoint_safeguard", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.icondestroy, 0, "enemy", &"mp_ingame_only/obj_attack_caps", "ui_icon_waypoint_safeguard", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.var_5160b107823f7779, 0, "friendly", &"mp_ingame_only/obj_escort_rebooting_caps", "ui_icon_waypoint_safeguard", 0, undefined );
    gamelogic_mp::setwaypointiconinfo( level.var_65ff2e433d96c4da, 0, "enemy", &"mp_ingame_only/obj_escort_rebooting_caps", "ui_icon_waypoint_safeguard", 0, undefined );
    gamelogic_mp::function_e2716c6f000db813( level.var_5160b107823f7779, 1 );
    gamelogic_mp::function_e2716c6f000db813( level.var_65ff2e433d96c4da, 1 );
    setomnvar( "ui_escort_goal_percent", 0.5 );
    setomnvar( "ui_escort_ent_speed", 0 );
    setomnvar( "ui_escort_owner_team", 0 );
    function_611ae85ab7bafad2( "defenders", 1, "attackersEnd" );
    
    if ( !var_d2fca88d4aa40040 )
    {
        function_611ae85ab7bafad2( "defenders", 2, "defendersEnd" );
    }
}

// Namespace escort
// Params 3
// Checksum 0xed909b5d, Offset: 0x2a9c
// Size: 0xd3
function function_611ae85ab7bafad2( team, objid, nodename )
{
    teamowner = game[ team ];
    origin = level.escortroute[ level.var_b8d670531a345f93[ nodename ] ];
    trigger = spawn( "trigger_radius", origin, 0, 128, 128 );
    zone = gameobjects::createuseobject( teamowner, trigger, [], ( 0, 0, 70 ), objid, 0, 1 );
    zone gameobjects::allowuse( "none" );
    zone gameobjects::setvisibleteam( "any" );
    objidpoolmanager::update_objective_state( objid, "current" );
    zone gameobjects::setobjectivestatusicons( level.iconfriendlyend, level.iconenemyend );
}

// Namespace escort
// Params 0
// Checksum 0x21add1f6, Offset: 0x2b77
// Size: 0x317
function function_f2efd6bd1de96d8b()
{
    if ( isdefined( level.escortroute ) )
    {
        return level.escortroute;
    }
    
    patharray = [];
    level.var_b8d670531a345f93 = [];
    currnode = getvehiclenode( "attackersEnd", #targetname );
    
    if ( !isdefined( currnode.target ) )
    {
        currnode = getvehiclenode( "defendersEnd", #targetname );
        level.var_b8d670531a345f93[ "defendersEnd" ] = 0;
        level.var_b8d670531a345f93[ "start" ] = "defenders";
        level.var_b8d670531a345f93[ "end" ] = "attackers";
    }
    else
    {
        level.var_b8d670531a345f93[ "attackersEnd" ] = 0;
        level.var_b8d670531a345f93[ "start" ] = "attackers";
        level.var_b8d670531a345f93[ "end" ] = "defenders";
    }
    
    patharray[ patharray.size ] = currnode.origin;
    
    while ( isdefined( currnode.target ) )
    {
        currnode = getvehiclenode( currnode.target, #targetname );
        
        if ( isdefined( currnode.script_noteworthy ) )
        {
            switch ( currnode.script_noteworthy )
            {
                case #"hash_be0e5b930f64d78a":
                    /#
                        if ( isdefined( level.var_b8d670531a345f93[ "<dev string:x74>" ] ) )
                        {
                            assertmsg( "<dev string:x82>" );
                        }
                    #/
                    
                    level.var_b8d670531a345f93[ "attackersHalf" ] = patharray.size;
                    break;
                case #"hash_fa039494e8eed1fe":
                    /#
                        if ( isdefined( level.var_b8d670531a345f93[ "<dev string:xd8>" ] ) )
                        {
                            assertmsg( "<dev string:xe6>" );
                        }
                    #/
                    
                    level.var_b8d670531a345f93[ "defendersHalf" ] = patharray.size;
                    break;
                case #"hash_7641f1d29b2dccef":
                    /#
                        if ( isdefined( level.var_b8d670531a345f93[ "<dev string:x13d>" ] ) )
                        {
                            assertmsg( "<dev string:x149>" );
                        }
                    #/
                    
                    level.var_b8d670531a345f93[ "escortStart" ] = patharray.size;
                    break;
                default:
                    assertmsg( "<dev string:x199>" + currnode.script_noteworthy );
                    break;
            }
        }
        
        patharray[ patharray.size ] = currnode.origin;
    }
    
    if ( !isdefined( level.var_b8d670531a345f93[ "defendersEnd" ] ) )
    {
        level.var_b8d670531a345f93[ "defendersEnd" ] = patharray.size - 1;
    }
    else
    {
        level.var_b8d670531a345f93[ "attackersEnd" ] = patharray.size - 1;
    }
    
    if ( isdefined( level.var_af100497a2e0fe56 ) )
    {
        patharray = [[ level.var_af100497a2e0fe56 ]]( patharray, level.var_b8d670531a345f93 );
    }
    
    /#
        assert( isdefined( level.var_b8d670531a345f93[ "<dev string:x74>" ] ), "<dev string:x1c3>" );
        assert( isdefined( level.var_b8d670531a345f93[ "<dev string:x13d>" ] ), "<dev string:x214>" );
        assert( isdefined( level.var_b8d670531a345f93[ "<dev string:xd8>" ] ), "<dev string:x261>" );
    #/
    
    return patharray;
}

// Namespace escort
// Params 0
// Checksum 0xcd57c74b, Offset: 0x2e97
// Size: 0x47
function function_cd6bf34ba99ab3ae()
{
    exclusionzones = getentarray( "escortExclusionZone", #targetname );
    
    if ( isdefined( level.var_ac49c2aa55733b91 ) )
    {
        exclusionzones = [[ level.var_ac49c2aa55733b91 ]]( exclusionzones );
    }
    
    level.var_24798a15671dc5d = exclusionzones;
}

// Namespace escort
// Params 1
// Checksum 0xe0e5ba1, Offset: 0x2ee6
// Size: 0x15c
function function_aa4be300cce9f75e( ownerteam )
{
    zone = self;
    
    if ( game_utility_mp::inovertime() || level.var_dbeaf99627787f48 )
    {
        return level.var_595af9da9052a32c;
    }
    
    if ( level.gametypebundle.var_bf5b84fd214e71d1 )
    {
        return round( level.escortent.speedmultiplier, 0.1 );
    }
    
    playerspeedmultiplier = 0;
    enemyteam = team_utility::getotherteam( ownerteam );
    enemyteamsize = zone.touchlist[ enemyteam ].size;
    ownerteamsize = zone.touchlist[ ownerteam ].size;
    
    switch ( ownerteamsize - enemyteamsize )
    {
        case 4:
        case 5:
        case 6:
            playerspeedmultiplier += 0.3;
            break;
        case 3:
            playerspeedmultiplier += 0.2;
            break;
        case 2:
            playerspeedmultiplier += 0.1;
            break;
        default:
            break;
    }
    
    return round( level.escortent.speedmultiplier + playerspeedmultiplier, 0.1 );
}

// Namespace escort
// Params 1
// Checksum 0xb68c6a00, Offset: 0x304b
// Size: 0x33
function getteamside( team )
{
    teamside = "attackers";
    
    if ( team != game[ "attackers" ] )
    {
        teamside = "defenders";
    }
    
    return teamside;
}

// Namespace escort
// Params 2
// Checksum 0x905e7a82, Offset: 0x3087
// Size: 0xde
function function_1bdc342f243cba64( var_668a7cfd4cf262d2, nextnodebenchmark )
{
    previouspoint = level.escortroute[ var_668a7cfd4cf262d2 ];
    endpoint = level.escortroute[ nextnodebenchmark ];
    var_9545a1ad00e8e3ea = distance( level.escortent.origin, previouspoint );
    var_53f8cd224b9a1bbe = distance( level.escortent.origin, endpoint );
    totaldistance = var_9545a1ad00e8e3ea + var_53f8cd224b9a1bbe;
    var_a18cfa2b1efde9ce = var_9545a1ad00e8e3ea / totaldistance;
    var_ca22fc88934a87ed = var_a18cfa2b1efde9ce / 4;
    var_17346e32abcdf635 = ( 1 - var_53f8cd224b9a1bbe / totaldistance ) / 4;
    goalupdate = math::lerp( var_ca22fc88934a87ed, var_17346e32abcdf635, var_a18cfa2b1efde9ce );
    return goalupdate;
}

// Namespace escort
// Params 3
// Checksum 0xb9328ca, Offset: 0x316e
// Size: 0x480
function function_92cdd513175967e2( var_87a792e86514f6b3, pathdirection, captureteam )
{
    pathstartteam = level.var_b8d670531a345f93[ "start" ];
    pathendteam = level.var_b8d670531a345f93[ "end" ];
    pathindex25 = level.var_b8d670531a345f93[ pathstartteam + "Half" ];
    pathindexhalf = level.var_b8d670531a345f93[ "escortStart" ];
    pathindex75 = level.var_b8d670531a345f93[ pathendteam + "Half" ];
    pathindexend = level.var_b8d670531a345f93[ pathendteam + "End" ];
    var_69b04c32b196fa43 = level.escortent.var_69b04c32b196fa43;
    
    if ( var_87a792e86514f6b3 )
    {
        if ( var_69b04c32b196fa43 < pathindex25 )
        {
            var_2e49280c75a5326e = 0;
            smallcheckpoint = 0;
            largecheckpoint = pathindex25;
        }
        else if ( var_69b04c32b196fa43 < pathindexhalf )
        {
            var_2e49280c75a5326e = 0.25;
            smallcheckpoint = pathindex25;
            largecheckpoint = pathindexhalf;
        }
        else if ( var_69b04c32b196fa43 < pathindex75 )
        {
            var_2e49280c75a5326e = 0.5;
            smallcheckpoint = pathindexhalf;
            largecheckpoint = pathindex75;
        }
        else
        {
            var_2e49280c75a5326e = 0.75;
            smallcheckpoint = pathindex75;
            largecheckpoint = pathindexend;
        }
    }
    else if ( var_69b04c32b196fa43 >= pathindex75 )
    {
        var_2e49280c75a5326e = 0.75;
        smallcheckpoint = pathindex75;
        largecheckpoint = pathindexend;
    }
    else if ( var_69b04c32b196fa43 >= pathindexhalf )
    {
        var_2e49280c75a5326e = 0.5;
        smallcheckpoint = pathindexhalf;
        largecheckpoint = pathindex75;
    }
    else if ( var_69b04c32b196fa43 >= pathindex25 )
    {
        var_2e49280c75a5326e = 0.25;
        smallcheckpoint = pathindex25;
        largecheckpoint = pathindexhalf;
    }
    else
    {
        var_2e49280c75a5326e = 0;
        smallcheckpoint = 0;
        largecheckpoint = pathindex25;
    }
    
    function_95252b07fe39560e( var_87a792e86514f6b3, smallcheckpoint, largecheckpoint, var_2e49280c75a5326e );
    
    if ( level.var_7afe14c349d25596.team == captureteam )
    {
        reachedcheckpoint = pathdirection > 0 && var_69b04c32b196fa43 >= pathindex25 || pathdirection < 0 && var_69b04c32b196fa43 <= pathindex25;
        
        if ( reachedcheckpoint )
        {
            level.escortent.speedmultiplier = level.var_1d6217b3b4dbb341;
            
            if ( !level.var_34db6683265d4f7d )
            {
                gamescore::giveteamscoreforobjective( captureteam, 1 );
                function_7267092caedb2e06( captureteam, 1 );
                level.var_34db6683265d4f7d = 1;
                function_86dc6b7976de0998( level.var_7afe14c349d25596, "idle" );
                
                if ( game_utility_mp::inovertime() )
                {
                    thread endgame( captureteam, game[ "end_reason" ][ "score_limit_reached" ] );
                }
            }
        }
    }
    
    if ( level.var_7225fdc5578bc9f5.team == captureteam )
    {
        reachedcheckpoint = pathdirection > 0 && var_69b04c32b196fa43 >= pathindex75 || pathdirection < 0 && var_69b04c32b196fa43 <= pathindex75;
        
        if ( reachedcheckpoint )
        {
            level.escortent.speedmultiplier = level.var_1d6217b3b4dbb341;
            
            if ( !level.var_1bd10eaa1dd9259e )
            {
                gamescore::giveteamscoreforobjective( captureteam, 1 );
                function_7267092caedb2e06( captureteam, 1 );
                level.var_1bd10eaa1dd9259e = 1;
                function_86dc6b7976de0998( level.var_7225fdc5578bc9f5, "idle" );
            }
            
            if ( game_utility_mp::inovertime() )
            {
                thread endgame( captureteam, game[ "end_reason" ][ "score_limit_reached" ] );
            }
        }
    }
    
    if ( !level.var_1986243d14bbbca6 )
    {
        closetogoal = pathdirection > 0 ? function_5a45289f7329a7da() > 0.75 : function_5a45289f7329a7da() < 0.25;
        
        if ( closetogoal )
        {
            level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_bbff9ad7333cc150" );
            level.var_1986243d14bbbca6 = 1;
            dialog::statusdialog( #"hash_9d3f6a888be0c6b", game[ "attackers" ] );
            dialog::statusdialog( #"hash_3f06b4b27720bb33", game[ "defenders" ] );
        }
    }
    
    if ( !level.gametypebundle.var_d2fca88d4aa40040 )
    {
        reachedhalfway = var_87a792e86514f6b3 && var_69b04c32b196fa43 < pathindexhalf || !var_87a792e86514f6b3 && var_69b04c32b196fa43 >= pathindexhalf;
        
        if ( reachedhalfway )
        {
            level.escortent.speedmultiplier = 1;
        }
    }
    
    level.escortent.var_2e49280c75a5326e = var_2e49280c75a5326e;
    level.escortent.smallcheckpoint = smallcheckpoint;
    level.escortent.largecheckpoint = largecheckpoint;
    escortspeed = function_aa4be300cce9f75e( captureteam );
    function_44dd5386d3fed7bc( escortspeed, pathdirection );
}

// Namespace escort
// Params 2
// Checksum 0x6cda6a5f, Offset: 0x35f6
// Size: 0x95
function function_86dc6b7976de0998( flarestruct, state )
{
    foreach ( flare in flarestruct.list )
    {
        flare setscriptablepartstate( "chevron_0", state );
    }
}

// Namespace escort
// Params 1
// Checksum 0x3ad8b095, Offset: 0x3693
// Size: 0x303
function updateescortgoalprogress( var_87a792e86514f6b3 )
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    level.escortent notify( #"updateescortgoalprogress" );
    level.escortent endon( #"updateescortgoalprogress" );
    zone = self;
    zone endon( #"zone_unoccupied" );
    zone endon( #"zone_contested" );
    ownerteam = zone gameobjects::getownerteam();
    var_11056bf4d550899a = 0;
    waitduration = 0.1;
    
    while ( !level.gameended )
    {
        function_95252b07fe39560e( var_87a792e86514f6b3, level.escortent.smallcheckpoint, level.escortent.largecheckpoint, level.escortent.var_2e49280c75a5326e );
        
        foreach ( object in zone.touchlist[ ownerteam ] )
        {
            currplayer = object.player;
            
            if ( !isdefined( currplayer ) )
            {
                continue;
            }
            
            if ( var_11056bf4d550899a >= 1 )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( currplayer ) ) )
                {
                    if ( isdefined( currplayer.leaderboarddata[ "objTime" ] ) )
                    {
                        currplayer.leaderboarddata[ "objTime" ] = currplayer.leaderboarddata[ "objTime" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objTime" ] ]]( currplayer, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x4e>" );
                    
                    if ( isdefined( currplayer.pers[ "objTime" ] ) )
                    {
                        currplayer.pers[ "objTime" ] = currplayer.pers[ "objTime" ] + 1;
                    }
                }
                
                currplayer stats::setextrascore0( currplayer.pers[ "objTime" ], "objTime" );
            }
            
            if ( !isdefined( currplayer.var_14cec456f2366e06 ) )
            {
                currplayer.var_14cec456f2366e06 = 0;
            }
            
            if ( currplayer.var_14cec456f2366e06 >= 3 )
            {
                currplayer thread points::doscoreevent( #"hash_4245a8ac196b8094" );
                currplayer.var_14cec456f2366e06 = 0;
            }
            
            currplayer.var_14cec456f2366e06 += waitduration;
        }
        
        if ( var_11056bf4d550899a >= 1 )
        {
            var_11056bf4d550899a = 0;
        }
        
        var_11056bf4d550899a += waitduration;
        wait waitduration;
    }
}

// Namespace escort
// Params 1
// Checksum 0x5e89f34d, Offset: 0x399e
// Size: 0x2c
function function_1c7063b35ca44873( data )
{
    if ( data.escortent )
    {
        data.escortent function_3527f662c0f4d682();
    }
}

// Namespace escort
// Params 0
// Checksum 0xc0f4f60f, Offset: 0x39d2
// Size: 0x2d
function function_3527f662c0f4d682()
{
    healthpercent = self.health / self.maxhealth;
    objectivesetprogress( 1 - healthpercent );
}

// Namespace escort
// Params 1
// Checksum 0x862428cd, Offset: 0x3a07
// Size: 0x6d
function objectivesetprogress( progress )
{
    objectiveprogress = level.var_b8d670531a345f93[ "attackersEnd" ] == 0 ? 1 - progress : progress;
    objidpoolmanager::objective_set_progress( level.escortent.zone.objidnum, clamp( objectiveprogress, 0, 1 ) );
}

// Namespace escort
// Params 4
// Checksum 0x834be34c, Offset: 0x3a7c
// Size: 0x65
function function_95252b07fe39560e( var_87a792e86514f6b3, smallcheckpoint, largecheckpoint, var_2e49280c75a5326e )
{
    if ( utility::flag( "rebooting" ) )
    {
        return;
    }
    
    var_f7b6bfaeb75291e8 = function_1bdc342f243cba64( smallcheckpoint, largecheckpoint );
    progress = var_2e49280c75a5326e + var_f7b6bfaeb75291e8;
    setomnvar( "ui_escort_goal_percent", progress );
}

// Namespace escort
// Params 0
// Checksum 0x302df495, Offset: 0x3ae9
// Size: 0xb
function function_5a45289f7329a7da()
{
    return getomnvar( "ui_escort_goal_percent" );
}

// Namespace escort
// Params 1
// Checksum 0x25e00cf2, Offset: 0x3afd
// Size: 0xb3
function function_af81e135ffb1b37e( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.var_53f7b0aaa96112e7 = 0;
    player.var_c36e159445e2a48b = 0;
    
    if ( level.gametypebundle.var_d2fca88d4aa40040 && isdefined( player.team ) )
    {
        zone = self;
        
        if ( player.team != level.attackersteam )
        {
            return;
        }
        
        if ( !zone.isunoccupied )
        {
            return;
        }
        
        zone capturezone( player.team );
        player notify( #"player_zone_captured", 0 );
        function_c18eb83275e643e7();
    }
}

// Namespace escort
// Params 1
// Checksum 0xf0651e02, Offset: 0x3bb8
// Size: 0x17
function function_ae39f76007065ca8( player )
{
    player.var_c36e159445e2a48b = undefined;
}

// Namespace escort
// Params 1
// Checksum 0xb40723b2, Offset: 0x3bd7
// Size: 0x8a, Type: bool
function zoneusecondition( player )
{
    foreach ( zone in level.var_24798a15671dc5d )
    {
        if ( player istouching( zone ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace escort
// Params 1
// Checksum 0x7de480ed, Offset: 0x3c6a
// Size: 0x59
function zoneonuse( creditplayer )
{
    zone = self;
    
    if ( !( isdefined( creditplayer ) && isdefined( creditplayer.team ) ) )
    {
        return;
    }
    
    zone capturezone( creditplayer.team );
    creditplayer notify( #"player_zone_captured", 0 );
    function_c18eb83275e643e7();
}

// Namespace escort
// Params 0
// Checksum 0xd8982d7b, Offset: 0x3ccb
// Size: 0x5f
function function_a14da9e898ddc07d()
{
    zone = self;
    axiscount = zone.touchlist[ "axis" ].size;
    alliescount = zone.touchlist[ "allies" ].size;
    var_1425be620949e0cb = abs( axiscount - alliescount );
    return int( var_1425be620949e0cb );
}

// Namespace escort
// Params 0
// Checksum 0x973da277, Offset: 0x3d33
// Size: 0x7f
function function_c18eb83275e643e7()
{
    zone = self;
    luaindex = zone.objidnum + 1;
    setomnvar( "ui_axis_player_count_zone_" + luaindex, zone.numtouching[ "axis" ] );
    setomnvar( "ui_allies_player_count_zone_" + luaindex, zone.numtouching[ "allies" ] );
    var_1425be620949e0cb = function_a14da9e898ddc07d();
    setomnvar( "ui_escort_zone_net_player_count", var_1425be620949e0cb );
}

// Namespace escort
// Params 0
// Checksum 0xb30d6ea6, Offset: 0x3dba
// Size: 0xf, Type: bool
function function_8ea371dae66464a8()
{
    return function_e15d026d85905b40() > function_ca0fc731363474e0();
}

// Namespace escort
// Params 1
// Checksum 0xb7c7a23a, Offset: 0x3dd2
// Size: 0x123
function capturezone( captureteam )
{
    level endon( #"rebooting" );
    
    if ( utility::flag( "rebooting" ) )
    {
        return;
    }
    
    zone = self;
    zone objidpoolmanager::objective_set_progress_team( zone.objidnum, captureteam );
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, captureteam );
    zone gameobjects::setownerteam( captureteam );
    zone gameobjects::setobjectivestatusicons( level.var_3321fde719805e13, level.icondestroy );
    claimteamside = getteamside( captureteam );
    var_87a792e86514f6b3 = claimteamside == level.var_b8d670531a345f93[ "start" ];
    
    if ( var_87a792e86514f6b3 )
    {
        pathdirection = -1;
    }
    else
    {
        pathdirection = 1;
    }
    
    setomnvar( "ui_escort_owner_team", pathdirection );
    
    if ( var_87a792e86514f6b3 )
    {
        zone function_6605fc88a45f2844( var_87a792e86514f6b3, pathdirection, captureteam );
        dialog::statusdialog( #"advance_attacker", captureteam );
        dialog::statusdialog( #"advance_defender", game[ "defenders" ] );
    }
    
    zone thread updateescortgoalprogress( var_87a792e86514f6b3 );
    function_c18eb83275e643e7();
}

// Namespace escort
// Params 3
// Checksum 0xadbbaca4, Offset: 0x3efd
// Size: 0xb6
function function_6605fc88a45f2844( var_87a792e86514f6b3, pathdirection, captureteam )
{
    zone = self;
    
    if ( level.gametypebundle.var_595376917423a9af )
    {
        zone thread function_682cc48adeff663( var_87a792e86514f6b3, pathdirection, captureteam );
    }
    else
    {
        zone thread function_830150bf772392f9( var_87a792e86514f6b3, pathdirection, captureteam );
    }
    
    zone gameobjects::setobjectivestatusicons( level.var_27eb3ae8eb35c539, level.icondestroy );
    
    if ( function_ca0fc731363474e0() > 0 )
    {
        objidpoolmanager::function_3fe36cbe084664b7( level.escortent.zone.objidnum, 1 );
    }
    
    setomnvar( "ui_escort_ent_moving", 1 );
}

// Namespace escort
// Params 2
// Checksum 0xed9307ac, Offset: 0x3fbb
// Size: 0x6c
function function_793fada9eb60733d( speedmulti, pathdirection )
{
    movespeed = level.var_291f3c19f5fae0ee * speedmulti;
    level.escortent function_eb88c4e66edbc855( "path", "instantaneousSpeed", utility::mph_to_ips( movespeed * pathdirection ) );
    setomnvar( "ui_escort_ent_speed", level.escortent.speedmultiplier );
}

// Namespace escort
// Params 3
// Checksum 0xa4f56173, Offset: 0x402f
// Size: 0x11b
function function_830150bf772392f9( var_87a792e86514f6b3, pathdirection, captureteam )
{
    self notify( #"hash_84df099c0d78de25" );
    self endon( #"hash_84df099c0d78de25" );
    level endon( #"game_ended" );
    level endon( #"round_end" );
    zone = self;
    zone endon( #"zone_unoccupied" );
    zone endon( #"zone_contested" );
    currspeed = zone function_aa4be300cce9f75e( captureteam );
    var_c595edb900349847 = zone function_a14da9e898ddc07d();
    function_793fada9eb60733d( currspeed, pathdirection );
    function_c18eb83275e643e7();
    function_92cdd513175967e2( var_87a792e86514f6b3, pathdirection, captureteam );
    childthread function_b983b92361131aec( var_87a792e86514f6b3, captureteam, pathdirection );
    
    while ( true )
    {
        movespeedupdate = zone function_aa4be300cce9f75e( captureteam );
        
        if ( movespeedupdate != currspeed )
        {
            function_793fada9eb60733d( movespeedupdate, pathdirection );
            currspeed = movespeedupdate;
        }
        
        netplayercount = zone function_a14da9e898ddc07d();
        
        if ( netplayercount != var_c595edb900349847 )
        {
            function_c18eb83275e643e7();
            var_c595edb900349847 = netplayercount;
        }
        
        wait 0.15;
    }
}

// Namespace escort
// Params 3
// Checksum 0x57b75c8c, Offset: 0x4152
// Size: 0x68
function function_b983b92361131aec( var_87a792e86514f6b3, captureteam, pathdirection )
{
    while ( true )
    {
        level.escortent waittill( #"reached_curve", curveindex );
        level.escortent.var_69b04c32b196fa43 = curveindex;
        thread function_92cdd513175967e2( var_87a792e86514f6b3, pathdirection, captureteam );
    }
}

// Namespace escort
// Params 3
// Checksum 0xbdd51984, Offset: 0x41c2
// Size: 0x11a
function function_682cc48adeff663( var_87a792e86514f6b3, pathdirection, captureteam )
{
    self notify( #"hash_b387dd81832497fa" );
    self endon( #"hash_b387dd81832497fa" );
    level endon( #"game_ended" );
    level endon( #"round_end" );
    zone = self;
    zone endon( #"zone_unoccupied" );
    zone endon( #"zone_contested" );
    currspeed = zone function_aa4be300cce9f75e( captureteam );
    var_c595edb900349847 = zone function_a14da9e898ddc07d();
    function_1fc68c2637545de1( pathdirection );
    function_c18eb83275e643e7();
    function_92cdd513175967e2( var_87a792e86514f6b3, pathdirection, captureteam );
    childthread function_f4c533e64d28bc02( var_87a792e86514f6b3, captureteam, pathdirection );
    
    while ( true )
    {
        movespeedupdate = zone function_aa4be300cce9f75e( captureteam );
        
        if ( movespeedupdate != currspeed )
        {
            function_de3fdde26f3a299( movespeedupdate, pathdirection );
            currspeed = movespeedupdate;
        }
        
        netplayercount = zone function_a14da9e898ddc07d();
        
        if ( netplayercount != var_c595edb900349847 )
        {
            function_c18eb83275e643e7();
            var_c595edb900349847 = netplayercount;
        }
        
        wait 0.15;
    }
}

// Namespace escort
// Params 3
// Checksum 0xdb306251, Offset: 0x42e4
// Size: 0x16c
function function_f4c533e64d28bc02( var_87a792e86514f6b3, captureteam, pathdirection )
{
    if ( level.escortent utility::issharedfuncdefined( #"escort", #"hash_6edd39baefe275f9" ) )
    {
        currnode = level.escortent utility::callsharedfunc( #"escort", #"hash_6edd39baefe275f9" );
    }
    
    while ( true )
    {
        if ( level.escortent utility::issharedfuncdefined( #"escort", #"hash_6edd39baefe275f9" ) )
        {
            var_76abbb912018c105 = level.escortent utility::callsharedfunc( #"escort", #"hash_6edd39baefe275f9" );
            
            if ( currnode && currnode != var_76abbb912018c105 )
            {
                currnode = var_76abbb912018c105;
                level.escortent.var_69b04c32b196fa43 = currnode;
                thread function_92cdd513175967e2( var_87a792e86514f6b3, pathdirection, captureteam );
            }
        }
        
        if ( level.escortent utility::issharedfuncdefined( #"escort", #"hash_b33c46a72a3bd370" ) )
        {
            if ( level.escortent utility::callsharedfunc( #"escort", #"hash_b33c46a72a3bd370" ) )
            {
                message = pathdirection > 0 ? "escort_ai_reached_end_node" : "escort_ai_reached_start_node";
                level.escortent notify( message );
            }
        }
        
        waitframe();
    }
}

// Namespace escort
// Params 1
// Checksum 0xc327378d, Offset: 0x4458
// Size: 0x71
function function_1fc68c2637545de1( pathdirection )
{
    escortai = level.escortent;
    
    if ( !escortai || !pathdirection )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"escort", #"hash_1416e3f64b880e8d" ) )
    {
        escortai utility::callsharedfunc( #"escort", #"hash_1416e3f64b880e8d", level.escortroute, undefined, pathdirection );
    }
}

// Namespace escort
// Params 2
// Checksum 0x9adac74e, Offset: 0x44d1
// Size: 0x76
function function_de3fdde26f3a299( movespeedmultiplier, pathdirection )
{
    escortai = level.escortent;
    
    if ( !escortai )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"escort", #"hash_b2d41febe9815cd5" ) )
    {
        escortai utility::callsharedfunc( #"escort", #"hash_b2d41febe9815cd5", movespeedmultiplier, pathdirection );
    }
    
    setomnvar( "ui_escort_ent_speed", movespeedmultiplier );
}

// Namespace escort
// Params 0
// Checksum 0xe4baba5c, Offset: 0x454f
// Size: 0x54
function function_d5a83a356ea1c1fd()
{
    escortai = level.escortent;
    
    if ( !escortai )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"escort", #"hash_b501f4d1d15bdf75" ) )
    {
        escortai utility::callsharedfunc( #"escort", #"hash_b501f4d1d15bdf75" );
    }
}

// Namespace escort
// Params 0
// Checksum 0xb549c2dc, Offset: 0x45ab
// Size: 0x5e
function function_60d711f07d57bbc1()
{
    level.escortent.zone gameobjects::setobjectivestatusicons( level.var_3321fde719805e13, level.icondestroy );
    objidpoolmanager::function_3fe36cbe084664b7( level.escortent.zone.objidnum, 0 );
    setomnvar( "ui_escort_ent_moving", 0 );
}

// Namespace escort
// Params 2
// Checksum 0x3b364e32, Offset: 0x4611
// Size: 0x41
function function_44dd5386d3fed7bc( movespeedmultiplier, pathdirection )
{
    if ( level.gametypebundle.var_595376917423a9af )
    {
        function_de3fdde26f3a299( movespeedmultiplier );
        return;
    }
    
    function_793fada9eb60733d( movespeedmultiplier, pathdirection );
}

// Namespace escort
// Params 0
// Checksum 0x4b8d6c50, Offset: 0x465a
// Size: 0x4c
function function_e15d026d85905b40()
{
    if ( !isdefined( level.escortent.zone.numtouching ) )
    {
        return;
    }
    
    return level.escortent.zone.numtouching[ level.attackersteam ];
}

// Namespace escort
// Params 0
// Checksum 0xd272ae63, Offset: 0x46af
// Size: 0x4c
function function_ca0fc731363474e0()
{
    if ( !isdefined( level.escortent.zone.numtouching ) )
    {
        return;
    }
    
    return level.escortent.zone.numtouching[ level.defendersteam ];
}

// Namespace escort
// Params 0
// Checksum 0xd85716a, Offset: 0x4704
// Size: 0xec
function zoneoncontested()
{
    level endon( #"rebooting" );
    
    if ( utility::flag( "rebooting" ) )
    {
        return;
    }
    
    zone = self;
    zone notify( #"zone_contested" );
    
    if ( level.gametypebundle.var_595376917423a9af )
    {
        function_d5a83a356ea1c1fd();
        function_60d711f07d57bbc1();
    }
    else
    {
        function_793fada9eb60733d( 0, 0 );
    }
    
    dialog::statusdialog( #"contested_attacker", game[ "attackers" ] );
    dialog::statusdialog( #"contested_defender", game[ "defenders" ] );
    setomnvar( "ui_escort_owner_team", 5 );
    zone gameobjects::setobjectivestatusicons( level.iconcontested );
    zone objidpoolmanager::objective_set_progress_team( zone.objidnum, "neutral" );
    zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, "neutral" );
    function_c18eb83275e643e7();
}

// Namespace escort
// Params 1
// Checksum 0x92edf452, Offset: 0x47f8
// Size: 0xb8
function zoneonuncontested( lastclaimteam )
{
    zone = self;
    ownerteam = zone gameobjects::getownerteam();
    var_d2fca88d4aa40040 = level.gametypebundle.var_d2fca88d4aa40040;
    
    if ( lastclaimteam == "none" || ownerteam == "neutral" || var_d2fca88d4aa40040 )
    {
        zone resetzone();
    }
    else
    {
        zone capturezone( lastclaimteam );
    }
    
    if ( var_d2fca88d4aa40040 )
    {
        if ( function_8ea371dae66464a8() )
        {
            zone capturezone( level.attackersteam );
        }
        else if ( level.var_dbeaf99627787f48 )
        {
            endgameontimelimit();
        }
    }
    
    function_c18eb83275e643e7();
}

// Namespace escort
// Params 0
// Checksum 0xa737ef2, Offset: 0x48b8
// Size: 0x38
function zoneonunoccupied()
{
    zone = self;
    zone notify( #"zone_unoccupied" );
    zone resetzone();
    
    if ( level.var_dbeaf99627787f48 )
    {
        endgameontimelimit();
    }
}

// Namespace escort
// Params 0
// Checksum 0x3994bf, Offset: 0x48f8
// Size: 0x147
function resetzone()
{
    level endon( #"rebooting" );
    
    if ( utility::flag( "rebooting" ) )
    {
        return;
    }
    
    zone = self;
    zone.lastclaimteam = "none";
    zone.lastprogressteam = "none";
    
    if ( level.gametypebundle.var_595376917423a9af )
    {
        function_d5a83a356ea1c1fd();
        function_60d711f07d57bbc1();
    }
    else
    {
        function_793fada9eb60733d( 0, 0 );
    }
    
    if ( level.gametypebundle.var_d2fca88d4aa40040 )
    {
        zone objidpoolmanager::objective_set_progress_team( zone.objidnum, level.attackersteam );
        zone gameobjects::setownerteam( level.attackersteam );
        zone gameobjects::setobjectivestatusicons( level.var_3321fde719805e13, level.icondestroy );
        zone gameobjects::setclaimteam( level.attackersteam );
    }
    else
    {
        zone gameobjects::setownerteam( "neutral" );
        zone gameobjects::setobjectivestatusicons( level.iconneutral );
        zone objidpoolmanager::function_84651f3f2873ee19( zone.objidnum, "neutral" );
    }
    
    setomnvar( "ui_escort_owner_team", 0 );
    setomnvar( "ui_escort_zone_net_player_count", 0 );
    function_c18eb83275e643e7();
}

// Namespace escort
// Params 0
// Checksum 0xead44b2, Offset: 0x4a47
// Size: 0xe1
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_c87bd865d7b44cd0( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_ctf_spawn_allies", game[ "defenders" ] );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_ctf_spawn_axis", game[ "attackers" ] );
    }
    
    spawnlogic::finalizemap();
}

// Namespace escort
// Params 0
// Checksum 0x6b7b6615, Offset: 0x4b30
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace escort
// Params 1
// Checksum 0xcf6ccdd, Offset: 0x4b42
// Size: 0x8d
function onplayerconnect( player )
{
    player thread function_dfdfbb2c06e3d5a5();
    player stats::setextrascore0( player.pers[ "objTime" ] ?? 0, "objTime" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
    player stats::setextrascore2( 0, "objectivekills" );
    player stats::setextrascore3( player.pers[ "escortEnt_kills" ] ?? 0, "escortEnt_kills" );
}

// Namespace escort
// Params 0
// Checksum 0xc6489e0, Offset: 0x4bd7
// Size: 0x7c
function function_dfdfbb2c06e3d5a5()
{
    player = self;
    
    if ( !isdefined( player.team ) )
    {
        player waittill( #"joined_team" );
    }
    
    teamside = getteamside( player.team );
    
    if ( teamside == level.var_b8d670531a345f93[ "start" ] )
    {
        player setclientomnvar( "ui_escort_player_team", -1 );
        return;
    }
    
    player setclientomnvar( "ui_escort_player_team", 1 );
}

// Namespace escort
// Params 1
// Checksum 0x20416614, Offset: 0x4c5b
// Size: 0x98
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    stats::setextrascore0( self.pers[ "objTime" ] ?? 0, "objTime" );
    stats::setextrascore1( self.pers[ "defends" ] ?? 0, "defends" );
    stats::setextrascore2( self.pers[ "extrascore2" ] ?? 0, "objectivekills" );
    stats::setextrascore3( self.pers[ "escortEnt_kills" ] ?? 0, "escortEnt_kills" );
}

// Namespace escort
// Params 1
// Checksum 0x4f1f82de, Offset: 0x4cfb
// Size: 0x2e4
function function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( !isplayer( attacker ) || !isplayer( victim ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( isdefined( deathdata.objweapon ) && weapon::iskillstreakweapon( deathdata.objweapon.basename ) )
    {
        return;
    }
    
    zone = level.zone;
    ownerteam = zone gameobjects::getownerteam();
    
    if ( !isdefined( ownerteam ) )
    {
        return;
    }
    
    var_a844077fc818e557 = 0;
    attackerteam = attacker.team;
    
    if ( attackerteam != ownerteam )
    {
        if ( victim istouching( zone.trigger ) )
        {
            attacker thread rank::function_d2aa8986c506e985( #"assault" );
            attacker events::function_58da673c1c3fc9f2();
            attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1 );
            attacker thread events::function_f3b6ddfecdb144fa( 0 );
        }
        
        return;
    }
    
    if ( attacker istouching( zone.trigger ) )
    {
        attacker thread rank::function_d2aa8986c506e985( #"defend" );
        attacker events::function_20a5f572df6afd43();
        
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
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x4e>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker stats::setextrascore1( attacker.pers[ "defends" ] );
        attacker stats::setextrascore2( attacker.pers[ "extrascore2" ] + 1 );
        
        if ( isdefined( attacker.var_c36e159445e2a48b ) )
        {
            attacker.var_c36e159445e2a48b++;
            
            if ( attacker.var_c36e159445e2a48b == 5 )
            {
                attacker thread events::function_d4fd7d540188e407();
            }
        }
    }
}

// Namespace escort
// Params 0
// Checksum 0x877380a6, Offset: 0x4fe7
// Size: 0xa3
function ontimelimit()
{
    var_a20f6b304357f1c1 = !level.zone.isunoccupied && ( !level.gametypebundle.var_d2fca88d4aa40040 || function_8ea371dae66464a8() || level.zone.stalemate );
    
    if ( !level.var_dbeaf99627787f48 && var_a20f6b304357f1c1 )
    {
        level.extratime = level.overtime;
        level.var_dbeaf99627787f48 = 1;
        function_49311a96c6612b89( level.extratime );
        return;
    }
    
    endgameontimelimit();
}

// Namespace escort
// Params 0
// Checksum 0x4b4e0406, Offset: 0x5092
// Size: 0xb5
function endgameontimelimit()
{
    winner = gamescore::gethighestscoringteam();
    
    if ( game[ "status" ] == "overtime" )
    {
        winner = "forfeit";
    }
    else if ( game[ "status" ] == "tie" && level.roundlimit == level.currentround )
    {
        winner = "overtime";
    }
    else if ( level.gametypebundle.var_d2fca88d4aa40040 )
    {
        winner = game[ "defenders" ];
        gamescore::giveteamscoreforobjective( winner, level.gametypebundle.var_22d6a8c3e407eb14 ?? 0, 0 );
    }
    
    thread endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace escort
// Params 2
// Checksum 0x74c9d82e, Offset: 0x514f
// Size: 0xbd
function function_90091f45f4039638( teamname, points )
{
    foreach ( player in level.players )
    {
        if ( player.team == teamname )
        {
            player hud_message::function_78fedf6f526825f4( #"hash_123217a9498fbdf", level.gametypebundle.var_e662dd7f27d462eb, points );
        }
    }
}

// Namespace escort
// Params 2
// Checksum 0x8dde5629, Offset: 0x5214
// Size: 0xe3
function function_7267092caedb2e06( teamname, points )
{
    foreach ( player in level.players )
    {
        if ( player.team == teamname )
        {
            player hud_message::function_78fedf6f526825f4( #"hash_17b49658886fdb91", level.gametypebundle.var_e662dd7f27d462eb );
            waitframe();
            player hud_message::function_78fedf6f526825f4( #"hash_123217a9498fbdf", level.gametypebundle.var_e662dd7f27d462eb, points );
        }
    }
}

// Namespace escort
// Params 1
// Checksum 0x22cd08b6, Offset: 0x52ff
// Size: 0xf0
function function_49311a96c6612b89( extratime )
{
    var_9e796424bdf8bde6 = level.gametypebundle.var_9e796424bdf8bde6 ?? 0;
    
    foreach ( player in level.players )
    {
        player hud_message::function_78fedf6f526825f4( #"hash_51ae1a1bc4b82802", level.gametypebundle.var_e662dd7f27d462eb );
        waitframe();
        
        if ( !var_9e796424bdf8bde6 )
        {
            player hud_message::function_78fedf6f526825f4( #"hash_46bef68dcc5aa8e4", level.gametypebundle.var_e662dd7f27d462eb, extratime );
        }
    }
}

/#

    // Namespace escort
    // Params 0
    // Checksum 0xba21c6a5, Offset: 0x53f7
    // Size: 0x11c, Type: dev
    function function_7337d4d409cea654()
    {
        level endon( #"game_ended" );
        level notify( #"hash_913fbe08657ceeaf" );
        level endon( #"hash_913fbe08657ceeaf" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_allies" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_escort_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x2b1>", points, 0 );
                function_90091f45f4039638( "<dev string:x2b1>", points );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_axis" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_escort_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x2b8>", points, 0 );
                function_90091f45f4039638( "<dev string:x2b8>", points );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_7337d4d409cea654();
    }

#/
