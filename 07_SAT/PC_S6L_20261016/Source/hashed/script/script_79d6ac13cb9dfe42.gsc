// script_79d6ac13cb9dfe42  (hash_79d6ac13cb9dfe42.gscc) (size: 5634 Bytes / 0x1602 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2954c41 (3801435201)
// size ...... 5634 (0x1602)
// includes .. 10  (offset: 0x1496)
// strings ... 20  (offset: 0x14e6)
// dev strs .. 1   (offset: 0x15f6)
// exports ... 11  (offset: 0xd62)
// cseg ...... 0x221 + 0xb41 (0xd62)
// imports ... 48  (offset: 0xf1a)
// animtree1 . 0   (offset: 0x1602)
// animtree2 . 0   (offset: 0x1602)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_47c07e1713f6efbc;

// Namespace namespace_47c07e1713f6efbc
// Params 0, eflags: 0x5
// Checksum 0x6ec90c5d, Offset: 0x23f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a94a6c2827e4f6e3", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_47c07e1713f6efbc
// Params 0
// Checksum 0xa86e3748, Offset: 0x268
// Size: 0x71
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"physicsbox", #"create", &function_efa2782f3fc50aa );
    ztron_hazard::function_6f661fac5fd31f1( #"physicsbox", #"arenaspawn", &function_d594f00c7a9ee250 );
    ztron_sound::function_4ac735395b173fe( "zmb_physicsBoxVelocity", "evt_ztron_physics_box_launcher" );
    ztron_sound::function_4ac735395b173fe( "ztron_springboard", "evt_ztron_springboard" );
    ztron_sound::function_4ac735395b173fe( "zmb_ragdoll_launched", "zmb_ragdoll_launched" );
}

// Namespace namespace_47c07e1713f6efbc
// Params 0
// Checksum 0x1ae0baaf, Offset: 0x2e1
// Size: 0xb1
function function_d594f00c7a9ee250()
{
    level.ztron.var_5f5cdb0cde32dcc9 = [];
    traps = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "physicsbox" );
    
    foreach ( trap in traps )
    {
        function_efa2782f3fc50aa( trap );
    }
}

// Namespace namespace_47c07e1713f6efbc
// Params 2
// Checksum 0x3a212482, Offset: 0x39a
// Size: 0x59
function function_efa2782f3fc50aa( trap, page = 0 )
{
    if ( page )
    {
        level.ztron.var_5f5cdb0cde32dcc9[ level.ztron.var_5f5cdb0cde32dcc9.size ] = trap;
        return;
    }
    
    function_2d48b73f18001723( trap );
}

// Namespace namespace_47c07e1713f6efbc
// Params 2
// Checksum 0x14117d18, Offset: 0x3fb
// Size: 0x25f
function function_2d48b73f18001723( trap, paged = 0 )
{
    assert( isdefined( trap.script_parameters ), "<dev string:x24>" );
    args = strtok( trap.script_parameters, ";" );
    trap.angles = trap.angles ?? ( 0, 0, 0 );
    
    switch ( args[ 0 ] )
    {
        case #"hash_afde2b1f38637992":
            trap.velocityvector = ( float( args[ 1 ] ), float( args[ 2 ] ), float( args[ 3 ] ) );
            trap.type = 0;
            break;
        default:
            assert( 0 );
            break;
    }
    
    if ( !isdefined( trap.script_model ) )
    {
        trap.script_model = utility::spawn_model( args[ 4 ] ?? "sat_zm_ztron_props_spring_platform", trap.origin, trap.angles );
        trap.script_model notsolid();
    }
    
    if ( !isdefined( trap.vfx_scriptable ) && function_518c04e62644e496( trap.script_model.model ) )
    {
        trap.vfx_scriptable = spawnscriptable( "ztron_physics_box", trap.origin, trap.angles );
        waitframe();
        trap.vfx_scriptable scriptablesetparententity( trap.script_model );
    }
    
    if ( isdefined( trap.script_model ) )
    {
        trap.script_model.targetname = "hazard";
        trap.script_model.hazardtype = "physicsbox";
    }
    
    trap.var_1b500357fd27cba9 = args[ 5 ] ?? 0;
    trap.upduration = isdefined( args[ 6 ] ) ? float( args[ 6 ] ) : 5;
    trap.recoverduration = isdefined( args[ 7 ] ) ? float( args[ 6 ] ) : 3;
    trap.paged = paged;
    trap thread function_9102b1de9cc41726();
    return trap;
}

