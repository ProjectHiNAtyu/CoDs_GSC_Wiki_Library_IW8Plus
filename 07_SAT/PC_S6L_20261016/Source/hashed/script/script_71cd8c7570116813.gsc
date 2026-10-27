// script_71cd8c7570116813  (hash_71cd8c7570116813.gscc) (size: 7588 Bytes / 0x1da4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60c05cb1 (1623219377)
// size ...... 7588 (0x1da4)
// includes .. 7   (offset: 0x1c44)
// strings ... 20  (offset: 0x1c7c)
// dev strs .. 1   (offset: 0x1d98)
// exports ... 20  (offset: 0x102c)
// cseg ...... 0x1b4 + 0xe78 (0x102c)
// imports ... 76  (offset: 0x134c)
// animtree1 . 0   (offset: 0x1da4)
// animtree2 . 0   (offset: 0x1da4)
#using script_71cef547a69e4a26;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;

#namespace ability_power_jump;

// Namespace ability_power_jump
// Params 0, eflags: 0x5
// Checksum 0x281b9022, Offset: 0x1d2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ability_power_jump", #"ability_manager", &pre_main, undefined );
}

// Namespace ability_power_jump
// Params 0, eflags: 0x4
// Checksum 0x6d30b1dd, Offset: 0x1fb
// Size: 0x50
function private pre_main()
{
    ability_manager::register_ability( { #cleanup_func:&function_2b343ee645690d03, #activate_func:&on_activate_power_jump, #charge_func:&function_60a18847f72f46d3, #can_activate_func:&can_activate_power_jump, #ref:"power_jump" } );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0xf8f38878, Offset: 0x253
// Size: 0xd7, Type: bool
function private can_activate_power_jump( params )
{
    if ( isdefined( self.micontext ) && !self.mutantinjectiontransformed )
    {
        return false;
    }
    
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( self isgestureplaying() && !self isgestureplaying( params.var_83195f10e1e12a6a.chargegesture ) )
    {
        return false;
    }
    
    if ( self meleebuttonpressed() || self attackbuttonpressed() )
    {
        return false;
    }
    
    if ( self getstance() == "prone" )
    {
        return false;
    }
    
    if ( self isswimunderwater() )
    {
        hud_message::showerrormessage( %"hash_4adbfce1ad6ba8f4" );
        return false;
    }
    
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( !power_jump_trace_passed( params.var_83195f10e1e12a6a ) )
    {
        hud_message::showerrormessage( %"hash_4adbfce1ad6ba8f4" );
        return false;
    }
    
    return true;
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x62ba11d, Offset: 0x333
// Size: 0x11b
function private function_60a18847f72f46d3( params )
{
    tuning = params.var_83195f10e1e12a6a;
    val::set_array( #"power_jump", [ "melee", "offhand_weapons" ], 0 );
    val::set( #"power_jump", "offhand_primary_weapons", 0 );
    val::set( #"power_jump", "offhand_secondary_weapons", 0 );
    val::set( #"power_jump", "equipment_primary", 0 );
    val::set( #"power_jump", "equipment_secondary", 0 );
    self lerpfovbypreset( "zombie_jump" );
    childthread function_99d3fc2eeac899c1( tuning );
    
    if ( !isdefined( self.var_4026b2b0e0c125b3 ) || gettime() > self.var_4026b2b0e0c125b3 )
    {
        self playlocalsound( tuning.var_40a43ef9a8d4551d );
        self.var_4026b2b0e0c125b3 = gettime() + 500;
    }
    
    self waittill( "ability_manager_charge_full_" + params.ref );
    self playlocalsound( tuning.var_40edc9cf40dd760e );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x570b6ec9, Offset: 0x456
// Size: 0xcb
function private on_activate_power_jump( params )
{
    tuning = params.var_83195f10e1e12a6a;
    self stopgestureviewmodel( tuning.chargegesture );
    childthread function_19ad60819a538fd5();
    
    if ( weapon::grenadeinpullback() )
    {
        self canceloffhands();
    }
    
    self playlocalsound( tuning.var_17f4d6d63f8aa27c );
    self playsound( tuning.var_26ecee79452f87df, self, self );
    player_angles = self getplayerangles();
    childthread power_jump_hit_ground( tuning );
    function_847546313d4f0173( player_angles, tuning.maxvelocity, params.charge_fraction, undefined, tuning );
    childthread function_1875418a88ae8849( tuning );
    childthread function_db2072945f3873c5( tuning );
    utility::waittill_any( "power_jump_complete", "death_or_disconnect" );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x2c54da22, Offset: 0x529
// Size: 0x79
function private function_2b343ee645690d03( params )
{
    tuning = params.var_83195f10e1e12a6a;
    self stopgestureviewmodel( tuning.chargegesture );
    self stopgestureviewmodel( tuning.airgesture );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    val::reset_all( #"power_jump" );
    
    if ( isalive( self ) )
    {
        self lerpfovbypreset( "zombiedefault" );
    }
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x560b6c91, Offset: 0x5aa
// Size: 0x89
function private function_99d3fc2eeac899c1( tuning )
{
    if ( self isgestureplaying( tuning.chargegesture ) )
    {
        return;
    }
    
    if ( weapon::grenadeinpullback() )
    {
        self canceloffhands();
    }
    
    while ( self ismantling() || self ismeleeing() )
    {
        waitframe();
    }
    
    function_b8ae60f114710304( tuning.chargegesture );
    
    while ( self isgestureplaying( tuning.chargegesture ) )
    {
        if ( self isonladder() )
        {
            self stopgestureviewmodel( tuning.chargegesture );
            break;
        }
        
        waitframe();
    }
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0xfdb8d742, Offset: 0x63b
// Size: 0xf5, Type: bool
function private power_jump_trace_passed( tuning )
{
    if ( tuning.var_fab79c3da75c54c3 != 0 )
    {
        end = self.origin + ( 0, 0, tuning.var_fab79c3da75c54c3 );
        result = playerphysicstrace( self.origin, end );
        
        if ( result != end )
        {
            return false;
        }
    }
    
    if ( tuning.var_fab79d3da75c56f6 != 0 )
    {
        start = self geteye();
        end = start + ( 0, 0, tuning.var_fab79d3da75c56f6 );
        radius = 10;
        height = 20;
        contents = trace::create_contents( 0, 1, 0, 1, 0, 0, 1 );
        result = trace::capsule_trace( start, end, radius, height, ( 0, 0, 0 ), self, contents );
        
        if ( result[ "fraction" ] != 1 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ability_power_jump
// Params 5, eflags: 0x4
// Checksum 0x37ae14ae, Offset: 0x739
// Size: 0x214
function private function_847546313d4f0173( player_angles, maxjumpvelocity, fraction, startoffset = ( 0, 0, 20 ), tuning )
{
    ground_normal = ( 0, 0, 1 );
    
    if ( tuning.var_66ef276c83bd435b )
    {
        ground_normal = power_jump_get_ground_normal( self, 0 );
        
        if ( !isdefined( ground_normal ) )
        {
            ground_normal = ( 0, 0, 1 );
        }
    }
    
    yawangles = ( 0, player_angles[ 1 ], 0 );
    right = anglestoright( yawangles );
    fwd = vectorcross( ground_normal, right );
    fwd_angles = vectortoangles( fwd );
    ground_pitch = angleclamp180( fwd_angles[ 0 ] );
    min_pitch = -85;
    max_pitch = ground_pitch;
    player_pitch = player_angles[ 0 ];
    
    if ( player_pitch > ground_pitch )
    {
        player_pitch = ground_pitch;
    }
    
    var_d01e318b66fb6024 = -45;
    var_cffb3f8b66d53736 = 0;
    frac = ( player_pitch - min_pitch ) / ( max_pitch - min_pitch );
    pitch_correction = var_cffb3f8b66d53736 + frac * ( var_d01e318b66fb6024 - var_cffb3f8b66d53736 );
    player_angles = ( player_pitch + pitch_correction, player_angles[ 1 ], player_angles[ 2 ] );
    dir = anglestoforward( player_angles );
    velocity = dir * fraction * maxjumpvelocity;
    startorg = self.origin + startoffset;
    self setorigin( startorg, 0 );
    self setvelocity( velocity );
    glassradiusdamage( self.origin + ( 0, 0, 30 ), 30, 50, 51 );
    fwddir = anglestoforward( self.angles );
    radorg = self.origin + ( 0, 0, 30 ) + fwddir * 15;
    radiusdamage( radorg, 100, 1, 1 );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0xa36a8ffb, Offset: 0x955
// Size: 0x11f
function private function_1875418a88ae8849( tuning )
{
    var_6270bf80abebca4b = tuning.aircontrol;
    
    if ( var_6270bf80abebca4b <= 0 )
    {
        return;
    }
    
    maxspeed = tuning.var_45ee2c02a46286;
    wait tuning.groundwaittime;
    
    while ( !power_jump_is_complete() )
    {
        movementinput = self getnormalizedmovement();
        
        if ( length( movementinput ) > 0 )
        {
            worlddir = rotatevector( ( movementinput[ 0 ], -1 * movementinput[ 1 ], 0 ), self.angles );
            velocity = self getvelocity();
            speed = length( velocity );
            var_24b974ad4db020a6 = worlddir * var_6270bf80abebca4b * level.framedurationseconds;
            newvel = velocity + var_24b974ad4db020a6;
            newspeed = length( newvel );
            
            if ( newspeed <= maxspeed )
            {
                self setvelocity( newvel );
            }
            else if ( speed < maxspeed )
            {
                newvel = vectornormalize( newvel ) * maxspeed;
                self setvelocity( newvel );
            }
        }
        
        waitframe();
    }
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x5795fd0e, Offset: 0xa7c
// Size: 0x116
function private power_jump_hit_ground( tuning )
{
    val::set( #"power_jump", "allow_jump", 0 );
    self setscriptablepartstate( "skydiveVfx", "enabled_zombie", 0 );
    self setscriptablepartstate( #"super_mega_jump", #"takeoff_alt" );
    wait tuning.groundwaittime;
    val::reset( #"power_jump", "offhand_weapons" );
    function_b8ae60f114710304( tuning.airgesture );
    childthread function_a4af55686fe4f23( tuning.airgesture );
    childthread function_3b5885f4bfb283ef( tuning );
    self lerpfovbypreset( "zombiedefault" );
    
    while ( !power_jump_is_complete() )
    {
        waitframe();
    }
    
    self notify( #"power_jump_complete" );
    self stopgestureviewmodel( tuning.airgesture );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    thread function_838e65e124728cb2();
    wait tuning.landingwaittime;
    self playsound( tuning.var_adf499feca9413a, undefined, self );
    val::reset_all( #"power_jump" );
}

// Namespace ability_power_jump
// Params 0, eflags: 0x4
// Checksum 0xda2fcc5a, Offset: 0xb9a
// Size: 0x44
function private function_838e65e124728cb2()
{
    self endon( #"disconnect" );
    self setscriptablepartstate( #"super_mega_jump", #"impact_alt" );
    wait 1;
    self setscriptablepartstate( #"super_mega_jump", #"off" );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x59315109, Offset: 0xbe6
// Size: 0x3f
function private function_3b5885f4bfb283ef( tuning )
{
    self endon( #"power_jump_complete" );
    
    while ( true )
    {
        self waittill( #"offhand_end" );
        function_b8ae60f114710304( tuning.airgesture );
    }
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x1e3408d1, Offset: 0xc2d
// Size: 0x3a
function private function_a4af55686fe4f23( gesture )
{
    self endon( #"power_jump_complete" );
    
    for ( ;; )
    {
        self waittill( #"offhand_pullback" );
        
        if ( self isgestureplaying( gesture ) )
        {
            self stopgestureviewmodel( gesture );
        }
    }
}

// Namespace ability_power_jump
// Params 0, eflags: 0x4
// Checksum 0x6c2e38, Offset: 0xc6f
// Size: 0x22, Type: bool
function private power_jump_is_complete()
{
    return self isonground() || self isonladder() || self ismantling() || self isswimming();
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x579f75fc, Offset: 0xc9a
// Size: 0x47
function private function_db2072945f3873c5( tuning )
{
    self endon( #"power_jump_complete" );
    cleartime = tuning.var_65c2e7a5633884d9;
    
    if ( cleartime < 0 )
    {
        return;
    }
    
    if ( cleartime > 0 )
    {
        wait cleartime;
    }
    
    self function_a4a572d8d09b0f46();
}

// Namespace ability_power_jump
// Params 0, eflags: 0x4
// Checksum 0x970df519, Offset: 0xce9
// Size: 0x5c
function private function_19ad60819a538fd5()
{
    wait 0.5;
    val::reset( #"power_jump", "offhand_primary_weapons" );
    val::reset( #"power_jump", "offhand_secondary_weapons" );
    val::reset( #"power_jump", "equipment_primary" );
    val::reset( #"power_jump", "equipment_secondary" );
}

// Namespace ability_power_jump
// Params 1, eflags: 0x4
// Checksum 0x4eb6edd2, Offset: 0xd4d
// Size: 0x47
function private function_b8ae60f114710304( gesture )
{
    if ( !gesture )
    {
        return;
    }
    
    if ( !isdefined( self.currentweapon ) )
    {
        return;
    }
    
    if ( self.currentweapon.basename == "none" )
    {
        return;
    }
    
    self forceplaygestureviewmodel( gesture );
}

// Namespace ability_power_jump
// Params 2, eflags: 0x4
// Checksum 0xb0181c8e, Offset: 0xd9c
// Size: 0x290
function private power_jump_get_ground_normal( traceignore, debug )
{
    if ( !isdefined( traceignore ) )
    {
        ignore = self;
    }
    else
    {
        ignore = traceignore;
    }
    
    if ( !isdefined( debug ) )
    {
        debug = 0;
    }
    
    ignorelist = [ ignore ];
    tracepoints = [ self.origin ];
    i = -1;
    
    while ( i <= 1 )
    {
        j = -1;
        
        while ( j <= 1 )
        {
            corner = ignore getpointinbounds( i, j, 0 );
            corner = ( corner[ 0 ], corner[ 1 ], self.origin[ 2 ] );
            tracepoints[ tracepoints.size ] = corner;
            j += 2;
        }
        
        i += 2;
    }
    
    avgnormal = ( 0, 0, 0 );
    tracehitcount = 0;
    
    foreach ( point in tracepoints )
    {
        trace = trace::_bullet_trace( point + ( 0, 0, 4 ), point + ( 0, 0, -16 ), 0, ignorelist );
        tracehit = trace[ "fraction" ] > 0 && trace[ "fraction" ] < 1;
        
        if ( tracehit )
        {
            avgnormal += trace[ "normal" ];
            tracehitcount++;
        }
        
        /#
            if ( debug )
            {
                if ( tracehit )
                {
                    line( point, point + trace[ "<dev string:x24>" ] * 30, ( 0, 1, 0 ) );
                    continue;
                }
                
                sphere( point, 3, ( 1, 0, 0 ) );
            }
        #/
    }
    
    if ( tracehitcount > 0 )
    {
        avgnormal /= tracehitcount;
        
        /#
            if ( debug )
            {
                line( self.origin, self.origin + avgnormal * 20, ( 1, 1, 1 ) );
            }
        #/
        
        return avgnormal;
    }
    
    /#
        if ( debug )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ) );
        }
    #/
    
    return;
}

