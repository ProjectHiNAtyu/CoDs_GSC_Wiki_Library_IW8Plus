// scripts\common\exploder.gsc  (hash_0bf3584572aa2feb.gscc) (size: 15890 Bytes / 0x3e12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7ea72af (3622466223)
// size ...... 15890 (0x3e12)
// includes .. 2   (offset: 0x3916)
// strings ... 48  (offset: 0x3926)
// dev strs .. 18  (offset: 0x3d26)
// exports ... 39  (offset: 0x28be)
// cseg ...... 0x30f + 0x25af (0x28be)
// imports ... 82  (offset: 0x2ed6)
// animtree1 . 0   (offset: 0x3e12)
// animtree2 . 0   (offset: 0x3e12)
#using scripts\common\createfx;
#using scripts\common\utility;

#namespace exploder;

// Namespace exploder/bootstrap
// Params 1, eflags: 0x24
// Checksum 0xa804cf9d, Offset: 0x32d
// Size: 0x16
function private event_handler[bootstrap] boot_strap( struct )
{
    level.struct_exploders = [];
}

// Namespace exploder/spawnstruct
// Params 1, eflags: 0x24
// Checksum 0x2809091b, Offset: 0x34b
// Size: 0x42
function private event_handler[spawnstruct] spawn_struct( struct )
{
    if ( isdefined( struct.script_prefab_exploder ) || isdefined( struct.script_exploder ) )
    {
        level.struct_exploders[ level.struct_exploders.size ] = struct;
    }
}

// Namespace exploder
// Params 1
// Checksum 0x8ff3f6ee, Offset: 0x395
// Size: 0xd5
function setup_individual_exploder( ent )
{
    targetname = ent.targetname;
    
    if ( !isdefined( targetname ) )
    {
        targetname = "";
    }
    
    if ( exploder_starts_hidden( ent ) )
    {
        ent hide();
        return;
    }
    
    if ( exploder_is_damaged_model( ent ) )
    {
        ent hide();
        ent notsolid();
        
        if ( isdefined( ent.spawnflags ) && ent.spawnflags & 1 )
        {
            if ( isdefined( ent.script_disconnectpaths ) )
            {
                ent connectpaths();
            }
        }
        
        return;
    }
    
    if ( exploder_is_chunk( ent ) )
    {
        ent hide();
        ent notsolid();
        
        if ( isdefined( ent.spawnflags ) && ent.spawnflags & 1 )
        {
            ent connectpaths();
        }
        
        return;
    }
}

// Namespace exploder
// Params 1
// Checksum 0xcf21ce1c, Offset: 0x472
// Size: 0x10c
function addinitexploders( potentialexploders )
{
    foreach ( ent in potentialexploders )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( isdefined( ent.script_prefab_exploder ) )
        {
            ent.script_exploder = ent.script_prefab_exploder;
            level.init_exploders[ level.init_exploders.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_exploder ) )
        {
            if ( !isdefined( ent.angles ) )
            {
                ent.angles = ( 0, 0, 0 );
            }
            
            level.init_exploders[ level.init_exploders.size ] = ent;
        }
    }
}

