// scripts\mp\compass.gsc  (hash_054823a29593228c.gscc) (size: 9042 Bytes / 0x2352 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x373d1e5 (57922021)
// size ...... 9042 (0x2352)
// includes .. 6   (offset: 0x2186)
// strings ... 26  (offset: 0x21b6)
// dev strs .. 6   (offset: 0x230a)
// exports ... 16  (offset: 0x16be)
// cseg ...... 0x27d + 0x1441 (0x16be)
// imports ... 67  (offset: 0x193e)
// animtree1 . 0   (offset: 0x2352)
// animtree2 . 0   (offset: 0x2352)
#using scripts\common\callbacks;
#using scripts\common\minimap;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\action_park_utility;
#using scripts\mp\common\utility\game_utility;

#namespace compass;

// Namespace compass
// Params 0
// Checksum 0xa38dc94b, Offset: 0x29b
// Size: 0xbc
function init_minimap_triggers()
{
    level.minimap_floor_triggers = getentarray( "trigger_multiple_set_minimap_floor", #classname );
    utility::array_levelthread( level.minimap_floor_triggers, &trigger_set_minimap_floor );
    callback::add( #"player_death", &function_2623eda812fa7d73 );
    level.var_d83d54ca5d051afa = getentarray( "minimap_stream_trigger", #script_noteworthy );
    utility::array_levelthread( level.var_d83d54ca5d051afa, &trigger_set_minimap_stream_hints );
    
    if ( !getdvarint( @"hash_9c2fd7d9bdd2bdba", 0 ) && level.var_d83d54ca5d051afa.size == 0 )
    {
        level callback::add( #"player_connect", &function_47d24757bf76397a );
    }
    
    level utility::flag_set( "flag_minimap_triggers_initialized" );
}

// Namespace compass
// Params 1, eflags: 0x4
// Checksum 0x4244ee2a, Offset: 0x35f
// Size: 0xc7
function private trigger_set_minimap_floor( trigger )
{
    level endon( #"game_ended" );
    trigger endon( #"hash_d59c9b5cee7db337" );
    minimap_floor = trigger.script_floor_number;
    assert( isdefined( minimap_floor ), "<dev string:x24>" );
    override_minimap_volume = undefined;
    
    if ( isdefined( trigger.target ) )
    {
        minimap_volume = getnoentvolumearray( trigger.target, #targetname );
        
        if ( minimap_volume.size > 0 )
        {
            override_minimap_volume = minimap_volume[ 0 ];
        }
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        trigger thread minimap::trigger_set_floor( ent, &function_d397f80372a5b227, minimap_floor, override_minimap_volume );
    }
}

// Namespace compass
// Params 2
// Checksum 0x4f65c8fb, Offset: 0x42e
// Size: 0xfa
function get_minimap_floor_at_location( location, no_waits )
{
    if ( !no_waits )
    {
        level utility::flag_wait( "flag_minimap_triggers_initialized" );
    }
    
    if ( isarray( level.minimap_floor_triggers ) )
    {
        if ( !isdefined( level.minimap_floor_probe ) )
        {
            level.minimap_floor_probe = level utility::spawn_tag_origin( location );
        }
        
        level.minimap_floor_probe.origin = location;
        
        foreach ( trigger in level.minimap_floor_triggers )
        {
            if ( level.minimap_floor_probe istouching( trigger ) )
            {
                return trigger.script_floor_number;
            }
        }
    }
}

// Namespace compass
// Params 1
// Checksum 0x256d111e, Offset: 0x531
// Size: 0x38
function function_63f039f18edc23e1( floor_number )
{
    assert( floor_number >= 1 && floor_number <= 32, "<dev string:x5c>" + floor_number + "<dev string:x6b>" );
    return 1 << floor_number - 1;
}

// Namespace compass
// Params 1
// Checksum 0x7864c9e4, Offset: 0x572
// Size: 0x22
function function_2623eda812fa7d73( params )
{
    self.minimap_stream_hints = [];
    self setclientomnvar( "ui_minimap_stream_hint_layer_flags", 0 );
}

// Namespace compass
// Params 1
// Checksum 0x28179a82, Offset: 0x59c
// Size: 0x45
function function_47d24757bf76397a( params )
{
    player = self;
    source = player getentitynumber();
    layer_flags = function_63f039f18edc23e1( 1 );
    player_set_minimap_stream_hints( source, layer_flags );
}

// Namespace compass
// Params 2
// Checksum 0x2caeb2d8, Offset: 0x5e9
// Size: 0xe9
function player_set_minimap_stream_hints( source, layer_flags )
{
    assert( isplayer( self ) );
    
    if ( layer_flags == 0 )
    {
        layer_flags = undefined;
    }
    
    if ( !isdefined( self.minimap_stream_hints ) )
    {
        self.minimap_stream_hints = [];
    }
    
    if ( self.minimap_stream_hints[ source ] === layer_flags )
    {
        return;
    }
    
    self.minimap_stream_hints[ source ] = layer_flags;
    stream_hint_layer_flags = 0;
    
    foreach ( layer_flags in self.minimap_stream_hints )
    {
        stream_hint_layer_flags |= layer_flags;
    }
    
    self setclientomnvar( "ui_minimap_stream_hint_layer_flags", stream_hint_layer_flags );
}

// Namespace compass
// Params 1, eflags: 0x4
// Checksum 0x70244d64, Offset: 0x6da
// Size: 0x1fd
function private trigger_set_minimap_stream_hints( trigger )
{
    level endon( #"game_ended" );
    source = trigger getentitynumber();
    event = "set_minimap_stream_hints_" + source;
    minimap_layer_flags = 0;
    var_77af3a72125d27e8 = utility::function_b104528d84ca3561( trigger.targetname, "," );
    
    foreach ( floor_number in var_77af3a72125d27e8 )
    {
        minimap_layer_flags |= function_63f039f18edc23e1( floor_number );
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            player = ent;
            player player_set_minimap_stream_hints( source, minimap_layer_flags );
            player utility::delaythreadendon( 1, [ "death_or_disconnect", event ], &player_set_minimap_stream_hints, 0 );
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            if ( isdefined( ent.owners ) )
            {
                foreach ( player in ent.owners )
                {
                    player player_set_minimap_stream_hints( source, minimap_layer_flags );
                    player utility::delaythreadendon( 1, [ "death_or_disconnect", event ], &player_set_minimap_stream_hints, 0 );
                }
            }
        }
    }
}

// Namespace compass
// Params 3
// Checksum 0xa957c50a, Offset: 0x8df
// Size: 0x8eb
function function_38c54a117ec16a13( override_minimap_volume, material, materialcodcaster )
{
    requiredmapaspectratio = getdvarfloat( @"scr_requiredmapaspectratio", 1 );
    corners = [];
    defaultvolume = undefined;
    
    if ( isdefined( override_minimap_volume ) )
    {
        minimapcorners = override_minimap_volume getboundscorners();
        corners[ 0 ] = { #angles:( 0, 0, 0 ), #origin:minimapcorners[ 0 ] };
        corners[ 1 ] = { #angles:( 0, 0, 0 ), #origin:minimapcorners[ 1 ] };
    }
    else
    {
        allvolumes = getnoentvolumearray( "noent_volume_minimap", #classname );
        
        if ( allvolumes.size > 0 )
        {
            if ( allvolumes.size != 1 )
            {
                foreach ( minimapvolume in allvolumes )
                {
                    if ( action_park_utility::is_enabled() )
                    {
                        if ( getxhash( minimapvolume.script_noteworthy ) == action_park_utility::get_combo_label() )
                        {
                            defaultvolume = minimapvolume;
                            break;
                        }
                    }
                    
                    if ( isdefined( game_utility::getlocaleid() ) && minimapvolume.script_noteworthy == game_utility::getlocaleid() )
                    {
                        defaultvolume = minimapvolume;
                        break;
                    }
                    
                    if ( minimapvolume.script_noteworthy === "default" )
                    {
                        assert( !isdefined( defaultvolume ), "<dev string:xa4>" );
                        defaultvolume = minimapvolume;
                    }
                }
                
                assert( isdefined( defaultvolume ), "<dev string:xec>" );
            }
            
            minimapcorners = defaultvolume ?? allvolumes[ 0 ] getboundscorners();
            corners[ 0 ] = { #angles:( 0, 0, 0 ), #origin:minimapcorners[ 0 ] };
            corners[ 1 ] = { #angles:( 0, 0, 0 ), #origin:minimapcorners[ 1 ] };
        }
        else
        {
            allcorners = getentarray( "minimap_corner", #targetname );
            var_49d7aeb9da49c4ae = game_utility::getgametype() == "war";
            
            if ( !var_49d7aeb9da49c4ae && isdefined( game_utility::getlocaleid() ) && !game_utility::isdonetskmap() )
            {
                if ( level.localeid != "locale_6" )
                {
                    corners = getcornersfromarray( allcorners, 1 );
                    
                    if ( corners.size != 2 )
                    {
                        corners = getcornersfromarray( allcorners, 0 );
                    }
                }
                else
                {
                    corners = [];
                    corners[ 0 ] = spawn( "script_origin", ( -1040, 12288, -136 ) );
                    corners[ 1 ] = spawn( "script_origin", ( 44016, -32768, -136 ) );
                }
                
                switch ( game_utility::getgametype() )
                {
                    case #"hash_ca6516c10db2c95":
                    case #"hash_7f9c384a34cc392f":
                    case #"hash_c065cef60f38490a":
                    case #"hash_eb5e5f470e0c1dc2":
                    case #"hash_ec086b911c1011ec":
                    case #"hash_fa50b0f6bd82e972":
                        material = material + "_" + level.localeid;
                        materialcodcaster = materialcodcaster + "_" + level.localeid;
                        break;
                }
            }
            else if ( game_utility::isdonetskmap() || game_utility::getmapname() == "mp_br_quarry" )
            {
                corners = [];
                corners[ 0 ] = spawn( "script_origin", ( -65536, 86016, 5400 ) );
                corners[ 1 ] = spawn( "script_origin", ( 81920, -61440, -2048 ) );
            }
            else
            {
                corners = getcornersfromarray( allcorners, 0 );
            }
        }
    }
    
    if ( corners.size != 2 )
    {
        println( "<dev string:x129>" );
        corners[ 0 ] = { #angles:( 0, 0, 0 ), #origin:( -1000, 1000, 0 ) };
        corners[ 1 ] = { #angles:( 0, 0, 0 ), #origin:( 1000, -1000, 0 ) };
    }
    
    corner0 = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], 0 );
    corner1 = ( corners[ 1 ].origin[ 0 ], corners[ 1 ].origin[ 1 ], 0 );
    cornerdiff = corner1 - corner0;
    north = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
    
    if ( isdefined( override_minimap_volume ) )
    {
        north = ( cos( override_minimap_volume.angles[ 1 ] ), sin( override_minimap_volume.angles[ 1 ] ), 0 );
        var_e2b9323c964f96ea = override_minimap_volume.angles[ 1 ];
    }
    else if ( isdefined( defaultvolume ) )
    {
        north = ( cos( defaultvolume.angles[ 1 ] ), sin( defaultvolume.angles[ 1 ] ), 0 );
        var_e2b9323c964f96ea = defaultvolume.angles[ 1 ];
    }
    else if ( allvolumes.size > 0 )
    {
        north = ( cos( allvolumes[ 0 ].angles[ 1 ] ), sin( allvolumes[ 0 ].angles[ 1 ] ), 0 );
        var_e2b9323c964f96ea = allvolumes[ 0 ].angles[ 1 ];
    }
    
    if ( isdefined( var_e2b9323c964f96ea ) )
    {
        if ( isplayer( self ) )
        {
            self function_4380969309573a3a( var_e2b9323c964f96ea );
        }
        else
        {
            setnorthyaw( var_e2b9323c964f96ea );
        }
    }
    
    west = ( 0 - north[ 1 ], north[ 0 ], 0 );
    
    if ( vectordot( cornerdiff, west ) > 0 )
    {
        if ( vectordot( cornerdiff, north ) > 0 )
        {
            northwest = corner1;
            southeast = corner0;
        }
        else
        {
            side = vecscale( north, vectordot( cornerdiff, north ) );
            northwest = corner1 - side;
            southeast = corner0 + side;
        }
    }
    else if ( vectordot( cornerdiff, north ) > 0 )
    {
        side = vecscale( north, vectordot( cornerdiff, north ) );
        northwest = corner0 + side;
        southeast = corner1 - side;
    }
    else
    {
        northwest = corner0;
        southeast = corner1;
    }
    
    if ( requiredmapaspectratio > 0 )
    {
        northportion = vectordot( northwest - southeast, north );
        westportion = vectordot( northwest - southeast, west );
        mapaspectratio = westportion / northportion;
        
        if ( mapaspectratio < requiredmapaspectratio )
        {
            incr = requiredmapaspectratio / mapaspectratio;
            addvec = vecscale( west, westportion * ( incr - 1 ) * 0.5 );
        }
        else
        {
            incr = mapaspectratio / requiredmapaspectratio;
            addvec = vecscale( north, northportion * ( incr - 1 ) * 0.5 );
        }
        
        northwest += addvec;
        southeast -= addvec;
    }
    
    corners[ 0 ].origin = northwest;
    corners[ 1 ].origin = southeast;
    level.mapsize = vectordot( northwest - southeast, north );
    level.mapcorners = corners;
    setomnvar( "ui_map_bounds_nw_x", northwest[ 0 ] );
    setomnvar( "ui_map_bounds_nw_y", northwest[ 1 ] );
    setomnvar( "ui_map_bounds_se_x", southeast[ 0 ] );
    setomnvar( "ui_map_bounds_se_y", southeast[ 1 ] );
    level.mapcorners[ 0 ].angles = generateaxisanglesfromforwardvector( vectornormalize( level.mapcorners[ 1 ].origin - level.mapcorners[ 0 ].origin ), ( 0, 0, 1 ) );
    
    if ( isent( level.mapcorners[ 0 ] ) )
    {
        level.mapcorners[ 0 ] addyaw( 45 );
    }
    else
    {
        level.mapcorners[ 0 ].angles += ( 0, 45, 0 );
    }
    
    level.mapcorners[ 1 ].angles = generateaxisanglesfromforwardvector( vectornormalize( level.mapcorners[ 0 ].origin - level.mapcorners[ 1 ].origin ), ( 0, 0, 1 ) );
    
    if ( isent( level.mapcorners[ 1 ] ) )
    {
        level.mapcorners[ 1 ] addyaw( 45 );
        return;
    }
    
    level.mapcorners[ 1 ].angles += ( 0, 45, 0 );
}

// Namespace compass
// Params 5
// Checksum 0x2b125a30, Offset: 0x11d2
// Size: 0x1ee
function setupminimap( material, materialcodcaster, var_57f48bd359c69d97, override_minimap_volume, floornumber )
{
    mapinfo = getmapscriptbundle();
    
    if ( isdefined( mapinfo ) && isdefined( mapinfo.var_97291df15e93d160 ) )
    {
        foreach ( minimapversion in mapinfo.var_97291df15e93d160 )
        {
            if ( minimapversion.gametype == game_utility::getgametype() )
            {
                material = minimapversion.minimaptexture;
            }
        }
    }
    
    if ( !isdefined( material ) )
    {
        material = "";
    }
    
    if ( !isdefined( materialcodcaster ) )
    {
        materialcodcaster = material;
    }
    
    if ( !isdefined( floornumber ) )
    {
        floornumber = 0;
    }
    
    numtiles = mapinfo.var_dd9c815565e80d93[ floornumber - 1 ].var_903bdb21f3a9fca4 ?? mapinfo.var_903bdb21f3a9fca4 ?? 1;
    
    if ( var_57f48bd359c69d97 >= 1 )
    {
        numtiles = var_57f48bd359c69d97;
    }
    
    /#
        level.minimapmaterial = material;
    #/
    
    function_38c54a117ec16a13( override_minimap_volume, material, materialcodcaster );
    assert( isdefined( level.mapcorners ) );
    northwest = level.mapcorners[ 0 ].origin;
    southeast = level.mapcorners[ 1 ].origin;
    
    if ( isplayer( self ) )
    {
        self function_15701c060002a36d( material, northwest[ 0 ], northwest[ 1 ], southeast[ 0 ], southeast[ 1 ], numtiles, materialcodcaster );
        return;
    }
    
    setminimap( material, northwest[ 0 ], northwest[ 1 ], southeast[ 0 ], southeast[ 1 ], numtiles, materialcodcaster );
}

// Namespace compass
// Params 2
// Checksum 0x29f15a34, Offset: 0x13c8
// Size: 0x2a
function vecscale( vec, scalar )
{
    return ( vec[ 0 ] * scalar, vec[ 1 ] * scalar, vec[ 2 ] * scalar );
}

// Namespace compass
// Params 2
// Checksum 0x406c067f, Offset: 0x13fb
// Size: 0x151
function getcornersfromarray( array, var_921f464690c83957 )
{
    corners = [];
    
    if ( var_921f464690c83957 )
    {
        foreach ( corner in array )
        {
            if ( corner.script_noteworthy == level.localeid )
            {
                corners[ corners.size ] = corner;
            }
        }
    }
    else
    {
        foreach ( corner in array )
        {
            if ( !isdefined( corner.script_noteworthy ) || isdefined( corner.script_noteworthy ) && !issubstr( corner.script_noteworthy, "locale" ) )
            {
                corners[ corners.size ] = corner;
            }
        }
    }
    
    return corners;
}

// Namespace compass
// Params 2
// Checksum 0xe375b645, Offset: 0x1555
// Size: 0x95
function function_d397f80372a5b227( floornumber, override_minimap_volume )
{
    assert( isplayer( self ) );
    self setclientomnvar( "ui_minimap_floor", floornumber );
    map_name = tolower( getdvar( @"ui_mapname" ) );
    minimap_image = "compass_map_" + map_name + "_floor_" + floornumber;
    self.minimap_data = { #override_volume:override_minimap_volume, #map_material:minimap_image };
    setupminimap( minimap_image, undefined, undefined, override_minimap_volume, floornumber );
}

// Namespace compass
// Params 0
// Checksum 0x2eeb5035, Offset: 0x15f2
// Size: 0x99
function function_a7fe4d42da59fc1b()
{
    self notify( #"hash_e4f52ebb792d716e" );
    self endon( #"hash_e4f52ebb792d716e" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        utility::waittill_any( "joined_spectators", "spectating_cycle" );
        waittillframeend();
        spectated_player = self getspectatingplayer();
        
        if ( isdefined( spectated_player ) && isdefined( spectated_player.minimap_data ) )
        {
            setupminimap( spectated_player.minimap_data.map_material, undefined, undefined, spectated_player.minimap_data.override_volume );
        }
    }
}

// Namespace compass
// Params 1
// Checksum 0xdc6c0995, Offset: 0x1693
// Size: 0x2b
function function_8c888382369ffced( floor )
{
    self notify( #"hash_d59c9b5cee7db337" );
    self.script_floor_number = floor;
    trigger_set_minimap_floor( self );
}

