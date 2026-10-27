// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_uranus.gsc  (hash_751c03c9c17206ac.gscc) (size: 9012 Bytes / 0x2334 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x672b0cb4 (1730874548)
// size ...... 9012 (0x2334)
// includes .. 14  (offset: 0x2090)
// strings ... 20  (offset: 0x2100)
// dev strs .. 22  (offset: 0x222c)
// exports ... 22  (offset: 0x140c)
// cseg ...... 0x229 + 0x11e3 (0x140c)
// imports ... 78  (offset: 0x177c)
// animtree1 . 0   (offset: 0x2334)
// animtree2 . 0   (offset: 0x2334)
#using script_16ea1b94f0f381b3;
#using script_bdb08507b3b7b94;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_uranus;

// Namespace zm_sat_ruby_uranus
// Params 0, eflags: 0x5
// Checksum 0x8c31e559, Offset: 0x247
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_uranus", undefined, &pre_main, undefined );
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0x44c013da, Offset: 0x268
// Size: 0x292
function pre_main()
{
    /#
        devgui_init();
    #/
    
    var_4d79cafdf38ba43e = utility::getstructarray( "ruby_boss_uranus_tower_spawn_pos", "targetname" );
    
    if ( var_4d79cafdf38ba43e.size <= 0 )
    {
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 3220, -10020, 2048 ), #targetname:"ruby_boss_uranus_tower_spawn_pos" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 5033, -9976, 2048 ), #targetname:"ruby_boss_uranus_tower_spawn_pos" } );
    }
    
    var_859d6d5889881c3a = utility::getstructarray( "ruby_boss_uranus_toxic_fog_pos", "targetname" );
    
    if ( var_859d6d5889881c3a.size <= 0 )
    {
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 3582, -9969, 1860 ), #targetname:"ruby_boss_uranus_toxic_fog_pos" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 3563, -10740, 1860 ), #targetname:"ruby_boss_uranus_toxic_fog_pos" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4682, -10746, 1860 ), #targetname:"ruby_boss_uranus_toxic_fog_pos" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4620, -9964, 1860 ), #targetname:"ruby_boss_uranus_toxic_fog_pos" } );
    }
    
    utility::registersharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1", &get_uranus_boss );
    utility::registersharedfunc( #"zombie_uranus", #"hash_c381381c8d11497b", &start_spawn_zombies );
    utility::registersharedfunc( #"zombie_uranus", #"hash_1347e30f12e31225", &stop_spawn_zombies );
    utility::registersharedfunc( #"zombie_uranus", #"hash_8488c9e136de573a", &wipeout_zombies );
    utility::registersharedfunc( #"zombie_uranus", #"hash_82cf0aa52d6d6117", &setup_boss_uranus );
    utility::registersharedfunc( #"zombie_uranus", #"hash_5da8be93e88c8fb", &function_20d967cb20eb00b2 );
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0xc322cfbd, Offset: 0x502
// Size: 0x15
function get_uranus_boss()
{
    return level.boss_uranus.boss;
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0x272a960, Offset: 0x520
// Size: 0x50
function function_20d967cb20eb00b2()
{
    if ( !level.boss_uranus.fog_poses )
    {
        level.boss_uranus.fog_poses = utility::getstructarray( "ruby_boss_uranus_toxic_fog_pos", "targetname" );
    }
    
    return level.boss_uranus.fog_poses;
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0x16397e6b, Offset: 0x579
// Size: 0x30e
function setup_boss_uranus()
{
    level endon( #"game_ended" );
    var_7d4158f529bad641 = utility::getstructarray( "ruby_boss_uranus_spawn_pos", "targetname" );
    
    if ( var_7d4158f529bad641.size > 0 )
    {
        spawn_boss_struct = var_7d4158f529bad641[ 0 ];
        level.boss_uranus = spawnstruct();
        
        while ( true )
        {
            boss = utility::callsharedfunc( #"zombie_uranus", #"hash_f14721ab0299a7f7", spawn_boss_struct.origin, spawn_boss_struct.angles );
            
            if ( !boss )
            {
                zm_utility::function_71d7c0e7375ef487( 1, [ "normal" ] );
                waitframe();
                continue;
            }
            
            level.boss_uranus.boss = boss;
            break;
        }
        
        level.boss_uranus.zombie_kill_throttle = throttle::throttle_initialize( "uranus_zombies", 1, level.framedurationseconds ?? 0.1 );
    }
    else
    {
        assertmsg( "<dev string:x24>" + "<dev string:x54>" );
        return;
    }
    
    var_afee42d70fbda038 = getscriptablearray( "ruby_boss_uranus_tower_scriptable", #targetname );
    
    if ( var_afee42d70fbda038.size > 0 )
    {
        foreach ( tower in var_afee42d70fbda038 )
        {
            utility::callsharedfunc( #"zombie_uranus", #"hash_199a328db2c1dad8", tower );
        }
    }
    else
    {
        tower_struct_arr = utility::getstructarray( "ruby_boss_uranus_tower_spawn_pos", "targetname" );
        
        foreach ( towerstruct in tower_struct_arr )
        {
            utility::callsharedfunc( #"zombie_uranus", #"hash_371e97b7a78e876a", towerstruct.origin, towerstruct.angles );
        }
    }
    
    panel_struct_arr = utility::getstructarray( "ruby_boss_uranus_panel_interact", "targetname" );
    
    if ( panel_struct_arr.size > 0 )
    {
        var_971419554aa6e36c = panel_struct_arr[ 0 ];
        panel = utility::callsharedfunc( #"zombie_uranus", #"hash_8887c4db58a529ab", var_971419554aa6e36c.origin, var_971419554aa6e36c.angles );
        boss utility::callsharedfunc( #"zombie_uranus", #"hash_2daf129ccc22b321", panel.origin );
    }
    
    boss utility::callsharedfunc( #"zombie_uranus", #"hash_886d275d9bbb29e3", 1 );
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0x8f1d95f1, Offset: 0x88f
// Size: 0x1c
function start_spawn_zombies()
{
    level.boss_uranus.boss thread spawn_zombie_thread();
}

// Namespace zm_sat_ruby_uranus
// Params 0, eflags: 0xc
// Checksum 0x3ab9fe82, Offset: 0x8b3
// Size: 0x14b
function private spawn_zombie_thread()
{
    self notify( #"hash_3c2c0ef109d27641" );
    self endon( #"hash_3c2c0ef109d27641" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"stop_spawn_zombies" );
    
    if ( !isdefined( level.boss_uranus.zombies ) )
    {
        level.boss_uranus.zombies = [];
    }
    
    self.spawning_zombies = 1;
    
    while ( true )
    {
        phasesetting = get_phase_setting();
        var_53a926d2e9598d1f = get_zombie_spawn_max( phasesetting );
        
        if ( var_53a926d2e9598d1f > 0 && level.boss_uranus.zombies.size >= var_53a926d2e9598d1f )
        {
            wait 1;
            continue;
        }
        
        pos = utility::callsharedfunc( #"zombie_uranus", #"hash_fddaede65cd5e4f5" );
        function_fcc576ce75ae207c( pos );
        index = clamp( level.players.size - 1, 0, phasesetting.var_e9fe33047720af8f.size - 1 );
        interval = phasesetting.var_e9fe33047720af8f[ index ].var_8f17fcdb8088a8c6 ?? 1.5;
        wait interval;
    }
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0x5234346f, Offset: 0xa06
// Size: 0x85
function get_phase_setting()
{
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( !settings )
    {
        return;
    }
    
    index = clamp( level.boss_uranus.boss.phase - 1, 0, settings.phase_list.size - 1 );
    phasesetting = settings.phase_list[ index ];
    return phasesetting;
}

// Namespace zm_sat_ruby_uranus
// Params 1
// Checksum 0x5055b9d0, Offset: 0xa94
// Size: 0x56, Type: bool
function get_zombie_spawn_max( phasesetting = get_phase_setting() )
{
    if ( !phasesetting )
    {
        return false;
    }
    
    playercount = level.players.size;
    return phasesetting.var_e9fe33047720af8f[ playercount - 1 ].var_8e490e61485c47af ?? 0;
}

// Namespace zm_sat_ruby_uranus
// Params 1, eflags: 0x4
// Checksum 0x75f79170, Offset: 0xaf3
// Size: 0x4d
function private function_a37424fcd756e3e1( params )
{
    callback::remove( #"on_ai_killed", &function_a37424fcd756e3e1 );
    level.boss_uranus.zombies = arrayremove( level.boss_uranus.zombies, self );
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0xf415623e, Offset: 0xb48
// Size: 0x18
function stop_spawn_zombies()
{
    self.spawning_zombies = 0;
    self notify( #"stop_spawn_zombies" );
}

// Namespace zm_sat_ruby_uranus
// Params 1
// Checksum 0x17c5f28c, Offset: 0xb68
// Size: 0x2a5
function function_fcc576ce75ae207c( position )
{
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( !settings )
    {
        return;
    }
    
    phase = level.boss_uranus.boss.phase ?? 1;
    phasesetting = settings.phase_list[ phase - 1 ];
    
    if ( !phasesetting )
    {
        assertmsg( "<dev string:x6f>" + phase );
        return;
    }
    
    zone = zone_manager::function_90e5c3e2272b0130( position );
    
    if ( !zone )
    {
        return;
    }
    
    do
    {
        spawn = utility::random_weighted_struct( phasesetting.spawnlist );
        zombie_type = function_b3988325430ce242( spawn.aitype );
    }
    while ( zm_utility::function_205b7482cb035d0e( spawn.aitype ).size >= spawn.typemax );
    
    agent = zone_spawner::spawn_agent( zombie_type, { #zones:[ zone ] } );
    
    if ( !agent )
    {
        return;
    }
    
    agent.var_36a117d7034025b8 = 1;
    agent val::set( "ruby_boss", "ignore_cleanup", 1 );
    agent.no_powerups = 1;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( position );
    
    if ( phasesetting.var_ed7bf168779ce9e3 )
    {
        round_difficulty = max( phasesetting.var_ed7bf168779ce9e3, round_difficulty );
    }
    
    agent zombie_utils::set_zombie_round_difficulty( round_difficulty + phasesetting.var_29e98968a4c9c590 );
    
    if ( agent )
    {
        agent.var_825b17c932865df = 1;
        agent.var_15598d8e493afe88 = 1;
        agent.ignore_enemy_count = 1;
        agent.b_ignore_cleanup = 1;
        agent.var_e7095781f14d8c2d = 1;
        agent.var_50c96a5c56dab386 = &uranus_zombie_droplist;
        agent thread zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "ruby_boss", 40 );
        
        if ( spawn.var_790754450bafbc7a != "" && spawn.zombiescriptablepartstate != "" )
        {
            agent utility::function_32b24db3127bff40( spawn.var_790754450bafbc7a, spawn.zombiescriptablepartstate );
        }
        
        level.boss_uranus.zombies[ level.boss_uranus.zombies.size ] = agent;
        agent callback::add( #"on_ai_killed", &function_a37424fcd756e3e1 );
    }
    
    return agent;
}

// Namespace zm_sat_ruby_uranus
// Params 0, eflags: 0x4
// Checksum 0xf1866ac9, Offset: 0xe16
// Size: 0xb7
function private uranus_zombie_droplist()
{
    zombie_droplist = "zm_sat_ruby_boss_fight_item_list";
    attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
    var_55f94a869dd7e4d5 = isplayer( attacker ) && attacker armor::function_22290101992e4874() <= 1;
    
    if ( isstartstr( self.subclass, "zombie_base_armored" ) && var_55f94a869dd7e4d5 )
    {
        zombie_droplist = "zm_sat_ruby_boss_fight_armored_item_list";
    }
    
    zombie_droplist_params = { #droppos:self.origin, #dropquantity:1, #droplist:zombie_droplist };
    return zombie_droplist_params;
}

// Namespace zm_sat_ruby_uranus
// Params 0
// Checksum 0xe0f66297, Offset: 0xed6
// Size: 0x129
function wipeout_zombies()
{
    foreach ( zombie in getaiarrayinradius( level.var_4cf3138664b652b6.origin, 4000, "team_two_hundred" ) )
    {
        throttle::throttle_wait_in_queue( level.boss_uranus.zombie_kill_throttle, zombie );
        
        if ( isalive( zombie ) && zombie.subclass != "zombie_uranus" && zombie.subclass != "zombie_neptune" && zombie.subclass != "zombie_galileo" && zombie.subclass != "zombie_galileo_drone" )
        {
            zombie kill();
        }
    }
    
    if ( level.boss_uranus )
    {
        level.boss_uranus.zombies = [];
    }
}

/#

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0x87546ea9, Offset: 0x1007
    // Size: 0xdd, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x9f>" );
        devgui::add_devgui_func( "<dev string:xc3>", "<dev string:xce>", &setup_boss_uranus, undefined, 0 );
        devgui::add_devgui_func( "<dev string:xe0>", "<dev string:xf5>", &toggle_spawn_zombies, 1, 1 );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x118>", &function_67c8bed4a67e5c0a, 1, 2 );
        devgui::add_devgui_func( "<dev string:x126>", "<dev string:x136>", &wipeout_zombies, undefined, 3 );
        devgui::add_devgui_func( "<dev string:x146>", "<dev string:x155>", &function_4bfa49038520d452, undefined, 4 );
        devgui::add_devgui_func( "<dev string:x164>", "<dev string:x169>", &function_ba62043dc2423cc2, undefined, 5 );
        devgui::add_devgui_func( "<dev string:x175>", "<dev string:x189>", &function_4b18fdaf3c1ee952 );
        devgui::add_devgui_func( "<dev string:x1a8>", "<dev string:x1bf>", &function_19b4c34451bae88e, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0x23e63da1, Offset: 0x10ec
    // Size: 0x4e, Type: dev
    function toggle_spawn_zombies()
    {
        boss = level.boss_uranus.boss;
        
        if ( !boss )
        {
            return;
        }
        
        if ( boss.spawning_zombies )
        {
            boss stop_spawn_zombies();
            return;
        }
        
        boss start_spawn_zombies();
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0x59da949, Offset: 0x1142
    // Size: 0x92, Type: dev
    function function_67c8bed4a67e5c0a()
    {
        if ( level.boss_uranus.boss )
        {
            if ( level.boss_uranus.boss zombie_uranus::is_in_combat() )
            {
                level.boss_uranus.boss utility::callsharedfunc( #"zombie_uranus", #"hash_2bd94f81341013ca" );
                return;
            }
            
            level.boss_uranus.boss utility::callsharedfunc( #"zombie_uranus", #"hash_bb468dfe138a9a08" );
        }
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0x5f126dd8, Offset: 0x11dc
    // Size: 0x167, Type: dev
    function function_4bfa49038520d452()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( isdefined( boss ) )
        {
            settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
            phase = boss.phase + 1;
            
            if ( phase > settings.phase_list.size )
            {
                phase = 1;
            }
            
            boss.health = int( boss.maxhealth * ( 1 - ( phase - 1 ) * 0.333 ) );
            boss utility::callsharedfunc( #"zombie_uranus", #"hash_886d275d9bbb29e3", phase );
            
            foreach ( player in level.players )
            {
                player zombie_boss_healthbar::healthbar_set_health( boss.health, boss.maxhealth );
                player zombie_boss_healthbar::function_db02000f515bd5c6( boss.health );
            }
        }
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0xef6719b7, Offset: 0x134b
    // Size: 0x3f, Type: dev
    function function_ba62043dc2423cc2()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( boss && isalive( boss ) )
        {
            boss kill();
        }
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0xc238771b, Offset: 0x1392
    // Size: 0x58, Type: dev
    function function_4b18fdaf3c1ee952()
    {
        Uranus = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( Uranus )
        {
            level.s_ruby_boss.var_79e1a9f832b78fb7 = 1;
            Uranus kill();
            return;
        }
        
        iprintlnbold( "<dev string:x1d6>" );
    }

    // Namespace zm_sat_ruby_uranus
    // Params 0
    // Checksum 0xd90abde0, Offset: 0x13f2
    // Size: 0x1a, Type: dev
    function function_19b4c34451bae88e()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1ed>", @"hash_8c90f14a1ea97909" );
    }

#/
