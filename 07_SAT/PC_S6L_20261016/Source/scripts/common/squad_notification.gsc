// scripts\common\squad_notification.gsc  (hash_1c60ab21d797632e.gscc) (size: 1579 Bytes / 0x62b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7fa7881d (2141685789)
// size ...... 1579 (0x62b)
// includes .. 2   (offset: 0x58b)
// strings ... 7   (offset: 0x59b)
// dev strs .. 4   (offset: 0x5f7)
// exports ... 4   (offset: 0x347)
// cseg ...... 0x10c + 0x23b (0x347)
// imports ... 14  (offset: 0x3e7)
// animtree1 . 0   (offset: 0x62b)
// animtree2 . 0   (offset: 0x62b)
#using scripts\common\scripted_widgets;
#using scripts\common\utility;

#namespace squad_notification;

// Namespace squad_notification
// Params 9
// Checksum 0x69d74575, Offset: 0x12a
// Size: 0x172
function create( widget_ref, widget_asset = undefined, var_9a9b67dc9cb62ec1 = 0, var_3bf9c78e48b6679b = undefined, default_str = undefined, param_str, use_game_clock = 1, auto_expire = 1, stream_and_wait = 1 )
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
        widget_asset = scripted_widgets::function_652736891a41e948( "scripted_widget_squad_notification" );
    }
    
    var_3bf9c78e48b6679b.fields = fields;
    scripted_widgets::create( widget_ref, widget_asset, var_3bf9c78e48b6679b, stream_and_wait );
    scripted_widgets::function_dd7a63eea5bde0dc( widget_ref, fields );
    
    if ( var_9a9b67dc9cb62ec1 != 0 )
    {
        utility::delaythread( var_9a9b67dc9cb62ec1, &close, widget_ref );
    }
    
    thread utility::thread_on_notify( "NotificationAnimFinished", &close, undefined, undefined, "scripted_widget_destroyed_" + widget_ref, widget_ref );
}

// Namespace squad_notification
// Params 2
// Checksum 0x1cd77089, Offset: 0x2a4
// Size: 0x5e
function update_message( widget_ref, message_str )
{
    assert( isdefined( widget_ref ), "<dev string:x60>" );
    assert( scripted_widgets::is_active( widget_ref ), "<dev string:x85>" );
    assert( isdefined( message_str ), "<dev string:xc1>" );
    thread scripted_widgets::function_f15c5dfb6c0f57c7( widget_ref, "message_locstring_index", getlocstringindex( message_str ) );
}

// Namespace squad_notification
// Params 1
// Checksum 0x1fcd0384, Offset: 0x30a
// Size: 0x3d
function close( widget_ref )
{
    assert( isdefined( widget_ref ), "<dev string:x60>" );
    
    if ( scripted_widgets::is_active( widget_ref ) )
    {
        thread scripted_widgets::destroy( widget_ref );
        self notify( "scripted_widget_destroyed_" + widget_ref, widget_ref );
    }
}

