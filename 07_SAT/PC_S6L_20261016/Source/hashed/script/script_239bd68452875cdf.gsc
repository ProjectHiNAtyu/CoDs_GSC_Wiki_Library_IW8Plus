// script_239bd68452875cdf  (hash_239bd68452875cdf.gscc) (size: 5403 Bytes / 0x151b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x978affcb (2542469067)
// size ...... 5403 (0x151b)
// includes .. 7   (offset: 0x1423)
// strings ... 0   (offset: 0x145b)
// dev strs .. 15  (offset: 0x145b)
// exports ... 14  (offset: 0xce3)
// cseg ...... 0x58 + 0xc8b (0xce3)
// imports ... 41  (offset: 0xf13)
// animtree1 . 0   (offset: 0x151b)
// animtree2 . 0   (offset: 0x151b)
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_util;

#namespace live_ragdoll_test;

/#

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x5
    // Checksum 0x4a8c8635, Offset: 0x76
    // Size: 0x7f, Type: dev
    function private autoexec initialize()
    {
        last_stand_value = level.laststand ?? getmatchrulesdata( "<dev string:x24>", "<dev string:x31>" );
        
        if ( last_stand_value == 2 || last_stand_value == 3 )
        {
            setdevdvar( @"scr_live_ragdoll_test", 0 );
            setdevdvar( @"hash_494aa0d0912c6e5f", 0 );
            setdevdvar( @"hash_53f1bc3cea55331e", 0 );
            setdevdvar( @"hash_d389265456a6e8ab", 0 );
            thread live_ragdoll_test_thread();
        }
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0xd19e1a81, Offset: 0xfd
    // Size: 0x14, Type: dev
    function private get_live_ragdoll_test()
    {
        return getdvarint( @"scr_live_ragdoll_test", 0 );
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0x920dd0f4, Offset: 0x119
    // Size: 0x14, Type: dev
    function private function_3f92cae9bf532c2b()
    {
        return getdvarint( @"hash_494aa0d0912c6e5f", 0 );
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0x2bd5358a, Offset: 0x135
    // Size: 0x14, Type: dev
    function private function_3ce4918fffbd5ba()
    {
        return getdvarint( @"hash_53f1bc3cea55331e", 0 );
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0x99aa4731, Offset: 0x151
    // Size: 0x14, Type: dev
    function private function_e4ca026120f22c27()
    {
        return getdvarint( @"hash_d389265456a6e8ab", 0 );
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0xc
    // Checksum 0x3b25485e, Offset: 0x16d
    // Size: 0x13e, Type: dev
    function private function_cb9802b469397626()
    {
        self notify( #"hash_dfa72627b9968fec" );
        self endon( #"hash_dfa72627b9968fec" );
        level endon( #"game_ended" );
        live_ragdoll_test = get_live_ragdoll_test();
        
        while ( true )
        {
            wait 1;
            updated_live_ragdoll_test = get_live_ragdoll_test();
            
            if ( live_ragdoll_test != updated_live_ragdoll_test )
            {
                if ( level.live_ragdoll_test.var_772608fac01056b4 )
                {
                    setdvar( @"scr_live_ragdoll_test", live_ragdoll_test );
                }
                else
                {
                    level notify( #"live_ragdoll_test", updated_live_ragdoll_test );
                    live_ragdoll_test = updated_live_ragdoll_test;
                }
            }
            
            if ( live_ragdoll_test == 0 )
            {
                continue;
            }
            
            var_aedaf22b81d19b4c = function_3f92cae9bf532c2b();
            
            if ( var_aedaf22b81d19b4c != 0 )
            {
                level notify( #"hash_23f7cf4d404fd8a5", var_aedaf22b81d19b4c );
                setdvar( @"hash_494aa0d0912c6e5f", 0 );
            }
            
            var_193c0304eac3cb1f = function_3ce4918fffbd5ba();
            
            if ( var_193c0304eac3cb1f != 0 )
            {
                level notify( #"hash_157f5271ff4afd50", var_193c0304eac3cb1f );
                setdvar( @"hash_53f1bc3cea55331e", 0 );
            }
            
            live_ragdoll_test_enemy_bot = function_e4ca026120f22c27();
            
            if ( live_ragdoll_test_enemy_bot != 0 )
            {
                level notify( #"live_ragdoll_test_enemy_bot", live_ragdoll_test_enemy_bot );
                setdvar( @"hash_d389265456a6e8ab", 0 );
            }
        }
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0xc
    // Checksum 0x203176f5, Offset: 0x2b3
    // Size: 0x49e, Type: dev
    function private live_ragdoll_test_thread()
    {
        self notify( #"hash_4418ec3dced9cb33" );
        self endon( #"hash_4418ec3dced9cb33" );
        level endon( #"game_ended" );
        thread function_cb9802b469397626();
        
        while ( true )
        {
            level waittill( #"live_ragdoll_test", live_ragdoll_test );
            level.live_ragdoll_test = {};
            level.live_ragdoll_test.var_772608fac01056b4 = 1;
            level.live_ragdoll_test.var_54e459d33138bbd0 = gamelogic_mp::gethostplayer();
            level.live_ragdoll_test.hud_display = level.live_ragdoll_test.var_54e459d33138bbd0 hud_util::createfontstring( "<dev string:x3b>", 1.2 );
            level.live_ragdoll_test.hud_display.color = ( 0, 1, 0 );
            level.live_ragdoll_test.hud_display hud_util::setpoint( "<dev string:x43>", "<dev string:x43>", 140, 30 );
            level.live_ragdoll_test.hud_display setdevtext( "<dev string:x4b>" );
            host_player_angles = level.live_ragdoll_test.var_54e459d33138bbd0 getplayerangles();
            host_player_forward = 120 * anglestoforward( host_player_angles );
            host_player_right = 36 * anglestoright( host_player_angles );
            var_9c290b8c919d05a6 = level.live_ragdoll_test.var_54e459d33138bbd0.origin + host_player_forward + host_player_right + ( 0, 0, 36 );
            var_a4c0ce7f6d9d774a = level.live_ragdoll_test.var_54e459d33138bbd0.origin + host_player_forward - host_player_right + ( 0, 0, 36 );
            var_d84cef0c36e16284 = { #angles:( 0, host_player_angles[ 1 ] + 180, 0 ), #origin:var_9c290b8c919d05a6 };
            var_72f66423c11f14b0 = { #angles:( 0, host_player_angles[ 1 ] + 180, 0 ), #origin:var_a4c0ce7f6d9d774a };
            thread bots::spawn_bots( 1, level.live_ragdoll_test.var_54e459d33138bbd0.team, &function_6484c8245761fedd, undefined, undefined, undefined, var_d84cef0c36e16284 );
            level waittill( #"hash_8112655e0e206551" );
            other_team = team_utility::getotherteam( level.live_ragdoll_test.var_54e459d33138bbd0.team );
            thread bots::spawn_bots( 1, other_team, &function_6484c8245761fedd, undefined, undefined, undefined, var_72f66423c11f14b0 );
            level waittill( #"hash_66a2874f13a8fe98" );
            thread function_931da4739b874754( level.live_ragdoll_test.var_54e459d33138bbd0, "<dev string:x65>" );
            thread function_931da4739b874754( level.live_ragdoll_test.friendly_bot, "<dev string:x83>" );
            thread function_931da4739b874754( level.live_ragdoll_test.var_d9084239cc1ec7f0, "<dev string:xa2>" );
            waitframe();
            level.live_ragdoll_test.var_772608fac01056b4 = undefined;
            level waittill( #"live_ragdoll_test" );
            
            if ( level.live_ragdoll_test.var_54e459d33138bbd0.healthregendisabled )
            {
                level.live_ragdoll_test.var_54e459d33138bbd0.healthregendisabled = 0;
            }
            
            if ( isdefined( level.live_ragdoll_test.misc_bots ) )
            {
                foreach ( bot in level.live_ragdoll_test.misc_bots )
                {
                    bot bots::bot_drop();
                }
            }
            
            level.live_ragdoll_test.friendly_bot bots::bot_drop();
            level.live_ragdoll_test.var_d9084239cc1ec7f0 bots::bot_drop();
            level.live_ragdoll_test.friendly_bot = undefined;
            level.live_ragdoll_test.var_d9084239cc1ec7f0 = undefined;
            level.live_ragdoll_test.hud_display destroy();
            level.live_ragdoll_test = undefined;
        }
    }

    // Namespace live_ragdoll_test
    // Params 2, eflags: 0x4
    // Checksum 0x1a220b8, Offset: 0x759
    // Size: 0x83, Type: dev
    function private function_931da4739b874754( var_ed4d82fcd6d2419f, notify_string )
    {
        level endon( #"game_ended" );
        var_ed4d82fcd6d2419f endon( #"disconnect" );
        live_ragdoll_test = get_live_ragdoll_test();
        
        while ( live_ragdoll_test == 1 )
        {
            level waittill( notify_string, var_9ea4bfa8c1fee49b );
            
            if ( var_9ea4bfa8c1fee49b == 1 )
            {
                function_2a6879bef5e645ce( var_ed4d82fcd6d2419f );
                continue;
            }
            
            if ( var_9ea4bfa8c1fee49b == 2 )
            {
                function_a9a12561ac5fe7dd( var_ed4d82fcd6d2419f );
            }
        }
    }

    // Namespace live_ragdoll_test
    // Params 1, eflags: 0x4
    // Checksum 0x8df53005, Offset: 0x7e4
    // Size: 0x13b, Type: dev
    function private function_2a6879bef5e645ce( var_ed4d82fcd6d2419f )
    {
        if ( !player::isreallyalive( var_ed4d82fcd6d2419f ) )
        {
            return;
        }
        
        var_f399c20b9e2593e0 = var_ed4d82fcd6d2419f getplayerangles();
        var_78d7bc0c4fab7aad = 120 * anglestoforward( var_f399c20b9e2593e0 );
        bot_spawn_origin = var_ed4d82fcd6d2419f.origin - var_78d7bc0c4fab7aad + ( 0, 0, 36 );
        bot_spawn_data = { #angles:var_f399c20b9e2593e0, #origin:bot_spawn_origin };
        other_team = team_utility::getotherteam( var_ed4d82fcd6d2419f.team );
        thread bots::spawn_bots( 1, other_team, &function_59d1778d8af1ef96, undefined, undefined, undefined, bot_spawn_data );
        level waittill( #"hash_93c64e61a75a2532", kill_bot );
        var_ed4d82fcd6d2419f.healthregendisabled = 1;
        var_ed4d82fcd6d2419f dodamage( var_ed4d82fcd6d2419f.health, kill_bot.origin, kill_bot, kill_bot, "<dev string:xbe>", undefined, "<dev string:xcf>" );
        var_ed4d82fcd6d2419f.healthregendisabled = 0;
        wait 5;
        level.live_ragdoll_test.misc_bots[ kill_bot getentitynumber() ] = undefined;
        kill_bot bots::bot_drop();
    }

    // Namespace live_ragdoll_test
    // Params 1, eflags: 0x4
    // Checksum 0x3b886a75, Offset: 0x927
    // Size: 0x1d7, Type: dev
    function private function_a9a12561ac5fe7dd( var_ed4d82fcd6d2419f )
    {
        if ( player::isreallyalive( var_ed4d82fcd6d2419f ) )
        {
            return;
        }
        
        var_f399c20b9e2593e0 = var_ed4d82fcd6d2419f getplayerangles();
        var_78d7bc0c4fab7aad = 120 * anglestoforward( var_f399c20b9e2593e0 );
        bot_spawn_origin = var_ed4d82fcd6d2419f.origin - var_78d7bc0c4fab7aad + ( 0, 0, 36 );
        bot_spawn_data = { #angles:var_f399c20b9e2593e0, #origin:bot_spawn_origin };
        thread bots::spawn_bots( 1, var_ed4d82fcd6d2419f.team, &function_59d1778d8af1ef96, undefined, undefined, undefined, bot_spawn_data );
        level waittill( #"hash_93c64e61a75a2532", revive_bot );
        revive_trigger = level.revivetriggers[ var_ed4d82fcd6d2419f.guid ];
        revive_trigger_origin = revive_trigger.origin;
        use_time = 1 + revive_trigger.usetime * 0.001;
        random_position_x = ( utility::cointoss() ? 1 : -1 ) * randomfloatrange( 12, 24 );
        random_position_y = ( utility::cointoss() ? 1 : -1 ) * randomfloatrange( 12, 24 );
        var_a7a7f20db54665a8 = revive_trigger_origin + ( random_position_x, random_position_y, 36 );
        var_7eda9d8950fb5383 = vectornormalize( revive_trigger_origin - var_a7a7f20db54665a8 );
        var_1337e6a455ed9502 = vectortoangles( var_7eda9d8950fb5383 );
        revive_bot setorigin( var_a7a7f20db54665a8 );
        revive_bot setplayerangles( var_1337e6a455ed9502 );
        revive_bot botpressbutton( "<dev string:xdb>", use_time );
        revive_bot bots_util::bot_usebutton_wait( use_time );
        wait 5;
        level.live_ragdoll_test.misc_bots[ revive_bot getentitynumber() ] = undefined;
        revive_bot bots::bot_drop();
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0xbba82fd6, Offset: 0xb06
    // Size: 0xc5, Type: dev
    function private function_6484c8245761fedd()
    {
        thread bot_thread( self, "<dev string:xdf>", ( 1, 0, 0 ) );
        self.ignoreall = 1;
        self botsetflag( "<dev string:xf0>", 1 );
        self botsetflag( "<dev string:xff>", 1 );
        self waittill( #"hash_c4c3867ada721e30" );
        wait 3;
        var_54e459d33138bbd0 = gamelogic_mp::gethostplayer();
        
        if ( self.team == var_54e459d33138bbd0.team )
        {
            level.live_ragdoll_test.friendly_bot = self;
            level notify( #"hash_8112655e0e206551", self );
            return;
        }
        
        level.live_ragdoll_test.var_d9084239cc1ec7f0 = self;
        level notify( #"hash_66a2874f13a8fe98", self );
    }

    // Namespace live_ragdoll_test
    // Params 0, eflags: 0x4
    // Checksum 0x9621327e, Offset: 0xbd3
    // Size: 0xa7, Type: dev
    function private function_59d1778d8af1ef96()
    {
        thread bot_thread( self, "<dev string:x110>", ( 0, 0, 1 ) );
        self.ignoreall = 1;
        self botsetflag( "<dev string:xf0>", 1 );
        self botsetflag( "<dev string:xff>", 1 );
        self waittill( #"hash_c4c3867ada721e30" );
        wait 3;
        
        if ( !isdefined( level.live_ragdoll_test.misc_bots ) )
        {
            level.live_ragdoll_test.misc_bots = [];
        }
        
        level.live_ragdoll_test.misc_bots[ self getentitynumber() ] = self;
        level notify( #"hash_93c64e61a75a2532", self );
    }

    // Namespace live_ragdoll_test
    // Params 3, eflags: 0x4
    // Checksum 0x7441418c, Offset: 0xc82
    // Size: 0x61, Type: dev
    function private bot_thread( bot, text, color )
    {
        level endon( #"game_ended" );
        bot endon( #"disconnect" );
        
        while ( true )
        {
            print3d( bot.origin, text, color, 1, 0.2, 1, 1 );
            waitframe();
        }
    }

#/
