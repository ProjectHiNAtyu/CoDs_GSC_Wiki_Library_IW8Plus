// script_f3c8f14c0381f7a  (hash_0f3c8f14c0381f7a.gscc) (size: 24304 Bytes / 0x5ef0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x685d9c07 (1750965255)
// size ...... 24304 (0x5ef0)
// includes .. 18  (offset: 0x5900)
// strings ... 66  (offset: 0x5990)
// dev strs .. 6   (offset: 0x5ea8)
// exports ... 50  (offset: 0x3f68)
// cseg ...... 0x5cd + 0x399b (0x3f68)
// imports ... 135 (offset: 0x4738)
// animtree1 . 0   (offset: 0x5ef0)
// animtree2 . 0   (offset: 0x5ef0)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_410b54b9533e5a00;

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x5
// Checksum 0x143e4b26, Offset: 0x5eb
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_89fc0090c0f4410f", undefined, &function_128310687dc8fd4f, undefined );
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0xc278ec98, Offset: 0x60c
// Size: 0xa
function function_128310687dc8fd4f()
{
    level thread function_913244f0f581644c();
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0x7acca0a, Offset: 0x61e
// Size: 0x26
function function_913244f0f581644c()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_ae163a412bc4f163", &function_d2be768ee2df4fde, &function_b7ddfa41ad37dafd, &function_d1e8707990948d77, &function_10d9037598090239 );
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0x10a7e017, Offset: 0x64c
// Size: 0x34
function function_d1e8707990948d77()
{
    if ( utility::issharedfuncdefined( "hornet_assault_round", #"hash_511c2d953fa53255" ) )
    {
        return !utility::callsharedfunc( "hornet_assault_round", #"hash_511c2d953fa53255", "zone_lava_garden_a" );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0xf72325a3, Offset: 0x688
// Size: 0x38
function function_10d9037598090239()
{
    if ( !function_d1e8707990948d77() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3c14bde4d45c3e8c", #type:"HINT_NOBUTTON" };
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0xe413ddfd, Offset: 0x6c9
// Size: 0xea
function function_d2be768ee2df4fde()
{
    level callback::add( "on_relic_challenge_objective_updated", &function_844c88a2f29c8a08 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level callback::add( "on_round_start", &on_round_start );
    level.active_relic_challenge.pause_spawning = 1;
    level.active_relic_challenge.var_3bc08f51893973a = 1;
    level.active_relic_challenge.postfxbundle_override = "sat_zm_relic_purple";
    level utility::flag_set( "mq_step_36_complete" );
    
    if ( level.hornet_mq.bossfight_interact )
    {
        level.hornet_mq.bossfight_interact delete();
    }
    
    level.var_41aad01d46c3f9cc = getomnvar( "ui_was_savegame_loaded_this_round" ) ?? 0;
    setomnvar( "ui_was_savegame_loaded_this_round", 1 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0x77ca6219, Offset: 0x7bb
// Size: 0x6f
function function_b7ddfa41ad37dafd()
{
    level callback::remove( "on_relic_challenge_objective_updated", &function_844c88a2f29c8a08 );
    level callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level callback::remove( "on_round_start", &on_round_start );
    level.var_b3d685cfbac74242 = undefined;
    setomnvar( "ui_was_savegame_loaded_this_round", level.var_41aad01d46c3f9cc );
    level.var_41aad01d46c3f9cc = undefined;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x5b>" );
    #/
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xc4032c55, Offset: 0x832
// Size: 0x24
function private on_round_start( params )
{
    if ( level.active_relic_challenge )
    {
        setomnvar( "ui_was_savegame_loaded_this_round", 1 );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x3514a819, Offset: 0x85e
// Size: 0xb7
function private on_zombie_ai_spawned( params )
{
    wait 1;
    
    if ( self && isalive( self ) )
    {
        var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
        round_number = zm_round_logic::get_rb_round_number();
        round_number = maxint( round_number, var_1c3d219b34d9181b );
        var_8c2db094245b0cd1 = level.active_relic_challenge.waveinfo.var_88a2e48792cee5a4 ?? 0;
        zombie_utils::set_zombie_round_difficulty( round_number, 1 );
        zombie_utils::set_zombie_round_difficulty( round_number + var_8c2db094245b0cd1, 0 );
        
        if ( !isdefined( self.var_13518fb33ec73cc ) )
        {
            self.var_13518fb33ec73cc = round_number;
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xe7d1564b, Offset: 0x91d
// Size: 0xc9
function private function_844c88a2f29c8a08( params )
{
    level thread function_2ea0a632a87a0345();
    waitframe();
    
    switch ( level.active_relic_challenge.var_3a04ef2068c13fc9 )
    {
        case 1:
            level function_d7728c7ac25b477a();
            break;
        case 2:
            level function_9f7924d2b579df90();
            break;
        case 3:
            level function_218cbd23e2ed5fca();
            break;
        case 4:
            level function_4a2b1b73623a33d1();
            break;
        case 5:
            level function_95efd0dc3c39296a();
            break;
        case 6:
            level function_fe2c1a16d7971acc();
            break;
        default:
            break;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0xda0934d0, Offset: 0x9ee
// Size: 0x11e
function private function_d7728c7ac25b477a()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level.ar_root.preferred_sector = "ar_sec3";
    var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
    round_number = zm_round_logic::get_rb_round_number();
    round_number = maxint( round_number, var_1c3d219b34d9181b );
    level.var_b3d685cfbac74242 = round_number;
    wait 5;
    quest_bundle = level.active_relic_challenge.quest_bundle;
    var_800c32584de16273 = #"hash_c870eabe9bdde807";
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, level.active_relic_challenge.bundle.ref );
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, var_800c32584de16273 );
    wait 2;
    level callback::add( "hornet_assault_round_ended", &function_fc8e0c84b7ba7983 );
    level callback::callback( "force_assault_round_start" );
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x4c41bcf8, Offset: 0xb14
// Size: 0xa9
function private function_fc8e0c84b7ba7983( params )
{
    if ( level callback::exists( "hornet_assault_round_ended", &function_fc8e0c84b7ba7983 ) )
    {
        level callback::remove( "hornet_assault_round_ended", &function_fc8e0c84b7ba7983 );
    }
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 1 )
    {
        if ( params.b_success )
        {
            zm_relic_challenges::progress_wave( 1, 1 );
            return;
        }
        
        if ( !isdefined( params.b_success ) && level.active_relic_challenge.var_3a04ef2068c13fc9 == 1 )
        {
            zm_relic_challenges::progress_wave( 1, 1 );
            return;
        }
        
        level thread zm_relic_challenges::end_relic_challenge( undefined, 0 );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0x3860b9a, Offset: 0xbc5
// Size: 0x1f1
function private function_9f7924d2b579df90()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_1c1045bc5f007321" );
    
    if ( utility::issharedfuncdefined( #"hornet_ash", #"ash_paused" ) )
    {
        level thread utility::callsharedfunc( #"hornet_ash", #"ash_paused" );
    }
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_3a6f936f234c0772" );
    }
    
    level callback::add( #"relic_challenge_ended", &function_398f9cf82ac5bbe4 );
    level thread function_c148eb85b6dfb3df( "_ring2_falling_rocks_abom_activate", 30 );
    
    if ( !isdefined( level.var_8a96c80267039e14 ) )
    {
        level.var_8a96c80267039e14 = [];
    }
    
    time = 30;
    level thread function_6bcea3fe31e60432( [], time, 2, level.var_8a96c80267039e14 );
    struct = utility::getstruct( "crf_z_rng_2", "targetname" );
    
    if ( struct )
    {
        struct.scriptable = spawnscriptable( %"sat_zm_cr_hold_point", struct.origin, struct.angles );
        struct.scriptable = interaction::register_scriptable_interact( struct.scriptable, &function_c87181909e4c695a );
        struct.scriptable utility::function_7c10ea82c1e305b8( "base", "Usable" );
        struct.scriptable.var_94d1ab5da995e573 = 0;
        level.var_8a96c80267039e14[ level.var_8a96c80267039e14.size ] = struct.scriptable;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x13b728d9, Offset: 0xdbe
// Size: 0x26f
function private function_c87181909e4c695a( player )
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    self.var_929a3ff666a99dac = 1;
    self.var_94d1ab5da995e573 = 1;
    utility::function_7c10ea82c1e305b8( "base", "Activated" );
    level thread function_2ea0a632a87a0345();
    waitframe();
    var_18608180abc142e8 = [];
    var_18608180abc142e8[ "zone_third_bailey_west_b" ] = 1;
    var_18608180abc142e8[ "zone_third_bailey_east_b" ] = 1;
    var_18608180abc142e8[ "zone_third_bailey_east_a" ] = 1;
    var_18608180abc142e8[ "zone_third_bailey_west_a" ] = 1;
    level thread function_6bcea3fe31e60432( var_18608180abc142e8, 1, 2, level.var_8a96c80267039e14 );
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring2_falling_rocks_abom_activate" );
    zm_quest::function_9f49b2a045ece8ae( 1, 1, quest_bundle.ref, step_ref );
    wait 0.5;
    level.active_relic_challenge.pause_spawning = 0;
    level thread function_c148eb85b6dfb3df( "_ring2_falling_rocks_abom_kills" );
    flame_structs = utility::getstructarray( "crf_rng_2_flame", "targetname" );
    level thread function_98d7d7957ae0e748( flame_structs, level.var_8a96c80267039e14 );
    wait 2;
    var_b019719ed237b270 = utility::getstructarray( "crf_z_rng_2_abom_spawn", "targetname" );
    var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
    round_number = zm_round_logic::get_rb_round_number();
    round_number = maxint( round_number, var_1c3d219b34d9181b );
    
    foreach ( struct in var_b019719ed237b270 )
    {
        zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_abom_hvt", struct, round_number, "elite" );
        zombie callback::add( #"on_ai_killed", &function_e93411e09da493b0 );
        wait 2;
    }
    
    /#
        iprintlnbold( "<dev string:x90>" );
    #/
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xe4baa02d, Offset: 0x1035
// Size: 0x16f
function private function_e93411e09da493b0( params )
{
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 != 2 )
    {
        return;
    }
    
    if ( !isdefined( level.active_relic_challenge.abom_kills ) )
    {
        level.active_relic_challenge.abom_kills = 0;
    }
    
    level.active_relic_challenge.max_abom_kills = 2;
    level.active_relic_challenge.abom_kills++;
    current_kills = level.active_relic_challenge.abom_kills;
    max_kills = level.active_relic_challenge.max_abom_kills;
    progress_frac = current_kills / max_kills;
    progress_frac = clamp( progress_frac, 0, 1 );
    progress_frac *= 100;
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring2_falling_rocks_abom_kills" );
    zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, step_ref );
    
    if ( current_kills >= max_kills )
    {
        if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 2 )
        {
            zm_relic_challenges::progress_wave( 1, 1 );
            level thread function_398f9cf82ac5bbe4();
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x9674fa9e, Offset: 0x11ac
// Size: 0x165
function private function_398f9cf82ac5bbe4( params )
{
    foreach ( scriptable in level.var_8a96c80267039e14 )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.var_8a96c80267039e14 = function_5713d46873b29625( level.var_8a96c80267039e14 );
    function_2d68e3feb1a013b0( "_ring2_falling_rocks_abom_activate" );
    function_2d68e3feb1a013b0( "_ring2_falling_rocks_abom_kills" );
    
    if ( level callback::exists( #"relic_challenge_ended", &function_398f9cf82ac5bbe4 ) )
    {
        level callback::remove( #"relic_challenge_ended", &function_398f9cf82ac5bbe4 );
    }
    
    foreach ( player in level.players )
    {
        player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0
// Checksum 0xfab082ed, Offset: 0x1319
// Size: 0x92
function function_2ea0a632a87a0345()
{
    level notify( #"hash_d613de70387424f0" );
    waitframe();
    
    foreach ( player in level.players )
    {
        player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0xa4690167, Offset: 0x13b3
// Size: 0x244
function private function_218cbd23e2ed5fca()
{
    level callback::add( #"relic_challenge_ended", &function_398f9df82ac5be17 );
    level.active_relic_challenge.pause_spawning = 1;
    level thread function_c148eb85b6dfb3df( "_ring3_peeks_push_activate", 30 );
    
    if ( !isdefined( level.var_5b7b1c63a431a14b ) )
    {
        level.var_5b7b1c63a431a14b = [];
    }
    
    level.active_relic_challenge.path_point_structs = [];
    level thread function_6bcea3fe31e60432( [], 30, 3, level.var_5b7b1c63a431a14b );
    
    for ( i = 0; i < 21 ; i++ )
    {
        point_struct = utility::getstruct( "crf_z_rng_3_mrp_point_" + i, "targetname" );
        
        if ( point_struct )
        {
            level.active_relic_challenge.path_point_structs[ level.active_relic_challenge.path_point_structs.size ] = point_struct.origin;
        }
    }
    
    path = level.active_relic_challenge.path_point_structs;
    spawn_point = utility::getstruct( "crf_z_rng_3_mrp_point_0", "targetname" );
    
    if ( spawn_point )
    {
        spawn_point.scriptable = spawnscriptable( %"sat_zm_cr_hold_point", spawn_point.origin, spawn_point.angles );
        spawn_point.scriptable = interaction::register_scriptable_interact( spawn_point.scriptable, &function_d269187988d743e7 );
        spawn_point.scriptable utility::function_7c10ea82c1e305b8( "base", "Usable" );
        spawn_point.scriptable.var_94d1ab5da995e573 = 0;
        spawn_point.scriptable.path = path;
        spawn_point.scriptable.ent_mover = utility::spawn_model( "tag_origin", spawn_point.origin, spawn_point.angles );
        spawn_point.scriptable utility::scriptable_setparententity( spawn_point.scriptable.ent_mover );
        level.active_relic_challenge.mrp_push = spawn_point.scriptable;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0xc
// Checksum 0x8c1a9cce, Offset: 0x15ff
// Size: 0x21f
function private function_d269187988d743e7( player )
{
    self notify( #"hash_59cb649ba7dbd626" );
    self endon( #"hash_59cb649ba7dbd626" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    self.var_929a3ff666a99dac = 1;
    self.var_94d1ab5da995e573 = 1;
    utility::function_7c10ea82c1e305b8( "base", "Activated_no_move" );
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring3_peeks_push_activate" );
    zm_quest::function_9f49b2a045ece8ae( 1, 1, quest_bundle.ref, step_ref );
    level thread function_2ea0a632a87a0345();
    wait 0.5;
    level thread function_c148eb85b6dfb3df( "_ring3_peeks_push_goal" );
    time = 90;
    thread function_63ed7d64bda9eb5b();
    self.ent_mover thread utility::function_2159dd4196ff4b81( self.path, time, 1, 0, 0, 0.5, 0.5, 1 );
    self.ent_mover thread function_4d19d6c8c7ae2e19();
    self.ent_mover thread function_7828da26bbb52cf4();
    
    /#
        iprintlnbold( "<dev string:xac>" );
    #/
    
    foreach ( var_5fb4fe43f49ba675 in self.path )
    {
        var_9e9bcd3c5818482a = getclosestpointonnavmesh( var_5fb4fe43f49ba675 ) - ( 0, 0, 15 );
        flame_scriptable = spawnscriptable( %"sat_zm_cr_point_edge", var_9e9bcd3c5818482a );
        level.var_5b7b1c63a431a14b[ level.var_5b7b1c63a431a14b.size ] = flame_scriptable;
        wait 0.1;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0x28c1dd3e, Offset: 0x1826
// Size: 0x169
function private function_63ed7d64bda9eb5b()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"death" );
    max_dist = distance2dsquared( self.origin, self.path[ 20 ] );
    
    while ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 )
    {
        wait 1;
        
        if ( !self )
        {
            return;
        }
        
        current_dist = distance2dsquared( self.origin, self.path[ 20 ] );
        progress_frac = current_dist / max_dist;
        progress_frac = clamp( progress_frac, 0, 1 );
        progress_frac *= 100;
        progress_frac = 100 - progress_frac;
        level function_6aaaffb6ce496d78( progress_frac );
        
        if ( progress_frac > 3 && !self.var_66e4b3424417cbde )
        {
            self.var_66e4b3424417cbde = 1;
        }
        
        if ( self.var_66e4b3424417cbde && progress_frac <= 0 )
        {
            level thread zm_relic_challenges::end_relic_challenge( undefined, 0 );
        }
        
        quest_bundle = level.active_relic_challenge.quest_bundle;
        step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring3_peeks_push_goal" );
        level zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, step_ref );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xbc9bb24b, Offset: 0x1997
// Size: 0x5cf
function private function_6aaaffb6ce496d78( progress_frac )
{
    if ( !level.active_relic_challenge.var_288a9ab97f25604 )
    {
        level.active_relic_challenge.var_288a9ab97f25604 = [];
        level.active_relic_challenge.var_288a9ab97f25604[ 0 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 1 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 5 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 8 ] = [ "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 15 ] = [ "zombie_ghoul", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 30 ] = [ "zombie_ghoul", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 35 ] = [ "zombie_spawn", "zombie_ghoul" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 45 ] = [ "zombie_ghoul", "zombie_ghoul", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 50 ] = [ "zombie_ghoul", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 60 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 70 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 75 ] = [ "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 80 ] = [ "zombie_ghoul", "zombie_ghoul_hvt" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 81 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 85 ] = [ "zombie_ghoul" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 86 ] = [ "zombie_ghoul", "zombie_ghoul", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 89 ] = [ "zombie_ghoul", "zombie_ghoul", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 90 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 92 ] = [ "zombie_ghoul", "zombie_ghoul_hvt", "zombie_ghoul_hvt", "zombie_hellhound" ];
        level.active_relic_challenge.var_288a9ab97f25604[ 95 ] = [ "zombie_spawn", "zombie_hellhound", "zombie_hellhound", "zombie_hellhound" ];
    }
    
    foreach ( key, a_val in level.active_relic_challenge.var_288a9ab97f25604 )
    {
        if ( progress_frac >= key && level.active_relic_challenge.var_288a9ab97f25604[ key ] )
        {
            level.active_relic_challenge.var_288a9ab97f25604[ key ] = undefined;
            
            if ( a_val[ 0 ] == "zombie_spawn" )
            {
                level thread function_aadc89d4bc755ca4();
                continue;
            }
            
            foreach ( subclass in a_val )
            {
                subclass_to_spawn = subclass;
                var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
                round_number = zm_round_logic::get_rb_round_number();
                round_number = maxint( round_number, var_1c3d219b34d9181b );
                zmb_spawner = zone_spawner::select_spawn_loc( subclass_to_spawn, undefined, 1 );
                zombie = level thread zm_relic_challenges::function_fcc576ce75ae207c( subclass_to_spawn, zmb_spawner, round_number );
            }
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0x3e891901, Offset: 0x1f6e
// Size: 0x92
function private function_aadc89d4bc755ca4()
{
    self notify( #"hash_1fc549f11913f109" );
    self endon( #"hash_1fc549f11913f109" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 )
    {
        level.active_relic_challenge.pause_spawning = 0;
    }
    
    wait 45;
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 )
    {
        level.active_relic_challenge.pause_spawning = 1;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0xa9950fb8, Offset: 0x2008
// Size: 0x93
function private function_4d19d6c8c7ae2e19()
{
    self notify( #"hash_9f5b80b29bab323f" );
    self endon( #"hash_9f5b80b29bab323f" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    
    while ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 )
    {
        players = getplayersinradius( self.origin, 225 );
        
        if ( players.size > 0 )
        {
            self.var_3b0701f0112a13fe = 1;
        }
        else
        {
            self.var_3b0701f0112a13fe = -0.8;
        }
        
        wait 0.5;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0x9ed112f3, Offset: 0x20a3
// Size: 0x6b
function private function_7828da26bbb52cf4()
{
    self notify( #"hash_6611f91d4c49a6fd" );
    self endon( #"hash_6611f91d4c49a6fd" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self waittill( #"stop_curve" );
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 3 )
    {
        zm_relic_challenges::progress_wave( 1, 1 );
    }
    
    level function_398f9df82ac5be17();
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0x73cf5389, Offset: 0x2116
// Size: 0xa0
function private function_3aa52f997c68d381()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"death" );
    wait 2;
    
    if ( self && isalive( self ) )
    {
        zombie_speed = "run";
        
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            chance = 75;
            
            if ( chance )
            {
                zombie_speed = "sprint";
            }
            else
            {
                zombie_speed = "run";
            }
            
            utility::callsharedfunc( #"zombie_utils", #"setmovespeed", zombie_speed, "relic_challenge", 9 );
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xb3cf8aa4, Offset: 0x21be
// Size: 0x1bc
function private function_398f9df82ac5be17( params )
{
    utility::clearsharedfunc( #"relics", #"hash_b2dd3117e28e0ada" );
    
    if ( level callback::exists( #"relic_challenge_ended", &function_398f9df82ac5be17 ) )
    {
        level callback::remove( #"relic_challenge_ended", &function_398f9df82ac5be17 );
    }
    
    foreach ( scriptable in level.var_5b7b1c63a431a14b )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    if ( params.var_c5acdbec60b34aab == 0 )
    {
        if ( level.active_relic_challenge.mrp_push )
        {
            level.active_relic_challenge.mrp_push freescriptable();
        }
    }
    
    foreach ( player in level.players )
    {
        player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
    }
    
    level.var_5b7b1c63a431a14b = function_5713d46873b29625( level.var_5b7b1c63a431a14b );
    function_2d68e3feb1a013b0( "_ring3_peeks_push_activate" );
    function_2d68e3feb1a013b0( "_ring3_peeks_push_goal" );
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0x5cafe8b2, Offset: 0x2382
// Size: 0x2eb
function private function_4a2b1b73623a33d1()
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level callback::add( #"relic_challenge_ended", &function_398f9af82ac5b77e );
    level.active_relic_challenge.pause_spawning = 1;
    level.var_c7eafa733421267e = [];
    level thread function_c148eb85b6dfb3df( "_ring4_orion_kills" );
    wait 2;
    
    foreach ( player in level.players )
    {
        player thread function_d698e22b176538af();
    }
    
    if ( level.active_relic_challenge.mrp_push )
    {
        spawnorigin = level.active_relic_challenge.mrp_push.origin + ( 0, 0, 40 );
        spawnangles = level.active_relic_challenge.mrp_push.angles;
        common_item::function_e08da1075e1758ef( "weapon", &function_6f3540b51af7902b );
        level callback::add( #"player_item_pickup", &on_item_picked_up );
        level.active_relic_challenge.katana_struct = { #spawnangles:spawnangles, #spawnorigin:spawnorigin, #weapon:function_ba8c1d5fa204bd45( spawnorigin, spawnangles ) };
        var_be1024dafa17d644 = spawnscriptable( %"hash_5b6f5948cd2a3b5a", spawnorigin, spawnangles );
        level.var_c7eafa733421267e[ level.var_c7eafa733421267e.size ] = level.active_relic_challenge.mrp_push;
        level.var_c7eafa733421267e[ level.var_c7eafa733421267e.size ] = var_be1024dafa17d644;
    }
    
    wait 5;
    utility::registersharedfunc( #"relics", #"hash_b2dd3117e28e0ada", &function_4d27ca5d77ad4d26 );
    level.active_relic_challenge.pause_spawning = 0;
    var_b019719ed237b270 = utility::getstructarray( "crf_z_rng_4_orion_spawn", "targetname" );
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_c221c63aa4ddfeb0 );
    
    foreach ( struct in var_b019719ed237b270 )
    {
        level thread function_c2c25c515c6dd3d( struct );
        wait 2;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x339004be, Offset: 0x2675
// Size: 0x87
function private function_c2c25c515c6dd3d( spawnstruct )
{
    var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
    round_number = zm_round_logic::get_rb_round_number();
    round_number = maxint( round_number, var_1c3d219b34d9181b );
    zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_orion", spawnstruct, round_number, "special" );
    
    if ( zombie )
    {
        zombie callback::add( #"on_ai_killed", &function_a0028a72164abd68 );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 2, eflags: 0x4
// Checksum 0x31d7d753, Offset: 0x2704
// Size: 0x93
function private function_ba8c1d5fa204bd45( origin, angles )
{
    var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_me_elnath_ultra" );
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.overridepaplvl = 4;
    spawnoptions.critical = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    var_291245eaf7d28734 = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
    level.var_c7eafa733421267e[ level.var_c7eafa733421267e.size ] = var_291245eaf7d28734;
    return var_291245eaf7d28734;
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xbb7d4465, Offset: 0x27a0
// Size: 0x7c
function private function_6f3540b51af7902b( params )
{
    waittillframeend();
    
    if ( params.spawnoptions.spawningentity && isplayer( params.spawnoptions.spawningentity ) )
    {
        if ( params.item.weaponobj.basename == "sat_me_elnath_mp" )
        {
            common_item::function_869d7676e359a627( params.item );
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xb09f9c13, Offset: 0x2824
// Size: 0xd6
function private on_item_picked_up( params )
{
    if ( params.item == level.active_relic_challenge.katana_struct.weapon )
    {
        origin = level.active_relic_challenge.katana_struct.spawnorigin;
        angles = level.active_relic_challenge.katana_struct.spawnangles;
        wait 0.1;
        
        if ( !level.active_relic_challenge.katana_struct.weapon )
        {
            level.active_relic_challenge.katana_struct.weapon = function_ba8c1d5fa204bd45( origin, angles );
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0x3ddebade, Offset: 0x2902
// Size: 0x117
function private function_d698e22b176538af()
{
    self notify( #"hash_dba4edf4e2cba0c6" );
    self endon( #"hash_dba4edf4e2cba0c6" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"death_or_disconnect" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
        wait 1;
    }
    
    if ( isplayer( self ) )
    {
        zm_utility::function_d47920bb0d5fa327( "relicchallenge_peeks_ring4" );
        zm_utility::function_92275a9d3969d91d( 1, 1, 0, 1, 1, 1, 1 );
        var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_me_elnath" );
        var_6828becb300b1c44 = item_weapon::function_e3101668a21a4237( var_8a61d4195b4b6e64 );
        weapon = weapon::buildweapon( var_8a61d4195b4b6e64.baseweapon, var_6828becb300b1c44.attachments );
        self giveweapon( weapon );
        weapon::function_b4c9549dee5d0fc5( weapon );
        self switchtoweapon( weapon );
        var_f053459cfbfb9e3 = utility::callsharedfunc( #"pack_a_punch", #"hash_340ee732d0e66af3", weapon, 3 );
        item_weapon::function_40e1cbd0e1f47d1a( var_f053459cfbfb9e3, 5 );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0x8eed1380, Offset: 0x2a21
// Size: 0x5f
function private function_eb65bf0431884920()
{
    self notify( #"hash_29d9cdb19c92b8f4" );
    self endon( #"hash_29d9cdb19c92b8f4" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    self endon( #"death_or_disconnect" );
    
    if ( player::isinlaststand( self ) )
    {
        self waittill( #"last_stand_exit" );
        wait 1;
    }
    
    zm_utility::function_663d59490abc834f();
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x794bf78d, Offset: 0x2a88
// Size: 0x8d
function private function_c221c63aa4ddfeb0( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    
    if ( self.subclass == "zombie_orion" )
    {
        if ( dmg_struct.objweapon.basename == "sat_me_elnath_mp" && player.var_9606da20c1b52a78 )
        {
            zm_relic_challenges::function_908a1b8613e50514();
        }
        else
        {
            idamage = 0;
            zm_relic_challenges::set_zombie_damage_invuln();
        }
    }
    
    return idamage;
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x213131f4, Offset: 0x2b1e
// Size: 0x1bc
function private function_a0028a72164abd68( params )
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_632654f6513efa6c" );
    
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 != 4 )
    {
        return;
    }
    
    if ( !isdefined( level.active_relic_challenge.orion_kills ) )
    {
        level.active_relic_challenge.orion_kills = 0;
    }
    
    level.active_relic_challenge.max_orion_kills = 4;
    level.active_relic_challenge.orion_kills++;
    current_kills = level.active_relic_challenge.orion_kills;
    max_kills = level.active_relic_challenge.max_orion_kills;
    progress_frac = current_kills / max_kills;
    progress_frac = clamp( progress_frac, 0, 1 );
    progress_frac *= 100;
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring4_orion_kills" );
    zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, step_ref );
    
    if ( current_kills >= max_kills )
    {
        if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 4 )
        {
            zm_relic_challenges::progress_wave( 1, 1 );
            level thread function_398f9af82ac5b77e();
            return;
        }
    }
    
    wait 3;
    var_b019719ed237b270 = utility::getstructarray( "crf_z_rng_4_orion_spawn", "targetname" );
    level thread function_c2c25c515c6dd3d( var_b019719ed237b270[ 0 ] );
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0xfb6540af, Offset: 0x2ce2
// Size: 0x7c
function private function_4d27ca5d77ad4d26()
{
    wait 2;
    
    if ( self && isalive( self ) )
    {
        zombie_speed = "run";
        
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            chance = 40;
            
            if ( chance )
            {
                zombie_speed = "sprint";
            }
            else
            {
                zombie_speed = "run";
            }
            
            utility::callsharedfunc( #"zombie_utils", #"setmovespeed", zombie_speed, "relic_challenge", 9 );
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x14624fe1, Offset: 0x2d66
// Size: 0x236
function private function_398f9af82ac5b77e( params )
{
    level notify( #"hash_632654f6513efa6c" );
    level utility::clearsharedfunc( #"relics", #"hash_b2dd3117e28e0ada" );
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    
    if ( level callback::exists( #"relic_challenge_ended", &function_398f9af82ac5b77e ) )
    {
        level callback::remove( #"relic_challenge_ended", &function_398f9af82ac5b77e );
    }
    
    if ( level callback::exists( #"player_item_pickup", &on_item_picked_up ) )
    {
        level callback::remove( #"player_item_pickup", &on_item_picked_up );
    }
    
    foreach ( scriptable in level.var_c7eafa733421267e )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.var_c7eafa733421267e = function_5713d46873b29625( level.var_c7eafa733421267e );
    
    foreach ( player in level.players )
    {
        player thread function_eb65bf0431884920();
    }
    
    foreach ( player in level.players )
    {
        player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
    }
    
    function_2d68e3feb1a013b0( "_ring4_orion_kills" );
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0xc4a79bdc, Offset: 0x2fa4
// Size: 0x159
function private function_95efd0dc3c39296a()
{
    level callback::add( #"relic_challenge_ended", &function_398f9bf82ac5b9b1 );
    level.active_relic_challenge.pause_spawning = 1;
    level thread function_c148eb85b6dfb3df( "_ring5_activate", 30 );
    level thread utility::callsharedfunc( #"hornet_ash", #"hash_a3b5e79a2097cdf9", "zone_main_bailey_d" );
    
    if ( !isdefined( level.var_314b13203ad8d55 ) )
    {
        level.var_314b13203ad8d55 = [];
    }
    
    time = 30;
    level thread function_6bcea3fe31e60432( [], time, 5, level.var_314b13203ad8d55 );
    struct = utility::getstruct( "crf_z_rng_5", "targetname" );
    
    if ( struct )
    {
        struct.scriptable = spawnscriptable( %"sat_zm_cr_hold_point", struct.origin, struct.angles );
        struct.scriptable = interaction::register_scriptable_interact( struct.scriptable, &function_94955adf43d7fd1 );
        struct.scriptable utility::function_7c10ea82c1e305b8( "base", "Usable" );
        struct.scriptable.var_94d1ab5da995e573 = 0;
        level.var_314b13203ad8d55[ level.var_314b13203ad8d55.size ] = struct.scriptable;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x7a49f31c, Offset: 0x3105
// Size: 0x1e1
function private function_94955adf43d7fd1( player )
{
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_f314fc2e89d7eccd" );
    
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    level thread function_2ea0a632a87a0345();
    waitframe();
    
    if ( !isdefined( level.active_relic_challenge.ghoul_kills ) )
    {
        level.active_relic_challenge.ghoul_kills = 0;
    }
    
    if ( !isdefined( level.active_relic_challenge.var_f05969d4d9c7dddf ) )
    {
        level.active_relic_challenge.var_f05969d4d9c7dddf = 0;
    }
    
    self.var_929a3ff666a99dac = 1;
    self.var_94d1ab5da995e573 = 1;
    utility::function_7c10ea82c1e305b8( "base", "Activated" );
    var_18608180abc142e8 = [];
    var_18608180abc142e8[ "zone_main_bailey_d" ] = 1;
    var_18608180abc142e8[ "zone_main_bailey_b" ] = 1;
    var_18608180abc142e8[ "zone_main_bailey_a" ] = 1;
    var_18608180abc142e8[ "zone_main_bailey_c" ] = 1;
    level thread function_6bcea3fe31e60432( var_18608180abc142e8, 1, 5, level.var_314b13203ad8d55 );
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring5_activate" );
    zm_quest::function_9f49b2a045ece8ae( 1, 1, quest_bundle.ref, step_ref );
    wait 0.5;
    level.active_relic_challenge.pause_spawning = 0;
    level thread function_c148eb85b6dfb3df( "_ring5_ghoul_kills" );
    flame_structs = utility::getstructarray( "crf_rng_5_flame", "targetname" );
    level thread function_98d7d7957ae0e748( flame_structs, level.var_314b13203ad8d55 );
    wait 2;
    level thread function_24b582a7008fd051();
    
    /#
        iprintlnbold( "<dev string:xc8>" );
    #/
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0xc
// Checksum 0x836db45e, Offset: 0x32ee
// Size: 0x137
function private function_24b582a7008fd051()
{
    self notify( #"hash_7ec4b8aae4fb588e" );
    self endon( #"hash_7ec4b8aae4fb588e" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_f314fc2e89d7eccd" );
    
    while ( level.active_relic_challenge.ghoul_kills < 4 && level.active_relic_challenge.var_3a04ef2068c13fc9 == 5 )
    {
        if ( level.active_relic_challenge.var_f05969d4d9c7dddf < 2 )
        {
            zmb_spawner = zone_spawner::select_spawn_loc( "zombie_ghoul_hvt", undefined, 1 );
            var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
            round_number = zm_round_logic::get_rb_round_number();
            round_number = maxint( round_number, var_1c3d219b34d9181b );
            zombie = zm_relic_challenges::function_fcc576ce75ae207c( "zombie_ghoul_hvt", zmb_spawner, round_number, "special" );
            level.active_relic_challenge.var_f05969d4d9c7dddf++;
            
            if ( zombie )
            {
                zombie callback::add( #"on_ai_killed", &function_8f34a74814e7adf );
            }
        }
        
        wait 3;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x1dbcc1bf, Offset: 0x342d
// Size: 0x158
function private function_8f34a74814e7adf( params )
{
    if ( level.active_relic_challenge.var_3a04ef2068c13fc9 != 5 )
    {
        return;
    }
    
    level.active_relic_challenge.max_ghoul_kills = 4;
    level.active_relic_challenge.ghoul_kills++;
    level.active_relic_challenge.var_f05969d4d9c7dddf--;
    current_kills = level.active_relic_challenge.ghoul_kills;
    max_kills = level.active_relic_challenge.max_ghoul_kills;
    progress_frac = current_kills / max_kills;
    progress_frac = clamp( progress_frac, 0, 1 );
    progress_frac *= 100;
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring5_ghoul_kills" );
    zm_quest::function_9f49b2a045ece8ae( progress_frac, 1, quest_bundle.ref, step_ref );
    
    if ( current_kills >= max_kills )
    {
        if ( level.active_relic_challenge.var_3a04ef2068c13fc9 == 5 )
        {
            zm_relic_challenges::progress_wave( 1, 1 );
            level thread function_398f9bf82ac5b9b1();
        }
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x204ba905, Offset: 0x358d
// Size: 0x18f
function private function_398f9bf82ac5b9b1( params )
{
    level notify( #"hash_f314fc2e89d7eccd" );
    
    if ( level callback::exists( #"relic_challenge_ended", &function_398f9bf82ac5b9b1 ) )
    {
        level callback::remove( #"relic_challenge_ended", &function_398f9bf82ac5b9b1 );
    }
    
    foreach ( scriptable in level.var_314b13203ad8d55 )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.var_314b13203ad8d55 = function_5713d46873b29625( level.var_314b13203ad8d55 );
    function_2d68e3feb1a013b0( "_ring5_activate" );
    function_2d68e3feb1a013b0( "_ring5_ghoul_kills" );
    
    foreach ( player in level.players )
    {
        player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
    }
    
    utility::callsharedfunc( #"hornet_ash", #"hash_b1637e4daf0e7578", "zone_main_bailey_d" );
}

// Namespace namespace_410b54b9533e5a00
// Params 0, eflags: 0x4
// Checksum 0xcc59ca6c, Offset: 0x3724
// Size: 0x140
function private function_fe2c1a16d7971acc()
{
    level callback::add( #"relic_challenge_ended", &function_398f98f82ac5b318 );
    level thread function_c148eb85b6dfb3df( "_ring6_activate" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"relic_complete" );
    level.active_relic_challenge.pause_spawning = 1;
    
    if ( !isdefined( level.var_e0f1325b6f382958 ) )
    {
        level.var_e0f1325b6f382958 = [];
    }
    
    struct = utility::getstruct( "crf_z_rng_6", "targetname" );
    
    if ( struct )
    {
        struct.scriptable = spawnscriptable( %"hash_e14f6fb777c63dc", struct.origin, struct.angles + ( 0, -90, 0 ) );
        struct.scriptable = interaction::register_scriptable_interact( struct.scriptable, &function_19399fcf0cc4f5c6, undefined, undefined );
        struct.scriptable utility::function_7c10ea82c1e305b8( "base", "Usable" );
        struct.scriptable.var_94d1ab5da995e573 = 0;
        level.var_e0f1325b6f382958[ level.var_e0f1325b6f382958.size ] = struct.scriptable;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0xa153609a, Offset: 0x386c
// Size: 0x1e7
function private function_19399fcf0cc4f5c6( player )
{
    level endon( #"game_ended" );
    
    if ( self.var_94d1ab5da995e573 )
    {
        return;
    }
    
    self.var_929a3ff666a99dac = 1;
    self.var_94d1ab5da995e573 = 1;
    utility::function_7c10ea82c1e305b8( "base", "Activated" );
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, "_ring6_activate" );
    zm_quest::function_9f49b2a045ece8ae( 1, 1, quest_bundle.ref, step_ref );
    level thread zm_relic_challenges::function_834b256c06132a78( level.active_relic_challenge.relic_hash );
    wait 1;
    
    foreach ( player in level.players )
    {
        player playsoundevent( %"sndevent_teleportation_player_2d" );
    }
    
    wait 3;
    level.var_7a0e1cc5121e500d = 0;
    var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
    round_number = zm_round_logic::get_rb_round_number();
    round_number = maxint( round_number, var_1c3d219b34d9181b );
    level thread utility::callsharedfunc( #"hash_2e016233ad60f72", #"start_boss_fight", round_number );
    wait 5;
    level thread function_c148eb85b6dfb3df( "_ring6_final", 666 );
    level thread function_6bcea3fe31e60432( [], 666, 6, level.var_e0f1325b6f382958 );
    
    /#
        iprintlnbold( "<dev string:xe4>" );
    #/
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x4d751fd4, Offset: 0x3a5b
// Size: 0xec
function private function_398f98f82ac5b318( params )
{
    if ( level callback::exists( #"relic_challenge_ended", &function_398f98f82ac5b318 ) )
    {
        level callback::remove( #"relic_challenge_ended", &function_398f98f82ac5b318 );
    }
    
    foreach ( scriptable in level.var_e0f1325b6f382958 )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.var_e0f1325b6f382958 = function_5713d46873b29625( level.var_e0f1325b6f382958 );
    function_2d68e3feb1a013b0( "_ring6_activate" );
    function_2d68e3feb1a013b0( "_ring6_final" );
    level thread function_2ea0a632a87a0345();
}

// Namespace namespace_410b54b9533e5a00
// Params 2, eflags: 0x4
// Checksum 0xf50d8e23, Offset: 0x3b4f
// Size: 0x110
function private function_c148eb85b6dfb3df( var_10b9a2bce841a5f2, timer )
{
    level endon( #"game_ended" );
    wait 1;
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, var_10b9a2bce841a5f2 );
    zm_quest::function_cd1f2fee4749fb0a( 1, quest_bundle.ref, step_ref );
    zm_quest::function_9f49b2a045ece8ae( 0, 1, quest_bundle.ref, step_ref );
    zm_quest::function_bf63bf6d044ad598( level.active_relic_challenge.var_189abf4197963d87, 1, quest_bundle.ref, step_ref );
    zm_quest::function_49f2a6a3c1320a6d( level.active_relic_challenge.var_5a5572cb1045b08f, 1, quest_bundle.ref, step_ref );
    
    if ( timer )
    {
        zm_quest::function_612a9ad0db22c29c( timer * 1000, 1, quest_bundle.ref, step_ref );
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 1, eflags: 0x4
// Checksum 0x658e43cd, Offset: 0x3c67
// Size: 0x6f
function private function_2d68e3feb1a013b0( var_10b9a2bce841a5f2 )
{
    quest_bundle = level.active_relic_challenge.quest_bundle;
    step_ref = hashcat( level.active_relic_challenge.bundle.ref, var_10b9a2bce841a5f2 );
    zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_bundle.ref, step_ref );
}

// Namespace namespace_410b54b9533e5a00
// Params 4, eflags: 0xc
// Checksum 0x91d84705, Offset: 0x3cde
// Size: 0x18c
function private function_6bcea3fe31e60432( var_18608180abc142e8, time, var_62a6b384c0358219, clean_up_array )
{
    self notify( #"hash_d5540d20d6acf661" );
    self endon( #"hash_d5540d20d6acf661" );
    level endon( #"game_ended" );
    level endon( #"relic_challenge_end" );
    level endon( #"hash_d613de70387424f0" );
    wait time + 6;
    
    while ( level.active_relic_challenge.var_3a04ef2068c13fc9 == var_62a6b384c0358219 )
    {
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            zone = player zone_manager::get_current_zone();
            
            if ( zone.script_zone_name && var_18608180abc142e8[ zone.script_zone_name ] )
            {
                player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "off" );
                continue;
            }
            
            if ( !player val::get( "freezecontrols" ) )
            {
                player utility::function_7c10ea82c1e305b8( "relic_trial_fog", "on" );
                player dodamage( 25, player.origin, player, player, "MOD_UNKNOWN" );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_410b54b9533e5a00
// Params 2, eflags: 0x4
// Checksum 0xd78a7c73, Offset: 0x3e72
// Size: 0xf6
function private function_98d7d7957ae0e748( var_8cbc5bcddd60888d, clean_up_array )
{
    if ( var_8cbc5bcddd60888d.size > 0 )
    {
        foreach ( struct in var_8cbc5bcddd60888d )
        {
            wait 0.1;
            point = struct.origin;
            var_9e9bcd3c5818482a = getclosestpointonnavmesh( point ) - ( 0, 0, 15 );
            struct.scriptable = spawnscriptable( %"sat_zm_cr_point_edge", var_9e9bcd3c5818482a, struct.angles );
            clean_up_array[ clean_up_array.size ] = struct.scriptable;
        }
    }
}

