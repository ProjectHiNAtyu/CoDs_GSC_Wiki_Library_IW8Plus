// scripts\common\scene_debug.gsc  (hash_308091d56071a91c.gscc) (size: 25839 Bytes / 0x64ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7ed148c (4159509644)
// size ...... 25839 (0x64ef)
// includes .. 7   (offset: 0x5cbb)
// strings ... 0   (offset: 0x5cf3)
// dev strs .. 131 (offset: 0x5cf3)
// exports ... 38  (offset: 0x43ff)
// cseg ...... 0x58 + 0x43a7 (0x43ff)
// imports ... 138 (offset: 0x49ef)
// animtree1 . 0   (offset: 0x64ef)
// animtree2 . 0   (offset: 0x64ef)
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scene_internal;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace scene_debug;

/#

    // Namespace scene_debug
    // Params 0
    // Checksum 0xebf894e6, Offset: 0x76
    // Size: 0x13c, Type: dev
    function function_194590af69906dd3()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdvarifuninitialized( @"scr_debug_scene_devgui", "<dev string:x24>" );
        setdvarifuninitialized( @"scr_debug_scene_disabled", 0 );
        setdvarifuninitialized( @"scr_debug_scene", 0 );
        setdvarifuninitialized( @"scr_debug_scene_events", 0 );
        setdvarifuninitialized( @"scr_debug_scene_events_filter", "<dev string:x24>" );
        setdvarifuninitialized( @"scr_debug_scene_player_rig", 0 );
        setdvarifuninitialized( @"hash_f98fc73c88850645", 0 );
        setdvarifuninitialized( @"hash_d0761d5c3f9e3bf", 0 );
        setdvarifuninitialized( @"hash_373ad6363da1c230", ( 0, 0, 0 ) );
        setdvarifuninitialized( @"hash_eab41865eb0e96ea", ( 0, 0, 0 ) );
        setdvarifuninitialized( @"scr_debug_scene_list", 0 );
        setdvarifuninitialized( @"hash_b279d32f047f16db", 0 );
        setdvarifuninitialized( @"scr_debug_scene_penetrate", 1 );
        setdvarifuninitialized( @"hash_b95e70dfa43a9845", 1 );
        setdvarifuninitialized( @"hash_bc2179c6aea6636d", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_778fd26081328e2f", "<dev string:x24>" );
        level thread debug_scenes();
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0x9c64e5d8, Offset: 0x1ba
    // Size: 0xd9, Type: dev
    function register()
    {
        if ( !getdvarint( @"scr_debug_scene_list", 0 ) )
        {
            return;
        }
        
        sceneroot = self;
        assert( isstruct( sceneroot.scenedata ) );
        
        if ( isdefined( level.scene.debuglist ) )
        {
            level.scene.debuglist.debuglistlast = sceneroot.scenedata;
        }
        
        sceneroot.scenedata.debuglistnext = level.scene.debuglist;
        sceneroot.scenedata.debuglistlast = undefined;
        level.scene.debuglist = sceneroot.scenedata;
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0xcbcc5af9, Offset: 0x29b
    // Size: 0xff, Type: dev
    function unregister()
    {
        if ( !getdvarint( @"scr_debug_scene_list", 0 ) )
        {
            return;
        }
        
        sceneroot = self;
        assert( isstruct( sceneroot.scenedata ) );
        
        if ( isdefined( sceneroot.scenedata.debuglistlast ) )
        {
            sceneroot.scenedata.debuglistlast.debuglistnext = sceneroot.scenedata.debuglistnext;
        }
        
        if ( level.scene.debuglist == sceneroot.scenedata )
        {
            level.scene.debuglist = sceneroot.scenedata.debuglistnext;
        }
        
        sceneroot.scenedata.debuglistlast = undefined;
        sceneroot.scenedata.debuglistnext = undefined;
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0xcf82ed0d, Offset: 0x3a2
    // Size: 0x11f, Type: dev
    function private debug_scenes()
    {
        while ( !( isdefined( level.player ) && isdefined( level.scene ) ) )
        {
            waitframe();
        }
        
        wait 0.5;
        level.scene.debug_player = level.player;
        level.scene.debug_player thread scene_menu_button_held_think( "<dev string:x25>" );
        level.scene.debug_player thread scene_menu_button_held_think( "<dev string:x2d>" );
        level.scene.debug_player thread scene_menu_button_held_think( "<dev string:x37>" );
        level.scene.debug_player thread scene_menu_button_held_think( "<dev string:x3f>" );
        function_146b8cea02a5a4eb();
        level thread function_52f6223b9b56681b();
        devgui::function_9082edeb5db93280( "<dev string:x49>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x57>", "<dev string:x67>", &function_bd0ab793e83b94ef, 0, 1 );
        devgui::add_devgui_func( "<dev string:x77>", "<dev string:x82>", &scene_menu, 0, 2 );
        devgui::function_77df7fe7dd273e10();
        level thread function_e7e798bd060cf03d();
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0xc0751d70, Offset: 0x4c9
    // Size: 0x108, Type: dev
    function private function_52f6223b9b56681b()
    {
        var_e29b675e10b7ca10 = [];
        i = 0;
        
        foreach ( s_scene in level.a_scene_structs )
        {
            if ( is_dupe_scene( s_scene.script_scenescriptbundle ) && !s_scene.var_b8d0b3148ac4e533 )
            {
                if ( isdefined( var_e29b675e10b7ca10[ s_scene.script_scenescriptbundle ] ) )
                {
                    var_e29b675e10b7ca10[ s_scene.script_scenescriptbundle ]++;
                }
                else
                {
                    var_e29b675e10b7ca10[ s_scene.script_scenescriptbundle ] = 1;
                }
                
                s_scene.var_d69404e803a096ca = var_e29b675e10b7ca10[ s_scene.script_scenescriptbundle ];
            }
            
            if ( i % 50 == 0 )
            {
                waitframe();
            }
            
            i++;
        }
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0x66f6ec04, Offset: 0x5d9
    // Size: 0xcf, Type: dev
    function private is_dupe_scene( str_scene_name )
    {
        n_count = 0;
        i = 0;
        
        foreach ( s_scene in level.a_scene_structs )
        {
            if ( s_scene.script_scenescriptbundle == str_scene_name )
            {
                n_count++;
                
                if ( n_count == 2 )
                {
                    break;
                }
            }
            
            if ( i % 50 == 0 )
            {
                waitframe();
            }
            
            i++;
        }
        
        if ( n_count > 1 )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0xdb08bfe4, Offset: 0x6b0
    // Size: 0x3d, Type: dev
    function private function_e7e798bd060cf03d()
    {
        while ( true )
        {
            waitframe();
            
            if ( !getdvarint( @"scr_debug_scene", 0 ) && !getdvarint( @"scr_debug_scene_list", 0 ) )
            {
                continue;
            }
            
            function_835db787656b0e9c();
        }
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0xacb530de, Offset: 0x6f5
    // Size: 0x310, Type: dev
    function private function_835db787656b0e9c()
    {
        countscene = 0;
        countobject = 0;
        countshot = 0;
        countbundle = 0;
        walk = level.scene.debuglist;
        
        if ( isdefined( level.globalbundles ) )
        {
            countbundle = level.globalbundles.size;
        }
        
        roots = [];
        
        while ( isdefined( walk ) )
        {
            countscene++;
            
            if ( getdvarint( @"scr_debug_scene_list", 0 ) )
            {
                roots[ roots.size ] = spawnstruct();
                roots[ roots.size - 1 ].sceneroot = walk.sceneroot;
            }
            
            scenescriptbundle = walk.sceneroot scene::scene_scriptbundle();
            sceneshots = scenescriptbundle scene::function_30fd977cf5a4a95e();
            sceneobjects = scenescriptbundle scene::function_bd663a9606d90ac1();
            
            if ( getdvarint( @"scr_debug_scene_list", 0 ) )
            {
                roots[ roots.size - 1 ].sceneshots = sceneshots;
                roots[ roots.size - 1 ].sceneobjects = sceneobjects;
            }
            
            countshot += sceneshots;
            countobject += sceneobjects;
            walk = walk.debuglistnext;
        }
        
        if ( getdvarint( @"scr_debug_scene_list", 0 ) )
        {
            roots = arraysort( roots, undefined, &function_2f7c63e77b293fe7 );
            
            foreach ( root in roots )
            {
                state = root.sceneroot scene::get_state();
                strorigin = "<dev string:x8d>" + int( root.sceneroot.origin[ 0 ] ) + "<dev string:x90>" + int( root.sceneroot.origin[ 1 ] ) + "<dev string:x90>" + int( root.sceneroot.origin[ 2 ] ) + "<dev string:x93>";
                strstate = state ?? "<dev string:x96>";
                print( root.sceneroot.script_scenescriptbundle + "<dev string:xa4>" + strstate + "<dev string:xa9>" + strorigin + "<dev string:xab>" + root.sceneshots + "<dev string:xb3>" + root.sceneobjects );
            }
        }
        
        setdvar( @"scr_debug_scene_list", 0 );
        printtoscreen2d( 50, 60, "<dev string:xbd>" + countscene + "<dev string:xc6>" + countshot + "<dev string:xcf>" + countobject + "<dev string:xda>" + countbundle, ( 1, 1, 1 ), 1 );
    }

    // Namespace scene_debug
    // Params 2, eflags: 0x4
    // Checksum 0x6ec9da56, Offset: 0xa0d
    // Size: 0x49, Type: dev
    function private function_2f7c63e77b293fe7( a, b )
    {
        return stricmp( a.sceneroot.script_scenescriptbundle, b.sceneroot.script_scenescriptbundle ) < 0;
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x31f1fce4, Offset: 0xa5e
    // Size: 0x179, Type: dev
    function private function_146b8cea02a5a4eb()
    {
        if ( !isdefined( level.var_18c87c2c4c3b0a2d ) )
        {
            level.var_18c87c2c4c3b0a2d = [];
        }
        
        var_851c384140f3d1c8 = getscriptbundlenames( "<dev string:xe5>" );
        
        foreach ( str_scene_bundle in var_851c384140f3d1c8 )
        {
            s_scenedef = getscriptbundle( str_scene_bundle );
            str_scene_name = strtok( getxhashsourcename( str_scene_bundle ), "<dev string:xf7>" );
            str_scene_name = str_scene_name[ 1 ];
            
            if ( !isdefined( str_scene_name ) )
            {
                continue;
            }
            
            if ( !arraycontains( level.var_18c87c2c4c3b0a2d, str_scene_name ) )
            {
                level.var_18c87c2c4c3b0a2d = arraycombineunique( level.var_18c87c2c4c3b0a2d, [ str_scene_name ] );
                s_scene = spawnstruct();
                s_scene.script_scenescriptbundle = str_scene_name;
                s_scene.origin = ( 0, 0, 0 );
                s_scene.angles = ( 0, 0, 0 );
                s_scene.var_b8d0b3148ac4e533 = 1;
                level.a_scene_structs = arraycombineunique( level.a_scene_structs, [ s_scene ] );
            }
        }
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0x85a2dcbf, Offset: 0xbdf
    // Size: 0x4e, Type: dev
    function private function_bd0ab793e83b94ef( params )
    {
        if ( params[ 0 ] == "<dev string:xf9>" || !utility::flag( "<dev string:x100>" ) )
        {
            utility::flag_set( "<dev string:x100>" );
            level thread function_3c59aa392ac39dcc();
            return;
        }
        
        utility::flag_clear( "<dev string:x100>" );
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0xc7009451, Offset: 0xc35
    // Size: 0x8b3, Type: dev
    function private function_3c59aa392ac39dcc( params )
    {
        level notify( #"hash_f940141742c4300d" );
        level endon( #"hash_f940141742c4300d" );
        var_8d60da971d96ac26 = ( 0.8, 0.8, 0 );
        v_scene_text_color = ( 0.8, 0, 0.8 );
        
        while ( utility::flag( "<dev string:x100>" ) )
        {
            foreach ( s_scene in level.a_scene_structs )
            {
                str_scene_state = s_scene scene::get_state();
                a_ents = s_scene scene::get_entities();
                str_scene_name = isdefined( s_scene.var_d69404e803a096ca ) ? s_scene.script_scenescriptbundle + "<dev string:x117>" + s_scene.var_d69404e803a096ca : s_scene.script_scenescriptbundle;
                print3d( s_scene.origin, "<dev string:x119>" + getxhashsourcename( str_scene_name ), ( 0.8, 0, 0.8 ), 0.8, 0.2 );
                print3d( s_scene.origin + ( 0, 0, -5 ), "<dev string:x121>" + str_scene_state, ( 0.8, 0, 0.8 ), 0.8, 0.2 );
                
                foreach ( ent in a_ents )
                {
                    if ( !isdefined( ent ) )
                    {
                        continue;
                    }
                    
                    sceneobjectdata = ent.sceneobjectdata;
                    str_anim = undefined;
                    
                    if ( isdefined( sceneobjectdata ) )
                    {
                        str_anim = sceneobjectdata.activeanimation;
                    }
                    
                    if ( isdefined( ent.scene_player_rig ) )
                    {
                        str_name = ent.scene_player_rig.animname;
                    }
                    else
                    {
                        str_name = ent.animname ?? sceneobjectdata.sceneobject.variant_object.name;
                    }
                    
                    if ( isanimation( str_anim ) && isdefined( str_name ) )
                    {
                        str_type = ent get_ent_type_text();
                        str_anim_text = "<dev string:x24>";
                        str_extra_info = "<dev string:x24>";
                        currentshot = sceneobjectdata.sceneplay.currentshot;
                        var_a9b8dffd45b33087 = 0;
                        var_9f35e59f5c1e4176 = 0;
                        
                        if ( currentshot >= 0 && currentshot < sceneobjectdata.sceneobject.variant_object.shots.size )
                        {
                            shotanimations = sceneobjectdata.sceneobject.variant_object.shots[ currentshot ].deltaanimations;
                            
                            if ( isdefined( shotanimations ) )
                            {
                                for ( animindex = 0; animindex < shotanimations.size ; animindex++ )
                                {
                                    shotanimation = shotanimations[ animindex ];
                                    animasset = shotanimation.deltaanimation.id;
                                    
                                    if ( isdefined( shotanimation.alternateanimations ) && isdefined( sceneobjectdata.animaltname ) )
                                    {
                                        for ( altnameidx = 0; altnameidx < sceneobjectdata.animaltname.size ; altnameidx++ )
                                        {
                                            hashindex = getxhash( sceneobjectdata.animaltname[ altnameidx ] );
                                            altanim = shotanimation.alternateanimations[ hashindex ];
                                            
                                            if ( isdefined( altanim.animation.id ) )
                                            {
                                                animasset = altanim.animation.id;
                                                break;
                                            }
                                        }
                                    }
                                    
                                    if ( animasset == str_anim )
                                    {
                                        if ( isdefined( shotanimation.var_f6f8a8ec50691b27 ) )
                                        {
                                            var_a9b8dffd45b33087 = shotanimation.var_f6f8a8ec50691b27 * 0.0333333;
                                        }
                                        
                                        if ( isdefined( shotanimation.var_a11f28bba26a8a90 ) )
                                        {
                                            var_9f35e59f5c1e4176 = shotanimation.var_a11f28bba26a8a90 * 0.0333333;
                                        }
                                        
                                        break;
                                    }
                                }
                            }
                        }
                        
                        var_2cdc21caff4906f = getanimlength( str_anim ) ?? 0;
                        var_ece01086c5567dc = max( 0, var_2cdc21caff4906f - var_a9b8dffd45b33087 - var_9f35e59f5c1e4176 );
                        var_bad1c827136f96f = var_2cdc21caff4906f;
                        
                        if ( isplayer( ent ) )
                        {
                            player_rig = level.player_rig ?? ent.scene_player_rig;
                            
                            if ( isdefined( player_rig ) )
                            {
                                var_b965be4ab10edc7e = player_rig getanimtime( str_anim ) ?? 0;
                                var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
                            }
                            else
                            {
                                var_b965be4ab10edc7e = 0;
                                var_3ba18033860bafae = 0;
                            }
                        }
                        else if ( ent vehicle::is_vehicle() || isai( ent ) || utility::issp() )
                        {
                            if ( isagent( ent ) && isdefined( ent.var_e073af6d35bd0942 ) )
                            {
                                var_b965be4ab10edc7e = ent aigetanimtime( "<dev string:x129>", ent.var_e073af6d35bd0942 );
                            }
                            else
                            {
                                var_b965be4ab10edc7e = ent getanimtime( str_anim ) ?? 0;
                            }
                            
                            var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
                        }
                        else if ( isanimscripted( ent ) )
                        {
                            var_b965be4ab10edc7e = ent getanimtime( str_anim ) ?? 0;
                            var_3ba18033860bafae = var_b965be4ab10edc7e * var_bad1c827136f96f;
                        }
                        else if ( isdefined( ent.var_bbd02606816314a8 ) )
                        {
                            if ( var_3ba18033860bafae >= var_bad1c827136f96f )
                            {
                                ent.var_bbd02606816314a8 = gettime();
                            }
                            
                            var_3ba18033860bafae = ( gettime() - ent.var_bbd02606816314a8 ) / 1000;
                            var_b965be4ab10edc7e = var_3ba18033860bafae / var_bad1c827136f96f;
                        }
                        else
                        {
                            var_b965be4ab10edc7e = 0;
                            var_3ba18033860bafae = 0;
                        }
                        
                        var_b288497f88cb2852 = var_bad1c827136f96f * 30;
                        var_b577b0949f7f5e84 = int( var_b965be4ab10edc7e * var_b288497f88cb2852 );
                        str_extra_info = "<dev string:x136>" + var_3ba18033860bafae + "<dev string:x142>" + var_bad1c827136f96f + "<dev string:x144>" + var_b577b0949f7f5e84 + "<dev string:x142>" + var_b288497f88cb2852 + "<dev string:x155>";
                        
                        if ( var_a9b8dffd45b33087 > 0 || var_9f35e59f5c1e4176 > 0 )
                        {
                            var_1a4a0f74fab7dc4 = int( var_a9b8dffd45b33087 * 30 );
                            var_6e1f97e6ac822aed = int( var_9f35e59f5c1e4176 * 30 );
                            str_extra_info += "<dev string:x157>" + var_a9b8dffd45b33087 + "<dev string:x165>" + var_1a4a0f74fab7dc4 + "<dev string:x169>" + var_9f35e59f5c1e4176 + "<dev string:x165>" + var_6e1f97e6ac822aed + "<dev string:x172>" + var_ece01086c5567dc + "<dev string:x182>";
                        }
                        
                        var_b991f23f9ff3c95e = getanimname( str_anim );
                        
                        if ( isxhashasset( var_b991f23f9ff3c95e ) )
                        {
                            var_b991f23f9ff3c95e = getxhashsourcename( var_b991f23f9ff3c95e );
                        }
                        
                        if ( animislooping( str_anim ) )
                        {
                            str_anim_text = "<dev string:x184>" + var_b991f23f9ff3c95e;
                        }
                        else
                        {
                            str_anim_text = "<dev string:x190>" + var_b991f23f9ff3c95e;
                        }
                        
                        v_print_origin = ent.origin - ( 0, 0, 6 );
                        print3d( v_print_origin, "<dev string:x197>" + ent getentitynumber() + str_type + "<dev string:x1a1>" + ( str_name ?? "<dev string:x1aa>" + ent getentitynumber() ), ( 0.8, 0.8, 0 ), 0.8, 0.2 );
                        print3d( v_print_origin - ( 0, 0, 5 ), str_anim_text, ( 0.8, 0.8, 0 ), 0.8, 0.2 );
                        print3d( v_print_origin - ( 0, 0, 11 ), str_extra_info, ( 0.8, 0.8, 0 ), 0.8, 0.2 );
                        print3d( v_print_origin - ( 0, 0, 17 ), "<dev string:x1b2>" + ent.origin, ( 0.8, 0.8, 0 ), 0.8, 0.2 );
                        ent render_tag( "<dev string:x1bf>" );
                        ent render_tag( "<dev string:x1d0>" );
                        ent render_tag( "<dev string:x1e0>" );
                        ent render_tag( "<dev string:x1f3>" );
                        ent render_tag( "<dev string:x1fe>" );
                        ent render_tag( "<dev string:x209>" );
                        ent render_tag( "<dev string:x213>" );
                        ent render_tag( "<dev string:x21b>", "<dev string:x226>" );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace scene_debug
    // Params 3, eflags: 0x4
    // Checksum 0x84f37627, Offset: 0x14f0
    // Size: 0x8f, Type: dev
    function private render_tag( str_tag, str_label, b_recorder_only )
    {
        if ( !isdefined( str_label ) )
        {
            str_label = str_tag;
        }
        
        v_centroid = self getcentroid();
        v_tag_org = self gettagorigin( str_tag, 1 );
        
        if ( isdefined( v_tag_org ) )
        {
            v_tag_ang = self gettagangles( str_tag );
            anim_origin_render( v_tag_org, v_tag_ang, 2, str_label );
            line( v_centroid, v_tag_org, ( 0.3, 0.3, 0.3 ), 1.25, 1 );
        }
    }

    // Namespace scene_debug
    // Params 4, eflags: 0x4
    // Checksum 0x922193e9, Offset: 0x1587
    // Size: 0xe7, Type: dev
    function private anim_origin_render( org, angles, line_length, str_label )
    {
        if ( isdefined( org ) && isdefined( angles ) )
        {
            if ( !isdefined( line_length ) )
            {
                line_length = 6;
            }
            
            originendpoint = org + anglestoforward( angles ) * line_length;
            originrightpoint = org + anglestoright( angles ) * -1 * line_length;
            originuppoint = org + anglestoup( angles ) * line_length;
            line( org, originendpoint, ( 1, 0, 0 ) );
            line( org, originrightpoint, ( 0, 1, 0 ) );
            line( org, originuppoint, ( 0, 0, 1 ) );
            
            if ( isdefined( str_label ) )
            {
                print3d( org, str_label, ( 1, 0.5, 1 ), 2, 0.05 );
            }
        }
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x6d598741, Offset: 0x1676
    // Size: 0x68, Type: dev
    function private get_ent_type_text()
    {
        str_text = "<dev string:x24>";
        
        if ( isscriptedai( self ) )
        {
            str_text = "<dev string:x22b>";
        }
        else if ( isplayer( self ) )
        {
            str_text = "<dev string:x230>";
        }
        else if ( isdefined( vehicle::get_ref() ) )
        {
            str_text = "<dev string:x239>";
        }
        else
        {
            str_text = "<dev string:x243>" + self.classname + "<dev string:x245>";
        }
        
        return str_text;
    }

    // Namespace scene_debug
    // Params 1
    // Checksum 0xdd6fa0a0, Offset: 0x16e6
    // Size: 0xce9, Type: dev
    function display_scene_menu( str_scene_selected )
    {
        str_type = "<dev string:x247>";
        level notify( #"scene_menu_cleanup" );
        level endon( #"scene_menu_cleanup" );
        waittillframeend();
        names = [];
        b_shot_menu = 0;
        s_scene = undefined;
        
        if ( isstring( str_scene_selected ) )
        {
            s_scene = function_aade29044f6febba( str_scene_selected );
            names = arraycombine( names, s_scene scene::get_shot_names() );
            names[ names.size ] = "<dev string:x24>";
            names[ names.size ] = "<dev string:x24d>";
            names[ names.size ] = "<dev string:x252>";
            names[ names.size ] = "<dev string:x24>";
            names[ names.size ] = "<dev string:x258>";
            str_title = str_scene_selected + "<dev string:x25d>";
            b_shot_menu = 1;
            selected = level.scene_menu_shot_index ?? 0;
        }
        else
        {
            if ( utility::flag( "<dev string:x264>" ) )
            {
                println( "<dev string:x27b>" + str_type + "<dev string:x28d>" );
            }
            
            var_5d9478057df4c3e5 = 1;
            
            foreach ( s_scene in level.a_scene_structs )
            {
                str_scenedef = s_scene.script_scenescriptbundle;
                
                if ( !isdefined( str_scenedef ) )
                {
                    continue;
                }
                
                if ( isxhash( str_scenedef ) )
                {
                    s_scenedef = getscriptbundle( str_scenedef );
                }
                
                if ( !isdefined( s_scenedef ) && isstring( str_scenedef ) )
                {
                    s_scenedef = getscriptbundle( "<dev string:x29c>" + str_scenedef );
                }
                
                if ( !isdefined( s_scenedef ) )
                {
                    continue;
                }
                
                str_scene_menu_name = isdefined( s_scene.var_d69404e803a096ca ) ? str_scenedef + "<dev string:x117>" + s_scene.var_d69404e803a096ca : str_scenedef;
                
                if ( utility::flag( "<dev string:x264>" ) )
                {
                    if ( s_scene scene::get_state() == "<dev string:x2af>" )
                    {
                        names[ names.size ] = str_scene_menu_name;
                        println( "<dev string:x27b>" + str_type + "<dev string:xa9>" + var_5d9478057df4c3e5 + "<dev string:x2b7>" + str_scenedef );
                        var_5d9478057df4c3e5++;
                    }
                    
                    continue;
                }
                
                names[ names.size ] = str_scene_menu_name;
            }
            
            if ( utility::flag( "<dev string:x264>" ) )
            {
                println( "<dev string:x27b>" + str_type + "<dev string:x2be>" );
            }
            
            names = utility::alphabetize( names );
            
            foreach ( str_scene_name in names )
            {
                if ( issubstr( str_scene_name, "<dev string:x2cb>" ) )
                {
                    names = arrayremove( names, str_scene_name );
                    arrayinsert( names, str_scene_name, 0 );
                }
            }
            
            if ( isdefined( level.var_33009922f6ff7446 ) )
            {
                foreach ( str_scene_name in names )
                {
                    if ( issubstr( str_scene_name, level.var_33009922f6ff7446 ) )
                    {
                        names = arrayremove( names, str_scene_name );
                        arrayinsert( names, str_scene_name, 0 );
                    }
                }
            }
            
            names[ names.size ] = "<dev string:x24>";
            names[ names.size ] = "<dev string:x2d0>";
            arrayinsert( names, "<dev string:x24>", 0 );
            arrayinsert( names, "<dev string:x2d5>", 0 );
            str_title = str_type + "<dev string:x182>";
            selected = level.scene_menu_index ?? 0;
        }
        
        if ( selected > names.size - 1 )
        {
            selected = 0;
        }
        
        up_pressed = 0;
        down_pressed = 0;
        held = 0;
        var_d87acc06076b58ca = gettime();
        
        while ( utility::flag( "<dev string:x2f4>" ) )
        {
            if ( !isdefined( level.scene.debug_player ) )
            {
                level.scene.debug_player = level.players[ 0 ];
                waitframe();
                continue;
            }
            
            if ( b_shot_menu )
            {
                if ( isdefined( level.last_scene_state[ str_scene_selected ] ) )
                {
                    str_title = str_scene_selected + "<dev string:x306>" + level.last_scene_state[ str_scene_selected ] + "<dev string:x309>";
                }
            }
            
            scene_list_settext( names, selected, str_title, b_shot_menu, 1 );
            currenttime = gettime();
            pagecount = 10;
            
            if ( currenttime < var_d87acc06076b58ca )
            {
                pagecount = 0;
            }
            
            if ( !up_pressed )
            {
                if ( level.scene.debug_player buttonpressed( "<dev string:x25>" ) || level.scene.debug_player buttonpressed( "<dev string:x37>" ) )
                {
                    up_pressed = 1;
                    selected--;
                    
                    while ( !isdefined( names[ selected ] ) || names[ selected ] == "<dev string:x24>" )
                    {
                        selected--;
                        
                        if ( selected < 0 )
                        {
                            selected = names.size - 1;
                            continue;
                        }
                        
                        if ( selected >= names.size )
                        {
                            selected = 0;
                        }
                    }
                }
            }
            else if ( level.scene.debug_player function_82c6c002c1cbc8d8( "<dev string:x25>" ) || level.scene.debug_player function_82c6c002c1cbc8d8( "<dev string:x37>" ) )
            {
                held = 1;
                selected -= pagecount;
            }
            else if ( !level.scene.debug_player buttonpressed( "<dev string:x25>" ) && !level.scene.debug_player buttonpressed( "<dev string:x37>" ) )
            {
                held = 0;
                up_pressed = 0;
            }
            
            if ( !down_pressed )
            {
                if ( level.scene.debug_player buttonpressed( "<dev string:x2d>" ) || level.scene.debug_player buttonpressed( "<dev string:x3f>" ) )
                {
                    down_pressed = 1;
                    selected++;
                    
                    while ( !isdefined( names[ selected ] ) || names[ selected ] == "<dev string:x24>" )
                    {
                        selected++;
                        
                        if ( selected < 0 )
                        {
                            selected = names.size - 1;
                            continue;
                        }
                        
                        if ( selected >= names.size )
                        {
                            selected = 0;
                        }
                    }
                }
            }
            else if ( level.scene.debug_player function_82c6c002c1cbc8d8( "<dev string:x2d>" ) || level.scene.debug_player function_82c6c002c1cbc8d8( "<dev string:x3f>" ) )
            {
                held = 1;
                selected += pagecount;
            }
            else if ( !level.scene.debug_player buttonpressed( "<dev string:x2d>" ) && !level.scene.debug_player buttonpressed( "<dev string:x3f>" ) )
            {
                held = 0;
                down_pressed = 0;
            }
            
            if ( held )
            {
                if ( selected < 0 )
                {
                    selected = 0;
                }
                else if ( selected >= names.size )
                {
                    selected = names.size - 1;
                }
            }
            else if ( selected < 0 )
            {
                selected = names.size - 1;
            }
            else if ( selected >= names.size )
            {
                selected = 0;
            }
            
            if ( held && pagecount == 10 )
            {
                var_d87acc06076b58ca = gettime() + 500;
            }
            
            if ( names[ selected ] != "<dev string:x2d5>" && names[ selected ] != "<dev string:x2d0>" && !b_shot_menu )
            {
                s_scene = function_aade29044f6febba( names[ selected ] );
            }
            
            if ( level.scene.debug_player buttonpressed( "<dev string:x30b>" ) || level.scene.debug_player buttonpressed( "<dev string:x314>" ) )
            {
                if ( b_shot_menu )
                {
                    while ( level.scene.debug_player buttonpressed( "<dev string:x30b>" ) || level.scene.debug_player buttonpressed( "<dev string:x314>" ) )
                    {
                        waitframe();
                    }
                    
                    level.scene_menu_shot_index = selected;
                    level thread display_scene_menu();
                }
                else
                {
                    level.scene_menu_index = selected;
                    str_debug_cmd = "<dev string:x31b>" + getxhashhexname( @"scr_debug_scene_devgui" ) + "<dev string:x320>";
                    adddebugcommand( str_debug_cmd );
                    return;
                }
            }
            
            if ( names[ selected ] != "<dev string:x2d0>" && names[ selected ] != "<dev string:x2d5>" && !b_shot_menu && isdefined( s_scene ) )
            {
                if ( level.scene.debug_player buttonpressed( "<dev string:x32c>" ) || level.scene.debug_player buttonpressed( "<dev string:x337>" ) )
                {
                    level.scene.debug_player setorigin( s_scene.origin );
                    
                    while ( level.scene.debug_player buttonpressed( "<dev string:x32c>" ) || level.scene.debug_player buttonpressed( "<dev string:x337>" ) )
                    {
                        waitframe();
                    }
                }
                else if ( level.scene.debug_player buttonpressed( "<dev string:x342>" ) || level.scene.debug_player buttonpressed( "<dev string:x34c>" ) )
                {
                    level.scene.debug_player setorigin( s_scene.origin );
                    
                    while ( level.scene.debug_player buttonpressed( "<dev string:x342>" ) || level.scene.debug_player buttonpressed( "<dev string:x34c>" ) )
                    {
                        waitframe();
                    }
                }
            }
            
            if ( b_shot_menu && ( function_6524e946516b534e() || is_init_button_pressed() ) && isdefined( str_scene_selected ) && arraycontains( s_scene scene::get_shot_names(), names[ selected ] ) )
            {
                if ( function_6524e946516b534e() )
                {
                    a_str_shot_names = s_scene scene::get_shot_names();
                    var_8001b0e61b029584 = [];
                    b_found_shot = 0;
                    
                    foreach ( str_shot_name in a_str_shot_names )
                    {
                        if ( str_shot_name != names[ selected ] && !b_found_shot )
                        {
                            continue;
                        }
                        
                        b_found_shot = 1;
                        var_8001b0e61b029584[ var_8001b0e61b029584.size ] = str_shot_name;
                    }
                    
                    s_scene thread scene::play( undefined, var_8001b0e61b029584 );
                }
                else if ( is_init_button_pressed() )
                {
                    s_scene thread scene::init( undefined, names[ selected ] );
                }
                
                while ( is_init_button_pressed() || function_6524e946516b534e() )
                {
                    waitframe();
                }
            }
            else if ( is_confirm_button_pressed() && isdefined( names[ selected ] ) )
            {
                if ( !b_shot_menu && names[ selected ] == "<dev string:x2d5>" )
                {
                    if ( utility::flag( "<dev string:x264>" ) )
                    {
                        utility::flag_clear( "<dev string:x264>" );
                    }
                    else
                    {
                        utility::flag_set( "<dev string:x264>" );
                    }
                    
                    while ( is_confirm_button_pressed() )
                    {
                        waitframe();
                    }
                    
                    level thread display_scene_menu();
                }
                else if ( !b_shot_menu )
                {
                    if ( names[ selected ] == "<dev string:x2d0>" )
                    {
                        str_debug_cmd = "<dev string:x31b>" + getxhashhexname( @"scr_debug_scene_devgui" ) + "<dev string:x320>";
                        adddebugcommand( str_debug_cmd );
                        return;
                    }
                }
                else if ( b_shot_menu )
                {
                    if ( s_scene.var_b8d0b3148ac4e533 )
                    {
                        s_scene.origin = getdvarvector( @"hash_373ad6363da1c230" );
                        s_scene.angles = getdvarvector( @"hash_eab41865eb0e96ea" );
                    }
                    
                    if ( names[ selected ] == "<dev string:x258>" )
                    {
                        level.scene_menu_shot_index = selected;
                        
                        while ( is_confirm_button_pressed() )
                        {
                            waitframe();
                        }
                        
                        level thread display_scene_menu();
                    }
                    else if ( names[ selected ] == "<dev string:x24d>" )
                    {
                        s_scene thread scene::stop();
                    }
                    else if ( names[ selected ] == "<dev string:x252>" )
                    {
                        s_scene thread scene::cleanup( 1 );
                    }
                    else if ( names[ selected ] == "<dev string:x356>" )
                    {
                        s_scene thread scene::init();
                    }
                    else if ( names[ selected ] == "<dev string:x35b>" )
                    {
                        s_scene thread scene::play();
                    }
                    else if ( names[ selected ] != "<dev string:x24>" )
                    {
                        s_scene thread scene::play( undefined, names[ selected ] );
                    }
                }
                
                while ( is_confirm_button_pressed() || function_6524e946516b534e() )
                {
                    waitframe();
                }
                
                if ( !b_shot_menu && names[ selected ] != "<dev string:x24>" )
                {
                    level.scene_menu_index = selected;
                    level thread display_scene_menu( names[ selected ] );
                }
            }
            
            waitframe();
        }
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0x733e72f0, Offset: 0x23d7
    // Size: 0xff, Type: dev
    function private function_aade29044f6febba( str_scene_selected )
    {
        var_64af815746cd2fd0 = strtok( str_scene_selected, "<dev string:x117>" );
        str_scene_selected = var_64af815746cd2fd0[ 0 ];
        var_d69404e803a096ca = var_64af815746cd2fd0[ 1 ];
        
        if ( isdefined( var_d69404e803a096ca ) )
        {
            var_d69404e803a096ca = int( var_d69404e803a096ca );
        }
        
        s_scene = level.a_scene_structs[ 0 ];
        
        foreach ( s_scene_to_use in level.a_scene_structs )
        {
            if ( str_scene_selected == s_scene_to_use.script_scenescriptbundle && ( !isdefined( var_d69404e803a096ca ) || var_d69404e803a096ca == s_scene_to_use.var_d69404e803a096ca ) )
            {
                s_scene = s_scene_to_use;
                break;
            }
        }
        
        return s_scene;
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0x5137c56b, Offset: 0x24de
    // Size: 0x123, Type: dev
    function private scene_menu( params )
    {
        if ( !utility::flag( "<dev string:x2f4>" ) )
        {
            utility::flag_set( "<dev string:x2f4>" );
            level.scene.debug_player val::set( "<dev string:x360>", "<dev string:x36c>", 0 );
            level.scene.debug_player val::set( "<dev string:x360>", "<dev string:x377>", 0 );
            level.scene.debug_player val::set( "<dev string:x360>", "<dev string:x37e>", 0 );
            level thread display_scene_menu();
            return;
        }
        
        utility::flag_clear( "<dev string:x2f4>" );
        level.scene.debug_player val::reset( "<dev string:x360>", "<dev string:x36c>" );
        level.scene.debug_player val::reset( "<dev string:x360>", "<dev string:x377>" );
        level.scene.debug_player val::reset( "<dev string:x360>", "<dev string:x37e>" );
        cleanup_button_hud();
    }

    // Namespace scene_debug
    // Params 5, eflags: 0x4
    // Checksum 0xcb1b82a, Offset: 0x2609
    // Size: 0x50, Type: dev
    function private scene_list_settext( strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5 )
    {
        if ( !utility::flag( "<dev string:x384>" ) )
        {
            thread _scene_list_settext( strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5 );
        }
    }

    // Namespace scene_debug
    // Params 5, eflags: 0x4
    // Checksum 0xb5601018, Offset: 0x2661
    // Size: 0x395, Type: dev
    function private _scene_list_settext( strings, n_selected, str_title, b_shot_menu, var_d7c3bc47919cd2a5 )
    {
        if ( !isdefined( var_d7c3bc47919cd2a5 ) )
        {
            var_d7c3bc47919cd2a5 = 1;
        }
        
        for ( i = 0; i < var_d7c3bc47919cd2a5 ; i++ )
        {
            printtoscreen2d( 100, 260, str_title, ( 1, 1, 1 ), 2 );
            str_mode = "<dev string:x397>";
            
            switch ( str_mode )
            {
                case #"hash_7038dec66d8275be":
                    printtoscreen2d( 100, 290, "<dev string:x39f>", ( 1, 1, 1 ), 2 );
                    break;
                case #"hash_7da50739ef480ecb":
                    break;
                case #"hash_8d4787dcb1802e22":
                    break;
                case #"hash_d48d5b579a6c7c3":
                    break;
            }
            
            for ( i = 0; i < 16 ; i++ )
            {
                index = i + n_selected - 5;
                
                if ( isdefined( strings[ index ] ) )
                {
                    text = strings[ index ];
                }
                else
                {
                    text = "<dev string:x24>";
                }
                
                str_scene = text;
                
                if ( isdefined( level.last_scene_state[ text ] ) )
                {
                    text += "<dev string:x306>" + level.last_scene_state[ text ] + "<dev string:x309>";
                }
                
                if ( i == 5 )
                {
                    text = "<dev string:x3d0>" + text + "<dev string:x3d3>";
                    str_color = ( 0.8, 0.4, 0 );
                }
                else if ( str_scene != "<dev string:x24>" )
                {
                    str_color = ( 0, 1, 0 );
                }
                else
                {
                    str_color = ( 1, 1, 1 );
                }
                
                y_offset = i * 30;
                printtoscreen2d( 86, 350 + y_offset, text, str_color, 2 );
            }
            
            if ( b_shot_menu && !getdvarint( @"hash_303a3f39ecf974db", 0 ) )
            {
                if ( !isdefined( level.scene.var_4b3d13d75ab66180 ) )
                {
                    level.scene.var_4b3d13d75ab66180 = newhudelem();
                }
                
                level.scene.var_4b3d13d75ab66180.alignx = "<dev string:x3d5>";
                level.scene.var_4b3d13d75ab66180.x = 55;
                level.scene.var_4b3d13d75ab66180.y = 250;
                level.scene.var_4b3d13d75ab66180.fontscale = 1;
                level.scene.var_4b3d13d75ab66180.color = ( 1, 1, 1 );
                level.scene.var_4b3d13d75ab66180.horzalign = "<dev string:x3da>";
                level.scene.var_4b3d13d75ab66180.vertalign = "<dev string:x3da>";
                buttonprompttext = "<dev string:x24>";
                
                if ( level.scene.debug_player usinggamepad() )
                {
                    buttonprompttext = "<dev string:x3e5>";
                }
                else
                {
                    buttonprompttext = "<dev string:x448>";
                }
                
                level.scene.var_4b3d13d75ab66180 setdevtext( buttonprompttext );
            }
            else
            {
                cleanup_button_hud();
                printtoscreen2d( 100, 830, "<dev string:x48e>", ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x2479533b, Offset: 0x29fe
    // Size: 0x34, Type: dev
    function private cleanup_button_hud()
    {
        if ( isdefined( level.scene.var_4b3d13d75ab66180 ) )
        {
            level.scene.var_4b3d13d75ab66180 destroy();
        }
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x69cb7b12, Offset: 0x2a3a
    // Size: 0x69, Type: dev
    function private is_confirm_button_pressed()
    {
        if ( level.scene.debug_player buttonpressed( "<dev string:x4b0>" ) || level.scene.debug_player buttonpressed( "<dev string:x4b9>" ) || level.scene.debug_player buttonpressed( "<dev string:x4c2>" ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x71b84dad, Offset: 0x2aab
    // Size: 0x49, Type: dev
    function private function_6524e946516b534e()
    {
        if ( level.scene.debug_player buttonpressed( "<dev string:x4c8>" ) || level.scene.debug_player buttonpressed( "<dev string:x4d1>" ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace scene_debug
    // Params 0, eflags: 0x4
    // Checksum 0x4ef00d57, Offset: 0x2afc
    // Size: 0x49, Type: dev
    function private is_init_button_pressed()
    {
        if ( level.scene.debug_player buttonpressed( "<dev string:x4d3>" ) || level.scene.debug_player buttonpressed( "<dev string:x4dc>" ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0xd0abf7c2, Offset: 0x2b4d
    // Size: 0x2f, Type: dev
    function private function_82c6c002c1cbc8d8( str_button )
    {
        if ( getdvarint( @"hash_66d7268f08facc81", 0 ) )
        {
            return 0;
        }
        
        return self._holding_button[ str_button ];
    }

    // Namespace scene_debug
    // Params 1, eflags: 0x4
    // Checksum 0xe2782c4, Offset: 0x2b84
    // Size: 0xd3, Type: dev
    function private scene_menu_button_held_think( str_button )
    {
        self endon( #"disconnect" );
        
        if ( !isdefined( self._holding_button ) )
        {
            self._holding_button = [];
        }
        
        self._holding_button[ str_button ] = 0;
        time_started = 0;
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            use_time = 250;
            
            if ( self._holding_button[ str_button ] )
            {
                if ( !self buttonpressed( str_button ) )
                {
                    self._holding_button[ str_button ] = 0;
                }
            }
            else if ( self buttonpressed( str_button ) )
            {
                if ( time_started == 0 )
                {
                    time_started = gettime();
                }
                
                if ( gettime() - time_started > use_time )
                {
                    self._holding_button[ str_button ] = 1;
                }
            }
            else if ( time_started != 0 )
            {
                time_started = 0;
            }
            
            waitframe();
        }
    }

    // Namespace scene_debug
    // Params 4
    // Checksum 0x7107bd12, Offset: 0x2c5f
    // Size: 0x3a4, Type: dev
    function tag_thread( tag, size, duration, blendtimesec )
    {
        self endon( #"death_or_disconnect" );
        self notify( "<dev string:x4e1>" + tag );
        self endon( "<dev string:x4e1>" + tag );
        starttime = gettime();
        
        if ( !isdefined( level.debug_tag_colors ) )
        {
            level.debug_tag_colors = [];
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 1, 0, 0 );
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 0, 1, 0 );
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 0, 0, 1 );
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 1, 1, 0 );
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 0, 1, 1 );
            level.debug_tag_colors[ level.debug_tag_colors.size ] = ( 1, 0, 1 );
            level.debug_tag_color = -1;
        }
        
        color = ( 1, 1, 1 );
        blendtimems = 0;
        
        if ( !isdefined( blendtimesec ) )
        {
            level.debug_tag_color = ( level.debug_tag_color + 1 ) % level.debug_tag_colors.size;
            color = level.debug_tag_colors[ level.debug_tag_color ];
        }
        else
        {
            blendtimems = blendtimesec * 1000;
        }
        
        start = gettime();
        
        while ( true )
        {
            waitframe();
            origin = self.origin;
            angles = self.angles;
            
            if ( blendtimems > 0 )
            {
                color = vectorlerp( ( 0, 0, 0 ), ( 1, 1, 1 ), min( 1, float( gettime() - start ) / float( blendtimems ) ) );
            }
            
            if ( tag != "<dev string:x24>" )
            {
                origin = self gettagorigin( tag, 0, 1, 0 );
                angles = self gettagangles( tag, 0, 1, 0 );
                print3d( origin + ( 0, 0, 1 ), tag, ( 1, 1, 1 ), 1, 0.15, 1, 1 );
            }
            else if ( isplayer( self ) )
            {
                origin = self geteye();
                angles = self getplayerangles();
            }
            else
            {
                print3d( origin + ( 0, 0, 1 ), "<dev string:x4f3>", ( 1, 1, 1 ), 1, 0.15, 1, 1 );
            }
            
            line( origin, origin + anglestoforward( angles ) * size, color, 1, 0, duration );
            line( origin, origin + anglestoright( angles ) * size, color * 0.75, 1, 0, duration );
            line( origin, origin + anglestoup( angles ) * size, ( 1, 1, 1 ), 1, 0, duration );
            print3d( origin + ( 0, 0, 5 ), "<dev string:x24>" + self getentitynumber(), ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( origin + ( 0, 0, 10 ), "<dev string:x24>" + gettime() - starttime, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
        }
    }

    // Namespace scene_debug
    // Params 4
    // Checksum 0x194510e7, Offset: 0x300b
    // Size: 0xee, Type: dev
    function object_event( sceneobjectdata, event, origin, angles )
    {
        if ( !getdvarint( @"scr_debug_scene_events", 0 ) )
        {
            return;
        }
        
        filter = getdvar( @"scr_debug_scene_events_filter", "<dev string:x24>" );
        
        if ( filter != "<dev string:x24>" && !issubstr( tolower( filter ), tolower( sceneobjectdata.sceneobject.variant_object.name ) ) && !issubstr( tolower( sceneobjectdata.sceneobject.variant_object.name ), tolower( filter ) ) && !issubstr( tolower( event ), tolower( filter ) ) )
        {
            return;
        }
        
        level thread object_event_thread( sceneobjectdata, event, origin, angles );
    }

    // Namespace scene_debug
    // Params 4, eflags: 0xc
    // Checksum 0xb3956ad8, Offset: 0x3101
    // Size: 0x695, Type: dev
    function private object_event_thread( sceneobjectdata, event, origin, angles )
    {
        self notify( #"hash_f0aa27cecc62b1c3" );
        self endon( #"hash_f0aa27cecc62b1c3" );
        assert( isdefined( sceneobjectdata ) );
        assert( isdefined( event ) );
        assert( isdefined( origin ) );
        assert( isdefined( angles ) );
        
        if ( !isdefined( level.scene_debug_events ) )
        {
            level.scene_debug_events = [];
        }
        
        bucketdistsq = squared( 5 );
        duration = getdvarint( @"scr_debug_scene_events", 0 );
        scale = 0.25;
        step = 4;
        eventlistadd = undefined;
        
        foreach ( eventlist in level.scene_debug_events )
        {
            if ( distancesquared( eventlist.origin, origin ) < bucketdistsq )
            {
                eventlistadd = eventlist;
                break;
            }
        }
        
        if ( !isdefined( eventlistadd ) )
        {
            eventlistadd = spawnstruct();
            eventlistadd.origin = origin;
            eventlistadd.angles = angles;
            eventlistadd.events = [];
            eventlistadd.offset = ( 0, 0, 0 );
            level.scene_debug_events[ level.scene_debug_events.size ] = eventlistadd;
        }
        
        eventadd = spawnstruct();
        eventadd.objectname = sceneobjectdata.sceneobject.variant_object.name;
        eventadd.activeanimation = sceneobjectdata.activeanimation;
        eventadd.scenename = sceneobjectdata.sceneroot.script_scenescriptbundle;
        eventadd.event = event;
        eventadd.origin = origin;
        eventadd.angles = angles;
        eventadd.time = gettime();
        eventlistadd.events[ eventlistadd.events.size ] = eventadd;
        print3d( ( 0, 0, 0 ), "<dev string:x24>", ( 1, 1, 1 ), 1, 1, 1 );
        waitframe();
        
        foreach ( eventlist in level.scene_debug_events )
        {
            drawnorigin = undefined;
            drawnangles = undefined;
            lastscene = undefined;
            lastobject = undefined;
            offset = ( 0, 0, 0 );
            
            for ( i = 0; i < eventlist.events.size ; i++ )
            {
                event = eventlist.events[ i ];
                
                if ( drawnorigin != event.origin || drawnangles != event.angles )
                {
                    drawnorigin = event.origin;
                    drawnangles = event.angles;
                    axis = anglestoaxis( event.angles );
                    line( event.origin, event.origin + axis[ "<dev string:x501>" ] * 10, ( 1, 0, 0 ), 1, 0, duration );
                    line( event.origin, event.origin + axis[ "<dev string:x509>" ] * 10, ( 0, 1, 0 ), 1, 0, duration );
                    line( event.origin, event.origin + axis[ "<dev string:x50f>" ] * 10, ( 0, 0, 1 ), 1, 0, duration );
                }
                
                if ( lastscene != event.scenename )
                {
                    lastscene = event.scenename;
                    print3d( eventlist.origin + offset, lastscene, ( 1, 1, 0 ), 1, scale, duration );
                    offset += ( 0, 0, step );
                }
                
                if ( lastobject != event.objectname )
                {
                    lastobject = event.objectname;
                    offset += ( 0, 0, step * 0.5 );
                    print3d( eventlist.origin + offset, lastobject, ( 0, 1, 1 ), 1, scale, duration );
                    offset += ( 0, 0, step );
                }
                
                print3d( eventlist.origin + offset, event.event + "<dev string:x306>" + event.time + "<dev string:x309>", ( 1, 1, 1 ), 1, scale, duration );
                offset += ( 0, 0, step );
                print3d( eventlist.origin + offset, "<dev string:x24>" + int( event.origin[ 0 ] ) + "<dev string:x90>" + int( event.origin[ 1 ] ) + "<dev string:x90>" + int( event.origin[ 2 ] ), ( 1, 1, 1 ), 1, scale, duration );
                offset += ( 0, 0, step );
                activeanimation = "<dev string:x24>";
                objectname = "<dev string:x24>";
                
                if ( isdefined( event.activeanimation ) )
                {
                    activeanimation = event.activeanimation;
                }
                
                if ( isdefined( event.objectname ) )
                {
                    objectname = event.objectname;
                }
                
                println( "<dev string:x512>" + event.time + "<dev string:x520>" + event.event + "<dev string:x523>" + objectname );
            }
        }
        
        level.scene_debug_events = undefined;
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0x6163ac84, Offset: 0x379e
    // Size: 0x152, Type: dev
    function scene_play_player()
    {
        sceneplay = self;
        sceneroot = sceneplay.sceneroot;
        scenedata = sceneroot.scenedata;
        
        if ( !isdefined( scenedata ) )
        {
            return;
        }
        
        foreach ( sceneobjectindex, var_1d42c5b8ad0adc80 in sceneplay.var_caf7bc39e6b19dd5 )
        {
            sceneobjectdata = scenedata.sceneobjectdata[ sceneobjectindex ];
            
            if ( isplayer( sceneobjectdata.entity ) )
            {
                return sceneobjectdata.entity;
            }
            
            if ( sceneobjectdata.sceneobject.variant_type === "<dev string:x527>" )
            {
                participatingplayers = sceneobjectdata.xcamplayers ?? sceneobjectdata.sceneroot.scenestatic.exclusiveplayers ?? level.players;
                return participatingplayers[ 0 ];
            }
        }
    }

    // Namespace scene_debug
    // Params 1
    // Checksum 0x9650506f, Offset: 0x38f8
    // Size: 0x364, Type: dev
    function function_ba32edc20462b709( shotindex )
    {
        sceneplay = self;
        
        if ( getdvarint( @"hash_f98fc73c88850645", 0 ) )
        {
            sceneroot = sceneplay.sceneroot;
            scenedata = sceneroot.scenedata;
            player = sceneplay scene_play_player();
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            sceneplay function_566e3d31befe1331();
            player.var_7b353d581f4f612c[ 0 ] = newhudelem();
            player.var_7b353d581f4f612c[ 1 ] = newhudelem();
            str_scene_name = sceneroot.script_scenescriptbundle ?? "<dev string:x24>";
            str_shot_name = sceneroot.scenedata.scenescriptbundle.shots[ shotindex ].variant_object.name ?? "<dev string:x24>";
            player.var_7b353d581f4f612c[ 0 ].alignx = "<dev string:x509>";
            player.var_7b353d581f4f612c[ 0 ].aligny = "<dev string:x532>";
            player.var_7b353d581f4f612c[ 0 ].vertalign = "<dev string:x532>";
            player.var_7b353d581f4f612c[ 0 ].horzalign = "<dev string:x509>";
            player.var_7b353d581f4f612c[ 0 ].font = "<dev string:x539>";
            player.var_7b353d581f4f612c[ 0 ].x = -20;
            player.var_7b353d581f4f612c[ 0 ].y = -90;
            player.var_7b353d581f4f612c[ 0 ].fontscale = 1;
            player.var_7b353d581f4f612c[ 0 ].color = ( 0.6, 0.6, 0.6 );
            player.var_7b353d581f4f612c[ 1 ].alignx = "<dev string:x509>";
            player.var_7b353d581f4f612c[ 1 ].aligny = "<dev string:x532>";
            player.var_7b353d581f4f612c[ 1 ].vertalign = "<dev string:x532>";
            player.var_7b353d581f4f612c[ 1 ].horzalign = "<dev string:x509>";
            player.var_7b353d581f4f612c[ 1 ].font = "<dev string:x539>";
            player.var_7b353d581f4f612c[ 1 ].x = -20;
            player.var_7b353d581f4f612c[ 1 ].y = -70;
            player.var_7b353d581f4f612c[ 1 ].fontscale = 1;
            player.var_7b353d581f4f612c[ 1 ].color = ( 0.6, 0.6, 0.6 );
            player.var_7b353d581f4f612c[ 0 ] setdevtext( "<dev string:x119>" + ( isxhashasset( str_scene_name ) ? getxhashsourcename( str_scene_name ) : str_scene_name ) );
            player.var_7b353d581f4f612c[ 1 ] thread function_11162298d42afbc9( sceneplay, str_shot_name, sceneroot.scene_shot_play_time_start );
        }
    }

    // Namespace scene_debug
    // Params 3, eflags: 0xc
    // Checksum 0xff7f8950, Offset: 0x3c64
    // Size: 0x103, Type: dev
    function private function_11162298d42afbc9( sceneplay, shotname, starttime )
    {
        self notify( #"hash_aa55ea9f662220f7" );
        self endon( #"hash_aa55ea9f662220f7" );
        self endon( #"death_or_disconnect" );
        
        while ( isdefined( sceneplay.sceneroot ) )
        {
            shottime = sceneplay.sceneroot scene::shot_get_time( sceneplay.currentshot );
            
            if ( isdefined( shottime ) )
            {
                shottime = "<dev string:x544>" + floor( shottime * 100 );
            }
            else
            {
                shottime = "<dev string:x24>";
            }
            
            if ( isdefined( sceneplay.sceneroot.scene_shot_play_time_start ) )
            {
                shottext = shottime + "<dev string:x547>" + shotname + "<dev string:x54f>" + sceneplay.sceneroot.scene_shot_play_time_start;
            }
            else
            {
                shottext = shottime + "<dev string:x547>" + shotname;
            }
            
            self setdevtext( shottext );
            waitframe();
        }
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0x48731e7e, Offset: 0x3d6f
    // Size: 0x111, Type: dev
    function function_566e3d31befe1331()
    {
        sceneplay = self;
        
        if ( getdvarint( @"hash_f98fc73c88850645", 0 ) )
        {
            sceneroot = sceneplay.sceneroot;
            scenedata = sceneroot.scenedata;
            player = sceneplay scene_play_player();
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            if ( isarray( player.var_7b353d581f4f612c ) )
            {
                foreach ( hud_elem in player.var_7b353d581f4f612c )
                {
                    if ( isdefined( hud_elem ) )
                    {
                        hud_elem destroy();
                    }
                }
                
                player.var_7b353d581f4f612c = function_5713d46873b29625( player.var_7b353d581f4f612c );
            }
        }
    }

    // Namespace scene_debug
    // Params 3
    // Checksum 0xedf6273, Offset: 0x3e88
    // Size: 0x2e7, Type: dev
    function function_bbb480647f4f57ab( shotindexes, duration, cameras )
    {
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        sceneplay = self;
        player = undefined;
        
        if ( getdvarint( @"hash_f98fc73c88850645", 0 ) )
        {
            sceneroot = sceneplay.sceneroot;
            scenedata = sceneroot.scenedata;
            player = sceneplay scene_play_player();
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            player function_b7d86476ccd2b3ea();
            y = -35;
            player.var_af0b696397ddfea3 = [];
            str_scene_name = sceneroot.script_scenescriptbundle ?? "<dev string:x24>";
            
            foreach ( arrayindex, shotindex in shotindexes )
            {
                hudelem = newhudelem();
                str_shot_name = sceneroot.scenedata.scenescriptbundle.shots[ shotindex ].variant_object.name ?? "<dev string:x24>";
                hudelem.alignx = "<dev string:x509>";
                hudelem.aligny = "<dev string:x532>";
                hudelem.vertalign = "<dev string:x532>";
                hudelem.horzalign = "<dev string:x509>";
                hudelem.font = "<dev string:x539>";
                hudelem.x = -25;
                hudelem.y = y;
                hudelem.fontscale = 1;
                hudelem.color = ( 0, 0.6, 0 );
                cameratext = "<dev string:x24>";
                
                if ( isdefined( cameras ) && isdefined( cameras[ arrayindex ] ) )
                {
                    camerapos = cameras[ arrayindex ];
                    cameratext = "<dev string:x557>" + int( camerapos[ 0 ] ) + "<dev string:x90>" + int( camerapos[ 1 ] ) + "<dev string:x90>" + int( camerapos[ 2 ] ) + "<dev string:x55a>";
                }
                
                hudelem setdevtext( cameratext + "<dev string:x55d>" + getxhashsourcename( str_scene_name ) + "<dev string:x56a>" + str_shot_name );
                y -= 20;
                player.var_af0b696397ddfea3[ player.var_af0b696397ddfea3.size ] = hudelem;
            }
        }
        
        if ( duration >= 0 && isdefined( player ) )
        {
            player utility::delaythreadendon( duration, "<dev string:x56e>", &function_b7d86476ccd2b3ea );
        }
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0x2b00da83, Offset: 0x4177
    // Size: 0xaf, Type: dev
    function function_b7d86476ccd2b3ea()
    {
        self notify( #"hash_a5a7cfd99bdbd78d" );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isarray( self.var_af0b696397ddfea3 ) )
        {
            foreach ( hud_elem in self.var_af0b696397ddfea3 )
            {
                if ( isdefined( hud_elem ) )
                {
                    hud_elem destroy();
                }
            }
            
            self.var_af0b696397ddfea3 = undefined;
        }
    }

    // Namespace scene_debug
    // Params 2
    // Checksum 0x55a08ec4, Offset: 0x422e
    // Size: 0x7f, Type: dev
    function function_c4e717374c36ac3( sceneobjectindex, entitytomatch )
    {
        var_c809a3d453c003d6 = getdvarint( @"hash_3bc9bc279e3f772", 0 );
        
        if ( isdefined( entitytomatch ) )
        {
            if ( var_c809a3d453c003d6 && entitytomatch == level.players[ 0 ] )
            {
                if ( var_c809a3d453c003d6 - 1 == sceneobjectindex )
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
        }
        else if ( var_c809a3d453c003d6 )
        {
            if ( var_c809a3d453c003d6 - 1 == sceneobjectindex )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        
        return 0;
    }

    // Namespace scene_debug
    // Params 0
    // Checksum 0xccaf1761, Offset: 0x42b5
    // Size: 0x14a, Type: dev
    function function_24a6aeb21d33a19b()
    {
        assert( isplayer( self ) );
        
        if ( getdvarint( @"scr_debug_scene", 0 ) && getdvarint( @"scr_debug_scene_penetrate", 0 ) )
        {
            hits = trace::player_trace_get_all_results( self.origin + ( 0, 0, 0.01 ), self.origin, undefined, self );
            
            foreach ( hitinfo in hits )
            {
                if ( isent( hitinfo[ "<dev string:x58f>" ] ) )
                {
                    iprintlnbold( "<dev string:x596>" + hitinfo[ "<dev string:x58f>" ] getentitynumber() + ( isdefined( hitinfo[ "<dev string:x58f>" ].model ) ? "<dev string:x5a5>" + hitinfo[ "<dev string:x58f>" ].model : "<dev string:x24>" ) );
                    continue;
                }
                
                if ( getdvarint( @"scr_debug_scene_penetrate", 0 ) > 1 )
                {
                    iprintlnbold( "<dev string:x5ae>" );
                }
            }
        }
    }

#/
