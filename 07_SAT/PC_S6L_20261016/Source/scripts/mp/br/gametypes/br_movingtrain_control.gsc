// scripts\mp\br\gametypes\br_movingtrain_control.gsc  (hash_4c7d391995b649f4.gscc) (size: 13149 Bytes / 0x335d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xefc0c3b8 (4022387640)
// size ...... 13149 (0x335d)
// includes .. 5   (offset: 0x3041)
// strings ... 38  (offset: 0x3069)
// dev strs .. 4   (offset: 0x332d)
// exports ... 36  (offset: 0x2031)
// cseg ...... 0x2f6 + 0x1d3b (0x2031)
// imports ... 84  (offset: 0x25d1)
// animtree1 . 0   (offset: 0x335d)
// animtree2 . 0   (offset: 0x335d)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_movingtrain;

#namespace br_movingtrain_control;

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x32570b3e, Offset: 0x314
// Size: 0x76
function init()
{
    level.wztrain_info.var_243e82181262a708 = getmatchrulesdata( "brData", "trainControlsEnabled" );
    
    if ( !function_1fd15c7b0e2117bf() )
    {
        return;
    }
    
    function_57f9402eb03e1163();
    scriptable::scriptable_addusedcallback( &function_9c62d3c050c3c376 );
    utility::registersharedfunc( #"br_movingtrain_control", #"hash_7db603b46356b014", &function_1fd15c7b0e2117bf );
    
    /#
        br_dev::registerhandlecommand( &handledevcommand_br );
    #/
    
    thread function_b5f2494da414f521();
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x5a98e8b, Offset: 0x392
// Size: 0x37
function function_57f9402eb03e1163()
{
    level.wztrain_info.var_2796947cc924309a = [];
    level.wztrain_info.var_2796947cc924309a[ "cargo_train" ] = function_f8b5cddb25b4378c();
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x130a62a5, Offset: 0x3d1
// Size: 0x295
function function_b5f2494da414f521()
{
    level endon( #"game_ended" );
    waitframe();
    br_movingtrain::function_846cc1006a2b6187( &after_state_changed );
    
    foreach ( train_name, controls in level.wztrain_info.var_2796947cc924309a )
    {
        thread function_899372e00f82dac1( train_name );
        animent = level.wztrain_info.animent[ train_name ];
        
        if ( isdefined( animent ) && controls.backwards_anim )
        {
            animent.backwards = 1;
        }
    }
    
    utility::flag_wait( "wztrain_anim_playing" );
    
    foreach ( train_name, controls in level.wztrain_info.var_2796947cc924309a )
    {
        function_ae1eb2ae5193bdc7( train_name );
        train_engine_model = level.wztrain_info.trains[ train_name ][ 0 ].linked_model;
        train_engine_model setscriptablepartstate( "train_control_horn", "moving" );
        
        if ( train_engine_model getscriptablehaspart( "train_part" ) )
        {
            train_engine_model setscriptablepartstate( "train_part", "moving" );
        }
        
        level thread function_dc07a62c8b96e4b4( controls, level.wztrain_info.trains[ train_name ] );
    }
    
    /#
        if ( getdvarint( @"hash_2c16009ad16f1d64", 0 ) )
        {
            foreach ( train_name, train_cars in level.wztrain_info.trains )
            {
                if ( !isdefined( level.wztrain_info.var_2796947cc924309a[ train_name ] ) )
                {
                    continue;
                }
                
                train_cars[ 0 ] thread function_be804d2a92b95302();
                train_cars[ train_cars.size - 1 ] thread function_c3dacc4fb3c35d5d();
            }
        }
    #/
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x1e275a9f, Offset: 0x66e
// Size: 0xb2
function function_f8b5cddb25b4378c()
{
    controls = spawnstruct();
    controls.var_5950ad72c654d5c1 = getdvarfloat( @"hash_d29dc09dffa5807", 0.208 );
    controls.accel_rate_brake = getdvarfloat( @"hash_f2e7d1767a506f1b", 0.6 );
    controls.speeds = [ 0, 0.5 ];
    controls.var_166548aa4c56b006 = 1;
    controls.backwards_anim = getdvarint( @"hash_aafd86e488bc3ce5", 1 );
    controls.var_fb51f3ed5c725df3 = "free";
    controls.is_reversed = 0;
    return controls;
}

// Namespace br_movingtrain_control
// Params 1, eflags: 0x4
// Checksum 0xc1659610, Offset: 0x729
// Size: 0x5b
function private function_899372e00f82dac1( train_name )
{
    level endon( #"game_ended" );
    locomotive = level.wztrain_info.trains[ train_name ][ 0 ];
    
    while ( true )
    {
        locomotive waittill( #"reset_train_controls" );
        function_20a8a8be9bfff54b( train_name );
    }
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0x239176fb, Offset: 0x78c
// Size: 0xd3
function function_939d93f81dd497f8( train_name, delay_seconds )
{
    level endon( #"game_ended" );
    controls = level.wztrain_info.var_2796947cc924309a[ train_name ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    now = gettime();
    reset_time_ms = now + delay_seconds * 1000;
    
    if ( controls.reset_time_ms > reset_time_ms )
    {
        return;
    }
    
    controls.reset_time_ms = reset_time_ms;
    locomotive = level.wztrain_info.trains[ train_name ][ 0 ];
    locomotive notify( #"hash_d7229f9365ff1306" );
    locomotive endon( #"hash_d7229f9365ff1306" );
    wait delay_seconds;
    function_20a8a8be9bfff54b( train_name );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xc337fe5a, Offset: 0x867
// Size: 0xbf
function function_20a8a8be9bfff54b( train_name )
{
    controls = level.wztrain_info.var_2796947cc924309a[ train_name ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    controls.var_fb51f3ed5c725df3 = "free";
    controls.is_reversed = 0;
    controls.var_166548aa4c56b006 = 1;
    function_ae1eb2ae5193bdc7( train_name );
    update_train_control_speed( train_name, controls.var_5950ad72c654d5c1 );
    
    if ( isplayer( controls.var_7f0813166105b1c6 ) )
    {
        controls.var_7f0813166105b1c6 br_movingtrain::train_analytics( 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0, 1 );
        controls.var_7f0813166105b1c6 = undefined;
    }
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0x606826e8, Offset: 0x92e
// Size: 0xd2
function function_2fffa9277773181a( train, state )
{
    controls = level.wztrain_info.var_2796947cc924309a[ train ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    if ( controls.var_fb51f3ed5c725df3 == state )
    {
        return;
    }
    
    controls.var_fb51f3ed5c725df3 = state;
    
    if ( getdvarint( @"hash_4eee316904a2408c", 0 ) == 1 )
    {
        if ( state == "free" )
        {
            br_movingtrain::function_ac8978ea16dce139( train, "dx_br_jpbm_wztr_trco_brdi", 1 );
        }
        else if ( state == "engaged" )
        {
            br_movingtrain::function_ac8978ea16dce139( train, "dx_br_jpbm_wztr_trco_brtr", 1 );
        }
    }
    
    update_train_control_speed( train, controls.accel_rate_brake );
    function_ae1eb2ae5193bdc7( train );
    after_state_changed( train );
}

// Namespace br_movingtrain_control
// Params 6
// Checksum 0xe6e95d62, Offset: 0xa08
// Size: 0x358
function function_9c62d3c050c3c376( instance, part, state, player, bautouse, usestring )
{
    if ( !function_73913502ebbdc224( part ) )
    {
        return;
    }
    
    train = function_64ba8944824abaab( instance );
    
    if ( !isdefined( train ) )
    {
        return;
    }
    
    controls = level.wztrain_info.var_2796947cc924309a[ train ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    var_ae92e29f72bd691 = part;
    var_e66ebd0043d4d769 = player;
    var_657a06e7f6e2bb9f = 0;
    player thread function_9b225ea9697355e2();
    
    if ( part == "train_control_horn" )
    {
        instance function_dc4453c351e7eed9( "train_control_horn" );
        level thread train_control_horn_anim( train );
        player br_movingtrain::train_analytics( 0, 0, 1 );
        var_657a06e7f6e2bb9f = 1;
    }
    else if ( part == "train_control_brake" )
    {
        if ( controls.var_fb51f3ed5c725df3 == "engaged" )
        {
            function_2fffa9277773181a( train, "free" );
            
            if ( controls.var_166548aa4c56b006 != 0 )
            {
                function_e639f8407b0632a7( train, "train_accelerate" );
            }
        }
        else
        {
            function_2fffa9277773181a( train, "engaged" );
            
            if ( controls.var_166548aa4c56b006 != 0 )
            {
                function_e639f8407b0632a7( train, "handbrake_engaged" );
            }
        }
        
        player br_movingtrain::train_analytics( 0, 0, 0, 1 );
        var_657a06e7f6e2bb9f = 1;
    }
    else if ( controls.var_fb51f3ed5c725df3 == "engaged" )
    {
        /#
            announcement( train + "<dev string:x24>" );
        #/
    }
    else
    {
        if ( part == "train_control_speed" )
        {
            if ( controls.var_166548aa4c56b006 == 0 )
            {
                controls.var_166548aa4c56b006 = 1;
                
                if ( getdvarint( @"hash_4eee316904a2408c", 0 ) == 1 )
                {
                    br_movingtrain::function_ac8978ea16dce139( train, "dx_br_jpbm_wztr_trco_acce", 1 );
                }
                
                function_e639f8407b0632a7( train, "train_accelerate" );
            }
            else
            {
                controls.var_166548aa4c56b006 = 0;
                
                if ( getdvarint( @"hash_4eee316904a2408c", 0 ) == 1 )
                {
                    br_movingtrain::function_ac8978ea16dce139( train, "dx_br_jpbm_wztr_trco_stop", 1 );
                }
                
                function_e639f8407b0632a7( train, "train_brake" );
            }
            
            player br_movingtrain::train_analytics( 0, 1 );
        }
        else if ( part == "train_control_direction" )
        {
            controls.is_reversed = !controls.is_reversed;
            function_a49c7bd0c046fe5a( train, controls.var_166548aa4c56b006 );
            player br_movingtrain::train_analytics( 1 );
        }
        
        controls.var_166548aa4c56b006 = abs( controls.var_166548aa4c56b006 ) * ( controls.is_reversed ? -1 : 1 );
        update_train_control_speed( train, controls.var_5950ad72c654d5c1 );
        var_657a06e7f6e2bb9f = 1;
    }
    
    reset_delay_seconds = getdvarfloat( @"hash_a54fa6f96163c9ec", 240 );
    
    if ( reset_delay_seconds >= 0 && var_657a06e7f6e2bb9f && function_9f9fe5e83f0ec0b8( part ) )
    {
        level thread function_939d93f81dd497f8( train, reset_delay_seconds );
    }
    
    controls.var_7f0813166105b1c6 = player;
    traincar = instance.entity.linked_brush;
    traincar notify( #"hash_2d2b2ea86eccd5fd", var_ae92e29f72bd691, var_e66ebd0043d4d769, var_657a06e7f6e2bb9f );
}

// Namespace br_movingtrain_control
// Params 2, eflags: 0x4
// Checksum 0xd49bd791, Offset: 0xd68
// Size: 0xa1
function private update_train_control_speed( train_name, accelerationrate )
{
    controls = level.wztrain_info.var_2796947cc924309a[ train_name ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    targetrate = utility::sign( controls.var_166548aa4c56b006 ) * controls.speeds[ int( abs( controls.var_166548aa4c56b006 ) ) ];
    
    if ( controls.var_fb51f3ed5c725df3 == "engaged" )
    {
        targetrate = 0;
    }
    
    level thread train_change_speed( train_name, accelerationrate, targetrate );
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x632eab78, Offset: 0xe11
// Size: 0x133
function function_9b225ea9697355e2()
{
    self endon( #"death_or_disconnect" );
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    self giveandfireoffhand( weapobj );
    nearbyplayers = getplayersandaiarrayinradius( self.origin, 40 );
    
    foreach ( player in nearbyplayers )
    {
        vehicle_allowplayeruse( player, 0 );
    }
    
    wait 1.17;
    
    foreach ( player in nearbyplayers )
    {
        vehicle_allowplayeruse( player, 1 );
    }
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xb15c2b1f, Offset: 0xf4c
// Size: 0x126
function train_control_speed( train )
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_anim_playing" );
    function_ae1eb2ae5193bdc7( train );
    
    /#
        control = level.wztrain_info.var_2796947cc924309a[ train ];
        
        if ( !isdefined( control ) )
        {
            return;
        }
        
        while ( true )
        {
            wait 1;
            targetrate = getdvarfloat( @"scr_br_train_control_speed", -2 );
            
            if ( targetrate != -2 )
            {
                targetrate = clamp( targetrate, -1, 1 );
                
                if ( !control.backwards_anim )
                {
                    targetrate = max( targetrate, 0 );
                }
                
                level thread train_change_speed( train, control.var_5950ad72c654d5c1, targetrate );
                announcement( "<dev string:x47>" + train + "<dev string:x53>" + targetrate );
                setdvar( @"scr_br_train_control_speed", -2 );
            }
            
            if ( getdvarint( @"scr_br_train_control_horn", 0 ) > 0 )
            {
                level thread br_movingtrain::function_bf1d85d685c88631( train );
                setdvar( @"scr_br_train_control_horn", 0 );
            }
        }
    #/
}

// Namespace br_movingtrain_control
// Params 3
// Checksum 0xe6369303, Offset: 0x107a
// Size: 0x289
function train_change_speed( train, accelerationrate, targetrate )
{
    level endon( #"game_ended" );
    level notify( #"train_change_speed" );
    level endon( #"train_change_speed" );
    currentrate = level.wztrain_info.animrate[ train ];
    animent = level.wztrain_info.animent[ train ];
    animtoplay = animent.anim_override;
    animref = level.scr_anim[ train ][ animtoplay ];
    
    if ( isarray( animref ) )
    {
        animref = level.scr_anim[ train ][ animtoplay ][ 0 ];
    }
    
    car_array = level.wztrain_info.trains[ train ];
    
    if ( currentrate != 0 )
    {
        foreach ( traincar in car_array )
        {
            temp = traincar.linked_model getlinkedscriptableinstance();
            
            if ( traincar.linked_model getscriptablehaspart( "train_speed_vfx" ) )
            {
                traincar.linked_model setscriptablepartstate( "train_speed_vfx", "slowing" );
            }
        }
    }
    
    while ( true )
    {
        currentrate = br_movingtrain::function_d4c2c525ba9de151( train, accelerationrate, targetrate );
        function_ae1eb2ae5193bdc7( train );
        
        if ( currentrate == targetrate )
        {
            break;
        }
        
        waitframe();
    }
    
    var_59fd9738cd084720 = "stopped";
    
    if ( currentrate != 0 )
    {
        var_59fd9738cd084720 = "moving";
    }
    
    foreach ( traincar in car_array )
    {
        if ( traincar.linked_model getscriptablehaspart( "train_speed_vfx" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_speed_vfx", var_59fd9738cd084720 );
        }
    }
    
    br_movingtrain::function_e2ce3bada3bdf46f( train, targetrate );
    function_ae1eb2ae5193bdc7( train );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xef575626, Offset: 0x130b
// Size: 0x26d
function function_ae1eb2ae5193bdc7( train )
{
    last_index = level.wztrain_info.trains[ train ].size - 1;
    train_engine_model = level.wztrain_info.trains[ train ][ 0 ].linked_model;
    var_e69d40c4f909c4ad = level.wztrain_info.trains[ train ][ last_index ].linked_model;
    controls = level.wztrain_info.var_2796947cc924309a[ train ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    var_3442e99f343c46cd = controls.var_166548aa4c56b006;
    reversedsetting = controls.is_reversed;
    
    if ( function_1fd15c7b0e2117bf() )
    {
        if ( controls.var_fb51f3ed5c725df3 == "locked_gas" && br_circle::function_6bf5d4e680297398( train_engine_model.origin ) )
        {
            train_engine_model function_6798e622fa4214e9( "train_control_speed" );
        }
        else if ( controls.var_fb51f3ed5c725df3 == "engaged" )
        {
            train_engine_model function_dc4453c351e7eed9( "train_control_speed" );
        }
        else if ( var_3442e99f343c46cd != 0 )
        {
            train_engine_model function_f6a1840deee3c881( "train_control_speed" );
        }
        else
        {
            train_engine_model function_a677e20007fcb50e( "train_control_speed" );
        }
        
        if ( controls.var_fb51f3ed5c725df3 == "engaged" )
        {
            train_engine_model function_dc4453c351e7eed9( "train_control_direction" );
        }
        else if ( !reversedsetting )
        {
            train_engine_model function_f6a1840deee3c881( "train_control_direction" );
        }
        else
        {
            train_engine_model function_a677e20007fcb50e( "train_control_direction" );
        }
        
        if ( controls.var_fb51f3ed5c725df3 == "locked_gas" && br_circle::function_6bf5d4e680297398( train_engine_model.origin ) )
        {
            var_e69d40c4f909c4ad function_6798e622fa4214e9( "train_control_brake" );
        }
        else if ( controls.var_fb51f3ed5c725df3 == "engaged" )
        {
            var_e69d40c4f909c4ad function_f6a1840deee3c881( "train_control_brake" );
        }
        else
        {
            var_e69d40c4f909c4ad function_579f34f25cd84de( "train_control_brake" );
        }
    }
    
    var_554c03965085ddd4 = train_engine_model getscriptablepartstate( "train_control_horn" );
    
    if ( var_554c03965085ddd4 != "locked" )
    {
        speed_state = var_3442e99f343c46cd != 0 ? "moving" : "stopped";
        train_engine_model setscriptablepartstate( "train_control_horn", speed_state );
    }
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xb06095a3, Offset: 0x1580
// Size: 0x1a
function function_f6a1840deee3c881( part )
{
    function_df5e435e1b8bb90d( part, "active" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0x42218579, Offset: 0x15a2
// Size: 0x1a
function function_20dfd60fe6459606( part )
{
    function_df5e435e1b8bb90d( part, "inactive" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xf106995b, Offset: 0x15c4
// Size: 0x1a
function function_579f34f25cd84de( part )
{
    function_df5e435e1b8bb90d( part, "neutral" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0x42218579, Offset: 0x15e6
// Size: 0x1a
function function_a677e20007fcb50e( part )
{
    function_df5e435e1b8bb90d( part, "inverted" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0x97f2e381, Offset: 0x1608
// Size: 0x1a
function function_e458d557ab90672e( part )
{
    function_df5e435e1b8bb90d( part, "saturated" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xb06095a3, Offset: 0x162a
// Size: 0x1a
function function_dc4453c351e7eed9( part )
{
    function_df5e435e1b8bb90d( part, "locked" );
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xd7525048, Offset: 0x164c
// Size: 0x1a
function function_6798e622fa4214e9( part )
{
    function_df5e435e1b8bb90d( part, "locked_gas" );
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0x4f003f9d, Offset: 0x166e
// Size: 0x48
function function_df5e435e1b8bb90d( part, state )
{
    train_scriptable = self;
    
    if ( isdefined( train_scriptable ) && train_scriptable getscriptablehaspart( part ) && train_scriptable getscriptableparthasstate( part, state ) )
    {
        train_scriptable setscriptablepartstate( part, state );
    }
}

// Namespace br_movingtrain_control
// Params 1, eflags: 0x4
// Checksum 0x7b7b61ba, Offset: 0x16be
// Size: 0x1a9
function private after_state_changed( train_name )
{
    controls = level.wztrain_info.var_2796947cc924309a[ train_name ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    car_array = level.wztrain_info.trains[ train_name ];
    currentspeed = abs( level.wztrain_info.animrate[ train_name ] );
    is_moving = currentspeed > 0;
    
    switch ( controls.var_fb51f3ed5c725df3 )
    {
        case #"hash_a8f0b714fb0cb53b":
            var_1f7f1d36234d8e68 = "free";
            break;
        case #"hash_457675bf573bc05e":
            var_1f7f1d36234d8e68 = is_moving ? "engaged_moving" : "engaged_stopped";
            break;
        case #"hash_1a60086c17c232a3":
            var_1f7f1d36234d8e68 = is_moving ? "cut_moving" : "cut_stopped";
            break;
    }
    
    foreach ( traincar in car_array )
    {
        if ( traincar.linked_model getscriptablehaspart( "train_brakes_vfx" ) && controls.var_fb51f3ed5c725df3 != "locked_gas" )
        {
            traincar.linked_model setscriptablepartstate( "train_brakes_vfx", var_1f7f1d36234d8e68 );
        }
    }
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0xd7c74045, Offset: 0x186f
// Size: 0x120
function function_e639f8407b0632a7( train_name, var_2e462ef4144837ff )
{
    car_array = level.wztrain_info.trains[ train_name ];
    assert( isarray( car_array ), "<dev string:x70>" );
    
    if ( !isarray( level.wztrain_info.var_3206c7c1f5d6745f ) )
    {
        level.wztrain_info.var_3206c7c1f5d6745f = [];
    }
    
    train_state = level.wztrain_info.var_3206c7c1f5d6745f[ train_name ];
    
    if ( isstring( train_state ) && train_state == var_2e462ef4144837ff )
    {
        return;
    }
    else
    {
        level.wztrain_info.var_3206c7c1f5d6745f[ train_name ] = var_2e462ef4144837ff;
    }
    
    i = 0;
    
    while ( i < car_array.size )
    {
        traincar = car_array[ i ];
        
        if ( traincar.linked_model getscriptablehaspart( "train_control_sfx" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_control_sfx", var_2e462ef4144837ff );
        }
        
        i += 2;
    }
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0x74697436, Offset: 0x1997
// Size: 0x8c
function train_control_horn_anim( train_name )
{
    wait 1.2;
    currentrate = level.wztrain_info.animrate[ train_name ];
    train_engine_model = level.wztrain_info.trains[ train_name ][ 0 ].linked_model;
    speed_state = currentrate != 0 ? "moving" : "stopped";
    train_engine_model setscriptablepartstate( "train_control_horn", speed_state );
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0xcbf83a4b, Offset: 0x1a2b
// Size: 0x42
function function_a49c7bd0c046fe5a( train_name, var_16f111d1330e0aac )
{
    if ( var_16f111d1330e0aac != 0 )
    {
        function_e639f8407b0632a7( train_name, "train_brake" );
        utility::delaythread( 3, &function_e639f8407b0632a7, train_name, "train_accelerate" );
    }
}

// Namespace br_movingtrain_control
// Params 2
// Checksum 0x1d5dcb8f, Offset: 0x1a75
// Size: 0x15e
function function_dc07a62c8b96e4b4( controls, train )
{
    if ( !getdvarint( @"hash_424b8a3a18e485d6", 1 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    train_engine = train[ 0 ];
    animent = level.wztrain_info.animent[ train_engine.train_name ];
    
    while ( !animent.animtimeset )
    {
        waitframe();
    }
    
    while ( true )
    {
        var_4458abc9f49612b7 = train_engine.linked_model getscriptablepartstate( "train_control_speed" );
        
        if ( br_circle::function_6bf5d4e680297398( train_engine.origin ) )
        {
            if ( controls.var_166548aa4c56b006 == 0 || controls.var_fb51f3ed5c725df3 == "engaged" )
            {
                function_20a8a8be9bfff54b( train_engine.train_name );
            }
            
            train_engine.linked_model function_6798e622fa4214e9( "train_control_speed" );
            function_2fffa9277773181a( train_engine.train_name, "locked_gas" );
        }
        else if ( var_4458abc9f49612b7 == "locked_gas" )
        {
            train_engine.linked_model function_f6a1840deee3c881( "train_control_speed" );
            function_2fffa9277773181a( train_engine.train_name, "free" );
        }
        
        wait 5;
    }
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0x2415316a, Offset: 0x1bdb
// Size: 0x10a
function function_64ba8944824abaab( var_4993ef06e9f3cb3a )
{
    foreach ( train_name, var_233545411267fe52 in level.wztrain_info.trains )
    {
        foreach ( var_228a18bdb3e08e22 in var_233545411267fe52 )
        {
            if ( var_4993ef06e9f3cb3a.entity == var_228a18bdb3e08e22.linked_model )
            {
                return train_name;
            }
        }
    }
}

// Namespace br_movingtrain_control
// Params 1
// Checksum 0xcd0b85eb, Offset: 0x1cee
// Size: 0x38, Type: bool
function function_73913502ebbdc224( part )
{
    return part == "train_control_speed" || part == "train_control_direction" || part == "train_control_horn" || part == "train_control_brake";
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0xefdaffc6, Offset: 0x1d2f
// Size: 0x23, Type: bool
function function_1fd15c7b0e2117bf()
{
    return level.wztrain_info.var_243e82181262a708 && !level.var_64a2b866ed206e9e;
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x21ee9f54, Offset: 0x1d5b
// Size: 0x17, Type: bool
function function_13cb3bb98562c75f()
{
    if ( function_1fd15c7b0e2117bf() )
    {
        return false;
    }
    
    return istrue( level.var_e7b31441dd59d0a5 );
}

// Namespace br_movingtrain_control
// Params 1, eflags: 0x4
// Checksum 0xcb8efa8a, Offset: 0x1d7b
// Size: 0x2c, Type: bool
function private function_9f9fe5e83f0ec0b8( part )
{
    return part == "train_control_brake" || part == "train_control_speed" || part == "train_control_direction";
}

// Namespace br_movingtrain_control
// Params 2, eflags: 0x4
// Checksum 0xc4107e9b, Offset: 0x1db0
// Size: 0xb7
function private handledevcommand_br( command, args )
{
    firstplayer = level.players[ 0 ];
    
    if ( !isdefined( firstplayer ) )
    {
        return;
    }
    
    switch ( command )
    {
        case #"hash_2899e5a679a1e049":
            if ( !isdefined( args[ 0 ] ) )
            {
                break;
            }
            
            switch ( args[ 0 ] )
            {
                case #"hash_1cf09102712cef10":
                    if ( !isdefined( args[ 1 ] ) )
                    {
                        break;
                    }
                    
                    if ( args[ 1 ] == "cut" || args[ 1 ] == "engaged" || args[ 1 ] == "free" )
                    {
                        function_2fffa9277773181a( "cargo_train", args[ 1 ] );
                    }
                    
                    break;
            }
            
            break;
    }
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0x7c0edfd7, Offset: 0x1e6f
// Size: 0x139
function function_be804d2a92b95302()
{
    level endon( #"game_ended" );
    var_a1e18f6f092e157c = ( 96, 0, 60 );
    var_7de151ae4cbe161b = ( -96, 0, 60 );
    var_147dfea2d90b8a5e = ( 0, 0, 60 );
    var_fbef134fe116bb6c = ( 0, 1, 0 );
    var_217e1acd98c3462b = ( 1, 0, 0 );
    var_f12a843cbc39f8ae = ( 0.5, 0, 1 );
    var_a521adf18a8bfb56 = 20;
    
    while ( true )
    {
        utility::draw_capsule( self localtoworldcoords( var_a1e18f6f092e157c ) + ( 0, 0, var_a521adf18a8bfb56 * -1 ), var_a521adf18a8bfb56, var_a521adf18a8bfb56 * 2, ( 0, 0, 0 ), var_fbef134fe116bb6c, 0 );
        utility::draw_capsule( self localtoworldcoords( var_7de151ae4cbe161b ) + ( 0, 0, var_a521adf18a8bfb56 * -1 ), var_a521adf18a8bfb56, var_a521adf18a8bfb56 * 2, ( 0, 0, 0 ), var_217e1acd98c3462b, 0 );
        utility::draw_capsule( self localtoworldcoords( var_147dfea2d90b8a5e ) + ( 0, 0, var_a521adf18a8bfb56 * -1 ), var_a521adf18a8bfb56, var_a521adf18a8bfb56 * 2, ( 0, 0, 0 ), var_f12a843cbc39f8ae, 0 );
        waitframe();
    }
}

// Namespace br_movingtrain_control
// Params 0
// Checksum 0xc04ea40a, Offset: 0x1fb0
// Size: 0x81
function function_c3dacc4fb3c35d5d()
{
    level endon( #"game_ended" );
    ctl_pos_override = ( 0, 0, 60 );
    var_533e151dfbe1ba4f = ( 1, 0, 0 );
    var_a521adf18a8bfb56 = 20;
    
    while ( true )
    {
        utility::draw_capsule( self localtoworldcoords( ctl_pos_override ) + ( 0, 0, var_a521adf18a8bfb56 * -1 ), var_a521adf18a8bfb56, var_a521adf18a8bfb56 * 2, ( 0, 0, 0 ), var_533e151dfbe1ba4f, 0 );
        waitframe();
    }
}

