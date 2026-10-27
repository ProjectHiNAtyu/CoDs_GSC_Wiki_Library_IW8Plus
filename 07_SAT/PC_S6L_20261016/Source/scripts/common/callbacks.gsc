// scripts\common\callbacks.gsc  (hash_4c770a9a4ad7659c.gscc) (size: 8689 Bytes / 0x21f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0e08b18 (3772812056)
// size ...... 8689 (0x21f1)
// includes .. 1   (offset: 0x217d)
// strings ... 0   (offset: 0x2185)
// dev strs .. 8   (offset: 0x2185)
// exports ... 48  (offset: 0x15b9)
// cseg ...... 0x58 + 0x1561 (0x15b9)
// imports ... 30  (offset: 0x1d39)
// animtree1 . 0   (offset: 0x21f1)
// animtree2 . 0   (offset: 0x21f1)
#using scripts\common\utility;

#namespace callback;

// Namespace callback
// Params 2
// Checksum 0x5d6ecb8e, Offset: 0x76
// Size: 0xd4
function callback( event, params = {} )
{
    assert( isstruct( params ), "<dev string:x24>" );
    _do_callbacks( level, event, params );
    
    if ( self != level )
    {
        _do_callbacks( self, event, params );
        
        if ( isdefined( self.var_947e48b35db244d1 ) )
        {
            foreach ( callback_template in self.var_947e48b35db244d1 )
            {
                _do_callbacks( callback_template, event, params );
            }
        }
    }
}

// Namespace callback
// Params 3
// Checksum 0xfd86311e, Offset: 0x152
// Size: 0x15d
function response( type, event, params = {} )
{
    assert( isstruct( params ), "<dev string:x24>" );
    eval = function_5f5d84cefece4c79( type, level, event, params );
    
    if ( eval.done == 1 )
    {
        return eval.val;
    }
    
    if ( self != level )
    {
        eval = function_5f5d84cefece4c79( type, self, event, params, eval );
        
        if ( eval.done == 1 )
        {
            return eval.val;
        }
        
        if ( isdefined( self.var_947e48b35db244d1 ) )
        {
            foreach ( callback_template in self.var_947e48b35db244d1 )
            {
                eval = function_5f5d84cefece4c79( type, callback_template, event, params, eval );
                
                if ( eval.done == 1 )
                {
                    return eval.val;
                }
            }
        }
    }
    
    eval = _final_response( type, eval );
    return eval.val;
}

// Namespace callback
// Params 2
// Checksum 0x6c4f6b1, Offset: 0x2b8
// Size: 0x99
function call_on_all_ai( event, params )
{
    ais = getaiarray();
    
    foreach ( ai in ais )
    {
        ai _do_callbacks( ai, event, params );
    }
}

// Namespace callback
// Params 2
// Checksum 0x925421a3, Offset: 0x359
// Size: 0xab
function call_on_all_players( event, params )
{
    players = level.players;
    
    foreach ( player in players )
    {
        player _do_callbacks( level, event, params );
        player _do_callbacks( player, event, params );
    }
}

// Namespace callback
// Params 3, eflags: 0x4
// Checksum 0x9dacf725, Offset: 0x40c
// Size: 0x94
function private _do_callbacks( ent, event, params )
{
    callbacks = ent.callbacks[ event ];
    
    if ( !isdefined( callbacks ) )
    {
        return;
    }
    
    for ( i = 0; i < callbacks.size ; i++ )
    {
        callback_fields = callbacks[ i ];
        callback = callback_fields[ 0 ];
        
        if ( callback_fields.size > 1 )
        {
            self thread [[ callback ]]( params, callback_fields[ 1 ] );
            continue;
        }
        
        self thread [[ callback ]]( params );
    }
}

