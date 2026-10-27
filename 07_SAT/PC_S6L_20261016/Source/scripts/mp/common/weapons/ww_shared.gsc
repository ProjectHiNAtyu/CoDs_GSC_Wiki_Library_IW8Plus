// scripts\mp\common\weapons\ww_shared.gsc  (hash_685fe4333d8372d8.gscc) (size: 4042 Bytes / 0xfca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x654a6ec1 (1699376833)
// size ...... 4042 (0xfca)
// includes .. 4   (offset: 0xe92)
// strings ... 12  (offset: 0xeb2)
// dev strs .. 6   (offset: 0xf76)
// exports ... 12  (offset: 0x8d2)
// cseg ...... 0x140 + 0x792 (0x8d2)
// imports ... 32  (offset: 0xab2)
// animtree1 . 0   (offset: 0xfca)
// animtree2 . 0   (offset: 0xfca)
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;

#namespace ww_shared;

// Namespace ww_shared
// Params 0, eflags: 0x5
// Checksum 0xb520ca29, Offset: 0x15e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ww_shared", undefined, undefined, &post_main );
}

// Namespace ww_shared
// Params 2
// Checksum 0xfeca09f, Offset: 0x17f
// Size: 0x11f
function show_hud_tutorial_message( tutorial_message_text, message_duration = 9.5 )
{
    self notify( #"hash_808d6c1208bfc7e5" );
    self endon( #"hash_808d6c1208bfc7e5" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    assert( isnumber( message_duration ), "<dev string:x24>" );
    message_duration = max( message_duration, 2 );
    
    if ( !scripted_widgets::is_active( "ww_tutorial_message_zm" ) )
    {
        scripted_widgets::create( "ww_tutorial_message_zm", "scripted_widget_ww_tutorial_message_zm" );
    }
    
    scripted_widgets::set_position( "ww_tutorial_message_zm", 0, 0, 0, 0 );
    scripted_widgets::function_f15c5dfb6c0f57c7( "ww_tutorial_message_zm", "locstring_index", getlocstringindex( tutorial_message_text ) ?? 0 );
    scripted_widgets::set_priority( "ww_tutorial_message_zm", -100 );
    scripted_widgets::set_state( "ww_tutorial_message_zm", "Show" );
    wait message_duration - 0.5;
    
    if ( self )
    {
        scripted_widgets::set_state( "ww_tutorial_message_zm", "Hide" );
    }
    else
    {
        return;
    }
    
    wait 0.6;
    
    if ( self && scripted_widgets::is_active( "ww_tutorial_message_zm" ) )
    {
        scripted_widgets::destroy( "ww_tutorial_message_zm" );
    }
}

// Namespace ww_shared
// Params 3
// Checksum 0x9c4aaea6, Offset: 0x2a6
// Size: 0xc3
function function_50a43e11790d1a15( weapon_name, ambient_fx_part_name, var_88a6e05244d65d08 )
{
    assert( isplayer( self ), "<dev string:x57>" );
    assert( isstring( weapon_name ), "<dev string:x8b>" );
    assert( isstring( var_88a6e05244d65d08 ), "<dev string:xa8>" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::function_7c10ea82c1e305b8( ambient_fx_part_name, var_88a6e05244d65d08 );
    self notify( "stop_monitor_ww_ambient_fx_" + weapon_name + "_state" );
    waitframe();
    
    if ( self )
    {
        data = get_ww_player_data( weapon_name );
        data.ambient_fx_part_name = undefined;
        data.var_bc3ad5120bbdf8ea = undefined;
        data.var_88a6e05244d65d08 = undefined;
    }
}

// Namespace ww_shared
// Params 5
// Checksum 0x302127cf, Offset: 0x371
// Size: 0x1c1
function function_3472b693f638483a( weapon_name, ambient_fx_part_name, var_bc3ad5120bbdf8ea, var_88a6e05244d65d08, var_a2a098d2015a5434 )
{
    self notify( #"hash_29533bd58e346150" );
    self endon( #"hash_29533bd58e346150" );
    assert( isplayer( self ), "<dev string:x57>" );
    assert( isstring( weapon_name ), "<dev string:x8b>" );
    assert( isstring( ambient_fx_part_name ), "<dev string:xd0>" );
    assert( isstring( var_bc3ad5120bbdf8ea ), "<dev string:xf6>" );
    assert( isstring( var_88a6e05244d65d08 ), "<dev string:xa8>" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_ww_ambient_fx_" + weapon_name + "_state" );
    childthread function_68ec63128ba030ec( weapon_name );
    childthread function_13a498dce15e6900( weapon_name );
    childthread function_1f96acfd76120b74( weapon_name );
    duration = var_a2a098d2015a5434 ?? 0.2;
    wait duration;
    data = get_ww_player_data( weapon_name );
    data.ambient_fx_part_name = ambient_fx_part_name;
    data.var_bc3ad5120bbdf8ea = var_bc3ad5120bbdf8ea;
    data.var_88a6e05244d65d08 = var_88a6e05244d65d08;
    
    while ( true )
    {
        if ( !data.is_switching && !data.is_raising && !data.inspect_end )
        {
            if ( !level.var_50a43e11790d1a15 )
            {
                utility::function_32b24db3127bff40( data.ambient_fx_part_name, data.var_bc3ad5120bbdf8ea );
            }
            else
            {
                utility::function_32b24db3127bff40( data.ambient_fx_part_name, data.var_88a6e05244d65d08 );
            }
        }
        
        waitframe();
    }
}

// Namespace ww_shared
// Params 0, eflags: 0x4
// Checksum 0x4da73961, Offset: 0x53a
// Size: 0x38
function private post_main()
{
    utility::registersharedfunc( #"ww_shared", #"show_hud_tutorial_message", &show_hud_tutorial_message );
    scene::function_85b13b837056bc8b( &disable_ambient_fx );
    scene::function_53de0775d8452750( &enable_ambient_fx );
}

// Namespace ww_shared
// Params 0, eflags: 0x4
// Checksum 0x7b4f8f03, Offset: 0x57a
// Size: 0xd
function private disable_ambient_fx()
{
    level.var_50a43e11790d1a15 = 1;
}

// Namespace ww_shared
// Params 0, eflags: 0x4
// Checksum 0x43adba32, Offset: 0x58f
// Size: 0xc
function private enable_ambient_fx()
{
    level.var_50a43e11790d1a15 = 0;
}

// Namespace ww_shared
// Params 1, eflags: 0xc
// Checksum 0x70e8f825, Offset: 0x5a3
// Size: 0x12e
function private function_68ec63128ba030ec( weapon_name )
{
    self notify( #"hash_be8673608acd87d9" );
    self endon( #"hash_be8673608acd87d9" );
    data = get_ww_player_data( weapon_name );
    data.is_switching = 0;
    
    while ( true )
    {
        self waittill( #"weapon_switch_started" );
        waitframe();
        
        if ( data.ambient_fx_part_name && data.var_88a6e05244d65d08 )
        {
            utility::function_32b24db3127bff40( data.ambient_fx_part_name, data.var_88a6e05244d65d08 );
        }
        
        data.is_switching = 1;
        
        while ( true )
        {
            result = utility::waittill_any_return_params( "weapon_raise_code", "weapon_switch_canceled", "offhand_end", "melee_fired" );
            
            if ( result[ "message" ] == "weapon_raise_code" || result[ "message" ] == "melee_fired" )
            {
                weapon = result[ 0 ];
                
                if ( isweapon( weapon ) && weapon.basename == weapon_name )
                {
                    break;
                }
                
                continue;
            }
            
            break;
        }
        
        data.is_switching = 0;
    }
}

// Namespace ww_shared
// Params 1, eflags: 0xc
// Checksum 0x9d313fe9, Offset: 0x6d9
// Size: 0xd3
function private function_13a498dce15e6900( weapon_name )
{
    self notify( #"hash_e1ac67706aa339b3" );
    self endon( #"hash_e1ac67706aa339b3" );
    data = get_ww_player_data( weapon_name );
    data.is_raising = 0;
    
    while ( true )
    {
        self waittill( #"weapon_raise_code", weapon );
        
        if ( weapon.basename != weapon_name )
        {
            continue;
        }
        
        data.is_raising = 1;
        
        if ( data.ambient_fx_part_name && data.var_88a6e05244d65d08 )
        {
            utility::function_32b24db3127bff40( data.ambient_fx_part_name, data.var_88a6e05244d65d08 );
        }
        
        wait 0.1;
        data.is_raising = 0;
    }
}

// Namespace ww_shared
// Params 1, eflags: 0xc
// Checksum 0x2e77f17, Offset: 0x7b4
// Size: 0xbc
function private function_1f96acfd76120b74( weapon_name )
{
    self notify( #"hash_3d2fe7202e87c2c4" );
    self endon( #"hash_3d2fe7202e87c2c4" );
    data = get_ww_player_data( weapon_name );
    data.inspect_end = 0;
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        
        while ( self function_985124b0e1e74f2e() )
        {
            waitframe();
        }
        
        data.inspect_end = 1;
        
        if ( data.ambient_fx_part_name && data.var_88a6e05244d65d08 )
        {
            utility::function_32b24db3127bff40( data.ambient_fx_part_name, data.var_88a6e05244d65d08 );
        }
        
        waitframe();
        data.inspect_end = 0;
    }
}

// Namespace ww_shared
// Params 1
// Checksum 0x58571325, Offset: 0x878
// Size: 0x5a
function get_ww_player_data( weapon_name )
{
    if ( !isarray( self.ww_shared_player_data ) )
    {
        self.ww_shared_player_data = [];
    }
    
    if ( isstring( weapon_name ) )
    {
        if ( !isdefined( self.ww_shared_player_data[ weapon_name ] ) )
        {
            self.ww_shared_player_data[ weapon_name ] = {};
        }
        
        return self.ww_shared_player_data[ weapon_name ];
    }
}

