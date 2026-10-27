// scripts\mp\zm\ztron\ztron_outro.gsc  (hash_14ae13c86290fd3f.gscc) (size: 24381 Bytes / 0x5f3d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbb09fc13 (3137993747)
// size ...... 24381 (0x5f3d)
// includes .. 19  (offset: 0x5785)
// strings ... 91  (offset: 0x581d)
// dev strs .. 0   (offset: 0x5db9)
// exports ... 30  (offset: 0x4221)
// cseg ...... 0x91a + 0x3907 (0x4221)
// imports ... 123 (offset: 0x46d1)
// animtree1 . 1   (offset: 0x5db9)
// animtree2 . 21  (offset: 0x5dd1)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weapon;
#using scripts\mp\zm\ztron\ztron_weather;
#using scripts\mp\zm\ztron\ztron_world_event;

#namespace ztron_outro;

// Namespace ztron_outro
// Params 0
// Checksum 0x71798771, Offset: 0x938
// Size: 0x201
function init()
{
    level.var_a3bf8eb31b920fc1 = {};
    level.var_a3bf8eb31b920fc1.playerspots = utility::getstructarray( "podium_playerpos" );
    level.var_a3bf8eb31b920fc1.zspots = utility::getstructarray( "podium_zombie_spot" );
    level.var_a3bf8eb31b920fc1.props = utility::getstructarray( "podium_prop" );
    level.var_a3bf8eb31b920fc1.camera = utility::getstruct( "podium_camera_shot3" );
    level.var_a3bf8eb31b920fc1.gemspot = utility::getstruct( "podium_gem_spot" );
    level.var_a3bf8eb31b920fc1.stunedpapaback = utility::getstruct( "podium_stuned_papaback" );
    initplayerdialog();
    initsound();
    initanimations();
    level.var_a3bf8eb31b920fc1.cutshots = [];
    
    for ( shotnumber = 0; true ; shotnumber++ )
    {
        shot = utility::getstruct( "podium_camera_shot" + shotnumber );
        
        if ( !isdefined( shot ) )
        {
            break;
        }
        
        args = strtok( shot.script_parameters, ";" );
        assert( args.size >= 4 );
        shot.var_c6db5c05a5f1e16e = float( args[ 0 ] );
        shot.var_9b703e3ad83159ff = float( args[ 1 ] );
        shot.var_3b388b4a90360b19 = float( args[ 2 ] );
        shot.shouldfadeout = int( args[ 3 ] );
        
        if ( isdefined( shot.target ) )
        {
            shot.targetstruct = utility::getstruct( shot.target, "targetname" );
        }
        
        level.var_a3bf8eb31b920fc1.cutshots[ level.var_a3bf8eb31b920fc1.cutshots.size ] = shot;
    }
}

#using_animtree( "script_model" );

// Namespace ztron_outro
// Params 0
// Checksum 0xe2310956, Offset: 0xb41
// Size: 0x188
function initanimations()
{
    level.scr_animtree[ "ztron_podium" ] = #animtree;
    level.scr_anim[ "ztron_podium" ][ "ph_parade_un_cheering_01" ] = %ph_parade_un_cheering_01;
    level.scr_eventanim[ "ztron_podium" ][ "ph_parade_un_cheering_01" ] = %"ph_parade_un_cheering_01";
    level.scr_anim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate03" ] = %jlr_patrol_victory_celebrate03;
    level.scr_eventanim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate03" ] = %"jlr_patrol_victory_celebrate03";
    level.scr_anim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate04" ] = %jlr_patrol_victory_celebrate04;
    level.scr_eventanim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate04" ] = %"jlr_patrol_victory_celebrate04";
    level.scr_anim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate02" ] = %jlr_patrol_victory_celebrate02;
    level.scr_eventanim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate02" ] = %"jlr_patrol_victory_celebrate02";
    level.scr_anim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate01" ] = %jlr_patrol_victory_celebrate01;
    level.scr_eventanim[ "ztron_podium" ][ "jlr_patrol_victory_celebrate01" ] = %"jlr_patrol_victory_celebrate01";
    level.scr_anim[ "ztron_podium" ][ "shipcrib_lounge_sit_idle_02" ] = %shipcrib_lounge_sit_idle_02;
    level.scr_eventanim[ "ztron_podium" ][ "shipcrib_lounge_sit_idle_02" ] = %"shipcrib_lounge_sit_idle_02";
}

// Namespace ztron_outro
// Params 1
// Checksum 0xcb2a4a71, Offset: 0xcd1
// Size: 0x4a
function function_bbe511f24bd5a8da( dialogarray )
{
    text = "podium_skit_4th_line1";
    
    if ( dialogarray.size > 0 )
    {
        randomindex = randomint( dialogarray.size );
        text = dialogarray[ randomindex ];
        dialogarray[ randomindex ] = undefined;
        function_cdc669dbc8ea2101( dialogarray );
    }
    
    return text;
}

