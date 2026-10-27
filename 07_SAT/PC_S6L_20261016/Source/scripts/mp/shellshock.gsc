// scripts\mp\shellshock.gsc  (hash_374464f426bc84e2.gscc) (size: 4145 Bytes / 0x1031 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfcaa4272 (4239016562)
// size ...... 4145 (0x1031)
// includes .. 7   (offset: 0xf65)
// strings ... 9   (offset: 0xf9d)
// dev strs .. 1   (offset: 0x1025)
// exports ... 17  (offset: 0xa71)
// cseg ...... 0x193 + 0x8de (0xa71)
// imports ... 17  (offset: 0xd19)
// animtree1 . 0   (offset: 0x1031)
// animtree2 . 0   (offset: 0x1031)
#using scripts\common\concussion_utility;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\mp\common\equipment\flash_grenade;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\laststand;

#namespace shellshock;

// Namespace shellshock
// Params 0
// Checksum 0xff585d6c, Offset: 0x1b1
// Size: 0xc5
function init()
{
    level._effect[ "slide_dust" ] = loadfxasset( "vfx_core_screen_scrnfx_tocam_slidedust_m" );
    level._effect[ "hit_left" ] = loadfxasset( "vfx_core_screen_blood_hit_left" );
    level._effect[ "hit_right" ] = loadfxasset( "vfx_core_screen_blood_hit_right" );
    utility::registersharedfunc( #"shellshock", #"flashinterruptdelayfunc", &flash_grenade::calculateinterruptdelay );
    utility::registersharedfunc( #"shellshock", #"concussioninterruptdelayfunc", &concussion_utility::calculateinterruptdelay );
    utility::registersharedfunc( #"shellshock", #"gasinterruptdelayfunc", &gas_grenade::gas_getblurinterruptdelayms );
    utility::registersharedfunc( #"shellshock", #"laststandinterruptdelayfunc", &laststand::getshellshockinterruptdelayms );
}

// Namespace shellshock
// Params 2
// Checksum 0x696f11f6, Offset: 0x27e
// Size: 0xdb
function shellshockondamage( cause, damage )
{
    if ( gettime() < self.flashendtime )
    {
        return;
    }
    
    switch ( cause ?? "" )
    {
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a86d8c43482948a4":
        case #"hash_a911a1880d996edb":
        case #"hash_c22b13f81bed11f0":
            if ( damage > 10 )
            {
                shellshock_utility_cpmp::_shellshock( level.gamemodebundle.var_7046c658b890ac2c ?? %"light_damage_mp", #"damage", self.shellshockreduction ?? 0.5 );
            }
            
            break;
        default:
            break;
    }
}

// Namespace shellshock
// Params 0
// Checksum 0xba8f4195, Offset: 0x361
// Size: 0x1c
function endondeath()
{
    self waittill( #"death" );
    waittillframeend();
    self notify( #"end_explode" );
}

// Namespace shellshock
// Params 3
// Checksum 0x87dbcde2, Offset: 0x385
// Size: 0xa4
function grenade_earthquake( scale, var_c8ae7a834efc10c0, duration )
{
    assert( !isdefined( scale ) || scale > 0, "<dev string:x24>" );
    self notify( #"hash_22511834ce73957b" );
    self endon( #"hash_22511834ce73957b" );
    thread endondeath();
    self endon( #"end_explode" );
    position = undefined;
    
    if ( !isdefined( var_c8ae7a834efc10c0 ) || var_c8ae7a834efc10c0 )
    {
        self waittill( #"explode", position );
    }
    else
    {
        position = self.origin;
    }
    
    grenade_earthquakeatposition_internal( position, scale, duration );
}

// Namespace shellshock
// Params 3
// Checksum 0xadbc9e34, Offset: 0x431
// Size: 0x29
function grenade_earthquakeatposition( position, scale, duration )
{
    grenade_earthquakeatposition_internal( position, scale, duration );
}

// Namespace shellshock
// Params 3
// Checksum 0x219c7614, Offset: 0x462
// Size: 0x77
function grenade_earthquakeatposition_internal( position, scale = 1, duration = 0.7 )
{
    playrumbleonposition( "grenade_rumble", position );
    sca = 0.45 * scale;
    rad = 800;
    earthquake( sca, duration, position, rad );
    _screenshakeonposition( position, 600 );
}

// Namespace shellshock
// Params 2
// Checksum 0x46b6d6ea, Offset: 0x4e1
// Size: 0x1f
function bloodmeleeeffect( objweapon, bloodorigin )
{
    shellshock_utility::bloodmeleeeffect( objweapon, bloodorigin );
}

// Namespace shellshock
// Params 0
// Checksum 0xa531caa7, Offset: 0x508
// Size: 0x4e
function c4_earthquake()
{
    thread endondeath();
    self endon( #"end_explode" );
    self waittill( #"explode", position );
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.4, 0.75, position, 512 );
}

// Namespace shellshock
// Params 11
// Checksum 0x380d474e, Offset: 0x55e
// Size: 0x17d
function generic_earthquake( duration, scalemin, scalemid, scalemax, rangemin, rangemid, rangemax, screenshakerange, rumbletype, waitnotify, var_3ad138cd8205b8f2 )
{
    self notify( #"hash_f8c1f11c51b8c995" );
    self endon( #"hash_f8c1f11c51b8c995" );
    level endon( #"game_ended" );
    thread endondeath();
    self endon( #"end_explode" );
    
    if ( !isdefined( duration ) )
    {
        duration = 0.7;
    }
    
    if ( !isdefined( scalemin ) )
    {
        scalemin = 0.45;
    }
    
    if ( !isdefined( scalemid ) )
    {
        scalemid = 0.45;
    }
    
    if ( !isdefined( scalemax ) )
    {
        scalemax = 0.45;
    }
    
    if ( !isdefined( rangemin ) )
    {
        rangemin = 800;
    }
    
    if ( !isdefined( rangemid ) )
    {
        rangemid = 800;
    }
    
    if ( !isdefined( rangemax ) )
    {
        rangemax = 800;
    }
    
    if ( !isdefined( screenshakerange ) )
    {
        screenshakerange = 600;
    }
    
    if ( !isdefined( rumbletype ) )
    {
        rumbletype = "grenade_rumble";
    }
    
    position = undefined;
    
    if ( !isdefined( waitnotify ) || waitnotify )
    {
        self waittill( #"explode", position );
    }
    else
    {
        position = self.origin;
    }
    
    if ( var_3ad138cd8205b8f2 )
    {
        scalemin *= 0.45;
        scalemid *= 0.45;
        scalemax *= 0.45;
    }
    
    earthquakeadvanced( scalemax, scalemid, scalemin, duration, position, rangemax, rangemid, rangemin );
    playrumbleonposition( rumbletype, position );
    _screenshakeonposition( position, screenshakerange );
}

// Namespace shellshock
// Params 11
// Checksum 0x50a08892, Offset: 0x6e3
// Size: 0xf7
function artillery_earthquake( position, duration = 1, scalemax = 0.35, scalemid = 0.15, scalemin = 0.05, radiusmax = 800, radiusmid = 2500, radiusmin = 10000, ignoreclients, playrumble = 1, var_ca144b5ca4279c98 = 1 )
{
    earthquakeadvanced( scalemax, scalemid, scalemin, duration, position, radiusmax, radiusmid, radiusmin );
    
    if ( playrumble )
    {
        playrumbleonposition( "artillery_rumble", position );
    }
    
    if ( var_ca144b5ca4279c98 )
    {
        _screenshakeonposition( position, radiusmax, ignoreclients );
    }
}

// Namespace shellshock
// Params 1
// Checksum 0xc9b13a29, Offset: 0x7e2
// Size: 0x2c
function stealthairstrike_earthquake( position )
{
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 1, 0.6, position, 2000 );
}

// Namespace shellshock
// Params 1
// Checksum 0xd358e940, Offset: 0x816
// Size: 0x38
function airstrike_earthquake( position )
{
    playrumbleonposition( "artillery_rumble", position );
    earthquake( 0.5, 0.65, position, 1000 );
    _screenshakeonposition( position, 900 );
}

// Namespace shellshock
// Params 9
// Checksum 0x3a20a76, Offset: 0x856
// Size: 0xc9
function airstrike_earthquake_advanced( position, duration = 1, scalemax = 0.35, scalemid = 0.15, scalemin = 0.05, radiusmax = 800, radiusmid = 2500, radiusmin = 10000, ignoreclients )
{
    earthquakeadvanced( scalemax, scalemid, scalemin, duration, position, radiusmax, radiusmid, radiusmin );
    playrumbleonposition( "artillery_rumble", position );
    _screenshakeonposition( position, radiusmax, ignoreclients );
}

// Namespace shellshock
// Params 1
// Checksum 0x62311d48, Offset: 0x927
// Size: 0x8e
function pulsegrenade_earthquake( var_c8ae7a834efc10c0 )
{
    self notify( #"hash_d42763cbb20d174c" );
    self endon( #"hash_d42763cbb20d174c" );
    thread endondeath();
    self endon( #"end_explode" );
    position = undefined;
    
    if ( !isdefined( var_c8ae7a834efc10c0 ) || var_c8ae7a834efc10c0 )
    {
        self waittill( #"explode", position );
    }
    else
    {
        position = self.origin;
    }
    
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.3, 0.35, position, 800 );
}

// Namespace shellshock
// Params 1
// Checksum 0x7fbb9685, Offset: 0x9bd
// Size: 0x8e
function engineerdrone_earthquake( var_c8ae7a834efc10c0 )
{
    self notify( #"hash_d42763cbb20d174c" );
    self endon( #"hash_d42763cbb20d174c" );
    thread endondeath();
    self endon( #"end_explode" );
    position = undefined;
    
    if ( !isdefined( var_c8ae7a834efc10c0 ) || var_c8ae7a834efc10c0 )
    {
        self waittill( #"explode", position );
    }
    else
    {
        position = self.origin;
    }
    
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.3, 0.35, position, 800 );
}

// Namespace shellshock
// Params 3
// Checksum 0xf6742dad, Offset: 0xa53
// Size: 0x1e
function _screenshakeonposition( position, radius, ignoreclients )
{
    
}

