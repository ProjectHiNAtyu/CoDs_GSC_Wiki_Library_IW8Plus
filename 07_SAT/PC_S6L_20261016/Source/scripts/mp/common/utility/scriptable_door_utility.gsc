// scripts\mp\common\utility\scriptable_door_utility.gsc  (hash_5ee6e4822826d120.gscc) (size: 5979 Bytes / 0x175b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb762a53b (3076695355)
// size ...... 5979 (0x175b)
// includes .. 2   (offset: 0x15ef)
// strings ... 19  (offset: 0x15ff)
// dev strs .. 1   (offset: 0x174f)
// exports ... 18  (offset: 0xe5f)
// cseg ...... 0x135 + 0xd2a (0xe5f)
// imports ... 38  (offset: 0x112f)
// animtree1 . 0   (offset: 0x175b)
// animtree2 . 0   (offset: 0x175b)
#using scripts\common\system;
#using scripts\common\utility;

#namespace scriptable_door_utility;

// Namespace scriptable_door_utility
// Params 0, eflags: 0x5
// Checksum 0xd535c906, Offset: 0x153
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"scriptable_door_utility", undefined, undefined, &post_main );
}

// Namespace scriptable_door_utility
// Params 0, eflags: 0x4
// Checksum 0x7dd12432, Offset: 0x174
// Size: 0x1d
function private post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    init_post_funcs();
    function_348426697254d2e5();
}

// Namespace scriptable_door_utility
// Params 0, eflags: 0x4
// Checksum 0x22a5462, Offset: 0x199
// Size: 0x21
function private init_post_funcs()
{
    level.var_598f3043421fe530 = [];
    level.var_598f3043421fe530[ "door_trigger" ] = &door_trigger;
}

// Namespace scriptable_door_utility
// Params 0, eflags: 0x4
// Checksum 0x5c91f45d, Offset: 0x1c2
// Size: 0xfa
function private function_348426697254d2e5()
{
    foreach ( targetname, func in level.var_598f3043421fe530 )
    {
        if ( isdefined( func ) )
        {
            entlist = getentarray( targetname, "targetname" );
            
            foreach ( entity in entlist )
            {
                entity thread [[ func ]]();
            }
        }
    }
}

