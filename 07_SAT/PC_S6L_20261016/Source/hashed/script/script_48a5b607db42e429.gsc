// script_48a5b607db42e429  (hash_48a5b607db42e429.gscc) (size: 11275 Bytes / 0x2c0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb27341fe (2993897982)
// size ...... 11275 (0x2c0b)
// includes .. 12  (offset: 0x293f)
// strings ... 38  (offset: 0x299f)
// dev strs .. 6   (offset: 0x2bc3)
// exports ... 28  (offset: 0x19f7)
// cseg ...... 0x3af + 0x1648 (0x19f7)
// imports ... 92  (offset: 0x1e57)
// animtree1 . 0   (offset: 0x2c0b)
// animtree2 . 0   (offset: 0x2c0b)
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\weapon;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\ent_manager;
#using scripts\mp\gamelogic;

#namespace elite_ironclad_truck;

// Namespace elite_ironclad_truck
// Params 3
// Checksum 0x409ff524, Offset: 0x3cd
// Size: 0x251
function spawn_launcher( spawnorigin, spawnangles, dropheight )
{
    function_fff8803f7fcc8087();
    truck = level airdrop_scriptbundle::startairdrop( "airdrop_vehicle_elite_ironclad_truck", undefined, undefined, { #var_aa2bfcf28487c0ca:0, #dropangles:spawnangles, #droporigin:spawnorigin, #dropheight:dropheight } )[ 0 ];
    truck.animname = "truck";
    truck.var_a751cd5c8001e2f3 = utility::function_1808878d1c511ce8();
    truck.launch_fx = utility::function_1808878d1c511ce8();
    truck.launch_fx.angles += ( 90, 0, 0 );
    truck.launch_fx linkto( truck, "tag_missile_animate", ( -300, 0, 0 ), ( 0, 0, 0 ) );
    truck.var_a751cd5c8001e2f3 linkto( truck, "tag_missile_animate", ( -300, 0, 0 ), ( 0, 0, 0 ) );
    truck.var_d4ff3764331dc9d1 = truck.launch_fx utility::function_1808878d1c511ce8();
    truck.var_d4ff3764331dc9d1 linkto( truck.launch_fx, "tag_origin", ( 30, 0, 0 ), ( 0, 0, 0 ) );
    truck.godmode = 1;
    truck.var_dc6529e31dd31da1 = 1;
    truck.bossinstance = 1;
    truck setcandamage( 0 );
    truck forcenetfieldhighlod( 1 );
    truck function_d2b8ee2e1275daaf( 1 );
    var_477110598cae17b0 = getdvarint( @"hash_c108eb81d69d34e4", 0 ) == 1;
    
    if ( vehicle_interact::can_use( truck ) && !var_477110598cae17b0 )
    {
        vehicle_interact::allow_use( truck, 0 );
    }
    
    level.elite_ironclad.truck = truck;
    truck thread monitor_vehicle_trigger();
    truck thread monitor_entities();
    truck.unresolved_collision_func = &my_unresolved_collision;
    truck vehphys_enablecollisioncallback( 1 );
}

// Namespace elite_ironclad_truck
// Params 3
// Checksum 0xbbda6f6, Offset: 0x626
// Size: 0xef
function my_unresolved_collision( player, arg1, arg2 )
{
    if ( getdvarint( @"scr_elite_ironclad_truck_unresolved_collision", 1 ) == 1 )
    {
        if ( !isdefined( self ) || !isdefined( player ) || !isplayer( player ) || !isalive( player ) )
        {
            return;
        }
        
        now = gettime();
        
        if ( isdefined( player.var_1e3f68929d0dd83 ) && now < player.var_1e3f68929d0dd83 )
        {
            return;
        }
        
        player.var_1e3f68929d0dd83 = now + 250;
        push_dir = vectornormalize( player.origin - self.origin );
        
        if ( !isdefined( push_dir ) )
        {
            push_dir = anglestoforward( self.angles );
        }
        
        player setvelocity( push_dir * 450 + ( 0, 0, 120 ) );
    }
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x3c947826, Offset: 0x71d
// Size: 0x1aa
function private monitor_entities()
{
    level endon( #"game_ended" );
    
    /#
        self endon( #"death" );
    #/
    
    waittillframeend();
    assert( isdefined( self.collision_trigger ) );
    
    while ( self )
    {
        cleanupradius = getdvarint( @"hash_f3a308938678104b", 350 );
        entities = getentarrayinradius( undefined, undefined, self.origin, cleanupradius );
        
        foreach ( ent in entities )
        {
            if ( ent && ent.model && ent.model == "military_carepackage_01_br_loadout" )
            {
                ent thread airdrop::destroycrate();
            }
        }
        
        scriptables = getentitylessscriptablearray( undefined, undefined, self.origin, cleanupradius );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable && scriptable scriptableislootcache() && scriptable getscriptableisreserved() )
            {
                scriptable freescriptable();
            }
        }
        
        waitframe();
    }
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x6cee58c8, Offset: 0x8cf
// Size: 0x1d6
function private monitor_vehicle_trigger()
{
    level endon( #"game_ended" );
    
    /#
        self endon( #"death" );
    #/
    
    trigger_half_size = self getboundshalfsize();
    var_a98f742b563a2ea8 = self getboundsmidpoint();
    self.collision_trigger = spawn( "trigger_box", self.origin, 0, trigger_half_size, trigger_half_size );
    self.collision_trigger enablelinkto();
    self.collision_trigger linkto( self, "tag_origin", var_a98f742b563a2ea8, ( 0, 0, 0 ) );
    self.collision_trigger.trigger_half_size = trigger_half_size;
    
    while ( self )
    {
        vehicles = getentarrayinradius( "script_vehicle", "classname", self.origin, trigger_half_size[ 0 ] * 2 );
        
        foreach ( veh in vehicles )
        {
            if ( !veh || veh == self )
            {
                continue;
            }
            
            if ( veh.equipmentref && veh.equipmentref == "equip_mini_sentry" && veh islinked() )
            {
                continue;
            }
            
            if ( veh.targetname && veh.targetname == "veh_sat_mini_sentry" && veh islinked() )
            {
                continue;
            }
            
            if ( veh istouching( self.collision_trigger ) && !veh.isdestroyed )
            {
                veh explode_vehicle( self );
            }
        }
        
        waitframe();
    }
}

// Namespace elite_ironclad_truck
// Params 1, eflags: 0x4
// Checksum 0x9298e8a6, Offset: 0xaad
// Size: 0x10d
function private explode_vehicle( inflictor )
{
    if ( self.rcxdtype && utility::issharedfuncdefined( #"killstreak_rcxd", #"explode" ) )
    {
        utility::callsharedfunc( #"killstreak_rcxd", #"explode" );
        return;
    }
    
    damage_data = spawnstruct();
    damage_data.inflictor = inflictor;
    damage_data.objweapon = undefined;
    damage_data.meansofdeath = "MOD_UNKNOWN";
    damage_data.attacker = inflictor;
    
    if ( self.helperdronetype && helper_drone::function_cdb02c8d3e1593c0( self.helperdronetype ) )
    {
        thread helper_drone::helperdrone_explode( 1, 0, 0, 1, damage_data );
        return;
    }
    
    if ( self.targetname && self.targetname == "veh_sat_mini_sentry" && !self.isdying )
    {
        thread mini_sentry::on_destruction( undefined );
        return;
    }
    
    vehicle::explode( damage_data, 1 );
    waitframe();
    self delete();
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x1b27e15e, Offset: 0xbc2
// Size: 0x66
function private function_fff8803f7fcc8087()
{
    level._effect[ "vfx_cq_scud_prelaunch" ] = loadfxasset( "vfx_saw_gameplay_scud_launcher_prelaunch" );
    level._effect[ "vfx_cq_scud_trail" ] = loadfxasset( "vfx_saw_gameplay_scud_launcher_trail" );
    level._effect[ "vfx_cq_scud_buildup" ] = loadfxasset( "vfx_saw_gameplay_scud_launcher_buildup" );
    level._effect[ "vfx_cq_scud_flare" ] = loadfxasset( "vfx_t10_levels_mp_wz2_sierra_scud_flare" );
}

// Namespace elite_ironclad_truck
// Params 1
// Checksum 0x8bc60c1d, Offset: 0xc30
// Size: 0x115
function function_4e3cabfb53aa6261( position )
{
    closest_distance_sqr = 3.40282e+38;
    assert( isdefined( level.elite_ironclad.var_daa9e10f4d3ee5b6 ), "<dev string:x24>" );
    
    foreach ( path in level.elite_ironclad.var_daa9e10f4d3ee5b6 )
    {
        path_starting_pos = path[ 0 ].origin;
        distance_sqr = distancesquared( position, path_starting_pos );
        
        if ( distance_sqr < closest_distance_sqr )
        {
            closest_distance_sqr = distance_sqr;
            closest_path = path;
        }
    }
    
    assert( isdefined( closest_path ), "<dev string:x63>" );
    
    if ( !isdefined( closest_path ) )
    {
        return;
    }
    
    return function_e081d140efbeb2b4( closest_path );
}

// Namespace elite_ironclad_truck
// Params 1
// Checksum 0x324c4fe6, Offset: 0xd4e
// Size: 0xa2
function function_e081d140efbeb2b4( path )
{
    waypoints = [];
    
    foreach ( node in path )
    {
        waypoint = getclosestpointonnavmesh( node.origin );
        waypoints[ waypoints.size ] = waypoint;
    }
    
    return waypoints;
}

// Namespace elite_ironclad_truck
// Params 1
// Checksum 0x8d164f59, Offset: 0xdf9
// Size: 0x22
function init_smoke_vfx( var_7b90d05d2338d6bb )
{
    level._effect[ "smoke_effect" ] = loadfxasset( var_7b90d05d2338d6bb );
}

// Namespace elite_ironclad_truck
// Params 3
// Checksum 0xea3ba3f, Offset: 0xe23
// Size: 0xb4
function function_2b0962ff066f1ca4( data, duration_ms, player )
{
    self notify( #"hash_4baaaa539989c169" );
    self endon( #"hash_4baaaa539989c169" );
    self endon( #"death" );
    level endon( #"game_ended" );
    truck = self;
    truck function_666e0346caf006a6( data, duration_ms, player );
    interval_ms = utility::function_edc4cc03e9e60b3e( @"hash_bf98bd551ff4eb88", 1000, data.var_dea9bc54c721a3de );
    truck childthread function_1e8e630c85d2bf32( data, duration_ms, interval_ms );
    truck waittill( #"hash_fdf532b557b79b3f" );
    truck function_d96ad411c7647a7d( data );
}

// Namespace elite_ironclad_truck
// Params 3, eflags: 0x4
// Checksum 0x726d883d, Offset: 0xedf
// Size: 0x2b7
function private function_666e0346caf006a6( data, duration_ms, player )
{
    truck = self;
    assert( !truck.var_1e0ff8b78f0a265f, "<dev string:xa9>" );
    radius = utility::function_48f723fdc612ec65( @"hash_88809474a381e60d", 200, data.radius );
    height = utility::function_48f723fdc612ec65( @"hash_513c4b4a82ea6e50", 150, data.height );
    var_a89bc83f15301e7 = "tag_origin";
    bundle = weapon::getequipmenttableinfo( "equip_smoke" ).bundle;
    assert( isdefined( bundle ), "<dev string:xfb>" );
    truck.var_1e0ff8b78f0a265f = spawn( "trigger_radius", truck gettagorigin( var_a89bc83f15301e7 ), 0, radius, height );
    truck.var_1e0ff8b78f0a265f ent_manager::registerspawn( 1, &function_4d4aab85654b0c2b );
    truck.var_1e0ff8b78f0a265f.radius = radius;
    truck.var_1e0ff8b78f0a265f.height = height;
    truck.var_1e0ff8b78f0a265f.owner = player;
    truck.var_1e0ff8b78f0a265f.grenade = truck;
    truck.var_1e0ff8b78f0a265f.smokegrenadebundle = bundle;
    truck.var_1e0ff8b78f0a265f.playersintrigger = [];
    truck.var_1e0ff8b78f0a265f enablelinkto();
    truck.var_1e0ff8b78f0a265f linkto( truck, var_a89bc83f15301e7, ( 140, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( truck.var_1e0ff8b78f0a265f, &function_aea65a985ffaf2ea, &function_c83aea94a33a8f5c );
    }
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        utility::callsharedfunc( #"smokemanager", #"register", truck.var_1e0ff8b78f0a265f, undefined, radius, height, duration_ms );
    }
    
    if ( !isdefined( truck.var_10c97f5f5008ef41 ) )
    {
        truck.var_10c97f5f5008ef41 = utility::function_1808878d1c511ce8();
        truck.var_10c97f5f5008ef41 linkto( truck, var_a89bc83f15301e7, ( 140, 0, -100 ), ( 0, 0, 0 ) );
    }
}

// Namespace elite_ironclad_truck
// Params 1
// Checksum 0xd6c9d681, Offset: 0x119e
// Size: 0x104
function function_d96ad411c7647a7d( data )
{
    truck = self;
    
    if ( !truck )
    {
        return;
    }
    
    truck notify( #"hash_26978444b0755964" );
    
    if ( truck.var_1e0ff8b78f0a265f )
    {
        truck.var_1e0ff8b78f0a265f function_ccb750b822054b1e();
        truck.var_1e0ff8b78f0a265f = undefined;
    }
    
    if ( isdefined( truck.var_10c97f5f5008ef41 ) )
    {
        if ( truck.var_1f38c5b0d5222c3a )
        {
            stopfxontag( utility::getfx( "smoke_effect" ), truck.var_10c97f5f5008ef41, "tag_origin" );
            truck.var_1f38c5b0d5222c3a = 0;
        }
        
        truck.var_10c97f5f5008ef41 delete();
        truck.var_10c97f5f5008ef41 = undefined;
    }
    
    if ( truck.playing_sound )
    {
        truck stoploopsound();
        truck.playing_sound = 0;
        thread utility::play_sound_in_space( data.var_17f7cd9aefaf17d8 ?? "eqp_smoke_grenade_lp_end", truck.origin );
    }
}

// Namespace elite_ironclad_truck
// Params 3, eflags: 0x4
// Checksum 0x8b8ba41, Offset: 0x12aa
// Size: 0x12b
function private function_1e8e630c85d2bf32( data, duration_ms, interval_ms )
{
    self endon( #"hash_26978444b0755964" );
    truck = self;
    vfx = utility::getfx( "smoke_effect" );
    assert( vfx, "<dev string:x134>" );
    thread utility::play_sound_in_space( data.var_cd49a721e49fc3d6 ?? "eqp_smoke_grenade_exp", truck.origin );
    truck playloopsound( data.var_2a302dc673dde92c ?? "eqp_smoke_grenade_lp" );
    truck.playing_sound = 1;
    end_time = gettime() + duration_ms;
    
    while ( gettime() < end_time )
    {
        if ( truck.var_1f38c5b0d5222c3a )
        {
            stopfxontag( vfx, truck.var_10c97f5f5008ef41, "tag_origin" );
        }
        
        if ( vfx )
        {
            playfxontag( vfx, truck.var_10c97f5f5008ef41, "tag_origin" );
            truck.var_1f38c5b0d5222c3a = 1;
        }
        
        wait interval_ms * 0.001;
    }
    
    truck notify( #"hash_fdf532b557b79b3f" );
}

// Namespace elite_ironclad_truck
// Params 0
// Checksum 0x2a384d75, Offset: 0x13dd
// Size: 0x37, Type: bool
function function_18603e0eb7d8bb55()
{
    truck = self;
    
    if ( !truck )
    {
        return false;
    }
    
    var_b3bda98608369a71 = truck.var_1cb645692f33f854 ?? 0;
    return gettime() >= var_b3bda98608369a71;
}

// Namespace elite_ironclad_truck
// Params 2, eflags: 0x4
// Checksum 0x753d05ae, Offset: 0x141d
// Size: 0x1f
function private function_aea65a985ffaf2ea( player, trigger )
{
    smoke_grenade::function_56ca448dca08569d( player, trigger );
}

// Namespace elite_ironclad_truck
// Params 2, eflags: 0x4
// Checksum 0x3553b12f, Offset: 0x1444
// Size: 0x1f
function private function_c83aea94a33a8f5c( player, trigger )
{
    smoke_grenade::function_449ca741441193f5( player, trigger );
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x3417f2d6, Offset: 0x146b
// Size: 0x9
function private function_4d4aab85654b0c2b()
{
    function_ccb750b822054b1e();
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x7017cfa6, Offset: 0x147c
// Size: 0xd8
function private function_ccb750b822054b1e()
{
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread smoke_grenade::smoke_grenade_onexittrigger( self, 1 );
    }
    
    ent_manager::deregisterspawn();
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) && isdefined( self.smokeid ) )
    {
        utility::callsharedfunc( #"smokemanager", #"hash_8f0ee43079ae77e3", self );
    }
    
    self delete();
}

// Namespace elite_ironclad_truck
// Params 0
// Checksum 0x5209abb7, Offset: 0x155c
// Size: 0x5e
function function_4b7f47dea0a5b722()
{
    level endon( #"game_ended" );
    level endon( #"truck_sabotaged" );
    thread function_7d2b10d1e5b0125b( ( -18056, -36763, 6199 ), "evt_ironclad_nuke_siren_dist", 18 );
    thread function_7d2b10d1e5b0125b( ( 3456, 48128, 5760 ), "evt_ironclad_nuke_siren_dist", 21 );
    function_170769d041561d59();
    function_f0d642706c3cd210();
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x217f1b7b, Offset: 0x15c2
// Size: 0xb2
function private function_170769d041561d59()
{
    truck = self;
    missile_collision = getent( "missile_scud_01", #targetname );
    missile_collision linkto( self, "tag_missile_animate", ( 0, 0, 0 ), ( 90, 0, 0 ) );
    truck thread scene::play( [ truck ], "low_idle", "wz_br_cer_cq_missile_truck" );
    wait 2;
    truck thread scene::play( [ truck ], "raise_missile", "wz_br_cer_cq_missile_truck" );
    wait 30;
    truck thread scene::play( [ truck ], "up_idle", "wz_br_cer_cq_missile_truck" );
    level notify( #"missile_armed" );
}

// Namespace elite_ironclad_truck
// Params 0, eflags: 0x4
// Checksum 0x1ec19060, Offset: 0x167c
// Size: 0xdd
function private function_f0d642706c3cd210()
{
    truck = self;
    playfx( utility::getfx( "vfx_cq_scud_prelaunch" ), truck.launch_fx.origin, ( -1, 0, 0 ) );
    wait 5;
    truck thread scene::play( [ truck ], "launch_missile" );
    stopfxontag( utility::getfx( "vfx_cq_scud_prelaunch" ), truck.var_a751cd5c8001e2f3, "tag_origin" );
    playfx( utility::getfx( "vfx_cq_scud_buildup" ), truck.launch_fx.origin, ( -1, 0, 0 ) );
    wait 1.75;
    playfxontag( utility::getfx( "vfx_cq_scud_trail" ), truck.launch_fx, "tag_origin" );
    level notify( #"missile_launched" );
}

// Namespace elite_ironclad_truck
// Params 3, eflags: 0x4
// Checksum 0x2bdbcfc3, Offset: 0x1761
// Size: 0x74
function private function_7d2b10d1e5b0125b( origin, soundalias, delay = 0 )
{
    wait delay;
    ent = spawn( "script_model", origin );
    ent forcenetfieldhighlod( 1 );
    waitframe();
    ent playloopsound( soundalias );
    level utility::waittill_any_timeout( 40, "game_ended" );
    ent stoploopsound();
    waitframe();
    ent delete();
}

// Namespace elite_ironclad_truck
// Params 0
// Checksum 0x675983a, Offset: 0x17dd
// Size: 0xba
function function_8c4af3992f36d9a4()
{
    truck = self;
    raisefrac = truck scene::shot_get_time( "raise_missile" );
    idlefrac = truck scene::shot_get_time( "up_idle" );
    startfrac = 1;
    
    if ( isdefined( raisefrac ) )
    {
        if ( raisefrac < 0.5 )
        {
            startfrac = raisefrac * 2;
            shot = "missile_destroy_a";
        }
        else
        {
            startfrac = ( raisefrac - 0.5 ) * 2;
            shot = "missile_destroy_c";
        }
    }
    else if ( isdefined( idlefrac ) )
    {
        shot = "missile_destroy_b";
    }
    else
    {
        return;
    }
    
    truck thread scene::play( [ truck ], shot, "wz_br_cer_cq_missile_truck", startfrac );
}

// Namespace elite_ironclad_truck
// Params 0
// Checksum 0x7a3603d8, Offset: 0x189f
// Size: 0x29
function function_24717faf99601fae()
{
    truck = self;
    truck thread scene::play( [ truck ], "hatch", "wz_br_cer_cq_missile_truck" );
}

// Namespace elite_ironclad_truck
// Params 0
// Checksum 0xb03209d3, Offset: 0x18d0
// Size: 0x18
function stop_animations()
{
    truck = self;
    truck scene::stop();
}

/#

    // Namespace elite_ironclad_truck
    // Params 0
    // Checksum 0x59e615cb, Offset: 0x18f0
    // Size: 0xc1, Type: dev
    function function_ead720925ab4cf83()
    {
        if ( level.elite_ironclad.truck )
        {
            return;
        }
        
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        spawnorigin = host.origin + anglestoforward( host.angles ) * 1000 + ( 0, 0, 10 );
        spawnangles = host.angles * ( 0, 1, 0 );
        overridestruct = {};
        overridestruct.droporigin = spawnorigin;
        overridestruct.dropangles = spawnangles;
        spawn_launcher( spawnorigin, spawnangles );
    }

    // Namespace elite_ironclad_truck
    // Params 2
    // Checksum 0xad8dc5c6, Offset: 0x19b9
    // Size: 0x3e, Type: dev
    function function_a79bb4cd2c983fb9( shot, startfrac )
    {
        truck = self;
        truck thread scene::play( [ truck ], shot, "<dev string:x170>", startfrac );
    }

#/
