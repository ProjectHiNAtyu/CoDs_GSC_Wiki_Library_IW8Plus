// scripts\mp\zm\systems\zm_round_spawning.gsc  (hash_4e3b2b1d9542e66b.gscc) (size: 65455 Bytes / 0xffaf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41bd3c99 (1102920857)
// size ...... 65455 (0xffaf)
// includes .. 23  (offset: 0xf2ab)
// strings ... 147 (offset: 0xf363)
// dev strs .. 71  (offset: 0xfc4f)
// exports ... 117 (offset: 0xbc13)
// cseg ...... 0xe8e + 0xad85 (0xbc13)
// imports ... 274 (offset: 0xce5b)
// animtree1 . 0   (offset: 0xffaf)
// animtree2 . 0   (offset: 0xffaf)
#using script_16ea1b94f0f381b3;
#using script_4bf223434bdc0646;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\status_effects;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\overlord;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_round_spawning;

// Namespace zm_round_spawning
// Params 0
// Checksum 0xdb64abf6, Offset: 0xeac
// Size: 0x378
function init_zm_round_spawning()
{
    if ( !isdefined( level.var_918358ca7e641ab2 ) )
    {
        level.var_918358ca7e641ab2 = &function_a7a5164e5196f1b7;
    }
    
    utility::flag_init( "zm_round_spawning_init_data_done" );
    var_5c736a1de5435dc2 = spawnstruct();
    var_5c736a1de5435dc2.var_f374ba2d1651228a = 1;
    var_5c736a1de5435dc2.var_35b424aba022d253 = 0;
    var_5c736a1de5435dc2.movespeedmultiplier = 4;
    var_5c736a1de5435dc2.movespeedoffset = 35;
    var_5c736a1de5435dc2.spawningzombies = 0;
    var_5c736a1de5435dc2.spawningpaused = 0;
    var_5c736a1de5435dc2.spawningcompleted = 0;
    var_5c736a1de5435dc2.isspecialround = 0;
    var_5c736a1de5435dc2.var_a07b129aac45da61 = 0;
    var_5c736a1de5435dc2.var_939db9ccafac43a7 = [];
    var_5c736a1de5435dc2.var_324c4d9ffb7372af = [];
    var_5c736a1de5435dc2.var_b730d8849849a3b2 = [];
    var_5c736a1de5435dc2.var_5c8829ccd69f3862 = 0;
    var_5c736a1de5435dc2.var_bb3be8e0341ae1eb = [];
    var_5c736a1de5435dc2.specialroundspawns = [];
    var_5c736a1de5435dc2.var_6204b965e4b41b56 = [];
    var_5c736a1de5435dc2.var_ffd1e6c992abef73 = [];
    var_5c736a1de5435dc2.var_90e1d244c1410109 = [];
    var_5c736a1de5435dc2.var_883bfe37c0fd93a3 = [];
    var_5c736a1de5435dc2.state = 0;
    level.var_d24e66b3dd54be4a = [ 1:"zombie_methone", 0:"zombie_hellhound" ];
    level.var_a009ab14ee0d3223 = var_5c736a1de5435dc2;
    level.var_7b337816c6b398df = &function_dea06a34aeea707d;
    level.var_d294be5cdc3a6077 = &function_dc38a7b6d572496f;
    level.var_768953ff5aba4257 = &function_350ae5b344b92adb;
    level.var_276a6abf9e419a7a = &function_eac31e771f56391a;
    level.var_c078bdf00f887d4b = &function_731e9691bd12b58f;
    utility::flag_wait_or_timeout( "round_spawning_bundle_set", 0.1 );
    var_8593f17418a81b6e = "zmroundspawning:zm_t10_base_round_spawning";
    
    if ( isdefined( level.var_fc24bbdd34d2b120 ) )
    {
        var_8593f17418a81b6e = level.var_fc24bbdd34d2b120;
    }
    
    if ( isdefined( level.var_edd2cdda7ab7ec0 ) )
    {
        var_8593f17418a81b6e = level.var_edd2cdda7ab7ec0;
    }
    
    thread function_8e3fb9cafdfec49c( var_8593f17418a81b6e );
    
    if ( getdvarint( @"zm_round_spawning_enabled", 1 ) > 0 )
    {
        level thread zm_round_spawning_thread();
        
        if ( !level callback::exists( "on_zombie_ai_killed", &function_1451667b00ffb21d ) )
        {
            level callback::add( "on_zombie_ai_killed", &function_1451667b00ffb21d );
        }
        
        level callback::add( "on_turned", &function_b2cd1d9c564cbf6e );
        level callback::add( "cleaned_up_zombie_spawn_fail", &function_1451667b00ffb21d );
        level callback::add( "round_spawning_completed", &function_1451667b00ffb21d );
        level callback::add( "on_brainrot_end", &on_brainrot_end );
    }
    
    level.round_spawn_speed_up_throttle = throttle::throttle_initialize( "round_spawn_speed_up", 2, 1 );
    level.var_148e14aa588539af = &function_dd4b8070d89e62c;
    level thread function_bf27d914a0d9ae6c();
    init_spawn_sound();
    zm_quest::function_3c363613c60958f5( "special_round_is_ongoing" );
    level callback::add( "on_round_end_immediate", &function_10c4a4c11287a05f );
    level callback::add( "special_round_end", &function_6d2c9b588c36f472 );
    level utility::thread_on_notify( "game_ended", &function_e203a9f62c731ba4, level, undefined, undefined, 1, 1 );
    utility::registersharedfunc( #"zombie", #"get_round_enemies", &get_round_enemies );
    utility::registersharedfunc( #"zombie", #"hash_55b419086029b9a2", &function_4564514496724003 );
    utility::registersharedfunc( #"zombie", #"hash_c9776044d2711c07", &function_17c7b9075fa1b886 );
    level function_eeded9fbedf5c06();
    
    /#
        level thread function_cedaa81b5fa233c6();
    #/
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xf272799a, Offset: 0x122c
// Size: 0x1785
function function_8e3fb9cafdfec49c( var_8593f17418a81b6e )
{
    utility::flag_wait( "build_ai_spawn_list_completed" );
    spawnbundle = getscriptbundle( var_8593f17418a81b6e );
    level.var_a009ab14ee0d3223.scriptbundle = spawnbundle;
    level.var_a009ab14ee0d3223.var_63a0ca44b877a390 = spawnbundle.var_c52a3963fd08b5d ?? 40;
    level.var_a009ab14ee0d3223.var_d685b0049c84326 = spawnbundle.var_4ddf16922d664613 ?? 0;
    level.var_a009ab14ee0d3223.var_f374ba2d1651228a = spawnbundle.var_f374ba2d1651228a ?? 1;
    level.var_a009ab14ee0d3223.var_35b424aba022d253 = spawnbundle.var_35b424aba022d253 ?? 36;
    level.var_a009ab14ee0d3223.var_31ae08b3ccc1f184 = spawnbundle.var_31ae08b3ccc1f184 ?? 750;
    level.var_a009ab14ee0d3223.movespeedmultiplier = spawnbundle.movespeedmultiplier ?? 4;
    level.var_a009ab14ee0d3223.movespeedoffset = spawnbundle.movespeedoffset ?? 35;
    level.var_a009ab14ee0d3223.supersprintinground = spawnbundle.supersprintinground ?? 40;
    level.var_a009ab14ee0d3223.var_21c97e4bd76e8702 = spawnbundle.var_21c97e4bd76e8702 ?? 5;
    level.var_a009ab14ee0d3223.var_3756709e67f5764a = spawnbundle.var_3756709e67f5764a ?? 5;
    level.var_a009ab14ee0d3223.var_5f62e94a2cd0a294 = spawnbundle.var_5f62e94a2cd0a294 ?? 95;
    level.var_a009ab14ee0d3223.var_7b8339d2f66a3028 = spawnbundle.var_7b8339d2f66a3028 ?? 29;
    level.var_a009ab14ee0d3223.var_5c020d5f56ef385e = spawnbundle.var_5c020d5f56ef385e ?? 20;
    level.var_a009ab14ee0d3223.linearscalarsolo = spawnbundle.linearscalarsolo ?? 0.84;
    level.var_a009ab14ee0d3223.linearscalarcoop = spawnbundle.linearscalarcoop ?? 0.6;
    level.var_a009ab14ee0d3223.exponentialscalar = spawnbundle.exponentialscalar ?? 0.13;
    level.var_a009ab14ee0d3223.var_9c1c9413c30befe7 = spawnbundle.var_9c1c9413c30befe7 ?? 0.5;
    level.var_a009ab14ee0d3223.var_6e44161797bcde4f = spawnbundle.var_6e44161797bcde4f ?? 0.02;
    level.var_a009ab14ee0d3223.var_6e3f901797b7c1c6 = spawnbundle.var_6e3f901797b7c1c6 ?? 0.03;
    level.var_a009ab14ee0d3223.var_56c41c4cbf72797a = spawnbundle.var_56c41c4cbf72797a ?? 0.04;
    level.var_a009ab14ee0d3223.var_6b273737afad7ed8 = spawnbundle.var_6b273737afad7ed8 ?? 0.02;
    level.var_a009ab14ee0d3223.var_6b2bbd37afb29b61 = spawnbundle.var_6b2bbd37afb29b61 ?? 0.03;
    level.var_a009ab14ee0d3223.var_ce0744f85c599e51 = spawnbundle.var_ce0744f85c599e51 ?? 0.04;
    level.var_a009ab14ee0d3223.var_c1b73934fd01a8bc = spawnbundle.var_c1b73934fd01a8bc ?? 1;
    level.var_a009ab14ee0d3223.var_c1bbbf34fd06c545 = spawnbundle.var_c1bbbf34fd06c545 ?? 2;
    level.var_a009ab14ee0d3223.var_dc585216a6550055 = spawnbundle.var_dc585216a6550055 ?? 3;
    level.var_a009ab14ee0d3223.var_2338e137586872c8 = spawnbundle.var_2338e137586872c8 ?? "random";
    level.var_a009ab14ee0d3223.var_da24f5c6bb59b76a = spawnbundle.var_da24f5c6bb59b76a ?? 4;
    level.var_a009ab14ee0d3223.var_d41ffa914f85b3a9 = spawnbundle.var_d41ffa914f85b3a9 ?? 3;
    level.var_a009ab14ee0d3223.var_b722e49071b9f6a5 = spawnbundle.var_b722e49071b9f6a5 ?? [];
    level.var_a009ab14ee0d3223.var_75817f97ecc62f4 = [];
    level.var_a009ab14ee0d3223.var_7fc3ad8b9bf70745 = spawnbundle.var_7fc3ad8b9bf70745 ?? 3;
    level.var_a009ab14ee0d3223.var_939663239fc36ad7 = spawnbundle.var_939663239fc36ad7 ?? 2;
    level.var_a009ab14ee0d3223.var_1d3cc9f3d6d385f1 = spawnbundle.var_1d3cc9f3d6d385f1 ?? 4;
    level.var_a009ab14ee0d3223.var_f0837b0d2f437d8c = spawnbundle.var_f0837b0d2f437d8c ?? 1;
    level.var_a009ab14ee0d3223.var_52fa3e9e5452fa07 = spawnbundle.var_52fa3e9e5452fa07 ?? 1;
    level.var_a009ab14ee0d3223.var_7d528d7f9174e9b9 = spawnbundle.var_7d528d7f9174e9b9 ?? 2;
    level.var_a009ab14ee0d3223.var_8a52ae780775b8b6 = spawnbundle.var_8a52ae780775b8b6 ?? 1;
    level.var_a009ab14ee0d3223.var_5b675df965b7d73c = spawnbundle.var_5b675df965b7d73c ?? 2;
    level.var_a009ab14ee0d3223.var_c68b71210be2bac1 = spawnbundle.var_c68b71210be2bac1 ?? 3;
    level.var_a009ab14ee0d3223.var_69a7030275dd9c9c = spawnbundle.var_69a7030275dd9c9c ?? 1;
    level.var_a009ab14ee0d3223.var_bda668de764a73ed = spawnbundle.var_bda668de764a73ed ?? 2;
    level.var_a009ab14ee0d3223.var_dd86aa356951f6bc = spawnbundle.var_dd86aa356951f6bc ?? 3;
    level.var_a009ab14ee0d3223.var_f0fd654a9847809b = spawnbundle.var_f0fd654a9847809b ?? 50;
    level.var_a009ab14ee0d3223.var_f82d7f279e97e0a9 = spawnbundle.var_91ac59b5022eb039 ?? "vfx_t10_gameplay_zm_camera_special_round";
    level.var_a009ab14ee0d3223.var_3d268311dd73c56a = spawnbundle.var_e91c8c1e62f24b02 ?? "vfx_t10_gameplay_zm_weapons_evil_special_round_vignette_cam";
    level.var_a009ab14ee0d3223.var_f29e38a084754468 = spawnbundle.var_f29e38a084754468;
    level.var_a009ab14ee0d3223.var_114c9b76cfe55d9f = spawnbundle.var_114c9b76cfe55d9f;
    level.var_a009ab14ee0d3223.var_9d824eca78ebddd3 = spawnbundle.var_9d824eca78ebddd3;
    level.var_a009ab14ee0d3223.var_f7f2dbe985a94d6c = spawnbundle.var_f7f2dbe985a94d6c;
    level.var_a009ab14ee0d3223.var_b8da3410be0d1a98 = spawnbundle.var_b8da3410be0d1a98;
    level.var_a009ab14ee0d3223.var_619922d9754be68f = spawnbundle.var_619922d9754be68f;
    level.var_a009ab14ee0d3223.var_78e3846a682aea5d = spawnbundle.var_78e3846a682aea5d;
    level.var_a009ab14ee0d3223.var_cba01f8be7e5e23f = spawnbundle.var_cba01f8be7e5e23f;
    level.var_a009ab14ee0d3223.var_1e7b50c32bd133a8 = spawnbundle.var_1e7b50c32bd133a8;
    level.var_a009ab14ee0d3223.var_216f16495abb4f8c = spawnbundle.var_216f16495abb4f8c;
    level.var_a009ab14ee0d3223.var_ca2d151211f80bb3 = spawnbundle.var_ca2d151211f80bb3;
    level.var_a009ab14ee0d3223.var_430ba35a3bc0f32f = spawnbundle.var_430ba35a3bc0f32f;
    level.var_a009ab14ee0d3223.var_8e2837ddb910d098 = spawnbundle.var_8e2837ddb910d098;
    level.var_a009ab14ee0d3223.var_4ff30f95c0ba091a = spawnbundle.var_4ff30f95c0ba091a;
    level.var_a009ab14ee0d3223.var_e5670225d7f8427e = spawnbundle.var_e5670225d7f8427e;
    level.var_a009ab14ee0d3223.var_b1df0e3eb9f9195 = spawnbundle.var_b1df0e3eb9f9195;
    level.var_a009ab14ee0d3223.var_a235cd2304d50585 = spawnbundle.var_a235cd2304d50585;
    level.var_a009ab14ee0d3223.var_f59dfe5a495ba8ce = spawnbundle.var_f59dfe5a495ba8ce;
    level.var_a009ab14ee0d3223.var_d4e8685c18b8d96e = spawnbundle.var_d4e8685c18b8d96e;
    level.var_a009ab14ee0d3223.var_85f2b3d8972dde85 = spawnbundle.var_85f2b3d8972dde85;
    level.var_a009ab14ee0d3223.var_7bc571f9a514040b = spawnbundle.var_7bc571f9a514040b;
    level.var_a009ab14ee0d3223.var_57097f98d640b515 = spawnbundle.var_57097f98d640b515;
    level.var_a009ab14ee0d3223.var_37cefcc28a37369e = spawnbundle.var_37cefcc28a37369e;
    level.var_a009ab14ee0d3223.var_b34b2c4efbd534ee = spawnbundle.var_b34b2c4efbd534ee;
    level.var_a009ab14ee0d3223.var_645577cb7a4a3a05 = spawnbundle.var_645577cb7a4a3a05;
    level.var_a009ab14ee0d3223.var_c3d3093021b8aa05 = spawnbundle.var_c3d3093021b8aa05;
    level.var_a009ab14ee0d3223.var_173b3a67663f4d4e = spawnbundle.var_173b3a67663f4d4e;
    level.var_a009ab14ee0d3223.var_2d3c6157e712e2b0 = spawnbundle.var_2d3c6157e712e2b0;
    level.var_a009ab14ee0d3223.var_a3329f530fbfad0b = [];
    
    if ( isdefined( spawnbundle.roundspawn_list ) )
    {
        foreach ( i, v in spawnbundle.roundspawn_list )
        {
            var_5890629931d8a04b = spawnstruct();
            var_5890629931d8a04b.ailist = v.baselist;
            var_5890629931d8a04b.exclusionlist = v.exclusionlist;
            var_5890629931d8a04b.var_1d9f0e28b53d4873 = v.var_1d9f0e28b53d4873;
            var_5890629931d8a04b.roundcount = v.roundcount;
            var_5890629931d8a04b.var_a42625720c9305fb = v.var_a42625720c9305fb;
            var_5890629931d8a04b.var_a4221f720c8f02f2 = v.var_a4221f720c8f02f2;
            var_5890629931d8a04b.var_a42f31720c9d3f0d = v.var_a42f31720c9d3f0d;
            var_5890629931d8a04b.roundname = v.var_fd610723c6c7e23c;
            var_5890629931d8a04b.normaldroplist = v.normaldroplist;
            var_5890629931d8a04b.specialdroplist = v.specialdroplist;
            var_5890629931d8a04b.elitedroplist = v.elitedroplist;
            var_5890629931d8a04b.lightarmordroplist = v.lightarmordroplist;
            var_5890629931d8a04b.heavyarmordroplist = v.heavyarmordroplist;
            var_5890629931d8a04b.roundnumber = v.roundnumber;
            roundindex = v.roundnumber;
            level.var_a009ab14ee0d3223.var_bb3be8e0341ae1eb[ roundindex ] = var_5890629931d8a04b;
            spawnlist = level.var_a009ab14ee0d3223.var_bb3be8e0341ae1eb[ roundindex ].ailist;
            namespace_c7157c2cd884c5d5::function_8506004ffbf27011( spawnlist );
            
            foreach ( aisubclass in namespace_c7157c2cd884c5d5::function_e0abfec4a095a04b( spawnlist ) )
            {
                if ( !isdefined( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] ) || level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] > roundindex )
                {
                    level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] = roundindex;
                }
            }
        }
    }
    else
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( isdefined( spawnbundle.var_f3d9d5522b89c6e2 ) )
    {
        level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9 = [];
        level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f = [];
        level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b = [];
        level.var_a009ab14ee0d3223.var_4fcb67d418d85735 = [];
        level.var_a009ab14ee0d3223.var_63798bb76ae9e64d = [];
        level.var_a009ab14ee0d3223.var_9d379c095fb6dce7 = [];
        level.var_a009ab14ee0d3223.var_d66e7149a8db73cb = [];
        level.var_a009ab14ee0d3223.var_9ae086885e903c0c = [];
        
        foreach ( mixedentry in spawnbundle.var_f3d9d5522b89c6e2 )
        {
            mixedentry.var_528de2fdf1c1a9d9 = 0;
            mixedentry.var_bed174c26f31d8c7 = 0;
            
            if ( mixedentry.var_aec029c0c07f2f6e != 0 )
            {
                level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ mixedentry.var_aec029c0c07f2f6e ] = mixedentry;
            }
            
            if ( mixedentry.var_7817982d154020ab == "normal" )
            {
                level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ mixedentry.var_aec029c0c07f2f6e ].index = level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9.size;
                level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9[ level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9.size ] = mixedentry;
            }
            else if ( mixedentry.var_7817982d154020ab == "special" )
            {
                level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ mixedentry.var_aec029c0c07f2f6e ].index = level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f.size;
                level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f[ level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f.size ] = mixedentry;
            }
            else if ( mixedentry.var_7817982d154020ab == "elite" )
            {
                level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ mixedentry.var_aec029c0c07f2f6e ].index = level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b.size;
                level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b.size ] = mixedentry;
            }
            
            if ( isdefined( mixedentry.var_1024b930aa2cc8a2 ) && mixedentry.var_aec029c0c07f2f6e != 0 )
            {
                namespace_c7157c2cd884c5d5::function_8506004ffbf27011( mixedentry.var_1024b930aa2cc8a2 );
                
                foreach ( aisubclass in namespace_c7157c2cd884c5d5::function_e0abfec4a095a04b( mixedentry.var_1024b930aa2cc8a2 ) )
                {
                    if ( !isdefined( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] ) || level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] > mixedentry.var_aec029c0c07f2f6e )
                    {
                        level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] = mixedentry.var_aec029c0c07f2f6e;
                    }
                }
            }
        }
    }
    
    if ( isdefined( spawnbundle.specialroundspawn_list ) )
    {
        foreach ( i, v in spawnbundle.specialroundspawn_list )
        {
            var_3d627a128994605e = 0;
            
            foreach ( aispawnstruct in v.specialaitype_list )
            {
                if ( namespace_c7157c2cd884c5d5::function_f566149de5039773( aispawnstruct.aispawntype ) )
                {
                    var_3d627a128994605e = 1;
                    break;
                }
            }
            
            if ( !var_3d627a128994605e )
            {
                continue;
            }
            
            specialroundinfo = spawnstruct();
            setdvarifuninitialized( @"hash_a3d8279ebfa85341", 1 );
            
            if ( getdvarint( @"hash_a3d8279ebfa85341", 1 ) == 1 )
            {
                var_64aa85763ee17d1 = v.var_56ce8489fb2cb6bb;
                var_53b9f2b28e0ba0e7 = v.var_2e583fefcad48069 + 1;
                specialroundinfo.specialroundname = v.specialroundname;
                beginround = randomintrange( var_64aa85763ee17d1, var_53b9f2b28e0ba0e7 );
                
                if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] ) )
                {
                    while ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] ) )
                    {
                        beginround++;
                    }
                }
                
                level.var_a009ab14ee0d3223.var_90e1d244c1410109[ v.specialroundname ] = 0;
                specialroundinfo.ailist = v.specialaitype_list;
                specialroundinfo.var_e28b1bf3be5e30f2 = v.var_e28b1bf3be5e30f2;
                specialroundinfo.var_e26825f3be37ff38 = v.var_e26825f3be37ff38;
                specialroundinfo.var_16f342b397743f5 = v.var_16f342b397743f5;
                specialroundinfo.var_1921e2b399d5b4b = v.var_1921e2b399d5b4b;
                specialroundinfo.specialroundtier = v.specialroundtier;
                specialroundinfo.specialroundname = v.specialroundname;
                specialroundinfo.var_562e39c780ef0fa4 = v.var_562e39c780ef0fa4;
                specialroundinfo.var_21ac207e2908c5c8 = v.var_21ac207e2908c5c8;
                specialroundinfo.var_4306ca79c64fad3b = v.var_4306ca79c64fad3b;
                specialroundinfo.var_42f9b879c6417120 = v.var_42f9b879c6417120;
                specialroundinfo.var_42fdbe79c6457429 = v.var_42fdbe79c6457429;
                specialroundinfo.var_4313bc79c65da2f6 = v.var_4313bc79c65da2f6;
                specialroundinfo.var_52bfbe9e13deb4c7 = v.var_52bfbe9e13deb4c7;
                specialroundinfo.var_1fb01024d9a5c081 = v.var_1fb01024d9a5c081;
                specialroundinfo.var_eec8f2844cac48b5 = v.var_eec8f2844cac48b5;
                specialroundinfo.var_10d082d4638b156b = v.var_10d082d4638b156b;
                specialroundinfo.var_9bb7dd09100f8ce2 = v.var_9bb7dd09100f8ce2;
                specialroundinfo.roundendrewardlist = v.roundendrewardlist;
                specialroundinfo.var_4d1f1b9df63feffd = v.var_4d1f1b9df63feffd;
                specialroundinfo.var_ae9d8d6388f2543a = v.var_ae9d8d6388f2543a;
                specialroundinfo.var_2c5d5fd47e6e5f28 = v.var_2c5d5fd47e6e5f28;
                specialroundinfo.var_29c2ee2eb254f8d5 = v.var_29c2ee2eb254f8d5;
                specialroundinfo.var_1ad671e17b49ed4f = v.var_1ad671e17b49ed4f;
                specialroundinfo.var_1ad16be17b43b746 = v.var_1ad16be17b43b746;
                specialroundinfo.var_1abb6de17b2b8879 = v.var_1abb6de17b2b8879;
                specialroundinfo.var_c77a2bb3ee36c2c9 = v.var_c77a2bb3ee36c2c9;
                specialroundinfo.var_47a8be5d3ffd24a = v.var_47a8be5d3ffd24a;
                level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] = specialroundinfo;
                
                if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ beginround ].ailist ) )
                {
                    foreach ( aispawnstruct in level.var_a009ab14ee0d3223.specialroundspawns[ beginround ].ailist )
                    {
                        namespace_c7157c2cd884c5d5::function_8506004ffbf27011( aispawnstruct.aispawntype );
                        
                        foreach ( aisubclass in namespace_c7157c2cd884c5d5::function_e0abfec4a095a04b( aispawnstruct.aispawntype ) )
                        {
                            if ( !isdefined( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] ) || level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] > beginround )
                            {
                                level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] = beginround;
                            }
                        }
                    }
                }
                
                if ( isdefined( v.specialroundflag ) && v.specialroundflag != "" )
                {
                    level thread function_13a446e22d50b1cb( beginround, v.specialroundflag, v.var_662409d4125fff1a );
                }
            }
        }
    }
    
    utility::flag_set( "zm_round_spawning_init_data_done" );
}

