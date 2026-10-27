// scripts\mp\ob\systems\ob_redeploy_drone.gsc  (hash_56fa67442b2578cc.gscc) (size: 26289 Bytes / 0x66b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac863436 (2894476342)
// size ...... 26289 (0x66b1)
// includes .. 11  (offset: 0x6181)
// strings ... 41  (offset: 0x61d9)
// dev strs .. 32  (offset: 0x64dd)
// exports ... 74  (offset: 0x4031)
// cseg ...... 0x520 + 0x3b11 (0x4031)
// imports ... 161 (offset: 0x4bc1)
// animtree1 . 0   (offset: 0x6691)
// animtree2 . 2   (offset: 0x6691)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\parachute;
#using scripts\mp\radiation;

#namespace ob_redeploy_drone;

// Namespace ob_redeploy_drone
// Params 0, eflags: 0x1
// Checksum 0xc837f9c4, Offset: 0x53e
// Size: 0xa
function autoexec main()
{
    level thread function_ed6b67ba86cf1f74();
}

// Namespace ob_redeploy_drone
// Params 0, eflags: 0x4
// Checksum 0x4268e5ca, Offset: 0x550
// Size: 0x1d
function private function_ed6b67ba86cf1f74()
{
    waitframe();
    
    if ( !getdvarint( @"redeploy_ascenders_enabled", 0 ) )
    {
        return;
    }
    
    init();
}

// Namespace ob_redeploy_drone
// Params 0, eflags: 0x4
// Checksum 0xdce139a, Offset: 0x575
// Size: 0x2d
function private init()
{
    /#
        level thread debug_init();
    #/
    
    initvariables();
    scriptable::scriptable_addusedcallbackbypart( "redeploy_drone_interact", &function_d3b7bea5de5c72 );
    level thread redeploy_drone_spawn_manager();
}

