// script_cdbbc61db6e8ab4  (hash_0cdbbc61db6e8ab4.gscc) (size: 17900 Bytes / 0x45ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbd8193b (4225243451)
// size ...... 17900 (0x45ec)
// includes .. 3   (offset: 0x4054)
// strings ... 27  (offset: 0x406c)
// dev strs .. 66  (offset: 0x42c4)
// exports ... 33  (offset: 0x3018)
// cseg ...... 0x378 + 0x2ca0 (0x3018)
// imports ... 69  (offset: 0x3540)
// animtree1 . 0   (offset: 0x45ec)
// animtree2 . 0   (offset: 0x45ec)
#using script_5cb6af9395d116c0;
#using scripts\common\devgui;
#using scripts\common\scene;

#namespace scorpio_debug;

// Namespace scorpio_debug
// Params 0
// Checksum 0xf2f9d5dd, Offset: 0x396
// Size: 0x203
function function_b94262a07ef51ab8()
{
    while ( !getdvarint( @"hash_26c0d3d10c872389", 0 ) )
    {
        waitframe();
    }
    
    /#
        devgui::init_devgui();
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x4a>", &scorpio::function_96429c231e4af458 );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x65>", &scorpio::function_2737405cf9fb2a23 );
        devgui::add_devgui_func( "<dev string:x71>", "<dev string:x8a>", &scorpio::function_731dc0dcbf1e744b );
        devgui::add_devgui_func( "<dev string:x99>", "<dev string:xb1>", &scorpio::function_876f13f543032ce2 );
        devgui::add_devgui_func( "<dev string:xc9>", "<dev string:xe4>", &function_bad9ca06ab1bbf18 );
        devgui::add_devgui_func( "<dev string:xfa>", "<dev string:x116>", &function_877b9a525be4f8c3 );
        devgui::add_devgui_func( "<dev string:x12d>", "<dev string:x14e>", &scorpio::function_3cffc07b3e2ef150 );
        devgui::add_devgui_func( "<dev string:x160>", "<dev string:x181>", &scorpio::function_3cffc37b3e2ef7e9 );
        devgui::add_devgui_func( "<dev string:x193>", "<dev string:x1bc>", &function_86b065ddc41477ff );
        devgui::add_devgui_func( "<dev string:x1dc>", "<dev string:x20a>", &function_defa9221adee47bf );
        devgui::add_devgui_func( "<dev string:x22f>", "<dev string:x257>", &function_f6281c6ec454b067 );
        devgui::add_devgui_func( "<dev string:x276>", "<dev string:x297>", &function_722fd098b491c49d );
        devgui::add_devgui_func( "<dev string:x2ae>", "<dev string:x2d7>", &function_b361c7c0e2de6622 );
        devgui::add_devgui_func( "<dev string:x2f7>", "<dev string:x325>", &function_5dabe06be5e8b9f4 );
        devgui::add_devgui_func( "<dev string:x34a>", "<dev string:x372>", &function_5e76a60f29269348 );
        devgui::add_devgui_func( "<dev string:x391>", "<dev string:x3b2>", &function_e028e9fd487fa71a );
        devgui::add_devgui_func( "<dev string:x3c9>", "<dev string:x3f4>", &function_8a1e271a991d0f69 );
        devgui::add_devgui_func( "<dev string:x404>", "<dev string:x42f>", &function_8a1e241a991d08d0 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x43f>", @"hash_50005837457e510e", 0 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x45e>", @"hash_2c00fccac61f2089", 0 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x47c>", @"hash_ba90189bd75b136c", 0 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x2fbb9eb7, Offset: 0x5a1
// Size: 0x12
function function_8a1e271a991d0f69()
{
    setdvar( @"hash_2c79bf8106ddb5da", 1 );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0xb6b2cf0e, Offset: 0x5bb
// Size: 0x12
function function_8a1e241a991d08d0()
{
    setdvar( @"hash_2c79bf8106ddb5da", 2 );
}

/#

    // Namespace scorpio_debug
    // Params 0
    // Checksum 0xe1dac6e9, Offset: 0x5d5
    // Size: 0xed, Type: dev
    function function_7726dd451bb42ab0()
    {
        sphere( level.players[ 0 ].origin, 60, ( 1, 0, 0 ), 0, 200 );
        print3d( level.players[ 0 ].origin - ( -5000, 0, 0 ), level.players[ 0 ].origin - level.scorpio_skel.origin, ( 1, 0, 0 ), 1, 10, 1000 );
        print3d( level.players[ 0 ].origin - ( -5000, 0, 300 ), level.players[ 0 ].angles, ( 0, 1, 0 ), 1, 10, 1000 );
    }

    // Namespace scorpio_debug
    // Params 0
    // Checksum 0xd5d32846, Offset: 0x6ca
    // Size: 0x5, Type: dev
    function function_ed8278e7a9ab6de8()
    {
        
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0xb83d1265, Offset: 0x6d7
    // Size: 0xf, Type: dev
    function private function_a8e005f7d464e614()
    {
        return level.scorpio_skel;
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0xec6f5fb5, Offset: 0x6ee
    // Size: 0x2f, Type: dev
    function private function_31866b883f387497()
    {
        return level.scorpio_animnode.scenedata.sceneobjectdata[ 0 ].activeanimation;
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0xd3e19ec1, Offset: 0x725
    // Size: 0x18, Type: dev
    function private function_e7351743ac10d961()
    {
        return getdvarfloat( @"hash_b3516b8c376d659e", 1 );
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0x899aff4d, Offset: 0x745
    // Size: 0x24, Type: dev
    function private function_bad9ca06ab1bbf18()
    {
        function_9a6e91083c23482e( &function_a8e005f7d464e614, &function_31866b883f387497, &function_e7351743ac10d961, @"hash_81f9f0d08f84eca1" );
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0x95d2828f, Offset: 0x771
    // Size: 0x30, Type: dev
    function private function_c89c43ec97e1f2ea()
    {
        if ( !isdefined( level.scrub_controls ) )
        {
            level.scrub_controls = {};
        }
        
        level.scrub_controls.print_count = 0;
    }

    // Namespace scorpio_debug
    // Params 1, eflags: 0x4
    // Checksum 0x2843f11f, Offset: 0x7a9
    // Size: 0xa8, Type: dev
    function private function_a9c1034b3239d2ea( text )
    {
        if ( !isdefined( level.scrub_controls ) )
        {
            level.scrub_controls = {};
        }
        
        if ( !isdefined( level.scrub_controls.print_count ) )
        {
            level.scrub_controls.print_count = 0;
        }
        
        level.scrub_controls.print_count++;
        y_pos = 30 + level.scrub_controls.print_count * 18;
        printtoscreen2d( 400, y_pos, text, ( 0.75, 0.75, 0.75 ), 1.2, 2 );
    }

    // Namespace scorpio_debug
    // Params 1, eflags: 0x4
    // Checksum 0x8f6b7345, Offset: 0x859
    // Size: 0x4a, Type: dev
    function private function_23d248847e44dce6( text )
    {
        if ( level.scrub_controls.disable_print_dvar )
        {
            if ( getdvarint( level.scrub_controls.disable_print_dvar, 0 ) )
            {
                return;
            }
        }
        
        function_a9c1034b3239d2ea( text );
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0x372d547a, Offset: 0x8ab
    // Size: 0xec, Type: dev
    function private function_c12ca1e336ff70c4()
    {
        rig = level.scrub_controls.rig;
        xanim = level.scrub_controls.xanim;
        var_74bc5db43a9207cf = level.scrub_controls.rate;
        timefrac = rig getanimtime( xanim );
        durationseconds = getanimlength( xanim );
        timeseconds = durationseconds * timefrac;
        timefrac = round( timefrac, 0.01 );
        durationseconds = round( durationseconds, 0.1 );
        timeseconds = round( timeseconds, 0.1 );
        function_23d248847e44dce6( "<dev string:x49a>" + getxhashsourcename( getanimname( xanim ) ) );
        function_23d248847e44dce6( "<dev string:x4a1>" + timefrac + "<dev string:x4ad>" + timeseconds + "<dev string:x4bb>" + durationseconds );
    }

    // Namespace scorpio_debug
    // Params 1
    // Checksum 0x1edf7671, Offset: 0x99f
    // Size: 0x58, Type: dev
    function function_8d8e52699754b9c7( rig )
    {
        if ( level.scrub_controls.rig == rig )
        {
            if ( level.scrub_controls.var_22f6e4262efc002d || level.scrub_controls.var_5c189a8b6d1ddd50 )
            {
                return 1;
            }
        }
    }

    // Namespace scorpio_debug
    // Params 4, eflags: 0x4
    // Checksum 0xb1f2817, Offset: 0x9ff
    // Size: 0x5d, Type: dev
    function private function_da7f330033834065( get_rig_func, get_xanim_func, get_animrate_func, disable_print_dvar )
    {
        if ( !isdefined( disable_print_dvar ) )
        {
            disable_print_dvar = undefined;
        }
        
        if ( level.scrub_controls.enabled )
        {
            function_877b9a525be4f8c3();
            return;
        }
        
        function_9a6e91083c23482e( get_rig_func, get_xanim_func, get_animrate_func, disable_print_dvar );
    }

    // Namespace scorpio_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2027ef16, Offset: 0xa64
    // Size: 0x3a, Type: dev
    function private function_877b9a525be4f8c3()
    {
        level notify( #"hash_c77d7fd9a519a76c" );
        level.scrub_controls.enabled = 0;
        level.scrub_controls = undefined;
        iprintln( "<dev string:x4bf>" );
    }

    // Namespace scorpio_debug
    // Params 4, eflags: 0x4
    // Checksum 0xf09bd7c3, Offset: 0xaa6
    // Size: 0x567, Type: dev
    function private function_9a6e91083c23482e( get_rig_func, get_xanim_func, get_animrate_func, disable_print_dvar )
    {
        if ( !isdefined( disable_print_dvar ) )
        {
            disable_print_dvar = undefined;
        }
        
        level endon( #"hash_c77d7fd9a519a76c" );
        assert( isfunction( get_rig_func ) );
        
        if ( !isfunction( get_rig_func ) )
        {
            return;
        }
        
        assert( isfunction( get_xanim_func ) );
        
        if ( !isfunction( get_xanim_func ) )
        {
            return;
        }
        
        assert( isfunction( get_animrate_func ) );
        
        if ( !isfunction( get_animrate_func ) )
        {
            return;
        }
        
        iprintln( "<dev string:x4d7>" );
        
        if ( !isdefined( level.scrub_controls ) )
        {
            level.scrub_controls = {};
        }
        
        scrub_controls = level.scrub_controls;
        scrub_controls.enabled = 1;
        scrub_controls.rig = undefined;
        scrub_controls.xanim = undefined;
        scrub_controls.var_22f6e4262efc002d = 0;
        scrub_controls.var_5c189a8b6d1ddd50 = 0;
        scrub_controls.rate = 4;
        scrub_controls.disable_print_dvar = disable_print_dvar;
        scrub_controls.pauseheld = 0;
        scrub_controls.var_1161c85c7efe0000 = 0;
        function_c89c43ec97e1f2ea();
        player = level.players[ 0 ];
        scrub_controls.rig = [[ get_rig_func ]]();
        
        while ( !isent( level.scrub_controls.rig ) )
        {
            function_c89c43ec97e1f2ea();
            function_23d248847e44dce6( "<dev string:x4ee>" );
            level.scrub_controls.rig = [[ get_rig_func ]]();
            waitframe();
        }
        
        while ( scrub_controls.enabled )
        {
            scrub_controls.xanim = [[ get_xanim_func ]]();
            
            while ( scrub_controls.enabled && !isanimation( scrub_controls.xanim ) )
            {
                function_c89c43ec97e1f2ea();
                function_23d248847e44dce6( "<dev string:x517>" );
                scrub_controls.xanim = [[ get_xanim_func ]]();
                waitframe();
            }
            
            var_3b6022bfddd285c2 = player buttonpressed( "<dev string:x542>" );
            var_ec4051f4fea9333c = player buttonpressed( "<dev string:x54d>" );
            scrub_controls.var_5c189a8b6d1ddd50 = var_3b6022bfddd285c2 || var_ec4051f4fea9333c;
            var_868d2356440bf8c9 = scrub_controls.pauseheld;
            scrub_controls.pauseheld = player buttonpressed( "<dev string:x557>" );
            pausetoggled = scrub_controls.pauseheld && !var_868d2356440bf8c9;
            var_49fa5fbc35916f2 = scrub_controls.var_1161c85c7efe0000;
            scrub_controls.var_1161c85c7efe0000 = player buttonpressed( "<dev string:x561>" );
            var_eb4eb742758b725 = scrub_controls.var_1161c85c7efe0000 && !var_49fa5fbc35916f2;
            
            if ( pausetoggled )
            {
                scrub_controls.var_22f6e4262efc002d = !scrub_controls.var_22f6e4262efc002d;
            }
            
            if ( var_eb4eb742758b725 )
            {
                scrub_controls.rate *= 2;
                
                if ( scrub_controls.rate > 32 )
                {
                    scrub_controls.rate = 4;
                }
            }
            
            function_c89c43ec97e1f2ea();
            function_23d248847e44dce6( "<dev string:x569>" );
            function_23d248847e44dce6( "<dev string:x596>" + "<dev string:x542>" + "<dev string:x5a1>" + "<dev string:x54d>" + "<dev string:x5a9>" );
            function_23d248847e44dce6( "<dev string:x561>" + "<dev string:x5b2>" + "<dev string:x557>" + "<dev string:x5c7>" );
            function_23d248847e44dce6( "<dev string:x5d6>" + scrub_controls.rate );
            walkanimrate = [[ get_animrate_func ]]();
            
            if ( !isnumber( walkanimrate ) )
            {
                assertmsg( "<dev string:x5e3>" );
                function_877b9a525be4f8c3();
                return;
            }
            
            var_708d2a1c35682c72 = walkanimrate * scrub_controls.rate;
            
            if ( var_3b6022bfddd285c2 )
            {
                scrub_controls.rig setanimrate( scrub_controls.xanim, var_708d2a1c35682c72 );
                function_23d248847e44dce6( "<dev string:x61e>" + var_708d2a1c35682c72 );
            }
            else if ( var_ec4051f4fea9333c )
            {
                timefrac = scrub_controls.rig getanimtime( scrub_controls.xanim );
                durationseconds = getanimlength( scrub_controls.xanim );
                timeseconds = durationseconds * timefrac;
                var_667e89509092e206 = var_708d2a1c35682c72 * level.framedurationseconds;
                var_ca4e9d9fb81940e = max( 0, timeseconds - var_667e89509092e206 );
                var_a40257ac49acaaad = var_ca4e9d9fb81940e / durationseconds;
                scrub_controls.rig setanimrate( scrub_controls.xanim, 0 );
                scrub_controls.rig setanimtime( scrub_controls.xanim, var_a40257ac49acaaad );
                function_23d248847e44dce6( "<dev string:x63c>" + var_708d2a1c35682c72 * -1 );
            }
            else if ( scrub_controls.var_22f6e4262efc002d )
            {
                scrub_controls.rig setanimrate( scrub_controls.xanim, 0 );
                function_23d248847e44dce6( "<dev string:x654>" );
            }
            else
            {
                scrub_controls.rig setanimrate( scrub_controls.xanim, walkanimrate );
                function_23d248847e44dce6( "<dev string:x66a>" + walkanimrate );
            }
            
            function_c12ca1e336ff70c4();
            waitframe();
        }
    }

    // Namespace scorpio_debug
    // Params 0
    // Checksum 0x5c0c18aa, Offset: 0x1015
    // Size: 0x5, Type: dev
    function function_370aece3766eb77()
    {
        
    }

#/

// Namespace scorpio_debug
// Params 0
// Checksum 0x55cc5182, Offset: 0x1022
// Size: 0x2bf
function function_86b065ddc41477ff()
{
    self notify( #"hash_6188eee1c273bf5b" );
    self endon( #"hash_6188eee1c273bf5b" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path01" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 55, 56 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 57 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x9844599a, Offset: 0x12e9
// Size: 0x35b
function function_defa9221adee47bf()
{
    self notify( #"hash_16671835745694d7" );
    self endon( #"hash_16671835745694d7" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path01" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path01_a_head_launch_end_xcam", 0, level.scorpio_animnode.origin, level.scorpio_animnode.angles );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path01_b_head_launch_end_xcam", 0, ( -1390.93, -29410.9, 4628.5 ), ( 0, 0, 0 ) );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 55, 56 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path01_c_head_launch_end_xcam", 0, ( 9409.88, -42439.6, 5890.95 ), ( 0, 0, 0 ) );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 57 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x686ed66f, Offset: 0x164c
// Size: 0x4b6
function function_f6281c6ec454b067()
{
    self notify( #"hash_61842e92afb81613" );
    self endon( #"hash_61842e92afb81613" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path01" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_loop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_attack_beam", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_b", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"scorpio_stomp_a" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 12, 13 ] );
        wait 10.133;
        wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
        level.scorpio_skel notify( #"scorpio_laser_a" );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 14 ] );
        level.scorpio_skel notify( #"scorpio_attack_beam" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 15, 16 ] );
        wait 11.3333;
        level.scorpio_skel thread scorpio::function_232cdd9c622061e4();
        wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 17 ] );
        level.scorpio_skel notify( #"scorpio_stomp_b" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 32, 33 ] );
        wait 10.133;
        wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
        level.scorpio_skel notify( #"scorpio_laser_b" );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 34 ] );
        level.scorpio_skel notify( #"scorpio_attack_beam" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 35, 36 ] );
        wait 11.3447;
        level.scorpio_skel thread scorpio::function_232cdd9c622061e4();
        wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 37 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x88d6cd4e, Offset: 0x1b0a
// Size: 0x1ee
function function_722fd098b491c49d()
{
    self notify( #"hash_fcc35f6aa0894049" );
    self endon( #"hash_fcc35f6aa0894049" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path01" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_path_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 58 ] );
        level.scorpio_skel waittill( #"scorpio_exit_finish" );
        level thread scorpio::scorpio_hide();
        
        if ( !getdvarint( @"hash_26c0d3d10c872389", 0 ) )
        {
            scorpio::function_96429c231e4af458();
            return;
        }
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0xec0adcac, Offset: 0x1d00
// Size: 0x2bf
function function_b361c7c0e2de6622()
{
    self notify( #"hash_b92109c3d286f1c5" );
    self endon( #"hash_b92109c3d286f1c5" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path02" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 52, 53 ] );
        wait 6.6;
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 54 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x167d64e, Offset: 0x1fc7
// Size: 0x35b
function function_5dabe06be5e8b9f4()
{
    self notify( #"hash_7cb4559fd430f5db" );
    self endon( #"hash_7cb4559fd430f5db" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path02" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_headlaunch", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 18, 19 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path02_a_head_launch_end_xcam", 0, level.scorpio_animnode.origin, level.scorpio_animnode.angles );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 20 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 38, 39 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path02_b_head_launch_end_xcam", 0, ( 31823, 16593.3, 5329.44 ), ( 0, 0, 0 ) );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 40 ] );
        level.scorpio_skel notify( #"hash_3e560b195993856e" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 52, 53 ] );
        wait 6.6;
        level.players[ 0 ] playxcam( "sat_wc_cin_scorpio_path02_c_head_launch_end_xcam", 0, ( 16760, 17241.7, 4531.61 ), ( 0, 0, 0 ) );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 54 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x3782aadf, Offset: 0x232a
// Size: 0x4b6
function function_5e76a60f29269348()
{
    self notify( #"hash_5b974bec5222d8c4" );
    self endon( #"hash_5b974bec5222d8c4" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path02" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_loop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_stop", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_attack_beam", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_stomp_b", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_a", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_laser_b", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_skel notify( #"scorpio_stomp_a" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 12, 13 ] );
        wait 10.133;
        wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
        level.scorpio_skel notify( #"scorpio_laser_a" );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 14 ] );
        level.scorpio_skel notify( #"scorpio_attack_beam" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 15, 16 ] );
        wait 11.3333;
        level.scorpio_skel thread scorpio::function_232cdd9c622061e4();
        wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 17 ] );
        level.scorpio_skel notify( #"scorpio_stomp_b" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 32, 33 ] );
        wait 10.133;
        wait getdvarfloat( @"hash_e13b1ba78c68a912", 0 );
        level.scorpio_skel notify( #"scorpio_laser_b" );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 34 ] );
        level.scorpio_skel notify( #"scorpio_attack_beam" );
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 35, 36 ] );
        wait 11.3447;
        level.scorpio_skel thread scorpio::function_232cdd9c622061e4();
        wait getdvarfloat( @"hash_f4cd847bec922ddc", 0 );
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 37 ] );
        level thread scorpio::scorpio_hide();
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x974bee57, Offset: 0x27e8
// Size: 0x1ee
function function_e028e9fd487fa71a()
{
    self notify( #"hash_c9673f82d77446" );
    self endon( #"hash_c9673f82d77446" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_scorpio_path02" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_path_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_exit_finish", "scorpio", 1 );
    
    do
    {
        level thread scorpio::scorpio_show();
        level.scorpio_animnode thread scene::play( level.scorpio_skel, [ 55 ] );
        level.scorpio_skel waittill( #"scorpio_exit_finish" );
        level thread scorpio::scorpio_hide();
        
        if ( !getdvarint( @"hash_26c0d3d10c872389", 0 ) )
        {
            scorpio::function_96429c231e4af458();
            return;
        }
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x447efea9, Offset: 0x29de
// Size: 0x170
function function_14621e4ec6cb5265()
{
    self notify( #"hash_b47f4e498c97abea" );
    self endon( #"hash_b47f4e498c97abea" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.origin = ( 0, 0, 0 );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_cin_scorpio" );
    
    foreach ( var_4a1ad098d589a970 in level.var_56174d118d349e38 )
    {
        level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, var_4a1ad098d589a970, "scorpio", 1 );
    }
    
    do
    {
        level.scorpio_animnode scene::play( level.scorpio_skel, [ 0, 1 ] );
        wait 0.1;
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x44490114, Offset: 0x2b56
// Size: 0xed
function function_8f5a1c9bad508d46()
{
    self notify( #"hash_9f91f4fd384a1a02" );
    self endon( #"hash_9f91f4fd384a1a02" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode.origin = level.scorpio_skel.origin ?? ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_cin_scorpio" );
    
    do
    {
        level.scorpio_animnode scene::play( level.scorpio_skel, "exit" );
        wait 0.1;
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x65d6ce3, Offset: 0x2c4b
// Size: 0x113
function function_5e5184ddbcce0ccd()
{
    self notify( #"hash_aac967d9156a7e59" );
    self endon( #"hash_aac967d9156a7e59" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode.origin = level.scorpio_skel.origin ?? ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "sat_wc_cin_scorpio_head_launch_modular" );
    
    do
    {
        level.scorpio_animnode thread scene::play( level.scorpio_skel );
        wait getdvarfloat( @"hash_eed18867766a125f", 3.3 );
        level.scorpio_animnode scene::play( level.scorpio_skel, "end" );
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0xc2453a74, Offset: 0x2d66
// Size: 0x15d
function function_9692ea19a4ca0369()
{
    self notify( #"hash_437f20ded5cea006" );
    self endon( #"hash_437f20ded5cea006" );
    
    if ( !isdefined( level.scorpio_skel ) )
    {
        return;
    }
    
    if ( !isdefined( level.scorpio_ents ) )
    {
        return;
    }
    
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode.origin = level.scorpio_skel.origin ?? ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_cin_scorpio_attack_laser" );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_start", "scorpio", 1 );
    level.scorpio_animnode scene::set_notify_note( level.scorpio_skel, "scorpio_beam_stop", "scorpio", 1 );
    
    do
    {
        level.scorpio_animnode thread scene::play( level.scorpio_skel );
        wait getdvarfloat( @"hash_f4cd847bec922ddc", 1 );
        level.scorpio_animnode scene::play( level.scorpio_skel, "end" );
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x53dc4e65, Offset: 0x2ecb
// Size: 0xf5
function function_a0b760b73e1c156f()
{
    self notify( #"hash_195921606efcd19b" );
    self endon( #"hash_195921606efcd19b" );
    scorpio::function_731dc0dcbf1e744b();
    level endon( #"scorpio_scene_stopped" );
    level.scorpio_animnode.angles = ( 0, 0, 0 );
    level.scorpio_animnode.origin = level.scorpio_skel.origin ?? ( 0, 0, 0 );
    level.scorpio_animnode scene::set_scriptbundle( "scene_sat_wc_cin_scorpio_attack_stomp" );
    
    do
    {
        level.scorpio_animnode thread scene::play( level.scorpio_skel );
        wait getdvarfloat( @"hash_e13b1ba78c68a912", 1 );
        level.scorpio_animnode scene::play( level.scorpio_skel, "end" );
    }
    while ( getdvarint( @"hash_fb3081b870a26896", 0 ) );
}

// Namespace scorpio_debug
// Params 0
// Checksum 0x3361fc34, Offset: 0x2fc8
// Size: 0x50
function function_f0624e90144541c2()
{
    if ( !getdvarint( @"hash_fb3081b870a26896", 0 ) )
    {
        /#
            iprintlnbold( "<dev string:x680>" );
        #/
        
        setdvar( @"hash_fb3081b870a26896", 1 );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x696>" );
    #/
    
    setdvar( @"hash_fb3081b870a26896", 0 );
}

