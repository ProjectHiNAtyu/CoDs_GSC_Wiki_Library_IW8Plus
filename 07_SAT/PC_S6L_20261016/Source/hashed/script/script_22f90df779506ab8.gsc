// script_22f90df779506ab8  (hash_22f90df779506ab8.gscc) (size: 4551 Bytes / 0x11c7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b2db1ff (1798156799)
// size ...... 4551 (0x11c7)
// includes .. 4   (offset: 0x111f)
// strings ... 10  (offset: 0x113f)
// dev strs .. 1   (offset: 0x11bb)
// exports ... 18  (offset: 0x9ef)
// cseg ...... 0x179 + 0x876 (0x9ef)
// imports ... 38  (offset: 0xcbf)
// animtree1 . 0   (offset: 0x11c7)
// animtree2 . 0   (offset: 0x11c7)
#using script_26f456dbdf9aa216;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\utility;

#namespace coverfire;

// Namespace coverfire
// Params 1
// Checksum 0x19e274aa, Offset: 0x197
// Size: 0x110
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
        case #"hash_99e614e786e54290":
            return &askforcoverfire;
        case #"hash_58cdde322b1d5c53":
            return &acknowledge;
        case #"hash_99efb042f2d3bcd8":
            return &changecover;
        case #"hash_713dc5b1c250d91c":
            return &coveringfire;
        case #"hash_a3836dc7307ecb50":
            return &coveringfirecleanup;
        case #"hash_80804c8d4d60b774":
            return &namespace_f9e15975f25db152::function_f5f982ce9e32c830;
        case #"hash_e345e196d91640b5":
            return &waitforbackup;
        case #"hash_ebecb858f57398a5":
            return &function_ae52034c879574e8;
        case #"hash_72afbfa1ff115f7b":
            return &gohide;
        case #"hash_3a1541c3369e831c":
            return &clearandpausepath;
        case #"hash_e0740123af2138d0":
            return &doresumepath;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace coverfire
// Params 1
// Checksum 0x7e792721, Offset: 0x2af
// Size: 0x2a
function onuserinit( interactionid )
{
    self.bulletsinclip = weaponclipsize( self.weapon );
    self function_79425128a4b03dfe( 1 );
}

