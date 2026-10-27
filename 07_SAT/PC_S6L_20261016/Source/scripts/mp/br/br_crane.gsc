// scripts\mp\br\br_crane.gsc  (hash_53fd31a65517fe9b.gscc) (size: 17793 Bytes / 0x4581 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x540109ef (1409354223)
// size ...... 17793 (0x4581)
// includes .. 4   (offset: 0x4059)
// strings ... 50  (offset: 0x4079)
// dev strs .. 17  (offset: 0x4481)
// exports ... 35  (offset: 0x2eb5)
// cseg ...... 0x39b + 0x2b1a (0x2eb5)
// imports ... 90  (offset: 0x342d)
// animtree1 . 0   (offset: 0x4581)
// animtree2 . 0   (offset: 0x4581)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;

#namespace br_crane;

// Namespace br_crane
// Params 0, eflags: 0x1
// Checksum 0xcc1523e0, Offset: 0x3b9
// Size: 0x29
function autoexec main()
{
    if ( !getdvarint( @"hash_f1dde303a997d853", 1 ) )
    {
        return;
    }
    
    level thread init();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_crane
// Params 0
// Checksum 0x4c91a8b0, Offset: 0x3ea
// Size: 0xcf
function init()
{
    level.var_25f5588936a79a98 = spawnstruct();
    level.var_25f5588936a79a98.anim_rate = getdvarfloat( @"scr_crane_anim_rate", 1 );
    
    /#
        level.var_25f5588936a79a98.a_s_destinations = [];
    #/
    
    level waittill( #"crane_anim_init_complete" );
    utility::flag_wait( "scriptables_ready" );
    cranes_init();
    
    if ( level.var_25f5588936a79a98.instances.size == 0 )
    {
        level.var_25f5588936a79a98 = undefined;
        return;
    }
    
    consoles_init();
    function_6b34acd2e24f5554();
    scriptable::scriptable_addusedcallbackbypart( "crane_console_interact", &function_819f30dfdd381987 );
    function_bc43fc39ba752da5();
    
    /#
        if ( getdvar( @"hash_8c5e75e7ae051167" ) )
        {
            level thread function_753c82cea5aeebd2();
        }
    #/
}

// Namespace br_crane
// Params 2
// Checksum 0x2d9b9a99, Offset: 0x4c1
// Size: 0x9a
function init_anim( str_id, animref )
{
    while ( !isdefined( level.var_25f5588936a79a98 ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.var_25f5588936a79a98.animstructs ) )
    {
        level.var_25f5588936a79a98.animstructs = [];
    }
    
    s = spawnstruct();
    s.animref = animref;
    s.animlen = getanimlength( animref );
    level.var_25f5588936a79a98.animstructs[ str_id ] = s;
}

// Namespace br_crane
// Params 3
// Checksum 0xa5aeaa69, Offset: 0x563
// Size: 0x1ca
function set_path_anims( s_from, s_to, a_s_anims )
{
    if ( !isdefined( s_from.targetname ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_25f5588936a79a98.path_anims[ s_from.targetname ] ) )
    {
        level.var_25f5588936a79a98.path_anims[ s_from.targetname ] = [];
    }
    
    level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ] = [];
    
    if ( isarray( a_s_anims ) )
    {
        foreach ( a in a_s_anims )
        {
            level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ][ level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ].size ] = a;
        }
        
        return;
    }
    
    level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ][ level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ].size ] = a_s_anims;
}

