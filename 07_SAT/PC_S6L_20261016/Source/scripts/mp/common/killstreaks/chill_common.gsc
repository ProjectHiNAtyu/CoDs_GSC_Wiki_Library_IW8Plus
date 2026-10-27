// scripts\mp\common\killstreaks\chill_common.gsc  (hash_1f0a957f0559a9c0.gscc) (size: 3439 Bytes / 0xd6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x84c484a2 (2227471522)
// size ...... 3439 (0xd6f)
// includes .. 4   (offset: 0xc6f)
// strings ... 13  (offset: 0xc8f)
// dev strs .. 0   (offset: 0xd6f)
// exports ... 11  (offset: 0x85b)
// cseg ...... 0x104 + 0x757 (0x85b)
// imports ... 19  (offset: 0xa13)
// animtree1 . 0   (offset: 0xd6f)
// animtree2 . 0   (offset: 0xd6f)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace chill_common;

// Namespace chill_common
// Params 0
// Checksum 0x413672e2, Offset: 0x122
// Size: 0xb3
function chill_init()
{
    chill_data = spawnstruct();
    chill_data.blindparts = [];
    chill_data.blindstates = [];
    chill_data.blinddurations = [];
    chill_data.blindparts[ 0 ] = "chilledInit";
    chill_data.blindstates[ 0 ] = "activeWeak";
    chill_data.blinddurations[ 0 ] = 2;
    chill_data.blindparts[ 1 ] = "chilledInit";
    chill_data.blindstates[ 1 ] = "active";
    chill_data.blinddurations[ 1 ] = 2;
    level.chill_data = chill_data;
}

