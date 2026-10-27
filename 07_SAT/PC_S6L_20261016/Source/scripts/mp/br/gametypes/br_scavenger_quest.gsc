// scripts\mp\br\gametypes\br_scavenger_quest.gsc  (hash_086b2d0e5abc6da7.gscc) (size: 23430 Bytes / 0x5b86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0e40867 (2967734375)
// size ...... 23430 (0x5b86)
// includes .. 19  (offset: 0x56be)
// strings ... 72  (offset: 0x5756)
// dev strs .. 8   (offset: 0x5b16)
// exports ... 44  (offset: 0x3c62)
// cseg ...... 0x68e + 0x35d4 (0x3c62)
// imports ... 159 (offset: 0x4342)
// animtree1 . 0   (offset: 0x5b86)
// animtree2 . 0   (offset: 0x5b86)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace br_scavenger_quest;

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x7e01758e, Offset: 0x6ac
// Size: 0x286
function getcontractdata( data )
{
    level.scavprops = spawnstruct();
    var_47b2c991ea1286f0 = getdvarint( @"hash_5802e08d3a73518f", 0 );
    level.scavprops.time = var_47b2c991ea1286f0 != 0 ? var_47b2c991ea1286f0 : br_contract_manager::function_4bc46e9c9bb0d265( "scavenger" );
    function_d4705e17aa0f7845( data );
    level.scavprops.var_816fe3689f19bf37 = getdvarint( @"hash_225f4b8e2dcb0e36", 0 );
    level.scavprops.var_bf57ed7291a4ea1c = 0;
    level.scavprops.var_9f2415107b8df79e = 0;
    level.scavprops.var_5e64bc1fd5270ab4 = 0;
    callback::add( "contracts_reinit", &function_cbdeee842b6b0019 );
    data.funcs[ "onInit" ] = &scav_oninit;
    data.funcs[ "onTeamAssigned" ] = &scav_onteamassigned;
    data.funcs[ "onCancel" ] = &scav_oncancel;
    data.funcs[ "circleTick" ] = &function_e3c37db29ef37019;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerTearDown" ] = &scav_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &scav_onplayerassimilated;
    data.funcs[ "onTimerExpired" ] = &function_3053c86ae9d409c6;
    data.funcs[ "onFinishContract" ] = &function_9e065e3462c14dfd;
    data.funcs[ "onCircleRelocation" ] = &function_67b529e129462fe2;
    data.funcs[ "bestRespawnMissionOrigin" ] = &function_30e1c8272073cbc1;
    data.funcs[ "onPostTabletInit" ] = &function_63157d9ba71faae8;
    data.funcs[ "onPostCircleRelocation" ] = &function_63157d9ba71faae8;
    data.basetime = level.scavprops.time;
    initdialogue();
}