// Namespace callback
// Params 3, eflags: 0x4
// Checksum 0x4bb8ac73, Offset: 0x4a8
// Size: 0x1f9
function private _evaluate_response( type, value, prev_eval )
{
    switch ( type )
    {
        case 0:
            if ( value == 1 )
            {
                return { #val:1, #done:1 };
            }
            
            break;
        case 1:
            if ( value == 0 )
            {
                return { #val:1, #done:1 };
            }
            
            break;
        case 2:
            if ( value == 0 )
            {
                return { #val:0, #done:1 };
            }
            
            break;
        case 3:
            if ( value == 1 )
            {
                return { #val:0, #done:1 };
            }
            
            break;
        case 4:
            if ( !isdefined( prev_eval.val ) || value > prev_eval.val )
            {
                return { #val:value, #done:0 };
            }
            
            return prev_eval;
        case 5:
            if ( !isdefined( prev_eval.val ) || value < prev_eval.val )
            {
                return { #val:value, #done:0 };
            }
            
            return prev_eval;
        case 6:
            combination = prev_eval.val ?? [];
            combination = arraycombine( combination, value ?? [] );
            return { #val:combination, #done:0 };
        case 7:
            return { #val:structcombine( prev_eval.val, value ), #done:0 };
    }
    
    return { #done:0 };
}

// Namespace callback
// Params 2, eflags: 0x4
// Checksum 0xb8ec2f6b, Offset: 0x6aa
// Size: 0x132
function private _final_response( type, eval )
{
    ret = { #done:0 };
    
    switch ( type )
    {
        case 4:
        case 5:
            ret.val = eval.val ?? 0;
            break;
        case 2:
        case 3:
            ret.val = 1;
            break;
        case 0:
        case 1:
            ret.val = 0;
            break;
        case 6:
            ret.val = eval.val ?? [];
            break;
        case 7:
            ret.val = eval.val ?? spawnstruct();
            break;
        default:
            ret.val = 0;
            break;
    }
    
    return ret;
}

// Namespace callback
// Params 5, eflags: 0x4
// Checksum 0xa6f99c75, Offset: 0x7e5
// Size: 0x114
function private function_5f5d84cefece4c79( type, ent, event, params, prev_eval = { #done:0 } )
{
    profilestart();
    callbacks = ent.callbacks[ event ];
    
    if ( !isdefined( callbacks ) )
    {
        profilestop();
        return prev_eval;
    }
    
    eval = prev_eval;
    
    for ( i = 0; i < callbacks.size ; i++ )
    {
        callback_fields = callbacks[ i ];
        callback = callback_fields[ 0 ];
        
        if ( callback_fields.size > 1 )
        {
            ret = self [[ callback ]]( params, callback_fields[ 1 ] );
        }
        else
        {
            ret = self [[ callback ]]( params );
        }
        
        assert( isdefined( ret ) || callback == &utility::empty_init_func );
        eval = _evaluate_response( type, ret, eval );
        
        if ( eval.done == 1 )
        {
            profilestop();
            return eval;
        }
    }
    
    profilestop();
    return _final_response( type, eval );
}

// Namespace callback
// Params 3
// Checksum 0xc916f290, Offset: 0x902
// Size: 0x172
function add( event, func, s_additional_params )
{
    if ( !isfunction( func ) )
    {
        assertmsg( "<dev string:x5d>" + ( isxhash( event ) ? getxhashsourcename( event ) : event ) + "<dev string:x73>" );
        return;
    }
    
    if ( !isdefined( event ) )
    {
        assertmsg( "<dev string:x90>" );
        return;
    }
    
    if ( !isdefined( self.callbacks[ event ] ) )
    {
        self.callbacks[ event ] = [];
    }
    
    /#
        foreach ( callback in self.callbacks[ event ] )
        {
            if ( isarray( callback ) && callback[ 0 ] == func )
            {
                if ( !isdefined( callback[ 1 ] ) && !isdefined( s_additional_params ) || callback[ 1 ] == s_additional_params )
                {
                    assertmsg( "<dev string:xc0>" + ( isxhash( event ) ? getxhashsourcename( event ) : event ) );
                }
            }
        }
    #/
    
    self.callbacks[ event ][ self.callbacks[ event ].size ] = [ func, s_additional_params ];
}

// Namespace callback
// Params 3
// Checksum 0x25ab586e, Offset: 0xa7c
// Size: 0x3e
function remove( event, func, s_additional_params )
{
    if ( !isdefined( event ) )
    {
        assertmsg( "<dev string:xee>" );
        return;
    }
    
    thread remove_internal( event, func, s_additional_params );
}

// Namespace callback
// Params 4
// Checksum 0x6d0f4eb, Offset: 0xac2
// Size: 0x125, Type: bool
function exists( event, func, s_additional_params, ignore_additional_params )
{
    if ( !isfunction( func ) )
    {
        assertmsg( "<dev string:x5d>" + ( isxhash( event ) ? getxhashsourcename( event ) : event ) + "<dev string:x73>" );
        return false;
    }
    
    if ( !isdefined( event ) )
    {
        assertmsg( "<dev string:x121>" );
        return false;
    }
    
    if ( isdefined( self.callbacks[ event ] ) )
    {
        foreach ( callback in self.callbacks[ event ] )
        {
            if ( callback[ 0 ] == func )
            {
                if ( ignore_additional_params )
                {
                    return true;
                }
                
                if ( !isdefined( callback[ 1 ] ) && !isdefined( s_additional_params ) || callback[ 1 ] == s_additional_params )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace callback
// Params 1
// Checksum 0x6d83e153, Offset: 0xbf0
// Size: 0xc7, Type: bool
function exists_any( event )
{
    if ( level.callbacks[ event ] )
    {
        return true;
    }
    
    if ( self != level )
    {
        if ( self.callbacks[ event ] )
        {
            return true;
        }
        
        if ( self.var_947e48b35db244d1 )
        {
            foreach ( callback_template in self.var_947e48b35db244d1 )
            {
                if ( callback_template.callbacks[ event ] )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace callback
// Params 1
// Checksum 0x756d349a, Offset: 0xcc0
// Size: 0x4b
function get_template( template_name )
{
    if ( !isdefined( level.callback_templates ) )
    {
        level.callback_templates = [];
    }
    
    if ( !isdefined( level.callback_templates[ template_name ] ) )
    {
        level.callback_templates[ template_name ] = {};
    }
    
    return level.callback_templates[ template_name ];
}

// Namespace callback
// Params 1
// Checksum 0x6fe1479c, Offset: 0xd14
// Size: 0x43
function function_99edd620ee45cd95( template_name )
{
    assert( self != level, "<dev string:x15d>" );
    
    if ( !isdefined( self.var_947e48b35db244d1[ template_name ] ) )
    {
        self.var_947e48b35db244d1[ template_name ] = get_template( template_name );
    }
}

// Namespace callback
// Params 1
// Checksum 0x22dd5d8b, Offset: 0xd5f
// Size: 0x4d, Type: bool
function function_494399dbf14431f0( template_name )
{
    return self != level && isdefined( level.callback_templates[ template_name ] ) && isdefined( self.var_947e48b35db244d1[ template_name ] ) && self.var_947e48b35db244d1[ template_name ] == level.callback_templates[ template_name ];
}

// Namespace callback
// Params 3, eflags: 0x4
// Checksum 0xe8b19943, Offset: 0xdb5
// Size: 0x13c
function private function_f01298ee2b91ffee( event, func, s_additional_params )
{
    removed_index = undefined;
    
    if ( isdefined( s_additional_params ) )
    {
        foreach ( index, func_group in self.callbacks[ event ] )
        {
            if ( func_group[ 0 ] == func && isdefined( func_group[ 1 ] ) && func_group[ 1 ] == s_additional_params )
            {
                removed_index = index;
                break;
            }
        }
    }
    else
    {
        foreach ( index, func_group in self.callbacks[ event ] )
        {
            if ( func_group[ 0 ] == func )
            {
                removed_index = index;
                break;
            }
        }
    }
    
    return removed_index;
}

// Namespace callback
// Params 3, eflags: 0x4
// Checksum 0xb183ec28, Offset: 0xefa
// Size: 0x100
function private remove_internal( event, func, s_additional_params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.callbacks[ event ] ) )
    {
        return;
    }
    
    if ( func === #"all" )
    {
        self.callbacks[ event ] = undefined;
        return;
    }
    
    var_d4239310c8dded2f = function_f01298ee2b91ffee( event, func, s_additional_params );
    
    if ( !isdefined( var_d4239310c8dded2f ) )
    {
        return;
    }
    
    self.callbacks[ event ][ var_d4239310c8dded2f ][ 0 ] = &utility::empty_init_func;
    func = &utility::empty_init_func;
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.callbacks[ event ] ) )
    {
        return;
    }
    
    var_d4239310c8dded2f = function_f01298ee2b91ffee( event, func, s_additional_params );
    
    if ( isdefined( var_d4239310c8dded2f ) )
    {
        self.callbacks[ event ][ var_d4239310c8dded2f ] = undefined;
        
        if ( isint( var_d4239310c8dded2f ) )
        {
            function_cdc669dbc8ea2101( self.callbacks[ event ] );
        }
        
        if ( self.callbacks[ event ].size == 0 )
        {
            self.callbacks[ event ] = undefined;
        }
    }
}

// Namespace callback/stance_changed
// Params 1, eflags: 0x24
// Checksum 0xc32c4ba6, Offset: 0x1002
// Size: 0x4e
function private event_handler[stance_changed] stance_changed_callback( params )
{
    if ( !isdefined( params ) || !isdefined( self ) )
    {
        return;
    }
    
    params.isalive = isalive( self );
    params.time = gettime();
    callback( #"stance_changed", params );
}

// Namespace callback/stance_changed_post
// Params 1, eflags: 0x24
// Checksum 0x57b94c27, Offset: 0x1058
// Size: 0x53
function private event_handler[stance_changed_post] stance_changed_post_callback( params )
{
    params.isalive = isalive( self );
    params.time = gettime();
    callback( #"stance_changed_post", params );
    self.laststancechangetime = params.time;
}

// Namespace callback/mantle_begin
// Params 1, eflags: 0x24
// Checksum 0x97260837, Offset: 0x10b3
// Size: 0x1e
function private event_handler[mantle_begin] mantle_begin_callback( params )
{
    callback( #"mantle_begin", params );
}

// Namespace callback/mantle_end
// Params 1, eflags: 0x24
// Checksum 0x58c24cdc, Offset: 0x10d9
// Size: 0x1e
function private event_handler[mantle_end] mantle_end_callback( params )
{
    callback( #"mantle_end", params );
}

// Namespace callback/jump_begin
// Params 1, eflags: 0x24
// Checksum 0x4978beed, Offset: 0x10ff
// Size: 0x1e
function private event_handler[jump_begin] jump_begin_callback( params )
{
    callback( #"jump_begin", params );
}

// Namespace callback/jump_end
// Params 1, eflags: 0x24
// Checksum 0x2a58d080, Offset: 0x1125
// Size: 0x1e
function private event_handler[jump_end] jump_end_callback( params )
{
    callback( #"jump_end", params );
}

// Namespace callback/dtp_begin
// Params 1, eflags: 0x24
// Checksum 0xf49095c0, Offset: 0x114b
// Size: 0x1e
function private event_handler[dtp_begin] dtp_begin_callback( params )
{
    callback( #"dtp_begin", params );
}

// Namespace callback/dtp_end
// Params 1, eflags: 0x24
// Checksum 0x3f3a7b31, Offset: 0x1171
// Size: 0x36
function private event_handler[dtp_end] dtp_end_callback( params = {} )
{
    params.time = gettime();
    callback( #"dtp_end", params );
}

// Namespace callback/player_in_air_begin
// Params 1, eflags: 0x24
// Checksum 0x6f6d6345, Offset: 0x11af
// Size: 0x1e
function private event_handler[player_in_air_begin] player_in_air_begin_callback( params )
{
    callback( #"player_in_air_begin", params );
}

// Namespace callback/player_in_air_end
// Params 1, eflags: 0x24
// Checksum 0x7b2e19f0, Offset: 0x11d5
// Size: 0x1e
function private event_handler[player_in_air_end] player_in_air_end_callback( params )
{
    callback( #"player_in_air_end", params );
}

// Namespace callback/explode
// Params 1, eflags: 0x24
// Checksum 0x48623c8a, Offset: 0x11fb
// Size: 0x1e
function private event_handler[explode] explode_callback( params )
{
    callback( #"explode", params );
}

// Namespace callback/input_type_changed
// Params 1, eflags: 0x24
// Checksum 0xa4a6531b, Offset: 0x1221
// Size: 0x1e
function private event_handler[input_type_changed] input_type_changed_callback( params )
{
    callback( #"input_type_changed", params );
}

// Namespace callback/sprint_begin
// Params 1, eflags: 0x24
// Checksum 0x23abbe81, Offset: 0x1247
// Size: 0x1e
function private event_handler[sprint_begin] sprint_begin_callback( params )
{
    callback( #"sprint_begin", params );
}

// Namespace callback/sprint_end
// Params 1, eflags: 0x24
// Checksum 0xe48c2cfd, Offset: 0x126d
// Size: 0x36
function private event_handler[sprint_end] sprint_end_callback( params = {} )
{
    params.time = gettime();
    callback( #"sprint_end", params );
}

// Namespace callback/sprint_slide_begin
// Params 1, eflags: 0x24
// Checksum 0xd5c5dd94, Offset: 0x12ab
// Size: 0x1e
function private event_handler[sprint_slide_begin] sprint_slide_begin_callback( params )
{
    callback( #"sprint_slide_begin", params );
}

// Namespace callback/sprint_slide_end
// Params 1, eflags: 0x24
// Checksum 0x9d91fdc2, Offset: 0x12d1
// Size: 0x36
function private event_handler[sprint_slide_end] sprint_slide_end_callback( params = {} )
{
    params.time = gettime();
    callback( #"sprint_slide_end", params );
}

// Namespace callback/event_b70217d016f49960
// Params 1, eflags: 0x24
// Checksum 0xcfd74617, Offset: 0x130f
// Size: 0x36
function private event_handler[event_b70217d016f49960] function_5916270813189d5e( params = {} )
{
    params.time = gettime();
    callback( #"hash_3f03a307b9f6e227", params );
}

// Namespace callback/player_ads_end
// Params 1, eflags: 0x24
// Checksum 0x2b14435, Offset: 0x134d
// Size: 0x1e
function private event_handler[player_ads_end] player_ads_end_callback( params )
{
    callback( #"player_ads_end", params );
}

// Namespace callback/player_on_ladder_begin
// Params 1, eflags: 0x24
// Checksum 0xf9db0d33, Offset: 0x1373
// Size: 0x1e
function private event_handler[player_on_ladder_begin] player_on_ladder_begin_callback( params )
{
    callback( #"player_on_ladder_begin", params );
}

// Namespace callback/player_on_ladder_end
// Params 1, eflags: 0x24
// Checksum 0xd76b4f2, Offset: 0x1399
// Size: 0x1e
function private event_handler[player_on_ladder_end] player_on_ladder_end_callback( params )
{
    callback( #"player_on_ladder_end", params );
}

// Namespace callback/event_bb6f8df1716434d4
// Params 1, eflags: 0x24
// Checksum 0x355e2f7b, Offset: 0x13bf
// Size: 0x1e
function private event_handler[event_bb6f8df1716434d4] function_7573185818218bb2( params )
{
    callback( #"hash_1bf3199fda4b9841", params );
}

// Namespace callback/event_8de4d4a7f21f4700
// Params 1, eflags: 0x24
// Checksum 0x9ab6701e, Offset: 0x13e5
// Size: 0x1e
function private event_handler[event_8de4d4a7f21f4700] function_88b54ecc6d6bc1be( params )
{
    callback( #"hash_48d4e39d6de3f7f1", params );
}

// Namespace callback/event_1512c0cb63ead69
// Params 1, eflags: 0x24
// Checksum 0x3897bdef, Offset: 0x140b
// Size: 0x1e
function private event_handler[event_1512c0cb63ead69] function_4e63c03587871f15( params )
{
    callback( #"hash_bfe74b2130bdd498", params );
}

// Namespace callback/noent_volume_trigger_enter
// Params 1, eflags: 0x24
// Checksum 0xd75df601, Offset: 0x1431
// Size: 0x1e
function private event_handler[noent_volume_trigger_enter] function_18b2db9a735f05db( params )
{
    callback( #"noent_volume_trigger_enter", params );
}

// Namespace callback/noent_volume_trigger_exit
// Params 1, eflags: 0x24
// Checksum 0x40f2a473, Offset: 0x1457
// Size: 0x1e
function private event_handler[noent_volume_trigger_exit] noent_volume_trigger_exit_callback( params )
{
    callback( #"noent_volume_trigger_exit", params );
}

// Namespace callback/active_roll_begin
// Params 1, eflags: 0x24
// Checksum 0xedd2fbc8, Offset: 0x147d
// Size: 0x1e
function private event_handler[active_roll_begin] active_roll_begin_callback( params )
{
    callback( #"active_roll_begin", params );
}

// Namespace callback/event_96aca87614d0130c
// Params 1, eflags: 0x24
// Checksum 0xfc556a5, Offset: 0x14a3
// Size: 0x1e
function private event_handler[event_96aca87614d0130c] function_84ca91c635f1331a( params )
{
    callback( #"hash_ad99e3d3c9ff54f1", params );
}

// Namespace callback/wall_jump_begin
// Params 1, eflags: 0x24
// Checksum 0x84610d4e, Offset: 0x14c9
// Size: 0x1e
function private event_handler[wall_jump_begin] wall_jump_begin_callback( params )
{
    callback( #"wall_jump_begin", params );
}

// Namespace callback/wall_jump_end
// Params 1, eflags: 0x24
// Checksum 0x1beda7a9, Offset: 0x14ef
// Size: 0x1e
function private event_handler[wall_jump_end] wall_jump_end_callback( params )
{
    callback( #"wall_jump_end", params );
}

// Namespace callback
// Params 2
// Checksum 0x327f2744, Offset: 0x1515
// Size: 0xa3, Type: bool
function function_2c2c3cf92a917620( event, sequence_step )
{
    if ( isdefined( level.var_330751f04fff2168[ event ] ) )
    {
        foreach ( step in level.var_330751f04fff2168[ event ] )
        {
            if ( step == sequence_step )
            {
                return true;
            }
        }
    }
    
    return false;
}

