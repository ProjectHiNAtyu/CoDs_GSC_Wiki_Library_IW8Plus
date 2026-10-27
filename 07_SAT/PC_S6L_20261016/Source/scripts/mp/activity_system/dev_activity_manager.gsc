// scripts\mp\activity_system\dev_activity_manager.gsc  (hash_1a1c0c49363f4ad7.gscc) (size: 5780 Bytes / 0x1694 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea3e0233 (3929932339)
// size ...... 5780 (0x1694)
// includes .. 6   (offset: 0x1530)
// strings ... 0   (offset: 0x1560)
// dev strs .. 23  (offset: 0x1560)
// exports ... 20  (offset: 0xdac)
// cseg ...... 0x58 + 0xd54 (0xdac)
// imports ... 37  (offset: 0x10cc)
// animtree1 . 0   (offset: 0x1694)
// animtree2 . 0   (offset: 0x1694)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;

#namespace dev_activity_manager;

/#

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x5
    // Checksum 0x57be3e20, Offset: 0x76
    // Size: 0x1c, Type: dev
    function private autoexec __init__system__()
    {
        system::register( #"dev_activity_manager", undefined, undefined, &post_main );
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0x504038c0, Offset: 0x9a
    // Size: 0x61, Type: dev
    function private post_main()
    {
        if ( !level.var_c339a4b8c7451a75 )
        {
            return;
        }
        
        level.dev_activities = [];
        level.dev_buttons = [];
        function_ca19f4586d15946c( &sortbuttons );
        devgui::add_devgui_func( "<dev string:x24>" + "<dev string:x34>", "<dev string:x42>", &teleporthome, 0, 0 );
        level thread function_69512290c8cdc1fb();
        level thread function_6de670d056af422b();
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0x6ba47d94, Offset: 0x103
    // Size: 0x22b, Type: dev
    function private function_6de670d056af422b()
    {
        wait 1;
        var_1bd8b956bef44a34 = [];
        var_1bb6605d35670fbd = [];
        var_379ce6899ccef40a = utility::getstructarray( "<dev string:x4f>", "<dev string:x66>" );
        
        foreach ( activitystruct in var_379ce6899ccef40a )
        {
            var_1bd8b956bef44a34[ activitystruct.script_noteworthy ] = 1;
        }
        
        foreach ( activitystruct in level.dev_activities )
        {
            var_1bb6605d35670fbd[ activitystruct.prefabstruct.script_noteworthy ] = 1;
        }
        
        foreach ( noteworthy, struct in var_1bd8b956bef44a34 )
        {
            if ( !isdefined( var_1bb6605d35670fbd[ noteworthy ] ) )
            {
                script::demoforcesre( "<dev string:x71>" + noteworthy + "<dev string:x7b>" );
            }
        }
        
        foreach ( noteworthy, struct in var_1bb6605d35670fbd )
        {
            if ( !isdefined( var_1bd8b956bef44a34[ noteworthy ] ) )
            {
                script::demoforcesre( "<dev string:x71>" + noteworthy + "<dev string:x9d>" );
            }
        }
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0xe399c5b3, Offset: 0x336
    // Size: 0xb2, Type: dev
    function private function_69512290c8cdc1fb()
    {
        level waittill( #"prematch_started" );
        
        foreach ( activity in level.dev_activities )
        {
            if ( activity.isactive && isdefined( activity.deactivatefunc ) )
            {
                deactivateactivity( activity.name );
            }
        }
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0xfb9883d7, Offset: 0x3f0
    // Size: 0x136, Type: dev
    function private function_ca19f4586d15946c( sortfunc )
    {
        buttons = utility::getstructarray( "<dev string:xc2>", "<dev string:x66>" );
        
        if ( buttons.size == 0 )
        {
            return;
        }
        
        foreach ( button in buttons )
        {
            button.script_model = getent( button.target, #targetname );
            button.hint_print = utility::getstruct( button.script_model.target, "<dev string:x66>" );
            button.enabled = 0;
            button.script_model hide();
        }
        
        if ( isdefined( sortfunc ) )
        {
            level.dev_buttons = arraysort( buttons, undefined, sortfunc );
        }
        else
        {
            level.dev_buttons = buttons;
        }
        
        level thread function_759888fb4864dd53();
    }

    // Namespace dev_activity_manager
    // Params 2, eflags: 0x4
    // Checksum 0xd944c787, Offset: 0x52e
    // Size: 0x72, Type: dev
    function private sortbuttons( button1, button2 )
    {
        if ( button1.origin[ 1 ] == button2.origin[ 1 ] )
        {
            return ( button1.origin[ 0 ] > button2.origin[ 0 ] );
        }
        
        return button1.origin[ 1 ] > button2.origin[ 1 ];
    }

    // Namespace dev_activity_manager
    // Params 4
    // Checksum 0xcb295fef, Offset: 0x5a8
    // Size: 0x105, Type: dev
    function addactivity( activityname, prefabstruct, activatefunc, deactivatefunc )
    {
        assert( isdefined( activityname ) );
        assert( isdefined( prefabstruct ) );
        activity = spawnstruct();
        activity.name = activityname;
        activity.prefabstruct = prefabstruct;
        activity.activatefunc = activatefunc;
        activity.deactivatefunc = deactivatefunc;
        activity.isactive = 0;
        level.dev_activities[ activity.name ] = activity;
        activity setupdevgui();
        
        if ( isdefined( activatefunc ) )
        {
            togglebutton = activity function_470f3ff4c95494ea( &function_e2357b6f84fbe122, "<dev string:xc9>" + activityname );
            
            if ( isdefined( togglebutton ) )
            {
                activity.togglebutton = togglebutton;
            }
        }
        
        activity function_470f3ff4c95494ea( &function_dcf9a8096dd8e7b8, "<dev string:xd3>" + activityname );
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0xc1be34b2, Offset: 0x6b5
    // Size: 0xfe, Type: dev
    function private setupdevgui()
    {
        activity = self;
        devgui::function_cd4e263c1f3018ae( "<dev string:x24>" + activity.name + "<dev string:xe0>", "<dev string:xea>" + activity.name, &function_b64a34621af566c1, 0, level.dev_activities.size );
        
        if ( isdefined( activity.activatefunc ) )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x24>" + activity.name + "<dev string:x103>", "<dev string:x10d>" + activity.name, &function_b65fdd6876c32b01, 0, level.dev_activities.size );
        }
        else
        {
            activity.isactive = 1;
        }
        
        if ( isdefined( activity.deactivatefunc ) )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x24>" + activity.name + "<dev string:x126>", "<dev string:x132>" + activity.name, &function_eeaaf9f65dbeeae4, 0, level.dev_activities.size );
        }
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0x61dc5983, Offset: 0x7bb
    // Size: 0x4f, Type: dev
    function private teleporthome()
    {
        player = level.players[ 0 ];
        tplocation = getgroundposition( ( 0, 0, 0 ), 10 ) + ( 0, 0, 10 );
        player setorigin( tplocation );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x1b88446b, Offset: 0x812
    // Size: 0x19, Type: dev
    function private function_b64a34621af566c1( args )
    {
        function_f2739edfc21e6202( args[ 0 ] );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x986e141d, Offset: 0x833
    // Size: 0x77, Type: dev
    function private function_f2739edfc21e6202( activityname )
    {
        player = level.players[ 0 ];
        activity = level.dev_activities[ activityname ];
        tplocation = getgroundposition( activity.prefabstruct.origin, 10 ) + ( 0, 0, 10 );
        player setorigin( tplocation );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x860bda32, Offset: 0x8b2
    // Size: 0x19, Type: dev
    function private function_b65fdd6876c32b01( args )
    {
        activateactivity( args[ 0 ] );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x2440688e, Offset: 0x8d3
    // Size: 0xc7, Type: dev
    function private activateactivity( activityname )
    {
        activity = level.dev_activities[ activityname ];
        
        if ( activity.isactive )
        {
            iprintlnbold( "<dev string:x14d>" );
            return;
        }
        
        activity.isactive = 1;
        
        if ( isdefined( activity.activatefunc ) )
        {
            activity thread [[ activity.activatefunc ]]();
        }
        
        if ( isdefined( activity.togglebutton ) )
        {
            if ( isdefined( activity.deactivatefunc ) )
            {
                activity.togglebutton.hint_string = "<dev string:x168>" + activityname;
                return;
            }
            
            activity.togglebutton.hint_string = "<dev string:x174>";
        }
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x3d7bb05c, Offset: 0x9a2
    // Size: 0x19, Type: dev
    function private function_eeaaf9f65dbeeae4( args )
    {
        deactivateactivity( args[ 0 ] );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0xa8ea1692, Offset: 0x9c3
    // Size: 0x9a, Type: dev
    function private deactivateactivity( activityname )
    {
        activity = level.dev_activities[ activityname ];
        
        if ( !activity.isactive )
        {
            iprintlnbold( "<dev string:x175>" );
            return;
        }
        
        activity.isactive = 0;
        
        if ( isdefined( activity.deactivatefunc ) )
        {
            activity thread [[ activity.deactivatefunc ]]();
        }
        
        if ( isdefined( activity.togglebutton ) )
        {
            activity.togglebutton.hint_string = "<dev string:xc9>" + activityname;
        }
    }

    // Namespace dev_activity_manager
    // Params 2, eflags: 0x4
    // Checksum 0xbf251c00, Offset: 0xa65
    // Size: 0xfa, Type: dev
    function private function_470f3ff4c95494ea( callbackfunc, hintstring )
    {
        activity = self;
        
        if ( !isdefined( level.dev_buttons ) )
        {
            script::demoforcesre( "<dev string:x192>" );
            return;
        }
        
        for ( index = 0; index < level.dev_buttons.size ; index++ )
        {
            button = level.dev_buttons[ index ];
            
            if ( button.enabled )
            {
                continue;
            }
            
            button.enabled = 1;
            button.script_model show();
            button.hint_string = hintstring;
            button.script_model.activity_name = activity.name;
            interaction::register_interact( button.script_model, 64, callbackfunc );
            return button;
        }
        
        script::demoforcesre( "<dev string:x1b0>" );
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0xc487b07a, Offset: 0xb67
    // Size: 0x7c, Type: dev
    function private function_e2357b6f84fbe122( player )
    {
        activityname = self.activity_name;
        activity = level.dev_activities[ activityname ];
        
        if ( activity.isactive && isdefined( activity.deactivatefunc ) )
        {
            deactivateactivity( activityname );
            return;
        }
        
        if ( !activity.isactive )
        {
            activateactivity( activityname );
        }
    }

    // Namespace dev_activity_manager
    // Params 1, eflags: 0x4
    // Checksum 0x613110a9, Offset: 0xbeb
    // Size: 0x51, Type: dev
    function private function_dcf9a8096dd8e7b8( player )
    {
        activityname = self.activity_name;
        activity = level.dev_activities[ activityname ];
        
        if ( activity.isactive )
        {
            function_f2739edfc21e6202( activityname );
        }
    }

    // Namespace dev_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0xf5a51663, Offset: 0xc44
    // Size: 0x168, Type: dev
    function private function_759888fb4864dd53()
    {
        if ( !isdefined( level.dev_buttons ) )
        {
            script::demoforcesre( "<dev string:x192>" );
            return;
        }
        
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( level.players[ 0 ] ) )
            {
                continue;
            }
            
            foreach ( button in level.dev_buttons )
            {
                if ( !button.enabled )
                {
                    continue;
                }
                
                dist = distancesquared( level.players[ 0 ].origin, button.hint_print.origin );
                
                if ( dist > 1440000 )
                {
                    continue;
                }
                
                alpha = 1 - math::normalize_value( 720000, 1440000, dist );
                print3d( button.hint_print.origin, button.hint_string, ( 1, 1, 1 ), alpha, 0.4 );
            }
        }
    }

#/
