// scripts\mp\zm\ztron\ztron_camera.gsc  (hash_407972ed40797fe5.gscc) (size: 18435 Bytes / 0x4803 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7053ae3 (3875879651)
// size ...... 18435 (0x4803)
// includes .. 12  (offset: 0x428b)
// strings ... 52  (offset: 0x42eb)
// dev strs .. 45  (offset: 0x45e3)
// exports ... 61  (offset: 0x2b03)
// cseg ...... 0x4cd + 0x2636 (0x2b03)
// imports ... 110 (offset: 0x348b)
// animtree1 . 0   (offset: 0x4803)
// animtree2 . 0   (offset: 0x4803)
#using script_31ee2a173f3499b7;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_camera;

// Namespace ztron_camera
// Params 0
// Checksum 0x529f096, Offset: 0x4eb
// Size: 0x1b
function init()
{
    /#
        function_ac7ee3673d6e340d();
    #/
    
    reset_variables();
    level thread function_42ee07a243e9f10e();
}

// Namespace ztron_camera
// Params 0
// Checksum 0x99866d7b, Offset: 0x50e
// Size: 0x7a
function function_42ee07a243e9f10e()
{
    while ( true )
    {
        level utility::waittill_any( "arena_initialized", "bonus_room_expired", "bonus_room_exit_taken" );
        
        if ( isdefined( level.ztron.active_arena.center.origin ) )
        {
            function_740408a841dcb4a5( level.ztron.active_arena.center.origin );
        }
    }
}

// Namespace ztron_camera
// Params 1
// Checksum 0x9f91bda9, Offset: 0x590
// Size: 0x27
function function_740408a841dcb4a5( var_5290e343e7cabade )
{
    setomnvar( "topdown_camera_center_pos_x", var_5290e343e7cabade[ 0 ] );
    setomnvar( "topdown_camera_center_pos_y", var_5290e343e7cabade[ 1 ] );
}

// Namespace ztron_camera
// Params 0
// Checksum 0xd9467d79, Offset: 0x5bf
// Size: 0x9
function function_f1184b51b6e0083d()
{
    camera_default();
}