// Namespace chill_common
// Params 2
// Checksum 0xc78080c4, Offset: 0x1dd
// Size: 0x12f
function chill( id, duration )
{
    if ( !isdefined( self.chill_data ) )
    {
        self.chill_data = spawnstruct();
    }
    
    struct = self.chill_data;
    thread chill_blind();
    
    if ( !isdefined( struct.active ) )
    {
        self notify( #"hash_62242c7625003b05" );
        struct.active = 1;
        struct.speedmod = 0;
        struct.times = [];
        duration *= 1000;
        starttime = gettime();
        endtime = starttime + duration;
        struct.times[ id ] = ( starttime, endtime, duration );
        chill_impair();
        self setscriptablepartstate( "chilled", "active", 0 );
        thread chill_update();
        return;
    }
    
    if ( !isdefined( struct.times[ id ] ) )
    {
        struct.active++;
    }
    
    duration *= 1000;
    starttime = gettime();
    endtime = starttime + duration;
    struct.times[ id ] = ( starttime, endtime, duration );
}

// Namespace chill_common
// Params 1
// Checksum 0xbed9ccdc, Offset: 0x314
// Size: 0xd0
function chillend( id )
{
    struct = self.chill_data;
    assert( isdefined( struct ) );
    assert( isdefined( struct.active ) );
    assert( isdefined( struct.times[ id ] ) );
    struct.active--;
    struct.times[ id ] = undefined;
    
    if ( struct.active == 0 )
    {
        self notify( #"chillEnd" );
        chill_impairend();
        self setscriptablepartstate( "chilled", "neutral", 0 );
        self.chill_data = undefined;
        
        if ( common::function_8ff835bf23198a0( "chill_data" ) )
        {
            common::function_d85a92c557ea5a52( "chill_data" );
        }
        
        weapons::updatemovespeedscale();
    }
}

// Namespace chill_common
// Params 0
// Checksum 0x9f33b, Offset: 0x3ec
// Size: 0x29, Type: bool
function ischilled()
{
    struct = self.chill_data;
    return isdefined( struct ) && isdefined( struct.active );
}

// Namespace chill_common
// Params 0
// Checksum 0x12263d2c, Offset: 0x41e
// Size: 0x18
function chill_resetdata()
{
    self notify( #"chillreset" );
    self.chill_data = undefined;
}

// Namespace chill_common
// Params 0
// Checksum 0xa7e1533b, Offset: 0x43e
// Size: 0x9b
function chill_resetscriptable()
{
    self setscriptablepartstate( "chilled", "neutral", 0 );
    
    foreach ( blindpart in level.chill_data.blindparts )
    {
        self setscriptablepartstate( blindpart, "neutral", 0 );
    }
}

// Namespace chill_common
// Params 0
// Checksum 0x8e33b187, Offset: 0x4e1
// Size: 0x4a
function chill_impair()
{
    val::set( "chill_impair", "sprint", 0 );
    val::set( "chill_impair", "slide", 0 );
    val::set( "chill_impair", "wallrun", 0 );
    val::set( "chill_impair", "mantle", 0 );
}

// Namespace chill_common
// Params 0
// Checksum 0x599cde76, Offset: 0x533
// Size: 0xe
function chill_impairend()
{
    val::reset_all( "chill_impair" );
}

// Namespace chill_common
// Params 0
// Checksum 0x154859bd, Offset: 0x549
// Size: 0x164
function chill_blind()
{
    self endon( #"death_or_disconnect" );
    var_a3109bec910603ae = self.chill_data;
    var_d1b0deb678b16ea = level.chill_data;
    var_10fd772eecb60093 = var_a3109bec910603ae.blindid;
    var_5f403d8c56ac9b36 = isdefined( self.perks[ "specialty_stun_resistance" ] ) ? 0 : 1;
    var_d30ddefa4e3d2916 = var_d1b0deb678b16ea.blindparts[ var_5f403d8c56ac9b36 ];
    var_83281604cde8355c = var_d1b0deb678b16ea.blindstates[ var_5f403d8c56ac9b36 ];
    var_6c20aaf0291b1d1f = var_d1b0deb678b16ea.blinddurations[ var_5f403d8c56ac9b36 ];
    
    if ( !isdefined( var_10fd772eecb60093 ) )
    {
        self setscriptablepartstate( var_d30ddefa4e3d2916, var_83281604cde8355c, 0 );
        var_a3109bec910603ae.blindid = var_5f403d8c56ac9b36;
    }
    else
    {
        if ( var_10fd772eecb60093 > var_5f403d8c56ac9b36 )
        {
            return;
        }
        
        var_d86a12564af5cd87 = var_d1b0deb678b16ea.blindparts[ var_10fd772eecb60093 ];
        
        if ( var_d86a12564af5cd87 != var_d30ddefa4e3d2916 )
        {
            self setscriptablepartstate( var_d86a12564af5cd87, "neutral", 0 );
        }
        
        self setscriptablepartstate( var_d30ddefa4e3d2916, var_83281604cde8355c, 0 );
        var_a3109bec910603ae.blindid = var_5f403d8c56ac9b36;
    }
    
    self notify( #"chillblind" );
    self endon( #"chillblind" );
    utility::waittill_any_timeout( var_6c20aaf0291b1d1f, "chillEnd" );
    self setscriptablepartstate( var_d30ddefa4e3d2916, "neutral", 0 );
    var_a3109bec910603ae.blindid = undefined;
}

// Namespace chill_common
// Params 0
// Checksum 0x11328d94, Offset: 0x6b5
// Size: 0x1a6
function chill_update()
{
    self endon( #"disconnect" );
    self endon( #"chillreset" );
    self endon( #"chillEnd" );
    struct = self.chill_data;
    
    if ( !common::function_8ff835bf23198a0( "chill_data" ) )
    {
        common::function_ac4bf3256b2545e3( "chill_data", self.chill_data.speedmod );
        common::function_11a0a06c67c80f4d( "chill_data", 2 );
    }
    
    while ( true )
    {
        time = gettime();
        bestratio = 0;
        
        foreach ( id, arr in struct.times )
        {
            start = arr[ 0 ];
            end = arr[ 1 ];
            duration = arr[ 2 ];
            
            if ( time < end )
            {
                elapsed = time - start;
                ratio = 1 - elapsed / duration;
                
                if ( ratio > bestratio )
                {
                    bestratio = ratio;
                }
                
                continue;
            }
            
            thread chillend( id );
        }
        
        struct.speedmod = bestratio * -0.55;
        common::function_a0f5c85d465c5f0a( "chill_data", struct.speedmod );
        weapons::updatemovespeedscale();
        wait 0.1;
    }
}

