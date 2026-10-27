// scripts\common\active_env\launcher.gsc  (hash_4d18dbd6f4b1437f.gscc) (size: 6298 Bytes / 0x189a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39258483 (958760067)
// size ...... 6298 (0x189a)
// includes .. 3   (offset: 0x174a)
// strings ... 17  (offset: 0x1762)
// dev strs .. 8   (offset: 0x183a)
// exports ... 14  (offset: 0xefa)
// cseg ...... 0x18e + 0xd6c (0xefa)
// imports ... 52  (offset: 0x112a)
// animtree1 . 0   (offset: 0x189a)
// animtree2 . 0   (offset: 0x189a)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\trigger;

#namespace launcher;

// Namespace launcher
// Params 0
// Checksum 0xe66ca11d, Offset: 0x1ac
// Size: 0x2c4
function launcher_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    
    if ( utility::flag_exist( "moving_platforms_initialized" ) )
    {
        utility::flag_wait( "moving_platforms_initialized" );
    }
    
    self.n_push_strength = self.script_float ?? 1000;
    self.player_influence = self.script_multiplier ?? 0;
    self.fixed_bounce = self.script_parameters == "fixed";
    self.push_wait_seconds = self.script_wait ?? 0;
    self.launch_sound = self.script_soundalias ?? undefined;
    self.waittill_notify = issubstr( self.script_parameters, "waittill_notify" ) ?? 0;
    self.waittill_second_notify = issubstr( self.script_parameters, "waittill_second_notify" ) ?? 0;
    self.waittill_jump = issubstr( self.script_parameters, "waittill_jump" ) ?? 0;
    self.waittill_slide = issubstr( self.script_parameters, "waittill_slide" ) ?? 0;
    self.reflector = issubstr( self.script_parameters, "reflector" ) ?? 0;
    self.launch_offset = self.script_offset ?? ( 0, 0, 8 );
    self.scriptables_attached = getentitylessscriptablearray( self.target, #targetname );
    
    if ( self.code_classname === "trigger_multiple" || self.classname == "noent_volume_trigger" )
    {
        self.launch_type = "brush";
    }
    else
    {
        self.launch_type = "origin_angles";
    }
    
    default_push = 1;
    
    if ( self.waittill_notify || self.waittill_second_notify )
    {
        self.notification_receiver = self;
        self.parent = self getlinkedparent();
        
        if ( isdefined( self.parent ) )
        {
            self.notification_receiver = self.parent;
        }
        
        if ( self.waittill_notify )
        {
            thread function_c36d9c2282f62294( "push_start" );
        }
        else if ( self.waittill_second_notify )
        {
            thread function_c36d9c2282f62294( "push_start_2" );
        }
        
        default_push = 0;
    }
    
    if ( self.push_wait_seconds > 0 )
    {
        thread wait_for_player();
        default_push = 0;
    }
    
    if ( self.waittill_jump )
    {
        thread wait_for_player_action( 1 );
        default_push = 0;
    }
    
    if ( self.waittill_slide )
    {
        thread wait_for_player_action( 0, 1 );
        default_push = 0;
    }
    
    if ( default_push )
    {
        trigger::makeenterexittrigger( self, &function_56cae147520e9afb, &function_d1fb715b904369ef );
    }
    
    /#
        thread function_f463d0f6504f544e();
    #/
}

