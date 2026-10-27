// script_4eb10b8076cd40c  (hash_04eb10b8076cd40c.gscc) (size: 6468 Bytes / 0x1944 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc931675f (3375458143)
// size ...... 6468 (0x1944)
// includes .. 9   (offset: 0x1854)
// strings ... 12  (offset: 0x189c)
// dev strs .. 0   (offset: 0x1944)
// exports ... 35  (offset: 0xe44)
// cseg ...... 0x10c + 0xd38 (0xe44)
// imports ... 41  (offset: 0x13bc)
// animtree1 . 0   (offset: 0x1944)
// animtree2 . 0   (offset: 0x1944)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai\smartobjects\utility;
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\ai\stealth\event;
#using scripts\common\ai\stealth\friendly;
#using scripts\common\ai\stealth\neutral;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;

#namespace stealth;

// Namespace stealth
// Params 0
// Checksum 0xa021db4a, Offset: 0x12a
// Size: 0x8e
function initstealthfunctions()
{
    self.fnsetstealthstate = &scrsetstealthstate;
    self.fnisinstealthidle = &isidle;
    self.fnisinstealthinvestigate = &isinvestigating;
    self.fnisinstealthhunt = &ishunting;
    self.fnisinstealthcombat = &iscombating;
    self.fnisinstealthidlescriptedanim = &isidlescriptedanim;
    self.fnstealthupdatevisionforlighting = &updatevisionforlighting;
    self.fnstealthisidlecurious = &isidlecurious;
    self.fnclearstealthvolume = &clearstealthvolume;
    self.var_d52986426f8538e6 = &function_3980c8cb1378f68;
}

// Namespace stealth
// Params 0
// Checksum 0xf6fe688c, Offset: 0x1c0
// Size: 0x32, Type: bool
function isidlescriptedanim()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 0 && self._blackboard.idlenodeisvalid;
}

// Namespace stealth
// Params 0
// Checksum 0x73309eb9, Offset: 0x1fb
// Size: 0x1b, Type: bool
function isidle()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 0;
}

// Namespace stealth
// Params 0
// Checksum 0xebb9ccc8, Offset: 0x21f
// Size: 0x1c, Type: bool
function isinvestigating()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 1;
}

// Namespace stealth
// Params 0
// Checksum 0x3e9817e3, Offset: 0x244
// Size: 0x1c, Type: bool
function ishunting()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 2;
}

// Namespace stealth
// Params 0
// Checksum 0xbc51b662, Offset: 0x269
// Size: 0x1c, Type: bool
function iscombating()
{
    return isdefined( self.stealth ) && self.stealth_bsmstate == 3;
}

// Namespace stealth
// Params 1
// Checksum 0x8685ff8c, Offset: 0x28e
// Size: 0x1c
function stealth_initfriendly( taskid )
{
    friendly::main();
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0x2a7d55f, Offset: 0x2b3
// Size: 0x20
function stealth_terminatefriendly( taskid )
{
    self.stealth = undefined;
    self.stealth_enabled = 0;
}

// Namespace stealth
// Params 1
// Checksum 0x562e24f9, Offset: 0x2db
// Size: 0x1c
function stealth_initneutral( taskid )
{
    neutral::main();
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0xe45a6fa6, Offset: 0x300
// Size: 0x26, Type: bool
function isinlight( lightvalue )
{
    if ( !isdefined( lightvalue ) )
    {
        return !level.is_dark;
    }
    
    return lightvalue >= 0.5;
}

// Namespace stealth
// Params 0
// Checksum 0x71d83fda, Offset: 0x32f
// Size: 0x2
function updatevisionforlighting()
{
    
}

// Namespace stealth
// Params 0
// Checksum 0xcc77f9f7, Offset: 0x339
// Size: 0x12f
function forceflashlightplayercanseeifnecessary()
{
    if ( self.flashlight )
    {
        var_99fd02cbdd7551fa = 0.1;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.nvg ) && player.nvg.lightmeter > var_99fd02cbdd7551fa && isdefined( player.nvg.prevlightmeter ) && player.nvg.lightmeter - player.nvg.prevlightmeter > 0.01 )
            {
                if ( self aipointinfov( player.origin ) && !self cansee( player ) )
                {
                    self cansee( player, 0 );
                }
            }
        }
    }
}

// Namespace stealth
// Params 1
// Checksum 0x7662b9c, Offset: 0x470
// Size: 0xc1
function function_ab851521b1a6db4( taskid )
{
    shouldupdatelightmeter = utility::ent_flag_exist( "react_to_dynolights" ) && utility::ent_flag( "react_to_dynolights" );
    
    if ( shouldupdatelightmeter && !isdefined( self.lightmeter ) )
    {
        utility::update_light_meter();
        shouldupdatelightmeter = 0;
    }
    
    updatelightbasedflashlight( self.stealth_bsmstate, 0.5 );
    
    if ( shouldupdatelightmeter )
    {
        entnum = self getentitynumber();
        frametime = level.frameduration;
        assert( isdefined( frametime ) );
        
        if ( gettime() / frametime % 5 == entnum % 5 )
        {
            utility::update_light_meter();
        }
    }
    
    forceflashlightplayercanseeifnecessary();
    return anim.success;
}

