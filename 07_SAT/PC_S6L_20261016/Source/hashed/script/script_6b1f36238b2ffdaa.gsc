// script_6b1f36238b2ffdaa  (hash_6b1f36238b2ffdaa.gscc) (size: 1657 Bytes / 0x679 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef65b651 (4016420433)
// size ...... 1657 (0x679)
// includes .. 2   (offset: 0x635)
// strings ... 4   (offset: 0x645)
// dev strs .. 0   (offset: 0x679)
// exports ... 7   (offset: 0x3bd)
// cseg ...... 0x9f + 0x31e (0x3bd)
// imports ... 12  (offset: 0x4d5)
// animtree1 . 0   (offset: 0x679)
// animtree2 . 0   (offset: 0x679)
#using scripts\common\callbacks;
#using scripts\common\system;

#namespace namespace_91c762c506fb5dfa;

// Namespace namespace_91c762c506fb5dfa
// Params 0, eflags: 0x5
// Checksum 0xd22246db, Offset: 0xbd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_76d42bd0ac53b1df", #"br_activity_scheduler", &init, undefined );
}

// Namespace namespace_91c762c506fb5dfa
// Params 0, eflags: 0x4
// Checksum 0xeadf3110, Offset: 0xe6
// Size: 0x4b
function private init()
{
    if ( !level.gametypebundle.var_41729606a9fcbc3a )
    {
        return;
    }
    
    var_6cbef891ee2debfb = hashcat( @"hash_3391fc87273dad01", "Down_But_Not_Out" );
    
    if ( getdvarint( var_6cbef891ee2debfb, 0 ) == 0 )
    {
        function_daaf741180d9d22f();
    }
}

// Namespace namespace_91c762c506fb5dfa
// Params 0, eflags: 0x4
// Checksum 0x91b27979, Offset: 0x139
// Size: 0x1da
function private function_daaf741180d9d22f()
{
    var_68f543069583585c = getscriptbundle( level.gametypebundle.var_41729606a9fcbc3a );
    
    if ( !var_68f543069583585c )
    {
        return;
    }
    
    callback::add( #"on_circle_set", &on_circle_set );
    callback::add( #"on_circle_started", &on_circle_close_start );
    level.var_ddaf8edbbbde658a = -1;
    
    foreach ( var_f0251a74c1b8ea3b in var_68f543069583585c.var_a927e81b58c1064f )
    {
        if ( var_f0251a74c1b8ea3b.label == "Down_But_Not_Out" )
        {
            foreach ( trigger in var_f0251a74c1b8ea3b.triggers )
            {
                if ( trigger.variant_object.triggertype == "ON_EACH_CIRCLE" )
                {
                    level.var_ddaf8edbbbde658a = trigger.variant_object.maxcircle - 1;
                    level.var_9f3e65403fec466 = trigger.variant_object.circleevent;
                    break;
                }
            }
            
            break;
        }
    }
    
    setomnvar( o"hash_b7f434c7b7001290", level.var_ddaf8edbbbde658a >= 0 ? 1 : 0 );
}

// Namespace namespace_91c762c506fb5dfa
// Params 1, eflags: 0x4
// Checksum 0x2966df92, Offset: 0x31b
// Size: 0x1a
function private on_circle_set( params )
{
    function_b1a2611817748dd8( "CircleSet", params );
}

// Namespace namespace_91c762c506fb5dfa
// Params 1, eflags: 0x4
// Checksum 0x242630ba, Offset: 0x33d
// Size: 0x1a
function private on_circle_close_start( params )
{
    function_b1a2611817748dd8( "CircleBeginClose", params );
}

// Namespace namespace_91c762c506fb5dfa
// Params 2, eflags: 0x4
// Checksum 0xbe157a45, Offset: 0x35f
// Size: 0x5e
function private function_b1a2611817748dd8( circleevent, var_1a39cca760ef1480 )
{
    if ( level.var_9f3e65403fec466 == circleevent )
    {
        var_15098feff65ac78d = var_1a39cca760ef1480.circleindex < level.var_ddaf8edbbbde658a;
        setomnvar( o"hash_b7f434c7b7001290", var_15098feff65ac78d ? 1 : 0 );
    }
}