// Namespace ztron_outro
// Params 0
// Checksum 0x4a8eeba9, Offset: 0xd24
// Size: 0x79d
function initplayerdialog()
{
    level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc = [];
    level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc[ level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc.size ] = #"hash_e6daf99955714a13";
    level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc[ level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc.size ] = #"hash_e6dafb9955714d79";
    level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc[ level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc.size ] = #"hash_e6dafc9955714f2c";
    level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc[ level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc.size ] = #"hash_e6dafe9955715292";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346 = [];
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6daf99955714a13";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6dafb9955714d79";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6dafc9955714f2c";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6dafe9955715292";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6dafa9955714bc6";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_b7603f8c2f80f460";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6dafd99557150df";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6daff9955715445";
    level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346[ level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346.size ] = #"hash_e6db0099557155f8";
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113 = [];
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113[ level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113.size ] = #"hash_1661053646456d6f";
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113[ level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113.size ] = #"hash_1661063646456f22";
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113[ level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113.size ] = #"hash_16610736464570d5";
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113[ level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113.size ] = #"hash_16610036464564f0";
    level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113[ level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113.size ] = #"hash_16610136464566a3";
    level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0 = [];
    level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0[ level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0.size ] = #"hash_8099234a5c38b02c";
    level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0[ level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0.size ] = #"hash_8099264a5c38b545";
    level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0[ level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0.size ] = #"hash_8099254a5c38b392";
    level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0[ level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0.size ] = #"hash_8099204a5c38ab13";
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45 = [];
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45[ level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45.size ] = #"hash_22004919889d36bb";
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45[ level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45.size ] = #"hash_22004a19889d386e";
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45[ level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45.size ] = #"hash_22004b19889d3a21";
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45[ level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45.size ] = #"hash_22004c19889d3bd4";
    level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45[ level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45.size ] = #"hash_22004d19889d3d87";
    level.var_a3bf8eb31b920fc1.papaback = [];
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933bf4412fdecb8";
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933c24412fdf1d1";
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933c14412fdf01e";
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933c44412fdf537";
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933c34412fdf384";
    level.var_a3bf8eb31b920fc1.papaback[ level.var_a3bf8eb31b920fc1.papaback.size ] = #"hash_b933c64412fdf89d";
    level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769 = [];
    level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769[ level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769.size ] = #"hash_11fa630c821c1976";
    level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769[ level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769.size ] = #"hash_e745ef4e8814f665";
    level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769[ level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769.size ] = #"hash_a7a478b3b7712802";
}

// Namespace ztron_outro
// Params 0
// Checksum 0x624c9d95, Offset: 0x14c9
// Size: 0x8a
function initsound()
{
    ztron_sound::function_4ac735395b173fe( "ztron_podium_postg_intro", "uin_potg_intro" );
    ztron_sound::function_4ac735395b173fe( "ztron_podium_raygun_fire", "evt_ztron_outro_raygun_fire" );
    ztron_sound::function_4ac735395b173fe( "ztron_podium_raygun_impact", "evt_ztron_outro_raygun_impact" );
    ztron_sound::function_4ac735395b173fe( "ztron_outro_gem_shower", "evt_ztron_outro_gem_shower" );
    ztron_sound::function_4ac735395b173fe( "ztron_ai_silverback_vocal_roar_short", "zmb_ztron_ai_silverback_vocal_roar_short" );
    ztron_sound::function_4ac735395b173fe( "ztron_outro_mamaback_takeoff", "evt_ztron_outro_mamaback_takeoff" );
    ztron_sound::function_4ac735395b173fe( "ztron_outro_mamaback_land", "evt_ztron_outro_mamaback_land" );
    ztron_sound::function_4ac735395b173fe( "ztron_outro_mamaback_land_last", "evt_ztron_outro_mamaback_land_last" );
}

// Namespace ztron_outro
// Params 1
// Checksum 0xf6889336, Offset: 0x155b
// Size: 0xa1
function function_b2c66142e7cc2971( isblack )
{
    foreach ( player in level.players )
    {
        ztron_sound::ztron_playsound( "ztron_podium_postg_intro", undefined, player );
        level thread game_utility::fadetoblackforplayer( player, isblack, 0.5 );
    }
    
    wait 0.5;
}

// Namespace ztron_outro
// Params 1
// Checksum 0xaad3b517, Offset: 0x1604
// Size: 0x86
function allplayersfreeze( isfreeze )
{
    foreach ( player in level.players )
    {
        player utility::function_bed40b09860f8227( isfreeze );
    }
}

// Namespace ztron_outro
// Params 2
// Checksum 0x9865d5fd, Offset: 0x1692
// Size: 0x54, Type: bool
function sortbyscore( lhs, rhs )
{
    return lhs.ztron.score.points > rhs.ztron.score.points;
}

