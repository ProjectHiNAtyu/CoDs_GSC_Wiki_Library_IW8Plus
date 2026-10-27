// scripts\mp\br\gametypes\br_contract_manager.gsc  (hash_01caeae196852962.gscc) (size: 65251 Bytes / 0xfee3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96602313 (2522882835)
// size ...... 65251 (0xfee3)
// includes .. 52  (offset: 0xf213)
// strings ... 143 (offset: 0xf3b3)
// dev strs .. 45  (offset: 0xfc93)
// exports ... 150 (offset: 0xb05b)
// cseg ...... 0xe7c + 0xa1df (0xb05b)
// imports ... 319 (offset: 0xc7cb)
// animtree1 . 0   (offset: 0xfee3)
// animtree2 . 0   (offset: 0xfee3)
#using script_1df1ae965888eae;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_peek;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_demolition_quest;
#using scripts\mp\br\gametypes\br_dom_quest;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_elite_geiger_quest;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_hacker_phone_quest;
#using scripts\mp\br\gametypes\br_intel_quest;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_chain_manager;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_safecrack_quest;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\br\gametypes\br_searchseizure_quest;
#using scripts\mp\br\gametypes\br_timedrun_quest;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\poi;
#using scripts\mp\squads;
#using scripts\mp\talking_gun;

#namespace br_contract_manager;

