// scripts\mp\ob\activities\ob_activity_surprise_shipment.gsc  (hash_3e1f93db5d3664c6.gscc) (size: 11211 Bytes / 0x2bcb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66e1b3e5 (1726067685)
// size ...... 11211 (0x2bcb)
// includes .. 15  (offset: 0x298b)
// strings ... 31  (offset: 0x2a03)
// dev strs .. 2   (offset: 0x2bb3)
// exports ... 24  (offset: 0x1bb3)
// cseg ...... 0x2f5 + 0x18be (0x1bb3)
// imports ... 87  (offset: 0x1f73)
// animtree1 . 0   (offset: 0x2bcb)
// animtree2 . 0   (offset: 0x2bcb)
#using script_16555c1140262e45;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_surprise_shipment;

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x5
// Checksum 0x76fa4cc1, Offset: 0x313
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_surprise_shipment", #"activity_common", &function_ebe8bbe912ed2049, undefined );
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0x6be4e192, Offset: 0x33c
// Size: 0x13
function private function_ebe8bbe912ed2049()
{
    activity_common::registeractivitytype( "REV_OB_SURPRISE_SHIPMENT", &activity_type_init );
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0x6e269630, Offset: 0x357
// Size: 0xb8
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_SURPRISE_SHIPMENT", 0, &setup_surprise_shipment );
    activity_common::function_944074f3079c1d4e( "REV_OB_SURPRISE_SHIPMENT", 1, &spawn_enemies );
    activity_common::function_944074f3079c1d4e( "REV_OB_SURPRISE_SHIPMENT", 2, &function_41b960ce7807481d );
    activity_common::function_944074f3079c1d4e( "REV_OB_SURPRISE_SHIPMENT", 3, &destroy_activity );
    activity_common::function_944074f3079c1d4e( "REV_OB_SURPRISE_SHIPMENT", 4, &get_surprise_shipment_center );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_SURPRISE_SHIPMENT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_SURPRISE_SHIPMENT" );
    
    if ( !level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] )
    {
        level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] = loadfxasset( "vfx_sat_ob_gameplay_chest_spawn" );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 1
// Checksum 0xbd7f0b64, Offset: 0x417
// Size: 0x8e
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    if ( !isdefined( self.var_b34af6b9123b981f ) )
    {
        self.var_b34af6b9123b981f = 1;
    }
    
    if ( self.enemies.size )
    {
        ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, self.var_b34af6b9123b981f - self.enemies.size, self.var_b34af6b9123b981f );
    }
    
    ob_activity_vo_utility::function_639b0047db8aec67( self, "mystery_box_brief" );
}

