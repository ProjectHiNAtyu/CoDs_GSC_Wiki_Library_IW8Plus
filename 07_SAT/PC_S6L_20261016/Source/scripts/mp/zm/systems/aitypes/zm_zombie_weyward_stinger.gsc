// scripts\mp\zm\systems\aitypes\zm_zombie_weyward_stinger.gsc  (hash_5b21f23be5879c22.gscc) (size: 880 Bytes / 0x370 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5e188e4 (3588327652)
// size ...... 880 (0x370)
// includes .. 2   (offset: 0x310)
// strings ... 6   (offset: 0x320)
// dev strs .. 0   (offset: 0x370)
// exports ... 3   (offset: 0x23c)
// cseg ...... 0xe0 + 0x15c (0x23c)
// imports ... 3   (offset: 0x2b4)
// animtree1 . 0   (offset: 0x370)
// animtree2 . 0   (offset: 0x370)
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace zm_zombie_weyward_stinger;

// Namespace zm_zombie_weyward_stinger
// Params 2
// Checksum 0x8eaac63d, Offset: 0xfe
// Size: 0x40
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_c5d89fd6604d20cc ) )
    {
        return;
    }
    
    level.var_c5d89fd6604d20cc = 1;
    level callback::add( "on_zombie_weyward_stinger_spawned", &on_zombie_weyward_stinger_spawned );
}

// Namespace zm_zombie_weyward_stinger
// Params 1
// Checksum 0x28fdad00, Offset: 0x146
// Size: 0xf6
function on_zombie_weyward_stinger_spawned( params )
{
    val::set( "zombie_weyward_stinger", "trigger_hurt_damage", 0 );
    val::set( "zombie_weyward_stinger", "ignore_cleanup", 1 );
    val::set( "zombie_weyward_stinger", "allow_dismember", 0 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
    self.var_15598d8e493afe88 = 1;
    self.ignore_enemy_count = 1;
    self.var_317816f65dd8fd6c = 2;
    self.b_ignore_water_check = 1;
    self.var_1bc1a37495c8ca04 = 1;
    self.b_ignore_monkey_bomb = 1;
    self.b_ignore_frenzied_guard = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.var_5a9c952260ab1cf = 1;
    self.disable_brain_rot = 1;
    self.var_6cd3687f6622091c = "j_tail_04";
}

