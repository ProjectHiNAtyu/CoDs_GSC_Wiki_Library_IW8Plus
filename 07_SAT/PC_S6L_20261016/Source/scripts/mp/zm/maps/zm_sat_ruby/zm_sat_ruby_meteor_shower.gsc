// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_meteor_shower.gsc  (hash_784116aa46707d15.gscc) (size: 11585 Bytes / 0x2d41 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6acdf565 (1791882597)
// size ...... 11585 (0x2d41)
// includes .. 17  (offset: 0x2aed)
// strings ... 37  (offset: 0x2b75)
// dev strs .. 0   (offset: 0x2d41)
// exports ... 24  (offset: 0x1bdd)
// cseg ...... 0x3ab + 0x1832 (0x1bdd)
// imports ... 97  (offset: 0x1f9d)
// animtree1 . 0   (offset: 0x2d41)
// animtree2 . 0   (offset: 0x2d41)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_meteor_shower;

// Namespace zm_sat_ruby_meteor_shower
// Params 0
// Checksum 0xbda843e2, Offset: 0x3c9
// Size: 0x1b
function init()
{
    if ( !getdvarint( @"hash_513d74c8d078142d", 0 ) )
    {
        function_844fa2fcbb92d7eb();
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0
// Checksum 0x7c59b3d5, Offset: 0x3ec
// Size: 0x163
function function_844fa2fcbb92d7eb()
{
    level.meteorshower = {};
    level.meteorshower.indoortriggers = getentarray( "trig_force_inside", "targetname" );
    level.meteorshower.outdoortriggers = getentarray( "trig_force_outside", "targetname" );
    level.meteorshower.var_61317d3c911f068c = throttle::throttle_initialize( "monitor_player_movements_during_meteor_shower", 1, 3 );
    level waittill( #"scriptables_ready" );
    level thread function_b2b82d59e8abc842();
    callback::add( #"player_laststand", &function_dd87fef17e864d87 );
    callback::add( #"player_laststand_revived", &function_6785e794e345403c );
    callback::add( #"player_death", &function_4b39478aa22f0dd5 );
    level callback::add( "on_round_end", &on_round_end );
    level.meteorshower.indoorzones = [ "zone_mainhall", "zone_planetarium", "zone_telescope", "zone_orrery_airlock", "zone_mainhall_left", "zone_planetarium_hallway_01", "zone_planetarium_hallway_02", "zone_planetarium_hallway_03", "zone_orrery_close_to_mainhall", "zone_orrery_upper_floor", "zone_orrery_close_to_courtyard", "zone_orrery", "zone_orrery_lower" ];
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0x3b7bfe0c, Offset: 0x557
// Size: 0x17
function function_dd87fef17e864d87( params )
{
    self.meteors_ignore = 1;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0x151d64c7, Offset: 0x576
// Size: 0x19
function function_6785e794e345403c( params )
{
    wait 5;
    self.meteors_ignore = undefined;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0xd32d5439, Offset: 0x597
// Size: 0x16
function function_4b39478aa22f0dd5( params )
{
    self.meteors_ignore = undefined;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0
// Checksum 0x9721893c, Offset: 0x5b5
// Size: 0xa3
function function_b2b82d59e8abc842()
{
    self notify( #"hash_f5a3bd2c63d691c5" );
    self endon( #"hash_f5a3bd2c63d691c5" );
    level endon( #"game_ended" );
    level endon( #"hash_99c5b834341eac0" );
    deactivateworldevent( "we_vfx_meteor_shower" );
    
    while ( true )
    {
        level waittill( #"on_round_start" );
        round_number = zm_utility::get_round_number();
        
        if ( zm_round_spawning::is_special_round( round_number ) )
        {
            activateworldevent( "we_vfx_meteor_shower" );
            level thread function_a34deca2625e1056();
            level waittill( #"on_round_end" );
            deactivateworldevent( "we_vfx_meteor_shower" );
            level notify( #"hash_1691f615d0cfcf52" );
        }
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0x5a4b81b9, Offset: 0x660
// Size: 0x65
function function_a34deca2625e1056( b_skipdelay = 0 )
{
    level endon( #"game_ended" );
    level endon( #"hash_99c5b834341eac0" );
    level endon( #"hash_1691f615d0cfcf52" );
    
    if ( !b_skipdelay )
    {
        delay = randomfloatrange( 10, 15 );
        wait delay;
    }
    
    level thread function_bd3ba33023c73d63();
    level thread do_meteor_shower();
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0, eflags: 0xc
// Checksum 0xfb81dea, Offset: 0x6cd
// Size: 0x44f
function private function_bd3ba33023c73d63()
{
    self notify( #"hash_cb674aa895b37afd" );
    self endon( #"hash_cb674aa895b37afd" );
    level endon( #"game_ended" );
    level endon( #"hash_99c5b834341eac0" );
    level endon( #"hash_1691f615d0cfcf52" );
    
    while ( true )
    {
        level.meteorshower.var_da4f4cdd7193471f = [];
        
        foreach ( player in level.players )
        {
            var_9a44b11a34204aa1 = undefined;
            var_da4f4cdd7193471f = { #meteorignore:player.meteors_ignore, #var_e418631e0dd784e3:[], #zone:player zone_manager::get_current_zone(), #playerangles:player.angles, #playerorigin:player.origin };
            
            foreach ( indoortrigger in level.meteorshower.indoortriggers )
            {
                if ( indoortrigger istouching( player ) )
                {
                    var_9a44b11a34204aa1 = 1;
                    break;
                }
            }
            
            var_77898ab40e53d0ae = player zone_manager::get_current_zone();
            
            if ( var_77898ab40e53d0ae.script_zone_name && arraycontains( level.meteorshower.indoorzones, var_77898ab40e53d0ae.script_zone_name ) )
            {
                var_9a44b11a34204aa1 = 1;
            }
            
            if ( var_9a44b11a34204aa1 )
            {
                continue;
            }
            
            foreach ( outdoortrigger in level.meteorshower.outdoortriggers )
            {
                if ( outdoortrigger istouching( player ) )
                {
                    var_4adae13eb83af1d4 = getclosestpointonnavmesh( player.origin, undefined, undefined, undefined, undefined, 1 );
                    
                    if ( outdoortrigger istouchingpoint( var_4adae13eb83af1d4 ) )
                    {
                        var_da4f4cdd7193471f.var_e418631e0dd784e3[ 0 ] = utility::drop_to_ground( var_4adae13eb83af1d4, 100 );
                        level.meteorshower.var_da4f4cdd7193471f[ level.meteorshower.var_da4f4cdd7193471f.size ] = var_da4f4cdd7193471f;
                        break;
                    }
                }
            }
            
            if ( var_da4f4cdd7193471f.var_e418631e0dd784e3.size > 0 )
            {
                continue;
            }
            
            var_7246622f53b81906 = function_7801d05a86b06144( player.origin, 32, 0, 64, 5 );
            
            foreach ( tacpoint in var_7246622f53b81906 )
            {
                var_204a6a925cf5a73b = tacpoint.navzoneindex != -1 && isdefined( tacpoint.var_e94b81e2231e2a9 );
                
                if ( var_204a6a925cf5a73b && tacpointexposedtosky( tacpoint ) )
                {
                    var_da4f4cdd7193471f.var_e418631e0dd784e3[ var_da4f4cdd7193471f.var_e418631e0dd784e3.size ] = tacpoint.groundpos;
                }
            }
            
            level.meteorshower.var_da4f4cdd7193471f[ level.meteorshower.var_da4f4cdd7193471f.size ] = var_da4f4cdd7193471f;
        }
        
        level notify( #"hash_6739120d8b94cd5b" );
        throttle::throttle_wait_in_queue( level.meteorshower.var_61317d3c911f068c, level );
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0
// Checksum 0x370a8af, Offset: 0xb24
// Size: 0x252
function do_meteor_shower()
{
    level endon( #"game_ended" );
    level endon( #"hash_99c5b834341eac0" );
    level endon( #"hash_1691f615d0cfcf52" );
    level.meteorshower.drop_meteor = 1;
    
    while ( true )
    {
        level waittill( #"hash_6739120d8b94cd5b" );
        var_fc744f701f1b0116 = undefined;
        
        foreach ( var_593ee9ad2e94f316 in level.meteorshower.var_da4f4cdd7193471f )
        {
            if ( var_593ee9ad2e94f316.var_e418631e0dd784e3.size > 0 && !isdefined( var_593ee9ad2e94f316.meteorignore ) )
            {
                var_f3af46d5cb247728 = 1;
                
                if ( !is_under_object( var_593ee9ad2e94f316.playerorigin ) )
                {
                    var_fc744f701f1b0116 = 1;
                }
                
                break;
            }
        }
        
        var_c9635fac6c75d098 = var_fc744f701f1b0116 && var_f3af46d5cb247728 && randomfloatrange( 0, 100 ) < 75;
        
        if ( var_c9635fac6c75d098 )
        {
            living_player_targets = [];
            
            foreach ( var_da4f4cdd7193471f in level.meteorshower.var_da4f4cdd7193471f )
            {
                if ( !isdefined( var_da4f4cdd7193471f.meteorignore ) )
                {
                    living_player_targets[ living_player_targets.size ] = var_da4f4cdd7193471f;
                }
            }
            
            var_91e35adeb25ea193 = utility::array_random( living_player_targets );
            var_d2b2ff10b10f251e = utility::array_random( var_91e35adeb25ea193.var_e418631e0dd784e3 );
        }
        else
        {
            var_d2b2ff10b10f251e = function_2d906bc73e186ed6();
        }
        
        if ( isdefined( var_d2b2ff10b10f251e ) )
        {
            level thread spawn_meteor( var_d2b2ff10b10f251e );
            level.meteorshower.var_1ac87cad5ce56a7e = var_d2b2ff10b10f251e;
        }
        
        interval = randomfloatrange( 2, 5 );
        wait interval;
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0, eflags: 0x4
// Checksum 0x964befed, Offset: 0xd7e
// Size: 0x23a
function private function_2d906bc73e186ed6()
{
    var_3b0b254721ed02e7 = 60;
    var_483c99022aad3d5e = 30;
    level.meteorshower.var_489b6e19226266af = utility::array_random( level.meteorshower.var_da4f4cdd7193471f );
    
    if ( isdefined( level.meteorshower.var_489b6e19226266af ) )
    {
        var_5bc1911205522051 = randomfloatrange( 0, 100 ) < 75;
        
        if ( var_5bc1911205522051 )
        {
            var_d2b2ff10b10f251e = utility::function_724309a65022770f( level.meteorshower.var_489b6e19226266af.playerorigin, 3000, var_3b0b254721ed02e7, level.meteorshower.var_489b6e19226266af.playerangles[ 1 ], undefined, &function_fb6476cd2db35782, var_483c99022aad3d5e );
            
            if ( function_af71737b74c37d24( var_d2b2ff10b10f251e ) )
            {
                level.meteorshower.var_489b6e19226266af = undefined;
                return var_d2b2ff10b10f251e;
            }
        }
        
        if ( isdefined( level.meteorshower.var_489b6e19226266af.zone ) )
        {
            random_zones = level.meteorshower.var_489b6e19226266af.zone zone_manager::get_adjacent_zones( 1, 1 );
            
            if ( isdefined( random_zones ) && random_zones.size > 0 )
            {
                var_8573a8362a84f9fb = arrayrandomize( random_zones );
                
                if ( isdefined( var_8573a8362a84f9fb ) && var_8573a8362a84f9fb.size > 0 )
                {
                    foreach ( adjacentzone in var_8573a8362a84f9fb )
                    {
                        if ( adjacentzone.is_enabled && adjacentzone.is_active )
                        {
                            var_d2b2ff10b10f251e = function_eb5de5214f8641a6( adjacentzone.origin );
                            
                            if ( isdefined( var_d2b2ff10b10f251e ) )
                            {
                                level.meteorshower.var_489b6e19226266af = undefined;
                                return var_d2b2ff10b10f251e;
                            }
                        }
                    }
                }
            }
        }
    }
    
    return level.meteorshower.var_1ac87cad5ce56a7e;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1, eflags: 0x4
// Checksum 0xbcf10e2f, Offset: 0xfc1
// Size: 0x55
function private function_eb5de5214f8641a6( var_c65117d8a1611708 )
{
    var_c18d692323a803dc = 10;
    
    for ( var_378615826c70e919 = 0; var_378615826c70e919 < var_c18d692323a803dc ; var_378615826c70e919++ )
    {
        var_d2b2ff10b10f251e = utility::function_7afe366c29a77c34( var_c65117d8a1611708, 3000 );
        
        if ( function_af71737b74c37d24( var_d2b2ff10b10f251e ) )
        {
            return var_d2b2ff10b10f251e;
        }
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1, eflags: 0x4
// Checksum 0xe5e3a42c, Offset: 0x101f
// Size: 0x8d, Type: bool
function private function_af71737b74c37d24( point )
{
    var_1fda85c38f9d9fc1 = squared( 150 );
    
    if ( distancesquared( point, level.meteorshower.var_489b6e19226266af.playerorigin ) <= var_1fda85c38f9d9fc1 )
    {
        return false;
    }
    
    closesttacpoint = findclosesttacpoint( point );
    var_204a6a925cf5a73b = closesttacpoint.navzoneindex != -1 && isdefined( closesttacpoint.var_e94b81e2231e2a9 );
    return var_204a6a925cf5a73b && tacpointexposedtosky( closesttacpoint );
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1, eflags: 0x4
// Checksum 0x148f13c7, Offset: 0x10b5
// Size: 0x8f, Type: bool
function private function_fb6476cd2db35782( point )
{
    var_1fda85c38f9d9fc1 = squared( 150 );
    
    if ( distancesquared( point, level.meteorshower.var_489b6e19226266af.playerorigin ) > var_1fda85c38f9d9fc1 )
    {
        return false;
    }
    
    closesttacpoint = findclosesttacpoint( point );
    var_d2637ae727876704 = closesttacpoint.navzoneindex == -1 || !isdefined( closesttacpoint.var_e94b81e2231e2a9 );
    return var_d2637ae727876704 || !tacpointexposedtosky( closesttacpoint );
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0xcaaf84ac, Offset: 0x114d
// Size: 0x1f
function on_round_end( params )
{
    level.meteorshower.drop_meteor = undefined;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1
// Checksum 0xc63bd7ca, Offset: 0x1174
// Size: 0x32b
function spawn_meteor( var_d2b2ff10b10f251e )
{
    level endon( #"game_ended" );
    var_bddff182d98f59f6 = var_d2b2ff10b10f251e + ( 0, -1200, 7500 );
    var_93436b5d97cfd76c = vectortoangles( var_d2b2ff10b10f251e - var_bddff182d98f59f6 );
    mover = utility::spawn_model( "tag_origin", var_bddff182d98f59f6, var_93436b5d97cfd76c );
    meteor = spawnscriptable( "ruby_meteor", var_bddff182d98f59f6, var_93436b5d97cfd76c );
    meteor scriptablesetparententity( mover );
    mover moveto( var_d2b2ff10b10f251e, 3.25 );
    mover utility::waittill_notify_or_timeout( "movedone", 3.25 );
    meteorimpact = spawnscriptable( "ruby_meteor_ground_impact", var_d2b2ff10b10f251e, ( 0, 0, 1 ) );
    earthquake( 0.7, 1, var_d2b2ff10b10f251e, 312.5 );
    playrumbleonposition( "heavy_1s", var_d2b2ff10b10f251e );
    nearbyents = getplayersandaiarrayinradius( var_d2b2ff10b10f251e, 250 );
    
    if ( getdvarfloat( @"hash_a00ddf81f4c86fa5", -1 ) >= 1 )
    {
        level thread utility::draw_circle( var_d2b2ff10b10f251e, 250, ( 0, 1, 0 ), 1, 0, 30 );
    }
    
    foreach ( nearbyent in nearbyents )
    {
        dmg = nearbyent function_c99d7c6e55ebcdbc();
        var_35d58ac89bf4b5ca = distance( var_d2b2ff10b10f251e, nearbyent.origin );
        var_a9e6352b74faa839 = math::lerp_fraction( 0, 250, var_35d58ac89bf4b5ca );
        
        if ( isdefined( dmg ) )
        {
            if ( isplayer( nearbyent ) && !player::isinlaststand( nearbyent ) )
            {
                if ( !isdefined( nearbyent.meteors_ignore ) )
                {
                    nearbyent knockback_player( var_d2b2ff10b10f251e, var_a9e6352b74faa839 );
                    nearbyent shellshock_utility_cpmp::_shellshock( %"shock_ruby_meteor_impact", #"damage", 1.5 );
                }
            }
            else if ( isai( nearbyent ) )
            {
                if ( dmg > nearbyent.health )
                {
                    if ( !nearbyent.noragdoll && !nearbyent.script_noragdoll )
                    {
                        nearbyent function_7ef5e200a10ee4e7( var_d2b2ff10b10f251e, var_a9e6352b74faa839 );
                    }
                    
                    nearbyent zm_cleanup_manager::function_dd62e2042418b7e5();
                }
                else if ( self.subclass != "zombie_galileo" )
                {
                    if ( nearbyent zombie_knockdown::function_99b2020a564d9c7e( var_d2b2ff10b10f251e ) )
                    {
                        nearbyent function_29853e0388efeb81( var_d2b2ff10b10f251e, var_a9e6352b74faa839 );
                    }
                    else if ( nearbyent.aicategory )
                    {
                        nearbyent zombie_stun::stun_ai( 2.5 );
                    }
                }
            }
            
            if ( !( isplayer( nearbyent ) && isdefined( nearbyent.meteors_ignore ) ) )
            {
                nearbyent dodamage( dmg, var_d2b2ff10b10f251e, mover, mover, "MOD_EXPLOSIVE", level.weaponnone, "none", undefined, 1073741824 );
            }
        }
    }
    
    level thread function_b1dbf66885785977( var_d2b2ff10b10f251e, var_93436b5d97cfd76c[ 1 ] );
    meteor freescriptable();
    wait 1;
    mover delete();
    wait 3;
    
    if ( isdefined( meteorimpact ) )
    {
        meteorimpact freescriptable();
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0, eflags: 0x4
// Checksum 0xac118f3d, Offset: 0x14a7
// Size: 0x13c
function private function_c99d7c6e55ebcdbc()
{
    dmg = 0;
    
    if ( isplayer( self ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && self issprintsliding() )
        {
            dmg = 0;
        }
        else
        {
            dmg = 55;
        }
    }
    else if ( isai( self ) )
    {
        if ( self.subclass == "zombie_galileo" || self.subclass == "zombie_galileo_drone" )
        {
            dmg = 0;
        }
        else
        {
            dmg = namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, zm_utility::get_round_number() );
            
            if ( self.aicategory )
            {
                switch ( self.aicategory )
                {
                    case #"hash_84fcf5e68d7230b2":
                        dmg *= 0.25;
                        break;
                    case #"hash_8c089e813083e510":
                        dmg *= 0.12;
                        break;
                    case #"hash_7b0e2f2ed84f34":
                        dmg *= 0.1;
                        break;
                    case #"hash_4e47eb6c32f5b165":
                        dmg *= 0.05;
                        break;
                    case #"hash_7e8a002ed096276c":
                        dmg = 0;
                        break;
                }
            }
        }
    }
    else
    {
        dmg = 50;
    }
    
    return dmg;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 2, eflags: 0x4
// Checksum 0xf707fd58, Offset: 0x15ec
// Size: 0x100
function private knockback_player( var_d2b2ff10b10f251e, var_a9e6352b74faa839 )
{
    var_86e55fb678d98536 = 50;
    var_fc001b893dc5e0db = 300;
    var_9bb6838a78485cf2 = 500;
    var_4875c4a245b82147 = vectornormalize2( self.origin - var_d2b2ff10b10f251e );
    
    if ( var_4875c4a245b82147 == ( 0, 0, 0 ) )
    {
        var_4875c4a245b82147 = anglestoforward( self.angles );
    }
    
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    var_d750b8a81b34edc6 = math::lerp( var_9bb6838a78485cf2, var_fc001b893dc5e0db, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_86e55fb678d98536 );
    impactmagnitude = getdvarfloat( @"hash_63a5c8451997935d", var_d750b8a81b34edc6 );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    self knockback( impactvector, impactmagnitude, 1 );
}

// Namespace zm_sat_ruby_meteor_shower
// Params 2, eflags: 0x4
// Checksum 0x42f09ead, Offset: 0x16f4
// Size: 0x6a
function private function_29853e0388efeb81( var_d2b2ff10b10f251e, var_a9e6352b74faa839 )
{
    var_a85e18f6e2a76eef = 25;
    var_f0057641911a379a = 200;
    var_d76388e2199bd98f = 300;
    impactmagnitude = math::lerp( var_d76388e2199bd98f, var_f0057641911a379a, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = var_a85e18f6e2a76eef;
    zombie_knockdown::function_6fc167d4a3590991( var_d2b2ff10b10f251e, impactmagnitude, var_f186e7fac7ca9a06 );
}

// Namespace zm_sat_ruby_meteor_shower
// Params 2, eflags: 0x4
// Checksum 0x87fbfc03, Offset: 0x1766
// Size: 0xbd
function private function_7ef5e200a10ee4e7( var_d2b2ff10b10f251e, var_a9e6352b74faa839 )
{
    var_c31dc26c108992f8 = 45;
    var_f186e7fac7ca9a06 = var_c31dc26c108992f8;
    impactmagnitude = math::lerp( 7000, 5500, var_a9e6352b74faa839 );
    var_4875c4a245b82147 = vectornormalize2( self.origin - var_d2b2ff10b10f251e );
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    impactvector = impactmagnitude * impactvector;
    self.ragdollimpactvector = impactvector;
    self.ragdollhitloc = "torso_lower";
    self.forceragdollimmediate = 1;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 3, eflags: 0x4
// Checksum 0xfa02b510, Offset: 0x182b
// Size: 0x2ea
function private function_b1dbf66885785977( var_dfd3708ddd6466e3, var_c5c4f0c50922dd67, var_7ffa0aaeaa288303 )
{
    if ( !level.meteorshower.drop_meteor )
    {
        return;
    }
    
    if ( level utility::flag( "bgb_time_out_active" ) )
    {
        return;
    }
    
    var_87c91812533c9c30 = undefined;
    
    if ( level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 - level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size <= 0 )
    {
        var_87c91812533c9c30 = 1;
    }
    
    var_dcc4b375335153af = randomintrange( 2, 4 );
    yawspawnangles = [];
    
    if ( var_dcc4b375335153af == 1 )
    {
        yawspawnangles[ 0 ] = var_c5c4f0c50922dd67;
    }
    else
    {
        var_9f55d7ceeca21dbf = -70;
        var_cc0c8228db393d49 = 70;
        var_30496eadb602f2f8 = ( var_cc0c8228db393d49 - var_9f55d7ceeca21dbf ) / ( var_dcc4b375335153af - 1 );
        
        for ( i = 0; i < var_dcc4b375335153af ; i++ )
        {
            spawnangles[ i ] = angleclamp180( var_c5c4f0c50922dd67 + var_9f55d7ceeca21dbf + i * var_30496eadb602f2f8 );
        }
    }
    
    currentspawnangles = 0;
    
    for ( i = 0; i < var_dcc4b375335153af ; i++ )
    {
        if ( var_7ffa0aaeaa288303 || level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 - level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size <= 0 )
        {
            return;
        }
        
        var_5c5f0b08b1ea248c = ( 0, spawnangles[ i ], 0 );
        zombie_shade = agent_manager::spawn_agent( "zombie_shade", var_dfd3708ddd6466e3, var_5c5f0b08b1ea248c );
        level.var_a009ab14ee0d3223.var_939db9ccafac43a7[ level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size ] = zombie_shade;
        
        if ( isdefined( zombie_shade ) )
        {
            var_df622bf2765e51a6 = 600;
            var_567d9f7a7f216d20 = 75;
            var_15525c37c75b697e = 900;
            var_e80ef01ae4c28ac5 = 8;
            zombie_shade.disable_spawn_vfx = 1;
            zombie_shade.spawn_source = "special_zombie_spawn";
            zombie_shade utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 0.5 );
            roundnumber = zm_utility::get_round_number();
            zombie_shade zombie_utils::set_zombie_round_difficulty( roundnumber );
            var_fa9e89c63419ed31 = vectorcross( ( 0, 0, 1 ), var_5c5f0b08b1ea248c );
            cannonballdir = rotatepointaroundvector( var_fa9e89c63419ed31, var_5c5f0b08b1ea248c, -1 * getdvarfloat( @"hash_7df1062a17f22630", var_567d9f7a7f216d20 ) );
            zombie_shade zombie_cannonball::cannonball_ai( cannonballdir, getdvarfloat( @"hash_a11d4d2b4c5987d6", var_df622bf2765e51a6 ), zombie_cannonball::adv_settings( 1, getdvarfloat( @"hash_ef310e3485c8db95", var_e80ef01ae4c28ac5 ), 0, getdvarfloat( @"hash_f0461bfb4eb1db2e", var_15525c37c75b697e ), undefined, 500 ), "roll_forward" );
            zombie_shade zombie_cannonball::function_c47b4675a71d8167( &zombie_shade_cannonball_failsafe );
        }
    }
    
    zombie_shade thread function_ff30e2d96962a09f();
    return zombie_shade;
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0, eflags: 0x4
// Checksum 0xe0e75241, Offset: 0x1b1e
// Size: 0x21
function private zombie_shade_cannonball_failsafe()
{
    self.death_source = "cannonball_failsafe";
    self.var_a13bed1ac47e1b2c = 1;
    self kill();
}

// Namespace zm_sat_ruby_meteor_shower
// Params 0
// Checksum 0xff547457, Offset: 0x1b47
// Size: 0x48
function function_ff30e2d96962a09f()
{
    utility::waittill_notify_or_timeout( "cannonball_end", 10 );
    current_zone = zone_manager::get_current_zone();
    
    if ( !current_zone.is_enabled && !self.damageshield )
    {
        self kill();
    }
}

// Namespace zm_sat_ruby_meteor_shower
// Params 1, eflags: 0x4
// Checksum 0xbf498427, Offset: 0x1b97
// Size: 0x45, Type: bool
function private is_under_object( origin )
{
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0, 1 );
    return !trace::ray_trace_passed( origin, origin + ( 0, 0, 5000 ), undefined, contents );
}

