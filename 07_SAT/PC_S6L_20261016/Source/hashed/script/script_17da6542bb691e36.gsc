// script_17da6542bb691e36  (hash_17da6542bb691e36.gscc) (size: 25262 Bytes / 0x62ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f880cd (150503629)
// size ...... 25262 (0x62ae)
// includes .. 10  (offset: 0x6136)
// strings ... 16  (offset: 0x6186)
// dev strs .. 7   (offset: 0x624e)
// exports ... 45  (offset: 0x4b36)
// cseg ...... 0x270 + 0x48c6 (0x4b36)
// imports ... 118 (offset: 0x523e)
// animtree1 . 0   (offset: 0x62ae)
// animtree2 . 0   (offset: 0x62ae)
#using script_2202b0478c57bf0d;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\damagefeedback;
#using scripts\mp\weapons;

#namespace namespace_90d2baa44d8f3f78;

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x5
// Checksum 0xf59e84a9, Offset: 0x28e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b6d8574c0a05ea39", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0xc85c4374, Offset: 0x2b7
// Size: 0xa5
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    level.package_airdrop.var_ced97a3033b9b333 = [];
    level thread function_8ed96706d3ef9e6f();
    level.package_airdrop.var_9299fde1eef86b5d = getdvarint( @"hash_cca268ebf1268c98", 1 ) && getdvarint( @"hash_35242ad4508afdb", 1 );
    function_b98e63e9a97775ef();
    function_52dd8e34bdfa8178();
    scriptable::scriptable_adddamagedcallback( &dronedamage );
    utility::registersharedfunc( #"start_airdrop", #"lightweight_drone", &function_6810b415ad2e23e5 );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x2584d6a4, Offset: 0x364
// Size: 0x9c
function private function_8ed96706d3ef9e6f()
{
    level waittill( #"game_ended" );
    
    foreach ( drone in level.package_airdrop.var_ced97a3033b9b333 )
    {
        if ( !isdefined( drone ) )
        {
            continue;
        }
        
        drone thread function_6905a67cd601eff2();
    }
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x4e60f5bb, Offset: 0x408
// Size: 0x21c
function private function_b98e63e9a97775ef()
{
    level.package_airdrop.patrols = [ { #waypoints:[ ( 2000, 0, 0 ), ( 2000, 2000, 0 ), ( 0, 2000, 0 ), ( 0, 0, 0 ) ], #stabtimes:[ 1.5, 1.5, 1.5, 1.5 ], #traveltimes:[ 3, 3, 3, 3 ], #containmentfriendly:1, #patrolname:#"patrol_square" }, { #waypoints:[ ( 3000, -500, 0 ), ( 1500, 1500, 0 ), ( 0, -1500, 0 ), ( -1500, 1500, 0 ), ( -3000, -500, 0 ), ( 0, 0, 0 ) ], #stabtimes:[ 2.31, 1.79, 2.63, 2.63, 1.79, 2.31 ], #traveltimes:[ 4.12, 3.33, 4.58, 4.58, 3.33, 4.12 ], #containmentfriendly:0, #patrolname:#"hash_96e5857eaa7365be" } ];
    level.package_airdrop.var_cbc5938a284238fd = trace::function_bbd81e56529ef225();
    level.package_airdrop.var_4beb547c30ae1aa0 = trace::function_95e6759db38fe94e();
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x6131b71, Offset: 0x62c
// Size: 0x973
function private function_52dd8e34bdfa8178()
{
    var_ca27e2a3a378ebe5 = [ { #var_ba493c8ae1b4b618:1.53, #traveltime:4.58, #offset:( 2000, 2000, -500 ), #distanceid:#"500", #spawnname:#"hash_d522bc7847d7774b" }, { #var_ba493c8ae1b4b618:1.53, #traveltime:4.58, #offset:( -2000, -2000, -500 ), #distanceid:#"500", #spawnname:#"hash_6c8a9597964e9011" }, { #var_ba493c8ae1b4b618:1.53, #traveltime:4.58, #offset:( 2000, -2000, -500 ), #distanceid:#"500", #spawnname:#"hash_705ae08412b73c95" }, { #var_ba493c8ae1b4b618:1.53, #traveltime:4.58, #offset:( -2000, 2000, -500 ), #distanceid:#"500", #spawnname:#"hash_a7f536eac1cfaa87" }, { #var_ba493c8ae1b4b618:0.27, #traveltime:0.8, #offset:( 0, 0, -500 ), #distanceid:#"500", #spawnname:#"spawn_c_500" } ];
    var_66998b3be1f494f9 = [ { #var_ba493c8ae1b4b618:1.59, #traveltime:4.78, #offset:( 2000, 2000, -1000 ), #distanceid:#"1000", #spawnname:#"hash_82418b836caf1f65" }, { #var_ba493c8ae1b4b618:1.59, #traveltime:4.78, #offset:( -2000, -2000, -1000 ), #distanceid:#"1000", #spawnname:#"hash_28c7a1b5235604f7" }, { #var_ba493c8ae1b4b618:1.59, #traveltime:4.78, #offset:( 2000, -2000, -1000 ), #distanceid:#"1000", #spawnname:#"hash_2296d54a753dadfb" }, { #var_ba493c8ae1b4b618:1.59, #traveltime:4.78, #offset:( -2000, 2000, -1000 ), #distanceid:#"1000", #spawnname:#"hash_b645b7c5fbc0b691" }, { #var_ba493c8ae1b4b618:0.53, #traveltime:1.6, #offset:( 0, 0, -1000 ), #distanceid:#"1000", #spawnname:#"spawn_c_1000" } ];
    var_cd4fb2850618cc88 = [ { #var_ba493c8ae1b4b618:1.84, #traveltime:5.52, #offset:( 2000, 2000, -2000 ), #distanceid:#"2000", #spawnname:#"hash_22a9578bc341e436" }, { #var_ba493c8ae1b4b618:1.84, #traveltime:5.52, #offset:( -2000, -2000, -2000 ), #distanceid:#"2000", #spawnname:#"hash_1e0bdd9ae65852a4" }, { #var_ba493c8ae1b4b618:1.84, #traveltime:5.52, #offset:( 2000, -2000, -2000 ), #distanceid:#"2000", #spawnname:#"hash_18481130389ccd88" }, { #var_ba493c8ae1b4b618:1.84, #traveltime:5.52, #offset:( -2000, 2000, -2000 ), #distanceid:#"2000", #spawnname:#"hash_6b0323ceee9a19c2" }, { #var_ba493c8ae1b4b618:1.07, #traveltime:3.2, #offset:( 0, 0, -2000 ), #distanceid:#"2000", #spawnname:#"hash_3342782933653d05" } ];
    var_fda428f52c452da7 = [ { #var_ba493c8ae1b4b618:2.21, #traveltime:6.62, #offset:( 2000, 2000, -3000 ), #distanceid:#"3000", #spawnname:#"hash_d7d36394b6777627" }, { #var_ba493c8ae1b4b618:2.21, #traveltime:6.62, #offset:( -2000, -2000, -3000 ), #distanceid:#"3000", #spawnname:#"hash_d33649a3d98e87b5" }, { #var_ba493c8ae1b4b618:2.21, #traveltime:6.62, #offset:( 2000, -2000, -3000 ), #distanceid:#"3000", #spawnname:#"hash_cd057d392b7630b9" }, { #var_ba493c8ae1b4b618:2.21, #traveltime:6.62, #offset:( -2000, 2000, -3000 ), #distanceid:#"3000", #spawnname:#"hash_202d0fd7e1cf7553" }, { #var_ba493c8ae1b4b618:1.59, #traveltime:4.78, #offset:( 0, 0, -3000 ), #distanceid:#"3000", #spawnname:#"hash_d2d60c22b42f36f4" } ];
    level.package_airdrop.var_afc3b97ba5d5d1ea = [];
    level.package_airdrop.var_afc3b97ba5d5d1ea = arraycombine( level.package_airdrop.var_afc3b97ba5d5d1ea, var_cd4fb2850618cc88 );
    level.package_airdrop.var_afc3b97ba5d5d1ea = arraycombine( level.package_airdrop.var_afc3b97ba5d5d1ea, var_ca27e2a3a378ebe5 );
    level.package_airdrop.var_afc3b97ba5d5d1ea = arraycombine( level.package_airdrop.var_afc3b97ba5d5d1ea, var_66998b3be1f494f9 );
    level.package_airdrop.var_afc3b97ba5d5d1ea = arraycombine( level.package_airdrop.var_afc3b97ba5d5d1ea, var_fda428f52c452da7 );
    level.package_airdrop.var_1debc3ef63906c3c = [];
    level.package_airdrop.var_1debc3ef63906c3c[ #"500" ] = var_ca27e2a3a378ebe5;
    level.package_airdrop.var_1debc3ef63906c3c[ #"1000" ] = var_66998b3be1f494f9;
    level.package_airdrop.var_1debc3ef63906c3c[ #"2000" ] = var_cd4fb2850618cc88;
    level.package_airdrop.var_1debc3ef63906c3c[ #"3000" ] = var_fda428f52c452da7;
    level.package_airdrop.var_c8ac2b438d125683 = [ { #offset:( 7071, 7071, 0 ), #statename:#"hash_47f6551ad923d6f" }, { #offset:( -7071, -7071, 0 ), #statename:#"hash_a13c8dcb0b2a1e25" }, { #offset:( 7071, -7071, 0 ), #statename:#"hash_3fa388537ce4ff1" }, { #offset:( -7071, 7071, 0 ), #statename:#"hash_792de66ac8765393" } ];
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x9b3521c9, Offset: 0xfa7
// Size: 0x4f7
function private function_6810b415ad2e23e5( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    dropinfo = function_3730d0f77a780d8d( airdropsettings, var_ef8325c1086c2688 );
    descentdistance = dropinfo.descentdistance;
    droplocation = dropinfo.droplocation;
    var_80e8ae6a2d79183a = 0;
    
    switch ( var_ef8325c1086c2688.movementmode )
    {
        case #"scripted_movements":
            route = function_b04005f617b93a17( droplocation, var_ef8325c1086c2688 );
            
            if ( !isdefined( route ) )
            {
                return;
            }
            
            moveyaw = route.moveyaw;
            spawnlocation = route.spawnlocation;
            initialspawnpoint = route.initialspawnpoint;
            var_80e8ae6a2d79183a = 1;
            break;
        case #"default_patrols":
            var_f306101e28a71fd9 = function_6a78af33f9a214a1( airdropsettings );
            var_5543605d9de4a325 = function_2958de8932b7dc50( airdropsettings );
            preferredheight = function_11972d690de467dc( airdropsettings, var_ef8325c1086c2688 );
            var_791234c19ad182eb = function_30310de07801c07( preferredheight );
            
            if ( var_5543605d9de4a325.size )
            {
                nearestcenter = function_e3aac1eb2e7fd3f1( droplocation, var_5543605d9de4a325 );
                
                if ( isdefined( nearestcenter ) )
                {
                    tocenter = ( nearestcenter[ 0 ] - droplocation[ 0 ], nearestcenter[ 1 ] - droplocation[ 1 ], 0 );
                    moveyaw = vectortoangles( tocenter )[ 1 ] - 45 + randomfloatrange( -20, 20 );
                }
                else
                {
                    moveyaw = randomfloat( 360 );
                }
            }
            else
            {
                moveyaw = randomfloat( 360 );
            }
            
            var_8af46db4ed9de27a = function_606b58d5cd4374ef( droplocation, var_791234c19ad182eb, var_f306101e28a71fd9, moveyaw, var_5543605d9de4a325 );
            
            if ( !isdefined( var_8af46db4ed9de27a ) )
            {
                return;
            }
            
            spawnlocation = droplocation - var_8af46db4ed9de27a.offset;
            var_599c89611404fc2d = airdropsettings.extradata.var_599c89611404fc2d == 1;
            initialspawnpoint = spawnlocation;
            
            if ( var_599c89611404fc2d )
            {
                var_d6303925357aa29a = function_9f33f5f128fd7013( spawnlocation, moveyaw, var_f306101e28a71fd9, var_5543605d9de4a325 );
                
                if ( isdefined( var_d6303925357aa29a ) )
                {
                    initialspawnpoint = ( spawnlocation[ 0 ] - var_d6303925357aa29a.offset[ 0 ], spawnlocation[ 1 ] - var_d6303925357aa29a.offset[ 1 ], spawnlocation[ 2 ] - var_d6303925357aa29a.offset[ 2 ] );
                }
            }
            
            break;
    }
    
    drone = spawnscriptable( var_ef8325c1086c2688.dronescriptable, initialspawnpoint, ( 0, moveyaw, 0 ) );
    
    /#
        drone function_42c90b9970abc83f( ( 0, 1, 0 ) );
    #/
    
    level.package_airdrop.var_ced97a3033b9b333[ level.package_airdrop.var_ced97a3033b9b333.size ] = drone;
    drone.health = var_ef8325c1086c2688.dronehealth;
    drone.maxhealth = drone.health;
    drone.disabledamage = 0;
    drone.owner = airdropsettings.player;
    drone.team = airdropsettings.team ?? "drone_dummy_team";
    drone.airdropsettings = airdropsettings;
    drone.moveyaw = moveyaw;
    drone.descentdistance = descentdistance;
    drone.var_8af46db4ed9de27a = var_8af46db4ed9de27a;
    drone.droplocation = droplocation;
    
    if ( isdefined( level.package_airdrop.var_3abdd882cee75b4f ) )
    {
        [[ level.package_airdrop.var_3abdd882cee75b4f ]]( drone );
    }
    
    drone.spawnlocation = spawnlocation;
    drone.var_d6303925357aa29a = var_d6303925357aa29a;
    drone.var_80e8ae6a2d79183a = var_80e8ae6a2d79183a;
    drone.hastransformed = 0;
    drone.var_fe3437bbc52ad866 = var_ef8325c1086c2688.var_fe3437bbc52ad866;
    drone.var_9b90d67237793c7d = 1;
    drone.var_fa6206c41d748e7b = 0;
    drone.var_d8b4e96bdfa6d1a1 = undefined;
    
    /#
        drone function_4ab2b8a4672a716c();
    #/
    
    weapons::function_ef0cb557b1a93af9( drone );
    calloutmarkerping::function_6052d1ed5729bcfc( drone );
    drone airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_cb68d69fe85eb56f", drone );
    drone namespace_df4ff65d6946b16b::function_8eeb9413290d228a();
    
    if ( drone.var_fe3437bbc52ad866 )
    {
        utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", drone, &droneemp );
        
        if ( level.var_36218e71baa7e689 )
        {
            drone.var_c5ccf9dff3b5e393 = &function_9df8d8c8ffb546dd;
        }
        
        if ( level.var_36218e71baa7e689 )
        {
            level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = drone;
        }
    }
    
    return drone function_189d2f8a4ccd9ccf();
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x3e2735af, Offset: 0x14a7
// Size: 0x1ab
function private function_3730d0f77a780d8d( airdropsettings, var_ef8325c1086c2688 )
{
    dropheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.dropheight;
    descentdistance = getactivedescent( airdropsettings, var_ef8325c1086c2688 );
    
    switch ( var_ef8325c1086c2688.movementmode )
    {
        case #"scripted_movements":
            groundlocation = airdropsettings.droparea.origin;
            break;
        default:
            var_5543605d9de4a325 = function_2958de8932b7dc50( airdropsettings );
            var_41907146691ecaa8 = airdropsettings.droparea.origin;
            
            if ( var_5543605d9de4a325.size && !function_41b26ac2990baab0( var_41907146691ecaa8, var_5543605d9de4a325 ) )
            {
                nearestcenter = function_e3aac1eb2e7fd3f1( var_41907146691ecaa8, var_5543605d9de4a325 );
                
                if ( isdefined( nearestcenter ) )
                {
                    var_41907146691ecaa8 = ( nearestcenter[ 0 ], nearestcenter[ 1 ], var_41907146691ecaa8[ 2 ] );
                }
            }
            
            raycastorigin = var_41907146691ecaa8 + ( 0, 0, 5000 );
            groundlocation = function_bc0cdc5c160889dd( raycastorigin );
            
            if ( !isdefined( groundlocation ) )
            {
                groundlocation = airdrop_scriptbundle::function_9bb59dc8e54b24b6( airdropsettings.droparea );
            }
            
            if ( !isdefined( groundlocation ) )
            {
                logstring( "[LIGHTWEIGHT_DRONE] Failed to resolve dry ground for " + airdropsettings.airdropidentifier + ". Falling back to dropArea.origin height." );
                groundlocation = var_41907146691ecaa8;
            }
            
            break;
    }
    
    droplocation = ( groundlocation[ 0 ], groundlocation[ 1 ], groundlocation[ 2 ] + dropheight + descentdistance );
    return { #droplocation:droplocation, #descentdistance:descentdistance };
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0xad876fb5, Offset: 0x165b
// Size: 0x88
function private function_c1dac0df96b713c( var_ef8325c1086c2688 )
{
    if ( !isdefined( var_ef8325c1086c2688.var_c604442eba55b918 ) )
    {
        logstring( "[LIGHTWEIGHT_DRONE] scriptedSpawnOffset is undefined for scripted behavior on drone scriptable " + var_ef8325c1086c2688.dronescriptable + ". Scripted spawn aborted." );
        return;
    }
    
    var_c604442eba55b918 = utility::function_b73ecb08dfaa1bc5( var_ef8325c1086c2688.var_c604442eba55b918 );
    
    if ( var_c604442eba55b918 == ( 0, 0, 0 ) )
    {
        logstring( "[LIGHTWEIGHT_DRONE] scriptedSpawnOffset is (0,0,0) for scripted behavior on drone scriptable " + var_ef8325c1086c2688.dronescriptable + ". Scripted spawn aborted." );
        return;
    }
    
    return var_c604442eba55b918;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x2aeeabf5, Offset: 0x16ec
// Size: 0x6b
function private function_b04005f617b93a17( droplocation, var_ef8325c1086c2688 )
{
    var_c604442eba55b918 = function_c1dac0df96b713c( var_ef8325c1086c2688 );
    
    if ( !isdefined( var_c604442eba55b918 ) )
    {
        return;
    }
    
    initialspawnpoint = droplocation - var_c604442eba55b918;
    return { #droplocation:droplocation, #spawnlocation:initialspawnpoint, #initialspawnpoint:initialspawnpoint, #moveyaw:0 };
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0xc150fe7c, Offset: 0x1760
// Size: 0x5f, Type: bool
function private function_6a78af33f9a214a1( airdropsettings )
{
    airdropidentifier = airdropsettings.airdropidentifier;
    return airdropsettings.overrideoptions.extradata.var_f306101e28a71fd9 ?? level.package_airdrop.var_ef5d3eb1f3996c23[ airdropidentifier ] ?? [];
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x3da0503, Offset: 0x17c8
// Size: 0x1c4
function private function_2958de8932b7dc50( airdropsettings )
{
    if ( level.br_lootdrone.var_b24896085d43cca4 == 0 )
    {
        return [];
    }
    
    if ( isdefined( airdropsettings.overrideoptions.extradata.var_5daaa4a6edccd264 ) )
    {
        return airdropsettings.overrideoptions.extradata.var_5daaa4a6edccd264;
    }
    
    radius = level.br_lootdrone.var_4e91e5f74d569143;
    
    if ( radius <= 0 )
    {
        return [];
    }
    
    hotzones = function_e2a061fcb85d84b5();
    
    if ( !hotzones.size )
    {
        return [];
    }
    
    radiussq = radius * radius;
    cylinders = [];
    
    foreach ( hotzone in hotzones )
    {
        hotzoneinfo = function_4e52a812b6d1d965( hotzone );
        
        if ( !isdefined( hotzoneinfo ) || !isdefined( hotzoneinfo.midpoint ) )
        {
            continue;
        }
        
        center = hotzoneinfo.midpoint;
        containmentcylinder = { #radiussq:radiussq, #radius:radius, #z:center[ 2 ], #y:center[ 1 ], #x:center[ 0 ] };
        cylinders[ cylinders.size ] = containmentcylinder;
    }
    
    /#
        function_faeffeb7de6eab8f( cylinders );
    #/
    
    return cylinders;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x89362111, Offset: 0x1995
// Size: 0xd4, Type: bool
function private function_41b26ac2990baab0( point, var_5543605d9de4a325 = undefined )
{
    if ( !var_5543605d9de4a325.size )
    {
        return true;
    }
    
    point2d = ( point[ 0 ], point[ 1 ], 0 );
    
    foreach ( containmentcylinder in var_5543605d9de4a325 )
    {
        if ( distance2dsquared( ( containmentcylinder.x, containmentcylinder.y, 0 ), point2d ) <= containmentcylinder.radiussq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x115b231, Offset: 0x1a72
// Size: 0xf0
function private function_e3aac1eb2e7fd3f1( point, var_5543605d9de4a325 = undefined )
{
    if ( !var_5543605d9de4a325.size )
    {
        return;
    }
    
    nearestcenter = undefined;
    nearestdistsq = undefined;
    
    foreach ( containmentcylinder in var_5543605d9de4a325 )
    {
        center = ( containmentcylinder.x, containmentcylinder.y, 0 );
        distsq = distance2dsquared( center, point );
        
        if ( !isdefined( nearestdistsq ) || distsq < nearestdistsq )
        {
            nearestdistsq = distsq;
            nearestcenter = center;
        }
    }
    
    return nearestcenter;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 4, eflags: 0x4
// Checksum 0x28b4ca8c, Offset: 0x1b6b
// Size: 0x1d6
function private function_9f33f5f128fd7013( spawnlocation, moveyaw = 0, var_f306101e28a71fd9 = undefined, var_5543605d9de4a325 = undefined )
{
    approaches = level.package_airdrop.var_c8ac2b438d125683;
    
    if ( !approaches.size )
    {
        return;
    }
    
    indices = [];
    
    for ( i = 0; i < approaches.size ; i++ )
    {
        indices[ indices.size ] = i;
    }
    
    indices = arrayrandomize( indices );
    var_b7a45d330661e4e5 = var_f306101e28a71fd9.size;
    hascontainment = var_5543605d9de4a325.size;
    
    foreach ( idx in indices )
    {
        candidate = approaches[ idx ];
        offset = function_a7a3c562775304ae( candidate.offset, moveyaw );
        farpos = ( spawnlocation[ 0 ] - offset[ 0 ], spawnlocation[ 1 ] - offset[ 1 ], spawnlocation[ 2 ] - offset[ 2 ] );
        
        if ( var_b7a45d330661e4e5 && function_b31bc78d7ea76317( farpos, spawnlocation, var_f306101e28a71fd9 ) )
        {
            continue;
        }
        
        if ( hascontainment && !function_41b26ac2990baab0( farpos, var_5543605d9de4a325 ) )
        {
            continue;
        }
        
        if ( trace::ray_trace_passed( farpos, spawnlocation, undefined, level.package_airdrop.var_4beb547c30ae1aa0 ) )
        {
            return { #offset:offset, #statename:candidate.statename };
        }
    }
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0xc2bde94e, Offset: 0x1d4a
// Size: 0x6c
function private function_bc0cdc5c160889dd( origin )
{
    result = trace::sphere_trace( origin, ( origin[ 0 ], origin[ 1 ], -10000 ), 100, undefined, level.package_airdrop.var_4beb547c30ae1aa0 );
    
    if ( !isdefined( result ) || result[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return ( origin[ 0 ], origin[ 1 ], result[ "position" ][ 2 ] );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0xd9fb40ef, Offset: 0x1dbf
// Size: 0x1ba, Type: bool
function private function_e3d98a41bdf8695( eattacker, detachvelocity )
{
    drone = self;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    packageorigin = drone.origin + ( 0, 0, var_ef8325c1086c2688.var_e89bbdec27fe1979 );
    packageangles = drone.angles;
    playsoundatpos( packageorigin, "br_deployable_kiosk_detach" );
    drone.airdropsettings.var_c1a665690b72db5b = drone;
    package = airdrop_scriptbundle::function_2c2cd0fc4ff63793( drone.airdropsettings, packageorigin, packageorigin, packageangles, detachvelocity );
    drone.airdropsettings.var_c1a665690b72db5b = undefined;
    
    if ( !isdefined( package ) )
    {
        return false;
    }
    
    drone.package = package;
    drone.package.eattacker = eattacker;
    drone.package.var_57eb671c310bb38e = drone namespace_df4ff65d6946b16b::function_c48a408d8c7eb9be();
    drone.var_a1e594c2cae42e0b = 1;
    drone setscriptablepartstate( #"model", #"unloaded" );
    drone namespace_df4ff65d6946b16b::analyticsdronedelivery();
    calloutmarkerping::function_9bd4bf4f8fe74b16( drone, drone.package, 9 );
    calloutmarkerping::function_ab4e5514677fba94( drone );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_e9a6accd033eb4b9", drone, eattacker );
    return true;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x21d4a1c, Offset: 0x1f82
// Size: 0x1be
function private function_11972d690de467dc( airdropsettings, var_ef8325c1086c2688 )
{
    var_9c2067d292892ef0 = airdropsettings.extradata.var_2cbebc93d68bfefd || airdropsettings.extradata.var_85377ffd195d8d13 || airdropsettings.extradata.var_4db60f8220ae9e28 || airdropsettings.extradata.var_fa16e498496647f9;
    var_33493f1ab143704c = [];
    
    if ( var_9c2067d292892ef0 )
    {
        if ( airdropsettings.extradata.var_2cbebc93d68bfefd )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"500";
        }
        
        if ( airdropsettings.extradata.var_85377ffd195d8d13 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"1000";
        }
        
        if ( airdropsettings.extradata.var_4db60f8220ae9e28 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"2000";
        }
        
        if ( airdropsettings.extradata.var_fa16e498496647f9 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"3000";
        }
    }
    else
    {
        if ( var_ef8325c1086c2688.var_62be558f061b447e )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"500";
        }
        
        if ( var_ef8325c1086c2688.var_c0eabfa341859750 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"1000";
        }
        
        if ( var_ef8325c1086c2688.var_57c84c7be05ecb69 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"2000";
        }
        
        if ( var_ef8325c1086c2688.var_a478be6134fe75e2 )
        {
            var_33493f1ab143704c[ var_33493f1ab143704c.size ] = #"3000";
        }
    }
    
    if ( !var_33493f1ab143704c.size )
    {
        return #"2000";
    }
    
    return var_33493f1ab143704c[ randomint( var_33493f1ab143704c.size ) ];
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0xb60d32ef, Offset: 0x2149
// Size: 0x131
function private getactivedescent( airdropsettings, var_ef8325c1086c2688 )
{
    var_9c2067d292892ef0 = airdropsettings.extradata.var_cf54e5b423652c8e || airdropsettings.extradata.var_f7897b5ee9ec7ffb || airdropsettings.extradata.var_311353120c9ce395;
    var_623a2f3a1f27aa4b = [];
    
    if ( var_9c2067d292892ef0 )
    {
        if ( airdropsettings.extradata.var_cf54e5b423652c8e )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 0;
        }
        
        if ( airdropsettings.extradata.var_f7897b5ee9ec7ffb )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 500;
        }
        
        if ( airdropsettings.extradata.var_311353120c9ce395 )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 1000;
        }
    }
    else
    {
        if ( var_ef8325c1086c2688.var_2d0e310cb9e6794b )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 0;
        }
        
        if ( var_ef8325c1086c2688.var_deaa6125d8ecce08 )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 500;
        }
        
        if ( var_ef8325c1086c2688.var_f15ccebaa2fd466 )
        {
            var_623a2f3a1f27aa4b[ var_623a2f3a1f27aa4b.size ] = 1000;
        }
    }
    
    if ( !var_623a2f3a1f27aa4b.size )
    {
        return 0;
    }
    
    return var_623a2f3a1f27aa4b[ randomint( var_623a2f3a1f27aa4b.size ) ];
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x84547ad9, Offset: 0x2283
// Size: 0x125
function private function_30310de07801c07( preferredheight )
{
    var_97da86b3055a8131 = [ #"500", #"1000", #"2000", #"3000" ];
    result = [];
    var_3c9e911d6e8e0a88 = 0;
    
    for ( i = 0; i < var_97da86b3055a8131.size ; i++ )
    {
        if ( var_97da86b3055a8131[ i ] == preferredheight )
        {
            var_3c9e911d6e8e0a88 = 1;
        }
        
        if ( var_3c9e911d6e8e0a88 )
        {
            randomized = arrayrandomize( level.package_airdrop.var_1debc3ef63906c3c[ var_97da86b3055a8131[ i ] ] );
            
            foreach ( spawninfo in randomized )
            {
                result[ result.size ] = spawninfo;
            }
        }
    }
    
    return result;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0x40844a23, Offset: 0x23b1
// Size: 0x52
function private function_a7a3c562775304ae( offset, yaw )
{
    if ( !yaw )
    {
        return offset;
    }
    
    rotatedxy = rotatepointaroundvector( ( 0, 0, 1 ), ( offset[ 0 ], offset[ 1 ], 0 ), yaw );
    return ( rotatedxy[ 0 ], rotatedxy[ 1 ], offset[ 2 ] );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 3, eflags: 0x4
// Checksum 0x8c1cb20c, Offset: 0x240c
// Size: 0x27c, Type: bool
function private function_b31bc78d7ea76317( startpoint, endpoint, var_f306101e28a71fd9 = undefined )
{
    if ( !var_f306101e28a71fd9.size )
    {
        return false;
    }
    
    var_13b21346ba4f95c6 = ( startpoint[ 0 ], startpoint[ 1 ], 0 );
    var_721824c71aacc801 = ( endpoint[ 0 ], endpoint[ 1 ], 0 );
    var_b88ce031033a308b = min( var_13b21346ba4f95c6[ 0 ], var_721824c71aacc801[ 0 ] );
    var_2c1c343157bfbc65 = max( var_13b21346ba4f95c6[ 0 ], var_721824c71aacc801[ 0 ] );
    var_b88cdf31033a2e58 = min( var_13b21346ba4f95c6[ 1 ], var_721824c71aacc801[ 1 ] );
    var_2c1c333157bfba32 = max( var_13b21346ba4f95c6[ 1 ], var_721824c71aacc801[ 1 ] );
    
    foreach ( var_672add1fe20fc1b0 in var_f306101e28a71fd9 )
    {
        if ( var_672add1fe20fc1b0.radius <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( var_672add1fe20fc1b0.radiussq ) )
        {
            var_672add1fe20fc1b0.radiussq = var_672add1fe20fc1b0.radius * var_672add1fe20fc1b0.radius;
            var_672add1fe20fc1b0.minx = var_672add1fe20fc1b0.x - var_672add1fe20fc1b0.radius;
            var_672add1fe20fc1b0.maxx = var_672add1fe20fc1b0.x + var_672add1fe20fc1b0.radius;
            var_672add1fe20fc1b0.miny = var_672add1fe20fc1b0.y - var_672add1fe20fc1b0.radius;
            var_672add1fe20fc1b0.maxy = var_672add1fe20fc1b0.y + var_672add1fe20fc1b0.radius;
        }
        
        if ( var_2c1c343157bfbc65 < var_672add1fe20fc1b0.minx || var_b88ce031033a308b > var_672add1fe20fc1b0.maxx || var_2c1c333157bfba32 < var_672add1fe20fc1b0.miny || var_b88cdf31033a2e58 > var_672add1fe20fc1b0.maxy )
        {
            continue;
        }
        
        cylindercenter = ( var_672add1fe20fc1b0.x, var_672add1fe20fc1b0.y, 0 );
        closestpoint = pointonsegmentnearesttopoint( var_13b21346ba4f95c6, var_721824c71aacc801, cylindercenter );
        
        if ( distance2dsquared( cylindercenter, closestpoint ) <= var_672add1fe20fc1b0.radiussq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 5, eflags: 0x4
// Checksum 0x51bc88d6, Offset: 0x2691
// Size: 0x29b
function private function_606b58d5cd4374ef( droplocation, var_afc3b97ba5d5d1ea, var_f306101e28a71fd9 = undefined, moveyaw = 0, var_5543605d9de4a325 = undefined )
{
    var_cbc77a3592b205ae = var_afc3b97ba5d5d1ea ?? function_30310de07801c07( #"2000" );
    var_b7a45d330661e4e5 = var_f306101e28a71fd9.size;
    hascontainment = var_5543605d9de4a325.size;
    
    for ( i = 0; i < var_cbc77a3592b205ae.size ; i++ )
    {
        var_8af46db4ed9de27a = var_cbc77a3592b205ae[ i ];
        offset = function_a7a3c562775304ae( var_8af46db4ed9de27a.offset, moveyaw );
        spawnlocation = ( droplocation[ 0 ] - offset[ 0 ], droplocation[ 1 ] - offset[ 1 ], droplocation[ 2 ] - offset[ 2 ] );
        var_75714dbeba4e5a3a = { #var_ba493c8ae1b4b618:var_8af46db4ed9de27a.var_ba493c8ae1b4b618, #traveltime:var_8af46db4ed9de27a.traveltime, #offset:offset, #distanceid:var_8af46db4ed9de27a.distanceid, #spawnname:var_8af46db4ed9de27a.spawnname };
        
        if ( var_b7a45d330661e4e5 && function_b31bc78d7ea76317( droplocation, spawnlocation, var_f306101e28a71fd9 ) )
        {
            continue;
        }
        
        if ( hascontainment && !function_41b26ac2990baab0( spawnlocation, var_5543605d9de4a325 ) )
        {
            continue;
        }
        
        groundpos = ( spawnlocation[ 0 ], spawnlocation[ 1 ], spawnlocation[ 2 ] - 10000 );
        
        if ( !trace::ray_trace_passed( spawnlocation, groundpos, undefined, level.package_airdrop.var_cbc5938a284238fd ) )
        {
            continue;
        }
        
        if ( !trace::ray_trace_passed( droplocation, spawnlocation, undefined, level.package_airdrop.var_4beb547c30ae1aa0 ) )
        {
            continue;
        }
        
        if ( isdefined( level.br_circle ) && br_circle::function_6bf5d4e680297398( spawnlocation ) )
        {
            var_e4e284950dcf6473 = var_75714dbeba4e5a3a;
            continue;
        }
        
        return var_75714dbeba4e5a3a;
    }
    
    if ( var_e4e284950dcf6473 )
    {
        return var_e4e284950dcf6473;
    }
    
    if ( var_b7a45d330661e4e5 )
    {
        return var_e4e284950dcf6473;
    }
    
    var_8af46db4ed9de27a = var_cbc77a3592b205ae[ 0 ];
    offset = function_a7a3c562775304ae( var_8af46db4ed9de27a.offset, moveyaw );
    var_cee0efaed91f2a7b = { #var_ba493c8ae1b4b618:var_8af46db4ed9de27a.var_ba493c8ae1b4b618, #traveltime:var_8af46db4ed9de27a.traveltime, #offset:offset, #distanceid:var_8af46db4ed9de27a.distanceid, #spawnname:var_8af46db4ed9de27a.spawnname };
    return var_cee0efaed91f2a7b;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0xf8efc0b5, Offset: 0x2935
// Size: 0x21
function private function_f9cc05f73658cc0d( airdropidentifier )
{
    while ( !airdrop_scriptbundle::function_c4567c2030476d19( airdropidentifier ) )
    {
        wait 0.05;
    }
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x795268a4, Offset: 0x295e
// Size: 0x79
function private function_479abe036302b608( eattacker = undefined )
{
    if ( self.var_a1e594c2cae42e0b )
    {
        return 1;
    }
    
    while ( !self.var_a1e594c2cae42e0b )
    {
        function_f9cc05f73658cc0d( self.airdropsettings.airdropidentifier );
        
        if ( self.var_a1e594c2cae42e0b )
        {
            break;
        }
        
        if ( function_e3d98a41bdf8695( eattacker ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    return self.var_a1e594c2cae42e0b;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x8739da1e, Offset: 0x29e0
// Size: 0x31
function private function_825105aee5c06ef3()
{
    if ( isdefined( self.var_d8b4e96bdfa6d1a1 ) )
    {
        self setscriptablepartstate( self.var_d8b4e96bdfa6d1a1, #"0" );
    }
    
    self.var_d8b4e96bdfa6d1a1 = undefined;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x28b6475c, Offset: 0x2a19
// Size: 0x9b, Type: bool
function private function_f7b0f5e58fad6317()
{
    drone = self;
    
    if ( !drone.var_ef786972af4cdf00 )
    {
        return false;
    }
    
    if ( drone.var_b53c0ab538b7a7f5 )
    {
        return true;
    }
    
    if ( !drone.var_fa6206c41d748e7b )
    {
        return false;
    }
    
    if ( drone.airdropsettings.extradata.skipdrop )
    {
        if ( drone.var_9b90d67237793c7d )
        {
            drone thread function_90eac947a8eb3aef();
            return true;
        }
        
        return false;
    }
    
    if ( drone.var_9b90d67237793c7d )
    {
        drone thread function_90eac947a8eb3aef();
        return true;
    }
    
    return false;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x18ed5757, Offset: 0x2abd
// Size: 0x5f
function private function_6905a67cd601eff2()
{
    drone = self;
    
    if ( drone.var_44f52ace6119ee1d )
    {
        return;
    }
    
    drone.disabledamage = 1;
    drone.var_9b90d67237793c7d = 1;
    drone.var_6c49c172ab28db01 = 1;
    drone thread function_7a48b23074c12bce( randomfloatrange( 0.25, 1.5 ) );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x72d6958, Offset: 0x2b24
// Size: 0x4fe
function private function_d4875264be415776( neworigin )
{
    drone = self;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    moveyaw = drone.moveyaw ?? 0;
    newdrone = spawnscriptable( var_ef8325c1086c2688.dronescriptable, neworigin, ( 0, moveyaw, 0 ) );
    newdrone.health = drone.health;
    newdrone.maxhealth = drone.maxhealth;
    newdrone.disabledamage = drone.var_ef786972af4cdf00 == 1;
    newdrone.owner = drone.owner;
    newdrone.team = drone.team;
    newdrone.airdropsettings = drone.airdropsettings;
    newdrone.moveyaw = moveyaw;
    newdrone.descentdistance = drone.descentdistance;
    newdrone.var_8af46db4ed9de27a = drone.var_8af46db4ed9de27a;
    newdrone.droplocation = drone.droplocation;
    newdrone.spawnlocation = drone.spawnlocation;
    newdrone.var_80e8ae6a2d79183a = drone.var_80e8ae6a2d79183a;
    newdrone.var_fe3437bbc52ad866 = drone.var_fe3437bbc52ad866;
    newdrone.hastransformed = drone.hastransformed;
    newdrone.var_a1e594c2cae42e0b = drone.var_a1e594c2cae42e0b;
    newdrone.var_904083cc887feb96 = drone.var_904083cc887feb96;
    newdrone.var_1994a551a4e4de5b = drone.var_1994a551a4e4de5b;
    newdrone.var_fc180128df7ac0f5 = drone.var_fc180128df7ac0f5;
    newdrone.var_9b90d67237793c7d = drone.var_9b90d67237793c7d;
    newdrone.empattacker = drone.empattacker;
    newdrone.var_fa6206c41d748e7b = drone.var_fa6206c41d748e7b;
    newdrone.var_ef786972af4cdf00 = drone.var_ef786972af4cdf00;
    newdrone.var_b53c0ab538b7a7f5 = drone.var_b53c0ab538b7a7f5;
    newdrone.var_d8b4e96bdfa6d1a1 = drone.var_d8b4e96bdfa6d1a1;
    newdrone.spawntime = drone.spawntime;
    newdrone.var_57eb671c310bb38e = drone.var_57eb671c310bb38e;
    
    if ( newdrone.var_a1e594c2cae42e0b )
    {
        newdrone setscriptablepartstate( #"model", #"unloaded" );
    }
    
    if ( newdrone.var_fe3437bbc52ad866 )
    {
        utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", newdrone, &droneemp );
        
        if ( level.var_36218e71baa7e689 )
        {
            newdrone.var_c5ccf9dff3b5e393 = &function_9df8d8c8ffb546dd;
        }
        
        if ( level.var_36218e71baa7e689 )
        {
            level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = newdrone;
        }
    }
    
    calloutmarkerping::function_6052d1ed5729bcfc( newdrone );
    calloutmarkerping::function_9bd4bf4f8fe74b16( drone, newdrone, 9 );
    level.package_airdrop.var_ced97a3033b9b333[ level.package_airdrop.var_ced97a3033b9b333.size ] = newdrone;
    
    if ( isdefined( level.package_airdrop.var_3abdd882cee75b4f ) )
    {
        [[ level.package_airdrop.var_3abdd882cee75b4f ]]( newdrone );
    }
    
    if ( isdefined( level.package_airdrop.var_d3c29d521a5f9b9 ) )
    {
        [[ level.package_airdrop.var_d3c29d521a5f9b9 ]]( drone );
    }
    
    level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, drone );
    waitframe();
    
    if ( !isdefined( newdrone ) )
    {
        level.package_airdrop.var_ced97a3033b9b333 = function_5713d46873b29625( level.package_airdrop.var_ced97a3033b9b333 );
        return;
    }
    
    if ( isdefined( drone ) )
    {
        drone freescriptable();
    }
    else
    {
        if ( isdefined( level.package_airdrop.var_d3c29d521a5f9b9 ) )
        {
            [[ level.package_airdrop.var_d3c29d521a5f9b9 ]]( newdrone );
        }
        
        level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, newdrone );
        newdrone freescriptable();
        return;
    }
    
    weapons::function_ef0cb557b1a93af9( newdrone );
    return newdrone;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 2, eflags: 0x4
// Checksum 0xf266b34d, Offset: 0x302b
// Size: 0xc9
function private function_a34aadb538efa08d( statename, duration )
{
    if ( duration <= 0 || !statename || statename == #"" )
    {
        logstring( "[LIGHTWEIGHT_DRONE] Invalid scripted spawn move state on airdrop " + self.airdropsettings.airdropidentifier + "." );
        return 0;
    }
    
    self.var_9b90d67237793c7d = 0;
    self setscriptablepartstate( #"move", statename );
    
    if ( !( utility::waittill_notify_or_timeout( #"drone_emped", duration ) != #"drone_emped" ) )
    {
        self.var_9b90d67237793c7d = 1;
        
        if ( function_f7b0f5e58fad6317() )
        {
            return 1;
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_9b90d67237793c7d = 1;
    
    if ( function_f7b0f5e58fad6317() )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x1fa09cbf, Offset: 0x30fd
// Size: 0xa8
function private function_3d1ab0b8f9c15ed( var_ef8325c1086c2688 )
{
    foreach ( var_83d395de961866c7 in var_ef8325c1086c2688.var_2b94c8417a9dddc )
    {
        if ( function_a34aadb538efa08d( var_83d395de961866c7.statename, var_83d395de961866c7.duration ) )
        {
            return 1;
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    return 0;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0xe496e703, Offset: 0x31ae
// Size: 0x79d
function private function_189d2f8a4ccd9ccf()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"drone_shot_down" );
    drone endon( #"drone_emp_leave" );
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    drone.var_a1e594c2cae42e0b = 0;
    drone.var_9b90d67237793c7d = 1;
    
    if ( drone.var_80e8ae6a2d79183a )
    {
        if ( drone function_3d1ab0b8f9c15ed( var_ef8325c1086c2688 ) )
        {
            return [ drone.package ];
        }
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        if ( drone.airdropsettings.extradata.skipdrop )
        {
            var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ];
            
            if ( isdefined( var_9ae4b3950522d64e.var_fa72dcb0e047f418 ) )
            {
                [[ var_9ae4b3950522d64e.var_fa72dcb0e047f418 ]]( drone );
            }
            
            drone thread function_7a48b23074c12bce();
            return [ drone.package ];
        }
    }
    else
    {
        if ( isdefined( drone.var_d6303925357aa29a ) )
        {
            drone.var_9b90d67237793c7d = 0;
            
            /#
                drone function_42c90b9970abc83f( ( 0, 0.5, 1 ) );
            #/
            
            /#
                drone function_4ab2b8a4672a716c();
            #/
            
            drone setscriptablepartstate( #"move", drone.var_d6303925357aa29a.statename );
            wait 15;
            
            if ( !isdefined( drone ) )
            {
                return;
            }
            
            drone.var_9b90d67237793c7d = 1;
            
            if ( drone function_f7b0f5e58fad6317() )
            {
                return [ drone.package ];
            }
            
            waitframe();
            
            if ( !isdefined( drone ) )
            {
                return;
            }
            
            drone = drone function_d4875264be415776( drone.spawnlocation );
            
            if ( !isdefined( drone ) )
            {
                return;
            }
            
            drone endon( #"drone_shot_down" );
            drone endon( #"drone_emp_leave" );
            drone.var_9b90d67237793c7d = 1;
            
            if ( drone function_f7b0f5e58fad6317() )
            {
                return [ drone.package ];
            }
        }
        
        if ( drone dronepatrol() )
        {
            return [ drone.package ];
        }
        
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
        
        if ( !( drone utility::waittill_notify_or_timeout( #"drone_emped", randomfloatrange( var_ef8325c1086c2688.var_50102c78d3af9faa, var_ef8325c1086c2688.var_8ab2746b1a667f94 ) ) != #"drone_emped" ) )
        {
            if ( drone function_f7b0f5e58fad6317() )
            {
                return [ drone.package ];
            }
        }
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        if ( drone.airdropsettings.extradata.skipdrop )
        {
            var_9ae4b3950522d64e = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ];
            
            if ( isdefined( var_9ae4b3950522d64e.var_fa72dcb0e047f418 ) )
            {
                [[ var_9ae4b3950522d64e.var_fa72dcb0e047f418 ]]( drone );
            }
            
            drone thread function_7a48b23074c12bce();
            return [ drone.package ];
        }
        
        var_a0d943b91deeaab8 = drone.var_8af46db4ed9de27a;
        drone.var_9b90d67237793c7d = 0;
        
        /#
            drone function_42c90b9970abc83f( ( 0, 0.5, 1 ) );
        #/
        
        /#
            drone function_4ab2b8a4672a716c();
        #/
        
        drone setscriptablepartstate( #"move", drone.var_8af46db4ed9de27a.spawnname );
        wait var_a0d943b91deeaab8.traveltime + var_a0d943b91deeaab8.var_ba493c8ae1b4b618;
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone.var_9b90d67237793c7d = 1;
        
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
        
        if ( !isdefined( drone ) )
        {
            return;
        }
    }
    
    drone function_a68f5ae9310ee04d();
    
    if ( !( drone utility::waittill_notify_or_timeout( #"drone_emped", randomfloatrange( var_ef8325c1086c2688.var_75171c24a3eec53e, var_ef8325c1086c2688.var_2720c5ff328f0a94 ) ) != #"drone_emped" ) )
    {
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
    }
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    descentdistance = drone.descentdistance;
    
    if ( descentdistance )
    {
        drone.disabledamage = 1;
        drone = drone function_d4875264be415776( drone.droplocation );
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone endon( #"drone_shot_down" );
        drone endon( #"drone_emp_leave" );
        drone.var_9b90d67237793c7d = 1;
        
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
        
        var_7c375183234efca = descentdistance == 500 ? #"descent_500" : #"descent";
        drone.var_9b90d67237793c7d = 0;
        
        /#
            drone function_42c90b9970abc83f( ( 1, 0, 0 ) );
        #/
        
        /#
            drone function_4ab2b8a4672a716c();
        #/
        
        drone setscriptablepartstate( #"move", var_7c375183234efca );
        wait descentdistance == 500 ? 2 : 4;
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone.var_9b90d67237793c7d = 1;
        
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
        
        if ( !( drone utility::waittill_notify_or_timeout( #"drone_emped", randomfloatrange( var_ef8325c1086c2688.var_30da358252911ed5, var_ef8325c1086c2688.var_971281789a49568b ) ) != #"drone_emped" ) )
        {
            if ( drone function_f7b0f5e58fad6317() )
            {
                return [ drone.package ];
            }
        }
        
        if ( !isdefined( drone ) )
        {
            return;
        }
    }
    
    drone endon( #"death" );
    
    if ( drone function_f7b0f5e58fad6317() )
    {
        return [ drone.package ];
    }
    
    function_f9cc05f73658cc0d( drone.airdropsettings.airdropidentifier );
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    if ( drone.var_ef786972af4cdf00 )
    {
        if ( !drone.var_fa6206c41d748e7b )
        {
            if ( !var_ef8325c1086c2688.neverdrop && !drone.airdropsettings.extradata.skipdrop && !drone.var_a1e594c2cae42e0b )
            {
                if ( !drone function_479abe036302b608( drone.empattacker ) )
                {
                    return [ drone.package ];
                }
            }
            
            drone.var_fa6206c41d748e7b = 1;
        }
        
        if ( drone function_f7b0f5e58fad6317() )
        {
            return [ drone.package ];
        }
    }
    
    if ( !var_ef8325c1086c2688.neverdrop && !drone.airdropsettings.extradata.skipdrop && !drone.var_a1e594c2cae42e0b )
    {
        drone thread function_e3d98a41bdf8695();
    }
    
    drone thread function_7a48b23074c12bce();
    return [ drone.package ];
}

// Namespace namespace_90d2baa44d8f3f78
// Params 6, eflags: 0x4
// Checksum 0xd5525e9e, Offset: 0x3954
// Size: 0x242, Type: bool
function private function_ba2451b3eed0f001( origin, patrol, checkgeometry = 0, var_f306101e28a71fd9 = undefined, moveyaw = 0, var_5543605d9de4a325 = undefined )
{
    if ( !patrol.waypoints )
    {
        return true;
    }
    
    raycastz = origin[ 2 ] + -60;
    prevpoint = ( origin[ 0 ], origin[ 1 ], raycastz );
    var_c7ed7c6d7630ce6f = isdefined( level.br_circle );
    var_b7a45d330661e4e5 = var_f306101e28a71fd9.size;
    hascontainment = isdefined( var_5543605d9de4a325 ) ? var_5543605d9de4a325.size : 0;
    
    /#
        drawdebug = getdvarint( @"hash_98ece78f3d5b137b", 0 ) == 1;
    #/
    
    foreach ( waypointoffset in patrol.waypoints )
    {
        var_65a6f2c199b29a83 = function_a7a3c562775304ae( waypointoffset, moveyaw );
        waypoint = ( origin[ 0 ] + var_65a6f2c199b29a83[ 0 ], origin[ 1 ] + var_65a6f2c199b29a83[ 1 ], raycastz );
        var_c0f8a76d5c99efc2 = var_b7a45d330661e4e5 && function_b31bc78d7ea76317( prevpoint, waypoint, var_f306101e28a71fd9 );
        geometryblocked = 0;
        
        if ( checkgeometry )
        {
            geometryblocked = !trace::ray_trace_passed( prevpoint, waypoint, undefined, level.package_airdrop.var_4beb547c30ae1aa0 );
        }
        
        /#
            if ( drawdebug && ( checkgeometry || var_b7a45d330661e4e5 ) )
            {
                line( prevpoint, waypoint, geometryblocked || var_c0f8a76d5c99efc2 ? ( 1, 0, 0 ) : ( 0, 1, 0 ), 1, 0, 3000 );
            }
        #/
        
        if ( geometryblocked || var_c0f8a76d5c99efc2 )
        {
            return false;
        }
        
        if ( var_c7ed7c6d7630ce6f && br_circle::function_6bf5d4e680297398( waypoint ) )
        {
            return false;
        }
        
        prevpoint = waypoint;
    }
    
    return true;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x3997832d, Offset: 0x3b9f
// Size: 0x469, Type: bool
function private dronepatrol()
{
    self endon( #"death" );
    self endon( #"drone_emp_leave" );
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.var_7963aba6f607355c <= 0 || self.airdropsettings.extradata.var_862f398e80cb8798 )
    {
        return false;
    }
    
    checkgeometry = 1;
    var_f306101e28a71fd9 = function_6a78af33f9a214a1( self.airdropsettings );
    moveyaw = self.moveyaw ?? 0;
    var_5543605d9de4a325 = function_2958de8932b7dc50( self.airdropsettings );
    hascontainment = var_5543605d9de4a325.size;
    var_fc4123a1b6cde273 = [];
    
    foreach ( patrol in level.package_airdrop.patrols )
    {
        if ( hascontainment && !patrol.containmentfriendly )
        {
            continue;
        }
        
        if ( function_ba2451b3eed0f001( self.origin, patrol, checkgeometry, var_f306101e28a71fd9, moveyaw, var_5543605d9de4a325 ) )
        {
            var_fc4123a1b6cde273[ var_fc4123a1b6cde273.size ] = patrol;
        }
    }
    
    if ( !var_fc4123a1b6cde273.size )
    {
        return false;
    }
    
    patrolstartorigin = self.origin;
    
    for ( i = 0; i < var_ef8325c1086c2688.var_7963aba6f607355c ; i++ )
    {
        if ( self.var_ef786972af4cdf00 )
        {
            function_825105aee5c06ef3();
            return false;
        }
        
        patrolindex = randomint( var_fc4123a1b6cde273.size );
        patrol = var_fc4123a1b6cde273[ patrolindex ];
        
        if ( patrol )
        {
            patrolname = patrol.patrolname;
            var_d30ef0ef2abf559f = patrol.traveltimes;
            var_233a7ffc91bf1c87 = patrol.stabtimes;
            
            for ( j = 0; j < var_d30ef0ef2abf559f.size ; j++ )
            {
                if ( self.var_ef786972af4cdf00 )
                {
                    function_825105aee5c06ef3();
                    return false;
                }
                
                if ( hascontainment && isdefined( patrol.waypoints ) && j < patrol.waypoints.size && isdefined( level.br_circle ) )
                {
                    var_65a6f2c199b29a83 = function_a7a3c562775304ae( patrol.waypoints[ j ], moveyaw );
                    nextwaypoint = ( patrolstartorigin[ 0 ] + var_65a6f2c199b29a83[ 0 ], patrolstartorigin[ 1 ] + var_65a6f2c199b29a83[ 1 ], patrolstartorigin[ 2 ] );
                    
                    if ( br_circle::function_6bf5d4e680297398( nextwaypoint ) )
                    {
                        function_825105aee5c06ef3();
                        return false;
                    }
                }
                
                function_751356cc5fbf04e1();
                self.var_d8b4e96bdfa6d1a1 = patrolname;
                self.var_9b90d67237793c7d = 0;
                
                /#
                    function_42c90b9970abc83f( ( 0, 0.5, 1 ) );
                #/
                
                /#
                    function_4ab2b8a4672a716c();
                #/
                
                self setscriptablepartstate( patrolname, getxhash( "" + j + 1 ) );
                
                if ( !( utility::waittill_notify_or_timeout( #"drone_emped", var_d30ef0ef2abf559f[ j ] ) != #"drone_emped" ) )
                {
                    self.var_9b90d67237793c7d = 1;
                    function_a68f5ae9310ee04d();
                    function_825105aee5c06ef3();
                    return false;
                }
                
                self.var_9b90d67237793c7d = 1;
                function_a68f5ae9310ee04d();
                
                if ( self.var_ef786972af4cdf00 )
                {
                    function_825105aee5c06ef3();
                    return false;
                }
                
                if ( !( utility::waittill_notify_or_timeout( #"drone_emped", var_233a7ffc91bf1c87[ j ] ) != #"drone_emped" ) )
                {
                    function_825105aee5c06ef3();
                    return false;
                }
                
                if ( self.var_ef786972af4cdf00 )
                {
                    function_825105aee5c06ef3();
                    return false;
                }
                
                if ( !( utility::waittill_notify_or_timeout( #"drone_emped", randomfloatrange( var_ef8325c1086c2688.var_b512932ff1235d2f, var_ef8325c1086c2688.var_5436c9e68f0a80a9 ) ) != #"drone_emped" ) )
                {
                    function_825105aee5c06ef3();
                    return false;
                }
            }
            
            self setscriptablepartstate( patrolname, #"0" );
            self.var_d8b4e96bdfa6d1a1 = undefined;
        }
    }
    
    return false;
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0x17fc6158, Offset: 0x4011
// Size: 0x1a
function private function_a68f5ae9310ee04d()
{
    self setscriptablepartstate( #"relocation_sfx", #"idle" );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0xb0d01952, Offset: 0x4033
// Size: 0x1a
function private function_751356cc5fbf04e1()
{
    self setscriptablepartstate( #"relocation_sfx", #"moving" );
}

/#

    // Namespace namespace_90d2baa44d8f3f78
    // Params 1, eflags: 0x4
    // Checksum 0xac6f8383, Offset: 0x4055
    // Size: 0x39, Type: dev
    function private function_42c90b9970abc83f( color )
    {
        if ( !getdvarint( @"hash_763b13be421f88d", 0 ) )
        {
            return;
        }
        
        sphere( self.origin, 96, color, 1, 800 );
    }

    // Namespace namespace_90d2baa44d8f3f78
    // Params 1, eflags: 0x4
    // Checksum 0xc6d27a33, Offset: 0x4096
    // Size: 0x117, Type: dev
    function private function_faeffeb7de6eab8f( var_5543605d9de4a325 )
    {
        if ( !getdvarint( @"hash_763b13be421f88d", 0 ) )
        {
            return;
        }
        
        foreach ( containmentcylinder in var_5543605d9de4a325 )
        {
            centerz = containmentcylinder.z ?? 0;
            var_ae72a4375a0d5cd5 = ( containmentcylinder.x, containmentcylinder.y, centerz - 500 );
            toppoint = ( containmentcylinder.x, containmentcylinder.y, centerz + 3000 );
            cylinder( var_ae72a4375a0d5cd5, toppoint, containmentcylinder.radius, ( 1, 0.5, 0 ), 1, 800 );
        }
    }

    // Namespace namespace_90d2baa44d8f3f78
    // Params 0, eflags: 0x4
    // Checksum 0xbfd67d03, Offset: 0x41b5
    // Size: 0x1dc, Type: dev
    function private function_4ab2b8a4672a716c()
    {
        if ( !getdvarint( @"hash_763b13be421f88d", 0 ) )
        {
            return;
        }
        
        if ( !isdefined( self.airdropsettings ) )
        {
            return;
        }
        
        var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
        var_84f78695b05d457b = getxhashsourcename( self.airdropsettings.airdropidentifier ) ?? "<dev string:x24>" + self.airdropsettings.airdropidentifier;
        var_2c659579445398f = getxhashsourcename( var_ef8325c1086c2688.type ) ?? "<dev string:x24>" + var_ef8325c1086c2688.type;
        var_81ad046e18790f97 = getxhashsourcename( var_ef8325c1086c2688.movementmode ) ?? "<dev string:x24>" + var_ef8325c1086c2688.movementmode;
        var_1dc1866e6d640bd3 = isdefined( self.var_8af46db4ed9de27a ) ? getxhashsourcename( self.var_8af46db4ed9de27a.distanceid ) ?? "<dev string:x24>" + self.var_8af46db4ed9de27a.distanceid : "<dev string:x25>";
        labelorigin = self.origin + ( 0, 0, 120 );
        label = "<dev string:x27>" + var_84f78695b05d457b + "<dev string:x2f>" + var_2c659579445398f + "<dev string:x3b>" + var_81ad046e18790f97 + "<dev string:x3f>" + var_1dc1866e6d640bd3 + "<dev string:x4a>" + ( self.descentdistance ?? 0 );
        print3d( labelorigin, label, ( 1, 1, 0 ), 1, 1.2, 900, 1 );
    }

#/

// Namespace namespace_90d2baa44d8f3f78
// Params 11, eflags: 0x4
// Checksum 0x56501af, Offset: 0x4399
// Size: 0x257
function private dronedamage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !level.package_airdrop.var_ced97a3033b9b333.size )
    {
        return;
    }
    
    if ( !instance || !instance.airdropsettings )
    {
        return;
    }
    
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ instance.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.type != #"lightweight_drone" || !var_ef8325c1086c2688.var_c11f182c49a6ea82 )
    {
        return;
    }
    
    if ( instance.disabledamage )
    {
        return;
    }
    
    resolvedattacker = isplayer( eattacker ) ? eattacker : eattacker.owner;
    var_a9083bbfa2c465e8 = isplayer( resolvedattacker );
    
    if ( var_a9083bbfa2c465e8 )
    {
        if ( isdefined( objweapon ) && objweapon.offhandtype == "secondary" && resolvedattacker getoffhandsecondaryclass() == "grapplinghook" )
        {
            if ( !level.package_airdrop.var_9299fde1eef86b5d )
            {
                resolvedattacker cancelgrapple();
            }
            
            return;
        }
    }
    
    instance.health -= idamage;
    
    if ( var_a9083bbfa2c465e8 )
    {
        var_795e8a31194a39ac = { #var_3e13d05260eee4e1:1, #var_4dba57e6e29ded8e:1, #var_f561a4dd442b0d91:1 };
        resolvedattacker damagefeedback::updatehitmarker( "hitequip", instance.health <= 0, 0, 1, "hitequip", undefined, undefined, var_795e8a31194a39ac, 1 );
    }
    
    if ( instance.health <= 0 )
    {
        instance thread dronedestroyed( resolvedattacker );
        return;
    }
    
    if ( var_a9083bbfa2c465e8 )
    {
        instance namespace_df4ff65d6946b16b::function_c86427bd7d0b3189( resolvedattacker );
        airdrop_scriptbundle::function_e9dbf2aaef9f1c96( instance.airdropsettings, #"hash_ad000e5ba06523ee", instance, resolvedattacker );
    }
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x80b759cf, Offset: 0x45f8
// Size: 0x17b
function private function_7a48b23074c12bce( predelay = 0 )
{
    if ( self.var_44f52ace6119ee1d )
    {
        return;
    }
    
    self.var_44f52ace6119ee1d = 1;
    self endon( #"death" );
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    function_825105aee5c06ef3();
    function_a68f5ae9310ee04d();
    wait predelay;
    
    if ( !self.airdropsettings.extradata.skipdrop )
    {
        self setscriptablepartstate( #"model", #"unloaded" );
    }
    
    self setscriptablepartstate( #"move", #"exit" );
    wait var_ef8325c1086c2688.var_3684447841b3ba58;
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( self.airdropsettings, #"hash_82fb75eefaf0a89a", self );
    namespace_df4ff65d6946b16b::function_526012cdc7caf315();
    
    if ( level.package_airdrop.var_d3c29d521a5f9b9 )
    {
        [[ level.package_airdrop.var_d3c29d521a5f9b9 ]]( self );
    }
    
    level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, self );
    level notify( #"hash_b725273b968f9756" );
    self freescriptable();
}

// Namespace namespace_90d2baa44d8f3f78
// Params 0, eflags: 0x4
// Checksum 0xe027c875, Offset: 0x477b
// Size: 0x16e
function private function_90eac947a8eb3aef()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"death" );
    
    if ( drone.var_b53c0ab538b7a7f5 )
    {
        return;
    }
    
    drone.var_b53c0ab538b7a7f5 = 1;
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        function_f9cc05f73658cc0d( drone.airdropsettings.airdropidentifier );
        drone function_e3d98a41bdf8695( drone.empattacker );
    }
    
    drone notify( #"drone_emp_leave" );
    drone function_825105aee5c06ef3();
    drone setscriptablepartstate( #"smoke", #"enabled" );
    
    if ( randomint( 100 ) < 15 )
    {
        wait randomfloatrange( 0.1, 0.6 );
        
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        drone namespace_df4ff65d6946b16b::droneexplosion();
        
        if ( level.package_airdrop.var_d3c29d521a5f9b9 )
        {
            [[ level.package_airdrop.var_d3c29d521a5f9b9 ]]( drone );
        }
        
        level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, drone );
        level notify( #"hash_b725273b968f9756" );
        drone freescriptable();
        return;
    }
    
    wait randomfloatrange( 0.25, 1.5 );
    
    if ( !isdefined( drone ) )
    {
        return;
    }
    
    drone thread function_7a48b23074c12bce();
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x921b2dd6, Offset: 0x48f1
// Size: 0xd5
function private droneemp( data )
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"death" );
    
    if ( drone.var_ef786972af4cdf00 )
    {
        return;
    }
    
    drone notify( #"drone_emped" );
    drone.var_ef786972af4cdf00 = 1;
    drone.empattacker = data.attacker;
    drone.disabledamage = 1;
    
    if ( isdefined( drone.var_d8b4e96bdfa6d1a1 ) )
    {
        drone.var_9b90d67237793c7d = 1;
        drone function_a68f5ae9310ee04d();
        drone function_825105aee5c06ef3();
    }
    
    drone.var_fa6206c41d748e7b = 1;
    
    if ( drone.var_9b90d67237793c7d )
    {
        drone thread function_90eac947a8eb3aef();
    }
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x7e055eb7, Offset: 0x49ce
// Size: 0x15
function private function_9df8d8c8ffb546dd( data )
{
    thread droneemp( data );
}

// Namespace namespace_90d2baa44d8f3f78
// Params 1, eflags: 0x4
// Checksum 0x743aae67, Offset: 0x49eb
// Size: 0x14b
function private dronedestroyed( eattacker )
{
    drone = self;
    drone.disabledamage = 1;
    drone endon( #"death" );
    drone notify( #"drone_shot_down" );
    drone namespace_df4ff65d6946b16b::function_ce8365a343fe648d( eattacker );
    drone namespace_df4ff65d6946b16b::function_fb19909cdff52447( eattacker );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_852023c9f529dca6", drone, eattacker );
    detachvelocity = drone namespace_df4ff65d6946b16b::function_fe5e5ec4101d44dc();
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        drone setscriptablepartstate( #"smoke", #"enabled" );
        function_f9cc05f73658cc0d( drone.airdropsettings.airdropidentifier );
        drone function_e3d98a41bdf8695( eattacker, detachvelocity );
    }
    
    drone namespace_df4ff65d6946b16b::droneexplosion();
    
    if ( level.package_airdrop.var_d3c29d521a5f9b9 )
    {
        [[ level.package_airdrop.var_d3c29d521a5f9b9 ]]( drone );
    }
    
    level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, drone );
    level notify( #"hash_b725273b968f9756" );
    drone freescriptable();
}

