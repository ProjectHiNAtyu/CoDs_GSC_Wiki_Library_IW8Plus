// scripts\mp\br\gametypes\br_gametype_bongo.gsc  (hash_4cf2f0ada9bfa864.gscc) (size: 53689 Bytes / 0xd1b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe62b805 (4267882501)
// size ...... 53689 (0xd1b9)
// includes .. 70  (offset: 0xc3f9)
// strings ... 199 (offset: 0xc629)
// dev strs .. 17  (offset: 0xd0e5)
// exports ... 143 (offset: 0x7b71)
// cseg ...... 0x123d + 0x6934 (0x7b71)
// imports ... 409 (offset: 0x91c9)
// animtree1 . 0   (offset: 0xd1b9)
// animtree2 . 0   (offset: 0xd1b9)
#using script_149ff34eed9c940e;
#using script_239a365a92ee4476;
#using script_2498b7c75f1dee2d;
#using script_3953cae29477fdd4;
#using script_61b40095fd0502f0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ae_utility;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\devgui;
#using scripts\common\mega_jump;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\ai\ai_category;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\armor;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_staged_items;
#using scripts\mp\br\weapons\br_monkey_bomb;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\equipment\health_kit;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_aether_upgrade;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_killstreak;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\mp_gameskill;
#using scripts\mp\ob\systems\ob_analytics_activity;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace br_gametype_bongo;

// Namespace br_gametype_bongo
// Params 0, eflags: 0x5
// Checksum 0xc576e0fa, Offset: 0x125b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"bongo_ftue", #"br_ftue", undefined, &register_ftue );
}

// Namespace br_gametype_bongo
// Params 0
// Checksum 0x7b5c11bf, Offset: 0x1284
// Size: 0x144
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
    lui_game_event_aggregator::registeronluieventcallback( &luinotifylistener );
    level.onplayerconnect = &onplayerconnect;
    level.modeloadoutupdateammo = &brloadoutupdateammo;
    create_script_utility::initialize_create_script();
    level thread ai_mp_controller::function_71bf1a00b0b8d267();
    utility::flag_wait( "ai_spawn_director_initialized" );
    level.totalspawnedai = 0;
    level.var_1e9432f20e98727f = 0;
    ai_spawn_director::function_c83497dcedebe189( &function_f7ca46b47cd383c6 );
    level.var_129ae32cb395a9b2 = 1;
    level thread activity_bongo_cradle_gas_bomb::init();
    namespace_775af9b7afedb6d1::init_scaling_health( 3 );
    entitymask = createentitytypemask( [ "etype_ai", "etype_vehicle", "etype_turret", "etype_scriptmover" ] );
    utility::callsharedfunc( #"zombie_health_bar", #"init", entitymask );
    weapons::deregisterusedcallback( "decoy_grenade" );
    weapons::registerusedcallback( "decoy_grenade", &function_12d3e6293a73c2b );
    br_monkey_bomb::init();
    
    if ( isdefined( level.var_d75b25dcd841b686 ) )
    {
        [[ level.var_d75b25dcd841b686 ]]();
    }
    
    level thread br_staged_items::init();
    level.brgametype.dialogprefix = "dx_br_brbm_";
}

