// scripts\mp\common\supers\super_contract_skipper.gsc  (hash_6e8d03035b87adf6.gscc) (size: 5666 Bytes / 0x1622 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d0e6a8f (1829661327)
// size ...... 5666 (0x1622)
// includes .. 16  (offset: 0x13d2)
// strings ... 35  (offset: 0x1452)
// dev strs .. 0   (offset: 0x1622)
// exports ... 12  (offset: 0xc0e)
// cseg ...... 0x349 + 0x8c5 (0xc0e)
// imports ... 51  (offset: 0xdee)
// animtree1 . 0   (offset: 0x1622)
// animtree2 . 0   (offset: 0x1622)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_hacker_phone_quest;
#using scripts\mp\br\gametypes\br_intel_quest;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hud_message;
#using scripts\mp\supers;

#namespace super_contract_skipper;

// Namespace super_contract_skipper
// Params 0, eflags: 0x5
// Checksum 0xafd0ceb7, Offset: 0x367
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"br_contract_skipper", undefined, undefined, &post_main );
}

// Namespace super_contract_skipper
// Params 0
// Checksum 0xe9823514, Offset: 0x388
// Size: 0xab
function post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( !getdvarint( @"hash_63ecf319164aa7c2", 1 ) )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        return;
    }
    
    level callback::add( #"register_super", &function_eaf810a5813f8c47 );
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
    
    level.contractskipper = spawnstruct();
    level.contractskipper.var_123f39cf5c29f2c1 = getdvarint( @"hash_434db37e194f878a", 0 );
}

