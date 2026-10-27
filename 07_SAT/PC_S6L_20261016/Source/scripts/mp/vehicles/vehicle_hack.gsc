// scripts\mp\vehicles\vehicle_hack.gsc  (hash_70843a09189799b6.gscc) (size: 5010 Bytes / 0x1392 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x342cfc08 (875363336)
// size ...... 5010 (0x1392)
// includes .. 5   (offset: 0x12a2)
// strings ... 13  (offset: 0x12ca)
// dev strs .. 0   (offset: 0x1392)
// exports ... 22  (offset: 0x9de)
// cseg ...... 0xf2 + 0x8ec (0x9de)
// imports ... 43  (offset: 0xd4e)
// animtree1 . 0   (offset: 0x1392)
// animtree2 . 0   (offset: 0x1392)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\emp_debuff;

#namespace vehicle_hack;

// Namespace vehicle_hack
// Params 0
// Checksum 0x5ce4bb7d, Offset: 0x110
// Size: 0xb
function clear()
{
    emp_debuff::clear_emp( 1 );
}

// Namespace vehicle_hack
// Params 0, eflags: 0x4
// Checksum 0xcaf2b9ac, Offset: 0x123
// Size: 0x82
function private function_9a290d9e2fe49276()
{
    utility::function_7c10ea82c1e305b8( "ddos", "disabled" );
    
    if ( getdvarint( @"hash_10320e52e3e9ab5c", 0 ) == 0 )
    {
        if ( isdefined( self.occupants ) )
        {
            if ( getdvarint( @"hash_6434c2bc75e4ba1", !isbrgamemode() ) )
            {
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
                vehicle_omnvar::show_warning( "DDoSed", occupants, vehicle::get_ref() );
            }
            
            vehicle_occupancy::allow_movement( self, 0, 1 );
            vehicle_occupancy::disable_engine();
        }
    }
}

// Namespace vehicle_hack
// Params 1, eflags: 0x4
// Checksum 0x33f99f99, Offset: 0x1ad
// Size: 0x92
function private function_26e7b2e184e20cd3( var_39bf183c57b8c062 )
{
    if ( var_39bf183c57b8c062 )
    {
        utility::function_7c10ea82c1e305b8( "ddos", "neutral" );
    }
    
    if ( getdvarint( @"hash_10320e52e3e9ab5c", 0 ) == 0 )
    {
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
        
        if ( getdvarint( @"hash_6434c2bc75e4ba1", !isbrgamemode() ) )
        {
            vehicle_omnvar::hide_warning( "DDoSed", occupants, vehicle::get_ref() );
        }
        
        vehicle_occupancy::allow_movement( self, 1, 1 );
        vehicle_occupancy::enable_engine();
        
        if ( occupants.size )
        {
            vehicle_occupancy::turn_engine_on();
        }
    }
}

// Namespace vehicle_hack
// Params 0
// Checksum 0xa6e88a58, Offset: 0x247
// Size: 0x38
function function_c0127e2aa29fa8b7()
{
    if ( !isdefined( self.var_ba1dad907bdda72c ) )
    {
        self.var_ba1dad907bdda72c = 0;
    }
    
    self.var_ba1dad907bdda72c++;
    
    if ( self.var_ba1dad907bdda72c == 1 )
    {
        function_9a290d9e2fe49276();
    }
}

// Namespace vehicle_hack
// Params 1
// Checksum 0xa6aebbdc, Offset: 0x287
// Size: 0x2d
function function_719a8b957386c2a6( var_39bf183c57b8c062 )
{
    self.var_ba1dad907bdda72c--;
    
    if ( self.var_ba1dad907bdda72c == 0 )
    {
        function_26e7b2e184e20cd3( var_39bf183c57b8c062 );
    }
}

// Namespace vehicle_hack
// Params 0, eflags: 0x4
// Checksum 0x8ffb6b10, Offset: 0x2bc
// Size: 0x49
function private neutralize_vehicle()
{
    function_c0127e2aa29fa8b7();
    
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = 1;
    }
    
    if ( isdefined( self.occupants ) )
    {
        vehicle_occupancy::allow_movement( self, 0, 0, self.var_61bbe14900381e41 );
        vehicle_occupancy::function_92ebe8fd4c9a3c7e( 0 );
    }
}

// Namespace vehicle_hack
// Params 1, eflags: 0x4
// Checksum 0xef738416, Offset: 0x30d
// Size: 0x49
function private enable_vehicle( var_39bf183c57b8c062 )
{
    function_719a8b957386c2a6( var_39bf183c57b8c062 );
    
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = undefined;
    }
    
    vehicle_occupancy::allow_movement( self, 1 );
    vehicle_occupancy::function_92ebe8fd4c9a3c7e( 1 );
    self.var_a3ee9268d358650a = undefined;
}

