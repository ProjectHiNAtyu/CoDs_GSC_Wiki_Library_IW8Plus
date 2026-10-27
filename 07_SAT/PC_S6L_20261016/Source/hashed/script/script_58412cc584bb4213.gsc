// script_58412cc584bb4213  (hash_58412cc584bb4213.gscc) (size: 3778 Bytes / 0xec2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9eba2ee9 (2663001833)
// size ...... 3778 (0xec2)
// includes .. 9   (offset: 0xe22)
// strings ... 7   (offset: 0xe6a)
// dev strs .. 0   (offset: 0xec2)
// exports ... 10  (offset: 0x7ea)
// cseg ...... 0xd2 + 0x718 (0x7ea)
// imports ... 41  (offset: 0x97a)
// animtree1 . 0   (offset: 0xec2)
// animtree2 . 0   (offset: 0xec2)
#using script_4bda2887133143de;
#using script_71717c2382b8911e;
#using script_9d7b1b99a878301;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_791b8fb7dc4f4007;

// Namespace namespace_791b8fb7dc4f4007
// Params 0, eflags: 0x5
// Checksum 0x52b77fe9, Offset: 0xf0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bc5541e4760f4f42", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_791b8fb7dc4f4007
// Params 0
// Checksum 0xfa34ef29, Offset: 0x119
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"moving_laser", #"create", &function_9965d8dd3de14c53 );
    ztron_hazard::function_6f661fac5fd31f1( #"moving_laser", #"arenaspawn", &function_ad2761b25ee2ea80 );
}

// Namespace namespace_791b8fb7dc4f4007
// Params 0
// Checksum 0x89bfe55a, Offset: 0x15f
// Size: 0x9c
function function_ad2761b25ee2ea80()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "moving_laser" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_9965d8dd3de14c53( var_4d080f710fb8349e );
    }
}

// Namespace namespace_791b8fb7dc4f4007
// Params 2
// Checksum 0x216555e8, Offset: 0x203
// Size: 0xa4
function function_9965d8dd3de14c53( trap, paged )
{
    trap.moving_state = 0;
    trap function_830d3f6222618dd8();
    trap function_374025a1c7df07ef();
    trap thread ztron_hazard_moving_platform::function_ab7a138d5123d51e( trap.moveorg );
    trap thread function_55cdcb1cfc634b55( trap.trigger );
    trap thread ztron_hazard_laser::function_5acdf668c0f45cbd( trap.beam );
    trap thread laserdeathwatcher();
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            trap thread ztron_hazard_laser::drawtrigger( trap.trigger );
        }
    #/
}

// Namespace namespace_791b8fb7dc4f4007
// Params 1
// Checksum 0x4bd65dbb, Offset: 0x2af
// Size: 0x76
function function_830d3f6222618dd8( trap )
{
    ztron_hazard_moving_platform::function_1e2210d0aea2cda9( self );
    splitstrings = strtok( self.script_label, ";" );
    self.length = isdefined( splitstrings[ 2 ] ) ? int( splitstrings[ 2 ] ) : 128;
    self.laserdir = anglestoforward( self.angles ?? ( 0, 0, 0 ) );
}

// Namespace namespace_791b8fb7dc4f4007
// Params 0
// Checksum 0x2555cde0, Offset: 0x32d
// Size: 0x27a
function function_374025a1c7df07ef()
{
    if ( !isdefined( self.moveorg ) )
    {
        self.moveorg = utility::function_1808878d1c511ce8( self.origin, self.angles );
    }
    
    if ( !isdefined( self.var_7ed5fbd3d5fbdf39 ) )
    {
        self.var_7ed5fbd3d5fbdf39 = utility::function_1808878d1c511ce8( self.origin, ( 0, 0, 0 ) );
        self.var_7ed5fbd3d5fbdf39 enablelinkto();
        self.var_7ed5fbd3d5fbdf39 linkto( self.moveorg );
    }
    
    if ( !isdefined( self.var_7ed5f8d3d5fbd8a0 ) )
    {
        endpoint = vectornormalize( self.laserdir ) * self.length + self.origin;
        self.var_7ed5f8d3d5fbd8a0 = utility::function_1808878d1c511ce8( endpoint, ( 0, 0, 0 ) );
        self.var_7ed5f8d3d5fbd8a0 enablelinkto();
        self.var_7ed5f8d3d5fbd8a0 linkto( self.moveorg );
    }
    
    if ( !isdefined( self.beam ) )
    {
        self.beam = playfxontagsbetweenclients( utility::getfx( "ztron_hazard_laser_trap" ), self.var_7ed5fbd3d5fbdf39, "tag_origin", self.var_7ed5f8d3d5fbd8a0, "tag_origin" );
    }
    
    if ( !isdefined( self.trigger ) )
    {
        size = ( distance( self.var_7ed5fbd3d5fbdf39.origin, self.var_7ed5f8d3d5fbd8a0.origin ) / 2, 4, 4 );
        centerorigin = ( self.var_7ed5f8d3d5fbd8a0.origin - self.var_7ed5fbd3d5fbdf39.origin ) / 2 + self.var_7ed5fbd3d5fbdf39.origin;
        trigger = spawn( "trigger_box", centerorigin, 0, size, size );
        trigger.angles = vectortoangles( self.var_7ed5f8d3d5fbd8a0.origin - self.var_7ed5fbd3d5fbdf39.origin );
        self.trigger = trigger;
        trigger.owner = self;
        self.trigger enablelinkto();
        self.trigger linkto( self.moveorg );
        ztron_sound::ztron_playsound( "ztron_laser_trap_active_lp", undefined, self.trigger );
    }
}

// Namespace namespace_791b8fb7dc4f4007
// Params 0
// Checksum 0x6097501f, Offset: 0x5af
// Size: 0xfc
function laserdeathwatcher()
{
    self notify( #"hash_3754dbb4dc991c4d" );
    self endon( #"hash_3754dbb4dc991c4d" );
    level endon( #"ztron_game_is_over" );
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
    
    if ( isdefined( self.moveorg ) )
    {
        self.moveorg delete();
        self.moveorg = undefined;
    }
}

// Namespace namespace_791b8fb7dc4f4007
// Params 1
// Checksum 0x5c225d21, Offset: 0x6b3
// Size: 0x118
function function_55cdcb1cfc634b55( trigger )
{
    self notify( #"hash_2b61a085dae000d1" );
    self endon( #"hash_2b61a085dae000d1" );
    trigger endon( #"death" );
    self endon( #"destroy_hazard" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isplayer( ent ) || ent vehicle::is_vehicle() )
        {
            ent dodamage( ent.maxhealth * function_46f0b3963ad6267f(), ent.origin, trigger, trigger, "MOD_UNKNOWN" );
            continue;
        }
        
        if ( isagent( ent ) )
        {
            if ( !ent.nogib )
            {
                ent ztron_hazard_laser::dismember_zombie();
            }
            
            ent thread ztron_hazard_laser::function_858959a905cca369();
            ent dodamage( ent.health, ent.origin, trigger, trigger );
        }
    }
}

// Namespace namespace_791b8fb7dc4f4007
// Params 0, eflags: 0x4
// Checksum 0x3ba7676e, Offset: 0x7d3
// Size: 0x17
function private function_46f0b3963ad6267f()
{
    if ( namespace_4ad55357f99ed963::function_4fd806686bdab01e() )
    {
        return 1;
    }
    
    return 0.3;
}

