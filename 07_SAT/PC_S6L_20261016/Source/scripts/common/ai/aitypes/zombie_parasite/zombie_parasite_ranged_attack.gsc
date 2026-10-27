// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_ranged_attack.gsc  (hash_5023ad5a73bdb7af.gscc) (size: 1985 Bytes / 0x7c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b180908 (991430920)
// size ...... 1985 (0x7c1)
// includes .. 4   (offset: 0x731)
// strings ... 4   (offset: 0x751)
// dev strs .. 5   (offset: 0x785)
// exports ... 8   (offset: 0x3f9)
// cseg ...... 0xcd + 0x32c (0x3f9)
// imports ... 18  (offset: 0x539)
// animtree1 . 0   (offset: 0x7c1)
// animtree2 . 0   (offset: 0x7c1)
#using script_79289efe13773540;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_parasite_ranged_attack;

// Namespace zombie_parasite_ranged_attack
// Params 1
// Checksum 0x96d279d7, Offset: 0xeb
// Size: 0x56
function function_ef838b48185aceb4( aitypescriptbundle )
{
    var_5aa57caf5f1a1879 = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_5aa57caf5f1a1879 ) && isdefined( var_5aa57caf5f1a1879.var_12c1e32265d76612 ) )
    {
        utility::add_fx( "parasite_spit_attack_impact_fx", var_5aa57caf5f1a1879.var_12c1e32265d76612 );
    }
    
    /#
        setup_ranged_attack_devgui();
    #/
}

// Namespace zombie_parasite_ranged_attack
// Params 0
// Checksum 0xa38a484a, Offset: 0x149
// Size: 0xd5
function init_zombie_parasite_ranged_attack()
{
    thread function_c1583b59d9b9ef64();
    var_5aa57caf5f1a1879 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    assert( isdefined( var_5aa57caf5f1a1879 ) );
    
    if ( !isdefined( self.var_577dec43cf1caedf ) )
    {
        self.var_577dec43cf1caedf = var_5aa57caf5f1a1879.var_3d123d088165ef00;
    }
    
    self function_786bb6aa1b76c7ee( "spit_max_target_count", self.var_577dec43cf1caedf );
    
    if ( var_5aa57caf5f1a1879.projectilespeedoverride > 0 )
    {
        self.var_ec263f0a689ef1dd = var_5aa57caf5f1a1879.projectilespeedoverride;
    }
    
    self.var_fe9bb2f0c2468d9a = var_5aa57caf5f1a1879.spitattackmincooldown;
    self.var_95fe29c1ef1d5ac0 = var_5aa57caf5f1a1879.var_1d06b82a61bdb60b;
    self.var_d3a22902cf4978d5 = var_5aa57caf5f1a1879.var_757f9eb87c370364;
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
}

// Namespace zombie_parasite_ranged_attack
// Params 1
// Checksum 0xfb3b2b, Offset: 0x226
// Size: 0x1e
function request_ranged_attack( target_ent )
{
    self.ranged_attack_target = target_ent;
    namespace_75a5bbd3a938f9df::function_8b1372bc3a2d158e();
}

// Namespace zombie_parasite_ranged_attack
// Params 0, eflags: 0x4
// Checksum 0x334c003e, Offset: 0x24c
// Size: 0x72
function private function_c1583b59d9b9ef64()
{
    self endon( #"death" );
    
    while ( true )
    {
        var_a9da764ea9556786 = utility::waittill_any_return( "ranged_attack_enemy_start", "ranged_attack_point_start" );
        assert( !self._blackboard.var_99f794dc99944d15, "<dev string:x24>" );
        request_ranged_attack( var_a9da764ea9556786 == "ranged_attack_enemy_start" ? self.enemy : undefined );
    }
}

// Namespace zombie_parasite_ranged_attack
// Params 5, eflags: 0x4
// Checksum 0xd1f224b0, Offset: 0x2c6
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

    // Namespace zombie_parasite_ranged_attack
    // Params 0
    // Checksum 0x64831e03, Offset: 0x33e
    // Size: 0x30, Type: dev
    function setup_ranged_attack_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5a>" );
        devgui::add_devgui_func( "<dev string:x74>", "<dev string:x89>", &toggle_ranged_attack, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_parasite_ranged_attack
    // Params 0, eflags: 0x4
    // Checksum 0x99ec4b6b, Offset: 0x376
    // Size: 0x83, Type: dev
    function private toggle_ranged_attack()
    {
        parasite = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x9e>" );
        
        while ( true )
        {
            if ( !isalive( parasite ) )
            {
                return;
            }
            
            if ( isdefined( parasite.enemy ) && !parasite._blackboard.var_65f32caa86b87a2 )
            {
                parasite request_ranged_attack( parasite.enemy );
            }
            
            waitframe();
        }
    }

#/
