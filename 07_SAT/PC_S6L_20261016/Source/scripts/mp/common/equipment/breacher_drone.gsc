// scripts\mp\common\equipment\breacher_drone.gsc  (hash_4a53290480f88c14.gscc) (size: 7433 Bytes / 0x1d09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cb43cf2 (1555315954)
// size ...... 7433 (0x1d09)
// includes .. 8   (offset: 0x1bcd)
// strings ... 16  (offset: 0x1c0d)
// dev strs .. 1   (offset: 0x1cfd)
// exports ... 18  (offset: 0x1199)
// cseg ...... 0x187 + 0x1012 (0x1199)
// imports ... 59  (offset: 0x1469)
// animtree1 . 0   (offset: 0x1d09)
// animtree2 . 0   (offset: 0x1d09)
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\weapons;

#namespace breacher_drone;

// Namespace breacher_drone
// Params 0, eflags: 0x1
// Checksum 0xc79ad0dd, Offset: 0x1a5
// Size: 0x9
function autoexec main()
{
    breacher_drone_init();
}

// Namespace breacher_drone
// Params 0
// Checksum 0xb9978922, Offset: 0x1b6
// Size: 0x8c
function breacher_drone_init()
{
    if ( utility::issharedfuncdefined( #"breacher_drone", #"init" ) )
    {
        [[ utility::getsharedfunc( #"breacher_drone", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"breacher_drone", #"breacher_drone_used", &breacher_drone_used );
    breacher_drone_initdvars();
    utility::registersharedfunc( #"equip_breacher_drone", #"hash_472c7440eb3590e3", &function_4c937174a0b3dfd8 );
    weapons::registerusedcallback( "breacher_drone", &breacher_drone_used );
}

// Namespace breacher_drone
// Params 0
// Checksum 0xe3576ca1, Offset: 0x24a
// Size: 0xe9
function breacher_drone_initdvars()
{
    setdvarifuninitialized( @"scr_breacher_drone_max_health", 55 );
    setdvarifuninitialized( @"scr_breacher_drone_lifetime", 8 );
    setdvarifuninitialized( @"hash_880bc9cb96e0d47a", 20 );
    setdvarifuninitialized( @"hash_e84ef551e525beef", 25 );
    setdvarifuninitialized( @"hash_4eb410aa813c8a92", 40 );
    setdvarifuninitialized( @"hash_7580f29bc586eaa1", 2 );
    setdvarifuninitialized( @"hash_78873628c410e47c", 4 );
    setdvarifuninitialized( @"hash_d0988687e6689cf8", 0.5 );
    setdvarifuninitialized( @"hash_178470c11f7062cd", 2.5 );
    setdvarifuninitialized( @"hash_984112ed98131c1f", 0 );
    setdvarifuninitialized( @"hash_b3179bfb043e6579", 15 );
    setdvarifuninitialized( @"hash_30eb2c84bb64de0f", -20 );
    setdvarifuninitialized( @"hash_c829ecd8ebe56106", 20 );
    setdvarifuninitialized( @"scr_breacher_drone_debug", 0 );
}

// Namespace breacher_drone
// Params 1
// Checksum 0x3f9235e5, Offset: 0x33b
// Size: 0x1e7
function breacher_drone_used( breacher_drone )
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"timeout" );
    level endon( #"game_ended" );
    isunderwater = player_utility::isswimmingunderwater();
    
    if ( isunderwater == 1 )
    {
        breacher_drone setscriptablepartstate( "exit", "on", 0 );
        return;
    }
    
    gunangle = self getgunangles();
    launchdirection = anglestoforward( gunangle );
    breacher_drone setotherent( self );
    breacher_drone setscriptablepartstate( "breacher_setup", "on", 0 );
    breacher_drone functionals_utility::function_f9c3bc385df6f245( undefined, &function_c69f1b449e2829c7, undefined );
    breacher_drone haywire::function_7f69a1eb3d590f76( &function_4c937174a0b3dfd8 );
    drone_velocity = breacher_drone.bundle.breacherdrone_velocity;
    launch_offset = getdvarfloat( @"hash_b3179bfb043e6579" );
    breacher_drone.origin += launchdirection * launch_offset;
    breacher_drone.starting_origin = breacher_drone.origin;
    breacher_drone thread function_f1f171aeff674ece();
    breacher_drone thread function_aae96f8739f035ff();
    breacher_drone thread breacher_fly( launchdirection, drone_velocity, gunangle );
    breacher_drone function_c0d3734f048c0531( 0 );
    maxlifetime = getdvarfloat( @"scr_breacher_drone_lifetime" );
    breacher_drone thread functionals_utility::functionals_timeout( maxlifetime, @"scr_breacher_drone_debug" );
    maxhealth = getdvarfloat( @"scr_breacher_drone_max_health" );
    damagefeedback = "hitequip";
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        breacher_drone thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( maxhealth, damagefeedback, &functionals_utility::functionals_handlefataldamage, &functionals_utility::functionals_handledamage, 0 );
    }
}

// Namespace breacher_drone
// Params 1
// Checksum 0x496fddce, Offset: 0x52a
// Size: 0x118
function function_c0d3734f048c0531( isarmed )
{
    trigger_height = isarmed ? getdvarint( @"hash_e84ef551e525beef" ) : getdvarint( @"hash_78873628c410e47c" );
    trigger_radius = isarmed ? getdvarint( @"hash_4eb410aa813c8a92" ) : getdvarint( @"hash_7580f29bc586eaa1" );
    
    if ( isdefined( self.playertrigger ) )
    {
        self.playertrigger notify( #"deleting_trigger" );
        self.playertrigger delete();
    }
    
    self.playertrigger = spawn( "trigger_radius", self.origin, 0, trigger_radius, trigger_height );
    self.playertrigger.angles = self.angles;
    self.playertrigger.origin = self.origin - ( 0, 0, trigger_height );
    self.playertrigger enablelinkto();
    self.playertrigger linkto( self );
    thread function_bd08d44c99ae0d68();
}

// Namespace breacher_drone
// Params 0
// Checksum 0xdf55e173, Offset: 0x64a
// Size: 0xf4
function function_bd08d44c99ae0d68()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"disconnect" );
    self.playertrigger endon( #"deleting_trigger" );
    
    while ( true )
    {
        self.playertrigger waittill( #"trigger", var_8ad0f64e430211ee );
        assert( isdefined( var_8ad0f64e430211ee ) );
        
        if ( isarray( var_8ad0f64e430211ee ) )
        {
            foreach ( ent in var_8ad0f64e430211ee )
            {
                function_e3d8f64518c47bbc( ent );
            }
            
            continue;
        }
        
        function_e3d8f64518c47bbc( var_8ad0f64e430211ee );
    }
    
    waitframe();
}

// Namespace breacher_drone
// Params 1
// Checksum 0x2f8a3835, Offset: 0x746
// Size: 0x76
function function_e3d8f64518c47bbc( ent )
{
    if ( isagent( ent ) || isplayer( ent ) || isai( ent ) )
    {
        if ( !isalive( ent ) )
        {
            return;
        }
        
        if ( isdefined( ent.team ) )
        {
            if ( ent.team == self.owner.team )
            {
                return;
            }
        }
        
        callback::callback( #"on_functional_death" );
    }
}

// Namespace breacher_drone
// Params 0
// Checksum 0xdc5fbb41, Offset: 0x7c4
// Size: 0x117
function function_f1f171aeff674ece()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"disconnect" );
    endangles = self.angles;
    xtilt = getdvarint( @"hash_30eb2c84bb64de0f" );
    startangle = ( xtilt, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, startangle, 1 );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        else
        {
            wait 0.2;
            function_a89613b6d2e3bdab();
        }
        
        waitframe();
    }
}

// Namespace breacher_drone
// Params 0
// Checksum 0x9fb4e1bc, Offset: 0x8e3
// Size: 0x107
function function_a89613b6d2e3bdab()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"disconnect" );
    startangle = self.angles;
    xtilt_flight = getdvarint( @"hash_c829ecd8ebe56106" );
    endangles = ( xtilt_flight, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, endangles, 1 );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        
        waitframe();
    }
}

// Namespace breacher_drone
// Params 3
// Checksum 0xb7c5d082, Offset: 0x9f2
// Size: 0x1f2
function breacher_fly( direction, velocity, gunangle )
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"timeout" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    raycaststart = self.origin;
    raycastdistance = getdvarint( @"hash_880bc9cb96e0d47a" );
    raycastend = raycaststart + direction * raycastdistance;
    vectordistance = 1500;
    startpos = self.origin;
    previouspos = self.origin;
    targetpos = raycaststart + direction * vectordistance;
    starttime = gettime();
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    collisioncontents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle" ] );
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        hitents = physics_raycast( previouspos, raycastend, collisioncontents, self, 0, "physicsquery_all" );
        
        if ( hitents.size >= 1 )
        {
            params = spawnstruct();
            params.hitents = hitents;
            callback::callback( #"on_functional_death", params );
            break;
        }
        
        newpos = math::lerp( startpos, targetpos, lerpfraction );
        previouspos = self.origin;
        self.origin = newpos;
        raycastend = self.origin + direction * raycastdistance;
        waitframe();
    }
}

