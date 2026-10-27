// scripts\anim\cqb.gsc  (hash_6fb5933380201a3a.gscc) (size: 3789 Bytes / 0xecd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c62e91b (476244251)
// size ...... 3789 (0xecd)
// includes .. 3   (offset: 0xe85)
// strings ... 2   (offset: 0xe9d)
// dev strs .. 1   (offset: 0xec1)
// exports ... 11  (offset: 0x8e1)
// cseg ...... 0x6d + 0x874 (0x8e1)
// imports ... 33  (offset: 0xa99)
// animtree1 . 0   (offset: 0xecd)
// animtree2 . 0   (offset: 0xecd)
#using scripts\asm\track;
#using scripts\common\ai;
#using scripts\common\utility;

#namespace cqb;

// Namespace cqb
// Params 0
// Checksum 0x7a8642be, Offset: 0x8b
// Size: 0x32
function setupcqbpointsofinterest()
{
    level.cqbpointsofinterest = [];
    level.fnfindcqbpointsofinterest = &findcqbpointsofinterest;
    
    /#
        level.fncqbdebug = &cqbdebug;
    #/
    
    thread gatherdynamiccqbstructs();
}

// Namespace cqb
// Params 0
// Checksum 0x3281e0fb, Offset: 0xc5
// Size: 0xa9
function gatherdynamiccqbstructs()
{
    waittillframeend();
    targetname = "poi";
    pointstructs = utility::getstructarray( targetname, "targetname" );
    
    foreach ( point in pointstructs )
    {
        level.cqbpointsofinterest[ level.cqbpointsofinterest.size ] = point;
    }
}

// Namespace cqb
// Params 1
// Checksum 0x7fcfafb3, Offset: 0x176
// Size: 0x98
function function_ede69124ce3aad21( poi )
{
    if ( !isdefined( poi ) )
    {
        if ( isdefined( self.cqb_point_of_interest ) )
        {
            self.cqb_point_of_interest = undefined;
            self function_e885c7bb61b04474( 0 );
        }
        
        return;
    }
    
    if ( self.cqb_point_of_interest != poi )
    {
        assert( isdefined( poi.origin ) );
        self.cqb_point_of_interest = poi;
        self function_e885c7bb61b04474( 1, poi.origin, istrue( poi.script_poi_forcestrafe ), istrue( poi.islookatonly ), poi.lookatduration );
    }
}

// Namespace cqb
// Params 0
// Checksum 0x234616e8, Offset: 0x216
// Size: 0x17d
function findcqbpointsofinterest()
{
    if ( isdefined( anim.findingcqbpointsofinterest ) )
    {
        return;
    }
    
    anim.findingcqbpointsofinterest = 1;
    
    /#
        level thread cqbdebug();
    #/
    
    waitframe();
    
    while ( true )
    {
        ai = level.poi_activeai;
        
        if ( !isdefined( ai ) )
        {
            waitframe();
            continue;
        }
        
        guystoremove = [];
        waited = 0;
        
        foreach ( guy in ai )
        {
            if ( isalive( guy ) )
            {
                guy function_ede69124ce3aad21( guy findbestpoi() );
                wait 0.05;
                waited = 1;
                continue;
            }
            
            guystoremove[ guystoremove.size ] = guy;
        }
        
        foreach ( guy in guystoremove )
        {
            level.poi_activeai = arrayremove( level.poi_activeai, guy );
        }
        
        if ( !waited )
        {
            wait 0.25;
        }
    }
}

// Namespace cqb
// Params 0
// Checksum 0x8fe5d843, Offset: 0x39b
// Size: 0x89
function findbestpoi()
{
    var_2a6b34d93235e4e3 = 5000;
    ismoving = isdefined( self.pathgoalpos );
    currentpoi = track::getcurrentpoi();
    haspoi = isdefined( currentpoi );
    
    if ( !haspoi && isdefined( self.poi_firstpoint ) )
    {
        return findfirstpoiinlink();
    }
    
    if ( haspoi && isdefined( currentpoi.target ) || isdefined( self.nextpoi ) )
    {
        return findnextpoiinlink( haspoi );
    }
}

