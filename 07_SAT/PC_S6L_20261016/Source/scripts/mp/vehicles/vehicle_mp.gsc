// scripts\mp\vehicles\vehicle_mp.gsc  (hash_19a564d17590e1ba.gscc) (size: 4061 Bytes / 0xfdd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4813a48b (1209246859)
// size ...... 4061 (0xfdd)
// includes .. 20  (offset: 0xf05)
// strings ... 2   (offset: 0xfa5)
// dev strs .. 1   (offset: 0xfc1)
// exports ... 11  (offset: 0x711)
// cseg ...... 0xaa + 0x667 (0x711)
// imports ... 54  (offset: 0x8c9)
// animtree1 . 0   (offset: 0xfcd)
// animtree2 . 1   (offset: 0xfcd)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_damage;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\outofbounds;
#using scripts\mp\vehicles\damage;
#using scripts\mp\vehicles\light_tank_mp;
#using scripts\mp\vehicles\vehicle_compass_mp;
#using scripts\mp\vehicles\vehicle_damage_mp;
#using scripts\mp\vehicles\vehicle_hack;
#using scripts\mp\vehicles\vehicle_mines_mp;
#using scripts\mp\vehicles\vehicle_occupancy_mp;
#using scripts\mp\vehicles\vehicle_oob_mp;
#using scripts\mp\vehicles\vehicle_spawn_mp;

#namespace vehicle_mp;

