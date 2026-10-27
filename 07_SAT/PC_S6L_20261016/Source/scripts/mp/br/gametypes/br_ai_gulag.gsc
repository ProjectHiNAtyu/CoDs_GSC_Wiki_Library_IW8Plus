// scripts\mp\br\gametypes\br_ai_gulag.gsc  (hash_4b12601ad9ca80f1.gscc) (size: 30200 Bytes / 0x75f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xccb0afff (3434131455)
// size ...... 30200 (0x75f8)
// includes .. 19  (offset: 0x6e98)
// strings ... 114 (offset: 0x6f30)
// dev strs .. 3   (offset: 0x75d4)
// exports ... 77  (offset: 0x4bac)
// cseg ...... 0x9d0 + 0x41dc (0x4bac)
// imports ... 185 (offset: 0x57b4)
// animtree1 . 0   (offset: 0x75f8)
// animtree2 . 0   (offset: 0x75f8)
#using script_68bfedf2ed730bd;
#using script_6962ddc481c4af49;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_ai_gulag_variations;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\class;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\pickups_scriptable;

#namespace br_ai_gulag;

// Namespace br_ai_gulag
// Params 0
// Checksum 0x70b2bdef, Offset: 0x9ee
// Size: 0x337
function init_ai_gulag()
{
    level.var_789f2cd3b152609 = spawnstruct();
    level.var_789f2cd3b152609.arenaaitype = 1;
    level.var_789f2cd3b152609.var_58f07c75360f4941 = getdvarint( @"hash_674e53f15c9ff53d", 1 );
    level.var_789f2cd3b152609.gulagicon = getdvarint( @"hash_7e7947ccb6191852", 1 );
    level.var_789f2cd3b152609.var_6bf10cb719d06859 = getdvarint( @"hash_bc73689cd8209e75", 1 );
    level.var_789f2cd3b152609.var_e44056edc55e61f2 = getdvarint( @"hash_a3f1cff5c396d63d", 12 );
    level.var_789f2cd3b152609.overtimeenabled = getdvarint( @"hash_5b3585afd70eaf8e", 0 );
    level.var_789f2cd3b152609.var_a1239fdc0f87e39 = getdvarint( @"hash_a206a25a0ce81dda", 1 );
    level.var_789f2cd3b152609.var_a8ceb128ab7075b9 = getdvarint( @"hash_f14d2f2480b4b618", 0 );
    level.var_789f2cd3b152609.var_f01c4495e87d1b2a = getdvarint( @"hash_8993dd89b4d00b97", 0 );
    level.var_789f2cd3b152609.var_3e2394db3758630c = getdvarint( @"hash_d824b632ccb82353", 0 );
    level.var_789f2cd3b152609.var_446eb1821745c1af = getdvarfloat( @"hash_546a3f7597c568a", 9 );
    level.var_789f2cd3b152609.var_e4c8c2a70a325b07 = getdvarint( @"hash_eaccaf202728ce0c", 0 );
    level.var_789f2cd3b152609.var_4dfc5b61b51ffb3a = getdvarint( @"hash_8d62b3080c53b03f", 0 );
    level.var_789f2cd3b152609.var_fa8b86008e71b203 = getdvarint( @"hash_bfbfcd12d33dce15", 1 );
    level.var_789f2cd3b152609.var_6813d4fe3768e5f8 = getdvarint( @"hash_19476c64d4742882", 0 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetMatchDuration", &function_501452574f8934e );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsMatchPending", &function_1aa772a50bdb216f );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetClosedCircleIndex", &function_3958e5ea19f0ba43 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetCountdownLength", &function_a7fd027ee1732f70 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagIsOneTeamLeft", &function_f14b62dfa1eca51 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetVictoryWait", &function_797059554619c02 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGetPostVictoryWait", &function_ea8bfebcda1d9634 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagHandleLossInfiniteEarly", &function_3293b88adae512df );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagGiveAIKillRewards", &function_12fd0a9331ccd688 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagWinSequence", &function_e2f235002f525a64 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulagLoseSequence", &function_f8b476d06f07a095 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulag_startWaitingStartTime", &function_604a95aa372a3ae3 );
    namespace_a8afdcd7738e364e::registergulagvariationfunc( "gulag_initPlayerArena", &gulagai_initplayerarena );
    namespace_a8afdcd7738e364e::function_6042ec174569fa17( "gulagOvertime" );
    level ai_mp_controller::function_2b1cc53b284373( &function_e433c87f626e0963 );
    level thread function_e8e2506ab8b48f1b();
    
    if ( !isdefined( level.supportsai ) )
    {
        thread ai_mp_controller::init();
    }
    
    if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
    {
        level thread function_cc085a4a8f0f5433();
    }
    
    level thread br_ai_gulag_variations::function_aad3de341555b28e();
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x42da27a2, Offset: 0xd2d
// Size: 0x73d
function function_e8e2506ab8b48f1b()
{
    level waittill( #"prematch_done" );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_cargo", &function_8e218ead5d6e8711 );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_cable", &function_43f0195bb850b618 );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_camera", &function_bb7cd492ef8ce246 );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_bag", &function_dd3dd10a5c3cadb5 );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_vent", &function_ef0442a77953e1fe );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_door", &function_377225a7011ef2fd );
    scriptable::scriptable_addusedcallbackbypart( "second_chance_door_win", &function_422fd2c2e8ce6385 );
    
    if ( level.var_789f2cd3b152609.overtimeenabled )
    {
        scriptable::scriptable_addusedcallbackbypart( "second_chance_drive", &function_8dca2da427d977 );
    }
    
    foreach ( arena in level.gulag.arenas )
    {
        arenatargets = getentarray( arena.target, #targetname );
        
        foreach ( arenatarget in arenatargets )
        {
            if ( !isdefined( arenatarget.script_noteworthy ) )
            {
                continue;
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_goal_door" )
            {
                arena.goal_doors = arenatarget;
                
                if ( !level.var_789f2cd3b152609.overtimeenabled )
                {
                    arena.goal_doors delete();
                    continue;
                }
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_goal_volume" )
            {
                if ( !level.var_789f2cd3b152609.var_fa8b86008e71b203 )
                {
                    arena.goal_volume = arenatarget;
                }
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_camera_door" )
            {
                arena.cameradoor = arenatarget;
                arena.cameradoor delete();
            }
        }
        
        arena.ai_structs = [];
        arena.legendary_loot_structs = [];
        arena.loot_structs = [];
        arena.var_c6d36c134a1dc81 = [];
        arena.var_70561c5d6a77ab5c = [];
        arena.var_6c19801152d6ad5 = [];
        
        if ( level.var_56c3cc3dc37f1728.var_5c0352aead2072bb )
        {
            arena.lootpickedup = [];
        }
        
        arenastructs = utility::getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "guard_stationary_smg" || isstartstr( arenastruct.script_noteworthy, "gulag_ai_enemy" ) )
            {
                arena.ai_structs[ arena.ai_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "mhc_legendary_loot_structs " || arenastruct.script_noteworthy == "gulag_ai_legendary_loot_structs" )
            {
                arena.legendary_loot_structs[ arena.legendary_loot_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "mhc_loot_structs" || arenastruct.script_noteworthy == "gulag_ai_loot_structs" )
            {
                arena.loot_structs[ arena.loot_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cabin_door" )
            {
                arena.var_70561c5d6a77ab5c[ arena.var_70561c5d6a77ab5c.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_camera" )
            {
                arena.var_c6d36c134a1dc81[ arena.var_c6d36c134a1dc81.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cable" )
            {
                arena.cable = spawnscriptable( "second_chance_cable", arenastruct.origin + ( 0, 0, level.var_789f2cd3b152609.var_3e2394db3758630c ), ( 0, 180, 0 ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cameras" )
            {
                arena.camera = spawnscriptable( "second_chance_camera", arenastruct.origin );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cargo" )
            {
                if ( level.var_789f2cd3b152609.var_4dfc5b61b51ffb3a < 0 )
                {
                    spawnscriptable( "second_chance_cargo", arenastruct.origin + ( 0, 0, level.var_789f2cd3b152609.var_3e2394db3758630c ) );
                }
                else
                {
                    arenastruct thread function_da035e625b437362();
                }
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_usb" && level.var_789f2cd3b152609.overtimeenabled )
            {
                arena.usbdrive = spawnscriptable( "second_chance_drive", arenastruct.origin );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_ot_flag" )
            {
                arena.var_db8b40804defedb = arenastruct.origin;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_vent" )
            {
                arena.vent = spawnscriptable( "second_chance_vent", arenastruct.origin + ( 0, 0, -10 ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_vent_bag" )
            {
                arena.bag = spawnscriptable( "second_chance_bag", arenastruct.origin + ( 0, 0, level.var_789f2cd3b152609.var_3e2394db3758630c ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_escape_doors" )
            {
                if ( level.var_789f2cd3b152609.var_fa8b86008e71b203 )
                {
                    var_504c4b8874dc1f9d = spawnscriptable( "second_chance_door_win", arenastruct.origin, arenastruct.angles );
                    arena.var_6c19801152d6ad5[ arena.var_6c19801152d6ad5.size ] = var_504c4b8874dc1f9d;
                }
            }
        }
        
        function_cfe3f097fceaa1ad( arena );
        
        if ( level.var_789f2cd3b152609.gulagicon )
        {
            arena.objid = function_5991fefc4f1bcaac( arena );
        }
        
        level thread gulag_aiinit( arena );
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x1115f489, Offset: 0x1472
// Size: 0x14
function function_501452574f8934e()
{
    return getdvarfloat( @"hash_8be34599dfa102b8", 50 );
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x22d2504f, Offset: 0x148f
// Size: 0xad
function function_1aa772a50bdb216f( nextmatch, arena )
{
    if ( nextmatch.size < 2 )
    {
        if ( function_9917cd1dd03477c6() )
        {
            foreach ( p in nextmatch )
            {
                if ( !isdefined( p.var_640dc06094860255 ) )
                {
                    return 1;
                }
                
                return 0;
            }
            
            return;
        }
        
        return 0;
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xa97dd78d, Offset: 0x1544
// Size: 0x36
function function_3958e5ea19f0ba43( offset )
{
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", 4 ) - offset;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xdbe60d6b, Offset: 0x1583
// Size: 0x11
function function_a7fd027ee1732f70()
{
    return getdvarint( @"hash_fb05c5f6825931d", 3 );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x89bd618e, Offset: 0x159d
// Size: 0xd
function function_f14b62dfa1eca51()
{
    if ( function_4bd3409c3c4d3d16() )
    {
        return 0;
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x8732c190, Offset: 0x15b2
// Size: 0x7
function function_797059554619c02()
{
    return 4.5;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x69064d2a, Offset: 0x15c2
// Size: 0x7
function function_ea8bfebcda1d9634()
{
    return 2;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x718b4f7e, Offset: 0x15d2
// Size: 0x62
function function_dc61fe53b19f7feb( arena )
{
    if ( level.var_789f2cd3b152609.var_a8ceb128ab7075b9 )
    {
        if ( level.var_789f2cd3b152609.var_f01c4495e87d1b2a == 1 )
        {
            arena function_71423b6290c1326f();
        }
        
        arena thread function_c9e10ecc30d270f6( arena.arenaplayers );
    }
    
    level thread gulag_aiinit( arena );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x79166948, Offset: 0x163c
// Size: 0x46d
function function_80c56a803be6b70c( arena )
{
    level endon( #"game_ended" );
    
    if ( !level.var_789f2cd3b152609.var_fa8b86008e71b203 )
    {
        level thread function_96dc0d0b4d0bcdf2( arena );
    }
    
    if ( isdefined( arena.goal_doors ) )
    {
        level thread function_7dfeed8e7cdb1324( arena.goal_doors );
    }
    
    var_19d9484bf3323ae4 = "gulagai" + arena.gulagindex;
    var_9407792f6bc33691 = "gulagplayers" + arena.gulagindex;
    
    if ( !threatbiasgroupexists( var_9407792f6bc33691 ) )
    {
        createthreatbiasgroup( var_9407792f6bc33691 );
    }
    
    if ( !threatbiasgroupexists( var_19d9484bf3323ae4 ) )
    {
        createthreatbiasgroup( var_19d9484bf3323ae4 );
        setthreatbiasagainstall( var_19d9484bf3323ae4, -100000 );
        setthreatbias( var_19d9484bf3323ae4, var_9407792f6bc33691, 2000 );
    }
    
    foreach ( ai in arena.ai_agents )
    {
        if ( isagent( ai ) )
        {
            ai setthreatbiasgroup( var_19d9484bf3323ae4 );
        }
    }
    
    arena.gulagpoints = undefined;
    
    foreach ( player in arena.arenaplayers )
    {
        player.var_3b5387aafed2f5 = undefined;
        player.var_640dc06094860255 = undefined;
        player.gulagbag = undefined;
        player.gulagkills = undefined;
        player.var_f4ced78321048739 = undefined;
        player.var_82aa9e2a587b9dd7 = undefined;
        player.var_645eef13705c0695 = undefined;
        player.var_716f2b98a73614d0 = undefined;
        player.starscorepoints = undefined;
        
        if ( isdefined( player.var_ba766a8c6b3f6606 ) )
        {
            player.var_ba766a8c6b3f6606 = undefined;
            arena.spawnbag = 1;
        }
        
        if ( !level.var_789f2cd3b152609.var_a8ceb128ab7075b9 )
        {
            player thread hud_message::showsplash( "br_ai_gulag_start" );
        }
        
        if ( level.var_789f2cd3b152609.gulagicon && isdefined( arena.objid ) )
        {
            objective_addclienttomask( arena.objid, player );
            objective_showtoplayersinmask( arena.objid );
        }
        
        player namespace_a974e4dd85555bc2::function_86f9f7643fc8bc16();
        player namespace_a974e4dd85555bc2::function_7fea090e43708ff1();
        player function_866dc5aba79e3ccc( 0 );
        player setthreatbiasgroup( var_9407792f6bc33691 );
        player thread gulag_trackplayerbullets();
    }
    
    if ( isdefined( arena.baggulag ) )
    {
        arena.baggulag freescriptable();
        arena.baggulag = undefined;
    }
    
    if ( arena.lootpickedup.size > 0 )
    {
        foreach ( loot in arena.lootpickedup )
        {
            if ( !isdefined( loot ) )
            {
                continue;
            }
            
            loot setscriptablepartstate( loot.type, "visible" );
        }
        
        arena.lootpickedup = [];
    }
    
    if ( arena.spawnbag )
    {
        function_2f68dab0b598929a( arena );
        arena.spawnbag = undefined;
    }
    
    arena.var_f433bbfd5155b6f0 = undefined;
    
    if ( level.var_789f2cd3b152609.overtimeenabled )
    {
        function_e79fdc176824e04d( arena );
    }
    
    if ( isdefined( arena.ai_agents ) )
    {
        arena.var_4bf13b3afd1652bc = arena.ai_agents.size;
    }
    
    if ( isdefined( arena.arenaplayers ) )
    {
        arena.var_856ffb24070a6fa8 = arena.arenaplayers.size;
    }
    
    arena notify( #"hash_691033fc1a60c497" );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x49e20cda, Offset: 0x1ab1
// Size: 0xa4
function gulag_trackplayerbullets()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player notify( #"gulag_trackplayerbullets" );
    player endon( #"gulag_trackplayerbullets" );
    player endon( #"can_show_splashes" );
    
    while ( true )
    {
        player waittill( #"weapon_fired", objweapon );
        
        if ( !isdefined( player.var_645eef13705c0695 ) )
        {
            player.var_645eef13705c0695 = 0;
        }
        
        player.var_645eef13705c0695 += 1;
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xa4771a29, Offset: 0x1b5d
// Size: 0xb0
function function_cc085a4a8f0f5433()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    wait 10;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player kill();
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x52057e71, Offset: 0x1c15
// Size: 0x49
function function_e79fdc176824e04d( arena )
{
    if ( isdefined( arena.var_e2cb99ec41c42dfc ) )
    {
        arena.var_e2cb99ec41c42dfc delete();
    }
    
    function_ee06af713fa9c2b7( arena.usbdrive.origin, arena );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xa832d2e5, Offset: 0x1c66
// Size: 0x10d
function function_da035e625b437362()
{
    arenastruct = self;
    level endon( #"game_ended" );
    time = 0;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        var_3f5d5b6d89fed8f3 = function_883e56acc5a79657();
        
        for ( circleindex = 0; circleindex < var_3f5d5b6d89fed8f3 ; circleindex++ )
        {
            timedelay = level.br_level.br_circledelaytimes[ circleindex ];
            timeclose = level.br_level.br_circleclosetimes[ circleindex ];
            time = time + timedelay + timeclose;
        }
    }
    
    waittime = int( time );
    wait waittime;
    
    if ( !isdefined( arenastruct ) )
    {
        return;
    }
    
    cargoscriptable = spawnscriptable( "second_chance_cargo", arenastruct.origin + ( 0, 0, level.var_789f2cd3b152609.var_3e2394db3758630c ) );
    return cargoscriptable;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xcbd1774, Offset: 0x1d7c
// Size: 0x88
function function_883e56acc5a79657()
{
    if ( !( isdefined( level.br_level ) && isdefined( level.br_level.br_circledelaytimes ) && isdefined( level.var_789f2cd3b152609.var_4dfc5b61b51ffb3a ) ) )
    {
        return 0;
    }
    
    if ( level.var_789f2cd3b152609.var_4dfc5b61b51ffb3a > 0 )
    {
        return level.var_789f2cd3b152609.var_4dfc5b61b51ffb3a;
    }
    
    var_3f5d5b6d89fed8f3 = max( 0, br_gulag::getgulagclosedcircleindex() - 1 );
    return var_3f5d5b6d89fed8f3;
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0x5c2585f4, Offset: 0x1e0d
// Size: 0x108
function function_8e218ead5d6e8711( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( !isdefined( instance.cargoprogress ) )
    {
        instance.cargoprogress = 0;
    }
    
    if ( instance.cargoprogress > 16 || player.var_3b5387aafed2f5 )
    {
        return;
    }
    
    player.var_3b5387aafed2f5 = 1;
    player playsoundonmovingent( "mine_betty_click" );
    instance.origin += ( 0, -35, 0 );
    instance.cargoprogress++;
    player.var_a5f44cd24240ec39 = 1;
    
    if ( instance.cargoprogress > 16 )
    {
        player function_9658049af42a6ab4( instance );
        instance thread function_a01b6a5bf8eea3fc();
    }
    
    player thread function_3267213afced5fda();
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x9c762943, Offset: 0x1f1d
// Size: 0x50
function function_3267213afced5fda()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait 1.5;
    
    if ( isdefined( player ) && isdefined( player.var_3b5387aafed2f5 ) )
    {
        player.var_3b5387aafed2f5 = 0;
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xc9649d80, Offset: 0x1f75
// Size: 0xdc
function function_9658049af42a6ab4( instance )
{
    player = self;
    arena = function_b137a10652cd5cd6( player );
    
    if ( !( isdefined( arena ) && isdefined( arena.jailedplayers ) ) || arena.jailedplayers.size == 0 )
    {
        return;
    }
    
    foreach ( p in arena.jailedplayers )
    {
        p thread hud_message::showsplash( "br_ai_gulag_cargo_success" );
    }
    
    instance thread function_5128ae2e92ec962f( arena );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x792897ca, Offset: 0x2059
// Size: 0x50
function function_a01b6a5bf8eea3fc()
{
    instance = self;
    level endon( #"game_ended" );
    wait 10;
    instance.origin += ( 0, 560, 0 );
    instance.cargoprogress = 0;
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0x52234b8b, Offset: 0x20b1
// Size: 0x5e
function function_bb7cd492ef8ce246( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( player.var_1bf57f0f71752039 )
    {
        return;
    }
    
    player thread function_278c7283c2150867();
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xc22e8dbe, Offset: 0x2117
// Size: 0x356
function function_278c7283c2150867()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    arena = function_b137a10652cd5cd6( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    player.var_1bf57f0f71752039 = 1;
    player.var_773ce8d494b9ddf6 = 1;
    player playsoundonmovingent( "mine_betty_click" );
    camera = spawn( "script_model", arena.var_c6d36c134a1dc81[ 0 ].origin );
    camera setmodel( "tag_origin" );
    camera.angles = arena.var_c6d36c134a1dc81[ 0 ].angles;
    cameratwo = spawn( "script_model", arena.var_c6d36c134a1dc81[ 1 ].origin );
    cameratwo setmodel( "tag_origin" );
    cameratwo.angles = arena.var_c6d36c134a1dc81[ 1 ].angles;
    camerathree = spawn( "script_model", arena.var_c6d36c134a1dc81[ 2 ].origin );
    camerathree setmodel( "tag_origin" );
    camerathree.angles = arena.var_c6d36c134a1dc81[ 2 ].angles;
    
    if ( level.var_789f2cd3b152609.var_a1239fdc0f87e39 )
    {
        foreach ( enemyai in function_8e8b213809f3c0ef( "gulag" ) )
        {
            enemyai hudoutlineenableforclient( player, "outlinefill_nodepth_red" );
        }
    }
    
    wait 1;
    
    if ( player function_4ee2dd60d5573a60( camera, cameratwo, camerathree ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_rcd_controls", 2 );
    player cameralinkto( camera, "tag_origin", 1, 1 );
    wait 3;
    
    if ( player function_4ee2dd60d5573a60( camera, cameratwo, camerathree ) )
    {
        return;
    }
    
    player cameraunlink();
    player cameralinkto( cameratwo, "tag_origin", 1, 1 );
    wait 3;
    
    if ( player function_4ee2dd60d5573a60( camera, cameratwo, camerathree ) )
    {
        return;
    }
    
    player cameraunlink();
    player cameralinkto( camerathree, "tag_origin", 1, 1 );
    wait 3;
    
    if ( player function_4ee2dd60d5573a60( camera, cameratwo, camerathree ) )
    {
        return;
    }
    
    if ( level.var_789f2cd3b152609.var_a1239fdc0f87e39 )
    {
        foreach ( enemyai in function_8e8b213809f3c0ef( "gulag" ) )
        {
            enemyai hudoutlinedisableforclient( player );
        }
    }
    
    player setclientomnvar( "ui_rcd_controls", 0 );
    player cameraunlink();
    camera delete();
    cameratwo delete();
    player.var_1bf57f0f71752039 = undefined;
}

// Namespace br_ai_gulag
// Params 3
// Checksum 0x3d8ac877, Offset: 0x2475
// Size: 0x6d, Type: bool
function function_4ee2dd60d5573a60( camera, cameratwo, camerathree )
{
    player = self;
    
    if ( !isdefined( player ) || !player.var_1bf57f0f71752039 )
    {
        if ( isdefined( camera ) )
        {
            camera delete();
        }
        
        if ( isdefined( cameratwo ) )
        {
            cameratwo delete();
        }
        
        if ( isdefined( camerathree ) )
        {
            camerathree delete();
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0xf97d8683, Offset: 0x24eb
// Size: 0x73
function function_43f0195bb850b618( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( player.var_b32a3801f354744a )
    {
        return;
    }
    
    player.var_d5080517305b223e = 1;
    player thread function_1ff99d0e15bc70b3( "briefcase_bomb_mp", 3 );
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0x3efe124a, Offset: 0x2566
// Size: 0xaa
function function_ef0442a77953e1fe( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( !isdefined( player.gulagbag ) )
    {
        player hud_message::showerrormessage( %"mp/br_ai_gulag_vent_unable" );
        return;
    }
    
    player.gulagbag = undefined;
    player.var_ba766a8c6b3f6606 = 1;
    player.var_3b005191bff230a6 = 1;
    player playsoundonmovingent( "mine_betty_click" );
    player thread hud_message::showsplash( "br_ai_gulag_vent_success" );
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0xe6430c22, Offset: 0x2618
// Size: 0xb5
function function_377225a7011ef2fd( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( arena.var_f433bbfd5155b6f0 ) )
    {
        arena.var_f433bbfd5155b6f0 = [];
    }
    
    if ( arraycontains( arena.var_f433bbfd5155b6f0, player ) )
    {
        return;
    }
    
    arena.var_f433bbfd5155b6f0[ arena.var_f433bbfd5155b6f0.size ] = player;
    arena function_7962f01a7ef231d();
    player playsoundonmovingent( "mine_betty_click" );
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0xf83378ac, Offset: 0x26d5
// Size: 0x187
function function_dd3dd10a5c3cadb5( instance, part, state, player, bautouse, usestring )
{
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( isdefined( player.gulagbag ) && !instance.ingulag )
    {
        return;
    }
    
    player playsoundonmovingent( "mine_betty_click" );
    
    if ( instance.ingulag )
    {
        player.pers[ "gamemodeLoadout" ] = function_6e9c3a996f00b9a0();
        player.class = "gamemode";
        player.prevweaponobj = undefined;
        struct = player class::loadout_getclassstruct();
        struct = player class::loadout_updateclass( struct, "gamemode" );
        player class::preloadandqueueclassstruct( struct, 1, 1 );
        player class::giveloadout( player.team, "gamemode", 0, 0 );
        player givestartammo( struct.loadoutprimaryobject );
        player item_ammo::function_46e5ccf39665fcf4( struct.loadoutprimaryobject, 0, 0, 0, undefined, 2 );
        
        if ( isdefined( struct.loadoutsecondaryobject ) )
        {
            player givestartammo( struct.loadoutsecondaryobject );
            player item_ammo::function_46e5ccf39665fcf4( struct.loadoutprimaryobject, 0, 0, 0, undefined, 2 );
        }
        
        return;
    }
    
    player.gulagbag = 1;
    player.var_a90b6a04ba2bd139 = 1;
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0x159b697e, Offset: 0x2864
// Size: 0xf4
function function_422fd2c2e8ce6385( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( arraycontains( arena.arenaplayers, player ) )
    {
        player thread namespace_a974e4dd85555bc2::function_bf71a0a0d9ead210( arena );
        player namespace_a974e4dd85555bc2::function_1a2c173510516f99( "win" );
        player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
        player function_866dc5aba79e3ccc( -1 );
        
        if ( level.var_789f2cd3b152609.gulagicon && isdefined( arena.objid ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
        }
        
        player thread br_gulag::gulagvictory( arena, player, 1, 0, "gulag_ai" );
        
        if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
        {
            player thread function_b688da6d50811b1();
        }
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xe684005, Offset: 0x2960
// Size: 0x81
function function_2f68dab0b598929a( arena )
{
    if ( !isdefined( arena.loot_structs ) || arena.loot_structs.size == 0 )
    {
        return;
    }
    
    arena.baggulag = spawnscriptable( "second_chance_bag", arena.loot_structs[ 0 ].origin + ( 0, 0, 10 ) );
    arena.baggulag.ingulag = 1;
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x568f624, Offset: 0x29e9
// Size: 0x45
function function_1ff99d0e15bc70b3( weaponref, waitduration )
{
    player = self;
    player.var_b32a3801f354744a = 1;
    player function_780a3fa695cec279( weaponref, waitduration );
    player function_c0ddd1d07911875f( weaponref );
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x19a1e257, Offset: 0x2a36
// Size: 0x88
function function_780a3fa695cec279( weaponref, waitduration )
{
    player = self;
    player endon( #"beginNewFight" );
    player endon( #"can_show_splashes" );
    item = makeweapon( weaponref );
    player inventory_utility::_giveweapon( item, undefined, undefined, 0 );
    player setweaponammostock( item, 0 );
    player setweaponammoclip( item, 0 );
    player thread gameobjects::switchtouseweapon( item, 1 );
    wait waitduration;
    player thread hud_message::showsplash( "br_ai_gulag_cable_tempered" );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x8a6b5197, Offset: 0x2ac6
// Size: 0x2e
function function_c0ddd1d07911875f( weaponref )
{
    player = self;
    player inventory_utility::getridofweapon( weaponref );
    player.var_b32a3801f354744a = undefined;
}

// Namespace br_ai_gulag
// Params 6
// Checksum 0xa927513c, Offset: 0x2afc
// Size: 0x21f
function function_8dca2da427d977( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( arena.overtime )
    {
        return;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player thread hud_message::showsplash( "br_ai_gulag_reached_end" );
    }
    
    if ( !level.var_789f2cd3b152609.var_fa8b86008e71b203 )
    {
        function_ee06af713fa9c2b7( arena.goal_volume.origin, arena );
    }
    
    arena.goal_doors.moved = 1;
    arena.goal_doors.origin -= ( 0, 0, 200 );
    
    if ( level.var_789f2cd3b152609.overtimeenabled )
    {
        arena.overtime = 1;
        arena.dom.arenaflag br_gulag::arenaflag_setenabled( 1 );
        arena.dom.arenaflag br_gulag::arenaflag_setvisible( arena, 1 );
        arena.dom.arenaflag.flagmodel playsoundonmovingent( "flag_spawned" );
        progress = clamp( arena.time / br_gulag::getovertimelength(), 0, 1 );
        br_gulag::setovertimeomnvarprogress( arena, progress );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x3dd8214c, Offset: 0x2d23
// Size: 0xee
function function_96dc0d0b4d0bcdf2( arena )
{
    level endon( #"game_ended" );
    
    while ( arena.arenaplayers.size > 0 )
    {
        arena.goal_volume waittill( #"trigger", player );
        
        if ( arraycontains( arena.arenaplayers, player ) )
        {
            player thread namespace_a974e4dd85555bc2::function_bf71a0a0d9ead210( arena );
            player namespace_a974e4dd85555bc2::function_1a2c173510516f99( "win" );
            player namespace_a974e4dd85555bc2::function_c197be32faf2846d();
            player function_866dc5aba79e3ccc( -1 );
            
            if ( level.var_789f2cd3b152609.gulagicon && isdefined( arena.objid ) )
            {
                objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
            }
            
            player thread br_gulag::gulagvictory( arena, player, 1, 0, "gulag_ai" );
            
            if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
            {
                player thread function_b688da6d50811b1();
            }
        }
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x756a7815, Offset: 0x2e19
// Size: 0x32
function function_b688da6d50811b1()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 9;
    player kill();
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x1fbf29cd, Offset: 0x2e53
// Size: 0x6e
function function_7dfeed8e7cdb1324( door )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( door.originalloc ) )
    {
        door.originalloc = door.origin;
    }
    
    if ( isdefined( door.moved ) )
    {
        door.origin = door.originalloc;
        door.moved = undefined;
    }
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0xbd268add, Offset: 0x2ec9
// Size: 0x37
function gulag_spawnscriptable( item, location )
{
    scriptable = spawnscriptable( item, location, ( 0, 0, 0 ) );
    return scriptable;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xd4fa437c, Offset: 0x2f09
// Size: 0x100
function function_5991fefc4f1bcaac( arena )
{
    if ( level.var_789f2cd3b152609.var_fa8b86008e71b203 )
    {
        if ( isdefined( arena.var_6c19801152d6ad5[ 0 ] ) )
        {
            location = arena.var_6c19801152d6ad5[ 0 ].origin;
        }
        else if ( isdefined( arena.goal_volume ) )
        {
            location = arena.goal_volume.origin;
        }
        else
        {
            location = ( 0, 0, 0 );
        }
    }
    else
    {
        location = arena.goal_volume.origin;
    }
    
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        objidpoolmanager::objective_add_objective( objid, "current", location, "ui_mp_br_mapmenu_icon_x1_05_objective" );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objid );
    }
    else
    {
        println( "<dev string:x24>" );
    }
    
    return objid;
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x484879e6, Offset: 0x3012
// Size: 0x38
function function_ee06af713fa9c2b7( location, arena )
{
    if ( !isdefined( arena.objid ) )
    {
        return;
    }
    
    objective_position( arena.objid, location );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x3db5366b, Offset: 0x3052
// Size: 0x58
function function_38e8efa96073b433()
{
    player = self;
    wait level.var_789f2cd3b152609.var_e44056edc55e61f2;
    
    if ( isdefined( player ) && player br_public::isplayerinorgoingtogulag() )
    {
        arenajail = function_b137a10652cd5cd6( player );
        
        if ( isdefined( arenajail ) )
        {
            player.var_640dc06094860255 = undefined;
        }
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xed26d3f4, Offset: 0x30b2
// Size: 0x134
function gulag_getarenaloadout()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = "iw9_pi_decho";
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "none";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "equip_frag";
    loadout[ "loadoutEquipmentSecondary" ] = "equip_snapshot_grenade";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_null" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xbb7e4ed4, Offset: 0x31ef
// Size: 0x134
function function_6e9c3a996f00b9a0()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = "iw9_sm_aviktor_mp";
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "iw9_sh_mbravo";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "equip_frag";
    loadout[ "loadoutEquipmentSecondary" ] = "equip_concussion";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_munitions_2" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xe77b338, Offset: 0x332c
// Size: 0x3a
function function_f8b476d06f07a095( arena )
{
    namespace_a974e4dd85555bc2::function_1a2c173510516f99( "lost" );
    
    if ( isdefined( arena.objid ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( arena.objid, self );
    }
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x6e5abc12, Offset: 0x336e
// Size: 0x39
function function_e2f235002f525a64( arena, var_fc49d709b55e5de7 )
{
    winner = self;
    winner.gulagplayerstate = 2;
    winner function_c92eb1ca0d9165d();
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xb3285f0f, Offset: 0x33af
// Size: 0x38
function function_604a95aa372a3ae3()
{
    player = self;
    player.waitingstarttime = gettime();
    player.var_640dc06094860255 = gettime();
    player thread function_38e8efa96073b433();
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x9fcdf534, Offset: 0x33ef
// Size: 0x56
function gulagai_initplayerarena()
{
    player = self;
    player.waitingduration = gettime() - player.waitingstarttime;
    player.waitingstarttime = undefined;
    weaponobj = player getcurrentprimaryweapon();
    player item_ammo::function_46e5ccf39665fcf4( weaponobj, 0, 0, 0, undefined, 2 );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xb0c6e11, Offset: 0x344d
// Size: 0xc6
function function_12fd0a9331ccd688( arena )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( arena.gulagpoints ) )
    {
        return;
    }
    
    points = arena.gulagpoints;
    wait 5;
    
    while ( !player isonground() )
    {
        wait 0.5;
    }
    
    if ( points >= 2 )
    {
        player br_plunder::playerplunderpickup( 5 );
    }
    
    if ( points >= 6 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_armor_plate", 1, 2 );
    }
    
    if ( points >= 8 )
    {
        player br_plunder::playerplunderpickup( 10 );
    }
    
    if ( points >= 10 )
    {
        br_pickups::br_forcegivecustompickupitem( player, "brloot_super_munitionsbox", 1 );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x7a933aca, Offset: 0x351b
// Size: 0x11d
function function_5128ae2e92ec962f( arena )
{
    cargo = self;
    
    if ( !isdefined( arena.jailedplayers ) || arena.jailedplayers.size < 1 )
    {
        return;
    }
    
    foreach ( p in arena.jailedplayers )
    {
        if ( isdefined( p.var_3b5387aafed2f5 ) )
        {
            p thread br_gulag::gulagvictory( p.arena, p, 1, 1, "jailbreakEvent" );
            
            if ( namespace_a974e4dd85555bc2::function_5320bbf12a78971d() )
            {
                p thread function_b688da6d50811b1();
            }
        }
    }
    
    playsoundatpos( cargo.origin, "evt_br_gulag_round_start_buzzer" );
    arena.jailedplayers = function_5713d46873b29625( arena.jailedplayers );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x4c3fc67e, Offset: 0x3640
// Size: 0x1f3
function function_e433c87f626e0963( params )
{
    killer = params.eattacker;
    
    if ( !isplayer( killer ) )
    {
        return;
    }
    
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( killer );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( arena.gulagpoints ) )
    {
        arena.gulagpoints = 0;
    }
    
    if ( !isdefined( killer.gulagkills ) )
    {
        killer.gulagkills = 0;
    }
    
    arena.gulagpoints += 1;
    killer.gulagkills += 1;
    
    if ( arena.gulagpoints == 2 || arena.gulagpoints == 6 || arena.gulagpoints == 8 || arena.gulagpoints == 10 )
    {
        foreach ( p in arena.arenaplayers )
        {
            p playsoundtoplayer( "mp_killconfirm_tags_pickup", p );
        }
    }
    
    foreach ( p in arena.arenaplayers )
    {
        p function_866dc5aba79e3ccc( arena.gulagpoints );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x76758438, Offset: 0x383b
// Size: 0x27
function function_866dc5aba79e3ccc( value )
{
    player = self;
    player setclientomnvar( "ui_br_ai_gulag_score", value );
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xdcd1a737, Offset: 0x386a
// Size: 0x19e
function function_c92eb1ca0d9165d()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    firstplayerstatus = 0;
    var_48d949b1ae1ff465 = 0;
    
    if ( isdefined( arena.arenaplayers[ 0 ] ) && isdefined( arena.arenaplayers[ 0 ].gulagplayerstate ) )
    {
        firstplayerstatus = arena.arenaplayers[ 0 ].gulagplayerstate;
    }
    
    if ( isdefined( arena.arenaplayers[ 1 ] ) && isdefined( arena.arenaplayers[ 1 ].gulagplayerstate ) )
    {
        var_48d949b1ae1ff465 = arena.arenaplayers[ 1 ].gulagplayerstate;
    }
    
    /#
        assert( firstplayerstatus < 16, "<dev string:x4e>" );
        assert( var_48d949b1ae1ff465 < 16, "<dev string:x90>" );
    #/
    
    var_24e56c10120ade9 = ( var_48d949b1ae1ff465 << 4 ) + firstplayerstatus;
    arenaparticipants = arraycombine( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( p in arenaparticipants )
    {
        p setclientomnvar( "ui_br_ai_gulag_player_state", var_24e56c10120ade9 );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x7cac9fdf, Offset: 0x3a10
// Size: 0xf3
function function_b137a10652cd5cd6( player )
{
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        foreach ( jailedplayers in currentarena.jailedplayers )
        {
            if ( jailedplayers == player )
            {
                arena = level.gulag.arenas[ i ];
                return arena;
            }
        }
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x7c53f3ab, Offset: 0x3b0c
// Size: 0x2a, Type: bool
function function_43645d97a69e494f()
{
    if ( isdefined( level.var_789f2cd3b152609 ) && level.var_789f2cd3b152609.arenaaitype )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x75c680ce, Offset: 0x3b3f
// Size: 0x55, Type: bool
function function_f97a5a833d374932()
{
    if ( isdefined( level.var_789f2cd3b152609 ) && level.var_789f2cd3b152609.arenaaitype && level.var_789f2cd3b152609.var_e4c8c2a70a325b07 || getdvarint( @"hash_8ffa9721c8dd3dcc", 0 ) != 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x160cad63, Offset: 0x3b9d
// Size: 0x41, Type: bool
function function_9917cd1dd03477c6()
{
    if ( isdefined( level.var_789f2cd3b152609 ) && level.var_789f2cd3b152609.arenaaitype && level.var_789f2cd3b152609.var_58f07c75360f4941 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x25cf2b31, Offset: 0x3be7
// Size: 0x180
function function_3293b88adae512df( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( isdefined( arena.objid ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
    }
    
    if ( player.health == 0 )
    {
        wait 7;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player br_gulag::setplayervargulag( 0 );
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate br_pickups::addrespawntoken( 1 );
            player br_gulag::playergulagautowin( "aiGulag", teammate );
            wait 7;
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            player kill();
        }
        
        return;
    }
    
    player thread br_gulag::gulagvictory( arena, player, 1, 0, "shutdown" );
    wait 7;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player kill();
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0x5999ba9a, Offset: 0x3d6f
// Size: 0x63, Type: bool
function function_565227f9fc314fbb( attacker, victim )
{
    if ( !function_43645d97a69e494f() || !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) )
    {
        if ( victim.gulag && attacker.gulag )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xa650e7d3, Offset: 0x3ddb
// Size: 0x2a, Type: bool
function function_4bd3409c3c4d3d16()
{
    if ( isdefined( level.var_789f2cd3b152609 ) && level.var_789f2cd3b152609.var_6bf10cb719d06859 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x4efe07a1, Offset: 0x3e0e
// Size: 0xfb
function function_c9e10ecc30d270f6( arenaplayers )
{
    arena = self;
    
    if ( level.var_789f2cd3b152609.var_f01c4495e87d1b2a == 0 )
    {
        arena function_a46559141434e044();
        arena thread function_de92482db4354ab3( arena.fightspawns );
        return;
    }
    
    if ( level.var_789f2cd3b152609.var_f01c4495e87d1b2a == 1 )
    {
        foreach ( p in arenaplayers )
        {
            p thread hud_message::showsplash( "br_ai_gulag_afk_door" );
        }
        
        arena function_a46559141434e044();
        arena function_6850a6a7ce62d7b0();
        arena function_1bccf986872d284a( arenaplayers );
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x89f87699, Offset: 0x3f11
// Size: 0x16
function function_a46559141434e044()
{
    wait level.var_789f2cd3b152609.var_446eb1821745c1af;
}

// Namespace br_ai_gulag
// Params 5
// Checksum 0x8e5584b2, Offset: 0x3f2f
// Size: 0x1e3
function function_de92482db4354ab3( locations, gasduration, var_194b6060a1438a59, gasdamage, var_46320e3d12a2fa40 )
{
    arena = self;
    arena endon( #"matchended" );
    arena endon( #"fight_over" );
    level endon( #"game_ended" );
    
    if ( !isdefined( locations ) )
    {
        return;
    }
    
    if ( !isdefined( gasduration ) )
    {
        gasduration = 11;
    }
    
    if ( !isdefined( var_194b6060a1438a59 ) )
    {
        var_194b6060a1438a59 = 0;
    }
    
    if ( !isdefined( gasdamage ) )
    {
        gasdamage = 15;
    }
    
    if ( !isdefined( var_46320e3d12a2fa40 ) )
    {
        var_46320e3d12a2fa40 = 1.5;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player thread function_1956ad38ff059047( gasdamage, var_46320e3d12a2fa40 );
    }
    
    foreach ( loc in locations )
    {
        position = loc.origin;
        playfx( utility::getfx( "glsmoke" ), position, anglestoup( ( 0, 90, 0 ) ) );
        arena thread gas_grenade::gas_createtrigger( position, arena.ai_agents[ 0 ], arena.ai_agents[ 0 ].team, gasduration, 0.7 );
        wait var_194b6060a1438a59;
    }
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0xc6336467, Offset: 0x411a
// Size: 0x7c
function function_1956ad38ff059047( gasdamage, var_46320e3d12a2fa40 )
{
    player = self;
    player endon( #"gulagRespawn" );
    player endon( #"gulag_end" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( player br_public::isplayerinorgoingtogulag() )
    {
        player waittill( #"gas_begin_coughing" );
        player thread function_3ffa816f46ad937c( gasdamage, var_46320e3d12a2fa40 );
    }
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0xd87f7f93, Offset: 0x419e
// Size: 0x8a
function function_3ffa816f46ad937c( gasdamage, var_46320e3d12a2fa40 )
{
    player = self;
    player endon( #"hash_1f7a3b28c814e517" );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( player.health - gasdamage <= 0 )
        {
            player kill();
        }
        else
        {
            player.health -= gasdamage;
        }
        
        wait var_46320e3d12a2fa40;
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0xcd8c7a2c, Offset: 0x4230
// Size: 0x38
function function_7962f01a7ef231d()
{
    arena = self;
    
    if ( arena.var_f433bbfd5155b6f0.size >= arena.arenaplayers.size )
    {
        arena notify( #"hash_dc2b8dd8c2e893ad" );
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x23a9956c, Offset: 0x4270
// Size: 0xc5
function function_71423b6290c1326f()
{
    arena = self;
    arena.gulag_doors = [];
    
    foreach ( structloc in arena.var_70561c5d6a77ab5c )
    {
        door = spawnscriptable( "second_chance_door", structloc.origin );
        arena.gulag_doors[ arena.gulag_doors.size ] = door;
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x97439c4e, Offset: 0x433d
// Size: 0x133
function function_6850a6a7ce62d7b0()
{
    arena = self;
    
    if ( !isdefined( arena.gulag_doors ) || arena.gulag_doors.size < 1 )
    {
        return;
    }
    
    foreach ( door in arena.gulag_doors )
    {
        door freescriptable();
    }
    
    arena.gulag_doors = undefined;
    
    foreach ( p in arena.arenaplayers )
    {
        p thread hud_message::showsplash( "br_ai_gulag_start" );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xd34c9ed, Offset: 0x4478
// Size: 0x12a
function function_1bccf986872d284a( arenaplayers )
{
    arena = self;
    
    if ( !isdefined( arena.var_f433bbfd5155b6f0 ) || arena.var_f433bbfd5155b6f0.size < 1 )
    {
        foreach ( p in arenaplayers )
        {
            p function_a3c315c9339c77d6();
        }
        
        return;
    }
    
    foreach ( p in arenaplayers )
    {
        if ( !arraycontains( arena.var_f433bbfd5155b6f0, p ) )
        {
            p function_a3c315c9339c77d6();
        }
    }
}

// Namespace br_ai_gulag
// Params 0
// Checksum 0x9f11daee, Offset: 0x45aa
// Size: 0x2b
function function_a3c315c9339c77d6()
{
    player = self;
    arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
    player thread br_gulag::gulagplayerlost( arena );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xf1bffaec, Offset: 0x45dd
// Size: 0x59
function gulag_aiinit( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.aiset = 1;
        
        if ( isdefined( arena.ai_structs ) )
        {
            thread gulag_spawnagents( arena );
        }
        
        arena waittill( #"matchended" );
        thread function_392b676cbae43233( arena );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xe33c840, Offset: 0x463e
// Size: 0x26
function function_cfe3f097fceaa1ad( arena )
{
    category = "gulag";
    ai_mp_controller::aibudget_registercategory( category );
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x7548ab17, Offset: 0x466c
// Size: 0x9f
function gulag_spawnagents( arena )
{
    if ( namespace_a974e4dd85555bc2::function_64591ecc14010927( arena ) )
    {
        thread br_ai_gulag_variations::function_baddb8c4549731db( arena );
        return;
    }
    
    foreach ( aispawn in arena.ai_structs )
    {
        thread gulag_spawnguard( arena, aispawn );
    }
}

// Namespace br_ai_gulag
// Params 2
// Checksum 0xa3f4f64e, Offset: 0x4713
// Size: 0x111
function gulag_spawnguard( arena, aispawn )
{
    aitype = "enemy_mp_smg_tier1_aq";
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    }
    
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread function_a0664a9707714ecd( arena );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 32 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread ai_behavior::behavior_GuardStationary( agent, 1, agent.origin );
            return;
        }
        
        agent thread ai_behavior::behavior_GuardStationary( agent );
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xed25cbcb, Offset: 0x482c
// Size: 0x131
function function_fac41e9291e29cb6( arena )
{
    if ( !arena.aiset )
    {
        gulag_aiinit( arena );
    }
    
    var_d0fc05116223dcaf = 0;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( player namespace_a974e4dd85555bc2::function_f8df68020042aa4() )
        {
            var_d0fc05116223dcaf = 1;
            break;
        }
    }
    
    if ( var_d0fc05116223dcaf )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
            }
        }
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x10ed396e, Offset: 0x4965
// Size: 0x41
function function_a0664a9707714ecd( arena )
{
    if ( !isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = [];
    }
    
    arena.ai_agents[ arena.ai_agents.size ] = self;
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0x7183b57b, Offset: 0x49ae
// Size: 0x8b
function function_397fd3290371340f( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        arena.ai_agents = arrayremove( arena.ai_agents, self );
        
        if ( isagent( self ) )
        {
            if ( isalive( self ) )
            {
                ai_mp_controller::killoffagent();
            }
            else
            {
                body = self getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body delete();
                }
            }
        }
        
        if ( arena.ai_agents.size <= 0 )
        {
            arena.ai_agents = undefined;
        }
    }
}

// Namespace br_ai_gulag
// Params 1
// Checksum 0xab53e0aa, Offset: 0x4a41
// Size: 0x16b
function function_392b676cbae43233( arena )
{
    if ( isdefined( arena.ai_agents ) )
    {
        foreach ( agent in arena.ai_agents )
        {
            if ( isagent( agent ) )
            {
                agent function_397fd3290371340f( arena );
                agent setthreatbiasgroup();
            }
        }
        
        arena.ai_agents = undefined;
        arena.aiset = undefined;
    }
    
    waitframe();
    var_5a1796bfaa7e2815 = 2950;
    nearbyloot = getlootscriptablearrayinradius( undefined, undefined, arena.center, var_5a1796bfaa7e2815 );
    
    foreach ( lootitem in nearbyloot )
    {
        if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
        {
            lootitem pickups::deletescriptableinstance();
        }
    }
}

