// script_68cb2933c7ed5348  (hash_68cb2933c7ed5348.gscc) (size: 12688 Bytes / 0x3190 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab9088f2 (2878376178)
// size ...... 12688 (0x3190)
// includes .. 16  (offset: 0x2e30)
// strings ... 38  (offset: 0x2eb0)
// dev strs .. 11  (offset: 0x310c)
// exports ... 33  (offset: 0x1ca0)
// cseg ...... 0x378 + 0x1928 (0x1ca0)
// imports ... 106 (offset: 0x21c8)
// animtree1 . 0   (offset: 0x3190)
// animtree2 . 0   (offset: 0x3190)
#using script_359c9cda9983c8fc;
#using script_36f4df0af71365fa;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_challenge;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_arena_ritual;

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x5
// Checksum 0xe695eb92, Offset: 0x396
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"Ritual", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0xeaf6ae48, Offset: 0x3b7
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0x563246ad, Offset: 0x3c8
// Size: 0x39
function arena_init_internal()
{
    waittillframeend();
    
    /#
        thread init_devgui();
    #/
    
    ztron_arena::function_c61881897b87656d( "ritual", &ritual_init, &ritual_shutdown );
    ztron_challenge::registerchallenge( "ritual", "ritual", &ritual_challenge );
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0xb08cfe8d, Offset: 0x409
// Size: 0xc3
function ritual_init()
{
    ztron_weather::function_c66678f1a8379c69( "ritual", "Wetness", 10, "round_about_to_start" );
    ztron_enemy::function_35cd7cda9fbadf39( "riser_zombie", "ztron_difficulty_new_ai_riser_zombie" );
    
    if ( level.ztron.game_laps == 0 && !level.ztron.blitzmode )
    {
        level.ztron.active_arena.var_7b32fe236a1111ab = &function_8a9f54d6f36ee686;
        thread ritualteleporter();
        level.ztron.var_e733dbd4ae561ad5 = "arena_complete_drop_to_fate";
        level.ztron.var_f845f668cc11904f = 1;
        level thread ritual_special_event();
    }
    
    thread function_8a3c383deb683417();
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0x82b22523, Offset: 0x4d4
// Size: 0x98
function ritual_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 2 && !level.ztron.var_95d8c7a469393957 )
        {
            ztron_bonus_room::function_b018ee630661e155( ztron_bonus_room::function_cc95fac45228eccd() );
        }
        
        if ( level.ztron.arena_rounds_left == 1 )
        {
            ztron_bonus_room::function_b018ee630661e155( "fate" );
        }
    }
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0x77ba6f30, Offset: 0x574
// Size: 0x66
function ritual_shutdown()
{
    if ( level.ztron.game_laps == 0 )
    {
        function_28a6f701a3bda144();
        level.ztron.var_e733dbd4ae561ad5 = undefined;
        level utility::flag_clear( "arena_hold_teleporter" );
        return;
    }
    
    arena = ztron_arena::function_973956bb5a6e60f7( "lava_cave" );
    arena.var_bbb74b6dde0dc6bd = undefined;
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0x7172224e, Offset: 0x5e2
// Size: 0x3f
function function_8a9f54d6f36ee686()
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"waiting_on_arena_completed" );
    
    if ( ztron_bonus_room::try_activate_bonus_room( undefined, 0 ) )
    {
        level waittill( #"bonus_room_completed" );
    }
    
    level notify( #"hash_18198cb75d8aea2e" );
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0xc
// Checksum 0xf21f55d9, Offset: 0x629
// Size: 0x64
function private function_3114b0747117e984()
{
    self notify( #"hash_6c3aba6f0cd9ef3c" );
    self endon( #"hash_6c3aba6f0cd9ef3c" );
    level utility::waittill_any( "ztron_teleporter_taken", "waiting_on_arena_completed", "arena_completed", "ztron_game_is_over" );
    trigger = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_trigger", #targetname );
    
    if ( trigger )
    {
        trigger thread ztron_arena::function_73f90694864f2eae();
    }
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x6edd9475, Offset: 0x695
// Size: 0x268
function private ritualteleporter()
{
    level endon( #"ztron_teleporter_taken", #"waiting_on_arena_completed", #"arena_completed", #"ztron_game_is_over" );
    trigger = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_trigger", #targetname );
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    thread function_3114b0747117e984();
    level waittill( #"hash_824e1ffce3b44832" );
    level notify( #"kill_teleporter" );
    level utility::flag_set( "arena_hold_teleporter" );
    function_3a1a354d1c77da58();
    trigger thread ztron_arena::function_58e6a12ecfe3c747( "tag_origin", "ztron_arena_exit", "ui_hud_ztron_icon_round_exit", trigger.origin );
    level utility::flag_clear( "arena_hold_teleporter" );
    level notify( #"teleporter_spawned" );
    trigger waittill( #"trigger", player );
    triggerplayer = player;
    
    foreach ( player in level.players )
    {
        player notify( #"ztron_player_dump_vehicle" );
    }
    
    waitframe();
    origin = trigger.origin;
    
    foreach ( player in level.players )
    {
        var_4f958026b93b4d8f = player === triggerplayer;
        
        if ( !var_4f958026b93b4d8f )
        {
            if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
            {
                player ztron_player_utility::playerrespawnnow();
            }
            
            player ztron_camera::function_9fbc0b40b3c0f437( 1 );
            player ztron_util::teleport_player( origin, player.angles );
            wait 0.1;
            player ztron_camera::function_9fbc0b40b3c0f437( 0 );
        }
        
        player thread function_636fa0ee2db66876();
    }
    
    trigger thread ztron_arena::function_73f90694864f2eae();
    wait 2;
    level notify( #"ztron_teleporter_taken" );
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0xd3b7f3aa, Offset: 0x905
// Size: 0xa7
function function_636fa0ee2db66876()
{
    self notify( #"hash_c81e2fca5b3aed5f" );
    self endon( #"hash_c81e2fca5b3aed5f" );
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    ztron_util::fade_out( 0, 0, 1 );
    thread ztron_player_utility::turnPlayerShieldOn( 0 );
    val::set( "ztron_arena_ritual", "allow_movement", 0 );
    cameradown = 44;
    ztron_camera::setCameraDown( cameradown );
    velocity = self getvelocity();
    self setvelocity( ( 0, 0, velocity[ 2 ] ) );
    wait 2;
    val::reset_all( "ztron_arena_ritual" );
    ztron_camera::setCameraDown( 0 );
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0xbfd27094, Offset: 0x9b4
// Size: 0x4a
function function_c835eb0fdd7017d()
{
    level.ztron.var_91517987ca332e2a = 0;
    level waittill( #"ztron_challenge_round_spawning" );
    level.ztron.var_91517987ca332e2a = level.zombies.size;
    level thread ztron_arena::function_bf1d1ae5d9863498();
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0x47de9921, Offset: 0xa06
// Size: 0x2f7
function ritual_challenge()
{
    level endon( #"arena_completed", #"ztron_game_is_over" );
    level.ztron.var_cd3b78b45db638d8 = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
    level utility::flag_set( "ztron_challenge_round_spawning" );
    riserdef = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
    origin = level.ztron.active_arena.center.origin;
    level.ztron.spawnspots = utility::getstructarray( "ritual_rise_spot", "targetname" );
    level.ztron.var_b73d65bda084ba92 = 0;
    level.ztron.var_cbfc78346d18c0a0 = &function_75db2f307ab81f6c;
    level.ztron.var_aa9e2c7ca33bc903 = &function_c835eb0fdd7017d;
    wait 5;
    var_a82e1f2633bba9c = 5 + 4 * level.ztron.game_laps;
    level.ztron.var_a593aa94dc733518 = "walk";
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        var_a82e1f2633bba9c += 3;
        level.ztron.var_a593aa94dc733518 = "sprint";
    }
    
    var_82c0555606f4d519 = level.ztron.spawnspots.size;
    maxspeed = "sprint";
    level thread ztron_arena::function_bf1d1ae5d9863498();
    
    while ( var_a82e1f2633bba9c > 0 )
    {
        if ( !utility::flag( "ztron_challenge_round_spawning" ) )
        {
            break;
        }
        
        numai = var_82c0555606f4d519;
        
        while ( numai > 0 && utility::flag( "ztron_challenge_round_spawning" ) )
        {
            ztron_enemy::function_77e1bf43b991b4a( riserdef, 1, origin, 0, undefined, level.players[ 0 ], undefined, level.ztron.active_arena, undefined, -1, 0, 1 );
            numai--;
            level.ztron.var_91517987ca332e2a++;
            waitframe();
        }
        
        while ( ztron_util::function_cdd411b0cc1f9d80().size > 10 )
        {
            wait 0.25;
        }
        
        var_a82e1f2633bba9c--;
        
        if ( level.ztron.var_a593aa94dc733518 != maxspeed )
        {
            level.ztron.var_a593aa94dc733518 = ztron_enemy_ai::function_301ea1a231b88fb2( level.ztron.var_a593aa94dc733518 );
        }
    }
    
    level.ztron.var_a593aa94dc733518 = undefined;
    level.ztron.var_cbfc78346d18c0a0 = undefined;
    level.ztron.spawnspots = undefined;
    level.ztron.var_b73d65bda084ba92 = undefined;
    level.ztron.var_aa9e2c7ca33bc903 = undefined;
    utility::flag_clear( "ztron_challenge_round_spawning" );
}

// Namespace ztron_arena_ritual
// Params 0
// Checksum 0xb5dae66a, Offset: 0xd05
// Size: 0x8b
function function_75db2f307ab81f6c()
{
    spot = level.ztron.var_b73d65bda084ba92;
    level.ztron.var_b73d65bda084ba92++;
    
    if ( level.ztron.var_b73d65bda084ba92 > level.ztron.spawnspots.size )
    {
        level.ztron.var_b73d65bda084ba92 = 0;
    }
    
    return level.ztron.spawnspots[ spot ];
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x93c1c3ba, Offset: 0xd99
// Size: 0x1b7
function private function_8a3c383deb683417()
{
    level endon( #"ztron_teleporter_taken", #"waiting_on_arena_completed", #"arena_completed", #"ztron_game_is_over" );
    middlerock = utility::getstruct( "ritual_middle_rock", "targetname" );
    origin = middlerock.origin;
    angles = middlerock.angles ?? ( 0, 0, 0 );
    self.middlerock = utility::spawn_model( "sat_zm_ztron_props_rock", origin, angles );
    self.middlerock solid();
    self.middlerock.navobstacle = function_8bf6c5fe849106c4( self.middlerock.origin, ( 0, 0, 0 ), 8, 60, 128 );
    self.middlerock thread ztron_util::function_36239518d8da65f0( level, "arena_completed" );
    self.var_1e20875c34be9dbe = utility::getstructarray( "ritual_event_elemental_terrain", "targetname" );
    eruptionspot = utility::getstruct( "ritual_event_eruption_spot", "targetname" );
    self.var_45d9d21dce46851e = utility::spawn_model( "tag_origin", eruptionspot.origin, eruptionspot.angles );
    self.var_45d9d21dce46851e thread ztron_util::function_36239518d8da65f0( level, "arena_completed" );
    shaftblocker = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_blocker", "targetname" );
    
    if ( isdefined( shaftblocker ) )
    {
        if ( !isdefined( shaftblocker.var_41b852170f1ff922 ) )
        {
            shaftblocker.var_41b852170f1ff922 = shaftblocker.origin;
        }
    }
    
    thread function_2a2e06c9575b8238();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0xc
// Checksum 0x8361c308, Offset: 0xf58
// Size: 0x96
function private function_6bafef87adddd6b9()
{
    self notify( #"hash_fb860f980e9b6d2a" );
    self endon( #"hash_fb860f980e9b6d2a" );
    level endon( #"ztron_game_is_over", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left <= 2 )
        {
            break;
        }
    }
    
    if ( level.ztron.arena_rounds_left == 2 )
    {
        wait randomfloatrange( 5, 10 );
    }
    
    thread function_2ab133cfb4367aef();
    wait 0.1;
    thread function_bf3617eea82b1fe5();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0xc
// Checksum 0x3abb093f, Offset: 0xff6
// Size: 0x67
function private function_2c4fd89e0c90d303()
{
    self notify( #"hash_a67baa0ab875daea" );
    self endon( #"hash_a67baa0ab875daea" );
    level endon( #"ztron_game_is_over", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        
        if ( level.ztron.arena_rounds_left == 1 )
        {
            break;
        }
    }
    
    function_cbbb6784da32c4f3();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x2f5520f0, Offset: 0x1065
// Size: 0x25
function private function_2a2e06c9575b8238()
{
    level endon( #"ztron_game_is_over", #"arena_completed" );
    thread function_6bafef87adddd6b9();
    thread function_2c4fd89e0c90d303();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0xf0e7a6b, Offset: 0x1092
// Size: 0xc6
function private function_bf3617eea82b1fe5()
{
    if ( !isdefined( self.middlerock ) )
    {
        return;
    }
    
    destroynavobstacle( self.middlerock.navobstacle );
    launchpoint = self.middlerock.origin + ( randomfloatrange( -48, 48 ), randomfloatrange( -48, 48 ), -8 );
    launchvector = vectornormalize2( ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 ) ) * 16000 + ( 0, 0, 8000 );
    self.middlerock physicslaunchserver( self.middlerock.origin, launchvector );
    self.middlerock ztron_util::deletemedelay( 1.5 );
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x8fe6f11a, Offset: 0x1160
// Size: 0x310
function private function_2ab133cfb4367aef()
{
    if ( !isdefined( self.var_1e20875c34be9dbe ) )
    {
        return;
    }
    
    foreach ( var_b107b25d793b0faf in self.var_1e20875c34be9dbe )
    {
        targets = ztron_util::function_2d9de5c7b97db39( var_b107b25d793b0faf.target, "targetname" );
        targets = arraycombine( targets, utility::getstructarray( var_b107b25d793b0faf.target, "targetname" ) );
        var_b107b25d793b0faf.navbadplaces = [];
        var_b107b25d793b0faf.scriptables = [];
        var_ef88dfe3d7a9e8fb = [];
        
        foreach ( target in targets )
        {
            if ( isstruct( target ) && target.script_noteworthy == "lava_model" && isdefined( target.script_parameters ) )
            {
                var_f87120e371a2593c = utility::spawn_model( target.script_parameters, target.origin + ( 0, 0, -32 ), target.angles ?? ( 0, 0, 0 ) );
                var_f87120e371a2593c movez( 32, 2 );
                var_b107b25d793b0faf.var_f87120e371a2593c = var_f87120e371a2593c;
            }
            else if ( isstruct( target ) && target.script_noteworthy == "lava_vfx" )
            {
                vfx_scriptable = spawnscriptable( "scriptable_zombie_triton_lava_bomb_aoe_ztron", target.origin );
                vfx_scriptable setscriptablepartstate( "impact", "impact" );
                var_ef88dfe3d7a9e8fb[ var_ef88dfe3d7a9e8fb.size ] = vfx_scriptable;
            }
            
            if ( issubstr( target.code_classname, "trigger_box" ) )
            {
                navbadplace = createnavbadplacebyent( target, 14.9 );
                var_b107b25d793b0faf.navbadplaces[ var_b107b25d793b0faf.navbadplaces.size ] = navbadplace;
            }
        }
        
        wait 2;
        
        foreach ( vfx_scriptable in var_ef88dfe3d7a9e8fb )
        {
            vfx_scriptable setscriptablepartstate( "impact", "off" );
            vfx_scriptable freescriptable();
        }
        
        var_b107b25d793b0faf.iseventbased = 1;
        namespace_8b88d3ab6f21188c::function_e77e60658a87d640( var_b107b25d793b0faf );
    }
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0xb7bf7621, Offset: 0x1478
// Size: 0x282
function private function_3a1a354d1c77da58()
{
    if ( !isdefined( self.var_1e20875c34be9dbe ) )
    {
        return;
    }
    
    foreach ( var_b107b25d793b0faf in self.var_1e20875c34be9dbe )
    {
        targets = ztron_util::function_2d9de5c7b97db39( var_b107b25d793b0faf.target, "targetname" );
        
        foreach ( target in targets )
        {
            if ( var_b107b25d793b0faf.terrainraised )
            {
                vfx_scriptable = spawnscriptable( "scriptable_zombie_triton_lava_bomb_aoe_ztron", target.origin + ( 0, 0, 32 ) );
                
                if ( vfx_scriptable )
                {
                    vfx_scriptable thread function_1b1d36bddb2d52f1( 4 );
                    vfx_scriptable setscriptablepartstate( "impact", "impact" );
                }
                
                var_b107b25d793b0faf.terrainraised = 0;
            }
        }
        
        if ( isdefined( var_b107b25d793b0faf.var_f87120e371a2593c ) )
        {
            var_b107b25d793b0faf.var_f87120e371a2593c movez( -3000, 18 );
            var_b107b25d793b0faf.var_f87120e371a2593c thread ztron_util::deletemedelay( 18 );
            var_b107b25d793b0faf.var_f87120e371a2593c = undefined;
        }
        
        foreach ( navbadplace in var_b107b25d793b0faf.navbadplaces )
        {
            if ( isdefined( navbadplace ) )
            {
                destroynavobstacle( navbadplace );
            }
        }
        
        var_b107b25d793b0faf notify( #"destroy_hazard" );
    }
    
    shaftblocker = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_blocker", "targetname" );
    
    if ( isdefined( shaftblocker ) )
    {
        shaftblocker.origin = shaftblocker.var_41b852170f1ff922 + ( 0, 0, 5000 );
    }
}

// Namespace ztron_arena_ritual
// Params 1
// Checksum 0x7614c1a8, Offset: 0x1702
// Size: 0x25
function function_1b1d36bddb2d52f1( delays )
{
    wait delays;
    self setscriptablepartstate( "impact", "off" );
    self freescriptable();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0xd91f8c8d, Offset: 0x172f
// Size: 0x2a
function private function_70d0be5ba4fc648c()
{
    level endon( #"arena_completed", #"ztron_game_is_over" );
    self waittill( #"movedone" );
    self hide();
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0xf21b8d27, Offset: 0x1761
// Size: 0x184
function private function_28a6f701a3bda144()
{
    if ( !isdefined( self.var_1e20875c34be9dbe ) )
    {
        return;
    }
    
    foreach ( var_b107b25d793b0faf in self.var_1e20875c34be9dbe )
    {
        targets = ztron_util::function_2d9de5c7b97db39( var_b107b25d793b0faf.target, "targetname" );
        
        foreach ( target in targets )
        {
            if ( issubstr( target.code_classname, "script_brushmodel" ) && isdefined( target.originposition ) )
            {
                target.origin = target.originposition;
                target show();
            }
        }
    }
    
    shaftblocker = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_blocker", "targetname" );
    
    if ( isdefined( shaftblocker ) )
    {
        shaftblocker.origin = shaftblocker.var_41b852170f1ff922;
    }
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x13ec323b, Offset: 0x18ed
// Size: 0x38
function private function_cbbb6784da32c4f3()
{
    level endon( #"arena_completed", #"ztron_game_is_over", #"round_over" );
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        thread lavaerupt();
    }
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0xc74fec0a, Offset: 0x192d
// Size: 0x1c2
function private lavaerupt()
{
    if ( !isdefined( self.var_45d9d21dce46851e ) )
    {
        return;
    }
    
    ballsnumber = randomintrange( 3, 5 );
    center_spot = self.var_45d9d21dce46851e.origin;
    launch_origin_offset = 32;
    launch_vector_offset = 96;
    launch_vector_z = 720;
    
    if ( level.ztron.var_95d8c7a469393957 )
    {
        launch_vector_z += 720;
    }
    
    while ( ballsnumber )
    {
        angle = randomfloat( 360 );
        origin_offset = randomfloatrange( launch_origin_offset * 0.5, launch_origin_offset );
        var_1ee0fb87e7a6465 = randomfloatrange( launch_vector_offset * 0.5, launch_vector_offset );
        vector_height = randomfloatrange( launch_vector_z * 0.5, launch_vector_z );
        x = cos( angle );
        y = sin( angle );
        launch_origin = center_spot + ( x, y, 0 ) * origin_offset;
        var_8173e8e98603d359 = ( x, y, 0 ) * var_1ee0fb87e7a6465 + ( 0, 0, vector_height );
        
        /#
            targetpoint = launch_origin + var_8173e8e98603d359;
            level thread ztron_debug::drawsphere( launch_origin, 8, 20, ( 1, 0, 0 ) );
            level thread ztron_debug::drawsphere( targetpoint, 16, 20, ( 0, 1, 0 ) );
            level thread ztron_debug::drawline( launch_origin, targetpoint, 20, ( 0, 0, 1 ) );
        #/
        
        lavaball = self.var_45d9d21dce46851e launchgrenade( "sat_ztron_lava_grenade", launch_origin, var_8173e8e98603d359 );
        
        if ( isdefined( lavaball ) )
        {
            lavaball thread function_223f2797910bb198();
        }
        
        ballsnumber--;
    }
}

// Namespace ztron_arena_ritual
// Params 0, eflags: 0x4
// Checksum 0x300352ac, Offset: 0x1af7
// Size: 0x58
function private function_223f2797910bb198()
{
    playfxontag( utility::getfx( "ztron_lava_ball" ), self, "tag_origin" );
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    thread zombie_triton_lava_bomb::lava_bomb_aoe( origin, self.angles, 128, 5, 8, "scriptable_zombie_triton_lava_bomb_aoe_ztron" );
}

/#

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0xd3021b0d, Offset: 0x1b57
    // Size: 0x86, Type: dev
    function private init_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x4d>", &function_4b96a37e1ffbf206 );
        devgui::add_devgui_func( "<dev string:x66>", "<dev string:x7d>", &function_663aa6f2b45f44f0 );
        devgui::add_devgui_func( "<dev string:x9a>", "<dev string:xb3>", &function_debb7629298b6d13 );
        devgui::add_devgui_func( "<dev string:xd2>", "<dev string:xe8>", &function_e0d95a74077ee3dd );
        devgui::add_devgui_func( "<dev string:x104>", "<dev string:x10f>", &function_5317c97419438547 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0xb09e4276, Offset: 0x1be5
    // Size: 0x1f, Type: dev
    function private function_4b96a37e1ffbf206()
    {
        level.ztron.active_arena function_bf3617eea82b1fe5();
    }

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0x6c1c2df7, Offset: 0x1c0c
    // Size: 0x1f, Type: dev
    function private function_663aa6f2b45f44f0()
    {
        level.ztron.active_arena function_2ab133cfb4367aef();
    }

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0x76455267, Offset: 0x1c33
    // Size: 0x1f, Type: dev
    function private function_debb7629298b6d13()
    {
        level.ztron.active_arena function_3a1a354d1c77da58();
    }

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0x65dbceec, Offset: 0x1c5a
    // Size: 0x1f, Type: dev
    function private function_e0d95a74077ee3dd()
    {
        level.ztron.active_arena function_28a6f701a3bda144();
    }

    // Namespace ztron_arena_ritual
    // Params 0, eflags: 0x4
    // Checksum 0x7bfaaf12, Offset: 0x1c81
    // Size: 0x1f, Type: dev
    function private function_5317c97419438547()
    {
        level.ztron.active_arena lavaerupt();
    }

#/
