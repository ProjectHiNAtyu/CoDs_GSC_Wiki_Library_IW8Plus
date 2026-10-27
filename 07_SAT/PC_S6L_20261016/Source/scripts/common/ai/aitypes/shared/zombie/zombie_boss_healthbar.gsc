// scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar.gsc  (hash_7129baf8ee832ed2.gscc) (size: 4763 Bytes / 0x129b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b6092af (459313839)
// size ...... 4763 (0x129b)
// includes .. 2   (offset: 0x11db)
// strings ... 8   (offset: 0x11eb)
// dev strs .. 3   (offset: 0x1273)
// exports ... 19  (offset: 0xaaf)
// cseg ...... 0xee + 0x9c1 (0xaaf)
// imports ... 32  (offset: 0xda7)
// animtree1 . 0   (offset: 0x129b)
// animtree2 . 0   (offset: 0x129b)
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;

#namespace zombie_boss_healthbar;

// Namespace zombie_boss_healthbar
// Params 1
// Checksum 0xd376d89e, Offset: 0x10c
// Size: 0x9a
function function_f50a10314e72caa1( var_f1c90c56c55773c5 )
{
    if ( isdefined( self.animsetname ) )
    {
        template = callback::get_template( self.animsetname );
        func = var_f1c90c56c55773c5 ?? &function_34fa8d0cfe24d6aa;
        
        if ( !template callback::exists( #"on_ai_damaged", func ) )
        {
            template callback::add( #"on_ai_damaged", func );
        }
    }
    
    if ( !level callback::exists( "on_boss_progress_updated", &on_boss_progress_updated ) )
    {
        level callback::add( "on_boss_progress_updated", &on_boss_progress_updated );
    }
}

// Namespace zombie_boss_healthbar
// Params 1
// Checksum 0x3668f539, Offset: 0x1ae
// Size: 0x98
function function_d16104a6c7125d2d( var_f1c90c56c55773c5 )
{
    if ( isdefined( self.animsetname ) )
    {
        template = callback::get_template( self.animsetname );
        func = var_f1c90c56c55773c5 ?? &function_34fa8d0cfe24d6aa;
        
        if ( template callback::exists( #"on_ai_damaged", func ) )
        {
            template callback::remove( #"on_ai_damaged", func );
        }
    }
    
    if ( level callback::exists( "on_boss_progress_updated", &on_boss_progress_updated ) )
    {
        level callback::remove( "on_boss_progress_updated", &on_boss_progress_updated );
    }
}

// Namespace zombie_boss_healthbar
// Params 0
// Checksum 0xe6538a58, Offset: 0x24e
// Size: 0x91
function init_zombie_boss_healthbar()
{
    if ( self.var_6f21c22a420f0038 )
    {
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar_show( self.var_6f21c22a420f0038, self );
        }
    }
}

// Namespace zombie_boss_healthbar
// Params 0
// Checksum 0xf6654b10, Offset: 0x2e7
// Size: 0x87
function function_57cec007b96540a4()
{
    if ( self.var_6f21c22a420f0038 )
    {
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar_hide();
        }
    }
}

// Namespace zombie_boss_healthbar
// Params 3
// Checksum 0x8ac3209a, Offset: 0x376
// Size: 0x1bf
function zombie_boss_healthbar_show( var_3c78c5f31278c74f, var_e616e8964b9d5819, widget_struct )
{
    s_bundle = getscriptbundle( "bosshealthbar:" + var_3c78c5f31278c74f );
    assert( isdefined( s_bundle ), "<dev string:x24>" + var_3c78c5f31278c74f + "<dev string:x50>" );
    
    if ( isdefined( s_bundle ) )
    {
        level.var_14719442b1c9d3ae = int( s_bundle.var_d163c5110958ca28 );
        
        if ( !function_44d523f97fcaa324() )
        {
            function_88114d9474978a1( widget_struct );
        }
        
        function_3cbd3855f84e7d31( "Vulnerable" );
        var_dc0a06d5c804fe02 = function_43b5ed5a14a56573( #"hash_9c9913488ca22949", hashcat( %"bosshealthbar:", var_3c78c5f31278c74f ) );
        assert( isdefined( var_dc0a06d5c804fe02 ), "<dev string:x24>" + var_3c78c5f31278c74f + "<dev string:x67>" );
        
        if ( var_dc0a06d5c804fe02 )
        {
            scripted_widgets::function_f15c5dfb6c0f57c7( "zm_boss_health_bar", "asset_index", var_dc0a06d5c804fe02 );
        }
        
        if ( self.var_7fa280bb4c563541 != var_e616e8964b9d5819 )
        {
            function_28a50fc7eea37be( self.var_7fa280bb4c563541, self );
        }
        
        self.var_7fa280bb4c563541 = var_e616e8964b9d5819;
        
        if ( isalive( var_e616e8964b9d5819 ) )
        {
            if ( !var_e616e8964b9d5819 callback::exists( #"on_ai_killed", &function_e304e2f9b89344ca ) )
            {
                var_e616e8964b9d5819 callback::add( #"on_ai_killed", &function_e304e2f9b89344ca );
            }
            
            if ( !var_e616e8964b9d5819 callback::exists( #"on_zombie_ai_killed", &function_e304e2f9b89344ca ) )
            {
                var_e616e8964b9d5819 callback::add( #"on_zombie_ai_killed", &function_e304e2f9b89344ca );
            }
            
            healthbar_set_health( var_e616e8964b9d5819.health, var_e616e8964b9d5819.maxhealth );
            return;
        }
        
        if ( isstruct( var_e616e8964b9d5819 ) )
        {
            healthbar_set_health( var_e616e8964b9d5819.health, var_e616e8964b9d5819.maxhealth );
        }
    }
}

// Namespace zombie_boss_healthbar
// Params 2
// Checksum 0x14b439e8, Offset: 0x53d
// Size: 0xa3
function healthbar_set_health( health = 0, maxhealth = 1 )
{
    if ( function_44d523f97fcaa324() )
    {
        maxwidth = 500;
        
        if ( isdefined( level.var_14719442b1c9d3ae ) )
        {
            maxwidth = level.var_14719442b1c9d3ae;
        }
        
        current_health_percent = health / maxhealth;
        
        if ( health <= 0 || maxhealth == 1 )
        {
            current_health_percent = 0;
        }
        
        var_8c57f71e0781ce25 = int( max( maxwidth * current_health_percent, 1 ) );
        waitframe();
        scripted_widgets::function_f15c5dfb6c0f57c7( "zm_boss_health_bar", "width", var_8c57f71e0781ce25 );
    }
}

// Namespace zombie_boss_healthbar
// Params 1
// Checksum 0xd0f32f9f, Offset: 0x5e8
// Size: 0xc
function function_db02000f515bd5c6( health )
{
    
}

// Namespace zombie_boss_healthbar
// Params 0
// Checksum 0xaf3c8e13, Offset: 0x5fc
// Size: 0x32
function zombie_boss_healthbar_hide()
{
    function_28a50fc7eea37be( self.var_7fa280bb4c563541, self );
    self.var_7fa280bb4c563541 = undefined;
    
    if ( scripted_widgets::is_active( "zm_boss_health_bar" ) )
    {
        function_5eb7baa0860aed01();
    }
}

// Namespace zombie_boss_healthbar
// Params 1
// Checksum 0x7160cd66, Offset: 0x636
// Size: 0x35
function zombie_boss_healthbar_immune( b_immune = 1 )
{
    if ( b_immune )
    {
        function_3cbd3855f84e7d31( "Immune" );
        return;
    }
    
    function_3cbd3855f84e7d31( "Vulnerable" );
}

// Namespace zombie_boss_healthbar
// Params 0
// Checksum 0xd9f38a67, Offset: 0x673
// Size: 0xd, Type: bool
function function_44d523f97fcaa324()
{
    return scripted_widgets::is_active( "zm_boss_health_bar" );
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x327249e6, Offset: 0x689
// Size: 0x97
function private function_34fa8d0cfe24d6aa( params )
{
    foreach ( player in level.players )
    {
        player healthbar_set_health( self.health, self.maxhealth );
    }
}

// Namespace zombie_boss_healthbar
// Params 2, eflags: 0x4
// Checksum 0x50dda3b2, Offset: 0x728
// Size: 0xba
function private function_28a50fc7eea37be( var_e616e8964b9d5819, excluding_player )
{
    if ( !isdefined( var_e616e8964b9d5819 ) || isstruct( var_e616e8964b9d5819 ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player != excluding_player && player.var_7fa280bb4c563541 == var_e616e8964b9d5819 )
        {
            return;
        }
    }
    
    function_e17d927be47995b3( var_e616e8964b9d5819 );
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x90dee30, Offset: 0x7ea
// Size: 0x7e
function private function_e17d927be47995b3( var_e616e8964b9d5819 )
{
    if ( !isdefined( var_e616e8964b9d5819 ) || isstruct( var_e616e8964b9d5819 ) )
    {
        return;
    }
    
    if ( var_e616e8964b9d5819 callback::exists( #"on_ai_killed", &function_e304e2f9b89344ca ) )
    {
        var_e616e8964b9d5819 callback::remove( #"on_ai_killed", &function_e304e2f9b89344ca );
    }
    
    if ( var_e616e8964b9d5819 callback::exists( #"on_zombie_ai_killed", &function_e304e2f9b89344ca ) )
    {
        var_e616e8964b9d5819 callback::remove( #"on_zombie_ai_killed", &function_e304e2f9b89344ca );
    }
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0xece76308, Offset: 0x870
// Size: 0x9d
function private function_e304e2f9b89344ca( params )
{
    foreach ( player in level.players )
    {
        if ( player.var_7fa280bb4c563541 == self )
        {
            player zombie_boss_healthbar_hide();
        }
    }
    
    function_e17d927be47995b3( self );
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x3f6bf61a, Offset: 0x915
// Size: 0x9b
function private on_boss_progress_updated( params )
{
    foreach ( player in level.players )
    {
        player healthbar_set_health( params.health, params.maxhealth );
    }
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x94908cc0, Offset: 0x9b8
// Size: 0xbf
function private function_88114d9474978a1( widget_struct = spawnstruct() )
{
    if ( !isdefined( widget_struct.position ) )
    {
        widget_struct.position = spawnstruct();
        widget_struct.position.left = 0;
        widget_struct.position.top = 0;
        widget_struct.position.horizontal_anchor = 1;
        widget_struct.position.vertical_anchor = 0;
        widget_struct.position.use_safe_area = 1;
    }
    
    scripted_widgets::create( "zm_boss_health_bar", "scripted_widget_boss_healthbar", widget_struct );
}

// Namespace zombie_boss_healthbar
// Params 0, eflags: 0x4
// Checksum 0x9c0f245a, Offset: 0xa7f
// Size: 0xe
function private function_5eb7baa0860aed01()
{
    scripted_widgets::destroy( "zm_boss_health_bar" );
}

// Namespace zombie_boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x9cb83cae, Offset: 0xa95
// Size: 0x1a
function private function_3cbd3855f84e7d31( value )
{
    scripted_widgets::set_state( "zm_boss_health_bar", value );
}

