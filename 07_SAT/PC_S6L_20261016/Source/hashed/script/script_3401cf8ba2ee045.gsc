// script_3401cf8ba2ee045  (hash_03401cf8ba2ee045.gscc) (size: 7417 Bytes / 0x1cf9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x691b7cae (1763409070)
// size ...... 7417 (0x1cf9)
// includes .. 7   (offset: 0x1afd)
// strings ... 29  (offset: 0x1b35)
// dev strs .. 3   (offset: 0x1cd5)
// exports ... 16  (offset: 0x10b5)
// cseg ...... 0x30f + 0xda6 (0x10b5)
// imports ... 68  (offset: 0x1335)
// animtree1 . 0   (offset: 0x1cf9)
// animtree2 . 0   (offset: 0x1cf9)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_73e2c42fdcce1e90;

// Namespace namespace_73e2c42fdcce1e90
// Params 0, eflags: 0x5
// Checksum 0x86b2146e, Offset: 0x32d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_dd386aeeac3ce585", #"ztron_item", undefined, &init );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 0
// Checksum 0x3238cfbd, Offset: 0x356
// Size: 0x70
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"barrel", #"use", &usebarrel );
    level.ztron.barrel_explo_fx = loadfxasset( "vfx_core_explo_grenadeexp_default" );
    ztron_sound::function_4ac735395b173fe( "barrel_explo_OS", "evt_ztron_hazard_redbarrel_explosion" );
    ztron_sound::function_4ac735395b173fe( "barrel_impact_OS", "evt_ztron_pickup_barrel_active_impact" );
    ztron_sound::function_4ac735395b173fe( "barrel_launch_OS", "evt_ztron_pickup_barrel_active_end" );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 2
