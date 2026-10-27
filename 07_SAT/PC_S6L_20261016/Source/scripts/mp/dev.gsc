// scripts\mp\dev.gsc  (hash_7262b27de233448f.gscc) (size: 246997 Bytes / 0x3c4d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f2672a6 (1864790694)
// size ...... 246997 (0x3c4d5)
// includes .. 100 (offset: 0x38ae9)
// strings ... 55  (offset: 0x38e09)
// dev strs .. 789 (offset: 0x39211)
// exports ... 531 (offset: 0x27c45)
// cseg ...... 0x3f1 + 0x27854 (0x27c45)
// imports ... 1248 (offset: 0x2cf3d)
// animtree1 . 0   (offset: 0x3c4d5)
// animtree2 . 0   (offset: 0x3c4d5)
#using script_16ea1b94f0f381b3;
#using script_78fc8c746d423a6d;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\debug_graycard;
#using scripts\common\debug_reflection;
#using scripts\common\dev;
#using scripts\common\devgui;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\armor;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\bots\bots_util;
#using scripts\mp\bounty;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\class;
#using scripts\mp\common\equipment\ai\agent_equipment;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\deployablebox;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\ent_manager;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\menus;
#using scripts\mp\mtx_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\overseer;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\rangefinder;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;
#using scripts\mp\teams;
#using scripts\mp\validation;
#using scripts\mp\weapons;

#namespace dev_mp;

// Namespace dev_mp
// Params 0
// Checksum 0xdccab685, Offset: 0x40f
// Size: 0x998
function init()
{
    if ( getbuildversion() != "SHIP" )
    {
        thread function_53c9fec4685894a8();
        setdvar( @"scr_giveweapon", "" );
    }
    
    /#
        dev::init();
        precachemodel( "<dev string:x24>" );
        precachemodel( "<dev string:x37>" );
        level.var_25ccba59a7813a4b = loadfxasset( "<dev string:x4d>" );
        level.var_270b509f77c3333a[ "<dev string:x6a>" ] = loadfxasset( "<dev string:x7d>" );
        level.var_f63fbf49aed40e23 = 0.25;
        level.var_59de0a10a714e6b0 = int( ceil( level.var_f63fbf49aed40e23 * 1000 / level.frameduration ) );
        thread function_c017dacaa7e9e13a();
        thread function_f991e75e48c655e5();
        thread function_23a9778193c84e17();
        thread function_df4ce5ccd744d7ae();
        thread function_34adbfddf846de6a();
        thread function_3c7e867162702821();
        thread function_94d284035f6fa534();
        thread bots_forceads();
        thread function_4789e3980daa6e27();
        thread function_5e2157232ab4d67c();
        thread addtestclientspawnpoint();
        thread warpenemies();
        thread warpfriendlies();
        thread function_c775d9c82c197378();
        thread function_4b24284d9589427f();
        thread function_3b38b843b1a97dfe();
        thread function_e497e457bfd53f9f();
        thread watchnoclip();
        thread watchufo();
        thread printperks();
        thread function_dc8b4bf0f53df4dc();
        thread devgiveperks();
        thread function_c870cca144d9ec12();
        thread devclearperks();
        thread function_b7a3d1a5adb3e853();
        thread function_1f19b81a419a44fd();
        thread function_ef8fe1dea5fc9565();
        thread function_9cae365772b00cc();
        thread function_3cf84678859b3388();
        thread function_869907cd2140639f();
        thread function_73f395dfbc0815e2();
        thread function_f2e859bbe8fce2b3();
        thread function_303f0d0b2b7dbbf2();
        thread function_ed4c630f7bfcecfa();
        thread function_9865b5a49824ae7d();
        thread function_87263b2000f07aaa();
        thread devchangetimelimit();
        thread function_d76df5d8a8da1e61();
        thread function_3ec3504eed372438();
        thread devhelipathdebugdraw();
        thread function_b3336c3a43f4f078();
        thread function_839a368fd139c6a7();
        thread function_76808e45fa231520();
        thread function_307fdd243ae1a43f();
        thread function_ac79105ffd245dac();
        thread function_417b0150f61716b1();
        thread devgivesuperthink();
        thread function_617e719bc105a6cb();
        thread function_5f0f78998322a581();
        thread function_fe6df4f275ece829();
        thread devgivefieldupgradethink();
        thread function_426f2b022f57ee66();
        thread function_57962a842bbc9f40();
        thread function_603e7489dd6d745d();
        thread function_eed1e1974ca75bad();
        thread function_1ba02fff74376141();
        thread function_f92e09a045007ed5();
        thread function_69d22cabc4009c08();
        thread function_2f0edd60c83f705f();
        thread function_1afed179a0ffd34c();
        thread function_5da5ca62d98617c9();
        thread function_3662b211939d2756();
        thread function_eebc88596c7389d7();
        thread function_99b2a56e1e353960();
        thread function_e8fe689b376ce824();
        thread watchlethaldelaycancel();
        thread watchsuperdelaycancel();
        thread watchslowmo();
        thread watchdoublejump();
        thread function_4d6a6347bc4cb039();
        thread rangefinder();
        thread function_b54d38db22001628();
        thread disableforfeit();
        thread function_fc24d5db7ef0f5c3();
        thread function_6346beb01a5c7ce7();
        thread function_ea08b5c90a80e45e();
        thread watchgunsmithdebugui();
        thread function_43813389429e5b7d();
        thread function_749b380fa4c83a79();
        thread function_f176d0539e1ad152();
        thread function_cd49faac6f2af4bc();
        thread outofboundsimmune();
        thread function_8ac81ab36da0ded7();
        thread function_f85a1f11e709f72();
        thread devrecordposition();
        thread function_b3a6a728a58bb7d1();
        thread function_355ba026ee9a6b1();
        thread function_608044dfa837df76();
        thread function_33cc0f178371735b();
        thread function_ac61a8e142381b89();
        thread function_16e1795998add75b();
        thread function_45f0955f21cf32f2();
        thread function_45f0965f21cf3525();
        thread devhideviewmodel();
        thread flipvehicle();
        thread explodevehicle();
        thread function_dfd115328bb558ae();
        thread function_44e9d6f174c177a6();
        thread function_4f86bf5b03acc10b();
        thread function_f6eca5ab3e53220();
        thread function_9b29e5159417d1c8();
        thread function_a620a475d8bc56d6();
        thread devcodcaster();
        thread function_fea17b16867e3f9f();
        thread function_5a57af4e7244e85f();
        thread function_cf36576398efca48();
        thread function_e9d765650411b698();
        thread function_d326d5fef6f3fc90();
        thread function_44ddd03daa83cd6d();
        thread function_95c59ea7bf11093c();
        thread watchttk();
        thread watchdam();
        thread function_1822d56d2fe4fb70();
        thread function_7ebbd6f0243f96d1();
        thread function_2ad72e198d9ced09();
        thread function_3d0775a8d9da57b5();
        thread function_e11e2566936f34b();
        thread function_379ebea10b2976b6();
        thread function_69f15ee6b34ce911();
        thread splashesdevgui();
        thread devprint();
        thread function_9633c9e9d5aba759();
        thread function_2726d56f99fed9eb();
        thread function_5fe08f6630955070();
        thread watchtacsprint();
        thread function_7b2f09c6d0ed8a49();
        thread function_3d33861f9e4a2a1e();
        thread function_a1d2cba3700cfaa6();
        thread watchreloadtime();
        thread function_2688c04a12ade9fb();
        thread function_68bd59a6149550fb();
        thread watchbotspawn();
        thread function_eab6bc4695e6be93();
        thread function_825310e06cbd8db7();
        thread function_ea776c407880d52();
        thread function_9487def91274e85e();
        thread function_159c6e0a46f803c();
        thread function_ac6a72612dd141b9();
        thread spawnsnapshot();
        thread function_971ceaf40064133f();
        thread allowclassswap();
        thread swapskin();
        thread function_69373454392ee259();
        thread function_22b3e8c41e35030b();
        thread devsetmovespeedscale();
        thread function_1643ce59962a1c48();
        thread devchangeteam();
        thread function_102299591efd4e8d();
        thread function_3e5aee9bd0e332e7();
        thread function_9ea5ddbfa2857f13();
        thread function_72dc5994a0e788fd();
        thread function_e0ad357d47c0b565();
        thread function_1d3457f338a90852();
        setdevdvarifuninitialized( @"scr_testclients_spawnpoint", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_drop_emp", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_plant_allies", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_plant_axis", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_defuse_allies", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_dir_blood", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_devchangetimelimit", "<dev string:xa5>" );
        setdevdvarifuninitialized( @"scr_devhelipathsdebugdraw", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"hash_b048e9c4cba3bb37", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"hash_af596796ae351a3c", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"hash_e182fb9e875bf879", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"scr_devminimap_visible", 0 );
        setdevdvarifuninitialized( @"scr_disable_forfeit", 0 );
        setdevdvarifuninitialized( @"hash_68db6c6a95694120", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"hash_cd901aea9e9e7eeb", "<dev string:xa3>" );
        setdevdvarifuninitialized( @"hash_7a5e31b62cb508b0", 0 );
        setdevdvarifuninitialized( @"scr_ttlos_trace", 0 );
        setdevdvarifuninitialized( @"hash_4806172df45de691", 0 );
        setdevdvarifuninitialized( @"hash_796deaab0da995a1", 0 );
        setdevdvarifuninitialized( @"hash_4c260c16d548430f", 0 );
        setdevdvarifuninitialized( @"hash_c000ec9a5a2f4b6c", 0 );
        setdevdvarifuninitialized( @"hash_a7e60a461c8707b7", 0 );
        setdevdvarifuninitialized( @"scr_ufo", 0 );
        setdevdvarifuninitialized( @"hash_d51785ab78729b60", 0 );
        setdevdvarifuninitialized( @"hash_4d5720fef87ec87b", 0 );
        setdevdvarifuninitialized( @"scr_team_revive_sphere", 0 );
        setdevdvarifuninitialized( @"hash_62a47106347dc9c3", 0 );
        setdevdvarifuninitialized( @"hash_c23c2c6a2023ae4e", 0 );
        setdevdvarifuninitialized( @"hash_f1f4f1ec702b2cf9", 0 );
        setdevdvarifuninitialized( @"hash_2a7bafdc840d1f2e", 0 );
        setdevdvarifuninitialized( @"scr_rangefinder", 0 );
        setdevdvarifuninitialized( @"hash_b665ceb14dabc0ed", -1 );
        setdevdvarifuninitialized( @"hash_81d89e4abec64203", 0 );
        setdevdvarifuninitialized( @"hash_969cec4a11333d98", 0 );
        setdevdvarifuninitialized( @"hash_5d008081f52285c9", 0 );
        setdevdvarifuninitialized( @"hash_e8bf0eb1142e2bf0", 0 );
        setdevdvarifuninitialized( @"hash_debd4bed61a9b4dc", 0 );
        setdevdvarifuninitialized( @"hash_4fea842213b31f9b", 0 );
        setdevdvarifuninitialized( @"hash_11544fe0c704e8fd", 0 );
        setdevdvarifuninitialized( @"hash_d1415bb7a04b48f9", 0 );
        setdevdvarifuninitialized( @"hash_b5df8cb15e263558", 0 );
        setdevdvarifuninitialized( @"hash_b8ecadb3f0f39c29", 0 );
        setdevdvarifuninitialized( @"hash_dd33e6bf6e533554", 0 );
        setdevdvarifuninitialized( @"scr_debug_bc_intensity", 0 );
        setdevdvarifuninitialized( @"hash_6c7fd12a611ca1e8", 0 );
        setdevdvarifuninitialized( @"hash_20d714b15057681f", 0 );
        setdevdvarifuninitialized( @"hash_3c6c485214ca7673", 0 );
        setdevdvarifuninitialized( @"hash_827901421ad0679", 1 );
        setdevdvarifuninitialized( @"hash_4dea2ef3c922a80b", 0 );
        setdevdvarifuninitialized( @"hash_9bffca47d2e56b54", 0 );
        setdevdvarifuninitialized( @"hash_94f1a2576daafe63", 0 );
        setdevdvar( @"hash_eac0c331e6c7a19", 0 );
        setdevdvar( @"hash_feed6c94acdeb007", 0 );
        setdevdvar( @"hash_25fb98b53bc71bdf", 0 );
        setdevdvarifuninitialized( @"hash_5de19f2fe36e6bb8", 0, 0, 1 );
        setdevdvarifuninitialized( @"hash_c34c8720e3f2e3ce", 0.5, 0.1, 5 );
        setdevdvarifuninitialized( @"hash_d2e1e14db7113dd", 4000, 500, 5000 );
        devgui::function_9082edeb5db93280( "<dev string:xa8>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xac>", @"hash_e5e94b23fad41f89" );
        devgui::function_77df7fe7dd273e10();
        level.nextbodyindex = 0;
        debug_reflection::init_reflection_probe( 1 );
        debug_graycard::init_graycard( 1 );
        rank::registerscoreinfo( #"debug_100", #"value", 100 );
        rank::registerscoreinfo( #"debug_500", #"value", 500 );
        rank::registerscoreinfo( #"debug_1000", #"value", 1000 );
        rank::registerscoreinfo( #"debug_1500", #"value", 1500 );
        rank::registerscoreinfo( #"debug_3000", #"value", 3000 );
        thread function_cdecebbc269f2302();
        thread function_1bcaf0d2db459b26();
        utility::registersharedfunc( #"devgui", #"hash_4977958f159a16fc", &add_debug_command );
        thread debugcamera();
        init_starts();
        callback::add( #"player_spawned", &onspawnplayer );
    #/
}

/#

    // Namespace dev_mp
    // Params 3
    // Checksum 0xa5f6cc6d, Offset: 0xdaf
    // Size: 0x3c, Type: dev
    function add_debug_command( player, cmd, var_bdc28222f4b49ff8 )
    {
        if ( !var_bdc28222f4b49ff8 && player isplayerheadless() )
        {
            return 1;
        }
        
        return player function_1d966664c74ab333( cmd );
    }

#/

// Namespace dev_mp
// Params 0
// Checksum 0xe37706d3, Offset: 0xdf3
// Size: 0x145
function debugcamera()
{
    while ( true )
    {
        if ( getdvarint( @"hash_3f6230e700a0b9aa", -1 ) == 1 )
        {
            setdvar( @"hash_3f6230e700a0b9aa", -1 );
            
            foreach ( player in level.players )
            {
                player.var_1d067bca9a6e6008 = player function_662d0b0f6b26828c();
            }
        }
        
        if ( getdvarint( @"hash_3f6230e700a0b9aa", -1 ) == 0 )
        {
            setdvar( @"hash_3f6230e700a0b9aa", -1 );
            
            foreach ( player in level.players )
            {
                player cameraunlink();
            }
        }
        
        waitframe();
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x32e87147, Offset: 0xf40
// Size: 0xe9
function function_662d0b0f6b26828c()
{
    spawnpoints = getentarray( "mp_global_intermission", #classname );
    
    if ( spawnpoints.size > 0 )
    {
        intermissionspawn = function_47c86977a18df38b( spawnpoints, self.origin );
        
        if ( isdefined( intermissionspawn ) )
        {
            cameraentity = spawn( "script_model", intermissionspawn.origin );
            
            if ( isdefined( cameraentity ) )
            {
                cameraentity setmodel( "tag_origin" );
                cameraentity.angles = intermissionspawn.angles;
                cameraentity.data = intermissionspawn;
                self cameralinkto( cameraentity, "tag_origin", 1, 1 );
                return cameraentity;
            }
            else
            {
                assert( isdefined( cameraentity ), "<dev string:xc5>" );
            }
        }
        else
        {
            assert( isdefined( intermissionspawn ), "<dev string:xf3>" );
        }
        
        return;
    }
    
    assert( spawnpoints.size, "<dev string:x11c>" );
}

// Namespace dev_mp
// Params 0
// Checksum 0x5e40c1d0, Offset: 0x1031
// Size: 0x35
function function_53c9fec4685894a8()
{
    if ( getbuildversion() != "SHIP" )
    {
        for ( ;; )
        {
            if ( getdvar( @"scr_giveweapon", "" ) != "" )
            {
                thread gui_giveweapon();
            }
            
            waitframe();
        }
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x2273e003, Offset: 0x106e
// Size: 0x1b7
function gui_giveweapon()
{
    if ( getbuildversion() != "SHIP" )
    {
        var_812be2f18e2b1ae = getdvar( @"scr_giveweapon", "" );
        variant = -1;
        
        if ( isdefined( level.weaponmapdata[ var_812be2f18e2b1ae ] ) )
        {
            var_812be2f18e2b1ae = level.weaponmapdata[ var_812be2f18e2b1ae ].assetname;
        }
        
        var_dd2db255da3902ac = undefined;
        hasnvg = utility::function_2a082dafe6f4bd5b();
        
        if ( weaponexists( var_812be2f18e2b1ae ) )
        {
            var_dd2db255da3902ac = buildweaponinternal( var_812be2f18e2b1ae, undefined, undefined, variant, undefined, undefined, hasnvg );
        }
        
        if ( isdefined( var_dd2db255da3902ac ) )
        {
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                currentweapon = player.currentweapon;
                player.droppeddeathweapon = undefined;
                player weapons::dropweaponfordeath( undefined, "" );
                player.droppeddeathweapon = undefined;
                
                if ( player hasweapon( var_dd2db255da3902ac ) )
                {
                    player inventory_utility::_takeweapon( var_dd2db255da3902ac );
                }
                
                if ( isbot( player ) )
                {
                    player botsetflag( "ignore_script_weapon", 0 );
                }
                
                player inventory_utility::_giveweapon( var_dd2db255da3902ac );
                player inventory_utility::_switchtoweaponimmediate( var_dd2db255da3902ac );
                weapon::fixupplayerweapons( player, var_dd2db255da3902ac );
            }
        }
        else
        {
            iprintlnbold( "Unable to find weapon: " + var_812be2f18e2b1ae );
        }
        
        setdvar( @"scr_giveweapon", "" );
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x67fecfb, Offset: 0x122d
// Size: 0x6a
function function_ffe8acaa84c63e12()
{
    if ( getbuildversion() != "SHIP" )
    {
        playerarray = [];
        
        if ( isdefined( level.var_ceefa46f8106bbca ) && isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            playerarray[ playerarray.size ] = level.var_ceefa46f8106bbca.ent;
        }
        else
        {
            playerarray = level.players;
        }
        
        return playerarray;
    }
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6c1d6da8, Offset: 0x129f
    // Size: 0x10, Type: dev
    function function_1bcaf0d2db459b26()
    {
        for ( ;; )
        {
            waitframe();
            updatedevsettings();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x85d61ed2, Offset: 0x12b7
    // Size: 0x5e6, Type: dev
    function function_2726d56f99fed9eb()
    {
        level endon( #"game_ended" );
        level waittill( #"player_spawned" );
        
        if ( utility::ismp() && !isbrgamemode() )
        {
            level waittill( #"prematch_done" );
        }
        
        if ( utility::iszm() && getprojectname() != "<dev string:x149>" )
        {
            level waittill( #"round_started" );
        }
        
        while ( true )
        {
            for ( ;; )
            {
                if ( getdvarint( @"hash_5de19f2fe36e6bb8" ) > 0 )
                {
                    break;
                }
                
                wait 1;
            }
            
            var_c5c4369b1d47f54e = getdvarfloat( @"hash_c34c8720e3f2e3ce" );
            var_3daf0238f3cb5b8e = getdvarint( @"hash_d2e1e14db7113dd" );
            iterationglobal = 0;
            var_30c963c38e0a88eb = 0;
            
            if ( level.mapcorners[ 0 ].origin[ 0 ] > level.mapcorners[ 1 ].origin[ 0 ] )
            {
                minx = getclosestpointonnavmesh( level.mapcorners[ 1 ].origin )[ 0 ];
                maxx = getclosestpointonnavmesh( level.mapcorners[ 0 ].origin )[ 0 ];
            }
            else
            {
                minx = getclosestpointonnavmesh( level.mapcorners[ 0 ].origin )[ 0 ];
                maxx = getclosestpointonnavmesh( level.mapcorners[ 1 ].origin )[ 0 ];
            }
            
            if ( level.mapcorners[ 0 ].origin[ 1 ] > level.mapcorners[ 1 ].origin[ 1 ] )
            {
                miny = getclosestpointonnavmesh( level.mapcorners[ 1 ].origin )[ 1 ];
                maxy = getclosestpointonnavmesh( level.mapcorners[ 0 ].origin )[ 1 ];
            }
            else
            {
                miny = getclosestpointonnavmesh( level.mapcorners[ 0 ].origin )[ 1 ];
                maxy = getclosestpointonnavmesh( level.mapcorners[ 1 ].origin )[ 1 ];
            }
            
            minz = getclosestpointonnavmesh( level.mapcenter + ( 0, 0, -1000 ) )[ 2 ];
            
            if ( isdefined( parachute::getc130height() ) )
            {
                maxz = getclosestpointonnavmesh( level.mapcenter + ( 0, 0, parachute::getc130height() ) )[ 2 ];
            }
            else
            {
                maxz = 24000;
            }
            
            if ( distance( ( minx, 0, 0 ), ( maxx, 0, 0 ) ) > distance( ( 0, miny, 0 ), ( 0, maxy, 0 ) ) )
            {
                iterationglobal = distance( ( minx, 0, 0 ), ( maxx, 0, 0 ) ) / var_3daf0238f3cb5b8e * 2;
            }
            else
            {
                iterationglobal = distance( ( 0, miny, 0 ), ( 0, maxy, 0 ) ) / var_3daf0238f3cb5b8e * 2;
            }
            
            foreach ( player in level.players )
            {
                for ( i = 1; i < iterationglobal + 1 || i >= 100 ; i++ )
                {
                    if ( isai( player ) )
                    {
                        break;
                    }
                    else
                    {
                        if ( getdvarint( @"hash_30c67e7422cbc657" ) == 0 )
                        {
                            setdevdvar( @"hash_30c67e7422cbc657", 2 );
                        }
                        
                        if ( !player isufo() )
                        {
                            player ufo();
                        }
                    }
                    
                    if ( getdvarint( @"hash_5de19f2fe36e6bb8" ) == 0 )
                    {
                        break;
                    }
                    
                    var_30c963c38e0a88eb = math::round_float( 6.28 * 2 * var_3daf0238f3cb5b8e * i / 2 * var_3daf0238f3cb5b8e, 0, 1 );
                    var_27c0a58e13f5443e = 360 / var_30c963c38e0a88eb;
                    navmeshpos = getclosestpointonnavmesh( ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], player.origin[ 2 ] ) );
                    player setorigin( getgroundposition( navmeshpos, 32, 100, 1000 ) );
                    wait var_c5c4369b1d47f54e;
                    
                    for ( j = 0; j < var_30c963c38e0a88eb || j >= 500 ; j++ )
                    {
                        if ( getdvarint( @"hash_5de19f2fe36e6bb8" ) == 0 )
                        {
                            break;
                        }
                        
                        rotx = level.mapcenter[ 0 ] + i * var_3daf0238f3cb5b8e * sin( var_27c0a58e13f5443e * j );
                        roty = level.mapcenter[ 1 ] + i * var_3daf0238f3cb5b8e * cos( var_27c0a58e13f5443e * j );
                        navmeshpos = getclosestpointonnavmesh( ( rotx, roty, randomfloatrange( minz, maxz ) ) );
                        player setorigin( getgroundposition( navmeshpos + ( 0, 0, 15 ), 1 ) );
                        wait var_c5c4369b1d47f54e;
                    }
                    
                    for ( k = 0; k < var_30c963c38e0a88eb ; k++ )
                    {
                        if ( getdvarint( @"hash_5de19f2fe36e6bb8" ) == 0 )
                        {
                            break;
                        }
                        
                        if ( maxx > minx )
                        {
                            rotx = randomfloatrange( minx, maxx );
                        }
                        else
                        {
                            rotx = randomfloatrange( maxx, minx );
                        }
                        
                        if ( maxy > miny )
                        {
                            roty = randomfloatrange( miny, maxy );
                        }
                        else
                        {
                            roty = randomfloatrange( maxy, miny );
                        }
                        
                        navmeshpos = getclosestpointonnavmesh( ( rotx, roty, randomfloatrange( minz, maxz ) ) );
                        player setorigin( getgroundposition( navmeshpos + ( 0, 0, 15 ), 1 ) );
                        wait var_c5c4369b1d47f54e;
                    }
                }
                
                if ( getdvarint( @"hash_5de19f2fe36e6bb8" ) > 0 )
                {
                    setdevdvar( @"hash_5de19f2fe36e6bb8", 0 );
                    
                    if ( getdvarint( @"hash_30c67e7422cbc657" ) > 0 )
                    {
                        setdevdvar( @"hash_30c67e7422cbc657", 0 );
                    }
                    
                    break;
                }
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x674fceb, Offset: 0x18a5
    // Size: 0x46d, Type: dev
    function function_ac79105ffd245dac()
    {
        start = ( 0, 0, 0 );
        playerangles = ( 0, 0, 0 );
        forward = ( 0, 1, 0 );
        left = ( 1, 0, 0 );
        end = ( 0, 1, 0 );
        hitpos = end;
        wingbasepos = start;
        ignorelist = undefined;
        runtrace = 1;
        waspressed = 0;
        
        while ( true )
        {
            if ( getdvarint( @"scr_ttlos_trace" ) == 1 )
            {
                host = devfindhost();
                
                if ( isdefined( host ) )
                {
                    buttondown = host buttonpressed( "<dev string:x14d>" );
                    
                    if ( buttondown && !waspressed )
                    {
                        runtrace = !runtrace;
                    }
                    
                    waspressed = buttondown;
                    
                    if ( runtrace )
                    {
                        start = host geteye();
                        playerangles = host getplayerangles();
                        forward = anglestoforward( playerangles );
                        left = anglestoleft( playerangles );
                        end = start + forward * 10000;
                        contents = physics_createcontents( [ "<dev string:x156>", "<dev string:x170>", "<dev string:x18a>", "<dev string:x1a2>", "<dev string:x1c1>" ] );
                        ignorelist = [ host ];
                        hits = undefined;
                        
                        while ( true )
                        {
                            hits = physics_raycast( start, end, contents, ignorelist, 1, "<dev string:x1d9>" );
                            var_500c00ff5b85f46d = ignorelist.size;
                            
                            if ( isdefined( hits ) )
                            {
                                foreach ( hit in hits )
                                {
                                    if ( hit[ "<dev string:x1ee>" ] == "<dev string:x1f6>" && isdefined( hit[ "<dev string:x205>" ] ) )
                                    {
                                        if ( hit[ "<dev string:x205>" ].code_classname == "<dev string:x20c>" )
                                        {
                                            ignorelist[ ignorelist.size ] = hit[ "<dev string:x205>" ];
                                            continue;
                                        }
                                        
                                        if ( hit[ "<dev string:x205>" ].code_classname == "<dev string:x217>" )
                                        {
                                            if ( hit[ "<dev string:x205>" ].spawnflags & 1 )
                                            {
                                                ignorelist[ ignorelist.size ] = hit[ "<dev string:x205>" ];
                                            }
                                            
                                            continue;
                                        }
                                        
                                        if ( hit[ "<dev string:x205>" ].code_classname == "<dev string:x229>" )
                                        {
                                            if ( hit[ "<dev string:x205>" ].spawnflags & 4 )
                                            {
                                                ignorelist[ ignorelist.size ] = hit[ "<dev string:x205>" ];
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if ( var_500c00ff5b85f46d == ignorelist.size )
                            {
                                break;
                            }
                        }
                        
                        hitpos = end;
                        
                        if ( hits.size > 0 )
                        {
                            hitpos = hits[ 0 ][ "<dev string:x236>" ];
                        }
                        
                        wingbasepos = host.origin;
                    }
                    else
                    {
                        line( start, hitpos, ( 0, 0, 1 ), 1, 0, 1 );
                    }
                    
                    disttohit = distance( start, hitpos );
                    depthtest = 1;
                    
                    if ( ignorelist.size > 1 )
                    {
                        depthtest = 0;
                    }
                    
                    if ( depthtest )
                    {
                        sphere( hitpos, 10, ( 1, 0, 0 ), 0, 1 );
                    }
                    
                    sphere( hitpos, 10, ( 0, 1, 0 ), depthtest, 1 );
                    print3d( hitpos + left * -20, string( disttohit ), ( 1, 1, 1 ), 1, 1, 1 );
                    var_3fcbef5d8a13140e = wingbasepos + left * 50;
                    line( var_3fcbef5d8a13140e, hitpos, ( 0, 1, 0 ), 1, depthtest, 1 );
                    var_75ace1b29e67463 = wingbasepos + left * -50;
                    line( var_75ace1b29e67463, hitpos, ( 0, 1, 0 ), 1, depthtest, 1 );
                    var_3fcbef5d8a13140e += ( 0, 0, 100 );
                    line( var_3fcbef5d8a13140e, hitpos, ( 0, 1, 0 ), 1, depthtest, 1 );
                    var_75ace1b29e67463 += ( 0, 0, 100 );
                    line( var_75ace1b29e67463, hitpos, ( 0, 1, 0 ), 1, depthtest, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb20aea49, Offset: 0x1d1a
    // Size: 0xbc, Type: dev
    function function_12358c50006775dd()
    {
        if ( level.players.size <= 1 )
        {
            return 0;
        }
        
        host = devfindhost();
        
        if ( isdefined( host ) )
        {
            foreach ( player in level.players )
            {
                if ( player.team != host.team )
                {
                    return 1;
                }
            }
        }
        
        return 0;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9d1e5008, Offset: 0x1dde
    // Size: 0x44, Type: dev
    function function_abf45694e962f4ef()
    {
        setdvar( @"hash_52a765fea3bbda2a", 1 );
        setdvar( @"hash_c5f02128703c1c57", 0 );
        setdvar( @"hash_d7e2432d9039715d", 1 );
        setdvar( @"hash_608f19db5c17a532", 1 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x419fea9f, Offset: 0x1e2a
    // Size: 0x42, Type: dev
    function function_195fb2ad562eb374()
    {
        setdvar( @"hash_52a765fea3bbda2a", 0 );
        setdvar( @"hash_c5f02128703c1c57", 0 );
        setdvar( @"hash_d7e2432d9039715d", 1 );
        setdvar( @"hash_608f19db5c17a532", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9fad901f, Offset: 0x1e74
    // Size: 0xc5, Type: dev
    function function_c88d7e5f9843f80e()
    {
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_d7e2432d9039715d", 1 ) == 0 )
        {
            return host;
        }
        
        foreach ( player in level.players )
        {
            if ( player.team != host.team )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe57791f, Offset: 0x1f41
    // Size: 0x6b6, Type: dev
    function function_cdecebbc269f2302()
    {
        if ( level.prematchperiodend != 0 )
        {
            flags::gameflagwait( "<dev string:x23f>" );
        }
        else
        {
            wait 1;
        }
        
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        var_c8f29fc3ee213af1 = 0;
        
        while ( true )
        {
            var_308c593c2264b16d = getdvarint( @"hash_4dea2ef3c922a80b" );
            
            if ( var_308c593c2264b16d == 0 && var_c8f29fc3ee213af1 == 1 )
            {
                function_195fb2ad562eb374();
                var_c8f29fc3ee213af1 = 0;
            }
            else if ( var_308c593c2264b16d == 1 && var_c8f29fc3ee213af1 == 0 )
            {
                while ( getdvarint( @"hash_4dea2ef3c922a80b" ) == 1 && !function_12358c50006775dd() )
                {
                    wait 1;
                    host iprintlnbold( "<dev string:x24d>" );
                }
                
                function_abf45694e962f4ef();
                var_c8f29fc3ee213af1 = 1;
            }
            
            if ( getdvarint( @"hash_11c9165e2dedb788" ) != 0 )
            {
                turnoffsnapshotmode();
                setdvar( @"hash_11c9165e2dedb788", 0 );
                setdvar( @"hash_4b177fe76d1e2e72", 3 );
            }
            
            var_6c81f985142804a8 = getdvarint( @"hash_b5e16ee20d9dcbab", 3 );
            var_e48e5cc5bdc7434b = getdvarint( @"hash_3d356758cf955276", 3 );
            var_d08122681fd7257f = getdvarint( @"hash_155e8825caf70660", 3 );
            
            if ( var_e48e5cc5bdc7434b != 3 )
            {
                function_94a7bad08a79c4f6( var_e48e5cc5bdc7434b );
                
                if ( var_e48e5cc5bdc7434b == getdvarint( @"hash_4b177fe76d1e2e72", 3 ) )
                {
                    setdvar( @"hash_4b177fe76d1e2e72", 3 );
                }
                
                setdvar( @"hash_3d356758cf955276", 3 );
            }
            else if ( var_6c81f985142804a8 != 3 )
            {
                setspawnsnapshot( var_6c81f985142804a8 );
                setdvar( @"hash_b5e16ee20d9dcbab", 3 );
                setdvar( @"hash_4b177fe76d1e2e72", var_6c81f985142804a8 );
            }
            else if ( var_d08122681fd7257f != 3 )
            {
                targetplayer = function_c88d7e5f9843f80e();
                
                if ( isdefined( targetplayer ) )
                {
                    targetplayer updatesnapshot( var_d08122681fd7257f );
                }
                
                setdvar( @"hash_155e8825caf70660", 3 );
                setdvar( @"hash_4b177fe76d1e2e72", var_d08122681fd7257f );
            }
            
            if ( getdvarint( @"hash_4b177fe76d1e2e72", 3 ) != 3 )
            {
                wait level.var_f63fbf49aed40e23;
                continue;
            }
            
            debugttlos();
            function_effdeeec918db2e8();
            
            if ( getdvarint( @"scr_spawns_hardpoint", 0 ) == 1 )
            {
                if ( isdefined( level.zone ) )
                {
                    if ( isdefined( level.getkothzonedeadzonedist ) )
                    {
                        deadzonedist = [[ level.getkothzonedeadzonedist ]]();
                    }
                    else
                    {
                        deadzonedist = 1000;
                    }
                    
                    cylinder( level.zone.curorigin, level.zone.curorigin + ( 0, 0, 1 ), deadzonedist, ( 1, 0, 0 ) );
                    
                    foreach ( spawnpoint in level.zone.spawnpoints[ "<dev string:x270>" ] )
                    {
                        drawspawnpoint( spawnpoint, spawnpoint.classname, ( 1, 1, 1 ) );
                    }
                    
                    foreach ( spawnpoint in level.zone.spawnpoints[ "<dev string:x276>" ] )
                    {
                        drawspawnpoint( spawnpoint, spawnpoint.classname, ( 1, 1, 1 ), undefined, undefined, 1 );
                    }
                }
            }
            
            if ( getdvarint( @"scr_spawns_secure", 0 ) == 1 )
            {
                if ( isdefined( level.current_objective ) )
                {
                    deadzonedist = [[ level.getkothzonedeadzonedist ]]();
                    maxdist = [[ level.var_348d716c11c353dc ]]();
                    fallbackdist = [[ level.var_815dcb3e1defb6aa ]]();
                    cylinder( level.current_objective.trigger.originalpos, level.current_objective.trigger.originalpos + ( 0, 0, 1 ), deadzonedist, ( 1, 0, 0 ), 0, 25 );
                    cylinder( level.current_objective.trigger.originalpos, level.current_objective.trigger.originalpos + ( 0, 0, 1 ), maxdist, ( 1, 0, 0 ), 0, 25 );
                    cylinder( level.current_objective.trigger.originalpos, level.current_objective.trigger.originalpos + ( 0, 0, 1 ), fallbackdist, ( 1, 0, 1 ), 0, 25 );
                    
                    foreach ( spawnpoint in level.current_objective.spawnpoints )
                    {
                        drawspawnpoint( spawnpoint, spawnpoint.classname, ( 1, 1, 1 ) );
                    }
                    
                    foreach ( spawnpoint in level.current_objective.fallbackspawnpoints )
                    {
                        drawspawnpoint( spawnpoint, spawnpoint.classname, ( 1, 1, 1 ), undefined, undefined, 1 );
                    }
                }
            }
            
            wait level.var_f63fbf49aed40e23;
        }
    }

    // Namespace dev_mp
    // Params 6
    // Checksum 0xb96f7590, Offset: 0x25ff
    // Size: 0x43d, Type: dev
    function drawspawnpoint( spawnpoint, classname, color, var_5db05520d6f34a0f, var_a4b430b790c583ed, var_dac85bf0ac5334ae )
    {
        if ( !isdefined( var_dac85bf0ac5334ae ) )
        {
            var_dac85bf0ac5334ae = 0;
        }
        
        height = var_dac85bf0ac5334ae ? 36 : 72;
        base = spawnpoint.origin;
        forward = anglestoforward( spawnpoint.angles );
        right = anglestoright( spawnpoint.angles );
        top = spawnpoint.origin + ( 0, 0, 1 ) * height;
        center = spawnpoint.origin + ( 0, 0, 1 ) * height * 0.5;
        forward *= 16;
        right *= 16;
        centerright = center + right;
        centerleft = center - right;
        centerforward = center + forward;
        centerback = center - forward;
        line( base, centerright, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( base, centerleft, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( top, centerright, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( top, centerleft, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( base, centerforward, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( top, centerforward, color, 1, 0, level.var_59de0a10a714e6b0 );
        line( base, top, color, 1, 0, level.var_59de0a10a714e6b0 );
        arrow_forward = anglestoforward( spawnpoint.angles );
        arrowhead_forward = anglestoforward( spawnpoint.angles );
        arrowhead_right = anglestoright( spawnpoint.angles );
        arrow_forward *= 32;
        arrowhead_forward *= 24;
        arrowhead_right *= 8;
        arrowtip = center + arrow_forward;
        arrowleft = center + arrowhead_forward - arrowhead_right;
        arrowright = center + arrowhead_forward + arrowhead_right;
        line( center, arrowtip, ( 1, 1, 1 ), 1, 0, level.var_59de0a10a714e6b0 );
        line( arrowtip, arrowleft, ( 1, 1, 1 ), 1, 0, level.var_59de0a10a714e6b0 );
        line( arrowtip, arrowright, ( 1, 1, 1 ), 1, 0, level.var_59de0a10a714e6b0 );
        
        foreach ( alternate in spawnpoint.alternates )
        {
            line( spawnpoint.origin, alternate, color, 1, 0, level.var_59de0a10a714e6b0 );
        }
        
        topline = spawnpoint.index + "<dev string:x27f>" + classname;
        print3d( spawnpoint.origin + ( 0, 0, height ), topline, color, 1, 1, level.var_59de0a10a714e6b0 );
        
        if ( isdefined( var_5db05520d6f34a0f ) )
        {
            print3d( spawnpoint.origin + ( 0, 0, height - 20 ), var_5db05520d6f34a0f, ( 1, 1, 1 ), 1, 1, level.var_59de0a10a714e6b0 );
        }
        
        if ( isdefined( var_a4b430b790c583ed ) )
        {
            print3d( spawnpoint.origin + ( 0, 0, height - 30 ), var_a4b430b790c583ed, ( 1, 1, 1 ), 1, 1, level.var_59de0a10a714e6b0 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5d9306a2, Offset: 0x2a44
    // Size: 0x1ce, Type: dev
    function function_effdeeec918db2e8()
    {
        if ( getdvarint( @"hash_c5f02128703c1c57" ) == 0 && getdvarint( @"hash_4dea2ef3c922a80b" ) == 1 )
        {
            host = devfindhost();
            
            if ( !function_12358c50006775dd() )
            {
                host iprintlnbold( "<dev string:x24d>" );
                return;
            }
            
            targetplayer = function_c88d7e5f9843f80e();
            
            if ( isdefined( targetplayer ) && targetplayer.team != "<dev string:x283>" )
            {
                var_c33c32fa63c0202 = level.disableteamstartspawns;
                level.disableteamstartspawns = 1;
                var_70053053d7b29eb3 = level.usestartspawns;
                level.usestartspawns = 0;
                level.var_8b5c76fe32f32acf = 1;
                selectedspawnpoint = targetplayer [[ level.getspawnpoint ]]();
                level.disableteamstartspawns = var_c33c32fa63c0202;
                level.usestartspawns = var_70053053d7b29eb3;
                
                if ( isdefined( level.lastspawnset ) )
                {
                    spawnlogic::activatespawnset( level.lastspawnset, 1 );
                    
                    if ( isdefined( level.var_7c9560dd3a04acc5 ) )
                    {
                        spawnlogic::activatespawnset( level.var_7c9560dd3a04acc5, 0 );
                    }
                }
                
                matchstarttimems = game[ "<dev string:x28d>" ];
                
                if ( isdefined( matchstarttimems ) )
                {
                    var_b9b9e65758beb657 = gettime() - matchstarttimems;
                }
                else
                {
                    var_b9b9e65758beb657 = 0;
                }
                
                targetplayer finalizespawnpointchoiceforplayer( selectedspawnpoint.index, 1, var_b9b9e65758beb657, selectedspawnpoint.bucket, selectedspawnpoint.usingfallback, selectedspawnpoint.threatsight, selectedspawnpoint.damagemod, selectedspawnpoint.group, selectedspawnpoint.set, selectedspawnpoint.evaluationid ?? 0 );
                level.var_8b5c76fe32f32acf = undefined;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xaa52370b, Offset: 0x2c1a
    // Size: 0x424, Type: dev
    function debugttlos()
    {
        var_da31ada643dedca5 = getdvarint( @"hash_4048e0584107c82d", 0 );
        
        if ( var_da31ada643dedca5 != 0 )
        {
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                switch ( getdvarint( @"hash_36ffd6c38bff011f", 0 ) )
                {
                    case 1:
                        nearestdist = 20000000;
                        nearestspawn = level.spawnpoints[ 0 ];
                        
                        foreach ( spawnpoint in level.spawnpoints )
                        {
                            dist = distance( spawnpoint.origin, host.origin );
                            
                            if ( dist < nearestdist )
                            {
                                nearestspawn = spawnpoint;
                                nearestdist = dist;
                            }
                        }
                        
                        level.var_3217e4102126369 = nearestspawn;
                        level.var_e320251b444bea29 = undefined;
                        setdevdvar( @"hash_36ffd6c38bff011f", 0 );
                        break;
                    case 2:
                        nearestdot = -1;
                        nearestspawn = level.spawnpoints[ 0 ];
                        playerforward = anglestoforward( host getplayerangles() );
                        
                        foreach ( spawnpoint in level.spawnpoints )
                        {
                            tospawnpoint = vectornormalize( spawnpoint.origin - host.origin );
                            dot = vectordot( playerforward, tospawnpoint );
                            
                            if ( dot > nearestdot )
                            {
                                nearestspawn = spawnpoint;
                                nearestdot = dot;
                            }
                        }
                        
                        level.var_3217e4102126369 = nearestspawn;
                        level.var_e320251b444bea29 = undefined;
                        setdevdvar( @"hash_36ffd6c38bff011f", 0 );
                        break;
                }
                
                switch ( getdvarint( @"hash_da92d5d5b7678a37", 0 ) )
                {
                    case 1:
                        playernodes = host getnearnodelistforspawncheck( spawnlogic::getfarnoderadiusdist() );
                        level.var_e320251b444bea29 = playernodes[ 0 ];
                        level.var_3217e4102126369 = undefined;
                        setdevdvar( @"hash_da92d5d5b7678a37", 0 );
                        break;
                    case 2:
                        startpos = host geteye();
                        dir = anglestoforward( host getplayerangles() );
                        endpos = startpos + dir * 5000;
                        traceresults = trace::ray_trace( startpos, endpos, host );
                        pathnodes = [];
                        
                        if ( isdefined( traceresults[ "<dev string:x236>" ] ) )
                        {
                            pathnodes = spawnlogic::getradiuspathsighttestnodes( traceresults[ "<dev string:x236>" ] );
                        }
                        
                        level.var_e320251b444bea29 = pathnodes[ 0 ];
                        level.var_3217e4102126369 = undefined;
                        setdevdvar( @"hash_da92d5d5b7678a37", 0 );
                        break;
                }
                
                if ( isdefined( level.var_3217e4102126369 ) )
                {
                    playernodes = host getnearnodelistforspawncheck( spawnlogic::getfarnoderadiusdist() );
                    spawnpointnodes = spawnlogic::getradiuspathsighttestnodes( level.var_3217e4102126369.origin );
                    
                    if ( isdefined( playernodes[ 0 ] ) && isdefined( spawnpointnodes[ 0 ] ) )
                    {
                        if ( var_da31ada643dedca5 == 1 )
                        {
                            function_fca1d2a8b31b5cc5( host, playernodes[ 0 ], spawnpointnodes[ 0 ] );
                        }
                        else
                        {
                            function_fee7b76683ad7f3( host, spawnpointnodes[ 0 ] );
                        }
                    }
                    
                    return;
                }
                
                if ( isdefined( level.var_e320251b444bea29 ) )
                {
                    playernodes = host getnearnodelistforspawncheck( spawnlogic::getfarnoderadiusdist() );
                    
                    if ( isdefined( playernodes[ 0 ] ) )
                    {
                        if ( var_da31ada643dedca5 == 1 )
                        {
                            function_fca1d2a8b31b5cc5( host, playernodes[ 0 ], level.var_e320251b444bea29 );
                            return;
                        }
                        
                        function_fee7b76683ad7f3( host, level.var_e320251b444bea29 );
                    }
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x7ef41279, Offset: 0x3046
    // Size: 0x289, Type: dev
    function function_fca1d2a8b31b5cc5( player, playernode, spawnnode )
    {
        pathpositions = player findpath( spawnnode.origin, playernode.origin );
        
        if ( !isdefined( pathpositions ) || pathpositions.size == 0 )
        {
            return;
        }
        
        function_7c8b72d92c9437be( pathpositions, ( 1, 1, 1 ) );
        tempspawnstruct = spawnstruct();
        tempspawnstruct.radiuspathnodes = [ spawnnode ];
        pathnodes = [];
        
        foreach ( pathposition in pathpositions )
        {
            pathnode = getclosestnodeinsight( pathposition );
            
            if ( isdefined( pathnode ) )
            {
                pathnodes[ pathnode getnodenumber() ] = pathnode;
            }
        }
        
        foreach ( pathnode in pathnodes )
        {
            start = pathnode.origin + ( 0, 0, 60 );
            end = spawnnode.origin + ( 0, 0, 60 );
            dist = distance( start, end );
            traceresults = trace::ray_trace( start, end, player );
            viewerstruct = spawnstruct();
            viewerstruct.spawnviewpathnodes = [ pathnode ];
            ttlos = spawnlogic::_precomputedlosdatatest( viewerstruct, tempspawnstruct );
            line( end, start, ( 0, 0, 1 ), 0, level.var_59de0a10a714e6b0 );
            box( start, 0, ( 0, 0, 0 ), 0, level.var_59de0a10a714e6b0 );
            box( end, 0, ( 1, 1, 1 ), 0, level.var_59de0a10a714e6b0 );
            function_15138e89030e7602( pathnode, ttlos );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xa15c2441, Offset: 0x32d7
    // Size: 0x147, Type: dev
    function function_fee7b76683ad7f3( player, targetnode )
    {
        pathnodes = getnodesinradius( player.origin, getdvarint( @"hash_8ce1d68eab6c438c", 1000 ), 0, 1024 );
        
        if ( !isdefined( pathnodes ) || pathnodes.size == 0 )
        {
            return;
        }
        
        sphere( targetnode.origin, 50, ( 1, 1, 1 ), 0, level.var_59de0a10a714e6b0 );
        tempspawnstruct = spawnstruct();
        tempspawnstruct.radiuspathnodes = [ targetnode ];
        
        foreach ( pathnode in pathnodes )
        {
            viewerstruct = spawnstruct();
            viewerstruct.spawnviewpathnodes = [ pathnode ];
            ttlos = spawnlogic::_precomputedlosdatatest( viewerstruct, tempspawnstruct );
            function_15138e89030e7602( pathnode, ttlos );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x30ef7ea4, Offset: 0x3426
    // Size: 0x19c, Type: dev
    function function_15138e89030e7602( pathnode, ttlos )
    {
        lowerlimitfullsights = getdvarfloat( @"scr_lowerlimitfullsights" );
        lowerlimitcornersights = getdvarfloat( @"scr_lowerlimitcornersights" );
        color = ( 0, 1, 0 );
        
        if ( ttlos[ 0 ] > lowerlimitfullsights )
        {
            color = ( 1, 0, 0 );
        }
        else if ( ttlos[ 0 ] > lowerlimitcornersights )
        {
            color = ( 1, 1, 0 );
        }
        
        print3d( pathnode.origin, ( 1 - ttlos[ 0 ] ) * 2550, color, 1, 1, level.var_59de0a10a714e6b0 );
        line( pathnode.origin + ( 0, 0, -10 ), pathnode.origin + ( 0, 0, 10 ), color, 1, 0, level.var_59de0a10a714e6b0 );
        line( pathnode.origin + ( 10, 0, 0 ), pathnode.origin + ( -10, 0, 0 ), color, 1, 0, level.var_59de0a10a714e6b0 );
        line( pathnode.origin + ( 0, 10, 0 ), pathnode.origin + ( 0, -10, 0 ), color, 1, 0, level.var_59de0a10a714e6b0 );
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x76aaad07, Offset: 0x35ca
    // Size: 0xdb, Type: dev
    function function_2a6e7065cb530979( mainspawnset, fallbackspawnset, var_55508d38456d0e8 )
    {
        if ( getdvarint( @"hash_4dea2ef3c922a80b" ) != 0 && level.var_8b5c76fe32f32acf )
        {
            spawnlogic::deactivateallspawnsets();
            spawnsets = getarraykeys( level.spawnglobals.spawnsets );
            
            foreach ( spawnset in spawnsets )
            {
                spawnlogic::activatespawnset( spawnset, 0 );
            }
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x38db8255, Offset: 0x36ad
    // Size: 0x103, Type: dev
    function function_96866f3a345090c7( spawningplayer )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        level.var_a4af9e395a5e2d4 = spawnstruct();
        data = level.var_a4af9e395a5e2d4;
        data.spawningplayer = spawningplayer;
        data.spawnpoints = undefined;
        
        foreach ( player in level.players )
        {
            player.var_7f3e27118dbf0e50 = undefined;
            player.var_7008a816abd98abf = undefined;
            player.var_bb9ba0040496c940 = undefined;
            player.buddyspawnpos = player.origin;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2eaadc15, Offset: 0x37b8
    // Size: 0x460, Type: dev
    function function_307fdd243ae1a43f()
    {
        while ( true )
        {
            var_229f3ab86ce035fd = getdvarint( @"hash_9bffca47d2e56b54" );
            
            if ( var_229f3ab86ce035fd == 0 )
            {
                waitframe();
                continue;
            }
            
            if ( var_229f3ab86ce035fd == 1 )
            {
                host = devfindhost();
                
                if ( !isdefined( host ) || host.team == "<dev string:x283>" )
                {
                    waitframe();
                    continue;
                }
                
                spawncontext = spawnlogic::createspawnquerycontext( host, host.team );
                spawnlogic::setactivespawnquerycontext( spawncontext );
                var_7f3e27118dbf0e50 = host spawnscoring::findbuddyspawn();
            }
            
            waitframe();
            
            if ( !isdefined( level.var_a4af9e395a5e2d4 ) )
            {
                continue;
            }
            
            foreach ( player in level.players )
            {
                if ( player == level.var_a4af9e395a5e2d4.spawningplayer )
                {
                    continue;
                }
                
                box( player.buddyspawnpos, 0, player.team != level.var_a4af9e395a5e2d4.spawningplayer.team ? ( 1, 0, 0 ) : ( 1, 1, 1 ), 0, 1 );
                
                if ( player.var_7f3e27118dbf0e50 != "<dev string:x2a5>" )
                {
                    playertext = player.var_7f3e27118dbf0e50 ?? "<dev string:x2ab>";
                    color = player.var_7f3e27118dbf0e50 == "<dev string:x2a5>" ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                    print3d( player.buddyspawnpos + ( 0, 0, 50 ), playertext, color, 1, 1, 1 );
                }
                
                if ( isdefined( player.var_7008a816abd98abf ) )
                {
                    foreach ( pathnode in player.var_7008a816abd98abf )
                    {
                        line( pathnode.origin, player.buddyspawnpos + ( 0, 0, 36 ), ( 0, 0, 0.5 ), 1, 0, 1 );
                        box( pathnode.origin, 0, ( 0, 0, 1 ), 0, 1 );
                    }
                }
            }
            
            foreach ( spawnpoint in level.var_a4af9e395a5e2d4.spawnpoints )
            {
                color = spawnpoint.var_9ae707ddde7e7e93 == "<dev string:x2b5>" ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                crittext = "<dev string:x2bd>" + ( spawnpoint.var_9ae707ddde7e7e93 ?? "<dev string:x2ab>" );
                drawspawnpoint( spawnpoint, "<dev string:x2c4>", color, "<dev string:x2d0>" + spawnpoint.totalscore, crittext );
                line( spawnpoint.origin + ( 0, 0, 36 ), spawnpoint.owner.buddyspawnpos + ( 0, 0, 36 ), ( 1, 1, 1 ), 1, 0, 1 );
            }
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xc1a30293, Offset: 0x3c20
    // Size: 0x39, Type: dev
    function function_f6455fc7b730d9f9( player, result )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        player.var_7f3e27118dbf0e50 = result;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x651d8aec, Offset: 0x3c61
    // Size: 0x45, Type: dev
    function function_ade21d22c5c6d9c6( spawnpoints )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        data = level.var_a4af9e395a5e2d4;
        data.spawnpoints = spawnpoints;
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xe499ff13, Offset: 0x3cae
    // Size: 0x41, Type: dev
    function function_4cce993aca3c36a3( buddy, pathnodes )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        if ( !isdefined( pathnodes ) )
        {
            return;
        }
        
        buddy.var_7008a816abd98abf = pathnodes;
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x40939ca1, Offset: 0x3cf7
    // Size: 0x41, Type: dev
    function function_97b016636c4e563c( buddy, pathnode )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        if ( !isdefined( pathnode ) )
        {
            return;
        }
        
        buddy.var_bb9ba0040496c940 = pathnode;
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x48fc397d, Offset: 0x3d40
    // Size: 0x39, Type: dev
    function function_9549682a12e7ad1( spawnpoint, reason )
    {
        if ( getdvarint( @"hash_9bffca47d2e56b54" ) == 0 )
        {
            return;
        }
        
        spawnpoint.var_9ae707ddde7e7e93 = reason;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xe1cfda80, Offset: 0x3d81
    // Size: 0xc5, Type: dev
    function function_102dff56284844d2( spawn_point_classname )
    {
        classname_parts = strtok( spawn_point_classname, "<dev string:x2d8>" );
        cmd = classname_parts[ 0 ];
        
        if ( classname_parts.size > 1 )
        {
            assert( classname_parts.size == 3 );
            cmd += "<dev string:x2da>" + classname_parts[ 1 ] + "<dev string:x2dc>" + classname_parts[ 2 ] + "<dev string:x2df>";
        }
        
        origin = self.origin;
        angles = ( 0, self.angles[ 1 ], 0 );
        cmd += "<dev string:x2da>" + function_628514c416bec965( "<dev string:x2e1>", origin ) + "<dev string:x2da>" + function_628514c416bec965( "<dev string:x2e8>", angles );
        return cmd;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x64e0d97a, Offset: 0x3e4e
    // Size: 0x7ed, Type: dev
    function function_7495dbd79e2c3aa6()
    {
        level endon( #"hash_47f3d9a9e91670d1" );
        self endon( #"disconnect" );
        dpad_left = 0;
        dpad_right = 0;
        dpad_up = 0;
        dpad_down = 0;
        var_fd2700823b5df238 = 0;
        
        if ( !isdefined( level.spawninspection ) )
        {
            level.spawninspection = spawnstruct();
        }
        
        level.spawninspection.teamfilter = "<dev string:x2ef>";
        level.spawninspection.currentsetindex = 0;
        level.spawninspection.currentspawnindex = 0;
        level.spawninspection.var_ff89847553d799e = 0;
        level.spawninspection.msg = "<dev string:x2f4>";
        updateplayerposition = 0;
        creationmode = 0;
        scale = 2;
        var_18f723825e78e614 = getarraykeys( level.spawnglobals.spawnsets );
        
        while ( true )
        {
            self setactionslot( 3, "<dev string:x2f4>" );
            self setactionslot( 4, "<dev string:x2f4>" );
            
            if ( !var_fd2700823b5df238 && ( self buttonpressed( "<dev string:x2f5>" ) || self buttonpressed( "<dev string:x303>" ) ) )
            {
                var_fd2700823b5df238 = 1;
                creationmode = !creationmode;
            }
            else if ( !self buttonpressed( "<dev string:x2f5>" ) && !self buttonpressed( "<dev string:x303>" ) )
            {
                var_fd2700823b5df238 = 0;
            }
            
            if ( !dpad_up && ( self buttonpressed( "<dev string:x305>" ) || self buttonpressed( "<dev string:x30d>" ) ) )
            {
                level.spawninspection.currentsetindex++;
                
                if ( level.spawninspection.currentsetindex >= var_18f723825e78e614.size )
                {
                    level.spawninspection.currentsetindex = 0;
                }
                
                level.spawninspection.currentspawnindex = 0;
                dpad_up = 1;
                updateplayerposition = 1;
            }
            else if ( !self buttonpressed( "<dev string:x305>" ) && !self buttonpressed( "<dev string:x30d>" ) )
            {
                dpad_up = 0;
            }
            
            if ( !dpad_down && ( self buttonpressed( "<dev string:x315>" ) || self buttonpressed( "<dev string:x31f>" ) ) )
            {
                level.spawninspection.currentsetindex--;
                
                if ( level.spawninspection.currentsetindex < 0 )
                {
                    level.spawninspection.currentsetindex = var_18f723825e78e614.size - 1;
                }
                
                level.spawninspection.currentspawnindex = 0;
                updateplayerposition = 1;
                dpad_down = 1;
            }
            else if ( !self buttonpressed( "<dev string:x315>" ) && !self buttonpressed( "<dev string:x31f>" ) )
            {
                dpad_down = 0;
            }
            
            if ( !dpad_left && ( self buttonpressed( "<dev string:x329>" ) || self buttonpressed( "<dev string:x333>" ) ) )
            {
                if ( creationmode )
                {
                    origin = self.origin;
                    angles = ( 0, self.angles[ 1 ], 0 );
                    cmd = function_628514c416bec965( "<dev string:x2e1>", origin ) + "<dev string:x2da>" + function_628514c416bec965( "<dev string:x2e8>", angles );
                    function_f2f129da49e94757( cmd );
                    displaymsg( "<dev string:x33d>" + origin + "<dev string:x356>" + angles );
                }
                else
                {
                    level.spawninspection.currentspawnindex--;
                    setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                    set = level.spawnglobals.spawnsets[ setid ];
                    
                    if ( level.spawninspection.currentspawnindex < 0 )
                    {
                        level.spawninspection.currentspawnindex = set.spawnpoints.size - 1;
                    }
                    
                    updateplayerposition = 1;
                    println( "<dev string:x358>" + level.spawninspection.currentspawnindex );
                }
                
                dpad_left = 1;
            }
            else if ( !self buttonpressed( "<dev string:x329>" ) && !self buttonpressed( "<dev string:x333>" ) )
            {
                dpad_left = 0;
            }
            
            if ( !dpad_right && ( self buttonpressed( "<dev string:x363>" ) || self buttonpressed( "<dev string:x36e>" ) ) )
            {
                if ( creationmode )
                {
                    setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                    set = level.spawnglobals.spawnsets[ setid ];
                    cmd = function_102dff56284844d2( set.devname );
                    function_8233006b43783ea( cmd );
                    displaymsg( "<dev string:x379>" + cmd );
                }
                else
                {
                    level.spawninspection.currentspawnindex++;
                    setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                    set = level.spawnglobals.spawnsets[ setid ];
                    
                    if ( level.spawninspection.currentspawnindex >= set.spawnpoints.size )
                    {
                        level.spawninspection.currentspawnindex = 0;
                    }
                    
                    updateplayerposition = 1;
                    println( "<dev string:x389>" + level.spawninspection.currentspawnindex );
                }
                
                dpad_right = 1;
            }
            else if ( !self buttonpressed( "<dev string:x363>" ) && !self buttonpressed( "<dev string:x36e>" ) )
            {
                dpad_right = 0;
            }
            
            if ( !creationmode && updateplayerposition && level.spawnglobals.spawnsets[ var_18f723825e78e614[ level.spawninspection.currentsetindex ] ].spawnpoints.size > 0 )
            {
                setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                set = level.spawnglobals.spawnsets[ setid ];
                spawnpoint = set.spawnpoints[ level.spawninspection.currentspawnindex ];
                println( "<dev string:x395>" + set.devname );
                self setorigin( spawnpoint.origin );
                self setplayerangles( spawnpoint.angles );
                updateplayerposition = 0;
            }
            
            if ( creationmode )
            {
                setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                set = level.spawnglobals.spawnsets[ setid ];
                printtoscreen2d( 100, 840, "<dev string:x3b5>", ( 1, 0, 0 ), scale );
                printtoscreen2d( 100, 870, "<dev string:x3c3>" + set.devname, ( 1, 0, 0 ), scale );
                updatemsg();
            }
            else
            {
                setid = var_18f723825e78e614[ level.spawninspection.currentsetindex ];
                set = level.spawnglobals.spawnsets[ setid ];
                size = set.spawnpoints.size;
                current_spawn_point = string( level.spawninspection.currentspawnindex + 1 );
                
                if ( size == 0 )
                {
                    current_spawn_point = "<dev string:xa3>";
                }
                
                printtoscreen2d( 100, 840, "<dev string:x3cd>", ( 1, 1, 0 ), scale );
                printtoscreen2d( 100, 870, "<dev string:x3dd>" + set.devname, ( 1, 1, 0 ), scale );
                printtoscreen2d( 100, 900, "<dev string:x3e7>" + current_spawn_point + "<dev string:x3ef>" + string( size ), ( 1, 1, 0 ), scale );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x114d6309, Offset: 0x4643
    // Size: 0x41, Type: dev
    function function_628514c416bec965( key, vec )
    {
        return key + "<dev string:x2dc>" + vec[ 0 ] + "<dev string:x3f8>" + vec[ 1 ] + "<dev string:x3f8>" + vec[ 2 ] + "<dev string:x2df>";
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x95c7e3ae, Offset: 0x468c
    // Size: 0x41, Type: dev
    function displaymsg( msg )
    {
        level.spawninspection.msg = msg;
        level.spawninspection.var_ff89847553d799e = gettime() + 4000;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd4b2e70b, Offset: 0x46d5
    // Size: 0x67, Type: dev
    function updatemsg()
    {
        if ( gettime() < level.spawninspection.var_ff89847553d799e && level.spawninspection.msg != "<dev string:x2f4>" )
        {
            printtoscreen2d( 100, 710, level.spawninspection.msg, ( 1, 0, 0 ) );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xeb454ad, Offset: 0x4744
    // Size: 0x5ee, Type: dev
    function updatedevsettings_killstreaks()
    {
        level thread function_c9cbf935219e6f72();
        var_a1a8006aa984b1c7 = getdvarint( @"scr_givekillstreaks" );
        
        if ( var_a1a8006aa984b1c7 != 0 )
        {
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                if ( isbot( player ) || istestclient( player ) )
                {
                    continue;
                }
                
                player killstreaks::equipkillstreak( "<dev string:x3fb>", 1 );
                player killstreaks::equipkillstreak( "<dev string:x406>", 2 );
                player killstreaks::equipkillstreak( "<dev string:x40e>", 3 );
                player killstreaks::givestreakpoints( getxhash( "<dev string:x419>" ), 15, 1500 );
                setdevdvar( @"scr_givekillstreaks", 0 );
            }
        }
        
        dvar_scr_givekillstreak = getdvar( @"scr_givekillstreak", "<dev string:x2f4>" );
        var_e1212251f23cf4b1 = getdvar( @"hash_eee5eaa5d4fb65b3", "<dev string:x2f4>" );
        dvar_scr_givekillstreakblueprintindex = getdvarint( @"scr_givekillstreakblueprintindex", 0 );
        
        if ( dvar_scr_givekillstreak != "<dev string:x2f4>" )
        {
            level.var_488c9a7624e2b0d0 = 1;
            streaknames = strtok( dvar_scr_givekillstreak, "<dev string:x424>" );
            blueprintindexes = strtok( dvar_scr_givekillstreakblueprintindex, "<dev string:x424>" );
            var_629b88ed632a30c2 = streaknames.size > 1;
            
            for ( i = 0; i < streaknames.size ; i++ )
            {
                streakname = streaknames[ i ];
                blueprintindex = int( blueprintindexes[ i ] ?? "<dev string:xa3>" );
                streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
                var_ec73d9361a038a70 = 0;
                emptime = undefined;
                
                if ( streakname == "<dev string:x426>" )
                {
                    var_ec73d9361a038a70 = 1;
                    emptime = getdvarfloat( @"scr_emp_timeout" );
                    streakname = "<dev string:x430>";
                    setdevdvar( @"scr_emp_timeout", 1 );
                }
                
                if ( isdefined( streaksetupinfo ) && killstreak_utility::getkillstreakindex( streakname ) != -1 )
                {
                    playerarray = function_ffe8acaa84c63e12();
                    
                    foreach ( player in playerarray )
                    {
                        if ( player.team != "<dev string:x283>" && player.sessionstate != "<dev string:x283>" )
                        {
                            if ( streakname == "<dev string:x434>" )
                            {
                                nuketype = getdvarint( @"scr_nuke_type", 0 );
                                
                                switch ( nuketype )
                                {
                                    case 1:
                                        streakname = "<dev string:x439>";
                                        break;
                                    case 2:
                                        streakname = "<dev string:x44e>";
                                        break;
                                }
                            }
                            
                            if ( !isdefined( player.pers[ #"hash_5358b5a919fe00a6" ] ) )
                            {
                                player.pers[ #"hash_5358b5a919fe00a6" ] = [];
                            }
                            
                            if ( var_e1212251f23cf4b1 != "<dev string:x2f4>" )
                            {
                                player.pers[ #"hash_5358b5a919fe00a6" ][ streakname ] = getxhashasset( var_e1212251f23cf4b1 );
                                setdevdvar( @"hash_eee5eaa5d4fb65b3", "<dev string:x2f4>" );
                            }
                            else
                            {
                                player.pers[ #"hash_5358b5a919fe00a6" ][ streakname ] = undefined;
                            }
                            
                            if ( istestclient( player ) )
                            {
                                continue;
                            }
                            
                            if ( isbrgamemode() || isdmzgamemode() )
                            {
                                player br_pickups::forcegivekillstreak( streakname, 0, 0, 0, 0, 0, undefined );
                                continue;
                            }
                            
                            player thread hud_message::showkillstreaksplash( streakname, player killstreaks::calcstreakcost( streakname ), undefined );
                            
                            if ( var_629b88ed632a30c2 )
                            {
                                player killstreaks::awardkillstreak( streakname, "<dev string:x459>", undefined, undefined, undefined, i, blueprintindex );
                                continue;
                            }
                            
                            if ( isdefined( level.var_ceefa46f8106bbca.killstreakslot ) && level.var_ceefa46f8106bbca.killstreakslot != 0 )
                            {
                                player killstreaks::equipkillstreak( streakname, level.var_ceefa46f8106bbca.killstreakslot, blueprintindex );
                                player killstreaks::setselectedkillstreak( level.var_ceefa46f8106bbca.killstreakslot );
                                player killstreaks::makekillstreakavailable( level.var_ceefa46f8106bbca.killstreakslot, "<dev string:x459>" );
                                continue;
                            }
                            
                            player killstreaks::awardkillstreak( streakname, "<dev string:x459>", undefined, undefined, undefined, undefined, blueprintindex );
                        }
                    }
                }
                else
                {
                    level thread function_bab91dfe0b77c4e8( "<dev string:x45f>" + dvar_scr_givekillstreak, 1 );
                    level thread function_bab91dfe0b77c4e8( "<dev string:x47c>", 2 );
                    println( "<dev string:x2df>" + dvar_scr_givekillstreak + "<dev string:x499>" );
                    
                    foreach ( killstreak, value in level.killstreaksetups )
                    {
                        if ( killstreak_utility::getkillstreakindex( killstreak ) != -1 )
                        {
                            println( "<dev string:x4cd>" + killstreak );
                        }
                    }
                    
                    println( "<dev string:x2f4>" );
                }
                
                if ( var_629b88ed632a30c2 )
                {
                    wait 1;
                }
            }
            
            if ( var_ec73d9361a038a70 )
            {
                level thread function_a48e6713064f914f( 5, @"scr_emp_timeout", emptime );
            }
            
            level.var_488c9a7624e2b0d0 = 0;
            setdevdvar( @"scr_givekillstreak", "<dev string:x2f4>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6420e564, Offset: 0x4d3a
    // Size: 0x113, Type: dev
    function function_c9cbf935219e6f72()
    {
        level endon( #"game_ended" );
        
        if ( !getdvarint( @"hash_91d8e47c501b6b33", 1 ) )
        {
            return;
        }
        
        bonusthreshold = level.gamemodebundle.var_e1660c9722ed73ca ?? 1000;
        var_6f8d032cfd402c9e = getdvarfloat( @"hash_86e92d3b2d8e5e8f", -1 );
        
        if ( var_6f8d032cfd402c9e >= 0 )
        {
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                var_244bb09b29e0dc3f = bonusthreshold * var_6f8d032cfd402c9e;
                player.pers[ "<dev string:x4d2>" ] = var_244bb09b29e0dc3f;
            }
            
            setdvar( @"hash_86e92d3b2d8e5e8f", -1 );
        }
    }

    // Namespace dev_mp
    // Params 2, eflags: 0x4
    // Checksum 0xc0771ad6, Offset: 0x4e55
    // Size: 0x26, Type: dev
    function private function_bab91dfe0b77c4e8( msg, delay )
    {
        wait delay ?? 0;
        iprintlnbold( msg );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4e4d9db2, Offset: 0x4e83
    // Size: 0x3d5e, Type: dev
    function updatedevsettings()
    {
        updateminimapsetting();
        
        if ( getdvar( @"hash_c6152d5c441f3a5", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            camval = int( getdvar( @"hash_c6152d5c441f3a5" ) );
            setdevdvar( @"hash_c6152d5c441f3a5", "<dev string:x2f4>" );
            
            if ( camval == 1 )
            {
                foreach ( player in level.players )
                {
                    player thread notifyaftertime();
                    player playerlogic::spawnspectatormapcam( 99 );
                }
            }
            else if ( camval == 2 )
            {
                map_restart();
            }
        }
        
        if ( getdvar( @"hash_d732ae157aef3ffd", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            score = getdvarint( @"hash_d732ae157aef3ffd" );
            gamescore::setteamscore( "<dev string:x4dd>", score );
        }
        
        if ( getdvar( @"hash_1b83a785deee1fc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            score = getdvarint( @"hash_1b83a785deee1fc" );
            gamescore::setteamscore( "<dev string:x4e4>", score );
        }
        
        if ( getdvar( @"hash_5846fb2081840ca1", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            setdevdvar( @"hash_5846fb2081840ca1", "<dev string:x2f4>" );
            
            for ( rid = 0; rid <= level.maxrank ; rid++ )
            {
                rankname = progression_utility::function_17f2711b0e810836( rid );
                iprintln( "<dev string:x4e9>" + rid + 1 );
                iprintln( "<dev string:x50c>", rankname, "<dev string:x52d>" + rid + 1 + "<dev string:x532>" );
                wait 0.05;
            }
        }
        
        updatedevsettings_killstreaks();
        var_e4c08605a2f0a6a1 = getdvarint( @"hash_b19cc3eed2cbedd8", 0 );
        var_448fd9a3e244ab0 = getdvarint( @"hash_4cef10a57c4fc6e7", 0 );
        
        if ( var_e4c08605a2f0a6a1 > 0 || var_448fd9a3e244ab0 > 0 )
        {
            foreach ( player in level.players )
            {
                player killstreaks::givestreakpoints( #"assist", 0, var_e4c08605a2f0a6a1 );
                player killstreaks::givestreakpoints( #"bounty", 0, var_448fd9a3e244ab0 );
            }
            
            setdevdvar( @"hash_b19cc3eed2cbedd8", 0 );
            setdevdvar( @"hash_4cef10a57c4fc6e7", 0 );
        }
        
        streakname = undefined;
        streaktype = undefined;
        var_6b700d6359ca71b3 = 0;
        var_545fc54d0ffe7bc = getdvar( @"hash_9c416c757bf76ea2", "<dev string:x2f4>" );
        var_103fd58dc01a02b0 = getdvar( @"hash_6dfb150e62d63d1a", "<dev string:x2f4>" );
        
        if ( var_545fc54d0ffe7bc != "<dev string:x2f4>" )
        {
            streakname = var_545fc54d0ffe7bc;
            streaktype = getdvar( @"hash_e0efb606c92e6d72", "<dev string:x2f4>" );
        }
        else if ( var_103fd58dc01a02b0 != "<dev string:x2f4>" )
        {
            streakname = var_103fd58dc01a02b0;
            streaktype = getdvar( @"hash_8727321c64d0325a", "<dev string:x2f4>" );
            var_6b700d6359ca71b3 = 1;
        }
        
        if ( isdefined( streakname ) )
        {
            if ( isdefined( level.killstreaksetups[ streakname ] ) && killstreak_utility::getkillstreakindex( streakname ) != -1 || streakname == "<dev string:x534>" )
            {
                foreach ( player in level.players )
                {
                    if ( isbot( player ) || istestclient( player ) )
                    {
                        if ( !var_6b700d6359ca71b3 )
                        {
                            continue;
                        }
                    }
                    else if ( var_6b700d6359ca71b3 )
                    {
                        continue;
                    }
                    
                    if ( player.team != "<dev string:x283>" && player.sessionstate != "<dev string:x283>" )
                    {
                        player thread hud_message::showkillstreaksplash( "<dev string:x406>", killstreaks::calcstreakcost( "<dev string:x406>" ), undefined );
                        player killstreaks::awardkillstreak( "<dev string:x406>", undefined, undefined, player );
                    }
                    
                    if ( streakname != "<dev string:x534>" )
                    {
                        setdevdvar( @"scr_crateoverride", streakname );
                        setdevdvar( @"hash_22186e8d4f1020da", streaktype );
                        continue;
                    }
                    
                    setdevdvar( @"scr_crateoverride", "<dev string:x2f4>" );
                    setdevdvar( @"hash_22186e8d4f1020da", "<dev string:x2f4>" );
                }
            }
            else
            {
                println( "<dev string:x2df>" + var_545fc54d0ffe7bc + "<dev string:x53b>" );
                
                foreach ( killstreak, value in level.killstreaksetups )
                {
                    if ( killstreak_utility::getkillstreakindex( killstreak ) != -1 )
                    {
                        println( "<dev string:x4cd>" + killstreak );
                    }
                }
                
                println( "<dev string:x2f4>" );
            }
            
            if ( var_545fc54d0ffe7bc != "<dev string:x2f4>" )
            {
                setdevdvar( @"hash_9c416c757bf76ea2", "<dev string:x2f4>" );
                setdevdvar( @"hash_e0efb606c92e6d72", "<dev string:x2f4>" );
            }
            else if ( var_103fd58dc01a02b0 != "<dev string:x2f4>" )
            {
                setdevdvar( @"hash_6dfb150e62d63d1a", "<dev string:x2f4>" );
                setdevdvar( @"hash_8727321c64d0325a", "<dev string:x2f4>" );
            }
        }
        
        if ( getdvar( @"hash_a39dff4526bfe814", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            tokens = strtok( getdvar( @"hash_a39dff4526bfe814" ), "<dev string:x356>" );
            
            if ( tokens.size )
            {
                playername = tokens[ 0 ];
                
                if ( isdefined( tokens[ 1 ] ) )
                {
                    slotid = int( tokens[ 1 ] );
                }
                else
                {
                    slotid = 0;
                }
                
                owner = undefined;
                
                foreach ( player in level.players )
                {
                    if ( player.name == playername )
                    {
                        owner = player;
                        break;
                    }
                }
                
                if ( !isdefined( owner ) )
                {
                    println( "<dev string:x573>" + playername + "<dev string:x57b>" );
                }
            }
            
            setdevdvar( @"hash_a39dff4526bfe814", "<dev string:x2f4>" );
        }
        
        dvar_scr_usekillstreak = getdvar( @"scr_usekillstreak", "<dev string:x2f4>" );
        
        if ( dvar_scr_usekillstreak != "<dev string:x2f4>" )
        {
            tokens = strtok( dvar_scr_usekillstreak, "<dev string:x356>" );
            
            if ( tokens.size > 1 )
            {
                playername = tokens[ 0 ];
                streakname = tokens[ 1 ];
                streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
                
                if ( !isdefined( streaksetupinfo ) )
                {
                    println( "<dev string:x586>" + streakname + "<dev string:x57b>" );
                }
                
                owner = undefined;
                
                foreach ( player in level.players )
                {
                    if ( player.name == playername )
                    {
                        owner = player;
                        player thread killstreaks::forceactivatekillstreak( streakname );
                        
                        if ( issubstr( streakname, "<dev string:x592>" ) )
                        {
                            wait 0.05;
                            player notify( #"confirm_location", level.mapcenter, 0 );
                        }
                        
                        if ( issubstr( streakname, "<dev string:x406>" ) )
                        {
                            wait 0.05;
                            
                            switch ( streakname )
                            {
                                case #"hash_a400758fbab9a20e":
                                case #"hash_d5cb9b4efa4e54b6":
                                    assertmsg( "<dev string:x5bc>" );
                                    break;
                                case #"hash_7deb28cdb2fc0bdd":
                                    assertmsg( "<dev string:x60d>" );
                                    break;
                            }
                        }
                        
                        break;
                    }
                }
                
                if ( !isdefined( owner ) )
                {
                    println( "<dev string:x573>" + playername + "<dev string:x57b>" );
                }
            }
            
            setdevdvar( @"scr_usekillstreak", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_dcabbf514faaada9", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            tokens = strtok( getdvar( @"hash_dcabbf514faaada9" ), "<dev string:x356>" );
            neworigin = ( int( tokens[ 0 ] ), int( tokens[ 1 ] ), int( tokens[ 2 ] ) );
            playername = tokens[ 3 ];
            
            foreach ( player in level.players )
            {
                if ( player.name == playername )
                {
                    player setorigin( neworigin );
                    break;
                }
            }
            
            setdevdvar( @"hash_dcabbf514faaada9", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_a4d8c0314583b9e0", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            tokens = strtok( getdvar( @"hash_a4d8c0314583b9e0" ), "<dev string:x356>" );
            
            if ( tokens.size > 1 )
            {
                playername = tokens[ 0 ];
                var_5b6ad3a4cdd0fcbf = tokens[ 1 ];
                
                if ( !isdefined( level.scriptperks[ var_5b6ad3a4cdd0fcbf ] ) )
                {
                    println( "<dev string:x655>" + var_5b6ad3a4cdd0fcbf + "<dev string:x57b>" );
                }
                
                owner = undefined;
                
                foreach ( player in level.players )
                {
                    if ( player.name == playername )
                    {
                        owner = player;
                        player notify( #"gambit_on" );
                        break;
                    }
                }
                
                if ( !isdefined( owner ) )
                {
                    println( "<dev string:x573>" + playername + "<dev string:x57b>" );
                }
            }
            
            setdevdvar( @"hash_a4d8c0314583b9e0", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_levelnotify", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            level notify( getdvar( @"scr_levelnotify" ) );
            setdevdvar( @"scr_levelnotify", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_giveperk", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            perk = getdvar( @"scr_giveperk" );
            var_4b2b3dc56d37a58 = getdvar( @"scr_giveperk_variation", "<dev string:x2f4>" ) != "<dev string:x2f4>" ? getdvar( @"scr_giveperk_variation" ) : undefined;
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] thread perk::giveperk( perk, undefined, var_4b2b3dc56d37a58 );
            }
            
            setdevdvar( @"scr_giveperk", "<dev string:x2f4>" );
            setdevdvar( @"scr_giveperk_variation", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_removeperk", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            perk = getdvar( @"scr_removeperk" );
            var_4b2b3dc56d37a58 = getdvar( @"scr_removeperk_variation", "<dev string:x2f4>" ) != "<dev string:x2f4>" ? getdvar( @"scr_removeperk_variation" ) : undefined;
            
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] thread perk::removeperk( perk, var_4b2b3dc56d37a58 );
            }
            
            setdevdvar( @"scr_removeperk", "<dev string:x2f4>" );
            setdevdvar( @"scr_removeperk_variation", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_x_kills_y", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            nametokens = strtok( getdvar( @"scr_x_kills_y" ), "<dev string:x356>" );
            
            if ( nametokens.size > 1 )
            {
                thread xkillsy( nametokens[ 0 ], nametokens[ 1 ] );
            }
            
            setdevdvar( @"scr_x_kills_y", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_6679cf3163ebab7", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            hostplayer = undefined;
            enemyplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( !player ishost() )
                {
                    continue;
                }
                
                hostplayer = player;
                break;
            }
            
            foreach ( player in level.players )
            {
                if ( level.teambased )
                {
                    if ( player.team == hostplayer.team )
                    {
                        continue;
                    }
                    
                    enemyplayer = player;
                    break;
                }
                
                if ( player ishost() )
                {
                    continue;
                }
                
                enemyplayer = player;
                break;
            }
            
            if ( isdefined( enemyplayer ) )
            {
                thread xkillsy( enemyplayer.name, hostplayer.name );
            }
            
            setdevdvar( @"hash_6679cf3163ebab7", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_drop_weapon", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            weapon = spawn( "<dev string:x65d>" + getdvar( @"scr_drop_weapon" ), level.players[ 0 ].origin );
            setdevdvar( @"scr_drop_weapon", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_set_rank", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            level.players[ 0 ].pers[ "<dev string:x665>" ] = 0;
            level.players[ 0 ].pers[ "<dev string:x66a>" ] = 0;
            newrank = min( getdvarint( @"scr_set_rank" ), 54 );
            newrank = max( newrank, 1 );
            setdevdvar( @"scr_set_rank", "<dev string:x2f4>" );
            
            if ( level.teambased )
            {
                foreach ( entry in level.teamnamelist )
                {
                    if ( !teams::getteamdata( entry, "<dev string:x671>" ) )
                    {
                        println( "<dev string:x67b>" );
                    }
                }
            }
            else
            {
                playercount = 0;
                
                foreach ( entry in level.teamnamelist )
                {
                    playercount += teams::getteamdata( entry, "<dev string:x671>" );
                }
                
                if ( playercount < 2 )
                {
                    println( "<dev string:x6c1>" );
                }
            }
            
            lastxp = 0;
            
            for ( index = 0; index <= newrank ; index++ )
            {
                newxp = progression_utility::getrankinfominxp( index );
                level.players[ 0 ] thread rank::giverankxp( #"kill", newxp - lastxp );
                lastxp = newxp;
                wait 0.25;
                self notify( #"hash_2f3190f014af6365" );
            }
        }
        
        if ( getdvarint( @"scr_rank_up", 0 ) != 0 )
        {
            currank = level.players[ 0 ] progression_utility::getrank();
            
            if ( currank != level.maxrank )
            {
                curxp = level.players[ 0 ] rank::getrankxp();
                neededxp = progression_utility::getrankinfomaxxp( currank ) - curxp;
                level.players[ 0 ] thread rank::giverankxp( #"kill", neededxp );
            }
            
            setdevdvar( @"scr_rank_up", 0 );
        }
        
        if ( getdvarint( @"scr_rank_up", 0 ) != 0 )
        {
            level.players[ 0 ] thread rank::giverankxp( #"challenge", getdvarint( @"scr_givexp" ) );
        }
        
        waitframe();
        
        if ( getdvar( @"hash_afb5a1040b7b5c86", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            notbot = function_2ee13eddfbd7f93c();
            notbot thread spam_points_popup();
            setdevdvar( @"hash_afb5a1040b7b5c86", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_show_splash", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            splashref = getdvar( @"scr_show_splash" );
            splashtokens = strtok( splashref, "<dev string:x706>" );
            
            if ( splashtokens.size > 1 )
            {
                splashlistoverride = splashtokens[ 0 ];
                splashref = splashtokens[ 1 ];
            }
            else
            {
                splashlistoverride = undefined;
            }
            
            if ( game_utility::getgametype() == "<dev string:x708>" )
            {
                level thread br_gametype_dmz::showdmzsplash( splashref, level.players );
            }
            else
            {
                foreach ( player in level.players )
                {
                    player thread hud_message::showsplash( splashref, 1, undefined, undefined, undefined, splashlistoverride );
                }
            }
            
            setdevdvar( @"scr_show_splash", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_show_splash_param", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            function_4e68244837c125a0();
        }
        
        if ( getdvar( @"scr_show_splash_global", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            function_713051940fe05138();
        }
        
        if ( getdvar( @"scr_show_splash_killstreak", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            function_2ae6b494e811ca5d();
        }
        
        if ( getdvar( @"scr_show_splash_type", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            splashtype = getdvar( @"scr_show_splash_type" );
            function_a7f3a0ccbd057d86( splashtype );
            setdevdvar( @"scr_show_splash_type", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_e7e9fe795e3b8bfa", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            challengetokens = strtok( getdvar( @"hash_e7e9fe795e3b8bfa" ), "<dev string:x356>" );
            
            if ( challengetokens.size > 1 )
            {
                aekind = int( challengetokens[ 0 ] );
                challengeid = int( challengetokens[ 1 ] );
                
                if ( isdefined( challengetokens[ 2 ] ) )
                {
                    progress = int( challengetokens[ 2 ] );
                }
                
                function_5ee57f35dfd23eec( aekind, challengeid, progress );
                setdevdvar( @"hash_e7e9fe795e3b8bfa", "<dev string:x2f4>" );
            }
        }
        
        if ( getdvar( @"hash_ca6af9ab4eea7f1b", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            foreach ( player in level.players )
            {
                player thread testlowermessage();
            }
            
            setdevdvar( @"hash_ca6af9ab4eea7f1b", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_entdebug", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            ents = getentarray();
            level.entarray = [];
            level.entcounts = [];
            level.entgroups = [];
            
            for ( index = 0; index < ents.size ; index++ )
            {
                classname = ents[ index ].classname;
                
                if ( !issubstr( classname, "<dev string:x70c>" ) )
                {
                    curent = ents[ index ];
                    level.entarray[ level.entarray.size ] = curent;
                    
                    if ( !isdefined( level.entcounts[ classname ] ) )
                    {
                        level.entcounts[ classname ] = 0;
                    }
                    
                    level.entcounts[ classname ]++;
                    
                    if ( !isdefined( level.entgroups[ classname ] ) )
                    {
                        level.entgroups[ classname ] = [];
                    }
                    
                    level.entgroups[ classname ][ level.entgroups[ classname ].size ] = curent;
                }
            }
        }
        
        if ( getdvar( @"scr_sre", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            assertmsg( "<dev string:x713>" );
            setdevdvar( @"scr_sre", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"scr_testmigration", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            setdevdvar( @"scr_testmigration", "<dev string:x2f4>" );
            thread hostmigration::callback_hostmigration();
            thread function_b83aba9d15e9b942();
        }
        
        if ( getdvar( @"hash_3198b55a01316553", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            promotion = getdvarint( @"hash_3198b55a01316553" ) == 2;
            
            foreach ( player in level.players )
            {
                player thread testendgameupdate( promotion );
            }
            
            setdevdvar( @"hash_3198b55a01316553", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_ccb91028531c7b90", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            ent = undefined;
            
            if ( isdefined( level.players[ 0 ] ) )
            {
                ent = level.players[ 0 ];
            }
            else if ( isdefined( level.players[ 0 ] ) )
            {
                ent = level.players[ 0 ];
            }
            
            if ( isdefined( ent ) )
            {
                println( "<dev string:x730>" + ent.origin[ 0 ] + "<dev string:x744>" + ent.origin[ 1 ] + "<dev string:x74a>" + ent.origin[ 2 ] );
            }
            else
            {
                println( "<dev string:x750>" );
            }
            
            setdevdvar( @"hash_ccb91028531c7b90", "<dev string:x2f4>" );
        }
        
        if ( getdvarint( @"hash_5011715b0d8686b1" ) > 0 )
        {
            clearscores = getdvarint( @"hash_5011715b0d8686b1" );
            
            if ( clearscores )
            {
                foreach ( entry in level.teamnamelist )
                {
                    gamescore::setteamscore( entry, 0 );
                }
            }
            
            setdevdvar( @"hash_5011715b0d8686b1", 0 );
        }
        
        if ( getdvarint( @"hash_1d72f4f6602796e9" ) > 0 )
        {
            setscore = getdvarint( @"hash_1d72f4f6602796e9" );
            
            if ( setscore )
            {
                level.scorelimit = 0;
            }
            
            setdevdvar( @"hash_1d72f4f6602796e9", 0 );
        }
        
        if ( getdvarint( @"hash_19130df90d792ee8" ) > 0 )
        {
            if ( game_utility::getgametype() == "<dev string:x75a>" )
            {
                if ( isdefined( level.var_b8108e132d830f23.development.setneutral ) )
                {
                    foreach ( objective in level.objectives )
                    {
                        [[ level.var_b8108e132d830f23.development.setneutral ]]( objective );
                    }
                }
            }
            
            setdevdvar( @"hash_19130df90d792ee8", 0 );
        }
        
        if ( getdvarint( @"hash_e182fb9e875bf879" ) > 0 )
        {
            if ( game_utility::getgametype() == "<dev string:x75a>" )
            {
                if ( isdefined( level.var_b8108e132d830f23.development.setcaptured ) )
                {
                    foreach ( objective in level.objectives )
                    {
                        [[ level.var_b8108e132d830f23.development.setcaptured ]]( objective, level.players[ 0 ].team );
                    }
                }
            }
            
            setdevdvar( @"hash_e182fb9e875bf879", 0 );
        }
        
        if ( getdvarint( @"hash_8a31b9a6205ce71b" ) > 0 )
        {
            cappointaction = getdvarint( @"hash_8a31b9a6205ce71b" );
            player = level.players[ 0 ];
            
            switch ( cappointaction )
            {
                case 1:
                    if ( player.team == "<dev string:x4e4>" || player.team == "<dev string:x4dd>" )
                    {
                        foreach ( objective in level.objectives )
                        {
                            if ( isdefined( level.dompoint_setcaptured ) )
                            {
                                objective [[ level.dompoint_setcaptured ]]( player.team, player );
                            }
                        }
                        
                        if ( isdefined( level.onflagcapture ) )
                        {
                            level [[ level.onflagcapture ]]( undefined, undefined, player, player.team, undefined, undefined );
                        }
                    }
                    
                    break;
                case 2:
                    foreach ( objective in level.objectives )
                    {
                        if ( isdefined( level.domflag_setneutral ) )
                        {
                            objective thread [[ level.domflag_setneutral ]]();
                        }
                    }
                    
                    break;
                case 3:
                    if ( player.team == "<dev string:x4e4>" || player.team == "<dev string:x4dd>" )
                    {
                        otherteam = team_utility::getotherteam( player.team );
                        
                        foreach ( objective in level.objectives )
                        {
                            if ( isdefined( level.dompoint_setcaptured ) )
                            {
                                objective [[ level.dompoint_setcaptured ]]( otherteam, player );
                            }
                        }
                        
                        if ( isdefined( level.onflagcapture ) )
                        {
                            level [[ level.onflagcapture ]]( undefined, undefined, player, otherteam, undefined, undefined );
                        }
                    }
                    
                    break;
            }
            
            if ( isdefined( level.updatefobspawnselection ) )
            {
                [[ level.updatefobspawnselection ]]();
            }
            
            setdevdvar( @"hash_8a31b9a6205ce71b", 0 );
        }
        
        if ( getdvarint( @"hash_cb1fa81ae9d1246a" ) > 0 )
        {
            var_b93b834d7024dd99 = getdvarint( @"hash_cb1fa81ae9d1246a" );
            player = level.players[ 0 ];
            
            if ( isdefined( level.var_c7f22dd7cb861f3 ) )
            {
                [[ level.var_c7f22dd7cb861f3 ]]( var_b93b834d7024dd99 );
            }
            
            setdevdvar( @"hash_cb1fa81ae9d1246a", 0 );
        }
        
        if ( getdvarint( @"hash_eee69dc2a527f44" ) > 0 )
        {
            all_dogs = agent_utility::getactiveagentsoftype( "<dev string:x75e>" );
            
            foreach ( dog in all_dogs )
            {
                dog agent_utility::killdog();
            }
            
            setdevdvar( @"hash_eee69dc2a527f44", 0 );
        }
        
        if ( getdvarint( @"hash_e4121048ccfa7580" ) > 0 )
        {
            active_agents = agent_utility::getactiveagentsoftype( "<dev string:x762>" );
            
            foreach ( agent in active_agents )
            {
                agent_utility::killagent( agent );
            }
            
            setdevdvar( @"hash_e4121048ccfa7580", 0 );
        }
        
        if ( getdvarint( @"hash_2972a0a5a58bfd5d" ) > 0 )
        {
            foreach ( player in level.players )
            {
                if ( isai( player ) )
                {
                    continue;
                }
                
                player_team = player.pers[ "<dev string:x766>" ];
                idx = 0;
                
                if ( game[ "<dev string:x76b>" ] == player_team )
                {
                    idx = 1;
                }
                
                player setclientomnvar( "<dev string:x775>", idx );
            }
            
            setdevdvar( @"hash_2972a0a5a58bfd5d", 0 );
        }
        
        if ( getdvar( @"scr_give_killstreak_points", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            foreach ( player in level.players )
            {
                if ( !isai( player ) )
                {
                    eventstring = getdvar( @"scr_give_killstreak_points" );
                    event = eventstring;
                    
                    if ( !isxhash( eventstring ) )
                    {
                        event = getxhash( eventstring );
                    }
                    
                    killaward = 1;
                    
                    switch ( eventstring )
                    {
                        case #"hash_8a8501d0715daa50":
                            killaward = 5;
                            break;
                        case #"hash_d7772b3b06853264":
                            killaward = 10;
                            break;
                        case #"hash_c129da3afad1afa3":
                            killaward = 15;
                            break;
                        case #"hash_fb5de347cc03cbc6":
                            killaward = 30;
                            break;
                    }
                    
                    eventvalue = rank::getscoreinfovalue( event );
                    player thread rank::scorepointspopup( eventvalue );
                    player killstreaks::givestreakpoints( event, killaward, eventvalue );
                }
            }
            
            setdevdvar( @"scr_give_killstreak_points", "<dev string:x2f4>" );
        }
        
        if ( getdvarint( @"hash_cccba423c010c957" ) != 0 )
        {
            foreach ( player in level.players )
            {
                points = getdvarint( @"hash_cccba423c010c957" );
                player bounty::bountyincreasestreak( points );
            }
            
            setdevdvar( @"hash_cccba423c010c957", 0 );
        }
        
        if ( getdvarint( @"hash_68db6c6a95694120" ) != 0 )
        {
            foreach ( player in level.players )
            {
                player energy_setmax( 1, 1000 );
                player energy_setenergy( 1, 1000 );
                player energy_setrestorerate( 1, 1000 );
                player energy_setresttimems( 1, 0 );
            }
        }
        
        if ( getdvarint( @"hash_ac45d88ed62c32a5", 0 ) != 0 )
        {
            dvar = getdvarint( @"hash_ac45d88ed62c32a5", 0 );
            
            foreach ( player in level.players )
            {
                switch ( dvar )
                {
                    case 1:
                        player setlensprofiledistort( "<dev string:x7a7>" );
                        break;
                    case 2:
                        player setlensprofiledistort( "<dev string:x7b8>" );
                        break;
                    case 3:
                        player setlensprofiledistort( "<dev string:x7c3>" );
                        break;
                    case 4:
                        player setlensprofiledistort( "<dev string:x7d0>" );
                        break;
                    case 5:
                        player setlensprofiledistort( "<dev string:x7dd>" );
                        break;
                    case 6:
                        player setlensprofiledistort( "<dev string:x7e3>" );
                        break;
                    case 7:
                        player setlensprofiledistort( "<dev string:x7ee>" );
                        break;
                    case 8:
                        player setlensprofiledistort( "<dev string:x2ef>" );
                        break;
                }
            }
            
            setdevdvar( @"hash_ac45d88ed62c32a5", 0 );
        }
        
        if ( getdvarint( @"hash_914bb3dc853c47c4", 0 ) != 0 )
        {
            if ( !isdefined( level.var_de9c40af8a4aa243 ) )
            {
                level.var_de9c40af8a4aa243 = [];
            }
            
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                tracestart = host geteye();
                forward = anglestoforward( host getplayerangles() );
                traceend = tracestart + forward * 5000;
                traceresults = trace::ray_trace( tracestart, traceend, host );
                
                if ( isplayer( traceresults[ "<dev string:x205>" ] ) && isbot( traceresults[ "<dev string:x205>" ] ) )
                {
                    level.var_de9c40af8a4aa243[ level.var_de9c40af8a4aa243.size ] = traceresults[ "<dev string:x205>" ];
                    iprintlnbold( "<dev string:x7f3>" + traceresults[ "<dev string:x205>" ].name + "<dev string:x7fd>" );
                }
            }
            
            setdevdvar( @"hash_914bb3dc853c47c4", 0 );
        }
        
        if ( getdvarint( @"hash_b34a0bfcf1e59832", 0 ) != 0 )
        {
            level.var_de9c40af8a4aa243 = undefined;
            iprintlnbold( "<dev string:x80b>" );
            setdevdvar( @"hash_b34a0bfcf1e59832", 0 );
        }
        
        if ( getdvarint( @"hash_3689035427e54e9f", 0 ) != 0 )
        {
            host = devfindhost();
            tracestart = host geteye();
            forward = anglestoforward( host getplayerangles() );
            traceend = tracestart + forward * 5000;
            traceresults = trace::ray_trace( tracestart, traceend, host );
            
            if ( isdefined( level.var_de9c40af8a4aa243 ) )
            {
                foreach ( target in level.var_de9c40af8a4aa243 )
                {
                    target setorigin( traceresults[ "<dev string:x236>" ] );
                }
            }
            
            setdevdvar( @"hash_3689035427e54e9f", 0 );
        }
        
        if ( getdvar( @"hash_c22d5ea67b157acc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                if ( host.var_45f7e72b795b2519 && isbot( host.var_cc908aa2d972bedb ) )
                {
                    targetbot = host.var_cc908aa2d972bedb;
                }
                else
                {
                    targetbot = bots_debug::function_944bfd48ce67278e();
                }
                
                if ( isdefined( targetbot ) )
                {
                    equipment = getdvar( @"hash_c22d5ea67b157acc", "<dev string:x2f4>" );
                    equipweaponname = level.equipment.table[ equipment ].weaponname;
                    
                    if ( isdefined( equipweaponname ) )
                    {
                        equipweapon = makeweapon( equipweaponname );
                        equipref = level.equipment.table[ equipment ].ref;
                        slot = level.equipment.table[ equipment ].defaultslot;
                        attachments = targetbot equipment_mp::function_97483661b0d7f039( equipweapon );
                        
                        if ( attachments.size > 0 )
                        {
                            equipweapon = equipweapon withattachments( attachments );
                        }
                        
                        targetbot equipment_mp::giveequipment( equipref, slot, undefined, undefined, attachments );
                        
                        if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                        {
                            equiptype = level.equipment.table[ equipment ].bundle.equipmenttype;
                            targetbot bots_debug::bot_use_equipment( equiptype, equipref );
                        }
                    }
                }
            }
            
            setdevdvar( @"hash_c22d5ea67b157acc", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_4883b42098a85dec", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                if ( host.var_45f7e72b795b2519 && isbot( host.var_cc908aa2d972bedb ) )
                {
                    targetbot = host.var_cc908aa2d972bedb;
                }
                else
                {
                    targetbot = bots_debug::function_944bfd48ce67278e();
                }
                
                if ( isdefined( targetbot ) )
                {
                    perk = getdvar( @"hash_4883b42098a85dec", "<dev string:x2f4>" );
                    
                    if ( isdefined( perk ) )
                    {
                        targetbot perk::giveperk( perk );
                    }
                }
            }
            
            setdevdvar( @"hash_4883b42098a85dec", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_84d17066d7567258", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                if ( host.var_45f7e72b795b2519 && isbot( host.var_cc908aa2d972bedb ) )
                {
                    targetbot = host.var_cc908aa2d972bedb;
                }
                else
                {
                    targetbot = bots_debug::function_944bfd48ce67278e();
                }
                
                if ( isdefined( targetbot ) )
                {
                    super = getdvar( @"hash_84d17066d7567258", "<dev string:x2f4>" );
                    superweaponname = level.superglobals.staticsuperdata[ super ].weapon;
                    
                    if ( !isdefined( superweaponname ) )
                    {
                        superweaponname = %"super_default_mp";
                    }
                    
                    superweapon = makeweapon( superweaponname );
                    attachments = targetbot supers_mp::function_a5902968fb664288( superweapon );
                    
                    if ( attachments.size > 0 )
                    {
                        superweapon = superweapon withattachments( attachments );
                    }
                    
                    targetbot perkpackage::perkpackage_givedebug( super, undefined, attachments );
                    
                    if ( isdefined( targetbot.super ) && getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        if ( !isnullweapon( superweapon ) && superweapon.basename != %"super_default_mp" )
                        {
                            targetbot weapon_utility::giveandfireoffhandreliable( superweapon );
                        }
                        
                        targetbot thread supers_mp::trysuperusebegin( superweapon );
                    }
                }
                
                setdevdvar( @"hash_84d17066d7567258", "<dev string:x2f4>" );
            }
        }
        
        if ( getdvar( @"hash_ba2c7949a7bef89a", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            host = devfindhost();
            
            if ( isdefined( host ) )
            {
                if ( host.var_45f7e72b795b2519 && isbot( host.var_cc908aa2d972bedb ) )
                {
                    targetbot = host.var_cc908aa2d972bedb;
                }
                else
                {
                    targetbot = bots_debug::function_944bfd48ce67278e();
                }
                
                if ( isdefined( targetbot ) )
                {
                    streakname = getdvar( @"hash_ba2c7949a7bef89a", "<dev string:x2f4>" );
                    streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
                    var_ec73d9361a038a70 = 0;
                    emptime = undefined;
                    
                    if ( streakname == "<dev string:x426>" )
                    {
                        var_ec73d9361a038a70 = 1;
                        emptime = getdvarfloat( @"scr_emp_timeout" );
                        streakname = "<dev string:x430>";
                        setdevdvar( @"scr_emp_timeout", 1 );
                    }
                    
                    if ( isdefined( streaksetupinfo ) && killstreak_utility::getkillstreakindex( streakname ) != -1 )
                    {
                        if ( targetbot.team != "<dev string:x283>" && targetbot.sessionstate != "<dev string:x283>" )
                        {
                            if ( streakname == "<dev string:x434>" )
                            {
                                nuketype = getdvarint( @"scr_nuke_type", 0 );
                                
                                switch ( nuketype )
                                {
                                    case 1:
                                        streakname = "<dev string:x439>";
                                        break;
                                    case 2:
                                        streakname = "<dev string:x44e>";
                                        break;
                                }
                            }
                            
                            targetbot killstreaks::awardkillstreak( streakname, "<dev string:x459>" );
                            
                            if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                            {
                                /#
                                    targetbot bots_debug::bot_use_killstreak();
                                #/
                            }
                        }
                    }
                    else
                    {
                        println( "<dev string:x2df>" + streakname + "<dev string:x499>" );
                        
                        foreach ( killstreak, value in level.killstreaksetups )
                        {
                            if ( killstreak_utility::getkillstreakindex( killstreak ) != -1 )
                            {
                                println( "<dev string:x4cd>" + killstreak );
                            }
                        }
                        
                        println( "<dev string:x2f4>" );
                    }
                    
                    if ( var_ec73d9361a038a70 )
                    {
                        /#
                            level thread function_a48e6713064f914f( 5, @"scr_emp_timeout", emptime );
                        #/
                    }
                }
            }
            
            /#
                setdevdvar( @"hash_ba2c7949a7bef89a", "<dev string:x2f4>" );
            #/
        }
        
        if ( getdvarint( @"hash_f9aebf06391bb03c", 0 ) != 0 )
        {
            switch ( getdvarint( @"hash_f9aebf06391bb03c", 0 ) )
            {
                case 1:
                    level.players[ 0 ] thread hud_message::showsplash( "<dev string:x820>", 42 );
                    break;
                case 2:
                    level.players[ 0 ] thread hud_message::showsplash( "<dev string:x831>", 25 );
                    break;
                case 3:
                    level.players[ 0 ] thread hud_message::showsplash( "<dev string:x83d>", undefined, level.players[ 0 ] );
                    break;
            }
            
            setdvar( @"hash_f9aebf06391bb03c", 0 );
        }
        
        if ( getdvarint( @"hash_f23e88e0327f5ea8", 0 ) == 1 )
        {
            if ( !level.var_bf3963e27160df2c )
            {
                level thread function_a88f3b3329ac35a0();
            }
        }
        
        if ( getdvarint( @"hash_c9ec8ca2b7a146c4", 0 ) > 0 )
        {
            points = getdvarint( @"hash_c9ec8ca2b7a146c4" );
            setdevdvar( @"hash_c9ec8ca2b7a146c4", 0 );
            
            foreach ( player in level.players )
            {
                player thread supers_mp::givesuperpoints( points, undefined, 1 );
            }
        }
        
        if ( getdvarint( @"hash_6711d09c824e3cc9", 0 ) > 0 )
        {
            if ( !level.var_5b4cbeb5ab415cc9 )
            {
                level.var_5b4cbeb5ab415cc9 = 1;
                level thread function_c5b4cae06ed2fea7();
            }
        }
        else if ( level.var_5b4cbeb5ab415cc9 )
        {
            level.var_5b4cbeb5ab415cc9 = undefined;
            level notify( #"hash_ac826e4e879175e6" );
        }
        
        function_bad0385e41a7f1();
        
        if ( getdvarint( @"scr_testshock", 0 ) == 1 )
        {
            shellshocktest( getdvar( @"scr_testshockid", "<dev string:x2f4>" ) );
            setdevdvar( @"scr_testshock", 0 );
        }
        
        if ( getdvarint( @"scr_testshockstop", 0 ) == 1 )
        {
            function_2f28ec2b67f23082();
            setdevdvar( @"scr_testshockstop", 0 );
        }
        
        waitframe();
        var_bc15181d614268bf = 0;
        
        if ( getdvarint( @"hash_6014f2652bf27fbd", 0 ) > 0 )
        {
            var_bc15181d614268bf = 1;
            setdevdvar( @"hash_6014f2652bf27fbd", 0 );
        }
        
        if ( !var_bc15181d614268bf )
        {
            level.dbgmolodrawhits = getdvarint( @"hash_bdb86700db7d369e", 0 ) > 0;
        }
        else
        {
            setdevdvar( @"hash_bdb86700db7d369e", 0 );
            level.dbgmolodrawhits = 0;
        }
        
        if ( !var_bc15181d614268bf )
        {
            level.var_569988d90e2df561 = getdvarint( @"hash_5148ee2a6dbcf8af", 0 ) > 0;
        }
        else
        {
            level.var_569988d90e2df561 = 0;
            setdevdvar( @"hash_5148ee2a6dbcf8af", 0 );
        }
        
        var_2cb8896592295144 = 0;
        
        if ( getdvarint( @"hash_23443a3853ae0bc2", 0 ) > 0 )
        {
            var_2cb8896592295144 = 1;
            setdevdvar( @"hash_23443a3853ae0bc2", 0 );
        }
        
        if ( !var_2cb8896592295144 )
        {
            level.var_b722f84d36dca941 = getdvarint( @"hash_2da10a7c8fe0958f", 0 ) > 0;
        }
        else
        {
            setdevdvar( @"hash_2da10a7c8fe0958f", 0 );
            level.var_b722f84d36dca941 = 0;
        }
        
        if ( !var_2cb8896592295144 )
        {
            level.var_b33c98c6278fc4d8 = getdvarint( @"hash_969b8a29c66b70e6", 0 ) > 0;
        }
        else
        {
            level.var_b33c98c6278fc4d8 = 0;
            setdevdvar( @"hash_969b8a29c66b70e6", 0 );
        }
        
        level.vehiclefriendlydamage = getdvarint( @"scr_vehiclefriendlydamage", 0 ) > 0;
        
        if ( isdefined( level.vehicle ) && isdefined( level.vehicle.spawn ) )
        {
            level.vehicle.spawn.abandonedtimeoutoverride = getdvarint( @"hash_e547fe8dfe1679f6", 0 );
        }
        
        vehicleref = getdvar( @"hash_29ad65e1f5a10c7d", "<dev string:x2f4>" );
        
        if ( vehicleref != "<dev string:x2f4>" )
        {
            player = level.players[ 0 ];
            
            if ( isdefined( player ) )
            {
                forward = anglestoforward( player getplayerangles() ) * ( 1, 1, 0 );
                data = vehicle::get_data( vehicleref );
                
                if ( data.mtx.size > 0 )
                {
                    dist = data.spawn.clearancecheckradius * 2 * 1.1;
                    
                    for ( i = 0; i < data.mtx.size ; i++ )
                    {
                        spawndata = spawnstruct();
                        spawndata.origin = player.origin + ( 0, 0, 100 ) + forward * dist * i;
                        spawndata.angles = player.angles * ( 0, 1, 0 );
                        spawndata.spawntype = "<dev string:x846>";
                        spawndata.var_4ae4f42e05dc7b41 = data.mtx[ i ].ref;
                        
                        if ( vehicle_airdrop::can_airdrop( vehicleref ) )
                        {
                            level.var_53ee440e883f18de = level vehicle_airdrop::vehicle_airdrop( vehicleref, spawndata );
                            continue;
                        }
                        
                        level.var_53ee440e883f18de = player vehicle::function_48833bc196a87e8c( vehicleref, spawndata );
                    }
                }
            }
            
            setdevdvar( @"hash_29ad65e1f5a10c7d", "<dev string:x2f4>" );
        }
        
        var_e8e58927672f220f = getdvar( @"hash_cf9748ad04470846", "<dev string:x2f4>" );
        
        if ( var_e8e58927672f220f != "<dev string:x2f4>" )
        {
            leveldata = vehicle_occupancy::get_level_data();
            
            foreach ( instance in leveldata.debuginstances )
            {
                if ( isdefined( instance vehicle::get_ref() ) && instance vehicle::get_ref() == "<dev string:x84d>" )
                {
                    instance notify( #"debug_give_upgrade", var_e8e58927672f220f );
                }
            }
            
            setdevdvar( @"hash_cf9748ad04470846", "<dev string:x2f4>" );
        }
        
        vehicleref = getdvar( @"hash_37b6962333b896f9", "<dev string:x2f4>" );
        
        if ( vehicleref != "<dev string:x2f4>" )
        {
            player = gamelogic_mp::gethostplayer();
            
            if ( isdefined( player ) )
            {
                thread vehicle::destroy_vehicles( vehicleref );
            }
            
            setdevdvar( @"hash_37b6962333b896f9", "<dev string:x2f4>" );
        }
        
        var_aa35bee5b2df66f4 = getdvar( @"hash_c6bdc7ccd09be1d9", "<dev string:x2f4>" );
        
        if ( var_aa35bee5b2df66f4 != "<dev string:x2f4>" )
        {
            function_955bf5ac1af8d697( var_aa35bee5b2df66f4 );
            setdevdvar( @"hash_c6bdc7ccd09be1d9", "<dev string:x2f4>" );
        }
        
        var_d70af4fce16b92f = getdvar( @"hash_2d1de779228d9247", "<dev string:x2f4>" );
        
        if ( var_d70af4fce16b92f != "<dev string:x2f4>" )
        {
            function_4ad50366843701ec( var_d70af4fce16b92f );
            setdevdvar( @"hash_2d1de779228d9247", "<dev string:x2f4>" );
        }
        
        if ( getdvarint( @"scr_testspawnpackage", 0 ) > 0 )
        {
            function_df7ad832ea350717();
            setdevdvar( @"scr_testspawnpackage", 0 );
        }
        
        if ( getdvarint( @"hash_bcb21c0721a9e458", 0 ) > 0 )
        {
            function_fdf51f95188af377();
            setdevdvar( @"hash_bcb21c0721a9e458", 0 );
        }
        
        if ( getdvar( @"scr_give_equipment", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            attachment = getdvar( @"hash_b3a8ae3efd5ba6b4", "<dev string:x2f4>" );
            
            if ( attachment != "<dev string:x2f4>" )
            {
                attachments = [ attachment ];
                setdevdvar( @"hash_b3a8ae3efd5ba6b4", "<dev string:x2f4>" );
            }
            else
            {
                attachments = [];
            }
            
            equipmentref = getdvar( @"scr_give_equipment", "<dev string:x2f4>" );
            var_c7927ce1577966e = getdvar( @"hash_8eb0b5d2fe30e7ae", "<dev string:x2f4>" );
            slot = equipment_mp::getdefaultslot( equipmentref );
            
            if ( isdefined( slot ) )
            {
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && attachment != "<dev string:x2f4>" )
                    {
                        player.var_f5392f9fde9169f3 = attachments;
                    }
                    
                    if ( isdefined( var_c7927ce1577966e ) )
                    {
                        if ( !isdefined( player.pers[ #"hash_ddf4800634d16ffd" ] ) )
                        {
                            player.pers[ #"hash_ddf4800634d16ffd" ] = [];
                        }
                        
                        if ( var_c7927ce1577966e != "<dev string:x2f4>" )
                        {
                            player.pers[ #"hash_ddf4800634d16ffd" ][ equipmentref ] = getxhashasset( var_c7927ce1577966e );
                            equipmentref = var_c7927ce1577966e;
                        }
                        else
                        {
                            player.pers[ #"hash_ddf4800634d16ffd" ] = undefined;
                        }
                    }
                    
                    player equipment_mp::giveequipment( equipmentref, slot, undefined, undefined, attachments );
                }
            }
            
            setdevdvar( @"scr_give_equipment", "<dev string:x2f4>" );
            setdevdvar( @"hash_8eb0b5d2fe30e7ae", "<dev string:x2f4>" );
        }
        
        if ( getdvarint( @"scr_equip_infinite_ammo", 0 ) != 0 )
        {
            foreach ( player in level.players )
            {
                player equipment_mp::incrementequipmentslotammo( "<dev string:x85c>", 9999 );
                player equipment_mp::incrementequipmentslotammo( "<dev string:x864>", 9999 );
                
                if ( level.tertiaryweaponslotenabled )
                {
                    player equipment_mp::incrementequipmentslotammo( "<dev string:x86e>", 9999 );
                }
            }
        }
        
        if ( getdvarint( @"scr_ammoregen", 0 ) != 0 )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player.devammoregen ) )
                {
                    player thread function_2727e04dff0cb74f();
                }
            }
        }
        
        if ( getdvarint( @"hash_712ae72ab5d6c715", 0 ) != 0 )
        {
            function_26f4d82c4225e478( getdvar( @"hash_712ae72ab5d6c715" ) );
            setdevdvar( @"hash_712ae72ab5d6c715", "<dev string:xa3>" );
        }
        
        if ( getdvarint( @"scr_debug_outline_players", 0 ) != 0 )
        {
            level thread function_91e14e60c07b43d5( getdvarint( @"scr_debug_outline_players", 0 ) );
            setdevdvar( @"scr_debug_outline_players", 0 );
        }
        
        if ( getdvarint( @"hash_f8fb42a86c465992", 0 ) != 0 )
        {
            function_ea5be41c599a0fad();
            setdevdvar( @"hash_f8fb42a86c465992", "<dev string:xa3>" );
        }
        
        if ( getdvarint( @"hash_d7d910e4c5366baf", 0 ) != 0 )
        {
            function_99643cc5f3aeb396();
            setdevdvar( @"hash_d7d910e4c5366baf", "<dev string:xa3>" );
        }
        
        if ( getdvarint( @"hash_cd736679460603b2", -1 ) != -1 )
        {
            setactiveplayer( getdvarint( @"hash_cd736679460603b2" ) );
            setdevdvar( @"hash_cd736679460603b2", -1 );
        }
        
        if ( getdvarint( @"hash_b266c7674623f57f", 0 ) != 0 )
        {
            function_aa73f07b79ef74b2();
            setdevdvar( @"hash_b266c7674623f57f", 0 );
        }
        
        if ( getdvarint( @"hash_d0560daa501833d7", 0 ) != 0 )
        {
            function_15072f897643b2ac();
            setdevdvar( @"hash_d0560daa501833d7", 0 );
        }
        
        if ( getdvarint( @"hash_1e71d7bfcd76b9f0", 0 ) != 0 )
        {
            function_727a21e438b03952( getdvarint( @"hash_1e71d7bfcd76b9f0" ) );
            setdevdvar( @"hash_1e71d7bfcd76b9f0", 0 );
        }
        
        if ( getdvarint( @"hash_75dc853de5aa02e4", 0 ) != 0 )
        {
            function_30b9e4041b6b6d11( getdvarint( @"hash_75dc853de5aa02e4" ) );
            setdevdvar( @"hash_75dc853de5aa02e4", 0 );
        }
        
        if ( getdvarint( @"scr_clearkillstreaks", 0 ) != 0 )
        {
            devclearkillstreaks();
            setdevdvar( @"scr_clearkillstreaks", 0 );
        }
        
        if ( getdvarint( @"hash_c3cafdefe09c5c07", 0 ) != 0 )
        {
            function_68d89078ec1e0abe();
            setdevdvar( @"hash_c3cafdefe09c5c07", 0 );
        }
        
        if ( getdvarint( @"hash_892a0f1030eb66da", 0 ) != 0 )
        {
            headless_killall();
            setdevdvar( @"hash_892a0f1030eb66da", 0 );
        }
        
        if ( getdvarint( @"hash_99f113c180dfe22d", 0 ) != 0 )
        {
            headless_killall();
            setdevdvar( @"hash_99f113c180dfe22d", 0 );
        }
        
        if ( getdvarint( @"hash_60951c4ee00ec45c", 0 ) != 0 )
        {
            function_205cd8869510d883();
            setdevdvar( @"hash_60951c4ee00ec45c", 0 );
        }
        
        if ( getdvarint( @"hash_8e93a66436d8d0bb", 0 ) != 0 )
        {
            function_205cd8869510d883();
            setdevdvar( @"hash_8e93a66436d8d0bb", 0 );
        }
        
        if ( getdvarint( @"hash_39dc8a1ad3dd146a", 0 ) != 0 )
        {
            function_2b606bc0f7063838( 1 );
            setdevdvar( @"hash_39dc8a1ad3dd146a", 0 );
        }
        
        if ( getdvarint( @"hash_a3a51abfffffb4cf", 0 ) != 0 )
        {
            function_2b606bc0f7063838( 0 );
            setdevdvar( @"hash_a3a51abfffffb4cf", 0 );
        }
        
        if ( getdvarint( @"hash_d2f9b7c5947f75b3", 0 ) != 0 )
        {
            function_2fa2bd0de3d64101( 1 );
            setdevdvar( @"hash_d2f9b7c5947f75b3", 0 );
        }
        
        if ( getdvarint( @"hash_629b4e289546a19e", 0 ) != 0 )
        {
            function_2fa2bd0de3d64101( 0 );
            setdevdvar( @"hash_629b4e289546a19e", 0 );
        }
        
        waitframe();
        
        if ( getdvarint( @"hash_6ab9781b392f5eab" ) != 0 )
        {
            if ( !isdefined( level.var_be148147e88112be ) )
            {
                level.var_be148147e88112be = 0;
            }
            
            player = level.players[ 0 ];
            
            if ( !level.var_be148147e88112be )
            {
                iprintln( "<dev string:x877>" );
                iprintln( "<dev string:x89a>" );
                level.var_be148147e88112be = 1;
                player thread function_7495dbd79e2c3aa6();
            }
            else
            {
                level notify( #"hash_47f3d9a9e91670d1" );
                level.var_be148147e88112be = 0;
                player setactionslot( 3, "<dev string:x8ba>" );
            }
            
            setdevdvar( @"hash_6ab9781b392f5eab", 0 );
        }
        
        if ( getdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            layoutname = getdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" );
            function_f79b267a365c94da( layoutname );
            setdevdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" );
        }
        
        areaswaphint = getdvar( @"hash_2f5ae859f49a8160", "<dev string:x2f4>" );
        
        if ( areaswaphint != "<dev string:x2f4>" )
        {
            hinttokens = strtok( areaswaphint, "<dev string:x356>" );
            
            if ( hinttokens.size == 2 )
            {
                var_88edf5a7cfdb5737 = int( hinttokens[ 0 ] );
                var_c9cc65ad65ba4be6 = int( hinttokens[ 1 ] );
                function_f5bed501d0539e38( var_88edf5a7cfdb5737, var_c9cc65ad65ba4be6 );
            }
            
            setdevdvar( @"hash_2f5ae859f49a8160", "<dev string:x2f4>" );
        }
        
        areaswap = getdvar( @"scr_areaswap", "<dev string:x2f4>" );
        
        if ( areaswap != "<dev string:x2f4>" )
        {
            swaptokens = strtok( areaswap, "<dev string:x356>" );
            
            if ( swaptokens.size == 2 )
            {
                var_50f31f64147bc399 = int( swaptokens[ 0 ] );
                var_89ee856525a6a510 = int( swaptokens[ 1 ] );
                function_7902b2b159053f24( var_50f31f64147bc399, var_89ee856525a6a510 );
            }
            
            setdevdvar( @"scr_areaswap", "<dev string:x2f4>" );
        }
        
        if ( getdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
        {
            layoutname = getdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" );
            function_f79b267a365c94da( layoutname );
            setdevdvar( @"hash_265eb98091c83ef1", "<dev string:x2f4>" );
        }
        
        function_c85a57f70a979c98();
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xde3f1efe, Offset: 0x8be9
    // Size: 0x1a4, Type: dev
    function function_f79b267a365c94da( layout_name )
    {
        bundle = getscriptbundle( layout_name );
        
        if ( !isdefined( bundle ) )
        {
            return;
        }
        
        foreach ( mod_point in bundle.mod_points )
        {
            if ( !( isdefined( mod_point ) && isdefined( mod_point.mod_point_name ) && isdefined( level.mod_points[ mod_point.mod_point_name ] ) && isdefined( level.mod_points[ mod_point.mod_point_name ].modsets ) ) )
            {
                continue;
            }
            
            foreach ( mod_set_name, mod_set in level.mod_points[ mod_point.mod_point_name ].modsets )
            {
                if ( isdefined( mod_set ) )
                {
                    function_f1fddb69e8ca5be8( mod_set.ents, getxhash( mod_set_name ) == ( mod_point.mod_set_active ?? "<dev string:x2f4>" ) );
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xaf8dad18, Offset: 0x8d95
    // Size: 0x144, Type: dev
    function function_f1fddb69e8ca5be8( modset, visible )
    {
        foreach ( ent in modset )
        {
            if ( ent isscriptable() )
            {
                ent setscriptablepartstate( "<dev string:x8c2>", visible ? "<dev string:x8cd>" : "<dev string:x8d2>", 1 );
                continue;
            }
            
            if ( isdefined( ent.name ) )
            {
                if ( !isdefined( level.lightintensity ) )
                {
                    level.lightintensity = [];
                }
                
                if ( !isdefined( level.lightintensity[ ent.name ] ) )
                {
                    level.lightintensity[ ent.name ] = ent getlightintensity();
                }
                
                ent setlightintensity( visible ? level.lightintensity[ ent.name ] : 0 );
                continue;
            }
            
            if ( visible )
            {
                ent show();
                continue;
            }
            
            ent hide();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x785b425a, Offset: 0x8ee1
    // Size: 0x62, Type: dev
    function function_26f4d82c4225e478( camtype )
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player.var_953a0e415aee7e97 ) )
        {
            player.var_953a0e415aee7e97 = 0;
        }
        
        if ( camtype == "<dev string:x8d7>" )
        {
            player function_e2556ad313902a04();
            return;
        }
        
        player replaycam( camtype );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2a800dc8, Offset: 0x8f4b
    // Size: 0xc0, Type: dev
    function function_e2556ad313902a04()
    {
        if ( self.var_953a0e415aee7e97 )
        {
            takegoproattachments();
            self.var_953a0e415aee7e97 = 0;
        }
        
        if ( isdefined( self.replaycam ) )
        {
            self cameraunlink();
            self unlink();
            self.replaycam delete();
        }
        
        self setclientdvar( @"cg_fov", 65 );
        setdvar( @"r_mbradialoverridedistortion", 0 );
        setdvar( @"r_mbradialoverrideradius", 0 );
        setdvar( @"r_mbradialoverridestrength", 0 );
        setdvar( @"r_mbradialoverridechromaticaberration", 0 );
        
        if ( isdefined( self.goprooverlay ) )
        {
            self.goprooverlay destroy();
        }
        
        visionsetfadetoblack( "<dev string:x2f4>", 0 );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x11253b86, Offset: 0x9013
    // Size: 0x31b, Type: dev
    function replaycam( camtype )
    {
        if ( !self.var_953a0e415aee7e97 )
        {
            givegoproattachments();
            self.var_953a0e415aee7e97 = 1;
        }
        
        camdata = function_76c16d0a2b78f549( camtype );
        
        if ( isdefined( camdata.dist ) )
        {
            vecaway = vectornormalize( ( camdata.up, camdata.forward, camdata.right ) ) * camdata.dist;
        }
        else
        {
            vecaway = ( camdata.up, camdata.forward, camdata.right );
        }
        
        self setclientdvar( @"cg_fov", camdata.fov );
        setdvar( @"r_mbradialoverridedistortion", 0.203 );
        setdvar( @"r_mbradialoverrideradius", -0.478 );
        setdvar( @"r_mbradialoverridestrength", 0.011 );
        setdvar( @"r_mbradialoverridechromaticaberration", 0.7 );
        
        if ( !isdefined( self.goprooverlay ) )
        {
            self.goprooverlay = newclienthudelem( self );
            self.goprooverlay.sort = 0;
            self.goprooverlay.foreground = 0;
            self.goprooverlay.horzalign = "<dev string:x8db>";
            self.goprooverlay.vertalign = "<dev string:x8db>";
            self.goprooverlay.alpha = 1;
            self.goprooverlay.enablehudlighting = 1;
            self.goprooverlay setshader( "<dev string:x8e6>", 640, 480 );
        }
        
        visionsetfadetoblack( "<dev string:x8fe>", 0 );
        
        if ( isdefined( self.replaycam ) )
        {
            self cameraunlink();
            self unlink();
            self.replaycam delete();
        }
        
        camera = spawn( "<dev string:x229>", self.origin + ( 0, 0, 300 ) );
        camera setmodel( "<dev string:x904>" );
        cameralink = spawn( "<dev string:x229>", self.origin + ( 0, 0, 300 ) );
        cameralink setmodel( "<dev string:x904>" );
        camera linkto( cameralink, "<dev string:x904>", ( 0, 0, 0 ), ( camdata.basepitch, camdata.baseyaw, camdata.baseroll ) );
        cameralink linkto( self, camdata.linktag, ( vecaway[ 0 ], vecaway[ 1 ] * -1, vecaway[ 2 ] ), ( camdata.roll, camdata.pitch * -1, camdata.yaw * -1 ) );
        self cameralinkto( camera, "<dev string:x904>", 1, 1 );
        self.replaycam = camera;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x2d7b271a, Offset: 0x9336
    // Size: 0x30c, Type: dev
    function function_76c16d0a2b78f549( camtype )
    {
        data = spawnstruct();
        
        switch ( camtype )
        {
            case #"hash_e7559840425a2b2b":
                data.linktag = "<dev string:x917>";
                data.basepitch = 0;
                data.baseyaw = 90;
                data.baseroll = 90;
                data.pitch = -30;
                data.yaw = -34;
                data.roll = 0;
                data.forward = 11;
                data.right = -4;
                data.up = 5;
                data.fov = 110;
                data.dist = 11;
                break;
            case #"hash_6b67a88e46e6afce":
                data.linktag = "<dev string:x92d>";
                data.basepitch = 0;
                data.baseyaw = 180;
                data.baseroll = 0;
                data.pitch = 15;
                data.yaw = 0;
                data.roll = -5;
                data.forward = 2;
                data.right = 1.5;
                data.up = 10;
                data.fov = 110;
                break;
            case #"hash_a17be67179043323":
                data.linktag = "<dev string:x92d>";
                data.basepitch = 0;
                data.baseyaw = 180;
                data.baseroll = 0;
                data.pitch = 0;
                data.yaw = 0;
                data.roll = 2;
                data.forward = -2;
                data.right = 0.7;
                data.up = 10.5;
                data.fov = 65;
                break;
            case #"hash_358b20ba43041f71":
                data.linktag = "<dev string:x92d>";
                data.basepitch = 0;
                data.baseyaw = 0;
                data.baseroll = 0;
                data.pitch = 0;
                data.yaw = 0;
                data.roll = 0;
                data.forward = 2.5;
                data.right = 1.5;
                data.up = -10;
                data.fov = 110;
                break;
            default:
                assertmsg( "<dev string:x95c>" + camtype + "<dev string:x969>" );
                break;
        }
        
        return data;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7cfbdb16, Offset: 0x964a
    // Size: 0x115, Type: dev
    function givegoproattachments()
    {
        if ( isdefined( self.goprohasattachments ) )
        {
            return;
        }
        
        currentweapon = self.currentweapon;
        weapons = self.primaryinventory;
        
        foreach ( weapon in weapons )
        {
            if ( !function_51358a5ba4f4ab62( weapon ) )
            {
                continue;
            }
            
            attachments = weapon.attachments;
            attachments[ attachments.size ] = "<dev string:x979>";
            attachments = utility::alphabetize( attachments );
            newweapon = makeweapon( getweaponbasename( weapon ), attachments );
            self takeweapon( weapon );
            self giveweapon( newweapon );
        }
        
        switchtoweaponwithbasename( currentweapon );
        self.goprohasattachments = 1;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x576d9adc, Offset: 0x9767
    // Size: 0x117, Type: dev
    function takegoproattachments()
    {
        if ( !isdefined( self.goprohasattachments ) )
        {
            return;
        }
        
        currentweapon = self.currentweapon;
        weapons = self.primaryinventory;
        
        foreach ( weapon in weapons )
        {
            if ( !function_51358a5ba4f4ab62( weapon ) )
            {
                continue;
            }
            
            attachments = weapon.attachments;
            attachments = arrayremove( attachments, "<dev string:x979>" );
            attachments = utility::alphabetize( attachments );
            newweapon = makeweapon( getweaponbasename( weapon ), attachments );
            self takeweapon( weapon );
            self giveweapon( newweapon );
        }
        
        switchtoweaponwithbasename( currentweapon );
        self.goprohasattachments = undefined;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xe30e62c8, Offset: 0x9886
    // Size: 0x45, Type: dev
    function function_51358a5ba4f4ab62( weapon )
    {
        basename = getweaponbasename( weapon );
        
        if ( issubstr( basename, "<dev string:x986>" ) )
        {
            return 1;
        }
        
        if ( issubstr( basename, "<dev string:x98f>" ) )
        {
            return 1;
        }
        
        return 0;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xcdee773a, Offset: 0x98d3
    // Size: 0xa6, Type: dev
    function switchtoweaponwithbasename( weapontocheck )
    {
        weapons = self.primaryinventory;
        
        foreach ( weapon in weapons )
        {
            if ( getweaponbasename( weapon ) == getweaponbasename( weapontocheck ) )
            {
                self switchtoweaponimmediate( weapon );
                break;
            }
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x5cb8ad6f, Offset: 0x9981
    // Size: 0xd7, Type: dev
    function function_91e14e60c07b43d5( type )
    {
        asset = type == 1 ? "<dev string:x998>" : "<dev string:x9b2>";
        repeat = type != 1;
        timeon = 1.25;
        timeoff = 2;
        
        foreach ( player in level.players )
        {
            level thread function_b3166b16b2d4ebb6( player, asset, repeat, timeon, timeoff );
        }
    }

    // Namespace dev_mp
    // Params 5
    // Checksum 0x285c3ded, Offset: 0x9a60
    // Size: 0xa7, Type: dev
    function function_b3166b16b2d4ebb6( player, asset, repeat, timeon, timeoff )
    {
        player endon( #"disconnect" );
        idbody = undefined;
        
        while ( true )
        {
            if ( isalive( player ) )
            {
                idbody = outline::outlineenableforall( player, asset, "<dev string:x9c2>" );
                player outline::_hudoutlineviewmodelenable( asset, 0 );
                
                if ( !repeat )
                {
                    break;
                }
                
                player utility::waittill_any_timeout( timeon, "<dev string:x9d6>" );
                outline::outlinedisable( idbody, player );
                player outline::_hudoutlineviewmodeldisable();
            }
            
            wait timeoff;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x860de212, Offset: 0x9b0f
    // Size: 0x123, Type: dev
    function function_ea5be41c599a0fad()
    {
        if ( level.var_a5605e6384b87128 )
        {
            level.var_a5605e6384b87128 = undefined;
            
            foreach ( player in level.players )
            {
                player disablephysicaldepthoffieldscripting();
                player notify( #"hash_589acbaf5cbc5356" );
            }
            
            return;
        }
        
        level.var_a5605e6384b87128 = 1;
        
        foreach ( player in level.players )
        {
            player enablephysicaldepthoffieldscripting();
            player thread function_3e5245cfa026b9a8();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8ae5a29d, Offset: 0x9c3a
    // Size: 0x109, Type: dev
    function function_3e5245cfa026b9a8()
    {
        level endon( #"game_ended" );
        self notify( #"hash_589acbaf5cbc5356" );
        self endon( #"hash_589acbaf5cbc5356" );
        self notifyonplayercommand( "<dev string:x9dc>", "<dev string:x9ea>" );
        self notifyonplayercommand( "<dev string:x9f8>", "<dev string:xa08>" );
        self notifyonplayercommand( "<dev string:xa16>", "<dev string:xa26>" );
        self notifyonplayercommand( "<dev string:xa2d>", "<dev string:xa3e>" );
        level.var_74d3b834e092b12d = 4;
        level.var_946a7afe0e2b70aa = 300;
        level.var_76892aeff9a8c6bc = [ 22, 16, 11, 8, 5.6, 4, 3.5, 2.8, 2.4, 2, 1.8, 1.6, 1.4 ];
        childthread function_c783dfc435c2dc35();
        childthread function_54c7d7d83b24c7d4();
        childthread function_32b685cb2015d55a();
        childthread function_501b91f56408f39();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe7278b1a, Offset: 0x9d4b
    // Size: 0x89, Type: dev
    function function_c783dfc435c2dc35()
    {
        while ( true )
        {
            self waittill( #"hash_ac0cf4650971cb94" );
            level.var_946a7afe0e2b70aa += 12;
            self iprintln( "<dev string:xa44>" + level.var_946a7afe0e2b70aa );
            self setphysicalviewmodeldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            self setphysicaldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8a4e74c1, Offset: 0x9ddc
    // Size: 0x89, Type: dev
    function function_54c7d7d83b24c7d4()
    {
        while ( true )
        {
            self waittill( #"hash_69f25e005c8d1701" );
            level.var_946a7afe0e2b70aa -= 12;
            self iprintln( "<dev string:xa65>" + level.var_946a7afe0e2b70aa );
            self setphysicalviewmodeldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            self setphysicaldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xba881468, Offset: 0x9e6d
    // Size: 0xaf, Type: dev
    function function_32b685cb2015d55a()
    {
        while ( true )
        {
            self waittill( #"hash_e39a94e7b85f7849" );
            level.var_74d3b834e092b12d++;
            level.var_74d3b834e092b12d = int( min( level.var_74d3b834e092b12d, level.var_76892aeff9a8c6bc.size - 1 ) );
            self iprintln( "<dev string:xa86>" + level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ] );
            self setphysicalviewmodeldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            self setphysicaldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa25b79bb, Offset: 0x9f24
    // Size: 0xa3, Type: dev
    function function_501b91f56408f39()
    {
        while ( true )
        {
            self waittill( #"hash_95a54c4204f79f9c" );
            level.var_74d3b834e092b12d--;
            level.var_74d3b834e092b12d = int( max( level.var_74d3b834e092b12d, 0 ) );
            self iprintln( "<dev string:xaa1>" + level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ] );
            self setphysicalviewmodeldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            self setphysicaldepthoffield( level.var_76892aeff9a8c6bc[ level.var_74d3b834e092b12d ], level.var_946a7afe0e2b70aa );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x602e0552, Offset: 0x9fcf
    // Size: 0x130, Type: dev
    function function_99643cc5f3aeb396()
    {
        if ( level.var_72853036e1b5f6d5 )
        {
            level.var_72853036e1b5f6d5 = undefined;
            
            foreach ( player in level.players )
            {
                player iprintlnbold( "<dev string:xabc>" );
                player notify( #"hash_2d9bba696301fbfb" );
                player game_utility::_visionsetnakedforplayer( "<dev string:x2f4>", 0 );
            }
            
            return;
        }
        
        level.var_72853036e1b5f6d5 = 1;
        
        foreach ( player in level.players )
        {
            player thread function_d02fb967107dc8e1();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x105e1e3d, Offset: 0xa107
    // Size: 0xd0, Type: dev
    function function_d02fb967107dc8e1()
    {
        level endon( #"game_ended" );
        self notify( #"hash_2d9bba696301fbfb" );
        self endon( #"hash_2d9bba696301fbfb" );
        
        while ( true )
        {
            self iprintlnbold( "<dev string:xad5>" );
            game_utility::_visionsetnakedforplayer( "<dev string:xaf6>", 0 );
            wait 3;
            self iprintlnbold( "<dev string:xaff>" );
            game_utility::_visionsetnakedforplayer( "<dev string:xb19>", 0 );
            wait 3;
            self iprintlnbold( "<dev string:xb32>" );
            game_utility::_visionsetnakedforplayer( "<dev string:xb4e>", 0 );
            wait 3;
            self iprintlnbold( "<dev string:xb60>" );
            thread game_utility::_visionunsetnakedforplayer( "<dev string:xb19>" );
            wait 3;
            self iprintlnbold( "<dev string:xb7a>" );
            thread game_utility::_visionunsetnakedforplayer( "<dev string:xb4e>" );
            wait 3;
            self iprintlnbold( "<dev string:xb96>" );
            thread game_utility::_visionunsetnakedforplayer( "<dev string:xaf6>" );
            wait 3;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc243a3a9, Offset: 0xa1df
    // Size: 0xb0, Type: dev
    function function_4d6a6347bc4cb039()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            while ( true )
            {
                if ( getdvarint( @"hash_2a7bafdc840d1f2e", 0 ) == 1 )
                {
                    break;
                }
                
                waitframe();
            }
            
            host = devfindhost();
            
            while ( true )
            {
                if ( isdefined( host ) )
                {
                    host.radarmode = "<dev string:xbb7>";
                    host.radarshowenemydirection = 1;
                    host.hasradar = 1;
                    triggeroneoffradarsweep( host );
                }
                else
                {
                    break;
                }
                
                if ( getdvarint( @"hash_2a7bafdc840d1f2e", 0 ) == 0 )
                {
                    break;
                }
                
                wait 0.2;
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9b1ed31b, Offset: 0xa297
    // Size: 0x168, Type: dev
    function function_99b2a56e1e353960()
    {
        level waittill( #"player_spawned" );
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        host notifyonplayercommand( "<dev string:xbc2>", "<dev string:xbd8>" );
        host notifyonplayercommand( "<dev string:xbc2>", "<dev string:xbe5>" );
        host notifyonplayercommand( "<dev string:xbc2>", "<dev string:xbfc>" );
        
        for ( selectedentity = undefined; true ; selectedentity = undefined )
        {
            host waittill( #"hash_438b5cc0a6f9372c" );
            var_416c4a513915bb07 = getdvarint( @"hash_a4e3922cf017e056", 0 );
            
            if ( var_416c4a513915bb07 != 0 )
            {
                if ( host playerads() > 0.5 )
                {
                    continue;
                }
                
                tracestart = host geteye();
                forward = anglestoforward( host getplayerangles() );
                traceend = tracestart + forward * 5000;
                traceresults = trace::ray_trace( tracestart, traceend, host );
                
                if ( isplayer( traceresults[ "<dev string:x205>" ] ) )
                {
                    selectedentity = traceresults[ "<dev string:x205>" ];
                    iprintlnbold( "<dev string:x7f3>" + selectedentity.name + "<dev string:x7fd>" );
                }
                else if ( isdefined( selectedentity ) )
                {
                    pos = traceresults[ "<dev string:x236>" ];
                    
                    if ( var_416c4a513915bb07 == 2 )
                    {
                        pos = getclosestpointonnavmesh( pos );
                    }
                    
                    selectedentity setorigin( pos );
                }
                
                continue;
            }
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x10143884, Offset: 0xa407
    // Size: 0x43, Type: dev
    function unlocksplash( increments, delay )
    {
        for ( i = 0; i < increments ; i++ )
        {
            thread hud_message::showsplash( "<dev string:xc0d>", undefined, self );
            wait delay;
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xafc539be, Offset: 0xa452
    // Size: 0x43, Type: dev
    function killstreaksplash( increments, delay )
    {
        for ( i = 0; i < increments ; i++ )
        {
            thread hud_message::showsplash( "<dev string:xc1b>", undefined, self );
            wait delay;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x69c17e2c, Offset: 0xa49d
    // Size: 0x1e, Type: dev
    function notifyaftertime()
    {
        wait 0.35;
        self notify( #"luinotifyserver", "<dev string:xc25>", 2 );
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xf565143a, Offset: 0xa4c3
    // Size: 0x3c, Type: dev
    function ranksplash( increments, delay )
    {
        for ( i = 0; i < increments ; i++ )
        {
            thread rank::updaterankannouncehud();
            wait delay;
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xb9b1a40c, Offset: 0xa507
    // Size: 0x35, Type: dev
    function weaponranksplash( increments, delay )
    {
        for ( i = 0; i < increments ; i++ )
        {
            wait delay;
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xe631f383, Offset: 0xa544
    // Size: 0xa0, Type: dev
    function testendgameupdate( promotion )
    {
        self setclientdvars( @"ui_challenge_1_ref", "<dev string:xc31>", @"ui_challenge_2_ref", "<dev string:xc3e>", @"ui_challenge_3_ref", "<dev string:xc51>", @"ui_challenge_4_ref", "<dev string:xc65>", @"ui_challenge_5_ref", "<dev string:xc6c>", @"ui_challenge_6_ref", "<dev string:xc7f>", @"ui_challenge_7_ref", "<dev string:xc8e>" );
        
        if ( promotion )
        {
            self setclientdvar( @"ui_promotion", 1 );
            return;
        }
        
        self setclientdvar( @"ui_promotion", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x81189b96, Offset: 0xa5ec
    // Size: 0x24, Type: dev
    function function_b83aba9d15e9b942()
    {
        level endon( #"host_migration_begin" );
        wait randomfloat( 20 );
        level notify( #"hostmigration_enoughplayers" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x61ed948e, Offset: 0xa618
    // Size: 0x57, Type: dev
    function testlowermessage()
    {
        lower_message::setlowermessageomnvar( level.var_791076e7de107dc2, int( gettime() + 10000 ) );
        wait 3;
        lower_message::setlowermessageomnvar( "<dev string:xc9e>" );
        wait 3;
        lower_message::setlowermessageomnvar( "<dev string:xcab>" );
        wait 10;
        lower_message::setlowermessageomnvar( "<dev string:xcab>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9568297, Offset: 0xa677
    // Size: 0x51, Type: dev
    function giveextraperks()
    {
        if ( !isdefined( self.extraperks ) )
        {
            return;
        }
        
        perks = getarraykeys( self.extraperks );
        
        for ( i = 0; i < perks.size ; i++ )
        {
            perk::giveperk( perks[ i ] );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x2597f954, Offset: 0xa6d0
    // Size: 0xfc, Type: dev
    function xkillsy( attackername, victimname )
    {
        attacker = undefined;
        victim = undefined;
        
        for ( index = 0; index < level.players.size ; index++ )
        {
            if ( level.players[ index ].name == attackername )
            {
                attacker = level.players[ index ];
                continue;
            }
            
            if ( level.players[ index ].name == victimname )
            {
                victim = level.players[ index ];
            }
        }
        
        if ( !isalive( attacker ) || !isalive( victim ) )
        {
            return;
        }
        
        victim thread [[ level.callbackplayerdamage ]]( attacker, attacker, 500, 0, "<dev string:xcbb>", "<dev string:xccc>", ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x2ef>", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x449b80e5, Offset: 0xa7d4
    // Size: 0x5a9, Type: dev
    function updateminimapsetting()
    {
        requiredmapaspectratio = getdvarfloat( @"scr_requiredmapaspectratio", 1 );
        
        if ( !isdefined( level.minimapheight ) )
        {
            setdevdvar( @"scr_minimap_height", "<dev string:xa3>" );
            level.minimapheight = 0;
        }
        
        minimapheight = getdvarfloat( @"scr_minimap_height" );
        
        if ( minimapheight != level.minimapheight )
        {
            if ( isdefined( level.minimaporigin ) )
            {
                level.minimapplayer unlink();
                level.minimaporigin delete();
                level notify( #"end_draw_map_bounds" );
            }
            
            if ( minimapheight > 0 )
            {
                level.minimapheight = minimapheight;
                players = getentarray( "<dev string:xcd4>", #classname );
                
                if ( players.size > 0 )
                {
                    player = players[ 0 ];
                    
                    if ( isdefined( level.mapcorners ) )
                    {
                        corners = level.mapcorners;
                    }
                    else
                    {
                        corners = getentarray( "<dev string:xcdb>", #targetname );
                        
                        if ( corners.size == 0 )
                        {
                            allvolumes = getnoentvolumearray( "<dev string:xcea>", #classname );
                            
                            if ( allvolumes.size > 0 )
                            {
                                if ( allvolumes.size != 1 )
                                {
                                    println( "<dev string:xcff>" );
                                    return;
                                }
                                
                                boundscorners = allvolumes[ 0 ] getboundscorners();
                                corners[ 0 ] = spawnstruct();
                                corners[ 0 ].origin = boundscorners[ 0 ];
                                corners[ 1 ] = spawnstruct();
                                corners[ 1 ].origin = boundscorners[ 1 ];
                            }
                        }
                    }
                    
                    if ( corners.size == 2 )
                    {
                        viewpos = corners[ 0 ].origin + corners[ 1 ].origin;
                        viewpos = ( viewpos[ 0 ] * 0.5, viewpos[ 1 ] * 0.5, viewpos[ 2 ] * 0.5 );
                        maxcorner = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], viewpos[ 2 ] );
                        mincorner = ( corners[ 0 ].origin[ 0 ], corners[ 0 ].origin[ 1 ], viewpos[ 2 ] );
                        
                        if ( corners[ 1 ].origin[ 0 ] > corners[ 0 ].origin[ 0 ] )
                        {
                            maxcorner = ( corners[ 1 ].origin[ 0 ], maxcorner[ 1 ], maxcorner[ 2 ] );
                        }
                        else
                        {
                            mincorner = ( corners[ 1 ].origin[ 0 ], mincorner[ 1 ], mincorner[ 2 ] );
                        }
                        
                        if ( corners[ 1 ].origin[ 1 ] > corners[ 0 ].origin[ 1 ] )
                        {
                            maxcorner = ( maxcorner[ 0 ], corners[ 1 ].origin[ 1 ], maxcorner[ 2 ] );
                        }
                        else
                        {
                            mincorner = ( mincorner[ 0 ], corners[ 1 ].origin[ 1 ], mincorner[ 2 ] );
                        }
                        
                        viewpostocorner = maxcorner - viewpos;
                        viewpos = ( viewpos[ 0 ], viewpos[ 1 ], viewpos[ 2 ] + minimapheight );
                        origin = spawn( "<dev string:xd65>", player.origin );
                        northvector = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
                        eastvector = ( northvector[ 1 ], 0 - northvector[ 0 ], 0 );
                        disttotop = vectordot( northvector, viewpostocorner );
                        
                        if ( disttotop < 0 )
                        {
                            disttotop = 0 - disttotop;
                        }
                        
                        disttoside = vectordot( eastvector, viewpostocorner );
                        
                        if ( disttoside < 0 )
                        {
                            disttoside = 0 - disttoside;
                        }
                        
                        if ( requiredmapaspectratio > 0 )
                        {
                            mapaspectratio = disttoside / disttotop;
                            
                            if ( mapaspectratio < requiredmapaspectratio )
                            {
                                incr = requiredmapaspectratio / mapaspectratio;
                                disttoside *= incr;
                                addvec = vecscale( eastvector, vectordot( eastvector, maxcorner - viewpos ) * ( incr - 1 ) );
                                mincorner -= addvec;
                                maxcorner += addvec;
                            }
                            else
                            {
                                incr = mapaspectratio / requiredmapaspectratio;
                                disttotop *= incr;
                                addvec = vecscale( northvector, vectordot( northvector, maxcorner - viewpos ) * ( incr - 1 ) );
                                mincorner -= addvec;
                                maxcorner += addvec;
                            }
                        }
                        
                        aspectratioguess = 1.77778;
                        angleside = 2 * atan( disttoside * 0.8 / minimapheight );
                        angletop = 2 * atan( disttotop * aspectratioguess * 0.8 / minimapheight );
                        
                        if ( angleside > angletop )
                        {
                            angle = angleside;
                        }
                        else
                        {
                            angle = angletop;
                        }
                        
                        znear = minimapheight - 1000;
                        
                        if ( znear < 16 )
                        {
                            znear = 16;
                        }
                        
                        if ( znear > 10000 )
                        {
                            znear = 10000;
                        }
                        
                        player playerlinkto( origin );
                        origin.origin = viewpos + ( 0, 0, -62 );
                        origin.angles = ( 90, getnorthyaw(), 0 );
                        player clearaccessory();
                        player takeallweapons();
                        player inventory_utility::_giveweapon( "<dev string:xd73>" );
                        devsetminimapdvarsettings( znear, angle );
                        level.minimapplayer = player;
                        level.minimaporigin = origin;
                        thread drawminimapbounds( viewpos, mincorner, maxcorner );
                        waitframe();
                        player setplayerangles( origin.angles );
                        setdvar( @"hash_e33eff4545d6dcfb", 0 );
                        setdvar( @"handheldcamerarotationscale", 0 );
                    }
                    else
                    {
                        println( "<dev string:xd81>" );
                    }
                    
                    return;
                }
                
                setdevdvar( @"scr_minimap_height", "<dev string:xa3>" );
            }
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xd7ea67ed, Offset: 0xad85
    // Size: 0x2e, Type: dev
    function vecscale( vec, scalar )
    {
        return ( vec[ 0 ] * scalar, vec[ 1 ] * scalar, vec[ 2 ] * scalar );
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xf090345f, Offset: 0xadbb
    // Size: 0x20d, Type: dev
    function drawminimapbounds( viewpos, mincorner, maxcorner )
    {
        level notify( #"end_draw_map_bounds" );
        level endon( #"end_draw_map_bounds" );
        viewheight = viewpos[ 2 ] - maxcorner[ 2 ];
        north = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
        diaglen = length( mincorner - maxcorner );
        mincorneroffset = mincorner - viewpos;
        mincorneroffset = vectornormalize( ( mincorneroffset[ 0 ], mincorneroffset[ 1 ], 0 ) );
        mincorner += vecscale( mincorneroffset, diaglen * 1 / 800 );
        maxcorneroffset = maxcorner - viewpos;
        maxcorneroffset = vectornormalize( ( maxcorneroffset[ 0 ], maxcorneroffset[ 1 ], 0 ) );
        maxcorner += vecscale( maxcorneroffset, diaglen * 1 / 800 );
        diagonal = maxcorner - mincorner;
        side = vecscale( north, vectordot( diagonal, north ) );
        sidenorth = vecscale( north, abs( vectordot( diagonal, north ) ) );
        corner0 = mincorner;
        corner1 = mincorner + side;
        corner2 = maxcorner;
        corner3 = maxcorner - side;
        toppos = vecscale( mincorner + maxcorner, 0.5 ) + vecscale( sidenorth, 0.51 );
        textscale = diaglen * 0.003;
        
        while ( true )
        {
            line( corner0, corner1, ( 0, 1, 0 ) );
            line( corner1, corner2, ( 0, 1, 0 ) );
            line( corner2, corner3, ( 0, 1, 0 ) );
            line( corner3, corner0, ( 0, 1, 0 ) );
            print3d( toppos, "<dev string:xdca>", ( 1, 1, 1 ), 1, textscale );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xf26d7d79, Offset: 0xafd0
    // Size: 0xfb, Type: dev
    function inittestclientlatent( team, connecting )
    {
        while ( !self canspawnbotortestclient() )
        {
            waitframe();
            
            if ( !isdefined( self ) )
            {
                if ( isdefined( connecting ) )
                {
                    connecting.abort = 1;
                }
                
                return;
            }
        }
        
        self spawnbotortestclient();
        playerlogic::spawnspectator();
        self.btestclient = 1;
        
        while ( !isdefined( self.pers[ "<dev string:x766>" ] ) )
        {
            waitframe();
            
            if ( !isdefined( self ) )
            {
                if ( isdefined( connecting ) )
                {
                    connecting.abort = 1;
                }
                
                return;
            }
        }
        
        if ( !isbrgamemode() )
        {
            menus::menuspectator();
            menus::autoassign();
        }
        
        if ( game_utility_mp::allowclasschoice() )
        {
            class = "<dev string:xdd7>" + randomint( 3 );
            self notify( #"loadout_class_selected", class );
        }
        
        utility::waittill_notify_or_timeout( "<dev string:xddd>", 0.5 );
        wait 0.1;
        
        if ( isdefined( connecting ) )
        {
            connecting.ready = 1;
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x8f11c0a8, Offset: 0xb0d3
    // Size: 0x140, Type: dev
    function spawn_test_clients( testclients )
    {
        connectingarray = [];
        
        while ( connectingarray.size < testclients )
        {
            waitframe();
            tc = addtestclient();
            
            if ( !isdefined( tc ) )
            {
                println( "<dev string:xdec>" );
                wait 1;
                continue;
            }
            
            connecting = spawnstruct();
            connecting.tc = tc;
            connecting.ready = 0;
            connecting.abort = 0;
            connectingarray[ connectingarray.size ] = connecting;
            connecting.tc thread inittestclientlatent( "<dev string:xe06>", connecting );
        }
        
        connectedcomplete = 0;
        
        while ( connectedcomplete < connectingarray.size )
        {
            connectedcomplete = 0;
            
            foreach ( connecting in connectingarray )
            {
                if ( connecting.ready || connecting.abort )
                {
                    connectedcomplete++;
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6fc865cb, Offset: 0xb21b
    // Size: 0x515, Type: dev
    function function_e8fe689b376ce824()
    {
        wait 1;
        
        for ( ;; )
        {
            if ( getdvar( @"hash_159870fced1db05e", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        rom = function_238cbe484cdaa614();
        command = getdvar( @"hash_159870fced1db05e" );
        
        if ( command != "<dev string:x270>" && !isdefined( rom ) )
        {
            print::printonteam( "<dev string:xe11>", level.players[ 0 ].team );
            command = "<dev string:x2f4>";
        }
        
        if ( command == "<dev string:x270>" )
        {
            level notify( #"hash_73af4e78750cc64f" );
            setdevdvar( @"hash_81f3fefd0af8548e", 0 );
            setdevdvar( @"testclients_domove", 0 );
            setdevdvar( @"scr_testclients_spawnpoint", 1 );
            level thread function_12c3b6d291939af();
            
            while ( getdvarint( @"scr_testclients_spawnpoint" ) > 0 )
            {
                wait 1;
            }
            
            level notify( #"hash_9c3089aec68ec165" );
            rom = function_238cbe484cdaa614();
            rom thread function_a471cbe48be940be();
            rom thread function_9c3e5e8292c41f4e();
            rom thread function_98a47eee22184481();
            
            if ( game_utility_mp::matchmakinggame() )
            {
                setmatchdata( "<dev string:xe36>", 1 );
            }
        }
        else if ( command == "<dev string:xe3e>" )
        {
            level notify( #"hash_73af4e78750cc64f" );
            rom = undefined;
            setdevdvar( @"hash_81f3fefd0af8548e", 1 );
            setdevdvar( @"testclients_domove", 1 );
        }
        else if ( command == "<dev string:xe44>" )
        {
            print::printonteam( "<dev string:xe4c>", level.players[ 0 ].team );
            rom kill();
        }
        else if ( command == "<dev string:xe5c>" || command == "<dev string:xe62>" || command == "<dev string:xe69>" )
        {
            print::printonteam( "<dev string:xe6f>" + command + "<dev string:x2d8>", level.players[ 0 ].team );
            rom.laststance = command;
            function_92301bd04bd54297( rom.laststance );
        }
        else if ( command == "<dev string:xe83>" )
        {
            host_origin = level.players[ 0 ].origin;
            host_angles = level.players[ 0 ].angles;
            rom_origin = rom.origin;
            rom_angles = rom.angles;
            level.players[ 0 ] setorigin( rom_origin );
            level.players[ 0 ] setplayerangles( rom_angles );
            rom setorigin( host_origin );
            rom.spawnpoint = host_origin;
            rom.forcespawnorigin = host_origin;
            rom setplayerangles( host_angles );
            rom_stance = rom getstance();
            host_stance = level.players[ 0 ] getstance();
            rom.laststance = host_stance;
            function_92301bd04bd54297( rom.laststance );
            level.players[ 0 ] setstance( rom_stance );
            print::printonteam( "<dev string:xe8a>", level.players[ 0 ].team );
        }
        else if ( command == "<dev string:xea5>" || command == "<dev string:xeb0>" )
        {
            level notify( #"hash_112783384518159c" );
            
            if ( command == "<dev string:xeb0>" )
            {
                rom thread function_a471cbe48be940be();
            }
        }
        else if ( command == "<dev string:xeba>" )
        {
            if ( !isdefined( rom.outlined ) )
            {
                rom.outlined = 0;
            }
            
            if ( !rom.outlined )
            {
                rom hudoutlinedisableforclient( level.players[ 0 ] );
                rom hudoutlineenableforclient( level.players[ 0 ], "<dev string:xec0>" );
                rom.outlined = 1;
            }
            else
            {
                rom hudoutlinedisableforclient( level.players[ 0 ] );
                rom.outlined = 0;
            }
        }
        else if ( command == "<dev string:xed4>" || command == "<dev string:xee5>" || command == "<dev string:xef6>" || command == "<dev string:xf0c>" || command == "<dev string:xf21>" || command == "<dev string:xf35>" || command == "<dev string:xf46>" || command == "<dev string:xf56>" || command == "<dev string:xf67>" )
        {
            if ( !isdefined( rom.var_220dc386876797fa ) )
            {
                rom.var_220dc386876797fa = 0;
            }
            
            level notify( #"hash_d2e18dcd1bda90ec" );
            rom.var_220dc386876797fa = 0;
            command = getsubstr( command, 13, command.size );
            
            if ( command != "<dev string:xf7b>" )
            {
                rom thread function_8964085395d73181( command );
                rom.var_220dc386876797fa = 1;
            }
        }
        
        setdevdvar( @"hash_159870fced1db05e", "<dev string:x2f4>" );
        thread function_e8fe689b376ce824();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbf439d40, Offset: 0xb738
    // Size: 0x8c, Type: dev
    function function_238cbe484cdaa614()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) || istestclient( player ) )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xf1e7a4b1, Offset: 0xb7cc
    // Size: 0x442, Type: dev
    function function_8964085395d73181( cmd )
    {
        level endon( #"hash_73af4e78750cc64f" );
        level endon( #"hash_d2e18dcd1bda90ec" );
        self endon( #"disconnect" );
        player = level.players[ 0 ];
        heightoffset = ( 0, 0, 16 );
        barlength = 16;
        var_e5ad5311f29acc9f = ( 1, 1, 1 );
        snipermaxrange = 2048;
        var_c3acd4b7f5fd5a75 = ( 0.2, 0.6, 0.2 );
        lmgmaxrange = 1100;
        var_1db3686769fbdfce = ( 0.5, 0.7, 0.5 );
        armaxrange = 1280;
        var_47319486b3b07df9 = ( 0.3, 0.4, 0.7 );
        smgmaxrange = 512;
        var_ada195e4e8e2cfa7 = ( 0.1, 0.6, 0.3 );
        pistolmaxrange = 300;
        var_a7500fe827086bcd = ( 0.1, 0.9, 0.6 );
        shotgunmaxrange = 190;
        var_5aec5f6e6989c1bc = ( 0.7, 0.1, 0.6 );
        colors = undefined;
        ranges = undefined;
        
        switch ( cmd )
        {
            case #"hash_c482c6c109150a4":
                colors = [ var_5aec5f6e6989c1bc, var_a7500fe827086bcd, var_ada195e4e8e2cfa7, var_47319486b3b07df9, var_1db3686769fbdfce, var_c3acd4b7f5fd5a75 ];
                ranges = [ shotgunmaxrange, pistolmaxrange, smgmaxrange, armaxrange, lmgmaxrange, snipermaxrange ];
                break;
            case #"hash_23209741b93850b5":
                colors = [ var_5aec5f6e6989c1bc ];
                ranges = [ shotgunmaxrange ];
                break;
            case #"hash_719417cb1de832b6":
                colors = [ var_a7500fe827086bcd ];
                ranges = [ pistolmaxrange ];
                break;
            case #"hash_900cb96c552c5e8e":
                colors = [ var_ada195e4e8e2cfa7 ];
                ranges = [ smgmaxrange ];
                break;
            case #"hash_fa18d2f6bd57925a":
                colors = [ var_47319486b3b07df9 ];
                ranges = [ armaxrange ];
                break;
            case #"hash_2f2d546c2247838f":
                colors = [ var_1db3686769fbdfce ];
                ranges = [ lmgmaxrange ];
                break;
            case #"hash_6191aaef9f922f96":
                colors = [ var_c3acd4b7f5fd5a75 ];
                ranges = [ snipermaxrange ];
                break;
            default:
                break;
        }
        
        if ( isdefined( colors ) && isdefined( ranges ) )
        {
            while ( true )
            {
                angles = vectortoangles( player.origin - self.origin );
                forward = anglestoforward( angles );
                right = anglestoright( angles );
                left = right * -1;
                endorg = self.origin + forward * snipermaxrange;
                points = [];
                points[ 0 ] = self.origin;
                
                foreach ( range in ranges )
                {
                    points[ points.size ] = points[ 0 ] + forward * range;
                }
                
                lastpoint = points[ 0 ];
                
                for ( i = 1; i < points.size ; i++ )
                {
                    var_8ddffaa25c52e26c = points[ i ] + heightoffset + right * barlength;
                    var_8ddffda25c52e905 = points[ i ] + heightoffset + left * barlength;
                    line( lastpoint + heightoffset, points[ i ] + heightoffset, colors[ i - 1 ], 1, 0, 1 );
                    line( var_8ddffaa25c52e26c, var_8ddffda25c52e905, colors[ i - 1 ], 1, 0, 1 );
                    lastpoint = points[ i ];
                }
                
                waitframe();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x85416fb9, Offset: 0xbc16
    // Size: 0x39, Type: dev
    function function_98a47eee22184481()
    {
        level endon( #"hash_73af4e78750cc64f" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( #"death" );
            thread function_ed9fdb29aebc0df4();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x383aa68d, Offset: 0xbc57
    // Size: 0x26, Type: dev
    function function_ed9fdb29aebc0df4()
    {
        corpse = self getcorpseentity();
        wait 1;
        
        if ( isdefined( corpse ) )
        {
            corpse delete();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x484accb4, Offset: 0xbc85
    // Size: 0xbb, Type: dev
    function function_9c3e5e8292c41f4e()
    {
        level endon( #"hash_73af4e78750cc64f" );
        self endon( #"disconnect" );
        
        if ( !isdefined( self.spawnpoint ) )
        {
            self.spawnpoint = self.origin;
        }
        
        if ( !isdefined( self.laststance ) )
        {
            self.laststance = "<dev string:x2ef>";
        }
        
        while ( true )
        {
            if ( !isalive( self ) )
            {
                self waittill( #"spawned_player" );
            }
            
            if ( self.origin != self.spawnpoint )
            {
                self setorigin( self.spawnpoint );
            }
            
            if ( self getstance() != self.laststance )
            {
                function_92301bd04bd54297( self.laststance );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x1a21227e, Offset: 0xbd48
    // Size: 0xae, Type: dev
    function function_92301bd04bd54297( stance )
    {
        switch ( stance )
        {
            case #"hash_3fed0cbd303639eb":
                setdevdvar( @"hash_33fe5ebb83d90648", 1 );
                setdevdvar( @"hash_43cd2bf145682550", 0 );
                break;
            case #"hash_d91940431ed7c605":
                setdevdvar( @"hash_33fe5ebb83d90648", 0 );
                setdevdvar( @"hash_43cd2bf145682550", 1 );
                break;
            case #"hash_c6775c88e38f7803":
            default:
                setdevdvar( @"hash_33fe5ebb83d90648", 0 );
                setdevdvar( @"hash_43cd2bf145682550", 0 );
                break;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x320bf5ef, Offset: 0xbdfe
    // Size: 0x183, Type: dev
    function function_a471cbe48be940be()
    {
        level endon( #"hash_73af4e78750cc64f" );
        level endon( #"hash_112783384518159c" );
        self endon( #"disconnect" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            romhealth = "<dev string:xfa0>" + self.health + "<dev string:xfa5>";
            romdist = function_bdbeab55d59f0d78( player.origin );
            
            if ( isdefined( self.attackerdata[ player.guid ] ) )
            {
                romdamage = "<dev string:xfa7>" + self.attackerdata[ player.guid ].damage + "<dev string:xfa5>";
                romhitloc = "<dev string:xfb0>" + self.attackerdata[ player.guid ].shitloc + "<dev string:xfa5>";
                var_6c1970b6e75289d4 = "<dev string:xfb6>" + getweaponbasename( self.attackerdata[ player.guid ].objweapon );
            }
            else
            {
                romdamage = "<dev string:xfbd>";
                romhitloc = "<dev string:xfc9>";
                var_6c1970b6e75289d4 = "<dev string:xfd0>";
            }
            
            builtstring = romhealth + romdamage + romdist + romhitloc + var_6c1970b6e75289d4;
            printtoscreen2d( 150, 500, builtstring, ( 1, 1, 1 ), 2 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x14f3ef, Offset: 0xbf89
    // Size: 0x45, Type: dev
    function function_12c3b6d291939af()
    {
        level endon( #"hash_73af4e78750cc64f" );
        level endon( #"hash_9c3089aec68ec165" );
        
        while ( true )
        {
            printtoscreen2d( 800, 650, "<dev string:xfd6>", ( 1, 1, 1 ), 2 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xc859dda3, Offset: 0xbfd6
    // Size: 0x13e, Type: dev
    function function_bdbeab55d59f0d78( playerorg )
    {
        shotgunmaxrange = 190;
        pistolmaxrange = 300;
        smgmaxrange = 512;
        lmgmaxrange = 1100;
        armaxrange = 1280;
        snipermaxrange = 2048;
        dist = int( distance( playerorg, self.origin ) );
        weapstring = "<dev string:x2f4>";
        
        if ( dist <= shotgunmaxrange )
        {
            weapstring = "<dev string:xfe9>";
        }
        else if ( dist > shotgunmaxrange && dist <= pistolmaxrange )
        {
            weapstring = "<dev string:xff1>";
        }
        else if ( dist > pistolmaxrange && dist <= smgmaxrange )
        {
            weapstring = "<dev string:xff8>";
        }
        else if ( dist > smgmaxrange && dist <= lmgmaxrange )
        {
            weapstring = "<dev string:xffc>";
        }
        else if ( dist > lmgmaxrange && dist <= armaxrange )
        {
            weapstring = "<dev string:x1000>";
        }
        else if ( dist > lmgmaxrange && dist <= snipermaxrange )
        {
            weapstring = "<dev string:x1003>";
        }
        else if ( dist > snipermaxrange )
        {
            weapstring = "<dev string:x1010>";
        }
        
        return "<dev string:x1019>" + dist + "<dev string:x1021>" + weapstring + "<dev string:x1024>";
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x72b3b806, Offset: 0xc11c
    // Size: 0x171, Type: dev
    function function_682b8590b6870b94()
    {
        var_d50af91f70ff14a4 = level.br_ac130.origin;
        var_8420562b06b24326 = vectornormalize( level.infilstruct.c130pathstruct.endpt - var_d50af91f70ff14a4 );
        var_b143c3687c779ed0 = ( level.br_level.br_mapbounds[ 0 ][ 0 ] - var_d50af91f70ff14a4[ 0 ] ) / var_8420562b06b24326[ 0 ];
        var_b11fd9687c4f547a = ( level.br_level.br_mapbounds[ 1 ][ 0 ] - var_d50af91f70ff14a4[ 0 ] ) / var_8420562b06b24326[ 0 ];
        var_3a1c2d7b783e89c5 = ( level.br_level.br_mapbounds[ 0 ][ 1 ] - var_d50af91f70ff14a4[ 1 ] ) / var_8420562b06b24326[ 1 ];
        var_3a3f377b7864e77b = ( level.br_level.br_mapbounds[ 1 ][ 1 ] - var_d50af91f70ff14a4[ 1 ] ) / var_8420562b06b24326[ 1 ];
        boundsdistances = arraysort( [ var_b11fd9687c4f547a, var_b143c3687c779ed0, var_3a3f377b7864e77b, var_3a1c2d7b783e89c5 ] );
        c130speed = br_c130::getc130speed();
        var_377d30ea5e85e284 = boundsdistances[ 1 ] / c130speed;
        var_bc152547c76d56df = boundsdistances[ 2 ] / c130speed;
        times = [ var_377d30ea5e85e284, var_bc152547c76d56df ];
        return times;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x256c85c8, Offset: 0xc295
    // Size: 0x71, Type: dev
    function function_e15ef46d2a25cc9c( var_8cc74e7bc3a45ca0 )
    {
        if ( isalive( self ) && !self isparachuting() && !self.gulag )
        {
            var_4a04fc1a97c3d093 = var_8cc74e7bc3a45ca0[ 1 ] - var_8cc74e7bc3a45ca0[ 0 ];
            var_1a45973ab711edaf = var_8cc74e7bc3a45ca0[ 0 ] + randomfloatrange( 0.2, 0.8 ) * var_4a04fc1a97c3d093;
            wait var_1a45973ab711edaf;
            self notify( #"halo_jump_solo_c130" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfc02de58, Offset: 0xc30e
    // Size: 0x133, Type: dev
    function function_df4ce5ccd744d7ae()
    {
        level endon( #"game_ended" );
        
        for ( ;; )
        {
            if ( isdefined( level.br_c130spawndone ) && !level.br_c130spawndone )
            {
                if ( isdefined( level.br_ac130 ) && isdefined( level.br_ac130.origin ) && isdefined( level.infilstruct ) && isdefined( level.infilstruct.c130pathstruct ) && level.infilstruct.playersinc130 > 0 )
                {
                    var_8cc74e7bc3a45ca0 = function_682b8590b6870b94();
                    
                    foreach ( player in level.players )
                    {
                        if ( !isdefined( player ) )
                        {
                            continue;
                        }
                        
                        if ( istestclient( player ) )
                        {
                            player thread function_e15ef46d2a25cc9c( var_8cc74e7bc3a45ca0 );
                        }
                    }
                    
                    break;
                }
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe0a97cb5, Offset: 0xc449
    // Size: 0x102, Type: dev
    function function_23a9778193c84e17()
    {
        level endon( #"game_ended" );
        
        for ( ;; )
        {
            var_c5bd4edc77fbea2a = 3;
            var_2341a54a830aced8 = 7;
            
            if ( getdvarint( @"hash_75663a72eb414a9a" ) > 0 )
            {
                if ( game[ "<dev string:x1027>" ] || level.br_c130spawndone )
                {
                    shootertc = function_19358e20a2edb5e( 1 );
                    
                    if ( isdefined( shootertc ) )
                    {
                        targetbot = function_209c442180a89401( shootertc, 0, 1 );
                        
                        if ( isdefined( targetbot ) )
                        {
                            var_453b6f68002c51cc = shootertc.origin + ( 0, 0, 30 );
                            var_a752cb134fe49f99 = targetbot.origin + ( 0, 0, 30 );
                            magicbullet( shootertc.currentweapon, var_453b6f68002c51cc, var_a752cb134fe49f99, shootertc, shootertc );
                            var_c5bd4edc77fbea2a = 0.1;
                            var_2341a54a830aced8 = 1;
                        }
                    }
                }
            }
            
            wait randomfloatrange( var_c5bd4edc77fbea2a, var_2341a54a830aced8 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x91342c9c, Offset: 0xc553
    // Size: 0xb1, Type: dev
    function function_c017dacaa7e9e13a()
    {
        level endon( #"game_ended" );
        
        for ( ;; )
        {
            if ( getdvarint( @"scr_testclients_killplayer" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_testclients_killplayer", 0 );
        notbot = function_2ee13eddfbd7f93c();
        bot = getbot( notbot );
        
        if ( isdefined( bot ) )
        {
            notbot thread [[ level.callbackplayerdamage ]]( bot, bot, 500, 0, "<dev string:xcbb>", bot.primaryweaponobj, bot.origin, ( 0, 0, 0 ), "<dev string:x2ef>", 0 );
        }
        
        wait 1;
        thread function_c017dacaa7e9e13a();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xeaf4381e, Offset: 0xc60c
    // Size: 0x1d8, Type: dev
    function function_f991e75e48c655e5()
    {
        for ( ;; )
        {
            if ( getdvar( @"scr_testclients_givekillstreak", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        killstreak = getdvar( @"scr_testclients_givekillstreak" );
        setdevdvar( @"scr_testclients_givekillstreak", "<dev string:x2f4>" );
        notbot = function_2ee13eddfbd7f93c();
        bot = getbot( notbot, 1 );
        
        if ( getdvarint( @"hash_9554b84c655e575d" ) )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) || istestclient( player ) )
                {
                    bot = player;
                }
                
                if ( isdefined( bot ) )
                {
                    bot botusekillstreak( killstreak );
                }
            }
        }
        else if ( getdvarint( @"hash_7ce94a8dcd3c8b99" ) )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) || istestclient( player ) )
                {
                    bot = player;
                }
                
                if ( isdefined( bot ) )
                {
                    bot thread botusekillstreak( killstreak );
                }
            }
        }
        else if ( isdefined( bot ) )
        {
            bot botusekillstreak( killstreak );
        }
        
        thread function_f991e75e48c655e5();
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x52114d7, Offset: 0xc7ec
    // Size: 0x116, Type: dev
    function botusekillstreak( killstreak )
    {
        var_ec73d9361a038a70 = 0;
        emptime = undefined;
        
        if ( killstreak == "<dev string:x426>" )
        {
            var_ec73d9361a038a70 = 1;
            emptime = getdvarfloat( @"scr_emp_timeout" );
            killstreak = "<dev string:x430>";
            setdevdvar( @"scr_emp_timeout", 1 );
        }
        
        if ( killstreak == "<dev string:x1033>" )
        {
            perkfunctions::setlightarmor();
            return;
        }
        
        if ( killstreak == "<dev string:x1045>" )
        {
            var_9f250dc5b290486 = getdvarint( @"hash_3f1bd355bf340abb" );
            setdvar( @"hash_3f1bd355bf340abb", 1 );
            juggernaut::tryusejuggernaut();
            setdvar( @"hash_3f1bd355bf340abb", var_9f250dc5b290486 );
            return;
        }
        
        killstreaks::awardkillstreak( killstreak, "<dev string:x459>" );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isai( self ) && !getdvarint( @"hash_dd6a15dccb6f778c" ) )
        {
            return;
        }
        
        thread killstreaks::forceactivategimmekillstreak();
        
        if ( var_ec73d9361a038a70 )
        {
            level thread function_a48e6713064f914f( 1, @"scr_emp_timeout", emptime );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xeab5b1df, Offset: 0xc90a
    // Size: 0xff, Type: dev
    function function_34adbfddf846de6a()
    {
        while ( true )
        {
            var_1613732f09d472d4 = getdvarint( @"hash_4e36a9eabf7e82e8" );
            var_e5aa7a935768c45 = getdvarint( @"hash_ef8dd069548e17f5" );
            
            if ( var_1613732f09d472d4 != -1 )
            {
                targetbot = getentbynum( var_1613732f09d472d4 );
                
                if ( isbot( targetbot ) )
                {
                    target_personality = getdvar( @"hash_25a092a4e24276a8", "<dev string:x2ef>" );
                    
                    if ( target_personality != "<dev string:x2ef>" )
                    {
                        targetbot bots_util_mp::bot_set_personality( target_personality );
                    }
                }
                
                setdevdvar( @"hash_4e36a9eabf7e82e8", -1 );
            }
            
            if ( var_e5aa7a935768c45 != -1 )
            {
                targetbot = getentbynum( var_e5aa7a935768c45 );
                
                if ( isbot( targetbot ) )
                {
                    target_difficulty = getdvar( @"hash_12f2c9fee50fa98d", "<dev string:x2ef>" );
                    
                    if ( target_difficulty != "<dev string:x2ef>" )
                    {
                        targetbot bots_util_mp::bot_set_difficulty( target_difficulty );
                    }
                }
                
                setdevdvar( @"hash_ef8dd069548e17f5", -1 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfd65dbc2, Offset: 0xca11
    // Size: 0xd5, Type: dev
    function function_3c7e867162702821()
    {
        while ( true )
        {
            if ( getdvar( @"hash_4ae56ff4e4985e83", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                if ( getdvar( @"hash_4ae56ff4e4985e83" ) == "<dev string:x1050>" )
                {
                    level thread function_729bd0a3b6053043( 1, 0 );
                }
                else if ( getdvar( @"hash_4ae56ff4e4985e83" ) == "<dev string:x1055>" )
                {
                    level thread function_729bd0a3b6053043( 0.05, 0 );
                }
                else if ( getdvar( @"hash_4ae56ff4e4985e83" ) == "<dev string:x105a>" )
                {
                    level thread function_729bd0a3b6053043( 1, 1 );
                }
                else if ( getdvar( @"hash_4ae56ff4e4985e83" ) == "<dev string:x1060>" )
                {
                    level function_5a5275187a9d0811();
                }
                
                setdvar( @"hash_4ae56ff4e4985e83", "<dev string:x2f4>" );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7a7586dd, Offset: 0xcaee
    // Size: 0x91, Type: dev
    function function_94d284035f6fa534()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_9608479c0ddc550d", 0 ) != 0 )
            {
                if ( level.var_dce68d4837fb7c51 )
                {
                    level notify( #"hash_1e07c483bcbc225f" );
                    level function_212d716dd7f2f952();
                    level.var_dce68d4837fb7c51 = undefined;
                    iprintlnbold( "<dev string:x1065>" );
                }
                else
                {
                    level function_61d3d4ff1671e72a();
                    level thread function_188c9a36be13da6b();
                    level.var_dce68d4837fb7c51 = 1;
                    iprintlnbold( "<dev string:x1081>" );
                }
                
                setdvar( @"hash_9608479c0ddc550d", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdd21b89a, Offset: 0xcb87
    // Size: 0x91, Type: dev
    function bots_forceads()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_10966de869cb14af", 0 ) != 0 )
            {
                if ( level.var_623212fe1271e353 )
                {
                    level notify( #"hash_b972d226e3d9d109" );
                    level function_64a3b82244be73a4();
                    level.var_623212fe1271e353 = undefined;
                    iprintlnbold( "<dev string:x109c>" );
                }
                else
                {
                    level function_1ff0894850c845ec();
                    level thread function_ccf53daca5e8a54d();
                    level.var_623212fe1271e353 = 1;
                    iprintlnbold( "<dev string:x10b1>" );
                }
                
                setdvar( @"hash_10966de869cb14af", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf972bed0, Offset: 0xcc20
    // Size: 0x91, Type: dev
    function function_4789e3980daa6e27()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_c0dc0c7f4b21ea54", 0 ) != 0 )
            {
                if ( level.var_90d13785045b4658 )
                {
                    level notify( #"hash_9de1c07fd3bcde08" );
                    level function_115e9454f407a171();
                    level.var_90d13785045b4658 = undefined;
                    iprintlnbold( "<dev string:x10c5>" );
                }
                else
                {
                    level function_b9f65599b41c035f();
                    level thread function_40ed794288ee970c();
                    level.var_90d13785045b4658 = 1;
                    iprintlnbold( "<dev string:x10e4>" );
                }
                
                setdvar( @"hash_c0dc0c7f4b21ea54", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x19e45a29, Offset: 0xccb9
    // Size: 0xac, Type: dev
    function function_61d3d4ff1671e72a()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) && !isdefined( player.perks[ "<dev string:x1102>" ] ) )
            {
                player perk::giveperk( "<dev string:x1102>" );
                player thread function_ee4ef3cee7424b88();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbac80b2b, Offset: 0xcd6d
    // Size: 0xa2, Type: dev
    function function_212d716dd7f2f952()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) && isdefined( player.perks[ "<dev string:x1102>" ] ) )
            {
                player perk::removeperk( "<dev string:x1102>" );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xca22005c, Offset: 0xce17
    // Size: 0x52, Type: dev
    function function_188c9a36be13da6b()
    {
        level endon( #"hash_1e07c483bcbc225f" );
        
        while ( true )
        {
            level waittill( #"player_spawned", player );
            
            if ( isbot( player ) )
            {
                player perk::giveperk( "<dev string:x1102>" );
                player thread function_ee4ef3cee7424b88();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbbe48a0b, Offset: 0xce71
    // Size: 0x2a, Type: dev
    function function_ee4ef3cee7424b88()
    {
        self endon( #"death" );
        self endon( #"disconnect" );
        wait 0.1;
        function_61ee960625d52f49();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xff07c584, Offset: 0xcea3
    // Size: 0xc1, Type: dev
    function function_61ee960625d52f49()
    {
        player = undefined;
        
        foreach ( p in level.players )
        {
            if ( !isbot( p ) )
            {
                player = p;
                break;
            }
        }
        
        if ( isdefined( player ) )
        {
            self dodamage( player.maxhealth, player.origin, player, player, "<dev string:x1118>", undefined, "<dev string:x1123>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xcfe025c6, Offset: 0xcf6c
    // Size: 0x87, Type: dev
    function function_1ff0894850c845ec()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                player thread bot_forceads();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1857e8df, Offset: 0xcffb
    // Size: 0x8b, Type: dev
    function function_64a3b82244be73a4()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                player notify( #"stop_forceads" );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf9897cb4, Offset: 0xd08e
    // Size: 0x44, Type: dev
    function function_ccf53daca5e8a54d()
    {
        level endon( #"hash_b972d226e3d9d109" );
        
        while ( true )
        {
            level waittill( #"player_spawned", player );
            
            if ( isbot( player ) )
            {
                player thread bot_forceads();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb6f9d7fa, Offset: 0xd0da
    // Size: 0x38, Type: dev
    function bot_forceads()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"stop_forceads" );
        
        while ( true )
        {
            self botpressbutton( "<dev string:x112f>", 1.1 );
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xaa20278c, Offset: 0xd11a
    // Size: 0x87, Type: dev
    function function_b9f65599b41c035f()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                player thread function_cc8e6aaca57c1c08();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x19e8ef79, Offset: 0xd1a9
    // Size: 0x44, Type: dev
    function function_40ed794288ee970c()
    {
        level endon( #"hash_9de1c07fd3bcde08" );
        
        while ( true )
        {
            level waittill( #"player_spawned", player );
            
            if ( isbot( player ) )
            {
                player thread function_cc8e6aaca57c1c08();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6aa12214, Offset: 0xd1f5
    // Size: 0x8b, Type: dev
    function function_115e9454f407a171()
    {
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                player notify( #"hash_d57d3ad927b17f56" );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5590d033, Offset: 0xd288
    // Size: 0x33, Type: dev
    function function_cc8e6aaca57c1c08()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_d57d3ad927b17f56" );
        
        while ( true )
        {
            self botpressbutton( "<dev string:x1133>" );
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x607af711, Offset: 0xd2c3
    // Size: 0x17e, Type: dev
    function function_729bd0a3b6053043( delay, domelee )
    {
        level notify( #"hash_aeb2c051217f36c4" );
        level endon( #"hash_aeb2c051217f36c4" );
        setdvar( @"player_sustainammo", 1 );
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) && isalive( player ) )
                {
                    if ( domelee )
                    {
                        button = "<dev string:x1140>";
                    }
                    else
                    {
                        button = "<dev string:x1146>";
                    }
                    
                    if ( delay == 0.05 )
                    {
                        player botpressbutton( button, delay );
                    }
                    else
                    {
                        player botpressbutton( button );
                    }
                    
                    if ( !isdefined( player.var_2380220540d81e31 ) )
                    {
                        forwarddir = anglestoforward( player.angles );
                        player.var_2380220540d81e31 = player.origin + forwarddir * 100 + ( 0, 0, 50 );
                    }
                    
                    player botlookatpoint( player.var_2380220540d81e31, delay + 0.1, "<dev string:x114d>" );
                }
            }
            
            wait delay;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x76d57afa, Offset: 0xd449
    // Size: 0xb1, Type: dev
    function function_5a5275187a9d0811()
    {
        setdvar( @"player_sustainammo", "<dev string:xa3>" );
        level notify( #"hash_aeb2c051217f36c4" );
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && isalive( player ) )
            {
                self.var_2380220540d81e31 = undefined;
            }
        }
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xaceb0f55, Offset: 0xd502
    // Size: 0x2c, Type: dev
    function function_a48e6713064f914f( waittime, dvarname, dvarvalue )
    {
        wait waittime;
        setdevdvar( dvarname, dvarvalue );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa8784fe4, Offset: 0xd536
    // Size: 0xd2, Type: dev
    function function_5e2157232ab4d67c()
    {
        for ( ;; )
        {
            if ( getdvarint( @"hash_407d81926ced4cff" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_407d81926ced4cff", 0 );
        notbot = function_2ee13eddfbd7f93c();
        bot = getbot( notbot );
        
        if ( isdefined( bot ) )
        {
            trace = trace::_bullet_trace( bot.origin + ( 0, 0, 4 ), bot.origin - ( 0, 0, 4 ), 0, bot );
            box = deployablebox::createboxforplayer( "<dev string:x115b>", trace[ "<dev string:x236>" ], bot );
            wait 0.05;
            box thread deployablebox::box_setactive();
        }
        
        thread function_5e2157232ab4d67c();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf1915dd, Offset: 0xd610
    // Size: 0x2ab, Type: dev
    function addtestclientspawnpoint()
    {
        for ( ;; )
        {
            if ( getdvarint( @"scr_testclients_spawnpoint" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            setdevdvar( @"scr_testclients_spawnpoint", 0 );
            thread addtestclientspawnpoint();
            return;
        }
        
        if ( !isalive( notbot ) )
        {
            setdevdvar( @"scr_testclients_spawnpoint", 0 );
            thread addtestclientspawnpoint();
            return;
        }
        
        markerpos = trace::_bullet_trace( notbot geteye(), notbot.origin + anglestoforward( notbot getplayerangles() ) * 10000, 0, notbot );
        marker = spawn( "<dev string:x229>", markerpos[ "<dev string:x236>" ] );
        marker setmodel( "<dev string:x116b>" );
        trace = trace::_bullet_trace( marker.origin + ( 0, 0, 50 ), marker.origin + ( 0, 0, -100 ), 0, marker );
        marker.origin = trace[ "<dev string:x236>" ];
        marker thread showfx();
        
        while ( getdvarint( @"scr_testclients_spawnpoint" ) > 0 )
        {
            markerpos = trace::_bullet_trace( notbot geteye(), notbot.origin + anglestoforward( notbot getplayerangles() ) * 10000, 0, marker );
            marker.origin = markerpos[ "<dev string:x236>" ];
            trace = trace::_bullet_trace( marker.origin + ( 0, 0, 50 ), marker.origin + ( 0, 0, -100 ), 0, marker );
            marker.origin = trace[ "<dev string:x236>" ];
            
            if ( notbot usebuttonpressed() )
            {
                ent = addtestclient();
                
                if ( !isdefined( ent ) )
                {
                    println( "<dev string:xdec>" );
                    wait 1;
                    continue;
                }
                
                ent inittestclientlatent( team_utility::getotherteam( notbot.team ) );
                
                if ( !isdefined( ent ) )
                {
                    println( "<dev string:xdec>" );
                    wait 1;
                    continue;
                }
                
                ent utility::waittill_notify_or_timeout( "<dev string:xddd>", 0.5 );
                wait 0.1;
                
                while ( ent.sessionstate != "<dev string:x1179>" )
                {
                    waitframe();
                }
                
                ent setorigin( marker.origin );
                
                if ( game_utility_mp::matchmakinggame() )
                {
                    setmatchdata( "<dev string:xe36>", 1 );
                }
                
                break;
            }
            
            wait 0.05;
        }
        
        marker delete();
        setdevdvar( @"scr_testclients_spawnpoint", 0 );
        thread addtestclientspawnpoint();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4eb89079, Offset: 0xd8c3
    // Size: 0x2b, Type: dev
    function showfx()
    {
        self endon( #"death" );
        wait 1;
        playfxontag( level.var_25ccba59a7813a4b, self, "<dev string:x1181>" );
    }

    // Namespace dev_mp
    // Params 3, eflags: 0x4
    // Checksum 0x3e3fa5d0, Offset: 0xd8f6
    // Size: 0x6a, Type: dev
    function private warpents( var_862218d87ba0e5ba, var_16348de4a4e6834f, warpfunction )
    {
        if ( !isdefined( warpfunction ) )
        {
            warpfunction = &function_b9d22947c76a3ca0;
        }
        
        if ( var_16348de4a4e6834f.size == 1 )
        {
            [[ warpfunction ]]( var_862218d87ba0e5ba, var_16348de4a4e6834f[ 0 ], 1 );
            return;
        }
        
        for ( i = 0; i < var_16348de4a4e6834f.size ; i++ )
        {
            [[ warpfunction ]]( var_862218d87ba0e5ba, var_16348de4a4e6834f[ i ], i );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4bc3d38e, Offset: 0xd968
    // Size: 0x210, Type: dev
    function warpenemies()
    {
        warpfuncs = [ &function_b9d22947c76a3ca0, &function_b0629272f88b6184 ];
        
        while ( true )
        {
            var_cccbfcc9422d964e = getdvarint( @"hash_1c423b4190c17fda" );
            
            if ( getdvarint( @"scr_warpenemies" ) > 0 || var_cccbfcc9422d964e > 0 || getdvarint( @"hash_32201091ed0c5bd6" ) > 0 )
            {
                notbot = function_2ee13eddfbd7f93c();
                
                if ( !isdefined( notbot ) )
                {
                    return;
                }
                
                warpfunction = warpfuncs[ 0 ];
                
                if ( var_cccbfcc9422d964e > 0 )
                {
                    warpfunction = warpfuncs[ var_cccbfcc9422d964e - 1 ];
                }
                
                targets = level.warptargets ?? level.characters;
                warpplayers = [];
                
                foreach ( character in targets )
                {
                    if ( !isalive( character ) )
                    {
                        continue;
                    }
                    
                    if ( isagent( character ) && getdvarint( @"hash_32201091ed0c5bd6" ) < 1 )
                    {
                        continue;
                    }
                    
                    if ( character.sessionstate == "<dev string:x283>" )
                    {
                        continue;
                    }
                    
                    if ( var_cccbfcc9422d964e > 0 && !isbot( character ) )
                    {
                        continue;
                    }
                    
                    if ( !level.teambased || character.team != notbot.team )
                    {
                        warpplayers[ warpplayers.size ] = character;
                    }
                }
                
                warpents( notbot, warpplayers, warpfunction );
                
                if ( getdvarint( @"hash_f5a9982eaa189f7b" ) > 0 )
                {
                    function_5514a33d3e21c1e1();
                }
                
                setdevdvar( @"scr_warpenemies", 0 );
                setdevdvar( @"hash_1c423b4190c17fda", 0 );
                setdevdvar( @"hash_32201091ed0c5bd6", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4cb971f6, Offset: 0xdb80
    // Size: 0x19e, Type: dev
    function function_3b38b843b1a97dfe()
    {
        for ( ;; )
        {
            if ( getdvar( @"hash_be5cbd4a2291f23f", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            waitframe();
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            return;
        }
        
        targets = undefined;
        
        if ( isdefined( level.warptargets ) )
        {
            targets = level.warptargets;
        }
        else
        {
            targets = level.characters;
        }
        
        warpplayers = [];
        
        foreach ( character in targets )
        {
            if ( !isalive( character ) )
            {
                continue;
            }
            
            if ( isagent( character ) )
            {
                continue;
            }
            
            if ( character.sessionstate == "<dev string:x283>" )
            {
                continue;
            }
            
            if ( getdvar( @"hash_be5cbd4a2291f23f", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                if ( !isbot( character ) )
                {
                    continue;
                }
            }
            
            if ( getdvar( @"hash_be5cbd4a2291f23f", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                if ( character.team == getdvar( @"hash_be5cbd4a2291f23f" ) )
                {
                    warpplayers[ warpplayers.size ] = character;
                }
            }
        }
        
        warpents( notbot, warpplayers );
        setdevdvar( @"hash_be5cbd4a2291f23f", "<dev string:x2f4>" );
        thread function_3b38b843b1a97dfe();
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x849d04ad, Offset: 0xdd26
    // Size: 0xf2, Type: dev
    function function_c3e83038a9057ee1( character, offsetfwd, offsetlft )
    {
        if ( !isdefined( offsetfwd ) )
        {
            offsetfwd = 0;
        }
        
        if ( !isdefined( offsetlft ) )
        {
            offsetlft = 0;
        }
        
        fwd = anglestoforward( character.angles ) * ( 72 + offsetfwd ) + ( 0, 0, 48 );
        lft = anglestoleft( character.angles ) * offsetlft;
        target = character.origin + fwd + lft;
        result = undefined;
        
        if ( game_utility::islargemap() || getdvarint( @"hash_97969ce3aa403846", 0 ) == 1 )
        {
            result = character.origin + fwd + lft;
        }
        else
        {
            result = getclosestpointonnavmesh( character.origin + fwd + lft, character );
        }
        
        return result;
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x38e548f9, Offset: 0xde20
    // Size: 0xc8, Type: dev
    function function_b9d22947c76a3ca0( caller, warpee, idx )
    {
        var_3a6ac5fca6f100a5 = idx % 3;
        var_d713a7c8d58158f5 = int( idx / 3 );
        offsetfwd = var_d713a7c8d58158f5 * 96;
        offsetlft = var_3a6ac5fca6f100a5 * 48 - 48;
        
        if ( var_d713a7c8d58158f5 % 2 != 0 )
        {
            offsetlft += 24;
        }
        
        spawnpos = function_c3e83038a9057ee1( caller, offsetfwd, offsetlft );
        spawnang = ( 0, caller getplayerangles( 1 )[ 1 ] + 180, 0 );
        warpee setorigin( spawnpos + ( 0, 0, 18 ) );
        warpee setplayerangles( spawnang );
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xba93a156, Offset: 0xdef0
    // Size: 0x7d, Type: dev
    function function_b0629272f88b6184( caller, warpee, idx )
    {
        spawnpos = isbrgamemode() ? br_circle::getrandompointincurrentcircle() : bots_util_mp::function_478281ff275ed942();
        spawnang = ( 0, caller getplayerangles( 1 )[ 1 ] + 180, 0 );
        warpee setorigin( spawnpos + ( 0, 0, 18 ) );
        warpee setplayerangles( spawnang );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x79cef22f, Offset: 0xdf75
    // Size: 0x1fe, Type: dev
    function warpfriendlies()
    {
        warpfuncs = [ &function_b9d22947c76a3ca0, &function_b0629272f88b6184 ];
        
        while ( true )
        {
            var_a353367544fe9bd5 = getdvarint( @"hash_7c14c45b0376be39" );
            
            if ( getdvarint( @"scr_warpfriendlies" ) > 0 || var_a353367544fe9bd5 > 0 || getdvarint( @"hash_493c636a94f69749" ) > 0 )
            {
                notbot = function_2ee13eddfbd7f93c();
                
                if ( !isdefined( notbot ) )
                {
                    return;
                }
                
                warpfunction = warpfuncs[ 0 ];
                
                if ( var_a353367544fe9bd5 > 0 )
                {
                    warpfunction = warpfuncs[ var_a353367544fe9bd5 - 1 ];
                }
                
                targets = level.warptargets ?? level.characters;
                warpplayers = [];
                
                foreach ( character in targets )
                {
                    if ( !isalive( character ) )
                    {
                        continue;
                    }
                    
                    if ( isagent( character ) && getdvarint( @"hash_493c636a94f69749" ) < 1 )
                    {
                        continue;
                    }
                    
                    if ( character.sessionstate == "<dev string:x283>" )
                    {
                        continue;
                    }
                    
                    if ( var_a353367544fe9bd5 > 0 && !isbot( character ) )
                    {
                        continue;
                    }
                    
                    if ( notbot != character && level.teambased && character.team == notbot.team )
                    {
                        warpplayers[ warpplayers.size ] = character;
                    }
                }
                
                warpents( notbot, warpplayers, warpfunction );
                setdevdvar( @"scr_warpfriendlies", 0 );
                setdevdvar( @"hash_7c14c45b0376be39", 0 );
                setdevdvar( @"hash_493c636a94f69749", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf2ec0, Offset: 0xe17b
    // Size: 0x133, Type: dev
    function function_c775d9c82c197378()
    {
        for ( ;; )
        {
            if ( getdvarint( @"hash_d2d27e6a1337fc41" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_d2d27e6a1337fc41", 0 );
        
        if ( !isdefined( level.var_e43c4f5db716fa0d ) )
        {
            level.var_e43c4f5db716fa0d = 0;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            return;
        }
        
        spawnpos = function_c3e83038a9057ee1( notbot );
        characterkeys = getarraykeys( level.characters );
        
        for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
        {
            characterindex = level.var_e43c4f5db716fa0d % characterkeys.size;
            character = level.characters[ characterkeys[ characterindex ] ];
            level.var_e43c4f5db716fa0d++;
            
            if ( isbot( character ) && isalive( character ) )
            {
                if ( level.teambased )
                {
                    if ( character.team != notbot.team )
                    {
                        character setorigin( spawnpos );
                        break;
                    }
                    
                    continue;
                }
                
                character setorigin( spawnpos );
                break;
            }
        }
        
        thread function_c775d9c82c197378();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x69d577da, Offset: 0xe2b6
    // Size: 0x143, Type: dev
    function function_4b24284d9589427f()
    {
        for ( ;; )
        {
            if ( getdvarint( @"hash_475e86d5470a4524" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_475e86d5470a4524", 0 );
        
        if ( !isdefined( level.var_a4dc107cd96473a6 ) )
        {
            level.var_a4dc107cd96473a6 = 0;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            return;
        }
        
        spawnpos = function_c3e83038a9057ee1( notbot );
        characterkeys = getarraykeys( level.characters );
        
        for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
        {
            characterindex = level.var_a4dc107cd96473a6 % characterkeys.size;
            character = level.characters[ characterkeys[ characterindex ] ];
            level.var_a4dc107cd96473a6++;
            
            if ( isdefined( character ) && character != notbot )
            {
                if ( level.teambased )
                {
                    if ( character.team == notbot.team && character.sessionstate == "<dev string:x1179>" )
                    {
                        character setorigin( spawnpos );
                        break;
                    }
                    
                    continue;
                }
                
                character setorigin( spawnpos );
                break;
            }
        }
        
        thread function_4b24284d9589427f();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf85bb3e5, Offset: 0xe401
    // Size: 0x75f, Type: dev
    function function_e497e457bfd53f9f()
    {
        for ( ;; )
        {
            if ( getdvar( @"hash_be4638b34423d0ca", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_50344224f078e06d();
            }
            else if ( getdvar( @"hash_be7522650406f34f", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_4b13696342c5dd1c();
            }
            else if ( getdvar( @"hash_87fd1aab915574c0", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_a869f8658514f213();
            }
            else if ( getdvar( @"hash_3debe2571172850", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_bdd807fdf068fbc5();
            }
            else if ( getdvar( @"hash_8fcbab7f56dcce7", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_467f0a5f3fb81f5a();
            }
            else if ( getdvar( @"hash_b679b1eead8733a3", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_dc4402d991756a00();
            }
            else if ( getdvarint( @"scr_dbgbullets", 0 ) != 0 )
            {
                thread dbgbullets();
            }
            else if ( getdvar( @"hash_ae04ade2c8e72fdc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_e39d9eae1535cb1b();
            }
            else if ( getdvarint( @"hash_4aa285a21e3a2ebe" ) != 0 )
            {
                thread function_ebe42c7f9468595f();
            }
            else if ( getdvar( @"scr_giveweaponvariant", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_giveweaponvariant();
            }
            else if ( getdvarint( @"hash_3fd9a57c895659d3" ) != 0 )
            {
                thread function_d821e8633f35c51a();
            }
            else if ( getdvar( @"hash_4685ccd8b87f6f7e", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_22539b6b89f04c3d();
            }
            
            waitframe();
            
            if ( getdvar( @"scr_spawnweapon", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_spawnweapon();
            }
            else if ( getdvar( @"hash_b1941ef83f118a4e", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_ee2fa471d106eab3();
            }
            else if ( getdvar( @"hash_6f67d3ada4d28ec5", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_867f0ed1ce0074fc();
            }
            else if ( getdvar( @"scr_dropweapon", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_dropweapon();
            }
            else if ( getdvarint( @"scr_dropammo", -1 ) != -1 )
            {
                thread gui_dropammo();
            }
            else if ( getdvar( @"scr_giveweaponsuper", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_giveweaponsuper();
            }
            else if ( getdvar( @"scr_giveattachment", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_giveattachment();
            }
            else if ( getdvarint( @"hash_3e790d5daea0f55e" ) != 0 )
            {
                thread function_9d019b70cbf4e65f();
            }
            else if ( getdvar( @"hash_94cfa401914bb582", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_b39412f831e56637();
            }
            else if ( getdvar( @"hash_cd022e5b7a0889e", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_97ca7d5b670b16d9();
            }
            else if ( getdvarint( @"hash_463624d11608d0dc", -1 ) != -1 )
            {
                thread function_e9ddac3b97b9268b();
            }
            else if ( getdvar( @"hash_1da69ba9e35c8ea0", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_e163d05fa967867b();
            }
            else if ( getdvar( @"scr_givegesture", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_givegesture();
            }
            else if ( getdvar( @"scr_giveexecution", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_giveexecution();
            }
            else if ( getdvar( @"hash_cfc446de878b0ee3", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6087efc6af1b20e0();
            }
            else if ( getdvar( @"hash_d51834b4d1b89a35", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_764b9db0597fadcb();
            }
            else if ( getdvar( @"hash_656c12d185e55da8", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_1c4a882baea8ba26();
            }
            else if ( getdvar( @"hash_29944a1d8da3e755", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_4987b5c2af52a59c();
            }
            
            waitframe();
            
            if ( getdvar( @"hash_d7ac865ae726cebc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_55abfa85c5e27063();
            }
            else if ( getdvar( @"scr_list_inventory", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread devlistinventory();
            }
            else if ( getdvar( @"hash_53605e5dfa2134cc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_7941e5ddcbbac9ba();
            }
            else if ( getdvarint( @"scr_give_cyberemp" ) != 0 )
            {
                function_7d2d52d9d13c1f5d();
            }
            else if ( getdvarint( @"scr_test_callback_group" ) != 0 )
            {
                function_646dd8d73f7c7241();
            }
            else if ( getdvar( @"hash_912105285f3af273", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                function_9fb9b49e99048d15();
            }
            else if ( getdvar( @"hash_5e62b8f4b2dd7d6e", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                function_7c712d8681561c1c();
            }
            else if ( getdvarint( @"hash_28e2b3251abc4817" ) != 0 )
            {
                thread function_b9a9a38a2753bde2();
            }
            else if ( getdvar( @"hash_8de4ac9450b61777", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6c926dcdc5c6fb78();
            }
            else if ( getdvar( @"hash_8de4ad9450b619aa", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6c9270cdc5c70211();
            }
            else if ( getdvar( @"hash_8de4ae9450b61bdd", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6c926fcdc5c6ffde();
            }
            else if ( getdvar( @"hash_8de4a79450b60c78", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6c9272cdc5c70677();
            }
            else if ( getdvar( @"hash_8de4a89450b60eab", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_6c9271cdc5c70444();
            }
            else if ( getdvarint( @"hash_efa2254b31f42841" ) != 0 )
            {
                thread function_b63f974a2e8d48b0();
            }
            else if ( getdvarint( @"hash_ac65f9192e2efd0" ) != 0 )
            {
                thread function_5757fd27d0ed350f();
            }
            else if ( getdvarint( @"hash_f8168febda35ecc7" ) != 0 )
            {
                thread function_de262db5fb407404();
            }
            else if ( getdvarint( @"hash_c70eda82dc2d8ce0" ) != 0 )
            {
                thread function_2bfd2009f778e48f();
            }
            else if ( getdvarint( @"hash_76509eeacc4eb3b" ) != 0 )
            {
                thread function_d1537369904fbc1c();
            }
            else if ( getdvarint( @"scr_soccerball_create" ) != 0 )
            {
                function_3d9c9bee5a3e707();
            }
            else if ( getdvarint( @"scr_soccerball_warp" ) != 0 )
            {
                function_483499ddbfdae929();
            }
            else if ( getdvar( @"hash_49e7d6f989610e4c", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_739cdb7ff393bbc9();
            }
            else if ( getdvar( @"hash_4434b2fec517d0dc", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_146d0b59d95b78c9();
            }
            else if ( getdvarint( @"hash_1355c524166682a" ) || !getdvarint( @"hash_1355c524166682a" ) && getdvarint( @"hash_fc21d0ecef8ba617" ) )
            {
                thread function_1bbae8647cefc43f();
            }
            else if ( getdvar( @"hash_1b5bb10f6c906c49", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_60493baa8536364e();
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe6239c5d, Offset: 0xeb68
    // Size: 0x404, Type: dev
    function function_50344224f078e06d()
    {
        entries = [];
        attachments = weapon::getnonopticattachmentlistbasenames();
        optics = weapon::getopticattachmentlistbasenames();
        
        foreach ( a in attachments )
        {
            entries[ entries.size ] = "<dev string:x1188>" + a + "<dev string:x11b1>" + tolower( a ) + "<dev string:x2df>";
        }
        
        foreach ( optic in optics )
        {
            entries[ entries.size ] = "<dev string:x11cc>" + optic + "<dev string:x11b1>" + tolower( optic ) + "<dev string:x2df>";
        }
        
        weapons = [];
        weaponsscriptbundle = weapon::function_16ff7d597f441100();
        
        if ( isdefined( weaponsscriptbundle ) )
        {
            foreach ( weaponname in weaponsscriptbundle )
            {
                weaponscriptbundle = weapon::function_659a3e10e8d1c91c( weaponname, [ #"menuclass", #"ref" ] );
                
                if ( isdefined( weaponscriptbundle ) )
                {
                    weapclass = weaponscriptbundle.menuclass;
                    
                    if ( weapclass == "<dev string:x2f4>" )
                    {
                        continue;
                    }
                    
                    if ( !issubstr( weapclass, "<dev string:x65d>" ) )
                    {
                        continue;
                    }
                    
                    if ( weapclass == "<dev string:x11f0>" || weapclass == "<dev string:x11fd>" || weapclass == "<dev string:x120c>" )
                    {
                        continue;
                    }
                    
                    weapclass = getsubstr( weapclass, 7 );
                    weap = weaponscriptbundle.ref;
                    project = "<dev string:x121d>";
                    
                    if ( isstartstr( weap, "<dev string:x1223>" ) )
                    {
                        project = "<dev string:x1227>";
                    }
                    
                    tokens = strtok( weap, "<dev string:x122d>" );
                    idx = 0;
                    
                    if ( tokens.size > 0 )
                    {
                        idx = 1;
                    }
                    
                    weapmid = tokens[ idx ];
                    
                    if ( tokens.size > 2 )
                    {
                        weapmid = tokens[ idx ] + "<dev string:x122d>" + tokens[ idx + 1 ];
                    }
                    
                    if ( weap.size < 3 || getsubstr( weap, weap.size - 3 ) != "<dev string:x122f>" )
                    {
                        weap += "<dev string:x122f>";
                    }
                    
                    path = "<dev string:x1233>" + project + "<dev string:x124b>" + weapclass + "<dev string:x124b>" + weapmid;
                    entries[ entries.size ] = path + "<dev string:x124d>" + tolower( weap ) + "<dev string:x2df>";
                }
            }
        }
        
        println( "<dev string:x1264>" );
        
        foreach ( e in entries )
        {
            if ( e != "<dev string:x2f4>" )
            {
                println( e );
            }
        }
        
        println( "<dev string:x12a4>" );
        iprintlnbold( "<dev string:x12c7>" );
        setdevdvar( @"hash_be4638b34423d0ca", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd68d8da6, Offset: 0xef74
    // Size: 0x137, Type: dev
    function function_4b13696342c5dd1c()
    {
        val = getdvar( @"hash_be7522650406f34f" );
        
        if ( isdefined( val ) )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    continue;
                }
                
                if ( getdvarint( @"hash_772ed98b83015ac9" ) == 0 )
                {
                    setdevdvar( @"hash_772ed98b83015ac9", 1 );
                    setdevdvar( @"hash_48a5711c3d32ab43", 0 );
                    player perk::giveperk( "<dev string:x12ef>" );
                    iprintlnbold( "<dev string:x1305>" );
                    continue;
                }
                
                setdevdvar( @"hash_772ed98b83015ac9", 0 );
                setdevdvar( @"hash_48a5711c3d32ab43", 0.75 );
                player perk::removeperk( "<dev string:x12ef>" );
                iprintlnbold( "<dev string:x131b>" );
            }
        }
        
        setdevdvar( @"hash_be7522650406f34f", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2fbaf429, Offset: 0xf0b3
    // Size: 0x102, Type: dev
    function function_a869f8658514f213()
    {
        val = getdvar( @"hash_87fd1aab915574c0" );
        
        if ( isdefined( val ) )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( level.var_a869f8658514f213 ) )
                {
                    level.var_a869f8658514f213 = 1;
                    player utility::setrecoilscale( 0, 100 );
                    iprintlnbold( "<dev string:x1332>" );
                    continue;
                }
                
                level.var_a869f8658514f213 = undefined;
                player utility::setrecoilscale( 0, 0 );
                iprintlnbold( "<dev string:x133d>" );
            }
        }
        
        setdevdvar( @"hash_87fd1aab915574c0", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6d4c9c94, Offset: 0xf1bd
    // Size: 0xcb, Type: dev
    function function_bdd807fdf068fbc5()
    {
        val = getdvar( @"hash_3debe2571172850" );
        
        if ( isdefined( val ) )
        {
            intval = int( val );
            
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    continue;
                }
                
                player utility::setrecoilscale( intval );
            }
        }
        
        setdevdvar( @"hash_3debe2571172850", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x54ef5fc0, Offset: 0xf290
    // Size: 0xf9, Type: dev
    function function_467f0a5f3fb81f5a()
    {
        val = getdvar( @"hash_8fcbab7f56dcce7" );
        
        if ( isdefined( val ) )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player.perks[ val ] ) )
                {
                    player perk::giveperk( val );
                    player iprintlnbold( "<dev string:x1347>" + val + "<dev string:x134e>" );
                    continue;
                }
                
                player perk::removeperk( val );
                player iprintlnbold( "<dev string:x1347>" + val + "<dev string:x1356>" );
            }
        }
        
        setdevdvar( @"hash_8fcbab7f56dcce7", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7a6d37ba, Offset: 0xf391
    // Size: 0x52, Type: dev
    function function_dc4402d991756a00()
    {
        if ( !isdefined( level.var_dc4402d991756a00 ) )
        {
            iprintlnbold( "<dev string:x1360>" );
            level.var_dc4402d991756a00 = 1;
        }
        else
        {
            iprintlnbold( "<dev string:x1378>" );
            level.var_dc4402d991756a00 = undefined;
        }
        
        setdevdvar( @"hash_b679b1eead8733a3", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x58b6805c, Offset: 0xf3eb
    // Size: 0xff, Type: dev
    function dbgbullets()
    {
        val = 0;
        type = undefined;
        
        if ( getdvarint( @"scr_dbgbullets" ) == 1 )
        {
            val = 2;
            type = "<dev string:x1391>";
        }
        else if ( getdvarint( @"scr_dbgbullets" ) == 2 )
        {
            val = 4;
            type = "<dev string:x762>";
        }
        else if ( getdvarint( @"scr_dbgbullets" ) == 7 )
        {
            val = 7;
            type = "<dev string:x13a2>";
        }
        else
        {
            assertmsg( "<dev string:x13ae>" + getdvar( @"scr_dbgbullets" ) );
            return;
        }
        
        if ( getdvarint( @"g_debugbullets" ) == val )
        {
            iprintlnbold( "<dev string:x13d4>" );
            setdevdvar( @"g_debugbullets", "<dev string:x8d7>" );
        }
        else
        {
            iprintlnbold( "<dev string:x13e7>" + type );
            setdevdvar( @"g_debugbullets", val );
        }
        
        setdevdvar( @"scr_dbgbullets", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbe1a3dae, Offset: 0xf4f2
    // Size: 0x61, Type: dev
    function function_e39d9eae1535cb1b()
    {
        if ( getdvarint( @"hash_937cc8707ed92860" ) == 1 )
        {
            iprintlnbold( "<dev string:x13f7>" );
            setdevdvar( @"hash_937cc8707ed92860", 0 );
        }
        else
        {
            iprintlnbold( "<dev string:x140c>" );
            setdevdvar( @"hash_937cc8707ed92860", 1 );
        }
        
        setdevdvar( @"hash_ae04ade2c8e72fdc", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf95e5ef1, Offset: 0xf55b
    // Size: 0x39, Type: dev
    function function_ebe42c7f9468595f()
    {
        if ( isdefined( level.blockweapondrops ) )
        {
            level.blockweapondrops = undefined;
        }
        else
        {
            level.blockweapondrops = 1;
        }
        
        setdevdvar( @"hash_4aa285a21e3a2ebe", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1374221f, Offset: 0xf59c
    // Size: 0x221, Type: dev
    function gui_spawnweapon()
    {
        weapnew = getdvar( @"scr_spawnweapon" );
        variant = -1;
        toks = strtok( weapnew, "<dev string:x1420>" );
        
        if ( toks.size > 1 )
        {
            weapnew = toks[ 0 ];
            variant = int( toks[ 1 ] );
        }
        
        if ( isdefined( weapnew ) )
        {
            weapnew = weapon::getweaponrootname( weapnew );
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                hasnvg = utility::function_2a082dafe6f4bd5b();
                var_dd2db255da3902ac = weapon::buildweapon( weapnew, undefined, undefined, undefined, variant, undefined, undefined, undefined, hasnvg );
                startpos = player.origin;
                dir = anglestoforward( player.angles );
                offset = 50;
                voffset = ( 0, 0, 45 );
                name = getcompleteweaponname( var_dd2db255da3902ac );
                weapon = spawn( "<dev string:x65d>" + name, startpos + offset * dir + voffset, 17 );
                weapon itemweaponsetammo( weaponclipsize( var_dd2db255da3902ac ), weaponmaxammo( var_dd2db255da3902ac ) );
                weapon makeusable();
                weapon sethintdisplayrange( 96 );
                weapon setuserange( 96 );
                centerofmass = weapon physics_getentitycenterofmass();
                
                if ( isdefined( centerofmass ) )
                {
                    centerofmass = centerofmass[ "<dev string:x1422>" ];
                }
                else
                {
                    centerofmass = weapon.origin;
                }
                
                launchforce = dir * 1000 + ( 0, 0, 500 );
                weapon physicslaunchserveritem( centerofmass, launchforce );
            }
        }
        
        setdevdvar( @"scr_spawnweapon", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x12a30871, Offset: 0xf7c5
    // Size: 0x5b, Type: dev
    function function_867f0ed1ce0074fc()
    {
        tuning = float( getdvar( @"hash_6f67d3ada4d28ec5" ) );
        intvalue = function_cc48710279fdc53e( tuning );
        iprintln( "<dev string:x142b>" + tuning + "<dev string:x1438>" + intvalue );
        setdevdvar( @"hash_6f67d3ada4d28ec5", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb43dd97a, Offset: 0xf828
    // Size: 0x2f5, Type: dev
    function function_ee2fa471d106eab3()
    {
        variantid = 0;
        blueprintname = getdvar( @"hash_b1941ef83f118a4e" );
        equipblueprint = getxhashasset( blueprintname );
        equipment = equipment_mp::function_e7be0aab8fa729de( blueprintname );
        equipasset = undefined;
        slot = undefined;
        
        if ( isdefined( level.equipment.table[ equipment ] ) )
        {
            equipasset = level.equipment.table[ equipment ].weaponname;
            slot = level.equipment.table[ equipment ].defaultslot;
        }
        else
        {
            equipment = undefined;
            
            foreach ( tableinfo in level.equipment.table )
            {
                equipvariants = getweaponblueprintnames( tableinfo.objweapon );
                
                foreach ( variant, id in equipvariants )
                {
                    if ( equipblueprint == variant )
                    {
                        equipment = tableinfo.ref;
                        equipasset = tableinfo.weaponname;
                        slot = tableinfo.defaultslot;
                        break;
                    }
                }
                
                if ( isdefined( equipasset ) )
                {
                    break;
                }
            }
        }
        
        if ( isdefined( equipasset ) )
        {
            equipvariants = getweaponblueprintnames( equipasset );
            
            foreach ( variant, id in equipvariants )
            {
                if ( equipblueprint == variant )
                {
                    foreach ( player in level.players )
                    {
                        player equipment_mp::giveequipment( equipment, slot, undefined, id );
                    }
                    
                    break;
                }
            }
        }
        
        setdevdvar( @"hash_b1941ef83f118a4e", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9ffef835, Offset: 0xfb25
    // Size: 0x18d, Type: dev
    function gui_giveweaponvariant()
    {
        variant = getdvarint( @"scr_giveweaponvariant" );
        
        if ( isdefined( variant ) )
        {
            curweapon = level.players[ 0 ] getcurrentweapon();
            weapnew = weapon::getweaponrootname( curweapon );
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                hasnvg = utility::function_2a082dafe6f4bd5b();
                var_dd2db255da3902ac = weapon::buildweapon( weapnew, undefined, undefined, undefined, variant, undefined, undefined, undefined, hasnvg );
                currentweapon = player.currentweapon;
                player.droppeddeathweapon = undefined;
                player weapons::dropweaponfordeath( undefined, "<dev string:x2f4>" );
                player.droppeddeathweapon = undefined;
                
                if ( player hasweapon( var_dd2db255da3902ac ) )
                {
                    player inventory_utility::_takeweapon( var_dd2db255da3902ac );
                }
                
                player inventory_utility::_giveweapon( var_dd2db255da3902ac );
                player setweaponammoclip( var_dd2db255da3902ac, weaponclipsize( var_dd2db255da3902ac ) );
                player setweaponammostock( var_dd2db255da3902ac, weaponmaxammo( var_dd2db255da3902ac ) );
                player inventory_utility::_switchtoweaponimmediate( var_dd2db255da3902ac );
                weapon::fixupplayerweapons( player, weapnew );
            }
        }
        
        setdevdvar( @"scr_giveweaponvariant", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa0d458d3, Offset: 0xfcba
    // Size: 0x6b, Type: dev
    function function_d821e8633f35c51a()
    {
        setdevdvar( @"hash_3fd9a57c895659d3", 0 );
        hostplayer = devfindhost();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        weapon = hostplayer getcurrentweapon();
        weaponname = getcompleteweaponname( weapon );
        toolweaponname = function_80178997ffe3f122( weaponname );
        println( "<dev string:x1444>" + toolweaponname );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x83cd63a, Offset: 0xfd2d
    // Size: 0x168, Type: dev
    function function_22539b6b89f04c3d()
    {
        weaponstring = getdvar( @"hash_4685ccd8b87f6f7e" );
        
        if ( isdefined( weaponstring ) )
        {
            var_c6f6ba5a9ac0b11 = function_acf5d335bf74f763( weaponstring );
            var_dd2db255da3902ac = makeweaponfromstring( var_c6f6ba5a9ac0b11 );
            weapnew = weapon::getweaponrootname( var_dd2db255da3902ac );
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                currentweapon = player.currentweapon;
                player.droppeddeathweapon = undefined;
                player weapons::dropweaponfordeath( undefined, "<dev string:x2f4>" );
                player.droppeddeathweapon = undefined;
                
                if ( player hasweapon( var_dd2db255da3902ac ) )
                {
                    player inventory_utility::_takeweapon( var_dd2db255da3902ac );
                }
                
                player inventory_utility::_giveweapon( var_dd2db255da3902ac );
                player setweaponammoclip( var_dd2db255da3902ac, weaponclipsize( var_dd2db255da3902ac ) );
                player setweaponammostock( var_dd2db255da3902ac, weaponmaxammo( var_dd2db255da3902ac ) );
                player inventory_utility::_switchtoweaponimmediate( var_dd2db255da3902ac );
                weapon::fixupplayerweapons( player, weapnew );
            }
        }
        
        setdevdvar( @"hash_4685ccd8b87f6f7e", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdf1cb89c, Offset: 0xfe9d
    // Size: 0x106, Type: dev
    function gui_giveweaponsuper()
    {
        weapnew = getdvar( @"scr_giveweaponsuper" );
        
        if ( isdefined( weapnew ) )
        {
            foreach ( player in level.players )
            {
                currentweapon = player.currentweapon;
                player dropitem( currentweapon );
                
                if ( player hasweapon( weapnew ) )
                {
                    player inventory_utility::_takeweapon( weapnew );
                }
                
                player inventory_utility::_giveweapon( weapnew );
                player setweaponammoclip( weapnew, weaponclipsize( weapnew ) );
                player setweaponammostock( weapnew, weaponmaxammo( weapnew ) );
                player inventory_utility::_switchtoweaponimmediate( weapnew );
            }
        }
        
        setdevdvar( @"scr_giveweaponsuper", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd03df7dc, Offset: 0xffab
    // Size: 0xb8, Type: dev
    function gui_giveattachment()
    {
        newattachment = getdvar( @"scr_giveattachment" );
        
        if ( isdefined( newattachment ) )
        {
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                gui_giveattachment_internal( player, newattachment );
            }
        }
        
        setdevdvar( @"scr_giveattachment", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1e96e000, Offset: 0x1006b
    // Size: 0x1f5, Type: dev
    function function_9d019b70cbf4e65f()
    {
        setdevdvar( @"hash_3e790d5daea0f55e", 0 );
        playerarray = function_ffe8acaa84c63e12();
        
        foreach ( player in playerarray )
        {
            weap = player.currentweapon;
            
            if ( !isdefined( weap ) || isnullweapon( weap ) )
            {
                continue;
            }
            
            weapbase = getweaponbasename( weap );
            defaultattachments = getweapondefaultattachments( weapbase );
            var_d74bdd955477254f = [];
            
            foreach ( att in defaultattachments )
            {
                varid = weap.attachmentvarindices[ att ];
                
                if ( !isdefined( varid ) )
                {
                    varid = 0;
                }
                
                var_d74bdd955477254f[ var_d74bdd955477254f.size ] = varid;
            }
            
            newweap = weapon::buildweapon( weapbase, defaultattachments, "<dev string:x2ef>", "<dev string:x2ef>", 0, var_d74bdd955477254f );
            level.players[ 0 ] takeweapon( weap );
            level.players[ 0 ] giveweapon( newweap );
            level.players[ 0 ] setweaponammoclip( newweap, weaponclipsize( newweap ) );
            level.players[ 0 ] setweaponammostock( newweap, weaponmaxammo( newweap ) );
            level.players[ 0 ] switchtoweaponimmediate( newweap );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x48e8252b, Offset: 0x10268
    // Size: 0xaf, Type: dev
    function gui_giveattachment_internal( player, newattachment )
    {
        currentweapon = player.currentweapon;
        player dropitem( currentweapon );
        newweapon = weapons::addattachmenttoweapon( currentweapon, newattachment );
        
        if ( !isdefined( newweapon ) )
        {
            player inventory_utility::_giveweapon( currentweapon );
            
            if ( !isbot( player ) )
            {
                player iprintlnbold( "<dev string:x1452>" + newattachment );
            }
            
            return;
        }
        
        player inventory_utility::_giveweapon( newweapon );
        player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
        player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
        player inventory_utility::_switchtoweaponimmediate( newweapon );
        weapon::fixupplayerweapons( player, newweapon );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6be14cae, Offset: 0x1031f
    // Size: 0x2ce, Type: dev
    function function_9fb9b49e99048d15()
    {
        dvarstring = getdvar( @"hash_912105285f3af273" );
        setdevdvar( @"hash_912105285f3af273", "<dev string:x2f4>" );
        categoryindex = int( getsubstr( dvarstring, 0, 1 ) );
        modelindex = int( getsubstr( dvarstring, 1, 3 ) );
        player = level.players[ 0 ];
        oldweapon = player.currentweapon;
        newweapon = oldweapon;
        
        if ( categoryindex == 0 )
        {
            iprintlnbold( "<dev string:x1484>" + modelindex );
            
            if ( !isdefined( newweapon.receiver ) )
            {
                iprintln( "<dev string:x148e>" );
                return;
            }
            
            attachmentname = newweapon.receiver;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        else if ( categoryindex == 1 )
        {
            iprintlnbold( "<dev string:x14b8>" + modelindex );
            
            if ( !isdefined( newweapon.frontpiece ) )
            {
                iprintln( "<dev string:x14c4>" );
                return;
            }
            
            attachmentname = newweapon.frontpiece;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        else if ( categoryindex == 2 )
        {
            iprintlnbold( "<dev string:x14f0>" + modelindex );
            
            if ( !isdefined( newweapon.backpiece ) )
            {
                iprintln( "<dev string:x14fb>" );
                return;
            }
            
            attachmentname = newweapon.backpiece;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        else if ( categoryindex == 3 )
        {
            iprintlnbold( "<dev string:x1526>" + modelindex );
            
            if ( !isdefined( newweapon.magazine ) )
            {
                iprintln( "<dev string:x1530>" );
                return;
            }
            
            attachmentname = newweapon.magazine;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        else if ( categoryindex == 4 )
        {
            iprintlnbold( "<dev string:x155a>" + modelindex );
            
            if ( !isdefined( newweapon.scope ) )
            {
                iprintln( "<dev string:x1561>" );
                return;
            }
            
            attachmentname = newweapon.scope;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        else if ( categoryindex == 5 )
        {
            iprintlnbold( "<dev string:x1588>" + modelindex );
            
            if ( !isdefined( newweapon.underbarrel ) )
            {
                iprintln( "<dev string:x1595>" );
                return;
            }
            
            attachmentname = newweapon.underbarrel;
            newweapon = newweapon withoutattachment( attachmentname );
            newweapon = newweapon withattachment( attachmentname, modelindex );
        }
        
        player dropitem( oldweapon );
        player inventory_utility::_giveweapon( newweapon );
        player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
        player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
        player inventory_utility::_switchtoweaponimmediate( newweapon );
        weapon::fixupplayerweapons( player, newweapon );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x19a8fe8f, Offset: 0x105f5
    // Size: 0x254, Type: dev
    function function_7c712d8681561c1c()
    {
        dvarstring = getdvar( @"hash_5e62b8f4b2dd7d6e" );
        args = strtok( dvarstring, "<dev string:x15c2>" );
        setdevdvar( @"hash_5e62b8f4b2dd7d6e", "<dev string:x2f4>" );
        attachmentname = args[ 0 ];
        modelindex = int( args[ 1 ] );
        player = level.players[ 0 ];
        oldweapon = player.currentweapon;
        newweapon = oldweapon;
        attachmenttoidmap = newweapon.attachmentvarindices;
        failed = 0;
        attachments = [];
        
        foreach ( attachment, id in attachmenttoidmap )
        {
            attachments[ attachments.size ] = attachment;
        }
        
        if ( !newweapon canuseattachment( attachmentname ) )
        {
            failed = 1;
        }
        
        if ( failed )
        {
            return;
        }
        
        var_c84cf1d3502a1321 = [];
        
        foreach ( idx, attachment in attachments )
        {
            var_c84cf1d3502a1321[ idx ] = attachmenttoidmap[ attachment ];
        }
        
        attachments[ attachments.size ] = attachmentname;
        var_c84cf1d3502a1321[ var_c84cf1d3502a1321.size ] = 0;
        attachments = weapon::weaponattachremoveextraattachments( attachments );
        newweapon = weapon::buildweapon( weapon::getweaponrootname( newweapon ), attachments, undefined, "<dev string:x2ef>", undefined, var_c84cf1d3502a1321, undefined, undefined, undefined );
        newweapon = newweapon withattachment( attachmentname, modelindex );
        iprintlnbold( "<dev string:x15c4>" + attachmentname + "<dev string:x15d7>" + modelindex );
        player dropitem( oldweapon );
        player inventory_utility::_giveweapon( newweapon );
        player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
        player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
        player inventory_utility::_switchtoweaponimmediate( newweapon );
        weapon::fixupplayerweapons( player, newweapon );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4ac275ff, Offset: 0x10851
    // Size: 0x1da, Type: dev
    function function_b39412f831e56637()
    {
        camo = getdvar( @"hash_94cfa401914bb582" );
        
        if ( camo )
        {
            validcamo = 0;
            camolistbundle = getscriptbundle( level.gamemodebundle.weaponcamolist );
            
            for ( camoindex = 0; camoindex < camolistbundle.camo_list.size ; camoindex++ )
            {
                var_c97aa77657bf1416 = camolistbundle.camo_list[ camoindex ].camodata;
                
                if ( !isdefined( var_c97aa77657bf1416 ) )
                {
                    continue;
                }
                
                if ( getxhashasset( "<dev string:x15f1>" + camo ) == var_c97aa77657bf1416 )
                {
                    camo = getscriptbundlefieldvalue( var_c97aa77657bf1416, #"ref" );
                    validcamo = 1;
                    break;
                }
            }
            
            if ( validcamo )
            {
                foreach ( player in level.players )
                {
                    weapon = player.currentweapon;
                    player dropitem( weapon );
                    weapon = weapon getnoaltweapon();
                    weapon = weapon withcamo( camo );
                    player inventory_utility::_giveweapon( weapon );
                    player setweaponammoclip( weapon, weaponclipsize( weapon ) );
                    player setweaponammostock( weapon, weaponmaxammo( weapon ) );
                    player inventory_utility::_switchtoweaponimmediate( weapon );
                }
            }
            else
            {
                iprintlnbold( "<dev string:x15fb>" + camo );
            }
        }
        
        setdevdvar( @"hash_94cfa401914bb582", "<dev string:x2f4>" );
        setdevdvar( @"hash_1355c524166682a", 0 );
        setdevdvar( @"hash_fc21d0ecef8ba617", 0 );
    }

    // Namespace dev_mp
    // Params 5
    // Checksum 0xea02f65c, Offset: 0x10a33
    // Size: 0x64, Type: dev
    function function_608a4435d88e25b3( x, y, msg, col, scale )
    {
        /#
            printtoscreen2d( x + 2, y + 2, msg, ( 0, 0, 0 ), scale );
        #/
        
        /#
            printtoscreen2d( x, y, msg, col, scale );
        #/
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x371e5a1d, Offset: 0x10a9f
    // Size: 0x1f4, Type: dev
    function function_1bbae8647cefc43f()
    {
        /#
            var_2f048fe4c10e9ce9 = getdvarint( @"hash_1355c524166682a" );
            camolistbundle = getscriptbundle( level.gamemodebundle.weaponcamolist );
            var_bad6be9206250ef2 = getscriptbundle( level.gamemodebundle.var_c77813c44e62ce1a );
            var_9ae0100e1770f60b = "<dev string:x2ef>";
            camocategory = "<dev string:x2ef>";
            
            if ( var_2f048fe4c10e9ce9 < camolistbundle.camo_list.size )
            {
                var_c97aa77657bf1416 = getxhashasset( "<dev string:x2ef>" );
                var_4a6802f920ba1652 = getxhashasset( "<dev string:x2ef>" );
                
                if ( var_2f048fe4c10e9ce9 > 0 )
                {
                    var_c97aa77657bf1416 = camolistbundle.camo_list[ var_2f048fe4c10e9ce9 - 1 ].camodata;
                    
                    if ( !isdefined( var_c97aa77657bf1416 ) )
                    {
                        return;
                    }
                    
                    var_4a6802f920ba1652 = getscriptbundlefieldvalue( var_c97aa77657bf1416, #"camocategory" );
                    var_9ae0100e1770f60b = getscriptbundlefieldvalue( var_c97aa77657bf1416, #"ref" );
                    camocategory = getxhashsourcename( var_4a6802f920ba1652 );
                }
                
                if ( var_2f048fe4c10e9ce9 != getdvarint( @"hash_fc21d0ecef8ba617" ) )
                {
                    foreach ( player in level.players )
                    {
                        function_f62ef2baaf9af0db( var_c97aa77657bf1416 );
                    }
                    
                    setdevdvar( @"hash_fc21d0ecef8ba617", var_2f048fe4c10e9ce9 );
                }
                
                if ( var_2f048fe4c10e9ce9 > 0 )
                {
                    function_608a4435d88e25b3( 10, 925, "<dev string:x1610>" + var_9ae0100e1770f60b, ( 1, 1, 1 ), 4 );
                    function_608a4435d88e25b3( 10, 1000, "<dev string:x1620>" + camocategory, ( 1, 1, 1 ), 4 );
                }
            }
        #/
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2531e692, Offset: 0x10c9b
    // Size: 0x1cb, Type: dev
    function function_97ca7d5b670b16d9()
    {
        ret = getdvar( @"hash_cd022e5b7a0889e" );
        reticle = getxhashasset( ret );
        
        if ( isdefined( reticle ) && reticle != %"" )
        {
            foreach ( player in level.players )
            {
                weapon = player.currentweapon;
                var_97583be6d9e8af07 = function_3b9780522c29b61a( weapon );
                hasreticle = 0;
                
                foreach ( scopereticle in var_97583be6d9e8af07 )
                {
                    if ( reticle == scopereticle )
                    {
                        hasreticle = 1;
                        break;
                    }
                }
                
                if ( !hasreticle )
                {
                    ret = "<dev string:x1630>" + ret;
                    reticle = getxhashasset( ret );
                }
                
                player dropitem( weapon );
                weapon = weapon getnoaltweapon();
                weapon = weapon withreticle( reticle );
                player inventory_utility::_giveweapon( weapon );
                player setweaponammoclip( weapon, weaponclipsize( weapon ) );
                player setweaponammostock( weapon, weaponmaxammo( weapon ) );
                player inventory_utility::_switchtoweaponimmediate( weapon );
            }
        }
        
        setdevdvar( @"hash_cd022e5b7a0889e", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd6c5f54e, Offset: 0x10e6e
    // Size: 0x14a, Type: dev
    function function_e9ddac3b97b9268b()
    {
        retint = getdvarint( @"hash_463624d11608d0dc", -1 );
        player = level.player;
        weapon = player.currentweapon;
        var_97583be6d9e8af07 = function_3b9780522c29b61a( weapon );
        
        if ( var_97583be6d9e8af07.size == 0 )
        {
            iprintlnbold( "<dev string:x163d>" );
        }
        else if ( var_97583be6d9e8af07.size == 1 )
        {
            iprintlnbold( "<dev string:x1654>" );
        }
        else if ( var_97583be6d9e8af07.size <= retint )
        {
            var_7babeb9000409c55 = var_97583be6d9e8af07.size - 1;
            
            if ( var_7babeb9000409c55 < 10 )
            {
                customprint = "<dev string:x1672>" + var_7babeb9000409c55;
            }
            else
            {
                customprint = "<dev string:x167b>" + var_7babeb9000409c55;
            }
            
            iprintlnbold( "<dev string:x1683>" + var_97583be6d9e8af07.size + "<dev string:x1694>" + customprint + "<dev string:x16a8>" );
        }
        else
        {
            reticle = var_97583be6d9e8af07[ retint ];
            player dropitem( weapon );
            weapon = weapon getnoaltweapon();
            weapon = weapon withreticle( reticle );
            player inventory_utility::_giveweapon( weapon );
            player setweaponammoclip( weapon, weaponclipsize( weapon ) );
            player setweaponammostock( weapon, weaponmaxammo( weapon ) );
            player inventory_utility::_switchtoweaponimmediate( weapon );
        }
        
        setdevdvar( @"hash_463624d11608d0dc", -1 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf79530fc, Offset: 0x10fc0
    // Size: 0xc2, Type: dev
    function function_4987b5c2af52a59c()
    {
        var_5d8cc93233d1451a = level.players[ 0 ] getcurrentweapon();
        
        foreach ( player in level.players )
        {
            if ( player != level.players[ 0 ] )
            {
                player giveweapon( var_5d8cc93233d1451a );
                player switchtoweaponimmediate( var_5d8cc93233d1451a );
            }
        }
        
        setdevdvar( @"hash_29944a1d8da3e755", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc1d0a35, Offset: 0x1108a
    // Size: 0xb2, Type: dev
    function function_b9a9a38a2753bde2()
    {
        slot = getdvarint( @"hash_28e2b3251abc4817" );
        setdevdvar( @"hash_28e2b3251abc4817", "<dev string:x2f4>" );
        player = level.players[ 0 ];
        currentweapon = player.currentweapon;
        newweapon = currentweapon clearsticker( slot - 1 );
        player dropitem( currentweapon );
        player inventory_utility::_giveweapon( newweapon );
        player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
        player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
        player inventory_utility::_switchtoweaponimmediate( newweapon );
        weapon::fixupplayerweapons( player, newweapon );
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x3483eda1, Offset: 0x11144
    // Size: 0x9b, Type: dev
    function function_d1223930907e4e99( slotindex, material )
    {
        player = level.players[ 0 ];
        currentweapon = player.currentweapon;
        newweapon = currentweapon setsticker( slotindex, material );
        player dropitem( currentweapon );
        player inventory_utility::_giveweapon( newweapon );
        player setweaponammoclip( newweapon, weaponclipsize( newweapon ) );
        player setweaponammostock( newweapon, weaponmaxammo( newweapon ) );
        player inventory_utility::_switchtoweaponimmediate( newweapon );
        weapon::fixupplayerweapons( player, newweapon );
        return newweapon;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe2ad3483, Offset: 0x111e7
    // Size: 0x60, Type: dev
    function function_6c926dcdc5c6fb78()
    {
        material = getdvar( @"hash_8de4ac9450b61777" );
        setdevdvar( @"hash_8de4ac9450b61777", "<dev string:x2f4>" );
        newweapon = function_d1223930907e4e99( 0, material );
        iprintlnbold( "<dev string:x16b3>" + newweapon.stickerslot0 + "<dev string:x16d7>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xca355ae, Offset: 0x1124f
    // Size: 0x61, Type: dev
    function function_6c9270cdc5c70211()
    {
        material = getdvar( @"hash_8de4ad9450b619aa" );
        setdevdvar( @"hash_8de4ad9450b619aa", "<dev string:x2f4>" );
        newweapon = function_d1223930907e4e99( 1, material );
        iprintlnbold( "<dev string:x16d9>" + newweapon.stickerslot1 + "<dev string:x16d7>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe2ad3481, Offset: 0x112b8
    // Size: 0x61, Type: dev
    function function_6c926fcdc5c6ffde()
    {
        material = getdvar( @"hash_8de4ae9450b61bdd" );
        setdevdvar( @"hash_8de4ae9450b61bdd", "<dev string:x2f4>" );
        newweapon = function_d1223930907e4e99( 2, material );
        iprintlnbold( "<dev string:x16fd>" + newweapon.stickerslot2 + "<dev string:x16d7>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbce91b5, Offset: 0x11321
    // Size: 0x61, Type: dev
    function function_6c9272cdc5c70677()
    {
        material = getdvar( @"hash_8de4a79450b60c78" );
        setdevdvar( @"hash_8de4a79450b60c78", "<dev string:x2f4>" );
        newweapon = function_d1223930907e4e99( 3, material );
        iprintlnbold( "<dev string:x1721>" + newweapon.stickerslot3 + "<dev string:x16d7>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe2ad3487, Offset: 0x1138a
    // Size: 0x61, Type: dev
    function function_6c9271cdc5c70444()
    {
        material = getdvar( @"hash_8de4a89450b60eab" );
        setdevdvar( @"hash_8de4a89450b60eab", "<dev string:x2f4>" );
        newweapon = function_d1223930907e4e99( 4, material );
        iprintlnbold( "<dev string:x1745>" + newweapon.var_73762c7cb8b2063 + "<dev string:x16d7>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x70e91d39, Offset: 0x113f3
    // Size: 0x93, Type: dev
    function function_d2c71ed27c34de1c()
    {
        setdevdvar( @"scr_print_player_index", 0 );
        
        foreach ( index, player in level.players )
        {
            player iprintlnbold( "<dev string:x1769>" + index );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x86ae87, Offset: 0x1148e
    // Size: 0x33f, Type: dev
    function function_87dce2a4711a2aa1()
    {
        reactive = getdvar( @"scr_operator_reactive" );
        var_6b6085908e270ffa = getdvarint( @"scr_operator_skin_target" );
        setdevdvar( @"scr_operator_reactive", "<dev string:x2f4>" );
        
        if ( level.var_f773cf0e91e2a6b0 )
        {
            return;
        }
        
        if ( var_6b6085908e270ffa == 3 )
        {
            targetindex = getdvarint( @"scr_operator_skin_target_index", 0 );
            
            if ( !isdefined( level.players[ targetindex ] ) )
            {
                return;
            }
            
            targetplayer = level.players[ targetindex ];
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player ishost() )
                {
                    level.hostplayer = player;
                }
            }
            
            assert( isdefined( level.hostplayer ), "<dev string:x1778>" );
            targetplayer = level.hostplayer;
            
            switch ( var_6b6085908e270ffa )
            {
                case 0:
                    break;
                case 1:
                case 2:
                    mindist = 0;
                    
                    if ( level.players.size > 1 )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player == level.hostplayer )
                            {
                                continue;
                            }
                            
                            dist = distancesquared( player.origin, level.hostplayer.origin );
                            
                            if ( mindist == 0 )
                            {
                                mindist = dist;
                                targetplayer = player;
                                continue;
                            }
                            
                            if ( mindist > dist )
                            {
                                mindist = dist;
                                targetplayer = player;
                            }
                        }
                    }
                    else
                    {
                        setdevdvar( @"hash_169df099a285d3e6", 1 );
                        setdevdvar( @"bot_notarget", 1 );
                        setdevdvar( @"hash_12d23346fbacee91", 1 );
                        setdvar( @"dev_spawnbots", 1 );
                        level.var_f773cf0e91e2a6b0 = 1;
                        level waittill( #"player_spawned", targetplayer );
                        level.var_f773cf0e91e2a6b0 = 0;
                    }
                    
                    break;
            }
            
            if ( var_6b6085908e270ffa == 2 )
            {
                targetangles = level.hostplayer getplayerangles();
                forward = anglestoforward( targetangles );
                warporigin = level.hostplayer.origin + forward * 100;
                targetplayer setorigin( getclosestpointonnavmesh( warporigin ) );
                targetplayer setplayerangles( targetangles + ( 0, 180, 0 ) );
            }
        }
        
        function_2bd28a7bc643a604( targetplayer, reactive );
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xcf561d98, Offset: 0x117d5
    // Size: 0x8a, Type: dev
    function function_2bd28a7bc643a604( player, reactive )
    {
        player player::_setsuit( player.operatorcustomization.suit );
        player.operatorcustomization.reactiveoperator = reactive;
        player function_184d7ec010cfaa92( player.operatorcustomization.reactiveoperator );
        println( "<dev string:x17b5>" + player.operatorcustomization.reactiveoperator );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb4a94605, Offset: 0x11867
    // Size: 0xe2, Type: dev
    function function_c3f641fc7f34a06a()
    {
        contrail = getdvar( @"scr_operator_contrail" );
        setdevdvar( @"scr_operator_contrail", "<dev string:x2f4>" );
        
        if ( contrail == "<dev string:x2ef>" )
        {
            contrail = "<dev string:x2f4>";
        }
        
        contrailhash = getxhashasset( contrail );
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                player setcontrail( contrailhash );
                break;
            }
        }
        
        println( "<dev string:x17cd>" + contrail );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd8fbeaac, Offset: 0x11951
    // Size: 0x343, Type: dev
    function function_b0822849b127b3c7()
    {
        skin = getxhashasset( getdvar( @"scr_operator_skin" ) );
        var_6b6085908e270ffa = getdvarint( @"scr_operator_skin_target" );
        setdevdvar( @"scr_operator_skin", "<dev string:x2f4>" );
        
        if ( level.var_f773cf0e91e2a6b0 )
        {
            return;
        }
        
        if ( var_6b6085908e270ffa == 3 )
        {
            targetindex = getdvarint( @"scr_operator_skin_target_index", 0 );
            
            if ( !isdefined( level.players[ targetindex ] ) )
            {
                return;
            }
            
            targetplayer = level.players[ targetindex ];
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player ishost() )
                {
                    level.hostplayer = player;
                }
            }
            
            assert( isdefined( level.hostplayer ), "<dev string:x1778>" );
            targetplayer = level.hostplayer;
            
            switch ( var_6b6085908e270ffa )
            {
                case 0:
                    break;
                case 1:
                case 2:
                    mindist = 0;
                    
                    if ( level.players.size > 1 )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player == level.hostplayer )
                            {
                                continue;
                            }
                            
                            dist = distancesquared( player.origin, level.hostplayer.origin );
                            
                            if ( mindist == 0 )
                            {
                                mindist = dist;
                                targetplayer = player;
                                continue;
                            }
                            
                            if ( mindist > dist )
                            {
                                mindist = dist;
                                targetplayer = player;
                            }
                        }
                    }
                    else
                    {
                        setdevdvar( @"hash_169df099a285d3e6", 1 );
                        setdevdvar( @"bot_notarget", 1 );
                        setdevdvar( @"hash_12d23346fbacee91", 1 );
                        setdvar( @"dev_spawnbots", 1 );
                        level.var_f773cf0e91e2a6b0 = 1;
                        level waittill( #"player_spawned", targetplayer );
                        level.var_f773cf0e91e2a6b0 = 0;
                    }
                    
                    break;
            }
            
            if ( var_6b6085908e270ffa == 2 )
            {
                targetangles = level.hostplayer getplayerangles();
                forward = anglestoforward( targetangles );
                warporigin = level.hostplayer.origin + forward * 100;
                targetplayer setorigin( getclosestpointonnavmesh( warporigin ) );
                targetplayer setplayerangles( targetangles + ( 0, 180, 0 ) );
            }
        }
        
        function_7620e0b2c7508d1e( targetplayer, skin );
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xc0b57219, Offset: 0x11c9c
    // Size: 0x512, Type: dev
    function function_7620e0b2c7508d1e( player, skin )
    {
        assert( isxhashasset( skin ), "<dev string:x17e5>" );
        operator = operator::function_30f20ce375c4ee40( skin );
        
        if ( !isdefined( operator ) )
        {
            iprintlnbold( "<dev string:x181d>" + skin + "<dev string:xfa5>" );
            return;
        }
        
        player operator::createoperatorcustomization( operator, skin );
        player utility::callsharedfunc( #"bodysize", #"hash_9199843bbf95cbf8" );
        gender = operator::getoperatorgender( operator );
        clothtype = operator::function_b1788ccf1b3c0ae9( skin );
        geartype = operator::function_d633420b529828e8( skin );
        player player::_setsuit( player.operatorcustomization.suit, 1 );
        
        if ( isdefined( player.operatorcustomization.reactiveoperator ) && player.operatorcustomization.reactiveoperator != "<dev string:x2f4>" )
        {
            player function_184d7ec010cfaa92( player.operatorcustomization.reactiveoperator );
        }
        
        player notify( #"set_operator" );
        
        if ( gender == "<dev string:x1844>" )
        {
            player setclientgender( "<dev string:x1844>" );
            player.operatorcustomization.gender = "<dev string:x1844>";
        }
        else
        {
            player setclientgender( "<dev string:x2f4>" );
            player.operatorcustomization.gender = "<dev string:x184b>";
        }
        
        if ( isdefined( clothtype ) && clothtype != "<dev string:x2f4>" )
        {
            if ( player.operatorcustomization.clothtype == clothtype )
            {
            }
            
            if ( !isdefined( player.operatorcustomization ) )
            {
                player.operatorcustomization = "<dev string:x2f4>";
            }
            
            if ( !isdefined( player.operatorcustomization.clothtype ) )
            {
                player.operatorcustomization.clothtype = "<dev string:x2f4>";
            }
            
            if ( isdefined( player.operatorcustomization.clothtype ) && player.operatorcustomization.clothtype != clothtype )
            {
                player.operatorcustomization.clothtype = clothtype;
                
                foreach ( _player in level.players )
                {
                    _player setclothtype( getxhash( clothtype ) );
                }
            }
        }
        else
        {
            foreach ( _player in level.players )
            {
                _player setclothtype( #"vestlight" );
            }
        }
        
        if ( isdefined( geartype ) && geartype != "<dev string:x2f4>" )
        {
            if ( player.operatorcustomization.geartype == geartype )
            {
            }
            
            if ( !isdefined( player.operatorcustomization ) )
            {
                player.operatorcustomization = "<dev string:x2f4>";
            }
            
            if ( !isdefined( player.operatorcustomization.geartype ) )
            {
                player.operatorcustomization.geartype = "<dev string:x2f4>";
            }
            
            if ( isdefined( player.operatorcustomization.geartype ) && player.operatorcustomization.geartype != geartype )
            {
                player.operatorcustomization.geartype = geartype;
                
                foreach ( _player in level.players )
                {
                    _player setgeartype( getxhash( geartype ) );
                }
            }
        }
        else
        {
            foreach ( _player in level.players )
            {
                _player setgeartype( #"millghtgr" );
            }
        }
        
        player function_223c4fc6696d52a7();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf55e60f, Offset: 0x121b6
    // Size: 0x185, Type: dev
    function gui_setclothtype()
    {
        clothtype = getdvar( @"scr_setclothtype" );
        setdevdvar( @"scr_setclothtype", "<dev string:x2f4>" );
        player = level.players[ 0 ];
        
        if ( isdefined( clothtype ) && clothtype != "<dev string:x2f4>" )
        {
            if ( player.operatorcustomization.clothtype == clothtype )
            {
            }
            
            if ( !isdefined( player.operatorcustomization ) )
            {
                player.operatorcustomization = "<dev string:x2f4>";
            }
            
            if ( !isdefined( player.operatorcustomization.clothtype ) )
            {
                player.operatorcustomization.clothtype = "<dev string:x2f4>";
            }
            
            if ( isdefined( player.operatorcustomization.clothtype ) && player.operatorcustomization.clothtype != clothtype )
            {
                player.operatorcustomization.clothtype = clothtype;
                
                foreach ( player in level.players )
                {
                    player setclothtype( getxhash( clothtype ) );
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xebe34c62, Offset: 0x12343
    // Size: 0x185, Type: dev
    function gui_setgeartype()
    {
        geartype = getdvar( @"scr_setgeartype" );
        setdevdvar( @"scr_setgeartype", "<dev string:x2f4>" );
        player = level.players[ 0 ];
        
        if ( isdefined( geartype ) && geartype != "<dev string:x2f4>" )
        {
            if ( player.operatorcustomization.geartype == geartype )
            {
            }
            
            if ( !isdefined( player.operatorcustomization ) )
            {
                player.operatorcustomization = "<dev string:x2f4>";
            }
            
            if ( !isdefined( player.operatorcustomization.geartype ) )
            {
                player.operatorcustomization.geartype = "<dev string:x2f4>";
            }
            
            if ( isdefined( player.operatorcustomization.geartype ) && player.operatorcustomization.geartype != geartype )
            {
                player.operatorcustomization.geartype = geartype;
                
                foreach ( player in level.players )
                {
                    player setgeartype( getxhash( geartype ) );
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4f95f74, Offset: 0x124d0
    // Size: 0x185, Type: dev
    function gui_setbagtype()
    {
        bagtype = getdvar( @"scr_setbagtype" );
        setdevdvar( @"scr_setbagtype", "<dev string:x2f4>" );
        player = level.players[ 0 ];
        
        if ( isdefined( bagtype ) && bagtype != "<dev string:x2f4>" )
        {
            if ( player.operatorcustomization.bagtype == bagtype )
            {
            }
            
            if ( !isdefined( player.operatorcustomization ) )
            {
                player.operatorcustomization = "<dev string:x2f4>";
            }
            
            if ( !isdefined( player.operatorcustomization.bagtype ) )
            {
                player.operatorcustomization.bagtype = "<dev string:x2f4>";
            }
            
            if ( isdefined( player.operatorcustomization.bagtype ) && player.operatorcustomization.bagtype != bagtype )
            {
                player.operatorcustomization.bagtype = bagtype;
                
                foreach ( player in level.players )
                {
                    player setbagtype( getxhash( bagtype ) );
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x73f360ed, Offset: 0x1265d
    // Size: 0x20, Type: dev
    function function_b63f974a2e8d48b0()
    {
        level notify( #"lodtest" );
        setdevdvar( @"hash_efa2254b31f42841", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xead6f87b, Offset: 0x12685
    // Size: 0x20, Type: dev
    function function_5757fd27d0ed350f()
    {
        level notify( #"hash_94f506afc67cfd9f" );
        setdevdvar( @"hash_ac65f9192e2efd0", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x22f260d, Offset: 0x126ad
    // Size: 0x20, Type: dev
    function function_de262db5fb407404()
    {
        level notify( #"hash_8b2a5027272e0f94" );
        setdevdvar( @"hash_f8168febda35ecc7", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7879a7f, Offset: 0x126d5
    // Size: 0x20, Type: dev
    function function_2bfd2009f778e48f()
    {
        level notify( #"hash_53de741bdb15bc9f" );
        setdevdvar( @"hash_c70eda82dc2d8ce0", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5ca4d2be, Offset: 0x126fd
    // Size: 0x2a4, Type: dev
    function function_d1537369904fbc1c()
    {
        setdevdvar( @"hash_76509eeacc4eb3b", "<dev string:x2f4>" );
        var_fc0df267d39d17f0 = [];
        
        foreach ( root, struct in level.weaponmapdata )
        {
            assetname = weapon::weaponassetnamemap( root );
            obj = makeweapon( assetname );
            
            if ( !weapon::isprimaryweapon( obj ) )
            {
                continue;
            }
            
            group = weapon::getweapongroup( assetname );
            attachments = weapon::getallselectableattachments( assetname );
            
            if ( !isdefined( var_fc0df267d39d17f0[ group ] ) )
            {
                var_fc0df267d39d17f0[ group ] = [];
            }
            
            foreach ( a in attachments )
            {
                if ( !arraycontains( var_fc0df267d39d17f0[ group ], a ) )
                {
                    var_fc0df267d39d17f0[ group ][ var_fc0df267d39d17f0[ group ].size ] = a;
                }
            }
        }
        
        foreach ( root, struct in level.weaponmapdata )
        {
            assetname = weapon::weaponassetnamemap( root );
            obj = makeweapon( assetname );
            
            if ( !weapon::isprimaryweapon( obj ) )
            {
                continue;
            }
            
            print( "<dev string:x1850>" + assetname + "<dev string:x1883>" );
            group = weapon::getweapongroup( assetname );
            attachments = weapon::getallselectableattachments( assetname );
            
            foreach ( a in var_fc0df267d39d17f0[ group ] )
            {
                if ( !arraycontains( attachments, a ) )
                {
                    print( "<dev string:x189a>" + a + "<dev string:xfa5>" );
                }
            }
            
            print( "<dev string:x18c3>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa6338a2b, Offset: 0x129a9
    // Size: 0x133, Type: dev
    function function_739cdb7ff393bbc9()
    {
        chroma = getdvar( @"hash_49e7d6f989610e4c" );
        
        if ( !isdefined( chroma ) )
        {
            return;
        }
        
        isvalidchroma = chroma != "<dev string:x2f4>" && chroma != "<dev string:x2ef>";
        chromahash = getxhashasset( chroma );
        
        foreach ( player in level.players )
        {
            weapon = player.currentweapon;
            
            if ( isvalidchroma )
            {
                weapon = weapon withchroma( chromahash );
            }
            else
            {
                weapon = weapon withoutchroma();
            }
            
            player inventory_utility::_giveweapon( weapon );
            player setweaponammoclip( weapon, weaponclipsize( weapon ) );
            player setweaponammostock( weapon, weaponmaxammo( weapon ) );
            player inventory_utility::_switchtoweaponimmediate( weapon );
        }
        
        setdevdvar( @"hash_49e7d6f989610e4c", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x57b156b6, Offset: 0x12ae4
    // Size: 0x103, Type: dev
    function function_146d0b59d95b78c9()
    {
        chroma = getdvar( @"hash_4434b2fec517d0dc" );
        
        if ( !isdefined( chroma ) || level.projectbundle.var_672cd1b066200001 )
        {
            return;
        }
        
        isvalidchroma = chroma != "<dev string:x2f4>" && chroma != "<dev string:x2ef>";
        chromahash = getxhashasset( chroma );
        
        foreach ( player in level.players )
        {
            if ( isvalidchroma )
            {
                player setoperatorchroma( chromahash );
                continue;
            }
            
            player setoperatorchroma();
        }
        
        setdevdvar( @"hash_4434b2fec517d0dc", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x74be6ada, Offset: 0x12bef
    // Size: 0xdd, Type: dev
    function function_60493baa8536364e()
    {
        parachute = getdvar( @"hash_1b5bb10f6c906c49" );
        
        if ( !isdefined( parachute ) )
        {
            return;
        }
        
        if ( parachute == "<dev string:x2ef>" )
        {
            parachute = "<dev string:x2f4>";
        }
        
        parachutehash = getxhashasset( parachute );
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                player setparachute( parachutehash );
                break;
            }
        }
        
        setdevdvar( @"hash_1b5bb10f6c906c49", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 7
    // Checksum 0xdae4c263, Offset: 0x12cd4
    // Size: 0x226, Type: dev
    function createweaponstruct( rarity, weaponroot, var_ab8723715e75f866, weaponname, var_b058292aa5af23a9, locdesc, icon )
    {
        struct = spawnstruct();
        struct.item = "<dev string:x1908>";
        struct.blank_0 = "<dev string:x2f4>";
        struct.type = "<dev string:x190d>";
        struct.rarity = string( rarity );
        struct.blank_1 = "<dev string:x2f4>";
        struct.blank_2 = "<dev string:x2f4>";
        struct.blank_3 = "<dev string:x2f4>";
        struct.blank_4 = "<dev string:x2f4>";
        struct.weaponroot = weaponroot;
        struct.blank_5 = "<dev string:x2f4>";
        struct.attachments = "<dev string:x2f4>";
        
        foreach ( key, aid in var_ab8723715e75f866 )
        {
            if ( struct.attachments != "<dev string:x2f4>" )
            {
                struct.attachments += "<dev string:x424>";
            }
            
            struct.attachments += key;
            
            if ( int( aid ) > 0 )
            {
                struct.attachments += "<dev string:x15c2>" + aid;
            }
        }
        
        struct.weaponname = weaponname;
        struct.var_b058292aa5af23a9 = var_b058292aa5af23a9;
        struct.locdesc = locdesc;
        struct.icon = icon;
        return struct;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x3c19140a, Offset: 0x12f02
    // Size: 0x117, Type: dev
    function function_2f24708df91414e2( s )
    {
        return s.item + "<dev string:x2da>" + s.blank_0 + "<dev string:x2da>" + s.type + "<dev string:x2da>" + s.rarity + "<dev string:x2da>" + s.blank_1 + "<dev string:x2da>" + s.blank_2 + "<dev string:x2da>" + s.blank_3 + "<dev string:x2da>" + s.blank_4 + "<dev string:x2da>" + s.weaponroot + "<dev string:x2da>" + s.blank_5 + "<dev string:x2da>" + s.attachments + "<dev string:x2da>" + s.weaponname + "<dev string:x2da>" + s.var_b058292aa5af23a9 + "<dev string:x2da>" + s.locdesc + "<dev string:x2da>" + s.icon;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3f47700a, Offset: 0x13021
    // Size: 0xeb, Type: dev
    function function_e163d05fa967867b()
    {
        grenade = getdvar( @"hash_1da69ba9e35c8ea0" );
        
        if ( isdefined( grenade ) )
        {
            playerarray = function_ffe8acaa84c63e12();
            
            foreach ( player in playerarray )
            {
                if ( isbot( player ) )
                {
                    continue;
                }
                
                player equipment_mp::clearallequipment();
                player giveweapon( grenade );
                player assignweaponoffhandprimary( grenade );
                player givemaxammo( grenade );
                setdevdvar( @"player_sustainammo", 1 );
            }
        }
        
        setdevdvar( @"hash_1da69ba9e35c8ea0", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x42296e77, Offset: 0x13114
    // Size: 0xf2, Type: dev
    function gui_givegesture()
    {
        gesture = getdvar( @"scr_givegesture" );
        
        if ( gesture )
        {
            foreach ( player in level.players )
            {
                if ( player ishost() )
                {
                    iprintlnbold( "<dev string:x1914>" + gesture );
                    
                    if ( !isdefined( player.selectedgesture ) )
                    {
                        player.selectedgesture = gesture;
                        player thread function_9dde6451f82bd34b();
                        continue;
                    }
                    
                    player.selectedgesture = gesture;
                }
            }
        }
        
        setdevdvar( @"scr_givegesture", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2ad5524d, Offset: 0x1320e
    // Size: 0x1b2, Type: dev
    function gui_giveexecution()
    {
        execution = getdvar( @"scr_giveexecution" );
        
        if ( execution )
        {
            var_51443246b5df7ad7 = level.var_ceefa46f8106bbca.entnum ?? -1;
            
            foreach ( player in level.players )
            {
                if ( var_51443246b5df7ad7 == -1 || var_51443246b5df7ad7 == player getentitynumber() )
                {
                    player clearexecution();
                    
                    foreach ( weapon in player.equippedweapons )
                    {
                        if ( issubstr( weapon.basename, "<dev string:x1927>" ) )
                        {
                            player takeweapon( weapon );
                        }
                    }
                    
                    player execution::_giveexecution( execution );
                    player.operatorcustomization.execution = player.executionref;
                    player mtx_weapon::function_bb6fc6aabe552b3b();
                    iprintlnbold( "<dev string:x1933>" + execution );
                }
            }
        }
        
        setdevdvar( @"scr_giveexecution", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x687e6f67, Offset: 0x133c8
    // Size: 0x1b5, Type: dev
    function function_6087efc6af1b20e0()
    {
        debugweapon = getdvar( @"hash_cfc446de878b0ee3" );
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                if ( isdefined( player.executionref ) )
                {
                    player clearexecution();
                    
                    foreach ( weapon in player.equippedweapons )
                    {
                        if ( issubstr( weapon.basename, "<dev string:x1947>" ) || issubstr( weapon.basename, "<dev string:x1956>" ) )
                        {
                            player takeweapon( weapon );
                        }
                    }
                }
                
                if ( isdefined( debugweapon ) )
                {
                    player giveweapon( debugweapon );
                    player giveexecution( execution::execution_getexecutionbyref( player.executionref ), debugweapon );
                }
                else
                {
                    player giveexecution( execution::execution_getexecutionbyref( player.executionref ) );
                }
                
                iprintlnbold( "<dev string:x1965>" + debugweapon );
            }
        }
        
        setdevdvar( @"hash_cfc446de878b0ee3", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x89e208a1, Offset: 0x13585
    // Size: 0x239, Type: dev
    function gui_dropweapon()
    {
        weaponbasename = getdvar( @"scr_dropweapon" );
        var_946c136ddeddf7d8 = getdvarint( @"scr_dropweapon_attachments", 0 );
        attachdictionary = [];
        attachlist = [];
        numattachments = 0;
        
        if ( var_946c136ddeddf7d8 > 0 )
        {
            csvfilename = "<dev string:x1980>" + getsubstr( weapon::getweaponrootname( weaponbasename ), 4 ) + "<dev string:x198d>";
            row = -1;
            
            while ( true )
            {
                row++;
                category = tablelookupbyrow( csvfilename, row, 1 );
                
                if ( !isdefined( category ) || category == "<dev string:x2f4>" )
                {
                    break;
                }
                
                if ( isdefined( attachdictionary[ category ] ) || category == "<dev string:x199e>" )
                {
                    continue;
                }
                
                attachdictionary[ category ] = tablelookupbyrow( csvfilename, row, 0 );
                numattachments++;
                
                if ( numattachments >= var_946c136ddeddf7d8 )
                {
                    break;
                }
            }
            
            foreach ( attachment in attachdictionary )
            {
                attachlist[ attachlist.size ] = attachment;
            }
        }
        
        weaponobj = weapon::buildweapon( weapon::getweaponrootname( weaponbasename ), attachlist, "<dev string:x19a3>", "<dev string:x2ef>", -1 );
        
        foreach ( player in level.players )
        {
            player inventory_utility::_giveweapon( weaponobj );
            player.droppeddeathweapon = undefined;
            player weapons::dropweaponfordeath( undefined, "<dev string:x2f4>", weaponobj );
            player.droppeddeathweapon = undefined;
        }
        
        setdevdvar( @"scr_dropweapon", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xec749c2e, Offset: 0x137c6
    // Size: 0x236, Type: dev
    function gui_dropammo()
    {
        ammodrop = getdvarint( @"scr_dropammo", -1 );
        
        if ( isdefined( ammodrop ) )
        {
            foreach ( player in level.players )
            {
                if ( ammodrop <= 4 )
                {
                    if ( player ishost() )
                    {
                        if ( isdefined( player.currentweapon ) )
                        {
                            if ( ammodrop == 0 )
                            {
                                player setweaponammoclip( player.currentweapon, 1 );
                            }
                            else if ( ammodrop == 1 )
                            {
                                player setweaponammostock( player.currentweapon, 1 );
                            }
                            else if ( ammodrop == 2 )
                            {
                                player setweaponammoclip( player.currentweapon, 0 );
                            }
                            else if ( ammodrop == 3 )
                            {
                                player setweaponammostock( player.currentweapon, 0 );
                            }
                            else if ( ammodrop == 4 )
                            {
                                player setweaponammoclip( player.currentweapon, 0 );
                                player setweaponammostock( player.currentweapon, 0 );
                            }
                        }
                    }
                    
                    continue;
                }
                
                if ( ammodrop > 4 && ammodrop <= 9 )
                {
                    if ( isdefined( player.currentweapon ) )
                    {
                        if ( ammodrop == 5 )
                        {
                            player setweaponammoclip( player.currentweapon, 1 );
                            continue;
                        }
                        
                        if ( ammodrop == 6 )
                        {
                            player setweaponammostock( player.currentweapon, 1 );
                            continue;
                        }
                        
                        if ( ammodrop == 7 )
                        {
                            player setweaponammoclip( player.currentweapon, 0 );
                            continue;
                        }
                        
                        if ( ammodrop == 8 )
                        {
                            player setweaponammostock( player.currentweapon, 0 );
                            continue;
                        }
                        
                        if ( ammodrop == 9 )
                        {
                            player setweaponammoclip( player.currentweapon, 0 );
                            player setweaponammostock( player.currentweapon, 0 );
                        }
                    }
                }
            }
        }
        
        setdevdvar( @"scr_dropammo", -1 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x25646641, Offset: 0x13a04
    // Size: 0x4a, Type: dev
    function function_9dde6451f82bd34b()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            if ( self buttonpressed( "<dev string:x19ad>" ) )
            {
                self giveandfireoffhand( self.selectedgesture );
                wait 1;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6b199a0e, Offset: 0x13a56
    // Size: 0x70, Type: dev
    function watchnoclip()
    {
        if ( game_utility_mp::lpcfeaturegated() )
        {
            return;
        }
        
        level waittill( #"player_spawned", player );
        
        if ( !isbot( player ) && !istestclient( player ) )
        {
            player notifyonplayercommand( "<dev string:x19b5>", "<dev string:x19c4>" );
            player notifyonplayercommand( "<dev string:x19d3>", "<dev string:xa08>" );
            player thread playernoclip();
        }
        
        level thread watchnoclip();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x36056ce, Offset: 0x13ace
    // Size: 0x88, Type: dev
    function playernoclip()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        self.var_14dd797c8083bb19 = 0;
        self.var_ae701a31f0506bdd = 0;
        
        if ( !game_utility_mp::lpcfeaturegated() )
        {
            thread function_5a153d589702c4f1();
            thread function_95ed9bbda2fcb965();
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_4888f3f38913205f" ) > 0 )
            {
                if ( self.var_14dd797c8083bb19 && self.var_ae701a31f0506bdd )
                {
                    self noclip();
                }
            }
            
            wait 0.2;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x26d2d4f4, Offset: 0x13b5e
    // Size: 0x4d, Type: dev
    function function_5a153d589702c4f1()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"hash_dde2100615754753" );
            self.var_14dd797c8083bb19 = 1;
            wait 0.2;
            self.var_14dd797c8083bb19 = 0;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfe4310f4, Offset: 0x13bb3
    // Size: 0x4d, Type: dev
    function function_95ed9bbda2fcb965()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"dpad_down_noclip" );
            self.var_ae701a31f0506bdd = 1;
            wait 0.2;
            self.var_ae701a31f0506bdd = 0;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2c4f7989, Offset: 0x13c08
    // Size: 0x8f, Type: dev
    function watchufo()
    {
        level waittill( #"player_spawned", player );
        
        if ( isdefined( player ) && !isbot( player ) && !istestclient( player ) )
        {
            player notifyonplayercommand( "<dev string:x19e4>", "<dev string:x19c4>" );
            player notifyonplayercommand( "<dev string:x19f0>", "<dev string:x9ea>" );
            player notifyonplayercommand( "<dev string:x19fc>", "<dev string:xa3e>" );
            player notifyonplayercommand( "<dev string:x1a03>", "<dev string:x1a0a>" );
            player thread playerufo();
        }
        
        level thread watchufo();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xba03c853, Offset: 0x13c9f
    // Size: 0xfa, Type: dev
    function function_67591ac520f1a7b6()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"hash_c603288fc25b5a7b" );
            
            if ( getdvarint( @"scr_ufo" ) > 0 )
            {
                contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 0 );
                shotdir = anglestoforward( self getplayerangles() );
                endpos = self geteye() + shotdir * 90000;
                var_51967c121bcf18a3 = physics_raycast( self geteye(), endpos, contents, undefined, 0, "<dev string:x1d9>", 0 );
                hit = var_51967c121bcf18a3.size > 0;
                
                if ( hit )
                {
                    hitpos = var_51967c121bcf18a3[ 0 ][ "<dev string:x236>" ];
                    println( string( hitpos ) + "<dev string:x3f8>" + ( 0, self getplayerangles()[ 1 ], 0 ) + "<dev string:x3f8>" );
                }
                
                wait 0.2;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2eb8ffae, Offset: 0x13da1
    // Size: 0x72, Type: dev
    function function_5f745916013ed260()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"hash_c9f933202bdcaeb9" );
            
            if ( getdvarint( @"scr_ufo" ) > 0 )
            {
                println( "<dev string:x2f4>" + self geteye() + "<dev string:x3f8>" + ( 0, self getplayerangles()[ 1 ], 0 ) + "<dev string:x3f8>" );
                wait 0.2;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x95b73a33, Offset: 0x13e1b
    // Size: 0x96, Type: dev
    function playerufo()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        if ( game_utility_mp::lpcfeaturegated() )
        {
            return;
        }
        
        self.var_168e2c0c287b84e6 = 0;
        self.var_a372d7ff4ba6336e = 0;
        thread function_cbf2be8cfbe8307e();
        thread function_6f61e8c452f5996();
        thread function_67591ac520f1a7b6();
        thread function_5f745916013ed260();
        
        while ( true )
        {
            if ( getdvarint( @"hash_2a77b8dc84093d22" ) > 0 )
            {
                if ( self.var_168e2c0c287b84e6 && self.var_a372d7ff4ba6336e )
                {
                    self ufo();
                }
            }
            
            wait 0.2;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x26082be8, Offset: 0x13eb9
    // Size: 0x4d, Type: dev
    function function_cbf2be8cfbe8307e()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"hash_ecefb2a484ad6dbe" );
            self.var_168e2c0c287b84e6 = 1;
            wait 0.2;
            self.var_168e2c0c287b84e6 = 0;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa45d1895, Offset: 0x13f0e
    // Size: 0x4d, Type: dev
    function function_6f61e8c452f5996()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"faux_spawn" );
        
        while ( true )
        {
            self waittill( #"dpad_up_ufo" );
            self.var_a372d7ff4ba6336e = 1;
            wait 0.2;
            self.var_a372d7ff4ba6336e = 0;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x96cf15fd, Offset: 0x13f63
    // Size: 0xf3, Type: dev
    function printperks()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_printperks" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && getdvarint( @"scr_printperks" ) != 2 || !isbot( player ) && getdvarint( @"scr_printperks" ) != 1 )
            {
                continue;
            }
            
            player printperks_player();
        }
        
        setdevdvar( @"scr_printperks", 0 );
        thread printperks();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf4554634, Offset: 0x1405e
    // Size: 0x27a, Type: dev
    function printperks_player()
    {
        count = function_bbf6e69e91013c42();
        println( "<dev string:x1a13>" + self.name + "<dev string:x1a29>" + count + "<dev string:x1a33>" );
        
        foreach ( perk, variations in self.perks )
        {
            count = 0;
            var_287bb892f315ac91 = "<dev string:x2f4>";
            var_e5700f4bb8ec0330 = function_73fd16aff1e869b7( perk );
            
            foreach ( variation, stacks in variations )
            {
                count += stacks;
                isactive = variation == var_e5700f4bb8ec0330;
                variation = variation == "<dev string:x2f4>" ? "<dev string:x1a38>" : variation;
                var_287bb892f315ac91 += ( isactive ? "<dev string:x1a40>" : "<dev string:x1a49>" ) + "<dev string:x1a54>" + variation + "<dev string:x706>" + stacks + "<dev string:x1a57>";
            }
            
            sval = ( count < 10 ? "<dev string:xa3>" : "<dev string:x2f4>" ) + count;
            println( sval + "<dev string:x1a5b>" + perk + "<dev string:x1a5f>" + var_287bb892f315ac91 );
        }
        
        if ( self.perksblocked.size > 0 )
        {
            println( "<dev string:x1a65>" );
            
            foreach ( perk, value in self.perksblocked )
            {
                sval = ( value < 10 ? "<dev string:xa3>" : "<dev string:x2f4>" ) + value;
                println( sval + "<dev string:x1a5b>" + perk );
            }
        }
        
        println( "<dev string:x1a76>" );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x4a71f259, Offset: 0x142e0
    // Size: 0x5f, Type: dev
    function function_73fd16aff1e869b7( perkname )
    {
        var_a22b8f3431f99dd2 = perks::function_80dd74eda1e2dfc6( perkname );
        
        if ( var_a22b8f3431f99dd2 == 0 )
        {
            return;
        }
        
        if ( var_a22b8f3431f99dd2 == 1 )
        {
            return getfirstarraykey( self.perks[ perkname ] );
        }
        
        if ( perks::function_74d8a2083b4dba89( perkname ) )
        {
            return perks::function_5f3646eb13ddcac4( perkname );
        }
        
        return;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7eeef4cf, Offset: 0x14347
    // Size: 0x89, Type: dev
    function function_dc8b4bf0f53df4dc()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_ba8f8e3054e5584d" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        if ( !isdefined( level.var_9d49592ccfd7d4cc ) )
        {
            level.var_9d49592ccfd7d4cc = 1;
            iprintlnbold( "<dev string:x1a7e>" );
            level thread function_d4565d2946a3c62d();
        }
        else
        {
            iprintlnbold( "<dev string:x1a94>" );
            level notify( #"hash_44dc72c1fa229b93" );
            level.var_9d49592ccfd7d4cc = undefined;
        }
        
        setdevdvar( @"hash_ba8f8e3054e5584d", 0 );
        thread function_dc8b4bf0f53df4dc();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc7d96732, Offset: 0x143d8
    // Size: 0x2e, Type: dev
    function function_d4565d2946a3c62d()
    {
        level endon( #"hash_44dc72c1fa229b93" );
        
        while ( true )
        {
            function_e69c03018c6efcb5();
            level waittill( #"hash_b21f590d1568ec6d" );
            waittillframeend();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x86c95a63, Offset: 0x1440e
    // Size: 0x9f, Type: dev
    function function_e69c03018c6efcb5()
    {
        foreach ( player in level.players )
        {
            count = player function_bbf6e69e91013c42();
            player iprintlnbold( "<dev string:x1aab>" + count );
            player printperks_player();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd3e01bec, Offset: 0x144b5
    // Size: 0xf0, Type: dev
    function function_bbf6e69e91013c42()
    {
        count = 0;
        
        foreach ( variations in self.perks )
        {
            foreach ( stacks in variations )
            {
                count += stacks;
            }
        }
        
        return count;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdbd426a3, Offset: 0x145ad
    // Size: 0x137, Type: dev
    function devgiveperks()
    {
        while ( true )
        {
            if ( getdvar( @"hash_8fcf658de0756ca3", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        perk = getdvar( @"hash_8fcf658de0756ca3" );
        var_4b2b3dc56d37a58 = getdvar( @"scr_giveperk_variation", "<dev string:x2f4>" ) != "<dev string:x2f4>" ? getdvar( @"scr_giveperk_variation" ) : undefined;
        playerarray = function_ffe8acaa84c63e12();
        
        foreach ( player in playerarray )
        {
            player thread perk::giveperk( perk, undefined, var_4b2b3dc56d37a58 );
            player class::function_fcd287e3e2445b46();
        }
        
        setdevdvar( @"hash_8fcf658de0756ca3", "<dev string:x2f4>" );
        setdevdvar( @"scr_giveperk_variation", "<dev string:x2f4>" );
        thread devgiveperks();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfcbad02f, Offset: 0x146ec
    // Size: 0x12c, Type: dev
    function function_c870cca144d9ec12()
    {
        while ( true )
        {
            if ( getdvar( @"hash_57ffa5c3291fa7ca", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        perk = getdvar( @"hash_57ffa5c3291fa7ca" );
        var_4b2b3dc56d37a58 = getdvar( @"scr_removeperk_variation", "<dev string:x2f4>" ) != "<dev string:x2f4>" ? getdvar( @"scr_removeperk_variation" ) : undefined;
        playerarray = function_ffe8acaa84c63e12();
        
        foreach ( player in playerarray )
        {
            player thread perk::removeperk( perk, var_4b2b3dc56d37a58 );
        }
        
        setdevdvar( @"hash_57ffa5c3291fa7ca", "<dev string:x2f4>" );
        setdevdvar( @"scr_removeperk_variation", "<dev string:x2f4>" );
        thread function_c870cca144d9ec12();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbb633f83, Offset: 0x14820
    // Size: 0xb4, Type: dev
    function devclearperks()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_devclearperks" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_devclearperks", 0 );
        
        foreach ( player in level.players )
        {
            player thread class::loadout_clearperks();
        }
        
        thread devclearperks();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe31c4744, Offset: 0x148dc
    // Size: 0x53, Type: dev
    function function_45f0955f21cf32f2()
    {
        while ( true )
        {
            if ( getdvar( @"hash_f0b8c004a14db0a2", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        game[ "<dev string:x1ab8>" ] = 2400;
        setdevdvar( @"hash_f0b8c004a14db0a2", "<dev string:x2f4>" );
        thread function_45f0955f21cf32f2();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7b1bf264, Offset: 0x14937
    // Size: 0xf8, Type: dev
    function devhideviewmodel()
    {
        while ( true )
        {
            if ( getdvar( @"scr_hide_viewmodel", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        val = getdvarint( @"scr_hide_viewmodel" );
        
        if ( val > 0 )
        {
            foreach ( player in level.players )
            {
                player setviewmodel( "<dev string:x1ad5>" );
            }
        }
        else
        {
            setdevdvar( @"scr_operator_skin", "<dev string:x1aea>" );
        }
        
        setdevdvar( @"scr_hide_viewmodel", "<dev string:x2f4>" );
        thread devhideviewmodel();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe31c5ce4, Offset: 0x14a37
    // Size: 0x53, Type: dev
    function function_45f0965f21cf3525()
    {
        while ( true )
        {
            if ( getdvar( @"hash_f0b8c104a14db2d5", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        game[ "<dev string:x1ab8>" ] = 4800;
        setdevdvar( @"hash_f0b8c104a14db2d5", "<dev string:x2f4>" );
        thread function_45f0965f21cf3525();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd60cac5, Offset: 0x14a92
    // Size: 0xb5, Type: dev
    function function_b7a3d1a5adb3e853()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_ed0cf15ec432ad73", 0 ) != 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_ed0cf15ec432ad73", 0 );
        
        foreach ( player in level.players )
        {
            player perkpackage::perkpackage_reset();
        }
        
        thread function_b7a3d1a5adb3e853();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1f347749, Offset: 0x14b4f
    // Size: 0xd6, Type: dev
    function function_1f19b81a419a44fd()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_93721f3cbd6d00c6" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        damageval = getdvarint( @"hash_93721f3cbd6d00c6" );
        notbot = function_2ee13eddfbd7f93c();
        
        if ( damageval >= 100 )
        {
            damageval = notbot.health - 1;
        }
        
        bot = getbot( notbot );
        
        if ( isdefined( bot ) )
        {
            notbot thread [[ level.callbackplayerdamage ]]( bot, bot, damageval, 0, "<dev string:xcbb>", 0, bot.currentweapon, bot.origin, ( 0, 0, 0 ), "<dev string:x2ef>", 0 );
        }
        
        setdevdvar( @"hash_93721f3cbd6d00c6", 0 );
        thread function_1f19b81a419a44fd();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9a930ab8, Offset: 0x14c2d
    // Size: 0x8e, Type: dev
    function function_ef8fe1dea5fc9565()
    {
        var_225eb3a62773eea4 = 0;
        var_225eb3a62773eea4 = utility::callsharedfunc( #"poise", #"hash_2e5810c3ef452673" );
        
        if ( !var_225eb3a62773eea4 )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_abd5695fcd2a7b80" ) > 0 )
            {
                damageval = getdvarint( @"hash_abd5695fcd2a7b80" );
                notbot = function_2ee13eddfbd7f93c();
                notbot poisedamage( damageval );
                setdevdvar( @"hash_abd5695fcd2a7b80", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6ad6feb9, Offset: 0x14cc3
    // Size: 0xb2, Type: dev
    function function_9cae365772b00cc()
    {
        var_225eb3a62773eea4 = 0;
        var_225eb3a62773eea4 = utility::callsharedfunc( #"poise", #"hash_2e5810c3ef452673" );
        
        if ( !var_225eb3a62773eea4 )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_ffe99b9a4de3c827" ) > 0 )
            {
                intensityval = getdvarint( @"hash_ffe99b9a4de3c827" );
                notbot = function_2ee13eddfbd7f93c();
                notbot utility::callsharedfunc( #"poise", #"poiseKnockdown", anglestoforward( notbot.angles ), intensityval );
                setdevdvar( @"hash_ffe99b9a4de3c827", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbcb3d8c3, Offset: 0x14d7d
    // Size: 0x5b, Type: dev
    function function_3cf84678859b3388()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_9e1de20ce2f61ca9" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        notbot.health = 100;
        setdevdvar( @"hash_9e1de20ce2f61ca9", 0 );
        thread function_3cf84678859b3388();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x110cf242, Offset: 0x14de0
    // Size: 0x1e, Type: dev
    function function_f2e859bbe8fce2b3()
    {
        function_e0803501c90a1b5d( 1, @"hash_709fdd5a35e4e984" );
        thread function_f2e859bbe8fce2b3();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1d3fb5ba, Offset: 0x14e06
    // Size: 0x1e, Type: dev
    function function_303f0d0b2b7dbbf2()
    {
        function_520eabca5d8cc968( 1, @"hash_92600bd85913f6" );
        thread function_303f0d0b2b7dbbf2();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf3fdb5fc, Offset: 0x14e2c
    // Size: 0x1d, Type: dev
    function function_ed4c630f7bfcecfa()
    {
        function_e0803501c90a1b5d( 0, @"hash_df48c48bec9a1f6f" );
        thread function_ed4c630f7bfcecfa();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8a63348d, Offset: 0x14e51
    // Size: 0x1d, Type: dev
    function function_9865b5a49824ae7d()
    {
        function_520eabca5d8cc968( 0, @"hash_e2f204ecf18361b1" );
        thread function_9865b5a49824ae7d();
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xb7f0aca8, Offset: 0x14e76
    // Size: 0x1b1, Type: dev
    function function_e0803501c90a1b5d( targetisenemy, hurtdvar )
    {
        while ( true )
        {
            if ( getdvarint( hurtdvar ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        damageval = getdvarint( hurtdvar );
        var_149288e10e7313ab = function_2ee13eddfbd7f93c();
        enemybot = getbot( var_149288e10e7313ab );
        attacker = targetisenemy ? var_149288e10e7313ab : enemybot;
        
        foreach ( player in level.players )
        {
            bot = undefined;
            
            if ( !isbot( player ) && !istestclient( player ) )
            {
                continue;
            }
            
            if ( isdefined( player ) && isdefined( attacker ) )
            {
                if ( level.teambased )
                {
                    if ( player.team != attacker.team )
                    {
                        bot = player;
                    }
                }
                else
                {
                    bot = player;
                }
            }
            
            if ( isdefined( bot ) )
            {
                if ( damageval >= 100 )
                {
                    damageval = bot.health - 1;
                }
                
                bot thread [[ level.callbackplayerdamage ]]( attacker, attacker, damageval, 0, "<dev string:xcbb>", 0, attacker.primaryweaponobj, attacker.origin, ( 0, 0, 0 ), "<dev string:x2ef>", 0 );
            }
        }
        
        setdevdvar( hurtdvar, 0 );
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x9cebe2c2, Offset: 0x1502f
    // Size: 0x155, Type: dev
    function function_520eabca5d8cc968( targetisenemy, resetdvar )
    {
        while ( true )
        {
            if ( getdvarint( resetdvar ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        var_149288e10e7313ab = function_2ee13eddfbd7f93c();
        enemybot = getbot( var_149288e10e7313ab );
        attacker = targetisenemy ? var_149288e10e7313ab : enemybot;
        
        foreach ( player in level.players )
        {
            bot = undefined;
            
            if ( !isbot( player ) && !istestclient( player ) )
            {
                continue;
            }
            
            if ( isdefined( player ) && isdefined( attacker ) )
            {
                if ( level.teambased )
                {
                    if ( player.team != attacker.team )
                    {
                        bot = player;
                    }
                }
                else
                {
                    bot = player;
                }
            }
            
            if ( isdefined( bot ) )
            {
                bot.health = 100;
            }
        }
        
        setdevdvar( resetdvar, 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc41c6152, Offset: 0x1518c
    // Size: 0x269, Type: dev
    function function_869907cd2140639f()
    {
        while ( true )
        {
            if ( getdvar( @"hash_58d027ad37e05b46", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        bot = undefined;
        notbot = function_2ee13eddfbd7f93c();
        bot = getbot( notbot );
        
        if ( isdefined( bot ) )
        {
            switch ( getdvar( @"hash_58d027ad37e05b46" ) )
            {
                case #"hash_7f140387222cfe9c":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoright( notbot.angles ) * 100 );
                    break;
                case #"hash_b291f3b7bbb77bab":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoright( notbot.angles ) * 100 * -1 );
                    break;
                case #"hash_56fc9561bf733ce7":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoforward( notbot.angles ) * 100 );
                    break;
                case #"hash_780928871e950151":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoright( notbot.angles ) * 600 );
                    break;
                case #"hash_d887fab7cfd82d82":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoright( notbot.angles ) * 600 * -1 );
                    break;
                case #"hash_404a4461b3700846":
                    bot setorigin( notbot.origin + ( 0, 0, 5 ) + anglestoforward( notbot.angles ) * 600 );
                    break;
            }
            
            wait 0.1;
            weapon_utility::_magicbullet( makeweapon( "<dev string:x1b38>" ), bot.origin + ( 0, 0, 35 ), notbot.origin + ( 0, 0, 35 ), bot );
        }
        
        setdevdvar( @"hash_58d027ad37e05b46", "<dev string:x2f4>" );
        thread function_869907cd2140639f();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4c6e65a8, Offset: 0x153fd
    // Size: 0xd1, Type: dev
    function function_73f395dfbc0815e2()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b16b6814d40b4d09" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        bot = getbot( notbot );
        fulldamage = notbot.health + ( notbot.armorhealth ?? 0 );
        
        if ( isdefined( bot ) )
        {
            notbot thread [[ level.callbackplayerdamage ]]( bot, bot, fulldamage, 0, "<dev string:xcbb>", 0, bot.currentweapon, bot.origin, ( 0, 0, 0 ), "<dev string:x2ef>", 0, undefined, undefined, 0, fulldamage );
        }
        
        setdevdvar( @"hash_b16b6814d40b4d09", 0 );
        thread function_73f395dfbc0815e2();
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x4b5e1b4d, Offset: 0x154d6
    // Size: 0x185, Type: dev
    function function_209c442180a89401( sourcebot, var_f10ba4907eb3327b, onlyenemies )
    {
        if ( !isdefined( sourcebot ) )
        {
            return;
        }
        
        closestbot = undefined;
        var_8eac9e5f1025454d = 2147483647;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isbot( player ) && !var_f10ba4907eb3327b || istestclient( player ) )
            {
                if ( player == sourcebot )
                {
                    continue;
                }
                
                if ( !isalive( player ) || player isparachuting() || player.gulag )
                {
                    continue;
                }
                
                checkdistance = 0;
                
                if ( level.teambased )
                {
                    if ( !onlyenemies || player.team != sourcebot.team )
                    {
                        checkdistance = 1;
                    }
                }
                else
                {
                    checkdistance = 1;
                }
                
                if ( checkdistance )
                {
                    distancesq = distancesquared( sourcebot.origin, player.origin );
                    
                    if ( distancesq < var_8eac9e5f1025454d )
                    {
                        var_8eac9e5f1025454d = distancesq;
                        closestbot = player;
                    }
                }
            }
        }
        
        return closestbot;
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xf042380c, Offset: 0x15663
    // Size: 0x155, Type: dev
    function function_19358e20a2edb5e( var_f10ba4907eb3327b, onlyenemies, var_c4c3dce6f5f84797 )
    {
        candidatebots = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !( isbot( player ) && !var_f10ba4907eb3327b || istestclient( player ) ) )
            {
                continue;
            }
            
            if ( !isalive( player ) || player isparachuting() || player.gulag )
            {
                continue;
            }
            
            if ( player == var_c4c3dce6f5f84797 )
            {
                continue;
            }
            
            if ( isdefined( var_c4c3dce6f5f84797 ) )
            {
                if ( level.teambased )
                {
                    if ( !onlyenemies || player.team != var_c4c3dce6f5f84797.team )
                    {
                        candidatebots[ candidatebots.size ] = player;
                    }
                }
                else
                {
                    candidatebots[ candidatebots.size ] = player;
                }
                
                continue;
            }
            
            candidatebots[ candidatebots.size ] = player;
        }
        
        if ( candidatebots.size == 0 )
        {
            return;
        }
        
        return candidatebots[ randomint( candidatebots.size ) ];
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x2adeb331, Offset: 0x157c0
    // Size: 0x28d, Type: dev
    function getbot( notbot, var_4573fb5961d43a98 )
    {
        bot = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && !istestclient( player ) )
            {
                continue;
            }
            
            if ( isdefined( player ) && isdefined( notbot ) )
            {
                if ( level.teambased )
                {
                    if ( player.team != notbot.team )
                    {
                        bot = player;
                        break;
                    }
                    
                    continue;
                }
                
                bot = player;
                break;
            }
        }
        
        if ( !isdefined( bot ) )
        {
            foreach ( player in level.players )
            {
                if ( !isbot( player ) && !istestclient( player ) )
                {
                    continue;
                }
                
                if ( isdefined( player ) && isdefined( notbot ) )
                {
                    if ( level.teambased )
                    {
                        if ( player.team == notbot.team )
                        {
                            bot = player;
                            break;
                        }
                    }
                }
            }
        }
        
        if ( !isdefined( bot ) )
        {
            setdevdvar( @"dev_spawnbots", 1 );
            wait 3;
            
            foreach ( player in level.players )
            {
                if ( !isbot( player ) && !istestclient( player ) )
                {
                    continue;
                }
                
                if ( isdefined( player ) && isdefined( notbot ) )
                {
                    if ( level.teambased )
                    {
                        if ( player.team != notbot.team )
                        {
                            bot = player;
                            break;
                        }
                        
                        continue;
                    }
                    
                    bot = player;
                    break;
                }
            }
        }
        
        return bot;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3942543d, Offset: 0x15a55
    // Size: 0xa2, Type: dev
    function function_2ee13eddfbd7f93c()
    {
        notbot = level.players[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && !istestclient( player ) )
            {
                return player;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa9ee4c52, Offset: 0x15aff
    // Size: 0x10f, Type: dev
    function function_87263b2000f07aaa()
    {
        while ( true )
        {
            if ( getdvar( @"hash_c9f6917530383799", "<dev string:xa3>" ) != "<dev string:xa3>" )
            {
                break;
            }
            
            wait 0.5;
        }
        
        if ( level.ingraceperiod )
        {
            level notify( #"hash_af7e9bbaadca5367" );
            level notify( #"matchstarttimer_done" );
            
            foreach ( p in level.players )
            {
                p setclientomnvar( "<dev string:x1b44>", 0 );
                p setclientomnvar( "<dev string:x1b5d>", 1 );
                playerlogic::clearprematchlook( p );
                p player::_freezecontrols( 0, 1 );
            }
        }
        
        setdevdvar( @"hash_c9f6917530383799", "<dev string:xa3>" );
        thread function_87263b2000f07aaa();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa09ca593, Offset: 0x15c16
    // Size: 0x42, Type: dev
    function devchangetimelimit()
    {
        timelimit_maprestart = getdvarfloat( @"scr_devchangetimelimit_maprestart", -1 );
        
        if ( timelimit_maprestart >= 0 )
        {
            setdevdvar( @"scr_devchangetimelimit", timelimit_maprestart );
        }
        
        devchangetimelimit_internal();
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xe43d660a, Offset: 0x15c60
    // Size: 0xd2, Type: dev
    function private devchangetimelimit_internal()
    {
        while ( true )
        {
            if ( getdvarfloat( @"scr_devchangetimelimit", -1 ) >= 0 )
            {
                break;
            }
            
            if ( getdvarfloat( @"scr_devchangetimelimit", -1 ) == -2 )
            {
                timelimit = game_utility_mp::gettimelimit();
                setdevdvar( @"scr_devchangetimelimit", int( timelimit / 2 ) );
                break;
            }
            
            wait 1;
        }
        
        timelimit = getdvarfloat( @"scr_devchangetimelimit" );
        setdevdvar( @"scr_devchangetimelimit_maprestart", timelimit );
        setdevdvar( @"scr_devchangetimelimit", -1 );
        level.starttime = gettime();
        level.timelimit = timelimit;
        game_utility_mp::setovertimelimitdvar( timelimit );
        level notify( #"scr_devchangetimelimit" );
        thread devchangetimelimit_internal();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc23fb465, Offset: 0x15d3a
    // Size: 0x6c, Type: dev
    function disableforfeit()
    {
        oldvalue = 0;
        
        while ( true )
        {
            newvalue = getdvarint( @"scr_disable_forfeit", 0 );
            
            if ( newvalue != oldvalue )
            {
                if ( newvalue == 1 )
                {
                    level.disableforfeit = 1;
                    level notify( #"abort_forfeit" );
                }
                else
                {
                    level.disableforfeit = 0;
                }
                
                oldvalue = newvalue;
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe8cddb77, Offset: 0x15dae
    // Size: 0x156, Type: dev
    function function_d76df5d8a8da1e61()
    {
        prev = getdvarint( @"hash_18cc90e3fd22526a" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_18cc90e3fd22526a" ) != prev )
            {
                break;
            }
            
            wait 1;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        switch ( getdvarint( @"hash_18cc90e3fd22526a" ) )
        {
            case 0:
                notbot notify( #"hash_7f5446ce2a10ba90" );
                
                if ( isdefined( notbot.var_acbfedce2fdecc2e ) )
                {
                    notbot.var_acbfedce2fdecc2e hud_util::destroyelem();
                }
                
                if ( isdefined( notbot.var_b7e28974a08aa14d ) )
                {
                    notbot.var_b7e28974a08aa14d hud_util::destroyelem();
                }
                
                break;
            case 1:
                notbot.var_acbfedce2fdecc2e = notbot hud_util::createprimaryprogressbar( 200, 250 );
                notbot.var_b7e28974a08aa14d = notbot hud_util::createprimaryprogressbartext( 200, 250 );
                notbot.var_b7e28974a08aa14d hud_util::setpoint( "<dev string:x1b72>", undefined, level.primaryprogressbartextx - 150, level.primaryprogressbartexty + 250 );
                notbot.var_b7e28974a08aa14d settext( "<dev string:x1b78>" );
                notbot thread function_ff42701095216f24();
                break;
        }
        
        thread function_d76df5d8a8da1e61();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9251decd, Offset: 0x15f0c
    // Size: 0x1d, Type: dev
    function function_ff42701095216f24()
    {
        level endon( #"game_ended" );
        self endon( #"hash_7f5446ce2a10ba90" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfd026edb, Offset: 0x15f31
    // Size: 0x126, Type: dev
    function function_3ec3504eed372438()
    {
        prev = getdvarint( @"hash_a468c3040709501b" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_a468c3040709501b" ) != prev )
            {
                break;
            }
            
            wait 1;
        }
        
        notbot = function_2ee13eddfbd7f93c();
        
        switch ( getdvarint( @"hash_a468c3040709501b" ) )
        {
            case 0:
                notbot notify( #"hash_100972c9c4a8fbc9" );
                
                if ( isdefined( notbot.var_939b6914a33347fd ) )
                {
                    notbot.var_939b6914a33347fd hud_util::destroyelem();
                }
                
                if ( isdefined( notbot.var_32befe724b1219c6 ) )
                {
                    notbot.var_32befe724b1219c6 hud_util::destroyelem();
                }
                
                break;
            case 1:
                notbot.var_939b6914a33347fd = notbot hud_util::createprimaryprogressbar( 200, 200 );
                notbot.var_32befe724b1219c6 = notbot hud_util::createprimaryprogressbartext( 200, 200 );
                notbot.var_32befe724b1219c6 settext( "<dev string:x1b82>" );
                notbot thread function_86dae57b57d92d();
                break;
        }
        
        thread function_3ec3504eed372438();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa5c7f53d, Offset: 0x1605f
    // Size: 0xea, Type: dev
    function function_86dae57b57d92d()
    {
        level endon( #"game_ended" );
        self endon( #"hash_100972c9c4a8fbc9" );
        prevxp = rank::getrankxp();
        
        while ( true )
        {
            currxp = rank::getrankxp();
            
            if ( prevxp != currxp )
            {
                rank = progression_utility::getrankforxp( currxp );
                minxp = progression_utility::getrankinfominxp( rank );
                nextxp = progression_utility::getrankinfoxpamt( rank );
                barfrac = ( currxp - minxp ) / nextxp;
                
                if ( barfrac > 1 )
                {
                    barfrac = 1;
                }
                
                self.var_939b6914a33347fd hud_util::updatebar( barfrac, 0 );
                prevxp = currxp;
                self.var_32befe724b1219c6 settext( "<dev string:x1b8c>" + currxp + "<dev string:x1b97>" + nextxp + "<dev string:x1ba4>" + rank + 1 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5c271e5e, Offset: 0x16151
    // Size: 0x2d6, Type: dev
    function devhelipathdebugdraw()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -30 );
        endonmsg = "<dev string:x1bab>";
        level.var_b91ec0d042adf28e = 0;
        
        while ( true )
        {
            if ( getdvarint( @"scr_devhelipathsdebugdraw" ) > 0 )
            {
                level.var_b91ec0d042adf28e = 1;
                script_origins = getentarray( "<dev string:xd65>", #classname );
                
                foreach ( ent in script_origins )
                {
                    if ( isdefined( ent.targetname ) )
                    {
                        switch ( ent.targetname )
                        {
                            case #"hash_c7f2713f8146c2fe":
                                textcolor = blue;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"hash_b3d3504a12cbef63":
                                textcolor = green;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"hash_edf28f9f9eab902":
                                textcolor = red;
                                textalpha = 1;
                                textscale = 3;
                                break;
                            case #"hash_18b8d1ddd9bd830d":
                                textcolor = white;
                                textalpha = 1;
                                textscale = 3;
                                break;
                        }
                        
                        switch ( ent.targetname )
                        {
                            case #"hash_edf28f9f9eab902":
                            case #"hash_18b8d1ddd9bd830d":
                            case #"hash_b3d3504a12cbef63":
                            case #"hash_c7f2713f8146c2fe":
                                if ( drawtime == maxdrawtime )
                                {
                                    ent thread drawpath( textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg );
                                }
                                
                                ent draworiginlines();
                                ent drawtargetnametext( textcolor, textalpha, textscale );
                                ent draworigintext( textcolor, textalpha, textscale, origintextoffset );
                                break;
                        }
                    }
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
            }
            
            if ( level.var_b91ec0d042adf28e && getdvarint( @"scr_devhelipathsdebugdraw", 0 ) == 0 )
            {
                level.var_b91ec0d042adf28e = 0;
                level notify( endonmsg );
                drawtime = maxdrawtime;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7edea4e5, Offset: 0x1642f
    // Size: 0x265, Type: dev
    function function_b3336c3a43f4f078()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -30 );
        endonmsg = "<dev string:x1bfc>";
        
        while ( true )
        {
            if ( getdvarint( @"hash_b048e9c4cba3bb37" ) > 0 )
            {
                script_structs = utility::getstructarray( "<dev string:x1c18>", "<dev string:x1c34>" );
                
                foreach ( ent in script_structs )
                {
                    line( ent.origin, ent.origin + ( 10, 0, 0 ), red );
                    line( ent.origin, ent.origin + ( 0, 10, 0 ), green );
                    line( ent.origin, ent.origin + ( 0, 0, 10 ), blue );
                    print3d( ent.origin, ent.origin );
                    
                    if ( isdefined( ent.script_noteworthy ) )
                    {
                        print3d( ent.origin + origintextoffset, ent.script_noteworthy );
                    }
                    
                    if ( isdefined( ent.radius ) )
                    {
                        print3d( ent.origin + origintextoffset * 2, "<dev string:x1c46>" + ent.radius );
                    }
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3ba67f58, Offset: 0x1669c
    // Size: 0xca, Type: dev
    function draworiginlines()
    {
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        line( self.origin, self.origin + anglestoforward( self.angles ) * 10, red );
        line( self.origin, self.origin + anglestoright( self.angles ) * 10, green );
        line( self.origin, self.origin + anglestoup( self.angles ) * 10, blue );
    }

    // Namespace dev_mp
    // Params 4
    // Checksum 0xd3dad397, Offset: 0x1676e
    // Size: 0x5c, Type: dev
    function drawtargetnametext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        print3d( self.origin + textoffset, self.targetname, textcolor, textalpha, textscale );
    }

    // Namespace dev_mp
    // Params 4
    // Checksum 0x11604c8f, Offset: 0x167d2
    // Size: 0x9e, Type: dev
    function draworigintext( textcolor, textalpha, textscale, textoffset )
    {
        if ( !isdefined( textoffset ) )
        {
            textoffset = ( 0, 0, 0 );
        }
        
        originstring = "<dev string:x1c4f>" + self.origin[ 0 ] + "<dev string:x3f8>" + self.origin[ 1 ] + "<dev string:x3f8>" + self.origin[ 2 ] + "<dev string:x532>";
        print3d( self.origin + textoffset, originstring, textcolor, textalpha, textscale );
    }

    // Namespace dev_mp
    // Params 4
    // Checksum 0xec8c6531, Offset: 0x16878
    // Size: 0x9c, Type: dev
    function drawspeedacceltext( textcolor, textalpha, textscale, textoffset )
    {
        if ( isdefined( self.script_airspeed ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 2 ), "<dev string:x1c51>" + self.script_airspeed, textcolor, textalpha, textscale );
        }
        
        if ( isdefined( self.script_accel ) )
        {
            print3d( self.origin + ( 0, 0, textoffset[ 2 ] * 3 ), "<dev string:x1c62>" + self.script_accel, textcolor, textalpha, textscale );
        }
    }

    // Namespace dev_mp
    // Params 7
    // Checksum 0xdc15c6a4, Offset: 0x1691c
    // Size: 0xf5, Type: dev
    function drawpath( linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        ent = self;
        entfirsttarget = ent.targetname;
        
        while ( isdefined( ent.target ) )
        {
            enttarget = getent( ent.target, #targetname );
            ent thread drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg );
            
            if ( ent.targetname == "<dev string:x1bd0>" )
            {
                entfirsttarget = ent.target;
            }
            else if ( ent.target == entfirsttarget )
            {
                break;
            }
            
            ent = enttarget;
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 8
    // Checksum 0x881e674a, Offset: 0x16a19
    // Size: 0x95, Type: dev
    function drawpathsegment( enttarget, linecolor, textcolor, textalpha, textscale, textoffset, drawtime, endonmsg )
    {
        level endon( endonmsg );
        
        while ( drawtime > 0 )
        {
            line( self.origin, enttarget.origin, linecolor );
            drawspeedacceltext( textcolor, textalpha, textscale, textoffset );
            drawtime -= 0.05;
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xaa4f57c2, Offset: 0x16ab6
    // Size: 0x1e0, Type: dev
    function function_839a368fd139c6a7()
    {
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        blue = ( 0, 0, 1 );
        textcolor = white;
        textalpha = 1;
        textscale = 1;
        maxdrawtime = 10;
        drawtime = maxdrawtime;
        origintextoffset = ( 0, 0, -30 );
        endonmsg = "<dev string:x1c70>";
        
        while ( true )
        {
            if ( getdvarint( @"hash_af596796ae351a3c" ) > 0 )
            {
                script_origins = getentarray( "<dev string:x1c90>", #targetname );
                
                foreach ( ent in script_origins )
                {
                    textcolor = red;
                    textalpha = 1;
                    textscale = 1;
                    
                    if ( drawtime == maxdrawtime )
                    {
                        ent thread drawpath( textcolor, white, textalpha, textscale, origintextoffset, drawtime, endonmsg );
                    }
                    
                    ent draworiginlines();
                    ent drawtargetnametext( textcolor, textalpha, textscale );
                    ent draworigintext( textcolor, textalpha, textscale, origintextoffset );
                }
                
                drawtime -= 0.05;
                
                if ( drawtime < 0 )
                {
                    drawtime = maxdrawtime;
                }
            }
            
            if ( getdvarint( @"hash_af596796ae351a3c", 0 ) )
            {
                level notify( endonmsg );
                drawtime = maxdrawtime;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8a9b3eb5, Offset: 0x16c9e
    // Size: 0x22f, Type: dev
    function function_76808e45fa231520()
    {
        while ( true )
        {
            if ( getdvar( @"hash_f901de8bb079b09b", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                break;
            }
            
            wait 1;
        }
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) || istestclient( player ) )
            {
                continue;
            }
            
            if ( getdvar( @"hash_f901de8bb079b09b" ) == "<dev string:x1ca3>" )
            {
                println( player.name );
                
                foreach ( challenge, value in player.challengedata )
                {
                    if ( issubstr( challenge, "<dev string:x1ca9>" ) && value )
                    {
                        println( "<dev string:x1cb0>" + challenge );
                    }
                }
                
                continue;
            }
            
            if ( getdvar( @"hash_f901de8bb079b09b" ) == "<dev string:x1cb8>" )
            {
                println( player.name );
                
                foreach ( challenge, value in player.challengedata )
                {
                    if ( issubstr( challenge, "<dev string:x1cbf>" ) && value )
                    {
                        println( "<dev string:x1cc7>" + challenge );
                    }
                }
            }
        }
        
        setdevdvar( @"hash_f901de8bb079b09b", "<dev string:x2f4>" );
        thread function_76808e45fa231520();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x52782c24, Offset: 0x16ed5
    // Size: 0x217, Type: dev
    function reflectionprobe_hide_hp()
    {
        neutralpoint = getentarray( "<dev string:x1cd0>", #targetname );
        enemypoint = getentarray( "<dev string:x1ce6>", #targetname );
        friendpoint = getentarray( "<dev string:x1d02>", #targetname );
        contestpoint = getentarray( "<dev string:x1d1f>", #targetname );
        
        foreach ( zone in neutralpoint )
        {
            zone hide();
        }
        
        foreach ( zone in enemypoint )
        {
            zone hide();
        }
        
        foreach ( zone in friendpoint )
        {
            zone hide();
        }
        
        foreach ( zone in contestpoint )
        {
            zone hide();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbd8765fe, Offset: 0x170f4
    // Size: 0xfd, Type: dev
    function reflectionprobe_hide_front()
    {
        fzaf = getent( "<dev string:x1d3d>", #targetname );
        
        if ( isdefined( fzaf ) )
        {
            fzaf hide();
        }
        
        fzae = getent( "<dev string:x1d5d>", #targetname );
        
        if ( isdefined( fzae ) )
        {
            fzae hide();
        }
        
        fzac = getent( "<dev string:x1d7c>", #targetname );
        
        if ( isdefined( fzac ) )
        {
            fzac hide();
        }
        
        fzxf = getent( "<dev string:x1d9d>", #targetname );
        
        if ( isdefined( fzxf ) )
        {
            fzxf hide();
        }
        
        fzxe = getent( "<dev string:x1dbb>", #targetname );
        
        if ( isdefined( fzxe ) )
        {
            fzxe hide();
        }
        
        var_316f8b30d1dcad17 = getent( "<dev string:x1dd8>", #targetname );
        
        if ( isdefined( var_316f8b30d1dcad17 ) )
        {
            var_316f8b30d1dcad17 hide();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x71770619, Offset: 0x171f9
    // Size: 0x192, Type: dev
    function gotonextspawn()
    {
        if ( isdefined( level.spawnpoints ) )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player.var_8879569e9a9353b7 ) )
                {
                    player.var_8879569e9a9353b7 = 0;
                }
                
                player.spawnpos = level.spawnpoints[ player.var_8879569e9a9353b7 ].origin;
                player spawn( level.spawnpoints[ player.var_8879569e9a9353b7 ].origin, level.spawnpoints[ player.var_8879569e9a9353b7 ].angles );
                iprintlnbold( player.var_8879569e9a9353b7 );
                player.var_b4d184f38e1d91bf = player.var_8879569e9a9353b7 - 1;
                
                if ( player.var_b4d184f38e1d91bf < 0 )
                {
                    player.var_b4d184f38e1d91bf = level.spawnpoints.size - 1;
                }
                
                player.var_8879569e9a9353b7++;
                
                if ( player.var_8879569e9a9353b7 == level.spawnpoints.size )
                {
                    player.var_8879569e9a9353b7 = 0;
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3965bbaa, Offset: 0x17393
    // Size: 0x19e, Type: dev
    function gotoprevspawn()
    {
        if ( isdefined( level.spawnpoints ) )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player.var_b4d184f38e1d91bf ) )
                {
                    player.var_b4d184f38e1d91bf = level.spawnpoints.size - 1;
                }
                
                player.spawnpos = level.spawnpoints[ player.var_b4d184f38e1d91bf ].origin;
                player spawn( level.spawnpoints[ player.var_b4d184f38e1d91bf ].origin, level.spawnpoints[ player.var_b4d184f38e1d91bf ].angles );
                iprintlnbold( player.var_8879569e9a9353b7 );
                player.var_8879569e9a9353b7 = player.var_b4d184f38e1d91bf + 1;
                
                if ( player.var_8879569e9a9353b7 == level.spawnpoints.size )
                {
                    player.var_8879569e9a9353b7 = 0;
                }
                
                player.var_b4d184f38e1d91bf--;
                
                if ( player.var_b4d184f38e1d91bf < 0 )
                {
                    player.var_b4d184f38e1d91bf = level.spawnpoints.size - 1;
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5d1da009, Offset: 0x17539
    // Size: 0xcf, Type: dev
    function devaliengiveplayersmoney()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_a0e912753d4b01bb" ) == 0 )
            {
                wait 0.05;
                continue;
            }
            
            foreach ( player in level.players )
            {
                if ( isdefined( level.var_8750d75de2b8736b ) )
                {
                    player [[ level.var_8750d75de2b8736b ]]( 1000 );
                }
            }
            
            setdevdvar( @"hash_a0e912753d4b01bb", "<dev string:xa3>" );
            wait 0.05;
        }
    }

#/

// Namespace dev_mp
// Params 0
// Checksum 0x87c581ea, Offset: 0x17610
// Size: 0x9d
function spam_points_popup()
{
    scoreevents = [ #"headshot", #"avenger", #"longshot", #"posthumous", #"double", #"triple", #"multi" ];
    
    for ( i = 0; i < scoreevents.size ; i++ )
    {
        thread rank::scorepointspopup( 100 );
        thread rank::scoreeventpopup( scoreevents[ i ] );
        wait 2;
    }
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x42983fc6, Offset: 0x176b5
    // Size: 0xec, Type: dev
    function function_417b0150f61716b1()
    {
        for ( ;; )
        {
            if ( getdvarint( @"hash_1059590334b9de2c" ) > 0 )
            {
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_1059590334b9de2c", 0 );
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            return;
        }
        
        foreach ( character in level.characters )
        {
            if ( level.teambased )
            {
                if ( character.team == notbot.team )
                {
                    kick( character getentitynumber() );
                }
                
                continue;
            }
            
            return;
        }
    }

#/

// Namespace dev_mp
// Params 0
// Checksum 0xba160473, Offset: 0x177a9
// Size: 0xfd
function devlistinventory()
{
    dvarvalue = getdvar( @"scr_list_inventory", "" );
    
    if ( dvarvalue != "" )
    {
        hostplayer = devfindhost();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        list = undefined;
        msg = undefined;
        bold = 0;
        
        if ( dvarvalue == "all" )
        {
            msg = "all weapons";
            list = hostplayer getweaponslistall( 0 );
        }
        else if ( dvarvalue == "allEvenNull" )
        {
            msg = "all weapons even null";
            list = hostplayer getweaponslistall( 1 );
        }
        else if ( dvarvalue == "primaryCurrent" )
        {
            msg = "current weapon";
            bold = 1;
            list = [ hostplayer getcurrentweapon() ];
        }
        else
        {
            msg = dvarvalue + " inventory";
            list = hostplayer getweaponslist( dvarvalue );
        }
        
        hostplayer devprintweaponlist( list, msg, bold );
        
        /#
            setdevdvar( @"scr_list_inventory", "<dev string:x2f4>" );
        #/
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xa6fcc21a, Offset: 0x178ae
// Size: 0x107
function function_7941e5ddcbbac9ba()
{
    dvarvalue = getdvar( @"hash_53605e5dfa2134cc", "" );
    
    if ( dvarvalue != "" )
    {
        hostplayer = devfindhost();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        msg = "current weapon";
        bold = 1;
        list = [ hostplayer getcurrentweapon() ];
        
        foreach ( weapon in list )
        {
            var_734a93e675953b93 = getcompleteweaponname( weapon );
        }
        
        /#
            function_3bc604f9c0efa918( var_734a93e675953b93 );
            setdevdvar( @"hash_53605e5dfa2134cc", "<dev string:x2f4>" );
        #/
    }
}

// Namespace dev_mp
// Params 3
// Checksum 0x2be5260c, Offset: 0x179bd
// Size: 0x177
function devprintweaponlist( list, msg, printbold )
{
    /#
        println( "<dev string:x1df7>" );
        println( "<dev string:x1e21>" + msg );
        println( "<dev string:x1df7>" );
        
        if ( list.size > 0 )
        {
            foreach ( weapon in list )
            {
                if ( weapon )
                {
                    clipammo = self getweaponammoclip( weapon );
                    stockammo = self getweaponammostock( weapon );
                    var_734a93e675953b93 = getcompleteweaponname( weapon );
                    weapmsg = "<dev string:x1e32>" + var_734a93e675953b93 + "<dev string:x356>" + clipammo + "<dev string:x124b>" + stockammo;
                    weapclass = weaponclass( var_734a93e675953b93 );
                    
                    if ( isdefined( weapclass ) )
                    {
                        weapmsg = weapmsg + "<dev string:x1e35>" + weapclass;
                    }
                    
                    println( weapmsg );
                    
                    if ( printbold )
                    {
                        iprintlnbold( weapmsg );
                    }
                    
                    continue;
                }
                
                println( "<dev string:x1e3d>" );
                
                if ( printbold )
                {
                    iprintlnbold( "<dev string:x1e3d>" );
                }
            }
        }
        else
        {
            println( "<dev string:x1e42>" );
        }
        
        println( "<dev string:x1df7>" );
    #/
}

// Namespace dev_mp
// Params 0
// Checksum 0x28269be4, Offset: 0x17b3c
// Size: 0x19b
function devgivesuperthink()
{
    while ( true )
    {
        super = getdvar( @"scr_givesuper", "" );
        blueprintindex = getdvarint( @"hash_c03a8d3daea44f20", 0 );
        
        if ( super != "" )
        {
            /#
                setdevdvar( @"scr_givesuper", "<dev string:x2f4>" );
            #/
            
            foreach ( player in level.players )
            {
                player supers_mp::givesuper( super, 0, 1, blueprintindex );
            }
        }
        
        if ( getdvarint( @"hash_1deddbedb2075add", 0 ) != 0 )
        {
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( player supers_mp::getcurrentsuper() ) )
                {
                    continue;
                }
                
                if ( player supers_mp::issupercharging() )
                {
                    player supers_mp::givesuperpoints( player supers_mp::getsuperpointsneeded() * 0.25 );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x99f31a0c, Offset: 0x17cdf
// Size: 0x9c
function function_617e719bc105a6cb()
{
    var_4e969ca5282252d1 = 0;
    state = 0;
    
    while ( true )
    {
        hostplayer = devfindhost();
        isnvg = getdvarint( @"hash_e8f85992b38b6ea8", 0 );
        
        if ( isnvg != state )
        {
            if ( isnvg )
            {
                if ( !var_4e969ca5282252d1 )
                {
                    var_3534084e25d1cc70 = 1;
                    hostplayer thread nvg::runnvg();
                }
                
                hostplayer val::reset_all( "devForceNVG" );
            }
            else
            {
                hostplayer val::set( "devForceNVG", "nvg", 0 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xae77dc93, Offset: 0x17d83
// Size: 0x82
function function_5f0f78998322a581()
{
    while ( true )
    {
        givedisguise = getdvarint( @"scr_disguise_activate", 0 );
        
        if ( givedisguise == 1 )
        {
            /#
                setdevdvar( @"scr_disguise_activate", 0 );
            #/
            
            hostplayer = devfindhost();
            
            if ( player::isreallyalive( hostplayer ) )
            {
                if ( hostplayer.disguised )
                {
                    hostplayer thread disguise::function_f7776d7012343e70();
                }
                else
                {
                    hostplayer thread disguise::disguise_tryuse();
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xbd9c48c0, Offset: 0x17e0d
// Size: 0x380
function function_3662b211939d2756()
{
    while ( true )
    {
        streakname = getdvar( @"hash_2d45555fbb2ce4da", "" );
        
        if ( streakname != "" )
        {
            if ( !isdefined( level.var_5e9687d0afaf1135 ) )
            {
                level.var_5e9687d0afaf1135 = 0;
            }
            
            targetbot = undefined;
            streakname = getdvar( @"hash_2d45555fbb2ce4da", "" );
            blueprintindex = getdvarint( @"scr_givekillstreakblueprintindex", 0 );
            streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
            
            /#
                setdevdvar( @"hash_2d45555fbb2ce4da", "<dev string:x2f4>" );
            #/
            
            host = devfindhost();
            
            if ( !isdefined( host ) )
            {
                continue;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                entindex = level.var_5e9687d0afaf1135 % characterkeys.size;
                ent = level.characters[ characterkeys[ entindex ] ];
                level.var_5e9687d0afaf1135++;
                
                if ( isbot( ent ) && isalive( ent ) && ent.sessionstate == "playing" )
                {
                    if ( !level.teambased || host.team != ent.team )
                    {
                        targetbot = ent;
                        break;
                    }
                }
            }
            
            if ( !isdefined( targetbot ) )
            {
                continue;
            }
            
            var_ec73d9361a038a70 = 0;
            emptime = undefined;
            
            if ( streakname == "emp_quick" )
            {
                var_ec73d9361a038a70 = 1;
                emptime = getdvarfloat( @"scr_emp_timeout" );
                streakname = "emp";
                
                /#
                    setdevdvar( @"scr_emp_timeout", 1 );
                #/
            }
            
            if ( isdefined( streaksetupinfo ) && killstreak_utility::getkillstreakindex( streakname ) != -1 )
            {
                if ( targetbot.team != "spectator" && targetbot.sessionstate != "spectator" )
                {
                    if ( streakname == "nuke" )
                    {
                        nuketype = getdvarint( @"scr_nuke_type", 0 );
                        
                        switch ( nuketype )
                        {
                            case 1:
                                streakname = "nuke_select_location";
                                break;
                            case 2:
                                streakname = "nuke_multi";
                                break;
                        }
                    }
                    
                    targetbot killstreaks::awardkillstreak( streakname, "other", undefined, undefined, undefined, undefined, blueprintindex );
                    
                    if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        /#
                            targetbot bots_debug::bot_use_killstreak();
                        #/
                    }
                }
            }
            else
            {
                println( "<dev string:x2df>" + streakname + "<dev string:x499>" );
                
                foreach ( killstreak, value in level.killstreaksetups )
                {
                    if ( killstreak_utility::getkillstreakindex( killstreak ) != -1 )
                    {
                        println( "<dev string:x4cd>" + killstreak );
                    }
                }
                
                println( "<dev string:x2f4>" );
            }
            
            if ( var_ec73d9361a038a70 )
            {
                /#
                    level thread function_a48e6713064f914f( 5, @"scr_emp_timeout", emptime );
                #/
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x51cbc9cf, Offset: 0x18195
// Size: 0x37f
function function_eebc88596c7389d7()
{
    while ( true )
    {
        streakname = getdvar( @"hash_83b57a87863f395", "" );
        
        if ( streakname != "" )
        {
            if ( !isdefined( level.var_c1af591be23c802 ) )
            {
                level.var_c1af591be23c802 = 0;
            }
            
            targetbot = undefined;
            streakname = getdvar( @"hash_83b57a87863f395", "" );
            blueprintindex = getdvarint( @"scr_givekillstreakblueprintindex", 0 );
            streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
            
            /#
                setdevdvar( @"hash_83b57a87863f395", "<dev string:x2f4>" );
            #/
            
            host = devfindhost();
            
            if ( !isdefined( host ) )
            {
                continue;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                entindex = level.var_c1af591be23c802 % characterkeys.size;
                ent = level.characters[ characterkeys[ entindex ] ];
                level.var_c1af591be23c802++;
                
                if ( isbot( ent ) && isalive( ent ) && ent.sessionstate == "playing" )
                {
                    if ( level.teambased && host.team == ent.team )
                    {
                        targetbot = ent;
                        break;
                    }
                }
            }
            
            if ( !isdefined( targetbot ) )
            {
                continue;
            }
            
            var_ec73d9361a038a70 = 0;
            emptime = undefined;
            
            if ( streakname == "emp_quick" )
            {
                var_ec73d9361a038a70 = 1;
                emptime = getdvarfloat( @"scr_emp_timeout" );
                streakname = "emp";
                
                /#
                    setdevdvar( @"scr_emp_timeout", 1 );
                #/
            }
            
            if ( isdefined( streaksetupinfo ) && killstreak_utility::getkillstreakindex( streakname ) != -1 )
            {
                if ( targetbot.team != "spectator" && targetbot.sessionstate != "spectator" )
                {
                    if ( streakname == "nuke" )
                    {
                        nuketype = getdvarint( @"scr_nuke_type", 0 );
                        
                        switch ( nuketype )
                        {
                            case 1:
                                streakname = "nuke_select_location";
                                break;
                            case 2:
                                streakname = "nuke_multi";
                                break;
                        }
                    }
                    
                    targetbot killstreaks::awardkillstreak( streakname, "other", undefined, undefined, undefined, undefined, blueprintindex );
                    
                    if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        /#
                            targetbot bots_debug::bot_use_killstreak();
                        #/
                    }
                }
            }
            else
            {
                println( "<dev string:x2df>" + streakname + "<dev string:x499>" );
                
                foreach ( killstreak, value in level.killstreaksetups )
                {
                    if ( killstreak_utility::getkillstreakindex( killstreak ) != -1 )
                    {
                        println( "<dev string:x4cd>" + killstreak );
                    }
                }
                
                println( "<dev string:x2f4>" );
            }
            
            if ( var_ec73d9361a038a70 )
            {
                /#
                    level thread function_a48e6713064f914f( 5, @"scr_emp_timeout", emptime );
                #/
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 1
// Checksum 0x84a436cd, Offset: 0x1851c
// Size: 0x7b
function function_9a0d41eb59b01683( streakname )
{
    switch ( streakname )
    {
        case #"hash_27002778019fb447":
        case #"hash_28d0236400e33fd0":
        case #"hash_349713b5ad494dda":
        case #"hash_634b246c3da5c56f":
        case #"hash_6362d6aae3e5a62e":
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_e171e5b86ef0a4cc":
            return 1;
        default:
            return 0;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x39e4c2e9, Offset: 0x1859f
// Size: 0x5e
function function_fe6df4f275ece829()
{
    while ( true )
    {
        equipmentref = getdvar( @"hash_24fc46aab8e515d3", "" );
        
        if ( equipmentref != "" )
        {
            /#
                setdevdvar( @"hash_24fc46aab8e515d3", "<dev string:x2f4>" );
            #/
            
            devfindhost() agent_equipment::function_f3b908ca82b18202( equipmentref );
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xaa618c7d, Offset: 0x18605
// Size: 0x166
function devgivefieldupgradethink()
{
    while ( true )
    {
        super = getdvar( @"hash_3617ac10e688070e", "" );
        attachment = getdvar( @"hash_fb824771564d5467", "" );
        blueprintindex = getdvarint( @"hash_63e9300e127cbfe7", 0 );
        
        if ( super != "" )
        {
            /#
                setdevdvar( @"hash_3617ac10e688070e", "<dev string:x2f4>" );
            #/
            
            if ( attachment != "" )
            {
                /#
                    setdevdvar( @"hash_fb824771564d5467", "<dev string:x2f4>" );
                #/
                
                attachments = [ attachment ];
            }
            else
            {
                attachments = [];
            }
            
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    player.var_e23e2367dfbe3011 = attachments;
                }
                
                if ( isbrgamemode() )
                {
                    player br_pickups::forcegivesuper( super, 1, 0, 0, 0 );
                    continue;
                }
                
                player perkpackage::perkpackage_givedebug( super, blueprintindex, attachments );
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xa6b85514, Offset: 0x18773
// Size: 0x1d7
function function_426f2b022f57ee66()
{
    while ( true )
    {
        super = getdvar( @"hash_69b7311657d28a29", "" );
        blueprintindex = getdvarint( @"hash_63e9300e127cbfe7", 0 );
        
        if ( super != "" )
        {
            /#
                setdevdvar( @"hash_69b7311657d28a29", "<dev string:x2f4>" );
            #/
            
            superweaponname = level.superglobals.staticsuperdata[ super ].weapon;
            
            if ( !isdefined( superweaponname ) )
            {
                superweaponname = %"super_default_mp";
            }
            
            superweapon = makeweapon( superweaponname );
            
            foreach ( ent in level.characters )
            {
                if ( !isbot( ent ) || !isalive( ent ) || ent.sessionstate != "playing" )
                {
                    continue;
                }
                
                attachments = ent supers_mp::function_a5902968fb664288( superweapon );
                
                if ( attachments.size > 0 )
                {
                    superweapon = superweapon withattachments( attachments );
                }
                
                ent perkpackage::perkpackage_givedebug( super, blueprintindex, attachments );
                
                if ( isdefined( ent.super ) && getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                {
                    if ( !isnullweapon( superweapon ) && superweapon.basename != %"super_default_mp" )
                    {
                        ent weapon_utility::giveandfireoffhandreliable( superweapon );
                    }
                    
                    ent thread supers_mp::trysuperusebegin( superweapon );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x923bcb7a, Offset: 0x18952
// Size: 0x228
function function_57962a842bbc9f40()
{
    while ( true )
    {
        super = getdvar( @"hash_ac808c387df6f898", "" );
        blueprintindex = getdvarint( @"hash_63e9300e127cbfe7", 0 );
        
        if ( super != "" )
        {
            /#
                setdevdvar( @"hash_ac808c387df6f898", "<dev string:x2f4>" );
            #/
            
            host = devfindhost();
            
            if ( !isdefined( host ) )
            {
                continue;
            }
            
            if ( !isdefined( level.var_7377e1a5cb66263 ) )
            {
                level.var_7377e1a5cb66263 = 0;
            }
            
            superweaponname = level.superglobals.staticsuperdata[ super ].weapon;
            
            if ( !isdefined( superweaponname ) )
            {
                superweaponname = %"super_default_mp";
            }
            
            superweapon = makeweapon( superweaponname );
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                entindex = level.var_7377e1a5cb66263 % characterkeys.size;
                ent = level.characters[ characterkeys[ entindex ] ];
                level.var_7377e1a5cb66263++;
                
                if ( isbot( ent ) && isalive( ent ) && ent.sessionstate == "playing" )
                {
                    if ( !level.teambased || host.team != ent.team )
                    {
                        attachments = ent supers_mp::function_a5902968fb664288( superweapon );
                        
                        if ( attachments.size > 0 )
                        {
                            superweapon = superweapon withattachments( attachments );
                        }
                        
                        ent perkpackage::perkpackage_givedebug( super, blueprintindex, attachments );
                        
                        if ( isdefined( ent.super ) && getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                        {
                            if ( !isnullweapon( superweapon ) && superweapon.basename != %"super_default_mp" )
                            {
                                ent weapon_utility::giveandfireoffhandreliable( superweapon );
                            }
                            
                            ent thread supers_mp::trysuperusebegin( superweapon );
                            break;
                        }
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xc98096e4, Offset: 0x18b82
// Size: 0x1eb
function function_603e7489dd6d745d()
{
    while ( true )
    {
        super = getdvar( @"hash_ae9fca9b189d7547", "" );
        blueprintindex = getdvarint( @"hash_63e9300e127cbfe7", 0 );
        
        if ( super != "" )
        {
            /#
                setdevdvar( @"hash_ae9fca9b189d7547", "<dev string:x2f4>" );
            #/
            
            if ( !isdefined( level.var_483100f4b1a4d5d8 ) )
            {
                level.var_483100f4b1a4d5d8 = 0;
            }
            
            superweaponname = level.superglobals.staticsuperdata[ super ].weapon;
            
            if ( !isdefined( superweaponname ) )
            {
                superweaponname = %"super_default_mp";
            }
            
            superweapon = makeweapon( superweaponname );
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                entindex = level.var_483100f4b1a4d5d8 % characterkeys.size;
                ent = level.characters[ characterkeys[ entindex ] ];
                level.var_483100f4b1a4d5d8++;
                
                if ( !isbot( ent ) || !isalive( ent ) || ent.sessionstate != "playing" )
                {
                    continue;
                }
                
                attachments = ent supers_mp::function_a5902968fb664288( superweapon );
                
                if ( attachments.size > 0 )
                {
                    superweapon = superweapon withattachments( attachments );
                }
                
                ent perkpackage::perkpackage_givedebug( super, blueprintindex, attachments );
                
                if ( isdefined( ent.super ) && getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                {
                    if ( !isnullweapon( superweapon ) && superweapon.basename != %"super_default_mp" )
                    {
                        ent weapon_utility::giveandfireoffhandreliable( superweapon );
                    }
                    
                    ent thread supers_mp::trysuperusebegin( superweapon );
                    break;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x7a270a2c, Offset: 0x18d75
// Size: 0x206
function function_eed1e1974ca75bad()
{
    while ( true )
    {
        equipment = getdvar( @"hash_c1fa6ab185f57dc3", "" );
        
        if ( equipment != "" )
        {
            /#
                setdevdvar( @"hash_c1fa6ab185f57dc3", "<dev string:x2f4>" );
            #/
            
            equipweaponname = level.equipment.table[ equipment ].weaponname;
            
            if ( isdefined( equipweaponname ) )
            {
                equipweapon = makeweapon( equipweaponname );
                
                foreach ( ent in level.characters )
                {
                    if ( !isbot( ent ) || !isalive( ent ) || ent.sessionstate != "playing" )
                    {
                        continue;
                    }
                    
                    equipref = level.equipment.table[ equipment ].ref;
                    slot = level.equipment.table[ equipment ].defaultslot;
                    attachments = ent equipment_mp::function_97483661b0d7f039( equipweapon );
                    
                    if ( attachments.size > 0 )
                    {
                        equipweapon = equipweapon withattachments( attachments );
                    }
                    
                    ent equipment_mp::giveequipment( equipref, slot, undefined, undefined, attachments );
                    
                    if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        equiptype = level.equipment.table[ equipment ].bundle.equipmenttype;
                        
                        /#
                            ent bots_debug::bot_use_equipment( equiptype, equipref );
                        #/
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x137b41c1, Offset: 0x18f83
// Size: 0xf4
function function_1ba02fff74376141()
{
    while ( true )
    {
        perkname = getdvar( @"hash_7395b2297287b659", "" );
        
        if ( perkname != "" )
        {
            /#
                setdevdvar( @"hash_7395b2297287b659", "<dev string:x2f4>" );
            #/
            
            foreach ( ent in level.characters )
            {
                if ( !isbot( ent ) || !isalive( ent ) || ent.sessionstate != "playing" )
                {
                    continue;
                }
                
                ent perk::giveperk( perkname );
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xf5a41d1c, Offset: 0x1907f
// Size: 0x24c
function function_69d22cabc4009c08()
{
    while ( true )
    {
        equipment = getdvar( @"hash_35f2aa5b08cbe390", "" );
        
        if ( equipment != "" )
        {
            /#
                setdevdvar( @"hash_35f2aa5b08cbe390", "<dev string:x2f4>" );
            #/
            
            notbot = function_484116646bce0cbf();
            
            if ( !isdefined( notbot ) )
            {
                return;
            }
            
            if ( !isdefined( level.var_d3a5a74214f0ab21 ) )
            {
                level.var_d3a5a74214f0ab21 = 0;
            }
            
            equipweaponname = level.equipment.table[ equipment ].weaponname;
            
            if ( !isdefined( equipweaponname ) )
            {
                continue;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                characterindex = level.var_d3a5a74214f0ab21 % characterkeys.size;
                character = level.characters[ characterkeys[ characterindex ] ];
                level.var_d3a5a74214f0ab21++;
                
                if ( isbot( character ) && isalive( character ) && character.sessionstate == "playing" && character.team != notbot.team )
                {
                    equipweapon = makeweapon( equipweaponname );
                    equipref = level.equipment.table[ equipment ].ref;
                    slot = level.equipment.table[ equipment ].defaultslot;
                    attachments = character equipment_mp::function_97483661b0d7f039( equipweapon );
                    
                    if ( attachments.size > 0 )
                    {
                        equipweapon = equipweapon withattachments( attachments );
                    }
                    
                    character equipment_mp::giveequipment( equipref, slot, undefined, undefined, attachments );
                    
                    if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        equiptype = level.equipment.table[ equipment ].bundle.equipmenttype;
                        
                        /#
                            character bots_debug::bot_use_equipment( equiptype, equipref );
                        #/
                    }
                    
                    break;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x6d1b2b20, Offset: 0x192d3
// Size: 0x24c
function function_2f0edd60c83f705f()
{
    while ( true )
    {
        equipment = getdvar( @"hash_85cb9b5fe926bb55", "" );
        
        if ( equipment != "" )
        {
            /#
                setdevdvar( @"hash_85cb9b5fe926bb55", "<dev string:x2f4>" );
            #/
            
            notbot = function_484116646bce0cbf();
            
            if ( !isdefined( notbot ) )
            {
                return;
            }
            
            if ( !isdefined( level.var_7f7f94535dc7a7b4 ) )
            {
                level.var_7f7f94535dc7a7b4 = 0;
            }
            
            equipweaponname = level.equipment.table[ equipment ].weaponname;
            
            if ( !isdefined( equipweaponname ) )
            {
                continue;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                characterindex = level.var_7f7f94535dc7a7b4 % characterkeys.size;
                character = level.characters[ characterkeys[ characterindex ] ];
                level.var_7f7f94535dc7a7b4++;
                
                if ( isbot( character ) && isalive( character ) && character.sessionstate == "playing" && character.team == notbot.team )
                {
                    equipweapon = makeweapon( equipweaponname );
                    equipref = level.equipment.table[ equipment ].ref;
                    slot = level.equipment.table[ equipment ].defaultslot;
                    attachments = character equipment_mp::function_97483661b0d7f039( equipweapon );
                    
                    if ( attachments.size > 0 )
                    {
                        equipweapon = equipweapon withattachments( attachments );
                    }
                    
                    character equipment_mp::giveequipment( equipref, slot, undefined, undefined, attachments );
                    
                    if ( getdvarint( @"hash_d37d55f3ae9fa226" ) == 1 )
                    {
                        equiptype = level.equipment.table[ equipment ].bundle.equipmenttype;
                        
                        /#
                            character bots_debug::bot_use_equipment( equiptype, equipref );
                        #/
                    }
                    
                    break;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x52969e3b, Offset: 0x19527
// Size: 0x136
function function_1afed179a0ffd34c()
{
    while ( true )
    {
        perk = getdvar( @"hash_68b0dc2de0ced92c", "" );
        
        if ( perk != "" )
        {
            /#
                setdevdvar( @"hash_68b0dc2de0ced92c", "<dev string:x2f4>" );
            #/
            
            notbot = function_484116646bce0cbf();
            
            if ( !isdefined( notbot ) )
            {
                return;
            }
            
            if ( !isdefined( level.var_ccdfa6872341a2ab ) )
            {
                level.var_ccdfa6872341a2ab = 0;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                characterindex = level.var_ccdfa6872341a2ab % characterkeys.size;
                character = level.characters[ characterkeys[ characterindex ] ];
                level.var_ccdfa6872341a2ab++;
                
                if ( isbot( character ) && isalive( character ) && character.sessionstate == "playing" && character.team != notbot.team )
                {
                    character perk::giveperk( perk );
                    break;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xc73d96f1, Offset: 0x19665
// Size: 0x136
function function_5da5ca62d98617c9()
{
    while ( true )
    {
        perk = getdvar( @"hash_34b71cf25a6f1703", "" );
        
        if ( perk != "" )
        {
            /#
                setdevdvar( @"hash_34b71cf25a6f1703", "<dev string:x2f4>" );
            #/
            
            notbot = function_484116646bce0cbf();
            
            if ( !isdefined( notbot ) )
            {
                return;
            }
            
            if ( !isdefined( level.var_fe933bc6d87bc214 ) )
            {
                level.var_fe933bc6d87bc214 = 0;
            }
            
            characterkeys = getarraykeys( level.characters );
            
            for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
            {
                characterindex = level.var_fe933bc6d87bc214 % characterkeys.size;
                character = level.characters[ characterkeys[ characterindex ] ];
                level.var_fe933bc6d87bc214++;
                
                if ( isbot( character ) && isalive( character ) && character.sessionstate == "playing" && character.team == notbot.team )
                {
                    character perk::giveperk( perk );
                    break;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x3fd147d2, Offset: 0x197a3
// Size: 0x9f
function function_484116646bce0cbf()
{
    notbot = level.players[ 0 ];
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && !istestclient( player ) )
        {
            return player;
        }
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xd84e9ac0, Offset: 0x1984a
// Size: 0x13a
function function_f92e09a045007ed5()
{
    while ( true )
    {
        killstreakref = getdvar( @"hash_20c7a16d77382d2b", "" );
        
        if ( killstreakref != "" )
        {
            /#
                setdevdvar( @"hash_20c7a16d77382d2b", "<dev string:x2f4>" );
            #/
            
            if ( killstreakref )
            {
                foreach ( ent in level.characters )
                {
                    if ( !isbot( ent ) || !isalive( ent ) || ent.sessionstate != "playing" )
                    {
                        continue;
                    }
                    
                    streakname = killstreakref;
                    streaksetupinfo = killstreaks::getkillstreaksetupinfo( streakname );
                    
                    if ( isdefined( streaksetupinfo ) && killstreak_utility::getkillstreakindex( streakname ) != -1 )
                    {
                        ent killstreaks::awardkillstreak( streakname, "other" );
                        ent killstreaks::forceactivategimmekillstreak();
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xca2277ff, Offset: 0x1998c
// Size: 0x8f
function devfindhost()
{
    hostplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( player ishost() )
        {
            hostplayer = player;
            break;
        }
    }
    
    return hostplayer;
}

// Namespace dev_mp
// Params 0
// Checksum 0x82423ee7, Offset: 0x19a24
// Size: 0x29
function watchlethaldelaycancel()
{
    while ( true )
    {
        if ( getdvarint( @"hash_6d6e240a9ede976e", 0 ) )
        {
            equipment_mp::cancellethaldelay();
            return;
        }
        
        wait 1;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x96887e8b, Offset: 0x19a55
// Size: 0x29
function watchsuperdelaycancel()
{
    while ( true )
    {
        if ( getdvarint( @"scr_superdelaycancel", 0 ) )
        {
            supers_mp::cancelsuperdelay();
            return;
        }
        
        wait 1;
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0xe872d8b7, Offset: 0x19a86
// Size: 0x6e
function watchslowmo()
{
    while ( true )
    {
        if ( getdvar( @"scr_slowmo", "" ) != "" )
        {
            break;
        }
        
        wait 1;
    }
    
    time = getdvarfloat( @"scr_slowmo" );
    setslowmotion( time, time, 0 );
    
    /#
        setdevdvar( @"scr_slowmo", "<dev string:x2f4>" );
    #/
    
    thread watchslowmo();
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2f5f077d, Offset: 0x19afc
    // Size: 0xd3, Type: dev
    function watchdoublejump()
    {
        doublejumpenabled = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_cd6c5be168321fbc", 0 ) != doublejumpenabled && level.players.size )
            {
                level notify( #"doublejumptoggle" );
                doublejumpenabled = !doublejumpenabled;
                
                foreach ( player in level.players )
                {
                    player allowdoublejump( doublejumpenabled );
                }
                
                if ( doublejumpenabled )
                {
                    level thread function_eec24cdcb2d04008();
                }
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x12294939, Offset: 0x19bd7
    // Size: 0x3b, Type: dev
    function function_eec24cdcb2d04008()
    {
        level endon( #"doublejumptoggle" );
        
        while ( true )
        {
            level waittill( #"player_spawned", player );
            player allowdoublejump( 1 );
        }
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x21964823, Offset: 0x19c1a
    // Size: 0x57, Type: dev
    function function_848e4513593acc9b( ent, radius, color )
    {
        ent endon( #"death" );
        
        while ( true )
        {
            thread debug::drawsphere( ent.origin, radius, 0.05, color );
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2700f135, Offset: 0x19c79
    // Size: 0x4f, Type: dev
    function function_3d9c9bee5a3e707()
    {
        var_d022c2300e79f200 = getdvarint( @"scr_soccerball_create", 0 );
        
        if ( var_d022c2300e79f200 > 0 )
        {
            if ( isdefined( level.setupsoccerball ) )
            {
                level thread [[ level.setupsoccerball ]]();
            }
            
            setdevdvar( @"scr_soccerball_create", 0 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6cf4ca7b, Offset: 0x19cd0
    // Size: 0x27e, Type: dev
    function function_483499ddbfdae929()
    {
        level endon( #"game_ended" );
        
        if ( getdvarint( @"scr_soccerball_warp" ) != 0 )
        {
            setdevdvar( @"scr_soccerball_warp", 0 );
            player = gamelogic_mp::gethostplayer();
            
            if ( isdefined( level.soccerballs ) )
            {
                var_3a6ac5fca6f100a5 = 1;
                var_d713a7c8d58158f5 = int( 0.333333 );
                offsetfwd = var_d713a7c8d58158f5 * 96;
                offsetlft = var_3a6ac5fca6f100a5 * 48 - 48;
                
                if ( var_d713a7c8d58158f5 % 2 != 0 )
                {
                    offsetlft += 24;
                }
                
                if ( !isdefined( offsetfwd ) )
                {
                    offsetfwd = 0;
                }
                
                if ( !isdefined( offsetlft ) )
                {
                    offsetlft = 0;
                }
                
                fwd = anglestoforward( player.angles ) * ( 72 + offsetfwd ) + ( 0, 0, 48 );
                lft = anglestoleft( player.angles ) * offsetlft;
                target = player.origin + fwd + lft;
                result = player.origin + fwd + lft;
                spawnang = ( 0, player getplayerangles( 1 )[ 1 ] + 180, 0 );
                angles = ( 0, 30, 0 );
                up = anglestoup( angles );
                forward = anglestoforward( angles );
                force = up * 500 + ( 0, 0, 80 );
                
                foreach ( ball in level.soccerballs )
                {
                    ball.visuals.origin = result + ( 0, 0, 18 );
                    ball.visuals physicslaunchserver( ball.visuals.origin, force );
                    
                    if ( isdefined( ball.var_fefca4aa4772092e ) )
                    {
                        ball [[ ball.var_fefca4aa4772092e ]]();
                    }
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd63fd4ab, Offset: 0x19f56
    // Size: 0x6f, Type: dev
    function function_7d2d52d9d13c1f5d()
    {
        giveemp = getdvarint( @"scr_give_cyberemp", 0 );
        
        if ( giveemp > 0 )
        {
            setdevdvar( @"scr_give_cyberemp", 0 );
            level.cyberemp.carrier = level.players[ 0 ];
            level.cyberemp gameobjects::setpickedup( level.players[ 0 ] );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa2b51a2, Offset: 0x19fcd
    // Size: 0x3c, Type: dev
    function function_646dd8d73f7c7241()
    {
        var_c319c52cbf3a3220 = getdvarint( @"scr_test_callback_group", 0 );
        
        if ( var_c319c52cbf3a3220 > 0 )
        {
            setdevdvar( @"scr_test_callback_group", 0 );
            callback_group::callback_test();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7e133d98, Offset: 0x1a011
    // Size: 0x161, Type: dev
    function function_2727e04dff0cb74f()
    {
        self endon( #"disconnect" );
        level endon( #"game_ended" );
        regen_interval = 0.15;
        self.devammoregen = 1;
        
        while ( true )
        {
            if ( getdvarint( @"scr_ammoregen" ) == 0 )
            {
                self.devammoregen = undefined;
                break;
            }
            
            foreach ( weapon in self.equippedweapons )
            {
                if ( !isnullweapon( weapon ) )
                {
                    ammostock = self getweaponammostock( weapon );
                    self setweaponammostock( weapon, ammostock + 1 );
                }
            }
            
            currentoffhand = self getcurrentoffhand( "<dev string:x1e4b>" );
            
            if ( !isnullweapon( currentoffhand ) )
            {
                currentammo = self getweaponammoclip( currentoffhand );
                self setweaponammoclip( currentoffhand, currentammo + 1 );
            }
            
            currentoffhand = self getcurrentoffhand( "<dev string:x1e5a>" );
            
            if ( !isnullweapon( currentoffhand ) )
            {
                currentammo = self getweaponammoclip( currentoffhand );
                self setweaponammoclip( currentoffhand, currentammo + 1 );
            }
            
            wait regen_interval;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6c46d81d, Offset: 0x1a17a
    // Size: 0x2be, Type: dev
    function function_8ac81ab36da0ded7()
    {
        setdevdvarifuninitialized( @"scr_testshock", 0 );
        setdevdvarifuninitialized( @"scr_testshockid", "<dev string:x2f4>" );
        setdevdvarifuninitialized( @"scr_testshockstop", 0 );
        level.var_3cccb16c72714bd5 = "<dev string:x1e6b>";
        level.var_50e8177e19120128 = [];
        level.var_f2946a34b20572b4 = [];
        level.var_bcc776d2a33ab31 = [];
        level.var_798d41483aa3975b = [];
        shockid = "<dev string:x1e6b>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1e77>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1e88>";
        level.var_bcc776d2a33ab31[ shockid ] = 4;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1e8e>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1e77>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1e88>";
        level.var_bcc776d2a33ab31[ shockid ] = 6;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1e9a>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1eab>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1ec1>";
        level.var_bcc776d2a33ab31[ shockid ] = 3;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1ec6>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1eab>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1ec1>";
        level.var_bcc776d2a33ab31[ shockid ] = 6;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1ed7>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1ee1>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1ef6>";
        level.var_bcc776d2a33ab31[ shockid ] = 0.5;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1efa>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1f04>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1ef6>";
        level.var_bcc776d2a33ab31[ shockid ] = 0.5;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1f19>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1f23>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1f19>";
        level.var_bcc776d2a33ab31[ shockid ] = 0.5;
        level.var_798d41483aa3975b[ shockid ] = undefined;
        shockid = "<dev string:x1f33>";
        level.var_50e8177e19120128[ shockid ] = "<dev string:x1f3a>";
        level.var_f2946a34b20572b4[ shockid ] = "<dev string:x1f33>";
        level.var_bcc776d2a33ab31[ shockid ] = 0.5;
        level.var_798d41483aa3975b[ shockid ] = undefined;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xa44b9952, Offset: 0x1a440
    // Size: 0xeb, Type: dev
    function shellshocktest( shockid )
    {
        if ( shockid == "<dev string:x2f4>" )
        {
            shockid = level.var_3cccb16c72714bd5;
        }
        
        assert( isdefined( level.var_50e8177e19120128 ), "<dev string:x1f4a>" );
        assert( arraycontains( getarraykeys( level.var_50e8177e19120128 ), shockid ), "<dev string:x1f7e>" );
        player = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( !player player::isreallyalive() )
        {
            return;
        }
        
        name = level.var_50e8177e19120128[ shockid ];
        category = level.var_f2946a34b20572b4[ shockid ];
        duration = level.var_bcc776d2a33ab31[ shockid ];
        interruptdelayms = level.var_798d41483aa3975b[ shockid ];
        player shellshock_utility_cpmp::_shellshock( name, category, duration, undefined, interruptdelayms );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x73c49bf4, Offset: 0x1a533
    // Size: 0x34, Type: dev
    function function_2f28ec2b67f23082()
    {
        player = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( !player player::isreallyalive() )
        {
            return;
        }
        
        shellshock_utility_cpmp::_stopshellshock( 0 );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xcf06a37e, Offset: 0x1a56f
    // Size: 0x4e, Type: dev
    function devcanspawnvehicle( player )
    {
        if ( !player player::isreallyalive() )
        {
            return 0;
        }
        
        if ( player utility::isusingremote() )
        {
            return 0;
        }
        
        if ( player.inlaststand )
        {
            return 0;
        }
        
        if ( isdefined( player.vehicle ) )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xd60efd4c, Offset: 0x1a5c5
    // Size: 0x2c, Type: dev
    function function_955bf5ac1af8d697( vehicletype )
    {
        player = devfindhost();
        
        if ( !isalive( player ) )
        {
            return;
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xb8613a86, Offset: 0x1a5f9
    // Size: 0x2c, Type: dev
    function function_4ad50366843701ec( vehicletype )
    {
        player = devfindhost();
        
        if ( !isalive( player ) )
        {
            return;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xab0ba2b3, Offset: 0x1a62d
    // Size: 0xc8, Type: dev
    function function_c5b4cae06ed2fea7()
    {
        level notify( #"hash_ac826e4e879175e6" );
        level endon( #"hash_ac826e4e879175e6" );
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player supers_mp::getcurrentsuper() ) && !player supers_mp::issuperready() )
                {
                    player thread supers_mp::givesuperpoints( player supers_mp::getsuperpointsneeded(), undefined, 1 );
                }
            }
            
            wait 0.25;
        }
    }

#/

// Namespace dev_mp
// Params 0
// Checksum 0x7ee73022, Offset: 0x1a6fd
// Size: 0x9
function rangefinder()
{
    thread rangefinder::runmprangefinder();
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe367c346, Offset: 0x1a70e
    // Size: 0xfc, Type: dev
    function watchttk()
    {
        var_f226f21d0168d336 = 0;
        
        while ( true )
        {
            var_eaa543b39e19908c = getdvarint( @"hash_969cec4a11333d98", 0 );
            
            if ( var_eaa543b39e19908c != var_f226f21d0168d336 && isdefined( level.players ) )
            {
                attacker = level.players[ 0 ];
                var_f226f21d0168d336 = var_eaa543b39e19908c;
                
                if ( var_eaa543b39e19908c == 0 )
                {
                    attacker notify( #"hash_e82fbc6de384ea08" );
                    iprintlnbold( "<dev string:x1fae>" );
                }
                else
                {
                    level.ttkdata = spawnstruct();
                    level.ttkdata.avgttk = 0;
                    level.ttkdata.ttktimes = [];
                    level.ttkdata.lastttk = 0;
                    attacker thread function_1c4cec5485338f27();
                    attacker thread function_b0afbc999d8bb2ce();
                    attacker thread function_e12fc27339d13df9();
                    attacker thread displayttk();
                    iprintlnbold( "<dev string:x1fc8>" );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9d82b7bb, Offset: 0x1a812
    // Size: 0x13e, Type: dev
    function displayttk()
    {
        self endon( #"hash_e82fbc6de384ea08" );
        lastttk = 0;
        avgttk = 0;
        numkills = 0;
        
        while ( true )
        {
            if ( isdefined( level.ttkdata ) )
            {
                if ( isdefined( level.ttkdata.ttktimes ) )
                {
                    numkills = level.ttkdata.ttktimes.size;
                }
                
                if ( isdefined( level.ttkdata.lastttk ) )
                {
                    lastttk = level.ttkdata.lastttk;
                }
                
                if ( isdefined( level.ttkdata.avgttk ) )
                {
                    avgttk = level.ttkdata.avgttk;
                }
            }
            
            printtoscreen2d( 500, 170, "<dev string:x1fe1>" + string( lastttk ), ( 1, 1, 1 ), 2 );
            printtoscreen2d( 500, 200, "<dev string:x1fed>" + string( avgttk ), ( 1, 1, 1 ), 2 );
            printtoscreen2d( 500, 230, "<dev string:x2001>" + string( numkills ), ( 1, 1, 1 ), 2 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x50ac92a0, Offset: 0x1a958
    // Size: 0x17a, Type: dev
    function function_1c4cec5485338f27()
    {
        self endon( #"hash_e82fbc6de384ea08" );
        
        while ( true )
        {
            self waittill( #"victim_damaged", victim, inflictor, damage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc );
            
            if ( !isdefined( victim.ttkdata ) )
            {
                ttkdata = spawnstruct();
                ttkdata.time = gettime();
                victim.ttkdata = ttkdata;
            }
            
            if ( !isalive( victim ) && isdefined( victim.ttkdata ) )
            {
                ttk = float( gettime() - victim.ttkdata.time ) / 1000;
                level.ttkdata.lastttk = ttk;
                print3d( victim.origin + ( 0, 0, 14 ), "<dev string:x2013>" + string( ttk ) + "<dev string:x2019>", ( 1, 0.843, 0 ), 1, 0.5, 400, 1 );
                level notify( #"victim_killed" );
                victim.ttkdata = undefined;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x67f7556d, Offset: 0x1aada
    // Size: 0x78, Type: dev
    function function_b0afbc999d8bb2ce()
    {
        self endon( #"hash_e82fbc6de384ea08" );
        
        while ( true )
        {
            self waittill( #"victim_armor_damaged", victim, inflictor );
            
            if ( !isdefined( victim.ttkdata ) )
            {
                ttkdata = spawnstruct();
                ttkdata.time = gettime();
                victim.ttkdata = ttkdata;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2b0fdc9b, Offset: 0x1ab5a
    // Size: 0xd8, Type: dev
    function function_e12fc27339d13df9()
    {
        self endon( #"hash_e82fbc6de384ea08" );
        var_6012ada29e1f3cf2 = 0;
        var_77eeb66e79c96c96 = 0;
        var_f31b2f2d90ec3100 = 1;
        
        while ( true )
        {
            if ( var_f31b2f2d90ec3100 )
            {
                level notify( #"hash_c05486ae527112f5" );
                level.players[ 0 ] thread function_17d8d485f0bb9e00();
                var_f31b2f2d90ec3100 = 0;
            }
            
            if ( level.players[ 0 ] isswitchingweapon() && !var_6012ada29e1f3cf2 )
            {
                var_f31b2f2d90ec3100 = 1;
                var_6012ada29e1f3cf2 = 1;
            }
            else if ( !level.players[ 0 ] isswitchingweapon() )
            {
                var_6012ada29e1f3cf2 = 0;
            }
            
            if ( !isalive( level.players[ 0 ] ) && !var_77eeb66e79c96c96 )
            {
                var_f31b2f2d90ec3100 = 1;
                var_77eeb66e79c96c96 = 1;
            }
            else if ( isalive( level.players[ 0 ] ) )
            {
                var_77eeb66e79c96c96 = 0;
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x85e51bcb, Offset: 0x1ac3a
    // Size: 0xcd, Type: dev
    function function_17d8d485f0bb9e00()
    {
        self endon( #"hash_e82fbc6de384ea08" );
        level endon( #"hash_c05486ae527112f5" );
        level.ttkdata.avgttk = 0;
        level.ttkdata.ttktimes = [];
        
        while ( true )
        {
            level waittill( #"victim_killed" );
            level.ttkdata.ttktimes[ level.ttkdata.ttktimes.size ] = level.ttkdata.lastttk;
            level.ttkdata.avgttk = script::limitdecimalplaces( utility::array_average( level.ttkdata.ttktimes ), 3 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7522eae1, Offset: 0x1ad0f
    // Size: 0xaf, Type: dev
    function watchdam()
    {
        var_dcd4881dae5e152d = 0;
        
        while ( true )
        {
            var_453cdb2f5ee6c47 = getdvarint( @"hash_81d89e4abec64203", 0 );
            
            if ( var_453cdb2f5ee6c47 != var_dcd4881dae5e152d )
            {
                attacker = level.players[ 0 ];
                var_dcd4881dae5e152d = var_453cdb2f5ee6c47;
                
                if ( var_453cdb2f5ee6c47 == 0 )
                {
                    attacker notify( #"hash_669453ed8479a1b3" );
                    iprintlnbold( "<dev string:x201b>" );
                }
                else
                {
                    attacker = level.players[ 0 ];
                    attacker thread function_20fc8bf051d21e84();
                    attacker thread function_99d8325f521c8e9d();
                    attacker thread function_b72a976339949a73();
                    attacker thread function_aced886a80e8bdc2();
                    iprintlnbold( "<dev string:x202f>" );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x54ea5b06, Offset: 0x1adc6
    // Size: 0x8e, Type: dev
    function function_20fc8bf051d21e84()
    {
        self endon( #"hash_669453ed8479a1b3" );
        
        while ( true )
        {
            self waittill( #"victim_damaged", victim, inflictor, damage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc );
            function_1b4a05253a9a0622( victim, self, damage );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x50691b4b, Offset: 0x1ae5c
    // Size: 0x8e, Type: dev
    function function_99d8325f521c8e9d()
    {
        self endon( #"hash_669453ed8479a1b3" );
        
        while ( true )
        {
            self waittill( #"hash_3a789df9d545be13", victim, inflictor, damage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc );
            function_1b4a05253a9a0622( victim, self, damage );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc4b79863, Offset: 0x1aef2
    // Size: 0x52, Type: dev
    function function_b72a976339949a73()
    {
        self endon( #"hash_669453ed8479a1b3" );
        
        while ( true )
        {
            self waittill( #"victim_armor_damaged", victim, inflictor, damage );
            function_1b4a05253a9a0622( victim, self, damage );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc3fcd78f, Offset: 0x1af4c
    // Size: 0x20d, Type: dev
    function function_aced886a80e8bdc2()
    {
        self endon( #"hash_669453ed8479a1b3" );
        dam = 0;
        totaldam = 0;
        var_8e047bc199265cae = 0;
        encstatus = 0;
        
        while ( true )
        {
            if ( isdefined( level.currentvictim ) && isdefined( level.currentvictim.damdata ) )
            {
                if ( isdefined( level.currentvictim.damdata.dam ) )
                {
                    dam = level.currentvictim.damdata.dam;
                }
                
                if ( isdefined( level.currentvictim.damdata.totaldam ) )
                {
                    totaldam = level.currentvictim.damdata.totaldam;
                }
                
                if ( isdefined( level.currentvictim.damdata.var_8e047bc199265cae ) )
                {
                    var_8e047bc199265cae = level.currentvictim.damdata.var_8e047bc199265cae;
                }
                
                if ( isdefined( level.currentvictim.damdata.encounteractive ) )
                {
                    encstatus = level.currentvictim.damdata.encounteractive;
                }
            }
            
            printtoscreen2d( 900, 170, "<dev string:x2042>" + string( dam ), ( 1, 0, 1 ), 2 );
            printtoscreen2d( 900, 200, "<dev string:x2053>" + string( totaldam ), ( 1, 0.843, 0 ), 2 );
            printtoscreen2d( 900, 230, "<dev string:x205f>" + string( var_8e047bc199265cae ), ( 1, 0.843, 0 ), 2 );
            printtoscreen2d( 900, 260, "<dev string:x2075>" + ( encstatus ? "<dev string:x2081>" : "<dev string:x2088>" ), ( 1, 0.843, 0 ), 2 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x4ba99fa2, Offset: 0x1b161
    // Size: 0x7c, Type: dev
    function function_226e17d8f442784b( victim )
    {
        self notify( #"hash_ae8cd6968c1392b4" );
        self endon( #"hash_ae8cd6968c1392b4" );
        self endon( #"hash_669453ed8479a1b3" );
        victim.damdata.encounteractive = 1;
        wait 5;
        victim.damdata.var_bbf823d270e248d5 = 0;
        victim.damdata.encounteractive = 0;
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xfca5a723, Offset: 0x1b1e5
    // Size: 0x1ab, Type: dev
    function function_1b4a05253a9a0622( victim, attacker, damage )
    {
        level.currentvictim = victim;
        
        if ( !isdefined( victim.damdata ) || victim.damdata.isalive == 0 )
        {
            damdata = spawnstruct();
            damdata.dam = 0;
            damdata.totaldam = 0;
            damdata.var_8e047bc199265cae = 0;
            damdata.var_bbf823d270e248d5 = 0;
            damdata.combattimestamp = 0;
            damdata.encounteractive = 0;
            damdata.isalive = 1;
            victim.damdata = damdata;
        }
        
        victim.damdata.dam = damage;
        victim.damdata.totaldam += damage;
        victim.damdata.var_bbf823d270e248d5 += damage;
        victim.damdata.var_8e047bc199265cae = victim.damdata.var_bbf823d270e248d5;
        attacker thread function_226e17d8f442784b( victim );
        
        if ( !isalive( victim ) && isdefined( victim.damdata ) )
        {
            victim.damdata.isalive = 0;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xcc2a523e, Offset: 0x1b398
    // Size: 0x15c, Type: dev
    function function_e11e2566936f34b()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_5d008081f52285c9", 0 ) == 1 && isdefined( level.players[ 0 ] ) )
            {
                vel = level.players[ 0 ] getvelocity();
                speed = length( vel );
                speedmph = speed * 0.056818;
                var_4cb2e12ee3a1b7da = speed * 0.0254;
                var_d9c0d6bd95b1fc90 = string( vel[ 0 ] );
                var_d9c0d7bd95b1fec3 = string( vel[ 1 ] );
                var_d9c0d8bd95b200f6 = string( vel[ 2 ] );
                printtoscreen2d( 500, 260, "<dev string:x2091>" + var_d9c0d6bd95b1fc90 + "<dev string:x3f8>" + var_d9c0d7bd95b1fec3 + "<dev string:x3f8>" + var_d9c0d8bd95b200f6, ( 1, 1, 1 ), 2 );
                printtoscreen2d( 500, 290, "<dev string:x20b5>" + string( speed ), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 500, 320, "<dev string:x20da>" + string( speedmph ), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 500, 350, "<dev string:x20fc>" + string( var_4cb2e12ee3a1b7da ), ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x58d89a37, Offset: 0x1b4fc
    // Size: 0x102, Type: dev
    function function_379ebea10b2976b6()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        var_76b94323f51c0fa1 = 0;
        sprintouttime = 0;
        var_f1824b6c0b0cfc82 = 0;
        var_65053683c6b34d45 = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_e8bf0eb1142e2bf0", 0 ) == 1 && isdefined( level.players ) )
            {
                if ( var_f1824b6c0b0cfc82 )
                {
                    if ( level.players[ 0 ] attackbuttonpressed() )
                    {
                        var_65053683c6b34d45 = 1;
                        var_76b94323f51c0fa1 = gettime();
                    }
                }
                
                if ( level.players[ 0 ] issprinting() )
                {
                    var_f1824b6c0b0cfc82 = 1;
                }
                else
                {
                    var_f1824b6c0b0cfc82 = 0;
                }
                
                if ( var_65053683c6b34d45 && level.players[ 0 ] isshooting() )
                {
                    sprintouttime = gettime() - var_76b94323f51c0fa1;
                    sprintouttime /= 1000;
                    var_65053683c6b34d45 = 0;
                }
                
                printtoscreen2d( 500, 350, "<dev string:x2125>" + string( sprintouttime ), ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x87e635a3, Offset: 0x1b606
    // Size: 0x173, Type: dev
    function watchtacsprint()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        totaldistance = 0;
        sprintdetected = 0;
        originposition = level.players[ 0 ].origin;
        sprintouttime = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_43a6786b8ff8bc8e", 0 ) == 1 && isdefined( level.players ) )
            {
                var_379fde5f25cc9db6 = level.players[ 0 ] issupersprinting();
                
                if ( var_379fde5f25cc9db6 && !sprintdetected )
                {
                    sprintdetected = 1;
                    var_76b94323f51c0fa1 = gettime();
                    originposition = level.players[ 0 ].origin;
                }
                
                if ( !var_379fde5f25cc9db6 )
                {
                    sprintdetected = 0;
                }
                else
                {
                    sprintouttime = gettime() - var_76b94323f51c0fa1;
                    sprintouttime /= 1000;
                    totaldistance = distance2d( level.players[ 0 ].origin, originposition );
                }
                
                text_time = "<dev string:x213d>" + string( sprintouttime );
                printtoscreen2d( 500, 400, text_time, ( 1, 1, 1 ), 2 );
                text_distance = "<dev string:x214a>" + string( totaldistance );
                printtoscreen2d( 500, 350, text_distance, ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6f336c26, Offset: 0x1b781
    // Size: 0xe2, Type: dev
    function function_a1d2cba3700cfaa6()
    {
        var_20f44b4bf7db7b9b = 0;
        var_9ccaeced7ade3ba1 = 0;
        var_2c13e0058e5bc144 = 1;
        var_8262a73f8265b909 = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_debd4bed61a9b4dc", 0 ) == 1 && isdefined( level.players ) )
            {
                if ( level.players[ 0 ] playerads() == 0 )
                {
                    var_2c13e0058e5bc144 = 1;
                    var_8262a73f8265b909 = 0;
                }
                else if ( var_2c13e0058e5bc144 )
                {
                    var_2c13e0058e5bc144 = 0;
                    var_20f44b4bf7db7b9b = gettime();
                }
                
                if ( level.players[ 0 ] playerads() == 1 && !var_8262a73f8265b909 )
                {
                    var_9ccaeced7ade3ba1 = gettime() - var_20f44b4bf7db7b9b;
                    var_9ccaeced7ade3ba1 /= 1000;
                    var_8262a73f8265b909 = 1;
                }
                
                printtoscreen2d( 500, 380, "<dev string:x2155>" + string( var_9ccaeced7ade3ba1 ), ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x37c45282, Offset: 0x1b86b
    // Size: 0xc9, Type: dev
    function watchreloadtime()
    {
        initreloadtime = 0;
        reloadtime = 0;
        var_4bd144c419c61047 = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_4fea842213b31f9b", 0 ) == 1 && isdefined( level.players ) )
            {
                if ( level.players[ 0 ] isreloading() && !var_4bd144c419c61047 )
                {
                    initreloadtime = gettime();
                    var_4bd144c419c61047 = 1;
                }
                
                if ( !level.players[ 0 ] isreloading() && var_4bd144c419c61047 )
                {
                    reloadtime = gettime() - initreloadtime;
                    reloadtime /= 1000;
                    var_4bd144c419c61047 = 0;
                }
                
                printtoscreen2d( 500, 410, "<dev string:x216d>" + string( reloadtime ), ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe82c1327, Offset: 0x1b93c
    // Size: 0xd8, Type: dev
    function function_2688c04a12ade9fb()
    {
        level.targetdistance = 0;
        level.var_13310d079107a52e = 0;
        var_38e024508c595a8e = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_11544fe0c704e8fd", 0 ) == 1 && isdefined( level.players ) )
            {
                level.players[ 0 ] thread function_21f3cd424e592f0f();
                var_38e024508c595a8e = 1;
                printtoscreen2d( 500, 440, "<dev string:x2181>" + string( level.targetdistance ), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 500, 470, "<dev string:x219a>" + string( level.var_13310d079107a52e ), ( 1, 1, 1 ), 2 );
            }
            else if ( var_38e024508c595a8e )
            {
                level notify( #"hash_60eb9812e017c149" );
                var_38e024508c595a8e = 0;
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3b73dcd3, Offset: 0x1ba1c
    // Size: 0xe2, Type: dev
    function function_21f3cd424e592f0f()
    {
        level endon( #"hash_60eb9812e017c149" );
        
        while ( true )
        {
            self waittill( #"victim_damaged", victim, inflictor, damage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc );
            iprintlnbold( "<dev string:x21b7>" );
            playerorigin = level.players[ 0 ] getorigin();
            targetorigin = victim getorigin();
            targetdistance = distance( playerorigin, targetorigin );
            level.targetdistance = targetdistance;
            level.var_13310d079107a52e = targetdistance / 39.37;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbc54c1f4, Offset: 0x1bb06
    // Size: 0xed, Type: dev
    function function_68bd59a6149550fb()
    {
        currentdvar = getdvarint( @"scr_bot_maxhealth" );
        
        while ( true )
        {
            if ( currentdvar != getdvarint( @"scr_bot_maxhealth" ) )
            {
                currentdvar = getdvarint( @"scr_bot_maxhealth" );
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        player.maxhealth = currentdvar;
                        player.health = level.boardai.maxhealth;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x65551c02, Offset: 0x1bbfb
    // Size: 0x84, Type: dev
    function watchbotspawn()
    {
        while ( true )
        {
            level waittill( #"player_spawned", player );
            botmaxhealth = getdvarint( @"scr_bot_maxhealth" );
            
            if ( isbot( player ) && botmaxhealth )
            {
                player.maxhealth = getdvarint( @"scr_bot_maxhealth" );
                player.health = level.boardai.maxhealth;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb9e17e0, Offset: 0x1bc87
    // Size: 0x1c9, Type: dev
    function function_eab6bc4695e6be93()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b8ecadb3f0f39c29" ) == 1 && isdefined( level.players ) )
            {
                ybase = 500;
                
                if ( getdvarint( @"hash_d1415bb7a04b48f9" ) == 1 )
                {
                    ybase = 300;
                }
                
                player = level.players[ 0 ];
                currentweapon = player getcurrentweapon();
                weapons = player getweaponslistall();
                printtoscreen2d( 1000, ybase, "<dev string:x21c4>", ( 1, 1, 1 ), 2 );
                i = 0;
                
                foreach ( weapon in weapons )
                {
                    str = weapon.basename;
                    
                    if ( weapon.isalternate )
                    {
                        str += "<dev string:x21d2>";
                    }
                    
                    slot = player getweaponslot( weapon );
                    str += "<dev string:x356>";
                    str += slot;
                    
                    if ( weapon == currentweapon )
                    {
                        str += "<dev string:x21d9>";
                    }
                    
                    if ( function_77cf0915f575a9d9( weapon ) )
                    {
                        if ( function_773c57b8a7042994( weapon ) )
                        {
                            str += "<dev string:x21e3>";
                        }
                        else
                        {
                            str += "<dev string:x21f9>";
                        }
                    }
                    
                    printtoscreen2d( 1000, ybase + 28 + 28 * i, str, ( 1, 1, 1 ), 2 );
                    i++;
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x326bf6d8, Offset: 0x1be58
    // Size: 0x15e, Type: dev
    function function_825310e06cbd8db7()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_d1415bb7a04b48f9" ) == 1 && isdefined( level.players ) )
            {
                ybase = 500;
                
                if ( getdvarint( @"hash_b8ecadb3f0f39c29" ) == 1 )
                {
                    ybase = 700;
                }
                
                currentweapon = level.players[ 0 ] getcurrentweapon();
                attachments = currentweapon.attachments;
                default_attachments = getweapondefaultattachments( currentweapon );
                printtoscreen2d( 1000, ybase, "<dev string:x2206>", ( 1, 1, 1 ), 2 );
                i = 0;
                
                foreach ( attachment in attachments )
                {
                    if ( arraycontains( default_attachments, attachment ) )
                    {
                        attachment += "<dev string:x2218>";
                    }
                    
                    printtoscreen2d( 1000, ybase + 28 + 28 * i, attachment, ( 1, 1, 1 ), 2 );
                    i++;
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbb294a8, Offset: 0x1bfbe
    // Size: 0x2c5, Type: dev
    function function_ea776c407880d52()
    {
        overridecolor = ( 0, 0.7, 0 );
        white = ( 1, 1, 1 );
        defaultcontext = "<dev string:x2223>";
        
        while ( true )
        {
            if ( getdvarint( @"hash_b5df8cb15e263558" ) == 1 && level.players.size )
            {
                gamemodecontext = level.gamemodebundle.var_6748b10750236616 ?? defaultcontext;
                gametypecontext = level.gametypebundle.var_dd8602136acdf333 ?? defaultcontext;
                
                if ( isxhash( gamemodecontext ) )
                {
                    gamemodecontext = getxhashsourcename( gamemodecontext );
                }
                
                if ( isxhash( gametypecontext ) )
                {
                    gametypecontext = getxhashsourcename( gametypecontext );
                }
                
                currentweapon = level.players[ 0 ] getcurrentweapon();
                attachments = currentweapon.attachments;
                default_attachments = getweapondefaultattachments( currentweapon );
                var_9369eac581d943de = function_e83ca2951c6a1fe7( currentweapon );
                var_3a8c136968600430 = issubstr( var_9369eac581d943de, "<dev string:x222b>" ) ? white : overridecolor;
                printtoscreen2d( 1000, 400, "<dev string:x2237>", white, 2 );
                printtoscreen2d( 1145, 400, gamemodecontext, gamemodecontext != defaultcontext ? overridecolor : white, 2 );
                printtoscreen2d( 1000, 430, "<dev string:x2242>", white, 2 );
                printtoscreen2d( 1145, 430, gametypecontext, gametypecontext != defaultcontext ? overridecolor : white, 2 );
                printtoscreen2d( 1000, 460, "<dev string:x224d>", white, 2 );
                printtoscreen2d( 1355, 460, var_9369eac581d943de, var_3a8c136968600430, 2 );
                printtoscreen2d( 1000, 500, "<dev string:x2206>", ( 1, 1, 1 ), 2 );
                i = 0;
                vertspace = 32;
                
                foreach ( attachment in attachments )
                {
                    contextoverride = function_73d358715e96597e( currentweapon, attachment );
                    
                    if ( arraycontains( default_attachments, attachment ) )
                    {
                        attachment += "<dev string:x2218>";
                    }
                    
                    printtoscreen2d( 1000, 530 + vertspace * i, attachment, white, 2 );
                    i++;
                    
                    if ( contextoverride )
                    {
                        printtoscreen2d( 1000, 530 + vertspace * i, "<dev string:x2265>" + contextoverride, overridecolor, 2 );
                        i++;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4842067b, Offset: 0x1c28b
    // Size: 0x44, Type: dev
    function function_9487def91274e85e()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_d394d7c378e5d660", 0 ) == 1 && isdefined( level.players[ 0 ] ) )
            {
                function_43521a5167d62cac( level.players[ 0 ] );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x371e2227, Offset: 0x1c2d7
    // Size: 0x3a4, Type: dev
    function function_43521a5167d62cac( player )
    {
        numbercolor = ( 0, 0.7, 0 );
        white = ( 1, 1, 1 );
        currentstance = 2;
        stancename = player getstance();
        
        switch ( stancename )
        {
            case #"hash_3fed0cbd303639eb":
                currentstance = 3;
                break;
            case #"hash_d91940431ed7c605":
                currentstance = 4;
                break;
            case #"hash_c6775c88e38f7803":
            default:
                if ( player issprinting() )
                {
                    currentstance = 5;
                    stancename = "<dev string:x227c>";
                }
                
                break;
        }
        
        maxspeedboost = level.var_3d09e599104f58f3[ currentstance ] ?? 1.08;
        printtoscreen2d( 1100, 300, "<dev string:x2283>" + stancename + "<dev string:x2285>", white, 2 );
        printtoscreen2d( 1000, 300, "<dev string:x2f4>" + maxspeedboost, numbercolor, 2 );
        currentmovespeedscale = player.var_ed65a6b490a1f726 ?? 1;
        printtoscreen2d( 1100, 400, "<dev string:x2297>" + stancename + "<dev string:x22ac>", white, 2 );
        printtoscreen2d( 1000, 400, "<dev string:x2f4>" + currentmovespeedscale, numbercolor, 2 );
        i = 0;
        vertspace = 35;
        var_9a3c25e1fef098a = 450;
        var_85d08bfc134cca2d = 1000;
        var_e24c4dcf03e17063 = 1100;
        
        if ( !isarray( player.movespeedscalers ) )
        {
            return;
        }
        
        foreach ( key, scaler in player.movespeedscalers )
        {
            if ( isdefined( player.var_6ce8c611b34fbad0 ) && isdefined( scaler[ 1 ] ) && player.var_6ce8c611b34fbad0 & scaler[ 1 ] )
            {
                continue;
            }
            
            switch ( scaler[ 0 ] )
            {
                case 1:
                    if ( scaler[ currentstance ] )
                    {
                        printtoscreen2d( var_85d08bfc134cca2d, var_9a3c25e1fef098a + vertspace * i, "<dev string:x2f4>" + scaler[ currentstance ], numbercolor, 2 );
                        printtoscreen2d( var_e24c4dcf03e17063, var_9a3c25e1fef098a + vertspace * i, "<dev string:x22ae>" + key + "<dev string:x22ac>", white, 2 );
                    }
                    
                    break;
                case 3:
                    if ( scaler[ currentstance ] )
                    {
                        printtoscreen2d( var_85d08bfc134cca2d, var_9a3c25e1fef098a + vertspace * i, "<dev string:x2f4>" + scaler[ currentstance ], numbercolor, 2 );
                        printtoscreen2d( var_e24c4dcf03e17063, var_9a3c25e1fef098a + vertspace * i, "<dev string:x22c7>" + key + "<dev string:x22ac>", white, 2 );
                    }
                    
                    break;
                case 2:
                    printtoscreen2d( var_85d08bfc134cca2d, var_9a3c25e1fef098a + vertspace * i, "<dev string:x2f4>" + ( scaler[ 2 ] ?? 1 ), numbercolor, 2 );
                    printtoscreen2d( var_e24c4dcf03e17063, var_9a3c25e1fef098a + vertspace * i, "<dev string:x22e6>" + key + "<dev string:x22ac>", white, 2 );
                    break;
                case 0:
                default:
                    printtoscreen2d( var_85d08bfc134cca2d, var_9a3c25e1fef098a + vertspace * i, "<dev string:x2f4>" + ( scaler[ 2 ] ?? 1 ), numbercolor, 2 );
                    printtoscreen2d( var_e24c4dcf03e17063, var_9a3c25e1fef098a + vertspace * i, "<dev string:x2303>" + key + "<dev string:x22ac>", white, 2 );
                    break;
            }
            
            i++;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4fe37d7e, Offset: 0x1c683
    // Size: 0x54, Type: dev
    function function_159c6e0a46f803c()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_a59b8462ed17fe6e" ) == 1 )
            {
                currentweapon = level.players[ 0 ] getcurrentweapon();
                function_469a20d0c3eb6042( currentweapon );
                setdvar( @"hash_a59b8462ed17fe6e", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xe7d737e2, Offset: 0x1c6df
    // Size: 0xd8, Type: dev
    function function_469a20d0c3eb6042( weapon )
    {
        if ( !isweapon( weapon ) )
        {
            return;
        }
        
        attachments = weapon.attachments;
        filenum = openfile( "<dev string:x231a>", "<dev string:x2331>" );
        fprintln( filenum, weapon.basename );
        
        foreach ( attachment in attachments )
        {
            fprintln( filenum, "<dev string:x2337>" + attachment );
        }
        
        closefile( filenum );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe491df15, Offset: 0x1c7bf
    // Size: 0x179, Type: dev
    function function_b54d38db22001628()
    {
        level.devminimapvisible = 0;
        
        while ( true )
        {
            if ( !level.devminimapvisible && getdvarint( @"scr_devminimap_visible", 0 ) == 1 )
            {
                foreach ( player in level.players )
                {
                    if ( isai( player ) )
                    {
                        continue;
                    }
                    
                    player player::showminimap();
                }
                
                level.devminimapvisible = 1;
            }
            else if ( level.devminimapvisible && getdvarint( @"scr_devminimap_visible", 0 ) == 0 )
            {
                foreach ( player in level.players )
                {
                    if ( isai( player ) )
                    {
                        continue;
                    }
                    
                    player player::hideminimap( 1 );
                }
                
                level.devminimapvisible = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0x65b87b1f, Offset: 0x1c940
    // Size: 0x7e, Type: dev
    function function_7c8b72d92c9437be( navpoints, color, heightoffset )
    {
        if ( !isdefined( navpoints ) || navpoints.size == 0 )
        {
            return;
        }
        
        if ( !isdefined( heightoffset ) )
        {
            heightoffset = 0;
        }
        
        offsetvec = ( 0, 0, heightoffset );
        
        for ( i = 0; i < navpoints.size - 1 ; i++ )
        {
            line( navpoints[ i ] + offsetvec, navpoints[ i + 1 ] + offsetvec, color );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x964c338e, Offset: 0x1c9c6
    // Size: 0xdf, Type: dev
    function function_df7ad832ea350717()
    {
        owner = devfindhost();
        
        if ( !owner player::isreallyalive() )
        {
            return;
        }
        
        position = owner.origin + ( 0, 0, 1000 );
        angles = owner.angles * ( 0, 1, 0 );
        streakinfo = spawnstruct();
        streakinfo.bundle = killstreak_utility::function_f943c0602acdc2af( "<dev string:x406>" );
        vehicleisreserved = vehicle_tracking::reserve_vehicle();
        thread airdrop::dropkillstreakcratefromscriptedheli( undefined, undefined, "<dev string:x534>", owner.origin, owner.origin, owner.angles + ( 0, 180, 0 ), vehicleisreserved, streakinfo );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb32db502, Offset: 0x1caad
    // Size: 0x6e, Type: dev
    function function_10e2d6737b971498()
    {
        var_b3c523e221b02341 = 0;
        
        while ( true )
        {
            stickydvar = getdvarint( @"scr_airdrop_sticky", 0 );
            
            if ( stickydvar && !var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x2339>" );
                var_b3c523e221b02341 = 1;
            }
            else if ( !stickydvar && var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x234a>" );
                var_b3c523e221b02341 = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6e3a4f1f, Offset: 0x1cb23
    // Size: 0x6e, Type: dev
    function function_fc24d5db7ef0f5c3()
    {
        var_b3c523e221b02341 = 0;
        
        while ( true )
        {
            lockondvar = getdvarint( @"hash_10368af4dee3ba2c", 0 );
            
            if ( lockondvar && !var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x235c>" );
                var_b3c523e221b02341 = 1;
            }
            else if ( !lockondvar && var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x2370>" );
                var_b3c523e221b02341 = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x851337e0, Offset: 0x1cb99
    // Size: 0x6e, Type: dev
    function function_d188c6c1043e8cfb()
    {
        var_b3c523e221b02341 = 0;
        
        while ( true )
        {
            animtypedvar = getdvarint( @"hash_a59a7da9fa17c00", 0 );
            
            if ( animtypedvar && !var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x2385>" );
                var_b3c523e221b02341 = 1;
            }
            else if ( !animtypedvar && var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x239e>" );
                var_b3c523e221b02341 = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb16201d, Offset: 0x1cc0f
    // Size: 0x6e, Type: dev
    function function_39cae819df85950a()
    {
        var_b3c523e221b02341 = 0;
        
        while ( true )
        {
            crashtypedvar = getdvarint( @"scr_gunship_crash_type", 0 );
            
            if ( crashtypedvar && !var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x23b7>" );
                var_b3c523e221b02341 = 1;
            }
            else if ( !crashtypedvar && var_b3c523e221b02341 )
            {
                iprintln( "<dev string:x23cb>" );
                var_b3c523e221b02341 = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7468d968, Offset: 0x1cc85
    // Size: 0x14a, Type: dev
    function function_43813389429e5b7d()
    {
        setdevdvarifuninitialized( @"hash_c130f1690a235782", 0 );
        setdevdvarifuninitialized( @"hash_873b7ff40bb2a37e", 0 );
        setdevdvarifuninitialized( @"hash_5fbef6e1f0b6624c", 0 );
        level thread function_3ea720be96a67b0c( @"hash_5fbef6e1f0b6624c", 0, "<dev string:x23e2>", "<dev string:x23f8>" );
        level thread function_3ea720be96a67b0c( @"hash_2c01d701bac5d9d3", 0, "<dev string:x240f>", "<dev string:x242c>" );
        level thread function_3ea720be96a67b0c( @"scr_debugairstrike", 0, "<dev string:x244a>", "<dev string:x2462>" );
        level thread function_3ea720be96a67b0c( @"hash_c130f1690a235782", 0, "<dev string:x247b>", "<dev string:x24a0>" );
        level thread function_825076f9b4f9bd23();
        level thread function_4dbe912351f4f233();
        level thread function_aa3d464d72fdf102();
        level thread function_56a1580ac6e5b733();
        level thread function_2c66453cdb9eba8c();
        level thread function_c3d303f9750d0f6();
        level thread function_e54f9aad99d41e51();
        level thread function_5524a41f633a3bae();
        level thread function_72066192b3954695();
        level thread function_f9c32972761613a1();
        level thread function_b32beb2704a5f8f3();
        level thread function_1257629dfb08f6ac();
        level thread function_e1ae70d52146037d();
        level thread function_23765a48f7b28d55();
        level thread function_5fe42f84c1e2149b();
        level thread function_8f8a3f0d78afd403();
        level thread function_4bf102fe77e8ec51();
        level thread function_63beeb9651cb5de6();
        level thread function_bab0fbcd1d4523f7();
        level thread function_d6695d784a2b836();
        level thread function_3f53f787586eeccf();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9bdb5d32, Offset: 0x1cdd7
    // Size: 0x49, Type: dev
    function function_825076f9b4f9bd23()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level waittill( #"connected", player );
            player callback::add( #"killstreak_activated", &function_a2264ad30e78e175 );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x67afed05, Offset: 0x1ce28
    // Size: 0x5e, Type: dev
    function function_a2264ad30e78e175( params )
    {
        if ( !getdvarint( @"hash_c130f1690a235782", 0 ) )
        {
            return;
        }
        
        if ( self != params.streakitem.owner )
        {
            return;
        }
        
        killstreaks::awardkillstreak( params.streakitem.streakname, "<dev string:x459>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2c97d739, Offset: 0x1ce8e
    // Size: 0x4d, Type: dev
    function function_4dbe912351f4f233()
    {
        level thread function_d188c6c1043e8cfb();
        level thread function_39cae819df85950a();
        level thread function_3ea720be96a67b0c( @"hash_9a9f1499825922aa", 0, "<dev string:x24c6>", "<dev string:x24de>" );
        level thread function_3ea720be96a67b0c( @"hash_cc9d9505b48bc357", 0, "<dev string:x24f7>", "<dev string:x250e>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x220d970f, Offset: 0x1cee3
    // Size: 0x5a, Type: dev
    function function_aa3d464d72fdf102()
    {
        level thread function_3ea720be96a67b0c( @"hash_35e0e06e57d92306", 0, "<dev string:x2525>", "<dev string:x2533>" );
        level thread function_3ea720be96a67b0c( @"hash_aff3efc76e4dfeb2", 1, "<dev string:x2542>", "<dev string:x2553>" );
        level thread function_3ea720be96a67b0c( @"hash_7943c6ec7e44f87c", 0, "<dev string:x2565>", "<dev string:x2586>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1066b5a1, Offset: 0x1cf45
    // Size: 0x26, Type: dev
    function function_56a1580ac6e5b733()
    {
        level thread function_3ea720be96a67b0c( @"hash_ac7f6a636682c52f", 0, "<dev string:x25a4>", "<dev string:x25b7>", "<dev string:x25cb>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x91a096a4, Offset: 0x1cf73
    // Size: 0x3d, Type: dev
    function function_2c66453cdb9eba8c()
    {
        level thread function_3ea720be96a67b0c( @"hash_91f047e0dec87b64", 0, "<dev string:x25d6>", "<dev string:x25e8>" );
        level thread function_3ea720be96a67b0c( @"hash_fd16625ce7800c7e", 0, "<dev string:x25fb>", "<dev string:x260b>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc2457a80, Offset: 0x1cfb8
    // Size: 0x4a, Type: dev
    function function_c3d303f9750d0f6()
    {
        level thread function_10e2d6737b971498();
        level thread function_3ea720be96a67b0c( @"scr_airdrop_ownership", 0, "<dev string:x261c>", "<dev string:x262e>", "<dev string:x2640>" );
        level thread function_3ea720be96a67b0c( @"hash_a62fccdf77b23d67", 0, "<dev string:x2655>", "<dev string:x2663>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x79eaf9bb, Offset: 0x1d00a
    // Size: 0x3d, Type: dev
    function function_e54f9aad99d41e51()
    {
        level thread function_3ea720be96a67b0c( @"hash_b72a0bb47130fb8e", 0, "<dev string:x2672>", "<dev string:x2686>" );
        level thread function_3ea720be96a67b0c( @"hash_51c63714caa01867", 0, "<dev string:x269b>", "<dev string:x26b1>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x657ce989, Offset: 0x1d04f
    // Size: 0x59, Type: dev
    function function_5524a41f633a3bae()
    {
        level thread function_3ea720be96a67b0c( @"hash_48714771f0d0b941", 0, "<dev string:x26c8>", "<dev string:x26e2>" );
        level thread function_3ea720be96a67b0c( @"hash_de4ffc2e910521a1", 0, "<dev string:x26fd>", "<dev string:x271b>" );
        level thread function_3ea720be96a67b0c( @"hash_125a1951df8627f5", 0, "<dev string:x273a>", "<dev string:x2752>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc0a4d2ec, Offset: 0x1d0b0
    // Size: 0x45, Type: dev
    function function_72066192b3954695()
    {
        level thread function_3ea720be96a67b0c( @"hash_3f1bd355bf340abb", 0, "<dev string:x276b>", "<dev string:x2785>" );
        level thread function_3ea720be96a67b0c( @"scr_juggernaut_execution", 0, "<dev string:x27a0>", "<dev string:x27c5>" );
        level thread function_563a6756d59a8e04();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9725d05f, Offset: 0x1d0fd
    // Size: 0x3d, Type: dev
    function function_f9c32972761613a1()
    {
        level thread function_3ea720be96a67b0c( @"scr_death_switch_type", 0, "<dev string:x27eb>", "<dev string:x280c>" );
        level thread function_3ea720be96a67b0c( @"hash_9564fda23c9d6dbd", 0, "<dev string:x2829>", "<dev string:x283e>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd71114c8, Offset: 0x1d142
    // Size: 0x3d, Type: dev
    function function_b32beb2704a5f8f3()
    {
        level thread function_3ea720be96a67b0c( @"hash_f91acea7f6a68742", 0, "<dev string:x2854>", "<dev string:x2867>" );
        level thread function_3ea720be96a67b0c( @"hash_189e3806377f69dc", 0, "<dev string:x287b>", "<dev string:x288c>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xba53a006, Offset: 0x1d187
    // Size: 0x59, Type: dev
    function function_1257629dfb08f6ac()
    {
        level thread function_3ea720be96a67b0c( @"hash_b23e7bb60bbe76a6", 0, "<dev string:x289e>", "<dev string:x28b1>" );
        level thread function_3ea720be96a67b0c( @"hash_7d1382405485d79f", 0, "<dev string:x28c5>", "<dev string:x28d8>" );
        level thread function_3ea720be96a67b0c( @"scr_helperdrone_visibility", 0, "<dev string:x28ec>", "<dev string:x290e>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc65bcccc, Offset: 0x1d1e8
    // Size: 0x3d, Type: dev
    function function_e1ae70d52146037d()
    {
        level thread function_3ea720be96a67b0c( @"hash_c9bd691ce96079ac", 0, "<dev string:x2931>", "<dev string:x2949>" );
        level thread function_3ea720be96a67b0c( @"hash_e19e5d308effeda3", 0, "<dev string:x2962>", "<dev string:x2973>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf33d2b2c, Offset: 0x1d22d
    // Size: 0x21, Type: dev
    function function_23765a48f7b28d55()
    {
        level thread function_3ea720be96a67b0c( @"hash_30dee5c8d013379b", 0, "<dev string:x2984>", "<dev string:x2998>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8e3d4c4e, Offset: 0x1d256
    // Size: 0x59, Type: dev
    function function_5fe42f84c1e2149b()
    {
        level thread function_3ea720be96a67b0c( @"hash_f8c88d9bcfa63da3", 0, "<dev string:x29ad>", "<dev string:x29c3>" );
        level thread function_3ea720be96a67b0c( @"hash_e9159b47fbb642af", 0, "<dev string:x29da>", "<dev string:x29f3>" );
        level thread function_3ea720be96a67b0c( @"hash_94edbe8b5c5b8dd0", 0, "<dev string:x2a0d>", "<dev string:x2a24>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd490bcb9, Offset: 0x1d2b7
    // Size: 0x3d, Type: dev
    function function_8f8a3f0d78afd403()
    {
        level thread function_3ea720be96a67b0c( @"scr_cruise_collision_debug", 0, "<dev string:x2a3c>", "<dev string:x2a4f>" );
        level thread function_3ea720be96a67b0c( @"hash_8a48b9267ed26d75", 0, "<dev string:x2a63>", "<dev string:x2a7a>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x231ebec1, Offset: 0x1d2fc
    // Size: 0x21, Type: dev
    function function_4bf102fe77e8ec51()
    {
        level thread function_3ea720be96a67b0c( @"hash_604652367665c1e0", 0, "<dev string:x2a91>", "<dev string:x2aa2>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x3b4ffa06, Offset: 0x1d325
    // Size: 0x21, Type: dev
    function function_63beeb9651cb5de6()
    {
        level thread function_3ea720be96a67b0c( @"hash_a34a2f5a7d33e3bb", 0, "<dev string:x2ab4>", "<dev string:x2aca>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x137f5df3, Offset: 0x1d34e
    // Size: 0x21, Type: dev
    function function_bab0fbcd1d4523f7()
    {
        level thread function_3ea720be96a67b0c( @"hash_7a4ebc4260fba96c", 0, "<dev string:x2ae1>", "<dev string:x2aeb>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe8bb2716, Offset: 0x1d377
    // Size: 0x21, Type: dev
    function function_d6695d784a2b836()
    {
        level thread function_3ea720be96a67b0c( @"scr_drill_charge_bomb_debug", 0, "<dev string:x2af5>", "<dev string:x2b10>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc8b643, Offset: 0x1d3a0
    // Size: 0x22, Type: dev
    function function_3f53f787586eeccf()
    {
        level thread function_3ea720be96a67b0c( @"hash_63063170f450a026", 1, "<dev string:x2b2c>", "<dev string:x2b4a>" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x9bf17f4f, Offset: 0x1d3ca
    // Size: 0x5a, Type: dev
    function private function_f20edabc64d0f700()
    {
        if ( level.frameduration == 16 )
        {
            if ( !isdefined( level.var_34567397eb6fe733 ) )
            {
                level.var_34567397eb6fe733 = 0;
            }
            
            level.var_34567397eb6fe733++;
            var_2bff6ac6c76caadc = level.var_34567397eb6fe733 % 3;
            
            while ( var_2bff6ac6c76caadc > 0 )
            {
                var_2bff6ac6c76caadc--;
                waitframe();
            }
        }
    }

    // Namespace dev_mp
    // Params 5
    // Checksum 0xba411d1a, Offset: 0x1d42c
    // Size: 0xb8, Type: dev
    function function_3ea720be96a67b0c( scriptdvar, var_b46d5b7d31907232, var_ba1db7f4350ed938, var_31d6716cebf7c284, optionalnotify )
    {
        level endon( #"game_ended" );
        function_f20edabc64d0f700();
        var_b3c523e221b02341 = 0;
        
        while ( true )
        {
            debugdvar = getdvarint( scriptdvar, var_b46d5b7d31907232 );
            
            if ( debugdvar && !var_b3c523e221b02341 )
            {
                iprintln( var_ba1db7f4350ed938 );
                var_b3c523e221b02341 = 1;
                
                if ( isdefined( optionalnotify ) )
                {
                    level notify( optionalnotify );
                }
            }
            else if ( !debugdvar && var_b3c523e221b02341 )
            {
                iprintln( var_31d6716cebf7c284 );
                var_b3c523e221b02341 = 0;
                
                if ( isdefined( optionalnotify ) )
                {
                    level notify( optionalnotify );
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x901ae59c, Offset: 0x1d4ec
    // Size: 0x2a5, Type: dev
    function function_563a6756d59a8e04()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        level endon( #"game_ended" );
        level waittill( #"player_spawned" );
        var_76c801d6e559846d = @"hash_caba4093ed4a5d5d";
        
        while ( true )
        {
            if ( getdvarint( var_76c801d6e559846d, 0 ) == 1 )
            {
                numbots = 1;
                team = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        team = team_utility::getotherteam( player.team );
                        break;
                    }
                }
                
                setdvar( @"hash_12d23346fbacee91", 1 );
                setdvar( @"bot_disableattack", 1 );
                setdvar( @"bot_notarget", 1 );
                level thread [[ level.bot_funcs[ "<dev string:x2b6c>" ] ]]( numbots, team );
                println( "<dev string:x2b77>" );
                level waittill( #"player_spawned" );
                setdvar( @"hash_1c423b4190c17fda", 1 );
                setdvar( @"bot_demigodmode", 1 );
                var_9d161cf38a202d90 = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        var_9d161cf38a202d90 = player;
                        break;
                    }
                }
                
                juggconfig = juggernaut::function_7a7d89de25fa010c( level.streakglobals.streakbundles[ "<dev string:x1045>" ] );
                var_9d161cf38a202d90 juggernaut::jugg_makejuggernaut( juggconfig );
                var_9d161cf38a202d90 juggernaut::createjuggobjective();
                juggweapon = makeweapon( juggconfig.classstruct.loadoutprimary );
                var_9d161cf38a202d90 inventory_utility::_giveweapon( juggweapon );
                var_9d161cf38a202d90 inventory_utility::_switchtoweapon( juggweapon );
                setdvar( var_76c801d6e559846d, 0 );
                juggcontext = var_9d161cf38a202d90.juggcontext;
                var_9d161cf38a202d90 waittill( #"death_or_disconnect" );
                var_9d161cf38a202d90 juggernaut::cleanupjuggobjective( juggcontext );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2f005b34, Offset: 0x1d799
    // Size: 0x46e, Type: dev
    function function_6346beb01a5c7ce7()
    {
        level waittill( #"player_spawned" );
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_aa6b4147be329989" ) != 0 )
            {
                level.var_6c7b4b86de51a6a8 = 1;
                level.exfilactivetimer = getdvarint( @"scr_testexfilactivetimer", 30 );
                level.exfilextracttimer = getdvarint( @"scr_testexfilextracttimer", 60 );
                level.var_f7ae77d9d67a19d4 = [];
                goal = spawn( "<dev string:x2b9b>", host.origin, 0, 120, 128 );
                level.var_f7ae77d9d67a19d4[ level.var_f7ae77d9d67a19d4.size ] = goal;
                team = host.team;
                goal.team = team;
                exfilgoalent = spawn( "<dev string:x229>", goal.origin );
                exfilgoalent.angles = ( 0, 270, 0 );
                exfilgoalent.team = team;
                exfilgoalent.visibleteam = "<dev string:x2baa>";
                exfilgoalent.ownerteam = team;
                exfilgoalent.type = "<dev string:x2f4>";
                droppoint = exfilgoalent.origin;
                contentoverride = trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
                ignoreents = [];
                trace = trace::ray_trace( exfilgoalent.origin + ( 0, 0, 20 ), exfilgoalent.origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
                
                if ( isplayer( trace[ "<dev string:x205>" ] ) )
                {
                    trace[ "<dev string:x205>" ] = undefined;
                }
                
                if ( isdefined( trace ) )
                {
                    tempangle = randomfloat( 360 );
                    droporigin = trace[ "<dev string:x236>" ];
                    forward = ( cos( tempangle ), sin( tempangle ), 0 );
                    forward = vectornormalize( forward - trace[ "<dev string:x2bae>" ] * vectordot( forward, trace[ "<dev string:x2bae>" ] ) );
                    dropangles = vectortoangles( forward );
                    exfilgoalent.origin = droporigin;
                    exfilgoalent setmodel( "<dev string:x2bb5>" );
                    exfilgoalent setscriptablepartstate( "<dev string:x2bcb>", "<dev string:x2bd2>" );
                    exfilgoalent playloopsound( "<dev string:x2bd6>" );
                }
                
                goal.exfilgoalent = exfilgoalent;
                goal.exfilgoalent.exfilobjid = objidpoolmanager::requestobjectiveid( 99 );
                
                if ( goal.exfilgoalent.exfilobjid != -1 )
                {
                    objectivestate = "<dev string:x2be7>";
                    objidpoolmanager::objective_add_objective( goal.exfilgoalent.exfilobjid, objectivestate, goal.origin + ( 0, 0, 60 ) );
                    objidpoolmanager::objective_set_play_intro( goal.exfilgoalent.exfilobjid, 1 );
                    objidpoolmanager::objective_set_play_outro( goal.exfilgoalent.exfilobjid, 1 );
                    objidpoolmanager::objective_playermask_showtoall( goal.exfilgoalent.exfilobjid );
                    self.showworldicon = 1;
                }
                
                goal.exfilgoalent gameobjects::setobjectivestatusicons( "<dev string:x2bef>", "<dev string:x2c0b>", goal.exfilgoalent.exfilobjid );
                objective_sethot( goal.exfilgoalent.exfilobjid, 1 );
                waitframe();
                playfxontag( level.var_270b509f77c3333a[ "<dev string:x6a>" ], goal.exfilgoalent, "<dev string:x904>" );
                exfilactivetime = level.exfilactivetimer;
                wait exfilactivetime;
                goal.exfilnotactive = 0;
                goal notify( #"hash_9fa14d1d3e06e890" );
                goal.exfilgoalent gameobjects::setobjectivestatusicons( "<dev string:x2c27>", "<dev string:x2c0b>", goal.exfilgoalent.exfilobjid );
                setdevdvar( @"hash_aa6b4147be329989", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbe2c4cfc, Offset: 0x1dc0f
    // Size: 0xf0, Type: dev
    function function_ea08b5c90a80e45e()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_1ba5f3b69f0f55b8", 0 ) != 0 )
            {
                if ( !isdefined( level.players[ 0 ] ) )
                {
                    continue;
                }
                
                printtoscreen2d( 500, 500, "<dev string:x2c42>" + level.players[ 0 ] getleftstickx(), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 500, 550, "<dev string:x2c4c>" + level.players[ 0 ] getleftsticky(), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 1000, 500, "<dev string:x2c56>" + level.players[ 0 ] getrightstickx(), ( 1, 1, 1 ), 2 );
                printtoscreen2d( 1000, 550, "<dev string:x2c60>" + level.players[ 0 ] getrightsticky(), ( 1, 1, 1 ), 2 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6b736485, Offset: 0x1dd07
    // Size: 0x39, Type: dev
    function watchgunsmithdebugui()
    {
        if ( game_utility_mp::lpcfeaturegated() )
        {
            return;
        }
        
        while ( true )
        {
            level waittill( #"connected", player );
            player thread watchplayergunsmithdebugui();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x292493fb, Offset: 0x1dd48
    // Size: 0x63, Type: dev
    function watchplayergunsmithdebugui()
    {
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( #"luinotifyserver", message, lootid );
            
            if ( message == "<dev string:x2c6a>" )
            {
                ref = loot::function_f54ecb89dfab8e8c( lootid );
                gui_giveattachment_internal( self, ref );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd29aa8e, Offset: 0x1ddb3
    // Size: 0x148, Type: dev
    function function_f176d0539e1ad152()
    {
        equippedgasmask = 0;
        
        while ( true )
        {
            maskon = getdvarint( @"hash_13631697f8fa7f58", 0 );
            
            if ( maskon )
            {
                if ( !equippedgasmask )
                {
                    foreach ( player in level.players )
                    {
                        if ( !isbrgamemode() )
                        {
                            player gasmask::equipgasmask();
                        }
                    }
                    
                    equippedgasmask = 1;
                }
            }
            else if ( equippedgasmask )
            {
                foreach ( player in level.players )
                {
                    if ( !isbrgamemode() )
                    {
                        player gasmask::removegasmask();
                    }
                }
                
                equippedgasmask = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfca0b53a, Offset: 0x1df03
    // Size: 0x5a, Type: dev
    function function_cd49faac6f2af4bc()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_7a5e31b62cb508b0" ) != 0 )
            {
                level.maxallowedteamkills = -1;
                level.friendlyfire = 1;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_7a5e31b62cb508b0", 0 );
        thread function_cd49faac6f2af4bc();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa3f1c7de, Offset: 0x1df65
    // Size: 0x145, Type: dev
    function function_fdf51f95188af377()
    {
        println( "<dev string:x2c7e>" );
        
        foreach ( root, struct in level.weaponmapdata )
        {
            weaponobj = weapon::buildweapon( root );
            attachments = weapon::getallselectableattachments( weaponobj );
            
            foreach ( attachment in attachments )
            {
                newweaponobj = weapons::addattachmenttoweapon( weaponobj, attachment );
                
                if ( !isdefined( newweaponobj ) )
                {
                    println( "<dev string:x2caa>" + root + "<dev string:x356>" + attachment );
                }
            }
            
            waitframe();
        }
        
        println( "<dev string:x2cb3>" );
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xe6709fd4, Offset: 0x1e0b2
    // Size: 0x46, Type: dev
    function function_8192e7be1de83b42( entry, groupa, groupb )
    {
        return entry == "<dev string:x2f4>" || entry == "<dev string:x2ce0>" || entry == groupa || entry == groupb;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x9ebd9d9a, Offset: 0x1e100
    // Size: 0x61, Type: dev
    function function_cfac6b585f0fda1( tablename )
    {
        baseattachments = [];
        idxcol = 1;
        
        for ( attachtitle = tablelookupbyrow( tablename, 0, idxcol ); attachtitle != "<dev string:x2f4>" ; attachtitle = tablelookupbyrow( tablename, 0, idxcol ) )
        {
            baseattachments[ attachtitle ] = 1;
            idxcol++;
        }
        
        return baseattachments;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2263c975, Offset: 0x1e169
    // Size: 0x67, Type: dev
    function function_749b380fa4c83a79()
    {
        if ( !isdefined( level.var_ceefa46f8106bbca ) )
        {
            level.var_ceefa46f8106bbca = spawnstruct();
        }
        
        while ( true )
        {
            level waittill( #"connected", player );
            
            if ( !isdefined( player.devguiadded ) )
            {
                player thread function_a0080f3122e1810( player );
                player.devguiadded = 1;
            }
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xd1ff0505, Offset: 0x1e1d8
    // Size: 0x55, Type: dev
    function function_a0080f3122e1810( player )
    {
        playername = player.name;
        playernum = player getentitynumber();
        
        if ( isdefined( playernum ) && !level.var_c156642535692bac )
        {
            player thread setupdevguientries( playername, playernum );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x762506a5, Offset: 0x1e235
    // Size: 0x55, Type: dev
    function function_15072f897643b2ac()
    {
        if ( isdefined( level.var_ceefa46f8106bbca ) )
        {
            level.var_ceefa46f8106bbca.ent = undefined;
            level.var_ceefa46f8106bbca.name = undefined;
            level.var_ceefa46f8106bbca.entnum = undefined;
            iprintln( "<dev string:x2ce3>" );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x2bf11846, Offset: 0x1e292
    // Size: 0x3f, Type: dev
    function function_727a21e438b03952( slotnumber )
    {
        if ( isdefined( level.var_ceefa46f8106bbca ) )
        {
            level.var_ceefa46f8106bbca.killstreakslot = slotnumber;
            iprintln( "<dev string:x2cfa>" + slotnumber );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xeccf4105, Offset: 0x1e2d9
    // Size: 0x5b, Type: dev
    function function_30b9e4041b6b6d11( slotnumber )
    {
        if ( slotnumber != 0 && isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            level.var_ceefa46f8106bbca.ent function_1588a3ec2c5371b9( level.var_ceefa46f8106bbca.killstreakslot );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8a878201, Offset: 0x1e33c
    // Size: 0xb2, Type: dev
    function devclearkillstreaks()
    {
        if ( isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            level.var_ceefa46f8106bbca.ent killstreaks::clearkillstreaks();
            return;
        }
        
        foreach ( player in level.players )
        {
            player killstreaks::clearkillstreaks();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xb2d0f19, Offset: 0x1e3f6
    // Size: 0x37, Type: dev
    function function_1588a3ec2c5371b9( slotnumber )
    {
        for ( i = 0; i <= slotnumber ; i++ )
        {
            killstreaks::makekillstreakavailable( i, "<dev string:x459>" );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x15081a35, Offset: 0x1e435
    // Size: 0x66, Type: dev
    function setupdevguientries( name, num )
    {
        cmd = "<dev string:x2d0c>" + name + "<dev string:x2d34>" + num + "<dev string:x2d50>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x2d54>" + name + "<dev string:x2d34>" + num + "<dev string:x2d50>";
        addentrytodevgui( cmd );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x15441c12, Offset: 0x1e4a3
    // Size: 0x88, Type: dev
    function setactiveplayer( num )
    {
        player = getentbynum( num );
        
        if ( isdefined( player ) )
        {
            level.var_ceefa46f8106bbca.ent = player;
            level.var_ceefa46f8106bbca.name = player.name;
            level.var_ceefa46f8106bbca.entnum = num;
            iprintln( "<dev string:x2d80>" + player.name );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2148f73e, Offset: 0x1e533
    // Size: 0x3e, Type: dev
    function function_aa73f07b79ef74b2()
    {
        host = devfindhost();
        target = host teams::getplayerlookattarget();
        
        if ( !isdefined( target ) )
        {
            return;
        }
        
        setactiveplayer( target getentitynumber() );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x737ea8ba, Offset: 0x1e579
    // Size: 0xab, Type: dev
    function function_68d89078ec1e0abe()
    {
        if ( isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            host = devfindhost();
            targetangles = level.var_ceefa46f8106bbca.ent getplayerangles();
            forward = anglestoforward( targetangles );
            warporigin = level.var_ceefa46f8106bbca.ent.origin + forward * 100;
            host setorigin( warporigin );
            host setplayerangles( targetangles + ( 0, 180, 0 ) );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x675b4342, Offset: 0x1e62c
    // Size: 0x19, Type: dev
    function addentrytodevgui( command )
    {
        level thread addentrytodevgui_internal( command );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x4c1e79b4, Offset: 0x1e64d
    // Size: 0x1c3, Type: dev
    function addentrytodevgui_internal( command )
    {
        level endon( #"game_ended" );
        
        if ( utility::flag_exist( "<dev string:x2d90>" ) )
        {
            utility::flag_wait( "<dev string:x2d90>" );
        }
        
        if ( utility::flag_exist( "<dev string:x2da1>" ) )
        {
            utility::flag_wait( "<dev string:x2da1>" );
        }
        
        final_command = "<dev string:x2f4>";
        toks = strtok( command, "<dev string:x124b>" );
        space = "<dev string:x356>";
        num_toks = 0;
        
        foreach ( tok in toks )
        {
            new_toks = strtok( tok, "<dev string:x356>" );
            count = 1;
            size = new_toks.size;
            
            foreach ( new_tok in new_toks )
            {
                if ( count < size )
                {
                    final_command = final_command + new_tok + space;
                }
                else
                {
                    final_command += new_tok;
                }
                
                count++;
            }
            
            num_toks++;
            
            if ( num_toks < toks.size )
            {
                final_command += "<dev string:x124b>";
            }
        }
        
        adddebugcommand( final_command );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6d252327, Offset: 0x1e818
    // Size: 0xf8, Type: dev
    function function_bad0385e41a7f1()
    {
        if ( !isdefined( level.var_16d4e8ddb4dfafe9 ) )
        {
            level.var_16d4e8ddb4dfafe9 = 0;
        }
        
        if ( level.var_16d4e8ddb4dfafe9 == 0 )
        {
            if ( getdvarint( @"hash_14dd8475d8aea762", 0 ) == 1 )
            {
                level.var_16d4e8ddb4dfafe9 = 1;
                
                foreach ( player in level.players )
                {
                    if ( player player::isreallyalive() )
                    {
                        player thread setplayeronfire();
                    }
                }
            }
            
            return;
        }
        
        if ( getdvarint( @"hash_14dd8475d8aea762", 0 ) == 0 )
        {
            level.var_16d4e8ddb4dfafe9 = 0;
            level notify( #"hash_81a48599b425aa60" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5b6fc6af, Offset: 0x1e918
    // Size: 0x38, Type: dev
    function setplayeronfire()
    {
        self endon( #"death" );
        self endon( #"disconnect" );
        damage_effects::enableburnfx();
        level waittill( #"hash_81a48599b425aa60" );
        damage_effects::disableburnfx();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x51a0259f, Offset: 0x1e958
    // Size: 0x138, Type: dev
    function outofboundsimmune()
    {
        isimmune = 0;
        
        while ( true )
        {
            current = getdvarint( @"scr_ignore_oob", 0 );
            
            if ( current )
            {
                if ( !isimmune )
                {
                    foreach ( player in level.players )
                    {
                        outofbounds::enableoobimmunity( player );
                    }
                    
                    isimmune = 1;
                }
            }
            else if ( isimmune )
            {
                foreach ( player in level.players )
                {
                    outofbounds::disableoobimmunity( player );
                }
                
                isimmune = 0;
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xdd829abf, Offset: 0x1ea98
    // Size: 0x14b, Type: dev
    function private function_b3a6a728a58bb7d1()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        var_127d6f6b052347fc = undefined;
        
        while ( true )
        {
            waitframe();
            debugactive = getdvarint( @"player_debugsprint" ) > 0;
            
            if ( var_127d6f6b052347fc != debugactive )
            {
                var_127d6f6b052347fc = debugactive;
                
                if ( debugactive )
                {
                    foreach ( player in level.players )
                    {
                        player thread function_309653edb862bf8a();
                        player thread function_96cd3394da13a97f();
                    }
                    
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    player function_df21090428209e92();
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x3d7b22bb, Offset: 0x1ebeb
    // Size: 0xb6, Type: dev
    function private function_309653edb862bf8a()
    {
        self endon( #"hash_da949d5b4d6b1add" );
        
        if ( !isdefined( self.debugsprintmeter ) )
        {
            self.debugsprintmeter = hud_util::createbar( ( 0, 1, 0 ), 100, 10 );
        }
        
        thread function_959a2d806536f837();
        
        while ( true )
        {
            if ( isdefined( self.debugsprintmeter ) )
            {
                sprintfrac = self getsprintmeterfraction();
                sprintmax = self function_1c6d288085be8e40();
                sprintvalue = sprintfrac * sprintmax;
                barfrac = min( sprintvalue / sprintmax, 1 );
                self.debugsprintmeter hud_util::updatebar( barfrac );
            }
            
            wait 0.05;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x593815ca, Offset: 0x1eca9
    // Size: 0x57, Type: dev
    function function_959a2d806536f837()
    {
        hud = self.debugsprintmeter;
        utility::waittill_any( "<dev string:x2db2>", "<dev string:x2dc9>" );
        
        if ( isdefined( hud ) )
        {
            if ( isdefined( hud.bar ) )
            {
                hud.bar destroy();
            }
            
            hud destroy();
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xa687c7b3, Offset: 0x1ed08
    // Size: 0x11, Type: dev
    function private function_df21090428209e92()
    {
        self notify( #"hash_da949d5b4d6b1add" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xfa39d5cb, Offset: 0x1ed21
    // Size: 0x276, Type: dev
    function private function_96cd3394da13a97f()
    {
        self endon( #"hash_da949d5b4d6b1add" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            if ( player issupersprinting() )
            {
                duration = getdvarint( @"player_debugsprintmode" );
                
                if ( duration == 0 )
                {
                    startpoint = player.origin;
                    starttime = gettime();
                    
                    while ( player issupersprinting() )
                    {
                        waitframe();
                    }
                    
                    endpoint = player.origin;
                    endtime = gettime();
                    dist = math::round_float( distance( startpoint, endpoint ), 2, 0 );
                    meters = math::round_float( dist * 0.0254, 2, 0 );
                    time = endtime - starttime;
                    seconds = math::round_float( time * 0.001, 2, 0 );
                    
                    /#
                        iprintlnbold( "<dev string:x2dd4>" + meters + "<dev string:x2de2>" + dist + "<dev string:x2de6>" + seconds + "<dev string:x2dee>" );
                    #/
                }
                else
                {
                    startpoint = player.origin;
                    starttime = gettime() * 0.001;
                    
                    while ( player issupersprinting() || player issprinting() )
                    {
                        currenttime = gettime() * 0.001;
                        
                        if ( currenttime - starttime < duration )
                        {
                            waitframe();
                            continue;
                        }
                        
                        break;
                    }
                    
                    endpoint = player.origin;
                    endtime = gettime() * 0.001;
                    runtime = endtime - starttime;
                    
                    if ( runtime < duration )
                    {
                        dist = math::round_float( distance( startpoint, endpoint ), 2, 0 );
                        meters = math::round_float( dist * 0.0254, 2, 0 );
                        seconds = math::round_float( runtime, 2, 0 );
                        
                        /#
                            iprintlnbold( "<dev string:x2df7>" + meters + "<dev string:x2de2>" + dist + "<dev string:x2de6>" + seconds + "<dev string:x2dee>" );
                        #/
                    }
                    else
                    {
                        dist = math::round_float( distance( startpoint, endpoint ), 2, 0 );
                        meters = math::round_float( dist * 0.0254, 2, 0 );
                        
                        /#
                            iprintlnbold( "<dev string:x2df7>" + meters + "<dev string:x2de2>" + dist + "<dev string:x2de6>" + duration + "<dev string:x2dee>" );
                        #/
                    }
                    
                    if ( player issupersprinting() )
                    {
                        while ( player issupersprinting() )
                        {
                            waitframe();
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x8ccdd6f7, Offset: 0x1ef9f
    // Size: 0x142, Type: dev
    function private function_355ba026ee9a6b1()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        var_127d6f6b052347fc = undefined;
        
        while ( true )
        {
            waitframe();
            debugactive = getdvarint( @"hash_63681362d5a030e0" ) > 0;
            
            if ( var_127d6f6b052347fc != debugactive )
            {
                var_127d6f6b052347fc = debugactive;
                
                if ( debugactive )
                {
                    foreach ( player in level.players )
                    {
                        player thread slidedebugprint();
                    }
                    
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    player function_57da6c119dfa8a08();
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x10b6eeff, Offset: 0x1f0e9
    // Size: 0x11, Type: dev
    function private function_57da6c119dfa8a08()
    {
        self notify( #"hash_5de8945a79a4f1d6" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x824f03a6, Offset: 0x1f102
    // Size: 0x11b, Type: dev
    function private slidedebugprint()
    {
        self endon( #"hash_5de8945a79a4f1d6" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            if ( player issprintsliding() )
            {
                startpoint = player.origin;
                starttime = gettime();
                maxspeed = 0;
                
                while ( player issprintsliding() )
                {
                    slidespeed = length( player getvelocity() );
                    
                    if ( slidespeed > maxspeed )
                    {
                        maxspeed = slidespeed;
                    }
                    
                    waitframe();
                }
                
                endpoint = player.origin;
                endtime = gettime();
                dist = math::round_float( distance( startpoint, endpoint ), 0, 0 );
                time = endtime - starttime;
                seconds = math::round_float( time * 0.001, 2, 0 );
                
                /#
                    iprintlnbold( "<dev string:x2e01>" + dist + "<dev string:x2e07>" + seconds + "<dev string:x2e13>" + maxspeed );
                #/
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xb99f9850, Offset: 0x1f225
    // Size: 0x142, Type: dev
    function private function_608044dfa837df76()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        var_127d6f6b052347fc = undefined;
        
        while ( true )
        {
            waitframe();
            debugactive = getdvarint( @"hash_b59ba008ca72833d" ) > 0;
            
            if ( var_127d6f6b052347fc != debugactive )
            {
                var_127d6f6b052347fc = debugactive;
                
                if ( debugactive )
                {
                    foreach ( player in level.players )
                    {
                        player thread divedebugprint();
                    }
                    
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    player function_1344d10a39a70d27();
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x30671e07, Offset: 0x1f36f
    // Size: 0x11, Type: dev
    function private function_1344d10a39a70d27()
    {
        self notify( #"hash_98576483f2db4627" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x98677e4b, Offset: 0x1f388
    // Size: 0x11b, Type: dev
    function private divedebugprint()
    {
        self endon( #"hash_98576483f2db4627" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            if ( player isdiving() )
            {
                startpoint = player.origin;
                starttime = gettime();
                maxspeed = 0;
                
                while ( player isdiving() )
                {
                    divespeed = length( player getvelocity() );
                    
                    if ( divespeed > maxspeed )
                    {
                        maxspeed = divespeed;
                    }
                    
                    waitframe();
                }
                
                endpoint = player.origin;
                endtime = gettime();
                dist = math::round_float( distance( startpoint, endpoint ), 0, 0 );
                time = endtime - starttime;
                seconds = math::round_float( time * 0.001, 2, 0 );
                
                /#
                    iprintlnbold( "<dev string:x2e2a>" + dist + "<dev string:x2e07>" + seconds + "<dev string:x2e13>" + maxspeed );
                #/
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x2a1bfc5e, Offset: 0x1f4ab
    // Size: 0x2e, Type: dev
    function function_79f8301425abd200( player )
    {
        var_42937b0a0e965a32 = istestclient( player ) || player isplayerheadless();
        return var_42937b0a0e965a32;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6613c723, Offset: 0x1f4e1
    // Size: 0x9a, Type: dev
    function function_4838699531f3a587()
    {
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && !istestclient( player ) && !function_79f8301425abd200( player ) )
            {
                return player;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2fc6eee5, Offset: 0x1f583
    // Size: 0xf1, Type: dev
    function function_829a2178344b7ae4()
    {
        friendlies = [];
        realclient = function_4838699531f3a587();
        
        if ( !isdefined( realclient ) )
        {
            return friendlies;
        }
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate == "<dev string:x283>" )
            {
                continue;
            }
            
            if ( !function_79f8301425abd200( player ) )
            {
                continue;
            }
            
            if ( player.team == realclient.team )
            {
                friendlies[ friendlies.size ] = player;
            }
        }
        
        return friendlies;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc3f4d402, Offset: 0x1f67c
    // Size: 0xf1, Type: dev
    function function_75e5de28232ad43d()
    {
        enemies = [];
        realclient = function_4838699531f3a587();
        
        if ( !isdefined( realclient ) )
        {
            return enemies;
        }
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate == "<dev string:x283>" )
            {
                continue;
            }
            
            if ( !function_79f8301425abd200( player ) )
            {
                continue;
            }
            
            if ( player.team != realclient.team )
            {
                enemies[ enemies.size ] = player;
            }
        }
        
        return enemies;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6be31b36, Offset: 0x1f775
    // Size: 0xbd, Type: dev
    function headless_get_all()
    {
        headless = [];
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.sessionstate == "<dev string:x283>" )
            {
                continue;
            }
            
            if ( !function_79f8301425abd200( player ) )
            {
                continue;
            }
            
            headless[ headless.size ] = player;
        }
        
        return headless;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7355d306, Offset: 0x1f83a
    // Size: 0x11c, Type: dev
    function headless_killall()
    {
        if ( getdvarint( @"hash_892a0f1030eb66da", 0 ) != 0 )
        {
            players = function_829a2178344b7ae4();
            
            foreach ( player in players )
            {
                player kill();
            }
            
            return;
        }
        
        if ( getdvarint( @"hash_99f113c180dfe22d", 0 ) != 0 )
        {
            players = function_75e5de28232ad43d();
            
            foreach ( player in players )
            {
                player kill();
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x28b5f880, Offset: 0x1f95e
    // Size: 0x6d, Type: dev
    function function_205cd8869510d883()
    {
        realclient = function_4838699531f3a587();
        
        if ( !isdefined( realclient ) )
        {
            return;
        }
        
        warpplayers = [];
        
        if ( getdvarint( @"hash_60951c4ee00ec45c", 0 ) != 0 )
        {
            warpplayers = function_829a2178344b7ae4();
        }
        else if ( getdvarint( @"hash_8e93a66436d8d0bb", 0 ) != 0 )
        {
            warpplayers = function_75e5de28232ad43d();
        }
        
        warpents( realclient, warpplayers );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xc9b82fd, Offset: 0x1f9d3
    // Size: 0xb3, Type: dev
    function function_2b606bc0f7063838( benable )
    {
        players = headless_get_all();
        
        foreach ( player in players )
        {
            if ( !benable )
            {
                player val::set( "<dev string:x2e30>", "<dev string:x2e3d>", 0 );
                continue;
            }
            
            player val::reset_all( "<dev string:x2e30>" );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xcbebe2b6, Offset: 0x1fa8e
    // Size: 0xb3, Type: dev
    function function_2fa2bd0de3d64101( benable )
    {
        players = headless_get_all();
        
        foreach ( player in players )
        {
            if ( !benable )
            {
                player val::set( "<dev string:x2e4c>", "<dev string:x2e5b>", 0 );
                continue;
            }
            
            player val::reset_all( "<dev string:x2e4c>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x18fb978b, Offset: 0x1fb49
    // Size: 0x104, Type: dev
    function function_f85a1f11e709f72()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        waitframe();
        
        for ( ;; )
        {
            if ( getdvar( @"scr_operator_skin", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_b0822849b127b3c7();
            }
            
            if ( getdvarint( @"scr_print_player_index" ) != 0 )
            {
                thread function_d2c71ed27c34de1c();
            }
            
            if ( getdvar( @"scr_setclothtype", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_setclothtype();
            }
            
            if ( getdvar( @"scr_setgeartype", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_setgeartype();
            }
            
            if ( getdvar( @"scr_setbagtype", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread gui_setbagtype();
            }
            
            if ( getdvar( @"scr_operator_reactive", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_87dce2a4711a2aa1();
            }
            
            if ( getdvar( @"scr_operator_contrail", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                thread function_c3f641fc7f34a06a();
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x39cdd13c, Offset: 0x1fc55
    // Size: 0xaa, Type: dev
    function recordposition()
    {
        setdevdvar( @"scr_recordposition", 0 );
        
        if ( !isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            setactiveplayer( 0 );
        }
        
        if ( isdefined( level.var_ceefa46f8106bbca.ent ) )
        {
            p = level.var_ceefa46f8106bbca.ent;
            file = openfile( "<dev string:x2e60>", "<dev string:x2e77>" );
            originstring = string( p.origin );
            fprintln( file, originstring );
            closefile( file );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5b7ae179, Offset: 0x1fd07
    // Size: 0xdd, Type: dev
    function function_55abfa85c5e27063()
    {
        vehhorn = getdvarint( @"hash_d7ac865ae726cebc", 0 );
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                if ( isdefined( player.vehiclecustomization ) )
                {
                    player.vehiclecustomization vehicle::function_b7228e49642d3ae8( undefined, vehhorn );
                    println( "<dev string:x2e7e>" + vehhorn );
                }
                
                break;
            }
        }
        
        setdevdvar( @"hash_d7ac865ae726cebc", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8e8e07c6, Offset: 0x1fdec
    // Size: 0xef, Type: dev
    function function_764b9db0597fadcb()
    {
        vehcamo = getdvar( @"hash_d51834b4d1b89a35", "<dev string:x2f4>" );
        
        if ( !issubstr( vehcamo, "<dev string:x2e91>" ) )
        {
            vehcamo = int( vehcamo ) - 1;
        }
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                continue;
            }
            
            player.vehiclecustomization = vehicle::function_b7228e49642d3ae8( vehcamo, undefined );
        }
        
        println( "<dev string:x2e93>" + vehcamo );
        setdevdvar( @"hash_d51834b4d1b89a35", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdf06d856, Offset: 0x1fee3
    // Size: 0xef, Type: dev
    function function_1c4a882baea8ba26()
    {
        vehcamo = getdvar( @"hash_656c12d185e55da8", "<dev string:x2f4>" );
        
        if ( vehcamo == "<dev string:x2f4>" )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            vehicle = player.vehicle;
            
            if ( isbot( player ) )
            {
                continue;
            }
            
            if ( isdefined( vehicle ) )
            {
                vehicle function_e7bba780254da962( vehcamo );
            }
        }
        
        println( "<dev string:x2ea6>" + vehcamo );
        setdevdvar( @"hash_656c12d185e55da8", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x423463c9, Offset: 0x1ffda
    // Size: 0xce, Type: dev
    function function_c400c37e23f3c8f4()
    {
        if ( !isdefined( level.br_armory_kiosk ) )
        {
            return;
        }
        
        path = "<dev string:x2eb9>";
        rows = tablelookupgetnumrows( path );
        spawnlocs = [];
        
        for ( i = 0; i < rows ; i++ )
        {
            veh = tablelookupbyrow( path, i, 0 );
            pos = ( float( tablelookupbyrow( path, i, 1 ) ), float( tablelookupbyrow( path, i, 2 ) ), float( tablelookupbyrow( path, i, 3 ) ) );
            angle = ( float( tablelookupbyrow( path, i, 4 ) ), float( tablelookupbyrow( path, i, 5 ) ), float( tablelookupbyrow( path, i, 6 ) ) );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x536fe91, Offset: 0x200b0
    // Size: 0x22, Type: dev
    function devrecordposition()
    {
        for ( ;; )
        {
            if ( getdvarint( @"scr_recordposition" ) != 0 )
            {
                thread recordposition();
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xfc8d0058, Offset: 0x200da
    // Size: 0xc, Type: dev
    function devcodcaster()
    {
        thread function_14e3921828d14eda();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6fe43c, Offset: 0x200ee
    // Size: 0x6f, Type: dev
    function function_14e3921828d14eda()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_53575b577130f7f9" ) != 0 )
            {
                setdvar( @"bg_esports_should_timeout", 1 );
                setdevdvar( @"hash_53575b577130f7f9", 0 );
            }
            
            if ( getdvarint( @"hash_e7372af7cfe8d1da" ) != 0 )
            {
                setdvar( @"bg_esports_should_timeout", 0 );
                setdevdvar( @"hash_e7372af7cfe8d1da", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdd01ba58, Offset: 0x20165
    // Size: 0x21, Type: dev
    function function_33cc0f178371735b()
    {
        level thread function_3ea720be96a67b0c( @"hash_ed5df81b887a95e2", 0, "<dev string:x2ee3>", "<dev string:x2ef5>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb19a1624, Offset: 0x2018e
    // Size: 0xcf, Type: dev
    function function_ac61a8e142381b89()
    {
        i = 0;
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_f75720f29df3df7" ) != 0 && i == 0 )
            {
                host = devfindhost();
                
                if ( isdefined( host ) )
                {
                    host setsoundsubmix( "<dev string:x2f08>", 1, 1 );
                    setglobalsoundcontext( "<dev string:x2f23>", "<dev string:x2f2e>" );
                    host setclienttriggeraudiozone( "<dev string:x2f2e>", 1 );
                }
                
                i = 1;
            }
            else if ( getdvarint( @"hash_f75720f29df3df7" ) == 0 && i == 1 )
            {
                host = devfindhost();
                
                if ( isdefined( host ) )
                {
                    host clearsoundsubmix( "<dev string:x2f08>", 2.2 );
                    setglobalsoundcontext( "<dev string:x2f23>", "<dev string:x2f4>" );
                    host clearclienttriggeraudiozone( 1 );
                }
                
                i = 0;
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x1b6eddc8, Offset: 0x20265
    // Size: 0x23, Type: dev
    function function_96c13d351419eadc( targetent )
    {
        setdvar( @"hash_305a7db16a11dd02", targetent getentitynumber() );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x634402fa, Offset: 0x20290
    // Size: 0x5d, Type: dev
    function function_16e1795998add75b()
    {
        level waittill( #"player_spawned", player );
        
        if ( getdvarint( @"scr_god", 0 ) == 1 )
        {
            adddebugcommand( "<dev string:x2f39>" );
            return;
        }
        
        if ( getdvarint( @"scr_demigod", 0 ) == 1 )
        {
            adddebugcommand( "<dev string:x2f3e>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xcd4fe973, Offset: 0x202f5
    // Size: 0xee, Type: dev
    function flipvehicle()
    {
        setdvar( @"scr_flip_vehicle", 0 );
        
        while ( true )
        {
            while ( getdvarint( @"scr_flip_vehicle", 0 ) == 0 )
            {
                wait 1;
            }
            
            setdvar( @"scr_flip_vehicle", 0 );
            
            if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].vehicle ) )
            {
                vehicle = level.players[ 0 ].vehicle;
                vehicle vehicle_teleport( ( vehicle.origin[ 0 ], vehicle.origin[ 1 ], vehicle.origin[ 2 ] + 100 ), ( vehicle.angles[ 0 ] + 180, vehicle.angles[ 1 ], vehicle.angles[ 2 ] ) );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x80f2853c, Offset: 0x203eb
    // Size: 0x445, Type: dev
    function explodevehicle()
    {
        dvars = [ @"scr_destroy_vehicle", @"scr_destroy_vehicle_parts", @"scr_sink_vehicle", @"hash_130359b22d6e3ba5", @"hash_b919610b324346ca", @"scr_activate_vehicle_parts", @"scr_vehicle_lock", @"hash_9080b40572c68279" ];
        
        while ( true )
        {
            shouldbreak = 0;
            
            while ( true )
            {
                foreach ( dvar in dvars )
                {
                    if ( getdvarint( dvar, 0 ) != 0 )
                    {
                        shouldbreak = 1;
                        break;
                    }
                }
                
                if ( shouldbreak )
                {
                    break;
                }
                
                wait 1;
            }
            
            if ( isdefined( level.players[ 0 ] ) )
            {
                vehicle = level.players[ 0 ].vehicle;
                
                if ( !vehicle )
                {
                    leveldata = vehicle_compass::get_level_data();
                    vehicle = sortbydistance( leveldata.instances, level.players[ 0 ].origin )[ 0 ];
                }
                
                if ( getdvarint( @"scr_destroy_vehicle", 0 ) != 0 )
                {
                    vehicle vehicle::explode();
                }
                else if ( getdvarint( @"scr_sink_vehicle", 0 ) != 0 )
                {
                    if ( vehicle vehicle_isphysveh() && !vehicle vehicle::is_boat() )
                    {
                        vehicle function_8646b6bbcbec5172( 0 );
                    }
                    
                    vehicle setdeffile( "<dev string:x2f47>" );
                }
                else if ( getdvarint( @"scr_destroy_vehicle_parts", 0 ) != 0 )
                {
                    vehicle_damage::function_c0997f62f7c7cbd8( vehicle );
                }
                else if ( getdvarint( @"scr_activate_vehicle_parts", 0 ) != 0 )
                {
                    vehicle_damage::activate_all_parts( vehicle );
                }
                else if ( getdvarint( @"hash_b919610b324346ca", 0 ) != 0 )
                {
                    vehicle.fuel = getdvarint( @"hash_b919610b324346ca", 0 );
                }
                else if ( getdvarint( @"scr_vehicle_lock", 0 ) != 0 )
                {
                    enemy = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( player player_utility::isenemy( level.players[ 0 ] ) )
                        {
                            enemy = player;
                            break;
                        }
                    }
                    
                    if ( isdefined( enemy ) )
                    {
                        enemy utility::callsharedfunc( #"vehicle", #"player_lock", vehicle );
                    }
                }
                else if ( getdvarint( @"hash_9080b40572c68279", 0 ) != 0 )
                {
                    enemy = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( player player_utility::isenemy( level.players[ 0 ] ) )
                        {
                            enemy = player;
                            break;
                        }
                    }
                    
                    if ( isdefined( enemy ) )
                    {
                        vehicle utility::callsharedfunc( #"vehicle", #"repair_engine", enemy );
                    }
                }
            }
            
            foreach ( dvar in dvars )
            {
                setdvar( dvar, 0 );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2fb1896, Offset: 0x20838
    // Size: 0x23d, Type: dev
    function function_dfd115328bb558ae()
    {
        setdvar( @"hash_9b965b6b823e2661", 0 );
        
        for ( ;; )
        {
            while ( getdvarint( @"hash_9b965b6b823e2661", 0 ) == 0 )
            {
                wait 1;
            }
            
            setdvar( @"hash_9b965b6b823e2661", 0 );
            setdvar( @"bg_vehautoshowhidetirebones", 0 );
            instances = vehicle_tracking::function_5820a38c9873992e();
            
            if ( instances.size > 0 )
            {
                foreach ( instance in instances )
                {
                    model = instance vehicle_code::get_vehicle_model();
                    
                    if ( issubstr( model, "<dev string:x2f6a>" ) )
                    {
                        continue;
                    }
                    
                    instance hidepart( "<dev string:x2f71>" );
                    instance hidepart( "<dev string:x2f8d>" );
                    instance hidepart( "<dev string:x2faa>" );
                    instance hidepart( "<dev string:x2fc5>" );
                    instance hidepart( "<dev string:x2fe1>" );
                    instance hidepart( "<dev string:x3002>" );
                    instance hidepart( "<dev string:x3024>" );
                    instance hidepart( "<dev string:x3044>" );
                    
                    if ( issubstr( model, "<dev string:x3065>" ) )
                    {
                        instance hidepart( "<dev string:x3071>" );
                        instance hidepart( "<dev string:x308e>" );
                        instance hidepart( "<dev string:x30ac>" );
                        instance hidepart( "<dev string:x30ce>" );
                    }
                    
                    if ( issubstr( model, "<dev string:x30f1>" ) )
                    {
                        instance hidepart( "<dev string:x30f5>" );
                        instance hidepart( "<dev string:x3113>" );
                        instance hidepart( "<dev string:x3132>" );
                        instance hidepart( "<dev string:x3150>" );
                        instance hidepart( "<dev string:x316f>" );
                        instance hidepart( "<dev string:x3192>" );
                        instance hidepart( "<dev string:x31b6>" );
                        instance hidepart( "<dev string:x31d9>" );
                    }
                    
                    if ( issubstr( model, "<dev string:x31fd>" ) )
                    {
                        instance hidepart( "<dev string:x320c>" );
                        instance hidepart( "<dev string:x3222>" );
                        instance hidepart( "<dev string:x3239>" );
                        instance hidepart( "<dev string:x324e>" );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x47119ecd, Offset: 0x20a7d
    // Size: 0x6e, Type: dev
    function function_44e9d6f174c177a6()
    {
        dvar = @"hash_46503e3553487660";
        setdvar( dvar, 0 );
        
        while ( true )
        {
            if ( getdvarint( dvar, 0 ) != 0 )
            {
                if ( isdefined( level.players[ 0 ] ) )
                {
                    player = level.players[ 0 ];
                    player function_3efe38905a871fec( 100 );
                }
                
                setdvar( dvar, 0 );
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x672d12a1, Offset: 0x20af3
    // Size: 0x60, Type: dev
    function function_4f86bf5b03acc10b()
    {
        waitframe();
        thread function_90aa285626e04b13();
        thread function_14c8d8a8c1ba0995();
        
        while ( true )
        {
            if ( getdvarint( @"hash_feed6c94acdeb007", 0 ) )
            {
                level thread function_1576455b42b7fc28();
                function_c46ebe0d3c9ceb4f();
                function_350e7ab1300f4403();
                function_83a4454af8e4682d();
                function_c407d2b41f75fbf6();
                debugvehicles();
                function_473149262c5be233();
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb766f918, Offset: 0x20b5b
    // Size: 0x12f, Type: dev
    function function_1576455b42b7fc28()
    {
        if ( !getdvarint( @"hash_2853a457a04cedd" ) )
        {
            return;
        }
        
        switch ( level.players[ 0 ].team )
        {
            case #"hash_7c2d091e6337bf54":
                setdevdvar( @"hash_5e767ceb6b77e053", 1 );
                break;
            case #"hash_5f54b9bf7583687f":
                setdevdvar( @"hash_5e767ceb6b77e053", 2 );
                break;
            default:
                setdevdvar( @"hash_5e767ceb6b77e053", -1 );
                break;
        }
        
        setdevdvar( @"hash_2853a457a04cedd", 0 );
        setdevdvar( @"dev_spawnbots", 1 );
        level waittill( #"player_spawned", bot );
        host = devfindhost();
        point = getclosestpointonnavmesh( host.origin );
        setdevdvar( @"hash_12d23346fbacee91", 2 );
        bot setorigin( point );
        bot botsetstance( getdvar( @"hash_84f60afafd582b5a", "<dev string:xe5c>" ) );
        bot botsetawareness( 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x14561be6, Offset: 0x20c92
    // Size: 0x1c8, Type: dev
    function function_c46ebe0d3c9ceb4f()
    {
        bots = botsalreadyspawned();
        
        if ( !isdefined( bots ) )
        {
            return;
        }
        
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        foreach ( bot in bots )
        {
            dist = distance( host.origin, bot.origin );
            headpos = bot gettagorigin( "<dev string:x917>" );
            scale = dist / 1000;
            print3d( headpos, "<dev string:x214a>" + dist, ( 1, 1, 1 ), 1, 1 + scale );
            
            if ( !getdvarint( @"hash_eac0c331e6c7a19", 0 ) )
            {
                if ( !isdefined( bot.outlineid ) )
                {
                    outlineid = outline::outlineenableforall( bot, "<dev string:xec0>", "<dev string:x3264>" );
                    bot.outlineid = outlineid;
                }
                else
                {
                    outline::outlinerefresh( bot );
                }
            }
            
            if ( ( getdvarint( @"hash_eac0c331e6c7a19", 0 ) || !getdvarint( @"hash_feed6c94acdeb007", 0 ) ) && isdefined( bot.outlineid ) )
            {
                outline::outlinedisable( bot.outlineid, bot );
                bot.outlineid = undefined;
                setdevdvar( @"hash_eac0c331e6c7a19", 1 );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8c5a1ba, Offset: 0x20e62
    // Size: 0xa6, Type: dev
    function botsalreadyspawned()
    {
        bots = [];
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && isalive( player ) )
            {
                bots[ bots.size ] = player;
            }
        }
        
        if ( bots.size == 0 )
        {
            return;
        }
        
        return bots;
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xd7f2cca7, Offset: 0x20f10
    // Size: 0x104, Type: dev
    function function_a6eff7b211cdf9b8( dist, bots )
    {
        host = devfindhost();
        forward = anglestoforward( host getplayerangles() );
        tracestart = host geteye() + forward * dist + ( 0, 0, 50 );
        traceend = tracestart + ( 0, 0, -1000 );
        traceresults = trace::ray_trace( tracestart, traceend, host );
        
        foreach ( bot in bots )
        {
            bot setorigin( traceresults[ "<dev string:x236>" ] );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x23bd210f, Offset: 0x2101c
    // Size: 0xd3, Type: dev
    function function_83a4454af8e4682d()
    {
        if ( !getdvarint( @"scr_audio_rotate", 0 ) )
        {
            return;
        }
        
        setdevdvar( @"scr_audio_rotate", 0 );
        bots = botsalreadyspawned();
        
        if ( !isdefined( bots ) )
        {
            return;
        }
        
        foreach ( bot in bots )
        {
            newangles = bot.angles + ( 0, 90, 0 );
            bot setplayerangles( newangles );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xcba0963f, Offset: 0x210f7
    // Size: 0x12b, Type: dev
    function function_49eab99fec624563( movedist, bots )
    {
        foreach ( bot in bots )
        {
            host = devfindhost();
            forward = anglestoforward( host getplayerangles() );
            dist = distance( host.origin, bot.origin ) + movedist;
            tracestart = host geteye() + forward * dist + ( 0, 0, 1000 );
            traceend = tracestart + ( 0, 0, -1000 );
            traceresults = trace::ray_trace( tracestart, traceend, host );
            bot setorigin( traceresults[ "<dev string:x236>" ] );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe65089dc, Offset: 0x2122a
    // Size: 0x2dd, Type: dev
    function function_90aa285626e04b13()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( !getdvarint( @"hash_feed6c94acdeb007", 0 ) )
            {
                waitframe();
                continue;
            }
            
            if ( !getdvarint( @"hash_68c6be05e346d7f", 0 ) )
            {
                waitframe();
                continue;
            }
            
            bots = botsalreadyspawned();
            
            if ( !isdefined( bots ) )
            {
                setdevdvar( @"hash_68c6be05e346d7f", 0 );
                waitframe();
                continue;
            }
            
            setdevdvar( @"hash_12d23346fbacee91", 0 );
            
            if ( getdvarint( @"hash_68c6be05e346d7f", 0 ) == 1 )
            {
                foreach ( bot in bots )
                {
                    botstartpoint = getclosestpointonnavmesh( bot.origin );
                    bot setorigin( botstartpoint );
                    host = devfindhost();
                    forward = vectornormalize( bot.origin - host.origin );
                    closestpoint = getclosestpointonnavmesh( bot.origin + forward * 1000 );
                    bot botclearscriptgoal();
                    waitframe();
                    bot botsetscriptgoal( closestpoint, 1, "<dev string:x326e>" );
                }
            }
            
            if ( getdvarint( @"hash_68c6be05e346d7f", 0 ) == 2 )
            {
                foreach ( bot in bots )
                {
                    botstartpoint = getclosestpointonnavmesh( bot.origin );
                    bot setorigin( botstartpoint );
                    host = devfindhost();
                    closestpoint = getclosestpointonnavmesh( host.origin );
                    bot botclearscriptgoal();
                    waitframe();
                    bot botsetscriptgoal( closestpoint, 20, "<dev string:x326e>" );
                }
            }
            
            if ( getdvarint( @"hash_68c6be05e346d7f", 0 ) == 3 )
            {
                foreach ( bot in bots )
                {
                    setdevdvar( @"hash_12d23346fbacee91", 2 );
                    bot botclearscriptgoal();
                }
            }
            
            setdevdvar( @"hash_68c6be05e346d7f", 0 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5f307c88, Offset: 0x2150f
    // Size: 0x116, Type: dev
    function function_14c8d8a8c1ba0995()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( !getdvarint( @"hash_feed6c94acdeb007", 0 ) )
            {
                waitframe();
                continue;
            }
            
            bots = botsalreadyspawned();
            
            if ( !isdefined( bots ) )
            {
                waitframe();
                continue;
            }
            
            foreach ( bot in bots )
            {
                if ( !isdefined( bot.stance ) )
                {
                    bot.stance = "<dev string:x2ef>";
                }
                
                stancedvar = getdvar( @"hash_84f60afafd582b5a", "<dev string:xe5c>" );
                
                if ( bot.stance != stancedvar )
                {
                    bot botsetstance( stancedvar );
                    bot.stance = stancedvar;
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2e082945, Offset: 0x2162d
    // Size: 0x3e4, Type: dev
    function function_350e7ab1300f4403()
    {
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        consoledvar = getdvarint( @"hash_7593dee806228a1a", 0 );
        var_909eda8f3eb3969 = getdvarint( @"hash_3100677c4c768b60", 0 );
        
        if ( !consoledvar )
        {
            return;
        }
        
        bots = botsalreadyspawned();
        
        if ( isdefined( bots ) )
        {
            foreach ( bot in bots )
            {
                if ( var_909eda8f3eb3969 != 4 )
                {
                    volume = "<dev string:x2f4>";
                    
                    switch ( consoledvar )
                    {
                        case 1:
                            volume = "<dev string:x3277>";
                            break;
                        case 2:
                            volume = "<dev string:x327c>";
                            break;
                        case 3:
                            volume = "<dev string:x3282>";
                            break;
                        case 4:
                            volume = "<dev string:x3289>";
                            break;
                        default:
                            volume = "<dev string:x3292>";
                            break;
                    }
                    
                    type = "<dev string:x2f4>";
                    
                    switch ( var_909eda8f3eb3969 )
                    {
                        case 1:
                            type = "<dev string:x3299>";
                            break;
                        case 2:
                            type = "<dev string:x32a3>";
                            break;
                        case 3:
                            type = "<dev string:x32ab>";
                            break;
                        case 4:
                            type = "<dev string:x32b3>";
                            break;
                        default:
                            type = "<dev string:x32bb>";
                            break;
                    }
                    
                    dist = distance( host.origin, bot.origin );
                    println( "<dev string:x32c0>" );
                    println( "<dev string:x32df>" + type );
                    println( "<dev string:x32ec>" + volume );
                    println( "<dev string:x32fb>" + bot getentitynumber() );
                    println( "<dev string:x3308>" + dist );
                    println( "<dev string:x3317>" + bot.primaryweapon );
                    println( "<dev string:x3324>" );
                }
            }
        }
        
        if ( !isdefined( level.devvehicles ) )
        {
            return;
        }
        
        foreach ( vehicle in level.devvehicles )
        {
            volume = "<dev string:x2f4>";
            
            switch ( consoledvar )
            {
                case 1:
                    volume = "<dev string:x3277>";
                    break;
                case 2:
                    volume = "<dev string:x327c>";
                    break;
                case 3:
                    volume = "<dev string:x3282>";
                    break;
                case 4:
                    volume = "<dev string:x3289>";
                    break;
                default:
                    volume = "<dev string:x3292>";
                    break;
            }
            
            dist = distance( host.origin, vehicle.origin );
            println( "<dev string:x32c0>" );
            println( "<dev string:x3341>" );
            println( "<dev string:x32ec>" + volume );
            println( "<dev string:x3355>" + vehicle.vehiclename );
            println( "<dev string:x3364>" + dist );
            println( "<dev string:x3324>" );
        }
        
        setdevdvar( @"hash_7593dee806228a1a", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdbe4fdfe, Offset: 0x21a19
    // Size: 0xe3, Type: dev
    function function_c407d2b41f75fbf6()
    {
        bots = botsalreadyspawned();
        
        if ( !isdefined( bots ) )
        {
            return;
        }
        
        dvar = getdvarint( @"hash_d91cce0b4aec39b4", 0 );
        
        switch ( dvar )
        {
            case 1:
                function_a6eff7b211cdf9b8( 100, bots );
                break;
            case 2:
                function_a6eff7b211cdf9b8( 500, bots );
                break;
            case 3:
                function_a6eff7b211cdf9b8( 1100, bots );
                break;
            case 4:
                function_49eab99fec624563( -50, bots );
                break;
            case 5:
                function_49eab99fec624563( 50, bots );
                break;
            default:
                break;
        }
        
        setdevdvar( @"hash_d91cce0b4aec39b4", 0 );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x98c7b866, Offset: 0x21b04
    // Size: 0x1f8, Type: dev
    function debugvehicles()
    {
        if ( !isdefined( level.devvehicles ) )
        {
            return;
        }
        
        if ( level.devvehicles.size < 1 )
        {
            return;
        }
        
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        foreach ( index, vehicle in level.devvehicles )
        {
            if ( !isdefined( vehicle.origin ) )
            {
                level.devvehicles[ index ] = undefined;
                continue;
            }
            
            dist = distance( host.origin, vehicle.origin );
            scale = dist / 1000;
            print3d( vehicle.origin + ( 0, 0, 50 ), "<dev string:x214a>" + dist, ( 1, 1, 1 ), 1, 1 + scale );
            
            if ( !getdvarint( @"hash_eac0c331e6c7a19", 0 ) )
            {
                if ( !isdefined( vehicle.outlineid ) )
                {
                    outlineid = outline::outlineenableforall( vehicle, "<dev string:xec0>", "<dev string:x3264>" );
                    vehicle.outlineid = outlineid;
                }
                else
                {
                    outline::outlinerefresh( vehicle );
                }
            }
            
            if ( ( getdvarint( @"hash_eac0c331e6c7a19", 0 ) || !getdvarint( @"hash_feed6c94acdeb007", 0 ) ) && isdefined( vehicle.outlineid ) )
            {
                outline::outlinedisable( vehicle.outlineid, vehicle );
                vehicle.outlineid = undefined;
                setdevdvar( @"hash_eac0c331e6c7a19", 1 );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x61c0d74c, Offset: 0x21d04
    // Size: 0x6a, Type: dev
    function function_473149262c5be233()
    {
        grenaderef = getdvar( @"hash_f717bc3454c9e8d4", "<dev string:x2f4>" );
        
        if ( grenaderef == "<dev string:x2f4>" )
        {
            return;
        }
        
        setdevdvar( @"hash_f717bc3454c9e8d4", "<dev string:x2f4>" );
        bots = botsalreadyspawned();
        
        if ( !isdefined( bots ) )
        {
            return;
        }
        
        setdevdvar( @"hash_c1fa6ab185f57dc3", grenaderef );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x25abeace, Offset: 0x21d76
    // Size: 0xf6, Type: dev
    function function_f6eca5ab3e53220()
    {
        setdvar( @"hash_5b211aca76235219", 0 );
        setdvar( @"hash_45f4dd24df5f8312", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_5b211aca76235219", 0 ) == 1 )
            {
                setdvar( @"hash_5b211aca76235219", 0 );
                dmz_dog_tag::function_34d0a7ddfa21db1c( level.players[ 0 ] );
                dropstruct = pickups::function_f71dd588dc4f6288();
                br_default_inventory::function_89372de057456bf3( level.players[ 0 ], dropstruct );
                br_default_inventory::function_7ee02b5481912409( level.players[ 0 ], dropstruct );
                level.players[ 0 ] br_default_inventory::clearbackpack();
            }
            
            if ( getdvarint( @"hash_45f4dd24df5f8312", 0 ) == 1 )
            {
                setdvar( @"hash_45f4dd24df5f8312", 0 );
                
                if ( isdefined( level.var_77124f00104ce287 ) )
                {
                    level.players[ 0 ] thread [[ level.var_77124f00104ce287 ]]();
                }
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8ebf5fe2, Offset: 0x21e74
    // Size: 0x4b, Type: dev
    function function_9b29e5159417d1c8()
    {
        setdvar( @"hash_f45a5fd7bc382158", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_f45a5fd7bc382158", 0 ) == 1 )
            {
                level.players[ 0 ] backpack::attachbag( "<dev string:x3377>" );
                return;
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x69404597, Offset: 0x21ec7
    // Size: 0x59, Type: dev
    function function_a620a475d8bc56d6()
    {
        if ( !isbrgamemode() )
        {
            return;
        }
        
        while ( true )
        {
            backpacksize = getdvarint( @"scr_debug_backpack_size", 0 );
            
            if ( backpacksize )
            {
                br_default_inventory::function_7fcce769f23a1428( level.players[ 0 ], backpacksize );
                setdvar( @"scr_debug_backpack_size", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa6318db2, Offset: 0x21f28
    // Size: 0x22d, Type: dev
    function function_fea17b16867e3f9f()
    {
        if ( !isbrgamemode() )
        {
            return;
        }
        
        lootids = [ 8486, 8369, 9104, 8554, 8548, 8372, 8600, 9171, 9250 ];
        
        while ( true )
        {
            var_b40c799b65f02f4 = getdvarint( @"hash_6b3fdb8f7cb8773e", 0 );
            
            if ( var_b40c799b65f02f4 )
            {
                setdvar( @"hash_6b3fdb8f7cb8773e", 0 );
                fakepickup = spawnstruct();
                var_1b6a9ea74101a90 = dmz_weapon_case::function_7537c1a799b06954();
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        br_default_inventory::function_7fcce769f23a1428( player, 9, undefined, 8545 );
                        waitframe();
                    }
                    
                    if ( isalive( player ) )
                    {
                        for ( i = 0; i < br_default_inventory::getplayerbackpacksize( player ) ; i++ )
                        {
                            if ( var_1b6a9ea74101a90 && isbot( player ) && i == 0 )
                            {
                                var_1b6a9ea74101a90 = 0;
                                fakepickup.scriptablename = loot::getScriptableFromLootID( 13358 );
                                fakepickup.count = 1;
                                player br_default_inventory::additemtobackpack( 13358, fakepickup );
                                continue;
                            }
                            
                            fakepickup.scriptablename = loot::getScriptableFromLootID( lootids[ i ] );
                            maxcount = level.br_pickups.var_3444316dc55e4b0a[ fakepickup.scriptablename ];
                            
                            if ( !isdefined( maxcount ) )
                            {
                                maxcount = level.br_pickups.maxcounts[ fakepickup.scriptablename ];
                            }
                            
                            fakepickup.count = maxcount;
                            player br_default_inventory::additemtobackpack( lootids[ i ], fakepickup );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7eee1de2, Offset: 0x2215d
    // Size: 0x2cf, Type: dev
    function function_5a57af4e7244e85f()
    {
        if ( !isbrgamemode() )
        {
            return;
        }
        
        while ( true )
        {
            var_b40c799b65f02f4 = getdvarint( @"hash_78f9417314344fb8", 0 );
            
            if ( var_b40c799b65f02f4 )
            {
                setdvar( @"hash_78f9417314344fb8", 0 );
                fakepickup = spawnstruct();
                
                foreach ( player in level.players )
                {
                    if ( player.platecarrierlevel < 3 )
                    {
                        player br_pickups::lootitem( 8410, 1 );
                        player armor::setarmorhealth( 150 );
                    }
                    
                    if ( isalive( player ) )
                    {
                        var_70c4dadd47e24393 = spawnstruct();
                        var_70c4dadd47e24393.scriptablename = "<dev string:x3396>";
                        var_70c4dadd47e24393.count = 800;
                        player br_plunder::takeplunderpickup( var_70c4dadd47e24393 );
                        var_d788e791eca8ccd0 = spawnstruct();
                        var_d788e791eca8ccd0.scriptablename = "<dev string:x33b5>";
                        var_d788e791eca8ccd0.count = 220;
                        player br_pickups::takegasmask( var_d788e791eca8ccd0 );
                        var_f94431eec72ae55d = spawnstruct();
                        var_f94431eec72ae55d.scriptablename = "<dev string:x33d2>";
                        var_f94431eec72ae55d.count = 1;
                        player br_pickups::takekillstreakpickup( var_f94431eec72ae55d );
                        player br_pickups::takerevivepickup();
                        var_28b738e4e23cff26 = spawnstruct();
                        var_28b738e4e23cff26.scriptablename = "<dev string:x33f8>";
                        var_28b738e4e23cff26.count = 1;
                        player br_pickups::takeequipmentpickup( var_28b738e4e23cff26 );
                        var_30e774dcdfd74521 = spawnstruct();
                        var_30e774dcdfd74521.scriptablename = "<dev string:x340b>";
                        var_30e774dcdfd74521.count = 1;
                        player br_pickups::takeequipmentpickup( var_30e774dcdfd74521 );
                        var_6db91e1f51f21c76 = spawnstruct();
                        var_6db91e1f51f21c76.scriptablename = "<dev string:x341f>";
                        var_6db91e1f51f21c76.count = 1;
                        player br_pickups::takeequipmentpickup( var_6db91e1f51f21c76 );
                        var_9e4f62ebac1255ba = spawnstruct();
                        var_9e4f62ebac1255ba.scriptablename = "<dev string:x3434>";
                        var_9e4f62ebac1255ba.count = 1;
                        player br_pickups::takesuperpickup( var_9e4f62ebac1255ba );
                        var_417eba90f0aa6d5b = spawnstruct();
                        var_417eba90f0aa6d5b.scriptablename = "<dev string:x344e>";
                        var_417eba90f0aa6d5b.origin = player.origin;
                        var_417eba90f0aa6d5b.count = 0;
                        var_417eba90f0aa6d5b.countlefthand = 0;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xaee70ab0, Offset: 0x22434
    // Size: 0x110, Type: dev
    function function_cf36576398efca48()
    {
        if ( !isbrgamemode() )
        {
            return;
        }
        
        while ( true )
        {
            radiospawn = getdvarint( @"scr_overseer_radio", 0 );
            
            if ( radiospawn )
            {
                setdvar( @"scr_overseer_radio", 0 );
                
                foreach ( player in level.players )
                {
                    spawnoptions = namespace_9d8e359c3b1041e5::initspawnoptions_spawnfromentitysharedfunc( player );
                    agentradio = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "<dev string:x346b>", 1, spawnoptions );
                    agentradio.entitynumber = player getentitynumber();
                    agentradio.script_poi = player.closestpoi;
                    thread overseer::function_ba3ea791538298e5( agentradio );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x25678284, Offset: 0x2254c
    // Size: 0xfe, Type: dev
    function function_72dc5994a0e788fd()
    {
        while ( true )
        {
            var_3d244ac981a56580 = getdvar( @"scr_spawn_agent_name", "<dev string:x2f4>" );
            
            if ( var_3d244ac981a56580 == "<dev string:x2f4>" )
            {
                wait 0.5;
                continue;
            }
            
            localplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && !isbot( player ) && !isagent( player ) )
                {
                    localplayer = player;
                }
            }
            
            function_d3ea160a5119a9a6( localplayer, var_3d244ac981a56580 );
            wait 0.5;
            setdvar( @"scr_spawn_agent_name", "<dev string:x2f4>" );
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xd0021ab3, Offset: 0x22652
    // Size: 0x12a, Type: dev
    function function_d3ea160a5119a9a6( player, agenttype )
    {
        forward = anglestoforward( player.angles );
        targetpos = player.origin + forward * 256;
        contentarray = trace::create_itemclip_contents();
        deploytrace = trace::ray_trace( targetpos + ( 0, 0, 1024 ), targetpos, undefined, contentarray, 0, 0, 1 );
        
        if ( deploytrace[ "<dev string:x1ee>" ] != "<dev string:x3483>" )
        {
            deploypos = deploytrace[ "<dev string:x236>" ];
        }
        else
        {
            deploypos = targetpos;
        }
        
        agent = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( agenttype, deploypos, ( 0, 0, 0 ), player.team );
        
        if ( !isdefined( agent ) )
        {
            return;
        }
        
        if ( !isdefined( level.var_ac2c2d974dab660f ) )
        {
            level.var_ac2c2d974dab660f = [];
        }
        
        level.var_ac2c2d974dab660f[ level.var_ac2c2d974dab660f.size ] = agent;
        agent ai_behavior::function_4a3c03bb49dd5d76( deploypos, 4, 0 );
        agent.dontevershoot = 1;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc6baab2f, Offset: 0x22784
    // Size: 0x1e2, Type: dev
    function function_e9d765650411b698()
    {
        while ( true )
        {
            while ( getdvarint( @"hash_4f11560b700207f", 0 ) == 0 )
            {
                wait 0.5;
            }
            
            setdvar( @"hash_4f11560b700207f", 0 );
            host = level.players[ 0 ];
            bot = undefined;
            
            foreach ( player in level.players )
            {
                if ( isbot( player ) && player.team == host.team )
                {
                    bot = player;
                    break;
                }
            }
            
            if ( !isdefined( bot ) )
            {
                iprintlnbold( "<dev string:x3490>" );
                continue;
            }
            
            revivetrigger = undefined;
            
            if ( isdefined( level.revivetriggers ) )
            {
                foreach ( testtrigger in level.revivetriggers )
                {
                    if ( testtrigger.deadplayer == host )
                    {
                        revivetrigger = testtrigger;
                        break;
                    }
                }
            }
            
            wait 3;
            
            if ( player::isinlaststand( host ) )
            {
                bot thread laststand::exit( "<dev string:x34dc>", host );
                continue;
            }
            
            if ( revivetrigger )
            {
                revivetrigger teamrevive::revivetriggerholdonuse( host );
                continue;
            }
            
            iprintlnbold( "<dev string:x34ef>" );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4a03b5ce, Offset: 0x2296e
    // Size: 0x10d, Type: dev
    function function_d326d5fef6f3fc90()
    {
        while ( true )
        {
            while ( getdvarint( @"hash_69a67e687db46395", 0 ) == 0 )
            {
                wait 0.5;
            }
            
            setdvar( @"hash_69a67e687db46395", 0 );
            bot = undefined;
            
            foreach ( player in level.players )
            {
                if ( isbot( player ) )
                {
                    bot = player;
                    break;
                }
            }
            
            if ( !isdefined( bot ) )
            {
                iprintlnbold( "<dev string:x353e>" );
                continue;
            }
            
            iprintlnbold( "<dev string:x3554>" );
            bot thread teamrevive::function_9aa67ac84cd92dc7( ( 0, 0, 0 ) );
            wait 10;
            iprintlnbold( "<dev string:x3570>" );
            bot teamrevive::function_578cb5a940497b93();
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x2633ff99, Offset: 0x22a83
    // Size: 0x1f2, Type: dev
    function private function_81550f99a639f7a0()
    {
        /#
            allycount = 0;
            enemycount = 0;
            var_7a7e2ccb5fbe9b10 = 2;
            var_6d04b3c28dce7abc = 2;
            host = gamelogic_mp::gethostplayer();
            hostteam = host.team;
            hostenemyteam = utility::get_enemy_team( host.team );
            
            foreach ( player in level.players )
            {
                if ( player == host )
                {
                    continue;
                }
                
                if ( player.team == hostteam )
                {
                    allycount++;
                }
                
                if ( player.team == hostenemyteam )
                {
                    enemycount++;
                }
            }
            
            var_7a7e2ccb5fbe9b10 -= allycount;
            var_6d04b3c28dce7abc -= enemycount;
            spawnorigin = bots_debug::function_ef2181d4d3f5fbc( host );
            hostangles = host getplayerangles();
            spawnangles = ( 0, hostangles[ 1 ] + 180, 0 );
            fixedspawndata = spawnstruct();
            fixedspawndata.origin = spawnorigin;
            fixedspawndata.angles = spawnangles;
            setdvar( @"bot_disableallai", 1 );
            level [[ level.bot_funcs[ "<dev string:x2b6c>" ] ]]( var_7a7e2ccb5fbe9b10, hostteam, undefined, undefined, "<dev string:x3580>", undefined, fixedspawndata );
            level utility::waittill_any_timeout( 5, "<dev string:x3580>" );
            level [[ level.bot_funcs[ "<dev string:x2b6c>" ] ]]( var_7a7e2ccb5fbe9b10, hostenemyteam, undefined, undefined, "<dev string:x3599>", undefined, fixedspawndata );
            level utility::waittill_any_timeout( 5, "<dev string:x3599>" );
        #/
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x99e5521b, Offset: 0x22c7d
    // Size: 0x139, Type: dev
    function private function_57344da414b82a21()
    {
        bots = [];
        dist = 200;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                bots[ bots.size ] = player;
            }
        }
        
        rotationsteps = bots.size - 1;
        forward = anglestoforward( self.angles );
        up = anglestoup( self.angles );
        
        for ( i = 0; i < rotationsteps ; i++ )
        {
            degrees = 0 + 30 * i;
            rot = rotatepointaroundvector( up, forward, degrees );
            rot = vectornormalize( rot ) * dist;
            rot = self.origin + rot;
            bots[ i ] moveto( rot, 0 );
        }
    }

    // Namespace dev_mp
    // Params 1, eflags: 0x4
    // Checksum 0x2b8aa954, Offset: 0x22dbe
    // Size: 0x242, Type: dev
    function private function_eb2127ab436218c8( var_97b1f24ef79651b5 )
    {
        assert( isdefined( var_97b1f24ef79651b5 ) );
        participants = spawnstruct();
        participants.host = gamelogic_mp::gethostplayer();
        participants.bot_friendly = undefined;
        participants.bot_hostile = undefined;
        participants.bot_friendly_second = undefined;
        participants.var_e4ba94c8b367c1ff = undefined;
        participants.reviver = undefined;
        participants.revivee = undefined;
        participants.killer = undefined;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                if ( player.team == participants.host.team && !isdefined( participants.bot_friendly ) )
                {
                    participants.bot_friendly = player;
                    continue;
                }
                
                if ( player.team == participants.host.team && !isdefined( participants.bot_friendly_second ) && player != participants.bot_friendly )
                {
                    participants.bot_friendly_second = player;
                    continue;
                }
                
                if ( isenemyteam( participants.host.team, player.team ) && !isdefined( participants.bot_hostile ) )
                {
                    participants.bot_hostile = player;
                    continue;
                }
                
                if ( isenemyteam( participants.host.team, player.team ) && !isdefined( participants.var_e4ba94c8b367c1ff ) && player != participants.bot_hostile )
                {
                    participants.var_e4ba94c8b367c1ff = player;
                }
            }
        }
        
        return participants;
    }

    // Namespace dev_mp
    // Params 1, eflags: 0x4
    // Checksum 0xf3d7f7e3, Offset: 0x23008
    // Size: 0x558, Type: dev
    function private function_c024953b31b87779( var_97b1f24ef79651b5 )
    {
        assert( isdefined( var_97b1f24ef79651b5 ) );
        testdata = var_97b1f24ef79651b5;
        reviveents = spawnstruct();
        reviveents.var_d06b965ba5742b02 = undefined;
        reviveents.var_85e54fcc715e0d56 = undefined;
        reviveents.var_43ab4fac99346235 = undefined;
        reviveents.laststandreviveent = undefined;
        reviveents.var_3239553af45c0de9 = [];
        
        foreach ( ent in level.laststandreviveents )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( ent.id != "<dev string:x35b8>" )
            {
                continue;
            }
            
            if ( !isdefined( ent.owner ) )
            {
                continue;
            }
            
            reviveents.var_3239553af45c0de9[ ent.owner getentitynumber() ] = ent;
            
            if ( isdefined( testdata.participants.host ) && ent.owner getentitynumber() == testdata.participants.host getentitynumber() )
            {
                reviveents.var_d06b965ba5742b02 = ent;
            }
            
            if ( isdefined( testdata.participants.bot_friendly ) && ent.owner getentitynumber() == testdata.participants.bot_friendly getentitynumber() )
            {
                reviveents.var_85e54fcc715e0d56 = ent;
            }
            
            if ( isdefined( testdata.participants.bot_hostile ) && ent.owner getentitynumber() == testdata.participants.bot_hostile getentitynumber() )
            {
                reviveents.var_43ab4fac99346235 = ent;
            }
        }
        
        if ( isdefined( testdata.participants.revivee ) )
        {
            reviveents.laststandreviveent = reviveents.var_3239553af45c0de9[ testdata.participants.revivee getentitynumber() ];
        }
        
        reviveents.var_85bd5b8d6f32208 = undefined;
        reviveents.var_a4270815dbc152fc = undefined;
        reviveents.var_40d35763cfea73a3 = undefined;
        reviveents.var_c9f1e562c271c7c1 = undefined;
        reviveents.var_11ce354c3dcdb00 = undefined;
        reviveents.var_b4a596937f855bbe = undefined;
        reviveents.var_fbb097618cc340d0 = [];
        
        if ( isdefined( level.revivetriggers ) )
        {
            foreach ( testtrigger in level.revivetriggers )
            {
                if ( !isdefined( testtrigger ) )
                {
                    continue;
                }
                
                reviveents.var_fbb097618cc340d0[ testtrigger.owner getentitynumber() ] = testtrigger;
                
                if ( isdefined( testdata.participants.host ) && testtrigger.deadplayer getentitynumber() == testdata.participants.host getentitynumber() )
                {
                    reviveents.var_85bd5b8d6f32208 = testtrigger;
                }
                
                if ( isdefined( testdata.participants.bot_friendly ) && testtrigger.deadplayer getentitynumber() == testdata.participants.bot_friendly getentitynumber() )
                {
                    reviveents.var_a4270815dbc152fc = testtrigger;
                }
                
                if ( isdefined( testdata.participants.bot_friendly_second ) && testtrigger.deadplayer getentitynumber() == testdata.participants.bot_friendly_second getentitynumber() )
                {
                    reviveents.var_c9f1e562c271c7c1 = testtrigger;
                }
                
                if ( isdefined( testdata.participants.bot_hostile ) && testtrigger.deadplayer getentitynumber() == testdata.participants.bot_hostile getentitynumber() )
                {
                    reviveents.var_40d35763cfea73a3 = testtrigger;
                }
                
                if ( isdefined( testdata.participants.var_e4ba94c8b367c1ff ) && testtrigger.deadplayer getentitynumber() == testdata.participants.var_e4ba94c8b367c1ff getentitynumber() )
                {
                    reviveents.var_11ce354c3dcdb00 = testtrigger;
                }
            }
            
            if ( isdefined( testdata.participants.revivee ) )
            {
                reviveents.var_b4a596937f855bbe = reviveents.var_fbb097618cc340d0[ testdata.participants.revivee getentitynumber() ];
            }
        }
        
        return reviveents;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xbb2925a7, Offset: 0x23568
    // Size: 0x93, Type: dev
    function function_44ddd03daa83cd6d()
    {
        setdvar( @"hash_f613b218fa0c3df6", 0 );
        
        while ( true )
        {
            dvarval = getdvarfloat( @"hash_f613b218fa0c3df6", 0 );
            
            while ( dvarval <= 0 )
            {
                dvarval = getdvarfloat( @"hash_f613b218fa0c3df6", 0 );
                wait 0.5;
            }
            
            host = level.players[ 0 ];
            host waittill( #"hash_e1ca0418f57dd9e3" );
            wait dvarval;
            host kill();
            setdvar( @"hash_f613b218fa0c3df6", 0 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xeb8c288d, Offset: 0x23603
    // Size: 0x21, Type: dev
    function function_95c59ea7bf11093c()
    {
        level thread function_3ea720be96a67b0c( @"hash_62a47106347dc9c3", 0, "<dev string:x35ca>", "<dev string:x35dd>" );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1ef38f85, Offset: 0x2362c
    // Size: 0x120, Type: dev
    function function_1822d56d2fe4fb70()
    {
        setdvar( @"hash_b5894713b17effdc", 0 );
        
        while ( true )
        {
            while ( getdvarint( @"hash_b5894713b17effdc", 0 ) == 0 )
            {
                wait 1;
            }
            
            setdvar( @"hash_b5894713b17effdc", 0 );
            spawndata = spawnstruct();
            spawndata.origin = level.players[ 0 ].origin + ( 0, 0, 300 );
            spawndata.initai = 1;
            ground = utility::drop_to_ground( spawndata.origin );
            littlebird = vehicle::spawn( %"hash_49602cb7beee6fba", spawndata );
            hoverheight = undefined;
            
            while ( isdefined( littlebird ) )
            {
                newhoverheight = getdvarfloat( @"hash_113aed1a7952f7bf", 200 );
                
                if ( newhoverheight != hoverheight )
                {
                    littlebird vehicle_helisetai( ground + ( 0, 0, newhoverheight ), undefined, undefined, undefined, undefined, undefined, 0, undefined, 0, 1, 0, 0, 0 );
                }
                
                hoverheight = newhoverheight;
                wait 0.5;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x304872c0, Offset: 0x23754
    // Size: 0xcd, Type: dev
    function function_7ebbd6f0243f96d1()
    {
        setdvar( @"hash_524c399fc04122a3", 0 );
        
        while ( getdvarint( @"hash_524c399fc04122a3", 0 ) == 0 )
        {
            wait 1;
        }
        
        level.getspawnpoint = &function_d4deb40650a2d4d7;
        
        while ( true )
        {
            wait 4;
            
            foreach ( bot in level.players )
            {
                if ( !isbot( bot ) )
                {
                    continue;
                }
                
                bot kill();
                wait 1;
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf783ade, Offset: 0x23829
    // Size: 0x37a, Type: dev
    function function_d4deb40650a2d4d7()
    {
        self.wassquadspawned = 0;
        vehicleent = undefined;
        
        if ( isdefined( level.vehicle.instances[ %"hash_1dd941f8f4026e3" ] ) )
        {
            foreach ( vehicle in level.vehicle.instances[ %"hash_1dd941f8f4026e3" ] )
            {
                vehicleent = vehicle;
                break;
            }
        }
        
        spawnpoint = spawnlogic::getspawnpoint( self, self.team, undefined, undefined, "<dev string:x35f1>" );
        
        if ( !isdefined( vehicleent ) )
        {
            return spawnpoint;
        }
        
        forwardoffset = -200;
        heightoffset = 64;
        spawnpoint.origin = vehicleent.origin + anglestoforward( vehicleent.angles ) * forwardoffset + ( 0, 0, heightoffset );
        spawnpoint.angles = ( 0, vehicleent.angles[ 1 ], 0 );
        seat = vehicle_occupancy::function_495d488c998ad412( vehicleent );
        
        if ( isdefined( seat ) && vehicle_interact::vehicle_can_be_used( vehicleent ) && ( vehicle_spawn::get_data( vehicleent vehicle::get_ref() ).var_2a99601c04eec8f0 || seat == "<dev string:x35f5>" ) )
        {
            data = spawnstruct();
            data.useonspawn = 1;
            data.enterstartwaitmsg = "<dev string:xddd>";
            thread vehicle_occupancy::enter( vehicleent, seat, self, data );
        }
        else
        {
            exitboundinginfo = vehicle_occupancy::get_exit_info( vehicleent );
            occupancydata = vehicle_occupancy::get_data( vehicleent vehicle::get_ref() );
            var_9989cf5ea2dc4b23 = 0;
            
            foreach ( ref, direction in occupancydata.exitdirections )
            {
                if ( direction == "<dev string:x35fc>" || direction == "<dev string:x3600>" )
                {
                    exit = vehicle_occupancy::get_exit_position( vehicleent, self, ref, exitboundinginfo, 1 );
                    
                    if ( isdefined( exit.origin ) )
                    {
                        spawnpoint.origin = exit.origin;
                        self.var_52451a3506366553 = vehicleent;
                        thread vehicle_collision::function_e3bc60c772acd609( vehicleent, self );
                        break;
                    }
                    
                    if ( !var_9989cf5ea2dc4b23 )
                    {
                        var_9989cf5ea2dc4b23 = 1;
                        leveldataforvehicle = vehicle_occupancy::get_data( vehicleent vehicle::get_ref() );
                        exitoffset = leveldataforvehicle.exitoffsets[ ref ];
                        spawnpoint.origin = vehicleent.origin + rotatevector( exitoffset, vehicleent.angles );
                        self.var_52451a3506366553 = vehicleent;
                        thread vehicle_collision::function_e3bc60c772acd609( vehicleent, self );
                    }
                }
            }
        }
        
        self.spawningintovehicle = 1;
        return spawnpoint;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb6bb11ff, Offset: 0x23bab
    // Size: 0xc5, Type: dev
    function devsetmovespeedscale()
    {
        lastvalue = 0;
        
        while ( true )
        {
            scale = getdvarfloat( @"hash_69bee8bf23e3b16f", 0 );
            
            if ( scale != 0 && scale != lastvalue )
            {
                foreach ( player in level.players )
                {
                    player setmovespeedscale( scale );
                    lastvalue = scale;
                }
            }
            
            wait 0.25;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x971ca670, Offset: 0x23c78
    // Size: 0xe7, Type: dev
    function function_1643ce59962a1c48()
    {
        if ( getdvarint( @"hash_97876abc9904a097", 0 ) == 0 )
        {
            return;
        }
        
        while ( true )
        {
            var_1643ce59962a1c48 = getdvarint( @"hash_97876abc9904a097", 0 ) != 0;
            
            foreach ( player in level.players )
            {
                hide = var_1643ce59962a1c48 && ( player isnoclip() || player isufo() );
                
                if ( hide )
                {
                    player playerhide();
                    continue;
                }
                
                player playershow();
            }
            
            wait 0.25;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xccd6ad8e, Offset: 0x23d67
    // Size: 0xde, Type: dev
    function function_2ad72e198d9ced09()
    {
        setdvar( @"hash_191cedf037a1c0e", 0 );
        
        while ( getdvarint( @"hash_191cedf037a1c0e", 0 ) == 0 )
        {
            wait 1;
        }
        
        foreach ( a in level.ascendstructs )
        {
            drawduration = 10;
            spherecolor = ( 1, 0, 0 );
            thread debug_utility::drawsphere( a.origin, 5, drawduration, spherecolor );
        }
        
        thread function_2ad72e198d9ced09();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x35272938, Offset: 0x23e4d
    // Size: 0x3b, Type: dev
    function function_3d0775a8d9da57b5()
    {
        setdvar( @"hash_1c59bb31183ed670", 0 );
        
        while ( getdvarint( @"hash_1c59bb31183ed670", 0 ) == 0 )
        {
            wait 1;
        }
        
        ent_manager::function_83d7500b56501ebf();
        thread function_3d0775a8d9da57b5();
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0xacca42a7, Offset: 0x23e90
    // Size: 0x25d, Type: dev
    function function_2c2ccf53ea3672a4( player, entnum )
    {
        if ( entnum > 0 )
        {
            foreach ( var_6d62b20cda1a1b11 in level.players )
            {
                if ( var_6d62b20cda1a1b11 getentitynumber() == entnum )
                {
                    return var_6d62b20cda1a1b11;
                }
            }
        }
        
        playerorigin = player.origin;
        playerangles = player getplayerangles();
        playerforward = anglestoforward( playerangles );
        tracestart = ( playerorigin[ 0 ], playerorigin[ 1 ], playerorigin[ 2 ] + player getplayerviewheight() );
        traceend = tracestart + playerforward * 5000;
        tracecontents = trace::create_default_contents( 0 );
        trace = trace::ray_trace( tracestart, traceend, player, tracecontents );
        ignoremeatshield = getdvarint( @"hash_37cada504d40f2b" ) == 1;
        
        if ( isbot( trace[ "<dev string:x205>" ] ) && ( !ignoremeatshield || ignoremeatshield && !trace[ "<dev string:x205>" ] ismeatshieldvictim() ) )
        {
            return trace[ "<dev string:x205>" ];
        }
        
        closestbot = undefined;
        closestdist = 0;
        
        foreach ( otherplayer in level.players )
        {
            if ( isbot( otherplayer ) )
            {
                dist = distance2dsquared( otherplayer.origin, trace[ "<dev string:x236>" ] );
                
                if ( ( closestdist == 0 || dist < closestdist ) && ( !ignoremeatshield || ignoremeatshield && !otherplayer ismeatshieldvictim() ) )
                {
                    closestdist = dist;
                    closestbot = otherplayer;
                }
            }
        }
        
        return closestbot;
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x5b342cf4, Offset: 0x240f5
    // Size: 0xad, Type: dev
    function function_25bf9ebdc4e323e2( entnum )
    {
        player = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( player ) )
        {
            iprintlnbold( "<dev string:x3607>" );
            return;
        }
        
        if ( !player function_ee74289b1224b9d7() )
        {
            bot = function_2c2ccf53ea3672a4( player, entnum );
            
            if ( isdefined( bot ) )
            {
                level notify( #"hash_8862918c7aa44ac0", player, bot );
                player controlslinkto( bot );
                player.var_45f7e72b795b2519 = 1;
                player.var_cc908aa2d972bedb = bot;
                player allowjump( 0 );
                player disableweapons();
                player thread function_c7cf6ad324d4c616();
                player thread function_7e64219298b739f8( bot );
            }
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x1af090bf, Offset: 0x241aa
    // Size: 0x6f, Type: dev
    function function_ee74289b1224b9d7()
    {
        player = self;
        
        if ( player.var_45f7e72b795b2519 )
        {
            level notify( #"hash_6f681f3ba947f2e1" );
            player notify( #"hash_6f681f3ba947f2e1" );
            player controlsunlink( 1 );
            player.var_45f7e72b795b2519 = 0;
            player.var_cc908aa2d972bedb = undefined;
            player allowjump( 1 );
            player enableweapons();
            return 1;
        }
        
        return 0;
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x23d7aca3, Offset: 0x24221
    // Size: 0x42, Type: dev
    function function_c7cf6ad324d4c616()
    {
        player = self;
        level endon( #"game_ended" );
        player endon( #"hash_6f681f3ba947f2e1" );
        player waittill( #"death" );
        player thread function_ee74289b1224b9d7();
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xf8948202, Offset: 0x2426b
    // Size: 0x52, Type: dev
    function function_7e64219298b739f8( bot )
    {
        player = self;
        level endon( #"game_ended" );
        player endon( #"hash_6f681f3ba947f2e1" );
        bot waittill( #"death" );
        wait 0.5;
        player thread function_ee74289b1224b9d7();
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xd19af4e, Offset: 0x242c5
    // Size: 0xb5, Type: dev
    function function_88c949e6cb1109e2( entnum )
    {
        player = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( player ) )
        {
            iprintlnbold( "<dev string:x3607>" );
            return;
        }
        
        if ( getdvarint( @"hash_3b784c215aed7807" ) != 0 )
        {
            setdvar( @"hash_3b784c215aed7807", 0 );
            player cameraunlink();
            player allowjump( 1 );
            player enableweapons();
            return;
        }
        
        bot = function_2c2ccf53ea3672a4( player, entnum );
        
        if ( isdefined( bot ) )
        {
            player cameralinkto( bot, "<dev string:x3625>", 1 );
            player allowjump( 0 );
            player disableweapons();
            setdvar( @"hash_3b784c215aed7807", 1 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x985f7112, Offset: 0x24382
    // Size: 0x75, Type: dev
    function function_3d33861f9e4a2a1e()
    {
        while ( true )
        {
            entnum = getdvarint( @"hash_4ad91d42246ab0eb" );
            
            if ( entnum )
            {
                function_25bf9ebdc4e323e2( entnum );
                setdvar( @"hash_4ad91d42246ab0eb", 0 );
            }
            
            entnum = getdvarint( @"hash_edb2160c1c990c65" );
            
            if ( entnum )
            {
                function_88c949e6cb1109e2( entnum );
                setdvar( @"hash_edb2160c1c990c65", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdd0b7725, Offset: 0x243ff
    // Size: 0xbe, Type: dev
    function function_69f15ee6b34ce911()
    {
        setdvar( @"scr_force_music", "<dev string:x2f4>" );
        playing = 0;
        
        while ( true )
        {
            if ( !playing && getdvar( @"scr_force_music", "<dev string:x2f4>" ) != "<dev string:x2f4>" )
            {
                level.players[ 0 ] setplayermusicstate( "<dev string:x3630>", [ getdvar( @"scr_force_music", "<dev string:x2f4>" ) ] );
                playing = 1;
            }
            else if ( playing && getdvar( @"scr_force_music", "<dev string:x2f4>" ) == "<dev string:x2f4>" )
            {
                level.players[ 0 ] stopplayermusicstate( "<dev string:x3630>" );
                playing = 0;
            }
            
            wait 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xca3b0762, Offset: 0x244c5
    // Size: 0xa6, Type: dev
    function splashesdevgui()
    {
        while ( getdvar( @"hash_2c0beeb4679914a5", "<dev string:x2ef>" ) == "<dev string:x2ef>" )
        {
            wait 1;
        }
        
        var_3e07aa6a38998ff6 = getdvar( @"hash_2c0beeb4679914a5", "<dev string:x2ef>" );
        
        if ( game_utility::getgametype() == "<dev string:x708>" )
        {
            br_gametype_dmz::showdmzsplash( var_3e07aa6a38998ff6, level.players, "<dev string:x363a>" );
        }
        else
        {
            setdvar( @"hash_c39067c564e9be9", 0 );
            setdvar( @"scr_show_splash", var_3e07aa6a38998ff6 );
        }
        
        setdvar( @"hash_2c0beeb4679914a5", "<dev string:x2ef>" );
        thread splashesdevgui();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7b836784, Offset: 0x24573
    // Size: 0x56, Type: dev
    function devprint()
    {
        while ( true )
        {
            msg = getdvar( @"scr_print", "<dev string:x2f4>" );
            
            if ( msg != "<dev string:x2f4>" )
            {
                iprintlnbold( msg );
                setdvar( @"scr_print", "<dev string:x2f4>" );
            }
            
            wait 0.5;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xba7b6594, Offset: 0x245d1
    // Size: 0x207, Type: dev
    function function_9633c9e9d5aba759()
    {
        level.var_41d16a340f1eb446 = [];
        
        while ( true )
        {
            radius = getdvarint( @"scr_quest_circle_create", 0 );
            
            if ( radius > 0 )
            {
                setdvar( @"scr_quest_circle_create", 0 );
                host = level.players[ 0 ];
                
                if ( !isdefined( host ) )
                {
                    wait 0.5;
                    continue;
                }
                
                origin = host.origin;
                circleobjective = spawnstruct();
                circleobjective.curorigin = origin;
                circleobjective.offset3d = ( 0, 0, 100 );
                circleobjective gameobjects::requestid( 1, 1, undefined, 1, 0 );
                objidpoolmanager::update_objective_setbackground( circleobjective.objidnum, 1 );
                objidpoolmanager::update_objective_setzoffset( circleobjective.objidnum, 100 );
                objidpoolmanager::update_objective_ownerteam( circleobjective.objidnum, host.team );
                objidpoolmanager::objective_playermask_showtoall( circleobjective.objidnum );
                circleobjective game_utility::questcircle_create( "<dev string:x363f>", origin, radius, host );
                circleobjective game_utility::questcircle_showtoall();
                level.var_41d16a340f1eb446[ level.var_41d16a340f1eb446.size ] = circleobjective;
            }
            
            clearcircles = getdvarint( @"scr_quest_circle_delete", 0 );
            
            if ( clearcircles )
            {
                setdvar( @"scr_quest_circle_delete", 0 );
                
                foreach ( circleobjective in level.var_41d16a340f1eb446 )
                {
                    circleobjective notify( #"stop_tracking" );
                    circleobjective gameobjects::releaseid();
                    circleobjective game_utility::questcircle_delete();
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf5b4cd14, Offset: 0x247e0
    // Size: 0x46, Type: dev
    function function_5514a33d3e21c1e1()
    {
        level.spawnpos = level.players[ 0 ].origin;
        level.spawnang = ( 0, level.players[ 0 ] getplayerangles( 1 )[ 1 ] + 180, 0 );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xfacc3a0, Offset: 0x2482e
    // Size: 0x3d, Type: dev
    function function_32d3b2a2c6812a11( bot )
    {
        bot setorigin( level.spawnpos + ( 0, 0, 18 ) );
        bot setplayerangles( level.spawnang );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa3c49fd0, Offset: 0x24873
    // Size: 0x9e, Type: dev
    function function_ac6a72612dd141b9()
    {
        bookmarkstart = "<dev string:x364a>";
        bookmarkend = "<dev string:x36c4>";
        
        if ( !isdefined( level.debugbookmark ) )
        {
            level.debugbookmark = 1;
        }
        
        while ( true )
        {
            if ( getdvarint( @"scr_debugbookmark" ) == 1 )
            {
                debugmark = level.debugbookmark ? bookmarkstart : bookmarkend;
                println( debugmark );
                setdvar( @"scr_debugbookmark", 0 );
                level.debugbookmark = !level.debugbookmark;
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf16eb72, Offset: 0x24919
    // Size: 0x2f2, Type: dev
    function snapshotallplayers()
    {
        dvarstring = getdvar( @"hash_6a93ed78e507e165", "<dev string:x2f4>" );
        filepath = "<dev string:x373e>" + dvarstring;
        fileid = openfile( filepath, "<dev string:x2331>" );
        axisplayers = [];
        alliesplayers = [];
        
        foreach ( player in level.players )
        {
            if ( player.team == "<dev string:x4e4>" )
            {
                axisplayers[ axisplayers.size ] = player;
                continue;
            }
            
            alliesplayers[ alliesplayers.size ] = player;
        }
        
        foreach ( axis in axisplayers )
        {
            var_d58ba5806537c55 = axis.origin[ 0 ] + "<dev string:x356>" + axis.origin[ 1 ] + "<dev string:x356>" + axis.origin[ 2 ] + "<dev string:x124b>" + axis.angles[ 0 ] + "<dev string:x356>" + axis.angles[ 1 ] + "<dev string:x356>" + axis.angles[ 2 ] + "<dev string:x124b>" + axis.team;
            fprintln( fileid, var_d58ba5806537c55 );
        }
        
        foreach ( allies in alliesplayers )
        {
            var_d58ba5806537c55 = allies.origin[ 0 ] + "<dev string:x356>" + allies.origin[ 1 ] + "<dev string:x356>" + allies.origin[ 2 ] + "<dev string:x124b>" + allies.angles[ 0 ] + "<dev string:x356>" + allies.angles[ 1 ] + "<dev string:x356>" + allies.angles[ 2 ] + "<dev string:x124b>" + allies.team;
            fprintln( fileid, var_d58ba5806537c55 );
        }
        
        closefile( fileid );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0xd66db763, Offset: 0x24c13
    // Size: 0x1ac, Type: dev
    function function_cc6f138a63c2a74( list )
    {
        axisplayers = [];
        alliesplayers = [];
        axiscounter = 0;
        alliescounter = 0;
        
        foreach ( player in level.players )
        {
            if ( player.team == "<dev string:x4e4>" )
            {
                axisplayers[ axisplayers.size ] = player;
                continue;
            }
            
            alliesplayers[ alliesplayers.size ] = player;
        }
        
        foreach ( item in list )
        {
            if ( item.teams == "<dev string:x4e4>" )
            {
                axisplayers[ axiscounter ] setorigin( item.origin );
                axisplayers[ axiscounter ] setplayerangles( item.angles );
                axiscounter += 1;
                continue;
            }
            
            alliesplayers[ alliescounter ] setorigin( item.origin );
            alliesplayers[ alliescounter ] setplayerangles( item.angles );
            alliescounter += 1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf3a14154, Offset: 0x24dc7
    // Size: 0x173, Type: dev
    function function_b758cea18793fa7e()
    {
        dvarstring = getdvar( @"hash_6a93ed78e507e165", "<dev string:x2f4>" );
        filepath = "<dev string:x373e>" + dvarstring;
        fileid = openfile( filepath, "<dev string:x374a>" );
        filecontent = function_34c9c07bc2a5ff96( fileid );
        filecontent = function_34c9c07bc2a5ff96( fileid );
        contentlist = strtok( filecontent, "<dev string:xfa5>" );
        array_loc_info = [];
        
        foreach ( lineitem in contentlist )
        {
            tempstring = strtok( lineitem, "<dev string:x124b>" );
            test = strtok( lineitem, "<dev string:x2da>" );
            loc_info = spawnstruct();
            loc_info.origin = utility::stringtovec3( tempstring[ 0 ] );
            loc_info.angles = utility::stringtovec3( tempstring[ 1 ] );
            loc_info.teams = tempstring[ 2 ];
            array_loc_info[ array_loc_info.size ] = loc_info;
        }
        
        function_cc6f138a63c2a74( array_loc_info );
        closefile( fileid );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xb63cce90, Offset: 0x24f42
    // Size: 0x39, Type: dev
    function spawnsnapshot()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_spawns_snapshot" ) )
            {
                snapshotallplayers();
                setdvar( @"scr_spawns_snapshot", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xf9709b63, Offset: 0x24f83
    // Size: 0x39, Type: dev
    function function_971ceaf40064133f()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_snapshot_teleport" ) )
            {
                function_b758cea18793fa7e();
                setdvar( @"scr_snapshot_teleport", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xeb33ac77, Offset: 0x24fc4
    // Size: 0x8c, Type: dev
    function allowclassswap()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_allow_classswap" ) )
            {
                level.var_7501b1ce6afaa90b = 1;
                
                /#
                    level.var_ae23cdf298259a28 = 1;
                #/
                
                setdvar( @"scr_allow_classswap", 0 );
            }
            
            if ( !getdvarint( @"hash_631019b694e27352" ) && isdefined( level.gametypebundle ) && level.gametypebundle.allowclassswap )
            {
                level.var_7501b1ce6afaa90b = 1;
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9166b324, Offset: 0x25058
    // Size: 0xf8, Type: dev
    function swapskin()
    {
        while ( true )
        {
            if ( !isdefined( level.players ) || !level.players.size )
            {
                waitframe();
                continue;
            }
            
            skin = getdvar( @"hash_17a1591e3fe7c036", "<dev string:x2f4>" );
            
            if ( skin != "<dev string:x2f4>" )
            {
                foreach ( player in level.players )
                {
                    function_7620e0b2c7508d1e( player, getxhashasset( skin ) );
                }
                
                level.var_7501b1ce6afaa90b = 1;
                setdvar( @"hash_17a1591e3fe7c036", "<dev string:x2f4>" );
            }
            
            wait 0.1;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4a11dc60, Offset: 0x25158
    // Size: 0xba, Type: dev
    function function_69373454392ee259()
    {
        /#
            while ( true )
            {
                if ( getdvarint( @"hash_17bb7ff71c139bfe", 0 ) )
                {
                    level.var_7501b1ce6afaa90b = 1;
                    
                    foreach ( player in level.players )
                    {
                        bots_debug::function_f77865bdc33a68e2( player );
                    }
                    
                    setdvar( @"hash_17bb7ff71c139bfe", 0 );
                }
                
                wait 0.1;
            }
        #/
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xd3a5e482, Offset: 0x2521a
    // Size: 0xc4, Type: dev
    function function_22b3e8c41e35030b()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            host = level.players[ 0 ];
            debugstring = getdvar( @"hash_b6f531c775f8a67e", "<dev string:x2f4>" );
            
            if ( isdefined( host ) && debugstring != "<dev string:x2f4>" )
            {
                switch ( debugstring )
                {
                    case #"hash_ca51c18a00a0a89c":
                        host setclientomnvar( "<dev string:x374f>", 1 );
                        break;
                    case #"hash_7ebb454a971d80d":
                        host setclientomnvar( "<dev string:x374f>", 0 );
                        break;
                    default:
                        break;
                }
                
                setdvar( @"hash_b6f531c775f8a67e", "<dev string:x2f4>" );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xc3f9e81c, Offset: 0x252e6
    // Size: 0x72, Type: dev
    function devchangeteam()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            host = level.players[ 0 ];
            val = getdvarint( @"hash_20fb386e44deb0c5", -1 );
            
            if ( val > -1 )
            {
                host thread menus::handleteamchange( "<dev string:x375d>", val );
            }
            
            setdvar( @"hash_20fb386e44deb0c5", -1 );
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x982b9eca, Offset: 0x25360
    // Size: 0x219, Type: dev
    function function_102299591efd4e8d()
    {
        firstpoint = 1;
        rulerstruct = spawnstruct();
        level waittill( #"prematch_done" );
        
        while ( true )
        {
            host = level.players[ 0 ];
            
            if ( !getdvarint( @"hash_94f1a2576daafe63" ) )
            {
                if ( isdefined( host.activerulers ) )
                {
                    foreach ( ruler in host.activerulers )
                    {
                        ruler notify( #"clear_ruler" );
                    }
                    
                    host.activerulers = undefined;
                }
                
                wait 1;
                continue;
            }
            
            host waittill( #"weapon_fired" );
            playerangles = host getplayerangles();
            playerforward = anglestoforward( playerangles );
            playereye = host geteye();
            traceresults = trace::ray_trace( playereye, playereye + playerforward * 20000 );
            
            if ( !isdefined( traceresults[ "<dev string:x236>" ] ) )
            {
                waitframe();
                continue;
            }
            
            color = firstpoint ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            rulerstruct thread function_8a2bc13d7131b7d3( traceresults[ "<dev string:x236>" ], color, firstpoint );
            
            if ( !firstpoint )
            {
                if ( !isdefined( host.activerulers ) )
                {
                    host.activerulers = [];
                }
                
                host.activerulers[ host.activerulers.size ] = rulerstruct;
                rulerstruct thread function_b1b0f137115b4316( getdvarint( @"hash_3bf47f1489cb6cc1", 60 ) );
                rulerstruct = spawnstruct();
            }
            else
            {
                rulerstruct.startpoint = traceresults[ "<dev string:x236>" ];
            }
            
            firstpoint = !firstpoint;
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x183c85a4, Offset: 0x25581
    // Size: 0xaf, Type: dev
    function function_3e5aee9bd0e332e7()
    {
        self endon( #"death_or_disconnect" );
        
        /#
            setdevdvarifuninitialized( @"hash_129223b87cbd4ed6", 0 );
        #/
        
        wait 1;
        cacheddvarvalue = 0;
        
        while ( true )
        {
            player = gamelogic_mp::gethostplayer();
            
            if ( isdefined( player ) )
            {
                currentdvarval = getdvarint( @"hash_129223b87cbd4ed6", 0 );
                
                if ( currentdvarval != cacheddvarvalue )
                {
                    if ( currentdvarval == 1 )
                    {
                        player setalternatemode( player.currentweapon, 1 );
                    }
                    else
                    {
                        player setalternatemode( player.currentweapon, 0 );
                    }
                    
                    cacheddvarvalue = currentdvarval;
                }
            }
            
            wait 0.25;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x9166693a, Offset: 0x25638
    // Size: 0x106, Type: dev
    function function_9ea5ddbfa2857f13()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"hash_8bdf3c3b87f737d3", 0 );
        
        while ( true )
        {
            value = getdvarint( @"hash_8bdf3c3b87f737d3", 0 );
            
            if ( value > 0 )
            {
                setdvar( @"hash_8bdf3c3b87f737d3", 0 );
                
                foreach ( player in level.players )
                {
                    player setclientomnvar( "<dev string:x3763>", 31 );
                    player setclientomnvar( "<dev string:x3780>", 90358 );
                    waitframe();
                    player setclientomnvar( "<dev string:x3763>", 0 );
                    player setclientomnvar( "<dev string:x3780>", 0 );
                }
            }
            
            wait 0.5;
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xea66e3cf, Offset: 0x25746
    // Size: 0x108, Type: dev
    function function_e0ad357d47c0b565()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_b14d6bb2fbc4c3d8 = getdvar( @"hash_b9bb1133beef333c", "<dev string:x2f4>" );
            
            if ( var_b14d6bb2fbc4c3d8 == "<dev string:x2f4>" )
            {
                wait 0.5;
                continue;
            }
            
            localplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && isplayer( player ) && !isbot( player ) )
                {
                    localplayer = player;
                }
            }
            
            function_b7b7f3441d8ce8a7( localplayer );
            wait 0.5;
            setdvar( @"hash_b9bb1133beef333c", "<dev string:x2f4>" );
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x849f5898, Offset: 0x25856
    // Size: 0x113, Type: dev
    function function_b7b7f3441d8ce8a7( player )
    {
        if ( !utility::issharedfuncdefined( #"interactiveworld", #"hash_6c5301579cd2777" ) )
        {
            return;
        }
        
        var_828eaa480e3c3062 = 1000;
        spawnposition = player.origin + ( 100, 0, 0 );
        eyeposition = player geteye();
        viewdirection = player getplayerangles();
        forwardvector = anglestoforward( viewdirection );
        var_1a3bb76a4c11aabf = eyeposition + forwardvector * var_828eaa480e3c3062;
        traceresult = trace::ray_trace( eyeposition, var_1a3bb76a4c11aabf );
        
        if ( traceresult[ "<dev string:x1ee>" ] != "<dev string:x3483>" )
        {
            spawnposition = traceresult[ "<dev string:x236>" ];
        }
        else
        {
            spawnposition = var_1a3bb76a4c11aabf;
        }
        
        utility::callsharedfunc( #"interactiveworld", #"hash_6c5301579cd2777", spawnposition, %"hash_173be7336020385e", 10, 10, 1000, ( 0, 0, 0 ), 0, undefined, undefined, 0 );
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x87613fbe, Offset: 0x25971
    // Size: 0x36, Type: dev
    function function_b1b0f137115b4316( time )
    {
        level endon( #"game_ended" );
        self endon( #"clear_ruler" );
        wait time;
        self notify( #"clear_ruler" );
    }

    // Namespace dev_mp
    // Params 3
    // Checksum 0xd5aac72a, Offset: 0x259af
    // Size: 0xb8, Type: dev
    function function_8a2bc13d7131b7d3( origin, color, firstpoint )
    {
        level endon( #"game_ended" );
        self endon( #"clear_ruler" );
        dist = undefined;
        midpoint = undefined;
        
        if ( !firstpoint )
        {
            dist = distance( self.startpoint, origin );
            midpoint = ( origin + self.startpoint ) / 2;
            iprintln( "<dev string:x214a>" + dist );
        }
        
        while ( true )
        {
            sphere( origin, 10, color );
            
            if ( !firstpoint )
            {
                print3d( midpoint, dist );
                line( self.startpoint, origin );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x2f05bde9, Offset: 0x25a6f
    // Size: 0x16f, Type: dev
    function function_c85a57f70a979c98()
    {
        if ( getdvarint( @"hash_5ca31f9195e4988f" ) > 0 )
        {
            level notify( #"hash_e69c7fee2cdc3479" );
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 1 )
            {
                function_56590fe5f4c35ead();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 2 )
            {
                function_862d727b4a2a1030();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 3 )
            {
                function_9897b7bd7c24e29();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 4 )
            {
                function_b9f3b196b194b2b();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 5 )
            {
                function_f7d1fd899e0db78f();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 6 )
            {
                function_33ac062812ce20();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 7 )
            {
                function_f1610035fb9774f3();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 8 )
            {
                level thread function_cb7029fa3cc81003();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 9 )
            {
                level thread function_33da32e8fcf7d2d();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 11 )
            {
                level thread function_44cf073615163030();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 12 )
            {
                level thread function_1c2bb1eec058b9fa();
            }
            
            if ( getdvarint( @"hash_5ca31f9195e4988f" ) == 13 )
            {
                level thread function_33f9f1239636bd98();
            }
            
            setdvar( @"hash_5ca31f9195e4988f", 0 );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x7733f176, Offset: 0x25be6
    // Size: 0x32, Type: dev
    function function_56590fe5f4c35ead()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5916c2d0, Offset: 0x25c20
    // Size: 0x51, Type: dev
    function function_862d727b4a2a1030()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 180, 30 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x50d4a800, Offset: 0x25c79
    // Size: 0xad, Type: dev
    function function_9897b7bd7c24e29()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37b9>", 0, 100, 30, 50 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 90, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 180, 10 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 0, 20 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xdc30f59d, Offset: 0x25d2e
    // Size: 0x89, Type: dev
    function function_b9f3b196b194b2b()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37c9>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37c9>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37c9>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37c9>", 0, 100, 0, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe75ce9fa, Offset: 0x25dbf
    // Size: 0x3c, Type: dev
    function function_f7d1fd899e0db78f()
    {
        level.players[ 0 ] viewkick( 100, level.players[ 0 ].origin );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x890d06ac, Offset: 0x25e03
    // Size: 0x61, Type: dev
    function function_33ac062812ce20()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 40 );
        level.players[ 0 ] cleardamageindicators();
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x434c3058, Offset: 0x25e6c
    // Size: 0x4f, Type: dev
    function function_f1610035fb9774f3()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 0 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 2, "<dev string:x3797>", 0, 100, 0, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xa358216, Offset: 0x25ec3
    // Size: 0x85, Type: dev
    function function_cb7029fa3cc81003()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37b9>", 0, 100, 30, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
        wait 1.95;
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 0, 400 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 0, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x4cb27616, Offset: 0x25f50
    // Size: 0x7f, Type: dev
    function function_33da32e8fcf7d2d()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x3797>", 0, 100, 0, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
        waitframe();
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37a7>", 0, 100, 0, 80 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xec4dac4f, Offset: 0x25fd7
    // Size: 0xbe, Type: dev
    function function_44cf073615163030()
    {
        level.players[ 0 ] function_7537b7737b866f75( 1, 0, "<dev string:x3797>", 0, 100, 0, 40 );
        level.players[ 0 ] function_7537b7737b866f75( 1, 0, "<dev string:x3797>", 0, 100, 0, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 1, 0, "<dev string:x3797>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 1, 0, "<dev string:x3797>", 0, 100, 0, 10 );
        level.players[ 0 ] function_a2b79feb4144b717();
        wait 1;
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37b9>", 0, 100, 30, 0 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xe50a5d78, Offset: 0x2609d
    // Size: 0x228, Type: dev
    function function_1c2bb1eec058b9fa()
    {
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 40 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 10 );
        level.players[ 0 ] function_a2b79feb4144b717();
        waitframe();
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 40 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 10 );
        level.players[ 0 ] function_a2b79feb4144b717();
        waitframe();
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 40 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 10 );
        level.players[ 0 ] function_a2b79feb4144b717();
        waitframe();
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 40 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 30 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 20 );
        level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 10 );
        level.players[ 0 ] function_a2b79feb4144b717();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x5ff3d7e4, Offset: 0x262cd
    // Size: 0xc1, Type: dev
    function function_33f9f1239636bd98()
    {
        level endon( #"hash_e69c7fee2cdc3479" );
        
        while ( true )
        {
            level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 40 );
            level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 30 );
            level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 20 );
            level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 10 );
            level.players[ 0 ] function_7537b7737b866f75( 0, 1, "<dev string:x37d7>", 0, 100, 0, 0 );
            level.players[ 0 ] function_a2b79feb4144b717();
            wait 2;
        }
    }

#/

// Namespace dev_mp
// Params 5
// Checksum 0xa9b827c6, Offset: 0x26396
// Size: 0xa1
function add_start( msg, setup_func, main_func, transient, catchup_function )
{
    add_start_assert();
    msg = tolower( msg );
    assert( !isstring( main_func ), "<dev string:x37e8>" );
    array = add_start_construct( msg, setup_func, main_func, transient, catchup_function );
    assert( isdefined( setup_func ), "<dev string:x3850>" );
    level.start_functions[ level.start_functions.size ] = array;
    level.start_arrays[ msg ] = array;
}

// Namespace dev_mp
// Params 0
// Checksum 0x20de98d0, Offset: 0x2643f
// Size: 0x30
function init_starts()
{
    utility::flag_init( "start_is_set" );
    
    /#
        if ( getdvarint( @"scr_enable_starts", 0 ) )
        {
            thread do_starts();
        }
        
        thread start_menu();
    #/
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x8126d683, Offset: 0x26477
    // Size: 0xc, Type: dev
    function do_starts()
    {
        thread handle_starts();
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x24619d40, Offset: 0x2648b
    // Size: 0x7b, Type: dev
    function start_menu()
    {
        for ( ;; )
        {
            if ( getdvarint( @"debug_start" ) )
            {
                setdevdvar( @"debug_start", 0 );
                level.debug.debug_start = 1;
                
                if ( isdefined( level.var_3f907696327a5b83 ) )
                {
                    [[ level.var_3f907696327a5b83 ]]();
                }
                else
                {
                    display_starts();
                }
                
                level.debug.debug_start = 0;
            }
            
            wait 0.05;
        }
    }

#/

// Namespace dev_mp
// Params 0
// Checksum 0xae6801c1, Offset: 0x2650e
// Size: 0x4a
function get_start_dvars()
{
    dvars = [];
    
    for ( i = 0; i < level.start_functions.size ; i++ )
    {
        dvars[ dvars.size ] = level.start_functions[ i ][ "name" ];
    }
    
    return dvars;
}

// Namespace dev_mp
// Params 0
// Checksum 0xb3400d02, Offset: 0x26561
// Size: 0x388
function display_starts()
{
    if ( level.start_functions.size <= 0 )
    {
        return;
    }
    
    dvars = get_start_dvars();
    dvars[ dvars.size ] = "cancel";
    host = gamelogic_mp::gethostplayer();
    host val::set( "display_starts", "allow_equipment_wheel", 0 );
    host val::set( "dev_starts", "damage", 0 );
    host freezecontrols( 1 );
    elems = start_list_menu();
    title = create_start( "Selected Start:", -1 );
    title.color = ( 1, 1, 1 );
    strings = [];
    
    for ( i = 0; i < dvars.size ; i++ )
    {
        dvar = dvars[ i ];
        start_string = "[" + dvars[ i ] + "]";
        strings[ strings.size ] = start_string;
    }
    
    selected = dvars.size - 1;
    up_pressed = 0;
    down_pressed = 0;
    found_current_start = 0;
    
    while ( selected > 0 )
    {
        if ( dvars[ selected ] == level.start_point )
        {
            found_current_start = 1;
            break;
        }
        
        selected--;
    }
    
    if ( !found_current_start )
    {
        selected = dvars.size - 1;
    }
    
    start_list_settext( elems, strings, selected );
    old_selected = selected;
    last_presstime = 0;
    
    for ( ;; )
    {
        host = gamelogic_mp::gethostplayer( 1 );
        
        if ( old_selected != selected )
        {
            start_list_settext( elems, strings, selected );
            old_selected = selected;
        }
        
        if ( gettime() - last_presstime > 150 )
        {
            up_pressed = 0;
            down_pressed = 0;
        }
        
        if ( !up_pressed )
        {
            if ( host buttonpressed( "UPARROW" ) || host buttonpressed( "DPAD_UP" ) || host buttonpressed( "APAD_UP" ) )
            {
                up_pressed = 1;
                last_presstime = gettime();
                selected--;
            }
        }
        else if ( !host buttonpressed( "UPARROW" ) && !host buttonpressed( "DPAD_UP" ) && !host buttonpressed( "APAD_UP" ) )
        {
            up_pressed = 0;
        }
        
        if ( !down_pressed )
        {
            if ( host buttonpressed( "DOWNARROW" ) || host buttonpressed( "DPAD_DOWN" ) || host buttonpressed( "APAD_DOWN" ) )
            {
                down_pressed = 1;
                last_presstime = gettime();
                selected++;
            }
        }
        else if ( !host buttonpressed( "DOWNARROW" ) && !host buttonpressed( "DPAD_DOWN" ) && !host buttonpressed( "APAD_DOWN" ) )
        {
            down_pressed = 0;
        }
        
        if ( selected < 0 )
        {
            selected = dvars.size - 1;
        }
        
        if ( selected >= dvars.size )
        {
            selected = 0;
        }
        
        if ( host buttonpressed( "BUTTON_B" ) || host buttonpressed( "escape" ) )
        {
            start_display_cleanup( elems, title );
            break;
        }
        
        if ( host buttonpressed( "kp_enter" ) || host buttonpressed( "BUTTON_A" ) || host buttonpressed( "enter" ) )
        {
            if ( dvars[ selected ] == "cancel" )
            {
                start_display_cleanup( elems, title );
                break;
            }
            
            setdvar( @"start", dvars[ selected ] );
            handle_starts();
            start_display_cleanup( elems, title );
            break;
        }
        
        wait 0.05;
    }
    
    host freezecontrols( 0 );
    host val::set( "dev_starts", "damage", 1 );
    host val::reset_all( "display_starts" );
}

// Namespace dev_mp
// Params 0
// Checksum 0x247fb953, Offset: 0x268f1
// Size: 0x48
function start_list_menu()
{
    hud_array = [];
    
    for ( i = 0; i < 11 ; i++ )
    {
        hud = create_start( "", i );
        hud_array[ hud_array.size ] = hud;
    }
    
    return hud_array;
}

// Namespace dev_mp
// Params 3
// Checksum 0x33f0b20, Offset: 0x26942
// Size: 0x77
function start_list_settext( hud_array, strings, num )
{
    for ( i = 0; i < hud_array.size ; i++ )
    {
        index = i + num - 5;
        
        if ( isdefined( strings[ index ] ) )
        {
            text = strings[ index ];
        }
        else
        {
            text = "";
        }
        
        /#
            hud_array[ i ] setdevtext( text );
        #/
    }
}

// Namespace dev_mp
// Params 2
// Checksum 0x8c6f6c8c, Offset: 0x269c1
// Size: 0x40
function start_display_cleanup( elems, title )
{
    title destroy();
    
    for ( i = 0; i < elems.size ; i++ )
    {
        elems[ i ] destroy();
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x5dded7ca, Offset: 0x26a09
// Size: 0x17a
function handle_starts()
{
    setdvarifuninitialized( @"start", "default" );
    
    if ( getdvarint( @"hash_7f5c464e214c560c", 0 ) != 0 )
    {
        return;
    }
    
    if ( !isdefined( level.start_functions ) )
    {
        level.start_functions = [];
    }
    
    assert( getdvar( @"jumpto", "<dev string:x2f4>" ) == "<dev string:x2f4>", "<dev string:x3894>" );
    level.start_point = tolower( getdvar( @"start", "default" ) );
    
    if ( level.start_point == "default" )
    {
        return;
    }
    
    dvars = get_start_dvars();
    utility::flag_set( "start_is_set" );
    start_array = level.start_arrays[ level.start_point ];
    
    if ( level.start_point == "default" )
    {
        if ( isdefined( level.default_start ) )
        {
            level thread [[ level.default_start ]]();
        }
    }
    else
    {
        start_array = level.start_arrays[ level.start_point ];
        
        /#
            thread indicate_start( level.start_point );
            thread indicate_start_always();
        #/
        
        thread [[ start_array[ "start_func" ] ]]();
    }
    
    if ( getdvarint( @"fpstool_run" ) )
    {
        setdvar( @"hash_46467383874e22fd", "" );
    }
    
    /#
        if ( getdvarint( @"scr_jumpstartpoints", 0 ) == 1 )
        {
            thread jumpstartpoints();
        }
    #/
}

// Namespace dev_mp
// Params 1
// Checksum 0x952617f5, Offset: 0x26b8b
// Size: 0x67
function get_string_for_starts( dvars )
{
    string = " ** No starts have been set up for this map with scriptsenginesputility::add_start().";
    
    if ( dvars.size )
    {
        string = " ** ";
        
        for ( i = dvars.size - 1; i >= 0 ; i-- )
        {
            string = string + dvars[ i ] + " ";
        }
    }
    
    setdvar( @"start", string );
    return string;
}

// Namespace dev_mp
// Params 2
// Checksum 0x290d45a4, Offset: 0x26bfb
// Size: 0x138
function create_start( start, index )
{
    alpha = 1;
    color = ( 0.9, 0.9, 0.9 );
    
    if ( index != -1 )
    {
        middle = 5;
        
        if ( index != middle )
        {
            alpha = 1 - abs( middle - index ) / middle;
        }
        else
        {
            color = ( 1, 1, 0 );
        }
    }
    
    if ( alpha == 0 )
    {
        alpha = 0.05;
    }
    
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 80;
    hudelem.y = 80 + index * 18;
    
    /#
        hudelem setdevtext( start );
    #/
    
    hudelem.alpha = 0;
    hudelem.foreground = 1;
    hudelem.color = color;
    hudelem.fontscale = 1.75;
    hudelem fadeovertime( 0.5 );
    hudelem.alpha = alpha;
    return hudelem;
}

// Namespace dev_mp
// Params 1
// Checksum 0x4002210a, Offset: 0x26d3c
// Size: 0xf3
function indicate_start( start )
{
    if ( level.var_275b63a4ee70c2a2 )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"loc_warningsaserrors" ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_7392d6caef3964a1" ) == 1 )
        {
            return;
        }
    #/
    
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 10;
    hudelem.y = 400;
    
    /#
        hudelem setdevtext( start );
    #/
    
    hudelem.alpha = 0;
    hudelem.fontscale = 3;
    wait 1;
    hudelem fadeovertime( 1 );
    hudelem.alpha = 1;
    wait 5;
    hudelem fadeovertime( 1 );
    hudelem.alpha = 0;
    wait 1;
    hudelem destroy();
}

// Namespace dev_mp
// Params 0
// Checksum 0xe3934d10, Offset: 0x26e37
// Size: 0x15f
function function_a88f3b3329ac35a0()
{
    self notify( #"hash_6d15732412c121f2" );
    self endon( #"hash_6d15732412c121f2" );
    
    /#
        host = devfindhost();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        level.var_bf3963e27160df2c = 1;
        debugcolor = ( 0.6, 0.6, 0.6 );
        healthcolor = ( 0.6, 0.6, 0.6 );
        var_d23a8a5d818795ec = ( 0.9, 0.1, 0.1 );
        var_940d801c5fa1367a = host.health;
        var_69fb200f96b676d7 = 0;
        
        while ( getdvarint( @"hash_f23e88e0327f5ea8", 0 ) == 1 )
        {
            if ( var_940d801c5fa1367a > host.health )
            {
                var_69fb200f96b676d7 = gettime();
            }
            
            var_48cfb7a4cdf941cd = gettime() - var_69fb200f96b676d7 < 420 ? ( gettime() - var_69fb200f96b676d7 ) / 420 : 1;
            healthcolor = vectorlerp( var_d23a8a5d818795ec, debugcolor, var_48cfb7a4cdf941cd );
            printtoscreen2d( 240, 60, "<dev string:x38b9>", debugcolor, 3 );
            printtoscreen2d( 240, 100, "<dev string:x38be>", debugcolor, 3 );
            printtoscreen2d( 420, 100, host.health, healthcolor, 3 );
            var_940d801c5fa1367a = host.health;
            waitframe();
        }
        
        level.var_bf3963e27160df2c = 0;
    #/
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x60be419d, Offset: 0x26f9e
    // Size: 0xf8, Type: dev
    function indicate_start_always()
    {
        if ( getdvarint( @"scr_show_start" ) == 0 )
        {
            return;
        }
        
        utility::flag_wait( "<dev string:x38c6>" );
        hudelem = newhudelem();
        hudelem.alignx = "<dev string:x38d3>";
        hudelem.aligny = "<dev string:x35fc>";
        hudelem.x = 10;
        hudelem.y = 10;
        hudelem setdevtext( level.start_point );
        hudelem.alpha = 0;
        hudelem.fontscale = 1;
        wait 1;
        hudelem fadeovertime( 0.25 );
        hudelem.alpha = 1;
        waitframe();
        
        for ( ;; )
        {
            level waittill( #"start_logic", start_point );
            
            if ( isdefined( start_point ) )
            {
                hudelem setdevtext( start_point );
            }
            else
            {
                hudelem setdevtext( "<dev string:x38d8>" );
            }
            
            wait 0.5;
        }
    }

#/

// Namespace dev_mp
// Params 5
// Checksum 0x24e0195b, Offset: 0x2709e
// Size: 0x71
function add_start_construct( msg, func, optional_func, transient, catchup_function )
{
    array = [];
    array[ "name" ] = msg;
    array[ "start_func" ] = func;
    array[ "logic_func" ] = optional_func;
    array[ "transient" ] = transient;
    array[ "catchup_function" ] = catchup_function;
    return array;
}

// Namespace dev_mp
// Params 0
// Checksum 0x26b73195, Offset: 0x27118
// Size: 0x18
function add_start_assert()
{
    if ( !isdefined( level.start_functions ) )
    {
        level.start_functions = [];
    }
}

// Namespace dev_mp
// Params 0
// Checksum 0x398a6858, Offset: 0x27138
// Size: 0xf, Type: bool
function level_has_start_points()
{
    return level.start_functions.size > 1;
}

/#

    // Namespace dev_mp
    // Params 0
    // Checksum 0x6424e696, Offset: 0x27150
    // Size: 0xe5, Type: dev
    function jumpstartpoints()
    {
        if ( level.start_arrays.size <= 1 )
        {
            return;
        }
        
        var_b838a2792018aaf4 = getdvarint( @"hash_12b44c14670814c", 15 );
        
        for ( ;; )
        {
            wait var_b838a2792018aaf4;
            spotindex = randomintrange( 0, level.start_arrays.size );
            
            foreach ( startstruct in level.start_arrays )
            {
                if ( spotindex == 0 )
                {
                    setdvar( @"start", startstruct[ "<dev string:x38f9>" ] );
                    break;
                }
                
                spotindex--;
            }
            
            map_restart();
        }
    }

    // Namespace dev_mp
    // Params 2
    // Checksum 0x2e53ca82, Offset: 0x2723d
    // Size: 0xe2, Type: dev
    function function_62fe1d0b2b006700( weaponref, expected )
    {
        player = gamelogic_mp::gethostplayer();
        class = "<dev string:x38fe>";
        struct = class::loadout_getclassstruct();
        var_4d5575c6f9ec8a5b = class::function_ad7e91d3dac61546();
        player class::loadout_updateclasscustom( struct, class, var_4d5575c6f9ec8a5b );
        struct.loadouttertiary = weaponref;
        var_25cd9baa4bdd20fd = validation::validateloadout( struct, class );
        success = struct.loadouttertiary == weaponref == expected;
        
        if ( success )
        {
            output = weaponref + "<dev string:x3906>";
            iprintlnbold( output );
            println( output );
            return;
        }
        
        output = weaponref + "<dev string:x390e>";
        iprintlnbold( output );
        println( output );
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0xee0bbc9b, Offset: 0x27327
    // Size: 0x145, Type: dev
    function function_5fe08f6630955070()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_a60cc0c5c920f578" ) != 0 )
            {
                var_26b579e696a89ea9 = loot::function_f54ecb89dfab8e8c( 50898 );
                function_62fe1d0b2b006700( var_26b579e696a89ea9, 0 );
                wait 0.5;
                var_bd219428a7cf0be9 = loot::function_f54ecb89dfab8e8c( 87545 );
                function_62fe1d0b2b006700( var_bd219428a7cf0be9, 0 );
                wait 0.5;
                tonfaref = loot::function_f54ecb89dfab8e8c( 25653 );
                function_62fe1d0b2b006700( tonfaref, 1 );
                wait 0.5;
                var_8525346d971036c4 = loot::function_f54ecb89dfab8e8c( 54601 );
                function_62fe1d0b2b006700( var_8525346d971036c4, 1 );
                wait 0.5;
                var_49f764ac17ffc49a = loot::function_f54ecb89dfab8e8c( 54033 );
                function_62fe1d0b2b006700( var_49f764ac17ffc49a, 1 );
                wait 0.5;
                kniferef = loot::function_f54ecb89dfab8e8c( 17750 );
                function_62fe1d0b2b006700( kniferef, 1 );
                
                for ( i = 0; i <= 4 ; i++ )
                {
                    wait 0.5;
                    var_1601d477ff2ae923 = loot::function_f54ecb89dfab8e8c( 89433 + i );
                    function_62fe1d0b2b006700( var_1601d477ff2ae923, 1 );
                }
                
                setdvar( @"hash_a60cc0c5c920f578", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace dev_mp
    // Params 1
    // Checksum 0x9a1b5381, Offset: 0x27474
    // Size: 0x1e, Type: dev
    function onspawnplayer( params )
    {
        if ( isbot( self ) )
        {
            function_fd796c9b565cf954();
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xbc347463, Offset: 0x2749a
    // Size: 0x2e, Type: dev
    function private function_fd796c9b565cf954()
    {
        bot = self;
        
        if ( getdvarint( @"hash_a5819da0d89256cc", 0 ) > 0 )
        {
            bot thread function_b725b45481d9a09b();
        }
    }

    // Namespace dev_mp
    // Params 1, eflags: 0x4
    // Checksum 0x5dfbde39, Offset: 0x274d0
    // Size: 0x88, Type: dev
    function private function_754685afacf5258e( other )
    {
        if ( level.teambased )
        {
            if ( isdefined( other.team ) && isdefined( self.team ) )
            {
                return ( other.team != self.team );
            }
            else
            {
                assertmsg( "<dev string:x3916>" );
                return 1;
            }
            
            return;
        }
        
        if ( isdefined( other.owner ) )
        {
            return ( other.owner != self );
        }
        
        return other != self;
    }

    // Namespace dev_mp
    // Params 1, eflags: 0x4
    // Checksum 0x1faa463b, Offset: 0x27560
    // Size: 0xa8, Type: dev
    function private function_1ca9dfab6a917530( player )
    {
        bot = self;
        delta = 60;
        mindistance = 50;
        
        if ( distance2d( bot.origin, player.origin ) > mindistance )
        {
            return 0;
        }
        
        botforward = anglestoforward( bot getplayerangles( 0 ) );
        var_c58c76eb6950c25f = vectornormalize( player.origin - bot.origin );
        var_c615e020c2daf69e = math::anglebetweenvectorsunit( botforward, var_c58c76eb6950c25f );
        return var_c615e020c2daf69e <= delta;
    }

    // Namespace dev_mp
    // Params 0, eflags: 0xc
    // Checksum 0xd2b0dbdc, Offset: 0x27610
    // Size: 0x14a, Type: dev
    function private function_b725b45481d9a09b()
    {
        self notify( #"hash_c22a41725711cbf4" );
        self endon( #"hash_c22a41725711cbf4" );
        bot = self;
        bot endon( #"death_or_disconnect" );
        
        while ( getdvarint( @"hash_a5819da0d89256cc" ) > 0 )
        {
            wait 1;
            
            foreach ( player in level.players )
            {
                if ( player == bot )
                {
                    continue;
                }
                
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                if ( !bot function_754685afacf5258e( player ) )
                {
                    continue;
                }
                
                if ( bot function_1ca9dfab6a917530( player ) )
                {
                    executionattempts = 0;
                    bot enableexecutionattack();
                    
                    while ( !bot isinexecutionattack() && executionattempts < 2 )
                    {
                        bot botpressbutton( "<dev string:x1140>", 2 );
                        executionattempts++;
                        wait 2.1;
                    }
                    
                    if ( executionattempts < 2 )
                    {
                        while ( bot isinexecutionattack() )
                        {
                            waitframe();
                        }
                    }
                    
                    break;
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x6ab7a68d, Offset: 0x27762
    // Size: 0xfa, Type: dev
    function private function_4e68244837c125a0()
    {
        splashtokens = strtok( getdvar( @"scr_show_splash_param" ), "<dev string:x356>" );
        
        if ( splashtokens.size > 1 )
        {
            splashref = splashtokens[ 0 ];
            param = int( splashtokens[ 1 ] );
            splashlistoverride = undefined;
            
            if ( splashtokens.size > 2 )
            {
                splashlistoverride = splashtokens[ 2 ];
            }
            
            foreach ( player in level.players )
            {
                player thread hud_message::showsplash( splashref, param, undefined, undefined, undefined, splashlistoverride );
            }
        }
        
        setdevdvar( @"scr_show_splash_param", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x47cba190, Offset: 0x27864
    // Size: 0xd0, Type: dev
    function private function_713051940fe05138()
    {
        splashref = getdvar( @"scr_show_splash_global", "<dev string:x2f4>" );
        splashtokens = strtok( splashref, "<dev string:x356>" );
        optionalparam = 1;
        
        if ( splashtokens.size > 1 )
        {
            splashref = splashtokens[ 0 ];
            optionalparam = int( splashtokens[ 1 ] );
        }
        
        if ( level.players.size > 0 )
        {
            owner = level.players[ 0 ];
            
            if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
            {
                level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashref, owner, undefined, optionalparam );
            }
        }
        
        setdevdvar( @"scr_show_splash_global", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0x365a7363, Offset: 0x2793c
    // Size: 0xa6, Type: dev
    function private function_2ae6b494e811ca5d()
    {
        killstreakref = getdvar( @"scr_show_splash_killstreak", "<dev string:x2f4>" );
        splashref = "<dev string:x3954>" + killstreakref;
        
        if ( level.players.size > 0 )
        {
            owner = level.players[ 0 ];
            
            if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
            {
                level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( splashref, owner );
            }
        }
        
        setdevdvar( @"scr_show_splash_killstreak", "<dev string:x2f4>" );
    }

    // Namespace dev_mp
    // Params 1, eflags: 0x4
    // Checksum 0xd10c26f1, Offset: 0x279ea
    // Size: 0x3e, Type: dev
    function private function_a7f3a0ccbd057d86( splashtype )
    {
        switch ( splashtype )
        {
            case #"hash_b216c9cbf6b56ed0":
                function_231c571359c854ae();
                break;
            default:
                break;
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xc21801df, Offset: 0x27a30
    // Size: 0x4d, Type: dev
    function private function_231c571359c854ae()
    {
        if ( level.players.size > 0 )
        {
            attacker = level.players[ 0 ];
            attacker setclientomnvar( "<dev string:x3961>", attacker getentitynumber() );
            attacker setclientomnvar( "<dev string:x3972>", gettime() );
        }
    }

    // Namespace dev_mp
    // Params 0
    // Checksum 0x994f61fa, Offset: 0x27a85
    // Size: 0x188, Type: dev
    function function_7b2f09c6d0ed8a49()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        var_127d6f6b052347fc = undefined;
        
        while ( true )
        {
            waitframe();
            debugactive = getdvarint( @"hash_25fb98b53bc71bdf" ) > 0;
            
            if ( var_127d6f6b052347fc != debugactive )
            {
                var_127d6f6b052347fc = debugactive;
                
                if ( debugactive )
                {
                    foreach ( player in level.players )
                    {
                        if ( !player ishost() )
                        {
                            continue;
                        }
                        
                        if ( !player isscriptable() )
                        {
                            continue;
                        }
                        
                        player setscriptablepartstate( "<dev string:x398a>", "<dev string:x399c>", 0 );
                    }
                    
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    if ( !player ishost() )
                    {
                        continue;
                    }
                    
                    if ( !player isscriptable() )
                    {
                        continue;
                    }
                    
                    player setscriptablepartstate( "<dev string:x398a>", "<dev string:x8d7>", 0 );
                }
            }
        }
    }

    // Namespace dev_mp
    // Params 0, eflags: 0x4
    // Checksum 0xff497c37, Offset: 0x27c15
    // Size: 0x30, Type: dev
    function private function_1d3457f338a90852()
    {
        while ( true )
        {
            while ( getdvarint( @"hash_e5e94b23fad41f89", 0 ) == 1 )
            {
                removeallcorpses();
                wait 5;
            }
            
            waitframe();
        }
    }

#/