// Namespace coverfire
// Params 1
// Checksum 0x701abf41, Offset: 0x2e1
// Size: 0x37
function waitforcooldown( target )
{
    self endon( #"death", #"hash_2d5ae4a6791676b6" );
    target endon( #"death", #"hash_2d5ae4a6791676b6" );
}

// Namespace coverfire
// Params 1
// Checksum 0x9054e98, Offset: 0x320
// Size: 0xf6
function onuserterminate( interactionid )
{
    self function_79425128a4b03dfe( 0 );
    self clearbtgoal( 1 );
    self.maxfaceenemydist = 300;
    self aiclearscriptdesiredspeed();
    self notify( #"endcoverfire" );
    self.keepclaimednode = 0;
    self.shootstyleoverride = undefined;
    self.var_fccfc00935827567 = 0;
    self.var_911e12c7cc4a33c1 = 0;
    
    if ( utility::is_dead_or_dying( self ) )
    {
        function_dd518df9ee8d217c( interactionid, "death", 1 );
    }
    
    if ( !getdvarint( @"hash_14b2e1d1e450bdd5", 0 ) || !getdvarint( @"hash_39e8da7ee4a82193", 0 ) )
    {
        return;
    }
    
    thread waitforcooldown( self );
    
    if ( isdefined( self.coverfirebuddy ) )
    {
        self.coverfirebuddy thread waitforcooldown( self );
        self.coverfirebuddy = undefined;
    }
    
    if ( isdefined( self.coverfiretarget ) )
    {
        thread waitforcooldown( self.coverfiretarget );
        self.coverfiretarget = undefined;
    }
}

// Namespace coverfire
// Params 2
// Checksum 0xc051751b, Offset: 0x41e
// Size: 0x15
function waitforbackup( statename, params )
{
    
}

// Namespace coverfire
// Params 2
// Checksum 0x4feaebdc, Offset: 0x43b
// Size: 0x5f
function askforcoverfire( statename, params )
{
    other = getbuddy();
    
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    other endon( #"death" );
    self pausepath();
    self clearpath();
    self.keepclaimednode = 1;
}

// Namespace coverfire
// Params 2
// Checksum 0xd7c4fc4, Offset: 0x4a2
// Size: 0xd4
function acknowledge( statename, params )
{
    other = getbuddy();
    
    if ( !isdefined( other ) )
    {
        return;
    }
    
    self endon( #"death" );
    other endon( #"death" );
    self.bulletsinclip = weaponclipsize( self.weapon );
    capinfo = getcapinfoforparticipant( self );
    capname = capinfo.capname;
    animset = capinfo.animation;
    
    if ( isdefined( capinfo ) && isdefined( capname ) && isdefined( animset ) )
    {
        cap::cap_start( capname, animset );
    }
    else
    {
        cap::cap_start( "cap_coverfire", "cap_coverfire" );
    }
    
    self waittill( #"cap_exit_completed" );
}

// Namespace coverfire
// Params 2
// Checksum 0x9b6cdecf, Offset: 0x57e
// Size: 0x77
function coveringfire( statename, params )
{
    self.maxfaceenemydistcache = self.maxfaceenemydist;
    self.maxfaceenemydist = 2048;
    self.var_fccfc00935827567 = 0;
    self.balwayscoverexposed = 1;
    self.providecoveringfire = 1;
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.shootstyleoverride = "full";
}

// Namespace coverfire
// Params 2
// Checksum 0x9e218abc, Offset: 0x5fd
// Size: 0x59
function coveringfirecleanup( statename, params )
{
    self.maxfaceenemydist = self.maxfaceenemydistcache;
    self.maxfaceenemydistcache = undefined;
    self.balwayscoverexposed = 0;
    self.providecoveringfire = 0;
    self.var_911e12c7cc4a33c1 = 0;
    self.shootstyleoverride = undefined;
}

// Namespace coverfire
// Params 2
// Checksum 0x105dd88a, Offset: 0x65e
// Size: 0x37
function changecover( statename, params )
{
    self endon( #"death" );
    self endon( #"endcoverfire" );
    self.keepclaimednode = 0;
}

// Namespace coverfire
// Params 1
// Checksum 0x8052a847, Offset: 0x69d
// Size: 0x20, Type: bool
function function_ae52034c879574e8( statename )
{
    return isdefined( self.covernode ) || !isalive( self );
}

// Namespace coverfire
// Params 2
// Checksum 0x32fa7f5e, Offset: 0x6c6
// Size: 0x2b
function gohide( statename, params )
{
    self.var_fccfc00935827567 = 1;
    self.var_911e12c7cc4a33c1 = 1;
}

// Namespace coverfire
// Params 2
// Checksum 0x730c7f6b, Offset: 0x6f9
// Size: 0x21
function clearandpausepath( statename, params )
{
    self clearpath();
    self pausepath();
}

// Namespace coverfire
// Params 2
// Checksum 0x84742d52, Offset: 0x722
// Size: 0x1b
function doresumepath( statename, params )
{
    self resumepath();
}

// Namespace coverfire
// Params 4
// Checksum 0xdabb53e, Offset: 0x745
// Size: 0x6c
function dodelay( interval, func, param, bool )
{
    time = gettime() + interval;
    
    while ( gettime() < time )
    {
        if ( !isdefined( bool ) )
        {
            waitframe();
        }
        
        if ( isdefined( func ) )
        {
            if ( isdefined( param ) )
            {
                self [[ func ]]( param );
                continue;
            }
            
            self [[ func ]]();
        }
    }
}

// Namespace coverfire
// Params 0
// Checksum 0xfd34f654, Offset: 0x7b9
// Size: 0x13d
function getbuddy()
{
    other = undefined;
    users = getbsequsers( self getinteractionid() );
    
    if ( users.size == 2 )
    {
        if ( users[ 0 ] == self )
        {
            other = users[ 1 ];
        }
        else
        {
            other = users[ 0 ];
        }
        
        return other;
    }
    
    mytag = self function_2e50bdd9495d2b8c();
    havetag = isdefined( mytag );
    interactionid = self getinteractionid();
    users = getbsequsers( interactionid );
    
    if ( users.size > 0 )
    {
        foreach ( user in users )
        {
            othertag = user function_2e50bdd9495d2b8c();
            var_bb3349036d5bdc6 = mytag == othertag;
            
            if ( var_bb3349036d5bdc6 )
            {
                continue;
            }
            
            if ( havetag )
            {
                if ( !var_bb3349036d5bdc6 && othertag != "extra" )
                {
                    other = user;
                    break;
                }
                
                continue;
            }
            
            if ( self != user )
            {
                other = user;
                break;
            }
        }
    }
    
    return other;
}

// Namespace coverfire
// Params 3
// Checksum 0x5767e93b, Offset: 0x8ff
// Size: 0xef
function capchooseanim( asmname, statename, params )
{
    other = getbuddy();
    toother = other.origin - self.origin;
    var_d1e281958c2a817e = vectortoyaw( toother );
    anglediff = angleclamp180( self.angles[ 1 ] - var_d1e281958c2a817e );
    animsuffix = "";
    
    if ( anglediff > 135 )
    {
        animsuffix = "2r";
    }
    else if ( anglediff < -135 )
    {
        animsuffix = "2l";
    }
    else if ( anglediff > 0 && anglediff <= 135 )
    {
        animsuffix = "6";
    }
    else
    {
        animsuffix = "4";
    }
    
    turnanim = asm_cap::cap_lookupanimfromalias( statename, statename + "_" + animsuffix );
    return turnanim;
}

