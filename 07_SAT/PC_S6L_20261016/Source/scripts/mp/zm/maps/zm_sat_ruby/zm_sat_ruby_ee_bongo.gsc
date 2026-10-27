// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_bongo.gsc  (hash_3371aa142c17e024.gscc) (size: 14751 Bytes / 0x399f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1bb0310b (464531723)
// size ...... 14751 (0x399f)
// includes .. 19  (offset: 0x35ff)
// strings ... 48  (offset: 0x3697)
// dev strs .. 2   (offset: 0x3987)
// exports ... 30  (offset: 0x210f)
// cseg ...... 0x3d7 + 0x1d38 (0x210f)
// imports ... 134 (offset: 0x25bf)
// animtree1 . 0   (offset: 0x399f)
// animtree2 . 0   (offset: 0x399f)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\loot\common_item;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_bongo_cs;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_ee_bongo;

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x5
// Checksum 0xe3aabc7e, Offset: 0x3f5
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_ee_bongo", #"zm_quest", &function_8c571c0988acfa8f, &function_3cd6ca42ef9901ac );
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x1a2b82f4, Offset: 0x422
// Size: 0xf2
function private function_8c571c0988acfa8f()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    weapons::registerusedcallback( "decoy_trinket", &decoy_trinket_used );
    level.ruby_ee_bongo = zm_quest::get_quest( #"ruby_ee_bongo" );
    level.ruby_ee_bongo.vfx_loot_consume = loadfxasset( "vfx_sat_gameplay_zm_ai_shade_consume_item_blue" );
    zm_quest::register_quest_step( #"ruby_ee_bongo", #"feed_bongo", &setup_bongo, &complete_bongo );
    zm_quest::register_quest_step( #"ruby_ee_bongo", #"hash_15d0bf5adbc9441f", &function_a29fb69d7cac3414 );
    zm_quest::register_quest_step( #"ruby_ee_bongo", #"hash_15d0c05adbc945d2", &function_a29fb99d7cac3aad );
    zm_quest::register_quest_step( #"ruby_ee_bongo", #"hash_15d0c15adbc94785", &function_a29fb89d7cac387a );
    zm_sat_ruby_ee_bongo_cs::main();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x564492f8, Offset: 0x51c
// Size: 0x56
function private function_3cd6ca42ef9901ac()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level callback::add( #"ruby_monkey_brain_dropped", &function_f1ac4932a912195a );
    level thread zm_quest::start_quest( #"ruby_ee_bongo" );
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x44438c6a, Offset: 0x57a
// Size: 0x46
function private setup_bongo( b_skipped, b_save_restored )
{
    level utility::flag_wait( "begin_round_logic" );
    level callback::add( "on_zombie_ai_killed", &function_fd1590f2abaac98b );
    level callback::add( "oscar_trap_success", &function_fd1590f2abaac98b );
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x90ff0f2f, Offset: 0x5c8
// Size: 0x78
function private complete_bongo( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        var_c50f749e8cfd5137 = zm_quest::function_73720cdf21c3cfd7( #"ruby_ee_bongo", #"ruby_ee_bongo_death" );
        
        if ( var_c50f749e8cfd5137 )
        {
            level callback::remove( "on_zombie_ai_killed", &function_fd1590f2abaac98b );
            level callback::remove( "oscar_trap_success", &function_fd1590f2abaac98b );
            return;
        }
    }
    
    level thread function_568901a073a2fc45( b_skipped || b_save_restored );
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x4afe53e2, Offset: 0x648
// Size: 0x6a
function private function_568901a073a2fc45( b_skipped )
{
    level utility::flag_wait( "initial_player_spawned" );
    
    if ( b_skipped && !level.ruby_ee_bongo.ai_bongo )
    {
        level.ruby_ee_bongo.ai_bongo = function_a837e85a522ba45c();
    }
    
    level.ruby_ee_bongo.ai_bongo thread function_3c6372d6a7d285a9();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x269ce308, Offset: 0x6ba
// Size: 0x28
function private function_a29fb69d7cac3414( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    function_5fe4e64e4b33b303();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x317241e5, Offset: 0x6ea
// Size: 0x50
function private function_a29fb99d7cac3aad( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_3e8340d7adccc1ad( level.ruby_ee_bongo.ai_bongo );
    level waittill( #"on_round_end" );
    function_5fe4e64e4b33b303();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x46757173, Offset: 0x742
// Size: 0x50
function private function_a29fb89d7cac387a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level thread function_3e8340d7adccc1ad( level.ruby_ee_bongo.ai_bongo );
    level waittill( #"on_round_end" );
    function_5fe4e64e4b33b303();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0xd15c54cf, Offset: 0x79a
// Size: 0x294
function private function_3c6372d6a7d285a9()
{
    self endon( #"death" );
    self unlink();
    val::reset_all( "ruby_ee_bongo" );
    var_1fb3065670f8e51 = function_2088b0bf21ccbfe1();
    zombie_utils::function_c2cee1190760989c( var_1fb3065670f8e51 );
    self setsafeguardent( var_1fb3065670f8e51 );
    self setsafeguardrange( 512 );
    level utility::flag_set( "bongo_follows" );
    level notify( #"highvis_reload_outline", var_1fb3065670f8e51.team ?? "allies", [ self ] );
    level callback::add( "using_healing_aura", &heal_bongo );
    callback::add( "on_zombie_ai_damaged", &function_8d83ee969b3b551 );
    callback::add( "on_zombie_ai_killed", &function_753d74aafb5f154e );
    
    if ( self.attractor.source )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        self.attractor.source.origin = var_1fb3065670f8e51.origin;
        self.attractor.source.team = level.var_ece703e3d116381c;
        function_6c9f1a7bffece67f( self.attractor.source.origin, 6400 );
        
        if ( var_1fb3065670f8e51 )
        {
            var_1fb3065670f8e51 playsoundtoplayer( "evt_ee_complete_success_stinger", var_1fb3065670f8e51 );
        }
        
        do_bongo_dance();
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
        self.attractor = undefined;
    }
    
    thread function_3ef4f82a63504acf();
    
    while ( true )
    {
        wait 15;
        
        if ( self.attractor || self.attractor_trinket )
        {
            continue;
        }
        
        if ( isalive( self.enemy ) && !issubstr( self.enemy.subclass, "galileo" ) )
        {
            continue;
        }
        
        if ( !var_1fb3065670f8e51 )
        {
            var_1fb3065670f8e51 = function_2088b0bf21ccbfe1();
        }
        
        self setsafeguardent( var_1fb3065670f8e51 );
        self setsafeguardrange( 512 );
        
        if ( distancesquared( self.origin, var_1fb3065670f8e51.origin ) < 1000000 )
        {
            continue;
        }
        
        s_attractor = spawnstruct();
        s_attractor.origin = var_1fb3065670f8e51.origin;
        self.attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 98, undefined, undefined, undefined, undefined, undefined, level.var_ece703e3d116381c );
        function_6c9f1a7bffece67f( var_1fb3065670f8e51, 6400 );
        wait 1;
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
        self.attractor = undefined;
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x5f822cdd, Offset: 0xa36
// Size: 0xeb, Type: bool
function private function_2088b0bf21ccbfe1()
{
    var_a3681dd2dec74e57 = 0;
    
    foreach ( player in level.players )
    {
        if ( player.var_b70ae82d0884cf2a && player.var_b70ae82d0884cf2a > var_a3681dd2dec74e57 )
        {
            var_1fb3065670f8e51 = player;
            var_a3681dd2dec74e57 = player.var_b70ae82d0884cf2a;
        }
    }
    
    if ( !var_1fb3065670f8e51 )
    {
        var_1fb3065670f8e51 = utility::get_array_of_closest( self.origin, level.players, undefined, 1 )[ 0 ];
    }
    
    return var_1fb3065670f8e51 ?? level.players[ 0 ];
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0xba1da333, Offset: 0xb2a
// Size: 0x280
function private function_f1ac4932a912195a( params )
{
    level callback::remove( #"ruby_monkey_brain_dropped", &function_f1ac4932a912195a );
    
    if ( level utility::flag( "bongo_follows" ) && !level.ruby_ee_bongo.ai_bongo )
    {
        return;
    }
    
    wait 1;
    level utility::flag_wait( "bongo_follows" );
    scr_brain = params.scriptable;
    trigger = spawn( "noent_volume_trigger_radius", scr_brain.origin, 0, 512, 64 );
    
    while ( scr_brain && level.ruby_ee_bongo.ai_bongo )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent != level.ruby_ee_bongo.ai_bongo )
        {
            continue;
        }
        
        if ( level.ruby_ee_bongo.ai_bongo.health == level.ruby_ee_bongo.ai_bongo.maxhealth )
        {
            continue;
        }
        
        while ( self.attractor || self.attractor_trinket )
        {
            wait 1;
        }
        
        break;
    }
    
    level utility::flag_set( "ruby_ee_brn_etn" );
    scr_brain.e_mover = utility::spawn_model( "tag_origin", scr_brain.origin, scr_brain.angles );
    scr_brain scriptablesetparententity( scr_brain.e_mover );
    s_attractor = spawnstruct();
    s_attractor.origin = scr_brain.origin;
    level.ruby_ee_bongo.ai_bongo.attractor = level.ruby_ee_bongo.ai_bongo zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 100, undefined, undefined, undefined, undefined, undefined, level.var_ece703e3d116381c );
    level.ruby_ee_bongo.ai_bongo function_3571d72f4c4b3c70( scr_brain, 9999 );
    level thread heal_bongo();
    scr_brain freescriptable();
    level.ruby_ee_bongo.ai_bongo do_bongo_dance();
    wait 1;
    level.ruby_ee_bongo.ai_bongo zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor );
    level utility::flag_clear( "ruby_ee_brn_etn" );
    trigger delete();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x670c59f, Offset: 0xdb2
// Size: 0x104
function private function_3ef4f82a63504acf()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"new_trinket", trinket );
        
        if ( !level utility::flag( "ruby_ee_brn_etn" ) )
        {
            self notify( #"hash_8b9b5ac69c0e0048" );
        }
        
        /#
            iprintlnbold( "<dev string:x35>" );
        #/
        
        s_attractor = spawnstruct();
        s_attractor.origin = trinket.origin;
        self.attractor_trinket = zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 99, undefined, undefined, undefined, undefined, undefined, level.var_ece703e3d116381c );
        val::set( "bongo_chases", "ignore_ai_collision", 1 );
        function_6c9f1a7bffece67f( s_attractor.origin );
        val::set( "bongo_chases", "ignore_ai_collision", 0 );
        
        if ( trinket )
        {
            thread function_a939faf4b148dbf( trinket );
            do_bongo_dance();
        }
        
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor_trinket );
        self.attractor_trinket = undefined;
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x571e7189, Offset: 0xebe
// Size: 0x138
function private function_a939faf4b148dbf( trinket )
{
    e_mover = utility::spawn_model( "tag_origin", trinket.origin, trinket.angles );
    
    if ( !trinket )
    {
        e_mover delete();
        return;
    }
    
    trinket scriptablesetparententity( e_mover );
    e_mover rotateto( ( 0, 0, 0 ), 0.666 );
    e_mover moveto( e_mover.origin + ( 0, 0, -4 ), 0.666 );
    e_mover waittill( #"rotatedone" );
    e_mover vibrate( ( 0, 1, 0 ), 2, 1, 7 );
    
    if ( isalive( self ) )
    {
        utility::waittill_any_timeout( 7, "death" );
    }
    
    e_mover vibrate( ( 0, 0, 0 ), 1, 1, 1 );
    e_mover rotateto( ( -90, 0, 0 ), 0.2 );
    e_mover moveto( e_mover.origin + ( 0, 0, 4 ), 0.2 );
    e_mover waittill( #"rotatedone" );
    e_mover delete();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x11d01ce3, Offset: 0xffe
// Size: 0xc6
function private heal_bongo( params )
{
    if ( !isalive( level.ruby_ee_bongo.ai_bongo ) )
    {
        return;
    }
    
    level.ruby_ee_bongo.ai_bongo setscriptablepartstate( "healing_aura_fx", "super_fx_on", 0 );
    level.ruby_ee_bongo.ai_bongo.health = level.ruby_ee_bongo.ai_bongo.maxhealth;
    wait 1;
    
    if ( isalive( level.ruby_ee_bongo.ai_bongo ) )
    {
        level.ruby_ee_bongo.ai_bongo setscriptablepartstate( "healing_aura_fx", "super_fx_off", 0 );
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0xe1b8fbe2, Offset: 0x10cc
// Size: 0x148
function private function_8d83ee969b3b551( params )
{
    if ( params.idamage > 100 )
    {
        self.health += int( params.idamage );
        self.health -= 100;
        zm_quest::function_4eefe6de31f5ddab( #"ruby_ee_bongo", #"ruby_ee_bongo_health", self.health );
    }
    else
    {
        zm_quest::function_4eefe6de31f5ddab( #"ruby_ee_bongo", #"ruby_ee_bongo_health", self.health - params.idamage );
    }
    
    if ( !params.eattacker || !params.eattacker val::get( "ignoreme" ) )
    {
        return;
    }
    
    var_9032ebed1df79c81 = zm_round_spawning::get_round_enemies();
    
    if ( var_9032ebed1df79c81 && var_9032ebed1df79c81.size < 3 )
    {
        self endon( #"death" );
        val::set( "bongo_last_zombie", "ignoreme", 1 );
        val::set( "bongo_last_zombie", "ignore_ai_collision", 1 );
        params.eattacker waittill( #"death" );
        val::reset_all( "bongo_last_zombie" );
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x2e0f754f, Offset: 0x121c
// Size: 0x76
function private function_753d74aafb5f154e( params )
{
    zm_quest::function_4eefe6de31f5ddab( #"ruby_ee_bongo", #"ruby_ee_bongo_death", 1 );
    zm_quest::function_6265be8d0549e1b1( #"ruby_ee_bongo", #"ruby_ee_bongo_health" );
    level callback::remove( "on_zombie_ai_killed", &function_fd1590f2abaac98b );
    level callback::remove( "oscar_trap_success", &function_fd1590f2abaac98b );
    level callback::remove( "using_healing_aura", &heal_bongo );
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x435fee53, Offset: 0x129a
// Size: 0x6f
function private do_bongo_dance()
{
    self endon( #"death" );
    self.scenedata = undefined;
    self.script_scenescriptbundle = "zm_sat_ruby_ee_bongo_dance";
    thread scene::play( self );
    self waittill( #"escape_attach_cymbals" );
    self setscriptablepartstate( "loot_consume_escape_special", "cymbals" );
    self waittill( #"stop_dance" );
    self setscriptablepartstate( "loot_consume_escape_special", "off" );
    scene::stop();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0xb0b2726a, Offset: 0x1311
// Size: 0x229
function private function_a837e85a522ba45c()
{
    s_spawn = get_bongo_spawn_point();
    ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_shade", [ "stam_zm_sat_ruby_bongo" ] );
    
    do
    {
        waitframe();
        ai_bongo = agent_manager::spawn_agent( ai_type, s_spawn.origin, s_spawn.angles, level.var_ece703e3d116381c );
    }
    while ( !ai_bongo );
    
    ai_bongo.b_ignore_cleanup = 1;
    ai_bongo.b_cleanup_no_respawn = 1;
    ai_bongo.var_825b17c932865df = 1;
    ai_bongo.var_15598d8e493afe88 = 1;
    ai_bongo.ignore_enemy_count = 1;
    ai_bongo.var_a13bed1ac47e1b2c = 1;
    ai_bongo.b_ignore_death_perception = 1;
    ai_bongo.var_3807d4363cfee498 = 1;
    ai_bongo.var_c966b63c8a2e3877 = 1;
    ai_bongo.var_7ee152b43c7188e1 = 1;
    ai_bongo.team = "neutral";
    ai_bongo.maxhealth = 11500;
    ai_bongo.health = 11500;
    ai_bongo val::set( "ruby_ee_bongo", "ignoreme", 1 );
    ai_bongo val::set( "ruby_ee_bongo", "ignoreall", 1 );
    ai_bongo val::set( "ruby_ee_bongo", "death", 0 );
    ai_bongo val::set( "ruby_ee_bongo", "show_healthbar", 0 );
    ai_bongo val::set( "ruby_ee_bongo", "allow_brot", 0 );
    ai_bongo setscriptablepartstate( "eyes", "brainrot_eyes" );
    ai_bongo disableaimassist();
    s_attractor = structcopy( s_spawn );
    ai_bongo.attractor = ai_bongo zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor, 99 );
    ai_bongo.v_escape = utility::getstruct( s_spawn.target ).origin;
    var_f93a08c86c2cd513 = zm_quest::function_73720cdf21c3cfd7( #"ruby_ee_bongo", #"ruby_ee_bongo_health" );
    
    if ( var_f93a08c86c2cd513 )
    {
        ai_bongo.health = var_f93a08c86c2cd513;
    }
    
    return ai_bongo;
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0xf8086ce3, Offset: 0x1543
// Size: 0x10a
function private get_bongo_spawn_point()
{
    a_spawns = utility::getstructarray( "ruby_ee_bongo" );
    
    while ( true )
    {
        s_spawn = utility::array_random( a_spawns );
        
        if ( s_spawn == level.ruby_ee_bongo.s_last_spawn )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( player zm_utility::is_player_facing( s_spawn.origin, 1024 ) )
            {
                b_reroll = 1;
                break;
            }
        }
        
        if ( b_reroll )
        {
            b_reroll = undefined;
            waitframe();
            continue;
        }
        
        level.ruby_ee_bongo.s_last_spawn = s_spawn;
        return s_spawn;
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0xb2c14457, Offset: 0x1655
// Size: 0xa0
function private function_3e8340d7adccc1ad( ai_bongo )
{
    if ( !isalive( ai_bongo ) )
    {
        return;
    }
    
    level.ruby_ee_bongo.ai_bongo = undefined;
    ai_bongo.attractor.source.origin = ai_bongo.v_escape;
    ai_bongo function_6c9f1a7bffece67f( ai_bongo.v_escape );
    ai_bongo val::set( "ruby_ee_bongo", "death", 1 );
    ai_bongo zombie_attractor_manager::function_dcfb4c31f1d97cd2( ai_bongo.attractor );
    ai_bongo invisiblenotsolid();
    ai_bongo kill();
}

/#

    // Namespace zm_sat_ruby_ee_bongo
    // Params 1, eflags: 0x4
    // Checksum 0xa1ef1a3a, Offset: 0x16fd
    // Size: 0x3d, Type: dev
    function private debug_draw_bongo( bongo )
    {
        while ( isalive( bongo ) )
        {
            utility::draw_circle( bongo.origin, 32, ( 0, 1, 1 ) );
            waitframe();
        }
    }

#/

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0x8e0b3a51, Offset: 0x1742
// Size: 0x219
function private function_5fe4e64e4b33b303()
{
    level.ruby_ee_bongo.ai_bongo = function_a837e85a522ba45c();
    e_linker = utility::spawn_model( "tag_origin", level.ruby_ee_bongo.ai_bongo.origin, level.ruby_ee_bongo.ai_bongo.angles );
    
    while ( level.ruby_ee_bongo.ai_bongo )
    {
        level.ruby_ee_bongo.ai_bongo linkto( e_linker );
        level.ruby_ee_bongo.ai_bongo thread zm_utility::function_4c161e50ce2233e6( [ "damage", "bongo_happy", "death" ] );
        results = level.ruby_ee_bongo.ai_bongo utility::waittill_any_return_params( "damage", "bongo_happy" );
        level.ruby_ee_bongo.ai_bongo unlink();
        
        if ( results[ "message" ] == "bongo_happy" )
        {
            var_b465fdb07bf6f6a1 = results[ 0 ];
            level.ruby_ee_bongo.ai_bongo function_3571d72f4c4b3c70( var_b465fdb07bf6f6a1 );
            break;
        }
        
        level.ruby_ee_bongo.ai_bongo playsoundonmovingent( "vox_ai_shade_jump_onto_vehicle" );
        level thread function_3e8340d7adccc1ad( level.ruby_ee_bongo.ai_bongo );
        level waittill( #"on_round_end" );
        level.ruby_ee_bongo.ai_bongo = function_a837e85a522ba45c();
        e_linker dontinterpolate();
        e_linker.origin = level.ruby_ee_bongo.ai_bongo.origin;
        e_linker.angles = level.ruby_ee_bongo.ai_bongo.angles;
    }
    
    e_linker delete();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 2, eflags: 0x4
// Checksum 0x57a934e, Offset: 0x1963
// Size: 0x21e
function private function_3571d72f4c4b3c70( var_b465fdb07bf6f6a1, n_timeout = 5000 )
{
    var_44616205278e62f2 = var_b465fdb07bf6f6a1.origin + vectornormalize( self.origin - var_b465fdb07bf6f6a1.origin ) * 12;
    self.attractor.source.origin = var_44616205278e62f2;
    
    /#
        debugstar( var_44616205278e62f2, ( 1, 0, 0 ), 99 );
    #/
    
    function_6c9f1a7bffece67f( var_44616205278e62f2, 1024, n_timeout );
    wait 0.5;
    var_b465fdb07bf6f6a1.e_mover vibrate( ( 1, 1, 1 ), 2, 0.7, 10 );
    
    if ( isalive( self ) )
    {
        v_move = getclosestpointonnavmesh( self gettagorigin( "tag_fx_loot" ) );
        
        if ( v_move )
        {
            var_b465fdb07bf6f6a1.e_mover moveto( v_move + ( 0, 0, 3 ), 1, 0.9 );
        }
        
        if ( isent( var_b465fdb07bf6f6a1 ) )
        {
            playfxontag( level.ruby_ee_bongo.vfx_loot_consume, var_b465fdb07bf6f6a1, "tag_origin" );
        }
        
        self setscriptablepartstate( "loot_consume", "consume" );
        self.script_scenescriptbundle = "zm_sat_ruby_ee_bongo_consume";
        scene::play( self );
        
        if ( isalive( self ) )
        {
            self setscriptablepartstate( "loot_consume", "off" );
        }
        
        if ( isent( var_b465fdb07bf6f6a1 ) )
        {
            stopfxontag( level.ruby_ee_bongo.vfx_loot_consume, var_b465fdb07bf6f6a1, "tag_origin" );
        }
    }
    
    if ( var_b465fdb07bf6f6a1.owner.var_b70ae82d0884cf2a )
    {
        var_b465fdb07bf6f6a1.owner.var_b70ae82d0884cf2a++;
    }
    else if ( var_b465fdb07bf6f6a1.owner )
    {
        var_b465fdb07bf6f6a1.owner.var_b70ae82d0884cf2a = 1;
    }
    
    var_b465fdb07bf6f6a1.e_mover delete();
    
    if ( isent( var_b465fdb07bf6f6a1 ) )
    {
        var_b465fdb07bf6f6a1 thread utility::delete_after_delay( 0.1 );
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 3, eflags: 0x4
// Checksum 0xd49b77dd, Offset: 0x1b89
// Size: 0xcc
function private function_6c9f1a7bffece67f( v_dest_or_ent, n_dist_sqrd = 1024, n_timeout = 9999 )
{
    self endon( #"hash_8b9b5ac69c0e0048" );
    self function_e8726d980fa12944();
    n_max_wait = gettime() + n_timeout;
    
    while ( isalive( self ) && distance2dsquared( self.origin, function_7ac3f256f3f35057( v_dest_or_ent ) ) > n_dist_sqrd )
    {
        wait 0.5;
        
        if ( gettime() > n_max_wait )
        {
            break;
        }
        
        if ( !v_dest_or_ent || isplayer( v_dest_or_ent ) && !isalive( v_dest_or_ent ) )
        {
            v_dest_or_ent = function_2088b0bf21ccbfe1();
        }
    }
    
    while ( zombie_traverse::is_traversing() )
    {
        wait 0.5;
    }
    
    self visiblesolid();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x936a4a76, Offset: 0x1c5d
// Size: 0x23
function private function_7ac3f256f3f35057( vec_or_ent )
{
    if ( isent( vec_or_ent ) )
    {
        return vec_or_ent.origin;
    }
    
    return vec_or_ent;
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x6c7de2e2, Offset: 0x1c89
// Size: 0x2ab
function private decoy_trinket_used( grenade )
{
    grenade endon( #"death" );
    grenade waittill( #"missile_stuck", stuckto );
    grenade.e_mover = utility::spawn_model( "tag_origin", grenade.origin, grenade.angles );
    
    if ( !grenade )
    {
        grenade.e_mover delete();
        return;
    }
    
    grenade linkto( grenade.e_mover );
    grenade.e_mover moveto( ( round( grenade.origin[ 0 ] ), round( grenade.origin[ 1 ] ), round( grenade.origin[ 2 ] ) + 3 ), 0.25 );
    
    if ( grenade.angles[ 0 ] < 90 )
    {
        var_79141f687771bba6 = -90;
    }
    else
    {
        var_79141f687771bba6 = 270;
    }
    
    grenade.e_mover rotateto( ( var_79141f687771bba6, grenade.angles[ 1 ], 0 ), 0.2, 0.19 );
    wait 0.25;
    var_8c4fe62d01999d1e = grenade zone_manager::get_current_zone();
    
    if ( level.ruby_ee_bongo.ai_bongo )
    {
        if ( !var_8c4fe62d01999d1e || level utility::flag( "bongo_follows" ) )
        {
            a_ai = getaiarrayinradius( grenade.origin, 256 );
            
            foreach ( ai in a_ai )
            {
                if ( ai == level.ruby_ee_bongo.ai_bongo )
                {
                    if ( !level utility::flag( "bongo_follows" ) && !ai trace::ray_trace_passed( ai geteye(), grenade.origin + ( 0, 0, 5 ), ai ) )
                    {
                        break;
                    }
                    
                    bongo = ai;
                    bongo notify( #"bongo_happy", grenade );
                    break;
                }
            }
        }
    }
    
    if ( !bongo || level utility::flag( "bongo_follows" ) )
    {
        grenade.e_mover delete();
        
        if ( var_8c4fe62d01999d1e )
        {
            grenade function_b10b4fb97162fe9b();
            return;
        }
        
        grenade thread utility::delete_after_delay( 15 );
    }
}

// Namespace zm_sat_ruby_ee_bongo
// Params 0, eflags: 0x4
// Checksum 0xebc5328e, Offset: 0x1f3c
// Size: 0x12d
function private function_b10b4fb97162fe9b()
{
    spawnoptions = common_item::function_bc5ff2958b71a708( self.origin, self.angles );
    spawnoptions.var_8d4f327170228364 = 1;
    spawnoptions.baseorigin = self.origin;
    spawnoptions.overrideorigin = self.origin;
    spawnoptions.var_5c41ec8e64770998 = self.origin;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.var_9b09286183ced731 = 1;
    spawnoptions.var_23d3495c57d61bdf = 1;
    spawnoptions.var_b8402e625c429a31 = 1;
    spawnoptions.var_18608bd8660b3a19 = 0;
    spawnoptions.var_f35b5b18b029c493 = 0;
    itembundle = getscriptbundle( %"hash_4533c64507f62d7d" );
    item = common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
    
    if ( level.ruby_ee_bongo.ai_bongo )
    {
        level.ruby_ee_bongo.ai_bongo notify( #"new_trinket", item );
    }
    
    self delete();
}

// Namespace zm_sat_ruby_ee_bongo
// Params 1, eflags: 0x4
// Checksum 0x6a346ffa, Offset: 0x2071
// Size: 0x9e
function private function_fd1590f2abaac98b( params )
{
    if ( isai( params.oscar ) )
    {
        ai = params.oscar;
    }
    else
    {
        if ( !issubstr( self.subclass, "zombie_galileo" ) )
        {
            return;
        }
        
        if ( issubstr( self.subclass, "drone" ) )
        {
            return;
        }
        
        ai = self;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( ai );
    itembundle = getscriptbundle( %"hash_4533c64507f62d7d" );
    common_item::function_61c2c0251e742ffd( itembundle, 1, spawnoptions );
}

