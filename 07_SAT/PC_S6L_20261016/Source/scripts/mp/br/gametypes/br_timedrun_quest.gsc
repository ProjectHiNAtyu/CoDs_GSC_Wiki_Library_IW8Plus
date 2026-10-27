// scripts\mp\br\gametypes\br_timedrun_quest.gsc  (hash_1d86af74cb794f29.gscc) (size: 14415 Bytes / 0x384f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1fff2ad (2717905581)
// size ...... 14415 (0x384f)
// includes .. 12  (offset: 0x3493)
// strings ... 52  (offset: 0x34f3)
// dev strs .. 3   (offset: 0x382b)
// exports ... 33  (offset: 0x237b)
// cseg ...... 0x475 + 0x1f06 (0x237b)
// imports ... 99  (offset: 0x28a3)
// animtree1 . 0   (offset: 0x384f)
// animtree2 . 0   (offset: 0x384f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\objidpoolmanager;

#namespace br_timedrun_quest;

// Namespace br_timedrun_quest
// Params 1
// Checksum 0xb80199b9, Offset: 0x493
// Size: 0x289
function getcontractdata( data )
{
    if ( getdvarint( @"scr_br_timedrun_quest_disable", 0 ) )
    {
        data.enabled = 0;
        return;
    }
    
    level.timedrun_quest = spawnstruct();
    var_47b2c991ea1286f0 = getdvarint( @"hash_949aadc2a390119d", 0 );
    level.timedrun_quest.questmaxtime = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "timedrun" );
    function_d4705e17aa0f7845( data );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_timedrun_accept" ] = "trst_wzan_trsf";
    game[ "dialog" ][ "mission_timedrun_accept_plunder" ] = "trst_wzan_trsf";
    game[ "dialog" ][ "mission_timedrun_success" ] = "trsc_wzan_trfs";
    game[ "dialog" ][ "mission_timedrun_success_plunder" ] = "trsc_wzan_trfs";
    game[ "dialog" ][ "mission_timedrun_fail_time" ] = "trfl_wzan_trfl";
    game[ "dialog" ][ "mission_timedrun_fail_circle" ] = "gnrc_wzan_msfr";
    callback::add( "area_swap_begin", &function_c1da596d8ee1a90a );
    data.funcs[ "onInit" ] = &quest_oninit;
    data.funcs[ "onTeamAssigned" ] = &quest_onteamassigned;
    data.funcs[ "onShowAgain" ] = &quest_onshowagain;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "circleTick" ] = &function_70034271e970d006;
    data.funcs[ "onTimerExpired" ] = &function_88679453542a90b3;
    data.funcs[ "onFinishContract" ] = &function_1be7c59a593161bc;
    data.funcs[ "onCircleRelocation" ] = &function_67b529e129462fe2;
    data.funcs[ "onBuyStationUsed" ] = &function_22da77ca8dba4295;
}

