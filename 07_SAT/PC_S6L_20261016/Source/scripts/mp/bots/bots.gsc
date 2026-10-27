// scripts\mp\bots\bots.gsc  (hash_266c7a1b794e081d.gscc) (size: 45545 Bytes / 0xb1e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbdd107cb (3184592843)
// size ...... 45545 (0xb1e9)
// includes .. 33  (offset: 0xa7c9)
// strings ... 135 (offset: 0xa8d1)
// dev strs .. 19  (offset: 0xb0f9)
// exports ... 125 (offset: 0x6f29)
// cseg ...... 0x8e1 + 0x6648 (0x6f29)
// imports ... 305 (offset: 0x82b1)
// animtree1 . 0   (offset: 0xb1e9)
// animtree2 . 0   (offset: 0xb1e9)
#using script_112673e9f8209cf8;
#using script_2444b97a3516cbb0;
#using script_3bdadfff7554ceba;
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\bots\bots_killstreaks;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\door;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\loot\common_item;
#using scripts\mp\menus;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace bots;

// Namespace bots/bots_main
// Params 0, eflags: 0x20
// Checksum 0x323b5d2b, Offset: 0x8ff
// Size: 0xb5
function event_handler[bots_main] main()
{
    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
    {
        return;
    }
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    namespace_a60e6d7e4e2fbfbf::init();
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        bt_util::init();
        autopilot::initialize();
    }
    
    setup_callbacks();
    bots_personality::setup_personalities();
    bots_killstreaks::bot_killstreak_setup();
    wait 1.4;
    level thread init();
    level.var_4552bbd1719ea85e = 1;
    level.var_7b3547487b68a2cb = 1;
    callback::add( #"player_death", &onkilled );
    
    /#
        bots_debug::main();
    #/
}

// Namespace bots
// Params 0
// Checksum 0x979c7ebc, Offset: 0x9bc
// Size: 0x568
function setup_callbacks()
{
    level callback::add( #"player_disconnect", &on_player_disconnect );
    function_16ee54a35257162d();
    
    if ( !isdefined( level.bot_think_funcs[ "watch_enemy" ] ) )
    {
        level.bot_think_funcs[ "watch_enemy" ] = &bot_think_watch_enemy;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "tactical_goals" ] ) )
    {
        level.bot_think_funcs[ "tactical_goals" ] = &bots_tactical_goals::think_tactical_goals;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "seek_dropped_weapon" ] ) )
    {
        level.bot_think_funcs[ "seek_dropped_weapon" ] = &bot_think_seek_dropped_weapons;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "revive" ] ) )
    {
        level.bot_think_funcs[ "revive" ] = &bot_think_revive;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "crate" ] ) )
    {
        level.bot_think_funcs[ "crate" ] = &bot_think_crate;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "crate_blocking_path" ] ) )
    {
        level.bot_think_funcs[ "crate_blocking_path" ] = &bot_think_crate_blocking_path;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "usable_objects" ] ) )
    {
        level.bot_think_funcs[ "usable_objects" ] = &bot_think_usable_objects;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "fieldupgrades" ] ) )
    {
        level.bot_think_funcs[ "fieldupgrades" ] = &bot_think_fieldupgrades;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "killstreak" ] ) )
    {
        level.bot_think_funcs[ "killstreak" ] = &bots_killstreaks::bot_think_killstreak;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "watch_aerial_killstreak" ] ) )
    {
        level.bot_think_funcs[ "watch_aerial_killstreak" ] = &bots_killstreaks::bot_think_watch_aerial_killstreak;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "dynamic_doors" ] ) )
    {
        level.bot_think_funcs[ "dynamic_doors" ] = &bot_think_dynamic_doors;
    }
    
    if ( !isdefined( level.bot_think_funcs[ "nvg" ] ) )
    {
        level.bot_think_funcs[ "nvg" ] = &bot_think_nvg;
    }
    
    /#
        if ( !isdefined( level.var_3b46458ac8430bf0[ "<dev string:x24>" ] ) )
        {
            level.var_3b46458ac8430bf0[ "<dev string:x24>" ] = &bots_debug::bot_think_debug;
        }
    #/
    
    if ( !isdefined( level.bot_funcs[ "bots_spawn" ] ) )
    {
        level.bot_funcs[ "bots_spawn" ] = &spawn_bots;
    }
    
    if ( !isdefined( level.bot_funcs[ "should_pickup_weapons" ] ) )
    {
        level.bot_funcs[ "should_pickup_weapons" ] = &bot_should_pickup_weapons;
    }
    
    if ( !isdefined( level.bot_funcs[ "leader_dialog" ] ) )
    {
        level.bot_funcs[ "leader_dialog" ] = &bots_util_mp::bot_leader_dialog;
    }
    
    if ( !isdefined( level.bot_funcs[ "should_start_cautious_approach" ] ) )
    {
        level.bot_funcs[ "should_start_cautious_approach" ] = &bots_strategy::should_start_cautious_approach_default;
    }
    
    if ( !isdefined( level.bot_funcs[ "know_enemies_on_start" ] ) )
    {
        level.bot_funcs[ "know_enemies_on_start" ] = &bot_know_enemies_on_start;
    }
    
    if ( !isdefined( level.bot_funcs[ "dropped_weapon_think" ] ) )
    {
        level.bot_funcs[ "dropped_weapon_think" ] = &bot_think_seek_dropped_weapons;
    }
    
    if ( !isdefined( level.bot_funcs[ "dropped_weapon_cancel" ] ) )
    {
        level.bot_funcs[ "dropped_weapon_cancel" ] = &should_stop_seeking_weapon;
    }
    
    if ( !isdefined( level.bot_funcs[ "crate_can_use" ] ) )
    {
        level.bot_funcs[ "crate_can_use" ] = &crate_can_use_always;
    }
    
    if ( !isdefined( level.bot_funcs[ "crate_low_ammo_check" ] ) )
    {
        level.bot_funcs[ "crate_low_ammo_check" ] = &crate_low_ammo_check;
    }
    
    if ( !isdefined( level.bot_funcs[ "crate_should_claim" ] ) )
    {
        level.bot_funcs[ "crate_should_claim" ] = &crate_should_claim;
    }
    
    if ( !isdefined( level.bot_funcs[ "crate_wait_use" ] ) )
    {
        level.bot_funcs[ "crate_wait_use" ] = &crate_wait_use;
    }
    
    if ( !isdefined( level.bot_funcs[ "crate_in_range" ] ) )
    {
        level.bot_funcs[ "crate_in_range" ] = &crate_in_range;
    }
    
    if ( !isdefined( level.bot_funcs[ "bot_set_difficulty" ] ) )
    {
        level.bot_funcs[ "bot_set_difficulty" ] = &bots_util_mp::bot_set_difficulty;
    }
    
    if ( !isdefined( level.bot_funcs[ "bot_set_personality" ] ) )
    {
        level.bot_funcs[ "bot_set_personality" ] = &bots_util_mp::bot_set_personality;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "capture" ] ) )
    {
        level.var_60b0dc5ab729292a[ "capture" ] = &bots_scripted_defense::function_7cec708f5701acfc;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "capture_zone" ] ) )
    {
        level.var_60b0dc5ab729292a[ "capture_zone" ] = &bots_scripted_defense::function_c0a033de446b16d3;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "protect" ] ) )
    {
        level.var_60b0dc5ab729292a[ "protect" ] = &bots_scripted_defense::function_1cd96bc453e3e9f5;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "protect_zone" ] ) )
    {
        level.var_60b0dc5ab729292a[ "protect_zone" ] = &bots_scripted_defense::function_23c77d885f361d30;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "bodyguard" ] ) )
    {
        level.var_60b0dc5ab729292a[ "bodyguard" ] = &bots_scripted_defense::function_f4f6eb50019ab23b;
    }
    
    if ( !isdefined( level.var_60b0dc5ab729292a[ "patrol" ] ) )
    {
        level.var_60b0dc5ab729292a[ "patrol" ] = &bots_scripted_defense::find_defend_tacpoint_patrol;
    }
    
    if ( !bots_util::function_deef484b5b3a3977() )
    {
        if ( !isdefined( level.bot_funcs[ "gametype_think" ] ) )
        {
            level.bot_funcs[ "gametype_think" ] = &bot_default_think;
        }
    }
    
    flags::gameflaginit( "bots_setup_callbacks_ended", 1 );
}

