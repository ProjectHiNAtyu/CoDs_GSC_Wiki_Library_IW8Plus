// scripts\mp\br\gametypes\br_hacker_phone_quest.gsc  (hash_17267ea0966a3768.gscc) (size: 20950 Bytes / 0x51d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeccf5065 (3973009509)
// size ...... 20950 (0x51d6)
// includes .. 15  (offset: 0x4c8a)
// strings ... 71  (offset: 0x4d02)
// dev strs .. 1   (offset: 0x51ca)
// exports ... 65  (offset: 0x3252)
// cseg ...... 0x6bc + 0x2b96 (0x3252)
// imports ... 131 (offset: 0x3c7a)
// animtree1 . 0   (offset: 0x51d6)
// animtree2 . 0   (offset: 0x51d6)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\rank;

#namespace br_hacker_phone_quest;

// Namespace br_hacker_phone_quest
// Params 0, eflags: 0x1
// Checksum 0x89398c26, Offset: 0x6da
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"hacker_phone", #"get_contract_data", &getcontractdata );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x76e2a15b, Offset: 0x702
// Size: 0x1b0
function getcontractdata( data )
{
    quest_initdata( data );
    data.funcs[ "onInit" ] = &quest_oninit;
    data.funcs[ "onTeamAssigned" ] = &quest_onteamassigned;
    data.funcs[ "onEnterGulag" ] = &quest_onentergulag;
    data.funcs[ "onPlayerRespawn" ] = &quest_onrespawn;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_22116566150b5d1;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &quest_onplayerteardown;
    data.funcs[ "onPlayerAssimilated" ] = &quest_onplayerassimilated;
    data.funcs[ "bestRespawnMissionOrigin" ] = &function_30e1c8272073cbc1;
    data.basetime = level.hackerphone.questmaxtime;
    level.contractmanager.var_47ca1f8bfd0c7ece = arraycombineunique( level.contractmanager.var_47ca1f8bfd0c7ece, [ &function_3696c4f50b8660c0 ] );
    level.contractmanager.var_f47c95550183eda9 = arraycombineunique( level.contractmanager.var_f47c95550183eda9, [ &function_be017604e50ab2b6 ] );
    callback::add( #"player_assimilated", &function_f91cdac8bffddf2a );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x5db762ac, Offset: 0x8ba
// Size: 0x1c
function quest_initdata( data )
{
    quest_initvariables( data );
    quest_initdialog();
}

// Namespace br_hacker_phone_quest
// Params 1, eflags: 0x4
// Checksum 0x9fe8efe0, Offset: 0x8de
// Size: 0x203
function private quest_initvariables( data )
{
    level.hackerphone = spawnstruct();
    level.hackerphone.enabled = getdvarint( @"hash_2665e66573a7705c", 1 );
    level.hackerphone.questmaxtime = getdvarint( @"hash_c7d4297bb4f79596", br_contract_manager::function_4bc46e9c9bb0d265( "hacker_phone" ) );
    var_7f0e8624f9666f = getdvar( @"hash_77a36e010a7b53f1", "" );
    
    if ( var_7f0e8624f9666f != "" )
    {
        level.hackerphone.var_9334cfba1af074b6 = strtok( var_7f0e8624f9666f, " " );
    }
    
    if ( isdefined( data.var_3e66e51a241b9989 ) && isdefined( data.var_3e66e51a241b9989.variant_object.var_be0adcc0147d2bfa ) )
    {
        level.hackerphone.var_be0adcc0147d2bfa = data.var_3e66e51a241b9989.variant_object.var_be0adcc0147d2bfa;
    }
    
    level.hackerphone.var_aa043f8b416d469a = getdvarint( @"hash_c4e08d2fdaab55f3", 75 );
    level.hackerphone.var_a349e2b8d2c3c110 = getdvarint( @"hash_23fab88c275bec9f", 20 );
    level.hackerphone.var_1bc84b4e41e8e325 = getdvarint( @"hash_3cf195484e92a076", 200 );
    level.hackerphone.var_44015290e6d36c32 = getdvarint( @"hash_630e4b6f3cc13d1e", 1 );
    level.hackerphone.payoutcount = int( level.hackerphone.var_1bc84b4e41e8e325 / level.hackerphone.var_a349e2b8d2c3c110 );
    level.hackerphone.shouldplayanim = getdvarint( @"hash_7152a29b5f75e34d", 1 );
}

// Namespace br_hacker_phone_quest
// Params 0, eflags: 0x4
// Checksum 0xb3f23eb1, Offset: 0xae9
// Size: 0x74
function private quest_initdialog()
{
    game[ "dialog" ][ "hacker_phone_start" ] = "hack_wzan_msns";
    game[ "dialog" ][ "hacker_phone_nag" ] = "hack_wzan_nag1";
    game[ "dialog" ][ "hacker_phone_missing" ] = "hack_wzan_mrkl";
    game[ "dialog" ][ "hacker_phone_timer_expired" ] = "hack_wzan_tmxp_01";
    game[ "dialog" ][ "hacker_phone_contract_hacked" ] = "hack_wzan_cnhc";
    game[ "dialog" ][ "hacker_phone_complete" ] = "hack_wzan_scmh";
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x8f615a41, Offset: 0xb65
// Size: 0x1c
function quest_oninit()
{
    thread function_b5324ed349f5ea37();
    return level.hackerphone.enabled;
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x29bb19e3, Offset: 0xb8a
// Size: 0x13b
function function_74a499a320255c30()
{
    teamsize = teams::getteamcount( self.team );
    contractlimit = 2;
    
    if ( isdefined( teamsize ) )
    {
        if ( isarray( level.hackerphone.var_9334cfba1af074b6 ) && level.hackerphone.var_9334cfba1af074b6.size >= teamsize )
        {
            contractlimit = int( level.hackerphone.var_9334cfba1af074b6[ teamsize - 1 ] );
        }
        else if ( isarray( level.hackerphone.var_be0adcc0147d2bfa ) )
        {
            foreach ( var_ecd9a5d1d9ed34a in level.hackerphone.var_be0adcc0147d2bfa )
            {
                if ( var_ecd9a5d1d9ed34a.teamsize == teamsize )
                {
                    contractlimit = var_ecd9a5d1d9ed34a.contractlimit;
                    break;
                }
            }
        }
    }
    
    return contractlimit;
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0xfb4da382, Offset: 0xcce
// Size: 0x20e
function quest_onteamassigned()
{
    self.category = "hacker_phone";
    teamname = self.team;
    self.var_5fff89b8a8a5275c = 0;
    self.var_c7c39713542d5360 = function_74a499a320255c30();
    self.payoutvalue = function_d9f029bfd94e972a( teamname );
    self.hackedinstances = [];
    
    if ( !function_ea6b677a9aef07dd() )
    {
        function_62d7554f9f5e5e6f( "br_hacker_phone_quest_failure", undefined, undefined, "Circle", 1 );
        return;
    }
    
    quest_setteamdata( teamname );
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.canhackcontracts = 1;
        player setclientomnvar( "ui_br_hacker_phone_state", 2 );
    }
    
    splashref = br_contract_manager::function_7c9586992cf68ed1( "br_hacker_phone_quest_start_team" );
    br_contract_manager::function_5c7e547ccc13711b( splashref );
    br_contract_manager::function_ba80ad6a1d946b85( 6, br_contract_manager::getquestindex( "hacker_phone" ) );
    br_contract_manager::function_87e10a6e85d45d58( "hacker_phone" );
    br_contract_manager::function_9fe564137142e8ee( self.var_5fff89b8a8a5275c, function_74a499a320255c30() );
    time = br_contract_manager::function_2f14979bf83bc3db( level.hackerphone.questmaxtime );
    br_contract_manager::function_3fbbc67df36be7bb( time );
    thread quest_watchtimer( time );
    br_contract_manager::createquestobjicon( "ui_map_icon_obj_hacker", "current", ( 0, 0, 0 ), self );
    objective_removeallfrommask( self.objectiveiconid );
    thread br_contract_manager::function_b6def068f44f04c9( self.objectiveiconid, teamname );
    function_597f7046b2cca91f( teamname );
    level thread br_public::brleaderdialogteam( "hacker_phone_start", teamname, 1, 1, undefined );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xe38ea17b, Offset: 0xee4
// Size: 0xd9
function quest_setteamdata( teamname )
{
    if ( !isdefined( level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] ) )
    {
        level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] = 0;
    }
    
    if ( !isdefined( level.teamdata[ teamname ][ "hackerPhoneIncreasedPaymentCountActive" ] ) )
    {
        level.teamdata[ teamname ][ "hackerPhoneIncreasedPaymentCountActive" ] = 0;
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
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xc56e2beb, Offset: 0xfc5
// Size: 0x112
function function_d9f029bfd94e972a( teamname )
{
    var_f4323195d896ce2e = level.hackerphone.var_aa043f8b416d469a;
    
    if ( level.hackerphone.var_44015290e6d36c32 )
    {
        var_58714c97368a2ed4 = getdvar( @"hash_779eac48f0f0fa66", "75 45 35 30" );
        payoutvalues = strtok( var_58714c97368a2ed4, " " );
        teamcount = int( min( teams::getteamcount( teamname ), payoutvalues.size ) );
        var_f4323195d896ce2e = int( payoutvalues[ teamcount - 1 ] );
    }
    
    if ( isdefined( self.tablet ) )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"getcontractplunderbonus" ) )
        {
            bonus = utility::callsharedfunc( #"gametype", #"getcontractplunderbonus", self );
            
            if ( bonus > 0 )
            {
                bonus /= level.hackerphone.payoutcount;
                var_f4323195d896ce2e += bonus;
            }
        }
    }
    
    return int( var_f4323195d896ce2e );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x7cb4cd28, Offset: 0x10e0
// Size: 0x51
function function_597f7046b2cca91f( teamname, useplayer )
{
    var_48423c6dad66d9c3 = self.var_48423c6dad66d9c3;
    
    if ( isdefined( useplayer ) )
    {
        var_48423c6dad66d9c3 = useplayer;
    }
    
    closestcontract = function_ebf9d64ec0e672e7( var_48423c6dad66d9c3, teamname );
    thread function_3aa19d53350b80a9( closestcontract, teamname );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x9fe8d1d, Offset: 0x1139
// Size: 0x248
function function_ebf9d64ec0e672e7( var_48423c6dad66d9c3, teamname )
{
    sortfrompoint = self.tablet.origin;
    
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
    
    foreach ( closephone in level.contractmanager.activetablets )
    {
        if ( !( isdefined( closephone ) && isdefined( closephone.origin ) ) )
        {
            continue;
        }
        
        if ( isdefined( closephone.task ) && isdefined( closephone.task.type ) && isdefined( closephone.task.type.ref ) && br_elite_broken_arrow::function_a24e8e6e0c75e020( closephone.task.type.ref ) )
        {
            continue;
        }
        
        closestphones[ closestphones.size ] = closephone;
    }
    
    closestphones = sortbydistance( closestphones, sortfrompoint );
    closestphones = arrayremove( closestphones, self.hackedinstances );
    closestphones = arrayremove( closestphones, self.tablet );
    
    if ( closestphones.size > 0 )
    {
        closestphone = closestphones[ 0 ];
        function_73f1145ec85910e2( closestphone );
        return closestphone;
    }
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x16ce067, Offset: 0x1389
// Size: 0xff
function function_3aa19d53350b80a9( markeditem, teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"marked_contract_hacked" );
    
    if ( !isdefined( markeditem ) )
    {
        return;
    }
    
    self.var_d0108c7e132f1bac = 0;
    
    while ( !function_360aec946e88ae31() )
    {
        var_9d379c5ba8ece0bd = 0;
        
        if ( self.var_d0108c7e132f1bac >= 70 )
        {
            level thread br_public::brleaderdialogteam( "hacker_phone_nag", teamname, 1, 0, undefined );
            var_9d379c5ba8ece0bd = 1;
            self.var_d0108c7e132f1bac = 0;
        }
        
        if ( !isdefined( markeditem ) || !arraycontains( level.contractmanager.activetablets, markeditem ) )
        {
            level thread br_public::brleaderdialogteam( "hacker_phone_missing", teamname, 1, 0, undefined, "dx_br_bds4_" );
            var_9d379c5ba8ece0bd = 1;
        }
        
        if ( var_9d379c5ba8ece0bd )
        {
            markeditem = function_ebf9d64ec0e672e7( self.var_48423c6dad66d9c3, teamname );
        }
        
        self.var_d0108c7e132f1bac++;
        wait 1;
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xc407df61, Offset: 0x1490
// Size: 0x47
function function_73f1145ec85910e2( item )
{
    if ( self.var_317cb22c817030c5 == item )
    {
        return;
    }
    
    br_contract_manager::movequestobjicon( item.origin + ( 0, 0, 25 ) );
    self.var_317cb22c817030c5 = item;
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xa6e4c824, Offset: 0x14df
// Size: 0x95
function function_65e79827fc9cbdf8( item, useplayer )
{
    useplayer endon( #"death_or_disconnect" );
    task = br_contract_manager::function_28779161e0912456( useplayer.team );
    
    if ( function_bfdaee73858e4f26( item, useplayer.team ) )
    {
        useplayer hud_message::showerrormessage( "MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED" );
        return;
    }
    
    if ( level.hackerphone.shouldplayanim )
    {
        useplayer dmz_task_utils::function_ce0c366b96d23996( "intel_pickup_phone_alt", 11 );
    }
    
    task function_8daac702e97483cf( item, useplayer );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x49e1b830, Offset: 0x157c
// Size: 0x3c, Type: bool
function function_bfdaee73858e4f26( item, teamname )
{
    if ( isdefined( item.var_7379b55339275347 ) )
    {
        if ( arraycontains( item.var_7379b55339275347, teamname ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xa4a2dc1e, Offset: 0x15c1
// Size: 0x5f
function function_fa9be0c3a117abb3( item, teamname )
{
    if ( !isdefined( item.var_7379b55339275347 ) )
    {
        item.var_7379b55339275347 = [];
    }
    
    item.var_7379b55339275347[ item.var_7379b55339275347.size ] = teamname;
    function_ea0142dd2875d9( teamname, item.index );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x12e2ffe2, Offset: 0x1628
// Size: 0x6a
function function_84a49b91479880e( item, teamname )
{
    if ( isdefined( item.var_7379b55339275347 ) && arraycontains( item.var_7379b55339275347, teamname ) )
    {
        item.var_7379b55339275347 = arrayremove( item.var_7379b55339275347, teamname );
        function_542963f1a1d18649( teamname, item.index );
    }
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x11d03857, Offset: 0x169a
// Size: 0x25f
function function_8daac702e97483cf( item, useplayer )
{
    if ( function_bfdaee73858e4f26( item, useplayer.team ) )
    {
        useplayer hud_message::showerrormessage( "MP_BR_INGAME/HACKER_PHONE_ALREADY_HACKED" );
        return;
    }
    
    task = br_contract_manager::function_28779161e0912456( useplayer br_contract_manager::function_6b738bc71eb53bd4() );
    
    if ( !isdefined( task ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( task != self )
    {
        return;
    }
    
    if ( task function_360aec946e88ae31() )
    {
        return;
    }
    
    task function_fa9be0c3a117abb3( item, useplayer.team );
    task.hackedinstances[ task.hackedinstances.size ] = item;
    task.var_5fff89b8a8a5275c++;
    task.var_c7c39713542d5360 = function_74a499a320255c30() - task.var_5fff89b8a8a5275c;
    task br_contract_manager::function_9fe564137142e8ee( task.var_5fff89b8a8a5275c, function_74a499a320255c30() );
    function_fb301c73f666fe9c( item, useplayer );
    
    if ( task.var_317cb22c817030c5 == item )
    {
        task notify( #"marked_contract_hacked" );
        task function_597f7046b2cca91f( useplayer.team, useplayer );
    }
    
    task.var_d0108c7e132f1bac = 0;
    playersonteam = teams::getteamdata( useplayer.team, "players" );
    
    foreach ( player in playersonteam )
    {
        xp = rank::getscoreinfoxp( #"br_mission_hacker_phone_contract_hacked" );
        xpmultiplier = task.islegendarycontract ? 1 + level.var_a792abb228730d6f.var_5a5f96c0b3a351e0 : 1;
        player thread points::doscoreevent( #"br_mission_hacker_phone_contract_hacked", undefined, undefined, xp * xpmultiplier );
    }
    
    if ( task function_360aec946e88ae31() )
    {
        task function_dd72e973244442d1( 1, "Win" );
        return;
    }
    
    level thread br_public::brleaderdialogteam( "hacker_phone_contract_hacked", useplayer.team, 1, 0.5, undefined );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xf3cb8c69, Offset: 0x1901
// Size: 0x45
function quest_watchtimer( time )
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    thread function_4d5bd9e78c2f51b1();
    wait time;
    function_62d7554f9f5e5e6f( "br_hacker_phone_quest_timer_expired", "hacker_phone_timer_expired", undefined, "Time" );
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x28dc7358, Offset: 0x194e
// Size: 0x88
function function_4d5bd9e78c2f51b1()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    hackablecontracts = level.contractmanager.activetablets;
    
    while ( hackablecontracts.size >= self.var_c7c39713542d5360 )
    {
        hackablecontracts = level.contractmanager.activetablets;
        hackablecontracts = arrayremove( hackablecontracts, self.hackedinstances );
        wait 1;
    }
    
    function_62d7554f9f5e5e6f( "br_hacker_phone_quest_failure", undefined, undefined, "Circle" );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xa80078a6, Offset: 0x19de
// Size: 0x20
function quest_onentergulag( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xce551b58, Offset: 0x1a06
// Size: 0x20
function quest_onrespawn( player )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::showquestobjicontoplayer( player );
    }
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xc5aa7d55, Offset: 0x1a2e
// Size: 0x1e
function quest_onplayerkilled( attacker, victim )
{
    quest_playerremoved( victim );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x63b5d747, Offset: 0x1a54
// Size: 0x15
function function_22116566150b5d1( victim )
{
    quest_playerremoved( victim );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xa3972266, Offset: 0x1a71
// Size: 0x15
function quest_onplayerdisconnect( player )
{
    quest_playerremoved( player );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xc72a60e7, Offset: 0x1a8e
// Size: 0x6f
function quest_playerremoved( player )
{
    if ( player.team == self.team )
    {
        filter = br_contract_manager::function_42827c79f1968770( player, level.contractmanager.defaultfilter );
        
        if ( !br_quest_util::isteamvalid( self.team, filter ) )
        {
            function_62d7554f9f5e5e6f( undefined, undefined, undefined, "Killed" );
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xa611f751, Offset: 0x1b05
// Size: 0x2a
function quest_oncancel( team )
{
    if ( self.team == team )
    {
        function_62d7554f9f5e5e6f( undefined, undefined, undefined, "Cancel" );
    }
}

// Namespace br_hacker_phone_quest
// Params 5
// Checksum 0x8d20dec9, Offset: 0x1b37
// Size: 0x83
function function_62d7554f9f5e5e6f( splashref, voiceref, delayoverride, endstate, skipwait )
{
    if ( isdefined( splashref ) )
    {
        br_contract_manager::function_5c7e547ccc13711b( splashref );
    }
    
    delay = 0;
    
    if ( isdefined( delayoverride ) )
    {
        delay = delayoverride;
    }
    
    if ( isdefined( voiceref ) )
    {
        level thread br_public::brleaderdialogteam( voiceref, self.team, 1, delay, undefined );
    }
    
    thread function_dd72e973244442d1( 0, endstate, skipwait );
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x62e3a418, Offset: 0x1bc2
// Size: 0x19, Type: bool
function function_360aec946e88ae31()
{
    if ( self.var_5fff89b8a8a5275c >= function_74a499a320255c30() )
    {
        return true;
    }
    
    return false;
}

// Namespace br_hacker_phone_quest
// Params 3
// Checksum 0xdff8c414, Offset: 0x1be4
// Size: 0xbe
function function_dd72e973244442d1( success, endstate, skipwait )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    level endon( #"game_ended" );
    self notify( #"task_ended" );
    contractor = self.contractoractive;
    
    if ( !skipwait )
    {
        wait level.contractmanager.var_dc52ccd301b92f4f ?? 0.3;
    }
    
    teamname = self.team;
    quest_cleanup( teamname );
    br_contract_manager::endcontract( success, undefined, undefined, undefined, endstate );
    
    if ( success )
    {
        thread function_c612710556886eb7( teamname, contractor );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x2d9456c5, Offset: 0x1caa
// Size: 0x132
function quest_cleanup( teamname )
{
    if ( br_contract_manager::checkforactiveobjicon() )
    {
        br_contract_manager::deletequestobjicon();
    }
    
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
        function_84a49b91479880e( taskinstance, teamname );
    }
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x6b368ee3, Offset: 0x1de4
// Size: 0x16d
function function_c612710556886eb7( teamname, contractor )
{
    level endon( #"game_ended" );
    params = spawnstruct();
    params.intvar = level.hackerphone.payoutcount;
    splashref = br_contract_manager::function_7c9586992cf68ed1( "br_hacker_phone_quest_complete" );
    br_contract_manager::function_5c7e547ccc13711b( splashref, params );
    level thread br_public::brleaderdialogteam( "hacker_phone_complete", teamname, 1, 1.5, undefined );
    br_contract_manager::function_7d7e225a8f9c9222( "hacker_phone", self.origin, self.team, self );
    function_98fd79adf815d470( teamname );
    
    if ( !function_8ff586a423ffc3f( teamname ) )
    {
        wait 4;
    }
    
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.var_d7c6c2a492dda544 = 1;
    }
    
    if ( contractor )
    {
        thread function_920a0b43782fbff9( teamname );
        return;
    }
    
    thread function_c1663eff1189276b( teamname );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x53a50c4c, Offset: 0x1f59
// Size: 0x20, Type: bool
function function_8ff586a423ffc3f( teamname )
{
    return level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] > 0;
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x4c03b64a, Offset: 0x1f82
// Size: 0x60
function function_c1663eff1189276b( teamname )
{
    level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ]++;
    level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] = level.hackerphone.payoutcount;
    function_21042e64474d3d7b( teamname );
    thread function_44c7e5f6277fe8fd( teamname );
    thread function_8ad899d49a0b6a08( teamname );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xd77d2e3c, Offset: 0x1fea
// Size: 0x70
function function_4d6acaaca1dc02( teamname )
{
    level endon( #"game_ended" );
    wait 0.05;
    
    for ( var_d2f24fe0bcede77b = level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]; var_d2f24fe0bcede77b > 0 ; var_d2f24fe0bcede77b-- )
    {
        wait level.hackerphone.var_a349e2b8d2c3c110;
    }
    
    level.teamdata[ teamname ][ "hackerPhoneIncreasedPaymentCountActive" ]--;
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xbf0ec767, Offset: 0x2062
// Size: 0x60
function function_920a0b43782fbff9( teamname )
{
    level.teamdata[ teamname ][ "hackerPhoneIncreasedPaymentCountActive" ]++;
    level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] = level.hackerphone.payoutcount;
    function_21042e64474d3d7b( teamname );
    thread function_44c7e5f6277fe8fd( teamname );
    thread function_4d6acaaca1dc02( teamname );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x5fca2fa9, Offset: 0x20ca
// Size: 0x70
function function_8ad899d49a0b6a08( teamname )
{
    level endon( #"game_ended" );
    wait 0.05;
    
    for ( var_d2f24fe0bcede77b = level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]; var_d2f24fe0bcede77b > 0 ; var_d2f24fe0bcede77b-- )
    {
        wait level.hackerphone.var_a349e2b8d2c3c110;
    }
    
    level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ]--;
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x8f00eb8e, Offset: 0x2142
// Size: 0x6e
function function_44c7e5f6277fe8fd( teamname )
{
    level notify( "monitor_payout_" + teamname );
    level endon( "monitor_payout_" + teamname );
    level endon( #"game_ended" );
    thread function_f509949a511864da( teamname );
    
    while ( level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] > 0 )
    {
        wait level.hackerphone.var_a349e2b8d2c3c110;
        function_21042e64474d3d7b( teamname );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x4fa7a5d2, Offset: 0x21b8
// Size: 0x1ca
function function_21042e64474d3d7b( teamname )
{
    if ( level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] > 0 )
    {
        level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]--;
    }
    
    payoutvalue = function_d57a908a09b65032( teamname );
    var_ef832427c68eff57 = teams::getteamdata( teamname, "alivePlayers" );
    
    foreach ( player in var_ef832427c68eff57 )
    {
        if ( isdefined( player ) && payoutvalue > 0 && player.var_d7c6c2a492dda544 && !player br_public::isplayerinorgoingtogulag() )
        {
            bundlename = common_item_database::function_ca9ca606e66b5911( "brloot_payment_hacker_phone" );
            itembundle = common_item::function_90c3e0c1fd55d6b6( bundlename );
            paymentitem = spawnstruct();
            paymentitem.type = itembundle.scriptable;
            paymentitem.count = payoutvalue;
            player common_item::function_96119bed8ab4c5d9( paymentitem, 1, 1 );
            pickupsfx = function_371a1a7a67c55dc7( teamname );
            player playlocalsound( pickupsfx );
            player setclientomnvar( "ui_br_hacker_phone_remaining_payments", level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ] );
            
            if ( isdefined( player.var_d8f8cc0486eccd5e ) )
            {
                player.var_d8f8cc0486eccd5e[ "totalPayout" ] = player.var_d8f8cc0486eccd5e[ "totalPayout" ] + payoutvalue * 10;
            }
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xab6ca9a5, Offset: 0x238a
// Size: 0x213
function function_f509949a511864da( teamname )
{
    level endon( "monitor_payout_" + teamname );
    level endon( #"game_ended" );
    var_a8968efab6722160 = teams::getteamdata( teamname, "players" );
    
    for ( var_d2f24fe0bcede77b = level.teamdata[ teamname ][ "hackerPhonePaymentsRemaining" ]; var_d2f24fe0bcede77b > 0 ; var_d2f24fe0bcede77b-- )
    {
        if ( var_d2f24fe0bcede77b == 3 )
        {
            foreach ( player in var_a8968efab6722160 )
            {
                if ( isdefined( player ) && player.team == teamname )
                {
                    br_contract_manager::displayplayersplash( player, "br_hacker_phone_quest_payment_expiring" );
                }
            }
        }
        
        wait level.hackerphone.var_a349e2b8d2c3c110;
    }
    
    function_8e88cc2537a846d6( teamname, 0 );
    
    foreach ( player in var_a8968efab6722160 )
    {
        if ( isdefined( player ) && player.team == teamname )
        {
            br_contract_manager::displayplayersplash( player, "br_hacker_phone_quest_payment_expired" );
        }
    }
    
    wait 0.05;
    
    foreach ( player in var_a8968efab6722160 )
    {
        if ( isdefined( player ) )
        {
            player.var_d7c6c2a492dda544 = undefined;
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x76984d8b, Offset: 0x25a5
// Size: 0x96
function function_d57a908a09b65032( teamname )
{
    var_e004b61e2a0d37cc = level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] * self.payoutvalue;
    var_fcef3a3384f52aa9 = 0;
    
    if ( isdefined( level.br_pe_data[ %"contractor" ] ) )
    {
        var_fcef3a3384f52aa9 = level.teamdata[ teamname ][ "hackerPhoneIncreasedPaymentCountActive" ] * self.payoutvalue * level.br_pe_data[ %"contractor" ].var_2371647dff4b6751;
    }
    
    return var_e004b61e2a0d37cc + var_fcef3a3384f52aa9;
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x6c3fe4b7, Offset: 0x2644
// Size: 0x10c
function function_ea0142dd2875d9( teamname, itemindex )
{
    var_3b64353cd4092f63 = level.teamdata[ teamname ][ "hackedContractsData1" ].size + level.teamdata[ teamname ][ "hackedContractsData2" ].size;
    assert( var_3b64353cd4092f63 <= function_74a499a320255c30(), "<dev string:x24>" );
    
    if ( level.teamdata[ teamname ][ "hackedContractsData1" ].size < 2 )
    {
        level.teamdata[ teamname ][ "hackedContractsData1" ][ level.teamdata[ teamname ][ "hackedContractsData1" ].size ] = itemindex;
        function_5a0cef6e706aa69e( teamname, level.teamdata[ teamname ][ "hackedContractsData1" ], "ui_br_hacked_phones_data1" );
        return;
    }
    
    level.teamdata[ teamname ][ "hackedContractsData2" ][ level.teamdata[ teamname ][ "hackedContractsData2" ].size ] = itemindex;
    function_5a0cef6e706aa69e( teamname, level.teamdata[ teamname ][ "hackedContractsData2" ], "ui_br_hacked_phones_data2" );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xcb3907e7, Offset: 0x2758
// Size: 0xe4
function function_542963f1a1d18649( teamname, itemindex )
{
    if ( arraycontains( level.teamdata[ teamname ][ "hackedContractsData1" ], itemindex ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData1" ] = arrayremove( level.teamdata[ teamname ][ "hackedContractsData1" ], itemindex );
        function_5a0cef6e706aa69e( teamname, level.teamdata[ teamname ][ "hackedContractsData1" ], "ui_br_hacked_phones_data1" );
        return;
    }
    
    if ( arraycontains( level.teamdata[ teamname ][ "hackedContractsData2" ], itemindex ) )
    {
        level.teamdata[ teamname ][ "hackedContractsData2" ] = arrayremove( level.teamdata[ teamname ][ "hackedContractsData2" ], itemindex );
        function_5a0cef6e706aa69e( teamname, level.teamdata[ teamname ][ "hackedContractsData2" ], "ui_br_hacked_phones_data2" );
    }
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xa8cdb565, Offset: 0x2844
// Size: 0x9b
function function_b1ff2c2ce1c9f270( player, teamname )
{
    if ( isdefined( level.teamdata[ teamname ][ "hackedContractsData1" ] ) )
    {
        packedvalue = function_faa31184f0628af3( level.teamdata[ teamname ][ "hackedContractsData1" ] );
        player setclientomnvar( "ui_br_hacked_phones_data1", packedvalue );
    }
    
    if ( isdefined( level.teamdata[ teamname ][ "hackedContractsData2" ] ) )
    {
        packedvalue = function_faa31184f0628af3( level.teamdata[ teamname ][ "hackedContractsData2" ] );
        player setclientomnvar( "ui_br_hacked_phones_data2", packedvalue );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xe194d815, Offset: 0x28e7
// Size: 0x121
function function_98fd79adf815d470( teamname )
{
    self.dlogdata = [];
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        if ( isdefined( player ) )
        {
            function_76c19f78121ebe32( player, 0, 0, 1 );
            player.var_d8f8cc0486eccd5e = [];
            player.var_d8f8cc0486eccd5e[ "tabletIndex" ] = self.tablet.index;
            player.var_d8f8cc0486eccd5e[ "totalPayout" ] = 0;
            player.var_d8f8cc0486eccd5e[ "payoutValue" ] = self.payoutvalue * 10;
            disconnect_event_aggregator::registerondisconnecteventcallback( &function_63262a672fe34388 );
        }
    }
    
    thread function_39a68d840e283dd8( teamname );
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0x389a1849, Offset: 0x2a10
// Size: 0xad
function function_8e88cc2537a846d6( teamname, var_85f0bd4d991741a )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    
    foreach ( player in playersonteam )
    {
        function_76c19f78121ebe32( player, var_85f0bd4d991741a, 0, 0 );
    }
    
    self notify( #"hash_bcf5c7a076264d1d" );
}

// Namespace br_hacker_phone_quest
// Params 4
// Checksum 0x9f906d75, Offset: 0x2ac5
// Size: 0xdc
function function_76c19f78121ebe32( player, var_85f0bd4d991741a, var_805b233fcebc3306, payoutextended )
{
    if ( isdefined( player ) & isarray( player.var_d8f8cc0486eccd5e ) )
    {
        player dlog_recordplayerevent( "dlog_event_contract_hacker_phone_payment_phase_completion", [ "tablet_index", player.var_d8f8cc0486eccd5e[ "tabletIndex" ], "total_payout_value", player.var_d8f8cc0486eccd5e[ "totalPayout" ], "cash_per_payout", player.var_d8f8cc0486eccd5e[ "payoutValue" ], "stopped_by_match_end", var_85f0bd4d991741a, "stopped_by_disconnect", var_805b233fcebc3306, "payout_extended", payoutextended ] );
        player.var_d8f8cc0486eccd5e = undefined;
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x4c586042, Offset: 0x2ba9
// Size: 0x19
function function_63262a672fe34388( player )
{
    function_76c19f78121ebe32( player, 0, 1, 0 );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xc464d23a, Offset: 0x2bca
// Size: 0x30
function function_39a68d840e283dd8( teamname )
{
    self endon( #"hash_bcf5c7a076264d1d" );
    level waittill( #"game_ended" );
    function_8e88cc2537a846d6( teamname, 1 );
}

// Namespace br_hacker_phone_quest
// Params 3
// Checksum 0x29daed93, Offset: 0x2c02
// Size: 0xb9
function function_5a0cef6e706aa69e( teamname, var_4aa76ff09e8017ae, var_1a92d5b7f05df90d )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    packedvalue = function_faa31184f0628af3( var_4aa76ff09e8017ae );
    
    foreach ( player in playersonteam )
    {
        player setclientomnvar( var_1a92d5b7f05df90d, packedvalue );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xf462f42d, Offset: 0x2cc3
// Size: 0x42
function function_faa31184f0628af3( var_4aa76ff09e8017ae )
{
    packedvalue = 0;
    
    for ( i = 0; i < var_4aa76ff09e8017ae.size ; i++ )
    {
        packedvalue += var_4aa76ff09e8017ae[ i ] << i * 16;
    }
    
    return packedvalue;
}

// Namespace br_hacker_phone_quest
// Params 2
// Checksum 0xfa7581d2, Offset: 0x2d0e
// Size: 0x8f
function function_fb301c73f666fe9c( closestphone, player )
{
    if ( function_bfdaee73858e4f26( closestphone, player.team ) )
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
    
    if ( closestphone.tablettype.ref == "hacker_phone" )
    {
        player function_b5e27f778ef42e0e();
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x8eee25a0, Offset: 0x2da5
// Size: 0x9a
function function_b5324ed349f5ea37()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_b5e27f778ef42e0e();
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0xfef3e1ec, Offset: 0x2e47
// Size: 0x8d
function function_3696c4f50b8660c0()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_b5e27f778ef42e0e();
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0xcf26c4f4, Offset: 0x2edc
// Size: 0x9a
function function_be017604e50ab2b6()
{
    level endon( #"game_ended" );
    level waittill( #"hash_b9088a339513058d" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_b5e27f778ef42e0e();
        }
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0x9ed9ad87, Offset: 0x2f7e
// Size: 0x92
function function_b5e27f778ef42e0e()
{
    var_f4323195d896ce2e = function_d9f029bfd94e972a( self.team );
    var_a77d2a27deee2430 = var_f4323195d896ce2e * level.hackerphone.payoutcount;
    
    if ( br_publicevents::ispubliceventoftypeactive( %"contractor" ) )
    {
        var_a77d2a27deee2430 = var_f4323195d896ce2e * level.hackerphone.payoutcount * level.br_pe_data[ %"contractor" ].var_2371647dff4b6751;
    }
    
    self setclientomnvar( "ui_br_hacker_phone_potential_cash_value", var_a77d2a27deee2430 );
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0xca73a396, Offset: 0x3018
// Size: 0x33
function function_371a1a7a67c55dc7( teamname )
{
    if ( level.teamdata[ teamname ][ "hackerPhonePaymentCountActive" ] > 1 )
    {
        return "fly_pickup_cash_med_01";
    }
    
    return "fly_pickup_cash_01";
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x783cfa2d, Offset: 0x3053
// Size: 0x2a
function function_f91cdac8bffddf2a( params )
{
    if ( self.var_d7c6c2a492dda544 )
    {
        self.var_d7c6c2a492dda544 = undefined;
        thread function_6706b814727fa901( self );
    }
}

// Namespace br_hacker_phone_quest
// Params 1
// Checksum 0x5ec7e10c, Offset: 0x3085
// Size: 0x36
function function_6706b814727fa901( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    wait 1;
    br_contract_manager::displayplayersplash( player, "br_hacker_phone_quest_payment_expired" );
}

// Namespace br_hacker_phone_quest
// Params 3
// Checksum 0xf8d0b904, Offset: 0x30c3
// Size: 0x6f
function quest_onplayerteardown( player, oldteam, newteam )
{
    player.canhackcontracts = undefined;
    player.var_d7c6c2a492dda544 = undefined;
    player setclientomnvar( "ui_br_hacker_phone_state", 0 );
    
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    player setclientomnvar( "ui_br_hacked_phones_data1", 0 );
    player setclientomnvar( "ui_br_hacked_phones_data2", 0 );
}

// Namespace br_hacker_phone_quest
// Params 3
// Checksum 0x3cbb4d1b, Offset: 0x313a
// Size: 0x9d
function quest_onplayerassimilated( player, oldteam, newteam )
{
    if ( br_contract_manager::function_c0bc7ce931921c06( player ) )
    {
        player.canhackcontracts = 1;
        player br_contract_manager::uiobjectiveshow( "hacker_phone" );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        player setclientomnvar( "ui_br_hacker_phone_state", 2 );
        player br_contract_manager::uiobjectivesetparameter( self.var_5fff89b8a8a5275c, function_74a499a320255c30() );
        br_contract_manager::showquestobjicontoplayer( player );
        function_b1ff2c2ce1c9f270( player, player.team );
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0xe34c3737, Offset: 0x31df
// Size: 0x34
function function_30e1c8272073cbc1()
{
    contract = self;
    
    if ( isdefined( contract.var_317cb22c817030c5 ) )
    {
        return contract.var_317cb22c817030c5.origin;
    }
}

// Namespace br_hacker_phone_quest
// Params 0
// Checksum 0xeee33d70, Offset: 0x321c
// Size: 0x35, Type: bool
function function_ea6b677a9aef07dd()
{
    hackablecontracts = level.contractmanager.activetablets;
    
    if ( hackablecontracts.size < self.var_c7c39713542d5360 )
    {
        return false;
    }
    
    return true;
}

