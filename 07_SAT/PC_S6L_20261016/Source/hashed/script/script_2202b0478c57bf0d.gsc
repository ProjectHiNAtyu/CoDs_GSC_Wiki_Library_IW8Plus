// script_2202b0478c57bf0d  (hash_2202b0478c57bf0d.gscc) (size: 16027 Bytes / 0x3e9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6bdfc614 (1809827348)
// size ...... 16027 (0x3e9b)
// includes .. 15  (offset: 0x3c4b)
// strings ... 33  (offset: 0x3cc3)
// dev strs .. 0   (offset: 0x3e9b)
// exports ... 34  (offset: 0x2893)
// cseg ...... 0x403 + 0x2490 (0x2893)
// imports ... 123 (offset: 0x2de3)
// animtree1 . 0   (offset: 0x3e9b)
// animtree2 . 0   (offset: 0x3e9b)
#using script_3f883e880904e5df;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_redeploy_drone;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\weapons;

#namespace namespace_df4ff65d6946b16b;

// Namespace namespace_df4ff65d6946b16b
// Params 0, eflags: 0x5
// Checksum 0x23e5365a, Offset: 0x421
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e530a7c8440f2456", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0, eflags: 0x4
// Checksum 0xeb0cb7e1, Offset: 0x44a
// Size: 0x38
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"start_airdrop", #"drone", &function_a6b97d86b3d5be99 );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1, eflags: 0x4
// Checksum 0x39e9ca2c, Offset: 0x48a
// Size: 0x1b4
function private function_a6b97d86b3d5be99( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    groundlocation = airdrop_scriptbundle::function_15ad4ce1fcf6748f( airdropsettings.droparea.origin ) ?? airdropsettings.droparea.origin;
    dropheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.dropheight;
    droplocation = ( groundlocation[ 0 ], groundlocation[ 1 ], groundlocation[ 2 ] + dropheight );
    direction = function_df1dbe06b913fcaa( airdropsettings, droplocation );
    
    if ( !isdefined( direction ) )
    {
        direction = vectornormalize2( getclosestpointonnavmesh( groundlocation ) - droplocation );
    }
    
    angles = generateaxisanglesfromforwardvector( direction, ( 0, 0, 1 ) );
    startinglocation = direction * -1 * var_ef8325c1086c2688.var_c19302c2e279c016 + ( 0, 0, var_ef8325c1086c2688.var_bde4c92c3498277a );
    goto = { #angles:angles, #exit:( startinglocation[ 0 ] + droplocation[ 0 ], startinglocation[ 1 ] + droplocation[ 1 ], startinglocation[ 2 ] ), #groundorigin:groundlocation, #origin:droplocation };
    drone = spawndrone( goto, airdropsettings );
    drone function_189d2f8a4ccd9ccf();
    return [ drone.package ];
}

// Namespace namespace_df4ff65d6946b16b
// Params 2
// Checksum 0x3cf8348, Offset: 0x647
// Size: 0x29e
function spawndrone( goto, airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    drone = spawn( "script_model", goto.exit );
    drone.type = "portable_buy_drone";
    drone setmodel( var_ef8325c1086c2688.dronemodel );
    drone forcenetfieldhighlod( 1 );
    level.package_airdrop.activedrones[ level.package_airdrop.activedrones.size ] = drone;
    drone.goto = goto;
    drone.angles = ( 0, randomint( 360 ), 0 );
    drone.speed = 0;
    drone.health = var_ef8325c1086c2688.dronehealth;
    drone.maxhealth = drone.health;
    drone.owner = airdropsettings.player;
    drone.team = airdropsettings.team;
    drone.airdropsettings = airdropsettings;
    drone.spawnlocation = goto.exit;
    drone.var_fe3437bbc52ad866 = var_ef8325c1086c2688.var_fe3437bbc52ad866;
    drone airdrop_scriptbundle::function_e9dbf2aaef9f1c96( airdropsettings, #"hash_cb68d69fe85eb56f", drone );
    drone function_8eeb9413290d228a();
    drone function_10e8d6741e0d6693();
    calloutmarkerping::function_6052d1ed5729bcfc( drone );
    
    if ( drone.var_fe3437bbc52ad866 )
    {
        utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", drone, &droneemp );
        
        if ( level.var_36218e71baa7e689 )
        {
            drone.var_c5ccf9dff3b5e393 = &function_9df8d8c8ffb546dd;
        }
        
        if ( level.var_36218e71baa7e689 )
        {
            level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = drone;
        }
    }
    
    if ( var_ef8325c1086c2688.var_c11f182c49a6ea82 )
    {
        drone setcandamage( 1 );
        drone.package.maxhealth = 999999999;
        drone.package.health = 999999999;
        weapons::function_ef0cb557b1a93af9( drone );
        drone thread function_3478c089f2f490c3();
    }
    else
    {
        drone setcandamage( 0 );
    }
    
    return drone;
}

// Namespace namespace_df4ff65d6946b16b
// Params 2, eflags: 0x4
// Checksum 0x203aa9de, Offset: 0x8ee
// Size: 0x390
function private function_df1dbe06b913fcaa( airdropsettings, location )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    spawnangles = ( 0, 0, 0 );
    
    if ( !isdefined( airdropsettings.player ) )
    {
        spawnangles = ( 0, randomfloatrange( 0, 360 ), 0 );
    }
    else
    {
        spawnangles = airdropsettings.player.angles;
    }
    
    contents = trace::create_default_contents( 1 );
    targetpos = location;
    targetheightoffset = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.dropheight;
    ownerforward = anglestoforward( spawnangles );
    ownerright = anglestoright( spawnangles );
    var_4159891f0b5bc03 = [ targetpos + ( -1 * ownerforward - ownerright ) * 100, targetpos + ( ownerright - ownerforward ) * 100, targetpos - ownerforward * 100, targetpos + ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + ( ownerforward + ownerright ) * 100, targetpos + ( ownerforward - ownerright ) * 100 ];
    bestdirection = vectornormalize( var_4159891f0b5bc03[ 2 ] - targetpos );
    var_102bbb6895ac37ca = 0;
    
    foreach ( dirpos in var_4159891f0b5bc03 )
    {
        var_8ba4b8834e7ce583 = vectornormalize( dirpos - targetpos );
        var_95a138eeb696530a = targetpos * ( 1, 1, 0 ) + ( 0, 0, targetheightoffset );
        var_abf75242f26b5e61 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * 24000;
        var_fe99d25d98da8c34 = var_95a138eeb696530a + var_8ba4b8834e7ce583 * 24000;
        traceresult = trace::ray_trace_passed( var_abf75242f26b5e61, var_fe99d25d98da8c34, undefined, contents );
        
        if ( !traceresult )
        {
            continue;
        }
        
        var_74b5881494d6d647 = var_95a138eeb696530a - var_8ba4b8834e7ce583 * int( 8000 );
        var_34a14ec7788b1717 = [ targetpos, targetpos - var_8ba4b8834e7ce583 * 512, targetpos - var_8ba4b8834e7ce583 * 256, targetpos + var_8ba4b8834e7ce583 * 256, targetpos + var_8ba4b8834e7ce583 * 512 ];
        successfulhits = 0;
        
        foreach ( endtracepos in var_34a14ec7788b1717 )
        {
            results = trace::ray_trace( var_74b5881494d6d647, endtracepos, undefined, contents );
            traceresult = results[ "fraction" ] == 1;
            
            if ( !traceresult )
            {
                continue;
            }
            
            successfulhits++;
        }
        
        if ( successfulhits > var_102bbb6895ac37ca )
        {
            bestdirection = var_8ba4b8834e7ce583;
            var_102bbb6895ac37ca = successfulhits;
            
            if ( successfulhits >= 3 )
            {
                break;
            }
        }
    }
    
    return bestdirection;
}

// Namespace namespace_df4ff65d6946b16b
// Params 0, eflags: 0x4
// Checksum 0xc71e3943, Offset: 0xc87
// Size: 0x164
function private function_10e8d6741e0d6693()
{
    drone = self;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    package = namespace_f00cbee467b4e1f3::createcrate( drone.airdropsettings, drone.origin, drone.goto.groundorigin, ( 0, 0, 0 ), undefined, 0 );
    package.drone = drone;
    package.var_57eb671c310bb38e = drone function_c48a408d8c7eb9be();
    drone.skipminimapicon = 1;
    package linkto( drone, "tag_origin", ( 0, 0, -100 ), ( 0, 0, 0 ) );
    
    if ( var_ef8325c1086c2688.var_c11f182c49a6ea82 )
    {
        package setcandamage( 1 );
        package thread function_49207a4eaf4d0353();
    }
    else
    {
        package setcandamage( 0 );
    }
    
    drone function_9e7626e811447e42();
    
    if ( !var_ef8325c1086c2688.var_df84b7e421e56c71 )
    {
        package setscriptablepartstate( #"objective", #"inactive", 0 );
    }
    
    drone.package = package;
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0x88592709, Offset: 0xdf3
// Size: 0x65
function function_273cf4bf486db488( var_ef8325c1086c2688 )
{
    drone = self;
    
    if ( !var_ef8325c1086c2688.neverdrop && !drone.airdropsettings.extradata.skipdrop && !drone.var_a1e594c2cae42e0b )
    {
        drone function_e3d98a41bdf8695();
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 2, eflags: 0x4
// Checksum 0xab62b54f, Offset: 0xe60
// Size: 0x1bc
function private function_e3d98a41bdf8695( eattacker, detachvelocity = undefined )
{
    drone = self;
    
    if ( !isdefined( drone.package ) )
    {
        return;
    }
    
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    drone.package airdrop::cratephysicson( undefined, detachvelocity );
    drone.package setcandamage( 0 );
    drone.package.eattacker = eattacker;
    drone.package.var_57eb671c310bb38e = drone function_c48a408d8c7eb9be();
    drone function_3168a034ee7decb5();
    
    if ( utility::issharedfuncdefined( #"redeploy_drone", #"dropbag_collision_watcher" ) )
    {
        drone.package thread [[ utility::getsharedfunc( #"redeploy_drone", #"dropbag_collision_watcher" ) ]]();
    }
    
    drone playsound( "br_deployable_kiosk_detach" );
    
    if ( !var_ef8325c1086c2688.var_df84b7e421e56c71 )
    {
        drone.package setscriptablepartstate( #"objective", #"active", 0 );
    }
    
    drone.var_a1e594c2cae42e0b = 1;
    drone analyticsdronedelivery();
    calloutmarkerping::function_9bd4bf4f8fe74b16( drone, drone.package, 9 );
    calloutmarkerping::function_ab4e5514677fba94( drone );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_e9a6accd033eb4b9", drone, eattacker );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xddf4f64d, Offset: 0x1024
// Size: 0x176
function function_189d2f8a4ccd9ccf()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"drone_emp_leave" );
    drone.var_a1e594c2cae42e0b = 0;
    goto = { #angles:drone.goto.angles, #origin:drone.goto.origin };
    dronemove( goto, 0 );
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.var_c0fb7c4e7d7e5925 > 0 )
    {
        goto.origin = ( drone.goto.origin[ 0 ], drone.goto.origin[ 1 ], drone.goto.origin[ 2 ] - var_ef8325c1086c2688.var_c0fb7c4e7d7e5925 );
        drone dronemove( goto, 0, var_ef8325c1086c2688.var_45aa07a9a3fad2e1, 1 );
    }
    
    function_273cf4bf486db488( var_ef8325c1086c2688 );
    drone thread function_7a48b23074c12bce();
}

// Namespace namespace_df4ff65d6946b16b
// Params 4
// Checksum 0x276f27ac, Offset: 0x11a2
// Size: 0x170
function dronemove( goto, reversing, speed, skiprotation )
{
    drone = self;
    drone thread function_81c71353bbf9044e();
    drone.b_movement_complete = undefined;
    drone.var_fe7274eb7e5153e7 = undefined;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( !reversing && !isdefined( speed ) )
    {
        drone.speed = var_ef8325c1086c2688.var_975fca1eaa4989af;
    }
    
    var_c9ba3343f54f1e08 = br_redeploy_drone::function_4932b017680a36b1();
    var_c9ba3343f54f1e08.i_min_speed = 2;
    var_c9ba3343f54f1e08.i_max_speed = speed ?? var_ef8325c1086c2688.var_b23dd50afb4efe09;
    drone thread br_redeploy_drone::function_f8019c12697fcf50( goto, var_c9ba3343f54f1e08 );
    
    if ( !skiprotation )
    {
        drone thread br_redeploy_drone::function_76cb6eb6a9700637( goto, var_c9ba3343f54f1e08 );
    }
    
    drone waittill( #"redeploy_drone_arrive" );
    
    while ( !reversing && ( !isdefined( drone.b_movement_complete ) || !isdefined( drone.var_fe7274eb7e5153e7 ) && !skiprotation ) )
    {
        wait 1;
    }
    
    drone.b_movement_complete = undefined;
    drone.var_fe7274eb7e5153e7 = undefined;
}

// Namespace namespace_df4ff65d6946b16b
// Params 1, eflags: 0x4
// Checksum 0xb6fcd2e2, Offset: 0x131a
// Size: 0xb2
function private function_7a48b23074c12bce( var_51c40de57d9f0f54 = 3 )
{
    drone = self;
    
    if ( drone.var_44f52ace6119ee1d )
    {
        return;
    }
    
    drone.var_44f52ace6119ee1d = 1;
    wait var_51c40de57d9f0f54;
    goto = drone.goto;
    goto.origin = drone.goto.exit;
    dronemove( goto, 1 );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_82fb75eefaf0a89a", drone );
    drone function_526012cdc7caf315();
    deletedrone( drone );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1, eflags: 0x4
// Checksum 0x9f5cf152, Offset: 0x13d4
// Size: 0x85
function private droneemp( data )
{
    drone = self;
    
    if ( drone.var_dcf7b7678590b6c5 )
    {
        return;
    }
    
    drone.var_dcf7b7678590b6c5 = 1;
    drone setcandamage( 0 );
    drone notify( #"stop_moving" );
    drone notify( #"drone_emp_leave" );
    
    if ( !drone.var_a1e594c2cae42e0b )
    {
        drone function_e3d98a41bdf8695( data.attacker );
    }
    
    drone thread function_7a48b23074c12bce( 0 );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1, eflags: 0x4
// Checksum 0xe674222b, Offset: 0x1461
// Size: 0x15
function private function_9df8d8c8ffb546dd( data )
{
    thread droneemp( data );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0x7daff76c, Offset: 0x147e
// Size: 0xc7
function deletedrone( drone )
{
    if ( drone )
    {
        if ( !drone.var_a1e594c2cae42e0b && drone.package )
        {
            drone.package delete();
        }
        
        airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_be72da1e5785d4d0", drone );
        weapons::function_d5eafafe8f6a97bf( drone );
        level.package_airdrop.activedrones = arrayremove( level.package_airdrop.activedrones, drone );
        drone delete();
        return;
    }
    
    level.package_airdrop.activedrones = function_5713d46873b29625( level.package_airdrop.activedrones );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xf63d084c, Offset: 0x154d
// Size: 0x5b
function function_81c71353bbf9044e()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    wait 1;
    drone setscriptablepartstate( "redeploy_drone_relocation_sfx", "kiosk_drone_move_sfx" );
    drone waittill( #"redeploy_drone_arrive" );
    drone setscriptablepartstate( "redeploy_drone_relocation_sfx", "kiosk_drone_idle_sfx" );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0, eflags: 0x4
// Checksum 0xa7fa5467, Offset: 0x15b0
// Size: 0x10e
function private function_49207a4eaf4d0353()
{
    package = self;
    level endon( #"game_ended" );
    package endon( #"entitydeleted" );
    package endon( #"death" );
    package.drone endon( #"packaged_dropped" );
    
    while ( true )
    {
        package waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isdefined( package.drone ) && !package.drone.var_a1e594c2cae42e0b )
        {
            package.drone function_52b3f12af75e9030( idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        }
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 0, eflags: 0x4
// Checksum 0x8f8f3607, Offset: 0x16c6
// Size: 0xc5
function private function_3478c089f2f490c3()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"drone_shot_down" );
    
    while ( true )
    {
        drone waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        drone function_52b3f12af75e9030( idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 10, eflags: 0x4
// Checksum 0x4569e4ae, Offset: 0x1793
// Size: 0x312
function private function_52b3f12af75e9030( idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon )
{
    drone = self;
    resolvedattacker = isplayer( eattacker ) ? eattacker : isplayer( eattacker.owner ) ? eattacker.owner : undefined;
    var_795e8a31194a39ac = { #var_3e13d05260eee4e1:1, #var_4dba57e6e29ded8e:1, #var_f561a4dd442b0d91:1 };
    
    if ( resolvedattacker )
    {
        resolvedattacker damagefeedback::updatehitmarker( "hitequip", drone.health == 0, 0, 1, "hitequip", undefined, undefined, var_795e8a31194a39ac, 1 );
    }
    
    if ( eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg" )
    {
        level thread br_redeploy_drone::function_cbbeb2f71936b10e( eattacker, drone.origin );
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a86d8c43482948a4":
        case #"hash_a911a1880d996edb":
        case #"hash_c22b13f81bed11f0":
            idamage = int( idamage * level.redeploy_drone_info_struct.var_9e437065f024b3dd );
            break;
    }
    
    if ( modelname == "ks_airstrike_target_br_ch3" )
    {
        idamage = level.redeploy_drone_info_struct.var_4f3cd2a57aac6ea6;
    }
    
    drone.health -= idamage;
    
    if ( !isdefined( drone.var_1994a551a4e4de5b ) )
    {
        drone.var_1994a551a4e4de5b = 0;
    }
    
    drone.var_1994a551a4e4de5b += 1;
    
    if ( isdefined( objweapon ) && objweapon.basename == "toma_proj_mp" )
    {
        drone.health = 0;
    }
    
    if ( drone.health <= 0 )
    {
        drone thread dronedestroyed( resolvedattacker );
        drone notify( #"drone_shot_down" );
        return;
    }
    
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.var_1fc1ea618268b617 && isdefined( self.var_a1e594c2cae42e0b ) && !self.var_a1e594c2cae42e0b )
    {
        drone thread function_7bb71bd8617aab6c( resolvedattacker );
    }
    
    drone function_c86427bd7d0b3189( resolvedattacker );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_ad000e5ba06523ee", drone, resolvedattacker );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0x1a6dab16, Offset: 0x1aad
// Size: 0x16a
function function_7bb71bd8617aab6c( eattacker )
{
    drone = self;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    healthbaramount = drone.maxhealth / var_ef8325c1086c2688.var_41fb6a3d01916f5c;
    
    if ( !isdefined( drone.var_90ff7795f6dcc3e2 ) )
    {
        drone.var_90ff7795f6dcc3e2 = var_ef8325c1086c2688.var_41fb6a3d01916f5c + 1;
    }
    
    for ( i = var_ef8325c1086c2688.var_41fb6a3d01916f5c; i > 0 ; i-- )
    {
        if ( drone.health < healthbaramount * i )
        {
            if ( drone.var_90ff7795f6dcc3e2 > i )
            {
                drone.var_90ff7795f6dcc3e2 = i;
                droporigin = drone.package.origin - ( 0, 0, 200 );
                itemspawnoptions = common_item::items_initspawnoptions_spawnfromposition( droporigin );
                itemspawnoptions.ignoreents = [ drone ];
                common_item::function_38cde6a6acb68ea6( var_ef8325c1086c2688.var_1fc1ea618268b617, 1, itemspawnoptions );
                break;
            }
        }
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0x9e4e563f, Offset: 0x1c1f
// Size: 0x3b
function function_fe5e5ec4101d44dc()
{
    startorigin = self.origin;
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    return ( self.origin - startorigin ) * 1 / level.framedurationseconds;
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0xee40e6dd, Offset: 0x1c63
// Size: 0xce
function dronedestroyed( eattacker )
{
    drone = self;
    level endon( #"game_ended" );
    function_ce8365a343fe648d( eattacker );
    drone function_fb19909cdff52447( eattacker );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_852023c9f529dca6", drone, eattacker );
    
    if ( !drone.var_a1e594c2cae42e0b && isdefined( drone.package ) )
    {
        drone function_e3d98a41bdf8695( eattacker );
        wait 0.3;
        
        if ( !isdefined( drone ) )
        {
            return;
        }
    }
    
    drone setscriptablepartstate( "redeploy_drone_relocation_smoke_vfx", "enabled" );
    drone physics_registerforcollisioncallback();
    drone thread br_redeploy_drone::function_2f9ddf986e50897();
    drone waittill( #"collision" );
    drone droneexplosion();
    deletedrone( drone );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0x61c115e6, Offset: 0x1d39
// Size: 0xa3
function function_ce8365a343fe648d( eattacker )
{
    if ( isplayer( eattacker ) && eattacker.team != self.airdropsettings.team )
    {
        var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
        
        if ( var_ef8325c1086c2688.var_ce8365a343fe648d )
        {
            eattacker points::doscoreevent( var_ef8325c1086c2688.var_ce8365a343fe648d );
        }
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0x47a2154f, Offset: 0x1de4
// Size: 0xda
function function_c86427bd7d0b3189( eattacker )
{
    if ( !isdefined( self.var_904083cc887feb96 ) )
    {
        self.var_904083cc887feb96 = [];
    }
    
    if ( !arraycontains( self.var_904083cc887feb96, eattacker ) && eattacker.team != self.airdropsettings.team )
    {
        var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ self.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
        self.var_904083cc887feb96[ self.var_904083cc887feb96.size ] = eattacker;
        
        if ( var_ef8325c1086c2688.var_c86427bd7d0b3189 )
        {
            eattacker points::doscoreevent( var_ef8325c1086c2688.var_c86427bd7d0b3189 );
        }
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xb1936ba8, Offset: 0x1ec6
// Size: 0x134
function droneexplosion()
{
    drone = self;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    nearbyplayers = getplayersinradius( drone.origin, var_ef8325c1086c2688.droneexplosionradius );
    
    foreach ( player in nearbyplayers )
    {
        player dodamage( var_ef8325c1086c2688.var_c9812fd06559a36e, drone.origin, player, player, "MOD_CRUSH" );
    }
    
    if ( var_ef8325c1086c2688.explosionscriptable )
    {
        level thread function_6958f357d4e3bb7d( drone.origin, var_ef8325c1086c2688.explosionscriptable );
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 2, eflags: 0x4
// Checksum 0xf0eeb133, Offset: 0x2002
// Size: 0x35
function private function_6958f357d4e3bb7d( origin, var_3cbcf438defc649d )
{
    vfx = spawnscriptable( var_3cbcf438defc649d, origin );
    wait 0.5;
    vfx freescriptable();
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xe6d7a112, Offset: 0x203f
// Size: 0x2f8
function function_9e7626e811447e42()
{
    drone = self;
    airdropsettings = drone.airdropsettings;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( var_ef8325c1086c2688.var_9e7626e811447e42 || var_ef8325c1086c2688.var_df84b7e421e56c71 )
    {
        drone setscriptablepartstate( "redeploy_drone_relocation_objective", "inactive" );
        
        if ( var_ef8325c1086c2688.var_df84b7e421e56c71 )
        {
            return;
        }
    }
    else
    {
        return;
    }
    
    var_9b7a6e48b9a336b5 = isdefined( airdropsettings.team ) && isdefined( var_ef8325c1086c2688.var_32bd400d23eac6e2 );
    objid = objidpoolmanager::requestobjectiveid( 1 );
    objective_state( objid, "active" );
    objective_position( objid, drone.origin );
    objective_setplayintro( objid, 0 );
    objective_onentity( objid, drone );
    objective_setzoffset( objid, 50 );
    objective_setshowdistance( objid, 0 );
    objective_setshowoncompass( objid, 0 );
    function_5a1f9b4d7de0b23b( objid, 1 );
    function_461834c350793158( objid, 1 );
    function_ab75a2ff49451957( objid, istrue( var_ef8325c1086c2688.var_35cd5ee6a36596db ) );
    objidpoolmanager::update_objective_icon( objid, var_ef8325c1086c2688.var_9e7626e811447e42 );
    objidpoolmanager::update_objective_setbackground( objid, 5 );
    objidpoolmanager::function_c34959a44b376957( objid, 12 );
    objidpoolmanager::update_objective_description( objid, var_ef8325c1086c2688.var_b56e67acf0cc0094 );
    objective_setlabel( objid, var_ef8325c1086c2688.var_a1b2b7b2937cc778 );
    
    if ( var_9b7a6e48b9a336b5 )
    {
        objidpoolmanager::objective_teammask_addtomask( objid, airdropsettings.team );
    }
    else
    {
        objidpoolmanager::objective_playermask_showtoall( objid );
    }
    
    function_44a344c68a68f28d( objid, istrue( var_ef8325c1086c2688.var_e62d1d2635dac87a ) );
    objective_sethideelevation( objid, 1 );
    drone.allyobjid = objid;
    
    if ( var_9b7a6e48b9a336b5 )
    {
        objid = objidpoolmanager::requestobjectiveid( 1 );
        objective_state( objid, "active" );
        objective_position( objid, drone.origin );
        objective_setplayintro( objid, 0 );
        objective_onentity( objid, drone );
        objective_setzoffset( objid, 50 );
        objective_setshowdistance( objid, 0 );
        objective_setshowoncompass( objid, 0 );
        function_461834c350793158( objid, 1 );
        function_ab75a2ff49451957( objid, istrue( var_ef8325c1086c2688.var_35cd5ee6a36596db ) );
        objidpoolmanager::update_objective_icon( objid, var_ef8325c1086c2688.var_32bd400d23eac6e2 );
        objidpoolmanager::update_objective_setbackground( objid, 5 );
        objidpoolmanager::function_c34959a44b376957( objid, 12 );
        objidpoolmanager::update_objective_description( objid, var_ef8325c1086c2688.var_b56e67acf0cc0094 );
        objective_setlabel( objid, var_ef8325c1086c2688.var_a1b2b7b2937cc778 );
        function_82680923a320d0af( objid );
        objidpoolmanager::objective_teammask_removefrommask( objid, airdropsettings.team );
        function_44a344c68a68f28d( objid, istrue( var_ef8325c1086c2688.var_e62d1d2635dac87a ) );
        objective_sethideelevation( objid, 1 );
        drone.enemyobjid = objid;
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0x59ab0f62, Offset: 0x233f
// Size: 0xaa
function function_3168a034ee7decb5()
{
    drone = self;
    
    if ( !isdefined( drone ) )
    {
        script::demoforcesre( "Scriptbundle Package Airdrop: Drone loaded icons cleanup called on undefined drone." );
        return;
    }
    
    drone setscriptablepartstate( "redeploy_drone_relocation_objective", "active" );
    
    if ( drone.allyobjid )
    {
        objective_hidefromplayersinmask( drone.allyobjid );
        objidpoolmanager::returnobjectiveid( drone.allyobjid );
        drone.allyobjid = undefined;
    }
    
    if ( drone.enemyobjid )
    {
        objective_hidefromplayersinmask( drone.enemyobjid );
        objidpoolmanager::returnobjectiveid( drone.enemyobjid );
        drone.enemyobjid = undefined;
    }
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xf9393d9d, Offset: 0x23f1
// Size: 0x8a
function function_c48a408d8c7eb9be()
{
    if ( !isdefined( self.var_57eb671c310bb38e ) )
    {
        if ( !isdefined( level.package_airdrop.var_189cb8899e0d4e3e ) )
        {
            level.package_airdrop.var_189cb8899e0d4e3e = 0;
        }
        
        level.package_airdrop.var_189cb8899e0d4e3e += 1;
        self.var_57eb671c310bb38e = level.package_airdrop.var_189cb8899e0d4e3e;
    }
    
    return self.var_57eb671c310bb38e;
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0x4aeaef0c, Offset: 0x2484
// Size: 0x20, Type: bool
function function_2afc02120a7203cf()
{
    return !self.airdropsettings.extradata.skipdrop;
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xa0fe1932, Offset: 0x24ad
// Size: 0xd9
function function_8eeb9413290d228a()
{
    self.spawntime = gettime();
    var_57eb671c310bb38e = function_c48a408d8c7eb9be();
    candrop = function_2afc02120a7203cf();
    poi = poi::poi_findpoioriginisin( self.origin );
    poiname = poi::function_356e66e91a150a02( poi );
    dlog_recordevent( "dlog_event_airdrop_drone_spawned", [ "circle_index", level.br_circle.circleindex ?? -1, "airdrop_name", self.airdropsettings.airdropidentifier, "drone_instance_id", var_57eb671c310bb38e, "can_drop", candrop, "poi_name", poiname ] );
}

// Namespace namespace_df4ff65d6946b16b
// Params 1
// Checksum 0xee169615, Offset: 0x258e
// Size: 0x158
function function_fb19909cdff52447( eattacker )
{
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    lifetime = gettime() - ( self.spawntime ?? gettime() );
    var_57eb671c310bb38e = function_c48a408d8c7eb9be();
    candrop = function_2afc02120a7203cf();
    poi = poi::poi_findpoioriginisin( self.origin );
    poiname = poi::function_356e66e91a150a02( poi );
    shotdistance = distance( self.origin, eattacker.origin );
    eattacker dlog_recordplayerevent( "dlog_event_airdrop_drone_destroyed", [ "circle_index", level.br_circle.circleindex ?? -1, "airdrop_name", self.airdropsettings.airdropidentifier, "drone_instance_id", var_57eb671c310bb38e, "can_drop", candrop, "poi_name", poiname, "lifetime", lifetime, "already_delivered", self.var_a1e594c2cae42e0b, "shot_distance", shotdistance ] );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0xc1f36fd6, Offset: 0x26ee
// Size: 0xd1
function function_526012cdc7caf315()
{
    if ( self.var_a1e594c2cae42e0b )
    {
        return;
    }
    
    var_57eb671c310bb38e = function_c48a408d8c7eb9be();
    poi = poi::poi_findpoioriginisin( self.origin );
    poiname = poi::function_356e66e91a150a02( poi );
    dlog_recordevent( "dlog_event_airdrop_drone_left_without_delivery", [ "circle_index", level.br_circle.circleindex ?? -1, "airdrop_name", self.airdropsettings.airdropidentifier, "drone_instance_id", var_57eb671c310bb38e, "poi_name", poiname, "on_game_end", istrue( self.var_6c49c172ab28db01 ) ] );
}

// Namespace namespace_df4ff65d6946b16b
// Params 0
// Checksum 0x4afc97ca, Offset: 0x27c7
// Size: 0xcc
function analyticsdronedelivery()
{
    var_57eb671c310bb38e = function_c48a408d8c7eb9be();
    candrop = function_2afc02120a7203cf();
    poi = poi::poi_findpoioriginisin( self.origin );
    poiname = poi::function_356e66e91a150a02( poi );
    dlog_recordevent( "dlog_event_airdrop_drone_delivery", [ "circle_index", level.br_circle.circleindex ?? -1, "airdrop_name", self.airdropsettings.airdropidentifier, "drone_instance_id", var_57eb671c310bb38e, "can_drop", candrop, "poi_name", poiname ] );
}

