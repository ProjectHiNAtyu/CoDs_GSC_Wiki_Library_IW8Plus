// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_neptune.gsc  (hash_53ebd7d51f4790db.gscc) (size: 3945 Bytes / 0xf69 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x187d3624 (410859044)
// size ...... 3945 (0xf69)
// includes .. 10  (offset: 0xea9)
// strings ... 8   (offset: 0xef9)
// dev strs .. 0   (offset: 0xf69)
// exports ... 12  (offset: 0x941)
// cseg ...... 0x106 + 0x83b (0x941)
// imports ... 31  (offset: 0xb21)
// animtree1 . 0   (offset: 0xf69)
// animtree2 . 0   (offset: 0xf69)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_neptune;

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0x5
// Checksum 0x1ba38ae3, Offset: 0x124
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_neptune", undefined, undefined, &post_main );
}

// Namespace zm_sat_ruby_neptune
// Params 0
// Checksum 0x352a9590, Offset: 0x145
// Size: 0x98
function post_main()
{
    utility::registersharedfunc( #"zombie_neptune", #"hash_ac8eb8136345157e", &start_spawn_zombies );
    utility::registersharedfunc( #"zombie_neptune", #"hash_42faa336e7782fac", &function_d7095fd0c1b75d1c );
    utility::registersharedfunc( #"zombie_neptune", #"hash_4ad26c2e9c84ce0d", &function_31955b8c6a69313d );
    utility::registersharedfunc( #"zombie_neptune", #"hash_d8982ad6d42f3c36", &stop_spawn_zombies );
    utility::registersharedfunc( #"zombie_neptune", #"hash_175433f148bd8ff3", &wipeout_zombies );
}

// Namespace zm_sat_ruby_neptune
// Params 0
// Checksum 0x67b93b07, Offset: 0x1e5
// Size: 0x36
function start_spawn_zombies()
{
    /#
        setdvarifuninitialized( @"hash_104da41f6b6b190f", 0 );
        
        if ( getdvarint( @"hash_104da41f6b6b190f", 0 ) )
        {
            return;
        }
    #/
    
    level.zombie_neptune thread spawn_zombie_thread();
}

// Namespace zm_sat_ruby_neptune
// Params 0
// Checksum 0x59e1a693, Offset: 0x223
// Size: 0x36
function function_d7095fd0c1b75d1c()
{
    /#
        setdvarifuninitialized( @"hash_104da41f6b6b190f", 0 );
        
        if ( getdvarint( @"hash_104da41f6b6b190f", 0 ) )
        {
            return;
        }
    #/
    
    level.zombie_neptune thread function_17ade4af1ae9fa08();
}

// Namespace zm_sat_ruby_neptune
// Params 0
// Checksum 0xe1e2727a, Offset: 0x261
// Size: 0x18
function function_31955b8c6a69313d()
{
    self.guardian_fight = 0;
    self notify( #"hash_1ffbd53c0ae24df0" );
}

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0xc
// Checksum 0x467b5fe6, Offset: 0x281
// Size: 0x1b2
function private spawn_zombie_thread()
{
    self notify( #"hash_e44649a500c5b1d9" );
    self endon( #"hash_e44649a500c5b1d9" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"stop_spawn_zombies" );
    
    if ( !isdefined( level.zombie_neptune.zombies ) )
    {
        level.zombie_neptune.zombies = [];
    }
    
    if ( !isdefined( level.zombie_neptune.n_fight_phase ) )
    {
        level.zombie_neptune.n_fight_phase = 1;
    }
    
    self.spawning_zombies = 1;
    neptune_aisettings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    arena_center = level.var_4cf3138664b652b6.origin ?? self.origin;
    
    while ( true )
    {
        zombie_settings = neptune_aisettings.phases[ level.zombie_neptune.n_fight_phase - 1 ].var_e9fe33047720af8f[ level.players.size - 1 ];
        
        if ( !isdefined( zombie_settings ) )
        {
            return;
        }
        
        var_f99653cb971f7164 = getaiarrayinradius( arena_center, 2000, "team_two_hundred" ).size;
        
        if ( zombie_settings.var_8e490e61485c47af > var_f99653cb971f7164 )
        {
            function_fcc576ce75ae207c( neptune_aisettings.phases[ level.zombie_neptune.n_fight_phase - 1 ].spawnlist );
        }
        
        wait zombie_settings.var_8f17fcdb8088a8c6 ?? 3;
    }
}

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0xc
// Checksum 0x1db7f007, Offset: 0x43b
// Size: 0x186
function private function_17ade4af1ae9fa08()
{
    self notify( #"hash_948450d9d90781e4" );
    self endon( #"hash_948450d9d90781e4" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_1ffbd53c0ae24df0" );
    
    if ( !isdefined( level.zombie_neptune.zombies ) )
    {
        level.zombie_neptune.zombies = [];
    }
    
    self.guardian_fight = 1;
    neptune_aisettings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    arena_center = level.var_4cf3138664b652b6.origin ?? self.origin;
    
    while ( true )
    {
        zombie_settings = neptune_aisettings.var_409389bb200ba165[ level.zombie_neptune.n_fight_phase - 2 ].var_e9fe33047720af8f[ level.players.size - 1 ];
        
        if ( !isdefined( zombie_settings ) )
        {
            return;
        }
        
        var_f99653cb971f7164 = getaiarrayinradius( arena_center, 2000, "team_two_hundred" ).size;
        
        if ( zombie_settings.var_8e490e61485c47af > var_f99653cb971f7164 )
        {
            function_fcc576ce75ae207c( neptune_aisettings.var_409389bb200ba165[ level.zombie_neptune.n_fight_phase - 2 ].spawnlist );
        }
        
        wait zombie_settings.var_8f17fcdb8088a8c6 ?? 3;
    }
}

// Namespace zm_sat_ruby_neptune
// Params 1, eflags: 0x4
// Checksum 0x45b62053, Offset: 0x5c9
// Size: 0x1a9
function private function_fcc576ce75ae207c( spawnlist )
{
    if ( !spawnlist )
    {
        return;
    }
    
    zone = zone_manager::function_90e5c3e2272b0130( level.zombie_neptune.origin );
    
    do
    {
        spawn = utility::random_weighted_struct( spawnlist );
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
    agent zombie_utils::set_zombie_round_difficulty( zm_round_logic::get_rb_round_number() );
    
    if ( agent )
    {
        agent.var_825b17c932865df = 1;
        agent.var_15598d8e493afe88 = 1;
        agent.ignore_enemy_count = 1;
        agent.b_ignore_cleanup = 1;
        agent.var_e7095781f14d8c2d = 1;
        agent.var_50c96a5c56dab386 = &neptune_zombie_droplist;
        agent thread zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "ruby_boss", 40 );
        
        if ( spawn.var_790754450bafbc7a != "" && spawn.zombiescriptablepartstate != "" )
        {
            agent utility::function_32b24db3127bff40( spawn.var_790754450bafbc7a, spawn.zombiescriptablepartstate );
        }
    }
    
    return agent;
}

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0x4
// Checksum 0xc90b0ed3, Offset: 0x77b
// Size: 0xb7
function private neptune_zombie_droplist()
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

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0x4
// Checksum 0xa0962653, Offset: 0x83b
// Size: 0x18
function private stop_spawn_zombies()
{
    self.spawning_zombies = 0;
    self notify( #"stop_spawn_zombies" );
}

// Namespace zm_sat_ruby_neptune
// Params 0, eflags: 0x4
// Checksum 0x2b2f46fd, Offset: 0x85b
// Size: 0xe6
function private wipeout_zombies()
{
    center = level.var_4cf3138664b652b6.origin ?? level.zombie_neptune.origin;
    
    if ( !center )
    {
        return;
    }
    
    foreach ( zombie in getaiarrayinradius( center, 4000, "team_two_hundred" ) )
    {
        if ( isdefined( level.var_5813417cdbda6704 ) )
        {
            throttle::throttle_wait_in_queue( level.var_5813417cdbda6704, zombie );
        }
        
        if ( zombie != level.zombie_neptune )
        {
            zombie kill();
        }
    }
}

