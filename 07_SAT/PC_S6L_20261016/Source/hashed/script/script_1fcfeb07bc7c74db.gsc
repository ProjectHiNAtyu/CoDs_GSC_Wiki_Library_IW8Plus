// script_1fcfeb07bc7c74db  (hash_1fcfeb07bc7c74db.gscc) (size: 1750 Bytes / 0x6d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4364e501 (1130685697)
// size ...... 1750 (0x6d6)
// includes .. 2   (offset: 0x67e)
// strings ... 3   (offset: 0x68e)
// dev strs .. 0   (offset: 0x6d6)
// exports ... 9   (offset: 0x36e)
// cseg ...... 0x7a + 0x2f4 (0x36e)
// imports ... 15  (offset: 0x4d6)
// animtree1 . 0   (offset: 0x6d6)
// animtree2 . 0   (offset: 0x6d6)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;

#namespace zm_bgb_round_off;

// Namespace zm_bgb_round_off
// Params 0, eflags: 0x5
// Checksum 0x1507536f, Offset: 0x98
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "round_off", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0x433bb78a, Offset: 0xbd
// Size: 0x23
function __init__()
{
    bgb::register( "round_off", "event", &event, undefined, &disable, &validation );
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0x24f5ebd9, Offset: 0xe8
// Size: 0x40
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_round_off" );
    level.var_dc81f03d76612023 = 1;
    thread track_round_end();
    thread deactivate_on_disconnect();
    self waittill( #"hash_479a9d058d0f9d3f" );
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0x3daed0ad, Offset: 0x130
// Size: 0x18
function disable()
{
    self notify( #"kill_round_off" );
    level.var_dc81f03d76612023 = undefined;
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0x312e705a, Offset: 0x150
// Size: 0xd8, Type: bool
function validation()
{
    if ( level.var_dc81f03d76612023 )
    {
        return false;
    }
    
    foreach ( player in level.players )
    {
        if ( player bgb::is_enabled( "round_off" ) || player bgb::is_enabled( "time_out" ) )
        {
            return false;
        }
        
        if ( player != self && ( player.var_44c8fd4fb28eb652 === "round_off" || player.var_44c8fd4fb28eb652 === "time_out" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0xc50283bd, Offset: 0x231
// Size: 0xf2
function track_round_end()
{
    self endon( #"disconnect" );
    self endon( #"kill_round_off" );
    var_e97a4f4962bc3f25 = bgb::get_bgb_slot( "round_off" );
    
    if ( !isdefined( var_e97a4f4962bc3f25 ) )
    {
        return;
    }
    
    var_6123eea429d6e467 = bgb::function_bc8c83873f4039ba( var_e97a4f4962bc3f25 );
    xuid = function_fffbd405b1911268( self getxuid() );
    
    if ( !isdefined( level.var_60ef36d37839ce06[ xuid ][ "round_off" ] ) )
    {
        level.var_60ef36d37839ce06[ xuid ][ "round_off" ] = 0;
    }
    
    level.var_60ef36d37839ce06[ xuid ][ "round_off" ] = level.var_60ef36d37839ce06[ xuid ][ "round_off" ] + 1;
    
    for ( x = 0; x < 2 ; x++ )
    {
        level waittill( #"bgb_round_end" );
        bgb::function_dfffb969b73ce4df( var_6123eea429d6e467, x + 0.5 );
    }
    
    self notify( #"hash_479a9d058d0f9d3f" );
}

// Namespace zm_bgb_round_off
// Params 1, eflags: 0x4
// Checksum 0x5356f848, Offset: 0x32b
// Size: 0x16
function private on_disconnect( params )
{
    level.var_dc81f03d76612023 = undefined;
}

// Namespace zm_bgb_round_off
// Params 0
// Checksum 0x798c2c47, Offset: 0x349
// Size: 0x25
function deactivate_on_disconnect()
{
    self endon( #"hash_3ef5c470162991fa" );
    self waittill( #"disconnect" );
    level.var_dc81f03d76612023 = undefined;
}

