// scripts\vehicle\pluto\zm_firefly_pluto.gsc  (hash_441d1766574140de.gscc) (size: 1898 Bytes / 0x76a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ec9ba72 (2395585138)
// size ...... 1898 (0x76a)
// includes .. 11  (offset: 0x6e2)
// strings ... 4   (offset: 0x73a)
// dev strs .. 0   (offset: 0x76a)
// exports ... 5   (offset: 0x2fa)
// cseg ...... 0xa8 + 0x252 (0x2fa)
// imports ... 27  (offset: 0x3c2)
// animtree1 . 0   (offset: 0x76a)
// animtree2 . 0   (offset: 0x76a)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\vehicle\pluto\pluto_shared;
#using scripts\vehicle\pluto\zm_firefly_pluto_ab;
#using scripts\vehicle\pluto\zm_firefly_pluto_breakdown;
#using scripts\vehicle\pluto\zm_firefly_pluto_damage;
#using scripts\vehicle\pluto\zm_firefly_pluto_head;
#using scripts\vehicle\pluto\zm_firefly_pluto_mg;
#using scripts\vehicle\pluto\zm_firefly_pluto_pap;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0, eflags: 0x5
// Checksum 0x86bf9059, Offset: 0xc6
// Size: 0x9
function private autoexec main()
{
    function_be4e014e75f3898d();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x840ea2a9, Offset: 0xd7
// Size: 0x1c5
function private function_be4e014e75f3898d()
{
    if ( !function_bdd68e56b5bb1269() )
    {
        return;
    }
    
    vehicle::register_vehicle_init( %"hash_62a07b56f29782f5", &function_e3f25747ea0e8d93 );
    callback::add( "on_pluto_spawned", &on_pluto_spawned_zm );
    utility::registersharedfunc( #"veh_pluto", #"hash_8319538f82a49890", &function_fe3cf3e8a93a2d13 );
    utility::registersharedfunc( #"veh_pluto", #"hash_655975bf60d149e1", &function_1c1ac2d157fe5c4e );
    utility::registersharedfunc( #"veh_pluto", #"hash_ed6bfe92f6416a79", &function_d05d285928ed6ea );
    utility::registersharedfunc( #"pack_a_punch", #"pap_fx_override", &function_6965a67190e085ef );
    utility::registersharedfunc( #"veh_pluto", #"on_breakdown", &function_cadac76a5d6fe53a );
    utility::registersharedfunc( #"veh_pluto", #"hash_c178a73f5131c339", &function_15d83b116cc098b9 );
    utility::registersharedfunc( #"veh_pluto", #"hash_171c9939fdff57dc", &function_4d7343cf17860004 );
    utility::registersharedfunc( #"veh_pluto", #"hash_17a5a9a72280815f", &function_2b4090229bfff6af );
    utility::registersharedfunc( #"veh_pluto", #"on_pluto_teleport", &function_85ea1ebcf7aa4529 );
    utility::registersharedfunc( #"veh_pluto", #"on_attach_head", &function_5314152f5e207d3b );
    utility::registersharedfunc( #"veh_pluto", #"hash_df3c234ed94054f7", &function_26b3cc04f515132c );
    utility::registersharedfunc( #"veh_pluto", #"hash_ee3a6dc51896d3d8", &function_eb9437e8c03d6ff5 );
    scriptable::scriptable_addusedcallbackbypart( "pap_usable", &pluto_pap_use );
    scriptable::scriptable_adddamagedcallback( &function_e6841f5e49f1eb39 );
    level utility::flag_set( "pluto_functions_registered" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x9863da15, Offset: 0x2a4
// Size: 0x13
function private on_pluto_spawned_zm( params )
{
    thread function_cb0ebdcb06cfe3fa();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xc0c87138, Offset: 0x2bf
// Size: 0x3b
function private function_cb0ebdcb06cfe3fa()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"hash_8c5d9655be6145c9" );
    level utility::flag_wait( "zm_game_over" );
    function_bb9f7ad1d8460570();
}

