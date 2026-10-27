// scripts\mp\zm\traps\laser_trap.gsc  (hash_0f6f43ed25b32e34.gscc) (size: 8720 Bytes / 0x2210 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa5147b8 (4199630776)
// size ...... 8720 (0x2210)
// includes .. 13  (offset: 0x1f70)
// strings ... 37  (offset: 0x1fd8)
// dev strs .. 0   (offset: 0x2210)
// exports ... 15  (offset: 0x1444)
// cseg ...... 0x381 + 0x10c3 (0x1444)
// imports ... 75  (offset: 0x169c)
// animtree1 . 0   (offset: 0x2210)
// animtree2 . 0   (offset: 0x2210)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\status_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\trap_core;

#namespace laser_trap;

// Namespace laser_trap
// Params 0
// Checksum 0xcde675d5, Offset: 0x39f
// Size: 0x397
function init()
{
    level._effect[ "laser_trap_beam" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_red" );
    level._effect[ "laser_trap_beam_trail" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_red_t" );
    level._effect[ "laser_trap_mirror_impact" ] = loadfxasset( "vfx_sat_levels_zm_ruby_laser_trap_mirrors_impact" );
    level.haywireenable = getdvarint( @"hash_f7d23d3c07de4f6c", 0 );
    level.gibenable = getdvarint( @"hash_99b4e751ae5391e5", 1 );
    level utility::flag_wait( "begin_round_logic" );
    corridor_ents = getentarray( "corridor_ent", #script_noteworthy );
    
    foreach ( ent in corridor_ents )
    {
        ent disconnectpaths();
    }
    
    trap_core::function_63a557f0f22161af( "laser_trap_switch", &function_5103a473c11743ab, &function_5332008bf3c15082 );
    level utility::flag_wait( "laser_trap_switch_trap_init_finished" );
    level.laser_trap_emitter = getent( "laser_trap_emitter", #targetname );
    level.laser_trap_coil = getent( "laser_trap_coil", #targetname );
    var_b7d3551bf7dac03e = [];
    
    foreach ( var_f5d93163bb80f7b in level.var_f301c0b95ea728e2 )
    {
        if ( var_f5d93163bb80f7b.targetname == "laser_trap_switch" )
        {
            var_b7d3551bf7dac03e = arraycombine( var_b7d3551bf7dac03e, var_f5d93163bb80f7b.trap_positions );
            var_f5d93163bb80f7b.a_switch_pos[ 0 ].interact.origin += ( 0, 8, 45 );
        }
    }
    
    foreach ( laser_transmitter in var_b7d3551bf7dac03e )
    {
        laser_transmitter.sbl = laser_transmitter.trap_scriptable;
        var_2d24cb374d17f3cc = laser_transmitter;
        
        while ( true )
        {
            var_2d24cb374d17f3cc.original_position = var_2d24cb374d17f3cc.origin;
            
            if ( !isdefined( var_2d24cb374d17f3cc.target ) )
            {
                break;
            }
            
            pseudo_reflector = utility::getstruct( var_2d24cb374d17f3cc.target, "targetname" );
            pseudo_reflector.sbl = utility::spawn_model( pseudo_reflector.script_modelname, pseudo_reflector.origin, pseudo_reflector.angles );
            var_2d24cb374d17f3cc.var_1b2ef4e9d237c9d6 = pseudo_reflector;
            var_2d24cb374d17f3cc = pseudo_reflector;
            var_2d24cb374d17f3cc.attack_entity = laser_transmitter.attack_entity;
        }
    }
}

// Namespace laser_trap
// Params 1
// Checksum 0x54fe9fa2, Offset: 0x73e
// Size: 0xbc
function function_5103a473c11743ab( activator )
{
    params = spawnstruct();
    params.activator = activator;
    params.var_359a765be5422f83 = self;
    level.laser_trap_emitter setscriptablepartstate( "fx", "on" );
    level.laser_trap_coil setscriptablepartstate( "fx", "start" );
    level callback::callback( "on_laser_trap_activated", params );
    
    if ( isdefined( activator ) && !activator utility::ent_flag( "laser_trap_first_kill_vo" ) )
    {
        if ( !level callback::exists( "on_zombie_ai_killed", &function_f00c0f833e8147fc ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
        }
    }
    
    thread function_31180ced8739f3a();
}

// Namespace laser_trap
// Params 1
// Checksum 0xb4455766, Offset: 0x802
// Size: 0x8f
function function_5332008bf3c15082( activator )
{
    params = spawnstruct();
    params.activator = activator;
    params.var_359a765be5422f83 = self;
    level.laser_trap_emitter setscriptablepartstate( "fx", "off" );
    level.laser_trap_coil setscriptablepartstate( "fx", "end" );
    level callback::callback( "on_laser_trap_deactivated", params );
    level callback::remove( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
    thread try_stop_beam();
}

// Namespace laser_trap
// Params 0
// Checksum 0x5c5c1c75, Offset: 0x899
// Size: 0x49
function function_31180ced8739f3a()
{
    for ( var_2d24cb374d17f3cc = self; true ; var_2d24cb374d17f3cc = var_2d24cb374d17f3cc.var_1b2ef4e9d237c9d6 )
    {
        if ( !isdefined( var_2d24cb374d17f3cc.var_1b2ef4e9d237c9d6 ) )
        {
            break;
        }
        
        var_2d24cb374d17f3cc thread beam_handler();
        var_2d24cb374d17f3cc thread get_beam_hit_result();
    }
}

// Namespace laser_trap
// Params 0
// Checksum 0x46fc584c, Offset: 0x8ea
// Size: 0x15e
function beam_handler()
{
    if ( self.var_1b2ef4e9d237c9d6.script_noteworthy == "moveable" )
    {
        self.beam_fx = playfxontagsbetweenclients( level._effect[ "laser_trap_beam" ], self.sbl, "tag_origin", self.var_1b2ef4e9d237c9d6.sbl, "tag_origin" );
        self.var_1b2ef4e9d237c9d6 thread function_e9e19762bec914b0( int( self.var_1b2ef4e9d237c9d6.script_parameters ) );
    }
    else
    {
        self.beam_ent = utility::spawn_tag_origin( self.origin, self.var_1b2ef4e9d237c9d6.sbl.origin - self.sbl.origin );
        self.beam_ent show();
        playfxontag( utility::getfx( "laser_trap_beam_trail" ), self.beam_ent, "tag_origin" );
        thread function_760cde12bfdbf079( self.sbl.origin, self.var_1b2ef4e9d237c9d6.sbl.origin );
    }
    
    playfxontag( utility::getfx( "laser_trap_mirror_impact" ), self.var_1b2ef4e9d237c9d6.sbl, "tag_origin" );
}

// Namespace laser_trap
// Params 2
// Checksum 0xd3a47574, Offset: 0xa50
// Size: 0x89
function function_760cde12bfdbf079( start_pos, end_pos )
{
    level endon( #"game_ended" );
    self endon( #"laser_fully_stopped" );
    
    while ( true )
    {
        self.beam_ent moveto( end_pos, 0.2 );
        self.beam_ent waittill( #"movedone" );
        self.beam_ent moveto( start_pos, 0.2 );
        self.beam_ent waittill( #"movedone" );
    }
}

// Namespace laser_trap
// Params 1
// Checksum 0x2002cce8, Offset: 0xae1
// Size: 0xd5
function function_e9e19762bec914b0( range )
{
    level endon( #"game_ended" );
    self endon( #"hash_364ee2c9467c44cc" );
    
    while ( true )
    {
        move_offset = ( randomfloatrange( range * -1, range ), randomfloatrange( range * -1, range ), 0 );
        move_target_position = self.original_position + move_offset;
        move_time = length( move_target_position - self.original_position ) / 20;
        self.sbl moveto( move_target_position, move_time );
        self.sbl waittill( #"movedone" );
        self.sbl moveto( self.original_position, move_time );
        self.sbl waittill( #"movedone" );
    }
}

// Namespace laser_trap
// Params 0
// Checksum 0xc2734a69, Offset: 0xbbe
// Size: 0x128
function get_beam_hit_result()
{
    level endon( #"game_ended" );
    self endon( #"laser_fully_stopped" );
    
    while ( true )
    {
        hit_result = trace::ray_trace_get_all_results( self.sbl.origin, self.var_1b2ef4e9d237c9d6.sbl.origin, [ self.sbl, self.var_1b2ef4e9d237c9d6.sbl ] );
        
        foreach ( ray_trace_result in hit_result )
        {
            if ( isai( ray_trace_result[ "entity" ] ) || isplayer( ray_trace_result[ "entity" ] ) )
            {
                thread damage_hit_ent( ray_trace_result[ "entity" ], ray_trace_result[ "position" ] );
            }
        }
        
        wait 0.25;
    }
}

// Namespace laser_trap
// Params 2
// Checksum 0x3bc7a217, Offset: 0xcee
// Size: 0x147
function damage_hit_ent( ent, hit_pos )
{
    if ( isplayer( ent ) && !player::isinlaststand( ent ) )
    {
        var_f170b524015f6863 = ent.maxhealth / 30;
        ent dodamage( var_f170b524015f6863, ent.origin, self.attack_entity, self.attack_entity, "MOD_PROJECTILE" );
        ent earthquakeforplayer( 0.3, 0.2, ent.origin, 200 );
        ent playrumbleonentity( "damage_heavy" );
        return;
    }
    
    need_delay = 0;
    
    if ( !isdefined( ent.var_9e2003a231a8ec2f ) || gettime() - ent.var_9e2003a231a8ec2f > 10000 )
    {
        need_delay = 1;
        ent.var_9e2003a231a8ec2f = gettime();
    }
    
    if ( need_delay )
    {
        wait 0.2;
    }
    
    if ( isalive( ent ) && !ent isragdoll() && isagent( ent ) && isdefined( self.attack_entity.activator ) )
    {
        ent thread effect_burn::burn( 2, 10, 1 );
        function_528fae578354c46a( ent, self.attack_entity, hit_pos );
    }
}

// Namespace laser_trap
// Params 3
// Checksum 0x4d6fc19e, Offset: 0xe3d
// Size: 0x242
function function_528fae578354c46a( zombie, eattacker, trace_position )
{
    if ( isai( zombie ) && isalive( zombie ) && isdefined( zombie.subclass ) && !zombie status_effects::has_status_effect_type( "charm" ) )
    {
        current_round = undefined;
        
        if ( zombie.type == "zombie" )
        {
            current_round = zombie zombie_utils::get_zombie_round_difficulty();
        }
        else
        {
            current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1();
        }
        
        n_damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round ) * 0.4;
        victim_aicategory = zombie.aicategory;
        victim_subclass = zombie.subclass;
        
        if ( level.gibenable )
        {
            zombie function_143569cb3466f472();
        }
        
        zombie.var_a13bed1ac47e1b2c = 1;
        
        switch ( zombie.subclass )
        {
            case #"hash_99a38be9e88b5244":
            case #"hash_f297af39454fdc7b":
                if ( zombie.health > n_damage )
                {
                    zombie thread damage_zombie_armor( eattacker );
                }
                
                zombie dodamage( n_damage, zombie.origin, eattacker, eattacker, "MOD_UNKNOWN", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                break;
            case #"hash_2f5c52f1e6ef9284":
                if ( !isdefined( zombie.var_f5b407724684cb72 ) )
                {
                    zombie.var_f5b407724684cb72 = 0;
                }
                
                zombie.var_f5b407724684cb72++;
                
                if ( zombie.var_f5b407724684cb72 == 1 )
                {
                    zombie thread metabone::destroy_metabone( "armored_head" );
                }
                else if ( zombie.var_f5b407724684cb72 >= 2 && zombie.health > n_damage )
                {
                    zombie thread metabone::destroy_metabone( "armored_torso" );
                }
                
                zombie dodamage( n_damage, zombie.origin, eattacker, eattacker, "MOD_UNKNOWN", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                break;
            default:
                zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_UNKNOWN", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                break;
        }
    }
}

// Namespace laser_trap
// Params 0
// Checksum 0xb253f7a, Offset: 0x1087
// Size: 0xa7
function function_143569cb3466f472()
{
    if ( !val::get( "allow_dismember" ) || self.damageshield )
    {
        return;
    }
    
    if ( isdefined( self.var_2d3d09afa922ca52 ) )
    {
        if ( gettime() - self.var_2d3d09afa922ca52 < 2000 )
        {
            return;
        }
    }
    
    rand = randomintrange( 0, 100 );
    
    if ( rand <= 15 )
    {
        namespace_b76ff2659823e89d::dismember_right_arm();
    }
    else if ( rand <= 30 )
    {
        namespace_b76ff2659823e89d::dismember_left_arm();
    }
    else if ( rand <= 70 )
    {
        namespace_b76ff2659823e89d::dismember_right_leg();
        namespace_b76ff2659823e89d::dismember_left_leg();
    }
    else
    {
        namespace_b76ff2659823e89d::function_6c318bca7bb326e7( 0 );
    }
    
    self.var_2d3d09afa922ca52 = gettime();
}

// Namespace laser_trap
// Params 1, eflags: 0x4
// Checksum 0x9298ff17, Offset: 0x1136
// Size: 0xd5
function private damage_zombie_armor( eattacker )
{
    armored_parts = [ "armored_head", "armored_torso" ];
    
    foreach ( part in armored_parts )
    {
        thread metabone::destroy_metabone( part );
    }
    
    if ( self.health / 3 > 10 )
    {
        self dodamage( self.health / 3, self.origin, eattacker, eattacker, "MOD_UNKNOWN", "<explicitweaponnone>" );
    }
}

// Namespace laser_trap
// Params 0
// Checksum 0x32e32b81, Offset: 0x1213
// Size: 0x154
function try_stop_beam()
{
    var_2d24cb374d17f3cc = self;
    
    while ( true )
    {
        var_2d24cb374d17f3cc notify( #"hash_364ee2c9467c44cc" );
        
        if ( var_2d24cb374d17f3cc.sbl.origin != var_2d24cb374d17f3cc.original_position )
        {
            var_2d24cb374d17f3cc.sbl moveto( var_2d24cb374d17f3cc.original_position, 1 );
        }
        
        if ( isdefined( var_2d24cb374d17f3cc.beam_fx ) )
        {
            var_2d24cb374d17f3cc.beam_fx utility::delaycall( 1, &delete );
            var_2d24cb374d17f3cc thread utility::delay_notify( 1, "laser_fully_stopped" );
        }
        else if ( isdefined( var_2d24cb374d17f3cc.beam_ent ) )
        {
            utility::noself_delaycall( 1, &killfxontag, level._effect[ "laser_trap_beam_trail" ], var_2d24cb374d17f3cc.beam_ent, "tag_origin" );
            var_2d24cb374d17f3cc thread utility::delay_notify( 1, "laser_fully_stopped" );
            var_2d24cb374d17f3cc.beam_ent utility::delaycall( 1 + level.framedurationseconds, &delete );
        }
        
        if ( !isdefined( var_2d24cb374d17f3cc.var_1b2ef4e9d237c9d6 ) )
        {
            break;
        }
        
        var_2d24cb374d17f3cc = var_2d24cb374d17f3cc.var_1b2ef4e9d237c9d6;
        utility::noself_delaycall( 1, &killfxontag, level._effect[ "laser_trap_mirror_impact" ], var_2d24cb374d17f3cc.sbl, "tag_origin" );
    }
}

// Namespace laser_trap
// Params 1, eflags: 0x4
// Checksum 0xaaf85291, Offset: 0x136f
// Size: 0xd5
function private function_f00c0f833e8147fc( params )
{
    if ( !isdefined( params.eattacker.activator ) )
    {
        return;
    }
    
    if ( params.eattacker.activator utility::ent_flag( "laser_trap_first_kill_vo" ) )
    {
        return;
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_f00c0f833e8147fc );
    params.eattacker.activator utility::ent_flag_set( "laser_trap_first_kill_vo" );
    var_db75d3de862ce072 = params.eattacker.activator namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"laser_trap_first_kill_vo" );
    
    if ( !var_db75d3de862ce072 )
    {
        params.eattacker.activator utility::ent_flag_clear( "laser_trap_first_kill_vo" );
    }
}

