// scripts\common\lighting.gsc  (hash_4a2ee8c6e0ebf192.gscc) (size: 53017 Bytes / 0xcf19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe69092a (3194554666)
// size ...... 53017 (0xcf19)
// includes .. 5   (offset: 0xc7a9)
// strings ... 70  (offset: 0xc7d1)
// dev strs .. 44  (offset: 0xccad)
// exports ... 137 (offset: 0x93a5)
// cseg ...... 0x44e + 0x8f57 (0x93a5)
// imports ... 199 (offset: 0xa90d)
// animtree1 . 0   (offset: 0xcf19)
// animtree2 . 0   (offset: 0xcf19)
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace lighting;

// Namespace lighting
// Params 0, eflags: 0x5
// Checksum 0x50517b5b, Offset: 0x46c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"general_lighting", undefined, undefined, &init );
}

// Namespace lighting
// Params 0, eflags: 0x4
// Checksum 0x563a8524, Offset: 0x48d
// Size: 0xc
function private init()
{
    /#
        function_f0ca62c2263b30cf();
    #/
}

// Namespace lighting
// Params 0
// Checksum 0xb8aecdb9, Offset: 0x4a1
// Size: 0x42
function is_light()
{
    if ( self.classname == "light" || self.classname == "light_omni" || self.classname == "light_spot" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace lighting
// Params 2
// Checksum 0x1711a394, Offset: 0x4eb
// Size: 0x94
function function_a6b7ccf4c5f2d94a( time, endintensity )
{
    self notify( #"hash_d04ebaa9a4e368fd" );
    self endon( #"hash_d04ebaa9a4e368fd" );
    self endon( #"death" );
    startintensity = self getlightintensity();
    wait 0.05;
    t = 0.05;
    
    while ( t <= time )
    {
        self setlightintensity( math::lerp( startintensity, endintensity, t / time ) );
        wait 0.05;
        t += 0.05;
    }
    
    self setlightintensity( endintensity );
}

// Namespace lighting
// Params 3
// Checksum 0x5a1ba11d, Offset: 0x587
// Size: 0x101
function toggle_light( targetname, state, override_intensity )
{
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    lights = arraycombine( ents1, ents2 );
    
    if ( !isdefined( lights ) || lights.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < lights.size ; i++ )
    {
        light = lights[ i ];
        
        if ( !isdefined( light.original_intensity ) )
        {
            light.original_intensity = light getlightintensity();
        }
        
        if ( state == 1 || state == 1 )
        {
            if ( isdefined( override_intensity ) )
            {
                intensity = override_intensity;
            }
            else
            {
                intensity = light.original_intensity;
            }
            
            light setlightintensity( intensity );
            continue;
        }
        
        light setlightintensity( 0 );
    }
}

// Namespace lighting
// Params 2
// Checksum 0x7604656f, Offset: 0x690
// Size: 0x92
function function_76e2f751f20e7dd8( time, endcolor )
{
    self notify( #"hash_283ccf38730a7daf" );
    self endon( #"hash_283ccf38730a7daf" );
    self endon( #"death" );
    startcolor = self getlightcolor();
    wait 0.05;
    t = 0.05;
    
    while ( t <= time )
    {
        self setlightcolor( vectorlerp( startcolor, endcolor, t / time ) );
        wait 0.05;
        t += 0.05;
    }
    
    self setlightcolor( endcolor );
}

// Namespace lighting
// Params 2
// Checksum 0xbde54b19, Offset: 0x72a
// Size: 0x94
function function_2fb063a6856cba93( time, endradius )
{
    self notify( #"hash_212f5afddbd592ee" );
    self endon( #"hash_212f5afddbd592ee" );
    self endon( #"death" );
    startradius = self getlightradius();
    wait 0.05;
    t = 0.05;
    
    while ( t <= time )
    {
        self setlightradius( math::lerp( startradius, endradius, t / time ) );
        wait 0.05;
        t += 0.05;
    }
    
    self setlightradius( endradius );
}

// Namespace lighting
// Params 0, eflags: 0x4
// Checksum 0x4503d35c, Offset: 0x7c6
// Size: 0x15
function private function_260a6b56a17548d4()
{
    if ( !level.var_13870a9c1fece6 )
    {
        self dontinterpolate();
    }
}

// Namespace lighting
// Params 13
// Checksum 0x93a1c4f1, Offset: 0x7e3
// Size: 0x3a5
function flicker_light( min_delay, max_delay, flicker_min_scale, flicker_max_scale, min_time, max_time, lerp_amount, min_num, max_num, min_pause, max_pause, pause_scale, intensity )
{
    if ( !isdefined( self.var_f68315892787643e ) )
    {
        self.var_f68315892787643e = 1;
    }
    
    if ( !isdefined( self.var_a103472cf4c39a00 ) )
    {
        self.var_a103472cf4c39a00 = 0;
    }
    
    self endon( #"kill_flicker" );
    self endon( #"death" );
    
    if ( !isdefined( min_delay ) )
    {
        min_delay = 0.1;
    }
    
    if ( !isdefined( max_delay ) )
    {
        max_delay = 1;
    }
    
    if ( !isdefined( flicker_min_scale ) )
    {
        flicker_min_scale = 0;
    }
    
    if ( !isdefined( flicker_max_scale ) )
    {
        flicker_max_scale = 0.5;
    }
    
    if ( !isdefined( min_time ) )
    {
        min_time = 0.1;
    }
    
    if ( !isdefined( max_time ) )
    {
        max_time = 0.2;
    }
    
    if ( !isdefined( lerp_amount ) )
    {
        lerp_amount = 0;
    }
    
    if ( !isdefined( min_num ) )
    {
        min_num = 1;
    }
    
    if ( !isdefined( max_num ) )
    {
        max_num = 1;
    }
    
    if ( !isdefined( min_pause ) )
    {
        min_pause = 0;
    }
    
    if ( !isdefined( max_pause ) )
    {
        max_pause = 0;
    }
    
    if ( !isdefined( pause_scale ) )
    {
        pause_scale = 1;
    }
    
    if ( isdefined( intensity ) )
    {
        self setlightintensity( intensity );
    }
    else
    {
        intensity = self getlightintensity();
    }
    
    min_intensity = intensity * flicker_min_scale;
    max_intensity = intensity * flicker_max_scale;
    
    if ( min_num < max_num )
    {
        num_flicker = randomintrange( min_num, max_num );
    }
    else
    {
        num_flicker = max_num;
    }
    
    if ( min_pause < max_pause )
    {
        pause_time = randomfloatrange( min_pause, max_pause );
    }
    else
    {
        pause_time = max_pause;
    }
    
    for ( ;; )
    {
        for ( z = 0; z < num_flicker ; z++ )
        {
            if ( min_intensity < max_intensity )
            {
                flicker_intensity = randomfloatrange( min_intensity, max_intensity );
            }
            else
            {
                flicker_intensity = max_intensity;
            }
            
            if ( min_delay < max_delay )
            {
                d_time = randomfloatrange( min_delay, max_delay );
            }
            else
            {
                d_time = max_delay;
            }
            
            if ( min_time < max_time )
            {
                f_time = randomfloatrange( min_time, max_time );
            }
            else
            {
                f_time = max_time;
            }
            
            while ( self.var_a103472cf4c39a00 )
            {
                wait 0.05;
            }
            
            if ( lerp_amount > 0 && lerp_amount <= 1 )
            {
                if ( d_time > 0 )
                {
                    l_time = f_time / 2 * lerp_amount;
                    t = 0;
                    
                    while ( t <= l_time )
                    {
                        self setlightintensity( math::lerp( intensity, flicker_intensity, t / l_time ) );
                        wait 0.05;
                        t += 0.05;
                    }
                    
                    self setlightintensity( flicker_intensity );
                    wait f_time - f_time * lerp_amount;
                    t = 0;
                    
                    while ( t <= l_time )
                    {
                        self setlightintensity( math::lerp( flicker_intensity, intensity, t / l_time ) );
                        wait 0.05;
                        t += 0.05;
                    }
                    
                    self setlightintensity( intensity );
                }
                else
                {
                    l_time = f_time * lerp_amount;
                    t = 0;
                    
                    while ( t <= l_time )
                    {
                        self setlightintensity( math::lerp( intensity, flicker_intensity, t / l_time ) );
                        wait 0.05;
                        t += 0.05;
                    }
                    
                    self setlightintensity( flicker_intensity );
                    wait f_time - f_time * lerp_amount;
                }
            }
            else
            {
                self setlightintensity( flicker_intensity );
                wait f_time;
                self setlightintensity( intensity );
            }
            
            wait d_time;
        }
        
        self setlightintensity( intensity * pause_scale );
        
        if ( min_pause < max_pause )
        {
            pause_time = randomfloatrange( min_pause, max_pause );
        }
        else
        {
            pause_time = max_pause;
        }
        
        t = 0;
        
        while ( t < pause_time )
        {
            while ( self.var_a103472cf4c39a00 )
            {
                wait 0.05;
            }
            
            wait 0.05;
            t += 0.05;
        }
        
        if ( min_num < max_num )
        {
            num_flicker = randomintrange( min_num, max_num );
            continue;
        }
        
        num_flicker = max_num;
    }
}

// Namespace lighting
// Params 6
// Checksum 0x507d84a3, Offset: 0xb90
// Size: 0x162
function fire_flicker_light( min_time, max_time, flicker_min_scale, flicker_max_scale, max_move, intensity )
{
    self endon( #"kill_flicker" );
    self endon( #"death" );
    
    if ( !isdefined( flicker_min_scale ) )
    {
        flicker_min_scale = 0.6;
    }
    
    if ( !isdefined( flicker_max_scale ) )
    {
        flicker_max_scale = 1.2;
    }
    
    if ( !isdefined( min_time ) )
    {
        min_time = 0.2;
    }
    
    if ( !isdefined( max_time ) )
    {
        max_time = 0.8;
    }
    
    if ( !isdefined( max_move ) )
    {
        max_move = 0;
    }
    
    if ( isdefined( intensity ) )
    {
        self setlightintensity( intensity );
    }
    else
    {
        intensity = self getlightintensity();
    }
    
    thread flicker_light( 0, 0, flicker_min_scale, flicker_max_scale, min_time, max_time, 0.5, undefined, undefined, undefined, undefined, undefined, intensity );
    
    if ( max_move > 0 )
    {
        start_origin = self.origin;
        
        while ( true )
        {
            x = start_origin[ 0 ] + randomfloatrange( 0 - max_move, max_move );
            y = start_origin[ 1 ] + randomfloatrange( 0 - max_move, max_move );
            z = start_origin[ 2 ] + randomfloatrange( 0 - max_move, max_move );
            move_time = randomfloatrange( 0.1, 0.5 );
            self moveto( ( x, y, z ), move_time, move_time * 0.25, move_time * 0.25 );
            wait move_time;
        }
    }
}

// Namespace lighting
// Params 6
// Checksum 0x896d0d4f, Offset: 0xcfa
// Size: 0x96
function blink_light( on_time = 1, off_time = 1, lerp_amount = 0, blink_num = 1, pause = 1, intensity )
{
    if ( isdefined( intensity ) )
    {
        self setlightintensity( intensity );
    }
    else
    {
        intensity = self getlightintensity();
    }
    
    flicker_light( on_time, on_time, 0, 0, off_time, off_time, lerp_amount, blink_num, blink_num, pause, pause, 0, intensity );
}

// Namespace lighting
// Params 0
// Checksum 0xbd73be41, Offset: 0xd98
// Size: 0x32
function light_init()
{
    if ( !isdefined( level._light ) )
    {
        level._light = spawnstruct();
        function_3171dec1082a69a9();
        function_4b86ed1e93f1bd0a();
        light_message_init();
    }
}

// Namespace lighting
// Params 0
// Checksum 0x3064938e, Offset: 0xdd2
// Size: 0x1f6
function function_4b86ed1e93f1bd0a()
{
    function_7874b79f5291a437( "fire", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 8 );
    function_7874b79f5291a437( "blue_fire", ( 0.445098, 0.62451, 0.972549 ), ( 0.05, 0.150451, 0.307843 ), 0.005, 0.2, 8 );
    function_7874b79f5291a437( "white_fire", ( 0.972549, 0.972549, 0.972549 ), ( 0.2, 0.2, 0.2 ), 0.005, 0.2, 8 );
    function_7874b79f5291a437( "white_fire_dim", ( 0.972549, 0.972549, 0.972549 ), ( 0.2, 0.2, 0.2 ), 0.005, 0.2, 0.5 );
    function_7874b79f5291a437( "street_light", ( 0.972549, 0.972549, 0.972549 ), ( 0.572549, 0.572549, 0.572549 ), 0.005, 0.2, 8 );
    function_7874b79f5291a437( "pulse", ( 0, 0, 0 ), ( 255, 107, 107 ), 0.2, 1, 8 );
    function_7874b79f5291a437( "lightbulb", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 6 );
    function_7874b79f5291a437( "fluorescent", ( 0.972549, 0.62451, 0.345098 ), ( 0.2, 0.146275, 0.0878432 ), 0.005, 0.2, 7 );
    function_7874b79f5291a437( "static_screen", ( 0.63, 0.72, 0.92 ), ( 0.4, 0.43, 0.48 ), 0.005, 0.2, 7 );
    function_7874b79f5291a437( "sfb_fire", ( 1, 0.65, 0.8 ), ( 0.4, 0.24, 0.3 ), 0.005, 0.2, 8 );
}

// Namespace lighting
// Params 7
// Checksum 0x401427d7, Offset: 0xfd0
// Size: 0xe9
function function_7874b79f5291a437( name, color0, color1, intensity, mindelay, maxdelay, maxmove )
{
    if ( !isdefined( level._light.var_432d031ce205b392 ) )
    {
        level._light.var_432d031ce205b392 = [];
    }
    
    new_preset = spawnstruct();
    new_preset.color0 = color0;
    new_preset.color1 = color1;
    new_preset.intensity = intensity;
    new_preset.mindelay = mindelay;
    new_preset.maxdelay = maxdelay;
    new_preset.maxmove = maxmove;
    level._light.var_432d031ce205b392[ name ] = new_preset;
}

// Namespace lighting
// Params 1
// Checksum 0x9a0b26f4, Offset: 0x10c1
// Size: 0x3d
function function_73d685ebeab523a8( name )
{
    if ( isdefined( level._light.var_432d031ce205b392[ name ] ) )
    {
        return level._light.var_432d031ce205b392[ name ];
    }
}

// Namespace lighting
// Params 8
// Checksum 0x220e9dd, Offset: 0x1107
// Size: 0x2c4
function function_31f8b86cd078c261( name, targetname, intensity, sync_group_name, var_391722422605ebed, var_18cab5e5f877ec62, lerptime, flickerpercentage )
{
    assert( isstring( name ) );
    assert( isstring( targetname ) );
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    if ( ents.size == 0 )
    {
        println( "<dev string:x24>" + name + "<dev string:x5f>" + targetname + "<dev string:xa1>" );
        return;
    }
    
    preset = function_73d685ebeab523a8( name );
    
    if ( !isdefined( preset ) )
    {
        println( "<dev string:xa4>" + name + "<dev string:xce>" );
        return;
    }
    
    if ( isdefined( intensity ) )
    {
        if ( intensity < 0 )
        {
            println( "<dev string:x11e>" + name + "<dev string:x13c>" );
            intensity = 0;
        }
        
        preset.intensity = intensity;
    }
    
    foreach ( ent in ents )
    {
        ent setlightintensity( preset.intensity );
        ent.var_f68315892787643e = 1;
        ent.var_a103472cf4c39a00 = 0;
        
        if ( var_391722422605ebed )
        {
            ent.var_8fc0e8bf87d21aa0 = intensity;
            ent thread function_9fc1707723ea7b31( preset.color0, preset.color1, preset.intensity, preset.mindelay, preset.maxdelay, preset.maxmove, sync_group_name );
            ent.var_937d151cad5a3560 = var_391722422605ebed;
            
            if ( var_18cab5e5f877ec62 )
            {
                thread function_5679735ccadcec95( ent, lerptime, 0, intensity, flickerpercentage );
            }
        }
        else
        {
            ent thread function_9fc1707723ea7b31( preset.color0, preset.color1, preset.intensity, preset.mindelay, preset.maxdelay, preset.maxmove, sync_group_name );
            ent.var_937d151cad5a3560 = undefined;
            
            if ( var_18cab5e5f877ec62 )
            {
                thread function_5679735ccadcec95( ent, lerptime, 0, intensity, flickerpercentage );
            }
        }
        
        ent function_260a6b56a17548d4();
    }
}

// Namespace lighting
// Params 6
// Checksum 0x3cfdc0be, Offset: 0x13d3
// Size: 0x180
function function_1cc3f3dfbd18b343( name, targetname, intensity, lerptime, flickerpercentage, var_6d60a1113c26f552 )
{
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    if ( ents.size == 0 )
    {
        return;
    }
    
    foreach ( ent in ents )
    {
        if ( !isdefined( ent.var_f68315892787643e ) )
        {
            return;
        }
        
        if ( isdefined( var_6d60a1113c26f552 ) )
        {
            intensity = var_6d60a1113c26f552;
            thread function_5679735ccadcec95( ent, lerptime, ent getlightintensity(), intensity, flickerpercentage );
            thread function_d407fc387bc9d503( ent, lerptime );
        }
        else if ( lerptime > 0 )
        {
            thread lerp_spot_intensity_manage( ent, lerptime, intensity, flickerpercentage );
            thread function_d407fc387bc9d503( ent, lerptime );
        }
        else
        {
            ent setlightintensity( intensity );
            ent notify( #"kill_flicker" );
            ent.var_f68315892787643e = 0;
        }
        
        if ( ( lerptime ?? 0 ) <= 0 )
        {
            ent function_260a6b56a17548d4();
        }
    }
}

// Namespace lighting
// Params 5
// Checksum 0x924f2261, Offset: 0x155b
// Size: 0x11e
function function_5679735ccadcec95( ent, lerptime, startintensity, targetintensity, flickerpercentage )
{
    assert( isdefined( ent ) );
    assert( isdefined( lerptime ) );
    assert( isdefined( targetintensity ) );
    assert( isdefined( startintensity ) );
    assert( isdefined( flickerpercentage ) );
    
    if ( startintensity == targetintensity )
    {
        return;
    }
    
    t = 0;
    
    while ( t < lerptime )
    {
        baseintensity = startintensity + ( targetintensity - startintensity ) * t / lerptime;
        flickeroffset = ( randomfloat( 1 ) - 0.5 ) * 2 * flickerpercentage;
        adjustedintensity = baseintensity * ( 1 + flickeroffset );
        adjustedintensity = max( 0, adjustedintensity );
        ent.var_8fc0e8bf87d21aa0 = adjustedintensity;
        ent setlightintensity( ent.var_8fc0e8bf87d21aa0 );
        t += 0.05;
        wait 0.05;
    }
    
    ent setlightintensity( targetintensity );
    ent.var_8fc0e8bf87d21aa0 = targetintensity;
}

// Namespace lighting
// Params 2
// Checksum 0xf777b265, Offset: 0x1681
// Size: 0x32
function function_d407fc387bc9d503( ent, delay )
{
    wait delay;
    ent notify( #"kill_flicker" );
    ent.var_f68315892787643e = 0;
}

// Namespace lighting
// Params 5
// Checksum 0x33687c44, Offset: 0x16bb
// Size: 0x40
function function_e403cbd4c8c0a503( ent, delay, var_4deaafe5ff54ddab, var_2bb9dde0d94f96db, flickerpercentage )
{
    wait delay;
    lerp_spot_intensity_manage( ent, var_2bb9dde0d94f96db, var_4deaafe5ff54ddab, flickerpercentage );
}

// Namespace lighting
// Params 4
// Checksum 0x58e59079, Offset: 0x1703
// Size: 0xe9
function lerp_spot_intensity( targetname, time, endintensity, flickerpercentage )
{
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    if ( ents.size == 0 )
    {
        return;
    }
    
    foreach ( ent in ents )
    {
        thread lerp_spot_intensity_manage( ent, time, endintensity, flickerpercentage );
    }
}

// Namespace lighting
// Params 4
// Checksum 0x74d2ff08, Offset: 0x17f4
// Size: 0x22b
function lerp_spot_intensity_manage( ent, time, endintensity, flickerpercentage )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    ent notify( #"kill_lerp_spot_intensity_manage" );
    ent endon( #"kill_lerp_spot_intensity_manage" );
    ent endon( #"death" );
    startintensity = ent getlightintensity();
    ent.endintensity = endintensity;
    t = 0;
    
    if ( isdefined( flickerpercentage ) )
    {
        while ( t < time )
        {
            base_intensity = startintensity + ( endintensity - startintensity ) * t / time;
            flicker_strength = 1 - t / time;
            flicker = ( randomfloat( 1 ) - 0.5 ) * 2 * flickerpercentage * flicker_strength;
            new_intensity = base_intensity + flicker;
            t += 0.05;
            ent setlightintensity( new_intensity );
            lerp_spot_intensity_manage_target( ent, new_intensity );
            wait 0.05;
        }
    }
    else
    {
        while ( t < time )
        {
            new_intensity = startintensity + ( endintensity - startintensity ) * t / time;
            t += 0.05;
            ent setlightintensity( new_intensity );
            lerp_spot_intensity_manage_target( ent, new_intensity );
            wait 0.05;
        }
    }
    
    ent setlightintensity( endintensity );
    
    if ( time <= 0 )
    {
        ent function_260a6b56a17548d4();
    }
    
    if ( isdefined( ent.target ) )
    {
        otherlights = getentarray( ent.target, #targetname );
        
        foreach ( otherlight in otherlights )
        {
            if ( isdefined( otherlight ) && otherlight.classname == "light" )
            {
                otherlight setlightintensity( endintensity );
                
                if ( time <= 0 )
                {
                    otherlight function_260a6b56a17548d4();
                }
            }
        }
    }
}

// Namespace lighting
// Params 2
// Checksum 0x1d556bc8, Offset: 0x1a27
// Size: 0xd2
function lerp_spot_intensity_manage_target( ent, new_intensity )
{
    if ( isdefined( ent.target ) )
    {
        otherlights = getentarray( ent.target, #targetname );
        
        foreach ( otherlight in otherlights )
        {
            if ( isdefined( otherlight ) && otherlight.classname == "light" )
            {
                otherlight setlightintensity( new_intensity );
            }
        }
    }
}

// Namespace lighting
// Params 3, eflags: 0x4
// Checksum 0x5fb32644, Offset: 0x1b01
// Size: 0x11f
function private function_47885fe894e92e34( sync_group_name, min_delay, max_delay )
{
    if ( !isdefined( level._light.var_116c1d4bcc866922 ) )
    {
        level._light.var_116c1d4bcc866922 = [];
    }
    
    if ( !isdefined( level._light.var_116c1d4bcc866922[ sync_group_name ] ) )
    {
        level._light.var_116c1d4bcc866922[ sync_group_name ] = [];
        level._light.var_116c1d4bcc866922[ sync_group_name ][ "time" ] = 0;
    }
    
    if ( gettime() != level._light.var_116c1d4bcc866922[ sync_group_name ][ "time" ] )
    {
        level._light.var_116c1d4bcc866922[ sync_group_name ][ "time" ] = gettime();
        level._light.var_116c1d4bcc866922[ sync_group_name ][ "delay" ] = randomfloatrange( min_delay, max_delay );
    }
    
    return level._light.var_116c1d4bcc866922[ sync_group_name ][ "delay" ];
}

// Namespace lighting
// Params 7
// Checksum 0x68846f5a, Offset: 0x1c29
// Size: 0x28d
function function_9fc1707723ea7b31( color0, color1, intensity, mindelay, maxdelay, maxmove, sync_group_name )
{
    assert( isdefined( self.var_f68315892787643e ) );
    assert( isdefined( self.var_a103472cf4c39a00 ) );
    self endon( #"kill_flicker" );
    self endon( #"death" );
    thread function_6f912113669218f7();
    
    if ( isdefined( color1 ) )
    {
        tocolor = color0;
    }
    else
    {
        self setlightcolor( color0 );
    }
    
    self setlightintensity( intensity );
    min_delay = mindelay;
    max_delay = maxdelay;
    thread fire_flicker( min_delay, max_delay );
    original_origin = self.origin;
    random_x = maxmove;
    random_y = maxmove;
    random_z = maxmove;
    delay = undefined;
    
    while ( true )
    {
        if ( isdefined( sync_group_name ) )
        {
            delay = function_47885fe894e92e34( sync_group_name, min_delay, max_delay );
        }
        else
        {
            delay = randomfloatrange( min_delay, max_delay );
        }
        
        x = random_x * randomfloatrange( 0.1, 1 );
        y = random_y * randomfloatrange( 0.1, 1 );
        z = random_z * randomfloatrange( 0.1, 1 );
        new_position = original_origin + ( x, y, z );
        self moveto( new_position, delay );
        steps = int( delay / 0.1 );
        
        if ( isdefined( color1 ) )
        {
            for ( i = 1; i <= steps ; i++ )
            {
                tocolor = vectorlerp( color0, color1, delay );
                tocolor = ( max( 0, min( 1, tocolor[ 0 ] ) ), max( 0, min( 1, tocolor[ 1 ] ) ), max( 0, min( 1, tocolor[ 2 ] ) ) );
                self setlightcolor( tocolor );
            }
            
            wait 0.05;
            
            for ( i = steps; i > 0 ; i-- )
            {
                fromcolor = vectorlerp( color1, color0, delay );
                fromcolor = ( max( 0, min( 1, tocolor[ 0 ] ) ), max( 0, min( 1, tocolor[ 1 ] ) ), max( 0, min( 1, tocolor[ 2 ] ) ) );
                self setlightcolor( fromcolor );
            }
            
            wait 0.05;
        }
        
        wait delay;
        
        while ( self.var_a103472cf4c39a00 )
        {
            wait 0.05;
        }
    }
}

// Namespace lighting
// Params 0
// Checksum 0xa0234c3c, Offset: 0x1ebe
// Size: 0x8f
function function_6f912113669218f7()
{
    self waittill( #"hash_a0a5348ddf48e63e" );
    currentintensity = self getlightintensity();
    duration = 2;
    steps = 40;
    steptime = duration / steps;
    
    for ( i = 0; i <= steps ; i++ )
    {
        lerpamount = i / steps;
        newintensity = math::lerp( currentintensity, 0, lerpamount );
        self setlightintensity( newintensity );
        wait steptime;
    }
}

// Namespace lighting
// Params 2
// Checksum 0xe6225c7, Offset: 0x1f55
// Size: 0x128
function fire_flicker( min_delay, max_delay )
{
    assert( isdefined( self.var_f68315892787643e ) );
    assert( isdefined( self.var_a103472cf4c39a00 ) );
    full = self getlightintensity();
    self endon( #"kill_flicker" );
    self endon( #"death" );
    
    for ( old_intensity = full;  ; old_intensity = intensity )
    {
        if ( isdefined( self.var_8fc0e8bf87d21aa0 ) )
        {
            full = self.var_8fc0e8bf87d21aa0;
        }
        
        if ( full == 0 )
        {
            intensity = 0;
        }
        else
        {
            intensity = randomfloatrange( full * 0.4, full * 1.3 );
        }
        
        timer = randomfloatrange( min_delay, max_delay );
        timer *= 0.75;
        
        while ( self.var_a103472cf4c39a00 )
        {
            wait 0.05;
        }
        
        for ( i = 0; i < timer ; i++ )
        {
            new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
            self setlightintensity( new_intensity );
            wait 0.05;
        }
    }
}

// Namespace lighting
// Params 2
// Checksum 0x9ab94a02, Offset: 0x2085
// Size: 0x13e
function create_light_object( script_noteworthy, fxid )
{
    light_object = spawnstruct();
    ents = getentarray( script_noteworthy, #script_noteworthy );
    light_object.lightents = [];
    light_object.modelents = [];
    
    foreach ( ent in ents )
    {
        if ( ent.classname == "script_model" )
        {
            light_object.modelents[ light_object.modelents.size ] = ent;
        }
        
        if ( ent.classname == "light" )
        {
            light_object.lightents[ light_object.lightents.size ] = ent;
        }
    }
    
    light_object.fxid = fxid;
    
    /#
        light_object.is_light_object = 1;
    #/
    
    return light_object;
}

// Namespace lighting
// Params 3
// Checksum 0x172cee16, Offset: 0x21cc
// Size: 0x1f2
function function_ee579d5362fddca9( intensity, color, is_on )
{
    assert( isdefined( self.is_light_object ) );
    
    foreach ( lightent in self.lightents )
    {
        lightent setlightintensity( intensity );
        lightent setlightcolor( color );
    }
    
    if ( is_on && !isdefined( self.was_on ) )
    {
        utility::exploder( self.fxid );
        
        foreach ( modelent in self.modelents )
        {
            modelent show();
        }
        
        self.was_on = 1;
        return;
    }
    
    if ( isdefined( self.was_on ) && !is_on )
    {
        utility::stop_exploder( self.fxid );
        
        foreach ( modelent in self.modelents )
        {
            modelent hide();
        }
        
        self.was_on = undefined;
    }
}

// Namespace lighting
// Params 7
// Checksum 0x5908f53, Offset: 0x23c6
// Size: 0xda
function flickering_light( light_object, off_color, off_intensity, on_color, on_intensity, min_delay, max_delay )
{
    light_object endon( #"kill_flicker" );
    light_object endon( #"death" );
    var_1ff7f980c880803d = 0;
    delay = 0;
    
    for ( ;; )
    {
        var_44056545b976b8f2 = var_1ff7f980c880803d;
        var_1ff7f980c880803d = randomfloat( 1 );
        
        if ( min_delay != max_delay )
        {
            delay += randomfloatrange( min_delay, max_delay );
        }
        else
        {
            delay += max_delay;
        }
        
        if ( delay == 0 )
        {
            delay += 1e-07;
        }
        
        var_b52486af3956beb6 = ( var_1ff7f980c880803d - var_44056545b976b8f2 ) / delay;
        
        while ( delay > 0 )
        {
        }
    }
}

// Namespace lighting
// Params 5
// Checksum 0x43deb307, Offset: 0x24a8
// Size: 0x73
function function_9f6d1c9de971cb7e( light_object, off_color, off_intensity, on_color, on_intensity )
{
    light_object endon( #"kill_flicker" );
    light_object endon( #"death" );
    base_frequency = 2;
    var_f3e10c2e884ac183 = 3;
    var_d6f2592e27b68946 = 5;
    
    for ( ;; )
    {
    }
}

// Namespace lighting
// Params 9
// Checksum 0xe5db56fd, Offset: 0x2523
// Size: 0x117
function function_49062d08e69c35df( name, minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause )
{
    if ( !isdefined( level._light.var_bc1f0a519db3f333 ) )
    {
        level._light.var_bc1f0a519db3f333 = [];
    }
    
    new_preset = spawnstruct();
    new_preset.minintensity = minintensity;
    new_preset.maxintensity = maxintensity;
    new_preset.mindelay = mindelay;
    new_preset.maxdelay = maxdelay;
    new_preset.minflicker = minflicker;
    new_preset.maxflicker = maxflicker;
    new_preset.minpause = minpause;
    new_preset.maxpause = maxpause;
    level._light.var_bc1f0a519db3f333[ name ] = new_preset;
}

// Namespace lighting
// Params 1
// Checksum 0xc6d5cb9b, Offset: 0x2642
// Size: 0x3d
function function_968477e29384c69f( name )
{
    if ( isdefined( level._light.var_bc1f0a519db3f333[ name ] ) )
    {
        return level._light.var_bc1f0a519db3f333[ name ];
    }
}

// Namespace lighting
// Params 4
// Checksum 0x915cf2af, Offset: 0x2688
// Size: 0x246
function function_7a5238a1901b801d( name, targetname, minintensity, maxintensity )
{
    assert( isstring( name ) );
    assert( isstring( targetname ) );
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    if ( ents.size == 0 )
    {
        println( "<dev string:x17f>" + name + "<dev string:x1c3>" + targetname + "<dev string:xa1>" );
        return;
    }
    
    preset = function_968477e29384c69f( name );
    
    if ( !isdefined( preset ) )
    {
        println( "<dev string:x1f1>" + name + "<dev string:x224>" );
        return;
    }
    
    if ( isdefined( minintensity ) )
    {
        if ( minintensity < 0 )
        {
            println( "<dev string:x11e>" + name + "<dev string:x13c>" );
            minintensity = 0;
        }
        
        preset.minintensity = minintensity;
    }
    
    if ( isdefined( maxintensity ) )
    {
        if ( maxintensity < 0 )
        {
            println( "<dev string:x11e>" + name + "<dev string:x13c>" );
            maxintensity = 0;
        }
        
        preset.maxintensity = maxintensity;
    }
    
    foreach ( ent in ents )
    {
        ent setlightintensity( preset.maxintensity );
        ent.var_f68315892787643e = 1;
        ent.var_a103472cf4c39a00 = 0;
        ent thread function_3b55b05a85ebb1d2( preset.minintensity, preset.maxintensity, preset.mindelay, preset.maxdelay, preset.minflicker, preset.maxflicker, preset.minpause, preset.maxpause );
        ent function_260a6b56a17548d4();
    }
}

// Namespace lighting
// Params 8
// Checksum 0x87bb7b06, Offset: 0x28d6
// Size: 0x179
function function_3b55b05a85ebb1d2( minintensity, maxintensity, mindelay, maxdelay, minflicker, maxflicker, minpause, maxpause )
{
    assert( isdefined( self.var_f68315892787643e ) );
    assert( isdefined( self.var_a103472cf4c39a00 ) );
    self endon( #"kill_flicker" );
    self endon( #"death" );
    min_delay = mindelay;
    max_delay = maxdelay;
    min_flicker = minflicker;
    max_flicker = maxflicker;
    min_pause = minpause;
    max_pause = maxpause;
    min_intensity = minintensity;
    max_intensity = maxintensity;
    
    if ( max_flicker < min_flicker || max_flicker == 0 )
    {
        min_flicker = 1;
        max_flicker = 3;
        println( "<dev string:x27d>" );
    }
    
    if ( max_pause < min_pause || max_pause == 0 )
    {
        min_pause = 8;
        max_pause = 15;
        println( "<dev string:x2c7>" );
    }
    
    if ( max_intensity < min_intensity || max_intensity == 0 )
    {
        min_intensity = 0;
        max_intensity = 10;
        println( "<dev string:x30f>" );
    }
    
    thread electric_flicker( min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause );
    original_origin = self.origin;
}

// Namespace lighting
// Params 8
// Checksum 0xf95e86c6, Offset: 0x2a57
// Size: 0x210
function electric_flicker( min_intensity, max_intensity, min_delay, max_delay, min_flicker, max_flicker, min_pause, max_pause )
{
    assert( isdefined( self.var_f68315892787643e ) );
    assert( isdefined( self.var_a103472cf4c39a00 ) );
    self endon( #"kill_flicker" );
    self endon( #"death" );
    self setlightintensity( max_intensity );
    pause_time = randomfloatrange( min_pause, max_pause );
    num_flicker = randomintrange( min_flicker, max_flicker );
    pause_time_2 = pause_time;
    var_497b13c09418565c = num_flicker;
    old_intensity = max_intensity;
    
    for ( ;; )
    {
        if ( pause_time == 0 || pause_time < 0 )
        {
            if ( num_flicker == 0 || num_flicker < 0 )
            {
                self setlightintensity( max_intensity );
                pause_time = randomfloatrange( min_pause, max_pause );
                pause_time_2 = pause_time;
            }
            else
            {
                for ( z = 0; z < var_497b13c09418565c ; z++ )
                {
                    intensity = randomfloatrange( min_intensity, max_intensity );
                    timer = randomfloatrange( min_delay, max_delay );
                    timer *= 0.75;
                    
                    while ( self.var_a103472cf4c39a00 )
                    {
                        wait 0.05;
                    }
                    
                    for ( i = 0; i < timer ; i++ )
                    {
                        new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
                        self setlightintensity( new_intensity );
                        wait 0.05;
                        num_flicker -= 1;
                    }
                    
                    old_intensity = intensity;
                }
            }
            
            continue;
        }
        
        for ( i = 0; i < pause_time_2 ; i++ )
        {
            intensity = randomfloatrange( max_intensity * 0.95, max_intensity );
            
            while ( self.var_a103472cf4c39a00 )
            {
                wait 0.05;
            }
            
            self setlightintensity( intensity );
            wait 0.05;
            pause_time -= 1;
            num_flicker = randomintrange( min_flicker, max_flicker );
            var_497b13c09418565c = num_flicker;
            wait 1;
        }
    }
}

// Namespace lighting
// Params 3
// Checksum 0xbf9b5f2b, Offset: 0x2c6f
// Size: 0xa1
function function_c9a5d78e059e4a27( targetname, time, endradius )
{
    ent = getent( targetname, #targetname );
    startradius = ent getlightradius();
    ent.endradius = endradius;
    t = 0;
    
    while ( t < time )
    {
        new_radius = startradius + ( endradius - startradius ) * t / time;
        t += 0.05;
        ent setlightradius( new_radius );
        wait 0.05;
    }
    
    ent setlightradius( endradius );
}

// Namespace lighting
// Params 2
// Checksum 0xf8115275, Offset: 0x2d18
// Size: 0x38
function set_light_intensity( targetname, endintensity )
{
    ent = getent( targetname, #targetname );
    ent setlightintensity( endintensity );
}

// Namespace lighting
// Params 3
// Checksum 0xd1d5de26, Offset: 0x2d58
// Size: 0xd5
function function_8a1c0484c28aea9c( targetname, time, endcolor )
{
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    foreach ( ent in ents )
    {
        thread function_a91693f843c36c1a( ent, time, endcolor );
    }
}

// Namespace lighting
// Params 3
// Checksum 0x1bb8138, Offset: 0x2e35
// Size: 0x88
function function_a91693f843c36c1a( ent, time, endcolor )
{
    startcolor = ent getlightcolor();
    ent.endcolor = endcolor;
    t = 0;
    
    while ( t < time )
    {
        new_color = startcolor + ( endcolor - startcolor ) * t / time;
        t += 0.05;
        ent setlightcolor( new_color );
        wait 0.05;
    }
    
    ent setlightcolor( endcolor );
}

// Namespace lighting
// Params 2
// Checksum 0xe8738f36, Offset: 0x2ec5
// Size: 0x38
function set_light_color( targetname, endcolor )
{
    ent = getent( targetname, #targetname );
    ent setlightcolor( endcolor );
}

// Namespace lighting
// Params 14
// Checksum 0xf5d5f698, Offset: 0x2f05
// Size: 0x781
function function_3c4a6dec76611612( targetname, var_b40e381c3e7101db, min_intensity, max_intensity, fxid1, fxid2, min_on_time, max_on_time, min_off_time, max_off_time, ender, snd_params, offint, oneshot_sfx )
{
    assert( isstring( targetname ) );
    self endon( #"death" );
    
    if ( isdefined( ender ) )
    {
        level endon( ender );
    }
    
    ents1 = getentarray( targetname, #targetname );
    ents2 = getentarray( targetname, #script_noteworthy );
    ents = arraycombine( ents1, ents2 );
    
    if ( !isdefined( ents ) )
    {
        println( "<dev string:x35b>" );
        return;
    }
    
    lightents = [];
    modelents = [];
    
    foreach ( ent in ents )
    {
        if ( ent.classname == "script_model" )
        {
            modelents[ modelents.size ] = ent;
        }
        
        if ( ent.classname == "light" )
        {
            lightents[ lightents.size ] = ent;
            intensity = min_intensity;
            
            if ( max_intensity > min_intensity )
            {
                intensity = randomfloatrange( min_intensity, max_intensity );
            }
            
            ent setlightintensity( intensity );
        }
    }
    
    snd_is_playing = 0;
    var_b184b085b8ea3262 = undefined;
    var_51256a15ab32b014 = undefined;
    var_b1929485b8fa3c53 = undefined;
    var_f0287da3238ed4c1 = undefined;
    snd_vol_env = undefined;
    snd_vol = 1;
    
    if ( isarray( snd_params ) )
    {
        var_b184b085b8ea3262 = snd_params[ "on" ];
        var_51256a15ab32b014 = snd_params[ "off" ];
        var_b1929485b8fa3c53 = snd_params[ "loop" ];
        snd_vol_env = snd_params[ "vol_env" ];
    }
    
    flicker_count = 0;
    
    if ( isdefined( fxid1 ) )
    {
        utility::exploder( fxid1 );
    }
    
    level.accelerationfactor = 1;
    
    while ( flicker_count < var_b40e381c3e7101db || var_b40e381c3e7101db == 0 )
    {
        on = undefined;
        off = offint ?? 0.05;
        
        if ( isdefined( min_on_time ) && isdefined( max_on_time ) )
        {
            var_b667df9db3ce9289 = randomfloatrange( min_on_time, max_on_time ) * level.accelerationfactor;
        }
        else
        {
            var_b667df9db3ce9289 = randomfloatrange( 0.1, 0.8 ) * level.accelerationfactor;
        }
        
        if ( isdefined( min_off_time ) && isdefined( max_off_time ) )
        {
            var_f526a6d26f734825 = randomfloatrange( min_off_time, max_off_time ) * level.accelerationfactor;
        }
        else
        {
            var_f526a6d26f734825 = randomfloatrange( 0.1, 0.8 ) * level.accelerationfactor;
        }
        
        if ( isdefined( fxid1 ) )
        {
            foreach ( light_ent in lightents )
            {
                if ( snd_is_playing )
                {
                    if ( isstring( var_f0287da3238ed4c1 ) )
                    {
                        level notify( var_f0287da3238ed4c1 );
                    }
                    
                    if ( isdefined( var_51256a15ab32b014 ) )
                    {
                        snd_is_playing = 0;
                    }
                }
            }
            
            utility::kill_exploder( fxid1 );
        }
        
        if ( isdefined( fxid2 ) )
        {
            foreach ( light_ent in lightents )
            {
                if ( snd_is_playing )
                {
                    if ( isstring( var_f0287da3238ed4c1 ) )
                    {
                        level notify( var_f0287da3238ed4c1 );
                    }
                    
                    if ( isdefined( var_51256a15ab32b014 ) )
                    {
                        snd_is_playing = 0;
                    }
                }
            }
            
            utility::kill_exploder( fxid2 );
        }
        
        foreach ( model01 in modelents )
        {
            model01 hide();
        }
        
        foreach ( light in lightents )
        {
            on = light getlightintensity();
            light setlightintensity( off );
        }
        
        wait var_f526a6d26f734825;
        
        if ( isdefined( fxid1 ) )
        {
            foreach ( light_ent in lightents )
            {
                intensity = min_intensity;
                
                if ( max_intensity > min_intensity )
                {
                    intensity = randomfloatrange( min_intensity, max_intensity );
                }
                
                light_ent setlightintensity( intensity );
                
                if ( isdefined( var_b184b085b8ea3262 ) && !snd_is_playing )
                {
                    if ( isarray( snd_vol_env ) )
                    {
                        if ( isdefined( var_b184b085b8ea3262 ) )
                        {
                            if ( isdefined( var_b1929485b8fa3c53 ) )
                            {
                                snd_is_playing = 1;
                            }
                        }
                    }
                }
            }
            
            utility::exploder( fxid1 );
        }
        
        if ( isdefined( fxid2 ) )
        {
            foreach ( light_ent in lightents )
            {
                intensity = min_intensity;
                
                if ( max_intensity > min_intensity )
                {
                    intensity = randomfloatrange( min_intensity, max_intensity );
                }
                
                light_ent setlightintensity( intensity );
                
                if ( isdefined( var_b184b085b8ea3262 ) && !snd_is_playing )
                {
                    if ( isarray( snd_vol_env ) )
                    {
                        if ( isdefined( var_b184b085b8ea3262 ) )
                        {
                            if ( isdefined( var_b1929485b8fa3c53 ) )
                            {
                                snd_is_playing = 1;
                            }
                        }
                    }
                }
            }
            
            utility::exploder( fxid2 );
        }
        
        foreach ( model01 in modelents )
        {
            model01 show();
        }
        
        foreach ( light in lightents )
        {
            light setlightintensity( on );
            
            if ( isdefined( oneshot_sfx ) )
            {
                light utility::playsoundonentity( oneshot_sfx );
            }
        }
        
        wait var_b667df9db3ce9289;
        
        if ( var_b40e381c3e7101db != 0 )
        {
            flicker_count++;
        }
    }
}

// Namespace lighting
// Params 11
// Checksum 0x1b0ec388, Offset: 0x368e
// Size: 0x188
function function_5ffdf38a79e3f52( ent, ent2, var_b40e381c3e7101db, min_intensity, min_on_time, max_on_time, min_off_time, max_off_time, ender, snd_params, offint )
{
    self endon( #"death" );
    
    if ( isdefined( ender ) )
    {
        level endon( ender );
    }
    
    if ( !isdefined( ent ) )
    {
        println( "<dev string:x38b>" );
        return;
    }
    
    if ( !isdefined( ent2 ) )
    {
        println( "<dev string:x39f>" );
        return;
    }
    
    for ( flicker_count = 0; flicker_count < var_b40e381c3e7101db || var_b40e381c3e7101db == 0 ; flicker_count++ )
    {
        on = undefined;
        
        if ( isdefined( offint ) )
        {
            off = offint;
        }
        else
        {
            off = 0.05;
        }
        
        delay = 0;
        
        if ( isdefined( min_on_time ) && isdefined( max_on_time ) )
        {
            var_b667df9db3ce9289 = randomfloatrange( min_on_time, max_on_time );
        }
        else
        {
            var_b667df9db3ce9289 = randomfloatrange( 0.1, 0.8 );
        }
        
        if ( isdefined( min_off_time ) && isdefined( max_off_time ) )
        {
            var_f526a6d26f734825 = randomfloatrange( min_off_time, max_off_time );
        }
        else
        {
            var_f526a6d26f734825 = randomfloatrange( 0.1, 0.8 );
        }
        
        ent hide();
        ent2 show();
        wait var_f526a6d26f734825;
        ent show();
        ent2 hide();
        wait var_b667df9db3ce9289;
        
        if ( var_b40e381c3e7101db != 0 )
        {
        }
    }
}

// Namespace lighting
// Params 0
// Checksum 0x4a22c69c, Offset: 0x381e
// Size: 0x29
function light_message_init()
{
    assert( isdefined( level._light ) );
    level._light.messages = [];
}

/#

    // Namespace lighting
    // Params 0
    // Checksum 0xc101b9ce, Offset: 0x384f
    // Size: 0x14, Type: dev
    function function_c8728dac1d3fa5e5()
    {
        setdvarifuninitialized( @"hash_4e1c5767f995ad93", 0 );
    }

#/

// Namespace lighting
// Params 2
// Checksum 0x88066bb8, Offset: 0x386b
// Size: 0x63
function function_f7a824abe157c4ee( message, callback )
{
    assert( isdefined( level._light ), "<dev string:x3b4>" );
    assert( isarray( level._light.messages ) );
    level._light.messages[ message ] = callback;
}

// Namespace lighting
// Params 3, eflags: 0x40 variadic
// Checksum 0xb5531710, Offset: 0x38d6
// Size: 0x8e
function light_message( message, ... )
{
    assert( isdefined( level._light ), "<dev string:x3b4>" );
    assert( isarray( level._light.messages ) );
    
    if ( isdefined( level._light.messages[ message ] ) )
    {
        thread [[ level._light.messages[ message ] ]]( flat_args( vararg, varargcount ) );
    }
    
    /#
    #/
}

// Namespace lighting
// Params 5
// Checksum 0xac510f1a, Offset: 0x396c
// Size: 0x60
function function_e12871c9da183fc6( outer_start, inner_start, outer_end, inner_end, duration )
{
    t = 0;
    
    while ( t <= duration )
    {
        time_fraction = t / duration;
        waitframe();
        t += 0.05;
    }
}

// Namespace lighting
// Params 1
// Checksum 0xec212362, Offset: 0x39d4
// Size: 0x18
function vfx_sunflare( fx_name )
{
    thread function_d9fb22c61ca15977( fx_name, 50000 );
}

// Namespace lighting
// Params 2
// Checksum 0x4177973b, Offset: 0x39f4
// Size: 0xfb
function function_d9fb22c61ca15977( fxid, dist )
{
    level endon( #"hash_d568bcaa53af512" );
    level endon( #"death" );
    
    if ( !isdefined( dist ) )
    {
        dist = 50000;
    }
    
    level.sunflare = utility::spawn_tag_origin();
    level.sunflare.origin = level.player.origin + get_sun_direction() * dist;
    level.sunflare show();
    playfxontag( utility::getfx( fxid ), level.sunflare, "tag_origin" );
    thread fx_flare_kill( fxid, level.sunflare );
    delay = 0.1;
    
    while ( true )
    {
        level.sunflare moveto( level.player.origin + get_sun_direction() * dist, delay );
        wait delay;
    }
}

// Namespace lighting
// Params 2
// Checksum 0x75c6ebf, Offset: 0x3af7
// Size: 0x42
function fx_flare_kill( fxid, ent )
{
    level waittill( #"kill_sun" );
    killfxontag( utility::getfx( fxid ), ent, "tag_origin" );
    level notify( #"hash_d568bcaa53af512" );
}

// Namespace lighting
// Params 1
// Checksum 0xb4ba1b9b, Offset: 0x3b41
// Size: 0x1d
function set_sun_flare_position( sun_flare_position )
{
    level.sun_flare_position = sun_flare_position;
    wait 0.3;
}

// Namespace lighting
// Params 0
// Checksum 0xc9de3fe, Offset: 0x3b66
// Size: 0x25
function get_sun_direction()
{
    if ( isdefined( level.sun_flare_position ) )
    {
        return anglestoforward( level.sun_flare_position );
    }
    
    return getmapsundirection();
}

// Namespace lighting
// Params 2
// Checksum 0x147d5860, Offset: 0x3b93
// Size: 0x91
function function_c5b05b9ca3722f93( time, destfov )
{
    foreach ( player in level.players )
    {
        player modifybasefov( destfov, time );
    }
    
    wait time;
}

// Namespace lighting
// Params 2
// Checksum 0x1be47dfd, Offset: 0x3c2c
// Size: 0x91
function function_f88a12fbc17f72b3( time, destfov )
{
    foreach ( player in level.players )
    {
        player lerpfov( destfov, time );
    }
    
    wait time;
}

// Namespace lighting
// Params 0
// Checksum 0x46f63d65, Offset: 0x3cc5
// Size: 0x1e8
function lerp_fov_over_distance_trigger()
{
    linepoints = strtok( self.script_parameters, " " );
    linepointstructs = [];
    
    foreach ( linepoint in linepoints )
    {
        linepointstructs[ linepointstructs.size ] = utility::getstruct( linepoint, "targetname" );
    }
    
    startfov = float( linepointstructs[ 0 ].script_parameters );
    endfov = float( linepointstructs[ 1 ].script_parameters );
    var_93d5bf59773700ac = distance( linepointstructs[ 0 ].origin, linepointstructs[ 1 ].origin );
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        while ( level.player istouching( self ) )
        {
            var_d383ca32d040a647 = pointonsegmentnearesttopoint( linepointstructs[ 0 ].origin, linepointstructs[ 1 ].origin, level.player.origin );
            delta = math::normalize_value( 0, var_93d5bf59773700ac, distance( linepointstructs[ 0 ].origin, var_d383ca32d040a647 ) );
            targetfov = math::factor_value( startfov, endfov, delta );
            level.player modifybasefov( targetfov, 0.05 );
            
            if ( level.player adsbuttonpressed() )
            {
                wait 0.3;
            }
            else
            {
                level.player modifybasefov( targetfov, 0.05 );
            }
            
            waitframe();
        }
    }
}

// Namespace lighting
// Params 7
// Checksum 0x824ff2da, Offset: 0x3eb5
// Size: 0x40b
function function_943fe28ee2534243( var_2c19f05b75e689a1, var_9a939fa2b14a8b53, var_3997572514a931d4, in_time, wait_time, out_time, running_threshold )
{
    self notify( #"end_dof_loops" );
    self endon( #"end_dof_loops" );
    level.var_b6ca7c87d1cb8b73 = 1;
    level.var_de08b20698bb831c = undefined;
    prev_time = gettime();
    prev_move_speed = length( self getvelocity() );
    waitframe();
    strength_goal = 0;
    distortion_goal = 0;
    radius_goal = 0;
    state = "DOWN";
    var_2699d59367341399 = undefined;
    var_1eafa0e89bac5b02 = 0;
    lerp_all_done = 0;
    
    while ( true )
    {
        text = "";
        curr_move_speed = length( self getvelocity() );
        
        if ( curr_move_speed == 0 && isdefined( level.player.ski_velocity ) )
        {
            curr_move_speed = level.player.ski_velocity;
        }
        
        time_elapsed_ms = gettime() - prev_time;
        stick_mag = length2d( self getnormalizedmovement() );
        
        if ( level.var_de08b20698bb831c )
        {
            state = "QUIT";
        }
        
        switch ( state )
        {
            case #"hash_faa298f6bdc36b00":
                if ( curr_move_speed < running_threshold || curr_move_speed < prev_move_speed && stick_mag < 0.05 )
                {
                    state = "wait";
                    var_2699d59367341399 = gettime() + wait_time * 1000;
                }
                
                break;
            case #"hash_1e6e35d002e26a35":
                if ( curr_move_speed >= running_threshold && ( curr_move_speed > prev_move_speed || curr_move_speed == prev_move_speed && stick_mag > 0.95 ) )
                {
                    state = "UP";
                    var_1eafa0e89bac5b02 = in_time;
                    strength_goal = var_9a939fa2b14a8b53;
                    distortion_goal = var_2c19f05b75e689a1;
                    radius_goal = var_3997572514a931d4;
                }
                
                break;
            case #"hash_bdf347744138cb00":
                if ( curr_move_speed >= running_threshold && ( curr_move_speed > prev_move_speed || curr_move_speed == prev_move_speed && stick_mag > 0.95 ) )
                {
                    state = "UP";
                    var_1eafa0e89bac5b02 = in_time;
                    strength_goal = var_9a939fa2b14a8b53;
                    distortion_goal = var_2c19f05b75e689a1;
                    radius_goal = var_3997572514a931d4;
                }
                else if ( gettime() > var_2699d59367341399 || curr_move_speed < prev_move_speed && stick_mag > 0.05 )
                {
                    state = "DOWN";
                    var_1eafa0e89bac5b02 = out_time;
                    strength_goal = 0;
                    distortion_goal = 0;
                    radius_goal = 0;
                }
                
                break;
            case #"hash_ca04c44443c6fa96":
                var_1eafa0e89bac5b02 = out_time;
                strength_goal = 0;
                distortion_goal = 0;
                radius_goal = 0;
                break;
        }
        
        if ( state != "wait" )
        {
            /#
                level.set_lerp_value_text = "<dev string:x3f4>";
            #/
            
            done1 = set_lerp_value( @"r_mbradialoverridestrength", state, curr_move_speed, strength_goal, var_9a939fa2b14a8b53, var_1eafa0e89bac5b02, time_elapsed_ms );
            done2 = set_lerp_value( @"r_mbradialoverridedistortion", state, curr_move_speed, distortion_goal, var_2c19f05b75e689a1, var_1eafa0e89bac5b02, time_elapsed_ms );
            done3 = set_lerp_value( @"r_mbradialoverrideradius", state, curr_move_speed, radius_goal, var_3997572514a931d4, var_1eafa0e89bac5b02, time_elapsed_ms );
            lerp_all_done = done1 && done2 && done3;
            
            /#
                if ( lerp_all_done )
                {
                    text = state + "<dev string:x3f5>" + "<dev string:x3fa>" + curr_move_speed + "<dev string:x402>" + level.set_lerp_value_text;
                }
                else
                {
                    text = state + "<dev string:x3fa>" + curr_move_speed + "<dev string:x402>" + level.set_lerp_value_text;
                }
            #/
        }
        else
        {
            var_3f012fcd4053a549 = var_2699d59367341399 - gettime();
            
            if ( var_3f012fcd4053a549 < 0 )
            {
                var_3f012fcd4053a549 = 0;
            }
            
            /#
                text = state + "<dev string:x3fa>" + curr_move_speed + "<dev string:x404>" + var_3f012fcd4053a549 * 0.001 + "<dev string:x40b>" + wait_time + "<dev string:x402>";
            #/
        }
        
        prev_time = gettime();
        
        if ( state != "wait" )
        {
            prev_move_speed = curr_move_speed;
        }
        
        if ( level.var_de08b20698bb831c && lerp_all_done )
        {
            break;
        }
        
        waitframe();
    }
    
    level.var_b6ca7c87d1cb8b73 = 0;
    level.var_de08b20698bb831c = undefined;
}

// Namespace lighting
// Params 0
// Checksum 0xe5bfb404, Offset: 0x42c8
// Size: 0xd
function function_de08b20698bb831c()
{
    level.var_de08b20698bb831c = 1;
}

// Namespace lighting
// Params 7
// Checksum 0x2a08ff36, Offset: 0x42dd
// Size: 0x1b3
function set_lerp_value( dvar_name, state, curr_move_speed, strength_goal, var_9a939fa2b14a8b53, var_1eafa0e89bac5b02, time_elapsed_ms )
{
    var_7a483ea4e0949c3b = undefined;
    current_speed_ratio = undefined;
    is_done = 0;
    curr_strength = getdvarfloat( dvar_name );
    
    if ( true )
    {
        current_speed_ratio = curr_move_speed / getdvarfloat( @"g_speed" );
    }
    else
    {
        current_speed_ratio = curr_move_speed / 340;
    }
    
    if ( current_speed_ratio > 1 )
    {
        current_speed_ratio = 1;
    }
    
    var_5c9acf3cba4626b5 = strength_goal * current_speed_ratio;
    
    if ( var_1eafa0e89bac5b02 == 0 )
    {
        var_7a483ea4e0949c3b = 1e+06;
    }
    else
    {
        var_664a4ac71ce6742f = var_9a939fa2b14a8b53 / var_1eafa0e89bac5b02;
        var_7a483ea4e0949c3b = var_664a4ac71ce6742f * time_elapsed_ms * 0.001;
    }
    
    if ( curr_strength != strength_goal )
    {
        if ( state == "UP" )
        {
            var_a49f8182655d3a9f = curr_strength + var_7a483ea4e0949c3b;
            
            if ( var_a49f8182655d3a9f > var_9a939fa2b14a8b53 * current_speed_ratio )
            {
                var_a49f8182655d3a9f = var_5c9acf3cba4626b5;
            }
        }
        else
        {
            var_a49f8182655d3a9f = curr_strength - var_7a483ea4e0949c3b;
            
            if ( var_a49f8182655d3a9f < 0 )
            {
                var_a49f8182655d3a9f = 0;
            }
        }
        
        utility::noself_func( "setsaveddvar", dvar_name, var_a49f8182655d3a9f );
        is_done = 0;
    }
    else
    {
        var_a49f8182655d3a9f = curr_strength;
        is_done = 1;
    }
    
    /#
        if ( var_9a939fa2b14a8b53 > 0 )
        {
            dvar_short = "<dev string:x40d>";
            
            if ( dvar_name == @"r_mbradialoverridedistortion" )
            {
                dvar_short = "<dev string:x411>";
            }
            
            if ( dvar_name == @"r_mbradialoverrideradius" )
            {
                dvar_short = "<dev string:x415>";
            }
            
            level.set_lerp_value_text = dvar_short + "<dev string:x419>" + var_a49f8182655d3a9f + "<dev string:x40b>" + var_5c9acf3cba4626b5 + "<dev string:x402>" + level.set_lerp_value_text;
        }
    #/
    
    return is_done;
}

// Namespace lighting
// Params 3
// Checksum 0xf67819a, Offset: 0x4499
// Size: 0xa6
function function_c3d5f270f5681f8d( ent, time, target )
{
    ent notify( #"hash_1e7902b31a797b96" );
    ent endon( #"hash_1e7902b31a797b96" );
    ent endon( #"death" );
    startorigin = ent.origin;
    t = 0;
    
    while ( t < time )
    {
        ent.origin = vectorlerp( startorigin, target, t / time );
        t += 0.05;
        wait 0.05;
    }
    
    ent.origin = target;
}

// Namespace lighting
// Params 0
// Checksum 0xa602c294, Offset: 0x4547
// Size: 0x7d
function function_8e7dee8802357c7b()
{
    while ( true )
    {
        self waittill( #"trigger" );
        vals = strtok( self.script_parameters, " " );
        targettime = float( vals[ 0 ] );
        targetdistance = float( vals[ 1 ] );
        thread sunshadowscale_lerp( targettime, targetdistance );
        waitframe();
        
        while ( level.player istouching( self ) )
        {
            wait 0.05;
        }
    }
}

// Namespace lighting
// Params 7
// Checksum 0x82f31af5, Offset: 0x45cc
// Size: 0x474
function function_5a431c17b2205ce5( var_8056e1171d618dd6, var_885ebbff219f92d5, var_896499698acbdeca, spotdistcull, var_3729678dbe7bc958, endflag, var_9ac733ed13c2ec87 )
{
    level endon( endflag );
    var_31f5132eb07d294d = var_885ebbff219f92d5;
    var_31caf3d7585cc0ba = [];
    
    if ( isdefined( var_9ac733ed13c2ec87 ) )
    {
        var_31caf3d7585cc0ba[ 0 ] = ( 1, 0, 0 );
        var_31caf3d7585cc0ba[ 1 ] = ( 0, 1, 0 );
        var_31caf3d7585cc0ba[ 2 ] = ( 0, 0, 1 );
        var_31caf3d7585cc0ba[ 3 ] = ( 1, 0, 1 );
        var_31caf3d7585cc0ba[ 4 ] = ( 0, 1, 1 );
        var_31caf3d7585cc0ba[ 5 ] = ( 1, 1, 0 );
        var_31caf3d7585cc0ba[ 6 ] = ( 1, 1, 1 );
        var_31caf3d7585cc0ba[ 7 ] = ( 0, 0.5, 0.5 );
    }
    
    if ( isdefined( var_885ebbff219f92d5 ) )
    {
        utility::noself_func( "setsaveddvar", @"sm_spotupdatelimit", var_31f5132eb07d294d );
    }
    
    if ( isdefined( spotdistcull ) )
    {
        utility::noself_func( "setsaveddvar", @"sm_spotdistcull", spotdistcull );
    }
    
    lights = getentarray( var_8056e1171d618dd6, #script_noteworthy );
    permanent_lights = [];
    
    if ( isdefined( var_3729678dbe7bc958 ) )
    {
        permanent_lights = getentarray( var_3729678dbe7bc958, #script_noteworthy );
    }
    
    while ( !isdefined( level.player ) )
    {
        wait 0.2;
    }
    
    angles = level.player getplayerangles();
    forward = anglestoforward( angles );
    player_eye_pos = level.player.origin + ( 0, 0, 48 );
    trace_result = trace::ray_trace( player_eye_pos, player_eye_pos + forward * 30000 );
    trace_result_position = trace_result[ "position" ];
    sorted_lights = sortbydistance( lights, trace_result_position );
    
    while ( true )
    {
        angles = level.player getplayerangles();
        forward = anglestoforward( angles );
        player_eye_pos = level.player.origin + ( 0, 0, 48 );
        trace_result = trace::ray_trace( player_eye_pos, player_eye_pos + forward * 30000 );
        trace_result_position = trace_result[ "position" ];
        sorted_lights = sortbydistance( lights, trace_result_position );
        var_fb4140e1cc829c54 = [];
        index = 0;
        
        if ( isdefined( var_3729678dbe7bc958 ) )
        {
            foreach ( light in permanent_lights )
            {
                intensity = light getlightintensity();
                
                if ( intensity < 0.1 )
                {
                    continue;
                }
                
                var_fb4140e1cc829c54[ index ] = light;
                index += 1;
            }
        }
        
        foreach ( light in sorted_lights )
        {
            intensity = light getlightintensity();
            
            if ( intensity < 0.1 )
            {
                continue;
            }
            
            var_fb4140e1cc829c54[ index ] = light;
            index += 1;
        }
        
        for ( i = 0; i < var_fb4140e1cc829c54.size ; i++ )
        {
            dist = distance( var_fb4140e1cc829c54[ i ].origin, level.player.origin );
            dot = vectordot( vectornormalize( var_fb4140e1cc829c54[ i ].origin - level.player.origin ), forward );
            
            if ( dist < spotdistcull )
            {
                /#
                    if ( var_9ac733ed13c2ec87 )
                    {
                        line( trace_result_position, var_fb4140e1cc829c54[ i ].origin, var_31caf3d7585cc0ba[ i ], 1, 0, 4 );
                    }
                #/
            }
        }
        
        if ( var_fb4140e1cc829c54.size > var_31f5132eb07d294d )
        {
            for ( i = var_31f5132eb07d294d; i < var_fb4140e1cc829c54.size ; i++ )
            {
            }
        }
        
        wait 0.4;
    }
}

// Namespace lighting
// Params 0
// Checksum 0xed1cabb8, Offset: 0x4a48
// Size: 0xd
function function_369128fe0bf1a67d()
{
    level.var_db380596fbf9c028 = 0;
    waitframe();
}

// Namespace lighting
// Params 2
// Checksum 0x4ecd60b5, Offset: 0x4a5d
// Size: 0x6b
function dazed_effect( intensity, time )
{
    utility::noself_func( "setsaveddvar", @"r_mbenable", 1 );
    
    if ( !isdefined( time ) )
    {
        time = 3;
    }
    
    if ( intensity == 1 )
    {
        level thread dazed_effect_low( time );
    }
    
    if ( intensity == 2 )
    {
        level thread dazed_effect_mid( time );
    }
    
    if ( intensity == 3 )
    {
        level thread dazed_effect_high( time );
    }
}

// Namespace lighting
// Params 1
// Checksum 0x8e9a21a5, Offset: 0x4ad0
// Size: 0xb5
function dazed_effect_low( time )
{
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscale", 1 );
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscaleviewmodel", 3 );
    utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0.07 );
    wait time;
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscale", 0 );
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscaleviewmodel", 0 );
    utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0 );
    wait 0.05;
    utility::noself_func( "setsaveddvar", @"r_mbenable", 0 );
}

// Namespace lighting
// Params 1
// Checksum 0xfdbdf892, Offset: 0x4b8d
// Size: 0xd7
function dazed_effect_mid( time )
{
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscale", 2 );
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscaleviewmodel", 2 );
    utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0.05 );
    wait 0.1;
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscale", 1 );
    utility::noself_func( "setsaveddvar", @"r_mbvelocityscaleviewmodel", 1 );
    utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0.007 );
    wait time;
    utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0 );
    wait 0.05;
    utility::noself_func( "setsaveddvar", @"r_mbenable", 0 );
}

// Namespace lighting
// Params 1
// Checksum 0x5d52d4d0, Offset: 0x4c6c
// Size: 0x2a
function dazed_effect_high( time )
{
    thread function_e1b43ac0d38a3561( 0.007, 0.2 );
    wait time;
    thread function_e1b43ac0d38a3561( 0, 1 );
}

// Namespace lighting
// Params 2
// Checksum 0x9416dae4, Offset: 0x4c9e
// Size: 0x98
function function_e1b43ac0d38a3561( end_value, duration )
{
    start_value = getdvarfloat( @"r_mbradialoverridestrength" );
    t = 0;
    
    while ( t <= duration )
    {
        time_fraction = t / duration;
        utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", math::lerp( start_value, end_value, time_fraction ) );
        waitframe();
        t += 0.05;
    }
    
    if ( end_value == 0 )
    {
        utility::noself_func( "setsaveddvar", @"r_mbradialoverridestrength", 0 );
    }
}

// Namespace lighting
// Params 3
// Checksum 0xda6bd0d2, Offset: 0x4d3e
// Size: 0x99
function lerp_dvar( dvar, end_value, duration )
{
    start_value = getdvarfloat( dvar );
    level endon( #"hash_8c50e704c19d3915" );
    t = 0.05;
    
    while ( t <= duration + 0.0001 )
    {
        time_fraction = t / duration;
        time_fraction = round( time_fraction, 0.0001 );
        utility::noself_func( "setsaveddvar", dvar, math::lerp( start_value, end_value, time_fraction ) );
        waitframe();
        t += 0.05;
    }
}

// Namespace lighting
// Params 0
// Checksum 0x69251f7c, Offset: 0x4ddf
// Size: 0xb3
function function_3171dec1082a69a9()
{
    function_18360974534b1f92( "default", 1, 1, 4.5, 500, 500, 0.05, 0.5 );
    function_18360974534b1f92( "viewmodel_blur", 1, 1, 4.5, 500, 500, 0.05, 0.5 );
    function_18360974534b1f92( "close_none_viewmodel_blur", 1, 50, 4, 1000, 7000, 0.05, 0.5 );
    function_18360974534b1f92( "river", 1, 104, 9, 500, 500, 1.8, 0.5 );
    function_18360974534b1f92( "medium_none_viewmodel_blur", 1, 500, 10, 1000, 7000, 0.05, 0.5 );
}

// Namespace lighting
// Params 8
// Checksum 0x79f61b4a, Offset: 0x4e9a
// Size: 0xe1
function function_18360974534b1f92( name, nstart, nend, nblur, fstart, fend, fblur, fbias )
{
    if ( !isdefined( level._light.dof_presets ) )
    {
        level._light.dof_presets = [];
    }
    
    new_dof = [];
    new_dof[ "nearStart" ] = nstart;
    new_dof[ "nearEnd" ] = nend;
    new_dof[ "nearBlur" ] = nblur;
    new_dof[ "farStart" ] = fstart;
    new_dof[ "farEnd" ] = fend;
    new_dof[ "farBlur" ] = fblur;
    new_dof[ "bias" ] = fbias;
    level._light.dof_presets[ name ] = new_dof;
}

// Namespace lighting
// Params 1
// Checksum 0x51d22cb8, Offset: 0x4f83
// Size: 0x53
function function_44355e3b3dedfa33( name )
{
    if ( isdefined( level._light.dof_presets[ name ] ) )
    {
        return level._light.dof_presets[ name ];
    }
    
    println( "<dev string:x41b>" + name + "<dev string:x448>" );
}

// Namespace lighting
// Params 3
// Checksum 0xcafb82e3, Offset: 0x4fde
// Size: 0x8c
function blend_dof_presets( preset1, preset2, time )
{
    assert( isdefined( preset1 ) );
    assert( isdefined( preset2 ) );
    assert( time >= 0 );
    
    if ( isdefined( level._light.dof_presets ) )
    {
        dof1 = function_44355e3b3dedfa33( preset1 );
        dof2 = function_44355e3b3dedfa33( preset2 );
        
        if ( isdefined( dof1 ) && isdefined( dof2 ) )
        {
        }
    }
}

// Namespace lighting
// Params 0
// Checksum 0x4b0d7b0e, Offset: 0x5072
// Size: 0x32
function function_e1efe93441929f64()
{
    function_ec28cf8df41a8329( "default", 2, 8 );
    function_ec28cf8df41a8329( "viewmodel_blur", 10, 90 );
    function_ec28cf8df41a8329( "max", 2, 128 );
}

// Namespace lighting
// Params 3
// Checksum 0xc26bb08, Offset: 0x50ac
// Size: 0xb5
function function_ec28cf8df41a8329( name, start, end )
{
    if ( !isdefined( level._light.var_2713048dc26971fd ) )
    {
        level._light.var_2713048dc26971fd = [];
    }
    
    new_dof_viewmodel[ "start" ] = start;
    new_dof_viewmodel[ "end" ] = end;
    level.player.var_dae7cf3c11d6e0f9 = new_dof_viewmodel[ "start" ];
    level.player.var_23033428b0937de8 = new_dof_viewmodel[ "end" ];
    level._light.var_2713048dc26971fd[ name ] = new_dof_viewmodel;
}

// Namespace lighting
// Params 1
// Checksum 0x6c81ba3a, Offset: 0x5169
// Size: 0x53
function function_515894dd03e56178( name )
{
    if ( isdefined( level._light.var_2713048dc26971fd[ name ] ) )
    {
        return level._light.var_2713048dc26971fd[ name ];
    }
    
    println( "<dev string:x41b>" + name + "<dev string:x448>" );
}

// Namespace lighting
// Params 3
// Checksum 0x257c8851, Offset: 0x51c4
// Size: 0x97
function function_cd05e40d90ac29e1( preset1, preset2, time )
{
    assert( isdefined( preset1 ) );
    assert( isdefined( preset2 ) );
    assert( time >= 0 );
    
    if ( isdefined( level._light.var_2713048dc26971fd ) )
    {
        start_viewmodel = function_515894dd03e56178( preset1 );
        end_viewmodel = function_515894dd03e56178( preset2 );
        
        if ( isdefined( start_viewmodel ) && isdefined( end_viewmodel ) )
        {
            function_3ed40c9c1e33402e( start_viewmodel, end_viewmodel, time );
        }
    }
}

// Namespace lighting
// Params 3
// Checksum 0x30e3cd50, Offset: 0x5263
// Size: 0x5b
function function_3ed40c9c1e33402e( start_viewmodel, end_viewmodel, time )
{
    if ( time <= 0 )
    {
        level.player.var_dae7cf3c11d6e0f9 = end_viewmodel[ "start" ];
        level.player.var_23033428b0937de8 = end_viewmodel[ "end" ];
    }
}

// Namespace lighting
// Params 6
// Checksum 0xc18bab78, Offset: 0x52c6
// Size: 0x1da
function lighting_target_dof( player, target, aperture, focus_lerp_speed, var_688d8b0f98f83b18, tag )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x45b>" );
        return;
    }
    
    if ( !isdefined( aperture ) )
    {
        assertmsg( "<dev string:x49e>" );
        return;
    }
    
    level notify( #"end_lighting_target_dof" );
    level endon( #"end_lighting_target_dof" );
    
    if ( !isdefined( focus_lerp_speed ) )
    {
        focus_lerp_speed = 1;
    }
    
    if ( !isdefined( var_688d8b0f98f83b18 ) )
    {
        var_688d8b0f98f83b18 = 1;
    }
    
    level thread lighting_target_dof_cleanup();
    waitframe();
    level.player enablephysicaldepthoffieldscripting();
    fstop = aperture;
    utility::flag_clear( "flag_autofocus_on" );
    
    while ( true )
    {
        if ( !isdefined( target ) )
        {
            assertmsg( "<dev string:x4e3>" );
            return;
        }
        
        if ( isdefined( tag ) && target tagexists( tag ) )
        {
            dof_dist = distance( level.player geteye(), target gettagorigin( tag ) );
        }
        else
        {
            dof_dist = distance( level.player geteye(), target.origin );
        }
        
        fstop = aperture;
        
        if ( dof_dist < 60 )
        {
            fstop += abs( 60 - dof_dist ) * 0.1;
        }
        
        level.player setphysicaldepthoffield( fstop, dof_dist, focus_lerp_speed, var_688d8b0f98f83b18 );
        
        if ( isdefined( level.var_4ff3acc140fd3c5e ) )
        {
            if ( isdefined( tag ) )
            {
                /#
                    print3d( target gettagorigin( tag ), "<dev string:x535>", ( 1, 1, 1 ), 1, 1, 2 );
                #/
                
                iprintln( dof_dist );
            }
            else
            {
                /#
                    print3d( target.origin, "<dev string:x535>", ( 1, 1, 1 ), 1, 1, 2 );
                #/
                
                iprintln( dof_dist );
            }
        }
        
        waitframe();
    }
}

// Namespace lighting
// Params 0
// Checksum 0x71a7d7af, Offset: 0x54a8
// Size: 0x29
function lighting_target_dof_cleanup()
{
    level waittill( #"end_lighting_target_dof" );
    utility::flag_set( "flag_autofocus_on" );
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace lighting
// Params 9
// Checksum 0x25ce65a2, Offset: 0x54d9
// Size: 0x3c5
function function_a7340c12300ce76a( time, materials, fadein_, fadeout_, var_58e1779612180598, xpos, ypos, sort, do_bob )
{
    player = wait_for_player();
    overlay = newclienthudelem( player );
    
    if ( !isdefined( overlay ) )
    {
        return;
    }
    
    assert( isdefined( time ) );
    overlay = newclienthudelem( level.player );
    overlay.x = 0;
    overlay.y = 0;
    overlay.splatter = 1;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.foreground = 0;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = var_58e1779612180598;
    overlay thread cleanup_overlay();
    
    if ( isdefined( xpos ) )
    {
        overlay.x = xpos;
    }
    
    if ( isdefined( ypos ) )
    {
        overlay.y = ypos;
    }
    
    if ( isdefined( sort ) )
    {
        overlay.sort = sort;
    }
    
    if ( isarray( materials ) )
    {
        foreach ( material in materials )
        {
            assert( isstring( material ) );
            
            if ( do_bob )
            {
                overlay setshader( materials, 640, 480 );
                continue;
            }
            
            overlay setshader( materials, 640, 480 );
        }
    }
    else
    {
        assert( isstring( materials ) );
        
        if ( do_bob )
        {
            overlay setshader( materials, 640, 480 );
        }
        else
        {
            overlay setshader( materials, 640, 480 );
        }
    }
    
    if ( time > 0 )
    {
        overlay.alpha = 0;
        
        if ( isdefined( fadein_ ) )
        {
            fadein = fadein_;
        }
        else
        {
            fadein = 1;
        }
        
        if ( isdefined( fadeout_ ) )
        {
            fadeout = fadeout_;
        }
        else
        {
            fadeout = 1;
        }
        
        if ( isdefined( var_58e1779612180598 ) )
        {
            max_alpha = clamp( var_58e1779612180598, 0, 1 );
        }
        else
        {
            max_alpha = 1;
        }
        
        step_time = 0.05;
        
        if ( fadein > 0 )
        {
            current_alpha = 0;
            increment_alpha = max_alpha / fadein / step_time;
            assert( increment_alpha > 0, "<dev string:x537>" );
            
            while ( current_alpha < max_alpha )
            {
                overlay.alpha = current_alpha;
                current_alpha += increment_alpha;
                wait step_time;
            }
        }
        
        overlay.alpha = max_alpha;
        wait time - fadein + fadeout;
        
        if ( fadeout > 0 && isdefined( overlay ) )
        {
            current_alpha = max_alpha;
            decrement_alpha = max_alpha / fadeout / step_time;
            assert( decrement_alpha > 0, "<dev string:x55b>" );
            
            while ( current_alpha > 0 )
            {
                overlay.alpha = current_alpha;
                current_alpha -= decrement_alpha;
                wait step_time;
            }
        }
        
        if ( isdefined( overlay ) )
        {
            overlay.alpha = 0;
            overlay destroy();
        }
    }
    
    if ( isdefined( overlay ) )
    {
        if ( do_bob )
        {
            overlay thread function_87a0f8163f7a658b();
        }
        
        level.overlay = overlay;
        return level.overlay;
    }
}

// Namespace lighting
// Params 0
// Checksum 0x8bd36dd1, Offset: 0x58a6
// Size: 0x22
function wait_for_player()
{
    while ( !isdefined( level.player ) )
    {
        wait 0.05;
    }
    
    return level.player;
}

// Namespace lighting
// Params 0
// Checksum 0x9a8254dc, Offset: 0x58d1
// Size: 0x1b2
function function_87a0f8163f7a658b()
{
    bob_height = 60;
    walk_freq = 2;
    run_freq = 4;
    check_interval = 0.05;
    smooth_factor = 0.15;
    basey = self.y;
    angle = 0;
    currentscale = 0;
    
    while ( isdefined( self ) && isdefined( level.player ) && self.alpha > 0 )
    {
        vel = length( level.player getvelocity() );
        
        if ( vel > 10 )
        {
            if ( vel > 200 )
            {
                freq = run_freq;
            }
            else
            {
                freq = walk_freq;
            }
            
            targetscale = clamp( vel / 300, 0, 1 );
            currentscale += ( targetscale - currentscale ) * smooth_factor;
            angle += freq * check_interval * 360;
            
            if ( angle > 360 )
            {
                angle -= 360;
            }
            
            offset = sin( angle * 0.0174533 ) * bob_height * currentscale;
            self.y = basey + offset;
        }
        else
        {
            currentscale += ( 0 - currentscale ) * smooth_factor;
            
            if ( currentscale > 0.01 )
            {
                angle += 6.28318 * walk_freq * check_interval;
                
                if ( angle > 6.28318 )
                {
                    angle -= 6.28318;
                }
                
                offset = sin( angle ) * bob_height * currentscale;
                self.y = basey + offset;
            }
            else
            {
                self.y = basey;
                angle = 0;
            }
        }
        
        wait check_interval;
    }
}

// Namespace lighting
// Params 0
// Checksum 0xb5758394, Offset: 0x5a8b
// Size: 0x15
function cleanup_overlay()
{
    level waittill( #"hash_df48cbb22fefed9d" );
    self destroy();
}

// Namespace lighting
// Params 0
// Checksum 0x9691795a, Offset: 0x5aa8
// Size: 0x2
function blood_splatter_simple()
{
    
}

// Namespace lighting
// Params 0
// Checksum 0xd5ab49c0, Offset: 0x5ab2
// Size: 0x10e
function function_5e520fee0eb1c532()
{
    overlay = newclienthudelem( level.player );
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( "fullscreen_dirt_bottom", 640, 480 );
    overlay setshader( "fullscreen_dirt_bottom_b", 640, 480 );
    overlay setshader( "fullscreen_dirt_left", 640, 480 );
    overlay setshader( "fullscreen_dirt_right", 640, 480 );
    overlay.splatter = 1;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.foreground = 0;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay fadeovertime( 3 );
    overlay.alpha = 0;
}

// Namespace lighting
// Params 1
// Checksum 0xbab0622f, Offset: 0x5bc8
// Size: 0x375
function bob_mask( hudelement )
{
    self endon( #"hash_762db8e7669fc292" );
    weapidletime = 0;
    previousangles = level.player getplayerangles();
    offsety = 0;
    offsetx = 0;
    addyoffset = hudelement.y;
    addxoffset = hudelement.x;
    frametime = 0.05;
    
    while ( true )
    {
        if ( isdefined( hudelement ) )
        {
            angles = level.player getplayerangles();
            velocity = level.player getvelocity();
            zvelocity = velocity[ 2 ];
            velocity -= velocity * ( 0, 0, 1 );
            speedxy = length( velocity );
            stance = level.player getstance();
            speedscale = clamp( speedxy, 0, 280 ) / 280;
            var_5422a6c64f0a1ce1 = 0.1 + speedscale * 0.25;
            var_af3aba194d8e6a5e = 0.1 + speedscale * 0.25;
            bobscale = 1;
            
            if ( stance == "crouch" )
            {
                bobscale = 0.75;
            }
            
            if ( stance == "prone" )
            {
                bobscale = 0.4;
            }
            
            if ( stance == "stand" )
            {
                bobscale = 1;
            }
            
            idlespeed = 5;
            adsspeed = 0.9;
            playerads = level.player playerads();
            bobspeed = idlespeed * ( 1 - playerads ) + adsspeed * playerads;
            bobspeed *= 1 + speedscale * 2;
            var_e9d5f1eb2b1b5bdc = 5;
            var_b477308d4d1e9ee = var_e9d5f1eb2b1b5bdc * var_5422a6c64f0a1ce1 * bobscale;
            var_b477408d4d1ec21 = var_e9d5f1eb2b1b5bdc * var_af3aba194d8e6a5e * bobscale;
            weapidletime += frametime * 1000 * bobspeed;
            var_fe6367e851478950 = 57.2958;
            verticalbob = sin( weapidletime * 0.001 * var_fe6367e851478950 );
            horizontalbob = sin( weapidletime * 0.0007 * var_fe6367e851478950 );
            anglediffyaw = angleclamp180( angles[ 1 ] - previousangles[ 1 ] );
            anglediffyaw = clamp( anglediffyaw, -10, 10 );
            offsetxtarget = anglediffyaw / 10 * var_e9d5f1eb2b1b5bdc * ( 1 - var_5422a6c64f0a1ce1 );
            offsetxchange = offsetxtarget - offsetx;
            offsetx += clamp( offsetxchange, -1, 1 );
            offsetytarget = clamp( zvelocity, -200, 200 ) / 200 * var_e9d5f1eb2b1b5bdc * ( 1 - var_af3aba194d8e6a5e );
            offsetychange = offsetytarget - offsety;
            offsety += clamp( offsetychange, -0.6, 0.6 );
            hudelement moveovertime( 0.05 );
            hudelement.x = addxoffset + clamp( verticalbob * var_b477308d4d1e9ee + offsetx - var_e9d5f1eb2b1b5bdc, 0 - 2 * var_e9d5f1eb2b1b5bdc, 0 );
            hudelement.y = addyoffset + clamp( horizontalbob * var_b477408d4d1ec21 + offsety - var_e9d5f1eb2b1b5bdc, 0 - 2 * var_e9d5f1eb2b1b5bdc, 0 );
            previousangles = angles;
        }
        
        wait frametime;
    }
}

// Namespace lighting
// Params 4
// Checksum 0xec3c538f, Offset: 0x5f45
// Size: 0x241
function gasmask_on_player( bfadein, fadeouttime, fadeintime, darktime )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( bfadein ) )
    {
        bfadein = 1;
    }
    
    if ( !isdefined( fadeouttime ) )
    {
        fadeouttime = 0;
    }
    
    if ( !isdefined( fadeintime ) )
    {
        fadeintime = 1;
    }
    
    if ( !isdefined( darktime ) )
    {
        darktime = 0.25;
    }
    
    if ( bfadein )
    {
        hud_util::fade_out( fadeouttime );
    }
    
    self.gasmask_hud_elem = newclienthudelem( self );
    self.gasmask_hud_elem.x = 0;
    self.gasmask_hud_elem.y = 0;
    self.gasmask_hud_elem.horzalign = "fullscreen";
    self.gasmask_hud_elem.vertalign = "fullscreen";
    self.gasmask_hud_elem.foreground = 0;
    self.gasmask_hud_elem.sort = -1;
    self.gasmask_hud_elem setshader( "gasmask_overlay_delta2_top", 650, 138 );
    self.gasmask_hud_elem.alpha = 1;
    self.var_cf93329d2d7c7150 = newclienthudelem( self );
    self.var_cf93329d2d7c7150.x = 0;
    self.var_cf93329d2d7c7150.y = 352;
    self.var_cf93329d2d7c7150.horzalign = "fullscreen";
    self.var_cf93329d2d7c7150.vertalign = "fullscreen";
    self.var_cf93329d2d7c7150.foreground = 0;
    self.var_cf93329d2d7c7150.sort = -1;
    self.var_cf93329d2d7c7150 setshader( "gasmask_overlay_delta2_bottom", 650, 138 );
    self.var_cf93329d2d7c7150.alpha = 1;
    level.player utility::delaythread( 1, &gasmask_breathing );
    thread bob_mask( self.gasmask_hud_elem );
    thread bob_mask( self.var_cf93329d2d7c7150 );
    
    if ( bfadein )
    {
        wait darktime;
        hud_util::fade_in( fadeintime );
    }
}

// Namespace lighting
// Params 0
// Checksum 0x161a7a30, Offset: 0x618e
// Size: 0x97
function function_7563cae8bdc97c4b()
{
    assert( isplayer( self ) );
    hud_util::fade_out( 0.25 );
    self notify( #"hash_762db8e7669fc292" );
    
    if ( isdefined( self.gasmask_hud_elem ) )
    {
        self.gasmask_hud_elem destroy();
        self.gasmask_hud_elem = undefined;
    }
    
    if ( isdefined( self.var_cf93329d2d7c7150 ) )
    {
        self.var_cf93329d2d7c7150 destroy();
        self.var_cf93329d2d7c7150 = undefined;
    }
    
    level.player notify( #"stop_breathing" );
    wait 0.25;
    hud_util::fade_in( 1.5 );
}

// Namespace lighting
// Params 0
// Checksum 0xa6e16a70, Offset: 0x622d
// Size: 0x2a
function gasmask_breathing()
{
    delay = 1;
    self endon( #"stop_breathing" );
    
    while ( true )
    {
        wait delay;
    }
}

// Namespace lighting
// Params 0
// Checksum 0x8e8d0324, Offset: 0x625f
// Size: 0x62
function function_8cae23740cdf4c1()
{
    self.gasmask = spawn( "script_model", ( 0, 0, 0 ) );
    self.gasmask setmodel( "prop_sas_gasmask" );
    self.gasmask linkto( self, "tag_eye", ( -4, 0, 2 ), ( 120, 0, 0 ) );
}

// Namespace lighting
// Params 0
// Checksum 0xfbceec66, Offset: 0x62c9
// Size: 0x1d
function gasmask_off_npc()
{
    if ( isdefined( self.gasmask ) )
    {
        self.gasmask delete();
    }
}

// Namespace lighting
// Params 2
// Checksum 0x816e8808, Offset: 0x62ee
// Size: 0xc2
function sunshadowscale_lerp( time, targetsample )
{
    utility::noself_func( "setsaveddvar", @"sm_sunmoving", 1 );
    currframe = 0;
    numframes = time * 20;
    numframes_less = numframes - 1;
    currsample = getdvarfloat( @"sm_sunsamplesizenear" );
    
    while ( currframe < numframes )
    {
        var_5999a2f47d8ce6f9 = ( targetsample - currsample ) * currframe / numframes_less;
        var_5999a2f47d8ce6f9 += currsample;
        utility::noself_func( "setsaveddvar", @"sm_sunsamplesizenear", var_5999a2f47d8ce6f9 );
        currframe++;
        waitframe();
    }
    
    utility::noself_func( "setsaveddvar", @"sm_sunmoving", 0 );
}

// Namespace lighting
// Params 11
// Checksum 0x503a2bcb, Offset: 0x63b8
// Size: 0x2bc
function function_5ce0748a8bf40392( onoff, min_intensity, max_intensity, min_delay, max_delay, sun_color, flare_delay, var_ebb5a4dd27af9458, var_ebb5a7dd27af9af1, var_ebb5a6dd27af98be, var_ebb5a9dd27af9f57 )
{
    if ( isdefined( flare_delay ) )
    {
        wait flare_delay;
    }
    
    if ( !utility::flag_exist( "sky_flare_off" ) )
    {
        utility::flag_init( "sky_flare_off" );
        utility::flag_init( "sky_flare_flicker" );
    }
    
    if ( !utility::flag_exist( "flare_off" ) )
    {
        utility::flag_init( "flare_off" );
    }
    
    level.var_91c5a9cc2b6aa8 = 0;
    setsaveddvar( @"sm_suncascadesizemultiplier2", 1 );
    wait 0.05;
    
    if ( onoff == 1 )
    {
        utility::flag_clear( "sky_flare_off" );
    }
    else
    {
        utility::flag_set( "sky_flare_off" );
    }
    
    wait 0.1;
    setsaveddvar( @"sm_sunsamplesizenear", 0.4 );
    setsaveddvar( @"sm_sundistantshadows", 1 );
    setsaveddvar( @"sm_sunmoving", 1 );
    var_32f5e7cd8b5e8508 = getsuncolorandintensity();
    thread function_618e594176cb809a( var_32f5e7cd8b5e8508, [ sun_color[ 0 ], sun_color[ 1 ], sun_color[ 2 ], max_intensity ], 0.5 );
    flicker_delay = 0.5;
    thread flare_flicker( min_intensity, max_intensity, min_delay, max_delay, flicker_delay );
    utility::flag_set( "sky_flare_flicker" );
    wait 0.05;
    
    if ( isplatformxb4() || isplatformps5() || isplatformpc() )
    {
        setsaveddvar( @"hash_6e3f8cef6be16b33", 0 );
        setsaveddvar( @"hash_1ea8544d78048529", 1 );
    }
    
    if ( !utility::flag( "sky_flare_off" ) )
    {
        lerpsunangles( var_ebb5a4dd27af9458, var_ebb5a7dd27af9af1, 10 );
    }
    
    for ( i = 0; !utility::flag( "sky_flare_off" ) && i < 10 ; i++ )
    {
        wait 1;
    }
    
    wait 0.05;
    
    if ( !utility::flag( "sky_flare_off" ) )
    {
        lerpsunangles( var_ebb5a7dd27af9af1, var_ebb5a6dd27af98be, 20 );
    }
    
    for ( i = 0; !utility::flag( "sky_flare_off" ) && i < 20 ; i++ )
    {
        wait 1;
    }
    
    wait 0.05;
    
    if ( !utility::flag( "sky_flare_off" ) )
    {
        lerpsunangles( var_ebb5a6dd27af98be, var_ebb5a9dd27af9f57, 5 );
    }
    
    for ( i = 0; !utility::flag( "sky_flare_off" ) && i < 5 ; i++ )
    {
        wait 1;
    }
    
    thread function_ff2d516a50cd5f4a( sun_color, var_32f5e7cd8b5e8508, max_intensity );
    utility::flag_set( "sky_flare_off" );
    utility::flag_clear( "sky_flare_flicker" );
}

// Namespace lighting
// Params 5
// Checksum 0xfcca687e, Offset: 0x667c
// Size: 0xc9
function flare_flicker( min_intensity, max_intensity, min_delay, max_delay, flicker_delay )
{
    if ( isdefined( flicker_delay ) )
    {
        wait flicker_delay;
    }
    
    for ( old_intensity = max_intensity;  ; old_intensity = intensity )
    {
        utility::flag_wait( "sky_flare_flicker" );
        intensity = randomfloatrange( min_intensity, max_intensity );
        timer = clamp( randomfloatrange( min_delay, max_delay ), 0.5, 2 );
        
        for ( i = 0; i < timer ; i++ )
        {
            new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
            setsuncolorandintensity( new_intensity );
            wait 0.05;
        }
    }
}

// Namespace lighting
// Params 3
// Checksum 0x7a89ee76, Offset: 0x674d
// Size: 0x18b
function function_ff2d516a50cd5f4a( sun_color, var_32f5e7cd8b5e8508, max_intensity )
{
    if ( level.var_91c5a9cc2b6aa8 == 0 )
    {
        level.var_91c5a9cc2b6aa8++;
        iprintln( "5 second fade" );
        var_41a5da53961a7b84 = getsuncolorandintensity();
        wait 0.1;
        thread function_618e594176cb809a( [ sun_color[ 0 ], sun_color[ 1 ], sun_color[ 2 ], max_intensity ], var_32f5e7cd8b5e8508, 5 );
        lerpsunangles( getsunangles(), ( -48, 4, 0 ), 5 );
        wait 5.05;
        setsaveddvar( @"sm_sunsamplesizenear", 0.45 );
        setsaveddvar( @"sm_sundistantshadows", 0 );
        setsaveddvar( @"sm_spotdistcull", 750 );
        
        if ( isplatformxb4() || isplatformps5() || isplatformpc() )
        {
            setsaveddvar( @"sm_spotupdatelimit", 8 );
        }
        
        wait 0.05;
        
        if ( isplatformxb4() || isplatformps5() || isplatformpc() )
        {
            setsaveddvar( @"hash_6e3f8cef6be16b33", 1 );
            setsaveddvar( @"hash_1ea8544d78048529", 0 );
        }
        
        level.var_91c5a9cc2b6aa8--;
        utility::flag_set( "sky_flare_off" );
        utility::flag_clear( "sky_flare_flicker" );
        utility::flag_set( "flare_off" );
        wait 0.5;
        setsaveddvar( @"sm_sunmoving", 0 );
        level.var_91c5a9cc2b6aa8 = 0;
        level.var_cfc25b90d262ffe0 = 1;
    }
}

// Namespace lighting
// Params 0
// Checksum 0xfe94c9fb, Offset: 0x68e0
// Size: 0x1a
function function_5c6646f1e40d2984()
{
    utility::flag_set( "sky_flare_off" );
    utility::flag_clear( "sky_flare_flicker" );
}

// Namespace lighting
// Params 3
// Checksum 0x1353ec33, Offset: 0x6902
// Size: 0xd3
function function_618e594176cb809a( startsunlight, endsunlight, ftime )
{
    ftime = int( ftime * 20 );
    increment = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        increment[ i ] = ( startsunlight[ i ] - endsunlight[ i ] ) / ftime;
    }
    
    newsunlight = [];
    
    for ( i = 0; i < ftime ; i++ )
    {
        wait 0.05;
        
        for ( j = 0; j < 4 ; j++ )
        {
            newsunlight[ j ] = startsunlight[ j ] - increment[ j ] * i;
        }
        
        setsuncolorandintensity( newsunlight[ 0 ], newsunlight[ 1 ], newsunlight[ 2 ], newsunlight[ 3 ] );
    }
    
    setsuncolorandintensity( endsunlight[ 0 ], endsunlight[ 1 ], endsunlight[ 2 ], endsunlight[ 3 ] );
}

// Namespace lighting
// Params 2
// Checksum 0xc0ee3d47, Offset: 0x69dd
// Size: 0xf3
function lerp_volumetricdepth( time, target_value )
{
    level notify( #"changing_volumetricdepth" );
    level endon( #"changing_volumetricdepth" );
    old_value = getdvarfloat( @"r_volumetricdepth" );
    
    if ( !isdefined( old_value ) || target_value == old_value )
    {
        return;
    }
    
    start_time_ms = gettime();
    end_time_ms = gettime() + time * 1000;
    time_ms = time * 1000;
    
    while ( gettime() <= end_time_ms )
    {
        time_percentage = 1 - ( end_time_ms - gettime() ) / time_ms;
        var_e9d95fbb3fbad0d8 = math::lerp( old_value, target_value, time_percentage );
        utility::noself_func( "setsaveddvar", @"r_volumetricdepth", var_e9d95fbb3fbad0d8 );
        waitframe();
    }
    
    utility::noself_func( "setsaveddvar", @"r_volumetricdepth", target_value );
}

// Namespace lighting
// Params 0
// Checksum 0xa5997f96, Offset: 0x6ad8
// Size: 0x40
function function_106f7a793737d76()
{
    utility::flag_init( "enable_grass_dof" );
    utility::flag_init( "enable_grass_dof_crouch" );
    utility::flag_init( "enable_grass_dof_prone" );
    utility::flag_wait( "player_spawned_with_loadout" );
    thread function_c72a85058d5af2e5();
    thread function_20f62f84bfc93602();
}

// Namespace lighting
// Params 0
// Checksum 0xbc18480e, Offset: 0x6b20
// Size: 0xd9
function function_c72a85058d5af2e5()
{
    level.grass_dof_trigger_count = 0;
    grass_dof_triggers = getentarray( "DOF_GRASS_ON", #targetname );
    
    foreach ( grass_dof_trigger in grass_dof_triggers )
    {
        grass_dof_trigger thread monitor_grass_dof_trigger();
    }
    
    while ( true )
    {
        level waittill( #"grass_dof_trigger_count_updated" );
        waittillframeend();
        
        if ( level.grass_dof_trigger_count > 0 )
        {
            utility::flag_set( "enable_grass_dof" );
            continue;
        }
        
        utility::flag_clear( "enable_grass_dof" );
    }
}

// Namespace lighting
// Params 0
// Checksum 0x6152ed60, Offset: 0x6c01
// Size: 0x86
function monitor_grass_dof_trigger()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player enable_grass_dof_condition() )
        {
            level.grass_dof_trigger_count++;
            level notify( #"grass_dof_trigger_count_updated" );
            
            while ( player istouching( self ) && player enable_grass_dof_condition() )
            {
                wait 0.1;
            }
            
            level.grass_dof_trigger_count--;
            level notify( #"grass_dof_trigger_count_updated" );
        }
    }
}

// Namespace lighting
// Params 0
// Checksum 0x5c4c8a0d, Offset: 0x6c8f
// Size: 0x6b, Type: bool
function enable_grass_dof_condition()
{
    stance = self getstance();
    
    if ( stance != "stand" )
    {
        if ( stance == "crouch" )
        {
            utility::flag_set( "enable_grass_dof_crouch" );
            utility::flag_clear( "enable_grass_dof_prone" );
        }
        else if ( stance == "prone" )
        {
            utility::flag_set( "enable_grass_dof_prone" );
            utility::flag_clear( "enable_grass_dof_crouch" );
        }
        
        return true;
    }
    
    return false;
}

// Namespace lighting
// Params 0
// Checksum 0xea365c88, Offset: 0x6d03
// Size: 0x1ff
function function_20f62f84bfc93602()
{
    wait 0.05;
    
    while ( true )
    {
        utility::flag_wait( "enable_grass_dof" );
        
        while ( utility::flag( "enable_grass_dof" ) && utility::flag( "equipment_interact" ) == 0 )
        {
            level.player enablephysicaldepthoffieldscripting();
            
            if ( utility::flag( "enable_grass_dof_crouch" ) == 1 && utility::flag( "equipment_interact" ) == 0 )
            {
                level.player setphysicaldepthoffield( 2, 400 );
                level.player setphysicalviewmodeldepthoffield( 1, 25 );
                wait 0.1;
            }
            
            if ( utility::flag( "enable_grass_dof_prone" ) == 1 && utility::flag( "equipment_interact" ) == 0 )
            {
                level.player setphysicaldepthoffield( 0.25, 800 );
                level.player setphysicalviewmodeldepthoffield( 0.5, 25 );
                wait 0.1;
            }
            
            wait 0.1;
        }
        
        if ( utility::flag( "enable_grass_dof" ) && utility::flag( "equipment_interact" ) == 1 )
        {
            while ( utility::flag( "enable_grass_dof" ) && utility::flag( "equipment_interact" ) == 1 )
            {
                level.player enablephysicaldepthoffieldscripting();
                
                if ( utility::flag( "enable_grass_dof_crouch" ) == 1 && utility::flag( "equipment_interact" ) == 1 )
                {
                    level.player setphysicaldepthoffield( 2, 400 );
                    wait 0.1;
                }
                
                if ( utility::flag( "enable_grass_dof_prone" ) == 1 && utility::flag( "equipment_interact" ) == 1 )
                {
                    level.player setphysicaldepthoffield( 0.25, 800 );
                    wait 0.1;
                }
                
                level.player setphysicalviewmodeldepthoffield( 30, 20 );
                wait 0.1;
            }
        }
        
        level.player setphysicalviewmodeldepthoffield( 30, 20 );
        level.player disablephysicaldepthoffieldscripting();
        wait 0.1;
    }
}

// Namespace lighting
// Params 0
// Checksum 0x2bff6087, Offset: 0x6f0a
// Size: 0x10
function function_18463233a10eebf0()
{
    hwconfiguratoraddasset( %"hw_cine_lastgen" );
}

// Namespace lighting
// Params 0
// Checksum 0xa8a20d33, Offset: 0x6f22
// Size: 0x10
function function_716fed8b33f8726a()
{
    hwconfiguratorremoveasset( %"hw_cine_lastgen" );
}

// Namespace lighting
// Params 2
// Checksum 0x494140bd, Offset: 0x6f3a
// Size: 0x94
function function_de6758dd83b822c9( duration, end_value )
{
    self notify( #"hash_fd4fb154ea4ddfc9" );
    self endon( #"hash_fd4fb154ea4ddfc9" );
    self endon( #"death" );
    start_value = self getlightfovouter();
    wait 0.05;
    t = 0.05;
    
    while ( t <= duration )
    {
        self setlightfovrange( math::lerp( start_value, end_value, t / duration ) );
        wait 0.05;
        t += 0.05;
    }
    
    self setlightfovrange( end_value );
}

// Namespace lighting
// Params 2
// Checksum 0xaaf8e46a, Offset: 0x6fd6
// Size: 0x94
function lerplightradius( duration, end_value )
{
    self notify( #"hash_fe58300f418979e8" );
    self endon( #"hash_fe58300f418979e8" );
    self endon( #"death" );
    start_value = self getlightradius();
    wait 0.05;
    t = 0.05;
    
    while ( t <= duration )
    {
        self setlightradius( math::lerp( start_value, end_value, t / duration ) );
        wait 0.05;
        t += 0.05;
    }
    
    self setlightradius( end_value );
}

// Namespace lighting
// Params 2
// Checksum 0xc5630f37, Offset: 0x7072
// Size: 0x73
function function_41f369b6b08bf95c( time, endsunintensity )
{
    startsunintensity = getsuncolorandintensity();
    t = 0;
    
    while ( t < time )
    {
        new_sunintensity = startsunintensity[ 3 ] + ( endsunintensity - startsunintensity[ 3 ] ) * t / time;
        t += 0.05;
        setsuncolorandintensity( new_sunintensity );
        wait 0.05;
    }
    
    setsuncolorandintensity( endsunintensity );
}

// Namespace lighting
// Params 2
// Checksum 0x45cefd14, Offset: 0x70ed
// Size: 0xc5
function function_5c214bd22bd73c2e( time, endsuncolor )
{
    startsuncolor = getsuncolorandintensity();
    start_intensity = startsuncolor[ 3 ];
    t = 0;
    
    while ( t < time )
    {
        new_suncolor = [ startsuncolor[ 0 ] + ( endsuncolor[ 0 ] - startsuncolor[ 0 ] ) * t / time, startsuncolor[ 1 ] + ( endsuncolor[ 1 ] - startsuncolor[ 1 ] ) * t / time, startsuncolor[ 2 ] + ( endsuncolor[ 2 ] - startsuncolor[ 2 ] ) * t / time ];
        t += 0.05;
        setsuncolorandintensity( new_suncolor[ 0 ], new_suncolor[ 1 ], new_suncolor[ 2 ] );
        wait 0.05;
    }
    
    setsuncolorandintensity( endsuncolor[ 0 ], endsuncolor[ 1 ], endsuncolor[ 2 ] );
}

// Namespace lighting
// Params 1
// Checksum 0x507cbd16, Offset: 0x71ba
// Size: 0x95
function accelerating_lerp( timeleft )
{
    level.accelerationfactor = 1;
    finalacceleration = 0.03;
    stepsize = ( level.accelerationfactor - finalacceleration ) / timeleft * 20;
    
    while ( level.accelerationfactor > finalacceleration )
    {
        level.accelerationfactor -= stepsize;
        
        if ( level.accelerationfactor < finalacceleration )
        {
            level.accelerationfactor = finalacceleration;
        }
        
        wait 0.05;
        timeleft -= 0.05;
    }
}

/#

    // Namespace lighting
    // Params 0, eflags: 0x4
    // Checksum 0x177aa67f, Offset: 0x7257
    // Size: 0xb5, Type: dev
    function private function_f0ca62c2263b30cf()
    {
        setdvarifuninitialized( @"hash_49acd06fabbd1dd3", 0 );
        
        if ( getdvarint( @"hash_49acd06fabbd1dd3" ) == 1 )
        {
            reference_triggers = getentarray( "<dev string:x57f>", #classname );
            
            foreach ( trigger in reference_triggers )
            {
                thread function_71be7ae1354f2d62( trigger );
            }
        }
    }

#/

// Namespace lighting
// Params 1, eflags: 0x4
// Checksum 0x36bc546c, Offset: 0x7314
// Size: 0x141
function private function_71be7ae1354f2d62( trigger )
{
    delete_trigger = 1;
    
    /#
        delete_trigger = 0;
        
        if ( !isdefined( trigger.script_noteworthy ) )
        {
            return;
        }
        
        settings = function_12247a14b44bd68a( trigger.script_parameters );
        
        while ( true )
        {
            trigger waittill( #"trigger", other );
            
            if ( !isalive( other ) || !isplayer( other ) )
            {
                continue;
            }
            
            setrefimage( trigger.script_noteworthy );
            
            if ( utility::issp() )
            {
                setsaveddvar( @"hash_ac4e80946d58eaf", settings[ "<dev string:x5a0>" ] );
                setsaveddvar( @"hash_28b6983a06668e89", "<dev string:x5a9>" );
            }
            else
            {
                setdvar( @"hash_ac4e80946d58eaf", settings[ "<dev string:x5a0>" ] );
                setdvar( @"hash_28b6983a06668e89", "<dev string:x5a9>" );
            }
            
            while ( other istouching( trigger ) )
            {
                wait 0.1;
            }
            
            if ( utility::issp() )
            {
                setsaveddvar( @"hash_28b6983a06668e89", "<dev string:x5ab>" );
                continue;
            }
            
            setdvar( @"hash_28b6983a06668e89", "<dev string:x5ab>" );
        }
    #/
    
    if ( delete_trigger )
    {
        trigger delete();
    }
}

/#

    // Namespace lighting
    // Params 1, eflags: 0x4
    // Checksum 0x33c96ba4, Offset: 0x745d
    // Size: 0xb5, Type: dev
    function private function_12247a14b44bd68a( param_string )
    {
        setting = [];
        bound = "<dev string:x5ad>";
        stop_adj = "<dev string:x5ab>";
        
        if ( !isdefined( param_string ) || param_string == "<dev string:x3f4>" )
        {
            setting[ "<dev string:x5a0>" ] = stop_adj;
            setting[ "<dev string:x5b7>" ] = bound;
            return setting;
        }
        
        string_tokens = strtok( param_string, "<dev string:x5bd>" );
        
        if ( string_tokens.size == 1 )
        {
            bound = string_tokens[ 0 ];
        }
        else if ( string_tokens.size == 2 )
        {
            bound = string_tokens[ 0 ];
            stop_adj = string_tokens[ 1 ];
        }
        
        setting[ "<dev string:x5a0>" ] = stop_adj;
        setting[ "<dev string:x5b7>" ] = bound;
        return setting;
    }

#/

// Namespace lighting
// Params 4
// Checksum 0x3117d150, Offset: 0x751a
// Size: 0x34
function sky_explosions( var_77c0038ca14d55ab, var_33d776c0ac00c210, var_9abc040ae62a6dc7, overrides )
{
    explosions( var_77c0038ca14d55ab, var_33d776c0ac00c210, var_9abc040ae62a6dc7, overrides );
}

// Namespace lighting
// Params 4
// Checksum 0xea22a7a3, Offset: 0x7556
// Size: 0x140
function explosions( var_77c0038ca14d55ab, var_33d776c0ac00c210, var_9abc040ae62a6dc7, overrides )
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        level.var_4ef948ecac046df4 = spawnstruct();
    }
    
    function_e39b05585f7574a6();
    wait 0.05;
    function_2e53a7448b96614();
    level.var_4ef948ecac046df4.settings = function_966f4a18e362de7d( var_77c0038ca14d55ab, var_33d776c0ac00c210, var_9abc040ae62a6dc7, overrides );
    println( "<dev string:x5bf>" + var_77c0038ca14d55ab );
    level.var_4ef948ecac046df4.interrupt_now = 0;
    level.var_4ef948ecac046df4.active = 1;
    level.var_4ef948ecac046df4.looping = 1;
    level.var_4ef948ecac046df4.stop_requested = 0;
    level.var_4ef948ecac046df4.pause_random = 0;
    level.var_4ef948ecac046df4.token = randomint( 1073741823 );
    thread function_133af968973d383f( level.var_4ef948ecac046df4.token );
    thread function_29dfab2e7cec5359( level.var_4ef948ecac046df4.token );
}

// Namespace lighting
// Params 0
// Checksum 0x7bb52b69, Offset: 0x769e
// Size: 0x71
function function_5737ca5aee1d4841()
{
    if ( isdefined( level.var_4ef948ecac046df4 ) )
    {
        level.var_4ef948ecac046df4.interrupt_now = 1;
        level notify( #"hash_7276b3ad2264459b" );
        level.var_4ef948ecac046df4.active = 0;
        level.var_4ef948ecac046df4.looping = 0;
        level.var_4ef948ecac046df4.stop_requested = 1;
    }
}

// Namespace lighting
// Params 1
// Checksum 0x42e28628, Offset: 0x7717
// Size: 0x57
function function_5c37bbc522578726( optoverrides )
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    req = spawnstruct();
    req.when = gettime();
    req.over = optoverrides;
    level notify( #"hash_a54993727165465e", req );
}

// Namespace lighting
// Params 2
// Checksum 0x3d1b9b63, Offset: 0x7776
// Size: 0x71
function function_93fb0de1f3d81787( times_array, optoverrides )
{
    if ( !isdefined( times_array ) )
    {
        return;
    }
    
    startt = gettime();
    
    for ( i = 0; i < times_array.size ; i++ )
    {
        target = startt + times_array[ i ] * 1000;
        
        while ( gettime() < target )
        {
            waitframe();
        }
        
        function_5c37bbc522578726( optoverrides );
    }
}

// Namespace lighting
// Params 2
// Checksum 0xaddafca6, Offset: 0x77ef
// Size: 0x50
function function_152cac85b5a5c7e9( dpitch, dheading )
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    level.var_4ef948ecac046df4.var_23b91e1571d4b610 = dpitch;
    level.var_4ef948ecac046df4.var_1c4ba325d3ea1070 = dheading;
}

// Namespace lighting
// Params 0
// Checksum 0x6bae664b, Offset: 0x7847
// Size: 0x3b
function function_dfc4f8458f90f62e()
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    level.var_4ef948ecac046df4.var_23b91e1571d4b610 = 0;
    level.var_4ef948ecac046df4.var_1c4ba325d3ea1070 = 0;
}

// Namespace lighting
// Params 0
// Checksum 0x91a17b77, Offset: 0x788a
// Size: 0x109
function function_e39b05585f7574a6()
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        level.var_4ef948ecac046df4 = spawnstruct();
    }
    
    if ( !level.var_4ef948ecac046df4.var_bec32022dc09360c )
    {
        if ( isdefined( level.var_b7b2880892025632 ) && isdefined( level.var_b73be4064bd5558 ) )
        {
            level.var_4ef948ecac046df4.var_7a3aa2882ec27409 = level.var_b7b2880892025632;
            osi = level.var_b73be4064bd5558;
            InvalidOpCode( 0x59, osi[ 0 ], osi[ 1 ], osi[ 2 ], osi[ 3 ] );
            // Unknown operator ( 0x59, t11, Black Ops 7 )
        }
        
        ci = getsuncolorandintensity();
        InvalidOpCode( 0x59, ci[ 0 ], ci[ 1 ], ci[ 2 ], ci[ 3 ] );
        // Unknown operator ( 0x59, t11, Black Ops 7 )
    }
}

// Namespace lighting
// Params 0
// Checksum 0x7c99611f, Offset: 0x799b
// Size: 0x7d
function function_2e53a7448b96614()
{
    if ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.var_bec32022dc09360c )
    {
        ci = level.var_4ef948ecac046df4.var_798957ac1ee8996e;
        dir = level.var_4ef948ecac046df4.var_7a3aa2882ec27409;
        setsuncolorandintensity( ci[ 0 ], ci[ 1 ], ci[ 2 ], ci[ 3 ] );
        setsundirection( dir );
    }
}

// Namespace lighting
// Params 4
// Checksum 0xbe1b9ec3, Offset: 0x7a20
// Size: 0xb12
function function_966f4a18e362de7d( masterintensity, intensityoverride, frequencyoverride, overrides )
{
    defaults = spawnstruct();
    
    if ( !isdefined( level.var_4ef948ecac046df4.var_23b91e1571d4b610 ) )
    {
        level.var_4ef948ecac046df4.var_23b91e1571d4b610 = 0;
    }
    
    if ( !isdefined( level.var_4ef948ecac046df4.var_1c4ba325d3ea1070 ) )
    {
        level.var_4ef948ecac046df4.var_1c4ba325d3ea1070 = 0;
    }
    
    defaults.set_count_min = 1;
    defaults.set_count_max = 4;
    defaults.var_d85290a99d1d00fd = 8000;
    defaults.var_d86492a99d3142bf = 500;
    defaults.var_5c4e0c6b9308d3f3 = 16000;
    defaults.var_5c5f2a6b931b2049 = 1000;
    defaults.var_2db29528a6c1dced = 1.5;
    defaults.var_2dc39728a6d3ebaf = 0.1;
    defaults.var_b980b7fe2d6fec7b = 3;
    defaults.var_b99295fe2d83df11 = 0.3;
    defaults.ramp_in_lo = 0.8;
    defaults.ramp_in_hi = 0.08;
    defaults.ramp_out_lo = 0.8;
    defaults.ramp_out_hi = 0.12;
    defaults.var_9ba56192d374251b = 0.0005;
    defaults.var_9bb63f92d385e4b1 = 0.008;
    defaults.var_5579bec2a318210d = 0.02;
    defaults.var_558bc0c2a32c62cf = 0.35;
    defaults.pitch_min = -30;
    defaults.pitch_max = -25;
    defaults.heading_min = 179;
    defaults.heading_max = 181;
    defaults.color_1 = ( 1, 0.85, 0.7 );
    defaults.color_2 = ( 1, 0.7, 0.54 );
    defaults.var_637b9d49a3884d18 = 0.5;
    defaults.var_9016292e320056f9 = 0.02;
    
    if ( isdefined( overrides ) )
    {
        if ( isdefined( overrides.set_count_min ) )
        {
            defaults.set_count_min = overrides.set_count_min;
        }
        
        if ( isdefined( overrides.set_count_max ) )
        {
            defaults.set_count_max = overrides.set_count_max;
        }
        
        if ( isdefined( overrides.var_d85290a99d1d00fd ) )
        {
            defaults.var_d85290a99d1d00fd = overrides.var_d85290a99d1d00fd;
        }
        
        if ( isdefined( overrides.var_d86492a99d3142bf ) )
        {
            defaults.var_d86492a99d3142bf = overrides.var_d86492a99d3142bf;
        }
        
        if ( isdefined( overrides.var_5c4e0c6b9308d3f3 ) )
        {
            defaults.var_5c4e0c6b9308d3f3 = overrides.var_5c4e0c6b9308d3f3;
        }
        
        if ( isdefined( overrides.var_5c5f2a6b931b2049 ) )
        {
            defaults.var_5c5f2a6b931b2049 = overrides.var_5c5f2a6b931b2049;
        }
        
        if ( isdefined( overrides.var_2db29528a6c1dced ) )
        {
            defaults.var_2db29528a6c1dced = overrides.var_2db29528a6c1dced;
        }
        
        if ( isdefined( overrides.var_2dc39728a6d3ebaf ) )
        {
            defaults.var_2dc39728a6d3ebaf = overrides.var_2dc39728a6d3ebaf;
        }
        
        if ( isdefined( overrides.var_b980b7fe2d6fec7b ) )
        {
            defaults.var_b980b7fe2d6fec7b = overrides.var_b980b7fe2d6fec7b;
        }
        
        if ( isdefined( overrides.var_b99295fe2d83df11 ) )
        {
            defaults.var_b99295fe2d83df11 = overrides.var_b99295fe2d83df11;
        }
        
        if ( isdefined( overrides.ramp_in_lo ) )
        {
            defaults.ramp_in_lo = overrides.ramp_in_lo;
        }
        
        if ( isdefined( overrides.ramp_in_hi ) )
        {
            defaults.ramp_in_hi = overrides.ramp_in_hi;
        }
        
        if ( isdefined( overrides.ramp_out_lo ) )
        {
            defaults.ramp_out_lo = overrides.ramp_out_lo;
        }
        
        if ( isdefined( overrides.ramp_out_hi ) )
        {
            defaults.ramp_out_hi = overrides.ramp_out_hi;
        }
        
        if ( isdefined( overrides.var_9ba56192d374251b ) )
        {
            defaults.var_9ba56192d374251b = overrides.var_9ba56192d374251b;
        }
        
        if ( isdefined( overrides.var_9bb63f92d385e4b1 ) )
        {
            defaults.var_9bb63f92d385e4b1 = overrides.var_9bb63f92d385e4b1;
        }
        
        if ( isdefined( overrides.var_5579bec2a318210d ) )
        {
            defaults.var_5579bec2a318210d = overrides.var_5579bec2a318210d;
        }
        
        if ( isdefined( overrides.var_558bc0c2a32c62cf ) )
        {
            defaults.var_558bc0c2a32c62cf = overrides.var_558bc0c2a32c62cf;
        }
        
        if ( isdefined( overrides.pitch_min ) )
        {
            defaults.pitch_min = overrides.pitch_min;
        }
        
        if ( isdefined( overrides.pitch_max ) )
        {
            defaults.pitch_max = overrides.pitch_max;
        }
        
        if ( isdefined( overrides.heading_min ) )
        {
            defaults.heading_min = overrides.heading_min;
        }
        
        if ( isdefined( overrides.heading_max ) )
        {
            defaults.heading_max = overrides.heading_max;
        }
        
        if ( isdefined( overrides.color_1 ) )
        {
            defaults.color_1 = overrides.color_1;
        }
        
        if ( isdefined( overrides.color_2 ) )
        {
            defaults.color_2 = overrides.color_2;
        }
        
        if ( isdefined( overrides.var_637b9d49a3884d18 ) )
        {
            defaults.var_637b9d49a3884d18 = overrides.var_637b9d49a3884d18;
        }
        
        if ( isdefined( overrides.var_9016292e320056f9 ) )
        {
            defaults.var_9016292e320056f9 = overrides.var_9016292e320056f9;
        }
    }
    
    master = _clamp_int( masterintensity, 1, 10 );
    
    if ( isdefined( intensityoverride ) )
    {
        idial = _clamp_int( intensityoverride, 1, 10 );
    }
    else
    {
        idial = master;
    }
    
    if ( isdefined( frequencyoverride ) )
    {
        fdial = _clamp_int( frequencyoverride, 1, 10 );
    }
    else
    {
        fdial = master;
    }
    
    MT = ( master - 1 ) / 9;
    it = ( idial - 1 ) / 9;
    ft = ( fdial - 1 ) / 9;
    s = spawnstruct();
    s.delay_min_ms = _lerp( defaults.var_d85290a99d1d00fd, defaults.var_d86492a99d3142bf, MT );
    s.delay_max_ms = _lerp( defaults.var_5c4e0c6b9308d3f3, defaults.var_5c5f2a6b931b2049, MT );
    s.set_count_min = defaults.set_count_min;
    s.set_count_max = int( _lerp( defaults.set_count_min + 1, defaults.set_count_max, MT ) );
    
    if ( s.set_count_max <= s.set_count_min )
    {
        s.set_count_max = s.set_count_min + 1;
    }
    
    s.freq_min = _lerp( defaults.var_2db29528a6c1dced, defaults.var_2dc39728a6d3ebaf, ft );
    s.freq_max = _lerp( defaults.var_b980b7fe2d6fec7b, defaults.var_b99295fe2d83df11, ft );
    
    if ( isdefined( overrides ) && isdefined( overrides.freq_scale ) )
    {
        s.freq_min *= overrides.freq_scale;
        s.freq_max *= overrides.freq_scale;
    }
    else if ( isdefined( level.var_4ef948ecac046df4 ) && isdefined( level.var_4ef948ecac046df4.settings ) && isdefined( level.var_4ef948ecac046df4.settings.freq_scale ) )
    {
        s.freq_min *= level.var_4ef948ecac046df4.settings.freq_scale;
        s.freq_max *= level.var_4ef948ecac046df4.settings.freq_scale;
    }
    else if ( isdefined( level.var_d9b0dda8f69e8b57 ) && isdefined( level.var_d9b0dda8f69e8b57.freq_scale ) )
    {
        s.freq_min *= level.var_d9b0dda8f69e8b57.freq_scale;
        s.freq_max *= level.var_d9b0dda8f69e8b57.freq_scale;
    }
    
    s.ramp_in_min = _lerp( defaults.ramp_in_lo, defaults.ramp_in_hi, MT );
    s.ramp_in_max = s.ramp_in_min + 0.02;
    s.ramp_out_min = _lerp( defaults.ramp_out_lo, defaults.ramp_out_hi, MT );
    s.ramp_out_max = s.ramp_out_min + 0.02;
    s.var_aa2027447d7ae155 = _lerp( defaults.var_9ba56192d374251b, defaults.var_9bb63f92d385e4b1, it );
    s.sun_int_max = _lerp( defaults.var_5579bec2a318210d, defaults.var_558bc0c2a32c62cf, it );
    s.pitch_min = defaults.pitch_min;
    s.pitch_max = defaults.pitch_max;
    s.heading_min = defaults.heading_min;
    s.heading_max = defaults.heading_max;
    s.color_1 = defaults.color_1;
    s.color_2 = defaults.color_2;
    s.var_637b9d49a3884d18 = defaults.var_637b9d49a3884d18;
    s.var_9016292e320056f9 = defaults.var_9016292e320056f9;
    return s;
}

// Namespace lighting
// Params 1
// Checksum 0x43bc2992, Offset: 0x853b
// Size: 0x3f9
function function_133af968973d383f( token )
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    level.var_4ef948ecac046df4.running = 1;
    level.var_4ef948ecac046df4.instrike = 0;
    level.var_4ef948ecac046df4.stop_requested = 0;
    var_adb2d43511f1cea3 = getsuncolorandintensity();
    var_cb7660ed636001ca = anglestoforward( getsunangles() );
    thread function_b0aebe3c6ee34f06( token, var_adb2d43511f1cea3, var_cb7660ed636001ca );
    wait 0.05;
    
    while ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.looping && level.var_4ef948ecac046df4.token == token && !level.var_4ef948ecac046df4.stop_requested )
    {
        if ( !level.var_4ef948ecac046df4.active )
        {
            wait 0.05;
            continue;
        }
        
        if ( isdefined( level.var_4ef948ecac046df4.pause_random ) && level.var_4ef948ecac046df4.pause_random )
        {
            waitframe();
            continue;
        }
        
        settings = level.var_4ef948ecac046df4.settings;
        
        while ( isdefined( level.var_4ef948ecac046df4.pause_random ) && level.var_4ef948ecac046df4.pause_random )
        {
            waitframe();
        }
        
        setcount = randomintrange( settings.set_count_min, settings.set_count_max );
        
        if ( setcount <= 0 )
        {
            setcount = 1;
        }
        
        for ( i = 0; i < setcount ; i++ )
        {
            if ( level.var_4ef948ecac046df4.stop_requested )
            {
                break;
            }
            
            while ( level.var_4ef948ecac046df4.instrike )
            {
                waitframe();
            }
            
            level.var_4ef948ecac046df4.instrike = 1;
            function_94ec34318067f090( settings, var_adb2d43511f1cea3, var_cb7660ed636001ca, undefined );
            wait settings.var_9016292e320056f9;
            level.var_4ef948ecac046df4.instrike = 0;
            
            if ( i < setcount - 1 )
            {
                wait randomfloatrange( settings.freq_min, settings.freq_max );
            }
        }
        
        if ( level.var_4ef948ecac046df4.stop_requested )
        {
            break;
        }
        
        nextms = randomfloatrange( settings.delay_min_ms, settings.delay_max_ms );
        targett = gettime() + nextms;
        applied = 0;
        var_71dae2b18151b0fd = 500;
        var_fcfe38af9e4c5841 = 0;
        
        while ( gettime() < targett && level.var_4ef948ecac046df4.token == token && !level.var_4ef948ecac046df4.stop_requested )
        {
            if ( isdefined( level.var_4ef948ecac046df4.pause_random ) && level.var_4ef948ecac046df4.pause_random )
            {
                waitframe();
                continue;
            }
            
            if ( level.player playerads() == 1 && !applied )
            {
                if ( !var_fcfe38af9e4c5841 )
                {
                    var_fcfe38af9e4c5841 = gettime();
                }
                
                if ( gettime() >= var_fcfe38af9e4c5841 + var_71dae2b18151b0fd )
                {
                    remain = max( 0, targett - gettime() );
                    targett = gettime() + remain * settings.var_637b9d49a3884d18;
                    applied = 1;
                }
            }
            else
            {
                var_fcfe38af9e4c5841 = 0;
            }
            
            waitframe();
        }
    }
    
    setsuncolorandintensity( var_adb2d43511f1cea3[ 0 ], var_adb2d43511f1cea3[ 1 ], var_adb2d43511f1cea3[ 2 ], var_adb2d43511f1cea3[ 3 ] );
    setsundirection( var_cb7660ed636001ca );
    level.var_4ef948ecac046df4.running = 0;
    level.var_4ef948ecac046df4.instrike = 0;
}

// Namespace lighting
// Params 3
// Checksum 0x85134a38, Offset: 0x893c
// Size: 0x96
function function_b0aebe3c6ee34f06( token, var_adb2d43511f1cea3, var_cb7660ed636001ca )
{
    self endon( #"kill" );
    level waittill( #"hash_7276b3ad2264459b" );
    
    if ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.token == token )
    {
        level.var_4ef948ecac046df4.stop_requested = 1;
        setsuncolorandintensity( var_adb2d43511f1cea3[ 0 ], var_adb2d43511f1cea3[ 1 ], var_adb2d43511f1cea3[ 2 ], var_adb2d43511f1cea3[ 3 ] );
        setsundirection( var_cb7660ed636001ca );
        function_2e53a7448b96614();
    }
}

// Namespace lighting
// Params 1
// Checksum 0x4cc58642, Offset: 0x89da
// Size: 0x190
function function_29dfab2e7cec5359( token )
{
    self endon( #"kill" );
    
    for ( ;; )
    {
        level waittill( #"hash_a54993727165465e", req );
        
        if ( !isdefined( level.var_4ef948ecac046df4 ) )
        {
            continue;
        }
        
        if ( level.var_4ef948ecac046df4.token != token )
        {
            continue;
        }
        
        if ( level.var_4ef948ecac046df4.stop_requested )
        {
            continue;
        }
        
        level.var_4ef948ecac046df4.pause_random = 1;
        level.var_4ef948ecac046df4.interrupt_now = 1;
        timeout = gettime() + 200;
        
        while ( level.var_4ef948ecac046df4.instrike && gettime() < timeout )
        {
            waitframe();
        }
        
        level.var_4ef948ecac046df4.interrupt_now = 0;
        level.var_4ef948ecac046df4.instrike = 1;
        var_adb2d43511f1cea3 = getsuncolorandintensity();
        var_cb7660ed636001ca = anglestoforward( getsunangles() );
        settings = level.var_4ef948ecac046df4.settings;
        function_94ec34318067f090( settings, var_adb2d43511f1cea3, var_cb7660ed636001ca, req.over );
        wait settings.var_9016292e320056f9;
        level.var_4ef948ecac046df4.instrike = 0;
        level.var_4ef948ecac046df4.pause_random = 0;
    }
}

// Namespace lighting
// Params 4
// Checksum 0x83bc1094, Offset: 0x8b72
// Size: 0x4bc
function function_94ec34318067f090( settings, var_adb2d43511f1cea3, var_cb7660ed636001ca, optoverrides )
{
    r_in_min = settings.ramp_in_min;
    r_in_max = settings.ramp_in_max;
    r_out_min = settings.ramp_out_min;
    r_out_max = settings.ramp_out_max;
    sun_min = settings.var_aa2027447d7ae155;
    sun_max = settings.sun_int_max;
    pitch_min = settings.pitch_min;
    pitch_max = settings.pitch_max;
    heading_min = settings.heading_min;
    heading_max = settings.heading_max;
    color1 = settings.color_1;
    color2 = settings.color_2;
    
    if ( isdefined( optoverrides ) )
    {
        if ( isdefined( optoverrides.ramp_in ) )
        {
            r_in_min = optoverrides.ramp_in;
            r_in_max = optoverrides.ramp_in;
        }
        
        if ( isdefined( optoverrides.ramp_out ) )
        {
            r_out_min = optoverrides.ramp_out;
            r_out_max = optoverrides.ramp_out;
        }
        
        if ( isdefined( optoverrides.var_aa2027447d7ae155 ) )
        {
            sun_min = optoverrides.var_aa2027447d7ae155;
        }
        
        if ( isdefined( optoverrides.sun_int_max ) )
        {
            sun_max = optoverrides.sun_int_max;
        }
        
        if ( isdefined( optoverrides.color_1 ) )
        {
            color1 = optoverrides.color_1;
        }
        
        if ( isdefined( optoverrides.color_2 ) )
        {
            color2 = optoverrides.color_2;
        }
        
        if ( isdefined( optoverrides.pitch ) && isdefined( optoverrides.heading ) )
        {
            pitch_min = optoverrides.pitch;
            pitch_max = optoverrides.pitch;
            heading_min = optoverrides.heading;
            heading_max = optoverrides.heading;
        }
    }
    
    rampin = randomfloatrange( r_in_min, r_in_max );
    rampout = randomfloatrange( r_out_min, r_out_max );
    pitch = randomfloatrange( pitch_min, pitch_max );
    heading = randomfloatrange( heading_min, heading_max );
    
    if ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.interrupt_now )
    {
        setsuncolorandintensity( var_adb2d43511f1cea3[ 0 ], var_adb2d43511f1cea3[ 1 ], var_adb2d43511f1cea3[ 2 ], var_adb2d43511f1cea3[ 3 ] );
        setsundirection( var_cb7660ed636001ca );
        return 0;
    }
    
    offsets = function_33c3b7816ee10899();
    dpitch = offsets[ 0 ];
    dhead = offsets[ 1 ];
    var_7115b244d5d12699 = _normalize_angle( pitch + dpitch );
    var_c66ec0b170dc84cd = _normalize_angle( heading + dhead );
    newdir = anglestoforward( ( var_7115b244d5d12699, var_c66ec0b170dc84cd, 0 ) );
    setsundirection( newdir );
    goalcolor = _lerp_vec( color1, color2, randomfloat( 1 ) );
    targeti = randomfloatrange( sun_min, sun_max );
    payload = spawnstruct();
    payload.pitch = var_7115b244d5d12699;
    payload.heading = var_c66ec0b170dc84cd;
    payload.color = goalcolor;
    payload.targeti = targeti;
    payload.ramp_in = rampin;
    payload.ramp_out = rampout;
    payload.is_forced = isdefined( optoverrides );
    level notify( #"hash_2bf65f690f189161", payload );
    setsaveddvar( @"hash_9074557c61a7a214", 1 );
    setsuncolorandintensity( goalcolor[ 0 ], goalcolor[ 1 ], goalcolor[ 2 ], var_adb2d43511f1cea3[ 3 ] );
    function_9e8626ae799423bc( goalcolor, var_adb2d43511f1cea3[ 3 ], targeti, rampin );
    
    if ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.interrupt_now )
    {
        setsuncolorandintensity( var_adb2d43511f1cea3[ 0 ], var_adb2d43511f1cea3[ 1 ], var_adb2d43511f1cea3[ 2 ], var_adb2d43511f1cea3[ 3 ] );
        setsundirection( var_cb7660ed636001ca );
        setsaveddvar( @"hash_9074557c61a7a214", 0 );
        level notify( #"hash_627a4c89273bcb11", payload );
        return rampin;
    }
    
    function_9e8626ae799423bc( goalcolor, targeti, var_adb2d43511f1cea3[ 3 ], rampout );
    setsuncolorandintensity( var_adb2d43511f1cea3[ 0 ], var_adb2d43511f1cea3[ 1 ], var_adb2d43511f1cea3[ 2 ], var_adb2d43511f1cea3[ 3 ] );
    setsundirection( var_cb7660ed636001ca );
    setsaveddvar( @"hash_9074557c61a7a214", 0 );
    level notify( #"hash_627a4c89273bcb11", payload );
    return rampin + rampout;
}

// Namespace lighting
// Params 3
// Checksum 0xd82970de, Offset: 0x9037
// Size: 0x42
function _clamp_int( v, lo, hi )
{
    if ( !isdefined( v ) )
    {
        return lo;
    }
    
    if ( v < lo )
    {
        return lo;
    }
    
    if ( v > hi )
    {
        return hi;
    }
    
    return int( v );
}

// Namespace lighting
// Params 3
// Checksum 0x3898e1f, Offset: 0x9082
// Size: 0x27
function _lerp( a, b, t )
{
    return a + ( b - a ) * t;
}

// Namespace lighting
// Params 3
// Checksum 0x850581a5, Offset: 0x90b2
// Size: 0x4d
function _lerp_vec( a, b, t )
{
    return ( _lerp( a[ 0 ], b[ 0 ], t ), _lerp( a[ 1 ], b[ 1 ], t ), _lerp( a[ 2 ], b[ 2 ], t ) );
}

// Namespace lighting
// Params 4
// Checksum 0x40a5c7a1, Offset: 0x9108
// Size: 0x12e
function function_9e8626ae799423bc( colorvec, fromi, toi, dur )
{
    r = colorvec[ 0 ];
    g = colorvec[ 1 ];
    b = colorvec[ 2 ];
    starti = fromi;
    range = toi - starti;
    steps = max( 1, int( dur / 0.05 ) );
    delta = range / steps;
    cur = starti;
    
    for ( i = 0; i < steps ; i++ )
    {
        if ( isdefined( level.var_4ef948ecac046df4 ) && level.var_4ef948ecac046df4.interrupt_now )
        {
            break;
        }
        
        cur = max( 0, cur + delta );
        setsuncolorandintensity( r, g, b, cur );
        wait 0.05;
    }
    
    if ( !isdefined( level.var_4ef948ecac046df4 ) || !level.var_4ef948ecac046df4.interrupt_now )
    {
        setsuncolorandintensity( r, g, b, toi );
    }
}

// Namespace lighting
// Params 0
// Checksum 0x6f9aadb9, Offset: 0x923e
// Size: 0x88
function function_33c3b7816ee10899()
{
    dpitch = 0;
    dhead = 0;
    
    if ( isdefined( level.var_4ef948ecac046df4 ) )
    {
        if ( isdefined( level.var_4ef948ecac046df4.var_23b91e1571d4b610 ) )
        {
            dpitch += level.var_4ef948ecac046df4.var_23b91e1571d4b610;
        }
        
        if ( isdefined( level.var_4ef948ecac046df4.var_1c4ba325d3ea1070 ) )
        {
            dhead += level.var_4ef948ecac046df4.var_1c4ba325d3ea1070;
        }
    }
    
    InvalidOpCode( 0x83, dpitch, dhead );
    // Unknown operator ( 0x83, t11, Black Ops 7 )
}

// Namespace lighting
// Params 1
// Checksum 0xdc3d1112, Offset: 0x92d0
// Size: 0x34
function _normalize_angle( a )
{
    while ( a >= 180 )
    {
        a -= 360;
    }
    
    while ( a < -180 )
    {
        a += 360;
    }
    
    return a;
}

// Namespace lighting
// Params 0
// Checksum 0xe5e17a12, Offset: 0x930d
// Size: 0x49
function function_166d5eddc3290e81()
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    level.var_4ef948ecac046df4.pause_random = 1;
    level.var_4ef948ecac046df4.interrupt_now = 1;
    level notify( #"hash_16198c03a0e3dffb" );
}

// Namespace lighting
// Params 0
// Checksum 0x26620b5c, Offset: 0x935e
// Size: 0x47
function function_57415344d5eeef66()
{
    if ( !isdefined( level.var_4ef948ecac046df4 ) )
    {
        return;
    }
    
    level.var_4ef948ecac046df4.interrupt_now = 0;
    level.var_4ef948ecac046df4.pause_random = 0;
    level notify( #"hash_61502f7360eac8a8" );
}

