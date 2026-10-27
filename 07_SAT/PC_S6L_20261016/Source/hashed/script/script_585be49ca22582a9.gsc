// script_585be49ca22582a9  (hash_585be49ca22582a9.gscc) (size: 4387 Bytes / 0x1123 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x727484d1 (1920238801)
// size ...... 4387 (0x1123)
// includes .. 9   (offset: 0x1067)
// strings ... 9   (offset: 0x10af)
// dev strs .. 0   (offset: 0x1123)
// exports ... 11  (offset: 0x973)
// cseg ...... 0x112 + 0x861 (0x973)
// imports ... 46  (offset: 0xb2b)
// animtree1 . 0   (offset: 0x1123)
// animtree2 . 0   (offset: 0x1123)
#using script_4bda2887133143de;
#using script_71717c2382b8911e;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_hazard_rotating_laser;

// Namespace ztron_hazard_rotating_laser
// Params 0, eflags: 0x5
// Checksum 0xc6d913f5, Offset: 0x130
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_rotating_laser", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_rotating_laser
// Params 0
// Checksum 0x335f9d97, Offset: 0x159
// Size: 0x51
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"rotating_laser", #"create", &function_60be83c5093e7065 );
    ztron_hazard::function_6f661fac5fd31f1( #"rotating_laser", #"arenaspawn", &function_7865a0fb1cc0406 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_rotating_laser_lp", "evt_ztron_traps_laser_lp", 1 );
}

// Namespace ztron_hazard_rotating_laser
// Params 0
// Checksum 0x447b1079, Offset: 0x1b2
// Size: 0x9c
function function_7865a0fb1cc0406()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "rotating_laser" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_60be83c5093e7065( var_4d080f710fb8349e );
    }
}

// Namespace ztron_hazard_rotating_laser
// Params 2
// Checksum 0x302df27c, Offset: 0x256
// Size: 0x97
function function_60be83c5093e7065( trap, paged )
{
    trap function_830d3f6222618dd8();
    trap function_374025a1c7df07ef();
    trap thread function_55cdcb1cfc634b55( trap.trigger );
    trap thread function_9f2ebd4b67c6acaa( trap.moveorg );
    trap thread ztron_hazard_laser::function_5acdf668c0f45cbd( trap.beam );
    trap thread laserdeathwatcher();
    
    /#
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            trap thread ztron_hazard_laser::drawtrigger( trap.trigger );
        }
    #/
}

// Namespace ztron_hazard_rotating_laser
// Params 0
// Checksum 0x3c98cf3d, Offset: 0x2f5
// Size: 0x74
function function_830d3f6222618dd8()
{
    if ( isdefined( self.script_parameters ) )
    {
        splitstrings = strtok( self.script_parameters, ";" );
        self.length = int( splitstrings[ 0 ] );
        self.rotatespeed = float( splitstrings[ 1 ] );
        self.laserdir = anglestoforward( self.angles ?? ( 0, 0, 0 ) );
    }
}

// Namespace ztron_hazard_rotating_laser
// Params 0
// Checksum 0x7cfac508, Offset: 0x371
// Size: 0x298
function function_374025a1c7df07ef()
{
    if ( !isdefined( self.moveorg ) )
    {
        self.moveorg = utility::function_1808878d1c511ce8( self.origin, self.angles ?? ( 0, 0, 0 ) );
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
        trigger.var_a2020bf17dd35c72 = size;
        trigger.angles = vectortoangles( self.var_7ed5f8d3d5fbd8a0.origin - self.var_7ed5fbd3d5fbdf39.origin );
        self.trigger = trigger;
        trigger.owner = self;
        self.trigger enablelinkto();
        self.trigger linkto( self.moveorg );
        ztron_sound::ztron_playsound( "ztron_laser_trap_active_lp", undefined, self.trigger );
    }
}

// Namespace ztron_hazard_rotating_laser
// Params 1
// Checksum 0x4534bc7c, Offset: 0x611
// Size: 0x66
function function_9f2ebd4b67c6acaa( moveorg )
{
    self notify( #"hash_4920005119ff0795" );
    self endon( #"hash_4920005119ff0795" );
    moveorg endon( #"death" );
    self endon( #"destroy_hazard" );
    ztron_sound::ztron_playsound( "ztron_hazard_rotating_laser_lp", undefined, moveorg );
    
    while ( isdefined( moveorg ) )
    {
        moveorg addyaw( self.rotatespeed );
        waitframe();
    }
}

// Namespace ztron_hazard_rotating_laser
// Params 0
// Checksum 0xe487d1be, Offset: 0x67f
// Size: 0x113
function laserdeathwatcher()
{
    self notify( #"hash_ee8ab128c727ef1f" );
    self endon( #"hash_ee8ab128c727ef1f" );
    level endon( #"ztron_game_is_over" );
    thread ztron_hazard::function_4d643b159a80c647();
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
        ztron_sound::ztron_stopsound( self.moveorg );
        self.moveorg delete();
        self.moveorg = undefined;
    }
}

// Namespace ztron_hazard_rotating_laser
// Params 1
// Checksum 0xac8c3da0, Offset: 0x79a
// Size: 0x1ba
function function_55cdcb1cfc634b55( trigger )
{
    self notify( #"hash_e70bec99735efe09" );
    self endon( #"hash_e70bec99735efe09" );
    trigger endon( #"death" );
    self endon( #"destroy_hazard" );
    content = 0;
    contentcache = level.create_contents_cache ?? trace::make_create_contents_cache();
    content |= contentcache._world | contentcache.vehicle | contentcache.playerclip | contentcache.vehicleclip;
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( ent.no_hazards || ent.ztron.boss )
        {
            continue;
        }
        
        if ( isplayer( ent ) || ent vehicle::is_vehicle() )
        {
            if ( ent.var_36c9b449d0f1069d && !trigger ztron_hazard_laser::function_764749df5399c352( self.var_7ed5fbd3d5fbdf39.origin, self.var_7ed5f8d3d5fbd8a0.origin, ent, content ) )
            {
                continue;
            }
            
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

// Namespace ztron_hazard_rotating_laser
// Params 0, eflags: 0x4
// Checksum 0x5483b8e0, Offset: 0x95c
// Size: 0x17
function private function_46f0b3963ad6267f()
{
    if ( namespace_4ad55357f99ed963::function_4fd806686bdab01e() )
    {
        return 1;
    }
    
    return 0.3;
}

