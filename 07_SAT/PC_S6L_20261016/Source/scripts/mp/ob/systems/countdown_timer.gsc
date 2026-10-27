// scripts\mp\ob\systems\countdown_timer.gsc  (hash_2970fb89f0b66550.gscc) (size: 1812 Bytes / 0x714 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d19d423 (1561973795)
// size ...... 1812 (0x714)
// includes .. 2   (offset: 0x65c)
// strings ... 7   (offset: 0x66c)
// dev strs .. 5   (offset: 0x6cc)
// exports ... 5   (offset: 0x3dc)
// cseg ...... 0x109 + 0x2d3 (0x3dc)
// imports ... 14  (offset: 0x4a4)
// animtree1 . 0   (offset: 0x714)
// animtree2 . 0   (offset: 0x714)
#using scripts\common\scripted_widgets;
#using scripts\common\utility;

#namespace countdown_timer;

// Namespace countdown_timer
// Params 9
// Checksum 0x3caf49fe, Offset: 0x127
// Size: 0x1a8
function create( widget_ref, widget_asset = undefined, var_9a9b67dc9cb62ec1 = 0, var_3bf9c78e48b6679b = undefined, default_str = undefined, param_str, use_game_clock = 1, auto_expire = 1, stream_and_wait = 0 )
{
    assert( isthreaded() || !stream_and_wait );
    assert( !scripted_widgets::is_active( widget_ref ), "<dev string:x24>" );
    fields = [];
    fields[ "message_locstring_index" ] = getlocstringindex( default_str );
    fields[ "countdown" ] = var_9a9b67dc9cb62ec1;
    fields[ "use_game_clock" ] = use_game_clock;
    fields[ "auto_expire" ] = auto_expire;
    
    if ( !isdefined( var_3bf9c78e48b6679b ) )
    {
        var_3bf9c78e48b6679b = {};
    }
    
    var_3bf9c78e48b6679b.ref = widget_ref;
    
    if ( !isdefined( widget_asset ) )
    {
        widget_asset = scripted_widgets::function_652736891a41e948( "scripted_widget_countdown_timer" );
    }
    
    var_3bf9c78e48b6679b.fields = fields;
    var_3bf9c78e48b6679b.position = { #vertical_anchor:0, #horizontal_anchor:1, #top:120, #left:0 };
    scripted_widgets::create( widget_ref, widget_asset, var_3bf9c78e48b6679b, stream_and_wait );
    scripted_widgets::function_dd7a63eea5bde0dc( widget_ref, fields );
    
    if ( var_9a9b67dc9cb62ec1 != 0 )
    {
        utility::delaythread( var_9a9b67dc9cb62ec1, &close, widget_ref );
    }
    
    thread utility::thread_on_notify( "NotificationAnimFinished", &close, undefined, undefined, "scripted_widget_destroyed_" + widget_ref, widget_ref );
}

// Namespace countdown_timer
// Params 2
// Checksum 0xf1b40f88, Offset: 0x2d7
// Size: 0x5e
function update_message( widget_ref, message_str )
{
    assert( isdefined( widget_ref ), "<dev string:x5d>" );
    assert( scripted_widgets::is_active( widget_ref ), "<dev string:x82>" );
    assert( isdefined( message_str ), "<dev string:xbb>" );
    thread scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "message_locstring_index", getlocstringindex( message_str ) );
}

// Namespace countdown_timer
// Params 2
// Checksum 0x88c12cc8, Offset: 0x33d
// Size: 0x5a
function update_countdown( widget_ref, countdown )
{
    assert( isdefined( widget_ref ), "<dev string:xe6>" );
    assert( scripted_widgets::is_active( widget_ref ), "<dev string:x82>" );
    assert( isdefined( countdown ), "<dev string:xe6>" );
    thread scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "countdown", countdown );
}

// Namespace countdown_timer
// Params 1
// Checksum 0x75c3cd3c, Offset: 0x39f
// Size: 0x3d
function close( widget_ref )
{
    assert( isdefined( widget_ref ), "<dev string:x5d>" );
    
    if ( scripted_widgets::is_active( widget_ref ) )
    {
        thread scripted_widgets::destroy( widget_ref );
        self notify( "scripted_widget_destroyed_" + widget_ref, widget_ref );
    }
}

