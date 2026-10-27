// script_2925c5adf721238a  (hash_2925c5adf721238a.gscc) (size: 16571 Bytes / 0x40bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1137116 (18051350)
// size ...... 16571 (0x40bb)
// includes .. 2   (offset: 0x3cdf)
// strings ... 36  (offset: 0x3cef)
// dev strs .. 25  (offset: 0x3f1b)
// exports ... 35  (offset: 0x2f6f)
// cseg ...... 0x43e + 0x2b31 (0x2f6f)
// imports ... 61  (offset: 0x34e7)
// animtree1 . 1   (offset: 0x408b)
// animtree2 . 2   (offset: 0x409b)
#using scripts\common\anim;
#using scripts\common\utility;

#namespace dmz_bio_lab_elevators;

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x83ab0528, Offset: 0x45c
// Size: 0xa4f
function initelevators( prioritytable )
{
    level.elevators = [];
    level.elevatorsfuncs = [];
    level.elevatorstops = [];
    level.var_7daa2f8007cbb7a7 = 0;
    scriptmodelanims();
    elevatorstops = getentitylessscriptablearray( "elevator_stop", #script_noteworthy );
    var_5f42e679da0bb041 = [];
    
    foreach ( stop in elevatorstops )
    {
        posstring = stop.origin[ 0 ] + "," + stop.origin[ 1 ];
        
        if ( !isdefined( var_5f42e679da0bb041[ posstring ] ) )
        {
            var_5f42e679da0bb041[ posstring ] = [];
        }
        
        var_5f42e679da0bb041[ posstring ][ var_5f42e679da0bb041[ posstring ].size ] = stop;
        stop.open = 0;
        [ stop.indicator ] = getentitylessscriptablearray( stop.target, #targetname );
        frontposition = utility::getstruct( stop.indicator.target, "targetname" );
        stop.frontposition = frontposition.origin;
        stop.doors = getentitylessscriptablearray( stop.indicator.target, #targetname );
        stop.var_f9192a59c6b1857a = getent( stop.target, #targetname );
        
        if ( level.mapname == "mp_biobunker" && isdefined( stop.script_linkname ) && isendstr( stop.script_linkname, "elevator_50" ) )
        {
            stop.frontposition = ( -15049, 7096, 1660 );
        }
        
        var_65a32e99ba834bcd = getentarray( stop.indicator.target, #targetname );
        
        foreach ( targetent in var_65a32e99ba834bcd )
        {
            if ( targetent.classname == "script_brushmodel" )
            {
                stop.aiclip = targetent;
                continue;
            }
            
            if ( targetent.classname == "info_volume" )
            {
                stop.var_37f6674910345671 = targetent;
            }
        }
        
        foreach ( door in stop.doors )
        {
            door.open = 0;
            door.clip = getent( door.target, #targetname );
            door.clip.initialorigin = door.clip.origin;
            openstruct = utility::getstruct( door.clip.target, "targetname" );
            door.clip.openposition = openstruct.origin;
            
            if ( openstruct.target )
            {
                bulletclip = getent( openstruct.target, #targetname );
                door.bulletclip = bulletclip;
            }
        }
        
        stop.waypointposition = utility::getstruct( stop.target, "targetname" );
    }
    
    elevatorcars = utility::getstructarray( "elevator_car", "script_noteworthy" );
    
    foreach ( elevatorset in var_5f42e679da0bb041 )
    {
        elevator = spawnstruct();
        elevator.parts = [];
        elevator.floors = [];
        group = "elevator_group_free";
        elevator.group = group;
        groundfloorindex = 0;
        
        foreach ( stop in elevatorset )
        {
            stop.elevator = elevator;
        }
        
        checkorigin = elevatorset[ groundfloorindex ].origin;
        mindist = undefined;
        targetcar = undefined;
        
        foreach ( car in elevatorcars )
        {
            dist = distancesquared( car.origin, checkorigin );
            
            if ( !isdefined( mindist ) || mindist > dist )
            {
                mindist = dist;
                targetcar = car;
            }
        }
        
        car = spawn( "script_model", targetcar.origin );
        car.angles = targetcar.angles;
        
        switch ( level.mapname )
        {
            case #"hash_721bd15904e6ff51":
                car setmodel( "building_biolabs_elevator_set_int" );
                break;
            case #"hash_5d52d1f62d321d14":
                car setmodel( "building_biobunker_elevator_car_frame_one_way" );
                break;
            default:
                car setmodel( "building_biolabs_elevator_set_int" );
                break;
        }
        
        car.animname = "elevator";
        car animation::setanimtree();
        car.elevator = elevator;
        car.moverdoesnotkill = 1;
        elevator.car = car;
        var_3a10b17fc3cd2ceb = arraysort( elevatorset, undefined, &heightcompare );
        
        for ( i = 0; i < var_3a10b17fc3cd2ceb.size ; i++ )
        {
            elevator.floors[ i ] = var_3a10b17fc3cd2ceb[ i ];
            elevator.floors[ i ].floornum = i;
            
            if ( i > 0 )
            {
                elevator.floors[ i ].targetheight = elevator.floors[ i ].origin[ 2 ] - elevator.floors[ i - 1 ].origin[ 2 ] + elevator.floors[ i - 1 ].targetheight;
            }
            else
            {
                elevator.floors[ i ].targetheight = elevator.car.origin[ 2 ];
            }
            
            elevator.floors[ i ].elevator = elevator;
            elevator.floors[ i ].floor = i;
            floororigin = ( elevator.car.origin[ 0 ], elevator.car.origin[ 1 ], elevator.floors[ i ].targetheight );
            worldfloor = function_b55f83eeeea55c19( floororigin );
            elevator.floors[ i ].worldfloor = worldfloor ?? i;
            stopid = function_6aba58f20b4f79e2( elevatorset[ i ] );
            
            if ( !isdefined( stopid ) )
            {
                level.var_7daa2f8007cbb7a7++;
                stopid = "unAuthorized_stop_" + level.var_7daa2f8007cbb7a7;
            }
            
            elevator.floors[ i ].stopid = stopid;
            level.elevatorstops[ stopid ] = elevator.floors[ i ];
        }
        
        elevator.id = elevator.floors[ 0 ].stopid;
        elevator.currentfloor = 0;
        elevator.targetfloor = 0;
        
        if ( !isdefined( level.elevators[ group ] ) )
        {
            level.elevators[ group ] = [];
        }
        
        level.elevators[ group ][ level.elevators[ group ].size ] = elevator;
    }
    
    level.var_8099ceeba888661b = [];
    level.var_b3e81e5e012c0764 = [];
    level.var_71333742db993dac = [];
    level thread function_d5c8244b25054a87();
    level thread function_4c7684ffbff52684();
    level.var_99b3ff6b099dcb03 = 1;
    
    if ( isdefined( prioritytable ) )
    {
        function_b0b82122afca887d( prioritytable );
    }
    
    /#
        level thread function_7d4c29e3e8666e2f();
    #/
}

// Namespace dmz_bio_lab_elevators
// Params 2
// Checksum 0x2b6bf6af, Offset: 0xeb3
// Size: 0x32, Type: bool
function heightcompare( target1, target2 )
{
    return target1.origin[ 2 ] < target2.origin[ 2 ];
}

// Namespace dmz_bio_lab_elevators
// Params 3
// Checksum 0xa85f16c4, Offset: 0xeee
// Size: 0x4b
function registerfsm( group, state, func )
{
    if ( !isdefined( level.elevatorsfuncs[ group ] ) )
    {
        level.elevatorsfuncs[ group ] = [];
    }
    
    level.elevatorsfuncs[ group ][ state ] = func;
}

// Namespace dmz_bio_lab_elevators
// Params 8
// Checksum 0x146b5932, Offset: 0xf41
// Size: 0xe2
function callelevator( owner, group, state, callorigin, pickrule, floors, assignedcallback, var_7d52ce2ab49c1dc3 )
{
    var_135eb1bbb709a2c9 = spawnstruct();
    var_135eb1bbb709a2c9.owner = owner;
    var_135eb1bbb709a2c9.group = group;
    var_135eb1bbb709a2c9.state = state;
    var_135eb1bbb709a2c9.callorigin = callorigin;
    var_135eb1bbb709a2c9.pickrule = pickrule;
    var_135eb1bbb709a2c9.idealfloors = floors;
    var_135eb1bbb709a2c9.assignedcallback = assignedcallback;
    var_135eb1bbb709a2c9.var_7d52ce2ab49c1dc3 = var_7d52ce2ab49c1dc3;
    level.var_b3e81e5e012c0764[ level.var_b3e81e5e012c0764.size ] = var_135eb1bbb709a2c9;
}

// Namespace dmz_bio_lab_elevators
// Params 6
// Checksum 0x7e5a4546, Offset: 0x102b
// Size: 0xc5
function function_7fddc8beb0a0d8d0( owner, group, state, id, assignedcallback, var_7d52ce2ab49c1dc3 )
{
    var_135eb1bbb709a2c9 = spawnstruct();
    var_135eb1bbb709a2c9.owner = owner;
    var_135eb1bbb709a2c9.group = group;
    var_135eb1bbb709a2c9.state = state;
    var_135eb1bbb709a2c9.pickrule = "elevator_pick_rule_id";
    var_135eb1bbb709a2c9.id = id;
    var_135eb1bbb709a2c9.assignedcallback = assignedcallback;
    var_135eb1bbb709a2c9.var_7d52ce2ab49c1dc3 = var_7d52ce2ab49c1dc3;
    level.var_b3e81e5e012c0764[ level.var_b3e81e5e012c0764.size ] = var_135eb1bbb709a2c9;
}

// Namespace dmz_bio_lab_elevators
// Params 5
// Checksum 0x1fcb2db, Offset: 0x10f8
// Size: 0x73
function function_ea3d16b9ac19d351( owner, group, state, callorigin, pickrule )
{
    elevator = undefined;
    
    switch ( pickrule )
    {
        case #"hash_a30cdbeb79218fc6":
            elevator = function_1e488729224edcd1( callorigin );
            break;
    }
    
    if ( isdefined( elevator ) )
    {
        elevator startelevator( group, state );
    }
    
    return elevator;
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xcb685642, Offset: 0x1174
// Size: 0x36
function activatefloor( floornum )
{
    if ( !arraycontains( level.var_71333742db993dac, floornum ) )
    {
        level.var_71333742db993dac[ level.var_71333742db993dac.size ] = floornum;
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x9ec45753, Offset: 0x11b2
// Size: 0x24
function function_4f5765fce5345e3b( floornum )
{
    if ( !isdefined( floornum ) )
    {
        return 0;
    }
    
    return arraycontains( level.var_71333742db993dac, floornum );
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xa5741845, Offset: 0x11df
// Size: 0x27
function function_b55f83eeeea55c19( origin )
{
    if ( isdefined( level.var_7d492e50761ed689 ) )
    {
        return [[ level.var_7d492e50761ed689 ]]( origin );
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xd20b6b0a, Offset: 0x120e
// Size: 0x7d
function function_6aba58f20b4f79e2( var_5f106b372b1cf8e )
{
    if ( isdefined( var_5f106b372b1cf8e.script_linkname ) )
    {
        groupstr = strtok( var_5f106b372b1cf8e.script_linkname, "_" );
        
        if ( groupstr.size > 0 )
        {
            stopid = groupstr[ 1 ];
            
            for ( i = 2; i < groupstr.size ; i++ )
            {
                stopid = stopid + "_" + groupstr[ i ];
            }
            
            return stopid;
        }
    }
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x81d2633a, Offset: 0x1294
// Size: 0xc2
function function_4c7684ffbff52684()
{
    level endon( #"game_ended" );
    level waittill( #"matchstarttimer_done" );
    
    foreach ( elevator in level.elevators[ "elevator_group_free" ] )
    {
        elevatorextbutton = elevator.floors[ elevator.currentfloor ];
        elevatorextbutton.aiclip disconnectpaths();
    }
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x69345ba5, Offset: 0x135e
// Size: 0x245
function function_d5c8244b25054a87()
{
    level endon( #"game_ended" );
    var_a6942d08b63bb4b8 = 0;
    
    while ( true )
    {
        for ( i = 0; i < level.var_b3e81e5e012c0764.size ; i++ )
        {
            if ( level.elevators[ "elevator_group_free" ].size > 0 )
            {
                elevator = undefined;
                request = level.var_b3e81e5e012c0764[ i ];
                
                switch ( request.pickrule )
                {
                    case #"hash_fba835080c4a6b66":
                        elevator = function_686951b492e3d074();
                        break;
                    case #"hash_597ee058566f8b00":
                        assert( isdefined( request.owner ), "<dev string:x24>" + "<dev string:x4d>" );
                        elevator = function_f4a5b8d27540a1a5( request.owner );
                        break;
                    case #"hash_a510ae28921a5f2":
                        assert( isdefined( request.owner ) && isarray( request.idealfloors ), "<dev string:x71>" + "<dev string:xac>" );
                        elevator = function_f4a5b8d27540a1a5( request.owner, request.idealfloors );
                        break;
                    case #"hash_a30cdbeb79218fc6":
                        assert( isdefined( request.callorigin ), "<dev string:xe0>" + "<dev string:xf9>" );
                        elevator = function_1e488729224edcd1( request.callorigin );
                        break;
                    case #"hash_db4c90c3bb8c6cbc":
                        assert( isdefined( request.id ), "<dev string:x11f>" + "<dev string:x135>" );
                        elevator = function_b50e7f9178b49c77( request.id );
                        break;
                }
                
                if ( isdefined( elevator ) )
                {
                    if ( isdefined( request.assignedcallback ) )
                    {
                        level thread [[ request.assignedcallback ]]( elevator, request.var_7d52ce2ab49c1dc3 );
                    }
                    
                    elevator startelevator( request.group, request.state );
                    level.var_b3e81e5e012c0764[ i ] = undefined;
                    var_a6942d08b63bb4b8 = 1;
                }
            }
        }
        
        if ( var_a6942d08b63bb4b8 )
        {
            level.var_b3e81e5e012c0764 = function_5713d46873b29625( level.var_b3e81e5e012c0764 );
            var_a6942d08b63bb4b8 = 0;
        }
        
        waitframe();
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x9fe542be, Offset: 0x15ab
// Size: 0x12d
function function_b0b82122afca887d( table )
{
    var_440eed6a54f4a027 = 0;
    var_484162a26998facb = 1;
    numrows = 0;
    
    if ( tableexists( table ) )
    {
        numrows = tablelookupgetnumrows( table );
    }
    else
    {
        assertmsg( table + "<dev string:x153>" );
        return;
    }
    
    level.var_f1252bbeb6fa49bd = [];
    
    for ( i = 0; i < numrows ; i++ )
    {
        prioritynode = spawnstruct();
        csvorigin = tablelookupbyrow( table, i, var_440eed6a54f4a027 );
        tmporigin = strtok( csvorigin, ", " );
        checkorigin = ( float( tmporigin[ 0 ] ), float( tmporigin[ 1 ] ), float( tmporigin[ 2 ] ) );
        prioritynode.origin = checkorigin;
        prioritynode.enable = 1;
        var_a5feefe713cbe13b = tablelookupbyrow( table, i, var_484162a26998facb );
        var_97e69230470f8e32 = strtok( var_a5feefe713cbe13b, ", " );
        prioritynode.elevatorids = var_97e69230470f8e32;
        level.var_f1252bbeb6fa49bd[ i ] = prioritynode;
    }
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0xa3ec1791, Offset: 0x16e0
// Size: 0x5b
function function_686951b492e3d074()
{
    elevator = utility::array_random( level.elevators[ "elevator_group_free" ] );
    
    if ( isdefined( elevator ) )
    {
        if ( elevator.floors.size > 1 )
        {
            elevator.targetfloor = utility::array_random( elevator.floors );
        }
        
        return elevator;
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xc937ef35, Offset: 0x1744
// Size: 0x1a9
function function_1e488729224edcd1( callorigin )
{
    if ( !isdefined( level.var_f1252bbeb6fa49bd ) || level.var_f1252bbeb6fa49bd.size == 0 )
    {
        assertmsg( "<dev string:x162>" );
        return;
    }
    
    var_ce8c2311ead06faa = sortbydistance( level.var_f1252bbeb6fa49bd, callorigin );
    var_d6e48a01151e0f02 = [];
    
    foreach ( node in var_ce8c2311ead06faa )
    {
        if ( node.enable )
        {
            var_d6e48a01151e0f02 = node.elevatorids;
            break;
        }
    }
    
    foreach ( stopid in var_d6e48a01151e0f02 )
    {
        stop = level.elevatorstops[ stopid ];
        elevator = function_b50e7f9178b49c77( stopid );
        
        if ( isdefined( elevator ) )
        {
            reachable = 1;
            
            if ( isdefined( level.var_a00ad87f50516998 ) )
            {
                reachable = [[ level.var_a00ad87f50516998 ]]( stop, callorigin );
            }
            
            if ( reachable )
            {
                return elevator;
            }
        }
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x56c4489a, Offset: 0x18f6
// Size: 0x6f
function function_b50e7f9178b49c77( stopid )
{
    stop = level.elevatorstops[ stopid ];
    
    if ( stop.elevator.group == "elevator_group_free" )
    {
        stop.elevator.targetfloor = stop.floor;
        return stop.elevator;
    }
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xe2114892, Offset: 0x196e
// Size: 0x22
function function_8233c454135b2c48( stopid )
{
    return level.elevatorstops[ stopid ].elevator;
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x468ceba1, Offset: 0x1999
// Size: 0x18
function function_ab18dd55b23e35eb( group )
{
    return level.elevators[ group ];
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0xdb060389, Offset: 0x19ba
// Size: 0x18
function function_a6eca4ffc8470660( stopid )
{
    return level.elevatorstops[ stopid ];
}

// Namespace dmz_bio_lab_elevators
// Params 2
// Checksum 0x3d916613, Offset: 0x19db
// Size: 0x15d, Type: bool
function function_5c9ef2502bfa6a6e( owner, worldfloors )
{
    foreach ( worldfloor in worldfloors )
    {
        foreach ( stop in level.elevatorstops )
        {
            if ( worldfloor == stop.worldfloor )
            {
                var_749f7849a939606c = stop.elevator;
                pickedinfo = level.var_8099ceeba888661b[ owner ][ var_749f7849a939606c.id ];
                
                if ( !isdefined( pickedinfo ) || arraycontains( pickedinfo.availablefloors, stop.floor ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace dmz_bio_lab_elevators
// Params 2
// Checksum 0x1c817103, Offset: 0x1b41
// Size: 0x3ed
function function_f4a5b8d27540a1a5( owner, worldfloors )
{
    assert( isdefined( owner ), "<dev string:x1be>" );
    
    if ( !isdefined( level.var_8099ceeba888661b[ owner ] ) )
    {
        level.var_8099ceeba888661b[ owner ] = [];
    }
    
    var_5025d2ccfd8e7976 = [];
    
    if ( !isdefined( worldfloors ) )
    {
        var_5025d2ccfd8e7976 = level.var_71333742db993dac;
    }
    else if ( isarray( worldfloors ) )
    {
        foreach ( worldfloor in worldfloors )
        {
            if ( function_4f5765fce5345e3b( worldfloor ) )
            {
                var_5025d2ccfd8e7976[ var_5025d2ccfd8e7976.size ] = worldfloor;
            }
        }
    }
    else
    {
        assert( "<dev string:x1ed>" );
        return;
    }
    
    if ( var_5025d2ccfd8e7976.size == 0 )
    {
        return;
    }
    
    availableelevators = [];
    
    foreach ( elevator in level.elevators[ "elevator_group_free" ] )
    {
        availableelevator = undefined;
        pickedinfo = level.var_8099ceeba888661b[ owner ][ elevator.id ];
        
        if ( !isdefined( pickedinfo ) )
        {
            for ( i = 0; i < elevator.floors.size ; i++ )
            {
                worldfloor = elevator.floors[ i ].worldfloor;
                
                if ( arraycontains( var_5025d2ccfd8e7976, worldfloor ) )
                {
                    if ( !isdefined( availableelevator ) )
                    {
                        availableelevator = spawnstruct();
                        availableelevator.var_bdb98f8c4ecc439b = [];
                        availableelevator.elevator = elevator;
                        availableelevators[ availableelevators.size ] = availableelevator;
                    }
                    
                    availableelevator.var_bdb98f8c4ecc439b[ availableelevator.var_bdb98f8c4ecc439b.size ] = i;
                }
            }
            
            continue;
        }
        
        if ( pickedinfo.availablefloors.size > 0 )
        {
            for ( i = 0; i < pickedinfo.availablefloors.size ; i++ )
            {
                worldfloor = elevator.floors[ pickedinfo.availablefloors[ i ] ].worldfloor;
                
                if ( arraycontains( var_5025d2ccfd8e7976, worldfloor ) )
                {
                    if ( !isdefined( availableelevator ) )
                    {
                        availableelevator = spawnstruct();
                        availableelevator.var_bdb98f8c4ecc439b = [];
                        availableelevator.elevator = elevator;
                        availableelevators[ availableelevators.size ] = availableelevator;
                    }
                    
                    availableelevator.var_bdb98f8c4ecc439b[ availableelevator.var_bdb98f8c4ecc439b.size ] = pickedinfo.availablefloors[ i ];
                }
            }
        }
    }
    
    if ( availableelevators.size == 0 )
    {
        return;
    }
    
    var_682d2537c75165b2 = availableelevators[ randomint( availableelevators.size ) ];
    elevator = var_682d2537c75165b2.elevator;
    var_bdb98f8c4ecc439b = var_682d2537c75165b2.var_bdb98f8c4ecc439b;
    pickedinfo = level.var_8099ceeba888661b[ owner ][ elevator.id ];
    
    if ( !isdefined( pickedinfo ) )
    {
        pickedinfo = spawnstruct();
        pickedinfo.availablefloors = [];
        
        for ( i = 0; i < elevator.floors.size ; i++ )
        {
            pickedinfo.availablefloors[ i ] = i;
        }
    }
    
    elevator.targetfloor = utility::array_random( var_bdb98f8c4ecc439b );
    pickedinfo.availablefloors = arrayremove( pickedinfo.availablefloors, elevator.targetfloor );
    level.var_8099ceeba888661b[ owner ][ elevator.id ] = pickedinfo;
    return elevator;
}

// Namespace dmz_bio_lab_elevators
// Params 2
// Checksum 0xe46dc409, Offset: 0x1f37
// Size: 0xbd
function startelevator( group, state )
{
    assert( group != "<dev string:x208>" && group != self.group, "<dev string:x21c>" );
    level.elevators[ self.group ] = arrayremove( level.elevators[ self.group ], self );
    self.group = group;
    self.state = state;
    
    if ( !isdefined( level.elevators[ group ] ) )
    {
        level.elevators[ group ] = [];
    }
    
    level.elevators[ group ][ level.elevators[ group ].size ] = self;
    waitframe();
    thread function_138839dad5d52039();
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x2ef2586e, Offset: 0x1ffc
// Size: 0x78
function releaseelevator()
{
    level.elevators[ self.group ] = arrayremove( level.elevators[ self.group ], self );
    self.group = "elevator_group_free";
    self.state = "";
    level.elevators[ "elevator_group_free" ][ level.elevators[ "elevator_group_free" ].size ] = self;
    self notify( #"elevator_release" );
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x236025b4, Offset: 0x207c
// Size: 0x19e
function function_138839dad5d52039()
{
    level endon( #"game_ended" );
    self endon( #"elevator_release" );
    
    while ( true )
    {
        keepprint = 1;
        
        if ( !isdefined( self.group ) )
        {
            keepprint = 0;
            logstring( self.id + " Group is undefined for this elevator" );
        }
        
        if ( keepprint && !isdefined( level.elevatorsfuncs[ self.group ] ) )
        {
            keepprint = 0;
            logstring( self.id + " Group " + self.group + " has not registered FSM yet" );
        }
        
        if ( keepprint && !isdefined( self.state ) )
        {
            keepprint = 0;
            logstring( self.id + " State is undefined for this elevator in Group: " + self.group );
        }
        
        if ( keepprint && !isdefined( level.elevatorsfuncs[ self.group ][ self.state ] ) )
        {
            keepprint = 0;
            logstring( self.id + " State " + self.state + " has not been registered FSM to Group: " + self.group );
        }
        
        if ( keepprint )
        {
            logstring( "===============  Elevator FSM Log  ===============" );
            logstring( "Elevator Id: " + self.id );
            logstring( "Group: " + self.group );
            logstring( "State: " + self.state );
            logstring( "===============  Elevator FSM Log End  ===============" );
        }
        
        self [[ level.elevatorsfuncs[ self.group ][ self.state ] ]]();
    }
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x91af6ff0, Offset: 0x2222
// Size: 0xc4
function elevatormove()
{
    duration = self.targetfloor - self.currentfloor;
    duration = duration >= 0 ? duration : self.currentfloor - self.targetfloor;
    
    if ( duration != 0 )
    {
        function_d13265114e773ac6( "reinforcement_closed" );
        self.car moveto( ( self.car.origin[ 0 ], self.car.origin[ 1 ], self.floors[ self.targetfloor ].targetheight ), duration );
        wait duration;
        waitframe();
    }
    
    self.currentfloor = self.targetfloor;
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x9fe1b8d1, Offset: 0x22ee
// Size: 0x192
function elevatordooropen()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "open", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x23c>" + self.elevator.id + "<dev string:x254>" + self.elevator.currentfloor + "<dev string:x264>" + self.elevator.targetfloor + "<dev string:x273>" + self.doors[ 0 ].state + "<dev string:x27c>" + self.doors[ 1 ].state );
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0xda52cbad, Offset: 0x2488
// Size: 0x192
function elevatordoorclose()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "closed", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x27e>" + self.elevator.id + "<dev string:x254>" + self.elevator.currentfloor + "<dev string:x264>" + self.elevator.targetfloor + "<dev string:x273>" + self.doors[ 0 ].state + "<dev string:x27c>" + self.doors[ 1 ].state );
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0xe0cc16d4, Offset: 0x2622
// Size: 0x1b6
function function_50dd027d9d8adf91()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "reinforcement_open", 0 );
    }
    
    if ( self.navobstacle )
    {
        destroynavobstacle( self.navobstacle );
        self.navobstacle = undefined;
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x297>" + self.elevator.id + "<dev string:x254>" + self.elevator.currentfloor + "<dev string:x264>" + self.elevator.targetfloor + "<dev string:x273>" + self.doors[ 0 ].state + "<dev string:x27c>" + self.doors[ 1 ].state );
}

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0xbb99f7d2, Offset: 0x27e0
// Size: 0x1fc
function function_8734cd9afdd343db()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "reinforcement_closed", 0 );
    }
    
    midpoint = ( self.doors[ 0 ].origin + self.doors[ 1 ].origin ) / 2;
    
    if ( !isdefined( self.navobstacle ) )
    {
        self.navobstacle = createnavobstaclebybounds( midpoint, ( 5, 86, 10 ), self.angles );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x2b9>" + self.elevator.id + "<dev string:x254>" + self.elevator.currentfloor + "<dev string:x264>" + self.elevator.targetfloor + "<dev string:x273>" + self.doors[ 0 ].state + "<dev string:x27c>" + self.doors[ 1 ].state );
}

// Namespace dmz_bio_lab_elevators
// Params 1
// Checksum 0x31261de0, Offset: 0x29e4
// Size: 0xfb
function function_d13265114e773ac6( closestate )
{
    foreach ( floor in self.floors )
    {
        foreach ( door in floor.doors )
        {
            door setscriptablepartstate( "door", closestate, 0 );
        }
    }
}

#using_animtree( "script_model" );

// Namespace dmz_bio_lab_elevators
// Params 0
// Checksum 0x21b308ee, Offset: 0x2ae7
// Size: 0xa2
function scriptmodelanims()
{
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "close" ] = %iw9_elevator_int_door_close;
    level.scr_eventanim[ "elevator" ][ "close" ] = %"iw9_elevator_int_door_close";
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "open" ] = %iw9_elevator_int_door_open;
    level.scr_eventanim[ "elevator" ][ "open" ] = %"iw9_elevator_int_door_open";
}

/#

    // Namespace dmz_bio_lab_elevators
    // Params 0
    // Checksum 0x391f667, Offset: 0x2b91
    // Size: 0x34, Type: dev
    function function_7d4c29e3e8666e2f()
    {
        level waittill( #"player_spawned" );
        level thread function_551c50899ddf7017( @"hash_b4957f27fef0ad51" );
        level thread function_94c34470c2302e71( @"hash_7f3c55bc1b0ba1dd" );
    }

    // Namespace dmz_bio_lab_elevators
    // Params 1
    // Checksum 0x26083bba, Offset: 0x2bcd
    // Size: 0x2b0, Type: dev
    function function_551c50899ddf7017( dvarname )
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( dvarname, 0 );
        var_5b016312a58b05b7 = [ "<dev string:x208>", "<dev string:x2dc>", "<dev string:x2f9>", "<dev string:x31a>" ];
        var_909223bc0d1b4b94 = [];
        var_909223bc0d1b4b94[ "<dev string:x208>" ] = ( 0, 1, 0 );
        var_909223bc0d1b4b94[ "<dev string:x2dc>" ] = ( 1, 0, 0 );
        var_909223bc0d1b4b94[ "<dev string:x2f9>" ] = ( 1, 1, 0 );
        var_909223bc0d1b4b94[ "<dev string:x31a>" ] = ( 0, 0, 1 );
        const_debug_radius = 64;
        
        while ( true )
        {
            shoulddraw = getdvarint( dvarname );
            
            if ( shoulddraw == 1 )
            {
                foreach ( group in var_5b016312a58b05b7 )
                {
                    if ( isdefined( level.elevators[ group ] ) )
                    {
                        foreach ( elevator in level.elevators[ group ] )
                        {
                            foreach ( floor in elevator.floors )
                            {
                                sphere( floor.origin, const_debug_radius, var_909223bc0d1b4b94[ group ] );
                            }
                            
                            sphere( elevator.car.origin, 16, ( 1, 0, 1 ) );
                            debugstar( elevator.car.origin, ( 1, 0, 1 ), 1, elevator.id, 0.8 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dmz_bio_lab_elevators
    // Params 1
    // Checksum 0x1bd0553b, Offset: 0x2e85
    // Size: 0xea, Type: dev
    function function_94c34470c2302e71( dvarname )
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( dvarname, 0 );
        const_debug_radius = 32;
        var_b12af8e99b1f949e = ( 1, 1, 1 );
        
        while ( true )
        {
            shoulddraw = getdvarint( dvarname );
            
            if ( shoulddraw == 1 )
            {
                foreach ( list in level.var_f1252bbeb6fa49bd )
                {
                    sphere( list.origin, const_debug_radius, var_b12af8e99b1f949e );
                }
            }
            
            waitframe();
        }
    }

#/
