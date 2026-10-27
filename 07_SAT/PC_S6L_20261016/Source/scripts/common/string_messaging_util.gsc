// scripts\common\string_messaging_util.gsc  (hash_7df192c4714a34bb.gscc) (size: 16168 Bytes / 0x3f28 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe71653d9 (3877000153)
// size ...... 16168 (0x3f28)
// includes .. 5   (offset: 0x3cf0)
// strings ... 33  (offset: 0x3d18)
// dev strs .. 0   (offset: 0x3f28)
// exports ... 28  (offset: 0x3150)
// cseg ...... 0x2eb + 0x2e65 (0x3150)
// imports ... 55  (offset: 0x35b0)
// animtree1 . 0   (offset: 0x3f28)
// animtree2 . 0   (offset: 0x3f28)
#using script_4e1f1a7ef824ddd5;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\player_broadcasting;
#using scripts\common\scripted_widgets;
#using scripts\common\utility;

#namespace string_messaging_util;

// Namespace string_messaging_util
// Params 0
// Checksum 0x1830b611, Offset: 0x309
// Size: 0x88
function _string_messaging_init()
{
    level utility::flag_wait( "scripted_widgets_initialized" );
    
    if ( !scripted_widgets::is_active( "string_messaging" ) )
    {
        widget_type = level.string_messaging_widget_type ?? "scripted_widget_objective_group";
        scripted_widgets::create( "string_messaging", widget_type );
    }
    
    if ( !isdefined( self.var_20edbb1c7dd11bfc ) )
    {
        function_db4bfb509bb8d2cc();
    }
    
    if ( !isdefined( self.var_b4c282567bc129d5 ) )
    {
        function_d360a841dd9001bd();
    }
    
    if ( !isdefined( self.var_508146bb326d420d ) )
    {
        _string_messaging_init_dialog();
    }
}

// Namespace string_messaging_util
// Params 0
// Checksum 0xaf9aa70a, Offset: 0x399
// Size: 0xcd
function function_db4bfb509bb8d2cc()
{
    self.str_msg_toast = [];
    self.var_20edbb1c7dd11bfc = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        toast = spawnstruct();
        toast.idx = i;
        display_idx = 6 + i;
        toast.omnvar_param = "objective_param_" + display_idx;
        toast.omnvar_data1 = "objective_count_" + display_idx;
        toast.omnvar_data2 = "objective_max_count_" + display_idx;
        toast.omnvar_state = "objective_state_" + display_idx;
        toast thread function_da199a69921efc61( self );
        self.str_msg_toast[ self.str_msg_toast.size ] = toast;
    }
}