// Namespace exploder
// Params 0
// Checksum 0x254995d0, Offset: 0x586
// Size: 0x8c4
function setupexploders()
{
    level.init_exploders = [];
    level.exploders = [];
    ents = getentarray( "script_brushmodel", #classname );
    smodels = getentarray( "script_model", #classname );
    
    foreach ( smodel in smodels )
    {
        ents[ ents.size ] = smodel;
    }
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.script_prefab_exploder ) )
        {
            ent.script_exploder = ent.script_prefab_exploder;
        }
        
        if ( isdefined( ent.masked_exploder ) )
        {
            continue;
        }
        
        if ( isdefined( ent.script_exploder ) )
        {
            setup_individual_exploder( ent );
        }
    }
    
    addinitexploders( getentarray( "script_brushmodel", #classname ) );
    addinitexploders( getentarray( "script_model", #classname ) );
    addinitexploders( level.struct_exploders );
    level.struct_exploders = undefined;
    
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    acceptabletargetnames = [];
    acceptabletargetnames[ "exploderchunk visible" ] = 1;
    acceptabletargetnames[ "exploderchunk" ] = 1;
    acceptabletargetnames[ "exploder" ] = 1;
    
    foreach ( exploder in level.init_exploders )
    {
        ent = utility::createexploder( exploder.script_fxid, 1 );
        ent.v = [];
        ent.v[ "origin" ] = exploder.origin;
        ent.v[ "angles" ] = exploder.angles;
        ent.v[ "delay" ] = exploder.script_delay;
        ent.v[ "delay_post" ] = exploder.script_delay_post;
        ent.v[ "firefx" ] = exploder.script_firefx;
        ent.v[ "firefxdelay" ] = exploder.script_firefxdelay;
        ent.v[ "firefxsound" ] = exploder.script_firefxsound;
        ent.v[ "earthquake" ] = exploder.script_earthquake;
        ent.v[ "rumble" ] = exploder.script_rumble;
        ent.v[ "damage" ] = exploder.script_damage;
        ent.v[ "damage_radius" ] = exploder.script_radius;
        ent.v[ "soundalias" ] = exploder.script_soundalias;
        ent.v[ "repeat" ] = exploder.script_repeat;
        ent.v[ "delay_min" ] = exploder.script_delay_min;
        ent.v[ "delay_max" ] = exploder.script_delay_max;
        ent.v[ "target" ] = exploder.target;
        ent.v[ "ender" ] = exploder.script_ender;
        ent.v[ "physics" ] = exploder.script_physics;
        ent.v[ "type" ] = "exploder";
        ent.v[ "dotraces" ] = exploder.script_trace;
        ent.v[ "envonly" ] = exploder.script_envonly;
        ent.v[ "area_swap_index" ] = exploder.script_area_swap_index;
        ent.v[ "area_swap_state" ] = exploder.script_area_swap_state;
        
        if ( !isdefined( ent.v[ "angles" ] ) )
        {
            ent.v[ "angles" ] = ( 0, 0, 0 );
        }
        
        ent createfx::set_forward_and_up_vectors();
        
        if ( !isdefined( exploder.script_fxid ) )
        {
            ent.v[ "fxid" ] = "No FX";
        }
        else
        {
            ent.v[ "fxid" ] = exploder.script_fxid;
        }
        
        ent.v[ "exploder" ] = exploder.script_exploder;
        assert( isdefined( exploder.script_exploder ), "<dev string:x24>" + exploder.origin + "<dev string:x38>" );
        
        if ( !isdefined( ent.v[ "delay" ] ) )
        {
            ent.v[ "delay" ] = 0;
        }
        
        if ( isdefined( exploder.target ) )
        {
            get_ent = getentarray( ent.v[ "target" ], #targetname )[ 0 ];
            
            if ( isdefined( get_ent ) )
            {
                org = get_ent.origin;
                ent.v[ "angles" ] = vectortoangles( org - ent.v[ "origin" ] );
            }
            else
            {
                get_ent = utility::get_target_ent( ent.v[ "target" ] );
                
                if ( isdefined( get_ent ) )
                {
                    org = get_ent.origin;
                    ent.v[ "angles" ] = vectortoangles( org - ent.v[ "origin" ] );
                }
            }
        }
        
        if ( isstruct( exploder ) )
        {
            ent.model = exploder;
            
            if ( isdefined( ent.model.script_modelname ) )
            {
                precachemodel( ent.model.script_modelname );
            }
        }
        else if ( exploder.code_classname == "script_brushmodel" || isdefined( exploder.model ) )
        {
            ent.model = exploder;
            ent.model.disconnect_paths = exploder.script_disconnectpaths;
        }
        
        if ( isdefined( exploder.targetname ) && isdefined( acceptabletargetnames[ exploder.targetname ] ) )
        {
            ent.v[ "exploder_type" ] = exploder.targetname;
        }
        else
        {
            ent.v[ "exploder_type" ] = "normal";
        }
        
        if ( isdefined( exploder.masked_exploder ) )
        {
            ent.v[ "masked_exploder" ] = exploder.model;
            ent.v[ "masked_exploder_spawnflags" ] = exploder.spawnflags;
            ent.v[ "masked_exploder_script_disconnectpaths" ] = exploder.script_disconnectpaths;
            exploder delete();
        }
        
        ent createfx::post_entity_creation_function();
        explodername = ent.v[ "exploder" ];
        
        if ( !isdefined( level.exploders[ explodername ] ) )
        {
            level.exploders[ explodername ] = [];
        }
        
        level.exploders[ explodername ][ level.exploders[ explodername ].size ] = ent;
    }
    
    level.init_exploders = undefined;
    
    /#
        level thread function_37d17d889197cbf9();
    #/
}

// Namespace exploder
// Params 2
// Checksum 0xc446df1d, Offset: 0xe52
// Size: 0x116
function exploder_flag_wait( msg, exploderarray )
{
    if ( !utility::flag_exist( msg ) )
    {
        utility::flag_init( msg );
    }
    
    utility::flag_wait( msg );
    
    foreach ( exploderstr in exploderarray )
    {
        foreach ( ent in level.createfxexploders[ exploderstr ] )
        {
            ent utility::activate_individual_exploder();
        }
    }
}

// Namespace exploder
// Params 1
// Checksum 0xbf7387d2, Offset: 0xf70
// Size: 0x1d, Type: bool
function exploder_is_damaged_model( ent )
{
    return ent.targetname == "exploder";
}

// Namespace exploder
// Params 1
// Checksum 0xa97f5cfa, Offset: 0xf96
// Size: 0x32, Type: bool
function exploder_starts_hidden( ent )
{
    return ent.model == "fx" && ent.targetname != "exploderchunk";
}

// Namespace exploder
// Params 1
// Checksum 0x88b41211, Offset: 0xfd1
// Size: 0x1d, Type: bool
function exploder_is_chunk( ent )
{
    return ent.targetname == "exploderchunk";
}

// Namespace exploder
// Params 1
// Checksum 0x11588f69, Offset: 0xff7
// Size: 0x11a
function show_exploder_models_proc( num )
{
    num += "";
    exploders = get_exploders();
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( !exploder_starts_hidden( ent.model ) && !exploder_is_damaged_model( ent.model ) && !exploder_is_chunk( ent.model ) )
            {
                ent.model show();
            }
            
            if ( isdefined( ent.brush_shown ) )
            {
                ent.model show();
            }
        }
    }
}

// Namespace exploder
// Params 1
// Checksum 0x7ae5a01a, Offset: 0x1119
// Size: 0xda
function get_exploders( str )
{
    exploders = [];
    
    if ( level.createfx_enabled )
    {
        exploders = get_createfx_exploders( str );
    }
    else if ( isdefined( level.createfxexploders[ str ] ) )
    {
        exploders = level.createfxexploders[ str ];
    }
    
    if ( isdefined( level.exploders[ str ] ) )
    {
        foreach ( exploder in level.exploders[ str ] )
        {
            exploders[ exploders.size ] = exploder;
        }
    }
    
    return exploders;
}

// Namespace exploder
// Params 1
// Checksum 0xaec2d438, Offset: 0x11fc
// Size: 0x106
function get_createfx_exploders( str )
{
    /#
        array = [];
        
        foreach ( ent in level.createfxent )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent.v[ "<dev string:x50>" ] != "<dev string:x55>" )
            {
                continue;
            }
            
            if ( !isdefined( ent.v[ "<dev string:x55>" ] ) )
            {
                continue;
            }
            
            if ( isdefined( str ) && ent.v[ "<dev string:x55>" ] + "<dev string:x5e>" != str )
            {
                continue;
            }
            
            array[ array.size ] = ent;
        }
        
        if ( array.size == 0 )
        {
            array = undefined;
        }
        
        return array;
    #/
}