// Namespace ztron_outro
// Params 1
// Checksum 0x77c1b85e, Offset: 0x16ef
// Size: 0xb7b
function podiumScene( var_874eefd9958c8b42 = 0 )
{
    level endon( #"request_end_game_again" );
    level.var_a3bf8eb31b920fc1.var_874eefd9958c8b42 = var_874eefd9958c8b42;
    setomnvarforallclients( "ui_ztron_player_in_podium", 1 );
    wait 1;
    laststate = ztron_main::function_6cacd29a4f2b9588( 4 );
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "podiumScene" );
    level.ztron.blockgg = 1;
    
    foreach ( player in level.players )
    {
        player notify( #"game_over_podium_scene" );
        
        if ( getdvarint( @"hash_6cb980a6d9b2caee", 1 ) == 1 )
        {
            player thread streamhint::playerstreamhintlocation( level.var_a3bf8eb31b920fc1.camera.origin );
        }
        
        player.ztron.blockgg = 1;
        player ztron_ui::function_545666b11d318ade( 2 );
        player val::set( "ztron_cutscene", "show_hud", 0 );
        player lerpfovscalefactor( 0, 0 );
        player status_effects::function_4306f85454d862ba();
    }
    
    ztron_ui::function_ce7fbecb1ea8d56f();
    
    if ( !var_874eefd9958c8b42 )
    {
        function_b2c66142e7cc2971( 1 );
    }
    
    allplayersfreeze( 1 );
    level thread ztron_util::killallenemies( 1 );
    ztron_weather::function_118f675e6049a8e0();
    ztron_weather::setlightstate( 2 );
    level thread ztron_world_event::function_e0e05f88577eca1f();
    
    foreach ( prop in level.var_a3bf8eb31b920fc1.props )
    {
        assert( !isdefined( prop.scriptmodel ) );
        prop.scriptmodel = spawn( "script_model", prop.origin );
        prop.scriptmodel setmodel( prop.script_label );
        prop.scriptmodel.angles = prop.angles;
    }
    
    foreach ( guy in level.var_a3bf8eb31b920fc1.zspots )
    {
        assert( !isdefined( guy.scriptmodel ) );
        guy.scriptmodel = spawn( "script_model", guy.origin );
        guy.scriptmodel setmodel( "c_t10_zmb_zod_zombie_01_dancing" );
        guy.scriptmodel.angles = guy.angles;
        besilent = 0;
        
        if ( isdefined( guy.script_parameters ) )
        {
            toks = strtok( guy.script_parameters, ";" );
            
            if ( toks.size > 0 )
            {
                besilent = int( toks[ 0 ] );
            }
        }
        
        clonehead = spawn( "script_model", guy.origin );
        clonehead setmodel( "c_t10_zmb_zod_zombie_head_dancing" );
        clonehead linkto( guy.scriptmodel, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
        guy.scriptmodel.clonehead = clonehead;
        guy.scriptmodel.ztron = spawnstruct();
        guy.scriptmodel thread function_b2fd4a09396c69bb( guy.script_int, besilent );
    }
    
    if ( getdvarint( @"hash_1de29596e4d6da8f" ) == 1 )
    {
        foreach ( player in level.players )
        {
            sortedplayers[ 0 ] = player;
            sortedplayers[ 1 ] = player;
            sortedplayers[ 2 ] = player;
            sortedplayers[ 3 ] = player;
            break;
        }
    }
    else
    {
        sortedplayers = arraysort( level.players, undefined, &sortbyscore );
    }
    
    if ( level.var_a3bf8eb31b920fc1.var_874eefd9958c8b42 )
    {
        level thread function_637a13b7bc85c383();
    }
    
    winner = sortedplayers[ 0 ];
    wait 2;
    level.var_a3bf8eb31b920fc1.podiumclones = [];
    
    foreach ( spot in level.var_a3bf8eb31b920fc1.playerspots )
    {
        idx = int( spot.script_noteworthy ) - 1;
        
        if ( idx < sortedplayers.size )
        {
            player = sortedplayers[ idx ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player player::updatesessionstate( "playing" );
            player setorigin( spot.origin );
            player setplayerangles( spot.angles );
            player.deathspectatepos = spot.origin;
            player thread function_76907cd47eb60cf1( idx );
            spot.myclone = player;
        }
    }
    
    podiumcamera = spawn( "script_model", ( 0, 0, 0 ) );
    podiumcamera setmodel( "tag_origin" );
    
    foreach ( player in level.players )
    {
        player ztron_camera::enabletopdown( 0 );
        player cameralinkto( podiumcamera, "tag_origin", 1, 1 );
        player notify( #"outro_start" );
    }
    
    wait 1;
    ztron_ui::function_ed63f265289260bb();
    podiumcamera thread podiumcameramove();
    level thread function_5251ea32a88aaa5b( winner );
    level thread function_42a2a0e641ada072();
    level thread outropapaback();
    level thread function_fda9f39980eca8bd();
    wait 2;
    level notify( #"hash_b25409ae06db4c42" );
    level notify( #"hash_a38d7b771f4f5445" );
    level utility::waittill_any_timeout( 60.2, "podium_abort" );
    function_b2c66142e7cc2971( 1 );
    wait 1;
    level notify( #"podiumCleanUp" );
    
    foreach ( prop in level.var_a3bf8eb31b920fc1.props )
    {
        assert( isdefined( prop.scriptmodel ) );
        prop.scriptmodel delete();
        prop.scriptmodel = undefined;
    }
    
    foreach ( spot in level.var_a3bf8eb31b920fc1.playerspots )
    {
        if ( isdefined( spot.chicken ) )
        {
            spot.chicken delete();
            spot.chicken = undefined;
        }
    }
    
    foreach ( guy in level.var_a3bf8eb31b920fc1.zspots )
    {
        if ( isdefined( guy.scriptmodel.clonehead ) )
        {
            guy.scriptmodel.clonehead delete();
            guy.scriptmodel.clonehead = undefined;
        }
        
        if ( isdefined( guy.scriptmodel ) )
        {
            guy.scriptmodel delete();
            guy.scriptmodel = undefined;
        }
    }
    
    foreach ( gemsitem in level.var_a3bf8eb31b920fc1.gemsarray )
    {
        thread ztron_item::clearitem( gemsitem );
    }
    
    foreach ( player in level.players )
    {
        player cameraunlink();
        player ztron_camera::enabletopdown( 1 );
        player player::updatesessionstate( "spectator" );
        level thread game_utility::fadetoblackforplayerkeepui( player, 1, 0.6 );
        player val::reset( "ztron_cutscene", "show_hud" );
    }
    
    allplayersfreeze( 1 );
    podiumcamera delete();
    wait 0.6;
    setomnvarforallclients( "post_game_state", 8 );
    wait 0.6;
    ztron_ui::function_37aad40e39a9fdfe( "game_over", ztron_main::function_d0ec00d4cc5debc7() );
    function_b2c66142e7cc2971( 0 );
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "gameOver" );
    wait 3;
    ztron_main::function_6cacd29a4f2b9588( laststate );
    setomnvarforallclients( "ui_ztron_player_in_podium", 0 );
    level notify( #"podiumalldone" );
}

// Namespace ztron_outro
// Params 0
// Checksum 0x2d12170e, Offset: 0x2272
// Size: 0x1eb
function podiumcameramove()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"entitydeleted" );
    firstscene = 1;
    
    foreach ( shot in level.var_a3bf8eb31b920fc1.cutshots )
    {
        var_2f34fb95c2c957a8 = distance( self.origin, shot.origin );
        
        if ( var_2f34fb95c2c957a8 > 1 )
        {
            needfade = 1;
        }
        
        if ( needfade && !firstscene )
        {
            function_b2c66142e7cc2971( 1 );
        }
        
        self.origin = shot.origin;
        self.angles = shot.angles;
        
        if ( needfade )
        {
            function_b2c66142e7cc2971( 0 );
        }
        
        if ( shot.var_c6db5c05a5f1e16e > 0 )
        {
            wait shot.var_c6db5c05a5f1e16e;
        }
        
        traveltime = shot.var_9b703e3ad83159ff;
        
        if ( shot.var_3b388b4a90360b19 == 0 )
        {
            traveltime -= 0.5;
        }
        
        if ( isdefined( shot.targetstruct ) )
        {
            self moveto( shot.targetstruct.origin, shot.var_9b703e3ad83159ff );
            self rotateto( shot.targetstruct.angles, shot.var_9b703e3ad83159ff );
        }
        
        wait traveltime;
        
        if ( shot.var_3b388b4a90360b19 > 0 )
        {
            wait shot.var_3b388b4a90360b19;
        }
        
        firstscene = 0;
        needfade = 0;
    }
}

// Namespace ztron_outro
// Params 3
// Checksum 0x46fcad9f, Offset: 0x2465
// Size: 0xe9
function create_player_rig( animname, spawnpos, spawnang )
{
    self.animname = animname;
    
    if ( !isdefined( spawnpos ) )
    {
        spawnpos = ( 0, 0, 0 );
    }
    
    if ( !isdefined( spawnang ) )
    {
        spawnang = ( 0, 0, 0 );
    }
    
    self function_e19ccf4da1a61ba7( spawnpos );
    player_rig = spawn( "script_arms", self.origin, 0, 0, self );
    self.player_rig = player_rig;
    player_rig.origin = spawnpos;
    player_rig.angles = spawnang;
    player_rig.player = self;
    player_rig hide( 1 );
    player_rig.animname = animname;
    player_rig useanimtree( #animtree );
    player_rig.updatedversion = 1;
    self playerlinktoabsolute( player_rig, "tag_player" );
}

// Namespace ztron_outro
// Params 1
// Checksum 0xc7cd87e5, Offset: 0x2556
// Size: 0x2b3
function function_76907cd47eb60cf1( idx )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    angles = self.angles;
    origin = self.origin;
    myanim = [];
    
    switch ( idx )
    {
        case 0:
            myanim[ 0 ] = [ "ph_parade_un_cheering_01", getanimlength( %ph_parade_un_cheering_01 ) ];
            myanim[ 1 ] = [ "jlr_patrol_victory_celebrate03", getanimlength( %jlr_patrol_victory_celebrate03 ) ];
            myanim[ 2 ] = [ "jlr_patrol_victory_celebrate04", getanimlength( %jlr_patrol_victory_celebrate04 ) ];
            myskit = 43;
            break;
        case 1:
            myanim[ 0 ] = [ "jlr_patrol_victory_celebrate02", getanimlength( %jlr_patrol_victory_celebrate02 ) ];
            myskit = 44;
            break;
        case 2:
            myanim[ 0 ] = [ "jlr_patrol_victory_celebrate01", getanimlength( %jlr_patrol_victory_celebrate01 ) ];
            myskit = 45;
            break;
        case 3:
            myanim[ 0 ] = [ "shipcrib_lounge_sit_idle_02", getanimlength( %shipcrib_lounge_sit_idle_02 ) ];
            myskit = 46;
            break;
    }
    
    thread function_5337f99a4f5d9abb( myskit, idx );
    
    if ( !isdefined( self.player_rig ) )
    {
        create_player_rig( "ztron_podium", self.origin, self.angles );
    }
    
    animstruct = spawnstruct();
    animstruct.origin = self.origin;
    animstruct.angles = self.angles;
    self.ztron.podiumanimstruct = animstruct;
    randomselect = undefined;
    randomindex = 0;
    waitframe();
    weapon = self getcurrentprimaryweapon();
    
    if ( isweapon( weapon ) && !isnullweapon( weapon ) )
    {
        inventory_utility::_takeweapon( weapon );
    }
    
    while ( true )
    {
        self.angles = angles;
        self.origin = origin;
        
        if ( randomselect )
        {
            randomindex = randomint( myanim.size );
        }
        else if ( randomindex >= myanim.size )
        {
            randomindex = 0;
        }
        
        var_85736400fadeac33 = myanim[ randomindex ];
        randomindex += 1;
        self.ztron.podiumanimstruct thread anim_mp::anim_player_solo( self, self.player_rig, var_85736400fadeac33[ 0 ] );
        wait var_85736400fadeac33[ 1 ];
    }
}

// Namespace ztron_outro
// Params 2
// Checksum 0x36b22d13, Offset: 0x2811
// Size: 0xbc
function function_5337f99a4f5d9abb( var_4f31dbacaac87752, idx )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    level waittill( #"hash_b25409ae06db4c42" );
    
    switch ( idx )
    {
        case 0:
            thread function_aac350187dec08a4( var_4f31dbacaac87752 );
            break;
        case 1:
            thread function_10245ab56f5d0694( var_4f31dbacaac87752 );
            break;
        case 2:
            thread function_7693f4f60a9d844d( var_4f31dbacaac87752 );
            break;
        case 3:
            thread function_934714d53a43871c( var_4f31dbacaac87752 );
            break;
        default:
            assert( 0 );
            break;
    }
}

// Namespace ztron_outro
// Params 1
// Checksum 0x7fe2bf9, Offset: 0x28d5
// Size: 0x154
function function_aac350187dec08a4( var_4f31dbacaac87752 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"podium_player_name", 0, 0, [ self.sessionuimemberindex ] );
    wait 1;
    level notify( #"hash_3a5e52bbc39e1c91" );
    wait 2;
    level utility::waittill_any_timeout( 7, "ztron_podium_showPlaces" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"hash_74e5f62c3f6e4224", 0, 0 );
    wait 1;
    ztron_dialog::function_927bb94feca983e8( #"hash_df82f4396736d284", 0, 0 );
    wait 14;
    text_pool = level.players.size > 1 ? level.var_a3bf8eb31b920fc1.var_5ae2ec7493d09346 : level.var_a3bf8eb31b920fc1.var_6e87a8cd6610b4bc;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( text_pool );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 4;
    level notify( #"gem_drop" );
    level notify( #"papaback_start" );
    wait 2;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( text_pool );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 4;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( text_pool );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 5;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( text_pool );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
}

// Namespace ztron_outro
// Params 1
// Checksum 0xa1d1e7c, Offset: 0x2a31
// Size: 0x11e
function function_10245ab56f5d0694( var_4f31dbacaac87752 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    level waittill( #"hash_3a5e52bbc39e1c91" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"podium_player_name", 0, 0, [ self.sessionuimemberindex ] );
    wait 2;
    level notify( #"hash_7d5c782c9416b38d" );
    
    if ( level.var_a3bf8eb31b920fc1.podiumclones.size == 2 )
    {
        wait 5;
        level notify( #"ztron_podium_showPlaces" );
    }
    else
    {
        level utility::waittill_any_timeout( 5, "ztron_podium_showPlaces" );
    }
    
    ztron_dialog::function_7e3f6329d9afcdc1( #"hash_2776e4916c709448", 0, 0 );
    wait 5;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 4;
    ztron_dialog::function_927bb94feca983e8( #"hash_3487830bad929478", 0, 0 );
    wait 19;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2eb7493d09113 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
}

// Namespace ztron_outro
// Params 1
// Checksum 0x7315be10, Offset: 0x2b57
// Size: 0x140
function function_7693f4f60a9d844d( var_4f31dbacaac87752 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    level waittill( #"hash_7d5c782c9416b38d" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"podium_player_name", 0, 0, [ self.sessionuimemberindex ] );
    wait 2;
    level notify( #"hash_2a4a15e11b70b32" );
    
    if ( level.var_112a8c3c85284746.podiumclones.size == 3 )
    {
        wait 3;
        level notify( #"ztron_podium_showPlaces" );
    }
    else
    {
        level utility::waittill_any_timeout( 3, "ztron_podium_showPlaces" );
    }
    
    ztron_dialog::function_7e3f6329d9afcdc1( #"hash_20ab772f04c0ce0b", 0, 0 );
    wait 7;
    ztron_dialog::function_927bb94feca983e8( #"hash_6086fd2df05d72b1", 0, 0 );
    wait 5;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 6;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2ea7493d08ee0 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    level waittill( #"papabacklanded" );
    wait 2;
    ztron_dialog::function_7e3f6329d9afcdc1( #"hash_98f15775b91f9bed", 0, 0 );
}

// Namespace ztron_outro
// Params 1
// Checksum 0x39d0f441, Offset: 0x2c9f
// Size: 0x10f
function function_934714d53a43871c( var_4f31dbacaac87752 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    level waittill( #"hash_2a4a15e11b70b32" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"podium_player_name", 0, 0, [ self.sessionuimemberindex ] );
    wait 3;
    level notify( #"ztron_podium_showPlaces" );
    ztron_dialog::function_7e3f6329d9afcdc1( #"podium_skit_4th_line1", 0, 0 );
    wait 3;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 5;
    ztron_dialog::function_927bb94feca983e8( #"hash_11bfe0b25280851c", 0, 0 );
    wait 4;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
    wait 10.5;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_5ae2f17493d09e45 );
    ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
}

// Namespace ztron_outro
// Params 1
// Checksum 0xc71e8647, Offset: 0x2db6
// Size: 0x4a
function function_5251ea32a88aaa5b( winner )
{
    level endon( #"ztron_game_is_over" );
    level endon( #"podiumCleanUp" );
    wait 2.5;
    
    while ( isdefined( winner ) )
    {
        if ( winner usebuttonpressed() )
        {
            level notify( #"podium_abort" );
            return;
        }
        
        waitframe();
    }
}

// Namespace ztron_outro
// Params 0
// Checksum 0x7d2a00d7, Offset: 0x2e08
// Size: 0x1b0
function function_42a2a0e641ada072()
{
    level endon( #"podiumCleanUp" );
    level waittill( #"gem_drop" );
    gems = 50;
    
    if ( isdefined( level.var_a3bf8eb31b920fc1.playerspots[ 0 ].myclone ) )
    {
        ztron_sound::ztron_playsound( "ztron_outro_gem_shower", undefined, level.var_a3bf8eb31b920fc1.playerspots[ 0 ].myclone );
    }
    
    level.var_a3bf8eb31b920fc1.gemsarray = [];
    
    while ( gems )
    {
        gems--;
        spot = level.var_a3bf8eb31b920fc1.gemspot.origin + ( randomintrange( -128, 128 ), randomintrange( -128, 128 ), randomintrange( 300, 500 ) );
        params = spawnstruct();
        params.overridelifetime = 9999;
        params.scale = 1.5;
        
        if ( !isdefined( params.launchforce ) )
        {
            params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 100 );
        }
        
        itembundlename = level.ztron.gembundles[ utility::array_random( level.ztron.var_c5f22b2665289fe ) ];
        gemsspawn = ztron_item::spawnitem( itembundlename, spot, 0, undefined, params );
        level.var_a3bf8eb31b920fc1.gemsarray[ level.var_a3bf8eb31b920fc1.gemsarray.size ] = gemsspawn;
        waitframe();
    }
}

// Namespace ztron_outro
// Params 0
// Checksum 0xe221dbb8, Offset: 0x2fc0
// Size: 0x18e
function function_637a13b7bc85c383()
{
    level endon( #"podiumCleanUp" );
    org = utility::spawn_model( "tag_origin", level.var_a3bf8eb31b920fc1.stunedpapaback.origin, level.var_a3bf8eb31b920fc1.stunedpapaback.angles );
    org thread ztron_util::function_36239518d8da65f0( level, "podiumCleanUp" );
    stunedpapaback = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "papaback" ), level.var_a3bf8eb31b920fc1.stunedpapaback.origin, undefined, undefined, 1, 1 );
    stunedpapaback thread ztron_util::function_36239518d8da65f0( level, "podiumCleanUp" );
    waitframe();
    stunedpapaback forceteleport( stunedpapaback.origin, level.var_a3bf8eb31b920fc1.stunedpapaback.angles );
    stunedpapaback.var_9f4fae59ff4e962a = 1;
    stunedpapaback.ignoreall = 1;
    stunedpapaback linkto( org );
    stunedpapaback.outroorg = org;
    stunedpapaback.ignoreme = 1;
    stunedpapaback.var_a436a6789de5017c = 1;
    stunedpapaback notify( #"kill_think" );
    level waittill( #"hash_a38d7b771f4f5445" );
    playfxontag( utility::getfx( "stun_head" ), stunedpapaback, "j_head_end" );
    playfxontag( utility::getfx( "stun_head" ), stunedpapaback, "j_head_end" );
    wait 0.5;
    stunedpapaback kill();
}

// Namespace ztron_outro
// Params 0
// Checksum 0xd5bd6ce6, Offset: 0x3156
// Size: 0x655
function outropapaback()
{
    level endon( #"podiumCleanUp" );
    var_def333a8d396d091 = utility::getstruct( "podium_mamaback_introspot", "targetname" );
    var_1e82799bb05bfe23 = utility::getstruct( "podium_mamaback_roofspot", "targetname" );
    podiumlocs = utility::getstructarray( "podium_playerpos", "targetname" );
    var_b0a4119e221c51f9 = podiumlocs[ 0 ];
    
    foreach ( spot in podiumlocs )
    {
        if ( spot.script_noteworthy == "1" )
        {
            var_b0a4119e221c51f9 = spot;
            break;
        }
    }
    
    org = utility::spawn_model( "tag_origin", var_def333a8d396d091.origin, var_def333a8d396d091.angles );
    org thread ztron_util::function_36239518d8da65f0( level, "podiumCleanUp" );
    level waittill( #"papaback_start" );
    ztron_sound::ztron_playsound( "ztron_lightning_bolt", org.origin );
    playfxontag( utility::getfx( "lightningStrike" ), org, "tag_origin" );
    wait 1;
    playfxontag( utility::getfx( "lightningStrike" ), org, "tag_origin" );
    ztron_sound::ztron_playsound( "ztron_lightning_bolt", org.origin );
    papaback = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "papaback" ), var_def333a8d396d091.origin, undefined, undefined, 1, 1 );
    papaback endon( #"death" );
    waitframe();
    papaback notify( #"kill_think" );
    papaback forceteleport( papaback.origin, var_def333a8d396d091.angles );
    papaback thread ztron_util::function_36239518d8da65f0( level, "podiumCleanUp" );
    papaback setcandamage( 0 );
    papaback.var_9f4fae59ff4e962a = 1;
    papaback.ignoreall = 1;
    papaback linkto( org );
    papaback.outroorg = org;
    papaback.ignoreme = 1;
    wait 0.5;
    playfxontag( utility::getfx( "lightningStrike" ), org, "tag_origin" );
    ztron_sound::ztron_playsound( "ztron_lightning_bolt", org.origin );
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_518b9c270d1d38f1" );
    wait 3;
    level notify( #"ztron_outro_mood_happy" );
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.papaback );
    papaback ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae );
    wait 2;
    org moveto( var_1e82799bb05bfe23.origin + ( 0, 0, 1500 ), 2 );
    playfx( utility::getfx( "turret_impact" ), org.origin + ( 0, 0, 12 ) );
    ztron_sound::ztron_playsound( "ztron_outro_mamaback_takeoff", org.origin );
    wait 2;
    org.origin = var_1e82799bb05bfe23.origin + ( 0, 0, 1500 );
    org.angles = var_1e82799bb05bfe23.angles;
    org moveto( var_1e82799bb05bfe23.origin, 2 );
    wait 2;
    playfx( utility::getfx( "turret_impact" ), org.origin + ( 0, 0, 12 ) );
    ztron_sound::ztron_playsound( "ztron_outro_mamaback_land", org.origin );
    ztron_sound::ztron_playsound( "ztron_ai_silverback_vocal_roar_short", undefined, papaback );
    level notify( #"papabacklanded" );
    wait 4;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_625d668753f43194" );
    wait 2;
    wait 2;
    level notify( #"papabackattack" );
    playfx( utility::getfx( "turret_impact" ), org.origin + ( 0, 0, 12 ) );
    ztron_sound::ztron_playsound( "ztron_outro_mamaback_takeoff", org.orgin );
    org moveto( var_1e82799bb05bfe23.origin + ( 0, 0, 1500 ), 2 );
    wait 1;
    wait 0.25;
    level thread chickenblast( "", org, level.var_a3bf8eb31b920fc1.playerspots[ 3 ] );
    wait 0.25;
    level thread chickenblast( "", org, level.var_a3bf8eb31b920fc1.playerspots[ 2 ] );
    wait 0.25;
    level thread chickenblast( "", org, level.var_a3bf8eb31b920fc1.playerspots[ 1 ], undefined, 1 );
    wait 0.25;
    level thread chickenblast( "", org, level.var_a3bf8eb31b920fc1.playerspots[ 0 ], "papabackWinner" );
    level notify( #"ztron_outro_mood_lol" );
    wait 1;
    org.origin = var_b0a4119e221c51f9.origin + ( 0, 0, 1500 );
    org moveto( var_b0a4119e221c51f9.origin, 1 );
    ztron_sound::ztron_playsound( "ztron_ai_silverback_vocal_roar_short", undefined, papaback );
    wait 1;
    playfx( utility::getfx( "turret_impact" ), org.origin + ( 0, 0, 12 ) );
    ztron_sound::ztron_playsound( "ztron_outro_mamaback_land_last", org.origin );
    level notify( #"papabackWinner" );
    
    if ( level.var_a3bf8eb31b920fc1.var_874eefd9958c8b42 )
    {
        papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_518b9f270d1d3e0a" );
    }
    else
    {
        roll = randomint( 100 );
        
        if ( roll == 0 )
        {
            papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_a91805b5ce7bcbee" );
        }
        else
        {
            papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_518b9a270d1d358b" );
        }
    }
    
    papaback utility::waittill_any_timeout( 3, "taunt_end", "death" );
    level notify( #"papabackdone" );
}

// Namespace ztron_outro
// Params 0
// Checksum 0x4832974a, Offset: 0x37b3
// Size: 0x133
function function_fda9f39980eca8bd()
{
    level endon( #"podiumCleanUp" );
    level waittill( #"papabackattack" );
    wait 1;
    var_a8a06d44ffed45ae = function_bbe511f24bd5a8da( level.var_a3bf8eb31b920fc1.var_2c3575fcf051a769 );
    var_abb4bdd4b6d86084 = [];
    
    foreach ( spot in level.var_a3bf8eb31b920fc1.playerspots )
    {
        idx = int( spot.script_noteworthy ) - 1;
        
        if ( idx == 0 )
        {
            continue;
        }
        
        if ( spot.myclone )
        {
            var_abb4bdd4b6d86084[ var_abb4bdd4b6d86084.size ] = spot.myclone;
        }
    }
    
    if ( var_abb4bdd4b6d86084.size == 0 )
    {
        return;
    }
    
    var_a5a249abbbf79f2 = var_abb4bdd4b6d86084[ randomint( var_abb4bdd4b6d86084.size ) ];
    var_a5a249abbbf79f2 ztron_dialog::function_7e3f6329d9afcdc1( var_a8a06d44ffed45ae, 0, 0 );
}

// Namespace ztron_outro
// Params 2
// Checksum 0x362167f2, Offset: 0x38ee
// Size: 0x4f
function function_b2fd4a09396c69bb( bubbledelay, besilent )
{
    self endon( #"death" );
    self useanimtree( #animtree );
    thread function_e6ad4ffcde392fc6();
    thread function_ace0033f3b6f38d3();
    thread function_787520d27e2cc950();
    
    if ( besilent != 1 )
    {
        thread function_4663539241202015( bubbledelay );
    }
}

// Namespace ztron_outro
// Params 0
// Checksum 0xa6f07ba8, Offset: 0x3945
// Size: 0x99
function function_e6ad4ffcde392fc6()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( level.ztron.var_cc2401fc489cfb47 ) )
        {
            wait randomfloatrange( 0.1, 2 );
            continue;
        }
        
        var_4bcb0442a5e20b5c = vectortoangles( level.ztron.var_cc2401fc489cfb47.origin - self.origin );
        self rotateto( ( 0, var_4bcb0442a5e20b5c[ 1 ], 0 ), randomfloatrange( 0.5, 2 ) );
        self waittill( #"rotatedone" );
    }
}

// Namespace ztron_outro
// Params 0
// Checksum 0x86604ff, Offset: 0x39e6
// Size: 0x206
function function_ace0033f3b6f38d3()
{
    self endon( #"death" );
    angryarray = [ [ "ai_t9_zm_zombie_base_attack_03", getanimlength( %ai_t9_zm_zombie_base_attack_03 ) ], [ "ai_t9_zm_zombie_base_attack_ranged_l_react_0", getanimlength( %ai_t9_zm_zombie_base_attack_ranged_l_react_0 ) ], [ "ai_t9_zm_zombie_base_attack_ranged_l_throw_01", getanimlength( %ai_t9_zm_zombie_base_attack_ranged_l_throw_01 ) ], [ "ai_t9_zm_zombie_base_attack_ranged_r_react_0", getanimlength( %ai_t9_zm_zombie_base_attack_ranged_r_react_0 ) ], [ "ai_t9_zm_zombie_base_attack_ranged_r_throw_01", getanimlength( %ai_t9_zm_zombie_base_attack_ranged_r_throw_01 ) ] ];
    happyarray = [ [ "ai_t10_zm_zombie_dance_01", getanimlength( %ai_t10_zm_zombie_dance_01 ) ], [ "ai_t10_zm_zombie_dance_15", getanimlength( %ai_t10_zm_zombie_dance_15 ) ], [ "ai_t10_zm_zombie_dance_11", getanimlength( %ai_t10_zm_zombie_dance_11 ) ], [ "ai_t10_zm_zombie_dance_12", getanimlength( %ai_t10_zm_zombie_dance_12 ) ], [ "ai_t10_zm_zombie_dance_08", getanimlength( %ai_t10_zm_zombie_dance_08 ) ], [ "ai_t10_zm_zombie_dance_09", getanimlength( %ai_t10_zm_zombie_dance_09 ) ] ];
    self.animarray = angryarray;
    self.var_4f9d11bc1ee42052 = "ztron_outro_mood_angry";
    
    while ( true )
    {
        result = level utility::waittill_any_in_array_return( [ "ztron_outro_mood_angry", "ztron_outro_mood_happy", "ztron_outro_mood_lol" ] );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.var_4f9d11bc1ee42052 = result;
        
        if ( result == "ztron_outro_mood_angry" )
        {
            self.animarray = angryarray;
        }
        else
        {
            self.animarray = happyarray;
        }
        
        thread function_787520d27e2cc950();
    }
}

// Namespace ztron_outro
// Params 0
// Checksum 0x9944e79e, Offset: 0x3bf4
// Size: 0x9c
function function_787520d27e2cc950()
{
    self endon( #"death" );
    angles = self.angles;
    origin = self.origin;
    
    while ( true )
    {
        self.angles = angles;
        self.origin = origin;
        randomanim = self.animarray[ randomint( self.animarray.size ) ];
        idleanim = randomanim[ 0 ];
        animlength = randomanim[ 1 ];
        self scriptmodelplayanim( idleanim );
        wait animlength;
    }
}

// Namespace ztron_outro
// Params 1
// Checksum 0x114e5f01, Offset: 0x3c98
// Size: 0x56
function function_4663539241202015( bubbledelay )
{
    self endon( #"death" );
    wait randomfloatrange( 1, 4 );
    
    if ( isdefined( bubbledelay ) )
    {
        wait bubbledelay;
    }
    
    while ( true )
    {
        if ( randomint( 100 ) <= 1 )
        {
            ztron_dialog::function_927bb94feca983e8( #"hash_91734abcfdd2dde6", 0, 0 );
            wait 2;
        }
        
        wait 1;
    }
}

// Namespace ztron_outro
// Params 5
// Checksum 0x301ae74a, Offset: 0x3cf6
// Size: 0x49a
function chickenblast( weapon, org, podiumspot, var_87c66310656995ee, var_c3f8e8e8f5844f10 )
{
    level endon( #"podiumCleanUp" );
    
    if ( !isdefined( podiumspot.myclone ) )
    {
        return;
    }
    
    podiumspot.myclone endon( #"disconnect" );
    glow = "glow_" + podiumspot.myclone.ztron.color;
    var_1e1a895196cdfff7 = ztron_weapon::function_bb0a58ae27b195fe( %"hash_1d1e9a024950ca1d" );
    magicbullet( var_1e1a895196cdfff7.weaponobj[ 2 ], org.origin, podiumspot.myclone.origin );
    magicbullet( var_1e1a895196cdfff7.weaponobj[ 2 ], org.origin, podiumspot.myclone.origin );
    magicbullet( var_1e1a895196cdfff7.weaponobj[ 2 ], org.origin, podiumspot.myclone.origin );
    magicbullet( var_1e1a895196cdfff7.weaponobj[ 2 ], org.origin, podiumspot.myclone.origin );
    magicbullet( var_1e1a895196cdfff7.weaponobj[ 2 ], org.origin, podiumspot.myclone.origin );
    ztron_sound::ztron_playsound( "ztron_podium_raygun_fire", org.origin );
    wait 0.4;
    playfxontag( utility::getfx( "ztron_brimestone_explo" ), podiumspot.myclone, "tag_origin" );
    ztron_sound::ztron_playsound( "ztron_podium_raygun_impact", podiumspot.myclone.origin );
    wait 0.1;
    podiumspot.myclone setorigin( podiumspot.origin + ( 0, 0, -100 ) );
    podiumspot.myclone utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", "off" );
    podiumspot.myclone playerhide();
    chicken = spawn( "script_model", podiumspot.origin );
    chicken thread ztron_util::function_36239518d8da65f0( level, "podiumCleanUp" );
    chicken setmodel( "ztron_big_chicken" );
    chicken useanimtree( #animtree );
    chicken.angles = podiumspot.angles;
    chicken.angles += ( 0, randomintrange( -90, 90 ), 0 );
    chicken.ztron = spawnstruct();
    podiumspot.chicken = chicken;
    curanim = [ "ai_sat_zm_a_chicken_idle_big", getanimlength( %ai_sat_zm_a_chicken_idle_big ) ];
    playfxontag( utility::getfx( "chicken_explode" ), chicken, "tag_origin" );
    playfxontag( utility::getfx( glow ), chicken, "tag_origin" );
    chicken endon( #"death" );
    
    if ( isdefined( var_87c66310656995ee ) )
    {
        chicken ztron_dialog::function_7e3f6329d9afcdc1( #"hash_48daebbf16cea58a" );
        chicken thread function_f31c0393f1d7bc07( var_87c66310656995ee );
    }
    
    while ( true )
    {
        chicken.origin = podiumspot.origin;
        chicken scriptmodelplayanim( curanim[ 0 ] );
        wait curanim[ 1 ];
        
        switch ( randomint( 4 ) )
        {
            case 0:
                curanim = [ "ai_sat_zm_a_chicken_idle_big", getanimlength( %ai_sat_zm_a_chicken_idle_big ) ];
                break;
            case 1:
                curanim = [ "ai_sat_zm_a_chicken_idle_a_big", getanimlength( %ai_sat_zm_a_chicken_idle_a_big ) ];
                break;
            case 2:
                curanim = [ "ai_sat_zm_a_chicken_idle_peck_big", getanimlength( %ai_sat_zm_a_chicken_idle_peck_big ) ];
                
                if ( !var_c3f8e8e8f5844f10 )
                {
                    chicken ztron_dialog::function_7e3f6329d9afcdc1( #"hash_c633a103df6edcb1" );
                }
                
                break;
            case 3:
                curanim = [ "ai_sat_zm_a_chicken_react_up_down_big", getanimlength( %ai_sat_zm_a_chicken_react_up_down_big ) ];
                
                if ( !var_c3f8e8e8f5844f10 )
                {
                    chicken ztron_dialog::function_7e3f6329d9afcdc1( #"hash_c6339e03df6ed798" );
                }
                
                break;
        }
    }
}

// Namespace ztron_outro
// Params 1
// Checksum 0xdc506ec, Offset: 0x4198
// Size: 0x89
function function_f31c0393f1d7bc07( note )
{
    self endon( #"death" );
    level waittill( note );
    playfxontag( utility::getfx( "big_chicken_explode" ), self, "tag_origin" );
    waitframe();
    self hide();
    wait 1;
    playfxontag( utility::getfx( "chicken_explode" ), self, "tag_origin" );
    wait 1;
    playfxontag( utility::getfx( "chicken_explode" ), self, "tag_origin" );
    wait 0.5;
    playfxontag( utility::getfx( "chicken_explode" ), self, "tag_origin" );
}

