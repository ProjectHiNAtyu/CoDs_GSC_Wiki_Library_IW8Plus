// script_36f4df0af71365fa  (hash_36f4df0af71365fa.gscc) (size: 3880 Bytes / 0xf28 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33e19aef (870423279)
// size ...... 3880 (0xf28)
// includes .. 9   (offset: 0xe6c)
// strings ... 7   (offset: 0xeb4)
// dev strs .. 2   (offset: 0xf10)
// exports ... 14  (offset: 0x804)
// cseg ...... 0xd8 + 0x72c (0x804)
// imports ... 37  (offset: 0xa34)
// animtree1 . 0   (offset: 0xf28)
// animtree2 . 0   (offset: 0xf28)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_8b88d3ab6f21188c;

// Namespace namespace_8b88d3ab6f21188c
// Params 0, eflags: 0x5
// Checksum 0xee1a9162, Offset: 0xf6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bcbd329cf07799fb", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 0
// Checksum 0x39bead7c, Offset: 0x11f
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"elemental_terrain", #"create", &function_e77e60658a87d640 );
    ztron_hazard::function_6f661fac5fd31f1( #"elemental_terrain", #"arenaspawn", &function_8ae25ab0f7577225 );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 0
// Checksum 0xc4a872eb, Offset: 0x165
// Size: 0x9c
function function_8ae25ab0f7577225()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "elemental_terrain" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_e77e60658a87d640( var_4d080f710fb8349e );
    }
}

