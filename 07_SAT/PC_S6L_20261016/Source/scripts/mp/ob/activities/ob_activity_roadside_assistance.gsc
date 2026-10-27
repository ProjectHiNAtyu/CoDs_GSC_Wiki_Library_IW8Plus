// scripts\mp\ob\activities\ob_activity_roadside_assistance.gsc  (hash_37bba89395d2ed92.gscc) (size: 11634 Bytes / 0x2d72 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51da2224 (1373250084)
// size ...... 11634 (0x2d72)
// includes .. 16  (offset: 0x2b02)
// strings ... 28  (offset: 0x2b82)
// dev strs .. 8   (offset: 0x2d12)
// exports ... 38  (offset: 0x183e)
// cseg ...... 0x2db + 0x1563 (0x183e)
// imports ... 111 (offset: 0x1e2e)
// animtree1 . 0   (offset: 0x2d72)
// animtree2 . 0   (offset: 0x2d72)
#using script_3edd59d0d3fc3262;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\ob_resource_manager;

#namespace ob_activity_roadside_assistance;

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x5
// Checksum 0x81082b7, Offset: 0x2f9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_roadside_assistance", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0xf842cdaa, Offset: 0x322
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_ROADSIDE_ASSISTANCE", &roadside_assistance_activity_init );
}

// Namespace ob_activity_roadside_assistance
// Params 0
// Checksum 0xb6070a00, Offset: 0x33d
// Size: 0xab
function roadside_assistance_activity_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_ROADSIDE_ASSISTANCE", 0, &roadside_assistance_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_ROADSIDE_ASSISTANCE", 1, &roadside_assistance_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_ROADSIDE_ASSISTANCE", 2, &roadside_assistance_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_ROADSIDE_ASSISTANCE", 3, &roadside_assistance_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_a3ae15899ef347c0, "REV_OB_ROADSIDE_ASSISTANCE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_d2227f455035385e, "REV_OB_ROADSIDE_ASSISTANCE" );
    level._effect[ "vfx_sat_ob_gameplay_wc_core_vehicle_dmg_cargo_truck_smokestack" ] = loadfxasset( "vfx_sat_ob_gameplay_wc_core_vehicle_dmg_cargo_truck_smokestack" );
    level._effect[ "vfx_sat_ob_gameplay_crate_destr" ] = loadfxasset( "vfx_sat_ob_gameplay_crate_destr" );
}

// Namespace ob_activity_roadside_assistance
// Params 0
// Checksum 0x1308db69, Offset: 0x3f0
// Size: 0x90
function roadside_assistance_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance.handler_list = [ "karm", "mars" ];
    activity_instance.enemies_broadcast = 0;
    activity_instance.vehicle = function_51a2d45ce28c265e( var_91c91f4a631c481d );
    activity_instance.spawned_bots = [];
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_activity_roadside_assistance
// Params 0
// Checksum 0x91dbb467, Offset: 0x488
// Size: 0x5e
function roadside_assistance_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.encounter_id = setup_guards();
    activity_instance setup_bots();
    
    /#
        activity_instance thread debug_draw();
        activity_instance thread function_8eeb50e8ea4082ae( "<dev string:x24>" );
    #/
}

// Namespace ob_activity_roadside_assistance
// Params 0
// Checksum 0x6c7dff0c, Offset: 0x4ee
// Size: 0xf4
function roadside_assistance_activity_ended()
{
    activity_instance = self;
    activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( activity_instance );
    player_list = activity_instance_common::function_4225efca86f0dea9( activity_instance );
    thread function_eb3b31bfffc00b69( activity_instance, activity_succeeded, player_list );
    
    if ( !self.var_a00973572e64 && self.vehicle && !self.vehicle vehicle_damage::is_burning_down() )
    {
        function_92c3ea82925a500f();
        
        if ( self.vehicle.cargo_crate && !self.vehicle.cargo_crate.looted )
        {
            self.vehicle.cargo_crate function_7653c765b6c7b815();
        }
    }
    
    /#
        if ( !isdefined( activity_succeeded ) )
        {
            activity_succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
        }
        
        thread function_8eeb50e8ea4082ae( "<dev string:x35>" + ( istrue( activity_succeeded ) ? "<dev string:x3f>" : "<dev string:x49>" ) );
    #/
}

