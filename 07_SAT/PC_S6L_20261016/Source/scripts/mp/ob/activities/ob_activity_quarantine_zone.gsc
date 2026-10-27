// scripts\mp\ob\activities\ob_activity_quarantine_zone.gsc  (hash_5e18ece55e10c49f.gscc) (size: 31477 Bytes / 0x7af5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86189d13 (2249760019)
// size ...... 31477 (0x7af5)
// includes .. 35  (offset: 0x7525)
// strings ... 85  (offset: 0x763d)
// dev strs .. 7   (offset: 0x7aa1)
// exports ... 61  (offset: 0x507d)
// cseg ...... 0x721 + 0x495c (0x507d)
// imports ... 220 (offset: 0x5a05)
// animtree1 . 0   (offset: 0x7af5)
// animtree2 . 0   (offset: 0x7af5)
#using script_30152080457bb762;
#using script_4eb10b8076cd40c;
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\activities\ob_activity_composite_utils;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_quarantine_zone;

// Namespace ob_activity_quarantine_zone
// Params 0, eflags: 0x5
// Checksum 0x6d0a08b8, Offset: 0x73f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_quarantine_zone", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_quarantine_zone
// Params 0, eflags: 0x4
// Checksum 0x52e9647b, Offset: 0x768
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_QUARANTINE_ZONE", &function_bc65776d7c87cc0b );
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xb21d2765, Offset: 0x783
// Size: 0x15e
function function_bc65776d7c87cc0b()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ZONE", 0, &quarantine_zone_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ZONE", 1, &quarantine_zone_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ZONE", 2, &quarantine_zone_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ZONE", 3, &function_693fb70f2fe6b5d2 );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ZONE", 5, &function_fec785b14862caa0 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_a219ef7a66cf1d63, "REV_OB_QUARANTINE_ZONE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_a95d5a34e530ac93, "REV_OB_QUARANTINE_ZONE" );
    
    if ( !isdefined( level.var_1ca65390816f8361 ) )
    {
        scriptable::scriptable_adddamagedcallback( &function_771b56e9e2b0af77 );
        level.var_1ca65390816f8361 = 1;
    }
    
    utility::registersharedfunc( "ob_quarantine_zone_door", #"hack", &function_ec00319d5c9ab121 );
    utility::registersharedfunc( "ob_quarantine_zone_door", #"start_hacking", &function_b0b67ab23297e563 );
    utility::registersharedfunc( "ob_quarantine_zone_rollup_door", #"hack", &function_ec00319d5c9ab121 );
    utility::registersharedfunc( "ob_quarantine_zone_rollup_door", #"start_hacking", &function_b0b67ab23297e563 );
    scriptable::scriptable_addusedcallbackbypart( "quarantine_zone_door_usable", &door_lock_scriptable_used );
    scriptable::scriptable_addusedcallbackbypart( "quarantine_zone_safe", &function_c8a9b246d60d8c7 );
    
    if ( !level.var_3b56f00a3f54ab26 )
    {
        level.var_3b56f00a3f54ab26 = throttle::throttle_initialize( "ob_stronghold_lockdoor", 2 );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xa66c5c5f, Offset: 0x8e9
// Size: 0x438
function quarantine_zone_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    self.s_center = utility::getstruct( self.varianttag + "_main", "targetname" );
    
    if ( !isdefined( self.s_center ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
    }
    
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.s_center.origin );
    
    switch ( self.difficulty_region )
    {
        case #"hash_c0250ffc2e87f2ff":
            self.var_2ecaecd2562f45e = 7000;
            self.active_zombie_cap = 12;
            self.var_414531652cd3271 = 20;
            self.safeitemspawnlist = self.var_91c91f4a631c481d.var_3e11a75535d2643f.safeitemspawnlist;
            self.var_3de5a2fc47d78f2 = self.var_91c91f4a631c481d.var_3e11a75535d2643f.var_3de5a2fc47d78f2;
            break;
        case #"hash_651f76c0ad6741ec":
            self.var_2ecaecd2562f45e = 7000;
            self.active_zombie_cap = 12;
            self.var_414531652cd3271 = 18;
            self.safeitemspawnlist = self.var_91c91f4a631c481d.var_3e11a75535d2643f.safeitemspawnlist;
            self.var_3de5a2fc47d78f2 = self.var_91c91f4a631c481d.var_3e11a75535d2643f.var_3de5a2fc47d78f2;
            break;
        case #"hash_5343b465e56ec9a4":
            self.var_2ecaecd2562f45e = 5125;
            self.active_zombie_cap = 10;
            self.var_414531652cd3271 = 16;
            self.safeitemspawnlist = self.var_91c91f4a631c481d.var_3e11a45535d25da6.safeitemspawnlist;
            self.var_3de5a2fc47d78f2 = self.var_91c91f4a631c481d.var_3e11a45535d25da6.var_3de5a2fc47d78f2;
            break;
        case #"hash_af83e47edfa8900a":
            self.var_2ecaecd2562f45e = 3300;
            self.active_zombie_cap = 8;
            self.var_414531652cd3271 = 14;
            self.safeitemspawnlist = self.var_91c91f4a631c481d.var_3e11a55535d25fd9.safeitemspawnlist;
            self.var_3de5a2fc47d78f2 = self.var_91c91f4a631c481d.var_3e11a55535d25fd9.var_3de5a2fc47d78f2;
            break;
        case #"hash_7bb2cd766703d463":
        default:
            self.var_2ecaecd2562f45e = 2000;
            self.active_zombie_cap = 6;
            self.var_414531652cd3271 = 12;
            self.safeitemspawnlist = self.var_91c91f4a631c481d.var_3e11a25535d25940.safeitemspawnlist;
            self.var_3de5a2fc47d78f2 = self.var_91c91f4a631c481d.var_3e11a25535d25940.var_3de5a2fc47d78f2;
            break;
    }
    
    self.var_c2127c21995e9409 = self.var_2ecaecd2562f45e;
    self.var_5efb395e6b88cee8 = self.var_2ecaecd2562f45e * 0.666667;
    self.var_400228510f338a3a = self.var_2ecaecd2562f45e * 0.333333;
    self.started = 0;
    self.var_58f16cb9744ac1d5 = 0;
    self.var_106349cce4eabb6a = self.var_414531652cd3271 - 4;
    self.var_a1dcfcad82310fb3 = [];
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, self.var_106349cce4eabb6a );
    setup_structs();
    setup_safe();
    setup_cysts();
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( !additional_spawn_data.var_d9274cd4b9b9a361 )
    {
        thread setup_linked_activities();
    }
    
    if ( !additional_spawn_data.var_2fd8956d4905e73 )
    {
        thread _lock_all_doors();
    }
    else
    {
        self.all_doors_unlocked = 1;
    }
    
    function_74bbe85e39e66206();
    spatial_zone_container::function_11cd1f1428a0af78( 0, &function_4a81af1f88d93532 );
    childthread function_f3812f02bde609c0();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x53390968, Offset: 0xd29
// Size: 0xec
function function_74bbe85e39e66206()
{
    terminal_structs = utility::function_b7f3d374aa10aa51( "Qzone_terminal_for_Heist", "script_noteworthy", self.s_center.origin, 2000 );
    
    if ( terminal_structs.size > 0 )
    {
        index = randomintrange( 0, terminal_structs.size );
        terminal_struct = terminal_structs[ index ];
        terminal = spawnscriptable( "sat_ob_heist_sky_control", ob_activity_utility::function_fd8fc0e0d2300792( terminal_struct.origin ), ob_activity_utility::function_fd8fc0e0d2300792( terminal_struct.angles ) );
        terminal setscriptablepartstate( #"heist_computer_station_usable", #"unusable" );
        self.terminal = terminal;
        terminal.owner_activity = self;
        return;
    }
    
    assertmsg( "<dev string:x24>" + self.origin + "<dev string:x64>" + self.varianttag );
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xb5d675c9, Offset: 0xe1d
// Size: 0xe6
function setup_linked_activities()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_330ab7d8c61d5307 = ob_activity_manager::function_ed1dae3a9cce08d2( self.varianttag );
    
    if ( var_330ab7d8c61d5307 )
    {
        foreach ( var_99c2b0d0a40bdfae in var_330ab7d8c61d5307 )
        {
            if ( var_99c2b0d0a40bdfae.type == "REV_OB_SUPPLY_DROP" )
            {
                self.var_c9876a8e7895a3a = namespace_d6b7e33ec877018f::setup_child_activity( "REV_OB_SUPPLY_DROP", var_99c2b0d0a40bdfae.name );
                return;
            }
            
            throttle::throttle_wait_in_queue( level.setup_linked_activities_throttle, self );
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xa2ddcd1d, Offset: 0xf0b
// Size: 0x9b
function function_338e9eba72105ea9()
{
    var_90660cf38103b643 = getnoentvolumearray( "entrance_" + self.varianttag, #targetname );
    
    foreach ( var_43aedf856cd54ff5 in var_90660cf38103b643 )
    {
        var_43aedf856cd54ff5 thread function_f853f6c9eea45023( self );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xc678856d, Offset: 0xfae
// Size: 0x2af
function function_f853f6c9eea45023( instance )
{
    instance endon( #"activity_ended" );
    instance endon( #"instance_destroyed" );
    instance endon( #"nest_cleared" );
    
    if ( !isdefined( instance.breached_players ) )
    {
        instance.breached_players = [];
    }
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        players = [];
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) )
                {
                    players[ players.size ] = occupant;
                }
            }
        }
        else
        {
            players[ players.size ] = ent;
        }
        
        if ( players.size == 0 )
        {
            continue;
        }
        
        activity_participation::function_fb0ec90aaf6d4c61( instance, players, "PlayerJoinedProximity" );
        
        foreach ( player in players )
        {
            if ( !arraycontains( instance.breached_players, player ) )
            {
                instance.breached_players = arraycombineunique( instance.breached_players, [ player ] );
                var_6f4bb5f194cdcf92 = activity_participation::function_e8eabd79cc49540e( player, [ "REV_OB_HEIST" ] );
                
                if ( var_6f4bb5f194cdcf92.size )
                {
                    instanceid = getarraykey( var_6f4bb5f194cdcf92, 0 );
                    heistinstance = level.activities.instances[ instanceid ];
                    
                    if ( heistinstance.terminal.origin )
                    {
                        if ( distance2dsquared( instance.var_441d26d05f86b224, heistinstance.terminal.origin ) <= 4000000 )
                        {
                            heistinstance ob_activity_utility::function_894ac80e038636c5( "wcpveheisthack", [ player ] );
                        }
                    }
                    
                    continue;
                }
                
                instance ob_activity_utility::function_894ac80e038636c5( "wcaquastrongholdspore", [ player ] );
            }
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x3c99d44d, Offset: 0x1265
// Size: 0x1cf
function setup_structs()
{
    all_structs = utility::getstructarray( self.s_center.targetname, "target" );
    self.a_s_cysts = [];
    self.var_b65091063dffc8f1 = [];
    self.var_d4c224d9c5d1d32f = [];
    
    foreach ( struct in all_structs )
    {
        if ( struct.targetname == "s_cyst_spawn" )
        {
            self.a_s_cysts[ self.a_s_cysts.size ] = struct;
        }
        else if ( struct.script_noteworthy == "s_safe_spawn" )
        {
            self.safe_spawn = struct;
        }
        
        switch ( struct.script_noteworthy )
        {
            case #"hash_2a78ee15440a7a06":
                struct.var_34b4ebb3144ed460 = 1;
                self.var_b65091063dffc8f1[ self.var_b65091063dffc8f1.size ] = struct;
                break;
            case #"hash_c4b0e76a67e9b991":
                self.var_d4c224d9c5d1d32f[ self.var_d4c224d9c5d1d32f.size ] = struct;
                break;
        }
    }
    
    if ( isdefined( self.s_center.var_5bf3f724a0920d67 ) )
    {
        var_b88cff45f0beffdb = utility::getstructarray( self.s_center.var_5bf3f724a0920d67, "targetname" );
        self.var_c0c940b175bdf3ca = function_47c86977a18df38b( var_b88cff45f0beffdb, self.s_center.origin, 1000 );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x3bead30, Offset: 0x143c
// Size: 0x149
function setup_safe()
{
    if ( isdefined( self.safe_spawn ) )
    {
        spawnorigin = ob_activity_utility::function_fd8fc0e0d2300792( self.safe_spawn.origin );
        spawnangles = ob_activity_utility::function_fd8fc0e0d2300792( self.safe_spawn.angles );
        self.safe = spawnscriptable( %"quarantine_zone_safe", spawnorigin, spawnangles );
        self.safe.safeitemspawnlist = self.safeitemspawnlist;
        self.safe.var_3de5a2fc47d78f2 = self.var_3de5a2fc47d78f2;
        self.safe.vine = spawnscriptable( %"sat_ob_quarantine_zone_safe_vine", spawnorigin, spawnangles );
        self.safe.vine setscriptablepartstate( #"state", #"visible_large_hint" );
        self.safe.vine interaction::function_303bcca6287d3d71( &function_640a42cb2fe59258 );
        self.safe.vine interaction::set_interact_hint_callback( &vine_hint );
        return;
    }
    
    assertmsg( "<dev string:x69>" );
}

// Namespace ob_activity_quarantine_zone
// Params 6
// Checksum 0x6dc28988, Offset: 0x158d
// Size: 0x11b
function function_c8a9b246d60d8c7( instance, part, state, player, bautouse, usestring )
{
    if ( instance getscriptablepartstate( #"quarantine_zone_safe", 0, 1 ) != #"open_usable" )
    {
        return;
    }
    
    instance setscriptablepartstate( #"quarantine_zone_safe", #"opening" );
    instance calloutmarkerping::function_608710c894185549();
    level thread function_ec8d1bbb1a1e91da( instance.origin, instance.safeitemspawnlist, instance.var_3de5a2fc47d78f2 );
    
    if ( instance.vine && instance.vine getscriptablepartstate( #"state", 0, 1 ) != #"dead" )
    {
        instance.vine setscriptablepartstate( #"state", #"dead" );
    }
    
    if ( instance.vine_trigger )
    {
        instance.vine_trigger delete();
    }
}

// Namespace ob_activity_quarantine_zone
// Params 3
// Checksum 0x241b7044, Offset: 0x16b0
// Size: 0x63
function function_ec8d1bbb1a1e91da( origin, item_spawn_list, item_spawn_count )
{
    waitframe();
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( origin + ( 0, 0, 70 ) );
    spawnoptions.spawnpositionindex = 5;
    items = common_item::function_38cde6a6acb68ea6( item_spawn_list, item_spawn_count, spawnoptions );
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0x26d6cbce, Offset: 0x171b
// Size: 0x36
function vine_hint( usable, player )
{
    return { #string:&"jup_ob_objectives/aether_nest_cache_locked", #type:"HINT_NOBUTTON" };
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0xbff485bf, Offset: 0x175a
// Size: 0x16, Type: bool
function function_640a42cb2fe59258( scriptable, player )
{
    return false;
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x7600d454, Offset: 0x1779
// Size: 0xf4
function setup_cysts()
{
    self.var_f13640703a255fe4 = function_99d7cbd66a1e53e4( self.a_s_cysts, self.var_414531652cd3271 );
    self.cysts = [];
    self.cleanup_cysts = [];
    self.scriptable = spawnscriptable( %"sat_ob_quarantine_zone_activity_scriptable", self.s_center.origin );
    
    foreach ( s_cyst in self.var_f13640703a255fe4 )
    {
        s_cyst.cyst_health = int( self.var_2ecaecd2562f45e / self.var_f13640703a255fe4.size );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0x6b148ae1, Offset: 0x1875
// Size: 0x1a0
function function_99d7cbd66a1e53e4( all_spawn_structs, var_8412f95215fbbd9b )
{
    buckets = [];
    bucket_keys = [];
    
    foreach ( struct in all_spawn_structs )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            if ( !isdefined( buckets[ struct.script_noteworthy ] ) )
            {
                buckets[ struct.script_noteworthy ] = [];
                bucket_keys[ bucket_keys.size ] = struct.script_noteworthy;
            }
            
            buckets[ struct.script_noteworthy ][ buckets[ struct.script_noteworthy ].size ] = struct;
        }
    }
    
    if ( bucket_keys.size > 0 )
    {
        bucket_keys = arrayrandomize( bucket_keys );
        selected_spawn_structs = [];
        i = 0;
        target_num_spawns = min( var_8412f95215fbbd9b, all_spawn_structs.size );
        
        while ( selected_spawn_structs.size < target_num_spawns )
        {
            var_2a88723414227592 = i % bucket_keys.size;
            
            if ( buckets[ bucket_keys[ var_2a88723414227592 ] ].size > 0 )
            {
                var_a4f4dea85619f7a8 = utility::array_random( buckets[ bucket_keys[ var_2a88723414227592 ] ] );
                buckets[ bucket_keys[ var_2a88723414227592 ] ] = arrayremove( buckets[ bucket_keys[ var_2a88723414227592 ] ], var_a4f4dea85619f7a8 );
                selected_spawn_structs[ selected_spawn_structs.size ] = var_a4f4dea85619f7a8;
            }
            
            i += 1;
        }
        
        return selected_spawn_structs;
    }
    
    return utility::array_slice( arrayrandomize( all_spawn_structs ), 0, var_8412f95215fbbd9b );
}

// Namespace ob_activity_quarantine_zone
// Params 11
// Checksum 0x6248078d, Offset: 0x1a1d
// Size: 0x2c1
function function_771b56e9e2b0af77( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_ob_quarantine_zone_flower_scriptable" || instance.destroyed )
    {
        return;
    }
    
    flower = instance;
    
    if ( isdefined( flower.spawner ) )
    {
        flower.spawner notify( #"start_spawn" );
    }
    
    if ( weapon::iswonderweapon( objweapon ) )
    {
        idamage = function_dadb12e90fff3806( idamage );
    }
    
    if ( isdefined( flower.health ) )
    {
        flower.health -= idamage;
        
        if ( isplayer( eattacker ) )
        {
            flower.a_player_assist = arraycombineunique( flower.a_player_assist, [ eattacker ] );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                mp_agent_damage::function_eb8ba16055d6da7c( eattacker, flower.var_6ae174d782d4ae, "none", smeansofdeath, objweapon, int( idamage ), undefined, 0, undefined, 0, 0 );
            }
            
            eattacker damagefeedback::updatehitmarker( "standard", flower.health <= 0, 0, 0, undefined );
            
            if ( !arraycontains( flower.activity_instance.playerparticipants, eattacker ) )
            {
                activity_participation::function_bc67362dace4370c( flower.activity_instance, eattacker );
            }
            
            if ( !eattacker.var_4bf11a8d9e26cab7 && !arraycontains( flower.activity_instance.var_a1dcfcad82310fb3, eattacker ) )
            {
                eattacker thread function_caaed276ac2c061c( flower.activity_instance );
            }
        }
        
        flower.activity_instance.var_1d0b08fe550caf30 = eattacker;
        
        if ( !flower.activity_instance.started )
        {
            flower.activity_instance notify( #"quarantine_zone_start" );
        }
        
        flower.activity_instance function_6aa09da8e2df2dd7( idamage );
        
        if ( flower.health <= 0 )
        {
            eattacker points::ob_do_score_event( #"ob_aethernest_cyst_destroyed" );
            flower thread flower_death( eattacker );
            params = spawnstruct();
            params.player = eattacker;
            params.cyst = flower;
            eattacker callback::callback( "aethernest_cyst_destroyed", params );
            return;
        }
        
        flower utility::function_32b24db3127bff40( "body", "damaged" );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x6ab7ba66, Offset: 0x1ce6
// Size: 0xbb
function function_caaed276ac2c061c( activity_instance )
{
    self endon( #"disconnect" );
    self.var_4bf11a8d9e26cab7 = 1;
    assigned_handler = utility::array_random( [ "_david", "_samuels", "_harper", "_fiftyfifty" ] );
    activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaquastrongholdhalluc", [ self ], [ assigned_handler ] );
    cd = activity_instance ob_activity_utility::get_conversation_cooldown_time( "wcaquastrongholdhalluc" + assigned_handler );
    wait cd ?? 3;
    self.var_4bf11a8d9e26cab7 = undefined;
    activity_instance.var_a1dcfcad82310fb3[ activity_instance.var_a1dcfcad82310fb3.size ] = self;
}

// Namespace ob_activity_quarantine_zone
// Params 1, eflags: 0x4
// Checksum 0xb7b017bb, Offset: 0x1da9
// Size: 0x19
function private function_dadb12e90fff3806( idamage )
{
    return int( max( idamage, 500 ) );
}

// Namespace ob_activity_quarantine_zone
// Params 1, eflags: 0x4
// Checksum 0xc481cac7, Offset: 0x1dcb
// Size: 0x1b5
function private flower_death( attacker )
{
    self endon( #"death" );
    flower = self;
    activity_instance = flower.activity_instance;
    flower.destroyed = 1;
    flower setscriptablepartstate( "health", "ignore_damage" );
    flower setscriptablepartstate( "body", "bursted" );
    flower setscriptablepartstate( "usable", "off" );
    activity_instance.cysts = arrayremove( activity_instance.cysts, flower );
    activity_instance.var_58f16cb9744ac1d5++;
    ob_activity_utility::function_f257a06b8f9e4c53( flower );
    activity_definition_utils::updateprogress( activity_instance.var_58f16cb9744ac1d5, activity_instance );
    activity_instance thread function_58a9b552bf6adb6c( attacker );
    
    if ( !activity_instance.var_67c8e83824bb5ebb )
    {
        if ( activity_instance.var_106349cce4eabb6a - activity_instance.var_58f16cb9744ac1d5 <= 3 )
        {
            activity_instance.var_67c8e83824bb5ebb = 1;
            
            foreach ( cyst in activity_instance.cysts )
            {
                cyst setscriptablepartstate( #"outline", #"on" );
            }
        }
    }
    
    if ( activity_instance.var_58f16cb9744ac1d5 >= activity_instance.var_106349cce4eabb6a )
    {
        activity_instance notify( #"nest_cleared" );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x76c3a3a0, Offset: 0x1f88
// Size: 0x88
function function_58a9b552bf6adb6c( attacker )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !activity_instance.var_832a01b4068ce719 && arraycontains( self.var_a1dcfcad82310fb3, attacker ) )
    {
        activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaquashflowerelim", [ attacker ] );
        activity_instance.var_832a01b4068ce719 = 1;
        wait 2;
        activity_instance.var_832a01b4068ce719 = 0;
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xcc3d4547, Offset: 0x2018
// Size: 0xf3
function function_f3812f02bde609c0()
{
    briefing_zone = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" )[ 0 ];
    origin = spatial_zone_container::function_2676e037929f0833( briefing_zone );
    radius = spatial_zone_container::function_231d9e91d8ef7b5f( briefing_zone );
    var_56ae48f9eceb8b3a = [];
    
    while ( true )
    {
        wait 0.2;
        player_list = function_d63fe6a4c08ba6f5( origin, radius, 2000, 0, var_56ae48f9eceb8b3a );
        
        foreach ( player in player_list )
        {
            ob_activity_utility::function_894ac80e038636c5( "wcaquastrongholdbrief", [ player ], undefined, undefined );
            var_56ae48f9eceb8b3a[ var_56ae48f9eceb8b3a.size ] = player;
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x2d336eed, Offset: 0x2113
// Size: 0x451
function function_4a81af1f88d93532( var_54c779cf281bb58d )
{
    if ( activity_instance_common::getactivitytype( self ) != "REV_OB_QUARANTINE_ZONE" )
    {
        return;
    }
    
    player = var_54c779cf281bb58d.player;
    
    if ( !isdefined( self.players_nearby ) )
    {
        self.players_nearby = [];
    }
    
    if ( !isdefined( self.var_70e9ace0eb08368b ) )
    {
        self.var_70e9ace0eb08368b = [];
    }
    
    prev_players_nearby = self.players_nearby;
    self.players_nearby = [[ var_54c779cf281bb58d.var_de8af980c94ffa6b ]]( var_54c779cf281bb58d );
    
    if ( self.players_nearby.size > prev_players_nearby.size && prev_players_nearby.size == 0 )
    {
        if ( !arraycontains( self.var_70e9ace0eb08368b, player ) )
        {
            haskey = 1;
            
            if ( haskey )
            {
                squad = player squad_utility::getsquadmembers();
                
                if ( squad.size == 0 )
                {
                    squad = [ player ];
                }
                
                foreach ( squadmate in squad )
                {
                    squadmate callback::callback( "on_approach_zm_stronghold" );
                    self.var_70e9ace0eb08368b[ self.var_70e9ace0eb08368b.size ] = squadmate;
                }
            }
        }
        
        foreach ( s_cyst in self.var_f13640703a255fe4 )
        {
            cyst = spawnscriptable( %"sat_ob_quarantine_zone_flower_scriptable", s_cyst.origin, s_cyst.angles );
            cyst.s_cyst = s_cyst;
            cyst.health = s_cyst.cyst_health;
            
            if ( s_cyst.cyst_health > 0 )
            {
                cyst.var_6ae174d782d4ae = cyst;
                cyst.var_6ae174d782d4ae.var_d62ad5bfd64ba592 = "tag_origin";
                cyst.activity_instance = self;
                
                if ( isdefined( s_cyst.spawner ) )
                {
                    cyst.spawner = s_cyst.spawner;
                }
                
                self.cysts[ self.cysts.size ] = cyst;
                cyst setscriptablepartstate( #"usable", #"off" );
                
                if ( self.var_67c8e83824bb5ebb )
                {
                    cyst setscriptablepartstate( #"outline", #"on" );
                }
                
                if ( self.all_doors_unlocked )
                {
                    ob_activity_utility::register_aether_blade_target( cyst );
                }
            }
            else
            {
                cyst setscriptablepartstate( #"health", #"ignore_damage" );
                cyst setscriptablepartstate( #"body", #"bursted" );
            }
            
            self.cleanup_cysts[ self.cleanup_cysts.size ] = cyst;
            
            if ( getbuildversion() != "SHIP" )
            {
                cyst thread debug_cyst();
            }
        }
        
        return;
    }
    
    if ( self.players_nearby.size == 0 )
    {
        foreach ( cyst in self.cleanup_cysts )
        {
            if ( isdefined( cyst ) && isdefined( cyst.s_cyst ) && isdefined( cyst.health ) )
            {
                ob_activity_utility::function_f257a06b8f9e4c53( cyst );
                cyst.s_cyst.cyst_health = cyst.health;
                cyst freescriptable();
            }
        }
        
        self.cleanup_cysts = [];
        self.cysts = [];
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x34a1c0eb, Offset: 0x256c
// Size: 0x1a6
function quarantine_zone_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self waittill( #"quarantine_zone_start" );
    
    /#
        thread debug_boss_spawn();
    #/
    
    self.scriptable setscriptablepartstate( #"audio_notifications", #"nest_started" );
    self.started = 1;
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    thread function_cd55c62b739c2f01();
    self waittill( #"nest_cleared" );
    
    foreach ( cyst in self.cysts )
    {
        cyst setscriptablepartstate( #"health", #"ignore_damage" );
        cyst setscriptablepartstate( #"body", #"bursted" );
        cyst.health = 0;
    }
    
    self.scriptable setscriptablepartstate( #"audio_notifications", #"nest_cleared" );
    wait 3;
    function_ebef81106cdde6c7();
    activity_definition_utils::function_a0a94881bc380bbf( 1, self );
    activity_definition_utils::updateprogress( 0, activity_instance, 1 );
    self waittill( #"boss_killed" );
    activity_definition_utils::updateprogress( 1, activity_instance );
    thread ob_activity_utility::function_894ac80e038636c5( "wcaquashsuccess", undefined, undefined, 5 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xe3bf674, Offset: 0x271a
// Size: 0x85
function function_6aa09da8e2df2dd7( damage )
{
    var_ab8007f32d8a3abe = get_current_health();
    var_b44147cf877e9402 = var_ab8007f32d8a3abe + damage;
    
    if ( var_b44147cf877e9402 >= self.var_5efb395e6b88cee8 && var_ab8007f32d8a3abe <= self.var_5efb395e6b88cee8 )
    {
        self notify( #"first_threshold_reached" );
        return;
    }
    
    if ( var_b44147cf877e9402 >= self.var_400228510f338a3a && var_ab8007f32d8a3abe <= self.var_400228510f338a3a )
    {
        self notify( #"second_threshold_reached" );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x2ac765fe, Offset: 0x27a7
// Size: 0x9a
function get_current_health()
{
    var_ab8007f32d8a3abe = 0;
    
    foreach ( cyst in self.cysts )
    {
        var_ab8007f32d8a3abe += cyst.health;
    }
    
    self.var_c2127c21995e9409 = var_ab8007f32d8a3abe;
    return var_ab8007f32d8a3abe;
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xed0187eb, Offset: 0x284a
// Size: 0x154
function function_cd55c62b739c2f01()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !self.all_doors_unlocked )
    {
        self waittill( #"quarantine_zone_unlocked" );
    }
    
    spawn_zombies_encounter( %"hash_6465600f633b25f", undefined, self.difficulty_region, 1 );
    self waittill( #"first_threshold_reached" );
    thread function_d2efe82ab3bc027e( "second_threshold_reached", "wave_1", 22 );
    self.scriptable setscriptablepartstate( #"audio_notifications", #"health_threshold_1" );
    earthquake( 0.35, 1.7, self.s_center.origin, 500 );
    playrumbleonposition( "grenade_rumble", self.s_center.origin );
    self waittill( #"second_threshold_reached" );
    thread function_d2efe82ab3bc027e( "nest_cleared", "wave_2", 30 );
    self.scriptable setscriptablepartstate( #"audio_notifications", #"health_threshold_2" );
    earthquake( 0.47, 1.7, self.s_center.origin, 500 );
    playrumbleonposition( "grenade_rumble", self.s_center.origin );
}

// Namespace ob_activity_quarantine_zone
// Params 3
// Checksum 0x1d02cd3, Offset: 0x29a6
// Size: 0x94
function function_d2efe82ab3bc027e( var_c68d7cba8f866275, var_d956f4bd38541770, wait_time )
{
    if ( isdefined( var_c68d7cba8f866275 ) )
    {
        self endon( var_c68d7cba8f866275 );
    }
    
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( var_d956f4bd38541770 ) )
    {
        spawn_zombies_encounter( %"hash_71939978fadf23b6", var_d956f4bd38541770, self.difficulty_region );
    }
    else
    {
        spawn_zombies_encounter( %"hash_71939978fadf23b6" );
    }
    
    wait wait_time;
    spawn_zombies_encounter( %"hash_6465600f633b25f", undefined, self.difficulty_region, 1 );
}

// Namespace ob_activity_quarantine_zone
// Params 5
// Checksum 0xdffe48ac, Offset: 0x2a42
// Size: 0xde
function spawn_zombies_encounter( bundle, optional_size_tag, var_bbb3c3d3da789bf4, is_flood_fill, cleanup_type = 0 )
{
    var_b7e6d2d89bfacd6 = 500;
    centerpoint = self.s_center.origin;
    self.encounterid = activity_ai_encounters::function_eb8506829193f5eb( bundle, centerpoint, var_b7e6d2d89bfacd6, 1, 1, 1, cleanup_type );
    
    if ( isdefined( self.encounterid ) )
    {
        if ( isdefined( optional_size_tag ) )
        {
            function_1a9d724a960fa19d( self.encounterid, optional_size_tag, 1 );
        }
        
        if ( isdefined( var_bbb3c3d3da789bf4 ) )
        {
            function_1a9d724a960fa19d( self.encounterid, var_bbb3c3d3da789bf4, 1 );
        }
        
        if ( isdefined( is_flood_fill ) )
        {
            if ( is_flood_fill )
            {
                function_bbd192652d1a9e18( self.encounterid, self.active_zombie_cap );
            }
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xe9ea0098, Offset: 0x2b28
// Size: 0xe2
function function_ebef81106cdde6c7()
{
    centerpoint = self.s_center.origin;
    ob_activity_utility::function_894ac80e038636c5( "wcaquashboss" );
    cd_k = ob_activity_utility::get_conversation_cooldown_time( "wcaquashboss_karma" );
    cd_m = ob_activity_utility::get_conversation_cooldown_time( "wcaquashboss_marshall" );
    cd = max( cd_k, cd_m );
    earthquake( 0.6, cd, centerpoint, 800 );
    playrumbleonposition( "grenade_rumble", centerpoint );
    wait cd ?? 3;
    self.boss_encounter_id = activity_ai_encounters::function_eb8506829193f5eb( %"hash_73a09805a927ef39", centerpoint, 800, 1, 1, 1, 0 );
    function_64ac8c4e752f4dca( self.boss_encounter_id, 0 );
    
    if ( isdefined( self.boss_encounter_id ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.boss_encounter_id, &function_6e9cdf5387044342, self );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 4
// Checksum 0x59d5378b, Offset: 0x2c12
// Size: 0x1c8
function function_6e9cdf5387044342( requestid, userdata, agent, data )
{
    activityinstance = userdata;
    
    if ( isalive( agent ) && isdefined( activityinstance ) && activityinstance.state == "Active" )
    {
        agent.activityinstance = activityinstance;
        agent.var_789b7a49ee864fec = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_quarantine_zone_amalgam_marker", 0, 1 );
        objidpoolmanager::update_objective_onentity( agent.var_789b7a49ee864fec, agent );
        agent callback::add( #"on_ai_killed", &function_c0b44f36c7e722f8 );
        agent callback::add( #"emergence_spawn", &function_43e02d05c99430a5 );
        agent callback::add( "on_zombie_ai_damaged", &function_9f2748036cf6a8b7 );
        activityinstance activity_participation::function_d041ee0ec570299d( agent );
        defend_pos = agent.activityinstance.s_center.origin;
        
        if ( function_fe7d2c562a2d1df0( agent.origin, agent.activityinstance ) )
        {
            defend_pos = agent.origin;
        }
        else
        {
            script::demoforcesre( "[Quarantine Zone] boss not spawned in combat area!" + agent.origin );
            
            /#
                debugstar( agent.origin, ( 1, 0, 0 ), 10000, "<dev string:xb4>", 1 );
            #/
        }
        
        agent.activityinstance.boss_defend_pos = defend_pos;
        agent thread function_a0f481767e65be1a( defend_pos );
        agent thread function_1ca87e107d0fbe03();
        return;
    }
    
    assertmsg( "<dev string:xc3>" );
    activityinstance notify( #"boss_killed" );
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x783b0681, Offset: 0x2de2
// Size: 0xf3
function function_43e02d05c99430a5( params )
{
    newboss = params.ai;
    
    if ( isdefined( newboss ) && isdefined( self.var_789b7a49ee864fec ) && isdefined( self.activityinstance ) )
    {
        newboss.var_789b7a49ee864fec = self.var_789b7a49ee864fec;
        newboss.activityinstance = self.activityinstance;
        objidpoolmanager::update_objective_onentity( self.var_789b7a49ee864fec, newboss );
        newboss callback::add( #"on_ai_killed", &function_c0b44f36c7e722f8 );
        newboss callback::add( #"emergence_spawn", &function_43e02d05c99430a5 );
        self.var_789b7a49ee864fec = undefined;
        callback::remove( #"on_ai_killed", &function_c0b44f36c7e722f8 );
        newboss thread function_a0f481767e65be1a( newboss.activityinstance.boss_defend_pos );
        newboss thread function_1ca87e107d0fbe03();
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x3bfa7975, Offset: 0x2edd
// Size: 0x63
function function_c0b44f36c7e722f8( params )
{
    if ( isdefined( self.activityinstance ) && self.activityinstance.state == "Active" )
    {
        self.activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_789b7a49ee864fec );
        self.activityinstance notify( #"boss_killed" );
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xd77581aa, Offset: 0x2f48
// Size: 0x65
function function_9f2748036cf6a8b7( dmg_struct )
{
    if ( dmg_struct.idamage > self.health )
    {
        if ( !isexplosivedamagemod( dmg_struct.smeansofdeath ) && !utility::isimpactdamage( dmg_struct.smeansofdeath ) )
        {
            self.death_fx_wait_time = 2.9 + level.framedurationseconds;
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x43e48306, Offset: 0x2fb5
// Size: 0x169
function function_1ca87e107d0fbe03()
{
    agent = self;
    agent endon( #"death" );
    activityinstance = agent.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    var_2dbfcc579fc9df09 = 2;
    var_2d9cbe579fa37887 = 4;
    
    while ( true )
    {
        wait randomfloatrange( var_2dbfcc579fc9df09, var_2d9cbe579fa37887 );
        
        if ( agent.favoriteenemy && !agent.favoriteenemy is_in_combat_area( activityinstance ) || agent.enemy && !agent.enemy is_in_combat_area( activityinstance ) )
        {
            players = arrayrandomize( level.players );
            
            foreach ( player in players )
            {
                if ( player is_in_combat_area( activityinstance ) && player != agent.favoriteenemy )
                {
                    agent zombie_utils::set_ai_target_priority( player );
                    break;
                }
            }
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x7ae9991d, Offset: 0x3126
// Size: 0x2bd
function function_a0f481767e65be1a( defend_pos )
{
    agent = self;
    agent endon( #"death" );
    activityinstance = agent.activityinstance;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    while ( true )
    {
        wait 10;
        
        if ( !agent is_in_combat_area( activityinstance ) )
        {
            agent.stealth_enabled = 0;
            agent.var_d20abf01030c60a2 = 1;
            agent.ignoreall = 1;
            agent clearenemy();
            agent clearbtgoal( 0 );
            agent clearbtgoal( 1 );
            agent clearbtgoal( 3 );
            agent zombie_utils::function_a8ce00e0448cb6f0( "walk", "oob", 1000 );
            wait randomfloatrange( 1, 2 );
            agent setbtgoalpos( 0, defend_pos );
            agent setbtgoalpos( 1, defend_pos );
            agent setbtgoalradius( 0, 128 );
            agent setbtgoalradius( 1, 128 );
            goalreached = 0;
            agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "oob", 1000 );
            bad_path = 0;
            
            while ( true )
            {
                msg = agent utility::waittill_any_timeout( 1, "goal", "bad_path", "goal_reached", "bt_goal" );
                
                if ( msg != "timeout" )
                {
                    if ( msg == "bad_path" )
                    {
                        script::demoforcesre( "[quarantine zone] boss is in bad path to defend goal. current:" + agent.origin + " goal:" + defend_pos );
                        
                        /#
                            debugstar( agent.origin, ( 1, 0, 0 ), 10000, "<dev string:x10e>", 1 );
                            debugstar( defend_pos, ( 1, 0, 0 ), 10000, "<dev string:x11c>", 1 );
                        #/
                        
                        bad_path = 1;
                    }
                    
                    goalreached = 1;
                }
                
                if ( goalreached || distance( agent.origin, defend_pos ) <= 128 )
                {
                    break;
                }
            }
            
            agent clearbtgoal( 0 );
            agent clearbtgoal( 1 );
            agent clearbtgoal( 3 );
            agent.ignoreall = 0;
            agent.var_d20abf01030c60a2 = 0;
            agent.stealth_enabled = 1;
            agent stealth::scrsetstealthstate( "idle" );
            agent zombie_utils::function_a8ce00e0448cb6f0( undefined, "oob", 1000 );
            
            if ( !bad_path )
            {
                agent setbtgoalstationary( 4 );
                
                while ( true )
                {
                    msg = agent utility::waittill_any_timeout( level.framedurationseconds, "damage" );
                    
                    if ( msg == "damage" || function_8d74d198e34d95d2( activityinstance ) )
                    {
                        agent clearbtgoal( 4 );
                        break;
                    }
                }
            }
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x9f15994b, Offset: 0x33eb
// Size: 0x8e, Type: bool
function function_8d74d198e34d95d2( activityinstance )
{
    foreach ( player in activityinstance.playerparticipants )
    {
        if ( player is_in_combat_area( activityinstance ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0x9489d675, Offset: 0x3482
// Size: 0xc1, Type: bool
function function_fe7d2c562a2d1df0( point, activityinstance )
{
    combat_volumes = getnoentvolumearray( "combat_volume_" + activityinstance.varianttag, #targetname );
    
    if ( combat_volumes.size == 0 )
    {
        return true;
    }
    
    foreach ( volume in combat_volumes )
    {
        if ( ispointinvolume( point, volume, 1 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x83484276, Offset: 0x354c
// Size: 0x1d, Type: bool
function is_in_combat_area( activityinstance )
{
    return function_fe7d2c562a2d1df0( self.origin, activityinstance );
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xda77c21d, Offset: 0x3572
// Size: 0x19
function function_44ec91ea48500936( obj )
{
    if ( isdefined( obj ) )
    {
        obj delete();
    }
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xc22d2e48, Offset: 0x3593
// Size: 0x5a
function function_fec785b14862caa0( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = self.s_center.origin;
    var_983974fc347bb3cb.angles = self.s_center.angles;
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xaf8d900f, Offset: 0x35f5
// Size: 0x5f
function function_a219ef7a66cf1d63( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    rewardamount = ob_activity_definition_utils::function_e55fda458ce2c4cc( self );
    activity_definition_utils::updatereward( rewardamount, self, { #players:player_list } );
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x4d8003a7, Offset: 0x365c
// Size: 0x141
function function_a95d5a34e530ac93( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( isdefined( self ) && self.state != "Ended" )
            {
                current_main_handler = self.var_b91228339d5bfc5c[ player.guid ];
                
                if ( isdefined( current_main_handler ) )
                {
                    switch ( current_main_handler )
                    {
                        case #"hash_eb2f7cb990e8046c":
                            vo = "wcaquashfail";
                            break;
                        case #"hash_a48f1af0624d2e8a":
                            vo = "wcaquastrongfailcradle";
                            break;
                        default:
                            break;
                    }
                    
                    ob_activity_utility::function_894ac80e038636c5( vo, [ player ], [ current_main_handler ] );
                }
            }
            
            player notify( #"left_quarantine_zone" );
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x5a98603b, Offset: 0x37a5
// Size: 0x3a1
function quarantine_zone_activity_ended()
{
    self endon( #"instance_destroyed" );
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    
    if ( isdefined( self.var_c9876a8e7895a3a ) )
    {
        self.var_c9876a8e7895a3a notify( #"child_activity_begin" );
    }
    
    foreach ( cyst in self.cysts )
    {
        if ( cyst.health > 0 )
        {
            cyst setscriptablepartstate( #"health", #"ignore_damage" );
            cyst setscriptablepartstate( #"body", #"bursted" );
            cyst.health = 0;
        }
    }
    
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( self.safe && activity_succeeded )
    {
        self.safe setscriptablepartstate( #"quarantine_zone_safe", #"open_usable" );
        
        foreach ( player in self.playerparticipants )
        {
            player calloutmarkerping::function_920a63c06abdefe8( self.safe.index );
        }
        
        if ( self.safe.vine )
        {
            self.safe.vine_trigger = spawn( "noent_volume_trigger_radius", self.safe.vine.origin, 0, 240, 60 );
            self.safe.vine_trigger thread function_91c4281b11212b5c( self.safe );
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    if ( isdefined( self.var_a2bed8e497f66fe5 ) )
    {
        foreach ( Gas in self.var_a2bed8e497f66fe5 )
        {
            Gas setscriptablepartstate( #"state", #"hidden" );
        }
    }
    
    if ( isdefined( self.var_1b94794135ef7044 ) )
    {
        foreach ( vfx in self.var_1b94794135ef7044 )
        {
            function_44ec91ea48500936( vfx );
        }
    }
    
    if ( isdefined( self.var_592890cbcd7cfad1 ) && self.var_592890cbcd7cfad1.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.var_592890cbcd7cfad1 );
    }
    
    ob_activity_utility::ob_disable_cover_nodes();
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0x73f97ad1, Offset: 0x3b4e
// Size: 0x298
function function_693fb70f2fe6b5d2()
{
    self endon( #"instance_destroyed" );
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    
    if ( isdefined( self.var_82209d06b3fad29d ) )
    {
        foreach ( prop in self.var_82209d06b3fad29d )
        {
            prop setscriptablepartstate( #"state", #"hidden" );
        }
    }
    
    if ( isdefined( self.safe ) )
    {
        self.safe freescriptable();
        
        if ( self.safe.vine )
        {
            self.safe.vine freescriptable();
        }
        
        if ( self.safe.vine_trigger )
        {
            self.safe.vine_trigger delete();
        }
    }
    
    if ( isdefined( self.var_1b94794135ef7044 ) )
    {
        foreach ( vfx in self.var_1b94794135ef7044 )
        {
            function_44ec91ea48500936( vfx );
        }
    }
    
    if ( isdefined( self.cleanup_cysts ) )
    {
        foreach ( cyst in self.cleanup_cysts )
        {
            cyst freescriptable();
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    if ( self.terminal )
    {
        self.terminal freescriptable();
    }
    
    if ( isdefined( self.var_592890cbcd7cfad1 ) && self.var_592890cbcd7cfad1.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.var_592890cbcd7cfad1 );
    }
    
    ob_activity_utility::ob_disable_cover_nodes();
    _unlock_all_doors();
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0x6e32e7a1, Offset: 0x3dee
// Size: 0x33
function function_ec00319d5c9ab121( hack_effect, attacker )
{
    quarantine_zone_activity_instance = self.quarantine_zone_activity_instance;
    quarantine_zone_activity_instance _unlock_all_doors();
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0xb6ce586b, Offset: 0x3e29
// Size: 0x8f
function function_b0b67ab23297e563( params )
{
    player = params.hacker;
    black_hat_data = params.black_hat_data;
    assert( isdefined( player ) && isdefined( black_hat_data ) );
    player endon( #"death_or_disconnect" );
    
    while ( black_hat_data.state == "hacking" )
    {
        wait 0.2;
    }
    
    if ( isdefined( black_hat_data.var_aa778d21f7d75252 ) )
    {
        black_hat_data.var_aa778d21f7d75252 = 0;
    }
}

// Namespace ob_activity_quarantine_zone
// Params 6, eflags: 0x4
// Checksum 0x3fdc3da5, Offset: 0x3ec0
// Size: 0x43
function private door_lock_scriptable_used( instance, part, state, player, bautouse, usestring )
{
    instance thread function_faf578848c15052f( player );
}

// Namespace ob_activity_quarantine_zone
// Params 1, eflags: 0x4
// Checksum 0xbecfd5a, Offset: 0x3f0b
// Size: 0x118
function private function_faf578848c15052f( player )
{
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    quarantine_zone_activity_instance = self.quarantine_zone_activity_instance;
    
    if ( !isdefined( quarantine_zone_activity_instance.hacking_players ) )
    {
        quarantine_zone_activity_instance.hacking_players = [];
    }
    
    quarantine_zone_activity_instance.hacking_players[ quarantine_zone_activity_instance.hacking_players.size ] = player;
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    quarantine_zone_activity_instance.hacking_players = arrayremove( quarantine_zone_activity_instance.hacking_players, player );
    
    if ( var_fab006cdb4f6e516 )
    {
        if ( isdefined( self.door ) )
        {
            namespace_2745d12b842cc671::unlockscriptabledoor( self.door );
            self.door function_e203bba36cfb19d0();
        }
        else if ( isdefined( self.button ) )
        {
            namespace_2745d12b842cc671::function_bfec62fe69e3f84b( self.button );
        }
        
        quarantine_zone_activity_instance function_338e9eba72105ea9();
        quarantine_zone_activity_instance _unlock_all_doors();
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0, eflags: 0x4
// Checksum 0xbb11fe0d, Offset: 0x402b
// Size: 0x4ec
function private _lock_all_doors()
{
    self.all_doors_unlocked = 0;
    self.var_373c0aef06315396 = [];
    self.var_2b895fcbec1b5882 = [];
    self.door_interact_nodes = [];
    zone = spatial_zone_container::function_f7fc3e6c249a8256( self, "OB_Spacer_Spatial_Zone" );
    searchradius = min( 1500, spatial_zone_container::function_231d9e91d8ef7b5f( zone[ 0 ] ) );
    var_d6fe3e5fb2099dd5 = getentitylessscriptablearray( undefined, undefined, self.s_center.origin, searchradius, "door" );
    mapbuttons = getentitylessscriptablearray( undefined, undefined, self.s_center.origin, searchradius, "arcwire_transmitter" );
    
    foreach ( button in mapbuttons )
    {
        button setscriptablepartstate( #"health_listener", #"disabled_no_notify" );
    }
    
    /#
        if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
        {
            thread debug::drawsphere( self.s_center.origin, searchradius, 900, ( 0, 1, 1 ) );
            
            foreach ( var_3bed73a94539a899 in var_d6fe3e5fb2099dd5 )
            {
                thread debug::drawsphere( var_3bed73a94539a899.origin, 1, 900, ( 1, 1, 1 ) );
            }
        }
    #/
    
    foreach ( var_25cb8d020dc582ca in self.var_d4c224d9c5d1d32f )
    {
        /#
            if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
            {
                thread debug::drawsphere( var_25cb8d020dc582ca.origin, 5, 900, ( 0.25, 0, 0.5 ) );
            }
        #/
        
        button_scriptables = namespace_2745d12b842cc671::function_3387024fc85970f7( var_25cb8d020dc582ca.origin, undefined, undefined, mapbuttons );
        
        foreach ( button in button_scriptables )
        {
            button setscriptablepartstate( #"arcwire_transmitter", #"disabled" );
            
            if ( arraycontains( self.var_2b895fcbec1b5882, button ) )
            {
                continue;
            }
            
            self.var_2b895fcbec1b5882[ self.var_2b895fcbec1b5882.size ] = button;
            thread function_148788d1442a0fcf( button );
        }
    }
    
    foreach ( var_a40b5ebaaffd1dea in self.var_b65091063dffc8f1 )
    {
        /#
            if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) == 1 )
            {
                thread debug::drawsphere( var_a40b5ebaaffd1dea.origin, 5, 900, ( 0.25, 0, 0.5 ) );
            }
        #/
        
        doorscriptables = [];
        doorscriptables = namespace_2745d12b842cc671::function_f4d67875159a0119( var_a40b5ebaaffd1dea, doorscriptables, "human_stronghold", istrue( var_a40b5ebaaffd1dea.var_34b4ebb3144ed460 ), 1, var_d6fe3e5fb2099dd5, 150 );
        
        foreach ( door in doorscriptables )
        {
            if ( arraycontains( self.var_373c0aef06315396, door ) )
            {
                continue;
            }
            
            thread function_2e3b0a5bee6342a4( door, var_a40b5ebaaffd1dea );
            self.var_373c0aef06315396[ self.var_373c0aef06315396.size ] = door;
        }
    }
    
    var_d6fe3e5fb2099dd5 = undefined;
    mapbuttons = undefined;
}

// Namespace ob_activity_quarantine_zone
// Params 2, eflags: 0x4
// Checksum 0x494b830c, Offset: 0x451f
// Size: 0x1f8
function private function_2e3b0a5bee6342a4( door, var_a40b5ebaaffd1dea )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    throttle::throttle_wait_in_queue( level.var_3b56f00a3f54ab26, var_a40b5ebaaffd1dea );
    n_touching_radius_check = 200;
    a_e_ent_array = vehicle_getarrayinradius( door.origin, n_touching_radius_check );
    
    foreach ( e_ent in a_e_ent_array )
    {
        e_ent.dontspawnhusk = 1;
        thread vehicle::death( e_ent );
    }
    
    while ( !door scriptabledoorisclosed() )
    {
        door scriptabledoorclose();
        waitframe();
    }
    
    door scriptabledoorlock();
    door function_7653c765b6c7b815();
    
    if ( !var_a40b5ebaaffd1dea.var_34b4ebb3144ed460 || door.doubledoor && !issubstr( door.classname, "saloon" ) )
    {
        return;
    }
    
    door.quarantine_zone_activity_instance = self;
    door.var_de79f5d2971427a8 = &function_32952c8d86664b71;
    offset_outter = rotatevector( ( 4, 0, 0 ), var_a40b5ebaaffd1dea.angles );
    var_f360911dcd28bf63 = door.origin + rotatevector( ( 45, 0, 35 ), door.angles ) + offset_outter;
    node = door function_3c4d2faf4c43b79( var_f360911dcd28bf63, var_a40b5ebaaffd1dea.angles, "ob_quarantine_zone_door" );
    node.quarantine_zone_activity_instance = self;
    node.door = door;
}

// Namespace ob_activity_quarantine_zone
// Params 1, eflags: 0x4
// Checksum 0x6495d182, Offset: 0x471f
// Size: 0x166
function private function_148788d1442a0fcf( button )
{
    button.quarantine_zone_activity_instance = self;
    button.var_cebadb03a69247f8 = &function_32952c8d86664b71;
    button_pos = button.origin + rotatevector( ( 0, -10, 5 ), button.angles );
    node = button function_3c4d2faf4c43b79( button_pos, button.angles - ( 0, 90, 0 ), "ob_quarantine_zone_rollup_door" );
    node.button = button;
    node.quarantine_zone_activity_instance = self;
    rollup_door_array = getentitylessscriptablearray( button.target, #targetname, button.origin, 1500 );
    
    foreach ( door in rollup_door_array )
    {
        if ( door getscriptablepartstate( #"arcwire_receiver" ) == #"set" )
        {
            door function_f73543c997ed7c9();
        }
    }
}

// Namespace ob_activity_quarantine_zone
// Params 0, eflags: 0x4
// Checksum 0x5bf72ddb, Offset: 0x488d
// Size: 0xdc
function private function_f73543c997ed7c9()
{
    n_touching_radius_check = 200;
    a_e_ent_array = vehicle_getarrayinradius( self.t_crush_zone.origin, n_touching_radius_check );
    
    foreach ( e_ent in a_e_ent_array )
    {
        if ( e_ent istouching( self.t_crush_zone ) )
        {
            e_ent.dontspawnhusk = 1;
            thread vehicle::death( e_ent );
        }
    }
    
    waitframe();
    self setscriptablepartstate( #"arcwire_receiver", #"reset" );
}

// Namespace ob_activity_quarantine_zone
// Params 3, eflags: 0x4
// Checksum 0xc602548a, Offset: 0x4971
// Size: 0x13b
function private function_3c4d2faf4c43b79( position, angles, black_hat_ref )
{
    attached_scriptable = spawnscriptable( %"sat_ob_quarantine_zone_door_lock", position, angles );
    attached_scriptable interaction::set_interact_hint_callback( &function_2422418112b60331 );
    attached_scriptable.quarantine_zone_activity_instance = self.quarantine_zone_activity_instance;
    self.quarantine_zone_activity_instance.door_interact_nodes[ self.quarantine_zone_activity_instance.door_interact_nodes.size ] = attached_scriptable;
    
    /#
        if ( getdvarint( @"hash_9c3d7b7ac76a359c", 0 ) )
        {
            var_e0d3072fe21bed24 = attached_scriptable.origin + anglestoforward( attached_scriptable.angles ) * 20;
            thread debug::drawsphere( attached_scriptable.origin, 1, 1000, ( 0, 1, 0 ) );
            thread debug::drawline( attached_scriptable.origin, var_e0d3072fe21bed24, 1000, ( 1, 0, 0 ) );
        }
    #/
    
    if ( getdvarint( @"hash_33769dd721bb42ea", 1 ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", black_hat_ref );
    }
    
    return attached_scriptable;
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0xdec53628, Offset: 0x4ab5
// Size: 0xa0
function function_2422418112b60331( usable, player )
{
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/interaction_hacking_in_progress", #type:"HINT_NOBUTTON" };
        }
    }
    
    return { #string:&"sat_ob_activities/activity_quarantine_zone_unlock_door", #type:"HINT_NOICON" };
}

// Namespace ob_activity_quarantine_zone
// Params 2
// Checksum 0xb887b0b1, Offset: 0x4b5e
// Size: 0x35
function function_32952c8d86664b71( instance, player )
{
    quarantine_zone_activity_instance = instance.quarantine_zone_activity_instance;
    quarantine_zone_activity_instance _unlock_all_doors();
}

// Namespace ob_activity_quarantine_zone
// Params 0, eflags: 0x4
// Checksum 0x7f664d09, Offset: 0x4b9b
// Size: 0x316
function private _unlock_all_doors()
{
    if ( self.all_doors_unlocked )
    {
        return;
    }
    
    foreach ( button in self.var_2b895fcbec1b5882 )
    {
        namespace_2745d12b842cc671::function_bfec62fe69e3f84b( button );
        button utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
    }
    
    foreach ( door in self.var_373c0aef06315396 )
    {
        door scriptabledoorunlock();
        door function_e203bba36cfb19d0();
        door utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
    }
    
    foreach ( node in self.door_interact_nodes )
    {
        node freescriptable();
    }
    
    self.var_373c0aef06315396 = [];
    self.door_interact_nodes = [];
    
    if ( self.hacking_players )
    {
        self.hacking_players = function_5713d46873b29625( self.hacking_players );
        
        foreach ( player in self.hacking_players )
        {
            player notify( #"cancel" );
        }
        
        self.hacking_players = undefined;
    }
    
    self.all_doors_unlocked = 1;
    
    foreach ( cyst in self.cysts )
    {
        ob_activity_utility::register_aether_blade_target( cyst );
    }
    
    self notify( #"quarantine_zone_unlocked" );
    spawn_zombies_encounter( %"hash_749d4967eeb07fd5", undefined, self.difficulty_region, 1, 2 );
}

// Namespace ob_activity_quarantine_zone
// Params 1
// Checksum 0x6cc8e00b, Offset: 0x4eb9
// Size: 0x82
function function_91c4281b11212b5c( safe )
{
    self endon( #"death" );
    vine = safe.vine;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( vine )
        {
            vine setscriptablepartstate( #"state", #"dead" );
            break;
        }
    }
    
    self delete();
}

// Namespace ob_activity_quarantine_zone
// Params 0
// Checksum 0xe256f4b6, Offset: 0x4f43
// Size: 0xd7
function debug_cyst()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_3114c84b5ad2054a", 0 ) )
        {
            if ( self getscriptablepartstate( "body" ) != "destroyed" )
            {
                /#
                    sphere( self.origin, 32, ( 1, 1, 0 ), 0, int( 1 / ( level.framedurationseconds ?? 0.48 ) ) );
                #/
                
                self setscriptablepartstate( #"debug", #"on" );
            }
            else
            {
                self setscriptablepartstate( #"debug", #"off" );
            }
        }
        else
        {
            self setscriptablepartstate( #"debug", #"off" );
        }
        
        wait 1;
    }
}

/#

    // Namespace ob_activity_quarantine_zone
    // Params 0
    // Checksum 0xd11c4130, Offset: 0x5022
    // Size: 0x5b, Type: dev
    function debug_boss_spawn()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_463bed063ec18848", 0 ) )
            {
                setdvar( @"hash_463bed063ec18848", 0 );
                function_ebef81106cdde6c7();
            }
            
            wait 1;
        }
    }

#/