// Namespace namespace_8b88d3ab6f21188c
// Params 2
// Checksum 0x24c8168d, Offset: 0x209
// Size: 0x1a5
function function_e77e60658a87d640( trapstruct, paged )
{
    if ( !isdefined( trapstruct.target ) )
    {
        assertmsg( "<dev string:x24>" + trapstruct.targetname + "<dev string:x4f>" );
        return;
    }
    
    if ( isdefined( trapstruct.script_parameters ) )
    {
        toks = strtok( trapstruct.script_parameters, ";" );
        
        if ( toks.size > 0 )
        {
            trapstruct.elementaltype = toks[ 0 ];
            
            if ( toks.size > 1 )
            {
                trapstruct.damage = float( toks[ 1 ] );
            }
            
            if ( toks.size > 2 )
            {
                trapstruct.duration = float( toks[ 2 ] );
            }
            
            if ( toks.size > 3 )
            {
                trapstruct.tick = float( toks[ 3 ] );
            }
            
            if ( toks.size > 4 )
            {
                trapstruct.var_1b500357fd27cba9 = int( toks[ 4 ] );
            }
            
            if ( toks.size > 5 )
            {
                trapstruct.var_faf94f76637b18d4 = float( toks[ 5 ] );
            }
            
            if ( toks.size > 6 )
            {
                trapstruct.speedscale = float( toks[ 6 ] );
            }
        }
    }
    
    if ( !isdefined( trapstruct.elementaltype ) )
    {
        trapstruct.elementaltype = "fire";
    }
    
    if ( !trapstruct.iseventbased )
    {
        trapstruct thread ztron_hazard::function_4d643b159a80c647( 0 );
    }
    
    triggers = ztron_util::function_2d9de5c7b97db39( trapstruct.target, #targetname );
    utility::array_thread( triggers, &function_c88117bcb1846393, trapstruct );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 1
// Checksum 0x2fb4d4c6, Offset: 0x3b6
// Size: 0xbd
function function_c88117bcb1846393( trapstruct )
{
    if ( self.code_classname != "trigger_multiple" )
    {
        return;
    }
    
    switch ( trapstruct.elementaltype )
    {
        case #"hash_7651db02434beff0":
            trigger::makeenterexittrigger( self, &function_f74945ba3ee5122c, &function_72c58d7fefb7ce0a, undefined, "exit_water_terrain", &function_ed1ddb1f2d9298b8, trapstruct );
            break;
        case #"hash_ceb098150f024a39":
        default:
            trigger::makeenterexittrigger( self, &function_d2791f0abc869711, undefined, undefined, "exit_fire_terrain", &function_5369ca5d580fef13, trapstruct );
            break;
    }
    
    /#
        trapstruct thread function_1cb6942ff6aaa24e( self );
    #/
    
    trapstruct waittill( #"destroy_hazard" );
    self notify( #"hash_73537c07898a047a" );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 2, eflags: 0xc
// Checksum 0x9d5f97a4, Offset: 0x47b
// Size: 0x52
function private function_8336acf6af486e30( trigger, payload )
{
    self notify( #"hash_650c83a68efd66c0" );
    self endon( #"hash_650c83a68efd66c0" );
    self endon( #"disconnect" );
    trigger waittill( #"hash_73537c07898a047a" );
    function_72c58d7fefb7ce0a( self, trigger, payload );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 3
// Checksum 0xb1e97a19, Offset: 0x4d5
// Size: 0x65
function function_f74945ba3ee5122c( player, trigger, payload )
{
    player thread function_8336acf6af486e30( trigger, payload );
    speedscale = payload.speedscale ?? getdvarfloat( @"hash_3ea7f48d4aa3cc71", 0.7 );
    player ztron_hazard::function_4512b7715789e4cf( "elemental_terrain", speedscale );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 3
// Checksum 0xa69852e, Offset: 0x542
// Size: 0x2c
function function_72c58d7fefb7ce0a( player, trigger, payload )
{
    player ztron_hazard::function_986fc44dada307f4( "elemental_terrain" );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 3
// Checksum 0xc2fd7d16, Offset: 0x576
// Size: 0x25, Type: bool
function function_ed1ddb1f2d9298b8( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 3
// Checksum 0xee2b5102, Offset: 0x5a4
// Size: 0x42
function function_d2791f0abc869711( enteringentity, trigger, payload )
{
    if ( enteringentity.ztron.boss )
    {
        return;
    }
    
    enteringentity thread function_71c7af7385b3c740( trigger, payload );
}

// Namespace namespace_8b88d3ab6f21188c
// Params 3
// Checksum 0xb8e65629, Offset: 0x5ee
// Size: 0x6b, Type: bool
function function_5369ca5d580fef13( var_11bf9622e9646279, trigger, payload )
{
    if ( !isplayer( var_11bf9622e9646279 ) && !isai( var_11bf9622e9646279 ) )
    {
        return true;
    }
    
    if ( isai( var_11bf9622e9646279 ) && ( var_11bf9622e9646279.ztron.boss || payload.var_1b500357fd27cba9 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_8b88d3ab6f21188c
// Params 2
// Checksum 0x7d102c23, Offset: 0x662
// Size: 0x145
function function_71c7af7385b3c740( trigger, trapstruct )
{
    self notify( #"hash_b53297125c653abf" );
    self endon( #"hash_b53297125c653abf" );
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"exit_fire_terrain" );
    trapstruct endon( #"destroy_hazard" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    damage = trapstruct.damage ?? 15;
    
    if ( isai( self ) )
    {
        damage = damage / 150 * self.maxhealth;
        
        if ( trapstruct.var_faf94f76637b18d4 )
        {
            damage = trapstruct.var_faf94f76637b18d4;
        }
    }
    
    tick = trapstruct.tick ?? 0.5;
    attacker = trigger;
    
    while ( true )
    {
        waitframe();
        
        if ( isplayer( self ) && player::isinlaststand( self ) )
        {
            continue;
        }
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( vehicle::is_vehicle() || self.no_hazards )
        {
            continue;
        }
        
        ztron_vfx::burn();
        self dodamage( damage, self.origin, trigger, trigger, "MOD_ELEMENTAL_FIRE" );
        wait tick;
    }
}

/#

    // Namespace namespace_8b88d3ab6f21188c
    // Params 1, eflags: 0x4
    // Checksum 0x8d582ec9, Offset: 0x7af
    // Size: 0x55, Type: dev
    function private function_1cb6942ff6aaa24e( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        
        while ( isdefined( trigger ) )
        {
            drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 1, 0, 0 ) );
            waitframe();
        }
    }

#/
