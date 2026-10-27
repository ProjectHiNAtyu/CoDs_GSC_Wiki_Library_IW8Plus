// scripts\mp\ftue\utility\ftue_utility.gsc  (hash_47a7dd805c87b33f.gscc) (size: 5191 Bytes / 0x1447 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77d78245 (2010612293)
// size ...... 5191 (0x1447)
// includes .. 3   (offset: 0x13cb)
// strings ... 8   (offset: 0x13e3)
// dev strs .. 0   (offset: 0x1447)
// exports ... 20  (offset: 0xd17)
// cseg ...... 0xf8 + 0xc1f (0xd17)
// imports ... 30  (offset: 0x1037)
// animtree1 . 0   (offset: 0x1447)
// animtree2 . 0   (offset: 0x1447)
#using scripts\common\utility;
#using scripts\mp\ftue\utility\ftue_objectives;
#using scripts\mp\ftue\utility\ftue_tip;

#namespace ftue_utility;

// Namespace ftue_utility
// Params 1
// Checksum 0xc0c896f4, Offset: 0x116
// Size: 0x16e
function function_584aa5eac58c2427( wallsarray )
{
    if ( !isdefined( wallsarray ) )
    {
        return;
    }
    
    spawnedwalls = [];
    
    foreach ( wall in wallsarray )
    {
        var_b9ce38f035230c56 = [ function_697ff1a2bf53ea4e( wall[ 0 ], wall[ 1 ], wall[ 2 ] ) ];
        direction = anglestoleft( wall[ 2 ] );
        directionnormalized = vectornormalize( direction ) * ( 1, 1, 0 );
        
        switch ( wall[ 0 ] )
        {
            case #"hash_3ad7f4106022290a":
                var_495309e66f3f123b = directionnormalized * 192;
                break;
            case #"hash_671771ce3aeca79a":
                var_495309e66f3f123b = directionnormalized * 64;
                break;
            default:
                var_495309e66f3f123b = directionnormalized * 192;
                break;
        }
        
        for ( i = 1; i < wall[ 3 ] ; i++ )
        {
            var_b9ce38f035230c56[ var_b9ce38f035230c56.size ] = function_697ff1a2bf53ea4e( wall[ 0 ], wall[ 1 ] + var_495309e66f3f123b * i, wall[ 2 ] );
        }
        
        spawnedwalls[ spawnedwalls.size ] = var_b9ce38f035230c56;
    }
    
    return spawnedwalls;
}

// Namespace ftue_utility
// Params 3
// Checksum 0x655e7b2f, Offset: 0x28d
// Size: 0x49
function function_697ff1a2bf53ea4e( scriptable, position, rotation )
{
    return spawnscriptable( level.ftuedata.wallsinfo.scriptables[ getxhash( scriptable ) ], position, rotation );
}

// Namespace ftue_utility
// Params 1
// Checksum 0x5c239d69, Offset: 0x2df
// Size: 0xe5
function function_661fc16bfca41cf0( wallsarray )
{
    foreach ( walls in wallsarray )
    {
        foreach ( wall in walls )
        {
            function_8e53c7d15b63df23( wall );
        }
    }
}

// Namespace ftue_utility
// Params 1
// Checksum 0x92d47bbf, Offset: 0x3cc
// Size: 0x25
function function_8e53c7d15b63df23( wall )
{
    wall.origin = ( 0, 0, 0 );
}

// Namespace ftue_utility
// Params 0
// Checksum 0x67c8b739, Offset: 0x3f9
// Size: 0xc7
function function_86d7d8bbd737aec5()
{
    if ( !isdefined( level.ftuedata.levelassets ) )
    {
        return;
    }
    
    foreach ( asset in level.ftuedata.levelassets )
    {
        spawnscriptable( level.ftuedata.var_d4308de483257c45.scriptables[ getxhash( asset[ 0 ] ) ], asset[ 1 ], asset[ 2 ] );
    }
}

