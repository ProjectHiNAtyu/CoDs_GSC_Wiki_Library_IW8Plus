// scripts\mp\gametypes\wm_ui.gsc  (hash_0762b218ddc37e9b.gscc) (size: 19793 Bytes / 0x4d51 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee5d62e2 (3999097570)
// size ...... 19793 (0x4d51)
// includes .. 7   (offset: 0x4591)
// strings ... 123 (offset: 0x45c9)
// dev strs .. 0   (offset: 0x4d51)
// exports ... 50  (offset: 0x33e1)
// cseg ...... 0xcd7 + 0x270a (0x33e1)
// imports ... 74  (offset: 0x3bb1)
// animtree1 . 0   (offset: 0x4d51)
// animtree2 . 0   (offset: 0x4d51)
#using script_1aadb848a02a4cf5;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\obj_captureflag;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\hud_message;

#namespace wm_ui;

// Namespace wm_ui
// Params 0
// Checksum 0x6c3df94, Offset: 0xcf5
// Size: 0x10
function init()
{
    waittillframeend();
    flags::gameflaginit( "ui_objectives_setup", 0 );
}

// Namespace wm_ui
// Params 1
// Checksum 0x2fe7df8a, Offset: 0xd0d
// Size: 0x1d7
function function_a76fff18cfaadc94( capture_zones )
{
    player = self;
    custom_icon = undefined;
    var_9ca47b3db62e832a = 0;
    total_zones = 0;
    show_counter = 0;
    
    if ( isdefined( capture_zones ) )
    {
        if ( capture_zones.size == 1 )
        {
            icon_suffix = capture_zones[ 0 ].objectivekey;
            
            switch ( icon_suffix )
            {
                case #"hash_fac2c5f6bddd49bd":
                    custom_icon = 0;
                    break;
                case #"hash_fac2c2f6bddd4504":
                    custom_icon = 1;
                    break;
                case #"hash_fac2c3f6bddd4697":
                    custom_icon = 2;
                    break;
            }
            
            var_9ca47b3db62e832a = 1;
        }
        else if ( capture_zones.size > 1 )
        {
            show_counter = 1;
            total_zones = capture_zones.size;
        }
    }
    
    remainzones = wm_objectives::function_918d2f8f04e8780c();
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_CAPTURE_UID" );
        ui_key = "WAR_CAPTURE";
        player start_objective( uid, ui_key );
        
        if ( isdefined( custom_icon ) )
        {
            namespace_4c5fce57fb970de0::set_obj_icon( player, uid, custom_icon );
        }
        
        namespace_4c5fce57fb970de0::function_d6a164b1dad285cf( player, uid, var_9ca47b3db62e832a );
        
        if ( show_counter )
        {
            setup_obj_counter( player, uid, total_zones, remainzones );
        }
    }
    else if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_DEFEND_UID" );
        ui_key = "WAR_DEFEND";
        player start_objective( uid, ui_key );
        
        if ( isdefined( custom_icon ) )
        {
            namespace_4c5fce57fb970de0::set_obj_icon( player, uid, custom_icon );
        }
        
        namespace_4c5fce57fb970de0::function_d6a164b1dad285cf( player, uid, var_9ca47b3db62e832a );
        
        if ( show_counter )
        {
            setup_obj_counter( player, uid, total_zones, remainzones );
        }
    }
    
    if ( var_9ca47b3db62e832a )
    {
        player thread function_8ba0a3ea57c90162();
    }
    
    if ( show_counter )
    {
        player thread function_9fc9d073a31491e1();
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x1acfe1bc, Offset: 0xeec
// Size: 0x115
function function_8ba0a3ea57c90162()
{
    level endon( #"game_ended" );
    level endon( #"end_zone_objective" );
    
    while ( true )
    {
        if ( !isalive( self ) )
        {
            break;
        }
        
        if ( isdefined( level.zone.capture_zones ) )
        {
            if ( level.zone.capture_zones.size > 1 )
            {
                break;
            }
            
            zone = level.zone.capture_zones[ 0 ];
            progress = zone.curprogress / zone.usetime;
            state = undefined;
            
            if ( zone.stalemate )
            {
                state = 1;
            }
            else if ( self.pers[ "team" ] == game[ "attackers" ] )
            {
                state = 2;
            }
            else if ( self.pers[ "team" ] == game[ "defenders" ] )
            {
                state = 3;
            }
            else
            {
                state = 0;
            }
            
            function_8dfc9c04f8d1b0d6( self, progress, state );
        }
        
        waitframe();
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xc737689a, Offset: 0x1009
// Size: 0x5c
function function_9fc9d073a31491e1()
{
    level endon( #"game_ended" );
    level endon( #"end_zone_objective" );
    self endon( #"disconnect" );
    remainzones = wm_objectives::function_918d2f8f04e8780c();
    
    while ( remainzones > 0 )
    {
        level waittill( #"wm_zone_captured" );
        remainzones--;
        function_f26fe2d73ef3a033( self, remainzones );
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0xb202469a, Offset: 0x106d
// Size: 0x18b
function function_3f36d437cf26e2f6( objectives )
{
    player = self;
    
    if ( isdefined( objectives ) )
    {
        if ( !isdefined( level.var_412867c78192c3bd ) )
        {
            level.var_412867c78192c3bd = spawnstruct();
        }
        
        if ( !isdefined( level.var_412867c78192c3bd.total_bombs ) )
        {
            level.var_412867c78192c3bd.total_bombs = objectives.size;
        }
        
        if ( !isdefined( level.var_412867c78192c3bd.remaining_bombs ) )
        {
            level.var_412867c78192c3bd.remaining_bombs = level.var_412867c78192c3bd.total_bombs;
        }
    }
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_BOMB_DEFUSE_UID" );
        ui_key = "WAR_BOMB_DEFUSE";
        player start_objective( uid, ui_key );
        setup_obj_counter( player, uid, level.var_412867c78192c3bd.total_bombs, level.var_412867c78192c3bd.remaining_bombs );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_BOMB_DEFEND_UID" );
        ui_key = "WAR_BOMB_DEFEND";
        player start_objective( uid, ui_key );
        setup_obj_counter( player, uid, level.var_412867c78192c3bd.total_bombs, level.var_412867c78192c3bd.remaining_bombs );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xc95044a2, Offset: 0x1200
// Size: 0xec
function function_f63d60dd5fbd6c58()
{
    if ( level.zone.objectivetype == 2 && isdefined( level.var_412867c78192c3bd ) )
    {
        prev_remaining = level.var_412867c78192c3bd.remaining_bombs;
        
        if ( prev_remaining > 0 )
        {
            remaining = prev_remaining - 1;
            level.var_412867c78192c3bd.remaining_bombs = remaining;
            
            foreach ( player in level.players )
            {
                function_f26fe2d73ef3a033( player, remaining );
            }
        }
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xade4e694, Offset: 0x12f4
// Size: 0x98
function function_3d6ddd22f226d43()
{
    player = self;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_HOSTAGE_RESCUE_UID" );
        ui_key = "WAR_HOSTAGE_RESCUE";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_HOSTAGE_DEFEND_UID" );
        ui_key = "WAR_HOSTAGE_DEFEND";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xab937ebe, Offset: 0x1394
// Size: 0x98
function function_1d49f046949d8d40()
{
    player = self;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_DESTROY_PLANT_ATTACKERS_UID" );
        ui_key = "WAR_DESTROY_PLANT_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_DESTROY_PLANT_DEFENDERS_UID" );
        ui_key = "WAR_DESTROY_PLANT_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xb302a52c, Offset: 0x1434
// Size: 0x1e8
function function_802fe98aacbfed1f()
{
    player = self;
    
    while ( !isdefined( level.escortvehicles[ 0 ] ) )
    {
        waitframe();
    }
    
    setomnvar( "ui_wm_escort_objective_id", level.escortvehicles[ 0 ].marker.objidnum );
    
    foreach ( vehicle in level.escortvehicles )
    {
        if ( isdefined( vehicle.checkpoints ) )
        {
            foreach ( i, checkpoint in vehicle.checkpoints )
            {
                if ( checkpoint.visible )
                {
                    setomnvar( "ui_wm_escort_checkpoint_" + i, checkpoint.progress );
                }
            }
        }
    }
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_TANK_ESCORT_ATTACKERS_UID" );
        ui_key = "WAR_TANK_ESCORT_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_TANK_ESCORT_DEFENDERS_UID" );
        ui_key = "WAR_TANK_ESCORT_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x64252021, Offset: 0x1624
// Size: 0x98
function function_b66de8144a7cb04a()
{
    player = self;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_AI_BOSS_ATTACKERS_UID" );
        ui_key = "WAR_AI_BOSS_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_AI_BOSS_DEFENDERS_UID" );
        ui_key = "WAR_AI_BOSS_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xa7b6cd46, Offset: 0x16c4
// Size: 0x98
function function_5feed18bd5e391ad()
{
    player = self;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_AI_BOSS_ZONE_ATTACKERS_UID" );
        ui_key = "WAR_AI_BOSS_ZONE_ATTACKERS";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_AI_BOSS_ZONE_DEFENDERS_UID" );
        ui_key = "WAR_AI_BOSS_ZONE_DEFENDERS";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x36ae86b7, Offset: 0x1764
// Size: 0x119
function function_2dd5eab36627fdb5()
{
    player = self;
    hack_zones = level.zone.hackzones;
    
    if ( hack_zones.size > 1 )
    {
        show_counter = 1;
        total_zones = hack_zones.size;
    }
    
    remainzones = wm_objectives::function_918d2f8f04e8780c();
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_HACK_ATTACK_UID" );
        ui_key = "WAR_HACK_ATTACK";
        player start_objective( uid, ui_key );
        
        if ( show_counter )
        {
            setup_obj_counter( player, uid, total_zones, remainzones );
        }
    }
    else if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_HACK_DEFEND_UID" );
        ui_key = "WAR_HACK_DEFEND";
        player start_objective( uid, ui_key );
        
        if ( show_counter )
        {
            setup_obj_counter( player, uid, total_zones, remainzones );
        }
    }
    
    if ( show_counter )
    {
        player thread function_d87adde2c6c937b();
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0xea08a16e, Offset: 0x1885
// Size: 0x5c
function function_d87adde2c6c937b()
{
    level endon( #"game_ended" );
    level endon( #"hash_ceedb371bdc45f31" );
    self endon( #"disconnect" );
    remainzones = wm_objectives::function_918d2f8f04e8780c();
    
    while ( remainzones > 0 )
    {
        level waittill( #"hash_592b7dab90cb3452" );
        remainzones--;
        function_f26fe2d73ef3a033( self, remainzones );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x162b5c2c, Offset: 0x18e9
// Size: 0x124
function function_11555ac53ab3db3e()
{
    player = self;
    total_zones = 0;
    hack_zones = level.zone.hackzones;
    
    if ( hack_zones.size > 1 )
    {
        total_zones = hack_zones.size;
    }
    
    currentphase = wm_objectives::function_166b889d13f5f736();
    remainzones = wm_objectives::function_ab807479f577b3fc();
    ui_keys = function_aa9e8ee40eefeb26();
    uids = function_b1a3facd637e8e9a();
    index = -1;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        index = 0;
    }
    else if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        index = 1;
    }
    
    uid = uids[ index ];
    ui_key = ui_keys[ index ];
    player start_objective( uid, ui_key );
    
    if ( currentphase == "hack" )
    {
        setup_obj_counter( player, uid, total_zones, remainzones );
        player thread function_4d483e63a99fe029();
        player thread function_adf507211e5be1c2();
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x1d6ab29b, Offset: 0x1a15
// Size: 0x4d
function function_adf507211e5be1c2()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level waittill( #"hack_zone_upload_full_complete" );
    function_55d25d2df71a3e98( self.pers[ "team" ] == game[ "attackers" ] );
    waitframe();
    thread function_11555ac53ab3db3e();
}

// Namespace wm_ui
// Params 0
// Checksum 0x59a848e7, Offset: 0x1a6a
// Size: 0x5c
function function_4d483e63a99fe029()
{
    level endon( #"game_ended" );
    level endon( #"hack_zone_upload_full_complete" );
    self endon( #"disconnect" );
    remainzones = wm_objectives::function_ab807479f577b3fc();
    
    while ( remainzones > 0 )
    {
        level waittill( #"hash_592b7dab90cb3452" );
        remainzones--;
        function_f26fe2d73ef3a033( self, remainzones );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x75838570, Offset: 0x1ace
// Size: 0x46
function function_aa9e8ee40eefeb26()
{
    currentphase = wm_objectives::function_166b889d13f5f736();
    
    if ( currentphase == "hack" )
    {
        return [ "WAR_HACK_BOMB_ATTACK_PHASE_1", "WAR_HACK_BOMB_DEFEND_PHASE_1" ];
    }
    
    return [ "WAR_HACK_BOMB_ATTACK_PHASE_2", "WAR_HACK_BOMB_DEFEND_PHASE_2" ];
}

// Namespace wm_ui
// Params 0
// Checksum 0xd503706, Offset: 0x1b1d
// Size: 0x46
function function_b1a3facd637e8e9a()
{
    currentphase = wm_objectives::function_166b889d13f5f736();
    
    if ( currentphase == "hack" )
    {
        return [ "WAR_HACK_BOMB_ATTACK_PHASE_1_UID", "WAR_HACK_BOMB_DEFEND_PHASE_1_UID" ];
    }
    
    return [ "WAR_HACK_BOMB_ATTACK_PHASE_2_UID", "WAR_HACK_BOMB_DEFEND_PHASE_2_UID" ];
}

// Namespace wm_ui
// Params 0
// Checksum 0xfce433d2, Offset: 0x1b6c
// Size: 0x1e8
function function_e921ed47ad7ee0c6()
{
    player = self;
    
    while ( !isdefined( level.escortvehicles[ 0 ] ) )
    {
        waitframe();
    }
    
    setomnvar( "ui_wm_escort_objective_id", level.escortvehicles[ 0 ].marker.objidnum );
    
    foreach ( vehicle in level.escortvehicles )
    {
        if ( isdefined( vehicle.checkpoints ) )
        {
            foreach ( i, checkpoint in vehicle.checkpoints )
            {
                if ( checkpoint.visible )
                {
                    setomnvar( "ui_wm_escort_checkpoint_" + i, checkpoint.progress );
                }
            }
        }
    }
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_ESCORT_WHEELSON_ATTACK_UID" );
        ui_key = "WAR_ESCORT_WHEELSON_ATTACK";
        player start_objective( uid, ui_key );
        return;
    }
    
    if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        uid = namespace_4c5fce57fb970de0::generate_uid( "WAR_ESCORT_WHEELSON_DEFEND_UID" );
        ui_key = "WAR_ESCORT_WHEELSON_DEFEND";
        player start_objective( uid, ui_key );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x146803cf, Offset: 0x1d5c
// Size: 0x103
function function_deeb34391371abc5()
{
    player = self;
    currentphase = wm_objectives::function_166b889d13f5f736();
    totalflags = level.zone.captureflags.size;
    remainflags = obj_captureflag::function_51f68acf123a57b7();
    ui_keys = function_5b51cca41a8d8de1();
    uids = function_cfb393d1afa1992f();
    index = -1;
    
    if ( player.pers[ "team" ] == game[ "attackers" ] )
    {
        index = 0;
    }
    else if ( player.pers[ "team" ] == game[ "defenders" ] )
    {
        index = 1;
    }
    
    uid = uids[ index ];
    ui_key = ui_keys[ index ];
    player start_objective( uid, ui_key );
    
    if ( currentphase == "capture_flag" )
    {
        setup_obj_counter( player, uid, totalflags, remainflags );
        player thread function_ac7f414cae536b16();
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x96b8d907, Offset: 0x1e67
// Size: 0x46
function function_5b51cca41a8d8de1()
{
    currentphase = wm_objectives::function_166b889d13f5f736();
    
    if ( currentphase == "capture_flag" )
    {
        return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_1", "WAR_CAPTURE_FLAG_DEFEND_PHASE_1" ];
    }
    
    return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_2", "WAR_CAPTURE_FLAG_DEFEND_PHASE_2" ];
}

// Namespace wm_ui
// Params 0
// Checksum 0xa5846537, Offset: 0x1eb6
// Size: 0x46
function function_cfb393d1afa1992f()
{
    currentphase = wm_objectives::function_166b889d13f5f736();
    
    if ( currentphase == "capture_flag" )
    {
        return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_1_UID", "WAR_CAPTURE_FLAG_DEFEND_PHASE_1_UID" ];
    }
    
    return [ "WAR_CAPTURE_FLAG_ATTACK_PHASE_2_UID", "WAR_CAPTURE_FLAG_DEFEND_PHASE_2_UID" ];
}

// Namespace wm_ui
// Params 0
// Checksum 0x30ba6b09, Offset: 0x1f05
// Size: 0x76
function function_ac7f414cae536b16()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    remainflags = obj_captureflag::function_51f68acf123a57b7();
    
    while ( remainflags > 0 )
    {
        level waittill( #"flag_placed" );
        remainflags--;
        function_f26fe2d73ef3a033( self, remainflags );
    }
    
    function_55d25d2df71a3e98( self.pers[ "team" ] == game[ "attackers" ] );
    waitframe();
    thread function_deeb34391371abc5();
}

// Namespace wm_ui
// Params 1
// Checksum 0x94c3a085, Offset: 0x1f83
// Size: 0x10a
function end_ui_objective( attackerswon )
{
    omnvar = "ui_wm_objective_state_" + level.zone.index;
    
    if ( attackerswon )
    {
        setomnvar( omnvar, 2 );
    }
    else
    {
        setomnvar( omnvar, 3 );
    }
    
    foreach ( player in level.players )
    {
        if ( player.pers[ "team" ] == game[ "attackers" ] )
        {
            player function_55d25d2df71a3e98( attackerswon );
            continue;
        }
        
        if ( player.pers[ "team" ] == game[ "defenders" ] )
        {
            player function_55d25d2df71a3e98( !attackerswon );
        }
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0xb72f20e6, Offset: 0x2095
// Size: 0x1a8
function start_ui_objective( objectivetype )
{
    player = self;
    setomnvar( "ui_wm_objective_state_" + level.zone.index, 1 );
    
    if ( isdefined( level.zone.objectivetype ) )
    {
        switch ( level.zone.objectivetype )
        {
            case 1:
                player thread function_a76fff18cfaadc94( level.zone.capture_zones );
                break;
            case 2:
                player thread function_3f36d437cf26e2f6( level.zone.objectives );
                break;
            case 3:
                player thread function_3d6ddd22f226d43();
                break;
            case 5:
                player thread function_1d49f046949d8d40();
                break;
            case 6:
                player thread function_802fe98aacbfed1f();
                break;
            case 11:
                player thread function_e921ed47ad7ee0c6();
                break;
            case 7:
                player thread function_b66de8144a7cb04a();
                break;
            case 8:
                player thread function_5feed18bd5e391ad();
                break;
            case 9:
                player thread function_2dd5eab36627fdb5();
                break;
            case 10:
                player thread function_11555ac53ab3db3e();
                break;
            case 12:
                player thread function_deeb34391371abc5();
                break;
            default:
                break;
        }
    }
}

// Namespace wm_ui
// Params 4
// Checksum 0x35abceea, Offset: 0x2245
// Size: 0x46
function setup_obj_counter( player, uid, total, remaining )
{
    namespace_4c5fce57fb970de0::function_461cbbc7cf88bc2( player );
    namespace_4c5fce57fb970de0::set_obj_counter_total( player, uid, total );
    namespace_4c5fce57fb970de0::set_obj_counter_progress( player, uid, remaining );
}

// Namespace wm_ui
// Params 2
// Checksum 0xb7e082e, Offset: 0x2293
// Size: 0x69
function function_f26fe2d73ef3a033( player, remaining )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        namespace_4c5fce57fb970de0::set_obj_counter_progress( player, uid, remaining );
    }
}

// Namespace wm_ui
// Params 3
// Checksum 0x7162b124, Offset: 0x2304
// Size: 0x7d
function function_8dfc9c04f8d1b0d6( player, progress, state )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        namespace_4c5fce57fb970de0::set_obj_progress_bar( player, uid, progress );
        namespace_4c5fce57fb970de0::set_obj_progress_bar_state( player, uid, state );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x62b4d66c, Offset: 0x2389
// Size: 0x90
function function_3d26f5d881c168f1()
{
    timeremaining = int( gamelogic_mp::gettimeremaining() );
    
    foreach ( player in level.players )
    {
        update_active_timer( player, timeremaining );
    }
}

// Namespace wm_ui
// Params 2
// Checksum 0x73988654, Offset: 0x2421
// Size: 0x69
function update_active_timer( player, timeremaining )
{
    if ( isdefined( player.objective_tracker ) && isdefined( player.objective_tracker.active_uid ) )
    {
        uid = player.objective_tracker.active_uid;
        namespace_4c5fce57fb970de0::set_obj_timer( player, uid, timeremaining );
    }
}

// Namespace wm_ui
// Params 2
// Checksum 0x8986eb7a, Offset: 0x2492
// Size: 0x5d
function function_e50496e135055296( oobtimelimit, isfallback )
{
    player = self;
    oobtype = 1;
    
    if ( isdefined( isfallback ) )
    {
        oobtype = 4;
    }
    
    player setclientomnvar( "ui_out_of_bounds_type", oobtype );
    player setclientomnvar( "ui_out_of_bounds_countdown", gettime() + oobtimelimit * 1000 );
}

// Namespace wm_ui
// Params 1
// Checksum 0x1d4d3718, Offset: 0x24f7
// Size: 0x5c
function init_obj_tracker( player )
{
    var_66ff60a50c114c9b = "scripted_widget_objective_tracker_jup_wm";
    
    if ( isdefined( level.var_66ff60a50c114c9b ) )
    {
        var_66ff60a50c114c9b = level.var_66ff60a50c114c9b;
    }
    
    namespace_4c5fce57fb970de0::player_init( player, "ObjectiveTracker_WarMode", var_66ff60a50c114c9b, 26, 265 );
    player start_ui_objective();
    player thread function_c2b1a2cfc1f931fc();
}

// Namespace wm_ui
// Params 2
// Checksum 0xc9fa193d, Offset: 0x255b
// Size: 0xa2
function start_objective( uid, ui_key )
{
    completed = 0;
    player_has_objective = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( isdefined( self.objective_tracker ) )
    {
        flags::gameflagset( "ui_objectives_setup" );
        
        if ( !player_has_objective )
        {
            namespace_4c5fce57fb970de0::add_objective( uid, undefined, undefined, ui_key, completed );
        }
        
        return;
    }
    
    level.pending_uid = uid;
    level.pending_ui_key = ui_key;
    flags::gameflagclear( "ui_objectives_setup" );
}

// Namespace wm_ui
// Params 2
// Checksum 0x6e4df98f, Offset: 0x2605
// Size: 0x79
function complete_objective( uid, is_successful )
{
    player_has_objective = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( player_has_objective && !self.objective_tracker.objectives[ uid ].is_completed )
    {
        namespace_4c5fce57fb970de0::on_objective_complete( uid, is_successful );
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0x8a6f657e, Offset: 0x2686
// Size: 0x7d
function function_55d25d2df71a3e98( is_successful )
{
    if ( isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.active_uid ) )
    {
        uid = self.objective_tracker.active_uid;
        
        if ( !self.objective_tracker.objectives[ uid ].is_completed )
        {
            namespace_4c5fce57fb970de0::on_objective_complete( uid, is_successful );
        }
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0xe3587d84, Offset: 0x270b
// Size: 0x4a
function clear_objective( uid )
{
    var_1050e0459943c8f0 = isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives[ uid ] );
    
    if ( var_1050e0459943c8f0 )
    {
        namespace_4c5fce57fb970de0::remove_objective( uid );
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x146a827d, Offset: 0x275d
// Size: 0x66
function get_current_objective()
{
    current_obj = undefined;
    next_uid = self.objective_tracker.next_uid;
    
    if ( isdefined( next_uid ) && isdefined( self.objective_tracker.objectives[ next_uid ] ) )
    {
        current_obj = self.objective_tracker.objectives[ next_uid ];
    }
    
    return current_obj;
}

// Namespace wm_ui
// Params 0
// Checksum 0x78c0cb57, Offset: 0x27cc
// Size: 0x1f1
function update_objective_ui()
{
    if ( !flags::gameflag( "ui_objectives_setup" ) )
    {
        if ( isdefined( level.pending_uid ) && isdefined( level.pending_ui_key ) )
        {
            foreach ( player in level.players )
            {
                player start_objective( level.pending_uid, level.pending_ui_key );
            }
        }
    }
    
    if ( !( isdefined( self ) && isdefined( self.objective_tracker ) && isdefined( self.objective_tracker.objectives ) ) )
    {
        return;
    }
    
    self.objective_tracker.var_6d4c835bb3019325 = level.framedurationseconds;
    current_obj = get_current_objective();
    
    if ( isdefined( current_obj ) )
    {
        if ( !isdefined( self.objective_tracker.active_uid ) )
        {
            namespace_4c5fce57fb970de0::function_cfd35a1d757761ed( current_obj.uid, current_obj.ui_key, current_obj.is_completed, current_obj.is_successful );
        }
        else if ( self.objective_tracker.active_uid != current_obj.uid )
        {
            namespace_4c5fce57fb970de0::function_5ed9e57658a48212();
        }
        else if ( self.objective_tracker.active_completed != current_obj.is_completed )
        {
            if ( current_obj.is_completed )
            {
                namespace_4c5fce57fb970de0::function_a119c385540b5a9b( current_obj.is_successful );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.objective_tracker.active_uid ) )
    {
        namespace_4c5fce57fb970de0::function_5ed9e57658a48212();
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0x2cf82a80, Offset: 0x29c5
// Size: 0x3b
function set_ui_objective( zone )
{
    ui_objective = function_a583d4dee7e506db( zone.objectivetype );
    
    if ( isdefined( ui_objective ) )
    {
        setomnvar( "ui_wm_objective", ui_objective );
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0xb87295e9, Offset: 0x2a08
// Size: 0x100
function function_a583d4dee7e506db( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            if ( game_utility::getmapname() == "mp_jup_dam" )
            {
                return 9;
            }
            else
            {
                return 1;
            }
        case 2:
            if ( game_utility::getmapname() == "mp_jup_dam" )
            {
                return 10;
            }
            else
            {
                return 2;
            }
        case 3:
            return 3;
        case 4:
            return 4;
        case 5:
            return 5;
        case 6:
        case 11:
            return 6;
        case 7:
            return 7;
        case 8:
            return 8;
        case 9:
            return 11;
        case 10:
            return 12;
        case 12:
            return 14;
        default:
            break;
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0x34f8cde4, Offset: 0x2b10
// Size: 0x1e
function update_ui_attacking_team( attackingteam )
{
    setomnvar( "ui_wm_axis_attacking", attackingteam == "axis" );
}

// Namespace wm_ui
// Params 0
// Checksum 0x42b20c02, Offset: 0x2b36
// Size: 0x45
function function_2584814c5c873ad5()
{
    setomnvar( "ui_wm_show_objectives", 0 );
    flags::gameflagwait( "prematch_done" );
    wait 5;
    function_516c801c51d3f45e( self.zone.objectivetype );
    wait 1;
    setomnvar( "ui_wm_show_objectives", 1 );
}

// Namespace wm_ui
// Params 1
// Checksum 0x6d6132d2, Offset: 0x2b83
// Size: 0x169
function function_516c801c51d3f45e( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            hud_message::notifyteam( "jup_wm_zone_attack", "jup_wm_zone_defend", game[ "attackers" ] );
            break;
        case 2:
            hud_message::notifyteam( "jup_wm_bomb_attack", "jup_wm_bomb_defend", game[ "attackers" ] );
            break;
        case 3:
            hud_message::notifyteam( "jup_wm_hostage_attack", "jup_wm_hostage_defend", game[ "attackers" ] );
            break;
        case 4:
            hud_message::notifyteam( "jup_wm_destroy_attack", "jup_wm_destroy_defend", game[ "attackers" ] );
            break;
        case 5:
            hud_message::notifyteam( "jup_wm_plant_attack", "jup_wm_plant_defend", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            hud_message::notifyteam( "jup_wm_escort_attack", "jup_wm_escort_defend", game[ "attackers" ] );
            break;
        case 7:
            hud_message::notifyteam( "jup_wm_boss_attack", "jup_wm_boss_defend", game[ "attackers" ] );
            break;
        case 8:
            hud_message::notifyteam( "jup_wm_boss_zone_attack", "jup_wm_boss_zone_defend", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui
// Params 2
// Checksum 0x57728a00, Offset: 0x2cf4
// Size: 0xc4
function function_8f6d4808684aff73( var_f9323042e910a86d, var_7d9cb3a967d065a )
{
    if ( isdefined( level.zone.objective.params[ "transitionSplash" ] ) )
    {
        attackersplash = level.zone.objective.params[ "transitionSplash" ][ 0 ];
        defendersplash = level.zone.objective.params[ "transitionSplash" ][ 1 ];
        hud_message::notifyteam( attackersplash, defendersplash, game[ "attackers" ] );
        return;
    }
    
    function_61248a50df2a8ba7( var_f9323042e910a86d );
    waitframe();
    function_9f204a45668152e6( var_7d9cb3a967d065a );
}

// Namespace wm_ui
// Params 1
// Checksum 0x8b38a860, Offset: 0x2dc0
// Size: 0x169
function function_61248a50df2a8ba7( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            hud_message::notifyteam( "jup_wm_secured_zone", "jup_wm_secured_zone_enemy", game[ "attackers" ] );
            break;
        case 2:
            hud_message::notifyteam( "jup_wm_secured_bomb", "jup_wm_secured_bomb_enemy", game[ "attackers" ] );
            break;
        case 3:
            hud_message::notifyteam( "jup_wm_secured_hostage", "jup_wm_secured_hostage_enemy", game[ "attackers" ] );
            break;
        case 4:
            hud_message::notifyteam( "jup_wm_secured_destroy", "jup_wm_secured_destroy_enemy", game[ "attackers" ] );
            break;
        case 5:
            hud_message::notifyteam( "jup_wm_secured_plant", "jup_wm_secured_plant_enemy", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            hud_message::notifyteam( "jup_wm_secured_escort", "jup_wm_secured_escort_enemy", game[ "attackers" ] );
            break;
        case 7:
            hud_message::notifyteam( "jup_wm_secured_boss", "jup_wm_secured_boss_enemy", game[ "attackers" ] );
            break;
        case 8:
            hud_message::notifyteam( "jup_wm_secured_boss_zone", "jup_wm_secured_boss_zone_enemy", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui
// Params 1
// Checksum 0x2aa9e048, Offset: 0x2f31
// Size: 0x169
function function_9f204a45668152e6( objectivetype )
{
    switch ( objectivetype )
    {
        case 1:
            hud_message::notifyteam( "jup_wm_next_zone", "jup_wm_next_zone_enemy", game[ "attackers" ] );
            break;
        case 2:
            hud_message::notifyteam( "jup_wm_next_bomb", "jup_wm_next_bomb_enemy", game[ "attackers" ] );
            break;
        case 3:
            hud_message::notifyteam( "jup_wm_next_hostage", "jup_wm_next_hostage_enemy", game[ "attackers" ] );
            break;
        case 4:
            hud_message::notifyteam( "jup_wm_next_destroy", "jup_wm_next_destroy_enemy", game[ "attackers" ] );
            break;
        case 5:
            hud_message::notifyteam( "jup_wm_next_plant", "jup_wm_next_plant_enemy", game[ "attackers" ] );
            break;
        case 6:
        case 11:
            hud_message::notifyteam( "jup_wm_next_escort", "jup_wm_next_escort_enemy", game[ "attackers" ] );
            break;
        case 7:
            hud_message::notifyteam( "jup_wm_next_boss", "jup_wm_next_boss_enemy", game[ "attackers" ] );
            break;
        case 8:
            hud_message::notifyteam( "jup_wm_next_boss_zone", "jup_wm_next_boss_zone_enemy", game[ "attackers" ] );
            break;
        default:
            break;
    }
}

// Namespace wm_ui
// Params 0
// Checksum 0x58097d1c, Offset: 0x30a2
// Size: 0x199
function function_c2b1a2cfc1f931fc()
{
    self endon( #"game_ended" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        self waittill( #"joined_team" );
        lastteam = self.pers[ "last_team" ];
        
        if ( isdefined( lastteam ) && self.team != lastteam )
        {
            current_obj = get_current_objective();
            
            if ( !isdefined( current_obj ) )
            {
                continue;
            }
            
            if ( isdefined( self.objective_tracker.active_uid ) )
            {
                self.objective_tracker.next_uid = undefined;
                wait 1;
            }
            
            objectivetype = level.zone.objectivetype;
            self.objective_tracker.objectives[ current_obj.uid ] = undefined;
            current_obj.uid = function_55e14d4c615d88b( objectivetype, self.team );
            current_obj.ui_key = function_9e0b6a1e335354f4( objectivetype, self.team );
            current_obj.update_counter_total = 1;
            current_obj.update_counter_progress = 1;
            self.objective_tracker.objectives[ current_obj.uid ] = current_obj;
            self.objective_tracker.next_uid = current_obj.uid;
            self.objective_tracker.active_uid = undefined;
        }
    }
}

// Namespace wm_ui
// Params 2
// Checksum 0x59624397, Offset: 0x3243
// Size: 0x15c
function function_9e0b6a1e335354f4( objectivetype, team )
{
    side = team == game[ "attackers" ] ? 0 : 1;
    var_1905594960f8755 = function_aa9e8ee40eefeb26();
    var_23edff46819abd50 = function_5b51cca41a8d8de1();
    mp = [ [], [ "WAR_CAPTURE", "WAR_DEFEND" ], [ "WAR_BOMB_DEFUSE", "WAR_BOMB_DEFEND" ], [ "WAR_HOSTAGE_RESCUE", "WAR_HOSTAGE_DEFEND" ], [ "", "" ], [ "WAR_DESTROY_PLANT_ATTACKERS", "WAR_DESTROY_PLANT_DEFENDERS" ], [ "WAR_TANK_ESCORT_ATTACKERS", "WAR_TANK_ESCORT_DEFENDERS" ], [ "WAR_AI_BOSS_ATTACKERS", "WAR_AI_BOSS_DEFENDERS" ], [ "WAR_AI_BOSS_ZONE_ATTACKERS", "WAR_AI_BOSS_ZONE_DEFENDERS" ], [ "WAR_HACK_ATTACK", "WAR_HACK_DEFEND" ], var_1905594960f8755, [ "WAR_ESCORT_WHEELSON_ATTACK", "WAR_ESCORT_WHEELSON_DEFEND" ], var_23edff46819abd50 ];
    return mp[ objectivetype ][ side ];
}

// Namespace wm_ui
// Params 2
// Checksum 0xa7ab23d4, Offset: 0x33a8
// Size: 0x38
function function_55e14d4c615d88b( objectivetype, team )
{
    prefix = function_9e0b6a1e335354f4( objectivetype, team ) + "_UID";
    return namespace_4c5fce57fb970de0::generate_uid( prefix );
}

