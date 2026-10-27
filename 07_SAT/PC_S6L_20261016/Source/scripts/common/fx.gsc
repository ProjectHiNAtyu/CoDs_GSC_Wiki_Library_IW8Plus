// scripts\common\fx.gsc  (hash_547435a3732a58c4.gscc) (size: 13007 Bytes / 0x32cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe445bae9 (3829775081)
// size ...... 13007 (0x32cf)
// includes .. 3   (offset: 0x2e63)
// strings ... 33  (offset: 0x2e7b)
// dev strs .. 37  (offset: 0x30c7)
// exports ... 32  (offset: 0x1f53)
// cseg ...... 0x234 + 0x1d1f (0x1f53)
// imports ... 84  (offset: 0x2453)
// animtree1 . 0   (offset: 0x32cf)
// animtree2 . 0   (offset: 0x32cf)
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\utility;

#namespace fx;

// Namespace fx
// Params 0
// Checksum 0x57406afb, Offset: 0x252
// Size: 0x4e
function initfx()
{
    if ( !utility::add_init_script( "fx", &initfx ) )
    {
        return;
    }
    
    utility::set_createfx_enabled();
    
    if ( havemapentseffects() )
    {
        level.createfxent = [];
    }
    
    utility::create_func_ref( "create_triggerfx", &create_triggerfx );
    thread init_fx_thread();
    script_struct_fx_init();
}

