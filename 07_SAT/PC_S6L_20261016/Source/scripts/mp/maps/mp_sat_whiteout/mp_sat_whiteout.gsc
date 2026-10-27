// scripts\mp\maps\mp_sat_whiteout\mp_sat_whiteout.gsc  (hash_0b63df18394ee4e1.gscc) (size: 12048 Bytes / 0x2f10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x58cf0368 (1489961832)
// size ...... 12048 (0x2f10)
// includes .. 15  (offset: 0x2be4)
// strings ... 52  (offset: 0x2c5c)
// dev strs .. 0   (offset: 0x2f10)
// exports ... 23  (offset: 0x1ed0)
// cseg ...... 0x396 + 0x1b3a (0x1ed0)
// imports ... 76  (offset: 0x2268)
// animtree1 . 0   (offset: 0x2f10)
// animtree2 . 0   (offset: 0x2f10)
#using scripts\common\active_env\moving_platforms;
#using scripts\common\active_env\utility;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_whiteout\gen\mp_sat_whiteout_art;
#using scripts\mp\maps\mp_sat_whiteout\mp_sat_whiteout_fx;
#using scripts\mp\maps\mp_sat_whiteout\mp_sat_whiteout_lighting;
#using scripts\mp\objidpoolmanager;

#namespace mp_sat_whiteout;

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0xa4a48dd1, Offset: 0x3b4
// Size: 0x1eb
function main()
{
    mp_sat_whiteout_art::main();
    namespace_41833c7d7f635375::main();
    mp_sat_whiteout_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_whiteout" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    callback::add( #"player_spawn_init", &on_spawn_init );
    utility::flag_wait( "scriptables_ready" );
    var_9349e424962b8eb0 = game_utility::getgametype();
    
    if ( arraycontains( [ "dom", "koth" ], var_9349e424962b8eb0 ) )
    {
        flags::function_2f3408423ccc9b2e( "chevrons_ready" );
    }
    
    level.s_inclinator = getent( "moving_platform_obj", "targetname" );
    level.var_f31d6a9929717c6d = 0;
    level.var_9e0358431bbb2a1f = 0;
    level.s_railing = getent( "struct_special", "targetname" );
    function_c854d9a790ddeb5e();
    level thread moving_platforms::moving_platforms_init();
    control_panel_init();
    function_860d46fc950fc220();
    setup_no_deploy_zones();
    setup_safety_counter();
    probe = getent( "moving_platform", "targetname" );
    probe linkto( level.s_inclinator );
    setdvar( @"hash_1673bfd92c93a024", 640 );
    utility::registersharedfunc( #"sat_whiteout", #"hash_b50f0f1668fc8491", &function_3b7eb150befb8b0e );
}

// Namespace mp_sat_whiteout
// Params 1
// Checksum 0x8512ce7f, Offset: 0x5a7
// Size: 0xc
function on_spawn_init( params )
{
    
}

// Namespace mp_sat_whiteout
// Params 2, eflags: 0x4
// Checksum 0x5c950c7d, Offset: 0x5bb
// Size: 0x1c0
function private function_3b7eb150befb8b0e( ent, stuckto )
{
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        tracecontent = trace::create_contents( 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0 );
        ignorelist = [ self, ent ];
        traceback = trace::ray_trace( self.origin + ( 0, 0, 58 ), ent.origin, ignorelist, tracecontent );
        
        if ( !traceback[ "entity" ] || !traceback[ "entity" ] ismovingplatform() )
        {
            return;
        }
        
        tracestartpos = ( self.origin + traceback[ "position" ] ) / 2 + ( 0, 0, 1 ) * 20;
        traceendpos = ( self.origin + traceback[ "position" ] ) / 2 + ( 0, 0, 1 ) * -200;
        traceback = trace::sphere_trace( tracestartpos, traceendpos, 6, ignorelist, tracecontent );
        
        if ( traceback[ "hittype" ] != "hittype_none" )
        {
            if ( traceback[ "entity" ] && traceback[ "entity" ] ismovingplatform() || traceback[ "hittype" ] == "hittype_world" )
            {
                /#
                    utility::draw_capsule( traceendpos, 8, 70, undefined, undefined, undefined, int( 1000 ) );
                #/
                
                ent unlink();
                ent.origin = traceback[ "position" ] + ( 0, 0, 10 );
                ent.angles = ( 0, 0, 0 );
            }
        }
        
        ent linkto( stuckto );
    }
}

