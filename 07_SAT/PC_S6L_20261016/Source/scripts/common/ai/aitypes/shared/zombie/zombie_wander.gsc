// scripts\common\ai\aitypes\shared\zombie\zombie_wander.gsc  (hash_40b59d0e3258fa0e.gscc) (size: 1356 Bytes / 0x54c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee7bfefc (4001103612)
// size ...... 1356 (0x54c)
// includes .. 2   (offset: 0x4f0)
// strings ... 5   (offset: 0x500)
// dev strs .. 0   (offset: 0x54c)
// exports ... 3   (offset: 0x370)
// cseg ...... 0xbb + 0x2b5 (0x370)
// imports ... 9   (offset: 0x3e8)
// animtree1 . 0   (offset: 0x54c)
// animtree2 . 0   (offset: 0x54c)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\values;

#namespace zombie_wander;

// Namespace zombie_wander
// Params 0
// Checksum 0xc0435fdf, Offset: 0xd9
// Size: 0x5b
function function_19c231bdb6f3a83a()
{
    if ( isdefined( self._blackboard.var_8d34ab856208146f ) && isdefined( self._blackboard.var_dd1cb4e12c4c12d2 ) )
    {
        self._blackboard.var_8d34ab856208146f = 0;
        self._blackboard.var_dd1cb4e12c4c12d2 = -1;
    }
}

// Namespace zombie_wander
// Params 2
// Checksum 0x90ac684c, Offset: 0x13c
// Size: 0x234
function wander_listener( var_274405aedd3a2e2d, var_d75b19704bd63a8d )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"wander_start" );
        
        if ( zombie_utils::get_zombie_round_difficulty() > 20 && self.var_d6894f01a36b4ff3.var_870436057aca227 )
        {
            move_speed = self.var_d6894f01a36b4ff3.var_870436057aca227;
        }
        else
        {
            move_speed = self.var_d6894f01a36b4ff3.wandermovetype;
        }
        
        zombie_utils::function_a8ce00e0448cb6f0( move_speed, "wander", 22 );
        
        if ( !self.var_d6894f01a36b4ff3.var_cfb7412a183301ad )
        {
            val::set( "wander_listener", "collide_with_ai_allies", 0 );
        }
        
        if ( !self.var_d6894f01a36b4ff3.var_cb500ace9989e397 )
        {
            val::set( "wander_listener", "script_pushable_by_ai", 0 );
            val::set( "wander_listener", "script_pushable", 0 );
        }
        
        if ( self.turnrate > 0 && self.var_d6894f01a36b4ff3.var_9660839af3193e78 > 0 )
        {
            self.turnrate *= self.var_d6894f01a36b4ff3.var_9660839af3193e78;
        }
        
        if ( !self.var_d6894f01a36b4ff3.var_ec76dfc5bca09867 )
        {
            enabled_traversals = self function_3e35d42cc05b0324();
            self enabletraversals( 0 );
        }
        
        if ( isfunction( var_274405aedd3a2e2d ) )
        {
            self [[ var_274405aedd3a2e2d ]]();
        }
        
        self waittill( #"wander_end" );
        zombie_utils::function_a8ce00e0448cb6f0( undefined, "wander" );
        val::reset_all( "wander_listener" );
        
        if ( self.turnrate > 0 && self.var_d6894f01a36b4ff3.var_9660839af3193e78 > 0 )
        {
            self.turnrate /= self.var_d6894f01a36b4ff3.var_9660839af3193e78;
        }
        
        if ( !self.var_d6894f01a36b4ff3.var_ec76dfc5bca09867 )
        {
            self enabletraversals( 1, flat_args( enabled_traversals, enabled_traversals.size ) );
        }
        
        if ( isfunction( var_d75b19704bd63a8d ) )
        {
            self [[ var_d75b19704bd63a8d ]]();
        }
    }
}

