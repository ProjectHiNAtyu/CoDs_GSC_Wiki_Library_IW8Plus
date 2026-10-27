// scripts\common\vehicle_code.gsc  (hash_6d7498659e4f29ae.gscc) (size: 38945 Bytes / 0x9821 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc024eb16 (3223644950)
// size ...... 38945 (0x9821)
// includes .. 11  (offset: 0x8a55)
// strings ... 124 (offset: 0x8aad)
// dev strs .. 128 (offset: 0x90f5)
// exports ... 77  (offset: 0x6159)
// cseg ...... 0xa19 + 0x5740 (0x6159)
// imports ... 225 (offset: 0x6d61)
// animtree1 . 1   (offset: 0x9815)
// animtree2 . 0   (offset: 0x9821)
#using scripts\common\ai;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;

#namespace vehicle_code;

// Namespace vehicle_code
// Params 0
// Checksum 0xd88c3e8, Offset: 0xa37
// Size: 0xde2
function vehicle_initlevelvariables()
{
    if ( utility::issp() )
    {
        setsaveddvar( @"movingplatformcinematicmotion", 1 );
        setsaveddvar( @"useextendedcinematicmotion", 1 );
    }
    
    if ( !isdefined( level.vehicle ) )
    {
        level.vehicle = spawnstruct();
    }
    
    level.vehicle.templates = spawnstruct();
    level.vehicle.helicopter_crash_locations = getentarray( "helicopter_crash_location", #targetname );
    level.vehicle.helicopter_crash_locations = arraycombine( level.vehicle.helicopter_crash_locations, utility::getstructarray_delete( "helicopter_crash_location", "targetname" ) );
    level.vehicle.templates.team = [];
    level.vehicle.templates.deathmodel = [];
    level.vehicle.templates.death_thread = [];
    level.vehicle.templates.driveidle = [];
    level.vehicle.templates.driveidle_r = [];
    level.vehicle.templates.rumble = [];
    level.vehicle.templates.mainturret = [];
    level.vehicle.templates.mgturret = [];
    level.vehicle.templates.death_earthquake = [];
    level.vehicle.templates.surface_effects = [];
    level.vehicle.templates.unloadgroups = [];
    level.vehicle.templates.aianims = [];
    level.vehicle.templates.landanims = [];
    level.vehicle.templates.exhaust_fx = [];
    level.vehicle.templates.engine_fx = [];
    level.vehicle.templates.shoot_shock = [];
    level.vehicle.templates.hide_part_list = [];
    level.vehicle.templates.destructible_model = [];
    level.vehicle.templates.grenade_shield = [];
    level.vehicle.templates.var_d499c951c21f6dbb = [];
    level.vehicle.templates.bullet_shield = [];
    level.vehicle.templates.collision_shield = [];
    level.vehicle.templates.death_jolt = [];
    level.vehicle.templates.death_badplace = [];
    level.vehicle.templates.idle_anim = [];
    level.vehicle.templates.helicopter_list = [];
    level.vehicle.templates.boat_list = [];
    level.vehicle.templates.airplane_list = [];
    level.vehicle.templates.tank_list = [];
    level.vehicle.templates.single_tread_list = [];
    level.vehicle.templates.deathanimations = [];
    level.vehicle.templates.vehicle_death_fx = [];
    level.vehicle.templates.vehicle_rocket_death_fx = [];
    level.vehicle.templates.var_5cc6ecb6fb44af7c = [];
    level.vehicle.templates.death_radiusdamage = [];
    level.vehicle.templates.model = [];
    level.vehicle.templates.husk = [];
    level.vehicle.templates.var_bc8fe258d26d514 = [];
    level.vehicle.templates.iw9physics = [];
    level.vehicle.templates.hudindex = [];
    level.vehicle.templates.dependentparts = [];
    level.vehicle.damageableparts = [];
    level.vehicle.var_f601a32decc8f632 = throttle::throttle_initialize( "stoppedVehicle_throttle", 10 );
    
    if ( utility::issp() )
    {
        partdamagel = function_2628f73dceb39b8a( 3, 3 );
        var_c31008c7889ca83 = function_2628f73dceb39b8a( 5, 5 );
        var_c30fa8c7889bd51 = function_2628f73dceb39b8a( 5, 5 );
        var_c31018c7889ccb6 = function_2628f73dceb39b8a( 3, 3 );
        level.vehicle.damageableparts[ "tag_mirror_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_mirror_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_mirror_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_mirror_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_left_2" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_right_2" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_left_2" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_right_2" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_top_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_top_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_middle" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_front_top" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_back_top" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_parking_front_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_parking_front_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_parking_back_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_parking_back_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_fog_left_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_light_fog_right_d0" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_antenna" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_hubcap_front_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_hubcap_front_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_hubcap_back_left" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_hubcap_back_right" ] = partdamagel;
        level.vehicle.damageableparts[ "tag_windshield_front" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_windshield_front_pristine" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_windshield_front_web" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_windshield_back" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_front_left" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_front_right" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_back_left" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_back_right" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_back_left_corner" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_back_right_corner" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_window_sunroof" ] = var_c31008c7889ca83;
        level.vehicle.damageableparts[ "tag_door_front_left" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_front_right" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_back_left" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_back_right" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_front_left_d0" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_front_right_d0" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_back_left_d0" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_door_back_right_d0" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_hood" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_hood_d0" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_trunk" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_bumper_front" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_bumper_back" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_bumper_front_damaged" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_bumper_back_damaged" ] = var_c30fa8c7889bd51;
        level.vehicle.damageableparts[ "tag_wheel_center_front_left" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_center_front_right" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_center_middle_left" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_center_middle_right" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_center_back_left" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_center_back_right" ] = var_c31018c7889ccb6;
        level.vehicle.damageableparts[ "tag_wheel_spare" ] = var_c31018c7889ccb6;
        
        foreach ( name, _ in level.vehicle.damageableparts )
        {
            vehicle::function_6a14477bcf586606( name );
        }
    }
}

// Namespace vehicle_code
// Params 2, eflags: 0x4
// Checksum 0x5a01906c, Offset: 0x1821
// Size: 0x43
function private function_2628f73dceb39b8a( healthvalue, explosivedamagehealthvalue )
{
    part = spawnstruct();
    part.healthvalue = healthvalue;
    part.explosivedamagehealthvalue = explosivedamagehealthvalue;
    return part;
}

// Namespace vehicle_code
// Params 2
// Checksum 0x8b0f762f, Offset: 0x186d
// Size: 0x121
function _getvehiclespawnerarray( value, key )
{
    /#
        if ( isdefined( value ) || isdefined( key ) )
        {
            assert( isdefined( value ) && isdefined( key ), "<dev string:x24>" );
        }
    #/
    
    newarray = [];
    
    if ( isdefined( value ) && isdefined( key ) )
    {
        check_classname = 1;
        vehicles = getentarray( value, key );
    }
    else
    {
        check_classname = 0;
        vehicles = getentarray( "script_vehicle", #code_classname );
    }
    
    foreach ( vehicle in vehicles )
    {
        if ( check_classname && vehicle.code_classname != "script_vehicle" )
        {
            continue;
        }
        
        if ( isspawner( vehicle ) )
        {
            newarray[ newarray.size ] = vehicle;
        }
    }
    
    return newarray;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x727ed301, Offset: 0x1997
// Size: 0x3f
function _mainturretoff()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    self.script_turretmain = 0;
    
    if ( !isdefined( self.mainturret ) )
    {
        return;
    }
    
    _turretoffshared( self.mainturret );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xa4f0a456, Offset: 0x19de
// Size: 0x40
function _mainturreton()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    self.script_turretmain = 1;
    
    if ( !isdefined( self.mainturret ) )
    {
        return;
    }
    
    _turretonshared( self.mainturret );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xa28cc787, Offset: 0x1a26
// Size: 0xed
function _mgoff()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    self.script_turretmg = 0;
    
    if ( vehicle::ishelicopter() && hashelicopterturret() )
    {
        if ( isdefined( level.chopperturretfunc ) )
        {
            assert( isdefined( level.chopperturretofffunc ), "<dev string:x76>" );
            self thread [[ level.chopperturretofffunc ]]();
            return;
        }
    }
    
    if ( !isdefined( self.mgturret ) )
    {
        return;
    }
    
    foreach ( turret in self.mgturret )
    {
        _turretoffshared( turret );
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0x6abecdce, Offset: 0x1b1b
// Size: 0xe8
function _mgon()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    self.script_turretmg = 1;
    
    if ( vehicle::ishelicopter() && hashelicopterturret() )
    {
        assert( isdefined( level.chopperturretonfunc ), "<dev string:x76>" );
        self thread [[ level.chopperturretonfunc ]]();
        return;
    }
    
    if ( !isdefined( self.mgturret ) )
    {
        return;
    }
    
    foreach ( turret in self.mgturret )
    {
        turret show();
        _turretonshared( turret );
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x77b2e2dc, Offset: 0x1c0b
// Size: 0x34
function _turretoffshared( turret )
{
    if ( isdefined( turret.script_fireondrones ) )
    {
        turret.script_fireondrones = 0;
    }
    
    turret setmode( "manual" );
}

// Namespace vehicle_code
// Params 1
// Checksum 0xe46b50ad, Offset: 0x1c47
// Size: 0x76
function _turretonshared( turret )
{
    if ( isdefined( turret.script_fireondrones ) )
    {
        turret.script_fireondrones = 1;
    }
    
    if ( isdefined( turret.defaultonmode ) )
    {
        if ( turret.defaultonmode != "sentry" )
        {
            turret setmode( turret.defaultonmode );
        }
    }
    else
    {
        turret setmode( "auto_nonai" );
    }
    
    set_turret_team( turret );
}

// Namespace vehicle_code
// Params 1
// Checksum 0x50d3288e, Offset: 0x1cc5
// Size: 0x5ac
function _vehicle_unload( who )
{
    self endon( #"death" );
    
    if ( isdefined( who ) )
    {
        self.unload_group = who;
    }
    
    if ( isdefined( self.vehicle_unload_function ) )
    {
        result = self [[ self.vehicle_unload_function ]]();
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    if ( isdefined( level.func[ "vehicle_unload" ] ) )
    {
        result = self [[ level.func[ "vehicle_unload" ] ]]();
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    if ( utility::ent_flag_exist( "no_riders_until_unload" ) )
    {
        utility::ent_flag_set( "no_riders_until_unload" );
        ai = spawn_unload_group( self.unload_group );
        
        foreach ( a in ai )
        {
            ai::spawn_failed( a );
        }
        
        waittillframeend();
    }
    
    self notify( #"unloading" );
    ai = [];
    unloadgroups = level.vehicle.templates.unloadgroups[ get_vehicle_classname() ];
    
    if ( isdefined( unloadgroups ) )
    {
        unloadgroup = vehicle_aianim::get_unload_group();
        
        if ( self.vehiclesetuprope )
        {
            for ( i = 0; i < level.vehicle.templates.aianims[ get_vehicle_classname() ].size ; i++ )
            {
                animpos = level.vehicle.templates.aianims[ get_vehicle_classname() ][ i ];
                
                if ( animpos.setuprope )
                {
                    usingrope = 0;
                    
                    foreach ( rider in self.riders )
                    {
                        if ( isdefined( rider.vehicle_position ) && isdefined( unloadgroup[ rider.vehicle_position ] ) && rider.vehicle_position != i )
                        {
                            rideranimpos = vehicle_aianim::anim_pos( self, rider.vehicle_position );
                            
                            if ( rideranimpos.fastroperig == animpos.fastroperig )
                            {
                                usingrope = 1;
                                break;
                            }
                        }
                    }
                    
                    if ( usingrope )
                    {
                        foreach ( rider in self.riders )
                        {
                            if ( isalive( rider ) && isdefined( rider.vehicle_position ) && rider.vehicle_position == i )
                            {
                                vehicle_aianim::guy_setup_rope( rider, animpos );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        foreach ( rider in self.riders )
        {
            if ( isalive( rider ) && isdefined( rider.vehicle_position ) && isdefined( unloadgroup[ rider.vehicle_position ] ) )
            {
                if ( isdefined( level.vehicle.aianimcheck[ "unload" ] ) && ![[ level.vehicle.aianimcheck[ "unload" ] ]]( rider, rider.vehicle_position ) )
                {
                    continue;
                }
                
                animpos = vehicle_aianim::anim_pos( self, rider.vehicle_position );
                
                if ( isdefined( animpos ) && animpos.do_not_unload )
                {
                    continue;
                }
                
                rider setbattlechatterflag( "unloading", 1, 3 );
                rider setbattlechatterflag( "disabled", 0 );
                
                if ( isdefined( level.vehicle.aianimthread[ "unload" ] ) )
                {
                    if ( !animpos.setuprope )
                    {
                        rider notify( #"newanim" );
                        
                        if ( rider != self.aidriver && who == "moving" || vehicle_ai::has_anim_intro() )
                        {
                            rider._blackboard.var_b9c6f854e130fe2a = 1;
                        }
                        
                        if ( rider == self.aidriver && who == "moving" )
                        {
                            continue;
                        }
                        
                        thread [[ level.vehicle.aianimthread[ "unload" ] ]]( rider, rider.vehicle_position );
                        rider notify( #"unload" );
                        rider.vehicle = undefined;
                        
                        if ( isdefined( animpos.mgturret ) )
                        {
                            rider ai::stop_use_turret();
                        }
                        
                        ai[ ai.size ] = rider;
                    }
                }
            }
        }
    }
    
    return ai;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x80ec3f57, Offset: 0x227a
// Size: 0x3c
function vehicle_setuplevelvariables()
{
    if ( !utility::add_init_script( "vehicle_vars", &vehicle_setuplevelvariables ) )
    {
        return;
    }
    
    vehicle_initlevelvariables();
    
    /#
        if ( getprojectname() == "<dev string:xac>" )
        {
            init_vehicle_spawner_devgui();
        }
    #/
    
    vehicle_aianim::setup_aianimthreads();
}

// Namespace vehicle_code
// Params 1
// Checksum 0x536cc7d4, Offset: 0x22be
// Size: 0xa6
function vehicle_triggerkillspawner( trigger )
{
    trigger waittill( #"trigger" );
    
    foreach ( vehiclespawner in vehicle_getspawnerarray() )
    {
        if ( vehiclespawner.script_kill_vehicle_spawner == trigger.script_kill_vehicle_spawner )
        {
            vehiclespawner delete();
        }
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x9284e0cb, Offset: 0x236c
// Size: 0x178
function vehicle_spawnaiarray( spawners )
{
    totalspawnedai = [];
    forcespawn = utility::ent_flag_exist( "no_riders_until_unload" ) && utility::ent_flag( "no_riders_until_unload" );
    
    foreach ( spawner in spawners )
    {
        spawner.count = 1;
        dronespawn = 0;
        
        if ( spawner.script_drone )
        {
            dronespawn = 1;
            spawned = utility::script_func( "dronespawn_bodyonly", spawner );
            spawned utility::script_func( "drone_give_soul" );
        }
        else if ( spawner.script_fakeactor || spawner.script_bodyonly )
        {
            dronespawn = 1;
            spawned = utility::script_func( "bodyonlyspawn", spawner );
            spawned utility::script_func( "fakeactor_give_soul" );
        }
        else
        {
            spawned = spawner utility::script_func( "spawn_ai", forcespawn );
        }
        
        if ( !dronespawn && !isalive( spawned ) )
        {
            continue;
        }
        
        totalspawnedai[ totalspawnedai.size ] = spawned;
    }
    
    riders = vehicle_removenonridersfromaiarray( totalspawnedai );
    return riders;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x5d261b3e, Offset: 0x24ed
// Size: 0x98
function vehicle_removenonridersfromaiarray( aiarray )
{
    living_ai = [];
    
    foreach ( ai in aiarray )
    {
        if ( !ai_should_be_added( ai ) )
        {
            continue;
        }
        
        living_ai[ living_ai.size ] = ai;
    }
    
    return living_ai;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x66646737, Offset: 0x258e
// Size: 0x44, Type: bool
function ai_should_be_added( ai )
{
    if ( isalive( ai ) )
    {
        return true;
    }
    
    if ( !isdefined( ai ) )
    {
        return false;
    }
    
    if ( !isdefined( ai.classname ) )
    {
        return false;
    }
    
    return ai.classname == "script_model";
}

// Namespace vehicle_code
// Params 0
// Checksum 0xd975dc42, Offset: 0x25db
// Size: 0x77
function spawn_riders()
{
    if ( utility::ent_flag_exist( "no_riders_until_unload" ) && !utility::ent_flag( "no_riders_until_unload" ) )
    {
        self notify( #"spawnedriders" );
        return [];
    }
    
    spawners = get_vehicle_riders_spawners();
    
    if ( !spawners.size )
    {
        self notify( #"spawnedriders" );
        return [];
    }
    
    riders = spawn_group( spawners );
    self notify( #"spawnedriders", riders );
    return riders;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x647d27bd, Offset: 0x265b
// Size: 0xbc
function spawn_group( spawners )
{
    ai = vehicle_spawnaiarray( spawners );
    ai = sort_by_startingpos( ai );
    
    if ( vehicle::is_common_vehicle() )
    {
        thread vehicle_ai::load( ai, 1 );
    }
    else
    {
        foreach ( guy in ai )
        {
            thread vehicle_aianim::guy_enter( guy );
        }
    }
    
    thread set_loaded_when_full( ai );
    return ai;
}

// Namespace vehicle_code
// Params 1
// Checksum 0xeb10ae94, Offset: 0x2720
// Size: 0x24
function set_loaded_when_full( ai )
{
    utility::array_wait( ai, "loaded", 1 );
    vehicle_aianim::vehicle_loaded_if_full( self );
}

// Namespace vehicle_code
// Params 1
// Checksum 0xe1ccc580, Offset: 0x274c
// Size: 0x28a
function spawn_unload_group( who )
{
    if ( !isdefined( who ) )
    {
        return spawn_riders();
    }
    
    assert( utility::ent_flag_exist( "<dev string:xb0>" ) && utility::ent_flag( "<dev string:xb0>" ), "<dev string:xc7>" );
    spawners = get_vehicle_riders_spawners();
    
    if ( !spawners.size )
    {
        return [];
    }
    
    group_spawners = [];
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.unloadgroups[ classname ][ who ] ) )
    {
        group = level.vehicle.templates.unloadgroups[ classname ][ who ];
        
        for ( i = 0; i < group.size ; i++ )
        {
            if ( isdefined( spawners[ i ] ) )
            {
                spawners[ i ].script_startingposition = group[ i ];
            }
        }
        
        spawners = sort_by_startingpos( spawners );
        
        foreach ( ride_pos in group )
        {
            foreach ( spawner in spawners )
            {
                if ( spawner.script_startingposition == ride_pos )
                {
                    group_spawners[ group_spawners.size ] = spawner;
                }
            }
        }
        
        ai = vehicle_spawnaiarray( group_spawners );
        
        foreach ( guy in ai )
        {
            thread vehicle_aianim::guy_enter( guy );
        }
        
        self notify( #"spawnedriders", ai );
        return ai;
    }
    
    return spawn_riders();
}

// Namespace vehicle_code
// Params 1
// Checksum 0x6c7f1082, Offset: 0x29de
// Size: 0xb2
function sort_by_startingpos( guysarray )
{
    firstarray = [];
    secondarray = [];
    
    foreach ( guy in guysarray )
    {
        if ( isdefined( guy.script_startingposition ) )
        {
            firstarray[ firstarray.size ] = guy;
            continue;
        }
        
        secondarray[ secondarray.size ] = guy;
    }
    
    return arraycombine( firstarray, secondarray );
}

// Namespace vehicle_code
// Params 1
// Checksum 0x4abf3f31, Offset: 0x2a99
// Size: 0x28
function function_2f279e91bd543e23( spawndata )
{
    if ( vehicle::ishelicopter() )
    {
        thread vehicle_ai_avoidance_heli( spawndata );
        return;
    }
    
    thread vehicle_ai_avoidance_logic();
}

// Namespace vehicle_code
// Params 0
// Checksum 0xcd202a1d, Offset: 0x2ac9
// Size: 0x3d
function get_vehicle_classname()
{
    var_7237854e3be197ca = self.classname_mp;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = self.classname_sp;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self.classname;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x7bf375d4, Offset: 0x2b0f
// Size: 0x4b
function get_vehicle_model()
{
    var_7237854e3be197ca = self.modelhack;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    model = self.vehiclemodel;
    
    if ( model == "" )
    {
        model = self.model;
    }
    
    return model;
}

#using_animtree( "vehicles" );

// Namespace vehicle_code
// Params 0
// Checksum 0x2949b0c4, Offset: 0x2b63
// Size: 0x213
function vehicle_deathcleanup()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x10a>" + "<dev string:x140>" + "<dev string:x163>" );
    self notify( #"stop_looping_death_fx" );
    self notify( #"death_finished" );
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
    }
    
    destroynavrepulsor( "veh_" + self getentitynumber() );
    
    if ( isdefined( self.rumbletrigger ) )
    {
        self.rumbletrigger delete();
    }
    
    if ( isdefined( self.mgturret ) )
    {
        utility::array_delete( self.mgturret );
    }
    
    if ( isdefined( self.mainturret ) )
    {
        self.mainturret delete();
    }
    
    if ( level.vehicle.templates.has_main_turret[ self.model ] )
    {
        self clearturrettarget();
    }
    
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.rumble[ classname ] ) )
    {
        self stoprumble( level.vehicle.templates.rumble[ classname ].rumble );
    }
    
    if ( !utility::issp() )
    {
        return;
    }
    
    self useanimtree( #animtree );
    
    if ( isdefined( level.vehicle.templates.driveidle[ self.model ] ) )
    {
        self clearanim( level.vehicle.templates.driveidle[ self.model ], 0 );
    }
    
    if ( isdefined( level.vehicle.templates.driveidle_r[ self.model ] ) )
    {
        self clearanim( level.vehicle.templates.driveidle_r[ self.model ], 0 );
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0xee29b86e, Offset: 0x2d7e
// Size: 0xc, Type: bool
function vehicle_iscrashing()
{
    return istrue( self.vehiclecrashing );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xd79607cc, Offset: 0x2d93
// Size: 0x9
function vehicle_killriders()
{
    vehicle_ai::kill_riders();
}

// Namespace vehicle_code
// Params 2
// Checksum 0x88a37fed, Offset: 0x2da4
// Size: 0x1cd
function vehicle_landanims( isunloadnode, hasnextnode )
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    self endon( #"death" );
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.landanims[ classname ] ) )
    {
        return;
    }
    
    landanims = level.vehicle.templates.landanims[ classname ];
    
    foreach ( lanim in landanims )
    {
        self setanim( lanim.land, 1, 0.2, 1 );
    }
    
    if ( !hasnextnode )
    {
        return;
    }
    
    if ( isdefined( isunloadnode ) )
    {
        self waittill( #"unloaded" );
    }
    else
    {
        self waittill( #"continuepath" );
    }
    
    foreach ( lanim in landanims )
    {
        self clearanim( lanim.land, 0 );
        self setanim( lanim.takeoff, 1, 0.2, 1 );
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x54def9c6, Offset: 0x2f79
// Size: 0xcd
function waittill_stable( node )
{
    offset = 12;
    stabletime = 400;
    timer = gettime() + stabletime;
    prevangles = self.angles;
    
    while ( isdefined( self ) )
    {
        if ( abs( angleclamp180( self.angles[ 0 ] ) ) > offset || abs( angleclamp180( self.angles[ 2 ] ) ) > offset || abs( self.angles[ 1 ] - prevangles[ 1 ] ) > 0.5 )
        {
            timer = gettime() + stabletime;
        }
        
        if ( gettime() > timer )
        {
            break;
        }
        
        prevangles = self.angles;
        wait 0.05;
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0x294eeabc, Offset: 0x304e
// Size: 0xe
function vehicle_kill_badplace_forever()
{
    self notify( #"kill_badplace_forever" );
}

// Namespace vehicle_code
// Params 1
// Checksum 0x4d582aca, Offset: 0x3064
// Size: 0x17
function get_from_linkedlist( node )
{
    return node.target;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x5cfbe322, Offset: 0x3084
// Size: 0xf5
function get_from_spawnstruct( node )
{
    array = utility::getstructarray( node.target, "targetname" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    foreach ( element in array )
    {
        poi_definition = element.script_poi ?? element.poi;
        comp_poi_definition = self.script_poi ?? self.poi;
        
        if ( poi_definition == comp_poi_definition )
        {
            return element;
        }
    }
    
    return array[ 0 ];
}

// Namespace vehicle_code
// Params 1
// Checksum 0xfa7e6581, Offset: 0x3181
// Size: 0x42
function get_from_entity( node )
{
    ent = getentarray( node.target, #targetname );
    
    if ( ent.size > 0 )
    {
        return ent[ randomint( ent.size ) ];
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x575d4c9, Offset: 0x31cc
// Size: 0x35
function get_from_vehicle_node( node )
{
    if ( !isdefined( node.target ) )
    {
        return;
    }
    
    return getvehiclenode( node.target, #targetname );
}

// Namespace vehicle_code
// Params 1
// Checksum 0xd3650c6a, Offset: 0x320a
// Size: 0x4b
function set_lookat_from_dest( dest )
{
    viewtarget = getent( dest.script_linkto, #script_linkname );
    
    if ( !isdefined( viewtarget ) )
    {
        return;
    }
    
    self setlookatent( viewtarget );
    self.set_lookat_point = 1;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x495c5cad, Offset: 0x325d
// Size: 0x66, Type: bool
function hashelicopterturret()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    if ( self.vehicletype == "cobra" )
    {
        return true;
    }
    
    if ( self.vehicletype == "cobra_player" )
    {
        return true;
    }
    
    if ( self.vehicletype == "viper" )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x9f66bc20, Offset: 0x32cc
// Size: 0x1d
function vehicle_ai_avoidance_cleanup()
{
    self waittill( #"death" );
    vehicle_remove_navobstacle();
    vehicle_remove_navrepulsor();
}

// Namespace vehicle_code
// Params 0
// Checksum 0x5a83e1df, Offset: 0x32f1
// Size: 0x125
function vehicle_ai_avoidance_logic()
{
    self endon( #"death" );
    thread vehicle_ai_avoidance_cleanup();
    isphysicsvehicle = self vehicle_isphysveh();
    var_95f636000669c3d5 = 56.25;
    vehicleref = vehicle::get_ref();
    
    if ( vehicle::has_data( vehicleref ) )
    {
        bundledata = vehicle::get_data( vehicleref );
        var_95f636000669c3d5 = bundledata.nudgethreshold * bundledata.nudgethreshold;
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.vehicle.var_f601a32decc8f632, self );
        vehicle_navobstacle();
        
        for ( currentorigin = self.origin; function_a45a8093293194a7( isphysicsvehicle ) ; currentorigin = self.origin )
        {
            wait 0.5;
            
            if ( length2dsquared( self.origin - currentorigin ) > var_95f636000669c3d5 )
            {
                vehicle_remove_navobstacle();
                vehicle_navobstacle();
            }
        }
        
        vehicle_remove_navobstacle();
        vehicle_navrepulsor();
        
        while ( !function_a45a8093293194a7( isphysicsvehicle ) )
        {
            wait 0.1;
        }
        
        vehicle_remove_navrepulsor();
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x3bf72216, Offset: 0x341e
// Size: 0x9e, Type: bool
function function_a45a8093293194a7( isphysicsvehicle )
{
    if ( !vehicle_is_stopped( 1 ) )
    {
        return false;
    }
    
    if ( isphysicsvehicle && !self vehicle_isonground() )
    {
        return false;
    }
    
    if ( !utility::issp() )
    {
        if ( !self vehicle_isphysveh() )
        {
            return false;
        }
        
        if ( self hascomponent( "p2p" ) && self function_24e10bf6894fa869( "p2p", "manualSpeed" ) > 0 )
        {
            return false;
        }
        
        if ( self hascomponent( "path" ) && !self function_24e10bf6894fa869( "path", "pause" ) && self function_24e10bf6894fa869( "path", "targetSpeed" ) > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicle_code
// Params 1
// Checksum 0xbb4da744, Offset: 0x34c5
// Size: 0xaf
function vehicle_is_stopped( var_ed87b2c2706620c4 )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicle_is_stopped" ) )
    {
        stopped = utility::callsharedfunc( #"vehicle", #"vehicle_is_stopped", var_ed87b2c2706620c4 );
        return stopped;
    }
    
    velocity = self vehicle_getvelocity();
    
    if ( !isdefined( velocity ) )
    {
        return 1;
    }
    
    speed = var_ed87b2c2706620c4 ? length( ( velocity[ 0 ], velocity[ 1 ], 0 ) ) : length( velocity );
    
    if ( self vehicle_isphysveh() )
    {
        return ( speed / 17.6 < 0.25 );
    }
    
    return speed / 17.6 == 0;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x8795afce, Offset: 0x357d
// Size: 0xb6
function vehicle_ai_avoidance_heli( spawndata )
{
    self endon( #"death" );
    thread vehicle_ai_avoidance_cleanup();
    
    while ( true )
    {
        if ( spawndata.custombounds )
        {
            function_c20e7a724922fd1d( spawndata.custombounds );
        }
        else
        {
            vehicle_navobstacle();
        }
        
        while ( self vehicle_getspeed() == 0 && ( !isdefined( self.script_disconnectpaths ) || self.script_disconnectpaths ) )
        {
            wait 0.1;
        }
        
        vehicle_remove_navobstacle();
        
        while ( self vehicle_getspeed() != 0 || isdefined( self.script_disconnectpaths ) && !self.script_disconnectpaths )
        {
            wait 0.1;
        }
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0x2b49824d, Offset: 0x363b
// Size: 0x68
function vehicle_navrepulsor()
{
    if ( isdefined( self.script_badplace ) && !self.script_badplace )
    {
        return;
    }
    
    radius = -1;
    
    if ( isdefined( self.var_3709dfeedf9c1aae ) )
    {
        radius = self.var_3709dfeedf9c1aae;
    }
    
    createnavrepulsor( self.unique_id + "vehicle_badplace", -1, self, radius, 0, "allies", "axis" );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xe9bf80c8, Offset: 0x36ab
// Size: 0x16
function vehicle_remove_navrepulsor()
{
    destroynavrepulsor( self.unique_id + "vehicle_badplace" );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xf43e9d83, Offset: 0x36c9
// Size: 0x2c
function vehicle_navobstacle()
{
    if ( isdefined( self.script_disconnectpaths ) && !self.script_disconnectpaths )
    {
        return;
    }
    
    self.navobstacleid = createnavbadplacebyent( self );
}

// Namespace vehicle_code
// Params 1
// Checksum 0xce984919, Offset: 0x36fd
// Size: 0x49
function function_c20e7a724922fd1d( bounds )
{
    if ( isdefined( self.script_disconnectpaths ) && !self.script_disconnectpaths )
    {
        return;
    }
    
    self.navobstacleid = createnavbadplacebybounds( self.origin, bounds, self.angles );
}

// Namespace vehicle_code
// Params 0
// Checksum 0xc6aa83cb, Offset: 0x374e
// Size: 0x27
function vehicle_remove_navobstacle()
{
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
        self.navobstacleid = undefined;
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0x5f2bdd17, Offset: 0x377d
// Size: 0x13
function vehicle_disable_navrepulsors()
{
    self.script_badplace = 0;
    vehicle_remove_navrepulsor();
}

// Namespace vehicle_code
// Params 0
// Checksum 0xf2c593ce, Offset: 0x3798
// Size: 0x1d
function vehicle_enable_navrepulsors()
{
    self.script_badplace = undefined;
    
    if ( !function_a45a8093293194a7() )
    {
        vehicle_navrepulsor();
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0xe0ea37bd, Offset: 0x37bd
// Size: 0x23
function function_1366abd824351577( radius )
{
    assert( radius > 0 );
    self.var_3709dfeedf9c1aae = radius;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x70e74ae5, Offset: 0x37e8
// Size: 0x13
function vehicle_disable_navobstacles()
{
    self.script_disconnectpaths = 0;
    vehicle_remove_navobstacle();
}

// Namespace vehicle_code
// Params 0
// Checksum 0x37bf5deb, Offset: 0x3803
// Size: 0x2a
function vehicle_enable_navobstacles()
{
    self.script_disconnectpaths = undefined;
    
    if ( !self.navobstacleid && function_a45a8093293194a7() )
    {
        vehicle_navobstacle();
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0xcfd53d92, Offset: 0x3835
// Size: 0xd2
function mainturretinit()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.mainturret[ classname ] ) )
    {
        return;
    }
    
    turret_template = level.vehicle.templates.mainturret[ classname ];
    
    if ( !isdefined( turret_template ) )
    {
        return;
    }
    
    self.mainturret = turretinitshared( turret_template );
    
    if ( !isdefined( self.script_turretmain ) )
    {
        self.script_turretmain = 1;
    }
    
    if ( self.script_turretmain == 0 )
    {
        thread _mainturretoff();
        return;
    }
    
    self.script_turretmain = 1;
    thread _mainturreton();
}

// Namespace vehicle_code
// Params 0
// Checksum 0x5c61d149, Offset: 0x390f
// Size: 0x1a9
function mginit()
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    classname = get_vehicle_classname();
    
    if ( isdefined( self.script_nomg ) && self.script_nomg > 0 )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.mgturret[ classname ] ) )
    {
        return;
    }
    
    turret_templates = level.vehicle.templates.mgturret[ classname ];
    
    if ( !isdefined( turret_templates ) )
    {
        return;
    }
    
    allowed_turrets = "";
    
    if ( isdefined( self.script_turrets ) )
    {
        allowed_turrets = self.script_turrets;
    }
    
    foreach ( index, turret_template in turret_templates )
    {
        if ( isdefined( turret_template.referencename ) && !issubstr( allowed_turrets, turret_template.referencename ) )
        {
            continue;
        }
        
        self.mgturret[ index ] = turretinitshared( turret_template );
    }
    
    if ( !isdefined( self.script_turretmg ) )
    {
        self.script_turretmg = 1;
    }
    
    if ( self.script_turretmg == 0 )
    {
        thread _mgoff();
        return;
    }
    
    self.script_turretmg = 1;
    thread _mgon();
}

// Namespace vehicle_code
// Params 1
// Checksum 0x9b8930f4, Offset: 0x3ac0
// Size: 0x2a1
function turretinitshared( turret_template )
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    mgangle = 0;
    
    if ( isdefined( self.script_mg_angle ) )
    {
        mgangle = self.script_mg_angle;
    }
    
    turret = spawnturret( "misc_turret", ( 0, 0, 0 ), turret_template.info );
    linkoffset = turret_template.offset_tag ?? ( 0, 0, 0 );
    parent = self;
    
    if ( isdefined( turret_template.mainturretchild ) )
    {
        if ( !isdefined( self.mainturret ) )
        {
            assertmsg( "<dev string:x16c>" + get_vehicle_classname() + "<dev string:x180>" );
        }
        
        parent = self.mainturret;
    }
    
    turret linkto( parent, turret_template.tag, linkoffset, ( 0, -1 * mgangle, 0 ) );
    bodymodel = get_vehicle_model();
    array = strtok( bodymodel, "::" );
    
    if ( array.size > 1 )
    {
        color = array[ 0 ] + "::";
    }
    else
    {
        color = "";
    }
    
    turret setmodel( color + turret_template.model );
    turret.angles = self.angles;
    turret.isvehicleattached = 1;
    turret.ownervehicle = self;
    turret.weaponinfo = turret_template.info;
    assert( isdefined( self.script_team ) );
    turret.script_team = self.script_team;
    turret makeusable();
    set_turret_team( turret );
    level thread vehicle_turret_difficulty( turret, utility::getdifficulty() );
    
    if ( isdefined( self.script_fireondrones ) )
    {
        turret.script_fireondrones = self.script_fireondrones;
    }
    
    if ( isdefined( turret_template.deletedelay ) )
    {
        turret.deletedelay = turret_template.deletedelay;
    }
    
    if ( isdefined( turret_template.defaultdroppitch ) )
    {
        turret setdefaultdroppitch( turret_template.defaultdroppitch );
    }
    
    if ( isdefined( turret_template.referencename ) )
    {
        turret.referencename = turret_template.referencename;
    }
    
    if ( isdefined( turret_template.defaultonmode ) )
    {
        turret turret_set_default_on_mode( turret_template.defaultonmode );
    }
    
    return turret;
}

// Namespace vehicle_code
// Params 2
// Checksum 0xe5351793, Offset: 0x3d6a
// Size: 0xbf
function vehicle_turret_difficulty( turret, difficulty )
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    turret.convergencetime = level.mgturretsettings[ difficulty ][ "convergenceTime" ];
    turret.suppressiontime = level.mgturretsettings[ difficulty ][ "suppressionTime" ];
    turret.accuracy = level.mgturretsettings[ difficulty ][ "accuracy" ];
    turret.aispread = level.mgturretsettings[ difficulty ][ "aiSpread" ];
    turret.playerspread = level.mgturretsettings[ difficulty ][ "playerSpread" ];
}

// Namespace vehicle_code
// Params 1
// Checksum 0x347a9430, Offset: 0x3e31
// Size: 0x17
function turret_set_default_on_mode( defaultonmode )
{
    self.defaultonmode = defaultonmode;
}

// Namespace vehicle_code
// Params 1
// Checksum 0xd005687f, Offset: 0x3e50
// Size: 0xc7
function set_turret_team( turret )
{
    switch ( self.script_team )
    {
        case #"hash_5f54b9bf7583687f":
        case #"hash_ecada18a31eceade":
            turret setturretteam( "allies" );
            break;
        case #"hash_3e323a3a6f36e18b":
        case #"hash_7c2d091e6337bf54":
            turret setturretteam( "axis" );
            break;
        case #"hash_24b14065e10b1f8d":
            turret setturretteam( "team3" );
            break;
        case #"hash_a571cacc018623b8":
            turret setturretteam( "neutral" );
            break;
        default:
            assertmsg( "<dev string:x1d4>" + self.script_team );
            break;
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0x528b5004, Offset: 0x3f1f
// Size: 0x70
function vehicle_setteam()
{
    classname = get_vehicle_classname();
    
    if ( !isdefined( self.script_team ) && isdefined( level.vehicle.templates.team[ classname ] ) )
    {
        self.script_team = level.vehicle.templates.team[ classname ];
    }
}

// Namespace vehicle_code
// Params 1
// Checksum 0x3195133e, Offset: 0x3f97
// Size: 0x9b
function get_vehiclenode_any_dynamic( target )
{
    path_start = getvehiclenode( target, #targetname );
    
    if ( !isdefined( path_start ) )
    {
        path_start = getent( target, #targetname );
    }
    else if ( vehicle::ishelicopter() )
    {
        /#
            println( "<dev string:x1ea>" + path_start.targetname );
            println( "<dev string:x207>" + self.vehicletype );
        #/
        
        assertmsg( "<dev string:x215>" );
    }
    
    if ( !isdefined( path_start ) )
    {
        path_start = utility::getstruct( target, "targetname" );
    }
    
    return path_start;
}

// Namespace vehicle_code
// Params 1
// Checksum 0x949c0a29, Offset: 0x403b
// Size: 0x69, Type: bool
function vehicle_isalive( vehicle )
{
    assert( !vehicle::is_common_vehicle(), "<dev string:x46>" );
    
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( vehicle.health < vehicle.healthbuffer )
    {
        return false;
    }
    
    if ( vehicle.health <= 0 )
    {
        return false;
    }
    
    if ( vehicle.isvehiclehusk )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x14eae456, Offset: 0x40ad
// Size: 0x58
function vehicle_pathdetach()
{
    self.attachedpath = undefined;
    self notify( #"newpath" );
    
    if ( vehicle::ishelicopter() )
    {
        self setgoalyaw( utility::flat_angle( self.angles )[ 1 ] );
        self setvehgoalpos( self.origin + ( 0, 0, 4 ), 1 );
    }
}

// Namespace vehicle_code
// Params 0
// Checksum 0xed9b841c, Offset: 0x410d
// Size: 0x185
function get_vehicle_riders_spawners()
{
    spawners = [];
    
    if ( isdefined( self.target ) )
    {
        targets = utility::noself_func_return( "getspawnerarray", self.target );
        
        if ( !isdefined( targets ) )
        {
            targets = utility::getstructarray( self.target, "targetname" );
        }
        
        if ( !isdefined( targets ) )
        {
            targets = [];
        }
        
        foreach ( target in targets )
        {
            if ( isstruct( target ) )
            {
                if ( !isdefined( target.script_demeanor ) )
                {
                    continue;
                }
            }
            else
            {
                if ( !issubstr( target.code_classname, "actor" ) && !issubstr( target.code_classname, "vehicle" ) )
                {
                    continue;
                }
                
                if ( issubstr( target.code_classname, "actor" ) )
                {
                    if ( !isspawner( target ) )
                    {
                        continue;
                    }
                    else if ( issubstr( target.code_classname, "vehicle" ) )
                    {
                        if ( !( target.spawnflags & 2 ) )
                        {
                            continue;
                        }
                    }
                }
            }
            
            if ( isdefined( target.dont_auto_ride ) )
            {
                continue;
            }
            
            spawners[ spawners.size ] = target;
        }
    }
    
    return spawners;
}

// Namespace vehicle_code
// Params 0
// Checksum 0xdf012c67, Offset: 0x429b
// Size: 0x48
function helicopter_unloading_watcher()
{
    if ( !vehicle::ishelicopter() )
    {
        return;
    }
    
    self endon( #"vehicle_crashdone" );
    self waittill( #"unloading" );
    self.unloading = 1;
    self waittill( #"unloaded" );
    self.unloading = undefined;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x290d9518, Offset: 0x42eb
// Size: 0x14, Type: bool
function vehicle_iscorpse()
{
    return isdefined( self ) && get_vehicle_classname() == "script_vehicle_corpse";
}

// Namespace vehicle_code
// Params 0
// Checksum 0x4be6d205, Offset: 0x4308
// Size: 0x77
function detach_getoutrigs()
{
    if ( !isdefined( self.fastroperig ) )
    {
        return;
    }
    
    if ( !self.fastroperig.size )
    {
        return;
    }
    
    keys = getarraykeys( self.fastroperig );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( isdefined( self.fastroperig[ keys[ i ] ] ) )
        {
            self.fastroperig[ keys[ i ] ] unlink();
        }
    }
}

// Namespace vehicle_code
// Params 4
// Checksum 0x39994960, Offset: 0x4387
// Size: 0x37b
function vehicle_huskLaunch( parent, vehicleref, spawndata, forcemultiplier )
{
    if ( vehicle::is_static() || !self vehicle_isphysveh() )
    {
        return;
    }
    
    if ( isdefined( parent ) && parent.p2phusk )
    {
        return;
    }
    
    if ( isdefined( parent ) && parent.headondeath )
    {
        return;
    }
    
    if ( isdefined( parent ) && isdefined( parent.damageinfo ) )
    {
        damagestrength = parent.damageinfo[ "amount" ];
        damagedir = parent.damageinfo[ "direction_vec" ];
        damagelocation = parent.damageinfo[ "damageLocation" ];
        damagemod = parent.damageinfo[ "MOD" ];
    }
    else
    {
        damagestrength = 600;
        damagedir = undefined;
        damagelocation = self.origin;
        damagemod = "";
    }
    
    if ( isdefined( parent ) && isdefined( parent.var_52e328d5399ca9af ) && gettime() - parent.var_52e328d5399ca9af < 1000 )
    {
        if ( getdvarint( @"scr_vehicle_damage_debug" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x248>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        damagestrength *= 0.1;
    }
    
    if ( isdefined( damagedir ) )
    {
        damagedir = ( damagedir[ 0 ], damagedir[ 1 ], 0.25 );
    }
    else
    {
        damagedir = ( randomfloatrange( -0.25, 0.25 ), randomfloatrange( -0.25, 0.25 ), 0.25 );
    }
    
    launchstrength = function_1aaf8ca18b62a037( damagestrength, damagemod, damagelocation, 0.3 );
    
    if ( isdefined( forcemultiplier ) )
    {
        launchstrength *= forcemultiplier;
    }
    
    if ( isdefined( vehicleref ) && isdefined( level.sharedfuncs[ vehicleref ] ) )
    {
        if ( utility::issharedfuncdefined( vehicleref, #"vehicle_husklaunch", 0 ) )
        {
            vehicle_husklaunchoverride = utility::getsharedfunc( vehicleref, #"vehicle_husklaunch" );
            self [[ vehicle_husklaunchoverride ]]( spawndata.initialvelocity );
            
            if ( isdefined( self.damagedir ) )
            {
                damagedir = self.damagedir;
            }
            
            if ( isdefined( self.launchstrength ) )
            {
                launchstrength = self.launchstrength;
            }
        }
    }
    
    self vehphys_impulse( damagedir, launchstrength, 1 );
    
    if ( getdvarint( @"scr_vehicle_damage_debug" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 6 ), "<dev string:x27b>" + gettime(), ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 3 ), "<dev string:x282>" + launchstrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 0 ), "<dev string:x299>" + self getconfigvalue( "<dev string:x2a0>" ) + "<dev string:x2a5>" + damagestrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        utility::draw_arrow_time( damagelocation, damagelocation + anglestoforward( vectortoangles( damagedir ) ) * launchstrength, ( 1, 0, 1 ), 1000 );
    }
    
    self.var_52e328d5399ca9af = gettime();
}

// Namespace vehicle_code
// Params 4
// Checksum 0x3ac5abb9, Offset: 0x470a
// Size: 0x31e
function vehicle_explosionlaunch( amount, damagedir, damagelocation, meansofdeath )
{
    if ( !self vehicle_isphysveh() )
    {
        return;
    }
    
    if ( self.isstationary )
    {
        if ( getdvarint( @"scr_vehicle_damage_debug" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x2b3>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    if ( self.healthactual <= self.healthbuffer + 1 )
    {
        if ( getdvarint( @"scr_vehicle_damage_debug" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x2cf>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    if ( isdefined( self.parentlaunchtime ) && gettime() - self.parentlaunchtime < 1000 )
    {
        if ( getdvarint( @"scr_vehicle_damage_debug" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x2ec>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        amount *= 0.1;
    }
    
    if ( !isdefined( self.var_52e328d5399ca9af ) )
    {
        self.var_52e328d5399ca9af = gettime();
    }
    else if ( gettime() - self.var_52e328d5399ca9af < 1000 )
    {
        if ( getdvarint( @"scr_vehicle_damage_debug" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x321>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        amount *= 0.1;
    }
    
    launchstrength = function_1aaf8ca18b62a037( amount, meansofdeath, damagelocation );
    damagedir = ( damagedir[ 0 ], damagedir[ 1 ], 0.25 );
    self vehphys_impulse( damagedir, launchstrength, 1 );
    
    if ( getdvarint( @"scr_vehicle_damage_debug" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 6 ), "<dev string:x27b>" + gettime() + "<dev string:x34f>" + self.var_52e328d5399ca9af, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 3 ), "<dev string:x36a>" + launchstrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 0 ), "<dev string:x299>" + self getconfigvalue( "<dev string:x2a0>" ) + "<dev string:x2a5>" + amount, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        utility::draw_arrow_time( damagelocation, damagelocation + anglestoforward( vectortoangles( damagedir ) ) * launchstrength, ( 1, 0, 1 ), 1000 );
    }
    
    self.var_52e328d5399ca9af = gettime();
}

// Namespace vehicle_code
// Params 4
// Checksum 0xd748da04, Offset: 0x4a30
// Size: 0x12b
function function_1aaf8ca18b62a037( amount, meansofdeath, damagelocation, launchscalar = 1 )
{
    amount = amount > 600 ? 600 : amount;
    
    if ( isdefined( meansofdeath ) )
    {
        meansofdeath = tolower( meansofdeath );
        
        if ( meansofdeath == "mod_projectile_splash" )
        {
            amount *= 0.75;
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        amount *= 0.1;
    }
    
    mass = self getconfigvalue( "mass" );
    maxlaunchstrength = mass * 0.1 * launchscalar;
    normalizedamount = math::normalize_value( 600, 0, amount );
    launchstrength = maxlaunchstrength * normalizedamount;
    launchstrength = min( launchstrength, 16250 );
    
    if ( getdvarint( @"scr_vehicle_damage_debug" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 9 ), "<dev string:x380>" + amount + "<dev string:x397>" + normalizedamount, ( 0, 1, 0 ), 1, 0.2, 1000, 1 );
        #/
    }
    
    return launchstrength;
}

// Namespace vehicle_code
// Params 0
// Checksum 0x1aa22ff0, Offset: 0x4b64
// Size: 0x18a
function function_123d1d60a34593b()
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( !self getscriptablehaspart( "flag" ) )
    {
        return;
    }
    
    assert( self getscriptableparthasstate( "<dev string:x3ab>", "<dev string:x3b0>" ) );
    assert( self getscriptableparthasstate( "<dev string:x3ab>", "<dev string:x3b5>" ) );
    assert( self getscriptableparthasstate( "<dev string:x3ab>", "<dev string:x3bc>" ) );
    assert( self getscriptableparthasstate( "<dev string:x3ab>", "<dev string:x3c1>" ) );
    speedsqfast = squared( 616 );
    speedsqmedium = squared( 123.2 );
    speedsqslow = squared( 35.2 );
    state = self getscriptablepartstate( "flag" );
    
    while ( true )
    {
        self waittill( #"player_enter" );
        
        while ( true )
        {
            prevstate = state;
            speedsquared = lengthsquared( self vehicle_getvelocity() );
            
            if ( speedsquared > speedsqfast )
            {
                state = "fast";
            }
            else if ( speedsquared > speedsqmedium )
            {
                state = "medium";
            }
            else if ( speedsquared > speedsqslow )
            {
                state = "slow";
            }
            else
            {
                state = "stopped";
            }
            
            if ( prevstate != state )
            {
                self setscriptablepartstate( "flag", state );
            }
            
            if ( speedsquared < 1 && vehicle_occupancy::get_all_occupants( self ).size == 0 )
            {
                break;
            }
            
            wait 0.1;
        }
    }
}

/#

    // Namespace vehicle_code
    // Params 0
    // Checksum 0xfee7261d, Offset: 0x4cf6
    // Size: 0x3e7, Type: dev
    function init_vehicle_spawn_devgui()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        wait 5;
        setdvarifuninitialized( @"scr_vehiclefriendlydamage", 0 );
        setdvarifuninitialized( @"scr_vehicle_spawn_broken", 0 );
        setdvarifuninitialized( @"scr_vehicle_spawn_husk", 0 );
        devgui::function_9082edeb5db93280( "<dev string:x3c9>" );
        
        foreach ( vehicleref in utility::alphabetize( vehicle::function_75acd2d48a8f3605( 0 ) ) )
        {
            data = vehicle::get_data( vehicleref );
            
            if ( data.iswondervehicle )
            {
                if ( !isdefined( level.wonder_veh ) )
                {
                    category = "<dev string:x3d9>";
                    devgui::add_devgui_command( category + vehicleref + "<dev string:x3ea>", "<dev string:x3f1>" + vehicleref, 1 );
                    devgui::add_devgui_command( category + vehicleref + "<dev string:x40f>", "<dev string:x418>" + vehicleref, 2 );
                }
                
                continue;
            }
            
            category = "<dev string:x438>";
            
            if ( data.canfly )
            {
                category = "<dev string:x447>";
            }
            else if ( data.isboat )
            {
                category = "<dev string:x455>";
            }
            else if ( data.istank )
            {
                category = "<dev string:x465>";
            }
            
            if ( isstartstr( data.ref, "<dev string:x474>" ) )
            {
                category += "<dev string:x479>";
            }
            else if ( isstartstr( data.ref, "<dev string:x47e>" ) )
            {
                category += "<dev string:x486>";
            }
            else if ( isstartstr( data.ref, "<dev string:x48b>" ) )
            {
                category += "<dev string:x493>";
            }
            else if ( isstartstr( data.ref, "<dev string:x498>" ) )
            {
                category += "<dev string:x4a0>";
            }
            else if ( isstartstr( data.ref, "<dev string:x4a5>" ) )
            {
                category += "<dev string:x4ad>";
            }
            else if ( isstartstr( data.ref, "<dev string:x4b2>" ) )
            {
                category += "<dev string:x4ba>";
            }
            
            devgui::add_devgui_command( category + vehicleref + "<dev string:x3ea>", "<dev string:x4bf>" + vehicleref, 1 );
            devgui::add_devgui_command( category + vehicleref + "<dev string:x40f>", "<dev string:x4d7>" + vehicleref, 2 );
            devgui::add_devgui_command( category + vehicleref + "<dev string:x4f1>", "<dev string:x4fe>" + vehicleref, 3 );
            devgui::add_devgui_command( category + vehicleref + "<dev string:x51b>", "<dev string:x3f1>" + vehicleref, 3 );
            devgui::add_devgui_command( category + vehicleref + "<dev string:x52e>", "<dev string:x418>" + vehicleref, 4 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x543>" );
        devgui::add_devgui_command( "<dev string:x563>", "<dev string:x575>" );
        devgui::add_devgui_command( "<dev string:x594>", "<dev string:x5a7>" );
        devgui::add_devgui_command( "<dev string:x5c6>", "<dev string:x5db>" );
        devgui::add_devgui_command( "<dev string:x5fa>", "<dev string:x610>" );
        devgui::add_devgui_command( "<dev string:x62f>", "<dev string:x643>" );
        devgui::add_devgui_command( "<dev string:x662>", "<dev string:x679>" );
        devgui::add_devgui_command( "<dev string:x69a>", "<dev string:x6b2>" );
        devgui::add_devgui_command( "<dev string:x6d3>", "<dev string:x6e8>" );
        devgui::add_devgui_command( "<dev string:x706>", "<dev string:x71b>" );
        devgui::add_devgui_command( "<dev string:x739>", "<dev string:x74e>" );
        devgui::add_devgui_command( "<dev string:x76c>", "<dev string:x781>" );
        devgui::add_devgui_command( "<dev string:x79f>", "<dev string:x7b4>" );
        devgui::add_devgui_command( "<dev string:x7d2>", "<dev string:x7e7>" );
        devgui::function_77df7fe7dd273e10();
        level thread watch_devgui_spawn();
    }

    // Namespace vehicle_code
    // Params 0, eflags: 0x4
    // Checksum 0x14ae4158, Offset: 0x50e5
    // Size: 0x97d, Type: dev
    function private watch_devgui_spawn()
    {
        while ( true )
        {
            vehicleref = getdvar( @"scr_spawnvehicle", "<dev string:x805>" );
            
            if ( vehicleref != "<dev string:x805>" )
            {
                player = level.players[ 0 ];
                
                if ( isdefined( player ) )
                {
                    if ( vehicle_airdrop::can_airdrop( vehicleref ) )
                    {
                        spawndata = spawnstruct();
                        spawndata.origin = player.origin + ( 0, 0, 100 );
                        spawndata.angles = player.angles * ( 0, 1, 0 );
                        spawndata.spawntype = "<dev string:x806>";
                        level.var_53ee440e883f18de = level vehicle_airdrop::vehicle_airdrop( vehicleref, spawndata );
                    }
                    else
                    {
                        if ( player vehicle::is_in_vehicle( 1 ) && getdvarint( @"hash_8af4302fef6d5e56" ) )
                        {
                            player.vehicle.dontspawnhusk = 1;
                            vehicle::death( player.vehicle );
                        }
                        
                        level.var_53ee440e883f18de = player vehicle::spawn_player_in_vehicle( vehicleref );
                    }
                }
                
                setdevdvar( @"scr_spawnvehicle", "<dev string:x805>" );
            }
            
            vehicleref = getdvar( @"hash_cf0e276f8c922946", "<dev string:x805>" );
            
            if ( vehicleref != "<dev string:x805>" )
            {
                setdevdvar( @"hash_cf0e276f8c922946", "<dev string:x805>" );
                color = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
                
                foreach ( spawn in vehicle_spawn::get_spawn_structs( vehicleref, undefined, [] ) )
                {
                    sphere( spawn.origin, 80, color, 0, 10000 );
                    
                    if ( spawn.angles )
                    {
                        utility::draw_angles( spawn.angles, spawn.origin, undefined, 10000, 20 );
                    }
                    
                    heightoffset = ( 0, 0, 0 );
                    
                    foreach ( flag, name in [ 12:"<dev string:x8b0>", 11:"<dev string:x89c>", 10:"<dev string:x88d>", 9:"<dev string:x87b>", 8:"<dev string:x86b>", 7:"<dev string:x85b>", "<dev string:x852>", 5:"<dev string:x84d>", 4:"<dev string:x836>", 3:"<dev string:x829>", 2:"<dev string:x818>", 1:"<dev string:x80d>" ] )
                    {
                        if ( spawn vehicle_spawn::has_flag( flag ) )
                        {
                            print3d( spawn.origin + heightoffset, name, color, 1, 1, 10000, 1 );
                            heightoffset += ( 0, 0, 20 );
                        }
                    }
                    
                    print3d( spawn.origin + heightoffset, vehicleref, color, 1, 2, 10000, 1 );
                }
            }
            
            host = function_711615b269dcc3c();
            
            if ( !isdefined( host ) )
            {
                waitframe();
                continue;
            }
            
            if ( getdvarint( @"hash_fd6e0935fce9f345", 0 ) == 1 )
            {
                setdvar( @"hash_fd6e0935fce9f345", 0 );
                closestspawn = sortbydistancecullbyradius( vehicle_spawn::get_all_spawn_structs(), host.origin, 3000 )[ 0 ];
                
                if ( closestspawn )
                {
                    closestspawn vehicle::function_dcbcdc00863e94d6();
                }
            }
            
            forward = anglestoforward( host.angles );
            vehicleref = getdvar( @"scr_audio_spawnvehicle", "<dev string:x805>" );
            
            if ( vehicleref != "<dev string:x805>" )
            {
                setdevdvar( @"scr_audio_spawnvehicle", "<dev string:x805>" );
                spawnposition = host.origin + ( 0, 0, 100 ) + forward * 300;
                spawnangles = host.angles * ( 0, 1, 0 );
                vehicle = undefined;
                spawndata = spawnstruct();
                spawndata.origin = spawnposition;
                spawndata.angles = spawnangles;
                spawndata.spawntype = "<dev string:x806>";
                [ vehicle, seatid ] = vehicle::function_48833bc196a87e8c( vehicleref, spawndata );
                level.var_53ee440e883f18de = vehicle;
                
                if ( getdvarint( @"hash_19956db1f58cf7c", 0 ) == 1 )
                {
                    vehicle function_edc1329b6c257a41( spawnposition, forward );
                }
                else
                {
                    vehicle addcomponent( "<dev string:x8c2>" );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8c6>", 1 );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8d2>", 1 );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8e6>", 300 );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8f4>", 1 );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x907>", 0.5 );
                    vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x918>", 4 );
                }
                
                vehicle vehicle_turnengineon();
                
                if ( !isdefined( level.devvehicles ) )
                {
                    level.devvehicles = [ vehicle ];
                }
                else
                {
                    level.devvehicles[ level.devvehicles.size ] = vehicle;
                }
            }
            
            drivedvar = getdvarint( @"scr_audio_drive", 0 );
            
            if ( isdefined( level.devvehicles ) && drivedvar )
            {
                setdevdvar( @"scr_audio_drive", 0 );
                
                foreach ( vehicle in level.devvehicles )
                {
                    switch ( drivedvar )
                    {
                        case 2:
                            if ( vehicle.vehiclename == "<dev string:x92b>" || vehicle.vehiclename == "<dev string:x937>" )
                            {
                                break;
                            }
                            
                            direction = vectornormalize( vehicle.origin - host.origin );
                            endpoint = direction * 3000 + vehicle.origin;
                            vehicle thread vehicle_ai::function_1a6c0d0264fdd63c( vehicle.origin, endpoint, 300 );
                            break;
                        case 1:
                            if ( vehicle.vehiclename == "<dev string:x92b>" || vehicle.vehiclename == "<dev string:x937>" )
                            {
                                break;
                            }
                            
                            direction = vectornormalize( host.origin - vehicle.origin );
                            endpoint = direction * -300 + host.origin;
                            vehicle thread vehicle_ai::function_1a6c0d0264fdd63c( vehicle.origin, endpoint, 300 );
                            break;
                        case 3:
                            vehicle notify( #"path_updated" );
                            vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x946>", 0 );
                            vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8c6>", 1 );
                            vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x952>", vehicle.origin );
                            vehicle stoppath();
                            vehicle vehicle_setspeedimmediate( 0, 1, 1 );
                            vehicle vehicle_cleardrivingstate();
                            break;
                        default:
                            break;
                    }
                }
            }
            
            destroydvar = getdvar( @"hash_aba9a0c99545e4f6", "<dev string:x805>" );
            
            if ( destroydvar != "<dev string:x805>" && isdefined( level.devvehicles ) )
            {
                setdevdvar( @"hash_aba9a0c99545e4f6", "<dev string:x805>" );
                
                foreach ( index, vehicle in level.devvehicles )
                {
                    if ( vehicle.vehiclename == destroydvar )
                    {
                        level.devvehicles[ index ] = undefined;
                        vehicle notify( #"path_updated" );
                        vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x946>", 0 );
                        vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x8c6>", 1 );
                        vehicle setconfigvalue( "<dev string:x8c2>", "<dev string:x952>", vehicle.origin );
                        vehicle stoppath();
                        vehicle vehicle_setspeedimmediate( 0, 1, 1 );
                        vehicle vehicle_cleardrivingstate();
                        break;
                    }
                }
                
                setdvar( @"hash_37b6962333b896f9", destroydvar );
            }
            
            waitframe();
        }
    }

    // Namespace vehicle_code
    // Params 0, eflags: 0x4
    // Checksum 0xe4d7cb6d, Offset: 0x5a6a
    // Size: 0xc0, Type: dev
    function private function_711615b269dcc3c()
    {
        if ( !isdefined( level.players ) )
        {
            return;
        }
        
        hostplayer = undefined;
        
        foreach ( player in level.players )
        {
            if ( isplayer( player ) && player utility::callsharedfunc( #"player", #"ishost" ) )
            {
                hostplayer = player;
                break;
            }
        }
        
        return hostplayer;
    }

    // Namespace vehicle_code
    // Params 0
    // Checksum 0xc256bf37, Offset: 0x5b32
    // Size: 0x225, Type: dev
    function init_vehicle_spawner_devgui()
    {
        setdvarifuninitialized( @"vehicle_spawner_vehicletype", "<dev string:x805>" );
        var_337d4e7b01c3603a = function_e102ffad881bafe9();
        ground_vehicles = [];
        water_vehicles = [];
        air_vehicles = [];
        
        if ( isdefined( var_337d4e7b01c3603a ) )
        {
            foreach ( var_c63888efdaddcd6e in var_337d4e7b01c3603a )
            {
                if ( isdefined( var_c63888efdaddcd6e.type ) && isdefined( var_c63888efdaddcd6e.model ) )
                {
                    if ( var_c63888efdaddcd6e.type == "<dev string:x95c>" )
                    {
                        ground_vehicles[ ground_vehicles.size ] = var_c63888efdaddcd6e;
                        continue;
                    }
                    
                    if ( var_c63888efdaddcd6e.type == "<dev string:x963>" )
                    {
                        water_vehicles[ water_vehicles.size ] = var_c63888efdaddcd6e;
                        continue;
                    }
                    
                    if ( var_c63888efdaddcd6e.type == "<dev string:x969>" )
                    {
                        air_vehicles[ air_vehicles.size ] = var_c63888efdaddcd6e;
                    }
                }
            }
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x96d>" );
        
        for ( index = 0; index < ground_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( ground_vehicles[ index ].vehicletype );
            devgui::function_cd4e263c1f3018ae( vehicletype, "<dev string:x98e>" + vehicletype, &function_33a8d9cc076a760 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x9af>" );
        
        for ( index = 0; index < water_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( water_vehicles[ index ].vehicletype );
            devgui::function_cd4e263c1f3018ae( vehicletype, "<dev string:x98e>" + vehicletype, &function_33a8d9cc076a760 );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x9cf>" );
        
        for ( index = 0; index < air_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( air_vehicles[ index ].vehicletype );
            devgui::function_cd4e263c1f3018ae( vehicletype, "<dev string:x98e>" + vehicletype, &function_33a8d9cc076a760 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace vehicle_code
    // Params 2
    // Checksum 0x47b35ecd, Offset: 0x5d5f
    // Size: 0x14c, Type: dev
    function function_edc1329b6c257a41( spawnposition, forward )
    {
        if ( getdvarint( @"hash_19956db1f58cf7c", 0 ) == 1 )
        {
            vehicle = self;
            var_658b3c60f55be51c = 1500 + 1000 * getdvarint( @"hash_6f7d4369d136d19a", 0 );
            vehicle.var_fe235c34c3ed8888 = spawnposition;
            vehicle.var_778ef4f53292ff6e = vehicle.origin + anglestoforward( vehicle.angles ) * var_658b3c60f55be51c;
            vehicle.distancetogoal = 50;
            vehicle.var_89739d842134105c = utility::mph_to_ips( vehicle vehicle_gettopspeedforward() );
            
            if ( vehicle vehicle::ishelicopter() )
            {
                vehicle.var_fe235c34c3ed8888 = vehicle.var_fe235c34c3ed8888 + ( 0, 100, 0 ) + forward * 300;
                vehicle.var_778ef4f53292ff6e = vehicle.var_778ef4f53292ff6e + ( 0, 100, 0 ) + forward * 300;
                vehicle.distancetogoal = 5000;
                vehicle.var_89739d842134105c /= 2;
            }
            
            vehicle thread function_3f67fe231df1c8af();
        }
    }

    // Namespace vehicle_code
    // Params 0
    // Checksum 0xbe2e00af, Offset: 0x5eb3
    // Size: 0xeb, Type: dev
    function vehicle_spawner_spawn_vehicle()
    {
        vehicletype = getdvar( @"vehicle_spawner_vehicletype", "<dev string:x805>" );
        
        if ( vehicletype != "<dev string:x805>" )
        {
            player = level.players[ 0 ];
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            forward = anglestoforward( player.angles );
            spawnposition = player.origin + ( 0, 0, 100 ) + forward * 300;
            spawnangles = player.angles * ( 0, 1, 0 );
            vehicle = spawnvehicle( undefined, "<dev string:x9ed>", vehicletype, spawnposition, spawnangles );
            
            if ( !isdefined( vehicle.interactdata ) )
            {
                vehicle makeusable();
            }
            
            vehicle function_edc1329b6c257a41( spawnposition, forward );
        }
    }

    // Namespace vehicle_code
    // Params 1
    // Checksum 0xb385036c, Offset: 0x5fa6
    // Size: 0x42, Type: dev
    function function_33a8d9cc076a760( param )
    {
        vehicletype = param[ 0 ];
        setdvar( @"vehicle_spawner_vehicletype", vehicletype );
        iprintln( "<dev string:xa01>" + vehicletype );
        vehicle_spawner_spawn_vehicle();
    }

    // Namespace vehicle_code
    // Params 0
    // Checksum 0x970b3ea4, Offset: 0x5ff0
    // Size: 0x169, Type: dev
    function function_3f67fe231df1c8af()
    {
        targetposition = self.var_fe235c34c3ed8888;
        self endon( #"death" );
        
        while ( true )
        {
            if ( !self hascomponent( "<dev string:x8c2>" ) )
            {
                if ( targetposition == self.var_fe235c34c3ed8888 )
                {
                    targetposition = self.var_778ef4f53292ff6e;
                }
                else
                {
                    targetposition = self.var_fe235c34c3ed8888;
                }
                
                println( "<dev string:xa1c>" + targetposition );
                var_c5331c6576c90dfe = getdvarint( @"hash_fd46728789917a5", 0 ) == 1;
                self addcomponent( "<dev string:x8c2>" );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:x8c6>", 1 );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:xa2d>", 0 );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:x952>", targetposition );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:x946>", self.var_89739d842134105c );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:xa38>", var_c5331c6576c90dfe );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:x8e6>", 25 );
                self setconfigvalue( "<dev string:x8c2>", "<dev string:xa4d>", 0.5 );
            }
            else
            {
                if ( distance2dsquared( self.origin, targetposition ) <= self.distancetogoal )
                {
                    self removecomponent( "<dev string:x8c2>" );
                }
                
                println( "<dev string:xa62>" + distance2dsquared( self.origin, targetposition ) );
            }
            
            waitframe();
        }
    }

#/
