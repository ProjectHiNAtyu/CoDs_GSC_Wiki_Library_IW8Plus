// script_68fc38d757ac68d3  (hash_68fc38d757ac68d3.gscc) (size: 16265 Bytes / 0x3f89 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a23f5ab (975435179)
// size ...... 16265 (0x3f89)
// includes .. 20  (offset: 0x3b9d)
// strings ... 46  (offset: 0x3c3d)
// dev strs .. 1   (offset: 0x3f7d)
// exports ... 49  (offset: 0x2741)
// cseg ...... 0x48d + 0x22b4 (0x2741)
// imports ... 104 (offset: 0x2ee9)
// animtree1 . 0   (offset: 0x3f89)
// animtree2 . 0   (offset: 0x3f89)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\dmz_poi;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace namespace_84d989e8789e6a05;

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x76c801da, Offset: 0x4ab
// Size: 0x17a
function dmztask_getspawndata( data )
{
    if ( getdvarint( @"hash_191305ad3d7422a8", 1 ) <= 0 )
    {
        return;
    }
    
    function_6e45033f4a7ba3e6();
    validnodes = [];
    phones = getentitylessscriptablearray( "brloot_activity_starter_hacker_phone" );
    
    foreach ( phone in phones )
    {
        origin = phone.origin;
        poiname = poi::poi_findpoioriginisin( origin );
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", origin, poiname );
        
        if ( isdefined( subarea ) && !br_dmz_radiation::function_704454416dce7454( phone.origin ) )
        {
            origin = phone.origin;
            poiname = poi::poi_findpoioriginisin( origin );
            subarea = dmz_poi::subarea_findfromorigin( origin, poiname );
            struct = spawnstruct();
            struct.origin = origin;
            struct.script_poi = poiname;
            validnodes[ validnodes.size ] = struct;
        }
    }
    
    activity_manager::function_f61a1f535aab4194( data, &function_7cc324c7c55e83a5, validnodes );
}

