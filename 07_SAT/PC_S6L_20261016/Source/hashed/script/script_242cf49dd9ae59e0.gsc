// script_242cf49dd9ae59e0  (hash_242cf49dd9ae59e0.gscc) (size: 4668 Bytes / 0x123c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d7588e7 (1836419303)
// size ...... 4668 (0x123c)
// includes .. 6   (offset: 0x1104)
// strings ... 21  (offset: 0x1134)
// dev strs .. 0   (offset: 0x123c)
// exports ... 11  (offset: 0xa94)
// cseg ...... 0x228 + 0x86c (0xa94)
// imports ... 41  (offset: 0xc4c)
// animtree1 . 0   (offset: 0x123c)
// animtree2 . 0   (offset: 0x123c)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_37fc6eb0d4ca3c9d;

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 0, eflags: 0x5
// Checksum 0x46bb9d63, Offset: 0x246
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_fb9c0ea22107a708", #"ztron_item", undefined, &init );
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 0
// Checksum 0x247715c1, Offset: 0x26f
// Size: 0x53
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"boxing_glove", #"use", &function_6aa5a21ab2722dc7 );
    ztron_sound::function_4ac735395b173fe( "boxing_intro_OS", "null" );
    ztron_sound::function_4ac735395b173fe( "boxing_outro_OS", "evt_ztron_pickup_boxers_outro" );
    ztron_sound::function_4ac735395b173fe( "boxing_impact_OS", "evt_ztron_pickup_boxers_active_impact" );
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 1
// Checksum 0x1aaac173, Offset: 0x2ca
// Size: 0x6a
function function_6aa5a21ab2722dc7( params )
{
    self notify( #"hash_9973b49a679ffd13" );
    self endon( #"hash_9973b49a679ffd13" );
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    function_39f806f311a52dfd( player, itemdata.duration );
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 2
// Checksum 0x5b14d150, Offset: 0x33c
// Size: 0x13b
function function_39f806f311a52dfd( player, duration )
{
    player notify( #"kill_duplicate_shields" );
    player endon( #"disconnect" );
    player endon( #"kill_duplicate_shields" );
    waitframe();
    spot = utility::spawn_model( "tag_origin", player.origin );
    spot linkto( player );
    var_40e68a43b7b48856 = anglestoleft( player.angles ) * 60 + ( 0, 0, 32 );
    var_b9a3ced91f6bf9d = anglestoright( player.angles ) * 60 + ( 0, 0, 32 );
    spot.var_c880884e5dc4d314 = function_255ee8d99035963f( spot, "sat_zm_ztron_props_gloves_lt", var_40e68a43b7b48856, ( 90, player.angles[ 1 ] + 90, 90 ) );
    spot.var_13dbe6e60a606c69 = function_255ee8d99035963f( spot, "sat_zm_ztron_props_gloves_rt", var_b9a3ced91f6bf9d, ( 90, player.angles[ 1 ] + 90, 90 ) );
    player thread function_58192dc19bafc4de( spot, duration );
    player thread function_3e5f55dbc2250825( spot );
    player thread function_480092cfa9af35f6();
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 4, eflags: 0x4
// Checksum 0xeb77380c, Offset: 0x47f
// Size: 0xb8
function private function_255ee8d99035963f( spot, model, originoffset, angle )
{
    glove = utility::spawn_model( model, self.origin + originoffset, angle );
    glove linkto( spot, "tag_origin", originoffset, angle );
    glove notsolid();
    trigger = spawn( "trigger_radius", glove.origin, 0, 30, 40 );
    trigger enablelinkto();
    trigger linkto( glove );
    trigger thread function_d028e20a424815a2( self );
    
    /#
        thread function_e616dff8e24fc8df( trigger );
    #/
    
    glove.trigger = trigger;
    return glove;
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 1, eflags: 0x4
// Checksum 0x7cdd787a, Offset: 0x540
// Size: 0x14a
function private function_d028e20a424815a2( player )
{
    level endon( #"ztron_game_is_over" );
    player endon( #"boxing_done" );
    player endon( #"disconnect" );
    player endon( #"kill_duplicate_shields" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( !isplayer( guy ) && !guy.ztron.boss && guy.team != player.team )
        {
            player playrumbleonentity( "damage_heavy" );
            
            if ( utility::percent_chance( 70 ) )
            {
                playfx( utility::getfx( "ztron_boxing_stars" ), self.origin );
            }
            else
            {
                playfx( utility::getfx( "ztron_boxing_pow" ), self.origin );
            }
            
            ztron_sound::ztron_playsound( "boxing_impact_OS", self.origin );
            dir = guy.origin - self.origin;
            player thread ztron_player_utility::function_9dbd11353321b474( "kapow", guy.var_945ef487faad2413 );
            guy thread ztron_util::function_afa1f6a404783c8a( dir, 100000, player, 0 );
        }
    }
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 2, eflags: 0x4
// Checksum 0xb1304975, Offset: 0x692
// Size: 0x102
function private function_58192dc19bafc4de( spot, duration )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"boxing_done" );
    self endon( #"disconnect" );
    self endon( #"kill_duplicate_shields" );
    
    if ( self.ztron.upgradeMask & 4096 )
    {
        duration *= 1.6;
    }
    
    duration = ztron_player_utility::function_10777122eee28fa8( duration, 1 );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    var_798c0da379cf5462 = 3;
    wait duration - var_798c0da379cf5462;
    
    if ( isdefined( spot.var_c880884e5dc4d314 ) )
    {
        spot.var_c880884e5dc4d314 setmodel( "sat_zm_ztron_props_gloves_lt_expiring" );
    }
    
    if ( isdefined( spot.var_13dbe6e60a606c69 ) )
    {
        spot.var_13dbe6e60a606c69 setmodel( "sat_zm_ztron_props_gloves_rt_expiring" );
    }
    
    wait var_798c0da379cf5462;
    ztron_sound::ztron_playsound( "boxing_outro_OS", self.origin );
    self notify( #"boxing_done" );
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 1, eflags: 0x4
// Checksum 0xd995486b, Offset: 0x79c
// Size: 0x224
function private function_3e5f55dbc2250825( spot )
{
    level endon( #"ztron_game_is_over" );
    utility::waittill_any( "boxing_done", "kill_duplicate_shields", "kill_shield", "disconnect", "death" );
    self notify( #"boxing_done" );
    
    if ( isdefined( spot.var_c880884e5dc4d314.trigger ) )
    {
        spot.var_c880884e5dc4d314.trigger delete();
    }
    
    if ( isdefined( spot.var_13dbe6e60a606c69.trigger ) )
    {
        spot.var_13dbe6e60a606c69.trigger delete();
    }
    
    spot.var_c880884e5dc4d314 unlink();
    spot.var_c880884e5dc4d314 solid();
    spot.var_13dbe6e60a606c69 unlink();
    spot.var_13dbe6e60a606c69 solid();
    waitframe();
    delay = 0.1;
    
    if ( isdefined( spot.var_c880884e5dc4d314 ) && isdefined( self ) )
    {
        vel = spot.var_c880884e5dc4d314.origin - self.origin;
        vel *= 10;
        spot.var_c880884e5dc4d314 physics_takecontrol( 1, spot.var_c880884e5dc4d314.origin, vel );
        delay = 5;
    }
    
    if ( isdefined( spot.var_13dbe6e60a606c69 ) && isdefined( self ) )
    {
        vel = spot.var_13dbe6e60a606c69.origin - self.origin;
        vel *= 10;
        spot.var_13dbe6e60a606c69 physics_takecontrol( 1, spot.var_13dbe6e60a606c69.origin, vel );
        delay = 5;
    }
    
    wait delay;
    
    if ( isdefined( spot.var_c880884e5dc4d314 ) )
    {
        spot.var_c880884e5dc4d314 delete();
    }
    
    if ( isdefined( spot.var_13dbe6e60a606c69 ) )
    {
        spot.var_13dbe6e60a606c69 delete();
    }
    
    if ( isdefined( spot ) )
    {
        spot delete();
    }
}

// Namespace namespace_37fc6eb0d4ca3c9d
// Params 0, eflags: 0x4
// Checksum 0x6d1338c4, Offset: 0x9c8
// Size: 0x44
function private function_480092cfa9af35f6()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"boxing_done" );
    self endon( #"kill_duplicate_shields" );
    self waittill( #"enter_vehicle" );
    
    if ( isdefined( self ) )
    {
        self notify( #"boxing_done" );
    }
}

/#

    // Namespace namespace_37fc6eb0d4ca3c9d
    // Params 1
    // Checksum 0xcee22689, Offset: 0xa14
    // Size: 0x80, Type: dev
    function function_e616dff8e24fc8df( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"boxing_done" );
        self endon( #"kill_duplicate_shields" );
        setdvarifuninitialized( @"scr_debug_draw_ztron_boxing_glove", 0 );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"scr_debug_draw_ztron_boxing_glove" ) )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