// Namespace exploder
// Params 5
// Checksum 0x2774962a, Offset: 0x130a
// Size: 0x17e
function stop_exploder_proc( num, players, bkill, radius, origin )
{
    num += "";
    var_2a2d2d350c260c94 = 0;
    exploders = get_exploders( num );
    radiussq = isdefined( radius ) ? squared( radius ) : undefined;
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( !isdefined( ent.looper ) )
            {
                continue;
            }
            
            if ( isdefined( radius ) && distancesquared( ent.origin, origin ) > radiussq )
            {
                continue;
            }
            
            if ( isdefined( ent.loopsound_ent ) )
            {
                ent.loopsound_ent stoploopsound();
                ent.loopsound_ent delete();
            }
            
            ent.looper delete();
            var_2a2d2d350c260c94 = 1;
        }
    }
    
    if ( !shouldrunserversideeffects() && ( havemapentseffects() || !var_2a2d2d350c260c94 ) )
    {
        stop_clientside_exploder( num, players, bkill, radius, origin );
    }
}

// Namespace exploder
// Params 5
// Checksum 0xe16079c, Offset: 0x1490
// Size: 0x85
function stop_clientside_exploder( explodername, players, bkill, radius, origin )
{
    if ( havemapentseffects() )
    {
        stopclientexploder( explodername, players, bkill, radius, origin );
        return;
    }
    
    if ( !is_valid_clientside_exploder_name( explodername ) )
    {
        println( "<dev string:x5f>" + explodername + "<dev string:x79>" );
        return;
    }
    
    exploder_num = int( explodername );
    stopclientexploder( exploder_num, players, bkill, radius, origin );
}

