// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_boss_fight.gsc  (hash_7ef53ef2a48b73fc.gscc) (size: 31488 Bytes / 0x7b00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e7b10af (1853558959)
// size ...... 31488 (0x7b00)
// includes .. 45  (offset: 0x7210)
// strings ... 122 (offset: 0x7378)
// dev strs .. 7   (offset: 0x7aac)
// exports ... 58  (offset: 0x47a4)
// cseg ...... 0x9a8 + 0x3dfc (0x47a4)
// imports ... 270 (offset: 0x50b4)
// animtree1 . 0   (offset: 0x7b00)
// animtree2 . 0   (offset: 0x7b00)
#using script_16ea1b94f0f381b3;
#using script_437ee0f94301721b;
#using script_4ca4034d0b68a7d4;
#using script_707daae07e6d6aa2;
#using scripts\anim\dialogue;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\script;
#using scripts\common\shellshock_utility;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\playerachievements;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_mq;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_boss_fight;

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x5
// Checksum 0x84ece41, Offset: 0x9c6
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_boss_fight", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x731645cc, Offset: 0x9f3
// Size: 0x94
function private pre_main()
{
    level.s_ruby_boss = { #var_be82617e5e8087bd:[] };
    level._effect[ "pillar_beam" ] = loadfxasset( "vfx_sat_levels_zm_ruby_boss_intro_pillar_beam" );
    callback::get_template( "zombie_uranus" ) callback::add( "on_ai_init", &function_48421ceb63765173 );
    callback::get_template( "zombie_neptune" ) callback::add( "on_ai_init", &function_8b7b1bf2b1eab1d8 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7d1b4b7b23fd890d", &function_ec6ec96f66b0dc71 );
    thread init_boss_fight_quest();
    init_game_over_scene();
    
    /#
        devgui_init();
    #/
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x4fd4d0ef, Offset: 0xa8f
// Size: 0x21d
function private post_main()
{
    level utility::flag_wait( "zm_sat_ruby_quest_boss_cs_completed" );
    var_cf5b011bc5592c76 = utility::getstructarray( "boss_mars_spawn", "targetname" );
    
    if ( var_cf5b011bc5592c76.size <= 0 )
    {
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4080.21, -40883.6, -12798.5 ), #targetname:"boss_mars_spawn" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4147.21, -40884.4, -12798.5 ), #targetname:"boss_mars_spawn" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4215.96, -40886.1, -12798.5 ), #targetname:"boss_mars_spawn" } );
        utility::addstruct( { #angles:( 0, 0, 0 ), #origin:( 4016.96, -40883.6, -12798.5 ), #targetname:"boss_mars_spawn" } );
    }
    
    var_141c1425428e9c20 = utility::getstructarray( "ruby_boss_neptune_spawn_pos", "targetname" );
    
    if ( var_141c1425428e9c20.size > 0 )
    {
        level.var_4cf3138664b652b6 = var_141c1425428e9c20[ 0 ];
    }
    
    if ( !level.var_4cf3138664b652b6 )
    {
        if ( !isdefined( level.var_4cf3138664b652b6 ) )
        {
            level.var_4cf3138664b652b6 = { #script_cs_flag:"zm_sat_ruby_quest_boss_cs", #name:"script_struct", #angles:( 0, 90, 0 ), #origin:( 4130, -41892, -12936 ), #targetname:"boss_mars_spawn" };
        }
    }
    
    level thread init_barrier();
    assert( isdefined( level.var_4cf3138664b652b6.origin ) && isdefined( level.var_4cf3138664b652b6.angles ) );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x3b93fa0e, Offset: 0xcb4
// Size: 0xf1
function init_barrier()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    level.entrance_clip = getent( "boss_entrance_clip", "targetname" );
    level.entrance_clip.mdl = utility::spawn_model( "tag_origin", level.entrance_clip.origin + ( 0, -20, -300 ), level.entrance_clip.angles + ( 0, 90, 0 ) );
    level.entrance_clip.sbl = spawnscriptable( "ruby_mars_entrance_barrier", level.entrance_clip.mdl.origin, level.entrance_clip.mdl.angles );
    set_entrance_barrier( 0 );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x759bb46c, Offset: 0xdad
// Size: 0x52
function init_boss_fight_quest()
{
    level utility::flag_wait( "zm_quest_initialized" );
    
    if ( getdvarint( @"scr_zm_ruby_boss_skipto", 0 ) )
    {
        level thread start_boss_fight();
    }
    
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"hash_22fdd0c3eb081084", &function_faa65c55f256000b );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x9088f457, Offset: 0xe07
// Size: 0x3e
function init_game_over_scene()
{
    level.neptune_game_over_scene = utility::getstructarray( "sat_cin_zm_vig_player_dth_neptune" )[ 0 ];
    
    if ( level.neptune_game_over_scene )
    {
        scene::add_scene_func( level.neptune_game_over_scene, &function_8854f7023073f1db, "callback_play" );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x2da985b2, Offset: 0xe4d
// Size: 0x11b
function function_8854f7023073f1db()
{
    level endon( #"game_ended" );
    boss = scene::get_entity( "neptune" );
    settings = level.zombie_neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    model = settings.var_8dd4e61c890f6cf6 ?? "c_sat_zmb_neptune_3";
    boss setmodel( model );
    boss utility::function_32b24db3127bff40( "eye", "on_3" );
    boss utility::function_32b24db3127bff40( "movement", "on_3" );
    zombie_neptune_metabones::function_bc9300a17f3a6e6e( level.zombie_neptune, boss, 3 );
    
    if ( isai( boss ) )
    {
        boss function_786bb6aa1b76c7ee( "disable_think", 1 );
    }
    
    var_ec5239099646d099 = getdvarint( @"hash_e6194c46ef879958", 1 );
    
    if ( var_ec5239099646d099 )
    {
        player = scene::get_entity( "Player 1" );
        
        if ( player )
        {
            wait 5;
            
            if ( player )
            {
                player playerhide();
            }
            
            wait 2.7;
            
            if ( player )
            {
                player playershow();
            }
        }
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x57bcc7e0, Offset: 0xf70
// Size: 0x10b
function function_48421ceb63765173( params )
{
    callback::add( #"hash_7d96b0fd9c6eff63", &function_8fb5cb13b65a1fed );
    callback::add( #"on_ai_killed", &function_4c3c58b0ad321dd0 );
    utility::registersharedfunc( #"zombie_uranus", #"hash_a06ba1d2c3f0c223", &function_f638dc0b6cb7687d );
    utility::registersharedfunc( #"zombie_uranus", #"hash_c57353fb61f49516", &function_e0abb2491e0b0ba );
    thread check_health_increase();
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( settings.meteormodel && !level.uranus_ambient )
    {
        level.uranus_ambient = utility::spawn_model( settings.meteormodel, self.origin, self.angles );
    }
    
    if ( level.uranus_ambient )
    {
        level.uranus_ambient utility::function_32b24db3127bff40( "debris", "on" );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xec45c38e, Offset: 0x1083
// Size: 0x6e
function function_8b7b1bf2b1eab1d8( params )
{
    callback::add( #"hash_b5e0b8a43edf3a0a", &function_1525877ffd149121 );
    callback::add( #"on_ai_killed", &on_neptune_killed );
    callback::add( #"hash_2f8220e252370c19", &function_d2431ec8aa1e7fd2 );
    callback::add( #"hash_a8c190693150f3fb", &function_f298e01af0de3d68 );
    thread check_health_increase();
    thread function_7f245b14d9828f0a();
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xf085602c, Offset: 0x10f9
// Size: 0x113
function private check_health_increase()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    threshold = getdvarfloat( @"hash_427987469908259f", 0.1 );
    
    if ( threshold <= 0 )
    {
        return;
    }
    
    if ( !isdefined( self.last_health ) )
    {
        self.last_health = self.health;
    }
    
    threshold = max( 0.1, threshold );
    
    while ( true )
    {
        diff = self.last_health - self.health;
        
        if ( diff < 0 && abs( diff ) / self.maxhealth > threshold )
        {
            script::function_2e2007575f92910d( self.agent_type + " Boss" + " unexpected health regen from " + self.last_health + " to " + self.health );
            self.health = self.last_health;
        }
        else if ( diff != 0 )
        {
            self.last_health = self.health;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xdc9c0d08, Offset: 0x1214
// Size: 0x3c0
function start_boss_fight( b_skip_uranus )
{
    self notify( #"hash_e85f85f57274be80" );
    self endon( #"hash_e85f85f57274be80" );
    level endon( #"game_ended" );
    utility::flag_set( "ruby_boss_fight_start" );
    
    foreach ( aether_zone in level.var_cc5333971c918a27 )
    {
        zone_manager::set_zone_enabled( aether_zone, 1 );
    }
    
    set_entrance_barrier( 1 );
    zm_fasttravel_core::function_298f7e021b71004( "portal_temple_b", 1, 1 );
    zm_sat_ruby::function_198c9c1c95647900( 1 );
    level thread zm_sat_ruby_quest_mq::function_cc977b5a019a1486();
    
    if ( !callback::exists( #"player_laststand", &vo_on_player_downed ) )
    {
        callback::add( #"player_laststand", &vo_on_player_downed );
    }
    
    if ( !callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::add( #"player_spawned", &on_player_spawned );
    }
    
    if ( !callback::exists( #"hash_7d450bcc4887da1e", &on_game_over ) )
    {
        level callback::add( #"hash_7d450bcc4887da1e", &on_game_over );
    }
    
    if ( getdvarint( @"scr_zm_ruby_boss_skipto", 0 ) || level.var_8bd966e8e0c1bbaa )
    {
        n_round = level.var_5b30c08562022091 ?? function_b80976b7930587b4();
        
        if ( zm_utility::get_round_number() != n_round )
        {
            level notify( #"restart_round" );
            zm_round_logic::function_68bdb49c82c0f892( n_round );
            zm_utility::function_1bd2eda42461fad1( n_round );
        }
        
        function_82d79b414f7830b0();
        waitframe();
    }
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    
    zm_round_spawning::pause_round_spawning( 1, "ruby_boss_fight_pause_spawning" );
    
    if ( !b_skip_uranus )
    {
        function_7820f770ed85e9be();
    }
    
    boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
    
    if ( !boss )
    {
        utility::callsharedfunc( #"zombie_uranus", #"hash_82cf0aa52d6d6117" );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_intro" );
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "sat_zm_ruby_boss", -1, 1 );
    }
    
    utility::callsharedfunc( #"zombie_uranus", #"hash_c381381c8d11497b" );
    wait 2;
    boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
    boss utility::callsharedfunc( #"zombie_uranus", #"hash_bb468dfe138a9a08" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.var_654073823a58b613 = &function_e5bc572edb237317;
    level.var_9075568a1189c7c9 = 1;
    
    if ( b_skip_uranus )
    {
        boss kill();
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        wait 3;
        thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"boss_1" );
        zm_quest::function_c2af37f835cd840b( zm_zombie_uranus_tower::get_charge_count( 1 ), 1, #"ruby_mq_guidance", #"boss_1" );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x56666f43, Offset: 0x15dc
// Size: 0x546
function function_7820f770ed85e9be()
{
    pillar_beams = [];
    pillar_beam_starts = [];
    central_vfx_pos = utility::getstruct( "ruby_boss_neptune_spawn_pos", "targetname" ).origin + ( 0, 0, 400 );
    var_618139f5f13fa334 = utility::getstruct( "ruby_boss_uranus_spawn_pos", "targetname" ).origin + ( 0, 0, 4000 );
    
    for ( i = 0; i < level.ruby_mq.var_e2f32ef1fd6fc6d3.size ; i++ )
    {
        pillar_beam_starts[ i ] = utility::spawn_model( "tag_origin", level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].origin );
    }
    
    wait 5;
    var_a612adb76c8fe11a = spawnscriptable( "ruby_uranus_summon", central_vfx_pos, vectortoangles( var_618139f5f13fa334 - central_vfx_pos ) );
    pillar_beam_end = utility::spawn_model( "tag_origin", central_vfx_pos );
    level.ruby_mq.var_e2f32ef1fd6fc6d3[ 0 ].sc_pillar_fx setscriptablepartstate( "boss_summon", "charging" );
    pillar_beams[ 0 ] = playfxontagsbetweenclients( level._effect[ "pillar_beam" ], pillar_beam_starts[ 0 ], "tag_origin", pillar_beam_end, "tag_origin" );
    level.ruby_mq.var_e2f32ef1fd6fc6d3[ 1 ].sc_pillar_fx setscriptablepartstate( "boss_summon", "charging" );
    pillar_beams[ 1 ] = playfxontagsbetweenclients( level._effect[ "pillar_beam" ], pillar_beam_starts[ 1 ], "tag_origin", pillar_beam_end, "tag_origin" );
    wait 1;
    level.ruby_mq.var_e2f32ef1fd6fc6d3[ 2 ].sc_pillar_fx setscriptablepartstate( "boss_summon", "charging" );
    pillar_beams[ 2 ] = playfxontagsbetweenclients( level._effect[ "pillar_beam" ], pillar_beam_starts[ 2 ], "tag_origin", pillar_beam_end, "tag_origin" );
    wait 1;
    level.ruby_mq.var_e2f32ef1fd6fc6d3[ 3 ].sc_pillar_fx setscriptablepartstate( "boss_summon", "charging" );
    pillar_beams[ 3 ] = playfxontagsbetweenclients( level._effect[ "pillar_beam" ], pillar_beam_starts[ 3 ], "tag_origin", pillar_beam_end, "tag_origin" );
    wait 1;
    level.ruby_mq.var_e2f32ef1fd6fc6d3[ 4 ].sc_pillar_fx setscriptablepartstate( "boss_summon", "charging" );
    pillar_beams[ 4 ] = playfxontagsbetweenclients( level._effect[ "pillar_beam" ], pillar_beam_starts[ 4 ], "tag_origin", pillar_beam_end, "tag_origin" );
    wait 2;
    
    for ( i = 0; i < level.ruby_mq.var_e2f32ef1fd6fc6d3.size ; i++ )
    {
        level.ruby_mq.var_e2f32ef1fd6fc6d3[ i ].sc_pillar_fx setscriptablepartstate( "boss_summon", "off" );
        pillar_beams[ i ] delete();
    }
    
    soundorigin = utility::getstruct( "step4_perfusion_mars_boss_interact", "targetname" );
    playsoundatpos( soundorigin.origin + ( 0, 0, 50 ), "evt_mq_pillar_symbol_all_play" );
    
    if ( isdefined( level.ruby_mq.var_e2f32ef1fd6fc6d3 ) )
    {
        foreach ( trigger in level.ruby_mq.var_e2f32ef1fd6fc6d3 )
        {
            if ( isdefined( trigger.sc_pillar_fx ) )
            {
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_1", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_2", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_3", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_4", "off" );
                trigger.sc_pillar_fx utility::function_7c10ea82c1e305b8( "trigger_5", "off" );
            }
        }
    }
    
    var_a612adb76c8fe11a setscriptablepartstate( "vfx", "beam" );
    activateworldevent( "we_vfx_boss_intro_buildup" );
    function_ad915db840c90fb3( 1023, 3, 1 );
    soundpos = ( 4085, -42615, -12458 );
    playsoundatpos( soundpos, #"hash_f3633e7c48055575" );
    wait 3;
    var_a612adb76c8fe11a freescriptable();
    wait 2;
    thread zm_utility::function_1d82e63812f9640a( central_vfx_pos, 2000, 6, "damage_heavy", 0.3 );
    playsoundatpos( soundpos, #"hash_7ff2af0509d6a8db" );
    wait 3;
    playsoundatpos( soundpos, #"hash_b3a35426ebb009e5" );
    deactivateworldevent( "we_vfx_boss_intro_buildup", 1 );
    activateworldevent( "we_vfx_boss_intro_spawn" );
    function_ad915db840c90fb3( 1023, 1, 4 );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xf78b504a, Offset: 0x1b2a
// Size: 0xdc
function private on_game_over( params )
{
    level callback::remove( #"hash_7d450bcc4887da1e", &on_game_over );
    
    if ( !utility::flag( "ruby_boss_fight_start" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    wait 4;
    
    if ( !isalive( level.zombie_neptune ) )
    {
        level dialogue::say( "dx_zm_rumb_5rbf_ssru_rm5spd" );
        return;
    }
    
    level dialogue::say( "dx_zm_rumb_5rbf_ssru_rm5rpd" );
}

// Namespace zm_sat_ruby_boss_fight
// Params 2
// Checksum 0xc42bd528, Offset: 0x1c0e
// Size: 0x90
function fade_screen( var_fe6eefcb57b80510, time )
{
    foreach ( player in level.players )
    {
        game_utility::fadetoblackforplayer( player, var_fe6eefcb57b80510, time );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x4cb7878c, Offset: 0x1ca6
// Size: 0x56
function on_player_spawned( params )
{
    if ( !utility::flag( "ruby_boss_fight_complete" ) )
    {
        arr_spawn_pos = utility::getstructarray( "boss_mars_spawn", "targetname" );
        start_struct = arr_spawn_pos[ self getentitynumber() ];
        
        if ( start_struct )
        {
            thread function_cd96995d9a559038( start_struct );
        }
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x637a6729, Offset: 0x1d04
// Size: 0x116
function function_8fb5cb13b65a1fed( params )
{
    boss = params.ent;
    phase = params.phase;
    
    if ( phase > 1 )
    {
        boss utility::callsharedfunc( #"zombie_uranus", #"hash_d5432c97d3e46ec7", 1 );
        wait 5;
        boss utility::callsharedfunc( #"zombie_uranus", #"hash_d5432c97d3e46ec7", 0 );
        boss utility::callsharedfunc( #"zombie_uranus", #"hash_bb468dfe138a9a08" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"boss_1" );
            zm_quest::function_c2af37f835cd840b( zm_zombie_uranus_tower::get_charge_count( phase ), 1, #"ruby_mq_guidance", #"boss_1" );
            zm_quest::function_9f49b2a045ece8ae( 0, 1, #"ruby_mq_guidance", #"boss_1" );
        }
    }
    
    if ( params.callback )
    {
        [[ params.callback ]]( {} );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xd3be0796, Offset: 0x1e22
// Size: 0x268
function function_4c3c58b0ad321dd0( params )
{
    level endon( #"game_ended" );
    utility::callsharedfunc( #"zombie_uranus", #"hash_567859af2c010066" );
    utility::callsharedfunc( #"zombie_uranus", #"hash_8488c9e136de573a" );
    thread function_f638dc0b6cb7687d();
    thread function_e0abb2491e0b0ba();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_bc952cb23607305" );
    level waittill( #"hash_9ff1c994a9593088", spawnpos );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_stage_1" );
    var_22f30f4d98ec7b99 = spawnscriptable( "scriptable_zombie_neptune_spawn", spawnpos, ( 0, 0, 1 ) );
    var_22f30f4d98ec7b99 utility::function_32b24db3127bff40( "spawn", "on" );
    
    /#
        if ( level.s_ruby_boss.var_79e1a9f832b78fb7 )
        {
            utility::callsharedfunc( #"zombie_uranus", #"hash_82cf0aa52d6d6117" );
            level.s_ruby_boss.var_79e1a9f832b78fb7 = 0;
            return;
        }
    #/
    
    wait 1.5;
    neptune_spawn_struct = level.var_4cf3138664b652b6;
    neptune = utility::callsharedfunc( #"zombie_neptune", #"hash_158570cc727fd014", spawnpos, neptune_spawn_struct.angles );
    neptune.ignoreall = 1;
    neptune.spawnpos = spawnpos;
    wait 2;
    level thread function_6b01801b08f66717();
    level thread function_c44556cd17a3323c( neptune );
    level thread function_d962effc1ef8402d();
    neptune.ignoreall = 0;
    thread zm_quest::update_guidance( undefined, #"ruby_mq_guidance", #"boss_3" );
    level.zombie_neptune = neptune;
    level.var_5813417cdbda6704 = throttle::throttle_initialize( "neptune_zombies", 1, level.framedurationseconds ?? 0.1 );
    level thread function_322281b557910b7b();
    utility::callsharedfunc( #"zombie_neptune", #"hash_ac8eb8136345157e" );
    utility::callsharedfunc( #"zm_laststand", #"hash_7f936b8cb61507e7", neptune.subclass );
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_player_dth_neptune";
    level.s_game_over_scene_override = utility::getstructarray( "sat_cin_zm_vig_player_dth_neptune" )[ 0 ];
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x96ae2858, Offset: 0x2092
// Size: 0x1bb
function private function_e0abb2491e0b0ba()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_8c90f14a1ea97909", 0 ) )
    {
        return;
    }
    
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    delay = getdvarfloat( @"hash_e8b80dd1895f1e7", settings.var_e2a6836aaa93aea8 );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    foreach ( player in level.players )
    {
        player thread zm_utility::white_screen_flash( 3, 1 );
    }
    
    wait 0.5;
    
    if ( level.uranus_ambient )
    {
        level.uranus_ambient utility::function_32b24db3127bff40( "debris", "off" );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.currentweapon ) && isdefined( player.currentprimaryweapon ) && !isnullweapon( player.currentweapon ) )
        {
            player forceplaygestureviewmodel( "t10_ges_streak_nuke_death" );
        }
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x7a1b3ef1, Offset: 0x2255
// Size: 0x2d7
function private function_f638dc0b6cb7687d()
{
    level endon( #"game_ended" );
    Uranus = self;
    origin = Uranus.origin;
    
    /#
        if ( isalive( self ) )
        {
            zombie_uranus_asm::death();
        }
    #/
    
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    delay = settings.var_899cc5d942b83631;
    
    /#
        delay = getdvarfloat( @"hash_83325ec81fcabab8", delay );
    #/
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    deathearthquake = settings.deathearthquake;
    center = level.var_4cf3138664b652b6.origin + ( 0, 0, 500 );
    earthquakeadvanced( deathearthquake.magnitudemax, deathearthquake.magnitudemid, deathearthquake.magnitudemin, deathearthquake.duration, center, deathearthquake.radiusmin, deathearthquake.radiusmid, deathearthquake.radiusmax );
    earthquake = settings.fireballearthquake;
    wait 1.5;
    meteorcount = settings.var_a31d785e89584f20;
    var_ee8b3c1e22698859 = randomintrange( int( meteorcount * 0.8 ), meteorcount );
    contents = trace::create_default_contents( 1 );
    randdist = 500;
    
    for ( i = 0; i < meteorcount ; i++ )
    {
        offset = ( randomfloatrange( randdist * -1, randdist ), randomfloatrange( randdist * -1, randdist ), randomfloatrange( randdist * -1, randdist ) );
        sourcepos = origin + offset;
        targetpos = level.var_4cf3138664b652b6.origin;
        
        if ( i == var_ee8b3c1e22698859 )
        {
            isneptune = 1;
        }
        else
        {
            targetpos += vectornormalize2( offset ) * randomfloatrange( 300, settings.var_88fc319c4d18ad5 );
            targetpos = utility::drop_to_ground( targetpos, 100, -500 );
            isneptune = 0;
        }
        
        dir = vectornormalize( targetpos - sourcepos );
        meteor = utility::spawn_model( settings.meteormodel, origin, vectortoangles( dir ) );
        meteor.isneptune = isneptune;
        duration = randomfloatrange( 7, 10 );
        result = trace::ray_trace( sourcepos, targetpos, self, contents );
        
        if ( result[ "fraction" ] < 1 )
        {
            targetpos = result[ "position" ];
        }
        
        meteor thread meteor_fall( sourcepos, targetpos, duration, earthquake );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 4, eflags: 0x4
// Checksum 0x4546c59c, Offset: 0x2534
// Size: 0x390
function private meteor_fall( sourcepos, targetpos, duration, earthquake )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    utility::function_32b24db3127bff40( "trail", "on" );
    dir = vectornormalize( targetpos - sourcepos );
    dir2 = vectornormalize2( dir );
    right = vectorcross( dir2, ( 0, 0, 1 ) );
    ctrlangle = 30;
    dircontrol = rotatepointaroundvector( right, dir, ctrlangle );
    distance2 = distance2d( targetpos, sourcepos );
    var_96e81673dd3580eb = sourcepos + dircontrol * distance2 * 0.5;
    thread utility::function_8001268940441423( sourcepos, targetpos, var_96e81673dd3580eb, duration, 0 );
    wait duration;
    utility::function_32b24db3127bff40( "trail", "off" );
    utility::function_32b24db3127bff40( "explosion", "on" );
    earthquakeadvanced( earthquake.magnitudemax, earthquake.magnitudemid, earthquake.magnitudemin, earthquake.duration, targetpos, earthquake.radiusmin, earthquake.radiusmid, earthquake.radiusmax );
    targets = getplayersandaiarrayinradius( targetpos, settings.var_e2ab98647ae64b55 );
    
    if ( utility::flag( "l_g_active" ) )
    {
        knockbackmag = settings.var_acfab589da173482;
        
        /#
            knockbackmag = getdvarfloat( @"hash_a8539db5d57b7105", knockbackmag );
        #/
    }
    else
    {
        knockbackmag = settings.var_f8c301dd10a294d5;
        
        /#
            knockbackmag = getdvarfloat( @"hash_d4b9485442b0b53b", knockbackmag );
        #/
    }
    
    knockback_cooldown = 500;
    
    foreach ( target in targets )
    {
        damage = settings.var_572dedac5b335be6;
        
        if ( isplayer( target ) )
        {
            if ( target.inlaststand )
            {
                continue;
            }
            
            /#
                damage = getdvarint( @"hash_996956f716d36d65", settings.var_572dedac5b335be6 );
            #/
            
            if ( damage >= target.health )
            {
                damage = target.health - 1;
            }
            
            if ( knockbackmag > 0 && ( !target.var_686063127f3de9af || gettime() > target.var_686063127f3de9af ) )
            {
                dir2 = vectornormalize2( target.origin - targetpos );
                right = vectorcross( dir2, ( 0, 0, 1 ) );
                dir = rotatepointaroundvector( right, dir2, 30 );
                target knockback( dir, knockbackmag, 1 );
                target.var_686063127f3de9af = gettime() + knockback_cooldown;
            }
        }
        
        if ( damage > 0 )
        {
            target dodamage( damage, targetpos, self, undefined, "MOD_EXPLOSIVE", undefined, targetpos );
        }
    }
    
    if ( self.isneptune )
    {
        level notify( #"hash_9ff1c994a9593088", targetpos );
    }
    
    wait 2;
    self delete();
}

// Namespace zm_sat_ruby_boss_fight
// Params 4
// Checksum 0x38ad73b, Offset: 0x28cc
// Size: 0xbf
function function_81bb9d06d0c4a338( center, minradius, maxradius, fixedangle )
{
    angle = fixedangle ?? randomfloat( 360 );
    distance = minradius < maxradius ? randomfloatrange( minradius, maxradius ) : maxradius;
    xoffset = distance * cos( angle );
    yoffset = distance * sin( angle );
    randpos = ( center[ 0 ] + xoffset, center[ 1 ] + yoffset, center[ 2 ] );
    position = getclosestpointonnavmesh( randpos );
    position = utility::drop_to_ground( position, 50, -300 );
    return position;
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x123d5afc, Offset: 0x2994
// Size: 0x2e
function function_d2431ec8aa1e7fd2( params )
{
    if ( randomint( 100 ) < 20 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_24d086146fc4011c" ] );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xcfc80a7e, Offset: 0x29ca
// Size: 0x2e
function function_f298e01af0de3d68( params )
{
    if ( randomint( 100 ) < 20 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_4000b97d1909e5a" ] );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x5ff141e3, Offset: 0x2a00
// Size: 0x187
function on_neptune_killed( params )
{
    if ( self != level.zombie_neptune )
    {
        return;
    }
    
    level thread function_15ade5ade9335125();
    waitframe();
    utility::callsharedfunc( #"zombie_neptune", #"hash_d8982ad6d42f3c36" );
    utility::callsharedfunc( #"zombie_neptune", #"hash_175433f148bd8ff3" );
    level notify( #"clear_high_round_gas" );
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_c41fa34081e4f0c0" ] );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_end" );
    
    foreach ( player in level.players )
    {
        player clearsoundsubmix( "sat_zm_ruby_boss" );
    }
    
    set_entrance_barrier( 0 );
    level utility::waittill_notify_or_timeout( "death_start_scene", 9 );
    callback::remove( #"player_laststand", &vo_on_player_downed );
    utility::flag_set( "ruby_boss_fight_complete" );
    utility::flag_clear( "ruby_boss_fight_start" );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level.var_654073823a58b613 = undefined;
    level.var_9075568a1189c7c9 = undefined;
    level.zombie_neptune = undefined;
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0xf9e8b56f, Offset: 0x2b8f
// Size: 0x2e0
function function_7f245b14d9828f0a()
{
    level endon( #"game_ended" );
    self waittill( #"death_transition", var_43ff4e66eade0a81 );
    self.nodamagenumbers = 1;
    self function_786bb6aa1b76c7ee( "neptune_disable_move", 1 );
    self function_786bb6aa1b76c7ee( "neptune_disable_melee", 1 );
    
    foreach ( value in self.behaviors )
    {
        value.cooldown_sec = 999999;
        value.var_5a4e1b29b5d9d41a = gettime();
    }
    
    hide_neptune();
    thread utility::callsharedfunc( #"zombie_neptune", #"hash_de07abc80a636fba" );
    
    foreach ( player in level.players )
    {
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
    }
    
    utility::waittill_notify_or_timeout( "transition_trails_done", 9 );
    show_neptune();
    
    if ( level.var_4cf3138664b652b6.angles[ 1 ] )
    {
        self orientmode( "face angle", level.var_4cf3138664b652b6.angles[ 1 ] );
    }
    
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "immune", 0 );
    utility::ent_flag_set( "kill_neptune" );
    wait 0.1;
    death_damage = self.health + 1;
    
    if ( isstruct( var_43ff4e66eade0a81 ) )
    {
        source = var_43ff4e66eade0a81.vpoint ?? self.origin;
        attacker = var_43ff4e66eade0a81.eattacker;
        inflictor = var_43ff4e66eade0a81.einflictor;
        mod = var_43ff4e66eade0a81.smeansofdeath;
        weapon = var_43ff4e66eade0a81.sweapon;
        hitloc = var_43ff4e66eade0a81.shitloc;
        flags = var_43ff4e66eade0a81.idflags;
        self dodamage( death_damage, source, attacker, inflictor, mod, weapon, hitloc, undefined, flags );
        return;
    }
    
    self dodamage( death_damage, self.origin );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0xcbcab4f5, Offset: 0x2e77
// Size: 0x5a
function hide_neptune()
{
    asm::function_7256f5ba459c840b( "idle_in" );
    self invisiblenotsolid();
    self hide();
    self hideallparts();
    zombie_neptune_metabones::function_c35ccbc3b1fbcab9();
    utility::function_32b24db3127bff40( "eye", "off" );
    utility::function_32b24db3127bff40( "movement", "off" );
    utility::function_32b24db3127bff40( "speed_boost", "off" );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0x55653b8a, Offset: 0x2ed9
// Size: 0xec
function show_neptune()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    models = [ self.model, settings.var_8dd4e71c890f6f29, settings.var_8dd4e61c890f6cf6 ];
    self setmodel( models[ self.n_fight_phase - 1 ] );
    neptune_spawn_struct = level.var_4cf3138664b652b6;
    self setorigin( neptune_spawn_struct.origin, 0 );
    self.angles = neptune_spawn_struct.angles;
    self visiblesolid();
    self show();
    self function_aa8ac009edde3f04();
    utility::function_32b24db3127bff40( "eye", "on_" + self.n_fight_phase );
    utility::function_32b24db3127bff40( "movement", "on_" + self.n_fight_phase );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x9271d493, Offset: 0x2fcd
// Size: 0x130
function change_healthbar( immune )
{
    var_47c35ddc0630df4 = self.maxhealth / 3;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_6f40a5ae8e5bd4ce = [ self.var_6f21c22a420f0038, settings.var_59ae47570a49763c, settings.var_59ae48570a49786f ];
    
    foreach ( player in level.players )
    {
        if ( player )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_show( var_6f40a5ae8e5bd4ce[ self.n_fight_phase - 1 ], self );
            player zombie_boss_healthbar::healthbar_set_health( var_47c35ddc0630df4, var_47c35ddc0630df4 );
            player.var_600fb1f95cfa7ecd = undefined;
            player zombie_boss_healthbar::function_db02000f515bd5c6( var_47c35ddc0630df4 );
            
            if ( immune )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_immune();
            }
        }
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0xea75c752, Offset: 0x3105
// Size: 0x3b
function increase_fight_phase()
{
    assert( self.n_fight_phase < 3 );
    self.n_fight_phase += 1;
    callback::callback( #"hash_696b6f168d1d9c5c" );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xc9c5de02, Offset: 0x3148
// Size: 0x3ff
function function_1525877ffd149121( params )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::callsharedfunc( #"zombie_neptune", #"hash_d8982ad6d42f3c36" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( self.n_fight_phase >= 2 )
    {
        self.melee_knockback_enabled = 1;
        self.var_5a9c952260ab1cf = 1;
        self.var_6c41e8e873b7594e = settings.meleedamage;
        self.var_c8cf90daee0f67a3 = settings.var_e5070b52534334ac;
        self.knockback_angle = settings.knockbackangle;
        self.var_8eed320b7873f7d6 = settings.var_6707cfb0acb9e092;
        self.var_2966c3d9ec29d388 = settings.var_402bd8e634cdb1bc;
    }
    
    musicevent = hashcat( #"hash_d7f4973314172c56", self.n_fight_phase );
    level musicbank_utility::function_5aca66c390aa347d( level.players, musicevent );
    self function_786bb6aa1b76c7ee( "immune", 1 );
    
    foreach ( player in level.players )
    {
        if ( player )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        }
    }
    
    utility::ent_flag_set( "zm_mod_health_regen_disable" );
    thread utility::callsharedfunc( #"zombie_neptune", #"hash_5bde7c89509f5672" );
    utility::waittill_any_in_array( [ "transition_explode_end", "special_pain_end" ] );
    increase_fight_phase();
    hide_neptune();
    wait settings.transitionwait;
    thread utility::callsharedfunc( #"zombie_neptune", #"hash_de07abc80a636fba" );
    utility::waittill_notify_or_timeout( "transition_trails_done", 9 );
    show_neptune();
    change_healthbar( 1 );
    utility::callsharedfunc( #"zombie_neptune", #"hash_eb8d89c8bd2c4362" );
    utility::function_32b24db3127bff40( "transition_hibernation", "on_" + self.n_fight_phase );
    utility::callsharedfunc( #"zombie_neptune", #"hash_42faa336e7782fac" );
    thread knockback_players();
    thread function_9f70e42031434a44();
    
    if ( self.n_fight_phase == 2 )
    {
        level thread function_84349ee0ba98242d();
    }
    else if ( self.n_fight_phase == 3 )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_866c8166a0559b07" ] );
        level thread spawn_blessing();
    }
    
    var_ad30c944bbd232d7 = 30;
    
    /#
        if ( level.var_658fb0b2495595d4 )
        {
            var_ad30c944bbd232d7 = level.var_658fb0b2495595d4;
        }
    #/
    
    wait var_ad30c944bbd232d7;
    utility::callsharedfunc( #"zombie_neptune", #"hash_cf482ff582551787" );
    utility::waittill_notify_or_timeout( "hibernation_breaking_off", 4 );
    utility::function_32b24db3127bff40( "transition_hibernation_out", "on_" + self.n_fight_phase );
    utility::waittill_notify_or_timeout( "neptune_hibernation_end", 4 );
    musicevent = hashcat( #"hash_66a034d9d7a7d92a", self.n_fight_phase );
    level musicbank_utility::function_5aca66c390aa347d( level.players, musicevent );
    utility::function_32b24db3127bff40( "transition_hibernation", "off" );
    utility::callsharedfunc( #"zombie_neptune", #"hash_4ad26c2e9c84ce0d" );
    self function_786bb6aa1b76c7ee( "immune", 0 );
    change_healthbar( 0 );
    utility::ent_flag_clear( "zm_mod_health_regen_disable" );
    self.var_d200801f77f0de0 = self.health;
    utility::callsharedfunc( #"zombie_neptune", #"hash_ac8eb8136345157e" );
    self.in_phase_transition = 0;
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x4e5e481d, Offset: 0x354f
// Size: 0x1c9
function private knockback_players()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"neptune_hibernation_end" );
    shockasset = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6246b6056559a60f;
    damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_38bf96003eaf2746;
    wait 0.5;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                if ( distance2dsquared( player.origin, self.origin ) > 62500 )
                {
                    continue;
                }
                
                if ( !isdefined( player.var_408f7c83c1370745 ) )
                {
                    player.var_408f7c83c1370745 = 0;
                }
                
                if ( gettime() - player.var_408f7c83c1370745 > 1000 )
                {
                    var_959e392b43754772 = player.origin - self.origin;
                    var_959e392b43754772 = ( var_959e392b43754772[ 0 ], var_959e392b43754772[ 1 ], 0 );
                    player shellshock_utility::_shellshock( shockasset, #"damage", 1.5 );
                    player knockback( var_959e392b43754772, 300, 1 );
                    player dodamage( damage, self.origin, self, self, "MOD_UNKNOWN" );
                    player.var_408f7c83c1370745 = gettime();
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xe66d115, Offset: 0x3720
// Size: 0x1ae
function private spawn_blessing()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !function_afdc3402f9f12a60() && !getdvarint( @"hash_f2661b0abc7dfb2c", 0 ) )
    {
        return;
    }
    
    var_7c06ccff26c8744e = utility::getstruct( "pedestal_spawn", "targetname" );
    wait 17;
    
    foreach ( player in level.players )
    {
        player thread zm_utility::white_screen_flash( 0.75, 0.5 );
        player playsoundtoplayer( "evt_mq_white_out", player );
    }
    
    level thread zm_quest::function_d5ef98341fd6a057( [ #"ruby_boss_neptune_powerup_spawn" ] );
    wait 1;
    spawnscriptable( "ruby_neptune_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
    wait 2;
    blessing = powerups::powerup_drop( "ruby_boss", var_7c06ccff26c8744e.origin + ( 0, 0, 200 ), -1 );
    blessing playsoundonmovingent( "evt_ruby_boss_neptune_powerup_spawn" );
    blessing.angles += ( 0, 180, 0 );
    blessing moveto( var_7c06ccff26c8744e.origin + ( 0, 0, 60 ), 1.8, 0, 1.8 );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x609a340a, Offset: 0x38d6
// Size: 0xb
function private function_afdc3402f9f12a60()
{
    return level.completed_firefly_mq;
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x8b06ad49, Offset: 0x38ea
// Size: 0x49
function on_player_connect( params )
{
    if ( !level.completed_firefly_mq )
    {
        standard_id = 54420;
        playerachievements::getstate( self, standard_id );
        directed_id = 63431;
        playerachievements::getstate( self, directed_id );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xb1071d30, Offset: 0x393b
// Size: 0x9f
function function_faa65c55f256000b( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( level.completed_firefly_mq )
    {
        return;
    }
    
    if ( params.achievementid == 54420 )
    {
        standard_complete = playerachievements::function_ce48098d17912e1f( self, 54420, "progress", 0 );
    }
    else if ( params.achievementid == 63431 )
    {
        directed_complete = playerachievements::function_ce48098d17912e1f( self, 63431, "progress", 0 );
    }
    
    if ( isplayer( self ) && ( standard_complete || directed_complete ) )
    {
        level.completed_firefly_mq = 1;
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0
// Checksum 0xf67c3bed, Offset: 0x39e2
// Size: 0x95
function function_15ade5ade9335125()
{
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"zm_sat_ruby_mq";
    params.is_main_quest = 1;
    params.var_be82617e5e8087bd = level.players;
    level callback::callback( #"zm_mq_quest_complete", params );
    params.event = #"zm_mq_quest_complete";
    level callback::callback( #"hash_6c71d319dc089c27", params );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xafd91d07, Offset: 0x3a7f
// Size: 0x2d
function private vo_on_player_downed( params )
{
    if ( utility::percent_chance( 50 ) )
    {
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_d7ecc8d394c065ce" ] );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xeac2c09b, Offset: 0x3ab4
// Size: 0x74
function private function_d962effc1ef8402d( params )
{
    level endon( #"game_ended" );
    var_62eb3c7975252f03 = function_1b9aca015902dbdf();
    wait 4;
    level zm_quest::function_d5ef98341fd6a057( [ #"hash_62a6d17ee49c4b8a" ] );
    
    if ( isdefined( var_62eb3c7975252f03 ) )
    {
        var_62eb3c7975252f03 zm_vo::function_8c1a12974bd11f01( #"hash_39ee4e9e2b9f8dc7" );
        return;
    }
    
    level zm_quest::function_d5ef98341fd6a057( [ #"hash_f396ca00e6ea0a71" ] );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x24b704a3, Offset: 0x3b30
// Size: 0x71
function private function_84349ee0ba98242d( params )
{
    level endon( #"game_ended" );
    var_62eb3c7975252f03 = function_1b9aca015902dbdf();
    level zm_quest::function_d5ef98341fd6a057( [ #"hash_877f81d1af9c721b" ] );
    
    if ( isdefined( var_62eb3c7975252f03 ) )
    {
        var_62eb3c7975252f03 zm_vo::function_8c1a12974bd11f01( #"hash_7aa99140c6fbbb3c" );
        return;
    }
    
    level zm_quest::function_d5ef98341fd6a057( [ #"hash_f652da896a30d26c" ] );
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x3e097737, Offset: 0x3ba9
// Size: 0xc5
function private function_1b9aca015902dbdf()
{
    var_52a111264f33ff56 = [];
    
    foreach ( player in level.players )
    {
        if ( player zm_vo::is_hero_operator() && zm_utility::is_player_valid_target( player ) && !player::isinlaststand( player ) )
        {
            var_52a111264f33ff56[ var_52a111264f33ff56.size ] = player;
        }
    }
    
    if ( var_52a111264f33ff56.size > 0 )
    {
        var_4efaf33c51758bd7 = utility::array_random( var_52a111264f33ff56 );
        return var_4efaf33c51758bd7;
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xdf11870, Offset: 0x3c76
// Size: 0xab
function set_entrance_barrier( should_set )
{
    if ( should_set )
    {
        level.entrance_clip solid();
        level.entrance_clip.mdl forcenetfieldhighlod( 1 );
        level.entrance_clip.sbl utility::function_32b24db3127bff40( "vfx", "on" );
        return;
    }
    
    level.entrance_clip notsolid();
    level.entrance_clip.mdl forcenetfieldhighlod( 0 );
    level.entrance_clip.sbl utility::function_32b24db3127bff40( "vfx", "off" );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xcab1d890, Offset: 0x3d29
// Size: 0xb8
function function_82d79b414f7830b0( param )
{
    zm_utility::open_sesame();
    zm_round_logic::function_895fdc21ab019efe();
    s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( "zone_temple" );
    
    foreach ( i, player in level.players )
    {
        player thread function_cd96995d9a559038( s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ i ] );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x366e6015, Offset: 0x3de9
// Size: 0x176
function function_cd96995d9a559038( var_e94b45e0030d64e4 )
{
    self endon( #"disconnect" );
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        thread playerlogic::spawnclient();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            utility::waittill_any_timeout( 5, "spawned_player" );
        }
    }
    
    if ( player::isinlaststand( self ) )
    {
        laststand::exit( "last_stand_revived", self );
    }
    
    if ( self == level.ruby_sq_echoes.active_player )
    {
        level callback::callback( "end_echoes_sq" );
    }
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        thread playerlogic::spawnclient();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            utility::waittill_any_timeout( 5, "spawned_player" );
        }
    }
    
    if ( isalive( self ) && self.sessionstate != "spectator" )
    {
        self dontinterpolate();
        self setorigin( var_e94b45e0030d64e4.origin );
        self setplayerangles( var_e94b45e0030d64e4.angles );
    }
    
    self.var_7ab4c9acb317c405 = var_e94b45e0030d64e4.origin;
    level.s_ruby_boss.var_be82617e5e8087bd = arraycombineunique( level.s_ruby_boss.var_be82617e5e8087bd, [ self ] );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x402f5b97, Offset: 0x3f67
// Size: 0x56
function function_ec6ec96f66b0dc71( params )
{
    function_2fbaac2680cfd365( params );
    
    if ( isarray( params ) && arraycontains( params, "neptune" ) )
    {
        thread start_boss_fight( 1 );
        return;
    }
    
    zm_sat_ruby_quest_mq::cleanup_step_13( 1 );
    level utility::flag_set( "ruby_boss_triggered" );
    thread start_boss_fight();
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x92afecee, Offset: 0x3fc5
// Size: 0x32
function function_1cf6e88bd2bce341( params )
{
    zm_sat_ruby_quest_mq::cleanup_step_13( 1 );
    level utility::flag_set( "ruby_boss_triggered" );
    function_2fbaac2680cfd365( params );
    thread start_boss_fight();
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0xefc0beb5, Offset: 0x3fff
// Size: 0x1e
function function_81d16042a00a2f86( params )
{
    function_2fbaac2680cfd365( params );
    thread start_boss_fight( 1 );
}

// Namespace zm_sat_ruby_boss_fight
// Params 1
// Checksum 0x2b1af0bf, Offset: 0x4025
// Size: 0x107
function function_2fbaac2680cfd365( params = [ "weapons", "round30" ] )
{
    if ( arraycontains( params, "weapons" ) )
    {
        level thread function_5f0a50b61f3da74c();
        params = arrayremove( params, "weapons" );
    }
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            n_round = int( removesubstr( param, "round" ) );
        }
    }
    
    zm_quest::set_max_round_cap();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        n_round = zm_round_logic::get_rb_round_cap();
    }
    
    level.var_5b30c08562022091 = n_round;
    level.var_8bd966e8e0c1bbaa = 1;
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb1445c96, Offset: 0x4134
// Size: 0x7b
function private function_5f0a50b61f3da74c()
{
    foreach ( player in level.players )
    {
        player thread function_e5292169f3b94171();
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0xc
// Checksum 0xd08872cc, Offset: 0x41b7
// Size: 0x303
function private function_e5292169f3b94171()
{
    self notify( #"hash_e19773f4151ac628" );
    self endon( #"hash_e19773f4151ac628" );
    player = self;
    player zombie_augments::function_eae5368ab01aaa9f();
    player zombie_augments::function_6dec499dd490fc54();
    player zombie_augments::function_ae34f860566cce0b( 1, 1 );
    
    if ( getdvarint( @"hash_348d280a97829389", 0 ) )
    {
        weapon_rarity = 3;
        n_power_level = 2;
    }
    else
    {
        weapon_rarity = 4;
        n_power_level = 3;
    }
    
    ammo_mods = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shadowvortex", "lightray" ];
    killstreaks = [ "zm_dinj", "death_machine_gun" ];
    super_power = utility::array_random( [ "super_aether_shroud" ] );
    thread perkpackage::perkpackage_givedebug( super_power );
    
    if ( laststand::function_7072b516e6cffb7c() == 0 )
    {
        player laststand::function_a2e03a85015b1897();
    }
    
    player zombie_perks::take_all_perks();
    player zombie_perks::give_perk( "specialty_juggernog" );
    player zombie_perks::give_perk( "specialty_quickrevive" );
    player zombie_perks::give_perk( "specialty_speedcola" );
    player zombie_perks::give_perk( "specialty_staminup" );
    player zombie_perks::give_perk( "specialty_elemental_pop" );
    player zombie_perks::give_perk( "specialty_phd_flopper" );
    player zombie_perks::give_perk( "specialty_death_perception" );
    player zombie_perks::give_perk( "specialty_deadshot" );
    player zombie_perks::give_perk( "specialty_m_mod" );
    player zombie_perks::give_perk( "specialty_d_mod" );
    player zombie_perks::give_perk( "specialty_w_mod" );
    player zombie_perks::give_perk( "specialty_z_mod" );
    player zombie_perks::give_perk( "specialty_vulture_aid" );
    player zm_armor::function_fdbe2cad6d8bb7e7( 3 );
    player armor::setarmorhealth( player.maxarmorhealth );
    player armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
    player currency::add_currency_amount( #"essence", 50000 );
    player killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    player thread zm::function_ac57ca8aaf8e8179();
    weapon = player function_cb38c050042391c5();
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, weapon_rarity );
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player ammo_mod::add_ammo_mod_to_weapon( weapon, utility::array_random( ammo_mods ) );
    
    if ( isarray( weapon ) && isweapon( weapon[ 1 ] ) )
    {
        weapon = weapon[ 1 ];
    }
    else
    {
        weapon = player function_cb38c050042391c5();
    }
    
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, weapon_rarity );
    player ammo_mod::add_ammo_mod_to_weapon( weapon, utility::array_random( ammo_mods ) );
    wait 5;
    
    for ( i = 0; i < 10 ; i++ )
    {
        player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xfb988897, Offset: 0x44c2
// Size: 0x35
function private function_cb38c050042391c5()
{
    self endon( #"disconnect" );
    currentweapon = self getcurrentweapon();
    
    while ( isnullweapon( currentweapon ) )
    {
        currentweapon = self getcurrentweapon();
        waitframe();
    }
    
    return currentweapon;
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xec687034, Offset: 0x4500
// Size: 0x26
function private function_6b01801b08f66717()
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        overlord::playevent( "zm_special_round_start_vo", level.players, undefined, 1 );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xa1917847, Offset: 0x452e
// Size: 0x31
function private function_c44556cd17a3323c( neptune )
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        zombie_uranus_toxic_mouth::function_d47f39c122c791fb( neptune, neptune.origin, "clear_high_round_gas" );
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 4, eflags: 0x4
// Checksum 0x41c6ec88, Offset: 0x4567
// Size: 0x4a
function private function_e5bc572edb237317( var_be866219ba036c6, var_77fc4ed806f5cac9, var_51c533560222849c, var_9e41dd30435985b7 )
{
    var_141c1425428e9c20 = utility::getstructarray( "ruby_boss_neptune_spawn_pos", "targetname" );
    return var_141c1425428e9c20[ self getentitynumber() ];
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb785a4ba, Offset: 0x45ba
// Size: 0x89
function private function_9f70e42031434a44()
{
    self endon( #"death" );
    self endon( #"neptune_hibernation_end" );
    neptune_spawn_struct = level.var_4cf3138664b652b6;
    hibernationstarttime = gettime();
    var_8c159cccb5a2746a = utility::function_4b74c15943231980( 30 );
    
    while ( true )
    {
        self forceteleport( neptune_spawn_struct.origin, neptune_spawn_struct.angles, 1000 );
        
        if ( gettime() - hibernationstarttime >= var_8c159cccb5a2746a )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1c56c43a, Offset: 0x464b
// Size: 0x40
function private function_b80976b7930587b4()
{
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_b397850099975023", 0 ) )
    {
        return 15;
    }
    
    if ( level.players.size == 1 )
    {
        return 25;
    }
    
    return 30;
}

// Namespace zm_sat_ruby_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb5a764de, Offset: 0x4693
// Size: 0xaf
function private function_322281b557910b7b()
{
    level.zombie_neptune endon( #"death" );
    var_5201119a03d17845 = getdvarfloat( @"hash_f5a9ddba5445d0b2", 250 );
    var_7aca0c778a72e3ef = level.var_4cf3138664b652b6.origin[ 2 ];
    
    while ( true )
    {
        if ( level.zombie_neptune.origin[ 2 ] - var_7aca0c778a72e3ef > var_5201119a03d17845 )
        {
            level.zombie_neptune forceteleport( level.var_4cf3138664b652b6.origin, level.var_4cf3138664b652b6.angles );
        }
        
        wait 2;
    }
}

/#

    // Namespace zm_sat_ruby_boss_fight
    // Params 0
    // Checksum 0xc14b39b0, Offset: 0x474a
    // Size: 0x5a, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x41>", "<dev string:x53>", &function_82d79b414f7830b0 );
        devgui::add_devgui_func( "<dev string:x69>", "<dev string:x92>", &function_1cf6e88bd2bce341 );
        devgui::add_devgui_func( "<dev string:xaa>", "<dev string:xd4>", &function_81d16042a00a2f86 );
        devgui::function_77df7fe7dd273e10();
    }

#/