// Namespace ftue_utility
// Params 3
// Checksum 0x16769c11, Offset: 0x4c8
// Size: 0x202
function function_ce08af4793216b52( var_c8cb9ed020b00fdb, placemarks, objectivetext )
{
    if ( placemarks )
    {
        foreach ( enemybot in var_c8cb9ed020b00fdb )
        {
            level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity function_1a55154eae7e9042( objectivetext );
        }
    }
    
    var_b32fbabdb018804a = 0;
    
    while ( var_b32fbabdb018804a < var_c8cb9ed020b00fdb.size )
    {
        foreach ( enemybot in var_c8cb9ed020b00fdb )
        {
            if ( isdefined( level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity ) && level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity.health <= 0 )
            {
                var_b32fbabdb018804a++;
                ftue_objectives::function_ed97408344737f10( level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity );
                level.ftuedata.enemybots[ getxhash( enemybot ) ] notify( #"death_or_disconnect" );
                level.ftuedata.enemybots[ getxhash( enemybot ) ].botentity = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace ftue_utility
// Params 1
// Checksum 0x7c5ad2aa, Offset: 0x6d2
// Size: 0x87
function function_1a55154eae7e9042( objectivetext )
{
    objectivelabel = undefined;
    markeroffset = getdvarint( @"hash_7e3a7d1b515ef19e", 77 );
    
    if ( isdefined( objectivetext ) )
    {
        switch ( objectivetext )
        {
            case #"hash_e810fefe7ef7f725":
                objectivelabel = &"ftue_mobile/shoot_test";
                break;
            case #"hash_f850836c8bee4d31":
                objectivelabel = &"ftue_mobile/shoot_ads_test";
                break;
        }
    }
    
    ftue_objectives::function_86cc57c1dfabee84( self, objectivelabel, "mgl_ui_icon_ping_tacmap_enemy", markeroffset );
}

// Namespace ftue_utility
// Params 3
// Checksum 0xd11489ed, Offset: 0x761
// Size: 0xa6
function function_6addef97e5a67cc6( position, spawndelay, var_e1a14f9574a702d4 )
{
    if ( !isdefined( level.ftuedata.marksinfo.var_7ae780ad4ab7db45 ) )
    {
        return;
    }
    
    if ( isdefined( spawndelay ) )
    {
        wait spawndelay;
    }
    
    level.ftuedata.markersinfo.var_7ae780ad4ab7db45.origin = position + ( 0, 0, level.ftuedata.markersinfo.var_51fa8037e09c45bc );
    
    if ( isdefined( var_e1a14f9574a702d4 ) )
    {
        level thread function_71d242c211be3a5e( position, var_e1a14f9574a702d4 );
    }
}

// Namespace ftue_utility
// Params 2, eflags: 0x4
// Checksum 0xad9db7a9, Offset: 0x80f
// Size: 0x69
function private function_71d242c211be3a5e( position, var_e1a14f9574a702d4 )
{
    level endon( #"hash_6739e5ea3b57b995" );
    
    while ( true )
    {
        if ( distance( level.player.origin, position ) < var_e1a14f9574a702d4 )
        {
            function_6addef97e5a67cc6( ( 0, 0, 0 ) );
        }
        else
        {
            function_6addef97e5a67cc6( position );
        }
        
        waitframe();
    }
}

// Namespace ftue_utility
// Params 6
// Checksum 0x2d0b5c81, Offset: 0x880
// Size: 0xc2
function function_5a362eb348f0d871( triggerorigin, triggerradius, triggerheight, objectivetext, objectiveicon, objectivezoffset )
{
    trigger = spawn( "trigger_radius", triggerorigin, 0, triggerradius, triggerheight );
    trigger.radius = triggerradius;
    trigger.height = triggerheight;
    
    if ( isdefined( objectivetext ) && isdefined( objectiveicon ) && isdefined( objectivezoffset ) )
    {
        objectiveid = ftue_objectives::function_518a2916085fd4f8( triggerorigin, objectivetext, objectiveicon, objectivezoffset );
        trigger.objectiveid = objectiveid;
    }
    
    if ( getdvarint( @"hash_66535d0f1ce2e9ff", 0 ) )
    {
        trigger thread function_156fbf6d265b56be();
    }
    
    return trigger;
}

// Namespace ftue_utility
// Params 0, eflags: 0x4
// Checksum 0x523a9450, Offset: 0x94b
// Size: 0x56
function private function_156fbf6d265b56be()
{
    self endon( #"entitydeleted" );
    
    while ( getdvarint( @"hash_66535d0f1ce2e9ff", 0 ) )
    {
        utility::draw_capsule( self.origin, self.radius, self.height, undefined, ( 1, 0, 0 ), 0, 1 );
        waitframe();
    }
}

// Namespace ftue_utility
// Params 1
// Checksum 0xb0f63c3c, Offset: 0x9a9
// Size: 0x25
function function_9189cec49656cbd5( triggerentity )
{
    ftue_objectives::function_ecadaaabe4a83e9b( triggerentity.objectiveid );
    triggerentity delete();
}

// Namespace ftue_utility
// Params 2
// Checksum 0x95a89003, Offset: 0x9d6
// Size: 0x69
function function_640512d17b1bf931( originalstartpoint, originalstartangles )
{
    if ( isdefined( level.ftuedata.playerstartingposition ) )
    {
        return [ level.ftuedata.playerstartingposition, level.ftuedata.var_4dde55a6c96044a3 ];
    }
    
    return [ originalstartpoint, originalstartangles ];
}

// Namespace ftue_utility
// Params 1
// Checksum 0xabd68830, Offset: 0xa48
// Size: 0x7b
function function_dd1f3cc0720fc167( abortcallback )
{
    self endon( #"currentContextualTipCompleted" );
    self endon( #"hash_90d4c3730ad489c0" );
    self endon( #"disconnect" );
    self waittill( #"currentContextualTipAborted", reason );
    
    if ( isdefined( abortcallback ) )
    {
        self [[ abortcallback ]]();
    }
    
    if ( reason != "death" )
    {
        ftue_tip::function_e1b6c8c6f8f3dc45( 0, level.ftuedata.var_8e6073bcd0a30366 );
    }
}

// Namespace ftue_utility
// Params 3
// Checksum 0x2023e8f, Offset: 0xacb
// Size: 0x87
function function_2623dccd6b2677cc( player, waitingtime, optionalcallback )
{
    player endon( #"currentContextualTipCompleted" );
    player endon( #"currentContextualTipAborted" );
    player endon( #"hash_90d4c3730ad489c0" );
    
    /#
        overridetime = getdvarint( @"hash_2fa12b4488f98d13", 0 );
        
        if ( overridetime != 0 )
        {
            waitingtime = overridetime;
        }
    #/
    
    player thread function_dd1f3cc0720fc167( optionalcallback );
    wait waitingtime;
    player notify( #"currentContextualTipAborted" );
}

// Namespace ftue_utility
// Params 1
// Checksum 0x21ad8205, Offset: 0xb5a
// Size: 0x19
function function_b342342ac1cbac2e( player )
{
    player notify( #"hash_90d4c3730ad489c0" );
}

// Namespace ftue_utility
// Params 3
// Checksum 0x2c80003f, Offset: 0xb7b
// Size: 0xd7
function function_843d41bc87b22e7f( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace ftue_utility
// Params 2
// Checksum 0xaa93987, Offset: 0xc5b
// Size: 0x4e
function spawncamera( pos, angles )
{
    cameraent = spawn( "script_model", pos );
    
    if ( isdefined( angles ) )
    {
        cameraent.angles = angles;
    }
    
    cameraent setmodel( "tag_origin" );
    return cameraent;
}

/#

    // Namespace ftue_utility
    // Params 1
    // Checksum 0xbe5d49b0, Offset: 0xcb2
    // Size: 0x65, Type: dev
    function printtoscreen( message )
    {
        if ( getdvarint( @"hash_5bcd0aca8a94e5a7", 0 ) == 0 )
        {
            return;
        }
        
        if ( isdefined( message ) )
        {
            starttime = gettime();
            
            while ( gettime() - starttime <= 2000 )
            {
                printtoscreen2d( 10, 200, message, ( 1, 1, 1 ), 2 );
                waitframe();
            }
        }
    }

#/
