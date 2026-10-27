// scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_ranged_attack.gsc  (hash_0f10936e542bd38f.gscc) (size: 1990 Bytes / 0x7c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3f0a500 (3824198912)
// size ...... 1990 (0x7c6)
// includes .. 4   (offset: 0x746)
// strings ... 3   (offset: 0x766)
// dev strs .. 5   (offset: 0x78a)
// exports ... 9   (offset: 0x3de)
// cseg ...... 0xba + 0x324 (0x3de)
// imports ... 18  (offset: 0x546)
// animtree1 . 0   (offset: 0x7c6)
// animtree2 . 0   (offset: 0x7c6)
#using script_6be5b69fb724fc48;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_vermin_ranged_attack;

// Namespace zombie_vermin_ranged_attack
// Params 1
// Checksum 0xf62e6db, Offset: 0xd8
// Size: 0x54
function function_3a2616b882541ba7( aitypescriptbundle )
{
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "vermin_ranged_attack_impact_fx", var_4b4d72d84afd1ebd.var_12c1e32265d76612 );
        utility::add_fx( "vermin_ranged_attack_screen_fx", var_4b4d72d84afd1ebd.var_ff4cb74a4737da78 );
    }
}

// Namespace zombie_vermin_ranged_attack
// Params 0
// Checksum 0xfeaacb26, Offset: 0x134
// Size: 0xce
function init_zombie_vermin_ranged_attack()
{
    thread function_c1583b59d9b9ef64();
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
    
    if ( isdefined( self.var_2179456a894d66e ) )
    {
        self function_786bb6aa1b76c7ee( "wallCrawlRangedAttackRange", self.var_2179456a894d66e );
    }
    
    thread namespace_4e91c4ed2c0457c1::track_target_angles();
    
    /#
        setup_ranged_attack_devgui();
    #/
}

// Namespace zombie_vermin_ranged_attack
// Params 1
// Checksum 0xed5d9cf0, Offset: 0x20a
// Size: 0x1e
function request_ranged_attack( target_ent )
{
    self.ranged_attack_target = target_ent;
    namespace_4e91c4ed2c0457c1::function_8b1372bc3a2d158e();
}

// Namespace zombie_vermin_ranged_attack
// Params 0, eflags: 0x4
// Checksum 0xe66cb6f7, Offset: 0x230
// Size: 0x54
function private function_c1583b59d9b9ef64()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_b283f7085796836b" );
        assert( !self._blackboard.var_99f794dc99944d15, "<dev string:x24>" );
        request_ranged_attack( self.enemy );
    }
}

// Namespace zombie_vermin_ranged_attack
// Params 0
// Checksum 0xf36d7f48, Offset: 0x28c
// Size: 0x16, Type: bool
function is_in_ranged_attack()
{
    return istrue( self._blackboard.var_65f32caa86b87a2 );
}

// Namespace zombie_vermin_ranged_attack
// Params 5, eflags: 0x4
// Checksum 0x3cb33636, Offset: 0x2ab
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

    // Namespace zombie_vermin_ranged_attack
    // Params 0
    // Checksum 0x53e2e295, Offset: 0x323
    // Size: 0x30, Type: dev
    function setup_ranged_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5a>" );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x87>", &toggle_ranged_attack, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_vermin_ranged_attack
    // Params 0, eflags: 0x4
    // Checksum 0x74ad59ed, Offset: 0x35b
    // Size: 0x83, Type: dev
    function private toggle_ranged_attack()
    {
        vermin = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x9c>" );
        
        while ( true )
        {
            if ( !isalive( vermin ) )
            {
                return;
            }
            
            if ( isdefined( vermin.enemy ) && !vermin._blackboard.var_65f32caa86b87a2 )
            {
                vermin request_ranged_attack( vermin.enemy );
            }
            
            waitframe();
        }
    }

#/
