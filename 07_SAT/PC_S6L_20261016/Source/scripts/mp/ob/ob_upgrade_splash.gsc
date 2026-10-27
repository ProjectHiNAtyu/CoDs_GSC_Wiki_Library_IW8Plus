// scripts\mp\ob\ob_upgrade_splash.gsc  (hash_29bf891c6a9bf1ec.gscc) (size: 1387 Bytes / 0x56b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4deba767 (1307289447)
// size ...... 1387 (0x56b)
// includes .. 2   (offset: 0x507)
// strings ... 2   (offset: 0x517)
// dev strs .. 4   (offset: 0x53b)
// exports ... 6   (offset: 0x253)
// cseg ...... 0x92 + 0x1c1 (0x253)
// imports ... 16  (offset: 0x343)
// animtree1 . 0   (offset: 0x56b)
// animtree2 . 0   (offset: 0x56b)
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;

#namespace ob_upgrade_splash;

// Namespace ob_upgrade_splash
// Params 1
// Checksum 0xc6be0a72, Offset: 0xb0
// Size: 0x17
function ob_upgrade_splash_is_active( var_7197385f9266378 )
{
    return scripted_widgets::is_active( "ob_upgrade_splash" );
}

// Namespace ob_upgrade_splash
// Params 0
// Checksum 0x60396ca3, Offset: 0xd0
// Size: 0x7e
function open_ob_upgrade_splash()
{
    assert( !ob_upgrade_splash_is_active(), "<dev string:x24>" );
    
    if ( ob_upgrade_splash_is_active() )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"deactivate_ob_upgrade_splash" );
    self notify( #"activated_ob_upgrade_splash" );
    scripted_widgets::create( "ob_upgrade_splash", scripted_widgets::function_652736891a41e948( "scripted_widget_ob_upgrade_splash" ), {}, 1 );
    scripted_widgets::set_position( "ob_upgrade_splash", 0, 0, 3, 3 );
    return 1;
}

// Namespace ob_upgrade_splash
// Params 1
// Checksum 0x69384617, Offset: 0x157
// Size: 0x29
function close_ob_upgrade_splash( val )
{
    if ( !ob_upgrade_splash_is_active() )
    {
        return;
    }
    
    scripted_widgets::destroy( "ob_upgrade_splash" );
    self disablephysicaldepthoffieldscripting();
}

/#

    // Namespace ob_upgrade_splash
    // Params 0
    // Checksum 0x3d09e4de, Offset: 0x188
    // Size: 0x2e, Type: dev
    function init_ob_upgrade_splash_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4e>" );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x86>", &test_ob_upgrade_splash );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_upgrade_splash
    // Params 0
    // Checksum 0x17956279, Offset: 0x1be
    // Size: 0x95, Type: dev
    function test_ob_upgrade_splash()
    {
        foreach ( player in level.players )
        {
            player open_ob_upgrade_splash();
            player waittill( #"upgradesplashhide" );
            player close_ob_upgrade_splash();
        }
    }

#/