// Namespace br_crane
// Params 4
// Checksum 0x648fee9e, Offset: 0x735
// Size: 0x80
function hacklinkto( target, clip, tag, v_offset )
{
    level endon( #"game_ended" );
    self endon( #"hash_b86a2a791c41e95f" );
    
    while ( true )
    {
        clip moveto( target gettagorigin( tag ) + v_offset, 0.05 );
        clip rotateto( combineanglesinverted( target.angles, target gettagangles( tag ) ), 0.05 );
        waitframe();
    }
}

// Namespace br_crane
// Params 0
// Checksum 0xe8b4be76, Offset: 0x7bd
// Size: 0xbe3
function cranes_init()
{
    level.var_25f5588936a79a98.instances = getentarray( "s4_cyclops_crane_animated", "targetname" );
    a_e_arm = getentarray( "crane_arm", "targetname" );
    var_90f84188292f013b = getentarray( "crane_arm_clip", "targetname" );
    a_e_dolly = getentarray( "crane_dolly", "targetname" );
    var_e5027dd71e2a625d = getentarray( "crane_dolly_clip", "targetname" );
    a_e_hook = getentarray( "crane_hook", "targetname" );
    a_e_cargo = getentarray( "crane_cargo", "targetname" );
    var_70ae1502f7df3cad = getentarray( "crane_cargo_clip", "targetname" );
    
    foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
    {
        var_9259692e2b4b537b.consoles = [];
        var_9259692e2b4b537b.destinations = [];
        var_9259692e2b4b537b.default_destinations = [];
        var_9259692e2b4b537b.dummy = spawn( "script_model", var_9259692e2b4b537b.origin );
        var_9259692e2b4b537b.dummy.angles = var_9259692e2b4b537b.angles;
        var_9259692e2b4b537b.dummy setmodel( "s4_cyclops_crane_animated" );
        var_9259692e2b4b537b.dummy hide();
        var_9259692e2b4b537b forcenetfieldhighlod( 1 );
        var_9259692e2b4b537b markkeyframedmover();
        var_9259692e2b4b537b setmoverantilagged( 1 );
        var_9259692e2b4b537b setmoveroptimized( 1 );
        var_5a285b6cfaff7b87 = function_628bac9faa9d1e86( var_90f84188292f013b, var_9259692e2b4b537b.origin )[ 0 ];
        var_5a285b6cfaff7b87 forcenetfieldhighlod( 1 );
        var_5a285b6cfaff7b87 setmoverantilagged( 1 );
        var_5a285b6cfaff7b87 setmovingplatformdef( "movingplatform_rotator" );
        var_5a285b6cfaff7b87 setmoveroptimized( 1 );
        var_5a285b6cfaff7b87.override_unresolved_collision = &function_15648e892f6e5072;
        utility::register_moving_platform_ent( var_5a285b6cfaff7b87 );
        var_9259692e2b4b537b.var_5a285b6cfaff7b87 = var_5a285b6cfaff7b87;
        dolly_clip = function_628bac9faa9d1e86( var_e5027dd71e2a625d, var_9259692e2b4b537b.origin )[ 0 ];
        dolly_clip forcenetfieldhighlod( 1 );
        dolly_clip setmoverantilagged( 1 );
        dolly_clip setmovingplatformdef( "movingplatform_rotator" );
        dolly_clip setmoveroptimized( 1 );
        dolly_clip.override_unresolved_collision = &function_15648e892f6e5072;
        utility::register_moving_platform_ent( dolly_clip );
        var_9259692e2b4b537b.dolly_clip = dolly_clip;
        cargo_clip = function_628bac9faa9d1e86( var_70ae1502f7df3cad, var_9259692e2b4b537b.origin )[ 0 ];
        cargo_clip forcenetfieldhighlod( 1 );
        cargo_clip setmoverantilagged( 1 );
        cargo_clip setmovingplatformdef( "movingplatform_rotator" );
        cargo_clip setmoveroptimized( 1 );
        cargo_clip.override_unresolved_collision = &function_15648e892f6e5072;
        utility::register_moving_platform_ent( cargo_clip );
        var_9259692e2b4b537b.cargo_clip = cargo_clip;
        var_9259692e2b4b537b thread function_b1e9c08f8c1d190a();
        var_9259692e2b4b537b.sfx = [];
        var_9259692e2b4b537b.sfx[ "arm" ] = [ spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin ) ];
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "arm" ] )
        {
            scriptable scriptablesetparententity( var_5a285b6cfaff7b87 );
        }
        
        var_cb5ff4715cf18a1e = [];
        a_s_consoles = utility::getstructarray( "crane_console_interact_noent", "targetname" );
        
        foreach ( struct in a_s_consoles )
        {
            if ( struct.script_parameters == "crane_nest" )
            {
                var_cb5ff4715cf18a1e[ var_cb5ff4715cf18a1e.size ] = struct;
            }
        }
        
        var_cb5ff4715cf18a1e = function_628bac9faa9d1e86( var_cb5ff4715cf18a1e, var_9259692e2b4b537b.origin );
        var_9259692e2b4b537b.sfx[ "cable" ] = [ spawnscriptable( "s4_cyclops_crane_sfx", dolly_clip.origin + ( 0, 0, -90 ) ) ];
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "cable" ] )
        {
            offset = scriptable.origin - dolly_clip.origin;
            scriptable scriptablesetparententity( dolly_clip, offset );
        }
        
        var_9259692e2b4b537b.sfx[ "cargo" ] = [];
        var_9259692e2b4b537b.sfx[ "cargo" ][ var_9259692e2b4b537b.sfx[ "cargo" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", cargo_clip.origin + anglestoforward( cargo_clip.angles ) * 180 + ( 0, 0, -365 ) );
        var_9259692e2b4b537b.sfx[ "cargo" ][ var_9259692e2b4b537b.sfx[ "cargo" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", cargo_clip.origin + anglestoforward( cargo_clip.angles ) * -180 + ( 0, 0, -365 ) );
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "cargo" ] )
        {
            offset = scriptable.origin - cargo_clip.origin;
            scriptable scriptablesetparententity( cargo_clip, offset );
        }
        
        var_9259692e2b4b537b.sfx[ "creak" ] = [];
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + ( 0, 0, 550 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * -2 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * -1 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * 1 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * 2 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * 3 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * 4 + ( 0, 0, 55 ) );
        var_9259692e2b4b537b.sfx[ "creak" ][ var_9259692e2b4b537b.sfx[ "creak" ].size ] = spawnscriptable( "s4_cyclops_crane_sfx", var_5a285b6cfaff7b87.origin + anglestoforward( var_9259692e2b4b537b gettagangles( "arm" ) ) * 450 * 5 + ( 0, 0, 55 ) );
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "creak" ] )
        {
            offset = scriptable.origin - var_5a285b6cfaff7b87.origin;
            scriptable scriptablesetparententity( var_5a285b6cfaff7b87, offset );
        }
        
        var_9259692e2b4b537b.sfx[ "dolly" ] = [ spawnscriptable( "s4_cyclops_crane_sfx", dolly_clip.origin + ( 0, 0, 50 ) ) ];
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "dolly" ] )
        {
            offset = scriptable.origin - dolly_clip.origin;
            scriptable scriptablesetparententity( dolly_clip, offset );
        }
        
        var_9259692e2b4b537b.sfx[ "hook" ] = [ spawnscriptable( "s4_cyclops_crane_sfx", cargo_clip.origin ) ];
        
        foreach ( scriptable in var_9259692e2b4b537b.sfx[ "hook" ] )
        {
            offset = scriptable.origin - cargo_clip.origin;
            scriptable scriptablesetparententity( cargo_clip, offset );
        }
        
        var_9259692e2b4b537b thread crane_sfx_watcher();
    }
}

