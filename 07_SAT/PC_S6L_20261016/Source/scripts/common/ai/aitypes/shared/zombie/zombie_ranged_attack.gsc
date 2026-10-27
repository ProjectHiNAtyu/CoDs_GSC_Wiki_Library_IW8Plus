// scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack.gsc  (hash_7249d2bc885b60ef.gscc) (size: 1131 Bytes / 0x46b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x687cf9f (109563807)
// size ...... 1131 (0x46b)
// includes .. 1   (offset: 0x463)
// strings ... 0   (offset: 0x46b)
// dev strs .. 0   (offset: 0x46b)
// exports ... 6   (offset: 0x2a7)
// cseg ...... 0x58 + 0x24f (0x2a7)
// imports ... 7   (offset: 0x397)
// animtree1 . 0   (offset: 0x46b)
// animtree2 . 0   (offset: 0x46b)
#using script_359b0b3edb7487ee;

#namespace zombie_ranged_attack;

// Namespace zombie_ranged_attack
// Params 0
// Checksum 0x2e673398, Offset: 0x76
// Size: 0xb4
function init_zombie_ranged_attack()
{
    if ( !self.var_d6894f01a36b4ff3.var_61f7cb9d1effbf0a )
    {
        return;
    }
    
    thread function_c1583b59d9b9ef64();
    self._blackboard.var_3c7d7ae944556d92 = int( self.var_d6894f01a36b4ff3.var_26c04115883926d8 * 1000 );
    self._blackboard.var_3c5a84e9442f3bd8 = int( self.var_d6894f01a36b4ff3.var_26e35715885f9ef2 * 1000 );
    self._blackboard.var_d751dec818290f98 = self.var_d6894f01a36b4ff3.var_9d909c03fc59c1b1;
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
}

// Namespace zombie_ranged_attack
// Params 0
// Checksum 0xfdda5276, Offset: 0x132
// Size: 0x16, Type: bool
function is_in_ranged_attack()
{
    return istrue( self._blackboard.var_65f32caa86b87a2 );
}

// Namespace zombie_ranged_attack
// Params 0
// Checksum 0xab8c4067, Offset: 0x151
// Size: 0x40
function force_ranged_attack()
{
    self._blackboard.var_65f32caa86b87a2 = 1;
    self._blackboard.var_7ba1c73f07fdd7ae = randomint( 2 ) == 0;
    self notify( #"ranged_attack_enemy_start" );
}

// Namespace zombie_ranged_attack
// Params 0, eflags: 0x4
// Checksum 0x29952851, Offset: 0x199
// Size: 0x33
function private function_c1583b59d9b9ef64()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        zombie_ranged_attack_asm::function_8b1372bc3a2d158e( self.enemy );
    }
}

// Namespace zombie_ranged_attack
// Params 5, eflags: 0x4
// Checksum 0x5c8d9d4b, Offset: 0x1d4
// Size: 0xd2
function private function_2408adb3cab0c16c( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( eattacker.grenadeweapon && objweapon == eattacker.grenadeweapon )
    {
        if ( eattacker.var_d6894f01a36b4ff3.var_794ee7b60b0d8ed5 && isdefined( eattacker.ranged_damage_multiplier ) )
        {
            idamage = int( ceil( idamage * eattacker.ranged_damage_multiplier ) );
            
            if ( eattacker.var_7977644af14eab4e )
            {
                idamage = minint( idamage, eattacker.maxdamagecap );
            }
        }
        else if ( isdefined( eattacker.ranged_grenade_damage ) )
        {
            idamage = eattacker.ranged_grenade_damage;
        }
    }
    
    return idamage;
}

