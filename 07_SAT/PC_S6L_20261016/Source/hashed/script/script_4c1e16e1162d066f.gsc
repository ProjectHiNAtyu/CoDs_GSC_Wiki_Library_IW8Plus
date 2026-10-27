// script_4c1e16e1162d066f  (hash_4c1e16e1162d066f.gscc) (size: 17178 Bytes / 0x431a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9f5c8187 (2673639815)
// size ...... 17178 (0x431a)
// includes .. 16  (offset: 0x3fae)
// strings ... 49  (offset: 0x402e)
// dev strs .. 2   (offset: 0x4302)
// exports ... 55  (offset: 0x2706)
// cseg ...... 0x3e1 + 0x2325 (0x2706)
// imports ... 133 (offset: 0x2f9e)
// animtree1 . 0   (offset: 0x431a)
// animtree2 . 0   (offset: 0x431a)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\common\equipment\c4;
#using scripts\mp\common\equipment\combataxe;
#using scripts\mp\common\equipment\decoy_grenade;
#using scripts\mp\common\equipment\mini_sentry;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\equipment\sensor_grenade;
#using scripts\mp\common\supers\drone_launcher;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\radiation;

#namespace ob_adz;

// Namespace ob_adz
// Params 1
// Checksum 0xb53647ce, Offset: 0x3ff
// Size: 0x1ed
function function_86ebf122bc776db5( b_dmg_outside = 0 )
{
    if ( utility::flag( "flag_area_denial_zone_init_begin" ) || utility::flag( "flag_area_denial_zone_init_complete" ) )
    {
        return;
    }
    
    utility::flag_set( "flag_area_denial_zone_init_begin" );
    level.var_117f58399f256fb6 = spawnstruct();
    level.var_117f58399f256fb6.var_23bd2c7f10918114 = 3;
    level.var_117f58399f256fb6.var_69e0a784e0cbf010 = int( 2 );
    level.var_117f58399f256fb6.var_4174d31098d8b9f8 = 1;
    level.var_117f58399f256fb6.var_608be8a9cfbc6a3c = int( 2 );
    level.var_117f58399f256fb6.var_bd1fe09d78a11cc1 = 10;
    level.var_117f58399f256fb6.damage_increase_max = int( 20 );
    level.var_117f58399f256fb6.zombie_damage_multiplier = 0.75;
    level.var_117f58399f256fb6.agent_damage_multiplier = 1.25;
    level.var_117f58399f256fb6.agent_damage_percent = 0.4;
    level.var_117f58399f256fb6.agent_damage_cooldown = 4000;
    level.var_117f58399f256fb6.quest_circle_inside = "Radiation_Sat_Ob_inner";
    level.var_117f58399f256fb6.quest_circle_outside = "Radiation_Sat_Ob_outer";
    level.var_117f58399f256fb6.var_bd84acd4fff0b4d9 = "mp_sat_ob_gemini";
    level.var_117f58399f256fb6.var_e9a329debf084432 = "mp_sat_ob_gemini_inverted";
    function_25d4a7092004ab79( b_dmg_outside );
    function_4039668d9e2ee8dd();
    zombie_utils::function_dfae6a5bd222c586( &_on_zombie_damage );
    agent_utils::register_soldier_damage_callback( &_on_agent_damage );
    level.var_117f58399f256fb6.radiation_array = [];
    utility::flag_set( "flag_area_denial_zone_init_complete" );
}

// Namespace ob_adz
// Params 4
// Checksum 0x76f8752b, Offset: 0x5f4
// Size: 0x9e
function function_47e86714392d46b4( struct_targetname, zone_radius, b_dmg_outside = 0, b_scramble = 0 )
{
    var_8c4fe62d01999d1e = utility::getstruct( struct_targetname, "targetname" );
    
    if ( !isdefined( zone_radius ) )
    {
        if ( isdefined( var_8c4fe62d01999d1e.radius ) )
        {
            zone_radius = var_8c4fe62d01999d1e.radius;
        }
        else
        {
            zone_radius = 2048;
        }
    }
    
    var_117f58399f256fb6 = function_76f1b56fc487b23b( struct_targetname, var_8c4fe62d01999d1e.origin, zone_radius, b_dmg_outside, b_scramble );
    return var_117f58399f256fb6;
}

