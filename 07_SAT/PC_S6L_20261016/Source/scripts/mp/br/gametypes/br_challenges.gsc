// scripts\mp\br\gametypes\br_challenges.gsc  (hash_2ddcac9beaec1ac6.gscc) (size: 7893 Bytes / 0x1ed5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6dd4e467 (1842668647)
// size ...... 7893 (0x1ed5)
// includes .. 9   (offset: 0x1ce9)
// strings ... 25  (offset: 0x1d31)
// dev strs .. 7   (offset: 0x1e71)
// exports ... 19  (offset: 0x1339)
// cseg ...... 0x2eb + 0x104e (0x1339)
// imports ... 56  (offset: 0x1631)
// animtree1 . 0   (offset: 0x1ed5)
// animtree2 . 0   (offset: 0x1ed5)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\player;

#namespace br_challenges;

// Namespace br_challenges
// Params 0
// Checksum 0xb91f774d, Offset: 0x309
// Size: 0xa1
function init()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( !challenges::challengesenabled() )
    {
        return;
    }
    
    level.var_283a0816be2c2063 = {};
    level.var_c6c529ad6eb57922 = [];
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &function_9bbe799f77e34961 );
    registerchallenge( "br_mastery_fiveContracts", &fivecontracts );
    registerchallenge( "br_mastery_pointBlank_airstrike", &pointblank_airstrike );
    registerchallenge( "br_mastery_pointBlank_tomahawk", &pointblank_tomahawk );
    registerchallenge( "br_mastery_c4VehicleMultKill", &c4vehiclemultkill );
    registerchallenge( "br_mastery_ghostRideWhip", &ghostridewhip );
    registerchallenge( "br_mastery_roundKillExecute", &roundkillexecute );
}

// Namespace br_challenges
// Params 2
// Checksum 0x141f65fd, Offset: 0x3b2
// Size: 0x5d
function registerchallenge( challengeref, challengefunc )
{
    if ( !isdefined( level.br_challenges ) )
    {
        level.br_challenges = [];
    }
    
    assert( !isdefined( level.br_challenges[ challengeref ] ), "<dev string:x24>" + challengeref + "<dev string:x33>" );
    level.br_challenges[ challengeref ] = challengefunc;
}

// Namespace br_challenges
// Params 2
// Checksum 0xc15ba20d, Offset: 0x417
// Size: 0x56
function challengeevaluator( challengeref, paramstruct )
{
    assert( isdefined( challengeref ) );
    
    if ( !isdefined( level.br_challenges ) )
    {
        return;
    }
    
    challengefunc = level.br_challenges[ challengeref ];
    
    if ( isdefined( challengefunc ) )
    {
        self thread [[ challengefunc ]]( challengeref, paramstruct );
    }
}

// Namespace br_challenges
// Params 1
// Checksum 0x38be2ed5, Offset: 0x475
// Size: 0x3a
function awardmasterychallenge( challengeref )
{
    if ( getdvarint( @"hash_ad789c41a11e3f59", 0 ) )
    {
        iprintlnbold( "Mastery Challenge: " + challengeref + " completed!" );
    }
    
    challenges::function_37e945722d6497f3( self, challengeref );
}

// Namespace br_challenges
// Params 1, eflags: 0x4
// Checksum 0xdfae98cb, Offset: 0x4b7
// Size: 0xbe
function private function_9bbe799f77e34961( params )
{
    activityinstance = self;
    
    if ( !activityinstance )
    {
        return;
    }
    
    activitycategory = activityinstance.category;
    
    if ( !isdefined( activitycategory ) )
    {
        return;
    }
    
    players = params.playerlist;
    
    if ( !players || players.size == 0 )
    {
        return;
    }
    
    switch ( activitycategory )
    {
        case #"hash_27add1a9d9ceb679":
            reportmissioncomplete( players, activityinstance );
            return;
        case #"hash_1bb9449b7ff55668":
        case #"hash_29d330d0a06d5678":
        case #"hash_91e7eea22d75682b":
            function_75a7b7237dc12b8a( activityinstance );
            return;
        default:
            return;
    }
}

