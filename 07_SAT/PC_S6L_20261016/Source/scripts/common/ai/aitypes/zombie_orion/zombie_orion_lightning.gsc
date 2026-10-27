// scripts\common\ai\aitypes\zombie_orion\zombie_orion_lightning.gsc  (hash_560d962e39114107.gscc) (size: 13981 Bytes / 0x369d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb04f45e (3406099550)
// size ...... 13981 (0x369d)
// includes .. 9   (offset: 0x33b1)
// strings ... 45  (offset: 0x33f9)
// dev strs .. 4   (offset: 0x366d)
// exports ... 26  (offset: 0x2209)
// cseg ...... 0x384 + 0x1e85 (0x2209)
// imports ... 112 (offset: 0x2619)
// animtree1 . 0   (offset: 0x369d)
// animtree2 . 0   (offset: 0x369d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace zombie_orion_lightning;

// Namespace zombie_orion_lightning
// Params 1
// Checksum 0xbeec1dca, Offset: 0x3a2
// Size: 0xc
function precache( aitypescriptbundle )
{
    
}

// Namespace zombie_orion_lightning
// Params 1
// Checksum 0xf795e606, Offset: 0x3b6
// Size: 0x6c
function init_global( aitypescriptbundle )
{
    callback::get_template( self.animsetname ) callback::add( "on_projectile_player_impact", &on_projectile_player_impact );
    callback::get_template( self.animsetname ) callback::add( "on_projectile_world_impact", &on_projectile_world_impact );
    callback::get_template( self.animsetname ) callback::add( "projectile_fired", &watch_projectile );
}

// Namespace zombie_orion_lightning
// Params 0
// Checksum 0x3f1b8a98, Offset: 0x42a
// Size: 0xf4
function init()
{
    thread call_lightning_listener();
    thread lightning_slam_listener();
    thread function_36ff1d13b76574f1();
    self function_786bb6aa1b76c7ee( "slam_max_attack_dist", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9da13e3df52ad0ba );
    self function_786bb6aa1b76c7ee( "move_slam_max_attack_dist", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a3fe8c097b1b8985 );
    self function_786bb6aa1b76c7ee( "min_ranged_attack_dist", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c69175bb668b7c1e );
    lightning_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4373c5231d5ced1 ) );
    self function_786bb6aa1b76c7ee( "call_lightning_cooldown", lightning_cooldown );
    self function_786bb6aa1b76c7ee( "call_lightning_time", lightning_cooldown + gettime() );
    
    /#
        init_orion_devgui();
    #/
    
    return anim.success;
}

// Namespace zombie_orion_lightning
// Params 2
// Checksum 0xc37dce05, Offset: 0x527
// Size: 0x226, Type: bool
function function_a3b7b9e86ecf69cc( taskid, params )
{
    assert( self.enemy );
    
    if ( isalive( self.enemy ) )
    {
        var_ee6433c31961982d = self.enemy.origin - self.origin;
        dist_sqr = lengthsquared( var_ee6433c31961982d );
        
        if ( dist_sqr < squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9da13e3df52ad0ba ) )
        {
            string = distance( self.origin, self.enemy.origin );
            
            /#
                print3d( self.origin + ( 0, 0, 90 ), string, ( 1, 0, 0 ), 1, 1, 600 );
            #/
            
            self function_f2df0257c63f229( "lightning_slam_moving" );
            return true;
        }
        
        if ( self.enemy vehicle::is_vehicle() )
        {
            var_f69827bbfb33eb2b = self.enemy vehicle_getvelocity();
        }
        else
        {
            var_f69827bbfb33eb2b = self.enemy getentityvelocity();
        }
        
        target_speed_sqr = length2dsquared( var_f69827bbfb33eb2b );
        var_1a5ef5034e474516 = vectordot2( var_f69827bbfb33eb2b, var_ee6433c31961982d ) > 0 && target_speed_sqr > 14400;
        
        if ( var_1a5ef5034e474516 && dist_sqr < squared( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a3fe8c097b1b8985 ) )
        {
            string = sqrt( target_speed_sqr ) + " / " + distance( self.origin, self.enemy.origin ) + " / " + ( var_1a5ef5034e474516 ? "backing up" : "not backing up" );
            
            /#
                print3d( self.origin + ( 0, 0, 90 ), string, ( 1, 0, 0 ), 1, 1, 600 );
            #/
            
            self function_786bb6aa1b76c7ee( "lightning_slam_moving", 1 );
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_orion_lightning
// Params 0, eflags: 0x4
// Checksum 0x19852353, Offset: 0x756
// Size: 0x2a
function private function_36ff1d13b76574f1()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_enemy_start" );
        thread monitor_projectile_attack();
    }
}

