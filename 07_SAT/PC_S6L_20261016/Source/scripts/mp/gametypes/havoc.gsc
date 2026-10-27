// scripts\mp\gametypes\havoc.gsc  (hash_13f6d1136f0a1b51.gscc) (size: 29490 Bytes / 0x7332 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb352c5e3 (3008546275)
// size ...... 29490 (0x7332)
// includes .. 29  (offset: 0x6c1a)
// strings ... 92  (offset: 0x6d02)
// dev strs .. 14  (offset: 0x727a)
// exports ... 96  (offset: 0x43c2)
// cseg ...... 0x6eb + 0x3cd7 (0x43c2)
// imports ... 208 (offset: 0x52c2)
// animtree1 . 0   (offset: 0x7332)
// animtree2 . 0   (offset: 0x7332)
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\equipment\snapshot_grenade;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\cranked;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\gun;
#using scripts\mp\gametypes\war;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\spawnlogic;

#namespace havoc;

// Namespace havoc
// Params 0
// Checksum 0x345cbf63, Offset: 0x709
// Size: 0x159
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    level.var_47e4ed2b82915eb9 = [];
    level.havoc_max_score = getdvarint( @"scr_havoc_scorelimit", 75 );
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    init_havoc_vo();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.onsuicidedeath = &onsuicidedeath;
    level.onteamchangedeath = &onsuicidedeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.var_f5062c36d13e920c = 1;
    level.var_d448c1abfcfe4987 = [];
    
    /#
        setdevdvarifuninitialized( @"hash_97c9e7f247669d0a", 0 );
        setdevdvarifuninitialized( @"hash_20d78d09742ab023", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_d3324e2adafbcfa9", "<dev string:x24>" );
    #/
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
}

// Namespace havoc
// Params 0
// Checksum 0xfcc96fd7, Offset: 0x86a
// Size: 0x3b
function init_havoc_vo()
{
    game[ "dialog" ][ "gametype" ] = "iw9_havc_mode_uktl_name";
    game[ "dialog" ][ "mod_incoming" ] = "havoc_mod_incoming";
    game[ "dialog" ][ "mod_activated" ] = "havoc_mod_activated";
}

// Namespace havoc
// Params 0
// Checksum 0x4dba11bf, Offset: 0x8ad
// Size: 0x10
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    gun::initializematchrules();
}

// Namespace havoc
// Params 0
// Checksum 0x474e635d, Offset: 0x8c5
// Size: 0x189
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/havoc" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/havoc" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/havoc_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/havoc_hint" );
    }
    
    initspawns();
    level.disablepersonalnuke = 1;
    level.var_f4b0dd42d71621b2 = 1;
    function_cfb1584acb49187f();
    function_37d1d5d3603a7d0a();
    function_6b68cf03592aad87();
    function_efcd437a52923547();
    function_d1144775d35b0934();
    level thread function_20c971997f98a297();
    level thread function_4f86079f1b03c068();
    
    /#
        level thread function_8c0fe4d63de67ac0();
        level thread function_9897970f39db0ebd();
    #/
}

// Namespace havoc
// Params 0
// Checksum 0x261da298, Offset: 0xa56
// Size: 0xef
function function_cfb1584acb49187f()
{
    level.havoc_tweakables = [];
    function_dbdd98eefc6fc87c( @"scr_loadoutperksoff", 1 );
    function_dbdd98eefc6fc87c( @"perk_package_enabled", 0 );
    function_dbdd98eefc6fc87c( @"scr_showperksonspawn", 0 );
    function_dbdd98eefc6fc87c( @"bg_falldamageminheight", 225, 1 );
    function_dbdd98eefc6fc87c( @"hash_f1b2bd0a1fa58a73", 0, 1 );
    function_dbdd98eefc6fc87c( @"hash_e24449fefa8b30ab", 1, 1 );
    function_dbdd98eefc6fc87c( @"hash_c0f3f80ec94308d1", 0, 1 );
    function_dbdd98eefc6fc87c( @"bg_bristotallynormal", 0, 1 );
    function_dbdd98eefc6fc87c( @"hash_2f4cf62df1af9a6", 125, 1 );
    function_dbdd98eefc6fc87c( @"hash_622ac697efdc8f3c", 80, 1 );
    function_dbdd98eefc6fc87c( @"scr_team_fftype", 0, 1 );
    function_dbdd98eefc6fc87c( @"scr_team_teamkillspawndelay", 0, 1 );
}

// Namespace havoc
// Params 0
// Checksum 0xdbad6472, Offset: 0xb4d
// Size: 0x27e
function function_37d1d5d3603a7d0a()
{
    level.havoc_mods = [];
    level.var_86d6e1ec36e8fb2f = [];
    level.var_f645d9b684d3e6b7 = [];
    level.var_b501209bd3051482 = 0;
    level.havoc_score_thresholds = [];
    level.var_647932689977f384 = getdvarint( @"hash_2f01a491b1940657", 5 );
    level.var_ef0eba2b6ea271b0 = int( level.havoc_max_score - level.havoc_max_score / level.var_647932689977f384 );
    level.var_cbe866d88e2eb4d9 = getdvarint( @"hash_c8f0ab916692bfbb", int( level.var_ef0eba2b6ea271b0 / level.var_647932689977f384 ) );
    newscorethreshold = level.var_cbe866d88e2eb4d9;
    
    for ( i = 0; i < function_efd9c3d8e10b92a5() ; i++ )
    {
        level.havoc_score_thresholds[ level.havoc_score_thresholds.size ] = newscorethreshold;
        newscorethreshold += level.var_cbe866d88e2eb4d9;
    }
    
    setomnvar( "ui_havoc_show_mod", -1 );
    setomnvar( "ui_havoc_threshold_progress", 0 );
    setomnvar( "ui_havoc_score_threshold", level.var_b501209bd3051482 );
    setomnvar( "ui_havoc_mod_status_1", -1 );
    setomnvar( "ui_havoc_mod_status_2", -1 );
    setomnvar( "ui_havoc_mod_status_3", -1 );
    setomnvar( "ui_havoc_mod_status_4", -1 );
    setomnvar( "ui_havoc_mod_status_5", -1 );
    var_ab5d3617134061a2 = getscriptbundle( level.projectbundle.havocmods );
    
    foreach ( moditem in var_ab5d3617134061a2.mods )
    {
        modindex = moditem.index;
        modcategory = moditem.type;
        modref = moditem.ref;
        modrestore = moditem.restoreonspawn;
        var_e9c97bf8dd06d6d5 = moditem.requiredmod;
        var_d402ad2078f87ce = moditem.incompatiblemod;
        function_b2f0931a44d9d566( modindex, modcategory, modref, modrestore, var_e9c97bf8dd06d6d5, var_d402ad2078f87ce );
    }
}

// Namespace havoc
// Params 0
// Checksum 0x9fdce436, Offset: 0xdd3
// Size: 0x4b
function function_6b68cf03592aad87()
{
    level.havoc_perks = [];
    level.havoc_perks[ "havoc_flame_on" ] = "specialty_fastreload";
    level.havoc_perks[ "havoc_third_person" ] = "specialty_third_person";
    level.havoc_perks[ "havoc_silent_assassin" ] = "specialty_commando";
}

