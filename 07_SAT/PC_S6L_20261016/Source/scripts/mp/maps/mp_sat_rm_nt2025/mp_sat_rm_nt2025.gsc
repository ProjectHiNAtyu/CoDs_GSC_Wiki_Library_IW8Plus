// scripts\mp\maps\mp_sat_rm_nt2025\mp_sat_rm_nt2025.gsc  (hash_5784604feb40e09f.gscc) (size: 7461 Bytes / 0x1d25 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc644df5f (3326402399)
// size ...... 7461 (0x1d25)
// includes .. 23  (offset: 0x1ab5)
// strings ... 30  (offset: 0x1b6d)
// dev strs .. 5   (offset: 0x1ce5)
// exports ... 20  (offset: 0xf21)
// cseg ...... 0x260 + 0xcc1 (0xf21)
// imports ... 74  (offset: 0x1241)
// animtree1 . 0   (offset: 0x1d25)
// animtree2 . 0   (offset: 0x1d25)
#using script_12a881b6c7ad6f5e;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\compass;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_rm_nt2025\gen\mp_sat_rm_nt2025_art;
#using scripts\mp\maps\mp_sat_rm_nt2025\mp_sat_rm_nt2025_fx;
#using scripts\mp\maps\mp_sat_rm_nt2025\mp_sat_rm_nt2025_lighting;

#namespace mp_sat_rm_nt2025;

