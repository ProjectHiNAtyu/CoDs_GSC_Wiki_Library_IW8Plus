// scripts\anim\animselector.gsc  (hash_469e0e48a1796ca6.gscc) (size: 6141 Bytes / 0x17fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x817e34bc (2172531900)
// size ...... 6141 (0x17fd)
// includes .. 1   (offset: 0x14a5)
// strings ... 39  (offset: 0x14ad)
// dev strs .. 29  (offset: 0x169d)
// exports ... 7   (offset: 0x1159)
// cseg ...... 0x60e + 0xb4b (0x1159)
// imports ... 18  (offset: 0x1271)
// animtree1 . 0   (offset: 0x17fd)
// animtree2 . 0   (offset: 0x17fd)
#using scripts\asm\asm;

#namespace animselector;

// Namespace animselector
// Params 0
// Checksum 0x7f3320b9, Offset: 0x62c
// Size: 0x165
function getanimselectorfilenames()
{
    filenamearray = [];
    filenamearray[ "traverse_warp_up" ] = [ [ 0, "animselectortables/soldier/soldier_traverse_warp_up.csv" ], [ 1, "animselectortables/civilian/civilian_traverse_warp_up.csv" ], [ 2, "animselectortables/bomber/bomber_traverse_warp_up.csv" ] ];
    filenamearray[ "traverse_warp_down" ] = [ [ 0, "animselectortables/soldier/soldier_traverse_warp_down.csv" ], [ 1, "animselectortables/civilian/civilian_traverse_warp_down.csv" ], [ 2, "animselectortables/bomber/bomber_traverse_warp_down.csv" ] ];
    filenamearray[ "traverse_warp_over" ] = [ [ 0, "animselectortables/soldier/soldier_traverse_warp_over.csv" ], [ 1, "animselectortables/civilian/civilian_traverse_warp_over.csv" ], [ 2, "animselectortables/bomber/bomber_traverse_warp_over.csv" ] ];
    filenamearray[ "traverse_warp_across" ] = [ [ 0, "animselectortables/soldier/soldier_traverse_warp_across.csv" ], [ 1, "animselectortables/civilian/civilian_traverse_warp_across.csv" ], [ 2, "animselectortables/bomber/bomber_traverse_warp_across.csv" ] ];
    filenamearray[ "traverse_warp_external" ] = [ [ 0, "animselectortables/soldier/soldier_traverse_warp_external.csv" ], [ 1, "animselectortables/civilian/civilian_traverse_warp_external.csv" ], [ 2, "animselectortables/bomber/bomber_traverse_warp_external.csv" ] ];
    return filenamearray;
}

// Namespace animselector
// Params 0
// Checksum 0x99ca251f, Offset: 0x79a
// Size: 0x48d
function init()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 )
    {
        return;
    }
    
    anim.animselectorfeaturetable = [];
    anim.animselectorfeaturetable[ "min_height" ] = [ "height", 0 ];
    anim.animselectorfeaturetable[ "max_height" ] = [ "height", 1 ];
    anim.animselectorfeaturetable[ "min_arrival_yaw" ] = [ "arrival_yaw", 0 ];
    anim.animselectorfeaturetable[ "max_arrival_yaw" ] = [ "arrival_yaw", 1 ];
    anim.animselectorfeaturetable[ "min_length" ] = [ "length", 0 ];
    anim.animselectorfeaturetable[ "max_length" ] = [ "length", 1 ];
    anim.animselectorfeaturetable[ "min_drop_height" ] = [ "drop_height", 0 ];
    anim.animselectorfeaturetable[ "max_drop_height" ] = [ "drop_height", 1 ];
    anim.animselectorfeaturetable[ "min_speed" ] = [ "speed", 0 ];
    anim.animselectorfeaturetable[ "max_speed" ] = [ "speed", 1 ];
    anim.animselector = [];
    filenamearray = getanimselectorfilenames();
    
    foreach ( statename, filenames in filenamearray )
    {
        foreach ( traverser, filename in filenames )
        {
            anim.animselector[ statename ][ traverser ] = spawnstruct();
            anim.animselector[ statename ][ traverser ].aliases = [];
            anim.animselector[ statename ][ traverser ].features = [];
            anim.animselector[ statename ][ traverser ].values = [];
            num_aliases = tablelookuprownum( filename[ 1 ], 0, "__END__" );
            assert( isdefined( num_aliases ) && num_aliases != -1, "<dev string:x24>" + filename[ 1 ] + "<dev string:x47>" );
            num_aliases -= 1;
            assert( num_aliases > 0, "<dev string:x6e>" );
            
            for ( i = 0; i < num_aliases ; i++ )
            {
                alias = tablelookupbyrow( filename[ 1 ], i + 1, 0 );
                anim.animselector[ statename ][ traverser ].aliases[ i ] = alias;
            }
            
            num_features = undefined;
            
            for ( i = 0; i < 50 ; i++ )
            {
                feature = tablelookupbyrow( filename[ 1 ], 0, i + 1 );
                
                if ( feature == "__END__" || feature == "" )
                {
                    num_features = i;
                    break;
                }
                
                anim.animselector[ statename ][ traverser ].features[ i ] = feature;
            }
            
            assert( isdefined( num_features ), "<dev string:xb6>" );
            assert( num_features > 0, "<dev string:xfb>" );
            
            for ( i = 0; i < num_aliases ; i++ )
            {
                for ( j = 0; j < num_features ; j++ )
                {
                    alias = anim.animselector[ statename ][ traverser ].aliases[ i ];
                    feature = anim.animselector[ statename ][ traverser ].features[ j ];
                    val = tablelookupbyrow( filename[ 1 ], i + 1, j + 1 );
                    
                    if ( val == "" )
                    {
                        val = undefined;
                    }
                    else
                    {
                        val = float( val );
                    }
                    
                    anim.animselector[ statename ][ traverser ].values[ alias ][ feature ] = val;
                }
            }
        }
    }
}