// Namespace fx
// Params 0
// Checksum 0x4e4fd7b8, Offset: 0x2a8
// Size: 0x3a1
function init_fx_thread()
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = spawnstruct();
    }
    
    utility::create_lock( "createfx_looper", 20 );
    level._fx.fireloopmod = 1;
    level._fx.exploderfunction = &exploder::exploder_before_load;
    waittillframeend();
    waittillframeend();
    level._fx.exploderfunction = &exploder::exploder_after_load;
    level._fx.server_culled_sounds = 0;
    
    if ( getdvarint( @"hash_7ebee7a942eed3c8" ) == 1 )
    {
        level._fx.server_culled_sounds = 1;
    }
    
    if ( level.createfx_enabled )
    {
        level._fx.server_culled_sounds = 0;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_85b139dc623fa880", 0 );
        setdevdvarifuninitialized( @"hash_66ba26fa32261de", 0 );
        setdevdvarifuninitialized( @"createfx_offset", "<dev string:x24>" );
        
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
        {
            level._fx.server_culled_sounds = 1;
        }
    #/
    
    if ( level.createfx_enabled )
    {
        level waittill( #"createfx_common_done" );
    }
    
    level.createfxexploders = [];
    flaggedexploders = [];
    
    /#
        remove_dupes();
        offset_fix();
    #/
    
    foreach ( ent in level.createfxent )
    {
        ent createfx::set_forward_and_up_vectors();
        
        switch ( ent.v[ "type" ] )
        {
            case #"hash_1ac9f75b98e637fd":
                ent thread loopfxthread();
                break;
            case #"hash_16b43f355b98c009":
                ent thread oneshotfxthread();
                break;
            case #"hash_fbc4edc91b6c146a":
                ent thread create_loopsound();
                break;
            case #"hash_c9ec51ce0335258e":
                ent thread create_interval_sound();
                break;
            case #"hash_46a741fcf24ab59":
                ent add_reactive_fx();
                break;
        }
        
        if ( isdefined( ent.v[ "exploder" ] ) )
        {
            createfx::add_exploder( ent.v[ "exploder" ], ent );
            
            if ( isdefined( ent.v[ "flag" ] ) && ent.v[ "flag" ] != "nil" )
            {
                temp = flaggedexploders[ ent.v[ "flag" ] ];
                
                if ( !isdefined( temp ) )
                {
                    temp = [];
                }
                
                temp[ temp.size ] = ent.v[ "exploder" ];
                flaggedexploders[ ent.v[ "flag" ] ] = temp;
            }
        }
    }
    
    foreach ( msg, exploderarray in flaggedexploders )
    {
        thread exploder::exploder_flag_wait( msg, exploderarray );
    }
    
    check_createfx_limit();
}

/#

    // Namespace fx
    // Params 0
    // Checksum 0x2b216660, Offset: 0x651
    // Size: 0x13d, Type: dev
    function remove_dupes()
    {
        if ( getdvarint( @"hash_66ba26fa32261de" ) == 0 )
        {
            return;
        }
        
        new_ents = [];
        
        for ( i = 0; i < level.createfxent.size ; i++ )
        {
            add_ent = 1;
            i_ent = level.createfxent[ i ];
            
            for ( j = i + 1; j < level.createfxent.size ; j++ )
            {
                j_ent = level.createfxent[ j ];
                
                if ( j_ent.v[ "<dev string:x26>" ] == i_ent.v[ "<dev string:x26>" ] )
                {
                    if ( j_ent.v[ "<dev string:x2b>" ] == i_ent.v[ "<dev string:x2b>" ] )
                    {
                        println( "<dev string:x32>" + j_ent.v[ "<dev string:x26>" ] + "<dev string:x47>" + j_ent.v[ "<dev string:x2b>" ] );
                        add_ent = 0;
                    }
                }
            }
            
            if ( add_ent )
            {
                new_ents[ new_ents.size ] = i_ent;
            }
        }
        
        level.createfxent = new_ents;
    }

    // Namespace fx
    // Params 0
    // Checksum 0x2e8dd813, Offset: 0x796
    // Size: 0x12c, Type: dev
    function offset_fix()
    {
        if ( getdvar( @"createfx_offset", "<dev string:x4c>" ) == "<dev string:x4c>" )
        {
            return;
        }
        
        dvar = getdvar( @"createfx_offset" );
        toks = strtok( dvar, "<dev string:x4d>" );
        
        if ( toks.size != 3 )
        {
            return;
        }
        
        offset = ( int( toks[ 0 ] ), int( toks[ 1 ] ), int( toks[ 2 ] ) );
        
        foreach ( ent in level.createfxent )
        {
            ent.v[ "<dev string:x2b>" ] = ent.v[ "<dev string:x2b>" ] + offset;
        }
        
        setdvar( @"createfx_offset", "<dev string:x4c>" );
        iprintlnbold( "<dev string:x4f>" );
    }

#/

// Namespace fx
// Params 0
// Checksum 0x6795301d, Offset: 0x8ca
// Size: 0xf5
function check_createfx_limit()
{
    /#
        if ( !utility::issp() )
        {
            return;
        }
        
        fx_count = 0;
        sound_count = 0;
        
        foreach ( ent in level.createfxent )
        {
            if ( createfx::is_createfx_type( ent, "<dev string:x7b>" ) )
            {
                fx_count++;
                continue;
            }
            
            if ( createfx::is_createfx_type( ent, "<dev string:x7e>" ) )
            {
                sound_count++;
            }
        }
        
        println( "<dev string:x84>" + fx_count );
        println( "<dev string:x9f>" + sound_count );
        check_limit_type( "<dev string:x7b>", fx_count );
        check_limit_type( "<dev string:x7e>", sound_count );
    #/
}

/#

    // Namespace fx
    // Params 2
    // Checksum 0x8d860322, Offset: 0x9c7
    // Size: 0x71, Type: dev
    function check_limit_type( type, count )
    {
        limit = undefined;
        
        if ( type == "<dev string:x7b>" )
        {
            limit = 1750;
        }
        else if ( type == "<dev string:x7e>" )
        {
            limit = 384;
        }
        
        if ( count > limit )
        {
            assertmsg( "<dev string:xbd>" + type + "<dev string:xda>" + count + "<dev string:x113>" + limit );
        }
    }

#/

// Namespace fx
// Params 4
// Checksum 0x9e603f60, Offset: 0xa40
// Size: 0xc8
function print_org( fxcommand, fxid, fxpos, waittime )
{
    if ( getdvarint( @"debug" ) == 1 )
    {
        /#
            println( "<dev string:x126>" );
            println( "<dev string:x128>" + fxpos[ 0 ] + "<dev string:x4d>" + fxpos[ 1 ] + "<dev string:x4d>" + fxpos[ 2 ] + "<dev string:x133>" );
            println( "<dev string:x135>" );
            println( "<dev string:x150>" );
            println( "<dev string:x15d>" + fxcommand + "<dev string:x133>" );
            println( "<dev string:x172>" + fxid + "<dev string:x133>" );
            println( "<dev string:x182>" + waittime + "<dev string:x133>" );
            println( "<dev string:x193>" );
        #/
    }
}

// Namespace fx
// Params 7
// Checksum 0xa70be49c, Offset: 0xb10
// Size: 0xca
function loopfx( fxid, fxpos, waittime, fxpos2, fxstart, fxstop, timeout )
{
    println( "<dev string:x195>" );
    ent = utility::createloopeffect( fxid );
    ent.v[ "origin" ] = fxpos;
    ent.v[ "angles" ] = ( 0, 0, 0 );
    
    if ( isdefined( fxpos2 ) )
    {
        ent.v[ "angles" ] = vectortoangles( fxpos2 - fxpos );
    }
    
    ent.v[ "delay" ] = waittime;
}

// Namespace fx
// Params 0
// Checksum 0xf29213f8, Offset: 0xbe2
// Size: 0x6c
function create_looper()
{
    self.looper = playloopedfx( level._effect[ self.v[ "fxid" ] ], self.v[ "delay" ], self.v[ "origin" ], 0, self.v[ "forward" ], self.v[ "up" ] );
    create_loopsound();
}

// Namespace fx
// Params 0
// Checksum 0xf608d04, Offset: 0xc56
// Size: 0x150
function create_loopsound()
{
    self notify( #"stop_loop" );
    
    if ( !isdefined( self.v[ "soundalias" ] ) )
    {
        return;
    }
    
    if ( self.v[ "soundalias" ] == "nil" )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
        {
            return;
        }
    #/
    
    culled = 0;
    end_on = undefined;
    
    if ( self.v[ "stopable" ] )
    {
        if ( isdefined( self.looper ) )
        {
            end_on = "death";
        }
        else
        {
            end_on = "stop_loop";
        }
    }
    else if ( level._fx.server_culled_sounds && isdefined( self.v[ "server_culled" ] ) )
    {
        culled = self.v[ "server_culled" ];
    }
    
    ent = self;
    
    if ( isdefined( self.looper ) )
    {
        ent = self.looper;
    }
    
    createfx_ent = undefined;
    
    if ( level.createfx_enabled )
    {
        createfx_ent = self;
    }
    
    ent utility::loop_fx_sound_with_angles( self.v[ "soundalias" ], self.v[ "origin" ], self.v[ "angles" ], culled, end_on, createfx_ent );
}

// Namespace fx
// Params 0
// Checksum 0xe4b1967d, Offset: 0xdae
// Size: 0x10a
function create_interval_sound()
{
    self notify( #"stop_loop" );
    
    if ( !isdefined( self.v[ "soundalias" ] ) )
    {
        return;
    }
    
    if ( self.v[ "soundalias" ] == "nil" )
    {
        return;
    }
    
    ender = undefined;
    runner = self;
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
        {
            return;
        }
    #/
    
    if ( self.v[ "stopable" ] || level.createfx_enabled )
    {
        if ( isdefined( self.looper ) )
        {
            runner = self.looper;
            ender = "death";
        }
        else
        {
            ender = "stop_loop";
        }
    }
    
    runner thread utility::loop_fx_sound_interval_with_angles( self.v[ "soundalias" ], self.v[ "origin" ], self.v[ "angles" ], ender, undefined, self.v[ "delay_min" ], self.v[ "delay_max" ] );
}

// Namespace fx
// Params 0
// Checksum 0x60f39ce9, Offset: 0xec0
// Size: 0xb2
function loopfxthread()
{
    waitframe();
    
    if ( isdefined( self.fxstart ) )
    {
        level waittill( "start fx" + self.fxstart );
    }
    
    while ( true )
    {
        create_looper();
        
        if ( isdefined( self.timeout ) )
        {
            thread loopfxstop( self.timeout );
        }
        
        if ( isdefined( self.fxstop ) )
        {
            level waittill( "stop fx" + self.fxstop );
        }
        else
        {
            return;
        }
        
        if ( isdefined( self.looper ) )
        {
            self.looper delete();
        }
        
        if ( isdefined( self.fxstart ) )
        {
            level waittill( "start fx" + self.fxstart );
            continue;
        }
        
        return;
    }
}

// Namespace fx
// Params 1
// Checksum 0xb4487097, Offset: 0xf7a
// Size: 0x29
function loopfxstop( timeout )
{
    self endon( #"death" );
    wait timeout;
    self.looper delete();
}

// Namespace fx
// Params 8
// Checksum 0x2e5989cb, Offset: 0xfab
// Size: 0x5d
function gunfireloopfx( fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax )
{
    thread gunfireloopfxthread( fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax );
}

// Namespace fx
// Params 8
// Checksum 0xeb023152, Offset: 0x1010
// Size: 0x161
function gunfireloopfxthread( fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax )
{
    level endon( #"stop all gunfireloopfx" );
    waitframe();
    
    if ( betweensetsmax < betweensetsmin )
    {
        temp = betweensetsmax;
        betweensetsmax = betweensetsmin;
        betweensetsmin = temp;
    }
    
    betweensetsbase = betweensetsmin;
    betweensetsrange = betweensetsmax - betweensetsmin;
    
    if ( shotdelaymax < shotdelaymin )
    {
        temp = shotdelaymax;
        shotdelaymax = shotdelaymin;
        shotdelaymin = temp;
    }
    
    shotdelaybase = shotdelaymin;
    shotdelayrange = shotdelaymax - shotdelaymin;
    
    if ( shotsmax < shotsmin )
    {
        temp = shotsmax;
        shotsmax = shotsmin;
        shotsmin = temp;
    }
    
    shotsbase = shotsmin;
    shotsrange = shotsmax - shotsmin;
    fxent = spawnfx( level._effect[ fxid ], fxpos );
    
    if ( !level.createfx_enabled )
    {
        fxent willneverchange();
    }
    
    for ( ;; )
    {
        shotnum = shotsbase + randomint( shotsrange );
        
        for ( i = 0; i < shotnum ; i++ )
        {
            triggerfx( fxent );
            wait shotdelaybase + randomfloat( shotdelayrange );
        }
        
        wait betweensetsbase + randomfloat( betweensetsrange );
    }
}

// Namespace fx
// Params 0
// Checksum 0xac376ab5, Offset: 0x1179
// Size: 0xae
function create_triggerfx()
{
    if ( !verify_effects_assignment( self.v[ "fxid" ] ) )
    {
        return;
    }
    
    self.looper = spawnfx( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
    triggerfx( self.looper, self.v[ "delay" ] );
    
    if ( !level.createfx_enabled )
    {
        self.looper willneverchange();
    }
    
    create_loopsound();
}

// Namespace fx
// Params 1
// Checksum 0xb7b633fc, Offset: 0x122f
// Size: 0x5b, Type: bool
function verify_effects_assignment( effectid )
{
    if ( isdefined( level._effect[ effectid ] ) )
    {
        return true;
    }
    
    if ( !isdefined( level._missing_fx ) )
    {
        level._missing_fx = [];
    }
    
    level._missing_fx[ self.v[ "fxid" ] ] = effectid;
    verify_effects_assignment_print( effectid );
    return false;
}

// Namespace fx
// Params 1
// Checksum 0x9b2a9764, Offset: 0x1293
// Size: 0xe0
function verify_effects_assignment_print( effectid )
{
    level notify( #"verify_effects_assignment_print" );
    level endon( #"verify_effects_assignment_print" );
    waitframe();
    
    /#
        println( "<dev string:x1ab>" );
        println( "<dev string:x1b2>" );
        keys = getarraykeys( level._missing_fx );
        
        foreach ( key in keys )
        {
            println( "<dev string:x1e0>" + key );
        }
        
        println( "<dev string:x1ab>" );
    #/
    
    assertmsg( "<dev string:x20b>" );
}

// Namespace fx
// Params 0
// Checksum 0x98338920, Offset: 0x137b
// Size: 0x39
function oneshotfxthread()
{
    waitframe();
    
    if ( self.v[ "delay" ] > 0 )
    {
        wait self.v[ "delay" ];
    }
    
    [[ level.func[ "create_triggerfx" ] ]]();
}

// Namespace fx
// Params 0
// Checksum 0x9381b8ef, Offset: 0x13bc
// Size: 0xc0
function add_reactive_fx()
{
    if ( !utility::issp() && getdvar( @"createfx", "" ) == "" )
    {
        return;
    }
    
    if ( !isdefined( level._fx.reactive_thread ) )
    {
        level._fx.reactive_thread = 1;
        level thread reactive_fx_thread();
    }
    
    if ( !isdefined( level._fx.reactive_fx_ents ) )
    {
        level._fx.reactive_fx_ents = [];
    }
    
    level._fx.reactive_fx_ents[ level._fx.reactive_fx_ents.size ] = self;
    self.next_reactive_time = 3000;
}

// Namespace fx
// Params 0
// Checksum 0x2622cf0, Offset: 0x1484
// Size: 0x116
function reactive_fx_thread()
{
    if ( !utility::issp() )
    {
        if ( getdvar( @"createfx" ) == "on" )
        {
            utility::flag_wait( "createfx_started" );
        }
    }
    
    level._fx.reactive_sound_ents = [];
    explosion_radius = 256;
    
    while ( true )
    {
        level waittill( #"code_damageradius", attacker, explosion_radius, point, objweapon, delay );
        ents = sort_reactive_ents( point, explosion_radius );
        
        foreach ( i, ent in ents )
        {
            ent thread play_reactive_fx( i, delay );
        }
    }
}

// Namespace fx
// Params 1
// Checksum 0x945da48b, Offset: 0x15a2
// Size: 0x15
function vector2d( vec )
{
    return ( vec[ 0 ], vec[ 1 ], 0 );
}

// Namespace fx
// Params 2
// Checksum 0x9162d79, Offset: 0x15c0
// Size: 0x2f5
function sort_reactive_ents( point, explosion_radius )
{
    closest = [];
    time = gettime();
    
    foreach ( ent in level._fx.reactive_fx_ents )
    {
        if ( ent.next_reactive_time > time )
        {
            continue;
        }
        
        radius_squared = ent.v[ "reactive_radius" ] + explosion_radius;
        radius_squared *= radius_squared;
        
        if ( distancesquared( point, ent.v[ "origin" ] ) < radius_squared )
        {
            closest[ closest.size ] = ent;
        }
    }
    
    foreach ( ent in closest )
    {
        var_7e9319e049f3a4bf = vector2d( ent.v[ "origin" ] - level.player.origin );
        playertopoint = vector2d( point - level.player.origin );
        vec1 = vectornormalize( var_7e9319e049f3a4bf );
        vec2 = vectornormalize( playertopoint );
        ent.dot = vectordot( vec1, vec2 );
    }
    
    for ( i = 0; i < closest.size - 1 ; i++ )
    {
        for ( j = i + 1; j < closest.size ; j++ )
        {
            if ( closest[ i ].dot > closest[ j ].dot )
            {
                temp = closest[ i ];
                closest[ i ] = closest[ j ];
                closest[ j ] = temp;
            }
        }
    }
    
    foreach ( ent in closest )
    {
        ent.origin = undefined;
        ent.dot = undefined;
    }
    
    for ( i = 4; i < closest.size ; i++ )
    {
        closest[ i ] = undefined;
    }
    
    return closest;
}

// Namespace fx
// Params 2
// Checksum 0x76c17998, Offset: 0x18be
// Size: 0x1d6
function play_reactive_fx( num, delay )
{
    assert( self.v[ "<dev string:x23a>" ] != "<dev string:x23f>" || self.v[ "<dev string:x245>" ] != "<dev string:x250>", "<dev string:x254>" + self.v[ "<dev string:x2b>" ] + "<dev string:x264>" );
    
    if ( self.v[ "fxid" ] != "No FX" )
    {
        playfx( level._effect[ self.v[ "fxid" ] ], self.v[ "origin" ], self.v[ "forward" ], self.v[ "up" ] );
    }
    
    if ( self.v[ "soundalias" ] == "nil" )
    {
        return;
    }
    
    sound_ent = get_reactive_sound_ent();
    
    if ( !isdefined( sound_ent ) )
    {
        return;
    }
    
    /#
        self.is_playing = 1;
    #/
    
    self.next_reactive_time = gettime() + 3000;
    sound_ent.origin = self.v[ "origin" ];
    sound_ent.is_playing = 1;
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    wait num * randomfloatrange( 0.05, 0.1 ) + delay;
    
    if ( utility::issp() )
    {
        sound_ent playsound( self.v[ "soundalias" ], "sounddone" );
        sound_ent waittill( #"sounddone" );
    }
    else
    {
        sound_ent playsound( self.v[ "soundalias" ] );
        wait 2;
    }
    
    wait 0.1;
    sound_ent.is_playing = 0;
    
    /#
        self.is_playing = undefined;
    #/
}

// Namespace fx
// Params 0
// Checksum 0xed30144b, Offset: 0x1a9c
// Size: 0x10c
function get_reactive_sound_ent()
{
    foreach ( ent in level._fx.reactive_sound_ents )
    {
        if ( !ent.is_playing )
        {
            return ent;
        }
    }
    
    if ( level._fx.reactive_sound_ents.size < 4 )
    {
        ent = spawn( "script_origin", ( 0, 0, 0 ) );
        ent.targetname = "get_reactive_sound_ent";
        ent.is_playing = 0;
        level._fx.reactive_sound_ents[ level._fx.reactive_sound_ents.size ] = ent;
        return ent;
    }
}

// Namespace fx
// Params 4
// Checksum 0x8f0d0ceb, Offset: 0x1bb1
// Size: 0x32
function playfxnophase( fx, location, forwarddir, updir )
{
    playfx( fx, location, forwarddir, updir );
}

// Namespace fx
// Params 0
// Checksum 0x7a36baf4, Offset: 0x1beb
// Size: 0xaf
function script_struct_fx_init()
{
    level.struct_fx = utility::getstructarray( "struct_fx", "targetname" );
    
    foreach ( struct in level.struct_fx )
    {
        if ( !utility::issp() || !isdefined( struct.script_fxgroup ) )
        {
            play_struct_fx( struct );
        }
    }
}

// Namespace fx
// Params 1
// Checksum 0xca86ac64, Offset: 0x1ca2
// Size: 0x22b
function play_struct_fx( struct )
{
    if ( isdefined( struct.script_fxid ) && isdefined( level._effect[ struct.script_fxid ] ) )
    {
        if ( !isdefined( struct.angles ) )
        {
            struct.angles = ( 0, 0, 0 );
        }
        
        struct.fx = spawnfx( level._effect[ struct.script_fxid ], struct.origin, anglestoforward( struct.angles ), anglestoup( struct.angles ) );
        
        if ( isdefined( struct.script_delay_min ) && isdefined( struct.script_delay_max ) )
        {
            assert( struct.script_delay_min <= struct.script_delay_max, "<dev string:x298>" + struct.origin + "<dev string:x2ad>" );
            triggerfx( struct.fx, ( struct.script_delay_min + randomfloat( struct.script_delay_max ) ) / 1000 );
        }
        else if ( isdefined( struct.script_delay ) )
        {
            triggerfx( struct.fx, struct.script_delay / 1000 );
        }
        else
        {
            triggerfx( struct.fx, -0.004 );
        }
    }
    
    if ( isdefined( struct.script_soundalias ) )
    {
        struct.sfx = spawn( "script_origin", struct.origin );
        struct.sfx.targetname = "play_struct_fx";
        struct.sfx.angles = struct.angles;
        
        if ( soundislooping( struct.script_soundalias ) )
        {
            struct.sfx playloopsound( struct.script_soundalias );
            return;
        }
        
        struct.sfx playsound( struct.script_soundalias );
    }
}

// Namespace fx
// Params 1
// Checksum 0x3cb68af0, Offset: 0x1ed5
// Size: 0x3b
function stop_struct_fx( struct )
{
    struct.fx delete();
    
    if ( isdefined( struct.sfx ) )
    {
        struct.sfx delete();
    }
}

// Namespace fx
// Params 1
// Checksum 0x85ebfe, Offset: 0x1f18
// Size: 0x18, Type: bool
function struct_fx_active( struct )
{
    return isdefined( struct.fx );
}

// Namespace fx
// Params 1
// Checksum 0xf860763d, Offset: 0x1f39
// Size: 0x19, Type: bool
function struct_fx_inactive( struct )
{
    return !isdefined( struct.fx );
}

