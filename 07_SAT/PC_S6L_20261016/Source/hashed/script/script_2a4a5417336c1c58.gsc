// script_2a4a5417336c1c58  (hash_2a4a5417336c1c58.gscc) (size: 7270 Bytes / 0x1c66 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x227f3c3b (578763835)
// size ...... 7270 (0x1c66)
// includes .. 6   (offset: 0x1bb2)
// strings ... 6   (offset: 0x1be2)
// dev strs .. 4   (offset: 0x1c32)
// exports ... 30  (offset: 0xf4a)
// cseg ...... 0xdf + 0xe6b (0xf4a)
// imports ... 67  (offset: 0x13fa)
// animtree1 . 0   (offset: 0x1c66)
// animtree2 . 0   (offset: 0x1c66)
#using script_ac28d65e8605696;
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_daf15362c2bc6ee0;

// Namespace namespace_daf15362c2bc6ee0
// Params 0, eflags: 0x5
// Checksum 0x6fd4680a, Offset: 0xfd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_9727e0d184482cd", undefined, undefined, &post_main );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 0, eflags: 0x4
// Checksum 0xaf0f7fba, Offset: 0x11e
// Size: 0x67
function private post_main()
{
    level.var_3d28f53244672d49 = [];
    callback::add( #"europa_activated", &on_activate );
    utility::registersharedfunc( #"europa", #"hash_28df9ffe0637327e", &function_8cbe02709eb81338 );
    utility::registersharedfunc( #"europa", #"hash_3ac6bb166921f4af", &function_b3a2e8914812e76d );
    
    /#
        debug_init();
    #/
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0x4
// Checksum 0x62e06197, Offset: 0x18d
// Size: 0x21
function private on_activate( params )
{
    self.europa.operating = 0;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 10
// Checksum 0xbdbe6f31, Offset: 0x1b6
// Size: 0x132
function function_8cbe02709eb81338( name, target, position, radius, angles, type, var_8ef7781f0cbd54b9, begincallback, successcallback, failcallback )
{
    if ( isstruct( name ) )
    {
        return function_86729cc9c0f84300( name );
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 100;
    }
    
    if ( !isdefined( position ) && isdefined( target ) )
    {
        position = target.origin;
    }
    
    if ( !isdefined( angles ) && isdefined( target ) )
    {
        angles = target.angles;
    }
    
    params = { #failcallback:failcallback, #successcallback:successcallback, #begincallback:begincallback, #var_8ef7781f0cbd54b9:var_8ef7781f0cbd54b9, #operatetype:type, #angles:angles, #radius:radius, #position:position, #target:target, #name:name };
    function_86729cc9c0f84300( params );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1
// Checksum 0xe2b0d8ec, Offset: 0x2f0
// Size: 0x24
function function_86729cc9c0f84300( params )
{
    level.var_3d28f53244672d49[ params.name ] = params;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1
// Checksum 0xefc44e21, Offset: 0x31c
// Size: 0x18
function function_b3a2e8914812e76d( name )
{
    level.var_3d28f53244672d49[ name ] = undefined;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1
// Checksum 0x51300058, Offset: 0x33c
// Size: 0xa8
function function_acd593afbb8bf67e( target )
{
    foreach ( var_386c01eb444cabb9 in level.var_3d28f53244672d49 )
    {
        if ( !isvector( target ) && var_386c01eb444cabb9.target == target || function_fe3c06c3ad48c86a( target, var_386c01eb444cabb9 ) )
        {
            return var_386c01eb444cabb9;
        }
    }
}

// Namespace namespace_daf15362c2bc6ee0
// Params 0
// Checksum 0x8aba9f16, Offset: 0x3ed
// Size: 0x15
function is_operating()
{
    return self.europa.operating;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 0
// Checksum 0x4fd0478d, Offset: 0x40b
// Size: 0x15
function is_operate_begin()
{
    return self.europa.operatingbegin;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1
// Checksum 0xf7e9e8d, Offset: 0x429
// Size: 0x15, Type: bool
function function_170c09b0fa122f9a( target )
{
    return isdefined( function_acd593afbb8bf67e( target ) );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 2
// Checksum 0xf8450afa, Offset: 0x447
// Size: 0x6b, Type: bool
function function_fe3c06c3ad48c86a( target, var_2214efba0b03a263 )
{
    pos = isvector( target ) ? target : target.origin;
    
    if ( !pos )
    {
        return false;
    }
    
    return distancesquared( pos, var_2214efba0b03a263.position ) <= var_2214efba0b03a263.radius * var_2214efba0b03a263.radius;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1
// Checksum 0x5a1d54aa, Offset: 0x4bb
// Size: 0x54
function function_74492292e039960b( target )
{
    var_386c01eb444cabb9 = function_acd593afbb8bf67e( target );
    
    if ( isdefined( var_386c01eb444cabb9 ) )
    {
        var_386c01eb444cabb9.commandpos = isvector( target ) ? target : target.origin;
        start_operate( var_386c01eb444cabb9 );
    }
}

// Namespace namespace_daf15362c2bc6ee0
// Params 0
// Checksum 0xeb21fd98, Offset: 0x517
// Size: 0x32
function stop_operate()
{
    if ( self.europa.var_f6d5db7778aa5cbe )
    {
        operate_fail( self.europa.var_f6d5db7778aa5cbe );
    }
}

// Namespace namespace_daf15362c2bc6ee0
// Params 0
// Checksum 0xab334f70, Offset: 0x551
// Size: 0x29
function function_2d05ab0168426123()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( is_operating() )
    {
        wait 1;
    }
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0x4
// Checksum 0xc1fcaf5e, Offset: 0x582
// Size: 0x39
function private start_operate( var_386c01eb444cabb9 )
{
    if ( is_operating() )
    {
        operate_fail( self.europa.var_f6d5db7778aa5cbe );
        return;
    }
    
    thread operate_thread( var_386c01eb444cabb9 );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0xc
// Checksum 0x7cf75e77, Offset: 0x5c3
// Size: 0x29a
function private operate_thread( var_386c01eb444cabb9 )
{
    self notify( #"hash_dd2242753bb12037" );
    self endon( #"hash_dd2242753bb12037" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_184874b290198094" );
    self notify( #"hash_6828fefa009be0fe", var_386c01eb444cabb9 );
    self.europa.operating = 1;
    self.europa.var_f6d5db7778aa5cbe = var_386c01eb444cabb9;
    logstring( "[EUROPA] Start operate: " + var_386c01eb444cabb9.name );
    val::set( #"europa", "ignoreall", 1 );
    pos = getclosestpointonnavmesh( var_386c01eb444cabb9.position, self );
    
    if ( !pos && var_386c01eb444cabb9.commandpos )
    {
        pos = var_386c01eb444cabb9.commandpos;
    }
    
    europa::move_to( pos, 0, {} );
    self waittill( #"europa_move_to_end", result );
    europa::function_47761cd429bc0244();
    self notify( #"hash_6581f960ad6a757", var_386c01eb444cabb9 );
    
    if ( !function_fe3c06c3ad48c86a( self, var_386c01eb444cabb9 ) )
    {
        operate_fail( var_386c01eb444cabb9 );
        return;
    }
    
    self.europa.operatingbegin = 1;
    
    if ( var_386c01eb444cabb9.var_8ef7781f0cbd54b9 )
    {
        thread europa_asm::play_scripted_anim( "idle" );
        warptime = 0.5;
        self motionwarp( var_386c01eb444cabb9.position, var_386c01eb444cabb9.angles, int( utility::function_4b74c15943231980( warptime ) ) );
        wait warptime;
        
        if ( self.origin != var_386c01eb444cabb9.position || self.angles != var_386c01eb444cabb9.angles )
        {
            self forceteleport( var_386c01eb444cabb9.position, var_386c01eb444cabb9.angles );
        }
        
        europa_asm::function_4d732b0c87bec23e();
    }
    
    europa::function_47761cd429bc0244();
    
    if ( !function_170c09b0fa122f9a( var_386c01eb444cabb9.target ) )
    {
        operate_fail( var_386c01eb444cabb9 );
        return;
    }
    
    if ( isdefined( var_386c01eb444cabb9.begincallback ) )
    {
        self [[ var_386c01eb444cabb9.begincallback ]]( var_386c01eb444cabb9 );
    }
    
    switch ( var_386c01eb444cabb9.operatetype )
    {
        case 1:
            operate_ground_smash( var_386c01eb444cabb9 );
            break;
        case 2:
            operate_pickup( var_386c01eb444cabb9 );
            break;
        default:
            break;
    }
    
    operate_success( var_386c01eb444cabb9 );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0xc
// Checksum 0x30009876, Offset: 0x865
// Size: 0x87
function private operate_pickup( var_386c01eb444cabb9 )
{
    self notify( #"hash_b416bb45456c622a" );
    self endon( #"hash_b416bb45456c622a" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_6828fefa009be0fe" );
    utility::callsharedfunc( #"europa", #"hash_64cb0fdb3b92bee7", { #target:var_386c01eb444cabb9.target } );
    utility::waittill_any_timeout( 8, "europa_pick_whistle_end" );
    wait 1;
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0x4
// Checksum 0x22e27da3, Offset: 0x8f4
// Size: 0xa3
function private operate_success( var_386c01eb444cabb9 )
{
    logstring( "[EUROPA] Operate success: " + var_386c01eb444cabb9.name );
    
    if ( isdefined( var_386c01eb444cabb9.successcallback ) )
    {
        self [[ var_386c01eb444cabb9.successcallback ]]( var_386c01eb444cabb9 );
    }
    
    self.europa.operating = 0;
    self.europa.operatingbegin = 0;
    self.europa.var_f6d5db7778aa5cbe = undefined;
    val::set( #"europa", "ignoreall", 0 );
    self notify( #"hash_abc966d3cdb0b6f0", var_386c01eb444cabb9 );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0x4
// Checksum 0xadcc227d, Offset: 0x99f
// Size: 0xa3
function private operate_fail( var_386c01eb444cabb9 )
{
    logstring( "[EUROPA] Operate failed: " + var_386c01eb444cabb9.name );
    
    if ( isdefined( var_386c01eb444cabb9.failcallback ) )
    {
        self [[ var_386c01eb444cabb9.failcallback ]]( var_386c01eb444cabb9 );
    }
    
    self.europa.operating = 0;
    self.europa.operatingbegin = 0;
    self.europa.var_f6d5db7778aa5cbe = undefined;
    val::set( #"europa", "ignoreall", 0 );
    self notify( #"hash_184874b290198094", var_386c01eb444cabb9 );
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0xc
// Checksum 0xa8f382ad, Offset: 0xa4a
// Size: 0xc7
function private operate_ground_smash( var_386c01eb444cabb9 )
{
    self notify( #"hash_b8579a80b1058770" );
    self endon( #"hash_b8579a80b1058770" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_6828fefa009be0fe" );
    
    if ( !callback::exists( #"hash_a22cade132a5709e", &function_bd594cb0ad1cf8c1 ) )
    {
        callback::add( #"hash_a22cade132a5709e", &function_bd594cb0ad1cf8c1 );
    }
    
    utility::callsharedfunc( #"europa", #"hash_daff0d3946426012" );
    self waittill( #"hash_f1b5ec4f83e6a6d5" );
    
    if ( callback::exists( #"hash_a22cade132a5709e", &function_bd594cb0ad1cf8c1 ) )
    {
        callback::remove( #"hash_a22cade132a5709e", &function_bd594cb0ad1cf8c1 );
    }
}

// Namespace namespace_daf15362c2bc6ee0
// Params 1, eflags: 0x4
// Checksum 0xe127eb74, Offset: 0xb19
// Size: 0x18
function private function_bd594cb0ad1cf8c1( params )
{
    self notify( #"hash_f1b5ec4f83e6a6d5" );
}

/#

    // Namespace namespace_daf15362c2bc6ee0
    // Params 0, eflags: 0x4
    // Checksum 0x34c2bba7, Offset: 0xb39
    // Size: 0x4b, Type: dev
    function private debug_init()
    {
        if ( getdvarint( @"hash_68468fbf29519d87" ) )
        {
            if ( !level callback::exists( #"on_ping", &debug_on_pinged ) )
            {
                level callback::add( #"on_ping", &debug_on_pinged );
            }
        }
        
        thread function_30d4565d0fef2d45();
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 1, eflags: 0x4
    // Checksum 0xf6eada06, Offset: 0xb8c
    // Size: 0xf2, Type: dev
    function private debug_on_pinged( params )
    {
        player = params.player;
        calloutent = player calloutmarkerping_getent( params.pingindex );
        
        if ( isdefined( calloutent ) && !function_acd593afbb8bf67e( calloutent ) && !isai( calloutent ) && !isai( calloutent.entity ) )
        {
            fwd = anglestoforward( calloutent.angles );
            pos = calloutent.origin + fwd * 30;
            angles = vectortoangles( fwd * -1 );
            utility::callsharedfunc( #"europa", #"hash_28df9ffe0637327e", "<dev string:x24>", calloutent, pos, 100, angles, 2, 1, &function_13906ce1fdbc284e, &function_89d92aa7a2b8e080, &function_f1ded49af226cf7d );
        }
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 1, eflags: 0x4
    // Checksum 0x28ebb01c, Offset: 0xc86
    // Size: 0x25, Type: dev
    function private function_13906ce1fdbc284e( params )
    {
        logstring( "<dev string:x35>" + params.name );
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 1, eflags: 0x4
    // Checksum 0x890d78db, Offset: 0xcb3
    // Size: 0x43, Type: dev
    function private function_89d92aa7a2b8e080( params )
    {
        logstring( "<dev string:x4d>" + params.name );
        utility::callsharedfunc( #"europa", #"hash_3ac6bb166921f4af", "<dev string:x24>" );
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 1, eflags: 0x4
    // Checksum 0x7504cac3, Offset: 0xcfe
    // Size: 0x25, Type: dev
    function private function_f1ded49af226cf7d( params )
    {
        logstring( "<dev string:x67>" + params.name );
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 0, eflags: 0x4
    // Checksum 0xef606f03, Offset: 0xd2b
    // Size: 0xa3, Type: dev
    function private function_30d4565d0fef2d45()
    {
        level endon( #"end_game" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_158d61374ebb2a49" ) )
            {
                foreach ( var_386c01eb444cabb9 in level.var_3d28f53244672d49 )
                {
                    function_b5867f1421697f04( var_386c01eb444cabb9 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 1, eflags: 0x4
    // Checksum 0x55550956, Offset: 0xdd6
    // Size: 0xbd, Type: dev
    function private function_b5867f1421697f04( var_386c01eb444cabb9 )
    {
        color = ( 1, 1, 0 );
        forward = anglestoforward( var_386c01eb444cabb9.angles );
        line( var_386c01eb444cabb9.position, var_386c01eb444cabb9.position + forward * var_386c01eb444cabb9.radius, color );
        function_564ffaa01213f1bc( var_386c01eb444cabb9.position, var_386c01eb444cabb9.radius, color, 1 );
        
        if ( isdefined( var_386c01eb444cabb9.target ) )
        {
            sphere( var_386c01eb444cabb9.target.origin, 10, color, 1 );
        }
    }

    // Namespace namespace_daf15362c2bc6ee0
    // Params 4, eflags: 0x4
    // Checksum 0xd7dfbadd, Offset: 0xe9b
    // Size: 0xaf, Type: dev
    function private function_564ffaa01213f1bc( origin, radius, color, timeseconds )
    {
        numsegments = 16;
        i = 0;
        
        while ( i < 360 )
        {
            j = i + 360 / numsegments;
            thread utility::draw_line_for_time( origin + ( radius * cos( i ), radius * sin( i ), 0 ), origin + ( radius * cos( j ), radius * sin( j ), 0 ), color[ 0 ], color[ 1 ], color[ 2 ], timeseconds );
            i += 360 / numsegments;
        }
    }

#/