// Namespace mp_sat_whiteout
// Params 0, eflags: 0x4
// Checksum 0x97ab1ec2, Offset: 0x783
// Size: 0x69
function private setup_safety_counter()
{
    level.var_a564626bcb66b0e5 = getent( "safety_counter", #script_noteworthy );
    
    if ( level.var_a564626bcb66b0e5 )
    {
        level.var_a564626bcb66b0e5 setscriptablepartstate( #"hash_715e4b46adbc9d4", #"0" );
        level.safetycounter = 0;
        level callback::add( #"player_death", &on_player_death );
    }
}

// Namespace mp_sat_whiteout
// Params 1, eflags: 0x4
// Checksum 0x35af8cf9, Offset: 0x7f4
// Size: 0x18f
function private on_player_death( deathdata )
{
    if ( deathdata.deathtype == "deathType_suicide" && deathdata.inflictor.classname == "trigger_hurt" )
    {
        level.safetycounter++;
        thousands = level.safetycounter >= 1000 ? getxhash( string( int( level.safetycounter / 1000 ) % 10 ) ) : #"off";
        hundreds = level.safetycounter >= 100 ? getxhash( string( int( level.safetycounter / 100 ) % 10 ) ) : #"off";
        tens = level.safetycounter >= 10 ? getxhash( string( int( level.safetycounter / 10 ) % 10 ) ) : #"off";
        ones = getxhash( string( level.safetycounter % 10 ) );
        level.var_a564626bcb66b0e5 setscriptablepartstate( #"thousands", thousands );
        level.var_a564626bcb66b0e5 setscriptablepartstate( #"hundreds", hundreds );
        level.var_a564626bcb66b0e5 setscriptablepartstate( #"hash_fa42e7ef19ca8b85", tens );
        level.var_a564626bcb66b0e5 setscriptablepartstate( #"hash_715e4b46adbc9d4", ones );
    }
}

// Namespace mp_sat_whiteout
// Params 0, eflags: 0x4
// Checksum 0x756dc7e, Offset: 0x98b
// Size: 0xd4
function private setup_no_deploy_zones()
{
    var_619d6a48f5a56867 = getentarray( "no_equipment_zone", #script_noteworthy );
    weaponfilter = [ #"remote_robot":1, #"super_gas_trap":1 ];
    
    foreach ( var_4f16c60769e4f39a in var_619d6a48f5a56867 )
    {
        var_4f16c60769e4f39a.weaponfilter = weaponfilter;
    }
    
    callback::callback( #"hash_500e33f5505ca842", { #var_619d6a48f5a56867:var_619d6a48f5a56867 } );
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0x9a3918e6, Offset: 0xa67
// Size: 0x18f
function control_panel_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    level.var_75d876dd32afb03f = undefined;
    level.var_89cd62d3122f7052 = undefined;
    scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &control_panel_activate );
    scriptable::scriptable_addnotifycallback( "transmitter_damaged", &control_panel_activate );
    var_c4c19cd0e72fe598 = getentitylessscriptablearray( "button_inclinator", #script_noteworthy );
    var_44caf2e74d046555 = getentarray( "button_trigger", #script_noteworthy );
    
    foreach ( t_close_prompt in var_44caf2e74d046555 )
    {
        t_close_prompt setusableenabled( 1 );
        t_close_prompt sethintstring( &"MP/USE_AUTO_DESCENDER" );
        t_close_prompt setusefov( 120 );
        t_close_prompt setuserange( 48 );
        
        if ( t_close_prompt.script_label == "upper" )
        {
            level.var_75d876dd32afb03f = t_close_prompt;
        }
        else if ( t_close_prompt.script_label == "lower" )
        {
            level.var_89cd62d3122f7052 = t_close_prompt;
        }
        
        t_close_prompt thread function_757e89694284a1ba();
    }
    
    function_debb0daa6c74e94f( 1 );
    
    if ( var_c4c19cd0e72fe598.size + var_44caf2e74d046555.size > 0 )
    {
        level thread function_6a3b2fdef09b778d( var_c4c19cd0e72fe598, var_44caf2e74d046555, level.s_inclinator );
    }
}

// Namespace mp_sat_whiteout
// Params 6, eflags: 0x4
// Checksum 0xe0695a0d, Offset: 0xbfe
// Size: 0x5b
function private control_panel_activate( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    if ( e_instance.script_noteworthy == "button_inclinator" )
    {
        level notify( #"button_used", e_player );
    }
}

// Namespace mp_sat_whiteout
// Params 0, eflags: 0x4
// Checksum 0x1f846d75, Offset: 0xc61
// Size: 0x3d
function private function_757e89694284a1ba()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", e_user );
        level notify( #"button_used", e_user );
    }
}

// Namespace mp_sat_whiteout
// Params 3, eflags: 0x4
// Checksum 0x4d84028c, Offset: 0xca6
// Size: 0x37f
function private function_6a3b2fdef09b778d( var_c4c19cd0e72fe598, var_44caf2e74d046555, e_mover )
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_df6b5577b05db5d0", 0 ) )
    {
        function_fe2bb82f5d223406( var_c4c19cd0e72fe598 );
        return;
    }
    
    b_first_time_use = 1;
    
    while ( true )
    {
        level waittill( #"button_used", e_user );
        
        if ( b_first_time_use )
        {
            level notify( #"hash_355172a818ac717c" );
            b_first_time_use = 0;
        }
        
        foreach ( scr_button in var_c4c19cd0e72fe598 )
        {
            scr_button setscriptablepartstate( "arcwire_transmitter", "activate" );
        }
        
        foreach ( t_close_prompt in var_44caf2e74d046555 )
        {
            t_close_prompt setusableenabled( 0 );
        }
        
        wait 0.5;
        moving_platforms::moving_platform_activate( e_mover );
        e_mover waittill( #"hash_9f51e66e91db7717" );
        wait 4;
        
        foreach ( scr_button in var_c4c19cd0e72fe598 )
        {
            scr_button setscriptablepartstate( "arcwire_transmitter", "standby" );
        }
        
        foreach ( t_close_prompt in var_44caf2e74d046555 )
        {
            t_close_prompt setusableenabled( 1 );
        }
        
        if ( level.var_9e0358431bbb2a1f )
        {
            function_debb0daa6c74e94f( 1 );
            
            foreach ( t_close_prompt in var_44caf2e74d046555 )
            {
                t_close_prompt sethintstring( &"MP/USE_AUTO_DESCENDER" );
            }
        }
        else
        {
            function_debb0daa6c74e94f( 0 );
            
            foreach ( t_close_prompt in var_44caf2e74d046555 )
            {
                t_close_prompt sethintstring( &"MP/USE_AUTO_ASCENDER" );
            }
            
            e_mover thread function_a940d04cf585ab4f();
        }
        
        level.var_9e0358431bbb2a1f = !level.var_9e0358431bbb2a1f;
    }
}

// Namespace mp_sat_whiteout
// Params 1
// Checksum 0xbafef11d, Offset: 0x102d
// Size: 0x86
function function_fe2bb82f5d223406( var_c4c19cd0e72fe598 )
{
    foreach ( scr_button in var_c4c19cd0e72fe598 )
    {
        scr_button setscriptablepartstate( "arcwire_transmitter", "disabled" );
    }
}

// Namespace mp_sat_whiteout
// Params 1
// Checksum 0x443b2deb, Offset: 0x10bb
// Size: 0x8a
function function_debb0daa6c74e94f( var_22754e38a04d6172 )
{
    if ( var_22754e38a04d6172 == 0 )
    {
        if ( isdefined( level.var_75d876dd32afb03f ) )
        {
            level.var_75d876dd32afb03f hide();
        }
        
        if ( isdefined( level.var_89cd62d3122f7052 ) )
        {
            level.var_89cd62d3122f7052 show();
        }
        
        return;
    }
    
    if ( var_22754e38a04d6172 == 1 )
    {
        if ( isdefined( level.var_75d876dd32afb03f ) )
        {
            level.var_75d876dd32afb03f show();
        }
        
        if ( isdefined( level.var_89cd62d3122f7052 ) )
        {
            level.var_89cd62d3122f7052 hide();
        }
    }
}

// Namespace mp_sat_whiteout
// Params 2
// Checksum 0x450e48e3, Offset: 0x114d
// Size: 0xd4
function function_3301daf0bb821038( var_f149be4c6d71abc7, e_mover )
{
    level endon( #"game_ended" );
    level waittill( #"hash_355172a818ac717c" );
    
    foreach ( scr_chevron in var_f149be4c6d71abc7 )
    {
        scr_chevron scriptableclearparententity();
        scr_chevron scriptablesetparententity( e_mover, scr_chevron.origin - e_mover.origin, scr_chevron.angles - e_mover.angles );
    }
}

// Namespace mp_sat_whiteout
// Params 1
// Checksum 0x5839d6bd, Offset: 0x1229
// Size: 0x34
function function_a940d04cf585ab4f( e_mover )
{
    level endon( #"game_ended" );
    level endon( #"button_used" );
    wait 15;
    level notify( #"button_used", undefined );
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0xfc5e2e96, Offset: 0x1265
// Size: 0x77c
function function_c854d9a790ddeb5e()
{
    e_objective_platform = getent( "moving_platform_obj", #targetname );
    var_9349e424962b8eb0 = game_utility::getgametype();
    
    if ( var_9349e424962b8eb0 == "sd" )
    {
        flags::function_2f3408423ccc9b2e( "bombZones_ready" );
        var_ca9acf9265e55d2e = [];
        s_bombzone = level.objectives[ "_a" ];
        var_b09dc3cda2327dca = s_bombzone.trigger;
        var_60d096117d339efe = s_bombzone.visuals[ 0 ];
        var_7f4db202932be1fe = getent( "moving_bombzone_a_collision", #targetname );
        var_1b0b12f08730b69b = getent( "damaged_bombzone_a", #script_noteworthy );
        var_ca9acf9265e55d2e[ var_ca9acf9265e55d2e.size ] = var_b09dc3cda2327dca;
        var_ca9acf9265e55d2e[ var_ca9acf9265e55d2e.size ] = var_60d096117d339efe;
        var_ca9acf9265e55d2e[ var_ca9acf9265e55d2e.size ] = var_7f4db202932be1fe;
        var_ca9acf9265e55d2e[ var_ca9acf9265e55d2e.size ] = var_1b0b12f08730b69b;
        
        foreach ( var_becc84db71389190 in var_ca9acf9265e55d2e )
        {
            var_becc84db71389190 enablelinkto();
            var_becc84db71389190 linkto( e_objective_platform );
        }
        
        s_bombzone.objidnum = obj_bombzone::getreservedobjid( s_bombzone.objectivekey );
        
        if ( !isdefined( s_bombzone.offset3d ) )
        {
            s_bombzone.offset3d = ( 0, 0, 64 );
        }
        
        s_bombzone.var_9795757cb4772679 = var_b09dc3cda2327dca.origin + s_bombzone.offset3d - e_objective_platform.origin;
        var_b09dc3cda2327dca.gameobject = s_bombzone;
        e_objective_platform.var_33280ff0477f0390 = var_b09dc3cda2327dca;
        e_objective_platform thread function_f3fd5eaa29a303c7();
    }
    
    var_f480d7448f241467 = function_84923af2e3155e47();
    
    foreach ( var_a3d8175dffc8bef2 in var_f480d7448f241467 )
    {
        var_e404d5921ae3bcc3 = [];
        var_e404d5921ae3bcc3[ 0 ] = [ ( 1199, -4062, 448 ), ( 0, 0, 0 ) ];
        var_e404d5921ae3bcc3[ 1 ] = [ ( 1199, -4126.01, 448 ), ( 0, 0, 0 ) ];
        var_e404d5921ae3bcc3[ 2 ] = [ ( 1199, -4190.01, 448 ), ( 0, 0, 0 ) ];
        var_e404d5921ae3bcc3[ 3 ] = [ ( 1199, -4254.01, 448 ), ( 0, 0, 0 ) ];
        var_e404d5921ae3bcc3[ 4 ] = [ ( 1253.07, -4288.11, 448 ), ( 0, 90, 0 ) ];
        var_e404d5921ae3bcc3[ 5 ] = [ ( 1317.07, -4288.11, 448 ), ( 0, 90, 0 ) ];
        var_e404d5921ae3bcc3[ 6 ] = [ ( 1381.07, -4288.11, 448 ), ( 0, 90, 0 ) ];
        var_e404d5921ae3bcc3[ 7 ] = [ ( 1445.07, -4288.11, 448 ), ( 0, 90, 0 ) ];
        var_e404d5921ae3bcc3[ 8 ] = [ ( 1509.07, -4288.11, 448 ), ( 0, 90, 0 ) ];
        var_e404d5921ae3bcc3[ 9 ] = [ ( 1551, -4246, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 10 ] = [ ( 1551, -4182, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 11 ] = [ ( 1551, -4118, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 12 ] = [ ( 1551, -4054, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 13 ] = [ ( 1551, -3990, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 14 ] = [ ( 1551, -3926, 447 ), ( 0, 180, 0 ) ];
        var_e404d5921ae3bcc3[ 15 ] = [ ( 1512.88, -3903.88, 447 ), ( 0, -90, 0 ) ];
        var_e404d5921ae3bcc3[ 16 ] = [ ( 1448.88, -3903.88, 447 ), ( 0, -90, 0 ) ];
        var_fd0032a62ad85144 = [];
        var_d362324ee152cea4 = 0;
        
        foreach ( scr_chevron in level.objectives[ var_a3d8175dffc8bef2.script_label ].chevrons )
        {
            v_origin = var_e404d5921ae3bcc3[ var_d362324ee152cea4 % var_e404d5921ae3bcc3.size ][ 0 ];
            var_4703226852537734 = var_e404d5921ae3bcc3[ var_d362324ee152cea4 % var_e404d5921ae3bcc3.size ][ 1 ];
            var_3f5e8aa838e40ef3 = spawnscriptable( "sat_gamemode_chevron_dynamic", v_origin, var_4703226852537734 );
            var_3f5e8aa838e40ef3.numchevrons = scr_chevron.numchevrons;
            var_fd0032a62ad85144[ var_fd0032a62ad85144.size ] = var_3f5e8aa838e40ef3;
            var_1a5d8528edba5ab0 = "chevron_";
            
            for ( i = 0; i < scr_chevron.numchevrons ; i++ )
            {
                scr_chevron setscriptablepartstate( var_1a5d8528edba5ab0 + i, "off" );
                var_3f5e8aa838e40ef3 setscriptablepartstate( var_1a5d8528edba5ab0 + i, "idle" );
            }
            
            level thread function_3301daf0bb821038( var_fd0032a62ad85144, e_objective_platform );
            var_d362324ee152cea4++;
        }
        
        level.objectives[ var_a3d8175dffc8bef2.script_label ].chevrons = [];
        level.objectives[ var_a3d8175dffc8bef2.script_label ].chevrons = var_fd0032a62ad85144;
        var_a3d8175dffc8bef2 enablelinkto();
        var_a3d8175dffc8bef2 linkto( e_objective_platform );
        e_objective_platform.var_33280ff0477f0390 = var_a3d8175dffc8bef2;
        s_game_object = e_objective_platform.var_33280ff0477f0390.gameobject;
        s_game_object.var_9795757cb4772679 = var_a3d8175dffc8bef2.origin + s_game_object.offset3d - e_objective_platform.origin;
    }
    
    if ( isdefined( e_objective_platform.var_33280ff0477f0390 ) )
    {
        s_game_object = e_objective_platform.var_33280ff0477f0390.gameobject;
        objidpoolmanager::update_objective_position( s_game_object.objidnum, e_objective_platform.origin + s_game_object.var_9795757cb4772679 );
        e_objective_platform thread function_3172881eadc8af8d();
    }
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0x124ecfe3, Offset: 0x19e9
// Size: 0xf1
function function_f3fd5eaa29a303c7()
{
    level endon( #"game_ended" );
    level waittill( #"bomb_planted", var_2b61a15bc7c446a7, var_36ffb15abee4b430 );
    waitframe();
    
    if ( var_2b61a15bc7c446a7.objectivekey != "_a" )
    {
        return;
    }
    
    if ( var_36ffb15abee4b430 )
    {
        var_2b61a15bc7c446a7.bombdefusetrig.origin = var_36ffb15abee4b430.origin;
        level.sdbombmodel.origin = var_36ffb15abee4b430.origin;
    }
    
    var_2b61a15bc7c446a7.bombdefusetrig enablelinkto();
    var_2b61a15bc7c446a7.bombdefusetrig linkto( self );
    level.sdbombmodel enablelinkto();
    level.sdbombmodel linkto( self );
    var_2b61a15bc7c446a7.var_9795757cb4772679 = var_2b61a15bc7c446a7.offset3d;
    level.sdbombmodel thread function_d2de282fb72715be();
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0x76beed04, Offset: 0x1ae2
// Size: 0xac
function function_d2de282fb72715be()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        objidpoolmanager::update_objective_position( level.defuseobject.objidnum, self.origin + level.defuseobject.offset3d );
        
        if ( level.defuseobject.radialtimeobjid )
        {
            objidpoolmanager::update_objective_position( level.defuseobject.radialtimeobjid, self.origin + level.defuseobject.offset3d );
        }
        
        wait 0.25;
    }
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0xc8e38d62, Offset: 0x1b96
// Size: 0xae
function function_84923af2e3155e47()
{
    var_9349e424962b8eb0 = game_utility::getgametype();
    
    if ( !arraycontains( [ "dom", "koth" ], var_9349e424962b8eb0 ) )
    {
        return;
    }
    
    switch ( var_9349e424962b8eb0 )
    {
        case #"hash_f4a9126c03d3385b":
            t_dom_b = getent( "b", #target );
            var_f480d7448f241467 = [ t_dom_b ];
            break;
        case #"hash_6efb0f59a62300fb":
            var_c8c2c40e19516bdd = getent( "hardpoint_vis_01", #target );
            var_f480d7448f241467 = [ var_c8c2c40e19516bdd ];
            break;
    }
    
    return var_f480d7448f241467;
}

// Namespace mp_sat_whiteout
// Params 0
// Checksum 0xad726616, Offset: 0x1c4d
// Size: 0x5d
function function_3172881eadc8af8d()
{
    level endon( #"game_ended" );
    s_game_object = self.var_33280ff0477f0390.gameobject;
    
    while ( true )
    {
        objidpoolmanager::update_objective_position( s_game_object.objidnum, self.origin + s_game_object.var_9795757cb4772679 );
        waitframe();
    }
}

// Namespace mp_sat_whiteout
// Params 0, eflags: 0x4
// Checksum 0xaea5fb4e, Offset: 0x1cb2
// Size: 0x14a
function private function_860d46fc950fc220()
{
    var_29425392539aba5c = getnoentvolumearray( "crush_zone_inclinator", #script_noteworthy );
    var_789eb79622e56fed = getnoentvolumearray( "crush_zone_railing", #script_noteworthy );
    
    foreach ( t_crush_zone in var_29425392539aba5c )
    {
        utility::function_9fc28d50a2652cd7( t_crush_zone );
        t_crush_zone thread function_1b89513d86c59df6( level.s_inclinator );
    }
    
    foreach ( t_crush_zone in var_789eb79622e56fed )
    {
        utility::function_9fc28d50a2652cd7( t_crush_zone );
        t_crush_zone thread function_1b89513d86c59df6( level.s_railing );
        t_crush_zone thread crush_instant( level.s_railing );
    }
}

// Namespace mp_sat_whiteout
// Params 1, eflags: 0x4
// Checksum 0xd56dcb56, Offset: 0x1e04
// Size: 0x7a
function private function_1b89513d86c59df6( e_moving_platform )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        e_moving_platform waittill( #"hash_184a6e52b6a45c2" );
        thread utility::function_6949f16f10cfdbee( e_moving_platform.t_crush_zone );
        e_moving_platform.t_crush_zone thread utility::function_6949f16f10cfdbee( self );
        e_moving_platform waittill( #"hash_9f51e66e91db7717" );
        thread utility::function_9074f7fdf422f8e5();
        e_moving_platform.t_crush_zone thread utility::function_9074f7fdf422f8e5();
    }
}

// Namespace mp_sat_whiteout
// Params 1, eflags: 0x4
// Checksum 0x446f3839, Offset: 0x1e86
// Size: 0x4a
function private crush_instant( e_moving_platform )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        e_moving_platform waittill( #"hash_184a6e52b6a45c2" );
        thread utility::function_5ca354a4734a1bd8();
        e_moving_platform waittill( #"hash_9f51e66e91db7717" );
        thread utility::function_9074f7fdf422f8e5();
    }
}

