// scripts\mp\electric_power_switch.gsc  (hash_13b844d6e9da8cd6.gscc) (size: 5988 Bytes / 0x1764 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x593151c0 (1496404416)
// size ...... 5988 (0x1764)
// includes .. 6   (offset: 0x1630)
// strings ... 12  (offset: 0x1660)
// dev strs .. 7   (offset: 0x1710)
// exports ... 19  (offset: 0xde4)
// cseg ...... 0x187 + 0xc5d (0xde4)
// imports ... 46  (offset: 0x10dc)
// animtree1 . 0   (offset: 0x1764)
// animtree2 . 0   (offset: 0x1764)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\content_manager;
#using scripts\mp\doorbuy;
#using scripts\mp\interaction;

#namespace electric_power_switch;

// Namespace electric_power_switch
// Params 0
// Checksum 0x736f8acc, Offset: 0x1a5
// Size: 0xa
function init_electric_power_switch()
{
    level thread _init_electric_power_switch();
}

// Namespace electric_power_switch
// Params 0, eflags: 0x4
// Checksum 0xf700fb8e, Offset: 0x1b7
// Size: 0x9a
function private _init_electric_power_switch()
{
    content_manager::function_3209da123476142f( "electric_power_switch", &on_spawn_power );
    level.electric_power_switches = [];
    utility::flag_init( "electric_power_switch_init_complete" );
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    
    if ( isdefined( var_959dbddcfff2592d ) && var_959dbddcfff2592d.size > 0 )
    {
        level.var_84ff4b746ce65cd4 = function_5e0adddca3ff112e( var_959dbddcfff2592d[ 0 ] );
        level thread function_605a8d53c17ec2fa( var_959dbddcfff2592d[ 0 ] );
    }
    else
    {
        return;
    }
    
    if ( level.var_84ff4b746ce65cd4 == 0 )
    {
        utility::flag_set( "electric_power_switch_init_complete" );
    }
    
    /#
        level thread setup_electric_power_switch_devgui();
    #/
}

// Namespace electric_power_switch
// Params 1, eflags: 0x4
// Checksum 0x6cfbfa3b, Offset: 0x259
// Size: 0x147
function private function_5e0adddca3ff112e( destination )
{
    count = 0;
    
    foreach ( location in destination.locations )
    {
        var_3adc81ea20cc8649 = location.instances[ "electric_power_switch" ];
        
        if ( isdefined( var_3adc81ea20cc8649 ) )
        {
            foreach ( instance in var_3adc81ea20cc8649.versions )
            {
                var_6ef5bb7453229b53 = instance.var_1d6cddfc47031bff[ "elec_switch_trigger" ];
                
                if ( isarray( var_6ef5bb7453229b53 ) )
                {
                    count += var_6ef5bb7453229b53.size;
                }
            }
        }
    }
    
    return count;
}

// Namespace electric_power_switch
// Params 0
// Checksum 0x8c4b5073, Offset: 0x3a9
// Size: 0x1c
function function_dec0a4e06ef0b6b2()
{
    if ( !isdefined( level.electric_power_switches ) )
    {
        return 0;
    }
    
    return level.electric_power_switches.size;
}

