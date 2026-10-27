// scripts\mp\zm\systems\aitypes\zm_zombie_aeon.gsc  (hash_4b40bba4d4dd4093.gscc) (size: 784 Bytes / 0x310 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74cb1b28 (1959467816)
// size ...... 784 (0x310)
// includes .. 2   (offset: 0x2cc)
// strings ... 4   (offset: 0x2dc)
// dev strs .. 0   (offset: 0x310)
// exports ... 3   (offset: 0x1fc)
// cseg ...... 0xaa + 0x152 (0x1fc)
// imports ... 3   (offset: 0x274)
// animtree1 . 0   (offset: 0x310)
// animtree2 . 0   (offset: 0x310)
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace zm_zombie_aeon;

// Namespace zm_zombie_aeon
// Params 2
// Checksum 0x71ad3489, Offset: 0xc8
// Size: 0x40
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_13c52b7600779fe2 ) )
    {
        return;
    }
    
    level.var_13c52b7600779fe2 = 1;
    level callback::add( "on_zombie_aeon_spawned", &on_zombie_aeon_spawned );
}

// Namespace zm_zombie_aeon
// Params 1
// Checksum 0x3c34f3d2, Offset: 0x110
// Size: 0xec
function on_zombie_aeon_spawned( params )
{
    val::set( "zombie_aeon", "trigger_hurt_damage", 0 );
    val::set( "zombie_aeon", "ignore_cleanup", 1 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.b_disable_annihilate = 1;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.var_bfa7ca2a8740bf7b = 1;
    self.ignore_enemy_count = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.var_5a9c952260ab1cf = 1;
    self.no_powerups = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.disable_brain_rot = 1;
}

