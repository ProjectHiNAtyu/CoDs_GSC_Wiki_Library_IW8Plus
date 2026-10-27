// script_2dfc6d485f888188  (hash_2dfc6d485f888188.gscc) (size: 5769 Bytes / 0x1689 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa20571cc (2718265804)
// size ...... 5769 (0x1689)
// includes .. 14  (offset: 0x1555)
// strings ... 12  (offset: 0x15c5)
// dev strs .. 3   (offset: 0x1665)
// exports ... 18  (offset: 0xb29)
// cseg ...... 0x16b + 0x9be (0xb29)
// imports ... 66  (offset: 0xdf9)
// animtree1 . 0   (offset: 0x1689)
// animtree2 . 0   (offset: 0x1689)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\class;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;

#namespace activity_bongo_elite_enemy;

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x5
// Checksum 0x5fe15392, Offset: 0x189
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_bongo_elite_enemy", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0x2cfc34a4, Offset: 0x1b2
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BONGO_ELITE_ENEMY", &capture_point_activity_type_init );
}

// Namespace activity_bongo_elite_enemy
// Params 0
// Checksum 0xe7baa64d, Offset: 0x1cd
// Size: 0x86
function capture_point_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BONGO_ELITE_ENEMY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BONGO_ELITE_ENEMY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BONGO_ELITE_ENEMY", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "BONGO_ELITE_ENEMY", 4, &activity_get_center_point );
    
    if ( !isdefined( level.var_1aff81a7080bac1b ) )
    {
        level.var_1aff81a7080bac1b = [];
    }
    
    level.var_1aff81a7080bac1b[ "saw_bongo_activity_elite_enemy_objective_marker" ] = %"ping_location_go";
    
    /#
        registerdevgui();
    #/
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0x2f064f7c, Offset: 0x25b
// Size: 0x4a
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_d7902a99156f281e = &function_d7902a99156f281e;
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0x98ff0d7e, Offset: 0x2ad
// Size: 0xdf
function private function_477932e3884ea1fd()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    origin = activity_instance_common::function_776ee11e7acc64a5( activity );
    activity.request_id = ai_spawn_director::spawn_request( activity.var_332f929de1894b2b.encounter, origin, activity.var_332f929de1894b2b.spawnradius, 1, 1, 0 );
    ai_spawn_director::add_spawned_callback( activity.request_id, &manglerspawned, activity );
    ai_spawn_director::function_a49c35b72d6b6fea( activity.request_id, &function_e6648940e35ee232, activity );
    
    if ( getdvarint( @"hash_ca6d17d4ab9cb22b", 1 ) )
    {
        function_64ac8c4e752f4dca( activity.request_id, 0 );
    }
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0xd8550c4c, Offset: 0x394
// Size: 0x2f
function private function_d4acef179eb9f9b2()
{
    activity = self;
    
    if ( activity.request_id )
    {
        ai_spawn_director::cancel_spawn_request( activity.request_id );
    }
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0x2569887a, Offset: 0x3cb
// Size: 0x2c
function private activity_get_center_point()
{
    activity = self;
    return utility::function_8391781ea0784541( activity.enemies )[ 0 ].origin;
}

// Namespace activity_bongo_elite_enemy
// Params 1, eflags: 0x4
// Checksum 0x8f692260, Offset: 0x400
// Size: 0x9e, Type: bool
function private function_d7902a99156f281e( player )
{
    activity = self;
    
    foreach ( agent in activity.enemies )
    {
        if ( agent.enemy == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_bongo_elite_enemy
// Params 4, eflags: 0x4
// Checksum 0x433c36ee, Offset: 0x4a7
// Size: 0x212
function private manglerspawned( requestid, activity, agent, data )
{
    agent.var_1588af4d0f09a140 = &function_17cb46a9b5ceded1;
    agent.activity = activity;
    var_42488f59f4eb0372 = getdvar( @"hash_36fca0d53d90faa4", "veh_sat_mil_light_heli_wz" );
    agent.var_c9852ed12f30a7ab = strtok( var_42488f59f4eb0372, "," );
    agent callback::add( "on_zombie_ai_damaged", &function_975bf5c275577adc );
    br_activity_util::additemdrops( requestid, activity, agent, data );
    
    if ( !isdefined( activity.enemies ) )
    {
        activity.enemies = [];
    }
    
    activity.enemies = arraycombineunique( activity.enemies, [ agent ] );
    agent playsound( #"hash_d3f4d8220a0ee7a4" );
    agent waittill( #"death" );
    br_activity_util::function_333e692c891758bb( activity.var_47e6a16ebba92f77, "specialEnemiesKilled" );
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( activity ) )
    {
        player thread hud_message::showsplash( "br_bongo_cradle_breach_mangler_eliminated" );
    }
    
    realattacker = br_activity_util::function_501ceea91ee698e7( agent.lastattacker );
    
    if ( realattacker )
    {
        br_activity_util::activitylog( activity, "Mangler killed by " + realattacker.name );
        agent playsound( #"hash_b8fd3ef1618826a8" );
        
        if ( activity.var_332f929de1894b2b.var_b305ed5a5ed070bd )
        {
            activity thread function_a5801350398fdea1( realattacker, agent.origin );
        }
        
        return;
    }
    
    agent playsound( #"hash_b0cb20c628ad5867" );
}

// Namespace activity_bongo_elite_enemy
// Params 1, eflags: 0x4
// Checksum 0x365008a1, Offset: 0x6c1
// Size: 0x10f
function private function_975bf5c275577adc( dmg_struct )
{
    if ( dmg_struct.einflictor.vehiclename && arraycontains( self.var_c9852ed12f30a7ab, dmg_struct.einflictor.vehiclename ) )
    {
        dmg_struct.idamage = 0;
    }
    
    if ( isplayer( dmg_struct.eattacker ) && self.activity )
    {
        thread function_2219d354659834ca();
        
        if ( !isdefined( self.activity.var_47e6a16ebba92f77 ) )
        {
            self.activity.var_47e6a16ebba92f77 = [];
        }
        
        self.activity.var_47e6a16ebba92f77 = arraycombineunique( self.activity.var_47e6a16ebba92f77, [ dmg_struct.eattacker ] );
        activity_definition_utils::function_16b3cfd89a1669f7( 1, self.activity, { #players:[ dmg_struct.eattacker ] } );
    }
}

// Namespace activity_bongo_elite_enemy
// Params 0, eflags: 0x4
// Checksum 0x8d148db9, Offset: 0x7d8
// Size: 0x80
function private function_2219d354659834ca()
{
    self endon( #"death" );
    
    if ( !getdvarint( @"hash_bcdc3703be391e83", 1 ) || self.var_5d2ae75e1048091a || self.enemy )
    {
        return;
    }
    
    self.var_5d2ae75e1048091a = 1;
    wait getdvarint( @"hash_458131472a5765af", 5 );
    
    if ( !self.enemy )
    {
        self.health = self.maxhealth;
    }
    
    self.var_5d2ae75e1048091a = 0;
}

// Namespace activity_bongo_elite_enemy
// Params 1, eflags: 0x4
// Checksum 0x7b0fbfee, Offset: 0x860
// Size: 0x74
function private function_17cb46a9b5ceded1( agent )
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( agent );
    killingteam = agent.lastattacker.team;
    
    if ( killingteam )
    {
        spawnoptions.payload = [ #"teamselect", killingteam ];
        spawnoptions.spawningteam = killingteam;
    }
    
    return spawnoptions;
}

// Namespace activity_bongo_elite_enemy
// Params 2, eflags: 0x4
// Checksum 0xdf17e930, Offset: 0x8dd
// Size: 0xa0
function private function_fd11a1b2ef69f1ef( player, weaponscriptable )
{
    level endon( #"game_ended" );
    objective = objidpoolmanager::requestobjectiveid( 0 );
    objidpoolmanager::objective_add_objective( objective, "current", weaponscriptable.origin, "icn_loadout", "icon_regular" );
    objidpoolmanager::objective_playermask_hidefromall( objective );
    objidpoolmanager::objective_playermask_addshowplayer( objective, player );
    objidpoolmanager::objective_showdistance( objective, 0 );
    objective_setbackground( objective, 1 );
    objective_setzoffset( objective, 30 );
    weaponscriptable waittill( #"death" );
    
    if ( objective )
    {
        objective_delete( objective );
    }
}

// Namespace activity_bongo_elite_enemy
// Params 2, eflags: 0x4
// Checksum 0xd138c12b, Offset: 0x985
// Size: 0xf7
function private function_a5801350398fdea1( player, origin )
{
    favoriteloadout = player class::function_c076a1e54ebf636a();
    weapon = favoriteloadout.loadoutprimaryobject;
    
    if ( !weapon )
    {
        defaultloadout = player class::loadout_getorbuildclassstruct( "default1" );
        weapon = defaultloadout.loadoutprimaryobject;
    }
    
    assert( weapon );
    weapondata = { #count:item_weapon::function_40acef7fe7fe290( weapon, weapon.var_e4de3f79b4ac164f ), #var_2cb6d045c209a9ff:weapon };
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin );
    weaponscriptable = item_weapon::function_53da2af5697709f8( weapon, weapondata, spawnoptions );
    wait self.var_332f929de1894b2b.objectivemarkerdelay ?? 1.5;
    
    if ( !weaponscriptable )
    {
        return;
    }
    
    thread function_fd11a1b2ef69f1ef( player, weaponscriptable );
}

// Namespace activity_bongo_elite_enemy
// Params 3, eflags: 0x4
// Checksum 0x9b184574, Offset: 0xa84
// Size: 0x37
function private function_e6648940e35ee232( request_id, activity_instance, data )
{
    if ( activity_instance_common::function_be0fb090edaf64f( activity_instance ) == 0 )
    {
        return;
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

/#

    // Namespace activity_bongo_elite_enemy
    // Params 0, eflags: 0x4
    // Checksum 0x5dfeb2ee, Offset: 0xac3
    // Size: 0x2e, Type: dev
    function private registerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x33>", "<dev string:x50>", &function_385518107ff2081 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_bongo_elite_enemy
    // Params 0, eflags: 0x4
    // Checksum 0x8e3e3978, Offset: 0xaf9
    // Size: 0x30, Type: dev
    function private function_385518107ff2081()
    {
        player = level.players[ 0 ];
        thread function_a5801350398fdea1( player, player.origin );
    }

#/
