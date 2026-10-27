// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rap.gsc  (hash_4cc529bc74743501.gscc) (size: 698 Bytes / 0x2ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4184bb9d (1099217821)
// size ...... 698 (0x2ba)
// includes .. 1   (offset: 0x29a)
// strings ... 2   (offset: 0x2a2)
// dev strs .. 0   (offset: 0x2ba)
// exports ... 3   (offset: 0x1b2)
// cseg ...... 0x74 + 0x13e (0x1b2)
// imports ... 4   (offset: 0x22a)
// animtree1 . 0   (offset: 0x2ba)
// animtree2 . 0   (offset: 0x2ba)
#using scripts\common\system;

#namespace zm_sat_locust_rap;

// Namespace zm_sat_locust_rap
// Params 0, eflags: 0x5
// Checksum 0xd3119225, Offset: 0x92
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"locust_rap", #"safe_area", undefined, &post_main );
}

// Namespace zm_sat_locust_rap
// Params 0, eflags: 0x4
// Checksum 0x3c30102, Offset: 0xbb
// Size: 0xf7
function private post_main()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    interactions = [];
    
    foreach ( node in level.safe_area.nodes )
    {
        if ( node.enter.script_flag_set == "foot_rap" || node.enter.script_flag_set == "shoulder_rap" )
        {
            interactions[ interactions.size ] = node.enter;
        }
    }
    
    level.var_db1ca16030498d75 = { #interactions:interactions };
}

