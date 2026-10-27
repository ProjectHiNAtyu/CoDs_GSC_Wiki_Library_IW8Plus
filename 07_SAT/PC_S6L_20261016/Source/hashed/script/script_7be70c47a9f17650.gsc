// script_7be70c47a9f17650  (hash_7be70c47a9f17650.gscc) (size: 1836 Bytes / 0x72c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb1abc4f (186301519)
// size ...... 1836 (0x72c)
// includes .. 5   (offset: 0x698)
// strings ... 8   (offset: 0x6c0)
// dev strs .. 0   (offset: 0x72c)
// exports ... 8   (offset: 0x350)
// cseg ...... 0xf3 + 0x25d (0x350)
// imports ... 18  (offset: 0x490)
// animtree1 . 0   (offset: 0x72c)
// animtree2 . 0   (offset: 0x72c)
#using script_54a05cbb2455bc6f;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;

#namespace namespace_33ec8ba9a5b9520d;

// Namespace namespace_33ec8ba9a5b9520d
// Params 0, eflags: 0x5
// Checksum 0xe2b754e, Offset: 0x111
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bea681fb7d0123a6", #"ztron_item", undefined, &init );
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 0
// Checksum 0x892f9c70, Offset: 0x13a
// Size: 0x6d
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"boots", #"use", &use );
    ztron_item::function_5844a9c240f7dc8d( #"boots", #"canautouse", &function_7d25c181433c3617 );
    ztron_item::function_5844a9c240f7dc8d( #"boots", #"hash_2dbdd4400cffa8b8", &canspawnitem );
    utility::add_fx( "ztron_player_speed_boots", "vfx_sat_zm_boots_ztron" );
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 1
// Checksum 0xd86bbb4f, Offset: 0x1af
// Size: 0x37, Type: bool
function canspawnitem( params )
{
    if ( level.players.size == 1 && level.players[ 0 ] ztron_fate::hasfate( 4 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 1
// Checksum 0x698a9028, Offset: 0x1ef
// Size: 0x15, Type: bool
function function_7d25c181433c3617( params )
{
    return !ztron_fate::hasfate( 4 );
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 1
// Checksum 0x42ebc759, Offset: 0x20d
// Size: 0x62
function use( params )
{
    player = params.player;
    
    if ( player ztron_fate::hasfate( 4 ) )
    {
        return;
    }
    
    time = player ztron_player_utility::function_10777122eee28fa8( 25 );
    player thread ztron_player_utility::function_8ee472666b217faf( time );
    player thread function_2882aa808b4d6ea7( time );
    player thread function_b4791e57e04b282f();
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 1, eflags: 0xc
// Checksum 0x4e42c3fa, Offset: 0x277
// Size: 0x95
function private function_2882aa808b4d6ea7( timeout )
{
    self notify( #"hash_29d5a9285c69b2db" );
    self endon( #"hash_29d5a9285c69b2db" );
    self endon( #"disconnect" );
    bootsfx = utility::getfx( "ztron_player_speed_boots" );
    stopfxontag( bootsfx, self, "tag_origin" );
    waitframe();
    playfxontag( bootsfx, self, "tag_origin" );
    msg = utility::waittill_any_timeout( timeout, "last_stand_enter", "death", "force_reset_speed" );
    
    if ( isdefined( self ) )
    {
        stopfxontag( bootsfx, self, "tag_origin" );
    }
}

// Namespace namespace_33ec8ba9a5b9520d
// Params 0, eflags: 0x4
// Checksum 0xadc8943f, Offset: 0x314
// Size: 0x3c
function private function_b4791e57e04b282f()
{
    self endon( #"disconnect" );
    self endon( #"speed_reset" );
    utility::waittill_any( "vehicle_enter", "slowed_by_hazard" );
    
    if ( isdefined( self ) )
    {
        self notify( #"force_reset_speed" );
    }
}