// Namespace exploder
// Params 1
// Checksum 0x3885e93b, Offset: 0x151d
// Size: 0x41
function get_exploder_array_proc( msg )
{
    msg += "";
    array = [];
    exploders = get_exploders( msg );
    
    if ( isdefined( exploders ) )
    {
        array = exploders;
    }
    
    return array;
}

// Namespace exploder
// Params 1
// Checksum 0x97ba41b3, Offset: 0x1567
// Size: 0xcb
function hide_exploder_models_proc( num )
{
    num += "";
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( isdefined( ent.model ) )
            {
                ent.model hide();
            }
        }
    }
}

// Namespace exploder
// Params 1
// Checksum 0x69acd33, Offset: 0x163a
// Size: 0xd6
function delete_exploder_proc( num )
{
    num += "";
    exploders = get_exploders( num );
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isstruct( ent.model ) )
            {
                continue;
            }
            
            if ( isdefined( ent.model ) )
            {
                ent.model delete();
            }
        }
    }
    
    level notify( "killexplodertridgers" + num );
}

// Namespace exploder
// Params 0
// Checksum 0xe4cd0700, Offset: 0x1718
// Size: 0x118
function exploder_damage()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        delay = self.v[ "delay" ];
    }
    else
    {
        delay = 0;
    }
    
    if ( isdefined( self.v[ "damage_radius" ] ) )
    {
        radius = self.v[ "damage_radius" ];
    }
    else
    {
        radius = 128;
    }
    
    damage = self.v[ "damage" ];
    origin = self.v[ "origin" ];
    
    if ( isdefined( self.v[ "envonly" ] ) )
    {
        envonly = self.v[ "envonly" ];
    }
    else
    {
        envonly = 0;
    }
    
    if ( isdefined( self.v[ "dotraces" ] ) )
    {
        dotraces = self.v[ "dotraces" ];
    }
    else
    {
        dotraces = 1;
    }
    
    wait delay;
    radiusdamage( origin, radius, damage, damage, undefined, "MOD_EXPLOSIVE", undefined, envonly, dotraces );
}

// Namespace exploder
// Params 0
// Checksum 0x361ace04, Offset: 0x1838
// Size: 0x16a
function activate_individual_exploder_proc()
{
    if ( isdefined( self.v[ "firefx" ] ) )
    {
        thread fire_effect();
    }
    
    if ( isdefined( self.v[ "fxid" ] ) && self.v[ "fxid" ] != "No FX" )
    {
        thread cannon_effect();
    }
    else if ( isdefined( self.v[ "soundalias" ] ) && self.v[ "soundalias" ] != "nil" )
    {
        thread sound_effect();
    }
    
    if ( isdefined( self.v[ "loopsound" ] ) && self.v[ "loopsound" ] != "nil" )
    {
        thread effect_loopsound();
    }
    
    if ( isdefined( self.v[ "damage" ] ) )
    {
        thread exploder_damage();
    }
    
    if ( isdefined( self.v[ "earthquake" ] ) )
    {
        thread exploder_earthquake();
    }
    
    if ( isdefined( self.v[ "rumble" ] ) )
    {
        thread exploder_rumble();
    }
    
    if ( self.v[ "exploder_type" ] == "exploder" )
    {
        thread brush_show();
        return;
    }
    
    if ( self.v[ "exploder_type" ] == "exploderchunk" || self.v[ "exploder_type" ] == "exploderchunk visible" )
    {
        thread brush_throw();
        return;
    }
    
    thread brush_delete();
}