// Namespace vehicle_hack
// Params 0, eflags: 0x4
// Checksum 0x73300a0d, Offset: 0x35e
// Size: 0x38
function private function_7b1b103aa7fb5210()
{
    if ( !isdefined( self.var_a3ee9268d358650a ) )
    {
        self.var_a3ee9268d358650a = 0;
    }
    
    self.var_a3ee9268d358650a++;
    
    if ( self.var_a3ee9268d358650a == 1 )
    {
        neutralize_vehicle();
    }
}

// Namespace vehicle_hack
// Params 1, eflags: 0x4
// Checksum 0xce397cde, Offset: 0x39e
// Size: 0x3c
function private function_79a287650c7855f1( var_39bf183c57b8c062 )
{
    if ( !isdefined( self.var_a3ee9268d358650a ) )
    {
        return;
    }
    
    self.var_a3ee9268d358650a--;
    
    if ( self.var_a3ee9268d358650a == 0 )
    {
        enable_vehicle( var_39bf183c57b8c062 );
    }
}

// Namespace vehicle_hack
// Params 2
// Checksum 0x3b08a2d8, Offset: 0x3e2
// Size: 0x47
function vehicle_hack( hackeffect, attacker )
{
    if ( hackeffect.var_bdd964bba0312052 )
    {
        thread function_b0ada8e8de0ef0e6( hackeffect );
        return;
    }
    
    if ( isdefined( hackeffect.speedscale ) )
    {
        thread function_dbcbd62d080e141( hackeffect );
    }
}

