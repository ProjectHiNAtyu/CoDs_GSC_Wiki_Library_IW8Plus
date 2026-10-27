// script_5155c7ada2c7988a  (hash_5155c7ada2c7988a.gscc) (size: 4852 Bytes / 0x12f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec20381f (3961534495)
// size ...... 4852 (0x12f4)
// includes .. 8   (offset: 0x11d4)
// strings ... 16  (offset: 0x1214)
// dev strs .. 0   (offset: 0x12f4)
// exports ... 11  (offset: 0xaec)
// cseg ...... 0x20b + 0x8e1 (0xaec)
// imports ... 45  (offset: 0xca4)
// animtree1 . 0   (offset: 0x12f4)
// animtree2 . 0   (offset: 0x12f4)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_hazard_pungi;

// Namespace ztron_hazard_pungi
// Params 0, eflags: 0x5
// Checksum 0x95b0f1b1, Offset: 0x229
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_hazard_pungi", #"ztron_hazards", undefined, &init );
}

// Namespace ztron_hazard_pungi
// Params 0
// Checksum 0x913c9a6c, Offset: 0x252
// Size: 0x71
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"pungi", #"create", &function_80b1e0915bf7e6c3 );
    ztron_hazard::function_6f661fac5fd31f1( #"pungi", #"arenaspawn", &function_5eb78dd0703c9031 );
    ztron_sound::function_4ac735395b173fe( "pungi_deploy", "evt_ztron_hazard_pungi_spike_up" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pungi_spike_set", "evt_ztron_hazard_pungi_spike_set" );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pungi_spike_down", "evt_ztron_hazard_pungi_spike_down" );
}

// Namespace ztron_hazard_pungi
// Params 0
// Checksum 0x4a838935, Offset: 0x2cb
// Size: 0xb1
function function_5eb78dd0703c9031()
{
    level.ztron.var_83554ea9542796a9 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "pungi" );
    
    foreach ( trap in traps )
    {
        function_80b1e0915bf7e6c3( trap );
    }
}

// Namespace ztron_hazard_pungi
// Params 2
// Checksum 0x48824d3, Offset: 0x384
// Size: 0x59
function function_80b1e0915bf7e6c3( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_83554ea9542796a9[ level.ztron.var_83554ea9542796a9.size ] = trap;
        return;
    }
    
    function_53671a12e4f43700( trap );
}

// Namespace ztron_hazard_pungi
// Params 2
// Checksum 0xac3b3742, Offset: 0x3e5
// Size: 0x8e
function function_53671a12e4f43700( trap, paged = 0 )
{
    trap.script_model = utility::spawn_model( "sat_zm_ztron_props_pungi_sticks", trap.origin, trap.angles );
    trap.script_model notsolid();
    trap.script_model.hazardtype = "pungi";
    trap.paged = paged;
    trap thread function_ad4df9f51c3a563d();
    return trap;
}

