// script_edd5dbb24387a65  (hash_0edd5dbb24387a65.gscc) (size: 2686 Bytes / 0xa7e)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd06333ae (3496162222)
// size ...... 2686 (0xa7e)
// includes .. 0   (offset: 0x98a)
// strings ... 12  (offset: 0x98a)
// dev strs .. 0   (offset: 0xa7e)
// exports ... 13  (offset: 0x66e)
// cseg ...... 0xe0 + 0x58e (0x66e)
// imports ... 8   (offset: 0x876)
// animtree1 . 0   (offset: 0xa7e)
// animtree2 . 0   (offset: 0xa7e)
#namespace dismember;

// Namespace dismember
// Params 1
// Checksum 0x62c2ad9e, Offset: 0xfe
// Size: 0x93
function function_462c4d5204fd1ef2( part )
{
    if ( !isdefined( self._blackboard.scriptableparts ) )
    {
        self._blackboard.scriptableparts = [];
    }
    
    if ( !isdefined( self._blackboard.scriptableparts[ part ] ) )
    {
        self._blackboard.scriptableparts[ part ] = spawnstruct();
        self._blackboard.scriptableparts[ part ].state = "normal";
    }
}

// Namespace dismember
// Params 2
// Checksum 0xba086159, Offset: 0x199
// Size: 0x105
function function_da16a0480d46b1b9( part, state )
{
    if ( self._blackboard.scriptableparts[ part ].state == "dismember" )
    {
        return;
    }
    
    if ( self._blackboard.scriptableparts[ part ].state != "normal" && state != "dismember" )
    {
        self._blackboard.scriptableparts[ part ].state += "_both";
    }
    else
    {
        self._blackboard.scriptableparts[ part ].state = state;
    }
    
    self._blackboard.scriptableparts[ part ].time = gettime();
}

// Namespace dismember
// Params 3
// Checksum 0x3f365411, Offset: 0x2a6
// Size: 0xcc
function function_fceaf842fad33472( part, state, waittime )
{
    self endon( #"entitydeleted" );
    function_da16a0480d46b1b9( part, state );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    if ( isdefined( self.scriptablecleanup ) )
    {
        return 1;
    }
    
    partstate = self._blackboard.scriptableparts[ part ].state;
    
    if ( isdefined( anim.dismemberheavyfx[ self.unittype ] ) )
    {
        if ( part != "head" && partstate != "dismember" )
        {
            if ( function_35862cb1dfa7f7b7( self.unittype ) )
            {
                partstate += "_lite";
            }
        }
    }
    
    self setscriptablepartstate( part, partstate );
}

// Namespace dismember
// Params 1
// Checksum 0x254d49fd, Offset: 0x37a
// Size: 0xb2
function function_5039abfc5bca6a1f( part )
{
    var_32248a09204f2950 = part + "_dism_fx";
    state = function_ccccf112328e1705( part );
    
    if ( state == "normal" )
    {
        state = "undamaged";
    }
    else if ( issubstr( state, "_both" ) )
    {
        state = "dmg_both";
    }
    
    if ( !isdefined( level.var_5369650a0a0abede ) && isdefined( anim.dismemberheavyfx[ self.unittype ] ) )
    {
        if ( part != "head" )
        {
            if ( function_35862cb1dfa7f7b7( self.unittype ) )
            {
                state += "_lite";
            }
        }
    }
    
    self setscriptablepartstate( var_32248a09204f2950, state );
}

// Namespace dismember
// Params 1
// Checksum 0xf9c31bba, Offset: 0x434
// Size: 0x9f, Type: bool
function function_35862cb1dfa7f7b7( type )
{
    newarray = [];
    
    for ( i = 0; i < anim.dismemberheavyfx[ type ].size ; i++ )
    {
        if ( gettime() - anim.dismemberheavyfx[ type ][ i ] > 1000 )
        {
            continue;
        }
        
        newarray[ newarray.size ] = anim.dismemberheavyfx[ type ][ i ];
    }
    
    if ( newarray.size < 0 )
    {
        newarray[ newarray.size ] = gettime();
        anim.dismemberheavyfx[ type ] = newarray;
        return false;
    }
    
    anim.dismemberheavyfx[ type ] = newarray;
    return true;
}

// Namespace dismember
// Params 1
// Checksum 0x70bbcf74, Offset: 0x4dc
// Size: 0x6b
function function_ccccf112328e1705( part )
{
    if ( !isdefined( self._blackboard.scriptableparts ) )
    {
        return "normal";
    }
    
    if ( !isdefined( self._blackboard.scriptableparts[ part ] ) )
    {
        return "normal";
    }
    
    return self._blackboard.scriptableparts[ part ].state;
}

// Namespace dismember
// Params 0
// Checksum 0x72d25bcf, Offset: 0x550
// Size: 0x2f, Type: bool
function function_ed7fe93db46db41f()
{
    if ( function_ccccf112328e1705( "left_leg" ) == "dismember" || function_ccccf112328e1705( "right_leg" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

// Namespace dismember
// Params 0
// Checksum 0x24a03017, Offset: 0x588
// Size: 0x2f, Type: bool
function function_23b48337efeaa57()
{
    if ( function_ccccf112328e1705( "left_leg" ) == "dismember" && function_ccccf112328e1705( "right_leg" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

// Namespace dismember
// Params 0
// Checksum 0xe66b6377, Offset: 0x5c0
// Size: 0x2f, Type: bool
function function_90f7015026931a5()
{
    if ( function_ccccf112328e1705( "left_arm" ) == "dismember" || function_ccccf112328e1705( "right_arm" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

// Namespace dismember
// Params 0
// Checksum 0xbeb826f7, Offset: 0x5f8
// Size: 0x1a, Type: bool
function function_2c73aed20d6fc721()
{
    if ( function_ccccf112328e1705( "right_arm" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

// Namespace dismember
// Params 0
// Checksum 0xdc5c1014, Offset: 0x61b
// Size: 0x1a, Type: bool
function function_b1405eb34476293a()
{
    if ( function_ccccf112328e1705( "left_arm" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

// Namespace dismember
// Params 0
// Checksum 0xe18eb291, Offset: 0x63e
// Size: 0x2f, Type: bool
function function_e33c8b8646f05875()
{
    if ( function_ccccf112328e1705( "left_arm" ) == "dismember" && function_ccccf112328e1705( "right_arm" ) == "dismember" )
    {
        return true;
    }
    
    return false;
}

