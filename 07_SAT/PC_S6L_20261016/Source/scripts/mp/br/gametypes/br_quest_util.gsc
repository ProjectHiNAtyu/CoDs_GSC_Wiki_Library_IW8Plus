// scripts\mp\br\gametypes\br_quest_util.gsc  (hash_651411145972e333.gscc) (size: 71811 Bytes / 0x11883 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x854f3420 (2236560416)
// size ...... 71811 (0x11883)
// includes .. 41  (offset: 0x10913)
// strings ... 112 (offset: 0x10a5b)
// dev strs .. 135 (offset: 0x11157)
// exports ... 222 (offset: 0xb967)
// cseg ...... 0xb2a + 0xae3d (0xb967)
// imports ... 344 (offset: 0xdc17)
// animtree1 . 0   (offset: 0x11883)
// animtree2 . 0   (offset: 0x11883)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_blueprint_extract_spawn;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_callouts;
#using scripts\mp\br\gametypes\br_challenges;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_common_kiosk;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_quest_util;

// Namespace br_quest_util
// Params 0
// Checksum 0xa18e6ead, Offset: 0xb48
// Size: 0x596
function init_quest_util()
{
    if ( !getdvarint( @"scr_br_quests_enabled", 1 ) )
    {
        return;
    }
    
    if ( common_item::items_isenabled() )
    {
        common_item::function_4b30c091d3b04a25( "activitystarter" );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"use", &function_e53aaf28ba448bcf );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"canautouse", &function_646e596034672318 );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"hash_9e49dfaa7c147654", &function_190d28195fb735f5 );
    }
    
    level.questinfo = spawnstruct();
    level.questinfo.quests = [];
    level.questinfo.thinkers = [];
    level.questinfo.tabletinfo = [];
    level.questinfo.teamsonquests = [];
    level.questinfo.thinkindex = 0;
    level.questinfo.tablevalues = [];
    level.questinfo.rewards = spawnstruct();
    level.questinfo.rewards.categorytogroup = [];
    level.questinfo.rewards.grouptorewards = [];
    level.questinfo.rewards.rewardtotype = [];
    level.questinfo.rewards.rewardtovalue = [];
    level.questinfo.tiers = [];
    level.questinfo.unlockables = [];
    
    /#
        level.questinfo.debuginfo = spawnstruct();
        var_b2cc2ca012894c63[ 0 ] = "<dev string:x24>";
        var_b2cc2ca012894c63[ 1 ] = "<dev string:x2f>";
        var_b2cc2ca012894c63[ 2 ] = "<dev string:x40>";
        var_b2cc2ca012894c63[ 3 ] = "<dev string:x51>";
        var_67e773d49335d70c = [];
        var_67e773d49335d70c[ "<dev string:x64>" ] = 0;
        
        foreach ( bit, str in var_b2cc2ca012894c63 )
        {
            var_67e773d49335d70c[ str ] = 1 << bit;
            var_67e773d49335d70c[ "<dev string:x64>" ] = var_67e773d49335d70c[ "<dev string:x64>" ] | 1 << bit;
        }
        
        var_67e773d49335d70c[ "<dev string:x68>" ] = var_67e773d49335d70c[ "<dev string:x24>" ] | var_67e773d49335d70c[ "<dev string:x2f>" ] | var_67e773d49335d70c[ "<dev string:x40>" ];
        level.questinfo.debuginfo.var_b2cc2ca012894c63 = var_b2cc2ca012894c63;
        level.questinfo.debuginfo.var_67e773d49335d70c = var_67e773d49335d70c;
        level.questinfo.debuginfo.var_f3009cb67d6c01fa = 0;
    #/
    
    level.questinfo.defaultfilter = [];
    level.questinfo.defaultfilter[ 0 ] = &filtercondition_isdead;
    level.questinfo.defaultfilter[ 1 ] = &filtercondition_ingulag;
    level.questinfo.getactiveforteam = &getallactivequestsforteam;
    br_circle::registercirclecallbacks( 7, &dangercircletick );
    
    if ( br_gametypes::isfeaturedisabled( #"brquests" ) )
    {
        return;
    }
    
    loadtables();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    br_blueprint_extract_spawn::init();
    
    if ( getdvarint( @"hash_b91a7ebb801d5968", 1 ) == 1 )
    {
        br_bunker_utility::disablelootbunkercachelocations();
    }
    
    if ( getdvarint( @"hash_fd6b014836f663e0", 1 ) == 1 )
    {
        br_bunker_utility::disablebunker11cachelocations();
    }
    
    thread inittablets();
    thread setupcirclepeek();
    assert( isdefined( game[ "<dev string:x77>" ] ) );
    game[ "dialog" ][ "mission_gen_accept" ] = "mission_mission_gen_accept";
    game[ "dialog" ][ "mission_misc_success" ] = "contract_misc_success";
    game[ "dialog" ][ "mission_obj_change" ] = "mission_mission_obj_change";
    game[ "dialog" ][ "mission_obj_moved" ] = "mission_mission_obj_moved";
    game[ "dialog" ][ "mission_obj_next_ptarget" ] = "mission_mission_obj_next_ptarget";
    game[ "dialog" ][ "mission_obj_next_nptarget" ] = "mission_mission_obj_next_nptarget";
    game[ "dialog" ][ "mission_obj_warning_time" ] = "mission_mission_obj_warning_time";
    game[ "dialog" ][ "mission_obj_warning_capture" ] = "mission_mission_obj_warning_capture";
    game[ "dialog" ][ "mission_obj_circle_fail" ] = "mission_mission_obj_circle_fail";
    game[ "dialog" ][ "mission_gen_fail" ] = "mission_mission_gen_fail";
    game[ "dialog" ][ "mission_teammate_down" ] = "mission_teammate_down";
    game[ "dialog" ][ "mission_enemy_down" ] = "mission_enemy_down";
    level._effect[ "vfx_dom_flare" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_dom" );
    level._effect[ "vfx_revive_flare" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_revive" );
    level._effect[ "vfx_smktrail_mortar" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_smktrail" );
    level._effect[ "vfx_marker_base_orange_pulse" ] = loadfxasset( "vfx_iw8_br_gameplay_tr_marker" );
    level.brmodevariantrewardcullfunc = undefined;
    callback::add( #"hash_a79b57f79ff15caa", &function_3d9395d13234bae6 );
    
    /#
        level.questinfo thread init_quest_debug();
    #/
}

// Namespace br_quest_util
// Params 1
// Checksum 0x4d7a3ddc, Offset: 0x10e6
// Size: 0x83
function function_3d9395d13234bae6( params )
{
    instance = params.instance;
    script::demoforcesre( "pickups::lootGetScriptableName is deprecated." );
    scriptablename = undefined;
    
    if ( isdefined( scriptablename ) && ( br_pickups::isquesttablet( scriptablename ) || br_contract_manager::function_ef612fee431a6a0a( instance ) ) )
    {
        if ( flags::gameflag( "prematch_done" ) )
        {
            level notify( "tablethide_kill_callout_" + instance.origin );
        }
        
        br_contract_manager::oncontracttablethide( instance );
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x466bb590, Offset: 0x1171
// Size: 0x11b
function loadtables()
{
    for ( row = 0; true ; row++ )
    {
        unlockableindex = tablelookupbyrow( "mp/brmission_unlockables.csv", row, 0 );
        
        if ( !isdefined( unlockableindex ) || unlockableindex == "" )
        {
            break;
        }
        
        if ( int( tablelookup( "mp/brmission_unlockables.csv", 0, unlockableindex, 3 ) ) == 1 )
        {
            continue;
        }
        
        unlockabledata = spawnstruct();
        unlockabledata.unlockableindex = int( unlockableindex );
        unlockabledata.lootid = int( tablelookup( "mp/brmission_unlockables.csv", 0, unlockableindex, 1 ) );
        unlockabledata.extractunlockablechance = int( tablelookup( "mp/brmission_unlockables.csv", 0, unlockableindex, 2 ) );
        assert( isdefined( unlockabledata.unlockableindex ) );
        assert( isdefined( unlockabledata.lootid ) );
        assert( isdefined( unlockabledata.extractunlockablechance ) );
        level.questinfo.unlockables[ unlockabledata.lootid ] = unlockabledata;
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0xefdb207d, Offset: 0x1294
// Size: 0x8c4
function inittablets()
{
    level.questinfo.activetablets = [];
    
    /#
        level.questinfo.debuginfo.var_8bb4f24fb0a12f10 = [];
        
        foreach ( type, info in level.questinfo.tabletinfo )
        {
            level.questinfo.debuginfo.var_8bb4f24fb0a12f10[ type ] = 0;
            level.questinfo.debuginfo.var_9a7f8051bbb7d16c[ type ] = 0;
        }
        
        level.questinfo.debuginfo.tabletsused = 0;
        level.questinfo.debuginfo.var_acbbb03b6cda49e9 = 0;
        level.questinfo.debuginfo.locationtablets = [];
    #/
    
    hidepercent = getdvarfloat( @"hash_4ec62b4599196026", 0.667 );
    hiddentablets = [];
    
    foreach ( type, info in level.questinfo.tabletinfo )
    {
        lootname = getlootname( type );
        tablets = getlootscriptablearray( lootname );
        
        if ( !info.enabled )
        {
            continue;
        }
        
        var_57990374e7137981 = getdvarfloat( @"hash_8d46517b8da8688", 1200 );
        
        if ( var_57990374e7137981 > 0 )
        {
            if ( !common_kiosk::function_5274212108b240d3() )
            {
                numdisabled = 0;
                
                foreach ( kiosk in level.br_armory_kiosk.scriptables )
                {
                    closetablets = getlootscriptablearrayinradius( lootname, undefined, kiosk.origin, var_57990374e7137981 );
                    
                    foreach ( closetablet in closetablets )
                    {
                        if ( closetablet.startdisabled )
                        {
                            continue;
                        }
                        
                        closetablet.startdisabled = 1;
                        numdisabled++;
                    }
                }
                
                for ( i = tablets.size - 1; i >= 0 && numdisabled ; i-- )
                {
                    if ( tablets[ i ].startdisabled )
                    {
                        tablets[ i ] = tablets[ tablets.size - 1 ];
                        tablets[ tablets.size - 1 ] = undefined;
                        numdisabled--;
                    }
                }
            }
        }
        
        for ( i = tablets.size - 1; i >= 0 ; i-- )
        {
            tablet = tablets[ i ];
            tablet tabletinit( type );
            
            if ( !tablet.init )
            {
                tablets[ i ].startdisabled = 1;
                tablets[ i ] = tablets[ tablets.size - 1 ];
                tablets[ tablets.size - 1 ] = undefined;
            }
        }
        
        if ( tablets.size )
        {
            setobjectivetypesomvarbit( type );
        }
        
        var_cdf758dee1735293 = tablets.size * hidepercent;
        var_80a9edfd2aa7a3ff = int( var_cdf758dee1735293 );
        extrachance = var_cdf758dee1735293 - var_80a9edfd2aa7a3ff;
        
        if ( randomfloat( 1 ) < extrachance )
        {
            var_80a9edfd2aa7a3ff++;
        }
        
        for ( i = 0; i < var_80a9edfd2aa7a3ff ; i++ )
        {
            randindex = randomintrange( 0, tablets.size );
            tablet = tablets[ randindex ];
            tablets[ randindex ].startdisabled = 1;
            hiddentablets[ hiddentablets.size ] = tablets[ randindex ];
            tablets[ randindex ] = tablets[ tablets.size - 1 ];
            tablets[ tablets.size - 1 ] = undefined;
        }
    }
    
    zones = getarraykeys( level.calloutglobals.namelocations );
    var_874836a3bba883af = [];
    locationmin = getdvarint( @"hash_96db0b0e9378ad40", 1 );
    
    if ( locationmin > 0 )
    {
        foreach ( zone in zones )
        {
            var_874836a3bba883af[ zone ] = locationmin;
            
            /#
                level.questinfo.debuginfo.locationtablets[ zone ] = [];
            #/
        }
    }
    
    totalquests = 0;
    
    foreach ( type, info in level.questinfo.tabletinfo )
    {
        tablets = getlootscriptablearray( getlootname( type ) );
        totalquests += tablets.size;
        
        if ( info.enabled )
        {
            foreach ( tablet in tablets )
            {
                if ( tablet.startdisabled )
                {
                    tablet tablethide();
                    continue;
                }
                
                tablet tabletshow();
                
                if ( var_874836a3bba883af.size > 0 )
                {
                    tabletzone = br_callouts::getlocationnameforpoint( tablet.origin );
                    
                    if ( isdefined( var_874836a3bba883af[ tabletzone ] ) )
                    {
                        /#
                            var_ab27321c91222845 = level.questinfo.debuginfo.locationtablets[ tabletzone ].size;
                            level.questinfo.debuginfo.locationtablets[ tabletzone ][ var_ab27321c91222845 ] = tablet;
                        #/
                        
                        var_874836a3bba883af[ tabletzone ]--;
                        
                        if ( !var_874836a3bba883af[ tabletzone ] )
                        {
                            var_874836a3bba883af[ tabletzone ] = undefined;
                        }
                    }
                }
            }
            
            continue;
        }
        
        foreach ( tablet in tablets )
        {
            tablet tablethide();
        }
    }
    
    if ( var_874836a3bba883af.size )
    {
        hiddentablets = arrayrandomize( hiddentablets );
        
        for ( i = 0; i < hiddentablets.size ; i++ )
        {
            tablet = hiddentablets[ i ];
            tabletzone = br_callouts::getlocationnameforpoint( tablet.origin );
            
            if ( isdefined( var_874836a3bba883af[ tabletzone ] ) )
            {
                tablet tabletshow();
                
                /#
                    var_ab27321c91222845 = level.questinfo.debuginfo.locationtablets[ tabletzone ].size;
                    level.questinfo.debuginfo.locationtablets[ tabletzone ][ var_ab27321c91222845 ] = tablet;
                #/
                
                var_874836a3bba883af[ tabletzone ]--;
                
                if ( !var_874836a3bba883af[ tabletzone ] )
                {
                    var_874836a3bba883af[ tabletzone ] = undefined;
                    
                    if ( !var_874836a3bba883af.size )
                    {
                        break;
                    }
                }
            }
        }
    }
    
    activequests = level.questinfo.activetablets.size;
    hiddenquests = hiddentablets.size;
    br_analytics::branalytics_inittablets( totalquests, activequests, hiddenquests, hidepercent );
    
    if ( br_gametypes::isfeatureenabled( #"tabletreplace" ) )
    {
        thread tabletreplace( hiddentablets );
        return;
    }
    
    thread delayedshowtablets( hiddentablets );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x155d9a4e, Offset: 0x1b60
// Size: 0x4b
function setobjectivetypesomvarbit( type )
{
    index = getquestindex( type );
    assert( index < 32, "<dev string:x7e>" + type + "<dev string:x8a>" );
    function_a9a8165656e26139( "ui_br_objective_types", index, 1, 1 );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xdbfbce49, Offset: 0x1bb3
// Size: 0xd0
function tabletreplace( hiddentablets )
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    hiddentablets = arrayrandomize( hiddentablets );
    var_5368e009f37fca29 = 0;
    var_fb7aaa2eb6f53014 = level.tabletreplacefrequency;
    
    for ( i = 0; i < hiddentablets.size ; i++ )
    {
        tablet = hiddentablets[ i ];
        level waittill( #"quest_started" );
        
        if ( isdefined( level.tabletreplacefrequency ) && level.tabletreplacefrequency != -1 )
        {
            var_5368e009f37fca29++;
            
            if ( var_5368e009f37fca29 >= var_fb7aaa2eb6f53014 )
            {
                tablet tabletshow();
                var_fb7aaa2eb6f53014 += level.tabletreplacefrequency;
                i++;
            }
            
            continue;
        }
        
        tablet tabletshow();
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x97c1e618, Offset: 0x1c8b
// Size: 0x23a
function delayedshowtablets( hiddentablets )
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    lastcircle = level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"hash_96878da693689ccd", 4 );
    showpercent = getdvarfloat( @"hash_743253d28cd0d1f7", 0.3 );
    flags::gameflagwait( "prematch_done" );
    validtablets = [];
    
    for ( i = 0; i < hiddentablets.size ; i++ )
    {
        tablet = hiddentablets[ i ];
        tablet.circleindex = br_circle::getcircleindexforpoint( tablet.origin );
        
        if ( tablet.circleindex >= 0 )
        {
            validtablets[ validtablets.size ] = tablet;
        }
    }
    
    hiddentablets = arrayrandomize( validtablets );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        if ( !level.br_circle.circleindex )
        {
            br_analytics::branalytics_delayedshowtablets( 0, showpercent, validtablets.size, 0 );
            continue;
        }
        
        validtablets = [];
        
        for ( i = 0; i < hiddentablets.size ; i++ )
        {
            tablet = hiddentablets[ i ];
            
            if ( tablet.circleindex >= level.br_circle.circleindex )
            {
                validtablets[ validtablets.size ] = tablet;
            }
        }
        
        showcount = int( ceil( validtablets.size * showpercent ) );
        var_e5702e20fac1982c = int( max( 0, getdvarint( @"hash_6cd10c5d6e2a6220", 100 ) - level.questinfo.activetablets.size ) );
        showcount = int( min( showcount, var_e5702e20fac1982c ) );
        
        for ( i = 0; i < showcount ; i++ )
        {
            tablet = validtablets[ i ];
            tablet tabletshow();
        }
        
        hiddentablets = [];
        
        for ( i = showcount; i < validtablets.size ; i++ )
        {
            hiddentablets[ hiddentablets.size ] = validtablets[ i ];
        }
        
        br_analytics::branalytics_delayedshowtablets( level.br_circle.circleindex, showpercent, validtablets.size, showcount );
        
        if ( level.br_circle.circleindex >= lastcircle )
        {
            break;
        }
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x403e4cfb, Offset: 0x1ecd
// Size: 0x110
function disablealltablets()
{
    foreach ( type, info in level.questinfo.tabletinfo )
    {
        tablets = getlootscriptablearray( getlootname( type ) );
        
        if ( info.enabled )
        {
            foreach ( tablet in tablets )
            {
                tablet tablethide();
            }
        }
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0xbbb4e995, Offset: 0x1fe5
// Size: 0x9
function tablethide()
{
    thread _tablethide();
}

// Namespace br_quest_util
// Params 0
// Checksum 0xe80dd425, Offset: 0x1ff6
// Size: 0x22
function _tablethide()
{
    self endon( #"show" );
    flags::gameflagwait( "prematch_done" );
    pickups::loothide( self );
}

// Namespace br_quest_util
// Params 0
// Checksum 0x82689a32, Offset: 0x2020
// Size: 0xc0
function tabletshow()
{
    assert( isdefined( self.init ) );
    self notify( #"show" );
    part = self.type;
    self setscriptablepartstate( part, "visible" );
    level.questinfo.activetablets[ string( self.index ) ] = self;
    br_analytics::branalytics_spawntablet( self );
    
    /#
        level.questinfo.debuginfo.var_8bb4f24fb0a12f10[ self.tablettype ]++;
        level.questinfo.debuginfo.var_9a7f8051bbb7d16c[ self.tablettype ]++;
    #/
}

// Namespace br_quest_util
// Params 1
// Checksum 0x6ca00124, Offset: 0x20e8
// Size: 0x8b
function tabletinit( type )
{
    if ( isdefined( self.init ) )
    {
        return;
    }
    
    self.init = 1;
    self.tablettype = type;
    tabletinit = level.questinfo.quests[ type ].funcs[ "tabletInit" ];
    
    if ( isdefined( tabletinit ) )
    {
        self.init = self [[ tabletinit ]]();
        
        if ( !self.init )
        {
            br_analytics::branalytics_invalidtablet( self );
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x12976086, Offset: 0x217b
// Size: 0x83
function onquesttablethide( instance )
{
    if ( isdefined( level.questinfo.activetablets[ string( instance.index ) ] ) )
    {
        /#
            level.questinfo.debuginfo.var_8bb4f24fb0a12f10[ instance.tablettype ]--;
        #/
        
        level.questinfo.activetablets[ string( instance.index ) ] = undefined;
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0xa0805e54, Offset: 0x2206
// Size: 0x5f
function activatetablet( instance )
{
    /#
        level.questinfo.debuginfo.var_8bb4f24fb0a12f10[ instance.tablettype ]++;
    #/
    
    level.questinfo.activetablets[ string( instance.index ) ] = instance;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x4073f197, Offset: 0x226d
// Size: 0x28
function getlootname( category )
{
    lootname = "brloot_" + category + "_tablet";
    return lootname;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x5484a05e, Offset: 0x229e
// Size: 0xae
function registerteamonquest( team, player )
{
    /#
        function_9b63c0e88a433955();
    #/
    
    br_analytics::branalytics_missionstart( self, player );
    level.questinfo.teamsonquests[ level.questinfo.teamsonquests.size ] = team;
    
    if ( !isdefined( level.questinfo.maxperkbonustier ) )
    {
        level.questinfo.maxperkbonustier = [];
    }
    
    level.questinfo.maxperkbonustier[ team ] = getquestperkbonus( team, 1 );
    level notify( #"quest_started", team );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xbfb000b7, Offset: 0x2354
// Size: 0x604
function releaseteamonquest( team )
{
    assert( arraycontains( level.questinfo.teamsonquests, team ), "<dev string:x9b>" + team + "<dev string:xcd>" );
    
    /#
        function_9b63c0e88a433955();
    #/
    
    if ( isdefined( level.questinfo.maxperkbonustier ) )
    {
        level.questinfo.maxperkbonustier[ team ] = undefined;
    }
    
    level.questinfo.teamsonquests = arrayremove( level.questinfo.teamsonquests, team );
    questtier = getquestrewardtier( team );
    results = [];
    
    if ( self.result == "success" )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( isbot( player ) && br_public::istutorial() )
            {
                continue;
            }
            
            player.brmissionscompleted = utility::get_int_or_0( player.brmissionscompleted ) + 1;
            
            if ( level.var_4d2ffb649fcef6ea )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "objectivesCompleted" ] ) )
                    {
                        player.leaderboarddata[ "objectivesCompleted" ] = player.leaderboarddata[ "objectivesCompleted" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objectivesCompleted" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objectivesCompleted" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xcf>" );
                    
                    if ( isdefined( player.pers[ "objectivesCompleted" ] ) )
                    {
                        player.pers[ "objectivesCompleted" ] = player.pers[ "objectivesCompleted" ] + 1;
                    }
                }
                
                player br_public::updatebrscoreboardstat( "missionsCompleted", player.pers[ "objectivesCompleted" ] );
            }
            else
            {
                player br_public::updatebrscoreboardstat( "missionsCompleted", player.brmissionscompleted );
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "contracts" ] ) )
                {
                    player.leaderboarddata[ "contracts" ] = player.leaderboarddata[ "contracts" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "contracts" ] ) )
                {
                    [[ level.leaderboardfunc[ "contracts" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xcf>" );
                
                if ( isdefined( player.pers[ "contracts" ] ) )
                {
                    player.pers[ "contracts" ] = player.pers[ "contracts" ] + 1;
                }
            }
            
            if ( !isdefined( player.brmissiontypescompleted ) )
            {
                player.brmissiontypescompleted = [];
            }
            
            player.brmissiontypescompleted[ self.questcategory ] = utility::get_int_or_0( player.brmissiontypescompleted[ self.questcategory ] ) + 1;
            player br_challenges::challengeevaluator( "br_mastery_fiveContracts" );
        }
    }
    
    if ( isdefined( self.result ) )
    {
        teamresult = self.result == "success" ? 1 : 2;
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( isbot( player ) && br_public::istutorial() )
            {
                continue;
            }
            
            contractid = br_contract_manager::getquesttableindex( self.category );
            challenges::function_84e8396c49d7b89d( player, contractid, teamresult == 1, 1 );
            player notify( #"hash_fe8368d98cacf961" );
        }
        
        if ( isdefined( self.targetteam ) )
        {
            targetresult = self.result == "success" ? 2 : 1;
            
            foreach ( player in teams::getteamdata( self.targetteam, "players" ) )
            {
                if ( isbot( player ) && br_public::istutorial() )
                {
                    continue;
                }
                
                contractid = br_contract_manager::getquesttableindex( self.category );
                challenges::function_84e8396c49d7b89d( player, contractid, targetresult == 1, 2 );
            }
        }
    }
    
    teamplayers = teams::getteamdata( team, "players" );
    numteamplayers = teamplayers.size;
    br_analytics::branalytics_missionend( self, questtier, results, numteamplayers );
    self notify( #"questended" );
    
    if ( isdefined( self.rewardscriptable ) )
    {
        self.rewardscriptable notify( #"questended", team, self.result );
    }
}

// Namespace br_quest_util
// Params 3
// Checksum 0xdb30d9f2, Offset: 0x2960
// Size: 0xc5
function startteamcontractchallenge( category, initiatingplayer, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        contractid = br_contract_manager::getquesttableindex( category );
        challenges::function_7bc79aeb658f2606( player, contractid, initiatingplayer );
    }
}

// Namespace br_quest_util
// Params 4
// Checksum 0x66dc5f1f, Offset: 0x2a2d
// Size: 0x31, Type: bool
function function_e53aaf28ba448bcf( itembundle, item, autouse, var_981c264073bf1154 )
{
    takequesttablet( item );
    return false;
}

// Namespace br_quest_util
// Params 4
// Checksum 0xa24cb657, Offset: 0x2a67
// Size: 0x28, Type: bool
function function_646e596034672318( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace br_quest_util
// Params 4
// Checksum 0x679ff477, Offset: 0x2a98
// Size: 0x4e, Type: bool
function function_190d28195fb735f5( itembundle, item, autouse, allowswap )
{
    if ( arraycontains( level.questinfo.teamsonquests, self.team ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x62d1e717, Offset: 0x2aef
// Size: 0x3b
function takequesttablet( instance )
{
    /#
        level.questinfo.debuginfo.tabletsused++;
    #/
    
    br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
}

// Namespace br_quest_util
// Params 3
// Checksum 0xebaafa87, Offset: 0x2b32
// Size: 0x21b
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !isdefined( level.questinfo ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    
    foreach ( tablet in level.questinfo.activetablets )
    {
        if ( distance2dsquared( dangercircleorigin, tablet.origin ) > var_1bdc861911b3625e * var_1bdc861911b3625e )
        {
            /#
                level.questinfo.debuginfo.var_acbbb03b6cda49e9++;
            #/
            
            pickups::loothide( tablet );
            br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
        }
    }
    
    foreach ( quest in level.questinfo.quests )
    {
        if ( isdefined( quest.funcs[ "circleTick" ] ) )
        {
            foreach ( instance in quest.instances )
            {
                instance [[ quest.funcs[ "circleTick" ] ]]( dangercircleorigin, var_1bdc861911b3625e );
            }
        }
    }
}

// Namespace br_quest_util
// Params 4
// Checksum 0xfe61566b, Offset: 0x2d55
// Size: 0xae
function createquestinstance( category, instanceid, missionid, rewardscriptable )
{
    instance = spawnstruct();
    
    /#
        instance.debugtype = "<dev string:xf5>";
    #/
    
    instance.questcategory = category;
    instance.enabled = 1;
    instance.category = category;
    instance.id = instanceid;
    instance.missionid = string( missionid );
    instance.rewardscriptable = rewardscriptable;
    instance _assignthinkoffset();
    return instance;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xf805447a, Offset: 0x2e0c
// Size: 0xef
function addquestinstance( category, instanceinfo )
{
    assert( isdefined( level.questinfo.quests[ category ] ), "<dev string:xfe>" + category + "<dev string:xcd>" );
    
    if ( !level.questinfo.ismanagerthreadthinking )
    {
        _initmanagerquestthread();
        level.questinfo thread _questmanagerthread();
    }
    
    if ( !_isquestthreaded( category ) && isdefined( level.questinfo.quests[ category ].numthinkfuncs ) )
    {
        if ( _checkforregister( category, "initQuestVars" ) )
        {
            level.questinfo.quests[ category ] _runinitquestvars( category );
        }
        
        _runaddquestinstance( category, instanceinfo );
        _runaddquestthread( category );
        return;
    }
    
    _runaddquestinstance( category, instanceinfo );
}

// Namespace br_quest_util
// Params 0
// Checksum 0x80b903af, Offset: 0x2f03
// Size: 0xe0
function removequestinstance()
{
    /#
        function_9b63c0e88a433955();
    #/
    
    if ( self.removed )
    {
        return;
    }
    
    self.removed = 1;
    category = self.questcategory;
    assert( isdefined( level.questinfo.quests[ category ].funcs[ "<dev string:x114>" ] ), "<dev string:x123>" + category + "<dev string:x146>" );
    _runremovequestinstance( category );
    
    if ( isdefined( self.subscribedlocale ) )
    {
        leavequestlocale();
    }
    
    if ( _questinstancesactive( category ) <= 0 )
    {
        if ( _checkforregister( category, "clearQuestVars" ) )
        {
            level.questinfo.quests[ category ] _runclearquestvars( category );
        }
        
        if ( _questthreadsactive() <= 0 )
        {
            _removemanagerquestthread();
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0xb7f5ff7f, Offset: 0x2feb
// Size: 0x18, Type: bool
function isquestinstancealocale( instance )
{
    return isdefined( instance.subscribedinstances );
}

// Namespace br_quest_util
// Params 0
// Checksum 0xb4927045, Offset: 0x300c
// Size: 0x18
function _initmanagerquestthread()
{
    level.questinfo.ismanagerthreadthinking = 1;
}

// Namespace br_quest_util
// Params 0
// Checksum 0x93ad4d9b, Offset: 0x302c
// Size: 0x23
function _removemanagerquestthread()
{
    level notify( #"hash_3bfcf9b2b6511960" );
    level.questinfo.ismanagerthreadthinking = 0;
}

// Namespace br_quest_util
// Params 0
// Checksum 0xc5284841, Offset: 0x3057
// Size: 0x175
function _questmanagerthread()
{
    level endon( #"game_ended" );
    level endon( #"hash_3bfcf9b2b6511960" );
    
    for ( ;; )
    {
        wait 0.05;
        level.questinfo.thinkindex++;
        
        foreach ( questid in level.questinfo.thinkers )
        {
            if ( !level.questinfo.quests[ questid ].enabled )
            {
                continue;
            }
            
            foreach ( instance in level.questinfo.quests[ questid ].instances )
            {
                if ( instance.enabled )
                {
                    instance _runquestthinkfunctions( questid );
                }
            }
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x77c1d382, Offset: 0x31d4
// Size: 0xd4
function _runquestthinkfunctions( questid )
{
    /#
        function_9b63c0e88a433955();
    #/
    
    for ( index = 0; index < level.questinfo.quests[ questid ].numthinkfuncs ; index++ )
    {
        if ( ( level.questinfo.thinkindex - self.thinkoffset + self.firstthink ) % level.questinfo.quests[ questid ].thinkrates[ index ] == 0 )
        {
            funclabel = "questThink" + index;
            [[ level.questinfo.quests[ questid ].funcs[ funclabel ] ]]();
        }
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x6229175d, Offset: 0x32b0
// Size: 0x83
function _assignthinkoffset()
{
    /#
        function_9b63c0e88a433955();
    #/
    
    if ( !isdefined( level.questinfo.thinkoffset ) )
    {
        level.questinfo.thinkoffset = 0;
    }
    
    self.thinkoffset = level.questinfo.thinkoffset;
    self.firstthink = level.questinfo.thinkindex;
    level.questinfo.thinkoffset++;
}

// Namespace br_quest_util
// Params 3
// Checksum 0x6456df20, Offset: 0x333b
// Size: 0x72
function _registerquestfunc( category, func, funclabel )
{
    assert( isdefined( level.questinfo.quests[ category ] ), "<dev string:xfe>" + category + "<dev string:xcd>" );
    level.questinfo.quests[ category ].funcs[ funclabel ] = func;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xb6913aa1, Offset: 0x33b5
// Size: 0x38, Type: bool
function _checkforregister( category, funclabel )
{
    return isdefined( level.questinfo.quests[ category ].funcs[ funclabel ] );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xe094532f, Offset: 0x33f6
// Size: 0x97, Type: bool
function registerquestcategory( category, var_a13d2a3b2fd9b748 )
{
    enabled = getdvarint( hashcat( @"hash_71622bba3f9292f4", category, "_quest" ), var_a13d2a3b2fd9b748 );
    
    if ( br_gametypes::isfeaturedisabled( #"missions" ) )
    {
        enabled = 0;
    }
    
    info = spawnstruct();
    info.enabled = enabled;
    level.questinfo.tabletinfo[ category ] = info;
    
    if ( !enabled )
    {
        return false;
    }
    
    _registerquestcategory( category );
    return true;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xd95f1425, Offset: 0x3496
// Size: 0x15
function registerquestlocale( category )
{
    _registerquestcategory( category );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x2adbd649, Offset: 0x34b3
// Size: 0xf6
function _registerquestcategory( category )
{
    if ( !isdefined( level.questinfo.quests[ category ] ) )
    {
        level.questinfo.quests[ category ] = spawnstruct();
        level.questinfo.quests[ category ].initflag = 0;
        level.questinfo.quests[ category ].hasinitfunc = 0;
        level.questinfo.quests[ category ].funcs = [];
        level.questinfo.quests[ category ].instances = [];
        level.questinfo.quests[ category ].enabled = 1;
        registerquestcategorytablevalues( category );
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x768a2b59, Offset: 0x35b1
// Size: 0x70
function registerquestcategorytablevalues( category )
{
    assert( !isdefined( level.questinfo.tablevalues[ category ] ) );
    level.questinfo.tablevalues[ category ] = spawnstruct();
    level.questinfo.tablevalues[ category ].index = getquesttableindex( category );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x18d5c800, Offset: 0x3629
// Size: 0x47
function registerinitquestvars( category, func )
{
    _registerquestfunc( category, func, "initQuestVars" );
    level.questinfo.quests[ category ].hasinitfunc = 1;
}

// Namespace br_quest_util
// Params 3
// Checksum 0xc1aa51d7, Offset: 0x3678
// Size: 0x18e
function registerquestthink( category, func, thinkrate )
{
    assert( isdefined( category ), "<dev string:xfe>" + category + "<dev string:x161>" );
    assert( isdefined( func ), "<dev string:x179>" + category + "<dev string:x161>" );
    assert( isdefined( thinkrate ), "<dev string:x199>" + category + "<dev string:x161>" );
    
    if ( !isdefined( level.questinfo.quests[ category ].numthinkfuncs ) )
    {
        level.questinfo.quests[ category ].numthinkfuncs = 0;
    }
    
    var_e88292aabb425b50 = int( thinkrate * 20 );
    level.questinfo.quests[ category ].thinkrates[ level.questinfo.quests[ category ].numthinkfuncs ] = var_e88292aabb425b50;
    funclabel = "questThink" + level.questinfo.quests[ category ].numthinkfuncs;
    _registerquestfunc( category, func, funclabel );
    level.questinfo.quests[ category ].numthinkfuncs += 1;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xce446cf2, Offset: 0x380e
// Size: 0x24
function registerquestcircletick( category, func )
{
    _registerquestfunc( category, func, "circleTick" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xa67899e4, Offset: 0x383a
// Size: 0x24
function registerremovequestinstance( category, func )
{
    _registerquestfunc( category, func, "removeInstance" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x83cbc1c1, Offset: 0x3866
// Size: 0x24
function registerclearquestvars( category, func )
{
    _registerquestfunc( category, func, "clearQuestVars" );
}

// Namespace br_quest_util
// Params 3
// Checksum 0x10dfe880, Offset: 0x3892
// Size: 0x173
function registerplayerfilter( category, filterarray, filterindex )
{
    assert( isdefined( level.questinfo.quests[ category ] ), "<dev string:xfe>" + category + "<dev string:xcd>" );
    assert( isarray( filterarray ), "<dev string:x1b5>" + category + "<dev string:xcd>" );
    
    if ( !isdefined( level.questinfo.quests[ category ].filters ) )
    {
        level.questinfo.quests[ category ].filters = [];
    }
    
    if ( isdefined( filterindex ) )
    {
        assert( !isdefined( level.questinfo.quests[ category ].filters[ filterindex ] ), "<dev string:x1ec>" + category + "<dev string:x20e>" + filterindex + "<dev string:xcd>" );
        level.questinfo.quests[ category ].filters[ filterindex ] = filterarray;
        return;
    }
    
    count = level.questinfo.quests[ category ].filters.size;
    level.questinfo.quests[ category ].filters[ count ] = filterarray;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x83cbc1c1, Offset: 0x3a0d
// Size: 0x24
function registeronplayerkilled( category, func )
{
    _registerquestfunc( category, func, "onPlayerKilled" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x1fa447e4, Offset: 0x3a39
// Size: 0x24
function registeronplayerdisconnect( category, func )
{
    _registerquestfunc( category, func, "onPlayerDisconnect" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x3e8b5bc2, Offset: 0x3a65
// Size: 0x24
function registeronentergulag( category, func )
{
    _registerquestfunc( category, func, "onEnterGulag" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xe820f0b9, Offset: 0x3a91
// Size: 0x24
function registeronrespawn( category, func )
{
    _registerquestfunc( category, func, "onRespawn" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xf36cd2c7, Offset: 0x3abd
// Size: 0x24
function registerontimerupdate( category, func )
{
    _registerquestfunc( category, func, "onTimerUpdate" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x83cbc1c1, Offset: 0x3ae9
// Size: 0x24
function registerontimerexpired( category, func )
{
    _registerquestfunc( category, func, "onTimerExpired" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x346dd1d8, Offset: 0x3b15
// Size: 0x24
function registertabletinit( category, func )
{
    _registerquestfunc( category, func, "tabletInit" );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xd0d85801, Offset: 0x3b41
// Size: 0xc
function _clearregisters( category )
{
    
}

// Namespace br_quest_util
// Params 2
// Checksum 0x44120bc6, Offset: 0x3b55
// Size: 0x13b
function onplayerkilled( attacker, victim )
{
    if ( !isdefined( level.questinfo ) )
    {
        return;
    }
    
    foreach ( quest in level.questinfo.quests )
    {
        if ( isdefined( quest.funcs[ "onPlayerKilled" ] ) )
        {
            foreach ( instance in quest.instances )
            {
                instance [[ quest.funcs[ "onPlayerKilled" ] ]]( attacker, victim );
            }
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x5882f9a1, Offset: 0x3c98
// Size: 0x4d
function onplayerconnect( player )
{
    if ( !( isdefined( player.team ) && isdefined( level.questinfo ) ) )
    {
        return;
    }
    
    setquestrewardtier( player.team, getquestrewardtier( player.team ) );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x1763227, Offset: 0x3ced
// Size: 0x131
function onplayerdisconnect( player )
{
    if ( !isdefined( level.questinfo ) )
    {
        return;
    }
    
    foreach ( quest in level.questinfo.quests )
    {
        if ( isdefined( quest.funcs[ "onPlayerDisconnect" ] ) )
        {
            foreach ( instance in quest.instances )
            {
                instance [[ quest.funcs[ "onPlayerDisconnect" ] ]]( player );
            }
        }
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x1e83d1ed, Offset: 0x3e26
// Size: 0x131
function onplayerentergulag()
{
    /#
        function_e4ac44a582699ee0();
    #/
    
    if ( !isdefined( level.questinfo ) )
    {
        return;
    }
    
    foreach ( quest in level.questinfo.quests )
    {
        if ( isdefined( quest.funcs[ "onEnterGulag" ] ) )
        {
            foreach ( instance in quest.instances )
            {
                instance [[ quest.funcs[ "onEnterGulag" ] ]]( self );
            }
        }
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x216710fd, Offset: 0x3f5f
// Size: 0x140
function onplayerrespawn()
{
    /#
        function_e4ac44a582699ee0();
    #/
    
    if ( !isdefined( level.questinfo ) )
    {
        return;
    }
    
    self setclientomnvar( "ui_player_spawned_notify", gettime() );
    
    foreach ( quest in level.questinfo.quests )
    {
        if ( isdefined( quest.funcs[ "onRespawn" ] ) )
        {
            foreach ( instance in quest.instances )
            {
                instance [[ quest.funcs[ "onRespawn" ] ]]( self );
            }
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x5c90aaf6, Offset: 0x40a7
// Size: 0x35
function _runinitquestvars( category )
{
    [[ level.questinfo.quests[ category ].funcs[ "initQuestVars" ] ]]();
}

// Namespace br_quest_util
// Params 1
// Checksum 0x35810d91, Offset: 0x40e4
// Size: 0x10e
function _runaddquestthread( category )
{
    if ( !_isquestthreaded( category ) )
    {
        /#
            for ( index = 0; index < level.questinfo.quests[ category ].numthinkfuncs ; index++ )
            {
                assert( isdefined( level.questinfo.quests[ category ].funcs[ "<dev string:x21b>" + index ] ), "<dev string:x123>" + category + "<dev string:x226>" + index + "<dev string:x23b>" );
            }
        #/
        
        count = level.questinfo.thinkers.size;
        level.questinfo.thinkers[ count ] = category;
        level.questinfo.quests[ category ].enabled = 1;
        return;
    }
    
    println( "<dev string:x23e>" + category + "<dev string:x256>" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x62e207a0, Offset: 0x41fa
// Size: 0x44
function _runaddquestinstance( category, instanceinfo )
{
    level.questinfo.quests[ category ].instances[ instanceinfo.id ] = instanceinfo;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xe1c5594f, Offset: 0x4246
// Size: 0x6c
function _runremovequestinstance( category )
{
    self [[ level.questinfo.quests[ category ].funcs[ "removeInstance" ] ]]();
    self notify( #"removed" );
    level.questinfo.quests[ category ].instances[ self.id ] = undefined;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xa8b83207, Offset: 0x42ba
// Size: 0x84
function _runclearquestvars( category )
{
    [[ level.questinfo.quests[ category ].funcs[ "clearQuestVars" ] ]]();
    level.questinfo.thinkers = arrayremove( level.questinfo.thinkers, category );
    level.questinfo.quests[ category ].enabled = 0;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x8f6f1b97, Offset: 0x4346
// Size: 0x2c, Type: bool
function _isquestthreaded( category )
{
    if ( arraycontains( level.questinfo.thinkers, category ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x36eabc3a, Offset: 0x437b
// Size: 0x53
function _questinstancesactive( category )
{
    if ( isdefined( level.questinfo.quests[ category ].instances ) )
    {
        return level.questinfo.quests[ category ].instances.size;
    }
    
    return 0;
}

// Namespace br_quest_util
// Params 0
// Checksum 0x96644197, Offset: 0x43d7
// Size: 0x2f
function _questthreadsactive()
{
    if ( isdefined( level.questinfo.thinkers ) )
    {
        return level.questinfo.thinkers.size;
    }
    
    return 0;
}

// Namespace br_quest_util
// Params 3
// Checksum 0x470c84aa, Offset: 0x440f
// Size: 0x7e
function createlocaleinstance( category, linkedcategory, instanceid )
{
    locale = createquestinstance( category, instanceid, "invalid" );
    locale.subscriber_type = linkedcategory;
    getquestdata( linkedcategory ).locale_type = category;
    locale.subscribedinstances = [];
    
    /#
        locale.debugtype = "<dev string:x267>";
    #/
    
    return locale;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x87de5dc8, Offset: 0x4496
// Size: 0x24
function registercreatequestlocale( category, func )
{
    _registerquestfunc( category, func, "create_locale" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xef66232f, Offset: 0x44c2
// Size: 0x24
function registermovequestlocale( category, func )
{
    _registerquestfunc( category, func, "move_locale" );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x9f8158ad, Offset: 0x44ee
// Size: 0x24
function registercheckiflocaleisavailable( category, func )
{
    _registerquestfunc( category, func, "check_available" );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x81c82f93, Offset: 0x451a
// Size: 0x28f
function _determinelocationarray( search_params )
{
    assert( isdefined( search_params.searchfunc ), "<dev string:x26e>" );
    
    switch ( search_params.searchfunc )
    {
        case #"hash_499717c03903e17b":
            return getentitylessscriptablearray( search_params.itemname, #classname, search_params.searchcircleorigin, search_params.searchradiusmax );
        case #"hash_e77c846975579748":
            var_6a71d752995abd49 = getunusedlootcachepoints( search_params.searchcircleorigin, search_params.searchradiusmax, 0, 1 );
            return var_6a71d752995abd49;
        case #"hash_54890ab858a5b8d7":
            return getquestpoints( search_params.questtypes, search_params.searchcircleorigin, search_params.searchradiusmax, 0, 1 );
        case #"hash_f657de26aeb66a7":
            allkiosks = undefined;
            
            if ( common_kiosk::function_5274212108b240d3() )
            {
                allkiosks = level.common_armory_kiosk.instances;
            }
            else
            {
                allkiosks = br_armory_kiosk::getallspawninstances();
            }
            
            activekiosks = [];
            
            foreach ( kiosk in allkiosks )
            {
                if ( !kiosk.disabled )
                {
                    activekiosks[ activekiosks.size ] = kiosk;
                }
            }
            
            return activekiosks;
        case #"hash_6cde8a1344819cc":
            if ( isdefined( level.br_plunder_sites ) )
            {
                var_abe0e39455c816ee = br_plunder::getplunderextractionsites();
                var_661a03d65ff583bd = [];
                
                foreach ( site in var_abe0e39455c816ee )
                {
                    if ( site getscriptablepartstate( site.type ) == "hidden" )
                    {
                        var_661a03d65ff583bd[ var_661a03d65ff583bd.size ] = site;
                    }
                }
                
                if ( var_661a03d65ff583bd.size == 0 )
                {
                    return var_abe0e39455c816ee;
                }
                
                return var_661a03d65ff583bd;
            }
        default:
            assert( 0, "<dev string:x2ae>" );
            break;
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0x57093f9e, Offset: 0x47b1
// Size: 0x352
function _findnewlocaleplacement( location_array, search_params )
{
    location_array = arrayrandomize( location_array );
    
    if ( !isdefined( search_params.mintime ) )
    {
        search_params.mintime = 0;
    }
    
    if ( !isdefined( search_params.travelspeed ) )
    {
        search_params.travelspeed = 190;
    }
    
    checkideal = isdefined( search_params.searchradiusidealmax ) && isdefined( search_params.searchradiusidealmin );
    
    if ( search_params.searchforcecirclecenter )
    {
        centertime = br_circle::getmintimetillpointindangercircle( search_params.searchcircleorigin );
    }
    else
    {
        centertime = 0;
    }
    
    debug = spawnstruct();
    
    /#
        debug.centertime = centertime;
        debug.forceclosest = getdvarint( @"hash_fb5e59c5e6515a4b", 0 );
    #/
    
    bestlocindex = undefined;
    var_49bdf85b1540dcb2 = search_params.searchradiusmax;
    
    foreach ( i, loc in location_array )
    {
        dist = distance2d( loc.origin, search_params.searchcircleorigin );
        
        /#
            debug.dist[ i ] = dist;
            
            if ( debug.forceclosest )
            {
                if ( dist < var_49bdf85b1540dcb2 )
                {
                    bestlocindex = i;
                    var_49bdf85b1540dcb2 = dist;
                }
                
                continue;
            }
        #/
        
        if ( dist < search_params.searchradiusmin )
        {
            continue;
        }
        
        seconds = br_circle::getmintimetillpointindangercircle( loc.origin );
        
        if ( !level.br_circle_disabled && seconds >= 0 )
        {
            /#
                debug.circletime[ i ] = seconds;
            #/
            
            if ( seconds < centertime )
            {
                continue;
            }
            
            if ( search_params.travelspeed > 0 )
            {
                traveltime = dist / search_params.travelspeed;
                
                /#
                    debug.traveltime[ i ] = traveltime;
                #/
                
                seconds -= traveltime;
            }
            
            if ( seconds < search_params.mintime )
            {
                continue;
            }
        }
        
        /#
            debug.var_531c3e3b52675bf[ i ] = 0;
        #/
        
        if ( checkideal )
        {
            if ( dist < search_params.searchradiusidealmax )
            {
                if ( dist >= search_params.searchradiusidealmin )
                {
                    /#
                        debug.var_531c3e3b52675bf[ i ] = 1;
                    #/
                    
                    var_ac99ac222f6bbc72 = 0;
                }
                else
                {
                    var_ac99ac222f6bbc72 = search_params.searchradiusidealmin - dist;
                }
            }
            else
            {
                var_ac99ac222f6bbc72 = dist - search_params.searchradiusidealmax;
            }
            
            if ( var_ac99ac222f6bbc72 < var_49bdf85b1540dcb2 )
            {
                var_49bdf85b1540dcb2 = var_ac99ac222f6bbc72;
                bestlocindex = i;
                
                if ( var_ac99ac222f6bbc72 <= 0 )
                {
                    break;
                }
            }
            
            continue;
        }
        
        bestlocindex = i;
    }
    
    /#
        thread function_5357172e35dc531e( location_array, bestlocindex, search_params, debug );
    #/
    
    bestloc = undefined;
    
    if ( isdefined( bestlocindex ) )
    {
        bestloc = location_array[ bestlocindex ];
    }
    else
    {
        /#
            thread function_cefb9e27ddbd3a08( location_array, bestlocindex, search_params, debug );
        #/
    }
    
    return bestloc;
}

/#

    // Namespace br_quest_util
    // Params 4
    // Checksum 0x4a279f7e, Offset: 0x4b0c
    // Size: 0x65, Type: dev
    function function_5357172e35dc531e( location_array, bestlocindex, search_params, debuginfo )
    {
        dvar = @"hash_b88af237972348e6";
        dvar_default = 0;
        
        if ( !getdvarint( dvar, dvar_default ) )
        {
            return;
        }
        
        function_2c3cf3d5aa9d1f70( dvar, dvar_default, location_array, bestlocindex, search_params, debuginfo );
    }

    // Namespace br_quest_util
    // Params 5
    // Checksum 0x9fa9a865, Offset: 0x4b79
    // Size: 0x143, Type: dev
    function function_cefb9e27ddbd3a08( location_array, bestlocindex, search_params, debuginfo, failindex )
    {
        dvar = @"hash_b4cb045fde16721f";
        dvar_default = -2;
        var_f07e5a917a3dba8d = -1;
        failindex = level.questinfo.debuginfo.var_f3009cb67d6c01fa;
        level.questinfo.debuginfo.var_f3009cb67d6c01fa++;
        
        while ( true )
        {
            while ( true )
            {
                dvarvalue = getdvarint( dvar, dvar_default );
                
                if ( dvarvalue == var_f07e5a917a3dba8d )
                {
                    line( search_params.searchcircleorigin, search_params.searchcircleorigin + ( 0, 0, 5000 ), ( 1, 0, 0 ) );
                    debugstar( search_params.searchcircleorigin, ( 1, 0, 0 ), 1, string( failindex ) );
                    waitframe();
                    continue;
                }
                
                if ( dvarvalue == failindex )
                {
                    break;
                }
                
                wait 0.2;
            }
            
            function_2c3cf3d5aa9d1f70( dvar, failindex, location_array, bestlocindex, search_params, debuginfo );
        }
    }

    // Namespace br_quest_util
    // Params 6
    // Checksum 0x69c5f534, Offset: 0x4cc4
    // Size: 0x4b3, Type: dev
    function function_2c3cf3d5aa9d1f70( dvar, dvarvalue, location_array, bestlocindex, search_params, debuginfo )
    {
        if ( !isdefined( debuginfo.dist ) )
        {
            debuginfo.dist = [];
        }
        
        if ( !isdefined( debuginfo.circletime ) )
        {
            debuginfo.circletime = [];
        }
        
        if ( !isdefined( debuginfo.traveltime ) )
        {
            debuginfo.traveltime = [];
        }
        
        if ( !isdefined( debuginfo.var_531c3e3b52675bf ) )
        {
            debuginfo.var_531c3e3b52675bf = [];
        }
        
        level notify( #"hash_347d573bb97fbd46" );
        level endon( #"hash_347d573bb97fbd46" );
        red = ( 1, 0, 0 );
        yellow = ( 1, 1, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        white = ( 1, 1, 1 );
        print3doffset = ( 0, 0, 15 );
        
        while ( getdvarint( dvar ) == dvarvalue )
        {
            sphere( search_params.searchcircleorigin, 10, yellow );
            print3d( search_params.searchcircleorigin, "<dev string:x2f6>" + location_array.size + "<dev string:x2fe>" + debuginfo.centertime, white, 1, 1, 1, 1 );
            
            if ( !isdefined( bestlocindex ) )
            {
                print3d( search_params.searchcircleorigin + print3doffset, "<dev string:x306>", red, 1, 1, 1, 1 );
            }
            
            utility::draw_circle( search_params.searchcircleorigin, search_params.searchradiusmin, green, 1, 0, 0 );
            utility::draw_circle( search_params.searchcircleorigin, search_params.searchradiusmax, red, 1, 0, 0 );
            
            if ( isdefined( search_params.searchradiusidealmin ) )
            {
                utility::draw_circle( search_params.searchcircleorigin, search_params.searchradiusidealmin, yellow, 1, 0, 0 );
            }
            
            if ( isdefined( search_params.searchradiusidealmax ) )
            {
                utility::draw_circle( search_params.searchcircleorigin, search_params.searchradiusidealmax, yellow, 1, 0, 0 );
            }
            
            foreach ( i, loc in location_array )
            {
                checked = isdefined( debuginfo.dist[ i ] );
                
                if ( i == bestlocindex )
                {
                    color = green;
                    size = 50;
                }
                else if ( checked )
                {
                    color = blue;
                    size = 20;
                }
                else
                {
                    color = white;
                    size = 10;
                }
                
                sphere( loc.origin, size, color );
                
                if ( checked )
                {
                    dist = debuginfo.dist[ i ];
                    
                    if ( dist <= search_params.searchradiusmin )
                    {
                        color = red;
                        colordist = red;
                    }
                    else
                    {
                        color = green;
                        colordist = green;
                    }
                    
                    if ( debuginfo.var_531c3e3b52675bf[ i ] )
                    {
                        colordist = yellow;
                    }
                    
                    printorigin = loc.origin;
                    print3d( printorigin, "<dev string:x318>" + debuginfo.dist[ i ], colordist, 1, 1, 1, 1 );
                    printorigin += print3doffset;
                    circletime = debuginfo.circletime[ i ];
                    
                    if ( isdefined( circletime ) )
                    {
                        str = "<dev string:x31f>" + circletime;
                        traveltime = debuginfo.traveltime[ i ];
                        
                        if ( !isdefined( traveltime ) )
                        {
                            traveltime = 0;
                        }
                        
                        str = string( circletime ) + "<dev string:x32c>" + traveltime;
                        
                        if ( circletime - traveltime < search_params.mintime )
                        {
                            color = red;
                            str += "<dev string:x330>";
                        }
                        else
                        {
                            color = green;
                            str += "<dev string:x334>";
                        }
                        
                        str += search_params.mintime;
                        print3d( printorigin, str, color, 1, 1, 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_quest_util
// Params 2
// Checksum 0xffbd8585, Offset: 0x517f
// Size: 0xb1
function _runcreatequestlocale( category, params )
{
    /#
        function_a65f25c1da281772();
    #/
    
    if ( isdefined( params ) )
    {
        locale = self [[ level.questinfo.quests[ category ].funcs[ "create_locale" ] ]]( params );
    }
    else
    {
        locale = self [[ level.questinfo.quests[ category ].funcs[ "create_locale" ] ]]();
    }
    
    assert( isdefined( locale.curorigin ), "<dev string:x339>" + category + "<dev string:x353>" );
    return locale;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xa6dfcdef, Offset: 0x5239
// Size: 0x7e
function _runmovequestlocale( category, params )
{
    /#
        function_984e3602904184b7();
    #/
    
    if ( isdefined( params ) )
    {
        self [[ level.questinfo.quests[ category ].funcs[ "move_locale" ] ]]( params );
        return;
    }
    
    self [[ level.questinfo.quests[ category ].funcs[ "move_locale" ] ]]();
}

// Namespace br_quest_util
// Params 1
// Checksum 0xe56599fa, Offset: 0x52bf
// Size: 0x35
function _runcheckiflocaleisavailable( category )
{
    return self [[ level.questinfo.quests[ category ].funcs[ "check_available" ] ]]();
}

// Namespace br_quest_util
// Params 2
// Checksum 0x5885cfa1, Offset: 0x52fd
// Size: 0x11d
function _findexisitingquestlocale( category, search_params )
{
    assert( isdefined( search_params.searchcircleorigin ), "<dev string:x37b>" + category + "<dev string:x39b>" );
    questdata = getquestdata( category );
    
    if ( !( isdefined( questdata ) && isdefined( questdata.instances ) ) )
    {
        return;
    }
    
    foreach ( instance in questdata.instances )
    {
        dist = distance2d( search_params.searchcircleorigin, instance.curorigin );
        
        if ( dist > search_params.searchradiusmax )
        {
            continue;
        }
        
        if ( !instance _runcheckiflocaleisavailable( category ) )
        {
            continue;
        }
        
        return instance;
    }
}

/#

    // Namespace br_quest_util
    // Params 2
    // Checksum 0xdf43f11e, Offset: 0x5423
    // Size: 0x97, Type: dev
    function function_66af587e620f5caa( category, search_params )
    {
        assert( isdefined( search_params.searchcircleorigin ), "<dev string:x3d3>" + category + "<dev string:x39b>" );
        assert( isdefined( search_params.searchradiusmax ), "<dev string:x3d3>" + category + "<dev string:x3e9>" );
        assert( isdefined( search_params.searchradiusmin ), "<dev string:x3d3>" + category + "<dev string:x41e>" );
        assert( isdefined( search_params.searchfunc ), "<dev string:x453>" );
    }

#/

// Namespace br_quest_util
// Params 2
// Checksum 0x219775e3, Offset: 0x54c2
// Size: 0x6a
function findquestplacement( category, search_params )
{
    /#
        function_66af587e620f5caa( category, search_params );
    #/
    
    if ( isdefined( search_params.reservedplacement ) )
    {
        placement = search_params.reservedplacement;
    }
    else
    {
        location_array = _determinelocationarray( search_params );
        placement = _findnewlocaleplacement( location_array, search_params );
    }
    
    return placement;
}

// Namespace br_quest_util
// Params 3
// Checksum 0xf7cd2354, Offset: 0x5535
// Size: 0x80
function requestquestlocale( category, search_params, ignoreexisting )
{
    /#
        function_a65f25c1da281772();
        function_66af587e620f5caa( category, search_params );
    #/
    
    locale = undefined;
    
    if ( !ignoreexisting )
    {
        locale = _findexisitingquestlocale( category, search_params );
    }
    
    if ( !isdefined( locale ) )
    {
        placement = findquestplacement( category, search_params );
        locale = _runcreatequestlocale( category, placement );
    }
    
    subscribetoquestlocale( locale );
    return locale;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xd639a0a, Offset: 0x55be
// Size: 0x3b
function subscribetoquestlocale( locale )
{
    /#
        function_a65f25c1da281772();
    #/
    
    self.subscribedlocale = locale;
    locale.subscribedinstances[ locale.subscribedinstances.size ] = self;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x50988d9e, Offset: 0x5601
// Size: 0x3e
function movequestlocale( category, search_params )
{
    /#
        function_984e3602904184b7();
    #/
    
    placement = findquestplacement( category, search_params );
    _runmovequestlocale( category, placement );
}

// Namespace br_quest_util
// Params 0
// Checksum 0x18a9d571, Offset: 0x5647
// Size: 0x57
function leavequestlocale()
{
    /#
        function_a65f25c1da281772();
    #/
    
    locale = self.subscribedlocale;
    locale.subscribedinstances = arrayremove( locale.subscribedinstances, self );
    
    if ( locale.subscribedinstances.size <= 0 )
    {
        locale removequestinstance();
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x524978c7, Offset: 0x56a6
// Size: 0x48
function getquestdata( category )
{
    if ( !( isdefined( level.questinfo ) && isdefined( level.questinfo.quests ) ) )
    {
        return;
    }
    
    return level.questinfo.quests[ category ];
}

// Namespace br_quest_util
// Params 2
// Checksum 0x3439dc83, Offset: 0x56f7
// Size: 0x37
function getquestinstancedata( category, instancekey )
{
    return level.questinfo.quests[ category ].instances[ instancekey ];
}

// Namespace br_quest_util
// Params 2
// Checksum 0xa392b19c, Offset: 0x5737
// Size: 0x6f
function getquestinstancedatasafe( category, instancekey )
{
    instance = undefined;
    
    if ( isdefined( level.questinfo ) && isdefined( level.questinfo.quests[ category ] ) )
    {
        instance = level.questinfo.quests[ category ].instances[ instancekey ];
    }
    
    return instance;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x319a6563, Offset: 0x57af
// Size: 0x3f, Type: bool
function checkforinstance( category, instanceid )
{
    if ( isdefined( level.questinfo.quests[ category ].instances[ instanceid ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x98046522, Offset: 0x57f7
// Size: 0x116
function _validateplayerfilter( filterkey )
{
    if ( isdefined( filterkey ) )
    {
        if ( isint( filterkey ) )
        {
            /#
                function_9b63c0e88a433955();
            #/
            
            assert( isdefined( level.questinfo.quests[ self.questcategory ].filters[ filterkey ] ) );
            return level.questinfo.quests[ self.questcategory ].filters[ filterkey ];
        }
        
        if ( isarray( filterkey ) )
        {
            return filterkey;
        }
        
        assert( 0, "<dev string:x493>" );
        return;
    }
    
    if ( isdefined( level.questinfo.quests[ self.questcategory ].filters ) )
    {
        /#
            function_9b63c0e88a433955();
        #/
        
        return level.questinfo.quests[ self.questcategory ].filters[ 0 ];
    }
    
    return level.questinfo.defaultfilter;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x2c441e3d, Offset: 0x5915
// Size: 0x8b, Type: bool
function _validateplayer( player, filter )
{
    foreach ( condition in filter )
    {
        if ( ![[ condition ]]( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x6978f117, Offset: 0x59a9
// Size: 0x32, Type: bool
function isplayervalid( player, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    return _validateplayer( player, filter );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xaf4dbe4d, Offset: 0x59e4
// Size: 0xab, Type: bool
function isteamvalid( team, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( _validateplayer( player, filter ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xc190dbc1, Offset: 0x5a98
// Size: 0xac, Type: bool
function isentireteamvalid( team, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( !_validateplayer( player, filter ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x9e446a21, Offset: 0x5b4d
// Size: 0xa0, Type: bool
function function_aa740d271fc528f6( group, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    
    foreach ( player in group )
    {
        if ( _validateplayer( player, filter ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x6fd67d09, Offset: 0x5bf6
// Size: 0xbb
function getvalidplayersinteam( team, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    players = [];
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( _validateplayer( player, filter ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x3268afa3, Offset: 0x5cba
// Size: 0xb0
function getvalidplayersinarray( group, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    players = [];
    
    foreach ( player in group )
    {
        if ( _validateplayer( player, filter ) )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x1ce6830d, Offset: 0x5d73
// Size: 0xe4
function sortvalidplayersinarray( group, filterkey )
{
    filter = _validateplayerfilter( filterkey );
    players = [];
    players[ "valid" ] = [];
    players[ "invalid" ] = [];
    
    foreach ( player in group )
    {
        if ( _validateplayer( player, filter ) )
        {
            players[ "valid" ][ players[ "valid" ].size ] = player;
            continue;
        }
        
        players[ "invalid" ][ players[ "invalid" ].size ] = player;
    }
    
    return players;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x380ebf5f, Offset: 0x5e60
// Size: 0xcc
function getteamcenter( team, filter )
{
    center = ( 0, 0, 0 );
    validplayers = getvalidplayersinteam( team, filter );
    
    if ( validplayers.size <= 0 )
    {
        return center;
    }
    
    foreach ( player in validplayers )
    {
        center += player.origin;
    }
    
    center /= validplayers.size;
    return center;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x1f07f216, Offset: 0x5f35
// Size: 0x1a, Type: bool
function filtercondition_isdead( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xeeb7011, Offset: 0x5f58
// Size: 0x1e, Type: bool
function filtercondition_isdowned( player )
{
    if ( player.inlaststand )
    {
        return false;
    }
    
    return true;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x29af7530, Offset: 0x5f7f
// Size: 0x1b, Type: bool
function filtercondition_ingulag( player )
{
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x49d8d64d, Offset: 0x5fa3
// Size: 0x1f, Type: bool
function filtercondition_hasbeeningulag( player )
{
    if ( isdefined( player.gulag ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_quest_util
// Params 4
// Checksum 0x880d61ce, Offset: 0x5fcb
// Size: 0xb9
function packsplashparambits( missionid, rewardtier, rewardindex = 0, unlockableindex = 0 )
{
    assert( missionid >= 0 && missionid < 32 );
    assert( rewardtier >= 0 && rewardtier < 32 );
    assert( rewardindex >= 0 && rewardindex < 64 );
    assert( unlockableindex >= 0 && unlockableindex < 8 );
    value = unlockableindex;
    value = value << 6 | rewardindex;
    value = value << 5 | rewardtier;
    value = value << 5 | missionid;
    return value;
}

// Namespace br_quest_util
// Params 3
// Checksum 0xc9f0e59b, Offset: 0x608d
// Size: 0x55
function displayteamsplash( team, splash_key, params )
{
    assert( isdefined( splash_key ), "<dev string:x4c4>" + team );
    players = teams::getteamdata( team, "players" );
    displaysplashtoplayers( players, splash_key, params );
}

// Namespace br_quest_util
// Params 3
// Checksum 0x70504c94, Offset: 0x60ea
// Size: 0xf2
function displaysplashtoplayers( players, splash_key, params )
{
    assert( isdefined( splash_key ), "<dev string:x4fb>" );
    
    foreach ( player in players )
    {
        if ( player br_public::isplayeringulag() )
        {
            continue;
        }
        
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        if ( isdefined( params ) )
        {
            if ( isdefined( params.excludedplayers ) )
            {
                if ( arraycontains( params.excludedplayers, player ) )
                {
                    continue;
                }
            }
        }
        
        displayplayersplash( player, splash_key, params );
    }
}

// Namespace br_quest_util
// Params 3
// Checksum 0x8c78b7f5, Offset: 0x61e4
// Size: 0x9e
function displayplayersplash( player, splash_key, params )
{
    assert( isdefined( splash_key ), "<dev string:x4c4>" + player.name );
    
    if ( isdefined( params ) && isdefined( params.packedbits ) )
    {
        player thread hud_message::showsplash( splash_key, params.packedbits );
        return;
    }
    
    if ( isdefined( params ) && isdefined( params.intvar ) )
    {
        player thread hud_message::showsplash( splash_key, params.intvar );
        return;
    }
    
    player thread hud_message::showsplash( splash_key );
}

// Namespace br_quest_util
// Params 5
// Checksum 0x28e7cf1, Offset: 0x628a
// Size: 0x1be
function displaysplashtoplayersinradius( splash_key, origin, radius, player_filter, params )
{
    maxdist2rd = radius * radius;
    newarray = [];
    
    foreach ( player in level.players )
    {
        dist2rd = distancesquared( origin, player.origin );
        
        if ( dist2rd > maxdist2rd )
        {
            continue;
        }
        
        if ( isdefined( params.excludedteams ) && arraycontains( params.excludedteams, player.team ) )
        {
            continue;
        }
        
        if ( isdefined( params.excludedplayers ) && arraycontains( params.excludedplayers, player ) )
        {
            continue;
        }
        
        if ( !isplayervalid( player, player_filter ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = player;
    }
    
    if ( newarray.size > 0 )
    {
        foreach ( player in newarray )
        {
            displayplayersplash( player, splash_key, params );
        }
    }
}

// Namespace br_quest_util
// Params 3
// Checksum 0x5dc2303a, Offset: 0x6450
// Size: 0x70
function displaysquadmessagetoplayer( player_ref, state, missionid )
{
    player = player_ref getentitynumber();
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( player ) )
    {
        player = 0;
    }
    
    if ( !isdefined( missionid ) )
    {
        missionid = 0;
    }
    
    value = 0;
    value = missionid << 12 | player << 4 | state;
    self setclientomnvar( "ui_br_expanded_obit_message", value );
}

// Namespace br_quest_util
// Params 4
// Checksum 0xd6274abd, Offset: 0x64c8
// Size: 0xa8
function displaysquadmessagetoteam( team, player_ref, state, missionid )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player displaysquadmessagetoplayer( player_ref, state, missionid );
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0x794fcd32, Offset: 0x6578
// Size: 0x1f
function giveplayerpoints( player, ref )
{
    player thread points::doscoreevent( ref );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xc2275bbd, Offset: 0x659f
// Size: 0x93
function giveteampoints( team, ref )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player thread points::doscoreevent( ref );
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0x1262d2e1, Offset: 0x663a
// Size: 0x29
function calldropbag( player, location )
{
    thread airdrop_loadout_crate::spawnloadoutcrate( player, location, 2 );
    level thread br_rewards::managedropbags();
}

// Namespace br_quest_util
// Params 5
// Checksum 0xbd695c34, Offset: 0x666b
// Size: 0x170
function giveteamplunderflat( team, amount, var_7dc6f42f0eee8606, squadindex, players = br_contract_manager::function_85e5094486ad4b57( team, squadindex ) )
{
    if ( !isdefined( players ) )
    {
        return;
    }
    
    var_4fa2322207914d5d = getdvarfloat( @"hash_7165dad703502609", 0.4 );
    
    foreach ( player in players )
    {
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        tempamount = amount;
        
        if ( !player::isreallyalive( player ) && var_7dc6f42f0eee8606 )
        {
            tempamount = int( amount * var_4fa2322207914d5d );
        }
        else
        {
            tempamount = int( tempamount * function_bf57ff81684bd6a( player ) );
        }
        
        player br_plunder::playerplunderpickup( tempamount );
        level.br_plunder.plunder_awarded_by_missions_total += tempamount;
        br_analytics::trackcashevent( player, "mission", tempamount );
        player br_plunder::function_d7efc5a9b599e020( 1, tempamount );
    }
}

// Namespace br_quest_util
// Params 4
// Checksum 0xd1fdce1a, Offset: 0x67e3
// Size: 0x133
function giveteamplunderdistributive( team, amount, squadindex, players = br_contract_manager::function_85e5094486ad4b57( team, squadindex ) )
{
    amountperplayer = int( amount / players.size );
    
    foreach ( player in players )
    {
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        var_598d99a13ff89b63 = int( amountperplayer * function_bf57ff81684bd6a( player ) );
        player br_plunder::playerplunderpickup( var_598d99a13ff89b63 );
        level.br_plunder.plunder_awarded_by_missions_total += var_598d99a13ff89b63;
        br_analytics::trackcashevent( player, "mission", var_598d99a13ff89b63 );
        player br_plunder::function_d7efc5a9b599e020( 1, var_598d99a13ff89b63 );
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x5ea562b9, Offset: 0x691e
// Size: 0x2c
function getquestindex( ref )
{
    return level.questinfo.tablevalues[ ref ].index;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xf709dbb3, Offset: 0x6953
// Size: 0x2c
function getquesttableindex( ref )
{
    index = int( tablelookup( "mp/brmissions.csv", 1, ref, 0 ) );
    return index;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x6ccdebcf, Offset: 0x6988
// Size: 0x36
function uiobjectiveshow( ref )
{
    assert( isplayer( self ) );
    index = getquestindex( ref );
    setquestindexomnvar( index );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x9781e191, Offset: 0x69c6
// Size: 0x93
function uiobjectiveshowtoteam( ref, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player uiobjectiveshow( ref );
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0x3978e3fb, Offset: 0x6a61
// Size: 0x17
function uiobjectivehide()
{
    assert( isplayer( self ) );
    setquestindexomnvar( 0 );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x7b38c38f, Offset: 0x6a80
// Size: 0x89
function uiobjectivehidefromteam( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player uiobjectivehide();
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x3c3026b6, Offset: 0x6b11
// Size: 0x26
function uiobjectivesetparameter( value )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_param", value );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xa4234009, Offset: 0x6b3f
// Size: 0x26
function uiobjectivesetlootid( value )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_loot_id", value );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xb15e26d3, Offset: 0x6b6d
// Size: 0x119
function function_bf57ff81684bd6a( player )
{
    mod = 1;
    
    if ( perks::function_ae69f867e887ac4a( "specialty_contract_payout" ) )
    {
        if ( isdefined( player.perks[ "specialty_contract_payout" ] ) )
        {
            mod += getdvarfloat( @"hash_cb657adb237d72a2", 0.1 );
        }
        else if ( getdvarint( @"hash_a50815ce2cfbefbc", 0 ) )
        {
            foreach ( tm in teams::getteamdata( player.team, "players" ) )
            {
                if ( tm != player && isdefined( tm.perks[ "specialty_contract_payout" ] ) )
                {
                    mod += getdvarfloat( @"hash_e4f6ee9301cbf325", 0.1 );
                }
            }
        }
    }
    
    return mod;
}

// Namespace br_quest_util
// Params 3
// Checksum 0x26ec5361, Offset: 0x6c8f
// Size: 0xba
function createquestobjicon( iconref, state, initalorigin )
{
    self.objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( self.objectiveiconid, state, ( 0, 0, 0 ), iconref );
        objidpoolmanager::update_objective_setbackground( self.objectiveiconid, 1 );
        objective_showtoplayersinmask( self.objectiveiconid );
        objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        
        if ( isdefined( initalorigin ) )
        {
            movequestobjicon( initalorigin );
        }
        
        return;
    }
    
    println( self.category + "<dev string:x52d>" );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xd78406bc, Offset: 0x6d51
// Size: 0x1e
function movequestobjicon( neworigin )
{
    objidpoolmanager::update_objective_position( self.objectiveiconid, neworigin );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x8d81592d, Offset: 0x6d77
// Size: 0x1c
function showquestobjicontoplayer( player )
{
    objective_addclienttomask( self.objectiveiconid, player );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x2ece3e55, Offset: 0x6d9b
// Size: 0x13
function showquestobjicontoall( objid )
{
    objective_addalltomask( objid );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xb52fadcf, Offset: 0x6db6
// Size: 0x1c
function hidequestobjiconfromplayer( player )
{
    objective_removeclientfrommask( self.objectiveiconid, player );
}

// Namespace br_quest_util
// Params 0
// Checksum 0xe8cfdfc7, Offset: 0x6dda
// Size: 0xc, Type: bool
function checkforactiveobjicon()
{
    return isdefined( self.objectiveiconid );
}

// Namespace br_quest_util
// Params 0
// Checksum 0xc2710cda, Offset: 0x6def
// Size: 0x22
function deletequestobjicon()
{
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_quest_util
// Params 2
// Checksum 0xe88ed074, Offset: 0x6e19
// Size: 0x101
function utilflare_shootflare( spawn_origin, flaretype )
{
    level endon( #"game_ended" );
    content_filter = trace::create_contents( 0, 1, 0, 1, 0, 0, 0 );
    new_position = trace::ray_trace( spawn_origin + ( 0, 0, 4000 ), spawn_origin, undefined, content_filter, undefined, 1 )[ "position" ];
    flare = spawn( "script_model", new_position );
    
    if ( !isdefined( flare ) )
    {
        return;
    }
    
    flare.angles = vectortoangles( ( 0, 0, 1 ) );
    flare setmodel( "equip_flare_br" );
    wait 0.5;
    flare setscriptablepartstate( "launch", "start", 0 );
    travelpart = "start";
    
    if ( flaretype == "revive" )
    {
        travelpart = "start_revive";
    }
    
    flare setscriptablepartstate( "travel", travelpart, 0 );
    flare thread _utilflare_lerpflare( flaretype );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xc36ca75c, Offset: 0x6f22
// Size: 0x60
function _utilflare_lerpflare( flaretype )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    movetime = 3.125;
    self moveto( self.origin + ( 0, 0, 2500 ), movetime );
    wait movetime;
    _utilflare_flareexplode( flaretype );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xb6730733, Offset: 0x6f8a
// Size: 0x75
function _utilflare_flareexplode( flaretype = "<undefined>" )
{
    self setscriptablepartstate( "travel", "off", 0 );
    
    if ( !_utilflare_isvalidflaretype( flaretype ) )
    {
        assertmsg( "<dev string:x549>" + flaretype + "<dev string:xcd>" );
        return;
    }
    
    fxstate = "start_" + flaretype;
    self setscriptablepartstate( "explode", fxstate, 0 );
    thread sfx_br_flare_phosphorus();
}

// Namespace br_quest_util
// Params 1
// Checksum 0xcec59bd6, Offset: 0x7007
// Size: 0x4a
function _utilflare_isvalidflaretype( flaretype )
{
    validflaretype = 0;
    
    if ( isdefined( flaretype ) )
    {
        switch ( flaretype )
        {
            case #"hash_b06d15a59bd8ea50":
            case #"hash_f4a9126c03d3385b":
                validflaretype = 1;
                break;
        }
    }
    
    return validflaretype;
}

// Namespace br_quest_util
// Params 0
// Checksum 0x8d0d3911, Offset: 0x705a
// Size: 0x76
function sfx_br_flare_phosphorus()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "phosphorus", "start", 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", "start", 0 );
    wait 12;
    self setscriptablepartstate( "phosphorus", "end", 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", "off", 0 );
    wait 5;
    self delete();
}

// Namespace br_quest_util
// Params 1
// Checksum 0xa27659c9, Offset: 0x70d8
// Size: 0x61
function questpointgetradius( point )
{
    radius = 0;
    
    if ( point.spawnflags & 4 )
    {
        radius = 256;
    }
    else if ( point.spawnflags & 2 )
    {
        radius = 128;
    }
    else if ( point.spawnflags & 1 )
    {
        radius = 168;
    }
    
    return radius;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x4f5c200, Offset: 0x7142
// Size: 0x4f
function questtimerinit( category, var_82771f20f3d40563 )
{
    questdata = getquestdata( category );
    questdata.usequesttimer = getdvarint( hashcat( @"hash_71622bba3f9292f4", category, "_enableQuestTime" ), var_82771f20f3d40563 );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x8be66f19, Offset: 0x7199
// Size: 0x7b
function questtimerset( time, animbuffer )
{
    /#
        function_a65f25c1da281772();
    #/
    
    if ( !isdefined( animbuffer ) )
    {
        animbuffer = 0;
    }
    
    totaltime = time + animbuffer;
    questdata = getquestdata( self.category );
    
    if ( !questdata.usequesttimer )
    {
        return;
    }
    
    self.missiontime = gettime() + totaltime * 1000;
    questtimerupdate();
}

// Namespace br_quest_util
// Params 1
// Checksum 0xc3dbfd26, Offset: 0x721c
// Size: 0x61
function questtimeradd( time )
{
    /#
        function_a65f25c1da281772();
    #/
    
    questdata = getquestdata( self.category );
    
    if ( !questdata.usequesttimer )
    {
        return;
    }
    
    self.missiontime += time * 1000;
    questtimerupdate();
}

// Namespace br_quest_util
// Params 0
// Checksum 0x7c073a5d, Offset: 0x7285
// Size: 0xe2
function questtimerupdate()
{
    /#
        function_a65f25c1da281772();
    #/
    
    foreach ( player in teams::getteamdata( self.id, "players" ) )
    {
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
    
    questdata = getquestdata( self.category );
    updatefunc = questdata.funcs[ "onTimerUpdate" ];
    
    if ( isdefined( updatefunc ) )
    {
        [[ updatefunc ]]();
    }
    
    thread _questtimerwait();
}

// Namespace br_quest_util
// Params 0
// Checksum 0x206c2f37, Offset: 0x736f
// Size: 0xb1
function _questtimerwait()
{
    /#
        function_a65f25c1da281772();
    #/
    
    self notify( #"hash_b982a6eee0ec0117" );
    self endon( #"game_ended" );
    self endon( #"hash_b982a6eee0ec0117" );
    self endon( #"questended" );
    waittime = ( self.missiontime - gettime() ) / 1000;
    wait waittime;
    questdata = getquestdata( self.category );
    expiredfunc = questdata.funcs[ "onTimerExpired" ];
    
    if ( isdefined( expiredfunc ) )
    {
        [[ expiredfunc ]]();
    }
    
    self.result = "timeout";
    thread removequestinstance();
}

// Namespace br_quest_util
// Params 1
// Checksum 0x79e7ff9e, Offset: 0x7428
// Size: 0x4c
function registercontributingplayers( player )
{
    if ( !isdefined( self.contributingplayers ) )
    {
        self.contributingplayers = [];
    }
    
    if ( !arraycontains( self.contributingplayers, player ) )
    {
        self.contributingplayers[ self.contributingplayers.size ] = player;
    }
}

// Namespace br_quest_util
// Params 0
// Checksum 0xc9526928, Offset: 0x747c
// Size: 0x24
function function_53e65e7cba4b09db()
{
    if ( isdefined( level.var_941fc1b70b63fdab ) )
    {
        return [[ level.var_941fc1b70b63fdab ]]();
    }
    
    return level.contractmanager;
}

// Namespace br_quest_util
// Params 5
// Checksum 0xda094286, Offset: 0x74a9
// Size: 0x11f
function givequestrewardsinstance( team, rewardorigin, rewardangles, rewardscriptable, players )
{
    /#
        function_a65f25c1da281772();
    #/
    
    if ( !isdefined( players ) )
    {
        players = teams::getteamdata( team, "players" );
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.missionparticipation ) )
        {
            player.missionparticipation = 1;
        }
        else
        {
            player.missionparticipation++;
        }
        
        player br_plunder::packextrascore0();
    }
    
    return givequestrewards( self.questcategory, self.rewardmodifier, self.modifier, team, rewardorigin, rewardangles, rewardscriptable, players );
}

// Namespace br_quest_util
// Params 8
// Checksum 0xf6909180, Offset: 0x75d1
// Size: 0x6f
function givequestrewards( category, rewardmod, questmod, team, rewardorigin, rewardangles, rewardscriptable, players )
{
    group = getquestrewardbuildgroupref( category, rewardmod, questmod );
    return givequestrewardgroup( group, team, rewardorigin, rewardangles, rewardscriptable, players );
}

// Namespace br_quest_util
// Params 7
// Checksum 0x6fe26a58, Offset: 0x7649
// Size: 0x185
function givequestrewardgroup( group, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex )
{
    results = [];
    level.currentrewarddropindex = 0;
    
    if ( !isdefined( players ) )
    {
        players = br_contract_manager::function_85e5094486ad4b57( team, squadindex );
    }
    
    utility::callsharedfunc( #"gametype", #"hash_b5249490580ccb18", group, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex );
    rewards = getquestrewardgroupstablerewards( group, team );
    
    foreach ( rewardref in rewards )
    {
        [ reward, value ] = givequestrewardref( rewardref, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex );
        
        if ( isdefined( results[ reward ] ) )
        {
            if ( isstring( results[ reward ] ) )
            {
                results[ reward ] = results[ reward ] + "," + value;
            }
            else
            {
                results[ reward ] += value;
            }
            
            continue;
        }
        
        results[ reward ] = value;
    }
    
    level.currentrewarddropindex = undefined;
    return results;
}

// Namespace br_quest_util
// Params 7
// Checksum 0x5d051d09, Offset: 0x77d7
// Size: 0x9d
function givequestrewardref( rewardref, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex )
{
    tier = getquestrewardtier( team, squadindex );
    rewardtype = getquestrewardstabletype( rewardref );
    value = getquestrewardstablevalue( rewardref, rewardtype, team );
    value = givequestreward( rewardtype, value, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex );
    return [ rewardtype, value ];
}

// Namespace br_quest_util
// Params 8
// Checksum 0x74c609fd, Offset: 0x787d
// Size: 0x5cb
function givequestreward( type, value, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_ef6173cee716461" ) )
    {
        [ completed, value ] = utility::callsharedfunc( #"gametype", #"hash_ef6173cee716461", type, value, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex );
        
        if ( completed )
        {
            return value;
        }
    }
    
    switch ( type )
    {
        case #"hash_59b8e9d05b31ff9":
            if ( level.br_plunder_enabled )
            {
                value = br_contract_manager::function_f4a5876cbb7cf34( team, value );
                participantplunder = isdefined( rewardscriptable ) && istrue( rewardscriptable.participantplunder );
                
                if ( game_utility::getgametype() != "plunder" && !participantplunder )
                {
                    giveteamplunderflat( team, value, undefined, squadindex, players );
                }
                else if ( players.size > 0 )
                {
                    if ( isbrgamemode() )
                    {
                        giveteamplunderflat( team, value, 1, squadindex, players );
                    }
                    else
                    {
                        giveteamplunderdistributive( team, value, squadindex, players );
                    }
                }
                else
                {
                    value = 0;
                }
            }
            else
            {
                value = 0;
            }
            
            break;
        case #"hash_fa66c6f6bd945535":
            if ( isdefined( rewardscriptable ) && rewardscriptable.participantxp && isdefined( players ) )
            {
                rewardplayers = players;
            }
            else
            {
                rewardplayers = br_contract_manager::function_85e5094486ad4b57( team, squadindex );
            }
            
            foreach ( player in rewardplayers )
            {
                player thread points::doscoreevent( #"br_missioncomplete", undefined, undefined, value, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
                weaponxp = int( value * 0.2 );
                lastweaponobj = player.lastnormalweaponobj;
                player br::givebrweaponxp( #"", weaponxp, lastweaponobj, 0, 0 );
                player.br_contractxpearned = utility::get_int_or_0( player.br_contractxpearned ) + value;
            }
            
            break;
        case #"hash_5c95c522c7b782c2":
            if ( isdefined( rewardscriptable ) && rewardscriptable.participantweaponxp && isdefined( players ) )
            {
                rewardplayers = players;
            }
            else
            {
                rewardplayers = br_contract_manager::function_85e5094486ad4b57( team, squadindex );
            }
            
            foreach ( player in rewardplayers )
            {
                lastweaponobj = player.lastnormalweaponobj;
                player br::givebrweaponxp( #"", value, lastweaponobj, 0, 0 );
            }
            
            break;
        case #"hash_3fcca127b49609dc":
            if ( game_utility::getgametype() != "plunder" )
            {
                items = getscriptablelootcachecontents( rewardscriptable );
                questrewarddropitems( team, rewardorigin, rewardangles, undefined, items );
            }
            
            break;
        case #"hash_4f00b29797aa9132":
            items = getscriptablelootcachecontents( rewardscriptable );
            questrewarddropitems( team, rewardorigin, rewardangles, undefined, items );
            break;
        case #"hash_f63eaf7a297850fc":
            items = strtok( value, " " );
            questrewarddropitems( team, rewardorigin, rewardangles, undefined, items );
            break;
        case #"hash_161f0250e7e8e1b5":
            teamplayer = br_contract_manager::function_85e5094486ad4b57( team, squadindex )[ 0 ];
            calldropbag( teamplayer, rewardorigin );
            break;
        case #"hash_5a20d43f09c87c1d":
            questrewardcirclepeek( team, squadindex );
            break;
        case #"hash_bee67d6e01f8331f":
            thread br_contract_manager::addquestrewardtierframeend( value, team, squadindex );
            break;
        case #"hash_4938974347fbe589":
            blueprintextract = br_blueprint_extract_spawn::blueprintextract_trygetreward( rewardorigin );
            
            if ( isdefined( blueprintextract ) )
            {
                br_blueprint_extract_spawn::blueprintextract_beforepickupspawned( team );
                items = [ blueprintextract ];
                questrewarddropitems( team, items, rewardorigin, rewardangles, 0 );
                displayteamsplash( team, "br_blueprint_extract_quest_spawned" );
            }
            
            break;
        case #"hash_634b246c3da5c56f":
            uavplayer = getclosestplayerforreward( team, players, rewardorigin );
            
            if ( isdefined( uavplayer ) )
            {
                uavplayer thread questrewarduav( value );
            }
            
            break;
        case #"hash_22ec6d5e437a8571":
            function_175a225ddbd5e9d4( team, players, rewardorigin, rewardscriptable );
            break;
        case #"hash_4ad475e6e15635bd":
            if ( !level.var_236a38f198a8e72a )
            {
                assertmsg( "<dev string:x57d>" + "<dev string:x59c>" );
            }
            else
            {
                overridestruct = { #dropradius:300, #droporigin:rewardorigin };
                airdrop_scriptbundle::startairdrop( level.var_236a38f198a8e72a, undefined, undefined, overridestruct );
            }
            
            break;
        case #"hash_43e76e9ca2c4666":
            closestplayer = getclosestplayerforreward( team, players, rewardorigin );
            utility::callsharedfunc( #"gametype", #"hash_f858d01d5bc62840", type, value, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex, closestplayer );
            break;
        case #"hash_db653a4972b3c13b":
            break;
        default:
            assertmsg( "<dev string:x5f3>" + type + "<dev string:xcd>" );
            break;
    }
    
    return value;
}

// Namespace br_quest_util
// Params 3
// Checksum 0xcd2e20da, Offset: 0x7e51
// Size: 0xf7
function getclosestplayerforreward( team, players, rewardorigin )
{
    if ( players.size > 0 )
    {
        possibleplayers = players;
    }
    else
    {
        possibleplayers = teams::getteamdata( team, "players" );
    }
    
    closestplayer = undefined;
    closestplayerdist = undefined;
    
    foreach ( player in possibleplayers )
    {
        dist = distance2d( player.origin, rewardorigin );
        
        if ( !isdefined( closestplayerdist ) || dist < closestplayerdist )
        {
            closestplayerdist = dist;
            closestplayer = player;
        }
    }
    
    return closestplayer;
}

// Namespace br_quest_util
// Params 0
// Checksum 0x44dbe753, Offset: 0x7f51
// Size: 0x107
function setupcirclepeek()
{
    if ( level.br_circle_disabled || level.br_level.staticcircle )
    {
        return;
    }
    
    assert( !isdefined( level.circlepeeks ), "<dev string:x60f>" );
    level.circlepeeks = [];
    level.teamswithcirclepeek = [];
    
    for ( index = 1; index < level.br_level.br_circleradii.size ; index++ )
    {
        circleradius = level.br_level.br_circleradii[ index ];
        circleorigin = level.br_level.br_circlecenters[ index ];
        level.circlepeeks[ index ] = spawnstruct();
        level.circlepeeks[ index ] game_utility::questcircle_create( "PeekCircle_Br", circleorigin, circleradius );
        level.circlepeeks[ index ] game_utility::questcircle_hidefromall();
    }
    
    level thread circlepeekcleanup();
}

// Namespace br_quest_util
// Params 0
// Checksum 0xbd15f05, Offset: 0x8060
// Size: 0xf6
function circlepeekcleanup()
{
    self endon( #"game_ended" );
    level endon( #"hash_161c3d8f1cc2d1ea" );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        level.circlepeeks[ level.br_circle.circleindex + 1 ] game_utility::questcircle_delete();
        
        foreach ( team in getarraykeys( level.teamswithcirclepeek ) )
        {
            level.teamswithcirclepeek[ team ]--;
            
            if ( level.teamswithcirclepeek[ team ] < 0 )
            {
                level.teamswithcirclepeek[ team ] = 0;
            }
        }
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0x9c081747, Offset: 0x815e
// Size: 0x27
function questrewardcirclepeek( team, squadindex )
{
    if ( isdefined( squadindex ) )
    {
        return;
    }
    
    br_circle_peek::function_6de0d379275546d1( team );
}

// Namespace br_quest_util
// Params 1
// Checksum 0xd8da9dfe, Offset: 0x818d
// Size: 0x74
function getquesttablerewardgroup( category )
{
    utilstruct = function_53e65e7cba4b09db();
    group = utilstruct.rewards.categorytogroup[ category ];
    
    if ( !isdefined( group ) )
    {
        group = tablelookup( "mp/brmissions.csv", 1, category, 7 );
        utilstruct.rewards.categorytogroup[ category ] = group;
    }
    
    return group;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x7ca9a66c, Offset: 0x820a
// Size: 0xe8
function getquestrewardgroupstablerewards( group, team )
{
    var_590ca8590c0f26c7 = getquestrewardsgrouptable();
    utilstruct = function_53e65e7cba4b09db();
    rewards = utilstruct.rewards.grouptorewards[ group ];
    
    if ( !isdefined( rewards ) )
    {
        rewards = [];
        rewardcol = 2;
        
        for ( i = 0; true ; i++ )
        {
            ref = tablelookup( var_590ca8590c0f26c7, 0, group, rewardcol );
            
            if ( ref == "" )
            {
                break;
            }
            
            rewards[ i ] = ref;
            rewardcol++;
        }
        
        if ( isdefined( level.brmodevariantrewardcullfunc ) )
        {
            rewards = [[ level.brmodevariantrewardcullfunc ]]( rewards );
        }
        
        utilstruct.rewards.grouptorewards[ group ] = rewards;
    }
    
    return rewards;
}

// Namespace br_quest_util
// Params 2
// Checksum 0x3cbff4bb, Offset: 0x82fb
// Size: 0x105
function function_8bc5caab400ddd74( group, team )
{
    var_590ca8590c0f26c7 = getquestrewardsgrouptable();
    utilstruct = function_53e65e7cba4b09db();
    rewards = utilstruct.rewards.grouptorewards[ group ];
    
    if ( !isdefined( rewards ) )
    {
        rewards = [];
        rewardcol = 2;
        scalercol = 3;
        
        while ( true )
        {
            ref = tablelookup( var_590ca8590c0f26c7, 0, group, rewardcol );
            
            if ( ref == "" )
            {
                break;
            }
            
            scaler = tablelookup( var_590ca8590c0f26c7, 0, group, scalercol );
            rewards[ ref ] = scaler;
            rewardcol += 2;
            scalercol += 2;
        }
        
        if ( isdefined( level.brmodevariantrewardcullfunc ) )
        {
            rewards = [[ level.brmodevariantrewardcullfunc ]]( rewards );
        }
        
        utilstruct.rewards.grouptorewards[ group ] = rewards;
    }
    
    return rewards;
}

// Namespace br_quest_util
// Params 1
// Checksum 0x6bfdfd85, Offset: 0x8409
// Size: 0x80
function getquestrewardstabletype( reward )
{
    rewardtable = function_6d363b5bdd7b0224();
    utilstruct = function_53e65e7cba4b09db();
    type = utilstruct.rewards.rewardtotype[ reward ];
    
    if ( !isdefined( type ) )
    {
        type = tablelookup( rewardtable, 0, reward, 1 );
        utilstruct.rewards.rewardtotype[ reward ] = type;
    }
    
    return type;
}

// Namespace br_quest_util
// Params 3
// Checksum 0xc8854772, Offset: 0x8492
// Size: 0x162
function getquestrewardstablevalue( rewardref, rewardtype, team )
{
    rewardtable = function_6d363b5bdd7b0224();
    utilstruct = function_53e65e7cba4b09db();
    value = utilstruct.rewards.rewardtovalue[ rewardref ];
    
    if ( !isdefined( value ) )
    {
        columnindex = getquestrewardstablevaluecolumnindex();
        value = tablelookup( rewardtable, 0, rewardref, columnindex );
        type = getquestrewardstabletype( rewardref );
        value = castrewardvalue( type, value );
        utilstruct.rewards.rewardtovalue[ rewardref ] = value;
    }
    
    if ( level.bmoovertime && !isstring( value ) )
    {
        value = int( value * level.overtimecashmultiplier );
    }
    
    if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ team ] ) && level.contractmanager.var_ec04bf3a584cbd90[ team ].contractoractive && !isstring( value ) && rewardtype == "plunder" )
    {
        value = int( value * level.br_pe_data[ %"contractor" ].var_2371647dff4b6751 );
    }
    
    return value;
}

// Namespace br_quest_util
// Params 0
// Checksum 0x4cf03683, Offset: 0x85fd
// Size: 0x8b
function getquestrewardstablevaluecolumnindex()
{
    assert( isdefined( level.maxteamsize ) );
    teamsize = level.maxteamsize;
    
    if ( br_public::istutorial() )
    {
        teamsize = 1;
    }
    
    switch ( teamsize )
    {
        case 4:
            return 10;
        case 3:
            return 9;
        case 2:
            return 8;
        case 1:
            return 7;
        default:
            return 9;
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0xbb3daa64, Offset: 0x8690
// Size: 0xe2
function function_bd95882dfd5d6665( ref )
{
    utilstruct = function_53e65e7cba4b09db();
    info = utilstruct.rewards.scalertoscaleinfo[ ref ];
    
    if ( !isdefined( info ) )
    {
        info = [];
        tiercol = 1;
        scalercol = 2;
        
        while ( true )
        {
            tier = tablelookup( "mp/brmission_reward_scalers.csv", 0, ref, tiercol );
            
            if ( tier == "" )
            {
                break;
            }
            
            tier = int( tier );
            scaler = float( tablelookup( "mp/brmission_reward_scalers.csv", 0, ref, scalercol ) );
            info[ tier ] = scaler;
            tiercol += 2;
            scalercol += 2;
        }
        
        utilstruct.rewards.scalertoscaleinfo[ ref ] = info;
    }
    
    return info;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xbd7d3fad, Offset: 0x877b
// Size: 0x2f
function getquestplunderrewardinstance( tier )
{
    return getquestplunderreward( self.questcategory, tier, self.modifier, self.rewardmodifier );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x84bd08b1, Offset: 0x87b3
// Size: 0x2f
function getquestxprewardinstance( tier )
{
    return getquestxpreward( self.questcategory, tier, self.modifier, self.rewardmodifier );
}

// Namespace br_quest_util
// Params 1
// Checksum 0x2fcab277, Offset: 0x87eb
// Size: 0x2f
function getquestweaponxprewardinstance( tier )
{
    return getquestweaponxpreward( self.questcategory, tier, self.modifier, self.rewardmodifier );
}

// Namespace br_quest_util
// Params 4
// Checksum 0x71346134, Offset: 0x8823
// Size: 0x47
function getquestplunderreward( category, tier, questmodifier, rewardmodifier )
{
    if ( !level.br_plunder_enabled )
    {
        return 0;
    }
    
    return function_8afbf9348250a768( category, tier, "plunder", questmodifier, rewardmodifier );
}

// Namespace br_quest_util
// Params 4
// Checksum 0x95f28970, Offset: 0x8873
// Size: 0x38
function getquestxpreward( category, tier, questmodifier, rewardmodifier )
{
    return function_8afbf9348250a768( category, tier, "xp", questmodifier, rewardmodifier );
}

// Namespace br_quest_util
// Params 4
// Checksum 0xfd34041f, Offset: 0x88b4
// Size: 0x38
function getquestweaponxpreward( category, tier, questmodifier, rewardmodifier )
{
    return function_8afbf9348250a768( category, tier, "weapon_xp", questmodifier, rewardmodifier );
}

// Namespace br_quest_util
// Params 5
// Checksum 0x57dd69c5, Offset: 0x88f5
// Size: 0x127
function function_8afbf9348250a768( category, tier, type, questmodifier, rewardmodifier )
{
    group = getquesttablerewardgroup( category );
    getquestrewardbuildgroupref( category, rewardmodifier, questmodifier );
    rewards = function_8bc5caab400ddd74( group );
    value = 0;
    
    foreach ( rewardref, scalerref in rewards )
    {
        rewardtype = getquestrewardstabletype( rewardref );
        
        if ( rewardtype == type )
        {
            basevalue = getquestrewardstablevalue( rewardref, rewardtype );
            scale = function_f031cc1f73280c56( scalerref, tier );
            value += basevalue * scale;
        }
    }
    
    value = castrewardvalue( type, value );
    return value;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xb86ec6fb, Offset: 0x8a25
// Size: 0x76
function function_f031cc1f73280c56( scalerref, tier )
{
    scaler = 1;
    info = function_bd95882dfd5d6665( scalerref );
    add = 0;
    
    for ( i = 1; i <= tier ; i++ )
    {
        if ( isdefined( info[ i ] ) )
        {
            add = info[ i ];
        }
        
        scaler += add;
    }
    
    return scaler;
}

// Namespace br_quest_util
// Params 2
// Checksum 0xbc9e3b5d, Offset: 0x8aa4
// Size: 0xf2
function getquestperkbonus( team, newquest = 0 )
{
    perkbonus = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        if ( player.hasbettermissionrewards )
        {
            perkbonus++;
        }
    }
    
    if ( isdefined( level.questinfo.maxperkbonustier[ team ] ) && !newquest )
    {
        perkbonus = int( min( perkbonus, level.questinfo.maxperkbonustier[ team ] ) );
    }
    
    return perkbonus;
}

// Namespace br_quest_util
// Params 5
// Checksum 0x630ddd0e, Offset: 0x8b9f
// Size: 0x19c
function questrewarddropitems( team, origin, angles, cachename, items )
{
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawneditems = [];
    
    if ( isdefined( cachename ) )
    {
        var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( cachename );
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            spawneditems = common_item::function_38cde6a6acb68ea6( var_f67995529827f79.spawnlistname, var_f67995529827f79.var_185d29f84c8dc710, spawnoptions );
        }
    }
    
    if ( isdefined( items ) )
    {
        foreach ( item in items )
        {
            spawneditem = common_item::function_57b88e025e5fb03e( item, undefined, spawnoptions );
            spawneditems[ spawneditems.size ] = spawneditem;
        }
    }
    
    foreach ( item in spawneditems )
    {
        item.team = team;
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x7f52ece8, Offset: 0x8d43
// Size: 0x6b
function questrewarduav( uavtype )
{
    streakinfo = killstreak_utility::createstreakinfo( uavtype, self );
    streakinfo.skipequippedstreakcheck = 1;
    streakinfo.var_16f8d415b9d7937 = 0;
    
    if ( uavtype == "directional_uav" )
    {
        streakinfo.overridetime = getdvarint( @"hash_df0bf19d56f89b93", 20 );
    }
    
    uav::tryuseuavfromstruct( streakinfo );
}

// Namespace br_quest_util
// Params 3
// Checksum 0x6e3327bb, Offset: 0x8db6
// Size: 0x84
function getquestrewardbuildgroupref( category, rewardmod, questmod )
{
    groupbase = getquesttablerewardgroup( category );
    group = groupbase;
    
    if ( isdefined( questmod ) )
    {
        group += questmod;
    }
    
    if ( isdefined( rewardmod ) )
    {
        group += rewardmod;
    }
    
    if ( questrewardgroupexist( group ) )
    {
        return group;
    }
    
    group = groupbase;
    
    if ( isdefined( rewardmod ) )
    {
        group += rewardmod;
    }
    
    if ( questrewardgroupexist( group ) )
    {
        return group;
    }
    
    return groupbase;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xa4f821a1, Offset: 0x8e43
// Size: 0x3a, Type: bool
function questrewardgroupexist( groupref )
{
    var_590ca8590c0f26c7 = getquestrewardsgrouptable();
    ref = tablelookup( var_590ca8590c0f26c7, 0, groupref, 0 );
    return ref != "";
}

// Namespace br_quest_util
// Params 1
// Checksum 0x9bd8d7c7, Offset: 0x8e86
// Size: 0xfb
function getrewardvaluetype( rewardtype )
{
    switch ( rewardtype )
    {
        case #"hash_59b8e9d05b31ff9":
        case #"hash_161f0250e7e8e1b5":
        case #"hash_3fcca127b49609dc":
        case #"hash_4938974347fbe589":
        case #"hash_4ad475e6e15635bd":
        case #"hash_4f00b29797aa9132":
        case #"hash_5a20d43f09c87c1d":
        case #"hash_5c95c522c7b782c2":
        case #"hash_bee67d6e01f8331f":
        case #"hash_db653a4972b3c13b":
        case #"hash_fa66c6f6bd945535":
            return "int";
        case #"hash_43e76e9ca2c4666":
        case #"hash_22ec6d5e437a8571":
        case #"hash_634b246c3da5c56f":
        case #"hash_f63eaf7a297850fc":
            return "string";
        default:
            assertmsg( "<dev string:x5f3>" + rewardtype + "<dev string:xcd>" );
            break;
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0xf924c0f6, Offset: 0x8f89
// Size: 0xb6
function castrewardvalue( rewardtype, value )
{
    type = getrewardvaluetype( rewardtype );
    
    if ( !isdefined( type ) )
    {
        assertmsg( "<dev string:x657>" );
        return value;
    }
    
    switch ( type )
    {
        case #"hash_4730906c2f53f03e":
            value = int( value );
            break;
        case #"hash_3e4a6f464c850b65":
            value = float( value );
            break;
        case #"hash_2ac140ce3b5ea398":
            value = string( value );
            break;
        default:
            assertmsg( "<dev string:x685>" + type + "<dev string:xcd>" );
            break;
    }
    
    return value;
}

// Namespace br_quest_util
// Params 0
// Checksum 0xdd1b88cf, Offset: 0x9048
// Size: 0x38
function getquestrewardsgrouptable()
{
    var_590ca8590c0f26c7 = getmatchrulesdata( "brData", "brMissionRewardGroupsTable" );
    
    if ( !isdefined( var_590ca8590c0f26c7 ) || var_590ca8590c0f26c7 == "" )
    {
        var_590ca8590c0f26c7 = "mp/brmission_reward_groups.csv";
    }
    
    return var_590ca8590c0f26c7;
}

// Namespace br_quest_util
// Params 0
// Checksum 0xc15444f6, Offset: 0x9089
// Size: 0x38
function function_6d363b5bdd7b0224()
{
    rewardstable = getmatchrulesdata( "brData", "brMissionRewardTable" );
    
    if ( !isdefined( rewardstable ) || rewardstable == "" )
    {
        rewardstable = "mp/brmission_rewards.csv";
    }
    
    return rewardstable;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xdb4f32a8, Offset: 0x90ca
// Size: 0x2d
function getquestrewardgroupindex( group )
{
    var_590ca8590c0f26c7 = getquestrewardsgrouptable();
    return int( tablelookup( var_590ca8590c0f26c7, 0, group, 1 ) );
}

// Namespace br_quest_util
// Params 4
// Checksum 0x881a632e, Offset: 0x9100
// Size: 0x281
function function_7f45d5f62d37f918( team, players, rewardorigin, rewardscriptable = undefined )
{
    activekiosks = [];
    
    if ( isdefined( rewardscriptable ) )
    {
        if ( rewardscriptable.var_ea4a540642460712 || rewardscriptable.isdeployablekiosk && rewardscriptable.isinteractable )
        {
            return rewardscriptable;
        }
        
        if ( rewardscriptable.visible && isdefined( rewardscriptable.index ) )
        {
            return rewardscriptable;
        }
    }
    
    allkiosks = common_kiosk::function_5c2447fa1580c330();
    
    if ( isdefined( allkiosks ) )
    {
        foreach ( kiosk in allkiosks )
        {
            if ( kiosk.visible )
            {
                activekiosks[ activekiosks.size ] = kiosk;
            }
        }
    }
    
    if ( isdefined( level.deployablekiosks.buystations ) )
    {
        foreach ( kiosk in level.deployablekiosks.buystations )
        {
            if ( kiosk.isinteractable )
            {
                activekiosks[ activekiosks.size ] = kiosk;
            }
        }
    }
    
    if ( !activekiosks.size )
    {
        return;
    }
    
    locations = arrayrandomize( activekiosks );
    closestkiosk = undefined;
    shortestdist = undefined;
    
    foreach ( kiosk in locations )
    {
        currentdist = distance2d( kiosk.origin, rewardorigin );
        
        if ( !isdefined( shortestdist ) || shortestdist > currentdist )
        {
            shortestdist = currentdist;
            closestkiosk = kiosk;
        }
    }
    
    return closestkiosk;
}

// Namespace br_quest_util
// Params 4
// Checksum 0x982b74, Offset: 0x938a
// Size: 0xc6
function function_175a225ddbd5e9d4( team, players, rewardorigin, rewardscriptable = undefined )
{
    kiosk = function_7f45d5f62d37f918( team, players, rewardorigin, rewardscriptable );
    
    if ( !isdefined( kiosk ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            br_common_kiosk::kiosksetupfiresaleforplayer( kiosk, player );
        }
    }
}

// Namespace br_quest_util
// Params 2
// Checksum 0x6d7833d, Offset: 0x9458
// Size: 0x5c
function getquestrewardtier( team, squadindex )
{
    utilstruct = function_53e65e7cba4b09db();
    idx = br_contract_manager::selectindex( team, squadindex );
    tier = utilstruct.tiers[ idx ];
    
    if ( !isdefined( tier ) )
    {
        tier = 0;
    }
    
    return tier;
}

// Namespace br_quest_util
// Params 3
// Checksum 0x39d904df, Offset: 0x94bd
// Size: 0x5e
function setquestrewardtier( team, tier, squadindex )
{
    utilstruct = function_53e65e7cba4b09db();
    idx = br_contract_manager::selectindex( team, squadindex );
    utilstruct.tiers[ idx ] = tier;
    setquestrewardtierteamomnvar( team, tier, squadindex );
}

// Namespace br_quest_util
// Params 3
// Checksum 0x5637770e, Offset: 0x9523
// Size: 0x35
function addquestrewardtier( team, value, squadindex )
{
    setquestrewardtier( team, getquestrewardtier( team, squadindex ) + value, squadindex );
}

// Namespace br_quest_util
// Params 3
// Checksum 0x44b37220, Offset: 0x9560
// Size: 0x36
function addquestrewardtierframeend( team, value, squadindex )
{
    waittillframeend();
    setquestrewardtier( team, getquestrewardtier( team, squadindex ) + value, squadindex );
}

// Namespace br_quest_util
// Params 2
// Checksum 0x80cbbdd7, Offset: 0x959e
// Size: 0x93
function setquestindexteamomnvar( team, questindex )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player setquestindexomnvar( questindex );
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x26f331d8, Offset: 0x9639
// Size: 0x23
function setquestindexomnvar( questindex )
{
    /#
        function_e4ac44a582699ee0();
    #/
    
    self setclientomnvar( "ui_br_objective_index", questindex );
}

// Namespace br_quest_util
// Params 3
// Checksum 0xbfe6a025, Offset: 0x9664
// Size: 0xa4
function setquestrewardtierteamomnvar( team, tier, squadindex )
{
    players = br_contract_manager::function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        player setquestrewardtieromnvar( tier );
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x65d33bd8, Offset: 0x9710
// Size: 0x23
function setquestrewardtieromnvar( tier )
{
    /#
        function_e4ac44a582699ee0();
    #/
    
    self setclientomnvar( "ui_br_objective_reward_tier", tier );
}

// Namespace br_quest_util
// Params 0
// Checksum 0xc705d890, Offset: 0x973b
// Size: 0x106
function cancelallmissions()
{
    foreach ( quest in level.questinfo.quests )
    {
        foreach ( instance in quest.instances )
        {
            instance.result = "cancel";
            instance removequestinstance();
        }
    }
}

// Namespace br_quest_util
// Params 1
// Checksum 0x9269136b, Offset: 0x9849
// Size: 0x3ad
function getallactivequestsforteam( team )
{
    results = [];
    
    foreach ( quest in level.questinfo.quests )
    {
        foreach ( id, instance in quest.instances )
        {
            if ( id != team )
            {
                continue;
            }
            
            if ( isquestinstancealocale( instance ) )
            {
                continue;
            }
            
            questinfo = spawnstruct();
            questinfo.instance = instance;
            
            switch ( instance.category )
            {
                case #"hash_96e641d7fe5b1cf1":
                    if ( isdefined( instance.targetplayer ) )
                    {
                        questinfo.origin = instance.targetplayer.origin;
                    }
                    
                    break;
                case #"hash_1cc92bad632fbc15":
                    if ( isdefined( instance.subscribedlocale ) && isdefined( instance.subscribedlocale.domflag ) && isdefined( instance.subscribedlocale.domflag.curorigin ) )
                    {
                        questinfo.origin = instance.subscribedlocale.domflag.curorigin + ( 0, 0, 60 );
                    }
                    
                    break;
                case #"hash_5c57b61aa79410db":
                    if ( isdefined( instance.subscribedlocale.cacheentity.origin ) && isdefined( instance.subscribedlocale.cacheentity ) )
                    {
                        questinfo.origin = instance.subscribedlocale.cacheentity.origin + ( 0, 0, 50 );
                    }
                    
                    break;
                case #"hash_d0eb63c46c25ef55":
                    break;
                case #"hash_97546a43dd1105ce":
                    if ( isdefined( instance.cacheentity ) && isdefined( instance.cacheentity.origin ) )
                    {
                        questinfo.origin = instance.cacheentity.origin + ( 0, 0, 50 );
                    }
                    
                    break;
                case #"hash_de61e484b9734ea1":
                    break;
                case #"hash_cc7c1c701864c7bf":
                    break;
                case #"hash_96815ed47cc355cf":
                    break;
                case #"hash_d0eb8b9de6742b83":
                    break;
                case #"hash_d50a09e505e005f1":
                    break;
                case #"hash_7b0c576c4a7e4890":
                    break;
                case #"hash_d43a3732d39e4a11":
                    break;
                default:
                    assertmsg( "<dev string:x6a7>" + instance.category );
                    break;
            }
            
            results[ results.size ] = questinfo;
        }
    }
    
    return results;
}

// Namespace br_quest_util
// Params 1
// Checksum 0xf29a0a43, Offset: 0x9bff
// Size: 0x64
function getquestunlockableindexfromlootid( lootid )
{
    unlockabledata = level.questinfo.unlockables[ lootid ];
    
    if ( !isdefined( unlockabledata ) )
    {
        assert( "<dev string:x6c0>" + lootid + "<dev string:x6ef>" + "<dev string:x709>" + "<dev string:x726>" );
        return 0;
    }
    
    return unlockabledata.unlockableindex;
}

// Namespace br_quest_util
// Params 0
// Checksum 0xd35b5c79, Offset: 0x9c6c
// Size: 0x172
function getrandomextractunlockablelootid()
{
    chancetotal = 0;
    
    foreach ( unlockabledata in level.questinfo.unlockables )
    {
        chancetotal += unlockabledata.extractunlockablechance;
    }
    
    randomroll = randomfloatrange( 0, chancetotal );
    chancecurrent = 0;
    
    foreach ( unlockabledata in level.questinfo.unlockables )
    {
        chancecurrent += unlockabledata.extractunlockablechance;
        
        if ( randomroll <= chancecurrent )
        {
            return unlockabledata.lootid;
        }
    }
    
    assert( "<dev string:x728>" );
    return level.questinfo.unlockables[ 0 ].lootid;
}

/#

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x18b21e8b, Offset: 0x9de7
    // Size: 0x11, Type: dev
    function function_a65f25c1da281772()
    {
        function_841b3c7627f3d30d( "<dev string:xf5>" );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0xc3793319, Offset: 0x9e00
    // Size: 0x11, Type: dev
    function function_984e3602904184b7()
    {
        function_841b3c7627f3d30d( "<dev string:x267>" );
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0xa14de345, Offset: 0x9e19
    // Size: 0x53, Type: dev
    function function_841b3c7627f3d30d( type )
    {
        selftype = self.debugtype;
        
        if ( !isdefined( selftype ) )
        {
            selftype = "<dev string:x77b>";
        }
        
        assert( type == selftype, "<dev string:x787>" + type + "<dev string:x797>" + selftype + "<dev string:x7a8>" );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x50de28b3, Offset: 0x9e74
    // Size: 0x16, Type: dev
    function function_9b63c0e88a433955()
    {
        function_26a924ca9b8c0bb2( "<dev string:xf5>", "<dev string:x267>" );
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0xccbc1bc8, Offset: 0x9e92
    // Size: 0x6d, Type: dev
    function function_26a924ca9b8c0bb2( type_a, type_b )
    {
        selftype = self.debugtype;
        
        if ( !isdefined( selftype ) )
        {
            selftype = "<dev string:x77b>";
        }
        
        assert( type_a == selftype || type_b == selftype, "<dev string:x787>" + type_a + "<dev string:x7ab>" + type_b + "<dev string:x797>" + selftype + "<dev string:x7a8>" );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0xdeaa19d9, Offset: 0x9f07
    // Size: 0x17, Type: dev
    function function_e4ac44a582699ee0()
    {
        assert( isplayer( self ), "<dev string:x7b2>" );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x2f44c80c, Offset: 0x9f26
    // Size: 0x2f, Type: dev
    function function_9054d3c68a31b891()
    {
        assert( isdefined( self.type ) && br_pickups::isquesttablet( self.type ), "<dev string:x7d7>" );
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0xfdec4fcd, Offset: 0x9f5d
    // Size: 0x27, Type: dev
    function function_97bf7ae5a8594284( category, func )
    {
        _registerquestfunc( category, func, "<dev string:x7fc>" );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x15a19ca2, Offset: 0x9f8c
    // Size: 0x1f, Type: dev
    function init_quest_debug()
    {
        thread quest_debug_hud();
        thread quest_devgui();
        br_dev::registerhandlecommand( &handledevcommand_quests );
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0xad0110d5, Offset: 0x9fb3
    // Size: 0xc1, Type: dev
    function handledevcommand_quests( command, args )
    {
        switch ( command )
        {
            case #"hash_3fbd7dbc792314ea":
                function_338febd4c3bb0045();
                break;
            case #"hash_9779298a0ee0bed1":
                function_557958d42a2c5936( args[ 0 ] );
                break;
            case #"hash_3646a7f55b1c0ac9":
                function_6a3e448995575f9f( args );
                break;
            case #"hash_c0e656e5de2e359d":
                function_1b4ea531f33bc28b( args );
                break;
            case #"hash_2b40e3c6ce7561c7":
                function_d94f9c7fe22ddad3( args );
                break;
            case #"hash_91c28b828620cf74":
                thread function_cd3f23be0b257668( args[ 0 ] );
                break;
            default:
                break;
        }
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0xdac714a4, Offset: 0xa07c
    // Size: 0x144, Type: dev
    function function_338febd4c3bb0045()
    {
        player = level.player;
        
        if ( !( isdefined( player ) && isdefined( player.team ) ) )
        {
            return;
        }
        
        foreach ( quest in level.questinfo.quests )
        {
            foreach ( id, instance in quest.instances )
            {
                if ( id == player.team )
                {
                    instance.result = "<dev string:x875>";
                    instance removequestinstance();
                }
            }
        }
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0xe30b71e, Offset: 0xa1c8
    // Size: 0x9d, Type: dev
    function function_557958d42a2c5936( category )
    {
        tablet = spawnscriptable( getlootname( category ), level.player.origin + ( 0, 0, 15 ), ( 0, 0, 0 ) );
        tablet tabletinit( category );
        
        if ( tablet.init )
        {
            tablet.keepinmap = 1;
            tablet thread function_84ee2cfb199dc9ed();
        }
        else
        {
            tablet tablethide();
            iprintlnbold( "<dev string:x87b>" );
        }
        
        return tablet;
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0xea95862b, Offset: 0xa26d
    // Size: 0x24, Type: dev
    function function_84ee2cfb199dc9ed()
    {
        self endon( #"death" );
        self waittill( #"questended" );
        self freescriptable();
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0xe4649493, Offset: 0xa299
    // Size: 0x1be, Type: dev
    function function_6a3e448995575f9f( args )
    {
        argteam = args[ 0 ];
        argcategory = args[ 1 ];
        friendlyteam = level.player.team;
        
        if ( !isdefined( friendlyteam ) )
        {
            friendlyteam = "<dev string:x8a5>";
        }
        
        if ( argteam == "<dev string:x8ac>" )
        {
            teams = [ friendlyteam ];
        }
        else if ( argteam == "<dev string:x8b5>" )
        {
            teams = team_utility::getenemyteams( friendlyteam );
        }
        else
        {
            teams = [ argteam ];
        }
        
        missionplayer = undefined;
        
        foreach ( team in teams )
        {
            if ( arraycontains( level.questinfo.teamsonquests, team ) )
            {
                continue;
            }
            
            aliveplayers = teams::getteamdata( team, "<dev string:x8bb>" );
            
            if ( !aliveplayers.size )
            {
                continue;
            }
            
            missionplayer = utility::array_random( aliveplayers );
            break;
        }
        
        if ( !isdefined( missionplayer ) )
        {
            iprintlnbold( "<dev string:x8c8>" + argteam + "<dev string:x8e4>" );
            return;
        }
        
        tablet = function_557958d42a2c5936( argcategory );
        
        if ( isdefined( tablet ) )
        {
            br_pickups::lootused( tablet, tablet.type, "<dev string:x8eb>", missionplayer );
            iprintlnbold( "<dev string:x8f3>" + missionplayer.team + "<dev string:xcd>" );
        }
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x898d7543, Offset: 0xa45f
    // Size: 0xbf, Type: dev
    function function_3cd42393be58318f( queststring )
    {
        var_94265271414d52ba = strtok( queststring, "<dev string:x90b>" );
        questint = 0;
        
        foreach ( tok in var_94265271414d52ba )
        {
            questint |= level.questinfo.debuginfo.var_67e773d49335d70c[ tok ];
        }
        
        return questint;
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x27eb3e25, Offset: 0xa526
    // Size: 0xcb, Type: dev
    function function_184529086f004f5f( i )
    {
        queststring = "<dev string:x90d>";
        
        foreach ( bit, str in level.questinfo.debuginfo.var_b2cc2ca012894c63 )
        {
            if ( i & 1 << bit )
            {
                if ( queststring != "<dev string:x90d>" )
                {
                    queststring += "<dev string:x90b>";
                }
                
                queststring += str;
            }
        }
        
        return queststring;
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x2111a2c5, Offset: 0xa5f9
    // Size: 0x40, Type: dev
    function function_1b4ea531f33bc28b( args )
    {
        showtype = args[ 0 ];
        
        if ( showtype == "<dev string:x90e>" )
        {
            level notify( #"hash_f2bee64de082489e" );
            return;
        }
        
        level thread function_1efe8152bef9247d( showtype );
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x70199107, Offset: 0xa641
    // Size: 0x198, Type: dev
    function function_1efe8152bef9247d( type )
    {
        level notify( #"hash_f2bee64de082489e" );
        level endon( #"hash_f2bee64de082489e" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        typeint = function_3cd42393be58318f( type );
        
        while ( true )
        {
            drawdist = getdvarfloat( @"hash_1929787a187dde7b", 5000 );
            points = getquestpoints( typeint, level.player.origin, drawdist, 0, 1 );
            
            foreach ( point in points )
            {
                sphere( point.origin, 10, ( 0, 1, 0 ), 0, 1 );
                print3d( point.origin, function_184529086f004f5f( point.spawnflags ), ( 0, 1, 1 ), 1, 1, 1, 1 );
                radius = questpointgetradius( point );
                
                if ( radius > 0 )
                {
                    utility::draw_circle( point.origin, radius, ( 1, 1, 0 ), 1, 0, 0 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x9c5a8f50, Offset: 0xa7e1
    // Size: 0x29, Type: dev
    function function_d94f9c7fe22ddad3( args )
    {
        questrewardcirclepeek( level.player.team );
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0xcb987564, Offset: 0xa812
    // Size: 0x20c, Type: dev
    function function_cd3f23be0b257668( enabled )
    {
        level notify( #"hash_57eec1ee472d8a12" );
        level endon( #"hash_57eec1ee472d8a12" );
        
        if ( enabled == "<dev string:x913>" )
        {
            return;
        }
        
        while ( true )
        {
            foreach ( type, info in level.questinfo.tabletinfo )
            {
                tablets = getlootscriptablearray( getlootname( type ) );
                
                foreach ( tablet in tablets )
                {
                    if ( !isdefined( tablet.reservedplacement ) )
                    {
                        continue;
                    }
                    
                    if ( isarray( tablet.reservedplacement ) )
                    {
                        count = tablet.reservedplacement.size;
                        
                        if ( !count )
                        {
                            continue;
                        }
                        
                        for ( i = 1; i < count ; i++ )
                        {
                            placement = tablet.reservedplacement[ i ];
                            function_ba9fe7d3820d92d3( placement, tablet.reservedplacement[ i - 1 ] );
                        }
                        
                        placement = tablet.reservedplacement[ 0 ];
                    }
                    else
                    {
                        placement = tablet.reservedplacement;
                    }
                    
                    debugstar( tablet.origin, ( 0, 1, 0 ), 1, type );
                    function_ba9fe7d3820d92d3( placement, tablet );
                }
            }
            
            waitframe();
        }
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0x6bd8bca0, Offset: 0xaa26
    // Size: 0xf8, Type: dev
    function function_ba9fe7d3820d92d3( placement, from )
    {
        if ( !isdefined( from.circletime ) )
        {
            from.circletime = br_circle::getmintimetillpointindangercircle( from.origin );
        }
        
        if ( !isdefined( placement.circletime ) )
        {
            placement.circletime = br_circle::getmintimetillpointindangercircle( placement.origin );
        }
        
        delta = placement.circletime - from.circletime;
        
        if ( delta <= 0 )
        {
            color = ( 1, 0, 0 );
        }
        else
        {
            color = ( 1, 1, 0 );
        }
        
        line( from.origin, placement.origin, color );
        debugstar( placement.origin, color, 1, string( delta ) );
    }

    // Namespace br_quest_util
    // Params 4
    // Checksum 0xceecece8, Offset: 0xab26
    // Size: 0x8b, Type: dev
    function function_4f8ad1b954f829d0( numerator, denominator, showdenominator, showpercent )
    {
        if ( !isdefined( showdenominator ) )
        {
            showdenominator = 1;
        }
        
        if ( !isdefined( showpercent ) )
        {
            showpercent = 1;
        }
        
        str = string( numerator );
        
        if ( showdenominator )
        {
            str += "<dev string:x917>" + denominator;
        }
        
        if ( showpercent && denominator )
        {
            str += "<dev string:x919>" + function_a121accb813839cf( numerator / denominator, 1 ) + "<dev string:x91c>";
        }
        
        return str;
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0x3626ac24, Offset: 0xabb9
    // Size: 0x49, Type: dev
    function function_a121accb813839cf( frac, decimalplaces )
    {
        if ( !isdefined( decimalplaces ) )
        {
            decimalplaces = 1;
        }
        
        return "<dev string:x90d>" + int( frac * pow( 10, 2 + decimalplaces ) + 0.5 ) / pow( 10, decimalplaces );
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x817732c0, Offset: 0xac0a
    // Size: 0x69e, Type: dev
    function quest_debug_hud()
    {
        setdvarifuninitialized( @"hash_d3c4b3e2a6204d64", 0 );
        setdvarifuninitialized( @"hash_3cec5db77a324ac5", 12 );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        wait 1;
        x_pos = 200;
        y_pos = 40;
        
        while ( true )
        {
            hudelems = [];
            
            while ( !getdvarint( @"hash_d3c4b3e2a6204d64", 0 ) )
            {
                waitframe();
            }
            
            hudheader = function_df5a78db0f20984b();
            hudheader.x = x_pos;
            hudheader.y = y_pos;
            hudheader setdevtext( "<dev string:x91e>" );
            
            while ( getdvarint( @"hash_d3c4b3e2a6204d64", 0 ) )
            {
                huddetail = getdvarint( @"hash_d3c4b3e2a6204d64", 0 );
                var_7fe8e0cbbb1776a7 = 0;
                var_873667154c2af007 = 0;
                
                switch ( huddetail )
                {
                    case 3:
                        var_7fe8e0cbbb1776a7 = 1;
                        var_873667154c2af007 = 0;
                        break;
                    case 2:
                        var_7fe8e0cbbb1776a7 = 0;
                        var_873667154c2af007 = 1;
                        break;
                    case 1:
                    default:
                        var_7fe8e0cbbb1776a7 = 1;
                        var_873667154c2af007 = 1;
                        break;
                }
                
                hudstrings = [];
                
                if ( var_7fe8e0cbbb1776a7 )
                {
                    totalstarting = 0;
                    
                    foreach ( type, count in self.debuginfo.var_9a7f8051bbb7d16c )
                    {
                        totalstarting += count;
                    }
                    
                    totalactive = 0;
                    
                    foreach ( type, count in self.debuginfo.var_8bb4f24fb0a12f10 )
                    {
                        totalactive += count;
                    }
                    
                    hudstrings[ hudstrings.size ] = "<dev string:x92a>" + function_4f8ad1b954f829d0( totalactive, totalstarting );
                    
                    foreach ( type, count in self.debuginfo.var_8bb4f24fb0a12f10 )
                    {
                        hudstrings[ hudstrings.size ] = "<dev string:x934>" + type + "<dev string:x936>" + function_4f8ad1b954f829d0( count, totalstarting, 0 );
                    }
                    
                    hudstrings[ hudstrings.size ] = "<dev string:x939>" + function_4f8ad1b954f829d0( self.debuginfo.tabletsused, totalstarting, 0 );
                    hudstrings[ hudstrings.size ] = "<dev string:x941>" + function_4f8ad1b954f829d0( self.debuginfo.var_acbbb03b6cda49e9, totalstarting, 0 );
                }
                
                if ( var_873667154c2af007 )
                {
                    hudstrings[ hudstrings.size ] = "<dev string:x953>";
                    
                    foreach ( type, quest in level.questinfo.quests )
                    {
                        hudstrings[ hudstrings.size ] = "<dev string:x934>" + type + "<dev string:x95b>" + quest.instances.size + "<dev string:x91c>";
                        
                        foreach ( id, instance in quest.instances )
                        {
                            hudstrings[ hudstrings.size ] = "<dev string:x95d>" + id;
                            instancefunc = level.questinfo.quests[ type ].funcs[ "<dev string:x7fc>" ];
                            
                            if ( isdefined( instancefunc ) )
                            {
                                instancestrings = instance [[ instancefunc ]]();
                                
                                foreach ( str in instancestrings )
                                {
                                    hudstrings[ hudstrings.size ] = "<dev string:x960>" + str;
                                }
                            }
                        }
                    }
                }
                
                count = 0;
                anychange = 0;
                
                for ( i = 0; i < hudstrings.size ; i++ )
                {
                    str = hudstrings[ i ];
                    
                    if ( !isdefined( hudelems[ i ] ) )
                    {
                        hudelems[ i ] = function_df5a78db0f20984b();
                    }
                    
                    if ( !isdefined( hudelems[ i ] ) )
                    {
                        break;
                    }
                    
                    anychange = anychange || str != hudelems[ i ].currenttext;
                    hudelems[ i ].x = x_pos;
                    hudelems[ i ].y = y_pos + 11 * ( i + 1 );
                    count++;
                }
                
                if ( anychange )
                {
                    hudheader clearalltextafterhudelem();
                    
                    for ( i = 0; i < count ; i++ )
                    {
                        hudelems[ i ] setdevtext( hudstrings[ i ] );
                        hudelems[ i ].currenttext = hudstrings[ i ];
                    }
                }
                
                if ( count < hudelems.size )
                {
                    for ( i = hudelems.size - 1; i >= count ; i-- )
                    {
                        hudelems[ i ] destroy();
                        hudelems[ i ] = undefined;
                    }
                }
                
                wait 0.05;
            }
            
            foreach ( hud in hudelems )
            {
                hud destroy();
            }
            
            hudheader destroy();
        }
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0x39638742, Offset: 0xb2b0
    // Size: 0x139, Type: dev
    function function_df5a78db0f20984b()
    {
        fontelem = newhudelem();
        
        if ( isdefined( fontelem ) )
        {
            fontelem.elemtype = "<dev string:x964>";
            fontelem.font = "<dev string:x969>";
            fontelem.fontscale = 1.2;
            fontelem.basefontscale = fontelem.fontscale;
            fontelem.x = 0;
            fontelem.y = 0;
            fontelem.width = 0;
            fontelem.height = int( level.fontheight * fontelem.fontscale );
            fontelem.xoffset = 0;
            fontelem.yoffset = 0;
            fontelem.children = [];
            fontelem hud_util::setparent( level.uiparent );
            fontelem.hidden = 0;
            fontelem.aligny = "<dev string:x971>";
            fontelem.alignx = "<dev string:x975>";
            fontelem.currenttext = "<dev string:x97a>";
            fontelem setdevtext( "<dev string:x97a>" );
        }
        
        return fontelem;
    }

    // Namespace br_quest_util
    // Params 0
    // Checksum 0xf36c9550, Offset: 0xb3f1
    // Size: 0x258, Type: dev
    function quest_devgui()
    {
        debughud = "<dev string:x980>" + "<dev string:x999>";
        thread adddebugcommanddelayed( debughud + "<dev string:x9a6>" + getxhashhexname( @"hash_d3c4b3e2a6204d64" ) + "<dev string:x9c2>" );
        thread adddebugcommanddelayed( debughud + "<dev string:x9c7>" + getxhashhexname( @"hash_d3c4b3e2a6204d64" ) + "<dev string:x9e0>" );
        thread adddebugcommanddelayed( debughud + "<dev string:x9e5>" + getxhashhexname( @"hash_d3c4b3e2a6204d64" ) + "<dev string:x9ff>" );
        thread adddebugcommanddelayed( debughud + "<dev string:xa04>" + getxhashhexname( @"hash_d3c4b3e2a6204d64" ) + "<dev string:xa11>" );
        
        foreach ( type, info in level.questinfo.tabletinfo )
        {
            function_2190fafae6ba4d43( type, "<dev string:xa16>" + type + "<dev string:xa1e>", [ 0, 1 ], info.enabled );
        }
        
        function_2190fafae6ba4d43( "<dev string:xa25>", "<dev string:xa32>", [ 500, 1000, 5000, 10000, 50000 ], 5000 );
        function_2baef23d959c1d7b( "<dev string:x80d>" );
        var_f8c8dba99dd710f = getarraykeys( level.questinfo.tabletinfo );
        function_2baef23d959c1d7b( "<dev string:x81c>", var_f8c8dba99dd710f );
        function_2baef23d959c1d7b( "<dev string:x829>" + "<dev string:xa55>", var_f8c8dba99dd710f );
        function_2baef23d959c1d7b( "<dev string:x829>" + "<dev string:xa5f>", var_f8c8dba99dd710f );
        var_52a9a1d5321cb73b = getarraykeys( level.questinfo.debuginfo.var_67e773d49335d70c );
        var_52a9a1d5321cb73b[ var_52a9a1d5321cb73b.size ] = "<dev string:x90e>";
        function_2baef23d959c1d7b( "<dev string:x83b>", var_52a9a1d5321cb73b );
        function_2baef23d959c1d7b( "<dev string:x860>", [ "<dev string:xa66>", "<dev string:x913>" ] );
        function_2baef23d959c1d7b( "<dev string:x84d>" );
    }

    // Namespace br_quest_util
    // Params 4
    // Checksum 0x939caace, Offset: 0xb651
    // Size: 0x57, Type: dev
    function function_2190fafae6ba4d43( submenu, dvarname, values, defaultvalue )
    {
        devguipath = "<dev string:x980>" + "<dev string:xa69>" + submenu + "<dev string:x917>";
        function_519b9041244ceca7( devguipath, dvarname, values, defaultvalue );
    }

    // Namespace br_quest_util
    // Params 2
    // Checksum 0x3a7dd8fd, Offset: 0xb6b0
    // Size: 0xe5, Type: dev
    function function_2baef23d959c1d7b( cmd, args )
    {
        devguipath = "<dev string:x980>" + "<dev string:xa75>";
        
        if ( isdefined( args ) )
        {
            foreach ( arg in args )
            {
                thread adddebugcommanddelayed( devguipath + cmd + "<dev string:x917>" + arg + "<dev string:xa81>" + cmd + "<dev string:xa93>" + arg + "<dev string:xa95>" );
            }
            
            return;
        }
        
        thread adddebugcommanddelayed( devguipath + cmd + "<dev string:xa81>" + cmd + "<dev string:xa95>" );
    }

    // Namespace br_quest_util
    // Params 4
    // Checksum 0x4c159711, Offset: 0xb79d
    // Size: 0x139, Type: dev
    function function_519b9041244ceca7( devguipath, dvarname, values, defaultvalue )
    {
        if ( isdefined( defaultvalue ) )
        {
            var_e3ef194a97d40c76 = 0;
            
            foreach ( value in values )
            {
                if ( value == defaultvalue )
                {
                    var_e3ef194a97d40c76 = 1;
                    break;
                }
            }
            
            if ( !var_e3ef194a97d40c76 )
            {
                values[ values.size ] = defaultvalue;
            }
        }
        
        var_3ccbaba17a87684c = devguipath + dvarname + "<dev string:x917>";
        
        for ( i = 0; i < values.size ; i++ )
        {
            value = values[ i ];
            isdefault = value == defaultvalue;
            thread adddebugcommanddelayed( var_3ccbaba17a87684c + value + ( isdefault ? "<dev string:xa98>" : "<dev string:xaa4>" ) + i + "<dev string:xaa6>" + dvarname + "<dev string:xa93>" + value + "<dev string:xa95>" );
        }
    }

    // Namespace br_quest_util
    // Params 1
    // Checksum 0x797bf965, Offset: 0xb8de
    // Size: 0x89, Type: dev
    function adddebugcommanddelayed( cmd )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( !isdefined( level.var_e49cfab3144b6e50 ) || level.var_e49cfab3144b6e50 < gettime() )
            {
                level.var_e49cfab3144b6e50 = gettime();
                level.var_bb5ead57ea9e3ac0 = 0;
            }
            
            if ( level.var_bb5ead57ea9e3ac0 < 3 )
            {
                break;
            }
            
            wait 0.05;
        }
        
        level.var_bb5ead57ea9e3ac0++;
        adddebugcommand( cmd );
    }

#/
