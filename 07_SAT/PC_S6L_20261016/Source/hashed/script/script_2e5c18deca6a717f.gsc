// script_2e5c18deca6a717f  (hash_2e5c18deca6a717f.gscc) (size: 3735 Bytes / 0xe97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x696d0422 (1768752162)
// size ...... 3735 (0xe97)
// includes .. 7   (offset: 0xcaf)
// strings ... 0   (offset: 0xce7)
// dev strs .. 35  (offset: 0xce7)
// exports ... 13  (offset: 0x75b)
// cseg ...... 0x58 + 0x703 (0x75b)
// imports ... 26  (offset: 0x963)
// animtree1 . 0   (offset: 0xe97)
// animtree2 . 0   (offset: 0xe97)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;

#namespace namespace_4b9b6c5a5daa32b4;

/#

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1
    // Checksum 0x1438e3ce, Offset: 0x76
    // Size: 0x13e, Type: dev
    function registerdevgui( var_45a0fbe6db07f1db )
    {
        devgui::function_9082edeb5db93280( var_45a0fbe6db07f1db + "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2e>", "<dev string:x58>", &function_43cf8da33bc7ec9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x88>", "<dev string:xb5>", &function_43cf8da33bc7ec9 );
        devgui::add_devgui_command( "<dev string:xe2>", "<dev string:xfa>" );
        devgui::add_devgui_func( "<dev string:x152>", "<dev string:x16e>", &function_4035991e7e4ef997 );
        devgui::add_devgui_func( "<dev string:x18a>", "<dev string:x1a9>", &function_90f6bbe828495247 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_45a0fbe6db07f1db + "<dev string:x1c8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e1>", "<dev string:x1fe>", &function_46e85a4289eafbec );
        devgui::function_cd4e263c1f3018ae( "<dev string:x21c>", "<dev string:x239>", &function_46e85a4289eafbec );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_45a0fbe6db07f1db + "<dev string:x257>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26f>", "<dev string:x28c>", &function_4f77b8f54aa38957 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2c8>", "<dev string:x2da>", &function_4f77b8f54aa38957 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x311>", "<dev string:x322>", &function_4f77b8f54aa38957 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x358>", "<dev string:x368>", &function_4f77b8f54aa38957 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 0, eflags: 0x4
    // Checksum 0xe8b1981f, Offset: 0x1bc
    // Size: 0x8a, Type: dev
    function private function_3f29066b74115e37()
    {
        foreach ( activity_instance in activity_common::function_394486cf35d84dc8() )
        {
            if ( activity_instance_common::getactivitytype( activity_instance ) != "<dev string:x39d>" )
            {
                continue;
            }
            
            return activity_instance;
        }
        
        return;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 0, eflags: 0x4
    // Checksum 0xbb35a245, Offset: 0x24e
    // Size: 0x4f, Type: dev
    function private function_e76a511f0dcc6962()
    {
        activity_instance = function_3f29066b74115e37();
        phase_activity = level.elite_ironclad.var_f4ace6bce7ae354f;
        
        if ( phase_activity )
        {
            return phase_activity;
        }
        
        if ( !activity_instance )
        {
            return;
        }
        
        return activity_instance.phaseactivity;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 0, eflags: 0x4
    // Checksum 0xe9559e6, Offset: 0x2a5
    // Size: 0x40, Type: dev
    function private function_e7443a1036fb17dd()
    {
        host = gamelogic_mp::gethostplayer( 1 );
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        if ( !utility::flag( "<dev string:x3b8>" ) )
        {
            adddebugcommand( "<dev string:x3c9>" );
            wait 2;
        }
        
        return host;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1, eflags: 0x4
    // Checksum 0x17a05289, Offset: 0x2ed
    // Size: 0xb0, Type: dev
    function private function_494b72046cef7335( owner )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || player == owner || player.team == owner.team )
            {
                continue;
            }
            
            return player;
        }
        
        return;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 2, eflags: 0x4
    // Checksum 0x977f0a02, Offset: 0x3a5
    // Size: 0x62, Type: dev
    function private function_959113eed82edffc( owner, params )
    {
        team_selector = params[ 0 ];
        
        if ( team_selector == "<dev string:x3dc>" )
        {
            var_cda59cc8b5ebd6c2 = function_494b72046cef7335( owner );
            
            if ( var_cda59cc8b5ebd6c2 )
            {
                return var_cda59cc8b5ebd6c2.team;
            }
            
            return;
        }
        
        return owner.team;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1, eflags: 0x4
    // Checksum 0xfe068d78, Offset: 0x40f
    // Size: 0x5a, Type: dev
    function private function_ad242ced9fad8aca( var_dde1be76c8097627 )
    {
        phase_activity = function_e76a511f0dcc6962();
        
        if ( !phase_activity )
        {
            return;
        }
        
        var_5174ac76a44dc2ab = phase_activity.var_332f929de1894b2b.var_1031868a166f4d60;
        
        if ( !var_5174ac76a44dc2ab )
        {
            return;
        }
        
        return var_5174ac76a44dc2ab + "<dev string:x3e2>" + var_dde1be76c8097627;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1
    // Checksum 0x9f3c777a, Offset: 0x471
    // Size: 0xda, Type: dev
    function function_4f77b8f54aa38957( params )
    {
        activity_definition = params[ 0 ];
        
        if ( !activity_definition )
        {
            return;
        }
        
        host = function_e7443a1036fb17dd();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        var_9955f93e8f3e6b37 = strtok( activity_definition, "<dev string:x3e4>" );
        
        if ( var_9955f93e8f3e6b37.size == 1 )
        {
            activity_definition = "<dev string:x3e6>" + activity_definition;
        }
        
        var_bd2ab1112cfdd196 = getscriptbundle( activity_definition );
        
        if ( !isdefined( var_bd2ab1112cfdd196 ) )
        {
            return;
        }
        
        phase_variant_data = activity_definition_utils::function_9129cd8075c85c09( var_bd2ab1112cfdd196 );
        phase_activity = { #var_332f929de1894b2b:phase_variant_data };
        level.elite_ironclad.var_de1da14fc2af6da3 = host.team;
        level.elite_ironclad.var_f4ace6bce7ae354f = phase_activity;
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1
    // Checksum 0xc2a8c38f, Offset: 0x553
    // Size: 0x8d, Type: dev
    function function_43cf8da33bc7ec9( params )
    {
        owner = function_e7443a1036fb17dd();
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        activating_team = function_959113eed82edffc( owner, params );
        activating_player = owner;
        splash_ref = "<dev string:x3fa>";
        
        if ( activating_team != owner.team )
        {
            activating_player = function_494b72046cef7335( owner );
            splash_ref = "<dev string:x411>";
        }
        
        owner hud_message::showsplash( splash_ref, undefined, activating_player, undefined, undefined, "<dev string:x42f>" );
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 0
    // Checksum 0xacd97df9, Offset: 0x5e8
    // Size: 0x70, Type: dev
    function function_4035991e7e4ef997()
    {
        owner = function_e7443a1036fb17dd();
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        phase_activity = function_e76a511f0dcc6962();
        
        if ( !phase_activity )
        {
            return;
        }
        
        pickup_splash = phase_activity.var_332f929de1894b2b.var_8aa44f37c2b20275;
        
        if ( !pickup_splash )
        {
            return;
        }
        
        owner hud_message::showsplash( pickup_splash, undefined, owner, undefined, undefined, "<dev string:x42f>" );
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 0
    // Checksum 0x7df4b703, Offset: 0x660
    // Size: 0x70, Type: dev
    function function_90f6bbe828495247()
    {
        owner = function_e7443a1036fb17dd();
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        phase_activity = function_e76a511f0dcc6962();
        
        if ( !phase_activity )
        {
            return;
        }
        
        pickup_splash = phase_activity.var_332f929de1894b2b.var_1ff3ac3b7136a04d;
        
        if ( !pickup_splash )
        {
            return;
        }
        
        owner hud_message::showsplash( pickup_splash, undefined, owner, undefined, undefined, "<dev string:x42f>" );
    }

    // Namespace namespace_4b9b6c5a5daa32b4
    // Params 1
    // Checksum 0xda7cbbd1, Offset: 0x6d8
    // Size: 0x83, Type: dev
    function function_46e85a4289eafbec( params )
    {
        owner = function_e7443a1036fb17dd();
        
        if ( !isdefined( owner ) )
        {
            return;
        }
        
        saboteur = function_494b72046cef7335( owner );
        
        if ( !saboteur )
        {
            return;
        }
        
        var_dde1be76c8097627 = params[ 0 ];
        
        if ( !var_dde1be76c8097627 )
        {
            return;
        }
        
        splash_name = function_ad242ced9fad8aca( var_dde1be76c8097627 );
        
        if ( !splash_name )
        {
            return;
        }
        
        owner hud_message::showsplash( splash_name, undefined, saboteur, undefined, undefined, "<dev string:x42f>" );
    }

#/