// Namespace havoc
// Params 0
// Checksum 0xeabd48af, Offset: 0xe26
// Size: 0xcd
function function_efcd437a52923547()
{
    level.ladderindex = dvars::dvarintvalue( "ladderIndex", 1, 1, 6 );
    gun::function_a412f4ddef3cec7d();
    level.havoc_weapon_list = [];
    
    for ( i = 0; i < 50 ; i++ )
    {
        var_7ed3352b779bf81e = function_9b3be6217248651e();
        
        if ( var_7ed3352b779bf81e.size == 0 )
        {
            break;
        }
        
        randomcategory = var_7ed3352b779bf81e[ randomint( var_7ed3352b779bf81e.size ) ];
        weapondata = gun::function_a2141e5b0ed7b293( randomcategory );
        weaponobj = gun::function_d3f34a8855cf982f( weapondata );
        
        if ( isnullweapon( weaponobj ) )
        {
            /#
                iprintln( "<dev string:x25>" + randomcategory );
            #/
            
            continue;
        }
        
        level.havoc_weapon_list[ level.havoc_weapon_list.size ] = weaponobj;
    }
}

// Namespace havoc
// Params 0
// Checksum 0x348e7795, Offset: 0xefb
// Size: 0x9a
function function_9b3be6217248651e()
{
    validcategories = [];
    
    foreach ( categoryref, category in level.weaponcategories )
    {
        if ( category.size > 0 && categoryref != "rand_knife_end" )
        {
            validcategories[ validcategories.size ] = categoryref;
        }
    }
    
    return validcategories;
}

// Namespace havoc
// Params 0
// Checksum 0x8ae44d4f, Offset: 0xf9e
// Size: 0x1e7
function function_d1144775d35b0934()
{
    function_504d7c104be18991( "havoc_ammo_feeder", &havoc_mod_ammofeed );
    function_504d7c104be18991( "havoc_cranked", &function_b034f40fc41d92f1 );
    function_504d7c104be18991( "havoc_equip_mayhem", &function_ed1ace92fd9c8cf2 );
    function_504d7c104be18991( "havoc_kill_snap", &function_5f92eb592f21f43d );
    function_504d7c104be18991( "havoc_lucky_killstreak", &havoc_mod_luckykillstreak );
    function_504d7c104be18991( "havoc_semtex_surprise", &function_25d9fcc52827bad2 );
    function_504d7c104be18991( "havoc_hero_drop", &function_aad7e37c72ef9bdc );
    function_504d7c104be18991( "havoc_eyes_on", &function_823256be6dc72442 );
    function_504d7c104be18991( "havoc_headshot_only", &function_1d1bd489d3f74d81 );
    function_504d7c104be18991( "havoc_low_gravity", &function_2ebf20822ef4abbb );
    function_504d7c104be18991( "havoc_third_person", &function_64022f3936807b6f );
    function_504d7c104be18991( "havoc_gun_cycle", &function_41d679b983b5a3b5 );
    function_504d7c104be18991( "havoc_flame_on", &function_cf2f37e8112686bd );
    function_504d7c104be18991( "havoc_system_reroll", &function_279862931f58f52a );
    
    foreach ( modcategoryindex, modcategory in level.havoc_mods )
    {
        foreach ( var_b02d949976f272ad, modstruct in modcategory )
        {
            if ( isdefined( modstruct.func ) )
            {
                continue;
            }
            
            level.havoc_mods[ modcategoryindex ][ var_b02d949976f272ad ] = undefined;
        }
    }
}

// Namespace havoc
// Params 2
// Checksum 0x5c9aa8a5, Offset: 0x118d
// Size: 0x8f
function function_504d7c104be18991( ref, triggerfunc )
{
    if ( function_ba4668892322fc69( ref ) )
    {
        return;
    }
    
    category = function_370db118a2f12f36( ref );
    
    if ( !isdefined( category ) )
    {
        /#
            iprintln( "<dev string:x5f>" + ref + "<dev string:x76>" );
        #/
        
        function_b2f0931a44d9d566( level.havoc_mods[ category ][ ref ].size, "player", ref, 0, "none" );
    }
    
    level.havoc_mods[ category ][ ref ].func = triggerfunc;
}

