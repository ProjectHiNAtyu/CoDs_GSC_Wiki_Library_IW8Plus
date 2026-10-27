// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_bear_attack_quest.gsc  (hash_625f59792195812a.gscc) (size: 21458 Bytes / 0x53d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58f6f800 (1492580352)
// size ...... 21458 (0x53d2)
// includes .. 31  (offset: 0x4e3a)
// strings ... 66  (offset: 0x4f32)
// dev strs .. 14  (offset: 0x532a)
// exports ... 54  (offset: 0x2d4e)
// cseg ...... 0x5e1 + 0x276d (0x2d4e)
// imports ... 207 (offset: 0x35be)
// animtree1 . 0   (offset: 0x53d2)
// animtree2 . 0   (offset: 0x53d2)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_bear_attack_quest;

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x5
// Checksum 0xeb8352fd, Offset: 0x5ff
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_a01cfb0950aec38", undefined, undefined, &init );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xc5090b01, Offset: 0x620
// Size: 0x1de
function init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    if ( game_utility::function_21211f3255f8ea58() )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_bear_attack_quest_cs_completed" );
    level.bear_attack_quest = zm_quest::get_quest( #"firefly_bear_attack_quest" );
    zm_quest::register_quest_step( #"firefly_bear_attack_quest", #"follow_prints", &function_ef944b4fcd6e3ff6, &function_9f9c1fcde9ffba51 );
    zm_quest::register_quest_step( #"firefly_bear_attack_quest", #"fight_bear", &function_ef944a4fcd6e3dc3, &function_9f9c1ccde9ffb3b8 );
    zm_quest::function_3c363613c60958f5( "progressing_bear_attack_quest" );
    level thread function_c0e23fc19d2b148b();
    
    /#
        function_1a807ce802e64642();
    #/
    
    foreach ( player in level.players )
    {
        player thread register_quest_item_used();
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( #"player_laststand", &function_b1a70274e9508a18 );
    utility::registersharedfunc( #"zombie", #"hash_f2c6034e2393f380", &function_c1e1f34bb4201be8 );
    level callback::add( "on_zombie_callisto_spawned", &function_3b3d490804dd22c0 );
    level callback::add( "on_zombie_callisto_hvt_spawned", &function_3b3d490804dd22c0 );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x49491fab, Offset: 0x806
// Size: 0x13
function on_player_connect( params )
{
    thread register_quest_item_used();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0xc
// Checksum 0xe28d0434, Offset: 0x821
// Size: 0x50
function private register_quest_item_used()
{
    self notify( #"hash_c5c4e4de5bfa31f8" );
    self endon( #"hash_c5c4e4de5bfa31f8" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level utility::flag_wait( "scriptables_ready" );
    callback::add( "quest_item_used", &function_f23d0a8e2ac87e2a );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x617f0322, Offset: 0x879
// Size: 0x24
function on_player_spawned( params )
{
    self setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
    self setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xa120223e, Offset: 0x8a5
// Size: 0x21
function on_player_disconnect( params )
{
    if ( self == level.ba_ee_player )
    {
        clear_zone();
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xb1bda40d, Offset: 0x8ce
// Size: 0x2b
function on_player_death( params )
{
    if ( self == level.ba_ee_player )
    {
        self.var_77bdf680e20d4bd0 = undefined;
        clear_zone();
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xd22fedf4, Offset: 0x901
// Size: 0x25
function function_b1a70274e9508a18( params )
{
    if ( self == level.ba_ee_player )
    {
        self.var_bf82e408b7a0e3c3 = 1;
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0x157a689a, Offset: 0x92e
// Size: 0xe
function private clear_zone()
{
    level notify( #"ba_ee_quit" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0xcc55a28a, Offset: 0x944
// Size: 0x34
function private function_c0e23fc19d2b148b()
{
    level endon( #"game_ended" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"firefly_bear_attack_quest" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0xe8bb778, Offset: 0x980
// Size: 0x4a
function private function_1cbf20f9abdca7c8()
{
    var_878fda9024f931 = utility::getstruct( "sq_bear_attack_chest", "targetname" );
    level.var_e6245e0757444937 = spawnscriptable( %"zm_sat_firefly_bear_attack_ee_lootcrate", var_878fda9024f931.origin, var_878fda9024f931.angles );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 2, eflags: 0x4
// Checksum 0xe37165cf, Offset: 0x9d2
// Size: 0x4f
function private function_ef944b4fcd6e3ff6( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level init_bear_prints();
    level utility::flag_wait( "bear_attack_step_1_complete" );
    level utility::flag_set( "ee_zone_enabled" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 2, eflags: 0x4
// Checksum 0xb2c006b5, Offset: 0xa29
// Size: 0x20
function private function_9f9c1fcde9ffba51( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 2, eflags: 0x4
// Checksum 0x6d6226d, Offset: 0xa51
// Size: 0x3a
function private function_ef944a4fcd6e3dc3( b_skipped, b_save_restored )
{
    level endon( #"game_ended" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "bear_attack_step_2_complete" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 2, eflags: 0x4
// Checksum 0x56446521, Offset: 0xa93
// Size: 0x35
function private function_9f9c1ccde9ffb3b8( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level thread function_8c5cf128438ca8e0();
        level utility::flag_set( "bear_attack_step_2_complete" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xba71dac6, Offset: 0xad0
// Size: 0x3a
function init_bear_prints()
{
    var_da3dc0acbb9dc02b = utility::getstructarray( "ba_ee_1st_fp_loc", "script_noteworthy" );
    random_loc = var_da3dc0acbb9dc02b[ randomint( var_da3dc0acbb9dc02b.size ) ];
    function_76072dfc104a8c3c( random_loc );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x6bfe2e49, Offset: 0xb12
// Size: 0x62
function function_76072dfc104a8c3c( spawn_loc )
{
    var_8c8d9a2f96844a34 = utility::spawn_model( %"zm_sat_firefly_bear_attack_bear_print", spawn_loc.origin, spawn_loc.angles );
    var_8c8d9a2f96844a34 utility::function_32b24db3127bff40( "footprint", "on" );
    var_8c8d9a2f96844a34 thread function_8faf49348d94aa57();
    spawn_loc thread function_310efe09561f4b4();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0xc
// Checksum 0x20c10ce0, Offset: 0xb7c
// Size: 0x4c
function private function_329c5685277f2b79( step )
{
    self notify( #"hash_6a8ea6ea6bcb7f16" );
    self endon( #"hash_6a8ea6ea6bcb7f16" );
    level endon( #"game_ended" );
    self endon( #"death" );
    level utility::flag_wait( step );
    self delete();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xa0e9cb1d, Offset: 0xbd0
// Size: 0x12d
function function_310efe09561f4b4()
{
    level endon( #"game_ended" );
    level endon( #"bear_attack_step_1_complete" );
    trigger = spawn( "trigger_radius", self.origin, undefined, 50, 30 );
    
    /#
        if ( getdvarint( @"hash_70b7a86a04bb47d0", 0 ) )
        {
            trigger thread function_95d30d11e48221bb();
        }
    #/
    
    trigger thread function_329c5685277f2b79( "bear_attack_step_1_complete" );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) && player hasperk( "specialty_death_perception" ) && !player.ismutantinjection && zm_quest::function_f98968f17772726c( 1 ) )
        {
            if ( isdefined( self.target ) )
            {
                var_de836d7c3a111ddf = utility::getstruct( self.target, "targetname" );
                function_76072dfc104a8c3c( var_de836d7c3a111ddf );
            }
            else if ( !utility::flag( "ee_zone_enabled" ) )
            {
                level thread init_bear_fight( player );
                level.s_return_loc = self;
                level utility::flag_set( "bear_attack_step_1_complete" );
            }
            
            break;
        }
    }
    
    trigger delete();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xb41777b2, Offset: 0xd05
// Size: 0xf2
function function_8faf49348d94aa57()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_ddbff7b53796e636 = 2250000;
    
    while ( !level.var_facc520a72b71b43 )
    {
        foreach ( player in level.players )
        {
            if ( player hasperk( "specialty_death_perception" ) && distance2dsquared( player.origin, self.origin ) < var_ddbff7b53796e636 )
            {
                self showtoplayer( player );
                continue;
            }
            
            self hidefromplayer( player );
        }
        
        wait 2;
    }
    
    self delete();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xecb854e, Offset: 0xdff
// Size: 0x34b
function init_bear_fight( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( level.var_facc520a72b71b43 )
    {
        return;
    }
    
    level.var_facc520a72b71b43 = 1;
    player val::set( "ba_ee", "show_hud", 0 );
    player val::set( "ba_ee", "ignoreme", 1 );
    player val::set( "ba_ee", "killstreaks", 0 );
    player val::set( "ba_ee", "show_compass", 0 );
    player player::hideminimap( 1 );
    player notify( #"progressing_bear_attack_quest" );
    level utility::flag_set( "progressing_bear_attack_quest" );
    
    if ( player.allyeuropa )
    {
        player utility::callsharedfunc( #"europa", #"hash_461d60a67b99be95" );
        player.allyeuropa utility::callsharedfunc( #"europa", #"hash_128edca9c946949c" );
    }
    
    player thread utility::callsharedfunc( #"mutant_injection", #"hash_a5f95a84b4e1bbaf", 1 );
    player_spawn_loc = utility::getstruct( "sq_bear_attack_player_cave_spawn_loc", "targetname" );
    assert( isdefined( player_spawn_loc ) && isdefined( player ) );
    player_spawn_loc thread scene::pre_stream_play( 1.5, [ player ], "shot_010", "sat_cin_zm_vig_plr_dth_callisto_01" );
    level namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1.5 );
    
    foreach ( sceneobjectdata in player_spawn_loc.scenedata.sceneobjectdata )
    {
        if ( isagent( sceneobjectdata.entity ) )
        {
            sceneobjectdata.entity val::set( "ba_ee_scene_actor", "show_healthbar", 0 );
        }
    }
    
    level thread function_5810051a4cac60b1( player );
    player setorigin( player_spawn_loc.origin );
    player setplayerangles( player_spawn_loc.angles );
    shot_seconds = player_spawn_loc scene::function_b3c7b792a7a154fa( "shot_010" );
    assert( shot_seconds > 3 );
    player val::set( "ba_ee", "ignoreme", 0 );
    waitframe();
    level namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1.5 );
    player function_538d84f484f623f();
    wait shot_seconds - 3;
    level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1.5 );
    player playsoundtoplayer( "evt_zm_firefly_ee_bear_attack_transition_in", player );
    player utility::function_32b24db3127bff40( "bear_attack_fx", "on" );
    pbgpostfxbundlestart( player, "sat_zm_firefly_bear_hallucination" );
    level thread spawn_zursa();
    player playsoundtoplayer( "evt_zm_firefly_ee_bear_attack_transition_in", player );
    wait 1.5;
    level namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1.5 );
    player setclientomnvar( "ui_zm_is_bear_attack_quest", 1 );
    player setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    
    if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        player thread function_18557325262e89f( #"hash_4094b053e1ae1b52" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xe8116b99, Offset: 0x1152
// Size: 0x224
function spawn_zursa()
{
    level endon( #"game_ended" );
    zursa_spawn_loc = utility::getstruct( "sq_bear_attack_bear_cave_spawn_loc", "targetname" );
    assert( isdefined( zursa_spawn_loc.origin ) );
    
    if ( zm_round_logic::get_rb_round_number() <= 27 )
    {
        round_number = 27;
    }
    else if ( zm_round_logic::get_rb_round_number() >= 30 )
    {
        round_number = 30;
    }
    else
    {
        round_number = zm_round_logic::get_rb_round_number();
    }
    
    var_c82c6d9cbe2d7ae4 = undefined;
    var_7fddd291a646eb9a = 5;
    var_385c77d9859710a3 = 15;
    var_b8313b3a65a15baf = 2;
    var_4eb74f56ee6fce9c = 0;
    tried_round = 0;
    ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_callisto_hvt", [ "stam_zm_sat_firefly_callisto_melee" ] );
    
    while ( tried_round < var_385c77d9859710a3 )
    {
        while ( var_4eb74f56ee6fce9c < var_7fddd291a646eb9a )
        {
            active_zombie_count = zm_utility::get_active_zombies_count();
            
            if ( active_zombie_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
            {
                zm_utility::function_71d7c0e7375ef487( 1, [ "normal" ] );
            }
            
            var_c82c6d9cbe2d7ae4 = agent_manager::spawn_agent( ai_type, zursa_spawn_loc.origin );
            
            if ( var_c82c6d9cbe2d7ae4 )
            {
                break;
            }
            
            waitframe();
            var_4eb74f56ee6fce9c++;
        }
        
        if ( var_c82c6d9cbe2d7ae4 )
        {
            var_c82c6d9cbe2d7ae4 callback::add( #"on_ai_killed", &function_cd667a5266c3908b );
            var_c82c6d9cbe2d7ae4 zombie_utils::set_zombie_round_difficulty( round_number );
            var_c82c6d9cbe2d7ae4.var_a13bed1ac47e1b2c = 1;
            var_c82c6d9cbe2d7ae4.no_powerups = 1;
            var_c82c6d9cbe2d7ae4.var_15598d8e493afe88 = 1;
            var_c82c6d9cbe2d7ae4.b_cleanup_no_respawn = 1;
            var_c82c6d9cbe2d7ae4.var_825b17c932865df = 1;
            var_c82c6d9cbe2d7ae4.var_7ee152b43c7188e1 = 1;
            var_c82c6d9cbe2d7ae4.ignore_enemy_count = 1;
            var_c82c6d9cbe2d7ae4.var_3398539ec080ceec = 1;
            var_c82c6d9cbe2d7ae4 thread force_kill_zursa();
            return;
        }
        
        wait var_b8313b3a65a15baf;
        tried_round++;
    }
    
    assert( isdefined( var_c82c6d9cbe2d7ae4 ), "<dev string:x24>" + ai_type + "<dev string:x4b>" + zursa_spawn_loc.origin + "<dev string:x5b>" );
    clear_zone();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x4cafba03, Offset: 0x137e
// Size: 0x62
function function_cd667a5266c3908b( var_6f88a6bfefadea5e )
{
    callback::remove( #"on_ai_killed", &function_cd667a5266c3908b );
    level thread function_a7885da8c2445eaa( self );
    
    if ( isplayer( var_6f88a6bfefadea5e.eattacker ) )
    {
        var_6f88a6bfefadea5e.eattacker thread function_18557325262e89f( #"hash_13b78fbe5266065e", #"bc_flavor_player_positive", 2 );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 3
// Checksum 0xab0ff3f, Offset: 0x13e8
// Size: 0x88
function function_18557325262e89f( var_8984c1f1eeea88ec, var_1c360473c4174a43, delay )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( self && !self.var_ffd22ab3381d687f )
    {
        self.var_ffd22ab3381d687f = 1;
        played = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec, var_1c360473c4174a43 );
        
        if ( played )
        {
            wait 2;
        }
        
        if ( self )
        {
            self.var_ffd22ab3381d687f = undefined;
        }
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x26f8402a, Offset: 0x1478
// Size: 0x214
function take_weapons()
{
    if ( self.var_488d504451d7ae6 )
    {
        return;
    }
    
    weaplist = self getweaponslistprimaries();
    
    if ( weaplist.size > 1 )
    {
        micontext = spawnstruct();
        micontext.lastweaponobj = self getcurrentweapon();
        micontext.weapstructs = [];
        meleeoverrideweapon = self getweaponmeleeslot();
        
        foreach ( weap in weaplist )
        {
            if ( !weapon::function_6b74ecd475e99b4( weap ) || weapon::isfistsonly( weap ) )
            {
                if ( !weap.isalternate && item_weapon::function_46d840bd6268e2ce( weap ) )
                {
                    weapstruct = spawnstruct();
                    weapstruct.weaponobj = weap;
                    weapstruct.clipammo = self getweaponammoclip( weap );
                    
                    if ( weapon::isakimbo( weap ) )
                    {
                        weapstruct.clipammo_l = self getweaponammoclip( weap, "left" );
                    }
                    
                    weapstruct.stockammo = self getweaponammostock( weap );
                    weapstruct.pap_level = pack_a_punch::get_pap_level( weap );
                    weapstruct.rarity = item_weapon::function_fb81bd2fe070faa6( weap );
                    weapstruct.ammo_mod = ammo_mod::get_ammo_mod_name( weap );
                    micontext.weapstructs[ micontext.weapstructs.size ] = weapstruct;
                }
                
                item_weapon::function_9e7275fa51ace996( weap, "fireflybearee_takeweapons" );
                item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:weap } );
            }
        }
    }
    
    if ( isdefined( micontext ) )
    {
        self switchtoweaponimmediate( meleeoverrideweapon );
        weapon::fixupplayerweapons( self, meleeoverrideweapon );
        self.var_488d504451d7ae6 = micontext;
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xac9f8662, Offset: 0x1694
// Size: 0x1eb
function function_f12453e0ba4752f9()
{
    if ( isdefined( self ) && isdefined( self.var_488d504451d7ae6 ) )
    {
        micontext = self.var_488d504451d7ae6;
        
        if ( isdefined( micontext.weapstructs ) )
        {
            foreach ( weapstruct in micontext.weapstructs )
            {
                item_weapon::function_35910aac16378fec( weapstruct.weaponobj, weapstruct.clipammo, weapstruct.stockammo );
                item_weapon::function_d6a514964e1e7f2c( weapstruct.weaponobj );
                
                if ( weapstruct.pap_level > 0 )
                {
                    pack_a_punch::function_3f3b9cdbb4843e45( weapstruct.weaponobj, weapstruct.pap_level, 1 );
                }
                
                item_weapon::function_40e1cbd0e1f47d1a( weapstruct.weaponobj, weapstruct.rarity, 1 );
                
                if ( weapstruct.ammo_mod )
                {
                    ammo_mod::add_ammo_mod_to_weapon( weapstruct.weaponobj, weapstruct.ammo_mod, 1 );
                }
                
                if ( weapon::isakimbo( weapstruct.weaponobj ) && weapstruct.clipammo_l >= 0 )
                {
                    self setweaponammoclip( weapstruct.weaponobj, weapstruct.clipammo_l, "left" );
                }
                
                if ( micontext.lastweaponobj == weapstruct.weaponobj )
                {
                    self switchtoweaponimmediate( weapstruct.weaponobj );
                }
                
                weapon::fixupplayerweapons( self, weapstruct.weaponobj );
            }
        }
        
        self.var_488d504451d7ae6 = undefined;
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x6f11512d, Offset: 0x1887
// Size: 0xcc
function take_equipments()
{
    ref = equipment_mp::getcurrentequipment( "secondary" );
    currammo = equipment_mp::getequipmentammo( ref );
    self.var_c2e2c8266481ba98 = spawnstruct();
    self.var_c2e2c8266481ba98.ref = ref;
    self.var_c2e2c8266481ba98.ammo = currammo;
    equipment_mp::takeequipment( "secondary" );
    ref = equipment_mp::getcurrentequipment( "primary" );
    currammo = equipment_mp::getequipmentammo( ref );
    self.var_a7836a0eda410c5 = spawnstruct();
    self.var_a7836a0eda410c5.ref = ref;
    self.var_a7836a0eda410c5.ammo = currammo;
    equipment_mp::takeequipment( "primary" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x13c87164, Offset: 0x195b
// Size: 0xc8
function function_c9b7b8b6a96da40d()
{
    if ( isdefined( self.var_c2e2c8266481ba98 ) )
    {
        equipment_mp::giveequipment( self.var_c2e2c8266481ba98.ref, "secondary" );
        equipment_mp::setequipmentammo( self.var_c2e2c8266481ba98.ref, self.var_c2e2c8266481ba98.ammo );
        self.var_c2e2c8266481ba98 = undefined;
    }
    
    if ( isdefined( self.var_a7836a0eda410c5 ) )
    {
        equipment_mp::giveequipment( self.var_a7836a0eda410c5.ref, "primary" );
        equipment_mp::setequipmentammo( self.var_a7836a0eda410c5.ref, self.var_a7836a0eda410c5.ammo );
        self.var_a7836a0eda410c5 = undefined;
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xb97b1511, Offset: 0x1a2b
// Size: 0x2fe
function function_232bcd7d0725d19e( player )
{
    weapstructs = player.var_488d504451d7ae6.weapstructs;
    tactical = player.var_c2e2c8266481ba98;
    lethal = player.var_a7836a0eda410c5;
    var_11c2017681e0cc8f = utility::getstruct( "sq_bear_attack_center_cave", "targetname" );
    level.weapons_taken = [];
    
    if ( weapstructs )
    {
        offset = ( 10, 10, 0 );
        loc = var_11c2017681e0cc8f.origin;
        
        foreach ( weap in weapstructs )
        {
            weapon_on_ground = function_2535619d314c1099( weap.weaponobj, loc, var_11c2017681e0cc8f.angles );
            
            if ( weapon_on_ground )
            {
                level.weapons_taken[ level.weapons_taken.size ] = weapon_on_ground;
                loc += offset;
            }
        }
    }
    
    if ( tactical )
    {
        offset = ( -8, 12, 0 );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_11c2017681e0cc8f.origin + offset, var_11c2017681e0cc8f.angles );
        bundlename = common_item_database::function_a4f0a21951180013( tactical.ref );
        
        if ( bundlename )
        {
            weapon_on_ground = common_item::function_61c2c0251e742ffd( bundlename, tactical.ammo, spawnoptions );
            
            if ( weapon_on_ground )
            {
                weapon_on_ground disablescriptableplayeruse( player );
                level.weapons_taken[ level.weapons_taken.size ] = weapon_on_ground;
            }
        }
    }
    
    if ( lethal )
    {
        offset = ( -7, -5, 0 );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( var_11c2017681e0cc8f.origin + offset, var_11c2017681e0cc8f.angles );
        bundlename = common_item_database::function_a4f0a21951180013( lethal.ref );
        
        if ( bundlename )
        {
            weapon_on_ground = common_item::function_61c2c0251e742ffd( bundlename, lethal.ammo, spawnoptions );
            
            if ( weapon_on_ground )
            {
                weapon_on_ground disablescriptableplayeruse( player );
                level.weapons_taken[ level.weapons_taken.size ] = weapon_on_ground;
            }
        }
    }
    
    var_11c2017681e0cc8f.interact = interaction::register_interact( var_11c2017681e0cc8f.origin + ( 0, 0, 25 ), 360, &function_fc20b517a58d1f62 );
    var_11c2017681e0cc8f.interact thread function_329c5685277f2b79( "bear_attack_step_2_complete" );
    level.bear_attack_loadout_sign_fx = spawnscriptable( %"zm_sat_firefly_bear_attack_loadout_sign_fx", var_11c2017681e0cc8f.origin );
    level.bear_attack_loadout_sign_fx setscriptablepartstate( "vfx", "on" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x7a4b3e1d, Offset: 0x1d31
// Size: 0x37
function function_fc20b517a58d1f62( player )
{
    player setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
    player setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 1 );
    player function_17a61640a7d3926f( 0 );
    self delete();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0x4
// Checksum 0xec38585c, Offset: 0x1d70
// Size: 0xe6
function private function_17a61640a7d3926f( var_99b13162d2894d8d = 1 )
{
    thread function_f12453e0ba4752f9();
    function_c9b7b8b6a96da40d();
    
    if ( self.var_d126f6884cde162 )
    {
        foreach ( str_perk in self.var_d126f6884cde162 )
        {
            zombie_perks::give_perk( str_perk );
        }
        
        self.var_d126f6884cde162 = undefined;
    }
    
    if ( self.var_77bdf680e20d4bd0 && var_99b13162d2894d8d )
    {
        laststand::function_39844c1e879cc048( self.var_77bdf680e20d4bd0 );
        self.var_77bdf680e20d4bd0 = undefined;
    }
    
    level function_8362151845277b87();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0x8b693f35, Offset: 0x1e5e
// Size: 0xc8
function private function_8362151845277b87()
{
    if ( level.weapons_taken )
    {
        foreach ( weap in level.weapons_taken )
        {
            if ( isent( weap ) )
            {
                weap delete();
                continue;
            }
            
            common_item::function_869d7676e359a627( weap );
        }
        
        level.weapons_taken = undefined;
    }
    
    if ( level.bear_attack_loadout_sign_fx )
    {
        level.bear_attack_loadout_sign_fx freescriptable();
        level.bear_attack_loadout_sign_fx = undefined;
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0x39865736, Offset: 0x1f2e
// Size: 0x39
function private function_6af2062d7e4581b6()
{
    if ( level.rewards_necklace )
    {
        level.rewards_necklace utility::scriptable_clearparententity();
        level.rewards_necklace = undefined;
    }
    
    zm_quest::function_2850bf8c7015dc92( [ "zone_dempsey" ] );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0x41862349, Offset: 0x1f6f
// Size: 0x54
function private force_kill_zursa()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    level waittill( #"ba_ee_quit" );
    callback::remove( #"on_ai_killed", &function_cd667a5266c3908b );
    self.var_a13bed1ac47e1b2c = 1;
    wait 3;
    
    if ( self )
    {
        self kill();
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0x4
// Checksum 0xc621e21a, Offset: 0x1fcb
// Size: 0x426
function private function_a7885da8c2445eaa( zursa )
{
    level endon( #"game_ended" );
    level endon( #"ba_ee_quit" );
    var_cdc2faf4e72eed6d = utility::getstruct( "ba_ee_necklace_loc", "script_noteworthy" );
    goalpos = zursa getclosestreachablepointonnavmesh( var_cdc2faf4e72eed6d.origin );
    var_fc1e8bf8b231c6cf = zursa findpath( zursa.origin, goalpos );
    
    if ( !var_fc1e8bf8b231c6cf )
    {
        var_fc1e8bf8b231c6cf = [ goalpos ];
    }
    
    die_pos = zursa.origin;
    give_necklace = zursa.in_melee_mode;
    mdl_soul_charge = utility::spawn_model( "tag_origin", die_pos );
    mdl_soul_height = ( 0, 0, 20 );
    wait 6;
    var_b6f300009163a299 = spawnscriptable( %"zm_sat_firefly_dmps_ee_wisp", die_pos + mdl_soul_height );
    var_b6f300009163a299 thread function_af408d5d9a4a7d13();
    var_b6f300009163a299 utility::scriptable_setparententity( mdl_soul_charge );
    var_b6f300009163a299 setscriptablepartstate( "base", "spawn" );
    wait 0.5;
    
    if ( var_b6f300009163a299 )
    {
        var_b6f300009163a299 setscriptablepartstate( "base", "hide" );
        var_b6f300009163a299 setscriptablepartstate( "trail", "on" );
    }
    
    p1 = die_pos;
    
    foreach ( p in var_fc1e8bf8b231c6cf )
    {
        if ( mdl_soul_charge )
        {
            start_pos = p1 + mdl_soul_height;
            end_pos = p + mdl_soul_height;
            mdl_soul_charge thread zm_quest::function_b8743f5a9219cf9b( start_pos, end_pos, undefined, -1, 0.08, 0, 2, undefined, undefined, 0 );
            mdl_soul_charge waittill( #"curve_done" );
            p1 = p;
        }
    }
    
    if ( var_b6f300009163a299 )
    {
        var_b6f300009163a299 setscriptablepartstate( "trail", "off" );
        var_b6f300009163a299 setscriptablepartstate( "base", "despawn" );
    }
    
    wait 3;
    
    if ( var_b6f300009163a299 )
    {
        var_b6f300009163a299 utility::scriptable_clearparententity();
        var_b6f300009163a299 freescriptable();
        var_b6f300009163a299 = undefined;
    }
    
    level utility::flag_set( "bear_attack_step_2_complete" );
    
    if ( level.var_e6245e0757444937 )
    {
        level.var_e6245e0757444937 utility::function_7c10ea82c1e305b8( "model", "opened" );
    }
    
    if ( level.ba_ee_player )
    {
        s_reward_loc = utility::getstruct( "ba_ee_common_reward_loc", "script_noteworthy" );
        var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_bear_attack_ee_rewards", "Default" );
        nav_angle = var_8b5270de14dff72e.size > 0 ? 120 / var_8b5270de14dff72e.size : 120;
        v = anglestoforward( s_reward_loc.angles );
        
        for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
        {
            itemspawnentryname = var_8b5270de14dff72e[ i ];
            v2 = rotatevector( v, ( 0, i * nav_angle - 15, 0 ) );
            drop_point = getrandomnavpoint( s_reward_loc.origin + v2 * 60, 15 );
            droppeditem = common_item::function_47324f290423b2d1( itemspawnentryname, s_reward_loc.origin, drop_point );
            wait 0.1;
        }
        
        if ( give_necklace )
        {
            drop_point = getrandomnavpoint( var_cdc2faf4e72eed6d.origin + anglestoforward( var_cdc2faf4e72eed6d.angles ) * 40, 25 );
            itembundle = getscriptbundle( hashcat( %"itemspawnentry:", "zm_sat_item_firefly_ba_ee_necklace" ) );
            e_necklace = common_item::function_47324f290423b2d1( itembundle, var_cdc2faf4e72eed6d.origin, drop_point );
            level.rewards_necklace = e_necklace;
            e_necklace thread function_bb18e7f38d178a0e();
        }
    }
    
    wait 3;
    
    if ( level.var_e6245e0757444937 )
    {
        level.var_e6245e0757444937 utility::function_7c10ea82c1e305b8( "model", "closed" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0, eflags: 0x4
// Checksum 0xd91d763b, Offset: 0x23f9
// Size: 0x44
function private function_af408d5d9a4a7d13()
{
    level endon( #"game_ended" );
    self endon( #"delete" );
    self endon( #"death" );
    level waittill( #"ba_ee_quit" );
    
    if ( self )
    {
        utility::scriptable_clearparententity();
        self freescriptable();
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x316b46bf, Offset: 0x2445
// Size: 0xc9
function function_bb18e7f38d178a0e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 1;
    bob_root = utility::spawn_model( "tag_origin", self.origin, self.angles );
    bob_root endon( #"deleted" );
    bob_root endon( #"death" );
    self.root = bob_root;
    utility::scriptable_setparententity( bob_root );
    
    while ( isdefined( bob_root ) )
    {
        bob_root movez( 5, 1.5, 0.5, 0.5 );
        bob_root waittill( #"movedone" );
        bob_root movez( -5, 1.5, 0.5, 0.5 );
        bob_root waittill( #"movedone" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xff5f83a, Offset: 0x2516
// Size: 0xc9
function function_f23d0a8e2ac87e2a( params )
{
    if ( params.bundle.ref == #"sat_zm_quest_firefly_baq_nl" )
    {
        player = params.player;
        self.var_655852b1b8481deb = 1;
        zm_quest::function_4eefe6de31f5ddab( #"firefly_bear_attack_quest", #"hash_424eab70253d06b", player getentitynumber() );
        zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"sat_zm_quest_firefly_baq_nl", 1, undefined, player );
        
        if ( params.scriptable )
        {
            params.scriptable utility::scriptable_clearparententity();
        }
        
        self playsound( #"hash_bbf307c5f516f9ad" );
        level notify( #"ba_ee_necklace_picked_up" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0x4
// Checksum 0xfa6d1119, Offset: 0x25e7
// Size: 0x3d
function private function_3b3d490804dd22c0( params )
{
    if ( !isdefined( self.var_f3f3b4d926db02c7 ) || !arraycontains( self.var_f3f3b4d926db02c7, &function_4caf5b9134c00a31 ) )
    {
        zombie_utils::function_dfae6a5bd222c586( &function_4caf5b9134c00a31 );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x1719e6b0, Offset: 0x262c
// Size: 0xfd
function function_8c5cf128438ca8e0()
{
    level endon( #"game_ended" );
    entitynumber = zm_quest::function_73720cdf21c3cfd7( #"firefly_bear_attack_quest", #"hash_424eab70253d06b" );
    
    if ( isdefined( entitynumber ) && zm_save::function_1dda3554974a999e() )
    {
        while ( level.players.size <= 0 )
        {
            waitframe();
        }
        
        foreach ( player in level.players )
        {
            if ( entitynumber == player getentitynumber() )
            {
                player.var_655852b1b8481deb = 1;
                zm_quest::function_b57dfe9625966b0b( #"misc", 0, #"sat_zm_quest_firefly_baq_nl", 1, undefined, player );
                return;
            }
        }
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0x35087524, Offset: 0x2731
// Size: 0x223
function function_5810051a4cac60b1( player )
{
    level endon( #"game_ended" );
    level function_1cbf20f9abdca7c8();
    level.ba_ee_player = player;
    zone_manager::set_zone_enabled( "zone_dempsey", 1 );
    zone_spawner::function_2ce7db1d59b307d8( "zone_dempsey" );
    zm_quest::function_d7216beb89a22329();
    
    if ( player )
    {
        player.var_d126f6884cde162 = player zombie_perks::get_active_perks_str_array();
        player thread zombie_perks::take_all_perks( 1 );
        player take_weapons();
        player take_equipments();
        player.var_77bdf680e20d4bd0 = player laststand::function_7072b516e6cffb7c();
        player laststand::function_39844c1e879cc048( 0 );
        level function_232bcd7d0725d19e( player );
    }
    
    wait 7;
    
    if ( player )
    {
        player utility::function_32b24db3127bff40( "bear_attack_fx", "off" );
        player utility::function_32b24db3127bff40( "bear_attack_fx", "end" );
        pbgpostfxbundleend( player, "sat_zm_firefly_bear_hallucination" );
    }
    
    level thread start_timeout_watcher();
    level thread reset_player_watcher( player );
    level thread function_909961cbc79a72a();
    
    if ( level.ba_ee_player )
    {
        level waittill( #"ba_ee_quit" );
    }
    
    level.ba_ee_player = undefined;
    zm_quest::function_d04a18ed4295a8cd();
    
    if ( player )
    {
        level namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 1.5 );
        player playsoundtoplayer( "evt_zm_firefly_ee_bear_attack_transition_out", player );
        player thread function_90a1131e6a4f7a9d( 15 );
        player setorigin( level.s_return_loc.origin );
        player setplayerangles( level.s_return_loc.angles );
        player player::showminimap();
        level namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1.5 );
        player val::reset_all( "ba_ee" );
    }
    
    if ( level.var_e6245e0757444937 )
    {
        level.var_e6245e0757444937 freescriptable();
        level.var_e6245e0757444937 = undefined;
    }
    
    level function_6af2062d7e4581b6();
    level function_8362151845277b87();
    level.var_facc520a72b71b43 = undefined;
    zone_manager::set_zone_enabled( "zone_dempsey", 0 );
    zone_spawner::function_8a020f24a3b73c79( "zone_dempsey" );
    level utility::flag_clear( "ee_zone_enabled" );
    level utility::flag_clear( "progressing_bear_attack_quest" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0x4
// Checksum 0xc733705e, Offset: 0x295c
// Size: 0x52
function private function_90a1131e6a4f7a9d( seconds )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    assert( seconds > 0 );
    val::set( "ba_ee_notarget", "ignoreme", 1 );
    wait seconds;
    val::reset_all( "ba_ee_notarget" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 2
// Checksum 0x480410d8, Offset: 0x29b6
// Size: 0x7f
function function_c1e1f34bb4201be8( score_event_info, base_points )
{
    points = base_points;
    
    if ( self.var_655852b1b8481deb && score_event_info.smeansofdeath == "MOD_MELEE" )
    {
        points = base_points * 2;
        single_digit = points % 10;
        
        if ( single_digit >= 5 )
        {
            single_digit = 5;
        }
        else
        {
            single_digit = 0;
        }
        
        points = int( points / 10 ) * 10 + single_digit;
    }
    
    return points;
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1, eflags: 0x4
// Checksum 0xc2e4d2c5, Offset: 0x2a3e
// Size: 0x47
function private function_4caf5b9134c00a31( params )
{
    damage = params.idamage;
    
    if ( params.eattacker.var_655852b1b8481deb )
    {
        damage *= 1.05;
    }
    
    return damage;
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xebc9d673, Offset: 0x2a8e
// Size: 0x1b
function function_538d84f484f623f()
{
    if ( namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        thread function_18557325262e89f( #"hash_31ba0536ec5f5ac7" );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 1
// Checksum 0xedd83bd6, Offset: 0x2ab1
// Size: 0x79
function reset_player_watcher( player )
{
    if ( player )
    {
        player endon( #"death_or_disconnect" );
    }
    
    level endon( #"game_ended" );
    level utility::waittill_any( "bear_attack_step_2_complete", "ba_ee_quit" );
    
    if ( player )
    {
        player function_17a61640a7d3926f();
        player val::set( "ba_ee", "show_hud", 1 );
        player setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
        player setclientomnvar( "ui_zm_is_bear_attack_quest_show_loadout", 0 );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xc4d1169, Offset: 0x2b32
// Size: 0x2a
function function_909961cbc79a72a()
{
    level endon( #"game_ended" );
    level waittill( #"bear_attack_step_2_complete" );
    wait 30;
    level notify( #"ba_ee_quit" );
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0x25d07756, Offset: 0x2b64
// Size: 0x3b
function start_timeout_watcher()
{
    level endon( #"game_ended" );
    level endon( #"ba_ee_quit" );
    level endon( #"bear_attack_step_2_complete" );
    level utility::flag_wait( "mq_waiting_to_commence" );
    level thread function_59d2642f4353515e();
}

// Namespace zm_sat_firefly_bear_attack_quest
// Params 0
// Checksum 0xe57b1d39, Offset: 0x2ba7
// Size: 0x36
function function_59d2642f4353515e()
{
    level endon( #"game_ended" );
    level endon( #"ba_ee_quit" );
    level endon( #"bear_attack_step_2_complete" );
    wait 300;
    level notify( #"ba_ee_quit" );
}

/#

    // Namespace zm_sat_firefly_bear_attack_quest
    // Params 0
    // Checksum 0xb0113bac, Offset: 0x2be5
    // Size: 0x5d, Type: dev
    function function_1a807ce802e64642()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6a>" );
        devgui::add_devgui_func( "<dev string:x7a>", "<dev string:x85>", &debug_spawn_bear, 0 );
        devgui::add_devgui_func( "<dev string:x96>", "<dev string:xa7>", &clear_zone, 0 );
        devgui::add_devgui_func( "<dev string:xb8>", "<dev string:xc6>", &debug_start_timeout, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_firefly_bear_attack_quest
    // Params 0
    // Checksum 0x98772acd, Offset: 0x2c4a
    // Size: 0x78, Type: dev
    function debug_spawn_bear()
    {
        origin = devgui::function_97024c0a6d1256a6();
        
        if ( isdefined( origin ) )
        {
            player = level.players[ 0 ];
            
            if ( !isdefined( team ) )
            {
                team = "<dev string:xda>";
            }
            
            aitype = subclass_to_aitype_map::function_427ae77ce1056e01( "<dev string:xeb>", [ "<dev string:xff>" ] );
            var_c82c6d9cbe2d7ae4 = agent_manager::spawn_agent( aitype, origin );
        }
    }

    // Namespace zm_sat_firefly_bear_attack_quest
    // Params 0
    // Checksum 0x182f2a34, Offset: 0x2cca
    // Size: 0x6a, Type: dev
    function function_95d30d11e48221bb()
    {
        self notify( #"hash_3ff0ba4b9bf0dfe" );
        self endon( #"hash_3ff0ba4b9bf0dfe" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            color = ( 0, 1, 0 );
            sphere( self.origin, 15, color, 0 );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_bear_attack_quest
    // Params 0
    // Checksum 0x3b9e3e5d, Offset: 0x2d3c
    // Size: 0x12, Type: dev
    function debug_start_timeout()
    {
        level utility::flag_set( "<dev string:x122>" );
    }

#/
