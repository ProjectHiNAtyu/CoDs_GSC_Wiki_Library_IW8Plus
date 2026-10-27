// scripts\mp\tripwire.gsc  (hash_19050e12e1446bb4.gscc) (size: 24959 Bytes / 0x617f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab709675 (2876282485)
// size ...... 24959 (0x617f)
// includes .. 7   (offset: 0x5ba7)
// strings ... 67  (offset: 0x5bdf)
// dev strs .. 15  (offset: 0x6013)
// exports ... 59  (offset: 0x3ff3)
// cseg ...... 0x78b + 0x3868 (0x3ff3)
// imports ... 142 (offset: 0x492b)
// animtree1 . 1   (offset: 0x60d7)
// animtree2 . 9   (offset: 0x60e3)
#using script_16ea1b94f0f381b3;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\loot\common_item;

#namespace tripwire;

// Namespace tripwire
// Params 0
// Checksum 0x3d3feb9c, Offset: 0x7a9
// Size: 0x246
function init()
{
    tripwiremodelprecache();
    spawntripwirelevelstruct();
    scriptable::scriptable_addusedcallbackbypart( "trap_device", &function_1402ecacc4a14f3d );
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    if ( utility::issharedfuncdefined( #"tripwire", #"init" ) )
    {
        [[ utility::getsharedfunc( #"tripwire", #"init" ) ]]();
    }
    
    level.var_c0402a9389a09e35 = &tripwire_enable;
    level.var_4e09347566c3e902 = &tripwire_disable;
    level.var_d2a069e71fe9643b = &function_314fc5450be92f90;
    setdvarifuninitialized( @"debug_tripwire", 0 );
    var_1dbf916af77b9662 = utility::getstructarray( "tripwire_start", "script_noteworthy" );
    
    foreach ( startstruct in var_1dbf916af77b9662 )
    {
        if ( !isdefined( startstruct.target ) )
        {
            assertmsg( "<dev string:x24>" + startstruct.origin + "<dev string:x4e>" );
        }
        
        if ( isdefined( startstruct.initted ) )
        {
            continue;
        }
        
        startstruct.initted = 1;
        endstructs = utility::getstructarray( startstruct.target, "targetname" );
        
        if ( endstructs.size < 1 )
        {
            assertmsg( "<dev string:x24>" + startstruct.origin + "<dev string:xa6>" );
        }
        
        foreach ( endstruct in endstructs )
        {
            buildtripwire( startstruct, endstruct );
        }
    }
}

// Namespace tripwire
// Params 0
// Checksum 0x3b20e8e6, Offset: 0x9f7
// Size: 0x84
function tripwiremodelprecache()
{
    precachemodel( "equipment_wm_tripwire_standard_cp" );
    precachemodel( "equipment_wm_tripwire_standard_cp" );
    precachemodel( "equipment_wm_tripwire_standard_cp" );
    precachemodel( "equipment_wm_tripwire_wall_after" );
    precachemodel( "equipment_wm_tripwire_wall_after_01" );
    precachemodel( "equipment_wm_tripwire_wall_after_02" );
    precachemodel( "equipment_wm_tripwire_wall_after_03" );
    precachemodel( "equipment_wm_tripwire_wall_after_04" );
    precachemodel( "equipment_wm_tripwire_ceiling_after" );
    precachemodel( "equipment_wm_tripwire_floor_after" );
    precachemodel( "offhand_2h_wm_grenade_frag_v0" );
    precachemodel( "offhand_2h_wm_grenade_semtex_v0" );
    precachemodel( "offhand_2h_wm_c4_v0" );
}

// Namespace tripwire
// Params 0
// Checksum 0x3b99b3c8, Offset: 0xa83
// Size: 0x5c
function spawntripwirelevelstruct()
{
    if ( !isdefined( level.tripwires ) )
    {
        level.tripwires = spawnstruct();
        level.tripwires.traptypes = [];
        level.tripwires.tripwires = [];
        level.tripwires.traps = [];
    }
}

// Namespace tripwire
// Params 2
// Checksum 0xa806a510, Offset: 0xae7
// Size: 0x15
function precache( type, model )
{
    
}

// Namespace tripwire
// Params 3
// Checksum 0x15bf26fa, Offset: 0xb04
// Size: 0x10b
function precachetrap( type, model, candisarm )
{
    if ( !isdefined( level.tripwires ) )
    {
        spawntripwirelevelstruct();
    }
    
    if ( !isdefined( level.tripwires.traptypes[ type ] ) )
    {
        level.tripwires.traptypes[ type ] = spawnstruct();
        level.tripwires.traptypes[ type ].model = model;
        level.tripwires.traptypes[ type ].triggerfunc = gettriggerfunc( type );
        level.tripwires.traptypes[ type ].candisarm = candisarm;
        
        if ( candisarm )
        {
            level.tripwires.traptypes[ type ].disarmfunc = getdisarmfunc( type );
        }
    }
    
    precachemodel( model );
}

// Namespace tripwire
// Params 3
// Checksum 0xba8e3c81, Offset: 0xc17
// Size: 0xe9
function buildtripwire( startstruct, endstruct, parenttripwire )
{
    if ( !isdefined( endstruct.script_animname ) )
    {
        endstruct.script_animname = "wall";
    }
    
    tripwire = spawntripwire( startstruct, endstruct );
    tripwire inittripwireanims( endstruct.script_animname );
    tripwire inittripwirestaticmodel( endstruct.script_animname );
    tripwire thread tripwirethink();
    tripwire thread triggertripwirefuncthink( &triggerfunctripwire );
    
    if ( isdefined( parenttripwire ) )
    {
        tripwire.targets[ tripwire.targets.size ] = parenttripwire;
    }
    
    tripwire processtripwiretarget( endstruct );
    level.tripwires.tripwires[ level.tripwires.tripwires.size ] = tripwire;
    return tripwire;
}

// Namespace tripwire
// Params 1
// Checksum 0xb8311b28, Offset: 0xd09
// Size: 0x17b
function processtripwiretarget( endstruct )
{
    msg = "script_struct_tripwire_end at location " + endstruct.origin + " has no target.  Target the ent you want the tripwire to trigger, or another script_struct_tripwire_end to continue the tripwire chain";
    
    if ( !isdefined( endstruct.target ) )
    {
        return;
    }
    
    targetstructs = utility::getstructarray( endstruct.target, "targetname" );
    targetents = getentarray( endstruct.target, #targetname );
    targets = arraycombine( targetstructs, targetents );
    
    if ( targets.size == 0 )
    {
        assertmsg( msg );
    }
    
    if ( endstruct shouldfindnavmodifier() )
    {
        self.navmodifier = createnavmodifier( endstruct.target, "targetname" );
    }
    
    foreach ( target in targets )
    {
        if ( target istripwirestruct() )
        {
            target = buildtripwire( endstruct, target, self );
        }
        else if ( target istripwiretrapstruct() )
        {
            target = buildtripwiretrap( target, self );
        }
        
        self.targets[ self.targets.size ] = target;
    }
}

// Namespace tripwire
// Params 0
// Checksum 0x2b12cc7a, Offset: 0xe8c
// Size: 0x27
function shouldfindnavmodifier()
{
    if ( isdefined( self.spawnflags ) && self.spawnflags & 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire
// Params 0
// Checksum 0x18e99988, Offset: 0xebb
// Size: 0x33
function istripwirestruct()
{
    if ( isstruct( self ) && isdefined( self.script_noteworthy ) && self.script_noteworthy == "tripwire_end" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire
// Params 0
// Checksum 0x65b18541, Offset: 0xef6
// Size: 0x36
function istripwiretrapstruct()
{
    if ( isstruct( self ) && isdefined( self.script_noteworthy ) && issubstr( self.script_noteworthy, "tripwire_trap_" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire
// Params 0
// Checksum 0x230e20dd, Offset: 0xf34
// Size: 0x95, Type: bool
function hastripwirechild()
{
    foreach ( target in self.targets )
    {
        if ( target.istripwire && !isdefined( target.triggered ) )
        {
            return true;
        }
    }
    
    return false;
}

#using_animtree( "script_model" );

// Namespace tripwire
// Params 2
// Checksum 0xd4552717, Offset: 0xfd2
// Size: 0x2b3
function spawntripwire( startstruct, endstruct )
{
    vec = startstruct.origin - endstruct.origin;
    tripwire = spawn( "script_model", endstruct.origin );
    tripwire.angles = vectortoangles( vec );
    tripwire setmodel( gettripwiremodel( endstruct.script_animname ) );
    tripwire useanimtree( #animtree );
    
    if ( isdefined( endstruct.angles ) )
    {
        f = anglestoforward( endstruct.angles );
        r = anglestoright( tripwire.angles );
        u = anglestoup( tripwire.angles );
        tripwire.finalangles = axistoangles( f, r, u );
    }
    
    tripwire.targets = [];
    tripwire.endpoint = startstruct.origin;
    tripwire.length = length( vec );
    tripwiretriggerradius = 30;
    tripwire.trigger = spawn( "trigger_rotatable_radius", tripwire.origin, 0, tripwiretriggerradius, tripwire.length + 10 );
    trigger_f = -1 * anglestoup( tripwire.angles );
    trigger_r = anglestoright( tripwire.angles );
    trigger_u = anglestoforward( tripwire.angles );
    tripwire.trigger.angles = axistoangles( trigger_f, trigger_r, trigger_u );
    tripwire.istripwire = 1;
    tripwire.triggered = 0;
    
    if ( isdefined( startstruct.script_delay ) )
    {
        tripwire.delay = startstruct.script_delay;
    }
    else
    {
        tripwire.delay = math::factor_value( 0.1, 0.35, tripwire getnormtripwirelength() );
    }
    
    /#
        if ( getdvarint( @"debug_tripwire", 0 ) != 0 )
        {
            triggerorg = tripwire.origin + anglestoforward( tripwire.angles ) * 0.5 * tripwire.length;
            thread debug_utility::drawline( tripwire.origin, triggerorg, 99999, ( 1, 0, 0 ) );
        }
    #/
    
    return tripwire;
}

// Namespace tripwire
// Params 1
// Checksum 0x84598022, Offset: 0x128e
// Size: 0xee
function inittripwireanims( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "<dev string:x105>" );
    }
    
    self.triggeranim = gettripwiretriggeranim( animname );
    self.stretchanim = gettripwirestretchanim( animname );
    self setanim( self.triggeranim, 1, 0, 0 );
    self setanim( self.stretchanim, 1, 0, 0 );
    
    if ( self.length < 10 || self.length > 300 )
    {
        assertmsg( "<dev string:x172>" + self.origin + "<dev string:x188>" + 10 + "<dev string:x19a>" + 300 + "<dev string:x1a0>" );
    }
    
    if ( getdvarint( @"hash_492741ff5b4afd4a", 0 ) )
    {
        thread function_273804969725946b( getnormtripwirelength() );
        return;
    }
    
    self setanimtime( self.stretchanim, getnormtripwirelength() );
}

// Namespace tripwire
// Params 1
// Checksum 0xf84a0c3b, Offset: 0x1384
// Size: 0x31
function inittripwirestaticmodel( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "<dev string:x105>" );
    }
    
    self.staticmodel = gettripwirestaticmodel( animname );
}

// Namespace tripwire
// Params 1
// Checksum 0x3f43a360, Offset: 0x13bd
// Size: 0x32
function gettripwiretriggersound( firsttriggered )
{
    if ( firsttriggered )
    {
        return "tripwire_pop_first";
    }
    
    if ( hastripwirechild() )
    {
        return "tripwire_pop";
    }
    
    return "tripwire_pop_last";
}

// Namespace tripwire
// Params 0
// Checksum 0x5f9dbd41, Offset: 0x13f7
// Size: 0x8a
function tripwirethink()
{
    self endon( #"tripwire_trigger" );
    self endon( #"death" );
    self.trigger endon( #"death" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", who );
        triggertraps = 1;
        firsttriggered = 1;
        
        if ( tripwireshouldtrigger( who ) )
        {
            self notify( #"trigger", who, triggertraps, firsttriggered );
        }
    }
}

// Namespace tripwire
// Params 1
// Checksum 0x47ab46fc, Offset: 0x1489
// Size: 0xb8
function tripwireshouldtrigger( who )
{
    if ( !( isdefined( self ) && isdefined( self.origin ) && isdefined( self.endpoint ) ) )
    {
        return 0;
    }
    
    if ( !isdefined( who ) || who isragdoll() )
    {
        return 0;
    }
    
    if ( !isalive( who ) )
    {
        return 0;
    }
    
    contentsoverride = trace::create_contents( 1, 0, 0, 0, 1, 1, 0, 0, 1 );
    trace = trace::ray_trace_ents( self.origin, self.endpoint, who, contentsoverride, undefined, undefined, 1 );
    
    if ( !isdefined( trace[ "fraction" ] ) )
    {
        return 0;
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tripwire
// Params 2
// Checksum 0x350f220b, Offset: 0x1549
// Size: 0x2a8
function buildtripwiretrap( struct, parenttripwire )
{
    if ( !isdefined( struct.trap ) )
    {
        if ( !isdefined( struct.angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        else
        {
            angles = struct.angles;
        }
        
        struct.trap = spawn( "script_model", struct.origin );
        struct.trap.angles = angles;
        struct.trap setmodel( level.tripwires.traptypes[ struct.script_noteworthy ].model );
        struct.trap thread triggertrapfuncthink( level.tripwires.traptypes[ struct.script_noteworthy ].triggerfunc );
        struct.trap thread damagetrapfuncthink();
        struct.trap.candisarm = level.tripwires.traptypes[ struct.script_noteworthy ].candisarm;
        struct.trap.istrap = 1;
        
        if ( isdefined( level.tripwires.traptypes[ struct.script_noteworthy ].disarmfunc ) )
        {
            struct.trap thread disarmfuncthink( level.tripwires.traptypes[ struct.script_noteworthy ].disarmfunc, struct );
        }
        
        if ( isdefined( struct.script_parameters ) )
        {
            [ struct.trap.grenadeweaponoverride ] = strtok( struct.script_parameters, " " );
        }
        
        struct.trap.parenttripwires = [];
        level.tripwires.traps[ level.tripwires.traps.size ] = struct.trap;
    }
    
    struct.trap.parenttripwires[ struct.trap.parenttripwires.size ] = parenttripwire;
    return struct.trap;
}

// Namespace tripwire
// Params 1
// Checksum 0xb41f6407, Offset: 0x17fa
// Size: 0x3ad
function function_273804969725946b( length_factor )
{
    var_cc03c7a64cb694d = 0.2;
    var_7ce7669b3e2e517e = 0.4;
    var_92b5e711a3c8fce9 = 0.6;
    tripwire_parts = [];
    tripwire_parts[ tripwire_parts.size ] = function_b0e5281aaa9f3b0a();
    
    if ( length_factor > var_cc03c7a64cb694d )
    {
        tripwire_parts[ tripwire_parts.size ] = function_b0e5281aaa9f3b0a();
    }
    
    if ( length_factor > var_7ce7669b3e2e517e )
    {
        tripwire_parts[ tripwire_parts.size ] = function_b0e5281aaa9f3b0a();
    }
    
    if ( length_factor > var_92b5e711a3c8fce9 )
    {
        tripwire_parts[ tripwire_parts.size ] = function_b0e5281aaa9f3b0a();
    }
    
    self hide();
    stretchfactor = length_factor * 2.23;
    waittime = math::factor_value( 1, 300, stretchfactor );
    waittime *= 0.05;
    animnotify = "tripwireStretchAnimTime";
    var_9aa602f2d17f5085 = anglestoforward( self.angles );
    var_7a70bce3c92e7169 = anglestoup( self.angles );
    tomatch = vectorcross( var_9aa602f2d17f5085, var_7a70bce3c92e7169 );
    var_1e7249b64bfc2a16 = self.origin + tomatch * 100 - self.origin;
    var_6d6f9e1b4e47dac1 = self.origin + var_7a70bce3c92e7169 * 100 - self.origin;
    vec1 = vectornormalize( var_6d6f9e1b4e47dac1 );
    vec2 = vectornormalize( ( 0, 0, 1 ) );
    angbetween = math::anglebetweenvectors( vec1, vec2 );
    angbetween = math::anglebetweenvectorssigned( vec1, vec2, vectornormalize( var_1e7249b64bfc2a16 ) );
    
    foreach ( part in tripwire_parts )
    {
        part scriptmodelplayanim( %tripwire_trigger_standard_stretch, animnotify, 0, 0.01 );
    }
    
    function_d580d2bb2b5cc380( waittime );
    
    foreach ( part in tripwire_parts )
    {
        part scriptmodelpauseanim( 1 );
        part rotateto( vectortoangles( tomatch ), 0.1, 0.05, 0.05 );
    }
    
    function_d580d2bb2b5cc380( 0.15 );
    
    foreach ( part in tripwire_parts )
    {
        part rotateroll( angbetween * -1, 3, 1, 1 );
    }
    
    utility::waittill_any( "tripwire_trigger", "tripwire_defused" );
    
    foreach ( part in tripwire_parts )
    {
        part delete();
    }
    
    self show();
}

// Namespace tripwire
// Params 0
// Checksum 0xd2fb4b42, Offset: 0x1baf
// Size: 0x47
function function_b0e5281aaa9f3b0a()
{
    tripwire_stretch = spawn( "script_model", self.origin );
    tripwire_stretch.angles = self.angles;
    tripwire_stretch setmodel( self.model );
    return tripwire_stretch;
}

// Namespace tripwire
// Params 0
// Checksum 0x2860619b, Offset: 0x1bff
// Size: 0x16
function getnormtripwirelength()
{
    return math::normalize_value( 10, 300, self.length );
}

// Namespace tripwire
// Params 1
// Checksum 0x5596caf0, Offset: 0x1c1e
// Size: 0x3e
function function_d580d2bb2b5cc380( durationseconds )
{
    level endon( #"game_ended" );
    durationprogress = 0;
    
    while ( durationprogress < durationseconds )
    {
        durationprogress += level.framedurationseconds;
        waitframe();
    }
}

// Namespace tripwire
// Params 0
// Checksum 0xf7f0bec5, Offset: 0x1c64
// Size: 0x96, Type: bool
function tripwirehastraps()
{
    foreach ( target in self.targets )
    {
        if ( isdefined( target.istrap ) && !isdefined( target.triggered ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tripwire
// Params 1
// Checksum 0x714e6777, Offset: 0x1d03
// Size: 0x90
function triggertripwirefuncthink( triggerfunc )
{
    while ( true )
    {
        self waittill( #"trigger", who, triggertrap, firsttriggered );
        
        if ( triggertrap )
        {
            break;
        }
        
        if ( !tripwirehastraps() )
        {
            break;
        }
    }
    
    if ( isdefined( who ) )
    {
        who.lasttriptime = gettime();
    }
    
    self notify( #"tripwire_trigger" );
    self.triggered = 1;
    self [[ triggerfunc ]]( who, triggertrap, firsttriggered );
}

// Namespace tripwire
// Params 1
// Checksum 0x69ef62bd, Offset: 0x1d9b
// Size: 0xc5
function triggertrapfuncthink( triggerfunc )
{
    while ( true )
    {
        self waittill( #"trigger", who, triggertrap );
        
        if ( triggertrap )
        {
            break;
        }
    }
    
    self notify( #"hash_317758f7d15d9609" );
    self.triggered = 1;
    
    if ( isdefined( self.defusehintstruct ) && !isdefined( self.defusehintstruct.defused ) )
    {
        if ( isent( self.defusehintstruct ) )
        {
            self.defusehintstruct makeunusable();
            self.defusehintstruct delete();
        }
    }
    
    self [[ triggerfunc ]]( who );
    level notify( #"tripwire_detonated", self.origin );
}

// Namespace tripwire
// Params 1
// Checksum 0x587d0e1a, Offset: 0x1e68
// Size: 0x6e
function gettriggerfunc( type )
{
    switch ( type )
    {
        case #"hash_32670e2a61b99a3b":
            return &triggerfuncc4;
        case #"hash_4beeaacc1db7b8cc":
            return &triggerfuncsemtex;
        case #"hash_496a20490fb91698":
            return &triggerfuncfrag;
        default:
            assertmsg( "<dev string:x1ae>" + type + "<dev string:x1d2>" );
            break;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0x5c09ade4, Offset: 0x1ede
// Size: 0xfd
function gettripwiretriggeranim( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return utility::array_random( [ %tripwire_trigger_standard_ceiling ] );
        case #"hash_3e7681464ca7b9fd":
            return utility::array_random( [ %tripwire_trigger_standard_floor ] );
        case #"hash_bdea657441323e75":
            if ( shouldusewallsize1() )
            {
                return utility::array_random( [ %tripwire_trigger_standard_wall_01 ] );
            }
            else if ( shouldusewallsize2() )
            {
                return utility::array_random( [ %tripwire_trigger_standard_wall_02 ] );
            }
            else if ( shouldusewallsize3() )
            {
                return utility::array_random( [ %tripwire_trigger_standard_wall_03 ] );
            }
            else if ( shouldusewallsize4() )
            {
                return utility::array_random( [ %tripwire_trigger_standard_wall_04 ] );
            }
            else
            {
                return utility::array_random( [ %tripwire_trigger_standard_wall ] );
            }
            
            break;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0xea0952a0, Offset: 0x1fe3
// Size: 0x94
function gettripwirestaticmodel( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return "equipment_wm_tripwire_ceiling_after";
        case #"hash_3e7681464ca7b9fd":
            return "equipment_wm_tripwire_floor_after";
        case #"hash_bdea657441323e75":
            if ( shouldusewallsize1() )
            {
                return "equipment_wm_tripwire_wall_after_01";
            }
            else if ( shouldusewallsize2() )
            {
                return "equipment_wm_tripwire_wall_after_02";
            }
            else if ( shouldusewallsize3() )
            {
                return "equipment_wm_tripwire_wall_after_03";
            }
            else if ( shouldusewallsize4() )
            {
                return "equipment_wm_tripwire_wall_after_04";
            }
            else
            {
                return "equipment_wm_tripwire_wall_after";
            }
            
            break;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0xd014c1aa, Offset: 0x207f
// Size: 0x58
function gettripwirestretchanim( animname )
{
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return %tripwire_trigger_standard_stretch;
        case #"hash_3e7681464ca7b9fd":
            return %tripwire_trigger_standard_stretch;
        case #"hash_bdea657441323e75":
            return %tripwire_trigger_standard_stretch;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0xb76904fb, Offset: 0x20df
// Size: 0x78
function gettripwiremodel( animname )
{
    if ( !isdefined( animname ) )
    {
        assertmsg( "<dev string:x105>" );
    }
    
    if ( level.script == "cp_raid1_boss1" )
    {
        return "equipment_wm_tripwire_standard_raid1_boss1";
    }
    
    switch ( animname )
    {
        case #"hash_28b4e95012259360":
            return "equipment_wm_tripwire_standard_cp";
        case #"hash_3e7681464ca7b9fd":
            return "equipment_wm_tripwire_standard_cp";
        case #"hash_bdea657441323e75":
            return "equipment_wm_tripwire_standard_cp";
    }
}

// Namespace tripwire
// Params 0
// Checksum 0x41ad7f85, Offset: 0x215f
// Size: 0x1e, Type: bool
function shouldusewallsize1()
{
    return self.length >= 51 && self.length < 69;
}

// Namespace tripwire
// Params 0
// Checksum 0xd8a42e68, Offset: 0x2186
// Size: 0x1e, Type: bool
function shouldusewallsize2()
{
    return self.length >= 69 && self.length < 100;
}

// Namespace tripwire
// Params 0
// Checksum 0xafa31ef3, Offset: 0x21ad
// Size: 0x1e, Type: bool
function shouldusewallsize3()
{
    return self.length > 10 && self.length < 37;
}

// Namespace tripwire
// Params 0
// Checksum 0x31c78b6a, Offset: 0x21d4
// Size: 0x1e, Type: bool
function shouldusewallsize4()
{
    return self.length >= 37 && self.length < 51;
}

// Namespace tripwire
// Params 3
// Checksum 0xb328f473, Offset: 0x21fb
// Size: 0x172
function triggerfunctripwire( who, triggertraps, firsttriggered )
{
    if ( isent( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self setanimrate( self.triggeranim, 1 );
    self setanim( %tripwire_stretch_overlay, 0, 0.2, 1 );
    thread swaptostaticmodel();
    self playsound( "tripwire_pop" );
    
    if ( isdefined( self.finalangles ) )
    {
        thread rotatetofinalangles();
    }
    
    if ( isplayer( who ) )
    {
        who playrumbleonentity( "damage_light" );
        earthquake( 0.1, 0.2, who.origin, 2000 );
    }
    
    wait self.delay;
    
    if ( isdefined( self.navmodifier ) )
    {
        destroynavobstacle( self.navmodifier );
    }
    
    firsttriggered = 0;
    
    if ( isdefined( self.targets ) )
    {
        foreach ( target in self.targets )
        {
            target notify( #"trigger", who, triggertraps, firsttriggered );
        }
    }
}

// Namespace tripwire
// Params 0
// Checksum 0x1c642540, Offset: 0x2375
// Size: 0x28
function rotatetofinalangles()
{
    self endon( #"death" );
    wait 0.25;
    self rotateto( self.finalangles, 0.25 );
}

// Namespace tripwire
// Params 0
// Checksum 0xd7f2843a, Offset: 0x23a5
// Size: 0x39
function swaptostaticmodel()
{
    self endon( #"death" );
    animtime = getanimlength( self.triggeranim );
    wait animtime;
    self setmodel( self.staticmodel );
}

// Namespace tripwire
// Params 0
// Checksum 0xeb582bd8, Offset: 0x23e6
// Size: 0x8f
function delete_trapfunc()
{
    firsttrigger = 1;
    
    foreach ( parenttripwire in self.parenttripwires )
    {
        parenttripwire thread triggerfunctripwire( undefined, 1, firsttrigger );
        firsttrigger = 0;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0x5015ab7e, Offset: 0x247d
// Size: 0x110
function triggerfuncsemtex( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "semtex_tripwire";
    }
    
    semtex = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    semtex.angles = self.angles;
    semtex.origin = self.origin;
    semtex linkto( self );
    self hide();
    semtex waittill( #"explode" );
    radiusdamage( self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "semtex_mp" );
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.45, 0.7, self.origin, 800 );
    wait 0.1;
    self notify( #"hash_6947fd128e51a1b2" );
    self delete();
}

// Namespace tripwire
// Params 1
// Checksum 0x83a9f9b2, Offset: 0x2595
// Size: 0x159
function triggerfuncfrag( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "frag_tripwire";
    }
    
    frag = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    frag.angles = self.angles;
    frag.origin = self.origin;
    frag linkto( self );
    self hide();
    frag waittill( #"explode" );
    
    if ( utility::issharedfuncdefined( #"tripwire", #"hash_46aac70534f51176" ) )
    {
        var_c393eef0865468ac = utility::getsharedfunc( #"tripwire", #"hash_46aac70534f51176" );
        level thread [[ var_c393eef0865468ac ]]( self, who );
    }
    else
    {
        radiusdamage( self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "frag_grenade_mp" );
        playrumbleonposition( "grenade_rumble", self.origin );
        earthquake( 0.45, 0.7, self.origin, 800 );
    }
    
    wait 0.1;
    self notify( #"hash_6947fd128e51a1b2" );
    self delete();
}

// Namespace tripwire
// Params 1
// Checksum 0xf691c540, Offset: 0x26f6
// Size: 0x166
function triggerfuncc4( who )
{
    if ( isdefined( self.grenadeweaponoverride ) )
    {
        grenadetype = self.grenadeweaponoverride;
    }
    else
    {
        grenadetype = "c4_mp";
    }
    
    c4 = magicgrenademanual( grenadetype, self.origin, ( 0, 0, 0 ), 0.25 );
    c4.angles = self.angles;
    c4.origin = self.origin;
    c4 linkto( self );
    self hide();
    c4 setscriptablepartstate( "effects", "explode", 0 );
    c4 notify( #"detonateexplosive" );
    radiusdamage( self.origin, 384, 256, 40, undefined, "MOD_EXPLOSIVE", "c4_mp" );
    self playsound( "iw9_frag_grenade_expl_trans" );
    
    if ( level.var_b7b8ccc6f5c15716 )
    {
        if ( isplayer( who ) )
        {
            who.shouldskipdeathsshield = 1;
            who dodamage( self.health + 100, self.origin, who, who, "MOD_SUICIDE", "c4_mp" );
        }
    }
    
    playrumbleonposition( "grenade_rumble", self.origin );
    earthquake( 0.45, 0.7, self.origin, 800 );
    self delete();
}

// Namespace tripwire
// Params 2
// Checksum 0x54ae7777, Offset: 0x2864
// Size: 0x294
function damagetrapfuncthink( damagefunc, struct )
{
    self endon( #"hash_317758f7d15d9609" );
    self setcandamage( 1 );
    self.health = 99999;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( utility::issharedfuncdefined( #"tripwire", #"blowtripwire" ) )
        {
            self thread [[ utility::getsharedfunc( #"tripwire", #"blowtripwire" ) ]]( attacker, type );
        }
        
        if ( utility::issharedfuncdefined( #"tripwire", #"hash_17ec5b6f42e3a391" ) )
        {
            var_c393eef0865468ac = utility::getsharedfunc( #"tripwire", #"hash_17ec5b6f42e3a391" );
            
            if ( self [[ var_c393eef0865468ac ]]( attacker, objweapon, type, damage, point ) )
            {
                break;
            }
        }
        else if ( cantriptrap( attacker, type, damage ) )
        {
            break;
        }
        
        self.health += damage;
    }
    
    self.triggered = 1;
    
    if ( isdefined( self.defusehintstruct ) && !isdefined( self.defusehintstruct.defused ) )
    {
        if ( isent( self.defusehintstruct ) )
        {
            self.defusehintstruct makeunusable();
            self.defusehintstruct delete();
        }
    }
    
    triggertraps = 0;
    firsttriggered = 1;
    self makeunusable();
    
    foreach ( parenttripwire in self.parenttripwires )
    {
        parenttripwire notify( #"trigger", attacker, triggertraps, firsttriggered );
    }
    
    self notify( #"trigger", attacker, 1 );
}

// Namespace tripwire
// Params 3
// Checksum 0x1b8c004, Offset: 0x2b00
// Size: 0x55, Type: bool
function cantriptrap( attacker, type, damage )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( isplayer( attacker ) && ( type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH" ) && damage > 150 )
    {
        return true;
    }
    
    return false;
}

// Namespace tripwire
// Params 2
// Checksum 0x35e8e436, Offset: 0x2b5e
// Size: 0x1d1
function disarmfuncthink( disarmfunc, struct )
{
    self endon( #"hash_317758f7d15d9609" );
    self.defusehintstruct = undefined;
    
    if ( utility::issharedfuncdefined( #"tripwire", #"createhintobject" ) )
    {
        var_c393eef0865468ac = utility::getsharedfunc( #"tripwire", #"createhintobject" );
        self.defusehintstruct = [[ var_c393eef0865468ac ]]( struct.origin, undefined, undefined, undefined, undefined, "duration_medium", "hide", 128, 35, 84, 35 );
    }
    else
    {
        self.defusehintstruct = struct utility::spawn_script_origin();
    }
    
    self.deletefunc = &delete_trapfunc;
    self.defusehintstruct waittill( #"trigger", who );
    level.lasttripwiredefusedtime = gettime();
    self.defusehintstruct.defused = 1;
    self.triggered = 1;
    triggertraps = 0;
    firsttriggered = 1;
    
    if ( isent( self.defusehintstruct ) )
    {
        self.defusehintstruct makeunusable();
        self.defusehintstruct delete();
    }
    
    foreach ( parenttripwire in self.parenttripwires )
    {
        parenttripwire notify( #"trigger", who, triggertraps, firsttriggered );
    }
    
    self [[ disarmfunc ]]( who );
}

// Namespace tripwire
// Params 1
// Checksum 0x1f5d887, Offset: 0x2d37
// Size: 0x5c
function getdisarmfunc( type )
{
    switch ( type )
    {
        case #"hash_4beeaacc1db7b8cc":
            return &disarmfuncsemtex;
        case #"hash_496a20490fb91698":
            return &disarmfuncfrag;
        default:
            assertmsg( "<dev string:x201>" + type + "<dev string:x225>" );
            break;
    }
}

// Namespace tripwire
// Params 1
// Checksum 0xe1991a91, Offset: 0x2d9b
// Size: 0x37
function disarmfuncsemtex( who )
{
    who disarmgiveweapon( "semtex", "semtex", self.origin, self.angles );
    self delete();
}

// Namespace tripwire
// Params 1
// Checksum 0x38854f75, Offset: 0x2dda
// Size: 0x37
function disarmfuncfrag( who )
{
    who disarmgiveweapon( "frag", "frag", self.origin, self.angles );
    self delete();
}

// Namespace tripwire
// Params 4
// Checksum 0xe9ea9898, Offset: 0x2e19
// Size: 0x71
function disarmgiveweapon( weapon, lootname, grenade_origin, grenade_angles )
{
    if ( utility::issharedfuncdefined( #"tripwire", #"hash_4cd0dc61820dc926" ) )
    {
        var_c393eef0865468ac = utility::getsharedfunc( #"tripwire", #"hash_4cd0dc61820dc926" );
        thread [[ var_c393eef0865468ac ]]( weapon, lootname, self, grenade_origin, grenade_angles );
    }
}

// Namespace tripwire
// Params 0
// Checksum 0xf4864242, Offset: 0x2e92
// Size: 0xee
function function_314fc5450be92f90()
{
    precachetrap( "tripwire_trap_frag", "offhand_2h_wm_grenade_frag_v0", 1 );
    precachetrap( "tripwire_trap_semtex", "offhand_2h_wm_grenade_semtex_v0", 1 );
    precachetrap( "tripwire_trap_c4", "offhand_2h_wm_c4_v0", 0 );
    
    if ( isdefined( level.equipment.table[ "equip_frag" ].weaponname ) )
    {
        level.tripwireweaponname = level.equipment.table[ "equip_frag" ].weaponname;
    }
    else
    {
        level.tripwireweaponname = "frag_grenade_mp";
    }
    
    if ( utility::issharedfuncdefined( #"tripwire", #"sort" ) )
    {
        [[ utility::getsharedfunc( #"tripwire", #"sort" ) ]]();
    }
    
    /#
        setdvar( @"scr_tripwire_show", 0 );
        level thread debug_tripwirelocations();
    #/
}

// Namespace tripwire
// Params 1
// Checksum 0xff138694, Offset: 0x2f88
// Size: 0x109
function function_27655ae51e3d4e95( var_ad2f1c2c5cde73a4 )
{
    scriptable::scriptable_addusedcallbackbypart( "trap_device", &function_1402ecacc4a14f3d );
    tripwires = getentitylessscriptablearray( var_ad2f1c2c5cde73a4, #classname );
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    foreach ( tripwire in tripwires )
    {
        tripwire function_aa3b37de1063ce15();
        tripwire thread function_2a8e6fecc8c37692();
    }
    
    level.tripwires.tripwires = arraycombine( level.tripwires.tripwires, tripwires );
}

// Namespace tripwire
// Params 3
// Checksum 0x2d744d48, Offset: 0x3099
// Size: 0x6b
function tripwire_enable( tripwire, ownerteam, tripwiretargets )
{
    tripwire function_aa3b37de1063ce15( ownerteam, tripwiretargets );
    tripwire thread function_2a8e6fecc8c37692();
    tripwire.enabled = 1;
    level.tripwires.tripwires[ level.tripwires.tripwires.size ] = tripwire;
}

// Namespace tripwire
// Params 1
// Checksum 0x29d6d2d9, Offset: 0x310c
// Size: 0x14f
function tripwire_disable( tripwire )
{
    tripwire.enabled = 0;
    assert( isdefined( tripwire.targetarray ), "<dev string:x24d>" );
    
    foreach ( item in tripwire.targetarray )
    {
        if ( item getscriptablehaspart( "trap_device" ) )
        {
            item setscriptablepartstate( "trap_device", "off" );
            continue;
        }
        
        if ( item.classname == "scriptable_dmz_tripwire" || item.classname == "scriptable_ob_tripwire" )
        {
            item setscriptablepartstate( "wire", "off" );
            continue;
        }
        
        if ( item getscriptablehaspart( "wall_pin" ) )
        {
            item setscriptablepartstate( "wall_pin", "invisible" );
            continue;
        }
        
        assertmsg( "<dev string:x272>" + tripwire.origin );
    }
    
    tripwire setscriptablepartstate( "wire", "off" );
}

// Namespace tripwire
// Params 2
// Checksum 0x64d249b8, Offset: 0x3263
// Size: 0x4c9
function function_aa3b37de1063ce15( navobstacleteam, targets )
{
    tripwire = self;
    tripwire setscriptablepartstate( "wire", "wire_taut" );
    tripwire.targets = [];
    tripwire.length = 64;
    tripwire.istripwire = 1;
    tripwire.triggered = 0;
    tripwire.delay = 0.35;
    var_5f7b881f5c8073ed = 0;
    
    if ( !isdefined( targets ) )
    {
        targets = getentitylessscriptablearray( tripwire.target, #targetname );
    }
    
    tripwire.targetarray = targets;
    tripwire.trapdevice = undefined;
    var_13a0b6b1eb22ec2 = [];
    
    foreach ( item in tripwire.targetarray )
    {
        if ( item getscriptablehaspart( "trap_device" ) )
        {
            tripwire.trapdevice = item;
            tripwire.trapdevice.tripwire = tripwire;
            continue;
        }
        
        if ( item.classname == "scriptable_dmz_tripwire" || item.classname == "scriptable_ob_tripwire" || item.classname == "scriptable_wz_tripwire" )
        {
            item setscriptablepartstate( "wire", "wire_taut" );
            tripwire.extrawire = item;
            var_5f7b881f5c8073ed = 15;
            continue;
        }
        
        if ( item getscriptablehaspart( "wall_pin" ) )
        {
            item setscriptablepartstate( "wall_pin", "visible", 1 );
            var_13a0b6b1eb22ec2[ var_13a0b6b1eb22ec2.size ] = item.origin;
            continue;
        }
        
        assertmsg( "<dev string:x272>" + tripwire.origin );
    }
    
    tripwire.trapdevice setscriptablepartstate( "trap_device", "active" );
    var_c3465365b2e2a29d = var_13a0b6b1eb22ec2.size == 2;
    tripwiretriggerradius = 5;
    trigger_f = -1 * anglestoup( tripwire.angles );
    trigger_r = anglestoright( tripwire.angles );
    trigger_u = anglestoforward( tripwire.angles );
    triggerlength = tripwire.length + var_5f7b881f5c8073ed;
    triggerpos = tripwire.origin - var_5f7b881f5c8073ed * trigger_u;
    
    if ( var_c3465365b2e2a29d )
    {
        var_861c8cb4398451fc = var_13a0b6b1eb22ec2[ 0 ] - var_13a0b6b1eb22ec2[ 1 ];
        tripwire.length = length( var_861c8cb4398451fc );
        triggerlength = tripwire.length;
        triggerpos = tripwire.origin;
    }
    
    tripwire.trigger = spawn( "trigger_rotatable_radius", triggerpos, 0, tripwiretriggerradius, triggerlength );
    tripwire.trigger.angles = axistoangles( trigger_f, trigger_r, trigger_u );
    navobstaclepos = tripwire.origin + trigger_u * 32;
    var_b9e4476bb898a56d = ( 40, 30, 64 + var_5f7b881f5c8073ed );
    
    if ( var_c3465365b2e2a29d )
    {
        navobstaclepos = tripwire.origin + trigger_u * tripwire.length * 0.5;
        var_e91379ce86c93dcf = getdvarint( @"hash_b20f014ff8301b42", 4 );
        navobstacledepth = getdvarint( @"hash_b64fa5855f75fdb5", 7 );
        var_adab2dbf749f4471 = getdvarint( @"hash_9950ea4c303f6053", 10 );
        var_280c9d62ca56ee4c = tripwire.length * 0.5;
        var_b9e4476bb898a56d = ( var_280c9d62ca56ee4c + var_e91379ce86c93dcf, navobstacledepth, var_adab2dbf749f4471 );
    }
    
    /#
        if ( getdvarint( @"debug_tripwire", 0 ) != 0 )
        {
            thread debug_utility::drawsphere( navobstaclepos, 10, 600, ( 0, 1, 0 ) );
        }
    #/
    
    if ( isdefined( navobstacleteam ) )
    {
        tripwire.navobstacleid = createnavbadplacebybounds( navobstaclepos, var_b9e4476bb898a56d, tripwire.angles, navobstacleteam );
    }
    else
    {
        tripwire.navobstacleid = createnavobstaclebybounds( navobstaclepos, var_b9e4476bb898a56d, tripwire.angles );
    }
    
    if ( utility::issharedfuncdefined( #"tripwire", #"ontripwirecreate" ) )
    {
        [[ utility::getsharedfunc( #"tripwire", #"ontripwirecreate" ) ]]( tripwire );
    }
}

// Namespace tripwire
// Params 0
// Checksum 0x437eb24c, Offset: 0x3734
// Size: 0x47
function function_2a8e6fecc8c37692()
{
    tripwire = self;
    tripwire endon( #"tripwire_defused" );
    tripwire.trigger waittill( #"trigger", triggeringent );
    function_92873af45d9d406( triggeringent, tripwire );
}

// Namespace tripwire
// Params 2
// Checksum 0x4e3f528d, Offset: 0x3783
// Size: 0x26c
function function_92873af45d9d406( triggeringent, tripwire )
{
    if ( tripwire.triggered )
    {
        return;
    }
    
    tripwire.triggered = 1;
    
    if ( isdefined( tripwire.extrawire ) )
    {
        tripwire.extrawire setscriptablepartstate( "wire", "wire_snap" );
        tripwire setscriptablepartstate( "wire", "off" );
    }
    else
    {
        tripwire setscriptablepartstate( "wire", "wire_snap" );
    }
    
    tripwire.trapdevice setscriptablepartstate( "trap_device", "off" );
    grenadename = "frag_tripwire";
    
    if ( isdefined( tripwire.script_parameters ) )
    {
        grenadename = tripwire.script_parameters;
    }
    else if ( tripwire.var_b4c81558b4af6d74 )
    {
        grenadename = tripwire.var_b4c81558b4af6d74;
    }
    
    frag = magicgrenademanual( grenadename, tripwire.trapdevice.origin, ( 0, 0, 0 ), 0.25 );
    frag waittill( #"explode" );
    
    if ( isdefined( tripwire.script_parameters ) && !isstring( tripwire.script_parameters ) && utility::issharedfuncdefined( #"tripwire", tripwire.script_parameters ) )
    {
        [[ utility::getsharedfunc( #"tripwire", tripwire.script_parameters ) ]]( triggeringent, tripwire );
    }
    else if ( utility::issharedfuncdefined( #"tripwire", #"tripwire_override" ) )
    {
        [[ utility::getsharedfunc( #"tripwire", #"tripwire_override" ) ]]( triggeringent, tripwire );
    }
    else
    {
        function_c93c5231c3dba4ec( tripwire );
    }
    
    if ( utility::issharedfuncdefined( #"tripwire", #"hash_836d8240dd8e7837" ) )
    {
        [[ utility::getsharedfunc( #"tripwire", #"hash_836d8240dd8e7837" ) ]]( triggeringent, tripwire );
    }
    
    if ( isdefined( tripwire.var_ffe73dd7ffd0aba ) )
    {
        self [[ tripwire.var_ffe73dd7ffd0aba ]]( triggeringent );
    }
    
    wait 0.1;
    
    if ( isdefined( tripwire.navobstacleid ) )
    {
        destroynavobstacle( tripwire.navobstacleid );
        tripwire.navobstacleid = undefined;
    }
    
    tripwire.trigger delete();
}

// Namespace tripwire
// Params 1
// Checksum 0xd53bbb40, Offset: 0x39f7
// Size: 0x93
function function_c93c5231c3dba4ec( tripwire )
{
    level.var_1b7719e8fe46996d radiusdamage( tripwire.trapdevice.origin, 384, 200, 40, level.var_1b7719e8fe46996d, "MOD_GRENADE", level.tripwireweaponname );
    playrumbleonposition( "grenade_rumble", tripwire.trapdevice.origin );
    earthquake( 0.45, 0.7, tripwire.trapdevice.origin, 800 );
}

// Namespace tripwire
// Params 6
// Checksum 0x73b8b18e, Offset: 0x3a92
// Size: 0x202
function function_1402ecacc4a14f3d( instance, part, state, player, bautouse, usestring )
{
    if ( part == "trap_device" )
    {
        instance setscriptablepartstate( "trap_device", "off" );
        
        if ( isdefined( instance.tripwire.extrawire ) )
        {
            instance.tripwire.extrawire setscriptablepartstate( "wire", "wire_snap" );
            instance.tripwire setscriptablepartstate( "wire", "off" );
        }
        else
        {
            instance.tripwire setscriptablepartstate( "wire", "wire_snap" );
        }
        
        instance.tripwire notify( #"tripwire_defused" );
        
        if ( utility::issharedfuncdefined( #"tripwire", #"ontripwiredefused" ) )
        {
            [[ utility::getsharedfunc( #"tripwire", #"ontripwiredefused" ) ]]( player, instance.tripwire );
        }
        
        if ( isdefined( instance.tripwire.navobstacleid ) )
        {
            destroynavobstacle( instance.tripwire.navobstacleid );
            instance.tripwire.navobstacleid = undefined;
        }
        
        if ( isent( instance.tripwire.trigger ) )
        {
            instance.tripwire.trigger delete();
        }
        
        var_c78a8c10b55266b6 = common_item::function_70d4affb770e8103( "equip_frag" );
        instance.tripwire.disabled = 1;
        spawnoptions = namespace_9d8e359c3b1041e5::initspawnoptions_spawnfrompositionsharedfunc( instance.origin, instance.angles );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( var_c78a8c10b55266b6, 1, spawnoptions );
    }
}

/#

    // Namespace tripwire
    // Params 0
    // Checksum 0xadb58d87, Offset: 0x3c9c
    // Size: 0x357, Type: dev
    function debug_tripwirelocations()
    {
        level endon( #"game_ended" );
        tripwires = getentitylessscriptablearray( "<dev string:x2a3>", #classname );
        enabledcolor = ( 0, 1, 0 );
        disabledcolor = ( 1, 0, 0 );
        disarmedcolor = ( 0, 0, 1 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_tripwire_show", 0 ) == 1 )
            {
                foreach ( tripwire in tripwires )
                {
                    if ( tripwire.enabled )
                    {
                        thread debug_utility::drawsphere( tripwire.origin, 32, 1, enabledcolor );
                    }
                }
            }
            else if ( getdvarint( @"scr_tripwire_show", 0 ) == 2 )
            {
                foreach ( tripwire in tripwires )
                {
                    if ( !tripwire.enabled )
                    {
                        thread debug_utility::drawsphere( tripwire.origin, 32, 1, disabledcolor );
                    }
                }
            }
            else if ( getdvarint( @"scr_tripwire_show", 0 ) == 3 )
            {
                foreach ( tripwire in tripwires )
                {
                    if ( tripwire.triggered || tripwire.disarmed )
                    {
                        thread debug_utility::drawsphere( tripwire.origin, 32, 1, disarmedcolor );
                        continue;
                    }
                    
                    if ( tripwire.enabled )
                    {
                        thread debug_utility::drawsphere( tripwire.origin, 32, 1, enabledcolor );
                        continue;
                    }
                    
                    thread debug_utility::drawsphere( tripwire.origin, 32, 1, disabledcolor );
                }
            }
            else if ( getdvarint( @"scr_tripwire_show", 0 ) == 4 )
            {
                foreach ( tripwire in tripwires )
                {
                    if ( tripwire.triggered || tripwire.disarmed )
                    {
                        thread debug_utility::drawsphere( tripwire.origin, 32, 1, disarmedcolor );
                    }
                }
            }
            
            wait 1;
        }
    }

#/