// Namespace ob_adz
// Params 5
// Checksum 0x970994e8, Offset: 0x69b
// Size: 0x1c5
function function_76f1b56fc487b23b( zone_id, zone_origin, zone_radius, b_dmg_outside = 0, b_scramble = 0 )
{
    if ( !level utility::flag( "flag_area_denial_zone_init_begin" ) )
    {
        function_86ebf122bc776db5();
    }
    else
    {
        utility::flag_wait( "flag_area_denial_zone_init_complete" );
    }
    
    function_25d4a7092004ab79( b_dmg_outside );
    QUEST_CIRCLE = function_f570090a98313b59( b_dmg_outside );
    waitframe();
    radiation = radiation::create( zone_origin, zone_radius, level.var_117f58399f256fb6.var_4174d31098d8b9f8, QUEST_CIRCLE, 1, b_dmg_outside );
    level.var_117f58399f256fb6.radiation_array[ level.var_117f58399f256fb6.radiation_array.size ] = radiation;
    radiation.zone_id = zone_id;
    radiation.zone_players = [];
    radiation radiation::function_1de5a68ddcf339aa( level.var_117f58399f256fb6.var_69e0a784e0cbf010, level.var_117f58399f256fb6.var_608be8a9cfbc6a3c, level.var_117f58399f256fb6.var_bd1fe09d78a11cc1, level.var_117f58399f256fb6.damage_increase_max );
    radiation callback::add( "player_entered_radiation", &function_6258359d76339439 );
    radiation callback::add( "player_exited_radiation", &function_3fb0848c4a63b803 );
    
    if ( b_scramble )
    {
        radiation radiation::set_radar_scramble( 1 );
    }
    
    radiation thread _agents_update();
    radiation thread _equipment_update();
    
    if ( b_dmg_outside )
    {
        radiation.var_e0dd4b03666cb7e8 = exclusion_zones::function_13326ea977bfb539( zone_origin, ( 2 * zone_radius, 0, 0 ), ( 0, 0, 0 ), 1 );
    }
    
    return radiation;
}

// Namespace ob_adz
// Params 1
// Checksum 0x792c87b4, Offset: 0x869
// Size: 0x87
function function_25d4a7092004ab79( b_dmg_outside = 0 )
{
    if ( b_dmg_outside == level.var_117f58399f256fb6.b_dmg_outside )
    {
        return;
    }
    
    if ( b_dmg_outside )
    {
        game_props = level.var_117f58399f256fb6.var_bd84acd4fff0b4d9;
    }
    else
    {
        game_props = level.var_117f58399f256fb6.var_e9a329debf084432;
    }
    
    setgameprops( game_props );
    level.var_117f58399f256fb6.b_dmg_outside = b_dmg_outside;
}

// Namespace ob_adz
// Params 1
// Checksum 0x4a2d2a13, Offset: 0x8f8
// Size: 0x52
function function_f570090a98313b59( b_dmg_outside = 0 )
{
    if ( b_dmg_outside )
    {
        QUEST_CIRCLE = level.var_117f58399f256fb6.quest_circle_outside;
    }
    else
    {
        QUEST_CIRCLE = level.var_117f58399f256fb6.quest_circle_inside;
    }
    
    return QUEST_CIRCLE;
}

// Namespace ob_adz
// Params 4
// Checksum 0x6c2a21c3, Offset: 0x953
// Size: 0x75
function function_f94c18166de9f51d( zone_id, transform_origin, transform_radius, transform_duration )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !isdefined( transform_origin ) )
    {
        transform_origin = radiation.origin;
    }
    
    if ( !isdefined( transform_radius ) )
    {
        transform_radius = radiation.radius;
    }
    
    if ( !isdefined( transform_duration ) )
    {
        transform_duration = 10;
    }
    
    radiation radiation::transform( transform_origin, transform_radius, transform_duration );
}

// Namespace ob_adz
// Params 5
// Checksum 0x8a060495, Offset: 0x9d0
// Size: 0x52
function function_e6a32356fff3021f( zone_id, var_5454f57201136c19, var_608be8a9cfbc6a3c, damage_increase_rate, damage_increase_max )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    radiation radiation::function_1de5a68ddcf339aa( var_5454f57201136c19, var_608be8a9cfbc6a3c, damage_increase_rate, damage_increase_max );
}

// Namespace ob_adz
// Params 1
// Checksum 0x219fa5a0, Offset: 0xa2a
// Size: 0x1c4
function function_a5e080cd4acacc53( zone_id )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    radiation.var_157cb954bcf8cf19 = 1;
    
    if ( radiation function_5a0008e97a795c3f() )
    {
        radiation function_7ff054a3cef544cd();
    }
    
    a_players = radiation.zone_players;
    
    if ( a_players.size > 0 )
    {
        foreach ( player in a_players )
        {
            if ( isdefined( player ) )
            {
                radiation.zone_players = arrayremove( radiation.zone_players, player );
                player.radiation_array = arrayremove( player.radiation_array, radiation );
            }
        }
    }
    
    level.var_117f58399f256fb6.radiation_array = arrayremove( level.var_117f58399f256fb6.radiation_array, radiation );
    radiation radiation::destroy();
    waitframe();
    
    if ( a_players.size > 0 )
    {
        foreach ( player in a_players )
        {
            if ( isdefined( player ) && player utility::ent_flag( "player_in_adz" ) )
            {
                player thread function_60b5ccb73d52d6c7();
            }
        }
    }
}

