// scripts\mp\zm\systems\aitypes\zm_zombie_hermes.gsc  (hash_097c98c67cf08026.gscc) (size: 1289 Bytes / 0x509 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xada2a66c (2913117804)
// size ...... 1289 (0x509)
// includes .. 4   (offset: 0x499)
// strings ... 6   (offset: 0x4b9)
// dev strs .. 0   (offset: 0x509)
// exports ... 5   (offset: 0x2e9)
// cseg ...... 0xd7 + 0x212 (0x2e9)
// imports ... 8   (offset: 0x3b1)
// animtree1 . 0   (offset: 0x509)
// animtree2 . 0   (offset: 0x509)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_zombie_hermes;

// Namespace zm_zombie_hermes
// Params 2
// Checksum 0xaa785c3d, Offset: 0xf5
// Size: 0x52
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.var_7cfacaf400d62693 ) )
    {
        return;
    }
    
    level.var_7cfacaf400d62693 = 1;
    level callback::add( "on_zombie_hermes_spawned", &function_1dd58eaaee33391f );
    level callback::add( "new_hermes_phase", &function_7fa20677621ff113 );
}

// Namespace zm_zombie_hermes
// Params 1
// Checksum 0x5c8fdcaa, Offset: 0x14f
// Size: 0x10a
function function_1dd58eaaee33391f( params )
{
    val::set( "hermes", "trigger_hurt_damage", 0 );
    val::set( "hermes", "ignore_cleanup", 1 );
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
    self.var_870c37c6f0744773 = &function_5edc9c31b13a0fc7;
    
    if ( self.hermes_brush_model[ "hermes_script_brushmodel" ] )
    {
        damage_utility::register_damageable_entity( self.hermes_brush_model[ "hermes_script_brushmodel" ], self.team );
    }
}

// Namespace zm_zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x8daa2e5f, Offset: 0x261
// Size: 0x55
function private function_7fa20677621ff113( params )
{
    phase = params.phase;
    var_28755b2381cf7597 = int( self.var_1a69b6b0a7582d0c[ phase - 1 ] * self.maxhealth );
    self.var_d200801f77f0de0 = var_28755b2381cf7597;
}

// Namespace zm_zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0xf6f87756, Offset: 0x2be
// Size: 0x2a, Type: bool
function private function_5edc9c31b13a0fc7( pos )
{
    zone = zone_manager::function_ac62281be3d43322( pos );
    
    if ( !zone )
    {
        return false;
    }
    
    return true;
}