// Namespace mp_sat_rm_nt2025
// Params 0
// Checksum 0x7d2c2f4b, Offset: 0x27e
// Size: 0x103
function main()
{
    mp_sat_rm_nt2025_art::main();
    mp_sat_rm_nt2025_fx::main();
    mp_sat_rm_nt2025_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_rm_nt2025" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"game_ended", &on_game_ended );
    callback::add( #"player_spawn_init", &on_spawn_init );
    function_431ffae9d97d6e98();
    level thread function_10cf0604d38868d2();
}

// Namespace mp_sat_rm_nt2025
// Params 1
// Checksum 0xf8d57ef5, Offset: 0x389
// Size: 0xc
function on_spawn_init( params )
{
    
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0x4
// Checksum 0x3f159833, Offset: 0x39d
// Size: 0x3b
function private on_game_ended( params )
{
    if ( level.var_a4851fe642803397 )
    {
        [[ utility::getsharedfunc( #"hash_bb64c53aee1652d8", #"hash_bb64c53aee1652d8" ) ]]( "sat_mp_nuketown_end", 6800 );
    }
}

/#

    // Namespace mp_sat_rm_nt2025
    // Params 0
    // Checksum 0xf556687c, Offset: 0x3e0
    // Size: 0x5, Type: dev
    function function_23dd2e4f33f2097b()
    {
        
    }

#/

// Namespace mp_sat_rm_nt2025
// Params 0
// Checksum 0x44054dc, Offset: 0x3ed
// Size: 0xb1
function function_10cf0604d38868d2()
{
    level endon( #"game_ended" );
    b_is_private_match = game_utility_mp::privatematch();
    var_60dc813d209798d4 = getdvarint( @"hash_368f1d610a4de2e7", 0 );
    
    /#
        b_is_private_match = 1;
    #/
    
    if ( !b_is_private_match || var_60dc813d209798d4 )
    {
        return;
    }
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"easteregg", &function_defedb64c78baa40 );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ee_emp", &debug_emp_blast );
    #/
    
    level waittill( #"mannequins_initialized" );
    level.n_heads_remaining = 28;
    scriptable::scriptable_addnotifycallback( "head_shot", &function_9e60c03a7d45ad10 );
    level thread function_5ad0be552e2d27a9();
    function_5b4105eae0ef5a92();
}

// Namespace mp_sat_rm_nt2025
// Params 6, eflags: 0x4
// Checksum 0x75941334, Offset: 0x4a6
// Size: 0xab
function private function_9e60c03a7d45ad10( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    level.n_heads_remaining--;
    var_6c6163353b11650e = 2;
    
    if ( level.n_heads_remaining == 0 )
    {
        level notify( #"hash_a705486324787fb7" );
        scriptable::function_65c9f35ffd4310f8( "head_shot", &function_9e60c03a7d45ad10 );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + level.n_heads_remaining + "<dev string:x30>" );
    #/
    
    wait var_6c6163353b11650e;
    level.var_dc54880b147638d5[ e_instance ] = undefined;
}

// Namespace mp_sat_rm_nt2025
// Params 0, eflags: 0x4
// Checksum 0xa45909d3, Offset: 0x559
// Size: 0xb4
function private function_5ad0be552e2d27a9()
{
    level endon( #"game_ended" );
    level endon( #"hash_a705486324787fb7" );
    
    if ( level.prematchperiodend > 0 )
    {
        level waittill( #"matchstarttimer_done" );
    }
    
    var_59e2c3c693d45fba = gettime();
    n_mannequin_time = 0;
    var_575af62f0df0ed85 = getdvarint( @"hash_3809fb9f40612a21", 120 );
    
    if ( var_575af62f0df0ed85 == -1 )
    {
        return;
    }
    
    while ( n_mannequin_time <= var_575af62f0df0ed85 * 1000 )
    {
        waitframe();
        n_mannequin_time = gettime() - var_59e2c3c693d45fba;
    }
    
    level notify( #"hash_76c3e699a3210f1b" );
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
    
    scriptable::function_65c9f35ffd4310f8( "head_shot", &function_9e60c03a7d45ad10 );
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0x4
// Checksum 0xc1f77e38, Offset: 0x615
// Size: 0x18
function private function_defedb64c78baa40( params )
{
    level notify( #"hash_a705486324787fb7" );
}

// Namespace mp_sat_rm_nt2025
// Params 0, eflags: 0x4
// Checksum 0x7a88944b, Offset: 0x635
// Size: 0x18a
function private function_5b4105eae0ef5a92()
{
    level endon( #"game_ended" );
    level endon( #"hash_76c3e699a3210f1b" );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"cradle", &function_a34505e7f7b33cf6 );
    #/
    
    level waittill( #"hash_a705486324787fb7" );
    level.var_ce0cc7271d4f6e45 = 1;
    
    /#
        iprintlnbold( "<dev string:x6b>" );
    #/
    
    audio_utility::snd_transient_load( "mp_sat_rm_nt2025_giant_manne" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"nuketown_ee" );
    emp_blast();
    var_e4cd6b131b647b4f = level.mapcenter;
    playsoundatpos( var_e4cd6b131b647b4f, "evt_airraid_siren" );
    var_9a83c033357b2842 = function_35d8f623767cc082();
    level thread function_5c095fea64b12675( var_9a83c033357b2842 );
    level.skipfinalkillcam = 1;
    level thread function_f81cf9c2ebd43641( 8.25 );
    wait 9;
    function_137210f385ea639b();
    earthquake( 0.3, 20, level.mapcenter, 2000 );
    wait 0.25;
    
    foreach ( e_player in level.players )
    {
        e_player kill();
    }
    
    level.disablespawning = 1;
    wait 1;
    level thread gamelogic_mp::forceend();
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0x4
// Checksum 0x31ff77d0, Offset: 0x7c7
// Size: 0x138
function private function_f81cf9c2ebd43641( delay )
{
    wait delay;
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"nuketown_ee" );
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( %"hash_8343ea1e18bb9ef" );
        player playsoundtoplayer( #"hash_bcdf09532dc6a2d3", player );
    }
    
    nuke::function_9d0bbd078749eaa9();
    wait 3;
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 0, 1 );
    }
}

// Namespace mp_sat_rm_nt2025
// Params 0, eflags: 0x4
// Checksum 0xee2e6d61, Offset: 0x907
// Size: 0x24f
function private emp_blast()
{
    s_streak_info = killstreak_utility::createstreakinfo( "emp_blast", undefined );
    var_5cc8815e64db8908 = level.mapcenter + ( 0, 0, 5000 );
    e_fx = spawn( "script_model", var_5cc8815e64db8908 );
    e_fx setmodel( "sat_killstreak_emp_blast_mp" );
    e_fx setscriptablepartstate( #"emp_air_explosion", #"on", 0 );
    
    foreach ( e_player in level.players )
    {
        function_c4e95ad9f1614b27( e_player );
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    s_obj_weapon = makeweapon( "sat_emp_blast_dmg_weapon_mp" );
    var_4e00ee8d01ee7fa3 = 33033;
    level.var_89fe7f9fa2bc945d = function_5713d46873b29625( level.var_89fe7f9fa2bc945d );
    var_459fe4d32b74cc10 = level.var_89fe7f9fa2bc945d;
    a_e_killstreaks = level.activekillstreaks;
    a_e_mines = weapon::function_3aafcaf7ff6dea9e();
    var_6311d76951452dfb = level.allsupportboxes;
    var_a4886dba1a474190 = [];
    var_a4886dba1a474190 = arraycombineunique( var_a4886dba1a474190, var_459fe4d32b74cc10, a_e_killstreaks, a_e_mines, var_6311d76951452dfb );
    
    foreach ( e_ent in var_a4886dba1a474190 )
    {
        if ( e_ent.isdestroyed )
        {
            continue;
        }
        
        if ( e_ent.var_c5ccf9dff3b5e393 )
        {
            e_ent [[ e_ent.var_c5ccf9dff3b5e393 ]]();
            continue;
        }
        
        e_ent dodamage( var_4e00ee8d01ee7fa3, e_ent.origin, undefined, undefined, "MOD_EXPLOSIVE", s_obj_weapon );
    }
}

// Namespace mp_sat_rm_nt2025
// Params 0, eflags: 0x4
// Checksum 0xc8ad1bb, Offset: 0xb5e
// Size: 0x14a
function private function_137210f385ea639b()
{
    s_bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_gas_grenade" );
    
    foreach ( e_player in level.players )
    {
        if ( s_bundle.var_1aadfb29005ffaa4 )
        {
            e_player thread gas_grenade::gas_applyblur();
            e_player thread gas_grenade::function_f45f8371a30fea6b( undefined );
            
            if ( gas_grenade::function_7a528b347ace56de() )
            {
                e_player thread gas_grenade::gas_startcoughing( undefined );
                continue;
            }
            
            e_player thread gas_grenade::gas_applycough( undefined, 0 );
        }
    }
    
    foreach ( e_player in level.players )
    {
        e_player setscriptablepartstate( #"gas_vfx", #"vfx_on", 1 );
    }
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0x4
// Checksum 0x946fe552, Offset: 0xcb0
// Size: 0x20
function private on_player_connect( params )
{
    if ( level.var_ce0cc7271d4f6e45 )
    {
        function_c4e95ad9f1614b27( self );
    }
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0x4
// Checksum 0x32c239b6, Offset: 0xcd8
// Size: 0x7f
function private function_c4e95ad9f1614b27( e_player )
{
    if ( e_player.var_9169e6e8e1b6fc53 )
    {
        e_player thread [[ e_player.var_9169e6e8e1b6fc53 ]]();
    }
    
    e_player.ksempd = 1;
    e_player val::set( "ksEMPBlast", "supers", 0 );
    e_player val::set( "ksEMPBlast", "killstreaks", 0 );
    e_player playsoundtoplayer( #"hash_e537c3a826c5a0ba", e_player );
    e_player emp_debuff::play_emp_scramble( 3, 1 );
}

// Namespace mp_sat_rm_nt2025
// Params 0, eflags: 0x4
// Checksum 0xdc79128a, Offset: 0xd5f
// Size: 0xb1
function private function_35d8f623767cc082()
{
    s_harper_scene = utility::getstruct( "scene_harper_boss", "targetname" );
    
    /#
        sceneoverride = getdvar( @"hash_c035d1b6b5706290", "<dev string:x80>" );
        
        if ( sceneoverride != "<dev string:x80>" )
        {
            s_harper_scene = structcopy( s_harper_scene );
            s_harper_scene.script_scenescriptbundle = sceneoverride;
        }
    #/
    
    var_d1e229c5b9da26b8[ "shot_010" ] = "shot_010";
    var_9a83c033357b2842 = spawnstruct();
    var_9a83c033357b2842.s_scene = s_harper_scene;
    var_9a83c033357b2842.s_action_queue = utility::queue_create();
    var_9a83c033357b2842.var_d1e229c5b9da26b8 = var_d1e229c5b9da26b8;
    return var_9a83c033357b2842;
}

// Namespace mp_sat_rm_nt2025
// Params 1, eflags: 0xc
// Checksum 0x4a614254, Offset: 0xe19
// Size: 0xbf
function private function_5c095fea64b12675( var_9a83c033357b2842 )
{
    self notify( #"hash_6e5501b67f2986cd" );
    self endon( #"hash_6e5501b67f2986cd" );
    level endon( #"game_over" );
    
    while ( true )
    {
        var_286cc7a2aaf7eed7 = utility::queue_isempty( var_9a83c033357b2842.s_action_queue );
        
        if ( var_286cc7a2aaf7eed7 )
        {
            utility::queue_enqueue( var_9a83c033357b2842.s_action_queue, "idle" );
        }
        
        var_10d0ec8539ca87f8 = utility::queue_peek( var_9a83c033357b2842.s_action_queue );
        utility::queue_dequeue( var_9a83c033357b2842.s_action_queue );
        var_9a83c033357b2842.s_scene scene::play( undefined, var_9a83c033357b2842.var_d1e229c5b9da26b8[ var_10d0ec8539ca87f8 ] );
    }
}

/#

    // Namespace mp_sat_rm_nt2025
    // Params 0
    // Checksum 0x4abc1fcb, Offset: 0xee0
    // Size: 0x5, Type: dev
    function function_4abbceed02953212()
    {
        
    }

    // Namespace mp_sat_rm_nt2025
    // Params 1, eflags: 0x4
    // Checksum 0xf3d74952, Offset: 0xeed
    // Size: 0x16, Type: dev
    function private debug_emp_blast( params )
    {
        emp_blast();
    }

    // Namespace mp_sat_rm_nt2025
    // Params 1, eflags: 0x4
    // Checksum 0x8a8c0a0d, Offset: 0xf0b
    // Size: 0x16, Type: dev
    function private function_a34505e7f7b33cf6( params )
    {
        function_137210f385ea639b();
    }

#/