// Namespace havoc
// Params 1
// Checksum 0xc1662a05, Offset: 0x1224
// Size: 0xbf, Type: bool
function function_ba4668892322fc69( modref )
{
    var_9ff75b0295603c03 = getdvar( @"hash_d3324e2adafbcfa9", "" );
    
    if ( var_9ff75b0295603c03 != "" )
    {
        modtokens = strtok( var_9ff75b0295603c03, "," );
        
        foreach ( mod in modtokens )
        {
            if ( issubstr( modref, mod ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace havoc
// Params 3
// Checksum 0xca69d928, Offset: 0x12ec
// Size: 0x78
function function_9a28bb4641d07aec( category, ref, modinfo )
{
    if ( !( isdefined( category ) && isdefined( ref ) ) )
    {
        /#
            iprintln( "<dev string:x98>" );
        #/
        
        return;
    }
    
    function_bf2c0abc3839b3ad( modinfo );
    
    if ( category == "weapon" || category == "end" )
    {
        level.havoc_mods[ category ] = [];
        return;
    }
    
    level.havoc_mods[ category ][ ref ] = undefined;
}

// Namespace havoc
// Params 1
// Checksum 0x5c3286cb, Offset: 0x136c
// Size: 0x34
function function_9cde914b41c4a109( modinfo )
{
    if ( !modinfo.restoreonspawn )
    {
        return;
    }
    
    level.var_86d6e1ec36e8fb2f[ modinfo.id ] = modinfo;
}

// Namespace havoc
// Params 1
// Checksum 0xb3e24e6c, Offset: 0x13a8
// Size: 0x70
function function_bf2c0abc3839b3ad( modinfo )
{
    if ( level.var_b501209bd3051482 > 0 )
    {
        setomnvar( "ui_havoc_mod_status_" + level.var_b501209bd3051482, modinfo.id );
    }
    
    level.var_f645d9b684d3e6b7[ modinfo.id ] = modinfo;
    level.var_d448c1abfcfe4987[ level.var_b501209bd3051482 ] = modinfo.id;
}

// Namespace havoc
// Params 0
// Checksum 0x77bc7e10, Offset: 0x1420
// Size: 0xf2
function function_20c971997f98a297()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    wait 5;
    function_8bc2d2f627bbd5a3( 0, 0, 1 );
    previoushighscore = 0;
    scorecounter = 0;
    
    while ( true )
    {
        [ highestteam, highestscore ] = gamescore::gethighestscore();
        
        if ( highestscore > previoushighscore )
        {
            scorediff = highestscore - previoushighscore;
            scorecounter += scorediff;
            previoushighscore = highestscore;
        }
        
        thresholdprogress = scorecounter / function_507bae43cb6da3c3();
        setomnvar( "ui_havoc_threshold_progress", thresholdprogress );
        thresholdlimit = function_507bae43cb6da3c3();
        
        if ( scorecounter >= thresholdlimit )
        {
            scorediff = scorecounter - thresholdlimit;
            scorecounter = scorediff;
            function_8bc2d2f627bbd5a3( 0, 1, 0 );
            
            if ( function_597a01e3492331ac() >= function_efd9c3d8e10b92a5() )
            {
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace havoc
// Params 0
// Checksum 0x5b6debba, Offset: 0x151a
// Size: 0xb
function function_efd9c3d8e10b92a5()
{
    return level.var_647932689977f384;
}

// Namespace havoc
// Params 0
// Checksum 0x65775e45, Offset: 0x152e
// Size: 0xb
function function_507bae43cb6da3c3()
{
    return level.var_cbe866d88e2eb4d9;
}

// Namespace havoc
// Params 0
// Checksum 0x2b6ef49f, Offset: 0x1542
// Size: 0x15
function function_cbb7ee582c063248()
{
    return level.havoc_score_thresholds[ level.var_b501209bd3051482 ];
}

// Namespace havoc
// Params 0
// Checksum 0xcb8b8f9e, Offset: 0x1560
// Size: 0xb
function function_e2b807d1a5e07a1()
{
    return level.var_ef0eba2b6ea271b0;
}

// Namespace havoc
// Params 0
// Checksum 0xaec8f3d9, Offset: 0x1574
// Size: 0xb
function function_597a01e3492331ac()
{
    return level.var_b501209bd3051482;
}

// Namespace havoc
// Params 1
// Checksum 0xd423b683, Offset: 0x1588
// Size: 0x38
function function_dc5f8062cae8be24( settodefault )
{
    level.var_b501209bd3051482++;
    
    if ( settodefault )
    {
        level.var_b501209bd3051482 = 0;
    }
    
    setomnvar( "ui_havoc_score_threshold", level.var_b501209bd3051482 );
}

// Namespace havoc
// Params 1
// Checksum 0xb44d4609, Offset: 0x15c8
// Size: 0x2f, Type: bool
function function_6f9b1142f02872b5( curscore )
{
    nextscorethreshold = level.havoc_score_thresholds[ level.var_b501209bd3051482 ];
    return curscore >= nextscorethreshold;
}

// Namespace havoc
// Params 3
// Checksum 0x77287321, Offset: 0x1600
// Size: 0x30
function function_8bc2d2f627bbd5a3( bypasstimer, var_ec3969962fc058b, var_250c2d367b4b81e1 )
{
    function_dc5f8062cae8be24();
    function_da5e08e9c16677ce( bypasstimer, var_ec3969962fc058b, var_250c2d367b4b81e1 );
}

// Namespace havoc
// Params 3
// Checksum 0x31014fc, Offset: 0x1638
// Size: 0x96
function function_da5e08e9c16677ce( bypasstimer, var_ec3969962fc058b, var_250c2d367b4b81e1 )
{
    modcategory = function_e7f4cad8bbef70e7();
    
    if ( isdefined( modcategory ) )
    {
        modlist = level.havoc_mods[ modcategory ];
        modref = undefined;
        
        if ( isdefined( modlist ) )
        {
            modref = function_54e0f44abbf21de1( modcategory );
        }
        else
        {
            /#
                iprintln( "<dev string:xb5>" );
            #/
        }
        
        level thread function_8de8ab29bff91d30( modcategory, modref, bypasstimer, var_ec3969962fc058b, var_250c2d367b4b81e1 );
        return;
    }
    
    /#
        iprintln( "<dev string:xdb>" );
    #/
}

// Namespace havoc
// Params 5
// Checksum 0xe1bb14f, Offset: 0x16d6
// Size: 0x31c
function function_8de8ab29bff91d30( modcategory, modref, bypasstimer, var_ec3969962fc058b, var_250c2d367b4b81e1 )
{
    level endon( #"game_ended" );
    
    if ( !( isdefined( modcategory ) && isdefined( modref ) ) )
    {
        /#
            iprintln( "<dev string:x105>" );
        #/
        
        return;
    }
    
    var_ce7066ae79f50ec5 = function_c1563b805481e930( modcategory, modref );
    
    if ( isdefined( var_ce7066ae79f50ec5 ) )
    {
        modid = havoc_getidbyref( modref );
        function_9a28bb4641d07aec( modcategory, modref, var_ce7066ae79f50ec5 );
        function_9cde914b41c4a109( var_ce7066ae79f50ec5 );
        currentthreshold = level.var_b501209bd3051482;
        
        /#
            iprintln( "<dev string:x123>" + modcategory + "<dev string:x14a>" + modref );
        #/
        
        var_e1d082ebd0c16d76 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_e1d082ebd0c16d76 hide();
        
        if ( !bypasstimer )
        {
            timer = 3;
            
            if ( var_ec3969962fc058b )
            {
                function_67044ff6d050f86d( "mod_incoming" );
            }
            
            setomnvar( "ui_havoc_countdown_time", gettime() + timer * 1000 );
            var_6cc99932f3d03adc = 0;
            var_da99ef1ad40a4fe9 = 0;
            var_e1d082ebd0c16d76 playsound( "ui_mp_havoc_timer" );
            
            while ( var_da99ef1ad40a4fe9 < timer )
            {
                var_6cc99932f3d03adc += level.framedurationseconds;
                var_da99ef1ad40a4fe9 += level.framedurationseconds;
                progress = clamp( 1 - var_da99ef1ad40a4fe9 / timer, 0, 1 );
                setomnvar( "ui_havoc_countdown_progress", progress );
                
                if ( var_6cc99932f3d03adc >= 1 )
                {
                    var_6cc99932f3d03adc = 0;
                    var_e1d082ebd0c16d76 playsound( "ui_mp_havoc_timer" );
                }
                
                waitframe();
            }
        }
        
        if ( isdefined( var_e1d082ebd0c16d76 ) )
        {
            var_e1d082ebd0c16d76 delete();
        }
        
        setomnvar( "ui_havoc_show_mod", modid );
        hud_util::showsplashtoall( modref );
        
        if ( var_250c2d367b4b81e1 )
        {
            function_67044ff6d050f86d( "mod_activated" );
        }
        
        switch ( modcategory )
        {
            case #"hash_611825599f1b56f9":
                function_d42a672e0e60f64( modid, var_ce7066ae79f50ec5.func );
                break;
            case #"hash_27124c6c97ccffa1":
                if ( modref == "havoc_gun_cycle" )
                {
                    function_d42a672e0e60f64( modid, var_ce7066ae79f50ec5.func );
                    break;
                }
            case #"hash_87d1443ef2805760":
            case #"hash_e0788d0d9af05c73":
            case #"hash_ed49946bfff8e78a":
                level [[ var_ce7066ae79f50ec5.func ]]();
                break;
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_match_start_countdown", 0 );
        }
        
        return;
    }
    
    /#
        iprintln( "<dev string:x152>" + modcategory + "<dev string:x188>" + modref + "<dev string:x193>" );
    #/
}

/#

    // Namespace havoc
    // Params 0
    // Checksum 0x80c1bc49, Offset: 0x19fa
    // Size: 0x5b, Type: dev
    function function_8c0fe4d63de67ac0()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_1e3844e12b196386 = getdvarint( @"hash_97c9e7f247669d0a", 0 );
            
            if ( var_1e3844e12b196386 )
            {
                level waittill( #"havoc_player_killed", attacker );
                function_da5e08e9c16677ce( 0, 1, 0 );
            }
            
            waitframe();
        }
    }

    // Namespace havoc
    // Params 1
    // Checksum 0x3488aa, Offset: 0x1a5d
    // Size: 0x86, Type: dev
    function function_9897970f39db0ebd( modref )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_944043dffb94b9db = getdvar( @"hash_20d78d09742ab023", "<dev string:x24>" );
            
            if ( var_944043dffb94b9db != "<dev string:x24>" )
            {
                modref = var_944043dffb94b9db;
                modcategory = function_370db118a2f12f36( modref );
                level thread function_8de8ab29bff91d30( modcategory, modref, 1, 0, 1 );
                setdevdvar( @"hash_20d78d09742ab023", "<dev string:x24>" );
            }
            
            waitframe();
        }
    }

#/

// Namespace havoc
// Params 2
// Checksum 0xac5e6792, Offset: 0x1aeb
// Size: 0x23
function function_d42a672e0e60f64( modid, callbackfunc )
{
    level.var_47e4ed2b82915eb9[ modid ] = callbackfunc;
}

// Namespace havoc
// Params 6
// Checksum 0x689e341c, Offset: 0x1b16
// Size: 0x14f
function havoc_mod_ammofeed( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( iskillstreakweapon )
    {
        return;
    }
    
    if ( !weapon::isprimaryweapon( objweapon ) )
    {
        return;
    }
    
    var_83a8675f9e45e80d = attacker getweaponammoclip( objweapon );
    var_28812d2df3fed49f = attacker getweaponammostock( objweapon );
    var_6021453cd8e527b4 = weaponclipsize( objweapon );
    var_2445818144778c8a = int( var_6021453cd8e527b4 - var_83a8675f9e45e80d );
    var_4422d3d54ebe5371 = int( min( var_28812d2df3fed49f, var_2445818144778c8a ) );
    
    if ( getdvarint( @"hash_da5503bd54dfb308" ) != 0 )
    {
        logstring( "havoc_mod_ammoFeed attacker:" + attacker.name + " victim:" + victim.name + " currentClipAmount:" + var_83a8675f9e45e80d + " currentStockAmount:" + var_28812d2df3fed49f + " refillClipAmount:" + var_6021453cd8e527b4 + " ammoFromStock:" + var_2445818144778c8a + " ammoToRefill:" + var_4422d3d54ebe5371 );
    }
    
    if ( var_4422d3d54ebe5371 > 0 )
    {
        attacker setweaponammoclip( objweapon, var_6021453cd8e527b4 );
        attacker setweaponammostock( objweapon, var_28812d2df3fed49f - var_4422d3d54ebe5371 );
        attacker damagefeedback::hudicontype( "ammofeeder" );
        attacker playlocalsound( "iw9_support_box_use" );
    }
}

// Namespace havoc
// Params 6
// Checksum 0xf460bcdf, Offset: 0x1c6d
// Size: 0x41
function function_28bea105496b9050( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isdefined( victim ) )
    {
        return;
    }
}

// Namespace havoc
// Params 6
// Checksum 0x7013e02a, Offset: 0x1cb6
// Size: 0x39
function function_a00af0bffb9afbbc( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    
}

// Namespace havoc
// Params 6
// Checksum 0x2853c9af, Offset: 0x1cf7
// Size: 0x8c
function function_b034f40fc41d92f1( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( isdefined( attacker.cranked ) && attacker.cranked )
    {
        attacker cranked::setcrankedplayerbombtimer( #"kill" );
    }
    else
    {
        attacker cranked::oncranked( undefined, attacker );
    }
    
    attacker thread function_a6617fafa794beeb();
}

// Namespace havoc
// Params 0
// Checksum 0xde7dd683, Offset: 0x1d8b
// Size: 0x4a
function function_a6617fafa794beeb()
{
    self endon( #"disconnect" );
    self notify( #"havoc_cranked_remove" );
    self endon( #"havoc_cranked_remove" );
    level endon( #"game_ended" );
    utility::waittill_any( "death", "last_stand_enter" );
    cranked::cleanupcrankedplayertimer();
}

// Namespace havoc
// Params 6
// Checksum 0x6fc470ec, Offset: 0x1ddd
// Size: 0x9b
function function_ed1ace92fd9c8cf2( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    primaryequip = attacker equipment_mp::getcurrentequipment( "primary" );
    secondaryequip = attacker equipment_mp::getcurrentequipment( "secondary" );
    
    if ( isdefined( primaryequip ) )
    {
        attacker equipment_mp::giveequipment( primaryequip, "primary" );
    }
    
    if ( isdefined( secondaryequip ) )
    {
        attacker equipment_mp::giveequipment( secondaryequip, "secondary" );
    }
}

// Namespace havoc
// Params 6
// Checksum 0xdf2a53eb, Offset: 0x1e80
// Size: 0x77
function function_5f92eb592f21f43d( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        return;
    }
    
    equipmentbundle = equipment_mp::function_c90a9aa89b223dd7( "equip_snapshot_grenade" );
    attacker thread snapshot_grenade::snapshot_grenade_watch_flight( victim.origin, undefined, undefined, undefined, equipmentbundle );
}

// Namespace havoc
// Params 6
// Checksum 0xda802a27, Offset: 0x1eff
// Size: 0x22c
function havoc_mod_luckykillstreak( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.havoc_kill_streak ) )
    {
        attacker.havoc_kill_streak = 1;
    }
    else
    {
        attacker.havoc_kill_streak++;
    }
    
    if ( getdvarint( @"hash_dbd2a5053cb970a0", 0 ) != 0 )
    {
        logstring( "havoc_mod_luckyKillstreak attack:" + attacker.name + " victim:" + victim.name + " havoc_kill_streak:" + attacker.havoc_kill_streak );
    }
    
    if ( attacker.havoc_kill_streak < 3 )
    {
        return;
    }
    
    var_cc2f146aee8a6479 = 0;
    
    if ( isdefined( attacker.var_bb087992e69bbff3 ) )
    {
        attacker killstreaks::removekillstreak( var_cc2f146aee8a6479 );
    }
    
    var_5abe547aea53662b = [];
    var_b8eb4c15aaa202f2 = getdvar( @"hash_42131082bf36147", "" );
    
    if ( var_b8eb4c15aaa202f2 != "" )
    {
        var_af972644045789e0 = strtok( var_b8eb4c15aaa202f2, "," );
        
        foreach ( killstreakname in var_af972644045789e0 )
        {
            var_5abe547aea53662b[ var_5abe547aea53662b.size ] = killstreakname;
        }
    }
    
    var_4df919eda4a9baa4 = airdrop::getrandomkillstreak();
    attacker killstreaks::awardkillstreak( var_4df919eda4a9baa4, "other", undefined, undefined, undefined, var_cc2f146aee8a6479 );
    attacker hud_message::showkillstreaksplash( var_4df919eda4a9baa4, 4 );
    attacker.havoc_kill_streak = undefined;
    attacker.var_bb087992e69bbff3 = var_4df919eda4a9baa4;
    attacker thread function_a871abd2bf6991bc();
    
    if ( getdvarint( @"hash_dbd2a5053cb970a0", 0 ) != 0 )
    {
        logstring( "havoc_mod_luckyKillstreak attack:" + attacker.name + " streak:" + var_4df919eda4a9baa4 );
    }
}

// Namespace havoc
// Params 0
// Checksum 0x4b02bb83, Offset: 0x2133
// Size: 0x49
function function_a871abd2bf6991bc()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_eccccb0248d5d562" );
    self endon( #"hash_eccccb0248d5d562" );
    self waittill( #"streak_activated" );
    self.var_bb087992e69bbff3 = undefined;
}

// Namespace havoc
// Params 6
// Checksum 0xc0d5544, Offset: 0x2184
// Size: 0x53
function function_25d9fcc52827bad2( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !isdefined( victim ) && !isdefined( attacker ) )
    {
        return;
    }
    
    victim thread havoc_mod_semtexsurprise_internal( attacker );
}

// Namespace havoc
// Params 1
// Checksum 0x79099dae, Offset: 0x21df
// Size: 0x151
function havoc_mod_semtexsurprise_internal( attacker )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    mindistance = 0;
    maxdistance = 300;
    grenadeorigin = self gettagorigin( "j_mainroot" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        randdist = mindistance + randomint( maxdistance - mindistance );
        randangle = randomint( 360 );
        x = grenadeorigin[ 0 ] + randdist * cos( randangle );
        y = grenadeorigin[ 1 ] + randdist * sin( randangle );
        z = grenadeorigin[ 2 ];
        grenadegoal = ( x, y, z );
        launchvelocity = grenadegoal - grenadeorigin;
        grenade = attacker utility::callsharedfunc( #"weapons", #"_launchgrenade", "equip_semtex", grenadeorigin, launchvelocity, randomfloatrange( 2, 2.25 ) );
        
        if ( getdvarint( @"hash_f8dd1815d5d00129", 0 ) != 0 )
        {
            logstring( "havoc_mod_semtexSurprise_internal grenade:" + grenade.origin );
        }
        
        wait 0.05;
    }
}

// Namespace havoc
// Params 6
// Checksum 0xbb1168a9, Offset: 0x2338
// Size: 0xa3
function function_41d679b983b5a3b5( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( !weapon_utility::isbulletweapon( objweapon ) && !weapon_utility::function_c1972d0d01397a22( objweapon ) )
    {
        return;
    }
    
    var_ba7d2b302d6ae466 = attacker havoc_getrandomweapon();
    attacker inventory_utility::_giveweapon( var_ba7d2b302d6ae466, undefined, undefined, 1 );
    curattackerweapon = attacker getcurrentweapon();
    
    if ( !isnullweapon( curattackerweapon ) )
    {
        attacker inventory_utility::_takeweapon( curattackerweapon );
    }
    
    attacker thread inventory_utility::domonitoredweaponswitch( var_ba7d2b302d6ae466 );
}

// Namespace havoc
// Params 0
// Checksum 0x7e29ea47, Offset: 0x23e3
// Size: 0xb2
function havoc_getrandomweapon()
{
    validweapons = [];
    
    foreach ( weapon in level.havoc_weapon_list )
    {
        if ( weapon.basename == "none" )
        {
            continue;
        }
        
        if ( self getcurrentweapon() == weapon )
        {
            continue;
        }
        
        validweapons[ validweapons.size ] = weapon;
    }
    
    return validweapons[ randomint( validweapons.size ) ];
}

// Namespace havoc
// Params 1
// Checksum 0x9e82dcf2, Offset: 0x249e
// Size: 0xae
function function_cf2f37e8112686bd( playeroverride )
{
    if ( isdefined( playeroverride ) )
    {
        playeroverride function_8d8793e06deec19b();
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player function_8d8793e06deec19b();
    }
}

// Namespace havoc
// Params 0
// Checksum 0xc7490fd, Offset: 0x2554
// Size: 0x9c
function function_8d8793e06deec19b()
{
    currentweapons = self getweaponslistprimaries();
    
    foreach ( weapon in currentweapons )
    {
        if ( isdefined( weapon ) )
        {
            inventory_utility::_takeweapon( weapon );
        }
    }
    
    perk::giveperk( "specialty_fastreload" );
    thread function_6fe63b4d3b357a57();
}

// Namespace havoc
// Params 1
// Checksum 0xba25512e, Offset: 0x25f8
// Size: 0x4a
function function_6fe63b4d3b357a57( weaponobj )
{
    self endon( #"death_or_disconnect" );
    weaponobj = weapon::buildweapon( "iw9_dm_crossbow", [ "ammo_bolt_mol" ] );
    inventory_utility::_giveweapon( weaponobj );
    thread function_164f098c772f9b4f( weaponobj );
    thread havoc_switchtoweapon( weaponobj );
}

// Namespace havoc
// Params 1
// Checksum 0xecbbf6e5, Offset: 0x264a
// Size: 0x64
function function_164f098c772f9b4f( crossbowweapon )
{
    self endon( #"death_or_disconnect" );
    stockammo = self getweaponammostock( crossbowweapon );
    
    while ( true )
    {
        self waittill( #"weapon_fired", objweapon );
        
        if ( isdefined( objweapon ) && objweapon != crossbowweapon )
        {
            continue;
        }
        
        self setweaponammostock( crossbowweapon, stockammo );
    }
}

// Namespace havoc
// Params 1
// Checksum 0x62318087, Offset: 0x26b6
// Size: 0x9d
function function_3c246b5ebea84a09( playeroverride )
{
    if ( isdefined( playeroverride ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player perk::giveperk( "specialty_commando" );
    }
}

// Namespace havoc
// Params 1
// Checksum 0x53fa5c7d, Offset: 0x275b
// Size: 0xfb
function function_6feef8f18826e9eb( playeroverride )
{
    if ( isdefined( playeroverride ) )
    {
        playeroverride function_e7f889239b2b21c5();
        return;
    }
    
    level.blastshieldclamp = dvars::getfloatproperty( @"perk_blastshieldclamphp", 0.8 ) * 30;
    level.maxallowedteamkills = -1;
    function_dbdd98eefc6fc87c( @"scr_team_fftype", 1, 0, "havoc_fragile" );
    function_dbdd98eefc6fc87c( @"scr_team_teamkillspawndelay", 0, 0, "havoc_fragile" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_e7f889239b2b21c5();
    }
}

// Namespace havoc
// Params 0
// Checksum 0x6aa9e42, Offset: 0x285e
// Size: 0x46
function function_e7f889239b2b21c5()
{
    if ( player::isreallyalive( self ) )
    {
        currenthealth = self.health;
        
        if ( self.health > 30 )
        {
            self.health = 30;
        }
        
        self.maxhealth = 30;
    }
}

// Namespace havoc
// Params 1
// Checksum 0xba086e20, Offset: 0x28ac
// Size: 0xe8
function function_aad7e37c72ef9bdc( playeroverride )
{
    if ( isdefined( playeroverride ) )
    {
        playeroverride thread function_d169573eaa504cbc();
        return;
    }
    
    function_dbdd98eefc6fc87c( @"bg_falldamageminheight", 50, 0, "havoc_hero_drop" );
    function_dbdd98eefc6fc87c( @"hash_f1b2bd0a1fa58a73", 1, 0, "havoc_hero_drop" );
    function_dbdd98eefc6fc87c( @"hash_e24449fefa8b30ab", 0, 0, "havoc_hero_drop" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread function_d169573eaa504cbc();
    }
}

// Namespace havoc
// Params 0
// Checksum 0x12086e7a, Offset: 0x299c
// Size: 0x57
function function_d169573eaa504cbc()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_76158f9795c6f611" );
        self radiusdamage( self.origin, 256, 100, 100, self, "MOD_CRUSH", "high_jump_mp" );
        thread function_cb123f0f64c2bf98();
    }
}

// Namespace havoc
// Params 0
// Checksum 0xadeeeda9, Offset: 0x29fb
// Size: 0x4a
function function_cb123f0f64c2bf98()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "heroDiveVfx", "impact", 0 );
    utility::waittill_any_timeout( 1, "death" );
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
}

// Namespace havoc
// Params 0
// Checksum 0xa416f7ad, Offset: 0x2a4d
// Size: 0x2
function function_5580551000373dd8()
{
    
}

// Namespace havoc
// Params 0
// Checksum 0xbb7f9f68, Offset: 0x2a57
// Size: 0xe5
function function_823256be6dc72442()
{
    if ( isbrgamemode() )
    {
        foreach ( team in level.teamnamelist )
        {
            uav::uav_setteamradarstrength( team, level.uavdirectionalid );
            level.activeadvanceduavs[ team ]++;
        }
        
        return;
    }
    
    uav::uav_setteamradarstrength( "allies", level.uavdirectionalid );
    level.activeadvanceduavs[ "allies" ]++;
    uav::uav_setteamradarstrength( "axis", level.uavdirectionalid );
    level.activeadvanceduavs[ "axis" ]++;
}

// Namespace havoc
// Params 0
// Checksum 0xb5314d1d, Offset: 0x2b44
// Size: 0xca
function function_19559a30589013f8()
{
    if ( isbrgamemode() )
    {
        foreach ( team in level.teamnamelist )
        {
            level.activeadvanceduavs[ team ]--;
            uav::uav_setteamradarstrength( team );
        }
        
        return;
    }
    
    level.activeadvanceduavs[ "allies" ]--;
    uav::uav_setteamradarstrength( "allies" );
    level.activeadvanceduavs[ "axis" ]--;
    uav::uav_setteamradarstrength( "axis" );
}

// Namespace havoc
// Params 0
// Checksum 0x3062a4fa, Offset: 0x2c16
// Size: 0x1a
function function_1d1bd489d3f74d81()
{
    function_dbdd98eefc6fc87c( @"hash_c0f3f80ec94308d1", 1, 0, "havoc_headshot_only" );
}

// Namespace havoc
// Params 0
// Checksum 0x3f99aaca, Offset: 0x2c38
// Size: 0x7f
function function_2ebf20822ef4abbb()
{
    lowgravstrength = getdvarint( @"scr_havoc_low_gravity_strength", 300 );
    var_467aa067fb39a209 = getdvarint( @"scr_havoc_low_gravity_jump_height", 80 );
    function_dbdd98eefc6fc87c( @"bg_bristotallynormal", 1, 0, "havoc_low_gravity" );
    function_dbdd98eefc6fc87c( @"hash_2f4cf62df1af9a6", lowgravstrength, 0, "havoc_low_gravity" );
    function_dbdd98eefc6fc87c( @"hash_622ac697efdc8f3c", var_467aa067fb39a209, 0, "havoc_low_gravity" );
}

// Namespace havoc
// Params 0
// Checksum 0x4c153172, Offset: 0x2cbf
// Size: 0x2
function function_2dc6c8101f7de88a()
{
    
}

// Namespace havoc
// Params 1
// Checksum 0x6313b793, Offset: 0x2cc9
// Size: 0xab
function function_64022f3936807b6f( playeroverride )
{
    if ( isdefined( playeroverride ) )
    {
        playeroverride perk::giveperk( "specialty_third_person" );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player perk::giveperk( "specialty_third_person" );
    }
}

// Namespace havoc
// Params 0
// Checksum 0xf85971b7, Offset: 0x2d7c
// Size: 0x13
function function_279862931f58f52a()
{
    function_7b2945247d674319( 1 );
    level thread function_cc092942d28d53a6();
}

// Namespace havoc
// Params 0
// Checksum 0x89efe065, Offset: 0x2d97
// Size: 0x37
function function_cc092942d28d53a6()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        wait 4;
        function_8bc2d2f627bbd5a3( 1, 0, 0 );
    }
}

// Namespace havoc
// Params 6
// Checksum 0x1e791fc5, Offset: 0x2dd6
// Size: 0xe7
function function_b2f0931a44d9d566( modindex, modcategory, modref, modrestore, var_e9c97bf8dd06d6d5, var_d402ad2078f87ce )
{
    newmod = spawnstruct();
    newmod.id = int( modindex );
    newmod.category = modcategory;
    newmod.ref = modref;
    newmod.restoreonspawn = isstring( modrestore ) ? utility::string_to_bool( modrestore ) : modrestore;
    newmod.threshold = function_1f35af4c7d97431e( modcategory, modref );
    newmod.var_ac5d3ac8f301a78b = var_e9c97bf8dd06d6d5;
    newmod.var_848e53215f9e5cde = var_d402ad2078f87ce;
    newmod.skip = 0;
    level.havoc_mods[ modcategory ][ modref ] = newmod;
}

// Namespace havoc
// Params 2
// Checksum 0x23b0e4ed, Offset: 0x2ec5
// Size: 0x8c
function function_1f35af4c7d97431e( modcategory, modref )
{
    modthreshold = 0;
    
    if ( modref == "havoc_third_person" )
    {
        return 4;
    }
    
    switch ( modcategory )
    {
        case #"hash_611825599f1b56f9":
        case #"hash_87d1443ef2805760":
        case #"hash_e0788d0d9af05c73":
            modthreshold = 0;
            break;
        case #"hash_27124c6c97ccffa1":
            modthreshold = 4;
            break;
        case #"hash_ed49946bfff8e78a":
            modthreshold = 5;
            break;
    }
    
    return modthreshold;
}

// Namespace havoc
// Params 1
// Checksum 0x2e0ae67c, Offset: 0x2f5a
// Size: 0x121
function function_370db118a2f12f36( var_9602574c0ac7cd74 )
{
    var_fa24b2411676dc80 = undefined;
    modcategories = level.havoc_mods;
    
    foreach ( categoryindex, category in modcategories )
    {
        modrefs = modcategories[ categoryindex ];
        
        foreach ( modindex, ref in modrefs )
        {
            if ( var_9602574c0ac7cd74 == modindex )
            {
                var_fa24b2411676dc80 = categoryindex;
                break;
            }
        }
        
        if ( isdefined( var_fa24b2411676dc80 ) )
        {
            break;
        }
    }
    
    return var_fa24b2411676dc80;
}

// Namespace havoc
// Params 1
// Checksum 0x2eac27b4, Offset: 0x3084
// Size: 0x4d
function havoc_getidbyref( var_9602574c0ac7cd74 )
{
    modcategory = function_370db118a2f12f36( var_9602574c0ac7cd74 );
    
    if ( !isdefined( modcategory ) )
    {
        /#
            iprintln( "<dev string:x1ca>" );
        #/
        
        return;
    }
    
    return level.havoc_mods[ modcategory ][ var_9602574c0ac7cd74 ].id;
}

// Namespace havoc
// Params 2
// Checksum 0x9d33aa07, Offset: 0x30da
// Size: 0x31
function function_c1563b805481e930( modcategory, modref )
{
    if ( !( isdefined( modcategory ) && isdefined( modref ) ) )
    {
        return;
    }
    
    return level.havoc_mods[ modcategory ][ modref ];
}

// Namespace havoc
// Params 0
// Checksum 0x735d0d34, Offset: 0x3114
// Size: 0xc3
function function_e7f4cad8bbef70e7()
{
    modcategories = level.havoc_mods;
    var_188ca0fcfacf2964 = [];
    
    foreach ( modcategoryindex, category in modcategories )
    {
        if ( category.size > 0 )
        {
            if ( function_94b459f62070dfba( modcategoryindex ) )
            {
                var_188ca0fcfacf2964[ var_188ca0fcfacf2964.size ] = modcategoryindex;
            }
        }
    }
    
    randomcategory = undefined;
    
    if ( var_188ca0fcfacf2964.size > 0 )
    {
        randomcategory = var_188ca0fcfacf2964[ randomint( var_188ca0fcfacf2964.size ) ];
    }
    
    return randomcategory;
}

// Namespace havoc
// Params 1
// Checksum 0x35e25883, Offset: 0x31e0
// Size: 0xec, Type: bool
function function_94b459f62070dfba( modcategory )
{
    modlist = level.havoc_mods[ modcategory ];
    validmods = [];
    
    foreach ( var_b02d949976f272ad, ref in modlist )
    {
        moddata = function_c1563b805481e930( modcategory, var_b02d949976f272ad );
        
        if ( function_3486007cfd2aaefe( moddata ) )
        {
            validmods[ validmods.size ] = moddata;
            
            if ( moddata.skip )
            {
                moddata.skip = 0;
            }
            
            continue;
        }
        
        moddata.skip = 1;
    }
    
    return validmods.size > 0;
}

// Namespace havoc
// Params 1
// Checksum 0x7387dbec, Offset: 0x32d5
// Size: 0x11d
function function_54e0f44abbf21de1( modcategory )
{
    modlist = level.havoc_mods[ modcategory ];
    var_37856df432fb38a2 = [];
    
    foreach ( var_b02d949976f272ad, ref in modlist )
    {
        moddata = function_c1563b805481e930( modcategory, var_b02d949976f272ad );
        
        if ( !moddata.skip )
        {
            var_37856df432fb38a2[ var_37856df432fb38a2.size ] = var_b02d949976f272ad;
        }
    }
    
    randommod = undefined;
    
    if ( var_37856df432fb38a2.size > 0 )
    {
        if ( modcategory == "world" )
        {
            if ( var_37856df432fb38a2.size > 1 && arraycontains( var_37856df432fb38a2, "havoc_third_person" ) )
            {
                randommod = function_3f74d7b0f91f28c2( var_37856df432fb38a2 );
            }
            else
            {
                randommod = var_37856df432fb38a2[ randomint( var_37856df432fb38a2.size ) ];
            }
        }
        else
        {
            randommod = var_37856df432fb38a2[ randomint( var_37856df432fb38a2.size ) ];
        }
    }
    
    return randommod;
}

// Namespace havoc
// Params 1
// Checksum 0x6e17edf7, Offset: 0x33fb
// Size: 0x155
function function_3f74d7b0f91f28c2( var_37856df432fb38a2 )
{
    minweight = 25;
    maxweight = 100;
    totalweight = 0;
    var_467cdb02ed27e541 = [];
    
    foreach ( mod in var_37856df432fb38a2 )
    {
        modweight = mod == "havoc_third_person" ? minweight : maxweight;
        totalweight += modweight;
        var_467cdb02ed27e541[ mod ] = totalweight;
    }
    
    randomweight = randomint( totalweight );
    weightedmod = undefined;
    
    foreach ( var_b02d949976f272ad, modweight in var_467cdb02ed27e541 )
    {
        if ( modweight > randomweight )
        {
            weightedmod = var_b02d949976f272ad;
            break;
        }
    }
    
    return weightedmod;
}

// Namespace havoc
// Params 1
// Checksum 0x1216ce0e, Offset: 0x3559
// Size: 0xad
function function_3486007cfd2aaefe( var_ce7066ae79f50ec5 )
{
    var_efac2288eee44800 = function_bb328eaad25b5c8b( var_ce7066ae79f50ec5 );
    
    if ( !var_efac2288eee44800 )
    {
        return 0;
    }
    
    if ( isdefined( level.var_d3c5fd0e15bbf0da[ var_ce7066ae79f50ec5.ref ] ) )
    {
        return 0;
    }
    
    if ( var_ce7066ae79f50ec5.var_ac5d3ac8f301a78b == "none" && var_ce7066ae79f50ec5.var_848e53215f9e5cde == "none" )
    {
        return 1;
    }
    
    if ( var_ce7066ae79f50ec5.var_ac5d3ac8f301a78b != "none" )
    {
        var_efac2288eee44800 = function_6b648ac4ecf1c19a( var_ce7066ae79f50ec5 );
    }
    
    if ( var_ce7066ae79f50ec5.var_848e53215f9e5cde != "none" )
    {
        var_efac2288eee44800 = function_da11d3af2784abd1( var_ce7066ae79f50ec5 );
    }
    
    return var_efac2288eee44800;
}

// Namespace havoc
// Params 1
// Checksum 0xc01921b5, Offset: 0x360f
// Size: 0x21, Type: bool
function function_bb328eaad25b5c8b( var_a61b323f6137ad4d )
{
    return var_a61b323f6137ad4d.threshold <= level.var_b501209bd3051482;
}

// Namespace havoc
// Params 1
// Checksum 0xff3dae10, Offset: 0x3639
// Size: 0xa9, Type: bool
function function_6b648ac4ecf1c19a( var_a61b323f6137ad4d )
{
    if ( level.var_f645d9b684d3e6b7.size > 0 )
    {
        foreach ( activemod in level.var_f645d9b684d3e6b7 )
        {
            if ( var_a61b323f6137ad4d.var_ac5d3ac8f301a78b == activemod.ref )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace havoc
// Params 1
// Checksum 0xf71162fb, Offset: 0x36eb
// Size: 0xa9, Type: bool
function function_da11d3af2784abd1( var_a61b323f6137ad4d )
{
    if ( level.var_f645d9b684d3e6b7.size > 0 )
    {
        foreach ( activemod in level.var_f645d9b684d3e6b7 )
        {
            if ( var_a61b323f6137ad4d.var_848e53215f9e5cde == activemod.ref )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace havoc
// Params 4
// Checksum 0x7a355fe4, Offset: 0x379d
// Size: 0x92
function function_dbdd98eefc6fc87c( name, value, setonly, modref )
{
    if ( !setonly )
    {
        var_78e73ae51168d378 = spawnstruct();
        var_78e73ae51168d378.name = name;
        var_78e73ae51168d378.resetval = getdvar( name );
        var_78e73ae51168d378.modref = modref ?? "none";
        level.havoc_tweakables[ level.havoc_tweakables.size ] = var_78e73ae51168d378;
    }
    
    setdvar( name, value );
}

// Namespace havoc
// Params 1
// Checksum 0x843e0024, Offset: 0x3837
// Size: 0xfd
function function_f259644bfc07dff2( var_af18f9fc39947d9e )
{
    if ( level.havoc_tweakables.size > 0 )
    {
        foreach ( tweakable in level.havoc_tweakables )
        {
            if ( var_af18f9fc39947d9e && ( tweakable.name == @"scr_loadoutperksoff" || tweakable.name == @"perk_package_enabled" || tweakable.name == @"scr_showperksonspawn" ) )
            {
                continue;
            }
            
            function_dbdd98eefc6fc87c( tweakable.name, tweakable.resetval, 1 );
        }
    }
}

// Namespace havoc
// Params 0
// Checksum 0x95209a4a, Offset: 0x393c
// Size: 0x115
function function_55724daee75a8bf4()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        foreach ( perk in level.havoc_perks )
        {
            if ( isdefined( player.perks[ perk ] ) )
            {
                player perk::removeperk( perk );
            }
        }
    }
}

// Namespace havoc
// Params 0
// Checksum 0xa401beee, Offset: 0x3a59
// Size: 0x175
function function_1502d98319fd3b34()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        foreach ( mod in level.var_f645d9b684d3e6b7 )
        {
            var_6a26e59247b773e2 = player function_955da81137db3d40();
            
            if ( mod.category == "weapon" && var_6a26e59247b773e2 )
            {
                player inventory_utility::_takeweapon( player getcurrentweapon() );
                player inventory_utility::_giveweapon( player.primaryweaponobj );
                player inventory_utility::_giveweapon( player.secondaryweaponobj );
                player thread inventory_utility::domonitoredweaponswitch( player.primaryweaponobj, 1 );
                break;
            }
        }
    }
}

// Namespace havoc
// Params 0
// Checksum 0x94016bf4, Offset: 0x3bd6
// Size: 0x85
function function_76ecff9c2b2e4a81()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player cranked::cleanupcrankedplayertimer();
    }
}

// Namespace havoc
// Params 0
// Checksum 0xc5d1004e, Offset: 0x3c63
// Size: 0x35
function function_955da81137db3d40()
{
    var_6a26e59247b773e2 = 0;
    var_fca4ef1b85bc6c03 = weapon::buildweapon( "iw9_dm_crossbow", [ "ammo_bolt_mol" ] );
    return self hasweapon( var_fca4ef1b85bc6c03 );
}

// Namespace havoc
// Params 1
// Checksum 0xea806d78, Offset: 0x3ca1
// Size: 0x14f
function function_7b2945247d674319( var_af18f9fc39947d9e )
{
    setomnvar( "ui_havoc_show_mod", -1 );
    setomnvar( "ui_havoc_mod_status_1", -1 );
    setomnvar( "ui_havoc_mod_status_2", -1 );
    setomnvar( "ui_havoc_mod_status_3", -1 );
    setomnvar( "ui_havoc_mod_status_4", -1 );
    setomnvar( "ui_havoc_mod_status_5", -1 );
    
    if ( level.var_f645d9b684d3e6b7.size > 0 )
    {
        foreach ( mod in level.var_f645d9b684d3e6b7 )
        {
            if ( mod.ref == "havoc_eyes_on" )
            {
                function_19559a30589013f8();
                break;
            }
        }
    }
    
    function_dc5f8062cae8be24( 1 );
    function_f259644bfc07dff2( var_af18f9fc39947d9e );
    function_55724daee75a8bf4();
    function_1502d98319fd3b34();
    function_76ecff9c2b2e4a81();
    
    if ( isdefined( level.var_6d30c715907eca66 ) )
    {
        [[ level.var_6d30c715907eca66 ]]();
    }
    
    level.var_47e4ed2b82915eb9 = [];
    level.var_86d6e1ec36e8fb2f = [];
    level.var_f645d9b684d3e6b7 = [];
}

// Namespace havoc
// Params 0
// Checksum 0xdf2ad0c, Offset: 0x3df8
// Size: 0x16
function function_4f86079f1b03c068()
{
    level waittill( #"game_ended" );
    function_7b2945247d674319();
}

// Namespace havoc
// Params 0
// Checksum 0x2e5e1da7, Offset: 0x3e16
// Size: 0x90
function function_561c9c9dd6a654d5()
{
    playerowner = undefined;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        playerowner = player;
        break;
    }
    
    return playerowner;
}

// Namespace havoc
// Params 0
// Checksum 0xc4c46c3e, Offset: 0x3eaf
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace havoc
// Params 0
// Checksum 0x88e5a6e8, Offset: 0x3ec0
// Size: 0x25
function initspawns()
{
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
        return;
    }
    
    war::initspawns();
}

// Namespace havoc
// Params 0
// Checksum 0xed9c86d8, Offset: 0x3eed
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace havoc
// Params 1
// Checksum 0x9b36f0c6, Offset: 0x3eff
// Size: 0x2a
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    thread function_48e1f5a850529caf();
    thread function_d7b36a7ca595b631();
}

// Namespace havoc
// Params 0
// Checksum 0xeeff1a98, Offset: 0x3f31
// Size: 0x6a
function function_48e1f5a850529caf()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_d3c2fc4c31a502ec" );
        
        if ( isplayer( self ) && !isbot( self ) )
        {
            killstreaks::clearkillstreaks();
            
            if ( isdefined( self.var_bb087992e69bbff3 ) )
            {
                killstreaks::awardkillstreak( self.var_bb087992e69bbff3, "other" );
            }
        }
    }
}

// Namespace havoc
// Params 0
// Checksum 0xc4719a05, Offset: 0x3fa3
// Size: 0x14c
function function_d7b36a7ca595b631()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"giveloadout" );
        class::loadout_clearperks( 1 );
        defaultperks = class::function_c8d9816a5c9f1f97( self );
        
        foreach ( perk in defaultperks )
        {
            class::loadout_giveperk( perk );
        }
        
        foreach ( modstruct in level.var_86d6e1ec36e8fb2f )
        {
            if ( !isdefined( modstruct.func ) )
            {
                continue;
            }
            
            level [[ modstruct.func ]]( self );
        }
    }
}

