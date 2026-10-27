// scripts\mp\br\gametypes\br_elite_broken_arrow.gsc  (hash_615b2c8d8d9d50db.gscc) (size: 186698 Bytes / 0x2d94a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa94aa66 (177515110)
// size ...... 186698 (0x2d94a)
// includes .. 69  (offset: 0x2c286)
// strings ... 292 (offset: 0x2c4ae)
// dev strs .. 38  (offset: 0x2d762)
// exports ... 552 (offset: 0x1ed92)
// cseg ...... 0x1904 + 0x1d48e (0x1ed92)
// imports ... 987 (offset: 0x243d2)
// animtree1 . 0   (offset: 0x2d94a)
// animtree2 . 0   (offset: 0x2d94a)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\swim_common;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_accolades;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_cq;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\nuke;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\music_br;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\weapons;

#namespace br_elite_broken_arrow;

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa28e3ce4, Offset: 0x1922
// Size: 0x3f2
function getcontractdata( data )
{
    if ( level.mapname == "mp_br_mechanics" )
    {
        function_585d459abe0c6a7();
    }
    
    if ( !getdvarint( @"scr_br_elite_broken_arrow", 0 ) || !level.gametypebundle.var_8feab651d46d21e7 )
    {
        data.enabled = 0;
        return;
    }
    
    level.arrow = spawnstruct();
    level.arrow.props = spawnstruct();
    level._effect[ "arrow_nuke_screen" ] = loadfxasset( "vfx_iw9_br_gameplay_champ_nuke_screen_flash" );
    level._effect[ "arrow_plutonium_far" ] = loadfxasset( "vfx_iw9_br_gameplay_champ_plutonium_screen_effect_far" );
    level._effect[ "arrow_plutonium_close" ] = loadfxasset( "vfx_iw9_br_gameplay_champ_plutonium_screen_effect_close" );
    function_45e9bdb9b4ecbbf7();
    arrow_initdvars();
    function_e5368bef9c22c1ae();
    arrow_initvo();
    data.funcs[ "onInit" ] = &arrow_oninit;
    data.funcs[ "onTeamAssigned" ] = &arrow_onteamassigned;
    data.funcs[ "onEnterGulag" ] = &arrow_onentergulag;
    data.funcs[ "onGlobalPlayerEnterGulag" ] = &arrow_onglobalplayerentergulag;
    data.funcs[ "onPlayerRespawn" ] = &arrow_onplayerrespawn;
    data.funcs[ "onGlobalPlayerRespawn" ] = &arrow_onglobalplayerrespawn;
    data.funcs[ "onTabletHidden" ] = &arrow_ontablethidden;
    level.var_760bf54d2dd70c96 = &function_d77bd3e0d285638c;
    level.var_aabf180af06fe71a = &function_a459cb368998e5b0;
    br_pickups::function_87a5dccc82001425( &function_dd448d417736770c );
    
    /#
        utility::registersharedfunc( #"elitearrow", #"hash_8b942b2d78109e52", &arrow_debug );
        utility::registersharedfunc( #"elitearrow", #"hash_23e5e55f2d0f123", &function_c2655c68f4ad6efe );
        devgui_init();
    #/
    
    utility::registersharedfunc( #"elitearrow", #"arrow_nepshockeffecttoggle", &arrow_nepshockeffecttoggle );
    scriptable::scriptable_addusedcallback( &function_6a7a2e75d800d56 );
    scriptable::scriptable_addusedcallback( &function_f36bc70f8fd71ee2 );
    callback::add( #"player_assimilated", &function_5487bfc866ded63 );
    
    foreach ( element in level.arrow.var_8dd9f3a49590d676 )
    {
        if ( isdefined( element.elementbundle ) )
        {
            currentelement = getscriptbundle( "elitebrokenarrowelement:" + element.elementbundle );
            
            if ( isdefined( currentelement.elementpartname ) )
            {
                utility::registersharedfunc( currentelement.elementpartname, #"delete", &function_dc24dc8b54ae7458 );
            }
        }
    }
    
    level.arrow.playerdisconnects = 0;
    level.arrow.var_7a52e613a9eacadf = [];
    
    if ( level.arrow.dvars.var_b5ff2f8a6cc95fe1 || level.arrow.dvars.var_f70f16757a0b3b2a )
    {
        thread function_435bc3a80674c2f6();
    }
    
    if ( level.arrow.dvars.var_4462fd08d38349e1 > 0 || level.arrow.dvars.var_d409b4bb0cef152a > 0 )
    {
        disconnect_event_aggregator::function_11efe509aba577f7( &function_6941fc075867cd36 );
        thread function_f485cde7c7e708bf();
    }
    
    thread arrow_tabletinit();
    thread function_209d8ec78a054eb2();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3713167f, Offset: 0x1d1c
// Size: 0x1c8c
function arrow_initdvars()
{
    level.arrow.dvars = spawnstruct();
    level.arrow.dvars.enabled = getdvarint( @"scr_br_elite_broken_arrow", 0 ) && level.gametypebundle.var_8feab651d46d21e7;
    level.arrow.dvars.version = getdvarint( @"scr_br_elite_broken_arrow_version", 0 );
    level.arrow.dvars.var_91b380f71234a20d = getdvarfloat( @"hash_e943bd1371a994c1", 50 );
    
    /#
        level.arrow.dvars.debug = getdvarint( @"scr_br_elite_broken_arrow_debug", 0 );
        level.arrow.dvars.var_218ba9a171abfc61 = getdvarint( @"hash_a126c91647677603", 0 );
        level.arrow.dvars.var_ed47ca835f8cea9 = getdvarint( @"hash_1cef39174d04857d", 300 );
        level.arrow.dvars.var_3e1b7abcab66af5b = getdvarint( @"hash_bcc502d0a16c3445", 100 );
        level.arrow.dvars.debugarm = getdvarint( @"hash_987a851b8a5164f6", 0 );
        level.arrow.dvars.debugdefuse = getdvarint( @"hash_6704ce9a3ae75962", 0 );
    #/
    
    level.arrow.dvars.numspawn = getdvarint( @"hash_75ac11dbfa57f324", 2 );
    level.arrow.dvars.scriptedflow = getdvarint( @"hash_30d49880d50137ee", 0 );
    level.arrow.dvars.var_f3c59172d6694bed = getdvarint( @"hash_531a7f3580ea315f", 1 );
    level.arrow.dvars.scripttracker = getdvarint( @"scr_br_elite_broken_arrow_script_tracker", 0 );
    level.arrow.dvars.maxaccepted = getdvarint( @"hash_950c20a5c594b232", level.arrow.dvars.numspawn );
    level.arrow.dvars.maxteamsize = getdvarint( @"scr_br_elite_broken_arrow_max_team_size", 4 );
    level.arrow.dvars.var_bd900eb8315d80ec = getdvarfloat( @"hash_31cc8aeba0a944be", 30 );
    level.arrow.dvars.var_f884ce880a0744fd = getdvarint( @"hash_dcffaf5c214172dd", 780 );
    level.arrow.dvars.var_27416c0d29b8c001 = getdvarint( @"hash_500b5c733669deb4", 0 );
    level.arrow.dvars.var_707b23afaba6c546 = getdvarint( @"hash_2f036784e7ec2c72", 18 );
    level.arrow.dvars.var_baacd4425151c0bc = getdvarint( @"hash_83550ac54c009fb2", 15000 );
    level.arrow.dvars.var_6ca90e57e1ca605a = getdvarint( @"hash_10264a6f662ca430", 7500 );
    level.arrow.dvars.containermaxdist = getdvarint( @"hash_df243df1aaa96e57", 40000 );
    level.arrow.dvars.containermindist = getdvarint( @"hash_b114889265a1179", 0 );
    level.arrow.dvars.var_52cf0885d260a509 = getdvarint( @"hash_d96ad4b9762ba0bb", 210 );
    level.arrow.dvars.var_6116a6c0191cf36f = getdvarfloat( @"hash_ddfdcd24993014cf", 1 );
    level.arrow.dvars.containergastime = getdvarfloat( @"hash_dde2af24991176cb", 40 );
    level.arrow.dvars.var_414a7a4c794f435e = getdvarint( @"hash_be31a0b0f96264be", 4000 );
    level.arrow.dvars.elementorder = getdvar( @"hash_287fbe54205f4583", "ber plu tri" );
    level.arrow.dvars.elementinteract = getdvarint( @"scr_br_elite_broken_arrow_element_interact", 1 );
    level.arrow.dvars.var_4c2b59a5167af6f7 = getdvarint( @"hash_ec0d2f77c149a76f", 1 );
    level.arrow.dvars.var_480100cb7388af26 = getdvarint( @"hash_d2b336a16e9b3f70", 1 );
    level.arrow.dvars.var_d8eb38995294120d = getdvarint( @"hash_98cb40fb319bcd47", 2304 );
    level.arrow.dvars.var_9ebf173ff863acfa = getdvarfloat( @"hash_ee13f902f72541ea", 1 );
    level.arrow.dvars.elementgastime = getdvarfloat( @"hash_ee1bff02f72d3aca", 20 );
    level.arrow.dvars.var_82ccd8cc5cd2df73 = getdvarint( @"hash_a061d7692b5d643", 3000 );
    level.arrow.dvars.var_2108533c91a9051a = getdvarint( @"hash_2aa7e94f2b915238", 0 );
    level.arrow.dvars.var_f7df06d7d9e4c803 = getdvarint( @"hash_649be3f19f691ba0", 1 );
    level.arrow.dvars.var_599fe0519f5449d9 = getdvarint( @"hash_1e38e38a1534c4a2", 1 );
    level.arrow.dvars.beroutline = getdvarint( @"hash_49d4578bb39f0848", 0 );
    level.arrow.dvars.var_71c6373dc2407ed1 = getdvarfloat( @"hash_cf6f4bc73fe603d4", 9 );
    level.arrow.dvars.var_527e5dff339e2860 = getdvarfloat( @"hash_bc4ab0e1e738f53b", 0.25 );
    level.arrow.dvars.var_8aae7bc9045309cf = getdvarfloat( @"hash_d9b5475a1979ab9d", 1.5 );
    level.arrow.dvars.var_67a9db4215269074 = getdvarint( @"hash_6b82286284e9d06e", 0 );
    level.arrow.dvars.var_59c2da93265dcb51 = getdvarint( @"hash_a6cfc5544d74f7bf", 5 );
    level.arrow.dvars.var_7c7623bdbc4d94e3 = getdvarfloat( @"hash_87b5941c5fdca522", 5 );
    level.arrow.dvars.var_930cad23daeab954 = getdvarint( @"hash_d1dd4f34aada10fe", 7 );
    level.arrow.dvars.var_595e539abb7c3146 = getdvarfloat( @"hash_5f0aa90f84bbd519", 5 );
    level.arrow.dvars.var_c38b93bfb001d469 = getdvarint( @"hash_e49151992582cfb7", 12 );
    level.arrow.dvars.var_f079e6040e40d41b = getdvarfloat( @"hash_d60d231ee6dc387a", 1 );
    level.arrow.dvars.var_ebf8847e50144553 = getdvarfloat( @"hash_956fdd322faed186", 0.25 );
    level.arrow.dvars.var_c80b42d236134c96 = getdvarint( @"hash_32813e962c93acb0", 256 );
    level.arrow.dvars.var_51532f530ccac4ab = getdvarint( @"hash_7eb225ee98272551", 192 );
    level.arrow.dvars.var_bfa5c3db81f0d555 = getdvarint( @"hash_8070336039bc4225", 768 );
    level.arrow.dvars.triinteract = getdvarint( @"scr_br_elite_broken_arrow_tri_interact", 2 );
    level.arrow.dvars.triddos = getdvarint( @"hash_eac47bf2c6567180", 1 );
    level.arrow.dvars.var_29878b57801e97c8 = getdvarfloat( @"hash_d9b3475d9a51f76c", 5 );
    level.arrow.dvars.var_2405e814f3c1956a = getdvarfloat( @"hash_a24a178dac7d8a33", 0.5 );
    level.arrow.dvars.var_72f0d2d059f8c74f = getdvarint( @"hash_2a2e0be32b76ef8b", 512 );
    level.arrow.dvars.var_d01564fbfd6f7abc = getdvarint( @"hash_261f96ea4e704b78", 0 );
    level.arrow.dvars.var_cffcbd78da0597e = getdvarint( @"hash_85047abb86e552d8", 590 );
    level.arrow.dvars.var_ea16265cd84314f3 = getdvarint( @"hash_248fd1e95368aad9", 192 );
    level.arrow.dvars.var_d938274ec8d77376 = getdvarfloat( @"hash_57c3e963115a0e1b", 1.5 );
    level.arrow.dvars.var_ddb83dd5415064db = getdvarfloat( @"hash_d8ea04134343528b", 3 );
    level.arrow.dvars.var_14980829444cda9b = getdvarfloat( @"hash_ecf067efc8974734", 6 );
    level.arrow.dvars.var_307f2b966c0d9b60 = getdvarfloat( @"hash_2378e0430f4a2e9e", 1 );
    level.arrow.dvars.var_251f223896982713 = getdvarfloat( @"hash_d4d62ec2ace68362", 1 );
    level.arrow.dvars.var_6ba986d3525f2913 = getdvarfloat( @"hash_389a4bb4ee827cb8", 1 );
    level.arrow.dvars.var_e3217483ea21be21 = getdvarfloat( @"hash_f35e51324fa28be4", 1 );
    level.arrow.dvars.var_7dbbb58baeea9a86 = getdvarfloat( @"hash_4912e52003018245", 1 );
    level.arrow.dvars.var_4a3bd07e32d65e5a = getdvarfloat( @"hash_b3291f1137147c4f", 1 );
    level.arrow.dvars.var_389f987e8799d68a = getdvarfloat( @"hash_29ff5562e7d0a380", 1 );
    level.arrow.dvars.var_3b2e99088566a4b6 = getdvarfloat( @"hash_8e909710891bbdaf", 1 );
    level.arrow.dvars.var_dbffc9a45878e066 = getdvarfloat( @"hash_67576d2ae1ff56e0", 1 );
    level.arrow.dvars.var_895fdf162edf00a3 = getdvarfloat( @"hash_8058e06ca4d33991", 13 );
    level.arrow.dvars.var_70cdbdc811d1f044 = getdvarfloat( @"hash_a58e96d700307a82", 8 );
    level.arrow.dvars.var_9c16cd85f1cd9ab4 = getdvarint( @"hash_e20e4ecc3c826e9d", 2 );
    level.arrow.dvars.var_bda484f453a433a6 = getdvarfloat( @"hash_7f1b736511ea4264", 12 );
    level.arrow.dvars.var_e1796d225c2725ca = getdvarint( @"hash_4db1fd61445ed464", 250 );
    level.arrow.dvars.var_e23fd56098147d87 = getdvarint( @"hash_9670ef62e1fa2e2d", 192 );
    level.arrow.dvars.var_c60f669e1f184cbf = getdvarfloat( @"hash_6426f6e330d523e2", 0.25 );
    level.arrow.dvars.var_227e2eb87503c78 = getdvarfloat( @"hash_a8b000ede1f4d6b8", 6 );
    level.arrow.dvars.var_e53c672822a290c9 = getdvarfloat( @"hash_87f645e62d9f9b80", 3 );
    level.arrow.dvars.var_deaf70b0be3bc149 = getdvarfloat( @"hash_4367a112e7a376c9", 0.1 );
    level.arrow.dvars.triggerheightoffset = getdvarfloat( @"hash_8a828a019e16aad4", 0.33 );
    level.arrow.dvars.var_77aaeb97fa9b3582 = getdvarfloat( @"hash_789c80e8d0a7863d", 0 );
    level.arrow.dvars.var_e7de7e4b4a624c8f = getdvarfloat( @"hash_b56cee9856470dfe", 0 );
    level.arrow.dvars.circleupdaterate = getdvarfloat( @"hash_43951110b4e39deb", 3.5 );
    level.arrow.dvars.var_2c4c02a4d4c842f4 = getdvarfloat( @"hash_fcb42fbee40a2b06", 0.5 );
    level.arrow.dvars.var_62902acdceec4990 = getdvarint( @"hash_a9b91d09c8910b23", 10000 );
    level.arrow.dvars.var_8ed1deb9efe5b9dc = getdvarint( @"hash_449561f9f615fba", 4500 );
    level.arrow.dvars.var_1eef1c421251a88d = getdvarint( @"hash_fbeb3408fd066a4f", 2000 );
    level.arrow.dvars.var_54a069203cb04431 = getdvarint( @"hash_a39387848555ff92", 700 );
    level.arrow.dvars.circlerangemin = getdvarint( @"scr_br_elite_broken_arrow_circle_range_min", 500 );
    level.arrow.dvars.circlerangemax = getdvarint( @"scr_br_elite_broken_arrow_circle_range_max", 2500 );
    level.arrow.dvars.var_91ea024b6f6360f1 = getdvarint( @"hash_28853a0ecca5530c", 650 );
    level.arrow.dvars.var_fb3256c8685e21c5 = getdvarint( @"hash_26e1802cc88b7a47", 100 );
    level.arrow.dvars.circleshuffle = getdvarint( @"hash_73e7f4778ad48646", 0 );
    level.arrow.dvars.bombsitetime = getdvarfloat( @"hash_2026983afb054ba1", 300 );
    level.arrow.dvars.bombsitesupplydrop = getdvarint( @"hash_5609f399d2aed079", 1 );
    level.arrow.dvars.var_f281cea63c3a523 = getdvarint( @"hash_83026ae3da184b2d", 1000 );
    level.arrow.dvars.var_4ab57c9dda491fbc = getdvarint( @"hash_e4a0734d3e02bac7", 2000000 );
    level.arrow.dvars.var_38fe632bfb0b4121 = getdvarint( @"hash_47538600a09b3ac9", 5 );
    level.arrow.dvars.var_1e77870d7bee3a6b = getdvarint( @"hash_60ba0fd26b4a9011", 2 );
    level.arrow.dvars.var_921547e84218c101 = getdvarint( @"hash_fc67ab7bebc87864", 1 );
    level.arrow.dvars.var_7660921955d6521a = getdvarint( @"hash_f49436da08765bb8", 0 );
    level.arrow.dvars.var_d850bd84825f8570 = getdvarint( @"hash_c6e5dc7debc72eed", 90 );
    level.arrow.dvars.var_4f4d8071f74a58 = getdvarint( @"hash_96aeae237894fba7", 1 );
    level.arrow.dvars.var_3d1234eb70abf65a = getdvarint( @"hash_935a1cb445bbb32f", 400 );
    level.arrow.dvars.var_d142560e952989b6 = getdvarint( @"hash_3593a7473763ab21", 1 );
    level.arrow.dvars.var_441a1c3264b4ee0f = getdvarint( @"hash_c0ef52a5ebba31ec", 40 );
    level.arrow.dvars.var_b8c9d0ad7b90b8f4 = getdvarint( @"hash_e2be0efae70f07a1", 4 );
    level.arrow.dvars.var_edf481113abfa588 = getdvarint( @"hash_abae39b8c021549c", 5 );
    level.arrow.dvars.userate = getdvarfloat( @"hash_634f6a9f40d48eaa", 1 );
    level.arrow.dvars.usecooldown = getdvarfloat( @"hash_d5198fa240c8a729", 0.75 );
    level.arrow.dvars.var_b026358b40a9b559 = getdvarint( @"hash_303acdb7c2756320", 0 );
    level.arrow.dvars.usetoggle = getdvarint( @"hash_8d4a9c3fb764f814", 0 );
    level.arrow.dvars.armtime = getdvarfloat( @"hash_e01340aac4318f42", 10 );
    level.arrow.dvars.var_bdbf3c072faefa58 = getdvarfloat( @"hash_b287a598411c516e", -1 );
    level.arrow.dvars.armradius = getdvarint( @"hash_71bef7be698cc6c9", 128 );
    level.arrow.dvars.armheight = getdvarint( @"hash_a2ec02dedbdf4744", 128 );
    level.arrow.dvars.fusetimer = getdvarfloat( @"scr_br_elite_broken_arrow_fuse_timer", 120 );
    level.arrow.dvars.fuseradius = getdvarint( @"hash_7c55fbb1b17fe120", 90 );
    level.arrow.dvars.fuseheight = getdvarint( @"hash_7b806b03745eb1c1", 72 );
    level.arrow.dvars.defusetime = getdvarfloat( @"hash_2ae542c01753b936", 5 );
    level.arrow.dvars.var_cae49f4917631000 = getdvarfloat( @"hash_afb6ff8e5b2c0402", 0.5 );
    level.arrow.dvars.var_21dd35790b14ce1f = getdvarint( @"scr_br_elite_broken_arrow_nuke_kill_players", 1 );
    level.arrow.dvars.nukevision = getdvarint( @"scr_br_elite_broken_arrow_nuke_vision", 1 );
    level.arrow.dvars.nukewaittime = getdvarfloat( @"hash_f75dc4d887b09ec1", 18 );
    level.arrow.dvars.var_e3dccd99f0e44410 = getdvarint( @"hash_a875817690841b", 100 );
    level.arrow.dvars.var_a9c9568e8d945a9c = getdvarfloat( @"hash_984263b915f3105b", 3 );
    level.arrow.dvars.var_dee7d30029f94eaa = getdvarfloat( @"hash_ed76cdfefe71c0e9", 0.5 );
    level.arrow.dvars.var_928fc5c3171c5a69 = getdvarfloat( @"hash_a8161a2602c3e52b", 1 );
    level.arrow.dvars.var_609955ed715f765a = getdvarint( @"hash_e7cb141aea4cd049", 500 );
    level.arrow.dvars.var_ffc1d7c34cebf8b9 = getdvarint( @"hash_a6d39b5b39005af5", 100 );
    level.arrow.dvars.var_a4f0102b2a46d2be = getdvarint( @"hash_e083ac3af8de9f02", 2000 );
    level.arrow.dvars.var_a33499e8225c46ee = getdvarint( @"hash_7c7e489c5812729c", 0 );
    level.arrow.dvars.var_a3e7e36a79c9db79 = getdvarint( @"hash_3f63147e77d0ce3", 0 );
    level.arrow.dvars.jailbreakenabled = getdvarint( @"scr_br_elite_broken_jailbreak_enabled", 0 );
    level.arrow.dvars.var_ce43d9340f0375ac = getdvarint( @"hash_2262425b040ad7e8", 1 );
    level.arrow.dvars.jailbreakwaittime = getdvarfloat( @"hash_9fc3c1594145303f", 5 );
    level.arrow.dvars.skiptoken = getdvarint( @"hash_eb319c1bcb7e8ed1", 0 );
    level.arrow.dvars.var_ea64420303c90048 = getdvarint( @"scr_br_elite_broken_arrow_ending_scene", 1 );
    level.arrow.dvars.var_473b1e06b0a45c80 = getdvarint( @"hash_2c2f1cabe40e0136", 1 );
    level.arrow.dvars.var_b16c7be26c6e0d6 = getdvarint( @"hash_48232564009021f9", 1 );
    level.arrow.dvars.var_4462fd08d38349e1 = getdvarfloat( @"hash_341bdf65df749f4c", 0.6 );
    level.arrow.dvars.var_d409b4bb0cef152a = getdvarfloat( @"hash_acc933a339494f7b", 0.6 );
    level.arrow.dvars.var_b5ff2f8a6cc95fe1 = getdvarint( @"hash_dc747a5af26f03a3", 1 );
    level.arrow.dvars.var_f70f16757a0b3b2a = getdvarint( @"hash_fa5e34549d935ec8", 1 );
    level.arrow.dvars.var_7a2065a331b917ee = getdvarint( @"hash_8d45d5ac2cb027b0", 0 );
    level.arrow.dvars.var_9a7a9f46220930d6 = getdvarint( @"hash_820fcaa2fce419db", 4 );
    level.arrow.dvars.tabletdropcount = getdvarint( @"hash_d2a47b9ac759e4bc", 1 );
    level.arrow.dvars.var_20340225b81f1fe1 = getdvarfloat( @"hash_f85a1d7cf6b954be", 0 );
    level.arrow.dvars.var_2057f425b8477bcf = getdvarfloat( @"hash_f8372f7cf693349c", 0 );
    
    if ( level.arrow.dvars.var_7a2065a331b917ee )
    {
        level.arrow.dvars.maxaccepted = level.arrow.dvars.numspawn * ( level.arrow.dvars.tabletdropcount + 1 );
    }
    
    function_ca060076e1025700();
    
    /#
        if ( level.arrow.dvars.debug )
        {
            function_7df3334d3a5aa7fb();
        }
    #/
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xfa4dbfaf, Offset: 0x39b0
// Size: 0x21d
function function_ca060076e1025700()
{
    switch ( level.arrow.dvars.version )
    {
        case 1:
            level.arrow.dvars.triddos = 0;
            level.arrow.dvars.beroutline = 0;
            level.arrow.dvars.var_707b23afaba6c546 = 15;
            level.arrow.dvars.var_baacd4425151c0bc = 20000;
            level.arrow.dvars.var_6ca90e57e1ca605a = 5000;
            level.arrow.dvars.var_52cf0885d260a509 = 120;
            level.arrow.dvars.var_82ccd8cc5cd2df73 = 2500;
            level.arrow.dvars.var_bfa5c3db81f0d555 = 512;
            level.arrow.dvars.circleupdaterate = 4;
            level.arrow.dvars.var_2c4c02a4d4c842f4 = 1;
            level.arrow.dvars.var_91ea024b6f6360f1 = 500;
            level.arrow.dvars.var_fb3256c8685e21c5 = 150;
            break;
        case 2:
            level.arrow.dvars.triddos = 1;
            level.arrow.dvars.beroutline = 1;
            break;
        default:
            break;
    }
}

/#

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0x95e6508d, Offset: 0x3bd5
    // Size: 0x191, Type: dev
    function function_7df3334d3a5aa7fb()
    {
        hostplayer = gamelogic_mp::gethostplayer();
        
        if ( isdefined( hostplayer ) )
        {
            hostplayer iprintlnbold( "<dev string:x24>" );
        }
        
        level.arrow.dvars.debug = 1;
        level.arrow.dvars.scriptedflow = 0;
        level.arrow.dvars.maxaccepted = 1000;
        level.arrow.dvars.var_6ca90e57e1ca605a = 0;
        level.arrow.dvars.debugarm = 1;
        level.arrow.dvars.debugdefuse = 1;
        level.arrow.dvars.skiptoken = 1;
        level.arrow.dvars.var_218ba9a171abfc61 = 1;
        level.arrow.dvars.jailbreakenabled = 0;
        level.arrow.dvars.bombsitesupplydrop = getdvarint( @"hash_5609f399d2aed079", 1 );
        level.arrow.dvars.var_7fd196d924c628d4 = undefined;
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xc2133964, Offset: 0x3d6e
    // Size: 0x1d9, Type: dev
    function function_5621852a8ed84e2a()
    {
        hostplayer = gamelogic_mp::gethostplayer();
        
        if ( isdefined( hostplayer ) )
        {
            hostplayer iprintlnbold( "<dev string:x24>" );
        }
        
        level.arrow.dvars.debug = 0;
        level.arrow.dvars.maxaccepted = level.arrow.dvars.numspawn;
        level.arrow.dvars.var_6ca90e57e1ca605a = 7500;
        level.arrow.dvars.debugarm = 0;
        level.arrow.dvars.debugdefuse = 0;
        level.arrow.dvars.skiptoken = 0;
        level.arrow.dvars.var_218ba9a171abfc61 = 0;
        level.arrow.dvars.jailbreakenabled = 1;
        level.arrow.dvars.bombsitesupplydrop = getdvarint( @"hash_5609f399d2aed079", 1 );
        level.arrow.dvars.var_7fd196d924c628d4 = undefined;
        
        if ( level.br_circle_disabled )
        {
            level.arrow.dvars.scriptedflow = 1;
            return;
        }
        
        level.arrow.dvars.scriptedflow = 4;
    }

#/

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xfeaf9471, Offset: 0x3f4f
// Size: 0x3e
function function_585d459abe0c6a7()
{
    setdvarifuninitialized( @"scr_br_elite_broken_arrow", 1 );
    setdvarifuninitialized( @"hash_60ba0fd26b4a9011", 1 );
    
    if ( level.br_circle_disabled )
    {
        setdvarifuninitialized( @"hash_30d49880d50137ee", 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe7564fe9, Offset: 0x3f95
// Size: 0x13a
function function_a66dc41a985ac5a6( listoverride )
{
    if ( !isdefined( level.arrow.elementlist ) || level.arrow.elementlist.size < 1 )
    {
        return;
    }
    
    elementlist = level.arrow.elementlist;
    
    if ( isdefined( listoverride ) )
    {
        elementlist = listoverride;
    }
    
    loot::function_ace7a24559a019fb();
    
    foreach ( bundleref in level.var_e43af16903bda945 )
    {
        itemid = level.var_16e1c38355341288[ bundleref ].lootid;
        itemname = bundleref;
        elementid = function_a246dc01c1d8e60e( itemname, 0, listoverride );
        
        if ( isdefined( elementid ) )
        {
            elementlist[ elementid ].elementitemid = int( itemid );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x380d35ff, Offset: 0x40d7
// Size: 0x302
function function_e5368bef9c22c1ae()
{
    var_26061032b1bd0bf7 = function_9fee5cbed598a524();
    
    if ( !isdefined( var_26061032b1bd0bf7 ) )
    {
        return;
    }
    
    level.arrow.var_8dd9f3a49590d676 = var_26061032b1bd0bf7.elementlist;
    level.arrow.elementlist = [];
    level.arrow.elementorder = strtok( level.arrow.dvars.elementorder, " " );
    
    if ( !isdefined( level.arrow.var_8dd9f3a49590d676 ) || level.arrow.var_8dd9f3a49590d676.size < 1 )
    {
        return;
    }
    
    if ( level.arrow.elementorder.size < 3 )
    {
        return;
    }
    
    foreach ( element in level.arrow.var_8dd9f3a49590d676 )
    {
        if ( isdefined( element.elementbundle ) )
        {
            currentelement = getscriptbundle( "elitebrokenarrowelement:" + element.elementbundle );
        }
        else
        {
            continue;
        }
        
        if ( level.arrow.elementlist.size == level.arrow.elementorder.size )
        {
            break;
        }
        
        if ( arraycontains( level.arrow.elementorder, currentelement.elementid ) )
        {
            level.arrow.elementlist[ currentelement.elementid ] = currentelement;
            
            if ( !isdefined( level.arrow.elementlist[ currentelement.elementid ].trackernumber ) )
            {
                level.arrow.elementlist[ currentelement.elementid ].trackernumber = 0;
            }
        }
    }
    
    for ( i = 0; i < level.arrow.elementorder.size ; i++ )
    {
        if ( !isdefined( level.arrow.elementlist[ level.arrow.elementorder[ i ] ] ) )
        {
            level.arrow.elementlist = [];
            return;
        }
        
        level.arrow.elementlist[ level.arrow.elementorder[ i ] ].elementindex = i;
    }
    
    function_a66dc41a985ac5a6();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x4095d836, Offset: 0x43e1
// Size: 0xb
function function_9fee5cbed598a524()
{
    return getscriptbundle( "elitebrokenarrowelementlist:root_elite_broken_arrow_element_list" );
}

/#

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xfcc3ec88, Offset: 0x43f5
    // Size: 0x1e1, Type: dev
    function function_dcf9a95a7c0cfd01()
    {
        if ( !isdefined( level.arrow.var_8dd9f3a49590d676 ) || level.arrow.var_8dd9f3a49590d676.size < 1 )
        {
            return;
        }
        
        if ( !isdefined( level.arrow.elementsall ) )
        {
            level.arrow.elementsall = [];
            
            foreach ( element in level.arrow.var_8dd9f3a49590d676 )
            {
                if ( isdefined( element.elementbundle ) )
                {
                    currentelement = getscriptbundle( "<dev string:x59>" + element.elementbundle );
                }
                else
                {
                    continue;
                }
                
                if ( isdefined( currentelement.elementpartname ) )
                {
                    level.arrow.elementsall[ currentelement.elementid ] = currentelement;
                    
                    if ( !isdefined( level.arrow.elementsall[ currentelement.elementid ].trackernumber ) )
                    {
                        level.arrow.elementsall[ currentelement.elementid ].trackernumber = 0;
                    }
                    
                    level.arrow.elementsall[ currentelement.elementid ].elementindex = 0;
                }
            }
            
            function_a66dc41a985ac5a6( level.arrow.elementsall );
        }
    }

#/

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdcaa870a, Offset: 0x45de
// Size: 0x1b7
function arrow_initvo()
{
    game[ "dialog" ][ "arrow_started" ] = "gmds_wzan_cqus";
    game[ "dialog" ][ "arrow_started_enemy" ] = "gmds_wzan_cqup";
    game[ "dialog" ][ "arrow_collect_element_1" ] = "cqpl_wzan_cmp1";
    game[ "dialog" ][ "arrow_collect_element_2" ] = "cqpl_wzan_cmp2";
    game[ "dialog" ][ "arrow_collect_element_all" ] = "cqsh_wzan_cmpa";
    game[ "dialog" ][ "arrow_bombsite_reveal" ] = "cqpl_wzan_devc";
    game[ "dialog" ][ "arrow_bombsite_arm" ] = "cqsh_wzan_deva";
    game[ "dialog" ][ "arrow_bombsite_arm_enemy" ] = "cqpl_wzan_deva";
    game[ "dialog" ][ "arrow_detonation_warning" ] = "cqpl_wzan_devw";
    game[ "dialog" ][ "arrow_defused" ] = "cqpl_wzan_dd30";
    game[ "dialog" ][ "arrow_defused_under_30" ] = "cqpl_wzan_ddls";
    game[ "dialog" ][ "arrow_detonated" ] = "cqsh_wzan_devt";
    game[ "dialog" ][ "arrow_detonated_enemy" ] = "cqpl_wzan_devt";
    game[ "dialog" ][ "arrow_failed" ] = "cqsh_wzan_dvdf";
    game[ "dialog" ][ "arrow_available" ] = "chmp_wzan_avil";
    game[ "dialog" ][ "arrow_steal" ] = "cqsh_wzan_tscn";
    game[ "dialog" ][ "arrow_start_geiger" ] = "cqsh_wzan_c3st";
    game[ "dialog" ][ "arrow_alert_element_1" ] = "cqsh_wzan_c1al";
    game[ "dialog" ][ "arrow_start_safecrack" ] = "cqsh_wzan_c1st";
    game[ "dialog" ][ "arrow_alert_element_2" ] = "cqsh_wzan_cmsc";
    game[ "dialog" ][ "arrow_bombsite_team" ] = "cqsh_wzan_armd";
    game[ "dialog" ][ "arrow_defused_extract" ] = "cqpl_wzan_exti";
    game[ "dialog" ][ "arrow_disarm_warning" ] = "cqsh_wzan_disw";
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb6562523, Offset: 0x479d
// Size: 0x46
function function_f5b9fee9ad433c19( dialog, delay = 2 )
{
    teaminfo = self;
    level thread br_public::brleaderdialogteam( dialog, teaminfo.targetteam, undefined, delay );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x6d365483, Offset: 0x47eb
// Size: 0xe9
function function_e770743a8f743fbc( dialog, delay = 2, var_b2fc9e583f0a4de8 )
{
    teaminfo = self;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player.team != teaminfo.targetteam )
        {
            if ( var_b2fc9e583f0a4de8 && function_83984ed760cb2b30( player ) )
            {
                continue;
            }
            
            level thread br_public::brleaderdialogplayer( dialog, player, undefined, undefined, delay );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1e0111a7, Offset: 0x48dc
// Size: 0x15
function function_3889badf08417418( dialog )
{
    br_public::brleaderdialog( dialog );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xde0bdbc1, Offset: 0x48f9
// Size: 0xdd
function function_45e9bdb9b4ecbbf7()
{
    level.arrow.bombsitelocations = [];
    bombsites = utility::getstructarray( "elite_arrow_spawn", "targetname" );
    
    if ( isdefined( bombsites ) && bombsites.size > 0 )
    {
        foreach ( bomb in bombsites )
        {
            level.arrow.bombsitelocations[ level.arrow.bombsitelocations.size ] = bomb.origin;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x4b692965, Offset: 0x49de
// Size: 0x43, Type: bool
function arrow_oninit()
{
    if ( !isdefined( level.arrow.numspawned ) )
    {
        level.arrow.numspawned = 0;
    }
    
    level.arrow.numspawned++;
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x3a9d05d7, Offset: 0x4a2a
// Size: 0x7d
function function_1054f70a6fa25397( player )
{
    teammembers = teams::getteamdata( player.team, "players" );
    
    if ( level.arrow.dvars.maxteamsize >= 0 && teammembers.size > level.arrow.dvars.maxteamsize )
    {
        return "too_many_teammates";
    }
    
    return 1;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1aa7d23c, Offset: 0x4ab0
// Size: 0x228
function arrow_onteamassigned()
{
    task = self;
    task.category = level.arrow.contractref;
    
    if ( !task arrow_onteamassignedchecknum() )
    {
        script::demoforcesre( "arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckNum. level.arrow.numAccepted: " + level.arrow.numaccepted + ", level.arrow.dvars.maxAccepted: " + level.arrow.dvars.maxaccepted );
        return;
    }
    
    if ( !task arrow_onteamassignedchecktoken() && !task.skiptoken )
    {
        script::demoforcesre( "arrow_onTeamAssigned - Failed arrow_onTeamAssignedCheckToken." );
        return;
    }
    
    level.arrow.numaccepted++;
    
    if ( level.arrow.numaccepted >= level.arrow.dvars.maxaccepted )
    {
        function_cbe12ec0b07ab447();
    }
    
    task function_16e3061ca1b37d9();
    task arrow_onteamassignedassim();
    task arrow_onteamassignedpers();
    
    if ( !isdefined( level.arrow.props.bombsite ) )
    {
        level.arrow.props.bombsite = function_95dc62093312cda6();
    }
    
    task.targetteam = task.var_fe0156f1cf4e5f41.team;
    task function_7daae34a11fa1b59();
    teaminfo = level.arrow.teaminfo[ task.targetteam ];
    
    if ( !isdefined( level.arrow.elementlist ) || level.arrow.elementlist.size < 1 )
    {
        function_9ecd3b1e0a8844b5( "container_spawn_failed" );
        return;
    }
    
    function_4342df1b68bc7af0( task.targetteam );
    teaminfo function_26a610b3c6b4aedd( task );
    teaminfo arrow_onteamassignedtracker( task );
    teaminfo arrow_flow();
    teaminfo function_a50ece5d2a7d3719();
    function_c55c319265aa598c();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1aa49c4b, Offset: 0x4ce0
// Size: 0x10b
function arrow_onteamassignedassim()
{
    task = self;
    
    foreach ( player in teams::getteamdata( task.var_fe0156f1cf4e5f41.team, "players" ) )
    {
        if ( utility::issharedfuncdefined( #"teamassim", #"isenabled" ) && [[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() && utility::issharedfuncdefined( #"teamassim", #"disableplayer" ) )
        {
            [[ utility::getsharedfunc( #"teamassim", #"disableplayer" ) ]]( player, "br_elite_contract" );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbec28cd7, Offset: 0x4df3
// Size: 0x174
function arrow_onteamassignedpers()
{
    task = self;
    
    foreach ( player in teams::getteamdata( task.var_fe0156f1cf4e5f41.team, "players" ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
        {
            if ( isdefined( player.leaderboarddata[ "eliteStarted" ] ) )
            {
                player.leaderboarddata[ "eliteStarted" ] = player.leaderboarddata[ "eliteStarted" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "eliteStarted" ] ) )
            {
                [[ level.leaderboardfunc[ "eliteStarted" ] ]]( player, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x72>" );
            
            if ( isdefined( player.pers[ "eliteStarted" ] ) )
            {
                player.pers[ "eliteStarted" ] = player.pers[ "eliteStarted" ] + 1;
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x709db087, Offset: 0x4f6f
// Size: 0x9e, Type: bool
function arrow_onteamassignedchecknum()
{
    task = self;
    
    if ( !isdefined( level.arrow.numaccepted ) || level.arrow.dvars.debug )
    {
        level.arrow.numaccepted = 0;
    }
    
    if ( level.arrow.numaccepted >= level.arrow.dvars.maxaccepted )
    {
        task br_contract_manager::endcontract();
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x892ae577, Offset: 0x5016
// Size: 0x53, Type: bool
function arrow_onteamassignedchecktoken()
{
    task = self;
    
    if ( function_2fbad3094c69e140( task.var_fe0156f1cf4e5f41 ) )
    {
        if ( level.arrow.dvars.skiptoken )
        {
            return true;
        }
        
        return true;
    }
    
    task br_contract_manager::endcontract();
    return false;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x900bbaa3, Offset: 0x5072
// Size: 0xbe
function function_26a610b3c6b4aedd( task )
{
    teaminfo = self;
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    if ( task.skiptoken )
    {
        teaminfo function_f5b9fee9ad433c19( "arrow_steal" );
    }
    else
    {
        teaminfo function_f5b9fee9ad433c19( "arrow_started" );
    }
    
    teaminfo function_e770743a8f743fbc( "arrow_started_enemy" );
    hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_started" ) );
    hud_util::showsplashtoallexceptteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_started_global" ), undefined, teaminfo.champion );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xba1ceee5, Offset: 0x5138
// Size: 0xb6
function arrow_onteamassignedtracker( task )
{
    teaminfo = self;
    
    /#
        if ( level.arrow.dvars.debug && isdefined( level.arrow.debugstate ) && level.arrow.debugstate == 8 )
        {
            return;
        }
    #/
    
    if ( level.arrow.dvars.scripttracker )
    {
        teaminfo function_ee90fbccf084693b();
    }
    else
    {
        task function_2a3ecd9294abc61f();
    }
    
    teaminfo function_b343371c751c2905();
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xcee34a65, Offset: 0x51f6
// Size: 0x1d8
function function_b343371c751c2905()
{
    teaminfo = self;
    revealindex = function_5b5877124e9591e3();
    revealtime = 1200;
    
    if ( level.arrow.dvars.var_f884ce880a0744fd > 0 )
    {
        revealtime = min( level.arrow.dvars.var_f884ce880a0744fd, 1200 );
    }
    else if ( br_gametypes::isfeatureenabled( #"circle" ) )
    {
        revealtime = br_circle::gettimetillcircleclosing( revealindex );
    }
    
    revealtime += level.arrow.dvars.bombsitetime;
    revealtime += 120;
    
    if ( isdefined( self.task.payload ) && isdefined( self.task.payload.time ) )
    {
        revealtime = self.task.payload.time;
    }
    
    teammates = teams::getteamdata( teaminfo.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        player function_a5ef95eeb7243ac5( int( revealtime ), 3 );
    }
    
    if ( level.arrow.dvars.scriptedflow == -1 )
    {
        teaminfo thread function_320a63340eaf0c61( revealtime );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x1434717d, Offset: 0x53d6
// Size: 0x91, Type: bool
function function_a459cb368998e5b0( playerswitching, newteam )
{
    var_dcb9ad24e899969c = function_4b02b09a89003454( newteam );
    var_2db8499dc0b138e3 = function_83984ed760cb2b30( playerswitching );
    
    if ( var_dcb9ad24e899969c && level.arrow.dvars.var_a33499e8225c46ee == 0 )
    {
        return false;
    }
    
    if ( var_2db8499dc0b138e3 && level.arrow.dvars.var_a3e7e36a79c9db79 == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x999a8cb9, Offset: 0x5470
// Size: 0xa6
function function_5487bfc866ded63( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    if ( !isdefined( level.arrow.teaminfo ) )
    {
        return;
    }
    
    if ( isdefined( level.arrow.teaminfo[ oldteam ] ) )
    {
        function_7c29894fdb9c6006( player, oldteam, newteam );
    }
    
    if ( isdefined( level.arrow.teaminfo[ newteam ] ) )
    {
        function_ce1a22f6f070b23( player, oldteam, newteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x607a1453, Offset: 0x551e
// Size: 0x141
function function_ce1a22f6f070b23( player, oldteam, newteam )
{
    assert( isdefined( level.arrow.teaminfo[ newteam ] ), "<dev string:x98>" + newteam );
    teaminfo = level.arrow.teaminfo[ newteam ];
    player function_83af91eaf6333c6b( 1 );
    teaminfo function_e7460b727a2abab();
    teaminfo function_a50ece5d2a7d3719();
    player function_a379c1d55f989dea( newteam );
    function_4d9f382f7c2dafab( player, 1, newteam );
    bombsite = level.arrow.props.bombsite;
    
    if ( teaminfo.state >= 2 && teaminfo.state <= 4 )
    {
        bombsite enablescriptableplayeruse( player );
    }
    else
    {
        bombsite disablescriptableplayeruse( player );
    }
    
    if ( isdefined( bombsite.arment ) )
    {
        bombsite.arment function_6fcebb19629beade( player, 1 );
    }
    
    if ( isdefined( bombsite.fuseent ) )
    {
        bombsite.fuseent function_6fcebb19629beade( player, 0 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x4e420a2f, Offset: 0x5667
// Size: 0x20a
function function_7c29894fdb9c6006( player, oldteam, newteam )
{
    assert( isdefined( level.arrow.teaminfo[ oldteam ] ), "<dev string:xbc>" + oldteam );
    teaminfo = level.arrow.teaminfo[ oldteam ];
    bombsite = level.arrow.props.bombsite;
    
    if ( isdefined( bombsite.elementicons ) )
    {
        foreach ( icon in bombsite.elementicons )
        {
            if ( !isdefined( icon ) )
            {
                continue;
            }
            
            icon function_68f1c109685ad84b( player, 0 );
        }
    }
    
    if ( teaminfo.state == 5 )
    {
        bombsite enablescriptableplayeruse( player );
    }
    else
    {
        bombsite disablescriptableplayeruse( player );
    }
    
    if ( isdefined( bombsite.arment ) )
    {
        bombsite.arment function_6fcebb19629beade( player, 0 );
    }
    
    if ( isdefined( bombsite.fuseent ) )
    {
        bombsite.fuseent function_6fcebb19629beade( player, 1 );
    }
    
    player setclientomnvar( "ui_br_elite_arrow_mission_data", 0 );
    player setclientomnvar( "ui_br_elite_arrow_mission_players", 0 );
    teaminfo function_e7460b727a2abab();
    player function_83af91eaf6333c6b( 0 );
    player function_34a9c8a21a16e0ba( oldteam );
    function_4d9f382f7c2dafab( player, 0, oldteam );
    
    if ( player == bombsite.targetplayer )
    {
        bombsite function_691930b2ff3bda1();
    }
    
    if ( player == teaminfo.owner )
    {
        player notify( #"arrow_player_removed" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8bf72046, Offset: 0x5879
// Size: 0x21
function arrow_onentergulag( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    function_9440e9d66d062c05( player, 0 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x2dbd6bb7, Offset: 0x58a2
// Size: 0x36
function arrow_onglobalplayerentergulag( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( function_4b02b09a89003454( player.team ) )
    {
        return;
    }
    
    function_13a40e495736af57( player, 0 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x96be26dd, Offset: 0x58e0
// Size: 0x95
function arrow_onplayerrespawn( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( self.category == "elite_arrow" || self.category == "elite_arrow_resurgence" )
    {
        function_9440e9d66d062c05( player, 1 );
        function_9a04f73120e3bf50( player );
    }
    
    teaminfo = level.arrow.teaminfo[ player.team ];
    
    if ( !isdefined( teaminfo.owner ) )
    {
        teaminfo function_86c4e142e522942a( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x64abc1b2, Offset: 0x597d
// Size: 0x40
function arrow_onglobalplayerrespawn( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( function_4b02b09a89003454( player.team ) )
    {
        return;
    }
    
    function_13a40e495736af57( player, 1 );
    function_9a04f73120e3bf50( player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc4c64e19, Offset: 0x59c5
// Size: 0x3f
function function_dd448d417736770c()
{
    if ( isdefined( self.task ) && isdefined( self.type ) && br_pickups::function_e83c60c3a6451be3( self.type ) )
    {
        self.task function_16e3061ca1b37d9();
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x47552ddd, Offset: 0x5a0c
// Size: 0x42
function arrow_ontablethidden( tablet )
{
    if ( !isdefined( level.arrow ) )
    {
        return;
    }
    
    if ( isdefined( tablet ) && isdefined( tablet.task ) )
    {
        tablet.task function_16e3061ca1b37d9();
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7b17b926, Offset: 0x5a56
// Size: 0x108
function arrow_onplayerdisconnect( player )
{
    if ( !isdefined( level.arrow ) )
    {
        return;
    }
    
    [ itemindex, slotlootid ] = function_aada90c08808dc70( player, 0 );
    
    while ( isdefined( itemindex ) )
    {
        player br_pickups::quickdropall( 10, itemindex );
        [ itemindex, slotlootid ] = function_aada90c08808dc70( player, itemindex + 1 );
    }
    
    function_b75562fc7984ebcf( player, 0 );
    
    if ( isdefined( level.arrow.props ) && isdefined( level.arrow.props.bombsite ) )
    {
        bombsite = level.arrow.props.bombsite;
        
        if ( player == bombsite.targetplayer )
        {
            bombsite function_691930b2ff3bda1();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x643517e1, Offset: 0x5b66
// Size: 0x17
function function_6941fc075867cd36( player )
{
    function_b75562fc7984ebcf( player, 1 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc9494302, Offset: 0x5b85
// Size: 0x7f
function function_bf64cefb532d5691( player )
{
    if ( arraycontains( level.arrow.var_7a52e613a9eacadf, player ) )
    {
        level.arrow.var_7a52e613a9eacadf = arrayremove( level.arrow.var_7a52e613a9eacadf, player );
        level.arrow.playerdisconnects -= 1;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x2f8ec51a, Offset: 0x5c0c
// Size: 0x27
function function_f485cde7c7e708bf()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    rejoin_utility::function_70467cdf042579e5( &function_bf64cefb532d5691 );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x7abcbca3, Offset: 0x5c3b
// Size: 0x39c
function function_b75562fc7984ebcf( player, canrejoin )
{
    if ( !flags::gameflag( "prematch_done" ) || !isdefined( level.totalplayers ) )
    {
        return;
    }
    
    disconnectpercent = 0;
    
    if ( isalive( player ) )
    {
        if ( canrejoin )
        {
            level.arrow.playerdisconnects += 1;
            level.arrow.var_7a52e613a9eacadf[ level.arrow.var_7a52e613a9eacadf.size ] = player;
        }
        else if ( arraycontains( level.arrow.var_7a52e613a9eacadf, player ) )
        {
            level.arrow.var_7a52e613a9eacadf = arrayremove( level.arrow.var_7a52e613a9eacadf, player );
        }
        else
        {
            level.arrow.playerdisconnects += 1;
        }
        
        disconnectpercent = level.arrow.playerdisconnects / level.totalplayers;
    }
    else
    {
        return;
    }
    
    if ( level.arrow.dvars.var_4462fd08d38349e1 > 0 && disconnectpercent >= level.arrow.dvars.var_4462fd08d38349e1 )
    {
        if ( level.arrow.numaccepted < level.arrow.dvars.maxaccepted )
        {
            function_3d2a63712c480b46();
            br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "inactive_disconnect_threshold_reached", level.arrow.playerdisconnects );
        }
    }
    
    if ( function_edb32a1dfc6c70f3() )
    {
        if ( level.arrow.dvars.var_d409b4bb0cef152a > 0 && disconnectpercent >= level.arrow.dvars.var_d409b4bb0cef152a )
        {
            foreach ( teaminfo in level.arrow.teaminfo )
            {
                if ( teaminfo.state == 6 )
                {
                    return;
                }
            }
            
            foreach ( teaminfo in level.arrow.teaminfo )
            {
                if ( teaminfo.state != 0 )
                {
                    task = level.contractmanager.var_ec04bf3a584cbd90[ teaminfo.targetteam ];
                    br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "active_disconnect_threshold_reached", level.arrow.playerdisconnects );
                    function_38408fc9cb01c95d( teaminfo );
                }
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb6b1645a, Offset: 0x5fdf
// Size: 0x22e
function function_435bc3a80674c2f6()
{
    level waittill( #"prematch_done" );
    level waittill( #"ddos_alert" );
    
    if ( level.arrow.dvars.var_b5ff2f8a6cc95fe1 )
    {
        if ( level.arrow.numaccepted < level.arrow.dvars.maxaccepted )
        {
            function_3d2a63712c480b46();
            br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "ddos_alert_received_inactive", level.arrow.playerdisconnects );
        }
    }
    
    if ( level.arrow.dvars.var_f70f16757a0b3b2a )
    {
        if ( function_edb32a1dfc6c70f3() )
        {
            foreach ( teaminfo in level.arrow.teaminfo )
            {
                if ( teaminfo.state == 6 )
                {
                    return;
                }
            }
            
            foreach ( teaminfo in level.arrow.teaminfo )
            {
                if ( teaminfo.state != 0 )
                {
                    task = level.contractmanager.var_ec04bf3a584cbd90[ teaminfo.targetteam ];
                    br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "ddos_alert_received_active", level.arrow.playerdisconnects );
                    function_38408fc9cb01c95d( teaminfo );
                }
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3c6cf21d, Offset: 0x6215
// Size: 0x7f
function function_3d2a63712c480b46()
{
    if ( isdefined( level.arrow.props.tablets ) && level.arrow.props.tablets.size > 0 )
    {
        function_cbe12ec0b07ab447();
        level.arrow.numaccepted = level.arrow.dvars.maxaccepted;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4db3c2b4, Offset: 0x629c
// Size: 0x58
function function_38408fc9cb01c95d( teaminfo )
{
    task = level.contractmanager.var_ec04bf3a584cbd90[ teaminfo.targetteam ];
    task.var_fe0156f1cf4e5f41 challenges::function_fd116258fc6dabb();
    teaminfo function_14ed8a3bc197bff6( "active_disconnect_threshold_reached", 0 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x2322824, Offset: 0x62fc
// Size: 0x5a
function function_320a63340eaf0c61( time )
{
    teaminfo = self;
    level endon( #"game_ended" );
    level endon( #"hash_895e058db3dd0ec9" );
    wait time;
    
    if ( teaminfo.state == 1 )
    {
        if ( !teaminfo function_2567ed6f703b2825() )
        {
            teaminfo arrow_ontimeout();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf1238494, Offset: 0x635e
// Size: 0x1e
function arrow_ontimeout()
{
    teaminfo = self;
    teaminfo function_14ed8a3bc197bff6( "task_timeout", 0 );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2e4023f2, Offset: 0x6384
// Size: 0xcc
function function_9ecd3b1e0a8844b5( endreason, var_b777daa10c56a3b7 )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo ) ) )
    {
        return;
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        teaminfo thread function_14ed8a3bc197bff6( endreason, 0, var_b777daa10c56a3b7 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xb28ee6d1, Offset: 0x6458
// Size: 0x2de
function function_14ed8a3bc197bff6( endreason, success, var_b777daa10c56a3b7 )
{
    teaminfo = self;
    
    if ( !isdefined( teaminfo ) || teaminfo.state == 0 || teaminfo.state == 6 )
    {
        return;
    }
    
    teaminfo notify( #"hash_bf2e9434c44de562" );
    teaminfo endon( #"hash_bf2e9434c44de562" );
    br_analytics::function_3330dd50820900c9( teaminfo, endreason, success );
    
    if ( success )
    {
        level.skipplaybodycountsound = 1;
        level.var_5195f9fa56bdff5 = 1;
        level notify( #"nuke_detonated" );
        
        foreach ( player in teams::getteamdata( teaminfo.targetteam, "players" ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "eliteCompleted" ] ) )
                {
                    player.leaderboarddata[ "eliteCompleted" ] = player.leaderboarddata[ "eliteCompleted" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "eliteCompleted" ] ) )
                {
                    [[ level.leaderboardfunc[ "eliteCompleted" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x72>" );
                
                if ( isdefined( player.pers[ "eliteCompleted" ] ) )
                {
                    player.pers[ "eliteCompleted" ] = player.pers[ "eliteCompleted" ] + 1;
                }
            }
            
            player function_ebda902dd0262d28();
        }
    }
    else
    {
        level notify( #"nuke_aborted" );
        audio_utility::function_5b885ff87a1180d4( level.players, "br_elite_contract_ending", 0 );
        teaminfo function_d6635548ec6104ca();
    }
    
    teaminfo function_d358f852dbf97ca5( endreason, success );
    teaminfo function_211d382b911139f( success );
    
    if ( function_8df0bcbf52ca9ae5() == 0 && level.arrow.dvars.var_7a2065a331b917ee == 0 )
    {
        function_8b0f0f49b2ac56d9();
    }
    
    teaminfo function_c9a9e36e63a2308e();
    function_c55c319265aa598c();
    wait 0.05;
    var_47532b294ab0591d = undefined;
    
    if ( !success )
    {
        var_47532b294ab0591d = var_b777daa10c56a3b7;
    }
    
    teaminfo.task br_contract_manager::endcontract( success, undefined, var_47532b294ab0591d );
    
    if ( success )
    {
        teaminfo function_5ea40494dacd0ad4();
        return;
    }
    
    teaminfo function_6041c9d818951de2();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1908bf8a, Offset: 0x673e
// Size: 0x64
function function_8b0f0f49b2ac56d9()
{
    bombsite = level.arrow.props.bombsite;
    
    if ( !isdefined( bombsite ) )
    {
        return;
    }
    
    bombsite notify( #"on_end_bombsite" );
    bombsite.enabled = 0;
    bombsite thread function_628ccb7591439095();
    waitframe();
    bombsite notify( #"death" );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x587544b9, Offset: 0x67aa
// Size: 0x95
function function_d6635548ec6104ca()
{
    teaminfo = self;
    task = level.contractmanager.var_ec04bf3a584cbd90[ teaminfo.targetteam ];
    
    if ( isdefined( task ) && isdefined( task.type.funcs[ "onEliteTearDown" ] ) )
    {
        task notify( #"task_ended" );
        task [[ task.type.funcs[ "onEliteTearDown" ] ]]( teaminfo.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xce1449b9, Offset: 0x6847
// Size: 0x69
function function_7cc825096998ff5c( delaytime )
{
    level endon( #"game_ended" );
    level endon( #"nuke_aborted" );
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    if ( !isdefined( delaytime ) )
    {
        delaytime = 0.4;
    }
    
    wait delaytime;
    hud_util::showsplashtoall( function_7a10d0b1b0720af0( "elite_arrow_victory" ) );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x271a5631, Offset: 0x68b8
// Size: 0x1b6
function function_d358f852dbf97ca5( endreason, success )
{
    teaminfo = self;
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    if ( success )
    {
        return;
    }
    
    if ( teaminfo.state >= 5 || endreason == "bomb_defused" )
    {
        level.arrow.defused = 1;
        
        if ( endreason == "active_disconnect_threshold_reached" )
        {
            hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_canceled_center" ) );
            return;
        }
        
        defuser = level.arrow.props.bombsite.lastuser;
        
        if ( !isdefined( defuser ) )
        {
            return;
        }
        
        hud_util::showsplashtoall( function_7a10d0b1b0720af0( "elite_arrow_defused" ), undefined, defuser );
        
        if ( isdefined( defuser ) )
        {
            defuserid = defuser getentitynumber();
            
            if ( isdefined( defuserid ) )
            {
                setomnvarforallclients( "ui_br_elite_savior_id", defuserid );
            }
        }
        
        return;
    }
    
    champion = teaminfo.champion ?? teaminfo.owner;
    
    if ( !isdefined( champion ) )
    {
        return;
    }
    
    if ( endreason == "active_disconnect_threshold_reached" )
    {
        hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_canceled_center" ) );
    }
    else
    {
        hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_failed_center" ) );
    }
    
    hud_util::showsplashtoallexceptteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_failed_global" ), undefined, champion );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x4b693fe6, Offset: 0x6a76
// Size: 0x65
function function_5ea40494dacd0ad4()
{
    if ( level.arrow.dvars.var_21dd35790b14ce1f )
    {
        br_gulag::pausegulag( 1 );
        bombsite = level.arrow.props.bombsite;
        
        if ( !isdefined( bombsite ) )
        {
            return;
        }
        
        bombsite function_e75962e825c03f5e();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6481e051, Offset: 0x6ae3
// Size: 0x22
function function_6041c9d818951de2()
{
    teaminfo = self;
    teaminfo function_f5b9fee9ad433c19( "arrow_failed", 4 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb4e68bb4, Offset: 0x6b0d
// Size: 0x60
function function_a50ece5d2a7d3719()
{
    teaminfo = self;
    function_958188efb2944b5a( teaminfo.targetteam, 1 );
    bombsite = level.arrow.props.bombsite;
    bombsite function_67ad4fbf44632408( 1, teaminfo.targetteam );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf04c5b7b, Offset: 0x6b75
// Size: 0xc1, Type: bool
function function_edb32a1dfc6c70f3()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo ) ) )
    {
        return false;
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        if ( teaminfo.state != 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x332a821, Offset: 0x6c3f
// Size: 0x70, Type: bool
function function_4b02b09a89003454( team )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo ) ) )
    {
        return false;
    }
    
    return isdefined( level.arrow.teaminfo[ team ] ) && level.arrow.teaminfo[ team ].state > 0;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x73f9bf60, Offset: 0x6cb8
// Size: 0x82, Type: bool
function function_83984ed760cb2b30( player )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo ) ) )
    {
        return false;
    }
    
    return isdefined( level.arrow.teaminfo[ player.team ] ) && level.arrow.teaminfo[ player.team ].state > 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdf2ab5e5, Offset: 0x6d43
// Size: 0x74
function function_ebcaa647b48649c9()
{
    groundloot = self;
    scriptable = groundloot.instance;
    
    if ( isdefined( groundloot.scriptablename ) && !groundloot function_c67ed81341a99d07() )
    {
        return;
    }
    
    if ( !scriptable function_c67ed81341a99d07() )
    {
        return;
    }
    
    elementid = function_a246dc01c1d8e60e( scriptable.type, 7 );
    return function_ca621b047cf24253( elementid, 0 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x13d11c6f, Offset: 0x6dc0
// Size: 0x77, Type: bool
function function_c67ed81341a99d07()
{
    scriptable = self;
    
    if ( !isdefined( scriptable ) )
    {
        return false;
    }
    
    elementid = undefined;
    name = scriptable.type;
    
    if ( isdefined( scriptable.scriptablename ) )
    {
        name = scriptable.scriptablename;
    }
    
    if ( isdefined( name ) )
    {
        elementid = function_a246dc01c1d8e60e( name, 7 );
    }
    
    return isdefined( elementid ) && isdefined( function_ca621b047cf24253( elementid, 7 ) );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x872fc7c9, Offset: 0x6e40
// Size: 0x95, Type: bool
function function_31df7dd55c44bda8()
{
    scriptable = self;
    
    if ( isdefined( scriptable.elementid ) && isdefined( function_ca621b047cf24253( scriptable.elementid, 5 ) ) )
    {
        return true;
    }
    
    elementid = undefined;
    name = scriptable.type;
    
    if ( isdefined( scriptable.scriptablename ) )
    {
        name = scriptable.scriptablename;
    }
    
    if ( isdefined( name ) )
    {
        elementid = function_a246dc01c1d8e60e( name, 0 );
    }
    
    return isdefined( elementid ) && isdefined( function_ca621b047cf24253( elementid, 0 ) );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x47f82758, Offset: 0x6ede
// Size: 0x72, Type: bool
function function_27a85745631565af()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return false;
    }
    
    return istrue( level.arrow.props.bombsite.siterevealed );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5f7ffa6d, Offset: 0x6f59
// Size: 0x9d, Type: bool
function function_90990ec28c31426a()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return false;
    }
    
    return level.arrow.props.bombsite.bombsitearmed && !level.arrow.props.bombsite.disarmed;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3e60d63e, Offset: 0x6fff
// Size: 0xc9, Type: bool
function function_d77bd3e0d285638c()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return true;
    }
    
    isarmed = function_90990ec28c31426a();
    
    if ( isarmed )
    {
        enemycount = teams::getenemycount( level.arrow.props.bombsite.targetteam, 1 );
        
        if ( enemycount == 0 )
        {
            level.arrow.props.bombsite function_14db70e5111b5554();
        }
    }
    
    return !isarmed;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x83f2c2d2, Offset: 0x70d1
// Size: 0x63, Type: bool
function function_1ccf14b419137856( player )
{
    cooldown = level.arrow.dvars.usecooldown * 1000;
    
    if ( isdefined( player.arrowusetime ) && gettime() < player.arrowusetime + cooldown )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x61971f66, Offset: 0x713d
// Size: 0xf5, Type: bool
function function_2169466aa0685681()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return false;
    }
    
    bombsite = level.arrow.props.bombsite;
    
    foreach ( element in level.arrow.elementlist )
    {
        if ( bombsite.neededelements[ element.elementid ] < 1 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1514b5bd, Offset: 0x723b
// Size: 0xc1
function function_800155bad6fc55c9( elementid )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.arrow.props.bombsite.neededelements[ elementid ] ) )
    {
        return 0;
    }
    
    if ( level.arrow.dvars.var_7660921955d6521a )
    {
        return ( level.arrow.props.bombsite.neededelements[ elementid ] == 0 );
    }
    
    return 1;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x6e49742c, Offset: 0x7304
// Size: 0xec
function function_aada90c08808dc70( player, itemindex )
{
    for ( i = itemindex; i < player common_inventory::function_9cd65c8312048802() ; i++ )
    {
        slotlootid = player common_inventory::inventory_getlootidatbackpackindex( i );
        
        foreach ( element in level.arrow.elementlist )
        {
            if ( element.elementitemid == slotlootid )
            {
                return [ i, slotlootid ];
            }
        }
    }
    
    return [ undefined, undefined ];
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x88e100ba, Offset: 0x73f9
// Size: 0x145
function function_b98555514759173c( player, elementid, itemindex )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.elements ) ) )
    {
        return;
    }
    
    foreach ( teamselements in level.arrow.props.elements )
    {
        if ( !isdefined( teamselements[ elementid ] ) )
        {
            continue;
        }
        
        if ( !( isdefined( itemindex ) && isdefined( teamselements[ elementid ].itemindex ) ) || teamselements[ elementid ].itemindex != itemindex )
        {
            continue;
        }
        
        if ( !( isdefined( player ) && isdefined( teamselements[ elementid ].player ) ) || teamselements[ elementid ].player != player )
        {
            continue;
        }
        
        return teamselements[ elementid ];
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7307c1f0, Offset: 0x7547
// Size: 0x1a
function function_18ff21e51998d8e6( elementindex )
{
    if ( !isdefined( elementindex ) )
    {
        return 0;
    }
    
    return 1 << elementindex;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x5074bed3, Offset: 0x756a
// Size: 0x275
function function_a246dc01c1d8e60e( attribute, parameter, listoverride )
{
    if ( getdvarint( @"scr_br_elite_broken_arrow", 0 ) == 0 )
    {
        return;
    }
    
    if ( !( isdefined( parameter ) && isdefined( attribute ) && isdefined( level.arrow ) && isdefined( level.arrow.elementlist ) ) || level.arrow.elementlist.size < 1 )
    {
        return;
    }
    
    var_11f5f6d8fe904f1f = level.arrow.elementlist;
    
    if ( isdefined( listoverride ) )
    {
        var_11f5f6d8fe904f1f = listoverride;
    }
    
    foreach ( element in var_11f5f6d8fe904f1f )
    {
        switch ( parameter )
        {
            case 0:
                searchparameter = element.elementscriptable;
                break;
            case 7:
                searchparameter = element.elementcontainer;
                break;
            case 1:
                searchparameter = element.elementpartname;
                break;
            case 8:
                searchparameter = element.var_2a778c5b7c855b93;
                break;
            case 3:
                searchparameter = element.elementquestcircle;
                break;
            case 2:
                searchparameter = element.elementicon;
                break;
            case 5:
                searchparameter = element.elementitemid;
                break;
            case 6:
                searchparameter = element.elementindex;
                break;
            case 4:
                searchparameter = element.trackernumber;
                break;
            case 9:
                searchparameter = element.var_4ff554ca19a3ec2b;
                break;
            case 10:
                searchparameter = element.var_f9adecf586b6ca90;
                break;
            default:
                return;
        }
        
        if ( searchparameter == attribute )
        {
            return element.elementid;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xc27835c5, Offset: 0x77e8
// Size: 0x29a
function function_ca621b047cf24253( elementid, attribute, listoverride )
{
    if ( !isdefined( level.arrow.elementlist ) || level.arrow.elementlist.size < 1 || !isdefined( level.arrow.elementlist[ elementid ] ) )
    {
        return;
    }
    
    var_11f5f6d8fe904f1f = level.arrow.elementlist;
    
    if ( isdefined( listoverride ) )
    {
        var_11f5f6d8fe904f1f = listoverride;
    }
    
    switch ( attribute )
    {
        case 0:
            return var_11f5f6d8fe904f1f[ elementid ].elementscriptable;
        case 7:
            return var_11f5f6d8fe904f1f[ elementid ].elementcontainer;
        case 1:
            return var_11f5f6d8fe904f1f[ elementid ].elementpartname;
        case 3:
            return var_11f5f6d8fe904f1f[ elementid ].elementquestcircle;
        case 2:
            return var_11f5f6d8fe904f1f[ elementid ].elementicon;
        case 5:
            return var_11f5f6d8fe904f1f[ elementid ].elementitemid;
        case 6:
            return var_11f5f6d8fe904f1f[ elementid ].elementindex;
        case 4:
            return var_11f5f6d8fe904f1f[ elementid ].trackernumber;
        case 9:
            return var_11f5f6d8fe904f1f[ elementid ].var_4ff554ca19a3ec2b;
        case 10:
            return var_11f5f6d8fe904f1f[ elementid ].var_f9adecf586b6ca90;
        case 11:
            return var_11f5f6d8fe904f1f[ elementid ].elementsplashlist.var_1925d6a75df8ff26;
        case 12:
            return var_11f5f6d8fe904f1f[ elementid ].elementsplashlist.var_5a6667597e542cea;
        case 13:
            return var_11f5f6d8fe904f1f[ elementid ].elementstringlist.heldreference;
        case 14:
            return var_11f5f6d8fe904f1f[ elementid ].elementstringlist.locatereference;
        case 15:
            return var_11f5f6d8fe904f1f[ elementid ].elementstringlist.securedreference;
        case 16:
            return var_11f5f6d8fe904f1f[ elementid ].elementstringlist.protectreference;
        default:
            return;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x271e6f0f, Offset: 0x7a8a
// Size: 0xa3
function function_3c6f8c0eb3453c9d( elems )
{
    if ( !isdefined( elems ) )
    {
        return;
    }
    
    if ( isarray( elems ) )
    {
        foreach ( elem in elems )
        {
            if ( isdefined( elem ) )
            {
                elem destroy();
            }
        }
        
        return;
    }
    
    if ( isdefined( elems ) )
    {
        elems destroy();
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x22992757, Offset: 0x7b35
// Size: 0xd4
function function_958188efb2944b5a( targetteam, isvisible )
{
    bombsite = level.arrow.props.bombsite;
    
    if ( !isdefined( bombsite.elementicons ) )
    {
        return;
    }
    
    foreach ( icon in bombsite.elementicons )
    {
        if ( !isdefined( icon ) )
        {
            continue;
        }
        
        icon function_f45d93bbeae7e3a2( targetteam, isvisible );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x66a4a055, Offset: 0x7c11
// Size: 0x10f
function function_6477e45cac6a8b5a( position, ignoreents )
{
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    testpos = br_public::droptogroundmultitrace( position, 100, -150, contents );
    result = br_public::raytraceoffset( testpos, 0, 0, 50, -125, contents, ignoreents );
    spawninfo = spawnstruct();
    spawninfo.origin = result[ "position" ];
    angledelta = math::anglebetweenvectors( ( 0, 0, 1 ), result[ "normal" ] );
    
    if ( angledelta <= level.arrow.dvars.var_bd900eb8315d80ec )
    {
        spawninfo.angles = generateaxisanglesfromupvector( result[ "normal" ], ( 0, 0, 0 ) );
    }
    else
    {
        spawninfo.angles = ( 0, 0, 0 );
    }
    
    return spawninfo;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5fac997c, Offset: 0x7d29
// Size: 0x29
function function_2fbad3094c69e140( player )
{
    return level.arrow.dvars.skiptoken;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xcf7947c5, Offset: 0x7d5b
// Size: 0x122, Type: bool
function function_c38819bc98658c08( player, elementid )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.elements ) ) || !isplayer( player ) )
    {
        return false;
    }
    
    foreach ( teamselements in level.arrow.props.elements )
    {
        if ( !( isdefined( teamselements[ elementid ] ) && isdefined( teamselements[ elementid ].player ) ) || !isplayer( teamselements[ elementid ].player ) )
        {
            continue;
        }
        
        if ( teamselements[ elementid ].player == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe0e2fe4, Offset: 0x7e86
// Size: 0x15b, Type: bool
function function_da9b57df62754bed( team, elementids )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo[ team ] ) && isdefined( elementids ) ) )
    {
        return false;
    }
    
    teammates = teams::getteamdata( team, "players" );
    
    foreach ( elementid in elementids )
    {
        elementfound = 0;
        
        foreach ( player in teammates )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( function_c38819bc98658c08( player, elementid ) )
            {
                elementfound = 1;
            }
        }
        
        if ( !elementfound )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe1d37aa1, Offset: 0x7fea
// Size: 0x55, Type: bool
function function_fdb3c39e53e957b9( container )
{
    if ( !container function_c67ed81341a99d07() )
    {
        return false;
    }
    
    state = container function_ab5af3aa6a38e25a();
    
    if ( state == "active_and_closed" || state == "active_and_open" || state == "opening" )
    {
        return true;
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x694aeee9, Offset: 0x8048
// Size: 0x195
function arrow_flow()
{
    teaminfo = self;
    
    if ( level.arrow.dvars.scriptedflow == 2 || level.arrow.dvars.scriptedflow == 3 )
    {
        thread arrow_flowcircles();
    }
    
    if ( level.arrow.dvars.scriptedflow == 3 )
    {
        firstelement = function_a246dc01c1d8e60e( 0, 6 );
        secondelement = function_a246dc01c1d8e60e( 1, 6 );
        teaminfo function_7969fed14848409a( function_ca621b047cf24253( firstelement, 7 ) );
        teaminfo function_a846b42fd6cd14d( secondelement );
    }
    
    if ( level.arrow.dvars.scriptedflow == 2 )
    {
        teaminfo function_a846b42fd6cd14d( function_a246dc01c1d8e60e( 0, 6 ) );
    }
    else if ( level.arrow.dvars.scriptedflow == 1 )
    {
        teaminfo thread arrow_flowsequence();
    }
    else if ( level.arrow.dvars.scriptedflow == 0 )
    {
        teaminfo function_c77a542ba998c23b();
    }
    else if ( level.arrow.dvars.scriptedflow == 4 )
    {
        thread function_38ae50a02d59b927();
        teaminfo thread arrow_flowpickup();
    }
    
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1e47dc6b, Offset: 0x81e5
// Size: 0x94
function function_38ae50a02d59b927()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    for ( circle = 0; true ; circle++ )
    {
        success = function_a41f47e979c8670a( circle );
        
        if ( !success )
        {
            function_9ecd3b1e0a8844b5( "circle_close" );
            return;
        }
        
        if ( success && circle == level.arrow.dvars.var_38fe632bfb0b4121 )
        {
            function_3c32cff7319cf86d();
        }
        
        level waittill( #"br_circle_set" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x53f3659e, Offset: 0x8281
// Size: 0x3b
function function_a41f47e979c8670a( circleindex )
{
    success = 1;
    dropindex = function_5b5877124e9591e3();
    
    if ( circleindex == dropindex )
    {
        success = function_c1293446caaf362a();
    }
    
    return success;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf58127fd, Offset: 0x82c5
// Size: 0x94
function arrow_flowcircles()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    for ( circle = 0; true ; circle++ )
    {
        success = function_1319244678494322( circle );
        
        if ( !success )
        {
            function_9ecd3b1e0a8844b5( "circle_close" );
            return;
        }
        
        if ( success && circle == level.arrow.dvars.var_38fe632bfb0b4121 )
        {
            function_3c32cff7319cf86d();
        }
        
        level waittill( #"br_circle_set" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xfe441fd6, Offset: 0x8361
// Size: 0xc4
function function_1319244678494322( circleindex )
{
    dropindex = function_5b5877124e9591e3();
    success = 1;
    
    if ( level.arrow.elementlist.size == 3 )
    {
        var_3ffae26477c6f016 = 2;
        var_5ac3ed3972fd0ffe = 1;
    }
    else
    {
        var_3ffae26477c6f016 = 1;
        var_5ac3ed3972fd0ffe = 0;
    }
    
    if ( circleindex == 1 && level.arrow.elementlist.size == 3 )
    {
        function_73de1a8a22880367( circleindex );
        return success;
    }
    
    if ( circleindex > 0 )
    {
        function_73de1a8a22880367( circleindex );
        success = function_7e986cfec29d1258( circleindex, dropindex, var_3ffae26477c6f016, var_5ac3ed3972fd0ffe );
    }
    
    if ( circleindex == dropindex )
    {
        success = function_c1293446caaf362a();
    }
    
    return success;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x150adc81, Offset: 0x842e
// Size: 0x8e
function function_5b5877124e9591e3()
{
    if ( br_circle_util::function_7c3401c47d505872() <= 1 )
    {
        return level.arrow.dvars.var_b8c9d0ad7b90b8f4;
    }
    
    if ( !br_circle_util::function_22abcafc992ddca7( level.arrow.dvars.var_edf481113abfa588 ) )
    {
        return level.arrow.dvars.var_edf481113abfa588;
    }
    
    return level.arrow.dvars.var_b8c9d0ad7b90b8f4;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x74fc75ae, Offset: 0x84c5
// Size: 0x9a
function function_73de1a8a22880367( circleindex )
{
    level notify( #"hash_9771dcec90e2b1ae" );
    elementid = function_a246dc01c1d8e60e( circleindex - 1, 6 );
    
    if ( isdefined( elementid ) )
    {
        level.arrow.countdowns = [];
        thiscircle = br_circle::getcircleclosetime( circleindex - 1 );
        nextcircle = br_circle::getcircleclosetime( circleindex );
        thread function_4900e2ceaa98d7ba( elementid, int( nextcircle - thiscircle ) );
        return;
    }
    
    level.arrow.countdowns = undefined;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x71501e84, Offset: 0x8567
// Size: 0x153
function function_4900e2ceaa98d7ba( elementid, timer, team, var_508d9e871f9afd39 )
{
    level endon( #"game_ended" );
    level endon( #"hash_9771dcec90e2b1ae" );
    countdown = int( timer );
    timerpaused = 0;
    
    while ( countdown > 0 )
    {
        if ( !function_edb32a1dfc6c70f3() )
        {
            wait 1;
            countdown--;
            continue;
        }
        
        if ( isdefined( team ) )
        {
            level.arrow.teaminfo[ team ].var_d19d7029a0328b66[ elementid ] = countdown;
        }
        else
        {
            level.arrow.countdowns[ elementid ] = countdown;
        }
        
        if ( countdown <= level.arrow.dvars.var_707b23afaba6c546 )
        {
            if ( !isdefined( team ) )
            {
                function_c9a9e36e63a2308e( countdown, timerpaused );
            }
            else
            {
                level.arrow.teaminfo[ team ] function_e7460b727a2abab( countdown, timerpaused );
            }
        }
        
        wait 1;
        timerpaused = level.arrow.dvars.var_f7df06d7d9e4c803 && !function_da9b57df62754bed( team, var_508d9e871f9afd39 );
        
        if ( !timerpaused )
        {
            countdown--;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0xedd3285c, Offset: 0x86c2
// Size: 0x11f, Type: bool
function function_7e986cfec29d1258( circleindex, dropindex, var_3ffae26477c6f016, var_5ac3ed3972fd0ffe )
{
    if ( !function_edb32a1dfc6c70f3() )
    {
        return false;
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( teaminfo.state == 0 )
        {
            continue;
        }
        
        currentelement = function_a246dc01c1d8e60e( circleindex - var_3ffae26477c6f016, 6 );
        
        if ( isdefined( currentelement ) )
        {
            teaminfo function_7969fed14848409a( function_ca621b047cf24253( currentelement, 7 ) );
        }
        
        nextelement = function_a246dc01c1d8e60e( circleindex - var_5ac3ed3972fd0ffe, 6 );
        
        if ( isdefined( nextelement ) && circleindex != dropindex )
        {
            teaminfo function_a846b42fd6cd14d( nextelement );
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xce64cbb9, Offset: 0x87ea
// Size: 0x114, Type: bool
function function_c1293446caaf362a()
{
    if ( !function_edb32a1dfc6c70f3() )
    {
        return false;
    }
    
    if ( !isdefined( level.arrow.props.bombsite ) )
    {
        return false;
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( teaminfo.state == 0 )
        {
            continue;
        }
        
        player = teaminfo.owner ?? teaminfo.champion;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        level.arrow.props.bombsite thread arrow_bombsitereveal( player );
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x47c8b69f, Offset: 0x8907
// Size: 0x14
function function_3c32cff7319cf86d()
{
    if ( !function_edb32a1dfc6c70f3() )
    {
        return;
    }
    
    thread function_1ae462cbb26a8fa9();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x63815a21, Offset: 0x8923
// Size: 0x4e
function function_1ae462cbb26a8fa9()
{
    level endon( #"game_ended" );
    level waittill( #"br_circle_started" );
    setdvar( @"hash_47d8674c992e098", 1 );
    br_circle::pausecircle( 1 );
    
    while ( function_edb32a1dfc6c70f3() )
    {
        wait 0.1;
    }
    
    br_circle::pausecircle( 0 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3dcd1f34, Offset: 0x8979
// Size: 0x11b
function arrow_flowsequence()
{
    teaminfo = self;
    level endon( #"game_ended" );
    teaminfo endon( #"hash_bf2e9434c44de562" );
    
    foreach ( element in level.arrow.elementorder )
    {
        elementcontainer = function_ca621b047cf24253( element, 7 );
        
        if ( !isdefined( elementcontainer ) )
        {
            break;
        }
        
        teaminfo function_7969fed14848409a( elementcontainer );
        function_58b1279cb8c57c57( teaminfo, function_ca621b047cf24253( element, 6 ) + 1 );
        teaminfo waittill( #"hash_11675fc4a3c8a965" );
    }
    
    level.arrow.props.bombsite arrow_bombsitereveal( teaminfo.champion );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x742f123e, Offset: 0x8a9c
// Size: 0x50
function function_58b1279cb8c57c57( teaminfo, elementindex )
{
    if ( elementindex >= level.arrow.elementlist.size )
    {
        return;
    }
    
    elementid = function_a246dc01c1d8e60e( elementindex, 6 );
    teaminfo function_a846b42fd6cd14d( elementid );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xedcf91d7, Offset: 0x8af4
// Size: 0x133
function arrow_flowpickup()
{
    teaminfo = self;
    level endon( #"game_ended" );
    teaminfo endon( #"hash_bf2e9434c44de562" );
    previouselement = [];
    
    foreach ( element in level.arrow.elementorder )
    {
        if ( !isdefined( level.arrow.elementlist[ element ] ) )
        {
            break;
        }
        
        function_4900e2ceaa98d7ba( element, int( level.arrow.dvars.var_707b23afaba6c546 ), teaminfo.targetteam, previouselement );
        elementcontainer = function_ca621b047cf24253( element, 7 );
        teaminfo function_7969fed14848409a( elementcontainer );
        teaminfo waittill( #"hash_11675fc4a3c8a965" );
        previouselement[ previouselement.size ] = element;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xcd43a46e, Offset: 0x8c2f
// Size: 0x186
function function_7969fed14848409a( containername )
{
    teaminfo = self;
    elementid = function_a246dc01c1d8e60e( containername, 7 );
    
    if ( isdefined( level.arrow.props.containers[ teaminfo.targetteam ][ elementid ] ) )
    {
        return;
    }
    
    spawnnode = teaminfo function_4ffd6c26fc9336f3();
    
    if ( !isdefined( spawnnode ) )
    {
        teaminfo thread function_14ed8a3bc197bff6( "container_spawn_failed" );
        return;
    }
    
    container = function_6cb96b29ee3f31a( containername, teaminfo.targetteam, spawnnode.origin, spawnnode.angles );
    
    if ( !isdefined( level.arrow.props.containers ) )
    {
        level.arrow.props.containers = [];
    }
    
    if ( !isdefined( level.arrow.props.containers[ teaminfo.targetteam ] ) )
    {
        level.arrow.props.containers[ teaminfo.targetteam ] = [];
    }
    
    level.arrow.props.containers[ teaminfo.targetteam ][ elementid ] = container;
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6936c227, Offset: 0x8dbd
// Size: 0xb1
function function_4ffd6c26fc9336f3()
{
    teaminfo = self;
    continuesearch = 0;
    
    while ( continuesearch <= 2 )
    {
        teamorigin = teaminfo function_1f4e63fca715af5();
        possiblenodes = function_a1c81512b7bac325( teamorigin, continuesearch );
        
        if ( possiblenodes.size == 0 )
        {
            continuesearch++;
            continue;
        }
        
        safetime = level.arrow.dvars.var_52cf0885d260a509 * getmatchrulesdata( "brData", "circleTimeScale" );
        spawnnode = function_c7a5926bd868b7a2( possiblenodes, safetime );
        
        if ( !isdefined( spawnnode ) )
        {
            continuesearch++;
            continue;
        }
        
        return spawnnode;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1998bc17, Offset: 0x8e77
// Size: 0xf6, Type: bool
function function_a2e2eaecb171934d()
{
    assert( isdefined( level.totalplayers ) );
    
    if ( !isdefined( level.contractmanager ) )
    {
        return false;
    }
    
    if ( game_utility_mp::privatematch() )
    {
        return false;
    }
    
    if ( level.arrow.dvars.skiptoken )
    {
        return true;
    }
    
    if ( level.arrow.dvars.var_91b380f71234a20d > 0 )
    {
        percentage = level.arrow.dvars.var_91b380f71234a20d / 100;
        maxplayers = getdvarint( @"party_maxplayers" );
        var_5b02d5e8daff5213 = maxplayers * percentage;
        
        if ( level.totalplayers < var_5b02d5e8daff5213 )
        {
            br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "not_enough_players_in_match", -1 );
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdcfb4ef, Offset: 0x8f76
// Size: 0x196
function arrow_tabletinit()
{
    level endon( #"game_ended" );
    
    if ( !function_af391dfd52ae4881() )
    {
        return;
    }
    
    arrow_tabletinitwait();
    
    if ( !function_a2e2eaecb171934d() )
    {
        logstring( "br_elite_broken_arrow::arrow_tabletInit - match is not valid!" );
        return;
    }
    
    thread function_1eaae0152262445e();
    
    if ( !level.arrow.dvars.var_27416c0d29b8c001 )
    {
        locksandkeys::function_94f3be340119a53();
    }
    
    thread function_4cfb4896bb1f46b7();
    
    if ( !isdefined( level.arrow.numspawned ) )
    {
        level.arrow.numspawned = 0;
    }
    
    if ( !isdefined( level.arrow.numaccepted ) )
    {
        level.arrow.numaccepted = 0;
    }
    
    for ( i = 0; i < level.arrow.dvars.numspawn ; i++ )
    {
        newtablet = function_354d0d2c81534141();
        
        if ( !isdefined( newtablet ) )
        {
            break;
        }
        
        if ( !isdefined( level.arrow.props.tablets ) )
        {
            level.arrow.props.tablets = [];
        }
        
        level.arrow.props.tablets[ level.arrow.props.tablets.size ] = newtablet;
    }
    
    function_5ced56aa00d4886e();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x77497ca7, Offset: 0x9114
// Size: 0x51
function arrow_tabletinitwait()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_fade_done" );
    
    if ( level.br_strongholds )
    {
        while ( !isdefined( level.fortressstruct ) || !level.fortressstruct.var_6dc29464d93d3edd )
        {
            waitframe();
        }
    }
    
    waitframe();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6f9636e6, Offset: 0x916d
// Size: 0x26, Type: bool
function function_af391dfd52ae4881()
{
    if ( level.arrow.dvars.disabled )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x18b122ee, Offset: 0x919c
// Size: 0xba
function function_354d0d2c81534141()
{
    lootcount = getlootspawnpointcount();
    
    if ( lootcount == 0 )
    {
        assertmsg( "<dev string:xe1>" );
        return;
    }
    
    startingindex = randomint( lootcount );
    currentindex = startingindex;
    
    while ( true )
    {
        var_cc87315988846c18 = getlootspawnpoint( currentindex );
        
        if ( function_6d18da8942944fe7( var_cc87315988846c18 ) )
        {
            break;
        }
        
        currentindex = ( currentindex + 1 ) % lootcount;
        
        if ( currentindex == startingindex )
        {
            assertmsg( "<dev string:x126>" );
            return;
        }
    }
    
    newtablet = function_5aa74efce0ddb257( var_cc87315988846c18.origin, var_cc87315988846c18.angles );
    disablelootspawnpoint( currentindex );
    return newtablet;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xc92cc92b, Offset: 0x925f
// Size: 0xb0
function function_5aa74efce0ddb257( origin, angles )
{
    wantedmodel = "offhand_2h_wm_briefcase_bomb_v0_nuke";
    contractref = "elite_arrow";
    tabletent = spawn( "script_model", origin );
    tabletent setmodel( wantedmodel );
    tabletent playloopsound( "iw9_br_elite_contract_attract_lp" );
    tabletent.angles = angles;
    newtablet = br_contract_manager::function_afc15d4bdb062dff( contractref, origin, angles );
    newtablet.task.tabletent = tabletent;
    level.arrow.contractref = contractref;
    return newtablet;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd8a928ff, Offset: 0x9318
// Size: 0x172, Type: bool
function function_6d18da8942944fe7( lootnode )
{
    if ( !function_4d8bf982a880bc4e( lootnode.index ) || lootnode.game_extrainfo == 1 )
    {
        return false;
    }
    
    if ( br_contract_manager::function_d0e283b300baf433( lootnode.origin ) )
    {
        return false;
    }
    
    if ( lootnode.sizeint == 0 )
    {
        return false;
    }
    
    if ( br_gametypes::isfeatureenabled( #"circle" ) && level.arrow.dvars.var_f3c59172d6694bed )
    {
        dangertime = br_circle_util::gettimetilldangerforpoint( lootnode.origin );
        circleend = br_circle::gettimetillcircleclosing( 1 );
        
        if ( circleend < dangertime )
        {
            return false;
        }
    }
    
    if ( ai_fortress::function_5428359c3c1916ac( lootnode.origin ) )
    {
        return false;
    }
    
    if ( br_bunker_utility::function_5f3fda39a064e862( lootnode.origin ) )
    {
        return false;
    }
    
    if ( !level.arrow.dvars.var_27416c0d29b8c001 && locksandkeys::function_9894956c856a7904( lootnode.origin ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"elitearrow", #"hash_1c85bf0e5a89d4e3" ) && [[ utility::getsharedfunc( #"elitearrow", #"hash_1c85bf0e5a89d4e3" ) ]]( lootnode.origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf7a1eb89, Offset: 0x9493
// Size: 0x126
function function_4cfb4896bb1f46b7()
{
    level endon( #"game_ended" );
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    flags::gameflagwait( "infil_animatic_complete" );
    wait 1.5;
    splashteams = [];
    
    foreach ( player in level.players )
    {
        if ( function_2fbad3094c69e140( player ) )
        {
            if ( !splashteams[ player.team ] )
            {
                splashteams[ player.team ] = 1;
                hud_util::showsplashtoteam( player.team, function_7a10d0b1b0720af0( "elite_arrow_available" ) );
                level thread br_public::brleaderdialogteam( "arrow_available", player.team, undefined, 2 );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x9d412488, Offset: 0x95c1
// Size: 0x48
function function_1eaae0152262445e()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    for ( circle = 0; true ; circle++ )
    {
        function_6d70ddb3ecfb14d7( circle );
        level waittill( #"br_circle_set" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf44e63ad, Offset: 0x9611
// Size: 0xaf
function function_6d70ddb3ecfb14d7( circleindex )
{
    if ( circleindex >= 2 )
    {
        if ( isdefined( level.arrow.numaccepted ) && level.arrow.numaccepted < level.arrow.dvars.maxaccepted )
        {
            function_cbe12ec0b07ab447();
            level.arrow.numaccepted = level.arrow.dvars.maxaccepted;
            br_analytics::function_2a3fd8c91d8471a8( level.totalplayers, "tablets_not_picked_up_before_2nd_circle", -1 );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb34c790b, Offset: 0x96c8
// Size: 0xdb
function function_cbe12ec0b07ab447()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.arrow.props.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        tablet.task function_16e3061ca1b37d9();
        tablet thread br_contract_manager::tablethide();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x28450ff4, Offset: 0x97ab
// Size: 0x39
function function_16e3061ca1b37d9()
{
    task = self;
    
    if ( isdefined( task.tabletent ) )
    {
        task.tabletent delete();
        task.tabletent = undefined;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5538370, Offset: 0x97ec
// Size: 0xef
function function_181e68a27c2977dc()
{
    player = self;
    
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.arrow.props.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        tablet.task.tabletent hidefromplayer( player );
        tablet disablescriptableplayeruse( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x295aefec, Offset: 0x98e3
// Size: 0xcb
function function_4342df1b68bc7af0( team )
{
    teammates = teams::getteamdata( team, "players" );
    
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.tablets ) ) )
    {
        return;
    }
    
    foreach ( player in teammates )
    {
        if ( isdefined( player ) )
        {
            player function_181e68a27c2977dc();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xcaa2b1cc, Offset: 0x99b6
// Size: 0xc2
function function_5ced56aa00d4886e()
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.tablets ) ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( function_2fbad3094c69e140( player ) )
        {
            player function_617af7c66e9d294c();
            continue;
        }
        
        player function_181e68a27c2977dc();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5ebede17, Offset: 0x9a80
// Size: 0xef
function function_617af7c66e9d294c()
{
    player = self;
    
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.arrow.props.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        tablet.task.tabletent showtoplayer( player );
        tablet enablescriptableplayeruse( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc633cc81, Offset: 0x9b77
// Size: 0x40, Type: bool
function function_4e04b7f49c90c1ed()
{
    tabletent = self;
    task = tabletent.task;
    task function_16e3061ca1b37d9();
    task.tablet thread br_contract_manager::tablethide();
    return false;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xa3dcd54b, Offset: 0x9bc0
// Size: 0x106
function function_7daae34a11fa1b59()
{
    task = self;
    
    if ( !isdefined( level.arrow.teaminfo ) )
    {
        level.arrow.teaminfo = [];
    }
    
    teaminfo = spawnstruct();
    teaminfo.state = 1;
    teaminfo.task = task;
    teaminfo.targetteam = task.targetteam;
    teaminfo.champion = task.var_fe0156f1cf4e5f41;
    teaminfo.owner = task.var_fe0156f1cf4e5f41;
    teaminfo.var_cb2723b89bd9c8e9 = undefined;
    teaminfo.firstpickups = 0;
    teaminfo.var_7c14906613fde75c = 0;
    teaminfo.var_d19d7029a0328b66 = [];
    level.arrow.teaminfo[ task.targetteam ] = teaminfo;
    teaminfo thread function_5f838725d24da084();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf4636f65, Offset: 0x9cce
// Size: 0x149
function function_211d382b911139f( success )
{
    teaminfo = self;
    function_bedb8b7dd399dd51( teaminfo.targetteam );
    tabletdrop = teaminfo.tabletdrop && level.arrow.dvars.var_7a2065a331b917ee;
    
    if ( !tabletdrop )
    {
        function_1b2080822f11788e( teaminfo.targetteam );
    }
    
    function_a40a657322f22f0a( teaminfo.targetteam );
    
    if ( !tabletdrop )
    {
        function_958188efb2944b5a( teaminfo.targetteam, 0 );
    }
    
    bombsite = level.arrow.props.bombsite;
    
    if ( isdefined( bombsite.arment ) )
    {
        bombsite.arment function_ef1082c3639c1297( teaminfo.targetteam, 0 );
    }
    
    if ( isdefined( bombsite.fuseent ) )
    {
        bombsite.fuseent function_ef1082c3639c1297( teaminfo.targetteam, 1 );
    }
    
    if ( success )
    {
        teaminfo.state = 6;
        return;
    }
    
    teaminfo.state = 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xefbda860, Offset: 0x9e1f
// Size: 0xf3
function function_5f838725d24da084()
{
    teaminfo = self;
    teaminfo notify( #"hash_13fe63fb57913e11" );
    teaminfo endon( #"hash_13fe63fb57913e11" );
    teaminfo endon( #"hash_bf2e9434c44de562" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( teaminfo.owner ) )
        {
            teaminfo function_f39a3f025f56c88f();
            wait 1;
            continue;
        }
        
        reason = teaminfo.owner utility::waittill_any_return_no_endon_death( "death_or_disconnect", "br_team_fully_eliminated", "arrow_player_removed" );
        
        if ( !isdefined( teaminfo.var_cb2723b89bd9c8e9 ) && isdefined( teaminfo.owner ) )
        {
            teaminfo.var_cb2723b89bd9c8e9 = teaminfo.owner.origin;
        }
        
        teaminfo function_5e3869f5b0f8eabe();
        teaminfo function_a4a2752a3c93fa3();
        teaminfo thread function_f39a3f025f56c88f( reason );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xaff970c6, Offset: 0x9f1a
// Size: 0xe0
function function_a4a2752a3c93fa3( reason )
{
    teaminfo = self;
    teammates = teams::getteamdata( teaminfo.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        if ( isalive( player ) && player != teaminfo.owner )
        {
            teaminfo.owner = player;
            teaminfo.var_cb2723b89bd9c8e9 = undefined;
            return;
        }
    }
    
    teaminfo.owner = undefined;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x23bf54a8, Offset: 0xa002
// Size: 0x93
function function_5e3869f5b0f8eabe()
{
    teaminfo = self;
    
    if ( teams::getteamcount( teaminfo.targetteam ) != 0 )
    {
        return;
    }
    
    if ( function_90990ec28c31426a() )
    {
        bombsite = level.arrow.props.bombsite;
        
        if ( bombsite.targetteam == teaminfo.targetteam )
        {
            bombsite.fuseent notify( #"fuse_cancelled" );
            teaminfo notify( #"hash_13fe63fb57913e11" );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xce2dc9f7, Offset: 0xa09d
// Size: 0x169
function function_f39a3f025f56c88f( reason )
{
    teaminfo = self;
    teammates = teams::getteamdata( teaminfo.targetteam, "players" );
    
    if ( reason != "br_team_fully_eliminated" )
    {
        foreach ( player in teammates )
        {
            if ( !isdefined( player.placementbonus ) )
            {
                return;
            }
        }
    }
    
    handled = utility::callsharedfunc( #"gametype", #"hash_e524d7396362f58d", teaminfo, reason );
    
    if ( handled )
    {
        return;
    }
    
    if ( reason == "arrow_player_removed" )
    {
        teaminfo thread function_14ed8a3bc197bff6( "team_empty", 0 );
        return;
    }
    
    var_ec0c0e9f9b3c55a9 = undefined;
    
    if ( isdefined( teaminfo.owner ) && isdefined( teaminfo.owner.laststandattacker ) )
    {
        var_ec0c0e9f9b3c55a9 = teaminfo.owner.laststandattacker.team;
    }
    
    teaminfo thread function_14ed8a3bc197bff6( "team_wiped", 0, var_ec0c0e9f9b3c55a9 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x2a218ebf, Offset: 0xa20e
// Size: 0x129
function function_209d8ec78a054eb2()
{
    level endon( #"br_ending_start" );
    level waittill( #"team_won", winningteam );
    
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.teaminfo ) ) )
    {
        return;
    }
    
    if ( isdefined( winningteam ) )
    {
        foreach ( teaminfo in level.arrow.teaminfo )
        {
            if ( !( isdefined( teaminfo ) && isdefined( teaminfo.task ) ) || teaminfo.targetteam == winningteam )
            {
                continue;
            }
            
            if ( teaminfo.state != 0 && teaminfo.state != 6 )
            {
                teaminfo thread function_14ed8a3bc197bff6( "team_wiped", 0, winningteam );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x51ee5aaa, Offset: 0xa33f
// Size: 0xa7
function function_8df0bcbf52ca9ae5()
{
    active = 0;
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        if ( teaminfo.state >= 1 )
        {
            active++;
        }
    }
    
    return active;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xcfde8fe3, Offset: 0xa3ef
// Size: 0x33
function function_1f4e63fca715af5()
{
    var_7237854e3be197ca = self.var_cb2723b89bd9c8e9;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self.owner.origin;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xeef71873, Offset: 0xa42b
// Size: 0x3b
function function_86c4e142e522942a( newowner )
{
    teaminfo = self;
    teaminfo.owner = newowner;
    teaminfo.var_cb2723b89bd9c8e9 = undefined;
    teaminfo thread function_5f838725d24da084();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbdc337ac, Offset: 0xa46e
// Size: 0xa7, Type: bool
function function_2567ed6f703b2825()
{
    teaminfo = self;
    elementsstates = teaminfo function_e76e8581c95d309b();
    
    foreach ( state in elementsstates )
    {
        if ( !( state == 3 ) || state >= 5 && state <= 8 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf08a7bfd, Offset: 0xa51e
// Size: 0x127, Type: bool
function function_d309c2c47e5dd2d3()
{
    teaminfo = self;
    elementsstates = teaminfo function_e76e8581c95d309b();
    
    foreach ( state in elementsstates )
    {
        switch ( state )
        {
            case 1:
            case 2:
            case 4:
                return false;
            case 0:
            case 3:
            case 5:
            case 6:
            case 7:
            case 8:
                break;
            default:
                assertmsg( "<dev string:x16c>" + state );
                break;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3646bf30, Offset: 0xa64e
// Size: 0x150
function function_95dc62093312cda6()
{
    bombsite = spawnscriptable( arrow_getbombsitescriptable(), ( 0, 0, -5000 ), ( 0, 0, 0 ) );
    bombsite function_4b822bf658740892( "disabled" );
    bombsite function_4b822bf658740892( "blank", "arrow_bombsite_screen" );
    neededelements = [];
    
    foreach ( element in level.arrow.elementlist )
    {
        neededelements[ element.elementid ] = 0;
    }
    
    bombsite.neededelements = neededelements;
    bombsite.enabled = 1;
    bombsite.dropping = undefined;
    bombsite.siterevealed = undefined;
    bombsite.var_3047d56bbd4f79da = undefined;
    bombsite.bombsitearmed = undefined;
    bombsite.skiptonuke = undefined;
    bombsite.detonated = undefined;
    bombsite.disarmed = undefined;
    return bombsite;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xe957d9a5, Offset: 0xa7a7
// Size: 0x94
function arrow_getbombsitescriptable()
{
    wantedscriptable = undefined;
    
    if ( utility::issharedfuncdefined( #"elitearrow", #"getbombsitescriptable" ) )
    {
        wantedscriptable = [[ utility::getsharedfunc( #"elitearrow", #"getbombsitescriptable" ) ]]();
    }
    
    if ( !isdefined( wantedscriptable ) )
    {
        wantedscriptable = level.arrow.elementorder.size > 0 && level.arrow.elementorder[ 0 ] == "gal" ? "brloot_elite_arrow_bombsite_delta" : "brloot_elite_arrow_bombsite";
    }
    
    return wantedscriptable;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x47639c7c, Offset: 0xa844
// Size: 0xdb
function function_628ccb7591439095()
{
    bombsite = self;
    bombsite thread function_643317b58b054cce();
    bombsite function_d58e6cee278dfae8();
    bombsite function_a4558788c086becf();
    bombsite arrow_fusecleanup();
    bombsite function_2808c5beb14d6543();
    bombsite function_16eb0b6fbbf4ba09();
    
    if ( isdefined( bombsite.arment ) )
    {
        bombsite.arment thread function_c62f00f84c4dba48( 1 );
    }
    
    if ( isdefined( bombsite.fuseent ) )
    {
        bombsite.fuseent thread function_c62f00f84c4dba48( 1 );
    }
    
    bombsite waittill( #"death" );
    
    if ( function_27a85745631565af() )
    {
        bombsite.disarmed = 1;
        bombsite function_4b822bf658740892( "disabled" );
        bombsite function_4b822bf658740892( "disarmed", "arrow_bombsite_screen" );
        return;
    }
    
    bombsite freescriptable();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x82a0f1c9, Offset: 0xa927
// Size: 0xaa
function function_16eb0b6fbbf4ba09()
{
    bombsite = self;
    bombsite function_ee7f8c159963d50f();
    
    if ( isdefined( bombsite.elementicons ) )
    {
        foreach ( icon in bombsite.elementicons )
        {
            if ( !isdefined( icon ) )
            {
                continue;
            }
            
            icon function_ee7f8c159963d50f();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0x5afc24b4, Offset: 0xa9d9
// Size: 0x97
function function_f36bc70f8fd71ee2( instance, part, state, player, bautouse, usestring )
{
    if ( part != "arrow_bombsite_body" )
    {
        return;
    }
    
    [ itemindex, slotlootid ] = instance function_54a1fc6321e11536( player );
    
    if ( !( isdefined( slotlootid ) && isdefined( player ) && isdefined( itemindex ) ) )
    {
        return;
    }
    
    instance function_3185cc05ae1ef77c( player, itemindex, slotlootid );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf1e4a7d8, Offset: 0xaa78
// Size: 0x111
function function_54a1fc6321e11536( player )
{
    bombsite = self;
    
    if ( !isdefined( level.arrow.teaminfo[ player.team ] ) )
    {
        return [ undefined, undefined ];
    }
    
    if ( !function_1ccf14b419137856( player ) )
    {
        return [ undefined, undefined ];
    }
    
    if ( bombsite.bombsitearmed || bombsite.var_3047d56bbd4f79da )
    {
        return [ undefined, undefined ];
    }
    
    [ itemindex, slotlootid ] = function_aada90c08808dc70( player, 0 );
    
    while ( isdefined( itemindex ) )
    {
        if ( function_800155bad6fc55c9( function_a246dc01c1d8e60e( slotlootid, 5 ) ) )
        {
            return [ itemindex, slotlootid ];
        }
        
        [ itemindex, slotlootid ] = function_aada90c08808dc70( player, itemindex + 1 );
    }
    
    return [ undefined, undefined ];
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x702560a, Offset: 0xab92
// Size: 0xa7
function function_3185cc05ae1ef77c( player, itemindex, slotlootid )
{
    bombsite = self;
    elementid = function_a246dc01c1d8e60e( slotlootid, 5 );
    
    if ( isdefined( bombsite.elementicons ) )
    {
        bombsite.elementicons[ elementid ] function_ee7f8c159963d50f();
        bombsite.elementicons[ elementid ] = undefined;
    }
    
    bombsite thread function_9b5de2b26454a4b6( player, elementid, itemindex );
    bombsite thread function_643317b58b054cce( elementid );
    player thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_loot_pickup", 1.17 );
    player common_inventory::function_4f226d9d5d61901e( itemindex, 1 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa6946c35, Offset: 0xac41
// Size: 0x86
function function_b235bf93d6871888( player )
{
    bombsite = self;
    level endon( #"game_ended" );
    bombsite function_4b822bf658740892( "depositing" );
    wait 1.5;
    
    if ( bombsite function_2169466aa0685681() )
    {
        if ( !player inventory_utility::iscurrentweapon( "briefcase_bomb_mp_nuke" ) )
        {
            bombsite function_4b822bf658740892( "arm" );
            bombsite arrow_bombsitearmusability();
        }
        
        return;
    }
    
    bombsite function_4b822bf658740892( "deposit" );
    bombsite arrow_bombsiterevealusability();
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x66496dee, Offset: 0xaccf
// Size: 0x49
function function_67ad4fbf44632408( toenable, targetteam, flipothers )
{
    if ( flipothers )
    {
        function_b0a5a3a9ba8d4c8d( !toenable );
    }
    
    if ( isdefined( targetteam ) )
    {
        function_c6b7b07eb63b4add( toenable, targetteam );
        return;
    }
    
    function_b0a5a3a9ba8d4c8d( toenable );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5061a89f, Offset: 0xad20
// Size: 0x105
function function_b0a5a3a9ba8d4c8d( toenable )
{
    bombsite = self;
    
    if ( toenable )
    {
        foreach ( player in level.players )
        {
            bombsite enablescriptableplayeruse( player );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        bombsite disablescriptableplayeruse( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x42eb8f0b, Offset: 0xae2d
// Size: 0x136
function function_c6b7b07eb63b4add( toenable, targetteam )
{
    bombsite = self;
    assert( isdefined( targetteam ), "<dev string:x185>" );
    
    if ( toenable )
    {
        teamplayers = teams::getteamdata( targetteam, "players" );
        
        foreach ( player in teamplayers )
        {
            bombsite enablescriptableplayeruse( player );
        }
        
        return;
    }
    
    teamplayers = teams::getteamdata( targetteam, "players" );
    
    foreach ( player in teamplayers )
    {
        bombsite disablescriptableplayeruse( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x106a1591, Offset: 0xaf6b
// Size: 0x3e
function function_37cabd6eb1536088( player )
{
    bombsite = self;
    bombsite.targetplayer = player;
    bombsite.targetteam = player.team;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xcaa1eeba, Offset: 0xafb1
// Size: 0xdf
function function_1441234aa7914e21( alive )
{
    bombsite = self;
    
    if ( !alive )
    {
        return bombsite.targetplayer;
    }
    
    backupplayer = undefined;
    teammates = teams::getteamdata( bombsite.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        if ( !isdefined( backupplayer ) )
        {
            backupplayer = player;
        }
        
        if ( isalive( player ) && !isbot( player ) )
        {
            return player;
        }
    }
    
    return backupplayer;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3686edad, Offset: 0xb099
// Size: 0xc4
function function_691930b2ff3bda1()
{
    bombsite = self;
    teammates = teams::getteamdata( bombsite.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        if ( isdefined( player ) && bombsite.targetplayer != player )
        {
            bombsite function_37cabd6eb1536088( player );
            return;
        }
    }
    
    bombsite.targetplayer = undefined;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x22f8604d, Offset: 0xb165
// Size: 0x37
function function_4b822bf658740892( newstate, partname )
{
    bombsite = self;
    
    if ( !isdefined( partname ) )
    {
        partname = "arrow_bombsite_body";
    }
    
    bombsite setscriptablepartstate( partname, newstate );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7e369165, Offset: 0xb1a4
// Size: 0x7a
function function_4227c8a67e697962( position )
{
    contents = trace::function_bbd81e56529ef225();
    result = br_public::raytraceoffset( position, 0, 0, 1000, -1000, contents );
    var_c4b64056c1e5b10a = undefined;
    
    if ( result[ "hittype" ] != "hittype_none" )
    {
        var_c4b64056c1e5b10a = result[ "position" ];
        underwaterdepth = max( 0, var_c4b64056c1e5b10a[ 2 ] - position[ 2 ] );
        return underwaterdepth;
    }
    
    return 0;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x6de91dcf, Offset: 0xb227
// Size: 0x2a3
function function_e1074af21eb3fbda( origin, angles )
{
    bombsite = self;
    
    if ( level.arrow.dvars.var_3d1234eb70abf65a > 0 )
    {
        navmeshpoint = getclosestpointonnavmesh( origin );
        
        if ( isdefined( navmeshpoint ) )
        {
            var_bc70c5e494075214 = level.arrow.dvars.var_3d1234eb70abf65a * level.arrow.dvars.var_3d1234eb70abf65a;
            
            if ( distancesquared( navmeshpoint, origin ) <= var_bc70c5e494075214 )
            {
                isvalid = !level.arrow.dvars.var_d142560e952989b6;
                
                if ( !isvalid )
                {
                    var_cbb81ce896ac34cd = ( 0, 0, 45 );
                    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
                    result = trace::ray_trace( origin + var_cbb81ce896ac34cd, navmeshpoint + var_cbb81ce896ac34cd, undefined, contents );
                    isvalid = result[ "hittype" ] == "hittype_none";
                }
                
                if ( isvalid )
                {
                    origin = navmeshpoint;
                }
            }
        }
    }
    
    if ( level.arrow.dvars.var_441a1c3264b4ee0f > 0 )
    {
        ignoreent = level.arrow.props.crate;
        ground = function_6477e45cac6a8b5a( origin, ignoreent );
        
        if ( abs( ground.origin[ 2 ] - origin[ 2 ] ) <= level.arrow.dvars.var_441a1c3264b4ee0f )
        {
            origin = ground.origin;
            angles = ground.angles;
        }
    }
    
    bombsite.origin = origin;
    bombsite.angles = angles;
    
    if ( level.arrow.dvars.var_d850bd84825f8570 > 0 )
    {
        underwaterdepth = function_4227c8a67e697962( origin );
        
        if ( underwaterdepth > level.arrow.dvars.var_d850bd84825f8570 )
        {
            function_9ecd3b1e0a8844b5( "bombsite_spawn_error" );
        }
    }
    
    if ( level.arrow.dvars.var_4f4d8071f74a58 )
    {
        if ( outofbounds::ispointinoutofbounds( origin ) )
        {
            function_9ecd3b1e0a8844b5( "bombsite_spawn_error" );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x6b73579a, Offset: 0xb4d2
// Size: 0x46
function function_3a155193f21c59b4( player )
{
    spawnorigin = function_2c4c0091fa19dd55( player );
    assert( isdefined( spawnorigin ), "<dev string:x1db>" );
    
    if ( !isdefined( spawnorigin ) )
    {
        function_9ecd3b1e0a8844b5( "bombsite_spawn_error" );
        return;
    }
    
    return spawnorigin;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc4eb99ff, Offset: 0xb521
// Size: 0x170
function function_2c4c0091fa19dd55( player )
{
    /#
        if ( level.arrow.dvars.debug )
        {
            return ( player.origin + anglestoforward( player.angles ) * level.arrow.dvars.var_ed47ca835f8cea9 );
        }
    #/
    
    if ( level.arrow.dvars.var_1e77870d7bee3a6b == 1 )
    {
        return function_506ff1d77e645afd();
    }
    
    level.arrow.bombsitelocations = arrayrandomize( level.arrow.bombsitelocations );
    
    foreach ( location in level.arrow.bombsitelocations )
    {
        if ( br_circle::ispointinnextsafecircle( location ) )
        {
            return location;
        }
    }
    
    if ( level.arrow.dvars.var_1e77870d7bee3a6b == 2 )
    {
        return function_506ff1d77e645afd();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb5ef105e, Offset: 0xb69a
// Size: 0xe9
function function_506ff1d77e645afd()
{
    origin = br_circle::getnextsafecircleorigin();
    
    if ( level.arrow.dvars.var_921547e84218c101 < 0 )
    {
        return origin;
    }
    
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    result = trace::ray_trace( origin + ( 0, 0, 3000 ), origin, undefined, contents );
    location = result[ "fraction" ] == 1 ? origin : result[ "position" ];
    location = getclosestpointonnavmesh( location, level.arrow.dvars.var_921547e84218c101 );
    radius = br_circle::getnextsafecircleradius();
    
    if ( distance2dsquared( origin, location ) < radius * radius )
    {
        origin = location;
    }
    
    return origin;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xfc2f0ec3, Offset: 0xb78c
// Size: 0x8b
function function_9171176ef9fb50a3( elementicons, playintro, showdistance )
{
    bombsite = self;
    bombsite function_565a465b2835d5a( undefined, bombsite.targetteam, "ui_map_icon_elite_bomb_site", "hud_icon_objective_elite_radioactive_red" );
    originoffset = vectornormalize( anglestoup( bombsite.angles ) ) * 35;
    bombsite function_e9eb704cd1527200( "ground", bombsite, istrue( playintro ), istrue( showdistance ), originoffset );
    bombsite function_4165eb397760c832( elementicons );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb19adc24, Offset: 0xb81f
// Size: 0xef
function function_4165eb397760c832( elementicons )
{
    bombsite = self;
    
    if ( !elementicons )
    {
        return;
    }
    
    bombsite.elementicons = [];
    zoffset = 25;
    xoffset = -7;
    
    for ( i = 0; i < bombsite.neededelements.size ; i++ )
    {
        if ( bombsite.neededelements[ i ] > 0 )
        {
            continue;
        }
        
        bombsite.elementicons[ i ] = spawnstruct();
        bombsite.elementicons[ i ] function_565a465b2835d5a( undefined, bombsite.targetteam, "ui_map_icon_elite_bomb_site", undefined );
        offsetdist = ( xoffset, 0, zoffset );
        bombsite.elementicons[ i ] function_e9eb704cd1527200( "ground", bombsite, 0, 0, offsetdist );
        xoffset += 7;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x4a203c38, Offset: 0xb916
// Size: 0xd3
function function_5c77194991e533a7( player, isvisible )
{
    bombsite = level.arrow.props.bombsite;
    bombsite function_b09749f100e42ff1( player, isvisible );
    
    if ( isdefined( bombsite.elementicons ) )
    {
        foreach ( elementicon in bombsite.elementicons )
        {
            elementicon function_b09749f100e42ff1( player, isvisible );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x6589dae9, Offset: 0xb9f1
// Size: 0x1b0
function function_643317b58b054cce( elementid )
{
    bombsite = self;
    bombsite notify( #"screen_update" );
    bombsite endon( #"screen_update" );
    bombsite endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        bombsite function_4b822bf658740892( "blank", "arrow_bombsite_screen" );
        
        if ( bombsite.disarmed )
        {
            bombsite function_4b822bf658740892( "disarmed", "arrow_bombsite_screen" );
        }
        else if ( bombsite.detonated )
        {
        }
        else if ( bombsite.bombsitearmed )
        {
            bombsite function_4b822bf658740892( "armed", "arrow_bombsite_screen" );
        }
        else if ( bombsite.var_3047d56bbd4f79da )
        {
            bombsite function_4b822bf658740892( "arming", "arrow_bombsite_screen" );
        }
        else
        {
            if ( isdefined( elementid ) )
            {
                bombsite function_4b822bf658740892( function_ca621b047cf24253( elementid, 9 ), "arrow_bombsite_screen" );
                elementid = undefined;
            }
            else
            {
                bombsite function_4b822bf658740892( "deposit", "arrow_bombsite_screen" );
            }
            
            waitframe();
            
            foreach ( tag, element in bombsite.neededelements )
            {
                if ( element )
                {
                    bombsite function_4b822bf658740892( function_ca621b047cf24253( tag, 10 ), "arrow_bombsite_screen" );
                    waitframe();
                }
            }
        }
        
        wait 2;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x14129ecc, Offset: 0xbba9
// Size: 0x1b7
function arrow_bombsitereveal( player, elementicons )
{
    bombsite = self;
    teaminfo = level.arrow.teaminfo[ player.team ];
    level endon( #"game_ended" );
    bombsite endon( #"on_end_bombsite" );
    teaminfo.state = 2;
    function_3b0990925ca12fb7( &"br_elite_broken_arrow/waiting_bomb" );
    function_c9a9e36e63a2308e();
    
    if ( bombsite.dropping )
    {
        return;
    }
    
    bombsite.dropping = 1;
    bombsite function_4b822bf658740892( "deposit" );
    bombsite function_37cabd6eb1536088( player );
    bombsite thread function_643317b58b054cce();
    spawnorigin = function_3a155193f21c59b4( player );
    
    if ( !isdefined( spawnorigin ) )
    {
        return;
    }
    
    function_e3baaa6d675aaf89();
    bombsite arrow_bombsiterevealdrop( spawnorigin, player );
    function_958af90ba3aae46d();
    teaminfo function_f5b9fee9ad433c19( "arrow_bombsite_team", 3 );
    teaminfo function_e770743a8f743fbc( "arrow_bombsite_reveal", 3, 1 );
    bombsite.siterevealed = 1;
    bombsite.spawntime = gettime();
    bombsite arrow_bombsiterevealusability();
    bombsite arrow_bombsiterevealicons( elementicons );
    function_24df41358c9c3ed4( level.arrow.dvars.bombsitetime );
    bombsite thread function_e014e911bdc41918();
    
    if ( teaminfo function_2567ed6f703b2825() )
    {
        teaminfo.state = 3;
        function_3b0990925ca12fb7( &"br_elite_broken_arrow/deposit_elems" );
    }
    
    function_c9a9e36e63a2308e();
    function_c55c319265aa598c();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xd8fd1a37, Offset: 0xbd68
// Size: 0xb5
function function_e3baaa6d675aaf89()
{
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    foreach ( teamref, teamdata in level.teamdata )
    {
        if ( function_4b02b09a89003454( teamref ) )
        {
            hud_util::showsplashtoteam( teamref, function_7a10d0b1b0720af0( "elite_arrow_bomb_revealed" ) );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf57b8758, Offset: 0xbe25
// Size: 0xb6
function function_958af90ba3aae46d()
{
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    foreach ( teamref, teamdata in level.teamdata )
    {
        if ( !function_4b02b09a89003454( teamref ) )
        {
            hud_util::showsplashtoteam( teamref, function_7a10d0b1b0720af0( "elite_arrow_bomb_revealed_global" ) );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xa01cb071, Offset: 0xbee3
// Size: 0x12c
function arrow_bombsiterevealdrop( spawnorigin, player )
{
    bombsite = self;
    level endon( #"game_ended" );
    bombsite endon( #"death" );
    
    if ( level.arrow.dvars.bombsitesupplydrop )
    {
        foreach ( activeteam in level.arrow.teaminfo )
        {
            if ( activeteam.state == 0 )
            {
                continue;
            }
            
            activeteam function_68bc27f2732052a7();
        }
        
        br_supply_drops_common::brsupplydrop_run( spawnorigin, "br_elite_arrow_bombsite_drop" );
        bombsite thread function_92602ab6170b0fa7();
        bombsite waittill( #"hash_4f54a6f4b4ac405e" );
        return;
    }
    
    bombsite function_e1074af21eb3fbda( spawnorigin, player.angles );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x771780b0, Offset: 0xc017
// Size: 0xba
function arrow_bombsiterevealusability()
{
    bombsite = self;
    bombsite function_67ad4fbf44632408( 0 );
    
    foreach ( activeteam in level.arrow.teaminfo )
    {
        if ( activeteam.state == 0 )
        {
            continue;
        }
        
        bombsite function_67ad4fbf44632408( 1, activeteam.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa3b2b75e, Offset: 0xc0d9
// Size: 0xc6
function arrow_bombsiterevealicons( elementicons )
{
    bombsite = self;
    bombsite function_9171176ef9fb50a3( elementicons, 1, 1 );
    
    foreach ( activeteam in level.arrow.teaminfo )
    {
        if ( activeteam.state == 0 )
        {
            continue;
        }
        
        function_958188efb2944b5a( activeteam.targetteam, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa4499546, Offset: 0xc1a7
// Size: 0xa7
function arrow_bombsitearm( player )
{
    bombsite = self;
    teaminfo = level.arrow.teaminfo[ player.team ];
    teaminfo.state = 4;
    bombsite arrow_bombsitearmusability();
    function_3b0990925ca12fb7( &"br_elite_broken_arrow/arm_the_bomb" );
    function_c9a9e36e63a2308e();
    function_c55c319265aa598c();
    
    if ( bombsite.var_3047d56bbd4f79da )
    {
        return;
    }
    
    bombsite.var_3047d56bbd4f79da = 1;
    bombsite thread function_643317b58b054cce();
    bombsite arrow_arm( player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xeb6b243, Offset: 0xc256
// Size: 0xe8
function arrow_bombsitearmusability()
{
    bombsite = self;
    bombsite function_67ad4fbf44632408( 0 );
    
    if ( level.arrow.dvars.debugarm )
    {
        bombsite function_67ad4fbf44632408( 1 );
        return;
    }
    
    foreach ( activeteam in level.arrow.teaminfo )
    {
        if ( activeteam.state == 0 )
        {
            continue;
        }
        
        bombsite function_67ad4fbf44632408( 1, activeteam.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa65524c4, Offset: 0xc346
// Size: 0x135
function function_40875ae3450b5aad( player )
{
    bombsite = self;
    teaminfo = level.arrow.teaminfo[ player.team ];
    teaminfo.state = 5;
    
    if ( bombsite.bombsitearmed )
    {
        return;
    }
    
    bombsite.bombsitearmed = 1;
    bombsite function_4b822bf658740892( "defuse" );
    bombsite thread function_643317b58b054cce();
    fusetimer = level.arrow.dvars.fusetimer;
    
    if ( isdefined( level.arrow.dvars.var_7fd196d924c628d4 ) )
    {
        fusetimer = level.arrow.dvars.var_7fd196d924c628d4;
    }
    
    function_c86c2af403b3208b( fusetimer, teaminfo );
    bombsite function_8dcdb90f11168179( teaminfo );
    bombsite function_b0f74d54c6a6a271();
    teaminfo function_1defd0778920b1ee( player );
    bombsite function_e9fffdec2173cc25();
    bombsite function_16eb0b6fbbf4ba09();
    bombsite arrow_fuse( player );
    function_cbe12ec0b07ab447();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x367534aa, Offset: 0xc483
// Size: 0x5f
function function_c86c2af403b3208b( timer, teaminfo )
{
    bombsite = self;
    function_24df41358c9c3ed4( timer );
    bombsite thread function_4d323923b8a1e408( int( timer - 1 ), 0 );
    teaminfo function_65a520f59398740c( int( timer ) );
    function_c9a9e36e63a2308e();
    function_c55c319265aa598c();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xbec7192f, Offset: 0xc4ea
// Size: 0x9e
function function_8dcdb90f11168179( teaminfo )
{
    foreach ( otherteam in level.arrow.teaminfo )
    {
        if ( otherteam == teaminfo )
        {
            continue;
        }
        
        otherteam thread function_14ed8a3bc197bff6( "enemy_armed_bomb" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x75ed6350, Offset: 0xc590
// Size: 0x9
function function_b0f74d54c6a6a271()
{
    music_br::function_93cd8f6274d9a5fe();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x28807fcf, Offset: 0xc5a1
// Size: 0x7d
function function_1defd0778920b1ee( player )
{
    teaminfo = self;
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_bomb_defend" ), undefined, player );
    hud_util::showsplashtoallexceptteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_bomb_defuse" ), undefined, player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xd1dd24e9, Offset: 0xc626
// Size: 0x54
function function_e9fffdec2173cc25()
{
    bombsite = self;
    
    if ( level.arrow.dvars.debugdefuse )
    {
        bombsite function_67ad4fbf44632408( 1 );
        return;
    }
    
    bombsite function_67ad4fbf44632408( 0, bombsite.targetteam, 1 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x176301c7, Offset: 0xc682
// Size: 0x1ce
function function_e014e911bdc41918()
{
    bombsite = self;
    level endon( #"game_ended" );
    timer = level.arrow.dvars.bombsitetime;
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        teaminfo function_c16ff926d3d4dd3f( timer );
    }
    
    result = bombsite utility::waittill_any_timeout( timer, "arm_complete", "on_end_bombsite" );
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        teaminfo function_5f0603cc08ffce2a();
    }
    
    if ( result == "timeout" )
    {
        if ( isdefined( bombsite.arment ) && bombsite.arment.inuse )
        {
            result2 = bombsite.arment utility::waittill_any_return( "trigger_success", "trigger_fail" );
            
            if ( result2 == "trigger_success" )
            {
                return;
            }
            else
            {
                waitframe();
            }
        }
        
        function_9ecd3b1e0a8844b5( "bombsite_timed_out" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x54967368, Offset: 0xc858
// Size: 0x10, Type: bool
function function_1f16a2fca52b3ce6()
{
    thread function_9ecd3b1e0a8844b5( "bombsite_deleted_in_area_swap" );
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd324b22a, Offset: 0xc871
// Size: 0x31
function function_24df41358c9c3ed4( durationseconds )
{
    level.arrow.bombsitetimestamp = int( gettime() + utility::function_4b74c15943231980( durationseconds ) );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc24c3301, Offset: 0xc8aa
// Size: 0x4e
function function_c7c54a78bcfa63f5()
{
    bombsitetimestamp = level.arrow.bombsitetimestamp ?? gettime();
    timeleftms = max( 0, bombsitetimestamp - gettime() );
    return int( round( utility::function_6f5d2e1f1ff70482( timeleftms ) ) );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xfee4e5c3, Offset: 0xc901
// Size: 0xe6
function function_14db70e5111b5554()
{
    bombsite = self;
    
    if ( bombsite.skiptonuke )
    {
        return;
    }
    
    bombsite.skiptonuke = 1;
    level.arrow.dvars.var_7fd196d924c628d4 = 7;
    player = function_1441234aa7914e21( 1 );
    
    if ( function_90990ec28c31426a() )
    {
        if ( function_c7c54a78bcfa63f5() <= 7 )
        {
            return;
        }
        
        teaminfo = level.arrow.teaminfo[ player.team ];
        bombsite function_c86c2af403b3208b( level.arrow.dvars.var_7fd196d924c628d4, teaminfo );
        bombsite thread function_5fb441d82c434422( bombsite.fuseent );
        return;
    }
    
    bombsite thread function_40875ae3450b5aad( player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x36e9f970, Offset: 0xc9ef
// Size: 0xc3
function function_94495ee901c84168()
{
    dropstruct = self;
    dropstruct.var_2fd5afa46e56e8f6 = 1;
    dropstruct.vertbase = getdvarint( @"hash_83026ae3da184b2d", 1000 );
    dropstruct.var_30cb3e606750fb2d = getdvarint( @"hash_71b0625ba447d37a", 100 );
    dropstruct.var_d51f27c0c0b1350f = getdvarint( @"hash_dde9024816a0b75a", 200 );
    dropstruct.var_c491715796150d41 = getdvarint( @"hash_e4a0734d3e02bac7", 562500 );
    dropstruct.initialmove = 0;
    dropstruct.spawnsmoke = 0;
    dropstruct.var_a43c47d2d034c865 = 1;
    dropstruct.var_9a2df96a0970a4e0 = 1;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xec9df6ed, Offset: 0xcaba
// Size: 0xb2
function function_92602ab6170b0fa7()
{
    bombsite = self;
    level endon( #"game_ended" );
    bombsite endon( #"death" );
    level waittill( #"hash_895e058db3dd0ec9" );
    crate = level.arrow.props.crate;
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    spawninfo = function_6477e45cac6a8b5a( crate.origin, [ crate ] );
    bombsite function_e1074af21eb3fbda( spawninfo.origin, spawninfo.angles );
    bombsite notify( #"hash_4f54a6f4b4ac405e" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1d277802, Offset: 0xcb74
// Size: 0x87
function function_e72954035e8ee219( dropend )
{
    dropstart = dropend + ( 0, 0, level.var_4280cdebdfea8385 );
    angles = ( 0, 0, 0 );
    crate = airdrop::createcrate( undefined, undefined, "elite_arrow_bombsite", dropstart, angles, dropend, undefined, 1 );
    crate function_866c91dba9271614();
    level.arrow.props.crate = crate;
    return crate;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x68735b1c, Offset: 0xcc04
// Size: 0xc0
function function_866c91dba9271614()
{
    crate = self;
    crate function_565a465b2835d5a( undefined, undefined, "ui_map_icon_elite_bomb_site", undefined );
    
    foreach ( activeteam in level.arrow.teaminfo )
    {
        crate function_f45d93bbeae7e3a2( activeteam.targetteam, 1 );
    }
    
    crate function_e9eb704cd1527200( "player", crate, 0, 0 );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xa3f78c9, Offset: 0xcccc
// Size: 0x79
function function_89de807c38769c83( player, isvisible )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.crate ) ) )
    {
        return;
    }
    
    crate = level.arrow.props.crate;
    crate function_b09749f100e42ff1( player, isvisible );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x772211b9, Offset: 0xcd4d
// Size: 0xd1
function function_69c6d9ad0402012e( dropend, dropstruct )
{
    crate = self;
    wait 2;
    crate br_supply_drops_common::function_2d4cad58d926b801( dropend, dropstruct );
    endtime = gettime() + 20000;
    
    while ( gettime() < endtime )
    {
        bodyid = crate physics_getbodyid( 0 );
        velocity = physics_getbodylinvel( bodyid );
        
        if ( lengthsquared( velocity ) <= 0.5 )
        {
            break;
        }
        
        waitframe();
    }
    
    wait 1.5;
    crate setscriptablepartstate( "dmz_supply_drop", "fully_opening_unusable" );
    crate function_ee7f8c159963d50f();
    
    if ( isdefined( crate.smokesignal ) )
    {
        crate.smokesignal delete();
    }
    
    level notify( #"hash_895e058db3dd0ec9" );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x39ea0299, Offset: 0xce26
// Size: 0x10, Type: bool
function function_f60906bc4f59fcdf()
{
    thread function_9ecd3b1e0a8844b5( "supply_drop_deleted_in_area_swap" );
    return true;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x7a4154f7, Offset: 0xce3f
// Size: 0xad
function function_4d323923b8a1e408( fusetimer, delay )
{
    bombsite = self;
    bombsite notify( #"nuke_countdown" );
    bombsite endon( #"nuke_countdown" );
    level endon( #"game_ended" );
    bombsite thread function_b71e7f686af9cabc( fusetimer );
    level thread function_1f9b3e8e5d1c4fbb( fusetimer );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread function_18a803df417ede88( fusetimer );
    starttime = gettime();
    endtime = fusetimer * 1000 + starttime;
    bombsite.bombendtime = endtime;
    bombsite utility::waittill_any_timeout( fusetimer, "on_end_bombsite" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x85783bdf, Offset: 0xcef4
// Size: 0xa6
function function_18a803df417ede88( var_9a0b50814cbfe53f )
{
    if ( isdefined( level.arrow.transientloaded ) || !level.arrow.dvars.var_473b1e06b0a45c80 || !level.arrow.dvars.var_ea64420303c90048 )
    {
        return;
    }
    
    maxloadingtime = getdvarfloat( @"bg_transients_infil_maxloadingtime" ) + 0.05;
    var_18c444ded37ecdb3 = var_9a0b50814cbfe53f - maxloadingtime;
    
    if ( var_18c444ded37ecdb3 > 0 )
    {
        wait var_18c444ded37ecdb3;
    }
    
    thread function_e00a96b2675830f3();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xa6c6bd6a, Offset: 0xcfa2
// Size: 0x7b
function function_e00a96b2675830f3()
{
    if ( isdefined( level.arrow.transientloaded ) )
    {
        return;
    }
    
    level.arrow.transientloaded = 0;
    transientname = br_ending_cq::function_aa8e694e37bf149f();
    loadinfiltransient( transientname );
    
    for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( transientname ) )
    {
        waitframe();
    }
    
    level.arrow.transientloaded = 1;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xb038a28b, Offset: 0xd025
// Size: 0x77
function function_f05f15fec911b2a2( origin, soundalias, delay = 0 )
{
    wait delay;
    ent = spawn( "script_model", origin );
    ent forcenetfieldhighlod( 1 );
    waitframe();
    ent playloopsound( soundalias );
    level utility::waittill_any_timeout( 39.9, "nuke_detonated" );
    ent stoploopsound();
    waitframe();
    ent delete();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7bc7abaf, Offset: 0xd0a4
// Size: 0xb1
function function_1f9b3e8e5d1c4fbb( fusetimer )
{
    level endon( #"nuke_detonated" );
    var_fef0639f2d6dca85[ 0 ] = [ 58.5, "mx_mp_br_cq_bombcountdown_1", "mx_mp_br_cq_bomb_defuse_1" ];
    musicindex = 0;
    assert( musicindex >= 0 && musicindex < var_fef0639f2d6dca85.size, "<dev string:x221>" );
    countdowntime = var_fef0639f2d6dca85[ musicindex ][ 0 ];
    fusewaittime = fusetimer - countdowntime - 1.5;
    
    if ( fusewaittime < 0 )
    {
        return;
    }
    
    wait fusewaittime;
    music_br::function_f0d88829286f07de();
    level waittill( #"nuke_aborted" );
    music_br::function_736c3fc77a5028e9();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdccd13a0, Offset: 0xd15d
// Size: 0x44
function function_278bed2ee617ed74()
{
    bombsite = self;
    plungerpos = bombsite.origin + ( 0, 0, 60 );
    wait 0.4;
    playsoundatpos( plungerpos, "evt_br_portable_nuke_detonation_plunger" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x22601266, Offset: 0xd1a9
// Size: 0x21f
function function_b71e7f686af9cabc( fusetimer )
{
    bombsite = self;
    level endon( #"game_ended" );
    level endon( #"nuke_aborted" );
    inttimer = int( fusetimer );
    fractimer = fusetimer - inttimer;
    timer = inttimer;
    teaminfo = level.arrow.teaminfo[ bombsite.targetteam ];
    wait fractimer;
    
    while ( timer > 0 )
    {
        soundalias = "";
        var_410a53ece5a85c4b = timer % 30;
        
        if ( timer <= 60 )
        {
            var_410a53ece5a85c4b = timer % 10;
        }
        
        if ( timer == 31 )
        {
            origin1 = ( 3456, 48128, 5760 );
            thread function_f05f15fec911b2a2( origin1, "evt_br_nuke_siren_dist", 0 );
            origin2 = ( -52160, 5304, 5760 );
            thread function_f05f15fec911b2a2( origin2, "evt_br_nuke_siren_dist", 3 );
            teaminfo function_e770743a8f743fbc( "arrow_detonation_warning" );
        }
        
        if ( timer == 5 )
        {
            if ( level.arrow.dvars.debug )
            {
                level.arrow.dvars.var_218ba9a171abfc61 = 0;
            }
            
            level thread function_7cc825096998ff5c( 0.4 );
        }
        
        if ( timer == 3 )
        {
            audio_utility::function_f8fa1bfbdb18edb5( level.players, "br_elite_contract_ending", 3 );
        }
        
        if ( timer == 2 )
        {
            bombsite thread function_278bed2ee617ed74();
        }
        
        if ( timer == 30 || timer == 20 )
        {
            soundalias = "evt_br_nuke_bomb_timer_urgent";
        }
        else if ( timer <= 10 )
        {
            soundalias = "evt_br_nuke_bomb_timer_urgent";
        }
        else if ( timer <= 30 )
        {
            soundalias = "evt_br_nuke_bomb_timer";
        }
        else if ( var_410a53ece5a85c4b == 0 )
        {
            soundalias = "evt_br_nuke_bomb_timer_reminder";
        }
        
        if ( soundalias != "" )
        {
            audio_utility::function_63bf1584c79c055( level.players, soundalias );
        }
        
        timer -= 1;
        wait 1;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7bb14ce9, Offset: 0xd3d0
// Size: 0x21
function function_93043387a3fd7168( bombsite )
{
    audio_utility::function_63bf1584c79c055( level.players, "evt_br_elite_arrow_nuke_explo" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x42de2dd1, Offset: 0xd3f9
// Size: 0xc
function arrow_blank( winner )
{
    
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc3e73c3e, Offset: 0xd40d
// Size: 0x1d7
function function_e75962e825c03f5e()
{
    bombsite = self;
    level.var_d5c2787fbd88bebd = 1;
    level.shownonspectatingwinnersplash = 1;
    level endon( #"game_ended" );
    owner = bombsite function_1441234aa7914e21();
    
    if ( level.arrow.dvars.var_ea64420303c90048 )
    {
        level.var_e0308e22e5b02b6c = undefined;
        level.br_endgamesplashcallback = &arrow_blank;
        level.var_b1c24afd146c3795 = 1;
        level thread br_ending_util::function_ee3a6a615e19250a( 0, 0.066, "nuke_fadeEnd" );
        audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_killstreak_nuke", 0 );
        utility::delaythread( 1, &audio_utility::function_63bf1584c79c055, level.players, "evt_br_cq_detonation_flyby_heli_incoming" );
    }
    else
    {
        level.mercywintriggered = 1;
        streakinfo = function_46cd27e657851a51( owner );
        function_ea9670f6089a9ee5();
        level thread function_93043387a3fd7168( bombsite );
        bombsite arrow_nukevision( owner, streakinfo );
        level.var_e0308e22e5b02b6c = &function_f981030422f8d7a7;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player player::_freezecontrols( 1, undefined, "cq_nuke" );
        player utility::hidehudenable();
    }
    
    level thread gamelogic_mp::endgame( owner.team, game[ "end_reason" ][ "nuke_end" ], undefined, 1, 1 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa2ab3527, Offset: 0xd5ec
// Size: 0xa5
function function_46cd27e657851a51( owner )
{
    streakinfo = killstreak_utility::createstreakinfo( "nuke", owner );
    streakinfo.var_5fefba97e6418b1c = 1;
    streakinfo.skipequippedstreakcheck = 1;
    
    if ( level.arrow.dvars.nukevision )
    {
        streakinfo.skipprelaunch = 1;
        streakinfo.skipvision = 1;
        streakinfo.skipslowmo = 1;
        streakinfo.skipexplosion = 1;
    }
    
    owner nuke::tryusenukefromstruct( streakinfo );
    return streakinfo;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x9a823e1d, Offset: 0xd69a
// Size: 0x95
function function_ea9670f6089a9ee5()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.ignoredeathsdoor = 1;
        player br_public::function_bb22d91d6d217fe1( 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x9526d493, Offset: 0xd737
// Size: 0x56
function arrow_nukevision( owner, streakinfo )
{
    bombsite = self;
    
    if ( level.arrow.dvars.nukevision )
    {
        bombsite function_b92b81a4caf49747( owner, streakinfo );
        return;
    }
    
    wait 7.5;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x5149171a, Offset: 0xd795
// Size: 0xed
function function_b92b81a4caf49747( owner, streakinfo )
{
    bombsite = self;
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || !isalive( player ) )
        {
            continue;
        }
        
        percent = 0;
        bombsite thread function_9800720152ae5d06( player, percent, owner, streakinfo );
    }
    
    if ( !level.arrow.dvars.var_ea64420303c90048 )
    {
        function_ade810e565a42222();
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0xa31bca28, Offset: 0xd88a
// Size: 0x78
function function_9800720152ae5d06( player, percent, owner, streakinfo )
{
    level endon( #"game_ended" );
    player function_69cfb089afe68d45( 1, "nuke_champ_quest_flash", 0.1 );
    wait 0.1;
    player function_69cfb089afe68d45( 1, "", 0.9 );
    player function_69cfb089afe68d45( 1, "nuke_champ_quest_death", 0.9 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdbb4f9a0, Offset: 0xd90a
// Size: 0xa5
function function_ade810e565a42222()
{
    wait 0.1;
    setomnvarforallclients( "post_game_state", 11 );
    wait 1.9;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        level thread game_utility::fadetoblackforplayer( player, 1, 0.1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe3ca0d6b, Offset: 0xd9b7
// Size: 0x1d
function function_f981030422f8d7a7( winnerplayers, var_c71a8bc30a7b241b )
{
    level thread function_52e3e88b898ed207();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x41e685bf, Offset: 0xd9dc
// Size: 0xaf
function function_52e3e88b898ed207()
{
    level endon( #"game_ended" );
    wait 0.75;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_world_fade", 1 );
        level thread game_utility::fadetoblackforplayer( player, 0, 0.1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbea4bb8f, Offset: 0xda93
// Size: 0x69
function function_95862b4d0fe2d4f9()
{
    setomnvarforallclients( "post_game_state", 13 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 13 );
    wantedbink = "mp_br_elite_arrow_nuke_saba";
    
    if ( utility::issharedfuncdefined( #"elitearrow", #"hash_13ae24680baaf81c" ) )
    {
        wantedbink = [[ utility::getsharedfunc( #"elitearrow", #"hash_13ae24680baaf81c" ) ]]();
    }
    
    playcinematicforall( wantedbink );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x6d1408b9, Offset: 0xdb04
// Size: 0x67
function function_74089124e164ac60( winnerplayers )
{
    if ( level.arrow.dvars.var_ea64420303c90048 )
    {
        level.var_572d9d46430e6e25 = spawnstruct();
        level.var_572d9d46430e6e25.var_cb34d2b743970ba5 = "cq_nuke";
        br_ending::play_ending( winnerplayers );
        return;
    }
    
    function_ba18aa3c9b88b3b2( winnerplayers );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x998aa846, Offset: 0xdb73
// Size: 0x94
function function_ba18aa3c9b88b3b2( winnerplayers )
{
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mp_killstreak_nuke", 6 );
    wait 6.1;
    function_95862b4d0fe2d4f9();
    wait 2;
    function_7ee9d604eb605fec( winnerplayers );
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 1 );
    wait 5;
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 2 );
    wait 2;
    
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    wait 1;
    setomnvarforallclients( "post_game_state", 14 );
    wait 10;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd0f8c8e0, Offset: 0xdc0f
// Size: 0x1e
function function_7ee9d604eb605fec( winners )
{
    br_accolades::function_8ffb08c901d9d792( winners );
    br_ending::function_c64a9bbb6771df41( winners );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb251428f, Offset: 0xdc35
// Size: 0x124
function function_e6db6205cc3891ed()
{
    teammates = teams::getteamdata( self.team, "players" );
    lootid = level.br_pickups.var_2e379e316c36bf4a[ "brloot_plunder_cash_uncommon_1" ];
    
    foreach ( teammate in teammates )
    {
        if ( isdefined( lootid ) )
        {
            view_origin = teammate getvieworigin();
            teammate br_pickups::function_55de798ca5dc4080( lootid, view_origin, 1, level.arrow.dvars.var_a4f0102b2a46d2be );
        }
        
        teammate thread points::doscoreevent( #"hash_4ebc44521d9a1b18" );
        teammate br_plunder::playerplunderpickup( level.arrow.dvars.var_a4f0102b2a46d2be );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xdca519e9, Offset: 0xdd61
// Size: 0x1de
function function_50830da7bfae9317( victim )
{
    if ( !isdefined( level.arrow.teaminfo[ victim.team ] ) )
    {
        return;
    }
    
    teaminfo = level.arrow.teaminfo[ victim.team ];
    xpreward = level.arrow.dvars.var_e3dccd99f0e44410;
    plunderreward = level.arrow.dvars.var_609955ed715f765a;
    
    if ( teaminfo.state == 5 )
    {
        xpreward *= level.arrow.dvars.var_a9c9568e8d945a9c;
        plunderreward += level.arrow.dvars.var_ffc1d7c34cebf8b9 * 5;
    }
    else
    {
        stepscompleted = teaminfo.firstpickups;
        
        if ( teaminfo.state == 4 )
        {
            stepscompleted++;
        }
        
        xpreward *= 1 + level.arrow.dvars.var_dee7d30029f94eaa * stepscompleted;
        plunderreward += level.arrow.dvars.var_ffc1d7c34cebf8b9 * stepscompleted;
    }
    
    lootid = level.br_pickups.var_2e379e316c36bf4a[ "brloot_plunder_cash_uncommon_1" ];
    
    if ( isdefined( lootid ) )
    {
        view_origin = self getvieworigin();
        br_pickups::function_55de798ca5dc4080( lootid, view_origin, 1, plunderreward );
    }
    
    thread points::doscoreevent( #"hash_8677b7ba02f174e2", undefined, undefined, xpreward );
    br_plunder::playerplunderpickup( plunderreward );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8c9191fc, Offset: 0xdf47
// Size: 0xc9
function arrow_arm( player )
{
    bombsite = self;
    usetime = level.arrow.dvars.armtime;
    decayrate = level.arrow.dvars.var_bdbf3c072faefa58;
    endconditions = [];
    bombsite.arment = function_17be96a6af4c899b( bombsite, "elite_arrow_arm", usetime, decayrate, endconditions, player );
    bombsite.arment.triggercomplete = &arrow_armcomplete;
    bombsite arrow_armusability();
    bombsite thread arrow_armwatchowner( bombsite.arment );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc3524129, Offset: 0xe018
// Size: 0x171
function arrow_armusability()
{
    bombsite = self;
    
    if ( !isdefined( bombsite.arment ) )
    {
        return;
    }
    
    if ( level.arrow.dvars.debugarm )
    {
        foreach ( player in level.players )
        {
            bombsite.arment function_6fcebb19629beade( player, 1 );
        }
        
        return;
    }
    
    foreach ( activeteam in level.arrow.teaminfo )
    {
        if ( activeteam.state == 0 )
        {
            continue;
        }
        
        bombsite.arment function_ef1082c3639c1297( activeteam.targetteam, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4cbc24dd, Offset: 0xe191
// Size: 0x5c
function arrow_armwatchowner( arment )
{
    bombsite = self;
    level endon( #"game_ended" );
    bombsite endon( #"arm_complete" );
    
    while ( true )
    {
        arment waittill( #"hash_6e608a45385c9138" );
        bombsite function_37cabd6eb1536088( arment.lastuser );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1eedc472, Offset: 0xe1f5
// Size: 0xe8
function arrow_armcomplete( result )
{
    bombsite = self;
    level endon( #"game_ended" );
    bombsite notify( #"arm_complete" );
    
    if ( result == "trigger_done" )
    {
        player = bombsite.arment.lastuser;
        teaminfo = level.arrow.teaminfo[ player.team ];
        br_analytics::function_3976c233fa7afe0e( player, gettime() - bombsite.spawntime );
        bombsite function_37cabd6eb1536088( player );
        teaminfo function_f5b9fee9ad433c19( "arrow_bombsite_arm", 5 );
        teaminfo function_e770743a8f743fbc( "arrow_bombsite_arm_enemy", 5 );
        waitframe();
        bombsite function_40875ae3450b5aad( player );
        return;
    }
    
    function_9ecd3b1e0a8844b5( "arm_error" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4040af04, Offset: 0xe2e5
// Size: 0x4a
function arrow_fuse( player )
{
    bombsite = self;
    bombsite function_690beb4225a7a7d4( player );
    bombsite arrow_fusespawntrigger( player );
    bombsite arrow_fuseusability();
    bombsite thread function_5fb441d82c434422( bombsite.fuseent );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x54efde89, Offset: 0xe337
// Size: 0xcb
function function_690beb4225a7a7d4( player )
{
    bombsite = self;
    spawninfo = function_6477e45cac6a8b5a( player.origin );
    bombsite.briefcaseent = spawnscriptable( "brloot_elite_arrow_briefcase", spawninfo.origin, spawninfo.angles );
    bombsite.briefcaseent.bombsite = bombsite;
    bombsite.briefcaseent arrow_fusesetstate( "defuse" );
    bombsite.briefcaseent function_565a465b2835d5a( "hud_icon_objective_elite_radioactive_red" );
    bombsite.briefcaseent function_e9eb704cd1527200( "ground", bombsite.briefcaseent, 1, 1 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe9312a9c, Offset: 0xe40a
// Size: 0xc7
function arrow_fusespawntrigger( player )
{
    bombsite = self;
    usetime = level.arrow.dvars.defusetime;
    decayrate = level.arrow.dvars.var_cae49f4917631000;
    endconditions = [ "fuse_detonated", "fuse_cancelled" ];
    bombsite.fuseent = function_17be96a6af4c899b( bombsite.briefcaseent, "elite_arrow_fuse", usetime, decayrate, endconditions, player );
    bombsite.fuseent.triggercomplete = &arrow_fusecomplete;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x97f74336, Offset: 0xe4d9
// Size: 0x1c0
function arrow_fuseusability()
{
    bombsite = self;
    
    if ( !isdefined( bombsite.fuseent ) )
    {
        return;
    }
    
    if ( level.arrow.dvars.debugdefuse )
    {
        foreach ( player in level.players )
        {
            bombsite.fuseent function_6fcebb19629beade( player, 1 );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.arrow.teaminfo[ player.team ] ) && level.arrow.teaminfo[ player.team ].state >= 5 )
        {
            bombsite.fuseent function_6fcebb19629beade( player, 0 );
            bombsite.briefcaseent disablescriptableplayeruse( player );
            continue;
        }
        
        bombsite.fuseent function_6fcebb19629beade( player, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7b22b1c6, Offset: 0xe6a1
// Size: 0x34
function arrow_fusesetstate( newstate )
{
    briefcaseent = self;
    partname = briefcaseent function_7c320131bd49bb18()[ 0 ];
    briefcaseent setscriptablepartstate( partname, newstate );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x7e2d558c, Offset: 0xe6dd
// Size: 0x8b
function function_f7c66312280484ed( player, isvisible )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.bombsite ) ) )
    {
        return;
    }
    
    briefcaseent = level.arrow.props.bombsite.briefcaseent;
    
    if ( !isdefined( briefcaseent ) )
    {
        return;
    }
    
    briefcaseent function_b09749f100e42ff1( player, isvisible );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x99c666de, Offset: 0xe770
// Size: 0x6f
function arrow_fusecleanup()
{
    bombsite = self;
    
    if ( !isdefined( bombsite.briefcaseent ) )
    {
        return;
    }
    
    bombsite.briefcaseent arrow_fusesetstate( "disabled" );
    bombsite.briefcaseent function_ee7f8c159963d50f();
    bombsite.briefcaseent notify( #"death" );
    bombsite.briefcaseent freescriptable();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x3c2f1ff9, Offset: 0xe7e7
// Size: 0xd8
function function_5fb441d82c434422( fuseent )
{
    bombsite = self;
    bombsite notify( #"hash_1f9a7927bbf1bc75" );
    bombsite endon( #"hash_1f9a7927bbf1bc75" );
    level endon( #"game_ended" );
    bombsite endon( #"fuse_complete" );
    
    if ( fuseent.id != "elite_arrow_fuse" )
    {
        return;
    }
    
    fusetimer = level.arrow.dvars.fusetimer;
    
    if ( isdefined( level.arrow.dvars.var_7fd196d924c628d4 ) )
    {
        fusetimer = level.arrow.dvars.var_7fd196d924c628d4;
    }
    
    wait fusetimer;
    fuseent notify( #"fuse_detonated" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5acceed6, Offset: 0xe8c7
// Size: 0x30b
function arrow_fusecomplete( result )
{
    briefcaseent = self;
    bombsite = briefcaseent.bombsite;
    bombsite notify( #"fuse_complete" );
    bombsite function_91d7da971b866291( result );
    
    if ( result == "fuse_detonated" )
    {
        bombsite.detonated = 1;
        level.arrow.endingdetonated = 1;
        player = bombsite function_1441234aa7914e21();
        teaminfo = level.arrow.teaminfo[ player.team ];
        teaminfo thread function_14ed8a3bc197bff6( "nuke_detonated", 1 );
        return;
    }
    
    if ( result == "fuse_cancelled" )
    {
        bombsite.disarmed = 1;
        level.arrow.endingdisarmed = 1;
        var_e5fedfe217c0f9e1 = undefined;
        function_9ecd3b1e0a8844b5( "bomb_defused", var_e5fedfe217c0f9e1 );
        return;
    }
    
    bombsite.disarmed = 1;
    level.arrow.endingdisarmed = 1;
    var_e5fedfe217c0f9e1 = undefined;
    
    if ( isdefined( bombsite.briefcaseent.lastuser ) )
    {
        bombsite.lastuser = bombsite.briefcaseent.lastuser;
        var_e5fedfe217c0f9e1 = bombsite.lastuser.team;
        level.arrow.var_fb22145a5485917c = var_e5fedfe217c0f9e1;
        bombsite.lastuser function_e6db6205cc3891ed();
        br_analytics::function_66d8c82e5bfe396a( bombsite.lastuser, bombsite.bombendtime - gettime() );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( bombsite.lastuser ) ) )
        {
            if ( isdefined( bombsite.lastuser.leaderboarddata[ "eliteBlocked" ] ) )
            {
                bombsite.lastuser.leaderboarddata[ "eliteBlocked" ] = bombsite.lastuser.leaderboarddata[ "eliteBlocked" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "eliteBlocked" ] ) )
            {
                [[ level.leaderboardfunc[ "eliteBlocked" ] ]]( bombsite.lastuser, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x72>" );
            
            if ( isdefined( bombsite.lastuser.pers[ "eliteBlocked" ] ) )
            {
                bombsite.lastuser.pers[ "eliteBlocked" ] = bombsite.lastuser.pers[ "eliteBlocked" ] + 1;
            }
        }
    }
    
    function_9ecd3b1e0a8844b5( "bomb_defused", var_e5fedfe217c0f9e1 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x32ee4ce7, Offset: 0xebda
// Size: 0xdd
function function_91d7da971b866291( result )
{
    bombsite = self;
    
    if ( result == "fuse_detonated" )
    {
        player = bombsite function_1441234aa7914e21();
        teaminfo = level.arrow.teaminfo[ player.team ];
        level thread function_c25bf3b4112300d9( teaminfo );
        return;
    }
    
    if ( result == "fuse_cancelled" )
    {
        function_3889badf08417418( "arrow_defused" );
        return;
    }
    
    teaminfo = level.arrow.teaminfo[ bombsite.targetteam ];
    
    if ( bombsite.bombendtime - gettime() <= 30000 )
    {
        teaminfo function_e770743a8f743fbc( "arrow_defused_under_30" );
        return;
    }
    
    teaminfo function_e770743a8f743fbc( "arrow_defused" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xf7e5a4fe, Offset: 0xecbf
// Size: 0x57
function function_c25bf3b4112300d9( teaminfo, delay = 0.35 )
{
    level waittill( #"nuke_fadeend" );
    wait delay;
    teaminfo function_f5b9fee9ad433c19( "arrow_detonated", 0 );
    teaminfo function_e770743a8f743fbc( "arrow_detonated_enemy", 0 );
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0xff5bb2e1, Offset: 0xed1e
// Size: 0x229
function function_17be96a6af4c899b( gameent, id, usetime, decayrate, endconditions, owner )
{
    dimensions = function_cb5c949472372a5d( id );
    triggerent = spawn( "trigger_radius", gameent.origin, 0, dimensions.radius, dimensions.height );
    triggerent.gameent = gameent;
    triggerent.id = id;
    triggerent.usetime = usetime;
    triggerent.decayrate = decayrate;
    triggerent.endconditions = endconditions;
    triggerent.endconditions[ triggerent.endconditions.size ] = "trigger_done";
    triggerent.owner = owner;
    triggerent.team = owner.team;
    triggerent.radius = dimensions.radius;
    triggerent.height = dimensions.height;
    triggerent.trigger = spawnstruct();
    triggerent.trigger.owner = owner;
    triggerent.trigger.id = id;
    triggerent.trigger.targetname = id + "_trigger";
    triggerent gameobjects::setusetime( triggerent.usetime );
    triggerent makeusable();
    triggerent sethintdisplayrange( triggerent.radius );
    triggerent setuserange( triggerent.radius );
    triggerent sethintdisplayfov( 360 );
    triggerent setusefov( 360 );
    triggerent.inuse = 0;
    triggerent function_2cc481fab895ceb3( id );
    gameent thread function_724dda45f8505184( triggerent );
    triggerent thread function_c62f00f84c4dba48();
    trigger::makeenterexittrigger( triggerent, &function_a1b217c9345ed242, &function_659ec8ae38a80954 );
    return triggerent;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2ad6a701, Offset: 0xef50
// Size: 0xab
function function_ef1082c3639c1297( targetteam, toenable )
{
    triggerent = self;
    teamplayers = teams::getteamdata( targetteam, "players" );
    
    foreach ( player in teamplayers )
    {
        triggerent function_6fcebb19629beade( player, toenable );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x606128c1, Offset: 0xf003
// Size: 0x76
function function_6fcebb19629beade( targetplayer, toenable )
{
    triggerent = self;
    
    if ( !isdefined( triggerent.targets ) )
    {
        triggerent.targets = [];
    }
    
    if ( toenable )
    {
        triggerent.targets[ targetplayer.name ] = 1;
        return;
    }
    
    triggerent.targets[ targetplayer.name ] = undefined;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd2957296, Offset: 0xf081
// Size: 0xf6
function function_cb5c949472372a5d( id )
{
    dimensions = spawnstruct();
    
    switch ( id )
    {
        case #"hash_ec25beb87c3d651a":
            dimensions.radius = level.arrow.dvars.fuseradius;
            dimensions.height = level.arrow.dvars.fuseheight;
            break;
        case #"hash_7f7fd592a3f31def":
        default:
            dimensions.radius = level.arrow.dvars.armradius;
            dimensions.height = level.arrow.dvars.armheight;
            break;
    }
    
    return dimensions;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1a5c1f5b, Offset: 0xf180
// Size: 0xcb
function function_2cc481fab895ceb3( id )
{
    triggerent = self;
    var_ca7bb1185f1f5ec4 = id == "elite_arrow_arm" || id == "elite_arrow_fuse";
    
    if ( var_ca7bb1185f1f5ec4 && isdefined( triggerent.gameent.iconinfo ) && isdefined( triggerent.gameent.iconinfo.all ) )
    {
        triggerent.objidnum = triggerent.gameent.iconinfo.all;
        objidpoolmanager::objective_set_progress( triggerent.objidnum, 0 );
        objidpoolmanager::update_objective_setbackground( triggerent.objidnum, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x9fa43efd, Offset: 0xf253
// Size: 0x6a
function function_724dda45f8505184( triggerent )
{
    gameent = self;
    level endon( #"game_ended" );
    result = triggerent utility::waittill_any_in_array_return( triggerent.endconditions );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    if ( isdefined( triggerent.triggercomplete ) )
    {
        gameent [[ triggerent.triggercomplete ]]( result );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x1f3e7c52, Offset: 0xf2c5
// Size: 0x69
function function_a1b217c9345ed242( user, trigger )
{
    if ( !isplayer( user ) || !isalive( user ) || !isdefined( trigger ) )
    {
        return;
    }
    
    if ( !user istouching( trigger ) )
    {
        return;
    }
    
    gameent = trigger.gameent;
    
    if ( !isdefined( gameent ) )
    {
        return;
    }
    
    gameent function_e31cf2bb0d433729( trigger, user );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xda8eb0c9, Offset: 0xf336
// Size: 0x2a
function function_659ec8ae38a80954( user, trigger )
{
    if ( !isplayer( user ) )
    {
        return;
    }
    
    thread function_ac44a7a1f66a108c( user, trigger );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xc29beb9a, Offset: 0xf368
// Size: 0x30
function function_ac44a7a1f66a108c( user, trigger )
{
    user notify( #"trigger_leave" );
    waitframe();
    user notify( #"trigger_use_think" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x9180f8f4, Offset: 0xf3a0
// Size: 0xcd
function function_e31cf2bb0d433729( triggerent, user )
{
    gameent = self;
    level endon( #"game_ended" );
    triggerent endon( #"hash_21e19ca38f6e49f8" );
    user endon( #"trigger_use_think" );
    
    while ( true )
    {
        triggerent waittill( #"trigger", newuser );
        
        if ( newuser != user )
        {
            continue;
        }
        
        if ( !triggerent function_179d03272917f111( user ) )
        {
            continue;
        }
        
        triggerent function_96ac0744d7efb983( user );
        
        if ( !user usebuttonpressed() )
        {
            continue;
        }
        
        triggerent function_fbc2b1c7e9e88905( user );
        result = triggerent function_242639a21ff78216( user );
        triggerent function_96320a89ad7913b7( user );
        gameent function_f19360a3a76e5253( triggerent, user, result );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb77bbdc5, Offset: 0xf475
// Size: 0x50
function function_fbc2b1c7e9e88905( user )
{
    triggerent = self;
    triggerent notify( #"hash_6e608a45385c9138" );
    
    if ( isplayer( user ) )
    {
        triggerent function_dd216b0e997028d6( user, 1 );
    }
    
    triggerent makeunusable();
    triggerent.inuse = 1;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf5722b1b, Offset: 0xf4cd
// Size: 0x87
function function_242639a21ff78216( user )
{
    triggerent = self;
    triggerent.lastuser = user;
    triggerent thread function_24895c3b6e0f4677( user );
    result = utility::waittill_any_ents_return_no_endon_death( triggerent, "trigger_success", triggerent, "trigger_fail", user, "trigger_leave", user, "death_or_disconnect" );
    triggerent thread function_e29338f3e1d8fca6( 0, triggerent.lastuser.team );
    triggerent thread function_fc15f01e1f7acf7d();
    return result;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd5be31d6, Offset: 0xf55d
// Size: 0x4e
function function_96320a89ad7913b7( user )
{
    triggerent = self;
    triggerent.inuse = 0;
    triggerent makeusable();
    
    if ( isplayer( user ) )
    {
        triggerent function_dd216b0e997028d6( user, 0 );
    }
    
    triggerent notify( #"trigger_stop" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x34e1497c, Offset: 0xf5b3
// Size: 0x58
function function_dd216b0e997028d6( user, isusing )
{
    triggerent = self;
    user notify( #"hash_f6e99542293f93b9" );
    user thread function_6a72886119124a24( isusing, triggerent );
    user function_4ab011a1f8af4bc2( isusing );
    triggerent function_bea208de2f3bfd65( isusing );
    triggerent function_ece85982cbfc9b2f( isusing );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x9f5cc6bb, Offset: 0xf613
// Size: 0x12d
function function_4ab011a1f8af4bc2( isusing )
{
    user = self;
    user val::set( "sam_holding_bomb", "allow_movement", !isusing );
    user val::set( "sam_holding_bomb", "sprint", !isusing );
    user val::set( "sam_holding_bomb", "fire", !isusing );
    user val::set( "sam_holding_bomb", "reload", !isusing );
    user val::set( "sam_holding_bomb", "weapon_pickup", !isusing );
    user val::set( "sam_holding_bomb", "weapon_switch", !isusing );
    user val::set( "sam_holding_bomb", "allow_jump", !isusing );
    user val::set( "sam_holding_bomb", "gesture", !isusing );
    user val::set( "sam_holding_bomb", "melee", !isusing );
    user val::set( "sam_holding_bomb", "mantle", !isusing );
    user val::set( "sam_holding_bomb", "offhand_weapons", !isusing );
    user function_60e112d2e106b00a();
    
    if ( !isusing )
    {
        user val::reset_all( "sam_holding_bomb" );
        user function_7d73d6786e51ae1f();
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xc0af121d, Offset: 0xf748
// Size: 0xf3
function function_6a72886119124a24( isusing, triggerent )
{
    user = self;
    
    if ( isusing )
    {
        briefcasebomb = makeweapon( "briefcase_bomb_mp_nuke" );
        user.briefcasebomb = briefcasebomb;
        user inventory_utility::_giveweapon( briefcasebomb, undefined, undefined, 0 );
        user setweaponammostock( briefcasebomb, 0 );
        user setweaponammoclip( briefcasebomb, 0 );
        user gameobjects::switchtouseweapon( briefcasebomb, 1, 1 );
        return;
    }
    
    if ( user inventory_utility::iscurrentweapon( "briefcase_bomb_mp_nuke" ) )
    {
        lastweaponobj = user inventory::getlastweapon();
        user inventory_utility::domonitoredweaponswitch( lastweaponobj, 0, 1 );
    }
    else
    {
        user inventory_utility::abortmonitoredweaponswitch( makeweapon( "briefcase_bomb_mp_nuke" ) );
        user.briefcasebomb = undefined;
    }
    
    if ( isdefined( user.briefcasebomb ) )
    {
        user takeweapon( user.briefcasebomb );
        user.briefcasebomb = undefined;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe7267976, Offset: 0xf843
// Size: 0xc2
function function_bea208de2f3bfd65( isusing )
{
    triggerent = self;
    
    if ( triggerent.id == "elite_arrow_arm" )
    {
        if ( isusing )
        {
            triggerent.gameent function_4b822bf658740892( "arming" );
        }
        else
        {
            triggerent.gameent function_4b822bf658740892( "arm" );
            triggerent.gameent arrow_bombsitearmusability();
        }
        
        return;
    }
    
    if ( triggerent.id == "elite_arrow_fuse" )
    {
        if ( isusing )
        {
            triggerent.gameent arrow_fusesetstate( "defusing" );
            return;
        }
        
        triggerent.gameent arrow_fusesetstate( "defuse" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x42d58fa7, Offset: 0xf90d
// Size: 0x12d
function function_24895c3b6e0f4677( user )
{
    triggerent = self;
    level endon( #"game_ended" );
    triggerent endon( #"hash_21e19ca38f6e49f8" );
    user endon( #"death_or_disconnect" );
    user endon( #"trigger_leave" );
    
    if ( !isdefined( triggerent.curprogress ) )
    {
        triggerent.curprogress = 0;
    }
    
    triggerent thread function_e29338f3e1d8fca6( 1, user.team );
    userate = level.arrow.dvars.userate;
    usetimegoal = triggerent.usetime;
    
    while ( function_45f954f0fc6af0e7( user ) )
    {
        function_f3406cce91c963e2( user );
        waitframe();
        progresstick = level.frameduration * userate;
        triggerent.curprogress += progresstick;
        
        if ( triggerent.curprogress >= usetimegoal )
        {
            triggerent notify( #"trigger_success" );
            return;
        }
    }
    
    triggerent notify( #"trigger_fail" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2a78d436, Offset: 0xfa42
// Size: 0x1de
function function_e29338f3e1d8fca6( securing, userteam )
{
    triggerent = self;
    level endon( #"game_ended" );
    triggerent endon( #"hash_21e19ca38f6e49f8" );
    triggerent notify( #"hash_9c7926a7bfde6f6d" );
    triggerent endon( #"hash_9c7926a7bfde6f6d" );
    
    while ( true )
    {
        if ( triggerent.id == "elite_arrow_fuse" )
        {
            var_9b04f913b1800fb4 = [];
            
            if ( isdefined( userteam ) )
            {
                var_9b04f913b1800fb4 = teams::getteamdata( userteam, "players" );
            }
            else
            {
                var_9b04f913b1800fb4 = level.players;
            }
            
            foreach ( player in var_9b04f913b1800fb4 )
            {
                if ( isdefined( player ) )
                {
                    player gameobjects::updateuiprogress( triggerent, securing );
                }
            }
        }
        else if ( triggerent.id == "elite_arrow_arm" )
        {
            targetteam = userteam ?? triggerent.gameent.targetteam;
            
            if ( !isdefined( targetteam ) )
            {
                break;
            }
            
            teammates = teams::getteamdata( targetteam, "players" );
            
            foreach ( player in teammates )
            {
                player gameobjects::updateuiprogress( triggerent, securing );
            }
        }
        
        waitframe();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x95db9bfc, Offset: 0xfc28
// Size: 0x38
function function_6d9c080c12df0dd4()
{
    triggerent = self;
    triggerent.curprogress = 0;
    triggerent thread function_e29338f3e1d8fca6( 0, undefined );
    triggerent notify( #"hash_9c7926a7bfde6f6d" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf9ec6f24, Offset: 0xfc68
// Size: 0x15d, Type: bool
function function_45f954f0fc6af0e7( user )
{
    triggerent = self;
    
    if ( !isdefined( triggerent ) )
    {
        return false;
    }
    
    usetimegoal = triggerent.usetime;
    
    if ( isdefined( triggerent.curprogress ) && triggerent.curprogress > usetimegoal )
    {
        return false;
    }
    
    if ( level.arrow.dvars.usetoggle )
    {
        if ( user.var_11e4fdc92d3d633 == 3 )
        {
            return false;
        }
    }
    else if ( !user usebuttonpressed() )
    {
        return false;
    }
    
    if ( isdefined( triggerent.targets ) && !triggerent.targets[ user.name ] )
    {
        return false;
    }
    
    if ( !player::isreallyalive( user ) || user.inlaststand )
    {
        return false;
    }
    
    var_f122bdbb6e7015a6 = triggerent.radius * triggerent.radius;
    
    if ( distance2dsquared( user.origin, triggerent.origin ) > var_f122bdbb6e7015a6 )
    {
        return false;
    }
    
    if ( abs( user.origin[ 2 ] - triggerent.origin[ 2 ] ) > triggerent.height )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x2029781f, Offset: 0xfdce
// Size: 0xa1
function function_f3406cce91c963e2( user )
{
    if ( !level.arrow.dvars.usetoggle )
    {
        return;
    }
    
    if ( !isdefined( user.var_11e4fdc92d3d633 ) )
    {
        user.var_11e4fdc92d3d633 = 1;
        return;
    }
    
    if ( user.var_11e4fdc92d3d633 == 1 )
    {
        if ( !user usebuttonpressed() )
        {
            user.var_11e4fdc92d3d633 = 2;
        }
        
        return;
    }
    
    if ( user.var_11e4fdc92d3d633 == 2 )
    {
        if ( user usebuttonpressed() )
        {
            user.var_11e4fdc92d3d633 = 3;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x382bdab5, Offset: 0xfe77
// Size: 0xaa
function function_f19360a3a76e5253( triggerent, user, result )
{
    gameent = self;
    user.var_11e4fdc92d3d633 = undefined;
    
    if ( result == "trigger_success" )
    {
        triggerent notify( #"trigger_done" );
        user.arrowusetime = gettime();
        gameent.lastuser = user;
        return;
    }
    
    if ( result == "trigger_fail" )
    {
        if ( level.arrow.dvars.var_b026358b40a9b559 )
        {
            user.arrowusetime = gettime();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x28a32d10, Offset: 0xff29
// Size: 0xb5
function function_fc15f01e1f7acf7d()
{
    triggerent = self;
    level endon( #"game_ended" );
    triggerent endon( #"hash_21e19ca38f6e49f8" );
    triggerent endon( #"hash_6e608a45385c9138" );
    decayrate = triggerent.decayrate;
    
    if ( decayrate == 0 )
    {
        return;
    }
    else if ( decayrate == -1 )
    {
        triggerent function_6d9c080c12df0dd4();
        return;
    }
    
    while ( true )
    {
        triggerent.curprogress -= level.frameduration * decayrate;
        
        if ( triggerent.curprogress <= 0 )
        {
            triggerent function_6d9c080c12df0dd4();
            return;
        }
        
        waitframe();
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb9d323d8, Offset: 0xffe6
// Size: 0x59, Type: bool
function function_179d03272917f111( user )
{
    triggerent = self;
    
    if ( triggerent.inuse )
    {
        return false;
    }
    
    if ( !function_1ccf14b419137856( user ) )
    {
        return false;
    }
    
    if ( isdefined( user.briefcasebomb ) )
    {
        return false;
    }
    
    if ( !triggerent function_45f954f0fc6af0e7( user ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x8a0c592b, Offset: 0x10048
// Size: 0x2a
function function_cfd1b042040de723()
{
    triggerent = self;
    
    if ( !triggerent.inuse )
    {
        return;
    }
    
    return triggerent.lastuser;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x654de703, Offset: 0x1007b
// Size: 0x8b
function function_96ac0744d7efb983( user )
{
    triggerent = self;
    level endon( #"game_ended" );
    triggerent endon( #"hash_21e19ca38f6e49f8" );
    
    while ( ( !user isonground() || user isswimming() ) && user usebuttonpressed() )
    {
        waitframe();
    }
    
    if ( user.insertingarmorplate )
    {
        user notify( #"try_armor_cancel" );
        
        while ( user.insertingarmorplate && user usebuttonpressed() )
        {
            waitframe();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x18e07aca, Offset: 0x1010e
// Size: 0x9e
function function_c62f00f84c4dba48( force )
{
    triggerent = self;
    
    if ( !isdefined( triggerent ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    triggerent notify( #"trigger_cleanup_singleton" );
    triggerent endon( #"trigger_cleanup_singleton" );
    
    if ( !force )
    {
        triggerent waittill( #"trigger_done" );
    }
    
    triggerent notify( #"hash_21e19ca38f6e49f8" );
    triggerent function_6d9c080c12df0dd4();
    waitframe();
    
    if ( isdefined( triggerent ) )
    {
        function_3c6f8c0eb3453c9d( triggerent.timerelem );
        triggerent notify( #"destroy" );
        triggerent delete();
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x6e32f8f3, Offset: 0x101b4
// Size: 0x78
function function_ece85982cbfc9b2f( isusing )
{
    triggerent = self;
    
    if ( !isusing || !isdefined( triggerent ) || triggerent.id != "elite_arrow_fuse" )
    {
        return;
    }
    
    if ( triggerent.firstdefuse )
    {
        return;
    }
    
    triggerent.firstdefuse = 1;
    level thread br_public::brleaderdialogteam( "arrow_disarm_warning", triggerent.team, undefined, 2 );
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x74024008, Offset: 0x10234
// Size: 0xb6
function function_565a465b2835d5a( allicon, targetteam, friendlyicon, enemyicon )
{
    gameent = self;
    gameent.iconinfo = spawnstruct();
    gameent.iconinfo.owner = gameent;
    gameent.iconinfo.allicon = allicon;
    gameent.iconinfo.friendlyicon = friendlyicon;
    gameent.iconinfo.enemyicon = enemyicon;
    
    if ( isdefined( targetteam ) )
    {
        gameent function_f45d93bbeae7e3a2( targetteam, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x814ebe02, Offset: 0x102f2
// Size: 0x32
function function_ee7f8c159963d50f()
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    function_96e433f12fac8051();
    gameent.iconinfo = undefined;
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0x316c516e, Offset: 0x1032c
// Size: 0x20f
function function_e9eb704cd1527200( state, followent, playintro, showdistance, originoffset, var_7dc69ac945958166 )
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    iconorigin = followent function_c48e3a8a14a46165( state, originoffset );
    
    if ( !isdefined( iconorigin ) )
    {
        return;
    }
    
    if ( isdefined( gameent.iconinfo.allicon ) )
    {
        gameent.iconinfo.all = function_33d5d65d1899d629( "all", gameent.iconinfo.allicon, iconorigin, playintro, showdistance );
        gameent function_b72733d5f53771f8( state, followent, gameent.iconinfo.all, "all", originoffset );
        return;
    }
    
    if ( isdefined( gameent.iconinfo.friendlyicon ) )
    {
        gameent.iconinfo.friendly = function_33d5d65d1899d629( "friendly", gameent.iconinfo.friendlyicon, iconorigin, playintro, showdistance );
        gameent function_b72733d5f53771f8( state, followent, gameent.iconinfo.friendly, "friendly", originoffset );
    }
    
    if ( isdefined( gameent.iconinfo.enemyicon ) )
    {
        gameent.iconinfo.enemy = function_33d5d65d1899d629( "enemy", gameent.iconinfo.enemyicon, iconorigin, playintro, showdistance );
        gameent function_b72733d5f53771f8( state, followent, gameent.iconinfo.enemy, "enemy", originoffset );
    }
    
    if ( isdefined( gameent.player ) && var_7dc69ac945958166 )
    {
        gameent.player.ismarked = 1;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe85023a4, Offset: 0x10543
// Size: 0x141
function function_96e433f12fac8051( var_7dc69ac945958166 )
{
    gameent = self;
    gameent notify( #"icon_hide" );
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    if ( isdefined( gameent.iconinfo.all ) )
    {
        objidpoolmanager::returnobjectiveid( gameent.iconinfo.all );
        gameent.iconinfo.all = undefined;
    }
    
    if ( isdefined( gameent.iconinfo.friendly ) )
    {
        objidpoolmanager::returnobjectiveid( gameent.iconinfo.friendly );
        gameent.iconinfo.friendly = undefined;
    }
    
    if ( isdefined( gameent.iconinfo.enemy ) )
    {
        objidpoolmanager::returnobjectiveid( gameent.iconinfo.enemy );
        gameent.iconinfo.enemy = undefined;
    }
    
    if ( isdefined( gameent.player ) && var_7dc69ac945958166 )
    {
        gameent.player.ismarked = 0;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xa309a0a9, Offset: 0x1068c
// Size: 0x19f
function function_b09749f100e42ff1( player, isvisible )
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo ) )
    {
        return;
    }
    
    if ( isvisible && !player br_public::isplayerinorgoingtogulag() )
    {
        if ( isdefined( gameent.iconinfo.all ) )
        {
            objective_addclienttomask( gameent.iconinfo.all, player );
        }
        
        if ( isdefined( gameent.iconinfo.friendly ) && function_644049e2c34e357e( player ) )
        {
            objective_addclienttomask( gameent.iconinfo.friendly, player );
        }
        
        if ( isdefined( gameent.iconinfo.enemy ) && !function_644049e2c34e357e( player ) )
        {
            objective_addclienttomask( gameent.iconinfo.enemy, player );
        }
        
        return;
    }
    
    if ( isdefined( gameent.iconinfo.all ) )
    {
        objective_removeclientfrommask( gameent.iconinfo.all, player );
    }
    
    if ( isdefined( gameent.iconinfo.friendly ) )
    {
        objective_removeclientfrommask( gameent.iconinfo.friendly, player );
    }
    
    if ( isdefined( gameent.iconinfo.enemy ) )
    {
        objective_removeclientfrommask( gameent.iconinfo.enemy, player );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x1007fb43, Offset: 0x10833
// Size: 0xab
function function_f45d93bbeae7e3a2( targetteam, isvisible )
{
    gameent = self;
    teamplayers = teams::getteamdata( targetteam, "players" );
    
    foreach ( player in teamplayers )
    {
        gameent function_68f1c109685ad84b( player, isvisible );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x6ce6cb9a, Offset: 0x108e6
// Size: 0xa8
function function_68f1c109685ad84b( targetplayer, isvisible )
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo.targets ) )
    {
        gameent.iconinfo.targets = [];
    }
    
    if ( isvisible )
    {
        gameent.iconinfo.targets[ targetplayer.name ] = 1;
    }
    else
    {
        gameent.iconinfo.targets[ targetplayer.name ] = undefined;
    }
    
    function_b09749f100e42ff1( targetplayer, isvisible );
}

// Namespace br_elite_broken_arrow
// Params 5
// Checksum 0xdfc6f8f5, Offset: 0x10996
// Size: 0x71
function function_b72733d5f53771f8( state, followent, iconid, icontype, originoffset )
{
    gameent = self;
    
    if ( state == "ground" )
    {
        gameent thread function_dd9319d39b3ecc93( followent, iconid, originoffset );
        return;
    }
    
    if ( state == "player" )
    {
        gameent thread function_5dd17f6b5b80aeed( followent, iconid, icontype, originoffset );
    }
}

// Namespace br_elite_broken_arrow
// Params 5
// Checksum 0xf5519c5c, Offset: 0x10a0f
// Size: 0x153
function function_33d5d65d1899d629( icontype, uiicon, iconorigin, playintro, showdistance )
{
    objid = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( objid != -1 )
    {
        objidpoolmanager::objective_add_objective( objid, "current", iconorigin, uiicon );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::objective_set_play_intro( objid, playintro );
        objective_setshowdistance( objid, showdistance );
        objective_removeallfrommask( objid );
        
        foreach ( player in level.players )
        {
            if ( player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            if ( icontype == "friendly" && !function_644049e2c34e357e( player ) )
            {
                continue;
            }
            
            if ( icontype == "enemy" && function_644049e2c34e357e( player ) )
            {
                continue;
            }
            
            objective_addclienttomask( objid, player );
        }
        
        objective_showtoplayersinmask( objid );
    }
    else
    {
        println( "<dev string:x254>" );
    }
    
    return objid;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x980d9c9, Offset: 0x10b6b
// Size: 0x86
function function_dd9319d39b3ecc93( followent, iconid, originoffset )
{
    gameent = self;
    gameent endon( #"death" );
    followent endon( #"death" );
    gameent endon( #"icon_hide" );
    
    while ( true )
    {
        iconorigin = followent function_c48e3a8a14a46165( "ground", originoffset );
        
        if ( !isdefined( iconorigin ) )
        {
            return;
        }
        
        objidpoolmanager::update_objective_position( iconid, iconorigin );
        waitframe();
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x39ca4cb4, Offset: 0x10bf9
// Size: 0xf1
function function_5dd17f6b5b80aeed( followent, iconid, icontype, originoffset )
{
    gameent = self;
    gameent endon( #"death" );
    followent endon( #"death" );
    gameent endon( #"icon_hide" );
    pingrate = function_4e3020b49e041db5( icontype );
    
    if ( pingrate <= 0 )
    {
        zoffset = 80;
        
        if ( isdefined( originoffset ) )
        {
            zoffset = originoffset[ 2 ];
        }
        
        objidpoolmanager::update_objective_setzoffset( iconid, zoffset );
        objidpoolmanager::update_objective_onentity( iconid, followent );
        return;
    }
    
    while ( true )
    {
        iconorigin = followent function_c48e3a8a14a46165( "player", originoffset );
        
        if ( !isdefined( iconorigin ) )
        {
            return;
        }
        
        objidpoolmanager::update_objective_position( iconid, iconorigin );
        
        if ( followent vehicle::is_in_vehicle() )
        {
            wait 0.1;
            continue;
        }
        
        wait pingrate;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x97aa2d06, Offset: 0x10cf2
// Size: 0x47
function function_9440e9d66d062c05( player, isvisible )
{
    function_5c77194991e533a7( player, isvisible );
    function_27b49d1a3c1a4881( player, isvisible );
    function_4d9f382f7c2dafab( player, isvisible );
    function_f7c66312280484ed( player, isvisible );
    function_89de807c38769c83( player, isvisible );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x762bc0d0, Offset: 0x10d41
// Size: 0x43
function function_13a40e495736af57( player, isvisible )
{
    function_5c77194991e533a7( player, isvisible );
    function_161bef5b8b736b3d( player, "ber", isvisible );
    function_f7c66312280484ed( player, isvisible );
    function_89de807c38769c83( player, isvisible );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5d1c8121, Offset: 0x10d8c
// Size: 0x57, Type: bool
function function_644049e2c34e357e( player )
{
    gameent = self;
    
    if ( !isdefined( gameent.iconinfo.targets ) )
    {
        return false;
    }
    
    return isdefined( gameent.iconinfo.targets[ player.name ] );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x5d7a901c, Offset: 0x10dec
// Size: 0x8a
function function_c48e3a8a14a46165( state, originoffset )
{
    gameent = self;
    iconorigin = gameent.origin;
    
    if ( !isdefined( iconorigin ) )
    {
        return;
    }
    
    if ( state == "ground" )
    {
        iconorigin += ( 0, 0, 25 );
    }
    else if ( state == "player" )
    {
        iconorigin += ( 0, 0, 80 );
    }
    
    if ( isdefined( originoffset ) )
    {
        iconorigin += originoffset;
    }
    
    return iconorigin;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x462fcc60, Offset: 0x10e7f
// Size: 0x76
function function_4e3020b49e041db5( icontype )
{
    pingrate = 0;
    
    if ( icontype == "friendly" )
    {
        pingrate = level.arrow.dvars.var_77aaeb97fa9b3582;
    }
    else if ( icontype == "enemy" )
    {
        pingrate = level.arrow.dvars.var_e7de7e4b4a624c8f;
    }
    
    return pingrate;
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0x94567365, Offset: 0x10efe
// Size: 0x144
function function_3104fc89b8022a3( circlenum, circleid, targetteam, circleshuffle, var_dfcd800166320640, alwaysupdate )
{
    gameent = self;
    
    if ( !( isdefined( circlenum ) && isdefined( circleid ) ) )
    {
        return;
    }
    
    gameent function_825783424484934a( circlenum, circleid, gameent.origin, level.arrow.dvars.var_62902acdceec4990 );
    mapcircle = gameent function_27eab5df1c54ba8e( circlenum );
    mapcircle.team = targetteam;
    
    if ( !var_dfcd800166320640 )
    {
        teamplayers = teams::getteamdata( targetteam, "players" );
        
        foreach ( player in teamplayers )
        {
            gameent function_283a93d640df2f39( circlenum, player );
        }
    }
    
    gameent thread function_9a8f3431009d56ed( circlenum, circleshuffle, alwaysupdate );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xee1da5b, Offset: 0x1104a
// Size: 0x49
function function_283a93d640df2f39( circlenum, player )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        gameent game_utility::questcircle_showtoplayer( player );
        return;
    }
    
    if ( circlenum == 2 )
    {
        gameent game_utility::function_a876d3dd7d7b002b( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2556ed41, Offset: 0x1109b
// Size: 0x49
function function_aeff4aa230db4689( circlenum, player )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        gameent game_utility::questcircle_hidefromplayer( player );
        return;
    }
    
    if ( circlenum == 2 )
    {
        gameent game_utility::function_167207183beca56f( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc42a72ba, Offset: 0x110ec
// Size: 0x44
function function_27eab5df1c54ba8e( circlenum )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        return gameent.mapcircle;
    }
    
    if ( circlenum == 2 )
    {
        return gameent.var_ff099728517fe06;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4d6b7568, Offset: 0x11138
// Size: 0x2b
function function_b0a3c382a922110e( circlenum )
{
    if ( circlenum == 1 )
    {
        return "circle_cleanup";
    }
    
    if ( circlenum == 2 )
    {
        return "circle_two_cleanup";
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x2eb59eec, Offset: 0x1116b
// Size: 0x61
function function_825783424484934a( circlenum, circleid, origin, radius )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        gameent game_utility::questcircle_create( circleid, origin, radius );
        return;
    }
    
    if ( circlenum == 2 )
    {
        gameent game_utility::function_50dcc41281a10ae6( circleid, origin, radius );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x356d94db, Offset: 0x111d4
// Size: 0x3f, Type: bool
function function_d9a582b87368cb68( circlenum )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        return gameent game_utility::questcircle_exists();
    }
    else if ( circlenum == 2 )
    {
        return gameent game_utility::function_d1278c8f8c4819da();
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe1259049, Offset: 0x1121c
// Size: 0x47
function function_3d73ec73e3624387( circlenum )
{
    gameent = self;
    gameent function_58cce243e09d71c8();
    
    if ( circlenum == 1 )
    {
        gameent game_utility::questcircle_delete();
        return;
    }
    
    if ( circlenum == 2 )
    {
        gameent game_utility::function_b67daf7bb752a06d();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbf01b24d, Offset: 0x1126b
// Size: 0x183
function function_58cce243e09d71c8()
{
    gameent = self;
    
    if ( !isdefined( gameent.targetteam ) )
    {
        return;
    }
    
    if ( !isdefined( gameent.mapcircle ) && !isdefined( gameent.var_ff099728517fe06 ) )
    {
        return;
    }
    
    teammates = teams::getteamdata( gameent.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            isowner = player calloutmarkerping::isowner( pingindex );
            
            if ( isowner )
            {
                var_6675b0888e2dbc2 = player function_689a4266a29aac13( pingindex );
                
                if ( var_6675b0888e2dbc2 != function_1bf3a084cfe14025( 14 ) )
                {
                    continue;
                }
                
                pingent = player calloutmarkerping_getent( pingindex );
                
                if ( isdefined( gameent.mapcircle ) && pingent != gameent.mapcircle || isdefined( gameent.var_ff099728517fe06 ) && pingent != gameent.var_ff099728517fe06 )
                {
                    continue;
                }
                
                player calloutmarkerping::function_7c0ee9d4b604e6d6( pingindex );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x719c1a65, Offset: 0x113f6
// Size: 0x3a
function function_5f2314b2294a2d59( circlenum, search_location )
{
    if ( circlenum == 1 )
    {
        game_utility::questcircle_move( search_location );
        return;
    }
    
    if ( circlenum == 2 )
    {
        game_utility::function_97e255c843f6d72f( search_location );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1e31d21, Offset: 0x11438
// Size: 0x47
function function_64367b7a627b5a40( circlenum )
{
    gameent = self;
    gameent notify( function_b0a3c382a922110e( circlenum ) );
    doesexist = gameent function_d9a582b87368cb68( circlenum );
    
    if ( doesexist )
    {
        gameent function_3d73ec73e3624387( circlenum );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xb5c7a537, Offset: 0x11487
// Size: 0x103
function function_9a8f3431009d56ed( circlenum, circleshuffle, alwaysupdate )
{
    gameent = self;
    gameent endon( function_b0a3c382a922110e( circlenum ) );
    
    while ( true )
    {
        haschanged = function_1c230ef469a69ba4( circlenum );
        
        if ( alwaysupdate || haschanged || level.arrow.dvars.circleshuffle || circleshuffle )
        {
            function_6db3d2b437495ea2( circlenum, alwaysupdate );
        }
        
        if ( alwaysupdate )
        {
            waitframe();
            continue;
        }
        
        var_77c417e71ae37482 = randomfloat( level.arrow.dvars.var_2c4c02a4d4c842f4 ) - level.arrow.dvars.var_2c4c02a4d4c842f4 / 2;
        wait level.arrow.dvars.circleupdaterate + var_77c417e71ae37482;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x4d5eb19c, Offset: 0x11592
// Size: 0x8c
function function_6db3d2b437495ea2( circlenum, ignorerange )
{
    gameent = self;
    search_location = ( gameent.origin[ 0 ], gameent.origin[ 1 ], 0 );
    
    if ( !ignorerange )
    {
        radius = function_9acb554963acbdee( circlenum );
        range = function_845f53eff5481995( radius );
        search_location += math::random_vector_2d() * range;
    }
    
    gameent function_5f2314b2294a2d59( circlenum, search_location );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x33017cd2, Offset: 0x11626
// Size: 0xe5
function function_845f53eff5481995( radius )
{
    if ( !isdefined( radius ) )
    {
        return;
    }
    
    if ( radius == level.arrow.dvars.var_54a069203cb04431 )
    {
        return randomfloatrange( 0, level.arrow.dvars.var_fb3256c8685e21c5 );
    }
    
    if ( radius == level.arrow.dvars.var_1eef1c421251a88d )
    {
        return randomfloatrange( 0, level.arrow.dvars.var_91ea024b6f6360f1 );
    }
    
    return randomfloatrange( level.arrow.dvars.circlerangemin, level.arrow.dvars.circlerangemax );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7c53fc13, Offset: 0x11713
// Size: 0x2ab, Type: bool
function function_1c230ef469a69ba4( circlenum )
{
    gameent = self;
    closestdist = undefined;
    circle = gameent function_27eab5df1c54ba8e( circlenum );
    teamplayers = game_utility_mp::getlivingplayers( circle.team );
    
    foreach ( player in teamplayers )
    {
        dist = distance2d( player.origin, gameent.origin );
        
        if ( !isdefined( closestdist ) || dist < closestdist )
        {
            closestdist = dist;
        }
    }
    
    oldradius = function_9acb554963acbdee( circlenum );
    newradius = oldradius;
    
    if ( !isdefined( closestdist ) || closestdist > level.arrow.dvars.var_62902acdceec4990 )
    {
        gameent function_543504ff47f942da( circlenum, level.arrow.dvars.var_62902acdceec4990 );
        newradius = level.arrow.dvars.var_62902acdceec4990;
    }
    else if ( closestdist > level.arrow.dvars.var_8ed1deb9efe5b9dc )
    {
        gameent function_543504ff47f942da( circlenum, level.arrow.dvars.var_8ed1deb9efe5b9dc );
        newradius = level.arrow.dvars.var_8ed1deb9efe5b9dc;
    }
    else if ( closestdist > level.arrow.dvars.var_1eef1c421251a88d )
    {
        gameent function_543504ff47f942da( circlenum, level.arrow.dvars.var_1eef1c421251a88d );
        newradius = level.arrow.dvars.var_1eef1c421251a88d;
    }
    else
    {
        gameent function_543504ff47f942da( circlenum, level.arrow.dvars.var_54a069203cb04431 );
        newradius = level.arrow.dvars.var_54a069203cb04431;
    }
    
    if ( newradius != oldradius )
    {
        return true;
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb5351f91, Offset: 0x119c7
// Size: 0x49
function function_543504ff47f942da( circlenum, newradius )
{
    gameent = self;
    
    if ( circlenum == 1 )
    {
        gameent game_utility::function_d46d8731ed9d281( newradius );
        return;
    }
    
    if ( circlenum == 2 )
    {
        gameent game_utility::function_c320a0eb32354330( newradius );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xcb1c7f7e, Offset: 0x11a18
// Size: 0x43
function function_9acb554963acbdee( circlenum )
{
    gameent = self;
    circle = gameent function_27eab5df1c54ba8e( circlenum );
    
    if ( isdefined( circle ) )
    {
        return circle.origin[ 2 ];
    }
    
    return -1;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xaff5cb8, Offset: 0x11a64
// Size: 0xb5
function function_a379c1d55f989dea( targetteam )
{
    player = self;
    
    foreach ( container in level.arrow.props.containers[ targetteam ] )
    {
        if ( !isdefined( container ) )
        {
            continue;
        }
        
        container function_283a93d640df2f39( 1, player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5f500ec2, Offset: 0x11b21
// Size: 0xb5
function function_34a9c8a21a16e0ba( targetteam )
{
    player = self;
    
    foreach ( container in level.arrow.props.containers[ targetteam ] )
    {
        if ( !isdefined( container ) )
        {
            continue;
        }
        
        container function_aeff4aa230db4689( 1, player );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5533dba1, Offset: 0x11bde
// Size: 0xb1
function function_ee90fbccf084693b()
{
    teaminfo = self;
    
    if ( !level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    teaminfo.trackerhud = spawnstruct();
    teammates = teams::getteamdata( teaminfo.targetteam, "players" );
    teaminfo.trackerhud.teammates = teammates;
    teaminfo function_5663cd835917df5b();
    teaminfo.trackerhud.hudbox = function_1f8b2916e2bc498c( ( 1, 0.9, 0.7 ), 165, 95, -50 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x596dbb50, Offset: 0x11c97
// Size: 0xba
function function_2808c5beb14d6543()
{
    if ( !level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    foreach ( info in level.arrow.teaminfo )
    {
        if ( !isdefined( info ) )
        {
            continue;
        }
        
        function_a40a657322f22f0a( info.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xbfc91bee, Offset: 0x11d59
// Size: 0x89
function function_a40a657322f22f0a( targetteam )
{
    if ( !( isdefined( level.arrow.teaminfo[ targetteam ] ) && isdefined( level.arrow.teaminfo[ targetteam ].trackerhud ) ) )
    {
        return;
    }
    
    level.arrow.teaminfo[ targetteam ] function_275f32ba1ce5b9e8();
    level.arrow.teaminfo[ targetteam ].trackerhud = undefined;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x2e57d2b8, Offset: 0x11dea
// Size: 0xeb
function function_275f32ba1ce5b9e8()
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    function_861bf7330fb2ac0( trackerhud.title );
    function_861bf7330fb2ac0( trackerhud.hudbox );
    
    foreach ( entry in trackerhud.entries )
    {
        function_861bf7330fb2ac0( entry );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x54d423fb, Offset: 0x11edd
// Size: 0x8c
function function_861bf7330fb2ac0( elems )
{
    if ( !isdefined( elems ) )
    {
        return;
    }
    
    foreach ( elem in elems )
    {
        if ( isdefined( elem ) )
        {
            elem hud_util::destroyelem();
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x9ee24692, Offset: 0x11f71
// Size: 0x14f
function function_5663cd835917df5b()
{
    teaminfo = self;
    bombsite = level.arrow.props.bombsite;
    
    if ( !level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    if ( bombsite.var_3047d56bbd4f79da )
    {
        teaminfo.trackerhud.title = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/arm_the_bomb", 1.2, 1, -75 );
        return;
    }
    
    if ( bombsite.siterevealed )
    {
        teaminfo.trackerhud.title = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/deposit_elems", 1.2, 1, -75 );
        return;
    }
    
    if ( bombsite.dropping )
    {
        teaminfo.trackerhud.title = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/waiting_bomb", 1.2, 1, -75 );
        return;
    }
    
    teaminfo.trackerhud.title = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/locate_elems", 1.2, 1, -75 );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2b241a44, Offset: 0x120c8
// Size: 0x1e7
function function_a846b42fd6cd14d( elementid, spawned )
{
    teaminfo = self;
    bombsite = level.arrow.props.bombsite;
    trackernumber = function_ca621b047cf24253( elementid, 4 );
    textheightoffset = function_c47b76ea665c86bf( function_ca621b047cf24253( elementid, 6 ) );
    
    if ( !isdefined( trackernumber ) )
    {
        return;
    }
    
    if ( !level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    if ( !isdefined( teaminfo.trackerhud.entries ) )
    {
        teaminfo.trackerhud.entries = [];
    }
    
    if ( isdefined( teaminfo.trackerhud.entries[ trackernumber ] ) )
    {
        function_861bf7330fb2ac0( teaminfo.trackerhud.entries[ trackernumber ] );
    }
    
    if ( bombsite.neededelements[ elementid ] )
    {
        teaminfo.trackerhud.entries[ trackernumber ] = function_c2993a6acec5ec2c( function_ca621b047cf24253( elementid, 15 ), 0.9, 0.6, textheightoffset );
        return;
    }
    
    if ( level.arrow.dvars.scriptedflow && !spawned )
    {
        teaminfo.trackerhud.entries[ trackernumber ] = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/next_task", 0.9, 0.6, textheightoffset );
        return;
    }
    
    teaminfo.trackerhud.entries[ trackernumber ] = function_c2993a6acec5ec2c( function_ca621b047cf24253( elementid, 14 ), 0.9, 1, textheightoffset );
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0xe4255c7f, Offset: 0x122b7
// Size: 0x1ab
function function_c2993a6acec5ec2c( text, size, alpha, heightoffset )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    if ( !isdefined( trackerhud.teammates ) )
    {
        return;
    }
    
    hudelem = [];
    
    foreach ( player in trackerhud.teammates )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        hudelem[ player.clientid ] = player hud_util::createfontstring( "default", size );
        hudelem[ player.clientid ] hud_util::setpoint( "LEFT", "LEFT", 15, heightoffset );
        hudelem[ player.clientid ].alpha = alpha;
        hudelem[ player.clientid ].archived = 0;
        hudelem[ player.clientid ].hidewheninmenu = 1;
        hudelem[ player.clientid ] settext( text );
    }
    
    return hudelem;
}

// Namespace br_elite_broken_arrow
// Params 5
// Checksum 0x45dd600, Offset: 0x1246b
// Size: 0x1cf
function function_da321b83ba297480( time, size, var_afc2983e8867e4fe, heightoffset, widthoffset )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    if ( !isdefined( trackerhud.teammates ) )
    {
        return;
    }
    
    hudelem = [];
    
    foreach ( player in trackerhud.teammates )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        hudelem[ player.clientid ] = player hud_util::createtimer( "default", size );
        hudelem[ player.clientid ] hud_util::setpoint( "LEFT", "LEFT", widthoffset, heightoffset );
        hudelem[ player.clientid ].alpha = 1;
        hudelem[ player.clientid ].archived = 0;
        hudelem[ player.clientid ].hidewheninmenu = 1;
        
        if ( var_afc2983e8867e4fe )
        {
            hudelem[ player.clientid ] settenthstimer( time );
            continue;
        }
        
        hudelem[ player.clientid ] settimer( time );
    }
    
    return hudelem;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0xd2e2dc92, Offset: 0x12643
// Size: 0x1bd
function function_1f8b2916e2bc498c( color, width, height, heightoffset )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    if ( !isdefined( trackerhud.teammates ) )
    {
        return;
    }
    
    hudelem = [];
    
    foreach ( player in trackerhud.teammates )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        hudelem[ player.clientid ] = player hud_util::createbar( color, width, height );
        hudelem[ player.clientid ] hud_util::setpoint( "LEFT", "LEFT", 0, heightoffset );
        hudelem[ player.clientid ].alpha = 0.5;
        hudelem[ player.clientid ].bar.alpha = 0.5;
        hudelem[ player.clientid ].archived = 0;
        hudelem[ player.clientid ].hidewheninmenu = 1;
    }
    
    return hudelem;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd009ab14, Offset: 0x12809
// Size: 0x90
function function_3b0990925ca12fb7( text )
{
    foreach ( activeteam in level.arrow.teaminfo )
    {
        activeteam function_f0a2414c497c20e9( text );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xcd03b1cd, Offset: 0x128a1
// Size: 0xeb
function function_f0a2414c497c20e9( text )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    if ( !isdefined( trackerhud.title ) )
    {
        return;
    }
    
    foreach ( entry in trackerhud.title )
    {
        if ( !isdefined( entry ) )
        {
            continue;
        }
        
        entry settext( text );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x94f59bde, Offset: 0x12994
// Size: 0xa5
function function_2fb9be8234857915( text, alpha, entryindex )
{
    foreach ( activeteam in level.arrow.teaminfo )
    {
        activeteam function_9c5337ece9a0a253( text, alpha, entryindex );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x5e8089f4, Offset: 0x12a41
// Size: 0x117
function function_9c5337ece9a0a253( text, alpha, entryindex )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    if ( !isdefined( trackerhud.entries[ entryindex ] ) )
    {
        return;
    }
    
    foreach ( entry in trackerhud.entries[ entryindex ] )
    {
        if ( !isdefined( entry ) )
        {
            continue;
        }
        
        entry settext( text );
        
        if ( isdefined( alpha ) )
        {
            entry.alpha = alpha;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x596aa0d8, Offset: 0x12b60
// Size: 0x78
function function_68bc27f2732052a7()
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    trackerhud.entries[ 6 ] = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/bomb_incoming", 1, 0.6, -12 );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xda437bcb, Offset: 0x12be0
// Size: 0xb8
function function_c16ff926d3d4dd3f( time )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    function_861bf7330fb2ac0( trackerhud.entries[ 6 ] );
    trackerhud.entries[ 6 ] = function_c2993a6acec5ec2c( &"br_elite_broken_arrow/bomb_expires", 1, 1, -12 );
    trackerhud.entries[ 7 ] = function_da321b83ba297480( time, 1, 0, -24, 125 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc734e844, Offset: 0x12ca0
// Size: 0x78
function function_5f0603cc08ffce2a()
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    function_861bf7330fb2ac0( trackerhud.entries[ 6 ] );
    function_861bf7330fb2ac0( trackerhud.entries[ 7 ] );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x869082c0, Offset: 0x12d20
// Size: 0x103
function function_65a520f59398740c( time )
{
    teaminfo = self;
    trackerhud = teaminfo.trackerhud;
    
    if ( !level.arrow.dvars.scripttracker || !isdefined( trackerhud ) )
    {
        return;
    }
    
    foreach ( entry in trackerhud.entries )
    {
        function_861bf7330fb2ac0( entry );
    }
    
    function_f0a2414c497c20e9( &"br_elite_broken_arrow/protect_nuke" );
    trackerhud.entries[ 8 ] = function_da321b83ba297480( time, 1.5, 1, -45, 15 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x765a6913, Offset: 0x12e2b
// Size: 0xa1
function function_2a3ecd9294abc61f()
{
    task = self;
    
    foreach ( player in teams::getteamdata( task.team, "players" ) )
    {
        if ( !player br_public::isplayeringulag() )
        {
            player function_83af91eaf6333c6b( 1 );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa30e2bfe, Offset: 0x12ed4
// Size: 0x46
function function_83af91eaf6333c6b( visible )
{
    player = self;
    
    if ( visible )
    {
        player br_contract_manager::uiobjectiveshow( level.arrow.contractref );
        return;
    }
    
    player br_contract_manager::uiobjectivehide();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x243eb3bb, Offset: 0x12f22
// Size: 0x16a
function function_e7460b727a2abab( timer, timerpaused )
{
    teaminfo = self;
    
    if ( level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    enabled = teaminfo function_3cca57d766d09cff();
    var_23fd853c2bd98c68 = teaminfo function_c7626032d3be2457();
    timer = function_ed33db5800fb5b73( timer );
    timerpaused = istrue( timerpaused );
    bombsite = function_b0d089fdc4b2de35();
    states = teaminfo function_e76e8581c95d309b();
    allies = teaminfo function_16ecfeb5748c14c5();
    enemies = teaminfo function_e0e5ec1a7b141681();
    teammates = teams::getteamdata( teaminfo.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        player function_7706d19f752dda66( enabled, var_23fd853c2bd98c68, states, bombsite, allies, timer, timerpaused );
        player function_445237a2b502e8d6( enemies );
        player function_a5ef95eeb7243ac5( timer, var_23fd853c2bd98c68 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xcf9167d7, Offset: 0x13094
// Size: 0x91
function function_dc2ad3dc56932c37( timer )
{
    player = self;
    
    if ( level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    var_23fd853c2bd98c68 = function_ade5bc91db2318e3();
    timer = function_ed33db5800fb5b73( timer );
    timerpaused = 0;
    bombsite = function_b0d089fdc4b2de35();
    states = function_50ce385d37d5e407();
    player function_7706d19f752dda66( 0, var_23fd853c2bd98c68, states, bombsite, [], timer, timerpaused );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb0765986, Offset: 0x1312d
// Size: 0xde
function function_c9a9e36e63a2308e( timer, timerpaused )
{
    if ( level.arrow.dvars.scripttracker )
    {
        return;
    }
    
    if ( !isdefined( level.arrow.teaminfo ) )
    {
        return;
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        teaminfo thread function_e7460b727a2abab( timer, timerpaused );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1711d91, Offset: 0x13213
// Size: 0x9e
function function_c55c319265aa598c( timer )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( function_83984ed760cb2b30( player ) )
        {
            continue;
        }
        
        player function_dc2ad3dc56932c37( timer );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x785cf2b3, Offset: 0x132b9
// Size: 0x1c, Type: bool
function function_3cca57d766d09cff()
{
    teaminfo = self;
    return teaminfo.state > 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x93a208ab, Offset: 0x132de
// Size: 0x1f
function function_c7626032d3be2457()
{
    teaminfo = self;
    return max( teaminfo.state, 0 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x672aa704, Offset: 0x13306
// Size: 0xa3
function function_ade5bc91db2318e3()
{
    statemax = 0;
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        statemax = max( teaminfo function_c7626032d3be2457(), statemax );
    }
    
    return statemax;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x73c12910, Offset: 0x133b2
// Size: 0x3b
function function_ed33db5800fb5b73( timer )
{
    if ( isdefined( level.arrow.bombsitetimestamp ) )
    {
        return function_c7c54a78bcfa63f5();
    }
    else if ( isdefined( timer ) )
    {
        return int( timer );
    }
    
    return 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xd6771e28, Offset: 0x133f6
// Size: 0x82
function function_b0d089fdc4b2de35()
{
    if ( isdefined( level.arrow.props.bombsite ) )
    {
        if ( level.arrow.props.bombsite.armedwipe )
        {
            return 3;
        }
        else if ( level.arrow.props.bombsite.siterevealed )
        {
            return 2;
        }
    }
    
    return 1;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x49d7bfc4, Offset: 0x13481
// Size: 0xa3
function function_e76e8581c95d309b()
{
    teaminfo = self;
    result = [];
    
    foreach ( element in level.arrow.elementorder )
    {
        result[ result.size ] = teaminfo function_ebc11b13c86dbf8a( element );
    }
    
    return result;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa4594c51, Offset: 0x1352d
// Size: 0x215
function function_ebc11b13c86dbf8a( elementid )
{
    teaminfo = self;
    
    if ( !isdefined( level.arrow.props.elements[ teaminfo.targetteam ][ elementid ] ) )
    {
        globalcountdown = isdefined( level.arrow.countdowns[ elementid ] ) && level.arrow.countdowns[ elementid ] <= level.arrow.dvars.var_707b23afaba6c546;
        teamcountdown = isdefined( teaminfo.var_d19d7029a0328b66[ elementid ] ) && teaminfo.var_d19d7029a0328b66[ elementid ] <= level.arrow.dvars.var_707b23afaba6c546;
        
        if ( globalcountdown || teamcountdown )
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    
    element = level.arrow.props.elements[ teaminfo.targetteam ][ elementid ];
    
    if ( element.var_5aab5c7a55f6dac6 > 0 )
    {
        switch ( element.var_5aab5c7a55f6dac6 )
        {
            case 1:
                return 5;
            case 2:
                return 6;
            case 3:
                return 7;
            case 4:
                return 8;
            default:
                break;
        }
    }
    
    if ( isdefined( element.player ) )
    {
        if ( element.player.team == element.targetteam )
        {
            return 3;
        }
        else
        {
            return 4;
        }
    }
    
    if ( element function_1282bda3309ca5b1() == "dropped" || element function_1282bda3309ca5b1() == "visible" || element.firstpickup )
    {
        return 2;
    }
    
    return 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x49aaf220, Offset: 0x1374b
// Size: 0xd6
function function_50ce385d37d5e407()
{
    elements = level.arrow.props.elements;
    
    if ( !isdefined( elements ) )
    {
        return [ 0, 0, 0 ];
    }
    
    result = [];
    
    foreach ( element in level.arrow.elementorder )
    {
        result[ result.size ] = function_dcf8cb140d797a78( element );
    }
    
    return result;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xe8ac0007, Offset: 0x1382a
// Size: 0xb9
function function_dcf8cb140d797a78( elementid )
{
    totalstate = 0;
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        totalstate = max( teaminfo function_ebc11b13c86dbf8a( elementid ), totalstate );
    }
    
    if ( totalstate < 5 )
    {
        totalstate = 0;
    }
    
    return totalstate;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4ad4aae, Offset: 0x138ec
// Size: 0x113
function function_16ecfeb5748c14c5( elements )
{
    teaminfo = self;
    elements = level.arrow.props.elements;
    result = [];
    
    if ( !isdefined( elements[ teaminfo.targetteam ] ) )
    {
        for ( i = 0; i < level.arrow.elementlist.size ; i++ )
        {
            result[ result.size ] = 0;
        }
    }
    else
    {
        foreach ( element in level.arrow.elementorder )
        {
            result[ result.size ] = teaminfo function_5f4ea29b0c5f3d98( element );
        }
    }
    
    return result;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb92fae32, Offset: 0x13a08
// Size: 0x7c
function function_5f4ea29b0c5f3d98( elementid )
{
    teaminfo = self;
    element = level.arrow.props.elements[ teaminfo.targetteam ][ elementid ];
    
    if ( !( isdefined( element ) && isdefined( element.player ) ) )
    {
        return 0;
    }
    
    return element.player.sessionuimemberindex;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5708cff9, Offset: 0x13a8d
// Size: 0x113
function function_e0e5ec1a7b141681( elements )
{
    teaminfo = self;
    elements = level.arrow.props.elements;
    result = [];
    
    if ( !isdefined( elements[ teaminfo.targetteam ] ) )
    {
        for ( i = 0; i < level.arrow.elementlist.size ; i++ )
        {
            result[ result.size ] = 0;
        }
    }
    else
    {
        foreach ( element in level.arrow.elementorder )
        {
            result[ result.size ] = teaminfo function_66c6166dfe7ce676( element );
        }
    }
    
    return result;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8d69f4fb, Offset: 0x13ba9
// Size: 0x78
function function_66c6166dfe7ce676( elementid )
{
    teaminfo = self;
    element = level.arrow.props.elements[ teaminfo.targetteam ][ elementid ];
    
    if ( !isdefined( element ) )
    {
        return 0;
    }
    
    if ( isdefined( element.player ) )
    {
        return element.player getentitynumber();
    }
    
    return 0;
}

// Namespace br_elite_broken_arrow
// Params 7
// Checksum 0xa1b89d52, Offset: 0x13c2a
// Size: 0x71
function function_7706d19f752dda66( enabled, var_23fd853c2bd98c68, stateelements, bombsite, allyelements, timer, timerpaused )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player function_ea5a6f3e93dbcb4f( stateelements, allyelements );
    player function_157ce1e05b9e8a5d( enabled, var_23fd853c2bd98c68, bombsite, timer, timerpaused );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xa962d9e0, Offset: 0x13ca3
// Size: 0x12d
function function_ea5a6f3e93dbcb4f( stateelements, allyelements )
{
    var_dabf939ebf670499 = 15;
    var_4c65a408687c33be = 3;
    var_aea7d8b052366a9b = stateelements.size;
    assert( stateelements.size <= 3 );
    assert( allyelements.size <= 4 );
    
    if ( stateelements.size < 3 )
    {
        stateelements[ stateelements.size ] = 0;
    }
    
    if ( allyelements.size < 4 )
    {
        allyelements[ allyelements.size ] = 0;
    }
    
    for ( i = 0; i < stateelements.size ; i++ )
    {
        if ( isdefined( stateelements[ i ] ) && stateelements[ i ] >= 0 && stateelements[ i ] <= var_dabf939ebf670499 )
        {
            omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_element_data", 4 * i, 4, int( stateelements[ i ] ) & var_dabf939ebf670499 );
        }
    }
    
    for ( i = 0; i < allyelements.size ; i++ )
    {
        if ( isdefined( allyelements[ i ] ) && allyelements[ i ] >= 0 && allyelements[ i ] <= var_4c65a408687c33be )
        {
            omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_element_data", 12 + 2 * i, 2, int( allyelements[ i ] ) & var_4c65a408687c33be );
        }
    }
    
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_element_data", 20, 3, var_aea7d8b052366a9b );
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0x74ff4a7a, Offset: 0x13dd8
// Size: 0x144
function function_157ce1e05b9e8a5d( enabled, var_23fd853c2bd98c68, bombsite, timer, timerpaused, success )
{
    enabledmax = 1;
    statemax = 7;
    bombsitemax = 3;
    timermax = 511;
    timerpausedmax = 1;
    assert( enabled >= 0 && enabled <= enabledmax );
    assert( var_23fd853c2bd98c68 >= 0 && var_23fd853c2bd98c68 <= statemax );
    assert( bombsite >= 0 && bombsite <= bombsitemax );
    assert( timer >= 0 && timer <= timermax );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 0, 1, int( enabled ) & enabledmax );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 1, 3, int( var_23fd853c2bd98c68 ) & statemax );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 4, 2, int( bombsite ) & bombsitemax );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 6, 9, int( timer ) & timermax );
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 15, 1, int( timerpaused ) & timerpausedmax );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb9542771, Offset: 0x13f24
// Size: 0x18
function function_ebda902dd0262d28()
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_data", 16, 1, int( 1 ) );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x9394120f, Offset: 0x13f44
// Size: 0x2b
function function_445237a2b502e8d6( enemyelements )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player function_2e53cee068fd42d( enemyelements );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb8b9771d, Offset: 0x13f77
// Size: 0x8c
function function_2e53cee068fd42d( enemyelements )
{
    var_3bcb81e300d317ed = 255;
    assert( enemyelements.size <= 4 );
    
    if ( enemyelements.size < 4 )
    {
        enemyelements[ enemyelements.size ] = 0;
    }
    
    for ( i = 0; i < enemyelements.size ; i++ )
    {
        if ( isdefined( enemyelements[ i ] ) && enemyelements[ i ] >= 0 && enemyelements[ i ] <= var_3bcb81e300d317ed )
        {
            omnvar_utility::function_85d5f88af471ac4b( "ui_br_elite_arrow_mission_players", 8 * i, 8, int( enemyelements[ i ] ) & var_3bcb81e300d317ed );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x47a80519, Offset: 0x1400b
// Size: 0x67
function function_a5ef95eeb7243ac5( timer, var_23fd853c2bd98c68 )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( var_23fd853c2bd98c68 == 0 || var_23fd853c2bd98c68 == 1 || var_23fd853c2bd98c68 == 6 )
    {
        return;
    }
    
    time = gettime() + timer * 1000;
    player setclientomnvar( "ui_br_objective_countdown_timer", time );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xa0ee11e2, Offset: 0x1407a
// Size: 0xd0
function function_7040886bcbf64e53()
{
    team = self.teams[ 0 ];
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        time = player getclientomnvar( "ui_br_objective_countdown_timer" );
        break;
    }
    
    time -= gettime();
    time *= 0.001;
    time = int( ceil( time ) );
    return time;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xa6c9db4, Offset: 0x14153
// Size: 0x207
function function_c77a542ba998c23b()
{
    teaminfo = self;
    player = teaminfo.champion;
    spawnnodes = function_2dbf8f2383410c8a( player );
    
    if ( !level.arrow.dvars.debug && ( spawnnodes.size != 3 || level.arrow.elementlist.size != 3 ) )
    {
        teaminfo thread function_14ed8a3bc197bff6( "container_spawn_failed", 0 );
        return;
    }
    
    if ( !isdefined( level.arrow.props.containers ) )
    {
        level.arrow.props.containers = [];
    }
    
    containers = [];
    
    foreach ( element in level.arrow.elementlist )
    {
        containers[ element.elementid ] = function_6cb96b29ee3f31a( function_ca621b047cf24253( element.elementid, 7 ), player.team, spawnnodes[ element.elementindex ].origin, spawnnodes[ element.elementindex ].angles );
        
        if ( element.elementid == "ber" )
        {
            containers[ element.elementid ] function_565a465b2835d5a( "ui_map_icon_elite_crown" );
        }
    }
    
    level.arrow.props.containers[ player.team ] = containers;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x7a5ff41b, Offset: 0x14362
// Size: 0x146
function function_6cb96b29ee3f31a( scriptable, targetteam, position, angles )
{
    container = spawnscriptable( scriptable, position, angles );
    container function_798f9315ddb3ee96( "active_and_closed" );
    elementid = function_a246dc01c1d8e60e( scriptable, 7 );
    questcircleid = function_ca621b047cf24253( elementid, 3 );
    container function_3104fc89b8022a3( 1, questcircleid, targetteam );
    container.targetteam = targetteam;
    container.criticalitem = 1;
    container.keepinmap = 1;
    container.donthide = 1;
    container.iconinfo = spawnstruct();
    container.iconinfo.friendlyicon = function_ca621b047cf24253( elementid, 2 );
    container function_f45d93bbeae7e3a2( targetteam, 1 );
    container function_c0a856ff30ee2572( container.type, targetteam );
    container thread function_ab16bdc543c629be();
    
    /#
        if ( getdvarint( @"hash_5257cc60e0dd8f5f", 0 ) == 1 )
        {
            sphere( position, 300, ( 0, 1, 0 ), 0, 600 );
        }
    #/
    
    return container;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x87aae494, Offset: 0x144b1
// Size: 0x162
function function_c0a856ff30ee2572( containername, targetteam )
{
    container = self;
    
    if ( !isdefined( level.arrow.props.elements ) )
    {
        level.arrow.props.elements = [];
    }
    
    if ( !isdefined( level.arrow.props.elements[ targetteam ] ) )
    {
        level.arrow.props.elements[ targetteam ] = [];
    }
    
    teaminfo = level.arrow.teaminfo[ targetteam ];
    elementid = function_a246dc01c1d8e60e( containername, 7 );
    level.arrow.props.elements[ targetteam ][ elementid ] = teaminfo function_8950525a5e4faf97( elementid, container.origin, container.angles );
    container.elementref = level.arrow.props.elements[ targetteam ][ elementid ];
    container.elementref.containerref = container;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xaa41afbb, Offset: 0x1461b
// Size: 0xbb
function function_d58e6cee278dfae8()
{
    if ( !isdefined( level.arrow.props.containers ) )
    {
        return;
    }
    
    foreach ( info in level.arrow.teaminfo )
    {
        if ( !isdefined( info ) )
        {
            continue;
        }
        
        function_bedb8b7dd399dd51( info.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x92311bbf, Offset: 0x146de
// Size: 0xc2
function function_bedb8b7dd399dd51( targetteam )
{
    if ( !isdefined( level.arrow.props.containers[ targetteam ] ) )
    {
        return;
    }
    
    foreach ( container in level.arrow.props.containers[ targetteam ] )
    {
        container function_d44035c167a39c69();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x81b710cc, Offset: 0x147a8
// Size: 0x3f
function function_d44035c167a39c69()
{
    container = self;
    
    if ( !isdefined( container ) )
    {
        return;
    }
    
    container function_64367b7a627b5a40( 1 );
    container function_96e433f12fac8051();
    container notify( #"death" );
    container freescriptable();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc13b524d, Offset: 0x147ef
// Size: 0x186
function function_2dbf8f2383410c8a( player )
{
    spawnnodes = [];
    
    /#
        if ( level.arrow.dvars.debug )
        {
            basepos = player.origin;
            baseangles = player.angles;
            forwardoffset = anglestoforward( baseangles ) * 100;
            rightoffset = anglestoright( baseangles ) * 100;
            spawnangles = ( 0, player.angles[ 1 ] + 90, 0 );
            
            for ( i = 0; i < level.arrow.elementlist.size ; i++ )
            {
                spawnnodes[ i ] = spawnstruct();
                spawnnodes[ i ].origin = basepos + forwardoffset + rightoffset * i;
                spawnnodes[ i ].angles = spawnangles;
            }
            
            return spawnnodes;
        }
    #/
    
    possiblenodes = function_a1c81512b7bac325( player.origin );
    
    if ( possiblenodes.size == 0 )
    {
        return;
    }
    
    circletimescale = getmatchrulesdata( "brData", "circleTimeScale" );
    spawnnodes[ 0 ] = function_c7a5926bd868b7a2( possiblenodes, 90 * circletimescale );
    spawnnodes[ 1 ] = function_c7a5926bd868b7a2( possiblenodes, 330 * circletimescale );
    spawnnodes[ 2 ] = function_c7a5926bd868b7a2( possiblenodes, 510 * circletimescale );
    spawnnodes = arrayrandomize( spawnnodes );
    return spawnnodes;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xd9d8c7c0, Offset: 0x1497e
// Size: 0x10a
function function_a1c81512b7bac325( position, var_864be5aa8cf4190d )
{
    maxdist = level.arrow.dvars.var_baacd4425151c0bc;
    
    if ( isdefined( var_864be5aa8cf4190d ) && int( var_864be5aa8cf4190d ) >= 2 )
    {
        maxdist = level.arrow.dvars.containermaxdist;
    }
    
    mindist = level.arrow.dvars.var_6ca90e57e1ca605a;
    
    if ( var_864be5aa8cf4190d )
    {
        mindist = level.arrow.dvars.containermindist;
    }
    
    possiblenodes = getunusedlootcachepoints( position, maxdist, mindist );
    
    if ( !var_864be5aa8cf4190d )
    {
        possiblenodes = function_cb5554a2f136bdab( position, possiblenodes );
    }
    
    if ( level.arrow.dvars.var_599fe0519f5449d9 )
    {
        possiblenodes = function_7f624458c64a1ffb( possiblenodes );
    }
    
    return possiblenodes;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2de5e250, Offset: 0x14a91
// Size: 0xc1
function function_cb5554a2f136bdab( position, nodes )
{
    if ( !br_gametypes::isfeatureenabled( #"circle" ) )
    {
        return nodes;
    }
    
    newarray = [];
    
    foreach ( node in nodes )
    {
        if ( br_circle_util::function_554002773c2c21f7( position, node.origin, 1000 ) )
        {
            newarray[ newarray.size ] = node;
        }
    }
    
    return newarray;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x30a90272, Offset: 0x14b5b
// Size: 0x9e
function function_7f624458c64a1ffb( nodes )
{
    newarray = [];
    
    foreach ( node in nodes )
    {
        if ( !br_strongholds::function_fd6ff3cc01d0ff9( node.origin ) )
        {
            newarray[ newarray.size ] = node;
        }
    }
    
    return newarray;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x42382177, Offset: 0x14c02
// Size: 0xdb
function function_c7a5926bd868b7a2( nodearr, var_c75cc1f32c344354 )
{
    if ( !isdefined( nodearr ) )
    {
        assertmsg( "<dev string:x28b>" );
        return;
    }
    
    nodearr = arrayrandomize( nodearr );
    
    if ( level.br_circle_disabled )
    {
        return nodearr[ 0 ];
    }
    
    foreach ( node in nodearr )
    {
        if ( !function_cd0239accc34d32c( node, var_c75cc1f32c344354 ) )
        {
            continue;
        }
        
        disablelootspawnpoint( node.index );
        return node;
    }
    
    assertmsg( "<dev string:x2cd>" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xaaadb45f, Offset: 0x14ce6
// Size: 0x53, Type: bool
function function_cd0239accc34d32c( node, var_c75cc1f32c344354 )
{
    safetime = br_circle_util::gettimetilldangerforpoint( node.origin );
    
    if ( safetime < var_c75cc1f32c344354 )
    {
        return false;
    }
    
    if ( ai_fortress::function_5428359c3c1916ac( node.origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x81ae87a8, Offset: 0x14d42
// Size: 0xe1
function function_ab16bdc543c629be()
{
    container = self;
    container notify( #"watch_circle" );
    container endon( #"watch_circle" );
    container endon( #"element_taken" );
    level endon( #"game_ended" );
    
    if ( level.arrow.dvars.var_6116a6c0191cf36f <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        wait level.arrow.dvars.var_6116a6c0191cf36f;
        
        if ( !function_fdb3c39e53e957b9( container ) )
        {
            return;
        }
        
        ingas = !level.br_circle_disabled && !br_circle_util::ispointinmulticircledanger( container.origin );
        
        if ( !ingas )
        {
            continue;
        }
        
        container function_75631f8ea0d18e57();
        container function_f25403ff9569d562();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x66e31d9c, Offset: 0x14e2b
// Size: 0xed
function function_75631f8ea0d18e57()
{
    container = self;
    
    if ( level.arrow.dvars.containergastime <= 0 )
    {
        return;
    }
    
    if ( !isdefined( container.gastime ) )
    {
        container.gastime = 0;
    }
    
    container.gastime += level.arrow.dvars.var_6116a6c0191cf36f;
    
    if ( container.gastime >= level.arrow.dvars.containergastime )
    {
        teaminfo = level.arrow.teaminfo[ container.targetteam ];
        teaminfo thread function_14ed8a3bc197bff6( "container_gas_timeout" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xfecdfc8e, Offset: 0x14f20
// Size: 0xab
function function_f25403ff9569d562()
{
    container = self;
    
    if ( level.arrow.dvars.var_414a7a4c794f435e < 0 )
    {
        return;
    }
    
    toofar = !br_circle_util::ispointinmulticircledanger( container.origin, level.arrow.dvars.var_414a7a4c794f435e );
    
    if ( toofar )
    {
        teaminfo = level.arrow.teaminfo[ container.targetteam ];
        teaminfo thread function_14ed8a3bc197bff6( "container_gas_too_far" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5481bd73, Offset: 0x14fd3
// Size: 0x47, Type: bool
function function_8b94fe836ea4730a()
{
    container = self;
    teaminfo = level.arrow.teaminfo[ container.targetteam ];
    teaminfo thread function_14ed8a3bc197bff6( "container_deleted_in_area_swap" );
    return false;
}

// Namespace br_elite_broken_arrow
// Params 6
// Checksum 0x463b4a3, Offset: 0x15023
// Size: 0xc7
function function_6a7a2e75d800d56( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( function_a246dc01c1d8e60e( part, 8 ) ) )
    {
        return;
    }
    
    if ( !instance function_206ea3b3452b2f2( player ) )
    {
        player hud_message::showerrormessage( %"mp_br_ingame/mission_occupied" );
        return;
    }
    
    if ( instance.elementref function_82760319f6a590e8() && !instance.elementref function_c977f58e352ad3a6( player ) )
    {
        player hud_message::showerrormessage( level.br_pickups.br_pickupdenyequipnoroom );
        return;
    }
    
    if ( state != "active_and_open" )
    {
        instance function_4e32922b51dfcb42( state );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x2f25547, Offset: 0x150f2
// Size: 0x53, Type: bool
function function_206ea3b3452b2f2( player )
{
    container = self;
    
    if ( isdefined( container.instance ) )
    {
        container = container.instance;
    }
    
    if ( container.targetteam != player.team )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x48272a6d, Offset: 0x1514e
// Size: 0x40, Type: bool
function function_82760319f6a590e8()
{
    container = self;
    
    if ( isdefined( container.instance ) )
    {
        container = container.instance;
    }
    
    if ( container function_ab5af3aa6a38e25a() != "active_and_open" )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbec34da7, Offset: 0x15197
// Size: 0xb5
function function_ab5af3aa6a38e25a()
{
    container = self;
    
    if ( isdefined( container.containerref ) )
    {
        container = container.containerref;
    }
    
    partname = container function_7c320131bd49bb18()[ 0 ];
    curstate = container getscriptablepartstate( partname, 1 );
    
    if ( curstate == "hidden" )
    {
        return "hidden";
    }
    
    if ( curstate == "active_and_closed" || curstate == "opening" || curstate == "closing" )
    {
        return "active_and_closed";
    }
    
    if ( curstate == "active_and_open" )
    {
        return "active_and_open";
    }
    
    if ( curstate == "empty_and_open" )
    {
        return "empty_and_open";
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x483d59a0, Offset: 0x15254
// Size: 0x34
function function_798f9315ddb3ee96( newstate )
{
    container = self;
    partname = container function_7c320131bd49bb18()[ 0 ];
    container setscriptablepartstate( partname, newstate );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc8e11cdb, Offset: 0x15290
// Size: 0x92
function function_4e32922b51dfcb42( state )
{
    container = self;
    
    switch ( state )
    {
        case #"hash_9fffec1a0638180a":
            container function_b8fa33dfdd0b0912();
            break;
        case #"hash_fc2a8f30b7cb30ce":
            container function_3289a676d3263a43();
            break;
        case #"hash_503933de2afb1e9d":
        case #"hash_61f1a95d6bf95699":
        case #"hash_68f80f4802765df7":
        case #"hash_d96f543f1c0bdf24":
        default:
            break;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf827ced7, Offset: 0x1532a
// Size: 0x33
function function_b8fa33dfdd0b0912()
{
    container = self;
    container notify( #"element_taken" );
    container function_798f9315ddb3ee96( "empty_and_open" );
    container function_96e433f12fac8051();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x9f444d1a, Offset: 0x15365
// Size: 0x4e
function function_3289a676d3263a43()
{
    container = self;
    container function_798f9315ddb3ee96( "opening" );
    container.elementref function_aabbbc78ff2214bc( 1 );
    container function_64367b7a627b5a40( 1 );
    container function_e9eb704cd1527200( "ground", container, 0, 0 );
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x4e7da8d8, Offset: 0x153bb
// Size: 0x49
function function_7f41ee2d4dca4284( elementid, position, angles, player )
{
    element = function_8950525a5e4faf97( elementid, position, angles );
    element function_6248728510695d6c( player );
    return element;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x108ed73f, Offset: 0x1540d
// Size: 0xff
function function_8950525a5e4faf97( elementid, position, angles )
{
    teaminfo = self;
    element = undefined;
    
    switch ( elementid )
    {
        case #"hash_21186d6c1b18ced6":
            element = teaminfo function_704babccabc9d084( elementid, position, angles );
            break;
        case #"hash_89183e6c51a64184":
            element = teaminfo function_d70a3ce3e793557e( elementid, position, angles );
            break;
        case #"hash_6d3f826c438808be":
            element = teaminfo function_3a0d390b8833b99c( elementid, position, angles );
            break;
        case #"hash_fb365c6c0708aacb":
            element = teaminfo function_437818d0382b297( elementid, position, angles );
            break;
        case #"hash_f496fe6c03c5a155":
            element = teaminfo function_72df0fcdba426e19( elementid, position, angles );
            break;
        case #"hash_4082276c2c059c84":
            element = teaminfo function_40143f775983017a( elementid, position, angles );
            break;
        default:
            break;
    }
    
    return element;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe0c2b1e8, Offset: 0x15515
// Size: 0x111
function function_861baab5997629cd( elementid, var_7dc69ac945958166 )
{
    teaminfo = self;
    teaminfo function_a846b42fd6cd14d( elementid, 1 );
    element = spawnstruct();
    element.elementid = elementid;
    element.targetteam = teaminfo.targetteam;
    element.firstpickup = 1;
    element.var_5aab5c7a55f6dac6 = 0;
    element.spawntime = gettime();
    element.trackernumber = function_ca621b047cf24253( elementid, 4 );
    
    if ( var_7dc69ac945958166 )
    {
        element.icon = "ui_map_icon_elite_crown";
        element function_565a465b2835d5a( element.icon );
    }
    else
    {
        element.icon = function_ca621b047cf24253( elementid, 2 );
        element function_565a465b2835d5a( undefined, teaminfo.targetteam, element.icon, undefined );
    }
    
    thread function_fc194ab8b74c5b8b( element );
    return element;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xfeec381e, Offset: 0x1562f
// Size: 0x7f
function function_7e138ac083b6ea81( player, dontcarry, var_7dc69ac945958166 )
{
    element = self;
    element function_5a7d980c9e870d29( var_7dc69ac945958166 );
    
    if ( dontcarry )
    {
        return;
    }
    
    if ( var_7dc69ac945958166 && !player.ismarked )
    {
        element function_e9eb704cd1527200( "player", player, 0, 0, undefined, var_7dc69ac945958166 );
    }
    
    element function_e75f50c37c7a155( "player", player );
    function_cb88db6faa38c2d9( element, player );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xeb37c582, Offset: 0x156b6
// Size: 0xa8
function function_86399e8b232b3750( player, var_7dc69ac945958166 )
{
    element = self;
    element function_5a7d980c9e870d29( var_7dc69ac945958166 );
    
    if ( element.cleanup )
    {
        return;
    }
    
    if ( var_7dc69ac945958166 )
    {
        element function_88c85c758a3691f1();
    }
    else
    {
        [ iconent, iconoffset ] = element function_4105c9bb4802e41c();
        element function_e9eb704cd1527200( "player", iconent, 0, 0, iconoffset );
    }
    
    element function_e75f50c37c7a155( "ground", player );
    function_ac74db64ad693b36( element, player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x85668259, Offset: 0x15766
// Size: 0xd0
function function_88c85c758a3691f1()
{
    element = self;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    element.icon = function_ca621b047cf24253( element.elementid, 2 );
    element.scriptable function_565a465b2835d5a( undefined, teaminfo.targetteam, element.icon, "ui_map_icon_elite_crown" );
    [ iconent, iconoffset ] = element function_4105c9bb4802e41c();
    element.scriptable function_e9eb704cd1527200( "player", iconent, 0, 0, iconoffset );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc0e2f331, Offset: 0x1583e
// Size: 0x98
function function_3118fc50fb80be8f( var_7dc69ac945958166 )
{
    element = self;
    element notify( #"element_cleanup" );
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    
    if ( !isdefined( teaminfo ) )
    {
        return;
    }
    
    if ( var_7dc69ac945958166 )
    {
        element function_5a7d980c9e870d29();
    }
    
    function_2fb9be8234857915( function_ca621b047cf24253( element.elementid, 15 ), 0.6, element.trackernumber );
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xc65d1d07, Offset: 0x158de
// Size: 0x135
function function_e75f50c37c7a155( state, player )
{
    element = self;
    
    if ( state == "player" )
    {
        if ( element.firstpickup )
        {
            if ( !level.arrow.dvars.var_218ba9a171abfc61 )
            {
                hud_util::showsplashtoteam( player.team, function_ca621b047cf24253( element.elementid, 12 ) );
            }
            
            waitframe();
        }
    }
    
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    
    if ( !isdefined( teaminfo ) || teaminfo.state == 0 )
    {
        return;
    }
    
    if ( state == "hidden" )
    {
        teaminfo function_9c5337ece9a0a253( function_ca621b047cf24253( element.elementid, 13 ), 1, element.trackernumber );
        return;
    }
    
    if ( state == "ground" )
    {
        teaminfo function_9c5337ece9a0a253( function_ca621b047cf24253( element.elementid, 16 ), 1, element.trackernumber );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x33638e86, Offset: 0x15a1b
// Size: 0x60
function function_c1a2d3435e4a89a0( scriptable, position, angles )
{
    elementscriptable = spawnscriptable( scriptable, position, angles );
    elementscriptable function_4751c49e2dd970b5( "hidden" );
    pickups::clearspaceforscriptableinstance();
    pickups::registerscriptableinstance( elementscriptable );
    elementscriptable.criticalitem = 1;
    return elementscriptable;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x5f42aa73, Offset: 0x15a84
// Size: 0x98
function function_45f544f77970e29b( position, angles )
{
    element = self;
    lootid = function_ca621b047cf24253( element.elementid, 5 );
    backpackname = common_inventory::function_a7a3fe2f2b6b7582( lootid );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( position, angles );
    spawnoptions.critical = 1;
    scriptable = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( backpackname, 1, spawnoptions );
    scriptable.criticalitem = 1;
    return scriptable;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x8bf3528, Offset: 0x15b25
// Size: 0xbb
function function_a4558788c086becf()
{
    if ( !isdefined( level.arrow.props.elements ) )
    {
        return;
    }
    
    foreach ( info in level.arrow.teaminfo )
    {
        if ( !isdefined( info ) )
        {
            continue;
        }
        
        function_1b2080822f11788e( info.targetteam );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x915cb55, Offset: 0x15be8
// Size: 0xc2
function function_1b2080822f11788e( targetteam )
{
    if ( !isdefined( level.arrow.props.elements[ targetteam ] ) )
    {
        return;
    }
    
    foreach ( element in level.arrow.props.elements[ targetteam ] )
    {
        element function_71f4537787958d6c();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x11610088, Offset: 0x15cb2
// Size: 0xe2
function function_71f4537787958d6c()
{
    element = self;
    
    if ( !isdefined( element ) || element.cleanup )
    {
        return;
    }
    
    element.cleanup = 1;
    
    if ( isdefined( element.player ) && isdefined( element.itemindex ) )
    {
        element.player common_inventory::function_4f226d9d5d61901e( element.itemindex, 1 );
    }
    
    if ( isdefined( element.funccleanup ) )
    {
        element [[ element.funccleanup ]]();
    }
    
    trackingcondition = element.alwaystrack || level.arrow.dvars.var_2108533c91a9051a;
    element function_3118fc50fb80be8f( trackingcondition );
    element function_ee7f8c159963d50f();
    element function_170bda5b2e99d253();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3e5c9a0b, Offset: 0x15d9c
// Size: 0x4f
function function_170bda5b2e99d253()
{
    element = self;
    
    if ( !isdefined( element.scriptable ) )
    {
        return;
    }
    
    element.scriptable function_ee7f8c159963d50f();
    pickups::loothide( element.scriptable );
    element.scriptable = undefined;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xa88ff338, Offset: 0x15df3
// Size: 0x78
function function_5a5d9ae50671e96a( player, instance, itemindex )
{
    if ( !instance function_31df7dd55c44bda8() && !instance function_c67ed81341a99d07() )
    {
        return;
    }
    
    element = function_395e28ee6df98f77( player, instance );
    
    if ( !isdefined( element ) )
    {
        return;
    }
    
    if ( element function_31df7dd55c44bda8() )
    {
        element function_6248728510695d6c( player );
    }
    
    element.itemindex = itemindex;
}

// Namespace br_elite_broken_arrow
// Params 5
// Checksum 0x432bf972, Offset: 0x15e73
// Size: 0xbc
function function_7258d356cf797c13( player, var_a1f2b0edcf8384f5, var_46df1fdc231963e3, var_1d268da1290aec32, var_759563c0ee5d07d0 )
{
    firstelement = undefined;
    var_57398dd9eb355fcd = function_a246dc01c1d8e60e( var_a1f2b0edcf8384f5, 5 );
    
    if ( isdefined( var_57398dd9eb355fcd ) )
    {
        firstelement = function_b98555514759173c( player, var_57398dd9eb355fcd, var_1d268da1290aec32 );
    }
    
    secondelement = undefined;
    var_b1dd380e086f439f = function_a246dc01c1d8e60e( var_46df1fdc231963e3, 5 );
    
    if ( isdefined( var_b1dd380e086f439f ) )
    {
        secondelement = function_b98555514759173c( player, var_b1dd380e086f439f, var_759563c0ee5d07d0 );
    }
    
    if ( isdefined( firstelement ) )
    {
        firstelement.itemindex = var_759563c0ee5d07d0;
    }
    
    if ( isdefined( secondelement ) )
    {
        secondelement.itemindex = var_1d268da1290aec32;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xfcb1f09f, Offset: 0x15f37
// Size: 0xe4
function function_395e28ee6df98f77( player, instance )
{
    element = undefined;
    
    if ( isdefined( instance.elementref ) )
    {
        element = instance.elementref;
    }
    else if ( isdefined( instance.instance ) )
    {
        element = instance.instance.elementref;
    }
    else if ( isdefined( instance.scriptablename ) )
    {
        elementid = function_a246dc01c1d8e60e( instance.scriptablename, 0 );
        element = level.arrow.props.elements[ player.team ][ elementid ];
    }
    
    element.elementindex = function_ca621b047cf24253( element.elementid, 6 );
    return element;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xbd168cec, Offset: 0x16024
// Size: 0xb5, Type: bool
function function_6248728510695d6c( player, dontcarry )
{
    element = self;
    
    if ( !element function_770bbad081e3c123( player ) && !dontcarry )
    {
        player hud_message::showerrormessage( %"mp_br_ingame/mission_occupied" );
        return false;
    }
    
    if ( !element function_c977f58e352ad3a6( player ) )
    {
        player hud_message::showerrormessage( level.br_pickups.br_pickupdenyequipnoroom );
        return false;
    }
    
    element thread function_94df433ee70aa862( player, dontcarry );
    
    if ( isdefined( element.containerref ) )
    {
        element.containerref function_4e32922b51dfcb42( element.containerref function_ab5af3aa6a38e25a() );
    }
    
    return istrue( dontcarry );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb45c03e6, Offset: 0x160e2
// Size: 0xc5
function function_94df433ee70aa862( player, dontcarry )
{
    element = self;
    element notify( #"on_pickup" );
    
    if ( !dontcarry )
    {
        element.player = player;
        element.gastime = undefined;
    }
    
    if ( isdefined( element.funcpickup ) )
    {
        element [[ element.funcpickup ]]( player, dontcarry );
    }
    
    trackingcondition = element.alwaystrack || level.arrow.dvars.var_2108533c91a9051a;
    element function_7e138ac083b6ea81( player, dontcarry, trackingcondition );
    element function_623602fb0eb61c82( player );
    element function_f6b02e446cca9187();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf086e0c6, Offset: 0x161af
// Size: 0xe1
function function_f6b02e446cca9187()
{
    element = self;
    bombsite = level.arrow.props.bombsite;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    var_5fad6feb79b2970d = teaminfo function_2567ed6f703b2825();
    
    if ( bombsite.siterevealed && var_5fad6feb79b2970d )
    {
        teaminfo.state = 3;
        function_3b0990925ca12fb7( &"hash_64d41e0af742e20e" );
    }
    else if ( bombsite.dropping && var_5fad6feb79b2970d )
    {
        teaminfo.state = 2;
        function_3b0990925ca12fb7( &"br_elite_broken_arrow/waiting_bomb" );
    }
    
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x64381009, Offset: 0x16298
// Size: 0xd2
function function_623602fb0eb61c82( player )
{
    element = self;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    
    if ( !element.firstpickup )
    {
        return;
    }
    
    element.firstpickup = 0;
    teaminfo.firstpickups++;
    teaminfo notify( #"hash_11675fc4a3c8a965" );
    teaminfo function_ffcd4f6a6c4ca6f9( element, player );
    teaminfo.var_7c14906613fde75c |= function_18ff21e51998d8e6( element.elementindex );
    element function_8e16e5dc2d2b880c();
    br_analytics::function_3616e4c972df7830( player, element );
    teaminfo function_19dd36b491302c0( player );
    teaminfo thread function_25f7b3e96034f6c4();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf34c6739, Offset: 0x16372
// Size: 0x12e
function function_8e16e5dc2d2b880c()
{
    element = self;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    level thread music_br::function_80eb8d35f2f8013();
    
    if ( isdefined( game[ "dialog" ][ "arrow_collect_element_" + teaminfo.firstpickups ] ) )
    {
        teaminfo function_e770743a8f743fbc( "arrow_collect_element_" + teaminfo.firstpickups );
    }
    
    if ( teaminfo.firstpickups >= level.arrow.props.bombsite.neededelements.size )
    {
        teaminfo function_f5b9fee9ad433c19( "arrow_collect_element_all" );
        return;
    }
    
    if ( isdefined( game[ "dialog" ][ "arrow_alert_element_intro_" + teaminfo.firstpickups ] ) )
    {
        teaminfo function_f5b9fee9ad433c19( "arrow_alert_element_intro_" + teaminfo.firstpickups, 0 );
    }
    
    if ( isdefined( game[ "dialog" ][ "arrow_alert_element_" + teaminfo.firstpickups ] ) )
    {
        teaminfo function_f5b9fee9ad433c19( "arrow_alert_element_" + teaminfo.firstpickups );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x1f6e9451, Offset: 0x164a8
// Size: 0x11d
function function_ffcd4f6a6c4ca6f9( element, player )
{
    teaminfo = self;
    bombsite = level.arrow.props.bombsite;
    
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    function_5b3297bd648264db( element, player );
    
    if ( teaminfo.firstpickups == bombsite.neededelements.size )
    {
        if ( level.arrow.dvars.var_b16c7be26c6e0d6 )
        {
            hud_util::showsplashtoteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_elements_acquired" ) );
        }
        
        if ( !isdefined( level.arrow.var_77c50dbbc2a9544f ) )
        {
            hud_util::showsplashtoallexceptteam( teaminfo.targetteam, function_7a10d0b1b0720af0( "elite_arrow_elements_acquired_global" ), undefined, player );
            level.arrow.var_77c50dbbc2a9544f = 1;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb32174a0, Offset: 0x165cd
// Size: 0x12c
function function_5b3297bd648264db( element, player )
{
    /#
        if ( level.arrow.dvars.var_218ba9a171abfc61 )
        {
            return;
        }
    #/
    
    elementflags = 0;
    
    foreach ( team in level.arrow.teaminfo )
    {
        elementflags |= team.var_7c14906613fde75c;
    }
    
    alreadyfound = elementflags & function_18ff21e51998d8e6( element.elementindex );
    
    if ( !alreadyfound )
    {
        splashid = function_ca621b047cf24253( element.elementid, 11 );
        
        if ( isdefined( splashid ) )
        {
            hud_util::showsplashtoallexceptteam( element.targetteam, splashid, undefined, player );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x801464fb, Offset: 0x16701
// Size: 0x10b, Type: bool
function function_770bbad081e3c123( player )
{
    element = self;
    
    if ( !isdefined( level.arrow ) )
    {
        return false;
    }
    
    if ( level.arrow.dvars.elementinteract == 2 )
    {
    }
    else if ( level.arrow.dvars.elementinteract == 1 )
    {
        if ( !isdefined( level.arrow.teaminfo[ player.team ] ) )
        {
            return false;
        }
        
        if ( level.arrow.teaminfo[ player.team ].state == 0 )
        {
            return false;
        }
    }
    else if ( level.arrow.dvars.elementinteract == 0 )
    {
        if ( element.targetteam != player.team )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8dd75914, Offset: 0x16815
// Size: 0x8a, Type: bool
function function_c977f58e352ad3a6( player )
{
    element = self;
    
    if ( isdefined( element.itemindex ) )
    {
        backpackelement = function_b98555514759173c( player, element.elementid, element.itemindex );
        
        if ( backpackelement == element )
        {
            return true;
        }
    }
    
    lootid = function_ca621b047cf24253( element.elementid, 5 );
    
    if ( !player common_inventory::function_e332683b9ad5368b( lootid, 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8cf2c981, Offset: 0x168a8
// Size: 0xc7
function function_19dd36b491302c0( player )
{
    teaminfo = self;
    bombsite = level.arrow.props.bombsite;
    
    if ( level.arrow.dvars.scriptedflow != 0 )
    {
        return;
    }
    
    if ( teaminfo.firstpickups < bombsite.neededelements.size )
    {
        return;
    }
    
    /#
        if ( level.arrow.dvars.debug && level.arrow.debugstate == 8 )
        {
            return;
        }
    #/
    
    bombsite thread arrow_bombsitereveal( player );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6931c9e0, Offset: 0x16977
// Size: 0x12f
function function_25f7b3e96034f6c4()
{
    if ( !level.arrow.dvars.jailbreakenabled )
    {
        return;
    }
    
    teaminfo = self;
    bombsite = level.arrow.props.bombsite;
    
    if ( teaminfo.firstpickups < bombsite.neededelements.size )
    {
        return;
    }
    
    if ( isdefined( level.arrow.jailbreaktriggered ) )
    {
        return;
    }
    
    level.arrow.jailbreaktriggered = 1;
    
    if ( level.arrow.dvars.var_ce43d9340f0375ac )
    {
        br_publicevents::function_ba5a796958d4925a();
    }
    
    waittime = level.arrow.dvars.jailbreakwaittime;
    
    if ( isdefined( waittime ) && waittime > 0 )
    {
        wait waittime;
    }
    
    eventtype = %"jailbreak";
    skipwait = 1;
    level thread br_publicevents::runpubliceventoftype( eventtype, skipwait );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xb3b99c31, Offset: 0x16aae
// Size: 0x38, Type: bool
function function_dc24dc8b54ae7458()
{
    scriptable = self;
    element = scriptable.elementref;
    
    if ( !isdefined( element ) )
    {
        return false;
    }
    
    element thread function_c56a308284520258();
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x40539bcc, Offset: 0x16aef
// Size: 0xcd
function function_c56a308284520258()
{
    element = self;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    level endon( #"game_ended" );
    teaminfo endon( #"hash_bf2e9434c44de562" );
    position = element.scriptable.origin;
    angles = element.scriptable.angles;
    element function_170bda5b2e99d253();
    wait 0.25;
    
    if ( element.cleanup )
    {
        return;
    }
    
    scriptable = element function_45f544f77970e29b( position, angles );
    element function_d5dbd2a497d735fb( undefined, scriptable );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xd55a79f0, Offset: 0x16bc4
// Size: 0x70
function function_51730e86424734b2( player, instance, itemindex )
{
    if ( !instance function_31df7dd55c44bda8() )
    {
        return;
    }
    
    elementid = function_a246dc01c1d8e60e( instance.type, 0 );
    element = function_b98555514759173c( player, elementid, itemindex );
    
    if ( !isdefined( element ) )
    {
        return;
    }
    
    element function_d5dbd2a497d735fb( player, instance );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x90d43078, Offset: 0x16c3c
// Size: 0x104
function function_d5dbd2a497d735fb( player, instance )
{
    element = self;
    
    if ( isdefined( instance ) )
    {
        element thread function_1970d17dcf59aa23();
        instance.criticalitem = 1;
        instance.elementref = element;
        element.scriptable = instance;
    }
    
    if ( isdefined( element.funcdrop ) )
    {
        element [[ element.funcdrop ]]( player );
    }
    
    trackingcondition = element.alwaystrack || level.arrow.dvars.var_2108533c91a9051a;
    element function_86399e8b232b3750( player, trackingcondition );
    element.player = undefined;
    element.itemindex = undefined;
    teaminfo = level.arrow.teaminfo[ element.targetteam ];
    teaminfo function_e7460b727a2abab();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5cafc24f, Offset: 0x16d48
// Size: 0x22
function function_c47b76ea665c86bf( elementindex )
{
    heightoffset = -60 + 12 * elementindex;
    return heightoffset;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x12c9024b, Offset: 0x16d73
// Size: 0xef
function function_1970d17dcf59aa23()
{
    element = self;
    element notify( #"watch_circle" );
    element endon( #"watch_circle" );
    element endon( #"on_pickup" );
    level endon( #"game_ended" );
    
    if ( level.arrow.dvars.var_9ebf173ff863acfa <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        wait level.arrow.dvars.var_9ebf173ff863acfa;
        
        if ( !isdefined( element.scriptable ) )
        {
            return;
        }
        
        ingas = !level.br_circle_disabled && !br_circle_util::ispointinmulticircledanger( element.scriptable.origin );
        
        if ( !ingas )
        {
            continue;
        }
        
        element function_ee2c46180b5b8bfa();
        element function_d23101a46fc09293();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xedbdc6de, Offset: 0x16e6a
// Size: 0xed
function function_ee2c46180b5b8bfa()
{
    element = self;
    
    if ( level.arrow.dvars.elementgastime < 0 )
    {
        return;
    }
    
    if ( !isdefined( element.gastime ) )
    {
        element.gastime = 0;
    }
    
    element.gastime += level.arrow.dvars.var_9ebf173ff863acfa;
    
    if ( element.gastime >= level.arrow.dvars.elementgastime )
    {
        teaminfo = level.arrow.teaminfo[ element.targetteam ];
        teaminfo thread function_14ed8a3bc197bff6( "element_gas_timeout" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x530fc485, Offset: 0x16f5f
// Size: 0xed
function function_d23101a46fc09293()
{
    element = self;
    
    if ( level.arrow.dvars.var_82ccd8cc5cd2df73 < 0 )
    {
        return;
    }
    
    if ( !( isdefined( element ) && isdefined( element.scriptable ) && isdefined( element.scriptable.origin ) ) )
    {
        return;
    }
    
    toofar = !br_circle_util::ispointinmulticircledanger( element.scriptable.origin, level.arrow.dvars.var_82ccd8cc5cd2df73 );
    
    if ( toofar )
    {
        teaminfo = level.arrow.teaminfo[ element.targetteam ];
        
        if ( !isdefined( teaminfo ) )
        {
            return;
        }
        
        teaminfo thread function_14ed8a3bc197bff6( "element_gas_too_far" );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xec6ade45, Offset: 0x17054
// Size: 0xde
function function_9b5de2b26454a4b6( player, elementid, itemindex )
{
    bombsite = self;
    teaminfo = level.arrow.teaminfo[ player.team ];
    teaminfo endon( #"hash_bf2e9434c44de562" );
    element = function_b98555514759173c( player, elementid, itemindex );
    
    if ( isdefined( element ) && element.cleanup )
    {
        return;
    }
    
    bombsite.neededelements[ elementid ]++;
    bombsite function_a59e440345d534f0( elementid );
    function_c9a9e36e63a2308e();
    function_c55c319265aa598c();
    
    if ( isdefined( element ) )
    {
        element function_71f4537787958d6c();
    }
    
    bombsite function_b235bf93d6871888( player );
    
    if ( function_2169466aa0685681() )
    {
        bombsite arrow_bombsitearm( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8c129b47, Offset: 0x1713a
// Size: 0x1a3
function function_a59e440345d534f0( elementid )
{
    bombsite = self;
    placedcount = 0;
    
    foreach ( element in level.arrow.elementlist )
    {
        placedcount += bombsite.neededelements[ element.elementid ];
    }
    
    foreach ( teaminfo in level.arrow.teaminfo )
    {
        if ( !isdefined( teaminfo ) )
        {
            continue;
        }
        
        if ( !isdefined( level.arrow.props.elements[ teaminfo.targetteam ] ) )
        {
            continue;
        }
        
        level.arrow.props.elements[ teaminfo.targetteam ][ elementid ].var_5aab5c7a55f6dac6 = placedcount;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6ebbe836, Offset: 0x172e5
// Size: 0x5f
function function_1282bda3309ca5b1()
{
    element = self;
    
    if ( !isdefined( element.scriptable ) )
    {
        return "hidden";
    }
    
    partname = element.scriptable function_7c320131bd49bb18()[ 0 ];
    curstate = element.scriptable getscriptablepartstate( partname, 1 );
    return curstate;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xbb29e693, Offset: 0x1734d
// Size: 0x3c
function function_4751c49e2dd970b5( newstate )
{
    element = self;
    
    if ( !isdefined( element ) )
    {
        return;
    }
    
    partname = element function_7c320131bd49bb18()[ 0 ];
    element setscriptablepartstate( partname, newstate );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd7dee5c0, Offset: 0x17391
// Size: 0xda
function function_98f8fb1c5418a605( elementid )
{
    elementsarray = [];
    
    if ( !( isdefined( elementid ) && isdefined( level.arrow.props.elements ) ) )
    {
        return elementsarray;
    }
    
    foreach ( teamelements in level.arrow.props.elements )
    {
        if ( isdefined( teamelements[ elementid ] ) )
        {
            elementsarray[ elementsarray.size ] = teamelements[ elementid ];
        }
    }
    
    return elementsarray;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc6b5368, Offset: 0x17474
// Size: 0x4e
function function_c45ae5931fd13dfe( newstate )
{
    iconstate = undefined;
    
    if ( newstate == "dropped" || newstate == "visible" )
    {
        iconstate = "ground";
    }
    else if ( newstate == "hidden" )
    {
        iconstate = "player";
    }
    
    return iconstate;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x93024548, Offset: 0x174cb
// Size: 0x153
function function_27b49d1a3c1a4881( player, isvisible )
{
    teaminfo = level.arrow.teaminfo[ player.team ];
    
    if ( !( isdefined( teaminfo ) && isdefined( level.arrow.props.elements ) ) )
    {
        return;
    }
    
    if ( isdefined( level.arrow.props.elements[ teaminfo.targetteam ] ) )
    {
        foreach ( element in level.arrow.props.elements[ teaminfo.targetteam ] )
        {
            element function_b09749f100e42ff1( player, isvisible );
            
            if ( isdefined( element.scriptable ) )
            {
                element.scriptable function_b09749f100e42ff1( player, isvisible );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x806bb307, Offset: 0x17626
// Size: 0x65, Type: bool
function function_4769873919350375()
{
    elementinstance = self;
    element = elementinstance.elementref;
    
    if ( isdefined( element ) )
    {
        teaminfo = level.arrow.teaminfo[ element.targetteam ];
        teaminfo thread function_14ed8a3bc197bff6( "element_deleted_in_area_swap" );
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x1f597401, Offset: 0x17694
// Size: 0x124
function function_4d9f382f7c2dafab( player, isvisible, teamoverride )
{
    if ( !isdefined( level.arrow.props.containers ) )
    {
        return;
    }
    
    containers = undefined;
    
    if ( isdefined( teamoverride ) )
    {
        containers = level.arrow.props.containers[ teamoverride ];
    }
    else
    {
        containers = level.arrow.props.containers[ player.team ];
    }
    
    if ( !isdefined( containers ) )
    {
        return;
    }
    
    foreach ( container in containers )
    {
        if ( isdefined( container ) )
        {
            container function_68f1c109685ad84b( player, isvisible );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x1d9a2494, Offset: 0x177c0
// Size: 0x10a
function function_161bef5b8b736b3d( player, elementid, isvisible )
{
    if ( isdefined( level.arrow.props.elements ) )
    {
        foreach ( teamelements in level.arrow.props.elements )
        {
            targetelement = teamelements[ elementid ];
            
            if ( !isdefined( targetelement ) )
            {
                continue;
            }
            
            targetelement function_b09749f100e42ff1( player, isvisible );
            
            if ( isdefined( targetelement.scriptable ) )
            {
                targetelement.scriptable function_b09749f100e42ff1( player, isvisible );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x7ed2b718, Offset: 0x178d2
// Size: 0x46
function function_5a7d980c9e870d29( var_7dc69ac945958166 )
{
    element = self;
    element function_96e433f12fac8051( var_7dc69ac945958166 );
    
    if ( isdefined( element.scriptable ) )
    {
        element.scriptable function_96e433f12fac8051( var_7dc69ac945958166 );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xd6406733, Offset: 0x17920
// Size: 0xd9
function function_4105c9bb4802e41c()
{
    element = self;
    iconent = element.geigerent;
    
    if ( isdefined( element.scriptable ) && isdefined( element.scriptable.linkedparent ) && !element.scriptable.linkedparent.isdestroyed )
    {
        iconent = element.scriptable.linkedparent;
    }
    
    iconoffset = ( 0, 0, 25 );
    
    if ( iconent == element.geigerent )
    {
        return [ iconent, iconoffset ];
    }
    
    iconoffset = ( 0, 0, 80 );
    return [ iconent, iconoffset ];
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x294e389f, Offset: 0x17a02
// Size: 0x98
function function_aabbbc78ff2214bc( toenable )
{
    element = self;
    
    switch ( element.elementid )
    {
        case #"hash_6d3f826c438808be":
            element function_1fe36133e26f1a49( istrue( toenable ) );
            
            if ( toenable )
            {
                element function_efdf2e48372641d();
            }
            
            return;
        case #"hash_89183e6c51a64184":
            element function_5fc4d6ee1864e952( istrue( toenable ) );
            return;
        case #"hash_4082276c2c059c84":
            element function_43e04c396234e215();
            return;
        case #"hash_fb365c6c0708aacb":
            element function_658ed1b5e399c54();
            return;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x2a4bf0a9, Offset: 0x17aa2
// Size: 0x71
function function_1bc78c7457e6ff7d()
{
    element = self;
    
    if ( isdefined( element.player ) )
    {
        if ( isdefined( element.player.vehicle ) && vehicle_occupancy::function_3080323254ba6900( element.player ) )
        {
            return element.player.vehicle;
        }
        
        return element.player;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x358408a8, Offset: 0x17b1c
// Size: 0xbd
function function_a28ae6b4340909e1()
{
    element = self;
    carrierent = element function_1bc78c7457e6ff7d();
    
    if ( isdefined( carrierent ) )
    {
        return carrierent;
    }
    
    if ( isdefined( element.scriptable ) )
    {
        return element.scriptable;
    }
    
    if ( isdefined( element.elementid ) && isdefined( level.arrow.props.containers[ element.targetteam ] ) )
    {
        return level.arrow.props.containers[ element.targetteam ][ element.elementid ];
    }
}

/#

    // Namespace br_elite_broken_arrow
    // Params 8
    // Checksum 0x189ebbbe, Offset: 0x17be2
    // Size: 0x1bd, Type: dev
    function function_9ad099e8987cc34a( position, radius, r0, r1, r2, r3, r4, r5 )
    {
        isdebug = getdvarint( @"scr_br_elite_broken_arrow_debug", 0 );
        
        if ( isdebug )
        {
            player = level.players[ 0 ];
            
            if ( isplayer( player ) && !isbot( player ) && !isagent( player ) )
            {
                color = ( 1, 1, 1 );
                dist = distance( player.origin, position );
                
                if ( dist <= r0 )
                {
                    color = ( 1, 0.5, 0.5 );
                }
                else if ( dist <= r1 )
                {
                    color = ( 1, 0.3, 0.125 );
                }
                else if ( dist <= r2 )
                {
                    color = ( 1, 0.5, 0 );
                }
                else if ( dist <= r3 )
                {
                    color = ( 1, 0.75, 0.5 );
                }
                else if ( dist <= r4 )
                {
                    color = ( 1, 1, 0.5 );
                }
                else if ( dist <= r5 )
                {
                    color = ( 1, 1, 0.75 );
                }
                
                print3d( position, "<dev string:x309>" + int( dist ), color, 1, 0.666, 1, 1 );
            }
            
            sphere( position, 7.5, ( 1, 0.25, 0.25 ), 0, 1 );
            sphere( position, radius, ( 1, 0.25, 0.25 ), 0, 1 );
        }
    }

#/

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xf7dc1d41, Offset: 0x17da7
// Size: 0x9d
function function_fb50f8f59417fa80( distsq, diststates )
{
    foreach ( dist, state in diststates )
    {
        distsqstate = squared( dist );
        
        if ( distsq <= distsqstate )
        {
            return state;
        }
    }
    
    return "off";
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xf5f2769, Offset: 0x17e4d
// Size: 0xc4
function function_74b0e4a5d7512dae( distsq, distdelays )
{
    foreach ( dist, delays in distdelays )
    {
        distsqdelay = squared( dist );
        
        if ( distsq <= distsqdelay )
        {
            delaymin = delays[ 0 ];
            delaymax = delays[ 1 ];
            delay = randomfloatrange( delaymin, delaymax );
            return delay;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0xf5707643, Offset: 0x17f1a
// Size: 0xae
function function_a3aa68989bb0fdf2( element, player, distdelays, diststates )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    assert( isdefined( element.elementid ) );
    InvalidOpCode( 0x7 );
    // Unknown operator ( 0x7, t11, Black Ops 7 )
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb5e98be, Offset: 0x18225
// Size: 0x432
function function_fc194ab8b74c5b8b( element, radius )
{
    level endon( #"game_ended" );
    element notify( #"hash_eaf4507561309458" );
    element endon( #"hash_eaf4507561309458" );
    level.arrow.dvars.var_480100cb7388af26 = getdvarint( @"hash_d2b336a16e9b3f70", 1 );
    level.arrow.dvars.var_d8eb38995294120d = getdvarint( @"hash_98cb40fb319bcd47", 2304 );
    dvardist = getdvarint( @"hash_98cb40fb319bcd47", 2304 );
    
    if ( !isdefined( radius ) )
    {
        radius = dvardist;
    }
    
    r0 = int( radius * 0.03125 );
    r1 = int( radius * 0.0625 );
    r2 = int( radius * 0.125 );
    r3 = int( radius * 0.25 );
    r4 = int( radius * 0.5 );
    r5 = int( radius * 1 );
    distdelays = [];
    distdelays[ r0 ] = [ 0.01, 0.02 ];
    distdelays[ r1 ] = [ 0.02, 0.05 ];
    distdelays[ r2 ] = [ 0.05, 0.1 ];
    distdelays[ r3 ] = [ 0.1, 0.2 ];
    distdelays[ r4 ] = [ 0.2, 0.5 ];
    distdelays[ r5 ] = [ 0.5, 1 ];
    diststates = [];
    diststates[ r0 ] = "100cps";
    diststates[ r1 ] = "50cps";
    diststates[ r2 ] = "20cps";
    diststates[ r3 ] = "10cps";
    diststates[ r4 ] = "5cps";
    diststates[ r5 ] = "2cps";
    
    if ( level.arrow.dvars.var_480100cb7388af26 == 1 )
    {
        element.geigerent = spawn( "script_model", ( 0, 0, 0 ) );
        element.geigerent setmodel( "tag_origin" );
    }
    
    while ( !element.cleanup )
    {
        elemententity = element function_a28ae6b4340909e1();
        
        if ( isdefined( elemententity ) )
        {
            position = elemententity.origin + ( 0, 0, 7.5 );
            
            if ( isent( element.geigerent ) )
            {
                element.geigerent.origin = elemententity.origin + ( 0, 0, 7.5 );
                position = element.geigerent.origin;
            }
            
            players = getentarrayinradius( "player", #classname, position, radius );
            
            foreach ( player in players )
            {
                var_2cdedb60f8a9faec = isarray( player.var_1e64e57b04591f8a ) && isdefined( player.var_1e64e57b04591f8a[ element.elementid ] );
                
                if ( !var_2cdedb60f8a9faec )
                {
                    player thread function_a3aa68989bb0fdf2( element, player, distdelays, diststates );
                }
            }
            
            /#
                function_9ad099e8987cc34a( position, radius, r0, r1, r2, r3, r4, r5 );
            #/
        }
        
        waitframe();
    }
    
    if ( isent( element.geigerent ) )
    {
        element.geigerent delete();
        element.geigerent = undefined;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x35d1787e, Offset: 0x1865f
// Size: 0x29
function function_c2569c447406d173()
{
    element = self;
    element.outlineids = [];
    element.outlineplayers = [];
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x8ba841b8, Offset: 0x18690
// Size: 0xc3
function function_a7dd0e5f18d7b236( outlinetype )
{
    element = self;
    
    if ( isdefined( element.outlineplayers ) )
    {
        foreach ( var_7dd27c2ee8d854d6 in element.outlineplayers )
        {
            element function_569d888e1c06f55c( var_7dd27c2ee8d854d6 );
            element function_4ebe15c2b805d314( var_7dd27c2ee8d854d6, outlinetype );
        }
    }
    
    element.outlineids = undefined;
    element.outlineplayers = undefined;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe2f2de53, Offset: 0x1875b
// Size: 0x78
function function_4ebe15c2b805d314( player, outlinetype )
{
    element = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    element endon( #"element_cleanup" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.var_308c34e56598ff62 )
    {
        player outline::_hudoutlineviewmodelenable( outlinetype, 0 );
        return;
    }
    
    player outline::_hudoutlineviewmodeldisable();
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xa8e95ef1, Offset: 0x187db
// Size: 0x7d
function function_7257c2e88eba0345( var_7dd27c2ee8d854d6, outlinetype, prioritygroup )
{
    element = self;
    var_40f30570a95b9375 = var_7dd27c2ee8d854d6 getentitynumber();
    id = outline::outlineenableforall( var_7dd27c2ee8d854d6, outlinetype, prioritygroup );
    element.outlineids[ var_40f30570a95b9375 ] = id;
    element.outlineplayers[ var_40f30570a95b9375 ] = var_7dd27c2ee8d854d6;
    var_7dd27c2ee8d854d6.var_308c34e56598ff62 = 1;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf8c80bb2, Offset: 0x18860
// Size: 0x80
function function_569d888e1c06f55c( var_7dd27c2ee8d854d6 )
{
    element = self;
    
    if ( !isdefined( var_7dd27c2ee8d854d6 ) )
    {
        return;
    }
    
    var_40f30570a95b9375 = var_7dd27c2ee8d854d6 getentitynumber();
    id = element.outlineids[ var_40f30570a95b9375 ];
    
    if ( isdefined( id ) )
    {
        outline::outlinedisable( id, var_7dd27c2ee8d854d6 );
    }
    
    element.outlineids[ var_40f30570a95b9375 ] = undefined;
    element.outlineplayers[ var_40f30570a95b9375 ] = undefined;
    var_7dd27c2ee8d854d6.var_308c34e56598ff62 = undefined;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xdb8cc35, Offset: 0x188e8
// Size: 0xc9
function function_6696f1bf9888a239( player, state, outlinetype )
{
    element = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    foreach ( playervisible in element.outlineplayers )
    {
        if ( !isdefined( playervisible ) )
        {
            continue;
        }
        
        if ( state )
        {
            playervisible hudoutlineenableforclient( player, outlinetype );
            continue;
        }
        
        playervisible hudoutlinedisableforclient( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd29fb0b5, Offset: 0x189b9
// Size: 0x42, Type: bool
function function_a3f8a164343cdf5f( player )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return false;
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        return false;
    }
    
    if ( player.var_308c34e56598ff62 )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xf4e8601e, Offset: 0x18a04
// Size: 0x37
function function_cb88db6faa38c2d9( element, player )
{
    player setsoundsubmix( "mute_scripted5", 0.1, 0.5 );
    player playlocalsound( "evt_elite_arrow_element_pickup_swt" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xd76e20b7, Offset: 0x18a43
// Size: 0x2e
function function_ac74db64ad693b36( element, player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player clearsoundsubmix( "mute_scripted5", 0 );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x33254f77, Offset: 0x18a79
// Size: 0x77
function function_75b7121227878f03( position, radius, height )
{
    element = self;
    trigger = spawn( "trigger_rotatable_radius", position, 0, radius, height );
    trigger.radius = radius;
    trigger.height = height;
    trigger.element = element;
    trigger enablelinkto();
    return trigger;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2d2f5994, Offset: 0x18af9
// Size: 0xb7
function function_99ea1059594ec8bc( trigger, linkent )
{
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    if ( trigger islinked() )
    {
        trigger unlink();
    }
    
    trigger notify( #"trigger_link" );
    
    if ( !( isdefined( linkent ) && isdefined( linkent.origin ) ) )
    {
        return;
    }
    
    trigger.origin = linkent.origin;
    offsetz = function_40f8ef8915d450b7( trigger );
    trigger.origin -= ( 0, 0, offsetz );
    
    if ( isent( linkent ) )
    {
        trigger linkto( linkent );
        return;
    }
    
    thread function_542cb52ab498204( trigger, linkent );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xfe4153b, Offset: 0x18bb8
// Size: 0xaf
function function_542cb52ab498204( trigger, linkent )
{
    trigger endon( #"trigger_link" );
    trigger endon( #"destroy" );
    linkent endon( #"destroy" );
    offsetz = function_40f8ef8915d450b7( trigger );
    
    while ( true )
    {
        wait 0.25;
        
        if ( !( isdefined( trigger ) && isdefined( linkent ) && isdefined( linkent.origin ) ) )
        {
            return;
        }
        
        trigger.origin = linkent.origin;
        trigger.origin -= ( 0, 0, offsetz );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x312c06c1, Offset: 0x18c6f
// Size: 0x4a
function function_40f8ef8915d450b7( trigger )
{
    if ( isdefined( trigger.height ) )
    {
        return ( trigger.height * level.arrow.dvars.triggerheightoffset );
    }
    
    return 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x90b82f08, Offset: 0x18cc2
// Size: 0x4b
function function_560ca4841716b4a0()
{
    element = self;
    trigger = element.trigger;
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    trigger notify( #"destroy" );
    trigger delete();
    element.trigger = undefined;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x62363120, Offset: 0x18d15
// Size: 0xca
function function_302bded5d0fc2aaa( player, trigger, force, ignoreheld )
{
    if ( !isplayer( player ) || !isalive( player ) || !isdefined( trigger ) )
    {
        return;
    }
    
    if ( !player istouching( trigger ) && !force )
    {
        return;
    }
    
    element = trigger.element;
    
    if ( !isdefined( element ) )
    {
        return;
    }
    
    if ( function_c38819bc98658c08( player, element.elementid ) && !ignoreheld )
    {
        return;
    }
    
    if ( !isdefined( trigger.nearbyplayers ) )
    {
        trigger.nearbyplayers = [];
    }
    
    trigger.nearbyplayers[ player.clientid ] = player;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x7fc9143b, Offset: 0x18de7
// Size: 0xab
function function_393d07d9567b9e06( vehicle, trigger )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.occupants ) ) )
    {
        return;
    }
    
    waitframe();
    
    foreach ( occupant in vehicle.occupants )
    {
        function_302bded5d0fc2aaa( occupant, trigger, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x2b01f6b, Offset: 0x18e9a
// Size: 0x88
function function_b5db4f3125a6431c( player, trigger, force )
{
    if ( !isplayer( player ) || !isdefined( trigger ) )
    {
        return;
    }
    
    if ( player istouching( trigger ) && !force )
    {
        return;
    }
    
    element = trigger.element;
    
    if ( !isdefined( element ) )
    {
        return;
    }
    
    if ( isdefined( trigger.nearbyplayers ) )
    {
        trigger.nearbyplayers[ player.clientid ] = undefined;
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe50bd2c8, Offset: 0x18f2a
// Size: 0xab
function function_22ba605a11e11bc4( vehicle, trigger )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.occupants ) ) )
    {
        return;
    }
    
    waitframe();
    
    foreach ( occupant in vehicle.occupants )
    {
        function_b5db4f3125a6431c( occupant, trigger, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xea4b19b6, Offset: 0x18fdd
// Size: 0x83
function function_704babccabc9d084( elementid, position, angles )
{
    teaminfo = self;
    beryllium = teaminfo function_861baab5997629cd( elementid, 1 );
    beryllium.alwaystrack = 1;
    beryllium.funcpickup = &function_1917d15e04a8ea8;
    beryllium.funcdrop = &function_556f29c55a7a2c41;
    beryllium.funccleanup = &function_f1877e998226719f;
    return beryllium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x11a4655f, Offset: 0x19069
// Size: 0x1d
function function_f1877e998226719f()
{
    beryllium = self;
    beryllium function_a7dd0e5f18d7b236( "outline_nodepth_red" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb6c6114f, Offset: 0x1908e
// Size: 0x56
function function_1917d15e04a8ea8( player, dontcarry )
{
    beryllium = self;
    
    if ( level.arrow.dvars.var_67a9db4215269074 )
    {
        beryllium function_a7dd0e5f18d7b236( "outline_nodepth_red" );
    }
    
    if ( dontcarry )
    {
        return;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x55a728c2, Offset: 0x190ec
// Size: 0x22
function function_556f29c55a7a2c41( player )
{
    beryllium = self;
    beryllium arrow_beroutline();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x378853bf, Offset: 0x19116
// Size: 0x74
function arrow_beroutline( resettime )
{
    beryllium = self;
    
    if ( !level.arrow.dvars.beroutline )
    {
        return;
    }
    
    beryllium function_c2569c447406d173();
    
    if ( !isdefined( beryllium.outlinetime ) || resettime )
    {
        beryllium.outlinetime = 0;
    }
    
    beryllium thread function_7364769761abdce7();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xcfae100b, Offset: 0x19192
// Size: 0xde
function function_7364769761abdce7()
{
    beryllium = self;
    level endon( #"game_ended" );
    beryllium endon( #"death" );
    beryllium endon( #"on_pickup" );
    
    while ( !self.cleanup )
    {
        beryllium.outlinetime += level.arrow.dvars.var_527e5dff339e2860;
        
        if ( beryllium.outlinetime >= level.arrow.dvars.var_71c6373dc2407ed1 )
        {
            beryllium function_a7aa68397a2dba18();
            beryllium.outlinetime = 0;
        }
        
        wait level.arrow.dvars.var_527e5dff339e2860;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x35b1f85a, Offset: 0x19278
// Size: 0xb0
function function_a7aa68397a2dba18()
{
    beryllium = self;
    teammates = teams::getteamdata( beryllium.targetteam, "players" );
    
    foreach ( player in teammates )
    {
        if ( !beryllium function_a3f8a164343cdf5f( player ) )
        {
            continue;
        }
        
        beryllium thread function_56a7e394062c9e94( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb273d9d5, Offset: 0x19330
// Size: 0x71
function function_56a7e394062c9e94( player )
{
    beryllium = self;
    level endon( #"game_ended" );
    beryllium endon( #"death" );
    beryllium endon( #"on_pickup" );
    beryllium function_d15d2f7ae680c8b8( player );
    wait level.arrow.dvars.var_8aae7bc9045309cf;
    beryllium function_f4b4b962f676d909( player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x67f1a732, Offset: 0x193a9
// Size: 0x37
function function_d15d2f7ae680c8b8( player )
{
    beryllium = self;
    beryllium function_7257c2e88eba0345( player, "outline_nodepth_red", "level_script" );
    beryllium thread function_821f64be9b512f88( player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa34e48ea, Offset: 0x193e8
// Size: 0x65
function function_821f64be9b512f88( player )
{
    beryllium = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_3bbdf0e408398b95" );
    utility::waittill_any_ents_return_no_endon_death( beryllium, "death", beryllium, "on_pickup", player, "death" );
    beryllium function_f4b4b962f676d909( player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc6ade631, Offset: 0x19455
// Size: 0x47
function function_f4b4b962f676d909( player )
{
    beryllium = self;
    
    if ( !isdefined( player ) || beryllium.cleanup )
    {
        return;
    }
    
    player notify( #"hash_3bbdf0e408398b95" );
    beryllium function_569d888e1c06f55c( player );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x121d9e3e, Offset: 0x194a4
// Size: 0x9d
function function_3a0d390b8833b99c( elementid, position, angles )
{
    teaminfo = self;
    tritium = teaminfo function_861baab5997629cd( elementid, level.arrow.dvars.var_2108533c91a9051a );
    tritium.alwaystrack = 0;
    tritium.funcpickup = &function_73c3333baf6fbb40;
    tritium.funcdrop = &function_3304c64352f37e89;
    tritium.funccleanup = &function_e15004893ebae367;
    return tritium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xc8b4fc81, Offset: 0x1954a
// Size: 0x19
function function_e15004893ebae367()
{
    tritium = self;
    tritium function_1fe36133e26f1a49( 0 );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x53575da1, Offset: 0x1956b
// Size: 0x3c
function function_73c3333baf6fbb40( player, dontcarry )
{
    tritium = self;
    
    if ( dontcarry )
    {
        return;
    }
    
    tritium function_efdf2e48372641d( tritium.player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xdff0489e, Offset: 0x195af
// Size: 0x2d
function function_3304c64352f37e89( player )
{
    tritium = self;
    tritium function_efdf2e48372641d( tritium.scriptable );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa159297a, Offset: 0x195e4
// Size: 0xe0
function function_1fe36133e26f1a49( toenable )
{
    tritium = self;
    
    if ( toenable )
    {
        linkent = tritium function_a28ae6b4340909e1();
        
        if ( !isdefined( linkent ) )
        {
            return;
        }
        
        if ( !isdefined( tritium.jament ) )
        {
            tritium function_8352d075a2d44fc4( linkent.origin );
        }
        
        foreach ( player in level.players )
        {
            tritium function_4e7f0e07f0cecbe9( player );
        }
        
        return;
    }
    
    tritium function_758079234f3125df();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x4e48703c, Offset: 0x196cc
// Size: 0x89
function function_8352d075a2d44fc4( position )
{
    tritium = self;
    
    if ( isdefined( tritium.jament ) )
    {
        return;
    }
    
    jament = spawn( "script_model", position );
    jament function_a68df5bdf751886a( level.arrow.dvars.var_bfa5c3db81f0d555 );
    jament.tritium = tritium;
    tritium.jament = jament;
    jament function_1f6cdaae3e202cbb();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xf3acfa23, Offset: 0x1975d
// Size: 0x48
function function_a68df5bdf751886a( jammerradius )
{
    jament = self;
    jament.var_1cc33a06670dae36 = [];
    jament.var_1b26f4a5de9c8b48 = 1;
    
    if ( isdefined( jammerradius ) )
    {
        jament.var_54b9b80a3d6bdb93 = jammerradius;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x79200752, Offset: 0x197ad
// Size: 0x61
function function_758079234f3125df()
{
    tritium = self;
    
    if ( !isdefined( tritium.jament ) )
    {
        return;
    }
    
    tritium function_a3c646f844e293d0();
    tritium.jament function_4ece4ead23c39c9d();
    tritium.jament notify( #"destroy" );
    tritium.jament delete();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x632b633a, Offset: 0x19816
// Size: 0x3a
function function_efdf2e48372641d( linkent )
{
    tritium = self;
    
    if ( !isdefined( linkent ) )
    {
        linkent = function_a28ae6b4340909e1();
    }
    
    function_99ea1059594ec8bc( tritium.jament, linkent );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x36110126, Offset: 0x19858
// Size: 0xea
function function_9a04f73120e3bf50( player )
{
    if ( !( isdefined( level.arrow ) && isdefined( level.arrow.props.elements ) ) )
    {
        return;
    }
    
    foreach ( teamelements in level.arrow.props.elements )
    {
        if ( !isdefined( teamelements[ "tri" ] ) )
        {
            continue;
        }
        
        tritium = teamelements[ "tri" ];
        tritium function_4e7f0e07f0cecbe9( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xdfa1873b, Offset: 0x1994a
// Size: 0x3b
function function_4e7f0e07f0cecbe9( player )
{
    tritium = self;
    
    if ( !tritium function_8c9aad2e0bafcd9c( player.team ) )
    {
        return;
    }
    
    tritium function_a42fb4681718f1a7( player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x2d3debb7, Offset: 0x1998d
// Size: 0xf2, Type: bool
function function_8c9aad2e0bafcd9c( team )
{
    tritium = self;
    
    if ( !isdefined( tritium.jament ) )
    {
        return false;
    }
    
    if ( level.arrow.dvars.triinteract == 2 )
    {
    }
    else if ( level.arrow.dvars.triinteract == 1 )
    {
        if ( !isdefined( level.arrow.teaminfo[ team ] ) )
        {
            return false;
        }
        
        if ( level.arrow.teaminfo[ team ].state == 0 )
        {
            return false;
        }
    }
    else if ( level.arrow.dvars.triinteract == 0 )
    {
        if ( tritium.targetteam != team )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x6545a4d4, Offset: 0x19a88
// Size: 0x56
function function_a42fb4681718f1a7( player )
{
    tritium = self;
    
    if ( !isdefined( tritium.jament ) )
    {
        return;
    }
    
    player utility::callsharedfunc( #"scrambler_drone_guard", #"setjammed", 1, tritium.jament, 1, 1 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x94ced8e5, Offset: 0x19ae6
// Size: 0xdd
function function_a3c646f844e293d0()
{
    tritium = self;
    
    if ( !isdefined( tritium.jament ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"scrambler_drone_guard", #"setjammed", 0, tritium.jament, 1, 1 );
    }
    
    tritium.jament utility::callsharedfunc( #"scrambler_drone_guard", #"endjammedeffect" );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6b5313c0, Offset: 0x19bcb
// Size: 0x47
function function_1f6cdaae3e202cbb()
{
    jament = self;
    
    if ( !level.arrow.dvars.triddos )
    {
        return;
    }
    
    jament.vehicles = [];
    jament thread function_83cea084cec8ec0d();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6962c3e, Offset: 0x19c1a
// Size: 0x94
function function_4ece4ead23c39c9d()
{
    jament = self;
    
    foreach ( vehicle in jament.vehicles )
    {
        jament function_9c89a6b5d15defc( vehicle );
    }
    
    jament.vehicles = undefined;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x3329330a, Offset: 0x19cb6
// Size: 0x13b
function function_83cea084cec8ec0d()
{
    jament = self;
    jament endon( #"death" );
    
    while ( true )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( !jament function_dc45df0d101e8a8( vehicle ) )
                {
                    continue;
                }
                
                jament thread function_f247448ba8ef222f( vehicle );
            }
        }
        
        wait level.arrow.dvars.var_2405e814f3c1956a;
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xaf893db0, Offset: 0x19df9
// Size: 0x112, Type: bool
function function_dc45df0d101e8a8( vehicle )
{
    jament = self;
    tritium = jament.tritium;
    
    if ( !( isdefined( tritium ) && isdefined( vehicle ) ) )
    {
        return false;
    }
    
    if ( vehicle.triddos )
    {
        return false;
    }
    
    vehicleteam = vehicle.team;
    
    if ( isdefined( vehicle.owner ) )
    {
        vehicleteam = vehicle.owner.team;
    }
    
    if ( !tritium function_8c9aad2e0bafcd9c( vehicleteam ) )
    {
        return false;
    }
    
    [ vehicleradius ] = vehicle getboundshalfsize();
    dist = level.arrow.dvars.var_72f0d2d059f8c74f + vehicleradius;
    distsq = squared( dist );
    
    if ( distancesquared( vehicle.origin, jament.origin ) > distsq )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xc39ea11a, Offset: 0x19f14
// Size: 0x65
function function_f247448ba8ef222f( vehicle )
{
    jament = self;
    jament endon( #"death" );
    vehicle endon( #"death" );
    jament function_31d97f616b316e5( vehicle );
    wait level.arrow.dvars.var_29878b57801e97c8;
    jament function_9c89a6b5d15defc( vehicle );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x9d015bb0, Offset: 0x19f81
// Size: 0xf1
function function_31d97f616b316e5( vehicle )
{
    jament = self;
    vehicle.triddos = 1;
    jament.vehicles[ vehicle getentitynumber() ] = vehicle;
    objweapon = makeweapon( "emp_pulse_mp" );
    data = damage_utility::packdamagedata( jament, vehicle, 1, objweapon, "MOD_EXPLOSIVE", jament, jament.origin );
    time = level.arrow.dvars.var_29878b57801e97c8 + level.arrow.dvars.var_2405e814f3c1956a;
    thread emp_debuff::function_1fdeda386a85c7c7( data, time, 0 );
    
    if ( level.arrow.dvars.var_d01564fbfd6f7abc )
    {
        vehicle vehphys_parkingbrake( 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1173e648, Offset: 0x1a07a
// Size: 0x66
function function_9c89a6b5d15defc( vehicle )
{
    jament = self;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.triddos = undefined;
    jament.vehicles[ vehicle getentitynumber() ] = undefined;
    
    if ( level.arrow.dvars.var_d01564fbfd6f7abc )
    {
        vehicle vehphys_parkingbrake( 0 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x29544f4, Offset: 0x1a0e8
// Size: 0xa8
function function_d70a3ce3e793557e( elementid, position, angles )
{
    teaminfo = self;
    plutonium = teaminfo function_861baab5997629cd( elementid, level.arrow.dvars.var_2108533c91a9051a );
    plutonium.alwaystrack = 0;
    plutonium.funcpickup = &function_6049c0093ce29022;
    plutonium.funcdrop = &function_aa3e86584bc54b4b;
    plutonium.funccleanup = &function_9306df4630dff59d;
    plutonium function_b00b9c413c5e4ab7( position, 0 );
    return plutonium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xabf10bd3, Offset: 0x1a199
// Size: 0x18
function function_9306df4630dff59d()
{
    plutonium = self;
    plutonium function_9ab0352544865c42();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x2b5a87bb, Offset: 0x1a1b9
// Size: 0x4e
function function_6049c0093ce29022( player, dontcarry )
{
    plutonium = self;
    
    if ( plutonium.firstpickup )
    {
        plutonium.damageenabled = 1;
    }
    
    if ( dontcarry )
    {
        return;
    }
    
    plutonium function_f8e4466a6aa609cf( player );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x36676a67, Offset: 0x1a20f
// Size: 0x12c
function function_f8e4466a6aa609cf( player )
{
    plutonium = self;
    player function_69cfb089afe68d45( 0, "elite_arrow_plutonium_far" );
    player function_69cfb089afe68d45( 1, "elite_arrow_plutonium_close", 1 );
    plutonium function_8bad98bb78a7884d( 1, utility::getfx( "arrow_plutonium_close" ), plutonium.geigerent, player );
    function_99ea1059594ec8bc( plutonium.trigger, player );
    
    if ( isdefined( plutonium.trigger.nearbyplayers ) )
    {
        foreach ( anyplayer in plutonium.trigger.nearbyplayers )
        {
            if ( !isdefined( anyplayer ) )
            {
                continue;
            }
            
            if ( anyplayer != player )
            {
                function_e85223dbb6a70b8d( anyplayer, plutonium.trigger );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd3c21e7, Offset: 0x1a343
// Size: 0x22
function function_aa3e86584bc54b4b( player )
{
    plutonium = self;
    plutonium function_f9db906c2863b76a();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x7fd94ab7, Offset: 0x1a36d
// Size: 0x152
function function_f9db906c2863b76a()
{
    plutonium = self;
    function_99ea1059594ec8bc( plutonium.trigger, plutonium.scriptable );
    
    if ( !isdefined( plutonium.player ) )
    {
        return;
    }
    
    plutonium.player function_69cfb089afe68d45( 0, "elite_arrow_plutonium_close" );
    
    if ( isdefined( plutonium.geigerent ) )
    {
        plutonium function_8bad98bb78a7884d( 0, utility::getfx( "arrow_plutonium_close" ), plutonium.geigerent, plutonium.player );
    }
    
    foreach ( teamelements in level.arrow.props.elements )
    {
        if ( !isdefined( teamelements[ "plu" ] ) )
        {
            continue;
        }
        
        trigger = teamelements[ "plu" ].trigger;
        function_e85223dbb6a70b8d( plutonium.player, trigger, undefined, 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xfa717443, Offset: 0x1a4c7
// Size: 0x1f5
function function_5fc4d6ee1864e952( toenable )
{
    plutonium = self;
    plutonium.damageenabled = istrue( toenable );
    
    if ( toenable )
    {
        if ( isdefined( plutonium.geigerent ) )
        {
            plutonium function_8bad98bb78a7884d( 1, utility::getfx( "arrow_plutonium_far" ), plutonium.geigerent );
        }
        
        if ( isdefined( plutonium.trigger.nearbyplayers ) )
        {
            foreach ( player in plutonium.trigger.nearbyplayers )
            {
                function_e85223dbb6a70b8d( player, plutonium.trigger );
            }
        }
        
        return;
    }
    
    if ( isdefined( plutonium.trigger.nearbyplayers ) )
    {
        if ( isdefined( plutonium.geigerent ) )
        {
            plutonium function_8bad98bb78a7884d( 0, utility::getfx( "arrow_plutonium_far" ), plutonium.geigerent );
            plutonium function_8bad98bb78a7884d( 0, utility::getfx( "arrow_plutonium_close" ), plutonium.geigerent );
        }
        
        foreach ( player in plutonium.trigger.nearbyplayers )
        {
            function_6ad53e7a35e27fc5( player, plutonium.trigger );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x29786f07, Offset: 0x1a6c4
// Size: 0x88
function function_b00b9c413c5e4ab7( position, startenabled )
{
    plutonium = self;
    plutonium.trigger = plutonium function_a472baa9b48912f8( position, level.arrow.dvars.var_c80b42d236134c96, level.arrow.dvars.var_51532f530ccac4ab );
    plutonium thread function_4ae48286932db8da();
    plutonium.damageenabled = startenabled;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x79cbd17e, Offset: 0x1a754
// Size: 0x146
function function_9ab0352544865c42()
{
    plutonium = self;
    
    if ( isdefined( plutonium.player ) )
    {
        plutonium.player function_69cfb089afe68d45( 0, "elite_arrow_plutonium_close" );
    }
    
    if ( isdefined( plutonium.trigger ) && isdefined( plutonium.trigger.nearbyplayers ) )
    {
        foreach ( player in plutonium.trigger.nearbyplayers )
        {
            function_6ad53e7a35e27fc5( player, plutonium.trigger, 1 );
        }
    }
    
    if ( isdefined( plutonium.geigerent ) )
    {
        plutonium function_8bad98bb78a7884d( 0, utility::getfx( "arrow_plutonium_far" ), plutonium.geigerent );
        plutonium function_8bad98bb78a7884d( 0, utility::getfx( "arrow_plutonium_close" ), plutonium.geigerent );
    }
    
    plutonium function_560ca4841716b4a0();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x85ddc55d, Offset: 0x1a8a2
// Size: 0x90
function function_4ae48286932db8da()
{
    plutonium = self;
    level endon( #"game_ended" );
    plutonium endon( #"element_cleanup" );
    
    while ( true )
    {
        if ( !plutonium.damageenabled )
        {
            wait level.arrow.dvars.var_ebf8847e50144553;
            continue;
        }
        
        plutonium function_bbeafe1c8b9686ff();
        plutonium function_da4f2d963226e033();
        wait level.arrow.dvars.var_ebf8847e50144553;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xce842967, Offset: 0x1a93a
// Size: 0x29c
function function_bbeafe1c8b9686ff()
{
    plutonium = self;
    
    if ( level.arrow.dvars.var_c38b93bfb001d469 <= 0 )
    {
        return;
    }
    
    if ( !( isdefined( level.vehicle ) && isdefined( plutonium.trigger ) ) )
    {
        return;
    }
    
    offsetz = function_40f8ef8915d450b7( plutonium.trigger );
    damageorigin = plutonium.trigger.origin + ( 0, 0, offsetz );
    damageradius = level.arrow.dvars.var_c80b42d236134c96;
    damageamount = level.arrow.dvars.var_c38b93bfb001d469;
    
    foreach ( vehicles in level.vehicle.instances )
    {
        foreach ( vehicle in vehicles )
        {
            if ( !isdefined( vehicle ) )
            {
                continue;
            }
            
            if ( distance2dsquared( vehicle.origin, damageorigin ) > squared( damageradius ) )
            {
                continue;
            }
            
            if ( !isdefined( vehicle.var_679bc32c865e8a5b ) )
            {
                vehicle.var_679bc32c865e8a5b = 0;
            }
            
            vehicle.var_679bc32c865e8a5b += level.arrow.dvars.var_ebf8847e50144553;
            
            if ( vehicle.var_679bc32c865e8a5b < level.arrow.dvars.var_f079e6040e40d41b )
            {
                continue;
            }
            
            vehicle dodamage( damageamount, vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", level.defaultfist );
            vehicle.var_679bc32c865e8a5b = 0;
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x9ed7d1e4, Offset: 0x1abde
// Size: 0x1e1
function function_da4f2d963226e033()
{
    plutonium = self;
    
    if ( isdefined( plutonium.trigger.nearbyplayers ) )
    {
        foreach ( player in plutonium.trigger.nearbyplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player istouching( plutonium.trigger ) && !isdefined( player.vehicle ) )
            {
                function_6ad53e7a35e27fc5( player, plutonium.trigger );
                continue;
            }
            
            if ( !isdefined( player.var_679bc32c865e8a5b ) )
            {
                player.var_679bc32c865e8a5b = 0;
            }
            
            player.var_679bc32c865e8a5b += level.arrow.dvars.var_ebf8847e50144553;
            
            if ( function_c38819bc98658c08( player, plutonium.elementid ) && player.var_679bc32c865e8a5b >= level.arrow.dvars.var_595e539abb7c3146 )
            {
                function_51f3dad9ffc95a06();
                player.var_679bc32c865e8a5b = 0;
                continue;
            }
            
            if ( player.var_679bc32c865e8a5b >= level.arrow.dvars.var_7c7623bdbc4d94e3 )
            {
                function_6d5ff9a1f7b40387( player );
                player.var_679bc32c865e8a5b = 0;
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xba9f2277, Offset: 0x1adc7
// Size: 0xe0
function function_6d5ff9a1f7b40387( player )
{
    plutonium = self;
    
    if ( level.arrow.dvars.var_59c2da93265dcb51 <= 0 )
    {
        return;
    }
    
    trigger = plutonium.trigger;
    
    if ( !isdefined( trigger ) )
    {
        return;
    }
    
    if ( function_c38819bc98658c08( player, "plu" ) )
    {
        return;
    }
    
    damage = level.arrow.dvars.var_59c2da93265dcb51;
    player dodamage( damage, plutonium.trigger.origin, player, undefined, "MOD_TRIGGER_HURT", level.defaultfist, "torso_upper" );
    player function_69cfb089afe68d45( 1, "elite_arrow_plutonium_far" );
    player playlocalsound( "evt_elite_arrow_plutonium_damage" );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x277571e0, Offset: 0x1aeaf
// Size: 0xb7
function function_51f3dad9ffc95a06()
{
    plutonium = self;
    
    if ( level.arrow.dvars.var_930cad23daeab954 <= 0 )
    {
        return;
    }
    
    if ( !isplayer( plutonium.player ) )
    {
        return;
    }
    
    damage = level.arrow.dvars.var_930cad23daeab954;
    player = plutonium.player;
    player dodamage( damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", level.defaultfist, "torso_upper" );
    player playlocalsound( "evt_elite_arrow_plutonium_damage" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xe1b44848, Offset: 0x1af6e
// Size: 0x67
function function_a472baa9b48912f8( position, radius, height )
{
    plutonium = self;
    trigger = plutonium function_75b7121227878f03( position, radius, height );
    trigger.targetname = "pluTrigger";
    trigger::makeenterexittrigger( trigger, &function_e85223dbb6a70b8d, &function_6ad53e7a35e27fc5 );
    return trigger;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x4b90d4f0, Offset: 0x1afde
// Size: 0xaf
function function_e85223dbb6a70b8d( entity, trigger, force, ignoreheld )
{
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_393d07d9567b9e06( entity, trigger );
        return;
    }
    
    function_302bded5d0fc2aaa( entity, trigger, force, ignoreheld );
    plutonium = trigger.element;
    
    if ( !isdefined( plutonium ) )
    {
        return;
    }
    
    if ( plutonium.damageenabled && ( !entity function_d959cd9f904a58eb( "elite_arrow_plutonium_close" ) || ignoreheld ) )
    {
        entity function_69cfb089afe68d45( 1, "elite_arrow_plutonium_far", 1 );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xaac2b64e, Offset: 0x1b095
// Size: 0x59
function function_6ad53e7a35e27fc5( entity, trigger, force )
{
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_22ba605a11e11bc4( entity, trigger );
        return;
    }
    
    function_b5db4f3125a6431c( entity, trigger, force );
    entity function_69cfb089afe68d45( 0, "elite_arrow_plutonium_far" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x933d7c6b, Offset: 0x1b0f6
// Size: 0x5f
function function_69cfb089afe68d45( visible, visionset, transitionduration )
{
    player = self;
    
    if ( visible )
    {
        if ( !function_d959cd9f904a58eb( visionset ) )
        {
            player game_utility::_visionsetnakedforplayer( visionset, transitionduration );
        }
        
        return;
    }
    
    if ( function_d959cd9f904a58eb( visionset ) )
    {
        player game_utility::_visionunsetnakedforplayer( visionset );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x83e81f8d, Offset: 0x1b15d
// Size: 0x28, Type: bool
function function_d959cd9f904a58eb( visionset )
{
    player = self;
    return isdefined( player.activevisionsetlist[ visionset ] );
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x87aae570, Offset: 0x1b18e
// Size: 0x79
function function_8bad98bb78a7884d( visible, id, ent, player )
{
    if ( visible )
    {
        if ( isdefined( player ) )
        {
            playfxontagforclients( id, ent, "tag_origin", player );
        }
        else
        {
            playfxontag( id, ent, "tag_origin" );
        }
        
        return;
    }
    
    if ( isdefined( player ) )
    {
        stopfxontagforclients( id, ent, "tag_origin", player );
        return;
    }
    
    stopfxontag( id, ent, "tag_origin" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x6622f326, Offset: 0x1b20f
// Size: 0xaa
function function_72df0fcdba426e19( elementid, position, angles )
{
    teaminfo = self;
    deuterium = teaminfo function_861baab5997629cd( elementid, level.arrow.dvars.var_2108533c91a9051a );
    deuterium.var_8d295e6fdc9c5864 = 0;
    deuterium.alwaystrack = 0;
    deuterium.funcpickup = &function_48e34ea3a9305fd3;
    deuterium.funcdrop = &function_748c3457b5ceee12;
    deuterium.funccleanup = &function_f8e33a1ef6314f8a;
    return deuterium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x1ccacf51, Offset: 0x1b2c2
// Size: 0x18
function function_f8e33a1ef6314f8a()
{
    deuterium = self;
    deuterium function_9d981e79b8e0f3e0();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x6121712d, Offset: 0x1b2e2
// Size: 0x4c
function function_33ab37392687a220( player, value )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player val::set( "deuterium_controls_restrictions", "slide", istrue( value ) );
    player val::set( "deuterium_controls_restrictions", "dtp", istrue( value ) );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb5ff0f28, Offset: 0x1b336
// Size: 0x58
function function_48e34ea3a9305fd3( player, dontcarry )
{
    deuterium = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( deuterium.firstpickup )
    {
        deuterium.var_8d295e6fdc9c5864 = 1;
    }
    
    if ( dontcarry )
    {
        return;
    }
    
    deuterium thread function_6bc66bf33fbd64b7();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x103f4d5, Offset: 0x1b396
// Size: 0x2f
function function_748c3457b5ceee12( player )
{
    deuterium = self;
    deuterium notify( #"deuterium_dropped" );
    deuterium function_9d981e79b8e0f3e0();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x86d81036, Offset: 0x1b3cd
// Size: 0xa6
function function_9d981e79b8e0f3e0()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    deuterium function_ca4d65d78bad28b4();
    player.movespeedscaler = 1;
    
    if ( player common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        player common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    player weapons::updatemovespeedscale();
    player.var_fef995115c379289 = 1;
    player setswimspeedscale( player.var_fef995115c379289 );
    function_33ab37392687a220( player, 1 );
    player.var_87ca408e836d56cf = undefined;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf3daae98, Offset: 0x1b47b
// Size: 0xa4
function function_6bc66bf33fbd64b7()
{
    deuterium = self;
    player = deuterium.player;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    deuterium endon( #"element_cleanup" );
    deuterium endon( #"deuterium_dropped" );
    function_33ab37392687a220( player, 0 );
    player.var_87ca408e836d56cf = &function_d1810a5415e2e3f9;
    deuterium thread function_15576f6cd1297694();
    
    while ( true )
    {
        if ( deuterium.var_8d295e6fdc9c5864 )
        {
            deuterium function_62263f8d62b183b1();
            deuterium function_83e490f11ef734d();
        }
        
        waitframe();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x99d2946f, Offset: 0x1b527
// Size: 0x63
function function_d1810a5415e2e3f9()
{
    player = self;
    
    if ( player isswimsprinting() )
    {
        breathtime = level.arrow.dvars.var_70cdbdc811d1f044;
    }
    else
    {
        breathtime = level.arrow.dvars.var_895fdf162edf00a3;
    }
    
    return breathtime;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x692451e3, Offset: 0x1b593
// Size: 0x45, Type: bool
function function_25683ff139e65b49()
{
    player = self;
    
    if ( player function_7e39007471591012() )
    {
        return false;
    }
    
    if ( isdefined( player.vehicle ) )
    {
        return false;
    }
    
    if ( player isonladder() )
    {
        return false;
    }
    
    if ( player isonascender() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x419bbe86, Offset: 0x1b5e1
// Size: 0x11a
function function_83e490f11ef734d()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !player function_25683ff139e65b49() )
    {
        deuterium function_ca4d65d78bad28b4();
        return;
    }
    
    if ( !( isdefined( player.var_55f5bc7c5cf2a51f ) && isdefined( player.var_631ebe5a65b688f8 ) ) )
    {
        return;
    }
    
    switch ( player.var_55f5bc7c5cf2a51f )
    {
        case 0:
            if ( player.var_631ebe5a65b688f8 == 0 )
            {
                if ( deuterium.coughfinished )
                {
                    deuterium function_ca4d65d78bad28b4();
                }
            }
            else if ( !deuterium.coughstarted )
            {
                deuterium function_e20e69824873f5f();
            }
            
            break;
        case 1:
            if ( player.var_631ebe5a65b688f8 == 2 )
            {
                if ( !deuterium.coughstarted )
                {
                    deuterium function_e20e69824873f5f();
                }
            }
            else if ( player.var_631ebe5a65b688f8 == 0 )
            {
                deuterium thread function_8c56c0fc281b5235();
            }
            
            break;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xe9224d10, Offset: 0x1b703
// Size: 0x82
function function_8c56c0fc281b5235()
{
    deuterium = self;
    player = deuterium.player;
    deuterium endon( #"deuterium_dropped" );
    deuterium endon( #"cough_cleared" );
    wait level.arrow.dvars.var_14980829444cda9b;
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    if ( !deuterium.coughstarted )
    {
        deuterium function_e20e69824873f5f();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf1cf106a, Offset: 0x1b78d
// Size: 0x129
function function_15576f6cd1297694()
{
    deuterium = self;
    player = deuterium.player;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    deuterium endon( #"element_cleanup" );
    deuterium endon( #"deuterium_dropped" );
    
    while ( true )
    {
        if ( deuterium.var_8d295e6fdc9c5864 && isplayer( player ) )
        {
            if ( function_c38819bc98658c08( player, deuterium.elementid ) )
            {
                if ( player function_7e39007471591012() )
                {
                    deuterium function_ca4d65d78bad28b4();
                    player.var_fef995115c379289 = function_76c7fdc919b431dd();
                    
                    if ( player.var_fef995115c379289 > 0 )
                    {
                        player setswimspeedscale( player.var_fef995115c379289 );
                    }
                }
                else if ( player isonground() )
                {
                    player.movespeedscaler = function_e97cca5897974b1a();
                    
                    if ( player.movespeedscaler > 0 )
                    {
                        player common::function_a0f5c85d465c5f0a( "moveSpeedScaler", player.movespeedscaler - 1 );
                        player weapons::updatemovespeedscale();
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x45d78be0, Offset: 0x1b8be
// Size: 0x132
function function_62263f8d62b183b1()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( function_c38819bc98658c08( player, deuterium.elementid ) )
    {
        if ( !player function_25683ff139e65b49() )
        {
            player.var_631ebe5a65b688f8 = 0;
            player.var_55f5bc7c5cf2a51f = 0;
            return;
        }
        
        if ( player isonground() )
        {
            var_5176d316abca82a6 = player issupersprinting();
            isplayersprinting = !var_5176d316abca82a6 && player issprinting();
            
            if ( isdefined( player.var_55f5bc7c5cf2a51f ) )
            {
                player.var_631ebe5a65b688f8 = player.var_55f5bc7c5cf2a51f;
            }
            
            if ( var_5176d316abca82a6 )
            {
                player.var_55f5bc7c5cf2a51f = 2;
            }
            else if ( isplayersprinting )
            {
                player.var_55f5bc7c5cf2a51f = 1;
            }
            else
            {
                player.var_55f5bc7c5cf2a51f = 0;
            }
            
            if ( !isdefined( player.var_631ebe5a65b688f8 ) && isdefined( player.var_55f5bc7c5cf2a51f ) )
            {
                player.var_631ebe5a65b688f8 = player.var_55f5bc7c5cf2a51f;
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x76586f95, Offset: 0x1b9f8
// Size: 0xd2
function function_76c7fdc919b431dd()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player isswimming() && player isswimunderwater() )
    {
        if ( player isswimsprinting() )
        {
            return level.arrow.dvars.var_3b2e99088566a4b6;
        }
        else
        {
            return level.arrow.dvars.var_dbffc9a45878e066;
        }
        
        return;
    }
    
    if ( player isswimsprinting() )
    {
        return level.arrow.dvars.var_4a3bd07e32d65e5a;
    }
    
    return level.arrow.dvars.var_389f987e8799d68a;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xbe815df0, Offset: 0x1bad2
// Size: 0x11c
function function_e97cca5897974b1a()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player issprinting() )
    {
        return level.arrow.dvars.var_251f223896982713;
    }
    
    if ( player issupersprinting() || player isautosprinting() )
    {
        return level.arrow.dvars.var_307f2b966c0d9b60;
    }
    
    if ( player crouchbuttonpressed() || player getstance() == "crouch" || player getstance() == "prone" )
    {
        return level.arrow.dvars.var_e3217483ea21be21;
    }
    
    if ( player issprintsliding() )
    {
        return level.arrow.dvars.var_7dbbb58baeea9a86;
    }
    
    return level.arrow.dvars.var_6ba986d3525f2913;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xccb54645, Offset: 0x1bbf6
// Size: 0x2a, Type: bool
function function_7e39007471591012()
{
    player = self;
    return isdefined( player ) && ( player swim_common::isplayerswimming() || player swim_common::isplayerunderwater() );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x351dfa4b, Offset: 0x1bc29
// Size: 0xd0
function function_e20e69824873f5f()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread gas_grenade::gas_applyblur();
    
    if ( !player.gascoughinprogress )
    {
        player thread gas_grenade::gas_queuecough( 0 );
        player white_phosphorus::enableloopingcoughaudio();
    }
    
    coughduration = level.arrow.dvars.var_d938274ec8d77376;
    
    if ( player.var_631ebe5a65b688f8 == 2 )
    {
        coughduration = level.arrow.dvars.var_ddb83dd5415064db;
    }
    
    deuterium.coughstarted = 1;
    wait coughduration;
    deuterium.coughfinished = 1;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x766544cb, Offset: 0x1bd01
// Size: 0x69
function function_ca4d65d78bad28b4()
{
    deuterium = self;
    player = deuterium.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player thread gas_grenade::gas_clearblur( 0 );
    player white_phosphorus::disableloopingcoughaudio();
    deuterium.coughstarted = 0;
    deuterium.coughfinished = 0;
    deuterium notify( #"cough_cleared" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xb4452e43, Offset: 0x1bd72
// Size: 0xc7
function function_437818d0382b297( elementid, position, angles )
{
    teaminfo = self;
    gallium = teaminfo function_861baab5997629cd( elementid, level.arrow.dvars.var_2108533c91a9051a );
    gallium.alwaystrack = 0;
    gallium.funcpickup = &function_4a07199c85093859;
    gallium.funcdrop = &function_c03517d8bd7e718;
    gallium.funccleanup = &function_1928f489dfea8bd4;
    gallium.teamaffected = teaminfo.champion.team;
    gallium function_c2569c447406d173();
    return gallium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xe28aac8b, Offset: 0x1be42
// Size: 0x80
function function_658ed1b5e399c54()
{
    gallium = self;
    gallium.trigger = gallium function_101f9115b59a311b( gallium.geigerent.origin, level.arrow.dvars.var_cffcbd78da0597e, level.arrow.dvars.var_ea16265cd84314f3 );
    gallium.outlineenabled = 1;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xcce326e7, Offset: 0x1beca
// Size: 0x115
function function_1928f489dfea8bd4()
{
    gallium = self;
    
    if ( isdefined( gallium ) && isdefined( gallium.trigger ) && isdefined( gallium.trigger.nearbyplayers ) )
    {
        foreach ( player in gallium.trigger.nearbyplayers )
        {
            if ( isplayer( player ) && player.team == gallium.teamaffected )
            {
                function_e232a1cb10a743d4( player, gallium.trigger, 1 );
            }
        }
    }
    
    gallium.outlineenabled = 0;
    gallium function_a7dd0e5f18d7b236( "snapshotgrenade" );
    gallium function_560ca4841716b4a0();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x6ee81cf4, Offset: 0x1bfe7
// Size: 0xa6
function function_4a07199c85093859( player, dontcarry )
{
    gallium = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( dontcarry )
    {
        return;
    }
    
    function_99ea1059594ec8bc( gallium.trigger, player );
    
    if ( isdefined( gallium.teamaffected ) && gallium.teamaffected != player.team )
    {
        gallium function_736eb867357deda7( gallium.teamaffected );
        gallium.teamaffected = player.team;
        gallium function_4aeb041565faa4db( player );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb5d305bb, Offset: 0x1c095
// Size: 0xf1
function function_4aeb041565faa4db( player )
{
    gallium = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( gallium.trigger.nearbyplayers ) )
    {
        return;
    }
    
    foreach ( anyplayer in gallium.trigger.nearbyplayers )
    {
        if ( isplayer( anyplayer ) && anyplayer.team == gallium.teamaffected )
        {
            function_9a1312383aac79c2( anyplayer, gallium.trigger );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x59684ad5, Offset: 0x1c18e
// Size: 0x36
function function_c03517d8bd7e718( player )
{
    gallium = self;
    function_99ea1059594ec8bc( gallium.trigger, gallium.scriptable );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x58e3f643, Offset: 0x1c1cc
// Size: 0x117
function function_736eb867357deda7( var_eb978572cac643aa )
{
    gallium = self;
    
    if ( !( isdefined( var_eb978572cac643aa ) && isdefined( gallium.trigger ) && isdefined( gallium.trigger.nearbyplayers ) ) )
    {
        return;
    }
    
    foreach ( player in gallium.trigger.nearbyplayers )
    {
        if ( isplayer( player ) && player.team == var_eb978572cac643aa )
        {
            if ( function_5769f26de0f2803( gallium, player ) )
            {
                continue;
            }
            
            gallium function_6696f1bf9888a239( player, 0, "snapshotgrenade" );
            gallium function_4c605d8530fc7aa4( player );
            player hudoutlinedisableforclients( level.players );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5a74500a, Offset: 0x1c2eb
// Size: 0x52
function function_fdb072961274a05d( player )
{
    gallium = self;
    gallium function_7257c2e88eba0345( player, "snapshotgrenade", "level_script" );
    gallium thread function_5a235f5b9a322a1b( player );
    gallium function_4ebe15c2b805d314( player, "snapshotgrenade" );
    player playloopsound( "evt_br_elite_arrow_neon_lp" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd859f861, Offset: 0x1c345
// Size: 0x8f
function function_5a235f5b9a322a1b( player )
{
    gallium = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_a0e7a5f23f51698c" );
    
    if ( player.var_9c96e5e26cfde4c4 )
    {
        return;
    }
    
    player.var_9c96e5e26cfde4c4 = 1;
    utility::waittill_any_ents_return_no_endon_death( gallium, "death", gallium, "on_drop", player, "death" );
    gallium function_4c605d8530fc7aa4( player );
    player.var_9c96e5e26cfde4c4 = 0;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xa0d6968e, Offset: 0x1c3dc
// Size: 0x53
function function_4c605d8530fc7aa4( player )
{
    gallium = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( #"hash_a0e7a5f23f51698c" );
    gallium function_569d888e1c06f55c( player );
    gallium function_4ebe15c2b805d314( player, "snapshotgrenade" );
    player stoploopsound( "evt_br_elite_arrow_neon_lp" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x639f3e31, Offset: 0x1c437
// Size: 0x67
function function_101f9115b59a311b( position, radius, height )
{
    gallium = self;
    trigger = gallium function_75b7121227878f03( position, radius, height );
    trigger.targetname = "galTrigger";
    trigger::makeenterexittrigger( trigger, &function_9a1312383aac79c2, &function_e232a1cb10a743d4 );
    return trigger;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x7e2695a9, Offset: 0x1c4a7
// Size: 0xca
function function_9a1312383aac79c2( entity, trigger, force, ignoreheld )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_76f99b7866ea803e( entity, trigger );
        thread function_393d07d9567b9e06( entity, trigger );
        return;
    }
    
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    function_302bded5d0fc2aaa( entity, trigger, force, 1 );
    gallium = trigger.element;
    
    if ( !isdefined( gallium ) )
    {
        return;
    }
    
    if ( entity.team == gallium.teamaffected && gallium.outlineenabled )
    {
        gallium function_fdb072961274a05d( entity );
        gallium function_6696f1bf9888a239( entity, 1, "snapshotgrenade" );
    }
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xe3da4c31, Offset: 0x1c579
// Size: 0xcc
function function_e232a1cb10a743d4( entity, trigger, force )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_8920f17d63587a1c( entity, trigger );
        thread function_22ba605a11e11bc4( entity, trigger );
        return;
    }
    
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    function_b5db4f3125a6431c( entity, trigger, force );
    gallium = trigger.element;
    
    if ( !isdefined( gallium ) )
    {
        return;
    }
    
    if ( entity.team == gallium.teamaffected )
    {
        if ( function_5769f26de0f2803( gallium, entity ) )
        {
            return;
        }
        
        gallium function_6696f1bf9888a239( entity, 0, "snapshotgrenade" );
        gallium function_4c605d8530fc7aa4( entity );
        entity hudoutlinedisableforclients( level.players );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x3c79e1a1, Offset: 0x1c64d
// Size: 0xb1
function function_76f99b7866ea803e( vehicle, trigger )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.occupants ) ) )
    {
        return;
    }
    
    waitframe();
    
    foreach ( occupant in vehicle.occupants )
    {
        if ( isdefined( occupant ) )
        {
            function_9a1312383aac79c2( occupant, trigger, 1 );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xba386e3e, Offset: 0x1c706
// Size: 0xb1
function function_8920f17d63587a1c( vehicle, trigger )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.occupants ) ) )
    {
        return;
    }
    
    waitframe();
    
    foreach ( occupant in vehicle.occupants )
    {
        if ( isdefined( occupant ) )
        {
            function_e232a1cb10a743d4( occupant, trigger, 1 );
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xb5894663, Offset: 0x1c7bf
// Size: 0x12a, Type: bool
function function_5769f26de0f2803( var_2254810936b9337c, player )
{
    if ( !isdefined( var_2254810936b9337c ) )
    {
        return false;
    }
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    galliumarray = function_98f8fb1c5418a605( "gal" );
    
    foreach ( element in galliumarray )
    {
        if ( element == var_2254810936b9337c )
        {
            continue;
        }
        
        if ( !( isdefined( element.trigger ) && isdefined( element.trigger.nearbyplayers ) && isdefined( element.teamaffected ) ) )
        {
            continue;
        }
        
        if ( element.teamaffected == player.team && arraycontains( element.trigger.nearbyplayers, player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xe68ce5b9, Offset: 0x1c8f2
// Size: 0xa6
function function_40143f775983017a( elementid, position, angles )
{
    teaminfo = self;
    neptunium = teaminfo function_861baab5997629cd( elementid, level.arrow.dvars.var_2108533c91a9051a );
    neptunium.alwaystrack = 0;
    neptunium.funcpickup = &function_cf43c4110f19b31e;
    neptunium.funcdrop = &function_e901b85fb9b054df;
    neptunium.funccleanup = &function_97d60ce135bd1ac9;
    neptunium function_9e229a3c550e0df2();
    return neptunium;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x7e8f7bab, Offset: 0x1c9a1
// Size: 0x111
function function_97d60ce135bd1ac9()
{
    neptunium = self;
    neptunium notify( #"neptunium_cleanup" );
    
    if ( isdefined( neptunium.player ) )
    {
        function_38e9fc8589c90321( neptunium.player, neptunium.trigger, 1 );
    }
    
    if ( isdefined( neptunium.trigger ) && isdefined( neptunium.trigger.nearbyplayers ) )
    {
        foreach ( nearbyplayer in neptunium.trigger.nearbyplayers )
        {
            if ( isdefined( nearbyplayer ) )
            {
                function_38e9fc8589c90321( nearbyplayer, neptunium.trigger, 1 );
            }
        }
    }
    
    neptunium function_560ca4841716b4a0();
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xdd0e3f05, Offset: 0x1caba
// Size: 0x68
function function_43e04c396234e215()
{
    neptunium = self;
    neptunium.containeropened = 1;
    neptunium function_b272588b0a956f5d();
    wait level.arrow.dvars.var_deaf70b0be3bc149;
    neptunium notify( #"hash_a14bc9e97877e0e4" );
    neptunium.damageenabled = 1;
    neptunium thread function_43a05701105428e();
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x664939fa, Offset: 0x1cb2a
// Size: 0x13b
function function_cf43c4110f19b31e( player, dontcarry )
{
    neptunium = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( neptunium.firstpickup )
    {
        neptunium.damageenabled = 1;
    }
    
    if ( dontcarry )
    {
        return;
    }
    
    if ( !isdefined( neptunium.trigger ) )
    {
        return;
    }
    
    function_99ea1059594ec8bc( neptunium.trigger, player );
    function_3133ba09c02c9ce1( player, neptunium.trigger, undefined, 1 );
    
    if ( isdefined( neptunium.trigger.nearbyplayers ) )
    {
        foreach ( nearbyplayer in neptunium.trigger.nearbyplayers )
        {
            if ( isdefined( nearbyplayer ) )
            {
                function_3133ba09c02c9ce1( nearbyplayer, neptunium.trigger, undefined, 1 );
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb7c844c4, Offset: 0x1cc6d
// Size: 0x1ae
function function_e901b85fb9b054df( player )
{
    neptunium = self;
    
    if ( !isdefined( neptunium.trigger ) )
    {
        return;
    }
    
    function_99ea1059594ec8bc( neptunium.trigger, neptunium.scriptable );
    function_3133ba09c02c9ce1( player, neptunium.trigger, undefined, 1 );
    
    foreach ( teamelements in level.arrow.props.elements )
    {
        if ( !isdefined( teamelements[ neptunium.elementid ] ) )
        {
            continue;
        }
        
        trigger = teamelements[ neptunium.elementid ].trigger;
        
        if ( isdefined( trigger ) && isdefined( trigger.nearbyplayers ) )
        {
            foreach ( nearbyplayer in trigger.nearbyplayers )
            {
                if ( isdefined( nearbyplayer ) )
                {
                    function_3133ba09c02c9ce1( nearbyplayer, trigger, undefined, 1 );
                }
            }
        }
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xfc6351ac, Offset: 0x1ce23
// Size: 0x72
function function_b272588b0a956f5d()
{
    neptunium = self;
    neptunium.trigger = neptunium function_897a26998db9bdc( neptunium.geigerent.origin, level.arrow.dvars.var_e1796d225c2725ca, level.arrow.dvars.var_e23fd56098147d87 );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x6c28b4ba, Offset: 0x1ce9d
// Size: 0xb9
function function_43a05701105428e()
{
    neptunium = self;
    level endon( #"game_ended" );
    neptunium endon( #"element_cleanup" );
    neptunium.var_14b8487dcb2bd30f = level.arrow.dvars.var_bda484f453a433a6 - level.arrow.dvars.var_227e2eb87503c78;
    neptunium.var_285a44d8f09c5bdf = 0;
    
    while ( true )
    {
        if ( neptunium.damageenabled )
        {
            neptunium function_2dafa3e2cdc8e4cd();
        }
        
        wait level.arrow.dvars.var_c60f669e1f184cbf;
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x5669ca76, Offset: 0x1cf5e
// Size: 0x116
function function_2dafa3e2cdc8e4cd()
{
    neptunium = self;
    
    if ( !isdefined( neptunium.var_e292c77dc5835420 ) )
    {
        neptunium.var_e292c77dc5835420 = 0;
    }
    
    neptunium.var_e292c77dc5835420 += level.arrow.dvars.var_c60f669e1f184cbf;
    
    if ( neptunium.var_e292c77dc5835420 < neptunium.var_14b8487dcb2bd30f )
    {
        return;
    }
    
    if ( isdefined( neptunium.var_285a44d8f09c5bdf ) && !neptunium.var_285a44d8f09c5bdf )
    {
        entity = neptunium function_1bc78c7457e6ff7d();
        
        if ( !isdefined( entity ) )
        {
            entity = neptunium.geigerent;
        }
        
        if ( isdefined( entity ) )
        {
            entity playsoundonmovingent( "evt_br_elite_arrow_neptunium_preload" );
        }
        
        neptunium.var_285a44d8f09c5bdf = 1;
    }
    
    if ( neptunium.var_e292c77dc5835420 >= level.arrow.dvars.var_bda484f453a433a6 )
    {
        neptunium function_f7d6aea04fa2adb9();
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x4be4ef34, Offset: 0x1d07c
// Size: 0x92
function function_f7d6aea04fa2adb9()
{
    neptunium = self;
    
    if ( !isdefined( neptunium.trigger.nearbyplayers ) || neptunium.trigger.nearbyplayers.size == 0 )
    {
        neptunium.var_e292c77dc5835420 = 0;
        neptunium.var_285a44d8f09c5bdf = 0;
        return;
    }
    else
    {
        neptunium notify( #"hash_a14bc9e97877e0e4" );
    }
    
    neptunium.var_e292c77dc5835420 = 0;
    neptunium.var_285a44d8f09c5bdf = 0;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5881235b, Offset: 0x1d116
// Size: 0x140
function function_e1bbba123ee7d56c( playershocked )
{
    neptunium = self;
    
    if ( !isplayer( playershocked ) )
    {
        return;
    }
    
    if ( !playershocked istouching( neptunium.trigger ) && !isdefined( playershocked.vehicle ) )
    {
        function_38e9fc8589c90321( playershocked, neptunium.trigger );
        return;
    }
    
    if ( isdefined( playershocked ) && function_c38819bc98658c08( playershocked, neptunium.elementid ) )
    {
        teammates = function_5713d46873b29625( teams::getteamdata( playershocked.team, "players" ) );
        
        if ( !arraycontains( teammates, playershocked ) )
        {
            return;
        }
    }
    
    if ( isdefined( neptunium.scriptable ) )
    {
        neptunium.scriptable function_4751c49e2dd970b5( "active" );
    }
    
    neptunium function_9848ca457ac000b7( playershocked );
    isplayerdriver = isdefined( playershocked.vehicle ) && vehicle_occupancy::function_3080323254ba6900( playershocked );
    
    if ( isplayerdriver )
    {
        neptunium function_c36f18d322874f30( playershocked );
    }
    else
    {
        neptunium function_cb3a3803b489ba07( playershocked );
    }
    
    if ( isdefined( neptunium.scriptable ) )
    {
        neptunium.scriptable function_4751c49e2dd970b5( "visible" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x72ef431a, Offset: 0x1d25e
// Size: 0x8c
function function_9848ca457ac000b7( player )
{
    if ( level.arrow.dvars.var_9c16cd85f1cd9ab4 <= 0 )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    damage = level.arrow.dvars.var_9c16cd85f1cd9ab4;
    player dodamage( damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", level.defaultfist, "torso_upper" );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0x8e8f5538, Offset: 0x1d2f2
// Size: 0x67
function function_897a26998db9bdc( position, radius, height )
{
    neptunium = self;
    trigger = neptunium function_75b7121227878f03( position, radius, height );
    trigger.targetname = "nepTrigger";
    trigger::makeenterexittrigger( trigger, &function_3133ba09c02c9ce1, &function_38e9fc8589c90321 );
    return trigger;
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x73cacecc, Offset: 0x1d362
// Size: 0x9a
function function_3133ba09c02c9ce1( entity, trigger, force, ignoreheld )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_b24948f1b33cb636( entity, trigger );
        thread function_393d07d9567b9e06( entity, trigger );
        return;
    }
    
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    function_302bded5d0fc2aaa( entity, trigger, force, 1 );
    neptunium = trigger.element;
    
    if ( !isdefined( neptunium ) )
    {
        return;
    }
    
    neptunium thread function_843fb6b20f95d91( entity );
    neptunium thread function_75beab95acafbcc7( entity );
}

// Namespace br_elite_broken_arrow
// Params 3
// Checksum 0xa4211063, Offset: 0x1d404
// Size: 0xd3
function function_38e9fc8589c90321( entity, trigger, force )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( entity vehicle::is_vehicle() )
    {
        thread function_22ba605a11e11bc4( entity, trigger );
        thread function_777e110d6f482c21( entity, trigger );
        entity notify( #"neptunium_trigger_exit" );
        return;
    }
    
    if ( !isplayer( entity ) )
    {
        return;
    }
    
    function_b5db4f3125a6431c( entity, trigger, force );
    neptunium = trigger.element;
    
    if ( !isdefined( neptunium ) )
    {
        return;
    }
    
    if ( function_d5bb7a070ad0de51( neptunium, entity ) )
    {
        return;
    }
    
    if ( entity.var_509a41f0685c8de4 )
    {
        neptunium function_7eb0980de8d335df( entity );
    }
    
    entity.var_56f698f15c5c7b75 = 0;
    entity notify( #"neptunium_trigger_exit" );
    entity stoploopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe987f336, Offset: 0x1d4df
// Size: 0xc0
function function_777e110d6f482c21( vehicle, trigger )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    waitframe();
    
    if ( isdefined( vehicle.occupants ) )
    {
        foreach ( occupant in vehicle.occupants )
        {
            function_38e9fc8589c90321( occupant, trigger, 1 );
        }
    }
    
    vehicle function_8bf24c4d35e7ad26();
    vehicle stoploopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x1dbfddf7, Offset: 0x1d5a7
// Size: 0x87
function function_75beab95acafbcc7( playerinradius )
{
    neptunium = self;
    level endon( #"game_ended" );
    neptunium endon( #"element_cleanup" );
    
    if ( !isplayer( playerinradius ) )
    {
        return;
    }
    
    if ( playerinradius.var_56f698f15c5c7b75 )
    {
        return;
    }
    
    playerinradius.var_56f698f15c5c7b75 = 1;
    playerinradius endon( #"neptunium_trigger_exit" );
    
    while ( true )
    {
        neptunium waittill( #"hash_a14bc9e97877e0e4" );
        neptunium function_e1bbba123ee7d56c( playerinradius );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xa43cbc8f, Offset: 0x1d636
// Size: 0xb4
function function_b24948f1b33cb636( vehicle, trigger )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    waitframe();
    
    if ( isdefined( vehicle.occupants ) )
    {
        foreach ( occupant in vehicle.occupants )
        {
            function_3133ba09c02c9ce1( occupant, trigger, 1 );
        }
    }
    
    vehicle function_6c5874a08c8c214e();
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xd67c6758, Offset: 0x1d6f2
// Size: 0x74
function function_843fb6b20f95d91( playerinradius )
{
    if ( !isplayer( playerinradius ) )
    {
        return;
    }
    
    if ( playerinradius.var_3dcdc181b764fcaf )
    {
        return;
    }
    
    function_992004613de40179( playerinradius, 1 );
    playerinradius.var_3dcdc181b764fcaf = 1;
    playerinradius waittill( #"neptunium_trigger_exit" );
    
    if ( !playerinradius.var_3dcdc181b764fcaf )
    {
        return;
    }
    
    function_992004613de40179( playerinradius, 0 );
    playerinradius.var_3dcdc181b764fcaf = 0;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xf217ca3a, Offset: 0x1d76e
// Size: 0x78
function function_992004613de40179( player, state )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( state && !player.var_509a41f0685c8de4 )
    {
        player setscriptablepartstate( "shockStickVfx", "vfx_start", 1 );
        player.var_509a41f0685c8de4 = 1;
        return;
    }
    
    player setscriptablepartstate( "shockStickVfx", "off", 0 );
    player.var_509a41f0685c8de4 = 0;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x96df1e0b, Offset: 0x1d7ee
// Size: 0xaf
function function_9e229a3c550e0df2()
{
    neptunium = self;
    neptunium.bundle = spawnstruct();
    neptunium.bundle.var_9342451ed3d7db03 = 0.8;
    neptunium.bundle.var_f3447a3874df563f = undefined;
    neptunium.bundle.var_bd94b71ffdfd39c = 1;
    neptunium.bundle.var_b110dbf60f7e2c47 = undefined;
    neptunium.bundle.var_4c6cc0f99efbb64f = 1;
    neptunium.bundle.var_e92504c2b2f419a8 = &arrow_nepshockeffecttoggle;
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0xf4c91b3c, Offset: 0x1d8a5
// Size: 0x2
function arrow_nepshockeffecttoggle()
{
    
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x3e79a73, Offset: 0x1d8b0
// Size: 0x9b
function function_c36f18d322874f30( player )
{
    if ( !( isdefined( player ) && isdefined( player.vehicle ) ) )
    {
        return;
    }
    
    vehicle = player.vehicle;
    
    if ( !player.ishaywire )
    {
        vehicle playsound( "evt_br_elite_arrow_neptunium_shock_in" );
        vehicle playloopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
        player utility::waittill_any_timeout( 1, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_enter" );
        vehicle stoploopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
        vehicle playsound( "evt_br_elite_arrow_neptunium_shock_out" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0xb21b90b8, Offset: 0x1d953
// Size: 0xdc
function function_cb3a3803b489ba07( player )
{
    neptunium = self;
    
    if ( !isplayer( player ) || isdefined( player.vehicle ) && vehicle_occupancy::function_3080323254ba6900( player ) )
    {
        return;
    }
    
    if ( !player.ishaywire )
    {
        shockdata = spawnstruct();
        shockdata.victim = player;
        neptunium shock_stick::function_5f89a63c19349cd5( shockdata, neptunium.bundle );
        player playsound( "evt_br_elite_arrow_neptunium_shock_in" );
        player playloopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
        player utility::waittill_any_timeout( 1, "haywire_cleared", "shockstick_interrupt", "killed_player", "last_stand_enter" );
        neptunium function_7eb0980de8d335df( player );
        player stoploopsound( "evt_br_elite_arrow_neptunium_shock_lp" );
        player playsound( "evt_br_elite_arrow_neptunium_shock_out" );
    }
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x21472f4b, Offset: 0x1da37
// Size: 0x8e
function function_7eb0980de8d335df( player )
{
    neptunium = self;
    
    if ( !isplayer( player ) || isdefined( player.vehicle ) && vehicle_occupancy::function_3080323254ba6900( player ) )
    {
        return;
    }
    
    if ( player.ishaywire )
    {
        player.ishaywire = undefined;
        fromdeath = !player::isreallyalive( player );
        player shock_stick::function_a509214050ca03a5( fromdeath, neptunium.bundle );
        player notify( #"haywire_cleared" );
    }
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x98a297cc, Offset: 0x1dacd
// Size: 0x13b
function function_6c5874a08c8c214e()
{
    vehicle = self;
    
    if ( !isdefined( vehicle ) || vehicle.ishaywire )
    {
        return;
    }
    
    if ( vehicle.var_81ac52e14bcb4f1c )
    {
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
        
        if ( occupants.size > 0 )
        {
            vehicle_omnvar::show_warning( "shockStickAttached", occupants, vehicle vehicle::get_ref() );
        }
        
        return;
    }
    
    vehicle.var_81ac52e14bcb4f1c = 1;
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    vehicle_omnvar::show_warning( "shockStickAttached", occupants, vehicle vehicle::get_ref() );
    
    if ( vehicle vehicle::ishelicopter() )
    {
        vehicle_occupancy::disable_engine();
        vehicle_occupancy::function_961dfeea38feb976();
        vehicle_occupancy::allow_movement( vehicle, 0, 0 );
    }
    else
    {
        vehicle.var_52dfac12181e4ef9 = vehicle vehicle_gettopspeedforward();
        vehicle.var_80f99dc346cf1422 = vehicle vehicle_gettopspeedreverse();
        vehicle vehicle_settopspeedforward( level.arrow.dvars.var_e53c672822a290c9 );
        vehicle vehicle_settopspeedreverse( level.arrow.dvars.var_e53c672822a290c9 );
    }
    
    vehicle utility::function_7c10ea82c1e305b8( "haywire", "on" );
}

// Namespace br_elite_broken_arrow
// Params 0
// Checksum 0x64679971, Offset: 0x1dc10
// Size: 0xe6
function function_8bf24c4d35e7ad26()
{
    vehicle = self;
    
    if ( !isdefined( vehicle ) || vehicle.ishaywire )
    {
        return;
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    vehicle_omnvar::hide_warning( "shockStickAttached", occupants, vehicle vehicle::get_ref() );
    
    if ( vehicle vehicle::ishelicopter() )
    {
        if ( vehicle vehicle_occupancy::is_engine_disabled() )
        {
            vehicle vehicle_occupancy::enable_engine();
            vehicle_occupancy::function_474d87fe62493d22();
            vehicle_occupancy::allow_movement( vehicle, 1, 0 );
        }
    }
    else
    {
        if ( isdefined( vehicle.var_52dfac12181e4ef9 ) )
        {
            vehicle vehicle_settopspeedforward( vehicle.var_52dfac12181e4ef9 );
        }
        
        if ( isdefined( vehicle.var_80f99dc346cf1422 ) )
        {
            vehicle vehicle_settopspeedreverse( vehicle.var_80f99dc346cf1422 );
        }
    }
    
    vehicle utility::function_7c10ea82c1e305b8( "haywire", "off" );
    vehicle.var_81ac52e14bcb4f1c = 0;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x8544fb79, Offset: 0x1dcfe
// Size: 0x100, Type: bool
function function_d5bb7a070ad0de51( var_401bcf2b6b232666, player )
{
    if ( !isdefined( var_401bcf2b6b232666 ) )
    {
        return false;
    }
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    neptuniumarray = function_98f8fb1c5418a605( "nep" );
    
    foreach ( element in neptuniumarray )
    {
        if ( element == var_401bcf2b6b232666 )
        {
            continue;
        }
        
        if ( !( isdefined( element.trigger ) && isdefined( element.trigger.nearbyplayers ) ) )
        {
            continue;
        }
        
        if ( arraycontains( element.trigger.nearbyplayers, player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0xe2980224, Offset: 0x1de07
// Size: 0x4c
function function_957e2129483a9d92( dropinfo, player )
{
    if ( dropinfo.origin == ( 0, 0, 0 ) )
    {
        dropinfo.origin = getclosestpointonnavmesh( player.origin );
    }
}

// Namespace br_elite_broken_arrow
// Params 2
// Checksum 0x5e493fc9, Offset: 0x1de5b
// Size: 0x4c
function function_643954a035d06e38( spawnoptions, player )
{
    if ( spawnoptions.baseorigin == ( 0, 0, 0 ) )
    {
        spawnoptions.baseorigin = getclosestpointonnavmesh( player.origin );
    }
}

// Namespace br_elite_broken_arrow
// Params 4
// Checksum 0x6d535e38, Offset: 0x1deaf
// Size: 0x12f
function function_e747a7a8161f31a9( team, rewardorigin, rewardangles, scriptablename )
{
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( rewardorigin, rewardangles );
    spawnedelement = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, 1, spawnoptions );
    teaminfo = level.arrow.teaminfo[ team ];
    elementid = function_a246dc01c1d8e60e( scriptablename, 0 );
    elementref = teaminfo function_8950525a5e4faf97( elementid, rewardorigin, rewardangles );
    level.arrow.props.elements[ team ][ elementid ] = elementref;
    spawnedelement.elementref = elementref;
    
    if ( isdefined( spawnedelement ) )
    {
        spawnedelement.criticalitem = 1;
        spawnedelement.elementref = elementref;
        elementref.scriptable = spawnedelement;
    }
    
    elementref function_aabbbc78ff2214bc( 1 );
    elementref function_d5dbd2a497d735fb( undefined, spawnedelement );
    spawnedelement function_64367b7a627b5a40( 1 );
    spawnedelement function_4751c49e2dd970b5( "dropped" );
    return spawnedelement;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x5930a61, Offset: 0x1dfe7
// Size: 0x9b
function function_f6ff0d8613c64445( team )
{
    questchain = level.var_7f7712f1dc8a87b4.teaminstances[ team ];
    rewardindex = questchain.index;
    assert( rewardindex >= 0 && rewardindex < level.arrow.elementorder.size, "<dev string:x310>" );
    elementid = function_a246dc01c1d8e60e( rewardindex, 6 );
    element = function_ca621b047cf24253( elementid, 0 );
    return element;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x80dc4b12, Offset: 0x1e08b
// Size: 0xe
function function_7a10d0b1b0720af0( splash )
{
    return splash;
}

// Namespace br_elite_broken_arrow
// Params 1
// Checksum 0x900d35a3, Offset: 0x1e0a2
// Size: 0x20, Type: bool
function function_a24e8e6e0c75e020( ref )
{
    return ref == "elite_arrow" || ref == "elite_arrow_resurgence";
}

/#

    // Namespace br_elite_broken_arrow
    // Params 2
    // Checksum 0x15a3ba19, Offset: 0x1e0cb
    // Size: 0x1f2, Type: dev
    function arrow_debug( debugstate, containertype )
    {
        level endon( #"game_ended" );
        flags::gameflagwait( "<dev string:x33f>" );
        
        if ( debugstate < 1 || debugstate > 8 )
        {
            return;
        }
        
        level.arrow.debugstate = debugstate;
        hostplayer = gamelogic_mp::gethostplayer();
        function_dcf9a95a7c0cfd01();
        function_7df3334d3a5aa7fb();
        
        if ( function_edb32a1dfc6c70f3() )
        {
            if ( debugstate == 7 )
            {
                level.arrow.props.bombsite arrow_bombsitereveal( hostplayer );
                return;
            }
            else
            {
                hostplayer arrow_debugend();
                
                if ( debugstate == 1 )
                {
                    return;
                }
            }
        }
        
        if ( debugstate == 8 )
        {
            level.arrow.props.elements[ hostplayer.team ] = [];
            elementid = function_36d7379c1630ad74( containertype, hostplayer );
        }
        
        tablet = br_contract_manager::function_afc15d4bdb062dff( level.arrow.contractref, hostplayer.origin, hostplayer.angles );
        hostplayer br_contract_manager::function_9490728b1fe4323( tablet );
        
        switch ( debugstate )
        {
            case 3:
            case 7:
                level.arrow.props.bombsite function_4fc30bcc17a0efa7( 1, hostplayer );
                break;
            case 4:
                function_fc09f12a6e10462a( hostplayer );
                break;
            case 5:
                function_aac1ea8777fb30f4( hostplayer );
                break;
            case 6:
                function_a4efd7f1d3fd545( hostplayer );
                break;
            default:
                break;
        }
    }

    // Namespace br_elite_broken_arrow
    // Params 1
    // Checksum 0x60a07179, Offset: 0x1e2c5
    // Size: 0xab, Type: dev
    function function_fc09f12a6e10462a( hostplayer )
    {
        level.arrow.props.bombsite function_4fc30bcc17a0efa7( 0, hostplayer );
        level.arrow.props.bombsite arrow_bombsitereveal( hostplayer );
        level.arrow.props.bombsite function_4b822bf658740892( "<dev string:x34d>" );
        level.arrow.props.bombsite arrow_bombsitearm( hostplayer );
    }

    // Namespace br_elite_broken_arrow
    // Params 1
    // Checksum 0x527c8b94, Offset: 0x1e378
    // Size: 0xd5, Type: dev
    function function_aac1ea8777fb30f4( hostplayer )
    {
        level.arrow.dvars.bombsitesupplydrop = 0;
        level.arrow.props.bombsite function_4fc30bcc17a0efa7( 0, hostplayer );
        level.arrow.props.bombsite arrow_bombsitereveal( hostplayer );
        level.arrow.props.bombsite thread function_40875ae3450b5aad( hostplayer );
        level.arrow.props.bombsite.fuseent.lastuser = hostplayer;
    }

    // Namespace br_elite_broken_arrow
    // Params 1
    // Checksum 0x746c7c35, Offset: 0x1e455
    // Size: 0xd3, Type: dev
    function function_a4efd7f1d3fd545( hostplayer )
    {
        level.arrow.dvars.bombsitesupplydrop = 0;
        level.arrow.props.bombsite function_4fc30bcc17a0efa7( 0, hostplayer );
        level.arrow.props.bombsite arrow_bombsitereveal( hostplayer );
        level.arrow.props.bombsite function_14db70e5111b5554();
        level.arrow.props.bombsite.fuseent.lastuser = hostplayer;
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0x5909ec88, Offset: 0x1e530
    // Size: 0x87, Type: dev
    function arrow_debugend()
    {
        function_9ecd3b1e0a8844b5( "<dev string:x351>" );
        self iprintlnbold( "<dev string:x357>" );
        
        if ( level.arrow.debugstate == 1 )
        {
            function_5621852a8ed84e2a();
        }
        
        if ( isdefined( level.arrow.props.bombsite ) )
        {
            level.arrow.props.bombsite = undefined;
        }
        
        function_e5368bef9c22c1ae();
        wait 3;
    }

    // Namespace br_elite_broken_arrow
    // Params 2
    // Checksum 0xbae7037d, Offset: 0x1e5bf
    // Size: 0x12f, Type: dev
    function function_36d7379c1630ad74( containertype, hostplayer )
    {
        if ( !( isdefined( level.arrow.elementsall ) && isdefined( level.arrow.elementlist ) ) )
        {
            return;
        }
        
        elementid = undefined;
        
        switch ( containertype )
        {
            case 1:
                elementid = "<dev string:x369>";
                break;
            case 2:
                elementid = "<dev string:x36d>";
                break;
            case 3:
                elementid = "<dev string:x371>";
                break;
            case 4:
                elementid = "<dev string:x375>";
                break;
            case 5:
                elementid = "<dev string:x379>";
                break;
            default:
                elementid = "<dev string:x37d>";
                break;
        }
        
        if ( isdefined( elementid ) )
        {
            level.arrow.elementlist = [];
            level.arrow.elementlist[ elementid ] = level.arrow.elementsall[ elementid ];
            return elementid;
        }
        
        return;
    }

    // Namespace br_elite_broken_arrow
    // Params 2
    // Checksum 0xa24592fe, Offset: 0x1e6f6
    // Size: 0x116, Type: dev
    function function_4fc30bcc17a0efa7( spawnelements, host )
    {
        containers = level.arrow.props.containers[ host.team ];
        
        if ( !isdefined( containers ) )
        {
            return;
        }
        
        foreach ( container in containers )
        {
            container function_798f9315ddb3ee96( "<dev string:x381>" );
            container function_64367b7a627b5a40( 1 );
            
            if ( spawnelements )
            {
                teaminfo = level.arrow.teaminfo[ host.team ];
                
                if ( !isdefined( teaminfo ) )
                {
                    return;
                }
                
                teaminfo function_e9a2b2313dba8f73( container, host );
            }
        }
    }

    // Namespace br_elite_broken_arrow
    // Params 2
    // Checksum 0x7795aeb7, Offset: 0x1e814
    // Size: 0x19a, Type: dev
    function function_e9a2b2313dba8f73( container, host )
    {
        teaminfo = self;
        originoffset = anglestoleft( container.angles ) * 25;
        elementid = function_a246dc01c1d8e60e( container.type, 7 );
        elemname = function_ca621b047cf24253( elementid, 0 );
        scriptable = function_c1a2d3435e4a89a0( elemname, container.origin + originoffset, container.angles );
        scriptable function_4751c49e2dd970b5( "<dev string:x390>" );
        scriptable.element = level.arrow.props.elements[ host.team ][ elementid ];
        container.elementref = level.arrow.props.elements[ host.team ][ elementid ];
        level.arrow.props.elements[ host.team ][ elementid ].scriptable = scriptable;
        scriptable.element function_aabbbc78ff2214bc( 1 );
        scriptable.element function_6248728510695d6c( host, 1 );
        scriptable.element function_d5dbd2a497d735fb( host, scriptable );
        teaminfo function_e7460b727a2abab();
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xf825174d, Offset: 0x1e9b6
    // Size: 0x152, Type: dev
    function function_c2655c68f4ad6efe()
    {
        level endon( #"game_ended" );
        flags::gameflagwait( "<dev string:x33f>" );
        var_36449a011c237614 = 1;
        var_2ba96637365676a5 = 2;
        visionset_nuke_flash = 3;
        visionset_nuke_death = 4;
        
        while ( true )
        {
            debugstate = getdvarint( @"hash_30a13e2a76f18834", 0 );
            
            if ( debugstate < var_36449a011c237614 || debugstate > visionset_nuke_death )
            {
                waitframe();
                continue;
            }
            
            setdvar( @"hash_30a13e2a76f18834", 0 );
            hostplayer = gamelogic_mp::gethostplayer();
            
            if ( debugstate == var_2ba96637365676a5 )
            {
                vision = "<dev string:x398>";
                hostplayer iprintlnbold( "<dev string:x398>" );
            }
            else if ( debugstate == visionset_nuke_flash )
            {
                vision = "<dev string:x3b4>";
                hostplayer iprintlnbold( "<dev string:x3b4>" );
            }
            else if ( debugstate == visionset_nuke_death )
            {
                vision = "<dev string:x3cb>";
                hostplayer iprintlnbold( "<dev string:x3cb>" );
            }
            else
            {
                vision = "<dev string:x3e2>";
                hostplayer iprintlnbold( "<dev string:x3e2>" );
            }
            
            hostplayer function_69cfb089afe68d45( 1, vision, 0.5 );
            wait 3;
            hostplayer function_69cfb089afe68d45( 1, "<dev string:x3fc>", 0 );
            wait 1;
            hostplayer function_69cfb089afe68d45( 0, vision );
        }
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xf38d17c9, Offset: 0x1eb10
    // Size: 0x44, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3fd>" );
        devgui::add_devgui_func( "<dev string:x428>", "<dev string:x444>", &function_a2b325bc91a0d8fc );
        devgui::add_devgui_func( "<dev string:x460>", "<dev string:x46e>", &force_timeout );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xd8c3c596, Offset: 0x1eb5c
    // Size: 0x181, Type: dev
    function function_a2b325bc91a0d8fc()
    {
        maxdistance = getdvarint( @"hash_4706fbbe163df937", 5000 );
        maxdistancesquare = maxdistance * maxdistance;
        
        foreach ( index, bombsite in level.arrow.bombsitelocations )
        {
            foundone = 0;
            
            foreach ( index2, compare in level.arrow.bombsitelocations )
            {
                if ( index == index2 )
                {
                    continue;
                }
                
                if ( distance2dsquared( bombsite, compare ) < maxdistancesquare )
                {
                    foundone = 1;
                    line( bombsite, compare, ( 0, 1, 0 ), 1, 1, 1000 );
                }
            }
            
            if ( !foundone )
            {
                sphere( bombsite, maxdistance, ( 1, 0, 0 ), 1, 1000 );
            }
        }
    }

    // Namespace br_elite_broken_arrow
    // Params 0
    // Checksum 0xd2ec6bc1, Offset: 0x1ece5
    // Size: 0xad, Type: dev
    function force_timeout()
    {
        foreach ( teaminfo in level.arrow.teaminfo )
        {
            if ( teaminfo.state == 6 || teaminfo.state == 0 )
            {
                continue;
            }
            
            teaminfo arrow_ontimeout();
        }
    }

#/
