// scripts\common\ai\aitypes\zombie_base\zombie_base_emergence_spawning.gsc  (hash_1e201f103b99a7a8.gscc) (size: 1357 Bytes / 0x54d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x311a61dc (823812572)
// size ...... 1357 (0x54d)
// includes .. 4   (offset: 0x4fd)
// strings ... 4   (offset: 0x51d)
// dev strs .. 0   (offset: 0x54d)
// exports ... 7   (offset: 0x275)
// cseg ...... 0xdc + 0x199 (0x275)
// imports ... 13  (offset: 0x38d)
// animtree1 . 0   (offset: 0x54d)
// animtree2 . 0   (offset: 0x54d)
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_base_emergence_spawning;

// Namespace zombie_base_emergence_spawning
// Params 0
// Checksum 0x43320e06, Offset: 0xfa
// Size: 0x22
function function_5424383cc2c5d969()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &should_disable_emergence_spawning );
}

// Namespace zombie_base_emergence_spawning
// Params 0
// Checksum 0x39c679ee, Offset: 0x124
// Size: 0x15
function init_zombie_base_emergence_spawning()
{
    namespace_659599414270bd0a::register_emergence_spawning_through_death_func( &function_88fe73b39bedf2ee );
    thread function_2fdec2227163a8e6();
}

// Namespace zombie_base_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x8cb83e2e, Offset: 0x141
// Size: 0x2b
function private function_2fdec2227163a8e6()
{
    self endon( #"death" );
    utility::ent_flag_wait( "post_host_spawn_enable_emergence_spawning_through_death_finished" );
    callback::add( "on_zombie_ai_damaged", &function_c9ae28ffcc107c8 );
}

// Namespace zombie_base_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x18e2cc9, Offset: 0x174
// Size: 0x76
function private function_c9ae28ffcc107c8( dmg_struct )
{
    if ( dmg_struct.idamage >= self.health && gettime() != self._blackboard.var_d922503bad49d017 )
    {
        if ( gettime() - self._blackboard.var_d922503bad49d017 <= 500 )
        {
            self._blackboard.var_1499c965638cbfd7 = 0;
        }
    }
}

// Namespace zombie_base_emergence_spawning
// Params 2, eflags: 0x4
// Checksum 0x6df4b795, Offset: 0x1f2
// Size: 0x29
function private function_88fe73b39bedf2ee( corpse, spawning_ai_subclass )
{
    if ( spawning_ai_subclass == "zombie_vermin" )
    {
        corpse namespace_b76ff2659823e89d::function_a6a09861ae148e04();
    }
}

// Namespace zombie_base_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x5eaf2f68, Offset: 0x223
// Size: 0x52
function private should_disable_emergence_spawning( params )
{
    if ( namespace_b76ff2659823e89d::function_29164cae62119e2f( params.eattacker, params.shitloc, params.eattacker.currentprimaryweapon, params.idamage ) )
    {
        namespace_659599414270bd0a::function_80623a2279a4d888();
    }
}

