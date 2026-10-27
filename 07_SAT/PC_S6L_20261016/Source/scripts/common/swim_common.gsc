// scripts\common\swim_common.gsc  (hash_4b87f2871b6b025c.gscc) (size: 24352 Bytes / 0x5f20 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16c4758c (381973900)
// size ...... 24352 (0x5f20)
// includes .. 7   (offset: 0x5710)
// strings ... 75  (offset: 0x5748)
// dev strs .. 1   (offset: 0x5f14)
// exports ... 96  (offset: 0x37f0)
// cseg ...... 0x755 + 0x309b (0x37f0)
// imports ... 126 (offset: 0x46f0)
// animtree1 . 0   (offset: 0x5f20)
// animtree2 . 0   (offset: 0x5f20)
#using scripts\common\callbacks;
#using scripts\common\heartbeat;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;

#namespace swim_common;

// Namespace swim_common
// Params 0, eflags: 0x5
// Checksum 0x324c008c, Offset: 0x773
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"swim_common", #"val", &pre_main, undefined );
}

// Namespace swim_common
// Params 0, eflags: 0x4
// Checksum 0x89836538, Offset: 0x79c
// Size: 0x13
function private pre_main()
{
    val::register_on_set_handler( "swimming", &function_72bf9ef5283c708 );
}

// Namespace swim_common
// Params 12
// Checksum 0x1709b0e, Offset: 0x7b7
// Size: 0x1b4
function initcommonswim( var_87ca408e836d56cf, var_91e79c1e5d912497, var_96154933dff85312, enterfunc, exitfunc, surfacefunc, descendfunc, playsoundfunc, visionsetfunc, drownfunc, var_21022c7158b2a4b3, var_f10d7aeea25eb7ff )
{
    setdvarifuninitialized( @"hash_2a4f08bc79265550", 0 );
    level.swim = spawnstruct();
    level.swim.var_87ca408e836d56cf = var_87ca408e836d56cf;
    level.swim.var_91e79c1e5d912497 = var_91e79c1e5d912497;
    level.swim.var_96154933dff85312 = var_96154933dff85312;
    level.swim.enterfunc = enterfunc;
    level.swim.exitfunc = exitfunc;
    level.swim.surfacefunc = surfacefunc;
    level.swim.descendfunc = descendfunc;
    level.swim.playsoundfunc = playsoundfunc;
    level.swim.visionsetfunc = visionsetfunc;
    level.swim.drownfunc = drownfunc;
    level.swim.var_3869cac93d7db6df = var_21022c7158b2a4b3;
    level.swim.var_f10d7aeea25eb7ff = var_f10d7aeea25eb7ff;
    level.swim.sfx = function_ed96c9cfaa5c69cb();
    function_a4f8facf751a8de0();
}

// Namespace swim_common
// Params 0
// Checksum 0x355e13bd, Offset: 0x973
// Size: 0xb54
function function_ed96c9cfaa5c69cb()
{
    sfx = spawnstruct();
    sfx buildaliasarray( [ "sfx", "surface", "slow", "quiet", "plr" ], "mvmt_swim_surfacing_plr_slow" );
    sfx buildaliasarray( [ "sfx", "surface", "slow", "quiet", "npc" ], "mvmt_swim_surfacing_npc_slow" );
    sfx buildaliasarray( [ "sfx", "surface", "slow", "breath", "plr" ], "mvmt_swim_surfacing_plr_slow_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "slow", "breath", "npc" ], "mvmt_swim_surfacing_npc_slow_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "slow", "gasp", "plr" ], "mvmt_swim_surfacing_plr_slow_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "slow", "gasp", "npc" ], "mvmt_swim_surfacing_npc_slow_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "quiet", "plr" ], "mvmt_swim_surfacing_plr_sprint" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "quiet", "npc" ], "mvmt_swim_surfacing_npc_sprint" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "breath", "plr" ], "mvmt_swim_surfacing_plr_sprint_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "breath", "npc" ], "mvmt_swim_surfacing_npc_sprint_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "gasp", "plr" ], "mvmt_swim_surfacing_plr_sprint_gasping" );
    sfx buildaliasarray( [ "sfx", "surface", "fast", "gasp", "npc" ], "mvmt_swim_surfacing_npc_sprint_gasping" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "quiet", "plr" ], "mvmt_swim_plunging_plr_slow" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "quiet", "npc" ], "mvmt_swim_plunging_npc_slow" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "breath", "plr" ], "mvmt_swim_plunging_plr_slow_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "breath", "npc" ], "mvmt_swim_plunging_npc_slow_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "gasp", "plr" ], "mvmt_swim_plunging_plr_slow_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "slow", "gasp", "npc" ], "mvmt_swim_plunging_npc_slow_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "quiet", "plr" ], "mvmt_swim_plunging_plr_sprint" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "quiet", "npc" ], "mvmt_swim_plunging_npc_sprint" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "breath", "plr" ], "mvmt_swim_plunging_plr_sprint_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "breath", "npc" ], "mvmt_swim_plunging_npc_sprint_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "gasp", "plr" ], "mvmt_swim_plunging_plr_sprint_inhaling" );
    sfx buildaliasarray( [ "sfx", "descend", "fast", "gasp", "npc" ], "mvmt_swim_plunging_npc_sprint_inhaling" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "quiet", "plr" ], "plr_breath_swim_surface_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "quiet", "npc" ], "npc_breath_swim_surface_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "breath", "plr" ], "plr_breath_swim_surface_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "breath", "npc" ], "npc_breath_swim_surface_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "gasp", "plr" ], "plr_breath_swim_surface_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "slow", "gasp", "npc" ], "npc_breath_swim_surface_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "quiet", "plr" ], "plr_breath_swim_surface_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "quiet", "npc" ], "npc_breath_swim_surface_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "breath", "plr" ], "plr_breath_swim_surface_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "breath", "npc" ], "npc_breath_swim_surface_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "gasp", "plr" ], "plr_breath_swim_surface_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "surface", "fast", "gasp", "npc" ], "npc_breath_swim_surface_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "quiet", "plr" ], "plr_breath_swim_descend_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "quiet", "npc" ], "npc_breath_swim_descend_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "breath", "plr" ], "plr_breath_swim_descend_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "breath", "npc" ], "npc_breath_swim_descend_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "gasp", "plr" ], "plr_breath_swim_descend_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "slow", "gasp", "npc" ], "npc_breath_swim_descend_gasp_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "quiet", "plr" ], "plr_breath_swim_descend_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "quiet", "npc" ], "npc_breath_swim_descend_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "breath", "plr" ], "plr_breath_swim_descend_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "breath", "npc" ], "npc_breath_swim_descend_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "gasp", "plr" ], "plr_breath_swim_descend_gasp_sprint_inh" );
    sfx buildaliasarray( [ "dlg", "descend", "fast", "gasp", "npc" ], "npc_breath_swim_descend_gasp_sprint_inh" );
    return sfx;
}