// Namespace br_challenges
// Params 1
// Checksum 0x8f55521e, Offset: 0x57d
// Size: 0x156
function function_75a7b7237dc12b8a( activityinstance )
{
    var_86737cbe11bf496e = activity_instance_common::function_9b599023b3237e1a( activityinstance );
    
    if ( utility::issharedfuncdefined( #"challenges", #"hash_8c96973f38ba6767" ) )
    {
        activityindex = utility::callsharedfunc( #"challenges", #"hash_8c96973f38ba6767", activityinstance );
    }
    else
    {
        activityindex = challenges::function_b023f79a238af6c2( activityinstance.type );
    }
    
    if ( activityinstance.missionstarttime )
    {
        var_725b4aa1a1c7d5f9 = int( ( gettime() - activityinstance.missionstarttime ) * 0.001 );
    }
    
    assert( isdefined( activityindex ), "<dev string:x46>" + activityinstance.type + "<dev string:x73>" );
    
    if ( !isdefined( activityindex ) )
    {
        return;
    }
    
    activitytype = challenges::function_a23641f33e985edb( 0, activityindex );
    
    foreach ( player in var_86737cbe11bf496e )
    {
        challenges::function_918534454a508804( player, activitytype, var_725b4aa1a1c7d5f9 );
    }
}

// Namespace br_challenges
// Params 2, eflags: 0x4
// Checksum 0x84dacab8, Offset: 0x6db
// Size: 0x11a
function private reportmissioncomplete( players, activityinstance )
{
    aeeventname = #"wz_mission_complete";
    eventdata = function_ace61864e40cc0ec();
    eventdata.eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9a5470bfcec63e3" ) ] = function_1b3d249a8c06e991( activityinstance.type );
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        /#
            challenges::function_ee4471f0d17f1d51( eventdata.aeeventid, eventdata.eventparams );
        #/
        
        player function_2e45314624fdfdb8( eventdata.aeeventid, eventdata.eventparams );
    }
}

// Namespace br_challenges
// Params 1, eflags: 0x4
// Checksum 0xf1b3931a, Offset: 0x7fd
// Size: 0x55
function private function_1b3d249a8c06e991( missiontype )
{
    var_853789b60b7ea319 = 0;
    var_d03ff6f30249c85c = function_23770661dbfe62d9();
    
    if ( !isdefined( var_d03ff6f30249c85c[ missiontype ] ) )
    {
        println( "<dev string:x90>" + missiontype );
        return var_853789b60b7ea319;
    }
    
    var_853789b60b7ea319 = challenges::function_a23641f33e985edb( var_853789b60b7ea319, var_d03ff6f30249c85c[ missiontype ] );
    return var_853789b60b7ea319;
}

// Namespace br_challenges
// Params 0, eflags: 0x4
// Checksum 0xc815ee5b, Offset: 0x85b
// Size: 0x19c
function private function_23770661dbfe62d9()
{
    if ( level.var_283a0816be2c2063.var_85f85b6121529b91 && level.var_283a0816be2c2063.var_85f85b6121529b91.size != 0 )
    {
        return level.var_283a0816be2c2063.var_85f85b6121529b91;
    }
    
    var_85f85b6121529b91 = [];
    var_85f85b6121529b91[ "REV_BONGO_MASON_ONE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"mason_1" );
    var_85f85b6121529b91[ "REV_BONGO_MASON_TWO" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"mason_2" );
    var_85f85b6121529b91[ "REV_BONGO_MASON_THREE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"mason_3" );
    var_85f85b6121529b91[ "REV_BONGO_KAGAN_ONE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"kagan_1" );
    var_85f85b6121529b91[ "BONGO_OPERATOR_MISSION_5" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"kagan_2" );
    var_85f85b6121529b91[ "REV_BONGO_KAGAN_THREE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"kagan_3" );
    var_85f85b6121529b91[ "REV_BONGO_DEMPSEY_ONE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"dempsey_1" );
    var_85f85b6121529b91[ "REV_BONGO_DEMPSEY_TWO" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"dempsey_2" );
    var_85f85b6121529b91[ "REV_BONGO_DEMPSEY_THREE" ] = ae_utility::function_2d1565a236387b2( #"hash_9a5470bfcec63e3", #"dempsey_3" );
    level.var_283a0816be2c2063.var_85f85b6121529b91 = var_85f85b6121529b91;
    return level.var_283a0816be2c2063.var_85f85b6121529b91;
}

// Namespace br_challenges
// Params 0, eflags: 0x4
// Checksum 0xc1c74830, Offset: 0xa00
// Size: 0x177
function private function_ace61864e40cc0ec()
{
    aeeventname = #"wz_mission_complete";
    
    if ( level.var_c6c529ad6eb57922[ aeeventname ] && level.var_c6c529ad6eb57922[ aeeventname ].eventparams.size != 0 )
    {
        return level.var_c6c529ad6eb57922[ aeeventname ];
    }
    
    level.var_c6c529ad6eb57922[ aeeventname ] = {};
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    level.var_c6c529ad6eb57922[ aeeventname ].aeeventid = aeeventid;
    gamemode = challenges::getchallengegamemode();
    gametype = challenges::function_9edd00e9e48c0821();
    level.var_c6c529ad6eb57922[ aeeventname ].eventparams = [];
    level.var_c6c529ad6eb57922[ aeeventname ].eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" ) ] = 1;
    level.var_c6c529ad6eb57922[ aeeventname ].eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gamemode" ) ] = gamemode;
    level.var_c6c529ad6eb57922[ aeeventname ].eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"gametype" ) ] = gametype;
    level.var_c6c529ad6eb57922[ aeeventname ].eventparams[ ae_utility::function_70b8bc68f3d8031e( aeeventname, #"hash_9a5470bfcec63e3" ) ] = 0;
    return level.var_c6c529ad6eb57922[ aeeventname ];
}

// Namespace br_challenges
// Params 2
// Checksum 0x4b1a0267, Offset: 0xb80
// Size: 0x10e
function fivecontracts( challengeref, paramstruct )
{
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    if ( utility::get_int_or_0( self.brmissionscompleted ) < 5 )
    {
        return;
    }
    
    var_8fa435c114d34294 = isdefined( level.gulag ) && !level.gulag.shutdown;
    
    foreach ( player in level.teamdata[ self.team ][ "players" ] )
    {
        if ( !player::isreallyalive( player ) )
        {
            return;
        }
        
        if ( var_8fa435c114d34294 && player br_public::isplayerinorgoingtogulag() )
        {
            return;
        }
    }
    
    awardmasterychallenge( challengeref );
}

// Namespace br_challenges
// Params 2
// Checksum 0x84d0a323, Offset: 0xc96
// Size: 0x13b
function pointblank_airstrike( challengeref, paramstruct )
{
    plane = paramstruct.plane;
    targetsite = paramstruct.targetsite;
    
    if ( !( isdefined( plane ) && isdefined( plane.airstrikeid ) && isdefined( plane.streakinfo ) && isdefined( targetsite ) ) )
    {
        return;
    }
    
    streakinfo = plane.streakinfo;
    
    if ( distancesquared( self.origin, targetsite ) > squared( 432 ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_ccf18229b13419ef" );
    self endon( #"hash_ccf18229b13419ef" );
    level utility::waittill_any_timeout( 10, "airstrike_finished_" + plane.airstrikeid );
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_ad789c41a11e3f59", 0 ) )
        {
            iprintlnbold( "<dev string:xa7>" + challengeref + "<dev string:xbb>" + streakinfo.kills );
        }
    #/
    
    if ( streakinfo.kills >= 3 )
    {
        awardmasterychallenge( "br_mastery_pointBlankStreakKill" );
    }
}

// Namespace br_challenges
// Params 2
// Checksum 0xfc850ab3, Offset: 0xdd9
// Size: 0xfa
function pointblank_tomahawk( challengeref, paramstruct )
{
    instreak = paramstruct.streakinfo;
    targetsite = paramstruct.targetsite;
    
    if ( !isdefined( instreak ) )
    {
        return;
    }
    
    if ( !isdefined( targetsite ) )
    {
        return;
    }
    
    if ( distancesquared( self.origin, targetsite ) > squared( 432 ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_62733e82fe9ec1df" );
    self endon( #"hash_62733e82fe9ec1df" );
    utility::waittill_any_timeout( 20, "cluster_strike_finished" );
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_ad789c41a11e3f59", 0 ) )
        {
            iprintlnbold( "<dev string:xa7>" + challengeref + "<dev string:xbb>" + instreak.kills );
        }
    #/
    
    if ( instreak.kills >= 3 )
    {
        awardmasterychallenge( "br_mastery_pointBlankStreakKill" );
    }
}

// Namespace br_challenges
// Params 2
// Checksum 0xebb8545e, Offset: 0xedc
// Size: 0x17e
function c4vehiclemultkill( challengeref, paramstruct )
{
    meansofdeath = paramstruct.meansofdeath;
    inflictor = paramstruct.inflictor;
    
    if ( !isdefined( meansofdeath ) || meansofdeath != "MOD_EXPLOSIVE" )
    {
        return;
    }
    
    if ( !isvalidinflictorc4vehicle( inflictor ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_685634b2e91b672b" );
    self endon( #"hash_685634b2e91b672b" );
    
    if ( !isdefined( self.recentc4vehiclekillcount ) )
    {
        self.recentc4vehiclekillcount = 0;
    }
    
    self.recentc4vehiclekillcount++;
    wait 4;
    
    /#
        if ( getdvarint( @"hash_ad789c41a11e3f59", 0 ) && isdefined( self.recentc4vehiclekillcount ) )
        {
            iprintlnbold( "<dev string:xa7>" + challengeref + "<dev string:xbb>" + self.recentc4vehiclekillcount );
        }
    #/
    
    if ( self.recentc4vehiclekillcount >= 3 )
    {
        awardmasterychallenge( challengeref );
        cooperator = c4vehiclecooperator( inflictor );
        issameteam = isdefined( cooperator ) && isdefined( cooperator.team ) && isdefined( self.team ) && cooperator.team == self.team;
        
        if ( issameteam )
        {
            cooperator awardmasterychallenge( challengeref );
        }
    }
    
    self.recentc4vehiclekillcount = undefined;
}

// Namespace br_challenges
// Params 1
// Checksum 0xf7dd2a95, Offset: 0x1062
// Size: 0x132, Type: bool
function isvalidinflictorc4vehicle( inflictor )
{
    if ( !isdefined( inflictor ) )
    {
        return false;
    }
    
    if ( isdefined( inflictor vehicle::get_ref() ) && inflictor.classname == "script_vehicle" && !inflictor vehicle_code::vehicle_is_stopped() )
    {
        children = inflictor getlinkedchildren();
        
        foreach ( child in children )
        {
            if ( child.weapon_name == "c4_mp" )
            {
                return true;
            }
        }
    }
    else if ( inflictor.weapon_name == "c4_mp" )
    {
        parent = inflictor getlinkedparent();
        
        if ( isdefined( parent ) && isdefined( parent vehicle::get_ref() ) && inflictor.classname == "script_vehicle" && !parent vehicle_code::vehicle_is_stopped() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_challenges
// Params 1
// Checksum 0x963b0e5f, Offset: 0x119d
// Size: 0x5a
function c4vehiclecooperator( inflictor )
{
    if ( isdefined( inflictor ) && isdefined( inflictor.weapon_name ) && inflictor.weapon_name == "c4_mp" )
    {
        parent = inflictor getlinkedparent();
        
        if ( isdefined( parent ) )
        {
            return parent.owner;
        }
    }
}

// Namespace br_challenges
// Params 2
// Checksum 0xd541997c, Offset: 0x1200
// Size: 0x21
function roundkillexecute( challengeref, paramstruct )
{
    awardmasterychallenge( "br_mastery_roundKillExecute" );
}

// Namespace br_challenges
// Params 2
// Checksum 0xaca09139, Offset: 0x1229
// Size: 0x110
function ghostridewhip( challengeref, paramstruct )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    exitdriver = paramstruct.exitdriver;
    maderecentkill = paramstruct.maderecentkill;
    
    if ( exitdriver )
    {
        if ( self.hasexiteddriver && self.recentghostridekillcount != 0 )
        {
            return;
        }
        
        self.hasexiteddriver = 1;
    }
    
    if ( !self.hasexiteddriver )
    {
        return;
    }
    
    self notify( #"hash_307411c565aa3eb4" );
    self endon( #"hash_307411c565aa3eb4" );
    
    if ( !isdefined( self.recentghostridekillcount ) )
    {
        self.recentghostridekillcount = 0;
    }
    
    if ( maderecentkill )
    {
        self.recentghostridekillcount++;
    }
    
    wait 4;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.recentghostridekillcount >= 3 )
    {
        awardmasterychallenge( challengeref );
    }
    
    self.recentghostridekillcount = undefined;
    self.hasexiteddriver = undefined;
}

