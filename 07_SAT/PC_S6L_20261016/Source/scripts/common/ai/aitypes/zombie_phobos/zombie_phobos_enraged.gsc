// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_enraged.gsc  (hash_08f5fd77c34416a9.gscc) (size: 2083 Bytes / 0x823 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1f472df (3790893791)
// size ...... 2083 (0x823)
// includes .. 4   (offset: 0x737)
// strings ... 9   (offset: 0x757)
// dev strs .. 7   (offset: 0x7cf)
// exports ... 10  (offset: 0x383)
// cseg ...... 0xea + 0x299 (0x383)
// imports ... 19  (offset: 0x513)
// animtree1 . 0   (offset: 0x823)
// animtree2 . 0   (offset: 0x823)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_phobos_enraged;

/#

    // Namespace zombie_phobos_enraged
    // Params 0
    // Checksum 0x415f99dc, Offset: 0x108
    // Size: 0xc, Type: dev
    function function_2487cd4ddfbb9cdc()
    {
        function_3807f593c08b6aa1();
    }

#/

// Namespace zombie_phobos_enraged
// Params 0
// Checksum 0xd6c56392, Offset: 0x11c
// Size: 0x2
function init_zombie_phobos_enraged()
{
    
}

// Namespace zombie_phobos_enraged
// Params 2
// Checksum 0x199eb3a3, Offset: 0x126
// Size: 0xdd
function function_a312daddd9ac722e( taskid, params )
{
    if ( is_enraged() )
    {
        return anim.failure;
    }
    
    if ( self.disableenraged )
    {
        return anim.failure;
    }
    
    enraged_health_percent = self.enraged_health_percent ?? 0.5;
    enraged_health_percent = getdvarfloat( @"phobos_health_percent", enraged_health_percent );
    enraged_health_threshold = self.maxhealth * enraged_health_percent;
    
    if ( self.health > enraged_health_threshold )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "in_enraged_transformation" ) > 0 )
    {
        return anim.running;
    }
    
    if ( self getaiblackboarddynamic( "enraged_requested" ) > 0 )
    {
        return anim.running;
    }
    
    thread set_enraged();
    return anim.running;
}

// Namespace zombie_phobos_enraged
// Params 0
// Checksum 0x42cd7c51, Offset: 0x20c
// Size: 0x15, Type: bool
function is_enraged()
{
    if ( self getaiblackboarddynamic( "is_enraged" ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_phobos_enraged
// Params 0
// Checksum 0x9cba1d36, Offset: 0x22a
// Size: 0x70
function set_enraged()
{
    self function_786bb6aa1b76c7ee( "enraged_requested", 1 );
    self waittill( #"enraged_start_anim" );
    zombie_utils::function_a8ce00e0448cb6f0( "run", "enraged", 25 );
    utility::function_7c10ea82c1e305b8( "enraged", "on" );
    utility::function_7c10ea82c1e305b8( "eye", "enraged" );
    wait 2.5;
    level callback::callback( "phobos_enraged_start_vo" );
    callback::callback( "phobos_enraged_start" );
}

/#

    // Namespace zombie_phobos_enraged
    // Params 0, eflags: 0x4
    // Checksum 0x7466c569, Offset: 0x2a2
    // Size: 0x44, Type: dev
    function private function_3807f593c08b6aa1()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x4a>", &force_enraged );
        devgui::add_devgui_func( "<dev string:x5f>", "<dev string:x6d>", &toggle_enraged_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_enraged
    // Params 1, eflags: 0x4
    // Checksum 0xb1f26446, Offset: 0x2ee
    // Size: 0x4b, Type: dev
    function private force_enraged( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x89>" );
        
        if ( isdefined( phobos ) )
        {
            phobos set_enraged();
        }
    }

    // Namespace zombie_phobos_enraged
    // Params 1, eflags: 0x4
    // Checksum 0x4563b419, Offset: 0x341
    // Size: 0x24, Type: dev
    function private toggle_enraged_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x97>", @"hash_afec1a4f0f9e6c38" );
    }

    // Namespace zombie_phobos_enraged
    // Params 0, eflags: 0x4
    // Checksum 0x5bd4cb92, Offset: 0x36d
    // Size: 0x16, Type: dev
    function private debug_enraged()
    {
        return getdvarint( @"hash_afec1a4f0f9e6c38", 0 ) > 0;
    }

#/
