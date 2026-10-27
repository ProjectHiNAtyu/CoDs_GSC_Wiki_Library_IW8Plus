// script_62f2f17deb39ce40  (hash_62f2f17deb39ce40.gscc) (size: 20497 Bytes / 0x5011 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e90aa97 (2391845527)
// size ...... 20497 (0x5011)
// includes .. 24  (offset: 0x4c65)
// strings ... 37  (offset: 0x4d25)
// dev strs .. 9   (offset: 0x4f95)
// exports ... 42  (offset: 0x3349)
// cseg ...... 0x2bf + 0x308a (0x3349)
// imports ... 154 (offset: 0x39d9)
// animtree1 . 0   (offset: 0x5011)
// animtree2 . 0   (offset: 0x5011)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_recon_quest;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\poi;

#namespace namespace_b52a40a0de3ec90a;

// Namespace namespace_b52a40a0de3ec90a
// Params 0, eflags: 0x5
// Checksum 0xa8e2b71, Offset: 0x2dd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_da46e3937970eaef", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0, eflags: 0x4
// Checksum 0xb7b90e85, Offset: 0x306
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CONTRACT_RECON", &activity_type_init );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x4f024fae, Offset: 0x321
// Size: 0x231
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_RECON", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_RECON", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_RECON", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_CONTRACT_RECON", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerKilledMoment", &player_killed, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerEnterGulagMoment", &player_entergulag, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "BRPlayerRespawnedMoment", &player_respawn, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "BRTimerExpired", &recon_timer_expired, "BR_CONTRACT_RECON" );
    activity_common::function_2dd4f07fa5c3e911( "BRCircleTick", &function_8c9e7f303900412, "BR_CONTRACT_RECON" );
    level.var_43a3c8517b4ceea0 = spawnstruct();
    level.var_43a3c8517b4ceea0 = getquestpoints( 7, ( 0, 0, 0 ), 999999, 0, 1 );
    level.var_43a3c8517b4ceea0 = arrayrandomize( level.var_43a3c8517b4ceea0 );
    
    /#
        if ( level.mapname == "<dev string:x24>" )
        {
            var_1640e5063393ef6 = [];
            
            for ( i = 0; i < 3 ; i++ )
            {
                tempnode = spawnstruct();
                tempnode.angles = ( 0, 0, 0 );
                tempnode.origin = ( 570 - i * 300, 705, -512 );
                
                switch ( i )
                {
                    case 0:
                        tempnode.spawnflags = 2;
                        break;
                    case 1:
                        tempnode.spawnflags = 1;
                        break;
                    case 2:
                    default:
                        tempnode.spawnflags = 4;
                        break;
                }
                
                level.var_43a3c8517b4ceea0[ level.var_43a3c8517b4ceea0.size ] = tempnode;
            }
        }
    #/
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x60bb9eab, Offset: 0x55a
// Size: 0x149
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    function_bc041d7a3efbfe87( self.varianttag, self.var_332f929de1894b2b );
    
    if ( utility::issharedfuncdefined( #"hash_da46e3937970eaef", #"contract_validate" ) )
    {
        if ( !utility::callsharedfunc( #"hash_da46e3937970eaef", #"contract_validate" ) )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
    if ( self.var_332f929de1894b2b.var_8aa7692a22ef3289 )
    {
        function_6e26c995cce2b006();
        
        if ( !isdefined( self.var_b25418214626adee ) )
        {
            activity_instance_common::function_9aeeabe50fc9cc3e( self );
            return;
        }
    }
    
    scriptable::scriptable_addusedcallbackbypart( self.var_332f929de1894b2b.domscriptable, &function_4cf1fce206ba178d );
    scriptable::scriptable_addusedcallbackbypart( self.var_332f929de1894b2b.var_519ad982094d0798, &function_4cf1fce206ba178d );
    scriptable::scriptable_addusedcallbackbypart( self.var_332f929de1894b2b.var_e881d4bcdfe42bf0, &function_4cf1fce206ba178d );
    
    /#
        if ( getdvarint( @"hash_17275ec2e0515d12", 0 ) )
        {
            level thread function_70ef765b4625d0e8();
        }
    #/
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x11699cfa, Offset: 0x6ab
// Size: 0xf5
function function_6e26c995cce2b006()
{
    switch ( self.var_332f929de1894b2b.dommode )
    {
        case #"hash_3aabf9627591d71e":
            self.var_b25418214626adee = br_recon_quest::function_8aabe8488ceb5c2f( self.var_1103806baee402d5, self.var_332f929de1894b2b, level.var_43a3c8517b4ceea0 );
            break;
        case #"hash_92bd366a87a75da9":
            self.var_b25418214626adee = function_1c2db8c871620b5();
            break;
        case #"hash_bc1498e071889798":
            self.var_b25418214626adee = function_e6a4eade8bb558c7( self.var_ca369031b554da2f );
            break;
        default:
            assertmsg( "<dev string:x35>" );
            self.var_b25418214626adee = undefined;
            return;
    }
    
    if ( self.var_b25418214626adee )
    {
        self.var_b25418214626adee.task = self;
        self.var_b25418214626adee.activity_instance = self;
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0x353789e7, Offset: 0x7a8
// Size: 0x10c
function function_bc041d7a3efbfe87( variantname, data )
{
    assert( isdefined( game[ "<dev string:x4d>" ] ) );
    
    if ( !isdefined( game[ "dialog" ][ "mission_" + variantname + "_start" ] ) )
    {
        game[ "dialog" ][ "mission_" + variantname + "_start" ] = data.startvo;
        game[ "dialog" ][ "mission_" + variantname + "_start_capture" ] = data.startcapturevo;
        game[ "dialog" ][ "mission_" + variantname + "_start_capture_first_person" ] = data.var_1befa01023971f6c;
        game[ "dialog" ][ "mission_" + variantname + "_success" ] = data.successvo;
        game[ "dialog" ][ "mission_" + variantname + "_time_expired" ] = data.var_da337e6084c18db3;
        game[ "dialog" ][ "mission_" + variantname + "_circle_fail" ] = data.var_7996b2d5b768cfd1;
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x54d92eb0, Offset: 0x8bc
// Size: 0xc0
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !self.var_b25418214626adee )
    {
        function_6e26c995cce2b006();
    }
    
    result = function_9c5a52201f47f21();
    
    if ( result )
    {
        recon_begin();
    }
    else
    {
        /#
            logstring( "<dev string:x54>" );
        #/
        
        self.endstate = "FailedToFindObj";
        activity_instance_common::endactivity( self, 0 );
    }
    
    params = spawnstruct();
    params.distance = distance2d( self.var_441d26d05f86b224, self.var_b25418214626adee.domflag.origin );
    br_activity_util::startcontract( params );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0xa97e1f88, Offset: 0x984
// Size: 0x40
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    recon_ended( succeeded );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x508a113d, Offset: 0x9cc
// Size: 0x263
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( activity_instance.icon ) )
    {
        playersonteam = teams::getteamdata( activity_instance.team, "players" );
        
        foreach ( player in playersonteam )
        {
            objidpoolmanager::objective_playermask_hidefrom( activity_instance.icon, player );
            objidpoolmanager::function_beebd729a49b6cc3( player );
            objidpoolmanager::function_6ac40386d1cd0d9a( activity_instance.icon, player );
        }
        
        objidpoolmanager::returnobjectiveid( activity_instance.icon );
    }
    
    activity_instance.objectiveiconid = activity_instance.objidnum;
    
    if ( isdefined( activity_instance.var_b25418214626adee ) )
    {
        activity_instance.var_b25418214626adee.domflag.trigger delete();
        
        if ( isdefined( activity_instance.domflag.entfollower ) )
        {
            activity_instance.domflag.entfollower delete();
        }
        
        activity_instance br_contract_manager::deletequestobjicon();
        activity_instance.domflag thread function_4d792dbccddbda42( activity_instance.var_b25418214626adee.domflag, activity_instance.successfullycompleted == 1 );
        activity_instance.var_b25418214626adee.domflag = undefined;
        activity_instance.var_b25418214626adee.activity_instance = undefined;
        activity_instance.var_b25418214626adee.task = undefined;
        activity_instance.var_b25418214626adee.setup = undefined;
        activity_instance.var_b25418214626adee.showworldicon = undefined;
        activity_instance.var_b25418214626adee.offset3d = undefined;
        activity_instance.var_b25418214626adee.curorigin = undefined;
        activity_instance.var_b25418214626adee.objidnum = undefined;
        activity_instance.var_b6c5eeeebd9383f5 = undefined;
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x4acde0a1, Offset: 0xc37
// Size: 0x11d, Type: bool
function function_9c5a52201f47f21()
{
    if ( utility::issharedfuncdefined( #"hash_da46e3937970eaef", getxhash( self.var_332f929de1894b2b.var_21c1c94f88e9a36c ) ) )
    {
        utility::callsharedfunc( #"hash_da46e3937970eaef", getxhash( self.var_332f929de1894b2b.var_21c1c94f88e9a36c ), self.var_ca369031b554da2f );
        return isdefined( self.var_b25418214626adee );
    }
    
    switch ( self.var_332f929de1894b2b.dommode )
    {
        case #"hash_3aabf9627591d71e":
        case #"hash_bc1498e071889798":
            self.var_b25418214626adee = function_fb73a57e1c865df9( self.var_b25418214626adee, self.var_ca369031b554da2f );
            break;
        case #"hash_92bd366a87a75da9":
            self.var_b25418214626adee = function_a51220fef73d29bf( self.traincar, self.var_ca369031b554da2f );
            break;
        default:
            assertmsg( "<dev string:x35>" );
            self.var_b25418214626adee = undefined;
            break;
    }
    
    return isdefined( self.var_b25418214626adee );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1, eflags: 0x4
// Checksum 0xa250e1fc, Offset: 0xd5d
// Size: 0x169
function private function_e6a4eade8bb558c7( var_ca369031b554da2f )
{
    if ( !isdefined( var_ca369031b554da2f.origin ) || !isdefined( self.var_332f929de1894b2b ) || !isdefined( level.var_43a3c8517b4ceea0 ) )
    {
        return;
    }
    
    var_afaf5f7a191b2490 = br_recon_quest::function_8aabe8488ceb5c2f( var_ca369031b554da2f.origin, self.var_332f929de1894b2b, level.var_43a3c8517b4ceea0 );
    
    if ( !isdefined( var_afaf5f7a191b2490 ) )
    {
        closestnode = undefined;
        closestdistsq = undefined;
        
        foreach ( domnode in level.var_43a3c8517b4ceea0 )
        {
            if ( !isdefined( domnode.origin ) )
            {
                continue;
            }
            
            if ( domnode.task || domnode.setup )
            {
                continue;
            }
            
            distsq = distancesquared( var_ca369031b554da2f.origin, domnode.origin );
            
            if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
            {
                closestdistsq = distsq;
                closestnode = domnode;
            }
        }
        
        var_afaf5f7a191b2490 = closestnode;
    }
    
    return var_afaf5f7a191b2490;
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x8d200d4d, Offset: 0xecf
// Size: 0x332
function recon_begin()
{
    br_activity_util::function_3fbbc67df36be7bb( self.var_332f929de1894b2b.contracttime );
    domstruct = self.var_b25418214626adee;
    self.curorigin = self.var_b25418214626adee.domflag.origin;
    self.offset3d = ( 0, 0, 50 );
    gameobjects::requestid( 1, 1, undefined, 1 );
    domstruct.curorigin = domstruct.domflag.origin;
    domstruct.offset3d = ( 0, 0, 50 );
    domstruct gameobjects::requestid( 1, 1, undefined, 1 );
    self.icon = domstruct.objidnum;
    iconposition = self.var_b25418214626adee.domflag.origin + ( 0, 0, 70 );
    br_recon_quest::function_62238d8e13a6af13( self.objidnum, iconposition, self.var_332f929de1894b2b.objectiveicon );
    br_recon_quest::function_62238d8e13a6af13( domstruct.objidnum, iconposition, self.var_332f929de1894b2b.objectiveicon );
    objective_removeallfrommask( self.objidnum );
    br_activity_util::function_87a015bf03f9d1f6( self.objidnum );
    objidpoolmanager::function_eb808b97701a4793( self.icon );
    objidpoolmanager::objective_set_play_intro( self.icon, 0 );
    objective_setlabel( self.objidnum, self.var_332f929de1894b2b.var_13b0ba523cf008e1 );
    thread br_contract_manager::function_d2646c7b2b23ae4b( "secure_recon_assigned", self.team, self.squadindex );
    level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_start", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_5486d2d12b5e3459, undefined, 1 );
    
    if ( self.var_332f929de1894b2b.var_107d056da158ac5b )
    {
        players = self.playerparticipants;
        
        foreach ( player in players )
        {
            domstruct.domflag enablescriptableplayeruse( player );
        }
    }
    else
    {
        domstruct.domflag thread recon_waitforplayers();
    }
    
    if ( self.var_332f929de1894b2b.dommode == "Train" )
    {
        objidpoolmanager::update_objective_onentity( self.objidnum, self.domflag.entfollower );
        objidpoolmanager::update_objective_onentity( self.icon, self.domflag.entfollower );
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x833b2cec, Offset: 0x1209
// Size: 0x13
function recon_timer_expired( params )
{
    function_e0cf16a02cca49f8();
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x931f55db, Offset: 0x1224
// Size: 0xeb
function function_8c9e7f303900412( params )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    if ( isdefined( self.var_b25418214626adee ) )
    {
        if ( !self.securing || self.var_b25418214626adee.domflag.playersintrigger.size < 1 )
        {
            if ( !br_circle_util::ispointindangercircle( self.var_b25418214626adee.domflag.origin, level.var_ea96217a33eb6457 ) )
            {
                level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_circle_fail", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_bddea2f4a049fb25, undefined, 1 );
                self.var_b6c5eeeebd9383f5 = 1;
                self.endstate = "Circle";
                activity_instance_common::endactivity( self, 0 );
            }
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0xc96b0ba7, Offset: 0x1317
// Size: 0x7a
function recon_ended( succeeded )
{
    if ( succeeded )
    {
        rewards = br_contract_manager::function_83f627106ef43736( self.var_332f929de1894b2b.rewardgroup, self.var_b25418214626adee );
    }
    
    if ( self.flare )
    {
        self.flare notify( #"end_flare_loop" );
    }
    
    br_recon_quest::function_3992efb53108782( 0 );
    br_activity_util::endcontract( succeeded, rewards, self.endstate );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x23aa4e47, Offset: 0x1399
// Size: 0x69
function function_1c2db8c871620b5()
{
    if ( !level.wztrain_info.dom_cars.size )
    {
        return;
    }
    
    traincar = level.wztrain_info.dom_cars[ randomint( level.wztrain_info.dom_cars.size ) ];
    self.traincar = traincar;
    return traincar.var_b25418214626adee;
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x4d634b3e, Offset: 0x140b
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x82498db5, Offset: 0x144b
// Size: 0x43
function player_killed( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.victim ) )
    {
        if ( !br_activity_util::function_79f1eba39959ffed( self ) )
        {
            self.endstate = "Killed";
            activity_instance_common::endactivity( self, 0 );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x5db2bfdc, Offset: 0x1496
// Size: 0x59
function player_entergulag( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objidnum, params.player );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x50dad3e8, Offset: 0x14f7
// Size: 0x59
function player_respawn( params )
{
    if ( activity_participation::function_e7fc1202ac164928( self, params.player ) )
    {
        if ( isdefined( self.objidnum ) && self.objidnum != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, params.player );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 6
// Checksum 0x5523d2ee, Offset: 0x1558
// Size: 0x1eb
function function_4cf1fce206ba178d( instance, part, state, useplayer, bautouse, usestring )
{
    if ( isstring( instance.activity_instance.var_332f929de1894b2b.domgesture ) )
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( makeweapon( instance.activity_instance.var_332f929de1894b2b.domgesture ), undefined, instance.activity_instance.var_332f929de1894b2b.var_eeccb0f33daf68f2 );
    }
    else
    {
        deployresult = useplayer br_contract_manager::function_14a772eecc5cf7d1( instance.activity_instance.var_332f929de1894b2b.domgesture, undefined, instance.activity_instance.var_332f929de1894b2b.var_eeccb0f33daf68f2 );
    }
    
    if ( !deployresult )
    {
        return;
    }
    
    if ( instance.node.spawnflags & 4 )
    {
        instance setscriptablepartstate( instance.activity_instance.var_332f929de1894b2b.var_e881d4bcdfe42bf0, "unusable" );
    }
    else if ( instance.node.spawnflags & 2 )
    {
        instance setscriptablepartstate( instance.activity_instance.var_332f929de1894b2b.var_519ad982094d0798, "unusable" );
    }
    else if ( instance.node.spawnflags & 1 )
    {
        instance setscriptablepartstate( instance.activity_instance.var_332f929de1894b2b.domscriptable, "unusable" );
    }
    
    function_bff21f4529905f83( instance, useplayer );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0x9e00bd14, Offset: 0x174b
// Size: 0x2a9
function function_bff21f4529905f83( instance, player )
{
    level thread br_public::brleaderdialogplayer( "mission_" + instance.activity_instance.varianttag + "_start_capture_first_person", player, 1, undefined, 2, undefined, instance.activity_instance.var_332f929de1894b2b.var_c11ab78c137e5948, undefined, 1 );
    players = teams::getteamdata( instance.activity_instance.team, "players" );
    players = arrayremove( players, player );
    level thread br_public::brleaderdialog( "mission_" + instance.activity_instance.varianttag + "_start_capture", 1, players, undefined, 2, undefined, instance.activity_instance.var_332f929de1894b2b.var_f644b39eef88ea97, 1 );
    player notify( #"hash_90cb896cd890da37" );
    
    if ( instance.activity_instance.var_332f929de1894b2b.var_6e9874e04cc8925d )
    {
        if ( getdvarint( @"hash_22ec3c39b0a3790d", instance.activity_instance.var_332f929de1894b2b.var_35592efc3e50f473 ) )
        {
            type = level.mapname == "mp_saw_sm_island" ? "dom_sm_island" : "dom";
            level thread br_contract_manager::utilflare_shootflare( instance.origin, type, undefined, undefined, 1, instance.activity_instance );
        }
        else
        {
            level thread br_contract_manager::utilflare_shootflare( instance.origin, "dom" );
        }
    }
    
    objidpoolmanager::objective_set_play_intro( instance.activity_instance.objidnum, 0 );
    instance.activity_instance thread function_1dc8f4a527cfbfbf( instance, instance.activity_instance.objidnum );
    instance.activity_instance br_activity_util::function_87a015bf03f9d1f6( instance.activity_instance.icon );
    
    if ( instance.activity_instance.var_c49e2e658305b134 )
    {
        objidpoolmanager::objective_set_show_progress( instance.activity_instance.objidnum, 1 );
    }
    
    instance.activity_instance thread domflag_update( instance.activity_instance.domflag, instance.activity_instance.icon, instance.activity_instance.objidnum );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 3
// Checksum 0x7d6612a, Offset: 0x19fc
// Size: 0x29
function domflag_update( domflag, objidnum, var_4bebb75e86ab0cd4 )
{
    domflag_updateinternal( domflag, objidnum, var_4bebb75e86ab0cd4 );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 3, eflags: 0x4
// Checksum 0xaaf62c53, Offset: 0x1a2d
// Size: 0x3cb
function private domflag_updateinternal( domflag, objidnum, var_4bebb75e86ab0cd4 )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.securing = 1;
    objective_setpinned( objidnum, 1 );
    
    if ( self.var_332f929de1894b2b.var_67535682825ef252 )
    {
        domflag function_d51f9fbdc73f5704();
    }
    
    playersonteam = self.playerparticipants;
    overlord::playevent( "secure_recon_uploading", playersonteam );
    timer = 0;
    duration = self.var_332f929de1894b2b.domcapturetime * 1000;
    
    while ( true )
    {
        count = 0;
        var_372ea00d5a2d40fc = 0;
        
        foreach ( arr in domflag.var_64f8beac2aabdec5 )
        {
            foreach ( player in arr )
            {
                if ( player )
                {
                    if ( isplayer( player ) && activity_participation::function_e7fc1202ac164928( self, player ) )
                    {
                        var_372ea00d5a2d40fc = 1;
                        objidpoolmanager::function_72efeaceb614613a( objidnum, player, 2, 2, self.var_332f929de1894b2b.timeremainingtext );
                        objective_setpinnedprogressbartext( self.var_332f929de1894b2b.timeremainingtext, player );
                        objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
                    }
                    
                    count++;
                }
            }
        }
        
        if ( !var_372ea00d5a2d40fc )
        {
            count = 0;
        }
        
        br_recon_quest::function_3992efb53108782( count );
        
        if ( count > 0 )
        {
            if ( !self.var_6472f484147d1cab )
            {
                self.var_6472f484147d1cab = 1;
                br_activity_util::function_951f899c3ca23364( 1 );
                objective_disableping( objidnum, 1 );
                calloutmarkerping::function_73084f64fa34a5a8( var_4bebb75e86ab0cd4 );
            }
            
            var_5d1f53051ff9c230 = self.var_332f929de1894b2b.var_51704ad3d151a5ed;
            var_2c0804422a8e5842 = 0;
            
            if ( level.maxteamsize > 1 )
            {
                var_2c0804422a8e5842 = var_5d1f53051ff9c230 / ( level.maxteamsize - 1 );
            }
            
            capturerate = 1 + ( count - 1 ) * var_2c0804422a8e5842;
            timer += level.frameduration * capturerate;
            progress = timer / duration;
            progress = clamp( progress, 0, 1 );
            
            if ( timer < duration )
            {
                objective_setprogress( var_4bebb75e86ab0cd4, progress );
                objective_setprogress( objidnum, progress );
                br_recon_quest::play_spotrep_capture_sfx( progress, domflag.playersintrigger );
            }
            else
            {
                self.capturingplayer = domflag.playersintrigger[ 0 ];
                level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_success", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_61dfddd29578c7ba, undefined, 1 );
                self.endstate = "Win";
                activity_instance_common::endactivity( self, 1 );
                self.securing = 0;
                break;
            }
        }
        else if ( self.var_6472f484147d1cab )
        {
            self.var_6472f484147d1cab = 0;
            br_activity_util::function_951f899c3ca23364( 0 );
            objective_disableping( objidnum, 0 );
        }
        
        waitframe();
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0xac062a56, Offset: 0x1e00
// Size: 0x244
function function_fb73a57e1c865df9( node, var_ca369031b554da2f )
{
    if ( !isdefined( node ) )
    {
        assertmsg( "<dev string:x97>" );
        return;
    }
    
    if ( !( node.spawnflags & 7 ) )
    {
        assertmsg( "<dev string:xcf>" );
    }
    
    v_origin = getgroundposition( node.origin, 1 );
    var_2a21be5f74f73c3d = node.angles ?? ( 0, 0, 0 );
    node.angles = var_2a21be5f74f73c3d;
    spawndompoint( var_ca369031b554da2f, node, v_origin, var_2a21be5f74f73c3d );
    self.domflag.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
    domradius = br_contract_manager::questpointgetradius( node );
    self.domflag.trigger = spawn( "trigger_radius", node.origin, 0, int( domradius ), self.var_332f929de1894b2b.var_1e35088397af1053 );
    self.domflag.radius = domradius;
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag.activity_instance = self;
    node.setup = 1;
    node.domflag = self.domflag;
    self.domflag.node = node;
    
    foreach ( player in level.players )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    self.domflag thread domflag_watchtrigger();
    return node;
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0x143662bc, Offset: 0x204d
// Size: 0x36e
function function_a51220fef73d29bf( traincar, var_ca369031b554da2f )
{
    if ( !isdefined( traincar ) )
    {
        assertmsg( "<dev string:x10d>" );
        return;
    }
    
    if ( !isdefined( traincar.var_b25418214626adee ) )
    {
        assertmsg( "<dev string:x146>" );
        return;
    }
    
    if ( !( traincar.var_b25418214626adee.spawnflags & 7 ) )
    {
        assertmsg( "<dev string:xcf>" );
    }
    
    var_2a21be5f74f73c3d = function_5d9d4913d5a2c4a7( traincar );
    var_92b32d702db115f1 = function_839a57500b3790b4( traincar );
    spawndompoint( var_ca369031b554da2f, traincar, var_92b32d702db115f1, var_2a21be5f74f73c3d );
    self.domflag.script_poi = poi::poi_findpoioriginisin( var_92b32d702db115f1, 1 );
    domradius = br_contract_manager::questpointgetradius( traincar.var_b25418214626adee );
    self.domflag.trigger = spawn( "trigger_radius", var_92b32d702db115f1, 0, int( domradius ), self.var_332f929de1894b2b.var_1e35088397af1053 );
    self.domflag.radius = domradius;
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag.task = self;
    self.domflag.activity_instance = self;
    traincar.var_b25418214626adee.setup = 1;
    traincar.var_b25418214626adee.domflag = self.domflag;
    var_8e758561227fe312 = self.traincar.linked_model;
    linkorigin = self.traincar.var_b25418214626adee.origin ?? ( 0, 0, 0 );
    linkangles = self.traincar.var_b25418214626adee.angles ?? ( 0, 0, 0 );
    self.domflag scriptablesetparententity( var_8e758561227fe312, linkorigin, linkangles );
    self.domflag.trigger enablelinkto();
    self.domflag.trigger linkto( var_8e758561227fe312, "tag_origin", linkorigin, linkangles );
    self.domflag.entfollower = spawn( "script_model", var_92b32d702db115f1 );
    self.domflag.entfollower linkto( traincar.linked_model );
    
    foreach ( player in level.players )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    self.domflag thread domflag_watchtrigger();
    return traincar.var_b25418214626adee;
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x1f35535c, Offset: 0x23c4
// Size: 0x74
function function_839a57500b3790b4( traincar )
{
    if ( isdefined( traincar.var_b25418214626adee.origin ) && isdefined( traincar.origin ) && isdefined( traincar.angles ) )
    {
        return ( traincar.origin + rotatevector( traincar.var_b25418214626adee.origin, traincar.angles ) );
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 1
// Checksum 0x9a27667a, Offset: 0x2440
// Size: 0x56
function function_5d9d4913d5a2c4a7( traincar )
{
    if ( isdefined( traincar.var_b25418214626adee.angles ) && isdefined( traincar.angles ) )
    {
        return ( traincar.angles + traincar.var_b25418214626adee.angles );
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 4
// Checksum 0x7f8f52c2, Offset: 0x249e
// Size: 0x1c6
function spawndompoint( var_ca369031b554da2f, point, v_origin, var_2a21be5f74f73c3d )
{
    /#
        if ( getdvar( @"hash_79bd989cf75e6e80", "<dev string:x188>" ) != "<dev string:x188>" )
        {
            size = getdvar( @"hash_79bd989cf75e6e80", "<dev string:x188>" );
            
            switch ( size )
            {
                case #"hash_5971965ed985a26c":
                    point.spawnflags = 2;
                    break;
                case #"hash_c71b112fe04823d6":
                    point.spawnflags = 1;
                    break;
                case #"hash_4bf33d595d8f4894":
                default:
                    point.spawnflags = 4;
                    break;
            }
        }
    #/
    
    payload = [ #"teamselect", var_ca369031b554da2f.team ];
    
    if ( point.spawnflags & 2 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( self.var_332f929de1894b2b.var_519ad982094d0798, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
        
        return;
    }
    
    if ( point.spawnflags & 1 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( self.var_332f929de1894b2b.domscriptable, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
        
        return;
    }
    
    if ( point.spawnflags & 4 )
    {
        if ( !isdefined( self.domflag ) )
        {
            self.domflag = spawnscriptable( self.var_332f929de1894b2b.var_e881d4bcdfe42bf0, v_origin, var_2a21be5f74f73c3d, undefined, payload );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0xc9487504, Offset: 0x266c
// Size: 0x100
function recon_waitforplayers()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        players = teams::getteamdata( self.activity_instance.team, "players" );
        
        foreach ( player in players )
        {
            if ( distance( player.origin, self.origin ) < self.radius )
            {
                function_bff21f4529905f83( self, player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x6ea1c41a, Offset: 0x2774
// Size: 0x144
function domflag_watchtrigger()
{
    level endon( #"game_ended" );
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    childthread function_86a70a58623745fc();
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) )
                {
                    function_97a824ee8e9624bb( occupant, occupant );
                }
            }
            
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            function_97a824ee8e9624bb( ent, ent );
            continue;
        }
        
        if ( gameobjects::function_e17a356e69f57699( ent ) && ent.owner )
        {
            function_97a824ee8e9624bb( ent.owner, ent );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0, eflags: 0x4
// Checksum 0xb6bebe01, Offset: 0x28c0
// Size: 0x100
function private function_86a70a58623745fc()
{
    level endon( #"game_ended" );
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( grenade in getentitiesinradiusfrompartitiongrid( self.trigger.origin, self.radius, createentitytypemask( [ "etype_missile" ] ), undefined, self.activity_instance.team ) )
        {
            self.trigger notify( #"trigger", grenade );
        }
        
        wait 1;
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2, eflags: 0x4
// Checksum 0xb9106412, Offset: 0x29c8
// Size: 0xc3
function private function_97a824ee8e9624bb( player, entity )
{
    if ( !isdefined( self.var_64f8beac2aabdec5 ) )
    {
        self.var_64f8beac2aabdec5 = [];
    }
    
    if ( !isdefined( self.var_64f8beac2aabdec5[ player getentitynumber() ] ) )
    {
        self.var_64f8beac2aabdec5[ player getentitynumber() ] = [];
    }
    
    if ( !arraycontains( self.playersintrigger, player ) )
    {
        self.playersintrigger[ self.playersintrigger.size ] = player;
    }
    
    if ( !arraycontains( self.var_64f8beac2aabdec5[ player getentitynumber() ], entity ) )
    {
        self.var_64f8beac2aabdec5[ player getentitynumber() ][ self.var_64f8beac2aabdec5[ player getentitynumber() ].size ] = entity;
        thread function_b171ab43f3af86a3( player, entity );
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2, eflags: 0x4
// Checksum 0x3dfd4852, Offset: 0x2a93
// Size: 0x1f8
function private function_4d69cb87a4b005ec( player, entity )
{
    if ( !player )
    {
        foreach ( entitynumber in getarraykeys( self.var_64f8beac2aabdec5 ) )
        {
            if ( !getentbynum( entitynumber ) )
            {
                self.var_64f8beac2aabdec5[ entitynumber ] = undefined;
            }
        }
        
        self.playersintrigger = function_5713d46873b29625( self.playersintrigger );
        return;
    }
    
    if ( !self.var_64f8beac2aabdec5[ player getentitynumber() ] )
    {
        return;
    }
    
    if ( !arraycontains( self.var_64f8beac2aabdec5[ player getentitynumber() ], entity ) )
    {
        return;
    }
    
    self.var_64f8beac2aabdec5[ player getentitynumber() ] = arrayremove( self.var_64f8beac2aabdec5[ player getentitynumber() ], entity );
    self.var_64f8beac2aabdec5[ player getentitynumber() ] = function_5713d46873b29625( self.var_64f8beac2aabdec5[ player getentitynumber() ] );
    
    if ( self.var_64f8beac2aabdec5[ player getentitynumber() ].size == 0 && arraycontains( self.playersintrigger, player ) )
    {
        self.playersintrigger = arrayremove( self.playersintrigger, player );
        self.playersintrigger = function_5713d46873b29625( self.playersintrigger );
        objicon = self.activity_instance.icon;
        
        if ( isdefined( player ) && isdefined( objicon ) && self.activity_instance.team == player.team )
        {
            objidpoolmanager::objective_playermask_hidefrom( objicon, player );
            objidpoolmanager::function_beebd729a49b6cc3( player );
            objidpoolmanager::function_6ac40386d1cd0d9a( objicon, player );
        }
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2, eflags: 0x4
// Checksum 0x7a167650, Offset: 0x2c93
// Size: 0xfc
function private function_b171ab43f3af86a3( player, entity )
{
    level endon( #"game_ended" );
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    domradius = self.radius;
    domradiussq = domradius * domradius;
    
    while ( isdefined( entity ) && isdefined( self.trigger ) && distancesquared( self.trigger.origin, entity.origin ) < domradiussq )
    {
        if ( isplayer( entity ) )
        {
            if ( !isalive( entity ) )
            {
                break;
            }
        }
        else if ( gameobjects::function_e17a356e69f57699( entity ) )
        {
            if ( entity.var_57b273c971318b8f === 0 || entity.var_918f5731d316cbc )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    function_4d69cb87a4b005ec( player, entity );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0x9ea8a23a, Offset: 0x2d97
// Size: 0x13e
function function_4d792dbccddbda42( domflag, success )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( success ) )
    {
        success = 0;
    }
    
    if ( self.activity_instance.var_332f929de1894b2b.var_67535682825ef252 )
    {
        function_283f4988a229c380();
    }
    
    if ( success )
    {
        if ( self.activity_instance.var_332f929de1894b2b.questdroploot )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( self.activity_instance.var_332f929de1894b2b.var_131e1fc1047155f4 );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                var_75edf5d39ca3eb70 = var_f67995529827f79.spawnlistname;
                spawncount = var_f67995529827f79.spawncount;
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
                common_item::function_38cde6a6acb68ea6( var_75edf5d39ca3eb70, spawncount, spawnoptions );
            }
        }
    }
    
    wait self.activity_instance.var_332f929de1894b2b.var_23a84a7cab980335;
    domflag freescriptable();
}

// Namespace namespace_b52a40a0de3ec90a
// Params 2
// Checksum 0xb34b7b50, Offset: 0x2edd
// Size: 0x193
function function_1dc8f4a527cfbfbf( domflag, objidnum )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        playersonteam = teams::getteamdata( self.team, "players" );
        
        foreach ( player in playersonteam )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( isdefined( objidnum ) && objidnum != -1 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
            }
        }
        
        foreach ( player in domflag.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team == self.team )
            {
                objidpoolmanager::objective_playermask_hidefrom( objidnum, player );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0x962351b9, Offset: 0x3078
// Size: 0x15f
function function_e0cf16a02cca49f8()
{
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    while ( self.securing && self.var_b25418214626adee.domflag.playersintrigger.size > 0 )
    {
        var_486aee031e94754 = 0;
        
        foreach ( player in self.var_b25418214626adee.domflag.playersintrigger )
        {
            if ( player.team == self.team )
            {
                var_486aee031e94754++;
            }
        }
        
        if ( var_486aee031e94754 > 0 )
        {
            wait 5;
            continue;
        }
        
        break;
    }
    
    level thread br_public::brleaderdialogteam( "mission_" + self.varianttag + "_time_expired", self.team, 1, 1, undefined, self.var_332f929de1894b2b.var_a3b0de4dd5ca30a7, undefined, 1 );
    self.endstate = "Time";
    activity_instance_common::endactivity( self, 0 );
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0xec8e5a1, Offset: 0x31df
// Size: 0x32
function function_d51f9fbdc73f5704()
{
    if ( self.activity_instance.var_332f929de1894b2b.var_5e24bc775a2a8c7a )
    {
        self setscriptablepartstate( "vfx_circle", "circle" );
    }
}

// Namespace namespace_b52a40a0de3ec90a
// Params 0
// Checksum 0xf500ac4, Offset: 0x3219
// Size: 0x75
function function_283f4988a229c380()
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "vfx_circle", "circle_end" );
    
    if ( self.activity_instance.var_332f929de1894b2b.var_5e24bc775a2a8c7a )
    {
        wait self.activity_instance.var_332f929de1894b2b.var_5e24bc775a2a8c7a;
    }
    else
    {
        wait 1;
    }
    
    self setscriptablepartstate( "vfx_circle", "no_circle" );
}

/#

    // Namespace namespace_b52a40a0de3ec90a
    // Params 0
    // Checksum 0xe82a10b7, Offset: 0x3296
    // Size: 0xb3, Type: dev
    function function_70ef765b4625d0e8()
    {
        waitframe();
        
        foreach ( domnode in level.var_43a3c8517b4ceea0 )
        {
            thread debug_utility::drawline( domnode.origin, domnode.origin + ( 0, 0, 1200 ), 9999999, ( 1, 0, 1 ) );
        }
    }

#/
