// scripts\common\ai\aitypes\zombie_loom_minion\zombie_loom_minion_ranged_attack.gsc  (hash_62e7adba38537fff.gscc) (size: 3126 Bytes / 0xc36 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf986aa7 (2946001575)
// size ...... 3126 (0xc36)
// includes .. 6   (offset: 0xb5a)
// strings ... 8   (offset: 0xb8a)
// dev strs .. 5   (offset: 0xbfa)
// exports ... 13  (offset: 0x65e)
// cseg ...... 0x146 + 0x518 (0x65e)
// imports ... 26  (offset: 0x866)
// animtree1 . 0   (offset: 0xc36)
// animtree2 . 0   (offset: 0xc36)
#using script_30a9571ffe15fb54;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_loom_minion_ranged_attack;

// Namespace zombie_loom_minion_ranged_attack
// Params 1
// Checksum 0xdc2a55a, Offset: 0x164
// Size: 0x54
function function_ad0f6ba5cb0ba286( aitypescriptbundle )
{
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "loom_minion_ranged_attack_impact_fx", var_4b4d72d84afd1ebd.var_12c1e32265d76612 );
        utility::add_fx( "loom_minion_ranged_attack_screen_fx", var_4b4d72d84afd1ebd.var_ff4cb74a4737da78 );
    }
}

// Namespace zombie_loom_minion_ranged_attack
// Params 0
// Checksum 0x95ce8c9d, Offset: 0x1c0
// Size: 0x42
function function_881c914a4f3b43ab()
{
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &function_7bc0da1e96600b73 );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &function_5145724237dbaba0 );
}

// Namespace zombie_loom_minion_ranged_attack
// Params 0
// Checksum 0xa47c8367, Offset: 0x20a
// Size: 0x1da
function init_zombie_loom_minion_ranged_attack()
{
    thread function_c1583b59d9b9ef64();
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
    self.var_697845a75531a531 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_697845a75531a531;
    self.var_77b43222d017d38a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_77b43222d017d38a;
    self.var_a4ce25555468ce2f = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a4ce25555468ce2f;
    self.var_554143a73ca3a67d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_554143a73ca3a67d;
    self.var_4f5bcdc39e31d440 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4f5bcdc39e31d440;
    self.var_440882cde5a176f6 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_440882cde5a176f6;
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = 1;
    }
    
    self function_786bb6aa1b76c7ee( "web_projectile_max_target_count", self.var_577dec43cf1caedf );
    self function_786bb6aa1b76c7ee( "preferred_ranged_attack_dist", self.var_d6894f01a36b4ff3.var_8f2dbb63d0d0a2bd );
    thread namespace_67309db3d9145ae0::track_target_angles();
    
    /#
        setup_ranged_attack_devgui();
    #/
}

// Namespace zombie_loom_minion_ranged_attack
// Params 1
// Checksum 0x22d83c9, Offset: 0x3ec
// Size: 0x1e
function request_ranged_attack( target_ent )
{
    self.ranged_attack_target = target_ent;
    namespace_67309db3d9145ae0::function_8b1372bc3a2d158e();
}

// Namespace zombie_loom_minion_ranged_attack
// Params 0, eflags: 0x4
// Checksum 0x6005566e, Offset: 0x412
// Size: 0x54
function private function_c1583b59d9b9ef64()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        assert( !self._blackboard.var_99f794dc99944d15, "<dev string:x24>" );
        request_ranged_attack( self.enemy );
    }
}

// Namespace zombie_loom_minion_ranged_attack
// Params 0
// Checksum 0x75049fd1, Offset: 0x46e
// Size: 0x16, Type: bool
function is_in_ranged_attack()
{
    return istrue( self._blackboard.var_65f32caa86b87a2 );
}

// Namespace zombie_loom_minion_ranged_attack
// Params 1, eflags: 0x4
// Checksum 0x1f04bc43, Offset: 0x48d
// Size: 0x26
function private function_7bc0da1e96600b73( params )
{
    enable_loom_minion_ranged_attack( 0 );
    val::set( "out_playable_space", "script_pushable_by_ai", 0 );
}

// Namespace zombie_loom_minion_ranged_attack
// Params 1, eflags: 0x4
// Checksum 0x8412ccfc, Offset: 0x4bb
// Size: 0x26
function private function_5145724237dbaba0( params )
{
    enable_loom_minion_ranged_attack( 1 );
    val::reset( "out_playable_space", "script_pushable_by_ai" );
}

// Namespace zombie_loom_minion_ranged_attack
// Params 1, eflags: 0x4
// Checksum 0x1f0e51d5, Offset: 0x4e9
// Size: 0x3a
function private enable_loom_minion_ranged_attack( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e && !self.b_in_spawn_closet )
    {
        self function_f2df0257c63f229( "disable_ranged_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_ranged_attack", 1 );
}

// Namespace zombie_loom_minion_ranged_attack
// Params 5, eflags: 0x4
// Checksum 0xbadad6af, Offset: 0x52b
// Size: 0x6f
function private function_2408adb3cab0c16c( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( isdefined( eattacker.ranged_grenade_damage ) && isdefined( eattacker.grenadeweapon ) && objweapon == eattacker.grenadeweapon )
    {
        idamage = eattacker.ranged_grenade_damage;
    }
    
    return idamage;
}

/#

    // Namespace zombie_loom_minion_ranged_attack
    // Params 0
    // Checksum 0xb586ca54, Offset: 0x5a3
    // Size: 0x30, Type: dev
    function setup_ranged_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5a>" );
        devgui::add_devgui_func( "<dev string:x77>", "<dev string:x8c>", &toggle_ranged_attack, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_loom_minion_ranged_attack
    // Params 0, eflags: 0x4
    // Checksum 0xf2c4b974, Offset: 0x5db
    // Size: 0x83, Type: dev
    function private toggle_ranged_attack()
    {
        loom_minion = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xa1>" );
        
        while ( true )
        {
            if ( !isalive( loom_minion ) )
            {
                return;
            }
            
            if ( isdefined( loom_minion.enemy ) && !loom_minion._blackboard.var_65f32caa86b87a2 )
            {
                loom_minion request_ranged_attack( loom_minion.enemy );
            }
            
            waitframe();
        }
    }

#/
