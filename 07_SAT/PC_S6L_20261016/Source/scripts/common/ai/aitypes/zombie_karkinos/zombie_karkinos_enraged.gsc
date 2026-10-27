// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_enraged.gsc  (hash_1442463ff6d46b11.gscc) (size: 1120 Bytes / 0x460 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcf060083 (3473277059)
// size ...... 1120 (0x460)
// includes .. 3   (offset: 0x3e8)
// strings ... 7   (offset: 0x400)
// dev strs .. 0   (offset: 0x460)
// exports ... 4   (offset: 0x28c)
// cseg ...... 0xc9 + 0x1c3 (0x28c)
// imports ... 6   (offset: 0x32c)
// animtree1 . 0   (offset: 0x460)
// animtree2 . 0   (offset: 0x460)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;

#namespace zombie_karkinos_enraged;

// Namespace zombie_karkinos_enraged
// Params 0
// Checksum 0xa5bf072d, Offset: 0xe7
// Size: 0x32
function init_karkinos_enrage()
{
    self.var_782eaac04c44f6d2 = 0;
    self.enrage_duration = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enrageduration;
}

// Namespace zombie_karkinos_enraged
// Params 3
// Checksum 0x594995db, Offset: 0x121
// Size: 0x118
function karkinos_enrage( duration, disable_ranged_attack, end_notify )
{
    self notify( #"hash_4687f0e8865eae8b" );
    self endon( #"hash_4687f0e8865eae8b" );
    self endon( #"death" );
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self function_786bb6aa1b76c7ee( "enter_enraged", 1 );
    self.var_782eaac04c44f6d2 = 1;
    
    if ( disable_ranged_attack )
    {
        self function_786bb6aa1b76c7ee( "disable_ranged_attack", 1 );
    }
    
    self notify( #"vox_enraged" );
    
    if ( self.shield_is_on || self.var_d5ae8d9ff7d863e2 > 0 && metabone::get_metabone_state_name( "claw_shield_weakpoint" ) != "broken" )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "run", "karkinos_enrage", 32 );
    }
    else
    {
        zombie_utils::function_a8ce00e0448cb6f0( "sprint", "karkinos_enrage", 32 );
    }
    
    callback::callback( #"hash_b05c7cceb18ef6b1", {} );
    
    if ( duration > 0 )
    {
        wait duration;
    }
    else
    {
        self waittill( end_notify );
    }
    
    thread function_5e7ee030c52d6023();
    callback::callback( #"hash_881f39883cfcd050", {} );
}

// Namespace zombie_karkinos_enraged
// Params 0
// Checksum 0x80345c4e, Offset: 0x241
// Size: 0x4b
function function_5e7ee030c52d6023()
{
    self endon( #"death" );
    self.var_782eaac04c44f6d2 = 0;
    self notify( #"exit_enraged" );
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "karkinos_enrage", 32 );
    self function_786bb6aa1b76c7ee( "disable_ranged_attack", 0 );
    self notify( #"vox_calmdown" );
}