#using_animtree( "scriptables" );

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x5b800c5a, Offset: 0x5aa
// Size: 0x2fd
function initvariables()
{
    level.redeploy_drone_info_struct = spawnstruct();
    level.redeploy_drone_info_struct.var_752a2de7a9a8ec9d = getdvarint( @"hash_fc06cf8b2e6ff7c8", 100 );
    level.redeploy_drone_info_struct.var_725b5a0d669b2688 = getdvarint( @"hash_4d3f3ddcf9c9ae8f", 2000 );
    level.redeploy_drone_info_struct.i_explosion_radius = getdvarint( @"scr_redeploy_drone_explosion_radius", 512 );
    level.redeploy_drone_info_struct.var_e287bb6858da1470 = getdvarint( @"scr_redeploy_drone_explosion_damage_min", 10 );
    level.redeploy_drone_info_struct.var_e264b16858b3b6ba = getdvarint( @"hash_3d7052323e9fd24d", 50 );
    level.redeploy_drone_info_struct.var_93c50a30cdabecab = getdvarint( @"scr_redeploy_drone_despawn_index", 3 );
    level.redeploy_drone_info_struct.var_9e437065f024b3dd = getdvarfloat( @"hash_590a91e3623c94d", 4 );
    level.redeploy_drone_info_struct.var_282669dff723ff8 = getdvarint( @"hash_3cd8f7500c4cffcb", 15 );
    level.redeploy_drone_info_struct.var_c91738a31073297d = getdvarint( @"hash_7a6046af43f645a", 5 );
    level.redeploy_drone_info_struct.var_d0553b05b6a9d317 = getdvarint( @"hash_67144a280e505eb0", 10 );
    level.redeploy_drone_info_struct.i_max_speed = getdvarint( @"scr_redeploy_drone_max_speed", 50 );
    var_e304f85506f34c20 = getdvarint( @"hash_9bd3724f70106775", 30000 );
    level.redeploy_drone_info_struct.var_2e5a2c13083fe991 = squared( var_e304f85506f34c20 );
    var_8318ed3598692919 = getdvarint( @"hash_59c137234dad4ad6", 8000 );
    level.redeploy_drone_info_struct.var_10fed330f6746fa6 = squared( var_8318ed3598692919 );
    level.redeploy_drone_info_struct.var_12bfa36b3396fee1 = getdvarint( @"hash_898325e4ee88d57f", 2400 );
    level.redeploy_drone_info_struct.var_bb39751f42ca73bc = getdvarint( @"hash_19f16b7bfea9d46", 3000 );
    level.redeploy_drone_info_struct.var_7a0ef63e9d1bf5cb = getdvarint( @"scr_parachute_overhead_warning_timeout_ms", 45000 );
    level.redeploy_drone_info_struct.var_70f8f33c72450ba = getanimlength( %veh9_mil_air_drone_redeploy_extend_hook_01 );
    level.redeploy_drone_info_struct.var_f662574871be8bd2 = getanimlength( %veh9_mil_air_drone_redeploy_retract_hook_01 );
    level.redeploy_drone_info_struct.var_91fb78a373d2f59 = [];
    level.redeploy_drone_info_struct.var_531f28cf3d055c11 = getentitylessscriptablearray( "scriptable_ob_redeploy_drone", #classname );
    level.redeploy_drone_info_struct.var_416151fca5c5b862 = [];
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x81f71045, Offset: 0x8af
// Size: 0x94
function redeploy_drone_spawn_manager()
{
    waitframe();
    function_713e11f8f6f563e8();
    function_e6a3b10a4a325792();
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        scriptable spawn_redeploy_drone();
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xad172819, Offset: 0x94b
// Size: 0xb7
function function_e6a3b10a4a325792()
{
    level.redeploy_drone_info_struct.var_dc2234786c8913dd = [];
    i_spawned = 0;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
    {
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ i_spawned ] = scriptable;
        i_spawned++;
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x2eda31ad, Offset: 0xa0a
// Size: 0x9c
function is_redeploy_drone_in_gas()
{
    ingas = 0;
    
    foreach ( circle in level.radiation.instances )
    {
        ingas = circle radiation::is_position_inside( self.origin );
    }
    
    return ingas;
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x7607c187, Offset: 0xaaf
// Size: 0xd4
function spawn_redeploy_drone()
{
    set_redeploy_drone_available();
    self setscriptablepartstate( "redeploy_drone_sfx", "engine_idle_sfx" );
    self setscriptablepartstate( "redeploy_drone_vfx", "enabled" );
    self setscriptablepartstate( "redeploy_drone_interact", "available" );
    thread function_e64f6d9b378833f8();
    
    if ( getdvarint( @"hash_94cc2e00dc85444b", 1 ) && !isdefined( self.temp ) )
    {
        drone = spawn( "script_model", self.origin );
        drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
        drone.angles = self.angles;
        drone.speed = 0;
        drone forcenetfieldhighlod( 1 );
        drone notsolid();
        self.temp = drone;
    }
    
    callback::callback( "on_spawn_redeploy_drone" );
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xd0c85ee9, Offset: 0xb8b
// Size: 0x2a3
function redeploy_drone_infil()
{
    wait 23;
    f_right_dot = vectordot( anglestoright( level.br_ac130.angles ), vectornormalize( self.origin - level.br_ac130.origin ) );
    v_spawn = level.br_ac130.origin + anglestoforward( level.br_ac130.angles ) * -1 * ( distance( level.br_ac130.origin, self.origin ) - 45000 ) + anglestoright( level.br_ac130.angles ) * 15000 * f_right_dot;
    var_59a9f6269998cd9a = 100;
    var_59cce02699bee4f0 = parachute::getc130height() - 4000;
    var_59a9ec269998b79c = var_59a9f6269998cd9a + var_59cce02699bee4f0 / 2;
    var_5b5fb127b73a395b = ( var_59cce02699bee4f0 - var_59a9f6269998cd9a ) / 2;
    f_forward_dot = vectordot( anglestoforward( level.br_ac130.angles ), vectornormalize( v_spawn - level.br_ac130.origin ) );
    f_z_offset = var_59a9ec269998b79c + var_5b5fb127b73a395b * f_forward_dot;
    v_spawn += ( 0, 0, -1 * f_z_offset );
    drone = spawn( "script_model", v_spawn );
    drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
    drone.angles = vectortoangles( self.origin - drone.origin );
    drone.speed = level.redeploy_drone_info_struct.i_max_speed * 4 * level.redeploy_drone_info_struct.var_251b2c6b71a01138;
    drone forcenetfieldhighlod( 1 );
    
    /#
        drone thread debug_sphere( undefined, 25, ( 1, 0, 0 ) );
    #/
    
    /#
        drone thread function_c4d1ea35667e37d4( ( 1, 0, 0 ) );
    #/
    
    drone thread function_f8019c12697fcf50( self );
    drone thread function_76cb6eb6a9700637( self );
    drone thread redeploy_drone_sfx_watcher();
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        wait 0.05;
    }
    
    drone notify( #"relocation_complete" );
    drone delete();
    cable_deploy();
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    set_redeploy_drone_available();
    thread function_e64f6d9b378833f8();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x72ed9891, Offset: 0xe36
// Size: 0xff
function function_713e11f8f6f563e8()
{
    collisioncontents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_water" ] );
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
    {
        trace = trace::ray_trace( scriptable.origin, scriptable.origin + ( 0, 0, -3000 ), undefined, collisioncontents, 1, 1, 0 );
        scriptable.str_surftype = trace[ "surfacetype" ];
        scriptable.var_bd4fec0091dedb5c = trace[ "position" ];
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xb2c870ca, Offset: 0xf3d
// Size: 0x174
function set_redeploy_drone_available()
{
    self setscriptablepartstate( "redeploy_drone", "available" );
    self.b_occupied = 1;
    self.b_used = 1;
    
    /#
        function_65401ca948591d1e();
    #/
    
    if ( !isdefined( self.var_bd4fec0091dedb5c ) )
    {
        self.var_bd4fec0091dedb5c = self.origin - ( 0, 0, 2727 );
    }
    
    scr_impact_fx = spawnscriptable( "ob_redeploy_drone_anchor_impact", self.var_bd4fec0091dedb5c );
    waitframe();
    
    /#
        if ( !isdefined( self.str_surftype ) )
        {
            self.str_surftype = "<dev string:x24>";
        }
    #/
    
    if ( isdefined( self.str_surftype ) )
    {
        switch ( self.str_surftype )
        {
            case #"hash_296fec58e16e327":
            case #"hash_2fa4167540164873":
            case #"hash_588c5c47805606eb":
            case #"hash_5f33d5485b7f33ed":
            case #"hash_6dc36f3e31f59c8b":
                scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_concrete" );
                break;
            case #"hash_1f2e430eca34d788":
            case #"hash_5ff12d0a2c109d2c":
            case #"hash_d4e7d6c49368be7f":
                scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_dirt" );
                break;
            case #"hash_2dc2bd39328def65":
            case #"hash_3990683480267242":
                scr_impact_fx setscriptablepartstate( "redeploy_drone_anchor_impact", "impact_water" );
                break;
        }
    }
    
    waitframe();
    scr_impact_fx freescriptable();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xabce2182, Offset: 0x10b9
// Size: 0x61
function set_redeploy_drone_in_gas()
{
    self setscriptablepartstate( "redeploy_drone", "unavailable" );
    self.b_occupied = 0;
    
    /#
        function_21f17ba620ead39e();
    #/
    
    if ( getdvarint( @"hash_94cc2e00dc85444b", 1 ) && isdefined( self.temp ) )
    {
        if ( isdefined( self.temp ) )
        {
            self.temp delete();
        }
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x41b5edf2, Offset: 0x1122
// Size: 0xbf
function cable_deploy()
{
    thread deploy_icon();
    
    if ( getdvarint( @"hash_94cc2e00dc85444b", 1 ) && !isdefined( self.temp ) )
    {
        drone = spawn( "script_model", self.origin );
        drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
        drone.angles = self.angles;
        drone.speed = 0;
        drone forcenetfieldhighlod( 1 );
        drone notsolid();
        self.temp = drone;
    }
    
    self setscriptablepartstate( "redeploy_drone", "deploy" );
    
    /#
        function_205ac32211ef7d20();
    #/
    
    wait level.redeploy_drone_info_struct.var_70f8f33c72450ba;
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x4dcf3a38, Offset: 0x11e9
// Size: 0x3b
function deploy_icon()
{
    deploy_icon = spawnscriptable( "ob_redeploy_drone_deploy", self.origin - ( 0, 0, 2727 ) );
    wait 0.8;
    deploy_icon freescriptable();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xbdf7dd5b, Offset: 0x122c
// Size: 0x4c
function cable_retract()
{
    self setscriptablepartstate( "redeploy_drone", "retract" );
    
    /#
        function_205ac32211ef7d20();
    #/
    
    wait level.redeploy_drone_info_struct.var_f662574871be8bd2 - 0.7;
    self setscriptablepartstate( "redeploy_drone_cable_sfx", "retract_stop" );
    wait 0.7;
}

// Namespace ob_redeploy_drone
// Params 2
// Checksum 0x3b3cb482, Offset: 0x1280
// Size: 0x10f
function redeploy_drone_destroyed( eattacker, modelname )
{
    if ( getdvarint( @"hash_94cc2e00dc85444b", 1 ) && isdefined( self.temp ) )
    {
        self.temp delete();
    }
    
    self setscriptablepartstate( "redeploy_drone", "unavailable" );
    self setscriptablepartstate( "redeploy_drone_sfx", "disabled" );
    self setscriptablepartstate( "redeploy_drone_cable_sfx", "disabled" );
    self setscriptablepartstate( "redeploy_drone_anchor_sfx", "disabled" );
    
    /#
        function_a8470b55ba93350();
    #/
    
    self.b_occupied = 0;
    drone = spawn( "script_model", self.origin );
    drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
    drone.angles = self.angles;
    drone.speed = 0;
    self notify( #"redeploy_drone_destroyed" );
    
    if ( modelname == "ks_airstrike_target_br_ch3" )
    {
        eattacker.var_118d28a879158438++;
    }
    
    drone redeploy_drone_freefall();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x12776d3e, Offset: 0x1397
// Size: 0x4c
function redeploy_drone_freefall()
{
    level endon( #"game_ended" );
    waitframe();
    self setscriptablepartstate( "redeploy_drone_relocation_smoke_vfx", "enabled" );
    self physics_registerforcollisioncallback();
    thread function_2f9ddf986e50897();
    self waittill( #"collision" );
    redeploy_drone_explosion();
    wait 0.2;
    self delete();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x18435f05, Offset: 0x13eb
// Size: 0x23b
function function_2f9ddf986e50897()
{
    level endon( #"game_ended" );
    self endon( #"collision" );
    v_movement = ( 0, 0, 0 );
    
    if ( isdefined( self.v_destination ) )
    {
        v_movement = vectornormalize( self.v_destination - self.origin );
    }
    
    self physics_takecontrol( 1, self.origin, v_movement * self.speed * 1500 );
    i = level.redeploy_drone_info_struct.var_752a2de7a9a8ec9d;
    x = randomfloatrange( i / 2, i );
    x = utility::cointoss() ? x : x * -1;
    y = randomfloatrange( i / 2, i );
    y = utility::cointoss() ? y : y * -1;
    z = randomfloatrange( i / 10, i / 5 );
    z = utility::cointoss() ? z : z * -1;
    self physics_applyimpulse( self.origin + ( randomintrange( -50, 51 ), randomintrange( -50, 51 ), randomintrange( -50, 51 ) ), ( x, y, z ) );
    
    while ( true )
    {
        var_9e922f60b00adbff = anglestoforward( self.angles ) * randomfloatrange( -1 * level.redeploy_drone_info_struct.var_725b5a0d669b2688, level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        var_54f5cce3f0e25b20 = anglestoright( self.angles ) * randomfloatrange( -1 * level.redeploy_drone_info_struct.var_725b5a0d669b2688, level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        var_6fc4450d22b6d93f = anglestoup( self.angles ) * randomfloat( level.redeploy_drone_info_struct.var_725b5a0d669b2688 );
        self physics_applyimpulse( self.origin + ( randomintrange( -50, 51 ), randomintrange( -50, 51 ), randomintrange( -50, 51 ) ), var_9e922f60b00adbff + var_54f5cce3f0e25b20 + var_6fc4450d22b6d93f );
        wait 0.05;
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x35fef2a3, Offset: 0x162e
// Size: 0x75
function redeploy_drone_explosion()
{
    vfx = spawnscriptable( "ob_redeploy_drone_explosion", self.origin );
    waitframe();
    radiusdamage( self.origin, level.redeploy_drone_info_struct.i_explosion_radius, level.redeploy_drone_info_struct.var_e264b16858b3b6ba, level.redeploy_drone_info_struct.var_e287bb6858da1470, undefined, "MOD_EXPLOSIVE" );
    vfx freescriptable();
}

// Namespace ob_redeploy_drone
// Params 6
// Checksum 0xc3ddef9a, Offset: 0x16ab
// Size: 0x7c
function function_d3b7bea5de5c72( instance, part, state, player, bautouse, usestring )
{
    player thread function_c402a843dfb643ff( instance );
    player thread function_100353b7081f4f4b( instance );
    level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"hash_3a14200176a3c4aa", #player:player } );
}

// Namespace ob_redeploy_drone
// Params 1
// Checksum 0x6cbf17b5, Offset: 0x172f
// Size: 0xf8
function function_c402a843dfb643ff( instance )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    instance endon( #"death" );
    threshold_sq = squared( 19 );
    
    while ( distance2dsquared( self.origin, instance.origin ) > threshold_sq )
    {
        waitframe();
    }
    
    if ( getdvarint( @"hash_5fb7b2aa9e28003b", 1 ) )
    {
        thread function_98dc30d2ea69e8a4();
    }
    
    while ( distance2dsquared( self.origin, instance.origin ) < threshold_sq )
    {
        waitframe();
    }
    
    self notify( #"redeploy_drone_launch" );
    thread function_8245b29bb3cd5c27();
    thread function_11c9995c11585344();
    self waittill( #"ascender_detached" );
    
    if ( instance.origin[ 2 ] - self.origin[ 2 ] < 300 )
    {
        self playsoundevent( %"sndevent_redeploydrone_launch_player" );
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xef928c2e, Offset: 0x182f
// Size: 0x31
function function_98dc30d2ea69e8a4()
{
    self endon( #"disconnect" );
    self.var_8b4dd1978732538 = 1;
    waitframe();
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    self.var_8b4dd1978732538 = 0;
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xa8dce369, Offset: 0x1868
// Size: 0xe
function function_8245b29bb3cd5c27()
{
    level endon( #"game_ended" );
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x195fd345, Offset: 0x187e
// Size: 0x20e
function function_11c9995c11585344()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( !self isonground() )
    {
        nearbyplayers = utility::playersincylinder( self.origin, level.redeploy_drone_info_struct.var_12bfa36b3396fee1, undefined, level.redeploy_drone_info_struct.var_bb39751f42ca73bc );
        teamcompare = self.team;
        
        foreach ( targetplayer in nearbyplayers )
        {
            sameteam = teamcompare == targetplayer.team;
            
            if ( sameteam )
            {
                continue;
            }
            
            var_7459e3ac9f644b43 = !player::isreallyalive( targetplayer ) || targetplayer.inlaststand;
            
            if ( var_7459e3ac9f644b43 )
            {
                continue;
            }
            
            targetparachuting = targetplayer isparachuting() || targetplayer isinfreefall();
            
            if ( targetparachuting )
            {
                continue;
            }
            
            time = gettime();
            heardrecently = isdefined( targetplayer.heardparachuteoverheadtime ) && time - targetplayer.heardparachuteoverheadtime < level.redeploy_drone_info_struct.var_7a0ef63e9d1bf5cb;
            
            if ( heardrecently )
            {
                continue;
            }
            
            targetplayer.heardparachuteoverheadtime = time;
            operatorteam = teams::getteamdata( self.targetplayer.team, "players" );
            var_ad56e81b377cf4b4 = game[ "voice" ][ operatorteam ];
            targetplayer queuedialogforplayer( #"queue1", level.activeparachutersfactionvo[ var_ad56e81b377cf4b4 ], "respawning_enemy_in_area", 2 );
        }
        
        waitframe();
    }
}

// Namespace ob_redeploy_drone
// Params 1
// Checksum 0xe0f169c8, Offset: 0x1a94
// Size: 0x44
function function_100353b7081f4f4b( instance )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"redeploy_drone_launch" );
    instance waittill( #"redeploy_drone_destroyed" );
    self dropoffascender();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xca518db5, Offset: 0x1ae0
// Size: 0x126
function despawn_redeploy_drones()
{
    level endon( #"game_ended" );
    level waittill( #"br_circle_set" );
    
    while ( level.br_circle.circleindex != level.redeploy_drone_info_struct.var_93c50a30cdabecab )
    {
        wait level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
    }
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable getscriptablepartstate( "redeploy_drone" ) == "available" || scriptable getscriptablepartstate( "redeploy_drone" ) == "deploy" || scriptable getscriptablepartstate( "redeploy_drone" ) == "retract" )
        {
            scriptable thread function_8085580e5330a29e();
            wait randomintrange( 5, 10 );
        }
    }
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x83383d2a, Offset: 0x1c0e
// Size: 0x2
function function_200421d609523ac3()
{
    
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x33d4bcb9, Offset: 0x1c18
// Size: 0xe1
function function_e64f6d9b378833f8()
{
    /#
        if ( getdvarint( @"hash_20d28f147758431b", 0 ) && level.mapname == "<dev string:x32>" )
        {
            return;
        }
    #/
    
    level endon( #"game_ended" );
    ingas = 0;
    
    while ( !ingas )
    {
        foreach ( circle in level.radiation.instances )
        {
            ingas = circle radiation::is_position_inside( self.origin );
        }
        
        wait 1;
    }
    
    thread redeploy_drone_relocate();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xeeff1368, Offset: 0x1d01
// Size: 0x428
function redeploy_drone_relocate()
{
    level endon( #"game_ended" );
    level notify( "forced_kill_callout_" + self.origin );
    calloutmarkerping::function_608710c894185549();
    i_circle_index = 0;
    i_wait = level.redeploy_drone_info_struct.var_282669dff723ff8 - level.redeploy_drone_info_struct.var_c91738a31073297d * i_circle_index;
    
    if ( i_wait < level.redeploy_drone_info_struct.var_d0553b05b6a9d317 )
    {
        i_wait = level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
    }
    
    wait i_wait;
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    target_scriptable = undefined;
    f_closest_sq = undefined;
    
    foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
    {
        if ( scriptable.b_occupied )
        {
            continue;
        }
        
        if ( scriptable getscriptablepartstate( "redeploy_drone" ) == "available" || scriptable getscriptablepartstate( "redeploy_drone" ) == "deploy" || scriptable getscriptablepartstate( "redeploy_drone" ) == "retract" )
        {
            continue;
        }
        
        if ( isdefined( level.aether_storm.radiation ) && level.aether_storm.radiation radiation::is_position_inside( scriptable.origin ) )
        {
            continue;
        }
        
        var_6468d285771e5ed2 = distance( scriptable.origin, self.origin ) / 489.7;
        var_6468d285771e5ed2 += 3;
        var_291b292f39e2ae67 = level.aether_storm.radiation radiation::function_ca7a405fde79979f( scriptable.origin );
        
        if ( var_291b292f39e2ae67 <= var_6468d285771e5ed2 )
        {
            continue;
        }
        
        if ( scriptable function_e2169a00d5058341() )
        {
            /#
                scriptable function_40b374f871ce7b65();
            #/
            
            continue;
        }
        
        distance_sq = distance2dsquared( self.origin, scriptable.origin );
        
        if ( !isdefined( f_closest_sq ) || distance_sq < f_closest_sq )
        {
            f_closest_sq = distance_sq;
            target_scriptable = scriptable;
        }
    }
    
    if ( !isdefined( target_scriptable ) )
    {
        self setscriptablepartstate( "redeploy_drone_interact", "disabled" );
        cable_retract();
        thread function_c23bc0649c658bea();
        return;
    }
    
    target_scriptable.b_occupied = 1;
    target_scriptable.b_used = 1;
    cable_retract();
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    self setscriptablepartstate( "redeploy_drone_cable_sfx", "retract_stop" );
    set_redeploy_drone_in_gas();
    drone = spawn( "script_model", self.origin );
    drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
    drone.angles = self.angles;
    drone.speed = 0;
    drone setcandamage( 1 );
    drone forcenetfieldhighlod( 1 );
    
    /#
        drone thread debug_sphere( undefined, 25, ( 1, 0, 0 ) );
    #/
    
    /#
        drone thread function_c4d1ea35667e37d4( ( 1, 0, 0 ) );
    #/
    
    drone thread function_f8019c12697fcf50( target_scriptable );
    drone thread function_76cb6eb6a9700637( target_scriptable );
    drone thread redeploy_drone_sfx_watcher( self, target_scriptable );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        wait 0.05;
    }
    
    drone notify( #"relocation_complete" );
    drone callback::callback( "on_redeploy_drone_relocated" );
    drone delete();
    target_scriptable cable_deploy();
    
    if ( target_scriptable getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    target_scriptable set_redeploy_drone_available();
    target_scriptable thread function_e64f6d9b378833f8();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x228a3d10, Offset: 0x2131
// Size: 0xfe
function function_c23bc0649c658bea()
{
    level notify( "forced_kill_callout_" + self.origin );
    calloutmarkerping::function_608710c894185549();
    
    if ( getdvarint( @"hash_94cc2e00dc85444b", 1 ) && isdefined( self.temp ) )
    {
        self.temp delete();
    }
    
    self setscriptablepartstate( "redeploy_drone", "unavailable" );
    self setscriptablepartstate( "redeploy_drone_sfx", "disabled" );
    self setscriptablepartstate( "redeploy_drone_cable_sfx", "disabled" );
    self setscriptablepartstate( "redeploy_drone_anchor_sfx", "disabled" );
    
    /#
        function_a8470b55ba93350();
    #/
    
    self.b_occupied = 0;
    drone = spawn( "script_model", self.origin );
    drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
    drone.angles = self.angles;
    drone.speed = 0;
    self notify( #"redeploy_drone_destroyed" );
    drone redeploy_drone_freefall();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0x8dc32c6b, Offset: 0x2237
// Size: 0x220
function function_8085580e5330a29e()
{
    level endon( #"game_ended" );
    i_circle_index = 0;
    i_wait = level.redeploy_drone_info_struct.var_282669dff723ff8 - level.redeploy_drone_info_struct.var_c91738a31073297d * i_circle_index;
    
    if ( i_wait < level.redeploy_drone_info_struct.var_d0553b05b6a9d317 )
    {
        i_wait = level.redeploy_drone_info_struct.var_d0553b05b6a9d317;
    }
    
    wait i_wait;
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    s_despawn = spawnstruct();
    var_edbf62b3aa438ff0 = br_circle::getsafecircleorigin();
    s_despawn.origin = self.origin + vectornormalize( self.origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], self.origin[ 2 ] ) ) * 20000;
    s_despawn.angles = vectortoangles( self.origin - ( var_edbf62b3aa438ff0[ 0 ], var_edbf62b3aa438ff0[ 1 ], self.origin[ 2 ] ) );
    cable_retract();
    
    if ( self getscriptablepartstate( "redeploy_drone" ) == "unavailable" )
    {
        return;
    }
    
    set_redeploy_drone_in_gas();
    drone = spawn( "script_model", self.origin );
    drone setmodel( "jup_ob_mil_air_drone_redeploy_relocate_lights" );
    drone.angles = self.angles;
    drone.speed = 0;
    drone forcenetfieldhighlod( 1 );
    
    /#
        drone thread debug_sphere( undefined, 25, ( 1, 0, 0 ) );
    #/
    
    /#
        drone thread function_c4d1ea35667e37d4( ( 1, 0, 0 ) );
    #/
    
    drone thread function_f8019c12697fcf50( s_despawn );
    drone thread function_76cb6eb6a9700637( s_despawn );
    drone thread redeploy_drone_sfx_watcher( self );
    
    while ( !( isdefined( drone.b_movement_complete ) && isdefined( drone.var_fe7274eb7e5153e7 ) ) )
    {
        wait 0.05;
    }
    
    drone notify( #"relocation_complete" );
    drone delete();
}

// Namespace ob_redeploy_drone
// Params 2
// Checksum 0xcd3304a6, Offset: 0x245f
// Size: 0x3e
function redeploy_drone_relocate_destroyed( eattacker, modelname )
{
    if ( modelname == "ks_airstrike_target_br_ch3" )
    {
        eattacker.var_118d28a879158438++;
    }
    
    self.owner = eattacker;
    redeploy_drone_freefall();
}

// Namespace ob_redeploy_drone
// Params 0
// Checksum 0xa803ee4a, Offset: 0x24a5
// Size: 0xc7, Type: bool
function function_e2169a00d5058341()
{
    foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
    {
        if ( scriptable == self )
        {
            continue;
        }
        
        if ( scriptable.b_occupied )
        {
            if ( distance2dsquared( self.origin, scriptable.origin ) < level.redeploy_drone_info_struct.var_10fed330f6746fa6 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_redeploy_drone
// Params 1
// Checksum 0xd1e55f80, Offset: 0x2575
// Size: 0x33f
function function_f8019c12697fcf50( target_scriptable )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self.v_destination = target_scriptable.origin;
    
    /#
        thread function_22c9b53930d26515( target_scriptable );
    #/
    
    while ( self.speed < level.redeploy_drone_info_struct.i_max_speed )
    {
        self.speed += 1;
        
        if ( self.speed > level.redeploy_drone_info_struct.i_max_speed )
        {
            self.speed = level.redeploy_drone_info_struct.i_max_speed;
        }
        
        self moveto( self.origin + self.speed * vectornormalize( self.v_destination - self.origin ), 0.05, 0, 0 );
        wait 0.05;
    }
    
    if ( self.speed > level.redeploy_drone_info_struct.i_max_speed )
    {
        while ( distance2dsquared( self.origin, self.v_destination ) > squared( self.speed * 20 * level.redeploy_drone_info_struct.var_251b2c6b71a01138 ) )
        {
            self moveto( self.origin + self.speed * vectornormalize( self.v_destination - self.origin ), 0.05, 0, 0 );
            wait 0.05;
        }
        
        self notify( #"redeploy_drone_arrive" );
        
        while ( distance2dsquared( self.origin, self.v_destination ) > 0.01 )
        {
            self moveto( self.origin + ( self.v_destination - self.origin ) * 0.05 / level.redeploy_drone_info_struct.var_251b2c6b71a01138, 0.05, 0, 0 );
            self.speed *= 0.95;
            wait 0.05;
        }
    }
    else
    {
        while ( distance2dsquared( self.origin, self.v_destination ) > 250000 )
        {
            self moveto( self.origin + self.speed * vectornormalize( self.v_destination - self.origin ), 0.05, 0, 0 );
            wait 0.05;
        }
        
        self notify( #"redeploy_drone_arrive" );
        
        while ( distance2dsquared( self.origin, self.v_destination ) > 0.01 )
        {
            self moveto( self.origin + ( self.v_destination - self.origin ) * 0.1, 0.05, 0, 0 );
            self.speed *= 0.9;
            wait 0.05;
        }
    }
    
    self moveto( self.v_destination, 0.05, 0, 0 );
    wait 0.05;
    self.speed = 0;
    self.v_destination = undefined;
    self.b_movement_complete = 1;
}

// Namespace ob_redeploy_drone
// Params 1
// Checksum 0xfeacb6d9, Offset: 0x28bc
// Size: 0x2bc
function function_76cb6eb6a9700637( target_scriptable )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    v_diff = vectornormalize( target_scriptable.origin - self.origin );
    f_yaw_diff = vectortoangles( v_diff )[ 1 ] - self.angles[ 1 ];
    
    if ( f_yaw_diff < -180 )
    {
        f_yaw_diff += 360;
    }
    
    if ( f_yaw_diff > 180 )
    {
        f_yaw_diff -= 360;
    }
    
    f_forward_dot = vectordot( v_diff, anglestoforward( self.angles ) );
    f_right_dot = vectordot( v_diff, anglestoright( self.angles ) );
    f_frames = abs( f_yaw_diff );
    var_8e605a9183d0adda = f_frames - 90;
    
    if ( var_8e605a9183d0adda > 0 )
    {
        var_cdd066867dc4ec27 = var_8e605a9183d0adda / f_frames;
        self rotateby( ( 30 * f_forward_dot + 15, f_yaw_diff * var_cdd066867dc4ec27, 30 * f_right_dot ), var_8e605a9183d0adda * 0.025, var_8e605a9183d0adda / 2 * 0.025, 0 );
        wait var_8e605a9183d0adda * 0.025;
        var_9b14118f1a9651d5 = f_frames - var_8e605a9183d0adda;
        self rotateto( ( 30, vectortoangles( v_diff )[ 1 ], 0 ), var_9b14118f1a9651d5 * 0.025, 0, var_9b14118f1a9651d5 / 2 * 0.025 );
        wait var_9b14118f1a9651d5 * 0.025;
    }
    else
    {
        f_halftime = f_frames / 2 * 0.025;
        
        if ( f_halftime < 1 )
        {
            f_halftime = 1;
        }
        
        self rotateby( ( 15 * f_forward_dot, f_yaw_diff / 2, 15 * f_right_dot ), f_halftime, f_halftime / 2, 0 );
        wait f_halftime;
        self rotateto( ( 30, vectortoangles( v_diff )[ 1 ], 0 ), f_halftime, 0, f_halftime / 2 );
        wait f_halftime;
    }
    
    self waittill( #"redeploy_drone_arrive" );
    f_yaw_diff = target_scriptable.angles[ 1 ] - self.angles[ 1 ];
    
    if ( f_yaw_diff < -180 )
    {
        f_yaw_diff += 360;
    }
    
    if ( f_yaw_diff > 180 )
    {
        f_yaw_diff -= 360;
    }
    
    f_forward_dot = vectordot( anglestoforward( self.angles ), anglestoforward( target_scriptable.angles ) );
    f_right_dot = vectordot( anglestoright( self.angles ), anglestoforward( target_scriptable.angles ) );
    f_halftime = 1;
    self rotateby( ( -30 * f_forward_dot - 30, f_yaw_diff / 2, 30 * f_right_dot ), f_halftime, f_halftime / 2, 0 );
    wait f_halftime;
    self rotateto( ( 0, target_scriptable.angles[ 1 ], 0 ), f_halftime, 0, f_halftime / 2 );
    wait f_halftime;
    self.var_fe7274eb7e5153e7 = 1;
}

// Namespace ob_redeploy_drone
// Params 2
// Checksum 0xcaf88afc, Offset: 0x2b80
// Size: 0x96
function redeploy_drone_sfx_watcher( departure_scriptable, arrival_scriptable )
{
    self endon( #"entitydeleted" );
    wait 1;
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "relocation_loop" );
    
    if ( isdefined( departure_scriptable ) )
    {
        departure_scriptable setscriptablepartstate( "redeploy_drone_sfx", "disabled" );
    }
    
    self waittill( #"redeploy_drone_arrive" );
    
    if ( isdefined( arrival_scriptable ) )
    {
        arrival_scriptable setscriptablepartstate( "redeploy_drone_sfx", "relocation_sfx_end" );
        wait 0.5;
        arrival_scriptable setscriptablepartstate( "redeploy_drone_sfx", "engine_idle_sfx" );
    }
    
    self setscriptablepartstate( "redeploy_drone_relocation_sfx", "relocation_end" );
}

/#

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xb30d1f5a, Offset: 0x2c1e
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xb9ea81e5, Offset: 0x2c2b
    // Size: 0x83, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        function_2da17367471b94e9( @"hash_20d28f147758431b", &function_44cc73900f4ab5c4 );
        function_2da17367471b94e9( @"hash_1b823e69b7bcb477", &function_35e87715d9077624 );
        function_2da17367471b94e9( @"hash_7206433d469d7d0a", &function_74861cf53dcd878b );
        function_2da17367471b94e9( @"hash_44c9b804cfee044b", &function_9ad0ac1dbf305540 );
        function_2da17367471b94e9( @"scr_debug_redeploy_drones_spawn_all", &function_41c7a536982a6ff5 );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xacadcfb, Offset: 0x2cb6
    // Size: 0x9c, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x42>" );
        devgui::add_devgui_func( "<dev string:x55>", "<dev string:x5b>", &function_f55fb32a09a9c23e );
        devgui::add_devgui_func( "<dev string:x71>", "<dev string:x87>", &function_23db4a1fa55837bc );
        devgui::add_devgui_func( "<dev string:xad>", "<dev string:xc8>", &function_e9f706dab8fb7f39 );
        devgui::add_devgui_func( "<dev string:xf3>", "<dev string:x103>", &function_f2bc4e0f4fdee368 );
        devgui::add_devgui_func( "<dev string:x123>", "<dev string:x132>", &function_64a9e6a7b755d1ae );
        devgui::add_devgui_func( "<dev string:x149>", "<dev string:x159>", &function_5b4d67b87505f46f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_redeploy_drone
    // Params 2
    // Checksum 0xe65ea076, Offset: 0x2d5a
    // Size: 0x27, Type: dev
    function function_2da17367471b94e9( dvar, func )
    {
        if ( getdvarint( dvar, 0 ) )
        {
            [[ func ]]();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xb7f360f9, Offset: 0x2d89
    // Size: 0x28, Type: dev
    function function_f55fb32a09a9c23e()
    {
        if ( !getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            function_3ac4f9785cd1eae();
            return;
        }
        
        function_e0eee23b41f48d50();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x920f0e4e, Offset: 0x2db9
    // Size: 0x1f, Type: dev
    function function_3ac4f9785cd1eae()
    {
        setdvar( @"scr_debug_redeploy_drones", 1 );
        iprintlnbold( "<dev string:x171>" );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x82689d53, Offset: 0x2de0
    // Size: 0x1e, Type: dev
    function function_e0eee23b41f48d50()
    {
        setdvar( @"scr_debug_redeploy_drones", 0 );
        iprintlnbold( "<dev string:x19b>" );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x4412b45c, Offset: 0x2e06
    // Size: 0x28, Type: dev
    function function_23db4a1fa55837bc()
    {
        if ( !getdvarint( @"hash_1b823e69b7bcb477", 0 ) )
        {
            function_35e87715d9077624();
            return;
        }
        
        function_9591370c4b42ee9e();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x64e61112, Offset: 0x2e36
    // Size: 0x27, Type: dev
    function function_35e87715d9077624()
    {
        setdvar( @"hash_1b823e69b7bcb477", 1 );
        iprintlnbold( "<dev string:x1c6>" );
        level thread function_456dc53c4ccc3357();
    }

    // Namespace ob_redeploy_drone
    // Params 2
    // Checksum 0xd21a6c4f, Offset: 0x2e65
    // Size: 0x278, Type: dev
    function function_456dc53c4ccc3357( v_position, i_radius )
    {
        level endon( #"game_ended" );
        level endon( #"hash_319d3c57e79e627c" );
        var_4ef8ad119102a654 = getdvarint( @"hash_9bd3724f70106775", 30000 );
        
        while ( true )
        {
            f_closest_dot = -1;
            scr_closest = undefined;
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                v_player = anglestoforward( level.players[ 0 ] getplayerangles() );
                v_scriptable = vectornormalize( scriptable.origin - level.players[ 0 ] geteye() );
                f_dot = vectordot( v_player, v_scriptable );
                
                if ( f_dot >= f_closest_dot )
                {
                    f_closest_dot = f_dot;
                    scr_closest = scriptable;
                }
            }
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( scriptable == scr_closest )
                {
                    sphere( scriptable.origin, 200, ( 1, 1, 1 ), 0, 2 );
                    cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_4ef8ad119102a654, ( 0, 0, 1 ), 0, 2 );
                    continue;
                }
                
                cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_4ef8ad119102a654, ( 0.5, 0.5, 0.5 ), 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xb2cad0c8, Offset: 0x30e5
    // Size: 0x2a, Type: dev
    function function_9591370c4b42ee9e()
    {
        setdvar( @"hash_1b823e69b7bcb477", 0 );
        iprintlnbold( "<dev string:x200>" );
        level notify( #"hash_319d3c57e79e627c" );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xc234fb5d, Offset: 0x3117
    // Size: 0x28, Type: dev
    function function_e9f706dab8fb7f39()
    {
        if ( !getdvarint( @"hash_7206433d469d7d0a", 0 ) )
        {
            function_74861cf53dcd878b();
            return;
        }
        
        function_1055ac56ead996af();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x8d6d787a, Offset: 0x3147
    // Size: 0x27, Type: dev
    function function_74861cf53dcd878b()
    {
        setdvar( @"hash_7206433d469d7d0a", 1 );
        iprintlnbold( "<dev string:x23b>" );
        level thread function_aefb6f1dcf5f9218();
    }

    // Namespace ob_redeploy_drone
    // Params 2
    // Checksum 0x84b261d2, Offset: 0x3176
    // Size: 0x278, Type: dev
    function function_aefb6f1dcf5f9218( v_position, i_radius )
    {
        level endon( #"game_ended" );
        level endon( #"hash_11cdd87366d33bf9" );
        var_75d3c72461966741 = getdvarint( @"hash_59c137234dad4ad6", 8000 );
        
        while ( true )
        {
            f_closest_dot = -1;
            scr_closest = undefined;
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                v_player = anglestoforward( level.players[ 0 ] getplayerangles() );
                v_scriptable = vectornormalize( scriptable.origin - level.players[ 0 ] geteye() );
                f_dot = vectordot( v_player, v_scriptable );
                
                if ( f_dot >= f_closest_dot )
                {
                    f_closest_dot = f_dot;
                    scr_closest = scriptable;
                }
            }
            
            foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( scriptable == scr_closest )
                {
                    sphere( scriptable.origin, 200, ( 1, 1, 1 ), 0, 2 );
                    cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_75d3c72461966741, ( 1, 1, 0 ), 0, 2 );
                    continue;
                }
                
                cylinder( scriptable.origin - ( 0, 0, 10 ), scriptable.origin + ( 0, 0, 10 ), var_75d3c72461966741, ( 0.5, 0.5, 0.5 ), 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xc89798fe, Offset: 0x33f6
    // Size: 0x2a, Type: dev
    function function_1055ac56ead996af()
    {
        setdvar( @"hash_7206433d469d7d0a", 0 );
        iprintlnbold( "<dev string:x27a>" );
        level notify( #"hash_11cdd87366d33bf9" );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xc2410db8, Offset: 0x3428
    // Size: 0x28, Type: dev
    function function_f2bc4e0f4fdee368()
    {
        if ( !getdvarint( @"hash_44c9b804cfee044b", 0 ) )
        {
            function_9ad0ac1dbf305540();
            return;
        }
        
        function_a962db6b7771f3da();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x99f09316, Offset: 0x3458
    // Size: 0xa2, Type: dev
    function function_9ad0ac1dbf305540()
    {
        setdvar( @"hash_44c9b804cfee044b", 1 );
        iprintlnbold( "<dev string:x2ba>" );
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable thread function_acb1eaea68b43a3e();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x73f868c2, Offset: 0x3502
    // Size: 0x172, Type: dev
    function function_acb1eaea68b43a3e()
    {
        level endon( #"game_ended" );
        level endon( #"hash_ff6880a7db0a6828" );
        
        while ( true )
        {
            switch ( self.str_surftype )
            {
                case #"hash_296fec58e16e327":
                case #"hash_1f2e430eca34d788":
                case #"hash_2dc2bd39328def65":
                case #"hash_2fa4167540164873":
                case #"hash_3990683480267242":
                case #"hash_588c5c47805606eb":
                case #"hash_5f33d5485b7f33ed":
                case #"hash_5ff12d0a2c109d2c":
                case #"hash_6dc36f3e31f59c8b":
                case #"hash_d4e7d6c49368be7f":
                    print3d( self.var_bd4fec0091dedb5c + ( 0, 0, 200 ), self.str_surftype, ( 1, 1, 1 ), 1, 10, 2, 1 );
                    sphere( self.var_bd4fec0091dedb5c, 20, ( 1, 1, 1 ), 0, 2 );
                    break;
                default:
                    print3d( self.var_bd4fec0091dedb5c + ( 0, 0, 200 ), self.str_surftype, ( 1, 0, 0 ), 1, 10, 2, 1 );
                    sphere( self.var_bd4fec0091dedb5c, 20, ( 1, 0, 0 ), 0, 2 );
                    break;
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xc941d4c8, Offset: 0x367c
    // Size: 0x2a, Type: dev
    function function_a962db6b7771f3da()
    {
        setdvar( @"scr_debug_redeploy_drones", 0 );
        iprintlnbold( "<dev string:x19b>" );
        level notify( #"hash_ff6880a7db0a6828" );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x2e985ece, Offset: 0x36ae
    // Size: 0x88, Type: dev
    function function_64a9e6a7b755d1ae()
    {
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable thread function_f82737388fc2162c();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x5e3324c2, Offset: 0x373e
    // Size: 0x13, Type: dev
    function function_f82737388fc2162c()
    {
        cable_deploy();
        set_redeploy_drone_available();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x80a93601, Offset: 0x3759
    // Size: 0x88, Type: dev
    function function_5b4d67b87505f46f()
    {
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable thread cable_retract();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x8ed2c3ad, Offset: 0x37e9
    // Size: 0x393, Type: dev
    function function_44cc73900f4ab5c4()
    {
        if ( level.mapname != "<dev string:x32>" )
        {
            return;
        }
        
        level notify( #"hash_a48f1e6117d0ea8d" );
        level endon( #"hash_a48f1e6117d0ea8d" );
        scr_static = spawnscriptable( "<dev string:x38e>", ( 0, 0, 2740 ) );
        var_45bdde538ab6ef4e = spawnscriptable( "<dev string:x38e>", ( 0, 0, 0 ) );
        var_45bddd538ab6ed1b = spawnscriptable( "<dev string:x38e>", ( 0, 0, 0 ) );
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = scr_static;
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = var_45bdde538ab6ef4e;
        level.redeploy_drone_info_struct.var_dc2234786c8913dd[ level.redeploy_drone_info_struct.var_dc2234786c8913dd.size ] = var_45bddd538ab6ed1b;
        var_45bdde538ab6ef4e.i_random = randomint( 360 );
        var_45bdde538ab6ef4e.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bdde538ab6ef4e.i_random, 0 ) );
        var_45bddd538ab6ed1b.i_random = var_45bdde538ab6ef4e.i_random + randomintrange( 90, 270 );
        
        if ( var_45bddd538ab6ed1b.i_random >= 360 )
        {
            var_45bddd538ab6ed1b.i_random -= 360;
        }
        
        var_45bddd538ab6ed1b.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bddd538ab6ed1b.i_random, 0 ) );
        scr_static set_redeploy_drone_available();
        scr_static setscriptablepartstate( "<dev string:x3a0>", "<dev string:x3b3>" );
        scr_static setscriptablepartstate( "<dev string:x3c3>", "<dev string:x3d6>" );
        var_45bdde538ab6ef4e function_92558e2048ced142();
        var_45bddd538ab6ed1b set_redeploy_drone_available();
        var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x3a0>", "<dev string:x3b3>" );
        var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x3c3>", "<dev string:x3d6>" );
        
        while ( true )
        {
            scr_static thread redeploy_drone_relocate();
            wait 6;
            var_45bddd538ab6ed1b redeploy_drone_relocate();
            wait 6;
            var_45bddd538ab6ed1b.i_random = var_45bdde538ab6ef4e.i_random + randomintrange( 90, 270 );
            
            if ( var_45bddd538ab6ed1b.i_random >= 360 )
            {
                var_45bddd538ab6ed1b.i_random -= 360;
            }
            
            var_45bddd538ab6ed1b.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bddd538ab6ed1b.i_random, 0 ) );
            var_45bddd538ab6ed1b function_92558e2048ced142();
            var_45bddd538ab6ed1b setscriptablepartstate( "<dev string:x3a0>", "<dev string:x3de>" );
            scr_static thread redeploy_drone_relocate();
            wait 6;
            var_45bdde538ab6ef4e redeploy_drone_relocate();
            wait 6;
            var_45bdde538ab6ef4e.i_random = var_45bddd538ab6ed1b.i_random + randomintrange( 90, 270 );
            
            if ( var_45bdde538ab6ef4e.i_random >= 360 )
            {
                var_45bdde538ab6ef4e.i_random -= 360;
            }
            
            var_45bdde538ab6ef4e.origin = scr_static.origin + 5500 * anglestoforward( ( 0, var_45bdde538ab6ef4e.i_random, 0 ) );
            var_45bdde538ab6ef4e function_92558e2048ced142();
            var_45bdde538ab6ef4e setscriptablepartstate( "<dev string:x3a0>", "<dev string:x3de>" );
        }
    }

    // Namespace ob_redeploy_drone
    // Params 2
    // Checksum 0xeb7e295d, Offset: 0x3b84
    // Size: 0x24, Type: dev
    function function_824ce39a43f46e7( instance, time )
    {
        wait time;
        instance redeploy_drone_destroyed();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xf5977a35, Offset: 0x3bb0
    // Size: 0x46, Type: dev
    function function_92558e2048ced142()
    {
        self setscriptablepartstate( "<dev string:x3e7>", "<dev string:x3f6>" );
        self setscriptablepartstate( "<dev string:x402>", "<dev string:x3de>" );
        self setscriptablepartstate( "<dev string:x41b>", "<dev string:x3de>" );
        self.b_occupied = 0;
        function_a8470b55ba93350();
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xa6ad88e0, Offset: 0x3bfe
    // Size: 0x19, Type: dev
    function function_65401ca948591d1e()
    {
        function_24c539ca7be1d0ca( ( 0, 1, 0 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x2bb75342, Offset: 0x3c1f
    // Size: 0x19, Type: dev
    function function_a8470b55ba93350()
    {
        function_24c539ca7be1d0ca( ( 1, 1, 0 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x2091cf11, Offset: 0x3c40
    // Size: 0x19, Type: dev
    function function_7a2988a0d2d64f3b()
    {
        function_24c539ca7be1d0ca( ( 0, 1, 1 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x9d744cfa, Offset: 0x3c61
    // Size: 0x19, Type: dev
    function function_40b374f871ce7b65()
    {
        function_24c539ca7be1d0ca( ( 0, 0, 1 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xfcebc61b, Offset: 0x3c82
    // Size: 0x19, Type: dev
    function function_21f17ba620ead39e()
    {
        function_24c539ca7be1d0ca( ( 1, 0, 0 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0xb5a34630, Offset: 0x3ca3
    // Size: 0x19, Type: dev
    function function_205ac32211ef7d20()
    {
        function_24c539ca7be1d0ca( ( 1, 0.5, 0 ) );
    }

    // Namespace ob_redeploy_drone
    // Params 1
    // Checksum 0xa9bd6930, Offset: 0x3cc4
    // Size: 0x58, Type: dev
    function function_24c539ca7be1d0ca( var_12db7f1af2b8a2e0 )
    {
        self notify( #"hash_a3bf32387f8edf95" );
        thread debug_sphere( self.origin, 100, var_12db7f1af2b8a2e0 );
        thread debug_line( self.origin, self.origin - ( 0, 0, 2700 ), var_12db7f1af2b8a2e0 );
    }

    // Namespace ob_redeploy_drone
    // Params 3
    // Checksum 0xa4097c4e, Offset: 0x3d24
    // Size: 0x55, Type: dev
    function debug_line( var_16b17372f24ea78c, var_16b17672f24eae25, var_12db7f1af2b8a2e0 )
    {
        self endon( #"hash_a3bf32387f8edf95" );
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
            {
                line( var_16b17372f24ea78c, var_16b17672f24eae25, var_12db7f1af2b8a2e0, 1, 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 3
    // Checksum 0xe19c0d63, Offset: 0x3d81
    // Size: 0x70, Type: dev
    function debug_sphere( v_pos, i_radius, var_12db7f1af2b8a2e0 )
    {
        self endon( #"hash_a3bf32387f8edf95" );
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
            {
                if ( isdefined( v_pos ) )
                {
                    sphere( v_pos, i_radius, var_12db7f1af2b8a2e0, 0, 2 );
                }
                else
                {
                    sphere( self.origin, i_radius, var_12db7f1af2b8a2e0, 0, 2 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 1
    // Checksum 0x148ee906, Offset: 0x3df9
    // Size: 0x60, Type: dev
    function function_22c9b53930d26515( target_scriptable )
    {
        self endon( #"redeploy_drone_arrive" );
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
            {
                line( self.origin, target_scriptable.origin, ( 1, 1, 0 ), 1, 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 1
    // Checksum 0xd2fda22a, Offset: 0x3e61
    // Size: 0xab, Type: dev
    function function_c4d1ea35667e37d4( var_12db7f1af2b8a2e0 )
    {
        if ( !getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            return;
        }
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"scr_debug_redeploy_drones", 0 ) )
            {
                line( self.origin, self.origin + anglestoforward( self.angles ) * 100, var_12db7f1af2b8a2e0, 1, 0, 2 );
                line( self.origin - anglestoright( self.angles ) * 75, self.origin + anglestoright( self.angles ) * 75, var_12db7f1af2b8a2e0, 1, 0, 2 );
            }
            
            waitframe();
        }
    }

    // Namespace ob_redeploy_drone
    // Params 0
    // Checksum 0x86042615, Offset: 0x3f14
    // Size: 0x11d, Type: dev
    function function_41c7a536982a6ff5()
    {
        if ( !getdvarint( @"scr_debug_redeploy_drones", 0 ) )
        {
            return;
        }
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_531f28cf3d055c11 )
        {
            scriptable spawn_redeploy_drone();
        }
        
        foreach ( scriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
        {
            scriptable cable_deploy();
            scriptable set_redeploy_drone_available();
        }
    }

#/
