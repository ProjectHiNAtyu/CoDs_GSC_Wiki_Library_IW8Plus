// script_4bda2887133143de  (hash_4bda2887133143de.gscc) (size: 8598 Bytes / 0x2196 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d7e8a07 (1837009415)
// size ...... 8598 (0x2196)
// includes .. 13  (offset: 0x1f9a)
// strings ... 28  (offset: 0x2002)
// dev strs .. 0   (offset: 0x2196)
// exports ... 21  (offset: 0x1322)
// cseg ...... 0x2af + 0x1073 (0x1322)
// imports ... 79  (offset: 0x166a)
// animtree1 . 0   (offset: 0x2196)
// animtree2 . 0   (offset: 0x2196)
#using script_2b3f8b011222f912;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\debug;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_laser;

// Namespace ztron_hazard_laser
// Params 0, eflags: 0x5
// Checksum 0x7de87a17, Offset: 0x2cd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_laser_trap", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0x5d9a328c, Offset: 0x2f6
// Size: 0x95
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"laser_trap", #"create", &function_b4e3e9bc0f8b3824 );
    ztron_hazard::function_6f661fac5fd31f1( #"laser_trap", #"arenaspawn", &function_b9dd59ce1135739d );
    ztron_sound::function_4ac735395b173fe( "ztron_laser_trap_warning", "evt_ztron_traps_laser_warning" );
    ztron_sound::function_4ac735395b173fe( "ztron_laser_trap_active_lp", "evt_ztron_traps_laser_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_laser_trap_on", "evt_ztron_traps_laser_start" );
    ztron_sound::function_4ac735395b173fe( "ztron_laser_trap_off", "evt_ztron_traps_laser_stop" );
    ztron_sound::function_4ac735395b173fe( "ztron_laser_trap_impact", "evt_ztron_traps_laser_impact" );
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0x6fda6e85, Offset: 0x393
// Size: 0xab
function function_b9dd59ce1135739d()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "laser_trap" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        if ( isdefined( var_4d080f710fb8349e.target ) )
        {
            function_b4e3e9bc0f8b3824( var_4d080f710fb8349e );
        }
    }
}