// Namespace vehicle_mp
// Params 0
// Checksum 0x254ce769, Offset: 0xc8
// Size: 0x1e8
function vehicle_mp_init()
{
    callback::add( #"vehicle_create", &vehicle_mp_create );
    utility::registersharedfunc( #"vehicle", #"deleteNextFrame", &vehicle_mp_deletenextframe );
    utility::registersharedfunc( #"vehicle", #"deleteNextFrameLate", &vehicle_mp_deletenextframelate );
    utility::registersharedfunc( #"vehicle", #"createhint", &gameobjects::createhintobject );
    callback::add( #"vehicle_occupancy_init", &vehicle_occupancy_mp::vehicle_occupancy_mp_init );
    utility::registersharedfunc( #"vehicle_mines", #"init", &vehicle_mines_mp::vehicle_mines_mp_init );
    utility::registersharedfunc( #"vehicle_spawn", #"init", &vehicle_spawn_mp::vehicle_spawn_mp_init );
    utility::registersharedfunc( #"vehicle_compass", #"init", &vehicle_compass_mp::vehicle_compass_mp_init );
    utility::registersharedfunc( #"vehicle_damage", #"init", &vehicle_damage_mp::vehicle_damage_mp_init );
    utility::registersharedfunc( #"vehicle_upgrade", #"init", &br_armory_kiosk::_runpurchasemenu );
    utility::registersharedfunc( #"vehicle_trophy", #"init", &trophy_system::trophy_watchprotection );
    utility::registersharedfunc( #"hash_37a09a3f61fad325", #"init", &trophy_system::function_3ef7d9b33d884442 );
    utility::registersharedfunc( #"hash_8fbc7580ee7f4ca9", #"init", &trophy_system::trophy_createexplosion );
    utility::registersharedfunc( #"hash_5af790a704e01be7", #"init", &trophy_system::trophy_explode );
    utility::registersharedfunc( #"vehicle", #"hack", &vehicle_hack::vehicle_hack );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"init", &light_tank_mp::light_tank_mp_init );
    damage::init();
    vehicle_oob_mp::vehicle_oob_mp_init();
    
    /#
        vehicle_mp_debug_init();
    #/
}

// Namespace vehicle_mp
// Params 3
// Checksum 0xa26557c2, Offset: 0x2b8
// Size: 0x51
function fastrope_anim( model, animation, flag )
{
    model dontinterpolate();
    model scriptmodelclearanim();
    model scriptmodelplayanimdeltamotionfrompos( getanimname( animation ), model.origin, model.angles, flag );
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace vehicle_mp
// Params 2
// Checksum 0xbb595392, Offset: 0x311
// Size: 0x131
function vehicle_anim( vehicle, animation )
{
    vehicle endon( #"death" );
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle vehicle_ai::has_anim_intro() )
        {
            if ( !vehicle.var_cb77d7510de9ffc9 )
            {
                vehicle.var_cb77d7510de9ffc9 = 1;
                vehicle vehicle_cleardrivingstate();
                vehicle vehphys_forcekeyframedmotion();
                vehicle animscripted( "placeholder", vehicle.scenenode.origin, vehicle.scenenode.angles, animation );
                wait vehicle vehicle_ai::get_intro_anim_time();
                vehicle stopanimscripted();
                vehicle function_d2b8ee2e1275daaf( 0 );
                vehicle vehphys_setdefaultmotion();
                vehicle cleargoalyaw();
                vehicle.var_cb77d7510de9ffc9 = undefined;
            }
            
            return;
        }
        
        if ( getdvarint( @"hash_fd91e28597d37f91", 1 ) == 1 )
        {
            vehicle function_ae42635bd61384d0( 1 );
        }
        
        if ( getdvarint( @"hash_8c25d25dcf77c272", 1 ) == 1 )
        {
            vehicle animscripted( "placeholder", vehicle.origin, vehicle.angles, %iw9_veh_blank_5_seconds );
        }
        
        vehicle vehicleplayanim( animation, 0 );
    }
}

// Namespace vehicle_mp
// Params 1
// Checksum 0x3a41caf8, Offset: 0x44a
// Size: 0x75
function vehicle_mp_create( params )
{
    vehicle = params.vehicle;
    vehicle.maxhealth = vehicle_damage::get_max_health( vehicle );
    vehicle.health = vehicle.maxhealth;
    outofbounds::registerentforoob( vehicle, "vehicle" );
    vehicle enableplayermarks( #"killstreak" );
    vehicle_occupancy_mp::vehicle_occupancy_mp_updatemarkfilter( vehicle );
}

// Namespace vehicle_mp
// Params 1
// Checksum 0xab911e66, Offset: 0x4c7
// Size: 0x29
function vehicle_mp_deletenextframe( vehicle )
{
    outofbounds::clearoob( vehicle, 1 );
    weapon_utility::clearlockedon( vehicle );
    vehicle vehicle_hack::clear();
}

// Namespace vehicle_mp
// Params 1
// Checksum 0xb52c6d69, Offset: 0x4f8
// Size: 0xc
function vehicle_mp_deletenextframelate( vehicle )
{
    
}

// Namespace vehicle_mp
// Params 1
// Checksum 0x8aff6716, Offset: 0x50c
// Size: 0x72
function function_a37d52efb9e9115a( vehicle )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle vehicle::get_ref() ) ) )
    {
        return 0;
    }
    
    switch ( vehicle vehicle::get_ref() )
    {
        case %"hash_38f9469ea4893813":
        case %"hash_3dff816eedc0901c":
        case %"hash_79bb1c850aa99b89":
        case %"hash_7ad965933c54dd53":
            return 1;
        default:
            return 0;
    }
}

/#

    // Namespace vehicle_mp
    // Params 0
    // Checksum 0x25ec9e49, Offset: 0x586
    // Size: 0x21, Type: dev
    function vehicle_mp_debug_init()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        thread function_db1342d990f1c2df();
    }

    // Namespace vehicle_mp
    // Params 0
    // Checksum 0xf2527e0a, Offset: 0x5af
    // Size: 0x31, Type: dev
    function function_db1342d990f1c2df()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f29bd33b293b2675", 0 ) != 0 )
            {
                function_4e38fa93d3b4e836();
            }
            
            wait level.framedurationseconds;
        }
    }

    // Namespace vehicle_mp
    // Params 0
    // Checksum 0x1a877d2f, Offset: 0x5e8
    // Size: 0x129, Type: dev
    function function_4e38fa93d3b4e836()
    {
        vehicles = getentarray( "<dev string:x24>", #classname );
        
        foreach ( vehicle in vehicles )
        {
            point = vehicle.origin;
            point += anglestoforward( vehicle.angles ) * getdvarint( @"hash_a765ffa626d484ef", 0 );
            point += anglestoright( vehicle.angles ) * getdvarint( @"hash_46a8210687b62330", 0 );
            point += anglestoup( vehicle.angles ) * getdvarint( @"hash_29007f0daffa3caf", 0 );
            thread debug_utility::drawsphere( point, 2, level.framedurationseconds, ( 1, 1, 1 ) );
        }
    }

#/