// Namespace br_timedrun_quest
// Params 1, eflags: 0x4
// Checksum 0xa6b3c7e, Offset: 0x724
// Size: 0x441
function private function_d4705e17aa0f7845( data )
{
    if ( data.var_3e66e51a241b9989.variant_object.contracttype == "TimedRun" )
    {
        level.timedrun_quest.maxrange = getdvarint( @"scr_br_timedrun_quest_max_range", data.var_3e66e51a241b9989.variant_object.maxrange );
        level.timedrun_quest.minrange = getdvarint( @"scr_br_timedrun_quest_min_range", data.var_3e66e51a241b9989.variant_object.minrange );
        level.timedrun_quest.var_a78f4e37e17d8c6 = getdvarint( @"hash_689311200a48b848", data.var_3e66e51a241b9989.variant_object.var_a78f4e37e17d8c6 );
        level.timedrun_quest.var_4ef5391b265b27ac = getdvarint( @"hash_a5b9d86496ac1416", data.var_3e66e51a241b9989.variant_object.var_4ef5391b265b27ac );
        level.timedrun_quest.var_5503ee709e8dec0c = getdvarint( @"scr_br_timedrun_quest_use_radius", data.var_3e66e51a241b9989.variant_object.var_5503ee709e8dec0c );
        level.timedrun_quest.radius = getdvarint( @"scr_br_timedrun_quest_radius", data.var_3e66e51a241b9989.variant_object.captureradius );
        level.timedrun_quest.var_880bf5ccc1b62680 = getdvarfloat( @"hash_96cfb36df1b94505", data.var_3e66e51a241b9989.variant_object.var_880bf5ccc1b62680 );
        level.timedrun_quest.timedrun_gesture = data.var_3e66e51a241b9989.variant_object.timedrun_gesture;
        level.timedrun_quest.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_8e795ac4a4f7c647", data.var_3e66e51a241b9989.variant_object.var_eeccb0f33daf68f2 );
        level.timedrun_quest.var_5b92e8936f0baf0 = utility::function_d2db822aceef856a( data.var_3e66e51a241b9989.variant_object.var_5b92e8936f0baf0, "," ) ?? utility::function_d2db822aceef856a( getdvar( @"hash_ba11fec64bec66d6", "1.0,0.9,0.8,0.7,0.6,0.5,0.5,0.5,0.5,0.5" ), "," );
        return;
    }
    
    level.timedrun_quest.maxrange = getdvarint( @"scr_br_timedrun_quest_max_range", 23000 );
    level.timedrun_quest.minrange = getdvarint( @"scr_br_timedrun_quest_min_range", 5000 );
    level.timedrun_quest.var_a78f4e37e17d8c6 = getdvarint( @"hash_689311200a48b848", 20000 );
    level.timedrun_quest.var_4ef5391b265b27ac = getdvarint( @"hash_a5b9d86496ac1416", 17000 );
    level.timedrun_quest.var_5503ee709e8dec0c = getdvarint( @"hash_fe25cf3411b667fc", 1 );
    level.timedrun_quest.radius = getdvarint( @"scr_br_timedrun_quest_radius", 150 );
    level.timedrun_quest.var_880bf5ccc1b62680 = getdvarfloat( @"hash_96cfb36df1b94505", 5 );
    level.timedrun_quest.timedrun_gesture = getdvar( @"hash_81134234f04af164", "ks_gesture_walkie_wz" );
    level.timedrun_quest.var_eeccb0f33daf68f2 = getdvarfloat( @"hash_8e795ac4a4f7c647", 0.45 );
    level.timedrun_quest.var_5b92e8936f0baf0 = utility::function_d2db822aceef856a( getdvar( @"hash_ba11fec64bec66d6", "1.0,0.9,0.8,0.7,0.6,0.5,0.5,0.5,0.5,0.5" ), "," );
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x5b0ee24c, Offset: 0xb6d
// Size: 0x78, Type: bool
function function_c1ae0bcd765767f1( kiosk )
{
    if ( !isdefined( kiosk ) )
    {
        return false;
    }
    
    if ( kiosk.var_ea4a540642460712 )
    {
        return br_deployable_kiosk::function_89cad7b93fb573d4( kiosk );
    }
    
    if ( kiosk.isdeployablekiosk )
    {
        return false;
    }
    
    return ( !kiosk.disabled || kiosk.isemped ) && !isdefined( kiosk.traincar ) && !kiosk.b_force_disabled;
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0xcbef9bd8, Offset: 0xbee
// Size: 0x14
function function_8a755cb0912dd0e4( targetid )
{
    return br_deployable_kiosk::function_3cf3d8098e05c9d7( targetid );
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0xae8b5191, Offset: 0xc0b
// Size: 0xde
function function_20ecef5ae3a6c07b( paramstruct, var_4084e963af9ed72e = 1 )
{
    alltargets = function_f59108ef6ed698cc();
    pendingtargets = br_deployable_kiosk::function_2fb4258a6b28de5d( 0 );
    
    foreach ( target in pendingtargets )
    {
        alltargets[ alltargets.size ] = target;
    }
    
    besttarget = function_829cfc20ed74ffcd( paramstruct, alltargets, 0 );
    
    if ( isdefined( besttarget ) || !var_4084e963af9ed72e )
    {
        return besttarget;
    }
    
    return function_829cfc20ed74ffcd( paramstruct, alltargets, 1 );
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x72adf1e0, Offset: 0xcf2
// Size: 0x3c
function function_774cc94bbee4831d( paramstruct )
{
    activetargets = function_f59108ef6ed698cc();
    target = function_829cfc20ed74ffcd( paramstruct, activetargets );
    return target.kiosk;
}

// Namespace br_timedrun_quest
// Params 0, eflags: 0x4
// Checksum 0xff939559, Offset: 0xd37
// Size: 0x16e
function private function_f59108ef6ed698cc()
{
    activetargets = [];
    allkiosks = br_armory_kiosk::getbuystations();
    
    foreach ( kiosk in allkiosks )
    {
        if ( !function_c1ae0bcd765767f1( kiosk ) )
        {
            continue;
        }
        
        activetarget = { #targetid:undefined, #kiosk:kiosk, #var_9aaebddcbd952541:0, #angles:kiosk.angles, #origin:kiosk.origin };
        activetargets[ activetargets.size ] = activetarget;
    }
    
    deployabletargets = br_deployable_kiosk::function_4fc195ced6b34583();
    
    foreach ( target in deployabletargets )
    {
        activetargets[ activetargets.size ] = target;
    }
    
    return activetargets;
}

// Namespace br_timedrun_quest
// Params 3, eflags: 0x4
// Checksum 0xf3595ee9, Offset: 0xeae
// Size: 0x442
function private function_829cfc20ed74ffcd( paramstruct, candidates, var_4084e963af9ed72e = 1 )
{
    activelocations = arrayrandomize( candidates );
    var_5b92e8936f0baf0 = utility::function_d2db822aceef856a( paramstruct.var_5b92e8936f0baf0, "," );
    var_4ef5391b265b27ac = function_36f418a8c3f17fed( paramstruct.var_4ef5391b265b27ac, var_5b92e8936f0baf0 );
    var_a78f4e37e17d8c6 = function_36f418a8c3f17fed( paramstruct.var_a78f4e37e17d8c6, var_5b92e8936f0baf0 );
    contracttime = paramstruct.contracttime ?? 120;
    var_3a6c0b9b0f3a6430 = 20;
    idealmidpoint = ( var_4ef5391b265b27ac + var_a78f4e37e17d8c6 ) / 2;
    idealtargets = [];
    fallbacktargets = [];
    
    foreach ( node in activelocations )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > paramstruct.maxrange || dist < paramstruct.minrange )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_4d410ddbe3d207be = br_circle::getmintimetillpointindangercircle( node.origin );
            
            if ( var_4d410ddbe3d207be - var_3a6c0b9b0f3a6430 - contracttime < 0 )
            {
                continue;
            }
        }
        
        if ( dist >= var_4ef5391b265b27ac && dist <= var_a78f4e37e17d8c6 )
        {
            idealtargets[ idealtargets.size ] = node;
            continue;
        }
        
        fallbacktargets[ fallbacktargets.size ] = node;
    }
    
    besttarget = undefined;
    bestdelta = undefined;
    
    if ( idealtargets.size > 0 )
    {
        foreach ( node in idealtargets )
        {
            dist = distance2d( node.origin, self.origin );
            delta = abs( dist - idealmidpoint );
            
            if ( !isdefined( bestdelta ) || delta < bestdelta )
            {
                bestdelta = delta;
                besttarget = node;
            }
        }
    }
    else if ( fallbacktargets.size > 0 )
    {
        foreach ( node in fallbacktargets )
        {
            dist = distance2d( node.origin, self.origin );
            
            if ( dist < var_4ef5391b265b27ac )
            {
                delta = var_4ef5391b265b27ac - dist;
            }
            else
            {
                delta = dist - var_a78f4e37e17d8c6;
            }
            
            if ( !isdefined( bestdelta ) || delta < bestdelta )
            {
                bestdelta = delta;
                besttarget = node;
            }
        }
    }
    
    if ( isdefined( besttarget ) || !var_4084e963af9ed72e || level.br_circle_disabled )
    {
        return besttarget;
    }
    
    var_310d579bedec6a5f = 0;
    
    foreach ( node in activelocations )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > paramstruct.maxrange || dist < paramstruct.minrange )
        {
            continue;
        }
        
        var_4d410ddbe3d207be = br_circle::getmintimetillpointindangercircle( node.origin );
        
        if ( var_4d410ddbe3d207be > var_310d579bedec6a5f )
        {
            var_310d579bedec6a5f = var_4d410ddbe3d207be;
            besttarget = node;
        }
    }
    
    return besttarget;
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0x2d539f70, Offset: 0x12f9
// Size: 0x9e
function function_36f418a8c3f17fed( range, var_5b92e8936f0baf0 )
{
    if ( level.br_circle_disabled )
    {
        return range;
    }
    
    circleindex = level.br_circle.circleindex;
    
    if ( !isdefined( var_5b92e8936f0baf0 ) )
    {
        var_5b92e8936f0baf0 = level.timedrun_quest.var_5b92e8936f0baf0;
    }
    
    if ( !isdefined( circleindex ) || circleindex < 1 || !isdefined( var_5b92e8936f0baf0 ) )
    {
        return range;
    }
    
    rangescalar = var_5b92e8936f0baf0[ circleindex ] ?? 1;
    adjustedrange = range * rangescalar;
    return adjustedrange;
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0xaac2ed57, Offset: 0x13a0
// Size: 0x1d4
function function_d0e544e5c9698c43()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( distance( player.origin, self.kiosk.origin ) < level.timedrun_quest.radius )
            {
                rewards = br_contract_manager::function_7d7e225a8f9c9222( "timedrun", self.kiosk, self.team, self );
                
                if ( self.kiosk.b_force_disabled )
                {
                    self.kiosk.b_force_disabled = 0;
                }
                
                if ( isdefined( rewards ) && isdefined( rewards[ "plunder" ] ) )
                {
                    br_contract_manager::function_1f816e3c3465df7e( "br_timedrun_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "timedrun" ), rewards[ "plunder" ] );
                }
                
                if ( game_utility::getgametype() == "plunder" )
                {
                    level thread br_public::brleaderdialogteam( "mission_timedrun_success_plunder", self.team, 1, 1, undefined, "dx_br_spct_" );
                }
                else
                {
                    level thread br_public::brleaderdialogteam( "mission_timedrun_success", self.team, 1, 1, undefined, "dx_br_spct_" );
                }
                
                self.rewardmodifier = undefined;
                self.result = "success";
                thread quest_end( 1, rewards, "Win" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0xdda86d06, Offset: 0x157c
// Size: 0xf4
function function_71340eb2802f12d7()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    self waittill( #"hash_9995336dbd416813" );
    rewards = br_contract_manager::function_7d7e225a8f9c9222( "timedrun", self.kiosk, self.team, self );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        br_contract_manager::function_1f816e3c3465df7e( "br_timedrun_quest_complete", br_contract_manager::function_e01c7810f3c75f0b( "timedrun" ), rewards[ "plunder" ] );
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        level thread br_public::brleaderdialogteam( "mission_timedrun_success_plunder", self.team, 1, 1, undefined, "dx_br_spct_" );
    }
    else
    {
        level thread br_public::brleaderdialogteam( "mission_timedrun_success", self.team, 1, 1, undefined, "dx_br_spct_" );
    }
    
    self.rewardmodifier = undefined;
    self.result = "success";
    thread quest_end( 1, rewards, "Win" );
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0xcb74b684, Offset: 0x1678
// Size: 0x79, Type: bool
function quest_oninit()
{
    kiosk = self.tablet function_774cc94bbee4831d( level.timedrun_quest );
    
    if ( !isdefined( kiosk ) )
    {
        return false;
    }
    
    if ( !isdefined( kiosk.timedruntablets ) )
    {
        kiosk.timedruntablets = [];
    }
    
    kiosk.timedruntablets[ kiosk.timedruntablets.size ] = self.tablet;
    self.kiosk = kiosk;
    return true;
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0x24718d13, Offset: 0x16fa
// Size: 0x3, Type: bool
function quest_onshowagain()
{
    return false;
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0x4480da5d, Offset: 0x1706
// Size: 0x2ad
function quest_onteamassigned()
{
    if ( !self.kiosk || self.kiosk.b_force_disabled || self.kiosk.disabled )
    {
        self.kiosk = self.tablet function_774cc94bbee4831d( level.timedrun_quest );
    }
    
    if ( isdefined( self.kiosk.timedruntablets ) )
    {
        self.kiosk.timedruntablets = arrayremove( self.kiosk.timedruntablets, self.tablet );
    }
    else
    {
        /#
            assertmsg( "<dev string:x2b>" );
            logstring( "<dev string:x54>" );
        #/
        
        br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "NoTargetError" );
        return;
    }
    
    if ( !isdefined( self.kiosk.activetasks ) )
    {
        self.kiosk.activetasks = [];
    }
    
    self.kiosk.activetasks[ self.kiosk.activetasks.size ] = self;
    self.category = "timedrun";
    br_contract_manager::function_87e10a6e85d45d58( "timedrun" );
    time = level.timedrun_quest.questmaxtime;
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    br_contract_manager::function_5c7e547ccc13711b( "br_timedrun_quest_start_team_notify" );
    
    if ( game_utility::getgametype() == "plunder" )
    {
        level thread br_public::brleaderdialogteam( "mission_timedrun_accept_plunder", self.team, 1, 1, undefined, "dx_br_spct_" );
    }
    else
    {
        level thread br_public::brleaderdialogteam( "mission_timedrun_accept", self.team, 1, 1, undefined, "dx_br_spct_" );
    }
    
    forwardvector = anglestoforward( self.kiosk.angles );
    self.curorigin = self.kiosk.origin + forwardvector * 12;
    br_contract_manager::createquestobjicon( "ui_map_icon_obj_supplyrun", "current", self.curorigin + ( 0, 0, 65 ) );
    thread timedrun_finishlinevfx( self.curorigin, self.team );
    objectiveid = self.objectiveiconid;
    objective_removeallfrommask( objectiveid );
    br_contract_manager::function_b6def068f44f04c9( objectiveid, self.team );
    
    if ( level.timedrun_quest.var_5503ee709e8dec0c )
    {
        thread function_d0e544e5c9698c43();
        return;
    }
    
    thread function_71340eb2802f12d7();
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x278649fc, Offset: 0x19bb
// Size: 0x46
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
        }
    }
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x2dc8a678, Offset: 0x1a09
// Size: 0x46
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
        }
    }
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0xbb35fcb4, Offset: 0x1a57
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    timedrun_playerremoved( victim );
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x1d2a56a6, Offset: 0x1a7d
// Size: 0x15
function function_22116566150b5d1( victim )
{
    timedrun_playerremoved( victim );
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0xdd08a387, Offset: 0x1a9a
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    timedrun_playerremoved( player );
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0xc717d7c8, Offset: 0x1ab7
// Size: 0x6e
function timedrun_playerremoved( player )
{
    if ( player.team == self.team )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.team, filter ) )
        {
            quest_end( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0xf0cf61e9, Offset: 0x1b2d
// Size: 0x145
function function_c1da596d8ee1a90a( var_b7aa92c3b872e5e0 )
{
    allkiosks = br_armory_kiosk::getbuystations();
    
    foreach ( kiosk in allkiosks )
    {
        if ( utility::is_origin_in_area_swap( kiosk.origin, var_b7aa92c3b872e5e0.swapname, var_b7aa92c3b872e5e0.swapstate ) )
        {
            kiosk.timedruntablets = function_5713d46873b29625( kiosk.timedruntablets );
            
            foreach ( tablet in kiosk.timedruntablets )
            {
                tablet thread br_contract_manager::tablethide( 1 );
            }
        }
    }
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0x33d276f8, Offset: 0x1c7a
// Size: 0x60, Type: bool
function function_67b529e129462fe2()
{
    if ( isdefined( self.kiosk ) && isdefined( self.tablet ) )
    {
        self.kiosk.timedruntablets = arrayremove( self.kiosk.timedruntablets, self.tablet );
    }
    
    self.kiosk = undefined;
    return quest_oninit();
}

// Namespace br_timedrun_quest
// Params 1
// Checksum 0x7199c4a5, Offset: 0x1ce3
// Size: 0x29
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        quest_end( 0, undefined, "Cancel" );
    }
}

// Namespace br_timedrun_quest
// Params 3
// Checksum 0x188ce7dc, Offset: 0x1d14
// Size: 0xb7
function quest_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objective_removeclientfrommask( self.objectiveiconid, player );
        }
        
        player br_contract_manager::uiobjectivehide();
        
        if ( !br_quest_util::isteamvalid( self.team, level.contractmanager.defaultfilter ) )
        {
            playersonteam = teams::getteamdata( self.team, "players" );
            thread quest_end( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace br_timedrun_quest
// Params 3
// Checksum 0xcec8522b, Offset: 0x1dd3
// Size: 0x7d
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( newteam == self.team )
    {
        player br_contract_manager::uiobjectiveshow( "timedrun" );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        
        if ( isdefined( self.objectiveiconid ) && self.objectiveiconid != -1 )
        {
            objective_addclienttomask( self.objectiveiconid, player );
        }
    }
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0x890909ee, Offset: 0x1e58
// Size: 0xaa
function function_70034271e970d006( dangercircleorigin, var_1bdc861911b3625e )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    if ( isdefined( self.kiosk ) )
    {
        if ( !br_circle_util::ispointindangercircle( self.kiosk.origin ) )
        {
            self.var_b6c5eeeebd9383f5 = 1;
            params = spawnstruct();
            params.intvar = 0;
            br_contract_manager::function_5c7e547ccc13711b( "br_timedrun_quest_circle_failure", params );
            level thread br_public::brleaderdialogteam( "mission_timedrun_fail_circle", self.team, 1, 2 );
            quest_end( 0, undefined, "Circle" );
        }
    }
}

// Namespace br_timedrun_quest
// Params 3
// Checksum 0x9a159eeb, Offset: 0x1f0a
// Size: 0xbd
function function_1be7c59a593161bc( contract, instance, team )
{
    playersonteam = teams::getteamdata( team, "players" );
    rewards = contract br_contract_manager::function_7d7e225a8f9c9222( "timedrun", self.kiosk, team, contract, contract.capturingplayer.sessionsquadid );
    
    if ( isdefined( rewards[ "plunder" ] ) )
    {
        splashref = br_contract_manager::function_7c9586992cf68ed1( "br_timedrun_quest_complete" );
        contract br_contract_manager::function_1f816e3c3465df7e( splashref, br_contract_manager::function_e01c7810f3c75f0b( "timedrun" ), rewards[ "plunder" ] );
    }
    
    contract thread quest_end( 1, rewards, "Win" );
}

// Namespace br_timedrun_quest
// Params 0
// Checksum 0x8ba78851, Offset: 0x1fcf
// Size: 0x5b
function function_88679453542a90b3()
{
    params = spawnstruct();
    params.intvar = 0;
    br_contract_manager::function_5c7e547ccc13711b( "br_timedrun_quest_timer_expired", params );
    level thread br_public::brleaderdialogteam( "mission_timedrun_fail_time", self.team, 1, 1, undefined, "dx_br_spct_" );
    thread quest_end( 0, undefined, "Time" );
}

// Namespace br_timedrun_quest
// Params 6
// Checksum 0xd100a91d, Offset: 0x2032
// Size: 0x143
function function_22da77ca8dba4295( instance, part, state, player, bautouse, usestring )
{
    instance endon( #"death" );
    
    if ( self.team == player.team )
    {
        if ( !isdefined( instance.hacking ) )
        {
            instance.hacking = 1;
        }
        else
        {
            return 1;
        }
        
        if ( isstring( level.timedrun_quest.timedrun_gesture ) )
        {
            deployresult = player br_contract_manager::function_14a772eecc5cf7d1( makeweapon( level.timedrun_quest.timedrun_gesture ), undefined, level.timedrun_quest.var_eeccb0f33daf68f2 );
            instance.hacking = undefined;
        }
        else
        {
            deployresult = player br_contract_manager::function_14a772eecc5cf7d1( level.timedrun_quest.timedrun_gesture, undefined, level.timedrun_quest.var_eeccb0f33daf68f2 );
            instance.hacking = undefined;
        }
        
        if ( deployresult )
        {
            self notify( #"hash_9995336dbd416813" );
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace br_timedrun_quest
// Params 3
// Checksum 0x72695a11, Offset: 0x217d
// Size: 0xcf
function quest_end( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    self.kiosk.activetasks = arrayremove( self.kiosk.activetasks, self );
    br_contract_manager::deletequestobjicon();
    
    if ( isdefined( self.finishlinevfx ) )
    {
        thread function_72fefa9e7d41c11f( level.timedrun_quest.var_880bf5ccc1b62680, self.finishlinevfx );
    }
    
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0x37d43cf4, Offset: 0x2254
// Size: 0xfa
function timedrun_finishlinevfx( spawn_origin, team )
{
    finishlinevfx = spawnfx( level._effect[ "vfx_marker_base_orange_pulse" ], spawn_origin + ( 0, 0, 10 ) );
    finishlinevfx.angles = vectortoangles( ( 0, 0, 1 ) );
    finishlinevfx hide();
    wait 0.5;
    triggerfx( finishlinevfx );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        finishlinevfx showtoplayer( player );
    }
    
    self.finishlinevfx = finishlinevfx;
}

// Namespace br_timedrun_quest
// Params 2
// Checksum 0x93b05f9d, Offset: 0x2356
// Size: 0x25
function function_72fefa9e7d41c11f( delay, vfx )
{
    wait delay;
    
    if ( isdefined( vfx ) )
    {
        vfx delete();
    }
}

