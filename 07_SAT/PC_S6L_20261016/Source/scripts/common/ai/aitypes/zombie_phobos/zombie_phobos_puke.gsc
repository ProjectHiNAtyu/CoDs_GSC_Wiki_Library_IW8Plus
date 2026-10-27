// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_puke.gsc  (hash_1f2efc9aa0b828dc.gscc) (size: 5630 Bytes / 0x15fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x746c5918 (1953257752)
// size ...... 5630 (0x15fe)
// includes .. 11  (offset: 0x143e)
// strings ... 24  (offset: 0x1496)
// dev strs .. 5   (offset: 0x15c2)
// exports ... 22  (offset: 0xac2)
// cseg ...... 0x1d2 + 0x8f0 (0xac2)
// imports ... 53  (offset: 0xe32)
// animtree1 . 0   (offset: 0x15fe)
// animtree2 . 0   (offset: 0x15fe)
#using script_16ea1b94f0f381b3;
#using script_747233989e7e890d;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_metabones;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spithose;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_phobos_puke;

// Namespace zombie_phobos_puke
// Params 1
// Checksum 0x685e9415, Offset: 0x1f0
// Size: 0xc
function function_f252f41a4c0efa0a( var_4b4d72d84afd1ebd )
{
    
}

/#

    // Namespace zombie_phobos_puke
    // Params 0
    // Checksum 0x68bb2a86, Offset: 0x204
    // Size: 0xc, Type: dev
    function function_b688e1b873f45f93()
    {
        function_9fae9accbe0fd1ef();
    }

