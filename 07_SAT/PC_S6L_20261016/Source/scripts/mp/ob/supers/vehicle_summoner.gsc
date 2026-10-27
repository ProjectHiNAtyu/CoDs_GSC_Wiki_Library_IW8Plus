// scripts\mp\ob\supers\vehicle_summoner.gsc  (hash_74eca725bf4bee7c.gscc) (size: 10071 Bytes / 0x2757 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe858bfef (3898130415)
// size ...... 10071 (0x2757)
// includes .. 13  (offset: 0x25b3)
// strings ... 18  (offset: 0x261b)
// dev strs .. 3   (offset: 0x2733)
// exports ... 28  (offset: 0x15e7)
// cseg ...... 0x206 + 0x13e1 (0x15e7)
// imports ... 99  (offset: 0x1a47)
// animtree1 . 0   (offset: 0x2757)
// animtree2 . 0   (offset: 0x2757)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;

#namespace vehicle_summoner;

// Namespace vehicle_summoner
// Params 0, eflags: 0x5
// Checksum 0x53681cfb, Offset: 0x224
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x817e62fd, Offset: 0x244
// Size: 0xb8
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_vehicle_summoner", undefined, undefined, &begin_use );
    supers_mp::registersuperextraweapon( "super_vehicle_summoner", "dirt_bike_mp" );
    supers_mp::registersuperextraweapon( "super_vehicle_summoner", "super_sat_blood_burner_aetherpulse" );
    level callback::add( #"on_ai_killed", &kill_by_vehicle );
    level callback::add( #"player_death", &kill_by_vehicle );
    level callback::add( #"player_vehicle_enter", &enter_vehicle );
    level callback::add( #"player_vehicle_exit", &exit_vehicle );
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0xf2f32264, Offset: 0x304
// Size: 0x51
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    init_data();
    initialize_fx( bundle );
    
    if ( function_8848e63a90a7de13() )
    {
        return spawn_vehicle();
    }
    
    function_999387294357da87();
    return 0;
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0xe7bc1182, Offset: 0x35e
// Size: 0x101
function private cancel( params )
{
    self notify( #"cancel_vehicle_summoner" );
    
    if ( self.var_aa5b1ad67e8382a8 )
    {
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self.var_aa5b1ad67e8382a8, 0 );
        
        if ( isdefined( occupants ) )
        {
            foreach ( occupant in occupants )
            {
                vehicle_occupancy::exit( self.var_aa5b1ad67e8382a8, undefined, occupant, undefined, 1 );
            }
        }
        
        self.var_aa5b1ad67e8382a8 delete();
        self.var_aa5b1ad67e8382a8 = undefined;
    }
    
    if ( self.var_55ec876aa23b7e23 )
    {
        self.var_55ec876aa23b7e23 destroy_chute();
        self.var_55ec876aa23b7e23 = undefined;
    }
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x8caa4a8f, Offset: 0x467
// Size: 0x154
function private init_data()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
    assert( isdefined( bundle.var_1f377d00ae0ba8aa ), "<dev string:x84>" );
    self.var_3ad218a44938a44e = { #var_c18df4ab2cf8436d:bundle.var_a105bdfe87c322f4, #enableejection:bundle.var_bfdf7b0b85914760, #var_22f5cfddb8a7fd1a:bundle.var_56122b2a3efaacda, #var_f72853afd883a8c:bundle.var_ce6c597f3eb43b4c, #var_939ac182e20cbe7c:bundle.var_c652fd63dc5b403c, #var_89deb1013f125984:bundle.var_2f74734be3cafa98, #vehicleduration:bundle.var_f2621ba7627a50ae, #var_9562450d4e201797:bundle.var_46b1606971d99e27, #var_6e245ad662b1d09a:bundle.var_36ffa7bb4bc71b9a, #var_dcff4c45efac6acd:bundle.var_467305ddd5ba625b, #chutexmodel:bundle.var_f4cb06becb256792, #delaytime:bundle.var_8909831655a3e58, #spawnheight:bundle.var_84b3c10a62d43dfa, #var_7d289323649cc2ec:bundle.var_1f377d00ae0ba8aa };
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x3b8738df, Offset: 0x5c3
// Size: 0x4a, Type: bool
function private function_8848e63a90a7de13()
{
    if ( level.vehiclespawndisabled )
    {
        return false;
    }
    
    if ( !self isonground() || self isskydiving() || self isswimming() || self ishanging() || self isvehicleactive() || self isonladder() )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x4f2770f8, Offset: 0x616
// Size: 0x2b1, Type: bool
function private spawn_vehicle()
{
    self endon( #"cancel_vehicle_summoner" );
    
    if ( vehicle_spawn::can_spawn_vehicle( self.var_3ad218a44938a44e.var_7d289323649cc2ec ) )
    {
        var_36819b40b4a7489b = vehicle::get_data( self.var_3ad218a44938a44e.var_7d289323649cc2ec );
        
        if ( !isdefined( var_36819b40b4a7489b.vehicle ) && !isdefined( var_36819b40b4a7489b.vehicleoverride ) )
        {
            function_999387294357da87();
            return false;
        }
        
        var_fe716a66badfe41d = getdvarint( @"hash_62e600f6825dd208", 0 ) == 1;
        var_ecf786cdad75e291 = get_correct_position();
        correct_position = var_ecf786cdad75e291;
        
        if ( isdefined( self.var_3ad218a44938a44e.spawnheight ) && correct_position && var_fe716a66badfe41d )
        {
            correct_position += ( 0, 0, self.var_3ad218a44938a44e.spawnheight );
        }
        
        if ( isdefined( correct_position ) )
        {
            destroy_vehicle();
            spawn_data = spawnstruct();
            spawn_data.origin = correct_position;
            spawn_data.angles = self.angles;
            spawn_data.owner = self;
            
            if ( self.var_3ad218a44938a44e.delaytime )
            {
                wait self.var_3ad218a44938a44e.delaytime;
            }
            
            if ( var_fe716a66badfe41d )
            {
                chute = create_chute( spawn_data );
            }
            
            if ( self.var_3ad218a44938a44e.var_939ac182e20cbe7c )
            {
                self playsoundevent( self.var_3ad218a44938a44e.var_939ac182e20cbe7c );
            }
            
            spawned_vehicle = vehicle::spawn( self.var_3ad218a44938a44e.var_7d289323649cc2ec, spawn_data );
            spawned_vehicle.var_f39bb880c3d3c092 = self;
            spawned_vehicle.var_f1c2227e07d1be4f = [];
            spawned_vehicle.var_7f5ce6ddfce8ac62 = [];
            self.var_aa5b1ad67e8382a8 = spawned_vehicle;
            
            if ( var_fe716a66badfe41d )
            {
                chute thread function_e8149a9f7118b3bf( spawned_vehicle, self.var_3ad218a44938a44e.var_dcff4c45efac6acd );
                chute animate_chute();
                spawned_vehicle thread function_f2dadc090548ef87( var_ecf786cdad75e291, self.var_3ad218a44938a44e.var_6e245ad662b1d09a );
                thread function_ded3efd3c87a688c( var_ecf786cdad75e291, spawned_vehicle, 1 );
                chute thread chute_disappears( spawned_vehicle );
                self.var_55ec876aa23b7e23 = chute;
            }
            else
            {
                thread function_ded3efd3c87a688c( var_ecf786cdad75e291, spawned_vehicle, 0 );
            }
            
            change_health();
            spawned_vehicle.var_2f93269fa97c970d = gettime() / 1000;
            spawned_vehicle thread function_f064792b086e7333( self );
            spawned_vehicle thread function_dc0b237d388b32aa( self );
            return true;
        }
    }
    
    function_999387294357da87();
    return false;
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x438dc4a6, Offset: 0x8d0
// Size: 0xf8
function private get_correct_position()
{
    player_origin = self.origin + ( 0, 0, 20 );
    forward_vector = anglestoforward( self.angles );
    spawn_position = player_origin + forward_vector * getdvarint( @"hash_4cb8de5bd3ff566c", 125 );
    raycast_hit = trace::ray_trace( player_origin, spawn_position, undefined, undefined, undefined, undefined, 1 );
    
    if ( raycast_hit[ "normal" ] != ( 0, 0, 0 ) )
    {
        spawn_position = function_ecb8915514dc0929( raycast_hit, player_origin );
    }
    
    var_34f80c5693214481 = trace::ray_trace( spawn_position, spawn_position + ( 0, 0, 1500 ) )[ "normal" ];
    
    if ( var_34f80c5693214481 == ( 0, 0, 0 ) )
    {
        if ( function_d2b3888a244a0e96( spawn_position ) )
        {
            return vehicle::drop_to_ground( self.var_3ad218a44938a44e.var_7d289323649cc2ec, spawn_position );
        }
    }
}

// Namespace vehicle_summoner
// Params 2, eflags: 0x4
// Checksum 0xd10a8fc3, Offset: 0x9d1
// Size: 0x4f
function private function_ecb8915514dc0929( raycast_hit, player_origin )
{
    dist = distance2d( player_origin, raycast_hit[ "position" ] );
    safe_distance = dist / 2;
    return raycast_hit[ "position" ] + raycast_hit[ "normal" ] * safe_distance;
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x26dfba5a, Offset: 0xa29
// Size: 0xb7, Type: bool
function private function_d2b3888a244a0e96( spawn_position )
{
    var_1ee22348ced85e75 = utility::drop_to_ground( spawn_position );
    is_point_in_fov = math::point_in_fov( var_1ee22348ced85e75, cos( 45 ), 1 );
    var_8cdf4d67df2a2a78 = outofbounds::ispointinoutofbounds( var_1ee22348ced85e75 );
    is_point_in_water = utility::ispointinwater( var_1ee22348ced85e75 );
    contents = physics_createcontents( [ "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    
    if ( is_point_in_fov && !var_8cdf4d67df2a2a78 && vehicle_spawn::function_c49e68f891a06e6f( var_1ee22348ced85e75, self.var_3ad218a44938a44e.var_7d289323649cc2ec, contents ) && !is_point_in_water )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x1cae84e2, Offset: 0xae9
// Size: 0x5f
function private create_chute( spawn_data )
{
    chute = spawn( "script_model", spawn_data.origin );
    chute.angles = spawn_data.origin;
    chute setmodel( self.var_3ad218a44938a44e.chutexmodel );
    return chute;
}

// Namespace vehicle_summoner
// Params 2, eflags: 0x4
// Checksum 0xe9afbaf, Offset: 0xb51
// Size: 0x86
function private function_e8149a9f7118b3bf( vehicle, detach_time )
{
    if ( !isdefined( detach_time ) )
    {
        assertmsg( "<dev string:xb3>" );
        detach_time = 2;
    }
    
    self linkto( vehicle, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    utility::waittill_notify_or_timeout( "death", detach_time );
    vehicle notify( #"stop_move_object" );
    
    if ( self )
    {
        self unlink();
    }
    
    vehicle notify( #"hash_d394761b832792aa" );
}

// Namespace vehicle_summoner
// Params 3, eflags: 0x4
// Checksum 0x92a08957, Offset: 0xbdf
// Size: 0x184
function private function_ded3efd3c87a688c( finish_position, vehicle, waitforchute )
{
    if ( waitforchute )
    {
        self.var_aa5b1ad67e8382a8 waittill( #"hash_d394761b832792aa" );
    }
    
    if ( self.var_aa5b1ad67e8382a8 )
    {
        if ( waitforchute && self.var_3ad218a44938a44e.var_9562450d4e201797 )
        {
            self.var_aa5b1ad67e8382a8 function_f2dadc090548ef87( finish_position, self.var_3ad218a44938a44e.var_9562450d4e201797 );
        }
    }
    
    fx_position = finish_position;
    
    if ( self.var_3ad218a44938a44e.var_89deb1013f125984 )
    {
        fx_position = finish_position + ( 0, 0, self.var_3ad218a44938a44e.var_89deb1013f125984 );
    }
    
    if ( self.var_3ad218a44938a44e.var_f72853afd883a8c )
    {
        self playsoundevent( self.var_3ad218a44938a44e.var_f72853afd883a8c );
    }
    
    if ( self isskydiving() || self iswingsuitdeployed() || self isparachutedeployed() || self isswimming() || vehicle::is_in_vehicle( 1 ) || self isonladder() || player::isinlaststand( self ) )
    {
        vehicle notify( #"hash_e67e0494c7e2208d" );
        destroy_vehicle();
        return 0;
    }
    
    self function_b14dead5d492aa48( 1 );
    thread vehicle_occupancy::enter( vehicle, "driver", self, undefined, 1 );
    self function_b14dead5d492aa48( 0 );
    vehicle.playerentered = 1;
    thread function_dab2110dd0635f7a( fx_position );
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x8e35d325, Offset: 0xd6b
// Size: 0x44
function private animate_chute()
{
    blend_type = animation::function_cd8b99431e720772( "care_package_chute", "care_package_drop" );
    utility::self_func( "scriptModelPlayAnim", level.scr_anim[ "care_package_chute" ][ "care_package_drop" ], undefined, 7, blend_type );
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0xc587af0, Offset: 0xdb7
// Size: 0x5b
function private chute_disappears( vehicle )
{
    self endon( #"death" );
    vehicle waittill( #"hash_d394761b832792aa" );
    finish_position = self.origin + ( 0, 0, 5000 );
    function_f2dadc090548ef87( finish_position, 4 );
    destroy_chute();
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x1e042282, Offset: 0xe1a
// Size: 0x21
function private destroy_chute()
{
    self setscriptablepartstate( #"visibility", #"hide", 0 );
    self delete();
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x8d21188f, Offset: 0xe43
// Size: 0x1f
function private destroy_vehicle()
{
    if ( isdefined( self.var_aa5b1ad67e8382a8 ) )
    {
        self.var_aa5b1ad67e8382a8 vehicle::explode();
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x789b3920, Offset: 0xe6a
// Size: 0x5a
function private function_dab2110dd0635f7a( position )
{
    if ( utility::fxexists( "vehicle_summoner_spawn_fx" ) )
    {
        playfx( utility::getfx( "vehicle_summoner_spawn_fx" ), position, anglestoforward( self.var_aa5b1ad67e8382a8.angles ), anglestoup( self.var_aa5b1ad67e8382a8.angles ) );
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x9a256be7, Offset: 0xecc
// Size: 0x4e
function private initialize_fx( bundle )
{
    if ( isdefined( level._effect[ "vehicle_summoner_spawn_fx" ] ) )
    {
        return;
    }
    
    if ( isdefined( bundle.var_15eaec6a8e65a06b ) )
    {
        level._effect[ "vehicle_summoner_spawn_fx" ] = loadfxasset( bundle.var_15eaec6a8e65a06b );
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0xd84670c, Offset: 0xf22
// Size: 0x21d
function private enter_vehicle( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
    
    if ( isdefined( params.vehicle.var_f39bb880c3d3c092 ) && !arraycontains( params.vehicle.var_f1c2227e07d1be4f, params.player ) )
    {
        if ( params.player == params.vehicle.var_f39bb880c3d3c092 )
        {
            params.player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_af46789c2b6936bc );
        }
        else if ( !params.vehicle.var_f39bb880c3d3c092 player_utility::isenemy( params.player ) && !arraycontains( params.vehicle.var_7f5ce6ddfce8ac62, params.player ) )
        {
            if ( !isdefined( params.vehicle.var_7f5ce6ddfce8ac62 ) )
            {
                params.vehicle.var_7f5ce6ddfce8ac62 = [];
            }
            
            params.vehicle.var_7f5ce6ddfce8ac62[ params.vehicle.var_7f5ce6ddfce8ac62.size ] = params.player;
            params.vehicle.var_f39bb880c3d3c092 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_b771af07d46d71e2 );
        }
        
        if ( !isdefined( params.vehicle.var_f1c2227e07d1be4f ) )
        {
            params.vehicle.var_f1c2227e07d1be4f = [];
        }
        
        params.vehicle.var_f1c2227e07d1be4f[ params.vehicle.var_f1c2227e07d1be4f.size ] = params.player;
        params.player callback::callback( "super_vehicle_summoner_enter_passenger", { #vehicle:params.vehicle } );
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x2573ce02, Offset: 0x1147
// Size: 0xb3
function private exit_vehicle( params )
{
    if ( isdefined( params.vehicle.var_f39bb880c3d3c092 ) && arraycontains( params.vehicle.var_f1c2227e07d1be4f, params.player ) )
    {
        params.vehicle.var_f1c2227e07d1be4f = arrayremove( params.vehicle.var_f1c2227e07d1be4f, params.player );
        params.player callback::callback( "super_vehicle_summoner_exit_passenger", { #vehicle:params.vehicle } );
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x29d8f542, Offset: 0x1202
// Size: 0x12b
function private kill_by_vehicle( params )
{
    if ( !isdefined( params.victim ) )
    {
        return;
    }
    
    attacker = params.attacker ?? params.eattacker;
    inflictor = params.inflictor ?? params.einflictor;
    
    if ( !isdefined( attacker ) && !isdefined( inflictor ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) && attacker player_utility::isenemy( params.victim ) && isdefined( inflictor.var_f1c2227e07d1be4f ) && arraycontains( inflictor.var_f1c2227e07d1be4f, attacker ) )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
        
        if ( attacker.var_aa5b1ad67e8382a8 == inflictor )
        {
            attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_265b0031114c6fa8 );
            return;
        }
        
        if ( !inflictor.var_f39bb880c3d3c092 player_utility::isenemy( attacker ) )
        {
            inflictor.var_f39bb880c3d3c092 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_a74fe1db02065693 );
        }
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x2ffa37f6, Offset: 0x1335
// Size: 0x7f
function private function_dc0b237d388b32aa( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self waittill( #"hash_e67e0494c7e2208d" );
    player thread supers_mp::superusefinished( undefined, undefined, undefined, 1, undefined, undefined, #"tactical" );
    
    if ( player.var_3ad218a44938a44e.var_22f5cfddb8a7fd1a )
    {
        player playsoundevent( player.var_3ad218a44938a44e.var_22f5cfddb8a7fd1a );
    }
}

// Namespace vehicle_summoner
// Params 1, eflags: 0x4
// Checksum 0x44e0da65, Offset: 0x13bc
// Size: 0xba
function private function_f064792b086e7333( player )
{
    level endon( #"game_ended" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_vehicle_summoner" );
    
    if ( !bundle.var_8b9eade13fbfb044 )
    {
        return;
    }
    
    waitframe();
    
    if ( player && !player callback::exists( #"super_cancel", &cancel ) )
    {
        player callback::add( #"super_cancel", &cancel );
    }
    
    self waittill( #"death" );
    
    if ( player && player callback::exists( #"super_cancel", &cancel ) )
    {
        player callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x81472f58, Offset: 0x147e
// Size: 0x6c
function private change_health()
{
    if ( isdefined( self.var_f6ce3f6c3c2ead86.bundle.var_31b3947af6712f08 ) )
    {
        self.var_aa5b1ad67e8382a8.health = int( self.var_aa5b1ad67e8382a8.health * self.var_f6ce3f6c3c2ead86.bundle.var_31b3947af6712f08 );
    }
}

// Namespace vehicle_summoner
// Params 0, eflags: 0x4
// Checksum 0x19838de, Offset: 0x14f2
// Size: 0x3e
function private function_999387294357da87()
{
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "SUPER_MP/VEHICLE_SUMMONER_CANNOT_USE" );
    }
}

// Namespace vehicle_summoner
// Params 2, eflags: 0x4
// Checksum 0x3437b183, Offset: 0x1538
// Size: 0xaf
function private function_f2dadc090548ef87( finish_pos, moving_time )
{
    self endon( #"stop_move_object" );
    self endon( #"death" );
    
    if ( !isdefined( moving_time ) )
    {
        self.origin = finish_pos;
        return;
    }
    
    time_since_start = 0;
    time_progress = 0;
    origin_position = self.origin;
    
    while ( time_progress < 1 )
    {
        time_progress = clamp( time_since_start / moving_time, 0, 1 );
        new_position = vectorlerp( origin_position, finish_pos, time_progress );
        self.origin = new_position;
        time_since_start += level.framedurationseconds;
        waitframe();
    }
}