// Namespace string_messaging_util
// Params 0
// Checksum 0x51b6a86, Offset: 0x46e
// Size: 0xcd
function _string_messaging_init_dialog()
{
    self.str_msg_dialog = [];
    self.var_508146bb326d420d = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        dialog = spawnstruct();
        dialog.idx = i;
        display_idx = 8 + i;
        dialog.omnvar_param = "objective_param_" + display_idx;
        dialog.omnvar_data1 = "objective_count_" + display_idx;
        dialog.omnvar_data2 = "objective_max_count_" + display_idx;
        dialog.omnvar_state = "objective_state_" + display_idx;
        dialog thread function_658bda80b35f96( self );
        self.str_msg_dialog[ self.str_msg_dialog.size ] = dialog;
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x681dbaf4, Offset: 0x543
// Size: 0x349
function function_dfed73672ce3e229( broadcast, message )
{
    formatted_message = spawnstruct();
    formatted_message.uniqueid = broadcast player_broadcasting::getbroadcastuniqueid();
    
    if ( isnumber( formatted_message.uniqueid ) )
    {
        formatted_message.uniqueid = string( formatted_message.uniqueid );
    }
    
    formatted_message.groupid = broadcast player_broadcasting::function_4aba6bea906de8b9();
    
    if ( isnumber( formatted_message.groupid ) )
    {
        formatted_message.groupid = string( formatted_message.groupid );
    }
    
    message_priority = namespace_2aca03e533f9f843::function_a0a2837d2275b131( broadcast );
    formatted_message.priority = message_priority;
    formatted_message.group_priority = message_priority;
    formatted_message.param = namespace_2aca03e533f9f843::function_a12099f1a0098ac0( message );
    broadcast_style_settings = namespace_2aca03e533f9f843::function_47a2d930b02016bf( message );
    message_style = broadcast_style_settings.stringmessagingutilstyle;
    broadcast_style = namespace_2aca03e533f9f843::function_1b17545f10298abf( message );
    
    if ( broadcast_style == "StringMessagingUtil_Splash" )
    {
        switch ( message_style )
        {
            case #"hash_a30f8a4037eef549":
                formatted_message.state = "show_title_toast";
                break;
            case #"hash_176327485b96c4a9":
                formatted_message.state = "show_desc_toast";
                break;
            case #"hash_e2bf296211079750":
                formatted_message.state = "success";
                break;
            case #"hash_c70936445ab69671":
                formatted_message.state = "failure";
                break;
            default:
                formatted_message.state = "show_title_toast";
                break;
        }
    }
    else if ( broadcast_style == "StringMessagingUtil_Dialog" )
    {
        switch ( message_style )
        {
            case #"hash_a30f8a4037eef549":
                formatted_message.state = "show_title_dialog";
                break;
            case #"hash_176327485b96c4a9":
                formatted_message.state = "show_desc_dialog";
                break;
            case #"hash_e2bf296211079750":
                formatted_message.state = "success";
                break;
            case #"hash_c70936445ab69671":
                formatted_message.state = "failure";
                break;
            default:
                formatted_message.state = "show_title_dialog";
                break;
        }
    }
    else
    {
        switch ( message_style )
        {
            case #"hash_a30f8a4037eef549":
                formatted_message.state = "show_title";
                break;
            case #"hash_176327485b96c4a9":
                formatted_message.state = "show_desc";
                break;
            case #"hash_e2bf296211079750":
                formatted_message.state = "success";
                break;
            case #"hash_c70936445ab69671":
                formatted_message.state = "failure";
                break;
            default:
                formatted_message.state = "show_title";
                break;
        }
    }
    
    function_2ff66c5806185b44( broadcast, message, formatted_message );
    return formatted_message;
}

// Namespace string_messaging_util
// Params 3, eflags: 0x4
// Checksum 0xce0260ee, Offset: 0x895
// Size: 0x14d
function private function_2ff66c5806185b44( broadcast, data_object, var_78a8be24d5a44488 )
{
    var_dea3985ee297b6e = 0;
    var_b2a3eaf4665f4a7 = 0;
    
    for ( var_7cef713213064ef1 = namespace_2aca03e533f9f843::function_e2456da4d8c9ce1( broadcast, data_object, var_dea3985ee297b6e ); isdefined( var_7cef713213064ef1 ) && var_b2a3eaf4665f4a7 < 2 ; var_7cef713213064ef1 = namespace_2aca03e533f9f843::function_e2456da4d8c9ce1( broadcast, data_object, var_dea3985ee297b6e ) )
    {
        if ( var_7cef713213064ef1.type == "ProgressTracker" )
        {
            var_f03f252dfe7001 = var_7cef713213064ef1.value;
            progress_data = namespace_2aca03e533f9f843::function_66deba6127b6ba4( var_7cef713213064ef1.format, var_f03f252dfe7001.startingprogressvalue, var_f03f252dfe7001.currentprogressvalue, var_f03f252dfe7001.finalprogressvalue );
            
            if ( isdefined( progress_data[ 0 ] ) )
            {
                var_6c39580bc8ff082d = function_9448a55760a99474( var_78a8be24d5a44488, progress_data[ 0 ], "Integer", var_b2a3eaf4665f4a7 );
                
                if ( var_6c39580bc8ff082d )
                {
                    var_b2a3eaf4665f4a7++;
                }
            }
            
            if ( isdefined( progress_data[ 1 ] ) )
            {
                var_6c39580bc8ff082d = function_9448a55760a99474( var_78a8be24d5a44488, progress_data[ 1 ], "Integer", var_b2a3eaf4665f4a7 );
                
                if ( var_6c39580bc8ff082d )
                {
                    var_b2a3eaf4665f4a7++;
                }
            }
        }
        else
        {
            var_6c39580bc8ff082d = function_9448a55760a99474( var_78a8be24d5a44488, var_7cef713213064ef1.value, var_7cef713213064ef1.type, var_b2a3eaf4665f4a7 );
            
            if ( var_6c39580bc8ff082d )
            {
                var_b2a3eaf4665f4a7++;
            }
        }
        
        var_dea3985ee297b6e++;
    }
}

// Namespace string_messaging_util
// Params 4, eflags: 0x4
// Checksum 0xff5d0983, Offset: 0x9ea
// Size: 0x83, Type: bool
function private function_9448a55760a99474( var_29d5e5763a2979ee, value, type, index )
{
    if ( index < 2 )
    {
        if ( type == "Integer" || type == "Float" )
        {
            if ( index == 0 )
            {
                var_29d5e5763a2979ee.data1 = int( value );
                return true;
            }
            else if ( index == 1 )
            {
                var_29d5e5763a2979ee.data2 = int( value );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x25277d59, Offset: 0xa76
// Size: 0x128
function function_d4ceab7526dea7ae( players, remove_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        foreach ( message in player.var_20edbb1c7dd11bfc )
        {
            if ( remove_message.uniqueid == message.uniqueid )
            {
                message.display_time = 0;
            }
        }
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0xcca9d232, Offset: 0xba6
// Size: 0x128
function function_e72c98bf142c7a1f( players, remove_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        foreach ( message in player.var_508146bb326d420d )
        {
            if ( remove_message.uniqueid == message.uniqueid )
            {
                message.display_time = 0;
            }
        }
    }
}

// Namespace string_messaging_util
// Params 1
// Checksum 0xf9ce637f, Offset: 0xcd6
// Size: 0x608
function function_da199a69921efc61( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( player ) && isdefined( player.var_20edbb1c7dd11bfc ) )
    {
        if ( player.var_20edbb1c7dd11bfc.size <= self.idx || !isdefined( player.var_20edbb1c7dd11bfc[ self.idx ] ) )
        {
            if ( isdefined( self.param ) )
            {
                player _string_messaging_update_state( "hidden", self.omnvar_state );
                self.param = undefined;
                self.state = undefined;
                self.data1 = undefined;
                self.data2 = undefined;
            }
        }
        else if ( !isdefined( self.param ) || player.var_20edbb1c7dd11bfc[ self.idx ].is_new )
        {
            self.param = player.var_20edbb1c7dd11bfc[ self.idx ].param;
            player function_96994aca10dc8f89( self.param, self.omnvar_param );
            self.state = player.var_20edbb1c7dd11bfc[ self.idx ].state;
            player _string_messaging_update_state( self.state, self.omnvar_state );
            
            if ( isdefined( player.var_20edbb1c7dd11bfc[ self.idx ].data1 ) )
            {
                self.data1 = player.var_20edbb1c7dd11bfc[ self.idx ].data1;
                player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
            }
            
            if ( isdefined( player.var_20edbb1c7dd11bfc[ self.idx ].data2 ) )
            {
                self.data2 = player.var_20edbb1c7dd11bfc[ self.idx ].data2;
                player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
            }
            
            player.var_20edbb1c7dd11bfc[ self.idx ].is_new = 0;
        }
        else if ( player.var_20edbb1c7dd11bfc[ self.idx ].should_remove )
        {
            player.var_20edbb1c7dd11bfc = arrayremove( player.var_20edbb1c7dd11bfc, player.var_20edbb1c7dd11bfc[ self.idx ] );
        }
        else
        {
            if ( player.var_20edbb1c7dd11bfc[ self.idx ].display_time > 0 )
            {
                player.var_20edbb1c7dd11bfc[ self.idx ].display_time -= 0.1;
            }
            
            if ( self.param != player.var_20edbb1c7dd11bfc[ self.idx ].param )
            {
                self.param = player.var_20edbb1c7dd11bfc[ self.idx ].param;
                player function_96994aca10dc8f89( self.param, self.omnvar_param );
            }
            
            if ( self.state != player.var_20edbb1c7dd11bfc[ self.idx ].state )
            {
                self.state = player.var_20edbb1c7dd11bfc[ self.idx ].state;
                player _string_messaging_update_state( self.state, self.omnvar_state );
            }
            
            if ( isdefined( player.var_20edbb1c7dd11bfc[ self.idx ].data1 ) )
            {
                if ( self.data1 != player.var_20edbb1c7dd11bfc[ self.idx ].data1 )
                {
                    self.data1 = player.var_20edbb1c7dd11bfc[ self.idx ].data1;
                    player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
                }
            }
            
            if ( isdefined( player.var_20edbb1c7dd11bfc[ self.idx ].data2 ) )
            {
                if ( self.data2 != player.var_20edbb1c7dd11bfc[ self.idx ].data2 )
                {
                    self.data2 = player.var_20edbb1c7dd11bfc[ self.idx ].data2;
                    player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
                }
            }
        }
        
        if ( isdefined( player.var_20edbb1c7dd11bfc[ self.idx ] ) )
        {
            if ( player.var_20edbb1c7dd11bfc[ self.idx ].display_time <= 0 )
            {
                if ( self.state != "hidden" )
                {
                    player.var_20edbb1c7dd11bfc[ self.idx ].state = "hidden";
                    self.state = "hidden";
                    player.var_20edbb1c7dd11bfc[ self.idx ].display_time = 0.5;
                    player _string_messaging_update_state( self.state, self.omnvar_state );
                }
                else
                {
                    player.var_20edbb1c7dd11bfc[ self.idx ].should_remove = 1;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace string_messaging_util
// Params 1
// Checksum 0xe1ab04a0, Offset: 0x12e6
// Size: 0x608
function function_658bda80b35f96( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( player ) && isdefined( player.var_508146bb326d420d ) )
    {
        if ( player.var_508146bb326d420d.size <= self.idx || !isdefined( player.var_508146bb326d420d[ self.idx ] ) )
        {
            if ( isdefined( self.param ) )
            {
                player _string_messaging_update_state( "hidden", self.omnvar_state );
                self.param = undefined;
                self.state = undefined;
                self.data1 = undefined;
                self.data2 = undefined;
            }
        }
        else if ( !isdefined( self.param ) || player.var_508146bb326d420d[ self.idx ].is_new )
        {
            self.param = player.var_508146bb326d420d[ self.idx ].param;
            player function_96994aca10dc8f89( self.param, self.omnvar_param );
            self.state = player.var_508146bb326d420d[ self.idx ].state;
            player _string_messaging_update_state( self.state, self.omnvar_state );
            
            if ( isdefined( player.var_508146bb326d420d[ self.idx ].data1 ) )
            {
                self.data1 = player.var_508146bb326d420d[ self.idx ].data1;
                player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
            }
            
            if ( isdefined( player.var_508146bb326d420d[ self.idx ].data2 ) )
            {
                self.data2 = player.var_508146bb326d420d[ self.idx ].data2;
                player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
            }
            
            player.var_508146bb326d420d[ self.idx ].is_new = 0;
        }
        else if ( player.var_508146bb326d420d[ self.idx ].should_remove )
        {
            player.var_508146bb326d420d = arrayremove( player.var_508146bb326d420d, player.var_508146bb326d420d[ self.idx ] );
        }
        else
        {
            if ( player.var_508146bb326d420d[ self.idx ].display_time > 0 )
            {
                player.var_508146bb326d420d[ self.idx ].display_time -= 0.1;
            }
            
            if ( self.param != player.var_508146bb326d420d[ self.idx ].param )
            {
                self.param = player.var_508146bb326d420d[ self.idx ].param;
                player function_96994aca10dc8f89( self.param, self.omnvar_param );
            }
            
            if ( self.state != player.var_508146bb326d420d[ self.idx ].state )
            {
                self.state = player.var_508146bb326d420d[ self.idx ].state;
                player _string_messaging_update_state( self.state, self.omnvar_state );
            }
            
            if ( isdefined( player.var_508146bb326d420d[ self.idx ].data1 ) )
            {
                if ( self.data1 != player.var_508146bb326d420d[ self.idx ].data1 )
                {
                    self.data1 = player.var_508146bb326d420d[ self.idx ].data1;
                    player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
                }
            }
            
            if ( isdefined( player.var_508146bb326d420d[ self.idx ].data2 ) )
            {
                if ( self.data2 != player.var_508146bb326d420d[ self.idx ].data2 )
                {
                    self.data2 = player.var_508146bb326d420d[ self.idx ].data2;
                    player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
                }
            }
        }
        
        if ( isdefined( player.var_508146bb326d420d[ self.idx ] ) )
        {
            if ( player.var_508146bb326d420d[ self.idx ].display_time <= 0 )
            {
                if ( self.state != "hidden" )
                {
                    player.var_508146bb326d420d[ self.idx ].state = "hidden";
                    self.state = "hidden";
                    player.var_508146bb326d420d[ self.idx ].display_time = 0.5;
                    player _string_messaging_update_state( self.state, self.omnvar_state );
                }
                else
                {
                    player.var_508146bb326d420d[ self.idx ].should_remove = 1;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace string_messaging_util
// Params 3
// Checksum 0xb2678374, Offset: 0x18f6
// Size: 0x149
function function_1c934d8a432c54d7( players, splash_broadcast, broadcast_command )
{
    broadcast_messages = splash_broadcast player_broadcasting::function_d95fdf9867bbbdc3();
    
    for ( message_id = 0; message_id < broadcast_messages.size ; message_id++ )
    {
        broadcast_message = broadcast_messages[ message_id ];
        new_message = function_dfed73672ce3e229( splash_broadcast, broadcast_message );
        new_message.uniqueid = splash_broadcast player_broadcasting::getbroadcastuniqueid() + "_messageId:_" + message_id;
        broadcast_style = namespace_2aca03e533f9f843::function_1b17545f10298abf( broadcast_message );
        
        if ( broadcast_style == "StringMessagingUtil_Splash" )
        {
            if ( broadcast_command == 2 )
            {
                function_d4ceab7526dea7ae( players, new_message );
            }
            else if ( broadcast_command == 0 )
            {
                function_a49f41fa812d37b4( players, new_message );
            }
            
            continue;
        }
        
        if ( broadcast_style == "StringMessagingUtil_Dialog" )
        {
            if ( broadcast_command == 2 )
            {
                function_e72c98bf142c7a1f( players, new_message );
            }
            else if ( broadcast_command == 0 )
            {
                function_27b68945c35b96d1( players, new_message );
            }
            
            continue;
        }
        
        if ( broadcast_style == "StringMessagingUtil_MinimapWidget" )
        {
            if ( broadcast_command == 0 )
            {
                function_f5ddf244f32cbf79( players, new_message );
                continue;
            }
            
            if ( broadcast_command == 1 )
            {
                function_4f15ce5378bbfa9b( players, new_message );
                continue;
            }
            
            if ( broadcast_command == 2 )
            {
                function_8633f5dadc030e86( players, new_message );
            }
        }
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0xddc3e7cc, Offset: 0x1a47
// Size: 0x1e5
function function_a49f41fa812d37b4( players, new_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    if ( !isdefined( new_message.priority ) )
    {
        new_message.priority = 999;
    }
    
    if ( !isdefined( new_message.display_time ) )
    {
        new_message.display_time = 12;
    }
    
    new_message.is_new = 1;
    new_message.should_remove = 0;
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.var_20edbb1c7dd11bfc ) )
        {
            player _string_messaging_init();
        }
        
        msg_added = 0;
        
        for ( i = 0; i < player.var_20edbb1c7dd11bfc.size ; i++ )
        {
            if ( new_message.priority < player.var_20edbb1c7dd11bfc[ i ].priority )
            {
                arrayinsert( player.var_20edbb1c7dd11bfc, new_message, i );
                message_added = 1;
                break;
            }
        }
        
        if ( !msg_added )
        {
            player.var_20edbb1c7dd11bfc[ player.var_20edbb1c7dd11bfc.size ] = new_message;
        }
        
        if ( player.var_20edbb1c7dd11bfc.size > player.str_msg_toast.size )
        {
            player.var_20edbb1c7dd11bfc[ 0 ] = undefined;
            function_cdc669dbc8ea2101( player.var_20edbb1c7dd11bfc );
        }
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x2d6073b, Offset: 0x1c34
// Size: 0x1d2
function function_27b68945c35b96d1( players, new_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    if ( !isdefined( new_message.priority ) )
    {
        new_message.priority = 999;
    }
    
    if ( !isdefined( new_message.display_time ) )
    {
        new_message.display_time = 12;
    }
    
    new_message.is_new = 1;
    new_message.should_remove = 0;
    
    foreach ( player in players )
    {
        if ( !isdefined( player.var_508146bb326d420d ) )
        {
            player _string_messaging_init();
        }
        
        msg_added = 0;
        
        for ( i = 0; i < player.var_508146bb326d420d.size ; i++ )
        {
            if ( new_message.priority < player.var_508146bb326d420d[ i ].priority )
            {
                arrayinsert( player.var_508146bb326d420d, new_message, i );
                message_added = 1;
                break;
            }
        }
        
        if ( !msg_added )
        {
            player.var_508146bb326d420d[ player.var_508146bb326d420d.size ] = new_message;
        }
        
        if ( player.var_508146bb326d420d.size > player.str_msg_dialog.size )
        {
            player.var_508146bb326d420d[ 0 ] = undefined;
            function_cdc669dbc8ea2101( player.var_508146bb326d420d );
        }
    }
}

// Namespace string_messaging_util
// Params 0
// Checksum 0x479931ea, Offset: 0x1e0e
// Size: 0xe7
function function_d360a841dd9001bd()
{
    self.str_msg_list = [];
    self.var_b4c282567bc129d5 = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        slot = spawnstruct();
        slot.idx = i;
        display_idx = 1 + i;
        slot.omnvar_param = "objective_param_" + display_idx;
        slot.omnvar_data1 = "objective_count_" + display_idx;
        slot.omnvar_data2 = "objective_max_count_" + display_idx;
        slot.omnvar_state = "objective_state_" + display_idx;
        slot.var_86ba56a2a3fb6caa = 0;
        slot.group_hidden = 0;
        slot thread function_b793d97ea0174922( self );
        self.str_msg_list[ self.str_msg_list.size ] = slot;
    }
}

// Namespace string_messaging_util
// Params 1
// Checksum 0xbcfd4d3c, Offset: 0x1efd
// Size: 0x53b
function function_b793d97ea0174922( player )
{
    player endon( #"disconnect" );
    
    while ( isdefined( player ) && isdefined( player.var_b4c282567bc129d5 ) )
    {
        self.var_86ba56a2a3fb6caa = function_ce01460be180487e( player );
        
        if ( player.str_msg_list.size - self.idx - 1 < self.var_86ba56a2a3fb6caa )
        {
            if ( isdefined( self.state ) && self.state != "hidden" )
            {
                self.state = "hidden";
                player _string_messaging_update_state( self.state, self.omnvar_state );
            }
        }
        else if ( player.var_b4c282567bc129d5.size <= self.idx || !isdefined( player.var_b4c282567bc129d5[ self.idx ] ) )
        {
            if ( isdefined( self.param ) )
            {
                player _string_messaging_update_state( "hidden", self.omnvar_state );
                self.param = undefined;
                self.state = undefined;
                self.data1 = undefined;
                self.data2 = undefined;
            }
        }
        else if ( !isdefined( self.param ) || player.var_b4c282567bc129d5[ self.idx ].is_new )
        {
            self.param = player.var_b4c282567bc129d5[ self.idx ].param;
            player function_96994aca10dc8f89( self.param, self.omnvar_param );
            self.state = player.var_b4c282567bc129d5[ self.idx ].state;
            player _string_messaging_update_state( self.state, self.omnvar_state );
            
            if ( isdefined( player.var_b4c282567bc129d5[ self.idx ].data1 ) )
            {
                self.data1 = player.var_b4c282567bc129d5[ self.idx ].data1;
                player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
            }
            
            if ( isdefined( player.var_b4c282567bc129d5[ self.idx ].data2 ) )
            {
                self.data2 = player.var_b4c282567bc129d5[ self.idx ].data2;
                player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
            }
            
            player.var_b4c282567bc129d5[ self.idx ].is_new = 0;
        }
        else if ( player.var_b4c282567bc129d5[ self.idx ].should_remove )
        {
            player.var_b4c282567bc129d5 = arrayremove( player.var_b4c282567bc129d5, player.var_b4c282567bc129d5[ self.idx ] );
        }
        else
        {
            if ( self.param != player.var_b4c282567bc129d5[ self.idx ].param )
            {
                self.param = player.var_b4c282567bc129d5[ self.idx ].param;
                player function_96994aca10dc8f89( self.param, self.omnvar_param );
            }
            
            if ( self.state != player.var_b4c282567bc129d5[ self.idx ].state )
            {
                self.state = player.var_b4c282567bc129d5[ self.idx ].state;
                player _string_messaging_update_state( self.state, self.omnvar_state );
            }
            
            if ( isdefined( player.var_b4c282567bc129d5[ self.idx ].data1 ) )
            {
                if ( self.data1 != player.var_b4c282567bc129d5[ self.idx ].data1 )
                {
                    self.data1 = player.var_b4c282567bc129d5[ self.idx ].data1;
                    player function_77e2b28b76ddf0a0( self.data1, self.omnvar_data1 );
                }
            }
            
            if ( isdefined( player.var_b4c282567bc129d5[ self.idx ].data2 ) )
            {
                if ( self.data2 != player.var_b4c282567bc129d5[ self.idx ].data2 )
                {
                    self.data2 = player.var_b4c282567bc129d5[ self.idx ].data2;
                    player function_77e2b28b76ddf0a0( self.data2, self.omnvar_data2 );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace string_messaging_util
// Params 1
// Checksum 0x7d89c534, Offset: 0x2440
// Size: 0x8b
function function_ce01460be180487e( player )
{
    line_count = 0;
    
    for ( i = player.var_b4c282567bc129d5.size - 1; i > self.idx ; i-- )
    {
        if ( player.var_b4c282567bc129d5[ i ].groupid == player.var_b4c282567bc129d5[ self.idx ].groupid )
        {
            line_count += 1;
        }
    }
    
    return line_count;
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x19763be0, Offset: 0x24d4
// Size: 0x2eb
function function_f5ddf244f32cbf79( players, new_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    new_message.is_new = 1;
    new_message.should_remove = 0;
    
    if ( !isdefined( new_message.priority ) )
    {
        new_message.priority = 999;
    }
    
    if ( !isdefined( new_message.group_priority ) )
    {
        new_message.group_priority = 999;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.var_b4c282567bc129d5 ) )
        {
            player _string_messaging_init();
        }
        
        message_found = 0;
        message_added = 0;
        group_start = -1;
        
        for ( i = 0; i < player.var_b4c282567bc129d5.size ; i++ )
        {
            if ( player.var_b4c282567bc129d5[ i ].uniqueid == new_message.uniqueid )
            {
                message_found = 1;
            }
            
            if ( player.var_b4c282567bc129d5[ i ].groupid == new_message.groupid && group_start < 0 )
            {
                group_start = i;
            }
        }
        
        if ( !message_found )
        {
            if ( group_start >= 0 )
            {
                for ( i = group_start; i < player.var_b4c282567bc129d5.size ; i++ )
                {
                    my_group = 0;
                    
                    if ( player.var_b4c282567bc129d5[ i ].groupid == new_message.groupid )
                    {
                        my_group = 1;
                    }
                    
                    if ( my_group && player.var_b4c282567bc129d5[ i ].priority > new_message.priority )
                    {
                        arrayinsert( player.var_b4c282567bc129d5, new_message, i );
                        message_added = 1;
                        break;
                    }
                    
                    if ( !my_group )
                    {
                        arrayinsert( player.var_b4c282567bc129d5, new_message, i );
                        message_added = 1;
                        break;
                    }
                }
            }
            else
            {
                for ( i = 0; i < player.var_b4c282567bc129d5.size ; i++ )
                {
                    if ( player.var_b4c282567bc129d5[ i ].group_priority > new_message.group_priority )
                    {
                        arrayinsert( player.var_b4c282567bc129d5, new_message, i );
                        message_added = 1;
                        break;
                    }
                }
            }
            
            if ( !message_added )
            {
                player.var_b4c282567bc129d5[ player.var_b4c282567bc129d5.size ] = new_message;
            }
        }
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x9db580a9, Offset: 0x27c7
// Size: 0x129
function function_8633f5dadc030e86( players, remove_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        foreach ( message in player.var_b4c282567bc129d5 )
        {
            if ( message.uniqueid == remove_message.uniqueid )
            {
                message.should_remove = 1;
            }
        }
    }
}

// Namespace string_messaging_util
// Params 2
// Checksum 0xd41f8e75, Offset: 0x28f8
// Size: 0x25a
function function_4f15ce5378bbfa9b( players, update_message )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        message_found = 0;
        
        foreach ( message in player.var_b4c282567bc129d5 )
        {
            if ( message.uniqueid == update_message.uniqueid )
            {
                message_found = 1;
                
                if ( isdefined( update_message.param ) )
                {
                    if ( message.param != update_message.param )
                    {
                        message.param = update_message.param;
                    }
                }
                
                if ( isdefined( update_message.state ) )
                {
                    if ( message.state != update_message.state )
                    {
                        message.state = update_message.state;
                    }
                }
                
                if ( isdefined( update_message.data1 ) )
                {
                    if ( isdefined( message.data1 ) && message.data1 != update_message.data1 )
                    {
                        message.data1 = update_message.data1;
                    }
                }
                
                if ( isdefined( update_message.data2 ) )
                {
                    if ( isdefined( message.data2 ) && message.data2 != update_message.data2 )
                    {
                        message.data2 = update_message.data2;
                    }
                }
            }
        }
        
        if ( !message_found )
        {
            function_f5ddf244f32cbf79( players, update_message );
        }
    }
}

// Namespace string_messaging_util
// Params 0
// Checksum 0x3db69d84, Offset: 0x2b5a
// Size: 0x5c
function function_162973038bb20b3()
{
    level.var_86d9f0ad682afe8f = [];
    level.var_86d9f0ad682afe8f[ "create" ] = &function_e09f7166bcd3f6c0;
    level.var_86d9f0ad682afe8f[ "update" ] = &function_c2ddc94161526204;
    level.var_86d9f0ad682afe8f[ "cleanup" ] = &function_dcbb6fc5be38efc3;
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &function_dcbb6fc5be38efc3 );
}

// Namespace string_messaging_util
// Params 1
// Checksum 0x29c536d4, Offset: 0x2bbe
// Size: 0xa1
function function_e09f7166bcd3f6c0( player )
{
    text = newclienthudelem( player );
    text.alpha = 0;
    text.alignx = "center";
    text.aligny = "top";
    text.fontscale = 3;
    text.x = 320;
    text.y = 115;
    text.color = ( 1, 0, 0 );
    player.var_7ee436bd0a82927c = text;
    return text;
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x1289ea6a, Offset: 0x2c68
// Size: 0x1b6
function function_c2ddc94161526204( player, time )
{
    if ( !isdefined( player.var_7ee436bd0a82927c ) )
    {
        return;
    }
    
    player.var_7ee436bd0a82927c.alpha = 1;
    var_226cd1e382a274a6 = 5;
    countdown_time = ceil( var_226cd1e382a274a6 - time );
    
    if ( !isdefined( player.var_7ee436bd0a82927c.time_tracking ) || countdown_time < player.var_7ee436bd0a82927c.time_tracking )
    {
        player.var_7ee436bd0a82927c.time_tracking = countdown_time;
        string_time = string( countdown_time );
        
        switch ( string_time )
        {
            case #"hash_31100bbc01bd3230":
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_5_desc" );
                break;
            case #"hash_31100cbc01bd33c3":
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_4_desc" );
                break;
            case #"hash_311011bc01bd3ba2":
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_3_desc" );
                break;
            case #"hash_311012bc01bd3d35":
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_2_desc" );
                break;
            case #"hash_31100fbc01bd387c":
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_1_desc" );
                break;
            default:
                player.var_7ee436bd0a82927c settext( &"jup_ob_objectives/leave_warning_1_desc" );
                break;
        }
    }
}

// Namespace string_messaging_util
// Params 1
// Checksum 0x68e0314e, Offset: 0x2e26
// Size: 0xa7
function function_dcbb6fc5be38efc3( relevant_info_struct )
{
    foreach ( player in relevant_info_struct.playerlist )
    {
        if ( isplayer( player ) && isdefined( player.var_7ee436bd0a82927c ) )
        {
            player.var_7ee436bd0a82927c destroy();
        }
    }
}

// Namespace string_messaging_util
// Params 4
// Checksum 0xd8aa46fa, Offset: 0x2ed5
// Size: 0x1ab
function function_fbbf36167b928d8a( stringreference, broadcaststyle = "StringMessagingUtil_Splash", var_dec8c469a5d32ec6 = "Title", priority = "Medium" )
{
    broadcast = player_broadcasting::function_f13a82c402b6308f( "StringReference" );
    broadcast.broadcastdefinition = spawnstruct();
    broadcast.broadcastdefinition.variant_object = spawnstruct();
    broadcast.broadcastdefinition.variant_object.priority = priority;
    broadcastdataobject = spawnstruct();
    broadcastdataobject.variant_object = spawnstruct();
    broadcastdataobject.variant_object.stringreference = stringreference;
    broadcastdataobject.variant_object.stylesettings = [];
    broadcastdataobject.variant_object.stylesettings[ 0 ] = spawnstruct();
    broadcastdataobject.variant_object.stylesettings[ 0 ].variant_object = spawnstruct();
    broadcastdataobject.variant_object.stylesettings[ 0 ].variant_object.broadcaststyle = broadcaststyle;
    broadcastdataobject.variant_object.stylesettings[ 0 ].variant_object.stringmessagingutilstyle = var_dec8c469a5d32ec6;
    broadcast.broadcastdataobjects[ 0 ] = broadcastdataobject;
    return broadcast;
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x5b11df64, Offset: 0x3089
// Size: 0x3d
function function_96994aca10dc8f89( param, omnvar )
{
    widget_ref = level.string_messaging_widget_ref ?? "scripted_widget_objective_text";
    scripted_widgets::set_param( widget_ref, param, omnvar );
}

// Namespace string_messaging_util
// Params 2
// Checksum 0x5b11df64, Offset: 0x30ce
// Size: 0x3d
function _string_messaging_update_state( state, omnvar )
{
    widget_ref = level.string_messaging_widget_ref ?? "scripted_widget_objective_text";
    scripted_widgets::set_state( widget_ref, state, omnvar );
}

// Namespace string_messaging_util
// Params 2
// Checksum 0xd000347e, Offset: 0x3113
// Size: 0x3d
function function_77e2b28b76ddf0a0( data, omnvar )
{
    widget_ref = level.string_messaging_widget_ref ?? "scripted_widget_objective_text";
    scripted_widgets::set_data( widget_ref, data, omnvar );
}

