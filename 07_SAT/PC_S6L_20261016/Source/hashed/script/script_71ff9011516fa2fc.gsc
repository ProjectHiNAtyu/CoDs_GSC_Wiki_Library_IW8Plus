// script_71ff9011516fa2fc  (hash_71ff9011516fa2fc.gscc) (size: 4883 Bytes / 0x1313 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34448918 (876906776)
// size ...... 4883 (0x1313)
// includes .. 5   (offset: 0x121f)
// strings ... 7   (offset: 0x1247)
// dev strs .. 7   (offset: 0x12bf)
// exports ... 22  (offset: 0x8fb)
// cseg ...... 0xd7 + 0x824 (0x8fb)
// imports ... 49  (offset: 0xc6b)
// animtree1 . 0   (offset: 0x1313)
// animtree2 . 0   (offset: 0x1313)
#using script_e92a9717969a5cd;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;

#namespace europa_blow_whistle;

// Namespace europa_blow_whistle
// Params 0, eflags: 0x5
// Checksum 0x7d8ae76b, Offset: 0xf5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"europa_blow_whistle", undefined, undefined, &post_main );
}

// Namespace europa_blow_whistle
// Params 0
// Checksum 0x5a783f49, Offset: 0x116
// Size: 0x21
function post_main()
{
    /#
        devgui_init();
    #/
    
    callback::add( #"europa_init", &on_init );
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x1d0b5cb6, Offset: 0x13f
// Size: 0x84
function private on_init( params )
{
    utility::registersharedfunc( #"europa", #"hash_64cb0fdb3b92bee7", &pickup_whistle );
    utility::registersharedfunc( #"europa", #"hash_eabd008e66cba461", &blow_whistle_begin );
    utility::registersharedfunc( #"europa", #"hash_6b1dc50e85b392ca", &watch_whistle_begin );
    utility::registersharedfunc( #"europa", #"hash_5f5fd94d52a75c86", &watch_whistle_end );
}

// Namespace europa_blow_whistle
// Params 0, eflags: 0x4
// Checksum 0x94fd49fe, Offset: 0x1cb
// Size: 0xd, Type: bool
function private function_8843641e9933ff21()
{
    return europa_asm::is_playing( "europa_blow_whistle" );
}

// Namespace europa_blow_whistle
// Params 0, eflags: 0x4
// Checksum 0xd387b05e, Offset: 0x1e1
// Size: 0xb
function private get_state()
{
    return self.var_ccbbbdae342727c2;
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x22aba336, Offset: 0x1f5
// Size: 0x17
function private set_state( state )
{
    self.var_ccbbbdae342727c2 = state;
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x90e0b9fd, Offset: 0x214
// Size: 0x15
function private pickup_whistle( params )
{
    thread pickup_whistle_thread( params );
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0xcde07b69, Offset: 0x231
// Size: 0x117
function private pickup_whistle_thread( params )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    model = "sat_zm_death_whistle";
    
    if ( params.target )
    {
        pos = params.target.origin;
        angles = params.target.angles;
    }
    else
    {
        pos = self gettagorigin( "tag_inhand" );
        angles = self gettagangles( "tag_inhand" );
    }
    
    whistle = utility::spawn_model( model, pos, angles );
    self.europa_whistle = whistle;
    self.no_revive = 0;
    thread utility::delete_on_death( whistle );
    
    /#
        if ( getdvarint( @"hash_2bb4b155390de1fc" ) )
        {
            thread debug_draw_whistle();
        }
    #/
    
    thread europa_asm::play_scripted_anim( "pickup_whistle" );
    childthread function_f5ba2757c8d1e818( whistle, params );
    self waittill( #"scripted_anim_cleared" );
    self notify( #"europa_pick_whistle_end" );
}

// Namespace europa_blow_whistle
// Params 2, eflags: 0x4
// Checksum 0x391b5cd6, Offset: 0x350
// Size: 0x7b
function private function_f5ba2757c8d1e818( whistle, params )
{
    self waittill( #"pick_whistle" );
    whistle.origin = self gettagorigin( "tag_inhand" );
    whistle.angles = self gettagangles( "tag_inhand" );
    whistle linktoblendtotag( self, "tag_inhand" );
    self waittill( #"stow_whistle" );
    
    if ( whistle )
    {
        whistle unlink();
        whistle hide();
    }
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x70a13f6c, Offset: 0x3d3
// Size: 0x26
function private watch_whistle_begin( params )
{
    europa_asm::play_cap( "europa_blow_whistle", "cap_europa_blow_whistle" );
    thread watch_whistle_thread( params );
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0xc
// Checksum 0x9d22ddad, Offset: 0x401
// Size: 0x122
function private watch_whistle_thread( params )
{
    self notify( #"hash_4b0b27618d5be74c" );
    self endon( #"hash_4b0b27618d5be74c" );
    level endon( #"game_ended" );
    self endon( #"death" );
    set_state( 1 );
    self waittill( #"take_out_whistle" );
    origin = self gettagorigin( "tag_inhand" );
    angles = self gettagangles( "tag_inhand" );
    
    if ( !self.europa_whistle )
    {
        self.europa_whistle = utility::spawn_model( "sat_zm_death_whistle", origin, angles );
        thread utility::delete_on_death( self.europa_whistle );
    }
    else
    {
        self.europa_whistle.origin = origin;
        self.europa_whistle.angles = angles;
    }
    
    self.europa_whistle linktoblendtotag( self, "tag_inhand" );
    self.europa_whistle show();
    thread watch_whistle_update();
    
    /#
        if ( getdvarint( @"hash_2bb4b155390de1fc" ) )
        {
            thread debug_draw_whistle();
        }
    #/
}

// Namespace europa_blow_whistle
// Params 0, eflags: 0xc
// Checksum 0x842dc805, Offset: 0x52b
// Size: 0x74
function private watch_whistle_update()
{
    self notify( #"hash_214eb0512df1bd71" );
    self endon( #"hash_214eb0512df1bd71" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.europa_whistle )
    {
        self.europa_whistle endon( #"death" );
    }
    
    while ( function_8843641e9933ff21() )
    {
        self waittill( #"europa_watch_whistle_begin" );
        set_state( 2 );
    }
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x50b3d9b, Offset: 0x5a7
// Size: 0x15
function private watch_whistle_end( params )
{
    thread function_d75ba3e75539e063( params );
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0xc
// Checksum 0x5ca98476, Offset: 0x5c4
// Size: 0xa1
function private function_d75ba3e75539e063( params )
{
    self notify( #"hash_847650ef6b6546d9" );
    self endon( #"hash_847650ef6b6546d9" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( get_state() == 3 )
    {
        self waittill( #"europa_blow_whistle_end" );
        wait 0.5;
    }
    
    europa_asm::fire_event( "exit_loop" );
    
    if ( self.europa_whistle )
    {
        self.europa_whistle unlink();
        self.europa_whistle delete();
        self.europa_whistle = undefined;
        set_state( 0 );
    }
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0x4
// Checksum 0x3a634e4f, Offset: 0x66d
// Size: 0x15
function private blow_whistle_begin( params )
{
    thread blow_whistle_thread( params );
}

// Namespace europa_blow_whistle
// Params 1, eflags: 0xc
// Checksum 0xe53ab13e, Offset: 0x68a
// Size: 0x8d
function private blow_whistle_thread( params )
{
    self notify( #"hash_2f5db3ba895c9da7" );
    self endon( #"hash_2f5db3ba895c9da7" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !function_8843641e9933ff21() )
    {
        watch_whistle_begin();
    }
    
    if ( get_state() == 1 )
    {
        self waittill( #"europa_watch_whistle_begin" );
        wait 0.1;
    }
    
    if ( get_state() == 2 )
    {
        europa_asm::fire_event( "blow" );
        set_state( 3 );
    }
}

/#

    // Namespace europa_blow_whistle
    // Params 0, eflags: 0x4
    // Checksum 0xf73456d9, Offset: 0x71f
    // Size: 0x5a, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x4a>", &devgui_pick_whistle );
        devgui::add_devgui_func( "<dev string:x57>", "<dev string:x6d>", &devgui_watch_whistle );
        devgui::add_devgui_func( "<dev string:x7b>", "<dev string:x90>", &devgui_blow_whistle );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa_blow_whistle
    // Params 0, eflags: 0x4
    // Checksum 0x6d069861, Offset: 0x781
    // Size: 0x21, Type: dev
    function private devgui_pick_whistle()
    {
        if ( level.europa )
        {
            level.europa pickup_whistle();
        }
    }

    // Namespace europa_blow_whistle
    // Params 0, eflags: 0x4
    // Checksum 0x20829ffe, Offset: 0x7aa
    // Size: 0x3b, Type: dev
    function private devgui_watch_whistle()
    {
        klaus = level.europa;
        
        if ( !klaus get_state() )
        {
            klaus watch_whistle_begin();
            return;
        }
        
        klaus watch_whistle_end();
    }

    // Namespace europa_blow_whistle
    // Params 0, eflags: 0x4
    // Checksum 0x278ec1ef, Offset: 0x7ed
    // Size: 0x34, Type: dev
    function private devgui_blow_whistle()
    {
        if ( isdefined( level.europa ) )
        {
            level.europa utility::callsharedfunc( #"europa", #"hash_eabd008e66cba461" );
        }
    }

    // Namespace europa_blow_whistle
    // Params 0, eflags: 0xc
    // Checksum 0xc5a4c789, Offset: 0x829
    // Size: 0xd2, Type: dev
    function private debug_draw_whistle()
    {
        self notify( #"hash_e53507ec0c0bff2d" );
        self endon( #"hash_e53507ec0c0bff2d" );
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( self.europa_whistle )
            {
                sphere( self.europa_whistle.origin, 1, ( 1, 0, 0 ) );
                fwd = anglestoforward( self.europa_whistle.angles );
                line( self.europa_whistle.origin, self.europa_whistle.origin + fwd * 5, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
