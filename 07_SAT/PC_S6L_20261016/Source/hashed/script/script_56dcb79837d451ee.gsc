// script_56dcb79837d451ee  (hash_56dcb79837d451ee.gscc) (size: 19196 Bytes / 0x4afc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc73b79fa (3342563834)
// size ...... 19196 (0x4afc)
// includes .. 3   (offset: 0x46b4)
// strings ... 0   (offset: 0x46cc)
// dev strs .. 72  (offset: 0x46cc)
// exports ... 38  (offset: 0x33ec)
// cseg ...... 0x58 + 0x3394 (0x33ec)
// imports ... 97  (offset: 0x39dc)
// animtree1 . 0   (offset: 0x4afc)
// animtree2 . 0   (offset: 0x4afc)
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_73de116fe4733020;

/#

    // Namespace namespace_73de116fe4733020
    // Params 0, eflags: 0x1
    // Checksum 0x833208c7, Offset: 0x76
    // Size: 0x10, Type: dev
    function autoexec main()
    {
        /#
            level thread function_25e74982bad276b2();
        #/
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x9ddf239, Offset: 0x8e
    // Size: 0x203, Type: dev
    function function_25e74982bad276b2()
    {
        while ( !isdefined( level.struct_class_names ) )
        {
            wait 1;
        }
        
        level.var_e3a25508acccec8a = utility::getstructarray( "<dev string:x24>", "<dev string:x39>" );
        
        if ( !level.var_e3a25508acccec8a.size )
        {
            level.var_e3a25508acccec8a = undefined;
            return;
        }
        
        level.var_7ec6b946ce125825 = 0;
        level.var_4fdd3d1133b558be = 0;
        level.var_142478e638411141 = 1;
        level.var_9f7cbda10cd8473a = 1;
        
        foreach ( var_9bc762b6a9670a91 in level.var_e3a25508acccec8a )
        {
            assert( isdefined( var_9bc762b6a9670a91.script_string ), "<dev string:x4b>" );
            var_9bc762b6a9670a91.s_bundle = getscriptbundle( "<dev string:x94>" + var_9bc762b6a9670a91.script_string );
            var_9bc762b6a9670a91.var_6358c7810e05e32 = 0;
            thread spawn_asset( var_9bc762b6a9670a91 );
        }
        
        a_s_temp = [];
        
        foreach ( n_index, s_instance in level.var_e3a25508acccec8a )
        {
            if ( !isdefined( s_instance.targetname ) )
            {
                s_instance.targetname = "<dev string:xa6>" + n_index;
            }
            
            a_s_temp[ s_instance.targetname ] = s_instance;
        }
        
        level.var_e3a25508acccec8a = a_s_temp;
        level thread function_c3feee0121413687();
        level thread function_1681c7d2d54cca80();
        level thread function_a03bb59318abadcd();
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x97df945b, Offset: 0x299
    // Size: 0x129, Type: dev
    function function_c3feee0121413687()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        wait 0.25;
        setdvarifuninitialized( @"hash_40ad028737193fbc", 1 );
        setdvarifuninitialized( @"hash_af2088374ac3b8ad", 1 );
        adddebugcommand( "<dev string:xbb>" );
        adddebugcommand( "<dev string:x112>" );
        waitframe();
        
        foreach ( str_instance_name, s_instance in level.var_e3a25508acccec8a )
        {
            adddebugcommand( "<dev string:x171>" + str_instance_name + "<dev string:x1a7>" + str_instance_name + "<dev string:x1d1>" );
            adddebugcommand( "<dev string:x1d4>" + str_instance_name + "<dev string:x20d>" + str_instance_name + "<dev string:x1d1>" );
            adddebugcommand( "<dev string:x23a>" + str_instance_name + "<dev string:x279>" + str_instance_name + "<dev string:x1d1>" );
            waitframe();
        }
        
        adddebugcommand( "<dev string:x2a3>" );
        level thread function_c6bec6f386ddca52();
    }

    // Namespace namespace_73de116fe4733020
    // Params 0, eflags: 0x4
    // Checksum 0x9029524, Offset: 0x3ca
    // Size: 0x151, Type: dev
    function private function_c6bec6f386ddca52()
    {
        level notify( #"hash_f640e19217618ac8" );
        level endon( #"hash_f640e19217618ac8" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            level.var_7ec6b946ce125825 = getdvarint( @"hash_af2088374ac3b8ad", 0 );
            level.var_4fdd3d1133b558be = getdvarint( @"hash_40ad028737193fbc", 0 );
            var_ee2abe2b69dc301a = getdvarint( @"hash_6a97927c7fa376a", 0 );
            str_spawn_camera = getdvar( @"hash_aa480c2109cbaaec" );
            str_spawn_crosshair = getdvar( @"hash_419027c07c5cac85" );
            str_spawn_source = getdvar( @"hash_28c1468f736008a6" );
            
            if ( var_ee2abe2b69dc301a != 0 )
            {
                function_beee767444cd9d72();
            }
            
            if ( str_spawn_camera != "<dev string:x300>" )
            {
                thread function_c8f31b58abe2cbf( str_spawn_camera );
            }
            
            if ( str_spawn_crosshair != "<dev string:x300>" )
            {
                function_d174e50fc33577e8( str_spawn_crosshair );
            }
            
            if ( str_spawn_source != "<dev string:x300>" )
            {
                function_b97063b5b36ddbc1( str_spawn_source );
            }
            
            setdvar( @"hash_aa480c2109cbaaec", "<dev string:x300>" );
            setdvar( @"hash_419027c07c5cac85", "<dev string:x300>" );
            setdvar( @"hash_28c1468f736008a6", "<dev string:x300>" );
            setdvar( @"hash_6a97927c7fa376a", 0 );
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x1ecf2840, Offset: 0x523
    // Size: 0x172, Type: dev
    function function_beee767444cd9d72()
    {
        foreach ( s_instance in level.var_e3a25508acccec8a )
        {
            if ( isdefined( s_instance.e_current_asset ) )
            {
                if ( isdefined( s_instance.e_current_asset.var_a59619ff66db1cd2 ) )
                {
                    foreach ( var_4d07d9e5a03d5195 in s_instance.e_current_asset.var_a59619ff66db1cd2 )
                    {
                        if ( isdefined( var_4d07d9e5a03d5195 ) )
                        {
                            var_4d07d9e5a03d5195 delete();
                        }
                    }
                }
                
                s_instance.e_current_asset delete();
            }
            
            if ( isdefined( s_instance.e_rotator ) )
            {
                s_instance.e_rotator delete();
            }
            
            if ( isdefined( s_instance.var_a190e8a030eedd0f ) )
            {
                s_instance.var_a190e8a030eedd0f delete();
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x78233d2, Offset: 0x69d
    // Size: 0x15b, Type: dev
    function function_c8f31b58abe2cbf( str_instance )
    {
        if ( str_instance == "<dev string:x300>" )
        {
            return;
        }
        
        s_instance = level.var_e3a25508acccec8a[ str_instance ];
        function_700f2ecb08ccc4e1( s_instance );
        var_c8572d255c28dc2f = 200;
        host = level.player;
        v_forward = anglestoforward( host getplayerangles() );
        v_forward *= var_c8572d255c28dc2f;
        v_player_origin = host getorigin();
        v_origin = v_player_origin + v_forward;
        
        if ( isdefined( s_instance.var_a190e8a030eedd0f ) )
        {
            s_instance.var_a190e8a030eedd0f delete();
        }
        
        s_instance.var_a190e8a030eedd0f = spawn( "<dev string:x301>", v_origin );
        s_instance.var_a190e8a030eedd0f.var_fd1725d5f1b6482 = 1;
        s_instance.e_rotator unlink();
        s_instance.e_rotator.origin = s_instance.var_a190e8a030eedd0f.origin;
        s_instance.e_rotator linkto( s_instance.var_a190e8a030eedd0f );
        s_instance.var_a190e8a030eedd0f linkto( host );
        s_instance.var_a190e8a030eedd0f thread function_a3cc85511aa0830e();
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x2c6d1224, Offset: 0x800
    // Size: 0xcf, Type: dev
    function function_a3cc85511aa0830e()
    {
        host = level.player;
        host endon( #"death" );
        self endon( #"death" );
        
        while ( true )
        {
            v_left_stick = host getnormalizedmovement();
            v_right_stick = ( 0, 0, 0 );
            
            if ( level.var_7ec6b946ce125825 && host adsbuttonpressed() && v_left_stick != ( 0, 0, 0 ) )
            {
                self unlink();
                self.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + v_left_stick[ 0 ] * 3 );
                self linkto( host );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x1838f2c7, Offset: 0x8d7
    // Size: 0xf8, Type: dev
    function function_d174e50fc33577e8( str_instance )
    {
        if ( str_instance == "<dev string:x300>" )
        {
            return;
        }
        
        s_instance = level.var_e3a25508acccec8a[ str_instance ];
        function_700f2ecb08ccc4e1( s_instance );
        host = level.player;
        v_forward = anglestoforward( host getplayerangles() );
        v_forward *= 4000;
        v_eye = host geteye();
        v_origin = physicstrace( v_eye, v_eye + v_forward );
        
        if ( isdefined( s_instance.var_a190e8a030eedd0f ) )
        {
            s_instance.var_a190e8a030eedd0f delete();
        }
        
        s_instance.var_a190e8a030eedd0f = spawn( "<dev string:x301>", v_origin );
        s_instance.e_rotator.origin = v_origin;
        s_instance.e_rotator linkto( s_instance.var_a190e8a030eedd0f );
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x60b26215, Offset: 0x9d7
    // Size: 0x7c, Type: dev
    function function_b97063b5b36ddbc1( str_instance )
    {
        if ( str_instance == "<dev string:x300>" )
        {
            return;
        }
        
        s_instance = level.var_e3a25508acccec8a[ str_instance ];
        function_700f2ecb08ccc4e1( s_instance );
        
        if ( isdefined( s_instance.var_a190e8a030eedd0f ) )
        {
            s_instance.var_a190e8a030eedd0f delete();
        }
        
        s_instance.e_rotator.origin = s_instance.origin;
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0xf725cd65, Offset: 0xa5b
    // Size: 0x413, Type: dev
    function function_1681c7d2d54cca80()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        wait 0.5;
        host = level.player;
        host endon( #"disconnect" );
        level thread function_f568aae89de3a25b();
        
        while ( true )
        {
            if ( !level.var_7ec6b946ce125825 )
            {
                host val::reset_all( "<dev string:x30e>" );
                waitframe();
                continue;
            }
            
            host val::set( "<dev string:x30e>", "<dev string:x31e>", 0 );
            
            if ( host fragbuttonpressed() )
            {
                b_anim_controls = 1;
                b_alt_controls = 0;
                host val::set( "<dev string:x30e>", "<dev string:x32e>", 0 );
            }
            else if ( host adsbuttonpressed() )
            {
                b_alt_controls = 1;
                b_anim_controls = 0;
                host val::reset( "<dev string:x30e>", "<dev string:x32e>" );
            }
            else
            {
                b_alt_controls = 0;
                b_anim_controls = 0;
                host val::reset( "<dev string:x30e>", "<dev string:x32e>" );
            }
            
            if ( ( host buttonpressed( "<dev string:x339>" ) || host buttonpressed( "<dev string:x341>" ) ) && !host sprintbuttonpressed() )
            {
                if ( b_anim_controls )
                {
                    host function_f9a1904ad3a280b6( "<dev string:x349>" );
                }
                else if ( b_alt_controls )
                {
                    function_aacb5ad7dd21217e();
                }
                else
                {
                    function_a95a58012faa6423();
                }
                
                while ( host buttonpressed( "<dev string:x339>" ) || host buttonpressed( "<dev string:x341>" ) )
                {
                    if ( b_alt_controls )
                    {
                        function_6ee12621094b1ede();
                    }
                    
                    waitframe();
                }
            }
            
            if ( ( host buttonpressed( "<dev string:x34e>" ) || host buttonpressed( "<dev string:x358>" ) ) && !host sprintbuttonpressed() )
            {
                if ( b_anim_controls )
                {
                    host function_f9a1904ad3a280b6( "<dev string:x362>" );
                }
                else if ( b_alt_controls )
                {
                }
                else
                {
                    host cycle_model( "<dev string:x362>" );
                }
                
                while ( host buttonpressed( "<dev string:x34e>" ) || host buttonpressed( "<dev string:x358>" ) )
                {
                    waitframe();
                }
            }
            
            if ( ( host buttonpressed( "<dev string:x367>" ) || host buttonpressed( "<dev string:x372>" ) ) && !host sprintbuttonpressed() )
            {
                if ( b_anim_controls )
                {
                    host function_f9a1904ad3a280b6( "<dev string:x37d>" );
                }
                else if ( b_alt_controls )
                {
                    if ( utility::flag( "<dev string:x383>" ) )
                    {
                        utility::flag_clear( "<dev string:x383>" );
                    }
                    else
                    {
                        utility::flag_set( "<dev string:x383>" );
                    }
                }
                else
                {
                    host cycle_model( "<dev string:x37d>" );
                }
                
                while ( host buttonpressed( "<dev string:x367>" ) || host buttonpressed( "<dev string:x372>" ) )
                {
                    waitframe();
                }
            }
            
            if ( ( host buttonpressed( "<dev string:x3a1>" ) || host buttonpressed( "<dev string:x3ab>" ) ) && !host sprintbuttonpressed() )
            {
                if ( b_anim_controls )
                {
                    function_6785ef9c54890035();
                    host function_f9a1904ad3a280b6( "<dev string:x3b5>" );
                }
                else if ( b_alt_controls )
                {
                    foreach ( s_instance in level.var_e3a25508acccec8a )
                    {
                        if ( isdefined( s_instance.e_current_asset ) && isdefined( s_instance.e_rotator ) && !s_instance.e_current_asset.b_playing_fx )
                        {
                            s_instance.e_current_asset unlink();
                            s_instance.e_current_asset function_c711317abdfec18b();
                            s_instance.e_current_asset linkto( s_instance.e_rotator );
                        }
                    }
                }
                else if ( utility::flag( "<dev string:x3bb>" ) )
                {
                    utility::flag_clear( "<dev string:x3bb>" );
                }
                else
                {
                    utility::flag_set( "<dev string:x3bb>" );
                }
                
                while ( host buttonpressed( "<dev string:x3a1>" ) || host buttonpressed( "<dev string:x3ab>" ) )
                {
                    if ( b_anim_controls )
                    {
                        function_ccdda9d1574d23d5();
                    }
                    
                    waitframe();
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x7cb5c176, Offset: 0xe76
    // Size: 0x3a5, Type: dev
    function function_f568aae89de3a25b()
    {
        while ( true )
        {
            if ( utility::flag( "<dev string:x3d8>" ) || !level.var_7ec6b946ce125825 )
            {
                waitframe();
                continue;
            }
            
            host = level.player;
            
            if ( isdefined( host ) && level.var_4fdd3d1133b558be )
            {
                x = ( 50, 400, 0 )[ 0 ] + ( 0, 20, 0 )[ 0 ];
                y = ( 50, 400, 0 )[ 1 ] + ( 0, 20, 0 )[ 1 ];
                
                if ( host fragbuttonpressed() )
                {
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 0, "<dev string:x3ea>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 1, "<dev string:x41d>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 2, "<dev string:x43e>", ( 1, 1, 1 ), 0.8 );
                }
                else if ( host adsbuttonpressed() )
                {
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 0, "<dev string:x462>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 1, "<dev string:x479>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 2, "<dev string:x49b>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 3, "<dev string:x4c4>", ( 1, 1, 1 ), 0.8 );
                }
                else
                {
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 0, "<dev string:x4fb>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 1, "<dev string:x51b>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 2, "<dev string:x53c>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 3, "<dev string:x563>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 4, "<dev string:x57b>", ( 1, 1, 1 ), 0.8 );
                    printtoscreen2d( x, y + ( 0, 20, 0 )[ 1 ] * 5, "<dev string:x59e>", ( 1, 1, 1 ), 0.8 );
                }
                
                printtoscreen2d( ( 640, 25, 0 )[ 0 ], ( 640, 25, 0 )[ 1 ], "<dev string:x5b3>", ( 1, 1, 1 ), 0.8 );
                function_d9186b5c35ef34d1();
            }
            
            waitframe();
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xbb9d1ce4, Offset: 0x1223
    // Size: 0x1c1, Type: dev
    function function_a03bb59318abadcd( s_instance )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            if ( utility::flag( "<dev string:x3bb>" ) || utility::flag( "<dev string:x383>" ) )
            {
                foreach ( s_instance in level.var_e3a25508acccec8a )
                {
                    function_700f2ecb08ccc4e1( s_instance );
                    e_rotator = s_instance.e_rotator;
                    v_new_angles = ( e_rotator.angles[ 0 ], e_rotator.angles[ 1 ], e_rotator.angles[ 2 ] );
                    
                    if ( utility::flag( "<dev string:x645>" ) )
                    {
                        v_new_angles = ( v_new_angles[ 0 ] + 3, v_new_angles[ 1 ], v_new_angles[ 2 ] );
                    }
                    
                    if ( utility::flag( "<dev string:x3bb>" ) )
                    {
                        v_new_angles = ( s_instance.e_rotator.angles[ 0 ], s_instance.e_rotator.angles[ 1 ] + 3, s_instance.e_rotator.angles[ 2 ] );
                    }
                    
                    if ( utility::flag( "<dev string:x383>" ) )
                    {
                        v_new_angles = ( v_new_angles[ 0 ], v_new_angles[ 1 ], v_new_angles[ 2 ] + 3 );
                    }
                    
                    v_new_angles = ( angleclamp( v_new_angles[ 0 ] ), angleclamp( v_new_angles[ 1 ] ), angleclamp( v_new_angles[ 2 ] ) );
                    e_rotator rotateto( v_new_angles, 0.05 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0xb86287a7, Offset: 0x13ec
    // Size: 0x53, Type: dev
    function function_6ee12621094b1ede()
    {
        if ( level.var_4fdd3d1133b558be )
        {
            printtoscreen2d( ( 700, 530, 0 )[ 0 ], ( 700, 530, 0 )[ 1 ], "<dev string:x664>" + level.var_9f7cbda10cd8473a, ( 1, 1, 1 ), 1 );
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x45f5ec44, Offset: 0x1447
    // Size: 0x59, Type: dev
    function function_ccdda9d1574d23d5()
    {
        if ( level.var_4fdd3d1133b558be )
        {
            printtoscreen2d( ( 700, 530, 0 )[ 0 ], ( 700, 530, 0 )[ 1 ], "<dev string:x67c>" + level.var_142478e638411141 + "<dev string:x693>", ( 1, 1, 1 ), 1 );
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x5199393a, Offset: 0x14a8
    // Size: 0x407, Type: dev
    function function_d9186b5c35ef34d1()
    {
        host = level.player;
        
        if ( isdefined( host ) && level.var_4fdd3d1133b558be )
        {
            foreach ( s_instance in level.var_e3a25508acccec8a )
            {
                var_ae04aa79b5a2ec63 = [];
                
                if ( isdefined( s_instance.e_current_asset ) )
                {
                    var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x695>" + ( s_instance.s_current_asset.assetlabel ?? "<dev string:x69c>" );
                    var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x6a7>" + s_instance.s_current_asset.assettype;
                    var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x6ae>" + get_current_asset_name( s_instance );
                    var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x6b5>" + ( s_instance.targetname ?? "<dev string:x6c0>" );
                    
                    if ( get_current_asset_type( s_instance ) == "<dev string:x6d0>" && isdefined( s_instance.s_current_asset.attachmodels ) )
                    {
                        foreach ( var_4d0b309f1c9b7a23 in s_instance.s_current_asset.attachmodels )
                        {
                            str_tag = var_4d0b309f1c9b7a23.var_be147a09ee598460 ?? "<dev string:x6d7>";
                            var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x6e2>" + var_4d0b309f1c9b7a23.attachmodel + "<dev string:x6f4>" + str_tag + "<dev string:x6f7>";
                        }
                        
                        if ( isdefined( s_instance.s_current_asset.str_model_variant ) )
                        {
                            var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x6f9>" + s_instance.s_current_asset.var_be76bde4aa37d75f + 1 + "<dev string:x708>" + s_instance.s_current_asset.str_model_variant;
                        }
                    }
                    
                    s_scene = get_current_scene_name( s_instance );
                    
                    if ( isdefined( s_scene ) && isdefined( s_scene.scene ) && s_instance.e_current_asset.b_anim_playing )
                    {
                        var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x70b>" + s_scene.scene;
                        
                        if ( isdefined( s_scene.sceneshot ) )
                        {
                            var_ae04aa79b5a2ec63[ var_ae04aa79b5a2ec63.size ] = "<dev string:x713>" + s_scene.sceneshot;
                        }
                    }
                    
                    if ( distance2dsquared( host.origin, s_instance.e_current_asset.origin ) < 250000 && utility::within_fov( host geteye(), host getplayerangles(), s_instance.e_current_asset getcentroid(), 0.9 ) )
                    {
                        foreach ( n_spacing, var_3fe5ac2f72d11497 in var_ae04aa79b5a2ec63 )
                        {
                            v_pos = s_instance.e_current_asset.origin + ( -15, 0, -15 );
                            v_pos += ( 0, 0, -2.5 * n_spacing );
                            print3d( v_pos, var_3fe5ac2f72d11497, ( 1, 1, 0 ), 1, 0.2 );
                        }
                    }
                }
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0xe2211676, Offset: 0x18b7
    // Size: 0x92, Type: dev
    function function_c711317abdfec18b()
    {
        [ n_radius ] = self getboundshalfsize();
        v_ground = getgroundposition( self.origin, n_radius );
        var_1e4bd5050504c7b0 = self getpointinbounds( 0, 0, -1 );
        n_z_diff = var_1e4bd5050504c7b0[ 2 ] - v_ground[ 2 ];
        self.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - n_z_diff );
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x38fc74f9, Offset: 0x1951
    // Size: 0x15c, Type: dev
    function cycle_model( str_direction )
    {
        if ( !isdefined( str_direction ) )
        {
            str_direction = "<dev string:x37d>";
        }
        
        foreach ( s_instance in level.var_e3a25508acccec8a )
        {
            if ( str_direction == "<dev string:x362>" )
            {
                if ( !isdefined( s_instance.var_6358c7810e05e32 ) )
                {
                    s_instance.var_6358c7810e05e32 = 1;
                }
                
                s_instance.var_6358c7810e05e32--;
                
                if ( s_instance.var_6358c7810e05e32 < 0 )
                {
                    s_instance.var_6358c7810e05e32 = s_instance.s_bundle.assetlist.size - 1;
                }
            }
            else
            {
                if ( !isdefined( s_instance.var_6358c7810e05e32 ) )
                {
                    s_instance.var_6358c7810e05e32 = -1;
                }
                
                s_instance.var_6358c7810e05e32++;
                
                if ( s_instance.var_6358c7810e05e32 > s_instance.s_bundle.assetlist.size - 1 )
                {
                    s_instance.var_6358c7810e05e32 = 0;
                }
            }
            
            spawn_asset( s_instance );
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xa18293d0, Offset: 0x1ab5
    // Size: 0x3d, Type: dev
    function get_operator_bundle( operator_ref )
    {
        s_operator_bundle = getoperatorscriptbundle( operator_ref );
        
        if ( !isdefined( s_operator_bundle ) )
        {
            println( "<dev string:x71a>" + getxhashsourcename( operator_ref ) );
            return;
        }
        
        return s_operator_bundle;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x81b933f3, Offset: 0x1afa
    // Size: 0x3d, Type: dev
    function get_operatorskin_bundle( operatorskin_ref )
    {
        var_57a3e5470cd36f42 = getoperatorskinscriptbundle( operatorskin_ref );
        
        if ( !isdefined( var_57a3e5470cd36f42 ) )
        {
            println( "<dev string:x747>" + getxhashsourcename( operatorskin_ref ) );
            return;
        }
        
        return var_57a3e5470cd36f42;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x391f30df, Offset: 0x1b3f
    // Size: 0x146, Type: dev
    function get_current_asset_name( s_instance )
    {
        str_name = "<dev string:x778>";
        str_type = get_current_asset_type( s_instance );
        
        switch ( str_type )
        {
            case #"hash_769eb8a21188fc4":
                str_name = s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].model;
                break;
            case #"hash_8cfcad56b3b4065d":
                str_name = getxhashsourcename( s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].operator );
                break;
            case #"hash_425f82dd2bc1f2a0":
                str_name = getxhashsourcename( s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].operatorskin );
                break;
            case #"hash_842bba4c2f48ddf0":
                str_name = s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].character;
                break;
            default:
                break;
        }
        
        return str_name;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xdacd2f9c, Offset: 0x1c8d
    // Size: 0x55, Type: dev
    function get_current_asset_type( s_instance )
    {
        n_current_index = s_instance.var_6358c7810e05e32;
        str_type = s_instance.s_bundle.assetlist[ n_current_index ].assettype;
        return str_type;
    }

    // Namespace namespace_73de116fe4733020
    // Params 2
    // Checksum 0x50637aaa, Offset: 0x1cea
    // Size: 0xe7, Type: dev
    function function_b5ffe6b9ae7088da( s_instance, var_962050f232b5c478 )
    {
        if ( var_962050f232b5c478 )
        {
            v_offset = ( s_instance.var_61027d2724fe83d3.x ?? 0, s_instance.var_61027d2724fe83d3.y ?? 0, s_instance.var_61027d2724fe83d3.z ?? 0 );
        }
        else
        {
            v_offset = ( s_instance.s_current_asset.spawnoffsetpos.x ?? 0, s_instance.s_current_asset.spawnoffsetpos.y ?? 0, s_instance.s_current_asset.spawnoffsetpos.z ?? 0 );
        }
        
        return v_offset;
    }

    // Namespace namespace_73de116fe4733020
    // Params 2
    // Checksum 0x4e4656d1, Offset: 0x1dd9
    // Size: 0xe7, Type: dev
    function function_dc445bb90ecad200( s_instance, var_962050f232b5c478 )
    {
        if ( var_962050f232b5c478 )
        {
            v_offset = ( s_instance.var_6954e8266f0e9e4d.x ?? 0, s_instance.var_6954e8266f0e9e4d.y ?? 0, s_instance.var_6954e8266f0e9e4d.z ?? 0 );
        }
        else
        {
            v_offset = ( s_instance.s_current_asset.var_75602065bbf8896.x ?? 0, s_instance.s_current_asset.var_75602065bbf8896.y ?? 0, s_instance.s_current_asset.var_75602065bbf8896.z ?? 0 );
        }
        
        return v_offset;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xf73ba47f, Offset: 0x1ec8
    // Size: 0xab, Type: dev
    function function_76dacffa5342b1e2( s_instance )
    {
        n_current_index = s_instance.s_current_asset.var_9d1fbdcb2650d4e5;
        s_anim_asset = s_instance.s_current_asset.assetanimations[ n_current_index ];
        v_offset = ( s_anim_asset.var_61027d2724fe83d3.x ?? 0, s_anim_asset.var_61027d2724fe83d3.y ?? 0, s_anim_asset.var_61027d2724fe83d3.z ?? 0 );
        return v_offset;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xf73ba47f, Offset: 0x1f7b
    // Size: 0xab, Type: dev
    function function_9d1f84f9b39d87c8( s_instance )
    {
        n_current_index = s_instance.s_current_asset.var_9d1fbdcb2650d4e5;
        s_anim_asset = s_instance.s_current_asset.assetanimations[ n_current_index ];
        v_offset = ( s_anim_asset.var_6954e8266f0e9e4d.x ?? 0, s_anim_asset.var_6954e8266f0e9e4d.y ?? 0, s_anim_asset.var_6954e8266f0e9e4d.z ?? 0 );
        return v_offset;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x71972bc9, Offset: 0x202e
    // Size: 0x8e, Type: dev
    function get_current_scene_name( s_instance )
    {
        n_current_index = s_instance.s_current_asset.var_9d1fbdcb2650d4e5;
        
        if ( !isarray( s_instance.s_current_asset.assetanimations ) || !s_instance.s_current_asset.assetanimations.size )
        {
            return;
        }
        
        s_scene = s_instance.s_current_asset.assetanimations[ n_current_index ];
        return s_scene;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xdf2c836b, Offset: 0x20c4
    // Size: 0x540, Type: dev
    function spawn_asset( s_instance )
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        function_700f2ecb08ccc4e1( s_instance );
        host = level.player;
        
        if ( isdefined( s_instance.e_current_asset ) && isdefined( s_instance.e_current_asset.var_a59619ff66db1cd2 ) )
        {
            foreach ( model in s_instance.e_current_asset.var_a59619ff66db1cd2 )
            {
                model delete();
            }
            
            s_instance.e_current_asset.var_a59619ff66db1cd2 = undefined;
        }
        
        if ( isdefined( s_instance.e_current_asset ) )
        {
            s_instance.e_current_asset delete();
        }
        
        s_instance.s_current_asset = s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ];
        
        if ( !isdefined( s_instance.s_current_asset.var_9d1fbdcb2650d4e5 ) )
        {
            s_instance.s_current_asset.var_9d1fbdcb2650d4e5 = 0;
        }
        
        str_type = get_current_asset_type( s_instance );
        v_pos = s_instance.e_rotator.origin + function_b5ffe6b9ae7088da( s_instance );
        v_ang = s_instance.e_rotator.angles + function_dc445bb90ecad200( s_instance );
        
        switch ( str_type )
        {
            case #"hash_842bba4c2f48ddf0":
                s_instance.e_current_asset = function_2e371f829f9db6b4( s_instance, v_pos, v_ang );
                break;
            case #"hash_8cfcad56b3b4065d":
                s_instance.e_current_asset = function_d3e5a06e0fb884c9( s_instance, v_pos, v_ang );
                break;
            case #"hash_425f82dd2bc1f2a0":
                s_instance.e_current_asset = function_e7d15d9a7b9ea504( s_instance, v_pos, v_ang );
                break;
            case #"hash_769eb8a21188fc4":
                str_asset_name = get_current_asset_name( s_instance );
                s_instance.e_current_asset = utility::spawn_model( str_asset_name, v_pos, v_ang );
                break;
            default:
                iprintlnbold( "<dev string:x7a0>" );
                return;
        }
        
        s_instance.e_current_asset linkto( s_instance.e_rotator );
        s_instance.e_rotator unlink();
        s_instance.e_rotator.angles = ( s_instance.e_rotator.angles[ 0 ], s_instance.e_rotator.angles[ 1 ], 0 );
        
        if ( isdefined( s_instance.var_a190e8a030eedd0f ) )
        {
            s_instance.var_a190e8a030eedd0f unlink();
            s_instance.var_a190e8a030eedd0f.angles = ( s_instance.var_a190e8a030eedd0f.angles[ 0 ], s_instance.var_a190e8a030eedd0f.angles[ 1 ], 0 );
            
            if ( s_instance.var_a190e8a030eedd0f.var_fd1725d5f1b6482 )
            {
                s_instance.e_rotator linkto( s_instance.var_a190e8a030eedd0f );
                s_instance.var_a190e8a030eedd0f linkto( host );
            }
        }
        
        if ( str_type == "<dev string:x6d0>" && isdefined( s_instance.s_current_asset.attachmodels ) )
        {
            s_instance.e_current_asset.var_a59619ff66db1cd2 = [];
            
            foreach ( var_4d0b309f1c9b7a23 in s_instance.s_current_asset.attachmodels )
            {
                if ( !isdefined( var_4d0b309f1c9b7a23.attachmodel ) )
                {
                    continue;
                }
                
                str_tag = var_4d0b309f1c9b7a23.var_be147a09ee598460 ?? "<dev string:x6d7>";
                var_4d07d9e5a03d5195 = utility::spawn_model( var_4d0b309f1c9b7a23.attachmodel, s_instance.e_current_asset.origin, s_instance.e_current_asset.angles );
                var_4d07d9e5a03d5195 linkto( s_instance.e_current_asset, str_tag, function_b5ffe6b9ae7088da( var_4d0b309f1c9b7a23, 1 ), function_dc445bb90ecad200( var_4d0b309f1c9b7a23, 1 ) );
                s_instance.e_current_asset.var_a59619ff66db1cd2[ s_instance.e_current_asset.var_a59619ff66db1cd2.size ] = var_4d07d9e5a03d5195;
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 3
    // Checksum 0x162c29e0, Offset: 0x260c
    // Size: 0x7f, Type: dev
    function function_2e371f829f9db6b4( s_instance, v_pos, v_ang )
    {
        var_daf7dc861ce9a958 = getxhashasset( get_current_asset_name( s_instance ) );
        
        if ( function_df63e3c9842e8497( var_daf7dc861ce9a958 ) )
        {
            entity = spawn( "<dev string:x301>", v_pos );
            
            if ( isdefined( entity ) )
            {
                entity function_589df9c1869fcee4( 1 );
                entity setcharacter( var_daf7dc861ce9a958 );
                entity.angles = v_ang;
            }
        }
        
        return entity;
    }

    // Namespace namespace_73de116fe4733020
    // Params 4
    // Checksum 0x8835ff31, Offset: 0x2693
    // Size: 0x12b, Type: dev
    function function_e7d15d9a7b9ea504( s_instance, v_pos, v_ang, var_fc343e6e0296c22 )
    {
        entity = undefined;
        s_skin_bundle = undefined;
        
        if ( isdefined( var_fc343e6e0296c22 ) )
        {
            s_skin_bundle = get_operatorskin_bundle( var_fc343e6e0296c22 );
        }
        else
        {
            s_skin_bundle = get_operatorskin_bundle( s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].operatorskin );
        }
        
        if ( isdefined( s_skin_bundle ) )
        {
            var_ffdcd064ce4b93de = isdefined( s_skin_bundle.var_7ee18fd3d0f73ac0 ) ? getscriptbundlefieldvalue( s_skin_bundle.var_7ee18fd3d0f73ac0, #"model" ) : undefined;
            str_head_model_name = isdefined( s_skin_bundle.var_76515354c5a33a52 ) ? getscriptbundlefieldvalue( s_skin_bundle.var_76515354c5a33a52, #"model" ) : undefined;
            
            if ( isdefined( var_ffdcd064ce4b93de ) )
            {
                entity = utility::spawn_model( var_ffdcd064ce4b93de, v_pos, v_ang );
            }
            
            if ( isdefined( str_head_model_name ) )
            {
                entity function_589df9c1869fcee4( 1 );
                entity attach( str_head_model_name, "<dev string:x300>", 1 );
            }
        }
        
        return entity;
    }

    // Namespace namespace_73de116fe4733020
    // Params 3
    // Checksum 0xccaf7238, Offset: 0x27c6
    // Size: 0x9e, Type: dev
    function function_d3e5a06e0fb884c9( s_instance, v_pos, v_ang )
    {
        operator_ref = s_instance.s_bundle.assetlist[ s_instance.var_6358c7810e05e32 ].operator;
        s_operator_bundle = get_operator_bundle( operator_ref );
        entity = undefined;
        
        if ( isdefined( s_operator_bundle.defaultskin ) )
        {
            entity = function_e7d15d9a7b9ea504( s_instance, v_pos, v_ang, s_operator_bundle.defaultskin );
        }
        
        return entity;
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0xe5e6d0b9, Offset: 0x286c
    // Size: 0x179, Type: dev
    function function_700f2ecb08ccc4e1( s_instance )
    {
        if ( !isdefined( s_instance.e_rotator ) )
        {
            s_instance.e_rotator = spawn( "<dev string:x301>", s_instance.origin );
            s_instance.e_rotator.angles = s_instance.angles ?? ( 0, 0, 0 );
        }
        
        if ( !isdefined( s_instance.e_rotator_linked_ents ) && isdefined( s_instance.script_linkname ) )
        {
            s_instance.e_rotator_linked_ents = spawn( "<dev string:x301>", s_instance.origin );
            s_instance.e_rotator_linked_ents.angles = s_instance.angles;
            s_instance.var_71dd5c0eea063942 = getentarray( s_instance.script_linkname, #script_linkto );
            
            foreach ( ent in s_instance.var_71dd5c0eea063942 )
            {
                ent linkto( s_instance.e_rotator_linked_ents );
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x7aeced22, Offset: 0x29ed
    // Size: 0x227, Type: dev
    function function_f9a1904ad3a280b6( str_option )
    {
        if ( !isdefined( str_option ) )
        {
            str_option = "<dev string:x37d>";
        }
        
        foreach ( s_instance in level.var_e3a25508acccec8a )
        {
            s_current_asset = s_instance.s_current_asset;
            
            if ( str_option == "<dev string:x362>" )
            {
                s_current_asset.var_9d1fbdcb2650d4e5--;
                
                if ( s_current_asset.var_9d1fbdcb2650d4e5 < 0 )
                {
                    s_current_asset.var_9d1fbdcb2650d4e5 = s_current_asset.assetanimations.size - 1;
                }
                
                s_instance.e_current_asset.b_anim_playing = undefined;
            }
            else if ( str_option == "<dev string:x37d>" )
            {
                s_current_asset.var_9d1fbdcb2650d4e5++;
                
                if ( s_current_asset.var_9d1fbdcb2650d4e5 > s_current_asset.assetanimations.size - 1 )
                {
                    s_current_asset.var_9d1fbdcb2650d4e5 = 0;
                }
                
                s_instance.e_current_asset.b_anim_playing = undefined;
            }
            
            s_scene = get_current_scene_name( s_instance );
            
            if ( isdefined( s_scene ) )
            {
                if ( isdefined( s_instance.e_current_asset ) )
                {
                    if ( str_option == "<dev string:x3b5>" )
                    {
                        var_387ccd7a0bf3bbd8 = 1;
                    }
                    else
                    {
                        var_387ccd7a0bf3bbd8 = 0;
                    }
                    
                    s_instance function_bc05fd68e6a4ac22( s_scene, var_387ccd7a0bf3bbd8 );
                }
                
                continue;
            }
            
            if ( isdefined( s_instance.e_current_asset ) && s_instance.e_current_asset.b_anim_playing && !s_instance.e_current_asset.b_playing_fx )
            {
                s_instance.e_rotator scene::stop();
                s_instance.e_current_asset linkto( s_instance.e_rotator );
                s_instance.e_current_asset.b_anim_playing = undefined;
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 2
    // Checksum 0x87091606, Offset: 0x2c1c
    // Size: 0x14d, Type: dev
    function function_bc05fd68e6a4ac22( s_scene, var_5afee459e3f197b8 )
    {
        if ( isdefined( self.e_rotator.script_scenescriptbundle ) )
        {
            self.e_rotator scene::stop();
        }
        
        self.e_rotator.script_scenescriptbundle = s_scene.scene;
        
        if ( var_5afee459e3f197b8 )
        {
            if ( self.e_current_asset.b_anim_playing )
            {
                self.e_rotator thread scene::play( self.e_current_asset, s_scene.sceneshot, s_scene.scene );
            }
            
            return;
        }
        
        if ( self.e_current_asset.b_anim_playing )
        {
            n_start_time = 0;
            b_paused = 1;
            self.e_current_asset.b_anim_playing = undefined;
        }
        else
        {
            n_start_time = 0;
            b_paused = 0;
            self.e_current_asset.b_anim_playing = 1;
        }
        
        self.e_rotator scene::stop();
        self.e_rotator thread scene::play( self.e_current_asset, s_scene.sceneshot, s_scene.scene, n_start_time );
    }

    // Namespace namespace_73de116fe4733020
    // Params 1
    // Checksum 0x20eb6fc5, Offset: 0x2d71
    // Size: 0x2fe, Type: dev
    function function_a5a90d387847e2ab( s_instance )
    {
        s_current_asset = s_instance.s_current_asset;
        var_9d1fbdcb2650d4e5 = s_current_asset.var_9d1fbdcb2650d4e5;
        
        if ( isdefined( s_instance.e_current_asset.var_4d07d9e5a03d5195 ) )
        {
            foreach ( model in s_instance.e_current_asset.var_a59619ff66db1cd2 )
            {
                model delete();
            }
        }
        
        if ( isarray( s_current_asset.assetanimations ) && isdefined( s_current_asset.assetanimations[ var_9d1fbdcb2650d4e5 ].attachmodel ) )
        {
            s_anim = s_current_asset.assetanimations[ var_9d1fbdcb2650d4e5 ];
            var_ed3b75c04056f6e1 = s_anim.attachmodel;
            str_tag = s_anim.var_be147a09ee598460 ?? "<dev string:x6d7>";
            s_instance.e_current_asset.var_4d07d9e5a03d5195 = spawn( "<dev string:x301>", s_instance.e_current_asset.origin );
            s_instance.e_current_asset.var_4d07d9e5a03d5195.angles = s_instance.e_current_asset.angles ?? ( 0, 0, 0 );
            var_8662368b2900e733 = function_76dacffa5342b1e2( s_instance );
            v_ang_offset_attach = function_9d1f84f9b39d87c8( s_instance );
            s_instance.e_current_asset.var_4d07d9e5a03d5195 linkto( s_instance.e_current_asset, str_tag, var_8662368b2900e733, v_ang_offset_attach );
            return;
        }
        
        if ( isdefined( s_current_asset.attachmodel ) )
        {
            var_ed3b75c04056f6e1 = s_current_asset.attachmodel;
            str_tag = s_current_asset.var_be147a09ee598460 ?? "<dev string:x6d7>";
            s_instance.e_current_asset.var_4d07d9e5a03d5195 = spawn( "<dev string:x301>", s_instance.e_current_asset.origin );
            s_instance.e_current_asset.var_4d07d9e5a03d5195.angles = s_instance.e_current_asset.angles ?? ( 0, 0, 0 );
            var_8662368b2900e733 = function_76dacffa5342b1e2( s_instance );
            v_ang_offset_attach = function_9d1f84f9b39d87c8( s_instance );
            s_instance.e_current_asset.var_4d07d9e5a03d5195 linkto( s_instance.e_current_asset, str_tag, var_8662368b2900e733, v_ang_offset_attach );
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x42a1ac44, Offset: 0x3077
    // Size: 0x65, Type: dev
    function function_6785ef9c54890035()
    {
        if ( level.var_142478e638411141 == 1 )
        {
            level.var_142478e638411141 = 0.1;
            return;
        }
        
        if ( level.var_142478e638411141 == 0.5 )
        {
            level.var_142478e638411141 = 1;
            return;
        }
        
        if ( level.var_142478e638411141 == 0.1 )
        {
            level.var_142478e638411141 = 0.5;
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x19c11548, Offset: 0x30e4
    // Size: 0xd2, Type: dev
    function function_aacb5ad7dd21217e()
    {
        level.var_9f7cbda10cd8473a -= 0.25;
        
        if ( level.var_9f7cbda10cd8473a < 0.25 )
        {
            level.var_9f7cbda10cd8473a = 1;
        }
        
        foreach ( s_instance in level.var_e3a25508acccec8a )
        {
            if ( isdefined( s_instance.e_current_asset ) )
            {
            }
            
            if ( isdefined( s_instance.e_current_asset.var_4d07d9e5a03d5195 ) )
            {
            }
        }
    }

    // Namespace namespace_73de116fe4733020
    // Params 0
    // Checksum 0x4c0ede3c, Offset: 0x31be
    // Size: 0x22e, Type: dev
    function function_a95a58012faa6423()
    {
        foreach ( s_instance in level.var_e3a25508acccec8a )
        {
            s_current_asset = s_instance.s_current_asset;
            
            if ( s_current_asset.assettype != "<dev string:x6d0>" )
            {
                continue;
            }
            
            if ( isarray( s_current_asset.var_9f770fc12b4aa2fd ) && s_current_asset.var_9f770fc12b4aa2fd.size > 0 && isdefined( s_instance.e_current_asset ) )
            {
                if ( !isdefined( s_current_asset.var_be76bde4aa37d75f ) )
                {
                    s_current_asset.var_be76bde4aa37d75f = 0;
                    s_instance.s_current_asset.str_model_variant = s_current_asset.var_9f770fc12b4aa2fd[ s_current_asset.var_be76bde4aa37d75f ].modelvariant;
                    s_instance.e_current_asset setmodel( s_instance.s_current_asset.str_model_variant );
                    continue;
                }
                
                s_current_asset.var_be76bde4aa37d75f++;
                
                if ( s_current_asset.var_be76bde4aa37d75f >= s_current_asset.var_9f770fc12b4aa2fd.size )
                {
                    s_current_asset.var_be76bde4aa37d75f = -1;
                    s_instance.e_current_asset setmodel( s_current_asset.model );
                    s_instance.s_current_asset.str_model_variant = undefined;
                    continue;
                }
                
                s_instance.s_current_asset.str_model_variant = s_current_asset.var_9f770fc12b4aa2fd[ s_current_asset.var_be76bde4aa37d75f ].modelvariant;
                
                if ( isdefined( s_instance.s_current_asset.str_model_variant ) )
                {
                    s_instance.e_current_asset setmodel( s_instance.s_current_asset.str_model_variant );
                }
            }
        }
    }

#/