// Namespace br_gametype_bongo
// Params 0
// Checksum 0xa5bf3cdd, Offset: 0x13d0
// Size: 0x64e
function init()
{
    br_gametypes::disablefeature( #"hash_5aaafc2b620d773c" );
    br_gametypes::enablefeature( #"hash_7a655b41b7ab5262" );
    setdvar( @"hash_f8822db2f03f2db2", 1 );
    utility::registersharedfunc( #"gametype", #"hash_e1a48c13a7e1e696", &onstartgametype );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"telemetry", #"hash_c2ff97bbe61f0a3f", &function_4b3f03861f9d84f2 );
    utility::registersharedfunc( #"challenges", #"hash_8c96973f38ba6767", &function_b023f79a238af6c2 );
    utility::registersharedfunc( #"challenges", #"reportweaponupgrade", &reportweaponupgrade );
    utility::registersharedfunc( #"challenges", #"hash_f7f21e7a2c2c67a4", &function_802cd3977a14218f );
    utility::registersharedfunc( #"challenges", #"hash_3a656de5d74b8c5", &function_6b45ab0efdcc9f96 );
    utility::registersharedfunc( #"dawg", #"hash_dcb19f7ac172bc76", &function_a6cc0e69a3ee461f );
    
    if ( getdvarint( @"hash_96c7a6018b4d886", 1 ) )
    {
        level callback::add( #"on_super_use_finished", &function_68200d5bc659c0d5 );
        level callback::add( #"equipment_use_success", &function_7a1543ba502d0376 );
        level callback::add( #"killstreak_removed", &function_dc24ba8ef5faebe8 );
    }
    
    if ( getdvarint( @"hash_fc996f940e123cef", 0 ) )
    {
        level callback::add( #"hash_aa7c0dbef3e86ee4", &function_21410e464931875c );
    }
    
    if ( getdvarint( @"hash_9a24546b5ffd8cf3", 0 ) != 1 )
    {
        level callback::add( "bongo_cradle_gas_expanding", &function_5f6d33567e962f8b );
    }
    
    if ( getdvarint( @"hash_d525cd4753d86dfe", 1 ) )
    {
        utility::registersharedfunc( #"gametype", #"hash_4d30403ee025b771", &function_493fcd4e3e24cba1 );
    }
    
    if ( getdvarint( @"hash_9437eaeb2611bed", 1 ) )
    {
        events::function_b8b24a291af69f1d();
        level.var_2365b76f19ea37ea = &function_2365b76f19ea37ea;
    }
    
    if ( getdvarint( @"hash_b93dc42c107f8ad4", 0 ) == 1 )
    {
        setomnvar( o"ui_br_resurgence_respawn_enabled", 1 );
        level.brgametype.respawnenable = 1;
        level.respawndelay = getdvarint( @"scr_bongo_respawn_delay", 90 );
        level.var_528d678aa54b1f26 = getdvarint( @"hash_9ad97ad901e22d7e", 2 );
        level.var_8690dec2acaf2b3 = getdvarint( @"hash_b10c1f8e0655fd6e", 1 ) == 1;
        
        if ( level.var_8690dec2acaf2b3 )
        {
            level.var_be7dc7b1a3809a1f = getdvarint( @"hash_5d2fe8129b7c8f5d", 1 ) == 1;
        }
        
        utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
        utility::registersharedfunc( #"gametype", #"hash_1de385892cb526fe", &playergulagautowinwait );
        utility::registersharedfunc( #"gametype", #"playerkilledspawn", &playerkilledspawn );
        utility::registersharedfunc( #"gametype", #"triggerrespawnoverlay", &triggerrespawnoverlay );
        utility::registersharedfunc( #"gametype", #"onspawnplayer", &onspawnplayer );
        utility::registersharedfunc( #"gametype", #"hash_7441ed4c82dce578", &function_358fbfe7ed4ab979 );
        callback::add( #"player_item_pickup", &function_a9cc756d803543a5 );
    }
    
    level.var_9455be8dc926ce7b = getdvarint( @"hash_f851134f5e3344b3", 0 );
    
    if ( level.var_9455be8dc926ce7b == 1 )
    {
        level.var_2a04d6af4dc510d7 = getdvarint( @"hash_a43964299f2fe76c", 4 );
        level.var_8adaef60fe79cdc3 = getdvarint( @"hash_3d2b1d3e5437b7d4", 0 ) == 1;
    }
    
    level callback::add( #"player_weapon_change", &function_77fd0cdd4306c912 );
    level callback::add( #"player_weapon_take", &function_ffc8fdaddd15f3a9 );
    level callback::add( "zombie_melee_pre", &function_15ca8eb0cb0049bc );
    level callback::add( "GuildBotInitOverride", &function_b7d9926f8689a93d );
    level callback::add( #"player_death", &function_b1aba1b51a0d44d7 );
    level callback::add( #"player_disconnect", &function_b1aba1b51a0d44d7 );
    level callback::add( #"on_ai_killed", &onagentkilled );
    level callback::add( #"hash_ab3afa9c65b57dc9", &function_ce8b77c5f4063e91 );
    level callback::add( #"player_used_item", &function_b424b66bf9048ab0 );
    level callback::add( #"on_used_super", &function_7c22a3bc6a315a9b );
    level callback::add( #"hash_6d84bb11b9d0a738", &function_e82f7ede9c660f85 );
    utility::registersharedfunc( #"br_infils", #"hash_f3c68636c0e494a1", &function_be334704d96df6b0 );
    utility::registersharedfunc( #"gametype", #"hash_7af8e4ae0ab0a773", &function_c3daa1416b99eb6a );
    utility::registersharedfunc( #"bongo", #"hash_e4108d66df2f65d3", &function_3b4bee4a10e4fc72 );
    utility::registersharedfunc( #"bongo", #"hash_ccf830b44797af61", &function_38da480cae458734 );
    utility::registersharedfunc( #"bongo", #"hash_bcaa98394557d852", &function_12c802b01c13329 );
    utility::registersharedfunc( #"dawg", #"hash_70fa1fdad51f3de7", &function_ecb37cd67f5ac146 );
    utility::registersharedfunc( #"br_activity", #"hash_bcbfb56578aa60e", &function_6eaff88c5aa159fc );
    utility::registersharedfunc( #"gametype", #"hash_f9e2fd3c47c40374", &function_ecba7a34dc3dca21 );
    
    if ( getdvarint( @"hash_ab9d174ee749fb7c", 1 ) )
    {
        utility::registersharedfunc( #"common_item_weapon", #"hash_79fad35fafa507cc", &function_5bb506241fcceb23 );
        utility::registersharedfunc( #"common_item_weapon", #"hash_a09b97b1335d2c79", &function_1436202e0ca47ce4 );
    }
    
    thread function_8477f14dd10fca72();
    thread function_3a9fbc1e338ab1dc();
    thread overridedialog();
    utility::callsharedfunc( #"bongo", #"init_ltm" );
    
    /#
        registerdevgui();
        thread function_b8f8a2460061c23e();
    #/
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x4efa5d61, Offset: 0x1a26
// Size: 0x26f
function private overridedialog()
{
    level waittill( #"hash_bb95e0eb0e85637" );
    game[ "dialog" ][ "gametype" ] = "";
    game[ "dialog" ][ "primary_objective" ] = "sabm_wzba_boio";
    game[ "dialog" ][ "circle_closing" ] = "sabm_wzba_bogc";
    game[ "dialog" ][ "final_circle" ] = "sabm_wzba_bofc";
    game[ "dialog" ][ "deploy_squad_leader" ] = "sabm_wzba_botl";
    game[ "dialog" ][ "respawning_enemy_in_area" ] = "sabm_wzba_boeo";
    game[ "dialog" ][ "team_victory" ] = "sabm_wzba_bogw";
    game[ "dialog" ][ "team_loss" ] = "";
    game[ "dialog" ][ "last_man_standing" ] = "sabm_wzba_boms";
    game[ "dialog" ][ "prematch_end" ] = "sabm_wzba_boed";
    game[ "dialog" ][ "prematch_enter" ] = "sabm_wzba_boer";
    game[ "dialog" ][ "top_10" ] = "sabm_wzba_bote";
    game[ "dialog" ][ "top_2" ] = "sabm_wzba_botw";
    game[ "dialog" ][ "top_25" ] = "sabm_wzba_botf";
    game[ "dialog" ][ "top_5" ] = "sabm_wzba_bofi";
    game[ "dialog" ][ "offense_obj" ] = "";
    game[ "dialog" ][ "defense_obj" ] = "";
    game[ "dialog" ][ "obj_extraction" ] = "";
    game[ "dialog" ][ "first_circle" ] = "";
    game[ "dialog" ][ "new_circle" ] = "";
    game[ "dialog" ][ "match_start" ] = "";
    game[ "dialog" ][ "supply_drop_incoming" ] = "";
    game[ "dialog" ][ "top_3" ] = "";
    game[ "dialog" ][ "top_50" ] = "";
    game[ "dialog" ][ "top_5_lose" ] = "";
    game[ "dialog" ][ "top_10_lose" ] = "";
    game[ "dialog" ][ "top_25_lose" ] = "";
    game[ "dialog" ][ "finish_calls" ] = "";
    game[ "dialog" ][ "br_sitrep_circle_in" ] = "";
    game[ "dialog" ][ "br_sitrep_circle_mixed" ] = "";
    game[ "dialog" ][ "br_sitrep_circle_out" ] = "";
    game[ "dialog" ][ "br_sitrep_circle_outfar" ] = "";
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2077a4fb, Offset: 0x1c9d
// Size: 0x55
function private function_6eaff88c5aa159fc( activityinstance )
{
    activitytype = activityinstance.type;
    activityorigin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    activityinstanceid = activityinstance.id;
    br_analytics::function_b63e427a9d8c7f20( activitytype, activityorigin, activityinstanceid );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x759e05b8, Offset: 0x1cfa
// Size: 0x46
function private function_8477f14dd10fca72()
{
    level waittill( #"br_shared_funcs_init" );
    utility::registersharedfunc( #"player", #"isPlayerWaitingResurgenceRespawn", &function_d21c5807836ea93c );
    utility::callsharedfunc( #"bongo", #"hash_e438fed9d0ae7675" );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x1f4cf8b9, Offset: 0x1d48
// Size: 0x1d, Type: bool
function private function_d5837527917f714c( player )
{
    return !item_redeploy_token::items_respawntokendisabled() && item_redeploy_token::function_6932ae7663f88c8e();
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xaa8682a9, Offset: 0x1d6e
// Size: 0xa, Type: bool
function private markplayeraseliminatedonkilled()
{
    return !function_d5837527917f714c( self );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x41378608, Offset: 0x1d81
// Size: 0x1c
function private function_3a9fbc1e338ab1dc()
{
    utility::flag_wait( "activity_nexus_init_complete" );
    activity_common::function_9fd46b47e0d8481d( 6, &function_80549647da0bf11d );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xbf78ad83, Offset: 0x1da5
// Size: 0x77, Type: bool
function private function_e82f7ede9c660f85( params )
{
    oldweapon = params.oldweapon;
    newweapon = params.newweapon;
    var_160c7928ef9a8280 = item_weapon::function_a23ea7289efe03ed( oldweapon );
    var_5e349add54e29fab = item_weapon::function_a23ea7289efe03ed( newweapon );
    
    if ( var_160c7928ef9a8280 && var_5e349add54e29fab )
    {
        if ( item_aether_upgrade::function_2e03bb7a00789440( var_160c7928ef9a8280, var_5e349add54e29fab ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x8f6e33cf, Offset: 0x1e25
// Size: 0x232
function function_493fcd4e3e24cba1( params )
{
    activityinstance = params.activityinstance;
    scoreeventoverride = params.scoreeventoverride;
    exp = params.exp;
    
    if ( isdefined( activityinstance.parentactivity ) )
    {
        var_332f929de1894b2b = activityinstance.parentactivity.var_332f929de1894b2b;
    }
    else if ( isdefined( activityinstance ) )
    {
        var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    }
    
    if ( !isdefined( exp ) )
    {
        exp = var_332f929de1894b2b.var_eee681d9591bb1a1 ?? 0;
    }
    
    scoreevent = #"hash_376a621453a0fd19";
    
    if ( isdefined( scoreeventoverride ) )
    {
        scoreevent = scoreeventoverride;
    }
    else if ( var_332f929de1894b2b.var_b7cb63381d74cf9f )
    {
        scoreevent = var_332f929de1894b2b.var_b7cb63381d74cf9f;
    }
    
    if ( isdefined( params.player ) )
    {
        player = params.player;
        player thread points::doscoreevent( scoreevent, undefined, undefined, exp, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
        weaponxp = int( exp * 0.2 );
        lastweaponobj = player.lastnormalweaponobj;
        player br::givebrweaponxp( #"", weaponxp, lastweaponobj, 0, 0 );
        return;
    }
    
    var_86737cbe11bf496e = activityinstance.var_86737cbe11bf496e ?? [];
    
    foreach ( player in var_86737cbe11bf496e )
    {
        player thread points::doscoreevent( scoreevent, undefined, undefined, exp, undefined, undefined, undefined, undefined, undefined, undefined, { #var_ef32324b503188b8:1 } );
        weaponxp = int( exp * 0.2 );
        lastweaponobj = player.lastnormalweaponobj;
        player br::givebrweaponxp( #"", weaponxp, lastweaponobj, 0, 0 );
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x986392d4, Offset: 0x205f
// Size: 0x9
function private onstartgametype()
{
    function_8ea16ca3f07fde8f();
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x40e6aad1, Offset: 0x2070
// Size: 0x19f
function private brloadoutupdateammo( loadoutweapons )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        br::brloadoutupdateammo( loadoutweapons );
        return;
    }
    
    magcount = getdvarint( @"hash_2c0326036764dcc0", 2 );
    ammotypes = item_ammo::function_66fcda3aac586229();
    var_232857ed7c70890f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73() : undefined;
    var_4375d83555c8dd6f = var_232857ed7c70890f[ 0 ];
    var_ac9ac87f293120e4 = var_232857ed7c70890f[ 1 ];
    backpacksize = common_inventory::function_9cd65c8312048802();
    var_a296fd8f25166c9c = function_2b4e5bd4aec17046( ammotypes, var_4375d83555c8dd6f, var_ac9ac87f293120e4, backpacksize );
    
    foreach ( ammotype in ammotypes )
    {
        var_8bb1b2bde27b267c = magcount * item_ammo::function_b956ec34b65538e( ammotype );
        item = { #count:var_8bb1b2bde27b267c, #type:ammotype };
        bundle = common_item::function_80af1e9daffacc7d( ammotype );
        bundlename = common_item::function_e044c3e813daec3a( bundle );
        var_6ecc64ede36ab68 = undefined;
        
        if ( var_a296fd8f25166c9c )
        {
            var_6ecc64ede36ab68 = var_a296fd8f25166c9c.var_66e476b922e17668[ ammotype ];
        }
        
        common_inventory::function_1a85f583119d9740( bundlename, bundle, item, undefined, undefined, undefined, var_6ecc64ede36ab68 );
    }
}

// Namespace br_gametype_bongo
// Params 4, eflags: 0x4
// Checksum 0x8fe38d1d, Offset: 0x2217
// Size: 0x151
function private function_2b4e5bd4aec17046( ammotypes, var_4375d83555c8dd6f, var_ac9ac87f293120e4, backpacksize )
{
    if ( !( isdefined( var_4375d83555c8dd6f ) && isdefined( var_ac9ac87f293120e4 ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_30275ba2c64712f3 ) )
    {
        level.var_30275ba2c64712f3 = [];
    }
    
    if ( !isdefined( level.var_30275ba2c64712f3[ var_ac9ac87f293120e4 ] ) )
    {
        level.var_30275ba2c64712f3[ var_ac9ac87f293120e4 ] = [];
    }
    
    cacheentry = level.var_30275ba2c64712f3[ var_ac9ac87f293120e4 ][ backpacksize ];
    
    if ( cacheentry )
    {
        return cacheentry;
    }
    
    var_66e476b922e17668 = [];
    
    foreach ( ammotype in ammotypes )
    {
        ammobundle = common_item::function_80af1e9daffacc7d( ammotype );
        
        if ( !ammobundle )
        {
            continue;
        }
        
        ammoslots = common_inventory_groups::function_9cfb83fd532b7894( ammobundle, var_4375d83555c8dd6f, backpacksize );
        var_66e476b922e17668[ ammotype ] = ammoslots;
    }
    
    cacheentry = { #var_66e476b922e17668:var_66e476b922e17668 };
    level.var_30275ba2c64712f3[ var_ac9ac87f293120e4 ][ backpacksize ] = cacheentry;
    return cacheentry;
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x7f69fc70, Offset: 0x2371
// Size: 0x57
function private function_8ea16ca3f07fde8f()
{
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &ob_analytics_activity::function_48061001a97cc2f8 );
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &ob_analytics_activity::on_activity_complete );
    activity_common::function_2dd4f07fa5c3e911( "ActivityFailure", &ob_analytics_activity::on_activity_failed );
    activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &ob_analytics_activity::on_activity_begin );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &ob_analytics_activity::function_4b55ce0113456ec6 );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x35aa9873, Offset: 0x23d0
// Size: 0x111
function private function_4b3f03861f9d84f2()
{
    player = self;
    is_prematch = gamelogic_mp::inprematch();
    player dlog_recordplayerevent( "dlog_event_blackout_player_match_end_supp", [ "activities_completed", player.endmatchstats[ "activitiesCompleted" ] ?? 0, "mystery_boxes_opened", player.endmatchstats[ "mysteryBoxesOpened" ] ?? 0, "teammates_resdeployed", player.endmatchstats[ "teammatesRedeployed" ] ?? 0, "weapon_upgrades_used", player.endmatchstats[ "weaponUpgradesUsed" ] ?? 0, "special_enemies_killed", player.endmatchstats[ "specialEnemiesKilled" ] ?? 0, "survival_time", isdefined( level.starttime ) ? gettime() - level.starttime : 0, "is_prematch", is_prematch ] );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x3790fff, Offset: 0x24ea
// Size: 0x13, Type: bool
function private function_d21c5807836ea93c()
{
    return !isalive( self ) && function_d5837527917f714c( self );
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0xe1261dc6, Offset: 0x2506
// Size: 0x1a1
function function_b023f79a238af6c2( activityinstance )
{
    keyname = #"activity_type";
    
    switch ( activityinstance.type )
    {
        case #"hash_73504feb2e27bfdd":
            return ae_utility::function_2d1565a236387b2( keyname, #"guild_drone" );
        case #"hash_b20ba2ef3cf75a10":
            return ae_utility::function_2d1565a236387b2( keyname, #"safecracker" );
        case #"hash_d7e979cafde512e1":
            return ae_utility::function_2d1565a236387b2( keyname, #"mangler" );
        case #"hash_4d5fd8a7d49e24cb":
            return ae_utility::function_2d1565a236387b2( keyname, #"surprise_shipment" );
        case #"hash_9f0c3ab8804734ea":
            if ( istrue( activityinstance.var_32736e4d8d0785dc ) )
            {
                return ae_utility::function_2d1565a236387b2( keyname, #"hop_vehicle_bounty" );
            }
            
            return ae_utility::function_2d1565a236387b2( keyname, #"target_uplink" );
        case #"hash_5d8504eeea9b13c":
            return ae_utility::function_2d1565a236387b2( keyname, #"care_package_drop" );
        case #"hash_795c80924c32a4f5":
            owningactivity = activity_instance_common::function_a45920af4495e9f( self ).owningactivity;
            
            if ( !isdefined( owningactivity ) )
            {
                return;
            }
            
            switch ( owningactivity.type )
            {
                case #"hash_a017438730c08880":
                    return ae_utility::function_2d1565a236387b2( keyname, #"relay_antenna" );
                case #"hash_ad6cd9fa15067b56":
                    return ae_utility::function_2d1565a236387b2( keyname, #"redeploy_tower" );
                default:
                    return;
            }
        default:
            return;
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xe37eba77, Offset: 0x26af
// Size: 0x43
function private function_802cd3977a14218f( player, lootcachebitfield )
{
    if ( player activity_bongo_cradle_gas_bomb::function_1cb6b6bbdfc6eee7() )
    {
        return challenges::function_a23641f33e985edb( lootcachebitfield, ae_utility::function_2d1565a236387b2( #"hash_f42835693a3d7da5", #"hash_1d0178fe6b730379" ) );
    }
    
    return lootcachebitfield;
}

// Namespace br_gametype_bongo
// Params 2
// Checksum 0x3db7235d, Offset: 0x26fb
// Size: 0xa6
function function_6b45ab0efdcc9f96( var_34c4673a21bda4c, victim )
{
    if ( issubstr( victim.agent_type, "bot" ) || issubstr( victim.agent_type, "dawg" ) )
    {
        return challenges::function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"guild_robot" ) );
    }
    
    if ( issubstr( victim.agent_type, "zombie" ) )
    {
        return challenges::function_a23641f33e985edb( var_34c4673a21bda4c, ae_utility::function_2d1565a236387b2( #"hash_22d8c6e760626656", #"zombie" ) );
    }
    
    return var_34c4673a21bda4c;
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x318f4d5, Offset: 0x27a9
// Size: 0x34
function private reportweaponupgrade( player, var_ab3d86fd09bad221 )
{
    if ( !var_ab3d86fd09bad221.weaponupgradeitem )
    {
        challenges::function_37e945722d6497f3( player, "weapon_full_upgrade", 1 );
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xed062005, Offset: 0x27e5
// Size: 0x22
function private register_ftue()
{
    if ( getdvarint( @"hash_9a24546b5ffd8cf3", 0 ) != 1 )
    {
        namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_feeeaf4be5bd0641 );
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x7be9926f, Offset: 0x280f
// Size: 0x152
function private function_feeeaf4be5bd0641()
{
    ftue_tip::function_d454ba9425f5164c( 1, "bongo_ftue_activity_rewards", &function_dbace31f2ca4796a );
    ftue_tip::function_d454ba9425f5164c( 2, "bongo_ftue_armor_upgrades", &function_4691cbb4e4d170e3 );
    ftue_tip::function_d454ba9425f5164c( 3, "bongo_ftue_charging_station_reward", &function_e2d7a9351c002ce7 );
    ftue_tip::function_d454ba9425f5164c( 4, "bongo_ftue_consumable_perks", &function_e9dc4a38cbd806a9 );
    ftue_tip::function_d454ba9425f5164c( 5, "bongo_ftue_cradle_breach_far", &function_5e4a5a19255cec06, &function_5ca72d69c4792e03 );
    ftue_tip::function_d454ba9425f5164c( 6, "bongo_ftue_cradle_breach_inside", &function_86d9e36415882465, &function_5ca72d69c4792e03 );
    ftue_tip::function_d454ba9425f5164c( 7, "bongo_ftue_cradle_breach_near", &function_33a2de94d8ffe1e7, &function_5ca72d69c4792e03 );
    ftue_tip::function_d454ba9425f5164c( 8, "bongo_ftue_cradle_crates", &function_8037fd752696ce58 );
    ftue_tip::function_d454ba9425f5164c( 9, "bongo_ftue_dead_player", &function_d7b05f5c1a04b38 );
    ftue_tip::function_d454ba9425f5164c( 10, "bongo_ftue_instanced_rewards", &function_8037fd752696ce58 );
    ftue_tip::function_d454ba9425f5164c( 11, "bongo_ftue_inventory", &function_5aaa036783b984e5 );
    ftue_tip::function_d454ba9425f5164c( 12, "bongo_ftue_mangler", &function_5260053c37da3a09 );
    ftue_tip::function_d454ba9425f5164c( 13, "bongo_ftue_redeploy_systems", &function_c9a35a424570a0f1 );
    ftue_tip::function_d454ba9425f5164c( 14, "bongo_ftue_respawn_token_1", &function_5b711399865b5676 );
    ftue_tip::function_d454ba9425f5164c( 15, "bongo_ftue_respawn_token_2", &function_8037fd752696ce58 );
    ftue_tip::function_d454ba9425f5164c( 16, "bongo_ftue_weapon_builds", &function_6bb7884ae4eabac6 );
    common_item::function_5734400f32ca9803( "item_select", &function_3848129c7496491f );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x1bbe9a3c, Offset: 0x2969
// Size: 0x214
function private function_b9f7dba79c13a918( params )
{
    if ( params.itembundle.rarity != 7 || !params.itembundle.var_dd54d02596151fda )
    {
        return;
    }
    
    if ( !isdefined( level.var_b0b91d00efa5756b ) )
    {
        level.var_b0b91d00efa5756b = 0;
    }
    
    if ( params.itembundle.subtype == "ww" )
    {
        level.var_b0b91d00efa5756b += 1;
        showsplashtoall = getdvarint( @"hash_c18fa79a46c1dbaa", 1 );
        splashref = "br_bongo_cradle_breach_wonder_weapon_earned";
    }
    else
    {
        level.var_b0b91d00efa5756b += 1;
        showsplashtoall = getdvarint( @"hash_2a7fcdd764284587", 1 );
        
        if ( isdefined( params.itembundle.var_4391c2a234042527 ) && params.itembundle.var_4391c2a234042527 != "" )
        {
            splashref = params.itembundle.var_4391c2a234042527;
        }
        else
        {
            splashref = "br_bongo_cradle_breach_exotic_weapon_earned";
        }
    }
    
    var_1f6a8790110b69fb = showsplashtoall ? level.players : teams::getteamdata( self.team, "players" );
    
    foreach ( player in var_1f6a8790110b69fb )
    {
        player thread hud_message::showsplash( splashref, undefined, self );
    }
    
    var_d90fa846849344c7 = getdvarint( @"hash_3a7ad9de0be94968", 1 );
    
    if ( var_d90fa846849344c7 >= 0 && level.var_b0b91d00efa5756b >= var_d90fa846849344c7 )
    {
        magicbox::function_6f00dd035f2d8f9a( 1, 1 );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x166e1a47, Offset: 0x2b85
// Size: 0x6a
function private on_item_pickup( params )
{
    item = params.item;
    itembundle = params.itembundle;
    
    if ( itembundle && itembundle.inventoryslot == "Weapon" )
    {
        self.var_1bf06f44a37d953 = 1;
        self.lastweaponpickuptime = gettime();
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x97068124, Offset: 0x2bf7
// Size: 0x65
function private function_15ca8eb0cb0049bc( params )
{
    if ( !isvector( params.meleetarget ) && params.meleetarget.equipmentref == "equip_mini_sentry" )
    {
        params.var_948a2ae89285ee6a += getdvarint( @"hash_4f97e116995b57a9", 30 );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x982dcab9, Offset: 0x2c64
// Size: 0x17
function private function_b7d9926f8689a93d( params )
{
    self.meleedamageoverride = 100;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x6e1d0eeb, Offset: 0x2c83
// Size: 0x22, Type: bool
function private function_c3daa1416b99eb6a( data )
{
    if ( self.equipmentref == "equip_mini_sentry" )
    {
        return true;
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x62f03ef1, Offset: 0x2cae
// Size: 0x1da
function onplayerconnect( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    thread br::onplayerconnect( player );
    thread function_a77de51ace7331da( player );
    thread function_e53d35bb022dec50( player );
    thread function_69f55db548ce3cfe( player );
    thread function_831a807ed595d53d( player );
    player.gameskill = mp_gameskill::get_gameskill();
    player mp_gameskill::apply_difficulty_settings( 1 );
    
    if ( player isplayerheadless() )
    {
        falldamagenegation = getdvarint( @"hash_e64fdf9fad1f589c", 2 );
        
        if ( falldamagenegation == 1 )
        {
            player mega_jump::set_fall_damage_reduction( 1 );
        }
        else if ( falldamagenegation == 2 )
        {
            thread function_4803628655aa3aff( player );
        }
    }
    
    player currency::init_player_currency( "salvage", currency::get_start_currency_amount( "salvage" ) );
    player callback::add( "magicbox_purchase", &function_b9f7dba79c13a918 );
    player callback::add( #"player_item_pickup", &on_item_pickup );
    
    for ( i = 0; i < common_inventory::function_7d8024a0beed38ae() ; i++ )
    {
        player common_inventory::inventory_setbackpackitematindex( i, 0, 0 );
    }
    
    player childthread function_98be71c6574b03ed();
    player callback::add( "lootcache_looted", &function_977b46892e8a7d4c );
    thread function_edb27b5c85c71d5f( player );
    
    foreach ( var_3b0c06617cfe33e7 in level.var_d9a59c65e30b6e7c )
    {
        if ( var_3b0c06617cfe33e7.var_f74a60fb93085714 )
        {
            var_3b0c06617cfe33e7 function_6113853a877d5460( player );
            continue;
        }
        
        var_3b0c06617cfe33e7 function_d6a7b7ef13a57f38( player );
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x472d98c2, Offset: 0x2e90
// Size: 0x26
function private function_98be71c6574b03ed()
{
    flags::gameflagwait( "infil_animatic_complete" );
    thread ftue_player::function_ae0296f83b974598( &function_f8df8893fdca7f93 );
    thread ftue_player::function_257c9575891b6d7d( &function_d9b69094bff48166 );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xb5d3f689, Offset: 0x2ebe
// Size: 0xd
function private function_f8df8893fdca7f93()
{
    self.var_152df6048aa53e05 = 1;
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x8e01f2e, Offset: 0x2ed3
// Size: 0x1b
function private function_d9b69094bff48166()
{
    if ( !self.var_152df6048aa53e05 )
    {
        return;
    }
    
    self.var_95f3bf0dc049c633 = 1;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xb2b1a4ed, Offset: 0x2ef6
// Size: 0x5e
function private function_977b46892e8a7d4c( params )
{
    cache = params.cacheinstance;
    
    if ( cache && cache.type == "br_loot_cache_aether" )
    {
        namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"bongo_ftue_cradle_crates" );
        callback::remove( "lootcache_looted", &function_977b46892e8a7d4c );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x13c6aea2, Offset: 0x2f5c
// Size: 0xfb
function private function_3848129c7496491f( params )
{
    itembundle = params.itembundle;
    
    if ( itembundle && itembundle.subtype == "item_select" )
    {
        owningteam = params.spawnoptions.spawningteam;
        players = teams::getteamdata( owningteam, "players" );
        
        foreach ( player in players )
        {
            player thread function_899c631884d5c94f();
            player calloutmarkerping::function_920a63c06abdefe8( params.item getscriptableindex() );
        }
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x28fc137b, Offset: 0x305f
// Size: 0x12
function private function_899c631884d5c94f()
{
    namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"bongo_ftue_instanced_rewards" );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x7c4aecb0, Offset: 0x3079
// Size: 0x12
function private function_1ae38b877faa38d()
{
    namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"bongo_ftue_respawn_token_2" );
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0xd45e13ac, Offset: 0x3093
// Size: 0x5c
function function_69f55db548ce3cfe( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( player ) )
    {
        player waittill( #"skydive_end" );
        
        while ( true )
        {
            if ( player isonground() || player isswimming() )
            {
                break;
            }
            
            waitframe();
        }
        
        player setclientomnvar( "ui_br_altimeter_state", 0 );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x65b24a5e, Offset: 0x30f7
// Size: 0xb2
function private function_a77de51ace7331da( player )
{
    player endon( #"disconnect" );
    
    while ( player )
    {
        player waittill( #"skydive_beginfreefall" );
        wait 1;
        vel = player getvelocity();
        xyspeed = length( ( vel[ 0 ], vel[ 1 ], 0 ) );
        
        if ( xyspeed < getdvarfloat( @"hash_8da99fac25838947", 50 ) )
        {
            playerangles = player getplayerangles( 1 );
            var_b276b0c578a86b0c = anglestoforward( ( 0, playerangles[ 1 ], 0 ) ) * getdvarfloat( @"hash_3bcd1d9ef294beaf", 100 );
            player setvelocity( vel + var_b276b0c578a86b0c );
        }
    }
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x5d14a608, Offset: 0x31b1
// Size: 0x118
function function_e53d35bb022dec50( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( player ) )
    {
        player waittill( #"skydive_deployparachute" );
        player setclientomnvar( "ui_br_altimeter_state", 2 );
        
        while ( true )
        {
            player setscriptablepartstate( "wingsuit_flaps", "on" );
            msg = player utility::waittill_any_return( "giveLoadout", "skydive_end", "last_stand_enter", "death_or_disconnect" );
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            if ( msg == "giveLoadout" )
            {
                continue;
            }
            
            break;
        }
        
        player setscriptablepartstate( "wingsuit_flaps", "off" );
        player.var_391c5dbd8fb94d36 = gettime();
        altimeterstate = 0;
        
        if ( !player isonground() && !player isswimming() && !player.inlaststand )
        {
            altimeterstate = 1;
        }
        
        player setclientomnvar( "ui_br_altimeter_state", altimeterstate );
        player setshowcontrail( 0 );
        
        if ( player.inlaststand )
        {
            player skydive_interrupt();
        }
    }
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0xc69e6185, Offset: 0x32d1
// Size: 0x6a
function function_4803628655aa3aff( player )
{
    player endon( #"disconnect" );
    assert( player isplayerheadless() );
    
    while ( true )
    {
        player waittill( #"skydive_beginfreefall" );
        player mega_jump::set_fall_damage_reduction( 1 );
        player utility::waittill_any( "skydive_end", "last_stand_enter", "death" );
        player mega_jump::set_fall_damage_reduction( 0 );
    }
}

// Namespace br_gametype_bongo
// Params 2
// Checksum 0x109e6141, Offset: 0x3343
// Size: 0x36
function function_bbe3d6cf9ddda498( origin, radius )
{
    var_a576a6c21214b164 = common_item::function_70d4affb770e8103( "wz_consumable_cache_loot_aether" );
    return getlootscriptablearrayinradius( var_a576a6c21214b164, undefined, origin, radius );
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x62072a62, Offset: 0x3382
// Size: 0x20
function function_e5e54b4110a6b8c( cache )
{
    cache.contents = undefined;
    common_cache::function_cad109a4d37ddbb( cache );
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0xe2c6cdb6, Offset: 0x33aa
// Size: 0x25
function function_d27a2e72415f2267( cache )
{
    cache setscriptablepartstate( #"body", #"hidden" );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x288b6e4b, Offset: 0x33d7
// Size: 0x9b
function private function_77fd0cdd4306c912( params )
{
    var_9ffea708a12df7c3 = undefined;
    weapon = params.weapon;
    
    if ( params.weapon )
    {
        weapon = weapon getnoaltweapon();
        itembundlename = item_weapon::function_a23ea7289efe03ed( weapon );
        
        if ( itembundlename )
        {
            var_9ffea708a12df7c3 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itembundlename );
        }
    }
    
    if ( !isbot( self ) )
    {
        self setclientomnvar( "ui_br_current_weapon_item_bundle", var_9ffea708a12df7c3 ?? 0 );
    }
    
    self.lastweaponchangetime = gettime();
    function_6d5d93bec67d8661( self );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x9af20b, Offset: 0x347a
// Size: 0x14
function private function_ffc8fdaddd15f3a9( params )
{
    function_6d5d93bec67d8661( self );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xae415784, Offset: 0x3496
// Size: 0xe8
function private function_6d5d93bec67d8661( player )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    var_8331a067ef724477 = undefined;
    primaryweapon = player item_weapon::function_e7484276ad85f220( #"primary_0" );
    
    if ( primaryweapon )
    {
        primaryweapon = primaryweapon getnoaltweapon();
        itembundlename = item_weapon::function_a23ea7289efe03ed( primaryweapon );
        
        if ( itembundlename )
        {
            var_8331a067ef724477 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itembundlename );
        }
    }
    
    self setclientomnvar( "ui_br_primary_weapon_item_bundle", var_8331a067ef724477 ?? 0 );
    var_350d89c580bb12d7 = undefined;
    secondaryweapon = player item_weapon::function_e7484276ad85f220( #"primary_1" );
    
    if ( secondaryweapon )
    {
        secondaryweapon = secondaryweapon getnoaltweapon();
        itembundlename = item_weapon::function_a23ea7289efe03ed( secondaryweapon );
        
        if ( itembundlename )
        {
            var_350d89c580bb12d7 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itembundlename );
        }
    }
    
    self setclientomnvar( "ui_br_secondary_weapon_item_bundle", var_350d89c580bb12d7 ?? 0 );
}

// Namespace br_gametype_bongo
// Params 3, eflags: 0x4
// Checksum 0x8d534ee5, Offset: 0x3586
// Size: 0x241
function private function_f7ca46b47cd383c6( agent, requestid, spawndata )
{
    if ( agent.type == "zombie" )
    {
        agent.shoulddropweapon = 0;
        agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "bongo", 1 );
    }
    
    switch ( agent.subclass )
    {
        case #"hash_2e6334b07cfe8d2f":
            agent.agentname = &"br_gametype_bongo/activity_charging_station_bot_name";
            agent.var_24954f14e27b448d = 0;
            break;
        case #"hash_b0491209df7b4b5c":
            vehicle_compass::function_e527b9d6ae381350( agent.turret, agent.team );
        case #"hash_d792b257b9ee46a":
            agent.agentname = &"ai/juggerbot";
            agent.shoulddropweapon = 0;
            agent.elite = 1;
            break;
        case #"hash_2f5c52f1e6ef9284":
            agent.var_24954f14e27b448d = 1;
            agent.elite = 1;
            break;
        default:
            agent.var_24954f14e27b448d = 0;
            break;
    }
    
    logstring( "Current AI Count [Request ID " + requestid + "]: " + function_da26e38f24f90f2f( requestid ) );
    level.totalspawnedai++;
    level.var_1e9432f20e98727f++;
    logstring( "Total AI spawned: " + level.totalspawnedai );
    logstring( "Total Alive AI (spawned): " + level.var_1e9432f20e98727f );
    
    if ( !isdefined( agent.bongotelemetry ) )
    {
        agent.bongotelemetry = spawnstruct();
    }
    
    agent.bongotelemetry.requestid = requestid;
    agent.bongotelemetry.spawntime = gettime();
    agent.bongotelemetry.spawnposition = agent.origin;
    agent.bongotelemetry.spawnaicount = level.var_1e9432f20e98727f;
    agent.agentdamagefeedback = 1;
    agent thread watchdeath();
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x2d155e5, Offset: 0x37cf
// Size: 0x39
function private function_a6cc0e69a3ee461f( team, dawgaisettings )
{
    return team == "team_hundred_ninety_seven" ? dawgaisettings.var_6a7a70f3ad78ede2 : dawgaisettings.var_a6cc0e69a3ee461f;
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x94343fbe, Offset: 0x3811
// Size: 0x223
function private watchdeath()
{
    agent = self;
    bongotelemetry = agent.bongotelemetry;
    agent waittill( #"death" );
    level.var_1e9432f20e98727f--;
    logstring( "Total Alive AI (death): " + level.var_1e9432f20e98727f );
    dlog_recordevent( "dlog_event_br_agent_life", [ "aitype", agent.classname, "context", bongotelemetry.context ?? "", "encounter", bongotelemetry.encounter ?? "", "spawn_encounter_spawned_count", bongotelemetry.encounter_spawn_count ?? 0, "spawn_encounter_killed_count", bongotelemetry.encounter_killed_count ?? 0, "spawn_request_id", bongotelemetry.requestid, "spawn_time", bongotelemetry.spawntime, "spawn_x", bongotelemetry.spawnposition[ 0 ], "spawn_y", bongotelemetry.spawnposition[ 1 ], "spawn_match_alive_ai_count", bongotelemetry.spawnaicount, "death_time", gettime(), "death_reason", agent.damagemod, "death_x", agent.origin[ 0 ], "death_y", agent.origin[ 1 ], "death_match_alive_ai_count", level.var_1e9432f20e98727f, "last_attacker", agent.lastattacker.name ?? "" ] );
    br_activity_util::function_333e692c891758bb( br_activity_util::function_501ceea91ee698e7( agent.lastattacker ), "specialEnemiesKilled" );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x3044edfe, Offset: 0x3a3c
// Size: 0x39
function private function_68200d5bc659c0d5( params )
{
    self endon( #"death_or_disconnect" );
    wait 1;
    
    if ( supers_mp::issuperready() )
    {
        return;
    }
    
    common_inventory_groups::function_d1ad55b9507ab500( 0, 5, 1, 0, 4, 2 );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2fb9b652, Offset: 0x3a7d
// Size: 0x5a
function private function_dc24ba8ef5faebe8( params )
{
    self endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"hash_3ea133694797e10b", 1 ) )
    {
        while ( utility::isusingremote() )
        {
            waitframe();
        }
    }
    
    wait 1;
    
    if ( !item_killstreak::hasanykillstreak() )
    {
        common_inventory_groups::function_d1ad55b9507ab500( 0, 6, 1, 0, 3, 2, 1 );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x301e7d14, Offset: 0x3adf
// Size: 0x61
function private function_7a1543ba502d0376( params )
{
    if ( equipment_mp::getequipmentslotammo( params.slot ) != 0 )
    {
        return;
    }
    
    if ( params.ref == "equip_c4" )
    {
        return;
    }
    
    if ( params.slot == "primary" )
    {
        function_27a2925e174c2868( params );
        return;
    }
    
    function_9a8577e27e2b2f93( params );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x905fbfa6, Offset: 0x3b48
// Size: 0x80
function private function_9a8577e27e2b2f93( params )
{
    params.player endon( #"death_or_disconnect" );
    wait 1;
    
    if ( params.player function_41360f0bcfc012aa() )
    {
        while ( params.player function_41360f0bcfc012aa() )
        {
            waitframe();
        }
        
        wait 1;
    }
    
    if ( equipment_mp::getequipmentslotammo( params.slot ) != 0 )
    {
        return;
    }
    
    common_inventory_groups::function_d1ad55b9507ab500( 0, 7, 1, 0, 1, 2, 1 );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2547ec04, Offset: 0x3bd0
// Size: 0x52
function private function_27a2925e174c2868( params )
{
    params.player endon( #"death_or_disconnect" );
    wait 1;
    
    if ( equipment_mp::getequipmentslotammo( params.slot ) != 0 )
    {
        return;
    }
    
    common_inventory_groups::function_d1ad55b9507ab500( 0, 8, 1, 0, 2, 2, 1 );
}

// Namespace br_gametype_bongo
// Params 8, eflags: 0x4
// Checksum 0x4bb44858, Offset: 0x3c2a
// Size: 0x1ce
function private function_2365b76f19ea37ea( victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring )
{
    var_7912b7fee009f972 = kiastring;
    eliminationscoreevent = function_b908e47ab1e62455( kiastring, victim ) ?? var_7912b7fee009f972;
    
    if ( eliminationscoreevent )
    {
        foreach ( player in self.a_n_player_damage )
        {
            if ( eattacker == player )
            {
                continue;
            }
            
            var_af019b261d1e4ac3 = victim function_5a9ad0e34e4ab14( victim );
            player thread function_3f53c38c75f535c4( eliminationscoreevent, var_af019b261d1e4ac3, victim, kiastring );
        }
    }
    
    vehiclescoreevent = function_5090f3ec0ba26c38( einflictor, kiastring, victim );
    
    if ( vehiclescoreevent )
    {
        eattacker thread function_3f53c38c75f535c4( vehiclescoreevent, sweapon, victim, kiastring );
        return;
    }
    
    criticalscoreevent = function_cf457fa5aaa1b729( eattacker, kiastring, victim );
    
    if ( criticalscoreevent )
    {
        eattacker thread function_3f53c38c75f535c4( criticalscoreevent, sweapon, victim, kiastring );
        return;
    }
    
    if ( eliminationscoreevent && !isvalidscoreevent( kiastring ) )
    {
        eattacker thread function_3f53c38c75f535c4( eliminationscoreevent, sweapon, victim, kiastring );
    }
    else
    {
        eattacker thread function_3f53c38c75f535c4( kiastring, sweapon, victim, kiastring );
    }
    
    level callback::callback( #"on_ai_killed_medal", { #sweapon:sweapon, #smeansofdeath:smeansofdeath, #victim:victim, #eattacker:eattacker } );
}

// Namespace br_gametype_bongo
// Params 4
// Checksum 0x6484c7fb, Offset: 0x3e00
// Size: 0x9b
function function_3f53c38c75f535c4( var_7912b7fee009f972, sweapon, victim, kiastring )
{
    if ( !isdefined( level.bongo_killing_score_event_throttle ) )
    {
        level.bongo_killing_score_event_throttle = throttle::throttle_initialize( "bongo_killing_score_event", 2, level.framedurationseconds );
    }
    
    var_1819ea4dc4ef3a41 = spawnstruct();
    throttle::throttle_wait_in_queue( level.bongo_killing_score_event_throttle, var_1819ea4dc4ef3a41 );
    
    if ( issubstr( var_7912b7fee009f972, "executed" ) )
    {
        wait 1;
    }
    
    if ( isdefined( self ) )
    {
        points::doscoreevent( var_7912b7fee009f972, sweapon, undefined, undefined, victim );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xf9770c05, Offset: 0x3ea3
// Size: 0x58
function private function_5a9ad0e34e4ab14( player )
{
    if ( !isplayer( player ) )
    {
        return level.weaponnone;
    }
    
    playerid = player getentitynumber();
    
    if ( !self.var_d4b7ed447e2bf50c[ playerid ] )
    {
        return level.weaponnone;
    }
    
    return self.var_d4b7ed447e2bf50c[ playerid ];
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xe02a3078, Offset: 0x3f04
// Size: 0xc8
function private function_41e7b7e813d58123( scoreevent, enemy )
{
    enemycategory = ai_category::function_e6e323e14b12152e( enemy );
    
    switch ( enemycategory )
    {
        case #"normal":
            return hashcat( scoreevent, "_normal" );
        case #"special":
            return hashcat( scoreevent, "_special" );
        case #"hvt":
        case #"elite":
            return hashcat( scoreevent, "_elite" );
        case #"boss":
            return hashcat( scoreevent, "_boss" );
        default:
            assertmsg( "<dev string:x24>" + enemy.subclass );
            return;
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x2860368c, Offset: 0x3fd4
// Size: 0x81
function private function_b908e47ab1e62455( kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:x62>" );
    
    if ( !isdefined( self.a_n_player_damage ) || self.a_n_player_damage.size <= 0 )
    {
        return;
    }
    
    scoreevent = hashcat( #"elimination", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace br_gametype_bongo
// Params 3, eflags: 0x4
// Checksum 0x1c0bc6f, Offset: 0x405e
// Size: 0xb7
function private function_cf457fa5aaa1b729( attacker, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:x62>" );
    
    if ( !self.last_dmg_struct.biscritical )
    {
        return;
    }
    
    if ( self.last_dmg_struct.eattacker != attacker && self.var_1480bf6f03b7e0be.eattacker != attacker )
    {
        return;
    }
    
    scoreevent = hashcat( #"critical", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace br_gametype_bongo
// Params 3, eflags: 0x4
// Checksum 0xba80d7dc, Offset: 0x411e
// Size: 0x85
function private function_5090f3ec0ba26c38( inflictor, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:x62>" );
    
    if ( !inflictor.vehicletype || inflictor function_a7378c4908103226() )
    {
        return;
    }
    
    scoreevent = hashcat( #"vehicle", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xcf7603f4, Offset: 0x41ac
// Size: 0x16, Type: bool
function private isvalidscoreevent( scoreevent )
{
    return rank::getscoreinfovalue( scoreevent ) > 0;
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x3a5da39a, Offset: 0x41cb
// Size: 0x60
function circletimer( circleindex )
{
    function_37e867e69810d3fd( circleindex );
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    if ( circleindex < level.var_528d678aa54b1f26 )
    {
        return;
    }
    
    level.brgametype.respawnenable = 0;
    function_d118ca011051b83d();
    function_29144786a2589318();
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x4c3a8884, Offset: 0x4233
// Size: 0xa3
function private function_d118ca011051b83d()
{
    foreach ( player in level.players )
    {
        if ( !level.var_142284b8acb971a6 )
        {
            player thread hud_message::showsplash( "br_bongo_redeploy_token_disabled" );
        }
        
        if ( player br_public::hasrespawntoken() )
        {
            player item_redeploy_token::function_16ab0a48337237ef( 1 );
        }
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x5205ae9d, Offset: 0x42de
// Size: 0x88
function private function_29144786a2589318()
{
    var_476a5aea7cc860fe = getlootscriptablearray( "brloot_bongo_redeploy_token", undefined );
    
    foreach ( lootitem in var_476a5aea7cc860fe )
    {
        common_item::function_869d7676e359a627( lootitem );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x60f5c892, Offset: 0x436e
// Size: 0x30
function private function_37e867e69810d3fd( circleindex )
{
    if ( !level.var_9455be8dc926ce7b )
    {
        return;
    }
    
    if ( circleindex == level.var_2a04d6af4dc510d7 )
    {
        thread function_7e7ee7aafd1a5579();
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xcf98f2ae, Offset: 0x43a6
// Size: 0xfa
function private function_7e7ee7aafd1a5579()
{
    if ( !level.vehicle || !level.vehicle.aircraft )
    {
        return;
    }
    
    aircraft = level.vehicle.aircraft;
    
    foreach ( vehicle in aircraft )
    {
        if ( !vehicle || !isalive( vehicle ) )
        {
            continue;
        }
        
        if ( level.var_8adaef60fe79cdc3 )
        {
            vehicle vehicle_occupancy::eject_all_occupants( vehicle );
        }
        
        vehicle vehicle_occupancy::disable_engine();
        vehicle dodamage( 99999, vehicle.origin, undefined, undefined );
    }
}

// Namespace br_gametype_bongo
// Params 3, eflags: 0x4
// Checksum 0xdf4f6795, Offset: 0x44a8
// Size: 0x2e
function private function_358fbfe7ed4ab979( victim, attacker, wasdeath )
{
    if ( !wasdeath )
    {
        function_af18e76dbcc3247b( victim, attacker );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xbf5f6ecd, Offset: 0x44de
// Size: 0x2b9
function private function_af18e76dbcc3247b( victim, attacker )
{
    spectatelog( victim, "handleInstantRespawn - start" );
    
    if ( getdvarint( @"hash_34915c52fb93cc4", 1 ) && victim.currentlyrespawning )
    {
        spectatelog( victim, "handleInstantRespawn - bail, already respawning" );
        return;
    }
    
    var_e1a9eed87f0c7851 = victim function_e7b6a060e65e4abf();
    
    if ( level.var_8690dec2acaf2b3 )
    {
        if ( var_e1a9eed87f0c7851.size > 0 )
        {
            if ( level.var_be7dc7b1a3809a1f )
            {
                player = function_8abaf82c3748dfe6( var_e1a9eed87f0c7851 );
                player.var_ad882e8f12cd3d2a = 0;
                spectatelog( victim, "handleInstantRespawn - single respawn of ", player );
                thread br_spectate::function_716fddf4830ea0cb( player );
            }
            else
            {
                foreach ( player in var_e1a9eed87f0c7851 )
                {
                    player.var_ad882e8f12cd3d2a = 0;
                }
            }
        }
    }
    
    if ( getdvarint( @"hash_b05afa6110e5da42", 0 ) == 1 )
    {
        if ( isdefined( victim ) && !victim.disconnecting )
        {
            victim thread br_spectate::spawnspectator( { #attacker:attacker } );
        }
        
        return;
    }
    
    alivecount = teams::getteamdata( victim.team, "aliveCount" );
    
    if ( alivecount > 0 || var_e1a9eed87f0c7851.size > 0 )
    {
        if ( isdefined( victim ) && !victim.disconnecting )
        {
            spectatelog( victim, "handleInstantRespawn - spawnSpectator victim" );
            victim thread br_spectate::spawnspectator( { #attacker:attacker } );
        }
        
        return;
    }
    
    spectatelog( victim, "handleInstantRespawn - spawnSpectator team" );
    players = teams::getteamdata( self.team, "players" );
    
    foreach ( player in players )
    {
        spectatedplayer = player getspectatingplayer();
        
        if ( isdefined( player ) && !player.disconnecting && !spectatedplayer || player == self || spectatedplayer == self )
        {
            player thread br_spectate::spawnspectator( { #attacker:attacker } );
        }
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x7d214b38, Offset: 0x479f
// Size: 0x256, Type: bool
function private playerkilledspawn( deathdata, finaldeath )
{
    if ( !level.br_prematchstarted )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_ecf2cee884be2cf3", 1 ) )
    {
        function_af18e76dbcc3247b( deathdata.victim, deathdata.attacker );
        return true;
    }
    
    var_e1a9eed87f0c7851 = deathdata.victim function_e7b6a060e65e4abf();
    
    if ( level.var_8690dec2acaf2b3 )
    {
        if ( var_e1a9eed87f0c7851.size > 0 )
        {
            if ( level.var_be7dc7b1a3809a1f )
            {
                player = function_8abaf82c3748dfe6( var_e1a9eed87f0c7851 );
                player.var_ad882e8f12cd3d2a = 0;
            }
            else
            {
                foreach ( player in var_e1a9eed87f0c7851 )
                {
                    player.var_ad882e8f12cd3d2a = 0;
                }
            }
        }
    }
    
    if ( getdvarint( @"hash_b05afa6110e5da42", 0 ) == 1 )
    {
        deathdata.victim thread br_spectate::spawnspectator( deathdata, finaldeath );
    }
    else
    {
        alivecount = teams::getteamdata( deathdata.victim.team, "aliveCount" );
        
        if ( alivecount > 0 || var_e1a9eed87f0c7851.size > 0 )
        {
            deathdata.victim thread playerlogic::spawnspectator( br_spectate::function_bbd17501369f5227( deathdata.victim.origin ), deathdata.victim.angles );
        }
        else
        {
            players = teams::getteamdata( self.team, "players" );
            
            foreach ( player in players )
            {
                player thread br_spectate::spawnspectator( deathdata, finaldeath );
            }
        }
    }
    
    return true;
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x1600f560, Offset: 0x49fe
// Size: 0xd6
function private function_e7b6a060e65e4abf()
{
    var_e1a9eed87f0c7851 = [];
    players = teams::getteamdata( self.team, "players" );
    
    foreach ( player in players )
    {
        if ( isalive( player ) )
        {
            return [];
        }
        
        if ( getdvarint( @"hash_34918c52fb9435d", 1 ) && player.currentlyrespawning )
        {
            return [];
        }
        
        if ( player item_redeploy_token::function_6932ae7663f88c8e() )
        {
            var_e1a9eed87f0c7851[ var_e1a9eed87f0c7851.size ] = player;
        }
    }
    
    return var_e1a9eed87f0c7851;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xd85bb642, Offset: 0x4add
// Size: 0xbc
function private function_8abaf82c3748dfe6( players )
{
    var_92ec223733462b9f = level.respawndelay + 1;
    var_c4308a1949316dd2 = players[ 0 ];
    
    foreach ( player in players )
    {
        if ( player.var_ad882e8f12cd3d2a < var_92ec223733462b9f )
        {
            var_92ec223733462b9f = player.var_ad882e8f12cd3d2a;
            var_c4308a1949316dd2 = player;
        }
    }
    
    return var_c4308a1949316dd2;
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x67a99bb1, Offset: 0x4ba2
// Size: 0x15e
function private playergulagautowinwait( sponsor, tokenused )
{
    var_7237854e3be197ca = sponsor;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    spectatelog( self, "playerGulagAutoWinWait - start" );
    self.tokenused = tokenused;
    
    if ( !tokenused )
    {
        return;
    }
    
    respawndelay = level.respawndelay;
    
    if ( respawndelay <= 0 )
    {
        return 1;
    }
    
    if ( level.var_8690dec2acaf2b3 )
    {
        var_e1a9eed87f0c7851 = function_e7b6a060e65e4abf();
        
        if ( var_e1a9eed87f0c7851.size > 0 )
        {
            if ( !level.var_be7dc7b1a3809a1f )
            {
                foreach ( player in var_e1a9eed87f0c7851 )
                {
                    player.var_ad882e8f12cd3d2a = 0;
                }
                
                return 1;
            }
        }
    }
    
    showrespawntimer( respawndelay );
    self.var_ad882e8f12cd3d2a = respawndelay;
    function_94ac6882af8c06c();
    self.var_ad882e8f12cd3d2a = 0;
    spectatelog( self, "playerGulagAutoWinWait - end" );
    self notify( #"hash_ed25060c573844a0" );
    thread function_69a6f0ec858af897();
    hiderespawntimer();
    return 1;
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x7ed7a310, Offset: 0x4d09
// Size: 0x45
function private function_94ac6882af8c06c()
{
    while ( self.var_ad882e8f12cd3d2a > 0 )
    {
        br_public::updatebrscoreboardstat( "respawnInSeconds", self.var_ad882e8f12cd3d2a );
        br_gametype_resurgence::function_6f6222b4837d3c31( self.var_ad882e8f12cd3d2a );
        wait 1;
        self.var_ad882e8f12cd3d2a--;
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x1c6d34b0, Offset: 0x4d56
// Size: 0x24
function private showrespawntimer( timer )
{
    br_gametype_resurgence::function_12b97810099f2b4d();
    br_gametype_resurgence::function_6f6222b4837d3c31( timer );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x4c591949, Offset: 0x4d82
// Size: 0x19
function private hiderespawntimer()
{
    br_gametype_resurgence::function_e9f3e6b5a7d226b0();
    br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x9c9a2399, Offset: 0x4da3
// Size: 0x30
function private function_69a6f0ec858af897()
{
    self endon( #"disconnect" );
    self.currentlyrespawning = 1;
    self waittill( #"spawned" );
    self.currentlyrespawning = undefined;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xf658d675, Offset: 0x4ddb
// Size: 0x1f
function private triggerrespawnoverlay( overlaytype )
{
    return level.brgametype.respawnenable;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2da010b1, Offset: 0x4e03
// Size: 0x67
function private function_a9cc756d803543a5( params )
{
    if ( !isdefined( params.itembundle ) || params.itembundle.ref != "wz_consumable_bongo_redeploy_token" )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return;
    }
    
    thread hud_message::showsplash( "br_bongo_redeploy_token_acquired" );
    function_1ae38b877faa38d();
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xc373ec60, Offset: 0x4e72
// Size: 0xaa
function private function_b1aba1b51a0d44d7( deathdata )
{
    player = self;
    teammates = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teammates )
    {
        function_1f186ea5a6da8c7f( teammate, teammates );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x77eb69ae, Offset: 0x4f24
// Size: 0xb0
function private function_1f186ea5a6da8c7f( player, teammates )
{
    deadcount = 0;
    
    foreach ( teammate in teammates )
    {
        if ( teammate == player )
        {
            continue;
        }
        
        if ( !teammate player::isreallyalive() )
        {
            deadcount++;
        }
    }
    
    player setclientomnvar( "ui_br_dead_teammates_count", deadcount );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xd60c1617, Offset: 0x4fdc
// Size: 0x165
function private onspawnplayer()
{
    squadmembers = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid );
    
    if ( !gamelogic_mp::inprematch() && !self.revealspawn && ( getdvarint( @"hash_a022047eb4adbe14", 0 ) || game[ "state" ] != "postgame" ) )
    {
        foreach ( squadmember in squadmembers )
        {
            if ( squadmember == self )
            {
                if ( self.tokenused )
                {
                    self.tokenused = undefined;
                    squadmember thread hud_message::showsplash( "br_bongo_redeploy_token_used" );
                    squadmember.var_1622158e490fc100 = 1;
                }
                
                continue;
            }
            
            if ( !self.var_ecce78452b9a6c18 )
            {
                squadmember thread hud_message::showsplash( "br_bongo_teammate_respawn", undefined, self );
                continue;
            }
            
            squadmember thread hud_message::showsplash( "br_bongo_teammate_respawn_station", undefined, self );
        }
    }
    
    thread function_42ace0b8829848f1();
    self.var_ecce78452b9a6c18 = undefined;
    function_b1aba1b51a0d44d7();
    utility::callsharedfunc( #"bongo", #"onspawnplayer_ltm" );
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0xaabc67ed, Offset: 0x5149
// Size: 0x13b
function function_12d3e6293a73c2b( grenade )
{
    grenade endon( #"death" );
    thread decoy_grenade::used( grenade );
    grenade waittill( #"hash_c860830af05fa677" );
    grenade.attractor = zombie_attractor_manager::add_attractor( grenade, 1, grenade.tableinfo.bundle.var_ca694ff612181976, 0, undefined, &function_a92d75a1117625fc, 0, self.team, 1 );
    grenade thread function_7de4ee6d3709aa7f();
    var_4bc2dcb755f719f6 = getaiarrayinradius( grenade.origin, grenade.tableinfo.bundle.var_ca694ff612181976 );
    
    foreach ( ai in var_4bc2dcb755f719f6 )
    {
        ai aieventlistenerevent( "decoy_grenade", grenade, grenade.origin );
    }
}

// Namespace br_gametype_bongo
// Params 0
// Checksum 0x1290d64a, Offset: 0x528c
// Size: 0x2c
function function_7de4ee6d3709aa7f()
{
    self waittill( #"death" );
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
}

// Namespace br_gametype_bongo
// Params 2
// Checksum 0x50238f4d, Offset: 0x52c0
// Size: 0x26, Type: bool
function function_a92d75a1117625fc( attractor, ai )
{
    return ai.aicategory == "normal";
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x19f12b9f, Offset: 0x52ef
// Size: 0x64
function private function_be334704d96df6b0()
{
    var_a9e15a4d8006eff8 = { #lifetime:90, #hotzonemodelname:"sat_br_avalon_hotzones_floating_name_fx", #var_19733a4972a03471:"sat_br_avalon_floating_name_fx", #anglesoffset:( 0, -90, 0 ), #offset:( 0, 0, 500 ) };
    return var_a9e15a4d8006eff8;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2e0bad8f, Offset: 0x535c
// Size: 0x15
function private function_dbace31f2ca4796a( params )
{
    return self.var_95f3bf0dc049c633;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x46b1c0e1, Offset: 0x537a
// Size: 0x16, Type: bool
function private function_4691cbb4e4d170e3( params )
{
    return isdefined( self.armor_upgrade );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x14af4791, Offset: 0x5399
// Size: 0xc3, Type: bool
function private function_e2d7a9351c002ce7( params )
{
    var_75cd5739161097b = activity_participation::function_e8eabd79cc49540e( self, [ "BONGO_CHARGING_STATION" ] );
    
    foreach ( var_c37c3ef849485cf5 in var_75cd5739161097b )
    {
        activity = activity_common::getactivityinstance( var_c37c3ef849485cf5.instanceid );
        
        if ( activity.state == "Active" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xea53d3a2, Offset: 0x5465
// Size: 0x37, Type: bool
function private function_e9dc4a38cbd806a9( params )
{
    for ( i = 9; i <= 13 ; i++ )
    {
        if ( common_inventory::inventory_getlootidatbackpackindex( i ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x755088e0, Offset: 0x54a5
// Size: 0xb7
function private function_5f6d33567e962f8b( params )
{
    activity = params.activity;
    origin = activity.bomborigin;
    var_6d5baab9981064b5 = activity.var_332f929de1894b2b.expandradius;
    insideplayers = getplayersinradius( origin, var_6d5baab9981064b5 );
    function_ea60f5815ec598bf( insideplayers, 1, 1 );
    nearplayers = getplayersinradius( origin, 5000 );
    function_ea60f5815ec598bf( nearplayers, 2 );
    function_ea60f5815ec598bf( level.players, 3 );
    level callback::remove( "bongo_cradle_gas_expanding", &function_5f6d33567e962f8b );
}

// Namespace br_gametype_bongo
// Params 3, eflags: 0x4
// Checksum 0xde9bbebc, Offset: 0x5564
// Size: 0xab
function private function_ea60f5815ec598bf( players, result, force )
{
    foreach ( player in players )
    {
        if ( !isdefined( player.var_4a9aafb627b3bde3 ) || force )
        {
            player.var_4a9aafb627b3bde3 = result;
        }
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xb429a4fe, Offset: 0x5617
// Size: 0x36
function private function_a2ae779fd4b00218( player )
{
    if ( !self.var_911b45616e7598c2 && isdefined( player.var_4a9aafb627b3bde3 ) )
    {
        return player.var_4a9aafb627b3bde3;
    }
    
    return 0;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x59d7d8b, Offset: 0x5656
// Size: 0x24, Type: bool
function private function_5e4a5a19255cec06( params )
{
    distancetier = function_a2ae779fd4b00218( self );
    return distancetier == 3;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xfdec0f77, Offset: 0x5683
// Size: 0x24, Type: bool
function private function_86d9e36415882465( params )
{
    distancetier = function_a2ae779fd4b00218( self );
    return distancetier == 1;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x53a7472f, Offset: 0x56b0
// Size: 0x24, Type: bool
function private function_33a2de94d8ffe1e7( params )
{
    distancetier = function_a2ae779fd4b00218( self );
    return distancetier == 2;
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x11507a41, Offset: 0x56dd
// Size: 0x2a
function private function_5ca72d69c4792e03( tipid, notificationid )
{
    self.var_911b45616e7598c2 = 1;
    ftue_tip::function_517f769824070ef6( tipid, notificationid );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x1f4e8fcf, Offset: 0x570f
// Size: 0x39
function private function_d7b05f5c1a04b38( params )
{
    var_25434392f016bfe = !player::isreallyalive( self ) && self.sessionstate == #"spectator";
    return var_25434392f016bfe;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xa13185e6, Offset: 0x5751
// Size: 0x37, Type: bool
function private function_5aaa036783b984e5( params )
{
    for ( i = 5; i <= 8 ; i++ )
    {
        if ( common_inventory::inventory_getlootidatbackpackindex( i ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xe3c14024, Offset: 0x5791
// Size: 0x2e, Type: bool
function private function_5260053c37da3a09( params )
{
    var_f40d18b11163fedd = activity_participation::function_e8eabd79cc49540e( self, [ "BONGO_ELITE_ENEMY" ] );
    return var_f40d18b11163fedd.size > 0;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x4e99103d, Offset: 0x57c8
// Size: 0xc6, Type: bool
function private function_c9a35a424570a0f1( params )
{
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( teammate == self )
        {
            continue;
        }
        
        if ( !player::isreallyalive( teammate ) && teammate.sessionstate == #"spectator" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xfaaf64cf, Offset: 0x5897
// Size: 0x2d
function private function_5b711399865b5676( params )
{
    if ( self.sessionstate == #"spectator" )
    {
        return 0;
    }
    
    return self.var_1622158e490fc100;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x30a897e8, Offset: 0x58cd
// Size: 0xe4, Type: bool
function private function_6bb7884ae4eabac6( params )
{
    if ( !self isonground() )
    {
        return false;
    }
    
    if ( !self.var_1bf06f44a37d953 )
    {
        return false;
    }
    
    var_1e3f7bdab5ec0f4c = 6250;
    var_5a4e302ffd4b631a = gettime() - self.lastweaponchangetime < var_1e3f7bdab5ec0f4c;
    pickedupweaponrecently = gettime() - self.lastweaponpickuptime < var_1e3f7bdab5ec0f4c;
    
    if ( var_5a4e302ffd4b631a || pickedupweaponrecently )
    {
        return false;
    }
    
    currentweapon = self getcurrentweapon();
    
    if ( !isdefined( currentweapon ) || isnullweapon( currentweapon ) || weapon::isfistweapon( currentweapon ) )
    {
        return false;
    }
    
    itembundlename = item_weapon::function_a23ea7289efe03ed( currentweapon );
    
    if ( !itembundlename )
    {
        return false;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !itembundle )
    {
        return false;
    }
    
    return isdefined( itembundle.var_dd54d02596151fda );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x5c2bbd9c, Offset: 0x59ba
// Size: 0xd, Type: bool
function private function_8037fd752696ce58( params )
{
    return false;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x83e53d6c, Offset: 0x59d0
// Size: 0x211
function private function_edb27b5c85c71d5f( player )
{
    player endon( #"disconnect" );
    
    if ( !getdvarint( @"hash_73deae6bc6f167db" ) )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( level.var_87b5616c20a9602d )
    {
        var_aad5f79efa645830 = level.var_87b5616c20a9602d utility::function_67292ed50d12c006();
        
        foreach ( var_451edc7d53a7f763 in var_aad5f79efa645830 )
        {
            foreach ( hiddenscriptable in var_451edc7d53a7f763 )
            {
                function_43891dc1856ceef1( hiddenscriptable, [ player ] );
            }
        }
    }
    
    foreach ( hiddenscriptable in level.var_6fc8ae7c0ec79a4b )
    {
        function_43891dc1856ceef1( hiddenscriptable, [ player ] );
    }
    
    if ( !level.var_4508d217b77df9cc )
    {
        var_2439dc8be20ad247 = getdvarint( @"hash_acab7b7dcb40168b", 4 );
        level.var_4508d217b77df9cc = throttle::throttle_initialize( "bongo_hidden_scriptable_manage", var_2439dc8be20ad247 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.var_4508d217b77df9cc, player );
        function_3f5f9aba0613d6c9( player );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x86621591, Offset: 0x5be9
// Size: 0x88
function private function_49f338be8a5662c1( player )
{
    if ( player.br_isplayerbeforeinitialinfildeploy || !isalive( player ) || player.ffsm_state == 1 )
    {
        return;
    }
    
    if ( player isvehicleactive() )
    {
        return [ getdvarint( @"hash_9d240a8053daf65d" ), getdvarint( @"hash_70008f25f9207a20" ) ];
    }
    
    return [ getdvarint( @"hash_290d30cc0d01c12a" ), getdvarint( @"hash_29d3990a48ef18e7" ) ];
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xeb3d875, Offset: 0x5c7a
// Size: 0xe8
function private function_3f5f9aba0613d6c9( player )
{
    var_c5eeb5bf17cb0c55 = function_49f338be8a5662c1( player );
    
    if ( var_c5eeb5bf17cb0c55 )
    {
        revealradius = var_c5eeb5bf17cb0c55[ 0 ];
        revealheight = var_c5eeb5bf17cb0c55[ 1 ];
        
        /#
            if ( getdvarint( @"hash_e196fc8cbfa9c57c", 0 ) )
            {
                if ( !player.var_50ae509df1db4b4 )
                {
                    player.var_50ae509df1db4b4 = spawnquestcircle( "<dev string:x77>", player.origin[ 0 ], player.origin[ 1 ], revealradius );
                }
                
                player.var_50ae509df1db4b4 moveto( ( player.origin[ 0 ], player.origin[ 1 ], revealradius ), 0.05 );
            }
        #/
        
        function_12c802b01c13329( player.team, player.origin, revealradius, revealheight );
    }
}

// Namespace br_gametype_bongo
// Params 4, eflags: 0x4
// Checksum 0xb9e6aed5, Offset: 0x5d6a
// Size: 0x1c7
function private function_12c802b01c13329( team, revealorigin, revealradius, revealheight = 0 )
{
    if ( !getdvarint( @"hash_73deae6bc6f167db" ) )
    {
        return;
    }
    
    if ( level.var_87b5616c20a9602d )
    {
        teammates = teams::getteamdata( team, "players" );
        hiddenscriptables = level.var_87b5616c20a9602d utility::function_822c5feaca90abc1( revealorigin, revealradius, 0 );
        
        foreach ( hiddenscriptable in hiddenscriptables )
        {
            if ( revealheight == 0 || abs( hiddenscriptable.origin[ 2 ] - revealorigin[ 2 ] ) < revealheight )
            {
                function_b34353b790457af9( hiddenscriptable, teammates );
            }
        }
    }
    
    foreach ( hiddenscriptable in level.var_6fc8ae7c0ec79a4b )
    {
        if ( distance2dsquared( hiddenscriptable.origin, revealorigin ) < revealradius * revealradius )
        {
            if ( revealheight == 0 || abs( hiddenscriptable.origin[ 2 ] - revealorigin[ 2 ] ) < revealheight )
            {
                function_b34353b790457af9( hiddenscriptable, teammates );
            }
        }
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xad56b0cd, Offset: 0x5f39
// Size: 0x17c
function private function_b34353b790457af9( scriptable, players )
{
    if ( isdefined( scriptable.scriptedobjid ) )
    {
        foreach ( player in players )
        {
            objective_addclienttomask( scriptable.scriptedobjid, player );
        }
        
        return;
    }
    
    if ( isent( scriptable ) )
    {
        foreach ( player in players )
        {
            scriptable showtoplayer( player );
        }
        
        return;
    }
    
    foreach ( player in players )
    {
        scriptable function_6113853a877d5460( player );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xa33a266d, Offset: 0x60bd
// Size: 0x18c
function private function_43891dc1856ceef1( scriptable, players )
{
    if ( isdefined( scriptable.scriptedobjid ) )
    {
        objective_showtoplayersinmask( scriptable.scriptedobjid );
        
        foreach ( player in players )
        {
            objective_removeclientfrommask( scriptable.scriptedobjid, player );
        }
        
        return;
    }
    
    if ( isent( scriptable ) )
    {
        foreach ( player in players )
        {
            scriptable hidefromplayer( player );
        }
        
        return;
    }
    
    foreach ( player in players )
    {
        scriptable function_d6a7b7ef13a57f38( player );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xc748f027, Offset: 0x6251
// Size: 0xc8
function private function_3b4bee4a10e4fc72( scriptable, var_93d7c08934e6fe53 )
{
    level.var_d9a59c65e30b6e7c = arraycombine( [ scriptable ], level.var_d9a59c65e30b6e7c );
    scriptable.var_f74a60fb93085714 = var_93d7c08934e6fe53;
    
    foreach ( player in level.players )
    {
        if ( var_93d7c08934e6fe53 )
        {
            scriptable function_6113853a877d5460( player );
            continue;
        }
        
        scriptable function_d6a7b7ef13a57f38( player );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x72d83aa6, Offset: 0x6321
// Size: 0xac
function private function_38da480cae458734( scriptable, moving )
{
    if ( !getdvarint( @"hash_73deae6bc6f167db" ) )
    {
        return;
    }
    
    if ( moving )
    {
        if ( !isdefined( level.var_6fc8ae7c0ec79a4b ) )
        {
            level.var_6fc8ae7c0ec79a4b = [];
        }
        
        level.var_6fc8ae7c0ec79a4b[ level.var_6fc8ae7c0ec79a4b.size ] = scriptable;
    }
    else
    {
        if ( !level.var_87b5616c20a9602d )
        {
            level.var_87b5616c20a9602d = utility::create_partition( [], getdvarint( @"hash_290d30cc0d01c12a" ), 1 );
        }
        
        level.var_87b5616c20a9602d utility::add_to_partition( scriptable );
    }
    
    function_43891dc1856ceef1( scriptable, level.players );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x588d289f, Offset: 0x63d5
// Size: 0x26
function private function_ecb37cd67f5ac146()
{
    self.agentdamagefeedback = 1;
    
    if ( getdvarint( @"hash_d16b43142c5bb967", 1 ) )
    {
        thread function_b923221d6d025a66();
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xbd752e49, Offset: 0x6403
// Size: 0x109
function private function_b923221d6d025a66()
{
    if ( !self.owner )
    {
        return;
    }
    
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 5;
        
        if ( distance2dsquared( self.origin, self.owner.origin ) > 640000 )
        {
            ownersright = self.owner.origin + anglestoright( self.owner.angles ) * 100;
            dawg::function_8f769ad7e90f97e2( ownersright );
        }
        
        /#
            if ( getdvarint( @"bot_drawdebuggametype", 0 ) )
            {
                if ( self.var_5450284b654f895f )
                {
                    sphere( self.var_5450284b654f895f, 50, ( 1, 0, 0 ), 0, 80 );
                }
                
                circle( self.origin, 800, undefined, ( 1, 0, 0 ), 0, 80 );
            }
        #/
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x65167dac, Offset: 0x6514
// Size: 0x180
function private function_80549647da0bf11d( params )
{
    activityinstance = params[ 0 ];
    player = params[ 1 ];
    var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
    
    if ( !var_332f929de1894b2b.focussettings || var_332f929de1894b2b.focussettings.size == 0 )
    {
        return 0;
    }
    
    focusstage = function_f05dc41b3b80a656( activityinstance, player );
    var_cb9af2eda74a082f = var_332f929de1894b2b.focussettings[ focusstage ];
    assert( isdefined( var_cb9af2eda74a082f ), "<dev string:x84>" + activityinstance.varianttag + "<dev string:x9d>" + focusstage );
    activitycenter = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    var_6ced70cdaff3108 = distance2d( player.origin, activitycenter );
    focusscore = lerp( var_cb9af2eda74a082f.var_a73ae914fecc263c, var_cb9af2eda74a082f.var_47618e5c0ecd31e9, ( var_6ced70cdaff3108 - var_cb9af2eda74a082f.closedistance ) / ( var_cb9af2eda74a082f.fardistance - var_cb9af2eda74a082f.closedistance ) );
    
    if ( var_cb9af2eda74a082f.var_a73ae914fecc263c < var_cb9af2eda74a082f.var_47618e5c0ecd31e9 )
    {
        return clamp( focusscore, var_cb9af2eda74a082f.var_a73ae914fecc263c, var_cb9af2eda74a082f.var_47618e5c0ecd31e9 );
    }
    
    return clamp( focusscore, var_cb9af2eda74a082f.var_47618e5c0ecd31e9, var_cb9af2eda74a082f.var_a73ae914fecc263c );
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0xf769fde0, Offset: 0x669c
// Size: 0x43
function private function_f05dc41b3b80a656( activityinstance, player )
{
    if ( activityinstance.var_d7902a99156f281e )
    {
        return activityinstance [[ activityinstance.var_d7902a99156f281e ]]( player );
    }
    
    return activityinstance.focusstage ?? 0;
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x3eeb54d9, Offset: 0x66e8
// Size: 0xd1, Type: bool
function private function_ecba7a34dc3dca21( item, lootid )
{
    if ( !common_inventory_groups::inventorygroup_enabled() )
    {
        return false;
    }
    
    if ( !common_inventory::function_7ec5937e3b3d86e0( item.scriptablename ) )
    {
        return false;
    }
    
    if ( item.weaponobj )
    {
        return false;
    }
    
    itembundle = common_item::function_80af1e9daffacc7d( item.type );
    itembundlename = common_item::function_e044c3e813daec3a( itembundle );
    var_93ca4f09d0d5e3f8 = common_inventory::function_e332683b9ad5368b( lootid, 1, 0, item ) || common_item::function_5f81801cb8c86ac2( itembundlename, itembundle, item );
    
    if ( var_93ca4f09d0d5e3f8 )
    {
        return false;
    }
    
    if ( !item.var_328ae4e0cf700246 && getdvarint( @"hash_e26fe7859bf552e9", 1 ) )
    {
        item magicbox::function_d6cb29bad3ee9a9( self );
    }
    
    return true;
}

// Namespace br_gametype_bongo
// Params 1
// Checksum 0x75dc4344, Offset: 0x67c2
// Size: 0xe6
function onagentkilled( sparams )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    player = sparams.eattacker;
    
    if ( isplayer( player ) )
    {
        deathdata = spawnstruct();
        deathdata.hitloc = sparams.shitloc;
        weapongroup = weapon::getweapongroup( sparams.sweapon );
        player events::function_a2d92a4b5cb17d36( self, sparams.sweapon, weapongroup, sparams.smeansofdeath, sparams.einflictor, deathdata );
        challenges::onagentkilled( self, sparams.einflictor, player, sparams.idamage, sparams.smeansofdeath, sparams.sweapon, player.modifiers );
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x96e32cc, Offset: 0x68b0
// Size: 0xdf
function private luinotifylistener( notification, lootid )
{
    switch ( notification )
    {
        case #"hash_c329c47183e8fb37":
            if ( self.var_474b55d348aba0ff == lootid )
            {
                rootname = self.var_23d45d4663c7f493;
                
                if ( !isdefined( self.var_1d4ab7f129d85a07[ rootname ] ) )
                {
                    self.var_1d4ab7f129d85a07[ rootname ] = [];
                }
                
                self.var_1d4ab7f129d85a07[ rootname ][ self.var_1d4ab7f129d85a07[ rootname ].size ] = lootid;
                self.var_474b55d348aba0ff = undefined;
                self.var_23d45d4663c7f493 = undefined;
                self notify( #"ui_bongo_unlock_status_complete" );
            }
            
            break;
        case #"hash_b5c371b85d6670ec":
            if ( self.var_474b55d348aba0ff == lootid )
            {
                self.var_474b55d348aba0ff = undefined;
                self notify( #"ui_bongo_unlock_status_complete" );
            }
            
            break;
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x2a9f6644, Offset: 0x6997
// Size: 0x26e
function private function_831a807ed595d53d( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !getdvarint( @"hash_ab9d174ee749fb7c", 1 ) )
    {
        return;
    }
    
    if ( isbot( player ) || player isplayerheadless() )
    {
        return;
    }
    
    if ( !level.var_1810412d48219c71 )
    {
        level.var_1810412d48219c71 = [];
        var_74d81d009f700d36 = strtok( getdvar( @"hash_8453e9ceae2a862c", "" ), "," );
        
        foreach ( lootid in var_74d81d009f700d36 )
        {
            level.var_1810412d48219c71[ level.var_1810412d48219c71.size ] = int( lootid );
        }
    }
    
    foreach ( rootname in level.commonitem.var_e0eee057e60c129f )
    {
        var_b0637a440bc9418a = weapon::function_d5894d0f984841a( rootname );
        var_b0637a440bc9418a = arrayremove( var_b0637a440bc9418a, var_74d81d009f700d36 );
        var_b0637a440bc9418a = arrayrandomize( var_b0637a440bc9418a );
        
        foreach ( camoLootID in var_b0637a440bc9418a )
        {
            player.var_474b55d348aba0ff = camoLootID;
            player.var_23d45d4663c7f493 = rootname;
            player setclientomnvar( "ui_bongo_is_item_unlocked", camoLootID );
            player utility::waittill_any_timeout( 5, "ui_bongo_unlock_status_complete" );
            
            if ( player.var_1d4ab7f129d85a07[ rootname ].size >= getdvarint( @"hash_df882c8c04d0dee6", 15 ) )
            {
                break;
            }
        }
    }
}

// Namespace br_gametype_bongo
// Params 2, eflags: 0x4
// Checksum 0x419da4a3, Offset: 0x6c0d
// Size: 0x35
function private function_e9bf1c3c6539defa( player, weaponobj )
{
    rootname = getweaponrootstring( weaponobj );
    return player.var_1d4ab7f129d85a07[ rootname ];
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x75891d81, Offset: 0x6c4b
// Size: 0x24
function private function_1436202e0ca47ce4( weaponobj )
{
    if ( weaponobj.var_e4de3f79b4ac164f >= 6 )
    {
        return;
    }
    
    return weaponobj function_9c6bf5d30861db6();
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xb42b26b3, Offset: 0x6c78
// Size: 0xc1
function private function_5bb506241fcceb23( weaponobj )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( weaponobj.var_e4de3f79b4ac164f >= 6 )
    {
        return;
    }
    
    if ( self.var_2e6e138927b1b4b7 )
    {
        weaponobj = weaponobj function_9c6bf5d30861db6();
        return weaponobj withcamo( self.var_2e6e138927b1b4b7 );
    }
    
    camoLootID = utility::array_random( function_e9bf1c3c6539defa( self, weaponobj ) );
    
    if ( camoLootID )
    {
        camoitem = getlootiteminfofromid( camoLootID );
        var_307e7a513a367517 = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoitem.itemref ), #"ref" );
        weaponobj = weaponobj function_9c6bf5d30861db6();
        return weaponobj withcamo( var_307e7a513a367517 );
    }
}

/#

    // Namespace br_gametype_bongo
    // Params 0, eflags: 0x4
    // Checksum 0xabe9313, Offset: 0x6d41
    // Size: 0x97, Type: dev
    function private registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:xbe>" );
        devgui::add_devgui_func( "<dev string:xc5>", "<dev string:xdc>", &function_ae647a9a4a3006c4 );
        devgui::function_eaac4ba4b3caf621( "<dev string:xf3>", @"hash_e37ddcdfdafd20d6" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x123>" );
        devgui::add_devgui_func( "<dev string:x13d>", "<dev string:x146>", &function_b9618c1c8f468227 );
        devgui::add_devgui_func( "<dev string:x162>", "<dev string:x16b>", &function_36700a1279fe3abc );
        devgui::function_eaac4ba4b3caf621( "<dev string:x187>", @"hash_e196fc8cbfa9c57c" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gametype_bongo
    // Params 0, eflags: 0x4
    // Checksum 0x55adc960, Offset: 0x6de0
    // Size: 0x93, Type: dev
    function private function_ae647a9a4a3006c4()
    {
        caches = function_bbe3d6cf9ddda498( level.origin, 10000 );
        
        foreach ( cache in caches )
        {
            function_e5e54b4110a6b8c( cache );
        }
    }

    // Namespace br_gametype_bongo
    // Params 0, eflags: 0x4
    // Checksum 0x8499f252, Offset: 0x6e7b
    // Size: 0x1e2, Type: dev
    function private function_b8f8a2460061c23e()
    {
        level endon( #"game_ended" );
        var_830ab6b194397ae4 = level.activities.activitynexussettings.var_523ebb34350932c3 ?? 2;
        
        while ( true )
        {
            if ( !getdvarint( @"hash_e37ddcdfdafd20d6", 0 ) || !level.players.size )
            {
                wait var_830ab6b194397ae4;
                continue;
            }
            
            player = level.players[ 0 ];
            var_ccc91d79bfa22c3a = activity_participation::function_e8eabd79cc49540e( player );
            
            if ( var_ccc91d79bfa22c3a.size == 0 )
            {
                wait var_830ab6b194397ae4;
                continue;
            }
            
            foreach ( var_89e86063b91ce05c in player.activities.participatingactivities )
            {
                activityinstance = activity_common::getactivityinstance( var_89e86063b91ce05c.instanceid );
                
                if ( !activityinstance )
                {
                    continue;
                }
                
                focusstage = function_f05dc41b3b80a656( activityinstance, player );
                focusscore = function_80549647da0bf11d( [ activityinstance, player ] );
                var_461b437c9d0a6159 = activityinstance.varianttag + "<dev string:x19a>" + focusstage + "<dev string:x1a5>" + int( focusscore );
                print3d( activity_instance_common::function_776ee11e7acc64a5( activityinstance ) + ( 0, 0, 72 ), var_461b437c9d0a6159, ( 1, 1, 0 ), 1, 1, int( var_830ab6b194397ae4 * level.frameduration ), 1 );
            }
            
            wait var_830ab6b194397ae4;
        }
    }

    // Namespace br_gametype_bongo
    // Params 0, eflags: 0x4
    // Checksum 0x54f4d06, Offset: 0x7065
    // Size: 0x178, Type: dev
    function private function_b9618c1c8f468227()
    {
        var_aad5f79efa645830 = level.var_87b5616c20a9602d utility::function_67292ed50d12c006();
        
        foreach ( var_451edc7d53a7f763 in var_aad5f79efa645830 )
        {
            foreach ( hiddenscriptable in var_451edc7d53a7f763 )
            {
                function_b34353b790457af9( hiddenscriptable, level.players );
            }
        }
        
        foreach ( hiddenscriptable in level.var_6fc8ae7c0ec79a4b )
        {
            function_b34353b790457af9( hiddenscriptable, level.players );
        }
    }

    // Namespace br_gametype_bongo
    // Params 0, eflags: 0x4
    // Checksum 0xbfe41105, Offset: 0x71e5
    // Size: 0x178, Type: dev
    function private function_36700a1279fe3abc()
    {
        var_aad5f79efa645830 = level.var_87b5616c20a9602d utility::function_67292ed50d12c006();
        
        foreach ( var_451edc7d53a7f763 in var_aad5f79efa645830 )
        {
            foreach ( hiddenscriptable in var_451edc7d53a7f763 )
            {
                function_43891dc1856ceef1( hiddenscriptable, level.players );
            }
        }
        
        foreach ( hiddenscriptable in level.var_6fc8ae7c0ec79a4b )
        {
            function_43891dc1856ceef1( hiddenscriptable, level.players );
        }
    }

#/

// Namespace br_gametype_bongo
// Params 3
// Checksum 0x3fec45d, Offset: 0x7365
// Size: 0xd4
function spectatelog( player, msg, player2 )
{
    if ( getdvarint( @"hash_7e850dd9a35660d2", 1 ) )
    {
        name = player.testname ?? player.name;
        str = "SPECTATE DEBUG: " + gettime() + " - " + name + " - " + player.team + " - " + msg;
        
        if ( player2 )
        {
            name2 = player2.testname ?? player2.name;
            str += name2 + " - " + player2.team;
        }
        
        logstring( str );
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xd72cbb25, Offset: 0x7441
// Size: 0x52
function private function_8159e997216be3cc( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    attackerweapon = player.lastdroppableweaponobj;
    
    if ( !isdefined( attackerweapon ) )
    {
        return;
    }
    
    ammotype = item_ammo::function_b162feeed34a4640( attackerweapon );
    
    if ( !isdefined( ammotype ) )
    {
        return;
    }
    
    return ammotype;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x1f53152d, Offset: 0x749c
// Size: 0x27e
function private function_ce8b77c5f4063e91( params )
{
    items = [];
    
    if ( getdvarint( @"hash_2473de83683b80db", 0 ) )
    {
        currentplatecount = params.victim armor::function_22290101992e4874();
        var_4a228ff7b1cc5b08 = getdvarint( @"hash_cbb18513ea1f28fd", 1 );
        
        if ( currentplatecount <= 0 && var_4a228ff7b1cc5b08 > 0 )
        {
            armorbundlename = common_item_database::function_a4f0a21951180013( level.armorref ?? "equip_armorplate" );
            items[ items.size ] = { #itemname:armorbundlename, #quantity:var_4a228ff7b1cc5b08 };
        }
    }
    
    if ( getdvarint( @"hash_12b368c1f5477a56", 0 ) )
    {
        if ( isplayer( params.attacker ) && params.attacker != params.victim )
        {
            ammotype = function_8159e997216be3cc( params.attacker );
            
            if ( isdefined( ammotype ) )
            {
                var_641d0819f6d09277 = common_item_database::function_a4f0a21951180013( ammotype );
                
                if ( isdefined( var_641d0819f6d09277 ) )
                {
                    var_2f04bf092b60d380 = max( getdvarint( @"hash_8eab0ce1274dcc15", 1 ), 1 );
                    ammocount = item_ammo::function_b956ec34b65538e( ammotype );
                    items[ items.size ] = { #itemname:var_641d0819f6d09277, #quantity:ammocount * var_2f04bf092b60d380 };
                }
            }
        }
    }
    
    var_75fa7259e37b2202 = 0;
    
    if ( getdvarint( @"hash_d92876b9d403255a", 1 ) )
    {
        if ( !var_75fa7259e37b2202 && isplayer( params.victim ) && params.victim.wasexecuted )
        {
            var_3d53ebca264c4609 = common_item_database::function_a4f0a21951180013( "wz_consumable_aether_upgrade" );
            
            if ( isdefined( var_3d53ebca264c4609 ) )
            {
                items[ items.size ] = { #itemname:var_3d53ebca264c4609, #quantity:1 };
                var_75fa7259e37b2202 = 1;
            }
        }
    }
    
    if ( getdvarint( @"hash_834d3b6717fc6a53", 1 ) )
    {
        if ( !var_75fa7259e37b2202 && isplayer( params.attacker ) && namespace_2acee5c054dc328c::function_54071707336fc8a4( params.victim, params.attacker ) )
        {
            var_3d53ebca264c4609 = common_item_database::function_a4f0a21951180013( "wz_consumable_aether_upgrade" );
            
            if ( isdefined( var_3d53ebca264c4609 ) )
            {
                items[ items.size ] = { #itemname:var_3d53ebca264c4609, #quantity:1 };
                var_75fa7259e37b2202 = 1;
            }
        }
    }
    
    return items;
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x199fdfbc, Offset: 0x7723
// Size: 0x46
function private function_b424b66bf9048ab0( params )
{
    if ( !isdefined( params.itemtype ) )
    {
        return;
    }
    
    if ( params.itemtype == "armor_upgrade" && isdefined( self.temphealth ) )
    {
        function_fd756909a71f5519();
    }
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0xd6adf004, Offset: 0x7771
// Size: 0x6f
function private function_7c22a3bc6a315a9b( params )
{
    player = params.player;
    superinfo = params.superinfo;
    
    if ( superinfo.staticdata.ref == health_kit::function_712a3c3caa4ef0a7() && player.armor_upgrade )
    {
        player function_fd756909a71f5519();
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xd3631f42, Offset: 0x77e8
// Size: 0x11
function private function_fd756909a71f5519()
{
    challenges::function_37e945722d6497f3( self, "trauma_kit_and_armor_acquired", 1 );
}

// Namespace br_gametype_bongo
// Params 1, eflags: 0x4
// Checksum 0x7640e74, Offset: 0x7801
// Size: 0xef
function private function_21410e464931875c( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_6c8d6fa014a94cee = utility::callsharedfunc( #"common_item_armor_upgrade", #"hash_10300f9a006a73f6" );
    var_b2fa03dc20b7a455 = var_6c8d6fa014a94cee.tier ?? 0;
    
    if ( var_b2fa03dc20b7a455 <= 0 )
    {
        return;
    }
    
    if ( getdvarint( @"hash_b772360e3178554d", 0 ) )
    {
        common_item::function_bbba261e6fdc7e52( "armor_upgrade" );
        return;
    }
    
    if ( var_b2fa03dc20b7a455 >= 2 )
    {
        bundlename = common_item_database::function_a4f0a21951180013( "wz_consumable_armor_upgrade_level_" + var_b2fa03dc20b7a455 - 1 );
        
        if ( !isdefined( bundlename ) )
        {
            return;
        }
        
        itembundle = common_item::function_90c3e0c1fd55d6b6( bundlename );
        
        if ( !isdefined( itembundle ) )
        {
            return;
        }
        
        item = common_item::function_77600f92048df72d( itembundle );
        
        if ( !isdefined( item ) )
        {
            return;
        }
        
        common_item::function_bbba261e6fdc7e52( "armor_upgrade" );
        common_item::function_96119bed8ab4c5d9( item, 1 );
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x83c3e08, Offset: 0x78f8
// Size: 0xb6
function private function_42ace0b8829848f1()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !getdvarint( @"hash_17db5a220f717c2d", 0 ) )
    {
        return;
    }
    
    if ( isbot( self ) )
    {
        return;
    }
    
    self enableoffhandweapons();
    self notifyonplayercommand( "bongo_dpad_down_press", "+actionslot 2" );
    self notifyonplayercommand( "bongo_dpad_down_release", "-actionslot 2" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "bongo_dpad_down_press", "bongo_dpad_down_release" );
        
        switch ( msg )
        {
            case #"hash_ac5bee6f4428bad3":
                function_f2938698a132a5b4();
                break;
            case #"hash_5b199afd1a4e06e1":
                function_926f0e3d2885f804();
                break;
        }
    }
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x92870fc0, Offset: 0x79b6
// Size: 0x37
function private function_f2938698a132a5b4()
{
    assert( isplayer( self ) );
    
    if ( self isthrowinggrenade() )
    {
        return;
    }
    
    self disableoffhandweapons();
    val::set( "quick_equip", "killstreaks", 0 );
    thread function_2e40a71c3c7abdb9();
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xc3f0789e, Offset: 0x79f5
// Size: 0x32
function private function_926f0e3d2885f804()
{
    assert( isplayer( self ) );
    self enableoffhandweapons();
    val::reset( "quick_equip", "killstreaks" );
    self notify( #"bongo_dpad_down_released" );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x93984262, Offset: 0x7a2f
// Size: 0xe2
function private function_2e40a71c3c7abdb9()
{
    self endon( #"death_or_disconnect" );
    self endon( #"bongo_dpad_down_released" );
    var_d03e180fce043c56 = 10000;
    timestart = gettime();
    var_37dd4e31585ad223 = 0;
    var_693facdd00f2c1fd = 0;
    var_8e93f2483f218a8 = 0;
    
    while ( gettime() - timestart < var_d03e180fce043c56 )
    {
        var_3c81dc792bcf66a8 = self fragbuttonpressed();
        var_32501c51dcaaaa06 = self secondaryoffhandbuttonpressed();
        superpressed = self superbuttonpressed();
        
        if ( var_3c81dc792bcf66a8 && !var_37dd4e31585ad223 )
        {
            thread function_6dffc57aabe6a0a2();
        }
        
        if ( var_32501c51dcaaaa06 && !var_693facdd00f2c1fd )
        {
            thread function_2e48343c354d6885();
        }
        
        if ( superpressed && !var_8e93f2483f218a8 )
        {
            thread function_6b5af22de57932b3();
        }
        
        var_37dd4e31585ad223 = var_3c81dc792bcf66a8;
        var_693facdd00f2c1fd = var_32501c51dcaaaa06;
        var_8e93f2483f218a8 = superpressed;
        waitframe();
    }
    
    function_926f0e3d2885f804();
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xf6072b84, Offset: 0x7b19
// Size: 0x15
function private function_6dffc57aabe6a0a2()
{
    common_inventory_groups::function_d1ad55b9507ab500( 0, 8, 1, 0, 2, 2, 1 );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0xbf68183, Offset: 0x7b36
// Size: 0x1e
function private function_2e48343c354d6885()
{
    if ( self function_41360f0bcfc012aa() )
    {
        return;
    }
    
    common_inventory_groups::function_d1ad55b9507ab500( 0, 7, 1, 0, 1, 2, 1 );
}

// Namespace br_gametype_bongo
// Params 0, eflags: 0x4
// Checksum 0x6891d767, Offset: 0x7b5c
// Size: 0x15
function private function_6b5af22de57932b3()
{
    common_inventory_groups::function_d1ad55b9507ab500( 0, 5, 1, 0, 4, 2, 1 );
}

