// scripts\common\active_env\lever_platform.gsc  (hash_7ee7c047cbdf9d21.gscc) (size: 3013 Bytes / 0xbc5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6fb011a (3606774042)
// size ...... 3013 (0xbc5)
// includes .. 1   (offset: 0xb45)
// strings ... 7   (offset: 0xb4d)
// dev strs .. 2   (offset: 0xbad)
// exports ... 4   (offset: 0x789)
// cseg ...... 0x11e + 0x66b (0x789)
// imports ... 27  (offset: 0x829)
// animtree1 . 0   (offset: 0xbc5)
// animtree2 . 0   (offset: 0xbc5)
#using scripts\common\utility;

#namespace lever_platform;

// Namespace lever_platform
// Params 0
// Checksum 0x20aad16b, Offset: 0x13c
// Size: 0x207
function lever_platform_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    self.var_e71254ec04ca6697 = self.angles;
    self.angles = ( 0, 0, 0 );
    
    if ( self.code_classname === "script_brushmodel" )
    {
        self setmoveroptimized( 1 );
        self setmoverantilagged( 1 );
        self markkeyframedmover();
        utility::register_moving_platform_ent( self );
        self setmovingplatformdef( "movingplatform_noairtrack" );
    }
    
    self.a_e_children = getentarray( self.target, #targetname );
    
    foreach ( e_child in self.a_e_children )
    {
        switch ( e_child.code_classname )
        {
            case #"hash_102733429cf8175d":
            case #"hash_8040aa10d9cac1e8":
                e_child enablelinkto();
                
                if ( e_child.script_noteworthy === "weight_trigger" )
                {
                    self.weight_trigger = e_child;
                }
                
                break;
            case #"hash_efad986c2d96044e":
                e_child enablelinkto();
                
                if ( e_child.script_noteworthy === "lever_scriptable" )
                {
                    self.var_68cbf87d1d84490b = e_child;
                }
                
                break;
            default:
                e_child forcenetfieldhighlod( 1 );
                e_child setmoveroptimized( 1 );
                e_child setmoverantilagged( 1 );
                e_child markkeyframedmover();
                utility::register_moving_platform_ent( e_child );
                e_child setmovingplatformdef( "movingplatform_noairtrack" );
                break;
        }
        
        e_child linkto( self );
    }
    
    if ( isdefined( self.weight_trigger ) )
    {
        thread lever_platform_logic();
        return;
    }
    
    /#
        logstring( "<dev string:x24>" );
    #/
}

// Namespace lever_platform
// Params 0, eflags: 0x4
// Checksum 0x7d32b99d, Offset: 0x34b
// Size: 0x3c5
function private lever_platform_logic()
{
    level endon( #"game_ended" );
    var_d2965137647c5bb0 = self.script_rotation_speed ?? ( 2, 0, 2 );
    var_c3e8ba4cb2e3409f = self.script_speed_scale ?? 0.5;
    var_3ec959cd1f301936 = self.script_float ?? 200;
    var_8fc7b65931a0a273 = self.script_rotation_amount[ 0 ] ?? -30;
    var_1bed4647f2c16985 = self.script_rotation_amount[ 1 ] ?? 30;
    var_15aeba59319f7b18 = ( 0, 0, 1 );
    n_last_time = gettime();
    var_c42cd12bee9b636c = [ 0, 0, 0 ];
    
    while ( true )
    {
        n_current_time = gettime();
        n_delta_time = ( gettime() - n_last_time ) / 1000;
        n_last_time = n_current_time;
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( var_d2965137647c5bb0[ i ] === 0 )
            {
                continue;
            }
            
            n_weights = 0;
            var_ecca6a97854c49ea = 0;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player istouching( self.weight_trigger ) && ( player isonground() || player ismantling() ) )
                {
                    if ( i == 2 )
                    {
                        var_a2127919e99d1044 = player.origin[ 1 ] - self.weight_trigger.origin[ 1 ];
                    }
                    else
                    {
                        var_a2127919e99d1044 = self.weight_trigger.origin[ i ] - player.origin[ i ];
                    }
                    
                    n_player_weight = 10;
                    
                    if ( player utility::isusingremote() )
                    {
                        if ( player.usingremote === "remote_robot" )
                        {
                            n_player_weight = 30;
                        }
                    }
                    
                    n_torque = n_player_weight * var_a2127919e99d1044;
                    var_ecca6a97854c49ea -= n_torque;
                    n_weights++;
                }
            }
            
            var_ecca6a97854c49ea /= var_3ec959cd1f301936;
            
            if ( n_weights > 0 )
            {
                n_target_angle = clamp( var_ecca6a97854c49ea * var_d2965137647c5bb0[ i ], var_8fc7b65931a0a273, var_1bed4647f2c16985 );
                n_current_angle = lerp( var_c42cd12bee9b636c[ i ], n_target_angle, n_delta_time * var_d2965137647c5bb0[ i ] );
            }
            else
            {
                n_current_angle = lerp( var_c42cd12bee9b636c[ i ], 0, n_delta_time * var_d2965137647c5bb0[ i ] * var_c3e8ba4cb2e3409f );
            }
            
            var_c42cd12bee9b636c[ i ] = n_current_angle;
        }
        
        self.angles = ( var_c42cd12bee9b636c[ 0 ], var_c42cd12bee9b636c[ 1 ], var_c42cd12bee9b636c[ 2 ] );
        
        if ( isdefined( self.var_68cbf87d1d84490b ) )
        {
            for ( i = 0; i < 3 ; i++ )
            {
                if ( var_15aeba59319f7b18[ i ] === 0 )
                {
                    continue;
                }
                
                if ( self.angles[ i ] >= 0 )
                {
                    var_22940d247257fa31 = self.angles[ i ] / var_1bed4647f2c16985;
                }
                else
                {
                    var_22940d247257fa31 = self.angles[ i ] / var_8fc7b65931a0a273;
                }
                
                var_d5fb829d7cf1ed24 = string( round( var_22940d247257fa31, 0.25 ) * 100 );
                
                if ( self.var_68cbf87d1d84490b getscriptableparthasstate( "moving_platform_anim", var_d5fb829d7cf1ed24 ) && self.var_68cbf87d1d84490b getscriptablepartstate( "moving_platform_anim" ) != var_d5fb829d7cf1ed24 )
                {
                    self.var_68cbf87d1d84490b setscriptablepartstate( "moving_platform_anim", var_d5fb829d7cf1ed24 );
                }
            }
        }
        
        waitframe();
        
        /#
        #/
    }
}

/#

    // Namespace lever_platform
    // Params 1, eflags: 0x4
    // Checksum 0x1b04cc96, Offset: 0x718
    // Size: 0x71, Type: dev
    function private debug_draw( value )
    {
        debugtextcolor = ( 0, 0, 1 );
        debugtextscale = 2;
        debugdrawframeduration = 1;
        debugposx = 400;
        debugposy = 1000;
        printtoscreen2d( debugposx, debugposy, "<dev string:x43>" + value, debugtextcolor, debugtextscale, debugdrawframeduration );
    }

#/