// Namespace stealth
// Params 0
// Checksum 0xc9c027e, Offset: 0x53a
// Size: 0x36
function function_335632da6b2501b3()
{
    if ( !self isinscriptedstate() )
    {
        if ( self.var_ea2c66a2a4a218b0 )
        {
            self.gunposeoverride_internal = "gun_down";
            return;
        }
        
        self.gunposeoverride_internal = "ready";
    }
}

// Namespace stealth
// Params 2
// Checksum 0x670226fc, Offset: 0x578
// Size: 0x210
function updatelightbasedflashlight( state, var_cd4803c3e9f0630d )
{
    if ( self isinscriptedstate() )
    {
        return;
    }
    
    if ( gettime() == self.starttime )
    {
        return;
    }
    
    lightmeter = self.lightmeter;
    
    /#
        if ( getdvarint( @"hash_7cbaa1208f238b77", 0 ) )
        {
            lightmeter = 0;
        }
    #/
    
    if ( isdefined( self._blackboard.bflashlight ) )
    {
        var_d0d064abaf2c2b53 = self._blackboard.bflashlight;
    }
    else
    {
        var_d0d064abaf2c2b53 = 0;
    }
    
    if ( isdefined( self.flashlightoverride ) )
    {
        self._blackboard.bflashlight = self.flashlightoverride;
    }
    else if ( self.noflashlight )
    {
        self._blackboard.bflashlight = 0;
    }
    else if ( isdefined( lightmeter ) )
    {
        var_cfdff92731186f3c = 0.1;
        
        if ( self._blackboard.bflashlight )
        {
            if ( lightmeter > var_cd4803c3e9f0630d + var_cfdff92731186f3c )
            {
                self._blackboard.bflashlight = 0;
            }
        }
        else
        {
            self._blackboard.bflashlight = lightmeter < var_cd4803c3e9f0630d;
        }
    }
    else if ( level.is_dark )
    {
        self._blackboard.bflashlight = 1;
    }
    else
    {
        self._blackboard.bflashlight = 0;
    }
    
    if ( var_d0d064abaf2c2b53 != self._blackboard.bflashlight )
    {
        if ( asm::asm_getdemeanor() != "patrol" && !self.asmflashlight )
        {
            assert( isdefined( self.fnstealthflashlighton ) && isdefined( self.fnstealthflashlightoff ) );
            
            if ( self._blackboard.bflashlight )
            {
                self [[ self.fnstealthflashlighton ]]();
                return;
            }
            
            self [[ self.fnstealthflashlightoff ]]();
        }
    }
}

// Namespace stealth
// Params 0
// Checksum 0xab906a45, Offset: 0x790
// Size: 0xb
function isidlecurious()
{
    return self.stealthidlecurious;
}

