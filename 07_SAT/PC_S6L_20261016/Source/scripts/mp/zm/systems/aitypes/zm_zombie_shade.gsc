// scripts\mp\zm\systems\aitypes\zm_zombie_shade.gsc  (hash_7c29fe6ba1115d77.gscc) (size: 1172 Bytes / 0x494 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b71d3f3 (1265751027)
// size ...... 1172 (0x494)
// includes .. 3   (offset: 0x434)
// strings ... 5   (offset: 0x44c)
// dev strs .. 0   (offset: 0x494)
// exports ... 6   (offset: 0x218)
// cseg ...... 0xaf + 0x169 (0x218)
// imports ... 10  (offset: 0x308)
// animtree1 . 0   (offset: 0x494)
// animtree2 . 0   (offset: 0x494)
#using scripts\common\callbacks;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm_utility;

#namespace zm_zombie_shade;

// Namespace zm_zombie_shade
// Params 2
// Checksum 0xa480080f, Offset: 0xcd
// Size: 0x52
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_5b556548447e9156 ) )
    {
        return;
    }
    
    level.var_5b556548447e9156 = 1;
    level callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &function_c6826f8a7da94528 );
}

// Namespace zm_zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xf24eb8c5, Offset: 0x127
// Size: 0x24
function private function_c6826f8a7da94528( params )
{
    callback::add( "escape_portal_spawned", &function_1d0e4c0baa8aeec0 );
    function_bc3f741de6e9d32a();
}

// Namespace zm_zombie_shade
// Params 0, eflags: 0x4
// Checksum 0x5b572e3a, Offset: 0x153
// Size: 0x4c
function private function_bc3f741de6e9d32a()
{
    round_number = zm_utility::get_round_number();
    
    if ( zm_round_spawning::is_special_round( round_number ) )
    {
        if ( self.b_in_spawn_closet )
        {
            callback::add( "in_playable_space", &force_consume_loot_in_playable_space );
            return;
        }
        
        self function_786bb6aa1b76c7ee( "force_consume_loot", 1 );
    }
}

// Namespace zm_zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x9233aebd, Offset: 0x1a7
// Size: 0x2a
function private force_consume_loot_in_playable_space( params )
{
    self function_786bb6aa1b76c7ee( "force_consume_loot", 1 );
    callback::remove( "in_playable_space", &force_consume_loot_in_playable_space );
}

// Namespace zm_zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xebef69d7, Offset: 0x1d9
// Size: 0x3f
function private function_1d0e4c0baa8aeec0( params )
{
    var_1fe3590ace9a98fb = params.portalspawnpoint;
    self.var_664fc2b93d674b62 = var_1fe3590ace9a98fb;
    callback::remove( "escape_portal_spawned", &function_1d0e4c0baa8aeec0 );
}

