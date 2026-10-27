// script_763af4c8c2a152b1  (hash_763af4c8c2a152b1.gscc) (size: 4695 Bytes / 0x1257 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3233a184 (842244484)
// size ...... 4695 (0x1257)
// includes .. 9   (offset: 0x10b7)
// strings ... 26  (offset: 0x10ff)
// dev strs .. 0   (offset: 0x1257)
// exports ... 8   (offset: 0xacf)
// cseg ...... 0x24e + 0x881 (0xacf)
// imports ... 40  (offset: 0xc0f)
// animtree1 . 0   (offset: 0x1257)
// animtree2 . 0   (offset: 0x1257)
#using script_52b2d6abd048104c;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_ad66d454a539231c;

// Namespace namespace_ad66d454a539231c
// Params 0, eflags: 0x5
// Checksum 0x442ce418, Offset: 0x26c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_682a7401208313b5", #"ztron_item", undefined, &init );
}

// Namespace namespace_ad66d454a539231c
// Params 0
// Checksum 0x8354fe4c, Offset: 0x295
// Size: 0x138
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"arcade", #"use", &usearcade );
    ztron_item::function_5844a9c240f7dc8d( #"arcade", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"arcade", #"hash_2dbdd4400cffa8b8", &canitemspawn );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_arcade_active_lp", "evt_ztron_pickup_arcade_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_lightning_bolt", "evt_ztron_lightning_bolt_large" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_arcade_takeoff_OS", "evt_ztron_pickup_sentry_land" );
    level.ztron.var_dd31f3a7d2992ed1 = spawnstruct();
    level.ztron.var_dd31f3a7d2992ed1.current = 0;
    level.ztron.var_dd31f3a7d2992ed1.roomlist = [ "side_scroller1", "side_scroller2", "side_scroller3", "eggxit", "fall_100", "duck_farm", "boom_room", "hangar", "armory" ];
}

// Namespace namespace_ad66d454a539231c
// Params 0
// Checksum 0x31f118fb, Offset: 0x3d5
// Size: 0x42
function function_f7fb12744fd95b5f()
{
    return level.ztron.var_dd31f3a7d2992ed1.roomlist[ randomint( level.ztron.var_dd31f3a7d2992ed1.roomlist.size ) ];
}

// Namespace namespace_ad66d454a539231c
// Params 1, eflags: 0x4
// Checksum 0xcb9dda79, Offset: 0x420
// Size: 0x74, Type: bool
function private canitemspawn( params )
{
    if ( level.ztron.var_371903e5801e0e08 )
    {
        return false;
    }
    
    if ( level.ztron.bossround )
    {
        return false;
    }
    
    var_bf9611110d3c96d6 = level.ztron.roundnumber - level.ztron.lastBonusRoomRound;
    return var_bf9611110d3c96d6 > 3;
}

// Namespace namespace_ad66d454a539231c
// Params 1, eflags: 0x4
// Checksum 0xf8edcdd2, Offset: 0x49d
// Size: 0xe, Type: bool
function private canautouse( params )
{
    return true;
}