// Namespace swim_common
// Params 0
// Checksum 0xcca10c86, Offset: 0x14d0
// Size: 0x77
function function_a4f8facf751a8de0()
{
    level._effect[ "swim_bubbles_light" ] = loadfxasset( level.gamemodebundle.var_168e06ec94653a5a );
    level._effect[ "swim_gasp_bubbles" ] = loadfxasset( level.gamemodebundle.var_57e6abeabae3d168 );
    level._effect[ "swim_drowning_bubbles" ] = loadfxasset( level.gamemodebundle.var_b7af1ab819d37e39 );
}

// Namespace swim_common
// Params 2
// Checksum 0xf8457236, Offset: 0x154f
// Size: 0x77
function buildaliasarray( keys, sfx )
{
    i = 0;
    currentstruct = self;
    
    while ( true )
    {
        if ( keys.size > i + 1 )
        {
            currentstruct function_4f8e8e236aa2d8cb( keys[ i ] );
        }
        else
        {
            currentstruct function_9461342671d97418( keys[ i ], sfx );
            break;
        }
        
        currentstruct = currentstruct.array[ keys[ i ] ];
        i++;
    }
}

// Namespace swim_common
// Params 1
// Checksum 0xdb3d27ec, Offset: 0x15ce
// Size: 0xce
function function_a372953c9b6fd183( keys )
{
    currentstruct = level.swim.sfx;
    i = 0;
    
    foreach ( key in keys )
    {
        if ( keys.size > i + 1 )
        {
            currentstruct = currentstruct.array[ key ];
        }
        else
        {
            return currentstruct.array[ key ];
        }
        
        i++;
    }
}

// Namespace swim_common
// Params 1
// Checksum 0x5a352ab2, Offset: 0x16a4
// Size: 0x42
function function_4f8e8e236aa2d8cb( key )
{
    if ( !isdefined( self.array ) )
    {
        self.array = [];
    }
    
    if ( !isdefined( self.array[ key ] ) )
    {
        self.array[ key ] = spawnstruct();
    }
}

