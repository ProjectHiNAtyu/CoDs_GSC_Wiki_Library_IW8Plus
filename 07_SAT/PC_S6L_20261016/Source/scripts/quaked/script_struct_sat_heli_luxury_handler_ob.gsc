// scripts\quaked\script_struct_sat_heli_luxury_handler_ob.gsc  (hash_1f60c71f1a0ac252.gscc) (size: 1551 Bytes / 0x60f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc6c9e3a (3698105914)
// size ...... 1551 (0x60f)
// includes .. 4   (offset: 0x5cb)
// strings ... 3   (offset: 0x5eb)
// dev strs .. 0   (offset: 0x60f)
// exports ... 6   (offset: 0x2ab)
// cseg ...... 0x7e + 0x22d (0x2ab)
// imports ... 20  (offset: 0x39b)
// animtree1 . 0   (offset: 0x60f)
// animtree2 . 0   (offset: 0x60f)
#using script_64ee381d3dd2061a;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_omnvar_utility;

#namespace namespace_e788799a43a4940c;

// Namespace namespace_e788799a43a4940c
// Params 0, eflags: 0x5
// Checksum 0x74ff0536, Offset: 0x9c
// Size: 0x17
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_4b9be3851036fd03", &function_f1b9ff7dbff7531 );
}

// Namespace namespace_e788799a43a4940c
// Params 0, eflags: 0x4
// Checksum 0x69977b13, Offset: 0xbb
// Size: 0x44
function private function_f1b9ff7dbff7531()
{
    if ( !vehicle::should_init( %"hash_4b9be3851036fd03" ) )
    {
        return;
    }
    
    heli_common_init( %"hash_4b9be3851036fd03" );
    utility::registersharedfunc( %"hash_4b9be3851036fd03", #"spawn", &function_ae497706c8a49842 );
}

// Namespace namespace_e788799a43a4940c
// Params 1, eflags: 0x4
// Checksum 0x48159884, Offset: 0x107
// Size: 0x59
function private heli_common_init( var_f2247e4ad4a341e5 )
{
    callbacks[ #"enterEnd" ] = &function_c10917d0538d897b;
    vehicle::generic_init( var_f2247e4ad4a341e5, callbacks );
    leveldataforvehicle = vehicle_omnvar::get_data( var_f2247e4ad4a341e5, 1 );
    leveldataforvehicle.ammoids[ "flares" ] = 1;
}

// Namespace namespace_e788799a43a4940c
// Params 2, eflags: 0x4
// Checksum 0xab5385ba, Offset: 0x168
// Size: 0xda
function private function_ae497706c8a49842( spawndata, faildata )
{
    if ( self.classname == "script_vehicle" )
    {
        vehicle = vehicle::function_66838ba16389a6cd( %"hash_4b9be3851036fd03", spawndata, self );
    }
    else
    {
        vehicle = vehicle::default_spawn( %"hash_4b9be3851036fd03", spawndata, faildata );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.flareref = %"hash_4b9be3851036fd03";
    vehicle namespace_48b810d689b085af::init_flare_system();
    bundle = getscriptbundle( getxhashasset( %"hash_4b9be3851036fd03" ) );
    vehicle.borntime = gettime();
    vehicle.var_bceeb379e0985296 = 1;
    vehicle thread namespace_48b810d689b085af::landing_gear_watcher();
    vehicle thread namespace_48b810d689b085af::collision_damage_watcher( bundle );
    vehicle thread namespace_48b810d689b085af::function_b051560c705fc65e( bundle );
    return vehicle;
}

// Namespace namespace_e788799a43a4940c
// Params 5, eflags: 0x4
// Checksum 0xa265864b, Offset: 0x24b
// Size: 0x60
function private function_c10917d0538d897b( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        if ( seatid == "driver" )
        {
            vehicle thread namespace_48b810d689b085af::handleflarefire( player );
        }
        
        vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
    }
}

