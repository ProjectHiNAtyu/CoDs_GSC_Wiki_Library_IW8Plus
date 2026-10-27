// script_afbad667a4b21ca  (hash_0afbad667a4b21ca.gscc) (size: 3571 Bytes / 0xdf3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x805d68ff (2153605375)
// size ...... 3571 (0xdf3)
// includes .. 9   (offset: 0xd73)
// strings ... 4   (offset: 0xdbb)
// dev strs .. 0   (offset: 0xdf3)
// exports ... 6   (offset: 0x963)
// cseg ...... 0x94 + 0x8cf (0x963)
// imports ... 24  (offset: 0xa53)
// animtree1 . 0   (offset: 0xdf3)
// animtree2 . 0   (offset: 0xdf3)
#using script_12c13822ade2c7b7;
#using script_359c9cda9983c8fc;
#using script_3a014b542599e1e;
#using script_3d224bcd5ba96094;
#using script_69e82e1f2f6d8101;
#using script_afb92aa9b64cf81;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\utility;

#namespace zombie_triton_scaling;

// Namespace zombie_triton_scaling
// Params 0
// Checksum 0xe81b89c2, Offset: 0xb2
// Size: 0x9
function init_zombie_triton_scaling()
{
    function_119c0a8fb9952b8a();
}

// Namespace zombie_triton_scaling
// Params 0, eflags: 0x4
// Checksum 0xf5874370, Offset: 0xc3
// Size: 0xe2
function private function_119c0a8fb9952b8a()
{
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_444bbbbc32190b7e", 0 ) )
    {
        thread function_41ad39daec244731();
        return;
    }
    
    if ( !isdefined( self.var_d3d0aa57a18342ad ) )
    {
        self.var_d3d0aa57a18342ad = "easy";
    }
    
    if ( self.var_d3d0aa57a18342ad != "intermediate" && level.var_6781718da4f78d1c.roundnumber >= 50 && level.var_6781718da4f78d1c.roundnumber <= 99 )
    {
        self.var_d3d0aa57a18342ad = "intermediate";
        thread function_3060d04da65ad343();
        return;
    }
    
    if ( self.var_d3d0aa57a18342ad != "hard" && level.var_6781718da4f78d1c.roundnumber >= 100 )
    {
        self.var_d3d0aa57a18342ad = "hard";
        thread set_hard_round_difficulty();
    }
}

