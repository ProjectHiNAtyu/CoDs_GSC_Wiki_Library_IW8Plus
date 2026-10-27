// scripts\vehicle\pluto\pluto_shared.gsc  (hash_2ed27b7aecded97e.gscc) (size: 22766 Bytes / 0x58ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb16e4c7b (2976795771)
// size ...... 22766 (0x58ee)
// includes .. 23  (offset: 0x53fe)
// strings ... 65  (offset: 0x54b6)
// dev strs .. 9   (offset: 0x5882)
// exports ... 52  (offset: 0x3636)
// cseg ...... 0x530 + 0x3106 (0x3636)
// imports ... 178 (offset: 0x3e56)
// animtree1 . 0   (offset: 0x58ee)
// animtree2 . 0   (offset: 0x58ee)
#using script_54d7585f0a1791e6;
#using script_61b40095fd0502f0;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\smart_seeker;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\weapons\lightning_chain;
#using scripts\mp\vehicles\damage;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;
#using scripts\vehicle\pluto\pluto_repair;
#using scripts\vehicle\pluto\pluto_sheds;
#using scripts\vehicle\pluto\pluto_upgrades;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0xb5d21600, Offset: 0x54e
// Size: 0x13b
function function_bdd68e56b5bb1269()
{
    if ( game_utility::function_21211f3255f8ea58() )
    {
        var_8356fac0d335ea17 = getscriptbundlenames( "zmsurvivalsettings" );
        var_5f49b6035f1a566b = getscriptbundle( var_8356fac0d335ea17[ 0 ] );
        map_name = level.mapname ?? level.mapinfobundle.mapname;
        poi_name = getdvar( hashcat( @"scr_", map_name, "_survival_poi" ) );
        
        foreach ( info in var_5f49b6035f1a566b.var_47377ab0cfa0e815 )
        {
            if ( info.poiname == poi_name )
            {
                return ( info.var_15d3a9f5e2036837 || !level.gametypebundle.disablewondervehicle );
            }
        }
        
        return 0;
    }
    
    return !level.gametypebundle.disablewondervehicle;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xfe8f8707, Offset: 0x691
// Size: 0xdf
function private function_e3f25747ea0e8d93()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    vehicle::generic_init( %"hash_62a07b56f29782f5" );
    utility::registersharedfunc( %"hash_62a07b56f29782f5", #"spawn", &wonderveh_spawn );
    utility::registersharedfunc( #"vehicle", #"hash_c91a9f6e5e3f772f", &function_7733ded1b54aab10 );
    leveldatafordamagestate = vehicle_damage::function_9a9c7f377e631a4d( %"hash_62a07b56f29782f5", "heavy", 1 );
    leveldatafordamagestate.onentercallback = &function_c52bf625c4dbcf75;
    leveldatafordamagestate.onexitcallback = &function_d6b73aea5c54e04b;
    damage::set_pre_mod_damage_callback( %"hash_62a07b56f29782f5", &function_a41f77207fac1bd0 );
    damage::set_post_mod_damage_callback( %"hash_62a07b56f29782f5", &function_65d1c54b9ae5e63b );
    function_978dcc37106478e();
    level thread init_repair_sheds();
    function_557ae5b6c6f6d6e5();
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0xf88da8ed, Offset: 0x778
// Size: 0x84
function private function_c52bf625c4dbcf75( oldstateref, data )
{
    speed = int( self vehicle_getspeed() );
    
    if ( speed <= 3 )
    {
        self setscriptablepartstate( "damageHeavy", "stopped", 1 );
    }
    else if ( speed <= 25 )
    {
        self setscriptablepartstate( "damageHeavy", "lowSpeed", 1 );
    }
    else
    {
        self setscriptablepartstate( "damageHeavy", "highSpeed", 1 );
    }
    
    thread vehicle_damage::function_ae99b703d6f83373( "heavy", data );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x83227176, Offset: 0x804
// Size: 0x20
function private function_d6b73aea5c54e04b( oldstateref, data )
{
    vehicle_damage::function_f60f559ead41cb86( data, 1 );
}

// Namespace pluto_veh
// Params 1
// Checksum 0xb2aa4a95, Offset: 0x82c
// Size: 0x1af
function function_978dcc37106478e( vehiclebundlehash = %"hash_62a07b56f29782f5" )
{
    turret_weapon = vehicle_occupancy::function_c1aff67bba66f89f( vehiclebundlehash, "gunner" );
    assert( isdefined( turret_weapon ), "<dev string:x24>" );
    bundledata = vehicle::get_data( vehiclebundlehash ).wondervehicle;
    level.var_101838a8465f9845 = bundledata;
    level.var_1290e4d5ec608e82 = turret_weapon;
    var_ff9dff6d5982ce27 = lightning_chain::create_lightning_chain_params( bundledata.var_4af57cb2bdf15875, bundledata.var_21ef0064f742524f, bundledata.var_d188a34e4c068753, bundledata.var_c210e50df0e39374, bundledata.var_efb7ed153cc8df3d );
    var_ff9dff6d5982ce27.var_a4b06b7d5862ddea = bundledata.var_1d1f799be05f33c9;
    var_ff9dff6d5982ce27.var_ae23bfd4b4acd418 = bundledata.var_7f26bc942ff702d1;
    var_ff9dff6d5982ce27.var_bf1f7231596f25bc = bundledata.var_775a0c7e7bf0ad11;
    var_ff9dff6d5982ce27.var_6232d6ee94f13e0f = 1;
    var_ff9dff6d5982ce27.should_gib_head = 1;
    var_ff9dff6d5982ce27.var_7a514800b212feb9 = 1;
    var_ff9dff6d5982ce27.var_fff5dc5501f9e352 = 1;
    level.var_3bcb3c1cbfd1e8fd = var_ff9dff6d5982ce27;
    level callback::add( "on_zombie_ai_damaged", &function_d45f62ecec56040 );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_1a6626fcd7fe9358 );
    }
    
    utility::registersharedfunc( #"lightning_chain", #"hash_d8c9695ff733902", &function_9c8e0c0e550b034e );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x3e317070, Offset: 0x9e3
// Size: 0x62
function private override_unresolved_collision( player, ballowsuicide )
{
    if ( !vehicle_occupancy::function_63c6c86801e0685c() )
    {
        return;
    }
    
    exit = vehicle_occupancy::function_7ce9972f31ab138b( player, self, player.origin );
    
    if ( isdefined( exit.origin ) )
    {
        player setorigin( exit.origin );
        return;
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x88a9140e, Offset: 0xa4d
// Size: 0x2d4, Type: bool
function private function_a41f77207fac1bd0( data )
{
    if ( data.victim.var_7493baa2cd62443 == 0 || data.victim.var_7493baa2cd62443 == 83 )
    {
        return false;
    }
    
    if ( isplayer( data.attacker ) )
    {
        return false;
    }
    
    current_time = gettime();
    
    if ( isdefined( data.victim.var_e80954486df087be ) && current_time - data.victim.var_e80954486df087be < 2000 )
    {
        return false;
    }
    
    data.victim.lastdamagetime = current_time;
    
    if ( data.meansofdeath == "MOD_CRUSH" )
    {
        data.victim function_10528e4104766dfb( data.damage );
        return false;
    }
    
    if ( ( isai( data.inflictor ) || isai( data.attacker ) ) && utility::issharedfuncdefined( #"veh_pluto", #"hash_17a5a9a72280815f" ) )
    {
        data.damage = data.victim utility::callsharedfunc( #"veh_pluto", #"hash_17a5a9a72280815f", data );
        playsoundatpos( data.point, #"hash_820ff06f10dff380" );
    }
    
    if ( data.victim.health <= 50 )
    {
        if ( level utility::flag( "salvage_repair_pluto" ) )
        {
            if ( data.victim.var_24544fc71ca1e2d5 + 10000 > gettime() )
            {
                return false;
            }
        }
        
        healthtoset = data.victim.secondarylife - data.damage * 1.5;
        data.victim function_d5238fe8d2eba98e( healthtoset );
        return false;
    }
    else if ( data.victim.health - data.damage <= 50 )
    {
        data.victim vehicle_damage::set_health( 50 );
        return false;
    }
    
    if ( data.victim.var_f9f14016a8fd3e1d + 2500 > data.victim.lastdamagetime )
    {
        return false;
    }
    
    if ( data.victim.secondarylife < data.victim.health )
    {
        data.victim function_d5238fe8d2eba98e( data.victim function_2d549804d691ee7() );
    }
    
    return true;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xfdf16a15, Offset: 0xd2a
// Size: 0xe, Type: bool
function private function_65d1c54b9ae5e63b( data )
{
    return true;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x1b685adb, Offset: 0xd41
// Size: 0xf6
function private function_10528e4104766dfb( damage )
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
    
    if ( normal[ 2 ] > 0.1 )
    {
        impactdot = vectordot( anglestoup( vehicle.angles ), -1 * normal );
        
        if ( impactdot < -0.8 )
        {
            damage = 0;
        }
    }
    
    if ( vehicle.health - damage <= 50 )
    {
        vehicle vehicle_damage::set_health( 50 );
        return;
    }
    
    vehicle dodamage( damage, position );
}

// Namespace pluto_veh
// Params 1
// Checksum 0x4e2d80a2, Offset: 0xe3f
// Size: 0xe, Type: bool
function function_7733ded1b54aab10( struct )
{
    return true;
}

// Namespace pluto_veh
// Params 2
// Checksum 0x1a8b1962, Offset: 0xe56
// Size: 0x11b
function wonderveh_spawn( spawndata, faildata )
{
    vehicle = vehicle::default_spawn( %"hash_62a07b56f29782f5", spawndata, faildata );
    
    if ( !vehicle )
    {
        return;
    }
    
    if ( !isdefined( level.wonder_veh ) )
    {
        level.wonder_veh = vehicle;
    }
    
    vehicle_occupancy::register_instance( vehicle );
    set_vehicle_usable_state( vehicle, 0 );
    var_a912e00d156140b8 = 0;
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_ed6bfe92f6416a79" ) )
    {
        vehicle thread utility::callsharedfunc( #"veh_pluto", #"hash_ed6bfe92f6416a79" );
    }
    
    if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_db077913b65c7469" ) )
    {
        vehicle thread utility::callsharedfunc( #"veh_pluto", #"hash_db077913b65c7469" );
    }
    else
    {
        var_a912e00d156140b8 = 1;
    }
    
    vehicle function_84ff4144ca54e126( var_a912e00d156140b8 );
    vehicle.var_e2f56f41c8d24c59 = 1;
    vehicle.unresolved_collision_func = &override_unresolved_collision;
    vehicle.var_437f0fbdb788a8fa = 1;
    return vehicle;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xd7493e94, Offset: 0xf7a
// Size: 0x203
function private function_84ff4144ca54e126( override )
{
    vehicle = self;
    vehicle.var_7493baa2cd62443 = 0;
    vehicle.stagerequested = -1;
    vehicle.var_e36cfae7a208562c = -1;
    
    if ( override )
    {
        vehicle.stagerequested = 1;
    }
    
    data = vehicle::get_data( %"hash_62a07b56f29782f5" );
    vehicle.bundledata = data.wondervehicle;
    vehicle.var_b6a3f46ec4332fd8 = 1;
    vehicle function_d5238fe8d2eba98e( vehicle function_2d549804d691ee7() );
    vehicle.startpos = vehicle.origin;
    vehicle.startangles = vehicle.angles;
    time = gettime();
    vehicle.lastdamagetime = 0;
    vehicle.var_64e6b9756c30f33a = time;
    vehicle.var_d45be1ebedba5514 = 0;
    vehicle.var_f9f14016a8fd3e1d = time;
    vehicle.var_fc023bdc1742c9fb = time;
    vehicle.turnofftimer = time;
    vehicle.var_b59ff7c648465b45 = &set_vehicle_usable_state;
    vehicle.var_2364be08b6facb67 = 1;
    vehicle setnodeploy( 1 );
    vehicle vehphys_enablecollisioncallback( 1 );
    vehicle function_5824cd07debbba4f( 1 );
    vehicle_interact::function_c9835ad3c3e5dab2( vehicle, "single_front" );
    vehicle thread function_1b5dcffbcf193d44();
    vehicle thread function_6d0f474b63483e17();
    vehicle thread function_c5cda5310d081358();
    vehicle function_7658d6a7028df58( "clear", "clear" );
    vehicle thread function_806e4dcbc16a1bdc();
    vehicle thread function_5611d4cba2c9c3df();
    vehicle thread function_329905dae292e536();
    vehicle thread function_c9702dbf624da16();
    vehicle thread function_74d3e619ff24b123();
    vehicle thread function_5a25ab73981a6cb8();
    vehicle callback::add( #"vehicle_delete", &function_684a58743f1cd34 );
    vehicle callback::callback( "on_pluto_spawned" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xbe4733d1, Offset: 0x1185
// Size: 0x80
function private function_74d3e619ff24b123()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    while ( true )
    {
        if ( self.var_7493baa2cd62443 == 83 )
        {
            if ( distance( vehicle.origin, vehicle.startpos ) > getdvarint( @"hash_d79f29fdf6d986a3", 64 ) )
            {
                vehicle function_934c783b411fa6cc( vehicle.startpos, vehicle.startangles );
            }
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x34cb616d, Offset: 0x120d
// Size: 0x35b
function private function_6d0f474b63483e17()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    while ( true )
    {
        if ( self.var_7493baa2cd62443 == 83 )
        {
            waitframe();
            continue;
        }
        
        if ( vehicle.health <= 50 )
        {
            if ( utility::issharedfuncdefined( #"veh_pluto", #"on_breakdown" ) )
            {
                vehicle utility::callsharedfunc( #"veh_pluto", #"on_breakdown" );
            }
            
            function_2d7ec1832d72a38f( vehicle, 1 );
            
            if ( isdefined( vehicle.occupants ) )
            {
                vehicle function_eb9437e8c03d6ff5();
                set_vehicle_usable_state( vehicle, 0 );
            }
            
            players_in_radius = getplayersinradius( vehicle.origin, 100, 100 );
            
            foreach ( player in players_in_radius )
            {
                if ( !isplayer( player ) || !isalive( player ) )
                {
                    continue;
                }
                
                if ( player getstance() != "crouch" && player getstance() != "prone" )
                {
                    continue;
                }
                
                player dodamage( player.maxhealth * 0.01, vehicle.origin );
            }
            
            if ( vehicle.var_861deff9d09b7d98 && !utility::flag( "firefly_boss_fight_start" ) )
            {
                var_4508c55eab7eed9c = getdvarint( @"hash_bed8944b8c86db8f", 75 );
                
                if ( distance2dsquared( vehicle.var_7c4f9d84d82ba65a, vehicle.origin ) <= var_4508c55eab7eed9c * var_4508c55eab7eed9c )
                {
                    vehicle.secondarylife = 50;
                }
                
                vehicle.var_861deff9d09b7d98 = 0;
            }
        }
        
        if ( vehicle.secondarylife <= 50 && !utility::flag( "firefly_boss_fight_start" ) )
        {
            vehicle function_bb9f7ad1d8460570();
            vehicle function_d5238fe8d2eba98e( function_2d549804d691ee7() );
        }
        
        vehicle function_e6343c0c97206da2();
        
        if ( !vehicle.blockingchecked )
        {
            vehicle childthread function_afc5c40f4c19c96c();
        }
        
        vehicle function_dac493a835ac5a17();
        
        if ( vehicle isboosting() )
        {
            all_occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle );
            
            foreach ( occupant in all_occupants )
            {
                if ( isplayer( occupant ) )
                {
                    occupant playrumbleonentity( "steady_rumble" );
                }
            }
        }
        
        if ( vehicle.occupants.size > 0 && vehicle.health > 50 )
        {
            currentdriver = vehicle_occupancy::get_driver( self );
            
            if ( isplayer( currentdriver ) )
            {
                if ( currentdriver isinvehicleleanout() )
                {
                    currentdriver val::set_array( "vehicle_occupant", [ "autoreload" ], 1 );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x3830b61c, Offset: 0x1570
// Size: 0x7e
function private function_afc5c40f4c19c96c()
{
    self notify( #"hash_22c61edfeaad7894" );
    self endon( #"hash_22c61edfeaad7894" );
    vehicle = self;
    vehicle endon( #"death" );
    vehicle.blockingchecked = 1;
    level waittill( #"hash_278e8250b8dee365", elite );
    
    if ( !utility::flag( "firefly_boss_fight_start" ) )
    {
        vehicle function_bb9f7ad1d8460570();
    }
    
    vehicle.blockingchecked = 0;
}

// Namespace pluto_veh
// Params 0
// Checksum 0xaba0da1c, Offset: 0x15f6
// Size: 0x11e
function function_eb9437e8c03d6ff5()
{
    vehicle = self;
    
    if ( !vehicle || !vehicle vehicle::is_vehicle() )
    {
        return;
    }
    
    foreach ( occupant in vehicle.occupants )
    {
        if ( !isplayer( occupant ) || !isalive( occupant ) )
        {
            continue;
        }
        
        occupant setclientomnvar( "ui_veh_show_health", 0 );
        data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
        thread vehicle_occupancy::exit( vehicle, vehicle_occupancy::get_occupant_seat( vehicle, occupant ), occupant, data, 1 );
        occupant val::reset_all( "vehicle_occupant" );
        occupant.var_505fd9d5c9a19dae = 0;
    }
    
    vehicle stopsounds();
    vehicle vehicle_occupancy::turn_engine_off();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x43ad0aac, Offset: 0x171c
// Size: 0x91
function private function_5a25ab73981a6cb8()
{
    forbidden_areas = getentarray( "oi_tessie_forbidden_area", #script_noteworthy );
    
    foreach ( area in forbidden_areas )
    {
        area thread function_2d94973770bb2af2( self );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x8d7833b, Offset: 0x17b5
// Size: 0x26
function private function_684a58743f1cd34( params )
{
    if ( self.var_fa86cbacaf912d02 )
    {
        self.var_fa86cbacaf912d02 delete();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x688b1102, Offset: 0x17e3
// Size: 0x72
function private function_2d94973770bb2af2( vehicle )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", entity );
        
        if ( entity == vehicle && !utility::flag( "firefly_boss_fight_start" ) )
        {
            vehicle function_bb9f7ad1d8460570();
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x4a85592f, Offset: 0x185d
// Size: 0x103
function private function_2d549804d691ee7()
{
    vehicle = self;
    blueprintbundle = vehicle function_8722cd990f035753();
    
    if ( !isdefined( blueprintbundle ) )
    {
        return self.bundledata.secondaryhealth;
    }
    
    blueprintdata = getscriptbundlefieldvalues( blueprintbundle, [ #"hash_eeff4c7bbfb402a1" ] );
    
    if ( !isdefined( blueprintdata.var_633105b2d512fa80 ) )
    {
        return self.bundledata.secondaryhealth;
    }
    
    round_number = minint( zm_round_logic::get_rb_round_number() ?? 1, getdvarint( @"hash_6c967e98c754a7eb", 30 ) );
    healthvalue = 100 / getdvarint( @"hash_6c967e98c754a7eb", 30 );
    bonushealth = int( blueprintdata.var_633105b2d512fa80.secondhealthbar / 100 * healthvalue * round_number );
    return blueprintdata.var_633105b2d512fa80.secondhealthbar + bonushealth;
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x18ad81aa, Offset: 0x1969
// Size: 0x3b
function private function_3f2f3b85be654fb8()
{
    self notify( #"hash_41262dc7c0e4cb2e" );
    self endon( #"hash_41262dc7c0e4cb2e" );
    self waittill( #"force_teleport" );
    println( "<dev string:x82>" );
    function_bb9f7ad1d8460570();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x8ba3a74f, Offset: 0x19ac
// Size: 0x189
function private function_e6343c0c97206da2()
{
    vehicle = self;
    
    if ( getdvarint( @"hash_93a65e1b1d18527e", 1 ) == 0 )
    {
        return;
    }
    
    vehicle thread function_3f2f3b85be654fb8();
    var_58c1e289944731a3 = 0;
    starttime = undefined;
    
    if ( vehicle vehicle_getspeed() < 5 )
    {
        pos = vehicle.origin;
        angle = math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( vehicle.angles ) );
        
        if ( angle > 45 )
        {
            starttime = gettime();
            endtime = starttime + getdvarint( @"hash_22cdf0c8e5c994b8", 10000 );
            stuckpos = vehicle.origin;
            println( "<dev string:x9d>" );
            var_821aeafda2b52f9 = 1;
            
            do
            {
                waitframe();
                angle = math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( vehicle.angles ) );
                
                if ( angle < 45 || vehicle vehicle_getspeed() > 1 && utility::function_3a444812a9926ec( stuckpos, vehicle.origin ) > 5 || level utility::flag( "warping_pluto" ) )
                {
                    var_821aeafda2b52f9 = 0;
                    println( "<dev string:xbf>" );
                    break;
                }
            }
            while ( gettime() < endtime );
        }
        
        var_58c1e289944731a3 = var_821aeafda2b52f9;
    }
    
    if ( var_58c1e289944731a3 )
    {
        println( "<dev string:xdf>" );
        vehicle function_bb9f7ad1d8460570();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x2866383, Offset: 0x1b3d
// Size: 0xf4
function private function_4ef7e9462c17178d()
{
    vehicle = self;
    
    if ( isdefined( vehicle.occupants ) )
    {
        foreach ( occupant in vehicle.occupants )
        {
            data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
            thread vehicle_occupancy::exit( vehicle, vehicle_occupancy::get_occupant_seat( vehicle, occupant ), occupant, data, 1 );
            occupant val::reset_all( "vehicle_occupant" );
            occupant.var_505fd9d5c9a19dae = 0;
        }
    }
    
    vehicle stopsounds();
    vehicle vehicle_occupancy::turn_engine_off();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xedd01fd1, Offset: 0x1c39
// Size: 0x264
function private function_bb9f7ad1d8460570()
{
    vehicle = self;
    teleport_pos = utility::getstructarray( "vehicle_respawn_point", "targetname" );
    vehicle function_4ef7e9462c17178d();
    
    if ( teleport_pos.size > 0 )
    {
        var_60ac108b6059b916 = [];
        
        for ( t = 0; t < teleport_pos.size ; t++ )
        {
            zone_struct = zone_manager::function_90e5c3e2272b0130( teleport_pos[ t ].origin );
            
            if ( zone_struct.is_enabled && zone_struct.script_zone_name != "zone_sunken_garage" )
            {
                distbetween = distance( teleport_pos[ t ].origin, vehicle.origin );
                println( "<dev string:xf0>" + t + "<dev string:x112>" + distbetween );
                
                if ( isdefined( vehicle.lastteleport ) && distance( vehicle.lastteleport.origin, teleport_pos[ t ].origin ) < 150 && !utility::flag( "firefly_boss_fight_start" ) )
                {
                    println( "<dev string:x116>" );
                    continue;
                }
                
                var_60ac108b6059b916[ var_60ac108b6059b916.size ] = teleport_pos[ t ];
            }
        }
        
        if ( var_60ac108b6059b916.size > 0 )
        {
            var_c4e4a10dff6e63eb = function_b21056d585c710d( var_60ac108b6059b916, vehicle.origin );
            vehicle.lastteleport = var_c4e4a10dff6e63eb;
        }
        else
        {
            println( "<dev string:x157>" );
            vehicle function_934c783b411fa6cc( vehicle.startpos, vehicle.startangles );
            return;
        }
        
        if ( isdefined( var_c4e4a10dff6e63eb ) )
        {
            vehicle function_934c783b411fa6cc( var_c4e4a10dff6e63eb.origin, var_c4e4a10dff6e63eb.angles );
            return;
        }
    }
    
    if ( level utility::flag( "garage_opened" ) )
    {
        vehicle function_934c783b411fa6cc( level.repairsheds[ 0 ].origin, level.repairsheds[ 0 ].angles );
        vehicle vehicle_teleport( level.repairsheds[ 0 ].origin, level.repairsheds[ 0 ].angles, 1 );
        return;
    }
    
    vehicle function_934c783b411fa6cc( vehicle.startpos, vehicle.startangles );
}

// Namespace pluto_veh
// Params 4, eflags: 0x4
// Checksum 0x204e0e73, Offset: 0x1ea5
// Size: 0x10d
function private function_20f35741e6ab262( origin, radius, mag, angles )
{
    a_players = getplayersinradius( origin, radius );
    
    foreach ( player in a_players )
    {
        truck_right = anglestoright( angles );
        var_c51215b779b5fe59 = player.origin - origin;
        var_460a5d54505d1630 = vectordot( var_c51215b779b5fe59, truck_right );
        
        if ( var_460a5d54505d1630 >= 0 )
        {
            v_knockback = truck_right;
        }
        else
        {
            v_knockback = truck_right * -1;
        }
        
        player knockback( v_knockback, mag, 1 );
    }
    
    if ( a_players.size > 0 )
    {
        return 1;
    }
}

// Namespace pluto_veh
// Params 3
// Checksum 0xa8e8f8ca, Offset: 0x1fba
// Size: 0x2cd
function function_934c783b411fa6cc( teleportpos, teleportang, var_9ca7146197d77830 = ( 0, 0, 0 ) )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    level utility::flag_waitopen( "warping_pluto" );
    level endon( #"hash_61178c06194d0605" );
    level utility::flag_set( "warping_pluto" );
    vehicle thread function_ff893250cb248325();
    vfx_pos_offset = ( 0, 0, 45 );
    in_fx_pos = teleportpos + vfx_pos_offset + var_9ca7146197d77830;
    playfx( level._effect[ "firefly_vehicle_teleport_in" ], in_fx_pos );
    playsoundatpos( in_fx_pos, #"hash_566a3821ead83944" );
    wait vehicle.bundledata.teleport_wait_time - 0.4;
    playfx( level._effect[ "firefly_vehicle_teleport_out" ], vehicle.origin );
    playsoundatpos( vehicle.origin, #"hash_2d98570ff81153e6" );
    level thread function_bf4d0ba240d25400( teleportpos );
    vehicle thread function_819f86cf6e2584d4( teleportpos, vehicle.bundledata.var_b778a8190d433900 );
    vehicle thread function_bc5e6173a86715f7( teleportpos, vehicle.bundledata.var_5fa3e73166cb9f2a, vehicle.bundledata.var_2b305a73cc92c62b, teleportang );
    wait 0.4;
    level utility::flag_set( "check_for_valid_pluto_teleport" );
    level utility::flag_waitopen_all_array( [ "pluto_teleport_equipment_check_invalid", "pluto_teleport_zombie_check_invalid", "pluto_teleport_player_check_invalid" ] );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread function_2bca6ede6622b06b( vehicle );
        }
    }
    
    sparams = { #teleportpos:teleportpos, #vehicle:vehicle };
    level callback::callback( "on_pluto_teleport", sparams );
    vehicle vehicle_teleport( teleportpos, teleportang ?? ( 0, 0, 0 ) );
    vehicle function_d5238fe8d2eba98e( vehicle function_2d549804d691ee7() );
    vehicle.var_861deff9d09b7d98 = 0;
    level notify( #"pluto_teleport_success" );
    level utility::flag_clear( "check_for_valid_pluto_teleport" );
    level utility::flag_clear( "warping_pluto" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x558f35db, Offset: 0x228f
// Size: 0x78
function private function_2bca6ede6622b06b( var_ff9973346887900c )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_8033a56a5bf3a4e4 = gettime();
    var_8ab680911d87cf5e = var_8033a56a5bf3a4e4 + getdvarint( @"hash_253d7d847975c25d", 1500 );
    
    while ( var_8033a56a5bf3a4e4 < var_8ab680911d87cf5e )
    {
        var_8033a56a5bf3a4e4 = gettime();
        
        if ( self getmovingplatformparent() == var_ff9973346887900c )
        {
            self function_a4a572d8d09b0f46();
        }
        
        wait 0.1;
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x6178e0ee, Offset: 0x230f
// Size: 0x9b
function private function_ff893250cb248325()
{
    self notify( #"hash_6e01a7b307a3a9e2" );
    self endon( #"hash_6e01a7b307a3a9e2" );
    level endon( #"game_ended" );
    level endon( #"pluto_teleport_success" );
    self endon( #"death" );
    wait getdvarint( @"hash_3c60b10bf68184c3", 5 );
    level utility::flag_clear( "check_for_valid_pluto_teleport" );
    level utility::flag_clear( "pluto_teleport_player_check_invalid" );
    level utility::flag_clear( "pluto_teleport_zombie_check_invalid" );
    level utility::flag_clear( "pluto_teleport_equipment_check_invalid" );
    level utility::flag_clear( "warping_pluto" );
    level notify( #"hash_61178c06194d0605" );
}

// Namespace pluto_veh
// Params 4, eflags: 0x4
// Checksum 0x9991303a, Offset: 0x23b2
// Size: 0xd1
function private function_bc5e6173a86715f7( teleportpos, radius, mag, teleportang )
{
    level endon( #"game_ended" );
    level endon( #"hash_61178c06194d0605" );
    self endon( #"death" );
    level utility::flag_set( "pluto_teleport_player_check_invalid" );
    
    while ( true )
    {
        if ( level utility::flag( "check_for_valid_pluto_teleport" ) )
        {
            a_players = getplayersinradius( teleportpos, radius );
            
            if ( a_players.size < 1 )
            {
                level utility::flag_clear( "pluto_teleport_player_check_invalid" );
                return;
            }
        }
        
        waitframe();
        
        if ( self.occupants.size > 0 )
        {
            function_4ef7e9462c17178d();
        }
        
        b_success = function_20f35741e6ab262( teleportpos, radius, mag, teleportang );
        
        if ( b_success )
        {
            wait 0.2;
        }
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x13a70a44, Offset: 0x248b
// Size: 0xa9
function private function_819f86cf6e2584d4( teleportpos, recycle_radius )
{
    level endon( #"game_ended" );
    level endon( #"hash_61178c06194d0605" );
    self endon( #"death" );
    level utility::flag_set( "pluto_teleport_zombie_check_invalid" );
    
    while ( true )
    {
        if ( level utility::flag( "check_for_valid_pluto_teleport" ) )
        {
            a_zombs = getaiarrayinradius( teleportpos, recycle_radius, zm_utility::get_zombie_team() );
            
            if ( a_zombs.size < 1 )
            {
                level utility::flag_clear( "pluto_teleport_zombie_check_invalid" );
                return;
            }
        }
        
        utility::callsharedfunc( #"veh_pluto", #"on_pluto_teleport", teleportpos );
        waitframe();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x528ea159, Offset: 0x253c
// Size: 0x85
function private function_bf4d0ba240d25400( teleportpos )
{
    level endon( #"game_ended" );
    level endon( #"hash_61178c06194d0605" );
    level utility::flag_set( "pluto_teleport_equipment_check_invalid" );
    
    while ( true )
    {
        if ( level utility::flag( "check_for_valid_pluto_teleport" ) )
        {
            var_354615d51ee1ac9f = function_906cab3bf305d188( teleportpos );
            
            if ( !var_354615d51ee1ac9f || var_354615d51ee1ac9f.size < 1 )
            {
                level utility::flag_clear( "pluto_teleport_equipment_check_invalid" );
                return;
            }
        }
        
        level function_e11690ba7a3649c2( teleportpos );
        waitframe();
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa5ecfd9a, Offset: 0x25c9
// Size: 0x161
function private function_906cab3bf305d188( teleportpos )
{
    equipment_in_level = level.activekillstreaks;
    equipment_in_level = arraycombineunique( equipment_in_level, weapon::function_3aafcaf7ff6dea9e() );
    
    if ( !equipment_in_level || equipment_in_level.size < 1 )
    {
        return;
    }
    
    equipment_in_level = sortbydistancecullbyradius( equipment_in_level, teleportpos, 150 );
    var_5da372bdcdfd7eb7 = [];
    
    foreach ( equipment in equipment_in_level )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            var_5da372bdcdfd7eb7[ var_5da372bdcdfd7eb7.size ] = equipment;
        }
    }
    
    return var_5da372bdcdfd7eb7;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x2feb7379, Offset: 0x2733
// Size: 0x1bc
function private function_e11690ba7a3649c2( teleportpos )
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    var_5da372bdcdfd7eb7 = function_906cab3bf305d188( teleportpos );
    
    foreach ( equipment in var_5da372bdcdfd7eb7 )
    {
        if ( equipment.equipmentref == "equip_mini_sentry" )
        {
            equipment thread mini_sentry::on_destruction();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "dawg" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread dawg::dawg_self_destruct();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "remote_turret" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment notify( #"kill_turret", 1, 1, 0, 1 );
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.streakname == "rcxd" )
        {
            equipment.owner notify( #"killstreak_cancel" );
            equipment thread rcxd_shared::rcxd_explode();
            b_valid_equipment = 1;
            continue;
        }
        
        if ( equipment.equipmentref == "equip_smart_seeker" )
        {
            equipment thread smart_seeker::function_16e1c3f278107106();
            b_valid_equipment = 1;
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x9a7e32a, Offset: 0x28f7
// Size: 0x67
function private function_c5cda5310d081358()
{
    vehicle = self;
    vehicle endon( #"death" );
    firstrun = 1;
    
    while ( true )
    {
        waitframe();
        
        if ( self.var_7493baa2cd62443 == 0 || !isdefined( self.tedd ) )
        {
            continue;
        }
        
        if ( firstrun )
        {
            firstrun = 0;
            vehicle function_f76a8a6b27dec0ae( "eyes" );
        }
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x7e0ee0d, Offset: 0x2966
// Size: 0x27
function private function_7658d6a7028df58( sfx, vfx )
{
    function_f76a8a6b27dec0ae( vfx );
    function_5d1d4ec58708e730( sfx );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xb9342fc2, Offset: 0x2995
// Size: 0x17
function private function_f76a8a6b27dec0ae( vfx )
{
    self.vfxrequest = vfx;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xd80c0cf4, Offset: 0x29b4
// Size: 0x17
function private function_5d1d4ec58708e730( audio )
{
    self.audiorequest = audio;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x8afcd581, Offset: 0x29d3
// Size: 0x55
function private function_5611d4cba2c9c3df()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        switch ( vehicle.vfxrequest )
        {
            case #"hash_d713220420f83aab":
                function_160b49e71f254868( vehicle, "playEyes" );
                break;
        }
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xff14f675, Offset: 0x2a30
// Size: 0x171
function private function_806e4dcbc16a1bdc()
{
    vehicle = self;
    vehicle endon( #"death" );
    lastaudio = [];
    var_925f51de61fb305b = 10;
    var_2d5b063da064d527 = randomint( var_925f51de61fb305b );
    
    for ( currenttime = gettime() / 1000; true ; currenttime = gettime() / 1000 )
    {
        waitframe();
        
        switch ( vehicle.audiorequest )
        {
            case #"hash_ad26743aa94a54ed":
                function_ebba03e59e4a5bfb( vehicle, "sfx_pluto_enter" );
                break;
            case #"hash_3f28cec865ad2857":
                function_ebba03e59e4a5bfb( vehicle, "sfx_pluto_upgrade" );
                break;
            case #"hash_1081b0150beddbb8":
                function_ebba03e59e4a5bfb( vehicle, "sfx_pluto_autoheal" );
                break;
            case #"hash_2509d98b32b48244":
                function_ebba03e59e4a5bfb( vehicle, "sfx_pluto_breakdown" );
                break;
            case #"hash_611825599f1b56f9":
                if ( !isdefined( lastaudio[ "kill" ] ) || currenttime > lastaudio[ "kill" ] + 20 )
                {
                    if ( var_2d5b063da064d527 == randomint( var_925f51de61fb305b ) || var_925f51de61fb305b == 1 )
                    {
                        lastaudio[ "kill" ] = currenttime;
                        function_ebba03e59e4a5bfb( vehicle, "sfx_pluto_kill" );
                        var_925f51de61fb305b = 10;
                        var_2d5b063da064d527 = randomint( var_925f51de61fb305b );
                    }
                    else
                    {
                        var_925f51de61fb305b--;
                        var_2d5b063da064d527 = randomint( var_925f51de61fb305b );
                    }
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0xc9548823, Offset: 0x2ba9
// Size: 0x37
function private function_160b49e71f254868( vehicle, var_827a2a5369774085 )
{
    vehicle utility::function_7c10ea82c1e305b8( "VFX", var_827a2a5369774085 );
    function_f76a8a6b27dec0ae( "clear" );
    wait 1.5;
}

// Namespace pluto_veh
// Params 3, eflags: 0x4
// Checksum 0xf62b92ce, Offset: 0x2be8
// Size: 0x59
function private function_ebba03e59e4a5bfb( vehicle, var_edf094f6f941163a, vo_sound_alias )
{
    level endon( #"game_ended" );
    vehicle endon( #"death" );
    vehicle utility::function_7c10ea82c1e305b8( "playVO", var_edf094f6f941163a );
    function_5d1d4ec58708e730( "clear" );
    wait 1.5;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x7b08353a, Offset: 0x2c49
// Size: 0xc8
function private function_329905dae292e536()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.enginelightson )
        {
            utility::function_7c10ea82c1e305b8( "exhaustFX", "exhaust_on" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "exhaustFX", "exhaust_off" );
        }
        
        if ( self function_b27c8f8886ef1042() || self vehicle_getinputvalue( 1 ) != 0 )
        {
            utility::function_7c10ea82c1e305b8( "tag_light_back_left", "on" );
            utility::function_7c10ea82c1e305b8( "tag_light_back_right", "on" );
            self.var_5a9b5363aafb3d3d = 1;
            continue;
        }
        
        if ( !utility::ent_flag( "tedd_angry_lights" ) )
        {
            utility::function_7c10ea82c1e305b8( "tag_light_back_left", "off" );
            utility::function_7c10ea82c1e305b8( "tag_light_back_right", "off" );
        }
        
        self.var_5a9b5363aafb3d3d = 0;
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x58f450c0, Offset: 0x2d19
// Size: 0x17
function private function_d5238fe8d2eba98e( var_c5c83c527ea95c00 )
{
    self.secondarylife = var_c5c83c527ea95c00;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x4c71d152, Offset: 0x2d38
// Size: 0x3a8
function private function_dac493a835ac5a17()
{
    vehicle = self;
    
    switch ( vehicle.var_7493baa2cd62443 )
    {
        case 2:
            autohealstarttime = vehicle.bundledata.var_d99d8fdcbb1fc573;
            break;
        case 3:
            autohealstarttime = vehicle.bundledata.var_d99d8edcbb1fc340;
            break;
        case 4:
            autohealstarttime = vehicle.bundledata.var_d99d95dcbb1fd2a5;
            break;
        default:
            autohealstarttime = vehicle.bundledata.var_fe1fbd81dbf2ff5d;
            break;
    }
    
    autohealstarttime = utility::function_4b74c15943231980( autohealstarttime );
    starttimeoverride = getdvarint( @"hash_7782e26f82a4502b", 0 );
    
    if ( starttimeoverride > 0 )
    {
        autohealstarttime = starttimeoverride * 1000;
    }
    
    healrate = vehicle.bundledata.autoheal_tick_rate;
    var_6d87ca855a75d4da = getdvarfloat( @"hash_2b4c8822dd1d39d8", -1 );
    
    if ( var_6d87ca855a75d4da > 0 )
    {
        healrate = var_6d87ca855a75d4da * 1000;
    }
    else if ( var_6d87ca855a75d4da == 0 && vehicle.occupants.size > 0 )
    {
        healrate *= vehicle.occupants.size;
    }
    
    if ( vehicle.health >= vehicle.maxhealth )
    {
        vehicle set_autoheal_data( undefined, 0 );
        return;
    }
    
    currenttime = gettime();
    
    foreach ( var_69cef1154b5d5944 in level.repairsheds )
    {
        if ( distance2dsquared( vehicle.origin, var_69cef1154b5d5944.origin ) <= var_69cef1154b5d5944.radiussquared * 2 )
        {
            vehicle set_autoheal_data( currenttime, 0 );
            return;
        }
    }
    
    if ( function_acee55283adf70ac( currenttime, autohealstarttime ) )
    {
        if ( !vehicle.firstautoheal )
        {
            vehicle set_autoheal_data( vehicle.var_e4e29ab14bb7d603, 1 );
            vehicle.var_b29016302e60a0d5 = currenttime;
            vehicle vehicle_damage::add_health( vehicle.maxhealth * 0.1 );
            
            if ( !vehicle.tedd.var_b1f02517b6f44e59 || currenttime - vehicle.tedd.var_b1f02517b6f44e59 >= utility::function_4b74c15943231980( 1200 ) )
            {
                vehicle.tedd.var_b1f02517b6f44e59 = currenttime;
                vehicle thread utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_d5a8f7d3638398cf" );
            }
        }
        else if ( vehicle.var_b29016302e60a0d5 + healrate < currenttime )
        {
            vehicle vehicle_damage::add_health( vehicle.maxhealth * 0.01 );
            vehicle.var_b29016302e60a0d5 = currenttime;
        }
        
        if ( vehicle.health >= vehicle.maxhealth )
        {
            vehicle setscriptablepartstate( "upgrades", "healthrestore" );
        }
        
        set_vehicle_usable_state( vehicle, 1, 1 );
        return;
    }
    
    if ( vehicle.firstautoheal )
    {
        vehicle set_autoheal_data( currenttime, 0 );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xa1c7f75f, Offset: 0x30e8
// Size: 0x5d
function private get_stage_delay()
{
    switch ( self.var_7493baa2cd62443 )
    {
        case 0:
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            return 6;
        case 4:
            return 8;
    }
    
    return 1;
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x3f8a908, Offset: 0x314e
// Size: 0x80, Type: bool
function private function_acee55283adf70ac( currenttime, starttime )
{
    vehicle = self;
    
    if ( getdvarint( @"hash_4f6b9cce75cf4673", 0 ) == 1 )
    {
        return false;
    }
    
    if ( self.autohealskip )
    {
        return true;
    }
    
    if ( level utility::flag( "salvage_repair_pluto" ) )
    {
        return false;
    }
    
    if ( isdefined( vehicle.lastdamagetime ) && vehicle.lastdamagetime + starttime < currenttime )
    {
        return true;
    }
    
    return false;
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0xafb2c36a, Offset: 0x31d7
// Size: 0x34
function private set_autoheal_data( time, var_b9f29e98ed13650b )
{
    self.var_e4e29ab14bb7d603 = time;
    self.firstautoheal = var_b9f29e98ed13650b;
    set_autoheal_scriptable( var_b9f29e98ed13650b );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x2bc3000, Offset: 0x3213
// Size: 0x4d
function private set_autoheal_scriptable( playautoheal )
{
    if ( playautoheal )
    {
        utility::function_7c10ea82c1e305b8( "healing", "healingOn" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "healing", "healingOff" );
    self.autohealskip = 0;
    function_d5238fe8d2eba98e( function_2d549804d691ee7() );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xbcbce3ab, Offset: 0x3268
// Size: 0x27e
function private function_d45f62ecec56040( params )
{
    if ( params.sweapon.basename == level.var_1290e4d5ec608e82 && isdefined( params.einflictor ) && ( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) && !self.lc_stunned )
    {
        player = params.eattacker.occupants[ "gunner" ];
        
        if ( !isdefined( player ) )
        {
            player = params.eattacker.var_41dc639e7561a25a;
            self.kiastring = #"hash_44bbda3ef8ad2400";
            self.var_5d3022108c155ed4 = #"hash_44bbda3ef8ad2400";
        }
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        if ( !isenemyteam( self.team, player.team ) )
        {
            return;
        }
        
        if ( params.einflictor.var_e76eebdb259e385b )
        {
            return;
        }
        else
        {
            params.einflictor.var_e76eebdb259e385b = 1;
        }
        
        player.var_40619328d00ca2e0 = 1;
        player.var_6a8018c50244433a = undefined;
        player.var_9f9a21aa61089e2e = 0;
        player.var_35ff0d14f2a02cd = 1;
        var_ff9dff6d5982ce27 = structcopy( level.var_3bcb3c1cbfd1e8fd );
        var_ff9dff6d5982ce27.weapon = params.objweapon;
        var_ff9dff6d5982ce27.attacker = player;
        var_ff9dff6d5982ce27.inflictor = params.einflictor;
        var_ff9dff6d5982ce27.lc_id = string( player getentitynumber() ) + gettime();
        var_ff9dff6d5982ce27.source_enemy = self;
        var_ff9dff6d5982ce27.arc_origin = params.vpoint;
        var_ff9dff6d5982ce27.inflictor = level.wonder_veh;
        var_ff9dff6d5982ce27.use_inflictor = 1;
        
        if ( params.einflictor.var_37bfd777035f3bd5 )
        {
            var_ff9dff6d5982ce27.attacker = level.wonder_veh.var_fa86cbacaf912d02;
            var_ff9dff6d5982ce27.attacker.owner = player;
        }
        
        thread lightning_chain::arc_damage( self, player, var_ff9dff6d5982ce27 );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xa98684c, Offset: 0x34ef
// Size: 0x6d
function private function_1a6626fcd7fe9358( params )
{
    if ( params.sweapon.basename == level.var_1290e4d5ec608e82 && isdefined( params.einflictor ) && ( params.smeansofdeath == "MOD_PROJECTILE" || params.smeansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        return 1;
    }
    
    return -1;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xe85ed6fa, Offset: 0x3565
// Size: 0xd0
function private function_9c8e0c0e550b034e()
{
    if ( !isdefined( level.var_101838a8465f9845 ) )
    {
        level.var_101838a8465f9845 = %"hash_62a07b56f29782f5";
    }
    
    bundledata = level.var_101838a8465f9845;
    
    switch ( self.aicategory )
    {
        case #"hash_8c089e813083e510":
            return int( self.maxhealth * bundledata.var_4223a8a49491c5e1 );
        case #"hash_7b0e2f2ed84f34":
            return int( self.maxhealth * bundledata.var_cb75ffa0f4b5bf21 );
        case #"hash_4e47eb6c32f5b165":
            return int( self.maxhealth * bundledata.var_bf9711c1d07004e6 );
        default:
            break;
    }
}

