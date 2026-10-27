// scripts\mp\outofrange.gsc  (hash_1bc41c41033b33a0.gscc) (size: 1860 Bytes / 0x744 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e9231b3 (2660381107)
// size ...... 1860 (0x744)
// includes .. 0   (offset: 0x6e0)
// strings ... 4   (offset: 0x6e0)
// dev strs .. 3   (offset: 0x720)
// exports ... 5   (offset: 0x4dc)
// cseg ...... 0x9b + 0x441 (0x4dc)
// imports ... 10  (offset: 0x5a4)
// animtree1 . 0   (offset: 0x744)
// animtree2 . 0   (offset: 0x744)
#namespace outofrange;

// Namespace outofrange
// Params 7
// Checksum 0xba95208e, Offset: 0xb9
// Size: 0xdf
function setupoutofrangewatcher( var_fcdef177c65a8cf9, tetherpoint, tetherent, var_212150adbea44ed1, minrangesq, maxrangesq, inverserange )
{
    assert( isdefined( self.owner ), "<dev string:x24>" );
    self.owner setclientomnvar( "ui_out_of_range", 0 );
    
    if ( inverserange == 1 )
    {
        assert( isdefined( tetherpoint ) || isdefined( tetherent ), "<dev string:x63>" );
    }
    else if ( !isdefined( tetherpoint ) )
    {
        tetherpoint = var_fcdef177c65a8cf9.origin;
    }
    
    if ( !isdefined( minrangesq ) )
    {
        minrangesq = 4000000;
    }
    
    if ( !isdefined( maxrangesq ) )
    {
        maxrangesq = 16000000;
    }
    
    if ( isdefined( tetherent ) )
    {
        var_fcdef177c65a8cf9 thread watchdistancefromentity( tetherent, var_212150adbea44ed1, minrangesq, maxrangesq, inverserange );
        return;
    }
    
    var_fcdef177c65a8cf9 thread watchdistancefromstaticpoint( tetherpoint, minrangesq, maxrangesq, inverserange );
}

// Namespace outofrange
// Params 5
// Checksum 0x15d05eff, Offset: 0x1a0
// Size: 0xd3
function watchdistancefromentity( tetherent, var_212150adbea44ed1, minrangesq, maxrangesq, inverserange )
{
    self endon( #"death" );
    inverted = inverserange == 1;
    
    if ( !isdefined( var_212150adbea44ed1 ) )
    {
        var_212150adbea44ed1 = "tag_origin";
    }
    
    while ( true )
    {
        if ( !isdefined( tetherent ) )
        {
            self.owner setclientomnvar( "ui_out_of_range", 0 );
            return;
        }
        
        tetherpoint = tetherent gettagorigin( var_212150adbea44ed1 );
        distancefrom = distancesquared( self.origin, tetherpoint );
        
        if ( distancefrom >= minrangesq && !inverted || distancefrom <= maxrangesq && inverted )
        {
            watchoutofrangestrength( tetherpoint, minrangesq, maxrangesq, tetherent, var_212150adbea44ed1, inverserange );
        }
        
        waitframe();
    }
}

// Namespace outofrange
// Params 4
// Checksum 0x8f7b1579, Offset: 0x27b
// Size: 0x8f
function watchdistancefromstaticpoint( tetherpoint, minrangesq, maxrangesq, inverserange )
{
    self endon( #"death" );
    inverted = inverserange == 1;
    
    while ( true )
    {
        distancefrom = distancesquared( self.origin, tetherpoint );
        
        if ( distancefrom >= minrangesq && !inverted || distancefrom <= maxrangesq && inverted )
        {
            watchoutofrangestrength( tetherpoint, minrangesq, maxrangesq, inverserange );
        }
        
        waitframe();
    }
}

// Namespace outofrange
// Params 6
// Checksum 0xc4e9fd5a, Offset: 0x312
// Size: 0x1ca
function watchoutofrangestrength( tetherpoint, minrangesq, maxrangesq, tetherent, var_212150adbea44ed1, inverserange )
{
    inverted = inverserange == 1;
    
    while ( true )
    {
        if ( isdefined( tetherent ) )
        {
            tetherpoint = tetherent gettagorigin( var_212150adbea44ed1 );
        }
        
        currentdistancevalue = distancesquared( self.origin, tetherpoint );
        
        if ( !inverted )
        {
            signalscale = currentdistancevalue / maxrangesq;
        }
        else if ( currentdistancevalue == 0 )
        {
            signalscale = minrangesq;
        }
        else
        {
            signalscale = minrangesq / currentdistancevalue;
        }
        
        assert( isdefined( self.owner ), "<dev string:x90>" );
        self.owner setclientomnvar( "ui_out_of_range", signalscale );
        
        if ( isdefined( self.owner.outofrangefunc ) && !inverted )
        {
            self.owner thread [[ self.owner.outofrangefunc ]]( self.owner );
        }
        
        if ( currentdistancevalue >= maxrangesq && !inverted || currentdistancevalue <= minrangesq && inverted )
        {
            weapon = makeweapon( "nuke_multi_mp" );
            meansofdeath = "MOD_EXPLOSIVE";
            self.owner setclientomnvar( "ui_out_of_range", 0 );
            self dodamage( 10000, self.origin, self.owner, self.owner, meansofdeath, weapon );
            break;
        }
        else if ( currentdistancevalue < minrangesq && !inverted || currentdistancevalue > minrangesq && inverted )
        {
            self.owner setclientomnvar( "ui_out_of_range", 0 );
            break;
        }
        
        waitframe();
    }
}