// Namespace scriptable_door_utility
// Params 3
// Checksum 0xf1687863, Offset: 0x2c4
// Size: 0xf4
function scriptable_door_get_in_radius( position, radius, maxheightdiff )
{
    doors = getentitylessscriptablearray( undefined, undefined, position, radius, "door" );
    filtereddoors = [];
    
    foreach ( door in doors )
    {
        if ( !door scriptableisdoor() )
        {
            continue;
        }
        
        if ( isdefined( maxheightdiff ) )
        {
            heightdiff = door.origin[ 2 ] - position[ 2 ];
            
            if ( heightdiff <= maxheightdiff )
            {
                filtereddoors[ filtereddoors.size ] = door;
            }
            
            continue;
        }
        
        filtereddoors[ filtereddoors.size ] = door;
    }
    
    return filtereddoors;
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0x644f6212, Offset: 0x3c1
// Size: 0xdc
function scriptable_door_freeze_open( isbashleft )
{
    self notify( #"scriptable_door_freeze_open" );
    self endon( #"scriptable_door_freeze_open" );
    bashstate = undefined;
    targetangles = undefined;
    
    if ( isbashleft )
    {
        bashstate = "bash_left_90";
        targetangles = self function_9ae4daa2a11c58bd() + ( 0, 90, 0 );
    }
    else
    {
        bashstate = "bash_right_90";
        targetangles = self function_9ae4daa2a11c58bd() + ( 0, -90, 0 );
    }
    
    while ( anglesdelta( self.angles, targetangles ) > 1 )
    {
        currentstate = self getscriptablepartstate( "door" );
        
        if ( currentstate != bashstate )
        {
            self setscriptablepartstate( "door", bashstate, 0 );
        }
        
        wait 0.05;
    }
    
    self setscriptablepartstate( "door", "ajar", 0 );
    self scriptabledoorfreeze( 1 );
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0x46831ae0, Offset: 0x4a5
// Size: 0x7c
function function_a6d402d10d7a3a2e( doors )
{
    foreach ( door in doors )
    {
        door scriptabledoorfreeze();
    }
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0xcbb34a60, Offset: 0x529
// Size: 0x62, Type: bool
function scriptable_door_is_double_door_pair( otherdoor )
{
    if ( self == otherdoor )
    {
        return false;
    }
    
    centera = self function_50ddcb729a6c2820();
    centerb = otherdoor function_50ddcb729a6c2820();
    distsqrd = distancesquared( centera, centerb );
    
    if ( distsqrd > 961 || distsqrd < 441 )
    {
        return false;
    }
    
    return true;
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0xbb148f26, Offset: 0x594
// Size: 0xac, Type: bool
function function_c4446a4597ae7ab2( otherdoor )
{
    if ( self == otherdoor )
    {
        return false;
    }
    
    centera = self function_50ddcb729a6c2820();
    centerb = otherdoor function_50ddcb729a6c2820();
    centerdistsqrd = distancesquared( centera, centerb );
    
    if ( centerdistsqrd > 3249 || centerdistsqrd < 2209 )
    {
        return false;
    }
    
    hingea = self.origin;
    hingeb = otherdoor.origin;
    hingedistsqrd = distancesquared( hingea, hingeb );
    
    if ( hingedistsqrd > 11881 || hingedistsqrd < 9801 )
    {
        return false;
    }
    
    return true;
}

// Namespace scriptable_door_utility
// Params 0, eflags: 0x4
// Checksum 0xf9a19daa, Offset: 0x649
// Size: 0xd6
function private function_f5b4bddd853e6304()
{
    if ( !isdefined( self.script_parameters ) )
    {
        return [];
    }
    
    parmlist = strtok( self.script_parameters, ";" );
    parmsresult = [];
    
    foreach ( parm in parmlist )
    {
        var_3cab52442d84430 = strtok( parm, " =" );
        
        if ( isdefined( var_3cab52442d84430[ 1 ] ) )
        {
            parmsresult[ var_3cab52442d84430[ 0 ] ] = var_3cab52442d84430[ 1 ];
            continue;
        }
        
        parmsresult[ var_3cab52442d84430[ 0 ] ] = 1;
    }
    
    return parmsresult;
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0xa64a0df9, Offset: 0x728
// Size: 0x1f2
function simple_lock_door( createnavobstacle = 1 )
{
    self endon( #"death" );
    function_1864b7fc259dd0fb();
    self.var_1a797c53e833daea = 1;
    utility::flag_wait( "scriptables_ready" );
    locks = get_target_doors( "door_lock" );
    
    foreach ( lock in locks )
    {
        if ( !isdefined( lock ) )
        {
            continue;
        }
        
        lock setscriptablepartstate( "door_lock", "locked", 0 );
    }
    
    if ( createnavobstacle )
    {
        self.navobstacles = [];
        doorlist = get_target_doors( "door" );
        
        foreach ( door in doorlist )
        {
            if ( isdefined( door.model ) )
            {
                halfbounds = function_decb653c5689e4ca( door.model );
                localmid = function_caaf4dc13b656242( door.model );
                mid = coordtransform( localmid, door.origin, door.angles );
                self.navobstacles[ self.navobstacles.size ] = createnavobstaclebybounds( mid, halfbounds, door.angles );
            }
        }
    }
}

// Namespace scriptable_door_utility
// Params 0
// Checksum 0x52ea7cf, Offset: 0x922
// Size: 0xc5
function simple_unlock_door()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    self.var_1a797c53e833daea = undefined;
    locks = get_target_doors( "door_lock" );
    
    foreach ( lock in locks )
    {
        if ( !isdefined( lock ) )
        {
            continue;
        }
        
        lock setscriptablepartstate( "door_lock", "static", 0 );
    }
    
    function_1864b7fc259dd0fb();
}

// Namespace scriptable_door_utility
// Params 0
// Checksum 0xa99f0fd5, Offset: 0x9ef
// Size: 0x93
function function_1864b7fc259dd0fb()
{
    if ( isarray( self.navobstacles ) )
    {
        foreach ( obstacle in self.navobstacles )
        {
            destroynavobstacle( obstacle );
        }
        
        self.navobstacles = undefined;
    }
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0xaf05175, Offset: 0xa8a
// Size: 0xb6
function function_ebbc2714ba8e6bd9( state )
{
    assert( isstring( state ), "<dev string:x24>" );
    doorlist = get_target_doors( "door" );
    
    foreach ( door in doorlist )
    {
        if ( !isdefined( door ) )
        {
            continue;
        }
        
        door setscriptablepartstate( "door", state, 0 );
    }
}

// Namespace scriptable_door_utility
// Params 1, eflags: 0x4
// Checksum 0x78b09d9a, Offset: 0xb48
// Size: 0x6a
function private get_target_doors( part )
{
    if ( !isdefined( self.doorlist[ part ] ) )
    {
        if ( isdefined( self.target ) )
        {
            self.doorlist[ part ] = getentitylessscriptablearray( self.target, "targetname", undefined, undefined, part );
        }
        else
        {
            self.doorlist[ part ] = [];
        }
    }
    
    return self.doorlist[ part ];
}

// Namespace scriptable_door_utility
// Params 0, eflags: 0x4
// Checksum 0xda95c96, Offset: 0xbbb
// Size: 0x22a
function private door_trigger()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    parms = function_f5b4bddd853e6304();
    
    if ( parms[ "locked" ] )
    {
        thread simple_lock_door();
    }
    
    utility::flag_wait( "scriptables_ready" );
    doorlist = get_target_doors( "door" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        if ( self.var_1a797c53e833daea )
        {
            continue;
        }
        
        foreach ( door in doorlist )
        {
            if ( !isdefined( door ) )
            {
                continue;
            }
            
            if ( isstring( parms[ "state" ] ) )
            {
                door setscriptablepartstate( "door", parms[ "state" ], 0 );
                self notify( parms[ "state" ] );
                continue;
            }
            
            if ( parms[ "cycle_on_trigger" ] )
            {
                curstate = door getscriptablepartstate( "door", 1 );
                
                if ( isdefined( curstate ) && issubstr( curstate, "open" ) )
                {
                    door setscriptablepartstate( "door", "closing", 0 );
                    self notify( #"closing" );
                }
                else if ( isdefined( curstate ) && issubstr( curstate, "clos" ) )
                {
                    door setscriptablepartstate( "door", "opening", 0 );
                    self notify( #"opening" );
                }
                
                continue;
            }
            
            self.doorclosetime = gettime() + 250;
            curstate = door getscriptablepartstate( "door", 1 );
            
            if ( isdefined( curstate ) && issubstr( curstate, "clos" ) || curstate == "static" )
            {
                door setscriptablepartstate( "door", "opening", 0 );
                self notify( #"opening" );
                door thread closedoortimeout( self );
            }
        }
        
        if ( parms[ "delete" ] )
        {
            self delete();
        }
    }
}

// Namespace scriptable_door_utility
// Params 1
// Checksum 0xcafe17bb, Offset: 0xded
// Size: 0x72
function closedoortimeout( trigger )
{
    self notify( #"hash_5bd9e1e46aadb587" );
    self endon( #"hash_5bd9e1e46aadb587" );
    self endon( #"death_or_disconnet" );
    trigger endon( #"death_or_disconnet" );
    
    while ( gettime() < trigger.doorclosetime )
    {
        waitframe();
    }
    
    self setscriptablepartstate( "door", "closing", 0 );
    trigger notify( #"closing" );
}

