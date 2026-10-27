// scripts\mp\ob\supers\death_machine.gsc  (hash_20c3965bcda8cb95.gscc) (size: 831 Bytes / 0x33f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97ceaff2 (2546905074)
// size ...... 831 (0x33f)
// includes .. 2   (offset: 0x303)
// strings ... 1   (offset: 0x313)
// dev strs .. 2   (offset: 0x327)
// exports ... 4   (offset: 0x17f)
// cseg ...... 0x6f + 0x110 (0x17f)
// imports ... 8   (offset: 0x21f)
// animtree1 . 0   (offset: 0x33f)
// animtree2 . 0   (offset: 0x33f)
#using scripts\common\callbacks;
#using scripts\mp\supers;

#namespace death_machine;

// Namespace death_machine
// Params 0, eflags: 0x5
// Checksum 0x7811d9a, Offset: 0x8d
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace death_machine
// Params 1, eflags: 0x4
// Checksum 0x9508e84, Offset: 0xad
// Size: 0x76
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_death_machine" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_death_machine", undefined, undefined, &begin_use );
}

// Namespace death_machine
// Params 0, eflags: 0x4
// Checksum 0xac9dedca, Offset: 0x12b
// Size: 0x53, Type: bool
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_death_machine" );
    
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x4d>" );
        return false;
    }
    
    if ( callback::exists_any( #"super_death_machine_begin_use" ) )
    {
        callback::callback( #"super_death_machine_begin_use" );
    }
    
    return true;
}

