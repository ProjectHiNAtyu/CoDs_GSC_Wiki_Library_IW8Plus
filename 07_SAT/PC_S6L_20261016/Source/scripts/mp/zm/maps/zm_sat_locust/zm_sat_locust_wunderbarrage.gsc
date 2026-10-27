// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_wunderbarrage.gsc  (hash_3b96202841389309.gscc) (size: 11175 Bytes / 0x2ba7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e0b702 (132167426)
// size ...... 11175 (0x2ba7)
// includes .. 10  (offset: 0x29a7)
// strings ... 26  (offset: 0x29f7)
// dev strs .. 7   (offset: 0x2b53)
// exports ... 27  (offset: 0x1a97)
// cseg ...... 0x1de + 0x18b9 (0x1a97)
// imports ... 94  (offset: 0x1ecf)
// animtree1 . 0   (offset: 0x2ba7)
// animtree2 . 0   (offset: 0x2ba7)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\damage;
#using scripts\mp\zm\systems\killstreaks\zm_robot_controller;

#namespace zm_sat_locust_wunderbarrage;

// Namespace zm_sat_locust_wunderbarrage
// Params 0, eflags: 0x1
// Checksum 0x2934a8bc, Offset: 0x1fc
// Size: 0x1ef
function autoexec function_98f57e10a268a5f9()
{
    level.robot_wunderbarrage = { #damage_percent_hvt:getdvarfloat( @"hash_56d60427f7baa14d", 0.1 ), #damage_percent_elite:getdvarfloat( @"hash_6e0bbf8264c760ec", 0.12 ), #damage_percent_special:getdvarfloat( @"hash_f84a9bab075154a8", 0.15 ), #all_missiles_fired:0, #is_active:0, #active_missile_count:0, #map_circle:{} };
    level.robot_wunderbarrage.defaults = { #var_991e405c8748a065:15000, #var_8e0c26679c09073:200, #var_7725a85501c8adf:1, #var_763844b3b672e0c:0, #var_31e5c2b466a0410e:1, #danger_zone_radius:getdvarint( @"hash_3dfdfed394930525", 250 ) * ( getdvarint( @"hash_b8b2fbd228d1104d", 4 ) - 2 ), #var_c6318ece6fa18364:getdvarfloat( @"hash_33f746b6c707743f", 1.5 ), #var_2a1b17b60632a51d:getdvarint( @"hash_b8b2fbd228d1104d", 4 ), #var_cc48735c9f8faaca:getdvarint( @"hash_77c45c6824cbaa3f", 5 ), #column_offset:getdvarint( @"hash_a8244137889b4685", 200 ), #row_offset:getdvarint( @"hash_3dfdfed394930525", 250 ), #var_a0ac878e7d67dc58:&calculate_target_position, #var_cf575fe32b17bb8d:0.75, #required_target_radius:50, #turret_owners:[] };
    level thread init_turret_locations();
    damage::register_scripted_damage_override_func( &wunderbarrage_player_damage_override );
    level callback::add( "on_zombie_ai_damaged", &function_aa182f086ff4b866 );
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
    
    /#
        level thread function_31ef032d3cc7d0be();
    #/
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0, eflags: 0x4
// Checksum 0x4875f8d0, Offset: 0x3f3
// Size: 0x9d
function private init_turret_locations()
{
    waitframe();
    var_58ce0e97d79cabbc = utility::getstructarray( "robot_rocket_tube" );
    
    foreach ( var_68668f1c01bf4127 in var_58ce0e97d79cabbc )
    {
        level.robot_wunderbarrage.defaults function_16feb079ca810058( var_68668f1c01bf4127 );
    }
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1
// Checksum 0x6247b9d, Offset: 0x498
// Size: 0xc8
function function_16feb079ca810058( turret_location )
{
    if ( isstruct( turret_location ) )
    {
        turret_location.angles = ( -90, 0, 90 );
        turret_chain = [ turret_location ];
        
        while ( isdefined( turret_location.target ) )
        {
            turret_location = utility::getstruct( turret_location.target );
            turret_chain[ turret_chain.size ] = turret_location;
        }
        
        assert( turret_chain.size == level.robot_wunderbarrage.defaults.var_2a1b17b60632a51d, "<dev string:x24>" );
    }
    else
    {
        turret_location = spawn_turret_owner( turret_location );
        turret_chain = [ turret_location ];
    }
    
    self.turret_owners[ self.turret_owners.size ] = turret_chain;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1, eflags: 0x4
// Checksum 0x8dde0bfb, Offset: 0x568
// Size: 0x3c
function private spawn_turret_owner( position )
{
    turret_owner = { #angles:( -90, 0, 90 ), #origin:position };
    return turret_owner;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0
// Checksum 0x9288580d, Offset: 0x5ad
// Size: 0xb2
function function_a7c497cce084d54f()
{
    foreach ( turret_owner in self.turret_owners )
    {
        if ( isdefined( turret_owner.launch_target_ent ) )
        {
            turret_owner.launch_target_ent delete();
        }
        
        turret_owner.turret_ent delete();
        turret_owner delete();
    }
    
    self.turret_owners = [];
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1
// Checksum 0x55215d39, Offset: 0x667
// Size: 0x25
function function_4da539d788e7778f( var_a7b26daee63d35b3 )
{
    assert( isfunction( var_a7b26daee63d35b3 ) );
    self.var_a0ac878e7d67dc58 = var_a7b26daee63d35b3;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 5
// Checksum 0x696aef32, Offset: 0x694
// Size: 0x35c
function launch_wunderbarrage( wunderbarrage_data_struct = level.robot_wunderbarrage.defaults, initiating_player, var_bcc67706b1cfd911, final_position_override, var_7308e4058fd91ecc )
{
    level endon( #"game_ended" );
    level notify( #"wunderbarrage_started" );
    
    if ( !isdefined( initiating_player ) )
    {
        initiating_player = level.players[ 0 ];
    }
    
    if ( !isdefined( final_position_override ) )
    {
        final_position_override = [[ wunderbarrage_data_struct.var_a0ac878e7d67dc58 ]]( wunderbarrage_data_struct, initiating_player );
    }
    
    if ( !isdefined( var_7308e4058fd91ecc ) )
    {
        var_7308e4058fd91ecc = wunderbarrage_data_struct.danger_zone_radius;
    }
    
    /#
        level notify( #"new_barrage" );
    #/
    
    launch_positions = isdefined( var_bcc67706b1cfd911 ) ? [ var_bcc67706b1cfd911 ] : wunderbarrage_data_struct.turret_owners[ randomint( wunderbarrage_data_struct.turret_owners.size ) ];
    
    if ( isfunction( wunderbarrage_data_struct.var_f3a4685889898e41 ) )
    {
        launch_positions = wunderbarrage_data_struct [[ wunderbarrage_data_struct.var_f3a4685889898e41 ]]();
    }
    
    landing_positions = function_1447e58042cd61c6( wunderbarrage_data_struct, initiating_player, launch_positions[ 0 ].origin, final_position_override );
    
    if ( wunderbarrage_data_struct.var_31e5c2b466a0410e )
    {
        wunderbarrage_data_struct thread quest_circle_warning( final_position_override, var_7308e4058fd91ecc );
    }
    
    var_2cfee48077cdfc76 = 0;
    wunderbarrage_data_struct.fired_missile_count = 0;
    level.robot_wunderbarrage.all_missiles_fired = 0;
    level.robot_wunderbarrage.is_active = 1;
    level.robot_wunderbarrage.owner = initiating_player;
    level.robot_wunderbarrage.kills = 0;
    
    while ( wunderbarrage_data_struct.fired_missile_count < wunderbarrage_data_struct.var_cc48735c9f8faaca * wunderbarrage_data_struct.var_2a1b17b60632a51d )
    {
        launch_pos = launch_positions.size == 1 ? launch_positions[ 0 ] : launch_positions[ var_2cfee48077cdfc76 ];
        landing_pos = landing_positions[ wunderbarrage_data_struct.fired_missile_count ];
        function_ca1a296b77ac2411( wunderbarrage_data_struct, initiating_player, launch_pos, final_position_override, landing_pos );
        wunderbarrage_data_struct.fired_missile_count++;
        wait randomfloatrange( 0.1, 0.2 );
        var_2cfee48077cdfc76++;
        
        if ( var_2cfee48077cdfc76 == wunderbarrage_data_struct.var_2a1b17b60632a51d )
        {
            var_2cfee48077cdfc76 = 0;
            wait wunderbarrage_data_struct.var_c6318ece6fa18364;
        }
    }
    
    level.robot_wunderbarrage.all_missiles_fired = 1;
    
    while ( level.robot_wunderbarrage.active_missile_count > 0 )
    {
        waitframe();
    }
    
    level.robot_wunderbarrage.is_active = 0;
    
    if ( level.robot_wunderbarrage.kills >= 5 )
    {
        if ( level.robot_wunderbarrage.owner && isplayer( level.robot_wunderbarrage.owner ) && isalive( level.robot_wunderbarrage.owner ) )
        {
            zm_robot_controller::play_player_banter( #"hash_f737622b095ae20e", level.robot_wunderbarrage.owner );
        }
    }
    
    level.robot_wunderbarrage.kills = 0;
    level.robot_wunderbarrage.owner = undefined;
    level notify( #"wunderbarrage_ended" );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 5
// Checksum 0xa89aaa85, Offset: 0x9f8
// Size: 0x349
function function_1447e58042cd61c6( wunderbarrage_data_struct = level.robot_wunderbarrage.defaults, initiating_player = level.players[ 0 ], launch_position, final_position_override = [[ wunderbarrage_data_struct.var_a0ac878e7d67dc58 ]]( wunderbarrage_data_struct, initiating_player ), var_8e5f4ab61d5d66ab = 1 )
{
    landing_positions = [];
    row_offset = wunderbarrage_data_struct.row_offset;
    column_offset = wunderbarrage_data_struct.column_offset;
    var_cc48735c9f8faaca = wunderbarrage_data_struct.var_cc48735c9f8faaca;
    var_2a1b17b60632a51d = wunderbarrage_data_struct.var_2a1b17b60632a51d;
    dir_target = ( final_position_override[ 0 ], final_position_override[ 1 ], 0 );
    dir_launch = ( launch_position[ 0 ], launch_position[ 1 ], 0 );
    projectile_direction = vectornormalize( dir_target - dir_launch );
    horz_direction = anglestoleft( vectortoangles( projectile_direction ) );
    var_254e6fa9737272de = var_2a1b17b60632a51d % 2 == 0;
    var_3e9b4ad12f11a839 = var_254e6fa9737272de ? column_offset * 0.5 : 0;
    starting_direction = var_8e5f4ab61d5d66ab ? projectile_direction : horz_direction;
    starting_pos = final_position_override + starting_direction * row_offset * -2;
    is_left = var_254e6fa9737272de;
    starting_pos_struct = { #origin:starting_pos };
    
    for ( i = 0; i < var_cc48735c9f8faaca ; i++ )
    {
        current_row_offset = row_offset * i;
        is_left = var_254e6fa9737272de;
        
        for ( idx = 0; idx < var_2a1b17b60632a51d ; idx++ )
        {
            if ( var_254e6fa9737272de )
            {
                var_489ef1e6e9ddf8cc = is_left ? column_offset * idx : column_offset * idx * -1;
                
                if ( idx == 0 || idx == 1 )
                {
                    var_489ef1e6e9ddf8cc += var_3e9b4ad12f11a839;
                }
                else if ( idx % 2 == 0 )
                {
                    multiplier = idx / 2 + 0.5;
                    var_489ef1e6e9ddf8cc = is_left ? column_offset * multiplier : column_offset * multiplier * -1;
                }
                else
                {
                    multiplier = idx / 2;
                    var_489ef1e6e9ddf8cc = is_left ? column_offset * multiplier : column_offset * multiplier * -1;
                }
            }
            else
            {
                var_489ef1e6e9ddf8cc = is_left ? column_offset * idx : column_offset * idx * -1;
                
                if ( idx > 0 )
                {
                    if ( idx % 2 == 0 )
                    {
                        multiplier = idx / 2;
                        var_489ef1e6e9ddf8cc = is_left ? column_offset * multiplier : column_offset * multiplier * -1;
                    }
                    else
                    {
                        multiplier = ( idx + 1 ) / 2;
                        var_489ef1e6e9ddf8cc = is_left ? column_offset * multiplier : column_offset * multiplier * -1;
                    }
                }
            }
            
            row_direction = var_8e5f4ab61d5d66ab ? projectile_direction : horz_direction;
            column_direction = var_8e5f4ab61d5d66ab ? horz_direction : projectile_direction;
            new_origin = starting_pos_struct.origin + row_direction * current_row_offset + column_direction * var_489ef1e6e9ddf8cc;
            var_674903a9ec146334 = { #origin:new_origin };
            landing_positions[ landing_positions.size ] = var_674903a9ec146334;
            
            /#
            #/
            
            is_left = !is_left;
        }
    }
    
    return landing_positions;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 5
// Checksum 0x19b760ca, Offset: 0xd4a
// Size: 0x281
function function_ca1a296b77ac2411( wunderbarrage_data_struct = level.robot_wunderbarrage.defaults, initiating_player = level.players[ 0 ], launch_pos = wunderbarrage_data_struct.turret_owners[ randomint( wunderbarrage_data_struct.turret_owners.size ) ][ 0 ], final_position_override = [[ wunderbarrage_data_struct.var_a0ac878e7d67dc58 ]]( wunderbarrage_data_struct, initiating_player ), landing_pos = { #origin:final_position_override } )
{
    launch_pos = launch_pos.origin;
    target_pos = landing_pos.origin;
    
    if ( isvector( target_pos ) )
    {
        dist = distance2d( launch_pos, target_pos );
        min_move_time = wunderbarrage_data_struct.var_59684fc8ebfb0a2d ?? 5;
        max_move_time = wunderbarrage_data_struct.var_f6dd48944f5ba833 ?? 7;
        traveltime = mapfloat( wunderbarrage_data_struct.var_8e0c26679c09073, wunderbarrage_data_struct.var_991e405c8748a065, min_move_time, max_move_time, dist );
        extra_z = 25;
        gravity = getdvarfloat( @"bg_gravity", 800 );
        launch_gravity = ( 0, 0, -1 * gravity );
        launch_velocity = ( target_pos - 0.5 * launch_gravity * squared( traveltime ) - launch_pos ) / traveltime + ( 0, 0, extra_z );
        missile = magicgrenademanual( "sat_zm_wunderbarrage_missile_proj", launch_pos, launch_velocity, traveltime, initiating_player );
        missile setentityowner( initiating_player );
        missile setotherent( initiating_player );
        missile setmagicgrenadecollision( 0 );
        missile forcenetfieldhighlod( 1 );
        missile.owner = initiating_player;
        missile utility::delaycall( traveltime * 0.666667, &setmagicgrenadecollision, 1 );
        missile setscriptablepartstate( "launch", "active", 0 );
        missile setscriptablepartstate( "trail", "active", 0 );
        missile.angles = generateaxisanglesfromforwardvector( launch_velocity, missile.angles );
        missile thread missile_lifetime();
        missile thread function_a6366552f5a4554e();
        missile thread missile_watch_stuck( 1, vectortoangles( launch_velocity ), gettime(), launch_velocity );
        level.robot_wunderbarrage.active_missile_count++;
    }
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1
// Checksum 0x6a7d6499, Offset: 0xfd3
// Size: 0x85
function function_380301741164ece8( params )
{
    wunderbarrage_data_struct = params.wunderbarrage_data_struct;
    initiating_player = params.initiating_player;
    var_bcc67706b1cfd911 = params.var_bcc67706b1cfd911;
    final_position_override = params.final_position_override;
    var_7308e4058fd91ecc = params.var_7308e4058fd91ecc;
    launch_wunderbarrage( wunderbarrage_data_struct, initiating_player, var_bcc67706b1cfd911, final_position_override, var_7308e4058fd91ecc );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1, eflags: 0x4
// Checksum 0xd1d0affc, Offset: 0x1060
// Size: 0x56
function private on_killed_medal( params )
{
    if ( !level.robot_wunderbarrage.is_active )
    {
        return;
    }
    
    if ( params.sweapon.basename == "sat_zm_wunderbarrage_missile_proj" )
    {
        level.robot_wunderbarrage.kills++;
    }
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0, eflags: 0x4
// Checksum 0xabd4c22, Offset: 0x10be
// Size: 0x54
function private missile_lifetime()
{
    self endon( #"death" );
    self endon( #"missile_empd" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    self endon( #"hash_7419a6ae62fb730b" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    wait 10;
    thread missile_explode();
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0, eflags: 0x4
// Checksum 0xfe55c8e2, Offset: 0x111a
// Size: 0xa5
function private function_a6366552f5a4554e()
{
    self endon( #"death" );
    self endon( #"missile_empd" );
    self endon( #"missile_stuck" );
    self endon( #"missile_water_impact" );
    self endon( #"hash_7419a6ae62fb730b" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    prevloc = self getorigin();
    
    while ( true )
    {
        if ( !isdefined( prevloc ) )
        {
            prevloc = self getorigin();
            waitframe();
            continue;
        }
        
        currloc = self getorigin();
        
        if ( !isdefined( currloc ) )
        {
            waitframe();
            continue;
        }
        
        self.angles = vectortoangles( currloc - prevloc );
        prevloc = currloc;
        waitframe();
    }
}

// Namespace zm_sat_locust_wunderbarrage
// Params 4, eflags: 0x4
// Checksum 0xdb1449bc, Offset: 0x11c7
// Size: 0xe3
function private missile_watch_stuck( explosiontype, launchangles, launchtimems, launchvelocity )
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    stuckto = function_34c62f2875ff70c8();
    
    if ( explosiontype != 1 && gettime() - launchtimems < self.var_ca5dd26ab39d925b * 1000 )
    {
        self notify( #"hash_f0d4a2ca833ee95c" );
        return;
    }
    
    wait 0.05;
    gravityaccel = -1 * getdvarfloat( @"bg_gravity", 800 );
    traveltime = ( gettime() - launchtimems ) / 1000;
    impactvelocity = launchvelocity + ( 0, 0, gravityaccel * traveltime );
    missile_stuck( explosiontype, stuckto, launchangles, impactvelocity );
    self notify( #"hash_7419a6ae62fb730b" );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0, eflags: 0x4
// Checksum 0xf6f67847, Offset: 0x12b2
// Size: 0x8c
function private function_34c62f2875ff70c8()
{
    self endon( #"death" );
    self endon( #"hash_f0d4a2ca833ee95c" );
    impactinfo = killstreak_shared::killstreak_waittillexplode( "missile_stuck", "missile_water_impact" );
    stuckto = undefined;
    
    if ( isdefined( impactinfo ) )
    {
        if ( impactinfo.msg == "missile_stuck" )
        {
            stuckto = impactinfo.param1;
        }
        else if ( impactinfo.msg == "missile_water_impact" )
        {
            self.waterimpact = 1;
        }
    }
    
    return stuckto;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 4, eflags: 0x4
// Checksum 0x2e2ca53a, Offset: 0x1347
// Size: 0xe7
function private missile_stuck( explosiontype, stuckto, launchangles, impactvelocity )
{
    angles = undefined;
    forward = vectornormalize( impactvelocity );
    up = anglestoup( self.angles );
    right = anglestoright( launchangles );
    
    if ( self.waterimpact )
    {
        up = ( 0, 0, 1 );
    }
    
    if ( abs( vectordot( forward, up ) ) >= 0.9848 )
    {
        angles = function_fa92cda591b32007( up, right );
    }
    else
    {
        angles = function_bfd836141a7179e8( up, forward );
    }
    
    self.angles = angles;
    thread missile_explode( self.origin, angles, stuckto, self.owner, gettime(), self.streakinfo );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 6, eflags: 0x4
// Checksum 0x9bdd4042, Offset: 0x1436
// Size: 0x8a
function private missile_explode( groundexplodepos, var_1e4591e5c045a586, stuckto, owner, starttime, streakinfo )
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "explode", "active", 1 );
    self setscriptablepartstate( "visibility", "hide" );
    namespace_9d8e359c3b1041e5::hostmigration_waitlongdurationwithpausesharedfunc( 3 );
    level.robot_wunderbarrage.active_missile_count--;
    self delete();
}

// Namespace zm_sat_locust_wunderbarrage
// Params 2, eflags: 0x4
// Checksum 0x65c9fa2e, Offset: 0x14c8
// Size: 0x3d
function private function_fa92cda591b32007( up, right )
{
    forward = vectornormalize( vectorcross( up, right ) );
    right = vectorcross( forward, up );
    return axistoangles( forward, right, up );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 2, eflags: 0x4
// Checksum 0x3b4f5900, Offset: 0x150e
// Size: 0x3d
function private function_bfd836141a7179e8( up, forward )
{
    right = vectornormalize( vectorcross( forward, up ) );
    forward = vectorcross( up, right );
    return axistoangles( forward, right, up );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 2, eflags: 0x4
// Checksum 0x72cede05, Offset: 0x1554
// Size: 0x8e
function private quest_circle_warning( circle_origin, circle_radius )
{
    level endon( #"game_ended" );
    level.robot_wunderbarrage.map_circle game_utility::questcircle_create( "Airstrike", circle_origin, circle_radius );
    level.robot_wunderbarrage.map_circle game_utility::questcircle_showtoall();
    level waittill( #"wunderbarrage_ended" );
    level.robot_wunderbarrage.map_circle game_utility::questcircle_delete();
    self.fired_missile_count = 0;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1, eflags: 0x4
// Checksum 0x5d8a5257, Offset: 0x15ea
// Size: 0x4b
function private function_98ba5a96d62352c0( origin )
{
    marker = spawnscriptable( "scriptable_hermes_missile_marker", origin, ( 0, 0, 0 ) );
    
    if ( isdefined( marker ) )
    {
        marker utility::function_32b24db3127bff40( "target", "on" );
    }
    
    return marker;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 2, eflags: 0x4
// Checksum 0xbf33cfcd, Offset: 0x163e
// Size: 0x1c8
function private calculate_target_position( wunderbarrage_data_struct, initiating_player )
{
    level endon( #"game_ended" );
    initiating_player endon( #"death_or_disconnect" );
    landing_position = undefined;
    contents = trace::create_contents( 0, 1 );
    
    while ( !isdefined( landing_position ) )
    {
        trace_start = initiating_player getcamerathirdperson() ? initiating_player getcamerathirdpersonorigin() : initiating_player getvieworigin();
        trace_end = trace_start + anglestoforward( initiating_player getplayerangles() ) * 10000;
        target_trace_result = trace::ray_trace( trace_start, trace_end, undefined, contents );
        target_trace_result = trace::convert_surface_flag( target_trace_result );
        target_position = target_trace_result[ "position" ];
        target_normal = target_trace_result[ "normal" ];
        
        if ( isdefined( target_position ) && target_trace_result[ "surfacetype" ] != "surftype_water" && vectordot( target_normal, ( 0, 0, 1 ) ) > wunderbarrage_data_struct.var_cf575fe32b17bb8d )
        {
            landing_position = wunderbarrage_data_struct.var_7725a85501c8adf ? getclosestpointonnavmesh( target_position ) : target_position;
            
            /#
                cylinder( landing_position, landing_position + target_normal * 3, wunderbarrage_data_struct.required_target_radius, ( 0, 1, 0 ), 0, 1 );
            #/
            
            return landing_position;
        }
        else
        {
            /#
                if ( length( target_normal ) > 0 )
                {
                    cylinder( target_position, target_position + target_normal * 3, wunderbarrage_data_struct.required_target_radius, ( 1, 0, 0 ), 0, 1 );
                }
                else
                {
                    sphere( target_position, wunderbarrage_data_struct.required_target_radius, ( 1, 0, 0 ), 0, 1 );
                }
            #/
        }
        
        waitframe();
    }
    
    assertmsg( "<dev string:x80>" );
}

// Namespace zm_sat_locust_wunderbarrage
// Params 10, eflags: 0x4
// Checksum 0x59f8c360, Offset: 0x180f
// Size: 0x82
function private wunderbarrage_player_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    assert( isplayer( self ) );
    
    if ( objweapon.basename == "sat_zm_wunderbarrage_missile_proj" )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace zm_sat_locust_wunderbarrage
// Params 1, eflags: 0x4
// Checksum 0xad71647b, Offset: 0x189a
// Size: 0x191
function private function_aa182f086ff4b866( params )
{
    if ( params.objweapon.basename == "sat_zm_wunderbarrage_missile_proj" && self.aicategory != "boss" )
    {
        if ( self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            var_8d2325a3c1b80415 = level.robot_wunderbarrage.damage_percent_hvt;
            
            if ( self.aicategory == "special" )
            {
                var_8d2325a3c1b80415 = level.robot_wunderbarrage.damage_percent_special;
            }
            else if ( self.aicategory == "elite" )
            {
                var_8d2325a3c1b80415 = level.robot_wunderbarrage.damage_percent_elite;
            }
            
            self dodamage( self.maxhealth * var_8d2325a3c1b80415, self.origin, undefined, undefined, "MOD_EXPLOSIVE", undefined, "torso_upper", undefined, 65536 );
            return;
        }
        
        if ( self.magic_bullet_shield )
        {
            return;
        }
        
        level callback::callback( #"wunderbarrage_zombie_kill", { #zombie:self } );
        self.var_e797f68de73ece4e = "_wunderbarrage";
        namespace_b76ff2659823e89d::function_61b75f09c6601780();
        self kill( params.vpoint, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
    }
}

// Namespace zm_sat_locust_wunderbarrage
// Params 0
// Checksum 0x1f284108, Offset: 0x1a33
// Size: 0x17, Type: bool
function is_not_active()
{
    return level.robot_wunderbarrage.is_active == 0;
}

/#

    // Namespace zm_sat_locust_wunderbarrage
    // Params 0, eflags: 0x4
    // Checksum 0xe53e045f, Offset: 0x1a53
    // Size: 0x44, Type: dev
    function private function_31ef032d3cc7d0be()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc7>" );
        devgui::add_devgui_func( "<dev string:xfb>", "<dev string:x111>", &function_ca1a296b77ac2411 );
        devgui::add_devgui_func( "<dev string:x127>", "<dev string:x142>", &launch_wunderbarrage );
        devgui::function_77df7fe7dd273e10();
    }

#/
