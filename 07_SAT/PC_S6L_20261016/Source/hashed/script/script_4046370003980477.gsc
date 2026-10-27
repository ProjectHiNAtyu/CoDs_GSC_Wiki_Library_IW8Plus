// script_4046370003980477  (hash_4046370003980477.gscc) (size: 2288 Bytes / 0x8f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc15ddba1 (3244153761)
// size ...... 2288 (0x8f0)
// includes .. 6   (offset: 0x818)
// strings ... 9   (offset: 0x848)
// dev strs .. 2   (offset: 0x8d8)
// exports ... 8   (offset: 0x468)
// cseg ...... 0xe1 + 0x387 (0x468)
// imports ... 21  (offset: 0x5a8)
// animtree1 . 0   (offset: 0x8f0)
// animtree2 . 0   (offset: 0x8f0)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_web;
#using scripts\common\callbacks;

#namespace namespace_456e43ba4bdef145;

// Namespace namespace_456e43ba4bdef145
// Params 0
// Checksum 0x14b1d5c7, Offset: 0xff
// Size: 0x22
function function_7c1f29ee2fca907e()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_dd14cc754c869f3e );
}

// Namespace namespace_456e43ba4bdef145
// Params 0
// Checksum 0xcf7a8ab6, Offset: 0x129
// Size: 0x61
function init_zombie_loom_minion_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    self.var_dc5ece9232230a99 = squared( self.var_d6894f01a36b4ff3.var_8f2dbb63d0d0a2bd );
    self.var_4fc72c7bdd280673 = squared( self.var_d6894f01a36b4ff3.var_8f2dbb63d0d0a2bd + 100 );
    thread zombie_wander::function_c77a8eaa38883b1c();
    thread function_28b232ff2e6b6094();
    thread reposition_listener();
}

// Namespace namespace_456e43ba4bdef145
// Params 1, eflags: 0x4
// Checksum 0x320d8655, Offset: 0x192
// Size: 0x58
function private function_dd14cc754c869f3e( params )
{
    var_4dd9c210b998e030 = function_565827781d82d7c1();
    
    /#
        record3dtext( "<dev string:x24>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_456e43ba4bdef145
// Params 0, eflags: 0x4
// Checksum 0xe9d4007d, Offset: 0x1f2
// Size: 0xb2
function private function_565827781d82d7c1()
{
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    featurearray = [];
    alias = self function_805ca5e408d630c0( animset, "move_loop", featurearray, 1 );
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
    
    return alias;
}

// Namespace namespace_456e43ba4bdef145
// Params 0, eflags: 0xc
// Checksum 0x8807ec30, Offset: 0x2ad
// Size: 0xd9
function private function_28b232ff2e6b6094()
{
    self notify( #"hash_a62bbde065538157" );
    self endon( #"hash_a62bbde065538157" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( isalive( self.enemy ) && zombie_loom_minion_web::is_entity_webbed( self.enemy, self.var_e66475cc61690441 ) )
        {
            if ( !zombie_utils::function_5585d9e5cf0a0fa0( "sprint_override" ) )
            {
                zombie_utils::function_a8ce00e0448cb6f0( "sprint", "sprint_override", 40 );
            }
        }
        else if ( function_1a1a7a8d33b02d52( self.enemy ) )
        {
            if ( !zombie_utils::function_5585d9e5cf0a0fa0( "sprint_override" ) )
            {
                zombie_utils::function_a8ce00e0448cb6f0( "sprint", "sprint_override", 40 );
            }
        }
        else if ( zombie_utils::function_5585d9e5cf0a0fa0( "sprint_override" ) )
        {
            zombie_utils::function_a8ce00e0448cb6f0( undefined, "sprint_override", 40 );
        }
        
        wait 0.25;
    }
}

// Namespace namespace_456e43ba4bdef145
// Params 1, eflags: 0x4
// Checksum 0x6e159036, Offset: 0x38e
// Size: 0x7f, Type: bool
function private function_1a1a7a8d33b02d52( target )
{
    if ( isalive( self.enemy ) )
    {
        dist_sqr = distancesquared( self.enemy.origin, self.origin );
        
        if ( dist_sqr > self.var_4fc72c7bdd280673 )
        {
            return true;
        }
        else if ( dist_sqr > self.var_dc5ece9232230a99 && zombie_utils::function_5585d9e5cf0a0fa0( "sprint_override" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_456e43ba4bdef145
// Params 0, eflags: 0x4
// Checksum 0x1d0c5c3a, Offset: 0x416
// Size: 0x52
function private reposition_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"reposition_start" );
        zombie_utils::function_a8ce00e0448cb6f0( "walk", "reposition_override", 21 );
        self waittill( #"reposition_end" );
        zombie_utils::function_a8ce00e0448cb6f0( undefined, "reposition_override", 21 );
    }
}