// Namespace ob_adz
// Params 2
// Checksum 0xec66c676, Offset: 0xbf6
// Size: 0x47
function function_f0f0de6800121e38( flag_destroy, zone_id )
{
    level utility::flag_wait( flag_destroy );
    
    if ( isdefined( function_a1b5ffd498b3f262( zone_id ) ) )
    {
        function_a5e080cd4acacc53( zone_id );
        return;
    }
    
    if ( function_75cf7cbba7a3a376() )
    {
        function_a5e080cd4acacc53();
    }
}

// Namespace ob_adz
// Params 0
// Checksum 0xacd195cb, Offset: 0xc45
// Size: 0x8d, Type: bool
function function_75cf7cbba7a3a376()
{
    if ( !level utility::flag( "flag_area_denial_zone_init_begin" ) )
    {
        function_86ebf122bc776db5();
    }
    else
    {
        utility::flag_wait( "flag_area_denial_zone_init_complete" );
    }
    
    if ( level.var_117f58399f256fb6.radiation_array.size > 0 )
    {
        for ( i = 0; i < level.var_117f58399f256fb6.radiation_array.size ; i++ )
        {
            if ( level.var_117f58399f256fb6.radiation_array[ i ] == self )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_adz
// Params 1
// Checksum 0xd8d8b54c, Offset: 0xcdb
// Size: 0xb5
function function_a1b5ffd498b3f262( zone_id )
{
    if ( !level utility::flag( "flag_area_denial_zone_init_begin" ) )
    {
        function_86ebf122bc776db5();
    }
    else
    {
        utility::flag_wait( "flag_area_denial_zone_init_complete" );
    }
    
    if ( level.var_117f58399f256fb6.radiation_array.size > 0 )
    {
        for ( i = 0; i < level.var_117f58399f256fb6.radiation_array.size ; i++ )
        {
            if ( level.var_117f58399f256fb6.radiation_array[ i ].zone_id == zone_id )
            {
                return level.var_117f58399f256fb6.radiation_array[ i ];
            }
        }
    }
}

// Namespace ob_adz
// Params 1
// Checksum 0x73c200d3, Offset: 0xd99
// Size: 0x89
function function_4b41c5c58f1cce95( zone_id )
{
    if ( !level utility::flag( "flag_area_denial_zone_init_begin" ) )
    {
        function_86ebf122bc776db5();
    }
    else
    {
        utility::flag_wait( "flag_area_denial_zone_init_complete" );
    }
    
    if ( isdefined( self ) && function_75cf7cbba7a3a376() )
    {
        radiation = self;
    }
    else
    {
        radiation = function_a1b5ffd498b3f262( zone_id );
    }
    
    if ( isdefined( zone_id ) )
    {
        assert( isdefined( radiation ), "<dev string:x24>" + zone_id );
    }
    else
    {
        assert( isdefined( radiation ), "<dev string:x57>" );
    }
    
    return radiation;
}

// Namespace ob_adz
// Params 1
// Checksum 0x82dd1a0a, Offset: 0xe2b
// Size: 0x63
function function_6258359d76339439( params )
{
    player = params.player;
    
    if ( !self.var_157cb954bcf8cf19 && isdefined( player ) && !isbot( player ) )
    {
        player thread function_39afabfb4aa667d5( self );
        player playrumbleonpositionforclient( "damage_heavy", player.origin );
    }
}

// Namespace ob_adz
// Params 1
// Checksum 0xed8d8125, Offset: 0xe96
// Size: 0x92
function function_3fb0848c4a63b803( params )
{
    player = params.player;
    
    if ( isdefined( player ) && isdefined( self ) && isdefined( self.zone_players ) && isdefined( player.radiation_array ) && !isbot( player ) )
    {
        self.zone_players = arrayremove( self.zone_players, player );
        player.radiation_array = arrayremove( player.radiation_array, self );
        player thread function_60b5ccb73d52d6c7();
    }
}

// Namespace ob_adz
// Params 1
// Checksum 0xca566b3c, Offset: 0xf30
// Size: 0x22
function function_99f3638286da180d( params )
{
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "aether_storm_sfx", "off" );
    }
}

// Namespace ob_adz
// Params 1
// Checksum 0x81f3e2f1, Offset: 0xf5a
// Size: 0x13a
function function_39afabfb4aa667d5( radiation )
{
    self notify( #"hash_a213d0662502ca73" );
    self endon( #"hash_a213d0662502ca73" );
    level endon( #"game_ended" );
    radiation endon( #"radiation_destroyed" );
    self endon( #"death" );
    
    if ( !isdefined( self.radiation_array ) )
    {
        self.radiation_array = [];
    }
    
    if ( !arraycontains( self.radiation_array, radiation ) )
    {
        self.radiation_array[ self.radiation_array.size ] = radiation;
    }
    
    if ( !arraycontains( radiation.zone_players, self ) )
    {
        radiation.zone_players[ radiation.zone_players.size ] = self;
    }
    
    if ( utility::ent_flag( "player_in_adz" ) )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "aether_storm_sfx", "activate" );
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:%"sat_ob_cradle_gas_circle_hallucination_gas_medium" }, 1, 1 );
    shellshock_utility_cpmp::_shellshock( %"gas_grenade_heavy_mp", #"gas", 1.5, 1 );
    utility::ent_flag_set( "player_in_adz" );
}

// Namespace ob_adz
// Params 0
// Checksum 0x3112ccc2, Offset: 0x109c
// Size: 0x81
function function_60b5ccb73d52d6c7()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.radiation_array.size > 0 )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "aether_storm_sfx", "off" );
    utility::ent_flag_clear( "player_in_adz" );
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:%"sat_ob_cradle_gas_circle_hallucination_gas_medium" } );
    shellshock_utility_cpmp::_stopshellshock();
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xadb854d7, Offset: 0x1125
// Size: 0x326
function private _agents_update()
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    var_dd77a4915a40fde6 = 0;
    nearby_agents = [];
    flee_point = undefined;
    var_2a669c0765836c0e = undefined;
    var_456fca0594399bfb = undefined;
    
    while ( function_75cf7cbba7a3a376() )
    {
        nearby_agents = getaiarrayinradius( self.origin, self.radius * 3, "all" );
        
        foreach ( agent in nearby_agents )
        {
            if ( !isalive( agent ) || agent.var_1e2afba6dedb6c52 || agent.var_b5ee399a718d6a57 )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            var_456fca0594399bfb = radiation::is_position_inside( agent.origin );
            
            if ( agent.type == "zombie" )
            {
                if ( var_456fca0594399bfb )
                {
                    if ( !agent utility::ent_flag( "adz_active" ) )
                    {
                        agent utility::ent_flag_set( "adz_active" );
                    }
                }
                else if ( agent utility::ent_flag( "adz_active" ) )
                {
                    agent utility::ent_flag_clear( "adz_active" );
                }
            }
            else
            {
                if ( var_456fca0594399bfb && !agent utility::ent_flag( "adz_immune" ) )
                {
                    if ( !agent utility::ent_flag( "adz_active" ) )
                    {
                        agent utility::ent_flag_set( "adz_active" );
                        
                        if ( !isdefined( agent.var_93cc49af81199859 ) || gettime() - agent.var_93cc49af81199859 >= level.var_117f58399f256fb6.agent_damage_cooldown )
                        {
                            damage = ( agent.maxhealth ?? 100 ) * level.var_117f58399f256fb6.agent_damage_percent;
                            agent dodamage( int( damage ), agent.origin, undefined, undefined, "MOD_TRIGGER_HURT", level.radiation.damageweapon, "torso_upper" );
                            agent.var_93cc49af81199859 = gettime();
                        }
                    }
                }
                else if ( agent utility::ent_flag( "adz_active" ) )
                {
                    agent utility::ent_flag_clear( "adz_active" );
                }
                
                if ( isalive( agent ) && !agent.combatrushing && !agent utility::ent_flag( "adz_immune" ) )
                {
                    flee_point = agent.origin + 2000 * vectornormalize( agent.origin - self.origin );
                    var_2a669c0765836c0e = getclosestpointonnavmesh( flee_point );
                    
                    if ( lengthsquared( flee_point - var_2a669c0765836c0e ) < 1000000 )
                    {
                        thread ai_behavior::behavior_combatRushOrigin( agent, flee_point );
                    }
                }
            }
            
            var_dd77a4915a40fde6 += 1;
            
            if ( var_dd77a4915a40fde6 > 5 )
            {
                var_dd77a4915a40fde6 = 0;
                waitframe();
            }
        }
        
        var_dd77a4915a40fde6 = 0;
        wait 1;
    }
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0x7dcdec1b, Offset: 0x1453
// Size: 0x1ee
function private _equipment_update()
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    var_dd77a4915a40fde6 = 0;
    
    while ( function_75cf7cbba7a3a376() )
    {
        var_e3b5f9b5bbe75a4a = [[ level.getactiveequipmentarray ]]();
        ents = arraycombine( level.activekillstreaks, var_e3b5f9b5bbe75a4a, level.grenades, level.vehicle.all, level.cratedata.crates );
        ents = function_5713d46873b29625( ents );
        ents = arrayremoveduplicates( ents );
        
        foreach ( ent in ents )
        {
            if ( !isdefined( ent ) )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            if ( ent.exploding || ent.is_adz_deleting )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            if ( !isplayer( ent.owner ) )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            var_59c7953c6fd72dbb = radiation::is_position_inside( ent.origin );
            
            if ( !var_59c7953c6fd72dbb )
            {
                var_dd77a4915a40fde6 += 0.1;
                continue;
            }
            
            if ( ent isscriptable() )
            {
                if ( ent utility::ent_flag( "remote_sentry_deployed" ) || ent utility::ent_flag( "mini_sentry_deployed" ) )
                {
                    ent thread _ent_delete();
                }
            }
            else
            {
                ent thread _ent_delete();
            }
            
            var_dd77a4915a40fde6 += 1;
            
            if ( var_dd77a4915a40fde6 > 3 )
            {
                var_dd77a4915a40fde6 = 0;
                waitframe();
            }
        }
        
        var_dd77a4915a40fde6 = 0;
        wait 1;
    }
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xaa97757e, Offset: 0x1649
// Size: 0x1af
function private _ent_delete()
{
    self endon( #"death" );
    str_ent_name = _get_ent_name( self );
    
    if ( isdefined( str_ent_name ) )
    {
        if ( arraycontains( [ "equip_cluster_grenade_submunition", "equip_semtex", "equip_frag", "equip_emp", "equip_smoke" ], str_ent_name ) )
        {
            self detonate();
            return;
        }
        
        if ( arraycontains( [ "rcxd", "sniper_drone", "tank_drone", "ground_drone_unit" ], str_ent_name ) )
        {
            self dodamage( 999999, self.origin );
            return;
        }
        
        if ( isdefined( level.var_117f58399f256fb6.var_4f976f4af41f874a[ str_ent_name ] ) )
        {
            self thread [[ level.var_117f58399f256fb6.var_4f976f4af41f874a[ str_ent_name ] ]]();
        }
        
        return;
    }
    
    if ( !isdefined( level._effect[ "vfx_cradle_burst" ] ) )
    {
        self delete();
        return;
    }
    
    self.is_adz_deleting = 1;
    origin = self.origin;
    angles = self.angles;
    var_64250342fb4fe6a6 = utility::spawn_tag_origin();
    var_64250342fb4fe6a6.origin = origin;
    var_64250342fb4fe6a6.angles = angles;
    var_64250342fb4fe6a6 show();
    waitframe();
    playfxontag( utility::getfx( "vfx_cradle_burst" ), var_64250342fb4fe6a6, "tag_origin" );
    earthquake( 0.1, 0.2, origin, 200 );
    playrumbleonposition( "damage_light", origin );
    wait 0.1;
    var_64250342fb4fe6a6 delete();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ob_adz
// Params 1, eflags: 0x4
// Checksum 0xe6a0c4bb, Offset: 0x1800
// Size: 0x81
function private _get_ent_name( ent )
{
    if ( isdefined( ent.equipmentref ) )
    {
        return ent.equipmentref;
    }
    
    if ( isdefined( ent.streakname ) )
    {
        return ent.streakname;
    }
    
    if ( isdefined( ent.streakref ) )
    {
        return ent.streakref;
    }
    
    if ( isdefined( ent.superref ) )
    {
        return ent.superref;
    }
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0x3d7fe8b0, Offset: 0x188a
// Size: 0x3b
function private function_12dcfb1b7bf67d48()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.var_d2c5a5dd33a1ad9 )
    {
        return;
    }
    
    effect_slow::slow( "hoarfrost", 0.5, 99999999, undefined, &function_6f6422276a2c0b11, undefined, "cold" );
}

// Namespace ob_adz
// Params 2, eflags: 0x44 variadic
// Checksum 0xfeca23ef, Offset: 0x18cd
// Size: 0x15
function private function_6f6422276a2c0b11( ... )
{
    
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0x6162c274, Offset: 0x18eb
// Size: 0x18
function private function_e896c5feb734732e()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    thread effect_slow::function_80a4bd13b5ba303a( "hoarfrost" );
}

// Namespace ob_adz
// Params 1, eflags: 0x4
// Checksum 0xde40a530, Offset: 0x190b
// Size: 0x4d
function private function_287b4cc8aa1a8413( var_1d8712ee8243f426 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self.og_difficulty = zombie_utils::get_zombie_round_difficulty();
    var_d62a9469f84faa8c = int( max( 1, zombie_utils::get_zombie_round_difficulty() + var_1d8712ee8243f426 ) );
    zombie_utils::set_zombie_round_difficulty( var_d62a9469f84faa8c );
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0x6e11ba59, Offset: 0x1960
// Size: 0x39
function private function_5a68cab585653ffb()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.og_difficulty ) )
    {
        zombie_utils::set_zombie_round_difficulty( self.og_difficulty );
        return;
    }
    
    zombie_utils::set_zombie_round_difficulty( zombie_utils::get_zombie_round_difficulty() );
}

