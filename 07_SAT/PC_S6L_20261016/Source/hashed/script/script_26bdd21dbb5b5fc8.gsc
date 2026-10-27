// script_26bdd21dbb5b5fc8  (hash_26bdd21dbb5b5fc8.gscc) (size: 1837 Bytes / 0x72d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x107aa8d0 (276474064)
// size ...... 1837 (0x72d)
// includes .. 1   (offset: 0x6d1)
// strings ... 0   (offset: 0x6d9)
// dev strs .. 7   (offset: 0x6d9)
// exports ... 5   (offset: 0x475)
// cseg ...... 0x58 + 0x41d (0x475)
// imports ... 13  (offset: 0x53d)
// animtree1 . 0   (offset: 0x72d)
// animtree2 . 0   (offset: 0x72d)
#using scripts\mp\weapons;

#namespace namespace_7bfb7f22014f83ed;

// Namespace namespace_7bfb7f22014f83ed
// Params 3
// Checksum 0x59609190, Offset: 0x76
// Size: 0x13a
function function_40826e063563a661( var_d0a9d177707a4448, attacker, bundle )
{
    assert( bundle.var_a0e0b1c7470493f, "<dev string:x24>" );
    assert( bundle.var_9eb191c744a2051, "<dev string:x6d>" );
    assert( bundle.var_a0e0b1c7470493f <= bundle.var_9eb191c744a2051, "<dev string:xb6>" );
    assert( bundle.var_cf5a7c5927a46bef, "<dev string:x100>" );
    assert( bundle.var_5ddcb34b88263285, "<dev string:x14c>" );
    assert( bundle.var_cf5a7c5927a46bef <= bundle.var_5ddcb34b88263285, "<dev string:x198>" );
    assert( bundle.var_25e40e7bc2651998, "<dev string:x1e8>" );
    submunition_weapon = makeweapon( bundle.var_25e40e7bc2651998 );
    
    for ( i = 0; i < bundle.var_be7ca49acafe51c0 ; i++ )
    {
        submunition_params = function_f1ca4f9081f21ad2( var_d0a9d177707a4448, bundle, i );
        spawn_cluster_submunition( submunition_weapon, submunition_params, attacker );
    }
}

// Namespace namespace_7bfb7f22014f83ed
// Params 3, eflags: 0x4
// Checksum 0xf0328687, Offset: 0x1b8
// Size: 0x94
function private spawn_cluster_submunition( submunition_weapon, submunition_params, attacker )
{
    submunition = magicgrenademanual( submunition_weapon, submunition_params.spawnorigin, submunition_params.velocity, submunition_params.fusetime, attacker );
    attacker weapons::grenadeinitialize( submunition, submunition_weapon );
    submunition setscriptablepartstate( #"visual", #"visible", 0 );
    submunition setcandamage( 0 );
    submunition thread function_bd2d58526614fa90( submunition_params.fusetime );
}

// Namespace namespace_7bfb7f22014f83ed
// Params 3, eflags: 0x4
// Checksum 0xddeb9183, Offset: 0x254
// Size: 0xfb
function private function_f1ca4f9081f21ad2( var_d0a9d177707a4448, bundle, index )
{
    launch_force = randomfloatrange( bundle.var_cf5a7c5927a46bef, bundle.var_5ddcb34b88263285 );
    launch_angle = randomfloatrange( 25, 55 );
    launch_direction = ( cos( launch_angle ), 0, sin( launch_angle ) );
    angle_progress = index / bundle.var_be7ca49acafe51c0;
    submunition_yaw = angle_progress * 6.28318 * 57.2958;
    launch_direction = rotatevector( launch_direction, ( 0, submunition_yaw, 0 ) );
    return { #fusetime:randomfloatrange( bundle.var_a0e0b1c7470493f, bundle.var_9eb191c744a2051 ), #velocity:launch_direction * launch_force, #spawnorigin:var_d0a9d177707a4448 + launch_direction * 30 };
}

// Namespace namespace_7bfb7f22014f83ed
// Params 1, eflags: 0x4
// Checksum 0xe1c3820b, Offset: 0x358
// Size: 0x11d
function private function_bd2d58526614fa90( fuse_time )
{
    self endon( #"explode", #"death" );
    min_time_fraction = 0.1 / fuse_time;
    var_caa17783fb8cc9f9 = 1 - min_time_fraction * 5;
    curr_time_fraction = var_caa17783fb8cc9f9 / 5 + 0.1;
    var_79e5f4700457e149 = fuse_time * curr_time_fraction;
    
    for ( var_4de30306971213a3 = 0; true ; var_4de30306971213a3 = 1 )
    {
        self setscriptablepartstate( #"ramp_up_fx", #"active", 0 );
        wait 0.05;
        self setscriptablepartstate( #"ramp_up_fx", #"inactive", 0 );
        wait 0.05;
        
        if ( !var_4de30306971213a3 )
        {
            remaining_wait = var_79e5f4700457e149 - 0.1;
            
            if ( remaining_wait <= 0 )
            {
                var_4de30306971213a3 = 1;
            }
            else
            {
                wait remaining_wait;
            }
            
            curr_time_fraction -= 0.05;
            
            if ( curr_time_fraction < min_time_fraction )
            {
                curr_time_fraction = min_time_fraction;
                var_4de30306971213a3 = 1;
            }
            
            var_79e5f4700457e149 = fuse_time * curr_time_fraction;
            
            if ( var_79e5f4700457e149 < 0.1 )
            {
                var_79e5f4700457e149 = 0.1;
            }
        }
    }
}