// Namespace namespace_ad66d454a539231c
// Params 2, eflags: 0x4
// Checksum 0xa79226de, Offset: 0x4b4
// Size: 0x2a3
function private function_b372c1e99cf10b2c( maxstrikes = 2, player )
{
    self endon( #"death" );
    level endon( #"game_over" );
    
    while ( maxstrikes > 0 )
    {
        teamagents = getaiarrayinradius( self.origin, 1000, zm_utility::get_zombie_team() );
        enemysorted = sortbydistance( teamagents, self.origin );
        potentials = [];
        
        foreach ( guy in enemysorted )
        {
            if ( guy.var_d30910d6dee056 )
            {
                continue;
            }
            
            potentials[ potentials.size ] = guy;
        }
        
        foreach ( guy in potentials )
        {
            if ( isdefined( guy ) )
            {
                if ( guy.ztron.boss )
                {
                    continue;
                }
                
                if ( guy.var_d30910d6dee056 )
                {
                    continue;
                }
                
                if ( guy.var_3af784d9bcd0f8e4 )
                {
                    continue;
                }
                
                in_view = utility::within_fov( self.origin, self.angles, guy.origin, 0.9 );
                
                if ( !in_view )
                {
                    continue;
                }
                
                maxstrikes--;
                guy.var_d30910d6dee056 = 1;
                self.org.origin = self.origin + ( 0, 0, 40 );
                playfxontag( utility::getfx( "ztron_tesla_trail" ), self.org, "tag_origin" );
                self.org moveto( guy.origin + ( 0, 0, 40 ), 0.4 );
                wait 0.4;
                stopfxontag( utility::getfx( "ztron_tesla_trail" ), self.org, "tag_origin" );
                guy namespace_3b4a83e58739c229::function_f371fa9b0bab6a4a( player );
                wait randomfloatrange( 0.4, 2 );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_ad66d454a539231c
// Params 1, eflags: 0x4
// Checksum 0x972c38fc, Offset: 0x75f
// Size: 0x370
function private usearcade( params )
{
    owner = params.player;
    origin = owner.origin;
    
    if ( level.ztron.bossround )
    {
        return;
    }
    
    if ( isdefined( level.ztron.var_8eb300b27e02f4 ) )
    {
        return;
    }
    
    spawnorigin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] );
    
    if ( utility::issharedfuncdefined( #"player", #"hash_9bc79685259c8dd2" ) )
    {
        safeorigin = owner utility::callsharedfunc( #"player", #"hash_9bc79685259c8dd2" );
        
        if ( isdefined( safeorigin ) )
        {
            spawnorigin = safeorigin;
        }
    }
    
    hitp = ztron_util::function_3fe38741460a4a49( spawnorigin );
    spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], hitp[ 2 ] + 12 );
    var_94200014b686b6e3 = utility::spawn_model( "sat_zm_ztron_props_arcade", spawnorigin, owner.angles + ( 0, 180, 0 ) );
    
    if ( !isdefined( var_94200014b686b6e3 ) )
    {
        return;
    }
    
    var_94200014b686b6e3 endon( #"death" );
    var_94200014b686b6e3 notsolid();
    var_94200014b686b6e3.org = utility::spawn_model( "tag_origin", spawnorigin, ( 0, 0, 0 ) );
    
    if ( !isdefined( var_94200014b686b6e3.org ) )
    {
        var_94200014b686b6e3 delete();
        return;
    }
    
    var_94200014b686b6e3.org thread ztron_util::function_36239518d8da65f0( var_94200014b686b6e3, "death" );
    var_94200014b686b6e3 thread ztron_util::function_36239518d8da65f0( level, "game_over" );
    level.ztron.slayer.forcedbonusroom = function_f7fb12744fd95b5f();
    ztron_bonus_room::function_b018ee630661e155( level.ztron.slayer.forcedbonusroom );
    level.ztron.var_8eb300b27e02f4 = var_94200014b686b6e3;
    ztron_sound::ztron_playsound( "ztron_pickup_arcade_active_lp", undefined, var_94200014b686b6e3 );
    var_94200014b686b6e3 thread ztron_util::function_b59665f20a2dbee( 1, 0 );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    timeout = gettime() + owner ztron_player_utility::function_10777122eee28fa8( itemdata.duration * 1000 );
    
    while ( timeout > gettime() )
    {
        if ( utility::flag( "ztron_round_over" ) )
        {
            break;
        }
        
        msg = utility::waittill_any_in_array_or_timeout( [ "exit_taken", "arena_completed" ], randomfloatrange( 1, 4 ) );
        playfxontag( utility::getfx( "lightningStrike" ), var_94200014b686b6e3, "tag_origin" );
        ztron_sound::ztron_playsound( "ztron_lightning_bolt", undefined, var_94200014b686b6e3 );
        var_94200014b686b6e3 thread function_b372c1e99cf10b2c( randomintrange( 1, 5 ), owner );
        
        if ( msg != "timeout" )
        {
            break;
        }
    }
    
    var_94200014b686b6e3 notify( #"stoprotate" );
    playfxontag( utility::getfx( "turret_impact" ), var_94200014b686b6e3, "tag_origin" );
    ztron_sound::ztron_stopsound( var_94200014b686b6e3 );
    ztron_sound::ztron_playsound( "ztron_pickup_arcade_takeoff_OS", undefined, var_94200014b686b6e3 );
    var_94200014b686b6e3 moveto( var_94200014b686b6e3.origin + ( 0, 0, 3000 ), 1 );
    level.ztron.var_8eb300b27e02f4 = undefined;
    wait 1;
    var_94200014b686b6e3.org delete();
    var_94200014b686b6e3 delete();
}

