// scripts\common\scripted_widgets\boss_healthbar.gsc  (hash_38fe73809eda0508.gscc) (size: 4512 Bytes / 0x11a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc0f2686 (3423544966)
// size ...... 4512 (0x11a0)
// includes .. 2   (offset: 0x10f0)
// strings ... 7   (offset: 0x1100)
// dev strs .. 3   (offset: 0x1178)
// exports ... 17  (offset: 0xa3c)
// cseg ...... 0xe1 + 0x95b (0xa3c)
// imports ... 32  (offset: 0xce4)
// animtree1 . 0   (offset: 0x11a0)
// animtree2 . 0   (offset: 0x11a0)
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;

#namespace boss_healthbar;

// Namespace boss_healthbar
// Params 1
// Checksum 0xabee73ab, Offset: 0xff
// Size: 0x9a
function init_boss_healthbar_global( on_damaged_callback )
{
    if ( isdefined( self.animsetname ) )
    {
        template = callback::get_template( self.animsetname );
        func = on_damaged_callback ?? &function_f49d8de897904a01;
        
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

// Namespace boss_healthbar
// Params 1
// Checksum 0x46262aa3, Offset: 0x1a1
// Size: 0x98
function function_1194a0ca02e5e856( on_damaged_callback )
{
    if ( isdefined( self.animsetname ) )
    {
        template = callback::get_template( self.animsetname );
        func = on_damaged_callback ?? &function_f49d8de897904a01;
        
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

// Namespace boss_healthbar
// Params 0
// Checksum 0x6f24c6cf, Offset: 0x241
// Size: 0x91
function function_188f870103dcb348()
{
    if ( self.var_6f21c22a420f0038 )
    {
        foreach ( player in level.players )
        {
            player boss_healthbar_show( self.var_6f21c22a420f0038, self );
        }
    }
}

// Namespace boss_healthbar
// Params 0
// Checksum 0x1a9278e3, Offset: 0x2da
// Size: 0x7b
function function_f557b1f591e4f7b1()
{
    foreach ( player in level.players )
    {
        player boss_healthbar_hide();
    }
}

// Namespace boss_healthbar
// Params 3
// Checksum 0xf6d85f01, Offset: 0x35d
// Size: 0x18e
function boss_healthbar_show( var_3c78c5f31278c74f, boss_entity, widget_struct )
{
    s_bundle = getscriptbundle( "bosshealthbar:" + var_3c78c5f31278c74f );
    assert( isdefined( s_bundle ), "<dev string:x24>" + var_3c78c5f31278c74f + "<dev string:x49>" );
    
    if ( isdefined( s_bundle ) )
    {
        level.var_14719442b1c9d3ae = int( s_bundle.var_d163c5110958ca28 );
        
        if ( !is_boss_healthbar_open() )
        {
            boss_healthbar_create( widget_struct );
        }
        
        set_boss_healthbar_state( "Vulnerable" );
        var_dc0a06d5c804fe02 = function_43b5ed5a14a56573( #"hash_9c9913488ca22949", hashcat( %"bosshealthbar:", var_3c78c5f31278c74f ) );
        assert( isdefined( var_dc0a06d5c804fe02 ), "<dev string:x24>" + var_3c78c5f31278c74f + "<dev string:x60>" );
        
        if ( var_dc0a06d5c804fe02 )
        {
            scripted_widgets::function_f15c5dfb6c0f57c7( "boss_health_bar", "asset_index", var_dc0a06d5c804fe02 );
        }
        
        if ( self.var_467806276fb267d2 != boss_entity )
        {
            function_19866ed6b9f6dc55( self.var_467806276fb267d2, self );
        }
        
        self.var_467806276fb267d2 = boss_entity;
        
        if ( isalive( boss_entity ) )
        {
            if ( !boss_entity callback::exists( #"on_ai_killed", &on_boss_killed ) )
            {
                boss_entity callback::add( #"on_ai_killed", &on_boss_killed );
            }
            
            healthbar_set_health( boss_entity.health, boss_entity.maxhealth );
            return;
        }
        
        if ( isstruct( boss_entity ) )
        {
            healthbar_set_health( boss_entity.health, boss_entity.maxhealth );
        }
    }
}

// Namespace boss_healthbar
// Params 2
// Checksum 0xb2aaeea5, Offset: 0x4f3
// Size: 0xa3
function healthbar_set_health( health = 0, maxhealth = 1 )
{
    if ( is_boss_healthbar_open() )
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
        scripted_widgets::function_f15c5dfb6c0f57c7( "boss_health_bar", "width", var_8c57f71e0781ce25 );
    }
}

// Namespace boss_healthbar
// Params 0
// Checksum 0x68dd8635, Offset: 0x59e
// Size: 0x32
function boss_healthbar_hide()
{
    function_19866ed6b9f6dc55( self.var_467806276fb267d2, self );
    self.var_467806276fb267d2 = undefined;
    
    if ( scripted_widgets::is_active( "boss_health_bar" ) )
    {
        boss_healthbar_remove();
    }
}

// Namespace boss_healthbar
// Params 0
// Checksum 0x60d01ea9, Offset: 0x5d8
// Size: 0xd, Type: bool
function is_boss_healthbar_open()
{
    return scripted_widgets::is_active( "boss_health_bar" );
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x1b549337, Offset: 0x5ee
// Size: 0x97
function private function_f49d8de897904a01( params )
{
    foreach ( player in level.players )
    {
        player healthbar_set_health( self.health, self.maxhealth );
    }
}

// Namespace boss_healthbar
// Params 2, eflags: 0x4
// Checksum 0xec1633c8, Offset: 0x68d
// Size: 0xba
function private function_19866ed6b9f6dc55( boss_entity, excluding_player )
{
    if ( !isdefined( boss_entity ) || isstruct( boss_entity ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player != excluding_player && player.var_467806276fb267d2 == boss_entity )
        {
            return;
        }
    }
    
    function_8b1e04b266fd49c4( boss_entity );
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x752cdb2b, Offset: 0x74f
// Size: 0x4e
function private function_8b1e04b266fd49c4( boss_entity )
{
    if ( !isdefined( boss_entity ) || isstruct( boss_entity ) )
    {
        return;
    }
    
    if ( boss_entity callback::exists( #"on_ai_killed", &on_boss_killed ) )
    {
        boss_entity callback::remove( #"on_ai_killed", &on_boss_killed );
    }
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x3893920a, Offset: 0x7a5
// Size: 0x9d
function private on_boss_killed( params )
{
    foreach ( player in level.players )
    {
        if ( player.var_467806276fb267d2 == self )
        {
            player boss_healthbar_hide();
        }
    }
    
    function_8b1e04b266fd49c4( self );
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x48ac4d9e, Offset: 0x84a
// Size: 0x9b
function private on_boss_progress_updated( params )
{
    foreach ( player in level.players )
    {
        player healthbar_set_health( params.health, params.maxhealth );
    }
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0xb9003de9, Offset: 0x8ed
// Size: 0x117
function private boss_healthbar_create( widget_struct = spawnstruct() )
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
    
    stream_and_wait = 0;
    var_536711e101433266 = 10;
    
    if ( isdefined( widget_struct.streaming ) )
    {
        stream_and_wait = widget_struct.streaming.stream_and_wait;
        var_536711e101433266 = widget_struct.streaming.var_536711e101433266;
    }
    
    scripted_widgets::create( "boss_health_bar", "scripted_widget_boss_healthbar", widget_struct, stream_and_wait, var_536711e101433266 );
}

// Namespace boss_healthbar
// Params 0, eflags: 0x4
// Checksum 0xd9c1a921, Offset: 0xa0c
// Size: 0xe
function private boss_healthbar_remove()
{
    scripted_widgets::destroy( "boss_health_bar" );
}

// Namespace boss_healthbar
// Params 1, eflags: 0x4
// Checksum 0x1d052873, Offset: 0xa22
// Size: 0x1a
function private set_boss_healthbar_state( value )
{
    scripted_widgets::set_state( "boss_health_bar", value );
}