// Namespace br_contract_manager
// Params 0
// Checksum 0x3528d0d, Offset: 0xe9a
// Size: 0x770
function function_2c05e0c3d3568609()
{
    if ( getcodegate( #"hash_7fff7c13f6cce76f" ) )
    {
        return;
    }
    
    arecontractsenabled = utility::function_edc4cc03e9e60b3e( @"scr_br_contracts_enabled", 1, istrue( level.gametypebundle.enablecontracts ) );
    
    if ( !arecontractsenabled )
    {
        if ( !isdefined( level.activitymanager ) )
        {
            thread function_36380e05f8258e66();
        }
        
        return;
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        return;
    }
    
    level utility::flag_init( "br_contract_manager_init" );
    level.contractmanager = spawnstruct();
    level.contractmanager.var_e03c6c6524bde63c = utility::function_48f723fdc612ec65( @"hash_4ec62b4599196026", 0.7, level.gametypebundle.var_e03c6c6524bde63c );
    level.contractmanager.var_6b059ba6e7923b61 = utility::function_edc4cc03e9e60b3e( @"hash_41d708400ba020e1", 5, level.gametypebundle.var_6b059ba6e7923b61 );
    level.contractmanager.locationmin = utility::function_edc4cc03e9e60b3e( @"hash_61d045aa9b2d5565", 3, level.gametypebundle.locationmin );
    level.contractmanager.var_f0371c3aaa1db0b7 = utility::function_edc4cc03e9e60b3e( @"hash_3b86f15e6ab5c0b0", 0, level.gametypebundle.var_f0371c3aaa1db0b7 );
    level.contractmanager.var_57990374e7137981 = utility::function_edc4cc03e9e60b3e( @"hash_341fd6b76f01c2e8", 1200, level.gametypebundle.var_57990374e7137981 );
    level.contractmanager.var_9cb095042fb73d82 = utility::function_edc4cc03e9e60b3e( @"hash_526a7311f94ae394", 1200, level.gametypebundle.var_9cb095042fb73d82 );
    level.contractmanager.lastcircle = utility::function_edc4cc03e9e60b3e( @"hash_96878da693689ccd", 4, level.gametypebundle.lastcircle );
    level.contractmanager.var_d2958f8f05865d78 = utility::function_48f723fdc612ec65( @"scr_br_quest_bonus_multiplier", 0.2, level.gametypebundle.var_d2958f8f05865d78 );
    level.contractmanager.var_ffa2c5fe1c38cb78 = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_enabled", 1, level.gametypebundle.var_ffa2c5fe1c38cb78 );
    level.contractmanager.var_1900cf632676172b = utility::function_edc4cc03e9e60b3e( @"scr_br_quest_bonus_max", 5, level.gametypebundle.var_1900cf632676172b );
    level.contractmanager.var_286863dc363b45d0 = utility::function_edc4cc03e9e60b3e( @"hash_868a4514edae1c1d", 1, level.gametypebundle.var_286863dc363b45d0 );
    level.contractmanager.var_dc52ccd301b92f4f = utility::function_48f723fdc612ec65( @"hash_53befb3a9881c61c", 0.5, level.gametypebundle.var_dc52ccd301b92f4f );
    level.contractmanager.var_eae36c09cff3d6c0 = utility::function_49a778e73bbb0f58( @"hash_d9a778f31a83da20", "", level.gametypebundle.var_eae36c09cff3d6c0 );
    
    if ( common_item::items_isenabled() )
    {
        common_item::function_4b30c091d3b04a25( "activitystarter" );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"use", &function_e53aaf28ba448bcf );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"canautouse", &function_646e596034672318 );
        common_item::function_84174b793b5fe9a7( "activitystarter", #"hash_9e49dfaa7c147654", &function_190d28195fb735f5 );
        
        /#
            common_item::function_9c9e4c71569f3ae8( &function_bdbdeb959248f26e );
        #/
    }
    
    level.var_59cbd4c4c932a897 = getnoentvolumearray( "exclude_contract_objectives", #script_noteworthy );
    var_bd05d7c4541fe595 = strtok( level.contractmanager.var_eae36c09cff3d6c0, ", " );
    
    foreach ( skippedtargetname in var_bd05d7c4541fe595 )
    {
        foreach ( volume in level.var_59cbd4c4c932a897 )
        {
            if ( volume.targetname == skippedtargetname )
            {
                level.var_59cbd4c4c932a897 = arrayremove( level.var_59cbd4c4c932a897, volume );
                break;
            }
        }
    }
    
    br_scavenger_quest::function_d61b29ded0232e9c( level.var_59cbd4c4c932a897 );
    function_7ec0d28902eeb0e2();
    
    if ( level.ssc )
    {
        level waittill( #"ssc_config_spawned" );
    }
    
    inittablets();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    br_circle_peek::setupcirclepeek();
    callback::add( #"player_assimilated", &function_2550892140fff0c1 );
    lui_game_event_aggregator::registeronluieventcallback( &function_dbddd582addf522c );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "mission_gen_accept" ] = "gnrc_wzan_msns";
    game[ "dialog" ][ "mission_misc_success" ] = "gnrc_wzan_msnc";
    game[ "dialog" ][ "mission_obj_change" ] = "gnrc_wzan_bjcn";
    game[ "dialog" ][ "mission_obj_moved" ] = "gnrc_wzan_bjcr";
    game[ "dialog" ][ "mission_obj_next_ptarget" ] = "gnrc_wzan_trgn";
    game[ "dialog" ][ "mission_obj_next_nptarget" ] = "gnrc_wzan_bjcn";
    game[ "dialog" ][ "mission_obj_warning_time" ] = "gnrc_wzan_mstw";
    game[ "dialog" ][ "mission_obj_warning_capture" ] = "mission_mission_obj_warning_capture";
    game[ "dialog" ][ "mission_obj_circle_fail" ] = "gnrc_wzan_msfr";
    game[ "dialog" ][ "mission_gen_fail" ] = "gnrc_wzan_msnf";
    game[ "dialog" ][ "mission_gen_fail_time" ] = "gnrc_wzan_mstt";
    game[ "dialog" ][ "mission_teammate_down" ] = "tmmd_wzan_mssn";
    game[ "dialog" ][ "mission_enemy_down" ] = "nmyd_wzan_mssn";
    level._effect[ "vfx_dom_flare" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_dom" );
    level._effect[ "vfx_revive_flare" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_revive" );
    level._effect[ "vfx_smktrail_mortar" ] = loadfxasset( "vfx_iw8_br_gameplay_flare_smktrail" );
    level._effect[ "vfx_marker_base_orange_pulse" ] = loadfxasset( "vfx_iw8_br_gameplay_tr_marker" );
    level.brmodevariantrewardcullfunc = undefined;
    br_circle::registercirclecallbacks( 3, &dangercircletick, &dangermulticircletick, &function_dd32a8bb6a1fe649 );
    callback::add( "lootcache_looted", &function_918f6f1ff6efac88 );
    callback::add( #"hash_51a6b1f1e6e29d3c", &function_918f6f1ff6efac88 );
    callback::add( "circle_relocation", &onCircleRelocation );
    
    /#
        debuginit();
        thread function_9313ac7c59ca74de();
    #/
    
    level utility::flag_set( "br_contract_manager_init" );
}

// Namespace br_contract_manager
// Params 0, eflags: 0x4
// Checksum 0xc4184b8, Offset: 0x1612
// Size: 0x8c
function private getcontractlist()
{
    contractlistoverride = getdvar( @"scr_br_contractlist_bundle", "" );
    
    if ( contractlistoverride != "" || !isdefined( level.gametypebundle ) )
    {
        var_d44522211e12cd3f = "contractlist:" + ( contractlistoverride ?? "br_contractlist" );
    }
    else
    {
        var_d44522211e12cd3f = game_utility::function_bf2984e0278cf917( level.gametypebundle.var_5ead51064df09c1b ).contractlist;
    }
    
    return getscriptbundle( var_d44522211e12cd3f ).contractlist;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x206e872d, Offset: 0x16a7
// Size: 0x701
function function_7ec0d28902eeb0e2()
{
    level.contractmanager.contractdata = [];
    level.contractmanager.var_ab95e990a9975df8 = [];
    level.contractmanager.var_d20593a250baacb6 = [];
    level.contractmanager.var_ec04bf3a584cbd90 = [];
    level.contractmanager.var_eadfe43e300095f8 = [];
    level.contractmanager.var_6869b28625f86223 = [];
    level.contractmanager.currenttasks = [];
    level.contractmanager.defaultfilter = [];
    level.contractmanager.defaultfilter[ 0 ] = &filtercondition_isdead;
    level.contractmanager.defaultfilter[ 1 ] = &filtercondition_ingulag;
    level.contractmanager.var_a53b51ae8a01a37b = getdvarint( @"hash_f6a77ffd2ac4d6d1", 1 );
    level.contractmanager.rewards = spawnstruct();
    level.contractmanager.rewards.categorytogroup = [];
    level.contractmanager.rewards.grouptorewards = [];
    level.contractmanager.rewards.scalertoscaleinfo = [];
    level.contractmanager.rewards.rewardtotype = [];
    level.contractmanager.rewards.rewardtovalue = [];
    level.contractmanager.tiers = [];
    level.contractmanager.var_4ed75045012f35a = "MP_BR_INGAME/CONTRACT_CANCEL_TIME";
    level.contractmanager.cancelmessage = "MP_BR_INGAME/CONTRACT_CANCEL";
    level.contractmanager.var_47ca1f8bfd0c7ece = [];
    level.contractmanager.var_f47c95550183eda9 = [];
    level.contractmanager.var_b073c6c9822b3544 = teams::squadasteamenabled() && getdvarint( @"hash_c74cd10916ec3f46", 0 );
    contractlist = getcontractlist();
    
    for ( contractidx = 0; contractidx < contractlist.size ; contractidx++ )
    {
        if ( !isdefined( contractlist[ contractidx ].contract ) )
        {
            continue;
        }
        
        contractbundle = getscriptbundle( contractlist[ contractidx ].contract );
        contractdata = spawnstruct();
        contractdata.index = contractidx;
        contractdata.enabled = contractbundle.enabled;
        contractdata.ref = contractbundle.name;
        contractdata.lootref = contractbundle.starterloot;
        contractdata.contracttime = contractbundle.contracttime;
        contractdata.rewardgroup = contractbundle.rewardgroup;
        contractdata.funcs = [];
        contractdata.var_9b0f065779b5af30 = contractbundle.var_9b0f065779b5af30;
        contractdata.var_83d4ad26c60bfb29 = contractbundle.mincircle;
        contractdata.var_e0d5eb2fac343453 = contractbundle.maxcircle;
        contractdata.var_d416063dbd153813 = contractbundle.var_c33340dd29167082;
        contractdata.var_546301a0b9b1e599 = contractbundle.var_ce584e150b2ca66c;
        contractdata.var_3e66e51a241b9989 = contractbundle.var_3e66e51a241b9989;
        level.contractmanager.contractdata[ level.contractmanager.contractdata.size ] = contractdata;
        level.contractmanager.var_ab95e990a9975df8[ contractdata.ref ] = contractdata;
        level.contractmanager.var_d20593a250baacb6[ contractdata.lootref ] = contractdata;
        
        if ( utility::issharedfuncdefined( contractdata.ref, #"get_contract_data" ) )
        {
            utility::callsharedfunc( contractdata.ref, #"get_contract_data", contractdata );
            continue;
        }
        
        switch ( contractdata.ref )
        {
            case #"hash_f4a9126c03d3385b":
                br_dom_quest::getcontractdata( contractdata );
                break;
            case #"hash_96e641d7fe5b1cf1":
                br_assassination_quest::getcontractdata( contractdata );
                break;
            case #"hash_f81960af7095fbde":
                br_assassination_quest::getcontractdata( contractdata, "master" );
                break;
            case #"hash_7b0c576c4a7e4890":
                br_vip_quest::getcontractdata( contractdata );
                break;
            case #"hash_5c57b61aa79410db":
                br_scavenger_quest::getcontractdata( contractdata );
                break;
            case #"hash_d0eb63c46c25ef55":
                br_timedrun_quest::getcontractdata( contractdata );
                break;
            case #"hash_cf3abe09f0094696":
                br_demolition_quest::getcontractdata( contractdata );
                break;
            case #"hash_bf5597954aaed3d7":
                br_intel_quest::getcontractdata( contractdata );
                break;
            case #"hash_d22bc78737d8a069":
                br_safecrack_quest::getcontractdata( contractdata );
                break;
            case #"hash_69146251ab5ca13a":
                br_elite_broken_arrow::getcontractdata( contractdata );
                break;
            case #"hash_4aae0f3e58abb932":
                br_elite_geiger_quest::getcontractdata( contractdata );
                break;
            case #"hash_9bcbe04c85a6a767":
                namespace_384fce4a31518799::getcontractdata( contractdata );
                break;
            case #"hash_73f686029a5278dc":
                br_searchseizure_quest::getcontractdata( contractdata );
                break;
            case #"hash_74ed0c0772e5616":
            case #"hash_1c8102acfec27e36":
            case #"hash_3684a21686064f80":
            case #"hash_55cbaf99a55ad833":
            case #"hash_74becfc3db09261d":
            case #"hash_c13e659fe3bd1db3":
            case #"hash_d055a3a4707f4721":
            case #"hash_e2589cebce7ef39c":
                break;
            default:
                logprint( "Unhandled contract type: " + contractdata.ref );
                break;
        }
    }
    
    numstates = tablelookupgetnumrows( "mp/brmissions.csv" );
    
    for ( stateidx = 0; stateidx < numstates ; stateidx++ )
    {
        state = spawnstruct();
        state.index = int( tablelookupbyrow( "mp/brmissions.csv", stateidx, 0 ) );
        state.ref = tablelookupbyrow( "mp/brmissions.csv", stateidx, 1 );
        state.contractref = tablelookupbyrow( "mp/brmissions.csv", stateidx, 18 );
        level.contractmanager.var_6869b28625f86223[ state.ref ] = state;
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x3c79301b, Offset: 0x1db0
// Size: 0xd42
function inittablets()
{
    level.contractmanager.activetablets = [];
    level.contractmanager.hiddentablets = [];
    level.contractmanager.var_18d07b59d1165e7e = [];
    level.contractmanager.var_49f4d421a1819b70 = [];
    level.contractmanager.var_b2a0d08193a033e6 = [];
    hidepercent = 0;
    var_e03c6c6524bde63c = level.contractmanager.var_e03c6c6524bde63c;
    var_8838247fda60ea73 = [];
    locationmin = level.contractmanager.locationmin;
    var_f0371c3aaa1db0b7 = level.contractmanager.var_f0371c3aaa1db0b7;
    
    if ( locationmin > 0 && isdefined( level.poi_names ) )
    {
        foreach ( poi in level.poi_names )
        {
            poiname = poi::function_356e66e91a150a02( poi );
            var_8838247fda60ea73[ poiname ] = locationmin;
        }
    }
    
    totalcontracts = 0;
    
    foreach ( type in level.contractmanager.contractdata )
    {
        if ( !type.spawndirectly )
        {
            tablets = getentitylessscriptablearray( type.lootref );
        }
        else
        {
            tablets = [[ type.funcs[ "spawnScriptables" ] ]]();
        }
        
        tablets = function_5713d46873b29625( tablets );
        
        if ( !type.enabled )
        {
            foreach ( tablet in tablets )
            {
                function_a28ecf3e9eb9e64a( tablet );
            }
            
            continue;
        }
        
        level.contractmanager.var_49f4d421a1819b70[ type.lootref ] = 0;
        level.contractmanager.var_b2a0d08193a033e6[ type.lootref ] = 0;
        
        if ( isdefined( type.tablethidepercent ) )
        {
            hidepercent = type.tablethidepercent;
        }
        else
        {
            hidepercent = var_e03c6c6524bde63c;
        }
        
        var_57990374e7137981 = level.contractmanager.var_57990374e7137981;
        
        if ( var_57990374e7137981 > 0 && tablets.size > 0 )
        {
            foreach ( kiosk in common_kiosk::function_5c2447fa1580c330() )
            {
                closetablets = getlootscriptablearrayinradius( type.lootref, undefined, kiosk.origin, var_57990374e7137981 );
                
                foreach ( closetablet in closetablets )
                {
                    closetablet.hideme = 1;
                }
            }
            
            for ( i = tablets.size - 1; i >= 0 ; i-- )
            {
                if ( !tablets[ i ].hideme )
                {
                    continue;
                }
                
                tablets[ i ].hideme = undefined;
                result = function_a28ecf3e9eb9e64a( tablets[ i ] );
                assert( result, "<dev string:x2b>" );
                tablets[ i ] = tablets[ tablets.size - 1 ];
                tablets[ tablets.size - 1 ] = undefined;
            }
        }
        
        for ( i = tablets.size - 1; i >= 0 ; i-- )
        {
            tablet = tablets[ i ];
            tablet tabletinit( type );
            
            if ( !tablet.init || ai_fortress::function_f45832ffece5dbb( tablet.origin ) || !br_circle::ispointwithininitialdangercircle( tablet.origin ) || function_d0e283b300baf433( tablet.origin ) )
            {
                result = function_a28ecf3e9eb9e64a( tablet );
                assert( result, "<dev string:x2b>" );
                tablets[ i ] = tablets[ tablets.size - 1 ];
                tablets[ tablets.size - 1 ] = undefined;
            }
        }
        
        var_161d5af736be45b4 = type.funcs[ "onPostTabletInit" ];
        
        if ( isdefined( var_161d5af736be45b4 ) )
        {
            level [[ var_161d5af736be45b4 ]]();
        }
        
        totalcontracts += tablets.size;
        
        if ( tablets.size )
        {
            setobjectivetypesomvarbit( type );
        }
        
        if ( type.var_83d4ad26c60bfb29 > 0 )
        {
            var_80a9edfd2aa7a3ff = tablets.size;
        }
        else
        {
            var_cdf758dee1735293 = tablets.size * hidepercent;
            var_80a9edfd2aa7a3ff = int( var_cdf758dee1735293 );
            extrachance = var_cdf758dee1735293 - var_80a9edfd2aa7a3ff;
            
            if ( randomfloat( 1 ) < extrachance )
            {
                var_80a9edfd2aa7a3ff++;
            }
        }
        
        for ( i = 0; i < var_80a9edfd2aa7a3ff ; i++ )
        {
            randindex = randomintrange( 0, tablets.size );
            tablet = tablets[ randindex ];
            level.contractmanager.hiddentablets[ level.contractmanager.hiddentablets.size ] = tablets[ randindex ];
            tablets[ randindex ] = tablets[ tablets.size - 1 ];
            tablets[ tablets.size - 1 ] = undefined;
        }
        
        foreach ( tablet in tablets )
        {
            if ( var_8838247fda60ea73.size > 0 )
            {
                poi = poi::poi_findpoioriginisin( tablet.origin );
                poiname = poi::function_356e66e91a150a02( poi );
                
                if ( isdefined( poiname ) && isdefined( var_8838247fda60ea73[ poiname ] ) )
                {
                    var_8838247fda60ea73[ poiname ]--;
                    
                    if ( !var_8838247fda60ea73[ poiname ] )
                    {
                        var_8838247fda60ea73[ poiname ] = undefined;
                    }
                }
            }
        }
        
        foreach ( tablet in tablets )
        {
            if ( var_f0371c3aaa1db0b7 > 0 )
            {
                if ( br_circle::ispointwithininitialdangercircle( tablet.origin ) )
                {
                    var_f0371c3aaa1db0b7--;
                }
            }
        }
        
        foreach ( tablet in tablets )
        {
            tablet tabletshow();
        }
    }
    
    if ( var_8838247fda60ea73.size )
    {
        level.contractmanager.hiddentablets = arrayrandomize( level.contractmanager.hiddentablets );
        
        for ( i = level.contractmanager.hiddentablets.size - 1; i >= 0 ; i-- )
        {
            tablet = level.contractmanager.hiddentablets[ i ];
            
            if ( !isdefined( tablet.task ) )
            {
                continue;
            }
            
            poi = poi::poi_findpoioriginisin( tablet.origin );
            
            if ( !isdefined( poi ) )
            {
                continue;
            }
            
            poiname = poi::function_356e66e91a150a02( poi );
            
            if ( isdefined( poiname ) && isdefined( var_8838247fda60ea73[ poiname ] ) && function_93f2b8f289652e2( tablet.task.type, 1 ) == 1 )
            {
                level.contractmanager.hiddentablets[ i ] = level.contractmanager.hiddentablets[ level.contractmanager.hiddentablets.size - 1 ];
                level.contractmanager.hiddentablets[ level.contractmanager.hiddentablets.size - 1 ] = undefined;
                tablet tabletshow();
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
    
    if ( var_f0371c3aaa1db0b7 > 0 )
    {
        level.contractmanager.hiddentablets = arrayrandomize( level.contractmanager.hiddentablets );
        
        for ( i = level.contractmanager.hiddentablets.size - 1; i >= 0 ; i-- )
        {
            tablet = level.contractmanager.hiddentablets[ i ];
            
            if ( br_circle::ispointwithininitialdangercircle( tablet.origin ) && function_93f2b8f289652e2( tablet.task.type, 1 ) == 1 )
            {
                tablet tabletshow();
                var_f0371c3aaa1db0b7--;
                
                if ( var_f0371c3aaa1db0b7 == 0 )
                {
                    break;
                }
            }
        }
    }
    
    var_9cb095042fb73d82 = squared( level.contractmanager.var_9cb095042fb73d82 );
    
    if ( var_9cb095042fb73d82 > 0 )
    {
        i_repopulate = 0;
        var_ea6a40311d9c88b4 = [];
        
        for ( i = level.contractmanager.activetablets.size - 1; i >= 0 ; i-- )
        {
            tablet = level.contractmanager.activetablets[ i ];
            
            if ( tablet function_34071c53dfc789e6( var_9cb095042fb73d82, level.contractmanager.activetablets ) )
            {
                level.contractmanager.activetablets[ i ] = level.contractmanager.activetablets[ level.contractmanager.activetablets.size - 1 ];
                level.contractmanager.activetablets[ level.contractmanager.activetablets.size - 1 ] = undefined;
                var_ea6a40311d9c88b4[ var_ea6a40311d9c88b4.size ] = tablet;
                i_repopulate++;
            }
        }
        
        level.contractmanager.hiddentablets = arrayrandomize( level.contractmanager.hiddentablets );
        
        for ( i = level.contractmanager.hiddentablets.size - 1; i >= 0 ; i-- )
        {
            if ( i_repopulate == 0 )
            {
                break;
            }
            
            tablet = level.contractmanager.hiddentablets[ i ];
            
            if ( isdefined( tablet.task.type ) )
            {
                if ( !tablet function_34071c53dfc789e6( var_9cb095042fb73d82, level.contractmanager.activetablets ) && function_93f2b8f289652e2( tablet.task.type, 1 ) == 1 )
                {
                    tablet tabletshow();
                    i_repopulate--;
                }
            }
        }
        
        level.contractmanager.hiddentablets = arraycombine( level.contractmanager.hiddentablets, var_ea6a40311d9c88b4 );
    }
    
    level thread function_2b369520ddba33ad();
    activecontracts = level.contractmanager.activetablets.size;
    hiddencontracts = level.contractmanager.hiddentablets.size;
    level.contractmanager.var_1b0c92a836296d3a = activecontracts;
    
    /#
        level thread function_a360fe748c75f5e7( 160000 );
    #/
    
    br_analytics::branalytics_inittablets( totalcontracts, activecontracts, hiddencontracts, hidepercent );
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_1c48ad8e4dae6be5" ) )
    {
        level.contractmanager thread utility::callsharedfunc( #"gametype", #"hash_1c48ad8e4dae6be5" );
    }
    else if ( br_gametypes::isfeatureenabled( #"tabletreplace" ) )
    {
        level.contractmanager thread tabletreplace();
    }
    else
    {
        level.contractmanager thread delayedshowtablets();
    }
    
    level notify( #"hash_626f1cbb34b08a9b" );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x424d3c88, Offset: 0x2afa
// Size: 0x12d
function function_36380e05f8258e66()
{
    var_ef273788189c67cd = getdvarint( @"hash_88cc8ac36a3c2863", 32 );
    tablet_throttle = throttle::throttle_initialize_gate( "tablet", var_ef273788189c67cd );
    contractlist = getcontractlist();
    flags::gameflagwait( "prematch_done" );
    
    for ( contractidx = 0; contractidx < contractlist.size ; contractidx++ )
    {
        if ( !isdefined( contractlist[ contractidx ].contract ) )
        {
            continue;
        }
        
        contractbundle = getscriptbundle( contractlist[ contractidx ].contract );
        tablets = getentitylessscriptablearray( contractbundle.starterloot );
        
        foreach ( tablet in tablets )
        {
            throttle::throttle_wait_gate( tablet_throttle );
            pickups::loothide( tablet );
        }
    }
}

// Namespace br_contract_manager
// Params 4, eflags: 0x4
// Checksum 0xb06f2d22, Offset: 0x2c2f
// Size: 0x56
function private function_e53aaf28ba448bcf( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( self.canhackcontracts )
    {
        thread br_hacker_phone_quest::function_65e79827fc9cbdf8( item, self );
        return item.count;
    }
    else
    {
        function_9490728b1fe4323( item );
    }
    
    return 0;
}

// Namespace br_contract_manager
// Params 4, eflags: 0x4
// Checksum 0x41db091e, Offset: 0x2c8e
// Size: 0x28, Type: bool
function private function_646e596034672318( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace br_contract_manager
// Params 4
// Checksum 0xcf5bb88c, Offset: 0x2cbf
// Size: 0x41, Type: bool
function function_190d28195fb735f5( itembundle, item, autouse, allowswap )
{
    return !function_9cb0572c407b9880( function_6b738bc71eb53bd4() ) || self.canhackcontracts;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x2f03596e, Offset: 0x2d09
// Size: 0x182
function function_918f6f1ff6efac88( params )
{
    if ( isbrgamemode() && isdefined( level.contractmanager ) )
    {
        foreach ( contract in level.contractmanager.contractdata )
        {
            if ( isdefined( contract.funcs[ "onCacheLooted" ] ) )
            {
                foreach ( task in level.contractmanager.currenttasks )
                {
                    if ( contract.ref == task.type.ref )
                    {
                        task [[ contract.funcs[ "onCacheLooted" ] ]]( params.player, params.instance.type );
                    }
                }
            }
        }
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x106a406d, Offset: 0x2e93
// Size: 0xd3
function function_12bf8ec6b4419503( i_distance_sq, var_e33007e788481556 = level.contractmanager.activetablets )
{
    if ( !isarray( var_e33007e788481556 ) )
    {
        return;
    }
    
    i_distance = sqrt( i_distance_sq );
    var_e33007e788481556 = sortbydistancecullbyradius( var_e33007e788481556, self.origin, i_distance );
    
    foreach ( tablet in var_e33007e788481556 )
    {
        if ( tablet == self )
        {
            continue;
        }
        
        return tablet;
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x5bb6921b, Offset: 0x2f6f
// Size: 0x2d, Type: bool
function function_34071c53dfc789e6( i_distance_sq, var_e33007e788481556 )
{
    nearbytablet = function_12bf8ec6b4419503( i_distance_sq, var_e33007e788481556 );
    return isdefined( nearbytablet );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x1b8f5036, Offset: 0x2fa5
// Size: 0x5d
function setobjectivetypesomvarbit( type )
{
    index = function_e01c7810f3c75f0b( type.ref );
    assert( index < 32, "<dev string:x66>" + type.ref + "<dev string:x72>" );
    function_a9a8165656e26139( "ui_br_objective_types", index, 1, 1 );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xe497bed9, Offset: 0x300a
// Size: 0x16c
function tabletreplace()
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    level.contractmanager.hiddentablets = arrayrandomize( level.contractmanager.hiddentablets );
    var_5368e009f37fca29 = 0;
    var_fb7aaa2eb6f53014 = level.tabletreplacefrequency;
    
    for ( i = 0; i < level.contractmanager.hiddentablets.size ; i++ )
    {
        level utility::waittill_any( "quest_started", "tablet_consumed_by_gas" );
        tablet = level.contractmanager.hiddentablets[ i ];
        
        if ( level.br_multi_circle_enabled )
        {
            while ( !br_circle_util::function_7dba95e6f0e08799( tablet.origin ) )
            {
                i++;
                tablet = level.contractmanager.hiddentablets[ i ];
                
                if ( i >= level.contractmanager.hiddentablets.size )
                {
                    return;
                }
            }
        }
        
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

// Namespace br_contract_manager
// Params 1
// Checksum 0x9dd5ba22, Offset: 0x317e
// Size: 0x1a
function function_fffb65b0e4bd2b69( newtablet )
{
    level notify( #"hash_fcc1b2315748aabd", newtablet );
}

// Namespace br_contract_manager
// Params 4
// Checksum 0x34a8b143, Offset: 0x31a0
// Size: 0x167
function function_afc15d4bdb062dff( contractref, origin, angles, iselite )
{
    foreach ( data in level.contractmanager.contractdata )
    {
        ref = data.ref;
        
        if ( ref == contractref )
        {
            if ( common_item::items_isenabled() )
            {
                spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
                spawnoptions.var_fd47e835523b473f = 1;
                spawnoptions.cleanupdisabled = 1;
                spawnoptions.critical = 1;
                newtablet = common_item::function_61c2c0251e742ffd( common_item::function_80af1e9daffacc7d( data.lootref ), 1, spawnoptions );
            }
            else
            {
                newtablet = spawnscriptable( data.lootref, origin, angles );
                pickups::registerscriptableinstance( newtablet );
            }
            
            newtablet tabletinit( data );
            newtablet tabletshow();
            function_fffb65b0e4bd2b69( newtablet );
            return newtablet;
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x552288ec, Offset: 0x330f
// Size: 0x67b
function delayedshowtablets()
{
    if ( !isdefined( level.br_level ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    lastcircle = int( min( level.contractmanager.lastcircle, level.br_level.br_circleclosetimes.size ) );
    showpercent = getdvarfloat( @"hash_743253d28cd0d1f7", 0.3 );
    validtablets = [];
    cnt = getdvarint( @"hash_256e361ad85b753", 32 );
    var_2c79f2b1b59c9d6d = throttle::throttle_initialize_gate( "delayedShowTablet", cnt );
    
    for ( i = 0; i < level.contractmanager.hiddentablets.size ; i++ )
    {
        throttle::throttle_wait_gate( var_2c79f2b1b59c9d6d );
        tablet = level.contractmanager.hiddentablets[ i ];
        tablet.circleindex = br_circle_util::function_b9385c27e6459e42( tablet.origin );
        
        if ( tablet.circleindex >= 0 )
        {
            validtablets[ validtablets.size ] = tablet;
        }
    }
    
    throttle::throttle_destroy( var_2c79f2b1b59c9d6d );
    level.contractmanager.hiddentablets = arrayrandomize( validtablets );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        if ( !level.br_circle.circleindex )
        {
            br_analytics::branalytics_delayedshowtablets( 0, showpercent, validtablets.size, 0 );
            continue;
        }
        
        var_9cb095042fb73d82 = squared( level.contractmanager.var_9cb095042fb73d82 );
        var_eb798324546a36c4 = [];
        var_877226b6f2d75f2f = [];
        
        foreach ( type in level.contractmanager.contractdata )
        {
            var_877226b6f2d75f2f[ type.lootref ] = 0;
            
            if ( function_93f2b8f289652e2( type ) != 1 )
            {
                var_eb798324546a36c4[ type.lootref ] = 0;
                continue;
            }
            
            var_6ae7618eedc05d79 = function_dc401ee9c856c395( type );
            
            if ( var_6ae7618eedc05d79 > -1 )
            {
                var_eb798324546a36c4[ type.lootref ] = var_6ae7618eedc05d79;
                continue;
            }
            
            var_eb798324546a36c4[ type.lootref ] = type.var_d416063dbd153813;
        }
        
        validtablets = [];
        prioritytablets = [];
        skippedtablets = [];
        
        for ( i = 0; i < level.contractmanager.hiddentablets.size ; i++ )
        {
            tablet = level.contractmanager.hiddentablets[ i ];
            
            if ( !isdefined( tablet ) )
            {
                continue;
            }
            
            if ( tablet.circleindex >= level.br_circle.circleindex )
            {
                if ( !function_18a4e317f83d467d( tablet ) )
                {
                    continue;
                }
                
                result = function_93f2b8f289652e2( tablet.task.type );
                
                if ( result == -1 )
                {
                    continue;
                }
                else if ( result == 0 )
                {
                    skippedtablets[ skippedtablets.size ] = tablet;
                    continue;
                }
                
                if ( var_9cb095042fb73d82 > 0 )
                {
                    if ( tablet function_34071c53dfc789e6( var_9cb095042fb73d82, level.contractmanager.activetablets ) )
                    {
                        skippedtablets[ skippedtablets.size ] = tablet;
                        continue;
                    }
                    
                    if ( tablet function_34071c53dfc789e6( var_9cb095042fb73d82, validtablets ) )
                    {
                        skippedtablets[ skippedtablets.size ] = tablet;
                        continue;
                    }
                }
                
                if ( var_eb798324546a36c4[ tablet.type ] > 0 )
                {
                    prioritytablets[ prioritytablets.size ] = tablet;
                    var_eb798324546a36c4[ tablet.type ]--;
                    continue;
                }
                
                validtablets[ validtablets.size ] = tablet;
            }
        }
        
        showcount = int( ceil( validtablets.size * showpercent ) );
        var_e5702e20fac1982c = int( max( 0, level.contractmanager.var_1b0c92a836296d3a - level.contractmanager.var_1b0c92a836296d3a / level.contractmanager.var_6b059ba6e7923b61 * level.br_circle.circleindex - level.contractmanager.activetablets.size ) );
        showcount = minint( showcount, var_e5702e20fac1982c );
        var_cb3b8ec1111fac84 = 0;
        
        foreach ( tablet in prioritytablets )
        {
            if ( !isdefined( tablet ) )
            {
                continue;
            }
            
            tablet tabletshow();
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
            
            if ( var_877226b6f2d75f2f[ tablet.type ] >= level.contractmanager.var_d20593a250baacb6[ tablet.type ].var_546301a0b9b1e599 && level.contractmanager.var_d20593a250baacb6[ tablet.type ].var_546301a0b9b1e599 >= 0 )
            {
                skippedtablets[ skippedtablets.size ] = tablet;
                continue;
            }
            
            tablet tabletshow();
            var_877226b6f2d75f2f[ tablet.type ]++;
            var_cb3b8ec1111fac84++;
        }
        
        level.contractmanager.hiddentablets = skippedtablets;
        br_analytics::branalytics_delayedshowtablets( level.br_circle.circleindex, showpercent, validtablets.size, var_cb3b8ec1111fac84 );
        
        if ( level.br_circle.circleindex >= lastcircle )
        {
            break;
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xf315a233, Offset: 0x3992
// Size: 0x6a
function function_18a4e317f83d467d( tablet )
{
    if ( isdefined( tablet.task.type.funcs[ "validateContractNotInStronghold" ] ) )
    {
        return tablet.task [[ tablet.task.type.funcs[ "validateContractNotInStronghold" ] ]]();
    }
    
    return 1;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x92dec82d, Offset: 0x3a05
// Size: 0x10c
function function_4fc77f3ec3e6e634()
{
    self endon( #"game_ended" );
    
    while ( !isdefined( level.lockedvolumes ) || level.lockedvolumes.size < 1 )
    {
        wait 0.5;
    }
    
    foreach ( tablet in level.contractmanager.activetablets )
    {
        if ( isdefined( tablet.task.type.funcs[ "validateContractNotInStronghold" ] ) )
        {
            tablet.task [[ tablet.task.type.funcs[ "validateContractNotInStronghold" ] ]]();
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x8d29a6fc, Offset: 0x3b19
// Size: 0x113
function disablealltablets()
{
    foreach ( type in level.contractmanager.contractdata )
    {
        tablets = getlootscriptablearray( type.lootref );
        
        if ( type.enabled )
        {
            foreach ( tablet in tablets )
            {
                tablet tablethide();
            }
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x68fe856b, Offset: 0x3c34
// Size: 0x84
function function_a28ecf3e9eb9e64a( tablet )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        assertmsg( "<dev string:x83>" );
        return;
    }
    
    if ( tablet.var_b40b29fd272da45b )
    {
        return 0;
    }
    
    count = level.contractmanager.var_18d07b59d1165e7e.size;
    level.contractmanager.var_18d07b59d1165e7e[ count ] = tablet;
    tablet.var_b40b29fd272da45b = 1;
    return 1;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x7ac8c2e9, Offset: 0x3cc0
// Size: 0x20e
function function_2b369520ddba33ad()
{
    flags::gameflagwait( "prematch_done" );
    var_ef273788189c67cd = getdvarint( @"hash_88cc8ac36a3c2863", 32 );
    tablet_throttle = throttle::throttle_initialize_gate( "tablet", var_ef273788189c67cd );
    
    foreach ( tablet in level.contractmanager.var_18d07b59d1165e7e )
    {
        throttle::throttle_wait_gate( tablet_throttle );
        tablet thread tablethide();
        tablet.var_b40b29fd272da45b = undefined;
    }
    
    level.contractmanager.var_18d07b59d1165e7e = undefined;
    
    foreach ( tablet in level.contractmanager.hiddentablets )
    {
        throttle::throttle_wait_gate( tablet_throttle );
        tablet thread tablethide();
    }
    
    foreach ( tablet in level.contractmanager.activetablets )
    {
        if ( tablet.startdisabled )
        {
            throttle::throttle_wait_gate( tablet_throttle );
            tablet.startdisabled = undefined;
            tablet thread tablethide();
        }
    }
    
    throttle::throttle_destroy( tablet_throttle );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x62cf1c1e, Offset: 0x3ed6
// Size: 0x83
function tablethide( hideforever )
{
    self endon( #"show" );
    
    if ( hideforever )
    {
        self.hiddenforever = 1;
    }
    
    oncontracttablethide( self );
    
    if ( isdefined( level.contractmanager.var_b2a0d08193a033e6[ self.type ] ) )
    {
        level.contractmanager.var_b2a0d08193a033e6[ self.type ]++;
    }
    
    flags::gameflagwait( "prematch_done" );
    pickups::loothide( self );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x162a9e25, Offset: 0x3f61
// Size: 0x92
function function_dd32a8bb6a1fe649( obj )
{
    if ( isdefined( obj.tablettype ) && !obj.hiddenforever )
    {
        allowshow = 1;
        
        if ( isdefined( obj.tablettype.funcs[ "onShowAgain" ] ) )
        {
            allowshow = obj.task [[ obj.tablettype.funcs[ "onShowAgain" ] ]]();
        }
        
        if ( allowshow )
        {
            obj tabletshow( 1 );
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xbab88ba7, Offset: 0x3ffb
// Size: 0x15e
function tabletshow( skipanalytics )
{
    assert( isdefined( self.init ) );
    
    if ( isdefined( level.contractmanager.var_49f4d421a1819b70[ self.type ] ) )
    {
        level.contractmanager.var_49f4d421a1819b70[ self.type ]++;
    }
    
    self notify( #"show" );
    part = self.type;
    self setscriptablepartstate( part, "visible" );
    
    if ( !arraycontains( level.contractmanager.activetablets, self ) )
    {
        level.contractmanager.activetablets[ level.contractmanager.activetablets.size ] = self;
    }
    
    if ( arraycontains( level.contractmanager.hiddentablets, self ) )
    {
        level.contractmanager.hiddentablets = arrayremove( level.contractmanager.hiddentablets, self );
    }
    
    if ( !skipanalytics )
    {
        br_analytics::branalytics_spawntablet( self );
    }
    
    level callback::callback( #"on_contract_shown", { #ref:self.tablettype.ref, #tablet:self } );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x3e710d6c, Offset: 0x4161
// Size: 0xca
function tabletinit( type, iselite )
{
    if ( isdefined( self.init ) )
    {
        return;
    }
    
    self.init = 1;
    self.tablettype = type;
    tabletinit = type.funcs[ "onInit" ];
    
    if ( isdefined( tabletinit ) )
    {
        task = spawnstruct();
        task.type = type;
        task.iselite = iselite;
        task.tablet = self;
        self.task = task;
        self.init = task [[ tabletinit ]]();
        
        if ( !self.init )
        {
            br_analytics::branalytics_invalidtablet( self );
        }
    }
    
    return self.init;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xf481d960, Offset: 0x4234
// Size: 0x155
function oncontracttablethide( instance )
{
    if ( !isdefined( level.contractmanager ) )
    {
        return;
    }
    
    level.contractmanager.activetablets = arrayremove( level.contractmanager.activetablets, instance );
    
    if ( utility::issharedfuncdefined( #"gametype", #"oncontracttablethide" ) )
    {
        utility::callsharedfunc( #"gametype", #"oncontracttablethide", instance.task );
    }
    
    instance notify( #"onTabletHidden" );
    
    if ( isdefined( instance ) && isdefined( instance.tablettype ) && isdefined( instance.tablettype.ref ) )
    {
        contractdata = function_e92ed9aae2a073ad( instance.tablettype.ref );
        
        if ( isdefined( contractdata ) && isdefined( contractdata.funcs[ "onTabletHidden" ] ) )
        {
            [[ contractdata.funcs[ "onTabletHidden" ] ]]( instance );
        }
    }
    
    level callback::callback( #"on_contract_hidden", { #ref:instance.tablettype.ref, #tablet:instance } );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xfc4f134e, Offset: 0x4391
// Size: 0x1fe
function function_3d62ad47bb990e95( player )
{
    if ( !self.skipanalytics )
    {
        br_analytics::branalytics_missionstart( self, player );
    }
    
    team = player.team;
    idx = team;
    self.team = team;
    self.var_fe0156f1cf4e5f41 = player;
    self.ended = undefined;
    
    if ( level.contractmanager.var_b073c6c9822b3544 )
    {
        idx = player.sessionsquadid;
        self.squadindex = idx;
    }
    
    function_645d5f233e8b5442( idx, self );
    level.contractmanager.currenttasks[ level.contractmanager.currenttasks.size ] = self;
    
    if ( isdefined( player.closestpoi ) )
    {
        self.startingpoi = player.closestpoi;
    }
    
    function_9566ff59d4afcce6( self.type.ref );
    
    if ( utility::issharedfuncdefined( #"gametype", #"setactivecontractstatusomnvar" ) )
    {
        utility::callsharedfunc( #"gametype", #"setactivecontractstatusomnvar", team, self );
    }
    
    players = function_85e5094486ad4b57();
    
    foreach ( friendlyplayer in players )
    {
        if ( !self.skipanalytics )
        {
            challenges::function_7bc79aeb658f2606( friendlyplayer, self.type.index, player );
        }
        
        talking_gun::talkinggun_event( friendlyplayer, #"contract_start" );
    }
    
    level notify( #"quest_started", idx );
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x67003250, Offset: 0x4597
// Size: 0x71f
function endcontract( success, rewards, var_7dcfa778765f05d1, var_8b55d0911674b2ba, endstate )
{
    team = self.team;
    idx = self.squadindex ?? team;
    callback::callback( #"on_contract_end", { #success:istrue( success ), #index:idx, #task:self } );
    numteamplayers = 0;
    assert( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ idx ] ), "<dev string:xb1>" + idx + "<dev string:xe9>" );
    islegendarycontract = istrue( self.islegendarycontract );
    
    if ( utility::issharedfuncdefined( #"gametype", #"setactivecontractstatusomnvar" ) )
    {
        utility::callsharedfunc( #"gametype", #"setactivecontractstatusomnvar", team );
    }
    
    if ( !self.iselite )
    {
        function_c99523533b27649f();
        function_645d5f233e8b5442( idx, undefined );
    }
    
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_objective_index", 0 );
    }
    
    if ( success )
    {
        numteamplayers = players.size;
        
        foreach ( player in players )
        {
            player setclientomnvar( "ui_br_objective_duration_time", 0 );
            
            if ( !isdefined( player.brmissionscompleted ) )
            {
                player.brmissionscompleted = 0;
            }
            
            player.brmissionscompleted++;
            
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
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:xeb>" );
                    
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
            
            if ( !isdefined( player.var_1cb9bb9f1476cdd4 ) )
            {
                player.var_1cb9bb9f1476cdd4 = [];
            }
            
            if ( !arraycontains( player.var_1cb9bb9f1476cdd4, self.type.ref ) )
            {
                player.var_1cb9bb9f1476cdd4[ player.var_1cb9bb9f1476cdd4.size ] = self.type.ref;
            }
            
            challenges::function_84e8396c49d7b89d( player, self.type.index, 1, 1, self.startingpoi, self.type.ref, undefined, islegendarycontract );
        }
        
        if ( !isdefined( level.contractmanager.var_eadfe43e300095f8[ idx ] ) )
        {
            level.contractmanager.var_eadfe43e300095f8[ idx ] = 0;
        }
        
        level.contractmanager.var_eadfe43e300095f8[ idx ]++;
        
        if ( utility::issharedfuncdefined( #"gametype", #"givecontractadditionalrewards" ) )
        {
            utility::callsharedfunc( #"gametype", #"givecontractadditionalrewards", team, self );
        }
        
        callback::callback( #"on_contract_completed", { #players:players } );
    }
    else
    {
        foreach ( player in players )
        {
            player setclientomnvar( "ui_br_objective_duration_time", 0 );
            challenges::function_84e8396c49d7b89d( player, self.type.index, 0, 1, undefined, self.type.ref, undefined, islegendarycontract );
        }
        
        if ( isdefined( var_7dcfa778765f05d1 ) )
        {
            var_44eabfaaeeccd596 = isdefined( var_8b55d0911674b2ba ) ? teams::getsquadmates( var_7dcfa778765f05d1, var_8b55d0911674b2ba ) : teams::getteamdata( var_7dcfa778765f05d1, "players" );
            
            foreach ( var_1cf12352269e9a61 in var_44eabfaaeeccd596 )
            {
                challenges::function_84e8396c49d7b89d( var_1cf12352269e9a61, self.type.index, 1, 2, undefined, self.type.ref, undefined, islegendarycontract );
            }
        }
    }
    
    instanceholder = spawnstruct();
    instanceholder.questcategory = self.category;
    instanceholder.islegendarycontract = self.islegendarycontract;
    
    if ( success )
    {
        instanceholder.result = "success";
    }
    else
    {
        instanceholder.result = "failure";
    }
    
    if ( isdefined( self.tablet ) )
    {
        instanceholder.missionid = string( self.tablet.index );
        instanceholder.endstate = endstate;
        
        if ( !isdefined( rewards ) )
        {
            rewards = [];
        }
        
        br_analytics::branalytics_missionend( instanceholder, 1, rewards, numteamplayers );
    }
    
    if ( !self.iselite )
    {
        level.contractmanager.currenttasks = arrayremove( level.contractmanager.currenttasks, self );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x2df26cfa, Offset: 0x4cbe
// Size: 0x23e
function function_9490728b1fe4323( instance )
{
    lootref = instance.type;
    idx = function_6b738bc71eb53bd4();
    
    if ( isdefined( level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onTeamAssigned" ] ) )
    {
        if ( function_9cb0572c407b9880( idx ) )
        {
            assertmsg( idx + "<dev string:x111>" );
            return;
        }
        
        if ( br_publicevents::ispubliceventoftypeactive( %"contractor" ) )
        {
            instance.task.contractoractive = 1;
        }
        
        if ( utility::issharedfuncdefined( #"gametype", #"additionalrewardsoncontractpickup" ) )
        {
            utility::callsharedfunc( #"gametype", #"additionalrewardsoncontractpickup", self.team, instance.task );
        }
        
        instance tablethide();
        instance.task function_3d62ad47bb990e95( self );
        instance.task.var_48423c6dad66d9c3 = self;
        instance.task [[ level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onTeamAssigned" ] ]]();
        br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
        
        if ( arraycontains( level.contractmanager.activetablets, instance ) )
        {
            oncontracttablethide( instance );
        }
        
        instance.task function_4ce08e6d11678a2( #"hash_67eb4b642067882a" );
        callback::callback( #"on_contract_start", { #index:idx, #task:instance.task } );
        
        if ( utility::issharedfuncdefined( #"gametype", #"playadditionalcontractvoonpickup" ) )
        {
            utility::callsharedfunc( #"gametype", #"playadditionalcontractvoonpickup", self.team, instance.task );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x151>" + instance.type.ref );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x4f563e9e, Offset: 0x4f04
// Size: 0x58
function function_27236a33ea7d5ad9( team, shouldforce )
{
    if ( !isdefined( level.contractmanager.var_783f7d22ddce5c52 ) )
    {
        level.contractmanager.var_783f7d22ddce5c52 = [];
    }
    
    level.contractmanager.var_783f7d22ddce5c52[ team ] = shouldforce;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xc386260f, Offset: 0x4f64
// Size: 0x47, Type: bool
function function_af264a228f8c4b11( team )
{
    return isdefined( level.contractmanager ) && isdefined( level.contractmanager.var_783f7d22ddce5c52 ) && level.contractmanager.var_783f7d22ddce5c52[ team ];
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x207ec2, Offset: 0x4fb4
// Size: 0x30, Type: bool
function function_9cb0572c407b9880( idx )
{
    return isdefined( level.contractmanager ) && isdefined( level.contractmanager.var_ec04bf3a584cbd90[ idx ] );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x1e87e1, Offset: 0x4fed
// Size: 0x32
function selectindex( team, squadindex )
{
    return level.contractmanager.var_b073c6c9822b3544 ? squadindex : team;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xf3b4306d, Offset: 0x5028
// Size: 0x1a
function function_10576a4d43567108()
{
    return selectindex( self.team, self.squadindex );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xa4ad70f, Offset: 0x504b
// Size: 0x1a
function function_6b738bc71eb53bd4()
{
    return selectindex( self.team, self.sessionsquadid );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x8807916e, Offset: 0x506e
// Size: 0x72
function function_85e5094486ad4b57( team = self.team, squadindex = self.squadindex )
{
    squadindex = level.contractmanager.var_b073c6c9822b3544 ? squadindex : undefined;
    return isdefined( squadindex ) ? teams::getsquadmates( team, squadindex ) : teams::getteamdata( team, "players" );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x832537d, Offset: 0x50e9
// Size: 0x4f
function function_e1073238262d21f0( player )
{
    return level.contractmanager.var_b073c6c9822b3544 ? self.squadindex == player.sessionsquadid : self.team == player.team;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x2711762f, Offset: 0x5141
// Size: 0x47
function function_28779161e0912456( idx )
{
    if ( isdefined( level.contractmanager ) && isdefined( level.contractmanager.var_ec04bf3a584cbd90 ) )
    {
        return level.contractmanager.var_ec04bf3a584cbd90[ idx ];
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x21afd5d, Offset: 0x5191
// Size: 0x53
function function_645d5f233e8b5442( idx, contract )
{
    if ( !( isdefined( level.contractmanager ) && isdefined( level.contractmanager.var_ec04bf3a584cbd90 ) ) )
    {
        return;
    }
    
    level.contractmanager.var_ec04bf3a584cbd90[ idx ] = contract;
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x990224a5, Offset: 0x51ec
// Size: 0x316
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    activetablets = [];
    
    if ( !( isdefined( level.contractmanager ) && isdefined( level.contractmanager.activetablets ) ) )
    {
        return;
    }
    else
    {
        activetablets = level.contractmanager.activetablets;
    }
    
    foreach ( contract in level.contractmanager.contractdata )
    {
        if ( isdefined( contract.funcs[ "circleTick" ] ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( contract.ref == task.type.ref )
                {
                    task [[ contract.funcs[ "circleTick" ] ]]( dangercircleorigin, var_1bdc861911b3625e );
                }
            }
        }
    }
    
    foreach ( tablet in activetablets )
    {
        if ( distance2dsquared( dangercircleorigin, tablet.origin ) > var_1bdc861911b3625e * var_1bdc861911b3625e )
        {
            if ( level.wztrain_info.contract == tablet )
            {
                if ( !level.wztrain_info.contract_in_gas )
                {
                    level.wztrain_info.contract_in_gas = 1;
                    tablet.task notify( #"entered_gas" );
                }
            }
            else
            {
                tablet tablethide();
                level.contractmanager.hiddentablets[ level.contractmanager.hiddentablets.size ] = tablet;
                br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
                level notify( #"tablet_consumed_by_gas" );
            }
            
            continue;
        }
        
        if ( level.wztrain_info.contract == tablet )
        {
            level.wztrain_info.contract_in_gas = 0;
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xf320c37a, Offset: 0x550a
// Size: 0x3ba
function dangermulticircletick()
{
    if ( !isdefined( level.contractmanager ) )
    {
        return;
    }
    
    foreach ( contract in level.contractmanager.contractdata )
    {
        if ( isdefined( contract.funcs[ "circleTick" ] ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( contract.ref == task.type.ref )
                {
                    task [[ contract.funcs[ "circleTick" ] ]]();
                }
            }
        }
    }
    
    hiddentablets = [];
    
    if ( level.wztrain_info.contract && !arraycontains( level.contractmanager.activetablets, level.wztrain_info.contract ) )
    {
        level.contractmanager.activetablets[ level.contractmanager.activetablets.size ] = level.wztrain_info.contract;
    }
    
    foreach ( tablet in level.contractmanager.activetablets )
    {
        if ( !( isdefined( tablet ) && isdefined( tablet.type ) && isdefined( tablet.tablettype ) ) )
        {
            continue;
        }
        
        if ( !isdefined( tablet.origin ) )
        {
            logstring( "br_contract_manager::dangerMultiCircleTick tablet does not have an origin! " + tablet.type );
            continue;
        }
        
        if ( !br_circle_util::ispointinmulticircledanger( tablet.origin, level.var_ea96217a33eb6457 ) )
        {
            if ( level.wztrain_info.contract == tablet )
            {
                if ( !level.wztrain_info.contract_in_gas )
                {
                    level.wztrain_info.contract_in_gas = 1;
                    tablet.task notify( #"entered_gas" );
                    hiddentablets[ hiddentablets.size ] = tablet;
                    oncontracttablethide( tablet );
                    pickups::loothide( tablet );
                }
            }
            else
            {
                hiddentablets[ hiddentablets.size ] = tablet;
                oncontracttablethide( tablet );
                pickups::loothide( tablet );
                br_plunder::modify_plunder_itemsinworld( "brloot_mission_tablet", -1 );
                level notify( #"tablet_consumed_by_gas" );
            }
            
            continue;
        }
        
        if ( level.wztrain_info.contract == tablet && level.wztrain_info.contract_in_gas )
        {
            level.wztrain_info.contract_in_gas = 0;
        }
    }
    
    return hiddentablets;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x5527bd86, Offset: 0x58cd
// Size: 0x425
function onCircleRelocation( params )
{
    /#
        var_ab234bb71ab92631 = 0;
    #/
    
    var_ef273788189c67cd = getdvarint( @"hash_a9ec52b9d0ca3d72", 32 );
    tablet_throttle = throttle::throttle_initialize_gate( "tablet_reinit", var_ef273788189c67cd );
    callback::callback( "contracts_reinit" );
    
    foreach ( tablet in level.contractmanager.activetablets )
    {
        if ( !( isdefined( tablet ) && isdefined( tablet.type ) && isdefined( tablet.tablettype ) ) )
        {
            continue;
        }
        
        if ( !isdefined( tablet.origin ) )
        {
            logstring( "br_contract_manager::onCircleRelocation tablet does not have an origin! " + tablet.type );
            continue;
        }
        
        lootref = tablet.type;
        reinitsuccess = 1;
        
        if ( isdefined( level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onCircleRelocation" ] ) )
        {
            reinitsuccess = tablet.task [[ level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onCircleRelocation" ] ]]();
            throttle::throttle_wait_gate( tablet_throttle );
        }
        
        if ( !reinitsuccess )
        {
            tablet thread tablethide( 1 );
            
            /#
                var_ab234bb71ab92631 += 1;
            #/
        }
    }
    
    /#
        println( "<dev string:x183>" + var_ab234bb71ab92631 );
        var_420e121060a9cf8b = 0;
    #/
    
    foreach ( tablet in level.contractmanager.hiddentablets )
    {
        if ( !( isdefined( tablet ) && isdefined( tablet.type ) && isdefined( tablet.tablettype ) ) )
        {
            continue;
        }
        
        if ( !isdefined( tablet.origin ) )
        {
            logstring( "br_contract_manager::onCircleRelocation tablet does not have an origin! " + tablet.type );
            continue;
        }
        
        if ( tablet.hiddenforever )
        {
            continue;
        }
        
        lootref = tablet.type;
        reinitsuccess = 1;
        
        if ( isdefined( level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onCircleRelocation" ] ) )
        {
            reinitsuccess = tablet.task [[ level.contractmanager.var_d20593a250baacb6[ lootref ].funcs[ "onCircleRelocation" ] ]]();
        }
        
        if ( reinitsuccess )
        {
            tablet.circleindex = br_circle_util::function_b9385c27e6459e42( tablet.origin );
        }
        else
        {
            tablet.circleindex = -1;
            tablet.hiddenforever = 1;
            
            /#
                var_420e121060a9cf8b += 1;
            #/
        }
        
        foreach ( type in level.contractmanager.contractdata )
        {
            var_e2107337a6f23550 = type.funcs[ "onPostCircleRelocation" ];
            
            if ( isdefined( var_e2107337a6f23550 ) )
            {
                level [[ var_e2107337a6f23550 ]]();
            }
        }
        
        throttle::throttle_wait_gate( tablet_throttle );
    }
    
    println( "<dev string:x1a2>" + var_420e121060a9cf8b );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xc91fe443, Offset: 0x5cfa
// Size: 0xe5
function onplayerkilled( attacker, victim )
{
    if ( !( isdefined( level.contractmanager ) && isdefined( victim ) ) )
    {
        return;
    }
    
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( isdefined( task.type.funcs[ "onPlayerKilled" ] ) )
        {
            task [[ task.type.funcs[ "onPlayerKilled" ] ]]( attacker, victim );
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x84ddebfe, Offset: 0x5de7
// Size: 0xdb
function function_ec8e0db9b18cc122( victim )
{
    if ( !( isdefined( level.contractmanager ) && isdefined( victim ) ) )
    {
        return;
    }
    
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( isdefined( task.type.funcs[ "onMarkPlayerAsEliminated" ] ) )
        {
            task [[ task.type.funcs[ "onMarkPlayerAsEliminated" ] ]]( victim );
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x1f0cbf84, Offset: 0x5eca
// Size: 0xa9
function onplayerconnect( player )
{
    if ( !( isdefined( player.team ) && isdefined( level.contractmanager ) ) )
    {
        return;
    }
    
    squadindex = undefined;
    idx = player.team;
    
    if ( level.contractmanager.var_b073c6c9822b3544 )
    {
        if ( !isdefined( player.sessionsquadid ) )
        {
            return;
        }
        
        squadindex = player.sessionsquadid;
        idx = squadindex;
    }
    
    setquestrewardtier( getquestrewardtier( idx ), player.team, squadindex );
    player function_4f491042394a6a2f();
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x7934e64, Offset: 0x5f7b
// Size: 0xdb
function onplayerdisconnect( player )
{
    if ( !( isdefined( level.contractmanager ) && isdefined( player ) ) )
    {
        return;
    }
    
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( isdefined( task.type.funcs[ "onPlayerDisconnect" ] ) )
        {
            task [[ task.type.funcs[ "onPlayerDisconnect" ] ]]( player );
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x71a010bd, Offset: 0x605e
// Size: 0x9d
function onplayerentergulag()
{
    if ( !isdefined( level.contractmanager ) )
    {
        return;
    }
    
    idx = function_6b738bc71eb53bd4();
    
    if ( function_9cb0572c407b9880( idx ) )
    {
        task = function_28779161e0912456( idx );
        
        if ( isdefined( task.type.funcs[ "onEnterGulag" ] ) )
        {
            task [[ task.type.funcs[ "onEnterGulag" ] ]]( self );
        }
        
        if ( isdefined( task.var_e702f7ee6139a98d ) )
        {
            function_53cdbd5f48a66a5a();
        }
    }
    
    onglobalplayerentergulag();
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x602d75b0, Offset: 0x6103
// Size: 0xbc
function onglobalplayerentergulag()
{
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( isdefined( task.type.funcs[ "onGlobalPlayerEnterGulag" ] ) )
        {
            task [[ task.type.funcs[ "onGlobalPlayerEnterGulag" ] ]]( self );
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x7b885ea6, Offset: 0x61c7
// Size: 0xac
function onplayerrespawn()
{
    if ( !isdefined( level.contractmanager ) )
    {
        return;
    }
    
    idx = function_6b738bc71eb53bd4();
    self setclientomnvar( "ui_player_spawned_notify", gettime() );
    
    if ( function_9cb0572c407b9880( idx ) )
    {
        task = function_28779161e0912456( idx );
        
        if ( isdefined( task.type.funcs[ "onPlayerRespawn" ] ) )
        {
            task [[ task.type.funcs[ "onPlayerRespawn" ] ]]( self );
        }
        
        if ( isdefined( task.var_e702f7ee6139a98d ) )
        {
            function_53cdbd5f48a66a5a();
        }
    }
    
    onglobalplayerrespawn();
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xb2610ddc, Offset: 0x627b
// Size: 0xbc
function onglobalplayerrespawn()
{
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( isdefined( task.type.funcs[ "onGlobalPlayerRespawn" ] ) )
        {
            task [[ task.type.funcs[ "onGlobalPlayerRespawn" ] ]]( self );
        }
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xb7854112, Offset: 0x633f
// Size: 0x59
function packsplashparambits( contractindex, rewardcash )
{
    assert( contractindex >= 0 && contractindex < 64 );
    assert( rewardcash >= 0 && rewardcash < 8192 );
    value = contractindex;
    value |= rewardcash << 5;
    return value;
}

// Namespace br_contract_manager
// Params 7
// Checksum 0x7782b301, Offset: 0x63a1
// Size: 0x10b
function function_1f816e3c3465df7e( splashref, contractindex, rewardcash, delay, splashlistoverride, team = self.team, squadindex = self.squadindex )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    params = packsplashparambits( contractindex, rewardcash );
    players = function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        player thread hud_message::showsplash( splashref, params, undefined, undefined, undefined, splashlistoverride );
    }
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x1c2f4ea8, Offset: 0x64b4
// Size: 0x82
function function_5c7e547ccc13711b( splash_key, params, splashlistoverride, team = self.team, squadindex = self.squadindex )
{
    assert( isdefined( splash_key ), "<dev string:x1c1>" );
    players = function_85e5094486ad4b57( team, squadindex );
    displaysplashtoplayers( players, splash_key, params, splashlistoverride );
}

// Namespace br_contract_manager
// Params 4
// Checksum 0x5b2cc2f5, Offset: 0x653e
// Size: 0x10b
function displaysplashtoplayers( players, splash_key, params, splashlistoverride )
{
    assert( isdefined( splash_key ), "<dev string:x1fc>" );
    
    if ( isdefined( level.br_ending ) )
    {
        return;
    }
    
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
        
        displayplayersplash( player, splash_key, params, splashlistoverride );
    }
}

// Namespace br_contract_manager
// Params 4
// Checksum 0x853217cd, Offset: 0x6651
// Size: 0xb7
function displayplayersplash( player, splash_key, params, splashlistoverride )
{
    assert( isdefined( splash_key ), "<dev string:x22e>" + player.name );
    
    if ( isdefined( params ) && isdefined( params.packedbits ) )
    {
        player thread hud_message::showsplash( splash_key, params.packedbits, undefined, undefined, undefined, splashlistoverride );
        return;
    }
    
    if ( isdefined( params ) && isdefined( params.intvar ) )
    {
        player thread hud_message::showsplash( splash_key, params.intvar, undefined, undefined, undefined, splashlistoverride );
        return;
    }
    
    player thread hud_message::showsplash( splash_key, undefined, undefined, undefined, undefined, splashlistoverride );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xb51d935e, Offset: 0x6710
// Size: 0x46
function function_7c9586992cf68ed1( splash_key )
{
    if ( utility::issharedfuncdefined( #"gametype", #"getcontractsplashrefoverride" ) )
    {
        splash_key = utility::callsharedfunc( #"gametype", #"getcontractsplashrefoverride", self, splash_key );
    }
    
    return splash_key;
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x97bb4b29, Offset: 0x675f
// Size: 0xe9
function function_ba80ad6a1d946b85( state, missionid, player_ref = self.var_fe0156f1cf4e5f41, team = self.team, squadindex = self.squadindex )
{
    players = function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        player displaysquadmessagetoplayer( player_ref, state, missionid );
    }
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xbe558f77, Offset: 0x6850
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

// Namespace br_contract_manager
// Params 1
// Checksum 0xdfdc949d, Offset: 0x68c8
// Size: 0x90
function function_4ce08e6d11678a2( ref )
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player giveplayerpoints( player, ref );
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x9ad8727f, Offset: 0x6960
// Size: 0x1f
function giveplayerpoints( player, ref )
{
    player thread points::doscoreevent( ref );
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x8ccd0cd9, Offset: 0x6987
// Size: 0x156
function function_b49b725168351e6( amount, team = self.team, squadindex = self.squadindex )
{
    players = function_85e5094486ad4b57( team, squadindex );
    var_4fa2322207914d5d = getdvarfloat( @"hash_7165dad703502609", 0.4 );
    
    foreach ( player in players )
    {
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        tempamount = amount;
        
        if ( !player::isreallyalive( player ) )
        {
            tempamount = int( amount * var_4fa2322207914d5d );
        }
        else
        {
            tempamount = int( tempamount * br_quest_util::function_bf57ff81684bd6a( player ) );
        }
        
        player br_plunder::playerplunderpickup( tempamount );
        level.br_plunder.plunder_awarded_by_missions_total += tempamount;
    }
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xd79edf86, Offset: 0x6ae5
// Size: 0x140
function function_83568686b37e6a1d( amount, team = self.team, squadindex = self.squadindex )
{
    players = function_85e5094486ad4b57( team, squadindex );
    amountperplayer = int( amount / players.size );
    
    foreach ( player in players )
    {
        if ( isbot( player ) && br_public::istutorial() )
        {
            continue;
        }
        
        var_598d99a13ff89b63 = int( amountperplayer * br_quest_util::function_bf57ff81684bd6a( player ) );
        player br_plunder::playerplunderpickup( var_598d99a13ff89b63 );
        level.br_plunder.plunder_awarded_by_missions_total += var_598d99a13ff89b63;
        br_analytics::trackcashevent( player, "mission", var_598d99a13ff89b63 );
    }
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x15d4df41, Offset: 0x6c2d
// Size: 0x66
function function_106e2298800cd4b2( category, column, nullreturn )
{
    if ( category == "intel" )
    {
        category = "intel_upload";
    }
    
    data = tablelookup( "mp/brmissions.csv", 1, category, column );
    
    if ( !isdefined( data ) || data == "" )
    {
        return nullreturn;
    }
    
    return int( data );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x4bf96274, Offset: 0x6c9c
// Size: 0xa2
function function_93f2b8f289652e2( type, nocircle )
{
    assert( isdefined( type ) );
    mincircle = type.var_83d4ad26c60bfb29;
    maxcircle = type.var_e0d5eb2fac343453;
    
    if ( nocircle )
    {
        if ( mincircle <= 0 )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    if ( level.br_circle.circleindex < mincircle )
    {
        return 0;
    }
    
    if ( level.br_circle.circleindex > maxcircle && maxcircle != -1 )
    {
        return -1;
    }
    
    return 1;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xce4761bc, Offset: 0x6d47
// Size: 0x65
function function_dc401ee9c856c395( type )
{
    assert( isdefined( type ) );
    mincircle = type.var_83d4ad26c60bfb29;
    var_6ae7618eedc05d79 = type.var_9b0f065779b5af30;
    
    if ( level.br_circle.circleindex == mincircle )
    {
        return var_6ae7618eedc05d79;
    }
    
    return -1;
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x76ed8295, Offset: 0x6db4
// Size: 0xc5
function function_7d7e225a8f9c9222( contractname, rewardposition, team = self.team, contract = self, squadindex = self.squadindex )
{
    contractbundle = function_33c901ddb7f5c50( contractname );
    groupref = contractbundle.rewardgroup;
    
    if ( groupref )
    {
        squadindex = level.contractmanager.var_b073c6c9822b3544 ? squadindex : undefined;
        players = function_85e5094486ad4b57( team, squadindex );
        return function_83f627106ef43736( groupref, rewardposition, team, contract, squadindex );
    }
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x59be062b, Offset: 0x6e81
// Size: 0x143
function function_83f627106ef43736( groupref, rewardposition, team = self.team, contract = self, squadindex = self.squadindex )
{
    if ( groupref )
    {
        squadindex = level.contractmanager.var_b073c6c9822b3544 ? squadindex : undefined;
        players = function_85e5094486ad4b57( team, squadindex );
        rewardscriptable = undefined;
        
        if ( rewardposition.var_ea4a540642460712 || rewardposition.isdeployablekiosk || rewardposition.visible && isdefined( rewardposition.index ) )
        {
            rewardscriptable = rewardposition;
        }
        
        rewards = br_quest_util::givequestrewardgroup( groupref, team, rewardposition.origin, rewardposition.angles, rewardscriptable, players, squadindex );
        
        if ( utility::issharedfuncdefined( #"gametype", #"modifybasecontractrewards" ) )
        {
            utility::callsharedfunc( #"gametype", #"modifybasecontractrewards", team, contract, rewards );
        }
        
        return rewards;
    }
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xf10849bf, Offset: 0x6fcc
// Size: 0x65, Type: bool
function function_7864d8f2e3f3454b( task, instance, team )
{
    if ( isdefined( task.type.funcs[ "onFinishContract" ] ) )
    {
        task thread [[ task.type.funcs[ "onFinishContract" ] ]]( task, instance, team );
        return true;
    }
    
    return false;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x3b6cfa94, Offset: 0x703a
// Size: 0x2c
function function_e01c7810f3c75f0b( ref )
{
    return level.contractmanager.var_ab95e990a9975df8[ ref ].index;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xfcb24371, Offset: 0x706f
// Size: 0x2c
function getquestindex( ref )
{
    return level.contractmanager.var_6869b28625f86223[ ref ].index;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x149e64fe, Offset: 0x70a4
// Size: 0x2c
function getquesttableindex( ref )
{
    index = int( tablelookup( "mp/brmissions.csv", 1, ref, 0 ) );
    return index;
}

// Namespace br_contract_manager
// Params 4
// Checksum 0x8dc8790, Offset: 0x70d9
// Size: 0x61
function function_d2646c7b2b23ae4b( eventref, team, squadindex, delay )
{
    if ( isdefined( squadindex ) && level.contractmanager.var_b073c6c9822b3544 )
    {
        level thread overlord::function_3aaf8e5681173423( eventref, team, squadindex, delay );
        return;
    }
    
    level thread overlord::function_be2d6dc71f97faa6( eventref, team, delay );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xc5418379, Offset: 0x7142
// Size: 0x8f
function function_87e10a6e85d45d58( ref )
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player uiobjectiveshow( ref );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x8f5a5482, Offset: 0x71d9
// Size: 0x36
function uiobjectiveshow( ref )
{
    assert( isplayer( self ) );
    index = getquestindex( ref );
    setquestindexomnvar( index );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x8d081165, Offset: 0x7217
// Size: 0x84
function function_c99523533b27649f()
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player uiobjectivehide();
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x3032439e, Offset: 0x72a3
// Size: 0x17
function uiobjectivehide()
{
    assert( isplayer( self ) );
    setquestindexomnvar( 0 );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x1f1029ec, Offset: 0x72c2
// Size: 0x99
function function_9fe564137142e8ee( value, value2 )
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player uiobjectivesetparameter( value, value2 );
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xcb7814c6, Offset: 0x7363
// Size: 0x52
function uiobjectivesetparameter( value, value2 )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_param", value );
    
    if ( isdefined( value2 ) )
    {
        assert( isdefined( value ), "<dev string:x265>" );
        self setclientomnvar( "ui_br_objective_extraParam", value2 );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xad69e06c, Offset: 0x73bd
// Size: 0x26
function uiobjectivesetlootid( value )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_br_objective_loot_id", value );
}

// Namespace br_contract_manager
// Params 4
// Checksum 0x198de078, Offset: 0x73eb
// Size: 0xeb
function createquestobjicon( iconref, state, initalorigin, contract )
{
    self.objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
    {
        logstring( "[GSC_OBJECTIVE] Creating quest objective icon " + self.objectiveiconid );
    }
    
    if ( self.objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( self.objectiveiconid, state, ( 0, 0, 0 ), iconref );
        function_9b8e4487dc719615( self.objectiveiconid, contract );
        objective_showtoplayersinmask( self.objectiveiconid );
        objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        
        if ( isdefined( initalorigin ) )
        {
            movequestobjicon( initalorigin );
        }
        
        return;
    }
    
    println( self.category + "<dev string:x2a7>" );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x129508d9, Offset: 0x74de
// Size: 0x64
function function_9b8e4487dc719615( objectiveiconid, contract )
{
    objectivebackgroundtype = 4;
    
    if ( utility::issharedfuncdefined( #"gametype", #"getspecialobjectivebackgroundtype" ) )
    {
        objectivebackgroundtype = utility::callsharedfunc( #"gametype", #"getspecialobjectivebackgroundtype", contract );
    }
    
    objidpoolmanager::update_objective_setbackground( objectiveiconid, objectivebackgroundtype );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x3413b9f1, Offset: 0x754a
// Size: 0x1e
function movequestobjicon( neworigin )
{
    objidpoolmanager::update_objective_position( self.objectiveiconid, neworigin );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x84cbf948, Offset: 0x7570
// Size: 0x1c
function showquestobjicontoplayer( player )
{
    objective_addclienttomask( self.objectiveiconid, player );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x27849e30, Offset: 0x7594
// Size: 0x13
function showquestobjicontoall( objid )
{
    objective_addalltomask( objid );
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xbc650daa, Offset: 0x75af
// Size: 0x1c
function hidequestobjiconfromplayer( player )
{
    objective_removeclientfrommask( self.objectiveiconid, player );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xb58608a, Offset: 0x75d3
// Size: 0xc, Type: bool
function checkforactiveobjicon()
{
    return isdefined( self.objectiveiconid );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xda83c11e, Offset: 0x75e8
// Size: 0x4a
function deletequestobjicon()
{
    if ( getdvarint( @"hash_4b48454d225475a", 0 ) == 1 )
    {
        logstring( "[GSC_OBJECTIVE] Deleting quest objective icon " + self.objectiveiconid );
    }
    
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xf84b0cfc, Offset: 0x763a
// Size: 0xe6
function function_b6def068f44f04c9( objectiveidnum, teamname, iselite )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) && !player br_public::isplayeringulag() )
        {
            if ( iselite )
            {
                questchain = quest_chain::function_2d09fe0b8396ea40( teamname );
                
                if ( isdefined( questchain ) )
                {
                    objective_addclienttomask( objectiveidnum, player );
                }
                
                continue;
            }
            
            objective_addclienttomask( objectiveidnum, player );
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x547d89bb, Offset: 0x7728
// Size: 0xa5
function function_3f9bfc2528d612aa( objectiveidnum )
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        if ( player::isreallyalive( player ) && !player br_public::isplayeringulag() )
        {
            objective_addclienttomask( objectiveidnum, player );
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x989d8283, Offset: 0x77d5
// Size: 0x63, Type: bool
function function_c0bc7ce931921c06( player )
{
    if ( !( isdefined( player.team ) && isdefined( self.team ) ) )
    {
        return false;
    }
    
    if ( isdefined( self.squadindex ) )
    {
        return ( self.squadindex == player.sessionsquadid );
    }
    
    return player.team == self.team;
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x752ce779, Offset: 0x7841
// Size: 0xd6
function function_14a772eecc5cf7d1( gestureweaponobj, var_48e9b160167e8daf, animdelay )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    assert( isdefined( gestureweaponobj ) && gestureweaponobj.basename != "<dev string:x2c3>", "<dev string:x2c8>" );
    result = weapon_utility::giveandfireoffhandreliable( gestureweaponobj, var_48e9b160167e8daf );
    phonegesture = issubstr( gestureweaponobj.basename, "phone" );
    
    if ( result && phonegesture )
    {
        killstreak_utility::function_f45c61b25dd7ae02( "uav" );
    }
    
    self notify( #"hash_5253d4e5cb8f29fd" );
    
    if ( self.inlaststand )
    {
        thread killstreakdeploy::watchlaststandend( gestureweaponobj );
    }
    
    if ( animdelay > 0 )
    {
        wait animdelay;
    }
    
    return result;
}

// Namespace br_contract_manager
// Params 6
// Checksum 0x309320cb, Offset: 0x7920
// Size: 0x267
function utilflare_shootflare( spawn_origin, flaretype, var_f951735683ac7938, var_3ee032294dd9dd49, var_ac5529f58167b2b, activityinstance )
{
    level endon( #"game_ended" );
    content_filter = trace::create_contents( 0, 1, 0, 1, 0, 0, 0 );
    new_position = trace::ray_trace( spawn_origin + ( 0, 0, 4000 ), spawn_origin, undefined, content_filter, undefined, 1 )[ "position" ];
    
    if ( !isdefined( var_f951735683ac7938 ) )
    {
        var_f951735683ac7938 = 0;
    }
    
    if ( var_f951735683ac7938 )
    {
        flare = spawn( "script_model", spawn_origin, 0, 1 );
    }
    else
    {
        flare = spawn( "script_model", new_position, 0, 1 );
    }
    
    if ( !isdefined( flare ) )
    {
        return;
    }
    
    start_pos = flare.origin;
    flare.angles = vectortoangles( ( 0, 0, 1 ) );
    
    if ( isdefined( var_3ee032294dd9dd49 ) )
    {
        flare setmodel( "equip_flare_ob" );
    }
    else if ( var_ac5529f58167b2b )
    {
        flare setmodel( "equip_flare_br_persistent" );
        activityinstance.flare = flare;
    }
    else
    {
        eventflare = 0;
        
        if ( isdefined( flaretype ) && utility::issharedfuncdefined( #"contract_manager", #"hash_aefe28d1fed6a259" ) )
        {
            eventflare = utility::callsharedfunc( #"contract_manager", #"hash_aefe28d1fed6a259", flaretype );
            flarename = "equip_flare_br_" + flaretype;
        }
        
        if ( eventflare )
        {
            flare setmodel( flarename );
        }
        else
        {
            flare setmodel( "equip_flare_br" );
        }
    }
    
    wait 0.5;
    start_state = isdefined( flaretype ) && flare getscriptableparthasstate( "launch", "start_" + flaretype ) ? "start_" + flaretype : "start";
    flare setscriptablepartstate( "launch", start_state, 0 );
    travel_state = isdefined( flaretype ) && flare getscriptableparthasstate( "travel", "start_" + flaretype ) ? "start_" + flaretype : "start";
    
    if ( isdefined( flaretype ) )
    {
        if ( flaretype == "4th_july" )
        {
            playsoundatpos( start_pos, "mus_iw9_flare_launch_stinger_july4" );
        }
    }
    
    flare setscriptablepartstate( "travel", travel_state, 0 );
    flare thread _utilflare_lerpflare( flaretype, var_ac5529f58167b2b );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x20fb184c, Offset: 0x7b8f
// Size: 0x6a
function _utilflare_lerpflare( flaretype, var_ac5529f58167b2b )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    movetime = 3.125;
    self moveto( self.origin + ( 0, 0, 2500 ), movetime );
    wait movetime;
    _utilflare_flareexplode( flaretype, var_ac5529f58167b2b );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x511c0bb4, Offset: 0x7c01
// Size: 0xc6
function _utilflare_flareexplode( flaretype = "<undefined>", var_ac5529f58167b2b )
{
    self setscriptablepartstate( "travel", "off", 0 );
    
    if ( !_utilflare_isvalidflaretype( flaretype, 1 ) && var_ac5529f58167b2b )
    {
        assertmsg( "<dev string:x31b>" + flaretype + "<dev string:xe9>" );
        return;
    }
    else if ( !_utilflare_isvalidflaretype( flaretype ) && !var_ac5529f58167b2b )
    {
        assertmsg( "<dev string:x359>" + flaretype + "<dev string:xe9>" );
        return;
    }
    
    fxstate = "start_" + flaretype;
    self setscriptablepartstate( "explode", fxstate, 0 );
    
    if ( var_ac5529f58167b2b )
    {
        thread function_646889a4fb85f1e5( flaretype );
        return;
    }
    
    thread sfx_br_flare_phosphorus( flaretype );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x383e497b, Offset: 0x7ccf
// Size: 0xf6
function _utilflare_isvalidflaretype( flaretype, var_ac5529f58167b2b )
{
    if ( utility::issharedfuncdefined( #"contract_manager", #"hash_aefe28d1fed6a259" ) )
    {
        if ( utility::callsharedfunc( #"contract_manager", #"hash_aefe28d1fed6a259", flaretype ) )
        {
            return 1;
        }
    }
    
    validflaretype = 0;
    
    if ( isdefined( flaretype ) && var_ac5529f58167b2b )
    {
        switch ( flaretype )
        {
            case #"hash_c18a5e54713480e4":
            case #"hash_f4a9126c03d3385b":
                validflaretype = 1;
                break;
        }
    }
    else if ( isdefined( flaretype ) )
    {
        switch ( flaretype )
        {
            case #"hash_81d3708cb9f6fbd":
            case #"hash_3d59be23329d4272":
            case #"hash_46a03ade8d786057":
            case #"hash_b06d15a59bd8ea50":
            case #"hash_c03ed6f6f4fe9dad":
            case #"hash_f4a9126c03d3385b":
                validflaretype = 1;
                break;
        }
    }
    
    return validflaretype;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x630a8c83, Offset: 0x7dce
// Size: 0x167
function sfx_br_flare_phosphorus( flaretype )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_f8adc1a860b779ae = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus", "start_" + flaretype ) ? "start_" + flaretype : "start";
    var_dd712f292ad4a929 = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus_loop", "start_" + flaretype ) ? "start_" + flaretype : "start";
    var_2c520a51c7f6d995 = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus", "end_" + flaretype ) ? "end_" + flaretype : "end";
    self setscriptablepartstate( "phosphorus", var_f8adc1a860b779ae, 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", var_dd712f292ad4a929, 0 );
    
    switch ( flaretype )
    {
        case #"hash_46a03ade8d786057":
            wait 40;
            break;
        case #"hash_f4a9126c03d3385b":
            break;
        case #"hash_81d3708cb9f6fbd":
            wait 2;
            break;
        default:
            wait 12;
            break;
    }
    
    self setscriptablepartstate( "phosphorus", var_2c520a51c7f6d995, 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", "off", 0 );
    wait 5;
    self delete();
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x8c4ae6e9, Offset: 0x7f3d
// Size: 0x145
function function_646889a4fb85f1e5( flaretype )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_f8adc1a860b779ae = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus", "start_" + flaretype ) ? "start_" + flaretype : "start";
    var_dd712f292ad4a929 = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus_loop", "start_" + flaretype ) ? "start_" + flaretype : "start";
    var_2c520a51c7f6d995 = isdefined( flaretype ) && self getscriptableparthasstate( "phosphorus", "end_" + flaretype ) ? "end_" + flaretype : "end";
    fxstate = "end_" + flaretype;
    self setscriptablepartstate( "phosphorus", var_f8adc1a860b779ae, 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", var_dd712f292ad4a929, 0 );
    self waittill( #"end_flare_loop" );
    self setscriptablepartstate( "explode", fxstate, 0 );
    self setscriptablepartstate( "phosphorus", var_2c520a51c7f6d995, 0 );
    wait 0.3;
    self setscriptablepartstate( "phosphorus_loop", "off", 0 );
    wait 5;
    self delete();
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x41e1e684, Offset: 0x808a
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

// Namespace br_contract_manager
// Params 1
// Checksum 0xc8c11345, Offset: 0x80f4
// Size: 0x3a
function function_33c901ddb7f5c50( contractname )
{
    if ( isdefined( level.contractmanager.var_ab95e990a9975df8 ) )
    {
        return level.contractmanager.var_ab95e990a9975df8[ contractname ];
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xa8eb1f3f, Offset: 0x8137
// Size: 0x40
function function_4bc46e9c9bb0d265( category )
{
    contractbundle = function_33c901ddb7f5c50( category );
    contracttime = contractbundle.contracttime;
    
    if ( !isdefined( contracttime ) )
    {
        return 0;
    }
    
    return contracttime;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x51c4ccc0, Offset: 0x8180
// Size: 0x48
function function_e92ed9aae2a073ad( contractref )
{
    if ( !( isdefined( level.contractmanager ) && isdefined( level.contractmanager.var_ab95e990a9975df8 ) ) )
    {
        return;
    }
    
    return level.contractmanager.var_ab95e990a9975df8[ contractref ];
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x375a36d7, Offset: 0x81d1
// Size: 0xf2
function function_3fbbc67df36be7bb( time, animbuffer = 0 )
{
    self.totaltime = time + animbuffer;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player setclientomnvar( "ui_br_objective_duration_time", self.totaltime * 1000 );
    }
    
    self.missionstarttime = gettime();
    self.missiontime = self.missionstarttime + self.totaltime * 1000;
    function_a21d0af31443edfc();
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xa097be5a, Offset: 0x82cb
// Size: 0xfa
function function_3a67c27d33cb206c( time )
{
    self.missiontime += time * 1000;
    currenttime = gettime();
    elapsed = currenttime - self.missionstarttime;
    newtime = self.totaltime * 1000 - elapsed + time * 1000;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player setclientomnvar( "ui_br_objective_duration_time", newtime );
    }
    
    function_a21d0af31443edfc();
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x5a16dbd6, Offset: 0x83cd
// Size: 0x70
function function_cf8dc263065eabc9( time )
{
    if ( self.missiontime - gettime() <= 1000 )
    {
        return;
    }
    
    if ( self.missiontime - gettime() - time * 1000 <= 0 )
    {
        self.missiontime = gettime() + 1000;
    }
    else
    {
        self.missiontime -= time * 1000;
    }
    
    function_a21d0af31443edfc();
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x588473d4, Offset: 0x8445
// Size: 0xd6
function function_a21d0af31443edfc()
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
    
    contractdata = function_e92ed9aae2a073ad( self.category );
    updatefunc = contractdata.funcs[ "onTimerUpdate" ];
    
    if ( isdefined( updatefunc ) )
    {
        [[ updatefunc ]]();
    }
    
    thread function_ba413f6e6e9fa43f();
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x6448666b, Offset: 0x8523
// Size: 0x2d
function function_74170131b71209ba()
{
    curtime = gettime();
    endtime = self.missiontime;
    return ( endtime - curtime ) / 1000;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x975e014c, Offset: 0x8559
// Size: 0xbe
function function_ba413f6e6e9fa43f()
{
    self notify( #"hash_712bc7b5bc2fdeb7" );
    self endon( #"game_ended" );
    self endon( #"hash_712bc7b5bc2fdeb7" );
    self endon( #"task_ended" );
    waittime = ( self.missiontime - gettime() ) / 1000;
    
    if ( waittime < 0 )
    {
        self.missiontime = gettime() + 1000;
        waittime = ( self.missiontime - gettime() ) / 1000;
    }
    
    wait waittime;
    contractdata = function_e92ed9aae2a073ad( self.category );
    expiredfunc = contractdata.funcs[ "onTimerExpired" ];
    
    if ( isdefined( expiredfunc ) )
    {
        [[ expiredfunc ]]();
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x7f9fa80a, Offset: 0x861f
// Size: 0x27
function questrewardcirclepeek( team, squadindex )
{
    if ( isdefined( squadindex ) )
    {
        return;
    }
    
    br_circle_peek::function_6de0d379275546d1( team );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xefa8964f, Offset: 0x864e
// Size: 0x111
function function_5f48264a2892eeef( team, squadindex )
{
    var_15f3fcf6c0c8df08 = self;
    
    if ( player::isreallyalive( var_15f3fcf6c0c8df08 ) && !var_15f3fcf6c0c8df08 br_public::isplayeringulag() )
    {
        var_15f3fcf6c0c8df08 br_pickups::forcegivesuper( "super_supply_drop", 1, 0, 0, 0 );
        return;
    }
    
    players = function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == var_15f3fcf6c0c8df08 )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayeringulag() )
        {
            continue;
        }
        
        player br_pickups::forcegivesuper( "super_supply_drop", 1, 0, 0, 0 );
        break;
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x50be15ae, Offset: 0x8767
// Size: 0x89
function function_2f14979bf83bc3db( time )
{
    self.contracttotaltime = time;
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_6b56733ee9bf2290" ) )
    {
        time = utility::callsharedfunc( #"gametype", #"hash_6b56733ee9bf2290", self, time );
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"getspecialcontracttime" ) )
    {
        time = utility::callsharedfunc( #"gametype", #"getspecialcontracttime", self, time );
    }
    
    return time;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xb7d8baf2, Offset: 0x87f9
// Size: 0x46
function function_7f2bcd04a826b94e( time )
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_97f3ff570459093f" ) )
    {
        time = utility::callsharedfunc( #"gametype", #"hash_97f3ff570459093f", self, time );
    }
    
    return time;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xbfe55d1, Offset: 0x8848
// Size: 0x40
function getquestrewardtier( idx )
{
    utilstruct = br_quest_util::function_53e65e7cba4b09db();
    tier = utilstruct.tiers[ idx ];
    
    if ( !isdefined( tier ) )
    {
        tier = 0;
    }
    
    return tier;
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x914270ea, Offset: 0x8891
// Size: 0x97
function setquestrewardtier( tier, team, squadindex )
{
    utilstruct = br_quest_util::function_53e65e7cba4b09db();
    
    if ( utilstruct.var_ffa2c5fe1c38cb78 )
    {
        if ( tier > utilstruct.var_1900cf632676172b && utilstruct.var_286863dc363b45d0 )
        {
            tier = utilstruct.var_1900cf632676172b;
        }
        
        idx = squadindex ?? team;
        utilstruct.tiers[ idx ] = tier;
        function_365b0b3e0a4c5743( team, tier, squadindex );
    }
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xc1b5189c, Offset: 0x8930
// Size: 0x46
function function_907ba50d40fb0a0c( value, team, squadindex )
{
    idx = squadindex ?? team;
    setquestrewardtier( getquestrewardtier( idx ) + value, team, squadindex );
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xa724cd66, Offset: 0x897e
// Size: 0x47
function addquestrewardtierframeend( value, team, squadindex )
{
    waittillframeend();
    idx = squadindex ?? team;
    setquestrewardtier( getquestrewardtier( idx ) + value, team, squadindex );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x84a087ee, Offset: 0x89cd
// Size: 0x5e
function function_f4a5876cbb7cf34( team, value )
{
    utilstruct = br_quest_util::function_53e65e7cba4b09db();
    
    if ( utilstruct.var_ffa2c5fe1c38cb78 )
    {
        return ( value + int( value * float( getquestrewardtier( team ) ) * utilstruct.var_d2958f8f05865d78 ) );
    }
    
    return value;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xfeab0478, Offset: 0x8a33
// Size: 0xa1
function function_9566ff59d4afcce6( ref )
{
    index = getquesttableindex( ref );
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player setquestindexomnvar( index );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x11e802b6, Offset: 0x8adc
// Size: 0x8f
function function_3ee820240b414ddb( questindex )
{
    players = function_85e5094486ad4b57();
    
    foreach ( player in players )
    {
        player setquestindexomnvar( questindex );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x66ec04e6, Offset: 0x8b73
// Size: 0x19
function setquestindexomnvar( questindex )
{
    self setclientomnvar( "ui_br_objective_index", questindex );
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xa9fe0f37, Offset: 0x8b94
// Size: 0xcc
function function_365b0b3e0a4c5743( team, tier, squadindex )
{
    players = function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        player setquestrewardtieromnvar( tier );
    }
    
    displaytier = tier + 1;
    
    if ( displaytier > 1 )
    {
        displaysplashtoplayers( players, "br_multi_contract_tier_" + displaytier );
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x25cc0ee6, Offset: 0x8c68
// Size: 0x19
function setquestrewardtieromnvar( tier )
{
    self setclientomnvar( "ui_br_objective_reward_tier", tier );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xab95bf1e, Offset: 0x8c89
// Size: 0x67
function function_173bf8dac654a1e1( targetplayer, threatlevel )
{
    if ( isdefined( targetplayer ) && self.aq_targethudenabled )
    {
        entitynumber = targetplayer getentitynumber();
    }
    else
    {
        entitynumber = -1;
    }
    
    entitynumber += 1;
    value = threatlevel << 8 | entitynumber;
    self setclientomnvar( "ui_br_assassination_target", value );
}

// Namespace br_contract_manager
// Params 0
// Checksum 0x7d62063e, Offset: 0x8cf8
// Size: 0x151
function function_4f491042394a6a2f()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !level.contractmanager.var_a53b51ae8a01a37b || isbot( player ) )
    {
        return;
    }
    
    flags::gameflagwait( "infil_animatic_complete" );
    
    while ( level.contractmanager.activetablets.size > 0 )
    {
        player waittill( #"hash_4c899cfd503a471b", notification, var_f1fbdfbc829c686d );
        
        if ( notification != "custom_loot_card_update" )
        {
            continue;
        }
        
        assert( isdefined( var_f1fbdfbc829c686d ) );
        
        if ( !var_f1fbdfbc829c686d || !player::isreallyalive( player ) )
        {
            continue;
        }
        
        closestphone = function_47c86977a18df38b( level.contractmanager.activetablets, player.origin, 400 );
        
        if ( isdefined( closestphone ) )
        {
            if ( utility::issharedfuncdefined( #"gametype", #"setclosebycontractstatusomnvar" ) )
            {
                utility::callsharedfunc( #"gametype", #"setclosebycontractstatusomnvar", player, closestphone.task );
            }
            
            if ( player.canhackcontracts )
            {
                br_hacker_phone_quest::function_fb301c73f666fe9c( closestphone, player );
            }
        }
    }
}

/#

    // Namespace br_contract_manager
    // Params 1, eflags: 0x4
    // Checksum 0xe438bd79, Offset: 0x8e51
    // Size: 0x162, Type: dev
    function private function_a360fe748c75f5e7( mindistancesq )
    {
        level endon( #"game_ended" );
        level waittill( #"infils_ready" );
        
        foreach ( phone in level.contractmanager.activetablets )
        {
            if ( !isdefined( phone ) )
            {
                continue;
            }
            
            foreach ( otherphone in level.contractmanager.activetablets )
            {
                if ( !isdefined( otherphone ) )
                {
                    continue;
                }
                
                if ( phone == otherphone )
                {
                    continue;
                }
                
                if ( distancesquared( phone.origin, otherphone.origin ) <= mindistancesq )
                {
                    println( "<dev string:x38d>" );
                }
            }
        }
    }

#/

// Namespace br_contract_manager
// Params 1
// Checksum 0x496355a6, Offset: 0x8fbb
// Size: 0x404
function function_2550892140fff0c1( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    foreach ( task in level.contractmanager.currenttasks )
    {
        if ( task.type.ref == "assassination" )
        {
            if ( task.targetplayer == player )
            {
                if ( isdefined( task.type.funcs[ "onTargetAssimilated" ] ) )
                {
                    task [[ task.type.funcs[ "onTargetAssimilated" ] ]]( player, oldteam, newteam );
                }
                
                continue;
            }
            
            if ( task.targetplayer.team == oldteam )
            {
                if ( isdefined( task.type.funcs[ "onTargetTeamTearDown" ] ) )
                {
                    task [[ task.type.funcs[ "onTargetTeamTearDown" ] ]]( player, oldteam, newteam );
                }
                
                continue;
            }
            
            if ( task.targetplayer.team == newteam )
            {
                if ( isdefined( task.type.funcs[ "onTargetTeamAssimilated" ] ) )
                {
                    task [[ task.type.funcs[ "onTargetTeamAssimilated" ] ]]( player, oldteam, newteam );
                }
            }
        }
    }
    
    if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ oldteam ] ) )
    {
        if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ oldteam ].type.funcs[ "onPlayerTearDown" ] ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( level.contractmanager.var_ec04bf3a584cbd90[ oldteam ].team == task.team )
                {
                    task [[ task.type.funcs[ "onPlayerTearDown" ] ]]( player, oldteam, newteam );
                }
            }
        }
    }
    
    if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ newteam ] ) )
    {
        if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ newteam ].type.funcs[ "onPlayerAssimilated" ] ) )
        {
            foreach ( task in level.contractmanager.currenttasks )
            {
                if ( level.contractmanager.var_ec04bf3a584cbd90[ newteam ].team == task.team )
                {
                    task thread function_7f4bf78cb09b0426( player, oldteam, newteam );
                }
            }
        }
    }
    
    br_circle_peek::function_a70e58c72b536c47( oldteam, newteam );
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x50f168a1, Offset: 0x93c7
// Size: 0x58
function function_7f4bf78cb09b0426( player, oldteam, newteam )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    waitframe();
    self [[ self.type.funcs[ "onPlayerAssimilated" ] ]]( player, oldteam, newteam );
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x65ed10d9, Offset: 0x9427
// Size: 0xc6
function function_a0e70de0d9b56fb0( newtablet, lootref )
{
    if ( !isdefined( level.contractmanager.contractdata ) )
    {
        return;
    }
    
    foreach ( data in level.contractmanager.contractdata )
    {
        if ( data.lootref == lootref )
        {
            newtablet tabletinit( data );
            break;
        }
    }
}

/#

    // Namespace br_contract_manager
    // Params 0, eflags: 0x4
    // Checksum 0xab2f305e, Offset: 0x94f5
    // Size: 0x15f, Type: dev
    function private debuginit()
    {
        devgui::function_9082edeb5db93280( "<dev string:x42c>" );
        devgui::add_devgui_command( "<dev string:x43a>", "<dev string:x443>" );
        devgui::add_devgui_command( "<dev string:x463>", "<dev string:x46e>" );
        devgui::add_devgui_command( "<dev string:x494>", "<dev string:x4a5>" );
        devgui::add_devgui_command( "<dev string:x4c9>", "<dev string:x4d6>" );
        
        foreach ( data in level.contractmanager.contractdata )
        {
            ref = data.ref;
            devgui::add_devgui_command( "<dev string:x4f7>" + ref, "<dev string:x4fe>" + ref + "<dev string:x51b>" );
            devgui::add_devgui_command( "<dev string:x51e>" + ref, "<dev string:x52a>" + ref + "<dev string:x51b>" );
            devgui::add_devgui_command( "<dev string:x547>" + ref, "<dev string:x556>" + ref + "<dev string:x51b>" );
            devgui::add_devgui_command( "<dev string:x57b>" + ref, "<dev string:x587>" + ref + "<dev string:x51b>" );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_contract_manager
    // Params 0
    // Checksum 0xbbc79606, Offset: 0x965c
    // Size: 0x7e3, Type: dev
    function function_9313ac7c59ca74de()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.players[ 0 ] ) )
        {
            waitframe();
        }
        
        idx = level.players[ 0 ] function_6b738bc71eb53bd4();
        
        while ( true )
        {
            foreach ( data in level.contractmanager.contractdata )
            {
                ref = data.ref;
                dvar = hashcat( @"hash_1fbd753c98c4b8b4", ref );
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    
                    foreach ( tablet in level.contractmanager.activetablets )
                    {
                        if ( tablet.type == data.lootref )
                        {
                            level.players[ 0 ] function_9490728b1fe4323( tablet );
                            break;
                        }
                    }
                }
                
                dvar = @"hash_79cdeeba217bc3d8";
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    task = level.contractmanager.var_ec04bf3a584cbd90[ idx ];
                    task endcontract( 1 );
                }
                
                dvar = @"hash_99194b03dd977e5";
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    task = level.contractmanager.var_ec04bf3a584cbd90[ idx ];
                    task endcontract( undefined );
                }
                
                dvar = hashcat( @"hash_8f2895efe9ecd943", ref );
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    tablet = spawnscriptable( data.lootref, level.players[ 0 ].origin );
                    pickups::registerscriptableinstance( tablet );
                    tablet tabletinit( data );
                    tablet tabletshow();
                    function_fffb65b0e4bd2b69( tablet );
                }
                
                dvar = hashcat( @"hash_511c5d962c539aa8", ref );
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    
                    if ( level.contractmanager.var_b073c6c9822b3544 )
                    {
                        foreach ( team, squadarray in level.squaddata )
                        {
                            foreach ( squadindex, squad in squadarray )
                            {
                                players = teams::getsquadmates( team, squadindex, 1 );
                                
                                if ( players.size > 0 && players[ 0 ].sessionsquadid != level.players[ 0 ].sessionsquadid )
                                {
                                    function_e1384ed619bd6d5c( players[ 0 ], ref );
                                }
                            }
                        }
                    }
                    else
                    {
                        foreach ( teamdata in level.teamdata )
                        {
                            if ( teamdata[ "<dev string:x5ab>" ].size > 0 )
                            {
                                if ( teamdata[ "<dev string:x5ab>" ][ 0 ].team != level.players[ 0 ].team )
                                {
                                    function_e1384ed619bd6d5c( teamdata[ "<dev string:x5ab>" ][ 0 ], ref );
                                }
                            }
                        }
                    }
                }
                
                dvar = hashcat( @"hash_7b9d7f89b65a3054", ref );
                
                if ( getdvarint( dvar, 0 ) )
                {
                    setdvar( dvar, 0 );
                    
                    if ( level.contractmanager.var_b073c6c9822b3544 )
                    {
                        foreach ( team, squadarray in level.squaddata )
                        {
                            foreach ( squadindex, squad in squadarray )
                            {
                                players = teams::getsquadmates( team, squadindex, 1 );
                                
                                if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ players[ 0 ].sessionsquadid ] ) )
                                {
                                    continue;
                                }
                                
                                if ( players.size > 0 && players[ 0 ].sessionsquadid != level.players[ 0 ].sessionsquadid )
                                {
                                    function_e1384ed619bd6d5c( players[ 0 ], ref );
                                    break;
                                }
                            }
                        }
                        
                        continue;
                    }
                    
                    foreach ( teamdata in level.teamdata )
                    {
                        if ( teamdata[ "<dev string:x5ab>" ].size > 0 )
                        {
                            if ( isdefined( level.contractmanager.var_ec04bf3a584cbd90[ teamdata[ "<dev string:x5ab>" ][ 0 ].team ] ) )
                            {
                                continue;
                            }
                            
                            if ( teamdata[ "<dev string:x5ab>" ][ 0 ].team != level.players[ 0 ].team )
                            {
                                function_e1384ed619bd6d5c( teamdata[ "<dev string:x5ab>" ][ 0 ], ref );
                                break;
                            }
                        }
                    }
                }
            }
            
            var_66d9efe1edd7b4f7 = getdvarint( @"hash_86d0a6d671419333", 0 );
            
            if ( var_66d9efe1edd7b4f7 > 0 )
            {
                setdvar( @"hash_86d0a6d671419333", 0 );
                var_66d9efe1edd7b4f7 = min( var_66d9efe1edd7b4f7, level.contractmanager.activetablets.size );
                
                foreach ( tablet in level.contractmanager.activetablets )
                {
                    tablet tablethide();
                    oncontracttablethide( tablet );
                    var_66d9efe1edd7b4f7 -= 1;
                    
                    if ( var_66d9efe1edd7b4f7 <= 0 )
                    {
                        break;
                    }
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace br_contract_manager
    // Params 1
    // Checksum 0xf2eda780, Offset: 0x9e47
    // Size: 0x11b, Type: dev
    function function_bdbdeb959248f26e( params )
    {
        item = params.item;
        itembundle = params.itembundle;
        
        if ( isdefined( item ) && isdefined( itembundle ) && flags::gameflag( "<dev string:x5b8>" ) )
        {
            if ( itembundle.lootitemtype == %"hash_738d248ec973b8d2" )
            {
                foreach ( data in level.contractmanager.contractdata )
                {
                    if ( item.type == data.lootref )
                    {
                        item.keepinmap = 1;
                        item tabletinit( data );
                        break;
                    }
                }
            }
        }
    }

    // Namespace br_contract_manager
    // Params 2
    // Checksum 0xdc0e8968, Offset: 0x9f6a
    // Size: 0x195, Type: dev
    function function_e1384ed619bd6d5c( player, contractref )
    {
        if ( !( isdefined( player.team ) && isdefined( level.contractmanager.contractdata ) && isdefined( level.contractmanager.var_ab95e990a9975df8[ contractref ] ) ) )
        {
            return;
        }
        
        newtablet = undefined;
        
        foreach ( data in level.contractmanager.contractdata )
        {
            ref = data.ref;
            
            if ( ref == contractref )
            {
                newtablet = spawnscriptable( data.lootref, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                pickups::registerscriptableinstance( newtablet );
                newtablet tabletinit( data );
                function_fffb65b0e4bd2b69( newtablet );
                break;
            }
        }
        
        if ( !isdefined( newtablet ) )
        {
            return;
        }
        
        newtablet.task function_3d62ad47bb990e95( player );
        newtablet.task [[ level.contractmanager.var_ab95e990a9975df8[ contractref ].funcs[ "<dev string:x5c6>" ] ]]();
    }

#/

// Namespace br_contract_manager
// Params 2
// Checksum 0x36743584, Offset: 0xa107
// Size: 0x64
function function_42827c79f1968770( player, defaultfilter )
{
    filter = undefined;
    
    if ( utility::issharedfuncdefined( #"gametype", #"getcontractmanagerfilter" ) )
    {
        filter = utility::callsharedfunc( #"gametype", #"getcontractmanagerfilter", player );
    }
    
    if ( !isdefined( filter ) )
    {
        filter = defaultfilter;
    }
    
    return filter;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x164d5273, Offset: 0xa174
// Size: 0x1a, Type: bool
function filtercondition_isdead( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xca38ca7d, Offset: 0xa197
// Size: 0x1b, Type: bool
function filtercondition_ingulag( player )
{
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0x6d7a8665, Offset: 0xa1bb
// Size: 0x1e, Type: bool
function filtercondition_iseliminated( player )
{
    if ( player.br_iseliminated )
    {
        return false;
    }
    
    return true;
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x2b2eae7b, Offset: 0xa1e2
// Size: 0xbd
function function_5080bebe8ff42294( team, squadindex )
{
    validplayers = [];
    players = function_85e5094486ad4b57( team, squadindex );
    
    foreach ( player in players )
    {
        if ( !player br_public::isplayerinorgoingtogulag() && player::isreallyalive( player ) )
        {
            validplayers[ validplayers.size ] = player;
        }
    }
    
    return validplayers;
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xaae66118, Offset: 0xa2a8
// Size: 0x2c3, Type: bool
function function_52c4002a1b5a9030( team, squadindex )
{
    var_8c2d118ee9374c1f = getdvarint( @"hash_9d25d6735879edd5", 1 );
    var_a100c4dd0c4f7657 = getdvarint( @"hash_896b3c10c7a229fa", 1 );
    var_9250f7d5b7c39ee7 = getdvarint( @"hash_6d95fadfacaba24f", 60 );
    
    if ( isdefined( squadindex ) && !squads::function_eee6396d37a87f96( team, squadindex, "currentContractCancels" ) )
    {
        squads::function_9f63a83550fcfd48( team, squadindex, "currentContractCancels", 0 );
    }
    else if ( !isdefined( level.teamdata[ team ][ "currentContractCancels" ] ) )
    {
        level.teamdata[ team ][ "currentContractCancels" ] = 0;
    }
    
    if ( var_8c2d118ee9374c1f > 0 )
    {
        var_22f5ad7829f47eb6 = isdefined( squadindex ) ? squads::getsquaddata( team, squadindex, "currentContractCancels" ) : level.teamdata[ team ][ "currentContractCancels" ];
        
        if ( var_22f5ad7829f47eb6 == var_8c2d118ee9374c1f - 1 && var_a100c4dd0c4f7657 )
        {
            function_35cbe034f1956abd( team, squadindex, var_9250f7d5b7c39ee7 );
            function_ba382e3b3fda76f7( team, squadindex );
            return true;
        }
        else if ( var_22f5ad7829f47eb6 >= var_8c2d118ee9374c1f )
        {
            if ( var_a100c4dd0c4f7657 )
            {
                if ( gettime() < function_4dc9b019602597e9( team, squadindex ) )
                {
                    self.var_e702f7ee6139a98d = [];
                    playersonteam = function_5080bebe8ff42294( team, squadindex );
                    
                    foreach ( player in playersonteam )
                    {
                        var_f53364666834da49 = ( function_4dc9b019602597e9( team, squadindex ) - gettime() ) / 1000;
                        var_f53364666834da49 = int( max( 0, ceil( var_f53364666834da49 ) ) );
                        player hud_message::showerrormessage( level.contractmanager.var_4ed75045012f35a, var_f53364666834da49 );
                    }
                    
                    return false;
                }
                
                function_35cbe034f1956abd( team, squadindex, var_9250f7d5b7c39ee7 );
                function_ba382e3b3fda76f7( team, squadindex );
                return true;
            }
            else
            {
                self.var_e702f7ee6139a98d = [];
                playersonteam = function_5080bebe8ff42294( team, squadindex );
                
                foreach ( player in playersonteam )
                {
                    player hud_message::showerrormessage( level.contractmanager.cancelmessage );
                }
                
                return false;
            }
        }
    }
    
    function_ba382e3b3fda76f7( team, squadindex );
    return true;
}

// Namespace br_contract_manager
// Params 3
// Checksum 0xff6c8b74, Offset: 0xa574
// Size: 0x5f
function function_35cbe034f1956abd( team, squadindex, var_9250f7d5b7c39ee7 )
{
    if ( isdefined( squadindex ) )
    {
        squads::function_9f63a83550fcfd48( team, squadindex, "cancelDelayTime", gettime() + var_9250f7d5b7c39ee7 * 1000 );
        return;
    }
    
    level.teamdata[ team ][ "cancelDelayTime" ] = gettime() + var_9250f7d5b7c39ee7 * 1000;
}

// Namespace br_contract_manager
// Params 2
// Checksum 0xfe66e8a9, Offset: 0xa5db
// Size: 0x40
function function_4dc9b019602597e9( team, squadindex )
{
    if ( isdefined( squadindex ) )
    {
        return squads::getsquaddata( team, squadindex, "cancelDelayTime" );
    }
    
    return level.teamdata[ team ][ "cancelDelayTime" ];
}

// Namespace br_contract_manager
// Params 3
// Checksum 0x10a89945, Offset: 0xa623
// Size: 0x85
function function_ba382e3b3fda76f7( team, squadindex, amount = 1 )
{
    if ( isdefined( squadindex ) )
    {
        current = squads::getsquaddata( team, squadindex, "currentContractCancels" );
        squads::function_9f63a83550fcfd48( team, squadindex, "currentContractCancels", current + amount );
        return;
    }
    
    level.teamdata[ team ][ "currentContractCancels" ] = level.teamdata[ team ][ "currentContractCancels" ] + amount;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xc99fc875, Offset: 0xa6b0
// Size: 0x48
function contract_canceltask( team )
{
    if ( isdefined( self.type.funcs[ "onCancel" ] ) )
    {
        self thread [[ self.type.funcs[ "onCancel" ] ]]( team );
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x3b0b9815, Offset: 0xa700
// Size: 0xcd
function function_efc317b649761d32( team, squadindex )
{
    if ( !isdefined( self.var_e702f7ee6139a98d ) )
    {
        self.var_e702f7ee6139a98d = [];
        return 0;
    }
    
    numplayers = 0;
    playersonteam = function_5080bebe8ff42294( team, squadindex );
    
    foreach ( player in playersonteam )
    {
        if ( arraycontains( self.var_e702f7ee6139a98d, player ) )
        {
            numplayers++;
        }
    }
    
    return numplayers;
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x60ca4731, Offset: 0xa7d6
// Size: 0x143, Type: bool
function function_90dd4fd8f842fdb( team, squadindex )
{
    if ( !isdefined( self.var_e702f7ee6139a98d ) )
    {
        self.var_e702f7ee6139a98d = [];
        return false;
    }
    
    playersonteam = function_5080bebe8ff42294( team, squadindex );
    
    if ( function_efc317b649761d32( team, squadindex ) == playersonteam.size && function_52c4002a1b5a9030( team, squadindex ) )
    {
        function_d2646c7b2b23ae4b( "mission_cancel_complete", team, squadindex, 1 );
        contract_canceltask( team );
        
        foreach ( player in playersonteam )
        {
            player setclientomnvar( "ui_br_contract_cancellation_state", 0 );
        }
        
        thread function_5c7e547ccc13711b( "br_contract_cancelled_" + self.type.ref );
        
        if ( isdefined( squadindex ) )
        {
            level thread br_public::function_d37b11df5bdfb45b( "mission_gen_fail", team, squadindex, 1, 2 );
        }
        else
        {
            level thread br_public::brleaderdialogteam( "mission_gen_fail", team, 1, 2 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xb514b99d, Offset: 0xa922
// Size: 0x2af
function function_121d761f81c5a69c()
{
    idx = function_6b738bc71eb53bd4();
    
    if ( function_9cb0572c407b9880( idx ) )
    {
        contract = function_28779161e0912456( idx );
        
        if ( !isdefined( contract ) )
        {
            assertmsg( "<dev string:x5d5>" );
            return;
        }
        
        if ( !isdefined( contract.type.funcs[ "onCancel" ] ) )
        {
            assertmsg( "<dev string:x61f>" );
            return;
        }
        
        if ( !isdefined( contract.var_e702f7ee6139a98d ) )
        {
            contract.var_e702f7ee6139a98d = [];
        }
        
        squadindex = level.contractmanager.var_b073c6c9822b3544 ? self.sessionsquadid : undefined;
        
        if ( arraycontains( contract.var_e702f7ee6139a98d, self ) )
        {
            contract function_90dd4fd8f842fdb( self.team, squadindex );
            return;
        }
        
        contract.var_e702f7ee6139a98d[ contract.var_e702f7ee6139a98d.size ] = self;
        
        if ( !contract function_90dd4fd8f842fdb( self.team, squadindex ) )
        {
            friendlyplayers = function_5080bebe8ff42294( self.team, squadindex );
            overlord::playevent( "mission_cancel_request", arrayremove( friendlyplayers, contract.var_e702f7ee6139a98d ) );
            var_196ba86d7faa9e2b = contract function_efc317b649761d32( self.team, squadindex );
            totalplayers = friendlyplayers.size;
            combineddata = var_196ba86d7faa9e2b | totalplayers << 3;
            
            foreach ( player in friendlyplayers )
            {
                player setclientomnvar( "ui_br_contract_cancellation_state", combineddata );
            }
            
            if ( contract.var_e702f7ee6139a98d.size > 0 )
            {
                foreach ( player in friendlyplayers )
                {
                    if ( !arraycontains( contract.var_e702f7ee6139a98d, player ) )
                    {
                        displayplayersplash( player, "br_" + contract.type.ref + "_quest_pending" );
                    }
                }
            }
        }
    }
}

// Namespace br_contract_manager
// Params 0
// Checksum 0xd57967bd, Offset: 0xabd9
// Size: 0x1c7
function function_53cdbd5f48a66a5a()
{
    idx = function_6b738bc71eb53bd4();
    
    if ( function_9cb0572c407b9880( idx ) )
    {
        contract = function_28779161e0912456( idx );
        squadindex = level.contractmanager.var_b073c6c9822b3544 ? self.sessionsquadid : undefined;
        friendlyplayers = function_5080bebe8ff42294( self.team, squadindex );
        
        if ( !isdefined( contract ) )
        {
            assertmsg( "<dev string:x5d5>" );
            return;
        }
        
        if ( !isdefined( contract.var_e702f7ee6139a98d ) )
        {
            return;
        }
        
        if ( arraycontains( contract.var_e702f7ee6139a98d, self ) )
        {
            if ( br_public::isplayerinorgoingtogulag() || !player::isreallyalive( self ) )
            {
                contract.var_e702f7ee6139a98d = arrayremove( contract.var_e702f7ee6139a98d, self );
            }
        }
        
        if ( !contract function_90dd4fd8f842fdb( self.team, squadindex ) )
        {
            overlord::playevent( "mission_cancel_request", arrayremove( friendlyplayers, contract.var_e702f7ee6139a98d ) );
            var_196ba86d7faa9e2b = contract function_efc317b649761d32( self.team, squadindex );
            totalplayers = friendlyplayers.size;
            combineddata = var_196ba86d7faa9e2b | totalplayers << 3;
            
            foreach ( player in friendlyplayers )
            {
                player setclientomnvar( "ui_br_contract_cancellation_state", combineddata );
            }
        }
    }
}

// Namespace br_contract_manager
// Params 2
// Checksum 0x8e4933a2, Offset: 0xada8
// Size: 0x3b
function function_dbddd582addf522c( notification, value )
{
    if ( isdefined( notification ) )
    {
        switch ( notification )
        {
            case #"hash_9fd64c8b171158f":
                function_121d761f81c5a69c();
                break;
        }
    }
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xf1340c15, Offset: 0xadeb
// Size: 0x48
function function_d0e283b300baf433( tabletorigin )
{
    isunderwater = 0;
    waterheightz = getwaterheightatlocation( tabletorigin );
    
    if ( isdefined( waterheightz ) )
    {
        diffz = tabletorigin[ 2 ] - waterheightz;
        isunderwater = diffz < 0;
    }
    
    return isunderwater;
}

// Namespace br_contract_manager
// Params 1
// Checksum 0xb0ace48, Offset: 0xae3c
// Size: 0x31
function function_ef612fee431a6a0a( instance )
{
    if ( common_item::items_isenabled() )
    {
        return common_item::function_f107d23d5275a951( instance.type, "activitystarter" );
    }
    
    return 0;
}

// Namespace br_contract_manager
// Params 5
// Checksum 0x2290c22a, Offset: 0xae75
// Size: 0x1e5
function function_2159ab6c273022cc( origin, mindistsq, maxdistsq, checkcircles, var_bbcc58bab9cf8264 )
{
    allpoints = getunusedlootcachepoints();
    selectedpoint = undefined;
    backuppoints = [];
    circlecenter = br_circle::getnextsafecircleorigin();
    circleradius = br_circle::getnextsafecircleradius();
    
    foreach ( point in allpoints )
    {
        if ( function_d0e283b300baf433( point.origin ) )
        {
            continue;
        }
        
        if ( ai_fortress::function_f96df72675d7e8c6( point.origin ) )
        {
            continue;
        }
        
        if ( br_scavenger_quest::function_9e34ff6f77321bef( point.origin ) )
        {
            continue;
        }
        
        if ( br_bunker_utility::function_5f3fda39a064e862( point.origin ) )
        {
            continue;
        }
        
        if ( locksandkeys::function_9894956c856a7904( point.origin ) )
        {
            continue;
        }
        
        if ( checkcircles && isdefined( circlecenter ) && isdefined( circleradius ) )
        {
            if ( distance2dsquared( circlecenter, point.origin ) > circleradius * circleradius )
            {
                continue;
            }
        }
        
        if ( var_bbcc58bab9cf8264 )
        {
            backuppoints[ backuppoints.size ] = point;
        }
        
        dist = distance2dsquared( origin, point.origin );
        
        if ( dist > mindistsq && dist < maxdistsq )
        {
            selectedpoint = point;
            break;
        }
    }
    
    if ( !isdefined( selectedpoint ) )
    {
        if ( backuppoints.size > 0 )
        {
            selectedpoint = backuppoints[ randomint( backuppoints.size ) ];
        }
        else
        {
            selectedpoint = allpoints[ randomint( allpoints.size ) ];
        }
    }
    
    return selectedpoint;
}