// Namespace breacher_drone
// Params 0
// Checksum 0x1afa7870, Offset: 0xbec
// Size: 0x6f
function function_aae96f8739f035ff()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self.owner endon( #"disconnect" );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            if ( distance2d( self.origin, self.starting_origin ) > 200 )
            {
                if ( isdefined( self ) )
                {
                    function_c0d3734f048c0531( 1 );
                    break;
                }
            }
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace breacher_drone
// Params 1
// Checksum 0x36b7d358, Offset: 0xc63
// Size: 0x65
function function_c69f1b449e2829c7( params )
{
    self notify( #"exploding" );
    
    if ( self.owner.ksempd || self.owner emp_debuff::is_empd() )
    {
        self setscriptablepartstate( "explode", "on_noDamage", 0 );
        return;
    }
    
    breacher_drone_explode( self.owner );
}

// Namespace breacher_drone
// Params 1
// Checksum 0x1552a170, Offset: 0xcd0
// Size: 0xba
function breacher_drone_explode( attacker )
{
    if ( getdvarint( @"hash_8bcdb1cfafe733b9", 0 ) )
    {
        self setscriptablepartstate( "explode_alt", "on", 0 );
    }
    else
    {
        self setscriptablepartstate( "explode", "on", 0 );
    }
    
    dmgradius = self.bundle.var_7a0b23c9d0efb739;
    maxdmg = self.bundle.var_88bdc36fdabace35;
    mindmg = self.bundle.var_88e0ad6fdae0e58b;
    self radiusdamage( self.origin, dmgradius, maxdmg, mindmg, attacker, "MOD_EXPLOSIVE", "breacher_drone" );
}

// Namespace breacher_drone
// Params 1
// Checksum 0x5b13d50c, Offset: 0xd92
// Size: 0x29
function function_4c937174a0b3dfd8( data )
{
    self setscriptablepartstate( "explode", "on_noDamage", 0 );
    wait 0.05;
    self delete();
}

// Namespace breacher_drone
// Params 0
// Checksum 0xfa2da79, Offset: 0xdc3
// Size: 0xa1
function function_e8750638cf62fe0e()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"disconnect" );
    droneangle = self.owner getgunangles();
    direction = anglestoforward( droneangle );
    
    while ( true )
    {
        hitents = function_a8940c6276f2860c( direction );
        
        if ( hitents.size >= 1 )
        {
            params = spawnstruct();
            params.hitents = hitents;
            callback::callback( #"on_functional_death", params );
        }
        
        waitframe();
    }
}

// Namespace breacher_drone
// Params 1
// Checksum 0x48e74bbf, Offset: 0xe6c
// Size: 0x178
function function_a8940c6276f2860c( dirvector )
{
    raycastcontents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    vectordistance = getdvarint( @"hash_880bc9cb96e0d47a" );
    raycaststart = self.origin;
    raycastend = raycaststart + dirvector * vectordistance;
    raycastresults = physics_raycast( raycaststart, raycastend, raycastcontents, undefined, 0, "physicsquery_all" );
    
    /#
        debugactive = getdvarint( @"scr_breacher_drone_debug" );
        
        if ( debugactive > 0 )
        {
            duration = 500;
            line( raycaststart, raycastend, ( 0, 0, 100 ), 1, 0, duration );
            drawcolor = ( 0, 255, 0 );
            
            foreach ( result in raycastresults )
            {
                sphere( result[ "<dev string:x24>" ], 5, drawcolor, 0, duration );
            }
        }
    #/
    
    return raycastresults;
}

// Namespace breacher_drone
// Params 0
// Checksum 0xd440334d, Offset: 0xfed
// Size: 0x1ac
function function_b9deb05c1ba0edfc()
{
    self endon( #"death" );
    self endon( #"exploding" );
    self endon( #"timeout" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    lerpdelay = getdvarfloat( @"hash_d0988687e6689cf8" ) * 1000;
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    var_a46d8ae8cf27d2e4 = getdvarint( @"hash_984112ed98131c1f" );
    launch_offset = getdvarfloat( @"hash_b3179bfb043e6579" );
    gunangle = self.owner getgunangles();
    launchdirection = anglestoforward( gunangle );
    lerpfraction = 0;
    starttime = gettime();
    target_height = self.origin[ 2 ];
    lerpstartheight = undefined;
    self.origin += launchdirection * launch_offset;
    
    while ( true )
    {
        if ( var_a46d8ae8cf27d2e4 == 1 )
        {
            timepassed = gettime() - starttime;
            lerpfraction = timepassed / lerpduration;
            
            if ( timepassed > lerpdelay )
            {
                if ( !isdefined( lerpstartheight ) )
                {
                    lerpstartheight = self.origin[ 2 ];
                }
                
                if ( lerpfraction < 1 )
                {
                    lerp_height = math::lerp( lerpstartheight, target_height, lerpfraction );
                    self.origin = ( self.origin[ 0 ], self.origin[ 1 ], lerp_height );
                }
            }
        }
        
        waitframe();
    }
}