// Namespace ob_adz
// Params 1, eflags: 0x4
// Checksum 0x9af6a17e, Offset: 0x19a1
// Size: 0x5d
function private _on_zombie_damage( params )
{
    if ( utility::ent_flag( "adz_active" ) && isplayer( params.eattacker ) )
    {
        damage = level.var_117f58399f256fb6.zombie_damage_multiplier * params.idamage;
        return damage;
    }
    
    return -1;
}

// Namespace ob_adz
// Params 1, eflags: 0x4
// Checksum 0x953bfb18, Offset: 0x1a07
// Size: 0x5d
function private _on_agent_damage( params )
{
    if ( utility::ent_flag( "adz_active" ) && isplayer( params.eattacker ) )
    {
        damage = level.var_117f58399f256fb6.agent_damage_multiplier * params.idamage;
        return damage;
    }
    
    return -1;
}

// Namespace ob_adz
// Params 3
// Checksum 0xc8a0b6d2, Offset: 0x1a6d
// Size: 0xae
function function_a7b3d34062d74207( zone_id, follow_start, follow_speed )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    radiation.follow_ent = utility::spawn_script_origin( radiation.origin, ( 0, 0, 0 ) );
    
    if ( isdefined( follow_start ) )
    {
        if ( isvector( follow_start ) )
        {
            radiation.follow_ent.origin = follow_start;
        }
        else
        {
            radiation function_c541fee6c7df7a21( zone_id, follow_start );
        }
    }
    
    if ( !isdefined( follow_speed ) )
    {
        follow_speed = 50;
    }
    
    radiation function_df6ab5364e5f8fd7( zone_id, follow_speed );
    radiation thread _follow_ent_update();
}