// Namespace namespace_47c07e1713f6efbc
// Params 0
// Checksum 0xefa622f, Offset: 0x663
// Size: 0x49c
function function_9102b1de9cc41726()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"destroy_hazard" );
    thread function_65a782557cc0f4c4();
    
    if ( !isdefined( self.script_model ) )
    {
        self notify( #"destroy_hazard" );
    }
    
    var_ceb4f48c38ed1bd3 = self.origin;
    up = anglestoup( self.angles );
    upposition = var_ceb4f48c38ed1bd3 + up * function_1cde9093b8fb3fed( self.script_model.model, "upPositionOffset" );
    
    while ( self )
    {
        waitframe();
        
        if ( !isdefined( self.trigger ) )
        {
            trigger_half_size = function_decb653c5689e4ca( self.script_model.model );
            self.trigger = spawn( "trigger_box", self.origin, undefined, trigger_half_size, trigger_half_size );
            self.trigger.origin += function_1cde9093b8fb3fed( self.script_model.model, "zTriggerOffset" ) * up;
            self.trigger.angles = self.angles;
            self.trigger.owner = self;
            
            /#
                thread function_d158f087a5fa8bfe( self.trigger );
            #/
            
            continue;
        }
        
        if ( self.vfx_scriptable )
        {
            self.vfx_scriptable setscriptablepartstate( "ztron_physics_box", "idle" );
        }
        
        while ( self )
        {
            self.trigger waittill( #"trigger", guy );
            
            if ( guy vehicle::is_vehicle() )
            {
                continue;
            }
            
            recoveryduration = self.recoverduration;
            
            switch ( self.type )
            {
                default:
                    if ( isplayer( guy ) )
                    {
                        ztron_sound::ztron_playsound( "zmb_physicsBoxVelocity", undefined, self.script_model );
                        
                        if ( isdefined( guy ) )
                        {
                            guyvel = guy getvelocity();
                            guy setorigin( guy.origin + up * 20 );
                            bouncevel = ( self.velocityvector[ 0 ] != 0 ? self.velocityvector[ 0 ] : guyvel[ 0 ], self.velocityvector[ 1 ] != 0 ? self.velocityvector[ 1 ] : guyvel[ 1 ], self.velocityvector[ 2 ] != 0 ? self.velocityvector[ 2 ] : guyvel[ 2 ] );
                            guy setvelocity( bouncevel );
                            
                            if ( ztron_main::function_4da200e9b8d58a3c() != 1 )
                            {
                                guy thread ztron_player_utility::function_a6f524867f63c5cc();
                            }
                            
                            ztron_sound::ztron_playsound( "ztron_springboard", undefined, guy );
                        }
                    }
                    else if ( isagent( guy ) )
                    {
                        if ( isdefined( guy.launched ) )
                        {
                            continue;
                        }
                        
                        if ( !issentient( guy ) )
                        {
                            continue;
                        }
                        
                        if ( !guy.takedamage )
                        {
                            continue;
                        }
                        
                        if ( guy.no_hazards || guy.ztron.boss || self.var_1b500357fd27cba9 )
                        {
                            continue;
                        }
                        
                        if ( !guy.no_ragdoll )
                        {
                            guy.launched = 1;
                            guy thread ztron_util::function_afa1f6a404783c8a( self.velocityvector, 200000 );
                            ztron_sound::ztron_playsound( "ztron_springboard", undefined, guy );
                            ztron_sound::ztron_playsound( "zmb_ragdoll_launched", undefined, guy );
                        }
                    }
                    
                    break;
            }
            
            break;
        }
        
        upduration = self.upduration;
        
        if ( isdefined( guy.ztron.upgradeMask ) && guy.ztron.upgradeMask & 64 )
        {
            recoveryduration *= 0.5;
            upduration *= 0.5;
        }
        
        if ( self.vfx_scriptable )
        {
            self.vfx_scriptable setscriptablepartstate( "ztron_physics_box", "hide" );
        }
        
        self.script_model moveto( upposition, 0.1 );
        playfx( utility::getfx( "ztron_boxing_stars" ), upposition + function_1cde9093b8fb3fed( self.script_model.model, "zVfxOffset" ) * up );
        wait upduration;
        self.script_model moveto( var_ceb4f48c38ed1bd3, recoveryduration );
        wait recoveryduration;
    }
}

// Namespace namespace_47c07e1713f6efbc
// Params 0
// Checksum 0xb65a4820, Offset: 0xb07
// Size: 0xb7
function function_65a782557cc0f4c4()
{
    thread ztron_hazard::function_4d643b159a80c647();
    self waittill( #"destroy_hazard" );
    
    if ( self.paged )
    {
        arrayremove( level.ztron.var_5f5cdb0cde32dcc9, self );
        ztron_debug::debugmsg( "Deleting physics box trap permenently at:" + self.origin );
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
        self.script_model = undefined;
    }
    
    if ( isdefined( self.vfx_scriptable ) )
    {
        self.vfx_scriptable freescriptable();
    }
}

// Namespace namespace_47c07e1713f6efbc
// Params 2
// Checksum 0x9d91bdca, Offset: 0xbc6
// Size: 0xd6
function function_1cde9093b8fb3fed( model_name, param_name )
{
    if ( model_name == "t10_zm_opal_dark_aether_mushroom_01_small" )
    {
        switch ( param_name )
        {
            case #"hash_7f4fa6c2b4cef48":
                return 64;
            case #"hash_4f038fac11d62b30":
                return 64;
            case #"hash_ac9f21110e5bd65c":
                return 128;
        }
        
        return;
    }
    
    if ( model_name == "sat_zm_ztron_platform_spring" )
    {
        switch ( param_name )
        {
            case #"hash_7f4fa6c2b4cef48":
                return 8;
            case #"hash_4f038fac11d62b30":
                return 16;
            case #"hash_ac9f21110e5bd65c":
                return 8;
        }
        
        return;
    }
    
    switch ( param_name )
    {
        case #"hash_7f4fa6c2b4cef48":
            return 8;
        case #"hash_4f038fac11d62b30":
            return 8;
        case #"hash_ac9f21110e5bd65c":
            return 16;
    }
}

// Namespace namespace_47c07e1713f6efbc
// Params 1
// Checksum 0x9065dd86, Offset: 0xca4
// Size: 0x4d
function function_518c04e62644e496( model_name )
{
    switch ( model_name )
    {
        case #"hash_ac72b46aff3b4dc9":
        case #"hash_c0957f58d7ad29a5":
            return 0;
        case #"hash_1641468b187f4da4":
            return 1;
        default:
            return 0;
    }
}

/#

    // Namespace namespace_47c07e1713f6efbc
    // Params 1, eflags: 0x4
    // Checksum 0xb53546b2, Offset: 0xcf9
    // Size: 0x69, Type: dev
    function private function_d158f087a5fa8bfe( trigger )
    {
        level endon( #"ztron_game_is_over" );
        self endon( #"destroy_hazard" );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1 )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
