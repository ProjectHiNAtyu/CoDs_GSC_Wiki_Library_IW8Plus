// script_7be7bf2c3fc071dd  (hash_7be7bf2c3fc071dd.gscc) (size: 3619 Bytes / 0xe23 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79003a (7929914)
// size ...... 3619 (0xe23)
// includes .. 6   (offset: 0xce3)
// strings ... 17  (offset: 0xd13)
// dev strs .. 0   (offset: 0xe23)
// exports ... 6   (offset: 0x7c3)
// cseg ...... 0x235 + 0x58e (0x7c3)
// imports ... 36  (offset: 0x8b3)
// animtree1 . 0   (offset: 0xe23)
// animtree2 . 0   (offset: 0xe23)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\streamhint;

#namespace namespace_83deb58a918028e8;

// Namespace namespace_83deb58a918028e8
// Params 0, eflags: 0x5
// Checksum 0xcbf813fb, Offset: 0x253
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "anywhere_but_here", #"bgb", &__init__, undefined );
}

// Namespace namespace_83deb58a918028e8
// Params 0
// Checksum 0xace7af63, Offset: 0x278
// Size: 0x93
function __init__()
{
    bgb::register( "anywhere_but_here", "activated", 1, undefined, undefined, &validation, &activation );
    bgb::function_dbfbba0189f602fa( "anywhere_but_here", 1 );
    level._effect[ "teleport_splash" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb" );
    level._effect[ "teleport_splash_3p" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    level._effect[ "teleport_aoe" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_aoe_zmb" );
    level._effect[ "teleport_aoe_kill" ] = loadfxasset( "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_aoe_kill_zmb" );
}

// Namespace namespace_83deb58a918028e8
// Params 0
// Checksum 0x872634df, Offset: 0x313
// Size: 0x44b
function activation()
{
    self endon( #"death_or_disconnect" );
    val::set( "anywhere_but_here", "ignoreme", 1 );
    val::set( "anywhere_but_here", "vehicle_use", 0 );
    
    if ( isdefined( level.var_654073823a58b613 ) )
    {
        var_1e4139ca72a33905 = self [[ level.var_654073823a58b613 ]]();
    }
    else
    {
        var_1e4139ca72a33905 = function_bf6363e79a1a43f6();
    }
    
    if ( !var_1e4139ca72a33905 )
    {
        val::reset_all( "anywhere_but_here" );
        return;
    }
    
    streamhint::playerstreamhintlocation( var_1e4139ca72a33905.origin );
    playfx( level._effect[ "teleport_splash_3p" ], self.origin );
    playsoundatpos( self.origin, #"evt_bgb_awbh_teleport_out" );
    wait 0.5;
    parent = self getlinkedparent();
    
    if ( isdefined( parent ) )
    {
        grandparent = parent getlinkedparent();
        self unlink();
    }
    
    if ( self isspectatinganyone() || self.sessionstate != "playing" )
    {
        return;
    }
    
    self setvelocity( ( 0, 0, 0 ) );
    
    if ( isvector( var_1e4139ca72a33905.origin ) )
    {
        self setorigin( var_1e4139ca72a33905.origin );
    }
    
    val::set( "anywhere_but_here", "freezecontrols", 1 );
    var_f7c8613ca0f514de = self.origin + ( 0, 0, 60 );
    a_ai = getaiarray();
    var_8e51d99478263b21 = [];
    var_f47d94670350654c = undefined;
    
    if ( a_ai.size )
    {
        var_8e51d99478263b21 = utility::get_array_of_closest( self.origin, a_ai );
        
        foreach ( ai in var_8e51d99478263b21 )
        {
            var_3a7faa84def42c4e = ai sightconetrace( var_f7c8613ca0f514de, self );
            
            if ( var_3a7faa84def42c4e > 0.2 )
            {
                var_f47d94670350654c = ai;
                break;
            }
        }
        
        if ( isdefined( var_f47d94670350654c ) )
        {
            self setplayerangles( vectortoangles( var_f47d94670350654c getcentroid() - var_f7c8613ca0f514de ) );
        }
        else if ( isdefined( var_1e4139ca72a33905.angles ) )
        {
            self setplayerangles( var_1e4139ca72a33905.angles );
        }
    }
    else if ( isdefined( var_1e4139ca72a33905.angles ) )
    {
        self setplayerangles( var_1e4139ca72a33905.angles );
    }
    
    if ( isdefined( level.var_a5b16f887c432c02 ) )
    {
        self [[ level.var_a5b16f887c432c02 ]]();
    }
    
    wait 0.1;
    self show();
    playfx( level._effect[ "teleport_splash" ], self.origin );
    playfx( level._effect[ "teleport_aoe" ], self.origin );
    self playsound( "evt_bgb_awbh_teleport_in" );
    a_ai = getaiarray();
    var_efb9ed6a0e9e4824 = utility::get_array_of_closest( self.origin, a_ai, undefined, undefined, 200 );
    
    foreach ( ai in var_efb9ed6a0e9e4824 )
    {
        if ( isai( ai ) )
        {
            playfx( level._effect[ "teleport_aoe_kill" ], ai.origin );
            ai.ignore_enemy_count = 1;
            ai dodamage( ai.health + 1000, self.origin, undefined, undefined, "MOD_UNKNOWN" );
            
            if ( !isalive( ai ) )
            {
                ai callback::callback( #"anywhere_but_here_kill", { #player:self } );
            }
        }
    }
    
    wait 0.2;
    val::reset( "anywhere_but_here", "freezecontrols" );
    wait 0.5;
    val::reset( "anywhere_but_here", "ignoreme" );
    val::reset( "anywhere_but_here", "vehicle_use" );
}

// Namespace namespace_83deb58a918028e8
// Params 0
// Checksum 0x2d26a769, Offset: 0x766
// Size: 0x3d
function validation()
{
    if ( isdefined( level.var_2fb58637e118b8bd ) )
    {
        return [[ level.var_2fb58637e118b8bd ]]();
    }
    else if ( !isdefined( function_bf6363e79a1a43f6() ) || !val::get( "allow_teleport" ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace namespace_83deb58a918028e8
// Params 0
// Checksum 0x4024be7b, Offset: 0x7ac
// Size: 0x16
function function_bf6363e79a1a43f6()
{
    return utility::callsharedfunc( "anywhere_but_here", #"hash_590b47e0428d4ab3" );
}