// Namespace havoc
// Params 1
// Checksum 0x1accb52c, Offset: 0x40f7
// Size: 0x4d
function havoc_switchtoweapon( weaponobj )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon != weaponobj )
        {
            inventory_utility::_switchtoweaponimmediate( weaponobj );
        }
        else
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace havoc
// Params 1
// Checksum 0x99f4a05b, Offset: 0x414c
// Size: 0x70
function function_67044ff6d050f86d( voref )
{
    dialogstruct = function_ad117d7e5454b0b7( game[ "dialog" ][ voref ], "allies" );
    dialog_utility::function_7162cf91018ef73e( voref, "allies", "killstreak_earned", undefined, dialogstruct );
    dialogstruct = function_ad117d7e5454b0b7( game[ "dialog" ][ voref ], "axis" );
    dialog_utility::function_7162cf91018ef73e( voref, "axis", "killstreak_earned", undefined, dialogstruct );
}

// Namespace havoc
// Params 2
// Checksum 0x82fe070, Offset: 0x41c4
// Size: 0xa2
function function_ad117d7e5454b0b7( event, team )
{
    dialoginfo = spawnstruct();
    dialoginfo.mode = "mp";
    dialoginfo.map = "havc";
    dialoginfo.scene = "mode";
    dialoginfo.character = tolower( dialog_utility::function_d960812ed4930188( team ) );
    
    if ( event == "havoc_mod_incoming" )
    {
        dialoginfo.event = "havi";
    }
    else
    {
        dialoginfo.event = "hava";
    }
    
    return dialoginfo;
}

// Namespace havoc
// Params 6
// Checksum 0x20470b8d, Offset: 0x426f
// Size: 0xde
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    level notify( #"havoc_player_killed", attacker );
    
    foreach ( callbackfunc in level.var_47e4ed2b82915eb9 )
    {
        [[ callbackfunc ]]( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
    
    victim.havoc_kill_streak = undefined;
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace havoc
// Params 1
// Checksum 0x4e3b1707, Offset: 0x4355
// Size: 0x17
function onsuicidedeath( victim )
{
    victim.havoc_kill_streak = undefined;
}

// Namespace havoc
// Params 0
// Checksum 0x9afc7803, Offset: 0x4374
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

