// scripts\common\elevators.gsc  (hash_5f903436642211af.gscc) (size: 30349 Bytes / 0x768d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae05dd70 (2919619952)
// size ...... 30349 (0x768d)
// includes .. 5   (offset: 0x6f2d)
// strings ... 70  (offset: 0x6f55)
// dev strs .. 6   (offset: 0x754d)
// exports ... 48  (offset: 0x5889)
// cseg ...... 0x8ad + 0x4fdc (0x5889)
// imports ... 115 (offset: 0x6009)
// animtree1 . 1   (offset: 0x7595)
// animtree2 . 12  (offset: 0x75cd)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace elevators;

// Namespace elevators
// Params 0, eflags: 0x1
// Checksum 0xda2c138f, Offset: 0x8cb
// Size: 0x19
function autoexec initelevators()
{
    if ( !game[ "isLaunchChunk" ] )
    {
        scriptable::scriptable_addpostinitcallback( &initelevatorscallback );
    }
}

// Namespace elevators
// Params 0, eflags: 0x4
// Checksum 0x2993f898, Offset: 0x8ec
// Size: 0x2d2
function private initelevatorscallback()
{
    if ( utility::flag( "elevators_init" ) )
    {
        return;
    }
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    scriptable::scriptable_addusedcallbackbypart( "button", &elevatorbuttonpressed );
    scriptable::scriptable_addusedcallbackbypart( "elevator_ext_button", &elevatorextbuttonpressed );
    scriptable::scriptable_addusedcallbackbypart( "elevator_int_button", &function_420790e08011157d );
    scriptable::scriptable_addusedcallbackbypart( "elevator_int_button_double", &function_420790e08011157d );
    level.elevatorsfuncs = [];
    level.elevatorsfuncs[ "waiting" ] = &function_ff6cd63892ae04a;
    level.elevatorsfuncs[ "doors_open" ] = &function_48f521fade03e66c;
    level.elevatorsfuncs[ "doors_closing" ] = &function_92764d22f13ac58b;
    level.elevatorsfuncs[ "moving" ] = &fsm_elevatormove;
    level.elevators = [];
    level.elevatorstops = [];
    level.elevatoronspawnplayer = &elevatoronspawnplayer;
    script_model_anims( "default" );
    elevatorstops = getentitylessscriptablearray( "elevator_stop", #script_noteworthy );
    
    foreach ( stop in elevatorstops )
    {
        initelevatorstop( stop );
    }
    
    elevatorcars = utility::getstructarray( "elevator_car", "script_noteworthy" );
    
    foreach ( elevatorset in level.elevatorstops )
    {
        if ( elevatorset.size != 2 || issubstr( elevatorset[ 0 ].classname, "reinforcement" ) || issubstr( elevatorset[ 1 ].classname, "reinforcement" ) )
        {
            continue;
        }
        
        elevator = initelevatorset( elevatorset, elevatorcars );
        
        if ( isdefined( elevator ) )
        {
            elevator thread function_e3c2c3f76756d496();
        }
    }
    
    utility::registersharedfunc( #"game", #"isentitytouchingdoortrigger", &isentitytouchingdoortrigger );
    utility::registersharedfunc( #"elevators", #"setpowered", &function_35d2ebf801a5dd25 );
    utility::registersharedfunc( #"elevators", #"hash_9ad183473a6eb9c0", &function_40bade5d1dab2640 );
    utility::flag_set( "elevators_init" );
}

// Namespace elevators
// Params 1
// Checksum 0x608cefaf, Offset: 0xbc6
// Size: 0x3a8
function initelevatorstop( stop )
{
    stop.open = 0;
    [ stop.indicator ] = getentitylessscriptablearray( stop.target, #targetname );
    stop.doors = getentitylessscriptablearray( stop.indicator.target, #targetname );
    stop.entsblocking = [];
    
    if ( stop.doors.size > 0 )
    {
        s_anchor = undefined;
        
        if ( isdefined( stop.doors[ 0 ].target ) )
        {
            s_anchor = utility::getstruct( stop.doors[ 0 ].target, "targetname" );
        }
        
        assert( stop.doors.size <= 2, "<dev string:x24>" );
        
        foreach ( door in stop.doors )
        {
            door.open = 0;
        }
        
        if ( stop.doors.size == 1 )
        {
            stop.doormidpoint = stop.doors[ 0 ].origin;
        }
        else
        {
            stop.doormidpoint = averagepoint( [ stop.doors[ 0 ].origin, stop.doors[ 1 ].origin ] );
        }
    }
    else
    {
        if ( isdefined( stop.target ) )
        {
            s_anchor = utility::getstruct( stop.target, "targetname" );
        }
        
        if ( !isdefined( s_anchor ) )
        {
            s_anchor = stop;
        }
        
        stop.doormidpoint = s_anchor.origin;
    }
    
    if ( isdefined( s_anchor ) )
    {
        stop.posstring = s_anchor.origin[ 0 ] + "," + s_anchor.origin[ 1 ];
    }
    else
    {
        stop.posstring = stop.doormidpoint[ 0 ] + "," + stop.doormidpoint[ 1 ];
    }
    
    if ( !isdefined( level.elevatorstops[ stop.posstring ] ) )
    {
        level.elevatorstops[ stop.posstring ] = [];
    }
    
    level.elevatorstops[ stop.posstring ][ level.elevatorstops[ stop.posstring ].size ] = stop;
    stop.playerblocked = 0;
    
    if ( isdefined( stop.doors[ 0 ].target ) )
    {
        if ( isdefined( s_anchor ) )
        {
            noenttrigger = getnoentvolumearray( s_anchor.target, #targetname );
        }
        else
        {
            noenttrigger = getnoentvolumearray( stop.doors[ 0 ].target, #targetname );
        }
        
        stop.trigger = noenttrigger[ 0 ];
        
        if ( isdefined( stop.trigger ) )
        {
            stop thread elevatortriggerfunc();
        }
    }
}

// Namespace elevators
// Params 0
// Checksum 0x936be88d, Offset: 0xf76
// Size: 0x9
function elevatoronspawnplayer()
{
    thread onspawnfinished();
}

// Namespace elevators
// Params 1, eflags: 0x4
// Checksum 0x419a5bb1, Offset: 0xf87
// Size: 0x70, Type: bool
function private is_damageable_equipment( equipment_ent )
{
    if ( isdefined( equipment_ent.equipmentref ) )
    {
        switch ( equipment_ent.equipmentref )
        {
            case #"hash_4a85ee2b82965fe2":
            case #"hash_aa60ec2aec479ec8":
            case #"hash_c848458cca24d656":
            case #"hash_eb1d3d54e9981d38":
                return true;
            default:
                return false;
        }
    }
    
    return false;
}

// Namespace elevators
// Params 0
// Checksum 0x68974edf, Offset: 0x1000
// Size: 0x38f
function crush_watcher()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    touchingradiuscheck = 200;
    var_65df8a86a3e1373d = 10000;
    crusher = self.parent;
    var_64bac4f6d602b39 = 12;
    direction_vec = ( 0, 0, 0 );
    point = ( 0, 0, 0 );
    angles = ( 0, 0, 0 );
    normal = ( 0, 0, 0 );
    modelname = "";
    tagname = "";
    partname = "";
    idflags = undefined;
    
    while ( true )
    {
        if ( crusher.moving == #"moving_down" )
        {
            entarray = getentarrayinradius( undefined, undefined, self.origin, touchingradiuscheck );
            touching = self getistouchingentities( entarray );
            
            foreach ( touchent in touching )
            {
                if ( isalive( touchent ) && isplayer( touchent ) )
                {
                    attacker = isdefined( crusher.lastplayerused ) && crusher.lastplayerused.team != touchent.team ? crusher.lastplayerused : self;
                    touchent.nocorpse = 1;
                    touchent kill( self.origin, attacker, self, "MOD_CRUSH" );
                }
                
                damageable = is_damageable_equipment( touchent );
                
                if ( !isalive( touchent ) && !touchent getcandamage() && !damageable )
                {
                    continue;
                }
                
                if ( touchent.origin[ 2 ] > crusher.origin[ 2 ] - var_64bac4f6d602b39 && !damageable )
                {
                    continue;
                }
                
                touchent.nocorpse = 1;
                
                if ( isdefined( level.taccover_destroy ) && touchent.equipmentref == "equip_tac_cover" )
                {
                    touchent [[ level.taccover_destroy ]]( 1, 1, 1 );
                    continue;
                }
                
                if ( touchent.classname == "script_vehicle" )
                {
                    touchent.dontspawnhusk = 1;
                    touchent dodamage( touchent.health + var_65df8a86a3e1373d, self.origin, self, self, "MOD_CRUSH" );
                    continue;
                }
                
                if ( touchent getcandamage() && touchent.health <= 0 )
                {
                    touchent notify( #"detonateexplosive" );
                    touchent notify( #"damage", touchent.health + var_65df8a86a3e1373d, undefined, direction_vec, point, "MOD_CRUSH", modelname, tagname, partname, idflags, undefined, self.origin, angles, normal, undefined );
                    continue;
                }
                
                touchent kill( self.origin, self, self, "MOD_CRUSH" );
            }
        }
        
        wait 0.1;
    }
}

// Namespace elevators
// Params 4
// Checksum 0xe6a57684, Offset: 0x1397
// Size: 0xefe
function initelevatorset( elevatorset, elevatorcars, overridemodel, canmove = 1 )
{
    elevator = spawnstruct();
    elevator.parts = [];
    elevator.floors = [];
    elevator.state = "doors_open";
    
    if ( elevatorset.size > 1 )
    {
        groundfloorindex = elevatorset[ 0 ].origin[ 2 ] < elevatorset[ 1 ].origin[ 2 ] ? 0 : 1;
    }
    else
    {
        groundfloorindex = 0;
    }
    
    foreach ( stop in elevatorset )
    {
        stop.elevator = elevator;
    }
    
    checkorigin = elevatorset[ groundfloorindex ].origin;
    mindist = undefined;
    targetcar = undefined;
    var_780fd90363a84465 = undefined;
    
    foreach ( car in elevatorcars )
    {
        if ( !isdefined( mindist ) )
        {
            mindist = distancesquared( car.origin, checkorigin );
            targetcar = car;
            var_780fd90363a84465 = car.targetname;
            continue;
        }
        
        dist = distancesquared( car.origin, checkorigin );
        
        if ( dist < mindist )
        {
            mindist = dist;
            targetcar = car;
            var_780fd90363a84465 = car.targetname;
        }
    }
    
    if ( !canmove )
    {
        elevator.targetcar = targetcar;
        level.elevators[ level.elevators.size ] = elevator;
        return elevator;
    }
    
    car = spawn( "script_model", targetcar.origin );
    car.angles = targetcar.angles;
    car.var_780fd90363a84465 = targetcar.targetname;
    car.str_model_name = targetcar.script_modelname;
    car.var_e7738fea56c3b3b9 = targetcar.var_ea865ed38d480b1e;
    car.var_4e25393fac8f541c = targetcar.var_a56fc80ec1e8e888;
    car.str_script_noteworthy = targetcar.script_noteworthy;
    car.var_87038cec80bd2c66 = 0;
    
    if ( isdefined( targetcar.target ) )
    {
        var_62fbe270e95f35a8 = getentarray( targetcar.target, #targetname );
        
        foreach ( crusherent in var_62fbe270e95f35a8 )
        {
            if ( crusherent.classname == "trigger_multiple" )
            {
                crusherent enablelinkto();
                crusherent linkto( car );
                crusherent.parent = car;
                crusherent.iscrusher = 1;
                crusherent thread crush_watcher();
            }
        }
    }
    
    accelerationtime = level.elevatoracceltime ?? 2;
    decelerationtime = level.elevatordeceltime ?? 2;
    
    if ( isdefined( targetcar.script_parameters ) )
    {
        var_fb3a9a50c517657e = strtok( targetcar.script_parameters, "," );
        car.n_travel_time = float( var_fb3a9a50c517657e[ 0 ] );
        
        if ( var_fb3a9a50c517657e.size >= 3 )
        {
            car.n_accel_time = level.elevatoracceltime ?? float( var_fb3a9a50c517657e[ 1 ] );
            car.n_decel_time = level.elevatordeceltime ?? float( var_fb3a9a50c517657e[ 2 ] );
        }
        else if ( var_fb3a9a50c517657e.size == 2 )
        {
            car.n_accel_time = level.elevatoracceltime ?? float( var_fb3a9a50c517657e[ 1 ] );
            car.n_decel_time = car.n_accel_time;
        }
        else if ( car.n_travel_time >= accelerationtime + decelerationtime )
        {
            car.n_accel_time = accelerationtime;
            car.n_decel_time = decelerationtime;
        }
        else
        {
            car.n_accel_time = 0;
            car.n_decel_time = 0;
        }
    }
    else
    {
        car.n_accel_time = accelerationtime;
        car.n_decel_time = decelerationtime;
    }
    
    if ( isdefined( targetcar.script_cost ) )
    {
        elevator.script_cost = targetcar.script_cost;
    }
    
    if ( !isdefined( car.var_780fd90363a84465 ) )
    {
        car.var_780fd90363a84465 = "default";
    }
    
    switch ( car.var_780fd90363a84465 )
    {
        case #"hash_dfb267e42bb20045":
            var_a590de25156f75dd = "t10_ava_building_elevator_double_set_int";
            car.animname = "elevator_double";
            car.var_170a141d7afa9404 = 1;
            break;
        case #"hash_5971965ed985a26c":
            var_a590de25156f75dd = "t10_machinery_elevator_passenger_small_single_door_01";
            car.animname = "elevator_small";
            car.var_170a141d7afa9404 = 0;
            break;
        case #"hash_6bf513acc2adb471":
            var_a590de25156f75dd = "t10_machinery_elevator_passenger_small_double_door_01";
            car.animname = "elevator_small_double";
            car.var_170a141d7afa9404 = 1;
            break;
        case #"hash_acc660ae6a3e8212":
            car.animname = undefined;
            car.var_170a141d7afa9404 = 0;
            break;
        case #"hash_75d772636fdb045a":
            var_a590de25156f75dd = overridemodel ?? "machinery_elevator_modern_02";
            car.animname = "elevator";
            car.lightingoverride = "rex_casino";
            car.var_170a141d7afa9404 = 0;
            break;
        case #"hash_705e7ec64c35c373":
            var_a590de25156f75dd = overridemodel ?? "machinery_elevator_modern_03";
            car.animname = "elevator";
            car.var_170a141d7afa9404 = 0;
            break;
        case #"hash_46988c88fcf0035b":
        case #"hash_f4b0251c9c32089e":
            var_a590de25156f75dd = overridemodel ?? "machinery_elevator_modern_01";
            car.animname = "elevator";
            car.var_170a141d7afa9404 = 0;
            break;
        default:
            var_a590de25156f75dd = overridemodel ?? "building_saba_elevator_set_int";
            car.animname = "elevator";
            car.var_170a141d7afa9404 = 0;
            break;
        case #"hash_53637054d352617f":
            var_a590de25156f75dd = overridemodel ?? "t10_machinery_cargo_lift_02";
            car.animname = "elevator";
            car.var_170a141d7afa9404 = 0;
            break;
    }
    
    if ( !isdefined( car.str_model_name ) )
    {
        car.str_model_name = var_a590de25156f75dd;
    }
    
    if ( isdefined( car.var_4e25393fac8f541c ) )
    {
        car.str_model_name = car.var_4e25393fac8f541c + "::" + car.str_model_name;
    }
    
    car setmodel( car.str_model_name );
    
    if ( isdefined( car.animname ) )
    {
        car animation::setanimtree();
    }
    
    assert( car isscriptable(), "<dev string:x4d>" );
    
    if ( !car isscriptable() )
    {
        return;
    }
    
    if ( car getscriptablehaspart( "lights" ) )
    {
        if ( isdefined( car.lightingoverride ) )
        {
            car setscriptablepartstate( "lights", car.lightingoverride );
        }
        else
        {
            car setscriptablepartstate( "lights", "on" );
        }
    }
    
    if ( car getscriptablehaspart( "elevator_music" ) )
    {
        car setscriptablepartstate( "elevator_music", car.var_e7738fea56c3b3b9 ?? "default" );
    }
    
    car.elevator = elevator;
    car.occupants = [];
    car.var_3777892fe6150c9b = 0;
    
    if ( car.model == "t10_ava_building_elevator_double_set_int_redcard" )
    {
        x_1 = -84;
        x_2 = 76;
        y_1 = -88;
        y_2 = 88;
        car.carheight = 144;
        car.corner_a = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_1, 0 ), car.angles[ 1 ] );
        car.corner_b = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_2, 0 ), car.angles[ 1 ] );
        car.corner_c = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_2, 0 ), car.angles[ 1 ] );
        car.corner_d = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_1, 0 ), car.angles[ 1 ] );
        car.var_3777892fe6150c9b = 1;
    }
    
    if ( !car.var_3777892fe6150c9b && isdefined( targetcar.target ) )
    {
        corner_a = utility::getstruct( targetcar.target, "targetname" );
        
        if ( isdefined( corner_a ) )
        {
            corner_b = utility::getstruct( corner_a.target, "targetname" );
            
            if ( isdefined( corner_b ) )
            {
                corner_c = utility::getstruct( corner_b.target, "targetname" );
                
                if ( isdefined( corner_c ) )
                {
                    corner_d = utility::getstruct( corner_c.target, "targetname" );
                    
                    if ( isdefined( corner_d ) )
                    {
                        car.carheight = 144;
                        car.corner_a = corner_a.origin;
                        car.corner_b = corner_b.origin;
                        car.corner_c = corner_c.origin;
                        car.corner_d = corner_d.origin;
                        car.var_3777892fe6150c9b = 1;
                    }
                }
            }
        }
    }
    
    if ( !car.var_3777892fe6150c9b && car.model == "building_saba_elevator_set_int" )
    {
        x_1 = -84;
        x_2 = 76;
        y_1 = -88;
        y_2 = 88;
        car.carheight = 144;
        car.corner_a = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_1, 0 ), car.angles[ 1 ] );
        car.corner_b = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_2, 0 ), car.angles[ 1 ] );
        car.corner_c = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_2, 0 ), car.angles[ 1 ] );
        car.corner_d = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_1, 0 ), car.angles[ 1 ] );
        car.var_3777892fe6150c9b = 1;
    }
    
    if ( !car.var_3777892fe6150c9b && car.model == "t10_machinery_elevator_passenger_small_single_door_01" )
    {
        x_1 = -84;
        x_2 = 76;
        y_1 = -88;
        y_2 = 88;
        car.carheight = 144;
        car.corner_a = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_1, 0 ), car.angles[ 1 ] );
        car.corner_b = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_1, y_2, 0 ), car.angles[ 1 ] );
        car.corner_c = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_2, 0 ), car.angles[ 1 ] );
        car.corner_d = car.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( x_2, y_1, 0 ), car.angles[ 1 ] );
        car.var_3777892fe6150c9b = 1;
        elevator.skip_interacts_specific = 1;
    }
    
    var_c2631db7e1de83f7 = getnoentvolumearray( "elevator_occupancy_trig", #targetname );
    
    if ( var_c2631db7e1de83f7.size > 0 )
    {
        var_e1be176ee236696a = sortbydistance( var_c2631db7e1de83f7, car.origin );
        closestidx = 0;
        tolerance = 48;
        car.occupancytrig = undefined;
        
        while ( closestidx < var_e1be176ee236696a.size )
        {
            if ( distance2dsquared( car.origin, var_e1be176ee236696a[ closestidx ].origin ) < tolerance * tolerance )
            {
                car.occupancytrig = var_e1be176ee236696a[ closestidx ];
                break;
            }
            
            closestidx++;
        }
        
        car.var_3777892fe6150c9b = 1;
    }
    
    car namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    car setmoveroptimized( 1 );
    car setmoverantilagged( 1 );
    car markkeyframedmover();
    elevator.car = car;
    function_e56676ade9d13b46( elevator, elevatorset, groundfloorindex );
    level.elevators[ level.elevators.size ] = elevator;
    return elevator;
}

