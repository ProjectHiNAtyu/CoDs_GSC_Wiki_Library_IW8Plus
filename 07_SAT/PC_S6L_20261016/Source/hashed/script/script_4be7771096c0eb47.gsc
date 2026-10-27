// script_4be7771096c0eb47  (hash_4be7771096c0eb47.gscc) (size: 3768 Bytes / 0xeb8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf868d48 (260476232)
// size ...... 3768 (0xeb8)
// includes .. 8   (offset: 0xdb4)
// strings ... 13  (offset: 0xdf4)
// dev strs .. 0   (offset: 0xeb8)
// exports ... 11  (offset: 0x85c)
// cseg ...... 0xec + 0x770 (0x85c)
// imports ... 32  (offset: 0xa14)
// animtree1 . 0   (offset: 0xeb8)
// animtree2 . 0   (offset: 0xeb8)
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;

#namespace zm_bgb_time_out;

// Namespace zm_bgb_time_out
// Params 0, eflags: 0x5
// Checksum 0x88a1279b, Offset: 0x10a
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "time_out", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_time_out
// Params 0
// Checksum 0xf83dc418, Offset: 0x12f
// Size: 0x39
function __init__()
{
    bgb::register( "time_out", "time", 180, &enable, &disable, &validation );
    callback::add( #"player_death", &on_player_killed );
}

// Namespace zm_bgb_time_out
// Params 0
// Checksum 0xab19b491, Offset: 0x170
// Size: 0x24e
function enable()
{
    self endon( #"disconnect" );
    self endon( #"kill_time_out" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player timeout_screen_flash();
        }
    }
    
    level notify( #"bgb_time_out_on_round_end" );
    thread disable_on_disconnect();
    zm_round_spawning::pause_round_spawning( 1, "bgb_time_out" );
    var_35a76b9286aef10b = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
    
    foreach ( var_7654d704b9415bab in var_35a76b9286aef10b )
    {
        if ( var_7654d704b9415bab.var_75afeb7d6a870ec0 )
        {
            var_7654d704b9415bab dodamage( var_7654d704b9415bab.health + 1000, var_7654d704b9415bab.origin );
        }
    }
    
    zm_cleanup_manager::function_ff2f735d3abb2ce0( 0, [ "elite", "hvt", "boss" ] );
    waitframe();
    level.var_f4f8c9a351eaab32.var_2afe3d6a4d95065b = [];
    zm_round_logic::function_895fdc21ab019efe();
    level utility::flag_set( "bgb_time_out_active" );
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_49413b60c16e505c" );
        player val::set( "bgb_time_out", "ignore_afk", 1 );
    }
}

// Namespace zm_bgb_time_out
// Params 0
// Checksum 0x73bc0aae, Offset: 0x3c6
// Size: 0xcc
function disable()
{
    if ( isdefined( self ) )
    {
        self notify( #"kill_time_out" );
    }
    
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_a5f62dae5c17e5f2" );
        player val::reset( "bgb_time_out", "ignore_afk" );
    }
    
    level utility::flag_clear( "bgb_time_out_active" );
    zm_round_spawning::pause_round_spawning( 0, "bgb_time_out" );
    level notify( #"kill_time_out" );
}

// Namespace zm_bgb_time_out
// Params 0
// Checksum 0x2ffc1cbc, Offset: 0x49a
// Size: 0x117, Type: bool
function validation()
{
    if ( level.var_6781718da4f78d1c.state === 2 )
    {
        return false;
    }
    
    if ( level.var_dc81f03d76612023 )
    {
        return false;
    }
    
    if ( zm_round_spawning::is_round_spawning_paused() )
    {
        return false;
    }
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        return false;
    }
    
    foreach ( player in level.players )
    {
        if ( player bgb::is_enabled( "round_off" ) || player bgb::is_enabled( "time_out" ) )
        {
            return false;
        }
        
        if ( player != self && ( player.var_44c8fd4fb28eb652 === "time_out" || player.var_44c8fd4fb28eb652 === "round_off" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_bgb_time_out
// Params 0, eflags: 0x4
// Checksum 0x40f7afd6, Offset: 0x5ba
// Size: 0x62
function private remove_white_screen()
{
    self endon( #"disconnect" );
    var_24c3037417857a23 = 0.5;
    self.var_2a7a357cf0f6f473 fadeovertime( var_24c3037417857a23 );
    self.var_2a7a357cf0f6f473.alpha = 0;
    wait var_24c3037417857a23;
    
    if ( isdefined( self.var_2a7a357cf0f6f473 ) )
    {
        self.var_2a7a357cf0f6f473 destroy();
    }
}

// Namespace zm_bgb_time_out
// Params 1, eflags: 0x4
// Checksum 0x684fd148, Offset: 0x624
// Size: 0x20
function private on_player_killed( deathdata )
{
    if ( isdefined( self.var_2a7a357cf0f6f473 ) )
    {
        remove_white_screen();
    }
}

// Namespace zm_bgb_time_out
// Params 0, eflags: 0xc
// Checksum 0x841d4107, Offset: 0x64c
// Size: 0x1a8
function private timeout_screen_flash()
{
    self notify( #"hash_a146d9ff01db9cdc" );
    self endon( #"hash_a146d9ff01db9cdc" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.var_2a7a357cf0f6f473 ) )
    {
        self.var_2a7a357cf0f6f473 = newclienthudelem( self );
        self.var_2a7a357cf0f6f473.x = 0;
        self.var_2a7a357cf0f6f473.y = 0;
        self.var_2a7a357cf0f6f473 setshader( "white", 640, 480 );
        self.var_2a7a357cf0f6f473.alignx = "left";
        self.var_2a7a357cf0f6f473.aligny = "top";
        self.var_2a7a357cf0f6f473.sort = 1;
        self.var_2a7a357cf0f6f473.horzalign = "fullscreen";
        self.var_2a7a357cf0f6f473.vertalign = "fullscreen";
        self.var_2a7a357cf0f6f473.alpha = 0;
        self.var_2a7a357cf0f6f473.foreground = 1;
        self.var_2a7a357cf0f6f473.archived = 0;
        self.var_2a7a357cf0f6f473.scramblerdisabled = 1;
    }
    
    var_24c3037417857a23 = 0.2;
    n_target_alpha = 0.8;
    self.var_2a7a357cf0f6f473 fadeovertime( var_24c3037417857a23 );
    self.var_2a7a357cf0f6f473.alpha = n_target_alpha;
    wait 0.5;
    remove_white_screen();
}

// Namespace zm_bgb_time_out
// Params 1, eflags: 0x4
// Checksum 0xbf839ffe, Offset: 0x7fc
// Size: 0x36
function private set_white_screen( screen_alpha )
{
    if ( isdefined( self.var_2a7a357cf0f6f473 ) )
    {
        self.var_2a7a357cf0f6f473.alpha = clamp( screen_alpha, 0, 1 );
    }
}

// Namespace zm_bgb_time_out
// Params 0
// Checksum 0x612d5490, Offset: 0x83a
// Size: 0x22
function disable_on_disconnect()
{
    self endon( #"kill_time_out" );
    self waittill( #"disconnect" );
    thread disable();
}

