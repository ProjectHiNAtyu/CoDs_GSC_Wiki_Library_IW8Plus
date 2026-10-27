// script_7ee07206a83ca532  (hash_7ee07206a83ca532.gscc) (size: 7463 Bytes / 0x1d27 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8da901d (3638202397)
// size ...... 7463 (0x1d27)
// includes .. 8   (offset: 0x1a93)
// strings ... 24  (offset: 0x1ad3)
// dev strs .. 6   (offset: 0x1cbf)
// exports ... 14  (offset: 0x108f)
// cseg ...... 0x24b + 0xe44 (0x108f)
// imports ... 67  (offset: 0x12bf)
// animtree1 . 1   (offset: 0x1d07)
// animtree2 . 0   (offset: 0x1d27)
#using script_16ea1b94f0f381b3;
#using script_4f7cbc7a2a2ba890;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\gamelogic;
#using scripts\mp\outofbounds;

#namespace benchmark_level;

// Namespace benchmark_level
// Params 24
// Checksum 0xe873f08c, Offset: 0x269
// Size: 0x2eb
function start( var_7874d79e3ff65bb0, var_418eec7606d72266, var_16c623c1071045d5, var_fe1ac3df122da8db, animation_start_origin, animation_start_angles, var_56c009b7ff2025b4, weapon_model, var_9593246a6e7bad36, weapon_animation, flyby_cam_animation, agent_body_model, agent_head_model, agent_hat_model, var_294fc07a4fa518e, var_19b7e4d3b87878d4, third_person_player_origin, third_person_player_angles, player_weapon, var_f97807b5808d561b, enter_water_vfx, exit_water_vfx, var_39cf46d4646d8134, enemy_agent_type )
{
    level.onplayerconnect = &onplayerconnect;
    level.onplayerdisconnect = &onplayerdisconnect;
    level.modifyplayerdamage = var_fe1ac3df122da8db;
    level.var_178a5d26de1a42ca = { #enemy_agent_type:enemy_agent_type, #var_39cf46d4646d8134:var_39cf46d4646d8134, #exit_water_vfx:exit_water_vfx, #enter_water_vfx:enter_water_vfx, #var_f97807b5808d561b:var_f97807b5808d561b, #player_weapon:player_weapon, #third_person_player_angles:third_person_player_angles, #third_person_player_origin:third_person_player_origin, #var_19b7e4d3b87878d4:var_19b7e4d3b87878d4, #var_294fc07a4fa518e:var_294fc07a4fa518e, #agent_hat_model:agent_hat_model, #agent_head_model:agent_head_model, #agent_body_model:agent_body_model, #flyby_cam_animation:flyby_cam_animation, #weapon_animation:weapon_animation, #var_9593246a6e7bad36:var_9593246a6e7bad36, #weapon_model:weapon_model, #var_56c009b7ff2025b4:var_56c009b7ff2025b4, #animation_start_angles:animation_start_angles, #animation_start_origin:animation_start_origin, #var_fe1ac3df122da8db:var_fe1ac3df122da8db, #var_16c623c1071045d5:var_16c623c1071045d5, #var_418eec7606d72266:var_418eec7606d72266, #var_7874d79e3ff65bb0:var_7874d79e3ff65bb0 };
    level.var_c353408e1112dca = getdvarint( @"hash_dfc28ba505e748e6", 0 );
    level._effect[ "vfx_muzzle_flash" ] = loadfxasset( level.var_178a5d26de1a42ca.var_39cf46d4646d8134 ?? "vfx_t10_core_weapons_muz_ar_able18" );
    level._effect[ "swim_exit_water" ] = loadfxasset( level.var_178a5d26de1a42ca.enter_water_vfx ?? "vfx_iw9_core_swimming_swim_exit_water_screen" );
    level._effect[ "swim_enter_water" ] = loadfxasset( level.var_178a5d26de1a42ca.exit_water_vfx ?? "vfx_iw9_core_swimming_swim_submerge_bubbles_2" );
    [[ var_16c623c1071045d5 ]]();
    
    if ( !benchmark_mp_utils::function_1213863ac8d76692() )
    {
        function_54c3798923acad54();
        level.var_7718711414cd6c5b = [[ var_7874d79e3ff65bb0 ]]();
        benchmark_mp_utils::function_6ab87ad1143eed0b( level.var_7718711414cd6c5b );
    }
}

// Namespace benchmark_level
// Params 0
// Checksum 0x6f86ffc2, Offset: 0x55c
// Size: 0x12
function function_c8ae0e55058400d6()
{
    return animation::get_scr_animlength( "flyby_cam", "mp_vm_benchmark" );
}

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0xda00f7cb, Offset: 0x577
// Size: 0x103
function private onplayerconnect( player )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    thread function_92dd64e788a3774e( player );
    player waittill( #"spawned" );
    
    if ( !benchmark_mp_utils::function_1213863ac8d76692() )
    {
        [[ level.var_178a5d26de1a42ca.var_418eec7606d72266 ]]( player );
        thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 0 );
        player utility::ent_flag_wait( "loading_over" );
        player utility::hidehudenable();
        player.team = "allies";
        player.sessionstate = "playing";
        player.safefromnuke = 1;
        player disableweapons();
        player lerpfovscalefactor( 0, 0 );
        outofbounds::enableoobimmunity( player );
        level.player = player;
        thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 1.5 );
        benchmark_start( player );
    }
    else
    {
        player thread function_6115141f6bfa117f();
    }
    
    /#
        thread benchmark_mp_utils::function_5417055af82bab24( player );
    #/
}

