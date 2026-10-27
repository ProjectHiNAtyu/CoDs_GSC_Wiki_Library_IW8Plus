// script_180a3d9c63ac0435  (hash_180a3d9c63ac0435.gscc) (size: 33699 Bytes / 0x83a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x642f89b (105052315)
// size ...... 33699 (0x83a3)
// includes .. 28  (offset: 0x7cab)
// strings ... 92  (offset: 0x7d8b)
// dev strs .. 12  (offset: 0x8313)
// exports ... 67  (offset: 0x55b7)
// cseg ...... 0x7c7 + 0x4df0 (0x55b7)
// imports ... 225 (offset: 0x602f)
// animtree1 . 0   (offset: 0x83a3)
// animtree2 . 0   (offset: 0x83a3)
#using script_2913428424697f6c;
#using script_31ee2a173f3499b7;
#using script_38390664ae794177;
#using script_4ce55cfc81c444ad;
#using script_5441a11286579ddc;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_achievements;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;
#using scripts\mp\zm\ztron\ztron_world_event;

#namespace ztron_arena_silverback_arena;

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x5
// Checksum 0x9e07e870, Offset: 0x7e5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"silverback_arena", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x205314ab, Offset: 0x806
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x96fdb5de, Offset: 0x817
// Size: 0x7c
function arena_init_internal()
{
    /#
        thread init_devgui();
    #/
    
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "silverback_arena", &silverback_arena_init, &silverback_arena_shutdown );
    ztron_challenge::registerchallenge( "silverback_arena", "silverback_arena", &silverback_arena_challenge, &function_27a69e93d3e28662, 1, &function_c3fc9c1e76e63323 );
    ztron_sound::function_4ac735395b173fe( "ztron_cart_moving_loop", "evt_ztron_minecart_move_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_platform_rotation_loop", "evt_ztron_minecart_platform_rotate_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_platform_trigger_activated_oneshot", "evt_ztron_minecart_platform_rotate_activate" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0xc
// Checksum 0xace45a1d, Offset: 0x89b
// Size: 0x64
function private function_8b13948ff4f05aa5()
{
    self notify( #"hash_239c3b238895b1e2" );
    self endon( #"hash_239c3b238895b1e2" );
    level endon( #"silverback_arena_shutdown", #"ztron_game_is_over" );
    
    if ( !level.ztron.var_371903e5801e0e08 )
    {
        while ( true )
        {
            level waittill( #"round_about_to_start" );
            ztron_ui::function_f5177e090dadd8f4( 2 );
        }
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x5d4c53cc, Offset: 0x907
// Size: 0xdf
function silverback_arena_init()
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_e733dbd4ae561ad5 = "casual_silverback_arena_complete";
    }
    
    thread function_8b13948ff4f05aa5();
    ztron_weather::function_c66678f1a8379c69( "silverback_arena", "Wetness", 15, "round_about_to_start" );
    thread function_c1f5ec028690cd9f();
    self.extra_round = &silverback_arena_boss_fight;
    level thread silverback_special_event();
    self.papaback_defeated = 0;
    level.ztron.active_arena.var_7b32fe236a1111ab = &function_732a771cea5f8730;
    
    if ( level.ztron.blitzmode )
    {
        level.ztron.active_arena.var_99a3ec7b171ae8b1 = &function_89309da58cd456d7;
    }
    
    level notify( #"silverback_arena_activated" );
}

// Namespace ztron_arena_silverback_arena
// Params 2, eflags: 0x4
// Checksum 0x889ddecc, Offset: 0x9ee
// Size: 0x39
function private function_36239518d8da65f0( ent, note )
{
    thread ztron_util::function_36239518d8da65f0( ent, note );
    thread ztron_util::function_36239518d8da65f0( level, "ztron_game_is_over" );
    thread ztron_util::function_36239518d8da65f0( level, "game_reset" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xc1b6eb0, Offset: 0xa2f
// Size: 0x230
function private function_c1f5ec028690cd9f()
{
    if ( level.ztron.blitzmode )
    {
        return;
    }
    
    self.gspawnfire = utility::getstruct( "g_spawn_fire", "script_noteworthy" );
    self.gspawnfire function_b9a2910a049c5d11();
    self.var_9cac20d45c392c34 = utility::getstruct( "g_spawn_bomb_device", "script_noteworthy" );
    self.var_3f5f6ae3e1c65020 = utility::getstruct( "fuse_begin_spot", "script_noteworthy" );
    self.var_9c7bedc6374fb288 = utility::getstruct( "rotation_device", "script_noteworthy" );
    self.var_9c7bedc6374fb288 resetspots( &function_6868b02c376c0013 );
    self.var_fb6e02d4a97fd296 = utility::getstruct( self.var_3f5f6ae3e1c65020.target, "targetname" );
    self.var_fb6e02d4a97fd296 resetspots( &function_c762c4192a2c1345 );
    self.tvspots = utility::getstructarray( "g_spawn_tv", "script_noteworthy" );
    mapspots( self.tvspots, &resettv );
    self.var_528b6c08413c7b25 = utility::getstructarray( "g_spawn_cutscene_zombie_spot", "script_noteworthy" );
    self.machinepower = utility::getstruct( "g_spawn_machine_power", "script_noteworthy" );
    
    if ( !isdefined( self.machinepower.scriptable ) )
    {
        self.machinepower.scriptable = spawnscriptable( "ztron_props_machine_power", self.machinepower.origin, self.machinepower.angles ?? ( 0, 0, 0 ) );
    }
    
    self.machinepower.scriptable setscriptablepartstate( "base", "base" );
    self.var_b6f637fd12c5c686 = utility::getstructarray( "g_spawn_explode_vfx", "script_noteworthy" );
    self.var_c9c2ae1c68f4109d = utility::getstruct( "silverback_arena_big_egg_begin_position", "targetname" );
    self.var_7238d11376a2df89 = utility::getstruct( "silverback_arena_big_egg_end_position", "targetname" );
    thread fuse_think();
    thread function_b324ed4953be1371();
    thread function_d711e07650ddbcda();
    thread g_spawn_bomb_device_explode();
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x32d4595a, Offset: 0xc67
// Size: 0x67
function silverback_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 1 )
        {
            level.ztron.var_4064026979f81a0c = &function_2d5f2aa6f4af9ccc;
        }
    }
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0x4bfcbdc4, Offset: 0xcd6
// Size: 0x37
function function_2d5f2aa6f4af9ccc( player )
{
    level utility::waittill_any_timeout( 6, "silverback_boss_fight_begin" );
    ztron_arena::roundendaward( player );
    level.ztron.var_4064026979f81a0c = undefined;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xdb050955, Offset: 0xd15
// Size: 0x22f
function silverback_arena_shutdown()
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.var_e733dbd4ae561ad5 = undefined;
    }
    
    ztron_ui::function_f5177e090dadd8f4( 0 );
    self notify( #"g_spawn_reset" );
    level notify( #"silverback_intro_done" );
    level notify( #"silverback_arena_shutdown" );
    level notify( #"slayermart_cleanup" );
    function_9ed92fa87a55881a();
    var_adde8d26347e76cc = self.intro.introstarted && !self.intro.introcompleted;
    var_adde8d26347e76cc |= self.intro.var_41010d03f1dc5419 && !self.intro.var_141ffcbbc55fb82d;
    
    if ( var_adde8d26347e76cc )
    {
        foreach ( player in level.players )
        {
            player ztron_player_utility::function_a9dd68a6d53566b0( 0 );
        }
        
        ztron_camera::function_b75a71ef33e0e6cc();
    }
    
    foreach ( tvspot in self.tvspots )
    {
        if ( isdefined( tvspot.scriptable ) )
        {
            tvspot.scriptable freescriptable();
            tvspot.scriptable = undefined;
        }
    }
    
    if ( isdefined( self.machinepower.scriptable ) )
    {
        self.machinepower.scriptable freescriptable();
        self.machinepower.scriptable = undefined;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x402fe823, Offset: 0xf4c
// Size: 0x73
function silverback_arena_challenge()
{
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "mangler_hvt" );
    level.ztron.var_37084fa69046d3b4 = 2;
    level.ztron.challenge_delay = gettime() + 15000;
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = 1;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x6a93165d, Offset: 0xfc7
// Size: 0x45
function function_27a69e93d3e28662()
{
    level.ztron.var_cd3b78b45db638d8.var_e95772ef2aa376a0 = undefined;
    level.ztron.var_cd3b78b45db638d8 = undefined;
    level.ztron.var_37084fa69046d3b4 = undefined;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x86424245, Offset: 0x1014
// Size: 0x86
function function_c3fc9c1e76e63323()
{
    time = gettime();
    
    if ( level.ztron.var_37084fa69046d3b4 > 0 && time > level.ztron.challenge_delay )
    {
        level.ztron.challenge_delay = time + 20000;
        level.ztron.var_37084fa69046d3b4--;
        return level.ztron.var_cd3b78b45db638d8;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0xc
// Checksum 0x1e856d92, Offset: 0x10a3
// Size: 0x55
function private function_9d5f2d44e3d83103()
{
    self notify( #"hash_5261992ef48788c1" );
    self endon( #"hash_5261992ef48788c1" );
    level thread ztron_arena::function_9ee2b02a6c783a7e();
    level thread ztron_arena::function_c9560777fa9a0b3();
    level thread ztron_arena::function_731f8db476a347a0();
    level utility::waittill_any( "silverback_arena_shutdown", "papaback_defeated", "ztron_game_is_over" );
    level notify( #"hash_1cf1c429bb1c9a07" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0xc
// Checksum 0xb4b58772, Offset: 0x1100
// Size: 0x76
function private function_39e32d39a03fdb9e()
{
    self notify( #"hash_b69cc5009e390936" );
    self endon( #"hash_b69cc5009e390936" );
    
    if ( getdvarint( @"hash_3b47529494ea1388", 1 ) == 1 )
    {
        level thread ztron_arena::function_8948506f3660f658();
    }
    
    level utility::waittill_any( "silverback_arena_shutdown", "papaback_defeated", "ztron_game_is_over" );
    level utility::flag_clear( "ztron_round_spawning" );
    level utility::flag_set( "ztron_round_over" );
    wait 0.1;
    level thread ztron_util::killallenemies();
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xb69c6de2, Offset: 0x117e
// Size: 0xc5f
function private silverback_papa_intro()
{
    level endon( #"silverback_arena_shutdown" );
    arena = level.ztron.active_arena;
    intro = spawnstruct();
    intro.playerslots = utility::getstructarray( "g_spawn_intro_player", "script_noteworthy" );
    intro.camera = utility::getstruct( "g_spawn_intro_camera", "script_noteworthy" );
    intro.papaback = utility::getstruct( "g_spawn_intro_papaback", "script_noteworthy" );
    arena.intro = intro;
    level notify( #"destroy_hazard_pole" );
    mapspots( arena.tvspots, &function_d3c9a89fc947224e );
    ztron_camera::function_90951f3fca05e46a( intro.camera.origin, intro.camera.angles ?? ( 0, 0, 0 ) );
    idx = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player ztron_player_utility::playerrespawnnow( 0, undefined, 0, 0 );
        }
        
        playerspot = intro.playerslots[ idx ];
        player ztron_player_utility::function_a9dd68a6d53566b0( 1, playerspot.origin, playerspot.angles, 1 );
        player.ignoreme = 1;
        idx++;
    }
    
    level thread ztron_world_event::function_ad84e488fb9e61d4();
    org = utility::spawn_model( "tag_origin", intro.papaback.origin + ( 0, 0, 1200 ), intro.papaback.angles );
    org thread ztron_util::function_36239518d8da65f0( level, "silverback_intro_done" );
    org forcenetfieldhighlod( 1 );
    org setmoverantilagged( 1 );
    intro.org = org;
    camorg = utility::spawn_model( "tag_origin", intro.camera.origin, intro.camera.angles );
    camorg thread ztron_util::function_36239518d8da65f0( level, "silverback_intro_done" );
    camorg forcenetfieldhighlod( 1 );
    camorg setmoverantilagged( 1 );
    intro.camorg = camorg;
    
    foreach ( player in level.players )
    {
        if ( player.ztron.scriptedcam )
        {
            player.ztron.scriptedcam.origin = camorg.origin;
            player.ztron.scriptedcam linkto( camorg );
            player.ztron.scriptedcam forcenetfieldhighlod( 1 );
        }
    }
    
    papaback = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "papaback" ), org.origin, undefined, undefined, 1, 1 );
    papaback notify( #"kill_think" );
    papaback forceteleport( papaback.origin, org.angles );
    papaback thread ztron_util::function_36239518d8da65f0( level, "silverback_intro_done" );
    papaback setcandamage( 0 );
    papaback.var_9f4fae59ff4e962a = 1;
    papaback linkto( org );
    papaback.introorg = org;
    papaback.stfu = 1;
    papaback.ignoreme = 1;
    arena.intro.introstarted = 1;
    arena.intro.introcompleted = 0;
    params = spawnstruct();
    params.disablelaunch = 1;
    params.hatchmanually = 1;
    arena.bigegg = level ztron_item::spawnitem( %"hash_6d23b44af54b9df0", arena.var_c9c2ae1c68f4109d.origin, 0, undefined, params );
    arena.bigegg.angles = arena.var_c9c2ae1c68f4109d.angles;
    arena.bigegg notsolid();
    playfx( utility::getfx( "lightning_b" ), papaback.origin );
    wait 1;
    playfx( utility::getfx( "lightning_strike" ), papaback.origin );
    org moveto( intro.papaback.origin, 0.5 );
    org waittill( #"movedone" );
    playfxontag( utility::getfx( "lightning_ground" ), papaback, "tag_origin" );
    playfx( utility::getfx( "papaback_intro" ), org.origin + ( 0, 0, 12 ) );
    wait 1;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_625d688753f434fa", 1 );
    wait 4;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_482ac3a2a505924c", 1 );
    wait 1;
    var_6e3e6d73096f5bd4 = 2;
    intro.papaback = utility::getstruct( intro.papaback.target, "targetname" );
    org thread utility::function_8001268940441423( org.origin, intro.papaback.origin, ( org.origin + intro.papaback.origin ) / 2 + ( 0, 0, 1500 ), var_6e3e6d73096f5bd4, 1 );
    org waittill( #"off_bezier_curve" );
    wait 1;
    var_6e3e6d73096f5bd4 = 1.5;
    intro.papaback = utility::getstruct( intro.papaback.target, "targetname" );
    org thread utility::function_8001268940441423( org.origin, intro.papaback.origin, ( org.origin + intro.papaback.origin ) / 2 + ( 0, 0, 1000 ), var_6e3e6d73096f5bd4, 1 );
    org waittill( #"off_bezier_curve" );
    wait 1;
    var_6e3e6d73096f5bd4 = 2;
    intro.camera = utility::getstruct( intro.camera.target, "targetname" );
    intro.papaback = utility::getstruct( intro.papaback.target, "targetname" );
    papaback unlink();
    papaback clearbtgoal( 1 );
    papaback ztron_enemy_ai::function_83baeab9d0850baa( intro.papaback.origin, 1, 1, -1 );
    papaback thread function_8c2954a80592e46c( intro.papaback.origin, squared( 10 ) );
    org moveto( intro.papaback.origin, var_6e3e6d73096f5bd4 );
    org rotateto( intro.papaback.angles, var_6e3e6d73096f5bd4 );
    camorg moveto( intro.camera.origin, var_6e3e6d73096f5bd4 );
    camorg rotateto( intro.camera.angles, var_6e3e6d73096f5bd4 );
    org waittill( #"movedone" );
    wait 1;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_482ac6a2a5059765", 1 );
    wait 4;
    var_6e3e6d73096f5bd4 = 1;
    intro.camera = utility::getstruct( intro.camera.target, "targetname" );
    intro.papaback = utility::getstruct( intro.papaback.target, "targetname" );
    papaback clearbtgoal( 1 );
    waitframe();
    papaback ztron_enemy_ai::function_83baeab9d0850baa( intro.papaback.origin, 1, 1, -1 );
    papaback thread function_8c2954a80592e46c( intro.papaback.origin, squared( 10 ) );
    org moveto( intro.papaback.origin, var_6e3e6d73096f5bd4 );
    org rotateto( intro.papaback.angles, var_6e3e6d73096f5bd4 );
    camorg moveto( intro.camera.origin, var_6e3e6d73096f5bd4 );
    camorg rotateto( intro.camera.angles, var_6e3e6d73096f5bd4 );
    org waittill( #"movedone" );
    arena.gspawnfire notify( #"fire_start_move" );
    wait 1;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_482ac5a2a50595b2", 1 );
    wait 4;
    arena.gspawnfire notify( #"fire_start_move" );
    intro.camera = utility::getstruct( intro.camera.target, "targetname" );
    intro.papaback = utility::getstruct( intro.papaback.target, "targetname" );
    papaback linkto( org );
    org moveto( intro.papaback.origin, var_6e3e6d73096f5bd4 );
    org rotateto( intro.papaback.angles, var_6e3e6d73096f5bd4 );
    camorg moveto( intro.camera.origin, var_6e3e6d73096f5bd4 );
    camorg rotateto( intro.camera.angles, var_6e3e6d73096f5bd4 );
    org waittill( #"movedone" );
    wait 1;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_482ac0a2a5058d33", 1 );
    wait 6;
    org moveto( org.origin + ( 0, 0, 1000 ), var_6e3e6d73096f5bd4 );
    ztron_util::function_9ecee6f38c56d30f( 1 );
    level notify( #"silverback_intro_done" );
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_a9dd68a6d53566b0( 0 );
        player.ignoreme = 0;
    }
    
    ztron_camera::function_b75a71ef33e0e6cc();
    level thread ztron_hazard::function_ed33fea23f0d8109( #"elec_pole", #"arenaspawn" );
    level ztron_camera::function_517f03fc102b896d( 1 );
    wait 1;
    level ztron_camera::function_517f03fc102b896d( 0 );
    ztron_util::function_52cbd62de5b033c9();
    arena.intro.introcompleted = 1;
}

// Namespace ztron_arena_silverback_arena
// Params 2, eflags: 0xc
// Checksum 0x2cbf8efa, Offset: 0x1de5
// Size: 0x83
function private function_8c2954a80592e46c( goto_position, distsq )
{
    self notify( #"hash_a1442eda710d6a7d" );
    self endon( #"hash_a1442eda710d6a7d" );
    self endon( #"death", #"kill_think" );
    self endon( #"near_goal_done" );
    
    while ( true )
    {
        if ( isdefined( goto_position ) && distancesquared( self.origin, goto_position ) <= distsq )
        {
            self setbtgoalstationary( 1 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x1f9fddc3, Offset: 0x1e70
// Size: 0x11
function private function_6cd2ca59c7eb4488()
{
    wait 1;
    self notify( #"hash_653b80249d1a4aa" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x92093bce, Offset: 0x1e89
// Size: 0xb97
function private silverback_arena_boss_fight()
{
    level endon( #"ztron_game_is_over", #"silverback_arena_shutdown" );
    
    if ( !isdefined( level.ztron.var_b275489e2025310b ) )
    {
        level.ztron.var_b275489e2025310b = [];
    }
    
    level.ztron.var_b275489e2025310b[ level.ztron.game_laps ] = gettime();
    level.ztron.active_arena.papaback_defeated = 0;
    level.ztron.bossround = 1;
    
    foreach ( player in level.players )
    {
        player.ztron.var_727e2da6b1dd717e = 0;
    }
    
    papabackcount = 1 + level.ztron.game_laps;
    
    /#
        overridecount = getdvarint( @"hash_f96f700e95fc183f", 0 );
        
        if ( overridecount > 0 )
        {
            papabackcount = overridecount;
        }
    #/
    
    thread function_41f2257209115985();
    ztron_sound::function_ac1e49175da7897d( "arenaEvent", "papabackSpawn", "silverback_arena" );
    
    if ( level.ztron.blitzmode )
    {
        level.ztron.var_5d66e2173c3de46f = 1;
        ztron_ui::function_37aad40e39a9fdfe( "papaback_coming" );
        ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Boss_Fight" ] );
        wait 6;
    }
    else
    {
        ztron_ui::function_37aad40e39a9fdfe( "papaback_coming" );
        ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Boss_Fight" ] );
        wait 6;
        
        if ( !level.ztron.active_arena.var_9fc9518ce94ee645 )
        {
            silverback_papa_intro();
        }
        else
        {
            level.ztron.active_arena.var_9fc9518ce94ee645 = undefined;
            level.ztron.active_arena thread function_6cd2ca59c7eb4488();
        }
    }
    
    level notify( #"silverback_boss_fight_begin" );
    thread function_39e32d39a03fdb9e();
    thread function_9d5f2d44e3d83103();
    org = utility::spawn_model( "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    org thread function_36239518d8da65f0( level, "silverback_arena_shutdown" );
    var_455c9ca2d6de30ca = level.ztron.active_arena.lootspots;
    
    if ( level.ztron.active_arena.lootspots.size > papabackcount )
    {
        var_455c9ca2d6de30ca = utility::array_random_slice( level.ztron.active_arena.lootspots, papabackcount );
    }
    
    papabackdef = ztron_enemy::function_96eea0d09d5640d1( "papaback" );
    offsetz = ( 0, 0, 2000 );
    
    for ( index = 0; index < papabackcount ; index++ )
    {
        if ( index != 0 )
        {
            wait 10;
        }
        
        spot = var_455c9ca2d6de30ca[ index % var_455c9ca2d6de30ca.size ];
        enemy = function_47c86977a18df38b( level.players, spot.origin );
        papaback = ztron_enemy::function_77e1bf43b991b4a( papabackdef, 1, spot.origin + offsetz, 0, undefined, enemy, undefined, level.ztron.active_arena, undefined, -1, 1, 1 );
        direction = enemy.origin - spot.origin;
        org.angles = vectortoangles( enemy.origin - spot.origin );
        org.origin = spot.origin + offsetz;
        
        if ( isdefined( papaback ) )
        {
            papaback notify( #"kill_think" );
            papaback.var_9f4fae59ff4e962a = 1;
            papaback.ignoreme = 1;
            papaback.stfu = 1;
            papaback.favoriteenemy = undefined;
            papaback clearenemy();
            papaback setcandamage( 0 );
            waitframe();
            papaback linkto( org );
        }
        
        org moveto( spot.origin, 1 );
        org waittill( #"movedone" );
        
        if ( papaback )
        {
            papaback unlink();
            papaback.var_9f4fae59ff4e962a = 0;
            papaback.ignoreme = 0;
            papaback.stfu = 0;
            papaback.favoriteenemy = enemy;
            papaback setcandamage( 1 );
            papaback thread namespace_4f6b9f859d8abc98::papabackthink();
            papaback.var_63c94fe1b2260b34 = 1;
            papaback.var_818c06f9a89fb0ba = 1;
            papaback callback::add( #"on_ai_killed", &function_d36ca5233bad0ed4 );
        }
        
        if ( isdefined( org ) )
        {
            playfxontag( utility::getfx( "lightningStrike" ), org, "tag_origin" );
            earthquake( 0.5, 0.75, org.origin, 1000 );
            wait 1;
            playfxontag( utility::getfx( "lightningStrike" ), org, "tag_origin" );
            earthquake( 0.5, 0.75, org.origin, 1000 );
        }
    }
    
    org delete();
    level.ztron.active_arena thread papaback_g_spawn_dialog();
    
    while ( level.ztron.papabacks.size > 0 )
    {
        wait 1;
    }
    
    level.ztron.bossround = 0;
    level notify( #"papaback_defeated" );
    level.ztron.active_arena.papaback_defeated = 1;
    level notify( #"round_over" );
    
    if ( level.ztron.blitzmode )
    {
        ztron_ui::function_ce37a481d70a78ed();
    }
    
    foreach ( player in level.players )
    {
        player ztron_achievements::function_db28e178f81942b2();
    }
    
    ztron_util::killallenemies();
    ztron_ui::function_37aad40e39a9fdfe( "papaback_defeated" );
    
    if ( level.ztron.blitzmode )
    {
        wait 2;
        room = level.ztron.active_arena;
        
        foreach ( spot in room.hazardspots )
        {
            spot notify( #"destroy_hazard" );
        }
        
        level notify( #"destroy_hazard_pole" );
        level.ztron.arena_poles = function_5713d46873b29625( level.ztron.arena_poles );
        room function_9ed92fa87a55881a();
        
        foreach ( player in level.players )
        {
            player ztron_player_utility::update_papaback_defeated( 1 );
        }
        
        level notify( #"extra_round_over" );
        function_1b866de0c5185f5a();
        
        for ( round = 0; round < 2 ; round++ )
        {
            for ( i = 0; i <= 3 ; i++ )
            {
                level thread function_13cf08b0ac9e70da();
                wait 1;
            }
            
            wait 10;
        }
        
        return;
    }
    
    ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Slayer_Victory" ] );
    wait 6.5;
    level.ztron.active_arena.bigegg thread function_fd6f81e71bf70a88();
    level ztron_util::function_9ecee6f38c56d30f( 1 );
    wait 0.5;
    room = level.ztron.active_arena;
    
    foreach ( spot in room.hazardspots )
    {
        spot notify( #"destroy_hazard" );
    }
    
    level notify( #"destroy_hazard_pole" );
    level.ztron.arena_poles = function_5713d46873b29625( level.ztron.arena_poles );
    ztron_weather::setweather( "Sunny" );
    ztron_weather::resetlightstate();
    level thread function_1cb476dccdba4292();
    room function_9ed92fa87a55881a();
    level ztron_util::function_52cbd62de5b033c9();
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        foreach ( player in level.players )
        {
            player ztron_player_utility::update_papaback_defeated( 1 );
        }
    }
    else if ( !level.ztron.var_95d8c7a469393957 )
    {
        slayermart = utility::getstruct( "silverback_arena_slayerMart", "targetname" );
        
        if ( isdefined( slayermart ) )
        {
            level thread ztron_slayer::slayer_arena_slayermart( slayermart, ( 0, 0, 0 ), 0, 0, 300 );
        }
        
        foreach ( player in level.players )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 1 );
        }
    }
    
    for ( round = 0; round < 2 ; round++ )
    {
        for ( i = 0; i <= 3 ; i++ )
        {
            level thread function_13cf08b0ac9e70da();
            wait 1;
        }
        
        wait 10;
    }
    
    level notify( #"extra_round_over" );
    function_1b866de0c5185f5a();
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x3b30a62c, Offset: 0x2a28
// Size: 0x9b
function function_1cb476dccdba4292()
{
    self notify( #"hash_747c8439c6d70d44" );
    self endon( #"hash_747c8439c6d70d44" );
    level endon( #"ztron_game_is_over", #"silverback_arena_shutdown" );
    level.ztron.no_bgb_machine = 1;
    level waittill( #"teleporter_being_opened" );
    wait 6;
    
    if ( !level.ztron.var_371903e5801e0e08 )
    {
        level.ztron.no_bgb_machine = undefined;
        level thread ztron_arena::function_9dab0d1667a2eadc( level.ztron.currentarena, 0 );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x9074ecf9, Offset: 0x2acb
// Size: 0x159
function private function_fd6f81e71bf70a88()
{
    level endon( #"ztron_game_is_over", #"silverback_arena_shutdown" );
    wait 1;
    self moveto( level.ztron.active_arena.var_7238d11376a2df89.origin + ( 0, 0, 20 ), 0.5 );
    self rotateto( self.angles + ( 0, 50, 50 ), 0.5 );
    wait 0.5;
    self physicslaunchserver( self.origin, ( 0, 0, 5 ) );
    hatchtime = randomfloatrange( 10, 12 );
    thread namespace_4e36c859ad6a5d59::function_11b925d295f56c6( hatchtime );
    self solid();
    wait hatchtime;
    level thread fireworkwatch( self.origin );
    params = spawnstruct();
    params.overridelifetime = 9999;
    params.scale = 1.5;
    
    if ( !isdefined( params.launchforce ) )
    {
        params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 100 );
    }
    
    gems = randomintrange( 12, 15 );
    ztron_item::function_d0a061baefd87906( self.origin, gems, 30, undefined, params );
}

// Namespace ztron_arena_silverback_arena
// Params 1, eflags: 0x4
// Checksum 0x38988edb, Offset: 0x2c2c
// Size: 0x11d
function private fireworkwatch( origin )
{
    level endon( #"ztron_game_is_over", #"silverback_arena_shutdown" );
    
    if ( !isdefined( origin ) )
    {
        origin = level.ztron.active_arena.var_7238d11376a2df89.origin + ( 0, 0, 20 );
    }
    
    fireworkspot = origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    playfx( utility::getfx( "ztron_egg_hatching_fireworks" ), fireworkspot );
    wait 0.5;
    fireworkspot = origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    playfx( utility::getfx( "ztron_egg_hatching_fireworks" ), fireworkspot );
    wait 0.5;
    fireworkspot = origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    playfx( utility::getfx( "ztron_egg_hatching_fireworks" ), fireworkspot );
    wait 0.5;
    fireworkspot = origin + ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    playfx( utility::getfx( "ztron_egg_hatching_fireworks" ), fireworkspot );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x544dc480, Offset: 0x2d51
// Size: 0x90
function private function_41f2257209115985()
{
    level.ztron.active_arena.var_f3d2bdcb7cafb15b = 22 + level.players.size * 4;
    ztron_enemy::function_c432c192a10985ad( "mimic" );
    ztron_enemy::function_c432c192a10985ad( "disciple" );
    ztron_enemy::function_c432c192a10985ad( "amalgam" );
    ztron_enemy::function_c432c192a10985ad( "mangler" );
    ztron_enemy::function_c432c192a10985ad( "ghoul" );
    ztron_enemy::function_c432c192a10985ad( "elder_disciple" );
    ztron_enemy::function_c432c192a10985ad( "mangler_hvt" );
    ztron_enemy::function_c432c192a10985ad( "mannequin" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x576e2ce0, Offset: 0x2de9
// Size: 0x62
function private function_1b866de0c5185f5a()
{
    ztron_enemy::function_103f4348c83c32ce( "mimic" );
    ztron_enemy::function_103f4348c83c32ce( "disciple" );
    ztron_enemy::function_103f4348c83c32ce( "amalgam" );
    ztron_enemy::function_103f4348c83c32ce( "mangler" );
    ztron_enemy::function_103f4348c83c32ce( "ghoul" );
    ztron_enemy::function_103f4348c83c32ce( "elder_disciple" );
    ztron_enemy::function_103f4348c83c32ce( "mangler_hvt" );
    ztron_enemy::function_103f4348c83c32ce( "mannequin" );
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0x7aad8e89, Offset: 0x2e53
// Size: 0x66
function function_863b1ea6b2c7cb07( notifyalert )
{
    self endon( #"stop_sound" );
    self.itemsarray = [];
    
    while ( true )
    {
        level waittill( notifyalert, item );
        self.itemsarray[ self.itemsarray.size ] = item.entity;
        item thread function_ea1ed9f7ac69333( self );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xb1362ce0, Offset: 0x2ec1
// Size: 0x179
function function_13cf08b0ac9e70da()
{
    spot = level.ztron.active_arena.lootspots[ randomint( level.ztron.active_arena.lootspots.size ) ];
    params = spawnstruct();
    params.playloopsound = 0;
    var_d37c6b2d31ac0b43 = "spotEnt" + ztron_item::getitemuniqueid();
    spotEnt = utility::spawn_model( "tag_origin", spot.origin, spot.angles );
    spotEnt thread ztron_util::function_36239518d8da65f0( level, "silverback_arena_shutdown" );
    spotEnt thread function_863b1ea6b2c7cb07( var_d37c6b2d31ac0b43 );
    
    if ( level.ztron.var_371903e5801e0e08 || level.ztron.var_95d8c7a469393957 || level.ztron.blitzmode )
    {
        function_3f033ee11f9747fc( spot.origin, 50, 128, undefined, params, var_d37c6b2d31ac0b43, level.ztron.blitzmode ? %"hash_503dd11fa661e43a" : undefined );
    }
    else
    {
        ztron_item::function_d3d82aa8c393b166( spot.origin, 50, 196, undefined, params, var_d37c6b2d31ac0b43 );
    }
    
    spotEnt thread function_95d52686c6241b86();
    ztron_sound::ztron_playsound( "ztron_pickup_money_lp", undefined, spotEnt );
}

// Namespace ztron_arena_silverback_arena
// Params 7, eflags: 0x4
// Checksum 0x219a2ece, Offset: 0x3042
// Size: 0x101
function private function_3f033ee11f9747fc( origin, numitems, offset = 256, spawnoptions = undefined, params = undefined, notifyalert, spawnlist = %"hash_3d72707d65e0f392" )
{
    spawnoptions = ztron_item::function_41854e96b8bf4a06( origin );
    itemnames = common_item::items_selectfromlist( spawnlist, numitems );
    
    foreach ( itemname in itemnames )
    {
        ztron_item::requestspawnitem( itemname, origin, offset, spawnoptions, params, notifyalert );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xf4cdd3ad, Offset: 0x314b
// Size: 0x15
function function_95d52686c6241b86()
{
    self waittill( #"stop_sound" );
    self delete();
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0x682c325d, Offset: 0x3168
// Size: 0x98
function function_ea1ed9f7ac69333( spotEnt )
{
    spotEnt endon( #"stop_sound", #"death" );
    utility::waittill_any( "picked_up", "death" );
    spotEnt.itemsarray = arrayremove( spotEnt.itemsarray, self );
    spotEnt.itemsarray = function_5713d46873b29625( spotEnt.itemsarray );
    
    if ( isdefined( spotEnt ) && spotEnt.itemsarray.size == 0 )
    {
        ztron_sound::ztron_stopsound( spotEnt );
        spotEnt notify( #"stop_sound" );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0x64e150a2, Offset: 0x3208
// Size: 0x2d
function function_d36ca5233bad0ed4( params )
{
    origin = self.origin;
    level thread ztron_item::function_d0a061baefd87906( origin, 20 );
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0xcb96e0fd, Offset: 0x323d
// Size: 0x98
function function_1e2909fbd10e3457( var_e1acf5dd2f719b25 )
{
    ents = [];
    
    foreach ( ent in var_e1acf5dd2f719b25 )
    {
        if ( isdefined( ent.targetdevice ) )
        {
            ents[ ents.size ] = ent;
        }
    }
    
    return ents;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xee1ef772, Offset: 0x32de
// Size: 0x263
function function_b324ed4953be1371()
{
    self endon( #"g_spawn_reset" );
    
    while ( true )
    {
        platform = self.var_fb6e02d4a97fd296;
        var_c5142e0d1342bef0 = self.var_9c7bedc6374fb288;
        fire = self.gspawnfire;
        
        if ( !( isdefined( platform ) && isdefined( var_c5142e0d1342bef0 ) ) || platform.rotdone || var_c5142e0d1342bef0.ismoving )
        {
            wait 0.1;
            continue;
        }
        
        /#
            if ( platform.var_b8bfcbd68a9116d0 )
            {
                if ( !isdefined( platform.var_7a34b56aab7fde9c ) )
                {
                    platform.var_7a34b56aab7fde9c = platform.rotspeed;
                }
                
                platform.rotspeed = platform.var_7a34b56aab7fde9c * 20;
            }
            else
            {
                platform.rotspeed = platform.var_7a34b56aab7fde9c ?? platform.rotspeed;
            }
        #/
        
        if ( platform.var_3549aec585a41b8a )
        {
            platformangles = platform.model.angles;
            fireangles = fire.model.angles;
            srcyaw = platformangles[ 1 ];
            maxyaw = platform.maxyaw;
            diffyaw = platform.rotspeed * level.framedurationseconds;
            remainyaw = maxyaw - srcyaw;
            rotdone = 0;
            
            if ( abs( diffyaw ) > abs( remainyaw ) )
            {
                rotdone = 1;
                diffyaw = remainyaw;
                dstyaw = maxyaw;
            }
            else
            {
                dstyaw = srcyaw + diffyaw;
            }
            
            platform.model rotateto( ( platformangles[ 0 ], dstyaw, platformangles[ 2 ] ), level.framedurationseconds );
            fire.model rotateto( ( fireangles[ 0 ], fireangles[ 1 ] + diffyaw, fireangles[ 2 ] ), level.framedurationseconds );
            platform.model waittill( #"rotatedone" );
            
            if ( rotdone )
            {
                platform.rotdone = 1;
                platform.var_3549aec585a41b8a = 0;
                self notify( #"hash_da5720c4cbf8509" );
            }
            
            continue;
        }
        
        waitframe();
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xf722919e, Offset: 0x3549
// Size: 0x12c
function private papaback_g_spawn_dialog()
{
    level endon( #"papaback_defeated", #"ztron_game_is_over", #"silverback_arena_shutdown" );
    self endon( #"g_spawn_reset", #"hash_653b80249d1a4aa" );
    var_ba2284343363a180 = 0;
    
    while ( level.ztron.papabacks.size > 0 && var_ba2284343363a180 < 2 )
    {
        self waittill( #"hash_da5720c4cbf8509" );
        var_ba2284343363a180++;
        
        foreach ( papaback in level.ztron.papabacks )
        {
            if ( var_ba2284343363a180 == 1 )
            {
                papaback ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "papaback_g_spawn_1" ) );
                continue;
            }
            
            if ( var_ba2284343363a180 == 2 )
            {
                papaback ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "papaback_g_spawn_2" ) );
                continue;
            }
            
            break;
        }
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xa8f58c6c, Offset: 0x367d
// Size: 0x100
function function_d711e07650ddbcda()
{
    self endon( #"g_spawn_reset" );
    
    while ( true )
    {
        platform = self.var_fb6e02d4a97fd296;
        var_c5142e0d1342bef0 = self.var_9c7bedc6374fb288;
        
        if ( !( isdefined( var_c5142e0d1342bef0 ) && isdefined( platform ) ) || platform.rotdone || var_c5142e0d1342bef0.ismoving )
        {
            wait 0.1;
            continue;
        }
        
        var_e1acf5dd2f719b25 = getentarrayinradius( undefined, undefined, var_c5142e0d1342bef0.origin, var_c5142e0d1342bef0.radius );
        var_e1acf5dd2f719b25 = function_1e2909fbd10e3457( var_e1acf5dd2f719b25 );
        
        if ( var_e1acf5dd2f719b25.size > 0 )
        {
            self.var_fb6e02d4a97fd296.var_3549aec585a41b8a = 1;
        }
        else
        {
            self.var_fb6e02d4a97fd296.var_3549aec585a41b8a = 0;
        }
        
        /#
            if ( platform.var_b8bfcbd68a9116d0 )
            {
                self.var_fb6e02d4a97fd296.var_3549aec585a41b8a = 1;
            }
        #/
        
        waitframe();
    }
}

// Namespace ztron_arena_silverback_arena
// Params 2, eflags: 0x4
// Checksum 0x80232fa6, Offset: 0x3785
// Size: 0xb6
function private function_b131706f90346baf( targetorg, speed = undefined )
{
    dist = distance( self.model.origin, targetorg );
    speed = speed ?? self.speed;
    movetime = dist / speed;
    assert( movetime >= 0 );
    
    if ( movetime > level.framedurationseconds )
    {
        self.model moveto( targetorg, movetime );
        self.ismoving = 1;
        self.model waittill( #"movedone" );
        self.ismoving = 0;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x67a8ff09, Offset: 0x3843
// Size: 0xcf, Type: bool
function private function_42740e2637c63c52()
{
    platform = self.var_fb6e02d4a97fd296;
    var_c5142e0d1342bef0 = self.var_9c7bedc6374fb288;
    
    if ( isdefined( platform.target ) )
    {
        var_ce354c2547ad43c7 = utility::getstruct( platform.target, "targetname" );
    }
    
    if ( isdefined( var_c5142e0d1342bef0.target ) )
    {
        var_b5140ad95613bf4d = utility::getstruct( var_c5142e0d1342bef0.target, "targetname" );
    }
    
    self.var_fb6e02d4a97fd296 = var_ce354c2547ad43c7;
    self.var_9c7bedc6374fb288 = var_b5140ad95613bf4d;
    
    if ( !( isdefined( var_ce354c2547ad43c7 ) && isdefined( var_b5140ad95613bf4d ) ) )
    {
        return false;
    }
    
    self.var_fb6e02d4a97fd296 function_c762c4192a2c1345();
    self.var_9c7bedc6374fb288 function_6868b02c376c0013();
    return true;
}

// Namespace ztron_arena_silverback_arena
// Params 2, eflags: 0x4
// Checksum 0x2bc575da, Offset: 0x391b
// Size: 0x84
function private mapspots( spots, mapfunc )
{
    foreach ( spot in spots )
    {
        spot thread [[ mapfunc ]]();
    }
}

// Namespace ztron_arena_silverback_arena
// Params 1, eflags: 0x4
// Checksum 0x1c1a299d, Offset: 0x39a7
// Size: 0x5e
function private resetspots( resetfunc )
{
    for ( spot = self; isdefined( spot ) ; spot = nextspot )
    {
        spot [[ resetfunc ]]();
        nextspot = undefined;
        
        if ( isdefined( spot.target ) )
        {
            nextspot = utility::getstruct( spot.target, "targetname" );
        }
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xfdd66e5f, Offset: 0x3a0d
// Size: 0x27
function private function_d3c9a89fc947224e()
{
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable setscriptablepartstate( "screen", "on" );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x28b7b4a0, Offset: 0x3a3c
// Size: 0x27
function private gspawntv()
{
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable setscriptablepartstate( "screen", "g_spawn" );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x7b80bcab, Offset: 0x3a6b
// Size: 0x27
function private dmgtv()
{
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable setscriptablepartstate( "screen", "dmg" );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x2e4a47cc, Offset: 0x3a9a
// Size: 0x4a
function private resettv()
{
    if ( !isdefined( self.scriptable ) )
    {
        self.scriptable = spawnscriptable( "ztron_props_tv_01", self.origin, self.angles );
    }
    
    self.scriptable setscriptablepartstate( "screen", "off" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xb9e7f503, Offset: 0x3aec
// Size: 0xb
function private function_dc633df4ff5ffb08()
{
    return self.ismoving;
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xd9417783, Offset: 0x3b00
// Size: 0xb
function private function_86b2f8d35fe798c5()
{
    return self.var_3549aec585a41b8a;
}

// Namespace ztron_arena_silverback_arena
// Params 2, eflags: 0xc
// Checksum 0xd6e61858, Offset: 0x3b14
// Size: 0xb2
function private soundstate( statefunc, soundaliasloop )
{
    self notify( #"hash_98cb9aad23309c6f" );
    self endon( #"hash_98cb9aad23309c6f" );
    
    if ( !isdefined( self.model ) )
    {
        return;
    }
    
    self.model endon( #"death" );
    state = undefined;
    
    while ( true )
    {
        newstate = self [[ statefunc ]]();
        
        if ( isdefined( newstate ) && newstate != state )
        {
            state = newstate;
            
            if ( state )
            {
                ztron_sound::ztron_playsound( soundaliasloop, undefined, self.model );
            }
            else
            {
                ztron_sound::ztron_stopsound( self.model );
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x2ac687ad, Offset: 0x3bce
// Size: 0xf5
function private function_b9a2910a049c5d11()
{
    self.speed = 100;
    self.radius = 5;
    self.ismoving = 0;
    
    if ( !self.model )
    {
        self.model = utility::spawn_model( "sat_zm_train_gear_tnt", self.origin, self.angles ?? ( 0, 0, 0 ) );
        thread soundstate( &function_dc633df4ff5ffb08, "ztron_cart_moving_loop" );
        self.model function_36239518d8da65f0( level, "silverback_arena_shutdown" );
        self.model hide();
        return;
    }
    
    self.model.origin = self.origin;
    self.model.angles = self.angles ?? ( 0, 0, 0 );
    self.model hide();
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xb4fe8a3e, Offset: 0x3ccb
// Size: 0x15a
function private function_c762c4192a2c1345()
{
    self.rotdone = 0;
    self.var_3549aec585a41b8a = 0;
    self.rotspeed = 17;
    self.radius = 64;
    
    /#
        self.var_b8bfcbd68a9116d0 = 0;
    #/
    
    args = strtok( self.script_noteworthy, ";" );
    self.maxyaw = int( args[ 0 ] );
    self.duration = float( args[ 1 ] ?? 10 );
    diffyaw = self.maxyaw - self.angles[ 1 ];
    
    if ( self.duration != 0 )
    {
        self.rotspeed = diffyaw / self.duration;
    }
    
    if ( !self.model )
    {
        self.model = utility::spawn_model( "sat_zm_train_gear", self.origin, self.angles ?? ( 0, 0, 0 ) );
        thread soundstate( &function_86b2f8d35fe798c5, "ztron_platform_rotation_loop" );
        self.model function_36239518d8da65f0( level, "silverback_arena_shutdown" );
        return;
    }
    
    self.model.angles = self.angles ?? ( 0, 0, 0 );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x36126b0d, Offset: 0x3e2d
// Size: 0xb2
function private function_74607a4025ee0755()
{
    if ( !isdefined( self.objectiveindex ) )
    {
        objectiveindex = objidpoolmanager::requestobjectiveid();
        objectiveicon = "ui_icon_ztron_question_mark";
        
        if ( objectiveindex != -1 )
        {
            origin = self.var_fb6e02d4a97fd296.origin + ( 0, 0, 64 );
            objidpoolmanager::objective_add_objective( objectiveindex, "current", origin, objectiveicon );
            objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
            objidpoolmanager::objective_set_play_intro( objectiveindex, 0 );
            objidpoolmanager::objective_set_play_outro( objectiveindex, 0 );
            objidpoolmanager::objective_playermask_showtoall( objectiveindex );
            objidpoolmanager::objective_showdistance( objectiveindex, 0 );
        }
        
        self.objectiveindex = objectiveindex;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x5d7b9e06, Offset: 0x3ee7
// Size: 0x29
function private function_9ed92fa87a55881a()
{
    if ( isdefined( self.objectiveindex ) )
    {
        objidpoolmanager::returnobjectiveid( self.objectiveindex );
        self.objectiveindex = undefined;
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0xd7b23107, Offset: 0x3f18
// Size: 0xbb
function private function_6868b02c376c0013()
{
    self.radius = 32;
    self.speed = 10;
    self.undergroundorigin = self.origin + ( 0, 0, -20 );
    self.ismoving = 0;
    
    if ( !self.model )
    {
        self.model = utility::spawn_model( "sat_zm_ztron_props_treasure_chest_small_02_base", self.undergroundorigin, self.angles ?? ( 0, 0, 0 ) );
        self.model function_36239518d8da65f0( level, "silverback_arena_shutdown" );
        return;
    }
    
    self.model.origin = self.undergroundorigin;
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x856553e2, Offset: 0x3fdb
// Size: 0x173
function private fuse_think()
{
    self endon( #"g_spawn_reset" );
    fire = self.gspawnfire;
    fire waittill( #"fire_start_move" );
    fire.model show();
    fire function_b131706f90346baf( self.var_3f5f6ae3e1c65020.origin, 200 );
    fire waittill( #"fire_start_move" );
    
    while ( true )
    {
        fire function_b131706f90346baf( self.var_fb6e02d4a97fd296.origin, self.speed );
        self.var_9c7bedc6374fb288 function_b131706f90346baf( self.var_9c7bedc6374fb288.origin );
        ztron_sound::ztron_playsound( "ztron_platform_trigger_activated_oneshot", self.var_9c7bedc6374fb288.origin );
        function_74607a4025ee0755();
        
        while ( !self.var_fb6e02d4a97fd296.rotdone )
        {
            waitframe();
        }
        
        function_9ed92fa87a55881a();
        self.var_9c7bedc6374fb288 thread function_b131706f90346baf( self.var_9c7bedc6374fb288.undergroundorigin );
        success = function_42740e2637c63c52();
        
        if ( !success )
        {
            self.var_fb6e02d4a97fd296 = undefined;
            break;
        }
    }
    
    fire function_b131706f90346baf( self.var_9cac20d45c392c34.origin );
    self notify( #"hash_653b80249d1a4aa" );
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x37f40602, Offset: 0x4156
// Size: 0xe1
function private watchpapaback()
{
    self endon( #"g_spawn_reset" );
    
    while ( true )
    {
        if ( level.ztron.papabacks.size > 0 )
        {
            foreach ( papaback in level.ztron.papabacks )
            {
                if ( !papaback.var_9f4fae59ff4e962a )
                {
                    self notify( #"fire_start_move" );
                }
            }
        }
        
        waitframe();
    }
    
    self waittill( #"movedone" );
    wait 5;
    self notify( #"fire_start_move" );
}

// Namespace ztron_arena_silverback_arena
// Params 1, eflags: 0x4
// Checksum 0x69021964, Offset: 0x423f
// Size: 0x102
function private function_4dfe5e6ed63ab168( room )
{
    ztron_dialog::function_7e3f6329d9afcdc1( #"papaback_g_spawn_cutscene", 1 );
    alivezombies = [];
    
    foreach ( spot in room.var_528b6c08413c7b25 )
    {
        if ( isdefined( spot.zombie ) )
        {
            alivezombies[ alivezombies.size ] = spot.zombie;
        }
    }
    
    var_7a3ad8d868e10599 = utility::array_random( alivezombies );
    
    if ( isdefined( var_7a3ad8d868e10599 ) )
    {
        var_7a3ad8d868e10599 ztron_dialog::function_7e3f6329d9afcdc1( #"papaback_g_spawn_cutscene_zombie", 1 );
    }
    
    if ( randomint( 100 ) == 0 )
    {
        ztron_dialog::function_7e3f6329d9afcdc1( #"hash_a91805b5ce7bcbee" );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0xc
// Checksum 0x7d555acc, Offset: 0x4349
// Size: 0xa71
function private g_spawn_bomb_device_explode()
{
    self notify( #"hash_aa790e405c8ea623" );
    self endon( #"hash_aa790e405c8ea623" );
    self endon( #"g_spawn_reset" );
    self waittill( #"hash_653b80249d1a4aa" );
    
    if ( getdvarint( @"hash_152669ad017e3da5", 0 ) )
    {
        return;
    }
    
    foreach ( papaback in level.ztron.papabacks )
    {
        papaback.var_9f4fae59ff4e962a = 1;
    }
    
    var_582f00ab9ff2409c = 1;
    
    while ( var_582f00ab9ff2409c )
    {
        var_582f00ab9ff2409c = 0;
        
        foreach ( papaback in level.ztron.papabacks )
        {
            if ( isdefined( papaback.specialattack ) )
            {
                var_582f00ab9ff2409c = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    if ( level.ztron.papabacks.size == 0 )
    {
        return;
    }
    
    level utility::flag_set( "ztron_round_paused" );
    level notify( #"hash_1cf1c429bb1c9a07" );
    
    if ( !isdefined( self.intro ) )
    {
        self.intro = spawnstruct();
    }
    
    intro = self.intro;
    intro.var_41010d03f1dc5419 = 1;
    intro.var_141ffcbbc55fb82d = 0;
    intro.cutscenecamera = utility::getstruct( "g_spawn_cutscene_camera", "script_noteworthy" );
    intro.cutscenepapaback = utility::getstruct( "g_spawn_cutscene_papaback", "script_noteworthy" );
    ztron_camera::function_90951f3fca05e46a( intro.cutscenecamera.origin, intro.cutscenecamera.angles ?? ( 0, 0, 0 ) );
    idx = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player ztron_player_utility::playerrespawnnow( 0, undefined, 0, 0 );
        }
        
        player ztron_player_utility::function_a9dd68a6d53566b0( 1, player.origin, player.angles, 1 );
        player.ignoreme = 1;
        idx++;
    }
    
    level notify( #"destroy_hazard_pole" );
    level thread ztron_world_event::function_c172adbbf64d3c04();
    
    foreach ( papaback in level.ztron.papabacks )
    {
        papaback notify( #"kill_think" );
        papaback.ispapaback = 1;
        papaback setcandamage( 0 );
        papaback.stfu = 1;
        papaback.ignoreme = 1;
        papaback clearenemy();
        papaback.favoriteenemy = undefined;
    }
    
    foreach ( spot in self.var_528b6c08413c7b25 )
    {
        thread function_70f81072e01ba4f0( spot );
    }
    
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        zombie setbtgoalstationary( 1 );
    }
    
    waitframe();
    papabackactor = level.ztron.papabacks[ 0 ];
    playeractor = level.players[ 0 ];
    org = utility::spawn_model( "tag_origin", intro.cutscenepapaback.origin + ( 0, 0, 2000 ), intro.cutscenepapaback.angles );
    org.papabackorigin = papabackactor.origin;
    org thread ztron_util::function_36239518d8da65f0( level, "silverback_cutscene_done" );
    org forcenetfieldhighlod( 1 );
    org setmoverantilagged( 1 );
    papabackactor linkto( org );
    var_6e3e6d73096f5bd4 = 2;
    org moveto( intro.cutscenepapaback.origin, var_6e3e6d73096f5bd4 );
    org rotateto( intro.cutscenepapaback.angles, var_6e3e6d73096f5bd4 );
    org waittill( #"movedone" );
    papabackactor unlink();
    papabackactor forceteleport( org.origin, ( 0, 0, 0 ) );
    mapspots( self.tvspots, &gspawntv );
    wait 1;
    papabackactor function_4dfe5e6ed63ab168( self );
    wait 4;
    mapspots( self.tvspots, &dmgtv );
    
    if ( self.var_b6f637fd12c5c686.size > 0 )
    {
        ztron_sound::ztron_playsound( "nuke_explo_OS", self.var_9cac20d45c392c34.origin );
        
        foreach ( vfx in self.var_b6f637fd12c5c686 )
        {
            playfx( utility::getfx( "ztron_nuke" ), vfx.origin );
        }
    }
    
    if ( isdefined( self.machinepower.scriptable ) )
    {
        self.machinepower.scriptable setscriptablepartstate( "base", "dmg" );
    }
    
    waitframe();
    playeractor thread namespace_a6a7fe92789f4ad9::deploynuke( papabackactor.origin, 0 );
    wait 2;
    ztron_util::function_9ecee6f38c56d30f( 1 );
    level utility::flag_clear( "ztron_round_paused" );
    thread function_9d5f2d44e3d83103();
    
    foreach ( papaback in level.ztron.papabacks )
    {
        halfhealth = int( papaback.maxhealth / 2 );
        
        if ( papaback.health < halfhealth )
        {
            papaback.health = halfhealth;
        }
        
        papaback clearbtgoal( 1 );
        papaback setcandamage( 1 );
        papaback.var_9f4fae59ff4e962a = 0;
        papaback.stfu = 0;
        papaback.ignoreme = 0;
        papaback thread namespace_4f6b9f859d8abc98::papabackthink();
    }
    
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        zombie clearbtgoal( 1 );
    }
    
    waitframe();
    
    foreach ( papaback in level.ztron.papabacks )
    {
        papaback notify( #"papaback_berserk_triggered" );
    }
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_a9dd68a6d53566b0( 0 );
        player.ignoreme = 0;
    }
    
    ztron_camera::function_b75a71ef33e0e6cc();
    level thread ztron_hazard::function_ed33fea23f0d8109( #"elec_pole", #"arenaspawn" );
    level ztron_camera::function_517f03fc102b896d( 1 );
    wait 1;
    level ztron_camera::function_517f03fc102b896d( 0 );
    ztron_util::function_52cbd62de5b033c9();
    level notify( #"silverback_cutscene_done" );
    self.intro.var_141ffcbbc55fb82d = 1;
}

// Namespace ztron_arena_silverback_arena
// Params 1, eflags: 0x4
// Checksum 0x28c29260, Offset: 0x4dc2
// Size: 0x7b
function private function_70f81072e01ba4f0( spot )
{
    zombie = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "basic_zombie" ), spot.origin, undefined, undefined, 1, 1 );
    
    if ( isdefined( zombie ) )
    {
        spot.zombie = zombie;
        zombie thread function_36239518d8da65f0( level, "silverback_cutscene_done" );
        waitframe();
        zombie forceteleport( spot.origin, spot.angles );
    }
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x6ae23093, Offset: 0x4e45
// Size: 0x1f
function get_current_rotation_device()
{
    return level.ztron.active_arena.var_9c7bedc6374fb288;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0xf39f3bfa, Offset: 0x4e6d
// Size: 0x1f
function function_2ced03c47701383()
{
    return level.ztron.active_arena.var_fb6e02d4a97fd296;
}

// Namespace ztron_arena_silverback_arena
// Params 0
// Checksum 0x6430fca5, Offset: 0x4e95
// Size: 0x1f
function get_current_fuse()
{
    return level.ztron.active_arena.gspawnfire;
}

// Namespace ztron_arena_silverback_arena
// Params 0, eflags: 0x4
// Checksum 0x5dbb85d2, Offset: 0x4ebd
// Size: 0xd8
function private function_732a771cea5f8730()
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"waiting_on_arena_completed" );
    
    if ( level.ztron.active_arena.papaback_defeated && !level.ztron.var_371903e5801e0e08 && !( getdvarint( @"hash_3da4a2c69a4d44d1", 0 ) == 1 ) )
    {
        level notify( #"kill_bgb_machine" );
        ztron_ui::function_e871c2190f0db007( "sat_ztron_outro", 0, undefined, 1 );
        level utility::waittill_notify_or_timeout( "bink_complete", 30 );
        ztron_ui::function_bddb5fe817c432f1();
    }
    
    if ( level.ztron.var_371903e5801e0e08 )
    {
        thread ztron_main::endgame( ztron_util::function_aff0434b226c0f6d(), game[ "end_reason" ][ "mp_faction_success" ] );
        return;
    }
    
    level notify( #"hash_18198cb75d8aea2e" );
}

// Namespace ztron_arena_silverback_arena
// Params 1
// Checksum 0xc3101b39, Offset: 0x4f9d
// Size: 0x3a4
function function_89309da58cd456d7( arenaid )
{
    level.ztron.var_7bccdb18d1ded9f2 = 1;
    
    foreach ( player in level.players )
    {
        player.ztron.blitzmode.var_f46ce1edc06a1312++;
    }
    
    wait 8;
    
    if ( level.ztron.metaenabled && level.ztron.var_7bccdb18d1ded9f2 )
    {
        if ( isdefined( level.ztron.meta ) )
        {
            level.ztron.meta.papabackdefeated = 1;
        }
        
        level namespace_4f98d1d7dc3196d::function_f7216127c5e1d966( 1 );
    }
    
    wait 7;
    
    foreach ( player in level.players )
    {
        player ztron_ui::function_787d89891b886acf( "META_SCOREBOARD_HINT", 60, 1 );
    }
    
    wait 15;
    level.ztron.var_d0972e445894306d = 300;
    level ztron_arena::function_f6b0233f60da3e6e();
    level thread ztron_arena::openteleporter( arenaid );
    ztron_ui::function_2a3f45a4f0ab93b6( 300 );
    msg = level utility::waittill_any_timeout( 300, "ztron_teleporter_taken" );
    ztron_ui::function_f6f4dd304ac8569b();
    
    if ( msg == "timeout" )
    {
        level notify( #"ztron_teleporter_taken" );
    }
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_7f458cb3544acb6b();
    }
    
    setomnvar( "ui_ztron_blitz_victory", 1 );
    
    foreach ( player in level.players )
    {
        breakdown = player ztron_ui::function_3579c3e1cfd9f4ba( 1 );
        player ztron_ui::function_7716b71d0d232366();
    }
    
    wait 25;
    
    foreach ( player in level.players )
    {
        player ztron_ui::function_ccc4f097446d1043();
    }
    
    ztron_util::function_9ecee6f38c56d30f( 1 );
    ztron_util::killallenemies();
    thread ztron_main::endgame( "tie", game[ "end_reason" ][ "mp_faction_success" ] );
}

/#

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0xab598274, Offset: 0x534a
    // Size: 0x86, Type: dev
    function private init_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x44>", "<dev string:x52>", &function_99a76bb95b5d36d3 );
        devgui::add_devgui_func( "<dev string:x66>", "<dev string:x77>", &function_15f7228aaf0603a0 );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:xa3>", &function_cf4559eea199ed8c );
        devgui::add_devgui_func( "<dev string:xb7>", "<dev string:xcb>", &function_55e20a64d6920ad0 );
        devgui::add_devgui_func( "<dev string:xde>", "<dev string:xfd>", &function_13bfebe0217d1597 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0x6a6caa5e, Offset: 0x53d8
    // Size: 0x50, Type: dev
    function private function_99a76bb95b5d36d3()
    {
        arena = level.ztron.active_arena;
        
        if ( isdefined( arena.gspawnfire ) )
        {
            function_55e20a64d6920ad0();
            arena notify( #"g_spawn_reset" );
            arena thread function_c1f5ec028690cd9f();
        }
    }

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0x37294e2c, Offset: 0x5430
    // Size: 0x49, Type: dev
    function private function_15f7228aaf0603a0()
    {
        arena = level.ztron.active_arena;
        
        if ( isdefined( arena.gspawnfire ) )
        {
            arena.gspawnfire notify( #"fire_start_move" );
        }
    }

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0x144c7b28, Offset: 0x5481
    // Size: 0x6c, Type: dev
    function private function_cf4559eea199ed8c()
    {
        arena = level.ztron.active_arena;
        platform = arena.var_fb6e02d4a97fd296;
        fire = arena.gspawnfire;
        
        if ( isdefined( platform ) )
        {
            platform.var_b8bfcbd68a9116d0 = !platform.var_b8bfcbd68a9116d0;
        }
    }

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0x465e9e8a, Offset: 0x54f5
    // Size: 0x73, Type: dev
    function private function_55e20a64d6920ad0()
    {
        arena = level.ztron.active_arena;
        arena.var_fb6e02d4a97fd296 = utility::getstruct( arena.var_3f5f6ae3e1c65020.target, "<dev string:x11b>" );
        platform = arena.var_fb6e02d4a97fd296;
        platform resetspots( &function_c762c4192a2c1345 );
    }

    // Namespace ztron_arena_silverback_arena
    // Params 0, eflags: 0x4
    // Checksum 0xf8e6e9da, Offset: 0x5570
    // Size: 0x47, Type: dev
    function private function_13bfebe0217d1597()
    {
        for ( round = 0; round < 2 ; round++ )
        {
            for ( i = 0; i <= 3 ; i++ )
            {
                level thread function_13cf08b0ac9e70da();
                wait 1;
            }
            
            wait 10;
        }
    }

#/
