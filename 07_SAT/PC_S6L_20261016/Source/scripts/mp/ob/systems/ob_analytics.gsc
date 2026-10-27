// scripts\mp\ob\systems\ob_analytics.gsc  (hash_496d48fd4f2cd3db.gscc) (size: 23074 Bytes / 0x5a22 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bca8a9 (163358889)
// size ...... 23074 (0x5a22)
// includes .. 23  (offset: 0x4f86)
// strings ... 121 (offset: 0x503e)
// dev strs .. 0   (offset: 0x5a22)
// exports ... 36  (offset: 0x3f5e)
// cseg ...... 0xa7e + 0x34e0 (0x3f5e)
// imports ... 83  (offset: 0x44fe)
// animtree1 . 0   (offset: 0x5a22)
// animtree2 . 0   (offset: 0x5a22)
#using script_16ea1b94f0f381b3;
#using script_3edd59d0d3fc3262;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\callbacks;
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\ob_analytics_activity;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\pack_a_punch;
#using scripts\mp\rank;
#using scripts\mp\telemetry_coop;
#using scripts\mp\vehicles\damage;

#namespace ob_analytics;

// Namespace ob_analytics
// Params 0
// Checksum 0x4d521c91, Offset: 0xa9c
// Size: 0x15a
function init_ob_analytics()
{
    level callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_pmc_mission_completed", &on_mission_complete );
    callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::add( "lootcache_looted", &on_player_loot_cache );
    callback::add( "encampment_key_looted", &function_2bec3d1d08d4abee );
    callback::add( "stronghold_key_looted", &function_1157c3fa05ff30de );
    callback::add( "warlord_damaged", &on_player_damaged_warlord );
    callback::add( "warlord_killed", &on_player_killed_warlord );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_disconnect", &on_player_disconnect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_server_exit_level", &function_f8ac77476d140859 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_ob_on_exfil", &function_6b978478e66b1b5a );
    callback::add( "register_activities", &function_74957fa2c36123b6 );
    callback::add( #"player_vehicle_enter", &on_player_vehicle_enter );
    callback::add( #"player_vehicle_exit", &on_player_vehicle_exit );
    callback::add( "on_vehicle_tire_repaired", &function_685618ab640d1e37 );
    callback::add( "on_vehicle_refueled", &on_vehicle_refueled );
    callback::add( "on_vehicle_spawned", &on_vehicle_spawned );
    callback::add( "on_ob_infil_complete", &on_ob_infil_complete );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xef93750d, Offset: 0xbfe
// Size: 0x46
function on_vehicle_spawned( sparams )
{
    waitframe();
    vehicle = sparams.vehicle;
    
    if ( !isdefined( vehicle vehicle::get_ref() ) )
    {
        return;
    }
    
    damage::register_additional_death_callback( vehicle vehicle::get_ref(), &vehicle_death_damage );
}

// Namespace ob_analytics
// Params 1
// Checksum 0x8957d3d3, Offset: 0xc4c
// Size: 0x129
function vehicle_death_damage( data )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    regiondifficulty = "difficulty_easy";
    
    if ( isfunction( level.var_bb131187d6741752 ) )
    {
        regiondifficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
    }
    
    if ( isplayer( data.attacker ) )
    {
        data.attacker dlog_recordplayerevent( "dlog_event_ob_player_vehicle_interact", [ "enter", 0, "exit", 0, "refuel", 0, "repair_tire", 0, "destroyed", 1, "name", self.vehiclename, "threat_level", regiondifficulty, "vehicle_x", self.origin[ 0 ], "vehicle_y", self.origin[ 1 ], "vehicle_z", self.origin[ 2 ] ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xf769c1fb, Offset: 0xd7d
// Size: 0x15c
function on_player_vehicle_enter( params )
{
    if ( isent( params.vehicle ) && isplayer( self ) )
    {
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( params.vehicle.origin );
        }
        
        self dlog_recordplayerevent( "dlog_event_ob_player_vehicle_interact", [ "enter", 1, "exit", 0, "refuel", 0, "repair_tire", 0, "destroyed", 0, "name", params.vehicle.vehiclename, "threat_level", regiondifficulty, "vehicle_x", params.vehicle.origin[ 0 ], "vehicle_y", params.vehicle.origin[ 1 ], "vehicle_z", params.vehicle.origin[ 2 ] ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x2c4a7052, Offset: 0xee1
// Size: 0x16e
function on_player_vehicle_exit( params )
{
    if ( isent( params.vehicle ) && isplayer( self ) )
    {
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( params.vehicle.origin );
        }
        
        if ( isent( params.vehicle ) )
        {
            self dlog_recordplayerevent( "dlog_event_ob_player_vehicle_interact", [ "enter", 0, "exit", 1, "refuel", 0, "repair_tire", 0, "destroyed", 0, "name", params.vehicle.vehiclename, "threat_level", regiondifficulty, "vehicle_x", params.vehicle.origin[ 0 ], "vehicle_y", params.vehicle.origin[ 1 ], "vehicle_z", params.vehicle.origin[ 2 ] ] );
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x97b54212, Offset: 0x1057
// Size: 0x15c
function function_685618ab640d1e37( params )
{
    if ( isent( params.vehicle ) && isplayer( self ) )
    {
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( params.vehicle.origin );
        }
        
        self dlog_recordplayerevent( "dlog_event_ob_player_vehicle_interact", [ "enter", 0, "exit", 0, "refuel", 0, "repair_tire", 1, "destroyed", 0, "name", params.vehicle.vehiclename, "threat_level", regiondifficulty, "vehicle_x", params.vehicle.origin[ 0 ], "vehicle_y", params.vehicle.origin[ 1 ], "vehicle_z", params.vehicle.origin[ 2 ] ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x9c98a3a2, Offset: 0x11bb
// Size: 0x170
function on_vehicle_refueled( params )
{
    if ( isent( params.vehicle ) && isplayer( params.player ) )
    {
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( params.vehicle.origin );
        }
        
        params.player dlog_recordplayerevent( "dlog_event_ob_player_vehicle_interact", [ "enter", 0, "exit", 0, "refuel", 1, "repair_tire", 0, "destroyed", 0, "name", params.vehicle.vehiclename, "threat_level", regiondifficulty, "vehicle_x", params.vehicle.origin[ 0 ], "vehicle_y", params.vehicle.origin[ 1 ], "vehicle_z", params.vehicle.origin[ 2 ] ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x91df2bd2, Offset: 0x1333
// Size: 0x6e
function function_74957fa2c36123b6( params )
{
    if ( isdefined( level.activities ) )
    {
        activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &ob_analytics_activity::function_48061001a97cc2f8 );
        activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &ob_analytics_activity::on_activity_complete );
        activity_common::function_2dd4f07fa5c3e911( "ActivityFailure", &ob_analytics_activity::on_activity_failed );
        activity_common::function_2dd4f07fa5c3e911( "ActivityBegin", &ob_analytics_activity::on_activity_begin );
        activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &ob_analytics_activity::function_4b55ce0113456ec6 );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x60e53fd2, Offset: 0x13a9
// Size: 0xf48
function on_player_spawned( params )
{
    self endon( #"disconnect" );
    
    while ( !isdefined( self.pers[ "telemetry" ] ) )
    {
        waitframe();
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_f36fb1bbac403cae ) )
    {
        self.pers[ "telemetry" ].var_f36fb1bbac403cae = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].soldier_kills ) )
    {
        self.pers[ "telemetry" ].soldier_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].boss_kills ) )
    {
        self.pers[ "telemetry" ].boss_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].elite_kills ) )
    {
        self.pers[ "telemetry" ].elite_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].special_kills ) )
    {
        self.pers[ "telemetry" ].special_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].normal_kills ) )
    {
        self.pers[ "telemetry" ].normal_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].critical_kills ) )
    {
        self.pers[ "telemetry" ].critical_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].pack_a_punch_kills ) )
    {
        self.pers[ "telemetry" ].pack_a_punch_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].looted_containers ) )
    {
        self.pers[ "telemetry" ].looted_containers = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].teammates_revived ) )
    {
        self.pers[ "telemetry" ].teammates_revived = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].one_shot_kills ) )
    {
        self.pers[ "telemetry" ].one_shot_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_earned ) )
    {
        self.pers[ "telemetry" ].essence_earned = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent ) )
    {
        self.pers[ "telemetry" ].essence_spent = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_from_cache ) )
    {
        self.pers[ "telemetry" ].essence_from_cache = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_b08a6e002fd52352 ) )
    {
        self.pers[ "telemetry" ].var_b08a6e002fd52352 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_274edd52ab89463b ) )
    {
        self.pers[ "telemetry" ].var_274edd52ab89463b = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_eaa2879e4e84605b ) )
    {
        self.pers[ "telemetry" ].var_eaa2879e4e84605b = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].match_time_elapsed ) )
    {
        self.pers[ "telemetry" ].match_time_elapsed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_bae626e3a314740 ) )
    {
        self.pers[ "telemetry" ].var_bae626e3a314740 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_1fe781c3a9eed293 ) )
    {
        self.pers[ "telemetry" ].var_1fe781c3a9eed293 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_4cffa3d84550a529 ) )
    {
        self.pers[ "telemetry" ].var_4cffa3d84550a529 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_2335a21e69863d59 ) )
    {
        self.pers[ "telemetry" ].var_2335a21e69863d59 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent_wallbuy ) )
    {
        self.pers[ "telemetry" ].essence_spent_wallbuy = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent_pack ) )
    {
        self.pers[ "telemetry" ].essence_spent_pack = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent_magicbox ) )
    {
        self.pers[ "telemetry" ].essence_spent_magicbox = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent_perk ) )
    {
        self.pers[ "telemetry" ].essence_spent_perk = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].perks_obtained ) )
    {
        self.pers[ "telemetry" ].perks_obtained = [];
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_1cca4ac764de07aa ) )
    {
        self.pers[ "telemetry" ].var_1cca4ac764de07aa = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].essence_spent_buystation ) )
    {
        self.pers[ "telemetry" ].essence_spent_buystation = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].mangler_kills ) )
    {
        self.pers[ "telemetry" ].mangler_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].mimic_kills ) )
    {
        self.pers[ "telemetry" ].mimic_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].disciple_kills ) )
    {
        self.pers[ "telemetry" ].disciple_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].hellhound_kills ) )
    {
        self.pers[ "telemetry" ].hellhound_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].base_zombie_kills ) )
    {
        self.pers[ "telemetry" ].base_zombie_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].light_armor_zombie_kills ) )
    {
        self.pers[ "telemetry" ].light_armor_zombie_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].heavy_armor_zombie_kills ) )
    {
        self.pers[ "telemetry" ].heavy_armor_zombie_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].abomination_kills ) )
    {
        self.pers[ "telemetry" ].abomination_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].deathworm_kills ) )
    {
        self.pers[ "telemetry" ].deathworm_kills = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_6f280cf9443b73ce ) )
    {
        self.pers[ "telemetry" ].var_6f280cf9443b73ce = [];
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].ai_attackers_on_laststand ) )
    {
        self.pers[ "telemetry" ].ai_attackers_on_laststand = [];
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].contracts_completed ) )
    {
        self.pers[ "telemetry" ].contracts_completed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].contracts_completed_xp ) )
    {
        self.pers[ "telemetry" ].contracts_completed_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].activities_completed ) )
    {
        self.pers[ "telemetry" ].activities_completed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].activities_completed_xp ) )
    {
        self.pers[ "telemetry" ].activities_completed_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_a3ef261d278ed203 ) )
    {
        self.pers[ "telemetry" ].var_a3ef261d278ed203 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].soldier_kills_xp ) )
    {
        self.pers[ "telemetry" ].soldier_kills_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].boss_kills_xp ) )
    {
        self.pers[ "telemetry" ].boss_kills_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_ac40685bec6e96d7 ) )
    {
        self.pers[ "telemetry" ].var_ac40685bec6e96d7 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].misc_combat_xp ) )
    {
        self.pers[ "telemetry" ].misc_combat_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_97df315dd9fee0e9 ) )
    {
        self.pers[ "telemetry" ].var_97df315dd9fee0e9 = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_fdf5e1f9296bdf6d ) )
    {
        self.pers[ "telemetry" ].var_fdf5e1f9296bdf6d = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].damaged_warlords ) )
    {
        self.pers[ "telemetry" ].damaged_warlords = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].killed_warlords ) )
    {
        self.pers[ "telemetry" ].killed_warlords = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].infil_essence ) )
    {
        self.pers[ "telemetry" ].infil_essence = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].eliminations ) )
    {
        self.pers[ "telemetry" ].eliminations = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].eliminations_xp ) )
    {
        self.pers[ "telemetry" ].eliminations_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].elite_eliminations ) )
    {
        self.pers[ "telemetry" ].elite_eliminations = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].elite_eliminations_xp ) )
    {
        self.pers[ "telemetry" ].elite_eliminations_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].contracts_completed ) )
    {
        self.pers[ "telemetry" ].contracts_completed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].contracts_completed_xp ) )
    {
        self.pers[ "telemetry" ].contracts_completed_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].activities_completed ) )
    {
        self.pers[ "telemetry" ].activities_completed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].activities_completed_xp ) )
    {
        self.pers[ "telemetry" ].activities_completed_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].world_events_completed ) )
    {
        self.pers[ "telemetry" ].world_events_completed = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].var_71230fde1cb2cadd ) )
    {
        self.pers[ "telemetry" ].var_71230fde1cb2cadd = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].special_eliminations ) )
    {
        self.pers[ "telemetry" ].special_eliminations = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].special_eliminations_xp ) )
    {
        self.pers[ "telemetry" ].special_eliminations_xp = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].gained_power ) )
    {
        self.pers[ "telemetry" ].gained_power = 0;
    }
    
    if ( utility::ent_flag( "ob_analytics_player_callbacks" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "ob_analytics_player_callbacks" );
    callback::add( "currency_add", &on_currency_add );
    callback::add( "currency_sub", &on_currency_sub );
    callback::add( "currency_set", &on_currency_set );
    callback::add( #"player_item_pickup", &on_item_pickup );
    callback::add( #"player_laststand_bleedout", &function_5f7514b664ba0082 );
    callback::add( #"player_laststand", &on_player_laststand );
    callback::add( #"player_death", &on_player_death );
    callback::add( "zm_perk_purchased", &on_perk_purchased );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xe8e5ac6, Offset: 0x22f9
// Size: 0x91
function on_player_laststand( params )
{
    if ( isplayer( self ) )
    {
        if ( isdefined( self.attacker.subclass ) )
        {
            self.pers[ "telemetry" ].ai_attackers_on_laststand[ self.pers[ "telemetry" ].ai_attackers_on_laststand.size ] = self.attacker.subclass;
        }
        
        self.lastattacker = self.attacker;
        telemetry_coop::player_death_event( "was_knocked" );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x7df7f4a, Offset: 0x2392
// Size: 0x81
function function_5f7514b664ba0082( params )
{
    if ( isplayer( self ) && isdefined( self.attacker ) )
    {
        if ( isdefined( self.attacker.subclass ) )
        {
            self.pers[ "telemetry" ].var_6f280cf9443b73ce[ self.pers[ "telemetry" ].var_6f280cf9443b73ce.size ] = self.attacker.subclass;
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xa2f08a35, Offset: 0x241b
// Size: 0x15
function on_player_disconnect( data )
{
    function_d8c6545e9f54b587( data );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xe048ff94, Offset: 0x2438
// Size: 0x99
function function_f8ac77476d140859( data )
{
    foreach ( player in level.players )
    {
        data = spawnstruct();
        data.player = player;
        function_d8c6545e9f54b587( data );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xabeb9c05, Offset: 0x24d9
// Size: 0x16d
function function_a56f8c4a7b8a2259( amount )
{
    regiondifficulty = "difficulty_easy";
    
    if ( isfunction( level.var_bb131187d6741752 ) )
    {
        regiondifficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
    }
    
    switch ( regiondifficulty )
    {
        case #"hash_7bb2cd766703d463":
        case #"hash_a1e09f51896088fb":
            self.pers[ "telemetry" ].var_bae626e3a314740 = self.pers[ "telemetry" ].var_bae626e3a314740 + amount;
            break;
        case #"hash_af83e47edfa8900a":
            self.pers[ "telemetry" ].var_1fe781c3a9eed293 = self.pers[ "telemetry" ].var_1fe781c3a9eed293 + amount;
            break;
        case #"hash_5343b465e56ec9a4":
            self.pers[ "telemetry" ].var_4cffa3d84550a529 = self.pers[ "telemetry" ].var_4cffa3d84550a529 + amount;
            break;
        case #"hash_651f76c0ad6741ec":
            self.pers[ "telemetry" ].var_2335a21e69863d59 = self.pers[ "telemetry" ].var_2335a21e69863d59 + amount;
            break;
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x54601b6a, Offset: 0x264e
// Size: 0x15d
function on_currency_add( sparams )
{
    self.pers[ "telemetry" ].essence_earned = self.pers[ "telemetry" ].essence_earned + sparams.amount;
    function_a56f8c4a7b8a2259( sparams.amount );
    
    if ( isdefined( sparams.reason ) )
    {
        if ( sparams.reason == #"cache" )
        {
            self.pers[ "telemetry" ].essence_from_cache = self.pers[ "telemetry" ].essence_from_cache + sparams.amount;
            return;
        }
        
        if ( sparams.reason == #"sold" )
        {
            self.pers[ "telemetry" ].var_1cca4ac764de07aa = self.pers[ "telemetry" ].var_1cca4ac764de07aa + sparams.amount;
            return;
        }
        
        if ( sparams.reason == #"infil_essence" )
        {
            self.pers[ "telemetry" ].infil_essence = sparams.amount;
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x623fd6bf, Offset: 0x27b3
// Size: 0x38d
function on_currency_sub( sparams )
{
    self.pers[ "telemetry" ].essence_spent = self.pers[ "telemetry" ].essence_spent + sparams.amount;
    str_type = "unknown";
    var_5436f678895d81b2 = "unknown";
    
    if ( isdefined( sparams.reason ) )
    {
        if ( sparams.reason == #"magicbox" )
        {
            self.pers[ "telemetry" ].essence_spent_magicbox = self.pers[ "telemetry" ].essence_spent_magicbox + sparams.amount;
            str_type = "magicbox";
        }
        else if ( sparams.reason == #"packapunch" )
        {
            self.pers[ "telemetry" ].essence_spent_pack = self.pers[ "telemetry" ].essence_spent_pack + sparams.amount;
            str_type = "packapunch";
        }
        else if ( sparams.reason == #"perk" )
        {
            self.pers[ "telemetry" ].essence_spent_perk = self.pers[ "telemetry" ].essence_spent_perk + sparams.amount;
            str_type = "perk";
            var_5436f678895d81b2 = sparams.info ?? "unknown";
        }
        else if ( sparams.reason == #"wallbuy" )
        {
            self.pers[ "telemetry" ].essence_spent_wallbuy = self.pers[ "telemetry" ].essence_spent_wallbuy + sparams.amount;
            str_type = "wallbuy";
            var_5436f678895d81b2 = sparams.info ?? "unknown";
        }
        else if ( sparams.reason == #"buystation" )
        {
            self.pers[ "telemetry" ].essence_spent_buystation = self.pers[ "telemetry" ].essence_spent_buystation + sparams.amount;
            str_type = "buystation";
            var_5436f678895d81b2 = sparams.info ?? "unknown";
        }
        else if ( sparams.reason == #"zip_door" )
        {
            str_type = "zip_door";
        }
    }
    
    regiondifficulty = "difficulty_easy";
    
    if ( isfunction( level.var_bb131187d6741752 ) )
    {
        regiondifficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
    }
    
    self dlog_recordplayerevent( "dlog_event_ob_player_purchase", [ "pos_x", self.origin[ 0 ], "pos_y", self.origin[ 1 ], "pos_z", self.origin[ 2 ], "difficulty", regiondifficulty, "essence_spent", sparams.amount, "type_purchased", str_type, "info_purchased", var_5436f678895d81b2 ] );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xc5ae92a9, Offset: 0x2b48
// Size: 0x124
function on_currency_set( sparams )
{
    if ( sparams.originalamount < sparams.amount )
    {
        increasedamount = sparams.amount - sparams.originalamount;
        self.pers[ "telemetry" ].essence_earned = self.pers[ "telemetry" ].essence_earned + increasedamount;
        
        if ( sparams.reason == #"kill" )
        {
            self.pers[ "telemetry" ].var_274edd52ab89463b = self.pers[ "telemetry" ].var_274edd52ab89463b + increasedamount;
        }
        
        if ( sparams.reason == #"activity_reward" )
        {
            self.pers[ "telemetry" ].var_eaa2879e4e84605b = self.pers[ "telemetry" ].var_eaa2879e4e84605b + increasedamount;
        }
        
        function_a56f8c4a7b8a2259( increasedamount );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xbe5407b0, Offset: 0x2c74
// Size: 0x8d
function on_item_pickup( sparams )
{
    if ( isdefined( sparams.item ) && isdefined( sparams.itembundle ) )
    {
        if ( common_item::function_16e8c106491eeaca( sparams.itembundle ) == "currency" )
        {
            self.pers[ "telemetry" ].var_b08a6e002fd52352 = self.pers[ "telemetry" ].var_b08a6e002fd52352 + sparams.item.count;
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x7b945341, Offset: 0x2d09
// Size: 0xcc
function function_d8c6545e9f54b587( data )
{
    player = data.player;
    
    if ( !isdefined( player.pers[ "telemetry" ].var_38e5ef1f0057f455 ) )
    {
        if ( !telemetry_utils::is_valid_client( player ) )
        {
            return;
        }
        
        if ( player.var_5a792f9fdacf9283 && !level.gameended )
        {
            return;
        }
        
        player.pers[ "telemetry" ].match_time_elapsed = int( game_utility_mp::getsecondspassed() );
        var_8338cacd5176ae75 = player currency::get_currency_amount( #"essence" );
        player.pers[ "telemetry" ].var_38e5ef1f0057f455 = 1;
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x15030fe9, Offset: 0x2ddd
// Size: 0x6a3
function on_ai_killed( params )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( !isdefined( params.eattacker ) )
    {
        return;
    }
    
    vehicle_kill = 0;
    attacker = params.eattacker;
    
    if ( params.eattacker vehicle::is_vehicle() )
    {
        attacker = params.eattacker getvehicleowner();
        vehicle_kill = 1;
    }
    else if ( params.einflictor vehicle::is_vehicle() )
    {
        attacker = params.einflictor getvehicleowner();
        vehicle_kill = 1;
    }
    else if ( isplayer( params.eattacker.owner ) )
    {
        attacker = params.eattacker.owner;
    }
    else if ( isplayer( params.einflictor.owner ) )
    {
        attacker = params.einflictor.owner;
    }
    
    if ( params.einflictor.streakname == "rcxd" )
    {
        vehicle_kill = 0;
    }
    
    if ( isplayer( attacker ) )
    {
        player = attacker;
        
        if ( !telemetry_utils::is_valid_client( player ) )
        {
            return;
        }
        
        if ( !isdefined( self.last_dmg_struct ) )
        {
            return;
        }
        
        num_hits = self.last_dmg_struct.num_hits;
        sweapon = self.last_dmg_struct.sweapon;
        aicategory = self.aicategory;
        kiastring = self.kiastring;
        biscritical = self.last_dmg_struct.biscritical;
        unittype = self.unittype;
        type = self.type;
        subclass = self.subclass;
        
        if ( !isdefined( aicategory ) && kiastring == #"warlord_kia" )
        {
            aicategory = "boss";
        }
        
        if ( num_hits == 1 )
        {
            player.pers[ "telemetry" ].one_shot_kills++;
        }
        
        if ( vehicle_kill )
        {
            kiastring = points::function_47dc9b24caa6ae1f( kiastring, "_vehicle" );
        }
        
        if ( isdefined( sweapon ) && !isnullweapon( sweapon ) )
        {
            if ( !isdefined( level.ob_ai_killed_telemetry_throttle ) )
            {
                level.ob_ai_killed_telemetry_throttle = throttle::throttle_initialize( "ob_ai_killed_telemetry_throttle", 1, level.framedurationseconds );
            }
            
            ai_killed_event = spawnstruct();
            throttle::throttle_wait_in_queue( level.ob_ai_killed_telemetry_throttle, ai_killed_event );
            
            if ( !telemetry_utils::is_valid_client( player ) )
            {
                return;
            }
            
            weaponname = weapon::getweaponrootname( sweapon );
            fullweaponname = getcompleteweaponname( sweapon );
            variantindex = getweaponvariantindex( sweapon );
            ai_killed_telemetry = { #weaponobj:sweapon, #statupdates:[], #variantid:variantindex, #fullweaponname:fullweaponname, #weaponname:weaponname };
            
            if ( isdefined( aicategory ) )
            {
                statname = undefined;
                
                if ( aicategory == "normal" )
                {
                    player.pers[ "telemetry" ].normal_kills++;
                    statname = "weapon_normal_zombie_kills";
                }
                else if ( aicategory == "special" )
                {
                    player.pers[ "telemetry" ].special_kills++;
                    statname = "weapon_special_zombie_kills";
                }
                else if ( aicategory == "elite" || aicategory == "hvt" )
                {
                    player.pers[ "telemetry" ].elite_kills++;
                    statname = "weapon_elite_zombie_kills";
                }
                else if ( aicategory == "boss" || kiastring == #"deathworm_kia" || kiastring == #"warlord_kia" )
                {
                    player.pers[ "telemetry" ].boss_kills++;
                    player.pers[ "telemetry" ].boss_kills_xp = player.pers[ "telemetry" ].boss_kills_xp + ( rank::getscoreinfoxp( kiastring ) ?? 0 );
                    statname = "weapon_boss_zombie_kills";
                }
                
                telemetry::function_6367d060fde50007( ai_killed_telemetry, statname, 1 );
            }
            
            if ( player pack_a_punch::get_pap_level( sweapon ) > 0 )
            {
                player.pers[ "telemetry" ].pack_a_punch_kills++;
                telemetry::function_6367d060fde50007( ai_killed_telemetry, "weapon_pack_a_punch_kills", 1 );
            }
            
            if ( biscritical )
            {
                player.pers[ "telemetry" ].critical_kills++;
                telemetry::function_6367d060fde50007( ai_killed_telemetry, "weapon_critical_kills", 1 );
            }
            
            if ( unittype == "soldier" )
            {
                player.pers[ "telemetry" ].soldier_kills++;
                player.pers[ "telemetry" ].soldier_kills_xp = player.pers[ "telemetry" ].soldier_kills_xp + ( rank::getscoreinfoxp( kiastring ) ?? 0 );
                telemetry::function_6367d060fde50007( ai_killed_telemetry, "weapon_soldier_kills", 1 );
            }
            else if ( type == "zombie" )
            {
                player.pers[ "telemetry" ].var_f36fb1bbac403cae++;
                player.pers[ "telemetry" ].var_a3ef261d278ed203 = player.pers[ "telemetry" ].var_a3ef261d278ed203 + ( rank::getscoreinfoxp( kiastring ) ?? 0 );
            }
            
            statname = "weapon_white_rarity_kills";
            var_d1ad847a3b590336 = player namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( sweapon );
            
            if ( isdefined( var_d1ad847a3b590336 ) )
            {
                switch ( var_d1ad847a3b590336 )
                {
                    case 0:
                        statname = "weapon_white_rarity_kills";
                        break;
                    case 1:
                        statname = "weapon_green_rarity_kills";
                        break;
                    case 2:
                        statname = "weapon_blue_rarity_kills";
                        break;
                    case 3:
                        statname = "weapon_purple_rarity_kills";
                        break;
                    case 4:
                        statname = "weapon_orange_rarity_kills";
                        break;
                }
            }
            
            telemetry::function_6367d060fde50007( ai_killed_telemetry, statname, 1 );
            player telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", ai_killed_telemetry );
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x203b69de, Offset: 0x3488
// Size: 0x199
function on_ob_infil_complete( params )
{
    players = level.players;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        [ var_3bd74208532ff4af, var_91335465cea304c0, var_42cf513a77bb356 ] = player namespace_3a2a361a08f89b78::get_backpack_items();
        var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( player.origin );
        var_80332670868723c3 = [];
        var_80332670868723c3 = player namespace_3a2a361a08f89b78::function_96b13be3ded29bab( var_80332670868723c3 );
        player dlog_recordplayerevent( "dlog_event_ob_player_infil_complete", [ "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "backpack_items", var_3bd74208532ff4af, "loadout_items", var_80332670868723c3, "acquisition_items", var_91335465cea304c0, "schematic_items", var_42cf513a77bb356 ] );
        waitframe();
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xa7a22a62, Offset: 0x3629
// Size: 0xc
function function_6b978478e66b1b5a( data )
{
    
}

// Namespace ob_analytics
// Params 1
// Checksum 0x3b52251e, Offset: 0x363d
// Size: 0x1e
function on_mission_complete( params )
{
    if ( isplayer( params.player ) )
    {
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x23953dc9, Offset: 0x3663
// Size: 0xaa
function on_player_death( params )
{
    if ( isplayer( self ) )
    {
        telemetry_coop::player_death_event( "was_killed" );
    }
    
    squadmembers = squad_utility::getsquadmembers();
    
    foreach ( player in squadmembers )
    {
        if ( isalive( player ) )
        {
            return;
        }
    }
    
    function_79a6c334ba3a4e85();
}

// Namespace ob_analytics
// Params 0
// Checksum 0x8a353922, Offset: 0x3715
// Size: 0xbd
function function_79a6c334ba3a4e85()
{
    activitystruct = activity_player_common::function_ef912bdece1bc4ef( self );
    
    if ( isdefined( activitystruct.focusedactivityid ) )
    {
        var_129646c41fa9ce9d = activity_common::getactivityinstance( activitystruct.focusedactivityid );
        activity_type = var_129646c41fa9ce9d.type;
    }
    
    dlog_recordevent( "dlog_event_ob_team_eliminated", [ "team", self.team, "survival_time", gettime() - level.starttime, "activity_type", activity_type ?? "none", "was_rift_run", self.rift_run ] );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xd625619c, Offset: 0x37da
// Size: 0x58
function function_b0f8cce4da821455( params )
{
    if ( isplayer( params.reviver ) )
    {
        params.reviver.pers[ "telemetry" ].teammates_revived++;
    }
    
    if ( isplayer( self ) )
    {
        telemetry_coop::player_death_event( "was_revived" );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xb4a62570, Offset: 0x383a
// Size: 0x130
function on_player_loot_cache( params )
{
    if ( isplayer( self ) )
    {
        self.pers[ "telemetry" ].looted_containers++;
    }
    
    if ( isdefined( params ) && isdefined( params.cacheinstance ) && isdefined( params.items ) )
    {
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( params.cacheinstance.origin );
        }
        
        var_2f92f97a929f9923 = [];
        
        foreach ( item in params.items )
        {
            if ( isdefined( item.lootid ) )
            {
                var_2f92f97a929f9923[ var_2f92f97a929f9923.size ] = item.lootid;
            }
        }
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x365b647f, Offset: 0x3972
// Size: 0xcc
function function_2bec3d1d08d4abee( params )
{
    if ( isplayer( self ) )
    {
        self.pers[ "telemetry" ].var_97df315dd9fee0e9++;
    }
    
    if ( isdefined( params.cacheinstance ) )
    {
        dlog_recordevent( "dlog_event_ob_human_faction_squad_get_encampment_key", [ "key_cache_location_x", params.cacheinstance.origin[ 0 ], "key_cache_location_y", params.cacheinstance.origin[ 0 ], "key_cache_location_z", params.cacheinstance.origin[ 0 ], "merc_camp_name", params.merc_camp_name ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x7768d3d1, Offset: 0x3a46
// Size: 0xcc
function function_1157c3fa05ff30de( params )
{
    if ( isplayer( self ) )
    {
        self.pers[ "telemetry" ].var_fdf5e1f9296bdf6d++;
    }
    
    if ( isdefined( params.cacheinstance ) )
    {
        dlog_recordevent( "dlog_event_ob_human_faction_squad_get_stronghold_key", [ "key_cache_location_x", params.cacheinstance.origin[ 0 ], "key_cache_location_y", params.cacheinstance.origin[ 0 ], "key_cache_location_z", params.cacheinstance.origin[ 0 ], "stronghold_name", params.stronghold_name ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0x4019ed25, Offset: 0x3b1a
// Size: 0x60
function on_player_damaged_warlord( params )
{
    if ( isplayer( self ) )
    {
        self.pers[ "telemetry" ].damaged_warlords++;
    }
    
    if ( isdefined( params.cacheinstance ) )
    {
        dlog_recordevent( "dlog_event_ob_human_faction_squad_damage_warlord", [ "warlord_name", params.warlord_name ] );
    }
}

// Namespace ob_analytics
// Params 1
// Checksum 0xf170663d, Offset: 0x3b82
// Size: 0x117
function on_player_killed_warlord( params )
{
    if ( isplayer( self ) )
    {
        self.pers[ "telemetry" ].killed_warlords++;
    }
    
    if ( isdefined( params ) )
    {
        dlog_recordevent( "dlog_event_ob_human_faction_warlord_kill", [ "warlord_name", params.warlord_name ] );
        dlog_recordevent( "dlog_event_ob_human_faction_warlord_death_means", [ "warlord_means", params.warlord_means_of_death, "warlord_name", params.warlord_name ] );
        timedifference = params.warlord_time_of_death - params.warlord_spawned_timestamp;
        dlog_recordevent( "dlog_event_ob_human_faction_time_to_death", [ "warlord_name", params.warlord_name, "stronghold_open_time", params.warlord_spawned_timestamp, "warlord_death_time", params.warlord_time_of_death, "time_difference", timedifference ] );
    }
}

// Namespace ob_analytics
// Params 3
// Checksum 0xdc964806, Offset: 0x3ca1
// Size: 0x5f
function function_fb1cea4931f5d970( player, points, xp )
{
    player dlog_recordplayerevent( "dlog_event_ob_player_activity_award", [ "activity_instance", self.varianttag, "power_tier_xp", points, "base_rank_xp", xp ] );
}

// Namespace ob_analytics
// Params 2
// Checksum 0x320577f8, Offset: 0x3d08
// Size: 0xef
function function_83b221bbc39fca8( player, index )
{
    activity_info = level.var_a964e9285c1f8206[ index ];
    var_3aab9f12f9af0b47 = activity_info.ddl_bit;
    current_mission_name = story_contract_util::function_d4e03884b38da3d8( player );
    clientnum = player getplayerclientnum();
    function_1a4bcaf4087cf6f2( clientnum, current_mission_name ?? "" + activity_info.story_index );
    player.var_b077deb7114b14f9 = gettime();
    is_using_vcon = player function_837cf56ce8e59b00();
    player dlog_recordplayerevent( "dlog_event_ob_player_story_mission_begin", [ "mission", var_3aab9f12f9af0b47 ?? "" + index, "session_squad_id", player.sessionsquadid, "is_using_vcon", is_using_vcon ] );
}

// Namespace ob_analytics
// Params 2
// Checksum 0x82eeb407, Offset: 0x3dff
// Size: 0xfc
function function_e543b14a44184994( player, index )
{
    activity_info = level.var_a964e9285c1f8206[ index ];
    var_3aab9f12f9af0b47 = activity_info.ddl_bit;
    player dlog_recordplayerevent( "dlog_event_ob_player_story_mission_completed", [ "mission", var_3aab9f12f9af0b47 ?? "" + index, "participate_time", gettime() - ( player.var_b077deb7114b14f9 ?? player.connecttime ), "player_x", player.origin[ 0 ], "player_y", player.origin[ 1 ], "player_z", player.origin[ 2 ], "session_squad_id", player.sessionsquadid ] );
}

// Namespace ob_analytics
// Params 1
// Checksum 0xb5218a61, Offset: 0x3f03
// Size: 0x5b
function on_perk_purchased( sparams )
{
    if ( isdefined( sparams.perkref ) )
    {
        self.pers[ "telemetry" ].perks_obtained[ self.pers[ "telemetry" ].perks_obtained.size ] = sparams.perkref;
    }
}