// Namespace ob_adz
// Params 3
// Checksum 0x2584f5ea, Offset: 0x1b23
// Size: 0x68
function function_ef1d4ad50a8b1fcc( zone_id, var_af4ad8937404e772, move_speed )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !radiation function_5a0008e97a795c3f() )
    {
        return;
    }
    
    if ( isdefined( move_speed ) )
    {
        radiation function_df6ab5364e5f8fd7( zone_id, move_speed );
    }
    
    radiation.follow_ent.origin = var_af4ad8937404e772;
}

// Namespace ob_adz
// Params 4
// Checksum 0xe2f3401f, Offset: 0x1b93
// Size: 0xd1
function function_c541fee6c7df7a21( zone_id, follow_link, link_speed, destroy_on_death = 0 )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !radiation function_5a0008e97a795c3f() )
    {
        return;
    }
    
    if ( !isdefined( follow_link ) )
    {
        return;
    }
    
    radiation function_11b3eea4905aa6ba( zone_id );
    waitframe();
    radiation.follow_ent.origin = follow_link.origin;
    radiation.follow_ent linkto( follow_link, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( link_speed ) )
    {
        radiation function_df6ab5364e5f8fd7( zone_id, link_speed );
    }
    
    radiation thread function_6e3a6e67dd866a61( follow_link, destroy_on_death );
}

