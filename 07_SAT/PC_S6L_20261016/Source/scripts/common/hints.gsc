// scripts\common\hints.gsc  (hash_60e6726c84077552.gscc) (size: 14264 Bytes / 0x37b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea1a758f (3927602575)
// size ...... 14264 (0x37b8)
// includes .. 6   (offset: 0x3520)
// strings ... 30  (offset: 0x3550)
// dev strs .. 6   (offset: 0x3768)
// exports ... 36  (offset: 0x23b8)
// cseg ...... 0x2ce + 0x20ea (0x23b8)
// imports ... 94  (offset: 0x2958)
// animtree1 . 0   (offset: 0x37b8)
// animtree2 . 0   (offset: 0x37b8)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;

#namespace hints;

// Namespace hints
// Params 0, eflags: 0x5
// Checksum 0x2d699e0a, Offset: 0x2ec
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hints", undefined, undefined, &post_main );
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0xfc987378, Offset: 0x30d
// Size: 0x9
function private post_main()
{
    thread _init_hints();
}

// Namespace hints
// Params 1, eflags: 0x4
// Checksum 0xbaacaec, Offset: 0x31e
// Size: 0x183
function private function_86101f3788ceeafc( hint_widget )
{
    level.hint_widget = hint_widget;
    data = getscriptbundle( hint_widget );
    assert( isdefined( data ), "<dev string:x24>" );
    data.hints = [];
    
    foreach ( param in data.parameters )
    {
        foreach ( property in param.properties )
        {
            if ( property.variant_object.property == "object_data" )
            {
                data.hints[ param.name ] = getscriptbundle( property.variant_object.value );
                break;
            }
        }
    }
    
    level.hint_widget_data = data;
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0x219dcc53, Offset: 0x4a9
// Size: 0x152
function private _init_hints()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) != 0 )
        {
            return;
        }
    #/
    
    level utility::flag_wait( "scripted_widgets_initialized" );
    utility::registersharedfunc( #"hint", #"add", &hint_add );
    utility::registersharedfunc( #"hint", #"add_action", &hint_add_action );
    utility::registersharedfunc( #"hint", #"add_simple", &hint_add_simple );
    utility::registersharedfunc( #"hint", #"add_wait", &hint_add_wait );
    utility::registersharedfunc( #"hint", #"add_action_wait", &function_61801f33a20df1e );
    utility::registersharedfunc( #"hint", #"add_simple_wait", &function_16f7a983ce97090e );
    utility::registersharedfunc( #"hint", #"close", &hint_close );
    utility::registersharedfunc( #"hint", #"exists", &hint_exists );
    utility::registersharedfunc( #"hint", #"get_current_hint_ref", &get_current_hint_ref );
    ui::lui_registercallback( "hint_interact", &hint_interact );
    level utility::flag_set( "hints_initialized" );
}

// Namespace hints
// Params 1, eflags: 0x4
// Checksum 0x17e57e4a, Offset: 0x603
// Size: 0x76
function private hint_interact( val )
{
    if ( isdefined( self.hints.interacts[ val - 1 ] ) && isdefined( self.hints.interacts[ val - 1 ].script_notify ) )
    {
        self notify( self.hints.interacts[ val - 1 ].script_notify );
    }
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0x7096eb3e, Offset: 0x681
// Size: 0x7e
function private function_ca00e47a0e5ea19a()
{
    assert( isplayer( self ), "<dev string:xbc>" );
    
    if ( !isdefined( self.hints ) )
    {
        self.hints = {};
        self.hints.hint_queue = [];
        self.hints.hint_ref = undefined;
        self.hints.hint_paused = 0;
        self.hints.var_29d124a5685cb31a = 0;
    }
}

// Namespace hints
// Params 2, eflags: 0x4
// Checksum 0x856f65d7, Offset: 0x707
// Size: 0x19a
function private get_hint_object( hint_ref, var_d7141974df312f3f )
{
    hint_widget = undefined;
    
    if ( isstring( var_d7141974df312f3f ) )
    {
        hint_widget = hashcat( %"scriptedwidget:", var_d7141974df312f3f );
    }
    else
    {
        hint_widget = scripted_widgets::function_652736891a41e948( "scripted_widget_hints" );
    }
    
    if ( isdefined( hint_widget ) )
    {
        data = getscriptbundle( hint_widget );
        
        if ( isdefined( data.parameters ) )
        {
            foreach ( param in data.parameters )
            {
                if ( param.name == hint_ref )
                {
                    foreach ( property in param.properties )
                    {
                        if ( property.variant_object.property == "object_data" )
                        {
                            return getscriptbundle( property.variant_object.value );
                        }
                    }
                }
            }
        }
    }
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0x1d5358ac, Offset: 0x8a9
// Size: 0x15
function private get_current_hint_ref()
{
    return self.hints.hint_ref;
}

// Namespace hints
// Params 2, eflags: 0x4
// Checksum 0xc2b57812, Offset: 0x8c7
// Size: 0x10f
function private skip_tutorial( hint_ref, var_d7141974df312f3f )
{
    object_data = get_hint_object( hint_ref, var_d7141974df312f3f );
    
    if ( isdefined( object_data.interactions ) )
    {
        foreach ( interaction in object_data.interactions )
        {
            if ( isdefined( interaction.script_notify ) )
            {
                self notify( interaction.script_notify );
            }
        }
    }
    
    self notify( hint_ref + "_closed" );
    
    if ( !isdefined( self.hints.hint_ref ) || self.hints.hint_ref == hint_ref )
    {
        self notify( #"hint_close" );
    }
}

// Namespace hints
// Params 2
// Checksum 0xf4f19470, Offset: 0x9de
// Size: 0x3c, Type: bool
function is_tutorial( hint_ref, var_d7141974df312f3f )
{
    object_data = get_hint_object( hint_ref, var_d7141974df312f3f );
    return isdefined( object_data ) && object_data.istutorial;
}

// Namespace hints
// Params 9
// Checksum 0xab743aa8, Offset: 0xa23
// Size: 0x171
function function_ccd82ecebe5d387e( anchor_ent, widget_ref, hint_widget = "scripted_widget_in_world_marker_tutorial", anchor_settings = "scripted_widget_anchor_overhead_clamped_ingame_tutorial", msg_string, show_distance = 1, init_param_str = "Default", init_state_ref, var_e71dfd313bcd065b )
{
    assert( isent( anchor_ent ), "<dev string:xf1>" );
    assert( isstring( widget_ref ), "<dev string:x129>" );
    self endon( #"death_or_disconnect" );
    self endon( "scripted_widget_destroyed_" + widget_ref );
    level utility::flag_wait( "hints_initialized" );
    widget_struct = { #param:init_param_str };
    
    if ( isdefined( init_state_ref ) )
    {
        assert( isstring( init_state_ref ), "<dev string:x165>" );
        widget_struct.state = init_state_ref;
    }
    
    scripted_widgets::anchored_add( anchor_ent, widget_ref, hint_widget, anchor_settings, widget_struct );
    fields = [];
    fields[ "show_distance" ] = show_distance;
    
    if ( isdefined( msg_string ) )
    {
        fields[ "locstring_index" ] = getlocstringindex( msg_string );
    }
    
    scripted_widgets::function_f67a7797f3301a25( anchor_ent, widget_ref, fields );
    
    if ( isdefined( var_e71dfd313bcd065b ) )
    {
        self endon( "scripted_widget_destroyed_" + widget_ref );
        utility::waittill_string( var_e71dfd313bcd065b, anchor_ent );
        thread function_ed0d5d94e69d96f9( anchor_ent, widget_ref );
    }
}

// Namespace hints
// Params 2
// Checksum 0xdd0f6118, Offset: 0xb9c
// Size: 0x51
function function_ed0d5d94e69d96f9( anchor_ent, widget_ref )
{
    assert( isent( anchor_ent ), "<dev string:xf1>" );
    assert( isstring( widget_ref ), "<dev string:x129>" );
    
    if ( scripted_widgets::anchored_is_active( anchor_ent, widget_ref ) )
    {
        scripted_widgets::anchored_remove( anchor_ent, widget_ref );
    }
}

// Namespace hints
// Params 9
// Checksum 0x509267b7, Offset: 0xbf5
// Size: 0x28c
function hint_add( hint_ref, timeout, breakfunc, notify_to_end, var_3610044c43c692e8 = 1, var_d7141974df312f3f, var_56862b32cbaa568f = 1, hide_widgets_array, over_everything )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    level utility::flag_wait( "hints_initialized" );
    is_tutorial = is_tutorial( hint_ref, var_d7141974df312f3f );
    
    if ( is_tutorial && utility::callsharedfunc( #"game", #"getplayerprofiledata", "tutorialsEnabled" ) != 1 )
    {
        utility::delaythread( level.framedurationseconds, &skip_tutorial, hint_ref, var_d7141974df312f3f );
        return;
    }
    
    if ( !var_56862b32cbaa568f && utility::callsharedfunc( #"save", #"get_hint_seen", hint_ref ) )
    {
        utility::delaythread( level.framedurationseconds, &skip_tutorial, hint_ref, var_d7141974df312f3f );
        return;
    }
    
    function_ca00e47a0e5ea19a();
    
    if ( !function_7d3145f64c6bcd53( hint_ref ) )
    {
        return;
    }
    
    self notify( #"hint_add" );
    
    if ( isdefined( self.hints.hint_ref ) || self.hints.hint_paused || scripted_widgets::is_active( "hint_display" ) )
    {
        next_hint = spawnstruct();
        next_hint.hint_ref = hint_ref;
        next_hint.timeout = timeout;
        next_hint.breakfunc = breakfunc;
        next_hint.notify_to_end = notify_to_end;
        next_hint.var_3610044c43c692e8 = var_3610044c43c692e8;
        next_hint.hide_widgets_table = hide_widgets_array;
        next_hint.over_everything = over_everything;
        
        if ( is_tutorial && !is_tutorial( self.hints.hint_ref ) )
        {
            self.hints.hint_queue = arraycombine( [ next_hint ], self.hints.hint_queue );
            hint_close( undefined, 1 );
        }
        else
        {
            self.hints.hint_queue[ self.hints.hint_queue.size ] = next_hint;
        }
        
        return;
    }
    
    hint_open( hint_ref, timeout, breakfunc, notify_to_end, var_3610044c43c692e8, var_d7141974df312f3f, hide_widgets_array, over_everything );
}

// Namespace hints
// Params 1, eflags: 0x4
// Checksum 0xc44c9b74, Offset: 0xe89
// Size: 0xd0, Type: bool
function private function_7d3145f64c6bcd53( hint_ref )
{
    if ( self.hints.hint_ref == hint_ref || self.hints.hiding_hint == hint_ref )
    {
        return false;
    }
    
    foreach ( hint_data in self.hints.hint_queue )
    {
        if ( hint_data.hint_ref == hint_ref )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace hints
// Params 9
// Checksum 0xa775655, Offset: 0xf62
// Size: 0x73
function hint_add_wait( hint_ref, timeout, breakfunc, notify_to_end, var_3610044c43c692e8, var_d7141974df312f3f, var_56862b32cbaa568f, hide_widgets_array, over_everything )
{
    thread hint_add( hint_ref, timeout, breakfunc, notify_to_end, var_3610044c43c692e8, var_d7141974df312f3f, var_56862b32cbaa568f, hide_widgets_array, over_everything );
    self waittill( hint_ref + "_closed" );
}

// Namespace hints
// Params 10, eflags: 0x4
// Checksum 0x24152fad, Offset: 0xfdd
// Size: 0x275
function private function_d792d6ae3ac16678( hint_ref, var_f8b58c3acd8b5fe1, timeout = 0, breakfunc, notify_to_end, delay = 0, var_3610044c43c692e8 = 1, var_8af000a92aab4e85 = 0, var_56862b32cbaa568f = 1, over_everything )
{
    assert( isdefined( hint_ref ) );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    level utility::flag_wait( "hints_initialized" );
    
    if ( !var_56862b32cbaa568f && utility::callsharedfunc( #"save", #"get_hint_seen", hint_ref ) )
    {
        return;
    }
    
    function_ca00e47a0e5ea19a();
    
    if ( !function_7d3145f64c6bcd53( hint_ref ) )
    {
        return;
    }
    
    self notify( #"hint_add" );
    
    if ( !var_8af000a92aab4e85 && ( isdefined( self.hints.hint_ref ) || self.hints.hint_paused || scripted_widgets::is_active( "hint_display" ) ) )
    {
        next_hint = spawnstruct();
        next_hint.hint_ref = hint_ref;
        next_hint.var_f8b58c3acd8b5fe1 = var_f8b58c3acd8b5fe1;
        next_hint.timeout = timeout;
        next_hint.breakfunc = breakfunc;
        next_hint.notify_to_end = notify_to_end;
        next_hint.delay = delay;
        next_hint.var_8af000a92aab4e85 = var_8af000a92aab4e85;
        next_hint.var_3610044c43c692e8 = var_3610044c43c692e8;
        next_hint.over_everything = over_everything;
        
        if ( is_tutorial( hint_ref ) && !is_tutorial( self.hints.hint_ref ) )
        {
            self.hints.hint_queue = arraycombine( [ next_hint ], self.hints.hint_queue );
            hint_close( undefined, 1 );
        }
        else
        {
            self.hints.hint_queue[ self.hints.hint_queue.size ] = next_hint;
        }
        
        return;
    }
    
    hint_open_simple( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_8af000a92aab4e85, over_everything );
}

// Namespace hints
// Params 9
// Checksum 0xeb7ed14, Offset: 0x125a
// Size: 0x10f
function hint_add_action( hint_ref, var_f8b58c3acd8b5fe1, timeout = 0, breakfunc, notify_to_end, delay = 0, var_3610044c43c692e8 = 1, var_56862b32cbaa568f = 1, over_everything )
{
    if ( is_tutorial( hint_ref ) && utility::callsharedfunc( #"game", #"getplayerprofiledata", "tutorialsEnabled" ) != 1 )
    {
        utility::delaythread( level.framedurationseconds, &skip_tutorial, hint_ref );
        return;
    }
    
    if ( !var_56862b32cbaa568f && utility::callsharedfunc( #"save", #"get_hint_seen", hint_ref ) )
    {
        utility::delaythread( level.framedurationseconds, &skip_tutorial, hint_ref );
        return;
    }
    
    function_d792d6ae3ac16678( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, 1, var_56862b32cbaa568f, over_everything );
}

// Namespace hints
// Params 9
// Checksum 0xaf08ae2f, Offset: 0x1371
// Size: 0x7f
function function_61801f33a20df1e( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_56862b32cbaa568f, over_everything )
{
    self endon( #"death_or_disconnect" );
    thread hint_add_action( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_56862b32cbaa568f, over_everything );
    self waittill( hint_ref + "_closed" );
}

// Namespace hints
// Params 9
// Checksum 0xa89d47bb, Offset: 0x13f8
// Size: 0x8b
function hint_add_simple( hint_ref, var_f8b58c3acd8b5fe1, timeout = 0, breakfunc, notify_to_end, delay = 0, var_3610044c43c692e8 = 1, var_56862b32cbaa568f = 1, over_everything )
{
    function_d792d6ae3ac16678( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, 0, var_56862b32cbaa568f, over_everything );
}

// Namespace hints
// Params 10
// Checksum 0xee74bed7, Offset: 0x148b
// Size: 0x8a
function function_16f7a983ce97090e( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_56862b32cbaa568f, var_8af000a92aab4e85, over_everything )
{
    self endon( #"death_or_disconnect" );
    thread function_d792d6ae3ac16678( hint_ref, var_f8b58c3acd8b5fe1, timeout, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_8af000a92aab4e85, var_56862b32cbaa568f, over_everything );
    self waittill( hint_ref + "_closed" );
}

// Namespace hints
// Params 2
// Checksum 0xd2c993cb, Offset: 0x151d
// Size: 0x51, Type: bool
function hint_exists( hint_ref, var_d7141974df312f3f )
{
    hint_widget = var_d7141974df312f3f ?? scripted_widgets::function_652736891a41e948( "scripted_widget_hints" );
    
    if ( !isdefined( hint_widget ) || !scripted_widgets::type_exists( hint_widget ) )
    {
        return false;
    }
    
    return isdefined( scripted_widgets::get_param_index( hint_widget, hint_ref ) );
}

// Namespace hints
// Params 9, eflags: 0x4
// Checksum 0x1305c7a1, Offset: 0x1577
// Size: 0x1b1
function private hint_open_simple( hint_ref, var_f8b58c3acd8b5fe1, timeout = 0, breakfunc, notify_to_end, delay, var_3610044c43c692e8, var_8af000a92aab4e85, over_everything )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        scripted_widgets::destroy( "hint_display" );
    }
    
    var_2f6b643608a5943e = scripted_widgets::function_652736891a41e948( "scripted_widget_hint_toasts" );
    assert( isdefined( var_2f6b643608a5943e ) );
    level.hint_widget = var_2f6b643608a5943e;
    scripted_widgets::create( "hint_display", level.hint_widget, { #over_everything:over_everything } );
    scripted_widgets::set_position( "hint_display", 0, 0, 3, 3, 0 );
    scripted_widgets::set_priority( "hint_display", 6 );
    scripted_widgets::function_dd7a63eea5bde0dc( "hint_display", function_6c37d920a4852e01( var_f8b58c3acd8b5fe1 ), 1 );
    
    if ( var_8af000a92aab4e85 )
    {
        scripted_widgets::set_state( "hint_display", "Center" );
        waitframe();
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    thread function_b4903116e38229a9();
    hint_show();
    function_ca00e47a0e5ea19a();
    self.hints.hint_ref = hint_ref;
    self notify( self.hints.hint_ref + "_shown" );
    
    if ( isdefined( notify_to_end ) )
    {
        thread function_b59c40b5f8e749f3( notify_to_end, var_3610044c43c692e8 );
    }
    
    if ( isdefined( breakfunc ) )
    {
        thread hint_close_func( breakfunc, var_3610044c43c692e8 );
    }
    
    if ( timeout > 0 )
    {
        thread hint_close_timeout( timeout, var_3610044c43c692e8 );
    }
    
    thread remove_on_death();
}

// Namespace hints
// Params 2, eflags: 0x4
// Checksum 0x816dcf2a, Offset: 0x1730
// Size: 0x47
function private function_b59c40b5f8e749f3( notify_str, var_3610044c43c692e8 = 1 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hint_close" );
    self waittill( notify_str );
    thread hint_close( undefined, !var_3610044c43c692e8 );
}

// Namespace hints
// Params 0, eflags: 0xc
// Checksum 0x6cfb6a64, Offset: 0x177f
// Size: 0xb3
function private function_b4903116e38229a9()
{
    self notify( #"hash_b93774729f0428cc" );
    self endon( #"hash_b93774729f0428cc" );
    self endon( #"death_or_disconnect" );
    self endon( #"hint_close" );
    
    while ( true )
    {
        ret = utility::waittill_any_return( "hint_close_anim_complete", "hint_close_request" );
        
        if ( ret == "hint_close_anim_complete" )
        {
            if ( self.hints.hiding_hint == self.hints.hint_ref )
            {
                thread hint_close( undefined, 1 );
            }
            
            continue;
        }
        
        thread hint_close( self.hints.hint_ref, 0 );
    }
}

// Namespace hints
// Params 8, eflags: 0x4
// Checksum 0x945d49c8, Offset: 0x183a
// Size: 0x456
function private hint_open( hint_ref, timeout, breakfunc, notify_to_end, var_3610044c43c692e8, var_d7141974df312f3f, hide_widgets_array, over_everything )
{
    if ( isstring( var_d7141974df312f3f ) )
    {
        function_86101f3788ceeafc( hashcat( %"scriptedwidget:", var_d7141974df312f3f ) );
    }
    else
    {
        hint_widget = scripted_widgets::function_652736891a41e948( "scripted_widget_hints" );
        assert( isdefined( hint_widget ) );
        function_86101f3788ceeafc( hint_widget );
    }
    
    widgetstruct = spawnstruct();
    widgetstruct.param = hint_ref;
    widgetstruct.over_everything = over_everything;
    assert( isdefined( hint_ref ) );
    
    foreach ( param in level.hint_widget_data.parameters )
    {
        if ( param.name == hint_ref )
        {
            foreach ( property in param.properties )
            {
                if ( property.variant_object.property == "object_data" )
                {
                    object_data = getscriptbundle( property.variant_object.value );
                    widgetstruct.object_data = object_data;
                    break;
                }
            }
            
            break;
        }
    }
    
    if ( isdefined( hide_widgets_array ) )
    {
        widgets_visibility::hide( "hint_display", hide_widgets_array );
    }
    
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        scripted_widgets::destroy( "hint_display" );
    }
    
    scripted_widgets::create( "hint_display", level.hint_widget, widgetstruct );
    scripted_widgets::set_position( "hint_display", 0, 0, 3, 3, 0 );
    
    if ( widgetstruct.object_data.hideshud )
    {
        val::set( "hint_display", "cg_drawcrosshair", 0 );
        val::set( "hint_display", "show_hud", 0 );
    }
    
    scripted_widgets::set_priority( "hint_display", 6 );
    
    if ( isdefined( timeout ) )
    {
        assert( isnumber( timeout ), "<dev string:x1a7>" );
        hint_archetype_fields = [];
        hint_archetype_fields[ "timer" ] = timeout;
        scripted_widgets::function_dd7a63eea5bde0dc( "hint_display", hint_archetype_fields, 1 );
    }
    
    thread function_b4903116e38229a9();
    hint_show();
    self.hints.hint_ref = hint_ref;
    
    if ( isdefined( self.hints.hint_ref ) )
    {
        self notify( self.hints.hint_ref + "_shown" );
    }
    
    if ( isdefined( widgetstruct.object_data ) )
    {
        if ( widgetstruct.object_data.timescale < 0 )
        {
            self.hints.var_29d124a5685cb31a = 1;
            utility::script_func( "slowmo_managed_start", "campaign_hints", widgetstruct.object_data.timescale, 0 );
        }
        
        if ( isdefined( widgetstruct.object_data.var_bc665452d45e800 ) )
        {
            val::set( "hint_display", "allow_movement", 0 );
            val::set( "hint_display", "freezecontrols_allowlook", 1 );
        }
        
        self.hints.interacts = widgetstruct.object_data.interactions;
    }
    
    if ( isdefined( notify_to_end ) )
    {
        thread function_b59c40b5f8e749f3( notify_to_end, var_3610044c43c692e8 );
    }
    
    if ( isdefined( breakfunc ) )
    {
        thread hint_close_func( breakfunc, var_3610044c43c692e8 );
    }
    
    if ( isdefined( timeout ) )
    {
        thread hint_close_timeout( timeout, var_3610044c43c692e8 );
    }
    
    thread remove_on_death();
}

// Namespace hints
// Params 0
// Checksum 0x6d101ad4, Offset: 0x1c98
// Size: 0x21
function hint_show()
{
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        scripted_widgets::set_state( "hint_display", "show" );
    }
}

// Namespace hints
// Params 0
// Checksum 0x500ea9d5, Offset: 0x1cc1
// Size: 0x48
function hint_hide()
{
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        self.hints.hiding_hint = self.hints.hint_ref;
        scripted_widgets::set_state( "hint_display", "hide" );
    }
}

// Namespace hints
// Params 2
// Checksum 0x6edae240, Offset: 0x1d11
// Size: 0x3f3
function hint_close( hint_ref = undefined, immediate = 0 )
{
    self endon( #"death_or_disconnect" );
    is_current_ref = !isdefined( hint_ref ) || hint_ref == self.hints.hint_ref;
    
    if ( !immediate && is_current_ref )
    {
        hint_hide();
        return;
    }
    
    if ( is_current_ref )
    {
        self.hints.hiding_hint = undefined;
        
        if ( self.hints.var_29d124a5685cb31a )
        {
            utility::script_func( "slowmo_managed_end", "campaign_hints", 0 );
            self.hints.var_29d124a5685cb31a = 0;
        }
        
        val::reset_all( "hint_display" );
        widgets_visibility::reset( "hint_display" );
        self notify( #"hint_close" );
        
        while ( self.hints.hint_paused )
        {
            waitframe();
        }
        
        if ( isdefined( self.hints ) )
        {
            if ( isdefined( self.hints.hint_ref ) )
            {
                thread utility::callsharedfunc( #"save", #"set_hint_seen", self.hints.hint_ref, 1 );
                self notify( self.hints.hint_ref + "_closed" );
                self.hints.hint_ref = undefined;
            }
            
            while ( self.hints.hint_queue.size > 0 )
            {
                next_hint = self.hints.hint_queue[ 0 ];
                self.hints.hint_queue[ 0 ] = undefined;
                function_cdc669dbc8ea2101( self.hints.hint_queue );
                
                if ( isdefined( next_hint.var_f8b58c3acd8b5fe1 ) )
                {
                    if ( !isdefined( next_hint.breakfunc ) || !self [[ next_hint.breakfunc ]]() )
                    {
                        thread hint_open_simple( next_hint.hint_ref, next_hint.var_f8b58c3acd8b5fe1, next_hint.timeout, next_hint.breakfunc, next_hint.notify_to_end, next_hint.delay, next_hint.var_3610044c43c692e8, next_hint.var_8af000a92aab4e85, next_hint.over_everything );
                        return;
                    }
                    
                    continue;
                }
                
                if ( !isdefined( next_hint.breakfunc ) || !self [[ next_hint.breakfunc ]]() )
                {
                    thread hint_open( next_hint.hint_ref, next_hint.timeout, next_hint.breakfunc, next_hint.notify_to_end, next_hint.var_3610044c43c692e8, next_hint.hide_widgets_table, next_hint.over_everything );
                    return;
                }
            }
        }
        
        hint_remove();
        return;
    }
    
    if ( isdefined( self.hints ) && isdefined( self.hints.hint_queue ) )
    {
        foreach ( index, hint_data in self.hints.hint_queue )
        {
            if ( hint_data.hint_ref == hint_ref )
            {
                self.hints.hint_queue[ index ] = undefined;
                
                if ( isint( index ) )
                {
                    function_cdc669dbc8ea2101( self.hints.hint_queue );
                }
            }
        }
    }
}

// Namespace hints
// Params 2
// Checksum 0x56962658, Offset: 0x210c
// Size: 0x59
function hint_close_func( breakfunc, var_37de315baedf1d52 = 1 )
{
    self endon( #"hint_close" );
    
    while ( !self [[ breakfunc ]]() || self.hints.hint_paused )
    {
        waitframe();
    }
    
    thread hint_close( undefined, !var_37de315baedf1d52 );
}

// Namespace hints
// Params 2
// Checksum 0x1f753c28, Offset: 0x216d
// Size: 0xba
function hint_close_timeout( timeout, var_8320670775ba614f = 1 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hint_close" );
    start_time = gettime();
    wait timeout;
    
    while ( self.hints.hint_paused )
    {
        waitframe();
    }
    
    if ( self.hints.hint_paused_start_time >= start_time )
    {
        thread hint_close_timeout( timeout - ( self.hints.hint_paused_start_time - start_time ) / 1000 );
        return;
    }
    
    thread hint_close( undefined, !var_8320670775ba614f );
}

// Namespace hints
// Params 0
// Checksum 0x36825b43, Offset: 0x222f
// Size: 0x37
function function_540b8ac4f8df4381()
{
    self.hints.hint_paused = 1;
    self.hints.hint_paused_start_time = gettime();
    thread hint_hide();
}

// Namespace hints
// Params 0
// Checksum 0xb9088580, Offset: 0x226e
// Size: 0xb4
function function_b6967c830f20e097()
{
    self.hints.hint_paused = 0;
    
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        thread hint_show();
        return;
    }
    
    if ( level.hint_queue.size > 0 )
    {
        next_hint = self.hints.hint_queue[ 0 ];
        thread hint_open( next_hint.hint_ref, next_hint.timeout, next_hint.breakfunc );
        self.hints.hint_queue[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.hints.hint_queue );
    }
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0xcd4dc105, Offset: 0x232a
// Size: 0x26
function private hint_remove()
{
    if ( scripted_widgets::is_active( "hint_display" ) )
    {
        self.hints = undefined;
        scripted_widgets::destroy( "hint_display" );
    }
}

// Namespace hints
// Params 1, eflags: 0x4
// Checksum 0xa0e9ddb0, Offset: 0x2358
// Size: 0x29
function private function_6c37d920a4852e01( message_title_str )
{
    fields = [];
    fields[ "title_locstring_index" ] = getlocstringindex( message_title_str );
    return fields;
}

// Namespace hints
// Params 0, eflags: 0x4
// Checksum 0x4524273, Offset: 0x238a
// Size: 0x2e
function private remove_on_death()
{
    self endon( #"disconnect" );
    self endon( #"hint_close" );
    self waittill( #"death" );
    thread hint_remove();
}

