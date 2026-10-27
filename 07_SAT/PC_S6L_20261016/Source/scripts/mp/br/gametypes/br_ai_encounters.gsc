// scripts\mp\br\gametypes\br_ai_encounters.gsc  (hash_430db7aa7226b2f3.gscc) (size: 48351 Bytes / 0xbcdf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52239ad9 (1378065113)
// size ...... 48351 (0xbcdf)
// includes .. 18  (offset: 0xafa7)
// strings ... 137 (offset: 0xb037)
// dev strs .. 102 (offset: 0xb7bb)
// exports ... 144 (offset: 0x707b)
// cseg ...... 0xc1f + 0x645c (0x707b)
// imports ... 321 (offset: 0x86fb)
// animtree1 . 0   (offset: 0xbcdf)
// animtree2 . 0   (offset: 0xbcdf)
#using script_16ea1b94f0f381b3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_ai_encounters_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_respawn;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_util;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;

#namespace br_ai_encounters;

// Namespace br_ai_encounters
// Params 0
// Checksum 0x96185d4b, Offset: 0xc3d
// Size: 0x94
function init()
{
    setdvarifuninitialized( @"scr_br_ai_encounters", 0 );
    
    if ( !getdvarint( @"scr_br_ai_encounters", 0 ) )
    {
        return;
    }
    
    setdvarifuninitialized( @"hash_ab50f58bb9979459", 30 );
    ai_encounter_info = spawnstruct();
    
    /#
        ai_encounter_info.debugtype = "<dev string:x24>";
    #/
    
    ai_encounter_info init_encounters();
    ai_encounter_info init_locations();
    ai_encounter_info thread encounter_manager();
    level.disableinitplayergameobjects = 0;
    
    /#
        level.var_13ca448b232206b = ai_encounter_info;
        ai_encounter_info thread init_debug();
    #/
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x91b6b931, Offset: 0xcd9
// Size: 0x24
function add_encounter_start_condition( func, params )
{
    add_condition( "encounter", func, params );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x5910b79b, Offset: 0xd05
// Size: 0x24
function add_location_start_condition( func, params )
{
    add_condition( "location", func, params );
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0xdfb5da76, Offset: 0xd31
// Size: 0x8e
function add_condition( category, func, params )
{
    if ( !isdefined( self.startconditions[ category ] ) )
    {
        self.startconditions[ category ] = [];
    }
    
    condition = spawnstruct();
    condition.func = func;
    condition.params = params;
    count = self.startconditions[ category ].size;
    self.startconditions[ category ][ count ] = condition;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xd376b227, Offset: 0xdc7
// Size: 0x34
function add_encounter_start_function( func )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    assert( !isdefined( self.func_encounterstart ) );
    self.func_encounterstart = func;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x6c7a68f, Offset: 0xe03
// Size: 0x326
function init_encounters()
{
    self.encounters = [];
    self.allencounters = [];
    root = init_encounter( "root" );
    
    /#
        root add_encounter_start_condition( &condition_debugpaused );
    #/
    
    root add_encounter_start_condition( &condition_prematchdone );
    root add_encounter_start_condition( &condition_mintimepassed, 60 );
    root add_encounter_start_condition( &condition_maxaliveplayers, 70 );
    root add_encounter_start_condition( &condition_maxactivelocations, 1 );
    root add_encounter_start_condition( &condition_lastencounterstarttime, 30 );
    root add_location_start_condition( &condition_stateis, 0 );
    root add_location_start_condition( &condition_insafecircle );
    root add_encounter_start_condition( &condition_circlecount, 2 );
    root add_encounter_start_condition( &condition_circlesremaining, 2 );
    root add_location_start_condition( &condition_anyplayerinsideradius, 7500 );
    root add_encounter_start_function( &root_ecounterstart );
    root_ai = init_encounter( "root_ai", root );
    root_ai add_encounter_start_function( &rootai_ecounterstart );
    bank = init_encounter( "bank", root_ai );
    bank add_location_start_condition( &condition_allplayersoutsideradius, 3000 );
    bank add_encounter_start_function( &bank_ecounterstart );
    airport = init_encounter( "airport", root_ai );
    airport add_location_start_condition( &condition_allplayersoutsideradius, 3000 );
    airport add_encounter_start_function( &airport_ecounterstart );
    truck = init_encounter( "truck", root_ai );
    truck add_location_start_condition( &condition_allplayersoutsideradius, 3000 );
    truck add_encounter_start_function( &truck_encounterstart );
    crate_guard = init_encounter( "crate_guard", root_ai );
    crate_guard add_location_start_condition( &condition_allplayersoutsideradius, 3000 );
    crate_guard add_encounter_start_function( &crateguard_encounterstart );
    jugg = init_encounter( "jugg", root_ai );
    jugg add_location_start_condition( &condition_allplayersoutsideradius, 1000 );
    jugg add_encounter_start_condition( &condition_disabled );
    test = init_encounter( "test", root_ai );
    test add_encounter_start_condition( &condition_disabled );
    test add_encounter_start_function( &test_ecounterstart );
    root_non_ai = init_encounter( "root_non_ai", root );
    root_non_ai add_location_start_condition( &condition_allplayersoutsideradius, 2000 );
    root_non_ai add_encounter_start_function( &rootnonai_ecounterstart );
    dom = init_encounter( "dom", root_non_ai );
    dom add_encounter_start_function( &dom_encounterstart );
    bomb_plant = init_encounter( "bomb_plant", root_non_ai );
    bomb_plant add_encounter_start_function( &bombplant_encounterstart );
    extraction = init_encounter( "extraction", root_non_ai );
    extraction add_encounter_start_function( &extraction_encounterstart );
    extraction add_encounter_start_condition( &condition_disabled );
    destruction = init_encounter( "destruction", root_non_ai );
    destruction add_encounter_start_function( &destruction_encounterstart );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0xf8bb7eef, Offset: 0x1131
// Size: 0xf8
function init_encounter( name, parent )
{
    encounter = spawnstruct();
    encounter.name = name;
    encounter.info = self;
    encounter.parentencounter = parent;
    encounter.encounters = [];
    encounter.startconditions = [];
    encounter.locations = [];
    
    /#
        encounter.debugtype = "<dev string:x29>";
    #/
    
    assert( !isdefined( self.allencounters[ name ] ), "<dev string:x33>" + name + "<dev string:x43>" );
    self.allencounters[ name ] = encounter;
    
    if ( isdefined( parent ) )
    {
        parent.encounters[ parent.encounters.size ] = encounter;
    }
    else
    {
        self.encounters[ self.encounters.size ] = encounter;
    }
    
    return encounter;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xb1fc6388, Offset: 0x1232
// Size: 0xac
function init_locations()
{
    /#
        function_74aa0eb4c6c52725();
    #/
    
    self.alllocations = [];
    self.activelocations = [];
    locations = utility::getstructarray( "ai_encounters", "targetname" );
    
    foreach ( location in locations )
    {
        init_location( location );
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x6e4b02ca, Offset: 0x12e6
// Size: 0x119
function init_location( location )
{
    /#
        function_74aa0eb4c6c52725();
    #/
    
    location.name = location.script_noteworthy;
    
    /#
        location.debugtype = "<dev string:x53>";
    #/
    
    assert( isdefined( location.name ), "<dev string:x5c>" );
    assert( isdefined( self.allencounters[ location.name ] ), "<dev string:x8e>" + location.name + "<dev string:xb4>" );
    encounter = self.allencounters[ location.name ];
    encounter.locations[ encounter.locations.size ] = location;
    location.encounter = encounter;
    location.state = 0;
    locationcount = self.alllocations.size;
    
    /#
        location.debugindex = locationcount;
    #/
    
    self.alllocations[ locationcount ] = location;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x5e12a869, Offset: 0x1407
// Size: 0x65
function encounter_manager()
{
    /#
        function_74aa0eb4c6c52725();
    #/
    
    while ( true )
    {
        self.validlocations = [];
        update_conditions( self.encounters );
        
        if ( self.validlocations.size )
        {
            location = utility::array_random( self.validlocations );
            encounter_start( location );
        }
        
        wait 0.05;
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x529e917a, Offset: 0x1474
// Size: 0x12c
function update_conditions( encounters )
{
    foreach ( encounter in encounters )
    {
        if ( !encounter check_encounter_start_conditions() )
        {
            continue;
        }
        
        update_conditions( encounter.encounters );
        
        foreach ( location in encounter.locations )
        {
            if ( !location check_location_start_conditions() )
            {
                continue;
            }
            
            self.validlocations[ self.validlocations.size ] = location;
        }
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x81df46c3, Offset: 0x15a8
// Size: 0x19
function check_encounter_start_conditions()
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    return check_start_conditions( self, "encounter", 0 );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x7b2845dd, Offset: 0x15ca
// Size: 0x22
function check_location_start_conditions()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    return check_start_conditions( self.encounter, "location", 1 );
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0x1a18be09, Offset: 0x15f5
// Size: 0x103, Type: bool
function check_start_conditions( encounter, conditiontype, var_84255060b719d178 )
{
    if ( var_84255060b719d178 && isdefined( encounter.parentencounter ) )
    {
        if ( !check_start_conditions( encounter.parentencounter, conditiontype, var_84255060b719d178 ) )
        {
            return false;
        }
    }
    
    if ( !isdefined( encounter.startconditions[ conditiontype ] ) )
    {
        return true;
    }
    
    for ( i = 0; i < encounter.startconditions[ conditiontype ].size ; i++ )
    {
        condition = encounter.startconditions[ conditiontype ][ i ];
        
        if ( isdefined( condition.params ) )
        {
            result = self [[ condition.func ]]( condition.params );
        }
        else
        {
            result = self [[ condition.func ]]();
        }
        
        /#
            if ( result )
            {
                function_8e305de2cc844ac3( undefined );
            }
        #/
        
        if ( !result )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x918896e2, Offset: 0x1701
// Size: 0x5a
function encounter_start( location )
{
    location.state = 1;
    self.activelocations[ self.activelocations.size ] = location;
    location.starttime = gettime();
    
    /#
        location.activedebuginfo = [];
    #/
    
    encounter_location_start_functions( location );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xacb60658, Offset: 0x1763
// Size: 0x20
function encounter_location_start_functions( location )
{
    location encounter_start_functions( location.encounter );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x6c87ff02, Offset: 0x178b
// Size: 0x55
function encounter_start_functions( encounter )
{
    /#
        function_a61e8bcf61450006();
    #/
    
    if ( isdefined( encounter.parentencounter ) )
    {
        encounter_start_functions( encounter.parentencounter );
    }
    
    if ( isdefined( encounter.func_encounterstart ) )
    {
        self [[ encounter.func_encounterstart ]]();
    }
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x754daa20, Offset: 0x17e8
// Size: 0x14a
function encounter_end( success, successteam )
{
    if ( success )
    {
        self.state = 2;
    }
    else
    {
        self.state = 3;
    }
    
    self.endtime = gettime();
    self.duration = self.endtime - self.starttime;
    
    /#
        self.activedebuginfo = undefined;
    #/
    
    info = self.encounter.info;
    info.activelocations = arrayremove( info.activelocations, self );
    info.lastencounter = self;
    
    if ( self.usesai )
    {
        foreach ( agent in self.agents )
        {
            if ( isalive( agent ) )
            {
                agent suicide();
            }
        }
    }
    
    self notify( #"hash_40e543a1950bc4ec", success, successteam );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x6f4e37a1, Offset: 0x193a
// Size: 0x26, Type: bool
function condition_disabled( encounter )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    /#
        function_8e305de2cc844ac3( "<dev string:xb6>" );
    #/
    
    return false;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x80dd2b5c, Offset: 0x1969
// Size: 0x57, Type: bool
function condition_stateis( state )
{
    /#
        function_a61e8bcf61450006();
    #/
    
    if ( self.state != state )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:xbf>" + state_to_string( self.state ) + "<dev string:xc6>" + state_to_string( state ) );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xac7013f1, Offset: 0x19c9
// Size: 0xc5, Type: bool
function condition_anyplayerinsideradius( radius )
{
    /#
        function_a61e8bcf61450006();
    #/
    
    radiussqr = radius * radius;
    sortedplayers = sortbydistance( level.players, self.origin );
    
    for ( i = 0; i < sortedplayers.size ; i++ )
    {
        player = sortedplayers[ i ];
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        dist2dsqr = distance2dsquared( player.origin, self.origin );
        
        if ( dist2dsqr < radiussqr )
        {
            return true;
        }
        
        break;
    }
    
    /#
        function_8e305de2cc844ac3( "<dev string:xd1>" + radius + "<dev string:xe7>" );
    #/
    
    return false;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xe4268d44, Offset: 0x1a97
// Size: 0xd7, Type: bool
function condition_allplayersoutsideradius( radius )
{
    /#
        function_a61e8bcf61450006();
    #/
    
    radiussqr = radius * radius;
    sortedplayers = sortbydistance( level.players, self.origin );
    
    for ( i = 0; i < sortedplayers.size ; i++ )
    {
        player = sortedplayers[ i ];
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        dist2dsqr = distance2dsquared( player.origin, self.origin );
        
        if ( dist2dsqr < radiussqr )
        {
            /#
                function_8e305de2cc844ac3( "<dev string:xe9>" + player.name + "<dev string:xf1>" + radius + "<dev string:xe7>" );
            #/
            
            return false;
        }
        
        break;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x91de980, Offset: 0x1b77
// Size: 0xa8, Type: bool
function condition_insafecircle()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    if ( level.br_circle_disabled )
    {
        return true;
    }
    
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) ) )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:xfe>" );
        #/
        
        return false;
    }
    
    circleorigin = br_circle::getsafecircleorigin();
    circleradius = br_circle::getsafecircleradius();
    locationdistsqr = distance2dsquared( self.origin, circleorigin );
    
    if ( locationdistsqr > circleradius * circleradius )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x112>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x865f777e, Offset: 0x1c28
// Size: 0x96, Type: bool
function condition_circlecount( mincircles )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( level.br_circle_disabled )
    {
        return true;
    }
    
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) ) )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:xfe>" );
        #/
        
        return false;
    }
    
    circlenum = getomnvar( "ui_br_circle_num" );
    
    if ( circlenum < mincircles )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x132>" + circlenum + "<dev string:x142>" + mincircles );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x40b02bdf, Offset: 0x1cc7
// Size: 0xc4, Type: bool
function condition_circlesremaining( mincircles )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( level.br_circle_disabled )
    {
        return true;
    }
    
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) ) )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x147>" + mincircles );
        #/
        
        return false;
    }
    
    totalcircles = level.br_level.br_circledelaytimes.size;
    circlesremaining = totalcircles - level.br_circle.circleindex;
    
    if ( circlesremaining < mincircles )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x168>" + circlesremaining + "<dev string:x142>" + mincircles );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xcb49a681, Offset: 0x1d94
// Size: 0xe8, Type: bool
function condition_maxaliveplayers( maxaliveplayers )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( !isdefined( level.teamdata ) )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x17c>" );
        #/
        
        return false;
    }
    
    count = 0;
    
    foreach ( teaminfo in level.teamdata )
    {
        count += teaminfo[ "aliveCount" ];
    }
    
    if ( count > maxaliveplayers )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x19b>" + count + "<dev string:x1b2>" + maxaliveplayers + "<dev string:xe7>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xe9364f9f, Offset: 0x1e85
// Size: 0x4c, Type: bool
function condition_maxactivelocations( maxactive )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( self.info.activelocations.size >= maxactive )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x1bb>" + maxactive + "<dev string:x1c0>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xe547b9c8, Offset: 0x1eda
// Size: 0x52, Type: bool
function condition_mintimepassed( timesec )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    passedtime = game_utility_mp::getsecondspassed();
    
    if ( passedtime < timesec )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x1d4>" + floor( passedtime ) + "<dev string:x1f2>" + timesec );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x5b7164d1, Offset: 0x1f35
// Size: 0x8c, Type: bool
function condition_lastencounterstarttime( timesec )
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    info = self.info;
    
    if ( isdefined( info.lastencounter ) )
    {
        timesincelastencounter = ( gettime() - info.lastencounter.endtime ) / 1000;
        
        if ( timesincelastencounter < timesec )
        {
            /#
                function_8e305de2cc844ac3( "<dev string:x1f4>" + floor( timesincelastencounter ) + "<dev string:x1f2>" + timesec );
            #/
            
            return false;
        }
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x8410c0e9, Offset: 0x1fca
// Size: 0x50, Type: bool
function condition_prematchdone()
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( !isdefined( game[ "flags" ][ "prematch_done" ] ) )
    {
        /#
            function_8e305de2cc844ac3( "<dev string:x213>" );
        #/
        
        return false;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return true;
    }
    
    /#
        function_8e305de2cc844ac3( "<dev string:x228>" );
    #/
    
    return false;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x4fff06fc, Offset: 0x2023
// Size: 0x34, Type: bool
function condition_debugpaused()
{
    /#
        function_f146f8d73fc64fba();
    #/
    
    if ( getdvarint( @"scr_ai_encounters_pause", 0 ) )
    {
        /#
            function_8e305de2cc844ac3( @"scr_ai_encounters_pause" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xf8c430f2, Offset: 0x2060
// Size: 0x45
function successcondition_enemykills( numkills )
{
    self endon( #"hash_40e543a1950bc4ec" );
    
    while ( true )
    {
        self waittill( #"agent_killed" );
        
        if ( self.agentskilled >= numkills )
        {
            encounter_end( 1 );
        }
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x7d17cfb1, Offset: 0x20ad
// Size: 0x8c
function failcondition_noplayersinengagedradius( timesec )
{
    self endon( #"hash_40e543a1950bc4ec" );
    
    /#
        function_a61e8bcf61450006();
    #/
    
    timesec = int( timesec );
    timesecmax = timesec;
    
    while ( true )
    {
        wait 1;
        
        if ( self.playersinengagedradius.size > 0 )
        {
            timesec = timesecmax;
        }
        else
        {
            timesec--;
            
            if ( timesec <= 0 )
            {
                encounter_end( 0 );
            }
        }
        
        /#
            self.activedebuginfo[ "<dev string:x23a>" ] = "<dev string:x261>" + timesec + "<dev string:x271>";
        #/
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x95999d6b, Offset: 0x2141
// Size: 0xe6
function failcondition_outsidedangercircle()
{
    self endon( #"hash_40e543a1950bc4ec" );
    
    /#
        function_a61e8bcf61450006();
    #/
    
    while ( true )
    {
        wait 1;
        
        if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) ) )
        {
            continue;
        }
        
        circleorigin = br_circle::getdangercircleorigin();
        circleradius = br_circle::getdangercircleradius();
        locationdistsqr = distance2dsquared( self.origin, circleorigin );
        
        if ( locationdistsqr > circleradius * circleradius )
        {
            if ( self.playersinengagedradius.size > 0 )
            {
                /#
                    self.activedebuginfo[ "<dev string:x273>" ] = "<dev string:x295>";
                #/
            }
            else
            {
                encounter_end( 0 );
            }
            
            continue;
        }
        
        /#
            self.activedebuginfo[ "<dev string:x273>" ] = "<dev string:x2c5>" + circleradius - sqrt( locationdistsqr );
        #/
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xc13d70bc, Offset: 0x222f
// Size: 0xae
function targetstart_spawner( target )
{
    targetstart_spawner_init( target );
    agent = spawn_agent( target );
    
    if ( isdefined( agent ) )
    {
        if ( isdefined( target.goalnodes ) )
        {
            goalnode = utility::array_random( target.goalnodes );
            agent setgoalnode( goalnode );
        }
        
        if ( isdefined( target.goalvolumes ) )
        {
            goalvolume = utility::array_random( target.goalvolumes );
            
            if ( goalvolume.auto )
            {
                agent setgoalvolumeauto( goalvolume );
            }
            else
            {
                agent setgoalvolume( goalvolume );
            }
        }
    }
    
    return agent;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xe817c968, Offset: 0x22e6
// Size: 0x141
function targetstart_spawner_init( spawner )
{
    spawner.team = br_ai_encounters_util::get_ai_team();
    spawner.aitype = [[ self.func_getspawneraitype ]]( spawner );
    targets = spawner br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        if ( !isdefined( target.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_8079f40c9ac24495":
                targetstart_spawner_volume( spawner, target, 0 );
                break;
            case #"hash_ab087df0efd0561":
                targetstart_spawner_volume( spawner, target, 1 );
                break;
            case #"hash_6450733d0f02003b":
            case #"hash_8d43150f19c69bd6":
                targetstart_spawner_node( spawner, target );
                break;
            default:
                break;
        }
    }
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x1806502f, Offset: 0x242f
// Size: 0x4b
function targetstart_spawner_node( spawner, node )
{
    if ( !isdefined( spawner.goalnodes ) )
    {
        spawner.goalnodes = [];
    }
    
    spawner.goalnodes[ spawner.goalnodes.size ] = node;
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0x33abbc9d, Offset: 0x2482
// Size: 0x62
function targetstart_spawner_volume( spawner, volume, auto )
{
    if ( !isdefined( spawner.goalvolumes ) )
    {
        spawner.goalvolumes = [];
    }
    
    volume.auto = auto;
    spawner.goalvolumes[ spawner.goalvolumes.size ] = volume;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x9f5b6422, Offset: 0x24ec
// Size: 0x8a
function targetstart_icon( iconstruct )
{
    id = objidpoolmanager::requestobjectiveid( 0 );
    objidpoolmanager::objective_add_objective( id, "current", iconstruct.origin, "icon_waypoint_objective_general", "icon_regular" );
    objective_setshowoncompass( id, 1 );
    objective_setplayintro( id, 1 );
    objective_setlabel( id, self.iconlabel );
    thread icon_update_visibility( id );
    self waittill( #"hash_40e543a1950bc4ec" );
    objidpoolmanager::returnobjectiveid( id );
    objective_delete( id );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x7c0280be, Offset: 0x257e
// Size: 0x1eb
function targetstart_reward( rewardstruct )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    self waittill( #"hash_40e543a1950bc4ec", success, successteam );
    
    if ( !success )
    {
        return;
    }
    
    rewardobject = rewardspawn( rewardstruct );
    
    if ( !isdefined( rewardobject ) )
    {
        return;
    }
    
    if ( isdefined( successteam ) )
    {
        successplayers = [];
        otherplayers = [];
        
        foreach ( guid, lasttime in self.playersinnotifyradius )
        {
            player = self.guidtoplayer[ guid ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team == successteam )
            {
                successplayers[ successplayers.size ] = player;
                continue;
            }
            
            otherplayers[ otherplayers.size ] = player;
        }
        
        thread rewardicon( rewardobject, "icon_waypoint_unlocked", successplayers );
        thread rewardicon( rewardobject, "icon_waypoint_locked", otherplayers );
        rewardobjectlock( rewardobject, successplayers, otherplayers );
        return;
    }
    
    showtoplayers = [];
    
    foreach ( guid, lasttime in self.playersinnotifyradius )
    {
        player = self.guidtoplayer[ guid ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        showtoplayers[ showtoplayers.size ] = player;
    }
    
    thread rewardicon( rewardobject, "icon_waypoint_unlocked", showtoplayers );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x67177386, Offset: 0x2771
// Size: 0xad
function targetstart_reward_prespawn( rewardstruct )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    rewardobject = rewardspawn( rewardstruct );
    br_ai_encounters_util::disablescriptableplayeruseall( rewardobject );
    navobstacleid = createnavobstaclebybounds( rewardobject.origin, ( 30, 15, 10 ), rewardobject.angles );
    self waittill( #"hash_40e543a1950bc4ec", success );
    destroynavobstacle( navobstacleid );
    
    if ( isdefined( rewardobject ) )
    {
        if ( success )
        {
            br_ai_encounters_util::enablescriptableplayeruseall( rewardobject );
            rewardicon( rewardobject, "icon_waypoint_unlocked" );
            return;
        }
        
        rewardobject freescriptable();
    }
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0xd2022030, Offset: 0x2826
// Size: 0xd9
function rewardspawn( rewardstruct, modifier )
{
    rewardtype = rewardstruct.script_parameters;
    
    if ( !isdefined( rewardtype ) )
    {
        rewardtype = "brloot_killstreak_clusterstrike";
    }
    
    rewardobject = undefined;
    
    switch ( rewardtype )
    {
        case #"hash_6a0ecbbfe8b1c8a5":
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( rewardstruct.origin + ( 0, 0, 0.1 ), rewardstruct.angles );
            rewardobject = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( rewardtype, undefined, spawnoptions );
            break;
        default:
            assertmsg( "<dev string:x2d6>" + rewardtype + "<dev string:xb4>" );
            break;
    }
    
    if ( isdefined( rewardobject ) )
    {
        thread rewardobjectusewatch( rewardobject );
        thread rewardobjectcleanup( rewardobject );
    }
    
    return rewardobject;
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0x4aa0cb48, Offset: 0x2908
// Size: 0x118
function rewardobjectlock( rewardobject, unlockedplayers, lockedplayers )
{
    rewardobjectsetusable( rewardobject, unlockedplayers );
    lock = spawn( "script_model", rewardobject.origin + ( 0, 0, 30 ) );
    lock setmodel( "tag_origin" );
    lock makeusable();
    lock sethintstring( "MP/DOOR_USE_LOCK" );
    lock setuseholdduration( "duration_long" );
    lock setusefov( 15 );
    lock setcursorhint( "HINT_BUTTON" );
    
    foreach ( player in unlockedplayers )
    {
        lock disableplayeruse( player );
    }
    
    thread rewardobjectcleanup( lock );
    thread rewardobjectlockthink( lock, rewardobject );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x7a56ff74, Offset: 0x2a28
// Size: 0x61
function rewardobjectlockthink( lock, rewardobject )
{
    self endon( #"reward_cleanup" );
    lock waittill( #"trigger", player );
    part = rewardobject.scriptablename;
    br_pickups::lootused( rewardobject, part, "visible", player );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xf2c4127c, Offset: 0x2a91
// Size: 0x2e
function rewardobjectusewatch( rewardobject )
{
    self endon( #"reward_cleanup" );
    
    while ( isdefined( rewardobject ) )
    {
        waitframe();
    }
    
    self notify( #"reward_cleanup" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x88f8bdf5, Offset: 0x2ac7
// Size: 0x39
function rewardobjectcleanup( rewardobject )
{
    self waittill( #"reward_cleanup" );
    
    if ( isdefined( rewardobject ) )
    {
        if ( rewardobject isscriptable() )
        {
            rewardobject freescriptable();
            return;
        }
        
        rewardobject delete();
    }
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0xc8b7a4b7, Offset: 0x2b08
// Size: 0x8f
function rewardobjectsetusable( rewardobject, var_33ca2b7d5466b35c )
{
    br_ai_encounters_util::disablescriptableplayeruseall( rewardobject );
    
    foreach ( player in var_33ca2b7d5466b35c )
    {
        rewardobject enablescriptableplayeruse( player );
    }
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0xd57307b8, Offset: 0x2b9f
// Size: 0xb9
function rewardicon( rewardobject, iconshader, showtoplayers )
{
    id = createrewardicon( rewardobject, iconshader );
    
    if ( id < 0 )
    {
        return;
    }
    
    if ( isdefined( showtoplayers ) )
    {
        foreach ( player in showtoplayers )
        {
            objective_addclienttomask( id, player );
        }
    }
    
    thread rewardiconcleanup( id );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x16c2f31d, Offset: 0x2c60
// Size: 0x92
function createrewardicon( rewardobject, iconshader )
{
    id = objidpoolmanager::requestobjectiveid();
    
    if ( id >= 0 )
    {
        objidpoolmanager::objective_add_objective( id, "current", rewardobject.origin + ( 0, 0, 50 ), iconshader, "icon_regular" );
        objective_setshowoncompass( id, 1 );
        objective_setplayintro( id, !self.norewardiconintro );
        objective_setlabel( id, "BR_AI_ENCOUNTERS/OBJ_LABEL_REWARD" );
        objective_showtoplayersinmask( id );
        objective_removeallfrommask( id );
    }
    
    return id;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xa8ff0dda, Offset: 0x2cfb
// Size: 0x22
function rewardiconcleanup( id )
{
    self waittill( #"reward_cleanup" );
    objidpoolmanager::returnobjectiveid( id );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xff59a58e, Offset: 0x2d25
// Size: 0xcf
function icon_update_visibility( objid )
{
    self endon( #"hash_40e543a1950bc4ec" );
    objective_showtoplayersinmask( objid );
    
    while ( true )
    {
        objective_removeallfrommask( objid );
        
        foreach ( guid, lasttime in self.playersinnotifyradius )
        {
            player = self.guidtoplayer[ guid ];
            
            if ( isdefined( player ) )
            {
                objective_addclienttomask( objid, player );
            }
        }
        
        self waittill( #"hash_5b513e64bebae8fa" );
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x4fc35303, Offset: 0x2dfc
// Size: 0x1ad
function spawn_agent( infostruct )
{
    assert( self.usesai, "<dev string:x2ec>" );
    agent = mp_agent::spawnnewagent( infostruct.aitype, infostruct.team, infostruct.origin, infostruct.angles );
    
    if ( isdefined( agent ) )
    {
        agent.recentkillcount = 0;
        agent.recentdefendcount = 0;
        agent.kills = 0;
        agent.deaths = 0;
        agent.pers[ "cur_kill_streak" ] = 0;
        agent.pers[ "cur_death_streak" ] = 0;
        agent.pers[ "cur_kill_streak_for_nuke" ] = 0;
        agent weapon_utility::function_b6883e5e149bdb1f();
        agent.killedplayers = [];
        agent.guid = agent player::getuniqueid();
        agent.script_noteworthy = infostruct.script_noteworthy;
        agent.scripted_long_deaths = 0;
        agent.agentdamagefeedback = 1;
        self.agents[ self.agents.size ] = agent;
        thread watch_agent_death( agent );
    }
    else
    {
        /#
            print_agent_array();
        #/
        
        assertmsg( "<dev string:x321>" + br_ai_encounters_util::vartostring( infostruct.aitype ) + "<dev string:x340>" + br_ai_encounters_util::vartostring( infostruct.team ) + "<dev string:x348>" + br_ai_encounters_util::vartostring( infostruct.origin ) );
    }
    
    return agent;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xd8585cc, Offset: 0x2fb2
// Size: 0x48
function watch_agent_death( agent )
{
    agent waittill( #"death" );
    self.agents = arrayremove( self.agents, agent );
    self.agentskilled++;
    self notify( #"agent_killed" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x33e2b795, Offset: 0x3002
// Size: 0xbf
function targetstart_spawntrigger( trigger )
{
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( isagent( player ) )
        {
            continue;
        }
        
        break;
    }
    
    targets = trigger br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        targetstart_spawner( target );
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x71e62d76, Offset: 0x30c9
// Size: 0x2b
function root_ecounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    thread root_inittargets();
    thread root_monitorplayers();
    thread root_failconditions();
    
    /#
        thread function_e57d306e2fad7665();
    #/
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x7d100dbe, Offset: 0x30fc
// Size: 0x17
function root_getspawneraitype( spawner )
{
    return spawner.name;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x8a8ddff2, Offset: 0x311c
// Size: 0x13a
function root_inittargets()
{
    self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_GENERIC";
    waittillframeend();
    targets = br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        type = target.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_da19fcc268ff194f":
                thread targetstart_spawner( target );
                break;
            case #"hash_34ff250b650cb23":
                thread targetstart_spawntrigger( target );
                break;
            case #"hash_502e6f4e764c2750":
                thread targetstart_icon( target );
                break;
            case #"hash_25cf64aa9fe8e63a":
                thread targetstart_reward( target );
                break;
            case #"hash_a5b2891a35ef9337":
                thread targetstart_reward_prespawn( target );
                break;
            default:
                break;
        }
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x5747500f, Offset: 0x325e
// Size: 0x304
function root_monitorplayers()
{
    self endon( #"hash_40e543a1950bc4ec" );
    self.notifyradius = 7500;
    self.engagedradius = 2000;
    self.playersinnotifyradius = [];
    self.playersinengagedradius = [];
    self.guidtoplayer = [];
    waittillframeend();
    assert( self.notifyradius > self.engagedradius );
    notifyradiussqr = self.notifyradius * self.notifyradius;
    engagedradiussqr = self.engagedradius * self.engagedradius;
    var_77aa5cf69e60494d = 20;
    
    while ( true )
    {
        currenttime = gettime();
        updatecount = 0;
        notifylistchanged = 0;
        engagedlistchanged = 0;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            self.guidtoplayer[ player.guid ] = player;
            
            if ( !isalive( player ) )
            {
                if ( isdefined( self.playersinnotifyradius[ player.guid ] ) )
                {
                    notifylistchanged = 1;
                    self.playersinnotifyradius[ player.guid ] = undefined;
                }
                
                if ( isdefined( self.playersinengagedradius[ player.guid ] ) )
                {
                    engagedlistchanged = 1;
                    self.playersinengagedradius[ player.guid ] = undefined;
                }
                
                continue;
            }
            
            dist2dsqr = distance2dsquared( player.origin, self.origin );
            
            if ( dist2dsqr <= notifyradiussqr )
            {
                if ( !isdefined( self.playersinnotifyradius[ player.guid ] ) )
                {
                    notifylistchanged = 1;
                }
                
                self.playersinnotifyradius[ player.guid ] = currenttime;
            }
            else
            {
                lasttime = self.playersinnotifyradius[ player.guid ];
                
                if ( currenttime - lasttime > 2000 )
                {
                    notifylistchanged = 1;
                    self.playersinnotifyradius[ player.guid ] = undefined;
                }
            }
            
            if ( dist2dsqr <= engagedradiussqr )
            {
                if ( !isdefined( self.playersinengagedradius[ player.guid ] ) )
                {
                    engagedlistchanged = 1;
                }
                
                self.playersinengagedradius[ player.guid ] = currenttime;
            }
            else
            {
                lasttime = self.playersinengagedradius[ player.guid ];
                
                if ( currenttime - lasttime > 2000 )
                {
                    engagedlistchanged = 1;
                    self.playersinengagedradius[ player.guid ] = undefined;
                }
            }
            
            updatecount++;
            
            if ( updatecount >= var_77aa5cf69e60494d )
            {
                wait 0.05;
                updatecount = 0;
            }
        }
        
        if ( notifylistchanged )
        {
            self notify( #"hash_5b513e64bebae8fa" );
        }
        
        if ( engagedlistchanged )
        {
            self notify( #"hash_8de1fe667bff7c68" );
        }
        
        wait 0.05;
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xc7181c79, Offset: 0x356a
// Size: 0x25
function root_failconditions()
{
    self.failconditionengagedradiustime = 90;
    waittillframeend();
    thread failcondition_noplayersinengagedradius( self.failconditionengagedradiustime );
    thread failcondition_outsidedangercircle();
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xbb58fbd7, Offset: 0x3597
// Size: 0x2f
function rootai_ecounterstart()
{
    self.usesai = 1;
    self.func_getspawneraitype = &root_getspawneraitype;
    self.agentskilled = 0;
    self.agents = [];
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xf76f2900, Offset: 0x35ce
// Size: 0x389
function bank_ecounterstart()
{
    self endon( #"hash_40e543a1950bc4ec" );
    
    /#
        function_a61e8bcf61450006();
    #/
    
    self.func_getspawneraitype = &bank_getspawneraitype;
    self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_BANK";
    thread alarm_sound_on();
    thread alarm_sound_off_encounter_end();
    thread vault_door_think();
    vol_01 = getent( "bank_vol_01", #targetname );
    vol_01_upper = getent( "bank_vol_01_upper", #targetname );
    level.wave1_enemies = [];
    var_8a4c691eb8acbf26 = utility::getstructarray( "enemy_wave_01", "targetname" );
    
    foreach ( struct in var_8a4c691eb8acbf26 )
    {
        newguy = targetstart_spawner( struct );
        
        if ( newguy.script_noteworthy == "wave01_upper" )
        {
            newguy setgoalvolumeauto( vol_01_upper );
            newguy.goalheight = 256;
        }
        else if ( newguy.script_noteworthy == "wave01_lower" )
        {
            newguy setgoalvolumeauto( vol_01 );
        }
        
        level.wave1_enemies[ level.wave1_enemies.size ] = newguy;
    }
    
    overrun = getent( "wave_01_overrun_trig", #targetname );
    waittill_trigger_or_dead( overrun, level.wave1_enemies, level.wave1_enemies.size - 3 );
    level notify( #"hash_2fd9ea11f51fdb2" );
    vol_02 = getent( "bank_vol_02", #targetname );
    wave2_enemies = [];
    wave2_guys = utility::getstructarray( "enemy_wave_02", "targetname" );
    
    foreach ( guy in wave2_guys )
    {
        newguy = targetstart_spawner( guy );
        newguy setgoalvolumeauto( vol_02 );
        wave2_enemies[ wave2_enemies.size ] = newguy;
    }
    
    foreach ( enemy in level.wave1_enemies )
    {
        if ( isalive( enemy ) )
        {
            enemy setgoalvolumeauto( vol_02 );
            wave2_enemies[ wave2_enemies.size ] = enemy;
        }
    }
    
    br_ai_encounters_util::waittill_dead( wave2_enemies, wave2_enemies.size );
    wait 0.5;
    self notify( #"hash_2433dfb6536fdb4e" );
    var_a5f24ec0f05713ef = [];
    jug = utility::getstruct( "enemy_wave_03_boss", "targetname" );
    jug_boss = targetstart_spawner( jug );
    jug_boss thread jug_behavior();
    var_a5f24ec0f05713ef[ var_a5f24ec0f05713ef.size ] = jug_boss;
    br_ai_encounters_util::waittill_dead( var_a5f24ec0f05713ef, var_a5f24ec0f05713ef.size );
    encounter_end( 1 );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x2d97d540, Offset: 0x395f
// Size: 0x1b
function vault_door_open_wait()
{
    self endon( #"hash_40e543a1950bc4ec" );
    self waittill( #"hash_2433dfb6536fdb4e" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x7ce3bfe8, Offset: 0x3982
// Size: 0x7d
function vault_door_init( door )
{
    if ( door.init )
    {
        door.angles = door.start_angles;
        return;
    }
    
    door_clip = getent( "vault_door_clip", #targetname );
    door_clip linkto( door );
    door.start_angles = door.angles;
    door.init = 1;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xc964381b, Offset: 0x3a07
// Size: 0x4f
function vault_door_think()
{
    door = getent( "vault_door", #targetname );
    vault_door_init( door );
    vault_door_open_wait();
    door thread vault_door_sound();
    door rotateby( ( 0, 180, 0 ), 5 );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x3b34dedb, Offset: 0x3a5e
// Size: 0x67
function jug_behavior()
{
    players = sortbydistance( level.players, self.origin );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isalive( player ) )
        {
            self getenemyinfo( player );
            self setgoalentity( player );
            break;
        }
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xdc340470, Offset: 0x3acd
// Size: 0x93
function alarm_sound_on()
{
    alarm_pos = getentarray( "bank_alarm_pos", #targetname );
    
    foreach ( pos in alarm_pos )
    {
        pos playloopsound( "emt_alarm_bank_bell_lp" );
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x61821bef, Offset: 0x3b68
// Size: 0x93
function alarm_sound_off()
{
    alarm_pos = getentarray( "bank_alarm_pos", #targetname );
    
    foreach ( pos in alarm_pos )
    {
        pos stoploopsound( "emt_alarm_bank_bell_lp" );
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xe5260ea2, Offset: 0x3c03
// Size: 0xb4
function vault_door_sound()
{
    distsqr = 4000000;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            if ( distancesquared( player.origin, self.origin ) <= distsqr )
            {
                player playsound( "cp_bank_vault_open" );
            }
        }
    }
}

// Namespace br_ai_encounters
// Params 4
// Checksum 0xccb742bc, Offset: 0x3cbf
// Size: 0x69
function waittill_trigger_or_dead( trigger, guys, num, timeoutlength )
{
    struct = spawnstruct();
    struct endon( #"done" );
    struct childthread _waittill_trigger( trigger );
    struct childthread _waittill_dead_notify_done( guys, num, timeoutlength );
    struct waittill( #"done" );
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0xe138f927, Offset: 0x3d30
// Size: 0x35
function _waittill_dead_notify_done( guys, num, timeoutlength )
{
    br_ai_encounters_util::waittill_dead( guys, num, timeoutlength );
    self notify( #"done" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x755b70db, Offset: 0x3d6d
// Size: 0x4a
function _waittill_trigger( trigger )
{
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        break;
    }
    
    self notify( #"done" );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x77d93d20, Offset: 0x3dbf
// Size: 0x16
function alarm_sound_off_encounter_end()
{
    self waittill( #"hash_40e543a1950bc4ec" );
    alarm_sound_off();
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x8119f2b7, Offset: 0x3ddd
// Size: 0x54
function bank_getspawneraitype( spawner )
{
    if ( isdefined( spawner.script_noteworthy ) )
    {
        switch ( spawner.script_noteworthy )
        {
            case #"hash_9196025f8ae8e51e":
                return "actor_enemy_br_juggernaut";
            default:
                break;
        }
    }
    
    return "actor_enemy_br_base";
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x98dcd69, Offset: 0x3e3a
// Size: 0x25c
function airport_ecounterstart()
{
    cargo_spawn = getent( "ai_encounter_crate", #targetname );
    cargo_spawn movez( 256, 0.05 );
    wait 0.5;
    createnavobstaclebyent( cargo_spawn );
    trigger = getent( "kickoff_airport_encounter", #targetname );
    trigger waittill( #"trigger", player );
    grenadeweapon = "smoke_grenade_mp";
    grenade_1 = magicgrenademanual( grenadeweapon, utility::getstruct( "airport_smoke_toss_pos", "targetname" ).origin, anglestoforward( utility::getstruct( "airport_smoke_toss_pos", "targetname" ).angles ) * 400, 1 );
    wait 0.1;
    grenade_2 = magicgrenademanual( grenadeweapon, utility::getstruct( "airport_smoke_toss_pos_02", "targetname" ).origin, anglestoforward( utility::getstruct( "airport_smoke_toss_pos_02", "targetname" ).angles ) * 400, 1.3 );
    grenade_3 = magicgrenademanual( grenadeweapon, utility::getstruct( "airport_smoke_toss_pos_03", "targetname" ).origin, anglestoforward( utility::getstruct( "airport_smoke_toss_pos_03", "targetname" ).angles ) * 450, 2 );
    vol_01 = getent( "airport_vol_01", #targetname );
    wait 2;
    var_630a6f0c6be3065d = [];
    var_8a4c691eb8acbf26 = utility::getstructarray( "airport_enemy_wave_01", "targetname" );
    
    foreach ( struct in var_8a4c691eb8acbf26 )
    {
        newguy = targetstart_spawner( struct );
        newguy setgoalvolumeauto( vol_01 );
        newguy thread airport_enemy_setup();
        var_630a6f0c6be3065d[ var_630a6f0c6be3065d.size ] = newguy;
    }
    
    br_ai_encounters_util::waittill_dead( var_630a6f0c6be3065d, var_630a6f0c6be3065d.size );
    encounter_end( 1 );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x647eafa5, Offset: 0x409e
// Size: 0x2e
function airport_enemy_setup()
{
    self.ignore_all = 1;
    wait randomfloatrange( 1, 2 );
    self.ignore_all = 0;
    self.accuracy = 0.01;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xb5482957, Offset: 0x40d4
// Size: 0x28b
function truck_encounterstart()
{
    self endon( #"hash_40e543a1950bc4ec" );
    self.func_getspawneraitype = &truck_getspawneraitype;
    self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_TRUCK";
    thread failcondition_noplayersinengagedradius( 90 );
    start_trigger = undefined;
    roll_door = undefined;
    var_51e7ff8a700e5109 = [];
    jump_down_nodes = [];
    targets = br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        type = target.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_4bc6c12fcdff02dc":
                start_trigger = target;
                break;
            case #"hash_954e5090b3c7b185":
                var_51e7ff8a700e5109[ var_51e7ff8a700e5109.size ] = target;
                break;
            case #"hash_48f45fbed0b294f3":
                roll_door = target;
                thread truck_roll_door_init( roll_door );
                break;
            case #"hash_3a455fee27335f03":
                jump_down_nodes[ jump_down_nodes.size ] = target;
                break;
            default:
                break;
        }
    }
    
    /#
        thread function_14cb60bfd730af07( roll_door );
    #/
    
    /#
        self.activedebuginfo[ "<dev string:x352>" ] = "<dev string:x373>";
    #/
    
    while ( true )
    {
        start_trigger waittill( #"trigger", player );
        
        if ( isalive( player ) && isplayer( player ) )
        {
            break;
        }
    }
    
    /#
        self.activedebuginfo[ "<dev string:x352>" ] = undefined;
    #/
    
    destroynavobstacle( roll_door getentitynumber() );
    truck_roll_door_open( roll_door );
    var_2795b37062aa5454 = [];
    
    foreach ( guy in var_51e7ff8a700e5109 )
    {
        newguy = targetstart_spawner( guy );
        var_2795b37062aa5454[ var_2795b37062aa5454.size ] = newguy;
    }
    
    br_ai_encounters_util::waittill_dead( var_2795b37062aa5454, var_2795b37062aa5454.size );
    encounter_end( 1 );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x2d705daa, Offset: 0x4367
// Size: 0xf1
function truck_roll_door_init( door )
{
    self endon( #"hash_40e543a1950bc4ec" );
    
    if ( !door.init )
    {
        door.angle_ref = utility::getstruct( door.target, "targetname" );
        
        if ( !isdefined( door.angle_ref.angles ) )
        {
            door.angle_ref.angles = ( 0, 0, 0 );
        }
        
        door.start_origin = door.origin;
        door.start_angles = door.angles;
        door.init = 1;
        return;
    }
    
    door.origin = door.start_origin;
    door.angles = door.start_angles;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xd01f0db, Offset: 0x4460
// Size: 0x2c
function truck_roll_door_open( roll_door )
{
    roll_door rotatepitch( -90, 1 );
    truck_roll_door_sound( roll_door );
    self notify( #"hash_706c3d9b61ac02f4" );
}

/#

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0x7d19056b, Offset: 0x4494
    // Size: 0x42, Type: dev
    function function_14cb60bfd730af07( roll_door )
    {
        self endon( #"hash_706c3d9b61ac02f4" );
        self waittill( #"hash_40e543a1950bc4ec", success );
        
        if ( success )
        {
            truck_roll_door_open( roll_door );
        }
    }

#/

// Namespace br_ai_encounters
// Params 1
// Checksum 0xcbababa2, Offset: 0x44de
// Size: 0xc0
function truck_roll_door_sound( door )
{
    distsqr = 1000000;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            if ( distancesquared( player.origin, door.origin ) <= distsqr )
            {
                player playsound( "cp_bank_gate_fall" );
            }
        }
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x1dc995a6, Offset: 0x45a6
// Size: 0x11
function truck_getspawneraitype( spawner )
{
    return "actor_enemy_br_base";
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xfe468a45, Offset: 0x45c0
// Size: 0x270
function crateguard_encounterstart()
{
    self endon( #"hash_40e543a1950bc4ec" );
    self.func_getspawneraitype = &crateguard_getspawneraitype;
    self.iconlabel = "BR_AI_ENCOUNTERS/OBJ_LABEL_CRATE_GUARD";
    thread failcondition_noplayersinengagedradius( 90 );
    start_trigger = undefined;
    guard_boss_spawner = undefined;
    guard_spawners = [];
    targets = br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        type = target.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_7df245010bdec44e":
                guard_spawners[ guard_spawners.size ] = target;
                break;
            case #"hash_96595d749aadbe62":
                assert( !isdefined( guard_boss_spawner ) );
                guard_boss_spawner = target;
                break;
            case #"hash_4bc6c12fcdff02dc":
                start_trigger = target;
                break;
            default:
                break;
        }
    }
    
    /#
        self.activedebuginfo[ "<dev string:x38d>" ] = "<dev string:x3b3>";
    #/
    
    while ( true )
    {
        start_trigger waittill( #"trigger", player );
        
        if ( isalive( player ) && isplayer( player ) )
        {
            break;
        }
    }
    
    /#
        self.activedebuginfo[ "<dev string:x38d>" ] = undefined;
    #/
    
    crate_guard_enemies = [];
    
    foreach ( struct in guard_spawners )
    {
        newguy = targetstart_spawner( struct );
        crate_guard_enemies[ crate_guard_enemies.size ] = newguy;
    }
    
    boss = targetstart_spawner( guard_boss_spawner );
    crate_guard_enemies[ crate_guard_enemies.size ] = boss;
    childthread crateguard_bosssetup( boss, crate_guard_enemies );
    br_ai_encounters_util::waittill_dead( crate_guard_enemies, crate_guard_enemies.size );
    encounter_end( 1 );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x6143b984, Offset: 0x4838
// Size: 0x63
function crateguard_bosssetup( boss, guards )
{
    boss.ignoreall = 1;
    everyone = guards;
    everyone[ everyone.size ] = boss;
    utility::waittill_any_ents_array( everyone, "death", "damage", "enemy" );
    
    if ( isdefined( boss ) )
    {
        boss.ignoreall = 0;
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x7f3dfc01, Offset: 0x48a3
// Size: 0x2b
function crateguard_getspawneraitype( spawner )
{
    if ( spawner.script_noteworthy == "guard_boss" )
    {
        return "actor_enemy_br_boss";
    }
    
    return "actor_enemy_br_base";
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x1f742cf6, Offset: 0x48d7
// Size: 0x49
function smoking()
{
    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "smoking_death";
    thread smoking_idle( "smoking_idle" );
    thread smoking_react( "smoking_react" );
    thread smoking_death( "smoking_death" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xe202ced5, Offset: 0x4928
// Size: 0x59
function smoking_idle( animalias )
{
    self endon( #"death" );
    self endon( #"damage" );
    thread ai_notetrack_loop( "smoking" );
    
    while ( true )
    {
        smoking_idle_start( "smoking_idle_start" );
        utility::animscripted_single( animalias );
        smoking_idle_end( "smoking_idle_end" );
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xb77cee4, Offset: 0x4989
// Size: 0x2d
function smoking_idle_start( animalias )
{
    self endon( #"death" );
    self endon( #"damage" );
    utility::animscripted_single( animalias );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xfe2bc09e, Offset: 0x49be
// Size: 0x2d
function smoking_idle_end( animalias )
{
    self endon( #"death" );
    self endon( #"damage" );
    utility::animscripted_single( animalias );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xde31d415, Offset: 0x49f3
// Size: 0xa4
function smoking_react( react_alias )
{
    self endon( #"death" );
    self waittill( #"damage" );
    ai_smoking_cleanup();
    self.deathstate = undefined;
    self.deathalias = undefined;
    
    if ( isdefined( self.idle_prop ) )
    {
        self.idle_prop unlink();
        self.idle_prop physicslaunchserver( self.idle_prop.origin, ( 0, 0, -10 ) );
        self.idle_prop = undefined;
    }
    
    utility::animscripted_single( react_alias );
    reset_guy( self );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x9043f18b, Offset: 0x4a9f
// Size: 0x2c
function smoking_death( sanim )
{
    self endon( #"damage" );
    self waittill( #"death" );
    ai_smoking_cleanup();
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x3212bfde, Offset: 0x4ad3
// Size: 0x116
function ai_notehandler_smoking( note )
{
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            playfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            break;
        case #"hash_d582c3286e5c390f":
            playfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
            stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            playfx( level.g_effect[ "lighter_glow" ], self gettagorigin( "tag_accessory_right" ) );
            thread ai_smoking_blowsmoke();
            break;
        case #"hash_682ec8b49fe7aa12":
            stopfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
            stopfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
            playfx( level.g_effect[ "cigarette_lit_toss" ], self gettagorigin( "tag_accessory_right" ), anglestoforward( self gettagangles( "tag_accessory_right" ) ) );
            break;
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x59d950b2, Offset: 0x4bf1
// Size: 0x92
function ai_smoking_blowsmoke()
{
    self endon( #"smoking_end" );
    self endon( #"death" );
    self notify( #"hash_fb34440e7db2425a" );
    self endon( #"hash_fb34440e7db2425a" );
    self endon( #"damage" );
    
    while ( true )
    {
        playfx( level.g_effect[ "cigarette_smoke" ], self geteye() - ( 0, 0, 2 ), anglestoforward( self gettagangles( "tag_eye" ) ) );
        waittime = randomintrange( 5, 8 );
        wait waittime;
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xddecfd8f, Offset: 0x4c8b
// Size: 0x65
function ai_smoking_cleanup()
{
    self notify( #"smoking_end" );
    self endon( #"death" );
    
    if ( utility::hastag( self.model, "tag_accessory_right" ) )
    {
        killfxontag( level.g_effect[ "cigarette_lit" ], self, "tag_accessory_right" );
        killfxontag( level.g_effect[ "cigarette_unlit" ], self, "tag_accessory_right" );
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x84fa6e05, Offset: 0x4cf8
// Size: 0x70
function standing_cellphone( var_9b5c33ff95ab0bd = 0 )
{
    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "stand_cellphone_death";
    thread ai_notetrack_loop( "standing_cellphone" );
    standing_cellphone_anim( "stand_cellphone_intro" );
    
    if ( var_9b5c33ff95ab0bd > 0 )
    {
        standing_cellphone_loop( "stand_cellphone_loop", var_9b5c33ff95ab0bd );
    }
    
    standing_cellphone_anim( "stand_cellphone_exit" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x8f993a8c, Offset: 0x4d70
// Size: 0x2d
function standing_cellphone_anim( animalias )
{
    self endon( #"death" );
    self endon( #"damage" );
    utility::animscripted_single( animalias );
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0x6d519cc8, Offset: 0x4da5
// Size: 0x37
function standing_cellphone_loop( animalias, loops )
{
    self endon( #"death" );
    self endon( #"damage" );
    utility::animscripted_loop_n_times( animalias, loops );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xa9092d5b, Offset: 0x4de4
// Size: 0x8d
function ai_notehandler_cellphone( note )
{
    self endon( #"death" );
    self endon( #"damage" );
    
    switch ( note )
    {
        case #"hash_2d1403e602f082a4":
            self.idle_prop = animation::anim_link_tag_model( "equipment_personal_smartphone_01", "tag_accessory_right" );
            wait 2;
            break;
        case #"hash_682ec8b49fe7aa12":
            if ( isdefined( self.idle_prop ) )
            {
                self.idle_prop delete();
                self.idle_prop = undefined;
            }
            
            break;
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xaa464a78, Offset: 0x4e79
// Size: 0xd
function setup_anim_guy()
{
    self.playing_skit = 1;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x4916252c, Offset: 0x4e8e
// Size: 0x96
function reset_guy( guy )
{
    guy allowedstances( "prone", "stand", "crouch" );
    guy utility::animscripted_clear();
    guy setlookatentity();
    guy.headlook_enabled = 1;
    guy.disableautolookat = 0;
    guy.deathstate = undefined;
    guy.deathalias = undefined;
    guy.ignoreall = 0;
    guy.playing_skit = undefined;
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xaf933052, Offset: 0x4f2c
// Size: 0x125
function ai_notetrack_loop( skit )
{
    self endon( #"death" );
    self notify( #"hash_fb34440e7db2425a" );
    self endon( #"hash_fb34440e7db2425a" );
    self endon( #"damage" );
    
    while ( true )
    {
        self waittill( #"animscripted", notes );
        
        if ( !isdefined( notes ) )
        {
            notes = [ "undefined" ];
        }
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        assert( isdefined( self.fnasm_handlenotetrack ) );
        
        foreach ( note in notes )
        {
            if ( skit == "smoking" )
            {
                ai_notehandler_smoking( note );
                continue;
            }
            
            if ( skit == "standing_cellphone" )
            {
                ai_notehandler_cellphone( note );
            }
        }
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x8b568f7e, Offset: 0x5059
// Size: 0xc
function test_ecounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x5f44ddb3, Offset: 0x506d
// Size: 0xc
function rootnonai_ecounterstart()
{
    self.usesai = 0;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x90c84169, Offset: 0x5081
// Size: 0x23c
function dom_encounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    self.norewardiconintro = 1;
    self.engagedradius = 1500;
    domencounter_icons();
    trigger = undefined;
    targets = br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        type = target.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_1b79c5d9e0f9886a":
                assert( !isdefined( trigger ) );
                radius = 315;
                height = 120;
                trigger = spawn( "trigger_radius", target.origin, 0, int( radius ), int( height ) );
                trigger.script_label = "_a";
                break;
            default:
                break;
        }
    }
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    level.setdomscriptablepartstatefunc = &domencounter_setdomscriptablepartstate;
    domflag = obj_dom::setupobjective( trigger );
    domflag.noscriptable = undefined;
    domflag.vfxnamemod = "_300";
    domflag.onuse = &domencounter_onuse;
    domflag.onuseupdate = &domencounter_onuseupdate;
    domflag.onenduse = &domencounter_onenduse;
    domflag gameobjects::setvisibleteam( "any" );
    domflag obj_dom::domflag_setneutral();
    level.flagcapturetime = getdvarint( @"hash_ab50f58bb9979459", 30 );
    domflag gameobjects::setusetime( level.flagcapturetime );
    domflag.encounterlocation = self;
    
    /#
        self.debugdomflag = domflag;
    #/
    
    thread encounterdeletedomgameobjectonend( domflag );
    thread icon_update_visibility( domflag.objidnum );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0xbfd025f, Offset: 0x52c5
// Size: 0x11d
function encounterdeletedomgameobjectonend( domflag )
{
    domflag endon( #"deleted" );
    self waittill( #"hash_40e543a1950bc4ec" );
    
    foreach ( vis in domflag.visuals )
    {
        vis delete();
    }
    
    if ( isdefined( domflag.flagmodel ) )
    {
        domflag.flagmodel delete();
    }
    
    if ( isdefined( domflag.scriptable ) )
    {
        domflag.scriptable delete();
    }
    
    if ( isdefined( domflag.trigger ) )
    {
        domflag.trigger delete();
        domflag.trigger = undefined;
    }
    
    domflag thread gameobjectreleaseid_delayed();
    domflag notify( #"deleted" );
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x51693b4b, Offset: 0x53ea
// Size: 0xf
function gameobjectreleaseid_delayed()
{
    wait 0.1;
    gameobjects::releaseid();
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x7e9e2de5, Offset: 0x5401
// Size: 0x17b
function domencounter_icons()
{
    level.iconneutral = "waypoint_captureneutral_br";
    level.iconcapture = "waypoint_capture_br";
    level.icondefend = "waypoint_defend_br";
    level.icondefending = "waypoint_defending_br";
    level.iconcontested = "waypoint_contested_br";
    level.icontaking = "waypoint_taking_br";
    level.iconlosing = "waypoint_losing_br";
    _setdomencountericoninfo( "icon_waypoint_dom_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1 );
    _setdomencountericoninfo( "waypoint_capture_br", "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1 );
    _setdomencountericoninfo( "waypoint_captureneutral_br", "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", 0 );
    _setdomencountericoninfo( "waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1 );
    _setdomencountericoninfo( "waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
    _setdomencountericoninfo( "icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
}

// Namespace br_ai_encounters
// Params 4
// Checksum 0xb26be2ac, Offset: 0x5584
// Size: 0x71
function _setdomencountericoninfo( name, colors, string, pulses )
{
    level.waypointcolors[ name ] = colors;
    level.waypointbgtype[ name ] = 0;
    level.waypointstring[ name ] = string;
    level.waypointshader[ name ] = "icon_waypoint_dom_a";
    level.waypointpulses[ name ] = pulses;
}

// Namespace br_ai_encounters
// Params 4
// Checksum 0x3ccba3e0, Offset: 0x55fd
// Size: 0x51
function domencounter_onuseupdate( team, progress, change, capplayer )
{
    if ( progress > 0.05 && change && !self.didstatusnotify )
    {
        self.didstatusnotify = 1;
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x5c196181, Offset: 0x5656
// Size: 0x29
function domencounter_onuse( credit_player )
{
    self.encounterlocation encounter_end( 1, credit_player.team );
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0x59898d86, Offset: 0x5687
// Size: 0x29
function domencounter_onenduse( team, player, success )
{
    obj_dom::dompoint_onuseend( team, player, success );
}

// Namespace br_ai_encounters
// Params 3
// Checksum 0x4c09d8e8, Offset: 0x56b8
// Size: 0xa1
function domencounter_setdomscriptablepartstate( part, state, statemod )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
        case #"hash_3699ac6c262c25ea":
        case #"hash_86bf1a776a7c4cbe":
            return 0;
        default:
            state = "using";
            
            if ( isdefined( statemod ) )
            {
                state += statemod;
            }
            
            self.scriptable setscriptablepartstate( part, state );
            
            if ( part == "pulse" )
            {
                self.scriptable setscriptablepartstate( "flag", state );
            }
            
            return 1;
    }
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x1c2c6c77, Offset: 0x5761
// Size: 0xc
function bombplant_encounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x3cf1535c, Offset: 0x5775
// Size: 0x104
function extraction_encounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    iprintlnbold( "EXTRACTION START" );
    print( "<dev string:x3cd>" );
    targets = br_ai_encounters_util::get_targets();
    
    foreach ( target in targets )
    {
        type = target.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_98ea57354948cbee":
                extraction_createescort( target );
                break;
            case #"hash_8d43150f19c69bd6":
                targetstart_extractiongoal( target );
                break;
            default:
                break;
        }
    }
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x1f3bf461, Offset: 0x5881
// Size: 0x67
function targetstart_extractiongoal( goalstruct )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    goal = spawn( "script_model", goalstruct.origin + ( 0, 0, 20 ) );
    goal setmodel( "ctf_game_flag_east" );
    self.goal = goal;
    goal.encounter = self;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x64fa06, Offset: 0x58f0
// Size: 0xe1
function extraction_createescort( target )
{
    escort = spawn( "script_model", target.origin + ( 0, 0, 20 ) );
    escort setmodel( "fullbody_usmc_ar" );
    escort scriptmodelplayanim( "sdr_cp_hostage_dropoff_ground_idle_pilot" );
    escort scriptmodelpauseanim( 1 );
    escort makeusable();
    escort setcursorhint( "HINT_NOICON" );
    escort setuseholdduration( "duration_medium" );
    escort sethintdisplayfov( 120 );
    escort setusefov( 120 );
    escort setuserange( 80 );
    escort sethintstring( &"mp/br_use_plunder_cache" );
    escort setasgametypeobjective();
    escort show();
    escort.readytoextract = 0;
    escort thread extraction_escortthink();
    self.escort = escort;
    escort.encounter = self;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0x1a3bf743, Offset: 0x59d9
// Size: 0x69
function extraction_escortthink()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !self.readytoextract )
        {
            player extraction_playerpickupbody( self, player.team );
            continue;
        }
        
        thread extraction_attachfultonballoontoescort( player );
    }
}

// Namespace br_ai_encounters
// Params 2
// Checksum 0xa839d508, Offset: 0x5a4a
// Size: 0xf6
function extraction_playerpickupbody( useent, team )
{
    self endon( #"droppedbody" );
    useent makeunusable();
    holdingbodyhud = hud_util::createfontstring( "default", 1.5 );
    holdingbodyhud hud_util::setpoint( "CENTER", "CENTER", 0, 120 );
    holdingbodyhud.label = &"mp/br_respawn_body";
    self.holdingbodyhud = holdingbodyhud;
    useent scriptmodelplayanim( "sdr_cp_hostage_walk_hostage" );
    useent linkto( self, "j_clavicle_le", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self allowads( 0 );
    self allowcrouch( 0 );
    self allowprone( 0 );
    self allowjump( 0 );
    br_respawn::playersetcarryteammates( 1 );
    
    while ( !self stancebuttonpressed() || !self isonground() )
    {
        waitframe();
    }
    
    extraction_dropbody( useent, self, holdingbodyhud, team );
}

// Namespace br_ai_encounters
// Params 4
// Checksum 0x58d356e8, Offset: 0x5b48
// Size: 0x14e
function extraction_dropbody( useent, playerholding, holdingbodyhud, team )
{
    if ( isdefined( playerholding ) )
    {
        playerholding allowads( 1 );
        playerholding allowcrouch( 1 );
        playerholding allowprone( 1 );
        playerholding allowjump( 1 );
        br_respawn::playersetcarryteammates( 0 );
    }
    
    if ( isdefined( holdingbodyhud ) )
    {
        holdingbodyhud destroy();
    }
    
    if ( useent islinked() )
    {
        useent unlink();
    }
    
    origin = undefined;
    
    if ( isdefined( playerholding ) )
    {
        useent.angles = playerholding.angles;
        origin = playerholding.origin;
        useent.origin = origin + ( 0, 0, 40 );
    }
    else
    {
        origin = useent.origin;
        useent.origin = origin + ( 0, 0, 40 );
    }
    
    useent scriptmodelplayanim( "sdr_cp_hostage_dropoff_ground_idle_pilot" );
    useent scriptmodelpauseanim( 1 );
    useent.origin = origin + ( 0, 0, 1 );
    useent makeusable();
    
    if ( useent extraction_checkescortradius() )
    {
        useent extraction_changeescortusefunction();
    }
    
    useent notify( #"droppedbody" );
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x638f99aa, Offset: 0x5c9e
// Size: 0x51
function extraction_checkescortradius( player )
{
    println( "<dev string:x3de>" );
    
    if ( distance2d( self.origin, self.encounter.goal.origin ) < 100 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xf9f83f24, Offset: 0x5cf7
// Size: 0x38
function extraction_changeescortusefunction()
{
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self setuseholdduration( "duration_long" );
    self sethintstring( &"mp/br_use_plunder_cache" );
    self.readytoextract = 1;
}

// Namespace br_ai_encounters
// Params 1
// Checksum 0x979f5bc7, Offset: 0x5d37
// Size: 0x49
function extraction_attachfultonballoontoescort( player )
{
    print( "<dev string:x3ed>" );
    self.encounter encounter_end( 1 );
    self.encounter.goal delete();
    self delete();
}

// Namespace br_ai_encounters
// Params 0
// Checksum 0xbaf8e81b, Offset: 0x5d88
// Size: 0xee
function destruction_encounterstart()
{
    /#
        function_a61e8bcf61450006();
    #/
    
    scriptables = getscriptablearray( self.target, #targetname );
    destroyobjects = [];
    
    foreach ( scriptable in scriptables )
    {
        type = scriptable.script_noteworthy;
        
        if ( !isdefined( type ) )
        {
            continue;
        }
        
        switch ( type )
        {
            case #"hash_145971eb70575f25":
                destroyobjects[ destroyobjects.size ] = scriptable;
                break;
            default:
                break;
        }
    }
}

/#

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x3c9f1c0a, Offset: 0x5e7e
    // Size: 0x11, Type: dev
    function function_74aa0eb4c6c52725()
    {
        function_841b3c7627f3d30d( "<dev string:x24>" );
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x28bec069, Offset: 0x5e97
    // Size: 0x11, Type: dev
    function function_f146f8d73fc64fba()
    {
        function_841b3c7627f3d30d( "<dev string:x29>" );
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0xdcbcc602, Offset: 0x5eb0
    // Size: 0x11, Type: dev
    function function_a61e8bcf61450006()
    {
        function_841b3c7627f3d30d( "<dev string:x53>" );
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0x79ed03d9, Offset: 0x5ec9
    // Size: 0x53, Type: dev
    function function_841b3c7627f3d30d( type )
    {
        selftype = self.debugtype;
        
        if ( !isdefined( selftype ) )
        {
            selftype = "<dev string:x3fd>";
        }
        
        assert( type == selftype, "<dev string:x409>" + type + "<dev string:x419>" + selftype + "<dev string:x42a>" );
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0x42d7ca4b, Offset: 0x5f24
    // Size: 0x1a, Type: dev
    function function_8e305de2cc844ac3( reason )
    {
        self.failreason = reason;
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0xb61f7ea1, Offset: 0x5f46
    // Size: 0x46, Type: dev
    function init_debug()
    {
        setdvarifuninitialized( @"scr_ai_encounters_pause", 0 );
        setdvarifuninitialized( @"hash_f14edbb0f6781ef7", 0 );
        thread function_8c6161f4c7775018();
        thread function_f5a9da02a80cf425();
        thread function_f4113a0e4434a642();
        thread encounter_hud();
        thread encounter_devgui();
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x71084e56, Offset: 0x5f94
    // Size: 0xd8, Type: dev
    function function_8c6161f4c7775018()
    {
        function_74aa0eb4c6c52725();
        assert( -1 );
        
        while ( true )
        {
            setdvar( @"hash_9c7e1cd61023c008", -2 );
            
            while ( getdvarint( @"hash_9c7e1cd61023c008", -2 ) == -2 )
            {
                wait 0.2;
            }
            
            forceindex = getdvarint( @"hash_9c7e1cd61023c008", -2 );
            
            if ( forceindex == -1 )
            {
                if ( !self.alllocations.size )
                {
                    continue;
                }
                
                sortedlocations = sortbydistance( self.alllocations, level.player.origin );
                forceindex = sortedlocations[ 0 ].debugindex;
            }
            
            forcelocation = self.alllocations[ forceindex ];
            encounter_start( forcelocation );
        }
    }

    // Namespace br_ai_encounters
    // Params 3
    // Checksum 0xb9f18a6d, Offset: 0x6074
    // Size: 0xe0, Type: dev
    function _encounter_force_end( dvarname, dvardefault, success )
    {
        function_74aa0eb4c6c52725();
        assert( dvardefault != -1 );
        
        while ( true )
        {
            setdvar( dvarname, dvardefault );
            
            while ( getdvarint( dvarname, dvardefault ) == dvardefault )
            {
                wait 0.2;
            }
            
            forceindex = getdvarint( dvarname, dvardefault );
            
            if ( forceindex == -1 )
            {
                if ( !self.activelocations.size )
                {
                    continue;
                }
                
                sortedlocations = sortbydistance( self.activelocations, level.player.origin );
                forceindex = sortedlocations[ 0 ].debugindex;
            }
            
            forcelocation = self.alllocations[ forceindex ];
            forcelocation encounter_end( success );
        }
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x334edc4f, Offset: 0x615c
    // Size: 0x19, Type: dev
    function function_f5a9da02a80cf425()
    {
        thread _encounter_force_end( @"hash_e4a17f4ad4db68f9", -2, 1 );
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x15edf206, Offset: 0x617d
    // Size: 0x18, Type: dev
    function function_f4113a0e4434a642()
    {
        thread _encounter_force_end( @"hash_ce1c94bf929657cc", -2, 0 );
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x52710234, Offset: 0x619d
    // Size: 0x4cb, Type: dev
    function encounter_hud()
    {
        setdvarifuninitialized( @"scr_ai_encounters_hud", 0 );
        setdvarifuninitialized( @"hash_42e40d8c0b9056bb", 10 );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        x_pos = 10;
        y_pos = 170;
        
        while ( true )
        {
            hudelems = [];
            
            while ( !getdvarint( @"scr_ai_encounters_hud", 0 ) )
            {
                waitframe();
            }
            
            hudheader = function_8c0030000a648cca();
            hudheader.x = x_pos;
            hudheader.y = y_pos;
            hudheader setdevtext( "<dev string:x42d>" );
            
            while ( getdvarint( @"scr_ai_encounters_hud", 0 ) )
            {
                maxprints = getdvarint( @"hash_42e40d8c0b9056bb", 10 );
                sortedlocations = sortbydistance( self.alllocations, level.player.origin );
                hudstrings = [];
                
                for ( i = 0; i < sortedlocations.size && i < maxprints ; i++ )
                {
                    loc = sortedlocations[ i ];
                    str = string( loc.debugindex ) + "<dev string:x43d>" + loc.name + "<dev string:x440>" + state_to_string( loc.state );
                    
                    if ( loc.state != 1 )
                    {
                        str += "<dev string:x440>" + get_location_fail_reason( loc );
                    }
                    
                    hudstrings[ hudstrings.size ] = str;
                    
                    if ( loc.state == 1 )
                    {
                        strprefix = "<dev string:x444>";
                        str = strprefix + "<dev string:x44b>" + loc.engagedradius + "<dev string:x45b>" + loc.playersinengagedradius.size;
                        hudstrings[ hudstrings.size ] = str;
                        str = strprefix + "<dev string:x468>" + loc.notifyradius + "<dev string:x45b>" + loc.playersinnotifyradius.size;
                        hudstrings[ hudstrings.size ] = str;
                        
                        if ( loc.usesai )
                        {
                            str = strprefix + "<dev string:x477>" + loc.agents.size + "<dev string:x486>" + loc.agentskilled;
                            hudstrings[ hudstrings.size ] = str;
                        }
                        
                        foreach ( debugstring in loc.activedebuginfo )
                        {
                            str = strprefix + debugstring;
                            hudstrings[ hudstrings.size ] = str;
                        }
                    }
                    
                    worldcolor = ( 1, 0, 0 );
                    
                    if ( loc.state == 1 )
                    {
                        worldcolor = ( 0, 1, 0 );
                    }
                    
                    str3d = string( loc.debugindex );
                    
                    if ( !i )
                    {
                        str3d += "<dev string:x491>";
                    }
                    
                    print3d( loc.origin, str3d, worldcolor );
                }
                
                count = 0;
                anychange = 0;
                
                for ( i = 0; i < hudstrings.size ; i++ )
                {
                    str = hudstrings[ i ];
                    
                    if ( !isdefined( hudelems[ i ] ) )
                    {
                        hudelems[ i ] = function_8c0030000a648cca();
                    }
                    
                    if ( !isdefined( hudelems[ i ] ) )
                    {
                        break;
                    }
                    
                    anychange = anychange || str != hudelems[ i ].currenttext;
                    hudelems[ i ].x = x_pos;
                    hudelems[ i ].y = y_pos + 10 * ( i + 1 );
                    count++;
                }
                
                if ( anychange )
                {
                    hudheader clearalltextafterhudelem();
                    
                    for ( i = 0; i < count ; i++ )
                    {
                        hudelems[ i ] setdevtext( hudstrings[ i ] );
                        hudelems[ i ].currenttext = hudstrings[ i ];
                    }
                }
                
                if ( count < hudelems.size )
                {
                    for ( i = hudelems.size - 1; i >= count ; i-- )
                    {
                        hudelems[ i ] destroy();
                        hudelems[ i ] = undefined;
                    }
                }
                
                waitframe();
            }
            
            foreach ( hud in hudelems )
            {
                hud destroy();
            }
            
            hudheader destroy();
        }
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0x378ead52, Offset: 0x6670
    // Size: 0x51, Type: dev
    function get_location_fail_reason( location )
    {
        var_7237854e3be197ca = get_encounter_fail_reason( location.encounter );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        var_7237854e3be197ca = location.failreason;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        return "<dev string:x493>";
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0x96ad7fda, Offset: 0x66c9
    // Size: 0x50, Type: dev
    function get_encounter_fail_reason( encounter )
    {
        if ( isdefined( encounter.parentencounter ) )
        {
            var_7237854e3be197ca = get_encounter_fail_reason( encounter.parentencounter );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        return encounter.failreason;
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x4fd5d57f, Offset: 0x6721
    // Size: 0x139, Type: dev
    function function_8c0030000a648cca()
    {
        fontelem = newhudelem();
        
        if ( isdefined( fontelem ) )
        {
            fontelem.elemtype = "<dev string:x4a2>";
            fontelem.font = "<dev string:x4a7>";
            fontelem.fontscale = 1.2;
            fontelem.basefontscale = fontelem.fontscale;
            fontelem.x = 0;
            fontelem.y = 0;
            fontelem.width = 0;
            fontelem.height = int( level.fontheight * fontelem.fontscale );
            fontelem.xoffset = 0;
            fontelem.yoffset = 0;
            fontelem.children = [];
            fontelem hud_util::setparent( level.uiparent );
            fontelem.hidden = 0;
            fontelem.aligny = "<dev string:x4af>";
            fontelem.alignx = "<dev string:x4b3>";
            fontelem.currenttext = "<dev string:x4b8>";
            fontelem setdevtext( "<dev string:x4b8>" );
        }
        
        return fontelem;
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0xd317f8d0, Offset: 0x6862
    // Size: 0x73, Type: dev
    function state_to_string( state )
    {
        switch ( state )
        {
            case 0:
                return "<dev string:x4be>";
            case 1:
                return "<dev string:x4c9>";
            case 2:
                return "<dev string:x4d4>";
            case 3:
                return "<dev string:x4e9>";
            default:
                return "<dev string:x4fd>";
        }
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0xf8e4d7a9, Offset: 0x68dd
    // Size: 0x1b8, Type: dev
    function encounter_devgui()
    {
        root = "<dev string:x505>";
        debughud = root + "<dev string:x520>";
        thread adddebugcommanddelayed( debughud + "<dev string:x52d>" + getxhashhexname( @"scr_ai_encounters_hud" ) + "<dev string:x539>" );
        thread adddebugcommanddelayed( debughud + "<dev string:x53e>" + getxhashhexname( @"scr_ai_encounters_hud" ) + "<dev string:x54b>" );
        debugai = root + "<dev string:x550>";
        thread adddebugcommanddelayed( debugai + "<dev string:x52d>" + getxhashhexname( @"hash_f14edbb0f6781ef7" ) + "<dev string:x539>" );
        thread adddebugcommanddelayed( debugai + "<dev string:x55c>" + getxhashhexname( @"hash_f14edbb0f6781ef7" ) + "<dev string:x56d>" );
        thread adddebugcommanddelayed( debugai + "<dev string:x572>" + getxhashhexname( @"hash_f14edbb0f6781ef7" ) + "<dev string:x54b>" );
        encounters = root + "<dev string:x57f>";
        encountersname = encounters + "<dev string:x58d>";
        _addlocation( encountersname, -1 );
        
        foreach ( i, loc in self.alllocations )
        {
            encountersname = encounters + loc.name + "<dev string:x599>" + i + "<dev string:x59b>" + i + "<dev string:x59e>";
            _addlocation( encountersname, i );
        }
    }

    // Namespace br_ai_encounters
    // Params 2
    // Checksum 0x90302636, Offset: 0x6a9d
    // Size: 0x9c, Type: dev
    function _addlocation( encountersname, index )
    {
        thread adddebugcommanddelayed( encountersname + "<dev string:x5a0>" + getxhashhexname( @"hash_9c7e1cd61023c008" ) + "<dev string:x5af>" + index + "<dev string:x5b1>" );
        thread adddebugcommanddelayed( encountersname + "<dev string:x5b4>" + getxhashhexname( @"hash_e4a17f4ad4db68f9" ) + "<dev string:x5af>" + index + "<dev string:x5b1>" );
        thread adddebugcommanddelayed( encountersname + "<dev string:x5cb>" + getxhashhexname( @"hash_ce1c94bf929657cc" ) + "<dev string:x5af>" + index + "<dev string:x5b1>" );
    }

    // Namespace br_ai_encounters
    // Params 1
    // Checksum 0xa1db19f9, Offset: 0x6b41
    // Size: 0x89, Type: dev
    function adddebugcommanddelayed( cmd )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( !isdefined( level.var_e49cfab3144b6e50 ) || level.var_e49cfab3144b6e50 < gettime() )
            {
                level.var_e49cfab3144b6e50 = gettime();
                level.var_bb5ead57ea9e3ac0 = 0;
            }
            
            if ( level.var_bb5ead57ea9e3ac0 < 3 )
            {
                break;
            }
            
            wait 0.05;
        }
        
        level.var_bb5ead57ea9e3ac0++;
        adddebugcommand( cmd );
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0x169c4fe2, Offset: 0x6bd2
    // Size: 0xc9, Type: dev
    function function_e57d306e2fad7665()
    {
        self endon( #"hash_40e543a1950bc4ec" );
        waittillframeend();
        
        if ( !self.usesai )
        {
            return;
        }
        
        while ( true )
        {
            debug = getdvarint( @"hash_f14edbb0f6781ef7", 0 );
            
            if ( debug )
            {
                foreach ( agent in self.agents )
                {
                    function_8ecfd626040cfbd3( agent, debug );
                }
                
                waitframe();
                continue;
            }
            
            wait 0.2;
        }
    }

    // Namespace br_ai_encounters
    // Params 2
    // Checksum 0xf5c5e14e, Offset: 0x6ca3
    // Size: 0x2d1, Type: dev
    function function_8ecfd626040cfbd3( agent, debug )
    {
        enemy = agent.enemy;
        printorigin = agent.origin + ( 0, 0, 70 );
        printdelta = ( 0, 0, -10 );
        printscale = 1;
        
        if ( isdefined( level.player ) )
        {
            playerdist = distance( level.player.origin, agent.origin );
            printscale = math::remap( playerdist, 0, 2000, 0.5, 2 );
            playerdir = anglestoforward( level.player.angles );
            enemydir = vectornormalize( agent.origin - level.player.origin );
            enemydot = vectordot( playerdir, enemydir );
            zoomdot = 0.99;
            
            if ( enemydot > zoomdot )
            {
                dotscale = math::remap( enemydot, zoomdot, 1, 1, 2 );
                printscale *= dotscale;
            }
            
            printdelta *= printscale;
        }
        
        if ( !isdefined( enemy ) )
        {
            print3d( printorigin, "<dev string:x5df>", ( 1, 0, 0 ), 1, printscale );
            printorigin += printdelta;
        }
        else
        {
            lastseen = agent lastknowntime( enemy );
            var_b7abcc953526b345 = gettime() - lastseen;
            
            if ( var_b7abcc953526b345 <= 50 )
            {
                var_283c5c8ae3ee4b44 = ( 0, 1, 0 );
            }
            else
            {
                var_283c5c8ae3ee4b44 = ( 1, 1, 0 );
            }
            
            enemyname = enemy.name;
            
            if ( !isdefined( enemyname ) )
            {
                enemyname = "<dev string:x5e4>" + enemy getentitynumber();
            }
            
            var_31156ddf229a04e = int( var_b7abcc953526b345 / 100 ) / 10;
            print3d( printorigin, enemyname + "<dev string:x5ea>" + var_31156ddf229a04e + "<dev string:x5ed>", var_283c5c8ae3ee4b44, 1, printscale );
            printorigin += printdelta;
            lastorigin = agent lastknownpos( enemy );
            sphere( lastorigin, 16, var_283c5c8ae3ee4b44 );
            
            if ( debug > 1 )
            {
                line( agent.origin, lastorigin, var_283c5c8ae3ee4b44 );
            }
        }
        
        print3d( printorigin, "<dev string:x5f0>" + agent.health + "<dev string:x59e>" + agent.maxhealth, ( 1, 1, 1 ), 1, printscale );
        printorigin += printdelta;
    }

    // Namespace br_ai_encounters
    // Params 0
    // Checksum 0xe2dfe76b, Offset: 0x6f7c
    // Size: 0xff, Type: dev
    function print_agent_array()
    {
        time = gettime();
        
        foreach ( agent in level.agentarray )
        {
            entnum = agent getentitynumber();
            agent_available_to_spawn_time = isdefined( level.agent_available_to_spawn_time ) && time < level.agent_available_to_spawn_time[ entnum ];
            println( br_ai_encounters_util::vartostring( agent ) + "<dev string:x5f3>" + br_ai_encounters_util::vartostring( agent.isactive ) + "<dev string:x5ff>" + br_ai_encounters_util::vartostring( agent.var_2bae40517a1557df ) + "<dev string:x61b>" + agent_available_to_spawn_time );
        }
    }

#/