// Namespace exploder
// Params 0
// Checksum 0x8709b90, Offset: 0x19aa
// Size: 0x154
function brush_delete()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    else
    {
        waitframe();
    }
    
    if ( !isdefined( self.model ) )
    {
        return;
    }
    
    if ( isstruct( self.model ) )
    {
        return;
    }
    
    if ( utility::issp() && isdefined( self.model.classname ) )
    {
        if ( self.model.spawnflags & 1 )
        {
            self.model builtin [[ level.func[ "connectPaths" ] ]]();
        }
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        self.model hide();
        self.model notsolid();
        wait 3;
        self.exploded = undefined;
        self.model show();
        self.model solid();
        return;
    }
    
    if ( !isdefined( self.v[ "fxid" ] ) || self.v[ "fxid" ] == "No FX" )
    {
        self.v[ "exploder" ] = undefined;
    }
    
    waittillframeend();
    self.model delete();
}

// Namespace exploder
// Params 0
// Checksum 0x7e742918, Offset: 0x1b06
// Size: 0x28b
function brush_throw()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    ent = undefined;
    
    if ( isdefined( self.v[ "target" ] ) )
    {
        ent = utility::get_target_ent( self.v[ "target" ] );
    }
    
    if ( !isdefined( ent ) )
    {
        self.model delete();
        return;
    }
    
    self.model show();
    
    if ( isdefined( self.v[ "delay_post" ] ) )
    {
        wait self.v[ "delay_post" ];
    }
    
    startorg = self.v[ "origin" ];
    startang = self.v[ "angles" ];
    org = ent.origin;
    physics = isdefined( self.v[ "physics" ] );
    
    if ( physics )
    {
        target = undefined;
        
        if ( isdefined( ent.target ) )
        {
            target = ent utility::get_target_ent();
        }
        
        if ( isdefined( target ) )
        {
            contact_point = ent.origin;
            throw_vec = vectornormalize( target.origin - ent.origin );
        }
        else
        {
            contact_point = self.model.origin;
            throw_vec = vectornormalize( org - self.model.origin );
        }
        
        throw_vec *= self.v[ "physics" ];
        self.model physicslaunchserver( contact_point, throw_vec );
        return;
    }
    else
    {
        throw_vec = org - self.model.origin;
        self.model rotatevelocity( throw_vec, 12 );
        self.model movegravity( throw_vec, 12 );
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        wait 3;
        self.exploded = undefined;
        self.v[ "origin" ] = startorg;
        self.v[ "angles" ] = startang;
        self.model hide();
        return;
    }
    
    self.v[ "exploder" ] = undefined;
    wait 6;
    self.model delete();
}

// Namespace exploder
// Params 0
// Checksum 0x1b3ee224, Offset: 0x1d99
// Size: 0x1fb
function brush_show()
{
    if ( isdefined( self.v[ "delay" ] ) )
    {
        wait self.v[ "delay" ];
    }
    
    assert( isdefined( self.model ) );
    is_struct = 0;
    structmodel = undefined;
    
    if ( !isdefined( self.model.script_modelname ) )
    {
        self.model show();
        self.model solid();
    }
    else
    {
        is_struct = 1;
        structmodel = spawn( "script_model", self.model.origin );
        structmodel.angles = self.model.angles;
        structmodel setmodel( self.model.script_modelname );
        
        if ( isdefined( self.model.script_linkname ) )
        {
            structmodel.script_linkname = self.model.script_linkname;
        }
    }
    
    self.brush_shown = 1;
    
    if ( !is_struct && utility::issp() && self.model.spawnflags & 1 )
    {
        if ( !isdefined( self.model.disconnect_paths ) )
        {
            self.model builtin [[ level.func[ "connectPaths" ] ]]();
        }
        else
        {
            self.model builtin [[ level.func[ "disconnectPaths" ] ]]();
        }
    }
    
    if ( level.createfx_enabled )
    {
        if ( isdefined( self.exploded ) )
        {
            return;
        }
        
        self.exploded = 1;
        wait 3;
        self.exploded = undefined;
        
        if ( !is_struct )
        {
            self.model hide();
            self.model notsolid();
            return;
        }
        
        structmodel delete();
    }
}