// Namespace cqb
// Params 0
// Checksum 0x647c0625, Offset: 0x42c
// Size: 0x8e
function findfirstpoiinlink()
{
    assert( isdefined( self.poi_firstpoint ) );
    
    if ( sighttracepassed( self geteye(), self.poi_firstpoint.origin, 0, undefined ) )
    {
        poi = self.poi_firstpoint;
        
        if ( isdefined( poi.target ) )
        {
            self.nextpoi = utility::getstruct( poi.target, "targetname" );
        }
        
        if ( iswithinfov( poi ) )
        {
            return poi;
        }
        else
        {
            return;
        }
        
        return;
    }
    
    return;
}

// Namespace cqb
// Params 1
// Checksum 0x4461aa2e, Offset: 0x4c2
// Size: 0x1cc
function findnextpoiinlink( haspoi )
{
    min_time = undefined;
    currentpoi = track::getcurrentpoi();
    assert( haspoi && isdefined( currentpoi.target ) || isdefined( self.nextpoi ) );
    
    if ( haspoi )
    {
        if ( isdefined( currentpoi.target ) )
        {
            self.nextpoi = utility::getstruct( currentpoi.target, "targetname" );
        }
        else
        {
            self.nextpoi = undefined;
        }
    }
    
    if ( isdefined( self.poi_firstpoint ) )
    {
        self.poi_firstpoint = undefined;
    }
    
    if ( haspoi && isdefined( currentpoi.script_time_min ) )
    {
        min_time = currentpoi.script_time_min * 1000;
    }
    else
    {
        min_time = 1200;
    }
    
    if ( !isdefined( self.nextpoi ) )
    {
        if ( gettime() < self.poi_starttime + min_time && iswithinfov( currentpoi ) )
        {
            return currentpoi;
        }
        else
        {
            ai::poi_enable( 0 );
            return;
        }
    }
    
    if ( haspoi && gettime() < self.poi_starttime + min_time && iswithinfov( currentpoi ) )
    {
        return currentpoi;
    }
    
    if ( !sighttracepassed( self geteye(), self.nextpoi.origin, 0, undefined ) )
    {
        return;
    }
    
    if ( !iswithinfov( self.nextpoi ) )
    {
        if ( isdefined( self.nextpoi.target ) )
        {
            self.nextpoi = utility::getstruct( self.nextpoi.target, "targetname" );
            return;
        }
        
        ai::poi_enable( 0 );
        return;
    }
    
    return self.nextpoi;
}

// Namespace cqb
// Params 1
// Checksum 0xefa7975, Offset: 0x696
// Size: 0x79, Type: bool
function iswithinfov( poi )
{
    if ( self.poi_disablefov )
    {
        return true;
    }
    
    assert( isdefined( poi ) );
    myforward = anglestoforward( self.angles );
    var_ee136b7b70af6357 = acos( vectordot( myforward, vectornormalize( poi.origin - self geteye() ) ) );
    return var_ee136b7b70af6357 < ( self.poi_fovlimit ?? 90 );
}

/#

    // Namespace cqb
    // Params 0
    // Checksum 0x10f1b0d8, Offset: 0x718
    // Size: 0x31, Type: dev
    function cqbdebug()
    {
        self notify( #"hash_109d4c39cc7ff8ef" );
        self endon( #"hash_109d4c39cc7ff8ef" );
        self endon( #"death" );
        level thread cqbdebugglobal();
    }

    // Namespace cqb
    // Params 0
    // Checksum 0x95ab86d1, Offset: 0x751
    // Size: 0x190, Type: dev
    function cqbdebugglobal()
    {
        setdvarifuninitialized( @"hash_e37c013185c9347c", "<dev string:x24>" );
        
        if ( isdefined( level.cqbdebugglobal ) )
        {
            return;
        }
        
        level.cqbdebugglobal = 1;
        
        while ( true )
        {
            if ( getdvarint( @"hash_e37c013185c9347c" ) != 1 )
            {
                wait 1;
                continue;
            }
            
            foreach ( ai in level.poi_activeai )
            {
                currentpoi = ai track::getcurrentpoi();
                
                if ( isdefined( currentpoi ) )
                {
                    line( ai geteye(), currentpoi.origin, ( 0, 0, 1 ), 1, 0, 1 );
                    continue;
                }
                
                if ( isdefined( ai.nextpoi ) )
                {
                    line( ai geteye(), ai.nextpoi.origin, ( 1, 0, 0 ), 1, 0, 1 );
                    continue;
                }
                
                if ( isdefined( ai.poi_firstpoint ) )
                {
                    line( ai geteye(), ai.poi_firstpoint.origin, ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            wait 0.05;
        }
    }

#/
