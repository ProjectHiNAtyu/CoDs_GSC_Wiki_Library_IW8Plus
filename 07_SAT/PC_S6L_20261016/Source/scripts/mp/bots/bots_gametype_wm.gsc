// scripts\mp\bots\bots_gametype_wm.gsc  (hash_1cdfa30be679555d.gscc) (size: 7706 Bytes / 0x1e1a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xce6e703b (3463344187)
// size ...... 7706 (0x1e1a)
// includes .. 8   (offset: 0x1c46)
// strings ... 17  (offset: 0x1c86)
// dev strs .. 3   (offset: 0x1df6)
// exports ... 19  (offset: 0x1252)
// cseg ...... 0x16f + 0x10e3 (0x1252)
// imports ... 54  (offset: 0x154a)
// animtree1 . 0   (offset: 0x1e1a)
// animtree2 . 0   (offset: 0x1e1a)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;

#namespace bots_gametype_wm;

// Namespace bots_gametype_wm
// Params 0
// Checksum 0xdc05c049, Offset: 0x18d
// Size: 0xae
function main()
{
    function_9f249c47bdf57c37( 1, &function_848f162a0a85faa1 );
    function_9f249c47bdf57c37( 2, &function_dbece2693b083d11 );
    function_9f249c47bdf57c37( 3, &function_608247dde079b3ae );
    function_9f249c47bdf57c37( 4, &function_848f162a0a85faa1 );
    function_9f249c47bdf57c37( 5, &function_3e2d8abd6a3f6e7f );
    function_9f249c47bdf57c37( 6, &function_2a487a49c3c6828a );
    function_9f249c47bdf57c37( 7, &function_848f162a0a85faa1 );
    function_9f249c47bdf57c37( 8, &function_848f162a0a85faa1 );
    function_9f249c47bdf57c37( 9, &function_9fcbd632a790cbca );
    level.var_d7ed3bdcb00a6cee = game[ "attackers" ];
    level.var_446ad1473db1520e = game[ "defenders" ];
    setup_callbacks();
    setup_bot_wm();
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x47cc8c2a, Offset: 0x243
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_wm_think;
    autopilot::initialize( undefined, undefined, [ "bot_wm_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x30edb588, Offset: 0x27e
// Size: 0x2
function setup_bot_wm()
{
    
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x186ecf99, Offset: 0x288
// Size: 0xfd
function bot_wm_think()
{
    self notify( #"bot_wm_think" );
    self endon( #"bot_wm_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self botsetflag( "disable_separation", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        if ( self.health <= 0 || self.liveragdoll )
        {
            wait 0.05;
            continue;
        }
        
        if ( !isdefined( level.zone ) )
        {
            wait 0.05;
            continue;
        }
        
        objectivetype = level.zone.objectivetype;
        
        if ( isdefined( objectivetype ) )
        {
            var_5bf41c9ec4fe6a0c = self [[ level.var_b177db790af0ee45[ objectivetype ] ]]();
            
            if ( !var_5bf41c9ec4fe6a0c )
            {
                self botclearscriptgoal();
            }
        }
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x533ae8e8, Offset: 0x38d
// Size: 0x20b, Type: bool
function function_2a487a49c3c6828a()
{
    random_target_radius = 512;
    
    if ( !isdefined( self.vehicle_target ) )
    {
        self.vehicle_target = utility::array_random( level.escortvehicles );
    }
    
    if ( !isdefined( self.vehicle_target ) )
    {
        return false;
    }
    
    var_d493244702d501ff = getrandomnavpoint( self.vehicle_target.origin, random_target_radius );
    
    if ( !isdefined( var_d493244702d501ff ) )
    {
        return false;
    }
    
    if ( !self botsetscriptgoal( var_d493244702d501ff, 64, "critical" ) )
    {
        return false;
    }
    
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result == "bad_path" && game_utility::getmapname() == "mp_jup_launchfacility" )
    {
        if ( self.vehicle_target.var_63ba5ed26f65fcf2 <= 1 )
        {
            for ( nodeid = self.vehicle_target.var_63ba5ed26f65fcf2; nodeid < self.vehicle_target.pathnodes.size ; nodeid++ )
            {
                nodepos = self.vehicle_target.pathnodes[ nodeid ];
                var_d493244702d501ff = getrandomnavpoint( nodepos.origin, random_target_radius );
                
                if ( !self botsetscriptgoal( var_d493244702d501ff, 64, "critical" ) )
                {
                    return false;
                }
                
                result = bots_util::bot_waittill_goal_or_fail();
                
                if ( result == "goal" )
                {
                    break;
                }
            }
        }
    }
    
    if ( result == "goal" )
    {
        /#
            botrepair = getdvarint( @"hash_8d0535c35be2b9c0", 0 );
            
            if ( botrepair != 0 && self.pers[ "<dev string:x24>" ] == game[ "<dev string:x29>" ] )
            {
                self botpressbutton( "<dev string:x33>", 1 );
                
                if ( self.vehicle_target.repairtrigger.progress > 0.5 )
                {
                    self.vehicle_target.repairtrigger.progress = 0.1;
                }
            }
        #/
        
        self botclearscriptgoal();
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0xca1e76de, Offset: 0x5a1
// Size: 0x1c5
function function_848f162a0a85faa1()
{
    if ( !isdefined( level.var_f81a10f3146550e9 ) )
    {
        return 0;
    }
    
    var_af2d2b6ad4448366 = [];
    
    foreach ( zone in level.var_f81a10f3146550e9 )
    {
        if ( !isdefined( zone.complete ) )
        {
            var_af2d2b6ad4448366[ var_af2d2b6ad4448366.size ] = zone;
            continue;
        }
    }
    
    var_b176fae21df10829 = utility::array_random( var_af2d2b6ad4448366 );
    level.var_f81a10f3146550e9 = var_af2d2b6ad4448366;
    
    if ( !isdefined( var_b176fae21df10829.tacpoints ) )
    {
        var_b176fae21df10829.tacpoints = bots_gametype_common::function_3491b57e9cace1d5( var_b176fae21df10829 );
    }
    
    if ( !isdefined( var_b176fae21df10829.entrance_indices ) )
    {
        bots_gametype_common::bot_cache_entrances_to_zones( [ var_b176fae21df10829 ] );
    }
    
    if ( game_utility::getmapname() == "mp_jup_launchfacility" )
    {
        return function_f1bd5081867f2d30( var_b176fae21df10829 );
    }
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        if ( !self botsetscriptgoal( ( -24616.4, 42112.4, -160 ), 256, "critical" ) )
        {
            return 0;
        }
        
        result = bots_util::bot_waittill_goal_or_fail();
        
        if ( result != "goal" )
        {
            return 0;
        }
    }
    
    tacpoint = utility::array_random( var_b176fae21df10829.tacpoints );
    
    if ( !self botsetscriptgoal( tacpoint, 16, "critical" ) )
    {
        return 0;
    }
    
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result != "goal" )
    {
        return 0;
    }
    else
    {
        self botclearscriptgoal();
    }
    
    return 1;
}

// Namespace bots_gametype_wm
// Params 1
// Checksum 0x21669470, Offset: 0x76f
// Size: 0x6e, Type: bool
function function_f1bd5081867f2d30( var_b176fae21df10829 )
{
    node = utility::array_random( var_b176fae21df10829.nodes );
    
    if ( !self botsetscriptgoal( node.origin, 128, "critical" ) )
    {
        return false;
    }
    
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result != "goal" )
    {
        return false;
    }
    else
    {
        self botclearscriptgoal();
    }
    
    return true;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x4af894ad, Offset: 0x7e6
// Size: 0x150, Type: bool
function function_dbece2693b083d11()
{
    if ( !isdefined( level.var_70fe84415eb002b1 ) )
    {
        return false;
    }
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        foreach ( bombzone in arrayrandomize( level.var_70fe84415eb002b1 ) )
        {
            if ( !bombzone.complete )
            {
                var_ce7ee78a7eac9273 = bombzone;
                self botclearbutton( "use" );
            }
        }
        
        point = getclosestpointonnavmesh( var_ce7ee78a7eac9273.curorigin );
        self botsetscriptgoal( point, 16, "critical" );
        
        /#
            sphere( point, 16, ( 1, 1, 1 ), 0, 4000 );
        #/
        
        result = bots_util::bot_waittill_goal_or_fail();
        
        if ( result == "goal" )
        {
            self botpressbutton( "use", 100 );
            result = bots_util::bot_usebutton_wait( 100 );
            self botclearscriptgoal();
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x174ad50d, Offset: 0x93f
// Size: 0x1b7, Type: bool
function function_3e2d8abd6a3f6e7f()
{
    if ( !isdefined( level.aa_sites ) )
    {
        return false;
    }
    
    var_3f4430319351d6eb = undefined;
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        foreach ( aasite in arrayrandomize( level.aa_sites ) )
        {
            if ( !isdefined( aasite ) )
            {
                continue;
            }
            
            objective = level.objectives[ aasite.objectivekey ];
            
            if ( !objective.complete )
            {
                var_3f4430319351d6eb = aasite;
                self botclearbutton( "use" );
            }
        }
        
        if ( !isdefined( var_3f4430319351d6eb ) )
        {
            return false;
        }
        
        point = var_3f4430319351d6eb.origin - 64 * vectornormalize( anglestoforward( var_3f4430319351d6eb.angles ) ) + 64 * vectornormalize( anglestoright( var_3f4430319351d6eb.angles ) );
        point = getclosestpointonnavmesh( point );
        self botsetscriptgoal( point, 16, "critical" );
        
        /#
            sphere( point, 16, ( 1, 1, 1 ), 0, 4000 );
        #/
        
        result = bots_util::bot_waittill_goal_or_fail();
        
        if ( result == "goal" )
        {
            self botpressbutton( "use", 100 );
            result = bots_util::bot_usebutton_wait( 100 );
            self botclearscriptgoal();
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x38b43744, Offset: 0xaff
// Size: 0x124, Type: bool
function function_608247dde079b3ae()
{
    if ( !isdefined( self.hostage_target ) )
    {
        self.hostage_target = utility::array_random( level.hostages );
    }
    
    if ( !isdefined( self.hostage_target ) )
    {
        return false;
    }
    
    if ( function_2df95d4df780af4e() )
    {
        self botsetscriptgoal( level.var_523987179ec00ac0.curorigin, 16, "critical" );
        result = bots_util::bot_waittill_goal_or_fail();
        
        if ( result == "goal" )
        {
            self botpressbutton( "use", 1 );
            result = bots_util::bot_usebutton_wait( 1 );
        }
    }
    else if ( self.pers[ "team" ] == level.var_d7ed3bdcb00a6cee )
    {
        if ( !isdefined( self.hostage_target.curorigin ) )
        {
            return false;
        }
        
        self botsetscriptgoal( self.hostage_target.curorigin, 16, "critical" );
        result = bots_util::bot_waittill_goal_or_fail();
        
        if ( result == "goal" )
        {
            self botpressbutton( "use", 1 );
            result = bots_util::bot_usebutton_wait( 1 );
        }
    }
    
    return true;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0xde07322e, Offset: 0xc2c
// Size: 0x41e, Type: bool
function function_9fcbd632a790cbca()
{
    if ( !isdefined( level.zone.hackzones ) )
    {
        return false;
    }
    
    var_24986b63cf31ae6d = getdvarint( @"hash_ed44a08b9b3977b4", 1000 );
    teammates = teams::getteamdata( self.team, "alivePlayers" );
    teammates = arrayremove( teammates, self );
    var_81f3885e0ffa52fb = undefined;
    bestscore = 0;
    isattacker = self.pers[ "team" ] == game[ "attackers" ];
    
    foreach ( zone in level.zone.hackzones )
    {
        if ( !isdefined( zone ) || zone.complete )
        {
            continue;
        }
        
        score = 0;
        
        if ( isattacker )
        {
            if ( !zone.hacked )
            {
                if ( zone.ishacking )
                {
                    score += 200;
                }
                else
                {
                    score += 300;
                }
            }
            else
            {
                score += 100;
                score -= zone.uploadingprogress * 100;
            }
        }
        else if ( zone.hacked )
        {
            if ( zone.var_2497a72ca9a9c5e6 )
            {
                score += 200;
            }
            else
            {
                score += 300;
                score += zone.uploadingprogress * 100;
            }
        }
        else
        {
            score += 100;
        }
        
        nearbyteammates = sortbydistancecullbyradius( teammates, zone.curorigin, var_24986b63cf31ae6d );
        score -= nearbyteammates.size * 1;
        
        if ( bestscore < score )
        {
            bestscore = score;
            var_81f3885e0ffa52fb = zone;
            continue;
        }
        
        if ( bestscore == score )
        {
            if ( distance2dsquared( zone.curorigin, self.origin ) < distance2dsquared( var_81f3885e0ffa52fb.curorigin, self.origin ) )
            {
                var_81f3885e0ffa52fb = zone;
            }
        }
    }
    
    if ( !isdefined( var_81f3885e0ffa52fb ) )
    {
        return false;
    }
    
    shouldusebutton = isattacker && !var_81f3885e0ffa52fb.hacked && !var_81f3885e0ffa52fb.ishacking || !isattacker && var_81f3885e0ffa52fb.hacked && !var_81f3885e0ffa52fb.var_2497a72ca9a9c5e6;
    
    if ( shouldusebutton )
    {
        var_d1ed849a969d94bb = 16;
        point = getclosestpointonnavmesh( var_81f3885e0ffa52fb.curorigin );
        self botclearscriptgoal();
        waitframe();
        success = self botsetscriptgoal( point, var_d1ed849a969d94bb, "critical" );
        
        if ( !success )
        {
            return false;
        }
        
        /#
            sphere( point, var_d1ed849a969d94bb, ( 1, 0, 0 ), 0, 120 );
        #/
        
        result = bots_util::bot_waittill_goal_or_fail( 2 );
        
        if ( result != "goal" )
        {
            return false;
        }
        
        var_5e84b18a2f3b715d = getdvarint( @"hash_cf260feea44f2491", 5 );
        
        if ( isdefined( self.lastdamagedtime ) && gettime() - self.lastdamagedtime < var_5e84b18a2f3b715d )
        {
            return true;
        }
        
        holdtime = getdvarint( @"hash_20b6c6b984cdc05b", 3 );
        self botpressbutton( "use", holdtime );
        result = bots_util::bot_usebutton_wait( holdtime, "damage" );
        self botclearscriptgoal();
        return true;
    }
    else
    {
        const_target_radius = 32;
        point = function_d6f98241da3d4583( var_81f3885e0ffa52fb.curorigin, 256, 1024 );
        self botclearscriptenemy();
        success = self botsetscriptgoal( point, const_target_radius, "critical" );
        
        if ( !success )
        {
            return false;
        }
        
        /#
            sphere( point, const_target_radius, ( 1, 1, 1 ), 0, 120 );
        #/
        
        result = bots_util::bot_waittill_goal_or_fail( 5 );
        return ( result == "goal" );
    }
    
    return false;
}

// Namespace bots_gametype_wm
// Params 3
// Checksum 0x4086629e, Offset: 0x1053
// Size: 0x80
function function_d6f98241da3d4583( origin, radius_min, radius_max )
{
    r = randomfloatrange( radius_min, radius_max );
    angle = randomfloat( 360 );
    offset = ( r * cos( angle ), r * sin( angle ), 0 );
    pos = origin + offset;
    navpos = getclosestpointonnavmesh( pos );
    return navpos;
}

// Namespace bots_gametype_wm
// Params 2
// Checksum 0x4eaf1f5f, Offset: 0x10dc
// Size: 0x39
function function_9f249c47bdf57c37( objectivetype, func )
{
    if ( !isdefined( level.var_b177db790af0ee45 ) )
    {
        level.var_b177db790af0ee45 = [];
    }
    
    level.var_b177db790af0ee45[ objectivetype ] = func;
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0xd76cd9ad, Offset: 0x111d
// Size: 0xc, Type: bool
function function_2df95d4df780af4e()
{
    return istrue( self.hashostage );
}

// Namespace bots_gametype_wm
// Params 0
// Checksum 0x228cf3cd, Offset: 0x1132
// Size: 0x12
function clear_defend()
{
    if ( namespace_14346d439f44a158::is_defending() )
    {
        namespace_14346d439f44a158::function_87e8deae08ce1a0();
    }
}

// Namespace bots_gametype_wm
// Params 1
// Checksum 0x60c31aca, Offset: 0x114c
// Size: 0x24, Type: bool
function bot_is_capturing_zone( zone )
{
    if ( !namespace_14346d439f44a158::is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_wm
// Params 1
// Checksum 0xbd44717d, Offset: 0x1179
// Size: 0x64
function bot_capture_koth_zone( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_tacpoint" ] = zone.center_tacpoint;
    namespace_14346d439f44a158::capture_zone( gameobjects_shared::get_origin( zone ), zone.tacpoints, zone, optional_params );
}

// Namespace bots_gametype_wm
// Params 2
// Checksum 0xf792367d, Offset: 0x11e5
// Size: 0x6c
function function_4fec844cf1d187b9( origin, radius )
{
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        enemies = teams::getteamdata( game[ "defenders" ], "alivePlayers" );
    }
    else
    {
        enemies = teams::getteamdata( game[ "attackers" ], "alivePlayers" );
    }
    
    return sortbydistancecullbyradius( enemies, origin, radius );
}

