// scripts\common\chyron.gsc  (hash_1ef733a204b3599f.gscc) (size: 3584 Bytes / 0xe00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b139587 (2601751943)
// size ...... 3584 (0xe00)
// includes .. 5   (offset: 0xcdc)
// strings ... 11  (offset: 0xd04)
// dev strs .. 8   (offset: 0xda0)
// exports ... 8   (offset: 0x850)
// cseg ...... 0x151 + 0x6ff (0x850)
// imports ... 29  (offset: 0x990)
// animtree1 . 0   (offset: 0xe00)
// animtree2 . 0   (offset: 0xe00)
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;

#namespace chyron;

// Namespace chyron
// Params 0, eflags: 0x5
// Checksum 0x97f42d72, Offset: 0x16f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"chyron", undefined, undefined, &post_main );
}

// Namespace chyron
// Params 0, eflags: 0x4
// Checksum 0x8769fabf, Offset: 0x190
// Size: 0x27
function private post_main()
{
    thread _init_chyron();
    utility::registersharedfunc( #"chyron", #"hash_147f02c28c4c2b04", &show_chyron );
}

// Namespace chyron
// Params 0, eflags: 0x4
// Checksum 0xb80a42ca, Offset: 0x1bf
// Size: 0x15b
function private _init_chyron()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) != 0 )
        {
            return;
        }
    #/
    
    level utility::flag_set( "introscreen_custom" );
    level utility::flag_wait( "scripted_widgets_initialized" );
    var_f5e66184d41f3fe8 = scripted_widgets::function_652736891a41e948( "scripted_widget_chyron" );
    
    if ( !isdefined( var_f5e66184d41f3fe8 ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x56>" + "<dev string:x6d>" );
    }
    
    mapinfo = getactivemapinfobundle();
    
    if ( !isdefined( mapinfo ) )
    {
        return;
    }
    
    level.var_648497113aba3bbc = {};
    level.var_648497113aba3bbc.widget = var_f5e66184d41f3fe8;
    level.var_648497113aba3bbc.var_bfdb98658efd79d0 = [];
    
    if ( mapinfo.var_bfdb98658efd79d0.size > 0 )
    {
        for ( i = 0; i < mapinfo.var_bfdb98658efd79d0.size ; i++ )
        {
            var_648497113aba3bbc = mapinfo.var_bfdb98658efd79d0[ i ];
            bundle = "chyron:" + var_648497113aba3bbc.chyron;
            var_31389415574c377f = getscriptbundle( bundle );
            level.var_648497113aba3bbc.var_bfdb98658efd79d0[ var_648497113aba3bbc.reference ] = var_31389415574c377f;
        }
    }
    
    level utility::flag_set( "chyrons_initialized" );
}

// Namespace chyron
// Params 7
// Checksum 0xba38e5bf, Offset: 0x322
// Size: 0x13d
function function_a6d314bf326b0e52( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x = undefined, pos_offset_y = undefined, show_hud_on_complete = 1, delay_to_show = 0 )
{
    assert( isplayer( self ), "<dev string:xb1>" );
    players = utility::callsharedfunc( #"squad_utility", #"getsquadmembers", self.team, 1 );
    
    if ( players && players.size > 0 )
    {
        foreach ( player in players )
        {
            player thread show_chyron( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x, pos_offset_y, show_hud_on_complete, delay_to_show );
        }
        
        return;
    }
    
    show_chyron( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x, pos_offset_y, show_hud_on_complete );
}

// Namespace chyron
// Params 7
// Checksum 0xae486f2f, Offset: 0x467
// Size: 0xe5
function function_d41002779543c80e( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x = undefined, pos_offset_y = undefined, show_hud_on_complete = 1, delay_to_show = 0 )
{
    foreach ( player in level.players )
    {
        player thread show_chyron( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x, pos_offset_y, show_hud_on_complete, delay_to_show );
    }
}

// Namespace chyron
// Params 7
// Checksum 0x6e3e45d5, Offset: 0x554
// Size: 0x29f
function show_chyron( var_f02cdcd56dc59b1, delay_reveal_chyron_line, delay_hide_chyron, pos_offset_x = undefined, pos_offset_y = undefined, show_hud_on_complete = 1, delay_to_show = 0 )
{
    self endon( #"death_or_disconnect" );
    self endon( #"chyron_hidden" );
    level utility::flag_wait( "chyrons_initialized" );
    
    if ( !( isdefined( level.var_648497113aba3bbc ) && isdefined( level.var_648497113aba3bbc.var_bfdb98658efd79d0 ) ) )
    {
        assertmsg( "<dev string:xd9>" + getdvar( @"ui_mapname" ) + "<dev string:x10d>" );
        return;
    }
    
    level.var_648497113aba3bbc.show_hud_on_complete = show_hud_on_complete;
    
    if ( !isdefined( var_f02cdcd56dc59b1 ) )
    {
        chyron_index = 0;
    }
    else
    {
        var_648497113aba3bbc = level.var_648497113aba3bbc.var_bfdb98658efd79d0[ var_f02cdcd56dc59b1 ];
        assert( isdefined( var_648497113aba3bbc ), "<dev string:x148>" + var_f02cdcd56dc59b1 + "<dev string:x163>" );
        chyron_index = -1;
        
        foreach ( key, chyron in level.var_648497113aba3bbc.var_bfdb98658efd79d0 )
        {
            chyron_index++;
            
            if ( var_f02cdcd56dc59b1 == key )
            {
                break;
            }
        }
    }
    
    if ( delay_to_show > 0 )
    {
        wait delay_to_show;
    }
    
    scripted_widgets::create( "chyron_display", level.var_648497113aba3bbc.widget );
    fields = [];
    fields[ "chyron_index" ] = chyron_index;
    fields[ "delay_reveal_chyron_line" ] = delay_reveal_chyron_line ?? 0.5;
    fields[ "delay_hide_chyron" ] = delay_hide_chyron ?? 3;
    scripted_widgets::function_dd7a63eea5bde0dc( "chyron_display", fields );
    
    if ( isnumber( pos_offset_x ) && isnumber( pos_offset_y ) )
    {
        scripted_widgets::set_position( "chyron_display", pos_offset_x, pos_offset_y, 0, 2, 1 );
    }
    
    widgets_visibility::hide( "chyron_display", [ #"chyron" ], 1, 1 );
    level notify( #"chyron_shown" );
    thread utility::thread_on_notify( "ChyronAnimFinished", &function_1fb3749d12e3e7fe, undefined, undefined, "scripted_widget_destroyed_" + "chyron_display", "chyron_display" );
}

// Namespace chyron
// Params 1
// Checksum 0xfe70fd29, Offset: 0x7fb
// Size: 0x55
function function_1fb3749d12e3e7fe( ref )
{
    scripted_widgets::destroy( ref );
    
    if ( level.var_648497113aba3bbc.show_hud_on_complete )
    {
        val::reset_all( ref );
    }
    
    widgets_visibility::reset( ref );
    self notify( #"chyron_hidden" );
    level notify( #"chyron_hidden" );
}