// Namespace launcher
// Params 2, eflags: 0x4
// Checksum 0x4a3c81db, Offset: 0x478
// Size: 0x20c
function private function_cbededb973285cba( player, launcher )
{
    if ( launcher.launch_type == "brush" )
    {
        launchdir = player.origin + ( 0, 0, 32 ) - launcher.origin;
    }
    else if ( launcher.launch_type == "origin_angles" )
    {
        launchdir = anglestoforward( launcher.angles );
    }
    else
    {
        assert( 0, "<dev string:x24>" + ( launcher.launch_type ?? "<dev string:x4f>" ) );
        launchdir = anglestoforward( launcher.angles );
    }
    
    playerdir = player getvelocity();
    var_cb48af336de18165 = vectornormalize( launchdir );
    
    if ( launcher.reflector )
    {
        var_fcfe9ebb628f427f = math::vector_reflect( playerdir, var_cb48af336de18165 );
        var_cb48af336de18165 = vectornormalize( var_fcfe9ebb628f427f );
    }
    
    if ( launcher.fixed_bounce )
    {
        launcherangles = vectortoangles( var_cb48af336de18165 );
        
        if ( lengthsquared( playerdir ) != 0 )
        {
            playerangles = vectortoangles( playerdir );
            var_647fb91c1ebd3f35 = math::angle_lerp( launcherangles[ 1 ], playerangles[ 1 ], launcher.player_influence );
            var_279011da45a52309 = ( launcherangles[ 0 ], var_647fb91c1ebd3f35, 0 );
        }
        else
        {
            var_279011da45a52309 = ( launcherangles[ 0 ], launcherangles[ 1 ], 0 );
        }
        
        var_cb48af336de18165 = anglestoforward( var_279011da45a52309 );
    }
    else if ( launcher.player_influence > 0 )
    {
        playernormalized = vectornormalize( playerdir );
        var_f29286b77b36aa4c = var_cb48af336de18165 + playernormalized * launcher.player_influence;
        var_cb48af336de18165 = vectornormalize( var_f29286b77b36aa4c );
    }
    
    launchstrength = launcher.n_push_strength;
    
    if ( player utility::isusingremote() && player.usingremote === "remote_robot" )
    {
        launchstrength *= 0.5;
    }
    
    return var_cb48af336de18165 * launchstrength;
}

// Namespace launcher
// Params 1, eflags: 0x4
// Checksum 0x11e13e84, Offset: 0x68d
// Size: 0x19b
function private player_launch( player )
{
    level endon( #"game_ended" );
    
    if ( !isalive( player ) || player.launcher_launching == 1 )
    {
        return;
    }
    
    player.launcher_launching = 1;
    launchvector = function_cbededb973285cba( player, self );
    
    if ( self.launch_sound )
    {
        offset = vectornormalize( player.origin - self.origin );
        var_a778536032930895 = self.origin + offset * -1;
        playsoundatpos( var_a778536032930895, self.launch_sound );
    }
    
    if ( self.scriptables_attached )
    {
        foreach ( scriptable in self.scriptables_attached )
        {
            scriptable setscriptablepartstate( "launcher_anim", "launcher_anim_play" );
        }
    }
    
    player function_a4a572d8d09b0f46();
    player setorigin( player.origin + self.launch_offset );
    player allowjump( 0 );
    player.var_b2b4a5303ac9f384 = 1;
    player thread function_95da73a6a2df281c();
    player thread function_9e441bcab525d785();
    waitframe();
    player setvelocity( launchvector );
    self notify( #"launcher_launch" );
}

// Namespace launcher
// Params 0, eflags: 0x4
// Checksum 0x87bdb9c0, Offset: 0x830
// Size: 0x26
function private function_95da73a6a2df281c()
{
    level endon( #"game_ended" );
    wait 0.2;
    self.launcher_launching = 0;
    self allowjump( 1 );
}

// Namespace launcher
// Params 0, eflags: 0x4
// Checksum 0x6a7d72cb, Offset: 0x85e
// Size: 0x3e
function private function_9e441bcab525d785()
{
    level endon( #"game_ended" );
    wait 0.2;
    
    while ( self.var_b2b4a5303ac9f384 === 1 )
    {
        if ( self isonground() )
        {
            self.var_b2b4a5303ac9f384 = 0;
        }
        
        wait 0.2;
    }
}

// Namespace launcher
// Params 2, eflags: 0x4
// Checksum 0x2bbe5579, Offset: 0x8a4
// Size: 0x28
function private function_56cae147520e9afb( player, trigger )
{
    if ( isplayer( player ) )
    {
        trigger thread player_launch( player );
    }
}

// Namespace launcher
// Params 2, eflags: 0x4
// Checksum 0x763fe8e7, Offset: 0x8d4
// Size: 0x2b
function private function_d1fb715b904369ef( player, trigger )
{
    if ( isplayer( player ) )
    {
        player.launcher_launching = 0;
    }
}

// Namespace launcher
// Params 0, eflags: 0x4
// Checksum 0xff1a66d7, Offset: 0x907
// Size: 0xc0
function private function_c4a9ea08c4cebe7e()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.notification_receiver ) )
    {
        self.notification_receiver endon( #"push_end" );
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                thread player_launch( player );
            }
        }
        
        wait 0.2;
    }
}