// Namespace zm_round_spawning
// Params 3, eflags: 0x4
// Checksum 0xeffe413b, Offset: 0x29b9
// Size: 0xa5
function private function_13a446e22d50b1cb( var_8fe0489a2c1edb76, specialroundflag, var_662409d4125fff1a )
{
    level endon( #"special_round_start" );
    level utility::flag_wait( specialroundflag );
    var_7b2f043d0c4d749 = zm_utility::get_round_number() + var_662409d4125fff1a;
    level.var_a009ab14ee0d3223.specialroundspawns[ var_7b2f043d0c4d749 ] = level.var_a009ab14ee0d3223.specialroundspawns[ var_8fe0489a2c1edb76 ];
    level.var_a009ab14ee0d3223.specialroundspawns[ var_8fe0489a2c1edb76 ] = undefined;
    level callback::callback( "special_round_scheduled", { #roundnumber:var_7b2f043d0c4d749 } );
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x21c3ee3b, Offset: 0x2a66
// Size: 0x95
function function_9fd9e12523021d1d( currentspecialround, newspecialround )
{
    assert( isint( currentspecialround ) && isint( newspecialround ), "<dev string:x3b>" );
    
    if ( currentspecialround != newspecialround )
    {
        level.var_a009ab14ee0d3223.specialroundspawns[ newspecialround ] = level.var_a009ab14ee0d3223.specialroundspawns[ currentspecialround ];
        level.var_a009ab14ee0d3223.specialroundspawns[ currentspecialround ] = undefined;
        level callback::callback( "special_round_scheduled", { #roundnumber:newspecialround } );
    }
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xf4d0efa, Offset: 0x2b03
// Size: 0x44
function function_8ef68e03bec37f85( roundname, var_a94c34f0be1497c6 )
{
    assert( isdefined( level.var_a009ab14ee0d3223 ), "<dev string:x8b>" );
    level.var_a009ab14ee0d3223.var_883bfe37c0fd93a3[ roundname ] = var_a94c34f0be1497c6;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xfd37069e, Offset: 0x2b4f
// Size: 0x887
function zm_round_spawning_thread()
{
    level endon( #"game_ended" );
    level callback::callback( "round_spawning_setup" );
    waitframe();
    utility::flag_wait( "subclass_to_aitype_map_initialized" );
    level thread [[ level.var_918358ca7e641ab2 ]]();
    
    while ( true )
    {
        switch ( level.var_a009ab14ee0d3223.state )
        {
            case 0:
                level.var_a009ab14ee0d3223 waittill( #"spawn" );
                roundnumber = zm_round_logic::get_rb_round_number();
                var_e9299b1c9798e152 = function_ad358cbb8158789e( roundnumber );
                level.var_a009ab14ee0d3223.var_8037eb378dce03e4 = randomintrange( level.var_a009ab14ee0d3223.var_52fa3e9e5452fa07, level.var_a009ab14ee0d3223.var_7d528d7f9174e9b9 + 1 );
                level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 = var_e9299b1c9798e152;
                level.var_a009ab14ee0d3223.var_a07b129aac45da61 = 0;
                level zm_cleanup_manager::function_227af94975b8071f();
                params = spawnstruct();
                params.roundnumber = roundnumber;
                function_58c1db68b1b5a98a();
                function_4e7bfd2c87a20b72();
                
                if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
                {
                    level.var_a009ab14ee0d3223.isspecialround = 1;
                    specialroundname = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].specialroundname ?? "special_round";
                    params.specialroundname = specialroundname;
                    params.isspecialround = 1;
                    
                    if ( isdefined( level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ] ) )
                    {
                        var_8c9f25be7256357d = roundnumber + 1;
                        
                        if ( !isdefined( level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ var_8c9f25be7256357d ] ) )
                        {
                            level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ var_8c9f25be7256357d ] = level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ];
                            level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ] = undefined;
                        }
                        else
                        {
                            while ( isdefined( level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ var_8c9f25be7256357d ] ) )
                            {
                                var_8c9f25be7256357d++;
                            }
                            
                            level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ var_8c9f25be7256357d ] = level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ];
                            level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ] = undefined;
                        }
                    }
                    
                    round_struct = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
                    params.roundendrewardlist = round_struct.roundendrewardlist;
                    callback::callback( "special_round_start", params );
                    level notify( #"special_round_start" );
                    level zm_cleanup_manager::function_e675dc1c82f6b58e();
                    wait 7;
                }
                else
                {
                    level.var_a009ab14ee0d3223.isspecialround = 0;
                    params.isspecialround = 0;
                }
                
                function_7c08fdc922a2cf9( 1 );
                level.var_a009ab14ee0d3223.state = 1;
                level.var_a009ab14ee0d3223.spawningcompleted = 0;
                callback::callback( "on_round_ai_spawn_started", params );
                break;
            case 1:
                /#
                    if ( getdvarint( @"zm_round_spawning_pause", 0 ) )
                    {
                        level.var_a009ab14ee0d3223.spawningpaused = 1;
                    }
                #/
                
                if ( !level.var_a009ab14ee0d3223.spawningpaused )
                {
                    function_9464570ccdf080fd();
                    
                    if ( level.var_a009ab14ee0d3223.var_a07b129aac45da61 )
                    {
                        zombies = getaiarray( zm_utility::get_zombie_team() );
                        
                        foreach ( zombie in zombies )
                        {
                            zombie zombie_emergence_spawning::function_80623a2279a4d888();
                        }
                        
                        level.var_a009ab14ee0d3223.var_a07b129aac45da61 = 0;
                    }
                    
                    if ( level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size >= level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 && !level.var_a009ab14ee0d3223.spawningcompleted )
                    {
                        level.var_a009ab14ee0d3223.spawningcompleted = 1;
                        callback::callback( "round_spawning_completed" );
                    }
                    
                    if ( zm_cleanup_manager::get_pending_respawn_count() > 0 )
                    {
                        wait 0.1;
                    }
                    else if ( !has_round_spawning_completed() )
                    {
                        roundnumber = zm_round_logic::get_rb_round_number();
                        specialroundstruct = undefined;
                        
                        if ( level.var_a009ab14ee0d3223.isspecialround )
                        {
                            specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
                        }
                        
                        spawndelay = undefined;
                        
                        if ( isdefined( level.override_zombie_spawn_delay ) )
                        {
                            spawndelay = [[ level.override_zombie_spawn_delay ]]( roundnumber, specialroundstruct );
                        }
                        
                        if ( !isdefined( spawndelay ) )
                        {
                            spawndelay = function_5f35aa2e209190da( roundnumber, specialroundstruct );
                        }
                        
                        if ( spawndelay > 0 )
                        {
                            wait spawndelay;
                        }
                        else
                        {
                            waitframe();
                        }
                    }
                }
                
                break;
            case 2:
                roundnumber = zm_round_logic::get_rb_round_number();
                
                if ( level.var_a009ab14ee0d3223.isspecialround )
                {
                    specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
                    
                    if ( isdefined( specialroundstruct.ailist ) )
                    {
                        foreach ( index, var_181e7f68891eaadf in specialroundstruct.ailist )
                        {
                            level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist[ index ].bhasspawned = 0;
                        }
                    }
                    
                    numplayers = level.players.size;
                    
                    if ( isdefined( specialroundstruct.specialroundname ) )
                    {
                        specialroundname = specialroundstruct.specialroundname;
                        paramsstruct = spawnstruct();
                        level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundname ]++;
                        
                        if ( specialroundstruct.var_e28b1bf3be5e30f2 != 0 && specialroundstruct.var_e26825f3be37ff38 != 0 )
                        {
                            var_8c9f25be7256357d = 0;
                            
                            if ( numplayers > 1 )
                            {
                                var_8c9f25be7256357d = randomintrange( specialroundstruct.var_16f342b397743f5, specialroundstruct.var_1921e2b399d5b4b + 1 );
                                var_8c9f25be7256357d = roundnumber + var_8c9f25be7256357d;
                            }
                            else
                            {
                                var_8c9f25be7256357d = randomintrange( specialroundstruct.var_e28b1bf3be5e30f2, specialroundstruct.var_e26825f3be37ff38 + 1 );
                                var_8c9f25be7256357d = roundnumber + var_8c9f25be7256357d;
                            }
                            
                            paramsstruct = specialroundstruct;
                            schedule_special_round( var_8c9f25be7256357d, paramsstruct );
                        }
                        
                        params = spawnstruct();
                        params.specialroundname = specialroundname;
                        callback::callback( "special_round_end", params );
                        level notify( #"special_round_end" );
                    }
                    
                    level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] = undefined;
                }
                
                function_4d3da95ccef4d3b4();
                level.var_a009ab14ee0d3223.var_4fcb67d418d85735 = [];
                level.var_a009ab14ee0d3223.var_63798bb76ae9e64d = [];
                level.var_a009ab14ee0d3223.var_9d379c095fb6dce7 = [];
                level.var_a009ab14ee0d3223.var_d66e7149a8db73cb = [];
                
                /#
                    if ( isdefined( level.var_dc917abcf5b8f749 ) )
                    {
                        function_72b3db5fc2b7d929( level.var_dc917abcf5b8f749 );
                    }
                #/
                
                level.var_a009ab14ee0d3223.var_939db9ccafac43a7 = [];
                level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = [];
                level.var_a009ab14ee0d3223.var_324c4d9ffb7372af = [];
                level.var_6781718da4f78d1c notify( #"round_cleared" );
                level.var_a009ab14ee0d3223 waittill( #"reset" );
                level.var_a009ab14ee0d3223.state = 0;
                break;
        }
        
        waitframe();
    }
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x9e9d8d23, Offset: 0x33de
// Size: 0x17e
function get_special_round_count( roundnumber, percent_override )
{
    specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
    var_f533b0f2f2cfcec9 = 1;
    var_62e02beede8dde07 = 0;
    
    if ( isdefined( level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundstruct.specialroundname ] ) )
    {
        var_62e02beede8dde07 = level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundstruct.specialroundname ];
    }
    
    multiplier = 8;
    
    if ( var_62e02beede8dde07 <= 1 )
    {
        multiplier = specialroundstruct.var_562e39c780ef0fa4;
    }
    else
    {
        multiplier = specialroundstruct.var_21ac207e2908c5c8;
    }
    
    numplayers = level.players.size;
    
    switch ( numplayers )
    {
        case 1:
            specialroundincrease = specialroundstruct.var_4306ca79c64fad3b;
            break;
        case 2:
            specialroundincrease = specialroundstruct.var_42f9b879c6417120;
            break;
        case 3:
            specialroundincrease = specialroundstruct.var_42fdbe79c6457429;
            break;
        default:
            specialroundincrease = specialroundstruct.var_4313bc79c65da2f6;
            break;
    }
    
    specialroundmultiplier = var_62e02beede8dde07 * specialroundincrease;
    var_f533b0f2f2cfcec9 = numplayers * multiplier + specialroundmultiplier;
    
    if ( var_f533b0f2f2cfcec9 < 1 )
    {
        var_f533b0f2f2cfcec9 = 1;
    }
    
    return var_f533b0f2f2cfcec9;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x9584df27, Offset: 0x3565
// Size: 0x63c
function function_4e7bfd2c87a20b72()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    var_e9299b1c9798e152 = function_ad358cbb8158789e( roundnumber );
    var_f533b0f2f2cfcec9 = 9999;
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        var_f533b0f2f2cfcec9 = get_special_round_count( roundnumber );
        var_e9299b1c9798e152 = get_special_round_count( roundnumber );
    }
    else
    {
        var_f533b0f2f2cfcec9 = function_678c569a34fbb6b9();
    }
    
    countspawn = 0;
    introcount = int( var_e9299b1c9798e152 * 0.06 );
    outrocount = int( var_e9299b1c9798e152 * 0.1 );
    var_3a00d85efe17851 = var_e9299b1c9798e152 - introcount + outrocount;
    
    if ( var_3a00d85efe17851 < 0 )
    {
        var_3a00d85efe17851 = 0;
    }
    
    var_4db5bb9c61bf4186 = int( var_3a00d85efe17851 * 0.21 );
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] = -1;
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] = -1;
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] = -1;
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] = -1;
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] = -1;
    level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 5 ] = -1;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 0 ] = 0;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 1 ] = 0;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 2 ] = 0;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 3 ] = 0;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 4 ] = 0;
    level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ 5 ] = 0;
    
    while ( countspawn < var_e9299b1c9798e152 )
    {
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] == -1 && countspawn >= int( var_e9299b1c9798e152 * 0.06 ) )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] = countspawn;
        }
        
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] == -1 && level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] >= 0 && countspawn >= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] + var_4db5bb9c61bf4186 )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] = countspawn;
        }
        
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] == -1 && level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] >= 0 && countspawn >= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] + var_4db5bb9c61bf4186 )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] = countspawn;
        }
        
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] == -1 && level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] >= 0 && countspawn >= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] + var_4db5bb9c61bf4186 )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] = countspawn;
        }
        
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] == -1 && level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] >= 0 && countspawn >= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] + var_4db5bb9c61bf4186 )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] = countspawn;
        }
        
        if ( level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 5 ] == -1 && level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] >= 0 && countspawn >= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] + var_4db5bb9c61bf4186 )
        {
            level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 5 ] = countspawn;
        }
        
        countspawn++;
    }
    
    var_e1594581b6d512d2 = level.var_a009ab14ee0d3223.var_2338e137586872c8;
    
    if ( var_e1594581b6d512d2 == "random" )
    {
        var_e1594581b6d512d2 = function_dfb7e940a514a581();
    }
    
    level.var_a009ab14ee0d3223.pointsleft = var_f533b0f2f2cfcec9;
    
    switch ( var_e1594581b6d512d2 )
    {
        case #"hash_c195d40415e89d91":
            function_c93cfc141ecce204( var_f533b0f2f2cfcec9, [ 0, 0.25, 0.25, 0.25, 0.25, 0 ] );
            break;
        case #"hash_8a3db0d873451574":
            function_c93cfc141ecce204( var_f533b0f2f2cfcec9, [ 0, 0.7, 0.1, 0.1, 0.1, 0 ] );
            break;
        case #"hash_81ed0cf4153bfd02":
            function_c93cfc141ecce204( var_f533b0f2f2cfcec9, [ 0, 0.1, 0.1, 0.1, 0.7, 0 ] );
            break;
        case #"hash_edf0fffe18cc8c34":
            function_c93cfc141ecce204( var_f533b0f2f2cfcec9, [ 0, 0.15, 0.35, 0.35, 0.15, 0 ] );
            break;
        case #"hash_5ee4a87134af6b56":
        default:
            function_c93cfc141ecce204( var_f533b0f2f2cfcec9, [ 0, 0.35, 0.15, 0.15, 0.35, 0 ] );
            break;
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x3e5faab7, Offset: 0x3ba9
// Size: 0x9d
function function_dfb7e940a514a581()
{
    nchoice = randomint( 5 );
    choice = "even";
    
    switch ( nchoice )
    {
        case 0:
            choice = "even";
            break;
        case 1:
            choice = "frontload";
            break;
        case 2:
            choice = "endload";
            break;
        case 3:
            choice = "middleload";
            break;
        case 4:
            choice = "frontandend";
            break;
    }
    
    return choice;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xc147cf44, Offset: 0x3c4f
// Size: 0x182
function function_c93cfc141ecce204( var_f2fa8559414915d8, percentage_array )
{
    /#
        total_percentage = 0;
        
        foreach ( percentage in percentage_array )
        {
            total_percentage += percentage;
        }
        
        assert( abs( total_percentage - 1 ) < 0.01, "<dev string:xce>" );
        assert( percentage_array.size == 6 );
    #/
    
    excess_count = 0;
    
    for ( quarter_i = 0; quarter_i < percentage_array.size ; quarter_i++ )
    {
        percentage = percentage_array[ quarter_i ];
        count = int( var_f2fa8559414915d8 * percentage );
        
        if ( count != var_f2fa8559414915d8 * percentage )
        {
            excess_count += 1;
            var_f2fa8559414915d8 -= 1;
        }
        
        level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ quarter_i ] = count;
    }
    
    while ( excess_count > 0 )
    {
        for ( quarter_i = 1; quarter_i <= 4 && excess_count > 0 ; quarter_i++ )
        {
            level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ quarter_i ] += 1;
            excess_count -= 1;
        }
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xc16a1a8a, Offset: 0x3dd9
// Size: 0xaa
function function_d2c908e7f62ac5dc()
{
    var_f032ae6bea6d620a = get_quarter();
    last_quarter = var_f032ae6bea6d620a - 1;
    
    if ( last_quarter > 0 && var_f032ae6bea6d620a < 5 )
    {
        if ( level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ last_quarter ] > 0 )
        {
            level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ var_f032ae6bea6d620a ] += level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ last_quarter ];
            level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ last_quarter ] = 0;
        }
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xfa678c6d, Offset: 0x3e8b
// Size: 0x15c
function get_quarter()
{
    var_c36ad45e737d0eb0 = level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size;
    
    if ( var_c36ad45e737d0eb0 <= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] )
    {
        return 0;
    }
    
    if ( var_c36ad45e737d0eb0 > level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 0 ] && var_c36ad45e737d0eb0 <= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] )
    {
        return 1;
    }
    
    if ( var_c36ad45e737d0eb0 > level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 1 ] && var_c36ad45e737d0eb0 <= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] )
    {
        return 2;
    }
    
    if ( var_c36ad45e737d0eb0 > level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 2 ] && var_c36ad45e737d0eb0 <= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] )
    {
        return 3;
    }
    
    if ( var_c36ad45e737d0eb0 > level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 3 ] && var_c36ad45e737d0eb0 <= level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] )
    {
        return 4;
    }
    
    if ( var_c36ad45e737d0eb0 > level.var_a009ab14ee0d3223.var_6204b965e4b41b56[ 4 ] )
    {
        return 5;
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x69daed84, Offset: 0x3fef
// Size: 0x2ea
function function_34fc35b31cc5777a( movespeed )
{
    self endon( #"death" );
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( roundnumber > level.var_a009ab14ee0d3223.var_da24f5c6bb59b76a )
    {
        return;
    }
    
    if ( !function_ef4f01ab7c2806e0( self ) )
    {
        return;
    }
    
    allflagsclear = 1;
    
    if ( isdefined( level.var_a009ab14ee0d3223.var_b722e49071b9f6a5 ) )
    {
        foreach ( var_eb7dab7f687c82ed in level.var_a009ab14ee0d3223.var_b722e49071b9f6a5 )
        {
            orcleared = 0;
            
            foreach ( var_d242237d938acceb in var_eb7dab7f687c82ed.doorflags )
            {
                if ( isdefined( var_d242237d938acceb.doorflagname ) )
                {
                    if ( level utility::flag( var_d242237d938acceb.doorflagname ) )
                    {
                        orcleared = 1;
                    }
                }
            }
            
            if ( !orcleared )
            {
                allflagsclear = 0;
            }
        }
        
        if ( !allflagsclear )
        {
            return;
        }
    }
    
    while ( isalive( self ) )
    {
        var_acd1e2d96c16a444 = 1;
        
        foreach ( player in level.players )
        {
            var_92068fefcb32dde = distance2dsquared( player.origin, self.origin );
            
            if ( var_92068fefcb32dde <= level.var_a009ab14ee0d3223.var_31ae08b3ccc1f184 * level.var_a009ab14ee0d3223.var_31ae08b3ccc1f184 )
            {
                var_acd1e2d96c16a444 = 0;
                break;
            }
        }
        
        if ( var_acd1e2d96c16a444 )
        {
            if ( isstring( movespeed ) )
            {
                movespeed = zm_utility::function_1588b24fa1d03f3b( movespeed );
            }
            
            if ( movespeed < level.var_a009ab14ee0d3223.var_35b424aba022d253 )
            {
                movespeed = level.var_a009ab14ee0d3223.var_35b424aba022d253;
                movespeed = zm_utility::function_3aa660fdfe227adb( movespeed );
                zombie_utils::function_a8ce00e0448cb6f0( movespeed, "speedup", 4 );
                return;
            }
        }
        
        throttle::throttle_wait_in_queue( level.round_spawn_speed_up_throttle, self );
    }
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x8acbce2f, Offset: 0x42e1
// Size: 0xae
function set_spawned_zombies_move_speed( zombie, priority )
{
    if ( !function_ef4f01ab7c2806e0( zombie ) )
    {
        return;
    }
    
    movespeed = function_6211dbc10409aa10();
    
    if ( movespeed == "super_sprint" && ( zombie.subclass == "zombie_base_armored_light" || zombie.subclass == "zombie_base_armored_heavy" || zombie.subclass == "zombie_base_armored_agni" ) )
    {
        movespeed = "sprint";
    }
    
    zombie.round_spawning_move_speed = movespeed;
    zombie zombie_utils::function_a8ce00e0448cb6f0( movespeed, "zm_round_spawning", priority );
    zombie thread function_34fc35b31cc5777a( movespeed );
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x744f92b9, Offset: 0x4397
// Size: 0xa1
function function_6d2ff2952b39d0d7( fromtype, totype )
{
    if ( !isdefined( level.var_a009ab14ee0d3223.var_5972f94205c7fe96 ) )
    {
        level.var_a009ab14ee0d3223.var_5972f94205c7fe96 = [];
    }
    
    if ( !isdefined( level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ] ) )
    {
        level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ] = [];
    }
    
    level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ][ level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ].size ] = totype;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x65b55ea6, Offset: 0x4440
// Size: 0x3b
function function_5dbb675c70d96223( fromtype )
{
    if ( level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ] )
    {
        level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ fromtype ] = undefined;
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x36f6a614, Offset: 0x4483
// Size: 0xa6, Type: bool
function private function_ef4f01ab7c2806e0( zombie )
{
    if ( isdefined( zombie ) && ( zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "hvt" ) )
    {
        return false;
    }
    
    if ( zombie.var_de67cb8723283501 )
    {
        return false;
    }
    
    if ( zombie.subclass == "zombie_base_luna" )
    {
        return false;
    }
    
    if ( zombie.subclass == "zombie_hellhound" || zombie.subclass == "zombie_methone" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x58ac33cd, Offset: 0x4532
// Size: 0x67
function private get_ai_category( aitype )
{
    subclass = level.var_a706785ff83cb223[ aitype ];
    
    if ( isdefined( level.var_d85265655f6db38a[ aitype ] ) )
    {
        return level.var_d85265655f6db38a[ aitype ];
    }
    
    if ( isdefined( subclass ) && isdefined( level.var_d85265655f6db38a[ subclass ] ) )
    {
        return level.var_d85265655f6db38a[ subclass ];
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xab899455, Offset: 0x45a1
// Size: 0x48e
function function_9464570ccdf080fd()
{
    free_count = getfreeagentcount();
    
    if ( free_count == 0 )
    {
        /#
            iprintln( "<dev string:x117>" + get_round_enemies().size + "<dev string:x14e>" + level.var_a009ab14ee0d3223.var_63a0ca44b877a390 );
        #/
        
        return;
    }
    
    roundnumber = zm_round_logic::get_rb_round_number();
    var_64a6b24ca8582470 = 0;
    zombies = get_round_enemies();
    
    if ( zombies.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
    {
        return;
    }
    
    if ( zombies.size >= level.var_d61fcb760217368 )
    {
        return;
    }
    
    zombie = zm_cleanup_manager::function_d1dc6feeb14c0420();
    
    if ( isdefined( zombie ) )
    {
        if ( isdefined( level.var_3c6a4eee7184de4e ) )
        {
            zombie thread [[ level.var_3c6a4eee7184de4e ]]();
        }
        else
        {
            set_spawned_zombies_move_speed( zombie, 2 );
        }
        
        zombie thread function_3ac3ea659894a1a7( roundnumber );
        return;
    }
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        var_64a6b24ca8582470 = 1;
        function_afbd7bd60c9f8ea5( var_64a6b24ca8582470 );
    }
    else
    {
        zombie = function_afbd7bd60c9f8ea5( var_64a6b24ca8582470 );
        
        if ( isdefined( zombie ) && level.var_26b0e4fd32e52842 )
        {
            var_64a6b24ca8582470 = 1;
        }
    }
    
    if ( !var_64a6b24ca8582470 )
    {
        if ( level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size < level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 )
        {
            var_b8419a4ddf0383ef = function_4ed4fdc352e66c9( roundnumber );
            aitype = function_89b373d5f044b7c5();
            
            if ( !isdefined( aitype ) )
            {
                return;
            }
            
            var_462f6aba113cd52c = 0;
            
            if ( isdefined( var_b8419a4ddf0383ef.exclusionlist ) )
            {
                foreach ( exclude in var_b8419a4ddf0383ef.exclusionlist )
                {
                    if ( aitype == exclude.aitype )
                    {
                        var_462f6aba113cd52c = 1;
                    }
                }
            }
            
            if ( get_ai_category( aitype ) == "special" )
            {
                var_41ad1fe468915a91 = function_8ec904484436a94b();
                specials_alive = 0;
                
                foreach ( zombie in level.var_a009ab14ee0d3223.var_b730d8849849a3b2 )
                {
                    if ( isalive( zombie ) && zombie.aicategory == "special" )
                    {
                        specials_alive++;
                    }
                }
                
                if ( specials_alive >= var_41ad1fe468915a91 )
                {
                    aitype = "zombie_base";
                }
            }
            
            if ( !var_462f6aba113cd52c )
            {
                zombie = function_de48159d01090b97( aitype );
                
                if ( zombie.aicategory == "special" )
                {
                    level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = arraycombineunique( level.var_a009ab14ee0d3223.var_b730d8849849a3b2, [ zombie ] );
                    zombiestruct = spawnstruct();
                    zombiestruct.subclass = zombie.subclass;
                    level.var_a009ab14ee0d3223.var_9d379c095fb6dce7 = arraycombineunique( level.var_a009ab14ee0d3223.var_9d379c095fb6dce7, [ zombiestruct ] );
                }
                else if ( zombie.aicategory == "elite" )
                {
                    level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = arraycombineunique( level.var_a009ab14ee0d3223.var_b730d8849849a3b2, [ zombie ] );
                    zombiestruct = spawnstruct();
                    zombiestruct.subclass = zombie.subclass;
                    level.var_a009ab14ee0d3223.var_d66e7149a8db73cb = arraycombineunique( level.var_a009ab14ee0d3223.var_d66e7149a8db73cb, [ zombiestruct ] );
                }
                
                if ( isdefined( zombie ) )
                {
                    if ( isdefined( level.var_3c6a4eee7184de4e ) )
                    {
                        zombie thread [[ level.var_3c6a4eee7184de4e ]]();
                    }
                    else
                    {
                        set_spawned_zombies_move_speed( zombie, 1 );
                    }
                    
                    zombie thread function_3ac3ea659894a1a7( roundnumber );
                    record_zombie_spawn( zombie );
                    zombie.spawn_source = "zm_round_spawning";
                }
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xe0882496, Offset: 0x4a37
// Size: 0xc7
function function_70d1a99dd6bc4905()
{
    foreach ( special in level.var_a009ab14ee0d3223.var_b730d8849849a3b2 )
    {
        if ( !isalive( special ) )
        {
            level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = arrayremove( level.var_a009ab14ee0d3223.var_b730d8849849a3b2, special );
        }
    }
    
    return level.var_a009ab14ee0d3223.var_b730d8849849a3b2.size;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x4041b9fc, Offset: 0x4b07
// Size: 0x36, Type: bool
function private function_8c69d9f0f6d77a68( entry )
{
    if ( !isdefined( entry.var_77bdde44b63bf08a ) )
    {
        return true;
    }
    
    if ( entry.var_77bdde44b63bf08a > gettime() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xdd3f004c, Offset: 0x4b46
// Size: 0x55
function private function_29ebf04c404a5dd6( entry )
{
    assert( function_8c69d9f0f6d77a68( entry ), "<dev string:x156>" );
    
    if ( isdefined( entry.var_99a9647da52d4989 ) )
    {
        entry.var_77bdde44b63bf08a = gettime() + utility::function_4b74c15943231980( entry.var_99a9647da52d4989 );
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x45eb3df0, Offset: 0x4ba3
// Size: 0x1b1
function private function_486c40aa4be63f2f( index )
{
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    roundnumber = zm_round_logic::get_rb_round_number();
    eliteentry = level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ];
    var_aec029c0c07f2f6e = eliteentry.var_aec029c0c07f2f6e;
    
    if ( roundnumber < var_aec029c0c07f2f6e )
    {
        return 0;
    }
    
    if ( eliteentry.var_bed174c26f31d8c7 != 0 && roundnumber < eliteentry.var_bed174c26f31d8c7 )
    {
        return 0;
    }
    
    numplayers = level.players.size;
    var_99820c5cb4e96aec = 1;
    
    if ( numplayers > 1 )
    {
        if ( eliteentry.var_528de2fdf1c1a9d9 <= level.var_a009ab14ee0d3223.var_939663239fc36ad7 )
        {
            var_99820c5cb4e96aec = level.var_a009ab14ee0d3223.var_8a52ae780775b8b6;
        }
        else if ( eliteentry.var_528de2fdf1c1a9d9 <= level.var_a009ab14ee0d3223.var_1d3cc9f3d6d385f1 && eliteentry.var_528de2fdf1c1a9d9 > level.var_a009ab14ee0d3223.var_939663239fc36ad7 )
        {
            var_99820c5cb4e96aec = level.var_a009ab14ee0d3223.var_5b675df965b7d73c;
        }
        else
        {
            var_99820c5cb4e96aec = level.var_a009ab14ee0d3223.var_c68b71210be2bac1;
        }
    }
    else if ( eliteentry.var_528de2fdf1c1a9d9 < level.var_a009ab14ee0d3223.var_7fc3ad8b9bf70745 )
    {
        var_99820c5cb4e96aec = level.var_a009ab14ee0d3223.var_f0837b0d2f437d8c;
    }
    else
    {
        var_99820c5cb4e96aec = level.var_a009ab14ee0d3223.var_8037eb378dce03e4;
    }
    
    return var_99820c5cb4e96aec;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x7c4a70dc, Offset: 0x4d5d
// Size: 0x136
function function_5103e4508a4b84c0( index, entry )
{
    max_count = function_486c40aa4be63f2f( index );
    elite_count = level.var_a009ab14ee0d3223.var_d66e7149a8db73cb.size;
    
    foreach ( var_d0c6b7fe2f128d03 in level.var_f4f8c9a351eaab32.var_e722b24f3444e929 )
    {
        if ( get_ai_category( var_d0c6b7fe2f128d03.aitype ) == "elite" )
        {
            elite_count++;
        }
    }
    
    if ( elite_count >= max_count )
    {
        return 0;
    }
    
    if ( !isdefined( entry ) )
    {
        entry = level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ];
    }
    
    if ( !function_8c69d9f0f6d77a68( entry ) )
    {
        return 0;
    }
    
    if ( level.var_609a4c84665ec35 )
    {
        var_a8009fd4d58a1dd5 = [[ level.var_609a4c84665ec35 ]]();
        return var_a8009fd4d58a1dd5;
    }
    
    return 1;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xa063ea2c, Offset: 0x4e9c
// Size: 0x109
function private function_1c5e342854430bc3( index )
{
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    roundnumber = zm_round_logic::get_rb_round_number();
    specialentry = level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f[ index ];
    var_aec029c0c07f2f6e = specialentry.var_aec029c0c07f2f6e;
    
    if ( roundnumber < var_aec029c0c07f2f6e )
    {
        return 0;
    }
    
    maxspecial = 0;
    var_e9299b1c9798e152 = function_ad358cbb8158789e( roundnumber );
    percentage = 0;
    
    if ( roundnumber < 20 )
    {
        percentage = level.var_a009ab14ee0d3223.var_6b273737afad7ed8;
    }
    else if ( roundnumber >= 20 && roundnumber < 30 )
    {
        percentage = level.var_a009ab14ee0d3223.var_6b2bbd37afb29b61;
    }
    else if ( roundnumber >= 30 )
    {
        percentage = level.var_a009ab14ee0d3223.var_ce0744f85c599e51;
    }
    
    maxspecial = int( var_e9299b1c9798e152 * percentage );
    maxspecial = max( maxspecial, 1 );
    return maxspecial;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x9c0c9cd1, Offset: 0x4fae
// Size: 0x573
function function_8ec904484436a94b()
{
    if ( getdvarint( @"hash_3c05d1d16d772c9e", -1 ) >= 0 )
    {
        return getdvarint( @"hash_3c05d1d16d772c9e", -1 );
    }
    
    roundnumber = zm_round_logic::get_rb_round_number();
    numplayers = level.players.size;
    
    if ( numplayers == 1 )
    {
        if ( roundnumber < level.var_a009ab14ee0d3223.var_f29e38a084754468 )
        {
            return ( level.var_a009ab14ee0d3223.var_114c9b76cfe55d9f ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_f29e38a084754468 && roundnumber < level.var_a009ab14ee0d3223.var_9d824eca78ebddd3 )
        {
            return ( level.var_a009ab14ee0d3223.var_114c9b76cfe55d9f ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_9d824eca78ebddd3 && roundnumber < level.var_a009ab14ee0d3223.var_b8da3410be0d1a98 )
        {
            return ( level.var_a009ab14ee0d3223.var_f7f2dbe985a94d6c ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_b8da3410be0d1a98 && roundnumber < level.var_a009ab14ee0d3223.var_78e3846a682aea5d )
        {
            return ( level.var_a009ab14ee0d3223.var_619922d9754be68f ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_78e3846a682aea5d )
        {
            return 9999;
        }
    }
    else if ( numplayers == 2 )
    {
        if ( roundnumber < level.var_a009ab14ee0d3223.var_cba01f8be7e5e23f )
        {
            return ( level.var_a009ab14ee0d3223.var_1e7b50c32bd133a8 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_cba01f8be7e5e23f && roundnumber < level.var_a009ab14ee0d3223.var_216f16495abb4f8c )
        {
            return ( level.var_a009ab14ee0d3223.var_1e7b50c32bd133a8 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_216f16495abb4f8c && roundnumber < level.var_a009ab14ee0d3223.var_430ba35a3bc0f32f )
        {
            return ( level.var_a009ab14ee0d3223.var_ca2d151211f80bb3 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_430ba35a3bc0f32f && roundnumber < level.var_a009ab14ee0d3223.var_4ff30f95c0ba091a )
        {
            return ( level.var_a009ab14ee0d3223.var_8e2837ddb910d098 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_4ff30f95c0ba091a )
        {
            return 9999;
        }
    }
    else if ( numplayers == 3 )
    {
        if ( roundnumber < level.var_a009ab14ee0d3223.var_e5670225d7f8427e )
        {
            return ( level.var_a009ab14ee0d3223.var_b1df0e3eb9f9195 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_e5670225d7f8427e && roundnumber < level.var_a009ab14ee0d3223.var_a235cd2304d50585 )
        {
            return ( level.var_a009ab14ee0d3223.var_b1df0e3eb9f9195 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_849a85995cefa0a9 && roundnumber < level.var_a009ab14ee0d3223.var_d4e8685c18b8d96e )
        {
            return ( level.var_a009ab14ee0d3223.var_f59dfe5a495ba8ce ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_d4e8685c18b8d96e && roundnumber < level.var_a009ab14ee0d3223.var_7bc571f9a514040b )
        {
            return ( level.var_a009ab14ee0d3223.var_85f2b3d8972dde85 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_7bc571f9a514040b )
        {
            return 9999;
        }
    }
    else if ( numplayers >= 4 )
    {
        if ( roundnumber < level.var_a009ab14ee0d3223.var_57097f98d640b515 )
        {
            return ( level.var_a009ab14ee0d3223.var_37cefcc28a37369e ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_57097f98d640b515 && roundnumber < level.var_a009ab14ee0d3223.var_b34b2c4efbd534ee )
        {
            return ( level.var_a009ab14ee0d3223.var_37cefcc28a37369e ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_849a85995cefa0a9 && roundnumber < level.var_a009ab14ee0d3223.var_c3d3093021b8aa05 )
        {
            return ( level.var_a009ab14ee0d3223.var_645577cb7a4a3a05 ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_c3d3093021b8aa05 && roundnumber < level.var_a009ab14ee0d3223.var_2d3c6157e712e2b0 )
        {
            return ( level.var_a009ab14ee0d3223.var_173b3a67663f4d4e ?? 1 );
        }
        else if ( roundnumber >= level.var_a009ab14ee0d3223.var_2d3c6157e712e2b0 )
        {
            return 9999;
        }
    }
    
    return 1;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xd08c2a5, Offset: 0x552a
// Size: 0x129, Type: bool
function function_22a217027ac6615c( index )
{
    var_41ad1fe468915a91 = function_8ec904484436a94b();
    specials_alive = 0;
    
    foreach ( zombie in level.var_a009ab14ee0d3223.var_b730d8849849a3b2 )
    {
        if ( isalive( zombie ) && zombie.aicategory == "special" )
        {
            specials_alive++;
        }
    }
    
    if ( specials_alive >= var_41ad1fe468915a91 )
    {
        return false;
    }
    
    max_count = function_1c5e342854430bc3( index );
    
    if ( level.var_a009ab14ee0d3223.var_9d379c095fb6dce7.size >= max_count )
    {
        return false;
    }
    
    entry = level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f[ index ];
    
    if ( !function_8c69d9f0f6d77a68( entry ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x2c7953d8, Offset: 0x565c
// Size: 0x109
function private function_25f56352e22abcb1( index )
{
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    roundnumber = zm_round_logic::get_rb_round_number();
    specialentry = level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9[ index ];
    var_aec029c0c07f2f6e = specialentry.var_aec029c0c07f2f6e;
    
    if ( roundnumber < var_aec029c0c07f2f6e )
    {
        return 0;
    }
    
    maxspecial = 0;
    var_e9299b1c9798e152 = function_ad358cbb8158789e( roundnumber );
    percentage = 0;
    
    if ( roundnumber < 20 )
    {
        percentage = level.var_a009ab14ee0d3223.var_6e44161797bcde4f;
    }
    else if ( roundnumber >= 20 && roundnumber < 30 )
    {
        percentage = level.var_a009ab14ee0d3223.var_6e3f901797b7c1c6;
    }
    else if ( roundnumber >= 30 )
    {
        percentage = level.var_a009ab14ee0d3223.var_56c41c4cbf72797a;
    }
    
    maxspecial = int( var_e9299b1c9798e152 * percentage );
    maxspecial = max( maxspecial, 1 );
    return maxspecial;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x73235706, Offset: 0x576e
// Size: 0x6c, Type: bool
function function_3a0ab1f6903b730a( index )
{
    max_count = function_25f56352e22abcb1( index );
    
    if ( level.var_a009ab14ee0d3223.var_63798bb76ae9e64d.size >= max_count )
    {
        return false;
    }
    
    entry = level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9[ index ];
    
    if ( !function_8c69d9f0f6d77a68( entry ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x7f1ba166, Offset: 0x57e3
// Size: 0x1cc
function private function_678c569a34fbb6b9()
{
    var_ea04b86c356927e = 0;
    typecount = 0;
    
    foreach ( index, entry in level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9 )
    {
        var_1ccefe81a23f7ccb = function_25f56352e22abcb1( index );
        typecount = max( typecount, var_1ccefe81a23f7ccb );
    }
    
    var_ea04b86c356927e += int( typecount );
    typecount = 0;
    
    foreach ( index, entry in level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f )
    {
        var_1ccefe81a23f7ccb = function_1c5e342854430bc3( index );
        typecount = max( typecount, var_1ccefe81a23f7ccb );
    }
    
    var_ea04b86c356927e += int( typecount );
    typecount = 0;
    
    foreach ( index, entry in level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b )
    {
        var_1ccefe81a23f7ccb = function_486c40aa4be63f2f( index );
        typecount = max( typecount, var_1ccefe81a23f7ccb );
    }
    
    var_ea04b86c356927e += int( typecount );
    return var_ea04b86c356927e;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x9addccb7, Offset: 0x59b8
// Size: 0x2
function function_b585cd5bced9aea4()
{
    
}

// Namespace zm_round_spawning
// Params 3
// Checksum 0xaea81d35, Offset: 0x59c2
// Size: 0x19d
function function_b1395b00814bd299( var_62e02beede8dde07, specialroundstruct, numplayers )
{
    if ( var_62e02beede8dde07 >= 1 )
    {
        max_active_zombies = clamp( specialroundstruct.var_29c2ee2eb254f8d5 + specialroundstruct.var_4d1f1b9df63feffd * var_62e02beede8dde07, specialroundstruct.var_29c2ee2eb254f8d5, specialroundstruct.var_ae9d8d6388f2543a ) ?? 0;
        
        if ( numplayers == 2 )
        {
            max_active_zombies = clamp( specialroundstruct.var_1ad671e17b49ed4f + specialroundstruct.var_4d1f1b9df63feffd * var_62e02beede8dde07, specialroundstruct.var_1ad671e17b49ed4f, specialroundstruct.var_2c5d5fd47e6e5f28 ) ?? 0;
        }
        else if ( numplayers == 3 )
        {
            max_active_zombies = clamp( specialroundstruct.var_1ad16be17b43b746 + specialroundstruct.var_4d1f1b9df63feffd * var_62e02beede8dde07, specialroundstruct.var_1ad16be17b43b746, specialroundstruct.var_2c5d5fd47e6e5f28 ) ?? 0;
        }
        else if ( numplayers >= 4 )
        {
            max_active_zombies = clamp( specialroundstruct.var_1abb6de17b2b8879 + specialroundstruct.var_4d1f1b9df63feffd * var_62e02beede8dde07, specialroundstruct.var_1abb6de17b2b8879, specialroundstruct.var_2c5d5fd47e6e5f28 ) ?? 0;
        }
    }
    else
    {
        max_active_zombies = specialroundstruct.var_29c2ee2eb254f8d5 ?? 0;
        
        if ( numplayers == 2 )
        {
            max_active_zombies = specialroundstruct.var_1ad671e17b49ed4f ?? 0;
        }
        else if ( numplayers == 3 )
        {
            max_active_zombies = specialroundstruct.var_1ad16be17b43b746 ?? 0;
        }
        else if ( numplayers >= 4 )
        {
            max_active_zombies = specialroundstruct.var_1abb6de17b2b8879 ?? 0;
        }
    }
    
    return max_active_zombies;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x67b8945a, Offset: 0x5b68
// Size: 0x4be
function function_afbd7bd60c9f8ea5( var_64a6b24ca8582470 )
{
    function_d2c908e7f62ac5dc();
    roundnumber = zm_round_logic::get_rb_round_number();
    var_e9299b1c9798e152 = function_ad358cbb8158789e( roundnumber );
    specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
    numplayers = level.players.size;
    
    if ( var_64a6b24ca8582470 )
    {
        if ( level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size < level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 )
        {
            var_62e02beede8dde07 = 0;
            
            if ( isdefined( level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundstruct.specialroundname ] ) )
            {
                var_62e02beede8dde07 = level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundstruct.specialroundname ];
            }
            
            max_active_zombies = function_b1395b00814bd299( var_62e02beede8dde07, specialroundstruct, numplayers );
            
            if ( max_active_zombies > 0 )
            {
                active_zombies_count = function_70d1a99dd6bc4905();
                
                if ( active_zombies_count >= max_active_zombies )
                {
                    return;
                }
            }
            
            aitype = function_89b373d5f044b7c5();
            
            if ( !isdefined( aitype ) )
            {
                return;
            }
            
            zombie = function_de48159d01090b97( aitype );
            
            if ( isdefined( zombie ) )
            {
                set_spawned_zombies_move_speed( zombie, 1 );
                record_zombie_spawn( zombie );
                zombie.spawn_source = "special_zombie_spawn";
                level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = arraycombineunique( level.var_a009ab14ee0d3223.var_b730d8849849a3b2, [ zombie ] );
            }
        }
        
        return;
    }
    
    if ( isdefined( level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ] ) )
    {
        introentry = level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ];
        level.var_a009ab14ee0d3223.var_9ae086885e903c0c[ roundnumber ].var_122d0041d67b9666 = 1;
        
        if ( introentry.var_7817982d154020ab == "elite" && function_5103e4508a4b84c0( introentry.index ) )
        {
            zombie = function_be0204e01b80d37f( roundnumber, introentry.var_1024b930aa2cc8a2 );
            
            if ( zombie.aicategory == "elite" )
            {
                level thread function_30faa377c3363900( introentry.index, roundnumber, numplayers, introentry );
            }
            
            if ( function_80434b8ade390787( zombie ) )
            {
                zombie.var_825b17c932865df = 1;
            }
        }
        else if ( introentry.var_7817982d154020ab == "special" && function_22a217027ac6615c( introentry.index ) )
        {
            zombie = function_be0204e01b80d37f( roundnumber, introentry.var_1024b930aa2cc8a2 );
        }
        else if ( introentry.var_7817982d154020ab == "normal" && function_3a0ab1f6903b730a( introentry.index ) )
        {
            zombie = function_be0204e01b80d37f( roundnumber, introentry.var_1024b930aa2cc8a2 );
        }
        
        return zombie;
    }
    
    level.var_a009ab14ee0d3223.var_4fcb67d418d85735 = arrayrandomize( level.var_a009ab14ee0d3223.var_4fcb67d418d85735 );
    
    for ( entry_i = 0; entry_i < level.var_a009ab14ee0d3223.var_4fcb67d418d85735.size ; entry_i++ )
    {
        entry = level.var_a009ab14ee0d3223.var_4fcb67d418d85735[ entry_i ];
        var_9434b90ea25429f6 = 0;
        
        if ( entry.var_7817982d154020ab == "elite" )
        {
            index = function_f02c63b99c9614c9( level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b, entry );
            
            if ( function_5103e4508a4b84c0( index ) )
            {
                var_9434b90ea25429f6 = 1;
            }
        }
        else if ( entry.var_7817982d154020ab == "special" )
        {
            index = function_f02c63b99c9614c9( level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f, entry );
            
            if ( function_22a217027ac6615c( index ) )
            {
                var_9434b90ea25429f6 = 1;
            }
        }
        else if ( entry.var_7817982d154020ab == "normal" )
        {
            index = function_f02c63b99c9614c9( level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9, entry );
            
            if ( function_3a0ab1f6903b730a( index ) )
            {
                var_9434b90ea25429f6 = 1;
            }
        }
        
        if ( var_9434b90ea25429f6 )
        {
            zombie = function_be0204e01b80d37f( roundnumber, entry.var_1024b930aa2cc8a2 );
            
            if ( isdefined( zombie ) )
            {
                function_29ebf04c404a5dd6( entry );
                
                if ( zombie.aicategory == "elite" )
                {
                    level thread function_30faa377c3363900( index, roundnumber, numplayers, entry );
                }
                
                if ( function_80434b8ade390787( zombie ) )
                {
                    zombie.var_825b17c932865df = 1;
                }
            }
            
            return zombie;
        }
    }
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x7d494376, Offset: 0x602e
// Size: 0x567
function private function_58c1db68b1b5a98a()
{
    level.var_a009ab14ee0d3223.var_4fcb67d418d85735 = [];
    roundnumber = zm_round_logic::get_rb_round_number();
    maxtypes = 1;
    
    if ( roundnumber < 20 )
    {
        maxtypes = level.var_a009ab14ee0d3223.var_69a7030275dd9c9c;
    }
    else if ( roundnumber >= 20 && roundnumber < 30 )
    {
        maxtypes = level.var_a009ab14ee0d3223.var_bda668de764a73ed;
    }
    else if ( roundnumber >= 30 && roundnumber <= level.var_a009ab14ee0d3223.var_f0fd654a9847809b )
    {
        maxtypes = level.var_a009ab14ee0d3223.var_dd86aa356951f6bc;
    }
    else if ( roundnumber > level.var_a009ab14ee0d3223.var_f0fd654a9847809b )
    {
        maxtypes = 999;
    }
    
    if ( maxtypes <= 0 )
    {
        return;
    }
    
    chosen_types = [];
    
    foreach ( index, eliteentry in level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b )
    {
        if ( function_5103e4508a4b84c0( index, eliteentry ) )
        {
            chosen_types[ chosen_types.size ] = "elite";
            maxtypes -= 1;
            break;
        }
    }
    
    for ( types = [ "normal", "special" ]; types.size > 0 && maxtypes > 0 ; types = arrayremove( types, type ) )
    {
        type = utility::array_random( types );
        maxtypes -= 1;
        
        if ( type == "special" )
        {
            foreach ( index, specialentry in level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f )
            {
                if ( function_22a217027ac6615c( index ) )
                {
                    chosen_types[ chosen_types.size ] = "special";
                    break;
                }
            }
            
            continue;
        }
        
        if ( type == "normal" )
        {
            foreach ( index, normalentry in level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9 )
            {
                if ( function_3a0ab1f6903b730a( index ) )
                {
                    chosen_types[ chosen_types.size ] = "normal";
                    break;
                }
            }
        }
    }
    
    foreach ( type in chosen_types )
    {
        if ( type == "elite" )
        {
            foreach ( index, entry in level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b )
            {
                if ( function_5103e4508a4b84c0( index ) )
                {
                    level.var_a009ab14ee0d3223.var_4fcb67d418d85735[ level.var_a009ab14ee0d3223.var_4fcb67d418d85735.size ] = entry;
                }
            }
            
            continue;
        }
        
        if ( type == "special" )
        {
            foreach ( index, entry in level.var_a009ab14ee0d3223.var_8eb34c1c71c1333f )
            {
                if ( function_22a217027ac6615c( index ) )
                {
                    level.var_a009ab14ee0d3223.var_4fcb67d418d85735[ level.var_a009ab14ee0d3223.var_4fcb67d418d85735.size ] = entry;
                }
            }
            
            continue;
        }
        
        if ( type == "normal" )
        {
            foreach ( index, entry in level.var_a009ab14ee0d3223.var_48700cdf9eaa7f9 )
            {
                if ( function_3a0ab1f6903b730a( index ) )
                {
                    level.var_a009ab14ee0d3223.var_4fcb67d418d85735[ level.var_a009ab14ee0d3223.var_4fcb67d418d85735.size ] = entry;
                }
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 4
// Checksum 0x9440cba, Offset: 0x659d
// Size: 0x189
function function_30faa377c3363900( index, roundnumber, numplayers, eliteentry )
{
    level endon( #"game_ended" );
    
    if ( roundnumber >= eliteentry.var_dcf519ba5ddfcb9e )
    {
        if ( numplayers > 1 )
        {
            var_bed174c26f31d8c7 = roundnumber + randomintrange( eliteentry.var_3708b6dda0c9ac40, eliteentry.var_36e5ccdda0a394ea + 1 );
        }
        else
        {
            var_bed174c26f31d8c7 = roundnumber + randomintrange( eliteentry.var_a30fe78ee3022427, eliteentry.var_a332d58ee3284449 + 1 );
        }
    }
    else if ( numplayers > 1 )
    {
        var_bed174c26f31d8c7 = roundnumber + randomintrange( eliteentry.var_c3a7b23c3e2683a6, eliteentry.var_c3cac43c3e4cf2f4 + 1 );
    }
    else
    {
        var_bed174c26f31d8c7 = roundnumber + randomintrange( eliteentry.var_5aa2b29a430b14d9, eliteentry.var_5a7fc49a42e4f4b7 + 1 );
    }
    
    level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_cea9d3c969c0d633 = var_bed174c26f31d8c7;
    level.var_6781718da4f78d1c waittill( #"round_cleared" );
    level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_528de2fdf1c1a9d9++;
    level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_bed174c26f31d8c7 = var_bed174c26f31d8c7;
    level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_cea9d3c969c0d633 = undefined;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xbc31ef6f, Offset: 0x672e
// Size: 0x250
function function_be0204e01b80d37f( roundnumber, var_d1cedc5980ddf715 )
{
    if ( !isdefined( var_d1cedc5980ddf715 ) )
    {
        return;
    }
    
    aitype = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( var_d1cedc5980ddf715 );
    
    if ( !isdefined( aitype ) )
    {
        return;
    }
    
    var_f032ae6bea6d620a = get_quarter();
    
    if ( isdefined( level.var_a009ab14ee0d3223.var_ffd1e6c992abef73 ) && level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ var_f032ae6bea6d620a ] <= 0 )
    {
        return;
    }
    
    if ( level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ] )
    {
        count = level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ].size;
        aitype = level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ][ randomint( count ) ];
    }
    
    zombie = function_de48159d01090b97( aitype );
    
    if ( isdefined( zombie ) )
    {
        level.var_a009ab14ee0d3223.var_ffd1e6c992abef73[ var_f032ae6bea6d620a ]--;
        set_spawned_zombies_move_speed( zombie, 1 );
        record_zombie_spawn( zombie );
        zombie.spawn_source = "mixed_zombie_spawn";
        zombie thread function_3ac3ea659894a1a7( roundnumber );
        level.var_a009ab14ee0d3223.var_b730d8849849a3b2 = arraycombineunique( level.var_a009ab14ee0d3223.var_b730d8849849a3b2, [ zombie ] );
        zombiestruct = spawnstruct();
        zombiestruct.subclass = zombie.subclass;
        
        if ( zombie.aicategory == "elite" )
        {
            level.var_a009ab14ee0d3223.var_d66e7149a8db73cb[ level.var_a009ab14ee0d3223.var_d66e7149a8db73cb.size ] = zombiestruct;
        }
        else if ( zombie.aicategory == "special" )
        {
            level.var_a009ab14ee0d3223.var_9d379c095fb6dce7[ level.var_a009ab14ee0d3223.var_9d379c095fb6dce7.size ] = zombiestruct;
        }
        else if ( zombie.aicategory == "normal" )
        {
            level.var_a009ab14ee0d3223.var_63798bb76ae9e64d[ level.var_a009ab14ee0d3223.var_63798bb76ae9e64d.size ] = zombiestruct;
        }
    }
    
    return zombie;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xfb75d596, Offset: 0x6987
// Size: 0xdb
function get_round_enemies()
{
    round_enemies = [];
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.ignore_enemy_count )
        {
            continue;
        }
        
        if ( zombie.aicategory == "elite" )
        {
            continue;
        }
        
        if ( zombie status_effects::has_status_effect_type( "charm" ) )
        {
            continue;
        }
        
        round_enemies[ round_enemies.size ] = zombie;
    }
    
    return round_enemies;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x24042ab6, Offset: 0x6a6b
// Size: 0x19e
function function_1451667b00ffb21d( params )
{
    if ( level.var_a009ab14ee0d3223.state == 1 )
    {
        if ( has_round_spawning_completed() && zm_cleanup_manager::get_pending_respawn_count() == 0 )
        {
            round_zombies = get_round_enemies();
            
            if ( !level.var_a009ab14ee0d3223.var_a07b129aac45da61 && round_zombies.size <= 8 )
            {
                if ( round_zombies.size == 1 && level.var_a009ab14ee0d3223.var_e128d3d80a5672c4.size > 0 )
                {
                    brainrotted_zombie = level.var_a009ab14ee0d3223.var_e128d3d80a5672c4[ level.var_a009ab14ee0d3223.var_e128d3d80a5672c4.size - 1 ];
                    function_17c7b9075fa1b886( brainrotted_zombie );
                }
                
                foreach ( zombie in round_zombies )
                {
                    zombie zombie_emergence_spawning::function_80623a2279a4d888();
                }
                
                level.var_a009ab14ee0d3223.var_a07b129aac45da61 = 1;
            }
            
            if ( round_zombies.size <= level.var_a009ab14ee0d3223.var_d685b0049c84326 )
            {
                if ( isai( self ) )
                {
                    thread on_round_last_ai_killed( params.eattacker );
                }
                
                level.var_a009ab14ee0d3223.state = 2;
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x2e85c8a5, Offset: 0x6c11
// Size: 0x8e
function function_b2cd1d9c564cbf6e( params )
{
    if ( !isdefined( level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 ) )
    {
        level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 = [];
    }
    
    level.var_a009ab14ee0d3223.var_e128d3d80a5672c4[ level.var_a009ab14ee0d3223.var_e128d3d80a5672c4.size ] = self;
    
    if ( function_17c7b9075fa1b886( self ) )
    {
        return;
    }
    
    if ( level.var_a009ab14ee0d3223.state == 1 )
    {
        function_1451667b00ffb21d( params );
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xaa8b422, Offset: 0x6ca7
// Size: 0x8f, Type: bool
function function_17c7b9075fa1b886( brainrotted_zombie )
{
    if ( !has_round_spawning_completed() || zm_cleanup_manager::get_pending_respawn_count() != 0 )
    {
        return false;
    }
    
    round_zombies = get_round_enemies();
    
    if ( round_zombies.size != 1 || round_zombies[ 0 ] == brainrotted_zombie || !isalive( round_zombies[ 0 ] ) )
    {
        return false;
    }
    
    if ( round_zombies[ 0 ] val::get( "qol_turned_second_to_last_zombie" ) )
    {
        return true;
    }
    
    round_zombies[ 0 ] val::set( "qol_turned_second_to_last_zombie", "ignoreme", 1 );
    round_zombies[ 0 ] thread function_62c40a2813627612( brainrotted_zombie );
    return true;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xe3d44fcb, Offset: 0x6d3f
// Size: 0xea
function on_brainrot_end( sparams )
{
    level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 = utility::array_removedead_or_dying( level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 );
    newarray = [];
    
    foreach ( zombie in level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 )
    {
        if ( !zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            continue;
        }
        
        newarray[ newarray.size ] = zombie;
    }
    
    level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 = newarray;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x96961d5c, Offset: 0x6e31
// Size: 0x106
function function_62c40a2813627612( var_965cfd62c65068da )
{
    self endon( #"death" );
    var_965cfd62c65068da waittill( #"death" );
    
    if ( level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 && level.var_a009ab14ee0d3223.var_e128d3d80a5672c4.size > 0 )
    {
        var_caf4d46a329c3fb = 1;
        
        while ( var_caf4d46a329c3fb )
        {
            var_caf4d46a329c3fb = 0;
            
            foreach ( brot_zombie in level.var_a009ab14ee0d3223.var_e128d3d80a5672c4 )
            {
                if ( isalive( brot_zombie ) )
                {
                    var_caf4d46a329c3fb = 1;
                }
            }
            
            waitframe();
        }
    }
    
    val::reset( "qol_turned_second_to_last_zombie", "ignoreme" );
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x7754c243, Offset: 0x6f3f
// Size: 0x16, Type: bool
function has_round_spawning_completed()
{
    return istrue( level.var_a009ab14ee0d3223.spawningcompleted );
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xb2fd04d, Offset: 0x6f5e
// Size: 0x22
function function_7c08fdc922a2cf9( bspawning )
{
    level.var_a009ab14ee0d3223.spawningzombies = bspawning;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xa01f7ad, Offset: 0x6f88
// Size: 0x16, Type: bool
function function_2dfe1b653adf9c0d()
{
    return istrue( level.var_a009ab14ee0d3223.spawningzombies );
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x6ee75782, Offset: 0x6fa7
// Size: 0x1a3
function function_5f35aa2e209190da( nround, sspecialround )
{
    if ( level.var_7f29a2c7fe5ec0ef )
    {
        return [[ level.var_7f29a2c7fe5ec0ef ]]();
    }
    
    var_ac07512145efb190 = level.players.size;
    round_zombies = get_round_enemies();
    var_bdc9e352a85d81c1 = var_ac07512145efb190 + 4 + int( nround % 2 );
    
    if ( round_zombies.size < var_bdc9e352a85d81c1 )
    {
        return 0.1;
    }
    
    if ( isdefined( sspecialround ) )
    {
        if ( sspecialround.var_c77a2bb3ee36c2c9 )
        {
            spawn_delay_func = level.var_a009ab14ee0d3223.var_883bfe37c0fd93a3[ sspecialround.specialroundname ];
            assert( isdefined( spawn_delay_func ), "<dev string:x1a5>" + sspecialround.specialroundname );
            n_delay = [[ spawn_delay_func ]]( nround, sspecialround );
            return n_delay;
        }
    }
    
    switch ( var_ac07512145efb190 )
    {
        case 1:
            n_delay = 1.5;
            break;
        case 2:
            n_delay = 1.125;
            break;
        case 3:
            n_delay = 0.6675;
            break;
        case 4:
            n_delay = 0.5025;
            break;
        default:
            n_delay = 0.4125;
            break;
    }
    
    nround = min( nround, 60 );
    
    for ( i = 1; i < nround ; i++ )
    {
        n_delay *= 0.95;
        
        if ( n_delay <= 0.1 )
        {
            n_delay = 0.1;
            break;
        }
    }
    
    return n_delay;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xc0462b75, Offset: 0x7153
// Size: 0x31a
function function_6211dbc10409aa10( fixed_round_number )
{
    if ( isdefined( fixed_round_number ) )
    {
        roundnumber = fixed_round_number;
    }
    else
    {
        roundnumber = zm_round_logic::get_rb_round_number();
    }
    
    if ( roundnumber == 1 && level.var_a009ab14ee0d3223.var_f374ba2d1651228a == 1 )
    {
        movespeed = 1;
    }
    else
    {
        movespeed = roundnumber * level.var_a009ab14ee0d3223.movespeedmultiplier;
        movespeed = int( clamp( movespeed, 1, 237 ) );
    }
    
    if ( roundnumber >= level.var_a009ab14ee0d3223.supersprintinground )
    {
        if ( roundnumber != level.var_a009ab14ee0d3223.supersprintinground )
        {
            var_ed2f54280944eb53 = level.var_a009ab14ee0d3223.var_21c97e4bd76e8702 + ( roundnumber - level.var_a009ab14ee0d3223.supersprintinground ) * level.var_a009ab14ee0d3223.var_3756709e67f5764a;
        }
        else
        {
            var_ed2f54280944eb53 = level.var_a009ab14ee0d3223.var_21c97e4bd76e8702;
        }
        
        var_e49e8bc18def774e = clamp( var_ed2f54280944eb53, level.var_a009ab14ee0d3223.var_21c97e4bd76e8702, level.var_a009ab14ee0d3223.var_5f62e94a2cd0a294 );
        
        if ( utility::percent_chance( var_e49e8bc18def774e ) )
        {
            return ( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "super_sprint" == "super_sprint" || "super_sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "super_sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "super_sprint" == "sprint" ? "run" : "super_sprint" );
        }
        else
        {
            movespeed = level.var_a009ab14ee0d3223.supersprintinground * level.var_a009ab14ee0d3223.movespeedmultiplier;
        }
    }
    
    if ( is_special_round( roundnumber ) )
    {
        movespeed = int( max( movespeed, 36 ) );
    }
    
    movespeed = randomintrange( movespeed, movespeed + level.var_a009ab14ee0d3223.movespeedoffset );
    movespeed = zm_utility::function_3aa660fdfe227adb( movespeed );
    return level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( movespeed == "super_sprint" || movespeed == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && movespeed == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && movespeed == "sprint" ? "run" : movespeed;
}

// Namespace zm_round_spawning
// Params 2, eflags: 0x4
// Checksum 0xe4ef484b, Offset: 0x7476
// Size: 0x55
function private function_dd4b8070d89e62c( zombie, round_number )
{
    if ( !level.var_9209eecc9aff21ad )
    {
        zombie namespace_9d8e359c3b1041e5::function_b2ccfa9f49ce6938( round_number );
    }
    
    if ( isdefined( level.var_3c6a4eee7184de4e ) )
    {
        zombie thread [[ level.var_3c6a4eee7184de4e ]]();
        return;
    }
    
    set_spawned_zombies_move_speed( zombie, 3 );
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xcb0fe1ec, Offset: 0x74d3
// Size: 0x238
function function_ad358cbb8158789e( nround )
{
    var_ac07512145efb190 = level.players.size;
    max_count = 24;
    countperplayer = 6;
    var_acecb1df010e120f = 1;
    
    if ( isfunction( level.var_4be693528db27813 ) )
    {
        max_count = [[ level.var_4be693528db27813 ]]( nround, var_ac07512145efb190 );
        return max_count;
    }
    
    roundspawnstruct = function_4ed4fdc352e66c9( nround );
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ nround ] ) )
    {
        max_count = get_special_round_count( nround );
    }
    else if ( roundspawnstruct.roundnumber == nround )
    {
        switch ( var_ac07512145efb190 )
        {
            case 1:
                max_count = roundspawnstruct.roundcount;
                break;
            case 2:
                max_count = roundspawnstruct.var_a42625720c9305fb;
                break;
            case 3:
                max_count = roundspawnstruct.var_a4221f720c8f02f2;
                break;
            default:
                max_count = roundspawnstruct.var_a42f31720c9d3f0d;
                break;
        }
    }
    else
    {
        if ( var_ac07512145efb190 == 1 )
        {
            var_14ff58d0d4520cc4 = level.var_a009ab14ee0d3223.var_7b8339d2f66a3028;
            n_scaler = level.var_a009ab14ee0d3223.linearscalarsolo;
            var_cc5b9dd7d354cecb = level.var_a009ab14ee0d3223.var_9c1c9413c30befe7;
        }
        else
        {
            var_14ff58d0d4520cc4 = level.var_a009ab14ee0d3223.var_5c020d5f56ef385e;
            n_scaler = level.var_a009ab14ee0d3223.linearscalarcoop;
            var_cc5b9dd7d354cecb = 0.5 + var_ac07512145efb190 / 2;
        }
        
        if ( nround < var_14ff58d0d4520cc4 )
        {
            n_scaler = level.var_a009ab14ee0d3223.exponentialscalar;
            multiplier = nround / 5;
            
            if ( multiplier < 1 )
            {
                multiplier = 1;
            }
            
            multiplier *= nround * n_scaler;
        }
        else
        {
            multiplier = nround * n_scaler;
        }
        
        max_count += int( var_cc5b9dd7d354cecb * countperplayer * multiplier );
        max_count = clamp( max_count, 24, 2147483647 );
    }
    
    return max_count;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x544f462d, Offset: 0x7714
// Size: 0x15d
function get_round_progress_percent()
{
    var_d7353168acb32c7e = level.var_a009ab14ee0d3223.var_5c8829ccd69f3862;
    var_6ecc4faadeb66114 = 0;
    zombies = getaispeciesarray( "all", "zombie" );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && zombie.team != level.player.team && !zombie.ignore_enemy_count )
        {
            var_6ecc4faadeb66114++;
        }
    }
    
    var_6283e357a4e52a5 = 0;
    var_6283e357a4e52a5 = level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 - level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size;
    var_6283e357a4e52a5 += zm_cleanup_manager::get_pending_respawn_count();
    progresspercentage = 100;
    
    if ( var_d7353168acb32c7e > 0 )
    {
        progressfraction = 1 - ( var_6283e357a4e52a5 + var_6ecc4faadeb66114 ) / var_d7353168acb32c7e;
        progresspercentage = progressfraction * 100;
    }
    
    return progresspercentage;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x484abb5b, Offset: 0x787a
// Size: 0xbe
function function_d6eb585544b35e3()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist ) )
    {
        randomindex = 0;
        
        if ( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist.size > 0 )
        {
            randomindex = randomintrange( 0, level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist.size );
        }
        
        return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist[ randomindex ].aispawntype;
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xd6d97156, Offset: 0x7940
// Size: 0xf7
function function_89b373d5f044b7c5()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        var_d1cedc5980ddf715 = function_d6eb585544b35e3();
        aitype = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( var_d1cedc5980ddf715 );
        return aitype;
    }
    
    roundspawnstruct = function_4ed4fdc352e66c9( roundnumber );
    
    if ( isdefined( roundspawnstruct.ailist ) )
    {
        aitype = namespace_c7157c2cd884c5d5::function_d34f63bc9c24e432( roundspawnstruct.ailist );
        
        if ( level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ] )
        {
            count = level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ].size;
            return level.var_a009ab14ee0d3223.var_5972f94205c7fe96[ aitype ][ randomint( count ) ];
        }
        
        return aitype;
    }
    else
    {
        assertmsg( "<dev string:x1db>" );
    }
    
    return "t10_spawner_zm_zombie";
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x4fda1f69, Offset: 0x7a40
// Size: 0x65
function function_4ed4fdc352e66c9( roundnumber )
{
    for ( roundindex = roundnumber; roundindex >= 1 ; roundindex-- )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.var_bb3be8e0341ae1eb[ roundindex ] ) )
        {
            roundspawnstruct = level.var_a009ab14ee0d3223.var_bb3be8e0341ae1eb[ roundindex ];
            return roundspawnstruct;
        }
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xd5a45855, Offset: 0x7aad
// Size: 0x16
function is_round_spawning_paused()
{
    return level.var_a009ab14ee0d3223 val::get( "pause_zombie_spawning" );
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x6a0893f0, Offset: 0x7acc
// Size: 0x9b
function pause_round_spawning( bpause, var_416a12f01f34bb88 )
{
    if ( bpause )
    {
        change_spawn_closet_sound( 0 );
        level.var_a009ab14ee0d3223 val::set( var_416a12f01f34bb88, "pause_zombie_spawning", 1 );
        level utility::flag_set( "pause_round_timeout" );
    }
    else
    {
        change_spawn_closet_sound( 1 );
        level.var_a009ab14ee0d3223 val::reset_all( var_416a12f01f34bb88 );
        level utility::flag_clear( "pause_round_timeout" );
    }
    
    level.var_a009ab14ee0d3223.spawningpaused = istrue( level.var_a009ab14ee0d3223.b_value_pause_zombie_spawning );
}

// Namespace zm_round_spawning
// Params 3, eflags: 0x4
// Checksum 0xc6529ffe, Offset: 0x7b6f
// Size: 0x71, Type: bool
function private function_aca6dc1b9ce0745( round_number, round_name, paramsstruct )
{
    if ( level.var_a009ab14ee0d3223.var_90e1d244c1410109[ round_name ] == 0 )
    {
        return false;
    }
    else if ( level.var_a009ab14ee0d3223.specialroundspawns[ round_number ].specialroundtier <= paramsstruct.specialroundtier )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xbcf5bbe2, Offset: 0x7be9
// Size: 0x4b7
function schedule_special_round( roundnumber, paramsstruct )
{
    self notify( #"hash_87075a0ab1236d94" );
    self endon( #"hash_87075a0ab1236d94" );
    
    if ( isdefined( paramsstruct.var_47a8be5d3ffd24a ) && paramsstruct.var_47a8be5d3ffd24a != 0 && paramsstruct.var_47a8be5d3ffd24a < roundnumber )
    {
        return;
    }
    
    while ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( paramsstruct.var_47a8be5d3ffd24a ) && paramsstruct.var_47a8be5d3ffd24a != 0 && paramsstruct.var_47a8be5d3ffd24a < roundnumber )
        {
            return;
        }
        
        if ( function_aca6dc1b9ce0745( roundnumber, level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].specialroundname, paramsstruct ) )
        {
            var_610a1ae8b7800cec = level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ];
            level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] = paramsstruct;
            roundnumber++;
            schedule_special_round( roundnumber, var_610a1ae8b7800cec );
            return;
        }
        
        roundnumber++;
    }
    
    waitframe();
    
    if ( !isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        specialroundinfo = spawnstruct();
        specialroundinfo.roundnumber = roundnumber;
        specialroundinfo.ailist = paramsstruct.ailist;
        specialroundinfo.var_e28b1bf3be5e30f2 = paramsstruct.var_e28b1bf3be5e30f2;
        specialroundinfo.var_e26825f3be37ff38 = paramsstruct.var_e26825f3be37ff38;
        specialroundinfo.var_16f342b397743f5 = paramsstruct.var_16f342b397743f5;
        specialroundinfo.var_1921e2b399d5b4b = paramsstruct.var_1921e2b399d5b4b;
        specialroundinfo.specialroundtier = paramsstruct.specialroundtier;
        specialroundinfo.specialroundname = paramsstruct.specialroundname;
        specialroundinfo.var_562e39c780ef0fa4 = paramsstruct.var_562e39c780ef0fa4;
        specialroundinfo.var_21ac207e2908c5c8 = paramsstruct.var_21ac207e2908c5c8;
        specialroundinfo.var_4306ca79c64fad3b = paramsstruct.var_4306ca79c64fad3b;
        specialroundinfo.var_42f9b879c6417120 = paramsstruct.var_42f9b879c6417120;
        specialroundinfo.var_42fdbe79c6457429 = paramsstruct.var_42fdbe79c6457429;
        specialroundinfo.var_4313bc79c65da2f6 = paramsstruct.var_4313bc79c65da2f6;
        specialroundinfo.var_52bfbe9e13deb4c7 = paramsstruct.var_52bfbe9e13deb4c7;
        specialroundinfo.var_1fb01024d9a5c081 = paramsstruct.var_1fb01024d9a5c081;
        specialroundinfo.var_eec8f2844cac48b5 = paramsstruct.var_eec8f2844cac48b5;
        specialroundinfo.var_10d082d4638b156b = paramsstruct.var_10d082d4638b156b;
        specialroundinfo.var_9bb7dd09100f8ce2 = paramsstruct.var_9bb7dd09100f8ce2;
        specialroundinfo.roundendrewardlist = paramsstruct.roundendrewardlist;
        specialroundinfo.var_4d1f1b9df63feffd = paramsstruct.var_4d1f1b9df63feffd;
        specialroundinfo.var_ae9d8d6388f2543a = paramsstruct.var_ae9d8d6388f2543a;
        specialroundinfo.var_2c5d5fd47e6e5f28 = paramsstruct.var_2c5d5fd47e6e5f28;
        specialroundinfo.var_29c2ee2eb254f8d5 = paramsstruct.var_29c2ee2eb254f8d5;
        specialroundinfo.var_1ad671e17b49ed4f = paramsstruct.var_1ad671e17b49ed4f;
        specialroundinfo.var_1ad16be17b43b746 = paramsstruct.var_1ad16be17b43b746;
        specialroundinfo.var_1abb6de17b2b8879 = paramsstruct.var_1abb6de17b2b8879;
        specialroundinfo.var_c77a2bb3ee36c2c9 = paramsstruct.var_c77a2bb3ee36c2c9;
        specialroundinfo.var_47a8be5d3ffd24a = paramsstruct.var_47a8be5d3ffd24a;
        
        foreach ( aispawnlist in specialroundinfo.ailist )
        {
            if ( isdefined( aispawnlist.spawncount ) && aispawnlist.spawncount != 0 )
            {
                aispawnlist.spawncount = 0;
            }
        }
        
        level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] = specialroundinfo;
    }
    
    level callback::callback( "special_round_scheduled", { #roundnumber:roundnumber } );
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x5d6aca31, Offset: 0x80a8
// Size: 0xad
function function_eac31e771f56391a()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_10d082d4638b156b ) )
        {
            return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_10d082d4638b156b;
        }
        else
        {
            roundstruct = function_4ed4fdc352e66c9( roundnumber );
            return roundstruct.lightarmordroplist;
        }
        
        return;
    }
    
    roundstruct = function_4ed4fdc352e66c9( roundnumber );
    return roundstruct.lightarmordroplist;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x9cad4d20, Offset: 0x815d
// Size: 0xad
function function_731e9691bd12b58f()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_9bb7dd09100f8ce2 ) )
        {
            return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_9bb7dd09100f8ce2;
        }
        else
        {
            roundstruct = function_4ed4fdc352e66c9( roundnumber );
            return roundstruct.heavyarmordroplist;
        }
        
        return;
    }
    
    roundstruct = function_4ed4fdc352e66c9( roundnumber );
    return roundstruct.heavyarmordroplist;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x91ffafe3, Offset: 0x8212
// Size: 0xad
function function_dea06a34aeea707d()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_52bfbe9e13deb4c7 ) )
        {
            return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_52bfbe9e13deb4c7;
        }
        else
        {
            roundstruct = function_4ed4fdc352e66c9( roundnumber );
            return roundstruct.normaldroplist;
        }
        
        return;
    }
    
    roundstruct = function_4ed4fdc352e66c9( roundnumber );
    return roundstruct.normaldroplist;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x2aeb4c58, Offset: 0x82c7
// Size: 0xad
function function_dc38a7b6d572496f()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_1fb01024d9a5c081 ) )
        {
            return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_1fb01024d9a5c081;
        }
        else
        {
            roundstruct = function_4ed4fdc352e66c9( roundnumber );
            return roundstruct.specialdroplist;
        }
        
        return;
    }
    
    roundstruct = function_4ed4fdc352e66c9( roundnumber );
    return roundstruct.specialdroplist;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xec5a2b2b, Offset: 0x837c
// Size: 0xad
function function_350ae5b344b92adb()
{
    roundnumber = zm_round_logic::get_rb_round_number();
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ] ) )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_eec8f2844cac48b5 ) )
        {
            return level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].var_eec8f2844cac48b5;
        }
        else
        {
            roundstruct = function_4ed4fdc352e66c9( roundnumber );
            return roundstruct.elitedroplist;
        }
        
        return;
    }
    
    roundstruct = function_4ed4fdc352e66c9( roundnumber );
    return roundstruct.elitedroplist;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x7006a662, Offset: 0x8431
// Size: 0x14d
function function_a7a5164e5196f1b7()
{
    level endon( #"game_ended" );
    var_2ee3cc99fe1b3b40 = level.var_a009ab14ee0d3223.var_da24f5c6bb59b76a;
    n_last_zombies = level.var_a009ab14ee0d3223.var_d41ffa914f85b3a9;
    
    while ( true )
    {
        roundnumber = zm_round_logic::get_rb_round_number();
        var_ea66d4e0c6f1ff00 = level.var_a009ab14ee0d3223.state;
        
        if ( roundnumber < var_2ee3cc99fe1b3b40 )
        {
            wait 3;
            continue;
        }
        
        if ( var_ea66d4e0c6f1ff00 != 1 )
        {
            wait 3;
            continue;
        }
        
        round_zombies = get_round_enemies();
        
        if ( round_zombies.size <= n_last_zombies && round_zombies.size > 0 )
        {
            zombies = round_zombies;
            
            foreach ( zombie in zombies )
            {
                if ( isalive( zombie ) )
                {
                    zombie thread last_zombie_speed_up();
                }
            }
        }
        
        wait 3;
    }
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0xb5c3b014, Offset: 0x8586
// Size: 0x41
function private last_zombie_speed_up()
{
    if ( self.var_14934b39c3a69040 )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        if ( !function_ef4f01ab7c2806e0( self ) )
        {
            return;
        }
        
        self.var_14934b39c3a69040 = 1;
        zombie_utils::function_a8ce00e0448cb6f0( "sprint", "speedup", 4 );
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x45e66aa8, Offset: 0x85cf
// Size: 0xd0
function private on_round_last_ai_killed( attacker )
{
    params = spawnstruct();
    params.ai = self;
    params.attacker = attacker;
    params.isspecialround = level.var_a009ab14ee0d3223.isspecialround;
    
    if ( params.isspecialround )
    {
        specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ zm_round_logic::get_rb_round_number() ];
        params.roundendrewardlist = specialroundstruct.roundendrewardlist;
    }
    
    if ( isdefined( self.var_664fc2b93d674b62 ) )
    {
        params.var_664fc2b93d674b62 = self.var_664fc2b93d674b62;
    }
    
    level callback::callback( "on_round_last_ai_killed", params );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xee171790, Offset: 0x86a7
// Size: 0x2b, Type: bool
function private function_80434b8ade390787( zombie )
{
    if ( isdefined( zombie ) && zombie.aicategory == "elite" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x70e8b9af, Offset: 0x86db
// Size: 0xb5
function function_bf27d914a0d9ae6c()
{
    utility::flag_wait( "zm_round_spawning_init_data_done" );
    setdvarifuninitialized( @"hash_cfc3eea82ec8401", 1 );
    
    if ( getdvarint( @"hash_cfc3eea82ec8401" ) == 1 )
    {
        level._effect[ "scrnfx_special_round" ] = loadfxasset( level.var_a009ab14ee0d3223.var_f82d7f279e97e0a9 );
        level._effect[ "special_round_cam_vfx" ] = loadfxasset( level.var_a009ab14ee0d3223.var_3d268311dd73c56a );
        level callback::add( "special_round_start", &on_special_round_start );
        level callback::add( "special_round_end", &on_special_round_end );
        level callback::add( "on_exfil_start", &on_exfil_start );
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x293afa52, Offset: 0x8798
// Size: 0x9a
function init_spawn_sound()
{
    var_e45007a327fa8d83 = getentitylessscriptablearray( "scriptable_zm_t10_spawn_closet_sound", #classname );
    
    if ( isdefined( var_e45007a327fa8d83 ) )
    {
        foreach ( var_31627cc4fbae8347 in var_e45007a327fa8d83 )
        {
            var_31627cc4fbae8347.b_is_playing = 0;
        }
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xb40ebd20, Offset: 0x883a
// Size: 0x101
function change_spawn_closet_sound( var_ae740a76f0c8ef99 )
{
    var_e45007a327fa8d83 = getentitylessscriptablearray( "scriptable_zm_t10_spawn_closet_sound", #classname );
    
    if ( isdefined( var_e45007a327fa8d83 ) )
    {
        foreach ( var_31627cc4fbae8347 in var_e45007a327fa8d83 )
        {
            if ( var_ae740a76f0c8ef99 && !var_31627cc4fbae8347.b_is_playing )
            {
                var_31627cc4fbae8347 setscriptablepartstate( "base", "on" );
                var_31627cc4fbae8347.b_is_playing = 1;
                continue;
            }
            
            if ( !var_ae740a76f0c8ef99 && var_31627cc4fbae8347.b_is_playing )
            {
                var_31627cc4fbae8347 setscriptablepartstate( "base", "off" );
                var_31627cc4fbae8347.b_is_playing = 0;
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xdbe7219f, Offset: 0x8943
// Size: 0x9e
function private on_special_round_start( params )
{
    if ( utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    if ( !level callback::exists( #"player_spawned", &function_338677c1925b2ed0 ) )
    {
        level callback::add( #"player_spawned", &function_338677c1925b2ed0 );
    }
    
    function_ad03c7718ee3842( 1 );
    pause_round_spawning( 1, "special_round_start_delay" );
    
    if ( level.s_rampage.var_e06b5c72f9591a0f )
    {
        wait 0.5;
    }
    else
    {
        wait 4.5;
    }
    
    level thread special_round_start_vo();
    wait 2;
    pause_round_spawning( 0, "special_round_start_delay" );
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x31d8293d, Offset: 0x89e9
// Size: 0x116
function private special_round_start_vo()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_e05a82d77bd87fe0 ) )
    {
        level.var_e05a82d77bd87fe0 = 0;
    }
    
    zm_quest::function_8934bb2a9028bdc5();
    waitframe();
    
    if ( level.var_445da93d1acc5bca )
    {
        return;
    }
    
    level utility::flag_set( "special_round_vo_active" );
    
    if ( level.var_453e7b180cb422e0 )
    {
        overlord::playevent( #"zm_special_round_start_vo_twins", level.players, undefined, 1, 1 );
    }
    else if ( utility::percent_chance( level.s_zm_vo.var_a082742f518d9ed1 ?? 75 ) && level.var_e05a82d77bd87fe0 < ( level.s_zm_vo.var_e05a82d77bd87fe0 ?? 6 ) && !level.var_7315ae0dd159a3d6 )
    {
        overlord::playevent( "zm_special_round_start_vo_warden", level.players, undefined, 1, 1 );
        level.var_e05a82d77bd87fe0++;
    }
    else
    {
        overlord::playevent( "zm_special_round_start_vo", level.players, undefined, 1, 1 );
    }
    
    level utility::flag_clear( "special_round_vo_active" );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xfb69ae3b, Offset: 0x8b07
// Size: 0x2a
function private on_special_round_end( params )
{
    level callback::remove( #"player_spawned", &function_338677c1925b2ed0 );
    function_ad03c7718ee3842( 0 );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x5be3c962, Offset: 0x8b39
// Size: 0x39
function private on_exfil_start( params )
{
    if ( is_special_round( zm_utility::get_round_number() ) )
    {
        level callback::remove( #"player_spawned", &function_338677c1925b2ed0 );
        function_ad03c7718ee3842( 0 );
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x5f206ad5, Offset: 0x8b7a
// Size: 0xa5
function function_ad03c7718ee3842( var_e12f26713e8411c0 )
{
    var_e12f26713e8411c0 = var_e12f26713e8411c0 ?? 1;
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player thread function_4ac257955c0b5c16( var_e12f26713e8411c0 );
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x1f6f51a, Offset: 0x8c27
// Size: 0x13f
function function_4ac257955c0b5c16( var_e12f26713e8411c0 )
{
    var_e12f26713e8411c0 = var_e12f26713e8411c0 ?? 1;
    player = self;
    player endon( #"death_or_disconnect" );
    
    if ( isalive( player ) )
    {
        if ( var_e12f26713e8411c0 )
        {
            playfxontagforclients( level._effect[ "scrnfx_special_round" ], player, "j_head", player );
            waitframe();
            
            if ( isplayer( player ) && isalive( player ) )
            {
                playfxontagforclients( level._effect[ "special_round_cam_vfx" ], player, "j_head", player );
                
                if ( level callback::exists_any( "custom_special_round_audio_start" ) )
                {
                    level callback::callback( "custom_special_round_audio_start", { #player:player } );
                }
                else if ( player getscriptablehaspart( "rbz_specialround_audio" ) )
                {
                    player setscriptablepartstate( "rbz_specialround_audio", "activate" );
                }
            }
            
            return;
        }
        
        stopfxontagforclients( level._effect[ "scrnfx_special_round" ], player, "j_head", player );
        
        if ( level callback::exists_any( "custom_special_round_audio_stop" ) )
        {
            level callback::callback( "custom_special_round_audio_stop", { #player:player } );
            return;
        }
        
        if ( player getscriptablehaspart( "rbz_specialround_audio" ) )
        {
            player setscriptablepartstate( "rbz_specialround_audio", "deactivate" );
        }
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x763c9b11, Offset: 0x8d6e
// Size: 0x27
function private function_338677c1925b2ed0( params )
{
    playfxontagforclients( level._effect[ "scrnfx_special_round" ], self, "j_head", self );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xd8baf6de, Offset: 0x8d9d
// Size: 0x4c
function private function_10c4a4c11287a05f( params )
{
    roundcheck = params.roundnumber;
    
    if ( params.var_e7c2c09903c13bf7 )
    {
        roundcheck++;
    }
    
    if ( is_special_round( roundcheck ) )
    {
        level utility::flag_set( "special_round_is_ongoing" );
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x40f9b28b, Offset: 0x8df1
// Size: 0x19
function private function_6d2c9b588c36f472( params )
{
    level utility::flag_clear( "special_round_is_ongoing" );
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x2809ba47, Offset: 0x8e12
// Size: 0x45, Type: bool
function is_special_round( n_round )
{
    if ( !isdefined( n_round ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns ) )
    {
        return isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ n_round ] );
    }
    
    return false;
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x3526228b, Offset: 0x8e60
// Size: 0x2c
function private function_eeded9fbedf5c06()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"pause_round_spawning", &cheat_pause_round_spawning );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_8182439e61f712d1", &function_3bd7f10826bbbf82 );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xac96f29a, Offset: 0x8e94
// Size: 0x44
function private cheat_pause_round_spawning( params )
{
    enabled = !isdefined( params ) || int( params[ 0 ] ) > 0;
    pause_round_spawning( enabled, "cheat_pause" );
    iprintlnbold( "Round Spawning Pause: " + enabled );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x9c077f6b, Offset: 0x8ee0
// Size: 0xa24
function private function_3bd7f10826bbbf82( params )
{
    log_statements = [];
    log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Debuging why round spawning is not progressing:";
    log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Round Logic state is " + level.var_6781718da4f78d1c.state;
    
    if ( level.var_a009ab14ee0d3223 val::get( "pause_zombie_spawning" ) )
    {
        valuestates = level.var_a009ab14ee0d3223.values[ "pause_zombie_spawning" ];
        reason = getlastarraykey( valuestates ) ?? "unknown";
        
        if ( !isstring( reason ) )
        {
            reason = "unknown";
        }
        
        iprintlnbold( "Round spawning is paused due to: " + reason );
        wait 1;
    }
    
    if ( getdvarint( @"zm_round_spawning_pause", 0 ) > 0 )
    {
        log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Paused due to zm_round_spawning_pause";
        iprintlnbold( "Round spawning is paused due to dvar: zm_round_spawning_pause" );
        wait 1;
    }
    
    if ( getdvarint( @"zm_round_spawning_enabled", 1 ) < 1 )
    {
        log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Paused due to zm_round_spawning_enabled";
        iprintlnbold( "Round spawning is paused due to dvar: zm_round_spawning_enabled" );
        wait 1;
    }
    
    if ( !utility::flag( "begin_round_logic" ) )
    {
        log_statements[ log_statements.size ] = "[ROUND_SPAWNING] begin_round_logic is false";
        iprintlnbold( "Round spawning has not started yet from flag 'begin_round_logic'" );
        wait 1;
    }
    
    valid_player_exists = 0;
    
    foreach ( player in level.players )
    {
        if ( !zm_utility::is_player_valid_target( player ) )
        {
            continue;
        }
        
        if ( player val::get( "round_spawning_ignore_player" ) )
        {
            continue;
        }
        
        valid_player_exists = 1;
        break;
    }
    
    if ( !valid_player_exists )
    {
        iprintlnbold( "Round spawning is paused due to no valid player" );
        
        foreach ( player in level.players )
        {
            if ( !zm_utility::is_player_valid_target( player ) )
            {
                log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Player (" + ( player.name ?? "unknown" ) + ") is not a valid target to spawn on";
                continue;
            }
            
            if ( player val::get( "round_spawning_ignore_player" ) )
            {
                valuestates = player.values[ "round_spawning_ignore_player" ];
                reason = getlastarraykey( valuestates ) ?? "unknown";
                
                if ( !isstring( reason ) )
                {
                    reason = "unknown";
                }
                
                log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Player (" + ( player.name ?? "unknown" ) + ") is set to be ignored by round spawning due to: " + reason;
            }
        }
    }
    
    round_enemies = get_round_enemies();
    
    if ( round_enemies.size > 0 )
    {
        if ( getdvarint( @"zm_cleanup_enabled", 1 ) < 1 )
        {
            log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Paused due to cleanup disabled via dvar 'zm_cleanup_enabled' and zombies alive";
            iprintlnbold( "Round spawning is aused due to cleanup disabled 'zm_cleanup_enabled'" );
            wait 1;
        }
    }
    
    foreach ( player in level.players )
    {
        if ( zm_utility::is_player_valid_target( player ) && !player val::get( "round_spawning_ignore_player" ) )
        {
            log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Player " + player getentitynumber() + ": origin: " + player.origin + ( isdefined( player.last_valid_position ) ? ", last valid: " + player.last_valid_position : "" ) + ( isdefined( player.cached_zone_info.zone_struct.zone_name ) ? ", zone: " + player.cached_zone_info.zone_struct.zone_name : " no zone set" );
        }
    }
    
    screen_statements = [];
    enemy_i = 1;
    
    foreach ( enemy in round_enemies )
    {
        enemy_zone = enemy zone_manager::get_current_zone();
        zone_name = enemy_zone.zone_name ?? "undefined zone";
        spawn_loc_origin = enemy.spawn_loc.origin ?? "unknown spawn loc";
        cleanup_disabled_reason = "";
        
        if ( enemy val::get( "ignore_cleanup" ) )
        {
            valuestates = enemy.values[ "ignore_cleanup" ];
            reason = getlastarraykey( valuestates ) ?? "";
            
            if ( isstring( reason ) )
            {
                cleanup_disabled_reason = "Cleanup disabled because of: " + reason;
            }
        }
        else if ( enemy.b_ignore_cleanup )
        {
            cleanup_disabled_reason = "Cleanup disabled but reason is unknown due to not using values system. ";
        }
        
        closest_player = enemy utility::get_closest_player();
        closest_player_info = "Closest player invalid.";
        
        if ( isdefined( closest_player ) )
        {
            closest_player_info = "Closest player origin (" + closest_player.origin + ") and distance is: " + distance( closest_player.origin, enemy.origin ) + ". ";
        }
        
        team_info = "Team: " + ( enemy.team ?? "" ) + ". ";
        var_d42e5c55fcbce9e7 = "";
        
        if ( enemy.b_in_cleanup )
        {
            var_d42e5c55fcbce9e7 = "Cannot cleanup due to in cleanup. ";
        }
        
        log_statements[ log_statements.size ] = "[ROUND_SPAWNING] Round enemy(" + enemy.subclass + ") w/ entnum(" + enemy getentitynumber() + ") found in " + zone_name + " " + enemy.origin + ". Spawn location: " + spawn_loc_origin + ". " + cleanup_disabled_reason + closest_player_info + team_info + var_d42e5c55fcbce9e7;
        screen_statements[ screen_statements.size ] = "Round spawning maybe paused due to alive enemy #" + enemy_i + " in " + zone_name + " (" + enemy.origin + " )" + ". " + cleanup_disabled_reason;
        enemy_i += 1;
    }
    
    level.var_a009ab14ee0d3223 val::log_value( "pause_zombie_spawning" );
    
    if ( isdefined( level.var_52cc30b67469d423 ) )
    {
        logstring( "Cleanup Distance Override is active: " + sqrt( level.var_52cc30b67469d423 ) );
    }
    
    foreach ( statement in log_statements )
    {
        logstring( statement );
    }
    
    round_enemies = get_round_enemies();
    enemy_i = 1;
    
    foreach ( enemy in round_enemies )
    {
        enemy val::log_value();
    }
    
    foreach ( zone_name, zone in level.zone_manager.inited_defs )
    {
        logstring( "Zone (" + zone_name + ") is " + ( zone.is_active ? "" : "not " ) + "active. " + ( zone.occupants.size > 0 ? "Occupants: " + zone.occupants.size : "" ) + ( zone.occupied_adjacencies.size > 0 ? "Occupied Adjacencies: " + zone.occupied_adjacencies.size : "" ) + ". Is " + ( zone.is_enabled ? "" : "not " ) + "enabled" );
    }
    
    var_d680a31029367088 = zombie_attractor_manager::function_c9d17cad763ffcf1();
    line_i = 0;
    
    while ( line_i < var_d680a31029367088.size )
    {
        logstring( var_d680a31029367088[ line_i ] );
        line_i += 1;
    }
    
    foreach ( enemy in round_enemies )
    {
        printbt( enemy );
    }
    
    foreach ( statement in screen_statements )
    {
        iprintlnbold( statement );
        wait 1;
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x9b7a407f, Offset: 0x990c
// Size: 0x5b
function private function_3ac3ea659894a1a7( roundnumber )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 3 );
    
    if ( zombie_emergence_spawning::function_5b6b730e9f21cb98( roundnumber ) && !is_special_round( roundnumber ) )
    {
        callback::add( "in_playable_space", &function_5455231d3a8aceba );
    }
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x8ea0d45c, Offset: 0x996f
// Size: 0x24
function private function_5455231d3a8aceba( params )
{
    zombie_emergence_spawning::enable_emergence_spawning();
    callback::remove( "in_playable_space", &function_5455231d3a8aceba );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xfabf9ef6, Offset: 0x999b
// Size: 0x154
function private record_zombie_spawn( zombie )
{
    assert( isalive( zombie ) );
    level.var_a009ab14ee0d3223.var_939db9ccafac43a7[ level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size ] = zombie;
    var_f032ae6bea6d620a = get_quarter();
    var_5d22771d0507d04d = level.var_a009ab14ee0d3223.var_324c4d9ffb7372af.size;
    var_d972a9638d02b2b2 = var_5d22771d0507d04d > 0 ? level.var_a009ab14ee0d3223.var_324c4d9ffb7372af[ var_5d22771d0507d04d - 1 ] : undefined;
    
    if ( !isdefined( var_d972a9638d02b2b2 ) || var_d972a9638d02b2b2.subclass != zombie.subclass || var_d972a9638d02b2b2.var_f032ae6bea6d620a != var_f032ae6bea6d620a )
    {
        var_643a400bf96456dd = { #var_f032ae6bea6d620a:var_f032ae6bea6d620a, #count:1, #subclass:zombie.subclass };
        level.var_a009ab14ee0d3223.var_324c4d9ffb7372af[ level.var_a009ab14ee0d3223.var_324c4d9ffb7372af.size ] = var_643a400bf96456dd;
        return;
    }
    
    var_d972a9638d02b2b2.count += 1;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0x61465975, Offset: 0x9af7
// Size: 0x105
function private function_32251af20b0b90d7( order_structs )
{
    order_string = "";
    previous_quarter = undefined;
    var_b07c4857b6f98458 = 2000;
    
    for ( order_i = 0; order_i < order_structs.size ; order_i++ )
    {
        var_f6331acff700bea2 = "";
        order_struct = order_structs[ order_i ];
        
        if ( order_struct.var_f032ae6bea6d620a != previous_quarter )
        {
            var_f6331acff700bea2 += " \tQ" + order_struct.var_f032ae6bea6d620a;
            previous_quarter = order_struct.var_f032ae6bea6d620a;
        }
        
        subclass = utility::string_replace( order_struct.subclass, "zombie_", "" );
        var_f6331acff700bea2 += " " + subclass + "*" + order_struct.count;
        
        if ( order_string.size + var_f6331acff700bea2.size > var_b07c4857b6f98458 )
        {
            order_string += "[STRING CAPPED]";
            break;
        }
        
        order_string += var_f6331acff700bea2;
    }
    
    return order_string;
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x7254435, Offset: 0x9c05
// Size: 0x1fb
function private function_4d3da95ccef4d3b4()
{
    assert( isdefined( level.var_a009ab14ee0d3223.var_a3329f530fbfad0b ) );
    
    if ( level.var_a009ab14ee0d3223.var_a3329f530fbfad0b.size > 500 )
    {
        return;
    }
    
    round_number = zm_round_logic::get_rb_round_number();
    level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ] = [];
    
    if ( !isdefined( level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ "total" ] ) )
    {
        level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ][ "total" ] = level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size;
    }
    
    if ( !isdefined( level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ "order" ] ) )
    {
        level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ][ "order" ] = function_32251af20b0b90d7( level.var_a009ab14ee0d3223.var_324c4d9ffb7372af );
    }
    
    for ( order_i = 0; order_i < level.var_a009ab14ee0d3223.var_324c4d9ffb7372af.size ; order_i++ )
    {
        var_f6331acff700bea2 = "";
        order_struct = level.var_a009ab14ee0d3223.var_324c4d9ffb7372af[ order_i ];
        
        if ( !isdefined( level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ][ order_struct.subclass ] ) )
        {
            level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ][ order_struct.subclass ] = 0;
        }
        
        level.var_a009ab14ee0d3223.var_a3329f530fbfad0b[ round_number ][ order_struct.subclass ] += order_struct.count;
    }
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xc49cd0d4, Offset: 0x9e08
// Size: 0x48c
function function_e203a9f62c731ba4( var_3050cf7bebc83d0d, var_8e32fd7b7404774b )
{
    var_d62428024efd59c2 = [];
    var_d62428024efd59c2[ "total" ] = 0;
    var_76c864a501f29b58 = 1;
    var_afec73b6a54579e8 = "";
    var_3489c5b7073b0352 = "";
    var_664dda53b3e8f906 = [];
    var_ae67b853e899c2bc = [];
    
    foreach ( round_number, var_749612b930527b45 in level.var_a009ab14ee0d3223.var_a3329f530fbfad0b )
    {
        foreach ( subclass, count in var_749612b930527b45 )
        {
            if ( !isdefined( var_d62428024efd59c2[ subclass ] ) && subclass != "order" )
            {
                var_d62428024efd59c2[ subclass ] = var_76c864a501f29b58;
                var_76c864a501f29b58++;
            }
        }
    }
    
    var_d62428024efd59c2[ "order" ] = var_76c864a501f29b58;
    var_76c864a501f29b58++;
    
    foreach ( round_number, var_749612b930527b45 in level.var_a009ab14ee0d3223.var_a3329f530fbfad0b )
    {
        var_f0ceac5d0486d9f2 = [];
        
        for ( subclass_i = 0; subclass_i < var_76c864a501f29b58 ; subclass_i++ )
        {
            var_f0ceac5d0486d9f2[ subclass_i ] = 0;
        }
        
        foreach ( subclass, count in var_749612b930527b45 )
        {
            var_f0ceac5d0486d9f2[ var_d62428024efd59c2[ subclass ] ] = count;
        }
        
        var_afec73b6a54579e8 = string( round_number ) + ",";
        var_3489c5b7073b0352 = string( round_number ) + ":\t\t\t";
        
        foreach ( count in var_f0ceac5d0486d9f2 )
        {
            var_afec73b6a54579e8 += string( count ) + ",";
            var_3489c5b7073b0352 += string( count ) + "\t\t";
        }
        
        var_664dda53b3e8f906[ var_664dda53b3e8f906.size ] = var_afec73b6a54579e8;
        var_ae67b853e899c2bc[ var_ae67b853e899c2bc.size ] = var_3489c5b7073b0352;
    }
    
    var_234761f7f3a3cf59 = "Round Number,";
    var_9f36dff792492e3f = "Round Number|\t\t";
    
    for ( column_i = 0; column_i < var_d62428024efd59c2.size ; column_i++ )
    {
        subclass = function_f02c63b99c9614c9( var_d62428024efd59c2, column_i );
        var_234761f7f3a3cf59 += subclass + ",";
        var_9f36dff792492e3f += subclass + "\t";
    }
    
    /#
        if ( var_8e32fd7b7404774b )
        {
            filenum = openfile( "<dev string:x21a>", "<dev string:x23a>" );
            fprintln( filenum, var_234761f7f3a3cf59 );
            
            foreach ( printed_line in var_664dda53b3e8f906 )
            {
                fprintln( filenum, printed_line );
            }
            
            closefile( filenum );
        }
    #/
    
    if ( var_3050cf7bebc83d0d )
    {
        logstring( "Printing Zombie Spawned History! A history of how many of each subclass were spawned in each round." );
        logstring( var_9f36dff792492e3f );
        
        foreach ( printed_line in var_ae67b853e899c2bc )
        {
            logstring( printed_line );
        }
        
        logstring( "-----------------------------------------------------" );
    }
}

// Namespace zm_round_spawning
// Params 3
// Checksum 0x7c626656, Offset: 0xa29c
// Size: 0x2c3
function function_8c0a8afe0779b82a( var_7e63715f16cd9f90, var_2adb7ed2ac62897d, min_elite_round_appearance = 0 )
{
    rounddiff = var_2adb7ed2ac62897d - var_7e63715f16cd9f90;
    
    if ( ( rounddiff > 1 || rounddiff < 0 ) && isdefined( level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b ) )
    {
        foreach ( index, eliteentry in level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b )
        {
            if ( var_2adb7ed2ac62897d > eliteentry.var_aec029c0c07f2f6e )
            {
                numplayers = level.players.size;
                
                if ( var_2adb7ed2ac62897d >= eliteentry.var_dcf519ba5ddfcb9e )
                {
                    cooldownmin = eliteentry.var_a30fe78ee3022427;
                    cooldownmax = eliteentry.var_a332d58ee3284449;
                    
                    if ( numplayers > 1 )
                    {
                        cooldownmin = eliteentry.var_3708b6dda0c9ac40;
                        cooldownmax = eliteentry.var_36e5ccdda0a394ea;
                    }
                }
                else
                {
                    cooldownmin = eliteentry.var_5aa2b29a430b14d9;
                    cooldownmax = eliteentry.var_5a7fc49a42e4f4b7;
                    
                    if ( numplayers > 1 )
                    {
                        cooldownmin = eliteentry.var_c3a7b23c3e2683a6;
                        cooldownmax = eliteentry.var_c3cac43c3e4cf2f4;
                    }
                }
                
                var_bed174c26f31d8c7 = int( ceil( ( var_2adb7ed2ac62897d - eliteentry.var_aec029c0c07f2f6e ) / cooldownmax * cooldownmax + eliteentry.var_aec029c0c07f2f6e ) );
                level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_bed174c26f31d8c7 = maxint( min_elite_round_appearance, var_bed174c26f31d8c7 );
                var_f0d5313e587c32e5 = 1;
                
                if ( cooldownmax > 0 )
                {
                    var_f0d5313e587c32e5 += int( floor( ( var_2adb7ed2ac62897d - eliteentry.var_aec029c0c07f2f6e - 1 ) / cooldownmax ) );
                }
                
                level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_528de2fdf1c1a9d9 = maxint( level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_528de2fdf1c1a9d9, var_f0d5313e587c32e5 );
                continue;
            }
            
            if ( var_2adb7ed2ac62897d <= eliteentry.var_aec029c0c07f2f6e )
            {
                level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_bed174c26f31d8c7 = 0;
                level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_528de2fdf1c1a9d9 = 0;
            }
        }
    }
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x731d1798, Offset: 0xa567
// Size: 0x116
function function_30c3e881d71480cb()
{
    var_205e996bb3dd6f70 = 0;
    
    foreach ( index, eliteentry in level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b )
    {
        next_round_appearance = level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_bed174c26f31d8c7;
        
        if ( level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_cea9d3c969c0d633 > next_round_appearance )
        {
            next_round_appearance = level.var_a009ab14ee0d3223.var_589c7ca7401c3f6b[ index ].var_cea9d3c969c0d633;
        }
        
        if ( next_round_appearance > 0 && ( var_205e996bb3dd6f70 == 0 || next_round_appearance < var_205e996bb3dd6f70 ) )
        {
            var_205e996bb3dd6f70 = next_round_appearance;
        }
    }
    
    return var_205e996bb3dd6f70;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0x879c852f, Offset: 0xa686
// Size: 0x163
function function_72b3db5fc2b7d929( roundnumber )
{
    for ( roundcount = 1; roundcount < roundnumber ; roundcount++ )
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ roundcount ] ) )
        {
            specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ roundcount ];
            numplayers = level.players.size;
            
            if ( isdefined( specialroundstruct.specialroundname ) )
            {
                specialroundname = specialroundstruct.specialroundname;
                paramsstruct = spawnstruct();
                level.var_a009ab14ee0d3223.var_90e1d244c1410109[ specialroundname ]++;
                
                if ( specialroundstruct.var_e28b1bf3be5e30f2 != 0 && specialroundstruct.var_e26825f3be37ff38 != 0 )
                {
                    var_8c9f25be7256357d = 0;
                    
                    if ( numplayers > 1 )
                    {
                        var_8c9f25be7256357d = randomintrange( specialroundstruct.var_16f342b397743f5, specialroundstruct.var_1921e2b399d5b4b + 1 );
                        var_8c9f25be7256357d = roundcount + var_8c9f25be7256357d;
                    }
                    else
                    {
                        var_8c9f25be7256357d = randomintrange( specialroundstruct.var_e28b1bf3be5e30f2, specialroundstruct.var_e26825f3be37ff38 + 1 );
                        var_8c9f25be7256357d = roundcount + var_8c9f25be7256357d;
                    }
                    
                    paramsstruct = specialroundstruct;
                    schedule_special_round( var_8c9f25be7256357d, paramsstruct );
                }
            }
            
            level.var_a009ab14ee0d3223.specialroundspawns[ roundcount ] = undefined;
        }
    }
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x3e0b457e, Offset: 0xa7f1
// Size: 0x5f
function private get_zombies_left_to_spawn()
{
    left_to_spawn = 0;
    
    if ( level.var_a009ab14ee0d3223.state == 1 )
    {
        left_to_spawn = level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 - level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size;
        left_to_spawn += zm_cleanup_manager::get_pending_respawn_count();
    }
    
    return left_to_spawn;
}

// Namespace zm_round_spawning
// Params 0, eflags: 0x4
// Checksum 0x1a39a7d0, Offset: 0xa859
// Size: 0xa3
function private get_scene_ai()
{
    scene_ai_count = 0;
    ai_array = getaiarray();
    
    foreach ( ai in ai_array )
    {
        if ( ai utility::ent_flag( "scene_active" ) && isalive( ai ) )
        {
            scene_ai_count++;
        }
    }
    
    return scene_ai_count;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xb48f27ff, Offset: 0xa905
// Size: 0x17
function function_7dc7e5157b1cdad1( var_4ddf16922d664613 )
{
    level.var_d61fcb760217368 = var_4ddf16922d664613;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0xe5b91b35, Offset: 0xa924
// Size: 0xc
function function_2f0d03da6725e4b9()
{
    level.var_d61fcb760217368 = undefined;
}

// Namespace zm_round_spawning
// Params 1
// Checksum 0xd75880d3, Offset: 0xa938
// Size: 0x16
function function_47a0f02e6a5d5987( var_4ddf16922d664613 )
{
    level thread function_ea9c46c2fb0106ae( var_4ddf16922d664613 );
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xa28499f9, Offset: 0xa956
// Size: 0x59
function private function_ea9c46c2fb0106ae( var_4ddf16922d664613 )
{
    var_6c5c84b1440d1698 = 10;
    utility::flag_wait_or_timeout( "zm_round_spawning_init_data_done", var_6c5c84b1440d1698 );
    assert( utility::flag( "<dev string:x240>" ), "<dev string:x261>" );
    level.var_a009ab14ee0d3223.var_d685b0049c84326 = var_4ddf16922d664613;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0x4d590bba, Offset: 0xa9b7
// Size: 0x16b
function function_c134fd55f45903e6( default_spawn_list, var_4f62464f67ccc67a = 0 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( default_spawn_list ) )
    {
        assertmsg( "<dev string:x2cb>" );
        default_spawn_list = %"zmroundspawning:zm_t10_base_round_spawning";
    }
    
    utility::flag_wait( "init_global_scriptbundles" );
    
    if ( var_4f62464f67ccc67a )
    {
        level.var_fc24bbdd34d2b120 = default_spawn_list;
        return;
    }
    
    var_cd16a2e74383ea61 = getactivemapinfobundle();
    round_spawning_bundle = var_cd16a2e74383ea61.var_75f8c609c8020440;
    zmgametypebundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_zm_mode" );
    
    if ( isdefined( zmgametypebundle ) && isdefined( zmgametypebundle.var_472fd4068b8056da ) )
    {
        foreach ( var_94d95820bd24ff04 in zmgametypebundle.var_472fd4068b8056da )
        {
            if ( var_94d95820bd24ff04.mapname == level.mapname )
            {
                round_spawning_bundle = var_94d95820bd24ff04.var_79915cd9ee0ba5d7;
                break;
            }
        }
    }
    
    if ( isdefined( round_spawning_bundle ) )
    {
        level.var_fc24bbdd34d2b120 = round_spawning_bundle;
        return;
    }
    
    level.var_fc24bbdd34d2b120 = default_spawn_list;
}

// Namespace zm_round_spawning
// Params 2
// Checksum 0xba8bb9c0, Offset: 0xab2a
// Size: 0x7e, Type: bool
function function_4564514496724003( zombie, n_max_zombies_remaining = 1 )
{
    if ( !isdefined( zombie ) )
    {
        return false;
    }
    
    var_b59eb37aae4d0c35 = has_round_spawning_completed();
    var_8ed8cb5b7d4dda66 = zm_cleanup_manager::get_pending_respawn_count() == 0;
    
    if ( var_b59eb37aae4d0c35 && var_8ed8cb5b7d4dda66 )
    {
        round_zombies = get_round_enemies();
        
        if ( round_zombies.size <= n_max_zombies_remaining && arraycontains( round_zombies, zombie ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_round_spawning
// Params 0
// Checksum 0x516d822f, Offset: 0xabb1
// Size: 0x5c
function function_f8f9048f8658271c()
{
    if ( !has_round_spawning_completed() )
    {
        return ( level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 - level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size );
    }
    
    var_82cadc6297506f64 = zm_cleanup_manager::get_pending_respawn_count();
    round_zombies = get_round_enemies();
    return var_82cadc6297506f64 + round_zombies.size;
}

// Namespace zm_round_spawning
// Params 1, eflags: 0x4
// Checksum 0xe309a899, Offset: 0xac16
// Size: 0x7c
function private function_de48159d01090b97( aitype )
{
    if ( isfunction( level.var_824b6ad533e38010 ) )
    {
        zombie = [[ level.var_824b6ad533e38010 ]]( aitype );
    }
    else if ( level.mapinfobundle.var_b7bdaf6a2a733aaa && arraycontains( level.var_d24e66b3dd54be4a, aitype ) )
    {
        zombie = zone_spawner::spawn_single_dog( aitype );
    }
    else
    {
        zombie = agent_spawner::spawn_agent( aitype, 1 );
    }
    
    return zombie;
}

/#

    // Namespace zm_round_spawning
    // Params 0
    // Checksum 0xd2a2474f, Offset: 0xac9b
    // Size: 0x108, Type: dev
    function function_cedaa81b5fa233c6()
    {
        waitframe();
        devgui::function_9082edeb5db93280( "<dev string:x300>" );
        devgui::add_devgui_func( "<dev string:x30f>", "<dev string:x31f>", &toggle_ai_count );
        devgui::add_devgui_func( "<dev string:x32f>", "<dev string:x345>", &function_9f5011347fc77821 );
        devgui::add_devgui_func( "<dev string:x35b>", "<dev string:x36e>", &toggle_player_info );
        devgui::add_devgui_func( "<dev string:x381>", "<dev string:x3a4>", &function_a9cfd92c53820c2c );
        devgui::add_devgui_func( "<dev string:x3ca>", "<dev string:x3fe>", &function_6a275bad9ae21aca );
        devgui::add_devgui_func( "<dev string:x43d>", "<dev string:x45c>", &function_823fb6c9844ab576 );
        devgui::add_devgui_func( "<dev string:x48f>", "<dev string:x4a5>", &turn_on_spawn_closet_sound );
        devgui::add_devgui_func( "<dev string:x4c0>", "<dev string:x4d7>", &turn_off_spawn_closet_sound );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x4f3>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4fa>", "<dev string:x513>", &function_87e50579575db5bf );
        devgui::function_cd4e263c1f3018ae( "<dev string:x54d>", "<dev string:x565>", &function_87e50579575db5bf );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_round_spawning
    // Params 1
    // Checksum 0x32f001fb, Offset: 0xadab
    // Size: 0x31, Type: dev
    function function_87e50579575db5bf( params )
    {
        var_40fbc79658a286a8 = params[ 0 ];
        level thread overlord::playevent( var_40fbc79658a286a8, level.players );
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x53575841, Offset: 0xade4
    // Size: 0x4d, Type: dev
    function private toggle_ai_count()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x5a6>", @"hash_3a3fc6ca48dc23f5" );
        end_notify = "<dev string:x5be>";
        
        if ( getdvarint( @"hash_3a3fc6ca48dc23f5" ) )
        {
            level thread zombie_ai_count( end_notify );
            return;
        }
        
        level notify( end_notify );
    }

    // Namespace zm_round_spawning
    // Params 1, eflags: 0x4
    // Checksum 0x525813ec, Offset: 0xae39
    // Size: 0x1a4, Type: dev
    function private zombie_ai_count( end_notify )
    {
        level endon( #"game_ended" );
        
        if ( isdefined( end_notify ) )
        {
            level endon( end_notify );
        }
        
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        player_team = level.player.team;
        
        while ( true )
        {
            var_bdae620cc1b9c4e = get_round_enemies().size;
            var_e6865d8e9d5eaeb6 = get_zombies_left_to_spawn();
            var_c6644d95c058c82 = agent_utility::getnumactiveagents();
            scene_ai_count = get_scene_ai();
            active_zombie_count = zm_utility::get_active_zombies_count();
            x = 600;
            y = 250;
            font_scale = 1.5;
            info = "<dev string:x5d2>" + var_c6644d95c058c82;
            printtoscreen2d( x, y, info, ( 1, 1, 1 ), font_scale );
            y += 50;
            info = "<dev string:x5eb>" + var_bdae620cc1b9c4e;
            printtoscreen2d( x, y, info, ( 1, 0, 0 ), font_scale );
            y += 30;
            info = "<dev string:x5fc>" + var_e6865d8e9d5eaeb6;
            printtoscreen2d( x, y, info, ( 1, 0, 0 ), font_scale );
            y += 50;
            info = "<dev string:x615>" + scene_ai_count;
            printtoscreen2d( x, y, info, ( 0.5, 0.5, 1 ), font_scale );
            y += 30;
            info = "<dev string:x635>" + active_zombie_count;
            printtoscreen2d( x, y, info, ( 0.5, 0.5, 1 ), font_scale );
            waitframe();
        }
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xf2465b4a, Offset: 0xafe5
    // Size: 0x4d, Type: dev
    function private function_9f5011347fc77821()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x65c>", @"hash_b600b21cb8ad12ed" );
        end_notify = "<dev string:x67a>";
        
        if ( getdvarint( @"hash_b600b21cb8ad12ed" ) )
        {
            level thread function_65612cb7e85955f8( end_notify );
            return;
        }
        
        level notify( end_notify );
    }

    // Namespace zm_round_spawning
    // Params 1, eflags: 0x4
    // Checksum 0xfb65ee0e, Offset: 0xb03a
    // Size: 0x12f, Type: dev
    function private function_65612cb7e85955f8( end_notify )
    {
        level endon( #"game_ended" );
        level endon( end_notify );
        frame_delta = 10;
        
        while ( true )
        {
            all = getaispeciesarray( "<dev string:x694>", "<dev string:x698>" );
            
            foreach ( ai in all )
            {
                if ( isalive( ai ) )
                {
                    text_pos = ai.origin;
                    spd_text = ai function_77c767a697575ded();
                    print3d( text_pos, spd_text + "<dev string:x69f>" + ai.health, ( 0.2, 1, 0.2 ), 1, 0.5, frame_delta );
                }
            }
            
            for ( i = 0; i < frame_delta ; i++ )
            {
                waitframe();
            }
        }
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xe7cc1e47, Offset: 0xb171
    // Size: 0x4d, Type: dev
    function private toggle_player_info()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x6a1>", @"hash_18105cf216b07e87" );
        end_notify = "<dev string:x6bc>";
        
        if ( getdvarint( @"hash_18105cf216b07e87" ) )
        {
            level thread watch_player_info( end_notify );
            return;
        }
        
        level notify( end_notify );
    }

    // Namespace zm_round_spawning
    // Params 1, eflags: 0x4
    // Checksum 0x5e2f702b, Offset: 0xb1c6
    // Size: 0x13a, Type: dev
    function private watch_player_info( end_notify )
    {
        level endon( #"game_ended" );
        level endon( end_notify );
        frame_delta = 10;
        
        while ( true )
        {
            line_i = 0;
            
            if ( isdefined( level.all_player_info ) )
            {
                foreach ( var_12688b133dcd9924 in level.all_player_info )
                {
                    if ( isalive( var_12688b133dcd9924.player ) )
                    {
                        printtoscreen2d( 30, 30 + line_i * 10, "<dev string:x6d3>" + var_12688b133dcd9924.player.name + "<dev string:x6dc>" + var_12688b133dcd9924.num_zombies, ( 1, 0, 0 ), undefined, frame_delta );
                    }
                    
                    line_i += 1;
                }
            }
            
            for ( i = 0; i < frame_delta ; i++ )
            {
                waitframe();
            }
        }
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xa60e340b, Offset: 0xb308
    // Size: 0x46, Type: dev
    function private function_77c767a697575ded()
    {
        spd = self aigettargetspeed();
        
        if ( spd < 36 )
        {
            return "<dev string:x6eb>";
        }
        
        if ( spd < 71 )
        {
            return "<dev string:x6f0>";
        }
        
        if ( spd < 237 )
        {
            return "<dev string:x6f4>";
        }
        
        return "<dev string:x6fb>";
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x7c6b284d, Offset: 0xb356
    // Size: 0x18b, Type: dev
    function private function_a9cfd92c53820c2c()
    {
        contents = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0 );
        lostrace = physics_raycast( level.players[ 0 ] geteye(), devgui::function_97024c0a6d1256a6(), contents, [ level.players[ 0 ] ], 0, "<dev string:x704>" );
        
        if ( lostrace.size > 0 )
        {
            closest_spawn_point = utility::get_array_of_closest( lostrace[ 0 ][ "<dev string:x719>" ], level.zone_spawn_locations )[ 0 ];
        }
        else
        {
            closest_spawn_point = utility::get_array_of_closest( level.players[ 0 ].origin, level.zone_spawn_locations )[ 0 ];
        }
        
        foreach ( ai_subclass in closest_spawn_point.ai_subclasses )
        {
            zombie = force_spawn_agent( ai_subclass, closest_spawn_point );
            
            if ( isdefined( zombie ) )
            {
                if ( isdefined( level.var_3c6a4eee7184de4e ) )
                {
                    zombie [[ level.var_3c6a4eee7184de4e ]]();
                }
                else
                {
                    set_spawned_zombies_move_speed( zombie, 1 );
                }
                
                zombie.var_825b17c932865df = 1;
                zombie.ignore_enemy_count = 1;
            }
            
            wait 4;
        }
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x9116a31f, Offset: 0xb4e9
    // Size: 0x31f, Type: dev
    function private function_6a275bad9ae21aca()
    {
        roundnumber = zm_round_logic::get_rb_round_number();
        var_64a6b24ca8582470 = 0;
        contents = trace::create_contents( 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0 );
        lostrace = physics_raycast( level.players[ 0 ] geteye(), devgui::function_97024c0a6d1256a6(), contents, [ level.players[ 0 ] ], 0, "<dev string:x704>" );
        
        if ( lostrace.size > 0 )
        {
            closest_spawn_point = utility::get_array_of_closest( lostrace[ 0 ][ "<dev string:x719>" ], level.zone_spawn_locations )[ 0 ];
        }
        else
        {
            closest_spawn_point = utility::get_array_of_closest( level.players[ 0 ].origin, level.zone_spawn_locations )[ 0 ];
        }
        
        var_64a6b24ca8582470 = istrue( level.var_a009ab14ee0d3223.isspecialround );
        
        foreach ( ai_subclass in closest_spawn_point.ai_subclasses )
        {
            ai_type = function_b3988325430ce242( ai_subclass );
            
            if ( level.var_a009ab14ee0d3223.isspecialround )
            {
                if ( var_64a6b24ca8582470 )
                {
                    if ( namespace_c7157c2cd884c5d5::function_cfe336af64fbc449( level.var_a009ab14ee0d3223.specialroundspawns[ roundnumber ].ailist, ai_type ) )
                    {
                        zombie = force_spawn_agent( ai_subclass, closest_spawn_point );
                        
                        if ( isdefined( zombie ) )
                        {
                            set_spawned_zombies_move_speed( zombie, 1 );
                            zombie.var_825b17c932865df = 1;
                            zombie.ignore_enemy_count = 1;
                        }
                    }
                }
            }
            
            if ( !var_64a6b24ca8582470 )
            {
                var_b8419a4ddf0383ef = function_4ed4fdc352e66c9( roundnumber );
                var_462f6aba113cd52c = 0;
                
                if ( isdefined( var_b8419a4ddf0383ef.exclusionlist ) )
                {
                    foreach ( exclude in var_b8419a4ddf0383ef.exclusionlist )
                    {
                        if ( ai_type == exclude.aitype )
                        {
                            var_462f6aba113cd52c = 1;
                        }
                    }
                }
                
                if ( !var_462f6aba113cd52c )
                {
                    if ( namespace_c7157c2cd884c5d5::function_cfe336af64fbc449( var_b8419a4ddf0383ef.ailist, ai_type ) )
                    {
                        zombie = force_spawn_agent( ai_subclass, closest_spawn_point );
                        
                        if ( isdefined( zombie ) )
                        {
                            if ( isdefined( level.var_3c6a4eee7184de4e ) )
                            {
                                zombie thread [[ level.var_3c6a4eee7184de4e ]]();
                            }
                            else
                            {
                                set_spawned_zombies_move_speed( zombie, 1 );
                            }
                            
                            zombie.var_825b17c932865df = 1;
                            zombie.ignore_enemy_count = 1;
                        }
                    }
                }
            }
            
            wait 4;
        }
    }

    // Namespace zm_round_spawning
    // Params 2, eflags: 0x4
    // Checksum 0xb0587f86, Offset: 0xb810
    // Size: 0xbf, Type: dev
    function private force_spawn_agent( ai_type, spawn_loc )
    {
        spawn_pos = spawn_loc.origin;
        spawn_angles = spawn_loc.angles ?? ( 0, 0, 0 );
        
        if ( !isdefined( spawn_loc.script_animation ) )
        {
            spawn_pos = getgroundposition( spawn_loc.origin, 32 );
        }
        
        agent = agent_manager::spawn_agent( ai_type, spawn_pos, spawn_angles );
        
        if ( isdefined( agent ) )
        {
            agent thread zone_spawner::function_ce10e453e7f7bb8e( spawn_loc, spawn_pos );
        }
        
        roundnumber = zm_round_logic::get_rb_round_number();
        
        if ( isdefined( agent ) )
        {
            agent thread function_3ac3ea659894a1a7( roundnumber );
        }
        
        return agent;
    }

    // Namespace zm_round_spawning
    // Params 0, eflags: 0x4
    // Checksum 0x330f935c, Offset: 0xb8d7
    // Size: 0x311, Type: dev
    function private function_823fb6c9844ab576()
    {
        pause_round_spawning( 1, "<dev string:x722>" );
        zm_utility::util_kill_all_zombies();
        logstring( "<dev string:x735>" );
        time_start = gettime();
        max_num_zombies = getmaxagents();
        current_num_zombies = 0;
        spawner_index = 0;
        agents = [];
        adddebugcommand( "<dev string:x773>" );
        
        while ( spawner_index < level.zone_spawn_locations.size )
        {
            spawn_point = level.zone_spawn_locations[ spawner_index ];
            
            if ( agents.size + spawn_point.ai_subclasses.size <= max_num_zombies )
            {
                foreach ( ai_subclass in spawn_point.ai_subclasses )
                {
                    zombie = force_spawn_agent( ai_subclass, spawn_point );
                    
                    if ( isdefined( zombie ) )
                    {
                        if ( isdefined( level.var_3c6a4eee7184de4e ) )
                        {
                            zombie [[ level.var_3c6a4eee7184de4e ]]();
                        }
                        else
                        {
                            set_spawned_zombies_move_speed( zombie, 1 );
                        }
                        
                        zombie.var_825b17c932865df = 1;
                        zombie val::set( "<dev string:x783>", "<dev string:x793>", 1 );
                        zombie.ignore_enemy_count = 1;
                        zombie.spawn_point = spawn_point;
                        agents[ agents.size ] = zombie;
                    }
                    
                    waitframe();
                }
                
                spawner_index++;
                continue;
            }
            
            wait 60;
            
            foreach ( zombie in agents )
            {
                closest_point = getclosestpointonnavmesh( zombie.origin );
                var_e74491998fec1a5 = distancesquared( zombie.origin, closest_point );
                
                if ( var_e74491998fec1a5 > 65536 )
                {
                    assert( isdefined( zombie.subclass ), "<dev string:x7a2>" );
                    assert( isdefined( zombie.spawn_point.origin ), "<dev string:x7e8>" );
                    logstring( "<dev string:x831>" + zombie.subclass + "<dev string:x84a>" + zombie.spawn_point.origin + "<dev string:x857>" );
                }
                
                zombie kill();
                waitframe();
            }
            
            agents = [];
        }
        
        adddebugcommand( "<dev string:x8a9>" );
        zm_utility::util_kill_all_zombies();
        time_elapsed = ( gettime() - time_start ) / 1000;
        pause_round_spawning( 0, "<dev string:x722>" );
        logstring( "<dev string:x8b9>" + time_elapsed + "<dev string:x90a>" );
    }

    // Namespace zm_round_spawning
    // Params 0
    // Checksum 0x6b211ecd, Offset: 0xbbf0
    // Size: 0xe, Type: dev
    function turn_on_spawn_closet_sound()
    {
        change_spawn_closet_sound( 1 );
    }

    // Namespace zm_round_spawning
    // Params 0
    // Checksum 0x8c9aacd9, Offset: 0xbc06
    // Size: 0xd, Type: dev
    function turn_off_spawn_closet_sound()
    {
        change_spawn_closet_sound( 0 );
    }

#/
