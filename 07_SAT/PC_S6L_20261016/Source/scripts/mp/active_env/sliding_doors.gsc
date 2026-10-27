// scripts\mp\active_env\sliding_doors.gsc  (hash_2f47ba4878416d53.gscc) (size: 8049 Bytes / 0x1f71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f8b3bf (150516671)
// size ...... 8049 (0x1f71)
// includes .. 4   (offset: 0x1dfd)
// strings ... 25  (offset: 0x1e1d)
// dev strs .. 0   (offset: 0x1f71)
// exports ... 16  (offset: 0x15e5)
// cseg ...... 0x1e9 + 0x13fc (0x15e5)
// imports ... 44  (offset: 0x1865)
// animtree1 . 0   (offset: 0x1f71)
// animtree2 . 0   (offset: 0x1f71)
#using scripts\common\active_env\utility;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\interaction;

#namespace sliding_doors;

// Namespace sliding_doors
// Params 0, eflags: 0x1
// Checksum 0xd27d652b, Offset: 0x207
// Size: 0x9a6
function autoexec sliding_door_init()
{
    if ( !isdefined( level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ] ) )
    {
        utility::registersharedfunc( #"hash_c64b9e01025b34ef", #"lock", &function_26b431be5853c306 );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ] ) )
    {
        utility::registersharedfunc( #"hash_c64b9e01025b34ef", #"unlock", &function_ecf3b63a71e432d );
    }
    
    if ( !isdefined( level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"force_open" ] ) )
    {
        utility::registersharedfunc( #"hash_c64b9e01025b34ef", #"force_open", &function_b547c31876d8759a );
    }
    
    scriptable::scriptable_adddamagedcallback( &door_damage );
    utility::flag_wait( "scriptables_ready" );
    var_d45df6ca65893c35 = getnoentvolumearray( "sliding_door", #script_noteworthy );
    level.var_d94fd043f14f11c9 = [];
    
    if ( var_d45df6ca65893c35.size == 0 )
    {
        return;
    }
    
    var_d5369bab24281dd8 = getentitylessscriptablearray( "sliding_door_scriptable", #script_noteworthy );
    
    foreach ( t_sliding_door in var_d45df6ca65893c35 )
    {
        t_sliding_door.var_1e0dba55ec4b19c0 = getentitylessscriptablearray( t_sliding_door.target, #targetname );
        var_1e0dba55ec4b19c0 = [];
        
        if ( t_sliding_door.var_1e0dba55ec4b19c0.size > 0 )
        {
            continue;
        }
        
        foreach ( scr_door in var_d5369bab24281dd8 )
        {
            if ( distancesquared( scr_door.origin, t_sliding_door.origin ) < squared( 80 ) )
            {
                var_1e0dba55ec4b19c0[ var_1e0dba55ec4b19c0.size ] = scr_door;
            }
            
            scr_door.trigger = t_sliding_door;
        }
        
        t_sliding_door.var_1e0dba55ec4b19c0 = var_1e0dba55ec4b19c0;
    }
    
    foreach ( t_sliding_door in var_d45df6ca65893c35 )
    {
        if ( isdefined( t_sliding_door.targetname ) )
        {
            if ( !isdefined( level.var_d94fd043f14f11c9[ t_sliding_door.targetname ] ) )
            {
                level.var_d94fd043f14f11c9[ t_sliding_door.targetname ] = [];
            }
            
            level.var_d94fd043f14f11c9[ t_sliding_door.targetname ][ level.var_d94fd043f14f11c9[ t_sliding_door.targetname ].size ] = t_sliding_door;
        }
    }
    
    if ( getdvarint( @"hash_46c249db6bf65fb7", 0 ) )
    {
        foreach ( t_sliding_door in var_d45df6ca65893c35 )
        {
            foreach ( scr_door in t_sliding_door.var_1e0dba55ec4b19c0 )
            {
                scr_door setscriptablepartstate( #"door", #"opening" );
            }
        }
        
        return;
    }
    
    var_1729009e7cfcada = level.mapname;
    var_434a34eafd761003 = [];
    
    if ( var_1729009e7cfcada == "mp_sat_the_forge" )
    {
        var_434a34eafd761003 = [ ( -1440, 508, 303 ), ( 241, 738, 367 ), ( -508, -671, 367 ), ( -185, -1049, 303 ), ( 803, 700, 367 ) ];
    }
    else if ( var_1729009e7cfcada == "mp_sat_cortex" )
    {
        var_434a34eafd761003 = [ ( 1520, 256, 111 ), ( 1088, -461, 47 ), ( -704, -68, 175 ) ];
    }
    
    scriptable::scriptable_addnotifycallback( "damaged", &function_2bb9d86728b48873 );
    scriptable::scriptable_addnotifycallback( "open_start", &function_9405a66002601f2c );
    scriptable::scriptable_addnotifycallback( "open_done", &function_9405a66002601f2c );
    scriptable::scriptable_addnotifycallback( "close_start", &function_9405a66002601f2c );
    scriptable::scriptable_addnotifycallback( "close_done", &function_9405a66002601f2c );
    
    foreach ( t_sliding_door in var_d45df6ca65893c35 )
    {
        foreach ( v_door_origin in var_434a34eafd761003 )
        {
            b_force_open = t_sliding_door.origin == v_door_origin;
            
            if ( b_force_open )
            {
                t_sliding_door.script_parameters = "force_open";
                
                foreach ( scr_door in t_sliding_door.var_1e0dba55ec4b19c0 )
                {
                    scr_door setscriptablepartstate( #"door", #"opening" );
                }
                
                break;
            }
        }
        
        if ( t_sliding_door.script_parameters == "force_open" )
        {
            continue;
        }
        
        foreach ( scr_door in t_sliding_door.var_1e0dba55ec4b19c0 )
        {
            scr_door.t_crush_zone = getnoentvolumearray( scr_door.target, #targetname )[ 0 ];
            utility::function_9fc28d50a2652cd7( scr_door.t_crush_zone );
            scr_door.sliding_door = t_sliding_door;
        }
        
        if ( t_sliding_door.script_parameters )
        {
            function_5f3c31c343ded7a( t_sliding_door.targetname, t_sliding_door.script_parameters );
        }
        
        if ( getdvarint( @"hash_bdfa80b372a84b1a", 0 ) )
        {
            t_player_trigger = spawn( "trigger_box", t_sliding_door.origin, 0, ( 55, 150, 55 ), ( 55, 150, 55 ) );
            
            if ( t_sliding_door.var_1e0dba55ec4b19c0.size > 0 )
            {
                t_player_trigger.angles = t_sliding_door.var_1e0dba55ec4b19c0[ 0 ].angles;
            }
            
            t_player_trigger thread function_22b0d22886a21f18( t_sliding_door );
        }
        
        /#
            if ( getdvarint( @"hash_78c682fe0f4ae1c", 0 ) )
            {
                if ( isdefined( t_player_trigger ) )
                {
                    level thread debug_draw_trigger( t_player_trigger );
                }
                
                level thread debug_draw_trigger( t_sliding_door, ( 1, 0, 0 ) );
            }
        #/
        
        t_sliding_door thread sliding_door_controller( t_sliding_door.var_1e0dba55ec4b19c0 );
    }
    
    level.sliding_door_lights = [];
    sliding_door_lights = getentitylessscriptablearray( "sliding_door_light", #script_noteworthy );
    
    foreach ( sliding_door_light in sliding_door_lights )
    {
        if ( level.var_d94fd043f14f11c9[ sliding_door_light.targetname ] )
        {
            if ( !level.sliding_door_lights[ sliding_door_light.targetname ] )
            {
                level.sliding_door_lights[ sliding_door_light.targetname ] = [];
            }
            
            level.sliding_door_lights[ sliding_door_light.targetname ][ level.sliding_door_lights[ sliding_door_light.targetname ].size ] = sliding_door_light;
        }
    }
    
    utility::flag_set( "sliding_doors_ready" );
}

// Namespace sliding_doors
// Params 2, eflags: 0x4
// Checksum 0xec6dbc2f, Offset: 0xbb5
// Size: 0x6e
function private function_5f3c31c343ded7a( targetname, state )
{
    switch ( state )
    {
        case #"hash_7dca1839ef64aba2":
            function_26b431be5853c306( targetname );
            return;
        case #"hash_a09b9dbf8f88f4b5":
            function_ecf3b63a71e432d( targetname );
            return;
        case #"hash_43753b487c95ad4d":
            function_b547c31876d8759a( targetname );
            return;
        default:
            return;
    }
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0xdeb580b9, Offset: 0xc2b
// Size: 0x13c
function private function_26b431be5853c306( targetname )
{
    t_sliding_doors = level.var_d94fd043f14f11c9[ targetname ];
    
    foreach ( t_sliding_door in t_sliding_doors )
    {
        t_sliding_door.is_locked = 1;
        function_45fa1c4fc76d14c7( t_sliding_door );
        
        foreach ( scr_door in t_sliding_door.var_1e0dba55ec4b19c0 )
        {
            scr_door setscriptablepartstate( "door", "locked", 0 );
            scr_door interaction::function_303bcca6287d3d71( &function_d7d6328b415e1ed4 );
        }
    }
    
    function_1dc078bb4c024e35( targetname, 0 );
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0x4c60f81c, Offset: 0xd6f
// Size: 0xac
function private function_ecf3b63a71e432d( targetname )
{
    t_sliding_doors = level.var_d94fd043f14f11c9[ targetname ];
    
    foreach ( t_sliding_door in t_sliding_doors )
    {
        t_sliding_door.is_locked = 0;
        function_6435703353d1ef0d( t_sliding_door );
    }
    
    function_1dc078bb4c024e35( targetname, 1 );
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0xe1dba6b6, Offset: 0xe23
// Size: 0x164
function private function_b547c31876d8759a( targetname )
{
    utility::flag_wait( "sliding_doors_ready" );
    function_ecf3b63a71e432d( targetname );
    t_sliding_doors = level.var_d94fd043f14f11c9[ targetname ];
    
    foreach ( t_sliding_door in t_sliding_doors )
    {
        t_sliding_door notify( #"hash_13d32ec7656b9bf6" );
        var_1e0dba55ec4b19c0 = getentitylessscriptablearray( t_sliding_door.target, #targetname );
        
        foreach ( scr_door in var_1e0dba55ec4b19c0 )
        {
            scr_door setscriptablepartstate( "door", "opening" );
            utility::function_3fcc72db54ef9ce( scr_door.t_crush_zone );
        }
    }
    
    function_1dc078bb4c024e35( targetname, 1 );
}

// Namespace sliding_doors
// Params 2, eflags: 0x4
// Checksum 0xc961a5d2, Offset: 0xf8f
// Size: 0xb2
function private function_1dc078bb4c024e35( targetname, is_unlock )
{
    sliding_door_lights = level.sliding_door_lights[ targetname ];
    
    foreach ( sliding_door_light in sliding_door_lights )
    {
        sliding_door_light setscriptablepartstate( "base", is_unlock ? "unlocked" : "locked" );
    }
}

// Namespace sliding_doors
// Params 2, eflags: 0x4
// Checksum 0x20c5d531, Offset: 0x1049
// Size: 0x16, Type: bool
function private function_d7d6328b415e1ed4( scriptable, player )
{
    return false;
}

// Namespace sliding_doors
// Params 4, eflags: 0x4
// Checksum 0x8744daaa, Offset: 0x1068
// Size: 0x71
function private function_9405a66002601f2c( e_instance, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    t_sliding_door = e_instance.t_sliding_door;
    
    if ( !isdefined( t_sliding_door ) )
    {
        [ t_sliding_door ] = getnoentvolumearray( e_instance.targetname, #target );
    }
    
    t_sliding_door notify( var_fbe21110104b5926 );
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0xb0c60923, Offset: 0x10e1
// Size: 0x51
function private function_22b0d22886a21f18( t_sliding_door )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        
        if ( isplayer( e_ent ) )
        {
            t_sliding_door notify( #"trigger", e_ent );
        }
    }
}

// Namespace sliding_doors
// Params 11, eflags: 0x4
// Checksum 0x90a4297, Offset: 0x113a
// Size: 0x95
function private door_damage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !instance || !instance.sliding_door )
    {
        return;
    }
    
    instance.sliding_door notify( #"trigger", eattacker );
}

/#

    // Namespace sliding_doors
    // Params 2, eflags: 0x4
    // Checksum 0x8908c5ce, Offset: 0x11d7
    // Size: 0x3d, Type: dev
    function private debug_draw_trigger( trigger, var_c9e35826ee79c05c )
    {
        if ( !isdefined( var_c9e35826ee79c05c ) )
        {
            var_c9e35826ee79c05c = undefined;
        }
        
        level endon( #"game_ended" );
        
        while ( true )
        {
            drawtrigger( trigger, var_c9e35826ee79c05c );
            waitframe();
        }
    }

#/

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0x81bcdc8d, Offset: 0x121c
// Size: 0x2bd
function private sliding_door_controller( var_1e0dba55ec4b19c0 )
{
    level endon( #"game_ended" );
    self endon( #"hash_13d32ec7656b9bf6" );
    
    if ( !isdefined( level.var_5ac924e35a6a476 ) )
    {
        level.var_5ac924e35a6a476 = getdvarfloat( @"hash_cc46bbc4fd08ba03", 4 );
    }
    
    var_8255db5d59759736 = getdvarint( @"hash_a02b98503996cbea", 0 ) == 1;
    
    if ( getmatchrulesdata( "commonOption", "forceOpenAutomaticDoors" ) || var_8255db5d59759736 )
    {
        foreach ( scr_door in var_1e0dba55ec4b19c0 )
        {
            scr_door setscriptablepartstate( "door", "opening" );
            utility::function_3fcc72db54ef9ce( scr_door.t_crush_zone );
        }
        
        return;
    }
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        
        if ( level.var_9832249e364674b6 && !isplayer( e_ent ) )
        {
            continue;
        }
        
        if ( self.is_locked )
        {
            continue;
        }
        
        foreach ( scr_door in var_1e0dba55ec4b19c0 )
        {
            scr_door setscriptablepartstate( "door", "opening" );
            utility::function_3fcc72db54ef9ce( scr_door.t_crush_zone );
        }
        
        self waittill( #"open_done" );
        n_delay = level.var_5ac924e35a6a476;
        
        while ( n_delay > 0 )
        {
            var_5a1c0f3d18fe810f = utility::waittill_any_timeout( 0.5, "trigger" );
            
            if ( var_5a1c0f3d18fe810f == "trigger" )
            {
                n_delay = level.var_5ac924e35a6a476;
                continue;
            }
            
            n_delay -= 0.5;
        }
        
        foreach ( scr_door in var_1e0dba55ec4b19c0 )
        {
            scr_door setscriptablepartstate( "door", "closing" );
            utility::function_3fcc72db54ef9ce( scr_door.t_crush_zone );
        }
    }
}

// Namespace sliding_doors
// Params 4, eflags: 0x4
// Checksum 0x2e23111f, Offset: 0x14e1
// Size: 0x78
function private function_2bb9d86728b48873( e_instance, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    [ t_sliding_door ] = getnoentvolumearray( e_instance.targetname, #target );
    t_sliding_door notify( #"trigger", var_533710b0b76c405a );
    e_instance setscriptablepartstate( "damage_listener", "idle" );
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0xedfb86, Offset: 0x1561
// Size: 0x47
function private function_45fa1c4fc76d14c7( t_sliding_door )
{
    if ( !t_sliding_door.nav_obstacle_id )
    {
        t_sliding_door.nav_obstacle_id = createnavobstaclebybounds( t_sliding_door.origin, t_sliding_door getboundshalfsize(), t_sliding_door.angles );
    }
}

// Namespace sliding_doors
// Params 1, eflags: 0x4
// Checksum 0x5683c1bf, Offset: 0x15b0
// Size: 0x35
function private function_6435703353d1ef0d( t_sliding_door )
{
    if ( t_sliding_door.nav_obstacle_id )
    {
        destroynavobstacle( t_sliding_door.nav_obstacle_id );
        t_sliding_door.nav_obstacle_id = undefined;
    }
}