// Namespace zombie_triton_scaling
// Params 0, eflags: 0x4
// Checksum 0x6c865bd7, Offset: 0x1ad
// Size: 0x2a6
function private function_41ad39daec244731()
{
    self endon( #"death" );
    ai::set_ai_max_health( int( self.maxhealth * 0.3 ) );
    self.health = self.maxhealth;
    wait 1;
    
    if ( isdefined( self.var_77998900691948fb ) && isdefined( self.var_43bac716d39a83e0 ) && isdefined( self.var_47f35434b8887c71 ) )
    {
        zombie_triton_foot_stomp::set_foot_stomp_damage_range( self.var_77998900691948fb - 10, self.var_43bac716d39a83e0 - 10 );
        zombie_triton_targeting::function_b07a430d3df9df65( self.var_47f35434b8887c71 * 1.1 );
    }
    
    if ( isdefined( self.var_778af70bfd34a9a3 ) && isdefined( self.var_b6ac6a074fa88774 ) && isdefined( self.var_cfa45f94ebd0dffb ) && isdefined( self.var_c244b0bc3f1e4031 ) && isdefined( self.var_5dd07c23088a0210 ) && isdefined( self.var_add92a8db3fd2295 ) )
    {
        zombie_triton_ground_slam::function_d8805e4a685f3f76( self.var_778af70bfd34a9a3 - 10 );
        zombie_triton_ground_slam::set_ground_slam_damage_range( self.var_b6ac6a074fa88774 - 10, self.var_cfa45f94ebd0dffb - 10 );
        zombie_triton_ground_slam::set_ground_slam_cooldown( self.var_c244b0bc3f1e4031 * 1.1 );
        zombie_triton_ground_slam::function_cc1ec29ceaa56b0a( self.var_5dd07c23088a0210 * 1.1 );
        zombie_triton_ground_slam::function_7d2f4a95c32d09ce( self.var_add92a8db3fd2295 * 1.1 );
    }
    
    if ( isdefined( self.var_d6fff8ffca6f2d9c ) && isdefined( self.var_ff7608ac9cb1e797 ) && isdefined( self._blackboard.var_61e56d196f8dacad ) && isdefined( self._blackboard.var_2ffd783f1bf107ff ) && isdefined( self._blackboard.var_f1f95501251c9a40 ) && isdefined( self.var_59fbdc5e5b6ae34d ) )
    {
        zombie_triton_leap_slam::function_70de57f35247ce32( self.var_d6fff8ffca6f2d9c - 10 );
        zombie_triton_leap_slam::function_f369021c13ba1f5( self.var_ff7608ac9cb1e797 - 10 );
        namespace_f0563419ebc8af00::set_leap_attack_cooldown( self._blackboard.var_61e56d196f8dacad * 1.1 );
        namespace_f0563419ebc8af00::function_7f43d0ce9021739c( 0.9 );
        namespace_f0563419ebc8af00::function_13586f09be6e9c76( clamp( self._blackboard.var_f1f95501251c9a40 - 0.1, 0, 1 ) );
        zombie_triton_targeting::function_6891912552daaaef( self.var_59fbdc5e5b6ae34d * 1.1 );
    }
    
    if ( isdefined( self.var_4f2a7d74389f9eec ) && isdefined( self.var_7660525b821efd53 ) )
    {
        zombie_triton_lava_bomb::function_a680f6c9f2a4f64c( self.var_4f2a7d74389f9eec * 0.8 );
        zombie_triton_lava_toss::function_723c852530f4779b( self.var_7660525b821efd53 * 1.1 );
    }
}

// Namespace zombie_triton_scaling
// Params 0, eflags: 0x4
// Checksum 0x94de219b, Offset: 0x45b
// Size: 0x27a
function private function_3060d04da65ad343()
{
    self endon( #"death" );
    wait 1;
    
    if ( isdefined( self.var_77998900691948fb ) && isdefined( self.var_43bac716d39a83e0 ) && isdefined( self.var_47f35434b8887c71 ) )
    {
        zombie_triton_foot_stomp::set_foot_stomp_damage_range( self.var_77998900691948fb + 15, self.var_43bac716d39a83e0 + 15 );
        zombie_triton_targeting::function_b07a430d3df9df65( self.var_47f35434b8887c71 * 0.85 );
    }
    
    if ( isdefined( self.var_778af70bfd34a9a3 ) && isdefined( self.var_b6ac6a074fa88774 ) && isdefined( self.var_cfa45f94ebd0dffb ) && isdefined( self.var_c244b0bc3f1e4031 ) && isdefined( self.var_5dd07c23088a0210 ) && isdefined( self.var_add92a8db3fd2295 ) )
    {
        zombie_triton_ground_slam::function_d8805e4a685f3f76( self.var_778af70bfd34a9a3 + 15 );
        zombie_triton_ground_slam::set_ground_slam_damage_range( self.var_b6ac6a074fa88774 + 15, self.var_cfa45f94ebd0dffb + 15 );
        zombie_triton_ground_slam::set_ground_slam_cooldown( self.var_c244b0bc3f1e4031 * 0.85 );
        zombie_triton_ground_slam::function_cc1ec29ceaa56b0a( self.var_5dd07c23088a0210 * 0.85 );
        zombie_triton_ground_slam::function_7d2f4a95c32d09ce( self.var_add92a8db3fd2295 * 0.85 );
    }
    
    if ( isdefined( self.var_d6fff8ffca6f2d9c ) && isdefined( self.var_ff7608ac9cb1e797 ) && isdefined( self._blackboard.var_61e56d196f8dacad ) && isdefined( self._blackboard.var_2ffd783f1bf107ff ) && isdefined( self._blackboard.var_f1f95501251c9a40 ) && isdefined( self.var_59fbdc5e5b6ae34d ) )
    {
        zombie_triton_leap_slam::function_70de57f35247ce32( self.var_d6fff8ffca6f2d9c + 15 );
        zombie_triton_leap_slam::function_f369021c13ba1f5( self.var_ff7608ac9cb1e797 + 15 );
        namespace_f0563419ebc8af00::set_leap_attack_cooldown( self._blackboard.var_61e56d196f8dacad * 0.85 );
        namespace_f0563419ebc8af00::function_7f43d0ce9021739c( 1.1 );
        namespace_f0563419ebc8af00::function_13586f09be6e9c76( clamp( self._blackboard.var_f1f95501251c9a40 + 0.1, 0, 1 ) );
        zombie_triton_targeting::function_6891912552daaaef( self.var_59fbdc5e5b6ae34d * 0.85 );
    }
    
    if ( isdefined( self.var_4f2a7d74389f9eec ) && isdefined( self.var_7660525b821efd53 ) )
    {
        zombie_triton_lava_bomb::function_a680f6c9f2a4f64c( self.var_4f2a7d74389f9eec * 1.2 );
        zombie_triton_lava_toss::function_723c852530f4779b( self.var_7660525b821efd53 * 0.85 );
    }
}

// Namespace zombie_triton_scaling
// Params 0, eflags: 0x4
// Checksum 0xb8ec3b3a, Offset: 0x6dd
// Size: 0x286
function private set_hard_round_difficulty()
{
    self endon( #"death" );
    utility::ent_flag_wait( "zombie_asm_init_finished" );
    wait 1;
    
    if ( isdefined( self.var_77998900691948fb ) && isdefined( self.var_43bac716d39a83e0 ) && isdefined( self.var_47f35434b8887c71 ) )
    {
        zombie_triton_foot_stomp::set_foot_stomp_damage_range( self.var_77998900691948fb + 25, self.var_43bac716d39a83e0 + 25 );
        zombie_triton_targeting::function_b07a430d3df9df65( self.var_47f35434b8887c71 * 0.75 );
    }
    
    if ( isdefined( self.var_778af70bfd34a9a3 ) && isdefined( self.var_b6ac6a074fa88774 ) && isdefined( self.var_cfa45f94ebd0dffb ) && isdefined( self.var_c244b0bc3f1e4031 ) && isdefined( self.var_5dd07c23088a0210 ) && isdefined( self.var_add92a8db3fd2295 ) )
    {
        zombie_triton_ground_slam::function_d8805e4a685f3f76( self.var_778af70bfd34a9a3 + 25 );
        zombie_triton_ground_slam::set_ground_slam_damage_range( self.var_b6ac6a074fa88774 + 25, self.var_cfa45f94ebd0dffb + 25 );
        zombie_triton_ground_slam::set_ground_slam_cooldown( self.var_c244b0bc3f1e4031 * 0.75 );
        zombie_triton_ground_slam::function_cc1ec29ceaa56b0a( self.var_5dd07c23088a0210 * 0.75 );
        zombie_triton_ground_slam::function_7d2f4a95c32d09ce( self.var_add92a8db3fd2295 * 0.75 );
    }
    
    if ( isdefined( self.var_d6fff8ffca6f2d9c ) && isdefined( self.var_ff7608ac9cb1e797 ) && isdefined( self._blackboard.var_61e56d196f8dacad ) && isdefined( self._blackboard.var_2ffd783f1bf107ff ) && isdefined( self._blackboard.var_f1f95501251c9a40 ) && isdefined( self.var_59fbdc5e5b6ae34d ) )
    {
        zombie_triton_leap_slam::function_70de57f35247ce32( self.var_d6fff8ffca6f2d9c + 25 );
        zombie_triton_leap_slam::function_f369021c13ba1f5( self.var_ff7608ac9cb1e797 + 25 );
        namespace_f0563419ebc8af00::set_leap_attack_cooldown( self._blackboard.var_61e56d196f8dacad * 0.75 );
        namespace_f0563419ebc8af00::function_7f43d0ce9021739c( 1.25 );
        namespace_f0563419ebc8af00::function_13586f09be6e9c76( clamp( self._blackboard.var_f1f95501251c9a40 + 0.2, 0, 1 ) );
        zombie_triton_targeting::function_6891912552daaaef( self.var_59fbdc5e5b6ae34d * 0.75 );
    }
    
    if ( isdefined( self.var_4f2a7d74389f9eec ) && isdefined( self.var_7660525b821efd53 ) )
    {
        zombie_triton_lava_bomb::function_a680f6c9f2a4f64c( self.var_4f2a7d74389f9eec * 1.4 );
        zombie_triton_lava_toss::function_723c852530f4779b( self.var_7660525b821efd53 * 0.75 );
    }
}