// Namespace bots
// Params 0
// Checksum 0xecbb6b0f, Offset: 0xf2c
// Size: 0x6a
function bot_default_think()
{
    self notify( #"bot_default_think" );
    self endon( #"bot_default_think" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

// Namespace bots/leader_dialog
// Params 1, eflags: 0x20
// Checksum 0x4d3c0535, Offset: 0xf9e
// Size: 0x48
function event_handler[leader_dialog] leader_dialog( data )
{
    if ( isdefined( level.bot_funcs[ "leader_dialog" ] ) )
    {
        self [[ level.bot_funcs[ "leader_dialog" ] ]]( data.dialog, data.location );
    }
}

// Namespace bots
// Params 0
// Checksum 0xb96d6cdc, Offset: 0xfee
// Size: 0x25
function init()
{
    initbotlevelvariables();
    setmatchdata( "hasBots", 1 );
    level thread bot_connect_monitor();
    level thread bots_util::bot_queued_process_manager();
}

// Namespace bots
// Params 0
// Checksum 0x3c063a90, Offset: 0x101b
// Size: 0xb6
function initbotlevelvariables()
{
    if ( !isdefined( level.crateownerusetime ) )
    {
        level.crateownerusetime = 500;
    }
    
    if ( !isdefined( level.cratenonownerusetime ) )
    {
        level.cratenonownerusetime = 3000;
    }
    
    level.bot_out_of_combat_time = 3000;
    level.bot_respawn_launcher_name = "iw6_panzerfaust3";
    level.bot_fallback_weapon = "iw9_me_knife";
    level.bot_light_volumes = getentarray( "bot_light_area", #targetname );
    level.bot_dark_volumes = getentarray( "bot_dark_area", #targetname );
    createthreatbiasgroup( "Bots" );
    setthreatbias( "Killstreak_Static", "Bots", -200 );
    level.bot_variables_initialized = 1;
}

// Namespace bots
// Params 0
// Checksum 0xb3a81686, Offset: 0x10d9
// Size: 0x39
function bot_player_spawned()
{
    /#
        bots_debug::bot_player_spawned();
    #/
    
    if ( isdefined( level.bot_funcs[ "player_spawned_gamemode" ] ) )
    {
        self [[ level.bot_funcs[ "player_spawned_gamemode" ] ]]();
    }
    
    bots_loadout::bot_set_loadout_class();
}

// Namespace bots
// Params 0
// Checksum 0x4a197d04, Offset: 0x111a
// Size: 0x6f
function watch_players_connecting()
{
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( !isai( player ) && level.players.size > 0 )
        {
            level.players_waiting_to_join[ level.players_waiting_to_join.size ] = player;
            childthread bots_notify_on_spawn( player );
            childthread bots_notify_on_disconnect( player );
            childthread bots_remove_from_array_on_notify( player );
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0xd905630, Offset: 0x1191
// Size: 0x42
function bots_notify_on_spawn( player )
{
    player endon( #"bots_human_disconnected" );
    
    while ( !arraycontains( level.players, player ) )
    {
        wait 0.05;
    }
    
    player notify( #"bots_human_spawned" );
}

// Namespace bots
// Params 1
// Checksum 0xa900cb45, Offset: 0x11db
// Size: 0x34
function bots_notify_on_disconnect( player )
{
    player endon( #"bots_human_spawned" );
    player waittill( #"disconnect" );
    player notify( #"bots_human_disconnected" );
}

// Namespace bots
// Params 1
// Checksum 0x5a65bced, Offset: 0x1217
// Size: 0x37
function bots_remove_from_array_on_notify( player )
{
    player utility::waittill_any( "bots_human_spawned", "bots_human_disconnected" );
    level.players_waiting_to_join = arrayremove( level.players_waiting_to_join, player );
}

// Namespace bots
// Params 0
// Checksum 0x64695b2f, Offset: 0x1256
// Size: 0x48
function monitor_pause_spawning()
{
    level.players_waiting_to_join = [];
    childthread watch_players_connecting();
    
    while ( true )
    {
        if ( level.players_waiting_to_join.size > 0 )
        {
            level.pausing_bot_connect_monitor = 1;
        }
        else
        {
            level.pausing_bot_connect_monitor = 0;
        }
        
        wait 0.5;
    }
}

// Namespace bots
// Params 1
// Checksum 0xdf27a683, Offset: 0x12a6
// Size: 0x37, Type: bool
function bot_can_join_team( team )
{
    if ( game_utility_mp::matchmakinggame() )
    {
        return true;
    }
    
    if ( !level.teambased )
    {
        return true;
    }
    
    if ( teams::getjointeampermissions( team ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots
// Params 0
// Checksum 0x317cafbb, Offset: 0x12e6
// Size: 0x3c, Type: bool
function bot_allowed_to_switch_teams()
{
    if ( isdefined( level.bots_disable_team_switching ) && level.bots_disable_team_switching )
    {
        return false;
    }
    
    if ( isdefined( level.matchrules_switchteamdisabled ) && level.matchrules_switchteamdisabled )
    {
        return false;
    }
    
    return true;
}

// Namespace bots
// Params 0
// Checksum 0x9ec9b450, Offset: 0x132b
// Size: 0x310
function bot_connect_monitor()
{
    level endon( #"game_ended" );
    self notify( #"bot_connect_monitor" );
    self endon( #"bot_connect_monitor" );
    level.pausing_bot_connect_monitor = 0;
    childthread monitor_pause_spawning();
    childthread bot_monitor_team_limits();
    bot_connect_monitor_update_time = 1.5;
    var_a1ce9357f21dd729 = isdefined( level.uibotmanager );
    
    for ( ;; )
    {
        /#
            if ( getdvarint( @"scr_spawnbots", -1 ) != -1 )
            {
                utility::error( "<dev string:x2a>" );
            }
            
            if ( getdvar( @"hash_9e5da81386e98d36", "<dev string:x61>" ) != "<dev string:x61>" )
            {
                utility::error( "<dev string:x69>" );
            }
        #/
        
        disable_spawning = level.pausing_bot_connect_monitor;
        
        if ( getdvarint( @"hash_bf83ab2fda368593", 0 ) != 0 )
        {
            disable_spawning = 1;
        }
        
        if ( disable_spawning )
        {
            hostmigration::waitlongdurationwithhostmigrationpause( bot_connect_monitor_update_time );
            continue;
        }
        
        dropbotsifnecessary();
        utility::callsharedfunc( #"bots", #"hash_b4affa645366edaa" );
        new_bots = spawnbotsifnecessary( var_a1ce9357f21dd729 );
        
        for ( i = 0; i < new_bots.size ; i++ )
        {
            /#
                bots_debug::function_3a932c51f82f0f37();
            #/
            
            if ( new_bots[ i ].team == "free" )
            {
                new_bots[ i ].bot.bot_team = "autoassign";
            }
            else
            {
                new_bots[ i ].bot.bot_team = new_bots[ i ].team;
            }
            
            var_467fde514b3e3c19 = new_bots[ i ].squad;
            new_bots[ i ].bot.bot_squad = var_467fde514b3e3c19;
            new_bots[ i ].bot.loadoutdata = level.loadoutdata;
            
            if ( new_bots[ i ].istestclient )
            {
                new_bots[ i ].bot playerlogic::spawnspectator();
                new_bots[ i ].bot.btestclient = 1;
                new_bots[ i ].bot menus::autoassign();
                class = "class" + randomint( 3 );
                new_bots[ i ].bot notify( #"loadout_class_selected", class );
                new_bots[ i ].bot ui::lui_notify_callback( "class_select", class );
            }
            else
            {
                new_bots[ i ].bot.equipment_enabled = 1;
            }
            
            new_bots[ i ].bot namespace_ddca46d216b096e2::function_30b9db7247f23009();
            new_bots[ i ].bot bot_set_xuid();
            
            /#
                new_bots[ i ].bot thread bots_debug::function_2d7d75ca7c5cbc98();
            #/
        }
        
        if ( new_bots.size > 0 )
        {
            level notify( #"spawned_bots" );
        }
        
        hostmigration::waitlongdurationwithhostmigrationpause( bot_connect_monitor_update_time );
    }
}

// Namespace bots
// Params 0
// Checksum 0xe69709a3, Offset: 0x1643
// Size: 0x91
function bot_set_xuid()
{
    if ( isdefined( self.xuid ) && self.xuid != "" )
    {
        return;
    }
    
    if ( isdefined( self.uibotprofile ) && isdefined( self.uibotprofile.xuid ) && self.uibotprofile.xuid != "" )
    {
        self.xuid = self.uibotprofile.xuid;
        return;
    }
    
    self.xuid = self getplayerunoid();
}

// Namespace bots
// Params 0
// Checksum 0xea4b5cfa, Offset: 0x16dc
// Size: 0x176
function bot_monitor_team_limits()
{
    level endon( #"game_ended" );
    self notify( #"bot_monitor_team_limits" );
    self endon( #"bot_monitor_team_limits" );
    level.bot_max_players_on_team[ "allies" ] = 0;
    level.bot_max_players_on_team[ "axis" ] = 0;
    hostmigration::waitlongdurationwithhostmigrationpause( 0.5 );
    bot_connect_monitor_update_time = 1.5;
    
    if ( !level.var_ae4d3fde002fedb4 )
    {
        return;
    }
    
    while ( true )
    {
        if ( level.hasbots )
        {
            level.bot_max_players_on_team[ "allies" ] = 0;
            level.bot_max_players_on_team[ "axis" ] = 0;
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.team ) && ( player.team == "allies" || player.team == "axis" ) )
                {
                    level.bot_max_players_on_team[ player.team ]++;
                }
            }
            
            update_max_players_from_team_agents();
        }
        
        hostmigration::waitlongdurationwithhostmigrationpause( bot_connect_monitor_update_time );
    }
}

// Namespace bots
// Params 0
// Checksum 0x7170f338, Offset: 0x185a
// Size: 0xf6
function update_max_players_from_team_agents()
{
    if ( isdefined( level.agentarray ) && level.var_62f4f0f64754e5dc )
    {
        foreach ( agent in level.agentarray )
        {
            if ( agent.isactive && game_utility_common::isteamparticipant( agent ) && isdefined( agent.team ) && ( agent.team == "allies" || agent.team == "axis" ) )
            {
                level.bot_max_players_on_team[ agent.team ]++;
            }
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xfd62cb2d, Offset: 0x1958
// Size: 0x3a
function bot_get_player_team()
{
    var_7237854e3be197ca = self.team;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.pers[ "team" ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace bots
// Params 0
// Checksum 0x3d58753a, Offset: 0x199a
// Size: 0x94
function bot_get_host_team()
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) && player ishost() )
        {
            return player bot_get_player_team();
        }
    }
    
    return "spectator";
}

// Namespace bots
// Params 0
// Checksum 0x9cd146c5, Offset: 0x1a37
// Size: 0xd5, Type: bool
function bot_get_human_picked_team()
{
    havehost = 0;
    humanchose = 0;
    hostchose = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            if ( player ishost() )
            {
                havehost = 1;
            }
            
            if ( player_picked_team( player ) )
            {
                humanchose = 1;
                
                if ( player ishost() )
                {
                    hostchose = 1;
                }
            }
        }
    }
    
    return hostchose || humanchose && !havehost;
}

// Namespace bots
// Params 1
// Checksum 0xc4d43ed2, Offset: 0x1b15
// Size: 0x86, Type: bool
function player_picked_team( player )
{
    if ( isdefined( player.team ) && player.team != "spectator" )
    {
        return true;
    }
    
    if ( isdefined( player.spectating_actively ) && player.spectating_actively )
    {
        return true;
    }
    
    if ( player iscodcaster() && isdefined( player.team ) && player.team == "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace bots
// Params 0
// Checksum 0xf2350e87, Offset: 0x1ba4
// Size: 0xd9, Type: bool
function bot_get_human_picked_class()
{
    havehost = 0;
    humanchose = 0;
    hostchose = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            if ( player ishost() )
            {
                havehost = 1;
            }
            
            if ( isdefined( player.class ) )
            {
                humanchose = 1;
                
                if ( player ishost() )
                {
                    hostchose = 1;
                }
            }
        }
    }
    
    return hostchose || humanchose && !havehost;
}

// Namespace bots
// Params 0
// Checksum 0xedbd219e, Offset: 0x1c86
// Size: 0xe1
function bot_client_counts()
{
    clientcounts = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player ) && isdefined( player.team ) )
        {
            clientcounts = cat_array_add( clientcounts, "all" );
            clientcounts = cat_array_add( clientcounts, player.team );
            
            if ( isbot( player ) )
            {
                clientcounts = cat_array_add( clientcounts, "bots" );
                clientcounts = cat_array_add( clientcounts, "bots_" + player.team );
                continue;
            }
            
            clientcounts = cat_array_add( clientcounts, "humans" );
            clientcounts = cat_array_add( clientcounts, "humans_" + player.team );
        }
    }
    
    return clientcounts;
}

// Namespace bots
// Params 2
// Checksum 0x318ec321, Offset: 0x1d70
// Size: 0x38
function cat_array_add( arraycounts = [], category )
{
    if ( !isdefined( arraycounts[ category ] ) )
    {
        arraycounts[ category ] = 0;
    }
    
    arraycounts[ category ] += 1;
    return arraycounts;
}

// Namespace bots
// Params 2
// Checksum 0x37e3872f, Offset: 0x1db1
// Size: 0x2d
function cat_array_get( arraycounts, category )
{
    if ( !isdefined( arraycounts ) )
    {
        return 0;
    }
    
    if ( !isdefined( arraycounts[ category ] ) )
    {
        return 0;
    }
    
    return arraycounts[ category ];
}

// Namespace bots
// Params 0
// Checksum 0x368c1e30, Offset: 0x1de7
// Size: 0x3d
function bot_drop()
{
    assert( isbot( self ) );
    assert( self.connected );
    kick( self.entity_number, &"exe/playerkicked_bot_balance" );
    wait 0.1;
}

// Namespace bots
// Params 2
// Checksum 0x1d1c6256, Offset: 0x1e2c
// Size: 0x155
function drop_bots( count, team )
{
    bots = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.connected ) && player.connected && isbot( player ) && ( !isdefined( team ) || player.team == team ) )
        {
            bots[ bots.size ] = player;
        }
    }
    
    for ( i = bots.size - 1; i >= 0 ; i-- )
    {
        if ( count <= 0 )
        {
            break;
        }
        
        if ( !bots[ i ] player::isreallyalive() )
        {
            bots[ i ] bot_drop();
            bots = arrayremove( bots, bots[ i ] );
            count--;
        }
    }
    
    for ( i = bots.size - 1; i >= 0 ; i-- )
    {
        if ( count <= 0 )
        {
            break;
        }
        
        bots[ i ] bot_drop();
        count--;
    }
}

// Namespace bots
// Params 1
// Checksum 0xc81428bf, Offset: 0x1f89
// Size: 0x4d
function bot_lui_convert_team_to_int( team_name )
{
    if ( team_name == "axis" )
    {
        return 0;
    }
    
    if ( team_name == "allies" )
    {
        return 1;
    }
    
    if ( team_name == "autoassign" || team_name == "random" )
    {
        return 2;
    }
    
    return 3;
}

// Namespace bots
// Params 3
// Checksum 0x829f3000, Offset: 0x1fde
// Size: 0x172
function spawn_bot_latent( team, botcallback, connecting )
{
    function_wait_time = gettime() + 60000;
    
    while ( !self canspawnbotortestclient() )
    {
        if ( gettime() >= function_wait_time )
        {
            kick( self.entity_number, &"exe/playerkicked_bot_balance" );
            connecting.abort = 1;
            println( "<dev string:xb2>" );
            return;
        }
        
        wait 0.05;
        
        if ( !isdefined( self ) )
        {
            connecting.abort = 1;
            println( "<dev string:xe2>" );
            return;
        }
    }
    
    if ( !isdefined( self ) )
    {
        connecting.abort = 1;
        println( "<dev string:x11f>" );
        return;
    }
    
    self spawnbotortestclient();
    self.equipment_enabled = 1;
    self.bot_team = team;
    self.bot_squad = connecting.bot_squad;
    
    if ( !isdefined( connecting.difficulty ) )
    {
        connecting.difficulty = "regular";
    }
    
    if ( isdefined( connecting.difficulty ) )
    {
        bots_util_mp::bot_set_difficulty( connecting.difficulty );
    }
    
    if ( isdefined( connecting.mind_personality ) )
    {
        self.mind_personality = connecting.mind_personality;
    }
    
    if ( isdefined( botcallback ) )
    {
        self [[ botcallback ]]();
    }
    
    connecting.ready = 1;
}

// Namespace bots
// Params 7
// Checksum 0x79dabe0b, Offset: 0x2158
// Size: 0x30e
function spawn_bots( num_bots, team, botcallback, var_96b053bb0e850a74, var_84f55f032a811f8f, difficulty, fixedspawndata )
{
    if ( getdvarint( @"hash_bf83ab2fda368593", 0 ) != 0 )
    {
        return;
    }
    
    level.bot_spawn_in_progress = 1;
    function_wait_time = gettime() + 15000;
    connectingarray = [];
    squad_index = connectingarray.size;
    
    /#
        bots_debug::function_3a932c51f82f0f37();
    #/
    
    while ( level.players.size < bots_util_mp::bot_get_client_limit() && connectingarray.size < num_bots && gettime() < function_wait_time )
    {
        hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        bot = addbot( "" );
        
        if ( !isdefined( bot ) )
        {
            /#
                if ( gettime() >= function_wait_time )
                {
                    println( "<dev string:x15c>" );
                }
                else
                {
                    println( "<dev string:x199>" );
                }
            #/
            
            if ( var_96b053bb0e850a74 )
            {
                if ( isdefined( var_84f55f032a811f8f ) )
                {
                    self notify( var_84f55f032a811f8f );
                }
                
                return;
            }
            
            hostmigration::waitlongdurationwithhostmigrationpause( 1 );
            continue;
        }
        
        connecting = spawnstruct();
        connecting.bot = bot;
        connecting.ready = 0;
        connecting.abort = 0;
        connecting.index = squad_index;
        connecting.difficulty = difficulty;
        connectingarray[ connectingarray.size ] = connecting;
        
        /#
            if ( isdefined( fixedspawndata ) )
            {
                bot.pers[ #"fixedbotspawn" ] = 1;
                bot.pers[ #"fixedspawnorigin" ] = fixedspawndata.origin;
                bot.pers[ #"fixedspawnangles" ] = fixedspawndata.angles;
                
                if ( !isdefined( level.fixedspawnbots ) )
                {
                    level.fixedspawnbots = [];
                }
                
                level.fixedspawnbots[ level.fixedspawnbots.size ] = bot;
            }
        #/
        
        connecting.bot thread spawn_bot_latent( team, botcallback, connecting );
        squad_index++;
    }
    
    /#
        if ( gettime() >= function_wait_time )
        {
            println( "<dev string:x1d4>" );
        }
    #/
    
    connectedcomplete = 0;
    function_wait_time = gettime() + 60000;
    
    while ( connectedcomplete < connectingarray.size && gettime() < function_wait_time )
    {
        connectedcomplete = 0;
        
        foreach ( connecting in connectingarray )
        {
            if ( connecting.ready || connecting.abort )
            {
                connectedcomplete++;
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( var_84f55f032a811f8f ) )
    {
        self notify( var_84f55f032a811f8f );
    }
    
    level.bot_spawn_in_progress = undefined;
}

// Namespace bots
// Params 0
// Checksum 0x6bb39900, Offset: 0x246e
// Size: 0x59
function function_24a88f687d01018a()
{
    if ( game_utility_mp::matchmakinggame() && self.sessionteam != "none" )
    {
        allow_choice = 0;
    }
    else if ( !game_utility_mp::matchmakinggame() && !game_utility_mp::denysystemicteamchoice() && game_utility_mp::doesmodesupportplayerteamchoice() )
    {
        allow_choice = 1;
    }
    else
    {
        allow_choice = 0;
    }
    
    return allow_choice;
}

// Namespace bots
// Params 0
// Checksum 0x48fa013c, Offset: 0x24d0
// Size: 0x2b, Type: bool
function function_d368124e9c5a1809()
{
    if ( level.bots_gametype_handles_class_choice )
    {
        return false;
    }
    
    if ( game_utility_mp::allowclasschoice() )
    {
        return true;
    }
    
    if ( game_utility_mp::allowclasschoice( 1 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots
// Params 0
// Checksum 0x2785beae, Offset: 0x2504
// Size: 0x1d, Type: bool
function bot_is_ready_to_spawn()
{
    if ( !isdefined( self.classcallback ) )
    {
        if ( function_d368124e9c5a1809() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots
// Params 0
// Checksum 0x5a0de4ef, Offset: 0x252a
// Size: 0x50
function function_9b6e2d66066b7627()
{
    self notify( #"hash_8b4f5a77ce27a4d8" );
    self endon( #"hash_8b4f5a77ce27a4d8" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_3f02b54a95773416", new_difficulty );
        bots_util_mp::bot_set_difficulty( new_difficulty );
    }
}

// Namespace bots
// Params 2
// Checksum 0x1cc57534, Offset: 0x2582
// Size: 0x108
function function_7226c9d17a3ed27( firstspawn, var_380a0a237e98a972 )
{
    assert( isdefined( self.team ) || isdefined( self.pers[ "<dev string:x1f0>" ] ) );
    difficulty = self.pers[ "bot_difficulty" ] ?? self botgetdifficulty();
    bots_util_mp::bot_set_difficulty( difficulty );
    
    if ( firstspawn )
    {
        thread function_9b6e2d66066b7627();
    }
    
    personality = undefined;
    
    if ( !isdefined( personality ) )
    {
        if ( isdefined( self.pers[ "personality" ] ) )
        {
            personality = self.pers[ "personality" ];
        }
    }
    
    if ( var_380a0a237e98a972 )
    {
        self.var_9bb25959617b9a1c = 1;
    }
    else if ( !isdefined( personality ) )
    {
        var_f5eafd5bca0967e8 = self botgetdifficultysetting( "advancedPersonality" );
        
        if ( firstspawn && isdefined( var_f5eafd5bca0967e8 ) && var_f5eafd5bca0967e8 != 0 )
        {
            personality = bots_personality::function_e29000cf21a9c3be();
        }
    }
    
    if ( !isdefined( personality ) )
    {
        personality = self botgetpersonality();
    }
    
    bots_util_mp::bot_set_personality( personality );
}

// Namespace bots
// Params 0
// Checksum 0xff59ee2, Offset: 0x2692
// Size: 0x82
function function_fa199354d6a14b4b()
{
    self notify( #"hash_b9c711cf0a76ec27" );
    self endon( #"hash_b9c711cf0a76ec27" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_2d4bde50812f715c" );
        wait randomfloatrange( 1, 3 );
        
        if ( getdvarint( @"hash_6e8b31590c83b6", 0 ) )
        {
            self notify( #"forfeit_vote_accept" );
            continue;
        }
        
        if ( level.leagueplaymatch )
        {
            self notify( #"forfeit_vote_accept" );
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xf56f1724, Offset: 0x271c
// Size: 0x55
function function_da11fef8993884fd()
{
    self.enemyselector = %"enemyselector_bot";
    self.var_33737daecbeeab6e = "botsight";
    self function_630eac6fd6900a61( self.var_33737daecbeeab6e, 1 );
    
    if ( !threatbiasgroupexists( "Bots" ) )
    {
        createthreatbiasgroup( "Bots" );
    }
    
    self setthreatbiasgroup( "Bots" );
}

// Namespace bots
// Params 0
// Checksum 0xa53f25ef, Offset: 0x2779
// Size: 0x319
function bot_think()
{
    self notify( #"bot_think" );
    self endon( #"bot_think" );
    self endon( #"disconnect" );
    
    while ( !level.botloadouts.initialized )
    {
        waitframe();
    }
    
    bots_loadout::function_869a511557a60ad4();
    
    while ( !isdefined( self.pers[ "team" ] ) )
    {
        waitframe();
    }
    
    function_7226c9d17a3ed27( 1 );
    thread function_fa199354d6a14b4b();
    
    while ( !level.bot_variables_initialized )
    {
        waitframe();
    }
    
    level.hasbots = 1;
    
    if ( !function_24a88f687d01018a() )
    {
        self.bot_team = self.pers[ "team" ];
    }
    
    team = self.bot_team;
    
    if ( !isdefined( team ) )
    {
        team = self.pers[ "team" ];
    }
    
    self.entity_number = self getentitynumber();
    firstspawn = 0;
    
    if ( !isdefined( self.bot_spawned_this_round ) )
    {
        firstspawn = 1;
        self.bot_spawned_this_round = 1;
        
        if ( function_24a88f687d01018a() )
        {
            var_492cb3987da1a243 = self.pers[ "team" ] != "spectator" && !isdefined( self.bot_team );
            
            if ( !var_492cb3987da1a243 )
            {
                var_f42bac3561ef5fc9 = isdefined( self.bot_team ) && self.bot_team != self.pers[ "team" ];
                
                if ( var_f42bac3561ef5fc9 )
                {
                    ui::lui_notify_callback( "team_select", bot_lui_convert_team_to_int( team ) );
                }
                
                wait 0.5;
                
                if ( self.pers[ "team" ] == "spectator" )
                {
                    bot_drop();
                    return;
                }
            }
        }
    }
    
    while ( true )
    {
        function_7226c9d17a3ed27();
        
        if ( firstspawn )
        {
            if ( isdefined( level.bot_funcs[ "class_select_override" ] ) )
            {
                self [[ level.bot_funcs[ "class_select_override" ] ]]();
            }
            else
            {
                bots_loadout::bot_set_loadout_class();
                
                if ( function_d368124e9c5a1809() )
                {
                    if ( self.connecttime == gettime() )
                    {
                        waittillframeend();
                        waittillframeend();
                    }
                    
                    while ( !game_utility_mp::allowclasschoice() )
                    {
                        waitframe();
                    }
                    
                    ui::lui_notify_callback( "class_select", self.bot_class );
                }
            }
            
            if ( self.health == 0 )
            {
                self.bwaitingforteamselect = 1;
                self notify( #"hash_df28b3ea97310afa" );
                self waittill( #"spawned_player" );
                self.bwaitingforteamselect = undefined;
                self.bot_team = team;
            }
            
            function_da11fef8993884fd();
            
            if ( isdefined( level.bot_funcs[ "know_enemies_on_start" ] ) )
            {
                self thread [[ level.bot_funcs[ "know_enemies_on_start" ] ]]();
            }
            
            firstspawn = 0;
            function_abd267784d89d474();
            bots_util_mp::function_3a78b8550144eb18();
        }
        
        self function_630eac6fd6900a61( self.var_33737daecbeeab6e, 1 );
        bot_modify_behavior_from_tweakables();
        bot_restart_think_threads();
        wait 0.1;
        
        if ( isalive( self ) )
        {
            self waittill( #"death" );
        }
        
        bot_post_death_func();
        respawn_watcher();
        self waittill( #"spawned_player" );
    }
}

// Namespace bots
// Params 0
// Checksum 0x6db048d2, Offset: 0x2a9a
// Size: 0x37
function bot_post_death_func()
{
    if ( isalive( self ) )
    {
        bots_util::function_b5df752f95e3ba();
    }
    
    if ( isdefined( level.bot_funcs[ "post_death_func" ] ) )
    {
        self [[ level.bot_funcs[ "post_death_func" ] ]]();
    }
}

// Namespace bots
// Params 1
// Checksum 0x57122594, Offset: 0x2ad9
// Size: 0x47
function onkilled( params )
{
    if ( params.victim && ( isbot( params.victim ) || isautopilot( params.victim ) ) )
    {
        bot_killed_callback();
    }
}

// Namespace bots
// Params 0
// Checksum 0x50b6eb57, Offset: 0x2b28
// Size: 0x16
function bot_killed_callback()
{
    self.bot_death_time = gettime();
    bots_util::function_b5df752f95e3ba();
}

// Namespace bots
// Params 0
// Checksum 0xf830d08e, Offset: 0x2b46
// Size: 0x1b
function bot_modify_behavior_from_tweakables()
{
    if ( level.headshotsonly )
    {
        self botsetflag( "only_headshots", 1 );
    }
}

// Namespace bots
// Params 0
// Checksum 0xda150179, Offset: 0x2b69
// Size: 0x87
function respawn_watcher()
{
    self endon( #"started_spawnplayer" );
    
    while ( !self.waitingtospawn )
    {
        wait 0.05;
    }
    
    if ( playerlogic::needsbuttontorespawn() )
    {
        while ( self.waitingtospawn )
        {
            if ( self.sessionstate == "spectator" )
            {
                if ( level.numlives == 0 || self.pers[ "lives" ] > 0 )
                {
                    self botpressbutton( "use", 0.5 );
                }
            }
            
            wait 1;
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0xabb6ee82, Offset: 0x2bf8
// Size: 0xe, Type: bool
function function_c84d79ce363ba645( crate )
{
    return true;
}

// Namespace bots
// Params 1
// Checksum 0xd65875d4, Offset: 0x2c0f
// Size: 0x37, Type: bool
function crate_can_use_always( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return false;
    }
    
    if ( !function_c84d79ce363ba645( crate ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots
// Params 0
// Checksum 0x5515112f, Offset: 0x2c4f
// Size: 0x96
function get_human_player()
{
    result = undefined;
    players = getentarray( "player", #classname );
    
    if ( isdefined( players ) )
    {
        for ( index = 0; index < players.size ; index++ )
        {
            if ( isdefined( players[ index ] ) && players[ index ].connected && !isai( players[ index ] ) && ( !isdefined( result ) || result.team == "spectator" ) )
            {
                result = players[ index ];
            }
        }
    }
    
    return result;
}

// Namespace bots
// Params 9
// Checksum 0x137dca0f, Offset: 0x2cee
// Size: 0x1d8
function bot_damage_callback( eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint, lightarmordamage = 0, idflags )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_BUMP" )
    {
        return;
    }
    
    if ( idamage <= 0 && lightarmordamage <= 0 )
    {
        return;
    }
    
    if ( !isdefined( einflictor ) )
    {
        if ( !isdefined( eattacker ) )
        {
            return;
        }
        
        einflictor = eattacker;
    }
    
    if ( isdefined( einflictor ) )
    {
        if ( isdefined( self.fnbotdamagecallback ) )
        {
            self [[ self.fnbotdamagecallback ]]( eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint, lightarmordamage, idflags );
        }
        
        if ( !isdefined( self.damageinfo ) )
        {
            self.damageinfo = [];
        }
        
        self.damageinfo[ "DamageTaken" ] = idamage;
        self.damageinfo[ "ArmorDamageTaken" ] = lightarmordamage;
        self.damageinfo[ "DamageSource" ] = getweaponbasename( sweapon );
        self.damageinfo[ "HitLocation" ] = shitloc;
        self.damageinfo[ "HitBy" ] = eattacker.name;
        
        if ( level.teambased )
        {
            if ( einflictor.team == self.team )
            {
                return;
            }
            else if ( isdefined( eattacker ) && eattacker.team == self.team )
            {
                return;
            }
        }
        
        attacker_ent = bots_util_mp::bot_get_known_attacker( eattacker, einflictor );
        
        if ( isent( attacker_ent ) )
        {
            self botsetattacker( attacker_ent );
        }
    }
    
    if ( isagent( self ) )
    {
        self notify( #"agentdamage" );
    }
}

// Namespace bots
// Params 11
// Checksum 0x8eb2c2cb, Offset: 0x2ece
// Size: 0x125
function on_bot_killed( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    self botclearscriptenemy();
    self botclearscriptgoal();
    attacker_ent = bots_util_mp::bot_get_known_attacker( attacker, einflictor );
    
    if ( isdefined( attacker_ent ) && isdefined( attacker_ent.helitype ) && ( attacker_ent.classname == "script_vehicle" || attacker_ent.classname == "script_model" ) )
    {
        respawn_chance = self botgetdifficultysetting( "launcherRespawnChance" );
        
        if ( randomfloat( 1 ) < respawn_chance )
        {
            self.respawn_with_launcher = 1;
        }
    }
    
    change_class_chance = 0.1;
    
    if ( randomfloat( 1 ) < change_class_chance )
    {
        bots_loadout::function_605c93dfe43e02ee();
    }
    
    /#
        bots_debug::function_f4ab7b07a673d429( objweapon );
    #/
}

// Namespace bots
// Params 4
// Checksum 0xa76706ee, Offset: 0x2ffb
// Size: 0x17d
function function_be8d6ad4371f7b67( attacker, inflictor, victim, deathdata )
{
    killing_entity = bots_util_mp::bot_get_known_attacker( attacker, inflictor );
    
    if ( isdefined( killing_entity ) )
    {
        if ( game_utility_common::isaigameparticipant( victim ) && !isagent( victim ) )
        {
            assert( !isdefined( killing_entity.classname ) || killing_entity.classname != "<dev string:x1f5>" && killing_entity.classname != "<dev string:x200>" );
            victim botmemoryevent( "death", deathdata.weaponfullstring, killing_entity.origin, victim.origin, killing_entity );
        }
        
        if ( game_utility_common::isaigameparticipant( attacker ) && !isagent( attacker ) )
        {
            should_record_kill = 1;
            
            if ( isdefined( killing_entity.classname ) && ( killing_entity.classname == "script_vehicle" && isdefined( killing_entity.helitype ) || killing_entity.classname == "rocket" || killing_entity.classname == "misc_turret" ) )
            {
                should_record_kill = 0;
            }
            
            if ( should_record_kill )
            {
                attacker botmemoryevent( "kill", deathdata.weaponfullstring, killing_entity.origin, victim.origin, victim );
            }
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xa4be29fd, Offset: 0x3180
// Size: 0xde, Type: bool
function bot_should_do_killcam()
{
    if ( game[ "isLaunchChunk" ] )
    {
        return true;
    }
    
    /#
        if ( bots_debug::function_499f7032a6a4fbb8() )
        {
            return false;
        }
    #/
    
    skip_killcam_chance = 0;
    bot_difficulty = self botgetdifficulty();
    
    if ( bot_difficulty == "recruit" )
    {
        skip_killcam_chance = 0.1;
    }
    else if ( bot_difficulty == "regular" )
    {
        skip_killcam_chance = 0.4;
    }
    else if ( bot_difficulty == "hardened" )
    {
        skip_killcam_chance = 0.7;
    }
    else if ( bot_difficulty == "veteran" )
    {
        skip_killcam_chance = 1;
    }
    else if ( bot_difficulty == "elite" )
    {
        skip_killcam_chance = 1;
    }
    else if ( bot_difficulty == "master" )
    {
        skip_killcam_chance = 1;
    }
    
    /#
        skip_killcam_chance = getdvarfloat( @"hash_9465918bde5118eb", skip_killcam_chance );
    #/
    
    return randomfloat( 1 ) < 1 - skip_killcam_chance;
}

// Namespace bots
// Params 0
// Checksum 0x69044d28, Offset: 0x3267
// Size: 0x4, Type: bool
function bot_should_pickup_weapons()
{
    return true;
}

// Namespace bots
// Params 0
// Checksum 0x512de9c5, Offset: 0x3274
// Size: 0x69
function bot_restart_think_threads()
{
    thread bot_think_gametype();
    var_23621b57ead5e58f = isdefined( self.bt );
    
    if ( var_23621b57ead5e58f )
    {
        self.var_e97e3258eda72385 = 1;
        self notify( #"bt_think_called" );
        function_c6f7fcc4ed5a585c( self.var_b0000032ff7f222e );
        return;
    }
    
    function_c6f7fcc4ed5a585c( "all" );
    
    /#
        function_ea4a1a6d7705b7ec( "<dev string:x20d>" );
    #/
}

// Namespace bots
// Params 1
// Checksum 0xeb992eee, Offset: 0x32e5
// Size: 0x149
function function_c6f7fcc4ed5a585c( threads )
{
    if ( !isdefined( threads ) || isarray( threads ) && threads.size == 0 )
    {
        return;
    }
    
    if ( isstring( threads ) && threads == "all" )
    {
        foreach ( var_ec9fb9d0637d028f in level.bot_think_funcs )
        {
            self thread [[ var_ec9fb9d0637d028f ]]();
        }
        
        return;
    }
    
    assert( isarray( threads ) );
    
    foreach ( var_8ff0ba336e89ebd in threads )
    {
        var_ec9fb9d0637d028f = level.bot_think_funcs[ var_8ff0ba336e89ebd ];
        assert( isdefined( var_ec9fb9d0637d028f ) );
        self thread [[ var_ec9fb9d0637d028f ]]();
    }
}

/#

    // Namespace bots
    // Params 1
    // Checksum 0x2a2d74d6, Offset: 0x3436
    // Size: 0x14c, Type: dev
    function function_ea4a1a6d7705b7ec( threads )
    {
        if ( !isdefined( threads ) || isarray( threads ) && threads.size == 0 )
        {
            return;
        }
        
        if ( isstring( threads ) && threads == "<dev string:x20d>" )
        {
            foreach ( var_ec9fb9d0637d028f in level.var_3b46458ac8430bf0 )
            {
                self thread [[ var_ec9fb9d0637d028f ]]();
            }
            
            return;
        }
        
        assert( isarray( threads ) );
        
        foreach ( var_8ff0ba336e89ebd in threads )
        {
            var_ec9fb9d0637d028f = level.var_3b46458ac8430bf0[ var_8ff0ba336e89ebd ];
            assert( isdefined( var_ec9fb9d0637d028f ) );
            self thread [[ var_ec9fb9d0637d028f ]]();
        }
    }

#/

// Namespace bots
// Params 0
// Checksum 0xc5846ac6, Offset: 0x358a
// Size: 0xdb
function bot_think_dynamic_doors()
{
    self notify( #"bot_think_dynamic_doors" );
    self endon( #"bot_think_dynamic_doors" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        doorpos = self getmodifierlocationonpath( "door", 64 );
        
        if ( isdefined( doorpos ) )
        {
            doorlist = getentarrayinradius( "dynamic_door", #targetname, doorpos, 64 );
            
            if ( doorlist.size > 0 )
            {
                door = function_47c86977a18df38b( doorlist, doorpos, 64 );
                
                if ( isdefined( door.state ) && door door::door_can_open_check() )
                {
                    door thread door::cheapopen( self );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots
// Params 0
// Checksum 0x3ae1c9df, Offset: 0x366d
// Size: 0x1fb
function bot_think_nvg()
{
    self notify( #"bot_think_nvg" );
    self endon( #"bot_think_nvg" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    isnightmap = utility::isnightmap();
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        indarkvolume = 0;
        var_bc9b6c8c56df2939 = 0;
        
        if ( isdefined( level.bot_light_volumes ) )
        {
            foreach ( vol in level.bot_light_volumes )
            {
                if ( self istouching( vol ) )
                {
                    var_bc9b6c8c56df2939 = 1;
                    break;
                }
            }
        }
        
        if ( isdefined( level.bot_dark_volumes ) )
        {
            foreach ( vol in level.bot_dark_volumes )
            {
                if ( self istouching( vol ) )
                {
                    indarkvolume = 1;
                    break;
                }
            }
        }
        
        if ( self.inmotionlight )
        {
            var_bc9b6c8c56df2939 = 1;
        }
        
        if ( indarkvolume || isnightmap && !var_bc9b6c8c56df2939 )
        {
            self botsetflag( "in_dark_area", 1 );
            self.indarkarea = 1;
        }
        else if ( !indarkvolume && self.indarkarea )
        {
            self botsetflag( "in_dark_area", 0 );
            self.indarkarea = 0;
        }
        
        wait 0.25;
    }
}

// Namespace bots
// Params 1
// Checksum 0x597d6e0d, Offset: 0x3870
// Size: 0xad
function bot_think_watch_enemy( bendondeath )
{
    self notify( #"bot_think_watch_enemy" );
    self endon( #"bot_think_watch_enemy" );
    self endon( #"exit_autopilot" );
    self endon( #"disconnect" );
    
    if ( bendondeath )
    {
        self endon( #"death" );
    }
    
    level endon( #"game_ended" );
    self.last_enemy_sight_time = 0;
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( self.enemy ) )
        {
            if ( self botcanseeentity( self.enemy ) )
            {
                self.last_enemy_sight_time = gettime();
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots
// Params 0
// Checksum 0x1e402ffd, Offset: 0x3925
// Size: 0x325
function bot_think_seek_dropped_weapons()
{
    self notify( #"bot_think_seek_dropped_weapons" );
    self endon( #"bot_think_seek_dropped_weapons" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait randomfloatrange( 0.25, 0.75 );
        
        if ( bots_util::bot_out_of_ammo() && !bots_util::bot_is_remote_or_linked() )
        {
            should_pickup_weapons_func = level.bot_funcs[ "should_pickup_weapons" ];
            should_pickup_weapons = self [[ should_pickup_weapons_func ]]();
            
            if ( should_pickup_weapons )
            {
                dropped_weapons = getentarray( "dropped_weapon", #targetname );
                dropped_weapons_sorted = utility::get_array_of_closest( self.origin, dropped_weapons );
                
                if ( dropped_weapons_sorted.size > 0 )
                {
                    dropped_weapon = dropped_weapons_sorted[ 0 ];
                    
                    if ( !dropped_weapon.calculated_closest_point )
                    {
                        dropped_weapon.closest_navmesh_point = self getclosestreachablepointonnavmesh( dropped_weapon.origin );
                        dropped_weapon.calculated_closest_point = 1;
                    }
                    
                    if ( isdefined( dropped_weapon.closest_navmesh_point ) )
                    {
                        bot_seek_dropped_weapon( dropped_weapon );
                    }
                }
            }
        }
        
        if ( !bots_util::bot_in_combat() && !bots_util::bot_is_remote_or_linked() && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            bot_lethal = self botfirstavailablegrenade( "lethal" );
            bot_tactical = self botfirstavailablegrenade( "tactical" );
            equipped_knife = undefined;
            
            if ( isdefined( bot_lethal ) && bot_lethal.classname == "throwingknife" )
            {
                equipped_knife = bot_lethal;
            }
            else if ( isdefined( bot_tactical ) && bot_tactical.classname == "throwingknife" )
            {
                equipped_knife = bot_tactical;
            }
            
            if ( isdefined( equipped_knife ) )
            {
                if ( self getammocount( equipped_knife ) == 0 )
                {
                    if ( isdefined( self.going_for_knife ) )
                    {
                        wait 5;
                        continue;
                    }
                    
                    dropped_knives = arraycombine( getentarray( "dropped_knife", #targetname ), getentarray( "dropped_combataxe", #targetname ) );
                    dropped_knives_sorted = utility::get_array_of_closest( self.origin, dropped_knives );
                    
                    foreach ( knife in dropped_knives_sorted )
                    {
                        if ( !isdefined( knife.calculated_closest_point ) )
                        {
                            knife.closest_navmesh_point = self getclosestreachablepointonnavmesh( knife.origin );
                            knife.calculated_closest_point = 1;
                        }
                        
                        if ( isdefined( knife.closest_navmesh_point ) )
                        {
                            self.going_for_knife = 1;
                            bot_seek_dropped_weapon( knife );
                        }
                    }
                    
                    continue;
                }
                
                self.going_for_knife = undefined;
            }
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0x7ee62090, Offset: 0x3c52
// Size: 0x16d
function bot_seek_dropped_weapon( dropped_weapon )
{
    if ( bots_tactical_goals::has_tactical_goal( "seek_dropped_weapon", dropped_weapon ) == 0 )
    {
        action_thread = undefined;
        
        if ( dropped_weapon.targetname == "dropped_weapon" )
        {
            var_9d66e89aefc3eae7 = 1;
            heldweapons = self getweaponslistprimaries();
            
            foreach ( held_weapon in heldweapons )
            {
                if ( dropped_weapon.model == getweaponmodel( held_weapon ) )
                {
                    var_9d66e89aefc3eae7 = 0;
                }
            }
            
            if ( var_9d66e89aefc3eae7 )
            {
                action_thread = &bot_pickup_weapon;
            }
        }
        
        extra_params = spawnstruct();
        extra_params.object = dropped_weapon;
        extra_params.script_goal_radius = 12;
        extra_params.should_abort = level.bot_funcs[ "dropped_weapon_cancel" ];
        extra_params.action_thread = action_thread;
        location = dropped_weapon.closest_navmesh_point ?? dropped_weapon.origin;
        bots_tactical_goals::new_tactical_goal( "seek_dropped_weapon", location, 100, extra_params );
    }
}

// Namespace bots
// Params 1
// Checksum 0x55e5b5d4, Offset: 0x3dc7
// Size: 0x1c
function bot_pickup_weapon( goal )
{
    self botpressbutton( "use", 2 );
    wait 2;
}

// Namespace bots
// Params 1
// Checksum 0x42b6e649, Offset: 0x3deb
// Size: 0xab, Type: bool
function should_stop_seeking_weapon( goal )
{
    if ( !isdefined( goal.object ) )
    {
        self.going_for_knife = undefined;
        return true;
    }
    
    if ( goal.object.targetname == "dropped_weapon" )
    {
        if ( !bots_util::bot_out_of_ammo() )
        {
            return true;
        }
    }
    else if ( goal.object.targetname == "dropped_knife" || goal.object.targetname == "dropped_combataxe" )
    {
        if ( bots_util::bot_in_combat() )
        {
            self.going_for_knife = undefined;
            return true;
        }
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0x5b30dcf, Offset: 0x3e9f
// Size: 0x52, Type: bool
function crate_in_range( crate )
{
    if ( !isdefined( crate.owner ) || crate.owner != self )
    {
        if ( distancesquared( self.origin, crate.origin ) > 4194304 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots
// Params 1
// Checksum 0x741b61f3, Offset: 0x3efa
// Size: 0x1de, Type: bool
function bot_crate_valid( crate )
{
    if ( !isdefined( crate ) )
    {
        return false;
    }
    
    cratecanuse = self [[ level.bot_funcs[ "crate_can_use" ] ]]( crate );
    
    if ( !cratecanuse )
    {
        if ( game_utility::getgametype() == "grnd" )
        {
            cratecanuse = 1;
        }
    }
    
    assert( isdefined( cratecanuse ), "<dev string:x211>" );
    
    if ( !cratecanuse )
    {
        return false;
    }
    
    if ( !crate_landed_and_on_path_grid( crate ) )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( crate.bomb ) && isdefined( crate.team ) && crate.team == self.team )
    {
        return false;
    }
    
    if ( !self [[ level.bot_funcs[ "crate_in_range" ] ]]( crate ) )
    {
        return false;
    }
    
    if ( isdefined( crate.boxtype ) )
    {
        if ( isdefined( level.boxsettings[ crate.boxtype ] ) && ![[ level.boxsettings[ crate.boxtype ].canusecallback ]]() )
        {
            return false;
        }
        
        if ( isdefined( crate.disabled_use_for[ self getentitynumber() ] ) && crate.disabled_use_for[ self getentitynumber() ] )
        {
            return false;
        }
        
        /#
            if ( isdefined( level.bot_can_use_box_by_type ) && !isdefined( level.bot_can_use_box_by_type[ crate.boxtype ] ) )
            {
                assertmsg( "<dev string:x25f>" + crate.boxtype + "<dev string:x26c>" );
                return false;
            }
        #/
        
        if ( !isdefined( level.bot_can_use_box_by_type ) || !self [[ level.bot_can_use_box_by_type[ crate.boxtype ] ]]( crate ) )
        {
            return false;
        }
    }
    else if ( bot_has_streak_in_crate( crate ) )
    {
        return false;
    }
    
    return isdefined( crate );
}

// Namespace bots
// Params 1
// Checksum 0x7a21eca0, Offset: 0x40e1
// Size: 0xd, Type: bool
function bot_has_streak_in_crate( crate )
{
    return false;
}

// Namespace bots
// Params 1
// Checksum 0x23a6d46, Offset: 0x40f7
// Size: 0x41, Type: bool
function crate_landed_and_on_path_grid( crate )
{
    assert( isdefined( crate ) );
    
    if ( !crate_has_landed( crate ) )
    {
        return false;
    }
    
    assert( isdefined( crate ) );
    
    if ( !crate_is_on_path_grid( crate ) )
    {
        return false;
    }
    
    return isdefined( crate );
}

// Namespace bots
// Params 1
// Checksum 0x1d16fe8b, Offset: 0x4141
// Size: 0x82, Type: bool
function crate_has_landed( crate )
{
    if ( isdefined( crate.boxtype ) )
    {
        return ( gettime() > crate.birthtime + 1000 );
    }
    else
    {
        if ( isdefined( crate.droppingtoground ) )
        {
            return !crate.droppingtoground;
        }
        
        if ( isdefined( crate.animname ) )
        {
            return false;
        }
        
        if ( isdefined( crate.avlinvel ) )
        {
            return ( crate.avlinvel < 0.01 );
        }
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0xc837bab2, Offset: 0x41cc
// Size: 0x47, Type: bool
function crate_is_on_path_grid( crate )
{
    assert( crate_has_landed( crate ) );
    
    if ( !isdefined( crate.on_navmesh ) )
    {
        function_a1e5e87a80b9cfa1( crate );
    }
    
    return isdefined( crate ) && crate.on_navmesh;
}

// Namespace bots
// Params 2
// Checksum 0x6b26b4ae, Offset: 0x421c
// Size: 0xed
function function_21d83e99839aefa3( tacpoint, crate )
{
    if ( crate.boxtype == "scavenger_bag" )
    {
        return ( abs( tacpoint.groundpos[ 0 ] - crate.origin[ 0 ] ) < 36 && abs( tacpoint.groundpos[ 0 ] - crate.origin[ 0 ] ) < 36 && abs( tacpoint.groundpos[ 0 ] - crate.origin[ 0 ] ) < 18 );
    }
    
    player_use_radius = getdvarfloat( @"bg_player_useradius" );
    var_111d32f14aeda84b = distancesquared( crate.origin, tacpoint.groundpos + ( 0, 0, 40 ) );
    return var_111d32f14aeda84b <= player_use_radius * player_use_radius;
}

// Namespace bots
// Params 1
// Checksum 0x5c6412d5, Offset: 0x4311
// Size: 0x229
function function_a1e5e87a80b9cfa1( crate )
{
    assert( !isdefined( crate.nearest_tacpoints ) );
    assert( !isdefined( crate.on_navmesh ) );
    crate thread crate_monitor_position();
    crate.on_navmesh = 0;
    var_58798902d6b8be37 = undefined;
    var_7efce52ca66df9db = undefined;
    
    if ( isdefined( crate.forcedisconnectuntil ) )
    {
        var_58798902d6b8be37 = crate.forcedisconnectuntil;
        var_7efce52ca66df9db = gettime() + 30000;
        crate.forcedisconnectuntil = var_7efce52ca66df9db;
        crate notify( #"path_disconnect" );
    }
    
    wait 0.05;
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    nearest_tacpoints = function_27314afb2c064a96( crate );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( isdefined( nearest_tacpoints ) && nearest_tacpoints.size > 0 )
    {
        crate.nearest_tacpoints = nearest_tacpoints;
        crate.on_navmesh = 1;
    }
    else
    {
        player_use_radius = getdvarfloat( @"bg_player_useradius" );
        closest_tacpoint = function_7801d05a86b06144( crate.origin, player_use_radius * 2, 0 )[ 0 ];
        crate_loc_on_ground = crate getpointinbounds( 0, 0, -1 );
        nearest_point = undefined;
        
        if ( crate.boxtype == "scavenger_bag" )
        {
            if ( bots_util::function_443e66298844a5a( crate.origin, player_use_radius ) )
            {
                nearest_point = crate.origin;
            }
        }
        else
        {
            nearest_point = getclosestpointonnavmesh( crate.origin );
        }
        
        if ( isdefined( closest_tacpoint ) && isdefined( nearest_point ) && abs( closest_tacpoint.groundpos[ 2 ] - crate_loc_on_ground[ 2 ] ) < 30 )
        {
            crate.nearest_points = [ nearest_point ];
            crate.nearest_tacpoints = [ closest_tacpoint ];
            crate.on_navmesh = 1;
        }
    }
    
    if ( isdefined( crate.forcedisconnectuntil ) )
    {
        if ( crate.forcedisconnectuntil == var_7efce52ca66df9db )
        {
            crate.forcedisconnectuntil = var_58798902d6b8be37;
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0x48306be3, Offset: 0x4542
// Size: 0x142
function function_27314afb2c064a96( crate )
{
    tacpoints = function_7801d05a86b06144( crate.origin, 256, 0 );
    
    for ( i = tacpoints.size; i > 0 ; i-- )
    {
        tacpoints[ i ] = tacpoints[ i - 1 ];
    }
    
    tacpoints[ 0 ] = findclosesttacpointinsight( crate.origin );
    var_cdad07fbc92a9642 = [];
    tacpoints_wanted = 1;
    
    if ( !isdefined( crate.boxtype ) )
    {
        tacpoints_wanted = 2;
    }
    
    for ( i = 0; i < tacpoints.size ; i++ )
    {
        tacpoint = tacpoints[ i ];
        
        if ( !( isdefined( tacpoint ) && isdefined( crate ) ) )
        {
            continue;
        }
        
        if ( !function_21d83e99839aefa3( tacpoint, crate ) )
        {
            if ( i == 0 )
            {
                continue;
            }
            else
            {
                break;
            }
        }
        
        wait 0.05;
        
        if ( !isdefined( crate ) )
        {
            break;
        }
        
        if ( sighttracepassed( crate.origin, tacpoint.groundpos + ( 0, 0, 55 ), 0, crate ) )
        {
            wait 0.05;
            
            if ( !isdefined( crate ) )
            {
                break;
            }
            
            var_cdad07fbc92a9642[ var_cdad07fbc92a9642.size ] = tacpoint;
            
            if ( var_cdad07fbc92a9642.size == tacpoints_wanted )
            {
                return var_cdad07fbc92a9642;
            }
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0x3eec6d17, Offset: 0x468d
// Size: 0xbc
function crate_get_bot_target( crate )
{
    if ( isdefined( crate.nearest_points ) )
    {
        return crate.nearest_points[ 0 ];
    }
    
    if ( isdefined( crate.nearest_tacpoints ) && crate.nearest_tacpoints.size > 0 )
    {
        if ( crate.nearest_tacpoints.size > 1 )
        {
            tacpoints_sorted = arrayreverse( self bottacpointscoremultiple( crate.nearest_tacpoints, "exposed" ) );
            return utility::random_weight_sorted( tacpoints_sorted ).groundpos;
        }
        else
        {
            return crate.nearest_tacpoints[ 0 ].groundpos;
        }
    }
    
    assertmsg( "<dev string:x288>" );
}

// Namespace bots
// Params 2
// Checksum 0x61b1503f, Offset: 0x4751
// Size: 0x68
function crate_get_bot_target_check_distance( crate, use_radius )
{
    var_7cbde54b5d13cacb = crate_get_bot_target( crate );
    var_7cbde54b5d13cacb = getclosestpointonnavmesh( var_7cbde54b5d13cacb, self );
    testradiussq = use_radius * 0.9;
    testradiussq *= testradiussq;
    
    if ( distancesquared( crate.origin, var_7cbde54b5d13cacb ) <= testradiussq )
    {
        return var_7cbde54b5d13cacb;
    }
    
    return;
}

// Namespace bots
// Params 0
// Checksum 0x2856e9eb, Offset: 0x47c1
// Size: 0x807
function bot_think_crate()
{
    self notify( #"bot_think_crate" );
    self endon( #"bot_think_crate" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player_use_radius = getdvarfloat( @"bg_player_useradius" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait_time = randomfloatrange( 2, 4 );
        utility::waittill_notify_or_timeout( "new_crate_to_take", wait_time );
        
        if ( isdefined( self.boxes ) && self.boxes.size == 0 )
        {
            self.boxes = undefined;
        }
        
        all_crates = level.carepackages;
        
        if ( !bots_util::bot_in_combat() && isdefined( self.boxes ) )
        {
            all_crates = arraycombine( all_crates, self.boxes );
        }
        
        if ( isdefined( level.bot_scavenger_bags ) && isdefined( self.perks[ "specialty_scavenger" ] ) )
        {
            all_crates = arraycombine( all_crates, level.bot_scavenger_bags );
        }
        
        if ( isdefined( level.cratedata ) )
        {
            foreach ( crate in level.cratedata.crates )
            {
                if ( isdefined( crate ) )
                {
                    all_crates[ all_crates.size ] = crate;
                }
            }
        }
        
        all_crates = function_5713d46873b29625( all_crates );
        
        if ( all_crates.size == 0 )
        {
            continue;
        }
        
        if ( bots_tactical_goals::has_tactical_goal( "airdrop_crate" ) || self botgetscriptgoaltype() == "tactical" || bots_util::bot_is_remote_or_linked() )
        {
            continue;
        }
        
        var_d3b759499078bdfd = [];
        
        foreach ( crate in all_crates )
        {
            if ( bot_crate_valid( crate ) )
            {
                var_d3b759499078bdfd[ var_d3b759499078bdfd.size ] = crate;
            }
        }
        
        var_d3b759499078bdfd = arrayremoveduplicates( var_d3b759499078bdfd );
        
        if ( var_d3b759499078bdfd.size == 0 )
        {
            continue;
        }
        
        var_d3b759499078bdfd = utility::get_array_of_closest( self.origin, var_d3b759499078bdfd );
        nearest_tacpoint_bot = self getnearesttacpoint();
        
        if ( !isdefined( nearest_tacpoint_bot ) )
        {
            continue;
        }
        
        ammolow = self [[ level.bot_funcs[ "crate_low_ammo_check" ] ]]();
        var_4fe21a47728f7e5e = ( ammolow || randomint( 100 ) < 50 ) && !emp_debuff::is_empd();
        crate_to_take = undefined;
        
        foreach ( crate in var_d3b759499078bdfd )
        {
            var_22994441b25ebdaa = 0;
            
            if ( crate.owner != self && !isdefined( crate.boxtype ) )
            {
                var_ea02e1806d2a8d35 = [];
                
                foreach ( player in level.players )
                {
                    if ( !isdefined( player.team ) )
                    {
                        continue;
                    }
                    
                    if ( !isai( player ) && level.teambased && player.team == self.team )
                    {
                        if ( distancesquared( player.origin, crate.origin ) < 490000 )
                        {
                            var_ea02e1806d2a8d35[ var_ea02e1806d2a8d35.size ] = player;
                        }
                    }
                }
                
                if ( var_ea02e1806d2a8d35.size > 0 )
                {
                    nearest_tacpoint_human = var_ea02e1806d2a8d35[ 0 ] getnearesttacpoint();
                    
                    if ( isdefined( nearest_tacpoint_human ) )
                    {
                        var_22994441b25ebdaa = 0;
                        
                        foreach ( tacpoint in crate.nearest_tacpoints )
                        {
                            var_22994441b25ebdaa = var_22994441b25ebdaa || tacpointsvisible( nearest_tacpoint_human, tacpoint );
                        }
                    }
                }
            }
            
            if ( !var_22994441b25ebdaa )
            {
                crate_is_claimed = isdefined( crate.var_f3af1ded1a89f317 ) && crate.var_f3af1ded1a89f317[ self.team ];
                var_860c440701874158 = 0;
                
                foreach ( tacpoint in crate.nearest_tacpoints )
                {
                    var_860c440701874158 = var_860c440701874158 || tacpointsvisible( nearest_tacpoint_bot, tacpoint );
                }
                
                if ( var_860c440701874158 || var_4fe21a47728f7e5e && !crate_is_claimed )
                {
                    crate_to_take = crate;
                    break;
                }
            }
        }
        
        if ( isdefined( crate_to_take ) )
        {
            if ( self [[ level.bot_funcs[ "crate_should_claim" ] ]]() )
            {
                if ( !isdefined( crate_to_take.boxtype ) )
                {
                    function_af2127e934127d9a( crate_to_take );
                }
            }
            
            extra_params = spawnstruct();
            extra_params.object = crate_to_take;
            extra_params.start_thread = &watch_bot_died_during_crate;
            extra_params.should_abort = &crate_picked_up;
            crate_dest = undefined;
            
            if ( isdefined( crate_to_take.boxtype ) )
            {
                if ( isdefined( crate_to_take.boxtouchonly ) && crate_to_take.boxtouchonly )
                {
                    extra_params.script_goal_radius = 16;
                    extra_params.action_thread = undefined;
                    crate_dest = crate_to_take.origin;
                }
                else
                {
                    extra_params.script_goal_radius = 50;
                    extra_params.action_thread = &use_box;
                    var_97bae113935cd79c = crate_get_bot_target_check_distance( crate_to_take, player_use_radius );
                    
                    if ( !isdefined( var_97bae113935cd79c ) )
                    {
                        continue;
                    }
                    
                    var_97bae113935cd79c -= crate_to_take.origin;
                    scale = length( var_97bae113935cd79c ) * randomfloat( 1 );
                    crate_dest = crate_to_take.origin + vectornormalize( var_97bae113935cd79c ) * scale + ( 0, 0, 12 );
                }
            }
            else
            {
                extra_params.action_thread = &use_crate;
                extra_params.end_thread = &stop_using_crate;
                crate_dest = crate_get_bot_target_check_distance( crate_to_take, player_use_radius );
                
                if ( !isdefined( crate_dest ) )
                {
                    continue;
                }
                
                extra_params.script_goal_radius = player_use_radius - distance( crate_to_take.origin, crate_dest + ( 0, 0, 40 ) );
                crate_dest += ( 0, 0, 24 );
            }
            
            if ( isdefined( extra_params.script_goal_radius ) )
            {
                assert( extra_params.script_goal_radius >= 0 );
            }
            
            crate_to_take notify( #"path_disconnect" );
            wait 0.05;
            
            if ( !isdefined( crate_to_take ) )
            {
                continue;
            }
            
            bots_tactical_goals::new_tactical_goal( "airdrop_crate", crate_dest, 30, extra_params );
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0x2185020f, Offset: 0x4fd0
// Size: 0xe, Type: bool
function bot_should_use_ballistic_vest_crate( crate )
{
    return true;
}

// Namespace bots
// Params 0
// Checksum 0xe07351d1, Offset: 0x4fe7
// Size: 0x4, Type: bool
function crate_should_claim()
{
    return true;
}

// Namespace bots
// Params 0
// Checksum 0xd3699669, Offset: 0x4ff4
// Size: 0x3, Type: bool
function crate_low_ammo_check()
{
    return false;
}

// Namespace bots
// Params 1
// Checksum 0xbc450b8, Offset: 0x5000
// Size: 0x3c, Type: bool
function bot_should_use_ammo_crate( crate )
{
    if ( getcompleteweaponname( self getcurrentweapon() ) == level.boxsettings[ crate.boxtype ].minigunweapon )
    {
        return false;
    }
    
    return true;
}

// Namespace bots
// Params 1
// Checksum 0x7ee59f5b, Offset: 0x5045
// Size: 0x22
function bot_pre_use_ammo_crate( crate )
{
    inventory_utility::_switchtoweapon( self.secondaryweapon );
    wait 1;
}

// Namespace bots
// Params 1
// Checksum 0xab1cff87, Offset: 0x506f
// Size: 0x25
function bot_post_use_ammo_crate( crate )
{
    inventory_utility::_switchtoweapon( nullweapon() );
    self.secondaryweapon = self getcurrentweapon();
}

// Namespace bots
// Params 1
// Checksum 0x73ed3482, Offset: 0x509c
// Size: 0x71, Type: bool
function bot_should_use_scavenger_bag( crate )
{
    if ( bots_util::bot_get_low_on_ammo( 0.66 ) )
    {
        nearest_tacpoint_bot = self getnearesttacpoint();
        
        if ( isdefined( crate.nearest_tacpoints[ 0 ] ) && isdefined( nearest_tacpoint_bot ) )
        {
            if ( tacpointsvisible( nearest_tacpoint_bot, crate.nearest_tacpoints[ 0 ], 1 ) )
            {
                if ( self function_6c6e0a8bb89a022e( crate.origin ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0xd6285b1d, Offset: 0x5116
// Size: 0x94, Type: bool
function bot_should_use_grenade_crate( crate )
{
    offhand_list = self getweaponslistoffhands();
    
    foreach ( weapon in offhand_list )
    {
        if ( self getweaponammostock( weapon ) == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0x86a09668, Offset: 0x51b3
// Size: 0xe, Type: bool
function bot_should_use_juicebox_crate( crate )
{
    return true;
}

// Namespace bots
// Params 0
// Checksum 0xb47029c3, Offset: 0x51ca
// Size: 0x8f
function crate_monitor_position()
{
    self notify( #"crate_monitor_position" );
    self endon( #"crate_monitor_position" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        lastpos = self.origin;
        wait 0.5;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !bots_util_mp::bot_vectors_are_equal( self.origin, lastpos ) )
        {
            self.on_navmesh = undefined;
            self.nearest_tacpoints = undefined;
            self.nearest_points = undefined;
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xb3f05110, Offset: 0x5261
// Size: 0x8
function crate_wait_use()
{
    wait 0.5;
}

// Namespace bots
// Params 1
// Checksum 0x9dcdb4b5, Offset: 0x5271
// Size: 0x20, Type: bool
function crate_picked_up( goal )
{
    if ( !isdefined( goal.object ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0x694356a5, Offset: 0x529a
// Size: 0x122
function use_crate( goal )
{
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    self [[ level.bot_funcs[ "crate_wait_use" ] ]]();
    
    if ( goal.object.owner == self )
    {
        time = level.crateownerusetime / 1000 + 0.5;
    }
    else
    {
        time = level.cratenonownerusetime / 1000 + 1;
    }
    
    self botpressbutton( "use", time );
    
    while ( time > 0 && isdefined( goal.object ) )
    {
        wait 0.05;
        time -= 0.05;
    }
    
    if ( time > 0 )
    {
        wait randomfloatrange( 0.05, 0.5 );
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0xe6f962f4, Offset: 0x53c4
// Size: 0x16c
function use_box( goal )
{
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    if ( isdefined( goal.object ) && isdefined( goal.object.boxtype ) )
    {
        boxtype = goal.object.boxtype;
        
        if ( isdefined( level.bot_pre_use_box_of_type[ boxtype ] ) )
        {
            self [[ level.bot_pre_use_box_of_type[ boxtype ] ]]( goal.object );
        }
        
        if ( isdefined( goal.object ) )
        {
            time = level.boxsettings[ goal.object.boxtype ].usetime / 1000 + 0.5;
            self botpressbutton( "use", time );
            wait time;
            
            if ( isdefined( level.bot_post_use_box_of_type[ boxtype ] ) )
            {
                self [[ level.bot_post_use_box_of_type[ boxtype ] ]]( goal.object );
            }
        }
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0xdb523238, Offset: 0x5538
// Size: 0x1e
function watch_bot_died_during_crate( goal )
{
    thread bot_watch_for_death( goal.object );
}

// Namespace bots
// Params 1
// Checksum 0x9273cda9, Offset: 0x555e
// Size: 0x46
function stop_using_crate( goal )
{
    if ( isdefined( goal.object ) )
    {
        goal.object.var_f3af1ded1a89f317[ self.team ] = undefined;
        self notify( #"hash_b99ce750982e0388" );
    }
}

// Namespace bots
// Params 1
// Checksum 0xe937ae35, Offset: 0x55ac
// Size: 0x81
function bot_watch_for_death( object )
{
    self endon( #"hash_b99ce750982e0388" );
    object endon( #"death_or_disconnect" );
    object endon( #"revived" );
    object endon( #"laststand_revived" );
    level endon( #"game_ended" );
    prev_team = self.team;
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( object ) )
    {
        object.var_f3af1ded1a89f317[ prev_team ] = undefined;
    }
}

// Namespace bots
// Params 0
// Checksum 0x5875940c, Offset: 0x5635
// Size: 0x162
function bot_think_crate_blocking_path()
{
    self notify( #"bot_think_crate_blocking_path" );
    self endon( #"bot_think_crate_blocking_path" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    radius = getdvarfloat( @"bg_player_useradius" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 3;
        
        if ( self usebuttonpressed() )
        {
            continue;
        }
        
        if ( utility::isusingremote() )
        {
            continue;
        }
        
        crates = level.carepackages;
        
        for ( i = 0; i < crates.size ; i++ )
        {
            crate = crates[ i ];
            
            if ( !isdefined( crate ) )
            {
                continue;
            }
            
            use_ent = self getplayeruseentity();
            
            if ( use_ent != crate )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, crate.origin ) < radius * radius )
            {
                if ( !bot_has_streak_in_crate( crate ) )
                {
                    if ( crate.owner == self )
                    {
                        self botpressbutton( "use", level.crateownerusetime / 1000 + 0.5 );
                        continue;
                    }
                    
                    self botpressbutton( "use", level.cratenonownerusetime / 1000 + 0.5 );
                }
            }
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0x3bf5b958, Offset: 0x579f
// Size: 0xaf
function bot_think_usable_objects()
{
    self notify( #"bot_think_usable_objects" );
    self endon( #"bot_think_usable_objects" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        wait 2;
        
        if ( self usebuttonpressed() )
        {
            continue;
        }
        
        if ( utility::isusingremote() )
        {
            continue;
        }
        
        use_ent = self getplayeruseentity();
        
        if ( isdefined( use_ent ) )
        {
            if ( use_ent.equipmentref == "equip_tac_insert" )
            {
                self botpressbutton( "use", 1 );
            }
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xe31c94ea, Offset: 0x5856
// Size: 0x11e
function bot_think_fieldupgrades()
{
    self notify( #"bot_think_fieldupgrades" );
    self endon( #"bot_think_fieldupgrades" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1;
        
        if ( isdefined( self.super.riotshielddata ) )
        {
            self botsetflag( "prefer_shield_out_all", 1 );
        }
        
        if ( self function_bece775663e54d92() )
        {
            continue;
        }
        
        if ( !level.allowsupers )
        {
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_690838cdefdef7ad", 0 ) == 1 )
            {
                continue;
            }
        #/
        
        if ( bots_util::bot_in_combat() )
        {
            continue;
        }
        
        superinfo = supers_mp::getcurrentsuper();
        
        if ( isdefined( superinfo ) )
        {
            if ( supers_mp::issuperready( superinfo ) )
            {
                self botpressbutton( "special" );
                
                if ( isdefined( superinfo.var_7ef7600ff6978d76 ) && superinfo.var_7ef7600ff6978d76.var_5e3a1c87edc1edd5 == #"riotshield" )
                {
                    self botsetflag( "prefer_shield_out_all", 1 );
                }
            }
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0x157228aa, Offset: 0x597c
// Size: 0x2d
function function_c1b2be64e31aa38b()
{
    revive_scriptables = level.laststandreviveents;
    revive_objects = revive_scriptables;
    
    if ( !isdefined( revive_objects ) )
    {
        revive_objects = [];
    }
    
    return revive_objects;
}

// Namespace bots
// Params 0
// Checksum 0x1ecc2da3, Offset: 0x59b2
// Size: 0x399
function bot_think_revive()
{
    self notify( #"bot_think_revive" );
    self endon( #"bot_think_revive" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        waittime = 2;
        
        if ( function_c1b2be64e31aa38b().size > 0 )
        {
            waittime = 0.05;
        }
        
        wait waittime;
        
        if ( !bot_can_revive() )
        {
            continue;
        }
        
        revive_objects = function_c1b2be64e31aa38b();
        
        if ( revive_objects.size == 0 )
        {
            continue;
        }
        
        if ( revive_objects.size > 1 )
        {
            revive_objects = sortbydistance( revive_objects, self.origin );
            
            if ( isdefined( self.owner ) )
            {
                for ( i = 0; i < revive_objects.size ; i++ )
                {
                    if ( revive_objects[ i ].owner != self.owner )
                    {
                        continue;
                    }
                    
                    if ( i == 0 )
                    {
                        break;
                    }
                    
                    var_cc1677d8768839af = revive_objects[ i ];
                    revive_objects[ i ] = revive_objects[ 0 ];
                    revive_objects[ 0 ] = var_cc1677d8768839af;
                    break;
                }
            }
        }
        
        foreach ( revive_object in revive_objects )
        {
            player = revive_object.owner;
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player == self )
            {
                continue;
            }
            
            if ( game_utility_mp::islaststandenabled() && ( !isalive( player ) || isdefined( player.fauxdead ) || player.delayedspawnedplayernotify ) )
            {
                continue;
            }
            
            if ( player.team != self.team )
            {
                continue;
            }
            
            if ( game_utility_mp::islaststandenabled() && !player.inlaststand && !game_utility_mp::isteamreviveenabled() )
            {
                continue;
            }
            
            if ( isdefined( player.var_f3af1ded1a89f317 ) && player.var_f3af1ded1a89f317[ self.team ] )
            {
                continue;
            }
            
            if ( game_utility_mp::islaststandenabled() )
            {
                reviveorigin = player.origin;
            }
            else
            {
                reviveorigin = revive_object.origin;
            }
            
            if ( distancesquared( self.origin, reviveorigin ) < 4194304 )
            {
                extra_params = spawnstruct();
                extra_params.object = player;
                extra_params.script_goal_radius = 64;
                
                if ( isdefined( self.last_revive_fail_time ) && gettime() - self.last_revive_fail_time < 1000 )
                {
                    extra_params.script_goal_radius = 32;
                }
                
                extra_params.start_thread = &watch_bot_died_during_revive;
                extra_params.end_thread = &stop_reviving;
                extra_params.should_abort = &function_887f1dcb03612b38;
                extra_params.action_thread = &revive_player;
                revivepriority = 60;
                
                if ( teams::getteamdata( self.team, "aliveCount" ) == 1 )
                {
                    revivepriority = 100;
                }
                
                bots_tactical_goals::new_tactical_goal( "revive", reviveorigin, revivepriority, extra_params );
                function_af2127e934127d9a( player );
                break;
            }
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0xf976b452, Offset: 0x5d53
// Size: 0x3f
function function_af2127e934127d9a( object )
{
    if ( !isdefined( object.var_f3af1ded1a89f317 ) )
    {
        object.var_f3af1ded1a89f317 = [];
    }
    
    object.var_f3af1ded1a89f317[ self.team ] = 1;
}

// Namespace bots
// Params 1
// Checksum 0x45c61cd1, Offset: 0x5d9a
// Size: 0x27
function watch_bot_died_during_revive( goal )
{
    if ( game_utility_mp::islaststandenabled() )
    {
        thread bot_watch_for_death( goal.object );
    }
}

// Namespace bots
// Params 1
// Checksum 0xf69deaa3, Offset: 0x5dc9
// Size: 0x46
function stop_reviving( goal )
{
    if ( isdefined( goal.object ) )
    {
        goal.object.var_f3af1ded1a89f317[ self.team ] = undefined;
        self notify( #"hash_b99ce750982e0388" );
    }
}

// Namespace bots
// Params 1
// Checksum 0x4fc0e89d, Offset: 0x5e17
// Size: 0xda, Type: bool
function function_887f1dcb03612b38( goal )
{
    if ( game_utility_mp::islaststandenabled() )
    {
        if ( !isdefined( goal.object ) || goal.object.health <= 0 )
        {
            return true;
        }
        
        if ( !goal.object.inlaststand )
        {
            return true;
        }
    }
    else if ( !isdefined( goal.object ) || player::isreallyalive( goal.object ) )
    {
        return true;
    }
    
    assert( isdefined( goal.object ) );
    var_41127ff833f7bf15 = 64;
    
    if ( distancesquared( goal.object.origin, goal.goal_position ) > var_41127ff833f7bf15 )
    {
        return true;
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0xcf8cb33e, Offset: 0x5efa
// Size: 0x1a2
function revive_player( goal )
{
    if ( isdefined( goal.object ) )
    {
        goal.object.var_f3af1ded1a89f317[ self.team ] = 1;
    }
    
    if ( distancesquared( self.origin, goal.goal_position ) > 4900 )
    {
        self.last_revive_fail_time = gettime();
        return;
    }
    
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    prev_team = self.team;
    
    if ( game_utility_mp::islaststandenabled() )
    {
        use_time = level.laststandrevivetimer;
    }
    else if ( isdefined( goal.object.usetime ) )
    {
        use_time = goal.object.usetime / 1000;
    }
    else
    {
        use_time = 3;
    }
    
    self botlookatpoint( goal.goal_position, use_time + 1, "script_forced" );
    wait 0.5;
    self botpressbutton( "use", use_time + 0.5 );
    wait use_time + 1.5;
    
    if ( isdefined( goal.object ) )
    {
        goal.object.var_f3af1ded1a89f317[ prev_team ] = undefined;
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
}

// Namespace bots
// Params 0
// Checksum 0xd642dbc5, Offset: 0x60a4
// Size: 0xdc, Type: bool
function bot_can_revive()
{
    if ( self.laststand == 1 )
    {
        return false;
    }
    
    if ( bots_tactical_goals::has_tactical_goal( "revive" ) )
    {
        return false;
    }
    
    if ( bots_util::bot_is_remote_or_linked() )
    {
        return false;
    }
    
    if ( bots_scripted_defense::function_737443eaedb33690() )
    {
        return true;
    }
    
    if ( isdefined( level.bot_funcs[ "tactical_revive_override" ] ) )
    {
        result = self [[ level.bot_funcs[ "tactical_revive_override" ] ]]();
        
        if ( result )
        {
            return true;
        }
    }
    
    goaltype = self botgetscriptgoaltype();
    
    if ( goaltype == "none" || goaltype == "hunt" || goaltype == "guard" )
    {
        return true;
    }
    
    if ( goaltype == "objective" )
    {
        goal = self botgetscriptgoal();
        
        if ( distance( self.origin, goal ) > 500 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots
// Params 1
// Checksum 0xdd7a476d, Offset: 0x6189
// Size: 0x4f
function revive_watch_for_finished( player )
{
    self endon( #"death_or_disconnect" );
    self endon( #"bad_path" );
    self endon( #"goal" );
    player utility::waittill_any( "death", "revived" );
    self notify( #"bad_path" );
}

// Namespace bots
// Params 0
// Checksum 0x45f7e7e3, Offset: 0x61e0
// Size: 0x146
function bot_know_enemies_on_start()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( gettime() > 15000 )
    {
        return;
    }
    
    while ( !game_utility_mp::gamehasstarted() || !flags::gameflag( "prematch_done" ) )
    {
        wait 0.05;
    }
    
    chosenenemy = undefined;
    var_6fc3a534207c4f59 = undefined;
    
    for ( enemyidx = 0; enemyidx < level.players.size ; enemyidx++ )
    {
        otherplayer = level.players[ enemyidx ];
        
        if ( isdefined( otherplayer ) && isdefined( self.team ) && isdefined( otherplayer.team ) && !isalliedsentient( self, otherplayer ) )
        {
            if ( !isdefined( otherplayer.bot_start_known_by_enemy ) )
            {
                chosenenemy = otherplayer;
            }
            
            if ( isai( otherplayer ) && !isdefined( otherplayer.bot_start_know_enemy ) )
            {
                var_6fc3a534207c4f59 = otherplayer;
            }
        }
    }
    
    if ( isdefined( chosenenemy ) )
    {
        self.bot_start_know_enemy = 1;
        chosenenemy.bot_start_known_by_enemy = 1;
        self getenemyinfo( chosenenemy );
    }
    
    if ( isdefined( var_6fc3a534207c4f59 ) )
    {
        var_6fc3a534207c4f59.bot_start_know_enemy = 1;
        self.bot_start_known_by_enemy = 1;
        var_6fc3a534207c4f59 getenemyinfo( self );
    }
}

// Namespace bots
// Params 0
// Checksum 0x9b9aa6f5, Offset: 0x632e
// Size: 0x8f
function bot_think_gametype()
{
    self notify( #"hash_4d3a3a1f216255f2" );
    self endon( #"hash_4d3a3a1f216255f2" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_7ef09a825ac4c8ad = 0;
    
    if ( isbrgamemode() )
    {
        var_7ef09a825ac4c8ad = 1;
    }
    
    if ( !var_7ef09a825ac4c8ad )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    waitframe();
    
    if ( isdefined( level.bot_funcs[ "gametype_think" ] ) )
    {
        self childthread [[ level.bot_funcs[ "gametype_think" ] ]]();
    }
}

// Namespace bots
// Params 1
// Checksum 0x85e7cd52, Offset: 0x63c5
// Size: 0x18f
function bot_add_scavenger_bag( dropbag )
{
    added = 0;
    dropbag.boxtype = "scavenger_bag";
    dropbag.boxtouchonly = 1;
    
    if ( !isdefined( level.bot_scavenger_bags ) )
    {
        level.bot_scavenger_bags = [];
    }
    
    foreach ( index, existingbag in level.bot_scavenger_bags )
    {
        if ( !isdefined( existingbag ) )
        {
            added = 1;
            level.bot_scavenger_bags[ index ] = dropbag;
            break;
        }
    }
    
    if ( !added )
    {
        level.bot_scavenger_bags[ level.bot_scavenger_bags.size ] = dropbag;
    }
    
    foreach ( participant in level.participants )
    {
        if ( isai( participant ) && isdefined( participant.perks[ "specialty_scavenger" ] ) )
        {
            participant notify( #"new_crate_to_take" );
        }
    }
}

// Namespace bots
// Params 1
// Checksum 0x19e6ce82, Offset: 0x655c
// Size: 0x46, Type: bool
function function_e8c1a1cd1aaa5f82( entity )
{
    assert( isdefined( entity ) );
    
    if ( !isagent( entity ) )
    {
        return false;
    }
    
    if ( !isdefined( entity.subclass ) )
    {
        return false;
    }
    
    return entity.subclass == "capture_bot";
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0xcbb9f5ac, Offset: 0x65ab
// Size: 0x24
function private on_player_disconnect( params )
{
    if ( isai( self ) || isautopilot( self ) )
    {
        function_2bc9768ae531395e();
    }
}

// Namespace bots
// Params 0
// Checksum 0x26bea874, Offset: 0x65d7
// Size: 0x2c
function function_abd267784d89d474()
{
    behaviortreeasset = bots_util::function_37a3a6193a454294();
    
    if ( isdefined( behaviortreeasset ) )
    {
        self.behaviortreeasset = behaviortreeasset;
        bt_util::bt_init();
    }
}

// Namespace bots
// Params 0
// Checksum 0xac9307ac, Offset: 0x660b
// Size: 0x2d
function function_2bc9768ae531395e()
{
    var_23621b57ead5e58f = isdefined( self.bt );
    
    if ( var_23621b57ead5e58f )
    {
        self btterminatetreeinstance();
        self.bt = undefined;
    }
}

// Namespace bots
// Params 0, eflags: 0x4
// Checksum 0x9d47989f, Offset: 0x6640
// Size: 0x6a
function private function_16ee54a35257162d()
{
    if ( getdvarint( @"hash_cc119b5cd59fa611", 1 ) == 0 )
    {
        return;
    }
    
    level callback::add( #"player_item_pickup", &on_player_item_pickup );
    level callback::add( #"killstreak_activated", &function_e1bf128c2a2289ef );
    level callback::add( #"on_used_super", &function_a42f65575fa6e87c );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_end", &function_c026a2ace0336630 );
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x65c684d8, Offset: 0x66b2
// Size: 0x13
function private function_c026a2ace0336630( data )
{
    function_f640a4078bc4a1e2();
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x8de2ccd6, Offset: 0x66cd
// Size: 0x5f
function private function_736320900a3806d4( botxuid )
{
    if ( !isdefined( level.var_51157fca226e9990 ) )
    {
        level.var_51157fca226e9990 = [];
    }
    
    if ( !isdefined( level.var_51157fca226e9990[ botxuid ] ) )
    {
        level.var_51157fca226e9990[ botxuid ] = { #fieldUpgrades:[], #killstreaks:[] };
    }
    
    return level.var_51157fca226e9990[ botxuid ];
}

// Namespace bots
// Params 2, eflags: 0x4
// Checksum 0x93c15625, Offset: 0x6735
// Size: 0x6c
function private function_8bf57ac40783d82c( botxuid, kferef )
{
    kfeinfo = function_736320900a3806d4( botxuid );
    
    if ( !isdefined( kfeinfo.killstreaks[ kferef ] ) )
    {
        kfeinfo.killstreaks[ kferef ] = { #usecount:0, #pickupcount:0 };
    }
    
    return kfeinfo.killstreaks[ kferef ];
}

// Namespace bots
// Params 2, eflags: 0x4
// Checksum 0xfa20c895, Offset: 0x67aa
// Size: 0x6c
function private function_734e4103815ea321( botxuid, kferef )
{
    kfeinfo = function_736320900a3806d4( botxuid );
    
    if ( !isdefined( kfeinfo.fieldUpgrades[ kferef ] ) )
    {
        kfeinfo.fieldUpgrades[ kferef ] = { #usecount:0, #pickupcount:0 };
    }
    
    return kfeinfo.fieldUpgrades[ kferef ];
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0xde78d027, Offset: 0x681f
// Size: 0x47
function private function_bcc5c610355e250d( kferef )
{
    botxuid = self.xuid;
    
    if ( !botxuid )
    {
        return;
    }
    
    killstreakinfo = function_8bf57ac40783d82c( botxuid, kferef );
    killstreakinfo.pickupcount++;
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x21987397, Offset: 0x686e
// Size: 0x47
function private function_146ef055d396900c( kferef )
{
    botxuid = self.xuid;
    
    if ( !botxuid )
    {
        return;
    }
    
    killstreakinfo = function_8bf57ac40783d82c( botxuid, kferef );
    killstreakinfo.usecount++;
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x5d28daab, Offset: 0x68bd
// Size: 0x47
function private function_5bfcacfa3a30b67a( kferef )
{
    botxuid = self.xuid;
    
    if ( !botxuid )
    {
        return;
    }
    
    fieldupgradeinfo = function_734e4103815ea321( botxuid, kferef );
    fieldupgradeinfo.pickupcount++;
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x5898fb10, Offset: 0x690c
// Size: 0x47
function private function_595eee5739af6a89( kferef )
{
    botxuid = self.xuid;
    
    if ( !botxuid )
    {
        return;
    }
    
    fieldupgradeinfo = function_734e4103815ea321( botxuid, kferef );
    fieldupgradeinfo.usecount++;
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x5fe52088, Offset: 0x695b
// Size: 0x82
function private on_player_item_pickup( param )
{
    if ( isbot( self ) )
    {
        itemtype = common_item::function_16e8c106491eeaca( param.itembundle );
        
        if ( itemtype == "killstreak" )
        {
            function_bcc5c610355e250d( param.itembundle.ref );
            return;
        }
        
        if ( itemtype == "super" )
        {
            function_5bfcacfa3a30b67a( param.itembundle.ref );
        }
    }
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x466fb0af, Offset: 0x69e5
// Size: 0x3e
function private function_e1bf128c2a2289ef( param )
{
    if ( isbot( self ) )
    {
        ref = param.streakitem.streakname;
        function_146ef055d396900c( ref );
    }
}

// Namespace bots
// Params 1, eflags: 0x4
// Checksum 0x55585bb9, Offset: 0x6a2b
// Size: 0x48
function private function_a42f65575fa6e87c( param )
{
    if ( isbot( self ) )
    {
        ref = param.superinfo.staticdata.ref;
        function_595eee5739af6a89( ref );
    }
}

// Namespace bots
// Params 3, eflags: 0x4
// Checksum 0xef0c6ad1, Offset: 0x6a7b
// Size: 0x11a
function private function_42ed897127b75258( var_5957bfeffd4b833c, killstreak, fieldupgrade )
{
    if ( var_5957bfeffd4b833c.size > 0 )
    {
        dlogok = dlog_recordevent( "dlog_event_bot_kfe_use_telemetry", [ "killstreak_counts", killstreak.countarr, "killstreak_names", killstreak.namearr, "killstreak_pickup_counts", killstreak.var_141d7c25643e4f3c, "killstreak_use_counts", killstreak.var_d51a35dc6aefbe8f, "field_upgrade_counts", fieldupgrade.countarr, "field_upgrade_names", fieldupgrade.namearr, "field_upgrade_pickup_counts", fieldupgrade.var_141d7c25643e4f3c, "field_upgrade_use_counts", fieldupgrade.var_d51a35dc6aefbe8f, "bot_unoids", var_5957bfeffd4b833c ] );
        assert( dlogok, "<dev string:x294>" );
    }
}

// Namespace bots
// Params 0, eflags: 0x4
// Checksum 0xed8d4398, Offset: 0x6b9d
// Size: 0x38c
function private function_f640a4078bc4a1e2()
{
    var_5957bfeffd4b833c = [];
    killstreak = {};
    fieldupgrade = {};
    
    foreach ( botxuid, kfeinfo in level.var_51157fca226e9990 )
    {
        var_5957bfeffd4b833c[ var_5957bfeffd4b833c.size ] = botxuid;
        
        if ( !isdefined( killstreak.countarr ) )
        {
            killstreak.countarr = [];
        }
        
        if ( !isdefined( fieldupgrade.countarr ) )
        {
            fieldupgrade.countarr = [];
        }
        
        killstreak.countarr[ killstreak.countarr.size ] = kfeinfo.killstreaks.size;
        fieldupgrade.countarr[ fieldupgrade.countarr.size ] = kfeinfo.fieldUpgrades.size;
        
        if ( !isdefined( killstreak.namearr ) )
        {
            killstreak.namearr = [];
        }
        
        if ( !isdefined( killstreak.var_141d7c25643e4f3c ) )
        {
            killstreak.var_141d7c25643e4f3c = [];
        }
        
        if ( !isdefined( killstreak.var_d51a35dc6aefbe8f ) )
        {
            killstreak.var_d51a35dc6aefbe8f = [];
        }
        
        foreach ( kferef, killstreakinfo in kfeinfo.killstreaks )
        {
            killstreak.namearr[ killstreak.namearr.size ] = kferef;
            killstreak.var_141d7c25643e4f3c[ killstreak.var_141d7c25643e4f3c.size ] = killstreakinfo.pickupcount;
            killstreak.var_d51a35dc6aefbe8f[ killstreak.var_d51a35dc6aefbe8f.size ] = killstreakinfo.usecount;
        }
        
        if ( !isdefined( fieldupgrade.namearr ) )
        {
            fieldupgrade.namearr = [];
        }
        
        if ( !isdefined( fieldupgrade.var_141d7c25643e4f3c ) )
        {
            fieldupgrade.var_141d7c25643e4f3c = [];
        }
        
        if ( !isdefined( fieldupgrade.var_d51a35dc6aefbe8f ) )
        {
            fieldupgrade.var_d51a35dc6aefbe8f = [];
        }
        
        foreach ( kferef, fieldupgradeinfo in kfeinfo.fieldUpgrades )
        {
            fieldupgrade.namearr[ fieldupgrade.namearr.size ] = kferef;
            fieldupgrade.var_141d7c25643e4f3c[ fieldupgrade.var_141d7c25643e4f3c.size ] = fieldupgradeinfo.pickupcount;
            fieldupgrade.var_d51a35dc6aefbe8f[ fieldupgrade.var_d51a35dc6aefbe8f.size ] = fieldupgradeinfo.usecount;
        }
        
        if ( var_5957bfeffd4b833c.size >= 100 )
        {
            function_42ed897127b75258( var_5957bfeffd4b833c, killstreak, fieldupgrade );
            var_5957bfeffd4b833c = [];
            killstreak = {};
            fieldupgrade = {};
        }
    }
    
    function_42ed897127b75258( var_5957bfeffd4b833c, killstreak, fieldupgrade );
    level.var_51157fca226e9990 = undefined;
}

