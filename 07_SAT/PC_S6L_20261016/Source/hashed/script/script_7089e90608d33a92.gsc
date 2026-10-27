// script_7089e90608d33a92  (hash_7089e90608d33a92.gscc) (size: 4334 Bytes / 0x10ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bf8bb46 (2616769350)
// size ...... 4334 (0x10ee)
// includes .. 8   (offset: 0xf96)
// strings ... 16  (offset: 0xfd6)
// dev strs .. 0   (offset: 0x10be)
// exports ... 10  (offset: 0x95e)
// cseg ...... 0x215 + 0x749 (0x95e)
// imports ... 41  (offset: 0xaee)
// animtree1 . 0   (offset: 0x10be)
// animtree2 . 3   (offset: 0x10be)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_356f861e48353864;

// Namespace namespace_356f861e48353864
// Params 0, eflags: 0x5
// Checksum 0xf008e4db, Offset: 0x233
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c9dc118f42a1587b", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_356f861e48353864
// Params 0
// Checksum 0x597c30a9, Offset: 0x25c
// Size: 0x62
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"logdrop", #"create", &function_89f0d9a5a07b89db );
    ztron_hazard::function_6f661fac5fd31f1( #"logdrop", #"arenaspawn", &function_b50bfc7b1f496b79 );
    ztron_sound::function_4ac735395b173fe( "ztron_traps_blade_lp", "zmb_traps_blade_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_hazard_pungi_spike_impact", "evt_ztron_hazard_pungi_spike_impact" );
}

// Namespace namespace_356f861e48353864
// Params 0
// Checksum 0x4e050378, Offset: 0x2c6
// Size: 0xb1
function function_b50bfc7b1f496b79()
{
    level.ztron.var_2a0ca30205a23a25 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "logdrop" );
    
    foreach ( trap in traps )
    {
        function_89f0d9a5a07b89db( trap );
    }
}

// Namespace namespace_356f861e48353864
// Params 2
// Checksum 0xbab3dec6, Offset: 0x37f
// Size: 0x59
function function_89f0d9a5a07b89db( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_2a0ca30205a23a25[ level.ztron.var_2a0ca30205a23a25.size ] = trap;
        return;
    }
    
    function_817e27d0671e0984( trap );
}

// Namespace namespace_356f861e48353864
// Params 2
// Checksum 0x9ce70c10, Offset: 0x3e0
// Size: 0x7e
function function_817e27d0671e0984( trap, paged = 0 )
{
    trap.script_model = utility::spawn_model( "sat_zm_trap_blade_fxanim", trap.origin, trap.angles );
    trap.script_model.hazardtype = "logdrop";
    trap.paged = paged;
    trap thread function_5aee8d16577090e9();
    return trap;
}

#using_animtree( "script_model" );

// Namespace namespace_356f861e48353864
// Params 0
// Checksum 0xd72292b9, Offset: 0x467
// Size: 0x1c7
function function_5aee8d16577090e9()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_35df174831788817();
    self.state = 0;
    length_intro = getanimlength( %sat_fxanim_zm_towers_trap_blade_01_start );
    length_loop = getanimlength( %sat_fxanim_zm_towers_trap_blade_01_loop );
    length_end = getanimlength( %sat_fxanim_zm_towers_trap_blade_01_end );
    
    while ( true )
    {
        if ( self.trigger )
        {
            self.trigger hide();
        }
        
        self.script_model stopanimscripted();
        self.state = 0;
        wait 8 + randomint( 5 );
        self.script_model scriptmodelplayanim( "sat_fxanim_zm_towers_trap_blade_01_start" );
        self.script_model utility::waittill_any_timeout( length_intro, "end", "scriptedanim", "new_scripted_anim" );
        self.state = 1;
        loops = randomintrange( 5, 15 );
        thread function_45eda3d6ac607568( loops * length_loop );
        
        while ( loops )
        {
            self.script_model scriptmodelplayanim( "sat_fxanim_zm_towers_trap_blade_01_loop" );
            ztron_sound::ztron_playsound( "ztron_traps_blade_lp", undefined, self.script_model );
            self.script_model utility::waittill_any_timeout( length_loop, "end", "scriptedanim", "new_scripted_anim" );
            loops--;
        }
        
        self notify( #"hash_ae87b3cbac4ea2e8" );
        self.state = 0;
        ztron_sound::ztron_playsound( "ztron_traps_blade_lp", undefined, self.script_model );
        self.script_model scriptmodelplayanim( "sat_fxanim_zm_towers_trap_blade_01_end" );
        self.script_model utility::waittill_any_timeout( length_end, "end", "scriptedanim", "new_scripted_anim" );
    }
}

// Namespace namespace_356f861e48353864
// Params 2
// Checksum 0x36c6dc1c, Offset: 0x636
// Size: 0x228
function function_45eda3d6ac607568( movetime, lifetime )
{
    self endon( #"destroy_hazard" );
    self endon( #"hash_ae87b3cbac4ea2e8" );
    
    while ( self.state === 1 )
    {
        if ( !self.trigger )
        {
            self.trigger = spawn( "trigger_box", self.origin + anglestoup( self.angles ) * 50, undefined, ( 16, 32, 32 ), ( 16, 32, 32 ) );
            self.trigger.angles = self.angles;
            self.trigger.owner = self;
            continue;
        }
        
        /#
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                thread function_ea62240d39c1a11( self.trigger );
            }
        #/
        
        self.trigger show();
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

// Namespace namespace_356f861e48353864
// Params 0
// Checksum 0x1e66d04a, Offset: 0x866
// Size: 0x92
function function_35df174831788817()
{
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( self.paged )
    {
        arrayremove( level.ztron.var_2a0ca30205a23a25, self );
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

    // Namespace namespace_356f861e48353864
    // Params 2, eflags: 0x4
    // Checksum 0x7628b5e3, Offset: 0x900
    // Size: 0x5e, Type: dev
    function private function_ea62240d39c1a11( trigger, owner )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"hash_ae87b3cbac4ea2e8" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            waitframe();
        }
    }

#/