// Namespace elevators
// Params 3
// Checksum 0x5ee21ad3, Offset: 0x229e
// Size: 0x27a
function function_e56676ade9d13b46( elevator, elevatorset, groundfloorindex )
{
    elevator.currentfloor = 0;
    elevator.targetfloor = 0;
    bottomheight = undefined;
    topheight = undefined;
    
    if ( elevatorset.size > 1 )
    {
        var_bfa94fd25392ea66 = abs( elevatorset[ groundfloorindex ].doormidpoint[ 2 ] - elevator.car.origin[ 2 ] ) < abs( elevatorset[ groundfloorindex == 0 ? 1 : 0 ].doormidpoint[ 2 ] - elevator.car.origin[ 2 ] );
        topheightoffset = elevatorset[ groundfloorindex == 0 ? 1 : 0 ].doormidpoint[ 2 ] - elevatorset[ groundfloorindex ].doormidpoint[ 2 ];
        
        if ( !var_bfa94fd25392ea66 )
        {
            bottomheight = elevator.car.origin[ 2 ] - topheightoffset;
            topheight = elevator.car.origin[ 2 ];
            elevator.currentfloor = 1;
            elevator.targetfloor = 1;
        }
        else
        {
            bottomheight = elevator.car.origin[ 2 ];
            topheight = elevator.car.origin[ 2 ] + topheightoffset;
        }
    }
    
    elevator.floors[ 0 ] = elevatorset[ groundfloorindex ];
    elevator.floors[ 0 ].floornum = 0;
    elevator.floors[ 0 ].targetheight = bottomheight;
    
    if ( elevatorset.size > 1 )
    {
        elevator.floors[ 1 ] = elevatorset[ groundfloorindex == 0 ? 1 : 0 ];
        elevator.floors[ 1 ].floornum = 1;
        elevator.floors[ 1 ].targetheight = topheight;
    }
    
    elevator.defaultfloor = elevator.currentfloor;
    elevator.car.defaultorigin = elevator.car.origin;
}

