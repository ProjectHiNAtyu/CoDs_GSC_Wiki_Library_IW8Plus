// script_34480588ab049163  (hash_34480588ab049163.gscc) (size: 4813 Bytes / 0x12cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef2cea41 (4012698177)
// size ...... 4813 (0x12cd)
// includes .. 6   (offset: 0x11a9)
// strings ... 17  (offset: 0x11d9)
// dev strs .. 0   (offset: 0x12cd)
// exports ... 11  (offset: 0xb01)
// cseg ...... 0x1ec + 0x915 (0xb01)
// imports ... 44  (offset: 0xcb9)
// animtree1 . 0   (offset: 0x12cd)
// animtree2 . 0   (offset: 0x12cd)
#using script_4ce55cfc81c444ad;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_c9144136d44580e6;

// Namespace namespace_c9144136d44580e6
// Params 0, eflags: 0x5
// Checksum 0x1c0052ec, Offset: 0x20a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b9fce2e6aec4ea4b", #"ztron_item", undefined, &init );
}

// Namespace namespace_c9144136d44580e6
// Params 0
// Checksum 0x7ad0b4d7, Offset: 0x233
// Size: 0x6e
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"magnet", #"use", &usemagnet );
    utility::add_fx( "vfx_ztron_magnet", "vfx_sat_zm_magnet_ring_zdo_ztron" );
    utility::add_fx( "vfx_ztron_magnet_fade", "vfx_sat_zm_magnet_ring_fade_ztron" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_magnet_lp", "evt_ztron_pickup_magnet_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_magnet_fade_OS", "evt_ztron_pickup_magnet_active_end" );
    level thread function_884c98cd00b56ac6();
}

// Namespace namespace_c9144136d44580e6
// Params 1
// Checksum 0xff504fc4, Offset: 0x2a9
// Size: 0x52
function usemagnet( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    activatemagnet( player, itemdata.duration );
}