// Namespace stealth
// Params 1
// Checksum 0x785b38c1, Offset: 0x7a4
// Size: 0xa1
function idle_init( taskid )
{
    self setlongdeathblocked( 1, "bt" );
    event::event_escalation_clear();
    
    if ( isdefined( self.stealth.funcs[ "hidden" ] ) )
    {
        callbacks::stealth_call_thread( "hidden" );
    }
    
    resumed_previous_goal = utility::resume_previous_goal();
    
    if ( !resumed_previous_goal && isdefined( self.target ) )
    {
        self.goalradius = 32;
        
        if ( isdefined( self.fnstealthgotonode ) )
        {
            self thread [[ self.fnstealthgotonode ]]( undefined, undefined, undefined, undefined );
        }
    }
    
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0xae97aa2a, Offset: 0x84e
// Size: 0x53
function idle_terminate( taskid )
{
    self notify( #"stop_going_to_node" );
    self setlongdeathblocked( 0, "bt" );
    utility::save_last_goal();
    self.last_set_goalnode = undefined;
    self.last_set_goalent = undefined;
    self.moveplaybackrate = 1;
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0x5b347b9d, Offset: 0x8aa
// Size: 0x5b
function hunt_custom_init( taskid )
{
    utility::set_patrol_style( "cqb" );
    
    if ( isdefined( self.stealth.funcs[ "hunt_custom_init" ] ) )
    {
        self thread [[ self.stealth.funcs[ "hunt_custom_init" ] ]]();
    }
    
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0xc93c703c, Offset: 0x90e
// Size: 0x93
function hunt_custom_update( taskid )
{
    if ( !self.Stealth_Hunt_IsCustom )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.stealth.funcs[ "hunt_custom_update" ] ) )
    {
        bresult = self [[ self.stealth.funcs[ "hunt_custom_update" ] ]]();
        
        if ( isdefined( bresult ) )
        {
            if ( bresult )
            {
                return anim.running;
            }
            else
            {
                return anim.failure;
            }
        }
    }
    
    return anim.running;
}

// Namespace stealth
// Params 1
// Checksum 0x80a6f38e, Offset: 0x9aa
// Size: 0x4f
function hunt_custom_terminate( taskid )
{
    if ( isdefined( self.stealth.funcs[ "hunt_custom_terminate" ] ) )
    {
        self thread [[ self.stealth.funcs[ "hunt_custom_terminate" ] ]]();
    }
    
    return anim.success;
}

// Namespace stealth
// Params 1
// Checksum 0x9279df54, Offset: 0xa02
// Size: 0x21
function hunt_active_terminate( taskid )
{
    utility::clearsmartobject( asm_bb::bb_getrequestedsmartobject() );
    self clearbtgoal( 3 );
}

// Namespace stealth
// Params 1
// Checksum 0x2a4d16e0, Offset: 0xa2b
// Size: 0x15
function function_8999d100efc720dd( taskid )
{
    return anim.failure;
}

// Namespace stealth
// Params 1
// Checksum 0xd71b3719, Offset: 0xa49
// Size: 0x15
function function_84e29b8ca80839d1( taskid )
{
    return anim.failure;
}

// Namespace stealth
// Params 1
// Checksum 0x2b702a8c, Offset: 0xa67
// Size: 0x15
function function_12f39c972e03a1c2( taskid )
{
    return anim.failure;
}

// Namespace stealth
// Params 1
// Checksum 0x5ce4692e, Offset: 0xa85
// Size: 0x15
function function_b97abf039b71eaa2( taskid )
{
    return anim.failure;
}

// Namespace stealth
// Params 1
// Checksum 0x1b4b00a3, Offset: 0xaa3
// Size: 0x11
function function_5a04d4d7ec0b2ecf( taskid )
{
    return "ReturnSuccess";
}

// Namespace stealth
// Params 1
// Checksum 0x23af980, Offset: 0xabd
// Size: 0x15
function function_3f6c8441336bf3a5( taskid )
{
    return anim.failure;
}

// Namespace stealth
// Params 1
// Checksum 0xf23bab27, Offset: 0xadb
// Size: 0xc
function function_79e71916e536a43e( taskid )
{
    
}

// Namespace stealth
// Params 0
// Checksum 0x5dc035f0, Offset: 0xaef
// Size: 0x20
function function_b054f03049b980bb()
{
    self.var_fb8a7aa17ec3708 = 0;
    self.var_51c18c65e845d655 = undefined;
    self.var_167039c96910edfa = undefined;
}

// Namespace stealth
// Params 0
// Checksum 0xc73f4e54, Offset: 0xb17
// Size: 0x60
function clearstealthvolume()
{
    if ( isdefined( level.stealth.combat_volumes[ self.script_stealthgroup ] ) && iscombating() || isdefined( level.stealth.hunt_volumes[ self.script_stealthgroup ] ) && ishunting() )
    {
        self clearbtgoal( 0 );
    }
}

// Namespace stealth
// Params 1
// Checksum 0x650aa35, Offset: 0xb7f
// Size: 0x113
function function_39be4d693b907f5c( event )
{
    assert( isdefined( event.typeorig ) );
    
    if ( isdefined( self.stealth ) && self.stealth_enabled )
    {
        self.stealth.investigateevent = event;
        self.var_e6969704da389ed1 = event.typeorig;
        self.var_41029b06299a2523 = event.entity;
        self.var_a7971d3c7cf8dba5 = event.receiver;
        self.var_5f2e4dbdcea0a9b0 = event.type;
        self.var_243af3aae47f2694 = 0;
        
        if ( isdefined( event.position ) )
        {
            self.var_feefceafd0a53d2b = event.position;
        }
        
        if ( isdefined( event.investigate_pos ) )
        {
            self.var_5438c8fb68e8c20e = event.investigate_pos;
        }
        
        if ( isdefined( event.look_pos ) )
        {
            self.var_9f01a7f92637a956 = event.look_pos;
        }
    }
}

// Namespace stealth
// Params 0
// Checksum 0xfab6159, Offset: 0xc9a
// Size: 0x14c
function function_3980c8cb1378f68()
{
    if ( !( isdefined( self.var_e6969704da389ed1 ) && isdefined( self.stealth.investigateevent ) ) )
    {
        return;
    }
    
    self.stealth.investigateevent.typeorig = self.var_e6969704da389ed1;
    self.stealth.investigateevent.position = self.var_feefceafd0a53d2b;
    self.stealth.investigateevent.entity = self.var_41029b06299a2523;
    self.stealth.investigateevent.receiver = self.var_a7971d3c7cf8dba5;
    self.stealth.investigateevent.type = self.var_5f2e4dbdcea0a9b0;
    self.stealth.investigateevent.investigate_pos = self.var_5438c8fb68e8c20e;
    self.stealth.investigateevent.look_pos = self.var_9f01a7f92637a956;
    return self.stealth.investigateevent;
}

// Namespace stealth
// Params 2
// Checksum 0x16243950, Offset: 0xdef
// Size: 0x55
function scrsetstealthstate( statename, e )
{
    if ( !utility::flag( "stealth_enabled" ) || !isdefined( self.stealth ) || !self.stealth_enabled )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self setstealthstate( statename, e );
}