// Namespace ob_adz
// Params 1
// Checksum 0xaa6e6e30, Offset: 0x1c6c
// Size: 0x4f
function function_11b3eea4905aa6ba( zone_id )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !radiation function_5a0008e97a795c3f() )
    {
        return;
    }
    
    if ( radiation.follow_ent islinked() )
    {
        radiation.follow_ent unlink();
    }
}

// Namespace ob_adz
// Params 2
// Checksum 0x81b68688, Offset: 0x1cc3
// Size: 0x44
function function_df6ab5364e5f8fd7( zone_id, follow_speed )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !radiation function_5a0008e97a795c3f() )
    {
        return;
    }
    
    radiation.follow_speed = follow_speed;
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xae31f555, Offset: 0x1d0f
// Size: 0x8d
function private _follow_ent_update()
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed", #"stop_follow_ent" );
    
    while ( isdefined( self.follow_ent ) )
    {
        follow_duration = distance2d( self.follow_ent.origin, self.origin ) / self.follow_speed;
        thread function_f94c18166de9f51d( undefined, self.follow_ent.origin, undefined, follow_duration );
        wait 1;
    }
}

// Namespace ob_adz
// Params 1, eflags: 0x4
// Checksum 0xfba7cff6, Offset: 0x1da4
// Size: 0x54
function private function_c53bda643103f7e9( patrol_origin )
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed", #"stop_follow_ent" );
    
    while ( true )
    {
        if ( self.origin == patrol_origin )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"radiation_patrol_goal" );
}

// Namespace ob_adz
// Params 2, eflags: 0x4
// Checksum 0xa0b46a30, Offset: 0x1e00
// Size: 0x51
function private function_6e3a6e67dd866a61( follow_link, destroy_on_death )
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    follow_link waittill( #"death" );
    
    if ( destroy_on_death )
    {
        function_a5e080cd4acacc53();
        return;
    }
    
    function_11b3eea4905aa6ba();
}

