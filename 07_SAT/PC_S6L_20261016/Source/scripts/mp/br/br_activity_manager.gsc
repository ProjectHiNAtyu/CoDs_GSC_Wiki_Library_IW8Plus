// scripts\mp\br\br_activity_manager.gsc  (hash_177dd3bc9470a6b5.gscc) (size: 20905 Bytes / 0x51a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4392ca78 (1133693560)
// size ...... 20905 (0x51a9)
// includes .. 25  (offset: 0x4ed1)
// strings ... 35  (offset: 0x4f99)
// dev strs .. 2   (offset: 0x5191)
// exports ... 41  (offset: 0x3675)
// cseg ...... 0x33a + 0x333b (0x3675)
// imports ... 148 (offset: 0x3cdd)
// animtree1 . 0   (offset: 0x51a9)
// animtree2 . 0   (offset: 0x51a9)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\poi;

#namespace br_activity_manager;

// Namespace br_activity_manager
// Params 0, eflags: 0x5
// Checksum 0x13dc496, Offset: 0x358
// Size: 0x40
function private autoexec __init__system__()
{
    system::register( #"br_activity_manager", [ #"common_item", #"activity_common", #"spatial_zone_container" ], &init, undefined );
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0xfa62d266, Offset: 0x3a0
// Size: 0x68
function private init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( !activity_common::function_54d6e6ddd48363b7() )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    var_3c8441d2cace240a = function_7bef2be0b2cda59a();
    
    if ( !isdefined( var_3c8441d2cace240a ) || var_3c8441d2cace240a.size == 0 )
    {
        return;
    }
    
    function_4e9ede7826376974();
    registercallbacks();
    registeractivities();
    function_d47c263e661bd81b();
    level thread function_9824ecddec0fd99f();
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0xe49a78d8, Offset: 0x410
// Size: 0x62e
function private function_4e9ede7826376974()
{
    level.activitymanager = {};
    level.activitymanager.var_cc0e4315eede2fec = [];
    level.activitymanager.var_ec04bf3a584cbd90 = [];
    level.activitymanager.hidepercent = utility::function_48f723fdc612ec65( @"hash_cde23b521b81aa73", 0.7, level.gametypebundle.var_e03c6c6524bde63c );
    level.activitymanager.var_eae36c09cff3d6c0 = utility::function_49a778e73bbb0f58( @"hash_d9a778f31a83da20", "", level.gametypebundle.var_eae36c09cff3d6c0 );
    level.activitymanager.var_3a2cc4e923991ef5 = utility::function_edc4cc03e9e60b3e( @"hash_526a7311f94ae394", 1200, level.gametypebundle.var_9cb095042fb73d82 );
    level.activitymanager.var_ca4984dbd98c87af = utility::function_edc4cc03e9e60b3e( @"hash_bcb0c81517def3a4", 315, level.gametypebundle.var_ca4984dbd98c87af );
    level.activitymanager.var_d2733bebc895f475 = utility::function_edc4cc03e9e60b3e( @"hash_36c299d6f9524df8", 0, level.gametypebundle.var_d2733bebc895f475 );
    level.activitymanager.locationmin = utility::function_edc4cc03e9e60b3e( @"hash_61d045aa9b2d5565", 3, level.gametypebundle.locationmin );
    level.activitymanager.var_f0371c3aaa1db0b7 = utility::function_edc4cc03e9e60b3e( @"hash_d730f6c60eca50fe", 0, level.gametypebundle.var_f0371c3aaa1db0b7 );
    level.activitymanager.lastcircle = utility::function_edc4cc03e9e60b3e( @"hash_96878da693689ccd", 4, level.gametypebundle.lastcircle );
    level.activitymanager.var_6b059ba6e7923b61 = utility::function_edc4cc03e9e60b3e( @"hash_41d708400ba020e1", 5, level.gametypebundle.var_6b059ba6e7923b61 );
    level.activitymanager.var_e44ee9b00344ffc6 = utility::function_edc4cc03e9e60b3e( @"hash_8152d3da5f317323", 0, level.gametypebundle.var_e44ee9b00344ffc6 );
    level.activitymanager.rewards = {};
    level.activitymanager.rewards.categorytogroup = [];
    level.activitymanager.rewards.grouptorewards = [];
    level.activitymanager.rewards.scalertoscaleinfo = [];
    level.activitymanager.rewards.rewardtotype = [];
    level.activitymanager.rewards.rewardtovalue = [];
    level.activitymanager.var_d2958f8f05865d78 = utility::function_48f723fdc612ec65( @"scr_br_quest_bonus_multiplier", 0.2, level.gametypebundle.var_d2958f8f05865d78 );
    level.activitymanager.var_ffa2c5fe1c38cb78 = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_enabled", 1, level.gametypebundle.var_ffa2c5fe1c38cb78 );
    level.activitymanager.var_1900cf632676172b = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_max", 5, level.gametypebundle.var_1900cf632676172b );
    level.activitymanager.var_286863dc363b45d0 = utility::function_edc4cc03e9e60b3e( @"hash_868a4514edae1c1d", 1, level.gametypebundle.var_286863dc363b45d0 );
    level.activitymanager.tiers = [];
    
    if ( !level.var_7a5ae1416d298edd )
    {
        level.var_7a5ae1416d298edd = &br_activity_util::cratedroprewards;
    }
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
    
    var_c6ed3d9889279ae0 = [ "BRPlayerEnterGulagMoment", "BRPlayerLeaveGulagMoment", "BRPlayerKilledMoment", "BRPlayerRespawnedMoment", "BRCircleTick", "BRCircleRelocate", "BRTimerExpired", "BRCacheOpened", "BRAgentKilledMoment" ];
    var_38c5026e3d88a5d = level.activities.activitymoments;
    var_38c5026e3d88a5d = arraycombine( var_38c5026e3d88a5d, var_c6ed3d9889279ae0 );
    level.var_e4594d201dbdb749 = getnoentvolumearray( "exclude_contract_objectives", #script_noteworthy );
    var_bd05d7c4541fe595 = strtok( level.activitymanager.var_eae36c09cff3d6c0, ", " );
    
    foreach ( skippedtargetname in var_bd05d7c4541fe595 )
    {
        foreach ( volume in level.var_e4594d201dbdb749 )
        {
            if ( volume.targetname == skippedtargetname )
            {
                level.var_e4594d201dbdb749 = arrayremove( level.var_e4594d201dbdb749, volume );
                break;
            }
        }
    }
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x3385ab04, Offset: 0xa46
// Size: 0x194
function private registercallbacks()
{
    activity_common::function_9fd46b47e0d8481d( 2, &function_4f6e32ed3053e085 );
    activity_common::function_9fd46b47e0d8481d( 3, &function_6a00b6bdcad6bd09 );
    activity_common::function_9fd46b47e0d8481d( 1, &setupinstance );
    activity_common::function_9fd46b47e0d8481d( 4, &cleanupinstance );
    common_item::function_4b30c091d3b04a25( "activitystarter" );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"hash_e8583c899ddff7b", &function_85b88974c6b75949 );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"use", &function_12b6d87b587420e4 );
    common_item::function_84174b793b5fe9a7( "activitystarter", #"hash_9e49dfaa7c147654", &function_a2614196c53bf7a2 );
    callback::add( "lootcache_looted", &function_ff0cca529842eb06 );
    callback::add( #"hash_51a6b1f1e6e29d3c", &function_ff0cca529842eb06 );
    callback::add( "circle_relocation", &onCircleRelocation );
    callback::add( "br_player_killed", &onplayerkilled );
    callback::add( #"hash_c15c682d6a5dcae0", &onplayerentergulag );
    callback::add( #"hash_438552ad6e5b08a0", &function_c94b44f4b59ca287 );
    callback::add( #"br_player_respawn", &function_3f84c7c5a53692ff );
    callback::add( #"on_ai_killed", &onagentkilled );
    level.activitymanager.var_a9b234c9e9601ab0 = &function_28779161e0912456;
    thread br_circle_peek::setupcirclepeek();
    br_circle::registercirclecallbacks( 3, &dangercircletick, &dangermulticircletick, &function_dd32a8bb6a1fe649 );
    utility::registersharedfunc( #"br", #"hash_209c6b6e037bd0ea", &function_afc15d4bdb062dff );
    level.var_941fc1b70b63fdab = &function_ec033034ce1ae61;
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x715141c9, Offset: 0xbe2
// Size: 0xb
function private function_ec033034ce1ae61()
{
    return level.activitymanager;
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0xa95d8ed2, Offset: 0xbf6
// Size: 0x12a
function private registeractivities()
{
    var_3c8441d2cace240a = function_7bef2be0b2cda59a();
    
    if ( !isdefined( var_3c8441d2cace240a ) || var_3c8441d2cace240a.size == 0 )
    {
        return;
    }
    
    level.activitymanager.var_3f09331d04a683ad = [];
    level.activitymanager.var_af82df8473fe6b7 = [];
    
    for ( listindex = 0; listindex < var_3c8441d2cace240a.size ; listindex++ )
    {
        entry = var_3c8441d2cace240a[ listindex ];
        
        if ( !entry.activity || !entry.variant )
        {
            continue;
        }
        
        if ( isdefined( entry.scriptable ) )
        {
            level.activitymanager.var_3f09331d04a683ad[ entry.scriptable ] = entry.variant;
            level.activitymanager.var_af82df8473fe6b7[ entry.scriptable ] = entry.spawninfo;
        }
        
        function_a9a8165656e26139( "ui_br_objective_types", listindex, 1, 1 );
        activity_definition_utils::function_74af1ab4059e3c06( entry.activity, entry.variant );
    }
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x1d6d8be8, Offset: 0xd28
// Size: 0x8d
function private function_d47c263e661bd81b()
{
    level.activitymanager.var_cbd7f4e8feb34f18 = [];
    nummissions = tablelookupgetnumrows( "mp/brmissions.csv" );
    
    for ( var_39520877e3384490 = 0; var_39520877e3384490 < nummissions ; var_39520877e3384490++ )
    {
        tableindex = int( tablelookupbyrow( "mp/brmissions.csv", var_39520877e3384490, 0 ) );
        missionref = tablelookupbyrow( "mp/brmissions.csv", var_39520877e3384490, 1 );
        level.activitymanager.var_cbd7f4e8feb34f18[ missionref ] = tableindex;
    }
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x1f0b0b52, Offset: 0xdbd
// Size: 0x7d
function private function_7bef2be0b2cda59a()
{
    listbundlename = level.gametypebundle.var_3c8441d2cace240a;
    listoverride = getdvar( @"hash_c16eabfbddcb41a2", "" );
    
    if ( listoverride != "" )
    {
        listbundlename = "activitystarterlist:" + listoverride;
    }
    
    if ( !isdefined( listbundlename ) )
    {
        return;
    }
    
    listbundle = getscriptbundle( listbundlename );
    
    if ( !isdefined( listbundle ) )
    {
        return;
    }
    
    return listbundle.var_3c8441d2cace240a;
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x4275df84, Offset: 0xe43
// Size: 0x640
function private function_9824ecddec0fd99f()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.activitymanager ) )
    {
        return;
    }
    
    utility::flag_wait( "onStartGameTypeFinished" );
    level.activitymanager.alltablets = [];
    level.activitymanager.hiddentablets = [];
    level.activitymanager.visibletablets = [];
    level.activitymanager.var_eadfe43e300095f8 = [];
    level.activitymanager.var_b073c6c9822b3544 = teams::squadasteamenabled() && getdvarint( @"hash_c74cd10916ec3f46", 0 );
    level.activitymanager.var_83d96d332c90289 = getdvarint( @"hash_71b547668a085e68", 1 ) == 1;
    var_a607fd9f7950bc61 = [];
    var_8838247fda60ea73 = [];
    var_f0371c3aaa1db0b7 = level.activitymanager.var_f0371c3aaa1db0b7;
    
    if ( level.activitymanager.locationmin > 0 && isdefined( level.poi_names ) )
    {
        foreach ( poi in level.poi_names )
        {
            poiname = poi::function_356e66e91a150a02( poi );
            var_8838247fda60ea73[ poiname ] = level.activitymanager.locationmin;
        }
    }
    
    var_7de5dad0b8cc8c91 = getdvarint( @"hash_9896905a180dc84", 1 );
    
    foreach ( scriptable, variant in level.activitymanager.var_3f09331d04a683ad )
    {
        tablets = getentitylessscriptablearray( scriptable );
        tablets = function_5713d46873b29625( tablets );
        spawninfo = level.activitymanager.var_af82df8473fe6b7[ scriptable ];
        
        foreach ( tablet in tablets )
        {
            if ( function_548788523dc12975( variant, tablet ) )
            {
                if ( var_7de5dad0b8cc8c91 && spawninfo.mincircle > 0 )
                {
                    level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size ] = tablet;
                }
                else
                {
                    var_a607fd9f7950bc61[ var_a607fd9f7950bc61.size ] = tablet;
                }
                
                continue;
            }
            
            if ( !getcodegate( #"hash_7fff7c13f6cce76f" ) )
            {
                br_activity_util::hidetablet( tablet );
            }
        }
    }
    
    var_760d06f9e500845d = int( var_a607fd9f7950bc61.size * level.activitymanager.hidepercent );
    var_a607fd9f7950bc61 = arrayrandomize( var_a607fd9f7950bc61 );
    level.activitymanager.hiddentablets = arrayrandomize( level.activitymanager.hiddentablets );
    level.activitymanager.hiddentablets = arraycombine( level.activitymanager.hiddentablets, utility::array_slice( var_a607fd9f7950bc61, 0, var_760d06f9e500845d ) );
    level.activitymanager.visibletablets = utility::array_slice( var_a607fd9f7950bc61, var_760d06f9e500845d, var_a607fd9f7950bc61.size );
    level.activitymanager.alltablets = arraycombine( level.activitymanager.hiddentablets, level.activitymanager.visibletablets );
    function_487867c8d2e3eec4( var_8838247fda60ea73 );
    function_1d47fc84a51893f1( var_f0371c3aaa1db0b7 );
    function_8d1feb0d9dcc2d6e();
    
    /#
        foreach ( tablet in level.activitymanager.alltablets )
        {
            assert( isdefined( tablet.var_edc89ff04fe6a343 ), "<dev string:x24>" + tablet getscriptableindex() + "<dev string:x40>" );
        }
    #/
    
    level thread function_2b369520ddba33ad();
    totalcontracts = level.activitymanager.alltablets.size;
    activecontracts = level.activitymanager.visibletablets.size;
    hiddencontracts = level.activitymanager.hiddentablets.size;
    level.activitymanager.var_1b0c92a836296d3a = activecontracts;
    br_analytics::branalytics_inittablets( totalcontracts, activecontracts, hiddencontracts, level.activitymanager.hidepercent );
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_1c48ad8e4dae6be5" ) )
    {
        level.activitymanager thread utility::callsharedfunc( #"gametype", #"hash_1c48ad8e4dae6be5" );
    }
    else if ( br_gametypes::isfeatureenabled( #"tabletreplace" ) )
    {
        level.activitymanager thread tabletreplace();
    }
    else if ( var_7de5dad0b8cc8c91 )
    {
        level.activitymanager thread delayedshowtablets();
    }
    
    level callback::callback( #"hash_92f629d70137a6ae" );
    level utility::flag_set( #"hash_92f629d70137a6ae" );
    
    /#
        thread function_76347ba97624b4a1();
    #/
}

// Namespace br_activity_manager
// Params 1
// Checksum 0x44c4f181, Offset: 0x148b
// Size: 0x47
function function_28779161e0912456( team )
{
    if ( isdefined( level.activitymanager ) && isdefined( level.activitymanager.var_ec04bf3a584cbd90 ) )
    {
        return level.activitymanager.var_ec04bf3a584cbd90[ team ];
    }
}

/#

    // Namespace br_activity_manager
    // Params 0
    // Checksum 0x7cda7f10, Offset: 0x14db
    // Size: 0xfe, Type: dev
    function function_76347ba97624b4a1()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_66d9efe1edd7b4f7 = getdvarint( @"hash_86d0a6d671419333", 0 );
            
            if ( var_66d9efe1edd7b4f7 > 0 )
            {
                setdvar( @"hash_86d0a6d671419333", 0 );
                var_66d9efe1edd7b4f7 = min( var_66d9efe1edd7b4f7, level.activitymanager.visibletablets.size );
                
                foreach ( tablet in level.activitymanager.visibletablets )
                {
                    function_e0a5bf95d38bf455( tablet );
                    var_66d9efe1edd7b4f7 -= 1;
                    
                    if ( var_66d9efe1edd7b4f7 <= 0 )
                    {
                        break;
                    }
                    
                    waitframe();
                }
            }
            
            wait 0.5;
        }
    }

#/

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x16b3927e, Offset: 0x15e1
// Size: 0x17a
function private function_487867c8d2e3eec4( var_8838247fda60ea73 )
{
    if ( !var_8838247fda60ea73 || !var_8838247fda60ea73.size )
    {
        return;
    }
    
    for ( i = level.activitymanager.hiddentablets.size - 1; i >= 0 ; i-- )
    {
        tablet = level.activitymanager.hiddentablets[ i ];
        poi = poi::poi_findpoioriginisin( tablet.origin );
        poiname = poi::function_356e66e91a150a02( poi );
        spawninfo = level.activitymanager.var_af82df8473fe6b7[ tablet.type ];
        
        if ( spawninfo && spawninfo.mincircle > 0 )
        {
            continue;
        }
        
        if ( isdefined( poiname ) && isdefined( var_8838247fda60ea73[ poiname ] ) )
        {
            br_activity_util::showtablet( tablet );
            level.activitymanager.hiddentablets[ i ] = level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ];
            level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ] = undefined;
            var_8838247fda60ea73[ poiname ]--;
            
            if ( !var_8838247fda60ea73[ poiname ] )
            {
                var_8838247fda60ea73[ poiname ] = undefined;
                
                if ( !var_8838247fda60ea73.size )
                {
                    break;
                }
            }
        }
    }
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x7be2501a, Offset: 0x1763
// Size: 0x156
function private function_1d47fc84a51893f1( var_f0371c3aaa1db0b7 )
{
    var_f0371c3aaa1db0b7 -= level.activitymanager.visibletablets.size;
    
    if ( var_f0371c3aaa1db0b7 <= 0 )
    {
        return;
    }
    
    for ( i = level.activitymanager.hiddentablets.size - 1; i >= 0 ; i-- )
    {
        tablet = level.activitymanager.hiddentablets[ i ];
        spawninfo = level.activitymanager.var_af82df8473fe6b7[ tablet.type ];
        
        if ( spawninfo && spawninfo.mincircle > 0 )
        {
            continue;
        }
        
        if ( br_circle::ispointwithininitialdangercircle( tablet.origin ) )
        {
            br_activity_util::showtablet( tablet );
            level.activitymanager.hiddentablets[ i ] = level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ];
            level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ] = undefined;
            var_f0371c3aaa1db0b7--;
            
            if ( var_f0371c3aaa1db0b7 == 0 )
            {
                break;
            }
        }
    }
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x7b9135aa, Offset: 0x18c1
// Size: 0x3db
function private function_8d1feb0d9dcc2d6e()
{
    var_e02d95db19e3e345 = level.activitymanager.var_3a2cc4e923991ef5;
    var_1a0e6f2636db14c5 = level.activitymanager.var_d2733bebc895f475;
    var_ff9c5d2de97da123 = level.activitymanager.var_ca4984dbd98c87af;
    
    if ( var_e02d95db19e3e345 > 0 || var_1a0e6f2636db14c5 > 0 || var_ff9c5d2de97da123 > 0 )
    {
        i_repopulate = 0;
        var_ea6a40311d9c88b4 = [];
        
        for ( i = level.activitymanager.visibletablets.size - 1; i >= 0 ; i-- )
        {
            tablet = level.activitymanager.visibletablets[ i ];
            excluded = tablet br_activity_util::function_68f2ccbc07be54d( var_e02d95db19e3e345, level.activitymanager.visibletablets );
            type_excluded = tablet br_activity_util::function_68f2ccbc07be54d( var_1a0e6f2636db14c5, level.activitymanager.visibletablets, activity_instance_common::getactivitytype( tablet.var_edc89ff04fe6a343.activityinstance ) );
            var_ba128678dea71907 = tablet br_activity_util::function_62fbf778fbab9c2b( var_ff9c5d2de97da123, level.activitymanager.visibletablets );
            
            if ( excluded || type_excluded || var_ba128678dea71907 )
            {
                var_ea6a40311d9c88b4[ var_ea6a40311d9c88b4.size ] = tablet;
                level.activitymanager.visibletablets[ i ] = level.activitymanager.visibletablets[ level.activitymanager.visibletablets.size - 1 ];
                level.activitymanager.visibletablets[ level.activitymanager.visibletablets.size - 1 ] = undefined;
                i_repopulate++;
            }
        }
        
        br_activity_util::function_28cfe75da788438f( "CONTRACT", "Repopulating " + i_repopulate + " Contracts due to distance exclusion." );
        
        for ( i = level.activitymanager.hiddentablets.size - 1; i >= 0 ; i-- )
        {
            if ( i_repopulate == 0 )
            {
                break;
            }
            
            tablet = level.activitymanager.hiddentablets[ i ];
            spawninfo = level.activitymanager.var_af82df8473fe6b7[ tablet.type ];
            
            if ( spawninfo && spawninfo.mincircle > 0 )
            {
                continue;
            }
            
            excluded = tablet br_activity_util::function_68f2ccbc07be54d( var_e02d95db19e3e345, level.activitymanager.visibletablets );
            type_excluded = tablet br_activity_util::function_68f2ccbc07be54d( var_1a0e6f2636db14c5, level.activitymanager.visibletablets, activity_instance_common::getactivitytype( tablet.var_edc89ff04fe6a343.activityinstance ) );
            var_ba128678dea71907 = tablet br_activity_util::function_62fbf778fbab9c2b( var_ff9c5d2de97da123, level.activitymanager.visibletablets );
            
            if ( !( excluded || type_excluded || var_ba128678dea71907 ) )
            {
                br_activity_util::showtablet( tablet );
                level.activitymanager.hiddentablets[ i ] = level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ];
                level.activitymanager.hiddentablets[ level.activitymanager.hiddentablets.size - 1 ] = undefined;
                i_repopulate--;
            }
        }
        
        if ( i_repopulate )
        {
            br_activity_util::function_28cfe75da788438f( "CONTRACT", "Failed to repopulate " + i_repopulate + " Contracts." );
        }
        
        level.activitymanager.hiddentablets = arraycombine( level.activitymanager.hiddentablets, var_ea6a40311d9c88b4 );
    }
}

// Namespace br_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x579cd01, Offset: 0x1ca4
// Size: 0x112
function private function_2b369520ddba33ad()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.activitymanager.alltablets ) || level.activitymanager.alltablets.size == 0 )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    var_ef273788189c67cd = getdvarint( @"hash_88cc8ac36a3c2863", 32 );
    tablet_throttle = throttle::throttle_initialize_gate( "tablet", var_ef273788189c67cd );
    
    foreach ( tablet in level.activitymanager.hiddentablets )
    {
        throttle::throttle_wait_gate( tablet_throttle );
        br_activity_util::hidetablet( tablet );
    }
    
    throttle::throttle_destroy( tablet_throttle );
}

// Namespace br_activity_manager
// Params 0
// Checksum 0xeee64ffe, Offset: 0x1dbe
// Size: 0x99d
function delayedshowtablets()
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    lastcircle = int( min( level.activitymanager.lastcircle, level.br_level.br_circleclosetimes.size ) );
    showpercent = getdvarfloat( @"hash_743253d28cd0d1f7", 0.3 );
    validtablets = [];
    cnt = getdvarint( @"hash_256e361ad85b753", 32 );
    var_2c79f2b1b59c9d6d = throttle::throttle_initialize_gate( "delayedShowTablet", cnt );
    
    for ( i = 0; i < level.activitymanager.hiddentablets.size ; i++ )
    {
        throttle::throttle_wait_gate( var_2c79f2b1b59c9d6d );
        tablet = level.activitymanager.hiddentablets[ i ];
        tablet.circleindex = br_circle_util::function_b9385c27e6459e42( tablet.origin );
        
        if ( tablet.circleindex >= 0 )
        {
            validtablets[ validtablets.size ] = tablet;
        }
    }
    
    throttle::throttle_destroy( var_2c79f2b1b59c9d6d );
    level.activitymanager.hiddentablets = arrayrandomize( validtablets );
    level.activitymanager.var_1eb36bef03722400 = [];
    
    for ( i = 0; i < level.activitymanager.visibletablets.size ; i++ )
    {
        tablettype = level.activitymanager.visibletablets[ i ].type;
        
        if ( !arraycontains( level.activitymanager.var_1eb36bef03722400, tablettype ) )
        {
            level.activitymanager.var_1eb36bef03722400[ level.activitymanager.var_1eb36bef03722400.size ] = tablettype;
        }
    }
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        if ( !level.br_circle.circleindex )
        {
            br_analytics::branalytics_delayedshowtablets( 0, showpercent, validtablets.size, 0 );
            continue;
        }
        
        var_e02d95db19e3e345 = level.activitymanager.var_3a2cc4e923991ef5;
        var_eb798324546a36c4 = [];
        var_877226b6f2d75f2f = [];
        
        foreach ( scriptable, spawninfo in level.activitymanager.var_af82df8473fe6b7 )
        {
            var_877226b6f2d75f2f[ scriptable ] = 0;
            
            if ( br_activity_util::function_ca55fe718632b570( spawninfo ) != 1 )
            {
                var_eb798324546a36c4[ scriptable ] = 0;
                continue;
            }
            
            var_6ae7618eedc05d79 = br_activity_util::function_dc401ee9c856c395( spawninfo );
            
            if ( var_6ae7618eedc05d79 > -1 )
            {
                var_eb798324546a36c4[ scriptable ] = var_6ae7618eedc05d79;
                continue;
            }
            
            var_eb798324546a36c4[ scriptable ] = spawninfo.var_c33340dd29167082;
        }
        
        validtablets = [];
        prioritytablets = [];
        skippedtablets = [];
        fallbacktablets = [];
        
        for ( i = 0; i < level.activitymanager.hiddentablets.size ; i++ )
        {
            tablet = level.activitymanager.hiddentablets[ i ];
            
            if ( !isdefined( tablet ) )
            {
                continue;
            }
            
            if ( tablet.circleindex >= level.br_circle.circleindex )
            {
                result = br_activity_util::function_ca55fe718632b570( tablet.task.type );
                
                if ( result == -1 )
                {
                    continue;
                }
                else if ( result == 0 )
                {
                    skippedtablets[ skippedtablets.size ] = tablet;
                    continue;
                }
                
                if ( var_eb798324546a36c4[ tablet.type ] > 0 )
                {
                    if ( level.activitymanager.var_e44ee9b00344ffc6 && var_e02d95db19e3e345 > 0 )
                    {
                        if ( tablet br_activity_util::function_34071c53dfc789e6( var_e02d95db19e3e345 ) || tablet br_activity_util::isneartablet( var_e02d95db19e3e345, validtablets ) )
                        {
                            fallbacktablets[ fallbacktablets.size ] = tablet;
                            continue;
                        }
                    }
                    
                    prioritytablets[ prioritytablets.size ] = tablet;
                    var_eb798324546a36c4[ tablet.type ]--;
                    continue;
                }
                
                if ( var_e02d95db19e3e345 > 0 )
                {
                    if ( tablet br_activity_util::function_34071c53dfc789e6( var_e02d95db19e3e345 ) )
                    {
                        skippedtablets[ skippedtablets.size ] = tablet;
                        continue;
                    }
                    
                    if ( tablet br_activity_util::isneartablet( var_e02d95db19e3e345, validtablets ) )
                    {
                        skippedtablets[ skippedtablets.size ] = tablet;
                        continue;
                    }
                }
                
                validtablets[ validtablets.size ] = tablet;
            }
        }
        
        if ( level.activitymanager.var_e44ee9b00344ffc6 )
        {
            foreach ( tablet in fallbacktablets )
            {
                if ( var_eb798324546a36c4[ tablet.type ] > 0 )
                {
                    prioritytablets[ prioritytablets.size ] = tablet;
                    var_eb798324546a36c4[ tablet.type ]--;
                }
            }
        }
        
        showcount = int( ceil( validtablets.size * showpercent ) );
        var_e5702e20fac1982c = int( max( 0, level.activitymanager.var_1b0c92a836296d3a - level.activitymanager.var_1b0c92a836296d3a / level.activitymanager.var_6b059ba6e7923b61 * level.br_circle.circleindex - level.activitymanager.visibletablets.size ) );
        showcount = minint( showcount, var_e5702e20fac1982c );
        var_cb3b8ec1111fac84 = 0;
        
        foreach ( tablet in prioritytablets )
        {
            if ( !isdefined( tablet ) )
            {
                continue;
            }
            
            br_activity_util::showtablet( tablet );
            var_877226b6f2d75f2f[ tablet.type ]++;
            var_cb3b8ec1111fac84++;
        }
        
        foreach ( tablet in validtablets )
        {
            if ( var_cb3b8ec1111fac84 >= showcount )
            {
                skippedtablets[ skippedtablets.size ] = tablet;
                continue;
            }
            
            if ( var_877226b6f2d75f2f[ tablet.type ] >= level.activitymanager.var_af82df8473fe6b7[ tablet.type ].var_ce584e150b2ca66c && level.activitymanager.var_af82df8473fe6b7[ tablet.type ].var_ce584e150b2ca66c >= 0 )
            {
                skippedtablets[ skippedtablets.size ] = tablet;
                continue;
            }
            
            br_activity_util::showtablet( tablet );
            var_877226b6f2d75f2f[ tablet.type ]++;
            var_cb3b8ec1111fac84++;
        }
        
        level.activitymanager.hiddentablets = skippedtablets;
        level.activitymanager.alltablets = arraycombine( level.activitymanager.hiddentablets, level.activitymanager.visibletablets );
        br_analytics::branalytics_delayedshowtablets( level.br_circle.circleindex, showpercent, validtablets.size, var_cb3b8ec1111fac84 );
        
        if ( var_cb3b8ec1111fac84 > 0 )
        {
            var_539b6cd633ca95a4 = 0;
            
            foreach ( tabletype, index in var_877226b6f2d75f2f )
            {
                if ( var_877226b6f2d75f2f[ tabletype ] > 0 && !arraycontains( level.activitymanager.var_1eb36bef03722400, tabletype ) )
                {
                    level.activitymanager.var_1eb36bef03722400[ level.activitymanager.var_1eb36bef03722400.size ] = tabletype;
                    var_539b6cd633ca95a4 = 1;
                }
            }
            
            if ( level.activitymanager.var_83d96d332c90289 && var_539b6cd633ca95a4 )
            {
                foreach ( p in level.players )
                {
                    if ( !isdefined( p ) || !p player::isreallyalive() || p br_public::isplayerinorgoingtogulag() )
                    {
                        continue;
                    }
                    
                    p hud_message::function_ccbbac80e736b9f9( "br_new_contract_type_circle", undefined, undefined, undefined, 1 );
                }
            }
        }
        
        if ( level.br_circle.circleindex >= lastcircle )
        {
            break;
        }
    }
}

// Namespace br_activity_manager
// Params 0
// Checksum 0x8ebdd8cb, Offset: 0x2763
// Size: 0x387
function tabletreplace()
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    level.activitymanager.hiddentablets = arrayrandomize( level.activitymanager.hiddentablets );
    var_5368e009f37fca29 = 0;
    var_fb7aaa2eb6f53014 = level.tabletreplacefrequency;
    i = 0;
    var_e02d95db19e3e345 = level.activitymanager.var_3a2cc4e923991ef5;
    var_4edaca160c18b946 = 0;
    var_6c795f8538a36fce = 0;
    undefinedtablet = 0;
    
    while ( level.activitymanager.hiddentablets.size > 0 )
    {
        if ( !var_6c795f8538a36fce && !undefinedtablet && !var_4edaca160c18b946 )
        {
            level utility::waittill_any( "contract_started", "tablet_consumed_by_gas" );
        }
        
        tablet = level.activitymanager.hiddentablets[ i ];
        
        if ( !isdefined( tablet ) || !isdefined( tablet.origin ) )
        {
            if ( arraycontains( level.activitymanager.hiddentablets, tablet ) )
            {
                level.activitymanager.hiddentablets[ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( level.activitymanager.hiddentablets );
                }
            }
            
            undefinedtablet = 1;
            
            if ( i >= level.activitymanager.hiddentablets.size )
            {
                i = 0;
            }
            
            continue;
        }
        
        undefinedtablet = 0;
        
        if ( level.br_multi_circle_enabled && !var_4edaca160c18b946 )
        {
            if ( !br_circle_util::ispointinmulticircledanger( tablet.origin, level.var_ea96217a33eb6457 ) )
            {
                if ( arraycontains( level.activitymanager.hiddentablets, tablet ) )
                {
                    level.activitymanager.hiddentablets[ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( level.activitymanager.hiddentablets );
                    }
                }
                
                i++;
                
                if ( i >= level.activitymanager.hiddentablets.size )
                {
                    i = 0;
                }
                
                var_6c795f8538a36fce = 1;
                continue;
            }
        }
        
        if ( var_e02d95db19e3e345 > 0 && tablet br_activity_util::function_34071c53dfc789e6( var_e02d95db19e3e345 ) )
        {
            i++;
            
            if ( i >= level.activitymanager.hiddentablets.size )
            {
                i = 0;
                var_4edaca160c18b946 = 0;
                continue;
            }
            
            var_4edaca160c18b946 = 1;
            continue;
        }
        
        var_6c795f8538a36fce = 0;
        var_4edaca160c18b946 = 0;
        
        if ( isdefined( level.tabletreplacefrequency ) && level.tabletreplacefrequency != -1 )
        {
            var_5368e009f37fca29++;
            
            if ( var_5368e009f37fca29 >= var_fb7aaa2eb6f53014 )
            {
                br_activity_util::showtablet( tablet );
                
                if ( arraycontains( level.activitymanager.hiddentablets, tablet ) )
                {
                    level.activitymanager.hiddentablets[ i ] = undefined;
                    
                    if ( isint( i ) )
                    {
                        function_cdc669dbc8ea2101( level.activitymanager.hiddentablets );
                    }
                }
                
                var_fb7aaa2eb6f53014 += level.tabletreplacefrequency;
            }
            
            continue;
        }
        
        br_activity_util::showtablet( tablet );
        
        if ( arraycontains( level.activitymanager.hiddentablets, tablet ) )
        {
            level.activitymanager.hiddentablets[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( level.activitymanager.hiddentablets );
            }
        }
    }
}

// Namespace br_activity_manager
// Params 4, eflags: 0x4
// Checksum 0x95fa3851, Offset: 0x2af2
// Size: 0x74
function private function_85b88974c6b75949( player, item, itembundle, spawnoptions )
{
    variant = level.activitymanager.var_3f09331d04a683ad[ item.type ];
    success = function_548788523dc12975( variant, item );
    
    if ( !success )
    {
        br_activity_util::hidetablet( item );
    }
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x1776f824, Offset: 0x2b6e
// Size: 0x6c
function private function_4f6e32ed3053e085( params )
{
    activity = params[ 0 ];
    level.activitymanager.var_cc0e4315eede2fec[ level.activitymanager.var_cc0e4315eede2fec.size ] = activity;
    activitycategory = activity_instance_common::getactivitycategory( activity );
    
    if ( activitycategory == "Contract" )
    {
        function_74d4cfdf03942098( activity );
    }
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x9108445, Offset: 0x2be2
// Size: 0x4f
function private function_74d4cfdf03942098( activity )
{
    activityvariantname = activity.varianttag;
    level.activitymanager.var_ec04bf3a584cbd90[ activity.team ] = activity;
    activity br_activity_util::function_4e9e312232df58ab( activityvariantname );
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x2067182e, Offset: 0x2c39
// Size: 0xbc
function private function_6a00b6bdcad6bd09( params )
{
    activity = params[ 0 ];
    var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity );
    
    if ( var_332f929de1894b2b.var_31fe81fca001e407 )
    {
        activity_instance_common::function_9b387cb1af0d5b4b( var_332f929de1894b2b.var_31fe81fca001e407 );
    }
    
    level.activitymanager.var_cc0e4315eede2fec = arrayremove( level.activitymanager.var_cc0e4315eede2fec, activity );
    activitycategory = activity_instance_common::getactivitycategory( activity );
    
    if ( activitycategory == "Contract" )
    {
        function_ee1e86cd56a236db( activity );
    }
    
    callback::callback( #"br_activity_end", { #activityinstance:activity } );
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x4c157eab, Offset: 0x2cfd
// Size: 0x4e
function private function_ee1e86cd56a236db( activity )
{
    if ( isdefined( level.activitymanager.var_ec04bf3a584cbd90[ activity.team ] ) )
    {
        level.activitymanager.var_ec04bf3a584cbd90[ activity.team ] = undefined;
    }
}

// Namespace br_activity_manager
// Params 1
// Checksum 0xe568b07c, Offset: 0x2d53
// Size: 0xe2
function cleanupinstance( params )
{
    activity = params[ 0 ];
    activitycategory = activity_instance_common::getactivitycategory( activity );
    
    if ( activitycategory == "Contract" && teams::function_b00ab7e503f33379( activity.team, "players" ) )
    {
        playerlist = teams::getteamdata( activity.team, "players" );
        
        foreach ( player in playerlist )
        {
            player br_activity_util::function_9f77cccca136d836();
        }
    }
}

// Namespace br_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x3b8b8bcd, Offset: 0x2e3d
// Size: 0x90
function private setupinstance( params )
{
    activity = params[ 0 ];
    props = activity_definition_utils::function_9129cd8075c85c09( activity );
    
    if ( props.syncsetup )
    {
        activity_instance_common::function_68f3f41c0fdc02f3( params );
    }
    else
    {
        activity_instance_common::setupinstance( params );
    }
    
    activity activity_definition_utils::function_13b825099ff661e( activity );
    
    if ( utility::issharedfuncdefined( #"br_activity", #"hash_bcbfb56578aa60e" ) )
    {
        utility::callsharedfunc( #"br_activity", #"hash_bcbfb56578aa60e", activity );
    }
}

// Namespace br_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x2c903e26, Offset: 0x2ed5
// Size: 0xe5
function private function_775e6e3efd07e312( activity, scriptable, player )
{
    activity.var_ca369031b554da2f = player;
    activity.team = player.team;
    player thread points::doscoreevent( #"hash_67eb4b642067882a" );
    br_activity_util::activitylog( activity, player.name + " joined activity via contract tablet interact." );
    level.activitymanager.alltablets = arrayremove( level.activitymanager.alltablets, scriptable );
    player callback::callback( #"hash_7633ef4b4aa02c94", { #scriptable:scriptable, #activity:activity } );
    level notify( #"contract_started", activity.team );
    br_activity_util::hidetablet( scriptable );
}

/#

    // Namespace br_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0xff1a6f6, Offset: 0x2fc2
    // Size: 0x70, Type: dev
    function private function_e0a5bf95d38bf455( scriptable )
    {
        level notify( #"contract_started", scriptable.var_edc89ff04fe6a343.activityinstance.team );
        level.activitymanager.alltablets = arrayremove( level.activitymanager.alltablets, scriptable );
        br_activity_util::hidetablet( scriptable );
    }

#/

// Namespace br_activity_manager
// Params 4, eflags: 0x4
// Checksum 0xe9044465, Offset: 0x303a
// Size: 0x34, Type: bool
function private function_12b6d87b587420e4( itembundle, item, autouse, var_981c264073bf1154 )
{
    level thread common_item::function_e8dfe5e68a7a03b4( self, itembundle );
    return true;
}

// Namespace br_activity_manager
// Params 4, eflags: 0x4
// Checksum 0x694db837, Offset: 0x3077
// Size: 0xa3, Type: bool
function private function_a2614196c53bf7a2( itembundle, item, autouse, allowswap )
{
    var_c8b9bfb7b4c3d6d9 = 1;
    
    if ( utility::issharedfuncdefined( #"activity", #"hash_6cef4604e39b1588" ) )
    {
        var_c8b9bfb7b4c3d6d9 = utility::callsharedfunc( #"activity", #"hash_6cef4604e39b1588", self );
    }
    
    participationconditions = item.var_edc89ff04fe6a343.activityinstance.participationconditions;
    return var_c8b9bfb7b4c3d6d9 && conditional_container::function_33051347e9187361( participationconditions, self );
}

// Namespace br_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xc1357ab8, Offset: 0x3123
// Size: 0x82, Type: bool
function private function_548788523dc12975( variant, scriptable )
{
    if ( !isdefined( variant ) || !isdefined( scriptable ) )
    {
        return false;
    }
    
    activity = activity_instance_common::function_9b387cb1af0d5b4b( variant, scriptable.origin );
    
    if ( isdefined( activity ) && activity.state != "Cleanup" )
    {
        activity.tablet = scriptable;
        activity activity_participation::function_7dd54a3f491d8ec8( scriptable, 0, &function_775e6e3efd07e312 );
        return true;
    }
    
    return false;
}

// Namespace br_activity_manager
// Params 1
// Checksum 0xae054684, Offset: 0x31ae
// Size: 0x5b
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    br_activity_util::function_e6250fc87b2e5e72( "BRPlayerKilledMoment", { #victim:victim, #attacker:attacker } );
}

// Namespace br_activity_manager
// Params 1
// Checksum 0xbb2d2667, Offset: 0x3211
// Size: 0x3b
function onplayerentergulag( params )
{
    player = params.player;
    br_activity_util::function_e6250fc87b2e5e72( "BRPlayerEnterGulagMoment", { #player:player } );
}

// Namespace br_activity_manager
// Params 1
// Checksum 0x29002c09, Offset: 0x3254
// Size: 0x3b
function function_c94b44f4b59ca287( params )
{
    player = params.player;
    br_activity_util::function_e6250fc87b2e5e72( "BRPlayerLeaveGulagMoment", { #player:player } );
}

// Namespace br_activity_manager
// Params 1
// Checksum 0x9941dafe, Offset: 0x3297
// Size: 0x3b
function function_3f84c7c5a53692ff( params )
{
    player = params.player;
    br_activity_util::function_e6250fc87b2e5e72( "BRPlayerRespawnedMoment", { #player:player } );
}

// Namespace br_activity_manager
// Params 1
// Checksum 0x7f6af4ef, Offset: 0x32da
// Size: 0x97
function onagentkilled( params )
{
    agent = params.victim;
    attacker = params.eattacker;
    br_activity_util::function_e6250fc87b2e5e72( "BRAgentKilledMoment", { #shitloc:params.shitloc, #sweapon:params.sweapon, #smeansofdeath:params.smeansofdeath, #attacker:attacker, #agent:agent } );
}

// Namespace br_activity_manager
// Params 3
// Checksum 0x6fb97a85, Offset: 0x3379
// Size: 0x1e
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    
}

// Namespace br_activity_manager
// Params 0
// Checksum 0x509020ee, Offset: 0x339f
// Size: 0x11d
function dangermulticircletick()
{
    br_activity_util::function_e6250fc87b2e5e72( "BRCircleTick" );
    hiddentablets = [];
    
    foreach ( tablet in level.activitymanager.visibletablets )
    {
        if ( !( isdefined( tablet ) && isdefined( tablet.type ) && isdefined( tablet.origin ) ) )
        {
            continue;
        }
        
        if ( !br_circle_util::ispointinmulticircledanger( tablet.origin, level.var_ea96217a33eb6457 ) )
        {
            level.activitymanager.alltablets = arrayremove( level.activitymanager.alltablets, tablet );
            level notify( #"tablet_consumed_by_gas" );
            br_activity_util::hidetablet( tablet );
        }
    }
    
    return hiddentablets;
}

// Namespace br_activity_manager
// Params 1
// Checksum 0x3aa68353, Offset: 0x34c5
// Size: 0xc
function function_dd32a8bb6a1fe649( tablet )
{
    
}

// Namespace br_activity_manager
// Params 1
// Checksum 0xcd57e7f0, Offset: 0x34d9
// Size: 0x24
function onCircleRelocation( params )
{
    br_activity_util::function_73a69a713bac3359( "BRCircleRelocate", { #params:params } );
}

// Namespace br_activity_manager
// Params 1
// Checksum 0xaf188839, Offset: 0x3505
// Size: 0x47
function function_ff0cca529842eb06( params )
{
    player = self;
    br_activity_util::function_59e94911ee8444c3( player, "BRCacheOpened", { #cache:params.cacheinstance, #player:player } );
}

// Namespace br_activity_manager
// Params 3
// Checksum 0xe4cc4abd, Offset: 0x3554
// Size: 0x121
function function_afc15d4bdb062dff( contractref, origin, angles )
{
    var_3c8441d2cace240a = function_7bef2be0b2cda59a();
    
    foreach ( activitystarter in var_3c8441d2cace240a )
    {
        ref = activitystarter.variant;
        
        if ( ref == contractref )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
            spawnoptions.var_fd47e835523b473f = 1;
            spawnoptions.cleanupdisabled = 1;
            spawnoptions.critical = 1;
            newtablet = common_item::function_61c2c0251e742ffd( common_item_database::function_ca9ca606e66b5911( activitystarter.scriptable ), 1, spawnoptions );
            br_activity_util::showtablet( newtablet );
            return newtablet;
        }
    }
}