// Namespace swim_common
// Params 2
// Checksum 0xa7c4ed57, Offset: 0x16ee
// Size: 0x48
function function_9461342671d97418( key, sfx )
{
    if ( !isdefined( self.array ) )
    {
        self.array = [];
    }
    
    if ( !isdefined( self.array[ key ] ) )
    {
        self.array[ key ] = sfx;
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x8e59a165, Offset: 0x173e
// Size: 0xd0
function function_5f2e885971e27d50()
{
    if ( isdefined( self.swim ) )
    {
        return;
    }
    
    self.swim = { #sfxstate:"none", #heartbeat:0, #sprinting:0, #drowning:0, #breathcritical:0, #swimming:0, #underwater:0, #breath:100 };
    createswimoverlay();
    thread function_d0ab97dd384c0600();
    thread swimcleanup();
    self endon( #"death", #"disconnect", #"showing_final_killcam", #"showing_potg", #"started_spawnplayer" );
    function_8bc658615151fc11();
    childthread function_54abfe78c75d3b80();
    childthread function_1cd729be2c6c72c5();
    childthread function_e5f749436761b7b5();
}

// Namespace swim_common
// Params 0
// Checksum 0x90fea65e, Offset: 0x1816
// Size: 0x2a
function function_54abfe78c75d3b80()
{
    while ( true )
    {
        utility::waittill_any( #"swim_breathing_disabled_end", #"swim_breathing_disabled_begin" );
        function_8bc658615151fc11();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x95200721, Offset: 0x1848
// Size: 0xb6
function function_8bc658615151fc11()
{
    var_4b961d311f22902d = [[ level.swim.var_3869cac93d7db6df ]]();
    
    if ( var_4b961d311f22902d )
    {
        function_6c0a071348a7629b();
    }
    else if ( self isswimming() )
    {
        sfx_swim_surface();
    }
    else
    {
        function_7ca78e7cdfd38015( 1.5 );
    }
    
    if ( var_4b961d311f22902d )
    {
        if ( !self.swim.underwater )
        {
            childthread function_51208b2efbedb7b3();
        }
    }
    else if ( self.swim.underwater )
    {
        childthread function_1fcc272380ba6e7b();
    }
    
    omnvar_utility::function_58bd31d56367a73d( o"swim_under_water", self.swim.underwater );
}

// Namespace swim_common
// Params 0
// Checksum 0x9f4509aa, Offset: 0x1906
// Size: 0x43
function function_1cd729be2c6c72c5()
{
    while ( true )
    {
        utility::waittill_any( #"swim_begin", #"swim_end", #"vehicle_enter", #"vehicle_exit" );
        function_6bdb1756a49fb143();
        function_8bc658615151fc11();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x5f079d56, Offset: 0x1951
// Size: 0x52
function function_6bdb1756a49fb143()
{
    if ( function_cba2881b5e36d851() && !self.swim.swimming )
    {
        childthread playerswimming();
    }
    
    if ( !function_cba2881b5e36d851() && self.swim.swimming )
    {
        childthread function_1d34a8e960ba182d();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x40db367, Offset: 0x19ab
// Size: 0x7
function function_cba2881b5e36d851()
{
    return self isswimming();
}

// Namespace swim_common
// Params 0
// Checksum 0xf585cacd, Offset: 0x19bb
// Size: 0x2a
function function_e5f749436761b7b5()
{
    while ( true )
    {
        utility::waittill_any( #"swim_sprint_begin", #"swim_sprint_end" );
        function_a640fd8ea8074213();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x9ff5de9b, Offset: 0x19ed
// Size: 0x96
function function_a640fd8ea8074213()
{
    if ( self isswimsprinting() )
    {
        if ( !self.swim.sprinting )
        {
            self.swim.sprinting = 1;
            
            if ( self isswimunderwater() )
            {
                self setclientomnvar( o"swim_breath_meter_sprint", 1 );
            }
        }
        
        return;
    }
    
    if ( self.swim.sprinting )
    {
        self.swim.sprinting = 0;
        
        if ( self isswimunderwater() )
        {
            self setclientomnvar( o"swim_breath_meter_sprint", 0 );
        }
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x7648e078, Offset: 0x1a8b
// Size: 0x58
function function_d0ab97dd384c0600()
{
    hudelm = self.swim.swimoverlay;
    utility::waittill_any( #"death_or_disconnect", #"showing_final_killcam", #"showing_potg", #"started_spawnplayer" );
    
    if ( hudelm )
    {
        hudelm destroy();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xd1f5de1, Offset: 0x1aeb
// Size: 0x40
function swimcleanup()
{
    self endon( #"disconnect" );
    utility::waittill_any( #"death", #"showing_final_killcam", #"showing_potg", #"started_spawnplayer" );
    cleanup_internal();
}

// Namespace swim_common
// Params 0
// Checksum 0x8ea9df2a, Offset: 0x1b33
// Size: 0x28
function cleanup_internal()
{
    uideathcleanup();
    function_d5783b89b4b286c7();
    scriptabledeathcleanup();
    clearbreathcritical();
    self.swim = undefined;
}

// Namespace swim_common
// Params 0
// Checksum 0x3101ea3f, Offset: 0x1b63
// Size: 0x13
function uideathcleanup()
{
    self setclientomnvar( o"swim_breath_meter_hide", 1 );
}

// Namespace swim_common
// Params 0
// Checksum 0x35ad0096, Offset: 0x1b7e
// Size: 0xe
function function_d5783b89b4b286c7()
{
    function_7ca78e7cdfd38015( 0.05 );
}

// Namespace swim_common
// Params 0
// Checksum 0xd7d586e4, Offset: 0x1b94
// Size: 0x34
function scriptabledeathcleanup()
{
    utility::function_32b24db3127bff40( #"swimdebris", #"abovewater" );
    utility::function_32b24db3127bff40( #"swimbubbles", #"abovewater" );
}

// Namespace swim_common
// Params 0
// Checksum 0x6e79b9b9, Offset: 0x1bd0
// Size: 0x88
function function_1fcc272380ba6e7b()
{
    self.swim.underwater = 0;
    self notify( #"hash_3030751fd4115249" );
    self endon( #"hash_3030751fd4115249" );
    childthread function_d47496a4474c3fc7();
    childthread swim_overlay_clear();
    childthread vfx_swim_surface();
    childthread vision_swim_surface();
    clearbreathcritical();
    function_e3e50f394caf650d();
    self childthread [[ level.swim.surfacefunc ]]();
    
    if ( self isswimsprinting() )
    {
        self setclientomnvar( o"swim_breath_meter_sprint", 0 );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xc04a9666, Offset: 0x1c60
// Size: 0x83
function function_51208b2efbedb7b3()
{
    self.swim.underwater = 1;
    self notify( #"hash_3030751fd4115249" );
    self endon( #"hash_3030751fd4115249" );
    childthread function_5cc0958b50414648();
    childthread swim_overlay_pulse();
    childthread function_7295c410a0b571c3();
    childthread function_d55eb3a4b6aa0756();
    childthread function_b3d73c8e2ca844f6();
    self childthread [[ level.swim.descendfunc ]]();
    
    if ( self isswimsprinting() )
    {
        self setclientomnvar( o"swim_breath_meter_sprint", 1 );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xce614d38, Offset: 0x1ceb
// Size: 0x76
function playerswimming()
{
    self notify( #"scr_change_swim_state" );
    self endon( #"scr_change_swim_state" );
    self.swim.swimming = 1;
    self childthread [[ level.swim.enterfunc ]]();
    params = spawnstruct();
    params.player = self;
    callback::callback( #"on_swim_enter", params );
}

// Namespace swim_common
// Params 0
// Checksum 0xa9c96537, Offset: 0x1d69
// Size: 0x75
function function_1d34a8e960ba182d()
{
    self notify( #"scr_change_swim_state" );
    self endon( #"scr_change_swim_state" );
    self.swim.swimming = 0;
    self childthread [[ level.swim.exitfunc ]]();
    params = spawnstruct();
    params.player = self;
    callback::callback( #"hash_c63f9d0c88a2d656", params );
}

// Namespace swim_common
// Params 0
// Checksum 0xeb4410e1, Offset: 0x1de6
// Size: 0x16, Type: bool
function isplayerunderwater()
{
    return istrue( self.swim.underwater );
}

// Namespace swim_common
// Params 0
// Checksum 0x12453892, Offset: 0x1e05
// Size: 0x16, Type: bool
function isplayerswimming()
{
    return istrue( self.swim.swimming );
}

// Namespace swim_common
// Params 1
// Checksum 0xaddd0812, Offset: 0x1e24
// Size: 0x85
function function_7ca78e7cdfd38015( time )
{
    if ( self.swim.sfxstate == "none" )
    {
        return;
    }
    
    self.swim.sfxstate = "none";
    self clearsoundsubmix( "player_swimming_underwater", 0.2 );
    self clearsoundsubmix( "iw9_player_drowning", 0 );
    self setentitysoundcontext( "atmosphere", "" );
    self clearclienttriggeraudiozone( 0.1 );
    self notify( #"jup_swim_none" );
}

// Namespace swim_common
// Params 0
// Checksum 0xe83c7afb, Offset: 0x1eb1
// Size: 0x6b
function sfx_swim_surface()
{
    if ( self.swim.sfxstate == "surface" )
    {
        return;
    }
    
    self.swim.sfxstate = "surface";
    self clearsoundsubmix( "iw9_player_drowning", 0 );
    self setentitysoundcontext( "atmosphere", "water_surface" );
    self clearclienttriggeraudiozone( 0.1 );
    self notify( #"jup_swim_surface" );
}

// Namespace swim_common
// Params 0
// Checksum 0x9d5ec71b, Offset: 0x1f24
// Size: 0x9c
function function_6c0a071348a7629b()
{
    if ( self.swim.sfxstate == "submerged" )
    {
        return;
    }
    
    self.swim.sfxstate = "submerged";
    self setentitysoundcontext( "atmosphere", "underwater" );
    
    if ( isdefined( level.snd.underwateroverride ) )
    {
        self setclienttriggeraudiozone( level.snd.underwateroverride, 0.1 );
    }
    else
    {
        self setclienttriggeraudiozone( "underwater", 0.1 );
    }
    
    self notify( #"hash_d6c47bd2cde09578" );
}

// Namespace swim_common
// Params 0
// Checksum 0x970c6e9a, Offset: 0x1fc8
// Size: 0x66
function function_f14426225c903665()
{
    plrsfx = "mvmt_swim_gagging_plr_bubbles";
    var_7a6ab0cb2e533515 = "plr_breath_swim_pain_gag";
    
    if ( soundexists( plrsfx ) )
    {
        self [[ level.swim.playsoundfunc ]]( plrsfx );
    }
    
    if ( soundexists( var_7a6ab0cb2e533515 ) )
    {
        self [[ level.swim.playsoundfunc ]]( var_7a6ab0cb2e533515 );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x3c6659f4, Offset: 0x2036
// Size: 0x7c
function function_25d266e9fea068c0()
{
    plrsfx = "mvmt_swim_plr_bubbles_light";
    var_7a6ab0cb2e533515 = "";
    
    if ( plrsfx != "" )
    {
        if ( soundexists( plrsfx ) )
        {
            self [[ level.swim.playsoundfunc ]]( plrsfx );
        }
    }
    
    if ( var_7a6ab0cb2e533515 != "" )
    {
        if ( soundexists( var_7a6ab0cb2e533515 ) )
        {
            self [[ level.swim.playsoundfunc ]]( var_7a6ab0cb2e533515 );
        }
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x1cf9db62, Offset: 0x20ba
// Size: 0x77
function sfx_player_drowning()
{
    plrsfx = "mvmt_swim_gagging_plr_bubbles_critical";
    var_7a6ab0cb2e533515 = "plr_breath_swim_pain_choke";
    
    if ( randomintrange( 0, 1 ) )
    {
        var_7a6ab0cb2e533515 = "plr_breath_swim_pain_gag";
    }
    
    if ( soundexists( plrsfx ) )
    {
        self [[ level.swim.playsoundfunc ]]( plrsfx );
    }
    
    if ( soundexists( var_7a6ab0cb2e533515 ) )
    {
        self [[ level.swim.playsoundfunc ]]( var_7a6ab0cb2e533515 );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x9a5178a4, Offset: 0x2139
// Size: 0x1b
function vfx_swim_surface()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    function_9c37c819694e107c();
    function_51dfe980848002f4();
}

// Namespace swim_common
// Params 0
// Checksum 0xe30ee7a7, Offset: 0x215c
// Size: 0x1b
function function_d55eb3a4b6aa0756()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    function_e87b98db3b0a63ff();
    function_cadda8bedabcc027();
}

// Namespace swim_common
// Params 0
// Checksum 0xba640ddf, Offset: 0x217f
// Size: 0x13
function function_e87b98db3b0a63ff()
{
    utility::function_32b24db3127bff40( "swimDebris", "underWater" );
}

// Namespace swim_common
// Params 0
// Checksum 0x59d90108, Offset: 0x219a
// Size: 0x13
function function_9c37c819694e107c()
{
    utility::function_32b24db3127bff40( "swimDebris", "aboveWater" );
}

// Namespace swim_common
// Params 0
// Checksum 0xe6873a47, Offset: 0x21b5
// Size: 0x13
function function_cadda8bedabcc027()
{
    utility::function_32b24db3127bff40( "swimBubbles", "bubblesEnter" );
}

// Namespace swim_common
// Params 0
// Checksum 0xb82be1d3, Offset: 0x21d0
// Size: 0x13
function function_51dfe980848002f4()
{
    utility::function_32b24db3127bff40( "swimBubbles", "aboveWater" );
}

// Namespace swim_common
// Params 0
// Checksum 0x434fa4ff, Offset: 0x21eb
// Size: 0x3a
function function_8471c9d328a1b33a()
{
    self thread [[ level.swim.var_f10d7aeea25eb7ff ]]( "swim_gasp_bubbles", #"swim_breathing_disabled_end", 3 );
    utility::function_32b24db3127bff40( "swimBubbles", "bubblesHeavy" );
}

// Namespace swim_common
// Params 0
// Checksum 0x1cb8914e, Offset: 0x222d
// Size: 0x29
function function_9881b5e592ce081d()
{
    self thread [[ level.swim.var_f10d7aeea25eb7ff ]]( "swim_bubbles_light", #"swim_breathing_disabled_end", 3 );
}

// Namespace swim_common
// Params 0
// Checksum 0xe9f05327, Offset: 0x225e
// Size: 0x29
function vfx_player_drowning()
{
    self thread [[ level.swim.var_f10d7aeea25eb7ff ]]( "swim_drowning_bubbles", #"swim_breathing_disabled_end", 3 );
}

// Namespace swim_common
// Params 3
// Checksum 0xbf4a786c, Offset: 0x228f
// Size: 0x39
function playsoundalias( plrsfx, npcsfx, soundsource )
{
    self [[ level.swim.playsoundfunc ]]( plrsfx, npcsfx, soundsource );
}

// Namespace swim_common
// Params 0
// Checksum 0xf3c0142b, Offset: 0x22d0
// Size: 0x14
function vision_swim_surface()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    dof_surface();
}

// Namespace swim_common
// Params 0
// Checksum 0xf3c0142b, Offset: 0x22ec
// Size: 0x14
function function_b3d73c8e2ca844f6()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    dof_descend();
}

// Namespace swim_common
// Params 0
// Checksum 0x2224e8af, Offset: 0x2308
// Size: 0x16
function dof_surface()
{
    if ( !isdefined( level.dyndof ) )
    {
        self disablephysicaldepthoffieldscripting();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x43daa458, Offset: 0x2326
// Size: 0x34
function dof_descend()
{
    if ( !isdefined( level.dyndof ) )
    {
        self enablephysicaldepthoffieldscripting( 1 );
        self setphysicaldepthoffield( 1, 200, 100 );
        self setphysicalviewmodeldepthoffield( 6, 100 );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x6aa3ed99, Offset: 0x2362
// Size: 0x3b
function swim_overlay_clear()
{
    self.swim.swimoverlay fadeovertime( 1 );
    self.swim.swimoverlay.alpha = 0;
}

// Namespace swim_common
// Params 0
// Checksum 0x5582a9df, Offset: 0x23a5
// Size: 0x45
function swim_overlay_pulse()
{
    self.swim.swimoverlay fadeovertime( 0.05 );
    
    while ( true )
    {
        waittillframeend();
        
        if ( function_52f40f2f133ccb1d() )
        {
            updateswimoverlaycolor();
            function_21fa96f8fd9e0c57();
        }
        
        wait 0.05;
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x1c72579f, Offset: 0x23f2
// Size: 0xe0
function function_7295c410a0b571c3()
{
    var_e1b700dd3740f51b = function_949715f5eceb122b();
    
    if ( !isdefined( self.heartbeat ) )
    {
        return;
    }
    
    while ( true )
    {
        self.heartbeat waittill( #"heartbeat" );
        wait 0.2 * self.heartbeat.pulseduration;
        
        if ( isdefined( self ) && isbreathcritical() )
        {
            if ( isdefined( self ) && function_52f40f2f133ccb1d() )
            {
                factor = math::normalize_value( 0, var_e1b700dd3740f51b, self.swim.breath );
                
                if ( factor > 0.66 )
                {
                    heartbeat = "heartbeatLight";
                }
                else if ( factor > 0.33 )
                {
                    heartbeat = "heartbeatMed";
                }
                else
                {
                    heartbeat = "heartbeatHeavy";
                }
                
                childthread heartbeat::function_8dc91616e5f2c60( heartbeat );
            }
        }
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xc9c2cfa, Offset: 0x24da
// Size: 0x2c3
function function_5cc0958b50414648()
{
    godmode = 0;
    expectedbreath = undefined;
    var_9d0449d244d95662 = undefined;
    var_90e27206ad8164e9 = undefined;
    var_7381ec71f6140ad9 = undefined;
    var_967633652f134280 = undefined;
    
    while ( true )
    {
        if ( self.swim.breath > 0 )
        {
            function_72bf9ef5283c708( val::get( "swimming" ) );
            godmode = 0;
        }
        
        while ( self.swim.breath > 0 )
        {
            if ( isdefined( self.swim.var_fe4523bf6919a4be ) && getdvarint( @"hash_42deeb1fb385c72", 1 ) )
            {
                self setclientomnvar( o"swim_breath_meter_hide", !self.swim.var_fe4523bf6919a4be );
                self.swim.var_fe4523bf6919a4be = undefined;
            }
            
            var_f85f6227588a6183 = expectedbreath != self.swim.breath;
            breathholdtime = [[ function_3e7ee06878dfe96a() ]]();
            var_603826bc448b1a88 = [[ level.swim.var_91e79c1e5d912497 ]]();
            var_90bd440a478720df = getdvarint( @"hash_2a4f08bc79265550" ) || self.usingscubagasmask && self.gasmaskequipped;
            var_9f47982a6ad237d3 = !var_90bd440a478720df && !function_7e1e4556b3a0f2c9();
            
            if ( var_90bd440a478720df )
            {
                self.swim.breath = 100;
            }
            
            if ( var_9f47982a6ad237d3 )
            {
                self.swim.breath -= 100 / breathholdtime * 0.05;
                self.swim.breath = clamp( self.swim.breath, 0, 100 );
            }
            
            expectedbreath = self.swim.breath;
            
            if ( var_f85f6227588a6183 || !( var_90e27206ad8164e9 === breathholdtime ) || !( var_7381ec71f6140ad9 === var_603826bc448b1a88 ) || !( var_967633652f134280 === var_9f47982a6ad237d3 ) )
            {
                childthread function_da3a0cd99e5aeae1( self.swim.breath, breathholdtime, var_603826bc448b1a88, var_9f47982a6ad237d3 );
                var_90e27206ad8164e9 = breathholdtime;
                var_7381ec71f6140ad9 = var_603826bc448b1a88;
                var_967633652f134280 = var_9f47982a6ad237d3;
            }
            
            self setclientomnvar( o"swim_breath_meter_percent", int( self.swim.breath ) );
            self function_e8f0149d8d8e76de( int( self.swim.breath ) );
            wait 0.05;
        }
        
        godmode = swim_drown( godmode );
    }
}

// Namespace swim_common
// Params 1, eflags: 0x4
// Checksum 0xe88f0708, Offset: 0x27a5
// Size: 0x2f
function private function_72bf9ef5283c708( value )
{
    if ( isdefined( self.swim ) )
    {
        self.swim.var_fe4523bf6919a4be = value;
    }
}

// Namespace swim_common
// Params 4, eflags: 0xc
// Checksum 0xa062cd22, Offset: 0x27dc
// Size: 0x113
function private function_da3a0cd99e5aeae1( breath, breathholdtime, var_603826bc448b1a88, var_9f47982a6ad237d3 )
{
    self notify( #"hash_be41a214f1ba72e1" );
    self endon( #"hash_be41a214f1ba72e1" );
    
    if ( !var_9f47982a6ad237d3 )
    {
        return;
    }
    
    var_1c79ef805a6efc7f = function_27a5aadfdc43940f( 0.66, breathholdtime, var_603826bc448b1a88 );
    var_8b2995168aa06f08 = function_27a5aadfdc43940f( 0.33, breathholdtime, var_603826bc448b1a88 );
    
    if ( breath > var_1c79ef805a6efc7f )
    {
        childthread wait_and_run( breathholdtime * ( breath - var_1c79ef805a6efc7f ) / 100, &lightbubbles );
    }
    
    if ( breath > var_8b2995168aa06f08 )
    {
        childthread wait_and_run( breathholdtime * ( breath - var_8b2995168aa06f08 ) / 100, &lightbubbles );
    }
    
    if ( !function_b59276a4d44d2ae() )
    {
        breathheartbeatthreshold = function_a3260f48c4477dca( breathholdtime );
        childthread wait_and_run( breathholdtime * ( breath - breathheartbeatthreshold ) / 100, &function_7af8a667e99a2c66 );
    }
    
    if ( !isbreathcritical() )
    {
        var_e1b700dd3740f51b = function_5982ea6f32c66988( var_603826bc448b1a88, breathholdtime );
        childthread wait_and_run( breathholdtime * ( breath - var_e1b700dd3740f51b ) / 100, &function_aa4da60311f14d56 );
    }
}

// Namespace swim_common
// Params 2, eflags: 0x4
// Checksum 0x3814ff74, Offset: 0x28f7
// Size: 0x24
function private wait_and_run( delay, func )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    [[ func ]]();
}

// Namespace swim_common
// Params 0, eflags: 0x4
// Checksum 0xa4a295c9, Offset: 0x2923
// Size: 0x10
function private function_aa4da60311f14d56()
{
    setbreathcritical();
    function_4727604a0716839e();
}

// Namespace swim_common
// Params 1
// Checksum 0x4c3c9ca3, Offset: 0x293b
// Size: 0x166, Type: bool
function swim_drown( wasgodmode )
{
    self endon( #"swim_stop_drowning" );
    self notify( #"swim_start_drowning" );
    drownweaponobj = undefined;
    drowntime = function_200fe28d960dffe1();
    
    if ( wasgodmode )
    {
        wait 0.5;
    }
    else
    {
        function_b33a9e53761fdba6();
        
        if ( drowntime > 0 )
        {
            self setclienttriggeraudiozone( "underwater_deathsdoor", 0 );
            
            if ( isdefined( level.drownvisionoverride ) )
            {
                vision = level.drownvisionoverride;
            }
            else
            {
                vision = "drowning";
            }
            
            self [[ level.swim.visionsetfunc ]]( vision, drowntime * 0.9 );
            childthread function_4b7313381aa55bb0( drowntime );
        }
        
        starttime = gettime();
        
        while ( true )
        {
            waitframe();
            
            if ( gettime() - starttime > drowntime * 1000 )
            {
                break;
            }
        }
        
        if ( level.swim.var_a7044bb949bba588 && self [[ level.swim.var_a7044bb949bba588 ]]() )
        {
            return true;
        }
        
        function_f1e3d269b34bb66();
        drownweaponobj = self [[ level.swim.drownfunc ]]();
    }
    
    self dodamage( self.health + 10000, self.origin, self, self, "MOD_SUICIDE", drownweaponobj, "torso_upper" );
    return true;
}

// Namespace swim_common
// Params 1
// Checksum 0x829c2f3f, Offset: 0x2aaa
// Size: 0x3a
function function_858b92a50d1c824b( isdisable )
{
    if ( !isdefined( self.swim ) )
    {
        return;
    }
    
    self.swim.var_401e9f3c6e4789da = isdisable ? 1 : undefined;
}

// Namespace swim_common
// Params 0
// Checksum 0x3b329777, Offset: 0x2aec
// Size: 0x26, Type: bool
function function_7e1e4556b3a0f2c9()
{
    if ( !isdefined( self.swim ) )
    {
        return false;
    }
    
    return istrue( self.swim.var_401e9f3c6e4789da );
}

// Namespace swim_common
// Params 1
// Checksum 0xf098214d, Offset: 0x2b1b
// Size: 0xc0
function function_4b7313381aa55bb0( timer )
{
    self endon( #"death_or_disconnect" );
    level endon( #"mission_fail" );
    level endon( #"game_ended" );
    
    for ( waittimeplus = 0.6; true ; waittimeplus = clamp( waittimeplus, 0, 1 ) )
    {
        function_84fa65e8abdf91b7();
        waittime = randomfloatrange( 0.8, 1.15 ) + waittimeplus;
        wait waittime;
        timer -= waittime;
        
        if ( self getclientomnvar( o"swim_breath_meter_critical" ) == 3 || !self.swim.drowning || timer <= 0 )
        {
            break;
        }
        
        waittimeplus -= 0.3;
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xeda4a07e, Offset: 0x2be3
// Size: 0x38
function swim_drown_stop()
{
    if ( function_72cf1914334a83de() )
    {
        if ( true )
        {
            childthread function_ee1cc9f6e50affdb();
        }
        
        self.swim.drowning = 0;
        self notify( #"swim_stop_drowning" );
    }
}

// Namespace swim_common
// Params 0
// Checksum 0xd6e92741, Offset: 0x2c23
// Size: 0x50
function function_ee1cc9f6e50affdb()
{
    self endon( #"swim_start_drowning" );
    self [[ level.swim.visionsetfunc ]]( "drowning_cleared", 1 );
    wait 1.05;
    self [[ level.swim.visionsetfunc ]]( "", 1 );
}

// Namespace swim_common
// Params 0
// Checksum 0x32dbfa75, Offset: 0x2c7b
// Size: 0x130
function function_d47496a4474c3fc7()
{
    if ( level.gametypebundle.var_27bc4bceae135078 && level.gametypebundle.var_27bc4bceae135078 > 0 )
    {
        wait level.gametypebundle.var_27bc4bceae135078;
    }
    
    while ( self.swim.breath < 100 )
    {
        self.swim.breath += 0.05 / [[ level.swim.var_96154933dff85312 ]]() * 100;
        self.swim.breath = clamp( self.swim.breath, 1, 100 );
        self setclientomnvar( o"swim_breath_meter_percent", int( self.swim.breath ) );
        self function_e8f0149d8d8e76de( int( self.swim.breath ) );
        wait 0.05;
    }
    
    self setclientomnvar( o"swim_breath_meter_hide", 1 );
}

// Namespace swim_common
// Params 2
// Checksum 0xb61ade00, Offset: 0x2db3
// Size: 0x1a0
function function_e59f9853946b5d19( amount, var_75693b72331513fa )
{
    self endon( #"hash_3030751fd4115249" );
    breathfunc = level.swim.var_96154933dff85312;
    
    if ( isdefined( var_75693b72331513fa ) )
    {
        breathfunc = var_75693b72331513fa;
    }
    
    while ( self.swim.breath <= amount )
    {
        self.swim.breath += 0.05 / [[ breathfunc ]]() * amount;
        self.swim.breath = clamp( self.swim.breath, 1, 100 );
        self setclientomnvar( o"swim_breath_meter_percent", int( self.swim.breath ) );
        self function_e8f0149d8d8e76de( int( self.swim.breath ) );
        var_e1b700dd3740f51b = function_949715f5eceb122b();
        
        if ( self.swim.breath > var_e1b700dd3740f51b && isbreathcritical() )
        {
            clearbreathcritical();
            self clearsoundsubmix( "iw9_player_drowning", 0 );
            self setclienttriggeraudiozone( "underwater", 5 );
        }
        
        heartbeatthreshold = function_63e6119e865570a7();
        
        if ( self.swim.breath > heartbeatthreshold && function_b59276a4d44d2ae() )
        {
            function_e3e50f394caf650d();
        }
        
        wait 0.05;
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x952ec52e, Offset: 0x2f5b
// Size: 0x1b
function function_4727604a0716839e()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    function_f14426225c903665();
    function_8471c9d328a1b33a();
}

// Namespace swim_common
// Params 0
// Checksum 0x70fc27a5, Offset: 0x2f7e
// Size: 0x10
function lightbubbles()
{
    function_25d266e9fea068c0();
    function_9881b5e592ce081d();
}

// Namespace swim_common
// Params 0
// Checksum 0x2697ed6f, Offset: 0x2f96
// Size: 0x1b
function function_84fa65e8abdf91b7()
{
    if ( !function_52f40f2f133ccb1d() )
    {
        return;
    }
    
    sfx_player_drowning();
    vfx_player_drowning();
}

// Namespace swim_common
// Params 0
// Checksum 0xb1947c16, Offset: 0x2fb9
// Size: 0x180
function updateswimoverlaycolor()
{
    var_e1b700dd3740f51b = function_949715f5eceb122b();
    
    if ( isdefined( level.var_6eeb39c05788e049 ) && [[ level.var_6eeb39c05788e049 ]]( #"player", #"updateswimoverlaycolor" ) )
    {
        colorfunc = [[ level.sharedfuncget_func ]]( #"player", #"updateswimoverlaycolor" );
        color = [[ colorfunc ]]( self.swim.breath, isbreathcritical(), var_e1b700dd3740f51b, 100 );
        self.swim.swimoverlay.color = color;
        return;
    }
    
    if ( isbreathcritical() )
    {
        colormax = ( 0.2, 0.1, 0.1 );
        colormin = ( 0.25, 0.05, 0.05 );
        factor = math::normalize_value( 0, var_e1b700dd3740f51b, self.swim.breath );
    }
    else
    {
        colormax = ( 0.2, 0.2, 0.2 );
        colormin = ( 0.1, 0.1, 0.1 );
        factor = math::normalize_value( var_e1b700dd3740f51b, 100, self.swim.breath );
    }
    
    color = math::factor_value( colormin, colormax, factor );
    self.swim.swimoverlay.color = color;
}

// Namespace swim_common
// Params 0
// Checksum 0xe8787e31, Offset: 0x3141
// Size: 0x13d
function function_21fa96f8fd9e0c57()
{
    var_e1b700dd3740f51b = function_949715f5eceb122b();
    
    /#
        if ( !isdefined( self.heartbeat ) )
        {
            assertmsg( "<dev string:x24>" );
        }
    #/
    
    if ( isbreathcritical() )
    {
        minminalpha = 0.1;
        minmaxalpha = 0.2;
        maxminalpha = 0.5;
        maxmaxalpha = 0.75;
        factor = math::normalize_value( 0, var_e1b700dd3740f51b, self.swim.breath );
    }
    else
    {
        minminalpha = 0;
        minmaxalpha = 0.3;
        maxminalpha = 0.2;
        maxmaxalpha = 0.6;
        factor = math::normalize_value( var_e1b700dd3740f51b, 100, self.swim.breath );
    }
    
    maxalpha = math::factor_value( maxmaxalpha, maxminalpha, factor );
    minalpha = math::factor_value( minmaxalpha, minminalpha, factor );
    self.swim.swimoverlay.alpha = math::factor_value( minalpha, maxalpha, self.heartbeat.pulsetime );
}

// Namespace swim_common
// Params 0
// Checksum 0xf2e0d199, Offset: 0x3286
// Size: 0x18
function function_65b1171cbe9502ee()
{
    if ( !isdefined( self.swim ) )
    {
        return 0;
    }
    
    return function_b59276a4d44d2ae();
}

// Namespace swim_common
// Params 0
// Checksum 0x7f92680, Offset: 0x32a7
// Size: 0x15
function isbreathcritical()
{
    return self.swim.breathcritical;
}

// Namespace swim_common
// Params 0
// Checksum 0x3dc956db, Offset: 0x32c5
// Size: 0x15
function function_72cf1914334a83de()
{
    return self.swim.drowning;
}

// Namespace swim_common
// Params 0
// Checksum 0x78b7851, Offset: 0x32e3
// Size: 0x15
function function_b59276a4d44d2ae()
{
    return self.swim.heartbeat;
}

// Namespace swim_common
// Params 0
// Checksum 0x2ecbd9df, Offset: 0x3301
// Size: 0x3a, Type: bool
function function_79e1ee77c514b2cc()
{
    if ( !isdefined( self.swim ) )
    {
        return false;
    }
    
    var_e1b700dd3740f51b = function_949715f5eceb122b();
    return self.swim.breath < var_e1b700dd3740f51b;
}

// Namespace swim_common
// Params 1
// Checksum 0xf86fc8fd, Offset: 0x3344
// Size: 0x46, Type: bool
function function_55f41a46c8508ab( var_980f4a83e08f7a27 )
{
    if ( !isdefined( self.swim ) )
    {
        return false;
    }
    
    lightbubblesthreshold = function_58336245d6dc0e54( var_980f4a83e08f7a27 );
    return self.swim.breath < lightbubblesthreshold;
}

// Namespace swim_common
// Params 0
// Checksum 0x86963e18, Offset: 0x3393
// Size: 0x3b
function clearbreathcritical()
{
    self setclientomnvar( o"swim_breath_meter_critical", 0 );
    
    if ( isdefined( self.swim ) )
    {
        self.swim.breathcritical = 0;
        swim_drown_stop();
    }
}

// Namespace swim_common
// Params 0
// Checksum 0x4e8e1b38, Offset: 0x33d6
// Size: 0x35
function setbreathcritical()
{
    self setclienttriggeraudiozone( "underwater_drowning", 0 );
    self.swim.breathcritical = 1;
    self setclientomnvar( o"swim_breath_meter_critical", 1 );
}

// Namespace swim_common
// Params 0
// Checksum 0x4d6de3ac, Offset: 0x3413
// Size: 0x17
function function_e3e50f394caf650d()
{
    self.swim.heartbeat = 0;
}

// Namespace swim_common
// Params 0
// Checksum 0x4f0b64fd, Offset: 0x3432
// Size: 0x24
function function_7af8a667e99a2c66()
{
    self.swim.heartbeat = 1;
    self notify( #"hash_8a4f2396a57e506e" );
}

// Namespace swim_common
// Params 0
// Checksum 0x161f75bf, Offset: 0x345e
// Size: 0x29
function function_b33a9e53761fdba6()
{
    self.swim.drowning = 1;
    self setclientomnvar( o"swim_breath_meter_critical", 2 );
}

// Namespace swim_common
// Params 0
// Checksum 0xa63806b9, Offset: 0x348f
// Size: 0x13
function function_f1e3d269b34bb66()
{
    self setclientomnvar( o"swim_breath_meter_critical", 3 );
}

// Namespace swim_common
// Params 0
// Checksum 0xe0e1fcda, Offset: 0x34aa
// Size: 0x3a, Type: bool
function function_12335dccfc07df6e()
{
    if ( !isdefined( self.swim ) )
    {
        return false;
    }
    
    heartbeatthreshold = function_63e6119e865570a7();
    return self.swim.breath < heartbeatthreshold;
}

// Namespace swim_common
// Params 0
// Checksum 0xad8861af, Offset: 0x34ed
// Size: 0x1e
function function_63e6119e865570a7()
{
    breathholdtime = [[ function_3e7ee06878dfe96a() ]]();
    return function_a3260f48c4477dca( breathholdtime );
}

// Namespace swim_common
// Params 1, eflags: 0x4
// Checksum 0x26c456bf, Offset: 0x3514
// Size: 0x24
function private function_a3260f48c4477dca( breathholdtime )
{
    var_d0f3b0cdae23d7c5 = breathholdtime - 6;
    return var_d0f3b0cdae23d7c5 / breathholdtime * 100;
}

// Namespace swim_common
// Params 0
// Checksum 0xed47b2b8, Offset: 0x3541
// Size: 0x3e
function function_949715f5eceb122b()
{
    breathholdtime = [[ function_3e7ee06878dfe96a() ]]();
    var_603826bc448b1a88 = [[ level.swim.var_91e79c1e5d912497 ]]();
    return function_5982ea6f32c66988( var_603826bc448b1a88, breathholdtime );
}

// Namespace swim_common
// Params 2, eflags: 0x4
// Checksum 0xb3752d38, Offset: 0x3588
// Size: 0x1c
function private function_5982ea6f32c66988( var_603826bc448b1a88, breathholdtime )
{
    return var_603826bc448b1a88 / breathholdtime * 100;
}

// Namespace swim_common
// Params 1
// Checksum 0xeb4976a4, Offset: 0x35ad
// Size: 0x49
function function_58336245d6dc0e54( var_980f4a83e08f7a27 )
{
    breathholdtime = [[ function_3e7ee06878dfe96a() ]]();
    var_603826bc448b1a88 = [[ level.swim.var_91e79c1e5d912497 ]]();
    return function_27a5aadfdc43940f( var_980f4a83e08f7a27, breathholdtime, var_603826bc448b1a88 );
}

// Namespace swim_common
// Params 3, eflags: 0x4
// Checksum 0x96beb4a0, Offset: 0x35ff
// Size: 0x3a
function private function_27a5aadfdc43940f( var_980f4a83e08f7a27, breathholdtime, var_603826bc448b1a88 )
{
    lightbubblestime = var_603826bc448b1a88 + var_980f4a83e08f7a27 * ( breathholdtime - var_603826bc448b1a88 );
    return lightbubblestime / breathholdtime * 100;
}

// Namespace swim_common
// Params 0
// Checksum 0x44b0e60b, Offset: 0x3642
// Size: 0x1e
function function_200fe28d960dffe1()
{
    if ( self.var_fc6aabccd52538ed )
    {
        return self.var_fc6aabccd52538ed;
    }
    
    return 4;
}

// Namespace swim_common
// Params 0
// Checksum 0x29a36191, Offset: 0x3668
// Size: 0x2f
function function_e17d5a8ae0a27da8()
{
    breathholdtime = [[ function_3e7ee06878dfe96a() ]]();
    return breathholdtime * self.swim.breath / 100;
}

// Namespace swim_common
// Params 0
// Checksum 0x64157a03, Offset: 0x36a0
// Size: 0xcf
function createswimoverlay()
{
    swimoverlay = newclienthudelem( self );
    swimoverlay.sort = 1;
    swimoverlay.x = 0;
    swimoverlay.y = 0;
    swimoverlay.alignx = "left";
    swimoverlay.aligny = "top";
    swimoverlay.foreground = 0;
    swimoverlay.lowresbackground = 1;
    swimoverlay.horzalign = "fullscreen";
    swimoverlay.vertalign = "fullscreen";
    swimoverlay.alpha = 0;
    swimoverlay setshader( "hud_swim_vignette", 640, 480 );
    self.swim.swimoverlay = swimoverlay;
}

// Namespace swim_common
// Params 3
// Checksum 0x7e6a2592, Offset: 0x3777
// Size: 0x2b
function function_bd47027c4d3e9288( msg1, msg2, timer )
{
    self endon( msg1 );
    self endon( msg2 );
    wait timer;
}

// Namespace swim_common
// Params 0
// Checksum 0xf1ca7d17, Offset: 0x37aa
// Size: 0xd, Type: bool
function function_52f40f2f133ccb1d()
{
    return !isdefined( self.usingremote );
}

// Namespace swim_common
// Params 0
// Checksum 0xb208a208, Offset: 0x37c0
// Size: 0x30
function function_3e7ee06878dfe96a()
{
    if ( isdefined( self.var_87ca408e836d56cf ) )
    {
        return self.var_87ca408e836d56cf;
    }
    
    return level.swim.var_87ca408e836d56cf;
}

