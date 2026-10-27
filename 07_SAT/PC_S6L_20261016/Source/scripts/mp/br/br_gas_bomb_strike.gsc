// scripts\mp\br\br_gas_bomb_strike.gsc  (hash_59059092829384ef.gscc) (size: 8237 Bytes / 0x202d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9422d553 (2485310803)
// size ...... 8237 (0x202d)
// includes .. 8   (offset: 0x1eb9)
// strings ... 13  (offset: 0x1ef9)
// dev strs .. 11  (offset: 0x1f9d)
// exports ... 32  (offset: 0x10bd)
// cseg ...... 0x150 + 0xf6d (0x10bd)
// imports ... 79  (offset: 0x15bd)
// animtree1 . 0   (offset: 0x202d)
// animtree2 . 0   (offset: 0x202d)
#using scripts\common\bots\bots_util;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player_utility;

#namespace br_gas_bomb_strike;

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x1
// Checksum 0x457eb397, Offset: 0x16e
// Size: 0x1e
function autoexec main()
{
    if ( getdvarint( @"scr_br_gas_bomb_strike_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    init();
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0x727e2865, Offset: 0x194
// Size: 0xa6
function private init()
{
    level.br_gas_bomb_strikes = { #var_6167179e423161ce:[] };
    utility::registersharedfunc( #"game", #"hash_83813268d7766e3d", &function_5b289e5a2156fd70 );
    utility::registersharedfunc( #"game", #"hash_5a923eb4a3810b51", &function_e7e1ea6b0592647 );
    utility::registersharedfunc( #"game", #"hash_84c33c8492bdaec4", &function_5186c3ae0b2287db );
    init_script_bundles();
    
    if ( level.br_gas_bomb_strikes.var_3e3c6b0c245acaca.size > 0 )
    {
        audio_utility::snd_transient_load( "mp_gametype_gas_bomb_strikes" );
    }
    
    /#
        debug_init();
    #/
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0xf4b2ec9d, Offset: 0x242
// Size: 0x9c
function private init_script_bundles()
{
    level.br_gas_bomb_strikes.var_3e3c6b0c245acaca = [];
    var_7390425f5437246e = getscriptbundlenames( "gasbombstrike" );
    
    foreach ( bundlename in var_7390425f5437246e )
    {
        function_d74bcee5951f85e8( bundlename );
    }
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xe3d55189, Offset: 0x2e6
// Size: 0xc9
function private function_d74bcee5951f85e8( bundlename )
{
    bundle = getscriptbundle( bundlename );
    
    if ( !isdefined( bundle ) )
    {
        assert( isdefined( bundle ) );
        return;
    }
    
    level.br_gas_bomb_strikes.var_3e3c6b0c245acaca[ bundlename ] = bundle;
    
    if ( bundle.var_43e7b2b66b23f989 )
    {
        bundle.targetposition = undefined;
        level.br_gas_bomb_strikes.var_8fe0b7fd75012ab4 = 1;
    }
    else
    {
        assert( bundle.targetposition );
        temptargetposition = utility::function_b73ecb08dfaa1bc5( bundle.targetposition );
        bundle.targetposition = temptargetposition;
    }
    
    register_gas_settings( bundle.gassettings );
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0x3ffc863e, Offset: 0x3b7
// Size: 0xd4
function private register_gas_settings( gassettings )
{
    if ( !isdefined( gassettings ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_gas_bomb_strikes.gassettings ) )
    {
        level.br_gas_bomb_strikes.gassettings = [];
    }
    
    var_7237854e3be197ca = level.br_gas_bomb_strikes.gassettings[ gassettings ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_b86690372968e34a = getscriptbundle( gassettings );
    
    if ( !isdefined( var_b86690372968e34a ) )
    {
        return;
    }
    
    level.br_gas_bomb_strikes.gassettings[ gassettings ] = var_b86690372968e34a;
    utility::callsharedfunc( #"gas", #"hash_b1acc2201b601807", var_b86690372968e34a.gastype, var_b86690372968e34a, &function_7ff5c943a0cb7059, &on_gas_exited, &function_f7ccdd5d10f4102a, &function_50b7421f885f5bf1 );
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0xfd5ee346, Offset: 0x493
// Size: 0xd7
function private function_5b289e5a2156fd70( var_b35aa375dee62cc2, startdelay = 0 )
{
    level endon( #"game_ended" );
    
    if ( startdelay > 0 )
    {
        wait startdelay;
    }
    
    foreach ( gasbombstrike in var_b35aa375dee62cc2 )
    {
        wait gasbombstrike.var_e81a97730dd21e67;
        thread function_c56e1dec2729fca3( gasbombstrike );
    }
    
    if ( !level.br_gas_bomb_strikes.var_8fe0b7fd75012ab4 )
    {
        childthread unload_soundbank();
    }
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0x88404f13, Offset: 0x572
// Size: 0x1c
function private unload_soundbank()
{
    utility::waittill_notify_or_timeout( "br_c130_left_bounds", 30 );
    audio_utility::snd_transient_unload( "mp_gametype_gas_bomb_strikes" );
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xa84b9a, Offset: 0x596
// Size: 0xd1
function private function_c56e1dec2729fca3( gasbombstrike )
{
    level endon( #"game_ended" );
    var_3a552db7a0f65d25 = level.br_gas_bomb_strikes.var_3e3c6b0c245acaca[ gasbombstrike.var_a06740239ae5a7bb ];
    
    if ( !isdefined( var_3a552db7a0f65d25 ) )
    {
        assert( isdefined( var_3a552db7a0f65d25 ) );
        return;
    }
    
    target = var_3a552db7a0f65d25.targetpoi != "" ? var_3a552db7a0f65d25.targetpoi : "generic_target";
    
    if ( !has_valid_target( target, var_3a552db7a0f65d25.var_ce11805354916987 ) )
    {
        logdebug( "Target " + target + " not valid." );
        return;
    }
    
    thread launch_strike( var_3a552db7a0f65d25, var_3a552db7a0f65d25.targetposition );
    record_dlog( target );
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0x19d8b6f0, Offset: 0x66f
// Size: 0x6a
function private function_5186c3ae0b2287db( var_a06740239ae5a7bb, targetposition )
{
    assert( targetposition );
    var_3a552db7a0f65d25 = level.br_gas_bomb_strikes.var_3e3c6b0c245acaca[ var_a06740239ae5a7bb ];
    
    if ( !isdefined( var_3a552db7a0f65d25 ) )
    {
        assert( isdefined( var_3a552db7a0f65d25 ) );
        return;
    }
    
    thread launch_strike( var_3a552db7a0f65d25, targetposition );
    record_dlog( "generic_target" );
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0x291c2d0a, Offset: 0x6e1
// Size: 0xd9, Type: bool
function private has_valid_target( target, var_ce11805354916987 )
{
    foreach ( var_9e10e0a74ecc23ae in var_ce11805354916987 )
    {
        switch ( var_9e10e0a74ecc23ae.var_7079ec0e3e71ef2e )
        {
            case #"hash_e8be6a1a3cee7912":
                var_4cc39d3cd8cce4ff = br::function_71f55559ba3d9403();
                
                if ( arraycontains( var_4cc39d3cd8cce4ff, target ) )
                {
                    return false;
                }
                
                break;
            default:
                logdebug( "ForbiddenTargetType not handled." );
                break;
        }
    }
    
    return true;
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0x566ae5fa, Offset: 0x7c3
// Size: 0x34
function private spawn_vfx_emitter( var_3a552db7a0f65d25, targetposition )
{
    vfxemitter = spawnscriptable( var_3a552db7a0f65d25.var_edcf8a0f6ba8722f, targetposition );
    return vfxemitter;
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0xac6498b8, Offset: 0x800
// Size: 0xb4
function private launch_strike( var_3a552db7a0f65d25, targetposition )
{
    level endon( #"game_ended" );
    wait var_3a552db7a0f65d25.var_219a127a3fd56bae;
    vfxemitter = spawn_vfx_emitter( var_3a552db7a0f65d25, targetposition );
    vfxemitter setscriptablepartstate( "Main", "Visible" );
    wait var_3a552db7a0f65d25.explosiondelay;
    var_8c97ad4bc32fd489 = create_gas_trigger( var_3a552db7a0f65d25, targetposition );
    var_8c97ad4bc32fd489.vfxemitter = vfxemitter;
    level.br_gas_bomb_strikes.var_6167179e423161ce[ level.br_gas_bomb_strikes.var_6167179e423161ce.size ] = var_8c97ad4bc32fd489;
    var_8c97ad4bc32fd489 thread function_b27732c19987ff6d();
}

// Namespace br_gas_bomb_strike
// Params 2, eflags: 0x4
// Checksum 0x9e74dd51, Offset: 0x8bc
// Size: 0xed
function private create_gas_trigger( var_3a552db7a0f65d25, targetposition )
{
    var_d82e98411c7d4fbe = ( targetposition[ 0 ], targetposition[ 1 ], 0 );
    vfxposition = targetposition;
    gassettings = level.br_gas_bomb_strikes.gassettings[ var_3a552db7a0f65d25.gassettings ];
    gasheight = gassettings.height + targetposition[ 2 ];
    params = { #var_67323b79f803c91b:vfxposition };
    trigger = utility::callsharedfunc( #"gas", #"hash_87b583f48f67914e", gassettings.gastype, var_d82e98411c7d4fbe, undefined, undefined, var_3a552db7a0f65d25.duration, 1, undefined, gasheight, undefined, undefined, params );
    trigger.gastype = gassettings.gastype;
    return trigger;
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0x4c1fa0db, Offset: 0x9b2
// Size: 0xc
function private function_7ff5c943a0cb7059( trigger )
{
    
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0x44a4e48b, Offset: 0x9c6
// Size: 0xc
function private on_gas_exited( trigger )
{
    
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xfc238ea, Offset: 0x9da
// Size: 0x73
function private function_f7ccdd5d10f4102a( trigger )
{
    trigger function_bbb2fe6f43c64b57();
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_c7fbe704c9b37cf7( trigger, trigger.origin, trigger.radius );
        trigger.navobstacle = function_8bf6c5fe849106c4( trigger.origin, ( 0, 0, 0 ), 10, trigger.radius, 10000 );
    }
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0x4b2243ad, Offset: 0xa55
// Size: 0x72
function private function_50b7421f885f5bf1( trigger )
{
    trigger.vfxemitter freescriptable();
    trigger function_9a5b43c3e8b89ea7();
    level.br_gas_bomb_strikes.var_6167179e423161ce = arrayremove( level.br_gas_bomb_strikes.var_6167179e423161ce, trigger );
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_966b709c4f1e30c4( trigger );
        destroynavobstacle( trigger.navobstacle );
    }
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0xe98d991f, Offset: 0xacf
// Size: 0x38
function private function_b27732c19987ff6d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( function_27b6b7a7be4c4b8e( self ) )
        {
            destroy_gas( self );
            return;
        }
    }
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0x60445078, Offset: 0xb0f
// Size: 0x10a, Type: bool
function private function_27b6b7a7be4c4b8e( trigger )
{
    if ( level.br_circle_disabled )
    {
        return false;
    }
    
    var_6d5baab9981064b5 = trigger.radius;
    gasorigin = trigger.origin;
    circleorigins = br_circle_util::function_af7123cc5e0fb96c();
    circleradii = br_circle_util::function_1a92b7a87aa9aec6();
    
    foreach ( circleorigin in circleorigins )
    {
        var_12c1c09b9bfc6d2e = vectornormalize( gasorigin - circleorigin );
        var_95b06468949c0589 = gasorigin + var_12c1c09b9bfc6d2e * var_6d5baab9981064b5;
        var_9577befb0e6ce098 = br_circle_util::ispointinmulticircledanger( var_95b06468949c0589 );
        
        if ( var_9577befb0e6ce098 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0xda3f656, Offset: 0xc22
// Size: 0x43
function private function_bbb2fe6f43c64b57()
{
    self.var_baf50663916aa7ed = spawnquestcircle( "bomb_gas_strike", self.origin[ 0 ], self.origin[ 1 ], self.radius, undefined );
    self.var_baf50663916aa7ed show();
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0x1fa520e9, Offset: 0xc6d
// Size: 0x10
function private function_9a5b43c3e8b89ea7()
{
    self.var_baf50663916aa7ed hide();
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xeddd0594, Offset: 0xc85
// Size: 0x34
function private record_dlog( target )
{
    eventparams = [ "target", target ];
    dlog_recordevent( "dlog_event_br_gas_bomb_strike", eventparams );
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xaa930822, Offset: 0xcc1
// Size: 0x27
function private destroy_gas( trigger )
{
    trigger utility::callsharedfunc( #"gas", #"destroy_trigger" );
}

// Namespace br_gas_bomb_strike
// Params 0, eflags: 0x4
// Checksum 0x5dcf83a7, Offset: 0xcf0
// Size: 0x9a
function private function_e7e1ea6b0592647()
{
    foreach ( var_8c97ad4bc32fd489 in level.br_gas_bomb_strikes.var_6167179e423161ce )
    {
        destroy_gas( var_8c97ad4bc32fd489 );
    }
    
    level.br_gas_bomb_strikes.var_6167179e423161ce = [];
}

// Namespace br_gas_bomb_strike
// Params 1, eflags: 0x4
// Checksum 0xd79f0edf, Offset: 0xd92
// Size: 0x28
function private logdebug( message )
{
    println( "<dev string:x24>" + "<dev string:x26>" + "<dev string:x37>" + message );
}

/#

    // Namespace br_gas_bomb_strike
    // Params 0, eflags: 0x4
    // Checksum 0xfaa76827, Offset: 0xdc2
    // Size: 0x18, Type: dev
    function private debug_init()
    {
        function_d6bde015b923205f();
        br_dev::registerhandlecommand( &function_11d7b4eba66512a6 );
    }

    // Namespace br_gas_bomb_strike
    // Params 0, eflags: 0x4
    // Checksum 0x6fc438d4, Offset: 0xde2
    // Size: 0x128, Type: dev
    function private function_d6bde015b923205f()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3a>" + "<dev string:x26>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3e>", "<dev string:x53>", &function_564f49e72e5abb53 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x3a>" + "<dev string:x26>" + "<dev string:x6d>" );
        
        foreach ( hashassetname, _ in level.br_gas_bomb_strikes.var_3e3c6b0c245acaca )
        {
            assetfullname = getxhashsourcename( hashassetname );
            assetnametokens = strtok( assetfullname, "<dev string:x86>" );
            assetname = assetnametokens.size > 1 ? assetnametokens[ assetnametokens.size - 1 ] : assetfullname;
            devgui::function_cd4e263c1f3018ae( assetname, "<dev string:x88>" + assetname, &function_4d81e2ef13de0498 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_gas_bomb_strike
    // Params 1, eflags: 0x4
    // Checksum 0xb4b65f33, Offset: 0xf12
    // Size: 0x16, Type: dev
    function private function_564f49e72e5abb53( _ )
    {
        function_e7e1ea6b0592647();
    }

    // Namespace br_gas_bomb_strike
    // Params 2, eflags: 0x4
    // Checksum 0x74501918, Offset: 0xf30
    // Size: 0x5a, Type: dev
    function private function_11d7b4eba66512a6( command, args )
    {
        if ( command != "<dev string:xa0>" )
        {
            return;
        }
        
        scriptbundlename = args[ 0 ];
        
        if ( !scriptbundlename )
        {
            [ scriptbundlename ] = getscriptbundlenames( "<dev string:xb7>" );
        }
        
        function_8a364483adbaf3ff( scriptbundlename );
    }

    // Namespace br_gas_bomb_strike
    // Params 1, eflags: 0x4
    // Checksum 0xe1933b30, Offset: 0xf92
    // Size: 0x19, Type: dev
    function private function_4d81e2ef13de0498( params )
    {
        function_8a364483adbaf3ff( params[ 0 ] );
    }

    // Namespace br_gas_bomb_strike
    // Params 1, eflags: 0x4
    // Checksum 0xf2b63df2, Offset: 0xfb3
    // Size: 0x10a, Type: dev
    function private function_8a364483adbaf3ff( scriptbundlename )
    {
        if ( !isdefined( scriptbundlename ) )
        {
            assert( isdefined( scriptbundlename ) );
            return;
        }
        
        scriptbundlehash = isxhashasset( scriptbundlename ) ? scriptbundlename : hashcat( %"hash_5c49ff7c65dae3c1", scriptbundlename );
        bundle = level.br_gas_bomb_strikes.var_3e3c6b0c245acaca[ scriptbundlehash ];
        
        if ( !isdefined( bundle ) )
        {
            assert( isdefined( bundle ) );
            return;
        }
        
        if ( bundle.var_43e7b2b66b23f989 )
        {
            runtimetargetposition = player_utility::getplayerlookatpos( level.players[ 0 ] );
            
            if ( !isdefined( runtimetargetposition ) )
            {
                runtimetargetposition = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ] getplayerangles() ) * 2500;
            }
            
            thread function_5186c3ae0b2287db( scriptbundlehash, runtimetargetposition );
            return;
        }
        
        var_3f0a7f6605f5a958 = {};
        var_3f0a7f6605f5a958.var_a06740239ae5a7bb = scriptbundlehash;
        thread function_c56e1dec2729fca3( var_3f0a7f6605f5a958 );
    }

#/