// Namespace vehicle_hack
// Params 1, eflags: 0xc
// Checksum 0xeb3663e1, Offset: 0x431
// Size: 0x7a
function private function_b0ada8e8de0ef0e6( hackeffect )
{
    self notify( #"hash_db52baac53e5b246" );
    self endon( #"hash_db52baac53e5b246" );
    level endon( #"game_ended" );
    self endon( #"death" );
    function_74bb56b044d8ee81();
    self.var_dc7f55c0fbdacc8e = 1;
    function_7b1b103aa7fb5210();
    wait hackeffect.hackduration * 0.001;
    function_79a287650c7855f1( 1 );
    self.var_dc7f55c0fbdacc8e = undefined;
}

// Namespace vehicle_hack
// Params 0, eflags: 0x4
// Checksum 0xe9c2e5c4, Offset: 0x4b3
// Size: 0x17
function private function_74bb56b044d8ee81()
{
    if ( self.var_dc7f55c0fbdacc8e )
    {
        function_79a287650c7855f1( 1 );
    }
}

// Namespace vehicle_hack
// Params 1, eflags: 0xc
// Checksum 0x1fc746c9, Offset: 0x4d2
// Size: 0x185
function private function_dbcbd62d080e141( hackeffect )
{
    self notify( #"hash_ad7a68dddb0811c4" );
    self endon( #"hash_ad7a68dddb0811c4" );
    level endon( #"game_ended" );
    self endon( #"death" );
    function_c823d34fdcfe2322();
    self.var_5874d4ade4d39f5c = 1;
    self.var_d92971aa060653fd = 1;
    function_c0127e2aa29fa8b7();
    hackduration = hackeffect.hackduration * 0.001;
    
    if ( self hascomponent( "p2p" ) )
    {
        if ( !isdefined( self.var_cc53a6339232a74 ) )
        {
            self.var_cc53a6339232a74 = self function_24e10bf6894fa869( "p2p", "manualSpeed" ) * 0.056818;
        }
        
        var_57a2a6e273ca3046 = self.var_cc53a6339232a74 * hackeffect.speedscale;
        vehicle::vehicle_set_speed( var_57a2a6e273ca3046 );
    }
    else
    {
        var_64995079a0bda966 = self vehicle_gettopspeedforward( 1 );
        var_b8b272237f683045 = var_64995079a0bda966 * hackeffect.speedscale;
        self vehicle_settopspeedforward( var_b8b272237f683045 );
        var_7f602d542422fe8a = self vehicle_getspeed();
        
        if ( var_7f602d542422fe8a > var_b8b272237f683045 )
        {
            self vehicle_setspeedimmediate( var_b8b272237f683045 );
        }
    }
    
    wait hackduration;
    
    if ( self hascomponent( "p2p" ) )
    {
        vehicle::vehicle_set_speed( self.var_cc53a6339232a74 );
        self.var_cc53a6339232a74 = undefined;
    }
    else if ( var_64995079a0bda966 )
    {
        self vehicle_settopspeedforward( var_64995079a0bda966 );
    }
    
    function_719a8b957386c2a6( 1 );
    self.var_d92971aa060653fd = undefined;
    self.var_5874d4ade4d39f5c = undefined;
}

// Namespace vehicle_hack
// Params 0, eflags: 0x4
// Checksum 0x65580694, Offset: 0x65f
// Size: 0x17
function private function_c823d34fdcfe2322()
{
    if ( self.var_5874d4ade4d39f5c )
    {
        function_719a8b957386c2a6( 1 );
    }
}

// Namespace vehicle_hack
// Params 1
// Checksum 0xbe00e71a, Offset: 0x67e
// Size: 0x78
function chaff_start_callback( data )
{
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = 1;
    }
    
    utility::function_7c10ea82c1e305b8( "ddos", "disabled" );
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
    vehicle_omnvar::show_warning( "movementDisabled", occupants, vehicle::get_ref() );
    vehicle_occupancy::allow_movement( self, 0, 0, self.var_61bbe14900381e41 );
    vehicle_occupancy::function_92ebe8fd4c9a3c7e( 0 );
}

// Namespace vehicle_hack
// Params 1
// Checksum 0x84f699d, Offset: 0x6fe
// Size: 0x75
function function_c0b7001382e8c258( fromdeath )
{
    if ( !fromdeath )
    {
        utility::function_7c10ea82c1e305b8( "ddos", "neutral" );
    }
    
    if ( isdefined( self.reactivearmor ) )
    {
        self.reactivearmordisabled = undefined;
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
    vehicle_omnvar::hide_warning( "movementDisabled", occupants, vehicle::get_ref() );
    vehicle_occupancy::allow_movement( self, 1 );
    vehicle_occupancy::function_92ebe8fd4c9a3c7e( 1 );
}

// Namespace vehicle_hack
// Params 1
// Checksum 0x74f9f119, Offset: 0x77b
// Size: 0x4c
function emp_start_callback( data )
{
    if ( utility::issharedfuncdefined( #"emp", #"onvehicleemped" ) )
    {
        self [[ utility::getsharedfunc( #"emp", #"onvehicleemped" ) ]]( data );
    }
    
    function_7b1b103aa7fb5210();
}

// Namespace vehicle_hack
// Params 1
// Checksum 0xac565ec0, Offset: 0x7cf
// Size: 0x7b
function function_9bbdc002b60edf61( data )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    data.damage = 800;
    self dodamage( data.damage, data.attacker.origin, data.attacker, data.objweapon, "MOD_EXPLOSIVE", data.objweapon, "none", undefined, 524288, undefined );
}

// Namespace vehicle_hack
// Params 0
// Checksum 0x3e93efb, Offset: 0x852
// Size: 0xb
function emp_remove_callback()
{
    function_79a287650c7855f1( 1 );
}

// Namespace vehicle_hack
// Params 1
// Checksum 0xa877f0ce, Offset: 0x865
// Size: 0xc7
function haywire_applied( data )
{
    vehicle = data.victim;
    
    if ( vehicle.ishaywire || vehicle.var_81ac52e14bcb4f1c )
    {
        return;
    }
    
    vehicle.ishaywire = 1;
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    vehicle_omnvar::show_warning( "shockStickAttached", occupants, vehicle vehicle::get_ref() );
    vehicle.var_52dfac12181e4ef9 = vehicle vehicle_gettopspeedforward();
    vehicle.var_80f99dc346cf1422 = vehicle vehicle_gettopspeedreverse();
    vehicle vehicle_settopspeedforward( 10 );
    vehicle vehicle_settopspeedreverse( 10 );
    vehicle utility::function_7c10ea82c1e305b8( "haywire", "on" );
}

// Namespace vehicle_hack
// Params 1
// Checksum 0xb35b866f, Offset: 0x934
// Size: 0xaa
function haywire_cleared( data )
{
    vehicle = data.victim;
    
    if ( !isdefined( vehicle ) || vehicle.var_81ac52e14bcb4f1c )
    {
        return;
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    vehicle_omnvar::hide_warning( "shockStickAttached", occupants, vehicle vehicle::get_ref() );
    maxspeedforward = vehicle vehicle_gettopspeedforward( 1 );
    maxspeedreverse = vehicle vehicle_gettopspeedreverse( 1 );
    vehicle vehicle_settopspeedforward( maxspeedforward );
    vehicle vehicle_settopspeedreverse( maxspeedreverse );
    vehicle utility::function_7c10ea82c1e305b8( "haywire", "off" );
}

