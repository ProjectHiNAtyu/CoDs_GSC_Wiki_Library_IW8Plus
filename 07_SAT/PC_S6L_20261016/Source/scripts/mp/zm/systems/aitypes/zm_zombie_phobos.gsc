// scripts\mp\zm\systems\aitypes\zm_zombie_phobos.gsc  (hash_5d5c1eed05b8a693.gscc) (size: 959 Bytes / 0x3bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4b7428bd (1265903805)
// size ...... 959 (0x3bf)
// includes .. 2   (offset: 0x367)
// strings ... 5   (offset: 0x377)
// dev strs .. 0   (offset: 0x3bf)
// exports ... 4   (offset: 0x24b)
// cseg ...... 0xcb + 0x180 (0x24b)
// imports ... 4   (offset: 0x2eb)
// animtree1 . 0   (offset: 0x3bf)
// animtree2 . 0   (offset: 0x3bf)
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace zm_zombie_phobos;

// Namespace zm_zombie_phobos
// Params 2
// Checksum 0xb26ea5ec, Offset: 0xe9
// Size: 0x52
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_9cc636505b764762 ) )
    {
        return;
    }
    
    level.var_9cc636505b764762 = 1;
    level callback::add( "on_zombie_phobos_spawned", &function_5fef688ae8f947fe );
    level callback::add( "on_zombie_phobos_spawn_empowered", &function_707c7cfd3094f273 );
}

// Namespace zm_zombie_phobos
// Params 1
// Checksum 0x7a49bc70, Offset: 0x143
// Size: 0xcb
function function_5fef688ae8f947fe( params )
{
    val::set( "phobos", "trigger_hurt_damage", 0 );
    val::set( "phobos", "ignore_cleanup", 1 );
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
}

// Namespace zm_zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0xaad8fba, Offset: 0x216
// Size: 0x35
function private function_707c7cfd3094f273( params )
{
    val::set( "phobos", "ignore_cleanup", 1 );
    self.b_cleanup_no_respawn = 1;
    self.var_825b17c932865df = 1;
}