// Namespace namespace_c9144136d44580e6
// Params 2
// Checksum 0x5871a87b, Offset: 0x303
// Size: 0x1c3
function activatemagnet( player, duration )
{
    player endon( #"disconnect" );
    player endon( #"death" );
    
    if ( isdefined( player.ztron.magnetorb ) )
    {
        player.ztron.magnetorb notify( #"expired" );
    }
    
    waitframe();
    magnetorb = utility::spawn_model( "tag_origin", player.origin );
    magnetorb.var_94aa2bee2b8fd1c2 = squared( 400 );
    
    if ( player.ztron.upgradeMask & 524288 )
    {
        magnetorb.var_94aa2bee2b8fd1c2 = int( squared( 400 ) * 1.5 );
        duration *= 1.5;
    }
    
    player.ztron.magnetorb = magnetorb;
    level.ztron.activeattractors[ level.ztron.activeattractors.size ] = magnetorb;
    ztron_sound::ztron_playsound( "ztron_pickup_magnet_lp", undefined, magnetorb );
    playfxontag( utility::getfx( "vfx_ztron_magnet" ), magnetorb, "tag_origin" );
    magnetorb thread playerdeathwatcher( player );
    magnetorb thread function_dbeac90b8f1a4a0b( player );
    magnetorb thread magnetcleanup( player );
    ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_item_magnet_group" ) );
    duration = player ztron_player_utility::function_10777122eee28fa8( duration );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    wait duration;
    ztron_sound::ztron_stopsound( magnetorb );
    ztron_sound::ztron_playsound( "ztron_pickup_magnet_fade_OS", magnetorb.origin );
    magnetorb notify( #"expired" );
}

// Namespace namespace_c9144136d44580e6
// Params 1, eflags: 0x4
// Checksum 0x2ea09d79, Offset: 0x4ce
// Size: 0xa0
function private function_99a5fcdf9057076c( item )
{
    if ( isdefined( self.var_9e9f4765a006b71c ) )
    {
        return [[ self.var_9e9f4765a006b71c ]]( item );
    }
    
    if ( item.inuse )
    {
        return 0;
    }
    
    bundlename = ztron_item::function_2f7a695f25056625( item );
    itemtype = getscriptbundlefieldvalue( bundlename, #"genericstring" );
    return itemtype == #"money" || itemtype == #"coin" || itemtype == #"boost" || itemtype == #"nuke";
}

// Namespace namespace_c9144136d44580e6
// Params 0, eflags: 0xc
// Checksum 0xa181bdf4, Offset: 0x577
// Size: 0x2dd
function private function_884c98cd00b56ac6()
{
    self notify( #"hash_738bd6ee369c4aef" );
    self endon( #"hash_738bd6ee369c4aef" );
    level endon( #"ztron_game_is_over" );
    level.ztron.activeattractors = [];
    
    while ( true )
    {
        waitframe();
        
        if ( level.ztron.activeattractors.size == 0 )
        {
            continue;
        }
        
        foreach ( item in level.ztron.itemdef.spawneditems )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            foreach ( orb in level.ztron.activeattractors )
            {
                if ( !isdefined( orb ) )
                {
                    continue;
                }
                
                if ( !orb function_99a5fcdf9057076c( item ) )
                {
                    continue;
                }
                
                distsq = distancesquared( orb.origin, item.origin );
                var_5c2e474d453e6b5d = orb.var_94aa2bee2b8fd1c2 ?? squared( 400 );
                
                if ( isdefined( level.ztron.attractordistsq ) )
                {
                    var_5c2e474d453e6b5d = level.ztron.attractordistsq;
                }
                
                if ( distsq > var_5c2e474d453e6b5d )
                {
                    continue;
                }
                
                if ( isent( item ) )
                {
                    target = item;
                }
                else
                {
                    item thread ztron_item::function_bae0ccef6b0adbca();
                    target = item.org;
                }
                
                if ( !isdefined( target ) )
                {
                    continue;
                }
                
                var_208a6a73417f7ed0 = item.var_208a6a73417f7ed0 ?? 10;
                var_208a6a73417f7ed0 = level.ztron.var_3cc1134d2808a4e1 ?? var_208a6a73417f7ed0;
                towardsvec = vectornormalize( orb.origin - target.origin );
                scale = ( var_5c2e474d453e6b5d - distsq ) / var_5c2e474d453e6b5d * var_208a6a73417f7ed0;
                movevec = towardsvec * scale;
                target.origin += movevec;
                item notify( #"hash_63d75c8dd85976bf" );
                item thread function_e9b4227897d6e2bb( orb );
            }
        }
    }
}

// Namespace namespace_c9144136d44580e6
// Params 1
// Checksum 0x64c05840, Offset: 0x85c
// Size: 0x148
function function_e9b4227897d6e2bb( attractor )
{
    self notify( #"hash_102e3006729cf48f" );
    self endon( #"hash_102e3006729cf48f" );
    self endon( #"hash_63d75c8dd85976bf" );
    self endon( #"death" );
    msg = attractor utility::waittill_any_return( "expired", "death" );
    target = isent( self ) ? self : self.org;
    
    if ( isdefined( target ) )
    {
        var_9e1a89b22e702898 = 32;
        pos = getgroundposition( target.origin, 32 ) + ( 0, 0, 20 );
        
        while ( isdefined( target ) && target.origin[ 2 ] - pos[ 2 ] > var_9e1a89b22e702898 )
        {
            target.origin -= ( 0, 0, var_9e1a89b22e702898 );
            
            if ( abs( target.origin[ 2 ] - pos[ 2 ] ) < var_9e1a89b22e702898 )
            {
                target.origin = pos;
            }
            
            waitframe();
        }
        
        if ( isdefined( target ) )
        {
            target.origin = pos;
        }
    }
    
    if ( isdefined( self.org ) )
    {
        ztron_item::function_fc50a80f5784c3a6();
    }
}

// Namespace namespace_c9144136d44580e6
// Params 1, eflags: 0xc
// Checksum 0x40ae5505, Offset: 0x9ac
// Size: 0x63
function private playerdeathwatcher( player )
{
    self notify( #"hash_f9dc8fc8d406fa7f" );
    self endon( #"hash_f9dc8fc8d406fa7f" );
    self endon( #"expired" );
    player utility::waittill_any( "death", "kill_shield", "disconnect", "ztron_exit_taken", "ztron_teleporter_taken", "clone_shutdown" );
    self notify( #"expired" );
}

// Namespace namespace_c9144136d44580e6
// Params 1, eflags: 0x4
// Checksum 0xefb60a65, Offset: 0xa17
// Size: 0x33
function private function_dbeac90b8f1a4a0b( player )
{
    self linktoignorerotation( player, "tag_origin", ( 0, 0, 60 ), ( 0, 0, 0 ) );
}

// Namespace namespace_c9144136d44580e6
// Params 1, eflags: 0xc
// Checksum 0xed2027d8, Offset: 0xa52
// Size: 0xaf
function private magnetcleanup( player )
{
    self notify( #"hash_816f850527b8f76a" );
    self endon( #"hash_816f850527b8f76a" );
    self endon( #"death" );
    self waittill( #"expired" );
    level.ztron.activeattractors = arrayremove( level.ztron.activeattractors, self );
    
    if ( isdefined( player ) )
    {
        stopfxontag( utility::getfx( "vfx_ztron_magnet" ), self, "tag_origin" );
        playfxontag( utility::getfx( "vfx_ztron_magnet_fade" ), self, "tag_origin" );
    }
    
    wait 1;
    
    if ( isdefined( self ) )
    {
        self unlink();
        self delete();
    }
}

