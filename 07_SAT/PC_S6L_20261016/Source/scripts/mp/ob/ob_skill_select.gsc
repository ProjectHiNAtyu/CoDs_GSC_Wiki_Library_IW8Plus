// scripts\mp\ob\ob_skill_select.gsc  (hash_14f26c71266409a8.gscc) (size: 1719 Bytes / 0x6b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51aaaeb1 (1370140337)
// size ...... 1719 (0x6b7)
// includes .. 2   (offset: 0x647)
// strings ... 2   (offset: 0x657)
// dev strs .. 5   (offset: 0x67b)
// exports ... 7   (offset: 0x337)
// cseg ...... 0x8e + 0x2a9 (0x337)
// imports ... 18  (offset: 0x44f)
// animtree1 . 0   (offset: 0x6b7)
// animtree2 . 0   (offset: 0x6b7)
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;

#namespace ob_skill_select;

// Namespace ob_skill_select
// Params 1
// Checksum 0xd4e88abb, Offset: 0xac
// Size: 0x17
function ob_skill_select_is_active( var_7197385f9266378 )
{
    return scripted_widgets::is_active( "ob_skill_select" );
}

// Namespace ob_skill_select
// Params 1
// Checksum 0x4c7d69a, Offset: 0xcc
// Size: 0xca
function open_ob_skill_select( var_7197385f9266378 )
{
    assert( !ob_skill_select_is_active(), "<dev string:x24>" );
    
    if ( ob_skill_select_is_active() )
    {
        return;
    }
    
    self.ob_skill_select_screen = spawnstruct();
    self.ob_skill_select_screen.var_7197385f9266378 = var_7197385f9266378;
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"deactivate_ob_skill_select" );
    self.var_3de5f173c0cfbb1e = 1;
    self notify( #"activated_ob_skill_select" );
    scripted_widgets::create( "ob_skill_select", scripted_widgets::function_652736891a41e948( "scripted_widget_ob_skill_select" ) );
    scripted_widgets::set_position( "ob_skill_select", 0, 0, 3, 3 );
    fields = [];
    self.current_ob_skill_select = self;
    return 1;
}

// Namespace ob_skill_select
// Params 1
// Checksum 0xb847c594, Offset: 0x19f
// Size: 0xb6
function close_ob_skill_select( val )
{
    if ( isdefined( self.current_ob_skill_select ) )
    {
        if ( isdefined( self.current_ob_skill_select.var_e16b18318cd0ac01 ) )
        {
            self.current_ob_skill_select notify( self.current_ob_skill_select.var_e16b18318cd0ac01, self );
        }
        
        if ( isdefined( self.current_ob_skill_select.ob_skill_select_screen.var_7197385f9266378 ) )
        {
            self.current_ob_skill_select thread [[ self.current_ob_skill_select.ob_skill_select_screen.var_7197385f9266378 ]]( self );
        }
        
        scripted_widgets::destroy( "ob_skill_select" );
        self disablephysicaldepthoffieldscripting();
        self.current_ob_skill_select = undefined;
    }
}

/#

    // Namespace ob_skill_select
    // Params 0
    // Checksum 0x96da6057, Offset: 0x25d
    // Size: 0x2e, Type: dev
    function init_ob_skill_select_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4c>" );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x80>", &function_3cdc0bbeb3b0b279 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_skill_select
    // Params 0
    // Checksum 0x8b17f1d, Offset: 0x293
    // Size: 0x83, Type: dev
    function function_3cdc0bbeb3b0b279()
    {
        foreach ( player in level.players )
        {
            player open_ob_skill_select( &function_5992d4aea9c1b18c );
        }
    }

    // Namespace ob_skill_select
    // Params 1
    // Checksum 0x2702b87d, Offset: 0x31e
    // Size: 0x19, Type: dev
    function function_5992d4aea9c1b18c( player )
    {
        iprintlnbold( "<dev string:x8c>" );
    }

#/