// Namespace namespace_84d989e8789e6a05
// Params 0
// Checksum 0x931b5f45, Offset: 0x62d
// Size: 0x112
function function_6e45033f4a7ba3e6()
{
    level.hackerphone = spawnstruct();
    level.hackerphone.var_1f893e68115f77b1 = getdvarint( @"hash_702ebf4ef0c6f88a", 3 );
    level.hackerphone.var_aa043f8b416d469a = getdvarint( @"hash_46511004c7948df", 60 );
    level.hackerphone.var_a349e2b8d2c3c110 = getdvarint( @"hash_c767586e70f5452f", 20 );
    level.hackerphone.var_1bc84b4e41e8e325 = getdvarint( @"hash_330cbe811cd82406", 400 );
    level.hackerphone.var_44015290e6d36c32 = getdvarint( @"hash_3326ba811fa9de92", 0 );
    level.hackerphone.payoutcount = int( level.hackerphone.var_1bc84b4e41e8e325 / level.hackerphone.var_a349e2b8d2c3c110 );
    callback::add( #"player_assimilated", &function_2550892140fff0c1 );
}

/#

    // Namespace namespace_84d989e8789e6a05
    // Params 0
    // Checksum 0x7796e41, Offset: 0x747
    // Size: 0x7, Type: dev
    function function_746bdfc760ec9b18()
    {
        return [];
    }

#/

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x7b4e6928, Offset: 0x756
// Size: 0xf1
function function_7cc324c7c55e83a5( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_ee2d935a9137174a;
    task.funcs[ "onTeamStart" ] = &function_d946587d2d396633;
    task.funcs[ "onPlayerJoined" ] = &function_68efdfc8c45fe078;
    task.funcs[ "onPlayerRemoved" ] = &function_54c79942ce3ba8d3;
    task.funcs[ "onTeamAssigned" ] = &function_bfd550bf36fa5919;
    task.funcs[ "onCancel" ] = &function_118e552e8ecdbdd2;
    task.ref = "dmz_hacker_phone";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    return task;
}

// Namespace namespace_84d989e8789e6a05
// Params 0
// Checksum 0x4c9699ac, Offset: 0x850
// Size: 0x2a
function function_ee2d935a9137174a()
{
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 25 ) );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x88ddd50c, Offset: 0x882
// Size: 0xc
function function_d946587d2d396633( teamname )
{
    
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xdcd3753, Offset: 0x896
// Size: 0x73
function function_68efdfc8c45fe078( player )
{
    player.canhackcontracts = 1;
    player setclientomnvar( "ui_br_hacker_phone_state", 2 );
    objidpoolmanager::objective_playermask_addshowplayer( self.icon, player );
    player br_contract_manager::uiobjectivesetparameter( self.var_5fff89b8a8a5275c, level.hackerphone.var_1f893e68115f77b1 );
    function_8ec26ff4f54e72b4( player, player.team );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xca01d80d, Offset: 0x911
// Size: 0x5b
function function_54c79942ce3ba8d3( player )
{
    player.canhackcontracts = undefined;
    player.var_d7c6c2a492dda544 = undefined;
    player setclientomnvar( "ui_br_hacker_phone_state", 0 );
    objidpoolmanager::objective_playermask_hidefrom( self.icon, player );
    player setclientomnvar( "ui_br_hacked_phones_data1", 0 );
    player setclientomnvar( "ui_br_hacked_phones_data2", 0 );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x4f8ab790, Offset: 0x974
// Size: 0x1c
function function_118e552e8ecdbdd2( teamname )
{
    function_9d013ddfe74d590b( teamname );
    function_6eeb399814bdf09d();
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x1fcfe0d0, Offset: 0x998
// Size: 0x209
function function_bfd550bf36fa5919( teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.var_5fff89b8a8a5275c = 0;
    self.var_c7c39713542d5360 = level.hackerphone.var_1f893e68115f77b1;
    self.payoutvalue = function_a4f7ac145fde1046( teamname );
    self.hackedinstances = [];
    
    if ( !isdefined( level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] ) )
    {
        level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] = 0;
    }
    
    if ( !isdefined( level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] ) )
    {
        level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] = 0;
    }
    
    if ( !isdefined( level.teamdata[ teamname ][ "hackedContractsData1" ] ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData1" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ teamname ][ "hackedContractsData2" ] ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData2" ] = [];
    }
    
    function_c422f6d43065595b( teamname );
    function_3130382b0ca705( teamname );
    dmz_task_utils::task_showsplashtoteam( "dmz_hacker_phone_accept", teamname );
    thread function_20d8ac31219936dd( teamname );
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.canhackcontracts = 1;
        player setclientomnvar( "ui_br_hacker_phone_state", 2 );
        activity_manager::function_9658fe6aabcb4b6( player, 1 );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hacker_phone_start", teamname, 2 );
}

