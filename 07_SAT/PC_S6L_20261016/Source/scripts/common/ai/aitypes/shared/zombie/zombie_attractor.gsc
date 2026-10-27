// scripts\common\ai\aitypes\shared\zombie\zombie_attractor.gsc  (hash_7709f621405a352f.gscc) (size: 947 Bytes / 0x3b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf64e4e88 (4132327048)
// size ...... 947 (0x3b3)
// includes .. 2   (offset: 0x387)
// strings ... 2   (offset: 0x397)
// dev strs .. 0   (offset: 0x3b3)
// exports ... 4   (offset: 0x207)
// cseg ...... 0x70 + 0x197 (0x207)
// imports ... 8   (offset: 0x2a7)
// animtree1 . 0   (offset: 0x3b3)
// animtree2 . 0   (offset: 0x3b3)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;

#namespace zombie_attractor;

// Namespace zombie_attractor
// Params 2
// Checksum 0x7aa254d9, Offset: 0x8e
// Size: 0xb2
function function_3bc77d754dfe41fa( taskid, params )
{
    range = zombie_utils::function_b292d64a276f14cc( params );
    
    if ( !isdefined( self.target_attractor ) || !self.target_attractor.var_927d86585b9a5ff7 )
    {
        return anim.failure;
    }
    
    var_ff2b7fc48d289912 = zombie_attractor_manager::function_f84fb37f6c524103();
    
    if ( distancesquared( var_ff2b7fc48d289912.goal, var_ff2b7fc48d289912.var_6ce9a7aa61a7a265 ) > squared( range ) )
    {
        return anim.failure;
    }
    
    zombie_utils::update_bt_goal( var_ff2b7fc48d289912.var_6ce9a7aa61a7a265 );
    return anim.success;
}

// Namespace zombie_attractor
// Params 2
// Checksum 0xe7a2fea9, Offset: 0x149
// Size: 0x58
function function_61be2fefc57f73e( taskid, params )
{
    move_speed = params;
    
    if ( move_speed == "" )
    {
        return anim.failure;
    }
    
    thread zombie_utils::function_a8ce00e0448cb6f0( move_speed, "zombie_attractor", 34 );
    thread function_e1d60810b7a524af();
    return anim.success;
}

// Namespace zombie_attractor
// Params 0, eflags: 0xc
// Checksum 0x3a67e467, Offset: 0x1aa
// Size: 0x5d
function private function_e1d60810b7a524af()
{
    self notify( #"hash_cc1b3b16d2062cb5" );
    self endon( #"hash_cc1b3b16d2062cb5" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !self.target_attractor )
        {
            zombie_utils::function_a8ce00e0448cb6f0( undefined, "zombie_attractor", 34 );
            return;
        }
        
        wait 0.1;
    }
}

