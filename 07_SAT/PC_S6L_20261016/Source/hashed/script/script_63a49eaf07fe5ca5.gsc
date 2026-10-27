// script_63a49eaf07fe5ca5  (hash_63a49eaf07fe5ca5.gscc) (size: 3208 Bytes / 0xc88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca9178d7 (3398531287)
// size ...... 3208 (0xc88)
// includes .. 5   (offset: 0xb48)
// strings ... 21  (offset: 0xb70)
// dev strs .. 0   (offset: 0xc88)
// exports ... 6   (offset: 0x6b4)
// cseg ...... 0x224 + 0x490 (0x6b4)
// imports ... 32  (offset: 0x7a4)
// animtree1 . 0   (offset: 0xc88)
// animtree2 . 0   (offset: 0xc88)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_2f0a7ae76863c350;

// Namespace namespace_2f0a7ae76863c350
// Params 0, eflags: 0x5
// Checksum 0x532922b5, Offset: 0x242
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5fefd9ca7b8224af", #"ztron_item", undefined, &init );
}

// Namespace namespace_2f0a7ae76863c350
// Params 0
// Checksum 0x2dd356b9, Offset: 0x26b
// Size: 0x55
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"sprinkler", #"use", &use );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_sprinkler_land_OS", "evt_ztron_pickup_sprinkler_land" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_sprinkler_takeoff_OS", "evt_ztron_pickup_sprinkler_takeoff" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_sprinkler_active_lp", "evt_ztron_pickup_sprinkler_active_lp", 1 );
}

// Namespace namespace_2f0a7ae76863c350
// Params 1, eflags: 0x4
// Checksum 0xca60787b, Offset: 0x2c8
// Size: 0x69
function private use( params )
{
    player = params.player;
    origin = player.origin;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    level thread sprinkler_update( player, origin, itemdata.duration );
}

// Namespace namespace_2f0a7ae76863c350
// Params 1, eflags: 0x4
// Checksum 0xe7b6b7a6, Offset: 0x339
// Size: 0x154
function private function_f0e9541f05df3a68( player )
{
    self endon( #"death" );
    self endon( #"sprinkler_done" );
    player endon( #"disconnect" );
    top = self.origin + ( 0, 0, 32 );
    
    while ( true )
    {
        self rotateto( self.angles + ( 0, 15, 0 ), 0.2 );
        wait 0.2;
        forward = anglestoforward( self.angles + ( 0, 0, 500 ) );
        velocity = forward * ( 150 + randomintrange( -50, 50 ) );
        boost = sin( self.angles[ 1 ] );
        
        if ( boost < 0 )
        {
            boost *= -1;
        }
        
        up = mapfloat( 0, 1, 300, 900, boost );
        velocity += ( 0, 0, up );
        grenade = player launchgrenade( "sat_ztron_sprinkler_grenade", top, velocity );
        grenade.team = player.team;
        grenade.owner = player;
        player playrumbleonentity( "damage_light" );
    }
}

// Namespace namespace_2f0a7ae76863c350
// Params 3
// Checksum 0x2b9fff7e, Offset: 0x495
// Size: 0x21f
function sprinkler_update( player, origin, timeout )
{
    dropspot = origin + ( 0, 0, 800 );
    sprinkler_mover = utility::spawn_model( "tag_origin", dropspot );
    sprinkler_scriptable = spawnscriptable( "ztron_sprinkler", dropspot );
    sprinkler_scriptable scriptablesetparententity( sprinkler_mover );
    
    if ( !isdefined( sprinkler_mover ) || !isdefined( sprinkler_scriptable ) )
    {
        return;
    }
    
    target = getgroundposition( player.origin, 1 );
    
    if ( isdefined( player.ztron.vehicle ) )
    {
        target = getgroundposition( player.origin + ( 0, 0, 100 ), 64 );
    }
    
    mark = target + ( 0, 0, 12 );
    sprinkler_mover moveto( mark, 0.5 );
    sprinkler_mover utility::waittill_any_timeout( 1, "movedone" );
    
    if ( isdefined( player ) )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_sprinkler_land_OS", dropspot );
    sprinkler_scriptable setscriptablepartstate( "sprinkler", "land" );
    physicsexplosionsphere( mark, 200, 128, 50 );
    playrumbleonposition( "grenade_rumble", mark );
    wait 1;
    
    if ( isdefined( player ) )
    {
        ztron_sound::ztron_playsound( "ztron_pickup_sprinkler_active_lp", undefined, sprinkler_mover );
        sprinkler_scriptable setscriptablepartstate( "sprinkler", "active" );
        sprinkler_mover thread function_f0e9541f05df3a68( player );
        timeout = player ztron_player_utility::function_10777122eee28fa8( timeout );
        player utility::waittill_any_timeout( timeout, "disconnect", "ztron_exit_taken", "ztron_teleporter_taken" );
        ztron_sound::ztron_stopsound( sprinkler_mover );
    }
    
    sprinkler_mover notify( #"sprinkler_done" );
    sprinkler_scriptable setscriptablepartstate( "sprinkler", "inactive" );
    wait 2;
    ztron_sound::ztron_playsound( "ztron_pickup_sprinkler_takeoff_OS", dropspot );
    sprinkler_scriptable setscriptablepartstate( "sprinkler", "takeoff" );
    sprinkler_mover moveto( dropspot, 0.5 );
    sprinkler_mover utility::waittill_any_timeout( 1, "movedone" );
    sprinkler_mover delete();
    sprinkler_scriptable freescriptable();
}

