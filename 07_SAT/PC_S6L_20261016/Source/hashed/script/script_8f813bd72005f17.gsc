// script_8f813bd72005f17  (hash_08f813bd72005f17.gscc) (size: 8678 Bytes / 0x21e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5bdf534 (3585996084)
// size ...... 8678 (0x21e6)
// includes .. 8   (offset: 0x1fc2)
// strings ... 23  (offset: 0x2002)
// dev strs .. 9   (offset: 0x2176)
// exports ... 27  (offset: 0x1236)
// cseg ...... 0x1e9 + 0x104d (0x1236)
// imports ... 78  (offset: 0x166e)
// animtree1 . 0   (offset: 0x21e6)
// animtree2 . 0   (offset: 0x21e6)
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;

#namespace namespace_d3d19b4295dd0b38;

// Namespace namespace_d3d19b4295dd0b38
// Params 0, eflags: 0x1
// Checksum 0xed87d90, Offset: 0x207
// Size: 0x90
function autoexec init()
{
    level.jumppad = spawnstruct();
    level.jumppad.lateral_strength = getdvarint( @"hash_71550f11f23dc89e", 1000 );
    level.jumppad.vertical_strength = getdvarint( @"hash_2ab456d67d6aae03", 2000 );
    
    if ( !getdvarint( @"hash_8e05a07a6c910eea" ) )
    {
        return;
    }
    
    calloutmarkerping::function_572853cf60de7300( "mp_saw_jumppad", %"ping_location_go" );
    jumppads_spawn();
    
    /#
        level thread debug_init();
    #/
}