// Namespace exploder
// Params 0
// Checksum 0x4d0eee91, Offset: 0x1f9c
// Size: 0x31
function exploder_rumble()
{
    if ( !utility::issp() )
    {
        return;
    }
    
    exploder_delay();
    level.player playrumbleonentity( self.v[ "rumble" ] );
}

// Namespace exploder
// Params 0
// Checksum 0x57dd1245, Offset: 0x1fd5
// Size: 0xb6
function exploder_delay()
{
    if ( !isdefined( self.v[ "delay" ] ) )
    {
        self.v[ "delay" ] = 0;
    }
    
    min_delay = self.v[ "delay" ];
    max_delay = self.v[ "delay" ] + 0.001;
    
    if ( isdefined( self.v[ "delay_min" ] ) )
    {
        min_delay = self.v[ "delay_min" ];
    }
    
    if ( isdefined( self.v[ "delay_max" ] ) )
    {
        max_delay = self.v[ "delay_max" ];
    }
    
    if ( min_delay > 0 )
    {
        wait randomfloatrange( min_delay, max_delay );
    }
}

// Namespace exploder
// Params 0
// Checksum 0xdc2bba34, Offset: 0x2093
// Size: 0x78
function effect_loopsound()
{
    if ( isdefined( self.loopsound_ent ) )
    {
        self.loopsound_ent stoploopsound();
        self.loopsound_ent delete();
    }
    
    origin = self.v[ "origin" ];
    alias = self.v[ "loopsound" ];
    exploder_delay();
    self.loopsound_ent = utility::play_loopsound_in_space( alias, origin );
}

// Namespace exploder
// Params 0
// Checksum 0xf6d3a37c, Offset: 0x2113
// Size: 0x9
function sound_effect()
{
    effect_soundalias();
}

// Namespace exploder
// Params 0
// Checksum 0x4fcb7fe2, Offset: 0x2124
// Size: 0x47
function effect_soundalias()
{
    origin = self.v[ "origin" ];
    alias = self.v[ "soundalias" ];
    exploder_delay();
    utility::play_sound_in_space( alias, origin );
}

// Namespace exploder
// Params 0
// Checksum 0x17cf881f, Offset: 0x2173
// Size: 0x2e
function exploder_earthquake()
{
    exploder_delay();
    utility::do_earthquake( self.v[ "earthquake" ], self.v[ "origin" ] );
}

// Namespace exploder
// Params 0
// Checksum 0x2a48cb9d, Offset: 0x21a9
// Size: 0x55
function exploder_playsound()
{
    if ( !isdefined( self.v[ "soundalias" ] ) || self.v[ "soundalias" ] == "nil" )
    {
        return;
    }
    
    utility::play_sound_in_space( self.v[ "soundalias" ], self.v[ "origin" ] );
}

// Namespace exploder
// Params 0
// Checksum 0xad6e3aa5, Offset: 0x2206
// Size: 0xe4
function fire_effect()
{
    forward = self.v[ "forward" ];
    up = self.v[ "up" ];
    firefxsound = self.v[ "firefxsound" ];
    origin = self.v[ "origin" ];
    firefx = self.v[ "firefx" ];
    ender = self.v[ "ender" ];
    
    if ( !isdefined( ender ) )
    {
        ender = "createfx_effectStopper";
    }
    
    exploder_delay();
    
    if ( isdefined( firefxsound ) )
    {
        utility::loop_fx_sound( firefxsound, origin, 1, ender );
    }
    
    playfx( level._effect[ firefx ], self.v[ "origin" ], forward, up );
}