// Namespace super_contract_skipper
// Params 1
// Checksum 0xb938d008, Offset: 0x43b
// Size: 0xce
function function_eaf810a5813f8c47( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_contract_skipper" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    utility::registersharedfunc( #"super_contract_skipper", #"beginuse", &function_94a066006a40e28b );
    utility::registersharedfunc( #"super_contract_skipper", #"enduse", &function_993288d72d92a89f );
    utility::registersharedfunc( #"super_contract_skipper", #"ongive", &function_33d19532e0eced9b );
    utility::registersharedfunc( #"super_contract_skipper", #"unset", &function_d7ebc562ea0890a8 );
}

// Namespace super_contract_skipper
// Params 0
// Checksum 0xe34348eb, Offset: 0x511
// Size: 0x23
function function_94a066006a40e28b()
{
    player = self;
    result = player function_8a90b61ae014c775();
    return result;
}

// Namespace super_contract_skipper
// Params 0
// Checksum 0x91237a0a, Offset: 0x53d
// Size: 0x1c
function function_993288d72d92a89f()
{
    player = self;
    player setclientomnvar( "ui_field_upgrade_use", 0 );
}

// Namespace super_contract_skipper
// Params 4
// Checksum 0xba4c7e30, Offset: 0x561
// Size: 0x9d
function function_33d19532e0eced9b( equipmentref, equipmentslot, variantid, attachments )
{
    player = self;
    
    if ( isdefined( self.super ) && isdefined( self.super.staticdata ) && isdefined( self.super.staticdata.id ) )
    {
        supers_mp::function_2ea603a86a682ab0( self.super.staticdata.id );
    }
}

// Namespace super_contract_skipper
// Params 0
// Checksum 0x77a1c31e, Offset: 0x606
// Size: 0x17
function function_d7ebc562ea0890a8()
{
    player = self;
    supers_mp::function_2ea603a86a682ab0( 0 );
}

// Namespace super_contract_skipper
// Params 0
// Checksum 0x4889163c, Offset: 0x625
// Size: 0x137
function function_8a90b61ae014c775()
{
    player = self;
    task = br_contract_manager::function_28779161e0912456( player br_contract_manager::function_6b738bc71eb53bd4() );
    
    if ( !isdefined( task ) )
    {
        player hud_message::showerrormessage( %"hash_269782a22360530f" );
        player playlocalsound( "fly_pickup_deny" );
        return;
    }
    
    if ( isdefined( task.contracttotaltime ) && level.contractskipper.var_123f39cf5c29f2c1 > 0 )
    {
        var_4a0a625c1e05f70b = int( ( gettime() - task.missiontime - task.contracttotaltime * 1000 ) / 1000 );
        
        if ( var_4a0a625c1e05f70b < level.contractskipper.var_123f39cf5c29f2c1 )
        {
            player hud_message::showerrormessage( %"hash_739e909e5d36e42b", int( level.contractskipper.var_123f39cf5c29f2c1 - var_4a0a625c1e05f70b ) );
            player playlocalsound( "fly_pickup_deny" );
            return;
        }
    }
    
    objweapon = makeweapon( "emp_pulse_device_mp" );
    deploysuccess = weapon_utility::giveandfireoffhandreliable( objweapon );
    
    if ( deploysuccess )
    {
        return player function_c2e0e867dd6023f2( task );
    }
    
    return supers_mp::refundsuper();
}

// Namespace super_contract_skipper
// Params 1
// Checksum 0x91c6d94, Offset: 0x764
// Size: 0x52, Type: bool
function function_c2e0e867dd6023f2( task )
{
    player = self;
    player setclientomnvar( "ui_super_ddos_screen_on", 1 );
    time = getdvarfloat( @"hash_f291eccacb78a528", 0.5 );
    wait time;
    player thread function_fbf2037b85a657ea( task );
    return true;
}

// Namespace super_contract_skipper
// Params 1
// Checksum 0x13ed39e1, Offset: 0x7bf
// Size: 0x351
function function_fbf2037b85a657ea( task )
{
    player = self;
    contractname = "unknown";
    
    switch ( br_contract_manager::function_e01c7810f3c75f0b( task.type.ref ) )
    {
        case 1:
            rewards = task br_contract_manager::function_83f627106ef43736( "assassin_target_killed", task.var_fe0156f1cf4e5f41 );
            
            if ( isdefined( rewards ) && isdefined( rewards[ "plunder" ] ) )
            {
                task br_contract_manager::function_1f816e3c3465df7e( "br_assassination_complete_hunters_win", 1, rewards[ "plunder" ] );
            }
            
            level thread br_public::brleaderdialogteam( "mission_ass_success", player.team, 1, 1 );
            task thread br_assassination_quest::function_72168f47af498225( 1, rewards, "ContractSkipped" );
            contractname = "bounty";
            break;
        case 2:
            br_quest_util::displaysquadmessagetoteam( task.team, player, 8, br_quest_util::getquestindex( "scavenger" ) );
            task br_scavenger_quest::dialog_play( "scavenger_missioncomplete" );
            rewards = task br_contract_manager::function_7d7e225a8f9c9222( "scavenger", player );
            task thread br_scavenger_quest::function_9e6c6f406c9b58f2( 1, rewards, "ContractSkipped" );
            task br_scavenger_quest::dialog_play( "mission_scav_success", "dx_br_jpbm_" );
            br_scavenger_quest::function_a11543dab390af1a( player, 1, 3 - task.cachescollected );
            contractname = "scavenger";
            break;
        case 3:
            task br_vip_quest::function_98f36a120cf3744b();
            level thread br_public::brleaderdialogteam( "mission_hvt_success_third_person", player.team, 1, 1 );
            contractname = "most_wanted";
            break;
        case 5:
            if ( !isdefined( task.capturingplayer ) )
            {
                task.capturingplayer = player;
            }
            
            task br_intel_quest::function_dd72e973244442d1( player.team );
            level thread br_public::brleaderdialogteam( "mission_intel_success", player.team, 1, 1, undefined, "dx_br_jpbm_" );
            contractname = "intel";
            break;
        case 10:
            task br_hacker_phone_quest::function_dd72e973244442d1( 1, "Win" );
            level thread br_public::brleaderdialogteam( "hacker_phone_complete", player.team, 1, 1, undefined, "dx_br_bds4_" );
            contractname = "hacker_phone";
            break;
        case 11:
            rewards = task br_contract_manager::function_83f627106ef43736( "master_assassin_target_killed", task.var_fe0156f1cf4e5f41 );
            
            if ( isdefined( rewards ) && isdefined( rewards[ "plunder" ] ) )
            {
                task br_contract_manager::function_1f816e3c3465df7e( "br_master_assassination_complete_hunters_win", 11, rewards[ "plunder" ] );
            }
            
            task thread br_assassination_quest::function_72168f47af498225( 1, rewards, "ContractSkipped" );
            level thread br_public::brleaderdialogteam( "mission_master_ass_success", player.team, 1, 1 );
            contractname = "big_game_bounty";
            break;
        default:
            hud_message::showerrormessage( %"hash_680da8978e63fbbb" );
            player playlocalsound( "fly_pickup_deny" );
            br_pickups::_givebrsuper( "equip_emppulse", "super_contract_skipper", 1 );
            break;
    }
    
    var_4a0a625c1e05f70b = gettime() - task.missiontime - task.contracttotaltime * 1000;
    player function_64e64210c17a9fda( contractname, var_4a0a625c1e05f70b );
}

// Namespace super_contract_skipper
// Params 2
// Checksum 0x672807ab, Offset: 0xb18
// Size: 0xf6
function function_64e64210c17a9fda( contractname, var_4a0a625c1e05f70b )
{
    player = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = level.mapname;
    eventparams[ eventparams.size ] = "circle_index";
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "contract_name";
    eventparams[ eventparams.size ] = contractname;
    eventparams[ eventparams.size ] = "contract_current_time";
    eventparams[ eventparams.size ] = int( var_4a0a625c1e05f70b / 1000 );
    eventparams[ eventparams.size ] = "use_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 );
    player dlog_recordplayerevent( "dlog_event_br_contract_skipper", eventparams );
}

