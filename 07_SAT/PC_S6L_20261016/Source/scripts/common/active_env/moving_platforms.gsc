// scripts\common\active_env\moving_platforms.gsc  (hash_1f0925d68f1e342a.gscc) (size: 16469 Bytes / 0x4055 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68624325 (1751270181)
// size ...... 16469 (0x4055)
// includes .. 4   (offset: 0x3dd9)
// strings ... 42  (offset: 0x3df9)
// dev strs .. 2   (offset: 0x403d)
// exports ... 33  (offset: 0x2b35)
// cseg ...... 0x566 + 0x25cf (0x2b35)
// imports ... 110 (offset: 0x305d)
// animtree1 . 0   (offset: 0x4055)
// animtree2 . 0   (offset: 0x4055)
#using scripts\common\active_env\utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\trigger;

#namespace moving_platforms;

// Namespace moving_platforms
// Params 1
// Checksum 0x730e7c3d, Offset: 0x584
// Size: 0x5dc
function moving_platforms_init( b_disable_moving_platforms = 0 )
{
    level endon( #"game_ended" );
    utility::flag_init( "moving_platforms_initialized" );
    utility::flag_wait( "scriptables_ready" );
    a_moving_platforms = getentarray( "moving_platform", #script_noteworthy );
    
    foreach ( e_moving_platform in a_moving_platforms )
    {
        /#
            if ( getdvarint( @"hash_c44408646a3564c2", 0 ) )
            {
                if ( e_moving_platform.script_translation_amount == ( 1, 2, 3 ) )
                {
                    e_moving_platform.script_translation_amount = ( 22.8, 0, 0 );
                }
                
                if ( e_moving_platform.script_rotation_amount == ( 1, 2, 3 ) )
                {
                    e_moving_platform.script_rotation_amount = ( 22.8, 0, 0 );
                }
                
                if ( e_moving_platform.script_rotation_speed == ( 1, 2, 3 ) )
                {
                    e_moving_platform.script_rotation_speed = ( 22.8, 0, 0 );
                }
            }
        #/
        
        moving_platform_setup( e_moving_platform );
        
        if ( isdefined( e_moving_platform.targetname ) )
        {
            e_moving_platform.var_bef131da06a9a52e = [];
            e_moving_platform.var_cfee50379361341b = getentarray( e_moving_platform.targetname, #target );
            a_scriptables = getscriptablearray( e_moving_platform.targetname, #target );
            
            if ( a_scriptables.size == 0 )
            {
                a_scriptables = getscriptablearray( e_moving_platform.targetname, #script_noteworthy );
            }
            
            var_56836c41cc824aeb = getentitylessscriptablearray( e_moving_platform.targetname, #target );
            e_moving_platform.a_scriptables = arraycombine( a_scriptables, var_56836c41cc824aeb );
            var_e45ca62c33a8406d = arraycombine( e_moving_platform.var_cfee50379361341b, e_moving_platform.a_scriptables );
            
            foreach ( e_addon in var_e45ca62c33a8406d )
            {
                if ( isent( e_addon ) )
                {
                    if ( e_addon isscriptable() && issubstr( e_moving_platform.script_parameters, "no_linked_scriptables" ) )
                    {
                        moving_platform_setup( e_addon );
                        continue;
                    }
                    
                    moving_platform_setup( e_addon, e_moving_platform );
                }
            }
            
            if ( issubstr( e_moving_platform.script_parameters, "link_arcwire" ) )
            {
                var_653253f3014b4813 = [];
                
                foreach ( scriptable in e_moving_platform.a_scriptables )
                {
                    if ( scriptable getscriptablehaspart( "button" ) || issubstr( scriptable.script_parameters, "moving_platform_button" ) )
                    {
                        var_653253f3014b4813[ var_653253f3014b4813.size ] = scriptable;
                    }
                }
                
                e_moving_platform.a_e_buttons = var_653253f3014b4813;
                e_moving_platform thread function_6af9e780863f1a09();
            }
        }
        
        if ( e_moving_platform.var_d78ee8402fdd6558 )
        {
            e_moving_platform.var_4d10215f783a3d91 = utility::getstruct( e_moving_platform.target, "targetname" );
            
            if ( !isdefined( e_moving_platform.var_4d10215f783a3d91 ) )
            {
                logstring( "Moving platform is set to translate but is not attached to any valid structs" );
                continue;
            }
            
            e_moving_platform.var_2257316b641a53c3 = e_moving_platform.var_4d10215f783a3d91;
            e_moving_platform.b_forward = 1;
            e_moving_platform function_a3b45b9cea6c9739();
            waitframe();
            e_moving_platform function_a3b45b9cea6c9739( 0 );
            e_moving_platform moving_platform_set_origin( e_moving_platform.var_4d10215f783a3d91.origin );
            waitframe();
            e_moving_platform thread function_95710aa5c905e919( 1 );
            e_moving_platform function_a3b45b9cea6c9739();
            continue;
        }
        
        if ( e_moving_platform.var_fcf6651f5d103047 )
        {
            e_moving_platform function_a3b45b9cea6c9739();
            waitframe();
            e_moving_platform function_a3b45b9cea6c9739( 0 );
        }
    }
    
    /#
        if ( isofflinetoolrun( 4 ) )
        {
            return;
        }
    #/
    
    foreach ( e_moving_platform in a_moving_platforms )
    {
        e_moving_platform function_905ce0ef40f861fe();
    }
    
    if ( b_disable_moving_platforms == 0 )
    {
        b_disable_moving_platforms = getdvarint( @"scr_moving_platforms_disable", 0 );
    }
    
    if ( b_disable_moving_platforms )
    {
        return;
    }
    
    foreach ( e_moving_platform in a_moving_platforms )
    {
        e_moving_platform.var_32fb357f1788ddd7 = 0;
        
        if ( !issubstr( e_moving_platform.script_parameters, "no_start" ) )
        {
            moving_platform_activate( e_moving_platform );
        }
    }
    
    utility::flag_set( "moving_platforms_initialized" );
}

// Namespace moving_platforms
// Params 1
// Checksum 0x75b9ac72, Offset: 0xb68
// Size: 0x66
function moving_platform_activate( e_mover )
{
    /#
        if ( isofflinetoolrun( 4 ) )
        {
            return;
        }
    #/
    
    if ( e_mover.script_noteworthy != "moving_platform" )
    {
        logstring( "Calling moving_platform_activate on a non-mover" );
        return;
    }
    
    if ( e_mover.var_d78ee8402fdd6558 )
    {
        e_mover thread moving_platform_logic();
    }
    
    if ( e_mover.var_fcf6651f5d103047 )
    {
        e_mover function_48533745b6d2ca09();
    }
}

// Namespace moving_platforms
// Params 1
// Checksum 0xb0d683ec, Offset: 0xbd6
// Size: 0x25
function moving_platform_set_origin( var_3b79d91bbb07b45 )
{
    if ( self.var_506d5484904ee4b0 == 0 )
    {
        self.origin = var_3b79d91bbb07b45;
    }
}

// Namespace moving_platforms
// Params 1
// Checksum 0xf5dac738, Offset: 0xc03
// Size: 0x25
function function_fc391854ab85ce9a( var_a320ecae04821823 )
{
    if ( self.var_be409590d085d881 == 0 )
    {
        self.angles = var_a320ecae04821823;
    }
}

// Namespace moving_platforms
// Params 0
// Checksum 0x8d8f8dbb, Offset: 0xc30
// Size: 0x64
function function_c7008eecc4f9fc68()
{
    if ( self.script_noteworthy != "moving_platform" )
    {
        logstring( "Entity is not a moving_platform" );
        return;
    }
    
    if ( issubstr( self.script_animation_type, "_pause" ) )
    {
        return ( self.var_32fb357f1788ddd7 != 1 );
    }
    
    if ( issubstr( self.script_parameters, "no_start" ) )
    {
        return ( self.var_32fb357f1788ddd7 != 1 );
    }
    
    return 0;
}

// Namespace moving_platforms
// Params 0
// Checksum 0x6641f985, Offset: 0xc9d
// Size: 0x28
function is_moving_platform_moving()
{
    if ( self.script_noteworthy != "moving_platform" )
    {
        logstring( "Entity is not a moving_platform" );
        return;
    }
    
    return self.var_32fb357f1788ddd7;
}

// Namespace moving_platforms
// Params 0
// Checksum 0x7357e7db, Offset: 0xcce
// Size: 0xbc
function get_moving_platform_ents()
{
    if ( !level.var_982d914e4e9905da )
    {
        var_1534eb4c2eb71098 = [];
        
        foreach ( platform in getentarray( "moving_platform", #script_noteworthy, 1 ) )
        {
            var_1534eb4c2eb71098 = arraycombine( var_1534eb4c2eb71098, platform.var_cfee50379361341b );
        }
        
        level.var_982d914e4e9905da = var_1534eb4c2eb71098;
    }
    
    return level.var_982d914e4e9905da;
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0xc45d5d80, Offset: 0xd93
// Size: 0x4b1
function private moving_platform_setup( e_mover, var_8293dcbfaa9d666e = undefined )
{
    switch ( e_mover.code_classname )
    {
        case #"hash_342450278210465":
        case #"hash_102733429cf8175d":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_d00e4b22d715f1e5":
            if ( isdefined( e_mover.script_noteworthy ) )
            {
                switch ( e_mover.script_noteworthy )
                {
                    case #"hash_5189556aab7779fb":
                        e_mover init_moving_crush_zone( var_8293dcbfaa9d666e );
                        break;
                    case #"hash_72e46202402b724":
                        var_8293dcbfaa9d666e.t_no_equipment_zone = e_mover;
                        break;
                    case #"hash_400bed0e8e40d537":
                        var_8293dcbfaa9d666e.var_86dca9acb681e3b9 = e_mover;
                        trigger::makeenterexittrigger( e_mover, &function_a19b17b205fa734f, &function_276dcf2c21b9a36b );
                        break;
                    case #"hash_be56c51ace81577a":
                        e_mover thread function_37b9d9bb44869f92();
                        break;
                    default:
                        break;
                }
            }
            
            e_mover enablelinkto();
            break;
        case #"hash_efad986c2d96044e":
            e_mover enablelinkto();
            break;
        case #"hash_d582c3286e5c390f":
            break;
        case #"hash_6318af6067faf262":
            if ( isdefined( e_mover.spawnflags ) )
            {
                if ( e_mover.spawnflags > 0 )
                {
                    e_mover.var_1c2692052bde8ec1 = ( e_mover.spawnflags & 4 ) > 0 && e_mover function_43cbc762fd86d084();
                    e_mover.var_9562e5ab1ca5041b = ( e_mover.spawnflags & 1 ) > 0;
                }
            }
            
            if ( issubstr( e_mover.script_parameters, "custom_unresolved" ) )
            {
                e_mover.unresolved_collision_func = &moving_platform_unresolved_collision;
            }
        default:
            e_mover forcenetfieldhighlod( 1 );
            e_mover setmoveroptimized( 1 );
            e_mover setmoverantilagged( 1 );
            e_mover markkeyframedmover();
            
            if ( !isdefined( e_mover.script_noteworthy ) )
            {
                e_mover.script_noteworthy = "train_";
            }
            
            utility::register_moving_platform_ent( e_mover );
            var_8eea36d5c48ff4e = e_mover.script_label ?? "defaultmovingplatform";
            e_mover setmovingplatformdef( var_8eea36d5c48ff4e );
            
            if ( !isdefined( e_mover.script_animation_type ) )
            {
                e_mover.script_animation_type = "default";
            }
            
            break;
    }
    
    if ( isdefined( e_mover.script_translation_amount ) )
    {
        e_mover.var_d78ee8402fdd6558 = 1;
    }
    
    if ( isdefined( e_mover.target ) )
    {
        if ( isdefined( utility::getstruct( e_mover.target, "targetname" ) ) )
        {
            e_mover.var_d78ee8402fdd6558 = 1;
        }
    }
    
    e_mover.var_fcf6651f5d103047 = isdefined( e_mover.script_rotation_amount );
    e_mover.var_506d5484904ee4b0 = issubstr( e_mover.script_parameters, "dont_translate" ) ?? 0;
    e_mover.var_be409590d085d881 = issubstr( e_mover.script_parameters, "dont_rotate" ) ?? 0;
    e_mover.var_75024a4c962bff6 = issubstr( e_mover.script_parameters, "dont_undock" ) ?? 0;
    e_mover.var_eb84564e35b49310 = issubstr( e_mover.script_parameters, "dont_follow_parent" ) ?? 0;
    
    if ( issubstr( e_mover.script_parameters, "no_deploy" ) )
    {
        e_mover setnodeploy( 1 );
    }
    
    if ( issubstr( e_mover.script_parameters, "no_solid" ) ?? 0 )
    {
        e_mover.var_6ba8f9601c0df935 = 1;
        e_mover notsolid();
    }
    
    e_mover.b_train = issubstr( e_mover.script_parameters, "train_method" );
    e_mover.b_train = !issubstr( e_mover.script_parameters, "dont_use_train_method" );
    e_mover.b_hider = issubstr( e_mover.script_parameters, "hide_on_repeat" );
    e_mover.b_waittill_matchstart_countdown = issubstr( e_mover.script_parameters, "waittill_matchstart_countdown" );
    
    if ( isdefined( var_8293dcbfaa9d666e ) )
    {
        if ( e_mover.var_eb84564e35b49310 != 1 )
        {
            e_mover linkto( var_8293dcbfaa9d666e );
        }
        
        e_mover.var_8293dcbfaa9d666e = var_8293dcbfaa9d666e;
        e_mover.angles_local = ( 0, 0, 0 );
        
        if ( e_mover.var_1c2692052bde8ec1 == 1 )
        {
            var_8293dcbfaa9d666e.var_bef131da06a9a52e[ var_8293dcbfaa9d666e.var_bef131da06a9a52e.size ] = e_mover;
        }
    }
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0x8ee95c70, Offset: 0x124c
// Size: 0x122
function private function_8f96975c524664da( s_new_state = undefined, node )
{
    var_40726c5330aca026 = self.a_scriptables;
    
    if ( isdefined( node ) )
    {
        var_a6bf7d023596d07c = getscriptablearray( node.target, #script_noteworthy );
        var_70587d32467fc945 = getentitylessscriptablearray( node.target, #targetname );
        var_40726c5330aca026 = arraycombine( self.a_scriptables, var_a6bf7d023596d07c, var_70587d32467fc945 );
    }
    
    foreach ( scr_scriptable in var_40726c5330aca026 )
    {
        if ( scr_scriptable getscriptablehaspart( "moving_platform_anim" ) && scr_scriptable getscriptableparthasstate( "moving_platform_anim", s_new_state ) )
        {
            scr_scriptable setscriptablepartstate( "moving_platform_anim", s_new_state );
        }
    }
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0xfd2ce612, Offset: 0x1376
// Size: 0x15
function private moving_platform_unresolved_collision( hitent, penetration )
{
    
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x6c164c2b, Offset: 0x1393
// Size: 0xcf
function private function_2c609c4cbad28cb5( var_9ea9a8e279fdc278 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( var_9ea9a8e279fdc278 ) )
    {
        logstring( "No starting struct" );
        return;
    }
    
    var_87a7d2f7ace0dacf[ var_9ea9a8e279fdc278.targetname ] = var_9ea9a8e279fdc278;
    
    for ( var_10ffed65d47596bd = var_9ea9a8e279fdc278.targetname; isdefined( var_87a7d2f7ace0dacf[ var_10ffed65d47596bd ].target ) ; var_10ffed65d47596bd = e_add.targetname )
    {
        e_add = utility::getstruct( var_87a7d2f7ace0dacf[ var_10ffed65d47596bd ].target, "targetname" );
        
        if ( !isdefined( e_add ) )
        {
            logstring( "Invalid target to continue building moving platform track" );
            return;
        }
        
        if ( arraycontains( var_87a7d2f7ace0dacf, e_add ) )
        {
            break;
        }
        
        var_87a7d2f7ace0dacf[ e_add.targetname ] = e_add;
    }
    
    return var_87a7d2f7ace0dacf;
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0xdff9ae12, Offset: 0x146b
// Size: 0x50
function private check_struct()
{
    if ( !isdefined( self.b_stop_here ) )
    {
        self.b_stop_here = issubstr( self.script_parameters, "stop_here" );
    }
    
    if ( !isdefined( self.b_activate_on_move_end ) )
    {
        self.b_activate_on_move_end = issubstr( self.script_parameters, "activate_on_move_end" );
    }
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0xaba32827, Offset: 0x14c3
// Size: 0xf8
function private function_127f554b17124ed9( name, type )
{
    a_structs = utility::getstructarray( name, type );
    a_structs_temp = a_structs;
    
    foreach ( struct in a_structs_temp )
    {
        if ( struct.script_noteworthy == "moving_platform" )
        {
            a_structs = arrayremove( a_structs, struct );
            continue;
        }
        
        struct check_struct();
    }
    
    switch ( a_structs.size )
    {
        case 0:
            return;
        case 1:
            return a_structs[ 0 ];
    }
    
    return a_structs[ randomintrange( 0, a_structs.size ) ];
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0x38eadf3d, Offset: 0x15c4
// Size: 0x68c
function private moving_platform_logic()
{
    level endon( #"game_ended" );
    utility::flag_wait( "moving_platforms_initialized" );
    
    if ( self.b_waittill_matchstart_countdown === 1 && level.prematchperiodend > 0 && game_utility_mp::isfirstround() )
    {
        level waittill( #"match_start_real_countdown" );
    }
    
    self notify( #"move_started" );
    var_dcc20d8cba0de47d = self.script_translation_amount ?? ( 100, 0, 0 );
    self.var_32fb357f1788ddd7 = 1;
    thread moving_platform_loop_sound( self.script_soundalias );
    thread function_95710aa5c905e919();
    self.var_2257316b641a53c3 check_struct();
    
    if ( self.var_2257316b641a53c3.b_activate_on_move_end == 0 )
    {
        function_88916c49c51b12c3( self.var_2257316b641a53c3 );
    }
    
    if ( self.script_delay > 0 )
    {
        wait self.script_delay;
    }
    
    function_a3b45b9cea6c9739( 0 );
    function_fc2c079e0dfce5cb();
    function_8f96975c524664da( "move_started" );
    
    while ( self.var_32fb357f1788ddd7 )
    {
        n_move_time = ( 3, 0, 0 );
        str_destination_struct_name = undefined;
        
        if ( self.b_forward && isdefined( self.var_2257316b641a53c3.target ) )
        {
            str_destination_struct_name = self.var_2257316b641a53c3.target;
        }
        else if ( self.b_forward == 0 && isdefined( self.var_2257316b641a53c3.targetname ) )
        {
            var_dc869111caef831f = function_127f554b17124ed9( self.var_2257316b641a53c3.targetname, "target" );
            str_destination_struct_name = var_dc869111caef831f.targetname;
        }
        
        var_6a080d2f4d4833b1 = undefined;
        
        if ( isdefined( str_destination_struct_name ) )
        {
            var_6a080d2f4d4833b1 = function_127f554b17124ed9( str_destination_struct_name, "targetname" );
        }
        
        if ( isdefined( var_6a080d2f4d4833b1 ) && self.b_stop_here != 1 )
        {
            if ( isdefined( var_6a080d2f4d4833b1.script_translation_amount ) )
            {
                self.script_translation_amount = var_6a080d2f4d4833b1.script_translation_amount;
                var_dcc20d8cba0de47d = var_6a080d2f4d4833b1.script_translation_amount;
            }
            
            if ( isdefined( var_6a080d2f4d4833b1.script_translation_time ) )
            {
                n_move_time = var_6a080d2f4d4833b1.script_translation_time;
            }
            else if ( isdefined( var_dcc20d8cba0de47d ) )
            {
                n_move_time = ( distance( var_6a080d2f4d4833b1.origin, self.origin ) / var_dcc20d8cba0de47d[ 0 ], var_dcc20d8cba0de47d[ 1 ], var_dcc20d8cba0de47d[ 2 ] );
                
                if ( n_move_time[ 0 ] < n_move_time[ 1 ] + n_move_time[ 2 ] )
                {
                    /#
                        logstring( "<dev string:x24>" + var_6a080d2f4d4833b1.name + "<dev string:x2a>" );
                    #/
                    
                    n_half_move_time = n_move_time[ 0 ] * 0.5;
                    n_move_time = ( n_move_time[ 0 ], n_half_move_time, n_half_move_time );
                }
            }
            
            if ( isdefined( var_6a080d2f4d4833b1.script_string ) )
            {
                self notify( var_6a080d2f4d4833b1.script_string );
            }
            
            if ( isdefined( var_6a080d2f4d4833b1.script_delay ) )
            {
                if ( var_6a080d2f4d4833b1.script_delay > 0 )
                {
                    wait var_6a080d2f4d4833b1.script_delay;
                }
            }
            
            if ( isdefined( var_6a080d2f4d4833b1.script_start_state ) )
            {
                function_8f96975c524664da( var_6a080d2f4d4833b1.script_start_state, var_6a080d2f4d4833b1 );
            }
            
            if ( var_6a080d2f4d4833b1.script_wait > 0 )
            {
                wait var_6a080d2f4d4833b1.script_wait;
            }
            
            if ( n_move_time[ 0 ] > 0 )
            {
                if ( self.var_506d5484904ee4b0 == 0 )
                {
                    if ( self.b_train == 0 )
                    {
                        self moveto( var_6a080d2f4d4833b1.origin, n_move_time[ 0 ], n_move_time[ 1 ], n_move_time[ 2 ] );
                    }
                    else
                    {
                        thread utility::translate_to( var_6a080d2f4d4833b1.origin, n_move_time[ 0 ], n_move_time[ 1 ], n_move_time[ 2 ] );
                    }
                }
                
                if ( self.var_be409590d085d881 == 0 )
                {
                    if ( !self.var_fcf6651f5d103047 )
                    {
                        if ( isdefined( self.var_2257316b641a53c3.script_rotation_amount ) && isdefined( var_6a080d2f4d4833b1.script_rotation_amount ) )
                        {
                            self rotateby( self.var_2257316b641a53c3.script_rotation_amount - var_6a080d2f4d4833b1.script_rotation_amount, n_move_time[ 0 ], n_move_time[ 1 ], n_move_time[ 2 ] );
                        }
                        else if ( isdefined( var_6a080d2f4d4833b1.angles ) )
                        {
                            self rotateto( var_6a080d2f4d4833b1.angles, n_move_time[ 0 ], n_move_time[ 1 ], n_move_time[ 2 ] );
                        }
                    }
                }
                
                wait n_move_time[ 0 ];
                
                if ( var_6a080d2f4d4833b1.script_delay_post > 0 )
                {
                    wait var_6a080d2f4d4833b1.script_delay_post;
                }
                
                self notify( #"translate_stop" );
                moving_platform_set_origin( var_6a080d2f4d4833b1.origin );
            }
            
            if ( var_6a080d2f4d4833b1.b_activate_on_move_end == 0 )
            {
                function_88916c49c51b12c3( var_6a080d2f4d4833b1 );
            }
            
            self.b_stop_here = var_6a080d2f4d4833b1.b_stop_here;
            self.var_2257316b641a53c3 = var_6a080d2f4d4833b1;
            continue;
        }
        
        self.b_stop_here = 0;
        
        switch ( self.script_animation_type )
        {
            case #"hash_924bab4626a58894":
                self.var_32fb357f1788ddd7 = 0;
            case #"hash_6d4d432c60462639":
            case #"hash_cb20eda5e00181ef":
                self.b_forward = !self.b_forward;
                waitframe();
                break;
            case #"hash_5a5258bc356b0b1d":
                self.var_32fb357f1788ddd7 = 0;
            case #"hash_95a3137e230e34e8":
                function_11344aca26a33e11( 0 );
                
                if ( isdefined( self.var_4d10215f783a3d91 ) )
                {
                    moving_platform_set_origin( self.var_4d10215f783a3d91.origin );
                    
                    if ( isdefined( self.var_4d10215f783a3d91.script_rotation_amount ) )
                    {
                        function_fc391854ab85ce9a( self.var_4d10215f783a3d91.script_rotation_amount );
                    }
                    else if ( isdefined( self.var_4d10215f783a3d91.angles ) )
                    {
                        function_fc391854ab85ce9a( self.var_4d10215f783a3d91.angles );
                    }
                }
                
                self.var_2257316b641a53c3 = self.var_4d10215f783a3d91;
                waitframe();
                function_11344aca26a33e11( 1 );
                break;
            default:
                self.var_32fb357f1788ddd7 = 0;
                waitframe();
                break;
        }
    }
    
    if ( self.var_2257316b641a53c3.b_activate_on_move_end == 1 )
    {
        function_88916c49c51b12c3( self.var_2257316b641a53c3 );
    }
    
    function_a3b45b9cea6c9739();
    waitframe();
    function_8f96975c524664da( "move_ended" );
    self notify( #"move_ended" );
    thread function_95710aa5c905e919( 1 );
    function_ad1c0b3b61523b63( self.var_2257316b641a53c3.script_start_state );
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x4175e0e, Offset: 0x1c58
// Size: 0x10a
function private get_struct_attachments( var_5990ce3727e634d1 )
{
    a_s_attachments = getentarray( var_5990ce3727e634d1.target, #targetname );
    
    if ( isdefined( var_5990ce3727e634d1.target2 ) )
    {
        var_5db43e5842ec611f = getentarray( var_5990ce3727e634d1.target2, #targetname );
        a_s_attachments = arraycombine( a_s_attachments, var_5db43e5842ec611f );
    }
    
    var_52febfb12401d085 = a_s_attachments;
    
    foreach ( struct in var_52febfb12401d085 )
    {
        if ( struct.script_noteworthy != "moving_platform" )
        {
            a_s_attachments = arrayremove( a_s_attachments, struct );
        }
    }
    
    if ( a_s_attachments.size > 0 )
    {
        return a_s_attachments;
    }
    
    return [];
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x317d2697, Offset: 0x1d6a
// Size: 0xbb
function private function_88916c49c51b12c3( var_f9af5886dd8b5910 )
{
    if ( !isdefined( var_f9af5886dd8b5910 ) )
    {
        logstring( "undefined struct" );
        return;
    }
    
    if ( !isdefined( var_f9af5886dd8b5910.a_s_attachments ) )
    {
        var_f9af5886dd8b5910.a_s_attachments = get_struct_attachments( var_f9af5886dd8b5910 );
    }
    
    foreach ( e_mover in var_f9af5886dd8b5910.a_s_attachments )
    {
        moving_platform_activate( e_mover );
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x138504c3, Offset: 0x1e2d
// Size: 0x73
function private moving_platform_loop_sound( str_sndalias )
{
    level endon( #"game_ended" );
    self endon( #"move_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( str_sndalias ) )
    {
        return;
    }
    
    if ( !soundexists( str_sndalias ) )
    {
        return;
    }
    
    var_520303cc736f6f2d = lookupsoundlength( str_sndalias ) / 1000;
    var_520303cc736f6f2d -= 1;
    
    while ( true )
    {
        self playsoundonmovingent( str_sndalias );
        wait var_520303cc736f6f2d;
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x65d942, Offset: 0x1ea8
// Size: 0x15b
function private function_11344aca26a33e11( var_c91f26ce3738add1 = 1 )
{
    var_960996f704772d98 = [];
    var_960996f704772d98 = arraycombine( self.var_cfee50379361341b, self.a_scriptables );
    var_960996f704772d98[ var_960996f704772d98.size ] = self;
    
    foreach ( e_check in var_960996f704772d98 )
    {
        if ( !e_check.b_hider )
        {
            continue;
        }
        
        switch ( e_check.code_classname )
        {
            case #"hash_3872eb7d97592cac":
            case #"hash_6318af6067faf262":
                if ( !var_c91f26ce3738add1 )
                {
                    e_check hide();
                    e_check notsolid();
                }
                else if ( var_c91f26ce3738add1 )
                {
                    e_check show();
                    
                    if ( self.var_6ba8f9601c0df935 != 1 )
                    {
                        e_check solid();
                    }
                }
                
                break;
            case #"hash_d5db7a2cf51228e4":
                if ( !var_c91f26ce3738add1 )
                {
                    e_check hide();
                }
                else if ( var_c91f26ce3738add1 )
                {
                    e_check show();
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0x2575ae34, Offset: 0x200b
// Size: 0x90
function private function_48533745b6d2ca09()
{
    switch ( self.script_animation_type )
    {
        case #"hash_e2c1aa5e565a538f":
            thread function_8a142ef80d25c294();
            break;
        case #"hash_7bbd660a0ef1a992":
            thread function_8a142ef80d25c294( 1 );
            break;
        case #"hash_96e0eede98a01485":
            thread function_8a142ef80d25c294( 0, 1 );
            break;
        case #"hash_dac7d62cc377c033":
        default:
            self rotatevelocity( self.script_rotation_amount, 999999 );
            thread function_95710aa5c905e919();
            break;
    }
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0x51d635a2, Offset: 0x20a3
// Size: 0x155
function private function_8a142ef80d25c294( b_pingpong = 0, var_fa076175b0704894 = 0 )
{
    level endon( #"game_ended" );
    utility::flag_wait( "moving_platforms_initialized" );
    n_swap = 1;
    
    while ( true )
    {
        if ( self.script_wait > 0 )
        {
            wait self.script_wait;
        }
        
        if ( self.var_8293dcbfaa9d666e.var_fcf6651f5d103047 || self.var_8293dcbfaa9d666e.var_d78ee8402fdd6558 )
        {
            var_27d80119963bf9b3 = angleclamp( self.angles );
            self function_3c97e081f6ee49ef( var_27d80119963bf9b3 );
            self function_f137e973856d34d9( self.script_rotation_amount * n_swap, self.script_rotation_speed[ 0 ], self.script_rotation_speed[ 1 ], self.script_rotation_speed[ 2 ] );
        }
        else
        {
            self rotateby( self.script_rotation_amount * n_swap, self.script_rotation_speed[ 0 ], self.script_rotation_speed[ 1 ], self.script_rotation_speed[ 2 ] );
        }
        
        thread function_95710aa5c905e919();
        wait self.script_rotation_speed[ 0 ];
        self notify( #"move_ended" );
        
        if ( var_fa076175b0704894 )
        {
            return;
        }
        
        if ( b_pingpong )
        {
            n_swap *= -1;
        }
    }
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0x7a4d09ba, Offset: 0x2200
// Size: 0x15
function private function_a19b17b205fa734f( var_fd3a9f9e9a2a06c2, trigger )
{
    
}

// Namespace moving_platforms
// Params 2, eflags: 0x4
// Checksum 0x81c4de25, Offset: 0x221d
// Size: 0x2f
function private function_276dcf2c21b9a36b( var_fd3a9f9e9a2a06c2, trigger )
{
    if ( isplayer( var_fd3a9f9e9a2a06c2 ) && isalive( var_fd3a9f9e9a2a06c2 ) )
    {
        var_fd3a9f9e9a2a06c2 function_a4a572d8d09b0f46();
    }
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0xfc33308b, Offset: 0x2254
// Size: 0xc5
function private function_37b9d9bb44869f92()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( e_player in level.players )
        {
            if ( e_player istouching( self ) )
            {
                if ( isdefined( self.var_8293dcbfaa9d666e ) )
                {
                    if ( self.var_8293dcbfaa9d666e is_moving_platform_moving() === 0 )
                    {
                        moving_platform_activate( self.var_8293dcbfaa9d666e );
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0x8350bb4f, Offset: 0x2321
// Size: 0x18a
function private function_6af9e780863f1a09()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"activate", e_instance );
        
        if ( isdefined( e_instance.entity ) )
        {
            if ( !arraycontains( self.a_e_buttons, e_instance.entity ) )
            {
                continue;
            }
        }
        else if ( !arraycontains( self.a_e_buttons, e_instance ) )
        {
            continue;
        }
        
        if ( function_c7008eecc4f9fc68() )
        {
            foreach ( e_button in self.a_e_buttons )
            {
                e_button setscriptablepartstate( "arcwire_transmitter", "activate" );
            }
            
            moving_platform_activate( self );
            self waittill( #"move_ended" );
            
            foreach ( e_button in self.a_e_buttons )
            {
                e_button setscriptablepartstate( "arcwire_transmitter", "standby" );
            }
        }
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x7bfc3ca7, Offset: 0x24b3
// Size: 0x13e
function private init_moving_crush_zone( var_8293dcbfaa9d666e )
{
    utility::function_9fc28d50a2652cd7( self );
    self.b_crush_on_notify = issubstr( self.script_parameters, "crush_on_notify" );
    var_8293dcbfaa9d666e.t_crush_zone = self;
    var_a24255d3bf12b5b3 = getentarray( self.targetname, #script_noteworthy );
    
    foreach ( t_zone in var_a24255d3bf12b5b3 )
    {
        if ( t_zone.targetname == "crush_zone" )
        {
            utility::function_9fc28d50a2652cd7( t_zone );
            
            if ( self.b_crush_on_notify )
            {
                str_notify_start = self.script_notify_start ?? "move_started";
                str_notify_stop = self.script_notify_stop ?? "move_ended";
                t_zone thread crush_on_notify( var_8293dcbfaa9d666e, str_notify_start, str_notify_stop );
                continue;
            }
            
            t_zone thread utility::function_6949f16f10cfdbee( self );
        }
    }
}

// Namespace moving_platforms
// Params 3, eflags: 0x4
// Checksum 0x25980080, Offset: 0x25f9
// Size: 0x7c
function private crush_on_notify( e_moving_platform, str_start_notify, str_end_notify )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        e_moving_platform waittill( str_start_notify );
        thread utility::function_6949f16f10cfdbee( e_moving_platform.t_crush_zone );
        e_moving_platform.t_crush_zone thread utility::function_6949f16f10cfdbee( self );
        e_moving_platform waittill( str_end_notify );
        thread utility::function_9074f7fdf422f8e5();
        e_moving_platform.t_crush_zone thread utility::function_9074f7fdf422f8e5();
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0xeede403a, Offset: 0x267d
// Size: 0xe6
function private function_a3b45b9cea6c9739( b_dock = 1 )
{
    if ( self.var_75024a4c962bff6 && b_dock === 0 )
    {
        return;
    }
    
    if ( self.var_1c2692052bde8ec1 == 1 )
    {
        if ( b_dock )
        {
            self dockmovingplatform( undefined );
        }
        else
        {
            self undockmovingplatform();
        }
    }
    
    foreach ( var_638e726058526a61 in self.var_bef131da06a9a52e )
    {
        if ( var_638e726058526a61.var_1c2692052bde8ec1 == 1 )
        {
            if ( b_dock )
            {
                var_638e726058526a61 dockmovingplatform( undefined );
                continue;
            }
            
            var_638e726058526a61 undockmovingplatform();
        }
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0xd5c59ef1, Offset: 0x276b
// Size: 0x100
function private function_95710aa5c905e919( b_run_once = 0 )
{
    level endon( #"game_ended" );
    self endon( #"move_ended" );
    
    while ( true )
    {
        b_updated = 0;
        
        if ( self.var_9562e5ab1ca5041b )
        {
            updatenavobstaclebyent( self );
            b_updated = 1;
        }
        
        if ( isdefined( self.var_cfee50379361341b ) )
        {
            foreach ( e_addon in self.var_cfee50379361341b )
            {
                if ( e_addon.var_9562e5ab1ca5041b )
                {
                    updatenavobstaclebyent( e_addon );
                    b_updated = 1;
                    waitframe();
                }
            }
        }
        
        if ( b_updated == 0 || b_run_once )
        {
            return;
        }
        
        wait 0.25;
    }
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0x32ce026a, Offset: 0x2873
// Size: 0x144
function private function_905ce0ef40f861fe()
{
    var_649bd7a692215a5 = getnodearray( self.targetname, #script_noteworthy );
    self.var_649bd7a692215a5 = var_649bd7a692215a5;
    
    if ( self.var_649bd7a692215a5.size > 0 )
    {
        self.var_37ab0d1f64aeef32 = 1;
        
        foreach ( node_navlink in self.var_649bd7a692215a5 )
        {
            if ( node_navlink.script_label === "moving_platform_navlink" )
            {
                node_navlink.var_838768d0a007b57e = getnode( node_navlink.target, #targetname );
                
                if ( isdefined( self.var_4d10215f783a3d91.script_start_state ) && isdefined( node_navlink.script_start_state ) )
                {
                    if ( self.var_4d10215f783a3d91.script_start_state != node_navlink.script_start_state )
                    {
                        continue;
                    }
                }
                
                function_81791428bfb178c3( node_navlink );
            }
        }
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x8032dd80, Offset: 0x29bf
// Size: 0xaf
function private function_ad1c0b3b61523b63( var_e05fb90ee8210c5 = undefined )
{
    foreach ( node_navlink in self.var_649bd7a692215a5 )
    {
        if ( !isdefined( node_navlink.script_start_state ) || node_navlink.script_start_state === var_e05fb90ee8210c5 )
        {
            function_81791428bfb178c3( node_navlink );
        }
    }
}

// Namespace moving_platforms
// Params 1, eflags: 0x4
// Checksum 0x8cfba093, Offset: 0x2a76
// Size: 0x3e
function private function_81791428bfb178c3( node_navlink )
{
    createnavlink( node_navlink.target, node_navlink.origin, node_navlink.var_838768d0a007b57e.origin, node_navlink );
}

// Namespace moving_platforms
// Params 0, eflags: 0x4
// Checksum 0xb3b90c58, Offset: 0x2abc
// Size: 0x79
function private function_fc2c079e0dfce5cb()
{
    foreach ( node_navlink in self.var_649bd7a692215a5 )
    {
        destroynavlink( node_navlink );
    }
}