// Namespace namespace_d3d19b4295dd0b38
// Params 0
// Checksum 0x738c32f0, Offset: 0x29f
// Size: 0x172
function jumppads_spawn()
{
    level waittill( #"scriptables_ready" );
    locs = utility::getstructarray( "jumppad_spawn", "targetname" );
    
    foreach ( loc in locs )
    {
        jumppad = spawnscriptable( "mp_saw_jumppad", loc.origin );
        jumppad.version = isdefined( loc.script_noteworthy ) ? int( loc.script_noteworthy ) : 0;
        jumppad.lateral_strength = int( loc.lateral_strength );
        jumppad.vertical_strength = int( loc.vertical_strength );
        
        if ( !isdefined( level.jumppad.jumppads ) )
        {
            level.jumppad.jumppads = [];
        }
        
        level.jumppad.jumppads[ level.jumppad.jumppads.size ] = jumppad;
    }
    
    level thread jumppads_activate();
}

// Namespace namespace_d3d19b4295dd0b38
// Params 0
// Checksum 0xe6ea9e93, Offset: 0x419
// Size: 0xe9
function jumppads_activate()
{
    level waittill( #"jumppads_activate" );
    
    foreach ( jumppad in level.jumppad.jumppads )
    {
        jumppad setscriptablepartstate( "ambient_fx", "on" );
        jumppad setscriptablepartstate( "icon", "on" );
        jumppad setscriptablepartstate( "model", "on" );
        trigger = spawn( "noent_volume_trigger_radius", jumppad.origin, 0, 50, 100 );
        jumppad jumppad_trigger_init( trigger );
    }
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1
// Checksum 0x85c48571, Offset: 0x50a
// Size: 0x37
function jumppad_trigger_init( trigger )
{
    self.trigger = trigger;
    trigger.jumppad = self;
    trigger::makeenterexittrigger( trigger, &jumppad_trigger_enter, &jumppad_trigger_exit );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 2, eflags: 0x4
// Checksum 0x9d6f0fde, Offset: 0x549
// Size: 0x100
function private jumppad_trigger_enter( player, trigger )
{
    if ( flags::gameflag( "prematch_done" ) && !flags::gameflag( "br_ready_to_jump" ) )
    {
        return;
    }
    
    if ( !isplayer( player ) || !player player::isreallyalive() )
    {
        if ( player.occupants )
        {
            foreach ( occupant in player.occupants )
            {
                occupant function_353638c337ac0a90( trigger );
                occupant thread function_77a83574306c8aef( trigger );
            }
        }
        
        return;
    }
    
    if ( !player istouching( trigger ) )
    {
        return;
    }
    
    player function_353638c337ac0a90( trigger );
    player thread function_dadf236f8c822dfb( trigger );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0xb2caff59, Offset: 0x651
// Size: 0x9f
function private function_353638c337ac0a90( trigger )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self playsoundevent( %"hash_67f984386a032f83" );
    
    if ( trigger.jumppad.version == 5 )
    {
        set_skydive_enabled( 0 );
    }
    
    self setscriptablepartstate( "low_gravity_screen_fx", "on" );
    self.falldamageprotection = 1;
    function_78c682336e636cb3( 1 );
    thread jump_watch( trigger.jumppad );
    thread trigger_watch_for_death( trigger );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        thread function_6d25fe3da125ba74( trigger );
    }
}

// Namespace namespace_d3d19b4295dd0b38
// Params 2, eflags: 0x4
// Checksum 0xd12bc35a, Offset: 0x6f8
// Size: 0xe4
function private jumppad_trigger_exit( player, trigger )
{
    if ( flags::gameflag( "prematch_done" ) && !flags::gameflag( "br_ready_to_jump" ) )
    {
        return;
    }
    
    if ( !isplayer( player ) || !player player::isreallyalive() )
    {
        return;
    }
    
    if ( player istouching( trigger ) )
    {
        return;
    }
    
    player playsoundevent( %"hash_79534f185f08fbe5" );
    
    if ( trigger.jumppad.version == 5 )
    {
        player set_skydive_enabled( 1 );
    }
    
    player setscriptablepartstate( "low_gravity_screen_fx", "off" );
    
    if ( !self isonground() )
    {
        player thread function_36d9ee6fa0455330( trigger.jumppad );
    }
    
    player thread function_a2f3d8938e43de8a();
    player thread function_e88c219fe0f3592e();
    player function_78c682336e636cb3( 0 );
    player notify( #"hash_33d57b40450ee1b4" );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0xc
// Checksum 0xab3d1912, Offset: 0x7e4
// Size: 0x5b
function private trigger_watch_for_death( trigger )
{
    self notify( #"hash_6bfd8c60cba90c35" );
    self endon( #"hash_6bfd8c60cba90c35" );
    level endon( #"game_ended" );
    self endon( #"hash_33d57b40450ee1b4", #"disconnect" );
    self waittill( #"death" );
    function_bffa1823a34d08e0( trigger );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0xc
// Checksum 0x43b11ccc, Offset: 0x847
// Size: 0x5b
function private function_dadf236f8c822dfb( trigger )
{
    self notify( #"hash_fa0c68f50eb51cd9" );
    self endon( #"hash_fa0c68f50eb51cd9" );
    level endon( #"game_ended" );
    self endon( #"hash_33d57b40450ee1b4", #"disconnect" );
    self waittill( #"vehicle_enter" );
    function_bffa1823a34d08e0( trigger );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0xc
// Checksum 0x5098c725, Offset: 0x8aa
// Size: 0x5b
function private function_77a83574306c8aef( trigger )
{
    self notify( #"hash_76922313430d8f70" );
    self endon( #"hash_76922313430d8f70" );
    level endon( #"game_ended" );
    self endon( #"hash_33d57b40450ee1b4", #"disconnect" );
    self waittill( #"vehicle_seat_exit" );
    function_bffa1823a34d08e0( trigger );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0xc
// Checksum 0x5e01bfbd, Offset: 0x90d
// Size: 0x51
function private function_6d25fe3da125ba74( trigger )
{
    self notify( #"hash_f68472d1e2e3d466" );
    self endon( #"hash_f68472d1e2e3d466" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    flags::gameflagwait( "prematch_fade_done" );
    function_bffa1823a34d08e0( trigger );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0xc739555c, Offset: 0x966
// Size: 0x7b
function private function_bffa1823a34d08e0( trigger )
{
    function_78c682336e636cb3( 0 );
    
    if ( trigger.jumppad.version == 5 )
    {
        set_skydive_enabled( 1 );
    }
    
    self setscriptablepartstate( "low_gravity_screen_fx", "off" );
    
    if ( !self.var_c7db4a5f206339af )
    {
        self.falldamageprotection = 0;
    }
    
    self setscriptablepartstate( "haunting_jump_pad", "off" );
    self notify( #"hash_33d57b40450ee1b4" );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0x6b5c1ec5, Offset: 0x9e9
// Size: 0x81
function private jump_watch( jumppad )
{
    self endon( #"hash_33d57b40450ee1b4" );
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( self isonground() && self jumpbuttonpressed() && !self ismantling() && !self.carryinghostage && !self getmeatshieldpartner() && !self.vehicle )
        {
            thread jump( jumppad );
        }
        
        waitframe();
    }
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0xae31dd1, Offset: 0xa72
// Size: 0x335
function private jump( jumppad )
{
    /#
        level.jumppad.lateral_strength = getdvarint( @"hash_71550f11f23dc89e", 1000 );
    #/
    
    /#
        level.jumppad.vertical_strength = getdvarint( @"hash_2ab456d67d6aae03", 2000 );
    #/
    
    if ( isdefined( jumppad.lateral_strength ) )
    {
        lateral = jumppad.lateral_strength;
    }
    else
    {
        lateral = level.jumppad.lateral_strength;
    }
    
    if ( isdefined( jumppad.vertical_strength ) )
    {
        vertical = jumppad.vertical_strength;
    }
    else
    {
        vertical = level.jumppad.vertical_strength;
    }
    
    /#
        lateral = getdvarint( @"hash_4863af4241a9247", lateral );
    #/
    
    /#
        vertical = getdvarint( @"hash_59a783a30a4c75b0", vertical );
    #/
    
    v = ( 0, 0, vertical );
    
    switch ( jumppad.version )
    {
        case 0:
            if ( isdefined( level.floating_island.portal_trigger ) )
            {
                v *= 1.3;
                v += anglestoforward( self.angles ) * lateral * 0.5;
            }
            else
            {
                v += anglestoforward( self.angles ) * lateral;
            }
            
            break;
        case 1:
            v += vectornormalize( self getvelocity() ) * lateral;
            break;
        case 2:
            var_85c1642ce2d404e2 = anglestoforward( self getplayerangles() ) * lateral;
            var_43bdef97e60d2a6e = vectornormalize( self getvelocity() ) * lateral;
            v += ( var_43bdef97e60d2a6e[ 0 ], var_43bdef97e60d2a6e[ 1 ], var_85c1642ce2d404e2[ 2 ] );
            break;
        case 3:
            break;
        case 4:
            v += anglestoforward( jumppad.angles ) * lateral;
            break;
        case 5:
            var_b872915080d2af4c = self getnormalizedmovement( 0.25 );
            player_fwd = anglestoforward( self.angles );
            player_right = anglestoright( self.angles );
            adjusted_fwd = var_b872915080d2af4c[ 0 ] * 300 * player_fwd;
            adjusted_right = var_b872915080d2af4c[ 1 ] * 300 * player_right;
            v = adjusted_fwd + adjusted_right + ( 0, 0, 375 );
            break;
        default:
            assertmsg( "<dev string:x24>" );
            break;
    }
    
    if ( jumppad.version == 5 )
    {
        self setscriptablepartstate( "haunting_jump_pad", "jump_begin_low_grav" );
    }
    else
    {
        jumppad setscriptablepartstate( "launch_fx", "on" );
        self setscriptablepartstate( "haunting_jump_pad", "jump_begin_jump_pad" );
    }
    
    function_78c682336e636cb3( 0 );
    self jumpscripted( v );
    thread function_36d9ee6fa0455330( jumppad );
    thread function_a2f3d8938e43de8a();
    thread function_e88c219fe0f3592e();
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0xc
// Checksum 0x27bbcb24, Offset: 0xdaf
// Size: 0x177
function private function_36d9ee6fa0455330( jumppad )
{
    self notify( #"hash_3eab71edceb99356" );
    self endon( #"hash_3eab71edceb99356" );
    level endon( #"game_ended" );
    self endon( #"skydive_deployparachute" );
    self endon( #"death_or_disconnect" );
    wait 0.5;
    
    if ( jumppad.version != 5 )
    {
        jumppad setscriptablepartstate( "launch_fx", "off" );
    }
    
    while ( !self isonground() && !isdefined( self.vehicle ) )
    {
        waitframe();
    }
    
    self notify( #"jumppad_landed" );
    
    if ( isdefined( self.vehicle ) )
    {
        self.var_4607453c4444cf8b = 1;
    }
    
    if ( jumppad.version == 5 )
    {
        if ( !self.var_4607453c4444cf8b )
        {
            self setscriptablepartstate( "haunting_jump_pad", "impact_low_grav" );
        }
        
        if ( self istouching( jumppad.trigger ) )
        {
            function_78c682336e636cb3( 1 );
        }
    }
    else if ( !self.var_4607453c4444cf8b )
    {
        self setscriptablepartstate( "haunting_jump_pad", "impact_jump_pad" );
    }
    
    if ( self.var_4607453c4444cf8b )
    {
        self setscriptablepartstate( "haunting_jump_pad", "off" );
    }
    
    self.var_4607453c4444cf8b = 0;
    
    if ( !jumppad.trigger.var_5ba24357c9d42a15[ self getentitynumber() ] && !self.var_c7db4a5f206339af )
    {
        self.falldamageprotection = 0;
    }
}

// Namespace namespace_d3d19b4295dd0b38
// Params 0, eflags: 0xc
// Checksum 0x1ec89c56, Offset: 0xf2e
// Size: 0x76
function private function_a2f3d8938e43de8a()
{
    self notify( #"hash_addb36cd77b8b107" );
    self endon( #"hash_addb36cd77b8b107" );
    level endon( #"game_ended" );
    self endon( #"jumppad_landed" );
    self endon( #"disconnect" );
    utility::waittill_any( "skydive_deployparachute", "death" );
    
    if ( !self.var_c7db4a5f206339af )
    {
        self.falldamageprotection = 0;
    }
    
    self setscriptablepartstate( "haunting_jump_pad", "off" );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 0, eflags: 0xc
// Checksum 0xf5763995, Offset: 0xfac
// Size: 0x56
function private function_e88c219fe0f3592e()
{
    self notify( #"hash_95254de92286a4f1" );
    self endon( #"hash_95254de92286a4f1" );
    level endon( #"game_ended" );
    self endon( #"jumppad_landed" );
    self endon( #"death_or_disconnect" );
    self waittill( #"mantle_start" );
    self.var_4607453c4444cf8b = 1;
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0x5bd7128e, Offset: 0x100a
// Size: 0x37
function private function_78c682336e636cb3( var_7247f97b9c2656e3 )
{
    if ( var_7247f97b9c2656e3 )
    {
        val::set( "manticore_s6_jump_pad", "allow_jump", 0 );
        return;
    }
    
    val::reset( "manticore_s6_jump_pad", "allow_jump" );
}

// Namespace namespace_d3d19b4295dd0b38
// Params 1, eflags: 0x4
// Checksum 0xe95bd427, Offset: 0x1049
// Size: 0x28
function private set_skydive_enabled( is_enabled )
{
    if ( !is_enabled )
    {
        self skydive_interrupt();
    }
    
    self skydive_setbasejumpingstatus( is_enabled );
    self skydive_setdeploymentstatus( is_enabled );
}

/#

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0xd02ad8ec, Offset: 0x1079
    // Size: 0x5, Type: dev
    function function_b967f2f55dce6301()
    {
        
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0xc18f5994, Offset: 0x1086
    // Size: 0x2f, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
        utility::function_95db22f620602461( @"hash_3098f301b7f66fc6", &function_e898e51c7414ba57 );
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0x9057f07f, Offset: 0x10bd
    // Size: 0x44, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x41>" );
        devgui::add_devgui_func( "<dev string:x4d>", "<dev string:x52>", &function_c41c2906cae9a8a );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x87>", &function_d307ea89d535fd95 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0xb9fbf6c9, Offset: 0x1109
    // Size: 0x15, Type: dev
    function function_c41c2906cae9a8a()
    {
        level.player thread jump();
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0xd8a98b63, Offset: 0x1126
    // Size: 0x5a, Type: dev
    function function_d307ea89d535fd95()
    {
        if ( !getdvarint( @"hash_3098f301b7f66fc6" ) )
        {
            setdvar( @"hash_3098f301b7f66fc6", 1 );
            iprintlnbold( "<dev string:xb1>" );
            function_e898e51c7414ba57();
            return;
        }
        
        setdvar( @"hash_3098f301b7f66fc6", 0 );
        iprintlnbold( "<dev string:xcf>" );
        function_9cd71e93496f553b();
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0x86bd5887, Offset: 0x1188
    // Size: 0x95, Type: dev
    function function_e898e51c7414ba57()
    {
        foreach ( jumppad in level.jumppad.jumppads )
        {
            debug::sphere( jumppad, 50, "<dev string:xee>", undefined, "<dev string:xcf>" );
        }
    }

    // Namespace namespace_d3d19b4295dd0b38
    // Params 0
    // Checksum 0xd6b442e1, Offset: 0x1225
    // Size: 0x11, Type: dev
    function function_9cd71e93496f553b()
    {
        level notify( #"hash_309b5c768947c4e4" );
    }

#/
