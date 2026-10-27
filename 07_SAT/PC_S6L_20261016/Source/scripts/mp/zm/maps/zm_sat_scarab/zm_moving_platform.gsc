// scripts\mp\zm\maps\zm_sat_scarab\zm_moving_platform.gsc  (hash_2088b63a3710ec3c.gscc) (size: 5711 Bytes / 0x164f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8bf5e0c9 (2348146889)
// size ...... 5711 (0x164f)
// includes .. 3   (offset: 0x15bf)
// strings ... 9   (offset: 0x15d7)
// dev strs .. 0   (offset: 0x164f)
// exports ... 16  (offset: 0xdef)
// cseg ...... 0xf9 + 0xcf6 (0xdef)
// imports ... 43  (offset: 0x106f)
// animtree1 . 0   (offset: 0x164f)
// animtree2 . 0   (offset: 0x164f)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;

#namespace zm_moving_platform;

// Namespace zm_moving_platform
// Params 0, eflags: 0x5
// Checksum 0x7b38c3d8, Offset: 0x117
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_moving_platform", undefined, undefined, &post_init );
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x48b5bb2a, Offset: 0x138
// Size: 0x16
function post_init()
{
    level utility::flag_wait( "begin_round_logic" );
    init_platforms();
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x404f3047, Offset: 0x156
// Size: 0x3b8
function init_platforms()
{
    level.zm_moving_platforms = [];
    level.zm_moving_platforms = getentarray( "zm_moving_platform", #targetname );
    
    if ( level.zm_moving_platforms.size == 0 )
    {
        return;
    }
    
    var_91bed5636f5f050d = getentarray( "m_pltfm_vlm", "targetname" );
    var_c09bd2d77e05e4e = getentarray( "m_pltfm_slickclip", "targetname" );
    var_bc45d2d32752059 = getentarray( "m_pltfm_plyclip", "targetname" );
    var_47d1108995277958 = getentarray( "m_pltfm_slickclip_btm", "targetname" );
    
    foreach ( v in var_91bed5636f5f050d )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms, v.origin, 9999 );
        v enablelinkto();
        v linkto( owner );
        v.my_owner = owner;
        owner.my_volume = v;
        v thread function_7a10f9b8873021e9();
        owner.v_highest = owner.origin + ( 0, 0, 10 );
        owner.v_lowest = owner.origin - ( 0, 0, 10 );
        owner thread do_bob();
    }
    
    foreach ( clip in var_c09bd2d77e05e4e )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms, clip.origin, 9999 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_954e28ef2b10ad82 = clip;
        clip notsolid();
    }
    
    foreach ( clip in var_bc45d2d32752059 )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms, clip.origin, 9999 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        owner.var_59f931d3a85c740f = clip;
        clip solid();
    }
    
    foreach ( clip in var_47d1108995277958 )
    {
        owner = function_b21056d585c710d( level.zm_moving_platforms, clip.origin, 9999 );
        clip enablelinkto();
        clip linkto( owner );
        clip.my_owner = owner;
        clip solid();
    }
    
    level thread set_platform_angles();
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x68261887, Offset: 0x516
// Size: 0x7f
function set_platform_angles()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < level.zm_moving_platforms.size ; i++ )
    {
        level.zm_moving_platforms[ i ] rotateyaw( 15 * i, 0.05 );
        wait 0.1;
        level.zm_moving_platforms[ i ].start_angles = level.zm_moving_platforms[ i ].angles;
    }
}

// Namespace zm_moving_platform
// Params 2
// Checksum 0xe66d348e, Offset: 0x59d
// Size: 0x9a
function function_c16477402f1d9c3a( platform, b_on_platform )
{
    if ( !isdefined( self.moving_platforms ) )
    {
        self.moving_platforms = [];
    }
    
    if ( b_on_platform )
    {
        if ( !arraycontains( self.moving_platforms, platform ) )
        {
            self.moving_platforms[ self.moving_platforms.size ] = platform;
            thread function_b9e211876ffe13c();
            thread function_5edc38f66bf69712( platform );
        }
    }
    else
    {
        self.moving_platforms = arrayremove( self.moving_platforms, platform );
    }
    
    self.b_on_platform = self.moving_platforms.size > 0;
}

// Namespace zm_moving_platform
// Params 1, eflags: 0x4
// Checksum 0x98f51eca, Offset: 0x63f
// Size: 0x46
function private function_5edc38f66bf69712( platform )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( self istouching( platform ) == 0 )
        {
            function_c16477402f1d9c3a( platform, 0 );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x7445dafc, Offset: 0x68d
// Size: 0xe5
function function_7a10f9b8873021e9()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        roll = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                roll = 1;
                player function_c16477402f1d9c3a( self, 1 );
            }
        }
        
        if ( self.b_is_busy )
        {
            if ( !self.my_owner.var_6f94844477c699f1 )
            {
                function_8d748791ae0942c();
            }
        }
        else if ( roll )
        {
            thread delay_to_roll();
        }
        
        waitframe();
    }
}