// Namespace exploder
// Params 0
// Checksum 0x79162183, Offset: 0x22f2
// Size: 0x11d
function cannon_effect()
{
    if ( isdefined( self.v[ "repeat" ] ) )
    {
        thread exploder_playsound();
        
        for ( i = 0; i < self.v[ "repeat" ] ; i++ )
        {
            playfx( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
            exploder_delay();
        }
        
        return;
    }
    
    exploder_delay();
    
    if ( isdefined( self.looper ) )
    {
        self.looper delete();
    }
    
    self.looper = spawnfx( utility::getfx( self.v[ "fxid" ] ), self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
    triggerfx( self.looper );
    exploder_playsound();
}

/#

    // Namespace exploder
    // Params 0
    // Checksum 0xcf9a345e, Offset: 0x2417
    // Size: 0x195, Type: dev
    function function_37d17d889197cbf9()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level waittill( #"cfx_exploder", origin, delay, damageamount, damageradius, dotraces, envonly, earthquakename, rumblename );
            ent = spawnstruct();
            ent.v = [];
            ent.v[ "<dev string:x55>" ] = 0;
            ent.v[ "<dev string:x9e>" ] = origin;
            ent.v[ "<dev string:xa5>" ] = ( 0, 0, 0 );
            ent.v[ "<dev string:xac>" ] = delay;
            ent.v[ "<dev string:xb6>" ] = damageamount;
            ent.v[ "<dev string:xbd>" ] = damageradius;
            ent.v[ "<dev string:xcb>" ] = dotraces;
            ent.v[ "<dev string:xd4>" ] = envonly;
            ent.v[ "<dev string:xdc>" ] = "<dev string:xea>";
            
            if ( earthquakename.size > 0 )
            {
                ent.v[ "<dev string:xf1>" ] = earthquakename;
            }
            
            if ( rumblename.size > 0 )
            {
                ent.v[ "<dev string:xfc>" ] = rumblename;
            }
            
            ent activate_individual_exploder_proc();
        }
    }

#/

// Namespace exploder
// Params 5
// Checksum 0xf4e6f301, Offset: 0x25b4
// Size: 0x140
function activate_exploder( num, players, starttime, radius, origin )
{
    num += "";
    level notify( "exploding_" + num );
    var_2a2d2d350c260c94 = 0;
    exploders = get_exploders( num );
    radiussq = isdefined( radius ) ? squared( radius ) : undefined;
    
    if ( isdefined( exploders ) )
    {
        foreach ( ent in exploders )
        {
            if ( isdefined( radius ) && distancesquared( ent.origin, origin ) > radiussq )
            {
                continue;
            }
            
            ent utility::activate_individual_exploder();
            var_2a2d2d350c260c94 = 1;
        }
    }
    
    if ( !shouldrunserversideeffects() && ( havemapentseffects() || !var_2a2d2d350c260c94 ) )
    {
        activate_clientside_exploder( num, players, starttime, radius, origin );
    }
}

// Namespace exploder
// Params 5
// Checksum 0x231a199b, Offset: 0x26fc
// Size: 0x87
function activate_clientside_exploder( explodername, players, starttime, radius, origin )
{
    if ( havemapentseffects() )
    {
        activateclientexploder( explodername, players, starttime, 0, radius, origin );
        return;
    }
    
    if ( !is_valid_clientside_exploder_name( explodername ) )
    {
        println( "<dev string:x5f>" + explodername + "<dev string:x79>" );
        return;
    }
    
    exploder_num = int( explodername );
    activateclientexploder( exploder_num, players, starttime, 0, radius, origin );
}

// Namespace exploder
// Params 1
// Checksum 0xf413163b, Offset: 0x278b
// Size: 0x4d, Type: bool
function is_valid_clientside_exploder_name( explodername )
{
    if ( !isdefined( explodername ) )
    {
        return false;
    }
    
    exploder_num = explodername;
    
    if ( isstring( explodername ) )
    {
        exploder_num = int( explodername );
        
        if ( exploder_num == 0 && explodername != "0" )
        {
            return false;
        }
    }
    
    return exploder_num >= 0;
}

// Namespace exploder
// Params 0
// Checksum 0xd70fba2a, Offset: 0x27e1
// Size: 0x4f
function shouldrunserversideeffects()
{
    if ( utility::issp() && !havemapentseffects() )
    {
        return 1;
    }
    
    if ( !isdefined( level.createfx_enabled ) )
    {
        utility::set_createfx_enabled();
    }
    
    if ( level.createfx_enabled )
    {
        return 1;
    }
    
    return getdvarint( @"clientsideeffects" ) != 1;
}

// Namespace exploder
// Params 5
// Checksum 0x6f507c88, Offset: 0x2838
// Size: 0x40
function exploder_before_load( num, players, starttime, radius, origin )
{
    waittillframeend();
    waittillframeend();
    activate_exploder( num, players, starttime, radius, origin );
}

// Namespace exploder
// Params 5
// Checksum 0x5dc568ec, Offset: 0x2880
// Size: 0x3e
function exploder_after_load( num, players, starttime, radius, origin )
{
    activate_exploder( num, players, starttime, radius, origin );
}