// Namespace elevators
// Params 0
// Checksum 0xbc79d741, Offset: 0x2520
// Size: 0x2e
function onspawnfinished()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"giveloadout" );
    
    if ( self.ti_spawn )
    {
        isinsideelevator();
    }
}

// Namespace elevators
// Params 1
// Checksum 0xe713df11, Offset: 0x2556
// Size: 0x18a
function isentitytouchingdoortrigger( ent )
{
    if ( !isent( ent ) )
    {
        return;
    }
    
    if ( isarray( self ) )
    {
        foreach ( elevator in self )
        {
            elevator thread isentitytouchingdoortrigger( ent );
        }
        
        return;
    }
    
    level endon( #"game_ended" );
    ent endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( ent ) )
        {
            if ( isdefined( self.floors[ self.currentfloor ].trigger ) )
            {
                self waittill( #"hash_ce4e01077f844492" );
                
                if ( !isdefined( ent ) )
                {
                    return;
                }
                
                if ( self.state == "moving" )
                {
                    if ( ispointinvolume( ent.origin, self.floors[ self.targetfloor ].trigger ) )
                    {
                        ent thread [[ ent.elevatordoorsclosecallback ]]();
                    }
                }
                
                if ( ispointinvolume( ent.origin, self.floors[ self.currentfloor ].trigger ) )
                {
                    ent thread [[ ent.elevatordoorsclosecallback ]]();
                }
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace elevators
// Params 1
// Checksum 0x66b7481b, Offset: 0x26e8
// Size: 0x24f
function function_b3983cdb994ef3a( ent )
{
    if ( !isent( ent ) )
    {
        return;
    }
    
    if ( isarray( self ) )
    {
        foreach ( elevator in self )
        {
            elevator thread function_b3983cdb994ef3a( ent );
        }
        
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    ent endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( ent ) )
        {
            if ( isdefined( self.floors[ self.currentfloor ].trigger ) )
            {
                self waittill( #"elevator_doors_closing" );
                
                if ( !isdefined( ent ) )
                {
                    return;
                }
                
                if ( ispointinvolume( ent.origin, self.floors[ self.currentfloor ].trigger ) )
                {
                    self.floors[ self.currentfloor ].playerblocked = 1;
                    self.floors[ self.currentfloor ] notify( #"player_blocked" );
                    self.floors[ self.currentfloor ] thread function_8b424b50d0e0a025();
                    wait 0.5;
                    
                    while ( self.floors[ self.currentfloor ].playerblocked == 1 )
                    {
                        if ( !isdefined( ent ) )
                        {
                            return;
                        }
                        
                        if ( ispointinvolume( ent.origin, self.floors[ self.currentfloor ].trigger ) )
                        {
                            self.floors[ self.currentfloor ].playerblocked = 1;
                            self.floors[ self.currentfloor ] notify( #"player_blocked" );
                            self.floors[ self.currentfloor ] thread function_8b424b50d0e0a025();
                        }
                        
                        wait 0.5;
                    }
                }
            }
            else
            {
                break;
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace elevators
// Params 1
// Checksum 0xb72c19, Offset: 0x293f
// Size: 0x18a
function deployablecover_isentitytouchingdoortrigger( ent )
{
    if ( !isent( ent ) )
    {
        return;
    }
    
    if ( isarray( self ) )
    {
        foreach ( elevator in self )
        {
            elevator thread deployablecover_isentitytouchingdoortrigger( ent );
        }
        
        return;
    }
    
    level endon( #"game_ended" );
    ent endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( ent ) )
        {
            if ( isdefined( self.floors[ self.currentfloor ].trigger ) )
            {
                self waittill( #"hash_ce4e01077f844492" );
                
                if ( !isdefined( ent ) )
                {
                    return;
                }
                
                if ( self.state == "moving" )
                {
                    if ( ent.collision istouching( self.floors[ self.targetfloor ].trigger ) )
                    {
                        ent thread [[ ent.elevatordoorsclosecallback ]]();
                    }
                }
                
                if ( ent.collision istouching( self.floors[ self.currentfloor ].trigger ) )
                {
                    ent thread [[ ent.elevatordoorsclosecallback ]]();
                }
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
        
        wait 1;
    }
}

// Namespace elevators
// Params 0
// Checksum 0x16a92219, Offset: 0x2ad1
// Size: 0xcd
function elevatortriggerfunc()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", enttriggered );
        
        if ( self.elevator.car.var_3777892fe6150c9b )
        {
            childthread elevatoroccupancytracking( enttriggered, self.elevator.car );
        }
        
        if ( isplayer( enttriggered ) || isdefined( enttriggered.helperdronetype ) || enttriggered vehicle::is_vehicle() || isagent( enttriggered ) )
        {
            self.playerblocked = 1;
            self notify( #"player_blocked" );
            thread function_8b424b50d0e0a025();
        }
        
        waitframe();
    }
}

// Namespace elevators
// Params 1
// Checksum 0xa259782e, Offset: 0x2ba6
// Size: 0x72
function function_780e7ebf75e3cdc3( var_a4a41ad797db25a2 )
{
    level endon( #"game_ended" );
    
    if ( self.elevator.car.var_3777892fe6150c9b )
    {
        childthread elevatoroccupancytracking( var_a4a41ad797db25a2, self.elevator.car );
    }
    
    self.playerblocked = 1;
    self notify( #"player_blocked" );
    thread function_8b424b50d0e0a025();
}

// Namespace elevators
// Params 0
// Checksum 0x38078f3d, Offset: 0x2c20
// Size: 0x2f
function function_8b424b50d0e0a025()
{
    self endon( #"player_blocked" );
    wait 0.7;
    
    if ( isdefined( self ) )
    {
        self.playerblocked = 0;
        self notify( #"player_unblocked" );
    }
}

// Namespace elevators
// Params 1
// Checksum 0x85307863, Offset: 0x2c57
// Size: 0xba
function function_3e0df752cc08a493( origin )
{
    if ( !isdefined( level.elevators ) )
    {
        return;
    }
    
    elevatorcars = [];
    
    foreach ( elevator in level.elevators )
    {
        elevatorcars[ elevatorcars.size ] = elevator.car;
    }
    
    car = function_47c86977a18df38b( elevatorcars, origin );
    return car;
}

// Namespace elevators
// Params 0
// Checksum 0x35720720, Offset: 0x2d1a
// Size: 0xc
function function_e3c2c3f76756d496()
{
    wait 1;
    thread function_138839dad5d52039();
}

// Namespace elevators
// Params 6
// Checksum 0xb23d5403, Offset: 0x2d2e
// Size: 0x200
function elevatorextbuttonpressed( instance, part, state, player, bautouse, usestring )
{
    if ( instance.elevator.elevator_nopower )
    {
        return;
    }
    
    if ( isdefined( instance.floornum ) )
    {
        if ( instance.elevator.currentfloor == instance.floornum )
        {
            instance.elevator.state = "doors_open";
        }
        else
        {
            instance.elevator.targetfloor = instance.floornum;
        }
        
        instance.elevator notify( #"stop_waiting" );
        instance.elevator.car.lastplayerused = player;
        instance.elevator.car setscriptablepartstate( "elevator_int_button", "not_usable", 0 );
        instance.elevator.floors[ instance.elevator.targetfloor ] setscriptablepartstate( "elevator_ext_button", "disabled" );
        
        if ( instance.elevator.currentfloor > instance.elevator.targetfloor )
        {
            instance.elevator.floors[ instance.elevator.targetfloor ] setscriptablepartstate( "elevator_button_lights", "up" );
            return;
        }
        
        instance.elevator.floors[ instance.elevator.targetfloor ] setscriptablepartstate( "elevator_button_lights", "down" );
    }
}

// Namespace elevators
// Params 6
// Checksum 0x3d6f6894, Offset: 0x2f36
// Size: 0x110
function function_420790e08011157d( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance.elevator ) )
    {
        elevator = instance.elevator;
    }
    else
    {
        elevator = instance.entity.elevator;
    }
    
    if ( elevator.elevator_nopower )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player playsound( "mp_elevator_button_press" );
    }
    
    elevator.car.lastplayerused = player;
    elevator.targetfloor = elevator.currentfloor == 0 ? 1 : 0;
    elevator notify( #"stop_waiting" );
    instance.entity.elevator.car setscriptablepartstate( "elevator_int_button", "not_usable", 0 );
}

// Namespace elevators
// Params 0
// Checksum 0xade49a06, Offset: 0x304e
// Size: 0xa6
function function_edc2ec8d917b841d()
{
    foreach ( part in self.parts )
    {
        if ( isdefined( part.info ) )
        {
            part.owner = self;
            self.floors[ part.floornum ] = part;
        }
    }
}

// Namespace elevators
// Params 6
// Checksum 0xcadcb80f, Offset: 0x30fc
// Size: 0x12e
function elevatorbuttonpressed( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance.floornum ) )
    {
        instance.elevator.car.lastplayerused = player;
        
        if ( instance.floornum == 0 )
        {
            instance.owner.targetfloor = instance.owner.currentfloor == 1 ? 2 : 1;
        }
        else if ( instance.owner.currentfloor == instance.floornum )
        {
            instance.owner.state = "doors_open";
        }
        else
        {
            instance.owner.targetfloor = instance.floornum;
        }
        
        instance.owner notify( #"stop_waiting" );
    }
}

// Namespace elevators
// Params 1
// Checksum 0x53dedb1e, Offset: 0x3232
// Size: 0xf4
function elevatordooropen( immediate )
{
    self.open = 1;
    
    foreach ( door in self.doors )
    {
        door.open = 1;
        
        if ( !immediate )
        {
            door setscriptablepartstate( "door", "open", 0 );
        }
    }
    
    if ( isdefined( self.indicator ) )
    {
        self.indicator setscriptablepartstate( "model", "arrived" );
    }
    
    self.elevator.car setscriptablepartstate( "door_sounds", "open" );
}

// Namespace elevators
// Params 1
// Checksum 0x6e547c3f, Offset: 0x332e
// Size: 0xe1
function elevatordoorclose( immediate )
{
    self.elevator endon( #"emergency_block" );
    self.open = 0;
    
    foreach ( door in self.doors )
    {
        door.open = 0;
        
        if ( !immediate )
        {
            door setscriptablepartstate( "door", "closed", 0 );
        }
    }
    
    self.elevator.car setscriptablepartstate( "door_sounds", "close" );
}

// Namespace elevators
// Params 0
// Checksum 0x51780e38, Offset: 0x3417
// Size: 0x21
function function_138839dad5d52039()
{
    while ( true )
    {
        self [[ level.elevatorsfuncs[ self.state ] ]]();
    }
}

// Namespace elevators
// Params 0
// Checksum 0xc63a5c04, Offset: 0x3440
// Size: 0x85
function function_ff6cd63892ae04a()
{
    if ( self.targetfloor != self.currentfloor && !self.var_3a97986bed8eb12c )
    {
        if ( self.floors[ self.currentfloor ].open )
        {
            self.state = "doors_closing";
        }
        else
        {
            self.state = "moving";
        }
        
        return;
    }
    
    while ( self.var_3a97986bed8eb12c )
    {
        waitframe();
    }
    
    self waittill( #"stop_waiting" );
}

// Namespace elevators
// Params 0
// Checksum 0xac6d5d58, Offset: 0x34cd
// Size: 0x249
function function_48f521fade03e66c()
{
    if ( self.var_280333f822f09d9 )
    {
        self waittill( #"hold_released" );
    }
    
    self.floors[ self.currentfloor ] setscriptablepartstate( "elevator_ext_button", "disabled" );
    self.floors[ self.currentfloor ] setscriptablepartstate( "elevator_button_lights", "off" );
    targetfloor = undefined;
    
    foreach ( otherfloor in self.floors )
    {
        if ( otherfloor.floornum != self.currentfloor )
        {
            targetfloor = otherfloor;
        }
    }
    
    if ( isdefined( targetfloor ) )
    {
        var_352bbf468064c385 = self.car.origin[ 2 ] >= targetfloor.origin[ 2 ];
        
        if ( !self.skip_interacts )
        {
            function_e1c456a9df1b3cb5( var_352bbf468064c385 );
        }
    }
    
    self notify( #"hash_ce4e01077f844492" );
    
    if ( level.var_d17a5d47819f662e )
    {
        self.car setscriptablepartstate( "door_sounds", "open", 0 );
    }
    
    isplatform = self.car.var_780fd90363a84465 == "platform";
    self.floors[ self.currentfloor ] thread elevatordooropen( isplatform );
    
    if ( !isplatform )
    {
        if ( self.car.var_170a141d7afa9404 && self.currentfloor != 0 )
        {
            self.car animation::anim_single_solo( self.car, "open_back" );
        }
        else
        {
            self.car animation::anim_single_solo( self.car, "open" );
        }
        
        self.state = "waiting";
        wait 5;
    }
    else
    {
        self.state = "waiting";
    }
    
    self notify( #"elevator_doors_opened" );
}

// Namespace elevators
// Params 0
// Checksum 0x36ec33a1, Offset: 0x371e
// Size: 0x1ef
function function_92764d22f13ac58b()
{
    self endon( #"emergency_block" );
    self notify( #"elevator_doors_closing" );
    wait 0.01;
    
    if ( self.floors[ self.currentfloor ].playerblocked == 1 )
    {
        thread function_1bd312a8a822886d();
        self.floors[ self.currentfloor ] waittill( #"player_unblocked" );
    }
    
    self notify( #"hash_ce4e01077f844492" );
    thread function_91a694f66d5e4924();
    wait 0.01;
    
    if ( level.var_d17a5d47819f662e )
    {
        self.car setscriptablepartstate( "door_sounds", "close", 0 );
    }
    
    isplatform = self.car.var_780fd90363a84465 == "platform";
    self.floors[ self.currentfloor ] thread elevatordoorclose( isplatform );
    
    if ( !isplatform )
    {
        if ( self.car.var_170a141d7afa9404 && self.currentfloor != 0 )
        {
            str_anim = "close_back";
        }
        else
        {
            str_anim = "close";
        }
        
        self.car thread animation::anim_single_solo( self.car, str_anim );
        var_18857c6e1d249e6b = getanimlength( level.scr_anim[ self.car.animname ][ str_anim ] );
        self.car utility::waittill_notify_or_timeout( str_anim, var_18857c6e1d249e6b );
        waitframe();
        waitframe();
        waitframe();
        waitframe();
    }
    
    self notify( #"elevator_stop_block" );
    self notify( #"elevator_closed" );
    self.state = "waiting";
    
    if ( !self.skip_interacts && !self.var_3a97986bed8eb12c )
    {
        self.floors[ self.currentfloor ] setscriptablepartstate( "elevator_ext_button", "usable" );
    }
}

// Namespace elevators
// Params 0
// Checksum 0x644ddbc, Offset: 0x3915
// Size: 0x6d4
function fsm_elevatormove()
{
    for ( i = 0; i < self.floors.size ; i++ )
    {
        if ( isdefined( self.floors[ i ].indicator ) )
        {
            if ( self.floors[ i ].floornum == self.targetfloor )
            {
                if ( self.currentfloor > self.targetfloor )
                {
                    self.floors[ i ].indicator setscriptablepartstate( "model", "down" );
                }
                else
                {
                    self.floors[ i ].indicator setscriptablepartstate( "model", "up" );
                }
                
                continue;
            }
            
            if ( self.floors[ i ].floornum > self.targetfloor )
            {
                self.floors[ i ].indicator setscriptablepartstate( "model", "down" );
                continue;
            }
            
            self.floors[ i ].indicator setscriptablepartstate( "model", "up" );
        }
    }
    
    totalheight = abs( self.floors[ self.targetfloor ].targetheight - self.floors[ self.currentfloor ].targetheight );
    totalaccelerationtime = self.car.n_accel_time + self.car.n_decel_time;
    
    if ( isdefined( self.car.n_travel_time ) )
    {
        assert( self.car.n_travel_time >= totalaccelerationtime, "<dev string:x8e>" + totalaccelerationtime + "<dev string:xb5>" );
        
        if ( self.car.n_travel_time >= totalaccelerationtime )
        {
            duration = self.car.n_travel_time;
        }
    }
    
    if ( isdefined( level.elevatormaxspeed ) )
    {
        duration = max( totalheight / level.elevatormaxspeed, totalaccelerationtime + 0.25 );
    }
    else if ( !isdefined( duration ) )
    {
        duration = max( totalheight / 150, totalaccelerationtime + 0.25 );
    }
    
    if ( getdvarint( @"hash_f879271e42082780", 1 ) == 0 )
    {
        foreach ( ent in self.car.occupants )
        {
            if ( isplayer( ent ) && isalive( ent ) )
            {
                ent thread function_874852fee5ddec64( duration );
            }
        }
    }
    
    targetpos = ( self.car.origin[ 0 ], self.car.origin[ 1 ], self.floors[ self.targetfloor ].targetheight );
    self.car.moving = self.currentfloor > self.targetfloor ? #"moving_down" : #"moving_up";
    self.car setscriptablepartstate( "elevator_sounds", "on" );
    
    if ( level.gametype == "dmz" && getdvarint( @"hash_97fde43f16aa76c6", 0 ) == 1 )
    {
        vehicles = vehicle_getarrayinradius( self.car.origin, 512, 512 );
        
        foreach ( vehicle in vehicles )
        {
            vehicle vehphys_impulse( ( 0, 0, -1 ), 0 );
        }
        
        startpoint = self.car.origin;
        endposition = ( startpoint[ 0 ], startpoint[ 1 ], targetpos[ 2 ] );
        fraction = 0;
        
        while ( fraction < 1 )
        {
            previousorigin = self.car.origin;
            self.car.origin = vectorlerp( startpoint, endposition, fraction );
            fraction += level.framedurationseconds / duration;
            waitframe();
        }
    }
    else
    {
        vehicles = vehicle_getarrayinradius( self.car.origin, 512, 512 );
        
        foreach ( vehicle in vehicles )
        {
            vehicle vehphys_impulse( ( 0, 0, -1 ), 0 );
        }
        
        self.car moveto( targetpos, duration, self.car.n_accel_time, self.car.n_decel_time );
        wait duration;
    }
    
    self.car setscriptablepartstate( "elevator_sounds", "off" );
    wait 0.5;
    self.car.moving = #"moving_stopped";
    self.currentfloor = self.targetfloor;
    self.state = "doors_open";
    self notify( #"finished_elevator_move", targetpos );
    
    for ( i = 0; i < self.floors.size ; i++ )
    {
        if ( isdefined( self.floors[ i ].indicator ) )
        {
            if ( self.floors[ i ].floornum != self.currentfloor )
            {
                self.floors[ i ].indicator setscriptablepartstate( "model", "off" );
            }
        }
    }
}

// Namespace elevators
// Params 1
// Checksum 0x76a6871, Offset: 0x3ff1
// Size: 0xa2
function function_e1c456a9df1b3cb5( var_352bbf468064c385 )
{
    if ( self.elevator_nopower )
    {
        self.car setscriptablepartstate( "elevator_int_button", "usable_nopower", 0 );
        return;
    }
    
    if ( level.var_d17a5d47819f662e && !self.skip_interacts_specific )
    {
        if ( var_352bbf468064c385 )
        {
            self.car setscriptablepartstate( "elevator_int_button", "usable_descend", 0 );
        }
        else
        {
            self.car setscriptablepartstate( "elevator_int_button", "usable_ascend", 0 );
        }
        
        return;
    }
    
    self.car setscriptablepartstate( "elevator_int_button", "usable", 0 );
}

// Namespace elevators
// Params 1
// Checksum 0xebe44094, Offset: 0x409b
// Size: 0x30
function function_874852fee5ddec64( duration )
{
    self endon( #"death_or_disconnect" );
    self allowprone( 0 );
    wait duration + 0.5;
    self allowprone( 1 );
}

// Namespace elevators
// Params 0
// Checksum 0xbe3ca053, Offset: 0x40d3
// Size: 0x81
function function_91a694f66d5e4924()
{
    self endon( #"elevator_closed" );
    self endon( #"elevator_doors_closing" );
    self endon( #"elevator_stop_block" );
    
    while ( true )
    {
        if ( self.floors[ self.currentfloor ].playerblocked == 1 )
        {
            self notify( #"emergency_block" );
            self.state = "doors_open";
            wait 0.025;
            self.state = "doors_closing";
            return;
        }
        
        waitframe();
    }
}

// Namespace elevators
// Params 1
// Checksum 0xf4590911, Offset: 0x415c
// Size: 0x40
function function_308280f314f433fd( num )
{
    return self.floors[ num ].child.child.child.origin;
}

// Namespace elevators
// Params 0
// Checksum 0x7b035218, Offset: 0x41a5
// Size: 0x26
function function_fb31a5842582eba9()
{
    function_fbd176f8c36ec3d6( "elevator_button_floor_01" );
    function_fbd176f8c36ec3d6( "elevator_button_floor_02" );
    function_fbd176f8c36ec3d6( "elevator_button_00_inside" );
}

// Namespace elevators
// Params 1
// Checksum 0x35d80986, Offset: 0x41d3
// Size: 0x114
function function_fbd176f8c36ec3d6( str )
{
    oldpart = self.parts[ str ];
    buttonpos = oldpart.origin;
    buttonangles = oldpart.angles + ( 90, 0, 0 );
    button = spawnscriptable( "scriptable_test_button", buttonpos, buttonangles );
    button.parent = oldpart.parent;
    button.child = oldpart.child;
    button.originalpos = oldpart.originalpos;
    button.info = str;
    button.floornum = int( oldpart.script_label );
    
    if ( isdefined( oldpart.children ) )
    {
        button.children = oldpart.children;
    }
    
    self.parts[ str ] = button;
}

#using_animtree( "script_model" );

// Namespace elevators
// Params 1
// Checksum 0x3968f8b5, Offset: 0x42ef
// Size: 0x3cc
function script_model_anims( subtype )
{
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "close" ] = %iw9_elevator_int_door_close;
    level.scr_eventanim[ "elevator" ][ "close" ] = %"iw9_elevator_int_door_close";
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "open" ] = %iw9_elevator_int_door_open;
    level.scr_eventanim[ "elevator" ][ "open" ] = %"iw9_elevator_int_door_open";
    level.scr_animtree[ "elevator_double" ] = #animtree;
    level.scr_anim[ "elevator_double" ][ "close" ] = %t10_ava_building_elevator_double_int_door_close;
    level.scr_eventanim[ "elevator_double" ][ "close" ] = %"t10_ava_building_elevator_double_int_door_close";
    level.scr_animtree[ "elevator_double" ] = #animtree;
    level.scr_anim[ "elevator_double" ][ "open" ] = %t10_ava_building_elevator_double_int_door_open;
    level.scr_eventanim[ "elevator_double" ][ "open" ] = %"t10_ava_building_elevator_double_int_door_open";
    level.scr_animtree[ "elevator_double" ] = #animtree;
    level.scr_anim[ "elevator_double" ][ "close_back" ] = %t10_ava_building_elevator_double_int_back_door_close;
    level.scr_eventanim[ "elevator_double" ][ "close_back" ] = %"t10_ava_building_elevator_double_int_back_door_close";
    level.scr_animtree[ "elevator_double" ] = #animtree;
    level.scr_anim[ "elevator_double" ][ "open_back" ] = %t10_ava_building_elevator_double_int_back_door_open;
    level.scr_eventanim[ "elevator_double" ][ "open_back" ] = %"t10_ava_building_elevator_double_int_back_door_open";
    level.scr_animtree[ "elevator_small" ] = #animtree;
    level.scr_anim[ "elevator_small" ][ "close" ] = %t10_machinery_elevator_passenger_small_single_door_close;
    level.scr_eventanim[ "elevator_small" ][ "close" ] = %"t10_machinery_elevator_passenger_small_single_door_close";
    level.scr_animtree[ "elevator_small" ] = #animtree;
    level.scr_anim[ "elevator_small" ][ "open" ] = %t10_machinery_elevator_passenger_small_single_door_open;
    level.scr_eventanim[ "elevator_small" ][ "open" ] = %"t10_machinery_elevator_passenger_small_single_door_open";
    level.scr_animtree[ "elevator_small_double" ] = #animtree;
    level.scr_anim[ "elevator_small_double" ][ "close" ] = %t10_machinery_elevator_passenger_small_double_door_frnt_close;
    level.scr_eventanim[ "elevator_small_double" ][ "close" ] = %"t10_machinery_elevator_passenger_small_double_door_frnt_close";
    level.scr_animtree[ "elevator_small_double" ] = #animtree;
    level.scr_anim[ "elevator_small_double" ][ "open" ] = %t10_machinery_elevator_passenger_small_double_door_frnt_open;
    level.scr_eventanim[ "elevator_small_double" ][ "open" ] = %"t10_machinery_elevator_passenger_small_double_door_frnt_open";
    level.scr_animtree[ "elevator_small_double" ] = #animtree;
    level.scr_anim[ "elevator_small_double" ][ "close_back" ] = %t10_machinery_elevator_passenger_small_double_door_rear_close;
    level.scr_eventanim[ "elevator_small_double" ][ "close_back" ] = %"t10_machinery_elevator_passenger_small_double_door_rear_close";
    level.scr_animtree[ "elevator_small_double" ] = #animtree;
    level.scr_anim[ "elevator_small_double" ][ "open_back" ] = %t10_machinery_elevator_passenger_small_double_door_rear_open;
    level.scr_eventanim[ "elevator_small_double" ][ "open_back" ] = %"t10_machinery_elevator_passenger_small_double_door_rear_open";
}

// Namespace elevators
// Params 2
// Checksum 0x8c36e0ee, Offset: 0x46c3
// Size: 0xf9
function elevatoroccupancytracking( enttriggered, car )
{
    enttriggered notify( #"hash_5715b2942b53c46b" );
    enttriggered endon( #"hash_5715b2942b53c46b" );
    enttriggered endon( #"death" );
    enttriggered endon( #"disconnect" );
    short_interval = 0.1;
    long_interval = 1.5;
    loop_long_interval = long_interval;
    var_e62d407ecb76700 = 140;
    
    while ( isdefined( enttriggered ) )
    {
        car function_8f29a6847e8fe0b7( enttriggered, 1 );
        
        while ( !enttriggered isinsideelevator( car ) )
        {
            wait short_interval;
            loop_long_interval -= short_interval;
            
            if ( loop_long_interval < 0 )
            {
                loop_long_interval = long_interval;
                
                if ( distance2dsquared( enttriggered.origin, car.origin ) > var_e62d407ecb76700 * var_e62d407ecb76700 )
                {
                    return;
                }
            }
        }
        
        car function_8f29a6847e8fe0b7( enttriggered );
        
        while ( enttriggered isinsideelevator( car ) )
        {
            wait short_interval;
        }
    }
}

// Namespace elevators
// Params 1
// Checksum 0xfa8227b3, Offset: 0x47c4
// Size: 0x32, Type: bool
function function_c7b2a502c96c5e62( ent )
{
    if ( isplayer( ent ) || isalive( ent ) || ent.var_7777b3d129b3ead1 )
    {
        return true;
    }
    
    return false;
}

// Namespace elevators
// Params 1
// Checksum 0x833ff4e3, Offset: 0x47ff
// Size: 0x67b
function isinsideelevator( car )
{
    if ( !function_c7b2a502c96c5e62( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.elevators ) )
    {
        return 0;
    }
    
    if ( !isdefined( car ) )
    {
        elevatorcars = [];
        
        foreach ( elevator in level.elevators )
        {
            elevatorcars[ elevatorcars.size ] = elevator.car;
        }
        
        car = function_47c86977a18df38b( elevatorcars, self.origin );
    }
    
    if ( !isdefined( car.carheight ) )
    {
        return 0;
    }
    
    if ( !car.var_3777892fe6150c9b )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_24b1d20863cdd66a", 0 ) == 1 )
    {
        if ( isdefined( car.occupancytrig ) && ispointinvolume( self.origin, car.occupancytrig ) )
        {
            if ( !self.isinsideelevator )
            {
                car function_8f29a6847e8fe0b7( self );
            }
            
            return 1;
        }
        
        if ( isdefined( car.corner_a ) )
        {
            z_padding = 16;
            
            if ( self.origin[ 2 ] < car.origin[ 2 ] - z_padding && self.origin[ 2 ] > car.origin[ 2 ] + car.carheight + z_padding )
            {
                return 0;
            }
            
            if ( function_85da6afd57a89851( self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d ) )
            {
                if ( !self.isinsideelevator )
                {
                    car function_8f29a6847e8fe0b7( self );
                }
                
                return 1;
            }
        }
        
        return 0;
    }
    
    if ( isdefined( car.occupancytrig ) && !ispointinvolume( self.origin, car.occupancytrig ) )
    {
        return 0;
    }
    
    if ( isdefined( car.corner_a ) && !function_85da6afd57a89851( self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d ) )
    {
        return 0;
    }
    
    var_1d21de6db1ad19ca = car.elevator.floors[ 0 ].targetheight;
    var_12b89ff78afe559d = car.elevator.floors[ 1 ].targetheight;
    
    if ( !( isdefined( var_1d21de6db1ad19ca ) && isdefined( var_12b89ff78afe559d ) ) )
    {
        return 0;
    }
    
    zpadding = 16;
    var_ee2c24098ddae926 = var_1d21de6db1ad19ca - zpadding;
    var_61cd6c09e27497f8 = var_12b89ff78afe559d + car.carheight + 5;
    
    if ( self.origin[ 2 ] <= car.origin[ 2 ] - zpadding || self.origin[ 2 ] >= car.origin[ 2 ] + car.carheight )
    {
        if ( self.origin[ 2 ] >= var_ee2c24098ddae926 && self.origin[ 2 ] <= var_61cd6c09e27497f8 )
        {
            glitchedorigin = self.origin;
            teleporttoorigin = ( self.origin[ 0 ], self.origin[ 1 ], car.origin[ 2 ] );
            teleporttoorigin = vectorlerp( car.origin, teleporttoorigin, 0.85 ) + ( 0, 0, zpadding );
            
            if ( isdefined( car.occupancytrig ) && !ispointinvolume( self.origin, car.occupancytrig ) || isdefined( car.corner_a ) && !function_85da6afd57a89851( self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d ) )
            {
                teleporttoorigin = car.origin + ( randomintrange( -48, 48 ), randomintrange( -48, 48 ), zpadding );
            }
            
            /#
                print3d( glitchedorigin, "<dev string:xb8>", ( 1, 0.25, 0 ), 1, 0.25, 1000 );
                line( glitchedorigin + ( -4, -4, 0 ), glitchedorigin + ( 4, 4, 0 ), ( 1, 0.25, 0 ), 1, 0, 1000 );
                line( glitchedorigin + ( -4, 4, 0 ), glitchedorigin + ( 4, -4, 0 ), ( 1, 0.25, 0 ), 1, 0, 1000 );
                line( teleporttoorigin, glitchedorigin, ( 1, 1, 0 ), 1, 0, 1000 );
                line( teleporttoorigin + ( -4, -4, 0 ), teleporttoorigin + ( 4, 4, 0 ), ( 0, 1, 1 ), 1, 0, 1000 );
                line( teleporttoorigin + ( -4, 4, 0 ), teleporttoorigin + ( 4, -4, 0 ), ( 0, 1, 1 ), 1, 0, 1000 );
                print3d( teleporttoorigin, "<dev string:xc1>", ( 0, 1, 1 ), 1, 0.25, 1000 );
            #/
            
            if ( !isplayer( self ) || !isalive( self ) && self.var_7777b3d129b3ead1 )
            {
                if ( isdefined( self.var_1bc9bd2308d79509 ) )
                {
                    self [[ self.var_1bc9bd2308d79509 ]]( teleporttoorigin );
                }
                else
                {
                    self.origin = teleporttoorigin;
                }
            }
            else
            {
                self setorigin( teleporttoorigin );
            }
            
            if ( isdefined( car.elevator ) )
            {
                level notify( #"elevator_teleported", car.elevator, teleporttoorigin );
            }
            
            return 1;
        }
        
        return 0;
    }
    
    if ( !self.isinsideelevator )
    {
        car function_8f29a6847e8fe0b7( self );
    }
    
    return 1;
}

// Namespace elevators
// Params 2
// Checksum 0x259e0b5, Offset: 0x4e82
// Size: 0xb9
function function_8f29a6847e8fe0b7( occupant, remove_occupant )
{
    self.occupants = function_46f9072493651dc9( self.occupants );
    
    if ( !isdefined( occupant ) )
    {
        return;
    }
    
    if ( remove_occupant )
    {
        occupant.isinsideelevator = 0;
        occupant.var_f6e3b9c9859e8abf = undefined;
        self.occupants = arrayremove( self.occupants, occupant );
        return;
    }
    
    thread removeoccupantondeath( occupant );
    occupant.isinsideelevator = 1;
    occupant.var_f6e3b9c9859e8abf = self;
    
    if ( !arraycontains( self.occupants, occupant ) )
    {
        self.occupants[ self.occupants.size ] = occupant;
    }
}

// Namespace elevators
// Params 1
// Checksum 0x57fd74e9, Offset: 0x4f43
// Size: 0x83
function removeoccupantondeath( occupant )
{
    occupant notify( #"removeoccupantondeath" );
    occupant endon( #"removeoccupantondeath" );
    occupant waittill( #"death_or_disconnect" );
    
    if ( isdefined( occupant ) )
    {
        occupant.isinsideelevator = 0;
        occupant.var_f6e3b9c9859e8abf = undefined;
        self.occupants = arrayremove( self.occupants, occupant );
        return;
    }
    
    self.occupants = function_5713d46873b29625( self.occupants );
}

// Namespace elevators
// Params 5
// Checksum 0xd69bfb38, Offset: 0x4fce
// Size: 0xcc, Type: bool
function function_85da6afd57a89851( point, corner_a, corner_b, corner_c, corner_d )
{
    corner_a = ( corner_a[ 0 ], corner_a[ 1 ], 0 );
    corner_b = ( corner_b[ 0 ], corner_b[ 1 ], 0 );
    corner_c = ( corner_c[ 0 ], corner_c[ 1 ], 0 );
    corner_d = ( corner_d[ 0 ], corner_d[ 1 ], 0 );
    point = ( point[ 0 ], point[ 1 ], 0 );
    center = vectorlerp( corner_a, corner_c, 0.5 );
    var_78d1e6ceef996a8a = pointonsegmentnearesttopoint( corner_a, corner_b, point );
    var_78ded7ceefa75e12 = pointonsegmentnearesttopoint( corner_b, corner_c, point );
    
    if ( distance2dsquared( center, point ) <= distance2dsquared( center, var_78d1e6ceef996a8a ) && distance2dsquared( center, point ) <= distance2dsquared( center, var_78ded7ceefa75e12 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace elevators
// Params 0
// Checksum 0xa98f6999, Offset: 0x50a3
// Size: 0x87
function function_1bd312a8a822886d()
{
    level endon( #"game_ended" );
    self endon( #"elevator_doors_closing" );
    self endon( #"disconnect" );
    
    while ( self.floors[ self.currentfloor ].playerblocked == 1 )
    {
        self.car playsound( "mp_elevator_open" );
        
        if ( self.floors[ self.currentfloor ].playerblocked == 0 )
        {
            break;
        }
        
        wait 3;
    }
}

// Namespace elevators
// Params 1
// Checksum 0xa95deb7b, Offset: 0x5132
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace elevators
// Params 1
// Checksum 0x9568cd58, Offset: 0x5151
// Size: 0xa8
function function_7618964fb697fbc4( callbackfunction )
{
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            if ( !isdefined( elevators ) )
            {
                continue;
            }
            
            elevators thread isentitytouchingdoortrigger( self );
        }
    }
    
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace elevators
// Params 1, eflags: 0x4
// Checksum 0xa07e0a54, Offset: 0x5201
// Size: 0x27e
function private function_35d2ebf801a5dd25( toggle )
{
    if ( !toggle )
    {
        if ( self.elevator_nopower )
        {
            return;
        }
        
        self.elevator_nopower = 1;
        
        if ( self.car getscriptablehaspart( "elevator_music" ) )
        {
            self.car setscriptablepartstate( "elevator_music", "off", 0 );
        }
        
        self.car setscriptablepartstate( "elevator_int_button", "usable_nopower", 0 );
        
        foreach ( ext_button in self.floors )
        {
            ext_button setscriptablepartstate( "elevator_ext_button", "usable_nopower", 0 );
        }
        
        return;
    }
    
    if ( !isdefined( self.elevator_nopower ) )
    {
        return;
    }
    
    self.elevator_nopower = undefined;
    
    if ( self.car getscriptablehaspart( "elevator_music" ) )
    {
        self.car setscriptablepartstate( "elevator_music", self.car.var_e7738fea56c3b3b9 ?? "default", 0 );
    }
    
    targetfloor = undefined;
    
    foreach ( otherfloor in self.floors )
    {
        if ( otherfloor.floornum != self.currentfloor )
        {
            targetfloor = otherfloor;
            otherfloor setscriptablepartstate( "elevator_ext_button", "usable", 0 );
            otherfloor setscriptablepartstate( "elevator_button_lights", "off", 0 );
            continue;
        }
        
        otherfloor setscriptablepartstate( "elevator_ext_button", "disabled", 0 );
        otherfloor setscriptablepartstate( "elevator_button_lights", "off", 0 );
    }
    
    if ( isdefined( targetfloor ) )
    {
        var_352bbf468064c385 = self.car.origin[ 2 ] >= targetfloor.origin[ 2 ];
        
        if ( !self.skip_interacts )
        {
            function_e1c456a9df1b3cb5( var_352bbf468064c385 );
        }
    }
}

// Namespace elevators
// Params 0, eflags: 0x4
// Checksum 0xb8b0457f, Offset: 0x5487
// Size: 0xfb
function private function_40bade5d1dab2640()
{
    foreach ( elevator in level.elevators )
    {
        elevator.currentfloor = elevator.defaultfloor;
        elevator.targetfloor = elevator.defaultfloor;
        elevator.car.origin = elevator.car.defaultorigin;
        elevator.car.moving = #"moving_stopped";
        elevator.state = "doors_open";
    }
}

// Namespace elevators
// Params 2
// Checksum 0x4b9bba49, Offset: 0x558a
// Size: 0x2ff
function function_b88aac40bfa20e98( toggle, var_d327f0dee62b9429 = 0 )
{
    level endon( #"game_ended" );
    
    if ( level.var_d17a5d47819f662e && !self.skip_interacts_specific )
    {
        if ( toggle )
        {
            targetfloor = undefined;
            
            foreach ( otherfloor in self.floors )
            {
                if ( otherfloor.floornum != self.currentfloor )
                {
                    targetfloor = otherfloor;
                }
            }
            
            if ( isdefined( targetfloor ) )
            {
                var_352bbf468064c385 = self.car.origin[ 2 ] >= targetfloor.origin[ 2 ];
            }
            
            if ( var_352bbf468064c385 )
            {
                self.car setscriptablepartstate( "elevator_int_button", "usable_descend", 0 );
            }
            else
            {
                self.car setscriptablepartstate( "elevator_int_button", "usable_ascend", 0 );
            }
        }
        else
        {
            self.car setscriptablepartstate( "elevator_int_button", "not_usable", 0 );
        }
    }
    else if ( toggle )
    {
        self.car setscriptablepartstate( "elevator_int_button", "usable", 0 );
    }
    else
    {
        self.car setscriptablepartstate( "elevator_int_button", "not_usable", 0 );
    }
    
    self.var_3a97986bed8eb12c = !toggle;
    
    if ( var_d327f0dee62b9429 )
    {
        return;
    }
    
    waitframe();
    
    if ( toggle )
    {
        foreach ( elevator_floor in self.floors )
        {
            elevator_floor setscriptablepartstate( "elevator_ext_button", "usable" );
        }
        
        self.state = "doors_open";
        waitframe();
        self notify( #"stop_waiting" );
        return;
    }
    
    foreach ( elevator_floor in self.floors )
    {
        elevator_floor setscriptablepartstate( "elevator_ext_button", "disabled" );
        elevator_floor setscriptablepartstate( "elevator_button_lights", "off" );
    }
    
    self.state = "doors_closing";
    waitframe();
    self notify( #"stop_waiting" );
}

