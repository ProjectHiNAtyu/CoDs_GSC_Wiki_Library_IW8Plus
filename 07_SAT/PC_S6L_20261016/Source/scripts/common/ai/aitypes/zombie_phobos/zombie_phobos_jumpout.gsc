// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_jumpout.gsc  (hash_1f14fd3ab70df73b.gscc) (size: 2305 Bytes / 0x901 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4836acd9 (1211542745)
// size ...... 2305 (0x901)
// includes .. 5   (offset: 0x855)
// strings ... 4   (offset: 0x87d)
// dev strs .. 7   (offset: 0x8ad)
// exports ... 13  (offset: 0x3f1)
// cseg ...... 0xa6 + 0x34b (0x3f1)
// imports ... 21  (offset: 0x5f9)
// animtree1 . 0   (offset: 0x901)
// animtree2 . 0   (offset: 0x901)
#using script_31af9060592e982c;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_phobos_jumpout;

/#

    // Namespace zombie_phobos_jumpout
    // Params 0
    // Checksum 0x50454733, Offset: 0xc4
    // Size: 0xc, Type: dev
    function function_6730a542a916ec66()
    {
        function_d161f08d54ddc447();
    }

#/

// Namespace zombie_phobos_jumpout
// Params 0
// Checksum 0x5eb93166, Offset: 0xd8
// Size: 0x6c
function init_zombie_phobos_jumpout()
{
    self.jumpout_target_position = level.var_ba95f1c82a1e4864;
    self.jumpout_target_angles = level.var_bce8f43a90c314d7;
    self.jumpin_target_position = level.jumpin_target_position;
    self.var_3e7ce8b4199afa2f = [ 0.75, 0.5, 0.25, 0 ];
    self.var_695bf72a6ac5e395 = 0;
}

// Namespace zombie_phobos_jumpout
// Params 2
// Checksum 0x5d96c50e, Offset: 0x14c
// Size: 0xf9
function function_ba29f7288173215f( taskid, params )
{
    if ( is_outside_arena() )
    {
        return anim.running;
    }
    
    if ( getdvarint( @"hash_24afcfc731250b7c", 1 ) <= 0 )
    {
        return anim.failure;
    }
    
    if ( !isdefined( self.jumpout_target_position ) )
    {
        return anim.failure;
    }
    
    var_bfd9a1b518cc6aa6 = self.health / self.maxhealth;
    health_percent_trigger = self.var_3e7ce8b4199afa2f[ self.var_695bf72a6ac5e395 ];
    
    if ( var_bfd9a1b518cc6aa6 < health_percent_trigger )
    {
        self.var_695bf72a6ac5e395 = int( min( self.var_695bf72a6ac5e395 + 1, self.var_3e7ce8b4199afa2f.size - 1 ) );
        namespace_c0f9e550c4119589::function_7606688f5fd124c6();
        thread function_17b35c565e8289cb();
        level callback::callback( "phobos_jump_out" );
        return anim.running;
    }
    
    return anim.failure;
}

// Namespace zombie_phobos_jumpout
// Params 1
// Checksum 0x5b6f586b, Offset: 0x24e
// Size: 0x17
function set_jumpout_position( jumpout_target_position )
{
    self.jumpout_target_position = jumpout_target_position;
}

// Namespace zombie_phobos_jumpout
// Params 1
// Checksum 0xdded7e58, Offset: 0x26d
// Size: 0x17
function set_jumpout_angles( jumpout_target_angles )
{
    self.jumpout_target_angles = jumpout_target_angles;
}

// Namespace zombie_phobos_jumpout
// Params 0
// Checksum 0x53d7a2ce, Offset: 0x28c
// Size: 0xc
function is_outside_arena()
{
    return self getaiblackboarddynamic( "is_outside_arena" );
}

// Namespace zombie_phobos_jumpout
// Params 0
// Checksum 0xab54852d, Offset: 0x2a1
// Size: 0x1f
function function_aa28bc246d1fda07()
{
    var_9ba1a01631fdde95 = getdvarfloat( @"hash_35f059bbd867e7bd", 40 );
    return var_9ba1a01631fdde95;
}

// Namespace zombie_phobos_jumpout
// Params 0, eflags: 0x4
// Checksum 0x276719d7, Offset: 0x2c9
// Size: 0x3f
function private function_17b35c565e8289cb()
{
    var_9ba1a01631fdde95 = function_aa28bc246d1fda07();
    utility::waittill_notify_or_timeout( "outside_arena_end", var_9ba1a01631fdde95 );
    
    if ( is_outside_arena() )
    {
        level callback::callback( "phobos_jump_in" );
        namespace_c0f9e550c4119589::function_7606688f5fd124c6();
    }
}

/#

    // Namespace zombie_phobos_jumpout
    // Params 0, eflags: 0x4
    // Checksum 0xbd5ba5c0, Offset: 0x310
    // Size: 0x44, Type: dev
    function private function_d161f08d54ddc447()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x4a>", &force_jumpout );
        devgui::add_devgui_func( "<dev string:x5f>", "<dev string:x6d>", &function_f9742e85b2f4cd55 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_jumpout
    // Params 1, eflags: 0x4
    // Checksum 0x8317c2e1, Offset: 0x35c
    // Size: 0x4b, Type: dev
    function private force_jumpout( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x89>" );
        
        if ( isdefined( phobos ) )
        {
            phobos namespace_c0f9e550c4119589::function_7606688f5fd124c6();
        }
    }

    // Namespace zombie_phobos_jumpout
    // Params 1, eflags: 0x4
    // Checksum 0xc8e48c4c, Offset: 0x3af
    // Size: 0x24, Type: dev
    function private function_f9742e85b2f4cd55( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x97>", @"hash_339af1b3500c22f6" );
    }

    // Namespace zombie_phobos_jumpout
    // Params 0, eflags: 0x4
    // Checksum 0xd976ba26, Offset: 0x3db
    // Size: 0x16, Type: dev
    function private debug_jumpout()
    {
        return getdvarint( @"hash_339af1b3500c22f6", 0 ) > 0;
    }

#/