// Namespace ob_activity_roadside_assistance
// Params 3
// Checksum 0xf399497d, Offset: 0x5ea
// Size: 0xcf
function function_eb3b31bfffc00b69( activity_instance, success, players )
{
    level endon( #"game_ended" );
    
    if ( !success )
    {
        wait 1.5;
    }
    
    foreach ( player in players )
    {
        if ( success )
        {
            thread ob_activity_vo_utility::function_639b0047db8aec67( self, "roadside_assistance_success", [ player ] );
            continue;
        }
        
        thread ob_activity_vo_utility::function_639b0047db8aec67( self, "roadside_assistance_fail", [ player ] );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 0
// Checksum 0xcba7646, Offset: 0x6c1
// Size: 0x23
function roadside_assistance_activity_destroy()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    roadside_assistance_activity_cleanup();
}

// Namespace ob_activity_roadside_assistance
// Params 1
// Checksum 0x34f47910, Offset: 0x6ec
// Size: 0x54
function function_a3ae15899ef347c0( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
    function_4972e69c3d362e81();
    roadside_assistance_cargo_play_vo( self, player_list );
}

// Namespace ob_activity_roadside_assistance
// Params 1
// Checksum 0x85bce8e1, Offset: 0x748
// Size: 0x32
function function_d2227f455035385e( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    thread ob_activity_vo_utility::function_639b0047db8aec67( self, "roadside_assistance_brief", player_list );
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0xba77dc3, Offset: 0x782
// Size: 0x23f
function private function_51a2d45ce28c265e( var_91c91f4a631c481d )
{
    vehicle_structs = utility::getstructarray( self.varianttag + "_vehicle", "targetname" );
    cargo_structs = utility::getstructarray( self.varianttag + "_cargo", "targetname" );
    assert( vehicle_structs.size <= 1 && cargo_structs.size <= 1 );
    
    if ( vehicle_structs.size > 0 )
    {
        var_465b20e0d8be9bfd = vehicle_structs[ 0 ].origin;
        var_79858549043f6653 = vehicle_structs[ 0 ].angles;
    }
    else
    {
        var_465b20e0d8be9bfd = activity_instance_common::function_776ee11e7acc64a5( self );
        var_79858549043f6653 = ( 0, 0, 0 );
    }
    
    cargo_origin = var_465b20e0d8be9bfd + ( -60, 0, 77 );
    cargo_angles = combineangles( var_79858549043f6653, ( 0, 90, 0 ) );
    
    if ( cargo_structs.size > 0 )
    {
        cargo_origin = cargo_structs[ 0 ].origin;
        cargo_angles = cargo_structs[ 0 ].angles;
    }
    
    vehicle_ref = var_91c91f4a631c481d.vehicleref ?? "veh_sat_medium_truck_mg_mp";
    spawndata = spawnstruct();
    spawndata.origin = var_465b20e0d8be9bfd;
    spawndata.angles = var_79858549043f6653;
    faildata = spawnstruct();
    vehicle = ob_resource_manager::activity_spawn_vehicle( vehicle_ref, spawndata, faildata );
    vehicle.var_1f9d76cca64c48f6 = 1;
    vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle setscriptablepartstate( #"single", #"vehicle_unusable_pingable" );
    vehicle.initial_smoke_vfx = setup_initial_smoke_vfx( vehicle );
    vehicle.cargo_crate = setup_cargo( vehicle, cargo_origin, cargo_angles );
    vehicle.var_d17d7176fa6477c9 = var_91c91f4a631c481d.var_86f5b66c96f3e141 ?? 120;
    vehicle init_vehicle_damage_state();
    vehicle thread vehicle_death_watcher( self );
    vehicle.cargo_crate thread cargo_destruction_watcher( self, vehicle.cargo_crate, vehicle );
    return vehicle;
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0xe6f9e6f0, Offset: 0x9ca
// Size: 0x69
function private vehicle_death_watcher( activity_instance )
{
    if ( !isdefined( activity_instance ) )
    {
        return;
    }
    
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    
    if ( isdefined( activity_instance ) && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 3, eflags: 0x4
// Checksum 0x4b8f0a30, Offset: 0xa3b
// Size: 0x67
function private cargo_destruction_watcher( activity_instance, cargo, vehicle )
{
    level endon( #"game_ended" );
    cargo endon( #"entitydeleted" );
    vehicle waittill( #"death" );
    playfx( utility::getfx( "vfx_sat_ob_gameplay_crate_destr" ), cargo.origin );
    cargo freescriptable();
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x7c71a100, Offset: 0xaaa
// Size: 0x5a
function private setup_initial_smoke_vfx( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    smoke = spawnscriptable( "sat_ob_activity_roadside_assistance_vehicle_smoke", vehicle.origin );
    smoke utility::scriptable_setparententity( vehicle );
    smoke setscriptablepartstate( #"smoke", #"on", 0 );
    return smoke;
}

// Namespace ob_activity_roadside_assistance
// Params 3, eflags: 0x4
// Checksum 0xf65e4369, Offset: 0xb0d
// Size: 0x83
function private setup_cargo( vehicle, origin, angles )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    crate_spawn_pos = getgroundposition( origin, 32 );
    cargo_crate = common_cache::function_9bc018c1b8aad720( #"activity_roadside_assistance", crate_spawn_pos, angles );
    cargo_crate.contents = [];
    cargo_crate.var_6e39895e14c70e34 = &function_1dbe7e2c6cc8f214;
    cargo_crate.activity_instance = self;
    return cargo_crate;
}

// Namespace ob_activity_roadside_assistance
// Params 2, eflags: 0x4
// Checksum 0x5974c822, Offset: 0xb99
// Size: 0x69
function private get_zone_def_name( player, position )
{
    zone_def_name = undefined;
    
    if ( utility::issharedfuncdefined( #"ob_loot", #"hash_b5deae02f491843f" ) )
    {
        zone_def_name = utility::callsharedfunc( #"ob_loot", #"hash_b5deae02f491843f", player, position );
    }
    else
    {
        zone_def_name = ob_activity_utility::function_11635f111a5a5ae3( position );
    }
    
    return zone_def_name;
}

// Namespace ob_activity_roadside_assistance
// Params 3, eflags: 0x4
// Checksum 0x525860a6, Offset: 0xc0b
// Size: 0x142
function private add_cargo( activity_instance, cargo_crate, player )
{
    zone_def_name = get_zone_def_name( player, cargo_crate.origin );
    
    if ( !zone_def_name )
    {
        assertmsg( "<dev string:x50>" );
    }
    
    var_e7476cf4916b5a8 = getscriptbundlefieldvalues( "itemspawnzonedef:" + zone_def_name, [ #"hash_32a95aa45b53f917" ] );
    
    foreach ( entry in var_e7476cf4916b5a8.var_a72bc938c97bce90 )
    {
        if ( entry.scriptkey == #"activity_roadside_assistance" )
        {
            assert( entry.cacheitemspawnentry, "<dev string:x81>" );
            common_cache::function_a136b84fc5c0dfab( cargo_crate, hashcat( %"itemspawnlist:", entry.itemspawnlist ), entry.itemspawnquantity, 1 );
        }
    }
}

// Namespace ob_activity_roadside_assistance
// Params 2, eflags: 0x4
// Checksum 0x72faac9, Offset: 0xd55
// Size: 0x8b
function private function_1dbe7e2c6cc8f214( instance, player )
{
    activity_instance = instance.activity_instance;
    
    if ( isdefined( activity_instance ) && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_definition_utils::updateprogress( 1, activity_instance );
        activity_participation::function_bc67362dace4370c( activity_instance, player, "PlayerJoinedInteract" );
        add_cargo( activity_instance, instance, player );
        instance.looted = 1;
        activity_instance function_4972e69c3d362e81();
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0xf16ddbb9, Offset: 0xde8
// Size: 0x5f
function private setup_guards()
{
    self.guards_in_combat = [];
    self.guards = [];
    encounter_id = activity_ai_encounters::function_92b671064b0b1ce2( self.varianttag + "_enc_vol", 1, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( encounter_id, &function_a6a78a7e4f736a9b, self );
    activity_ai_encounters::function_6bf4ff2fbde584ee( encounter_id, &finished_spawning_guards, self );
    return encounter_id;
}

// Namespace ob_activity_roadside_assistance
// Params 2, eflags: 0x4
// Checksum 0xd588d757, Offset: 0xe50
// Size: 0xdc
function private finished_spawning_guards( requestid, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    level endon( #"game_ended" );
    var_41f9287c4987add7 = function_9b649316adcccbaa( requestid );
    guards = var_41f9287c4987add7.ai;
    
    foreach ( guard in guards )
    {
        guard function_fa32376aaa88a7a2( activity_instance_common::function_776ee11e7acc64a5( activity_instance ), 1181.1 );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 4, eflags: 0x4
// Checksum 0x29fb6705, Offset: 0xf34
// Size: 0x82
function private function_a6a78a7e4f736a9b( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    activity_instance.guards = arraycombineunique( activity_instance.guards, [ agent ] );
    activity_instance notify( #"guards_spawned" );
    
    if ( isdefined( agent ) )
    {
        agent.var_88af750d8cd349c1 = 1;
        agent thread guard_watchers( activity_instance );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x23bff769, Offset: 0xfbe
// Size: 0x49
function private guard_watchers( activity_instance )
{
    if ( !isdefined( activity_instance ) )
    {
        return;
    }
    
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    childthread guard_entered_combat_watcher( activity_instance );
    childthread function_84c0f1d347ad70e5( activity_instance );
    childthread guard_death_watcher( activity_instance );
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x6c062e9a, Offset: 0x100f
// Size: 0x56
function private guard_entered_combat_watcher( activity_instance )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"stealth_combat", attacker );
        
        if ( isplayer( attacker ) )
        {
            activity_participation::function_bc67362dace4370c( activity_instance, attacker );
        }
        
        activity_instance on_guard_entered_combat( self );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x84fe00d7, Offset: 0x106d
// Size: 0x37
function private function_84c0f1d347ad70e5( activity_instance )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"stealth_combat_exited" );
        activity_instance function_5a363187d6f327a0( self );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0xa071f88b, Offset: 0x10ac
// Size: 0xe7
function private guard_death_watcher( activity_instance )
{
    self waittill( #"death", attacker );
    activity_instance function_5a363187d6f327a0( self );
    
    if ( isplayer( attacker ) )
    {
        activity_participation::function_bc67362dace4370c( activity_instance, attacker );
    }
    
    if ( isplayer( attacker ) && isdefined( activity_instance ) && !activity_instance.attacked_by_player )
    {
        activity_instance.attacked_by_player = 1;
        activity_instance function_4972e69c3d362e81();
    }
    
    if ( arraycontains( activity_instance.guards, self ) )
    {
        activity_instance.guards = arrayremove( activity_instance.guards, self );
    }
    
    if ( activity_instance.guards.size == 2 && activity_instance.enemies_broadcast == 0 )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "roadside_assistance_enemies" );
        activity_instance.enemies_broadcast = 1;
    }
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x8d99457d, Offset: 0x119b
// Size: 0x38
function private on_guard_entered_combat( guard )
{
    if ( !isdefined( guard ) )
    {
        return;
    }
    
    self.guards_in_combat = arraycombineunique( self.guards_in_combat, [ guard ] );
    function_4972e69c3d362e81();
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0x4e615106, Offset: 0x11db
// Size: 0x3e
function private function_5a363187d6f327a0( guard )
{
    if ( !isdefined( guard ) )
    {
        return;
    }
    
    if ( arraycontains( self.guards_in_combat, guard ) )
    {
        self.guards_in_combat = arrayremove( self.guards_in_combat, guard );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0x68911681, Offset: 0x1221
// Size: 0x4e
function private setup_bots()
{
    activity_instance = self;
    bot_spawns = utility::getstructarray( activity_instance.varianttag + "_bot_spawn", "targetname" );
    activity_instance.spawned_bots = story_contract_util::spawn_bots_folded( bot_spawns, "activate" );
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0x60311855, Offset: 0x1277
// Size: 0x19b
function private function_4972e69c3d362e81()
{
    if ( function_2baf0d7ac1e0e8a8() )
    {
        function_92c3ea82925a500f();
        
        if ( self.spawned_bots && isarray( self.spawned_bots ) )
        {
            foreach ( bot in self.spawned_bots )
            {
                bot notify( #"activate" );
                
                if ( !bot isincombat() )
                {
                    bot aieventlistenerevent( "gunshot", self.vehicle, self.vehicle.origin );
                }
            }
        }
        
        if ( self.guards && isarray( self.guards ) )
        {
            foreach ( guard in self.guards )
            {
                if ( !guard isincombat() )
                {
                    guard aieventlistenerevent( "gunshot", self.vehicle, self.vehicle.origin );
                }
            }
        }
    }
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0x449faf83, Offset: 0x141a
// Size: 0xc4, Type: bool
function private function_2baf0d7ac1e0e8a8()
{
    if ( !isdefined( self ) || self.var_a00973572e64 )
    {
        return false;
    }
    
    if ( !isdefined( self.vehicle ) || self.vehicle vehicle_damage::is_burning_down() )
    {
        return false;
    }
    
    if ( activity_instance_common::getactivitystate( self ) != "Active" )
    {
        return false;
    }
    
    if ( self.attacked_by_player )
    {
        return true;
    }
    
    if ( self.vehicle && self.vehicle.cargo_crate && self.vehicle.cargo_crate.looted )
    {
        return true;
    }
    
    if ( !isdefined( self.guards_in_combat ) || self.guards_in_combat.size == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0xa1884a71, Offset: 0x14e7
// Size: 0xcb
function private function_92c3ea82925a500f()
{
    vehicle = self.vehicle;
    
    if ( isdefined( vehicle.initial_smoke_vfx ) )
    {
        vehicle.initial_smoke_vfx freescriptable();
        playfxontag( utility::getfx( "vfx_sat_ob_gameplay_wc_core_vehicle_dmg_cargo_truck_smokestack" ), self.vehicle, "tag_origin" );
    }
    
    target_health = vehicle_damage::function_8c4b44320250db18( vehicle );
    damage_amount = max( int( vehicle.health - target_health ), 0 );
    
    if ( damage_amount > 0 )
    {
        vehicle dodamage( damage_amount, vehicle.origin, undefined, undefined, "MOD_CRUSH" );
    }
    
    self.var_a00973572e64 = 1;
    thread function_5fcaa4da5c1ed3e2( vehicle );
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x9c>" );
    #/
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0xfa47eb16, Offset: 0x15ba
// Size: 0x82
function private init_vehicle_damage_state()
{
    vehicle = self.vehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    target_health = vehicle_damage::function_a5c118b954f2ccba( vehicle );
    damage_amount = max( int( vehicle.health - target_health ), 0 );
    
    if ( damage_amount > 0 )
    {
        vehicle dodamage( damage_amount, vehicle.origin, undefined, undefined, "MOD_CRUSH" );
    }
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:xb8>" );
    #/
}

// Namespace ob_activity_roadside_assistance
// Params 0, eflags: 0x4
// Checksum 0x37eaa963, Offset: 0x1644
// Size: 0x60
function private roadside_assistance_activity_cleanup()
{
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    
    if ( isdefined( self.vehicle ) && isdefined( self.vehicle.initial_smoke_vfx ) )
    {
        self.vehicle.initial_smoke_vfx freescriptable();
    }
    
    if ( isdefined( self.encounter_id ) )
    {
        function_b43716082f77e5e5( self.encounter_id );
    }
}

// Namespace ob_activity_roadside_assistance
// Params 2, eflags: 0x4
// Checksum 0xe2ec7d5d, Offset: 0x16ac
// Size: 0x24
function private roadside_assistance_cargo_play_vo( activity_instance, player_list )
{
    thread ob_activity_vo_utility::function_639b0047db8aec67( self, "roadside_assistance_cargo", player_list );
}

// Namespace ob_activity_roadside_assistance
// Params 1, eflags: 0x4
// Checksum 0xf1e4dab5, Offset: 0x16d8
// Size: 0x80
function private function_5fcaa4da5c1ed3e2( vehicle )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    vehicle endon( #"death" );
    var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    vo_delay = ( var_91c91f4a631c481d.var_86f5b66c96f3e141 ?? 120 ) / 2;
    wait vo_delay;
    thread ob_activity_vo_utility::function_639b0047db8aec67( self, "roadside_assistance_warning" );
}

/#

    // Namespace ob_activity_roadside_assistance
    // Params 0, eflags: 0x4
    // Checksum 0x8e4db808, Offset: 0x1760
    // Size: 0x83, Type: dev
    function private debug_draw()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_roadside_assistance", 0 ) )
            {
                if ( isdefined( self.vehicle ) )
                {
                    print3d( self.vehicle getcentroid() + ( 0, 0, 100 ), string( self.vehicle.health ), ( 1, 1, 0 ), 1, 1, 1, 0 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_roadside_assistance
    // Params 1, eflags: 0x4
    // Checksum 0x9fb7fc73, Offset: 0x17eb
    // Size: 0x53, Type: dev
    function private function_8eeb50e8ea4082ae( text )
    {
        if ( !getdvarint( @"scr_debug_roadside_assistance", 0 ) )
        {
            return;
        }
        
        print3d( activity_instance_common::function_776ee11e7acc64a5( self ) + ( 0, 0, 150 ), text, ( 1, 0, 0 ), 1, 1, 100, 1 );
    }

#/