// Namespace zm_moving_platform
// Params 0, eflags: 0x4
// Checksum 0xe973dd08, Offset: 0x77a
// Size: 0x55
function private function_b9e211876ffe13c()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self.var_8ad9c553e7688ebe && self hasweapon( self.var_8ad9c553e7688ebe ) )
    {
        wait 0.05;
        
        if ( self )
        {
            killstreakdeploy::streakdeploy_cancelalldeployments();
            self notify( #"equip_deploy_cancel" );
        }
    }
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x4ed3207f, Offset: 0x7d7
// Size: 0x5c
function delay_to_roll()
{
    level endon( #"game_ended" );
    self endon( #"no_players_touching" );
    self.b_is_busy = 1;
    wait 2;
    self.my_owner notify( #"quit_bob" );
    self.my_owner thread do_lean();
    self.my_owner thread do_bob();
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0xaac4debe, Offset: 0x83b
// Size: 0x6d
function do_bob()
{
    level endon( #"game_ended" );
    self endon( #"quit_bob" );
    wait randomfloat( 2 );
    
    while ( true )
    {
        self moveto( self.v_highest, 5, 1, 1 );
        self waittill( #"movedone" );
        self moveto( self.v_lowest, 5, 1, 1 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x7970216, Offset: 0x8b0
// Size: 0x113
function do_lean()
{
    level endon( #"game_ended" );
    self endon( #"reset_lean" );
    childthread function_3405b2eacd05e88c( 150, 5 );
    self playsound( #"hash_2c41f1d3ee843cfd" );
    self playloopsound( #"hash_ef0b96815c4acd43" );
    wait 3;
    thread set_slick_clip( 1 );
    self.var_6f94844477c699f1 = 1;
    wait 2;
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
    thread set_slick_clip( 0 );
    self playsound( #"hash_2c41f1d3ee843cfd" );
    self playloopsound( #"hash_ef0b96815c4acd43" );
    childthread function_3405b2eacd05e88c( -175, 5, 0.55, 0.45 );
    self waittill( #"rock_rotate_done" );
    childthread function_3405b2eacd05e88c( 25, 2.5, 0.5, 0.5 );
    self waittill( #"rock_rotate_done" );
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
    self.my_volume.b_is_busy = 0;
    self.var_6f94844477c699f1 = 0;
}

// Namespace zm_moving_platform
// Params 4, eflags: 0x4
// Checksum 0x4a277a76, Offset: 0x9cb
// Size: 0x253
function private function_3405b2eacd05e88c( target_roll, time, acceleration_pct = 0.75, deceleration_pct = 0.25 )
{
    level endon( #"game_ended" );
    time_elapsed = 0;
    var_aa5e31c32aaec336 = target_roll / time / level.framedurationseconds;
    accelerate_time = time * acceleration_pct;
    decelerate_time = time * deceleration_pct;
    decelerate_start_time = time - decelerate_time;
    total_roll = 0;
    self.curr_target_roll = target_roll;
    rumble_interval = 1;
    var_648022615e5973bd = 0;
    rumble_duration = abs( target_roll / 30 );
    rumble_strength = abs( target_roll / 800 );
    rumble_str = time > 3 ? "heavy_3s" : "light_2s";
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player istouching( self.my_volume ) )
        {
            player playrumbleonentity( rumble_str );
        }
    }
    
    while ( true )
    {
        if ( time_elapsed > time )
        {
            self notify( #"rock_rotate_done" );
            return;
        }
        
        if ( time_elapsed < accelerate_time && accelerate_time > 0 )
        {
            var_d63d8bb1bb4f8747 = var_aa5e31c32aaec336 * time_elapsed / accelerate_time;
        }
        else if ( time_elapsed > decelerate_start_time && decelerate_time > 0 )
        {
            var_d63d8bb1bb4f8747 = var_aa5e31c32aaec336 * ( 1 - ( time_elapsed - decelerate_start_time ) / decelerate_time );
        }
        else
        {
            var_d63d8bb1bb4f8747 = var_aa5e31c32aaec336;
        }
        
        if ( var_648022615e5973bd > rumble_interval )
        {
            var_648022615e5973bd = 0;
            earthquake( rumble_strength, rumble_duration, self.origin, 150 );
        }
        
        self addroll( var_d63d8bb1bb4f8747 );
        time_elapsed += level.framedurationseconds;
        var_648022615e5973bd += level.framedurationseconds;
        total_roll += var_d63d8bb1bb4f8747;
        wait level.framedurationseconds;
    }
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x5e7bce88, Offset: 0xc26
// Size: 0xb4
function reset_lean()
{
    level endon( #"game_ended" );
    self notify( #"reset_lean" );
    self.my_volume.b_is_busy = 0;
    target_roll = self.curr_target_roll ? self.curr_target_roll / abs( self.curr_target_roll ) : 5;
    function_3405b2eacd05e88c( target_roll, 1, 0 );
    thread set_slick_clip( 0 );
    self rotateto( self.start_angles, 3, 1.5, 1.5 );
    self waittill( #"rotatedone" );
    self stoploopsound();
    self playsound( #"hash_2c7f7dcfa6116ec4" );
}

// Namespace zm_moving_platform
// Params 1
// Checksum 0x4e5fb108, Offset: 0xce2
// Size: 0x54
function set_slick_clip( var_5bd9b6a6a6a5d2a0 )
{
    level endon( #"game_ended" );
    
    if ( var_5bd9b6a6a6a5d2a0 )
    {
        if ( self.var_954e28ef2b10ad82 )
        {
            self.var_954e28ef2b10ad82 solid();
        }
        
        return;
    }
    
    if ( self.var_954e28ef2b10ad82 )
    {
        self.var_954e28ef2b10ad82 notsolid();
    }
}

// Namespace zm_moving_platform
// Params 0
// Checksum 0x7336840c, Offset: 0xd3e
// Size: 0xb1
function function_8d748791ae0942c()
{
    b_players_touching = 0;
    
    foreach ( player in level.players )
    {
        if ( player istouching( self ) )
        {
            b_players_touching = 1;
            break;
        }
    }
    
    if ( b_players_touching == 0 )
    {
        self.my_owner thread reset_lean();
        self notify( #"no_players_touching" );
    }
}