// Namespace ob_adz
// Params 1
// Checksum 0x80dba13f, Offset: 0x1e59
// Size: 0x5e
function function_7ff054a3cef544cd( zone_id )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !radiation function_5a0008e97a795c3f() )
    {
        return;
    }
    
    radiation function_11b3eea4905aa6ba();
    radiation notify( #"stop_follow_ent" );
    radiation.follow_speed = undefined;
    radiation.follow_ent delete();
}

// Namespace ob_adz
// Params 1
// Checksum 0x76f863f8, Offset: 0x1ebf
// Size: 0x33, Type: bool
function function_5a0008e97a795c3f( zone_id )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( isdefined( radiation.follow_ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_adz
// Params 6
// Checksum 0xfbad2807, Offset: 0x1efb
// Size: 0xe6
function function_9cc438b428df537a( zone_id, patrol_start, var_74eb10e4c024e464, patrol_wait = 3, var_8cecdd3369405f2d, var_11b065e9e75a62c9 )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    radiation function_a7b3d34062d74207( zone_id );
    
    if ( !isdefined( var_74eb10e4c024e464 ) )
    {
        var_74eb10e4c024e464 = 50;
    }
    
    s_patrol_start = utility::getstruct( patrol_start, "targetname" );
    s_patrol_next = utility::getstruct( s_patrol_start.target, "targetname" );
    radiation thread function_e8c11c141b3d47f6( zone_id, s_patrol_next, var_74eb10e4c024e464, patrol_wait );
    
    if ( isdefined( var_8cecdd3369405f2d ) )
    {
        if ( var_8cecdd3369405f2d == "pursuit" )
        {
            radiation thread function_99de57084ebd78a4( zone_id, var_11b065e9e75a62c9 );
            return;
        }
        
        if ( var_8cecdd3369405f2d == "pause" )
        {
            radiation thread function_90f3374b80135150( zone_id, var_11b065e9e75a62c9 );
        }
    }
}

// Namespace ob_adz
// Params 4
// Checksum 0x899116ed, Offset: 0x1fe9
// Size: 0x127
function function_e8c11c141b3d47f6( zone_id, patrol_struct, var_74eb10e4c024e464, patrol_wait )
{
    self notify( #"hash_d48172e85813667b" );
    self endon( #"hash_d48172e85813667b" );
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed", #"stop_patrol" );
    self.zone_patrol = 1;
    self.patrol_struct = patrol_struct;
    self.patrol_wait = patrol_wait;
    self.var_74eb10e4c024e464 = var_74eb10e4c024e464;
    
    while ( isdefined( self.patrol_struct ) )
    {
        function_ef1d4ad50a8b1fcc( zone_id, self.patrol_struct.origin, self.var_74eb10e4c024e464 );
        thread function_c53bda643103f7e9( self.patrol_struct.origin );
        self waittill( #"radiation_patrol_goal" );
        
        if ( self.patrol_wait > 0 )
        {
            wait self.patrol_wait;
        }
        
        self.patrol_struct = utility::getstruct( self.patrol_struct.target, "targetname" );
    }
}

// Namespace ob_adz
// Params 2
// Checksum 0xcfa5e3ad, Offset: 0x2118
// Size: 0x118
function function_99de57084ebd78a4( zone_id, pursuit_speed )
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    pursuit_player = undefined;
    self.zone_pursuit = undefined;
    
    if ( !isdefined( pursuit_speed ) )
    {
        pursuit_speed = 50;
    }
    
    while ( true )
    {
        if ( self.zone_players.size > 0 )
        {
            if ( self.zone_patrol )
            {
                self notify( #"stop_patrol" );
                self.zone_patrol = undefined;
                self.zone_pursuit = 1;
            }
            
            if ( !isdefined( pursuit_player ) || !arraycontains( self.zone_players, pursuit_player ) )
            {
                pursuit_player = utility::array_random( self.zone_players );
                function_c541fee6c7df7a21( zone_id, pursuit_player, pursuit_speed );
            }
        }
        else if ( self.zone_pursuit )
        {
            function_11b3eea4905aa6ba( zone_id );
            pursuit_player = undefined;
            waitframe();
            thread function_e8c11c141b3d47f6( zone_id, self.patrol_struct, self.var_74eb10e4c024e464, self.patrol_wait );
            self.zone_pursuit = undefined;
        }
        
        wait 1;
    }
}

// Namespace ob_adz
// Params 2
// Checksum 0xa15026a0, Offset: 0x2238
// Size: 0x10c
function function_90f3374b80135150( zone_id, pause_wait = 3 )
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    self.zone_pause = undefined;
    var_c9cdccc7439284d9 = utility::function_4b74c15943231980( pause_wait );
    
    while ( true )
    {
        if ( self.zone_players.size > 0 )
        {
            if ( self.zone_patrol )
            {
                self notify( #"stop_patrol" );
                self.zone_patrol = undefined;
                self.zone_pause = 1;
                waitframe();
                function_ef1d4ad50a8b1fcc( zone_id, self.origin );
            }
            
            pause_start_ms = gettime();
        }
        else if ( self.zone_pause && gettime() > pause_start_ms + var_c9cdccc7439284d9 )
        {
            thread function_e8c11c141b3d47f6( zone_id, self.patrol_struct, self.var_74eb10e4c024e464, self.patrol_wait );
            self.zone_pause = undefined;
        }
        
        wait 1;
    }
}

// Namespace ob_adz
// Params 3
// Checksum 0x8f689a93, Offset: 0x234c
// Size: 0x7f
function function_27eacaca0a6b29fd( zone_id, investigate_radius, investigate_delay = 3 )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    
    if ( !isdefined( investigate_radius ) )
    {
        investigate_radius = radiation.radius;
    }
    
    radiation.investigate_radius = investigate_radius;
    radiation.investigate_delay = investigate_delay;
    radiation callback::add( "player_entered_radiation", &function_b3284bdfdf60ec92 );
}

// Namespace ob_adz
// Params 1
// Checksum 0x373b554a, Offset: 0x23d3
// Size: 0x31
function function_95a627e587f1d1cf( zone_id )
{
    radiation = function_4b41c5c58f1cce95( zone_id );
    callback::remove( "player_entered_radiation", &function_b3284bdfdf60ec92 );
}

// Namespace ob_adz
// Params 1
// Checksum 0x2cbeb437, Offset: 0x240c
// Size: 0x32
function function_b3284bdfdf60ec92( params )
{
    player = params.player;
    
    if ( isdefined( player ) )
    {
        thread function_e7d794aa31371437( player );
    }
}

// Namespace ob_adz
// Params 1
// Checksum 0xaeaad521, Offset: 0x2446
// Size: 0xa5
function function_e7d794aa31371437( player )
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    player endon( #"death", #"player_exited_radiation" );
    var_8b7792eab934cb8e = squared( 512 );
    
    while ( true )
    {
        v_investigate = getclosestpointonnavmesh( player.origin );
        
        if ( distancesquared( player.origin, v_investigate ) < var_8b7792eab934cb8e )
        {
            stealtheventbroadcastsimple( "investigate", player, v_investigate, self.investigate_radius );
        }
        
        wait self.investigate_delay;
    }
}

// Namespace ob_adz
// Params 0
// Checksum 0xc642e1a3, Offset: 0x24f3
// Size: 0x14d
function function_4039668d9e2ee8dd()
{
    level.var_117f58399f256fb6.var_4f976f4af41f874a = [];
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_c4" ] = &function_169f109de17fcc4b;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_molotov" ] = &_destroy_molotov;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_combataxe" ] = &_destroy_combataxe;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_cluster_grenade" ] = &_destroy_cluster_grenade;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_mini_sentry" ] = &mini_sentry::on_destruction;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_decoy" ] = &decoy_grenade::_destroy;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_sensor_grenade" ] = &sensor_grenade::destroy_sensor_grenade;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "equip_drone_launcher" ] = &_destroy_drone_launcher;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "super_drone_launcher" ] = &function_b4ddf915345d231e;
    level.var_117f58399f256fb6.var_4f976f4af41f874a[ "remote_turret" ] = &_destroy_remote_turret;
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xe739004e, Offset: 0x2648
// Size: 0x30
function private function_169f109de17fcc4b()
{
    if ( isdefined( self.var_95bfba95499bb5ee ) && self.var_95bfba95499bb5ee )
    {
        c4::c4_delete( 0, 0 );
        return;
    }
    
    c4::c4_explode( self );
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xf3af645f, Offset: 0x2680
// Size: 0x9
function private _destroy_molotov()
{
    molotov::molotov_burn_destroy();
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xd4776984, Offset: 0x2691
// Size: 0xe
function private _destroy_cluster_grenade()
{
    self stopsounds();
    self detonate();
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xd57ca05f, Offset: 0x26a7
// Size: 0x1b
function private _destroy_combataxe()
{
    level endon( #"game_ended" );
    wait 0.1;
    combataxe::deletepickup();
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xbcd65121, Offset: 0x26ca
// Size: 0xb
function private _destroy_drone_launcher()
{
    drone_launcher::destroy_launcher( undefined, 0 );
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0x2ddc5ec7, Offset: 0x26dd
// Size: 0xc
function private function_b4ddf915345d231e()
{
    drone_launcher::destroy_drone( undefined, 1 );
}

// Namespace ob_adz
// Params 0, eflags: 0x4
// Checksum 0xdbfae81, Offset: 0x26f1
// Size: 0x15
function private _destroy_remote_turret()
{
    self notify( #"kill_turret", 1, 1, 0, 1 );
}