// Namespace benchmark_level
// Params 0, eflags: 0x4
// Checksum 0xe780c019, Offset: 0x682
// Size: 0x2c
function private function_6115141f6bfa117f()
{
    self endon( #"disconnect" );
    wait 1;
    
    if ( level.prematchallowfunc )
    {
        self [[ level.prematchallowfunc ]]( 1 );
    }
}

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0xd0927439, Offset: 0x6b6
// Size: 0x80
function private benchmark_start( player )
{
    player endon( #"disconnect" );
    
    /#
        benchmark_mp_utils::function_e921e44aeeb73adb( player );
    #/
    
    level utility::flag_set( "benchmark_start" );
    
    if ( benchmark_mp_utils::isdevbuild() && getdvarint( @"hash_a6580d9de6607747", 0 ) == 1 )
    {
        benchmark_mp_utils::function_87f27a2fe82b85da( 0, 1 );
        wait 1;
        benchmark_mp_utils::function_2544b8c262fb0f68();
        return;
    }
    
    thread setupplayeranims( player );
    thread benchmark_mp_utils::function_424726511ca50e8a( player, level.var_7718711414cd6c5b );
}

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0xc1b37308, Offset: 0x73e
// Size: 0xb8
function private onplayerdisconnect( player )
{
    all_agents = getaiarray();
    
    if ( !gamelogic_mp::function_45db3a140da5f4b1( player ) && all_agents && all_agents.size > 0 )
    {
        foreach ( agent in all_agents )
        {
            agent agent_utils::despawnagent();
        }
    }
    
    player lerpfovscalefactor( 1, 0 );
    benchmark_mp_utils::function_f9d0dfe3ff7db515();
}

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0x40df0ab6, Offset: 0x7fe
// Size: 0x61
function private function_92dd64e788a3774e( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, value );
        
        if ( msg == "versus_done" )
        {
            player utility::ent_flag_set( "loading_over" );
            break;
        }
    }
}