// Namespace ztron_hazard_pungi
// Params 0, eflags: 0xc
// Checksum 0xe9480ff7, Offset: 0x47c
// Size: 0x105
function private function_427cc35a8fb04389()
{
    self notify( #"hash_fd5347276ba38892" );
    self endon( #"hash_fd5347276ba38892" );
    self endon( #"destroy_hazard" );
    radius = 50;
    
    while ( true )
    {
        corpsearray = function_955f614470e71cb2( self.origin, radius );
        
        if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
        {
            ztron_debug::drawsphere( self.origin, radius, 1, ( 0, 1, 0 ) );
        }
        
        foreach ( corpse in corpsearray )
        {
            corpse thread ztron_util::deletemedelay( 0.5 );
        }
        
        wait 1;
    }
}

// Namespace ztron_hazard_pungi
// Params 0
// Checksum 0xd2bf2693, Offset: 0x589
// Size: 0x21b
function function_ad4df9f51c3a563d()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_7860fe1dfdfd24d3();
    self.state = 1;
    up = anglestoup( self.angles );
    peekoffset = up * -24;
    hideoffset = up * -48;
    wait randomfloat( 10 );
    thread function_427cc35a8fb04389();
    
    while ( isdefined( self.script_model ) )
    {
        self notify( #"hash_ae87b3cbac4ea2e8" );
        
        if ( self.trigger )
        {
            self.trigger triggerdisable();
        }
        
        self.state = 1;
        ztron_sound::ztron_playsound( "ztron_hazard_pungi_spike_down", undefined, self.script_model );
        self.script_model moveto( self.origin + hideoffset, 0.15 );
        self.script_model waittill( #"movedone" );
        self.script_model hide();
        wait 12;
        self.script_model show();
        self.state = 2;
        self.script_model moveto( self.origin + peekoffset, 0.15 );
        self.script_model waittill( #"movedone" );
        ztron_sound::ztron_playsound( "ztron_hazard_pungi_spike_set", undefined, self.script_model );
        playfxontag( utility::getfx( "ztron_hazard_pungi_hint" ), self.script_model, "tag_origin" );
        wait 3;
        self.state = 3;
        thread function_10a80a6a3cc63f6c( 0.15, 6 );
        playfxontag( utility::getfx( "ztron_hazard_pungi_activate" ), self.script_model, "tag_origin" );
        self.script_model moveto( self.origin, 0.15 );
        ztron_sound::ztron_playsound( "pungi_deploy", undefined, self.script_model );
        wait 6;
        stopfxontag( utility::getfx( "ztron_hazard_pungi_hint" ), self.script_model, "tag_origin" );
    }
}

// Namespace ztron_hazard_pungi
// Params 2
// Checksum 0xd9615887, Offset: 0x7ac
// Size: 0x240
function function_10a80a6a3cc63f6c( movetime, lifetime )
{
    self endon( #"destroy_hazard" );
    self endon( #"hash_ae87b3cbac4ea2e8" );
    utility::waittill_any_timeout( movetime + 0.1, "movedone" );
    
    while ( self.state === 3 )
    {
        if ( !self.trigger )
        {
            up = anglestoup( self.angles );
            offset = up * 12;
            triggersize = ( 32, 32, 32 );
            self.trigger = spawn( "trigger_box", self.origin + offset, 0, triggersize, triggersize );
            self.trigger.angles = self.angles;
            self.trigger.owner = self;
            continue;
        }
        
        /#
            thread function_4e919059bbf0fbc9( self.trigger );
        #/
        
        self.trigger triggerenable();
        self.trigger waittill( #"trigger", guy );
        
        if ( isalive( guy ) )
        {
            if ( guy.no_hazards || guy.ztron.boss )
            {
                continue;
            }
            
            if ( guy vehicle::is_vehicle() )
            {
                continue;
            }
            
            if ( !isdefined( guy.var_fc95b04081ec6fbc ) )
            {
                guy.var_fc95b04081ec6fbc = 0;
            }
            
            if ( guy.var_fc95b04081ec6fbc < gettime() )
            {
                ztron_sound::ztron_playsound( "ztron_hazard_pungi_spike_impact", undefined, guy );
                playfxontag( utility::getfx( "ztron_hazard_pungi_damage" ), guy, "tag_origin" );
                guy.var_fc95b04081ec6fbc = gettime() + 1000;
            }
            
            if ( isplayer( guy ) )
            {
                guy dodamage( guy.health + 100, guy.origin, self.trigger, self.script_model );
            }
            else if ( !guy.marked_for_death )
            {
                guy thread ztron_util::function_ea0a0be5c5468c48( 0.1, undefined, undefined, 0 );
            }
        }
        
        continue;
    }
}

// Namespace ztron_hazard_pungi
// Params 0
// Checksum 0x587985b5, Offset: 0x9f4
// Size: 0x92
function function_7860fe1dfdfd24d3()
{
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( self.paged )
    {
        arrayremove( level.ztron.var_83554ea9542796a9, self );
        ztron_debug::debugmsg( "Deleting Pungi trap permenently at:" + self.origin );
    }
    
    waitframe();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

/#

    // Namespace ztron_hazard_pungi
    // Params 2, eflags: 0x4
    // Checksum 0x3f0e273c, Offset: 0xa8e
    // Size: 0x5e, Type: dev
    function private function_4e919059bbf0fbc9( trigger, owner )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"hash_ae87b3cbac4ea2e8" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            waitframe();
        }
    }

#/