// Namespace ob_activity_surprise_shipment
// Params 1
// Checksum 0xb122b507, Offset: 0x4ad
// Size: 0x103
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( !activity_instance_common::function_6bb0be4a3940d6e3( self ) )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( self, "mystery_box_fail", player_list );
    }
    
    if ( self.playerparticipants.size == 0 && self.opened && self.enemies.size > 0 )
    {
        foreach ( enemy in self.enemies )
        {
            enemy.nocorpse = 1;
            enemy.var_a13bed1ac47e1b2c = 1;
            enemy kill();
        }
        
        activity_instance_common::endactivity( self, 0 );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0xcbc74f92, Offset: 0x5b8
// Size: 0x5d
function private get_surprise_shipment_center()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    center_point = undefined;
    
    if ( activity_instance.struct_center )
    {
        center_point = activity_instance.struct_center;
    }
    
    return center_point;
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0xf4265027, Offset: 0x61e
// Size: 0x1d9
function setup_surprise_shipment()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.handler_list = [ "karm", "mars" ];
    ref_struct = utility::getstruct( self.varianttag, "targetname" );
    
    if ( !isdefined( activity_instance.var_91c91f4a631c481d ) )
    {
        activity_instance.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    }
    
    container_scriptables = getentitylessscriptablearray( self.varianttag + "_container", #targetname );
    
    if ( container_scriptables.size == 1 )
    {
        activity_instance.container_scriptable = container_scriptables[ 0 ];
        activity_instance.container_scriptable.was_spawned = 0;
        self.difficulty_region = region_difficulty_manager::get_region_difficulty( activity_instance.container_scriptable.origin );
    }
    else
    {
        activity_instance.container_scriptable = spawnscriptable( "sat_ob_surprise_shipping_container", ref_struct.origin, ref_struct.angles );
        activity_instance.container_scriptable.was_spawned = 1;
        self.difficulty_region = region_difficulty_manager::get_region_difficulty( ref_struct.origin );
    }
    
    if ( activity_instance.container_scriptable )
    {
        activity_instance.struct_center = activity_instance.container_scriptable.origin;
    }
    else
    {
        activity_instance.struct_center = ref_struct.origin;
    }
    
    activity_instance.container_scriptable setscriptablepartstate( "state", "visible" );
    activity_instance thread player_proximity_watcher();
    activity_instance.var_e05641f64c5fd5b4 = 0;
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0x4577be54, Offset: 0x7ff
// Size: 0x265
function private setup_drones()
{
    x_offsets = [ 72, 72, -72, -72, 96, 96, -96, -96 ];
    y_offsets = [ 12, -12, 12, -12, 12, -12, 12, -12 ];
    z_offset = 48;
    ob_flying_drone::setup_helper_drones();
    var_a321aefa8952cb14 = function_aa6ab63470841817();
    target = spawnstruct();
    forward = anglestoright( self.container_scriptable.angles );
    right = anglestoforward( self.container_scriptable.angles );
    up = anglestoup( self.container_scriptable.angles );
    
    for ( i = 0; i < var_a321aefa8952cb14 ; i++ )
    {
        spawn_location_array = [];
        index = x_offsets.size - 1 - i;
        target = {};
        targetloc = self.container_scriptable.origin + forward * x_offsets[ index ] + right * y_offsets[ index ] + up * z_offset;
        spawn_location_array[ spawn_location_array.size ] = targetloc;
        sign = x_offsets[ i ] > 0 ? 1 : -1;
        finish_pos = targetloc + forward * 300 * sign;
        spawn_location_array[ spawn_location_array.size ] = finish_pos;
        spawnoptions = {};
        spawnoptions.activationdelay = 0.1;
        spawnoptions.var_bd2b4756836f0b9a = randomfloatrange( 0.8, 1.3 );
        spawnoptions.hovertime = randomfloatrange( 1.8, 2.5 );
        target.origin = spawnoptions.finish_pos;
        drone = ob_flying_drone::spawn_helper_drone( "explosive", target, spawn_location_array, undefined, spawnoptions );
        drone ob_flying_drone::function_c2373db857efa03( self.playerparticipants );
        self.enemies[ self.enemies.size ] = drone;
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0x981de026, Offset: 0xa6c
// Size: 0x5d
function private function_aa6ab63470841817()
{
    switch ( self.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            return 2;
        case #"hash_af83e47edfa8900a":
            return 2;
        case #"hash_5343b465e56ec9a4":
            return 3;
        case #"hash_651f76c0ad6741ec":
            return 4;
        default:
            return 0;
    }
}

// Namespace ob_activity_surprise_shipment
// Params 1, eflags: 0x4
// Checksum 0x8d5100a5, Offset: 0xad1
// Size: 0xaf
function private function_438f8326034ceac1( benable )
{
    if ( self.enemies )
    {
        foreach ( enemy in self.enemies )
        {
            if ( enemy.directorrequestid == self.request_id )
            {
                enemy.kfe_ignore = !benable;
            }
        }
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0x9b184bb2, Offset: 0xb88
// Size: 0x6d
function private function_6ce33da9a50aae35()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self waittill( #"ss_ai_spawned" );
    self.container_scriptable setscriptablepartstate( #"state", #"activate" );
    self notify( #"activated" );
    wait 1.8;
    self.fully_opened = 1;
    function_438f8326034ceac1( 1 );
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0x833de957, Offset: 0xbfd
// Size: 0x17d
function spawn_enemies()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread function_6ce33da9a50aae35();
    var_9573911a6f37ae5d = utility::array_random( activity_instance.var_91c91f4a631c481d.containerencounters );
    encounter_name = "ai_encounter:" + var_9573911a6f37ae5d.encounter;
    self.request_id = activity_instance activity_ai_encounters::function_eb8506829193f5eb( encounter_name, self.container_scriptable.origin, 0, 1, 1, 1, 2 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( self.request_id, &finished_spawning, activity_instance );
    self.enemies = [];
    thread function_79a19f33d48080cb( self.request_id );
    
    if ( utility::percent_chance( 0 ) )
    {
        setup_drones();
    }
    
    if ( self.container_scriptable.abilitycase )
    {
        self.container_scriptable.abilitycase freescriptable();
        self.container_scriptable.abilitycase = undefined;
    }
    
    thread encounter_watcher();
    chest_scriptables = getentitylessscriptablearray( self.varianttag + "_lootcache", #targetname );
    
    if ( chest_scriptables.size == 1 )
    {
        self.chest = chest_scriptables[ 0 ];
        self.chest setscriptablepartstate( "body", "hidden" );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 1
// Checksum 0xaebc91b, Offset: 0xd82
// Size: 0x56
function function_41b960ce7807481d( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_succeeded || activity_instance_common::function_6bb0be4a3940d6e3( activity_instance ) )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "mystery_box_success" );
        return;
    }
    
    ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "mystery_box_fail" );
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0xdcb6703a, Offset: 0xde0
// Size: 0x42
function destroy_activity()
{
    if ( self.container_scriptable && self.container_scriptable getscriptablepartstate( "state" ) == "visible" )
    {
        self.container_scriptable setscriptablepartstate( "state", "activate" );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0x34a7d3ee, Offset: 0xe2a
// Size: 0x294
function encounter_watcher()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self waittill( #"ss_ai_spawned" );
    
    while ( true )
    {
        lastalive = self.enemies.size;
        self.enemies = utility::array_removedead_or_dying( self.enemies );
        
        if ( lastalive > self.enemies.size )
        {
            activity_definition_utils::updateprogress( self.var_b34af6b9123b981f - self.enemies.size, self, self.var_b34af6b9123b981f );
        }
        
        if ( self.enemies.size == 0 && self.playerparticipants.size > 0 )
        {
            if ( self.var_e05641f64c5fd5b4 )
            {
                wait 3.5;
            }
            else
            {
                waitframe();
            }
            
            spawn_pos = self.container_scriptable.origin + ( 0, 0, 15 );
            spawn_options = common_item::function_bc5ff2958b71a708( spawn_pos, self.container_scriptable.angles );
            spawn_options.var_f35b5b18b029c493 = 0;
            
            if ( !isdefined( self.difficulty_region ) )
            {
                self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.container_scriptable.origin );
            }
            
            var_a376fd5283f69590 = get_difficulty_index();
            lootlist = "itemspawnlist:ob_activity_itemspawnlist_surprise_shipment_r" + var_a376fd5283f69590;
            item_name = function_c11af7a197679429( lootlist, 1 );
            playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), spawn_pos + ( 0, 0, 24 ) );
            common_item::function_61c2c0251e742ffd( item_name[ 0 ], undefined, spawn_options );
            ability_case_struct = utility::getstruct( "ability_case_" + self.varianttag, "targetname" );
            
            if ( ability_case_struct.origin )
            {
                self.container_scriptable.abilitycase = utility::callsharedfunc( #"ability_case", #"spawn", ability_case_struct.origin, undefined, undefined, #"tactical", ability_case_struct.angles );
                
                if ( self.container_scriptable.abilitycase )
                {
                    self.container_scriptable.abilitycase.dynamicoptions = 1;
                }
            }
            
            activity_instance_common::endactivity( self, 1 );
            return;
        }
        
        utility::array_any_wait( self.enemies, "entitydeleted" );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 1
// Checksum 0x5b441f49, Offset: 0x10c6
// Size: 0x39
function function_79a19f33d48080cb( request_id )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level waittill( "ai_encounter_despawning_" + request_id );
    activity_instance_common::endactivity( self, 0 );
}

/#

    // Namespace ob_activity_surprise_shipment
    // Params 0, eflags: 0xc
    // Checksum 0x5a770077, Offset: 0x1107
    // Size: 0xcf, Type: dev
    function private draw_enemy()
    {
        self notify( #"hash_2eb29d3d25b7413b" );
        self endon( #"hash_2eb29d3d25b7413b" );
        self endon( #"death" );
        level endon( #"game_ended" );
        var_ce3878a674e5dbf = 5;
        endtime = gettime() + var_ce3878a674e5dbf * 1000;
        var_22402606c961b292 = int( var_ce3878a674e5dbf / level.framedurationseconds );
        
        while ( true )
        {
            waitframe();
            
            if ( gettime() > endtime )
            {
                break;
            }
            
            sphere( self.origin, 8, ( 0, 1, 1 ), 1, var_22402606c961b292 );
        }
        
        while ( true )
        {
            waitframe();
            sphere( self.origin, 8, ( 0, 0, 0 ) );
        }
    }

#/

// Namespace ob_activity_surprise_shipment
// Params 11, eflags: 0x4
// Checksum 0x87dfeaa5, Offset: 0x11de
// Size: 0x1c3
function private function_ef27370bdfa84416( enemy, safe_distance = 10, b_reset_state = 0, container, var_23471ca7e89c4aa9, container_right, container_up, forward_offset, right_offset, up_offset, angles_offset )
{
    targetloc = container.origin + var_23471ca7e89c4aa9 * forward_offset + container_right * right_offset + container_up * up_offset;
    targetangles = container.angles + angles_offset;
    
    /#
        if ( getdvarint( @"hash_9b34aded3a0abf21", 0 ) == 1 )
        {
            duration = 7200;
            sphere( container.origin, 13, ( 0, 1, 0 ), 1, duration );
            print3d( container.origin, "<dev string:x24>" + container.origin, ( 0, 1, 0 ), 1, 0.3, duration );
            sphere( targetloc, 10, ( 1, 0, 0 ), 1, duration );
            print3d( targetloc, "<dev string:x2f>" + targetloc, ( 1, 0, 0 ), 1, 0.3, duration );
            line( container.origin, targetloc, ( 1, 1, 0 ), 1, 1, duration );
            enemy thread draw_enemy();
        }
    #/
    
    enemy forceteleport( targetloc, targetangles, safe_distance, b_reset_state );
    enemy function_fa32376aaa88a7a2( container.origin, 3937.01 );
}

// Namespace ob_activity_surprise_shipment
// Params 2
// Checksum 0x3164d754, Offset: 0x13a9
// Size: 0x3e9
function finished_spawning( requestid, activity_instance )
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    activity_instance.enemies = var_41f9287c4987add7.ai;
    forward = anglestoright( activity_instance.container_scriptable.angles );
    right = anglestoforward( activity_instance.container_scriptable.angles );
    up = anglestoup( activity_instance.container_scriptable.angles );
    
    if ( activity_instance.enemies.size == 1 )
    {
        enemy = activity_instance.enemies[ 0 ];
        var_c15bc04e8424223e = enemy.turret && enemy.turret.dawg == enemy ? 8 : 0;
        z_offsets = 13 + var_c15bc04e8424223e;
        function_ef27370bdfa84416( enemy, 10, 1, activity_instance.container_scriptable, forward, right, up, 0, 0, z_offsets, ( 0, -90, 0 ) );
    }
    else
    {
        x_offsets = [ 72, 72, -72, -72, 96, 96, -96, -96 ];
        y_offsets = [ 12, -12, 12, -12, 12, -12, 12, -12 ];
        rotations = [ -90, -90, 90, 90, -90, -90, 90, 90 ];
        
        for ( i = 0; i < activity_instance.enemies.size ; i++ )
        {
            enemy = activity_instance.enemies[ i ];
            var_c15bc04e8424223e = enemy.turret && enemy.turret.dawg == enemy ? 8 : 0;
            z_offsets = 13 + var_c15bc04e8424223e;
            function_ef27370bdfa84416( enemy, 10, 0, activity_instance.container_scriptable, forward, right, up, x_offsets[ i ], y_offsets[ i ], z_offsets, ( 0, rotations[ i ], 0 ) );
        }
    }
    
    if ( !activity_instance.fully_opened )
    {
        activity_instance function_438f8326034ceac1( 0 );
    }
    
    activity_instance.var_b34af6b9123b981f = activity_instance.enemies.size;
    activity_instance ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, activity_instance.enemies.size );
    activity_instance notify( #"ss_ai_spawned" );
    
    if ( enemy )
    {
        if ( enemy.turret && enemy.turret.dawg == enemy )
        {
            activity_instance.var_e05641f64c5fd5b4 = 1;
            enemy.turret dawg_turret::function_609516267ed6c6b3();
            enemy dawg_mp::function_5fb9cbb29986580b();
            waitframe();
            activity_instance.var_dbf5fc92cc0cb705 = activity_instance.container_scriptable;
            enemy.owner = activity_instance.container_scriptable;
            enemy.var_24954f14e27b448d = 1;
            ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "mystery_box_dawgs" );
            return;
        }
        
        if ( enemy.subclass == "juggerbot" )
        {
            wait 2;
            ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "mystery_box_juggerbot" );
            return;
        }
        
        wait 2;
        ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "mystery_box_robots" );
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0
// Checksum 0x9348519c, Offset: 0x179a
// Size: 0x2fe
function player_proximity_watcher()
{
    level endon( #"game_ended" );
    self endon( #"instance_destroyed" );
    players_array = getplayersinradius( self.container_scriptable.origin, 1968.5 );
    
    while ( true )
    {
        wait 0.2;
        players_array = getplayersinradius( self.container_scriptable.origin, 1968.5 );
        
        if ( players_array.size > 0 )
        {
            participants = arrayintersection( players_array, self.playerparticipants );
            
            foreach ( player in players_array )
            {
                if ( !arraycontains( participants, player ) )
                {
                    activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedProximity" );
                }
            }
        }
        
        if ( self.playerparticipants.size > 0 )
        {
            players_array = getplayersinradius( self.container_scriptable.origin, 1181.1 );
            
            if ( !self.opened && players_array.size > 0 )
            {
                thread _delayed_open();
                self.opened = 1;
            }
            
            for ( remainingplayers = self.playerparticipants; remainingplayers.size > 0 ; remainingplayers = arrayremove( remainingplayers, playersquad ) )
            {
                squadabandoned = 1;
                player = utility::array_get_first_item( remainingplayers );
                playersquad = activity_player_common::function_44ef43ff1f6d21d4( player );
                
                foreach ( squadmember in playersquad )
                {
                    if ( distance2dsquared( squadmember.origin, self.container_scriptable.origin ) < 1.55e+07 )
                    {
                        squadabandoned = 0;
                        break;
                    }
                    
                    foreach ( enemy in self.enemies )
                    {
                        if ( isalive( enemy ) && distance2dsquared( squadmember.origin, enemy.origin ) < 1.55e+07 )
                        {
                            squadabandoned = 0;
                            break;
                        }
                    }
                }
                
                if ( squadabandoned )
                {
                    activity_participation::function_1b2fcd30f5842df5( self, player, 2 );
                }
            }
        }
    }
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0xe41bb084, Offset: 0x1aa0
// Size: 0x4c
function private _delayed_open()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.container_scriptable setscriptablepartstate( "audio", "playsound" );
    wait 1.5;
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_surprise_shipment
// Params 1
// Checksum 0xd3c1866c, Offset: 0x1af4
// Size: 0x5a
function function_470b4f0cecef4cf4( rewardstruct )
{
    rewardstruct.origin = self.container_scriptable.origin + ( 0, 0, 13 );
    rewardstruct.angles = self.container_scriptable.angles;
    return rewardstruct;
}

// Namespace ob_activity_surprise_shipment
// Params 0, eflags: 0x4
// Checksum 0x55a2da06, Offset: 0x1b57
// Size: 0x5c
function private get_difficulty_index()
{
    switch ( self.difficulty_region )
    {
        case #"hash_7bb2cd766703d463":
            return 0;
        case #"hash_af83e47edfa8900a":
            return 1;
        case #"hash_5343b465e56ec9a4":
            return 2;
        case #"hash_651f76c0ad6741ec":
            return 3;
        default:
            return 0;
    }
}