// Namespace ztron_camera
// Params 0
// Checksum 0x9c7fab3e, Offset: 0x5d0
// Size: 0x1d
function camera_default()
{
    function_79d64be315aa51c9( 1 );
    function_55ff170984e4b286( 1 );
    function_e907a99451bc212c( 1 );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x63db1ad1, Offset: 0x5f5
// Size: 0x22
function function_55ff170984e4b286( mode )
{
    self.ztron.favoritecameramode = mode;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x53aee501, Offset: 0x61f
// Size: 0x22
function function_e907a99451bc212c( mode )
{
    self.ztron.var_f0702c81e06af50 = mode;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x8fe20f47, Offset: 0x649
// Size: 0x25
function function_9d2ce447580a6290( needhint = 1 )
{
    function_79d64be315aa51c9( function_3cc9282ac7d95b92(), 0, needhint );
}

// Namespace ztron_camera
// Params 1
// Checksum 0xf92b3e0, Offset: 0x676
// Size: 0x25
function function_9d5a55b239f1315a( needhint = 1 )
{
    function_79d64be315aa51c9( function_87270944e0a059a8(), 0, needhint );
}

// Namespace ztron_camera
// Params 0
// Checksum 0x3ac60ca7, Offset: 0x6a3
// Size: 0x1a, Type: bool
function function_3cc9282ac7d95b92()
{
    return self.ztron.favoritecameramode ?? 1;
}

// Namespace ztron_camera
// Params 0
// Checksum 0x6c9b2530, Offset: 0x6c6
// Size: 0x1a, Type: bool
function function_87270944e0a059a8()
{
    return self.ztron.var_f0702c81e06af50 ?? 1;
}

// Namespace ztron_camera
// Params 3
// Checksum 0xefabce58, Offset: 0x6e9
// Size: 0x154
function function_79d64be315aa51c9( mode = 1, force = 0, needhint = 1 )
{
    if ( !ztron_player_utility::function_a120489ddd3aa5ce() )
    {
        return;
    }
    
    if ( ztron_player_utility::isplayerspectating() )
    {
        return;
    }
    
    if ( !isdefined( self.ztron ) )
    {
        return;
    }
    
    if ( !force )
    {
        if ( !level.ztron.var_e1b2540e2c81f811 && level.ztron.var_74a3707334cfe144 || self.ztron.var_74a3707334cfe144 )
        {
            mode = 4;
        }
    }
    
    self.ztron.var_a46fa357ac82e4a = mode;
    var_4e63d1b535a5c79 = function_4963ef31446ec8d9( mode );
    self.ztron.var_a4c2f70bbc713f98 = !var_4e63d1b535a5c79;
    self.ignoredeathsdoor = var_4e63d1b535a5c79;
    
    if ( self.ignoredeathsdoor )
    {
        damage_effects::onexitdeathsdoor( 1 );
    }
    
    enabletopdown( var_4e63d1b535a5c79 );
    self setclientomnvar( "topdown_camera_mode", mode );
    
    if ( var_4e63d1b535a5c79 )
    {
        function_1873609edbd36982();
    }
    else
    {
        thread function_3f5f4767374bb6c7();
    }
    
    if ( needhint )
    {
        function_957a029acd88992d( mode );
    }
    
    self notify( #"topdown_camera_changed", var_4e63d1b535a5c79 );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x7559c11c, Offset: 0x845
// Size: 0xae
function function_957a029acd88992d( mode )
{
    if ( !isdefined( mode ) )
    {
        return;
    }
    
    messageref = "";
    
    switch ( mode )
    {
        case 0:
            messageref = "CAM_MODE_LOW";
            break;
        case 1:
            messageref = "CAM_MODE_STANDARD";
            break;
        case 2:
            messageref = "CAM_MODE_HIGH";
            break;
        case 3:
            messageref = "CAM_MODE_EXTRA_HIGH";
            break;
        default:
            break;
    }
    
    if ( messageref != "" )
    {
        ztron_ui::function_787d89891b886acf( messageref, 2, 1 );
    }
}

// Namespace ztron_camera
// Params 1
// Checksum 0x3830e95d, Offset: 0x8fb
// Size: 0x84
function function_e53bf7020d2f155d( value )
{
    if ( !self isconnected() )
    {
        return;
    }
    
    pitch = 75;
    
    if ( value != 0 )
    {
        pitch = 5;
        
        if ( value == 2 )
        {
            function_79d64be315aa51c9( 0 );
        }
        else if ( value == 3 )
        {
            function_79d64be315aa51c9( 1 );
        }
        else if ( value == 4 )
        {
            pitch = getdvarfloat( @"hash_5d510649e72a9c5a", 60 );
            function_79d64be315aa51c9( 6 );
        }
    }
    
    function_493424525b419e28( pitch );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x5172b81c, Offset: 0x987
// Size: 0x2f
function function_493424525b419e28( value )
{
    self setclientomnvar( "topdown_camera_pitch", value );
    self.ztron.camera_pitch = value;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x13eaa590, Offset: 0x9be
// Size: 0x8c
function function_94c683cd71e7ae65( value )
{
    if ( value )
    {
        maxval = 63;
        var_126caf91eef9e1f3 = value / maxval;
        var_a014b1de074d1b54 = math::lerp( 75, 95, var_126caf91eef9e1f3 );
        self setclientomnvar( "topdown_camera_pitch", var_a014b1de074d1b54 );
        self.ztron.camera_pitch = var_a014b1de074d1b54;
        return;
    }
    
    self setclientomnvar( "topdown_camera_pitch", 75 );
    self.ztron.camera_pitch = 75;
}

// Namespace ztron_camera
// Params 2
// Checksum 0x9df66a33, Offset: 0xa52
// Size: 0x83
function function_90951f3fca05e46a( origin, angles )
{
    if ( !isdefined( level.ztron.var_3fde0581821de071 ) )
    {
        level.ztron.var_3fde0581821de071 = spawnstruct();
    }
    
    level.ztron.var_3fde0581821de071.origin = origin;
    level.ztron.var_3fde0581821de071.angles = angles;
}

// Namespace ztron_camera
// Params 0
// Checksum 0x9f3ee74b, Offset: 0xadd
// Size: 0x9b
function function_b75a71ef33e0e6cc()
{
    if ( !isdefined( level.ztron.var_3fde0581821de071 ) )
    {
        level.ztron.var_3fde0581821de071 = spawnstruct();
    }
    
    level.ztron.var_3fde0581821de071.origin = ( 0, 0, 0 );
    level.ztron.var_3fde0581821de071.angles = ( 0, 0, 0 );
    level.ztron.var_b25ff0c59f404fc9 = 0;
}

// Namespace ztron_camera
// Params 0, eflags: 0x4
// Checksum 0x7aa9017b, Offset: 0xb80
// Size: 0x4b
function private reset_variables()
{
    function_b75a71ef33e0e6cc();
    level.ztron.defaultcameramode = 1;
    
    if ( level.ztron.var_74a3707334cfe144 )
    {
        level.ztron.defaultcameramode = 4;
    }
}

// Namespace ztron_camera
// Params 0
// Checksum 0x8115c02, Offset: 0xbd3
// Size: 0x1f7
function function_1873609edbd36982()
{
    var_a46fa357ac82e4a = self.ztron.var_a46fa357ac82e4a;
    height = function_903ad0895928478e( var_a46fa357ac82e4a );
    var_3262faaf98730055 = function_b8ca4a67e46eaaa6( var_a46fa357ac82e4a );
    self setclientomnvar( "topdown_camera_range", height );
    self setclientomnvar( "topdown_camera_range_lean_center_scale", var_3262faaf98730055 );
    
    if ( var_a46fa357ac82e4a == 5 )
    {
        self setclientomnvar( "topdown_camera_is_affected_by_center_pos", 0 );
        assert( isdefined( level.ztron.var_3fde0581821de071 ) );
        var_f8dad7f191e8f7cc = level.ztron.var_3fde0581821de071.origin;
        angles = level.ztron.var_3fde0581821de071.angles;
        
        if ( !isdefined( self.ztron.scriptedcam ) )
        {
            self.ztron.scriptedcam = spawn( "script_model", var_f8dad7f191e8f7cc );
            self.ztron.scriptedcam setmodel( "tag_origin" );
            self cameralinkto( self.ztron.scriptedcam, "tag_origin", 1, 1 );
        }
        
        self.ztron.scriptedcam moveto( var_f8dad7f191e8f7cc, 0.1 );
        self.ztron.scriptedcam.angles = angles;
        self.last_camera_pos = var_f8dad7f191e8f7cc;
        self.last_camera_angles = angles;
        return;
    }
    
    self setclientomnvar( "topdown_camera_is_affected_by_center_pos", istrue( level.ztron.var_b25ff0c59f404fc9 ) );
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 || ztron_main::function_4da200e9b8d58a3c() == 0 )
    {
        self setclientomnvar( "topdown_camera_is_affected_by_center_pos", 1 );
    }
    
    thread function_3f5f4767374bb6c7();
}

// Namespace ztron_camera
// Params 1
// Checksum 0x1c4fe59e, Offset: 0xdd2
// Size: 0x11, Type: bool
function function_4963ef31446ec8d9( mode )
{
    return mode != 4;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x3f03850d, Offset: 0xdec
// Size: 0x1c8
function enabletopdown( enable )
{
    if ( self function_acbf60ca18b9864b() == enable )
    {
        return;
    }
    
    self function_1791326025cc0de6( enable );
    
    if ( enable )
    {
        val::set( "topdowncamera", "sprint", !enable );
        val::set( "topdowncamera", "allow_jump", !enable || level.ztron.var_e65fc3d0de638a87 );
        val::set( "topdowncamera", "ads", !enable );
        val::set( "topdowncamera", "prone", !enable );
        val::set( "topdowncamera", "crouch", !enable || level.ztron.var_eada0e62460405c1 );
        val::set( "topdowncamera", "melee", !enable );
        val::set( "topdowncamera", "offhand_primary_weapons", !enable );
        val::set( "topdowncamera", "offhand_secondary_weapons", !enable );
        val::set( "topdowncamera", "mantle", !enable );
        val::set( "topdowncamera", "mount_side", !enable );
        val::set( "topdowncamera", "mount_top", !enable );
        val::set( "topdowncamera", "swimming_sprint", !enable );
        val::set( "topdowncamera", "dtp", !enable );
        val::set( "topdowncamera", "swimming_underwater", !enable );
        val::set( "topdowncamera", "swimming_jump", !enable );
        return;
    }
    
    val::reset_all( "topdowncamera" );
    val::set( "topdowncamera", "offhand_primary_weapons", enable );
    val::set( "topdowncamera", "offhand_secondary_weapons", enable );
    val::set( "topdowncamera", "ads", !enable );
}

// Namespace ztron_camera
// Params 2
// Checksum 0xfc97d66a, Offset: 0xfbc
// Size: 0x6a
function flipTopdownCamera( mode = 0, reset = 0 )
{
    if ( reset )
    {
        self function_3f88f030cac9aa4b( 0 );
        self.ztron.var_13805a047e18bac9 = 0;
        return;
    }
    
    self.ztron.var_13805a047e18bac9 = mode;
    self function_3f88f030cac9aa4b( mode == 1 );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x3cd5f8aa, Offset: 0x102e
// Size: 0x2f
function function_74296609ac79a40d( yaw )
{
    self.ztron.camera_yaw_ext = yaw;
    self setclientomnvar( "topdown_camera_yaw_ext", yaw );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x2609402f, Offset: 0x1065
// Size: 0x2f
function function_a13b43697fdb6f43( zoffset )
{
    self.ztron.camera_z_offset = zoffset;
    self setclientomnvar( "topdown_camera_z_offset", zoffset );
}

// Namespace ztron_camera
// Params 1, eflags: 0x4
// Checksum 0x181661f8, Offset: 0x109c
// Size: 0x125
function private function_903ad0895928478e( mode )
{
    if ( !isdefined( mode ) )
    {
        return 650;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        if ( isdefined( level.ztron.var_c8e8ffbf87a3fba ) )
        {
            height = [[ level.ztron.var_c8e8ffbf87a3fba ]]( mode );
            
            if ( isdefined( height ) )
            {
                return height;
            }
        }
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( isdefined( level.ztron.var_845785fe1acb998a ) )
        {
            height = [[ level.ztron.var_845785fe1acb998a ]]( mode );
            
            if ( isdefined( height ) )
            {
                return height;
            }
        }
    }
    
    switch ( mode )
    {
        case 0:
            return 400;
        case 1:
            return 650;
        case 2:
            return 850;
        case 3:
            return 1050;
        case 6:
            return getdvarfloat( @"hash_5c9d709dcefa07e7", 1200 );
        default:
            return 650;
    }
}

// Namespace ztron_camera
// Params 1, eflags: 0x4
// Checksum 0x3cfda283, Offset: 0x11c9
// Size: 0x126
function private function_b8ca4a67e46eaaa6( mode )
{
    if ( !isdefined( mode ) )
    {
        return 1;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        if ( isdefined( level.ztron.var_465e06d2221e50da ) )
        {
            scale = [[ level.ztron.var_465e06d2221e50da ]]( mode );
            
            if ( isdefined( scale ) )
            {
                return scale;
            }
        }
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( isdefined( level.ztron.var_19104e5e9d7f256a ) )
        {
            scale = [[ level.ztron.var_19104e5e9d7f256a ]]( mode );
            
            if ( isdefined( scale ) )
            {
                return scale;
            }
        }
    }
    
    switch ( mode )
    {
        case 0:
            return 0.4;
        case 1:
            return 1;
        case 2:
            return 1.6;
        case 3:
            return 2.2;
        case 6:
            return 1;
        default:
            return 1;
    }
}

// Namespace ztron_camera
// Params 1
// Checksum 0xd81aa5f1, Offset: 0x12f7
// Size: 0x4e
function function_be3daddd800c42b3( curmode = 1 )
{
    curmode--;
    maxselectable = 3;
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
    {
        maxselectable = 2;
    }
    
    if ( curmode < 0 )
    {
        curmode = maxselectable;
    }
    
    return curmode;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x769c392d, Offset: 0x134e
// Size: 0x4d
function function_9e0e667097229f7b( curmode = 1 )
{
    curmode++;
    maxselectable = 3;
    
    if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) )
    {
        maxselectable = 2;
    }
    
    if ( curmode > maxselectable )
    {
        curmode = 0;
    }
    
    return curmode;
}

// Namespace ztron_camera
// Params 0
// Checksum 0x27ff3121, Offset: 0x13a4
// Size: 0x24
function function_45b3c6e393d142a7()
{
    if ( self.ztron.var_a46fa357ac82e4a > 2 )
    {
        function_79d64be315aa51c9( 2 );
    }
}

// Namespace ztron_camera
// Params 0
// Checksum 0x6a7df31, Offset: 0x13d0
// Size: 0xba
function function_d0ea3a7f3f025351()
{
    newcameramode = 0;
    
    if ( self.ztron.score.lives <= 0 )
    {
        newcameramode = 3;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        if ( level.ztron.var_8a9067aa4cd65369.type == "side_scroller_player" || level.ztron.var_8a9067aa4cd65369.type == "side_scroller_helo" || level.ztron.var_8a9067aa4cd65369.type == "fall_100" )
        {
            newcameramode = 0;
        }
    }
    
    return newcameramode;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x9fd0eee6, Offset: 0x1493
// Size: 0x11, Type: bool
function function_437577293a7cbb75( var_a46fa357ac82e4a )
{
    return var_a46fa357ac82e4a <= 3;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x141c70d0, Offset: 0x14ad
// Size: 0x76
function function_c84d3066c4f2d6fc( var_b7efc25b0b2e74c6 )
{
    fallbackcamera = var_b7efc25b0b2e74c6 ?? self.ztron.var_a46fa357ac82e4a;
    var_32bcb3111caf51fb = function_437577293a7cbb75( fallbackcamera );
    
    if ( var_32bcb3111caf51fb )
    {
        self.ztron.var_8e5c9b20774ccee9 = fallbackcamera;
    }
    
    newcameramode = function_d0ea3a7f3f025351();
    function_79d64be315aa51c9( newcameramode );
}

// Namespace ztron_camera
// Params 0
// Checksum 0xa0a0f90c, Offset: 0x152b
// Size: 0x2f
function function_28677b8eaecd3c2d()
{
    function_79d64be315aa51c9( self.ztron.var_8e5c9b20774ccee9 );
    self.ztron.var_8e5c9b20774ccee9 = undefined;
}

// Namespace ztron_camera
// Params 1
// Checksum 0x4f4e5bba, Offset: 0x1562
// Size: 0x18
function function_a33f5a3220dee73e( enable )
{
    setomnvar( "topdown_camera_use_ground_normal_for_pitch", enable );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x25717c6b, Offset: 0x1582
// Size: 0x8e
function function_517f03fc102b896d( skiplerp )
{
    profilestart();
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_9fbc0b40b3c0f437( skiplerp );
        }
    }
    
    profilestop();
}

// Namespace ztron_camera
// Params 1
// Checksum 0xdeb9b3a1, Offset: 0x1618
// Size: 0x1d
function function_9fbc0b40b3c0f437( skiplerp )
{
    self setclientdvar( @"hash_b2b0bb001922f393", skiplerp );
}

// Namespace ztron_camera
// Params 1
// Checksum 0xf2f20638, Offset: 0x163d
// Size: 0x44
function function_d5969d200777318d( time )
{
    self notify( #"hash_cf19953a099cf18" );
    self endon( #"hash_cf19953a099cf18" );
    self endon( #"disconnect" );
    function_9fbc0b40b3c0f437( 1 );
    wait time;
    function_9fbc0b40b3c0f437( 0 );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x91442495, Offset: 0x1689
// Size: 0x8a
function function_672265518094104d( var_6f39e8db6acdf274 )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_e4951d704daaa62f( var_6f39e8db6acdf274 );
        }
    }
}

// Namespace ztron_camera
// Params 2
// Checksum 0xd15c39d3, Offset: 0x171b
// Size: 0x265
function function_c41bb4f128ee8d5b( timeout, forced )
{
    self notify( #"hash_a1fd3983ca93ac7e" );
    self endon( #"hash_a1fd3983ca93ac7e" );
    self endon( #"disconnect" );
    self endon( #"hash_463ac41b7bf90869" );
    thread function_6c4bbd27a4a8dedb();
    result = undefined;
    
    if ( timeout == -1 )
    {
        result = utility::waittill_any_return_params( "ztron_camera_changed", "ztron_playerDumpFPS" );
    }
    else
    {
        timeout = ztron_player_utility::function_10777122eee28fa8( timeout );
        result = utility::waittill_any_return_params_or_timeout( timeout, "ztron_camera_changed", "ztron_playerDumpFPS" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( forced )
    {
        if ( !result[ 0 ].clearforced || !level.ztron.var_e1b2540e2c81f811 && level.ztron.var_74a3707334cfe144 )
        {
            thread function_c41bb4f128ee8d5b( timeout, forced );
        }
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_1p_outro_OS", self.origin );
    utility::function_7c10ea82c1e305b8( "ztron_player_heads_up", "off" );
    thread function_2dd89834006b4be5( 0.2 );
    
    if ( self.inlaststand )
    {
        var_aedbd039179e5154 = ztron_main::function_4da200e9b8d58a3c() == 5 ? function_87270944e0a059a8() : function_3cc9282ac7d95b92();
        function_c84d3066c4f2d6fc( var_aedbd039179e5154 );
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        function_9d5a55b239f1315a();
    }
    else
    {
        function_9d2ce447580a6290();
    }
    
    thread ztron_player_utility::function_985a085be4ea0ba4();
    thread function_deddb681669a273b();
    cam_range = function_903ad0895928478e( self.ztron.var_a46fa357ac82e4a );
    var_3910ba256445821 = self.origin + ( 0, 0, 72 );
    cam_origin_angles = self.angles;
    cam_target_angles = ( self.ztron.camera_pitch ?? 75, self.ztron.var_13805a047e18bac9 == 1 ? 180 : 0, 0 );
    cam_target_pos = self.origin - anglestoforward( cam_target_angles ) * cam_range;
    function_7d04971d3595278( var_3910ba256445821, cam_origin_angles );
    waitframe();
    childthread function_8d844ce10ccd8a0( cam_target_angles, cam_target_pos );
    wait 0.2;
    ztron_score::function_4ea454cb6435a318();
    ztron_player_utility::function_1bb9b2e327c29632( self );
}

// Namespace ztron_camera
// Params 2, eflags: 0x4
// Checksum 0x7f91c99f, Offset: 0x1988
// Size: 0x50
function private function_8d844ce10ccd8a0( cam_target_angles, cam_target_pos )
{
    self endon( #"hash_2cb65a9e19437b27" );
    thread function_c55643e3b7249305( cam_target_angles, 0.1 );
    wait 0.05;
    thread function_cf86d241b76bf777( cam_target_pos, 0.15 );
    wait 0.15;
    thread function_3f5f4767374bb6c7();
}

// Namespace ztron_camera
// Params 0, eflags: 0xc
// Checksum 0x5403064f, Offset: 0x19e0
// Size: 0x47
function private function_deddb681669a273b()
{
    self notify( #"hash_dbb53ec6ee98c40" );
    self endon( #"hash_dbb53ec6ee98c40" );
    self endon( #"disconnect" );
    ztron_player_utility::freezeplayercontrols( 1 );
    wait level.framedurationseconds + 0.2;
    ztron_player_utility::freezeplayercontrols( 0 );
}

// Namespace ztron_camera
// Params 2
// Checksum 0x72dccb40, Offset: 0x1a2f
// Size: 0x133
function function_7d04971d3595278( pos, angle )
{
    profilestart();
    self notify( #"hash_2cb65a9e19437b27" );
    
    if ( !isdefined( self.ztron.scriptedcam ) )
    {
        self.ztron.scriptedcam = spawn( "script_model", pos );
        self.ztron.scriptedcam setmodel( "tag_origin" );
        self cameralinkto( self.ztron.scriptedcam, "tag_origin", 1, 1 );
        assert( isdefined( self.ztron.scriptedcam ), "<dev string:x24>" );
        self.ztron.scriptedcam thread ztron_util::function_1544885c712921f8( self );
    }
    
    self.ztron.scriptedcam.nodelete = 0;
    self.ztron.scriptedcam moveto( pos, 0.01 );
    self.ztron.scriptedcam.angles = angle;
    profilestop();
}

// Namespace ztron_camera
// Params 2, eflags: 0x4
// Checksum 0x49f6b1dc, Offset: 0x1b6a
// Size: 0x139
function private function_cf86d241b76bf777( var_50dad689fa4b51ec, movetime )
{
    assert( isdefined( self.ztron.scriptedcam ), "<dev string:x24>" );
    self endon( #"disconnect" );
    self endon( #"hash_2cb65a9e19437b27" );
    
    if ( isdefined( self.ztron.scriptedcam ) )
    {
        self.ztron.scriptedcam endon( #"death" );
        self.ztron.scriptedcam.nodelete += 1;
        self.ztron.scriptedcam moveto( var_50dad689fa4b51ec, movetime );
        self.ztron.scriptedcam waittill( #"movedone" );
        self.ztron.scriptedcam.nodelete -= 1;
    }
}

// Namespace ztron_camera
// Params 2, eflags: 0x4
// Checksum 0x3d485762, Offset: 0x1cab
// Size: 0x139
function private function_c55643e3b7249305( var_8c977e5e5fd3d71d, rotatetime )
{
    assert( isdefined( self.ztron.scriptedcam ), "<dev string:x4f>" );
    self endon( #"disconnect" );
    self endon( #"hash_2cb65a9e19437b27" );
    
    if ( isdefined( self.ztron.scriptedcam ) )
    {
        self.ztron.scriptedcam endon( #"death" );
        self.ztron.scriptedcam.nodelete += 1;
        self.ztron.scriptedcam rotateto( var_8c977e5e5fd3d71d, rotatetime );
        self.ztron.scriptedcam waittill( #"rotatedone" );
        self.ztron.scriptedcam.nodelete -= 1;
    }
}

// Namespace ztron_camera
// Params 0
// Checksum 0xdd32dfc5, Offset: 0x1dec
// Size: 0xc4
function function_3f5f4767374bb6c7()
{
    self notify( #"hash_fa2cd845eb2153dc" );
    self endon( #"hash_fa2cd845eb2153dc" );
    self endon( #"hash_2cb65a9e19437b27" );
    self endon( #"disconnect" );
    
    if ( isdefined( self.ztron.scriptedcam ) )
    {
        ztron_debug::debugmsg( "---$ ScriptedCam deletion is requested" );
        
        while ( self.ztron.scriptedcam.nodelete > 0 )
        {
            ztron_debug::debugmsg( "---$ ScriptedCam deletion is blocked currently, waiting a frame!" );
            waitframe();
        }
        
        self cameraunlink();
        self.ztron.scriptedcam delete();
        self.ztron.scriptedcam = undefined;
        self notify( #"hash_1599cd8faf59a8ce" );
    }
}

// Namespace ztron_camera
// Params 0, eflags: 0xc
// Checksum 0x902c499f, Offset: 0x1eb8
// Size: 0x5e
function private function_6c4bbd27a4a8dedb()
{
    self notify( #"hash_8e80c0f7ec62e1f9" );
    self endon( #"hash_8e80c0f7ec62e1f9" );
    self endon( #"disconnect" );
    self endon( #"ztron_playerdumpfps" );
    utility::waittill_any( "ztron_exit_taken", "ztron_teleporter_taken", "ztron_playerDumpFPS", "host_migration_begin", "last_stand_enter" );
    self notify( #"ztron_playerdumpfps" );
}

// Namespace ztron_camera
// Params 3
// Checksum 0xff7e3abf, Offset: 0x1f1e
// Size: 0xfe
function function_4cb0fb44c3e8f6ed( timeout = 10, force = 0, var_e9796aa4b9b54edd = 1 )
{
    self notify( #"hash_bab7d453cd559afc" );
    self endon( #"hash_bab7d453cd559afc" );
    self endon( #"disconnect" );
    
    if ( self.ztron.var_a4c2f70bbc713f98 )
    {
        thread function_c41bb4f128ee8d5b( timeout, force );
        return;
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_1p_intro_OS", self.origin );
    prevcamera = self.ztron.var_a46fa357ac82e4a;
    function_79d64be315aa51c9( 4 );
    thread ztron_player_utility::function_985a085be4ea0ba4( 0 );
    self.ztron.var_8a46e28ad02229a8 = force;
    thread function_2dd89834006b4be5();
    ztron_score::function_4ea454cb6435a318();
    
    if ( var_e9796aa4b9b54edd )
    {
        thread function_e6efe0f15a6ec3f4( prevcamera );
    }
    
    thread function_c41bb4f128ee8d5b( timeout, force );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x26b9aa81, Offset: 0x2024
// Size: 0x130
function function_e6efe0f15a6ec3f4( prevcamera )
{
    self notify( #"hash_8c88354665f60758" );
    self endon( #"hash_8c88354665f60758" );
    self endon( #"disconnect" );
    self endon( #"ztron_playerdumpfps" );
    self endon( #"hash_463ac41b7bf90869" );
    self endon( #"hash_1599cd8faf59a8ce" );
    ztron_player_utility::freezeplayercontrols( 1 );
    cam_range = function_903ad0895928478e( prevcamera );
    cam_lookat = self.origin + ( 0, 0, 72 );
    cam_angles = ( self.ztron.camera_pitch ?? 75, self.ztron.var_13805a047e18bac9 == 1 ? 180 : 0, 0 );
    var_f8dad7f191e8f7cc = self.origin - anglestoforward( cam_angles ) * cam_range;
    function_7d04971d3595278( var_f8dad7f191e8f7cc, cam_angles );
    childthread function_a49b8d2080aaf5dd( cam_lookat );
    wait 0.25;
    playfxontagforclients( utility::getfx( "ztron_exp_lg" ), self, "tag_origin", self );
    wait 0.1;
    ztron_player_utility::freezeplayercontrols( 0 );
}

// Namespace ztron_camera
// Params 1
// Checksum 0x3854c05, Offset: 0x215c
// Size: 0x60
function function_a49b8d2080aaf5dd( cam_lookat )
{
    self notify( #"hash_2d22c567cc2e3832" );
    self endon( #"hash_2d22c567cc2e3832" );
    self endon( #"hash_2cb65a9e19437b27" );
    thread function_cf86d241b76bf777( cam_lookat, 0.3 );
    wait 0.25;
    function_c55643e3b7249305( self.angles, 0.1 );
    thread function_3f5f4767374bb6c7();
}

// Namespace ztron_camera
// Params 1, eflags: 0x4
// Checksum 0xc2cdf1c5, Offset: 0x21c4
// Size: 0x6f
function private function_2dd89834006b4be5( time = 1 )
{
    self endon( #"disconnect" );
    var_62aef5673524c52b = self.ztron.var_8a46e28ad02229a8;
    self.ztron.var_8a46e28ad02229a8 = 1;
    wait time;
    self.ztron.var_8a46e28ad02229a8 = var_62aef5673524c52b;
}

/#

    // Namespace ztron_camera
    // Params 0
    // Checksum 0x19429f69, Offset: 0x223b
    // Size: 0x1e6, Type: dev
    function function_ac7ee3673d6e340d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7c>" );
        devgui::add_devgui_func( "<dev string:x8c>", "<dev string:x9c>", &function_43ec4655c8b4518e );
        devgui::add_devgui_func( "<dev string:xab>", "<dev string:xbc>", &function_e733fe8fb74f1c81 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd3>", "<dev string:xe7>", &function_895b890b23e89982 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfb>", "<dev string:x114>", &function_895b890b23e89982 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x128>", "<dev string:x13d>", &function_895b890b23e89982 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x151>", "<dev string:x16c>", &function_895b890b23e89982 );
        devgui::add_devgui_func( "<dev string:x180>", "<dev string:x196>", &function_6bc34b05e46b9463 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1a9>", "<dev string:x1c4>", &function_f0acd92008140b48 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e2>", "<dev string:x1fa>", &function_f0acd92008140b48 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x218>", "<dev string:x230>", &function_f0acd92008140b48 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x24e>", "<dev string:x267>", &function_f0acd92008140b48 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x285>", "<dev string:x29f>", &function_e70b130bf4bf7547 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2bf>", "<dev string:x2da>", &function_e70b130bf4bf7547 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fb>", "<dev string:x316>", &function_e70b130bf4bf7547 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x337>", "<dev string:x353>", &function_e70b130bf4bf7547 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x375>", "<dev string:x391>", &function_e70b130bf4bf7547 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3b3>", "<dev string:x3ce>", &function_e91c6f6a69db89d8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3ef>", "<dev string:x40c>", &function_e91c6f6a69db89d8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x42f>", "<dev string:x44c>", &function_e91c6f6a69db89d8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x46f>", "<dev string:x494>", &function_711a5944b72a1658 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4c7>", "<dev string:x4f0>", &function_711a5944b72a1658 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0xcaccbd1f, Offset: 0x2429
    // Size: 0x2e, Type: dev
    function private function_711a5944b72a1658( params )
    {
        enable = int( params[ 0 ] ) == 1;
        function_a33f5a3220dee73e( enable );
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0x3ad42f8f, Offset: 0x245f
    // Size: 0xf4, Type: dev
    function private function_43ec4655c8b4518e( params )
    {
        if ( isdefined( level.player ) )
        {
            enable = !level.player function_acbf60ca18b9864b();
            level.player function_79d64be315aa51c9( enable ? 1 : 4 );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    enable = !player function_acbf60ca18b9864b();
                    player function_79d64be315aa51c9( enable ? 1 : 4 );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 0, eflags: 0x4
    // Checksum 0x4f5ea2f8, Offset: 0x255b
    // Size: 0xf1, Type: dev
    function private function_e733fe8fb74f1c81()
    {
        if ( isdefined( level.player ) )
        {
            level.player flipTopdownCamera( 1 - ( level.player.ztron.var_13805a047e18bac9 ?? 0 ) );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    player flipTopdownCamera( 1 - ( player.ztron.var_13805a047e18bac9 ?? 0 ) );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0x76a16fb1, Offset: 0x2654
    // Size: 0xda, Type: dev
    function private function_895b890b23e89982( params )
    {
        mode = isdefined( params[ 0 ] ) ? int( params[ 0 ] ) : undefined;
        
        if ( isdefined( level.player ) )
        {
            level.player function_79d64be315aa51c9( mode );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    player function_79d64be315aa51c9( mode );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 0, eflags: 0x4
    // Checksum 0x1b7180a2, Offset: 0x2736
    // Size: 0x13d, Type: dev
    function private function_6bc34b05e46b9463()
    {
        if ( isdefined( level.player ) )
        {
            origin = level.player.origin + ( 0, 0, 600 );
            angles = vectortoangles( ( 0, 0, -600 ) );
            function_90951f3fca05e46a( origin, angles );
            level.player function_79d64be315aa51c9( 5 );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    origin = player.origin + ( 0, 0, 600 );
                    angles = vectortoangles( ( 0, 0, -600 ) );
                    function_90951f3fca05e46a( origin, angles );
                    player function_79d64be315aa51c9( 5 );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0x71ba041a, Offset: 0x287b
    // Size: 0xda, Type: dev
    function private function_f0acd92008140b48( params )
    {
        mode = isdefined( params[ 0 ] ) ? int( params[ 0 ] ) : undefined;
        
        if ( isdefined( level.player ) )
        {
            level.player function_e53bf7020d2f155d( mode );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    player function_e53bf7020d2f155d( mode );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0x286b2072, Offset: 0x295d
    // Size: 0xcf, Type: dev
    function private function_e70b130bf4bf7547( params )
    {
        angle = int( params[ 0 ] );
        
        if ( isdefined( level.player ) )
        {
            level.player function_74296609ac79a40d( angle );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    player function_74296609ac79a40d( angle );
                }
            }
        }
    }

    // Namespace ztron_camera
    // Params 1, eflags: 0x4
    // Checksum 0x9bca1923, Offset: 0x2a34
    // Size: 0xcf, Type: dev
    function private function_e91c6f6a69db89d8( params )
    {
        angle = int( params[ 0 ] );
        
        if ( isdefined( level.player ) )
        {
            level.player function_a13b43697fdb6f43( angle );
            return;
        }
        
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) )
                {
                    player function_a13b43697fdb6f43( angle );
                }
            }
        }
    }

#/