// Namespace br_scavenger_quest
// Params 1, eflags: 0x4
// Checksum 0x1e612bc5, Offset: 0x93a
// Size: 0x418
function private function_d4705e17aa0f7845( data )
{
    if ( data.var_3e66e51a241b9989.variant_object.contracttype == "Scav" )
    {
        level.scavprops.timebonus = getdvarint( @"hash_428ad704764ff3e7", data.var_3e66e51a241b9989.variant_object.var_b4cf59331380ec10 );
        level.scavprops.var_ce9802e8722a9e3 = getdvarint( @"hash_3deb493ce0569a9a", data.var_3e66e51a241b9989.variant_object.var_841dea2d691ff5e7 );
        level.scavprops.cachespawncount = getdvarint( @"hash_1eaf2ef86c1344e8", data.var_3e66e51a241b9989.variant_object.var_1000227fa52ddba6 );
        level.scavprops.var_969fe1df0f49bfbb = getdvarint( @"hash_40502e1ccc8afee2", data.var_3e66e51a241b9989.variant_object.scavengermaxrange );
        level.scavprops.var_aad0bb484dd85e49 = getdvarint( @"hash_6cf95a3cc8a2c6bc", data.var_3e66e51a241b9989.variant_object.scavengerminrange );
        level.scavprops.var_97050b1a3a69a1f6 = getdvarint( @"hash_a438440ce7ce72c", data.var_3e66e51a241b9989.variant_object.var_c8ff599821fbffe6 );
        level.scavprops.var_dfcae2ece12540c0 = getdvarint( @"hash_8ce4daaf96793442", data.var_3e66e51a241b9989.variant_object.var_7c498685b4a0adcc );
        level.scavprops.var_7534fb724afd7b91 = getdvarint( @"hash_dab0e9a1525b9075", data.var_3e66e51a241b9989.variant_object.var_7534fb724afd7b91 );
        level.scavprops.var_6824d12a3f2b6146 = getdvarint( @"hash_2b9d8f4be5437b84", data.var_3e66e51a241b9989.variant_object.var_b8db88806a68c1de );
        level.scavprops.var_49641b3ede16b76e = getdvarint( @"hash_849cc562887e6a7b", data.var_3e66e51a241b9989.variant_object.var_49641b3ede16b76e );
        return;
    }
    
    level.scavprops.timebonus = getdvarint( @"hash_428ad704764ff3e7", 45 );
    level.scavprops.var_ce9802e8722a9e3 = getdvarint( @"hash_3deb493ce0569a9a", 1 );
    level.scavprops.cachespawncount = getdvarint( @"hash_1eaf2ef86c1344e8", 3 );
    level.scavprops.var_969fe1df0f49bfbb = getdvarint( @"hash_40502e1ccc8afee2", 7000 );
    level.scavprops.var_aad0bb484dd85e49 = getdvarint( @"hash_6cf95a3cc8a2c6bc", 1200 );
    level.scavprops.var_97050b1a3a69a1f6 = getdvarint( @"hash_a438440ce7ce72c", 4350 );
    level.scavprops.var_dfcae2ece12540c0 = getdvarint( @"hash_8ce4daaf96793442", 1600 );
    level.scavprops.var_7534fb724afd7b91 = getdvarint( @"hash_dab0e9a1525b9075", 10 );
    level.scavprops.var_6824d12a3f2b6146 = getdvarint( @"hash_2b9d8f4be5437b84", 0 );
    level.scavprops.var_49641b3ede16b76e = getdvarint( @"hash_849cc562887e6a7b", 15 );
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x6a2e7b61, Offset: 0xd5a
// Size: 0x4d
function scav_oninit()
{
    if ( utility::issharedfuncdefined( #"hash_c7f590db1cbb7497", #"init" ) )
    {
        return utility::callsharedfunc( #"hash_c7f590db1cbb7497", #"init" );
    }
    
    if ( !isdefined( self.cachedata ) )
    {
        return function_b9dbee94704376a1();
    }
    
    return 1;
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x83cf4d6b, Offset: 0xdb0
// Size: 0x74
function initdialogue()
{
    game[ "dialog" ][ "scavenger_missionstart" ] = "scvn_wzan_msns";
    game[ "dialog" ][ "scavenger_onesecured" ] = "scvn_wzan_nscr";
    game[ "dialog" ][ "scavenger_twosecured" ] = "scvn_wzan_twsc";
    game[ "dialog" ][ "scavenger_missioncomplete" ] = "scvn_wzan_msnc";
    game[ "dialog" ][ "scavenger_almosttimeout" ] = "gnrc_wzan_mstw";
    game[ "dialog" ][ "scavenger_timeout" ] = "scvn_wzan_tmlr";
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x906d527b, Offset: 0xe2c
// Size: 0x105, Type: bool
function function_b9dbee94704376a1()
{
    if ( !isdefined( self.cachedata ) )
    {
        self.cachedata = [];
    }
    
    if ( !isdefined( self.cachescollected ) )
    {
        self.cachescollected = 0;
    }
    
    bestcaches = function_4a6cfc43287c4d0e();
    
    if ( !isdefined( bestcaches ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.scavprops.cachespawncount ; i++ )
    {
        self.cachedata[ i ] = spawnstruct();
        self.cachedata[ i ].cachenode = bestcaches[ i ];
        self.cachedata[ i ].collected = 0;
        
        if ( !isdefined( self.cachedata[ i ].cachenode ) )
        {
            self.cachedata = undefined;
            return false;
        }
        
        disablelootspawnpoint( self.cachedata[ i ].cachenode.index );
    }
    
    return true;
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x1bd4a29f, Offset: 0xf3a
// Size: 0x18d
function scav_onteamassigned()
{
    self.category = "scavenger";
    br_contract_manager::function_87e10a6e85d45d58( "scavenger" );
    
    foreach ( player in br_contract_manager::function_85e5094486ad4b57() )
    {
        player br_contract_manager::uiobjectivesetparameter( 0 );
    }
    
    time = level.scavprops.time;
    time = br_contract_manager::function_2f14979bf83bc3db( time );
    br_contract_manager::function_3fbbc67df36be7bb( time, 0 );
    
    if ( !isdefined( self.cachedata ) )
    {
        if ( !function_b9dbee94704376a1() )
        {
            /#
                logstring( "<dev string:x24>" );
            #/
            
            br_contract_manager::endcontract( undefined, undefined, undefined, undefined, "NoTargetError" );
            return;
        }
    }
    
    if ( !level.scavprops.var_6824d12a3f2b6146 )
    {
        function_ff06c9e4c3f27546( 0 );
    }
    else
    {
        for ( i = 0; i < level.scavprops.cachespawncount ; i++ )
        {
            function_ff06c9e4c3f27546( i );
        }
    }
    
    splashref = br_contract_manager::function_7c9586992cf68ed1( "br_scavenger_quest_start_team" );
    br_contract_manager::function_5c7e547ccc13711b( splashref );
    dialog_play( "scavenger_missionstart" );
    br_contract_manager::function_ba80ad6a1d946b85( 6, br_contract_manager::getquestindex( "scavenger" ) );
}

// Namespace br_scavenger_quest
// Params 2
// Checksum 0x2c7a7027, Offset: 0x10cf
// Size: 0x188
function function_e3c37db29ef37019( dangercircleorigin, var_1bdc861911b3625e )
{
    if ( self.var_b6c5eeeebd9383f5 )
    {
        return;
    }
    
    foreach ( cache in self.cachedata )
    {
        if ( !cache.collected && isdefined( cache.cacheentity ) )
        {
            if ( !br_circle_util::ispointindangercircle( cache.cacheentity.origin ) )
            {
                if ( !isdefined( cache.cacheentity.var_145290aab5fc9cca ) )
                {
                    cache.cacheentity.var_145290aab5fc9cca = gettime() + utility::function_4b74c15943231980( level.scavprops.var_7534fb724afd7b91 );
                }
                
                if ( gettime() >= cache.cacheentity.var_145290aab5fc9cca )
                {
                    self.var_b6c5eeeebd9383f5 = 1;
                    params = spawnstruct();
                    params.intvar = 0;
                    br_contract_manager::function_5c7e547ccc13711b( "br_scavenger_quest_timer_expired", params );
                    dialog_play( "mission_obj_circle_fail" );
                    thread function_9e6c6f406c9b58f2( 0, undefined, "Circle" );
                    return;
                }
            }
        }
    }
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x753b273f, Offset: 0x125f
// Size: 0x8, Type: bool
function function_67b529e129462fe2()
{
    return function_b9dbee94704376a1();
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x678c6432, Offset: 0x1270
// Size: 0xe6
function function_cbdeee842b6b0019( params )
{
    tablets = getlootscriptablearray( "brloot_scavenger_laptop" );
    
    foreach ( tablet in tablets )
    {
        cachedata = tablet.task.cachedata;
        
        if ( isdefined( cachedata ) )
        {
            for ( i = 0; i < cachedata.size ; i++ )
            {
                function_246fc1f7c4b50798( cachedata[ i ].cachenode.index );
            }
            
            cachedata = undefined;
        }
    }
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x6bee24c8, Offset: 0x135e
// Size: 0x4c
function function_30e1c8272073cbc1()
{
    contract = self;
    
    if ( isdefined( contract.cachedata[ contract.cachescollected ] ) )
    {
        return contract.cachedata[ contract.cachescollected ].origin;
    }
}

// Namespace br_scavenger_quest
// Params 2
// Checksum 0xef294153, Offset: 0x13b3
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    scav_playerremoved( victim );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x4936eb41, Offset: 0x13d9
// Size: 0x15
function function_22116566150b5d1( victim )
{
    scav_playerremoved( victim );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x89141e60, Offset: 0x13f6
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    scav_playerremoved( player );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x3bd0e7b1, Offset: 0x1413
// Size: 0x20
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        hidescavengerhudfromplayer( player );
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0xe1601a5, Offset: 0x143b
// Size: 0x20
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        function_94926b6633489f22( player );
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x6eb8fb3e, Offset: 0x1463
// Size: 0x69
function scav_playerremoved( player )
{
    if ( br_contract_manager::function_e1073238262d21f0( player ) )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        players = br_contract_manager::function_85e5094486ad4b57();
        
        if ( !br_quest_util::function_aa740d271fc528f6( players, filter ) )
        {
            function_9e6c6f406c9b58f2( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0xbc87384c, Offset: 0x14d4
// Size: 0xe3
function scav_onplayerteardown( player, oldteam, newteam )
{
    if ( oldteam == self.team )
    {
        if ( !br_quest_util::isteamvalid( oldteam, level.contractmanager.defaultfilter ) )
        {
            thread scav_oncancel( oldteam );
            return;
        }
        
        hidescavengerhudfromplayer( player );
        
        foreach ( cache in self.cachedata )
        {
            cache.cacheentity disablescriptableplayeruse( player );
        }
    }
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0xc6c96bbe, Offset: 0x15bf
// Size: 0xee
function scav_onplayerassimilated( player, oldteam, newteam )
{
    if ( !isdefined( self.cachedata ) )
    {
        return;
    }
    
    if ( newteam == self.team )
    {
        function_94926b6633489f22( player );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        player br_contract_manager::uiobjectivesetparameter( self.cachescollected );
        
        foreach ( cache in self.cachedata )
        {
            cache.cacheentity enablescriptableplayeruse( player );
        }
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0xe633d181, Offset: 0x16b5
// Size: 0x35
function scav_oncancel( team )
{
    if ( self.team == team )
    {
        function_9e6c6f406c9b58f2( 0, undefined, "Cancel" );
        dialog_play( "mission_gen_fail" );
    }
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0x1a6acb76, Offset: 0x16f2
// Size: 0x7a
function function_9e6c6f406c9b58f2( success, rewards, endstate )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    deletescavengerhud();
    wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    scav_cleanup();
    br_contract_manager::endcontract( success, rewards, undefined, undefined, endstate );
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x2a8ed35a, Offset: 0x1774
// Size: 0x166
function scav_cleanup()
{
    foreach ( cache in self.cachedata )
    {
        if ( !cache.collected && isdefined( cache.cacheentity ) )
        {
            if ( level.scavprops.var_49641b3ede16b76e > 0 )
            {
                foreach ( player in br_contract_manager::function_85e5094486ad4b57() )
                {
                    cache.cacheentity disablescriptableplayeruse( player );
                }
                
                cache.cacheentity utility::delaycallendon( level.scavprops.var_49641b3ede16b76e, "death", &delete );
                continue;
            }
            
            cache.cacheentity delete();
        }
    }
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0xfee6b38a, Offset: 0x18e2
// Size: 0x8f
function function_aca75e24223e6995()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    currtime = gettime();
    
    while ( currtime < self.missiontime )
    {
        wait ( self.missiontime - currtime ) / 1000;
        currtime = gettime();
        
        if ( !self.var_45913c2d587b1644 && currtime >= self.missiontime * 0.67 )
        {
            dialog_play( "scavenger_almosttimeout" );
            self.var_45913c2d587b1644 = 1;
        }
    }
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x774fa4c0, Offset: 0x1979
// Size: 0x4c
function function_3053c86ae9d409c6()
{
    params = spawnstruct();
    params.intvar = 0;
    br_contract_manager::function_5c7e547ccc13711b( "br_scavenger_quest_timer_expired", params );
    dialog_play( "scavenger_timeout", "dx_br_jpbm_" );
    thread function_9e6c6f406c9b58f2( 0, undefined, "Time" );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x4ef9c5a, Offset: 0x19cd
// Size: 0xd6
function function_ff06c9e4c3f27546( cacheindex )
{
    cache = self.cachedata[ cacheindex ].cachenode;
    self.cachedata[ cacheindex ].cacheentity = spawnscavengerlootcache( cache.origin, cache.angles );
    self.cachedata[ cacheindex ] br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current", undefined, self );
    objectiveid = self.cachedata[ cacheindex ].objectiveiconid;
    objective_removeallfrommask( objectiveid );
    objective_onentity( objectiveid, self.cachedata[ cacheindex ].cacheentity );
    objective_setzoffset( objectiveid, 65 );
    br_contract_manager::function_3f9bfc2528d612aa( objectiveid );
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x2caaccb3, Offset: 0x1aab
// Size: 0x94
function function_63157d9ba71faae8()
{
    if ( isdefined( level.var_a0d4b439e70b9564 ) )
    {
        foreach ( cache in level.var_a0d4b439e70b9564 )
        {
            cache.circletimeline = undefined;
        }
        
        level.var_a0d4b439e70b9564 = undefined;
    }
}

// Namespace br_scavenger_quest
// Params 7
// Checksum 0xd7083808, Offset: 0x1b47
// Size: 0x426
function function_a4c607c30e090cdc( nodearr, numnodes, searchorigin, minrange, maxrange, idealminrange, idealmaxrange )
{
    assert( isdefined( nodearr ) && nodearr.size > 0 );
    assert( numnodes > 0 );
    nodes = nodearr;
    bestnodes = [];
    var_b07fdd0d8193a57e = randomfloatrange( idealminrange, idealmaxrange );
    var_b5eefdf655fda772 = undefined;
    
    if ( !level.br_circle_disabled )
    {
        var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( searchorigin );
        var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    }
    
    bestdist = undefined;
    bestnode = undefined;
    bestidx = undefined;
    
    foreach ( idx, node in nodearr )
    {
        dist = abs( distance2d( searchorigin, node.origin ) - var_b07fdd0d8193a57e );
        
        if ( !function_2871bef7a2c4a57c( node, searchorigin, dist, minrange, maxrange, var_b5eefdf655fda772 ) )
        {
            continue;
        }
        
        if ( !isdefined( bestdist ) || dist < bestdist )
        {
            bestdist = dist;
            bestnode = node;
            bestidx = idx;
        }
    }
    
    if ( !isdefined( bestnode ) )
    {
        return;
    }
    
    bestnodes[ 0 ] = bestnode;
    bestnode.inuse = 1;
    disablelootspawnpoint( bestidx );
    
    if ( numnodes == 1 )
    {
        return bestnodes;
    }
    
    var_99de37bc0048da4c = function_f2cebf4619351557( searchorigin, bestnode.origin, numnodes );
    var_621b950480af4f38 = [];
    
    for ( i = 0; i < numnodes - 1 ; i++ )
    {
        index = i + 1;
        var_621b950480af4f38[ i ] = spawnstruct();
        var_621b950480af4f38[ i ].index = index;
        var_621b950480af4f38[ i ].point = var_99de37bc0048da4c[ index ];
        var_621b950480af4f38[ i ].bestdist = undefined;
        var_621b950480af4f38[ i ].bestnode = undefined;
        var_621b950480af4f38[ i ].nodeindex = undefined;
    }
    
    idealdisttolerance = 100;
    
    foreach ( var_669129c42b13e91b in var_621b950480af4f38 )
    {
        foreach ( idx, node in nodearr )
        {
            dist = distance2d( var_669129c42b13e91b.point, node.origin );
            
            if ( !function_2871bef7a2c4a57c( node, searchorigin, dist, minrange, maxrange, var_b5eefdf655fda772 ) )
            {
                continue;
            }
            
            if ( !isdefined( var_669129c42b13e91b.bestdist ) || dist < var_669129c42b13e91b.bestdist )
            {
                var_669129c42b13e91b.bestdist = dist;
                var_669129c42b13e91b.bestnode = node;
                var_669129c42b13e91b.nodeindex = idx;
                
                if ( dist <= idealdisttolerance )
                {
                    break;
                }
            }
        }
        
        if ( !( isdefined( var_669129c42b13e91b.index ) && isdefined( var_669129c42b13e91b.bestnode ) ) )
        {
            return;
        }
        
        bestnodes[ var_669129c42b13e91b.index ] = var_669129c42b13e91b.bestnode;
        var_669129c42b13e91b.bestnode.inuse = 1;
        disablelootspawnpoint( var_669129c42b13e91b.nodeindex );
    }
    
    return bestnodes;
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0xc0459a88, Offset: 0x1f76
// Size: 0x897
function function_4877939499134596( searchorigin, searchparams, var_a2fe50a5407e438b )
{
    cachelocations = [];
    nodes = var_a2fe50a5407e438b;
    var_b5eefdf655fda772 = undefined;
    drawdebug = getdvarint( @"hash_aa67bf32d8429170", 0 );
    tabletorigin = searchorigin;
    
    if ( !isdefined( nodes ) || nodes.size < searchparams.cachespawncount )
    {
        return;
    }
    
    if ( !level.br_circle_disabled )
    {
        var_baa7342c2419df11 = br_circle_util::function_472c93858e491e0a( searchorigin );
        var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( var_baa7342c2419df11 );
    }
    
    for ( i = 0; i < searchparams.cachespawncount ; i++ )
    {
        bestcache = undefined;
        var_9c4a00c8f4eae0c6 = searchparams.var_969fe1df0f49bfbb;
        
        if ( i > 0 && isdefined( var_b5eefdf655fda772 ) && !searchparams.var_6824d12a3f2b6146 )
        {
            var_b5eefdf655fda772 = br_circle_util::function_b880c0f9998fdd69( cachelocations[ i - 1 ].circletimeline );
        }
        
        foreach ( cache in nodes )
        {
            if ( cache.inuse )
            {
                continue;
            }
            
            dist = distance2d( cache.origin, searchorigin );
            
            if ( dist < searchparams.var_aad0bb484dd85e49 )
            {
                continue;
            }
            
            if ( function_9e34ff6f77321bef( cache.origin ) )
            {
                continue;
            }
            
            if ( br_bunker_utility::function_5f3fda39a064e862( cache.origin ) )
            {
                continue;
            }
            
            if ( locksandkeys::function_9894956c856a7904( cache.origin ) )
            {
                continue;
            }
            
            if ( !level.br_circle_disabled )
            {
                if ( !isdefined( cache.circletimeline ) )
                {
                    cache.circletimeline = br_circle_util::function_472c93858e491e0a( cache.origin );
                    
                    if ( !isdefined( level.var_a0d4b439e70b9564 ) )
                    {
                        level.var_a0d4b439e70b9564 = [];
                    }
                    
                    level.var_a0d4b439e70b9564[ level.var_a0d4b439e70b9564.size ] = cache;
                }
                
                var_4d410ddbe3d207be = br_circle_util::function_b880c0f9998fdd69( cache.circletimeline );
                
                if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 )
                {
                    continue;
                }
            }
            
            var_ac99ac222f6bbc72 = 0;
            
            if ( dist < searchparams.var_97050b1a3a69a1f6 )
            {
                if ( dist < searchparams.var_dfcae2ece12540c0 )
                {
                    var_ac99ac222f6bbc72 = searchparams.var_dfcae2ece12540c0 - dist;
                }
            }
            else
            {
                var_ac99ac222f6bbc72 = dist - searchparams.var_97050b1a3a69a1f6;
            }
            
            if ( !isdefined( searchparams.var_4c0fb0c208710b20 ) )
            {
                searchparams.var_4c0fb0c208710b20 = -1;
            }
            
            if ( i > 0 )
            {
                if ( i == 1 )
                {
                    direction = anglestoforward( vectortoangles( cachelocations[ i - 1 ].origin - tabletorigin ) );
                }
                else
                {
                    direction = anglestoforward( vectortoangles( cachelocations[ i - 1 ].origin - cachelocations[ i - 2 ].origin ) );
                }
                
                vector = vectornormalize( cache.origin - cachelocations[ i - 1 ].origin );
                dot = vectordot( direction, vector );
                
                if ( dot < searchparams.var_4c0fb0c208710b20 )
                {
                    /#
                        if ( drawdebug )
                        {
                            if ( !isdefined( level.debugheight ) )
                            {
                                level.debugheight = 5000;
                            }
                            
                            level thread debug_utility::drawline( cachelocations[ i - 1 ].origin + ( 0, 0, level.debugheight - cachelocations[ i - 1 ].origin[ 2 ] ), cache.origin + ( 0, 0, level.debugheight - cache.origin[ 2 ] ), 100000, ( 1, 0, 0 ) );
                            print3d( cachelocations[ 0 ].origin + ( 0, 0, level.debugheight - cachelocations[ 0 ].origin[ 2 ] ), "<dev string:x6b>" + self.id + "<dev string:x79>", ( 1, 0, 0 ), 1, 10, 100000 );
                            var_c6f709ad2955c60f = 1;
                            var_1e616c07bb17dc5b = 1;
                            var_62b37b55edbc88b4 = 0;
                        }
                    #/
                    
                    continue;
                }
            }
            
            if ( var_ac99ac222f6bbc72 < var_9c4a00c8f4eae0c6 )
            {
                if ( ai_fortress::function_fd527fe79c5d43e8( cache.origin, 0 ) )
                {
                    continue;
                }
                
                var_9c4a00c8f4eae0c6 = var_ac99ac222f6bbc72;
                bestcache = cache;
                
                if ( var_ac99ac222f6bbc72 <= 0 )
                {
                    break;
                }
            }
        }
        
        if ( !isdefined( bestcache ) )
        {
            if ( i > 1 && drawdebug )
            {
                if ( !isdefined( level.debugheight ) )
                {
                    level.debugheight = 5000;
                }
                
                level thread debug_utility::drawline( cachelocations[ i - 2 ].origin + ( 0, 0, level.debugheight - cachelocations[ i - 2 ].origin[ 2 ] ), cachelocations[ i - 1 ].origin + ( 0, 0, level.debugheight - cachelocations[ i - 1 ].origin[ 2 ] ), 100000, ( 1, 0, 0 ) );
                
                /#
                    print3d( cachelocations[ i - 1 ].origin + ( 0, 0, level.debugheight - cachelocations[ i - 1 ].origin[ 2 ] ), "<dev string:x6b>" + self.id + "<dev string:x89>" + i + 1, ( 1, 0, 0 ), 1, 10, 100000 );
                #/
            }
            
            return;
        }
        
        bestcache.inuse = 1;
        cachelocations[ i ] = bestcache;
        searchorigin = bestcache.origin;
    }
    
    if ( drawdebug )
    {
        if ( !isdefined( var_c6f709ad2955c60f ) )
        {
            var_c6f709ad2955c60f = 0;
        }
        
        if ( !isdefined( var_1e616c07bb17dc5b ) )
        {
            var_1e616c07bb17dc5b = 1;
        }
        
        if ( !isdefined( var_62b37b55edbc88b4 ) )
        {
            var_62b37b55edbc88b4 = 0;
        }
        
        level thread debug_utility::drawline( tabletorigin + ( 0, 0, level.debugheight - tabletorigin[ 2 ] ), cachelocations[ 0 ].origin + ( 0, 0, level.debugheight - cachelocations[ 0 ].origin[ 2 ] ), 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
        level thread debug_utility::drawsphere( tabletorigin, 50, 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
        level thread debug_utility::drawline( tabletorigin, tabletorigin + ( 0, 0, level.debugheight - tabletorigin[ 2 ] ), 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
        
        /#
            print3d( tabletorigin + ( 0, 0, level.debugheight - tabletorigin[ 2 ] ), "<dev string:x6b>" + self.id + "<dev string:x98>", ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ), 1, 10, 100000 );
        #/
        
        for ( i = 0; i < cachelocations.size ; i++ )
        {
            if ( i > 0 )
            {
                level thread debug_utility::drawline( cachelocations[ i - 1 ].origin + ( 0, 0, level.debugheight - cachelocations[ i - 1 ].origin[ 2 ] ), cachelocations[ i ].origin + ( 0, 0, level.debugheight - cachelocations[ i ].origin[ 2 ] ), 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
            }
            
            level thread debug_utility::drawsphere( cachelocations[ i ].origin, 50, 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
            level thread debug_utility::drawline( cachelocations[ i ].origin, cachelocations[ i ].origin + ( 0, 0, level.debugheight - cachelocations[ i ].origin[ 2 ] ), 100000, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ) );
            
            /#
                print3d( cachelocations[ i ].origin + ( 0, 0, level.debugheight - cachelocations[ i ].origin[ 2 ] ), "<dev string:x6b>" + self.id + "<dev string:x89>" + i + 1, ( var_c6f709ad2955c60f, var_1e616c07bb17dc5b, var_62b37b55edbc88b4 ), 1, 10, 100000 );
            #/
        }
    }
    
    return cachelocations;
}

// Namespace br_scavenger_quest
// Params 6
// Checksum 0xe1f258b0, Offset: 0x2816
// Size: 0x113, Type: bool
function function_2871bef7a2c4a57c( node, origin, dist, minrange, maxrange, var_b5eefdf655fda772 )
{
    if ( node.inuse )
    {
        return false;
    }
    
    if ( dist < minrange || dist > maxrange )
    {
        return false;
    }
    
    if ( ai_fortress::function_f45832ffece5dbb( node.origin ) )
    {
        return false;
    }
    
    if ( function_9e34ff6f77321bef( node.origin ) )
    {
        return false;
    }
    
    if ( br_bunker_utility::function_5f3fda39a064e862( node.origin ) )
    {
        return false;
    }
    
    if ( locksandkeys::function_9894956c856a7904( node.origin ) )
    {
        return false;
    }
    
    if ( !level.br_circle_disabled )
    {
        circletimeline = br_circle_util::function_472c93858e491e0a( node.origin );
        var_4d410ddbe3d207be = br_circle_util::function_b880c0f9998fdd69( circletimeline );
        
        if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 )
        {
            return false;
        }
        
        traveltime = dist / 190;
        
        if ( var_4d410ddbe3d207be < var_b5eefdf655fda772 + traveltime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0xd64c7cf6, Offset: 0x2932
// Size: 0xa7, Type: bool
function function_9e34ff6f77321bef( v_origin )
{
    if ( isdefined( level.var_38e0cfd2f954b68f ) && level.var_38e0cfd2f954b68f.size > 0 )
    {
        foreach ( exclusionvolume in level.var_38e0cfd2f954b68f )
        {
            if ( ispointinvolume( v_origin, exclusionvolume ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0x2ab6d4dc, Offset: 0x29e2
// Size: 0x124
function function_f2cebf4619351557( originpoint, point1, numpoints )
{
    points = [];
    points[ 0 ] = point1;
    radius = distance2d( originpoint, point1 );
    rotangle = 360 / numpoints;
    var_b8f0a184a4010b3c = [];
    var_b8f0a184a4010b3c[ 0 ] = ( point1[ 0 ] - originpoint[ 0 ], point1[ 1 ] - originpoint[ 1 ], 0 );
    
    for ( i = 1; i < numpoints ; i++ )
    {
        cpoint = points[ i - 1 ];
        xtemp = cpoint[ 0 ] - originpoint[ 0 ];
        ytemp = cpoint[ 1 ] - originpoint[ 1 ];
        x = xtemp * cos( rotangle ) - ytemp * sin( rotangle );
        y = ytemp * cos( rotangle ) + xtemp * sin( rotangle );
        var_b8f0a184a4010b3c[ var_b8f0a184a4010b3c.size ] = ( x, y, 0 );
        x += originpoint[ 0 ];
        y += originpoint[ 1 ];
        points[ points.size ] = ( x, y, 0 );
    }
    
    return points;
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0x3b4f7822, Offset: 0x2b0f
// Size: 0x159
function function_4a6cfc43287c4d0e()
{
    if ( utility::issharedfuncdefined( #"hash_c7f590db1cbb7497", #"hash_884b17ee1e68daca" ) )
    {
        locations = utility::callsharedfunc( #"hash_c7f590db1cbb7497", #"hash_884b17ee1e68daca" );
    }
    else
    {
        locations = getunusedlootcachepoints( self.tablet.origin, level.scavprops.var_969fe1df0f49bfbb, level.scavprops.var_aad0bb484dd85e49, 1 );
    }
    
    if ( locations.size <= level.scavprops.cachespawncount )
    {
        return;
    }
    
    if ( level.scavprops.var_816fe3689f19bf37 )
    {
        return function_a4c607c30e090cdc( locations, level.scavprops.cachespawncount, self.tablet.origin, level.scavprops.var_aad0bb484dd85e49, level.scavprops.var_969fe1df0f49bfbb, level.scavprops.var_dfcae2ece12540c0, level.scavprops.var_97050b1a3a69a1f6 );
    }
    
    return function_4877939499134596( self.tablet.origin, level.scavprops, locations );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0xec50cce3, Offset: 0x2c70
// Size: 0xa3
function function_94926b6633489f22( player )
{
    foreach ( cacheobj in self.cachedata )
    {
        if ( isdefined( cacheobj.objectiveiconid ) )
        {
            cacheobj br_contract_manager::showquestobjicontoplayer( player );
        }
    }
    
    player br_contract_manager::uiobjectiveshow( "scavenger" );
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x8b34262d, Offset: 0x2d1b
// Size: 0x9e
function hidescavengerhudfromplayer( player )
{
    foreach ( cacheobj in self.cachedata )
    {
        if ( isdefined( cacheobj.objectiveiconid ) )
        {
            cacheobj br_contract_manager::hidequestobjiconfromplayer( player );
        }
    }
    
    player br_contract_manager::uiobjectivehide();
}

// Namespace br_scavenger_quest
// Params 0
// Checksum 0xe59fc9ff, Offset: 0x2dc1
// Size: 0xfa
function deletescavengerhud()
{
    foreach ( player in br_contract_manager::function_85e5094486ad4b57() )
    {
        hidescavengerhudfromplayer( player );
    }
    
    foreach ( cacheobj in self.cachedata )
    {
        if ( cacheobj br_contract_manager::checkforactiveobjicon() )
        {
            cacheobj br_contract_manager::deletequestobjicon();
        }
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0xfd91c2f5, Offset: 0x2ec3
// Size: 0x3f
function function_c0e40cd3d5a09287( volume )
{
    if ( !isdefined( level.var_38e0cfd2f954b68f ) )
    {
        level.var_38e0cfd2f954b68f = [];
    }
    
    if ( isdefined( volume ) )
    {
        level.var_38e0cfd2f954b68f[ level.var_38e0cfd2f954b68f.size ] = volume;
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x269882a9, Offset: 0x2f0a
// Size: 0x42
function function_d61b29ded0232e9c( volumes )
{
    if ( !isdefined( level.var_38e0cfd2f954b68f ) )
    {
        level.var_38e0cfd2f954b68f = [];
    }
    
    if ( volumes.size > 0 )
    {
        level.var_38e0cfd2f954b68f = arraycombine( level.var_38e0cfd2f954b68f, volumes );
    }
}

// Namespace br_scavenger_quest
// Params 2
// Checksum 0x9eaa02ca, Offset: 0x2f54
// Size: 0x7d
function spawnscavengerlootcache( inorigin, inangles )
{
    cacheentity = spawn( "script_model", inorigin );
    cacheentity.angles = inangles;
    cacheentity setmodel( "military_loot_crate_01_br_scavenger_01" );
    cacheentity setscriptablepartstate( "body", "scavenger_closed" );
    cacheentity common_cache::function_e35d5e97bd22367( &scavengerlootcacheused );
    cacheentity.task = self;
    thread function_4db08f00bd40d49b( cacheentity );
    return cacheentity;
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x5ec0a6d0, Offset: 0x2fda
// Size: 0x10d
function function_4db08f00bd40d49b( cacheentity )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    cacheentity endon( #"death" );
    
    while ( true )
    {
        var_88b519152b97f56a = undefined;
        
        foreach ( player in level.players )
        {
            if ( br_contract_manager::function_e1073238262d21f0( player ) )
            {
                if ( !isdefined( var_88b519152b97f56a ) )
                {
                    var_88b519152b97f56a = player;
                }
                
                cacheentity enablescriptableplayeruse( player );
                continue;
            }
            
            cacheentity disablescriptableplayeruse( player );
        }
        
        assert( isdefined( var_88b519152b97f56a ), "<dev string:xa8>" );
        
        if ( !var_88b519152b97f56a )
        {
            break;
        }
        
        cacheentity setotherent( var_88b519152b97f56a );
        var_88b519152b97f56a waittill( #"disconnect" );
    }
}

// Namespace br_scavenger_quest
// Params 6
// Checksum 0xf3073c39, Offset: 0x30ef
// Size: 0x52f
function scavengerlootcacheused( instance, part, state, player, bautouse, usestring )
{
    if ( player utility::callsharedfunc( #"gametype", #"hash_673db8bb5562ee19", instance ) )
    {
        return;
    }
    
    assert( part == "<dev string:xdc>" );
    
    if ( isdefined( instance.entity.task ) && isdefined( player ) && state == "scavenger_closed" )
    {
        task = instance.entity.task;
        
        if ( player.team != task.team )
        {
            /#
                player iprintlnbold( "<dev string:xe1>" );
            #/
            
            return;
        }
        
        instance setscriptablepartstate( "body", "scavenger_opening" );
        var_e80d80736b232376 = getdvarint( @"hash_28b9017071772839", 30 );
        instance.entity utility::delaycallendon( var_e80d80736b232376, "death_or_disconnect", &delete );
        
        if ( !isdefined( task.cachescollected ) || task.cachescollected == 0 )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_scav_one" );
        }
        else if ( task.cachescollected == 1 )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_scav_two" );
        }
        else
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_scav_three" );
        }
        
        if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
        {
            common_cache::fillcontentsfromlist( instance, var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount );
        }
        
        common_cache::opencache( instance, player, undefined, 1 );
        
        if ( !isdefined( task ) || task.ended )
        {
            return;
        }
        
        task.cachescollected++;
        
        if ( task.cachescollected < level.scavprops.cachespawncount )
        {
            task br_contract_manager::function_ba80ad6a1d946b85( 7, br_contract_manager::getquestindex( "scavenger" ), player );
            
            if ( level.scavprops.var_ce9802e8722a9e3 )
            {
                time = task br_contract_manager::function_7f2bcd04a826b94e( level.scavprops.timebonus );
                task br_contract_manager::function_3a67c27d33cb206c( time );
            }
            
            var_fab5f44dc4cb40c9 = undefined;
            
            if ( task.cachescollected == 1 )
            {
                task dialog_play( "scavenger_onesecured" );
            }
            else if ( task.cachescollected == 2 )
            {
                task dialog_play( "scavenger_twosecured" );
            }
            
            foreach ( cacheobj in task.cachedata )
            {
                if ( cacheobj.cacheentity == instance.entity )
                {
                    var_fab5f44dc4cb40c9 = cacheobj;
                }
            }
            
            assert( isdefined( var_fab5f44dc4cb40c9 ) );
            var_fab5f44dc4cb40c9.collected = 1;
            var_fab5f44dc4cb40c9 br_contract_manager::deletequestobjicon();
            var_fab5f44dc4cb40c9.objectiveiconid = undefined;
            
            if ( !level.scavprops.var_6824d12a3f2b6146 )
            {
                task function_ff06c9e4c3f27546( task.cachescollected );
            }
        }
        else
        {
            task br_contract_manager::function_ba80ad6a1d946b85( 8, br_contract_manager::getquestindex( "scavenger" ), player );
            task dialog_play( "scavenger_missioncomplete" );
            br_contract_manager::function_7864d8f2e3f3454b( task, instance );
        }
        
        players = task br_contract_manager::function_85e5094486ad4b57();
        
        foreach ( p in players )
        {
            p br_contract_manager::uiobjectivesetparameter( task.cachescollected );
        }
        
        task br_contract_manager::function_9fe564137142e8ee( task.cachescollected );
        
        if ( !isdefined( instance.origin ) )
        {
            script::demoforcesre( "IW9-638849: player.origin = " + player.origin + ", cacheState = " + state );
        }
        
        level notify( "lootcache_opened_kill_callout" + instance.origin );
        
        foreach ( p in players )
        {
            p notify( #"hash_fe8368d98cacf961" );
        }
    }
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0x20c196ef, Offset: 0x3626
// Size: 0x93
function function_9e065e3462c14dfd( contract, instance, team )
{
    rewards = contract br_contract_manager::function_7d7e225a8f9c9222( "scavenger", instance );
    
    if ( !br_public::istutorial() )
    {
        if ( isdefined( rewards[ "plunder" ] ) )
        {
            splashref = contract br_contract_manager::function_7c9586992cf68ed1( "br_scavenger_quest_complete" );
            contract br_contract_manager::function_1f816e3c3465df7e( splashref, br_contract_manager::function_e01c7810f3c75f0b( "scavenger" ), rewards[ "plunder" ] );
        }
    }
    
    contract thread function_9e6c6f406c9b58f2( 1, rewards, "Win" );
}

// Namespace br_scavenger_quest
// Params 3
// Checksum 0xf56ee530, Offset: 0x36c1
// Size: 0x36e
function function_a11543dab390af1a( player, delay, var_777699a0e3e55aad )
{
    playerorigin = player.origin;
    playerangles = player.angles;
    playerteam = player.team;
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( player ) )
    {
        playerorigin = player.origin;
        playerangles = player.angles;
        playerteam = player.team;
    }
    
    forward = anglestoforward( playerangles );
    rotationangle = randomfloatrange( 0, 360 );
    offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle ) + ( 0, 200, 0 );
    drop_point = isnavmeshloaded() ? getclosestpointonnavmesh( playerorigin + offset ) : playerorigin + offset;
    crate = airdrop::dropcrate( undefined, playerteam, "legendary_supply_drop", drop_point + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), drop_point );
    crate.source = "scavenger_quest";
    crate.skipminimapicon = 1;
    script::demoforcesre( "GetScriptCacheContents does not work with the common item system. Create script key to spawn items if needed." );
    var_c9bf68652d310af9 = [];
    var_1dcf0fb0650e14c7 = [];
    var_763f63e36ae7892d = [];
    crate.item_rewards = arraycombine( var_c9bf68652d310af9, var_1dcf0fb0650e14c7, var_763f63e36ae7892d );
    
    if ( level.maxteamsize == 1 && getdvarint( @"hash_eeda2ab8e7d694fb", 1 ) )
    {
        for ( i = 0; i < crate.item_rewards.size ; i++ )
        {
            if ( crate.item_rewards[ i ] == "brloot_gulag_token" )
            {
                crate.item_rewards[ i ] = "brloot_redeploy_token";
            }
        }
    }
    
    level.vipprops.var_3d60cfe23445889c += 1;
    
    if ( level.vipprops.var_3d60cfe23445889c >= level.vipprops.var_f45c29c0ca894ec8 )
    {
        level.vipprops.var_3d60cfe23445889c = 0;
    }
    
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        fadestart = getdvarint( @"hash_3f485fe18a08de25", 4921 );
        fadeend = getdvarint( @"hash_18160829d60f2e3c", 5906 );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, "ui_map_icon_supply_drop_yellow" );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, &"mp_br_ingame/reward_icon_name_vip" );
        function_ac9886e0e2860e18( id, fadestart, fadeend );
        function_44a344c68a68f28d( id, 1 );
        crate.scriptedobjid = id;
        level.brgametype thread br_vip_quest::function_220cf16950d590c7( crate );
        
        if ( !level.br_circle_disabled )
        {
            crate thread br_vip_quest::function_65fa856fb85f5bb8( drop_point );
        }
    }
}

// Namespace br_scavenger_quest
// Params 1
// Checksum 0x1214fdde, Offset: 0x3a37
// Size: 0x1e9
function function_874e5feeb8c44122( player )
{
    var_81fbbdcd6859c57c = [];
    
    if ( isdefined( self.item_rewards ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        
        foreach ( item in self.item_rewards )
        {
            if ( br_pickups::ispickupstackable( item ) )
            {
                var_81fbbdcd6859c57c[ item ] = !isdefined( var_81fbbdcd6859c57c[ item ] ) ? level.br_pickups.counts[ item ] : var_81fbbdcd6859c57c[ item ] + level.br_pickups.counts[ item ];
                
                if ( var_81fbbdcd6859c57c[ item ] == level.br_pickups.maxcounts[ item ] )
                {
                    common_item::items_spawnitemfromscriptable( item, var_81fbbdcd6859c57c[ item ], spawnoptions );
                    var_81fbbdcd6859c57c[ item ] = 0;
                }
                
                continue;
            }
            
            if ( namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( item ) )
            {
                common_item::items_spawnitemfromscriptable( item, 1, spawnoptions );
            }
        }
        
        foreach ( key, value in var_81fbbdcd6859c57c )
        {
            if ( value > 0 )
            {
                common_item::items_spawnitemfromscriptable( key, value, spawnoptions );
            }
        }
    }
    
    player thread points::doscoreevent( #"br_cacheopen_epic" );
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

// Namespace br_scavenger_quest
// Params 2
// Checksum 0x3120a81f, Offset: 0x3c28
// Size: 0x3a
function dialog_play( dialog, prefixoverride )
{
    players = br_contract_manager::function_85e5094486ad4b57();
    br_public::brleaderdialog( dialog, 1, players, undefined, 2, undefined, prefixoverride );
}