// Namespace namespace_84d989e8789e6a05
// Params 1, eflags: 0x4
// Checksum 0x10543284, Offset: 0xba9
// Size: 0x178
function private function_6eeb399814bdf09d( teamname )
{
    if ( isdefined( teamname ) )
    {
        function_9d013ddfe74d590b( teamname );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hacker_phone_success", teamname, 1.5 );
        dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
        playersonteam = teams::getteamdata( teamname, "players" );
        br_gametype_dmz::showdmzsplash( "dmz_hacker_phone_complete", playersonteam, undefined, level.hackerphone.payoutcount );
        level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] = level.hackerphone.payoutcount;
        function_ca6388987d86425c( teamname );
        playersonteam = teams::getteamdata( teamname, "players" );
        
        foreach ( player in playersonteam )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.var_d7c6c2a492dda544 = 1;
        }
        
        if ( !function_4b54e650ee565ea3( teamname ) )
        {
            wait 5.5;
        }
        
        thread function_c8a931512c5f1e4f( teamname );
    }
    
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xf14f300c, Offset: 0xd29
// Size: 0x72, Type: bool
function function_eb9cb24f743cd519( node )
{
    origin = node.origin;
    poiname = poi::poi_findpoioriginisin( origin );
    subarea = dmz_poi::subarea_findfromorigin( origin, poiname );
    return isdefined( subarea ) && !br_dmz_radiation::function_704454416dce7454( origin ) && !ai_fortress::function_5428359c3c1916ac( origin ) && !locksandkeys::function_9894956c856a7904( origin );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x4b6a427d, Offset: 0xda4
// Size: 0x20, Type: bool
function function_4b54e650ee565ea3( teamname )
{
    return level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] > 0;
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x2d535a01, Offset: 0xdcd
// Size: 0x129
function function_9d013ddfe74d590b( teamname )
{
    dmz_task_utils::function_3ff46488beb193c7();
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( isdefined( player ) )
        {
            player.canhackcontracts = undefined;
            player setclientomnvar( "ui_br_hacker_phone_state", 0 );
        }
    }
    
    foreach ( taskinstance in self.hackedinstances )
    {
        function_149d3f04ae11e052( taskinstance, teamname );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x821b97a6, Offset: 0xefe
// Size: 0x6d
function function_4aad07fa1664ce24( var_6a5099486f6f578b, useplayer )
{
    self endon( #"death_or_disconnect" );
    
    if ( function_41641244efbe022a( var_6a5099486f6f578b.instance, useplayer.team ) )
    {
        useplayer hud_message::showerrormessage( %"mp_br_ingame/hacker_phone_already_hacked" );
        return;
    }
    
    useplayer dmz_task_utils::function_ce0c366b96d23996( "intel_pickup_phone_alt", 11 );
    function_952fa348a95a0c83( var_6a5099486f6f578b, useplayer );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x32ff1849, Offset: 0xf73
// Size: 0x239
function function_952fa348a95a0c83( var_6a5099486f6f578b, useplayer )
{
    if ( function_41641244efbe022a( var_6a5099486f6f578b.instance, useplayer.team ) )
    {
        useplayer hud_message::showerrormessage( %"mp_br_ingame/hacker_phone_already_hacked" );
        return;
    }
    
    task = activity_manager::function_a7c6aab0d0a8ba71( useplayer );
    
    if ( !isdefined( task ) )
    {
        return;
    }
    
    task function_be6cdb296db11a8f( var_6a5099486f6f578b.instance, useplayer.team );
    task.hackedinstances[ task.hackedinstances.size ] = var_6a5099486f6f578b.instance;
    task.var_5fff89b8a8a5275c++;
    task.var_c7c39713542d5360 = level.hackerphone.var_1f893e68115f77b1 - task.var_5fff89b8a8a5275c;
    task function_3130382b0ca705( useplayer.team );
    function_d1aad829093cf458( var_6a5099486f6f578b.instance, useplayer );
    
    if ( task.var_317cb22c817030c5 == var_6a5099486f6f578b.instance )
    {
        task notify( #"marked_contract_hacked" );
        task function_c422f6d43065595b( useplayer.team, useplayer );
    }
    
    task.var_d0108c7e132f1bac = 0;
    playersonteam = teams::getteamdata( useplayer.team, "players" );
    
    foreach ( player in playersonteam )
    {
        player thread points::doscoreevent( #"br_mission_hacker_phone_contract_hacked" );
    }
    
    if ( task function_6d89f39dafcc5bf5() )
    {
        task function_6eeb399814bdf09d( useplayer.team );
        return;
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hacker_phone_hacked", useplayer.team, 1 );
}

// Namespace namespace_84d989e8789e6a05
// Params 0
// Checksum 0xc39b0806, Offset: 0x11b4
// Size: 0x32, Type: bool
function function_6d89f39dafcc5bf5()
{
    if ( self.var_5fff89b8a8a5275c >= level.hackerphone.var_1f893e68115f77b1 )
    {
        self notify( #"hash_dca110638a743102" );
        return true;
    }
    
    return false;
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xb34fe967, Offset: 0x11ef
// Size: 0x88
function function_20d8ac31219936dd( teamname )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    hackablecontracts = level.var_f9ba6d6273c5cc67.var_9433e6119f67c877;
    
    while ( hackablecontracts.size >= self.var_c7c39713542d5360 )
    {
        hackablecontracts = level.var_f9ba6d6273c5cc67.var_9433e6119f67c877;
        hackablecontracts = arrayremove( hackablecontracts, self.hackedinstances );
        wait 1;
    }
    
    function_118e552e8ecdbdd2( teamname );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xfe9525a, Offset: 0x127f
// Size: 0x5f
function function_be6cdb296db11a8f( scriptableinstance, teamname )
{
    if ( !isdefined( scriptableinstance.var_7379b55339275347 ) )
    {
        scriptableinstance.var_7379b55339275347 = [];
    }
    
    scriptableinstance.var_7379b55339275347[ scriptableinstance.var_7379b55339275347.size ] = teamname;
    function_7d7f222935c0b5dd( teamname, scriptableinstance.index );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x4860de10, Offset: 0x12e6
// Size: 0x3c, Type: bool
function function_41641244efbe022a( scriptableinstance, teamname )
{
    if ( isdefined( scriptableinstance.var_7379b55339275347 ) )
    {
        if ( arraycontains( scriptableinstance.var_7379b55339275347, teamname ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xab8aab28, Offset: 0x132b
// Size: 0x6a
function function_149d3f04ae11e052( scriptableinstance, teamname )
{
    if ( isdefined( scriptableinstance.var_7379b55339275347 ) && arraycontains( scriptableinstance.var_7379b55339275347, teamname ) )
    {
        scriptableinstance.var_7379b55339275347 = arrayremove( scriptableinstance.var_7379b55339275347, teamname );
        function_b582aa823c6bb0f5( teamname, scriptableinstance.index );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x16d6431c, Offset: 0x139d
// Size: 0xb1
function function_3130382b0ca705( teamname )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        player br_contract_manager::uiobjectivesetparameter( self.var_5fff89b8a8a5275c, level.hackerphone.var_1f893e68115f77b1 );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 0
// Checksum 0x3f1bcd1e, Offset: 0x1456
// Size: 0x99
function function_8b0a22d69c3133ca()
{
    if ( !isdefined( self.team ) )
    {
        return;
    }
    
    teammates = teams::getteamdata( self.team, "players" );
    var_f4323195d896ce2e = function_a4f7ac145fde1046( self.team );
    multipliedcash = int( ceil( dmz_task_utils::function_801915892ff1d63e( self, dmz_task_utils::function_5fad6b062ca5ce96( teammates, var_f4323195d896ce2e ) ) ) );
    var_a77d2a27deee2430 = multipliedcash * level.hackerphone.payoutcount;
    self setclientomnvar( "ui_br_hacker_phone_potential_cash_value", var_a77d2a27deee2430 );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xe3e80270, Offset: 0x14f7
// Size: 0x9e
function function_a4f7ac145fde1046( teamname )
{
    var_f4323195d896ce2e = level.hackerphone.var_aa043f8b416d469a;
    
    if ( level.hackerphone.var_44015290e6d36c32 )
    {
        var_58714c97368a2ed4 = getdvar( @"hash_a38ed422cbf98056", "60 45 30 15" );
        payoutvalues = strtok( var_58714c97368a2ed4, " " );
        teamcount = int( min( teams::getteamcount( teamname ), payoutvalues.size ) );
        var_f4323195d896ce2e = payoutvalues[ teamcount - 1 ];
    }
    
    return int( var_f4323195d896ce2e );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xd49d5bc8, Offset: 0x159e
// Size: 0x28
function function_97d54a99cb48d946( teamname )
{
    return level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] * self.payoutvalue;
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x47356793, Offset: 0x15cf
// Size: 0x93
function function_c8a931512c5f1e4f( teamname )
{
    level endon( #"game_ended" );
    lootid = level.br_pickups.var_2e379e316c36bf4a[ "brloot_payment_hacker_phone" ];
    level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ]++;
    level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] = level.hackerphone.payoutcount;
    function_70289ceafd152a5f( teamname, lootid );
    thread function_e813ec6b135861c9( teamname, lootid );
    thread function_55acef85dcea4c6c( teamname );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xb9acddd6, Offset: 0x166a
// Size: 0x78
function function_e813ec6b135861c9( teamname, lootid )
{
    level notify( "monitor_payout_" + teamname );
    level endon( "monitor_payout_" + teamname );
    level endon( #"game_ended" );
    thread function_b55471045e6abaae( teamname );
    
    while ( level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] > 0 )
    {
        wait level.hackerphone.var_a349e2b8d2c3c110;
        function_70289ceafd152a5f( teamname, lootid );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x30ad359f, Offset: 0x16ea
// Size: 0x70
function function_55acef85dcea4c6c( teamname )
{
    level endon( #"game_ended" );
    wait 0.5;
    
    for ( var_d2f24fe0bcede77b = level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]; var_d2f24fe0bcede77b > 0 ; var_d2f24fe0bcede77b-- )
    {
        wait level.hackerphone.var_a349e2b8d2c3c110;
    }
    
    level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ]--;
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xe2616720, Offset: 0x1762
// Size: 0x1b9
function function_70289ceafd152a5f( teamname, lootid )
{
    if ( level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] > 0 )
    {
        level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]--;
    }
    
    var_ef832427c68eff57 = teams::getteamdata( teamname, "alivePlayers" );
    
    if ( !var_ef832427c68eff57.size )
    {
        return;
    }
    
    payoutvalue = function_97d54a99cb48d946( teamname );
    var_49d1109d70fecb76 = dmz_task_utils::function_5fad6b062ca5ce96( var_ef832427c68eff57, payoutvalue );
    
    foreach ( player in var_ef832427c68eff57 )
    {
        if ( isdefined( player ) && var_49d1109d70fecb76 > 0 && player.var_d7c6c2a492dda544 )
        {
            multipliedcash = int( ceil( dmz_task_utils::function_801915892ff1d63e( player, var_49d1109d70fecb76 ) ) );
            player br_plunder::playerplunderpickup( multipliedcash );
            
            if ( isdefined( lootid ) )
            {
                view_origin = player getvieworigin();
                player setclientomnvar( "ui_br_hacker_phone_remaining_payments", level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] );
                player br_pickups::function_55de798ca5dc4080( lootid, view_origin, 1, multipliedcash );
            }
            
            if ( isdefined( player.var_d8f8cc0486eccd5e ) )
            {
                player.var_d8f8cc0486eccd5e[ "totalPayout" ] = player.var_d8f8cc0486eccd5e[ "totalPayout" ] + multipliedcash * 10;
            }
            
            challenges::function_37e945722d6497f3( player, "passive_income_payment", 1 );
        }
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xfb91d522, Offset: 0x1923
// Size: 0x21d
function function_b55471045e6abaae( teamname )
{
    level endon( "monitor_payout_" + teamname );
    level endon( #"game_ended" );
    var_c799436422cf8dc1 = teams::getteamdata( teamname, "players" );
    
    for ( var_d2f24fe0bcede77b = level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]; var_d2f24fe0bcede77b > 0 ; var_d2f24fe0bcede77b-- )
    {
        if ( var_d2f24fe0bcede77b == 3 )
        {
            foreach ( player in var_c799436422cf8dc1 )
            {
                if ( isdefined( player ) && player.team == teamname )
                {
                    br_gametype_dmz::showdmzsplash( "dmz_hacker_phone_expiring", [ player ] );
                }
            }
        }
        
        wait level.hackerphone.var_a349e2b8d2c3c110;
    }
    
    foreach ( player in var_c799436422cf8dc1 )
    {
        if ( isdefined( player ) && player.team == teamname )
        {
            br_gametype_dmz::showdmzsplash( "dmz_hacker_phone_expired", [ player ] );
        }
    }
    
    wait 0.5;
    
    foreach ( player in var_c799436422cf8dc1 )
    {
        if ( isdefined( player ) )
        {
            player.var_d7c6c2a492dda544 = undefined;
        }
    }
    
    function_c9da883f28fd492( teamname, 0 );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x4a58e6b0, Offset: 0x1b48
// Size: 0x8f
function function_d1aad829093cf458( closestphone, player )
{
    if ( function_41641244efbe022a( closestphone, player.team ) )
    {
        player setclientomnvar( "ui_br_hacker_phone_state", 1 );
        return;
    }
    
    if ( player.canhackcontracts )
    {
        player setclientomnvar( "ui_br_hacker_phone_state", 2 );
        return;
    }
    
    player setclientomnvar( "ui_br_hacker_phone_state", 0 );
    
    if ( closestphone.activity.type == "hacker_phone" )
    {
        player function_8b0a22d69c3133ca();
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x35bcc90c, Offset: 0x1bdf
// Size: 0x119
function function_7d7f222935c0b5dd( teamname, instanceindex )
{
    var_3b64353cd4092f63 = level.teamdata[ teamname ][ "hackedContractsData1" ].size + level.teamdata[ teamname ][ "hackedContractsData2" ].size;
    assert( var_3b64353cd4092f63 <= level.hackerphone.var_1f893e68115f77b1, "<dev string:x24>" );
    
    if ( level.teamdata[ teamname ][ "hackedContractsData1" ].size < 2 )
    {
        level.teamdata[ teamname ][ "hackedContractsData1" ][ level.teamdata[ teamname ][ "hackedContractsData1" ].size ] = instanceindex;
        function_acada909aff0612( teamname, level.teamdata[ teamname ][ "hackedContractsData1" ], "ui_br_hacked_phones_data1" );
        return;
    }
    
    level.teamdata[ teamname ][ "hackedContractsData2" ][ level.teamdata[ teamname ][ "hackedContractsData2" ].size ] = instanceindex;
    function_acada909aff0612( teamname, level.teamdata[ teamname ][ "hackedContractsData2" ], "ui_br_hacked_phones_data2" );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xf1196c30, Offset: 0x1d00
// Size: 0xe4
function function_b582aa823c6bb0f5( teamname, instanceindex )
{
    if ( arraycontains( level.teamdata[ teamname ][ "hackedContractsData1" ], instanceindex ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData1" ] = arrayremove( level.teamdata[ teamname ][ "hackedContractsData1" ], instanceindex );
        function_acada909aff0612( teamname, level.teamdata[ teamname ][ "hackedContractsData1" ], "ui_br_hacked_phones_data1" );
        return;
    }
    
    if ( arraycontains( level.teamdata[ teamname ][ "hackedContractsData2" ], instanceindex ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData2" ] = arrayremove( level.teamdata[ teamname ][ "hackedContractsData2" ], instanceindex );
        function_acada909aff0612( teamname, level.teamdata[ teamname ][ "hackedContractsData2" ], "ui_br_hacked_phones_data2" );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x2232384e, Offset: 0x1dec
// Size: 0x9b
function function_8ec26ff4f54e72b4( player, teamname )
{
    if ( isdefined( level.teamdata[ teamname ][ "hackedContractsData1" ] ) )
    {
        packedvalue = function_a9bfbd91f5c42407( level.teamdata[ teamname ][ "hackedContractsData1" ] );
        player setclientomnvar( "ui_br_hacked_phones_data1", packedvalue );
    }
    
    if ( isdefined( level.teamdata[ teamname ][ "hackedContractsData2" ] ) )
    {
        packedvalue = function_a9bfbd91f5c42407( level.teamdata[ teamname ][ "hackedContractsData2" ] );
        player setclientomnvar( "ui_br_hacked_phones_data2", packedvalue );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 3
// Checksum 0xc1df03c, Offset: 0x1e8f
// Size: 0xb9
function function_acada909aff0612( teamname, var_4aa76ff09e8017ae, var_1a92d5b7f05df90d )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    packedvalue = function_a9bfbd91f5c42407( var_4aa76ff09e8017ae );
    
    foreach ( player in playersonteam )
    {
        player setclientomnvar( var_1a92d5b7f05df90d, packedvalue );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x765dba8b, Offset: 0x1f50
// Size: 0x42
function function_a9bfbd91f5c42407( var_4aa76ff09e8017ae )
{
    packedvalue = 0;
    
    for ( i = 0; i < var_4aa76ff09e8017ae.size ; i++ )
    {
        packedvalue += var_4aa76ff09e8017ae[ i ] << i * 16;
    }
    
    return packedvalue;
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x6384bc0a, Offset: 0x1f9b
// Size: 0x3c
function function_371a1a7a67c55dc7( player )
{
    if ( level.teamdata[ player.team ][ "hackerPhonePaymentCountActive" ] > 1 )
    {
        return "fly_pickup_cash_med_01";
    }
    
    return "fly_pickup_cash_01";
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xde66fd0d, Offset: 0x1fdf
// Size: 0x5b
function function_c422f6d43065595b( teamname, useplayer )
{
    var_48423c6dad66d9c3 = self.activity.var_48423c6dad66d9c3;
    
    if ( isdefined( useplayer ) )
    {
        var_48423c6dad66d9c3 = useplayer;
    }
    
    closestcontract = function_e9a161f9723e2f03( var_48423c6dad66d9c3, teamname );
    thread function_f86a8e8c067e7215( closestcontract, teamname );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0xc43b6e33, Offset: 0x2042
// Size: 0x225
function function_e9a161f9723e2f03( var_48423c6dad66d9c3, teamname )
{
    sortfrompoint = self.node.origin;
    
    if ( isdefined( var_48423c6dad66d9c3 ) )
    {
        sortfrompoint = var_48423c6dad66d9c3.origin;
    }
    else
    {
        playersonteam = teams::getteamdata( teamname, "players" );
        
        foreach ( player in playersonteam )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            sortfrompoint = player.origin;
            break;
        }
    }
    
    closestphones = [];
    
    foreach ( closephone in level.var_f9ba6d6273c5cc67.var_9433e6119f67c877 )
    {
        if ( !( isdefined( closephone ) && isdefined( closephone.origin ) ) )
        {
            continue;
        }
        
        closestphones[ closestphones.size ] = closephone;
    }
    
    closestphones = sortbydistance( closestphones, sortfrompoint );
    closestphones = arrayremove( closestphones, self.hackedinstances );
    
    if ( closestphones.size > 0 )
    {
        foreach ( phone in closestphones )
        {
            if ( function_eb9cb24f743cd519( phone ) )
            {
                function_39e79b57ff47cbbe( phone );
                return phone;
            }
        }
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x55ce5b46, Offset: 0x226f
// Size: 0xf3
function function_f86a8e8c067e7215( var_567cf684baff459e, teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"marked_contract_hacked" );
    
    if ( !isdefined( var_567cf684baff459e ) )
    {
        return;
    }
    
    haspart = var_567cf684baff459e getscriptablehaspart( "brloot_activity_starter" );
    
    if ( !haspart )
    {
        return;
    }
    
    self.var_d0108c7e132f1bac = 0;
    
    while ( !function_6d89f39dafcc5bf5() )
    {
        if ( var_567cf684baff459e getscriptablepartstate( "brloot_activity_starter" ) == "hidden" || self.var_d0108c7e132f1bac >= 90 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hacker_phone_nag", teamname, 0 );
            self.var_d0108c7e132f1bac = 0;
            var_567cf684baff459e = function_e9a161f9723e2f03( self.activity.var_48423c6dad66d9c3, teamname );
        }
        
        self.var_d0108c7e132f1bac++;
        wait 1;
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x4eeb1333, Offset: 0x236a
// Size: 0x47
function function_39e79b57ff47cbbe( scriptableinstance )
{
    if ( self.var_317cb22c817030c5 == scriptableinstance )
    {
        return;
    }
    
    dmz_task_utils::function_c74c010e593f5ea5( scriptableinstance.origin + ( 0, 0, 25 ) );
    self.var_317cb22c817030c5 = scriptableinstance;
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xfbf46f5e, Offset: 0x23b9
// Size: 0x121
function function_ca6388987d86425c( teamname )
{
    self.dlogdata = [];
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( isdefined( player ) )
        {
            function_3dabc2a09207ecf6( player, 0, 0, 1 );
            player.var_d8f8cc0486eccd5e = [];
            player.var_d8f8cc0486eccd5e[ "tabletIndex" ] = self.tablet.index;
            player.var_d8f8cc0486eccd5e[ "totalPayout" ] = 0;
            player.var_d8f8cc0486eccd5e[ "payoutValue" ] = self.payoutvalue * 10;
            disconnect_event_aggregator::registerondisconnecteventcallback( &function_d808da5bd374652c );
        }
    }
    
    thread function_aba872bc98d19cf4( teamname );
}

// Namespace namespace_84d989e8789e6a05
// Params 2
// Checksum 0x24dea6c4, Offset: 0x24e2
// Size: 0xad
function function_c9da883f28fd492( teamname, var_85f0bd4d991741a )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        function_3dabc2a09207ecf6( player, var_85f0bd4d991741a, 0, 0 );
    }
    
    self notify( #"hash_bcf5c7a076264d1d" );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xe82f4834, Offset: 0x2597
// Size: 0x19
function function_d808da5bd374652c( player )
{
    function_3dabc2a09207ecf6( player, 0, 1, 0 );
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xc4ab0a64, Offset: 0x25b8
// Size: 0x30
function function_aba872bc98d19cf4( teamname )
{
    level endon( #"hash_bcf5c7a076264d1d" );
    level waittill( #"game_ended" );
    function_c9da883f28fd492( teamname, 1 );
}

// Namespace namespace_84d989e8789e6a05
// Params 4
// Checksum 0xf60f29c, Offset: 0x25f0
// Size: 0xdc
function function_3dabc2a09207ecf6( player, var_85f0bd4d991741a, var_805b233fcebc3306, payoutextended )
{
    if ( isdefined( player ) & isarray( player.var_d8f8cc0486eccd5e ) )
    {
        player dlog_recordplayerevent( "dlog_event_contract_hacker_phone_payment_phase_completion", [ "tablet_index", player.var_d8f8cc0486eccd5e[ "tabletIndex" ], "total_payout_value", player.var_d8f8cc0486eccd5e[ "totalPayout" ], "cash_per_payout", player.var_d8f8cc0486eccd5e[ "payoutValue" ], "stopped_by_match_end", var_85f0bd4d991741a, "stopped_by_disconnect", var_805b233fcebc3306, "payout_extended", payoutextended ] );
        player.var_d8f8cc0486eccd5e = undefined;
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0x2318250c, Offset: 0x26d4
// Size: 0x2a
function function_2550892140fff0c1( params )
{
    if ( self.var_d7c6c2a492dda544 )
    {
        self.var_d7c6c2a492dda544 = undefined;
        thread function_7121ed0b475db1f5( self );
    }
}

// Namespace namespace_84d989e8789e6a05
// Params 1
// Checksum 0xbdfb7546, Offset: 0x2706
// Size: 0x3b
function function_7121ed0b475db1f5( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    wait 1;
    br_gametype_dmz::showdmzsplash( "dmz_hacker_phone_expired", [ player ] );
}

