// script_4c43ae7605bdd091  (hash_4c43ae7605bdd091.gscc) (size: 14963 Bytes / 0x3a73 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6248be98 (1648934552)
// size ...... 14963 (0x3a73)
// includes .. 15  (offset: 0x3837)
// strings ... 26  (offset: 0x38af)
// dev strs .. 7   (offset: 0x3a1f)
// exports ... 34  (offset: 0x26a3)
// cseg ...... 0x2cb + 0x23d8 (0x26a3)
// imports ... 98  (offset: 0x2bf3)
// animtree1 . 0   (offset: 0x3a73)
// animtree2 . 0   (offset: 0x3a73)
#using script_3953cae29477fdd4;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevent_bountyroyale;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace namespace_191d099ac4db2477;

// Namespace namespace_191d099ac4db2477
// Params 0, eflags: 0x5
// Checksum 0x93bca1b0, Offset: 0x2e9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bc39f357669ed2da", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_191d099ac4db2477
// Params 0, eflags: 0x4
// Checksum 0xa0b2a007, Offset: 0x312
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_BOUNTY_ROYALE", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_BOUNTY_ROYALE" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x5766d282, Offset: 0x342
// Size: 0x6c
function function_323fab1b62a2d5d4( eventinfo )
{
    if ( !flags::gameflagexists( "bounty_royale_pe_init" ) )
    {
        flags::gameflaginit( "bounty_royale_pe_init", 0 );
    }
    
    eventinfo.waitfunc = &br_publicevent_bountyroyale::waitfunc;
    eventinfo.postinitfunc = &br_publicevent_bountyroyale::postinitfunc;
    eventinfo.canactivatefunc = &br_publicevent_bountyroyale::canactivatefunc;
    eventinfo.deactivatefunc = &br_publicevent_bountyroyale::function_c7a6338c6f315a82;
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xd302aa04, Offset: 0x3b6
// Size: 0x6f
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_BOUNTY_ROYALE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_BOUNTY_ROYALE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_BOUNTY_ROYALE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_BOUNTY_ROYALE", 3, &function_d4acef179eb9f9b2 );
    
    if ( level.usegulag )
    {
        activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &onplayerrespawn, "BR_PUBLIC_EVENT_BOUNTY_ROYALE" );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xf618e6e1, Offset: 0x42d
// Size: 0x69
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    level.var_533642d714767ad8 = 1;
    activity_instance.var_bbfe55644d1207a5 = 1;
    level.var_d7be75388b125a1c = 1;
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xa3dac645, Offset: 0x49e
// Size: 0x14d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 1;
    var_7babff54f87e36c2 = br_publicevent_bountyroyale::function_d5141fc12e321361();
    
    foreach ( team in var_7babff54f87e36c2 )
    {
        level thread br_public::brleaderdialogteam( "bountyroyale_explanation", team, 1, undefined, undefined, "dx_br_brbr_" );
    }
    
    utility::registersharedfunc( #"activity", #"hash_6cef4604e39b1588", &function_af03327c7a85cd73 );
    setomnvar( o"hash_6bbb871ed609d71c", 1 );
    
    if ( self.var_332f929de1894b2b.cancelcontracts )
    {
        function_2c351b3426cd21fe();
    }
    
    wait 2.5;
    br_publicevent_bountyroyale::function_6bf7ffc4bd6979fd();
    activity_instance function_e74b721c0ce273cc();
    activity_instance.var_bbfe55644d1207a5 = undefined;
    eventduration = function_a2743e8b4fa5854a();
    br_activity_util::function_f255dbc3d969ce02( eventduration, 15 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xdd62c8c3, Offset: 0x5f3
// Size: 0xba
function activity_ended()
{
    if ( self.var_332f929de1894b2b.var_e1e24e7d51a42877 )
    {
        foreach ( activebounty in self.var_c6bffb23fde2c467 )
        {
            activity_instance_common::endactivity( activebounty, 0 );
        }
    }
    
    utility::clearsharedfunc( #"activity", #"hash_6cef4604e39b1588" );
    setomnvar( o"hash_6bbb871ed609d71c", 0 );
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xbd9c1472, Offset: 0x6b5
// Size: 0xe1
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( activity_instance.var_ed5d663c78f22b15 ) )
    {
        level thread br_analytics::function_ba7e47ee7f1974ec( self, activity_instance.var_ed5d663c78f22b15 );
    }
    
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    
    foreach ( team in level.teamnamelist )
    {
        br_publicevent_bountyroyale::function_6239e450a9a265b1( team, 0 );
        br_publicevent_bountyroyale::function_ebebc9c703462516( team, 0 );
        br_publicevent_bountyroyale::function_69639a51e4bc2a16( team, 0 );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0x147b03d, Offset: 0x79e
// Size: 0xfd
function function_2c351b3426cd21fe()
{
    foreach ( activityinstance in level.activitymanager.var_cc0e4315eede2fec )
    {
        if ( activity_instance_common::getactivitycategory( activityinstance ) != "Contract" )
        {
            continue;
        }
        
        if ( activity_definition_utils::function_9129cd8075c85c09( activityinstance ).nocancel )
        {
            continue;
        }
        
        activity_instance_common::endactivity( activityinstance, self.var_332f929de1894b2b.var_97b2e0918d0b3777 );
        activityteam = activityinstance.playerparticipants[ 0 ].team;
        level thread br_public::brleaderdialogteam( "bountyroyale_explanation_override", activityteam, 1, undefined, undefined, "dx_br_brbr_" );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x12c9162a, Offset: 0x8a3
// Size: 0xd, Type: bool
function function_af03327c7a85cd73( player )
{
    return false;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0xe7347d96, Offset: 0x8b9
// Size: 0xc2
function onplayerrespawn( params )
{
    player = params.player;
    
    if ( !isdefined( player ) || arraycontains( self.eventdata.participatingteams, player.team ) )
    {
        return;
    }
    
    newtarget = function_3f149e07705befef( player.team, undefined );
    
    if ( isdefined( newtarget ) )
    {
        function_56df1f1349b3ca77( player.team, newtarget );
        self.eventdata.participatingteams = arraycombineunique( self.eventdata.participatingteams, [ player.team ] );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0x34e65fed, Offset: 0x983
// Size: 0x81
function function_a2743e8b4fa5854a()
{
    eventduration = self.var_332f929de1894b2b.duration;
    buffertime = 10;
    minduration = 30;
    
    if ( level.br_circle.circleindex > -1 )
    {
        var_63cd788ad27022c0 = int( floor( br_circle::function_f30ad5eda1a16d44() ) );
        eventduration = min( eventduration, var_63cd788ad27022c0 - buffertime );
    }
    
    eventduration = max( eventduration, minduration );
    return eventduration;
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xac1402d, Offset: 0xa0d
// Size: 0xbd
function function_e74b721c0ce273cc()
{
    self.var_c6bffb23fde2c467 = [];
    availableteams = br_publicevent_bountyroyale::function_d5141fc12e321361();
    
    if ( availableteams.size <= 1 )
    {
        return;
    }
    
    function_729f5f17033279d0( availableteams );
    var_b744bc1e119447fe = function_a13e3f055fc15f6f( availableteams );
    
    foreach ( team, target in var_b744bc1e119447fe )
    {
        function_56df1f1349b3ca77( team, target );
    }
    
    br_publicevent_bountyroyale::function_24fe7227ec5a2165( var_b744bc1e119447fe );
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x485368ed, Offset: 0xad2
// Size: 0x10e
function function_729f5f17033279d0( availableteams )
{
    self.eventdata = spawnstruct();
    self.eventdata.participatingteams = availableteams;
    self.var_ed5d663c78f22b15 = [];
    
    foreach ( team in availableteams )
    {
        teamdata = spawnstruct();
        teamdata.failcount = 0;
        teamdata.successcount = 0;
        teamdata.targetedplayer = undefined;
        teamdata.var_6ff8379e9568d24f = [];
        self.var_ed5d663c78f22b15[ team ] = teamdata;
        br_publicevent_bountyroyale::function_ebebc9c703462516( team, 0 );
        br_publicevent_bountyroyale::function_6239e450a9a265b1( team, 0 );
        br_publicevent_bountyroyale::function_69639a51e4bc2a16( team, 0 );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 2
// Checksum 0x78a2e7aa, Offset: 0xbe8
// Size: 0x77
function function_56df1f1349b3ca77( team, target )
{
    bountyinstance = activity_instance_common::function_9b387cb1af0d5b4b( self.var_332f929de1894b2b.var_dca91bbd8a7f48 );
    bountyinstance namespace_2acee5c054dc328c::function_6a015dc94c111927( team, target.team, &oncontractend, self );
    self.var_c6bffb23fde2c467[ self.var_c6bffb23fde2c467.size ] = bountyinstance;
    br_publicevent_bountyroyale::function_6239e450a9a265b1( team, 1 );
}

// Namespace namespace_191d099ac4db2477
// Params 3
// Checksum 0x71d7889d, Offset: 0xc67
// Size: 0x2bc
function oncontractend( contract, success, endstate )
{
    public_event = self;
    level endon( #"game_ended" );
    contract br_publicevent_bountyroyale::function_f0148d15eece9a89( endstate );
    wait 2;
    public_event.var_c6bffb23fde2c467 = arrayremove( public_event.var_c6bffb23fde2c467, contract );
    br_publicevent_bountyroyale::function_69639a51e4bc2a16( contract.targetteam, 0 );
    br_publicevent_bountyroyale::function_69639a51e4bc2a16( contract.team, 0 );
    
    if ( !br_activity_util::function_28ad214e28d6ee27( "BR_PUBLIC_EVENT_BOUNTY_ROYALE" ) )
    {
        return;
    }
    
    var_898a627b92c23dc5 = public_event.var_ed5d663c78f22b15[ contract.team ];
    var_57ee2d1096b1e3de = public_event.var_ed5d663c78f22b15[ contract.targetteam ];
    var_57ee2d1096b1e3de.var_6ff8379e9568d24f = arrayremove( var_57ee2d1096b1e3de.var_6ff8379e9568d24f, contract.team );
    
    if ( var_57ee2d1096b1e3de.var_6ff8379e9568d24f.size == 0 )
    {
        var_57ee2d1096b1e3de.targetedplayer = undefined;
    }
    
    var_4f8445da3c85dd73 = endstate == "Win";
    ispoached = endstate == "Vanished";
    
    if ( var_4f8445da3c85dd73 )
    {
        var_898a627b92c23dc5.successcount++;
        br_publicevent_bountyroyale::function_ebebc9c703462516( contract.team, var_898a627b92c23dc5.successcount );
        level thread br_public::brleaderdialogteam( "bountyroyale_success", contract.team, 1, undefined, undefined, "dx_br_brbr_" );
    }
    else if ( ispoached )
    {
        level thread br_public::brleaderdialogteam( "bountyroyale_poached", contract.team, 1, undefined, undefined, "dx_br_brbr_" );
    }
    
    if ( var_4f8445da3c85dd73 || ispoached )
    {
        var_57ee2d1096b1e3de.failcount++;
    }
    
    if ( self.var_332f929de1894b2b.var_2e9ed57c16a1c5bb || var_4f8445da3c85dd73 || ispoached )
    {
        if ( br_publicevent_bountyroyale::function_67888fe593cd2fb8( contract.team ) )
        {
            return;
        }
        
        if ( function_258c990454bff383() )
        {
            return;
        }
        
        lasttarget = contract.targetteam;
        newtarget = function_3f149e07705befef( contract.team, lasttarget );
        
        if ( isdefined( newtarget ) )
        {
            function_56df1f1349b3ca77( contract.team, newtarget );
            return;
        }
        
        br_publicevent_bountyroyale::function_6239e450a9a265b1( contract.hunterteam, 0 );
        var_9eb2b1914b7f4a07 = self.eventdata.participatingteams.size;
        assert( var_9eb2b1914b7f4a07 <= 1, "<dev string:x24>" + var_9eb2b1914b7f4a07 + "<dev string:x5a>" + contract.hunterteam + "<dev string:x6a>" );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xaf15bce3, Offset: 0xf2b
// Size: 0xb, Type: bool
function function_258c990454bff383()
{
    return function_54888467536d085f() < 5;
}

// Namespace namespace_191d099ac4db2477
// Params 0
// Checksum 0xcc9ba507, Offset: 0xf3f
// Size: 0x36
function function_54888467536d085f()
{
    var_68d5c64e3eb8bc82 = self.eventendtime - gettime();
    remainingseconds = int( floor( var_68d5c64e3eb8bc82 / 1000 ) );
    return remainingseconds;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x21804838, Offset: 0xf7e
// Size: 0xe9
function function_1c482a1287b16a53( availableteams )
{
    var_b744bc1e119447fe = [];
    randomizedteams = arrayrandomize( availableteams );
    
    foreach ( index, hunterteam in randomizedteams )
    {
        targetindex = index + 1;
        
        if ( targetindex >= randomizedteams.size )
        {
            targetindex = 0;
        }
        
        targetteam = randomizedteams[ targetindex ];
        var_fc943dae65c4d7c2 = teams::getteamdata( targetteam, "alivePlayers" );
        targetplayer = utility::array_random( var_fc943dae65c4d7c2 );
        var_b744bc1e119447fe[ hunterteam ] = targetplayer;
    }
    
    return var_b744bc1e119447fe;
}

// Namespace namespace_191d099ac4db2477
// Params 2
// Checksum 0x2eef5800, Offset: 0x1070
// Size: 0x72
function function_3f149e07705befef( hunterteam, lasttarget )
{
    switch ( self.var_332f929de1894b2b.var_708abc1795dbaf45 )
    {
        case 0:
            return function_67df3a14383c518e( hunterteam, lasttarget );
        case 1:
            return function_1581549226a41de3( hunterteam, undefined );
        case 2:
            return function_1581549226a41de3( hunterteam, lasttarget );
    }
}

// Namespace namespace_191d099ac4db2477
// Params 2
// Checksum 0x90a4a9b1, Offset: 0x10ea
// Size: 0x301
function function_67df3a14383c518e( hunterteam, lasttarget )
{
    var_402384e392946204 = function_1cc65394637560e6( hunterteam );
    possibleteams = [];
    toremove = [];
    distancestep = self.var_332f929de1894b2b.var_34e492a810a098ef;
    var_af8a429facd717a4 = distancestep * distancestep;
    
    foreach ( team in self.eventdata.participatingteams )
    {
        if ( team == hunterteam )
        {
            continue;
        }
        
        if ( team == lasttarget && self.eventdata.participatingteams.size > 2 )
        {
            continue;
        }
        
        if ( br_publicevent_bountyroyale::function_67888fe593cd2fb8( team ) )
        {
            toremove[ toremove.size ] = team;
            continue;
        }
        
        teamdata = self.var_ed5d663c78f22b15[ team ];
        
        if ( teamdata.var_6ff8379e9568d24f.size >= self.var_332f929de1894b2b.maxhunters )
        {
            continue;
        }
        
        squaddata = spawnstruct();
        squaddata.team = team;
        squaddata.center = function_1cc65394637560e6( team );
        squaddata.distsquared = distancesquared( var_402384e392946204, squaddata.center );
        distancepenalty = int( floor( squaddata.distsquared / var_af8a429facd717a4 ) );
        squaddata.score = teamdata.successcount - teamdata.failcount;
        squaddata.score -= distancepenalty;
        possibleteams[ possibleteams.size ] = squaddata;
    }
    
    self.eventdata.participatingteams = arrayremove( self.eventdata.participatingteams, toremove );
    bestteam = undefined;
    
    foreach ( squadteam in possibleteams )
    {
        if ( !isdefined( bestteam ) || bestteam.score < squadteam.score )
        {
            bestteam = squadteam;
        }
    }
    
    targetteam = bestteam.team;
    target = br_publicevent_bountyroyale::determinetargetplayer( targetteam );
    return target;
}

// Namespace namespace_191d099ac4db2477
// Params 2
// Checksum 0x3be0c808, Offset: 0x13f4
// Size: 0x21d
function function_1581549226a41de3( hunterteam, lasttarget )
{
    var_402384e392946204 = function_1cc65394637560e6( hunterteam );
    toremove = [];
    closestplayer = undefined;
    var_350b991bbbed45c7 = 2147483647;
    
    foreach ( team in self.eventdata.participatingteams )
    {
        if ( team == hunterteam )
        {
            continue;
        }
        
        if ( team == lasttarget && self.eventdata.participatingteams.size > 2 )
        {
            continue;
        }
        
        if ( br_publicevent_bountyroyale::function_67888fe593cd2fb8( team ) )
        {
            toremove[ toremove.size ] = team;
            continue;
        }
        
        var_57ee2d1096b1e3de = self.var_ed5d663c78f22b15[ team ];
        players = [];
        
        if ( isdefined( var_57ee2d1096b1e3de.targetedplayer ) )
        {
            players[ players.size ] = var_57ee2d1096b1e3de.targetedplayer;
        }
        else
        {
            players = teams::getteamdata( team, "alivePlayers" );
        }
        
        foreach ( player in players )
        {
            distsquared = distancesquared( var_402384e392946204, player.origin );
            
            if ( distsquared < var_350b991bbbed45c7 )
            {
                var_350b991bbbed45c7 = distsquared;
                closestplayer = player;
            }
        }
    }
    
    self.eventdata.participatingteams = arrayremove( self.eventdata.participatingteams, toremove );
    return closestplayer;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x315e222a, Offset: 0x161a
// Size: 0xb8
function function_a13e3f055fc15f6f( availableteams )
{
    playerclusters = function_30950d7c95ca3d71( availableteams );
    var_b744bc1e119447fe = [];
    
    foreach ( cluster in playerclusters )
    {
        bounties = function_1c482a1287b16a53( cluster.teams );
        var_b744bc1e119447fe = function_c6c06162c8e6ae75( var_b744bc1e119447fe, bounties );
    }
    
    return var_b744bc1e119447fe;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0xd14e8326, Offset: 0x16db
// Size: 0x539
function function_30950d7c95ca3d71( availableteams )
{
    clusters = [];
    clustersgrid = [];
    var_5ed4dcc36c53c99d = [];
    squadcenters = [];
    var_a257cd69bf9eefff = 0;
    clusterradius = activity_definition_utils::function_9129cd8075c85c09( self ).clusterradius;
    clusterlength = 2 * activity_definition_utils::function_9129cd8075c85c09( self ).clusterradius;
    var_97aadf24d0d174ea = activity_definition_utils::function_9129cd8075c85c09( self ).var_97aadf24d0d174ea;
    
    foreach ( team in availableteams )
    {
        squadcentroid = function_1cc65394637560e6( team );
        squadcenters[ team ] = squadcentroid;
        var_9d77e543b3143cab = int( floor( squadcentroid[ 0 ] / clusterlength ) );
        var_e8991b7655b2946e = int( floor( squadcentroid[ 1 ] / clusterlength ) );
        
        if ( !isdefined( clustersgrid[ var_9d77e543b3143cab ] ) )
        {
            clustersgrid[ var_9d77e543b3143cab ] = [];
        }
        
        if ( !isdefined( clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ] ) )
        {
            cluster = spawnstruct();
            cluster.teams = [ team ];
            cluster.centroid = squadcentroid;
            clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ] = cluster;
            clusters[ clusters.size ] = cluster;
            continue;
        }
        
        cluster = clustersgrid[ var_9d77e543b3143cab ][ var_e8991b7655b2946e ];
        cluster.teams[ cluster.teams.size ] = team;
        cluster.centroid += ( squadcentroid - cluster.centroid ) / cluster.teams.size;
        var_5ed4dcc36c53c99d[ var_5ed4dcc36c53c99d.size ] = cluster;
    }
    
    var_116ce816a835f516 = arrayremove( clusters, var_5ed4dcc36c53c99d );
    var_42c0da0bfc79e2b1 = var_116ce816a835f516.size;
    
    /#
        thread drawclusters( var_116ce816a835f516, squadcenters, 1 );
    #/
    
    result = function_55a0c540d7b39dd4( clusters, var_116ce816a835f516, squadcenters, clusterradius );
    
    if ( result.var_116ce816a835f516.size > 0 && var_97aadf24d0d174ea > 0 )
    {
        maxradius = clusterradius * var_97aadf24d0d174ea;
        result = function_55a0c540d7b39dd4( result.clusters, result.var_116ce816a835f516, squadcenters, maxradius );
    }
    
    if ( result.var_116ce816a835f516.size == 1 )
    {
        result = function_55a0c540d7b39dd4( result.clusters, result.var_116ce816a835f516, squadcenters, clusterradius );
    }
    
    clusters = result.clusters;
    var_116ce816a835f516 = result.var_116ce816a835f516;
    
    if ( var_116ce816a835f516.size > 0 )
    {
        cluster = spawnstruct();
        cluster.teams = [];
        cluster.centroid = ( 0, 0, 0 );
        var_a257cd69bf9eefff = 1;
        
        foreach ( var_28d19792004c7ce1 in var_116ce816a835f516 )
        {
            cluster.teams[ cluster.teams.size ] = var_28d19792004c7ce1.teams[ 0 ];
            cluster.centroid += ( var_28d19792004c7ce1.centroid - cluster.centroid ) / cluster.teams.size;
            clusters = arrayremove( clusters, var_28d19792004c7ce1 );
        }
        
        clusters[ clusters.size ] = cluster;
    }
    
    /#
        var_d2b183323b1c64fe = [];
        teamcount = 0;
        
        foreach ( cluster in clusters )
        {
            assert( cluster.teams.size > 1, "<dev string:x6c>" );
            
            foreach ( team in cluster.teams )
            {
                teamcount++;
                
                if ( !isdefined( var_d2b183323b1c64fe[ team ] ) )
                {
                    var_d2b183323b1c64fe[ team ] = 1;
                    continue;
                }
                
                assertmsg( "<dev string:x9c>" + team + "<dev string:xa2>" );
            }
        }
        
        assert( teamcount == availableteams.size, "<dev string:xc8>" );
        thread drawclusters( clusters, squadcenters );
    #/
    
    function_8f4cdeb5dcf501d1( clusters, var_42c0da0bfc79e2b1, var_a257cd69bf9eefff );
    return clusters;
}

// Namespace namespace_191d099ac4db2477
// Params 4
// Checksum 0xa27873e6, Offset: 0x1c1d
// Size: 0x1ef
function function_55a0c540d7b39dd4( clusters, var_116ce816a835f516, squadcenters, maxdistance )
{
    toremove = [];
    var_1ab3474a7c6d13eb = maxdistance * maxdistance;
    
    foreach ( var_28d19792004c7ce1 in var_116ce816a835f516 )
    {
        if ( !function_b249dc8d64ad59fd( var_28d19792004c7ce1 ) )
        {
            continue;
        }
        
        nearcluster = function_c4b9c163757a1b16( var_28d19792004c7ce1, clusters );
        var_3b6f9f2795ad440 = var_28d19792004c7ce1.teams[ 0 ];
        var_1fda01e66a20ba90 = 0;
        var_c0605ab1f710e556 = var_116ce816a835f516.size - toremove.size;
        
        if ( var_c0605ab1f710e556 == 1 )
        {
            var_1fda01e66a20ba90 = 1;
        }
        else
        {
            var_a90a9ca8d29d1331 = squadcenters[ var_3b6f9f2795ad440 ];
            var_b70547d613d62a8b = nearcluster.centroid;
            var_1fda01e66a20ba90 = distance2dsquared( var_b70547d613d62a8b, var_a90a9ca8d29d1331 ) < var_1ab3474a7c6d13eb;
        }
        
        if ( var_1fda01e66a20ba90 )
        {
            nearcluster.centroid += ( var_28d19792004c7ce1.centroid - nearcluster.centroid ) / nearcluster.teams.size;
            
            if ( function_b249dc8d64ad59fd( nearcluster ) )
            {
                toremove[ toremove.size ] = nearcluster;
            }
            
            nearcluster.teams[ nearcluster.teams.size ] = var_3b6f9f2795ad440;
            toremove[ toremove.size ] = var_28d19792004c7ce1;
            clusters = arrayremove( clusters, var_28d19792004c7ce1 );
        }
    }
    
    var_116ce816a835f516 = arrayremove( var_116ce816a835f516, toremove );
    result = spawnstruct();
    result.clusters = clusters;
    result.var_116ce816a835f516 = var_116ce816a835f516;
    return result;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x994ae03a, Offset: 0x1e15
// Size: 0x1b, Type: bool
function function_b249dc8d64ad59fd( cluster )
{
    return cluster.teams.size == 1;
}

// Namespace namespace_191d099ac4db2477
// Params 2
// Checksum 0x217b3750, Offset: 0x1e39
// Size: 0xdb
function function_c4b9c163757a1b16( cluster, clusters )
{
    closestcluster = undefined;
    var_d809a0d4ba10a1f6 = undefined;
    
    foreach ( candidatecluster in clusters )
    {
        if ( candidatecluster == cluster )
        {
            continue;
        }
        
        dist = distance2dsquared( cluster.centroid, candidatecluster.centroid );
        
        if ( !isdefined( var_d809a0d4ba10a1f6 ) || dist < var_d809a0d4ba10a1f6 )
        {
            var_d809a0d4ba10a1f6 = dist;
            closestcluster = candidatecluster;
        }
    }
    
    return closestcluster;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x17f2d7e8, Offset: 0x1f1d
// Size: 0xdc
function function_1cc65394637560e6( team )
{
    var_d4d9c3e347bb10ca = ( 0, 0, 0 );
    teamsize = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            var_d4d9c3e347bb10ca += player.origin;
            teamsize++;
        }
    }
    
    if ( teamsize > 0 )
    {
        var_d4d9c3e347bb10ca /= teamsize;
    }
    
    return var_d4d9c3e347bb10ca;
}

// Namespace namespace_191d099ac4db2477
// Params 3
// Checksum 0xf47e8f8e, Offset: 0x2002
// Size: 0x51
function function_8f4cdeb5dcf501d1( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 )
{
    if ( getdvarint( @"hash_e36b1d2f6f9475cd", 0 ) == 0 )
    {
        return;
    }
    
    stats = function_55238f73137ad387( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 );
    function_988dc73bb8f948ea( stats );
}

// Namespace namespace_191d099ac4db2477
// Params 3
// Checksum 0x644eda6e, Offset: 0x205b
// Size: 0x1d5
function function_55238f73137ad387( clusters, var_42c0da0bfc79e2b1, var_7abadce195fc4305 )
{
    stats = spawnstruct();
    stats.clusterscount = clusters.size;
    stats.var_c977fb4fd957cbe9 = 0;
    
    if ( var_7abadce195fc4305 )
    {
        lastcluster = clusters[ clusters.size - 1 ];
        stats.var_c977fb4fd957cbe9 = lastcluster.teams.size;
    }
    
    stats.var_4dc2769dfe116232 = var_42c0da0bfc79e2b1 - stats.var_c977fb4fd957cbe9;
    var_d8ee20a6bce613f9 = [];
    
    foreach ( cluster in clusters )
    {
        var_d8ee20a6bce613f9[ var_d8ee20a6bce613f9.size ] = cluster.teams.size;
    }
    
    stats.var_9828b4fd72cadf5e = arraysort( var_d8ee20a6bce613f9 );
    stats.averagesize = utility::array_average( stats.var_9828b4fd72cadf5e );
    var_cd3cf2cf3b927430 = int( floor( stats.var_9828b4fd72cadf5e.size / 2 ) );
    
    if ( stats.var_9828b4fd72cadf5e.size % 2 != 0 )
    {
        stats.var_f14c41a9e27f048d = stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 ];
    }
    else
    {
        var_4f7cc90ae3a68c0 = stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 ] + stats.var_9828b4fd72cadf5e[ var_cd3cf2cf3b927430 - 1 ];
        stats.var_f14c41a9e27f048d = var_4f7cc90ae3a68c0 / 2;
    }
    
    return stats;
}

// Namespace namespace_191d099ac4db2477
// Params 1
// Checksum 0x6233e00d, Offset: 0x2239
// Size: 0x164
function function_988dc73bb8f948ea( stats )
{
    logstring( "-----------------------------------------------------" );
    logstring( "Public Event Bounty Royale - Clustering Statistics :" );
    logstring( "-----------------------------------------------------" );
    logstring( "Isolated Squads Remaining: " + stats.var_c977fb4fd957cbe9 );
    logstring( "Isolated Squads Merged with nearby Clusters: " + stats.var_4dc2769dfe116232 );
    logstring( "---------------------" );
    arraystr = "[ ";
    index = 0;
    
    foreach ( size in stats.var_9828b4fd72cadf5e )
    {
        arraystr += size;
        
        if ( index == stats.var_9828b4fd72cadf5e.size - 1 )
        {
            arraystr += " ]";
        }
        else
        {
            arraystr += ", ";
        }
        
        index++;
    }
    
    logstring( "Cluster sizes: " + arraystr );
    logstring( "Median  Cluster Size: " + stats.var_f14c41a9e27f048d );
    logstring( "Average Cluster Size: " + stats.averagesize );
    logstring( "-----------------------------------------------------" );
}

/#

    // Namespace namespace_191d099ac4db2477
    // Params 1
    // Checksum 0x99692ed2, Offset: 0x23a5
    // Size: 0xc0, Type: dev
    function function_c82275f556df96a9( position )
    {
        if ( getdvarint( @"hash_abd886dfdd042260", 0 ) == 0 )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level endon( #"bounty_redraw" );
        radius = self.clusterradius;
        height = ( 0, 0, 2 );
        yellow = ( 1, 1, 0 );
        red = ( 1, 0, 0 );
        
        while ( true )
        {
            waitframe();
            cylinder( position - height, position + height, radius, yellow, 1, 1 );
            sphere( position, 50, red, 0, 1 );
        }
    }

    // Namespace namespace_191d099ac4db2477
    // Params 3
    // Checksum 0x189af51a, Offset: 0x246d
    // Size: 0x236, Type: dev
    function drawclusters( clusters, squadcenters, var_7d5faccbec298845 )
    {
        if ( getdvarint( @"hash_abd886dfdd042260", 0 ) == 0 )
        {
            return;
        }
        
        if ( var_7d5faccbec298845 )
        {
            level notify( #"bounty_redraw" );
        }
        
        level endon( #"game_ended" );
        level endon( #"bounty_redraw" );
        radius = activity_definition_utils::function_9129cd8075c85c09( self ).clusterradius;
        height = ( 0, 0, 1 );
        orange = ( 1, 0.7, 0 );
        red = ( 1, 0, 0 );
        cyan = ( 0, 1, 1 );
        
        while ( true )
        {
            foreach ( cluster in clusters )
            {
                position = cluster.centroid;
                
                if ( cluster.teams.size == 1 )
                {
                    sphere( position, 100, cyan, 0, 1 );
                    continue;
                }
                else
                {
                    sphere( position, 100, orange, 0, 1 );
                    cylinder( position, position + height, radius, orange, 0, 1 );
                }
                
                foreach ( team in cluster.teams )
                {
                    var_a90a9ca8d29d1331 = squadcenters[ team ];
                    sphere( var_a90a9ca8d29d1331, 50, red, 0, 1 );
                    line( position, var_a90a9ca8d29d1331, red );
                }
            }
            
            waitframe();
        }
    }

#/
