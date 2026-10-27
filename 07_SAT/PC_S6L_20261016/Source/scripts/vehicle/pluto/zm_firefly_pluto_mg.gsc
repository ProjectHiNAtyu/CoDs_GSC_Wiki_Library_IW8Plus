// scripts\vehicle\pluto\zm_firefly_pluto_mg.gsc  (hash_5c6cef8acbef78c1.gscc) (size: 7419 Bytes / 0x1cfb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa2abcfdb (2729168859)
// size ...... 7419 (0x1cfb)
// includes .. 8   (offset: 0x1b6f)
// strings ... 23  (offset: 0x1baf)
// dev strs .. 0   (offset: 0x1cfb)
// exports ... 18  (offset: 0x1127)
// cseg ...... 0x1b7 + 0xf70 (0x1127)
// imports ... 64  (offset: 0x13f7)
// animtree1 . 0   (offset: 0x1cfb)
// animtree2 . 0   (offset: 0x1cfb)
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\zm_utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0xafa27d2c, Offset: 0x1d5
// Size: 0x96
function function_4d7343cf17860004()
{
    self setscriptablepartstate( "turret_fx", "turret_fx_on" );
    thread function_8497f937e7e1099f();
    thread function_6f070e5d11b6e804();
    self.var_fa86cbacaf912d02 = utility::spawn_script_origin();
    self.var_fa86cbacaf912d02.var_74828b8c6990f0b2 = 1;
    
    if ( !isdefined( level.pluto_mg_autofire_throttle ) )
    {
        level.pluto_mg_autofire_throttle = throttle::throttle_initialize( "pluto_mg_autofire", 2 );
    }
    
    if ( !isdefined( level.var_3bcb3c1cbfd1e8fd.var_d0449be91ab49769 ) )
    {
        level.var_3bcb3c1cbfd1e8fd.var_d0449be91ab49769 = &function_3fd83d0e2e13b310;
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x41fe056a, Offset: 0x273
// Size: 0x4b, Type: bool
function private function_3fd83d0e2e13b310()
{
    if ( self.type == "zombie" && isdefined( self.aicategory ) )
    {
        if ( self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xc3fb86a7, Offset: 0x2c7
// Size: 0x64
function private function_6f070e5d11b6e804()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self isturretoverheated( 1 ) || utility::function_9f2c41c1dcc8c94( "single", "vehicle_unusable" ) )
        {
            self setscriptablepartstate( "turret_fx", "turret_fx_off" );
        }
        else
        {
            self setscriptablepartstate( "turret_fx", "turret_fx_on" );
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0xfd67558f, Offset: 0x333
// Size: 0x227
function private function_8497f937e7e1099f()
{
    self notify( #"hash_f0761cd7d72ecfdc" );
    self endon( #"hash_f0761cd7d72ecfdc" );
    level endon( #"game_ended" );
    self endon( #"death" );
    var_bd099b14b19d612e = 0;
    vehicle = self;
    veh_data = vehicle::get_data( %"hash_62a07b56f29782f5" );
    turret = veh_data.occupancy.seatdata[ "gunner" ].turretobjweapon;
    vehicle setturretaispread( vehicle.bundledata.var_31ae616c1f8fd4fe );
    vehicle thread function_46bf89fea453f5c7();
    
    while ( true )
    {
        if ( !vehicle function_a696e387e55be7f4() )
        {
            vehicle function_5e378584994a8a0b();
            wait 1;
            continue;
        }
        
        if ( isdefined( turret ) )
        {
            turret_target = vehicle get_pluto_turret_target();
            
            if ( isdefined( turret_target ) )
            {
                if ( isai( turret_target ) && turret_target.aicategory == "normal" && !turret_target.var_698cf8d8d4a8cbb9 && zm_cleanup_manager::function_2aa25a812d802967() <= vehicle.bundledata.var_4af57cb2bdf15875 )
                {
                    var_bd099b14b19d612e++;
                    
                    if ( var_bd099b14b19d612e >= 120 )
                    {
                        vehicle function_5e378584994a8a0b();
                        var_bd099b14b19d612e = 0;
                        wait 1;
                    }
                    
                    waitframe();
                    continue;
                }
                
                var_bd099b14b19d612e = 0;
                target_offset = get_turret_target_offset( turret_target );
                
                if ( isai( turret_target ) )
                {
                    vehicle setturrettargetent( turret_target, target_offset, 1 );
                }
                else if ( !isent( turret_target ) )
                {
                    vehicle setturrettargetvec( turret_target.origin + target_offset, 1 );
                }
                else
                {
                    vehicle setturrettargetent( turret_target, target_offset, 1 );
                }
                
                wait 1.5;
                
                if ( vehicle function_a696e387e55be7f4() )
                {
                    vehicle.var_41dc639e7561a25a = vehicle.occupants[ "driver" ];
                    thread function_d3b34845336b343c();
                    vehicle fireweapon( 1 );
                    vehicle thread function_93b11f794f502aea();
                    wait 1;
                }
            }
            else
            {
                var_bd099b14b19d612e++;
                
                if ( var_bd099b14b19d612e >= 120 )
                {
                    vehicle function_5e378584994a8a0b();
                    var_bd099b14b19d612e = 0;
                    wait 1;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd6bcef74, Offset: 0x562
// Size: 0x3d
function private function_d3b34845336b343c()
{
    self waittill( #"vehicle_turret_fire", index, firebarrel, projectile );
    projectile.var_37bfd777035f3bd5 = 1;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x36d1ab34, Offset: 0x5a7
// Size: 0x56
function private function_46bf89fea453f5c7()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    
    while ( true )
    {
        if ( vehicle isturretoverheated( 1 ) && !vehicle utility::ent_flag( "overheat_autofire_delay_active" ) )
        {
            vehicle thread function_280cd96e92fb175d();
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x8d95e65a, Offset: 0x605
// Size: 0x5e
function private function_280cd96e92fb175d()
{
    self notify( #"hash_8a0a505cc9755827" );
    self endon( #"hash_8a0a505cc9755827" );
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_set( "overheat_autofire_delay_active" );
    wait self.bundledata.var_36ebae75be6fee9e;
    utility::ent_flag_clear( "overheat_autofire_delay_active" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xdac08085, Offset: 0x66b
// Size: 0x6b, Type: bool
function private function_a696e387e55be7f4()
{
    vehicle = self;
    
    if ( vehicle.var_7493baa2cd62443 < 4 )
    {
        return false;
    }
    
    if ( isplayer( vehicle.occupants[ "gunner" ] ) )
    {
        return false;
    }
    
    if ( !isplayer( vehicle.occupants[ "driver" ] ) )
    {
        return false;
    }
    
    if ( vehicle utility::ent_flag( "overheat_autofire_delay_active" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xb1ab6ce8, Offset: 0x6df
// Size: 0x3a
function private function_5e378584994a8a0b()
{
    level endon( #"game_ended" );
    vehicle = self;
    vehicle clearturrettarget( 1 );
    vehicle setturrettargetlocalangles( ( 0, 0, 0 ), 1 );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xf950aba2, Offset: 0x721
// Size: 0x83
function private get_pluto_turret_target()
{
    level endon( #"game_ended" );
    vehicle = self;
    turret_target = vehicle function_c9935ce7d3447ee2();
    
    if ( !isdefined( turret_target ) )
    {
        var_7d122e2a94f2cef5 = getaiarrayinradius( vehicle.origin, 1500, zm_utility::get_zombie_team() );
        turret_target = vehicle function_2684357bc8c7ecf3( var_7d122e2a94f2cef5 );
        
        if ( !isdefined( turret_target ) )
        {
            turret_target = vehicle function_88617c8fc88b01bf( var_7d122e2a94f2cef5 );
        }
        
        if ( !isdefined( turret_target ) )
        {
            turret_target = vehicle function_d45c58cb3d8286b7( var_7d122e2a94f2cef5 );
        }
    }
    
    return turret_target;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x9c728058, Offset: 0x7ad
// Size: 0x128
function private function_c9935ce7d3447ee2()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    var_e456f7da90a899c5 = [];
    
    if ( isplayer( vehicle.occupants[ "driver" ] ) )
    {
        driver = vehicle.occupants[ "driver" ];
        
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            isowner = driver calloutmarkerping::isowner( pingindex );
            
            if ( isowner )
            {
                pingent = driver calloutmarkerping_getent( pingindex );
                
                if ( pingent )
                {
                    if ( isai( pingent ) && isalive( pingent ) && pingent.team == zm_utility::get_zombie_team() )
                    {
                        var_e456f7da90a899c5[ var_e456f7da90a899c5.size ] = pingent;
                        continue;
                    }
                    
                    if ( pingent.type && pingent isscriptableinstance() && arraycontains( [ %"zm_sat_urchin_large" ], pingent.type ) )
                    {
                        var_e456f7da90a899c5[ var_e456f7da90a899c5.size ] = pingent;
                    }
                }
            }
        }
    }
    
    return vehicle function_992d8a27261d3edd( var_e456f7da90a899c5 );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xf1e15e9d, Offset: 0x8de
// Size: 0x120
function private function_2684357bc8c7ecf3( var_7d122e2a94f2cef5 )
{
    vehicle = self;
    a_zombs = [];
    
    foreach ( var_bd2c4ac1948d79c6 in var_7d122e2a94f2cef5 )
    {
        if ( var_bd2c4ac1948d79c6.subclass == "zombie_shade" && var_bd2c4ac1948d79c6.var_c2244a336e1c23aa )
        {
            a_zombs[ a_zombs.size ] = var_bd2c4ac1948d79c6;
            continue;
        }
        
        if ( var_bd2c4ac1948d79c6.subclass == "zombie_callisto" && distance2dsquared( var_bd2c4ac1948d79c6.origin, vehicle.origin ) <= squared( 500 ) )
        {
            a_zombs[ a_zombs.size ] = var_bd2c4ac1948d79c6;
            continue;
        }
        
        if ( var_bd2c4ac1948d79c6.subclass == "zombie_hermes" )
        {
            a_zombs[ a_zombs.size ] = var_bd2c4ac1948d79c6;
        }
    }
    
    return vehicle function_992d8a27261d3edd( a_zombs );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x7c4dd28b, Offset: 0xa07
// Size: 0x258
function private function_88617c8fc88b01bf( var_7d122e2a94f2cef5 )
{
    vehicle = self;
    a_urchins = getentitylessscriptablearray( undefined, undefined, vehicle.origin, 3000 );
    
    foreach ( sbl in a_urchins )
    {
        if ( sbl.type != %"zm_sat_urchin_large" )
        {
            a_urchins = arrayremove( a_urchins, sbl );
        }
    }
    
    if ( vehicle vehicle_getspeed() >= 10 )
    {
        var_aa99aeaec1cf8b2e = [];
        
        foreach ( urchin in a_urchins )
        {
            if ( math::within_fov_2d( vehicle gettagorigin( "tag_gunner_flash1" ), vehicle.angles, urchin.origin, cos( 100 ) ) && distance2dsquared( vehicle.origin, urchin.origin ) >= squared( 500 ) )
            {
                var_aa99aeaec1cf8b2e[ var_aa99aeaec1cf8b2e.size ] = urchin;
            }
        }
        
        turret_target = vehicle function_992d8a27261d3edd( var_aa99aeaec1cf8b2e, 0 );
        
        if ( isdefined( turret_target ) )
        {
            return turret_target;
        }
    }
    
    a_zombs = [];
    
    foreach ( var_bd2c4ac1948d79c6 in var_7d122e2a94f2cef5 )
    {
        if ( var_bd2c4ac1948d79c6.var_698cf8d8d4a8cbb9 )
        {
            a_zombs[ a_zombs.size ] = var_bd2c4ac1948d79c6;
        }
    }
    
    a_targets = arraycombine( a_urchins, a_zombs );
    return vehicle function_992d8a27261d3edd( a_zombs );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x3e9a44c4, Offset: 0xc68
// Size: 0xaa
function private function_d45c58cb3d8286b7( var_7d122e2a94f2cef5 )
{
    vehicle = self;
    a_zombs = [];
    
    foreach ( var_bd2c4ac1948d79c6 in var_7d122e2a94f2cef5 )
    {
        if ( !var_bd2c4ac1948d79c6.var_698cf8d8d4a8cbb9 )
        {
            a_zombs[ a_zombs.size ] = var_bd2c4ac1948d79c6;
        }
    }
    
    return vehicle function_992d8a27261d3edd( a_zombs );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x1de80806, Offset: 0xd1b
// Size: 0x2b0
function private function_992d8a27261d3edd( a_group, b_sort_distance = 1 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    
    if ( b_sort_distance )
    {
        a_group = function_628bac9faa9d1e86( a_group, vehicle.origin );
    }
    else
    {
        a_group = arrayrandomize( a_group );
    }
    
    a_targets = [];
    
    foreach ( target in a_group )
    {
        veh_fwd = anglestoforward( self.angles );
        veh_to_target = vectornormalize( target.origin - self.origin + veh_fwd * 30 );
        dot_product = vectordot( veh_fwd, veh_to_target );
        
        if ( dot_product > cos( 45 ) )
        {
            a_targets[ a_targets.size ] = target;
        }
    }
    
    a_targets = arraycombineunique( a_targets, a_group );
    var_f1e2f97cb1ef5ea5 = squared( 4500 );
    
    foreach ( target in a_targets )
    {
        if ( distance2dsquared( target.origin, vehicle.origin ) > var_f1e2f97cb1ef5ea5 )
        {
            continue;
        }
        
        target_offset = get_turret_target_offset( target );
        target_origin = target.origin + target_offset;
        trace = trace::ray_trace( vehicle gettagorigin( "tag_gunner_flash1" ), target_origin, [ vehicle ], undefined, 0, 0, 1 );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            return target;
        }
        else if ( trace[ "hittype" ] == "hittype_entity" && ( trace[ "entity" ] == target || trace[ "entity" ].owner == target ) )
        {
            return target;
        }
        else if ( trace[ "hittype" ] == "hittype_scriptable" && trace[ "scriptable" ] == target )
        {
            return target;
        }
        
        throttle::throttle_wait_in_queue( level.pluto_mg_autofire_throttle, vehicle );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xfba2f455, Offset: 0xfd3
// Size: 0x9c
function private get_turret_target_offset( target )
{
    if ( isai( target ) )
    {
        switch ( target.subclass )
        {
            case #"hash_615dbf7f92e4de09":
                target_offset = ( 0, 0, 10 );
                break;
            case #"hash_2acd09119803cd7e":
                target_offset = ( 0, 0, 200 );
                break;
            default:
                target_offset = ( 0, 0, 40 );
                break;
        }
        
        return target_offset;
    }
    
    return ( 0, 0, 40 );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xd23821d2, Offset: 0x1078
// Size: 0xaf
function private function_93b11f794f502aea()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    vehicle = self;
    curr_time = gettime();
    
    if ( !vehicle.tedd.var_f15a9c4c57622a9 || curr_time - vehicle.tedd.var_f15a9c4c57622a9 >= utility::function_4b74c15943231980( 60 ) )
    {
        vehicle.tedd.var_f15a9c4c57622a9 = curr_time;
        vehicle utility::callsharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", #"hash_7c03ecd3c23d7246" );
    }
}

