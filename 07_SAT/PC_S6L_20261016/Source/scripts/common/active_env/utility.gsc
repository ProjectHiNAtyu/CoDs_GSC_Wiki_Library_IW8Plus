// scripts\common\active_env\utility.gsc  (hash_1adabd4beb172de7.gscc) (size: 7335 Bytes / 0x1ca7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x61f83106 (1643655430)
// size ...... 7335 (0x1ca7)
// includes .. 5   (offset: 0x1bdf)
// strings ... 13  (offset: 0x1c07)
// dev strs .. 0   (offset: 0x1ca7)
// exports ... 28  (offset: 0x11b7)
// cseg ...... 0x141 + 0x1076 (0x11b7)
// imports ... 48  (offset: 0x1617)
// animtree1 . 0   (offset: 0x1ca7)
// animtree2 . 0   (offset: 0x1ca7)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\equipment\ammo_box;
#using scripts\mp\common\equipment\proximity_alarm;
#using scripts\mp\damage;

#namespace utility;

// Namespace utility
// Params 1
// Checksum 0x4712ef49, Offset: 0x15f
// Size: 0x75
function function_9fc28d50a2652cd7( t_crush_zone )
{
    if ( !isdefined( level.var_ff28e0c14ba90179 ) )
    {
        level.var_ff28e0c14ba90179 = [];
    }
    
    level.var_ff28e0c14ba90179[ level.var_ff28e0c14ba90179.size ] = t_crush_zone;
    registersharedfunc( #"game", #"registerentincrushzones", &function_f6d2b1924fca249 );
    registersharedfunc( #"game", #"unregisterentfromcrushzones", &function_6bff702e28b22a8f );
}

// Namespace utility
// Params 1
// Checksum 0x384c92e4, Offset: 0x1dc
// Size: 0xde
function function_e73b16a1b35af044( var_8f02ffaa7cc7316e )
{
    if ( !isdefined( level.var_ff28e0c14ba90179 ) )
    {
        level.var_ff28e0c14ba90179 = [];
    }
    
    foreach ( t_crush_zone in var_8f02ffaa7cc7316e )
    {
        level.var_ff28e0c14ba90179[ level.var_ff28e0c14ba90179.size ] = t_crush_zone;
    }
    
    registersharedfunc( #"game", #"registerentincrushzones", &function_f6d2b1924fca249 );
    registersharedfunc( #"game", #"unregisterentfromcrushzones", &function_6bff702e28b22a8f );
}

// Namespace utility
// Params 0
// Checksum 0xc872f098, Offset: 0x2c2
// Size: 0x2b
function function_5ca354a4734a1bd8()
{
    level endon( #"game_ended" );
    self endon( #"hash_316019751c651d01" );
    
    while ( true )
    {
        function_3fcc72db54ef9ce( self );
        waitframe();
    }
}

// Namespace utility
// Params 1
// Checksum 0x49039870, Offset: 0x2f5
// Size: 0x37
function function_6949f16f10cfdbee( e_ent )
{
    level endon( #"game_ended" );
    self endon( #"hash_316019751c651d01" );
    
    while ( true )
    {
        function_91cfc363ac2bb680( self, e_ent );
        waitframe();
    }
}

// Namespace utility
// Params 0
// Checksum 0x90e390a4, Offset: 0x334
// Size: 0xe
function function_9074f7fdf422f8e5()
{
    self notify( #"hash_316019751c651d01" );
}

// Namespace utility
// Params 2
// Checksum 0xa78b56e7, Offset: 0x34a
// Size: 0xb1
function function_91cfc363ac2bb680( t_crush_zone, e_ent_touch )
{
    if ( isdefined( t_crush_zone.var_d1a9e2ca4ba96c64 ) )
    {
        foreach ( e_ent in t_crush_zone.var_d1a9e2ca4ba96c64 )
        {
            if ( isdefined( e_ent ) && e_ent istouching( e_ent_touch ) )
            {
                function_a159923982374987( t_crush_zone, e_ent );
            }
        }
    }
}

// Namespace utility
// Params 1
// Checksum 0x52af4638, Offset: 0x403
// Size: 0x9d
function function_3fcc72db54ef9ce( t_crush_zone )
{
    if ( isdefined( t_crush_zone.var_d1a9e2ca4ba96c64 ) )
    {
        foreach ( e_ent in t_crush_zone.var_d1a9e2ca4ba96c64 )
        {
            if ( isdefined( e_ent ) )
            {
                function_a159923982374987( t_crush_zone, e_ent );
            }
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x3710de65, Offset: 0x4a8
// Size: 0x47
function private function_a159923982374987( t_crush_zone, e_ent )
{
    if ( isdefined( t_crush_zone ) && isdefined( e_ent ) )
    {
        t_crush_zone.var_d1a9e2ca4ba96c64 = arrayremove( t_crush_zone.var_d1a9e2ca4ba96c64, e_ent );
        e_ent destroy_ent();
    }
}

// Namespace utility
// Params 1
// Checksum 0x5b7bbfb1, Offset: 0x4f7
// Size: 0x118
function function_f6d2b1924fca249( e_ent )
{
    if ( !( isdefined( e_ent ) && isdefined( level.var_ff28e0c14ba90179 ) ) )
    {
        return;
    }
    
    foreach ( t_crush_zone in level.var_ff28e0c14ba90179 )
    {
        var_d7f6256315a70ff6 = isent( e_ent ) && e_ent istouching( t_crush_zone );
        var_f141d3e6c8e83040 = ispointinvolume( e_ent.origin, t_crush_zone );
        var_10e83b2691e13475 = var_d7f6256315a70ff6 || var_f141d3e6c8e83040;
        
        if ( !var_10e83b2691e13475 )
        {
            continue;
        }
        
        if ( !isdefined( t_crush_zone.var_d1a9e2ca4ba96c64 ) )
        {
            t_crush_zone.var_d1a9e2ca4ba96c64 = [];
        }
        
        t_crush_zone.var_d1a9e2ca4ba96c64[ t_crush_zone.var_d1a9e2ca4ba96c64.size ] = e_ent;
    }
}

// Namespace utility
// Params 1
// Checksum 0x958342d9, Offset: 0x617
// Size: 0xc6
function function_6bff702e28b22a8f( e_ent )
{
    if ( !( isdefined( e_ent ) && isdefined( level.var_ff28e0c14ba90179 ) ) )
    {
        return;
    }
    
    foreach ( t_crush_zone in level.var_ff28e0c14ba90179 )
    {
        if ( !isdefined( t_crush_zone.var_d1a9e2ca4ba96c64 ) )
        {
            continue;
        }
        
        t_crush_zone.var_d1a9e2ca4ba96c64 = arrayremove( t_crush_zone.var_d1a9e2ca4ba96c64, [ e_ent ] );
    }
}

// Namespace utility
// Params 2
// Checksum 0x1d8f87c0, Offset: 0x6e5
// Size: 0xea
function destroy_ents_in_trigger( e_attacker, var_ac6bbd197805b70d )
{
    level endon( #"game_ended" );
    self endon( #"hash_5f80eb6dacae9e86" );
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        e_inflictor = self;
        
        if ( !isdefined( var_ac6bbd197805b70d ) )
        {
            e_ent destroy_ent( e_attacker, e_inflictor );
            continue;
        }
        
        foreach ( var_33fe4e3a06b21c77 in var_ac6bbd197805b70d )
        {
            if ( e_ent istouching( var_33fe4e3a06b21c77 ) )
            {
                e_ent destroy_ent( e_attacker, e_inflictor );
            }
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x4770e682, Offset: 0x7d7
// Size: 0x169
function private destroy_ent( e_attacker, e_inflictor )
{
    var_4f976f4af41f874a = [];
    var_4f976f4af41f874a[ "t10_proximity_alarm" ] = &proximity_alarm::proximity_alarm_destroy;
    var_4f976f4af41f874a[ "t10_semtex_mp" ] = &function_fa524d3dc0dd7614;
    var_4f976f4af41f874a[ "t10_assault_pack_mp" ] = &ammo_box::ammobox_destroy;
    var_4f976f4af41f874a[ "t10_jammer_plantable" ] = &util_destroy_jammer;
    var_4f976f4af41f874a[ "rc_xd" ] = &function_6c7683a1e5bd3d8f;
    var_4f976f4af41f874a[ "missile_turret" ] = &util_destroy_turret;
    
    if ( isdefined( self.var_a21f47f6f7811618 ) )
    {
        self [[ self.var_a21f47f6f7811618 ]]();
        return;
    }
    
    if ( isdefined( self.weapon_name ) && arraycontains( var_4f976f4af41f874a, self.weapon_name ) )
    {
        self [[ var_4f976f4af41f874a[ self.weapon_name ] ]]();
        return;
    }
    
    if ( isdefined( self.streakname ) && arraycontains( var_4f976f4af41f874a, self.streakname ) )
    {
        self [[ var_4f976f4af41f874a[ self.streakname ] ]]();
        return;
    }
    
    if ( isplayer( self ) )
    {
        e_player = self;
        
        if ( !isdefined( e_attacker ) || e_player.team == e_attacker.team )
        {
            e_attacker = e_player;
        }
        
        e_player.var_62a8e010c7611cda = 1;
        damage::addattacker( e_player, e_attacker, undefined, nullweapon(), 0, undefined, undefined, undefined, undefined, "MOD_UNKNOWN" );
        e_player kill( self.origin, e_attacker, self, "MOD_CRUSH" );
    }
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0x75639be, Offset: 0x948
// Size: 0x2
function private function_6c7683a1e5bd3d8f()
{
    
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0xd6c30afd, Offset: 0x952
// Size: 0x2
function private util_destroy_jammer()
{
    
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0x4365618b, Offset: 0x95c
// Size: 0x2d
function private function_fa524d3dc0dd7614()
{
    magicgrenademanual( self.weapon_name, self.origin, ( 0, 0, 0 ), 0 );
    self delete();
}

// Namespace utility
// Params 0, eflags: 0x4
// Checksum 0x56414bfd, Offset: 0x991
// Size: 0xe
function private util_destroy_turret()
{
    self notify( #"kill_turret" );
}

// Namespace utility
// Params 3
// Checksum 0x57da1c5b, Offset: 0x9a7
// Size: 0xde
function setup_no_deploy_zones( weaponfilter, triggername = "no_equipment_zone", triggerkey = #script_noteworthy )
{
    var_619d6a48f5a56867 = getentarray( triggername, triggerkey );
    
    foreach ( var_4f16c60769e4f39a in var_619d6a48f5a56867 )
    {
        var_4f16c60769e4f39a.weaponfilter = weaponfilter;
    }
    
    callback::callback( #"hash_500e33f5505ca842", { #var_619d6a48f5a56867:var_619d6a48f5a56867 } );
}

// Namespace utility
// Params 4
// Checksum 0x233bd7f, Offset: 0xa8d
// Size: 0x1c6
function translate_to( var_54ab98a98b57d4a3, var_9fbf8c91b4222a27, n_accel_time_s, var_dc47444ccdded684 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"translate_stop" );
    var_cf6eb94f01e66fd6 = self.origin;
    
    if ( n_accel_time_s + var_dc47444ccdded684 > var_9fbf8c91b4222a27 )
    {
        k = var_9fbf8c91b4222a27 / ( n_accel_time_s + var_dc47444ccdded684 );
        n_accel_time_s *= k;
        var_dc47444ccdded684 *= k;
    }
    
    var_e1194e2fe89ca514 = var_9fbf8c91b4222a27 - n_accel_time_s - var_dc47444ccdded684;
    n_max_velocity = 1 / ( var_e1194e2fe89ca514 + 0.5 * ( n_accel_time_s + var_dc47444ccdded684 ) );
    var_81c2bb4dfe4e0ea7 = n_accel_time_s > 0 ? n_max_velocity / n_accel_time_s : 0;
    n_decel = ( var_dc47444ccdded684 > 0 ? n_max_velocity / var_dc47444ccdded684 : 0 ) * -1;
    n_accel_dist = function_6a613af315ab0e4c( 0, var_81c2bb4dfe4e0ea7, n_accel_time_s );
    var_c15c4032c5170483 = n_max_velocity * var_e1194e2fe89ca514;
    var_55b6bc99c3c0dc55 = n_accel_dist + var_c15c4032c5170483;
    n_start_time_ms = gettime();
    n_time_elapsed_s = 0;
    
    while ( n_time_elapsed_s <= var_9fbf8c91b4222a27 )
    {
        n_time_elapsed_s = ( gettime() - n_start_time_ms ) / 1000;
        
        if ( n_time_elapsed_s < n_accel_time_s )
        {
            var_3471316e3ec32d4a = function_6a613af315ab0e4c( 0, var_81c2bb4dfe4e0ea7, n_time_elapsed_s );
        }
        else if ( n_time_elapsed_s < n_accel_time_s + var_e1194e2fe89ca514 )
        {
            var_678d0228f3f2c387 = n_time_elapsed_s - n_accel_time_s;
            var_3471316e3ec32d4a = n_accel_dist + n_max_velocity * var_678d0228f3f2c387;
        }
        else
        {
            var_57c921c39539f5f2 = n_time_elapsed_s - n_accel_time_s - var_e1194e2fe89ca514;
            var_3471316e3ec32d4a = var_55b6bc99c3c0dc55 + function_6a613af315ab0e4c( n_max_velocity, n_decel, var_57c921c39539f5f2 );
        }
        
        var_3471316e3ec32d4a = clamp( var_3471316e3ec32d4a, 0, 1 );
        self.origin = vectorlerp( var_cf6eb94f01e66fd6, var_54ab98a98b57d4a3, var_3471316e3ec32d4a );
        waitframe();
    }
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x501cbf16, Offset: 0xc5b
// Size: 0x42
function private function_6a613af315ab0e4c( var_2daa048adc2c1c03, var_c3b47bc557abe0e9, n_time )
{
    n_displacement = var_2daa048adc2c1c03 * n_time + 0.5 * var_c3b47bc557abe0e9 * pow( n_time, 2 );
    return n_displacement;
}

// Namespace utility
// Params 3
// Checksum 0xe0550172, Offset: 0xca6
// Size: 0x46
function function_6b6c127afa12d17( pivot, point, angles )
{
    rotated_point = point;
    rotated_point = function_ca8552b091c9f560( pivot, rotated_point, angles );
    rotated_point = function_ca8553b091c9f793( pivot, rotated_point, angles );
    return rotated_point;
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x4a37edb2, Offset: 0xcf5
// Size: 0x7d
function private function_ca8552b091c9f560( pivot, point, angles )
{
    point -= pivot;
    s = sin( angles[ 0 ] );
    c = cos( angles[ 0 ] );
    znew = point[ 1 ] * s + point[ 2 ] * c;
    point = ( point[ 0 ] + pivot[ 0 ], point[ 1 ] + pivot[ 1 ], znew + pivot[ 2 ] );
    return point;
}

// Namespace utility
// Params 3, eflags: 0x4
// Checksum 0x97223e6d, Offset: 0xd7b
// Size: 0x95
function private function_ca8553b091c9f793( pivot, point, angles )
{
    point -= pivot;
    s = sin( angles[ 1 ] );
    c = cos( angles[ 1 ] );
    xnew = point[ 0 ] * c - point[ 1 ] * s;
    ynew = point[ 0 ] * s + point[ 1 ] * c;
    point = ( xnew + pivot[ 0 ], ynew + pivot[ 1 ], point[ 2 ] + pivot[ 2 ] );
    return point;
}

// Namespace utility
// Params 4
// Checksum 0xa4cb8ad, Offset: 0xe19
// Size: 0xf3, Type: bool
function function_95d696d596171e4e( source, target, sourcefov = 180, maxdistance = 0 )
{
    distancetotarget = length( target.origin - source.origin );
    vectortotarget = vectornormalize( target.origin - source.origin );
    sourceforward = anglestoforward( source.angles );
    dot = vectordot( sourceforward, vectortotarget );
    angle = acos( dot );
    
    if ( angle <= sourcefov * 0.5 && distancetotarget < maxdistance )
    {
        if ( maxdistance > 0 && distancetotarget < maxdistance )
        {
            return true;
        }
        else if ( maxdistance === 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility
// Params 1
// Checksum 0x9ef3ea08, Offset: 0xf15
// Size: 0x148
function unresolved_collision_replacement( str_script_noteworthy_check = "sc_unresolved_collision" )
{
    var_6bb93d65b70b4592 = getentarray( str_script_noteworthy_check, #script_noteworthy );
    
    foreach ( e_unresolved in var_6bb93d65b70b4592 )
    {
        e_unresolved.unresolved_collision_func = &function_9dd19eb4dd4bf00a;
    }
    
    flag_wait( "scriptables_ready" );
    var_8eb9aaab7c3da12d = getscriptablearray( str_script_noteworthy_check, #script_noteworthy );
    
    foreach ( scr_unresolved in var_8eb9aaab7c3da12d )
    {
        scr_unresolved.unresolved_collision_func = &function_9dd19eb4dd4bf00a;
    }
}

// Namespace utility
// Params 1
// Checksum 0xab71cf49, Offset: 0x1065
// Size: 0xce
function function_92ef15feec9f0bc( str_tag = "veh_" )
{
    flag_wait( "scriptables_ready" );
    var_fe8457cf1a700ea6 = getscriptablearray( "scriptable", #code_classname );
    
    foreach ( scriptable in var_fe8457cf1a700ea6 )
    {
        if ( issubstr( scriptable.classname, str_tag ) )
        {
            scriptable.unresolved_collision_func = &function_9dd19eb4dd4bf00a;
        }
    }
}

// Namespace utility
// Params 2, eflags: 0x4
// Checksum 0x965dffee, Offset: 0x113b
// Size: 0x15
function private function_9dd19eb4dd4bf00a( hitent, penetration )
{
    
}

// Namespace utility
// Params 2
// Checksum 0x4a4960ed, Offset: 0x1158
// Size: 0x5e
function function_136bd9aeb8121a6b( var_722754a1d6e8ebe6, var_5da50d0bd99288e6 )
{
    var_b78a4d168d50058a = vectordot( var_722754a1d6e8ebe6, anglestoright( var_5da50d0bd99288e6 ) );
    var_b78a4e168d5007bd = vectordot( var_722754a1d6e8ebe6, anglestoup( var_5da50d0bd99288e6 ) );
    var_b78a4b168d500124 = vectordot( var_722754a1d6e8ebe6, anglestoforward( var_5da50d0bd99288e6 ) );
    return ( var_b78a4d168d50058a, var_b78a4e168d5007bd, var_b78a4b168d500124 );
}

