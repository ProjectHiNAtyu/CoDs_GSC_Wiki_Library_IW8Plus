// scripts\common\ai\aitypes\zombie_loom\zombie_loom_ride.gsc  (hash_63f793d4434ae05d.gscc) (size: 7831 Bytes / 0x1e97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd52f50ec (3576647916)
// size ...... 7831 (0x1e97)
// includes .. 6   (offset: 0x1d37)
// strings ... 21  (offset: 0x1d67)
// dev strs .. 0   (offset: 0x1e97)
// exports ... 18  (offset: 0x1193)
// cseg ...... 0x1c2 + 0xfd1 (0x1193)
// imports ... 72  (offset: 0x1463)
// animtree1 . 0   (offset: 0x1e97)
// animtree2 . 0   (offset: 0x1e97)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom_ride;

// Namespace zombie_loom_ride
// Params 1
// Checksum 0xf6a7f02a, Offset: 0x1e0
// Size: 0xc
function precache( aitypescriptbundle )
{
    
}

// Namespace zombie_loom_ride
// Params 0
// Checksum 0xf5b0a48, Offset: 0x1f4
// Size: 0xa8
function init()
{
    callback::add( "on_turned", &function_c43ae7844f78ed94 );
    callback::add( "force_ride_loom", &force_ride_loom );
    callback::add( "stop_riding", &function_3f29e4e7b7291742 );
    callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
    callback::add( "friendly_zombie_damage", &on_zombie_ai_damaged );
    callback::add( #"on_ai_killed", &function_3695bbaa5fc2bea );
    
    if ( !level callback::exists( #"on_ping", &on_player_ping ) )
    {
        level callback::add( #"on_ping", &on_player_ping );
    }
    
    level utility::flag_set( "ride_init_complete" );
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0x102681dc, Offset: 0x2a4
// Size: 0x47
function private function_c43ae7844f78ed94( params )
{
    self notify( #"end_ride_watcher" );
    self function_dc61b81ec6b63cc4( 0 );
    
    if ( self.ridingplayer )
    {
        self function_786bb6aa1b76c7ee( "in_ride_mode", 0 );
        thread function_8f7454e07cd183d8( self.ridingplayer );
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0xb00b793f, Offset: 0x2f3
// Size: 0x15d
function private on_zombie_ai_damaged( params )
{
    if ( params.smeansofdeath != "MOD_MELEE" )
    {
        return;
    }
    
    if ( !isplayer( params.eattacker ) || !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    player_origin = params.eattacker.origin;
    
    if ( player_origin[ 2 ] > self.origin[ 2 ] )
    {
        if ( player_origin[ 2 ] - self.origin[ 2 ] > 24 )
        {
            distance_check = 64;
            
            if ( distance2d( self.origin, player_origin ) < distance_check && !params.eattacker.ridingloom )
            {
                ride_loom( params.eattacker );
            }
        }
    }
    
    if ( isplayer( self.ridingplayer ) )
    {
        if ( !isdefined( self.ridingdamage ) )
        {
            self.ridingdamage = 0;
        }
        
        self.ridingdamage += params.idamage;
        var_d648d1dbc51f0b0f = self.maxhealth * 0.15;
        
        if ( self.ridingdamage >= var_d648d1dbc51f0b0f )
        {
            unride_loom( self.ridingplayer );
        }
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0xce25fe5a, Offset: 0x458
// Size: 0x44
function private function_3695bbaa5fc2bea( params )
{
    if ( self.ridingplayer )
    {
        unride_loom( self.ridingplayer, 1 );
    }
    
    if ( self.ridepoint )
    {
        self.ridepoint delete();
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0x89ab3a45, Offset: 0x4a4
// Size: 0xe5
function private function_b1209d322a2dfd14( player )
{
    self endon( #"death" );
    self endon( #"end_ride_watcher" );
    
    while ( isplayer( player ) && isalive( player ) && player.ridingloom && isalive( self ) && zombie_utils::function_bf1464d09f4e4b40() )
    {
        ceiling_check_start = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 64 );
        ceiling_check_end = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 156 );
        passed_check = trace::ray_trace_passed( ceiling_check_start, ceiling_check_end, player );
        
        if ( !passed_check )
        {
            unride_loom( player );
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0xbe6c2116, Offset: 0x591
// Size: 0xcc
function private on_player_ping( params )
{
    player = params.player;
    
    if ( isplayer( player ) )
    {
        var_e26e9f45f32b9571 = params.pingindex;
        ping_origin = player calloutmarkerping_getorigin( var_e26e9f45f32b9571 );
        
        if ( player.ridingloom && player.ridingent zombie_utils::function_bf1464d09f4e4b40() && ping_origin )
        {
            new_pos = getclosestpointonnavmesh( ping_origin );
            
            if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", new_pos ) )
            {
                player.ridingent clearpath();
                player.ridingent setbtgoalpos( 3, new_pos );
            }
        }
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0xc1c35508, Offset: 0x665
// Size: 0x1eb
function private function_8f7454e07cd183d8( player )
{
    self endon( #"death" );
    self endon( #"end_ride_watcher" );
    
    if ( zombie_utils::function_bf1464d09f4e4b40() )
    {
        while ( isplayer( player ) && isalive( player ) && player.ridingloom && isalive( self ) && zombie_utils::function_bf1464d09f4e4b40() )
        {
            wait 1;
        }
        
        unride_loom( player );
        return;
    }
    
    start_ride = gettime();
    self function_786bb6aa1b76c7ee( "in_ride_mode", 1 );
    asm::function_7256f5ba459c840b( "stun_ride_in" );
    view_angle = self.angles;
    var_a486f1d1629803ac = isplayer( player ) && player.mask_ee.var_73e37bf886655ce7.ref == "zmloot_scarab_loom_ride_ee_mask";
    var_48aa3ccf233fc3fa = 5000;
    
    if ( var_a486f1d1629803ac )
    {
        var_48aa3ccf233fc3fa = 10000;
    }
    
    var_48aa3ccf233fc3fa = clamp( var_48aa3ccf233fc3fa - self.var_131488064947ccb9 * var_48aa3ccf233fc3fa * 0.15, 2000, 10000 );
    
    while ( gettime() - start_ride < var_48aa3ccf233fc3fa )
    {
        rnd_number = randomintrange( 0, 4 );
        
        switch ( rnd_number )
        {
            case 0:
                view_angle = ( view_angle[ 0 ], view_angle[ 1 ] + 90, view_angle[ 2 ] );
                break;
            case 1:
                view_angle = ( view_angle[ 0 ], view_angle[ 1 ] - 90, view_angle[ 2 ] );
                break;
            case 2:
                view_angle = ( view_angle[ 0 ], view_angle[ 1 ] + 45, view_angle[ 2 ] );
                break;
            case 3:
                view_angle = ( view_angle[ 0 ], view_angle[ 1 ] - 90, view_angle[ 2 ] );
                break;
        }
        
        self orientmode( "face angle 3d", view_angle );
        wait 1;
    }
    
    unride_loom( player );
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0x1d87c14d, Offset: 0x858
// Size: 0x229
function private ride_loom( player )
{
    if ( player.b_in_safehouse )
    {
        return;
    }
    
    if ( self isintraverse() )
    {
        return;
    }
    
    if ( isplayer( self.ridingplayer ) )
    {
        return;
    }
    
    self notify( #"hash_4d903a106d68ba76" );
    self.var_bb233fbf81eeaddd = zombie_utils::function_bf1464d09f4e4b40();
    
    if ( !isdefined( self.ridepoint ) )
    {
        ride_point = spawn( "script_model", self.origin );
        ride_point setmodel( "tag_origin" );
        ride_point_origin = self gettagorigin( "tag_ride" );
        var_66789fc2dee0510a = abs( ride_point_origin[ 2 ] - self.origin[ 2 ] );
        ride_point linkto( self, "tag_origin", ( 0, 0, var_66789fc2dee0510a ), ( 0, 0, 0 ) );
        self.ridepoint = ride_point;
    }
    else
    {
        ride_point_origin = self gettagorigin( "tag_ride" );
        var_66789fc2dee0510a = abs( ride_point_origin[ 2 ] - self.origin[ 2 ] );
        self.ridepoint linkto( self, "tag_origin", ( 0, 0, var_66789fc2dee0510a ), ( 0, 0, 0 ) );
    }
    
    if ( !isdefined( self.var_131488064947ccb9 ) )
    {
        self.var_131488064947ccb9 = 0;
    }
    
    self.var_131488064947ccb9++;
    self.ridingplayer = player;
    self.collide_with_ai = 0;
    self enabletraversals( 0 );
    player.ridingloom = 1;
    player.ridingent = self;
    player setstance( "crouch", 1, 1 );
    player val::set( "riding_loom", "stance_change", 0 );
    angle_lock = self.var_bb233fbf81eeaddd ? 180 : 90;
    player playerlinkto( self.ridepoint, "tag_origin", 1, angle_lock, angle_lock, angle_lock, angle_lock, 0 );
    player callback::add( #"player_laststand", &function_cdcb4590421e60c2, { #loom:self } );
    player callback::callback( "on_ride_loom" );
    thread function_8f7454e07cd183d8( player );
    thread function_b1209d322a2dfd14( player );
}

// Namespace zombie_loom_ride
// Params 2
// Checksum 0xdf93693d, Offset: 0xa89
// Size: 0x111
function unride_loom( player, var_f703a80d37a11436 )
{
    if ( !self.var_bb233fbf81eeaddd )
    {
        thread function_d904306b8bb72756();
    }
    
    self.var_bb233fbf81eeaddd = undefined;
    self.ridingplayer = undefined;
    self.ridingdamage = undefined;
    self.collide_with_ai = 1;
    self enabletraversals( 1 );
    self clearpath();
    self clearbtgoal( 3 );
    self function_786bb6aa1b76c7ee( "in_ride_mode", 0 );
    
    if ( isplayer( player ) && isalive( player ) && player.ridingloom )
    {
        player unlink( 1 );
        player val::reset( "riding_loom", "stance_change" );
        player.ridingloom = undefined;
        player.ridingent = undefined;
        
        if ( var_f703a80d37a11436 )
        {
            player unlink();
            player thread function_7366507e747a3d34();
        }
        else
        {
            player thread function_7ed2b756d8c1c17a( self );
        }
        
        player setstance( "stand", 1, 1 );
        player callback::remove( #"player_laststand", &function_cdcb4590421e60c2 );
    }
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0xaabaa53e, Offset: 0xba2
// Size: 0x2ae
function private function_7ed2b756d8c1c17a( var_904ee913f7d90487 )
{
    self setstance( "stand", 1, 1 );
    var_8954ce3c68f5f734 = 0;
    the_point = ( 0, 0, 0 );
    points = getrandomnavpoints( var_904ee913f7d90487.origin, 128, 10, undefined, undefined, undefined, undefined, undefined, 127 );
    
    foreach ( point in points )
    {
        var_8954ce3c68f5f734 = utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", point );
        
        if ( var_8954ce3c68f5f734 )
        {
            the_point = point;
            break;
        }
    }
    
    if ( !var_8954ce3c68f5f734 )
    {
        points = getrandomnavpoints( var_904ee913f7d90487.origin, 256, 10, undefined, undefined, undefined, undefined, undefined, 255 );
        
        foreach ( point in points )
        {
            var_8954ce3c68f5f734 = utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", point );
            
            if ( var_8954ce3c68f5f734 )
            {
                the_point = point;
                break;
            }
        }
    }
    
    ceiling_check_start = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 64 );
    ceiling_check_end = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 256 );
    var_f9c0cbf3f54da04d = trace::ray_trace_passed( ceiling_check_start, ceiling_check_end, self );
    e_mover = spawn( "script_model", self.origin );
    e_mover setmodel( "tag_origin" );
    self playerlinkto( e_mover );
    
    if ( !var_8954ce3c68f5f734 || !var_f9c0cbf3f54da04d )
    {
        if ( !var_8954ce3c68f5f734 )
        {
            self unlink();
        }
        else
        {
            e_mover moveto( the_point, 0.2, 0.1 );
            wait 0.3;
        }
    }
    else
    {
        time = e_mover fake_physicslaunch( the_point, 250 );
        wait time;
    }
    
    if ( isplayer( self ) )
    {
        self unlink();
        thread function_7366507e747a3d34();
    }
    
    e_mover delete();
}

// Namespace zombie_loom_ride
// Params 2, eflags: 0x4
// Checksum 0xd1748bc0, Offset: 0xe58
// Size: 0xca
function private fake_physicslaunch( target_pos, power )
{
    start_pos = self.origin;
    
    if ( !power )
    {
        power = 250;
    }
    
    gravity = getdvarfloat( @"bg_gravity", 0 ) * -1;
    dist = distance( start_pos, target_pos );
    time = dist / power;
    
    if ( !time )
    {
        time = 1;
    }
    
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self movegravity( velocity, time );
    return time;
}

// Namespace zombie_loom_ride
// Params 0, eflags: 0x4
// Checksum 0x71bef8f6, Offset: 0xf2b
// Size: 0x2c
function private function_d904306b8bb72756()
{
    self endon( #"death" );
    self endon( #"hash_4d903a106d68ba76" );
    self function_dc61b81ec6b63cc4( 1 );
    wait 10;
    self function_dc61b81ec6b63cc4( 0 );
}

// Namespace zombie_loom_ride
// Params 0, eflags: 0x4
// Checksum 0x5908fd1e, Offset: 0xf5f
// Size: 0x17a
function private function_7366507e747a3d34()
{
    self endon( #"death_or_disconnect" );
    wait 1;
    
    if ( isplayer( self ) && isalive( self ) )
    {
        the_point = getclosestpointonnavmesh( self.origin );
        self setorigin( the_point );
        
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", self.origin ) )
        {
            if ( isdefined( self.var_5b28480c7d2cbeff ) )
            {
                var_2ce3dc2482e72cc9 = utility::getstructarray( self.var_5b28480c7d2cbeff.target, "targetname" );
                teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
                self setadditionalstreamposuntilcleared( teleport_pos.origin );
                utility::callsharedfunc( #"zm_utility", #"hash_aa5e3e963ec5ea62", teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 0, 0.25, 0, 0.25 );
                self clearadditionalstreampos();
                return;
            }
            
            var_2ce3dc2482e72cc9 = utility::getstructarray( level.var_1552925d1fc3e4aa.target, "targetname" );
            teleport_pos = var_2ce3dc2482e72cc9[ self getentitynumber() ];
            utility::callsharedfunc( #"zm_utility", #"hash_aa5e3e963ec5ea62", teleport_pos.origin, teleport_pos.angles, "teleport_out_of_map", 0, 0.25, 0, 0.25 );
            self clearadditionalstreampos();
        }
    }
}

// Namespace zombie_loom_ride
// Params 2, eflags: 0x4
// Checksum 0xc3c7ed14, Offset: 0x10e1
// Size: 0x36
function private function_cdcb4590421e60c2( params, additional_params )
{
    loom = additional_params.loom;
    loom unride_loom( self );
}

// Namespace zombie_loom_ride
// Params 1, eflags: 0x4
// Checksum 0x948aa96f, Offset: 0x111f
// Size: 0x3c
function private function_3f29e4e7b7291742( params )
{
    self notify( #"end_ride_watcher" );
    
    if ( isplayer( params.player ) )
    {
        unride_loom( params.player );
    }
}

// Namespace zombie_loom_ride
// Params 1
// Checksum 0xe22b33fa, Offset: 0x1163
// Size: 0x30
function force_ride_loom( params )
{
    if ( isplayer( params.player ) )
    {
        ride_loom( params.player );
    }
}