#/

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0x7543ab01, Offset: 0x218
// Size: 0x62
function function_b9c24965924a2f8d( taskid, params )
{
    var_9fc358fae8286538 = gettime() - ( self.puke_start_time ?? self.birthtime );
    cooldown_score = clamp( math::remap( var_9fc358fae8286538, 0, utility::function_4b74c15943231980( 120 ), 0, 1 ), 0, 1 );
    return cooldown_score;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0x46b4e04, Offset: 0x283
// Size: 0x1a
function function_f190c572c2d540d3( taskid, params )
{
    return 0.6;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xca3f190e, Offset: 0x2a6
// Size: 0x1a
function function_2689cd4de3a67e54( taskid, params )
{
    return 0.35;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xdb146b28, Offset: 0x2c9
// Size: 0x2c
function function_90503d708f1a5b0f( taskid, params )
{
    var_defb0cc400ac09a0 = zombie_phobos_metabones::function_d106078919e7275f() / 8;
    return var_defb0cc400ac09a0;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xe5434c9d, Offset: 0x2fe
// Size: 0x8f
function function_4fddfc6d93c86d7e( taskid, params )
{
    var_5ca3cc62ad480151 = gettime() - ( self.spit_start_time ?? 0 );
    var_7e953d5d70f88d13 = gettime() - ( self.var_e93cc47a6f947ce5 ?? 0 );
    recent_time = min( var_5ca3cc62ad480151, var_7e953d5d70f88d13 );
    followup_score = clamp( math::remap( recent_time, 0, utility::function_4b74c15943231980( 15 ), 1, 0.5 ), 0.5, 1 );
    return followup_score;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xdd77500d, Offset: 0x396
// Size: 0xe2
function function_e98d9fbc0a020c3a( taskid, params )
{
    targets = self function_f017e352a29a57a1( self.origin, 3000, 1 );
    targets_visible = 0;
    
    foreach ( target in targets )
    {
        if ( self cansee( target ) )
        {
            targets_visible += 1;
        }
    }
    
    visibility_score = 0;
    
    if ( targets_visible > 0 )
    {
        visibility_score = math::remap( targets_visible / targets.size, 0, 1, 0.5, 1 );
    }
    
    return visibility_score;
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xb299e138, Offset: 0x481
// Size: 0x6d
function function_cb89691e559a27c0( taskid, params )
{
    var_755b44fafdba522f = self.origin + anglestoforward( self.angles ) * 200;
    hit_wall = navtrace( self.origin, var_755b44fafdba522f, self );
    
    if ( hit_wall )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0xe4c4962c, Offset: 0x4f7
// Size: 0x2a
function init_phobos_puke()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    thread function_944d16118376ec87();
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0x961bb804, Offset: 0x529
// Size: 0x9
function request_puke()
{
    namespace_e35cf5e19cb4a348::function_51e38bfee277eed1();
}

// Namespace zombie_phobos_puke
// Params 0, eflags: 0x4
// Checksum 0xb04eff32, Offset: 0x53a
// Size: 0x7b
function private on_puke_start()
{
    self.puke_start_time = gettime();
    var_4ecbecea68f9f02a = function_280534335219c0e5();
    level callback::callback( "phobos_puke_vo" );
    self function_786bb6aa1b76c7ee( "puke_end_time", gettime() + getdvarfloat( @"hash_1209a3be87827aa", 1000 ) * var_4ecbecea68f9f02a + 1000 );
    thread utility::thread_on_notify( "puke_zombies", &function_9464570ccdf080fd, self, self, [ "death", "puke_end" ] );
}

// Namespace zombie_phobos_puke
// Params 0, eflags: 0x4
// Checksum 0xc45d3974, Offset: 0x5bd
// Size: 0x37
function private function_944d16118376ec87()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"puke_start" );
        on_puke_start();
        self waittill( #"puke_end" );
    }
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0xb6e7b85d, Offset: 0x5fc
// Size: 0x138
function function_9464570ccdf080fd()
{
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "vomit", "straight_down" );
    var_4ecbecea68f9f02a = function_280534335219c0e5();
    zombie_aitype = function_1429567d6a7418fd();
    spawn_point = get_puke_spawn_position();
    
    if ( !isdefined( spawn_point ) )
    {
        return;
    }
    
    zombie_phobos_metabones::function_2b7c1d11b4ee6412( self );
    zombie_i = 0;
    
    while ( zombie_i < var_4ecbecea68f9f02a )
    {
        zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_aitype, spawn_point, self.angles, self.team );
        
        if ( isdefined( zombie ) )
        {
            zombie.no_powerups = self.puke_zombies_no_powerups;
            zombie.var_7a679e69584d580c = &zombie_phobos_spithose::function_de99d28d05984f96;
            set_zombie_empowered( zombie, self );
            zombie zombie_cannonball::cannonball_ai( anglestoforward( self.angles ) + ( randomfloatrange( -0.5, 0.5 ), 0 + randomfloatrange( -0.5, 0.5 ), -1.5 ), 200, zombie_cannonball::adv_settings( 1, 0, 0 ), "intentional_drop" );
            wait 1;
        }
        
        zombie_i += 1;
    }
    
    utility::function_7c10ea82c1e305b8( "vomit", "off" );
}

// Namespace zombie_phobos_puke
// Params 2
// Checksum 0xd6bd336e, Offset: 0x73c
// Size: 0x12e
function set_zombie_empowered( zombie, phobos )
{
    zombie zombie_utils::set_zombie_round_difficulty( zombie_utils::get_zombie_round_difficulty() + 10 );
    zombie zombie_utils::function_a8ce00e0448cb6f0( "run", "phobos_spawn_base", 6 );
    zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "phobos_spawn", 30 );
    zombie utility::function_32b24db3127bff40( "phobos_empowered", "on" );
    zombie utility::ent_flag_set( "phobos_empowered" );
    zombie.var_6c41e8e873b7594e *= 2;
    run_away_time = 5;
    zombie thread utility::delaythread( run_away_time, &zombie_utils::function_a8ce00e0448cb6f0, undefined, "phobos_spawn", 30 );
    zombie thread val::set_for_time( run_away_time, "phobos_empowered_run_away", "ignore_ai_collision", 1 );
    zombie zombie_utils::function_dfae6a5bd222c586( &function_302c0e6242d3f6d );
    zombie.owner = phobos;
    zombie.forceannihilate = 1;
    zombie.toxic_gas_notify = "roar_end";
    params = spawnstruct();
    params.zombie = zombie;
    zombie callback::callback( "on_zombie_phobos_spawn_empowered", params );
}

// Namespace zombie_phobos_puke
// Params 1, eflags: 0x4
// Checksum 0x60f3ce8e, Offset: 0x872
// Size: 0xba
function private function_302c0e6242d3f6d( params )
{
    if ( params.smeansofdeath != "MOD_MELEE" && params.sweapon.damagemodcategory != #"melee" )
    {
        if ( params.smeansofdeath == "MOD_ELEMENTAL_DARK" || params.var_5e5a2456deacd236 == "dark" )
        {
            params.var_ff33243f5be1fe3b = min( params.var_ff33243f5be1fe3b, 0.3 );
        }
        else
        {
            params.var_ff33243f5be1fe3b = min( params.var_ff33243f5be1fe3b, 0.1 );
        }
    }
    
    return params.idamage;
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0x4b8c5a46, Offset: 0x935
// Size: 0x7d
function get_puke_spawn_position()
{
    jaw_pos = self gettagorigin( "j_jaw" ) + ( 0, 0, -20 );
    var_755b44fafdba522f = ( jaw_pos[ 0 ], jaw_pos[ 1 ], self.origin[ 2 ] );
    var_df3368937a615ae9 = getrandomnavpoint( var_755b44fafdba522f, 5, undefined, undefined, 1 );
    
    if ( !isdefined( var_df3368937a615ae9 ) )
    {
        return;
    }
    
    spawn_point = ( var_df3368937a615ae9[ 0 ], var_df3368937a615ae9[ 1 ], var_df3368937a615ae9[ 2 ] + 100 );
    return spawn_point;
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0xa6ad4cd6, Offset: 0x9bb
// Size: 0x19
function function_1429567d6a7418fd()
{
    aitype = function_b3988325430ce242( "zombie_base_toxic" );
    return aitype;
}

// Namespace zombie_phobos_puke
// Params 0
// Checksum 0x55a65460, Offset: 0x9dd
// Size: 0x5b
function function_280534335219c0e5()
{
    var_4ecbecea68f9f02a = 1;
    var_20e35377fb0057f7 = zombie_phobos_metabones::function_d106078919e7275f();
    
    if ( var_20e35377fb0057f7 <= 2 )
    {
        var_4ecbecea68f9f02a = 1;
    }
    else if ( var_20e35377fb0057f7 <= 4 )
    {
        var_4ecbecea68f9f02a = 2;
    }
    else if ( var_20e35377fb0057f7 <= 6 )
    {
        var_4ecbecea68f9f02a = 3;
    }
    else if ( var_20e35377fb0057f7 <= 8 )
    {
        var_4ecbecea68f9f02a = 4;
    }
    
    return var_4ecbecea68f9f02a;
}

/#

    // Namespace zombie_phobos_puke
    // Params 0, eflags: 0x4
    // Checksum 0x64cc2c7d, Offset: 0xa41
    // Size: 0x2e, Type: dev
    function private function_9fae9accbe0fd1ef()
    {
        devgui::function_9082edeb5db93280( "<dev string:x98>" );
        devgui::add_devgui_func( "<dev string:xb0>", "<dev string:xbb>", &force_puke );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_puke
    // Params 1, eflags: 0x4
    // Checksum 0x1afcb7b7, Offset: 0xa77
    // Size: 0x4b, Type: dev
    function private force_puke( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xcd>" );
        
        if ( isdefined( phobos ) )
        {
            phobos request_puke();
        }
    }

#/
