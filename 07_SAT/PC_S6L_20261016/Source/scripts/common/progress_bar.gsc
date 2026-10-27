// scripts\common\progress_bar.gsc  (hash_234fa4de8d0826e7.gscc) (size: 2349 Bytes / 0x92d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xafbb5b1 (184268209)
// size ...... 2349 (0x92d)
// includes .. 2   (offset: 0x861)
// strings ... 9   (offset: 0x871)
// dev strs .. 5   (offset: 0x8e9)
// exports ... 8   (offset: 0x4ed)
// cseg ...... 0x101 + 0x3ec (0x4ed)
// imports ... 18  (offset: 0x62d)
// animtree1 . 0   (offset: 0x92d)
// animtree2 . 0   (offset: 0x92d)
#using scripts\common\scripted_widgets;
#using scripts\common\utility;

#namespace progress_bar;

// Namespace progress_bar
// Params 7
// Checksum 0x5735f4e2, Offset: 0x11f
// Size: 0x142
function create( widget_ref, var_3bf9c78e48b6679b = undefined, widget_asset = undefined, init_progress_float = 0, default_str = undefined, param_str = "Default", stream_and_wait = 1 )
{
    assert( !scripted_widgets::is_active( widget_ref ), "<dev string:x24>" );
    fields = [];
    fields[ "progress_pct" ] = init_progress_float;
    fields[ "locstring_index" ] = getlocstringindex( default_str );
    
    if ( !isdefined( var_3bf9c78e48b6679b ) )
    {
        var_3bf9c78e48b6679b = {};
    }
    
    var_3bf9c78e48b6679b.ref = widget_ref;
    var_3bf9c78e48b6679b.param = param_str;
    
    if ( !isdefined( widget_asset ) )
    {
        widget_asset = scripted_widgets::function_652736891a41e948( "scripted_widget_progressbar" );
    }
    
    var_3bf9c78e48b6679b.fields = fields;
    scripted_widgets::create( widget_ref, widget_asset, var_3bf9c78e48b6679b, stream_and_wait );
    scripted_widgets::function_dd7a63eea5bde0dc( widget_ref, fields );
    
    if ( var_3bf9c78e48b6679b.state )
    {
        waitframe();
    }
    
    show_progressbar( widget_ref );
    thread utility::thread_on_notify( "ProgressBarAnimFinished", &close, undefined, undefined, "scripted_widget_destroyed_" + widget_ref, widget_ref );
}

// Namespace progress_bar
// Params 7
// Checksum 0xe455468e, Offset: 0x269
// Size: 0x10e
function function_cba379f6af7ebedc( widget_ref, var_3bf9c78e48b6679b, widget_asset = undefined, init_progress_float = 0, default_str = undefined, param_str = "Default", stream_and_wait = 1 )
{
    assert( !scripted_widgets::is_active( widget_ref ), "<dev string:x24>" );
    assert( isstruct( var_3bf9c78e48b6679b ) );
    anchor_struct = var_3bf9c78e48b6679b.anchor_struct;
    assert( isstruct( anchor_struct ) );
    var_3bf9c78e48b6679b.ent = anchor_struct.ent;
    var_3bf9c78e48b6679b.anchor_type = anchor_struct.anchor_type;
    var_3bf9c78e48b6679b.remove_on_death = anchor_struct.remove_on_death;
    create( widget_ref, var_3bf9c78e48b6679b, widget_asset, init_progress_float, default_str, param_str, stream_and_wait );
}

// Namespace progress_bar
// Params 1
// Checksum 0x1c8e236d, Offset: 0x37f
// Size: 0x36
function show_progressbar( widget_ref )
{
    assert( isdefined( widget_ref ) && scripted_widgets::is_active( widget_ref ), "<dev string:x5a>" );
    set_progress_state( widget_ref, "show" );
}

// Namespace progress_bar
// Params 2
// Checksum 0x2bba4436, Offset: 0x3bd
// Size: 0x56
function hide_progressbar( widget_ref, destroy_on_hide_bool = 0 )
{
    assert( isdefined( widget_ref ), "<dev string:x84>" );
    
    if ( scripted_widgets::is_active( widget_ref ) )
    {
        scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "destroy_on_hide", destroy_on_hide_bool );
        set_progress_state( widget_ref, "hide" );
    }
}

// Namespace progress_bar
// Params 2
// Checksum 0x783beb99, Offset: 0x41b
// Size: 0x45
function set_progress_state( widget_ref, state_ref_str )
{
    assert( isdefined( widget_ref ) && scripted_widgets::is_active( widget_ref ) && isstring( state_ref_str ), "<dev string:xa9>" );
    scripted_widgets::set_state( widget_ref, state_ref_str );
}

// Namespace progress_bar
// Params 2
// Checksum 0x97b21881, Offset: 0x468
// Size: 0x40
function function_c2b337c258c8a34( widget_ref, progress_float )
{
    assert( isdefined( widget_ref ), "<dev string:xe4>" );
    
    if ( scripted_widgets::is_active( widget_ref ) )
    {
        scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "progress_pct", progress_float );
    }
}

// Namespace progress_bar
// Params 1
// Checksum 0xdb0113e3, Offset: 0x4b0
// Size: 0x3d
function close( widget_ref )
{
    assert( isdefined( widget_ref ), "<dev string:x84>" );
    
    if ( scripted_widgets::is_active( widget_ref ) )
    {
        thread scripted_widgets::destroy( widget_ref );
        self notify( "scripted_widget_destroyed_" + widget_ref, widget_ref );
    }
}