// Namespace zombie_orion_lightning
// Params 0, eflags: 0xc
// Checksum 0x2365a39, Offset: 0x788
// Size: 0x88
function private monitor_projectile_attack()
{
    self notify( #"hash_1d2f68e16df90ea" );
    self endon( #"hash_1d2f68e16df90ea" );
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    self endon( #"launch_projectile" );
    self function_f2df0257c63f229( "abort_ranged_attack" );
    
    while ( self.enemy )
    {
        if ( !self cansee( self.enemy, 0 ) )
        {
            self function_786bb6aa1b76c7ee( "abort_ranged_attack", 1 );
            self notify( #"cancel_ranged_attack" );
            break;
        }
        
        waitframe();
    }
}

// Namespace zombie_orion_lightning
// Params 1
// Checksum 0xbbd250a8, Offset: 0x818
// Size: 0x1ba
function watch_projectile( params )
{
    if ( params.projectile && params.var_e1b150b361aa0993 )
    {
        self endon( #"death" );
        params.projectile endon( #"death" );
        params.var_e1b150b361aa0993 endon( #"death" );
        
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_86d08f85bd39d734 > 0 )
        {
            thread function_5c7e947c52329243( params.projectile, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7473d6fd1e3c66b2, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_86d08f85bd39d734 );
        }
        
        last_pos = params.projectile.origin;
        
        while ( true )
        {
            curr_pos = params.projectile.origin;
            var_ee6433c31961982d = params.var_e1b150b361aa0993.origin - curr_pos;
            to_target_flat = ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0 );
            projectile_dir = curr_pos - last_pos;
            var_fd08df3e4d6e9c41 = ( projectile_dir[ 0 ], projectile_dir[ 1 ], 0 );
            
            if ( vectordot( to_target_flat, var_fd08df3e4d6e9c41 ) < 0 )
            {
                dist_sqr_flat = lengthsquared( to_target_flat );
                
                if ( dist_sqr_flat > 2500 )
                {
                    params.projectile detonate();
                }
            }
            
            last_pos = params.projectile.origin;
            waitframe();
        }
    }
}

// Namespace zombie_orion_lightning
// Params 3, eflags: 0x4
// Checksum 0x53bea4e2, Offset: 0x9da
// Size: 0x25e
function private function_5c7e947c52329243( projectile, min_shock_duration, max_shock_duration )
{
    self endon( #"death" );
    projectile endon( #"death" );
    last_pos = projectile.origin;
    
    while ( true )
    {
        curr_pos = projectile.origin;
        nearby_ai = getaiarrayinradius( curr_pos, 200 );
        
        foreach ( ai in nearby_ai )
        {
            if ( ai != self && ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai.ishaywire )
            {
                closest_point = pointonsegmentnearesttopoint( last_pos, curr_pos, ai.origin );
                
                if ( distance2dsquared( closest_point, ai.origin ) < ( ai.radius + 30 ) * ( ai.radius + 30 ) )
                {
                    if ( closest_point[ 2 ] < ai.origin[ 2 ] + ai.height + 20 && closest_point[ 2 ] + 20 > ai.origin[ 2 ] )
                    {
                        if ( utility::issharedfuncdefined( #"shockstick", #"shockstick_canbehaywire" ) && utility::issharedfuncdefined( #"shockstick", #"shockstick_applyhaywire" ) )
                        {
                            shockdata = function_327197455e717e13( randomfloatrange( min_shock_duration, max_shock_duration ), self, curr_pos );
                            
                            if ( ai [[ utility::getsharedfunc( #"shockstick", #"shockstick_canbehaywire" ) ]]( shockdata, 1 ) )
                            {
                                shockdata thread [[ utility::getsharedfunc( #"shockstick", #"shockstick_applyhaywire" ) ]]( ai, shockdata.weapon, 0 );
                            }
                        }
                    }
                }
            }
        }
        
        last_pos = projectile.origin;
        wait 0.2;
    }
}

// Namespace zombie_orion_lightning
// Params 0, eflags: 0x4
// Checksum 0x93ca7876, Offset: 0xc40
// Size: 0x41
function private call_lightning_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"call_lightning_charge", outside );
        thread call_lightning( self.origin, outside );
    }
}

// Namespace zombie_orion_lightning
// Params 5, eflags: 0x4
// Checksum 0x51bf41b3, Offset: 0xc89
// Size: 0x8b
function private player_damage( player, damage, position, radius, earthquake_strength )
{
    assert( player );
    player dodamage( damage, position, self, undefined, "MOD_ELEMENTAL_ELEC", "<explicitweaponnone>" );
    
    if ( earthquake_strength > 0 )
    {
        player playrumbleonentity( earthquake_strength >= 0.5 ? "heavy_1s" : "light_1s" );
        player earthquakeforplayer( earthquake_strength, min( earthquake_strength * 2, 1 ), position, radius );
    }
}

// Namespace zombie_orion_lightning
// Params 2, eflags: 0xc
// Checksum 0xf642f35f, Offset: 0xd1c
// Size: 0x2ca
function private call_lightning( position, outside )
{
    self notify( #"hash_7f3c280666d1b1c2" );
    self endon( #"hash_7f3c280666d1b1c2" );
    level endon( #"game_ended" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self function_786bb6aa1b76c7ee( "is_lightning_charged", 1 );
    self.lightning_charge_time = gettime();
    nearby_players = getplayersinradius( position, settings.var_f99132d1b6779051, 100, 1 );
    
    foreach ( player in nearby_players )
    {
        if ( player.team != self.team && isalive( player ) )
        {
            player_damage( player, settings.var_25138f63d9f8ae72 * ( self.var_fe048a2106d8ef00[ #"call_lightning" ] ?? 1 ), position, settings.var_f99132d1b6779051, settings.var_38267e28662bde50 );
        }
    }
    
    nearby_ai = getaiarrayinradius( position, settings.var_f99132d1b6779051 );
    
    foreach ( ai in nearby_ai )
    {
        if ( ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            ai zombie_knockdown::function_6fc167d4a3590991( position );
        }
    }
    
    /#
        if ( function_bf2a4eb30c919078() )
        {
            sphere( position, settings.var_f99132d1b6779051, ( 1, 0, 0 ) );
            cylinder( position, position + ( 0, 0, 40 ), settings.var_f99132d1b6779051, ( 1, 0, 0 ), 0, 30 );
        }
    #/
    
    utility::function_32b24db3127bff40( "call_lightning", outside ? "on_outside" : "on" );
    utility::waittill_any( "release_lightning", "terminate_lightning_attack" );
    
    if ( self )
    {
        utility::function_32b24db3127bff40( "call_lightning", "off" );
        self function_786bb6aa1b76c7ee( "is_lightning_charged", 0 );
    }
}

// Namespace zombie_orion_lightning
// Params 0, eflags: 0x4
// Checksum 0x7bd99640, Offset: 0xfee
// Size: 0x66
function private lightning_slam_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"lightning_slam_impact", position );
        
        if ( !position )
        {
            position = self.origin + anglestoforward( self.angles ) * 50;
        }
        
        thread lightning_slam_impact( position ?? self.origin );
    }
}

// Namespace zombie_orion_lightning
// Params 1, eflags: 0x4
// Checksum 0x9d4cd76, Offset: 0x105c
// Size: 0x3c5
function private lightning_slam_impact( position )
{
    level endon( #"game_ended" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    nearby_players = getplayersinradius( position, settings.var_cd2ede1fb68a3836, 100, 1 );
    
    foreach ( player in nearby_players )
    {
        if ( player.team != self.team && isalive( player ) )
        {
            if ( self cansee( player ) || !navtrace( position, player.origin ) )
            {
                player_damage( player, settings.var_76f8ed9bd9c80621 * ( self.var_fe048a2106d8ef00[ #"lightning_slam" ] ?? 1 ), position, settings.var_cd2ede1fb68a3836, settings.var_8e18d86c5f30f1dd );
                thread lightning_strike_player( player, 1 );
                
                if ( settings.var_91f18b8b93127bc2 > 0 )
                {
                    knockback_dir = player.origin - position;
                    var_f6203e9c1bc655f9 = self.origin - player.origin;
                    
                    if ( vectordot( knockback_dir, var_f6203e9c1bc655f9 ) > 0 || lengthsquared( knockback_dir ) < 0.001 )
                    {
                        knockback_dir = player.origin - self.origin;
                    }
                    
                    right_dir = vectorcross( knockback_dir, ( 0, 0, 1 ) );
                    
                    if ( lengthsquared( right_dir ) > 0.001 )
                    {
                        knockback_dir = rotatepointaroundvector( right_dir, knockback_dir, 22 );
                    }
                    
                    player knockback( knockback_dir, settings.var_91f18b8b93127bc2, 1 );
                }
            }
        }
    }
    
    nearby_ai = getaiarrayinradius( position, settings.var_cd2ede1fb68a3836 );
    
    foreach ( ai in nearby_ai )
    {
        if ( ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            ai zombie_knockdown::function_6fc167d4a3590991( position );
        }
    }
    
    /#
        if ( function_bf2a4eb30c919078() )
        {
            sphere( position, settings.var_cd2ede1fb68a3836, ( 1, 0, 0 ) );
            cylinder( position, position + ( 0, 0, 40 ), settings.var_cd2ede1fb68a3836, ( 1, 0, 0 ), 0, 30 );
        }
    #/
    
    if ( settings.var_911a6ac4e3991681 && !utility::ent_flag( "hvt_slam_done" ) )
    {
        thread hvt_slam_hide();
    }
    
    if ( settings.var_19960dda5c54aaca )
    {
        slam_scriptable = spawnscriptable( settings.var_19960dda5c54aaca, position );
        part_name = settings.var_65d42a37d396d250;
        slam_scriptable setscriptablepartstate( part_name, "on" );
        wait settings.var_fd9a9269ba754da9;
        
        if ( slam_scriptable )
        {
            slam_scriptable setscriptablepartstate( part_name, "off" );
            slam_scriptable freescriptable();
        }
    }
}

// Namespace zombie_orion_lightning
// Params 1, eflags: 0x4
// Checksum 0x30dd3c6a, Offset: 0x1429
// Size: 0x52
function private on_projectile_player_impact( params )
{
    if ( isalive( self ) && params.player )
    {
        thread lightning_strike_ground( params.player.origin, undefined, issubstr( self.subclass, "_hvt" ) );
    }
}

// Namespace zombie_orion_lightning
// Params 1, eflags: 0x4
// Checksum 0xa477e529, Offset: 0x1483
// Size: 0x6a
function private on_projectile_world_impact( params )
{
    if ( isalive( self ) )
    {
        contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        ground_pos = utility::drop_to_ground( params.position, 0, -2000, undefined, contents );
        thread lightning_strike_ground( ground_pos ?? params.position );
    }
}

// Namespace zombie_orion_lightning
// Params 2, eflags: 0x4
// Checksum 0xa59421b2, Offset: 0x14f5
// Size: 0x15e
function private lightning_strike_player( player, apply_damage_over_time = 0 )
{
    if ( !isalive( player ) || !isalive( self ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    player utility::function_32b24db3127bff40( "marked_by_lightning", "on" );
    
    if ( apply_damage_over_time && settings.var_6c9117b1b8479b1d > 0 )
    {
        num_ticks = settings.var_6c9117b1b8479b1d;
        tick_interval = settings.var_5b42981c7235059e;
        var_2cb9fba4482b9d09 = settings.var_eb9d4d0c06443a2e * ( self.var_fe048a2106d8ef00[ #"lightning_dot" ] ?? 1 );
        
        for ( i = 0; i < num_ticks ; i++ )
        {
            if ( isalive( player ) && isalive( self ) )
            {
                wait tick_interval;
                player player_damage( player, var_2cb9fba4482b9d09, player.origin );
                continue;
            }
            
            break;
        }
    }
    else
    {
        wait randomfloatrange( settings.var_e49eb006f54de66c, settings.var_2cdce511932e962a );
    }
    
    if ( player )
    {
        player utility::function_32b24db3127bff40( "marked_by_lightning", "off" );
    }
}

// Namespace zombie_orion_lightning
// Params 3, eflags: 0x4
// Checksum 0xbf2fbc4, Offset: 0x165b
// Size: 0x36a
function private lightning_strike_ground( position, immune_zombie, hvt_strike )
{
    level endon( #"game_ended" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( isalive( self ) && settings.var_7a2273bd506d71cd )
    {
        lightning_scriptable = spawnscriptable( settings.var_7a2273bd506d71cd, position );
        part_name = settings.var_1f0e1f54fb3f34d7;
        lightning_scriptable setscriptablepartstate( part_name, "strike" );
        nearby_players = getplayersinradius( position, settings.var_179cdc5b5adfb847, 100, 1 );
        
        foreach ( player in nearby_players )
        {
            if ( player.team != self.team && isalive( player ) )
            {
                trace_passed = position == player.origin || !navtrace( position, player.origin );
                
                if ( !trace_passed )
                {
                    player_top = player utility::function_f02ebab438642e16();
                    height = player_top[ 2 ] - player.origin[ 2 ];
                    var_cb4d865cc6ed9998 = position + ( 0, 0, height );
                    trace_passed = trace::ray_trace_passed( var_cb4d865cc6ed9998, player_top, undefined, trace::create_default_contents( 1 ) );
                }
                
                if ( trace_passed )
                {
                    player player_damage( player, settings.var_fa756ea9dc7b2a94 * ( self.var_fe048a2106d8ef00[ #"lightning_strike_aoe" ] ?? 1 ), position, settings.var_179cdc5b5adfb847, settings.var_c67d159cf08313b6 );
                    thread lightning_strike_player( player, hvt_strike );
                }
            }
        }
        
        nearby_ai = getaiarrayinradius( position, settings.var_179cdc5b5adfb847 );
        
        foreach ( ai in nearby_ai )
        {
            if ( ai != immune_zombie && ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                ai zombie_knockdown::function_6fc167d4a3590991( position );
            }
        }
        
        /#
            if ( function_bf2a4eb30c919078() )
            {
                sphere( position, settings.var_179cdc5b5adfb847, ( 1, 0, 0 ) );
                cylinder( position, position + ( 0, 0, 40 ), settings.var_179cdc5b5adfb847, ( 1, 0, 0 ), 0, 30 );
            }
        #/
        
        wait settings.var_c16aa66d799b8580;
        
        if ( lightning_scriptable )
        {
            lightning_scriptable setscriptablepartstate( part_name, "off" );
            lightning_scriptable freescriptable();
        }
    }
}

// Namespace zombie_orion_lightning
// Params 4, eflags: 0x4
// Checksum 0x3dd2c7d9, Offset: 0x19cd
// Size: 0x1e4
function private function_327197455e717e13( shockduration, owner, pos, b_set_team )
{
    shockdata = spawnstruct();
    
    if ( utility::issharedfuncdefined( #"equipment", #"hash_3187f585d2de7de7" ) )
    {
        shockdata.tableinfo = [[ utility::getsharedfunc( #"equipment", #"hash_3187f585d2de7de7" ) ]]( "equip_shockstick" );
    }
    
    shockdata.owner = owner;
    shockdata.team = b_set_team ? isdefined( self.var_bd22ba6c600a23a3 ) ? self.var_bd22ba6c600a23a3.team : self.team : undefined;
    shockdata.origin = pos;
    shockdata.weapon = makeweapon( "none" );
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = shockduration;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = shockduration + 0.25;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    return shockdata;
}

// Namespace zombie_orion_lightning
// Params 0, eflags: 0x4
// Checksum 0x9601d16b, Offset: 0x1bba
// Size: 0x236
function private hvt_slam_hide()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    cached_enemy = self.enemy;
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    val::set( "hvt_slam", "damage", 0 );
    utility::function_7c10ea82c1e305b8( "reveal_out", "reveal_out_hvt_hide" );
    namespace_9d8e359c3b1041e5::function_a0ae7f4d57eeafce( 3, [ "normal" ] );
    wait 0.4;
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self hide();
    behind_yaw = self.angles[ 1 ] + 180;
    min_yaw = behind_yaw - 90;
    max_yaw = behind_yaw + 90;
    spawn_points = getrandomnavpoints( self.origin, 100, 3, self, 0, 0, min_yaw, max_yaw );
    spawn_angles = self.angles;
    zombie_ai_type = function_b3988325430ce242( "zombie_base" );
    spawned_zombies = [];
    
    if ( isdefined( spawn_points ) )
    {
        for ( i = 0; i < spawn_points.size ; i++ )
        {
            zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_ai_type, spawn_points[ i ], spawn_angles, self.team );
            
            if ( zombie )
            {
                spawned_zombies[ spawned_zombies.size ] = zombie;
            }
        }
    }
    
    if ( spawned_zombies.size <= 0 )
    {
        level thread function_b8efd95fe06996c7( self );
        return;
    }
    
    target = cached_enemy ?? self.enemy;
    host_index = randomint( spawned_zombies.size );
    host_zombie = spawned_zombies[ host_index ];
    host_zombie.nocorpse = 1;
    thread function_87ddfb33cdfd3127( host_zombie, spawned_zombies, target );
    
    foreach ( zombie in spawned_zombies )
    {
        zombie thread hvt_slam_zombie_post_init( self, target );
    }
}

// Namespace zombie_orion_lightning
// Params 3, eflags: 0x4
// Checksum 0x14154157, Offset: 0x1df8
// Size: 0xfc
function private function_87ddfb33cdfd3127( host_zombie, spawned_zombies, cached_enemy )
{
    while ( isalive( self ) && isalive( host_zombie ) )
    {
        if ( isalive( host_zombie.enemy ) )
        {
            dist_sq = distancesquared( host_zombie.origin, host_zombie.enemy.origin );
            
            if ( dist_sq <= 4096 )
            {
                thread lightning_strike_ground( host_zombie.origin, host_zombie );
                
                if ( host_zombie.magic_bullet_shield || host_zombie.damageshield )
                {
                    host_zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
                }
                
                host_zombie kill();
                break;
            }
        }
        
        self forceteleport( host_zombie.origin, host_zombie.angles );
        waitframe();
    }
    
    level function_b8efd95fe06996c7( self, spawned_zombies );
}

// Namespace zombie_orion_lightning
// Params 2, eflags: 0x4
// Checksum 0x413d5093, Offset: 0x1efc
// Size: 0x144
function private function_b8efd95fe06996c7( hvt_orion, spawned_zombies )
{
    level endon( #"game_ended" );
    
    if ( isalive( hvt_orion ) )
    {
        hvt_orion show();
        hvt_orion utility::function_7c10ea82c1e305b8( "spawn_reveal", "spawn_reveal_traverse_teleport" );
    }
    
    if ( spawned_zombies )
    {
        foreach ( zombie in spawned_zombies )
        {
            if ( isalive( zombie ) )
            {
                if ( zombie.magic_bullet_shield || zombie.damageshield )
                {
                    zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
                }
                
                zombie kill();
            }
        }
    }
    
    wait 0.5;
    
    if ( isalive( hvt_orion ) )
    {
        hvt_orion utility::function_32b24db3127bff40( "spawn_reveal", "off" );
        hvt_orion function_f2df0257c63f229( "in_spawn_reveal" );
        hvt_orion val::reset_all( "hvt_slam" );
        hvt_orion utility::ent_flag_set( "hvt_slam_done" );
    }
}

// Namespace zombie_orion_lightning
// Params 2, eflags: 0x4
// Checksum 0xd5a8523b, Offset: 0x2048
// Size: 0x14b
function private hvt_slam_zombie_post_init( orion, target )
{
    self endon( #"death" );
    utility::ent_flag_wait( "ai_init_complete" );
    self.no_powerups = 1;
    self.ignore_enemy_count = orion.ignore_enemy_count;
    self.var_825b17c932865df = orion.var_825b17c932865df;
    self.b_cleanup_no_respawn = 1;
    self.var_15598d8e493afe88 = 1;
    self.kiastring = #"zombie_kia_mission_kill";
    
    if ( !self.nocorpse )
    {
        self.forceannihilate = 1;
    }
    
    val::set( "hvt_slam_zombie", "ignore_cleanup", 1 );
    
    if ( isdefined( level.zm_get_round_number ) )
    {
        round_number = [[ level.zm_get_round_number ]]();
        zombie_utils::set_zombie_round_difficulty( round_number );
    }
    
    self.maxhealth = int( self.maxhealth * 0.5 );
    self.health = self.maxhealth;
    zombie_utils::function_a8ce00e0448cb6f0( "run", "hvt_slam", 100 );
    
    if ( isalive( target ) )
    {
        zombie_utils::set_ai_target_priority( target, "hvt_slam", 100 );
    }
    
    utility::function_32b24db3127bff40( "base", "orion_eyes" );
}

/#

    // Namespace zombie_orion_lightning
    // Params 0
    // Checksum 0x9de83146, Offset: 0x219b
    // Size: 0x2e, Type: dev
    function init_orion_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x39>", "<dev string:x4e>", &toggle_debug_display );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_orion_lightning
    // Params 0, eflags: 0x4
    // Checksum 0xb0ffecb2, Offset: 0x21d1
    // Size: 0x16, Type: dev
    function private function_bf2a4eb30c919078()
    {
        return getdvarint( @"orion_debug_display", 0 ) > 0;
    }

    // Namespace zombie_orion_lightning
    // Params 0, eflags: 0x4
    // Checksum 0x36aed92d, Offset: 0x21ef
    // Size: 0x1a, Type: dev
    function private toggle_debug_display()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x63>", @"orion_debug_display" );
    }

#/
