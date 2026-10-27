// scripts\mp\ob\ob_reward_select.gsc  (hash_4eebd6895951c28c.gscc) (size: 1685 Bytes / 0x695 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf538b367 (4114133863)
// size ...... 1685 (0x695)
// includes .. 2   (offset: 0x625)
// strings ... 2   (offset: 0x635)
// dev strs .. 5   (offset: 0x659)
// exports ... 7   (offset: 0x315)
// cseg ...... 0x90 + 0x285 (0x315)
// imports ... 18  (offset: 0x42d)
// animtree1 . 0   (offset: 0x695)
// animtree2 . 0   (offset: 0x695)
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;

#namespace ob_reward_select;

// Namespace ob_reward_select
// Params 1
// Checksum 0x66cd7665, Offset: 0xae
// Size: 0x17, Type: bool
function ob_reward_select_is_active( var_7197385f9266378 )
{
    return scripted_widgets::is_active( "ob_reward_select" );
}

// Namespace ob_reward_select
// Params 1
// Checksum 0xc6d271d5, Offset: 0xce
// Size: 0xa6
function open_ob_reward_select( var_7197385f9266378 )
{
    assert( !ob_reward_select_is_active(), "<dev string:x24>" );
    
    if ( ob_reward_select_is_active() )
    {
        return;
    }
    
    self.ob_reward_select_screen = spawnstruct();
    self.ob_reward_select_screen.var_7197385f9266378 = var_7197385f9266378;
    self.var_3de5f173c0cfbb1e = 1;
    self notify( #"activated_ob_reward_select" );
    scripted_widgets::create( "ob_reward_select", scripted_widgets::function_652736891a41e948( "scripted_widget_reward_selection" ) );
    scripted_widgets::set_position( "ob_reward_select", 0, 0, 3, 3 );
    fields = [];
    self.current_ob_reward_select = self;
    return 1;
}

// Namespace ob_reward_select
// Params 1
// Checksum 0xa44cab0e, Offset: 0x17d
// Size: 0xb6
function close_ob_reward_select( val )
{
    if ( isdefined( self.current_ob_reward_select ) )
    {
        if ( isdefined( self.current_ob_reward_select.var_94f5e86c4d3a4227 ) )
        {
            self.current_ob_reward_select notify( self.current_ob_reward_select.var_94f5e86c4d3a4227, self );
        }
        
        if ( isdefined( self.current_ob_reward_select.ob_reward_select_screen.var_7197385f9266378 ) )
        {
            self.current_ob_reward_select thread [[ self.current_ob_reward_select.ob_reward_select_screen.var_7197385f9266378 ]]( self );
        }
        
        scripted_widgets::destroy( "ob_reward_select" );
        self disablephysicaldepthoffieldscripting();
        self.current_ob_reward_select = undefined;
    }
}

/#

    // Namespace ob_reward_select
    // Params 0
    // Checksum 0x68f3ed34, Offset: 0x23b
    // Size: 0x2e, Type: dev
    function init_ob_reward_select_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4d>" );
        devgui::add_devgui_func( "<dev string:x5f>", "<dev string:x6b>", &function_b66a2fa63b7e0f5d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_reward_select
    // Params 0
    // Checksum 0xdbb6074c, Offset: 0x271
    // Size: 0x83, Type: dev
    function function_b66a2fa63b7e0f5d()
    {
        foreach ( player in level.players )
        {
            player open_ob_reward_select( &function_4e3694303556d570 );
        }
    }

    // Namespace ob_reward_select
    // Params 1
    // Checksum 0xcfb6f7f2, Offset: 0x2fc
    // Size: 0x19, Type: dev
    function function_4e3694303556d570( player )
    {
        iprintlnbold( "<dev string:x77>" );
    }

#/