// Checksum 0x9de1bed5, Offset: 0x3ce
// Size: 0x56
function function_a84b31d195eeb3b1( owner, duration )
{
    if ( duration )
    {
        if ( owner.ztron.var_2588c7465d7536b2 & 4 )
        {
            duration = int( duration * 1.25 );
        }
        
        duration = owner ztron_player_utility::function_10777122eee28fa8( duration, 1 );
    }
    
    return int( duration );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 1
// Checksum 0x4a1385ea, Offset: 0x42d
// Size: 0x77
function usebarrel( params )
{
    owner = params.player;
    storebought = params.scriptable.storebought ?? 0;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    thread activatebarrel( owner, itemdata.duration, storebought );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 0
// Checksum 0x3e965f59, Offset: 0x4ac
// Size: 0xf, Type: bool
function function_e2dc036bf709683e()
{
    return self.lifetime ?? 0;
}

// Namespace namespace_73e2c42fdcce1e90
// Params 5
// Checksum 0x80525040, Offset: 0x4c4
// Size: 0x2be
function activatebarrel( owner, duration, storebought = 0, permanent = 0, var_4f41655560136ded = 0 )
{
    owner notify( #"kill_duplicate_shields" );
    owner endon( #"disconnect" );
    owner endon( #"kill_duplicate_shields" );
    waitframe();
    speed = 180;
    
    if ( owner.ztron.var_2588c7465d7536b2 & 4 )
    {
        speed *= 1.25;
    }
    
    if ( permanent )
    {
        assert( !isdefined( owner.ztron.permabarrel ), "<dev string:x24>" );
        owner.ztron.permabarrel = spawnbarrel( owner, ( 70, 0, 12 ), "ztron_nuclear_barrel" );
        var_7c4d5294acdb33b4 = ztron_item::function_19da353cdad58904( owner, "tag_origin", owner.ztron.permabarrel, speed, ( 70, 0, 22 ) );
        var_7c4d5294acdb33b4 thread ztron_util::function_36239518d8da65f0( owner.ztron.permabarrel, "death" );
        owner thread function_372cf918870f18c2( owner.ztron.permabarrel );
        return;
    }
    
    if ( !var_4f41655560136ded )
    {
        duration = function_a84b31d195eeb3b1( owner, duration );
    }
    
    profilestart();
    var_6f9107a0d8815b39 = spawnbarrel( owner, ( 70, 0, 12 ) );
    var_6f9107a0d8815b39.lifetime = duration;
    var_6f9104a0d88154a0 = spawnbarrel( owner, ( -70, 0, 12 ) );
    var_6f9104a0d88154a0.lifetime = duration;
    barrel_array = [ var_6f9107a0d8815b39, var_6f9104a0d88154a0 ];
    var_7c4d5294acdb33b4 = ztron_item::function_8b0c01e93664327d( owner, "tag_origin", barrel_array, speed );
    owner.barrel_scriptable = spawnscriptable( "ztron_audio_barrel_powerup", owner.origin, owner.angles );
    owner.barrel_scriptable scriptablesetparententity( owner );
    owner thread barrelvehiclewatcher( storebought );
    owner thread function_3e5f55dbc2250825( barrel_array, owner, var_7c4d5294acdb33b4, storebought );
    owner thread function_58192dc19bafc4de( barrel_array, owner, duration );
    profilestop();
    
    if ( storebought )
    {
        save = spawnstruct();
        save.ref = "ztron_store_sawblade_and_barrel_5min";
        save.entity = var_6f9107a0d8815b39;
        save.var_c93abd0f18db7640 = &function_e2dc036bf709683e;
        owner thread ztron_save::function_70c11aca4f83fcda( save );
    }
}

// Namespace namespace_73e2c42fdcce1e90
// Params 3, eflags: 0x4
// Checksum 0xc12a682a, Offset: 0x78a
// Size: 0xff
function private spawnbarrel( owner, origin_offset, model = "decor_barrel_wood_ztron" )
{
    permanent = model == "ztron_nuclear_barrel";
    barrel = utility::spawn_model( model, owner.origin + origin_offset );
    trigger = spawn( "trigger_radius", barrel.origin, 0, 32, 50 );
    trigger enablelinkto();
    trigger linkto( barrel );
    barrel.trigger = trigger;
    barrel thread function_d028e20a424815a2( trigger, owner, permanent );
    
    /#
        thread function_479d3bb29828dc90( trigger, owner );
    #/
    
    barrel.trigger = trigger;
    barrel thread ztron_util::function_36239518d8da65f0( owner, "game_over_podium_scene" );
    barrel thread ztron_util::function_36239518d8da65f0( owner, "disconnect" );
    barrel.trigger thread ztron_util::function_36239518d8da65f0( barrel, "death" );
    return barrel;
}

// Namespace namespace_73e2c42fdcce1e90
// Params 1, eflags: 0xc
// Checksum 0x70ff52d3, Offset: 0x892
// Size: 0xfb
function private function_372cf918870f18c2( barrel )
{
    self notify( #"hash_c62a550895d2667" );
    self endon( #"hash_c62a550895d2667" );
    self endon( #"disconnect" );
    barrel endon( #"death" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "enter_vehicle", "bonus_room_ready", "outro_start", "game_over_podium_scene" );
        barrel hide();
        barrel notsolid();
        barrel.trigger triggerdisable();
        assert( barrel.trigger function_b0b72d20769d0233() == 0, "<dev string:x44>" );
        utility::waittill_any( "exit_vehicle", "bonus_room_completed" );
        barrel show();
        barrel solid();
        barrel.trigger triggerenable();
        assert( barrel.trigger function_b0b72d20769d0233() == 1, "<dev string:x68>" );
    }
}

// Namespace namespace_73e2c42fdcce1e90
// Params 3, eflags: 0x4
// Checksum 0x21157e90, Offset: 0x995
// Size: 0xe6
function private function_d028e20a424815a2( trigger, owner, permanent )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    trigger endon( #"death" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && ent.team != owner.team )
        {
            ztron_sound::ztron_playsound( "barrel_impact_OS", ent.origin );
            
            if ( isplayer( owner ) )
            {
                owner playrumbleonentity( "damage_heavy" );
            }
            
            dir = ent.origin - self.origin;
            ent thread ztron_util::function_afa1f6a404783c8a( dir, 10000, owner, 0 );
        }
    }
}

// Namespace namespace_73e2c42fdcce1e90
// Params 1, eflags: 0x4
// Checksum 0x29759d1d, Offset: 0xa83
// Size: 0x4b
function private barrellaunch( force )
{
    self solid();
    force *= randomfloatrange( 0.5, 1.5 );
    ztron_sound::ztron_playsound( "barrel_launch_OS", self.origin );
    self physicslaunchserver( self.origin, force );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 3, eflags: 0x4
// Checksum 0x54b1d1cc, Offset: 0xad6
// Size: 0x197
function private barrelcleanup( owner, rotation_center_pos, delay = 4 )
{
    self endon( #"death" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self setmodel( "decor_barrel_wood_ztron_red" );
    movedir = vectornormalize( self.origin - rotation_center_pos + ( 0, 0, 150 ) );
    
    if ( isdefined( owner.barrel_scriptable ) )
    {
        owner.barrel_scriptable freescriptable();
        owner.barrel_scriptable = undefined;
    }
    
    player = owner.is_clone ? owner.owner : owner;
    thread barrellaunch( movedir * 2750 );
    level utility::waittill_any_timeout( delay + randomfloatrange( 0.1, 1 ), "ztron_exit_taken" );
    explosioneffect = spawnfx( level.ztron.barrel_explo_fx, self.origin );
    triggerfx( explosioneffect );
    ztron_sound::ztron_playsound( "barrel_explo_OS", self.origin );
    ztron_util::function_7e8b8153f3f2566( self.origin, 256, 35 * level.ztron.roundnumber, player );
    
    if ( isplayer( owner ) )
    {
        owner playrumbleonentity( "damage_heavy" );
    }
    
    explosioneffect utility::delaycall( 1, &delete );
    self delete();
}

// Namespace namespace_73e2c42fdcce1e90
// Params 4, eflags: 0x4
// Checksum 0x282deb31, Offset: 0xc75
// Size: 0x14b
function private function_3e5f55dbc2250825( barrel_array, owner, var_7c4d5294acdb33b4, storebought = 0 )
{
    level endon( #"ztron_game_is_over" );
    
    if ( storebought )
    {
        result = owner utility::waittill_any_return( "barrel_done", "kill_duplicate_shields", "kill_shield", "disconnect", "death", "clear_active_item", "game_over_podium_scene" );
    }
    else
    {
        result = owner utility::waittill_any_return( "barrel_done", "kill_duplicate_shields", "kill_shield", "disconnect", "death", "game_over_podium_scene" );
    }
    
    delay = 4;
    ztron_item::function_21c3b4ab8aa7468d( barrel_array );
    
    foreach ( barrel in barrel_array )
    {
        barrel thread barrelcleanup( owner, var_7c4d5294acdb33b4.origin, delay );
    }
    
    ztron_item::function_39d7023e3666b11e( var_7c4d5294acdb33b4 );
    owner notify( #"barrel_done" );
}

// Namespace namespace_73e2c42fdcce1e90
// Params 3, eflags: 0x4
// Checksum 0xc8782b88, Offset: 0xdc8
// Size: 0x203
function private function_58192dc19bafc4de( barrel_array, owner, duration )
{
    level endon( #"ztron_game_is_over" );
    owner endon( #"barrel_done" );
    owner endon( #"kill_duplicate_shields" );
    owner endon( #"game_over_podium_scene" );
    
    if ( isplayer( owner ) )
    {
        owner endon( #"disconnect" );
    }
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    var_798c0da379cf5462 = 6;
    
    while ( duration > var_798c0da379cf5462 )
    {
        wait 1;
        duration--;
        
        foreach ( barrel in barrel_array )
        {
            barrel.lifetime = duration;
        }
    }
    
    foreach ( barrel in barrel_array )
    {
        barrel setmodel( "decor_barrel_wood_ztron_red_no_physics" );
    }
    
    while ( duration > 0 )
    {
        wait 1;
        duration--;
        
        foreach ( barrel in barrel_array )
        {
            barrel.lifetime = duration;
        }
    }
    
    if ( isdefined( owner ) )
    {
        owner notify( #"barrel_done" );
    }
}

// Namespace namespace_73e2c42fdcce1e90
// Params 1, eflags: 0x4
// Checksum 0x62e17093, Offset: 0xfd3
// Size: 0x5d
function private barrelvehiclewatcher( storebought = 0 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"barrel_done" );
    self endon( #"kill_duplicate_shields" );
    self waittill( #"enter_vehicle" );
    
    if ( isdefined( self ) && !storebought )
    {
        self notify( #"barrel_done" );
    }
}

/#

    // Namespace namespace_73e2c42fdcce1e90
    // Params 2, eflags: 0x4
    // Checksum 0x2c3529df, Offset: 0x1038
    // Size: 0x7d, Type: dev
    function private function_479d3bb29828dc90( trigger, owner )
    {
        if ( getdvarint( @"scr_debug_draw_ztron_barrel", 0 ) )
        {
            level endon( #"ztron_game_is_over" );
            owner endon( #"barrel_done" );
            owner endon( #"kill_duplicate_shields" );
            
            while ( isdefined( trigger ) )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
                waitframe();
            }
        }
    }

#/