// Namespace animselector
// Params 3
// Checksum 0x9a45fd62, Offset: 0xc2f
// Size: 0xd5
function checkfeaturevalue( val, feature, featurearray )
{
    assert( isdefined( anim.animselectorfeaturetable ), "<dev string:x146>" );
    assert( isdefined( anim.animselectorfeaturetable[ feature ] ), "<dev string:x175>" + feature + "<dev string:x18d>" );
    featurename = anim.animselectorfeaturetable[ feature ][ 0 ];
    featurereq = anim.animselectorfeaturetable[ feature ][ 1 ];
    featureval = featurearray[ featurename ];
    
    if ( !isdefined( featureval ) )
    {
        return 1;
    }
    
    if ( featurereq == 0 )
    {
        return ( featureval >= val );
    }
    else if ( featurereq == 1 )
    {
        return ( featureval <= val );
    }
    
    assertmsg( "<dev string:x1b9>" + feature + "<dev string:x1d2>" );
}

/#

    // Namespace animselector
    // Params 2
    // Checksum 0x99e180a3, Offset: 0xd0c
    // Size: 0xdf, Type: dev
    function function_a765a89903c8beb6( statename, featurearray )
    {
        warningstring = "<dev string:x1f5>" + self.animsetname + "<dev string:x21e>" + statename + "<dev string:x228>";
        
        foreach ( key, value in featurearray )
        {
            warningstring = warningstring + key + "<dev string:x236>" + value + "<dev string:x239>";
        }
        
        warningstring = warningstring + "<dev string:x23c>" + self.origin + "<dev string:x239>";
        println( warningstring );
    }

#/

// Namespace animselector
// Params 3
// Checksum 0x41c00628, Offset: 0xdf3
// Size: 0x211
function selectanim( statename, featurearray, traverserindex )
{
    assert( isdefined( anim.animselector[ statename ] ) );
    assert( isdefined( traverserindex ) );
    assert( traverserindex != -1, "<dev string:x24a>" );
    traverseinfo = anim.animselector[ statename ][ traverserindex ];
    
    foreach ( alias in traverseinfo.aliases )
    {
        if ( isai( self ) && !asm::asm_hasalias( statename, alias ) )
        {
            println( "<dev string:x272>" + alias + "<dev string:x284>" + statename + "<dev string:x2a5>" + self.animsetname + "<dev string:x2b4>" );
            continue;
        }
        
        var_4305196ac73feac0 = 1;
        
        foreach ( feature in traverseinfo.features )
        {
            val = traverseinfo.values[ alias ][ feature ];
            
            if ( isdefined( val ) )
            {
                if ( !checkfeaturevalue( val, feature, featurearray ) )
                {
                    var_4305196ac73feac0 = 0;
                    break;
                }
            }
        }
        
        if ( var_4305196ac73feac0 )
        {
            /#
                if ( isai( self ) && alias == "<dev string:x2df>" )
                {
                    function_a765a89903c8beb6( statename, featurearray );
                }
            #/
            
            return alias;
        }
    }
    
    assertmsg( "<dev string:x2e7>" + statename + "<dev string:x317>" );
}

// Namespace animselector
// Params 0
// Checksum 0x1202d4ee, Offset: 0x100c
// Size: 0x14c
function gettraverserindex()
{
    archetype = self getbasearchetype();
    
    if ( isdefined( archetype ) )
    {
        switch ( archetype )
        {
            case #"hash_68e7a52445d0df5":
            case #"hash_44aaeb0edd152195":
            case #"hash_4ad475e6e15635bd":
            case #"hash_4ba1525745ce470f":
            case #"hash_62f2aeb0d80aad52":
            case #"hash_85c2b0495aa920dd":
            case #"hash_8f72439a52a5037f":
            case #"hash_a646e2b1476895dd":
            case #"hash_c36adf2d3ad18f39":
                return 0;
            case #"hash_61a5404fe564f969":
            case #"hash_da4c0e7d8f5fe7c5":
            case #"hash_e87767df2e5c3a68":
                return 1;
            default:
                if ( isdefined( self.animsetname ) && self.animsetname == "suicidebomber_cp" )
                {
                    return 2;
                }
                
                if ( isdefined( self.unittype ) && self.unittype == "soldier" )
                {
                    return 0;
                }
                
                assertmsg( "<dev string:x3c0>" + self.origin + "<dev string:x3d8>" + ( self.var_4249813a2840cfc8 ?? "<dev string:x3ee>" ) + "<dev string:x3f0>" + archetype + "<dev string:x3fd>" );
                return -1;
        }
    }
    
    return -1;
}