// Namespace electric_power_switch
// Params 1
// Checksum 0x34aa77d1, Offset: 0x3ce
// Size: 0x118
function function_605a8d53c17ec2fa( destination )
{
    foreach ( location in destination.locations )
    {
        var_3adc81ea20cc8649 = location.instances[ "electric_power_switch" ];
        
        if ( isdefined( var_3adc81ea20cc8649 ) )
        {
            foreach ( instance in var_3adc81ea20cc8649.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace electric_power_switch
// Params 1, eflags: 0x4
// Checksum 0x245a48b1, Offset: 0x4ee
// Size: 0x1f
function private on_spawn_power( instance )
{
    instance spawn_switches();
    instance set_lights_state( 0 );
}

/#

    // Namespace electric_power_switch
    // Params 0
    // Checksum 0xc3583053, Offset: 0x515
    // Size: 0x44, Type: dev
    function setup_electric_power_switch_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x4c>", &debug_turn_on_power );
        devgui::add_devgui_func( "<dev string:x60>", "<dev string:x6f>", &function_e2b601cd18848cd1 );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace electric_power_switch
// Params 0
// Checksum 0x8b771c4, Offset: 0x561
// Size: 0xb
function debug_turn_on_power()
{
    function_2d462dbfcc76b0db( 1 );
}

// Namespace electric_power_switch
// Params 0
// Checksum 0xd53b7869, Offset: 0x574
// Size: 0xa
function function_e2b601cd18848cd1()
{
    function_2d462dbfcc76b0db( 0 );
}

// Namespace electric_power_switch
// Params 1
// Checksum 0x21857b0c, Offset: 0x586
// Size: 0x142
function function_2d462dbfcc76b0db( state )
{
    var_6ef5bb7453229b53 = utility::getstructarray( "elec_switch_trigger", "targetname" );
    
    if ( isarray( var_6ef5bb7453229b53 ) )
    {
        foreach ( var_9141af98d93fd67c in var_6ef5bb7453229b53 )
        {
            if ( !isdefined( var_9141af98d93fd67c.interact ) )
            {
                continue;
            }
            
            if ( var_9141af98d93fd67c.interact.b_power_on && state )
            {
                continue;
            }
            
            if ( !var_9141af98d93fd67c.interact.b_power_on && !state )
            {
                continue;
            }
            
            if ( !isdefined( var_9141af98d93fd67c.script_use_once ) || var_9141af98d93fd67c.script_use_once )
            {
                iprintlnbold( "POWER CAN ONLY TURN ON ONCE. But we are forcing to turn now!" );
                var_9141af98d93fd67c.script_use_once = 0;
            }
            
            var_9141af98d93fd67c.interact function_e17b8c37ab7db9f2( level.players[ 0 ] );
        }
    }
}

// Namespace electric_power_switch
// Params 0, eflags: 0x4
// Checksum 0x98b63754, Offset: 0x6d0
// Size: 0x96
function private spawn_switches()
{
    var_6ef5bb7453229b53 = self.var_1d6cddfc47031bff[ "elec_switch_trigger" ];
    
    if ( isarray( var_6ef5bb7453229b53 ) )
    {
        foreach ( var_9141af98d93fd67c in var_6ef5bb7453229b53 )
        {
            var_9141af98d93fd67c thread spawn_electric_switch();
        }
    }
}

// Namespace electric_power_switch
// Params 0, eflags: 0x4
// Checksum 0x848d8c80, Offset: 0x76e
// Size: 0xf1
function private spawn_electric_switch()
{
    self.interact = interaction::register_interact( self.origin, self.radius, &function_e17b8c37ab7db9f2, &"SHARED_HINTSTRINGS/ELECTRIC_SWITCH_OFF_HINT" );
    self.interact.struct = self;
    var_ba0fb417fd6f6a49 = utility::getstruct( self.target2, "targetname" );
    switch_model = var_ba0fb417fd6f6a49.script_noteworthy ?? "t10_zm_power_switch_handle";
    self.model_switch = content_manager::spawn_script_model( var_ba0fb417fd6f6a49, switch_model, 1, 1 );
    level.electric_power_switches[ level.electric_power_switches.size ] = self;
    
    if ( level.var_84ff4b746ce65cd4 > 0 )
    {
        level.var_84ff4b746ce65cd4--;
        
        if ( level.var_84ff4b746ce65cd4 == 0 )
        {
            utility::flag_set( "electric_power_switch_init_complete" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x84>" );
}

// Namespace electric_power_switch
// Params 1
// Checksum 0xea2f27bf, Offset: 0x867
// Size: 0xae
function function_e17b8c37ab7db9f2( player )
{
    b_use_once = 1;
    
    if ( isdefined( self.struct.script_use_once ) )
    {
        b_use_once = self.struct.script_use_once;
    }
    
    if ( self.struct.var_f0957ca9999a3ac3 )
    {
        level notify( #"hash_79599f9044df4715", player );
        return;
    }
    
    if ( !self.b_power_on )
    {
        turn_power_on( b_use_once );
        
        if ( isdefined( self ) )
        {
            self.b_power_on = 1;
        }
        
        return;
    }
    
    if ( !b_use_once )
    {
        turn_power_off();
        
        if ( isdefined( self ) )
        {
            self.b_power_on = 0;
        }
    }
}

// Namespace electric_power_switch
// Params 1, eflags: 0x4
// Checksum 0xbd986bc9, Offset: 0x91d
// Size: 0xbb
function private turn_power_on( use_once )
{
    var_41a7b79236ee0d86 = self.struct.script_noteworthy;
    var_bb3cfcbf65750e32 = self.struct.script_flag_set;
    
    if ( !isdefined( var_41a7b79236ee0d86 ) )
    {
        level utility::flag_set( var_bb3cfcbf65750e32 );
    }
    else
    {
        var_bb3cfcbf65750e32 += var_41a7b79236ee0d86;
        level utility::flag_set( var_bb3cfcbf65750e32 );
    }
    
    set_power_items( 1, var_41a7b79236ee0d86 );
    thread set_switch_state( 1, use_once );
    params = spawnstruct();
    params.on = 1;
    params.flag = var_bb3cfcbf65750e32;
    level callback::callback( "power_switch_state_changed", params );
}

// Namespace electric_power_switch
// Params 0, eflags: 0x4
// Checksum 0x835112d8, Offset: 0x9e0
// Size: 0xac
function private turn_power_off()
{
    var_41a7b79236ee0d86 = self.struct.script_noteworthy;
    var_bb3cfcbf65750e32 = self.struct.script_flag_set;
    
    if ( !isdefined( var_41a7b79236ee0d86 ) )
    {
        level utility::flag_clear( var_bb3cfcbf65750e32 );
    }
    else
    {
        var_bb3cfcbf65750e32 += var_41a7b79236ee0d86;
        level utility::flag_clear( var_bb3cfcbf65750e32 );
    }
    
    set_power_items( 0, var_41a7b79236ee0d86 );
    thread set_switch_state( 0 );
    params = spawnstruct();
    params.on = 0;
    params.flag = var_bb3cfcbf65750e32;
    level callback::callback( "power_switch_state_changed", params );
}

// Namespace electric_power_switch
// Params 2
// Checksum 0xbc09b5fb, Offset: 0xa94
// Size: 0x229
function set_switch_state( state, use_once )
{
    /#
        if ( !isdefined( self.struct.model_switch ) )
        {
            return;
        }
    #/
    
    off_rotation = self.struct.switch_bounds.off ?? 30;
    on_rotation = self.struct.switch_bounds.on ?? -90;
    var_2d10abea2d2e97e4 = self.struct.var_2d10abea2d2e97e4 ?? 2;
    model_switch = self.struct.model_switch;
    
    if ( var_2d10abea2d2e97e4 == 2 )
    {
        model_angles = ( model_switch.angles[ 0 ], model_switch.angles[ 1 ], off_rotation );
        
        if ( state )
        {
            model_angles = ( model_switch.angles[ 0 ], model_switch.angles[ 1 ], on_rotation );
        }
    }
    else if ( var_2d10abea2d2e97e4 == 1 )
    {
        model_angles = ( model_switch.angles[ 0 ], off_rotation, model_switch.angles[ 2 ] );
        
        if ( state )
        {
            model_angles = ( model_switch.angles[ 0 ], on_rotation, model_switch.angles[ 2 ] );
        }
    }
    else if ( var_2d10abea2d2e97e4 == 0 )
    {
        model_angles = ( off_rotation, model_switch.angles[ 1 ], model_switch.angles[ 2 ] );
        
        if ( state )
        {
            model_angles = ( on_rotation, model_switch.angles[ 1 ], model_switch.angles[ 2 ] );
        }
    }
    else
    {
        assertmsg( "<dev string:xd0>" );
        return;
    }
    
    model_switch rotateto( model_angles, 0.5 );
    
    if ( use_once )
    {
        self makeunusable();
        model_switch utility::function_7c10ea82c1e305b8( "base", "hide" );
        return;
    }
    
    self makeusable();
    
    if ( state )
    {
        self sethintstring( &"SHARED_HINTSTRINGS/ELECTRIC_SWITCH_ON_HINT" );
        return;
    }
    
    self sethintstring( &"SHARED_HINTSTRINGS/ELECTRIC_SWITCH_OFF_HINT" );
}

// Namespace electric_power_switch
// Params 2
// Checksum 0x84368676, Offset: 0xcc5
// Size: 0x2b
function set_power_items( state, var_41a7b79236ee0d86 )
{
    level thread doorbuy::function_f036c23977df35fc( state, var_41a7b79236ee0d86 );
    level thread set_lights_state( state, var_41a7b79236ee0d86 );
}

// Namespace electric_power_switch
// Params 2
// Checksum 0xfa55f556, Offset: 0xcf8
// Size: 0xec
function set_lights_state( state, var_41a7b79236ee0d86 )
{
    lights = getentarray( "electric_power_light", #targetname );
    b_global_power = !isdefined( var_41a7b79236ee0d86 );
    
    foreach ( light in lights )
    {
        var_a507e285448e8204 = light.script_noteworthy == var_41a7b79236ee0d86;
        
        if ( !var_a507e285448e8204 && !b_global_power )
        {
            continue;
        }
        
        intensity = 0;
        
        if ( state )
        {
            intensity = 1;
        }
        
        light setlightintensity( intensity );
    }
}

