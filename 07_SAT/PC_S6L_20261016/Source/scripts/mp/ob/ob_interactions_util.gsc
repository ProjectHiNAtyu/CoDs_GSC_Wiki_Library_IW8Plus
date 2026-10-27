// scripts\mp\ob\ob_interactions_util.gsc  (hash_6fd2f8dba4845b5a.gscc) (size: 11536 Bytes / 0x2d10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec3703b4 (3963028404)
// size ...... 11536 (0x2d10)
// includes .. 8   (offset: 0x29b0)
// strings ... 32  (offset: 0x29f0)
// dev strs .. 13  (offset: 0x2c70)
// exports ... 36  (offset: 0x18f8)
// cseg ...... 0x2aa + 0x164e (0x18f8)
// imports ... 88  (offset: 0x1e98)
// animtree1 . 0   (offset: 0x2d10)
// animtree2 . 0   (offset: 0x2d10)
#using scripts\anim\utility;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\interaction;

#namespace ob_interactions_util;

/#

    // Namespace ob_interactions_util
    // Params 0, eflags: 0x1
    // Checksum 0xca33483, Offset: 0x2c8
    // Size: 0xc, Type: dev
    function autoexec function_be95214c775d8ba5()
    {
        thread init_interactions_devgui();
    }

#/

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xe651d6ec, Offset: 0x2dc
// Size: 0x52
function private function_a499139fe37d9b2a( interact_struct )
{
    self endon( #"interaction_complete" );
    self endon( #"interaction_interrupt" );
    self waittill( #"disconnect" );
    
    if ( interact_struct )
    {
        interact_struct.var_1674515c4a4c0655 = arrayremove( interact_struct.var_1674515c4a4c0655, self );
    }
}

// Namespace ob_interactions_util
// Params 10
// Checksum 0x8575bacf, Offset: 0x336
// Size: 0x587, Type: bool
function function_c7b5806740384a61( var_c5142e0d1342bef0, player, var_74b8918d075c659e, interact_struct = undefined, var_94e834d8b01bd0a3 = 1, showprogress = 1, requirehold = 0, progresstype = 13, var_80bfb1a398f1fca5 = undefined, var_dcce58d6b9dd7056 = requirehold )
{
    player endon( #"disconnect" );
    isgestureweapon = isvalidgestureweapon( var_c5142e0d1342bef0 );
    
    if ( !function_cb0dd281d0e0f4ba( var_c5142e0d1342bef0 ) && !isgestureweapon )
    {
        return false;
    }
    
    if ( player.using_device )
    {
        return false;
    }
    
    player setclientomnvar( "ui_hackingdevice_state", -1 );
    
    if ( progresstype < 0 )
    {
        player setclientomnvar( "ui_clink_interaction_type", 0 );
        player setclientomnvar( "ui_clink_interaction_progress", -1 );
        player setclientomnvar( "ui_clink_interaction_require_hold", 0 );
    }
    
    player.using_device = 1;
    player.var_80bfb1a398f1fca5 = var_80bfb1a398f1fca5;
    
    if ( var_80bfb1a398f1fca5 )
    {
        player widgets_visibility::hide( "ClinkInteractions", [ "ClinkInteractions" ], 1, 1 );
        thread function_4157916a3aa064bd( player, var_80bfb1a398f1fca5 );
    }
    
    if ( isdefined( interact_struct ) )
    {
        if ( !isdefined( interact_struct.var_1674515c4a4c0655 ) )
        {
            interact_struct.var_1674515c4a4c0655 = [];
        }
        
        interact_struct.var_1674515c4a4c0655[ interact_struct.var_1674515c4a4c0655.size ] = player;
        interact_struct disablescriptableplayeruse( player );
        player thread function_a499139fe37d9b2a( interact_struct );
    }
    
    if ( isgestureweapon )
    {
        function_1e247b5853916cac( var_c5142e0d1342bef0, player, var_94e834d8b01bd0a3 );
    }
    else
    {
        var_c5142e0d1342bef0 = function_6f888f678b89efe1( var_c5142e0d1342bef0, player, var_94e834d8b01bd0a3 );
    }
    
    player setclientomnvar( "ui_hackingdevice_state", 0 );
    thread function_7dcdb43e6ab59160( player );
    thread function_aac0387380a1edc4( player, var_74b8918d075c659e );
    player setscriptablepartstate( "hacking_audio", "start", 0 );
    
    if ( requirehold )
    {
        thread watchcancelhold( player );
    }
    else
    {
        thread watchcancel( player );
    }
    
    if ( showprogress )
    {
        if ( progresstype < 0 )
        {
            player setclientomnvar( "ui_clink_interaction_type", int( abs( progresstype ) ) );
            player setclientomnvar( "ui_clink_interaction_progress", 0 );
            
            if ( var_dcce58d6b9dd7056 )
            {
                player setclientomnvar( "ui_clink_interaction_require_hold", requirehold ? 1 : 0 );
            }
        }
        else
        {
            player setclientomnvar( "ui_securing", progresstype );
            player setclientomnvar( "ui_securing_progress", 0 );
        }
    }
    
    speedmult = player function_5418d931d7a9c2c2();
    var_74b8918d075c659e /= speedmult;
    buttontime = 0;
    
    while ( buttontime < var_74b8918d075c659e )
    {
        if ( player.var_c6e1464ec410750f || !isalive( player ) || player.fauxdeath )
        {
            player setscriptablepartstate( "hacking_audio", "fail", 0 );
            
            if ( showprogress )
            {
                if ( progresstype < 0 )
                {
                    player setclientomnvar( "ui_clink_interaction_type", 0 );
                }
                else
                {
                    player setclientomnvar( "ui_securing", 0 );
                    player setclientomnvar( "ui_securing_progress", 0 );
                }
            }
            
            if ( isgestureweapon )
            {
                function_9326d575e2d5591e( var_c5142e0d1342bef0, player );
            }
            else
            {
                player inventory_utility::getridofweapon( var_c5142e0d1342bef0 );
                player function_e3b1d4261027fb9c();
            }
            
            if ( isdefined( interact_struct ) )
            {
                interact_struct enablescriptableplayeruse( player );
                interact_struct.var_1674515c4a4c0655 = arrayremove( interact_struct.var_1674515c4a4c0655, player );
            }
            
            player.using_device = 0;
            player notify( #"interaction_interrupt" );
            return false;
        }
        
        buttontime += level.framedurationseconds;
        
        if ( showprogress )
        {
            if ( progresstype < 0 )
            {
                player setclientomnvar( "ui_clink_interaction_progress", clamp( buttontime / var_74b8918d075c659e, 0, 1 ) );
            }
            else
            {
                player setclientomnvar( "ui_securing_progress", clamp( buttontime / var_74b8918d075c659e, 0, 1 ) );
            }
        }
        
        waitframe();
    }
    
    player setscriptablepartstate( "hacking_audio", "success", 0 );
    
    if ( showprogress )
    {
        if ( progresstype < 0 )
        {
            player setclientomnvar( "ui_clink_interaction_progress", 1 );
            player setclientomnvar( "ui_clink_interaction_type", 0 );
        }
        else
        {
            player setclientomnvar( "ui_securing", 0 );
            player setclientomnvar( "ui_securing_progress", 0 );
        }
    }
    
    if ( isgestureweapon )
    {
        function_9326d575e2d5591e( var_c5142e0d1342bef0, player, 1 );
    }
    else
    {
        player inventory_utility::getridofweapon( var_c5142e0d1342bef0 );
        player function_e3b1d4261027fb9c();
    }
    
    if ( isdefined( interact_struct ) )
    {
        interact_struct enablescriptableplayeruse( player );
        interact_struct.var_1674515c4a4c0655 = arrayremove( interact_struct.var_1674515c4a4c0655, player );
        
        foreach ( player_interacting in interact_struct.var_1674515c4a4c0655 )
        {
            player_interacting notify( #"cancel" );
        }
    }
    
    if ( player )
    {
        if ( !isbot( player ) )
        {
            player notifyonplayercommandremove( "cancel", "+weapnext" );
            player notifyonplayercommandremove( "cancel", "-weapnext" );
        }
        
        player notifyonplayercommandremove( "cancel", "-usereload" );
        player notifyonplayercommandremove( "cancel", "-activate" );
    }
    
    player.using_device = 0;
    player notify( #"interaction_complete" );
    
    if ( var_80bfb1a398f1fca5 )
    {
        player widgets_visibility::reset( player.var_80bfb1a398f1fca5 );
    }
    
    return true;
}

// Namespace ob_interactions_util
// Params 0, eflags: 0x4
// Checksum 0xae0a318, Offset: 0x8c6
// Size: 0x45
function private function_5418d931d7a9c2c2()
{
    if ( self.var_5798802691d131d.bundle.var_1ee36a15d33999e4 )
    {
        return self.var_5798802691d131d.bundle.var_1ee36a15d33999e4;
    }
    
    return 1;
}

// Namespace ob_interactions_util
// Params 2, eflags: 0x4
// Checksum 0xb7d0c66d, Offset: 0x914
// Size: 0x47
function private function_4157916a3aa064bd( player, var_80bfb1a398f1fca5 )
{
    player endon( #"interaction_complete" );
    player endon( #"disconnect" );
    player waittill( #"death" );
    player widgets_visibility::reset( var_80bfb1a398f1fca5 );
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xf22f3fa, Offset: 0x963
// Size: 0x1b, Type: bool
function private function_cb0dd281d0e0f4ba( var_c5142e0d1342bef0 )
{
    if ( var_c5142e0d1342bef0 != "sat_hacking_device_ob" )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xdf1b9fa2, Offset: 0x987
// Size: 0x1b, Type: bool
function private isvalidgesture( gesture )
{
    if ( gesture != "sat_ges_offhand_1h_intel_pickup" )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xc0493c1e, Offset: 0x9ab
// Size: 0x14, Type: bool
function private isvalidgestureweapon( weaponname )
{
    return weaponname == "earpiece_press_sat_ob";
}

// Namespace ob_interactions_util
// Params 3, eflags: 0x4
// Checksum 0x1d31e12e, Offset: 0x9c8
// Size: 0x67
function private function_6f888f678b89efe1( var_c5142e0d1342bef0, player, var_94e834d8b01bd0a3 )
{
    var_e2b4f1c85347e964 = makeweapon( var_c5142e0d1342bef0 );
    player inventory_utility::_giveweapon( var_e2b4f1c85347e964, undefined, undefined, 0 );
    player setweaponammostock( var_e2b4f1c85347e964, 0 );
    player setweaponammoclip( var_e2b4f1c85347e964, 0 );
    player function_5612a3182e4b7d52( var_94e834d8b01bd0a3 );
    player gameobjects::switchtouseweapon( var_e2b4f1c85347e964, 1 );
    return var_e2b4f1c85347e964;
}

// Namespace ob_interactions_util
// Params 3, eflags: 0x4
// Checksum 0x3da9ba78, Offset: 0xa38
// Size: 0x34
function private function_1e247b5853916cac( var_c5142e0d1342bef0, player, var_94e834d8b01bd0a3 )
{
    player function_5612a3182e4b7d52( var_94e834d8b01bd0a3 );
    player thread utility::function_72b6372d2d8c997( var_c5142e0d1342bef0, 1 );
}

// Namespace ob_interactions_util
// Params 3, eflags: 0x4
// Checksum 0xa8508c68, Offset: 0xa74
// Size: 0x99
function private function_9326d575e2d5591e( var_c5142e0d1342bef0, player, immediate = 0 )
{
    player function_e3b1d4261027fb9c();
    
    if ( player hasweapon( var_c5142e0d1342bef0 ) )
    {
        currentoffhand = player getheldoffhand();
        was_holding = currentoffhand && currentoffhand.basename == var_c5142e0d1342bef0;
        player takeweapon( var_c5142e0d1342bef0 );
        
        if ( was_holding && !immediate )
        {
            msg = player utility::waittill_any_timeout( 1, "gesture_stopped" );
        }
    }
}

// Namespace ob_interactions_util
// Params 2, eflags: 0x4
// Checksum 0xf6ea27f4, Offset: 0xb15
// Size: 0x30
function private function_57ed9717f63bfe03( gesture, player )
{
    player canceloffhands();
    player function_5612a3182e4b7d52( 1 );
    player forceplaygestureviewmodel( gesture, undefined );
}

// Namespace ob_interactions_util
// Params 2, eflags: 0x4
// Checksum 0xbe57689c, Offset: 0xb4d
// Size: 0x34
function private function_a7363caeb2976d61( gesture, player )
{
    player function_e3b1d4261027fb9c();
    player stopgestureviewmodel( gesture );
    
    while ( player isgestureplaying( gesture ) )
    {
        waitframe();
    }
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0x519caa3d, Offset: 0xb89
// Size: 0x71
function private function_5612a3182e4b7d52( var_2d4efe2296ed91cf )
{
    if ( var_2d4efe2296ed91cf )
    {
        val::set( "using_device", "allow_movement", 0 );
        val::set( "using_device", "allow_jump", 0 );
    }
    
    val::set( "using_device", "gesture", 0 );
    val::set( "using_device", "weapon_pickup", 0 );
    val::set( "using_device", "weapon_switch", 0 );
    self function_60e112d2e106b00a();
}

// Namespace ob_interactions_util
// Params 0, eflags: 0x4
// Checksum 0x4ebe7a2e, Offset: 0xc02
// Size: 0x14
function private function_e3b1d4261027fb9c()
{
    val::reset_all( "using_device" );
    self function_7d73d6786e51ae1f();
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xb0d9deab, Offset: 0xc1e
// Size: 0xe0
function private watchcancel( player )
{
    player endon( #"interaction_complete" );
    player endon( #"death_or_disconnect" );
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "cancel", "+weapnext" );
        player notifyonplayercommand( "cancel", "-weapnext" );
    }
    
    player.var_c6e1464ec410750f = 0;
    player utility::waittill_any( "cancel", "super_use_started" );
    player.var_c6e1464ec410750f = 1;
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommandremove( "cancel", "+weapnext" );
        player notifyonplayercommandremove( "cancel", "-weapnext" );
    }
    
    player setscriptablepartstate( "hacking_audio", "fail", 0 );
    
    if ( player.var_80bfb1a398f1fca5 )
    {
        player widgets_visibility::reset( player.var_80bfb1a398f1fca5 );
    }
}

// Namespace ob_interactions_util
// Params 6
// Checksum 0x8c1eb03f, Offset: 0xd06
// Size: 0xae
function function_b2920b846a11242b( var_d1a8bc40d51e3d65, scriptable, on_use_function, var_aa860069b9a5fc3c, var_eacc7d96bf73810e, var_74b8918d075c659e )
{
    scriptable.var_d1a8bc40d51e3d65 = var_d1a8bc40d51e3d65;
    scriptable.on_use_function = on_use_function;
    scriptable.var_aa860069b9a5fc3c = var_aa860069b9a5fc3c;
    scriptable.var_eacc7d96bf73810e = var_eacc7d96bf73810e;
    scriptable = interaction::register_scriptable_interact( scriptable, &function_accc1373ed1f3ccd, &function_d43c881ad9724f4e, &function_c5d2defa70bcfd22 );
    scriptable interaction::function_3d5329c553924b3();
    scriptable.var_1674515c4a4c0655 = [];
    scriptable.var_74b8918d075c659e = var_74b8918d075c659e;
}

// Namespace ob_interactions_util
// Params 7
// Checksum 0xc4f39882, Offset: 0xdbc
// Size: 0xc5
function function_3a40e5af5d2427ec( gesture, scriptable, on_use_function, var_aa860069b9a5fc3c, var_eacc7d96bf73810e, var_35788db5ef3ff129, var_74b8918d075c659e )
{
    scriptable.interaction_gesture = gesture;
    scriptable.on_use_function = on_use_function;
    scriptable.var_aa860069b9a5fc3c = var_aa860069b9a5fc3c;
    scriptable.var_eacc7d96bf73810e = var_eacc7d96bf73810e;
    scriptable.var_35788db5ef3ff129 = var_35788db5ef3ff129;
    scriptable = interaction::register_scriptable_interact( scriptable, &function_accc1373ed1f3ccd, &function_d43c881ad9724f4e, &function_c5d2defa70bcfd22 );
    scriptable interaction::function_3d5329c553924b3();
    scriptable.var_1674515c4a4c0655 = [];
    scriptable.var_74b8918d075c659e = var_74b8918d075c659e;
}

// Namespace ob_interactions_util
// Params 2
// Checksum 0x5356f3fb, Offset: 0xe89
// Size: 0x43
function function_70142b27ee3bb960( origin, angles = ( 0, 0, 0 ) )
{
    var_eebd9757f2ffe5bd = spawnscriptable( "ob_hacking_device_default", origin, angles );
    return var_eebd9757f2ffe5bd;
}

// Namespace ob_interactions_util
// Params 0
// Checksum 0x7d3fb375, Offset: 0xed5
// Size: 0x25, Type: bool
function function_e9bcc6f4aa671db7()
{
    assert( isdefined( self.var_1674515c4a4c0655 ), "<dev string:x24>" );
    return self.var_1674515c4a4c0655.size > 0;
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0x6031d1e, Offset: 0xf03
// Size: 0x203
function private function_c5d2defa70bcfd22( player )
{
    player endon( #"interaction_complete" );
    thread watchcancelhold( player );
    
    if ( isdefined( self.var_eacc7d96bf73810e ) )
    {
        thread [[ self.var_eacc7d96bf73810e ]]( player );
    }
    
    if ( !function_cb0dd281d0e0f4ba( self.var_d1a8bc40d51e3d65 ) && !isvalidgesture( self.interaction_gesture ) )
    {
        return 0;
    }
    
    if ( player.using_device )
    {
        return 0;
    }
    
    player setclientomnvar( "ui_hackingdevice_state", -1 );
    player.using_device = 1;
    self.wasused = 0;
    
    if ( self.var_d1a8bc40d51e3d65 )
    {
        var_c5142e0d1342bef0 = function_6f888f678b89efe1( self.var_d1a8bc40d51e3d65, player, 1 );
    }
    else
    {
        function_57ed9717f63bfe03( self.interaction_gesture, player );
    }
    
    self.var_1674515c4a4c0655[ self.var_1674515c4a4c0655.size ] = player;
    player setclientomnvar( "ui_hackingdevice_state", 0 );
    thread function_7dcdb43e6ab59160( player );
    thread function_aac0387380a1edc4( player, self.var_74b8918d075c659e );
    self.var_bb46d5a7ea3aae62 = 0;
    wait 0.2;
    
    while ( !self.wasused )
    {
        if ( !isalive( player ) || player.fauxdeath || player.var_c6e1464ec410750f )
        {
            self disablescriptableplayeruse( player );
            
            if ( var_c5142e0d1342bef0 )
            {
                player inventory_utility::getridofweapon( var_c5142e0d1342bef0, 1 );
                wait 0.5;
                player function_e3b1d4261027fb9c();
            }
            else
            {
                function_a7363caeb2976d61( self.interaction_gesture, player );
            }
            
            player.using_device = 0;
            self.var_bb46d5a7ea3aae62 = 1;
            self.var_1674515c4a4c0655 = arrayremove( self.var_1674515c4a4c0655, player );
            player setclientomnvar( "ui_hackingdevice_state", -1 );
            self enablescriptableplayeruse( player );
            
            if ( self.var_35788db5ef3ff129 )
            {
                self thread [[ self.var_35788db5ef3ff129 ]]( player );
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace ob_interactions_util
// Params 2, eflags: 0x4
// Checksum 0xcde5de58, Offset: 0x110e
// Size: 0x68
function private function_7dcdb43e6ab59160( player, var_9fb795945c6a8473 = 0.65 )
{
    player endon( #"cancel" );
    player endon( #"super_use_started" );
    player endon( #"disconnect" );
    wait var_9fb795945c6a8473;
    
    if ( !player.var_c6e1464ec410750f )
    {
        player setclientomnvar( "ui_hackingdevice_state", 1 );
    }
}

// Namespace ob_interactions_util
// Params 2, eflags: 0x4
// Checksum 0xf116dc4f, Offset: 0x117e
// Size: 0x6b
function private function_aac0387380a1edc4( player, var_726b012d1bedd86b = 2 )
{
    player endon( #"cancel" );
    player endon( #"super_use_started" );
    player endon( #"disconnect" );
    wait var_726b012d1bedd86b - 0.65;
    
    if ( !player.var_c6e1464ec410750f )
    {
        player setclientomnvar( "ui_hackingdevice_state", 2 );
    }
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0xe13f5876, Offset: 0x11f1
// Size: 0x27
function private function_d43c881ad9724f4e( player )
{
    if ( isdefined( self.var_aa860069b9a5fc3c ) )
    {
        [[ self.var_aa860069b9a5fc3c ]]( player );
    }
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0x9d0c6303, Offset: 0x1220
// Size: 0x214
function private function_accc1373ed1f3ccd( player )
{
    self.wasused = 1;
    player notify( #"interaction_complete" );
    
    if ( self.var_35788db5ef3ff129 )
    {
        self thread [[ self.var_35788db5ef3ff129 ]]( player );
    }
    
    if ( isdefined( self.on_use_function ) )
    {
        thread [[ self.on_use_function ]]( player );
    }
    
    if ( self.var_dc502194ad8f6f01 )
    {
        self setscriptablepartstate( "interact", "unusable" );
    }
    
    if ( self.var_d1a8bc40d51e3d65 )
    {
        var_bb7b9f3e99426c4d = getdvarint( @"hash_7c14bd5d6a04f082", 1 );
        player inventory_utility::getridofweapon( self.var_d1a8bc40d51e3d65, var_bb7b9f3e99426c4d );
        player function_e3b1d4261027fb9c();
    }
    else
    {
        function_a7363caeb2976d61( self.interaction_gesture, player );
    }
    
    if ( isdefined( player ) )
    {
        player notifyonplayercommandremove( "cancel", "-usereload" );
        player notifyonplayercommandremove( "cancel", "-activate" );
    }
    
    player.using_device = 0;
    
    if ( isarray( self.var_1674515c4a4c0655 ) )
    {
        if ( isplayer( player ) && arraycontains( self.var_1674515c4a4c0655, player ) )
        {
            self.var_1674515c4a4c0655 = arrayremove( self.var_1674515c4a4c0655, player );
        }
        
        if ( self.var_1674515c4a4c0655.size > 0 )
        {
            foreach ( var_60a18211288345a4 in self.var_1674515c4a4c0655 )
            {
                if ( self.var_d1a8bc40d51e3d65 )
                {
                    var_60a18211288345a4 function_f80e05693bd6a7e5( self.var_d1a8bc40d51e3d65 );
                    continue;
                }
                
                var_60a18211288345a4 function_274323340522ae7a( self.interaction_gesture );
            }
            
            self.var_1674515c4a4c0655 = [];
        }
    }
    
    if ( self.var_dc502194ad8f6f01 )
    {
        self freescriptable();
    }
}

// Namespace ob_interactions_util
// Params 1, eflags: 0x4
// Checksum 0x51f2433f, Offset: 0x143c
// Size: 0xea
function private watchcancelhold( player )
{
    player endon( #"interaction_complete" );
    player endon( #"death_or_disconnect" );
    player.var_c6e1464ec410750f = 0;
    player notifyonplayercommand( "cancel", "-usereload" );
    player notifyonplayercommand( "cancel", "-activate" );
    wait 0.2;
    
    if ( player usebuttonpressed( 1 ) )
    {
        player utility::waittill_any( "cancel", "super_use_started" );
        player.var_c6e1464ec410750f = 1;
    }
    else
    {
        player.var_c6e1464ec410750f = 1;
    }
    
    if ( player.var_80bfb1a398f1fca5 )
    {
        player widgets_visibility::reset( player.var_80bfb1a398f1fca5 );
    }
    
    player setclientomnvar( "ui_hackingdevice_state", -1 );
    player notifyonplayercommandremove( "cancel", "-usereload" );
    player notifyonplayercommandremove( "cancel", "-activate" );
}

// Namespace ob_interactions_util
// Params 1
// Checksum 0x9485eb72, Offset: 0x152e
// Size: 0x84
function function_f80e05693bd6a7e5( var_548f2c5a041171d7 )
{
    if ( isdefined( self.using_device ) )
    {
        if ( !self.using_device )
        {
            return;
        }
        
        var_c5142e0d1342bef0 = makeweapon( var_548f2c5a041171d7 );
        
        if ( self.currentweapon == var_c5142e0d1342bef0 )
        {
            inventory_utility::getridofweapon( var_c5142e0d1342bef0, 1 );
            self notifyonplayercommandremove( "cancel", "-usereload" );
            self notifyonplayercommandremove( "cancel", "-activate" );
            function_e3b1d4261027fb9c();
            self.using_device = 0;
        }
    }
}

// Namespace ob_interactions_util
// Params 1
// Checksum 0x4dba4500, Offset: 0x15ba
// Size: 0x65
function function_274323340522ae7a( gesture )
{
    if ( isdefined( self.using_device ) )
    {
        if ( !self.using_device )
        {
            return;
        }
        
        if ( self isgestureplaying( gesture ) )
        {
            function_a7363caeb2976d61( gesture, self );
            self notifyonplayercommandremove( "cancel", "-usereload" );
            self notifyonplayercommandremove( "cancel", "-activate" );
            self.using_device = 0;
        }
    }
}

// Namespace ob_interactions_util
// Params 6
// Checksum 0x133827c6, Offset: 0x1627
// Size: 0x92
function function_575ced8669e25f2c( var_d1a8bc40d51e3d65, var_31b15f93363a1dd0, scriptable_interact_override = "ob_anim_interact", on_use_function, var_aa860069b9a5fc3c, var_eacc7d96bf73810e )
{
    interact_scriptable = spawnscriptable( scriptable_interact_override, var_31b15f93363a1dd0 );
    
    while ( !isdefined( interact_scriptable ) )
    {
        waitframe();
    }
    
    interact_scriptable setscriptablepartstate( "interact", "usable" );
    interact_scriptable.var_dc502194ad8f6f01 = 1;
    function_b2920b846a11242b( var_d1a8bc40d51e3d65, interact_scriptable, on_use_function, var_aa860069b9a5fc3c, var_eacc7d96bf73810e );
    return interact_scriptable;
}

/#

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0x176c3fbc, Offset: 0x16c2
    // Size: 0x85, Type: dev
    function init_interactions_devgui( params )
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x42>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66>", "<dev string:x71>", &function_12ddba339b222524, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7b>", "<dev string:x8e>", &function_837cef9d79e08888, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9f>", "<dev string:xb0>", &function_9fd68f861be26af6, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xc0>", "<dev string:xd9>", &function_aae3834a42b51b61, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0x3bf4402c, Offset: 0x174f
    // Size: 0x33, Type: dev
    function function_12ddba339b222524( params )
    {
        var_fab006cdb4f6e516 = function_c7b5806740384a61( "<dev string:xf0>", level.players[ 0 ], 10 );
    }

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0x22cc13a9, Offset: 0x178a
    // Size: 0x33, Type: dev
    function function_837cef9d79e08888( params )
    {
        var_fab006cdb4f6e516 = function_c7b5806740384a61( "<dev string:x106>", level.players[ 0 ], 10 );
    }

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0xb2357840, Offset: 0x17c5
    // Size: 0x8a, Type: dev
    function function_9fd68f861be26af6( params )
    {
        if ( isdefined( level.var_79bc24a684b2badb ) )
        {
            level.var_79bc24a684b2badb freescriptable();
            level.var_79bc24a684b2badb notify( #"death" );
        }
        
        level.var_79bc24a684b2badb = function_70142b27ee3bb960( level.players[ 0 ].origin + ( 30, 30, 0 ) );
        function_b2920b846a11242b( "<dev string:xf0>", level.var_79bc24a684b2badb, &function_f8dfcf07aabae6e8 );
    }

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0x34d3687d, Offset: 0x1857
    // Size: 0x8a, Type: dev
    function function_aae3834a42b51b61( params )
    {
        if ( isdefined( level.var_eaec0c9f22642f22 ) )
        {
            level.var_eaec0c9f22642f22 freescriptable();
            level.var_eaec0c9f22642f22 notify( #"death" );
        }
        
        level.var_eaec0c9f22642f22 = function_70142b27ee3bb960( level.players[ 0 ].origin + ( 30, 30, 0 ) );
        function_3a40e5af5d2427ec( "<dev string:x11c>", level.var_eaec0c9f22642f22, &function_f8dfcf07aabae6e8 );
    }

    // Namespace ob_interactions_util
    // Params 1
    // Checksum 0x8620e51d, Offset: 0x18e9
    // Size: 0xf, Type: dev
    function function_f8dfcf07aabae6e8( params )
    {
        
    }

#/
