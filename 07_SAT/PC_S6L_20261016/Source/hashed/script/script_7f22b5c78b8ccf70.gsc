// script_7f22b5c78b8ccf70  (hash_7f22b5c78b8ccf70.gscc) (size: 1809 Bytes / 0x711 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9c768f3 (4190595315)
// size ...... 1809 (0x711)
// includes .. 3   (offset: 0x6a5)
// strings ... 6   (offset: 0x6bd)
// dev strs .. 0   (offset: 0x711)
// exports ... 9   (offset: 0x3fd)
// cseg ...... 0xc2 + 0x33b (0x3fd)
// imports ... 11  (offset: 0x565)
// animtree1 . 0   (offset: 0x711)
// animtree2 . 0   (offset: 0x711)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace boss_pops;

// Namespace boss_pops
// Params 1
// Checksum 0xd49adbe1, Offset: 0xe0
// Size: 0x9d
function function_21563b860ead0e69( taskid )
{
    set_boss_values();
    self.var_d99adfef8a477dc3 = self.origin;
    self.var_2ccd5045ad629692 = [ { #angles:self.angles, #origin:self.origin } ];
    callback::add( #"on_ai_killed", &callback_on_death );
    zombie_utils::function_dfae6a5bd222c586( &function_e5f0cfbdaf8e51c5 );
    self function_43a971093c992365( 1 );
    self forcenetfieldhighlod( 1 );
    self.var_2fc3a5fb762afb6e = 1;
    return anim.success;
}

// Namespace boss_pops
// Params 1
// Checksum 0xa9a9e24f, Offset: 0x186
// Size: 0xd, Type: bool
function function_e5f0cfbdaf8e51c5( params )
{
    return false;
}

// Namespace boss_pops
// Params 1
// Checksum 0x7b9db9f5, Offset: 0x19c
// Size: 0x17
function function_4c469f7f8939560e( launch_loc )
{
    self.var_d99adfef8a477dc3 = launch_loc;
}

// Namespace boss_pops
// Params 1
// Checksum 0xf0cc1792, Offset: 0x1bb
// Size: 0xc2
function function_1d553e9d7f5f1f2e( launch_locs )
{
    self.var_2ccd5045ad629692 = [];
    
    foreach ( loc in launch_locs )
    {
        var_d216afac03eaa6d0 = { #angles:( 0, 0, 0 ), #origin:loc };
        self.var_2ccd5045ad629692[ self.var_2ccd5045ad629692.size ] = var_d216afac03eaa6d0;
    }
}

// Namespace boss_pops
// Params 0
// Checksum 0x5b535c76, Offset: 0x285
// Size: 0xb
function function_5841cefc95b45c06()
{
    return self.var_d99adfef8a477dc3;
}

// Namespace boss_pops
// Params 0
// Checksum 0x43e89f02, Offset: 0x299
// Size: 0xb
function function_e8b7c32e77fa2ba2()
{
    return self.var_2ccd5045ad629692;
}

// Namespace boss_pops
// Params 0, eflags: 0x4
// Checksum 0xcabc080, Offset: 0x2ad
// Size: 0x117
function private set_boss_values()
{
    val::set( "pops", "trigger_hurt_damage", 0 );
    val::set( "pops", "ignore_cleanup", 1 );
    val::set( "pops", "damage", 0 );
    val::set( "pops", "death", 0 );
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
    self.disable_brain_rot = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.action_cooldowns = [ 1, 1, 1 ];
}

// Namespace boss_pops
// Params 1, eflags: 0x4
// Checksum 0x6da82556, Offset: 0x3cc
// Size: 0x31
function private callback_on_death( params )
{
    logstring( "[LOCUST BOSS] Pops has been killed" );
    
    if ( isdefined( self.body ) )
    {
        self.body delete();
    }
}

