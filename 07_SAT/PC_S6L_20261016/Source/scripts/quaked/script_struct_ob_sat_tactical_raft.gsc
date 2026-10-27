// scripts\quaked\script_struct_ob_sat_tactical_raft.gsc  (hash_3e753b3cd52888b2.gscc) (size: 2897 Bytes / 0xb51 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd628f6cc (3593008844)
// size ...... 2897 (0xb51)
// includes .. 5   (offset: 0xaad)
// strings ... 7   (offset: 0xad5)
// dev strs .. 3   (offset: 0xb2d)
// exports ... 9   (offset: 0x575)
// cseg ...... 0xa8 + 0x4cd (0x575)
// imports ... 32  (offset: 0x6dd)
// animtree1 . 0   (offset: 0xb51)
// animtree2 . 0   (offset: 0xb51)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\events;
#using scripts\mp\vehicles\damage;

#namespace namespace_1969bd1c90ec4348;

// Namespace namespace_1969bd1c90ec4348
// Params 0, eflags: 0x5
// Checksum 0x230d2170, Offset: 0xc6
// Size: 0x45
function private autoexec main()
{
    vehicle::register_vehicle_init( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ), &boat_init );
}

// Namespace namespace_1969bd1c90ec4348
// Params 0, eflags: 0x4
// Checksum 0x62b9dec3, Offset: 0x113
// Size: 0xcf
function private boat_init()
{
    vehicle::generic_init( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) );
    utility::registersharedfunc( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ), #"spawn", &boat_spawn );
    damage::set_pre_mod_damage_callback( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ), &function_c8af33bec346f6e0 );
}

// Namespace namespace_1969bd1c90ec4348
// Params 1, eflags: 0x4
// Checksum 0x304c119d, Offset: 0x1ea
// Size: 0xe, Type: bool
function private function_c8af33bec346f6e0( data )
{
    return true;
}

// Namespace namespace_1969bd1c90ec4348
// Params 2
// Checksum 0xa8149eac, Offset: 0x201
// Size: 0x105
function boat_spawn( spawndata, faildata )
{
    if ( self.classname == "script_vehicle" )
    {
        vehicle = vehicle::function_66838ba16389a6cd( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ), spawndata, self );
    }
    else
    {
        vehicle = vehicle::default_spawn( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ), spawndata, faildata );
    }
    
    vehicle utility::function_7c10ea82c1e305b8( "visiblity", "hide" );
    vehicle utility::function_7c10ea82c1e305b8( "stability", "stable" );
    vehicle utility::function_7c10ea82c1e305b8( "spawn", "spawn" );
    vehicle_occupancy::register_instance( vehicle );
    setup_boat( vehicle );
    return vehicle;
}

// Namespace namespace_1969bd1c90ec4348
// Params 1, eflags: 0x4
// Checksum 0x5660bf81, Offset: 0x30f
// Size: 0x5e
function private setup_boat( vehicle )
{
    if ( !isdefined( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_ob_sat_tactical_raft.gsc" ) ) )
    {
        return;
    }
    
    vehicle thread function_efd01b753d4f65b7();
    
    /#
        vehicle thread function_27bcfc9cf2512d6();
    #/
}

// Namespace namespace_1969bd1c90ec4348
// Params 0, eflags: 0x4
// Checksum 0x6f58bc73, Offset: 0x375
// Size: 0x127
function private function_efd01b753d4f65b7()
{
    vehicle = self;
    nextimpulse = 0;
    
    while ( !vehicle vehicle::is_husk() )
    {
        vehicle waittill( #"touch", enttouching );
        
        if ( isplayer( enttouching ) )
        {
            if ( vehicle.occupants.size <= 0 )
            {
                if ( enttouching events::events_issliding() )
                {
                    function_e3126ed2f446be60( vehicle, enttouching, getdvarfloat( @"hash_28ed8bc7b7d06354", 12.5 ), getdvarfloat( @"hash_8eea322c6080754d", 2.5 ), nextimpulse );
                }
                else if ( enttouching ismeleeing() && enttouching getstance() != "prone" )
                {
                    movplat = enttouching getmovingplatformparent();
                    
                    if ( !isdefined( movplat ) )
                    {
                        function_e3126ed2f446be60( vehicle, enttouching, getdvarfloat( @"hash_e1b638da1de05b09", 7.5 ), getdvarfloat( @"hash_9cd4710984d2f6e8", 2.5 ), nextimpulse );
                    }
                    else
                    {
                        println( "<dev string:x24>" );
                    }
                }
            }
            else
            {
                println( "<dev string:x4b>" );
            }
        }
        
        waitframe();
    }
    
    println( "<dev string:x69>" );
}

// Namespace namespace_1969bd1c90ec4348
// Params 5, eflags: 0x4
// Checksum 0x63eb200e, Offset: 0x4a4
// Size: 0xa1
function private function_e3126ed2f446be60( var_7622fc98cc781399, enttouching, var_ede3236bc61d395b, var_f36f932960ff04df, nextimpulse )
{
    time = gettime();
    
    if ( isdefined( var_7622fc98cc781399 ) )
    {
        if ( time > nextimpulse && var_7622fc98cc781399 vehicle_getspeed() < 1 )
        {
            force = vectornormalize2( anglestoforward( enttouching getplayerangles() ) );
            force *= var_ede3236bc61d395b;
            force += ( 0, 0, var_f36f932960ff04df );
            var_7622fc98cc781399 vehphys_impulse( force, var_ede3236bc61d395b, 1 );
            nextimpulse = time + getdvarint( @"hash_fcdfd07fd84d73a6", 2500 );
        }
    }
}

/#

    // Namespace namespace_1969bd1c90ec4348
    // Params 0, eflags: 0x4
    // Checksum 0x6fed9bcd, Offset: 0x54d
    // Size: 0x28, Type: dev
    function private function_27bcfc9cf2512d6()
    {
        vehicle = self;
        vehicle endon( #"death" );
        
        while ( true )
        {
            waitframe();
        }
    }

#/