#using_animtree( "script_model" );

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0x3263bda8, Offset: 0x867
// Size: 0x45e
function private setupplayeranims( player )
{
    player endon( #"disconnect" );
    starting_origin = getdvarvector( @"benchmark_starting_origin", level.var_178a5d26de1a42ca.animation_start_origin ?? getclosestpointonnavmesh( ( 0, 0, 0 ) ) );
    starting_angles = getdvarvector( @"benchmark_starting_angles", level.var_178a5d26de1a42ca.animation_start_angles ?? ( 0, 0, 0 ) );
    starting_node = utility::spawn_tag_origin( starting_origin, starting_angles );
    player setorigin( starting_node.origin );
    player setplayerangles( starting_node.angles );
    player playerhide();
    
    if ( isanimation( level.var_178a5d26de1a42ca.var_9593246a6e7bad36 ) )
    {
        var_2850c83e44ce1406 = getanimname( level.var_178a5d26de1a42ca.var_9593246a6e7bad36 );
        level.scr_animtree[ "player_rig" ] = #animtree;
        level.scr_animname[ "player_rig" ][ "mp_vm_benchmark" ] = var_2850c83e44ce1406;
        level.scr_anim[ "player_rig" ][ "mp_vm_benchmark" ] = level.var_178a5d26de1a42ca.var_9593246a6e7bad36;
        level.scr_eventanim[ "player_rig" ][ "mp_vm_benchmark" ] = %"mp_vm_benchmark";
        level.scr_viewmodelanim[ "player_rig" ][ "mp_vm_benchmark" ] = var_2850c83e44ce1406;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( level.var_178a5d26de1a42ca.var_56c009b7ff2025b4 ) || !modelexists( level.var_178a5d26de1a42ca.var_56c009b7ff2025b4 ) )
    {
        assertmsg( "<dev string:x4d>" );
        return;
    }
    
    player_rig = spawn( "script_model", starting_node.origin );
    player_rig.animname = "player_rig";
    player_rig setmodel( level.var_178a5d26de1a42ca.var_56c009b7ff2025b4 );
    player_rig.angles = starting_node.angles;
    player_rig useanimtree( #animtree );
    player_weapon = function_c0af9afe4efc1ad2( player_rig );
    
    if ( isdefined( player_weapon ) )
    {
        setomnvar( "ui_benchmark_gun_model_ent", player_weapon );
    }
    
    function_e64409e068b0e08f();
    
    if ( !level.var_c353408e1112dca )
    {
        flyby_cam = spawn( "script_model", starting_node.origin );
        flyby_cam.animname = "flyby_cam";
        flyby_cam setmodel( level.var_178a5d26de1a42ca.var_56c009b7ff2025b4 );
        flyby_cam.angles = starting_node.angles;
        flyby_cam useanimtree( #animtree );
        flyby_cam hideallparts();
        third_person_agent = benchmark_mp_utils::function_50caa57b4077d26f( level.var_178a5d26de1a42ca.third_person_player_origin, level.var_178a5d26de1a42ca.third_person_player_angles, 1, level.var_178a5d26de1a42ca.var_294fc07a4fa518e, level.var_178a5d26de1a42ca.var_19b7e4d3b87878d4 );
        player.animname = "flyby_cam";
        player playerlinktoabsolute( flyby_cam, "tag_player" );
        starting_node animation::anim_first_frame_solo( flyby_cam, "mp_vm_benchmark" );
        starting_node thread animation::anim_single_solo( flyby_cam, "mp_vm_benchmark" );
        fade_out_time = level.fade_out_time ?? 0.5;
        wait function_c8ae0e55058400d6() - fade_out_time;
        benchmark_mp_utils::function_1575e6db0bcbad11( 0.5 );
        wait fade_out_time;
        
        if ( isdefined( third_person_agent ) )
        {
            third_person_agent agent_utils::despawnagent();
        }
        
        benchmark_mp_utils::function_157210286b7849ce( 1 );
    }
    
    player.animname = "player_rig";
    player playerlinktoabsolute( player_rig, "tag_player" );
    starting_node animation::anim_first_frame_solo( player_rig, "mp_vm_benchmark" );
    
    if ( isanimation( level.var_178a5d26de1a42ca.weapon_animation ) )
    {
        player_rig animation::anim_first_frame_solo( player_weapon, "mp_vm_benchmark", "j_gun" );
        player_rig thread animation::anim_single_solo( player_weapon, "mp_vm_benchmark", "j_gun" );
    }
    
    starting_node thread animation::anim_single_solo( player_rig, "mp_vm_benchmark" );
}

// Namespace benchmark_level
// Params 1, eflags: 0x4
// Checksum 0x3e6d3030, Offset: 0xccd
// Size: 0x17e
function private function_c0af9afe4efc1ad2( player_rig )
{
    if ( !isdefined( level.var_178a5d26de1a42ca.weapon_model ) || !modelexists( level.var_178a5d26de1a42ca.weapon_model ) )
    {
        assertmsg( "<dev string:x8a>" );
        return;
    }
    
    if ( isanimation( level.var_178a5d26de1a42ca.weapon_animation ) )
    {
        level.scr_animtree[ "player_weapon" ] = #animtree;
        level.scr_anim[ "player_weapon" ][ "mp_vm_benchmark" ] = level.var_178a5d26de1a42ca.weapon_animation;
        level.scr_animname[ "player_weapon" ][ "mp_vm_benchmark" ] = getanimname( level.var_178a5d26de1a42ca.weapon_animation );
        level.scr_eventanim[ "player_weapon" ][ "mp_vm_benchmark" ] = %"mp_vm_benchmark";
    }
    else
    {
        assertmsg( "<dev string:xc0>" );
    }
    
    player_weapon = spawn( "script_model", ( 0, 0, 0 ) );
    player_weapon setmodel( level.var_178a5d26de1a42ca.weapon_model );
    player_weapon useanimtree( #animtree );
    player_weapon.animname = "player_weapon";
    player_weapon linkto( player_rig, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    return player_weapon;
}

// Namespace benchmark_level
// Params 2
// Checksum 0x55229252, Offset: 0xe54
// Size: 0x7e
function function_7cdd735564992994( player, custom_struct )
{
    if ( !isdefined( custom_struct.agent_group_id ) )
    {
        assertmsg( "<dev string:xe9>" );
        return;
    }
    
    thread benchmark_mp_utils::function_e1dbf0f401a5e201( custom_struct.agent_group_id, level.var_178a5d26de1a42ca.agent_body_model, level.var_178a5d26de1a42ca.agent_head_model, level.var_178a5d26de1a42ca.agent_hat_model );
}

// Namespace benchmark_level
// Params 2
// Checksum 0x188f9488, Offset: 0xeda
// Size: 0x49
function function_9055a9e9904536bc( player, custom_struct )
{
    if ( !isdefined( custom_struct.sequence_func ) )
    {
        assertmsg( "<dev string:x129>" );
        return;
    }
    
    thread namespace_6826532b84b72321::function_f79179c6b5c2f11d( player, [[ custom_struct.sequence_func ]]() );
}

// Namespace benchmark_level
// Params 0, eflags: 0x4
// Checksum 0xfe262229, Offset: 0xf2b
// Size: 0x89
function private function_e64409e068b0e08f()
{
    animation::addnotetrack_customfunction( "player_weapon", "player_fire_kill", &benchmark_mp_utils::function_db2483a05fc6044, "mp_vm_benchmark" );
    animation::addnotetrack_customfunction( "player_weapon", "player_fire", &benchmark_mp_utils::player_fireweapon, "mp_vm_benchmark" );
    animation::addnotetrack_customfunction( "player_rig", "player_enter_water", &benchmark_mp_utils::function_2c03773097b86c22, "mp_vm_benchmark" );
    animation::addnotetrack_customfunction( "player_rig", "player_surface_water", &benchmark_mp_utils::function_c1c32536f7a7b08d, "mp_vm_benchmark" );
    animation::addnotetrack_customfunction( "player_rig", "player_exit_water", &benchmark_mp_utils::playerexitwater, "mp_vm_benchmark" );
}

// Namespace benchmark_level
// Params 0, eflags: 0x4
// Checksum 0x36487c69, Offset: 0xfbc
// Size: 0xd3
function private function_54c3798923acad54()
{
    if ( isanimation( level.var_178a5d26de1a42ca.flyby_cam_animation ) )
    {
        var_2850c83e44ce1406 = getanimname( level.var_178a5d26de1a42ca.flyby_cam_animation );
        level.scr_animtree[ "flyby_cam" ] = #animtree;
        level.scr_anim[ "flyby_cam" ][ "mp_vm_benchmark" ] = level.var_178a5d26de1a42ca.flyby_cam_animation;
        level.scr_animname[ "flyby_cam" ][ "mp_vm_benchmark" ] = var_2850c83e44ce1406;
        level.scr_eventanim[ "flyby_cam" ][ "mp_vm_benchmark" ] = "mp_vm_benchmark";
        level.scr_viewmodelanim[ "flyby_cam" ][ "mp_vm_benchmark" ] = var_2850c83e44ce1406;
        return;
    }
    
    level.var_c353408e1112dca = 1;
}