// Namespace ztron_hazard_laser
// Params 2
// Checksum 0xa1dd38d9, Offset: 0x446
// Size: 0x130
function function_b4e3e9bc0f8b3824( trap, paged )
{
    trap function_830d3f6222618dd8();
    
    if ( !isdefined( trap.activated ) || !isdefined( trap.target ) )
    {
        return;
    }
    
    trap function_374025a1c7df07ef();
    trap thread function_1a3bb6b70661757b();
    
    if ( trap.activated && trap.duration == 0 )
    {
        trap thread function_5acdf668c0f45cbd( trap.beam );
    }
    
    trap thread laserdeathwatcher();
    trap thread roundendwatcher();
    trap thread function_55cdcb1cfc634b55( trap.trigger );
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            thread debug::drawsphere( trap.var_7ed5fbd3d5fbdf39.origin, 5, 100, ( 0, 1, 0 ) );
            thread debug::drawsphere( trap.var_7ed5f8d3d5fbd8a0.origin, 5, 100, ( 0, 1, 0 ) );
            trap thread drawtrigger( trap.trigger );
        }
    #/
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0x84c83b4a, Offset: 0x57e
// Size: 0x29e
function function_374025a1c7df07ef()
{
    if ( !isdefined( self.var_7ed5fbd3d5fbdf39 ) )
    {
        var_7ed5fbd3d5fbdf39 = utility::function_1808878d1c511ce8( self.origin, ( 0, 0, 0 ) );
        self.var_7ed5fbd3d5fbdf39 = var_7ed5fbd3d5fbdf39;
    }
    
    if ( !isdefined( self.var_7ed5f8d3d5fbd8a0 ) )
    {
        endstruct = utility::getstruct( self.target, "targetname" );
        var_7ed5f8d3d5fbd8a0 = utility::function_1808878d1c511ce8( endstruct.origin, ( 0, 0, 0 ) );
        self.var_7ed5f8d3d5fbd8a0 = var_7ed5f8d3d5fbd8a0;
    }
    
    if ( !isdefined( self.trigger ) )
    {
        size = ( distance( self.var_7ed5fbd3d5fbdf39.origin, self.var_7ed5f8d3d5fbd8a0.origin ) / 2, 3, 3 );
        centerorigin = ( self.var_7ed5f8d3d5fbd8a0.origin - self.var_7ed5fbd3d5fbdf39.origin ) / 2 + self.var_7ed5fbd3d5fbdf39.origin;
        trigger = spawn( "trigger_box", centerorigin, 0, size, size );
        trigger.owner = self;
        trigger.angles = vectortoangles( self.var_7ed5f8d3d5fbd8a0.origin - self.var_7ed5fbd3d5fbdf39.origin );
        trigger.isoneshot = 1;
        trigger.var_a2020bf17dd35c72 = size;
        trigger.var_25a91246420e99e = self.var_7ed5fbd3d5fbdf39.origin;
        trigger.var_7457b84496b96be2 = self.var_7ed5f8d3d5fbd8a0.origin;
        self.trigger = trigger;
    }
    
    if ( !isdefined( self.beam ) )
    {
        fx = self.var_3bb2e51468eadc4d == "red" ? "ztron_hazard_laser_trap_red" : "ztron_hazard_laser_trap";
        self.beam = playfxontagsbetweenclients( utility::getfx( fx ), self.var_7ed5fbd3d5fbdf39, "tag_origin", self.var_7ed5f8d3d5fbd8a0, "tag_origin" );
    }
    
    if ( !isdefined( self.beamhint ) )
    {
        self.beamhint = playfxontagsbetweenclients( utility::getfx( "ztron_hazard_laser_trap_hint" ), self.var_7ed5fbd3d5fbdf39, "tag_origin", self.var_7ed5f8d3d5fbd8a0, "tag_origin" );
    }
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xa0cd774a, Offset: 0x824
// Size: 0x7d
function function_830d3f6222618dd8()
{
    if ( isdefined( self.script_parameters ) )
    {
        splitstrings = strtok( self.script_parameters, ";" );
        self.initdelay = float( splitstrings[ 0 ] );
        self.activated = int( splitstrings[ 1 ] );
        self.cooldown = int( splitstrings[ 2 ] );
        self.duration = int( splitstrings[ 3 ] );
        self.var_3bb2e51468eadc4d = splitstrings[ 4 ];
    }
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xc0917578, Offset: 0x8a9
// Size: 0x28, Type: bool
function function_fb9c420dfbee98ef()
{
    return !( self.activated ? self.duration == 0 : self.cooldown == 0 );
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xea50a955, Offset: 0x8da
// Size: 0x7b
function function_e1dc0c51a9ccbe54()
{
    self notify( #"hash_28eececdec76f05b" );
    self endon( #"hash_28eececdec76f05b" );
    self endon( #"destroy_hazard" );
    self.var_782045e4157dc5ab = 0;
    
    while ( true )
    {
        while ( !self.var_782045e4157dc5ab )
        {
            waitframe();
        }
        
        ztron_sound::ztron_playsound( "ztron_laser_trap_warning", undefined, self.trigger );
        
        while ( self.var_782045e4157dc5ab )
        {
            waitframe();
        }
        
        ztron_sound::ztron_stoploopsound( "ztron_laser_trap_warning" );
    }
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xa8e7df54, Offset: 0x95d
// Size: 0xd5
function function_1a3bb6b70661757b()
{
    self notify( #"hash_4336d4b24e47b7b7" );
    self endon( #"hash_4336d4b24e47b7b7" );
    self endon( #"destroy_hazard" );
    thread function_e1dc0c51a9ccbe54();
    togglelaser( self.activated, self.initdelay );
    
    while ( isdefined( self.var_7ed5fbd3d5fbdf39 ) && isdefined( self.var_7ed5f8d3d5fbd8a0 ) )
    {
        if ( function_fb9c420dfbee98ef() )
        {
            if ( !self.activated && gettime() > self.var_83064dba5bafe44e - 4000 )
            {
                self.var_782045e4157dc5ab = 1;
                self.beamhint show();
            }
            
            if ( gettime() > self.var_83064dba5bafe44e )
            {
                self.var_782045e4157dc5ab = 0;
                togglelaser( !self.activated );
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_hazard_laser
// Params 1
// Checksum 0xeaaef891, Offset: 0xa3a
// Size: 0x69
function function_5acdf668c0f45cbd( beam )
{
    self notify( #"hash_4c57a8365db6bf69" );
    self endon( #"hash_4c57a8365db6bf69" );
    beam endon( #"death" );
    self endon( #"destroy_hazard" );
    
    while ( isdefined( beam ) )
    {
        level waittill( #"hash_2bc51110a02eb3c3", player );
        player thread function_661ec88680c7353d( beam );
    }
}

// Namespace ztron_hazard_laser
// Params 1, eflags: 0x4
// Checksum 0x2072fb40, Offset: 0xaab
// Size: 0x57
function private function_661ec88680c7353d( beam )
{
    beam endon( #"death" );
    self endon( #"disconnect" );
    
    while ( !self.versusdone )
    {
        waitframe();
    }
    
    if ( isdefined( beam ) )
    {
        beam hidefromplayer( self );
        waitframe();
        
        if ( isdefined( beam ) && isdefined( self ) )
        {
            beam show();
        }
    }
}

// Namespace ztron_hazard_laser
// Params 2
// Checksum 0xc3b42bf9, Offset: 0xb0a
// Size: 0x107
function togglelaser( activated, initdelay )
{
    if ( activated )
    {
        self.beam show();
        ztron_sound::ztron_stopsound( self.trigger );
        ztron_sound::ztron_playsound( "ztron_laser_trap_on", undefined, self.trigger );
        ztron_sound::ztron_playsound( "ztron_laser_trap_active_lp", undefined, self.trigger );
    }
    else
    {
        self.beam hide();
        ztron_sound::ztron_stopsound( self.trigger );
        ztron_sound::ztron_playsound( "ztron_laser_trap_off", undefined, self.trigger );
    }
    
    self.beamhint hide();
    self.activated = activated;
    self.var_83064dba5bafe44e = gettime() + ( self.activated ? self.duration : self.cooldown ) * 1000;
    
    if ( initdelay > 0 )
    {
        self.var_83064dba5bafe44e += initdelay * 1000;
    }
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0x98766c5e, Offset: 0xc19
// Size: 0x105
function laserdeathwatcher()
{
    self notify( #"hash_ff980bfce65e53dc" );
    self endon( #"hash_ff980bfce65e53dc" );
    level endon( #"ztron_game_is_over" );
    thread ztron_hazard::function_4d643b159a80c647( 1 );
    self waittill( #"destroy_hazard" );
    
    if ( isdefined( self.var_7ed5fbd3d5fbdf39 ) )
    {
        self.var_7ed5fbd3d5fbdf39 delete();
        self.var_7ed5fbd3d5fbdf39 = undefined;
    }
    
    if ( isdefined( self.var_7ed5f8d3d5fbd8a0 ) )
    {
        self.var_7ed5f8d3d5fbd8a0 delete();
        self.var_7ed5f8d3d5fbd8a0 = undefined;
    }
    
    if ( isdefined( self.trigger ) )
    {
        ztron_sound::ztron_stopsound( self.trigger );
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.beam ) )
    {
        self.beam delete();
        self.beam = undefined;
    }
    
    if ( isdefined( self.beamhint ) )
    {
        self.beamhint delete();
        self.beamhint = undefined;
    }
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xfebeedf6, Offset: 0xd26
// Size: 0x4b
function roundendwatcher()
{
    self notify( #"hash_5aeea58e3aec94c8" );
    self endon( #"hash_5aeea58e3aec94c8" );
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    level waittill( #"round_over" );
    self notify( #"destroy_hazard" );
}

// Namespace ztron_hazard_laser
// Params 1
// Checksum 0xb958632b, Offset: 0xd79
// Size: 0x1f9
function function_55cdcb1cfc634b55( trigger )
{
    self notify( #"hash_ddc8b99f81e46401" );
    self endon( #"hash_ddc8b99f81e46401" );
    trigger endon( #"death" );
    self endon( #"destroy_hazard" );
    content = 0;
    contentcache = level.create_contents_cache ?? trace::make_create_contents_cache();
    content |= contentcache._world | contentcache.vehicle | contentcache.playerclip | contentcache.vehicleclip;
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !self.activated || ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isplayer( ent ) || ent vehicle::is_vehicle() )
        {
            if ( ent.var_36c9b449d0f1069d && !trigger function_764749df5399c352( trigger.var_25a91246420e99e, trigger.var_7457b84496b96be2, ent, content ) )
            {
                continue;
            }
            
            ent dodamage( ent.maxhealth, ent.origin, trigger, trigger, "MOD_UNKNOWN" );
            ztron_sound::ztron_playsound( "ztron_laser_trap_impact", ent.origin );
            continue;
        }
        
        if ( isagent( ent ) )
        {
            if ( ent namespace_b76ff2659823e89d::is_crawling() && ztron_ai_zombie::function_555a3760f7f13d53( ent ) )
            {
                continue;
            }
            
            if ( !ent.nogib )
            {
                ent dismember_zombie();
            }
            
            ent thread function_858959a905cca369();
            ent dodamage( ent.health, ent.origin, trigger, trigger );
            ztron_sound::ztron_playsound( "ztron_laser_trap_impact", ent.origin );
        }
    }
}

// Namespace ztron_hazard_laser
// Params 4
// Checksum 0xe65dccea, Offset: 0xf7a
// Size: 0x107, Type: bool
function function_764749df5399c352( tracestart, traceend, ent, content )
{
    if ( !( isdefined( tracestart ) && isdefined( traceend ) && isdefined( self.var_a2020bf17dd35c72 ) ) )
    {
        return true;
    }
    
    dir = traceend - tracestart;
    dirvec = vectornormalize( ( 0, dir[ 1 ], dir[ 2 ] ) );
    var_fef7ec4f61284092 = vectornormalize( vectorcross( dirvec, ( 1, 0, 0 ) ) );
    offset = self.var_a2020bf17dd35c72[ 2 ] * var_fef7ec4f61284092;
    hitents = [];
    hitents[ hitents.size ] = ent;
    results = trace::ray_trace_ents( tracestart + offset, traceend + offset, hitents, content );
    var_4d9a24a84bd41886 = trace::ray_trace_ents( tracestart - offset, traceend - offset, hitents, content );
    
    if ( results[ "entity" ] || var_4d9a24a84bd41886[ "entity" ] )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0x6ac9859c, Offset: 0x108a
// Size: 0xb8
function function_858959a905cca369()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "darkFlareImpact", "vfx_start" );
    
    if ( !callback::exists( "pre_killed_body_cloned", &function_5da8178bffbab10c ) )
    {
        callback::add( "pre_killed_body_cloned", &function_5da8178bffbab10c );
    }
    
    zombie_emergence_spawning::function_80623a2279a4d888();
    
    if ( isdefined( self getaiblackboarddynamic( "death_dafg_dissolve" ) ) )
    {
        self function_786bb6aa1b76c7ee( "death_dafg_dissolve", 1 );
    }
    
    wait 1;
    utility::function_7c10ea82c1e305b8( "darkFlareImpact", "off" );
    
    if ( isdefined( self getaiblackboarddynamic( "death_dafg_dissolve" ) ) )
    {
        self function_786bb6aa1b76c7ee( "death_dafg_dissolve", 0 );
    }
    
    zombie_emergence_spawning::enable_emergence_spawning();
    callback::remove( "pre_killed_body_cloned", &function_5da8178bffbab10c );
}

// Namespace ztron_hazard_laser
// Params 1, eflags: 0x4
// Checksum 0x9481c1de, Offset: 0x114a
// Size: 0x24
function private function_5da8178bffbab10c( params )
{
    utility::ent_flag_set( "dissolve_purple" );
    utility::ent_flag_set( "dark_aether_bubble" );
}

// Namespace ztron_hazard_laser
// Params 0
// Checksum 0xd05641e1, Offset: 0x1176
// Size: 0x63
function dismember_zombie()
{
    chance = randomint( 100 );
    
    if ( chance < 25 )
    {
        namespace_b76ff2659823e89d::function_6c318bca7bb326e7();
        return;
    }
    
    if ( chance < 50 )
    {
        namespace_b76ff2659823e89d::function_ea9f5a702fae84ee();
        return;
    }
    
    if ( chance < 70 )
    {
        namespace_b76ff2659823e89d::dismember_left_arm();
        return;
    }
    
    if ( chance < 90 )
    {
        namespace_b76ff2659823e89d::dismember_right_arm();
        return;
    }
    
    namespace_b76ff2659823e89d::function_61b75f09c6601780();
}

/#

    // Namespace ztron_hazard_laser
    // Params 1
    // Checksum 0x72b3b1f0, Offset: 0x11e1
    // Size: 0x141, Type: dev
    function drawtrigger( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            
            if ( trigger.var_25a91246420e99e )
            {
                dir = trigger.var_7457b84496b96be2 - trigger.var_25a91246420e99e;
                dirvec = vectornormalize( ( 0, dir[ 1 ], dir[ 2 ] ) );
                var_fef7ec4f61284092 = vectornormalize( vectorcross( dirvec, ( 1, 0, 0 ) ) );
                offset = trigger.var_a2020bf17dd35c72 * var_fef7ec4f61284092;
                thread ztron_debug::drawline( trigger.var_25a91246420e99e + offset, trigger.var_7457b84496b96be2 + offset, 0.05, ( 0, 0, 1 ) );
                thread ztron_debug::drawline( trigger.var_25a91246420e99e - offset, trigger.var_7457b84496b96be2 - offset, 0.05, ( 0, 0, 1 ) );
            }
            
            waitframe();
        }
    }

#/
