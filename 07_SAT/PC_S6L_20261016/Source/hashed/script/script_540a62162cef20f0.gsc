// script_540a62162cef20f0  (hash_540a62162cef20f0.gscc) (size: 6406 Bytes / 0x1906 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98243360 (2552509280)
// size ...... 6406 (0x1906)
// includes .. 13  (offset: 0x1786)
// strings ... 20  (offset: 0x17ee)
// dev strs .. 0   (offset: 0x1906)
// exports ... 18  (offset: 0xd8e)
// cseg ...... 0x20c + 0xb82 (0xd8e)
// imports ... 62  (offset: 0x105e)
// animtree1 . 0   (offset: 0x1906)
// animtree2 . 0   (offset: 0x1906)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mutant_injection_shared;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace namespace_9c38de505200a0ad;

// Namespace namespace_9c38de505200a0ad
// Params 0, eflags: 0x5
// Checksum 0xf9fa39a0, Offset: 0x22a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b2882a6d533d0a38", #"ztron_item", undefined, &init );
}

// Namespace namespace_9c38de505200a0ad
// Params 0
// Checksum 0x9bfdcb59, Offset: 0x253
// Size: 0x93
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"mutant_injection", #"use", &function_c311a6e3210783c3 );
    ztron_item::function_5844a9c240f7dc8d( #"disciple_injection", #"use", &function_c311a6e3210783c3 );
    ztron_item::function_5844a9c240f7dc8d( #"mutant_injection", #"canautouse", &can_auto_use );
    ztron_item::function_5844a9c240f7dc8d( #"disciple_injection", #"canautouse", &can_auto_use );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_mutant_injection_OS", "evt_ztron_mutant_injection_start" );
    level thread function_8e6f42288af40642();
}

// Namespace namespace_9c38de505200a0ad
// Params 0
// Checksum 0x206a7f13, Offset: 0x2ee
// Size: 0xfb
function function_8e6f42288af40642()
{
    waitframe();
    level utility::registersharedfunc( #"mutant_injection", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    level utility::registersharedfunc( #"zm_dinj", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    level utility::registersharedfunc( #"mutant_injection", #"getconfig", &getconfig );
    level utility::registersharedfunc( #"zm_dinj", #"getconfig", &getconfig );
    level utility::registersharedfunc( #"mutant_injection", #"overridetimeout", &function_e838b0a95cb15fd6 );
    level utility::registersharedfunc( #"zm_dinj", #"overridetimeout", &function_e838b0a95cb15fd6 );
    level utility::registersharedfunc( #"mutant_injection", #"hash_2a99682c5fc5e5ab", &function_9ad2bb8e50961dd2 );
    level utility::registersharedfunc( #"zm_dinj", #"hash_2a99682c5fc5e5ab", &function_9ad2bb8e50961dd2 );
}

// Namespace namespace_9c38de505200a0ad
// Params 1
// Checksum 0xb57431d1, Offset: 0x3f1
// Size: 0x25
function function_9ad2bb8e50961dd2( endnotes )
{
    self.ztron.var_607326a01e81ad4f = &function_42e7ea288d2f4227;
}

// Namespace namespace_9c38de505200a0ad
// Params 0
// Checksum 0x878f2673, Offset: 0x41e
// Size: 0x24
function function_42e7ea288d2f4227()
{
    if ( self.ztron.usingmutant )
    {
        self notify( #"mutantinjection_exit" );
    }
}

// Namespace namespace_9c38de505200a0ad
// Params 1
// Checksum 0x27ab4c9d, Offset: 0x44a
// Size: 0x19d
function function_e838b0a95cb15fd6( endnotes )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death_or_disconnect" );
    
    if ( isarray( endnotes ) )
    {
        foreach ( note in endnotes )
        {
            self endon( note );
        }
    }
    
    duration = 45;
    
    if ( isdefined( self.micontext.itembundle ) )
    {
        itemdata = ztron_item::function_998f2b10462afbf4( self.micontext.itembundle );
        duration = ztron_player_utility::function_10777122eee28fa8( itemdata.duration );
    }
    
    duration = utility::function_4b74c15943231980( duration );
    
    while ( self.var_5b2350918da14d25 )
    {
        waitframe();
    }
    
    start_time = gettime();
    self.mutant_injection_end_time = start_time + duration;
    self.mutant_injection_start_time = start_time;
    
    while ( gettime() < self.mutant_injection_end_time )
    {
        time_progress = ( self.mutant_injection_end_time - gettime() ) / duration;
        self setclientomnvar( "ui_zm_zm_minj_progress", time_progress );
        waitframe();
    }
    
    self setclientomnvar( "ui_zm_zm_minj_progress", 0 );
    self.mutant_injection_end_time = undefined;
    self.mutant_injection_start_time = undefined;
    self notify( #"mutant_injection_time_out" );
}

// Namespace namespace_9c38de505200a0ad
// Params 1, eflags: 0x4
// Checksum 0xb70b99d5, Offset: 0x5ef
// Size: 0x4b, Type: bool
function private can_auto_use( params )
{
    return isplayer( self ) && !killstreak::ismutantinjection() && !ztron_player_utility::function_32883fa42c326520() && !self getcamerathirdperson() && !level utility::flag( "ztron_cutscene" ) && self isonground();
}

// Namespace namespace_9c38de505200a0ad
// Params 3
// Checksum 0x146bcb41, Offset: 0x643
// Size: 0x2d0
function function_9cdbe50399a4b30a( player, type = "zm_minj", bundle )
{
    self notify( #"hash_9e952f61167db796" );
    self endon( #"hash_9e952f61167db796" );
    player endon( #"disconnect" );
    isdisciple = type == "zm_dinj";
    player.ztron.usingmutant = 1;
    ztron_sound::ztron_playsound( "ztron_pickup_mutant_injection_OS", player.origin );
    player val::set( "ztron_mutant_injection", "weapon_switch", 1 );
    player val::set( "ztron_mutant_injection", "melee", 1 );
    player.ztron.var_ccae92f84b4e34b2 = 1;
    
    if ( isdefined( player.ztron.currentweapon ) )
    {
        player takeweapon( player.ztron.currentweapon );
    }
    
    player killstreaks::awardkillstreak( type, "other", undefined, undefined, undefined, 1 );
    streak_item = player killstreaks::getkillstreakinslot( 1 );
    success = player killstreaks::triggerkillstreak( streak_item, 1 );
    
    if ( !success )
    {
        player val::reset_all( "ztron_mutant_injection" );
        player.ztron.usingmutant = undefined;
        player resetweapon();
    }
    else
    {
        if ( !ztron_item::function_4b0636e7b2fc461f() )
        {
            player.var_5b2350918da14d25 = 1;
            player thread function_a4c520f07f0bc43c();
        }
        
        player notify( #"hash_463ac41b7bf90869" );
        player.ztron.var_74a3707334cfe144 = 1;
        player ztron_camera::function_79d64be315aa51c9( 4 );
        player ztron_score::function_4ea454cb6435a318();
        player.ztron.blockboost = 1;
        player.ztron.var_557a2e6d2ffa015c = 1;
        player.ztron.var_8a46e28ad02229a8 = 1;
        player.micontext.itembundle = bundle;
        
        if ( !isdefined( player.ztron.var_a6cc3941355a4845 ) )
        {
            player.ztron.var_a6cc3941355a4845 = "ztron_player_trail_" + player.ztron.color;
            playfxontag( utility::getfx( player.ztron.var_a6cc3941355a4845 ), player, "tag_origin" );
        }
        
        player thread function_c653ad3b67743d5f();
        player thread function_80e0c0b19820605d();
        player thread function_8358183514901ca8( isdisciple );
    }
    
    player killstreaks::removekillstreak( 1 );
    return success;
}

// Namespace namespace_9c38de505200a0ad
// Params 1
// Checksum 0xd3386f87, Offset: 0x91c
// Size: 0x7b
function function_c311a6e3210783c3( params )
{
    player = params.player;
    
    if ( player killstreak::ismutantinjection() )
    {
        return 0;
    }
    
    if ( params.bundle.ref == "ztron_disciple_injection" )
    {
        streakname = "zm_dinj";
    }
    else
    {
        streakname = "zm_minj";
    }
    
    return function_9cdbe50399a4b30a( player, streakname, params.bundle );
}

// Namespace namespace_9c38de505200a0ad
// Params 1, eflags: 0xc
// Checksum 0xc78c46f9, Offset: 0x9a0
// Size: 0x60
function private function_a4c520f07f0bc43c( time )
{
    self notify( #"hash_b927580d3082fb26" );
    self endon( #"hash_b927580d3082fb26" );
    self endon( #"disconnect" );
    self endon( #"returned_to_human" );
    self endon( #"mutant_injecton_instant_exit" );
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    self.var_5b2350918da14d25 = undefined;
}

// Namespace namespace_9c38de505200a0ad
// Params 0, eflags: 0xc
// Checksum 0xeb57bb04, Offset: 0xa08
// Size: 0x1dc
function private function_c653ad3b67743d5f()
{
    self notify( #"hash_d6ab2eeee70eeee8" );
    self endon( #"hash_d6ab2eeee70eeee8" );
    self endon( #"disconnect" );
    msg = utility::waittill_any_return( "returned_to_human", "mutant_injecton_instant_exit" );
    val::reset_all( "ztron_mutant_injection" );
    self.ztron.var_74a3707334cfe144 = 0;
    self.ztron.blockboost = 0;
    self.ztron.var_557a2e6d2ffa015c = 0;
    self.ztron.var_8a46e28ad02229a8 = undefined;
    self.ztron.usingmutant = undefined;
    self.ztron.var_607326a01e81ad4f = undefined;
    self.var_5b2350918da14d25 = undefined;
    
    if ( isdefined( self.ztron.var_a6cc3941355a4845 ) )
    {
        stopfxontag( utility::getfx( self.ztron.var_a6cc3941355a4845 ), self, "tag_origin" );
        self.ztron.var_a6cc3941355a4845 = undefined;
    }
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) && level.ztron.var_8a9067aa4cd65369.var_6210dc1f68bbfa57 == 0 )
    {
        ztron_camera::function_79d64be315aa51c9( 5 );
    }
    else if ( self.ztron.var_a46fa357ac82e4a != 5 )
    {
        ztron_camera::function_9d2ce447580a6290();
        ztron_player_utility::freezeplayercontrols( 0 );
        thread ztron_camera::function_3f5f4767374bb6c7();
    }
    
    ztron_score::function_4ea454cb6435a318();
    
    if ( msg == "mutant_injecton_instant_exit" )
    {
        thread function_9be05153cade8f47();
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", self.ztron.color );
    }
    
    thread ztron_player_utility::turnPlayerShieldOn();
    resetweapon();
}

// Namespace namespace_9c38de505200a0ad
// Params 0, eflags: 0x4
// Checksum 0xe3619ba4, Offset: 0xbec
// Size: 0x5e
function private function_9be05153cade8f47()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self waittill( #"returned_to_human" );
    
    if ( !isdefined( self.ztron.vehicle ) )
    {
        utility::function_7c10ea82c1e305b8( "ztron_player_trail_fx", self.ztron.color );
    }
}

// Namespace namespace_9c38de505200a0ad
// Params 1, eflags: 0xc
// Checksum 0x58424a23, Offset: 0xc52
// Size: 0x81
function private function_8358183514901ca8( isdisciple )
{
    self notify( #"hash_4009ccba0ccd23f2" );
    self endon( #"hash_4009ccba0ccd23f2" );
    self endon( #"disconnect" );
    self endon( #"returned_to_human" );
    self endon( #"mutant_injecton_instant_exit" );
    utility::waittill_any_ents( level, "ztron_exit_taken", level, "ztron_teleporter_taken", self, "cutscene_played", self, "ztron_player_dump_vehicle" );
    
    if ( isdisciple )
    {
        thread mutant_injection_utility::function_6fa2b0b46d2abcf7( 1 );
        return;
    }
    
    thread mutant_injection_shared::function_6fa2b0b46d2abcf7( 1 );
}

// Namespace namespace_9c38de505200a0ad
// Params 0, eflags: 0xc
// Checksum 0xe7c9be31, Offset: 0xcdb
// Size: 0x44
function private function_80e0c0b19820605d()
{
    self notify( #"hash_3c4055391b39a8c6" );
    self endon( #"hash_3c4055391b39a8c6" );
    self endon( #"disconnect", #"returned_to_human" );
    self waittill( #"mutant_injection_transform_interrupt" );
    waitframe();
    resetweapon();
}

// Namespace namespace_9c38de505200a0ad
// Params 0, eflags: 0x4
// Checksum 0xbce53b76, Offset: 0xd27
// Size: 0x1e
function private resetweapon()
{
    ztron_weapon::function_85196995466c1a41();
    self.ztron.var_ccae92f84b4e34b2 = 0;
}

// Namespace namespace_9c38de505200a0ad
// Params 2
// Checksum 0x67ae1b09, Offset: 0xd4d
// Size: 0x18
function function_c059fcb8b93ffa03( target, damagescale )
{
    return 2000;
}

// Namespace namespace_9c38de505200a0ad
// Params 0
// Checksum 0x52d237a6, Offset: 0xd6e
// Size: 0x1f
function getconfig()
{
    config = {};
    config.var_48388e1c9593fba0 = 10;
    return config;
}