// Namespace launcher
// Params 1, eflags: 0x4
// Checksum 0xf8883b86, Offset: 0x9cf
// Size: 0x35
function private function_c36d9c2282f62294( notify_msg )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.notification_receiver waittill( notify_msg );
        thread function_c4a9ea08c4cebe7e();
    }
}

// Namespace launcher
// Params 0, eflags: 0x4
// Checksum 0xea0b2549, Offset: 0xa0c
// Size: 0xef
function private wait_for_player()
{
    level endon( #"game_ended" );
    current_wait_time = 0;
    
    while ( true )
    {
        var_1237215c5558e91a = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                var_1237215c5558e91a++;
                
                if ( current_wait_time >= self.push_wait_seconds )
                {
                    thread player_launch( player );
                }
            }
        }
        
        if ( current_wait_time >= self.push_wait_seconds || var_1237215c5558e91a < 1 )
        {
            current_wait_time = 0;
        }
        else
        {
            current_wait_time += 0.2;
        }
        
        wait 0.2;
    }
}

// Namespace launcher
// Params 2, eflags: 0x4
// Checksum 0x6f132b80, Offset: 0xb03
// Size: 0x108
function private wait_for_player_action( check_jump, slide_check )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                if ( check_jump == 1 )
                {
                    if ( player isjumping() || player isdiving() )
                    {
                        player_velocity = player getvelocity();
                        
                        if ( player_velocity[ 2 ] > 0 )
                        {
                            thread player_launch( player );
                        }
                    }
                    
                    continue;
                }
                
                if ( slide_check == 1 )
                {
                    if ( player issprintsliding() || player isdiving() )
                    {
                        thread player_launch( player );
                    }
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace launcher
    // Params 0, eflags: 0x4
    // Checksum 0x8622cb3b, Offset: 0xc13
    // Size: 0x3e, Type: dev
    function private function_f463d0f6504f544e()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_launcher_debug", 0 ) )
            {
                function_80dedebf1e437344( level.players[ 0 ], self );
            }
            
            waitframe();
        }
    }

    // Namespace launcher
    // Params 2, eflags: 0x4
    // Checksum 0x4c0d5278, Offset: 0xc59
    // Size: 0x2a1, Type: dev
    function private function_80dedebf1e437344( player, launcher )
    {
        var_ef87b8583634dd50 = launcher.origin + launcher.launch_offset;
        
        if ( player && distancesquared( player.origin, launcher.origin ) < 4000000 )
        {
            launchvector = function_cbededb973285cba( player, launcher );
        }
        else
        {
            launchvector = anglestoforward( launcher.angles ) * launcher.n_push_strength;
        }
        
        launchdir = vectornormalize( launchvector );
        line( var_ef87b8583634dd50, var_ef87b8583634dd50 + launchdir * 96, ( 1, 0.5, 0 ), 1, 0, 1 );
        line( launcher.origin, var_ef87b8583634dd50, ( 1, 0, 0 ), 1, 0, 1 );
        drawtrigger( launcher, ( 0, 1, 1 ), 0 );
        textorigin = launcher.origin + ( 0, 0, 48 );
        launcher_header = "<dev string:x54>" + launcher.launch_type;
        launcher_detail = "<dev string:x5f>" + launcher.n_push_strength + "<dev string:x6a>" + launcher.player_influence;
        var_f9576a3a9d9381ec = "<dev string:x78>" + launcher.fixed_bounce + "<dev string:x86>" + launcher.push_wait_seconds + "<dev string:x96>" + launcher.reflector;
        print3d( textorigin, launcher_header, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( textorigin + ( 0, 0, -20 ), launcher_detail, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( textorigin + ( 0, 0, -40 ), var_f9576a3a9d9381ec, ( 1, 1, 1 ), 1, 1, 1, 1 );
        var_16e6b07febbff4bc = launchvector;
        
        for ( i = 1; i <= 20 ; i++ )
        {
            t = i * 0.15;
            var_8f2ad24d6dc89273 = var_ef87b8583634dd50 + var_16e6b07febbff4bc * t;
            var_8f2ad24d6dc89273 += ( 0, 0, -400 * t * t );
            sphere( var_8f2ad24d6dc89273, 4, ( 1, 1, 0 ), 0 );
        }
    }

#/
