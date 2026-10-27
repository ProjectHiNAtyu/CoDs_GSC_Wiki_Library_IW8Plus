// scripts\mp\common\killstreaks\bunker_buster_mp.gsc  (hash_3443c98e748b472b.gscc) (size: 9581 Bytes / 0x256d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf968a6e4 (4184385252)
// size ...... 9581 (0x256d)
// includes .. 13  (offset: 0x21e9)
// strings ... 17  (offset: 0x2251)
// dev strs .. 32  (offset: 0x23a9)
// exports ... 22  (offset: 0x1515)
// cseg ...... 0x1a5 + 0x1370 (0x1515)
// imports ... 80  (offset: 0x1885)
// animtree1 . 0   (offset: 0x256d)
// animtree2 . 0   (offset: 0x256d)
#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\killstreaks\bunker_buster;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\points;
#using scripts\mp\ent_manager;
#using scripts\mp\objidpoolmanager;

#namespace bunker_buster_mp;

// Namespace bunker_buster_mp
// Params 0, eflags: 0x1
// Checksum 0xac9a1e5a, Offset: 0x1c3
// Size: 0x1c
function autoexec main()
{
    utility::registersharedfunc( "bunker_buster", #"init", &init );
}

// Namespace bunker_buster_mp
// Params 0, eflags: 0x4
// Checksum 0x4b7952dd, Offset: 0x1e7
// Size: 0x1d1
function private init()
{
    /#
        devgui_init();
    #/
    
    utility::registersharedfunc( #"bunker_buster", #"missile_gas_volume", &missile_gas_volume );
    utility::registersharedfunc( "bunker_buster", #"dialog_deploy", &dialog_deploy );
    utility::registersharedfunc( "bunker_buster", #"dialog_warning", &dialog_warning );
    utility::registersharedfunc( "bunker_buster", #"dialog_hits", &dialog_hits );
    game[ "dialog" ][ "bunker_buster" + "_deploy" ] = "dx_br_smis_bnbs_bbpi_bbkd";
    game[ "dialog" ][ "bunker_buster" + "_warning_friendly" ] = "dx_br_smis_bnbs_bbpi_kfsi";
    game[ "dialog" ][ "bunker_buster" + "_warning_enemy" ] = "dx_br_smis_bnbs_bbpi_kesi";
    game[ "dialog" ][ "bunker_buster" + "_no_hits" ] = "dx_br_smis_bnbs_bbpi_bkne";
    game[ "dialog" ][ "bunker_buster" + "_single_hit" ] = "dx_br_smis_bnbs_bbpi_bksh";
    game[ "dialog" ][ "bunker_buster" + "_multiple_hits" ] = "dx_br_smis_bnbs_bbpi_bkmh";
    bundle = level.streakglobals.streakbundles[ "bunker_buster" ];
    
    if ( utility::callsharedfunc( #"gas", #"hash_43bf0d88a1c3c9b8", bundle ) )
    {
        utility::callsharedfunc( #"gas", #"hash_b1acc2201b601807", "bunker_buster", bundle.gassettings );
        utility::callsharedfunc( #"gas", #"hash_220661f5c1a54532", "bunker_buster", #"gas_assist", &function_ca1a5849471f6394 );
        utility::callsharedfunc( #"gas", #"hash_220661f5c1a54532", "bunker_buster", #"gas_kill", &function_2eeef3a721b936d7 );
    }
}

// Namespace bunker_buster_mp
// Params 4
// Checksum 0x557393fc, Offset: 0x3c0
// Size: 0xeb
function missile_gas_volume( startposition, endposition, radius, streak_info )
{
    if ( level.bunker_buster.var_8411ba005ba2ff6a )
    {
        trigger = [[ level.bunker_buster.create_trigger_func ]]( "bunker_buster", endposition, self, self.team, level.bunker_buster.gas_lifetime, 1, radius, level.bunker_buster.gas_height ?? distance( startposition, endposition ), undefined, streak_info );
        trigger thread watch_gas_victims( 2, streak_info );
        return;
    }
    
    level thread gas_create_trigger( endposition, self, self.team, level.bunker_buster.gas_lifetime, radius, distance( startposition, endposition ), streak_info );
}

// Namespace bunker_buster_mp
// Params 7
// Checksum 0x8ea1b597, Offset: 0x4b3
// Size: 0x16a
function gas_create_trigger( position, owner, team, duration, radius, height, streak_info )
{
    trigger = spawn( "trigger_radius", position, 0, radius, height );
    trigger ent_manager::registerspawn( 1, &gas_grenade::sweepgas );
    trigger.height = height;
    trigger.radius = radius;
    trigger.duration = duration;
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.weapon = level.bunker_buster.projectile_weapon;
    trigger.playersintrigger = [];
    trigger.var_a8d0289a93e5a155 = [];
    
    if ( gas_grenade::function_7ae095a698691834() )
    {
        trigger thread br::function_ce601d6f64265108( position );
    }
    
    trigger thread gas_grenade::gas_watchtriggerenter();
    trigger thread gas_grenade::gas_watchtriggerexit();
    trigger thread watch_gas_victims( 2, streak_info );
    trigger thread gas_grenade::gas_destroytriggerdelayed( duration, "gas_cleared" );
    
    if ( !isdefined( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = [];
    }
    
    level.var_9f723c1b2e8c3484[ level.var_9f723c1b2e8c3484.size ] = trigger;
}

// Namespace bunker_buster_mp
// Params 2
// Checksum 0x39ebdf3, Offset: 0x625
// Size: 0xaa
function watch_gas_victims( duration, streak_info )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( ;; )
    {
        self waittill( #"trigger", ent );
        num = ent getentitynumber();
        
        if ( !isdefined( streak_info.gas_victims[ num ] ) && ( isplayer( ent ) || isagent( ent ) ) && ent.team != self.team )
        {
            streak_info.gas_victims[ num ] = 1;
        }
    }
}

// Namespace bunker_buster_mp
// Params 1
// Checksum 0x6540769, Offset: 0x6d7
// Size: 0x2e
function dialog_deploy( player )
{
    br_public::brleaderdialogplayer( "bunker_buster" + "_deploy", player, 1, 0, 1, undefined, "" );
}

// Namespace bunker_buster_mp
// Params 2
// Checksum 0x58be5715, Offset: 0x70d
// Size: 0x61
function dialog_warning( friendlies, enemies )
{
    if ( friendlies.size > 0 )
    {
        br_public::brleaderdialog( "bunker_buster" + "_warning_friendly", 1, friendlies, 0, undefined, undefined, "" );
    }
    
    if ( enemies.size > 0 )
    {
        br_public::brleaderdialog( "bunker_buster" + "_warning_enemy", 1, enemies, 0, undefined, undefined, "" );
    }
}

// Namespace bunker_buster_mp
// Params 2
// Checksum 0x797349b, Offset: 0x776
// Size: 0x182
function dialog_hits( player, streak_info )
{
    dialog = "";
    total_victims = [];
    
    foreach ( k, v in streak_info.explosion_victims )
    {
        total_victims[ k ] = 1;
    }
    
    foreach ( k, v in streak_info.gas_victims )
    {
        total_victims[ k ] = 1;
    }
    
    switch ( total_victims.size )
    {
        case 0:
            dialog = "bunker_buster" + "_no_hits";
            break;
        case 1:
            dialog = "bunker_buster" + "_single_hit";
            break;
        default:
            dialog = "bunker_buster" + "_multiple_hits";
            break;
    }
    
    br_public::brleaderdialogplayer( dialog, player, 1, 0, undefined, undefined, "" );
}

/#

    // Namespace bunker_buster_mp
    // Params 0, eflags: 0x4
    // Checksum 0xe20c4b38, Offset: 0x900
    // Size: 0xb1, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4e>", "<dev string:x72>", &function_8d90c565b9fc0f7a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x83>", "<dev string:xa4>", &function_8d90c565b9fc0f7a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb5>", "<dev string:xc9>", &function_d2dcfd50e5f39365 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd6>", "<dev string:xe8>", &function_d2dcfd50e5f39365 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf5>", "<dev string:x109>", &function_d2dcfd50e5f39365 );
        devgui::function_77df7fe7dd273e10();
        
        if ( isbrgamemode() )
        {
            devgui::function_9082edeb5db93280( "<dev string:x116>" );
            devgui::add_devgui_command( "<dev string:x12e>", "<dev string:x13c>" );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace bunker_buster_mp
    // Params 1, eflags: 0x4
    // Checksum 0xbab1ee01, Offset: 0x9b9
    // Size: 0x26, Type: dev
    function private function_8d90c565b9fc0f7a( params )
    {
        level.player thread function_3982c695982f8bc5( int( params[ 0 ] ) );
    }

    // Namespace bunker_buster_mp
    // Params 1, eflags: 0x4
    // Checksum 0x66e77001, Offset: 0x9e7
    // Size: 0x34, Type: dev
    function private function_d2dcfd50e5f39365( params )
    {
        direction = int( params[ 0 ] );
        level.player thread function_656740d7163522ae( direction );
    }

    // Namespace bunker_buster_mp
    // Params 1, eflags: 0x4
    // Checksum 0xd86c96, Offset: 0xa23
    // Size: 0x112, Type: dev
    function private function_3982c695982f8bc5( team )
    {
        player = undefined;
        
        if ( team == 0 )
        {
            player = self;
        }
        else
        {
            foreach ( p in level.players )
            {
                if ( p.team != self.team )
                {
                    player = p;
                }
            }
            
            if ( !isdefined( player ) )
            {
                iprintlnbold( "<dev string:x17d>" );
                return;
            }
        }
        
        streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "<dev string:x1b0>", player );
        streakinfo.targetoverride = self.origin;
        streakinfo.uid = player bunker_buster::function_284de62c881a1cee();
        player thread bunker_buster::strike_fire( streakinfo );
    }

    // Namespace bunker_buster_mp
    // Params 1, eflags: 0x4
    // Checksum 0x8553eee8, Offset: 0xb3d
    // Size: 0x1f5, Type: dev
    function private function_656740d7163522ae( direction )
    {
        self notify( "<dev string:x1be>" );
        self endon( "<dev string:x1be>" );
        origin = self.origin;
        
        if ( getdvarint( @"hash_1826bea9905c3eea", 0 ) )
        {
            origin = level.var_d091fc9631f2e540;
            setdvar( @"hash_1826bea9905c3eea", 0 );
        }
        else
        {
            level.var_d091fc9631f2e540 = origin;
        }
        
        missile = spawn_missile( origin );
        do_opposite = 0;
        
        if ( direction == 2 )
        {
            direction = 0;
            do_opposite = 1;
        }
        
        dir_trace = missile full_rt( direction );
        
        if ( isdefined( dir_trace ) )
        {
            if ( do_opposite )
            {
                var_f5a0fbde2d50755 = missile full_rt( !direction );
            }
        }
        
        stuck_to = missile function_572848b9d20fa013();
        
        if ( getdvarint( @"hash_d2398cc34f83ff2b", 1 ) )
        {
            level thread missile_explosion( missile, stuck_to );
            
            if ( dir_trace.size > 0 )
            {
                has_debug = isdefined( dir_trace[ #"debugdata" ] ) + isdefined( dir_trace[ dir_trace.size - 1 ][ "<dev string:x1db>" ] );
                
                for ( i = 0; i < dir_trace.size - has_debug ; i++ )
                {
                    potential_output = dir_trace[ i ];
                    
                    if ( i > 1 )
                    {
                        prev_potential_output = dir_trace[ i - 1 ];
                        dist = distance( potential_output[ "<dev string:x1e0>" ], prev_potential_output[ "<dev string:x1e0>" ] );
                        
                        if ( dist > 512 )
                        {
                            break;
                        }
                        
                        if ( dist < 64 )
                        {
                            continue;
                        }
                    }
                    
                    missile = spawn_missile( potential_output[ "<dev string:x1e0>" ], -32, ( 0, 0, -1024 ), missile );
                    stuck_to = missile function_572848b9d20fa013();
                    level thread missile_explosion( missile, stuck_to );
                }
            }
        }
        
        if ( isdefined( missile ) )
        {
            missile thread utility::delete_after_delay( level.framedurationseconds );
            missile function_fab4d59281f1b075();
        }
    }

    // Namespace bunker_buster_mp
    // Params 1, eflags: 0x4
    // Checksum 0x98c8e364, Offset: 0xd3a
    // Size: 0x1ed, Type: dev
    function private full_rt( direction )
    {
        start = direction == 0 ? self.origin : utility::flat_origin( self.origin );
        end = direction == 0 ? utility::flat_origin( self.origin ) : self.origin;
        contents = trace::create_contents( 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0 );
        rt_type = getdvarint( @"hash_604388345506b32e", 0 );
        
        if ( rt_type == 0 )
        {
            trace = trace::ray_trace_get_all_results( start, end, [ self ], contents, 1 );
        }
        else if ( rt_type == 1 )
        {
            trace = trace::capsule_trace_get_all_results( start, end, 16, 32, self.angles, [ self ], contents, 1 );
        }
        else if ( rt_type == 2 )
        {
            trace = trace::sphere_trace_get_all_results( start, end, 32, [ self ], contents, 1, 0 );
        }
        
        if ( trace.size == 1 )
        {
            key = getarraykey( trace, 0 );
            
            if ( isxhash( key ) && key == #"debugdata" )
            {
                return;
            }
        }
        
        trace = adjust_trace( trace, end, direction, 128, 360 );
        
        if ( isdefined( trace ) )
        {
            switch ( direction )
            {
                case 0:
                    color = ( 1, 1, 1 );
                    break;
                case 1:
                    color = ( 1, 0.5, 0 );
                    break;
                case 2:
                    color = ( 1, 1, 0 );
                    break;
            }
            
            trace::draw_trace( trace, color, 1, int( 60 / level.framedurationseconds ) );
        }
        
        return trace;
    }

    // Namespace bunker_buster_mp
    // Params 5, eflags: 0x4
    // Checksum 0x78024de3, Offset: 0xf2f
    // Size: 0x251, Type: dev
    function private adjust_trace( trace, end, direction, min_dist, max_dist )
    {
        if ( !getdvarint( @"hash_e4b86b7a307bc35", 1 ) )
        {
            return trace;
        }
        
        if ( trace.size == 0 )
        {
            return;
        }
        
        valid_trace = [];
        
        if ( isdefined( trace[ #"debugdata" ] ) )
        {
            debug_data = trace[ #"debugdata" ];
            trace[ #"debugdata" ] = undefined;
        }
        
        if ( direction == 1 )
        {
            trace = arrayreverse( trace );
        }
        
        for ( i = 0; i < trace.size ; i++ )
        {
            if ( !isdefined( trace[ i ] ) )
            {
                continue;
            }
            
            ct = trace[ i ];
            
            if ( !isdefined( trace[ i + 1 ] ) )
            {
                if ( valid_trace.size == 0 )
                {
                    break;
                }
                
                ntp = valid_trace[ valid_trace.size - 1 ][ "<dev string:x1e0>" ];
            }
            else
            {
                ntp = trace[ i + 1 ][ "<dev string:x1e0>" ];
            }
            
            dist = abs( distance( ct[ "<dev string:x1e0>" ], ntp ) );
            
            if ( dist == 0 )
            {
                valid_trace[ valid_trace.size ] = ct;
                break;
            }
            
            if ( dist < min_dist )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_65fd9d08dc67fde1", 0 ) )
            {
                if ( dist >= max_dist )
                {
                    if ( i < trace.size )
                    {
                        valid_trace[ valid_trace.size ] = ct;
                    }
                    
                    break;
                }
            }
            
            if ( direction == 1 && getdvarint( @"hash_95dca2c14e359be2", 1 ) )
            {
                test_trace = trace::ray_trace( ct[ "<dev string:x1e0>" ], utility::flat_origin( ct[ "<dev string:x1e0>" ] ), undefined, undefined, 1, 1, 0 );
                
                if ( test_trace[ "<dev string:x1e9>" ] == "<dev string:x1f1>" )
                {
                    continue;
                }
            }
            
            valid_trace[ valid_trace.size ] = ct;
        }
        
        if ( valid_trace.size > 0 )
        {
            if ( isdefined( debug_data ) )
            {
                valid_trace[ valid_trace.size ] = debug_data;
            }
            
            return valid_trace;
        }
        
        if ( isdefined( ct ) && direction == 1 && getdvarint( @"hash_95dca2c14e359be2", 1 ) )
        {
            test_trace = trace::ray_trace( ct[ "<dev string:x1e0>" ], utility::flat_origin( ct[ "<dev string:x1e0>" ] ), undefined, undefined, 1, 1, 0 );
            
            if ( test_trace[ "<dev string:x1e9>" ] == "<dev string:x1f1>" )
            {
                return;
            }
        }
        
        if ( isdefined( debug_data ) )
        {
            trace[ trace.size ] = debug_data;
        }
        
        return trace;
    }

    // Namespace bunker_buster_mp
    // Params 4, eflags: 0x4
    // Checksum 0xcbecef42, Offset: 0x1188
    // Size: 0x186, Type: dev
    function private spawn_missile( origin, offset, velocity, prev_missile )
    {
        if ( !isdefined( offset ) )
        {
            offset = 4096;
        }
        
        if ( !isdefined( velocity ) )
        {
            velocity = ( 0, 0, 0 );
        }
        
        bombing_info = { #initvelocity:velocity, #sourcepos:origin + ( 0, 0, offset ), #goalpos:origin };
        
        if ( !isdefined( prev_missile ) )
        {
            streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "<dev string:x1b0>", self );
        }
        else
        {
            streakinfo = prev_missile.streakinfo;
        }
        
        missile = magicgrenademanual( "<dev string:x1fe>", bombing_info.sourcepos, bombing_info.initvelocity, 6, self );
        missile setscriptablepartstate( "<dev string:x20b>", "<dev string:x211>", 0 );
        
        if ( !isdefined( prev_missile ) )
        {
            missile setscriptablepartstate( "<dev string:x218>", "<dev string:x211>", 0 );
        }
        
        if ( isdefined( prev_missile ) )
        {
            minimapid = prev_missile.minimapid;
            prev_missile delete();
        }
        else
        {
            minimapid = missile objidpoolmanager::createobjective( "<dev string:x21f>", self.team, undefined, 1, 1 );
        }
        
        missile.minimapid = minimapid;
        missile.streakinfo = streakinfo;
        missile.owner = self;
        missile setentityowner( self );
        missile setotherent( self );
        missile forcenetfieldhighlod( 1 );
        return missile;
    }

    // Namespace bunker_buster_mp
    // Params 0, eflags: 0x4
    // Checksum 0xe7f81ed7, Offset: 0x1316
    // Size: 0x75, Type: dev
    function private function_fab4d59281f1b075()
    {
        if ( self.classname != "<dev string:x249>" )
        {
            namespace_9d8e359c3b1041e5::setmissileminimapvisiblesharedfunc( 0 );
        }
        
        if ( isdefined( self.minimapid ) )
        {
            if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
            {
                [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
            }
            
            self.minimapid = undefined;
        }
    }

    // Namespace bunker_buster_mp
    // Params 0, eflags: 0x4
    // Checksum 0x98b28a2f, Offset: 0x1393
    // Size: 0x7d, Type: dev
    function private function_572848b9d20fa013()
    {
        impact_info = killstreak_shared::killstreak_waittillexplode( "<dev string:x256>", "<dev string:x264>", "<dev string:x279>" );
        stuck_to = undefined;
        
        if ( isdefined( impact_info ) )
        {
            if ( impact_info.msg == "<dev string:x256>" )
            {
                stuck_to = impact_info.param1;
            }
            else if ( impact_info.msg == "<dev string:x264>" )
            {
                self.water_impact = 1;
            }
        }
        
        return stuck_to;
    }

    // Namespace bunker_buster_mp
    // Params 2, eflags: 0x4
    // Checksum 0x72e1926c, Offset: 0x1418
    // Size: 0xb1, Type: dev
    function private missile_explosion( missile, stuck_to )
    {
        if ( !getdvarint( @"hash_21fb555b256afb3a", 1 ) )
        {
            return;
        }
        
        explosion_ent = toma_strike::toma_strike_create_explosion( missile.origin, missile.angles, stuck_to, missile.owner, gettime(), missile.streakinfo );
        explode_part = missile.water_impact ? "<dev string:x27f>" : "<dev string:x293>";
        explosion_ent setscriptablepartstate( explode_part, "<dev string:x211>", 0 );
        explosion_ent thread utility::delete_after_delay( 0.1 );
    }

#/

// Namespace bunker_buster_mp
// Params 1
// Checksum 0x7fd921ba, Offset: 0x14d1
// Size: 0x1e
function function_2eeef3a721b936d7( player )
{
    player thread points::doscoreevent( #"hash_524d6f950b94dfc2" );
}

// Namespace bunker_buster_mp
// Params 1
// Checksum 0x7607ccb7, Offset: 0x14f7
// Size: 0x1e
function function_ca1a5849471f6394( player )
{
    player thread points::doscoreevent( #"hash_16c1add3a59e1b21" );
}