// Namespace br_crane
// Params 0
// Checksum 0xb0bc07b4, Offset: 0x13a8
// Size: 0x173
function function_b1e9c08f8c1d190a()
{
    self.cargo_interact = spawnscriptable( "crane_console_interact_noent", self.cargo_clip.origin );
    self.cargo_interact.var_9259692e2b4b537b = self;
    wait 1;
    self.cargo_clip.angles = self gettagangles( "tag_hook" );
    var_d1f47820ce3cbf47 = ( 0, 0, 0 );
    var_d1f47820ce3cbf47 += anglestoforward( self.cargo_clip.angles ) * ( -16, -84, -321 )[ 0 ];
    var_d1f47820ce3cbf47 += anglestoright( self.cargo_clip.angles ) * ( -16, -84, -321 )[ 1 ];
    var_d1f47820ce3cbf47 += ( 0, 0, 1 ) * ( -16, -84, -321 )[ 2 ];
    self.cargo_interact.angles = self.cargo_clip.angles + ( 0, 90, 0 );
    self.cargo_interact scriptablesetparententity( self.cargo_clip, var_d1f47820ce3cbf47, self.cargo_clip.angles - self.cargo_interact.angles );
    level notify( #"crane_init_complete" );
}

// Namespace br_crane
// Params 0
// Checksum 0x233761b0, Offset: 0x1523
// Size: 0x30b
function consoles_init()
{
    utility::flag_wait( "mp_wz2_sierra_downtown_s4_cs_completed" );
    a_s_consoles = utility::getstructarray( "crane_console_interact_noent", "targetname" );
    
    foreach ( s in a_s_consoles )
    {
        var_190f59357d8260f7 = spawnscriptable( "crane_console_interact_noent", s.origin, s.angles );
        var_190f59357d8260f7.var_9259692e2b4b537b = function_628bac9faa9d1e86( level.var_25f5588936a79a98.instances, var_190f59357d8260f7.origin )[ 0 ];
        
        if ( isdefined( s.script_noteworthy ) )
        {
            var_190f59357d8260f7.s_destination = utility::getstruct( s.script_noteworthy, "targetname" );
        }
        
        if ( isdefined( var_190f59357d8260f7.s_destination ) )
        {
            var_190f59357d8260f7.s_destination.var_9259692e2b4b537b = var_190f59357d8260f7.var_9259692e2b4b537b;
        }
        
        if ( s.script_parameters != "crane_nest" )
        {
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact_model", "on" );
        }
        
        if ( s.script_parameters == "crane_nest" )
        {
            var_190f59357d8260f7.var_2e40c884d30b02f2 = 1;
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact_model", "off" );
        }
        
        var_190f59357d8260f7.var_9259692e2b4b537b.consoles[ var_190f59357d8260f7.var_9259692e2b4b537b.consoles.size ] = var_190f59357d8260f7;
        
        if ( s.script_parameters != "crane_nest" )
        {
            var_190f59357d8260f7.var_9259692e2b4b537b.destinations[ var_190f59357d8260f7.var_9259692e2b4b537b.destinations.size ] = var_190f59357d8260f7.s_destination;
        }
        
        /#
            level.var_25f5588936a79a98.a_s_destinations[ level.var_25f5588936a79a98.a_s_destinations.size ] = var_190f59357d8260f7.s_destination;
        #/
    }
    
    foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
    {
        var_9259692e2b4b537b.cargo_interact setscriptablepartstate( "crane_console_interact_model", "off" );
        var_9259692e2b4b537b.consoles[ var_9259692e2b4b537b.consoles.size ] = var_9259692e2b4b537b.cargo_interact;
    }
}

// Namespace br_crane
// Params 0
// Checksum 0xd19881, Offset: 0x1836
// Size: 0xe4
function function_6b34acd2e24f5554()
{
    var_dc2dab28f2ca86a7 = utility::getstructarray( "crane_destination_default", "script_noteworthy" );
    
    foreach ( s in var_dc2dab28f2ca86a7 )
    {
        s.var_9259692e2b4b537b = function_628bac9faa9d1e86( level.var_25f5588936a79a98.instances, s.origin )[ 0 ];
        s.var_9259692e2b4b537b.default_destinations[ s.var_9259692e2b4b537b.default_destinations.size ] = s;
    }
}

// Namespace br_crane
// Params 0
// Checksum 0xc2b772d, Offset: 0x1922
// Size: 0x197
function function_bc43fc39ba752da5()
{
    level waittill( #"crane_init_complete" );
    
    foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
    {
        i_from = randomint( var_9259692e2b4b537b.destinations.size );
        i_to = randomint( var_9259692e2b4b537b.destinations.size );
        
        /#
            var_d5ea54f9891f1322 = getdvarint( @"hash_984d83d8bfd0dd4", -1 );
            
            if ( var_d5ea54f9891f1322 != -1 )
            {
                assert( var_d5ea54f9891f1322 < var_9259692e2b4b537b.destinations.size );
                i_from = var_d5ea54f9891f1322;
            }
            
            var_d04c8e2d998c943f = getdvarint( @"hash_371a24aa34947845", -1 );
            
            if ( var_d04c8e2d998c943f != -1 )
            {
                assert( var_d04c8e2d998c943f < var_9259692e2b4b537b.destinations.size );
                i_to = var_d04c8e2d998c943f;
            }
            
            if ( var_d5ea54f9891f1322 != -1 && var_d04c8e2d998c943f != -1 )
            {
                assert( var_d5ea54f9891f1322 != var_d04c8e2d998c943f );
            }
        #/
        
        while ( i_from == i_to )
        {
            i_to = randomint( var_9259692e2b4b537b.destinations.size );
            waitframe();
        }
        
        var_9259692e2b4b537b thread move( var_9259692e2b4b537b.destinations[ i_from ], var_9259692e2b4b537b.destinations[ i_to ] );
    }
}

// Namespace br_crane
// Params 2
// Checksum 0xd47eaa4, Offset: 0x1ac1
// Size: 0x21a
function move( s_from, s_to )
{
    a_s_anims = level.var_25f5588936a79a98.path_anims[ s_from.targetname ][ s_to.targetname ];
    level endon( #"game_ended" );
    self.var_32fb357f1788ddd7 = 1;
    consoles_lock();
    thread hacklinkto( self.dummy, self.var_5a285b6cfaff7b87, "arm", ( 0, 0, 0 ) );
    thread hacklinkto( self.dummy, self.dolly_clip, "head", ( 0, 0, 56 ) );
    thread hacklinkto( self.dummy, self.cargo_clip, "tag_hook", ( 0, 0, -68 ) );
    
    foreach ( s in a_s_anims )
    {
        playback_time = s.animlen * 1 / level.var_25f5588936a79a98.anim_rate;
        self.dummy scriptmodelplayanim( s.animref, "crane_anim", 0, level.var_25f5588936a79a98.anim_rate );
        wait 0.1;
        self scriptmodelplayanim( s.animref, "crane_anim", 0, level.var_25f5588936a79a98.anim_rate );
        wait playback_time;
        self.s_destination = s_to;
    }
    
    self notify( #"hash_b86a2a791c41e95f" );
    self.var_32fb357f1788ddd7 = undefined;
    consoles_unlock();
    
    /#
        level notify( #"hash_bd02382d45b4912e" );
    #/
}

// Namespace br_crane
// Params 6
// Checksum 0x56b188eb, Offset: 0x1ce3
// Size: 0x177
function function_819f30dfdd381987( scriptable, part, state, player, bautouse, usestring )
{
    if ( scriptable.s_destination == scriptable.var_9259692e2b4b537b.s_destination )
    {
        if ( soundexists( "fly_pickup_deny" ) )
        {
            player playlocalsound( "fly_pickup_deny" );
        }
        
        return;
    }
    
    if ( soundexists( "fly_pickup_ammo_gen" ) )
    {
        player playlocalsound( "fly_pickup_ammo_gen" );
    }
    
    s_destination = undefined;
    
    if ( isdefined( scriptable.s_destination ) )
    {
        s_destination = scriptable.s_destination;
    }
    else
    {
        s_destination = function_628bac9faa9d1e86( scriptable.var_9259692e2b4b537b.default_destinations, scriptable.var_9259692e2b4b537b.s_destination.origin )[ 0 ];
        
        if ( s_destination == scriptable.var_9259692e2b4b537b.s_destination )
        {
            s_destination = function_628bac9faa9d1e86( scriptable.var_9259692e2b4b537b.default_destinations, scriptable.var_9259692e2b4b537b.s_destination.origin )[ 1 ];
        }
    }
    
    scriptable.var_9259692e2b4b537b thread move( scriptable.var_9259692e2b4b537b.s_destination, s_destination );
}

// Namespace br_crane
// Params 0
// Checksum 0xf76346b, Offset: 0x1e62
// Size: 0xc6
function consoles_lock()
{
    consoles_transition();
    
    foreach ( var_190f59357d8260f7 in self.consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact", "crane_console_interact_locked" );
        
        if ( !var_190f59357d8260f7.var_2e40c884d30b02f2 && var_190f59357d8260f7 != var_190f59357d8260f7.var_9259692e2b4b537b.cargo_interact )
        {
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact_model", "transit" );
        }
    }
}

// Namespace br_crane
// Params 0
// Checksum 0x8547d6ec, Offset: 0x1f30
// Size: 0xfe
function consoles_unlock()
{
    consoles_transition();
    
    foreach ( var_190f59357d8260f7 in self.consoles )
    {
        if ( var_190f59357d8260f7.s_destination == var_190f59357d8260f7.var_9259692e2b4b537b.s_destination )
        {
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact", "crane_console_interact_locked_at_location" );
        }
        else
        {
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact", "crane_console_interact" );
        }
        
        if ( !var_190f59357d8260f7.var_2e40c884d30b02f2 && var_190f59357d8260f7 != var_190f59357d8260f7.var_9259692e2b4b537b.cargo_interact )
        {
            var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact_model", "on" );
        }
    }
}

// Namespace br_crane
// Params 0
// Checksum 0x5547b5c4, Offset: 0x2036
// Size: 0x84
function consoles_transition()
{
    foreach ( var_190f59357d8260f7 in self.consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( "crane_console_interact", "transition" );
    }
    
    waitframe();
}

// Namespace br_crane
// Params 1
// Checksum 0xeb4287af, Offset: 0x20c2
// Size: 0x19
function get_destination( str )
{
    return utility::getstruct( str, "targetname" );
}

// Namespace br_crane
// Params 3
// Checksum 0x3c1eeab, Offset: 0x20e4
// Size: 0x1dc
function crane_sfx( part, time, decel )
{
    level endon( #"game_ended" );
    
    foreach ( scriptable in self.sfx[ part ] )
    {
        scriptable setscriptablepartstate( "s4_cyclops_crane_sfx", part + "_start" );
    }
    
    /#
        function_74c4b5f0c21a870a( part );
    #/
    
    if ( part == "creak" )
    {
        wait time - decel;
        
        foreach ( scriptable in self.sfx[ part ] )
        {
            scriptable setscriptablepartstate( "s4_cyclops_crane_sfx", part + "_decel" );
        }
        
        wait decel;
    }
    else
    {
        wait time;
    }
    
    foreach ( scriptable in self.sfx[ part ] )
    {
        scriptable setscriptablepartstate( "s4_cyclops_crane_sfx", part + "_stop" );
    }
    
    /#
        function_e22cb9186a2a7145( part );
    #/
}

// Namespace br_crane
// Params 0
// Checksum 0x6d785e78, Offset: 0x22c8
// Size: 0x182
function crane_sfx_watcher()
{
    while ( true )
    {
        msg = utility::waittill_any_return( "arm_start", "arm_decel", "arm_stop", "dolly_start", "dolly_stop", "hook_start", "hook_stop" );
        
        switch ( msg )
        {
            case #"hash_d09f80f8cb9f188e":
                thread crane_play_sfx( [ "arm", "creak" ], "_start" );
                break;
            case #"hash_8647040e855b5e9f":
                thread crane_play_sfx( [ "creak" ], "_decel" );
                break;
            case #"hash_4a920f8e465b6f56":
                thread crane_play_sfx( [ "arm", "creak" ], "_stop" );
                break;
            case #"hash_a0a728bf09efe2cc":
                thread crane_play_sfx( [ "dolly" ], "_start" );
                break;
            case #"hash_f29160818d11528":
                thread crane_play_sfx( [ "dolly" ], "_stop" );
                break;
            case #"hash_ebc996ed0fb892a5":
                thread crane_play_sfx( [ "cable", "hook", "cargo" ], "_start" );
                break;
            case #"hash_1de0f72ee635277":
                thread crane_play_sfx( [ "cable", "hook", "cargo" ], "_stop" );
                break;
        }
    }
}

// Namespace br_crane
// Params 2
// Checksum 0x4c4a9d6, Offset: 0x2452
// Size: 0xff
function crane_play_sfx( var_7e823c81ba29f5d4, str_state )
{
    foreach ( str_part in var_7e823c81ba29f5d4 )
    {
        foreach ( scriptable in self.sfx[ str_part ] )
        {
            scriptable setscriptablepartstate( "s4_cyclops_crane_sfx", str_part + str_state );
        }
    }
}

// Namespace br_crane
// Params 3
// Checksum 0xa74135bb, Offset: 0x2559
// Size: 0x61
function function_15648e892f6e5072( player, unused_1, var_c42324aa35433459 )
{
    if ( player getstance() == "stand" )
    {
        player setstance( "crouch" );
        return;
    }
    
    if ( player getstance() == "crouch" )
    {
        player setstance( "prone" );
        return;
    }
    
    player kill();
}

/#

    // Namespace br_crane
    // Params 0
    // Checksum 0xea7f3a39, Offset: 0x25c2
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x4e3b3022, Offset: 0x25cf
    // Size: 0x44, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        utility::function_95db22f620602461( @"hash_7b6bb8e3f87c3e2f", &function_4a19aeb7cfc7d698 );
        utility::function_95db22f620602461( @"hash_771a048e536c2a45", &function_9f563fa57ed6e5ec );
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x33f3ffcc, Offset: 0x261b
    // Size: 0x56, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        
        if ( getdvarint( @"hash_7b6bb8e3f87c3e2f", 1 ) )
        {
            devgui::add_devgui_func( "<dev string:x32>", "<dev string:x3f>", &function_57c1c73d3adafd80 );
            devgui::add_devgui_func( "<dev string:x52>", "<dev string:x63>", &function_5497a23f1e514684 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0xb9d07d8, Offset: 0x2679
    // Size: 0x27, Type: dev
    function function_57c1c73d3adafd80()
    {
        if ( !getdvarint( @"hash_7b6bb8e3f87c3e2f" ) )
        {
            function_4a19aeb7cfc7d698();
            return;
        }
        
        function_be2f0c3df4571f52();
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x9e76efab, Offset: 0x26a8
    // Size: 0xc4, Type: dev
    function function_4a19aeb7cfc7d698()
    {
        setdvar( @"hash_7b6bb8e3f87c3e2f", 1 );
        iprintlnbold( "<dev string:x7a>" );
        
        foreach ( s in level.var_25f5588936a79a98.a_s_destinations )
        {
            debug::sphere( s );
            debug::print3d( s, s.targetname, undefined, undefined, "<dev string:x89>", undefined, undefined, 3, -300 );
        }
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x444a52ab, Offset: 0x2774
    // Size: 0x2a, Type: dev
    function function_be2f0c3df4571f52()
    {
        setdvar( @"hash_7b6bb8e3f87c3e2f", 0 );
        iprintlnbold( "<dev string:x9f>" );
        level notify( #"hash_7fea6a88c562584" );
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x979dcbce, Offset: 0x27a6
    // Size: 0x27, Type: dev
    function function_5497a23f1e514684()
    {
        if ( !getdvarint( @"hash_771a048e536c2a45" ) )
        {
            function_9f563fa57ed6e5ec();
            return;
        }
        
        function_41b772f5f2c32606();
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0xe2251dcb, Offset: 0x27d5
    // Size: 0x1b2, Type: dev
    function function_9f563fa57ed6e5ec()
    {
        while ( !isdefined( level.var_25f5588936a79a98.instances[ 0 ].sfx ) )
        {
            waitframe();
        }
        
        setdvar( @"hash_771a048e536c2a45", 1 );
        iprintlnbold( "<dev string:xaf>" );
        
        foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
        {
            foreach ( type in var_9259692e2b4b537b.sfx )
            {
                foreach ( scriptable in type )
                {
                    debug::sphere( scriptable, undefined, "<dev string:xc2>", undefined, "<dev string:xc9>", "<dev string:xc9>" );
                }
            }
        }
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x428b5fb2, Offset: 0x298f
    // Size: 0x2a, Type: dev
    function function_41b772f5f2c32606()
    {
        setdvar( @"hash_771a048e536c2a45", 0 );
        iprintlnbold( "<dev string:x9f>" );
        level notify( #"hash_20b2d5c6581c4544" );
    }

    // Namespace br_crane
    // Params 1
    // Checksum 0x82984239, Offset: 0x29c1
    // Size: 0xd6, Type: dev
    function function_74c4b5f0c21a870a( type )
    {
        if ( !getdvarint( @"hash_771a048e536c2a45" ) )
        {
            return;
        }
        
        waitframe();
        
        foreach ( scriptable in self.sfx[ type ] )
        {
            scriptable notify( #"hash_20b2d5c6581c4544" );
            debug::print3d( scriptable, type, "<dev string:xe3>", undefined, "<dev string:xc9>", "<dev string:xc9>" );
            debug::sphere( scriptable, undefined, "<dev string:xe3>", undefined, "<dev string:xc9>", "<dev string:xc9>" );
        }
    }

    // Namespace br_crane
    // Params 1
    // Checksum 0x805badf8, Offset: 0x2a9f
    // Size: 0xd5, Type: dev
    function function_e22cb9186a2a7145( type )
    {
        if ( !getdvarint( @"hash_771a048e536c2a45" ) )
        {
            return;
        }
        
        foreach ( scriptable in self.sfx[ type ] )
        {
            scriptable notify( #"hash_20b2d5c6581c4544" );
            debug::print3d( scriptable, type, "<dev string:xe9>", undefined, "<dev string:xc9>", "<dev string:xc9>" );
            debug::sphere( scriptable, undefined, "<dev string:xe9>", undefined, "<dev string:xc9>", "<dev string:xc9>" );
        }
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0xb334ffd9, Offset: 0x2b7c
    // Size: 0x88, Type: dev
    function function_753c82cea5aeebd2()
    {
        foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
        {
            var_9259692e2b4b537b thread function_6b0b130ef97f0395();
        }
    }

    // Namespace br_crane
    // Params 0
    // Checksum 0x80ecbbe, Offset: 0x2c0c
    // Size: 0x98, Type: dev
    function function_6b0b130ef97f0395()
    {
        level endon( #"game_ended" );
        pause_time = getdvarint( @"hash_7636a31f5f5cf1be", 5 );
        
        while ( true )
        {
            wait pause_time;
            i_to = randomint( self.destinations.size );
            
            while ( self.destinations[ i_to ] == self.s_destination )
            {
                i_to = randomint( self.destinations.size );
                waitframe();
            }
            
            move( self.s_destination, self.destinations[ i_to ] );
        }
    }

    // Namespace br_crane
    // Params 1
    // Checksum 0x7db57e35, Offset: 0x2cac
    // Size: 0x209, Type: dev
    function function_99090912ffe7a02f( a_args )
    {
        str_id = a_args[ 0 ];
        
        foreach ( var_9259692e2b4b537b in level.var_25f5588936a79a98.instances )
        {
            playback_time = level.var_25f5588936a79a98.animstructs[ str_id ].animlen * 1 / level.var_25f5588936a79a98.anim_rate;
            var_9259692e2b4b537b thread hacklinkto( var_9259692e2b4b537b.dummy, var_9259692e2b4b537b.var_5a285b6cfaff7b87, "<dev string:xed>", ( 0, 0, 0 ) );
            var_9259692e2b4b537b thread hacklinkto( var_9259692e2b4b537b.dummy, var_9259692e2b4b537b.dolly_clip, "<dev string:xf1>", ( 0, 0, 56 ) );
            var_9259692e2b4b537b thread hacklinkto( var_9259692e2b4b537b.dummy, var_9259692e2b4b537b.cargo_clip, "<dev string:xf6>", ( 0, 0, -68 ) );
            var_9259692e2b4b537b.dummy scriptmodelplayanim( level.var_25f5588936a79a98.animstructs[ str_id ].animref, "<dev string:xff>", 0, level.var_25f5588936a79a98.anim_rate );
            wait 0.1;
            var_9259692e2b4b537b scriptmodelplayanim( level.var_25f5588936a79a98.animstructs[ str_id ].animref, "<dev string:xff>", 0, level.var_25f5588936a79a98.anim_rate );
            wait playback_time;
            var_9259692e2b4b537b notify( #"hash_b86a2a791c41e95f" );
        }
    }

#/
