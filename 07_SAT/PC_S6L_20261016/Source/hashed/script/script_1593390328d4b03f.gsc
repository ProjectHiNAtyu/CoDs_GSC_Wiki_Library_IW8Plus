// script_1593390328d4b03f  (hash_1593390328d4b03f.gscc) (size: 3445 Bytes / 0xd75 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf604b9 (200672441)
// size ...... 3445 (0xd75)
// includes .. 5   (offset: 0xbf1)
// strings ... 24  (offset: 0xc19)
// dev strs .. 0   (offset: 0xd75)
// exports ... 5   (offset: 0x8a5)
// cseg ...... 0x1f7 + 0x6ae (0x8a5)
// imports ... 22  (offset: 0x96d)
// animtree1 . 0   (offset: 0xd75)
// animtree2 . 0   (offset: 0xd75)
#using script_3d2770dc09c1243;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\matchdata;

#namespace namespace_f049c34dec12ef04;

// Namespace namespace_f049c34dec12ef04
// Params 0
// Checksum 0x41cba59b, Offset: 0x215
// Size: 0x140
function init()
{
    loots = [];
    
    foreach ( loot in getlootscriptablearray() )
    {
        if ( issubstr( loot.type, "panel" ) )
        {
            continue;
        }
        
        loots[ loots.size ] = loot;
    }
    
    foreach ( ent in getentitylessscriptablearray() )
    {
        if ( issubstr( ent.classname, "cache" ) )
        {
            loots[ loots.size ] = ent;
        }
    }
    
    level.mit.loot = { #loots:loots };
}

// Namespace namespace_f049c34dec12ef04
// Params 0
// Checksum 0xf8a71760, Offset: 0x35d
// Size: 0xbb
function function_ea4702e96396446c()
{
    const_batch_size = 10;
    i = 0;
    
    while ( i < level.mit.loot.loots.size )
    {
        loops = min( const_batch_size, level.mit.loot.loots.size - i );
        
        for ( j = 0; j < loops ; j++ )
        {
            checkloot( level.mit.loot.loots[ i + j ] );
        }
        
        waitframe();
        i += const_batch_size;
    }
}

// Namespace namespace_f049c34dec12ef04
// Params 1, eflags: 0x4
// Checksum 0x7f7088a7, Offset: 0x420
// Size: 0x122
function private checkloot( loot )
{
    var_73f35b02f6136d21 = 250;
    var_6abcf77e60c66755 = 1024;
    var_4fa3b7a6850a4445 = 10;
    var_2441d96acbd27744 = -30;
    contents = trace::create_world_contents() + trace::create_item_contents();
    clip = utility::drop_to_ground( loot.origin, var_4fa3b7a6850a4445, var_2441d96acbd27744, undefined, contents );
    noclip = mit::floatequal( clip[ 2 ] - loot.origin[ 2 ], var_2441d96acbd27744, 1 );
    
    if ( noclip )
    {
        report( "no clip", loot );
        return;
    }
    
    navmeshpoint = bots_util_mp::function_1882f18076610076( clip );
    var_43b5f29a3c71a9a9 = distance2dsquared( navmeshpoint, clip );
    verticaloffset = abs( navmeshpoint[ 2 ] - clip[ 2 ] );
    comment = "";
    
    if ( var_43b5f29a3c71a9a9 > var_6abcf77e60c66755 || verticaloffset > var_73f35b02f6136d21 )
    {
        report( "no navmesh", loot, sqrt( var_43b5f29a3c71a9a9 ), verticaloffset, navmeshpoint, clip );
    }
}

// Namespace namespace_f049c34dec12ef04
// Params 6, eflags: 0x4
// Checksum 0x75d5bc27, Offset: 0x54a
// Size: 0x35b
function private report( situation, loot, hoffset, voffset, navmeshpoint, clippoint )
{
    if ( !level.mit.loot.var_99adbc981517875b )
    {
        header = "#time; #situation; #lootType; #lootOrigin; #hOffset; #vOffset; #navmeshPoint; #clipPoint";
        mit::outputlog( "Loot", header );
        level.mit.loot.var_99adbc981517875b = 1;
    }
    
    loottype = "";
    
    if ( isdefined( loot.type ) )
    {
        loottype = loot.type;
    }
    
    lootorigin = "";
    
    if ( isdefined( loot.origin ) )
    {
        lootorigin = loot.origin;
    }
    
    situation = situation ? situation : "NO_SITUATION";
    reportstring = gettime() + "; " + situation + "; " + loottype + "; " + lootorigin + "; " + ( hoffset ?? "" ) + "; " + ( voffset ?? "" ) + "; " + ( navmeshpoint ?? "" ) + "; " + ( clippoint ?? "" );
    mit::outputlog( "Loot", reportstring );
    var_633d09e49dd543d0 = mit::function_655ffb35317b1edb( lootorigin, 3, [ -1, -1, -1 ] );
    var_d95e68a7180797ee = mit::function_655ffb35317b1edb( navmeshpoint, 3, [ -1, -1, -1 ] );
    var_3dce9f644a324bd4 = mit::function_655ffb35317b1edb( clippoint, 3, [ -1, -1, -1 ] );
    dlog_recordevent( "dlog_event_mit_loot_location", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "situation", situation ?? "", "loot_type", loottype ?? "", "loot_origin_x", var_633d09e49dd543d0[ 0 ] * 1, "loot_origin_y", var_633d09e49dd543d0[ 1 ] * 1, "loot_origin_z", var_633d09e49dd543d0[ 2 ] * 1, "h_offset", isnumber( hoffset ) ? hoffset * 1 : -1, "v_offset", isnumber( voffset ) ? voffset * 1 : -1, "navmesh_point_x", var_d95e68a7180797ee[ 0 ] * 1, "navmesh_point_y", var_d95e68a7180797ee[ 1 ] * 1, "navmesh_point_z", var_d95e68a7180797ee[ 2 ] * 1, "clip_point_x", var_3dce9f644a324bd4[ 0 ] * 1, "clip_point_y", var_3dce9f644a324bd4[ 0 ] * 1, "clip_point_z", var_3dce9f644a324bd4[ 0 ] * 1 ] );
}

