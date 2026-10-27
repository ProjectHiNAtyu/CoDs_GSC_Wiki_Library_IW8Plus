// scripts\mp\zm\systems\time_travel.gsc  (hash_1da5e5086386a243.gscc) (size: 16321 Bytes / 0x3fc1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x265ba721 (643540769)
// size ...... 16321 (0x3fc1)
// includes .. 11  (offset: 0x3d49)
// strings ... 36  (offset: 0x3da1)
// dev strs .. 1   (offset: 0x3fb5)
// exports ... 44  (offset: 0x25d5)
// cseg ...... 0x2b4 + 0x2321 (0x25d5)
// imports ... 140 (offset: 0x2cb5)
// animtree1 . 0   (offset: 0x3fc1)
// animtree2 . 0   (offset: 0x3fc1)
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace time_travel;

// Namespace time_travel
// Params 0, eflags: 0x5
// Checksum 0x8ca8da6f, Offset: 0x2d2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"sat_timetravel", undefined, undefined, &init );
}

// Namespace time_travel
// Params 0
// Checksum 0x99652eb8, Offset: 0x2f3
// Size: 0x457
function init()
{
    map_info_bundle = getactivemapinfobundle();
    timetravel_data = map_info_bundle.timetravel;
    
    if ( !map_info_bundle.timetravelenabled || level.timetravel_disabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"sat_timetravel", #"enable", &enable );
    utility::registersharedfunc( #"sat_timetravel", #"disable", &disable );
    utility::registersharedfunc( #"sat_timetravel", #"timetravel", &timetravel );
    callback::add( #"player_spawned", &on_player_spawn );
    callback::add( #"player_death", &on_player_death );
    level.timetravel = { #var_d7164c9e89c397d4:!getdvarint( @"hash_85377a3aaf03d7c", 0 ), #timetravel_entities:[], #data:{ #bad_place_data:timetravel_data.badplacesettings, #check_bad_place:timetravel_data.checkbadplace, #slowmo_factor:timetravel_data.slowmofactor, #var_7ee8ab88af0a9fc0:timetravel_data.var_68ddf7bb32df8398, #var_c490a0705bbacaa5:timetravel_data.var_149cb2aad2ab4721, #var_3da5f45db86c5d0d:timetravel_data.auravfx, #time_travel_vfx:timetravel_data.timetravelvfx, #warm_up_vfx:timetravel_data.var_498fefd7c2aecc86, #total_duration:timetravel_data.var_118ce4e5b8a79d72 + timetravel_data.timetravelduration + timetravel_data.timetravelduration / 2 * timetravel_data.slowmofactor + 1, #timetravel_duration:timetravel_data.timetravelduration, #warm_up_duration:timetravel_data.var_118ce4e5b8a79d72 }, #timelines:[], #enabled:1 };
    
    if ( level.timetravel.data.check_bad_place )
    {
        level.var_1a7d5de49b6970b1 = 1;
    }
    
    if ( timetravel_data.timewarppowerups )
    {
        powerups::register_powerup_dropped_callback( &register_timetravel_entity );
    }
    
    timeline_nodes = utility::getstructarray( "timeline", "targetname" );
    
    for ( i = 0; i < timeline_nodes.size ; i++ )
    {
        timeline_node = timeline_nodes[ i ];
        timeline_data = {};
        timeline_data.name = timeline_node.script_noteworthy;
        timeline_data.origin = timeline_node.origin;
        level.timetravel.timelines[ i ] = timeline_data;
    }
    
    level.timetravel.timeline = level.timetravel.timelines[ 0 ];
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        zm_save::function_1f44a48caae2acbf();
        saved_timeline = utility::callsharedfunc( #"zombie", #"get_saved_timeline" ) ?? "";
        level.timetravel.timeline = function_5ea459e5e03d5e3e( saved_timeline ) ?? level.timetravel.timeline;
    }
    
    setup_vfx();
    init_dev_commands();
    register_events( timetravel_data.var_69c24d1e1e80f8c7, &enable );
    register_events( timetravel_data.var_4ef09e95bd65a1f2, &disable );
    utility::flag_set( "timetravel_system_ready" );
    var_f0044768b5dc8778 = getdvar( @"hash_614c73605c999a65", timetravel_data.var_2d084b0d82825900 );
    var_a566634dda7aa664 = getdvarfloat( @"hash_2185a348d3e2a74b", timetravel_data.var_acfa65726c20c7dc );
    
    if ( isdefined( var_f0044768b5dc8778 ) )
    {
        if ( isdefined( timetravel_data.var_b4c592cb31cbacf1 ) )
        {
            level waittill( timetravel_data.var_b4c592cb31cbacf1 );
        }
        
        enable();
        level callback::add( var_f0044768b5dc8778, &timetravel, { #delay:var_a566634dda7aa664 } );
    }
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x7d7ccbd4, Offset: 0x752
// Size: 0xee
function private on_player_spawn( params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::flag_wait( "timetravel_system_ready" );
    
    if ( !isdefined( self.timetravel ) )
    {
        self.timetravel = {};
    }
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = self playergetzoomfov();
    }
    
    if ( level.timetravel.data.check_bad_place )
    {
        thread function_e806113b056ebb96();
    }
    
    if ( utility::flag( "timetravel_ongoing" ) && !self.is_timetraveling )
    {
        level waittill( #"timetravel_done" );
    }
    
    if ( isdefined( self ) && function_aabe6993e4bc263d() != level.timetravel.timeline )
    {
        thread function_3722cb7433cd3b44( level.timetravel.timeline, {} );
    }
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x1579bbdb, Offset: 0x848
// Size: 0x1d
function private on_player_death( params )
{
    utility::function_32b24db3127bff40( "timetravel_fx", "off" );
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x39d7f0ce, Offset: 0x86d
// Size: 0x76
function private setup_vfx()
{
    level._effect[ #"timetravel_aura" ] = loadfxasset( level.timetravel.data.var_3da5f45db86c5d0d );
    level._effect[ #"hash_ba98c57b39719d73" ] = loadfxasset( level.timetravel.data.bad_place_data.respawnvfx );
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0xbb3a3ab0, Offset: 0x8eb
// Size: 0x99
function private register_events( events, func )
{
    if ( isdefined( events ) )
    {
        foreach ( event in events )
        {
            level callback::add( event.id, func );
        }
    }
}

// Namespace time_travel
// Params 2
// Checksum 0x380356fc, Offset: 0x98c
// Size: 0x141
function timetravel( var_b19ce51dfc12b7f8, params )
{
    self notify( #"hash_f71b765bdf54a214" );
    self endon( #"hash_f71b765bdf54a214" );
    
    if ( !level.timetravel.enabled )
    {
        return;
    }
    
    utility::flag_set( "timetravel_ongoing" );
    
    if ( isdefined( params.delay ) )
    {
        level utility::waittill_notify_or_timeout( "timetravel_abort_delay", params.delay );
    }
    
    function_994e32e90cc2ff71();
    next_timeline = get_next_timeline();
    level callback::callback( "pre_timetravel_done", params );
    level notify( #"pre_timetravel_done", next_timeline );
    warp_all_players( next_timeline, params );
    function_c0f0bfb304158b12( next_timeline, params );
    wait level.timetravel.data.total_duration;
    level.timetravel.timeline = next_timeline;
    utility::flag_clear( "timetravel_ongoing" );
    function_1d3829d6fef4d65c();
    level callback::callback( "timetravel_done", params );
    level notify( #"timetravel_done", level.timetravel.timeline.name );
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0x475575a7, Offset: 0xad5
// Size: 0xb3
function private warp_all_players( timeline, params )
{
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "playing" && player.hasspawned )
        {
            player thread function_3722cb7433cd3b44( timeline, params );
        }
    }
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0x605b1321, Offset: 0xb90
// Size: 0x89
function private function_3722cb7433cd3b44( timeline, params )
{
    if ( self.is_timetraveling )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_1fea1afdcad724b();
    self.is_timetraveling = 1;
    warm_up( timeline );
    travel( timeline );
    function_e824f7e5d185e530();
    self.is_timetraveling = 0;
    callback::callback( "timetravel_player_done", params );
    self notify( #"timetravel_player_done" );
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xa2caadf7, Offset: 0xc21
// Size: 0xb5
function private warm_up( next_timeline )
{
    current_timeline = function_aabe6993e4bc263d();
    timetravel_offset = next_timeline.origin - current_timeline.origin;
    warm_up_duration = level.timetravel.data.warm_up_duration;
    self setadditionalstreamposuntilcleared( self.origin + timetravel_offset, 3 );
    hintfx( utility::getfx( #"timetravel_aura" ), self.origin, int( warm_up_duration ) * 1000 );
    utility::function_32b24db3127bff40( "timetravel_fx", "warm_up" );
    wait warm_up_duration;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xfb9e4079, Offset: 0xcde
// Size: 0x236
function private travel( next_timeline )
{
    current_timeline = function_aabe6993e4bc263d();
    timetravel_duration = level.timetravel.data.timetravel_duration;
    var_40036e577105db91 = timetravel_duration / 2;
    slowmo_factor = level.timetravel.data.slowmo_factor;
    var_c490a0705bbacaa5 = level.timetravel.data.var_c490a0705bbacaa5;
    var_7ee8ab88af0a9fc0 = level.timetravel.data.var_7ee8ab88af0a9fc0;
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    thread slow_motion( slowmo_factor, timetravel_duration );
    self modifybasefov( self.defaultbasefov * var_c490a0705bbacaa5, var_40036e577105db91 );
    utility::function_32b24db3127bff40( "timetravel_fx", "timetravel" );
    wait var_40036e577105db91;
    self modifybasefov( self.defaultbasefov * var_7ee8ab88af0a9fc0, var_40036e577105db91 );
    wait var_40036e577105db91;
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    if ( self.sessionstate != "playing" )
    {
        return;
    }
    
    timeline_offset = self.origin - current_timeline.origin;
    dest_position = next_timeline.origin + timeline_offset;
    dest_position = function_d4fffecdd4b3331a( dest_position );
    
    while ( distancesquared( self.origin, dest_position ) > 1000 )
    {
        self setorigin( dest_position );
        waitframe();
    }
    
    playfx( utility::getfx( #"timetravel_aura" ), dest_position );
    self modifybasefov( self.defaultbasefov, timetravel_duration );
    utility::function_32b24db3127bff40( "timetravel_fx", "off" );
    self clearadditionalstreampos();
    
    if ( !function_cfdb3554fcf6261d() )
    {
        if ( level.timetravel.data.check_bad_place )
        {
            waitframe();
            check_bad_place();
            return;
        }
        
        unlock_zone( dest_position );
    }
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0xe8c017a, Offset: 0xf1c
// Size: 0x9a
function private slow_motion( factor, duration )
{
    level endon( #"game_ended" );
    
    if ( !level.timetravel.var_d7164c9e89c397d4 || level.timetravel.var_aab45770c18b020 )
    {
        return;
    }
    
    level.timetravel.var_aab45770c18b020 = 1;
    setslowmotion( 1, factor, duration / 2 );
    wait duration;
    setslowmotion( factor, 1, duration / 2 );
    level.timetravel.var_aab45770c18b020 = 0;
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0xf3254890, Offset: 0xfbe
// Size: 0xe2
function private function_c0f0bfb304158b12( timeline, params )
{
    foreach ( entity in level.timetravel.timetravel_entities )
    {
        if ( !isdefined( entity ) || !isdefined( entity.timetravel ) )
        {
            level.timetravel.timetravel_entities = arrayremove( level.timetravel.timetravel_entities, entity );
            continue;
        }
        
        entity thread warp_entity( timeline, params );
    }
}

// Namespace time_travel
// Params 2, eflags: 0x4
// Checksum 0x379ada61, Offset: 0x10a8
// Size: 0x103
function private warp_entity( timeline, params )
{
    if ( self.is_timetraveling )
    {
        return;
    }
    
    self.is_timetraveling = 1;
    current_timeline = function_aabe6993e4bc263d();
    timetravel_offset = timeline.origin - current_timeline.origin;
    timetravel_duration = level.timetravel.data.warm_up_duration + level.timetravel.data.timetravel_duration;
    wait timetravel_duration;
    
    if ( !isdefined( self ) || !isdefined( self.timetravel ) )
    {
        return;
    }
    
    dest_position = self.origin + timetravel_offset;
    self.origin = dest_position;
    self.is_timetraveling = 0;
    callback::callback( "timetravel_entity_done", params );
    self notify( #"timetravel_entity_done" );
}

// Namespace time_travel
// Params 1
// Checksum 0xe1dea00d, Offset: 0x11b3
// Size: 0xe2
function function_b981ae62bbb5502f( var_ebb239619e603dcf )
{
    self.is_timetraveling = 1;
    current_timeline = function_aabe6993e4bc263d();
    target_timeline = function_5ea459e5e03d5e3e( var_ebb239619e603dcf );
    timetravel_offset = target_timeline.origin - current_timeline.origin;
    timetravel_duration = level.timetravel.data.warm_up_duration + level.timetravel.data.timetravel_duration;
    wait timetravel_duration;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    dest_position = self.origin + timetravel_offset;
    self.origin = dest_position;
    self.is_timetraveling = 0;
    self notify( #"timetravel_entity_done" );
}

// Namespace time_travel
// Params 1
// Checksum 0x2cfcb2f1, Offset: 0x129d
// Size: 0x9a
function function_5ea459e5e03d5e3e( var_ebb239619e603dcf )
{
    foreach ( timeline in level.timetravel.timelines )
    {
        if ( timeline.name == var_ebb239619e603dcf )
        {
            return timeline;
        }
    }
}

// Namespace time_travel
// Params 0
// Checksum 0x48224192, Offset: 0x1340
// Size: 0x15
function get_current_timeline()
{
    return level.timetravel.timeline;
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x6b67eade, Offset: 0x135e
// Size: 0x22
function private function_aabe6993e4bc263d()
{
    return function_b21056d585c710d( level.timetravel.timelines, self.origin );
}

// Namespace time_travel
// Params 0
// Checksum 0xf0766681, Offset: 0x1389
// Size: 0xa3
function get_next_timeline()
{
    for ( i = 0; i < level.timetravel.timelines.size ; i++ )
    {
        if ( level.timetravel.timelines[ i ] == level.timetravel.timeline )
        {
            var_65b3b3bdd6cf0f10 = i + 1 >= level.timetravel.timelines.size ? 0 : i + 1;
            return level.timetravel.timelines[ var_65b3b3bdd6cf0f10 ];
        }
    }
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x53790591, Offset: 0x1434
// Size: 0xc0
function private function_d4fffecdd4b3331a( dest_position )
{
    var_9142ba986e0b2e36 = dest_position;
    
    if ( !ispointonnavmesh( var_9142ba986e0b2e36, self, 1 ) )
    {
        var_9142ba986e0b2e36 = getclosestpointonnavmesh( var_9142ba986e0b2e36 );
        relocation_vector = vectornormalize2( var_9142ba986e0b2e36 - dest_position );
        function_f8c6f648b7457dc1( var_9142ba986e0b2e36 );
        
        for ( i = 5; i > 0 ; i-- )
        {
            if ( ispointonnavmesh( var_9142ba986e0b2e36, self, 1 ) && zone_manager::function_90e5c3e2272b0130( var_9142ba986e0b2e36 ) && function_11015e8a0fdc6f73( var_9142ba986e0b2e36 ) )
            {
                return var_9142ba986e0b2e36;
            }
            
            var_9142ba986e0b2e36 += relocation_vector * 100;
            var_9142ba986e0b2e36 = getclosestpointonnavmesh( var_9142ba986e0b2e36 );
            waitframe();
        }
        
        var_9142ba986e0b2e36 = function_9636b4740d24ceb3( dest_position ).origin + ( 0, 0, 50 );
    }
    
    return var_9142ba986e0b2e36;
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x6eb3f010, Offset: 0x14fd
// Size: 0x48, Type: bool
function private function_cfdb3554fcf6261d()
{
    if ( isdefined( level.zone_manager ) && !namespace_af5a2e4a7277c1d::function_83f76a6615ec6637() && ( !namespace_af5a2e4a7277c1d::function_eebc26d3ebcc3852() || namespace_af5a2e4a7277c1d::function_cb6f435613626945() ) && !namespace_af5a2e4a7277c1d::function_8a01a51e9195d1e8() || function_216bcfe1137cf85() )
    {
        return false;
    }
    
    return true;
}

// Namespace time_travel
// Params 5
// Checksum 0x71807e7f, Offset: 0x154e
// Size: 0x145
function function_ff2da1e34e2b4e1a( bounds_key, origin, x_corner, y_corner, z_corner )
{
    bad_place_data = level.timetravel.data.bad_place_data;
    axis_x = vectornormalize( x_corner - origin );
    axis_y = vectornormalize( y_corner - origin );
    axis_z = vectornormalize( z_corner - origin );
    width = distance( origin, x_corner );
    length = distance( origin, y_corner );
    height = distance( origin, z_corner );
    bounds = { #height:height, #length:length, #width:width, #axis_z:axis_z, #axis_y:axis_y, #axis_x:axis_x, #origin:origin };
    
    if ( !isdefined( bad_place_data.exclusion_bounds ) )
    {
        bad_place_data.exclusion_bounds = [];
    }
    
    bad_place_data.exclusion_bounds[ bounds_key ] = bounds;
}

// Namespace time_travel
// Params 1
// Checksum 0xaae952e7, Offset: 0x169b
// Size: 0x63
function function_4350005d1d5c2a0f( bounds_key )
{
    bad_place_data = level.timetravel.data.bad_place_data;
    
    if ( bad_place_data.exclusion_bounds && bad_place_data.exclusion_bounds[ bounds_key ] )
    {
        bad_place_data.exclusion_bounds[ bounds_key ] = undefined;
    }
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x41f3a9ae, Offset: 0x1706
// Size: 0x170, Type: bool
function private function_216bcfe1137cf85()
{
    exclusion_bounds = level.timetravel.data.bad_place_data.exclusion_bounds;
    
    if ( !isdefined( exclusion_bounds ) )
    {
        return false;
    }
    
    foreach ( bounds in exclusion_bounds )
    {
        if ( !isdefined( bounds ) )
        {
            continue;
        }
        
        relative_pos = self.origin - bounds.origin;
        local_x = vectordot( relative_pos, bounds.axis_x );
        local_y = vectordot( relative_pos, bounds.axis_y );
        local_z = vectordot( relative_pos, bounds.axis_z );
        
        if ( local_x >= 0 && local_x <= bounds.width && local_y >= 0 && local_y <= bounds.length && local_z >= 0 && local_z <= bounds.height )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xfc664662, Offset: 0x187f
// Size: 0xa0, Type: bool
function private function_11015e8a0fdc6f73( position )
{
    player_capsule = self getcollision( "stand" );
    player_radius = player_capsule.capsule_radius;
    player_height = player_capsule.capsule_halfheight + player_capsule.capsule_midpoint_height + player_capsule.capsule_radius - 5;
    trace = trace::capsule_get_closest_point( position + ( 0, 0, 5 ), player_radius, player_height, undefined, 0, self );
    
    if ( trace[ "hittype" ] == "hittype_none" )
    {
        return true;
    }
    
    return false;
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x44fd3ce5, Offset: 0x1928
// Size: 0x107
function private function_e806113b056ebb96()
{
    self endon( #"disconnect" );
    bad_place_data = level.timetravel.data.bad_place_data;
    
    if ( !isdefined( bad_place_data.var_fa21e11f8ef09d42 ) )
    {
        bad_place_data.var_fa21e11f8ef09d42 = 0.5;
    }
    
    while ( true )
    {
        wait bad_place_data.var_fa21e11f8ef09d42;
        bad_place_data.var_fa21e11f8ef09d42 = clamp( bad_place_data.var_fa21e11f8ef09d42 + 0.5, 0.5, 3 );
        
        if ( self.b_ignore_playable_area_check || val::get( "ignore_playable_area_check" ) || !isalive( self ) || self.sessionstate == "spectator" || self.sessionstate == "playing_but_spectating" || self function_e7d19d7e4403c48() || self.var_3e117ace01f16233 )
        {
            continue;
        }
        
        if ( !function_cfdb3554fcf6261d() )
        {
            check_bad_place();
        }
    }
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0xbdaf2add, Offset: 0x1a37
// Size: 0x155
function private check_bad_place()
{
    if ( self.var_3e117ace01f16233 || self isufo() || self isnoclip() )
    {
        return;
    }
    
    bad_place_data = level.timetravel.data.bad_place_data;
    
    if ( function_f8c6f648b7457dc1( self.origin ) )
    {
        return;
    }
    
    self.var_3e117ace01f16233 = 1;
    self allowreload( 0 );
    
    if ( isdefined( bad_place_data.sfxambience ) )
    {
        self playsoundtoplayer( bad_place_data.sfxambience, self );
    }
    
    if ( isdefined( bad_place_data.pbgeffect ) )
    {
        pbgpostfxbundlestart( self, bad_place_data.pbgeffect, 5 );
    }
    
    var_bd5ca1ddd65a1392 = 1;
    i = 0;
    
    while ( i < bad_place_data.var_b76f058988457e1d )
    {
        if ( function_cfdb3554fcf6261d() )
        {
            var_bd5ca1ddd65a1392 = 0;
            break;
        }
        
        wait 0.1;
        i += 0.1;
    }
    
    if ( var_bd5ca1ddd65a1392 )
    {
        get_player_out_of_bad_place( bad_place_data );
    }
    
    self.var_3e117ace01f16233 = 0;
    self allowreload( 1 );
    self stopsounds();
    
    if ( isdefined( bad_place_data.pbgeffect ) )
    {
        pbgpostfxbundleend( self, bad_place_data.pbgeffect, 10 );
    }
    
    bad_place_data.var_fa21e11f8ef09d42 = 0.5;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xff87ad6f, Offset: 0x1b94
// Size: 0x81, Type: bool
function private function_f8c6f648b7457dc1( position )
{
    excluded_zones = strtok( level.timetravel.data.bad_place_data.var_5216a4d131aa6687, "," );
    zone = zone_manager::function_90e5c3e2272b0130( position );
    
    if ( zone && arraycontains( excluded_zones, zone.zone_name ) )
    {
        unlock_zone( position );
        return true;
    }
    
    return false;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x223d4d60, Offset: 0x1c1e
// Size: 0x171
function private get_player_out_of_bad_place( bad_place_data )
{
    if ( self.sessionstate != "playing" || !self.hasspawned )
    {
        return;
    }
    
    dest_spawn_point = function_9636b4740d24ceb3( self.origin );
    function_a4efdbf05ae19239( 0 );
    self.doorbuy_disabled = 1;
    
    if ( isnullweapon( self gethighpriorityweapon() ) && !weapon::isakimbo( self getcurrentweapon() ) && !self function_5616aa6e4686fae5() && !self getcurrentweapon().ismelee )
    {
        self playviewmodelanim( removesubstr( bad_place_data.viewmodelanimation.name, "@sbundle" ), 1 );
    }
    
    self playsoundtoplayer( bad_place_data.sfxteleport, self );
    utility::function_32b24db3127bff40( "timetravel_fx", "bad_place" );
    wait bad_place_data.teleportduration;
    pbgpostfxbundleend( self, bad_place_data.pbgeffect, 5 );
    playfx( utility::getfx( #"hash_ba98c57b39719d73" ), dest_spawn_point.origin );
    utility::function_32b24db3127bff40( "timetravel_fx", "off" );
    self setorigin( dest_spawn_point.origin + ( 0, 0, bad_place_data.var_138aa49995535171 ) );
    self setplayerangles( dest_spawn_point.angles );
    function_a4efdbf05ae19239( 1 );
    self.doorbuy_disabled = 0;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x868c9c33, Offset: 0x1d97
// Size: 0x43
function private function_9636b4740d24ceb3( origin )
{
    enabled_zones = zone_manager::get_enabled_zones();
    target_zone = function_47c86977a18df38b( enabled_zones, origin );
    selected_spawn_point = function_4c03c68b9f8fe408( target_zone );
    return selected_spawn_point;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x6415129d, Offset: 0x1de3
// Size: 0x176
function private function_4c03c68b9f8fe408( target_zone )
{
    target_zone = isstring( target_zone ) ? target_zone : target_zone.zone_name;
    spawn_points = zone_manager::function_9dd25e9fb0ecd45b( target_zone );
    
    if ( !spawn_points || spawn_points.size == 0 )
    {
        spawn_points = [ zone_manager::function_aeaa8dd788ed9b16( undefined, 1 ) ];
    }
    
    spawn_points = arrayrandomize( spawn_points );
    
    foreach ( spawn_point in spawn_points )
    {
        var_f448a26cf56f4a2a = spawn_point.var_f448a26cf56f4a2a;
        
        if ( var_f448a26cf56f4a2a.size == 0 )
        {
            continue;
        }
        
        foreach ( spawn_location in var_f448a26cf56f4a2a )
        {
            if ( spawn_location.is_on_cooldown )
            {
                continue;
            }
            
            spawn_location thread set_spawn_location_on_cooldown();
            return spawn_location;
        }
    }
    
    return spawn_points[ randomint( spawn_points.size ) ];
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x894f2395, Offset: 0x1f62
// Size: 0x1a
function private set_spawn_location_on_cooldown()
{
    self.is_on_cooldown = 1;
    wait 2;
    self.is_on_cooldown = 0;
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xd87a45d1, Offset: 0x1f84
// Size: 0x82
function private function_a4efdbf05ae19239( enable )
{
    self allowmovement( enable );
    self allowfire( enable );
    self allowads( enable );
    
    if ( enable )
    {
        val::reset( #"sat_timetravel", "weapon_switch" );
        val::reset( #"sat_timetravel", "weapon_first_raise_anims" );
        return;
    }
    
    val::set( #"sat_timetravel", "weapon_switch", 0 );
    val::set( #"sat_timetravel", "weapon_first_raise_anims", 0 );
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x37b5d663, Offset: 0x200e
// Size: 0x4e
function private unlock_zone( dest_position )
{
    if ( isdefined( level.zone_manager ) && !zone_manager::function_65305a611c6226d9( dest_position ) )
    {
        dest_zone = zone_manager::function_90e5c3e2272b0130( dest_position );
        zone_manager::set_zone_enabled( dest_zone.script_zone_name, 1 );
    }
}

// Namespace time_travel
// Params 1
// Checksum 0xb95302f6, Offset: 0x2064
// Size: 0xe9
function register_timetravel_entity( entity )
{
    utility::flag_wait( "timetravel_system_ready" );
    entity.timetravel = { #timeline:function_b21056d585c710d( level.timetravel.timelines, entity.origin ) };
    level.timetravel.timetravel_entities[ level.timetravel.timetravel_entities.size ] = entity;
    
    if ( utility::flag( "timetravel_ongoing" ) && !entity.is_timetraveling )
    {
        level waittill( #"timetravel_done" );
    }
    
    if ( isdefined( entity ) && entity function_aabe6993e4bc263d() != level.timetravel.timeline )
    {
        entity warp_entity( level.timetravel.timeline, {} );
    }
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xf6454bcb, Offset: 0x2155
// Size: 0x30
function private enable( params )
{
    level.timetravel.enabled = 1;
    callback::callback( "timetravel_enabled", params );
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0xb3e2cf57, Offset: 0x218d
// Size: 0x2f
function private disable( params )
{
    level.timetravel.enabled = 0;
    callback::callback( "timetravel_disabled", params );
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0xab187676, Offset: 0x21c4
// Size: 0x18
function private function_1d3829d6fef4d65c()
{
    level val::reset( #"sat_timetravel", "allow_exfil" );
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0xf0e2c82d, Offset: 0x21e4
// Size: 0x33
function private function_994e32e90cc2ff71()
{
    level val::set( #"sat_timetravel", "allow_exfil", 0 );
    level utility::callsharedfunc( #"zombie", #"abort_magicbox" );
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x7ee3f22e, Offset: 0x221f
// Size: 0xa6
function private function_e824f7e5d185e530()
{
    val::reset( #"sat_timetravel", "allow_teleport" );
    val::reset( #"sat_timetravel", "disallow_magicbox" );
    val::reset( #"sat_timetravel", "mount_side" );
    val::reset( #"sat_timetravel", "mount_top" );
    val::reset( #"sat_timetravel", "allow_ping" );
    val::reset( #"sat_timetravel", "killstreaks" );
    val::reset( #"sat_timetravel", "mantle" );
    calloutmarkerping::function_5a33bcee47519dd6();
    self.var_2314a9263fbe04b9 = 0;
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0xabe5d144, Offset: 0x22cd
// Size: 0xbb
function private function_1fea1afdcad724b()
{
    val::set( #"sat_timetravel", "allow_teleport", 0 );
    val::set( #"sat_timetravel", "disallow_magicbox", 1 );
    val::set( #"sat_timetravel", "mount_side", 0 );
    val::set( #"sat_timetravel", "mount_top", 0 );
    val::set( #"sat_timetravel", "allow_ping", 0 );
    val::set( #"sat_timetravel", "killstreaks", 0 );
    val::set( #"sat_timetravel", "mantle", 0 );
    calloutmarkerping::function_5a33bcee47519dd6();
    self.var_2314a9263fbe04b9 = 1;
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace time_travel
// Params 0, eflags: 0x4
// Checksum 0x2093fc2c, Offset: 0x2390
// Size: 0xcd
function private init_dev_commands()
{
    if ( !isdefined( level.timetravel.dev_commands ) )
    {
        level.timetravel.dev_commands = [];
    }
    
    level.timetravel.dev_commands[ #"timewarp_all_players" ] = &timetravel;
    level.timetravel.dev_commands[ #"enable" ] = &enable;
    level.timetravel.dev_commands[ #"disable" ] = &disable;
    setdvar( @"hash_a16da1867b1c0848", 1 );
    utility::callsharedfunc( #"dev", #"register_dev_console_callback", #"sat_timetravel", &function_e99665ca16fea021 );
}

// Namespace time_travel
// Params 1, eflags: 0x4
// Checksum 0x3bdfd4ca, Offset: 0x2465
// Size: 0x170
function private function_e99665ca16fea021( params )
{
    command_targets = level.players;
    player_name_dvar = getdvar( @"cheat_player" );
    
    if ( player_name_dvar != "" )
    {
        foreach ( player in level.players )
        {
            if ( player.name == player_name_dvar )
            {
                command_targets = [ player ];
                break;
            }
        }
    }
    
    command_function = level.timetravel.dev_commands[ getxhash( params[ 0 ] ) ];
    
    if ( !command_function )
    {
        println( "<dev string:x24>" + params[ 0 ] );
        return;
    }
    
    foreach ( player in command_targets )
    {
        player [[ command_function ]]();
    }
}

