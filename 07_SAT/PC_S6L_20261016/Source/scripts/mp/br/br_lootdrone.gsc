// scripts\mp\br\br_lootdrone.gsc  (hash_47b0b1dbc6e30b86.gscc) (size: 55696 Bytes / 0xd990 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d9aedb2 (1570434482)
// size ...... 55696 (0xd990)
// includes .. 26  (offset: 0xd41c)
// strings ... 36  (offset: 0xd4ec)
// dev strs .. 56  (offset: 0xd6cc)
// exports ... 126 (offset: 0x9f3c)
// cseg ...... 0x37d + 0x9bbf (0x9f3c)
// imports ... 258 (offset: 0xb2ec)
// animtree1 . 0   (offset: 0xd990)
// animtree2 . 0   (offset: 0xd990)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace br_lootdrone;

// Namespace br_lootdrone
// Params 0, eflags: 0x5
// Checksum 0x5757c01d, Offset: 0x39b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"br_lootdrone", #"airdrop_scriptbundle", undefined, &post_main );
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x9f2ce046, Offset: 0x3c4
// Size: 0xee
function private post_main()
{
    if ( !getdvarint( @"hash_d19e58197d298c7a", 0 ) )
    {
        return;
    }
    
    matchchance = getdvarfloat( @"hash_35b62ef1ab3a1ceb", 1 );
    
    if ( randomfloat( 1 ) > matchchance )
    {
        logstring( "[LOOTDRONE] Loot drones chance not met. Skipping initialization." );
        return;
    }
    
    utility::flag_wait( "init_global_scriptbundles" );
    level.br_lootdrone = game_utility_mp::function_4b7180ed8c2e9742( "lootdroneconfig" );
    
    if ( !isdefined( level.br_lootdrone ) )
    {
        level.br_lootdrone = game_utility_mp::function_cb7ed8e67866f9d0( "lootdroneconfig" );
    }
    
    if ( !level.br_lootdrone )
    {
        return;
    }
    
    initlevel();
    level thread function_4aed1b1d15dbe231();
    level thread convertcaches();
    level thread function_731df381cfd669f9();
    level thread function_227f2bbab85cbeb3();
    level thread function_7d58620b260f7beb();
    level thread function_54195966887d048f();
    level callback::add( "brGametypeInit", &initfeatures );
    
    /#
        debug_init();
    #/
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x8653db1b, Offset: 0x4ba
// Size: 0xbb4
function private initlevel()
{
    level.br_lootdrone.var_8b7ac7e1495fbe5d = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    level.br_lootdrone.var_635b8fe50c2dca88 = utility::function_48f723fdc612ec65( @"hash_daf9e43d16d8582e", 0, level.br_lootdrone.var_635b8fe50c2dca88 );
    level.br_lootdrone.var_e876b64823b1a173 = utility::function_48f723fdc612ec65( @"hash_4591ceae48308be4", 0, level.br_lootdrone.var_e876b64823b1a173 );
    level.br_lootdrone.var_4fdb5d4e04369f12 = utility::function_edc4cc03e9e60b3e( @"hash_7580ce2769e6f733", 0, level.br_lootdrone.var_4fdb5d4e04369f12 );
    level.br_lootdrone.var_fddd47311bb3f564 = utility::function_edc4cc03e9e60b3e( @"hash_d045004d875227b7", 0, level.br_lootdrone.var_fddd47311bb3f564 );
    level.br_lootdrone.var_a06e5acbe3e22e4f = utility::function_edc4cc03e9e60b3e( @"hash_bb0a2cf199a1742b", 0, level.br_lootdrone.var_a06e5acbe3e22e4f );
    level.br_lootdrone.var_621b890d4a646c41.mindropheight = utility::function_48f723fdc612ec65( @"scr_br_lootdrone_min_drop_height", 0, level.br_lootdrone.var_621b890d4a646c41.mindropheight );
    level.br_lootdrone.var_621b890d4a646c41.maxdropheight = utility::function_48f723fdc612ec65( @"scr_br_lootdrone_max_drop_height", 0, level.br_lootdrone.var_621b890d4a646c41.maxdropheight );
    level.br_lootdrone.var_4079be14911ebeeb = utility::function_48f723fdc612ec65( @"hash_f7e58427b3aba08d", 0, level.br_lootdrone.var_4079be14911ebeeb );
    level.br_lootdrone.var_388052d3e139ed54 = utility::function_48f723fdc612ec65( @"hash_d11e04279ef4cce1", 0, level.br_lootdrone.var_388052d3e139ed54 );
    level.br_lootdrone.var_b24896085d43cca4 = utility::function_edc4cc03e9e60b3e( @"hash_3f3241b62209386b", 0, level.br_lootdrone.var_b24896085d43cca4 );
    level.br_lootdrone.var_4e91e5f74d569143 = utility::function_48f723fdc612ec65( @"hash_c9b0d84a4534aab8", 0, level.br_lootdrone.var_4e91e5f74d569143 );
    level.br_lootdrone.var_1a0b2eaf0ac587f9 = level.br_lootdrone.var_635b8fe50c2dca88 * level.br_lootdrone.var_635b8fe50c2dca88;
    function_fbbeeccfc4a0a7c4();
    level.br_lootdrone.var_a61eb77b5109dd26 = getdvarfloat( @"hash_b5e5818325a11f31", 1 );
    level.br_lootdrone.var_41b003a6d25074cb = [];
    
    foreach ( poiname in strtok( getdvar( @"hash_532f4b881526c256", "" ), "," ) )
    {
        level.br_lootdrone.var_41b003a6d25074cb[ poiname ] = 1;
    }
    
    level.br_lootdrone.var_b6a8e1c58b20979b = utility::function_edc4cc03e9e60b3e( @"hash_324a40625da9abda", 0, level.br_lootdrone.var_b6a8e1c58b20979b );
    level.br_lootdrone.var_116a7891549bb55f = utility::function_edc4cc03e9e60b3e( @"hash_131973e20d3b6db8", 0, level.br_lootdrone.var_116a7891549bb55f );
    level.br_lootdrone.var_9916edc752ef3a6e = utility::function_edc4cc03e9e60b3e( @"hash_c1c46e94127dcadb", 0, level.br_lootdrone.var_9916edc752ef3a6e );
    level.br_lootdrone.var_12932a65bebc4852 = utility::function_edc4cc03e9e60b3e( @"hash_6d26ec07e723e1d6", 0, level.br_lootdrone.var_12932a65bebc4852 );
    level.br_lootdrone.var_c22e4119a84057e0 = utility::function_48f723fdc612ec65( @"hash_bd195f59b4d23849", 0, level.br_lootdrone.var_c22e4119a84057e0 );
    level.br_lootdrone.var_9916edc752ef3a6e = 0;
    level.br_lootdrone.var_12932a65bebc4852 = 0;
    level.br_lootdrone.var_621b890d4a646c41.var_dc7f6abf2e8019d8 = utility::function_edc4cc03e9e60b3e( @"hash_53a4f1808b69f2bf", 0, level.br_lootdrone.var_621b890d4a646c41.var_dc7f6abf2e8019d8 );
    level.br_lootdrone.var_621b890d4a646c41.var_a3f427622d11ba36 = utility::function_edc4cc03e9e60b3e( @"hash_bd00dc510b1f9619", 0, level.br_lootdrone.var_621b890d4a646c41.var_a3f427622d11ba36 );
    level.br_lootdrone.var_621b890d4a646c41.var_38236c2f495de39b = utility::function_edc4cc03e9e60b3e( @"hash_1940e869c3efae0a", 0, level.br_lootdrone.var_621b890d4a646c41.var_38236c2f495de39b );
    level.br_lootdrone.var_621b890d4a646c41.var_a3fbec9b096364d4 = utility::function_edc4cc03e9e60b3e( @"hash_a5beb48128fbd8db", 0, level.br_lootdrone.var_621b890d4a646c41.var_a3fbec9b096364d4 );
    level.br_lootdrone.var_621b890d4a646c41.var_ceda19e9baa0dab9 = utility::function_edc4cc03e9e60b3e( @"hash_76a2d7342ef6c5f9", 0, level.br_lootdrone.var_621b890d4a646c41.var_ceda19e9baa0dab9 );
    level.br_lootdrone.var_621b890d4a646c41.var_328f74f22390f516 = utility::function_edc4cc03e9e60b3e( @"hash_6ea19edee4366ba6", 0, level.br_lootdrone.var_621b890d4a646c41.var_328f74f22390f516 );
    level.br_lootdrone.var_621b890d4a646c41.var_346b07d129d2d8f8 = utility::function_edc4cc03e9e60b3e( @"hash_248caa91728f2ee6", 0, level.br_lootdrone.var_621b890d4a646c41.var_346b07d129d2d8f8 );
    level.br_lootdrone.var_ae3587a8e8d911c8 = getdvarint( @"hash_38a90c968cfd4303", 1 );
    function_2c85cd98195b2486( level.br_lootdrone.var_e4093ff943672adf );
    function_7f9a455c6eb166ab();
    level.br_lootdrone.fleeingdrones = [];
    level.br_lootdrone.var_5efb1aef7c349d19 = [];
    level.br_lootdrone.var_89efa08ae46e6eed = [];
    level.br_lootdrone.kiosks = [];
    
    if ( !isdefined( level.package_airdrop.var_ef5d3eb1f3996c23 ) )
    {
        level.package_airdrop.var_ef5d3eb1f3996c23 = [];
    }
    
    level.br_lootdrone.var_3750860b7dcf6c1b = [];
    level.br_lootdrone.var_765bc259fc4ff49f = [];
    level.br_lootdrone.var_d28b4351589a191d = 0;
    level.br_lootdrone.var_9afd91952aa20502 = utility::function_48f723fdc612ec65( @"hash_ee0c69f396ccb987", 0, level.br_lootdrone.var_9afd91952aa20502 );
    level.br_lootdrone.var_9ada7b952a7b8ce8 = utility::function_48f723fdc612ec65( @"hash_ee2f57f396f2d9a9", 0, level.br_lootdrone.var_9ada7b952a7b8ce8 );
    level.br_lootdrone.var_551666ea4ade92e3 = utility::function_48f723fdc612ec65( @"hash_ca171a534752e4d7", 0, level.br_lootdrone.var_551666ea4ade92e3 );
    level.br_lootdrone.var_e1c40909b51b3ce8 = utility::function_48f723fdc612ec65( @"hash_60f012c9dcb7f3c4", 0, level.br_lootdrone.var_e1c40909b51b3ce8 );
    level.br_lootdrone.var_d9a3e21b2f00c81c = utility::function_48f723fdc612ec65( @"hash_998a292e3a2279d7", 0, level.br_lootdrone.var_d9a3e21b2f00c81c );
    level.br_lootdrone.var_bc85d1d49753d773 = utility::function_edc4cc03e9e60b3e( @"hash_f841441bb4d64379", 0, level.br_lootdrone.var_bc85d1d49753d773 );
    level.br_lootdrone.var_9faa4405618522ba = utility::function_edc4cc03e9e60b3e( @"hash_1ca1411df06e5e56", 0, level.br_lootdrone.var_9faa4405618522ba );
    level.br_lootdrone.var_16a9bf46776cd068 = getdvarint( @"hash_a6a8ed2f2e04aaed", 1 );
    level.br_lootdrone.var_15dd4500ea25ad81 = getdvarint( @"hash_430188e1fe0b765d", 1 );
    level.br_lootdrone.var_d12f481a1e217674 = getdvarint( @"hash_98a7ec4155422db5", 0 );
    level.br_lootdrone.var_229c4d2940cc8413 = getdvarint( @"hash_e4a6cf5917e83fb8", 1 );
    level.br_lootdrone.telemetry = { #var_a088f263f19a6fb1:0, #var_c321f05a95173c8:0, #var_caec3e8e99052b75:0, #var_88c020c31e7555f0:0, #var_2a9d4b08cc231baa:0, #var_548f43e4a4515465:0, #var_39162a6e452b334b:0, #var_a598f061d3b42889:0, #var_80ec86b393056146:0, #var_61c7f623ab3a1a70:0, #var_c35878820e8392bc:0, #var_3fd4fb097c510f93:0, #var_64cf1ff93713217d:0 };
    level.br_lootdrone.var_4f08593951f223c3 = max( 1, level.br_lootdrone.var_635b8fe50c2dca88 );
    level.br_lootdrone.var_4342a8c408f9b538 = 1 / level.br_lootdrone.var_4f08593951f223c3;
    level.br_lootdrone.var_5ca2ba5e47c0a97f = level.br_lootdrone.var_c22e4119a84057e0 * level.br_lootdrone.var_c22e4119a84057e0;
    level.br_lootdrone.var_63e951522e470ce = undefined;
    level.br_lootdrone.var_ad3b5c2032eff2a2 = 1;
    level thread initializeairdrops();
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x8ac06736, Offset: 0x1076
// Size: 0x14b
function private function_2c85cd98195b2486( var_f306101e28a71fd9 )
{
    if ( !var_f306101e28a71fd9 )
    {
        return;
    }
    
    foreach ( var_672add1fe20fc1b0 in var_f306101e28a71fd9 )
    {
        if ( var_672add1fe20fc1b0.radius <= 0 )
        {
            var_672add1fe20fc1b0.radiussq = 0;
            continue;
        }
        
        var_672add1fe20fc1b0.radiussq = var_672add1fe20fc1b0.radius * var_672add1fe20fc1b0.radius;
        var_672add1fe20fc1b0.minx = var_672add1fe20fc1b0.x - var_672add1fe20fc1b0.radius;
        var_672add1fe20fc1b0.maxx = var_672add1fe20fc1b0.x + var_672add1fe20fc1b0.radius;
        var_672add1fe20fc1b0.miny = var_672add1fe20fc1b0.y - var_672add1fe20fc1b0.radius;
        var_672add1fe20fc1b0.maxy = var_672add1fe20fc1b0.y + var_672add1fe20fc1b0.radius;
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xa8a1c566, Offset: 0x11c9
// Size: 0x409
function private initializeairdrops()
{
    level.br_lootdrone.var_41734b419eaa2d6e = [];
    level.br_lootdrone.var_5efb1aef7c349d19 = [];
    level.br_lootdrone.var_89efa08ae46e6eed = [];
    
    foreach ( cacheconversion in level.br_lootdrone.var_803f0a47efa17f45 )
    {
        level.br_lootdrone.var_5efb1aef7c349d19[ cacheconversion.cacheairdrop ] = cacheconversion.var_3b8656737e816a30;
        level.br_lootdrone.var_89efa08ae46e6eed[ cacheconversion.cacheairdrop ] = { #var_4cb5d83a125fb4f4:cacheconversion.var_4cb5d83a125fb4f4, #var_43a08c048eb36af2:cacheconversion.var_43a08c048eb36af2, #var_3b8656737e816a30:cacheconversion.var_3b8656737e816a30 };
        level.package_airdrop.var_ef5d3eb1f3996c23[ cacheconversion.cacheairdrop ] = level.br_lootdrone.var_e4093ff943672adf;
        
        if ( !airdrop_scriptbundle::function_fa19528c206bd43( cacheconversion.cacheairdrop ) )
        {
            airdrop_scriptbundle::registerairdrop( cacheconversion.cacheairdrop );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_cb68d69fe85eb56f", &function_3c7e87469c5b1c89 );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_e9a6accd033eb4b9", &function_12e66e75a4671a5f );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_82fb75eefaf0a89a", &function_92ecce849ccd6b80 );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_852023c9f529dca6", &function_62126435aa684b9c );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_ad000e5ba06523ee", &function_4da7827748327bbc );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_bf45f87bd7e526e0", &function_e3319882cb2cb1f8 );
            airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.cacheairdrop, #"hash_bdb69033b1b13c60", &function_ef629207eca04484 );
        }
        
        if ( cacheconversion.var_f038d32f67f47aa9 )
        {
            level.br_lootdrone.var_41734b419eaa2d6e[ cacheconversion.cacheairdrop ] = cacheconversion.var_f038d32f67f47aa9;
            level.br_lootdrone.var_89efa08ae46e6eed[ cacheconversion.var_f038d32f67f47aa9 ] = level.br_lootdrone.var_89efa08ae46e6eed[ cacheconversion.cacheairdrop ];
            
            if ( !airdrop_scriptbundle::function_fa19528c206bd43( cacheconversion.var_f038d32f67f47aa9 ) )
            {
                airdrop_scriptbundle::registerairdrop( cacheconversion.var_f038d32f67f47aa9 );
                airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.var_f038d32f67f47aa9, #"hash_cb68d69fe85eb56f", &function_3c7e87469c5b1c89 );
                airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.var_f038d32f67f47aa9, #"hash_e9a6accd033eb4b9", &function_12e66e75a4671a5f );
                airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.var_f038d32f67f47aa9, #"hash_852023c9f529dca6", &function_62126435aa684b9c );
                airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.var_f038d32f67f47aa9, #"hash_bf45f87bd7e526e0", &function_e3319882cb2cb1f8 );
                airdrop_scriptbundle::function_eeb87fc1f31bec35( cacheconversion.var_f038d32f67f47aa9, #"hash_bdb69033b1b13c60", &function_ef629207eca04484 );
            }
        }
    }
    
    if ( level.br_lootdrone.var_9916edc752ef3a6e )
    {
        function_520831d2effe8fe3();
    }
    
    if ( level.br_lootdrone.var_4ae010cf02bff2d8 )
    {
        airdrop_scriptbundle::registerairdrop( level.br_lootdrone.var_4ae010cf02bff2d8 );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xb60b3639, Offset: 0x15da
// Size: 0x127
function private function_520831d2effe8fe3()
{
    br_deployable_kiosk::function_1cc0e3b19bbe480c( level.br_lootdrone.kioskairdrop );
    level.package_airdrop.var_ef5d3eb1f3996c23[ level.br_lootdrone.kioskairdrop ] = level.br_lootdrone.var_e4093ff943672adf;
    airdrop_scriptbundle::function_eeb87fc1f31bec35( level.br_lootdrone.kioskairdrop, #"hash_f35f0e2b6123474f", &function_5dce73d456f8ba69, 1 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( level.br_lootdrone.kioskairdrop, #"crateactivatefunc", &function_286bbc9e096eacea, 1 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( level.br_lootdrone.kioskairdrop, #"hash_cb68d69fe85eb56f", &function_6bdd625ec3faa448, 1 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( level.br_lootdrone.kioskairdrop, #"hash_852023c9f529dca6", &function_f8dddaa9eea3f115 );
    airdrop_scriptbundle::function_eeb87fc1f31bec35( level.br_lootdrone.kioskairdrop, #"hash_e9a6accd033eb4b9", &function_ce18f613abf8eeaf, 1 );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x4f471212, Offset: 0x1709
// Size: 0x172
function private function_e402fc89335d03f9( objectiveplayer, cacheconversion )
{
    lootcache = self;
    var_825584aaa4e821e7 = level.br_lootdrone.var_89efa08ae46e6eed[ cacheconversion ];
    
    if ( !isdefined( var_825584aaa4e821e7.var_3b8656737e816a30 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid == -1 )
    {
        return;
    }
    
    lootdroneobjective = { #objid:objid };
    lootcache.lootdroneobjective = lootdroneobjective;
    objidpoolmanager::objective_add_objective( objid, "active", lootcache.origin, var_825584aaa4e821e7.var_3b8656737e816a30 );
    objidpoolmanager::update_objective_onentity( objid, lootcache );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::update_objective_setbackground( objid, 1 );
    objidpoolmanager::objective_playermask_single( objid, objectiveplayer );
    objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
    objective_disableping( objid, 1 );
    rgbcolor = utility::function_c5d9978d36c9459e( var_825584aaa4e821e7.var_43a08c048eb36af2 );
    objidpoolmanager::function_373aaf492aabde6f( objid, rgbcolor[ 0 ], rgbcolor[ 1 ], rgbcolor[ 2 ] );
    wait var_825584aaa4e821e7.var_4cb5d83a125fb4f4;
    
    if ( !isdefined( lootdroneobjective.objid ) )
    {
        return;
    }
    
    objidpoolmanager::returnobjectiveid( lootdroneobjective.objid );
    lootdroneobjective.objid = undefined;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x820d0ea2, Offset: 0x1883
// Size: 0x9e
function private function_5dce73d456f8ba69( airdropsettings )
{
    br_deployable_kiosk::disabledeployablekiosk();
    self.var_60de57e0dd65d20a = airdropsettings.extradata.var_60de57e0dd65d20a;
    
    if ( isdefined( self.var_60de57e0dd65d20a ) )
    {
        br_deployable_kiosk::function_3b2eefd0e491e3cd( self.var_60de57e0dd65d20a, self );
    }
    
    if ( br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        self setscriptablepartstate( #"objective", #"firesale_active", 0 );
    }
    else
    {
        self setscriptablepartstate( #"objective", #"active", 0 );
    }
    
    calloutmarkerping::function_6052d1ed5729bcfc( self );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xd9d51936, Offset: 0x1929
// Size: 0x16e
function private function_286bbc9e096eacea( isfirstactivation )
{
    if ( !isfirstactivation )
    {
        return;
    }
    
    origin = ( round( self.origin[ 0 ] ), round( self.origin[ 1 ] ), round( self.origin[ 2 ] ) );
    angles = self.angles;
    statickiosk = spawnscriptable( level.br_lootdrone.var_ba03c9558ad09288, origin, angles );
    statickiosk setscriptablepartstate( #"objective", #"active" );
    statickiosk br_deployable_kiosk::disabledeployablekiosk();
    statickiosk.var_ea4a540642460712 = 1;
    statickiosk.var_60de57e0dd65d20a = self.var_60de57e0dd65d20a;
    level.deployablekiosks.buystations[ level.deployablekiosks.buystations.size ] = statickiosk;
    level.br_lootdrone.kiosks[ level.br_lootdrone.kiosks.size ] = statickiosk;
    airdrop::cratephysicsoff();
    calloutmarkerping::function_9bd4bf4f8fe74b16( self, statickiosk, 9 );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    statickiosk br_deployable_kiosk::activatedeployablekiosk( 1 );
    
    if ( isdefined( statickiosk.var_60de57e0dd65d20a ) )
    {
        br_deployable_kiosk::function_89d9b01a8deaecf7( statickiosk.var_60de57e0dd65d20a, statickiosk );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xfb41946a, Offset: 0x1a9f
// Size: 0x111
function private function_fbbeeccfc4a0a7c4()
{
    invalidkeys = [];
    
    foreach ( key, conversion in level.br_lootdrone.var_803f0a47efa17f45 )
    {
        if ( function_350e351986607b20( conversion ) )
        {
            continue;
        }
        
        invalidkeys[ invalidkeys.size ] = key;
    }
    
    foreach ( key in invalidkeys )
    {
        level.br_lootdrone.var_803f0a47efa17f45[ key ] = undefined;
    }
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x4c4b9a9, Offset: 0x1bb8
// Size: 0xb8, Type: bool
function private function_350e351986607b20( conversion )
{
    if ( conversion.var_7e15420da21dba66 > 0 )
    {
        return true;
    }
    
    foreach ( poioverride in conversion.poioverrides )
    {
        if ( poioverride.conversionratio > 0 )
        {
            return true;
        }
    }
    
    if ( conversion.var_df182d199a9a16b6 > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x81bdbb54, Offset: 0x1c79
// Size: 0x35
function private initfeatures( params )
{
    if ( level.br_lootdrone.var_b6a8e1c58b20979b == 1 )
    {
        br_gametypes::disablefeature( #"hash_bd1f8398e2f123b" );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x639c8456, Offset: 0x1cb6
// Size: 0xc62
function private convertcaches()
{
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    mapcaches = getlootscriptablearrayinradius( undefined, undefined, undefined, undefined, "body" );
    level.br_lootdrone.eligiblecaches = [];
    level.br_lootdrone.var_82171b46b24d6333 = [];
    
    /#
        level.br_lootdrone.fallbackcaches = [];
        level.br_lootdrone.forbiddencaches = [];
    #/
    
    poicaches = [];
    var_d68c81b03d8c8dfb = [];
    var_2776f4fc58fc4e76 = [];
    var_e3ae39b24a8141c1 = max( 1, level.br_lootdrone.var_635b8fe50c2dca88 );
    
    for ( cacheindex = 0; cacheindex < mapcaches.size ; cacheindex++ )
    {
        cache = mapcaches[ cacheindex ];
        cachetype = getxhash( cache.type );
        cacheconversion = level.br_lootdrone.var_803f0a47efa17f45[ cachetype ];
        
        if ( !cacheconversion )
        {
            continue;
        }
        
        if ( cache function_c8505c98da9172dd() )
        {
            /#
                level.br_lootdrone.forbiddencaches[ level.br_lootdrone.forbiddencaches.size ] = cache;
            #/
            
            continue;
        }
        
        function_9cd34f662e07096a( cache );
        poi = poi::poi_findpoioriginisin( cache.origin );
        poiname = poi::function_356e66e91a150a02( poi );
        
        if ( !isdefined( poicaches[ poiname ] ) )
        {
            poicaches[ poiname ] = [];
        }
        
        if ( !isdefined( poicaches[ poiname ][ cachetype ] ) )
        {
            poicaches[ poiname ][ cachetype ] = { #fallbackcaches:[], #eligiblecaches:[] };
        }
        
        if ( !isdefined( var_d68c81b03d8c8dfb[ poiname ] ) )
        {
            var_d68c81b03d8c8dfb[ poiname ] = { #var_183ff7ba7a40a478:[], #var_2377e6b44abb7b9f:0, #currentweight:0, #weight:0, #maxy:cache.origin[ 1 ], #miny:cache.origin[ 1 ], #maxx:cache.origin[ 0 ], #minx:cache.origin[ 0 ], #origin:poi::poi_getorigin( poiname ) ?? cache.origin, #poiname:poiname };
        }
        
        var_d68c81b03d8c8dfb[ poiname ].minx = min( var_d68c81b03d8c8dfb[ poiname ].minx, cache.origin[ 0 ] );
        var_d68c81b03d8c8dfb[ poiname ].maxx = max( var_d68c81b03d8c8dfb[ poiname ].maxx, cache.origin[ 0 ] );
        var_d68c81b03d8c8dfb[ poiname ].miny = min( var_d68c81b03d8c8dfb[ poiname ].miny, cache.origin[ 1 ] );
        var_d68c81b03d8c8dfb[ poiname ].maxy = max( var_d68c81b03d8c8dfb[ poiname ].maxy, cache.origin[ 1 ] );
        
        if ( cache function_94d6d44e45ece601( var_2776f4fc58fc4e76, var_e3ae39b24a8141c1, level.br_lootdrone.var_1a0b2eaf0ac587f9 ) )
        {
            if ( !isdefined( poicaches[ poiname ][ cachetype ].eligiblecaches ) )
            {
                poicaches[ poiname ][ cachetype ].eligiblecaches = [];
            }
            
            poicaches[ poiname ][ cachetype ].eligiblecaches[ poicaches[ poiname ][ cachetype ].eligiblecaches.size ] = cache;
            level.br_lootdrone.eligiblecaches[ level.br_lootdrone.eligiblecaches.size ] = cache;
            function_c52cf5937159dfe7( var_2776f4fc58fc4e76, cache, var_e3ae39b24a8141c1 );
        }
        else
        {
            if ( !isdefined( poicaches[ poiname ][ cachetype ].fallbackcaches ) )
            {
                poicaches[ poiname ][ cachetype ].fallbackcaches = [];
            }
            
            poicaches[ poiname ][ cachetype ].fallbackcaches[ poicaches[ poiname ][ cachetype ].fallbackcaches.size ] = cache;
            
            /#
                level.br_lootdrone.fallbackcaches[ level.br_lootdrone.fallbackcaches.size ] = cache;
            #/
        }
        
        if ( cacheindex % 50 == 0 )
        {
            waitframe();
        }
    }
    
    level.br_lootdrone.var_a0f20434e13b93ef = [];
    
    foreach ( poiname, var_478f3a478c14b8b6 in poicaches )
    {
        if ( level.br_lootdrone.var_41b003a6d25074cb[ poiname ] )
        {
            continue;
        }
        
        foreach ( cachetype, caches in var_478f3a478c14b8b6 )
        {
            conversion = level.br_lootdrone.var_803f0a47efa17f45[ cachetype ];
            conversionratio = conversion.poioverrides[ poiname ].conversionratio ?? conversion.var_7e15420da21dba66;
            
            if ( conversionratio <= 0 )
            {
                continue;
            }
            
            conversionratio *= level.br_lootdrone.var_a61eb77b5109dd26;
            var_b2fb47ae4a7dd73d = conversion.poioverrides[ poiname ].var_b2fb47ae4a7dd73d ?? conversion.var_b232394a0ade0964;
            var_b2fb47ae4a7dd73d *= level.br_lootdrone.var_a61eb77b5109dd26;
            cachescount = caches.eligiblecaches.size + caches.fallbackcaches.size;
            var_399a8644de8c700 = cachescount * conversionratio;
            var_e765b2165a811496 = cachescount * var_b2fb47ae4a7dd73d;
            
            if ( conversion.var_df182d199a9a16b6 > 0 && var_399a8644de8c700 > 0 )
            {
                cacheairdrop = conversion.cacheairdrop;
                var_d68c81b03d8c8dfb[ poiname ].weight += var_399a8644de8c700;
                var_d68c81b03d8c8dfb[ poiname ].var_2377e6b44abb7b9f += var_399a8644de8c700;
                
                if ( !isdefined( var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ] ) )
                {
                    var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ] = structcopy( conversion );
                }
                
                if ( !isdefined( var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ].weight ) )
                {
                    var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ].weight = 0;
                }
                
                if ( !isdefined( var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ].currentweight ) )
                {
                    var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ].currentweight = 0;
                }
                
                var_d68c81b03d8c8dfb[ poiname ].var_183ff7ba7a40a478[ cacheairdrop ].weight += var_399a8644de8c700;
            }
            
            var_7690516b713df56e = min( var_399a8644de8c700, caches.eligiblecaches.size );
            cachesarray = arrayrandomize( caches.eligiblecaches );
            
            for ( i = 0; i < var_7690516b713df56e ; i++ )
            {
                level.br_lootdrone.var_a0f20434e13b93ef[ level.br_lootdrone.var_a0f20434e13b93ef.size ] = cachesarray[ i ];
                cachesarray[ i ] setscriptablepartstate( #"body", #"hidden" );
            }
            
            cachesarray = caches.fallbackcaches;
            fallbackneeded = max( 0, var_e765b2165a811496 - var_7690516b713df56e );
            
            if ( conversion.var_df182d199a9a16b6 > 0 && cachescount > 0 && ( var_7690516b713df56e > 0 || fallbackneeded > 0 ) )
            {
                airdrop = conversion.cacheairdrop;
                level.br_lootdrone.var_82171b46b24d6333[ airdrop ] = ( level.br_lootdrone.var_82171b46b24d6333[ airdrop ] ?? 0 ) + conversion.var_df182d199a9a16b6;
            }
            
            for ( i = 0; i < min( fallbackneeded, cachesarray.size ) ; i++ )
            {
                level.br_lootdrone.var_a0f20434e13b93ef[ level.br_lootdrone.var_a0f20434e13b93ef.size ] = cachesarray[ i ];
                cachesarray[ i ] setscriptablepartstate( #"body", #"hidden" );
            }
        }
    }
    
    var_dedda6e13abf3dde = max( level.br_lootdrone.var_e876b64823b1a173, level.br_lootdrone.var_635b8fe50c2dca88 );
    level.br_lootdrone.var_765bc259fc4ff49f = [];
    level.br_lootdrone.var_d28b4351589a191d = 0;
    
    foreach ( poiname, poientry in var_d68c81b03d8c8dfb )
    {
        if ( !isdefined( poientry.origin ) || poientry.weight <= 0 || poientry.var_2377e6b44abb7b9f <= 0 )
        {
            continue;
        }
        
        poiwidth = poientry.maxx - poientry.minx;
        poiheight = poientry.maxy - poientry.miny;
        poientry.spawnradius = max( var_dedda6e13abf3dde, max( poiwidth, poiheight ) * 0.5 );
        poientry.airdropentries = [];
        
        foreach ( airdrop, airdropentry in poientry.var_183ff7ba7a40a478 )
        {
            if ( airdropentry.weight <= 0 )
            {
                continue;
            }
            
            poientry.airdropentries[ poientry.airdropentries.size ] = airdropentry;
        }
        
        if ( !poientry.airdropentries.size )
        {
            continue;
        }
        
        level.br_lootdrone.var_d28b4351589a191d += poientry.weight;
        level.br_lootdrone.var_765bc259fc4ff49f[ level.br_lootdrone.var_765bc259fc4ff49f.size ] = poientry;
    }
    
    poicaches = undefined;
    level.br_lootdrone.var_f5dec3101007d7d3 = level.br_lootdrone.var_a0f20434e13b93ef.size;
    level.br_lootdrone.var_fe6cce5e2a4b0fe2 = arraycopy( level.br_lootdrone.var_a0f20434e13b93ef );
    level.br_lootdrone.var_a0f20434e13b93ef = [];
    level.br_lootdrone.var_c34a04f3770c2345 = 0;
    function_7f9a455c6eb166ab();
    
    /#
        var_35a42d1f33ade6c6 = 1;
    #/
    
    if ( !var_35a42d1f33ade6c6 )
    {
        level.br_lootdrone.eligiblecaches = undefined;
    }
    
    level flags::gameflaginit( #"br_lootdrone_init", 1 );
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xb418c2f9, Offset: 0x2920
// Size: 0x1cd
function private function_bae9f8459ee88891()
{
    function_1079439585d3332f();
    var_d2de7b546853c213 = { #avoidgas:0, #circleindex:isdefined( level.br_circle ) ? level.br_circle.circleindex : 0, #var_b67a29fd754f5bbb:0, #dangerradius:0, #dangerorigin:undefined, #var_cc6780fc3aca6efc:level.br_lootdrone.var_5e179e8a8fc38942, #var_6de6665ee743ab43:level.br_lootdrone.var_bfbcf6b143ee6c9f, #gascaches:[], #validcaches:level.br_lootdrone.var_a0f20434e13b93ef };
    
    if ( !level.br_lootdrone.var_a06e5acbe3e22e4f )
    {
        var_d2de7b546853c213.validcaches = level.br_lootdrone.var_ffeb83b29ba43c8e;
        var_d2de7b546853c213.gascaches = level.br_lootdrone.var_a9a863a86f9b2a1;
        var_d2de7b546853c213.dangerorigin = level.br_lootdrone.var_109aac7f8126fa00;
        var_d2de7b546853c213.dangerradius = level.br_lootdrone.var_19ae45bbc5b41e74;
        var_d2de7b546853c213.var_b67a29fd754f5bbb = level.br_lootdrone.var_1e35b227b30df6fc;
        var_d2de7b546853c213.circleindex = level.br_lootdrone.var_3590e99033f2c157;
        var_d2de7b546853c213.avoidgas = isdefined( var_d2de7b546853c213.dangerorigin ) && var_d2de7b546853c213.var_b67a29fd754f5bbb > 0;
    }
    
    return var_d2de7b546853c213;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x47812257, Offset: 0x2af6
// Size: 0xe9
function private function_7f9a455c6eb166ab()
{
    level.br_lootdrone.var_5e179e8a8fc38942 = level.br_lootdrone.var_4079be14911ebeeb > 0 ? max( 1, level.br_lootdrone.var_4079be14911ebeeb ) : 0;
    level.br_lootdrone.var_bfbcf6b143ee6c9f = [];
    level.br_lootdrone.var_ffeb83b29ba43c8e = [];
    level.br_lootdrone.var_a9a863a86f9b2a1 = [];
    level.br_lootdrone.var_109aac7f8126fa00 = undefined;
    level.br_lootdrone.var_19ae45bbc5b41e74 = 0;
    level.br_lootdrone.var_1e35b227b30df6fc = 0;
    level.br_lootdrone.var_3590e99033f2c157 = undefined;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xd5841468, Offset: 0x2be7
// Size: 0x34d
function private function_1079439585d3332f()
{
    currentcircleindex = isdefined( level.br_circle ) ? level.br_circle.circleindex : 0;
    
    if ( level.br_lootdrone.var_a06e5acbe3e22e4f )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e = level.br_lootdrone.var_a0f20434e13b93ef;
        level.br_lootdrone.var_a9a863a86f9b2a1 = [];
        level.br_lootdrone.var_109aac7f8126fa00 = undefined;
        level.br_lootdrone.var_19ae45bbc5b41e74 = 0;
        level.br_lootdrone.var_1e35b227b30df6fc = 0;
        level.br_lootdrone.var_3590e99033f2c157 = currentcircleindex;
        return;
    }
    
    if ( level.br_lootdrone.var_3590e99033f2c157 == currentcircleindex && isdefined( level.br_lootdrone.var_ffeb83b29ba43c8e ) && isdefined( level.br_lootdrone.var_a9a863a86f9b2a1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_circle ) )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e = arraycopy( level.br_lootdrone.var_a0f20434e13b93ef );
        level.br_lootdrone.var_a9a863a86f9b2a1 = [];
        level.br_lootdrone.var_109aac7f8126fa00 = undefined;
        level.br_lootdrone.var_19ae45bbc5b41e74 = 0;
        level.br_lootdrone.var_1e35b227b30df6fc = 0;
        level.br_lootdrone.var_3590e99033f2c157 = currentcircleindex;
        return;
    }
    
    dangerorigin = br_circle::getdangercircleorigin();
    dangerradius = br_circle::getdangercircleradius();
    
    if ( !isdefined( dangerorigin ) || dangerradius <= 0 )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e = arraycopy( level.br_lootdrone.var_a0f20434e13b93ef );
        level.br_lootdrone.var_a9a863a86f9b2a1 = [];
        level.br_lootdrone.var_109aac7f8126fa00 = undefined;
        level.br_lootdrone.var_19ae45bbc5b41e74 = 0;
        level.br_lootdrone.var_1e35b227b30df6fc = 0;
        level.br_lootdrone.var_3590e99033f2c157 = undefined;
        return;
    }
    
    cachepartition = function_5e9d3bf49a06fc6( dangerorigin, dangerradius );
    level.br_lootdrone.var_ffeb83b29ba43c8e = cachepartition.validcaches;
    level.br_lootdrone.var_a9a863a86f9b2a1 = cachepartition.gascaches;
    level.br_lootdrone.var_109aac7f8126fa00 = dangerorigin;
    level.br_lootdrone.var_19ae45bbc5b41e74 = dangerradius;
    level.br_lootdrone.var_1e35b227b30df6fc = cachepartition.var_b67a29fd754f5bbb;
    level.br_lootdrone.var_3590e99033f2c157 = currentcircleindex;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xddcc26a, Offset: 0x2f3c
// Size: 0x117
function private function_5e9d3bf49a06fc6( dangerorigin, dangerradius )
{
    cachepartition = { #var_b67a29fd754f5bbb:dangerradius * dangerradius, #gascaches:[], #validcaches:[] };
    
    foreach ( cache in level.br_lootdrone.var_a0f20434e13b93ef )
    {
        if ( function_a8424d3233eb384f( cache.origin, dangerorigin, cachepartition.var_b67a29fd754f5bbb ) )
        {
            cachepartition.validcaches[ cachepartition.validcaches.size ] = cache;
            continue;
        }
        
        cachepartition.gascaches[ cachepartition.gascaches.size ] = cache;
    }
    
    return cachepartition;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0x99313a8c, Offset: 0x305c
// Size: 0x32, Type: bool
function private function_a8424d3233eb384f( point, dangerorigin, var_b67a29fd754f5bbb )
{
    if ( var_b67a29fd754f5bbb <= 0 )
    {
        return true;
    }
    
    return distance2dsquared( point, dangerorigin ) <= var_b67a29fd754f5bbb;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x3f909701, Offset: 0x3097
// Size: 0x171
function private function_d4cff8a308be6438( cache )
{
    var_e3ae39b24a8141c1 = level.br_lootdrone.var_5e179e8a8fc38942;
    
    if ( var_e3ae39b24a8141c1 > 0 )
    {
        function_c52cf5937159dfe7( level.br_lootdrone.var_bfbcf6b143ee6c9f, cache, var_e3ae39b24a8141c1 );
    }
    
    if ( level.br_lootdrone.var_a06e5acbe3e22e4f || !( isdefined( level.br_lootdrone.var_ffeb83b29ba43c8e ) && isdefined( level.br_lootdrone.var_a9a863a86f9b2a1 ) ) )
    {
        return;
    }
    
    currentcircleindex = isdefined( level.br_circle ) ? level.br_circle.circleindex : 0;
    
    if ( level.br_lootdrone.var_3590e99033f2c157 != currentcircleindex )
    {
        return;
    }
    
    if ( function_a8424d3233eb384f( cache.origin, level.br_lootdrone.var_109aac7f8126fa00, level.br_lootdrone.var_1e35b227b30df6fc ) )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e[ level.br_lootdrone.var_ffeb83b29ba43c8e.size ] = cache;
        return;
    }
    
    level.br_lootdrone.var_a9a863a86f9b2a1[ level.br_lootdrone.var_a9a863a86f9b2a1.size ] = cache;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xc5069f64, Offset: 0x3210
// Size: 0x1cf
function private function_c9529eef0294d3fa( cache )
{
    var_e3ae39b24a8141c1 = level.br_lootdrone.var_5e179e8a8fc38942;
    
    if ( var_e3ae39b24a8141c1 > 0 )
    {
        function_b0d307a0d0990b1b( level.br_lootdrone.var_bfbcf6b143ee6c9f, cache, var_e3ae39b24a8141c1 );
    }
    
    if ( level.br_lootdrone.var_a06e5acbe3e22e4f || !( isdefined( level.br_lootdrone.var_ffeb83b29ba43c8e ) && isdefined( level.br_lootdrone.var_a9a863a86f9b2a1 ) ) )
    {
        return;
    }
    
    currentcircleindex = isdefined( level.br_circle ) ? level.br_circle.circleindex : 0;
    
    if ( level.br_lootdrone.var_3590e99033f2c157 != currentcircleindex )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e = arrayremove( level.br_lootdrone.var_ffeb83b29ba43c8e, cache );
        level.br_lootdrone.var_a9a863a86f9b2a1 = arrayremove( level.br_lootdrone.var_a9a863a86f9b2a1, cache );
        return;
    }
    
    if ( function_a8424d3233eb384f( cache.origin, level.br_lootdrone.var_109aac7f8126fa00, level.br_lootdrone.var_1e35b227b30df6fc ) )
    {
        level.br_lootdrone.var_ffeb83b29ba43c8e = arrayremove( level.br_lootdrone.var_ffeb83b29ba43c8e, cache );
        return;
    }
    
    level.br_lootdrone.var_a9a863a86f9b2a1 = arrayremove( level.br_lootdrone.var_a9a863a86f9b2a1, cache );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xfd1e8196, Offset: 0x33e7
// Size: 0xa2, Type: bool
function private function_d7bc30eb6a574c1e( cache, ignoredcaches = undefined )
{
    if ( !isdefined( ignoredcaches ) || !ignoredcaches.size )
    {
        return false;
    }
    
    foreach ( ignoredcache in ignoredcaches )
    {
        if ( ignoredcache == cache )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0xdb04bed, Offset: 0x3492
// Size: 0x8d
function private function_b666d518f3bd15df( caches, var_fbf0f266b67de556, ignoredcaches = undefined )
{
    if ( !caches.size )
    {
        return;
    }
    
    startindex = randomint( caches.size );
    
    for ( offset = 0; offset < caches.size ; offset++ )
    {
        cache = caches[ ( startindex + offset ) % caches.size ];
        
        if ( function_d7bc30eb6a574c1e( cache, ignoredcaches ) || function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 ) )
        {
            continue;
        }
        
        return cache;
    }
}

// Namespace br_lootdrone
// Params 7, eflags: 0x4
// Checksum 0x931245fe, Offset: 0x3528
// Size: 0x234
function private deploylootdrone( airdropidentifier, airdropconversion, droporigin, dropheight, var_665ef687359d7f72, var_862f398e80cb8798, var_1e5f0b9c8603ca4d )
{
    if ( level.br_lootdrone.var_11cc17f5a555ff86.size == 0 )
    {
        heightsettings = level.br_lootdrone.var_621b890d4a646c41;
    }
    else
    {
        poi = poi::poi_findpoioriginisin( droporigin );
        poiname = poi::function_356e66e91a150a02( poi );
        heightsettings = level.br_lootdrone.var_11cc17f5a555ff86[ getxhash( poiname ) ].overrides ?? level.br_lootdrone.var_621b890d4a646c41;
    }
    
    overridestruct = { #droplocationtype:"map_center", #extradata:{ #var_e3f3bcf1714cf46e:airdropconversion.cacheairdrop, #var_862f398e80cb8798:var_862f398e80cb8798, #var_311353120c9ce395:heightsettings.var_346b07d129d2d8f8, #var_f7897b5ee9ec7ffb:heightsettings.var_328f74f22390f516, #var_cf54e5b423652c8e:heightsettings.var_ceda19e9baa0dab9, #var_fa16e498496647f9:heightsettings.var_a3fbec9b096364d4, #var_4db60f8220ae9e28:heightsettings.var_38236c2f495de39b, #var_85377ffd195d8d13:heightsettings.var_a3f427622d11ba36, #var_2cbebc93d68bfefd:heightsettings.var_dc7f6abf2e8019d8, #var_599c89611404fc2d:!var_1e5f0b9c8603ca4d && level.br_lootdrone.var_bc85d1d49753d773, #skipdrop:var_665ef687359d7f72 && !heightsettings.var_d12f481a1e217674, #var_665ef687359d7f72:var_665ef687359d7f72 }, #dropheight:dropheight ?? randomfloatrange( heightsettings.mindropheight, heightsettings.maxdropheight ), #droporigin:droporigin };
    thread airdrop_scriptbundle::startairdrop( airdropidentifier, undefined, undefined, overridestruct );
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0xf8e4498d, Offset: 0x3764
// Size: 0x3b
function private function_2c67fbd8bbe65582( player, var_d2de7b546853c213, var_fbf0f266b67de556 = undefined )
{
    return function_b291647086b54f0d( player.origin, var_d2de7b546853c213, var_fbf0f266b67de556, undefined );
}

// Namespace br_lootdrone
// Params 6, eflags: 0x4
// Checksum 0x7b375473, Offset: 0x37a8
// Size: 0x397
function private function_b291647086b54f0d( anchororigin, var_d2de7b546853c213, var_fbf0f266b67de556, overridemaxdistance, scatterorigin = undefined, scatterradius = 0 )
{
    var_e1098f30a8a54307 = 0;
    validcaches = var_d2de7b546853c213.validcaches;
    gascaches = var_d2de7b546853c213.gascaches;
    var_6de6665ee743ab43 = var_d2de7b546853c213.var_6de6665ee743ab43;
    dangerorigin = var_d2de7b546853c213.dangerorigin;
    dangerradius = var_d2de7b546853c213.dangerradius;
    var_b67a29fd754f5bbb = var_d2de7b546853c213.var_b67a29fd754f5bbb;
    ignoredcaches = [];
    maxdistance = overridemaxdistance ?? level.br_lootdrone.var_4079be14911ebeeb;
    usescatter = isdefined( scatterorigin ) && scatterradius > 0;
    var_4bbdd064db9947d7 = usescatter ? max( 1, scatterradius - 780 ) : 0;
    
    while ( true )
    {
        if ( !validcaches.size )
        {
            if ( !level.br_lootdrone.var_116a7891549bb55f || !gascaches.size )
            {
                return;
            }
            
            cache = function_b666d518f3bd15df( gascaches, var_fbf0f266b67de556, ignoredcaches );
            var_e1098f30a8a54307 = 1;
        }
        else if ( usescatter )
        {
            cache = function_bb95a306e9cbdfa8( validcaches, anchororigin, maxdistance, var_6de6665ee743ab43, var_d2de7b546853c213.var_cc6780fc3aca6efc, var_fbf0f266b67de556, var_d2de7b546853c213.avoidgas, dangerorigin, var_b67a29fd754f5bbb, ignoredcaches );
        }
        else
        {
            cache = function_5400510d486e6d36( validcaches, anchororigin, maxdistance, var_6de6665ee743ab43, var_d2de7b546853c213.var_cc6780fc3aca6efc, var_fbf0f266b67de556, var_d2de7b546853c213.avoidgas, dangerorigin, var_b67a29fd754f5bbb, ignoredcaches );
            
            if ( !isdefined( cache ) && level.br_lootdrone.var_388052d3e139ed54 > 0 && isdefined( level.br_lootdrone.var_4ea96ab988978b8 ) && gettime() - level.br_lootdrone.var_4ea96ab988978b8 >= level.br_lootdrone.var_388052d3e139ed54 * 1000 && gascaches.size )
            {
                cache = function_b666d518f3bd15df( gascaches, var_fbf0f266b67de556, ignoredcaches );
                
                if ( isdefined( cache ) )
                {
                    var_e1098f30a8a54307 = 1;
                }
            }
        }
        
        if ( !isdefined( cache ) )
        {
            return;
        }
        
        if ( var_e1098f30a8a54307 )
        {
            droporigin = br_circle::getrandompointinboundscircle( dangerorigin, dangerradius, 0.25, 0.75, 1, 1, 1 );
        }
        else if ( usescatter )
        {
            droporigin = utility::function_7afe366c29a77c34( scatterorigin, var_4bbdd064db9947d7 );
        }
        else
        {
            droporigin = utility::function_7afe366c29a77c34( cache.origin, level.br_lootdrone.var_e876b64823b1a173 );
        }
        
        if ( !function_a0b4734bc08cf51c( level.br_lootdrone.var_e79621abdda9125f, droporigin ) )
        {
            break;
        }
        
        ignoredcaches[ ignoredcaches.size ] = cache;
        var_e1098f30a8a54307 = 0;
    }
    
    level.br_lootdrone.var_a0f20434e13b93ef = arrayremove( level.br_lootdrone.var_a0f20434e13b93ef, cache );
    function_c9529eef0294d3fa( cache );
    cacheconversion = level.br_lootdrone.var_803f0a47efa17f45[ getxhash( cache.type ) ];
    level.br_lootdrone.var_4ea96ab988978b8 = gettime();
    function_d06224ddfe6dabbd( droporigin );
    deploylootdrone( cacheconversion.cacheairdrop, cacheconversion, droporigin );
    return cache;
}

// Namespace br_lootdrone
// Params 10, eflags: 0x4
// Checksum 0x91e58bf8, Offset: 0x3b48
// Size: 0x2ea
function private function_5400510d486e6d36( caches, point, maxdistance, var_6de6665ee743ab43 = undefined, var_e3ae39b24a8141c1 = 0, var_fbf0f266b67de556 = undefined, avoidgas = 0, dangerorigin = undefined, var_b67a29fd754f5bbb = 0, ignoredcaches = undefined )
{
    if ( !caches.size )
    {
        return;
    }
    
    maxdistancesq = maxdistance * maxdistance;
    bestcache = undefined;
    bestdistsq = maxdistancesq;
    
    if ( isdefined( var_6de6665ee743ab43 ) && var_e3ae39b24a8141c1 > 0 && maxdistance > 0 )
    {
        bucketradius = int( ceil( maxdistance / var_e3ae39b24a8141c1 ) );
        bucketx = int( floor( point[ 0 ] / var_e3ae39b24a8141c1 ) );
        buckety = int( floor( point[ 1 ] / var_e3ae39b24a8141c1 ) );
        
        for ( x = bucketx - bucketradius; x <= bucketx + bucketradius ; x++ )
        {
            for ( y = buckety - bucketradius; y <= buckety + bucketradius ; y++ )
            {
                var_656a18542bf13f83 = var_6de6665ee743ab43[ x ][ y ];
                
                if ( !var_656a18542bf13f83 )
                {
                    continue;
                }
                
                foreach ( cache in var_656a18542bf13f83 )
                {
                    if ( function_d7bc30eb6a574c1e( cache, ignoredcaches ) || avoidgas && !function_a8424d3233eb384f( cache.origin, dangerorigin, var_b67a29fd754f5bbb ) || function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 ) )
                    {
                        continue;
                    }
                    
                    distsq = distance2dsquared( cache.origin, point );
                    
                    if ( distsq <= bestdistsq )
                    {
                        bestdistsq = distsq;
                        bestcache = cache;
                    }
                }
            }
        }
        
        return bestcache;
    }
    
    foreach ( cache in caches )
    {
        if ( function_d7bc30eb6a574c1e( cache, ignoredcaches ) || function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 ) )
        {
            continue;
        }
        
        distsq = distance2dsquared( cache.origin, point );
        
        if ( distsq <= bestdistsq )
        {
            bestdistsq = distsq;
            bestcache = cache;
        }
    }
    
    return bestcache;
}

// Namespace br_lootdrone
// Params 10, eflags: 0x4
// Checksum 0x1704c53b, Offset: 0x3e3b
// Size: 0x2eb
function private function_bb95a306e9cbdfa8( caches, point, maxdistance, var_6de6665ee743ab43 = undefined, var_e3ae39b24a8141c1 = 0, var_fbf0f266b67de556 = undefined, avoidgas = 0, dangerorigin = undefined, var_b67a29fd754f5bbb = 0, ignoredcaches = undefined )
{
    if ( !caches.size )
    {
        return;
    }
    
    maxdistancesq = maxdistance * maxdistance;
    eligiblecaches = [];
    
    if ( isdefined( var_6de6665ee743ab43 ) && var_e3ae39b24a8141c1 > 0 && maxdistance > 0 )
    {
        bucketradius = int( ceil( maxdistance / var_e3ae39b24a8141c1 ) );
        bucketx = int( floor( point[ 0 ] / var_e3ae39b24a8141c1 ) );
        buckety = int( floor( point[ 1 ] / var_e3ae39b24a8141c1 ) );
        
        for ( x = bucketx - bucketradius; x <= bucketx + bucketradius ; x++ )
        {
            for ( y = buckety - bucketradius; y <= buckety + bucketradius ; y++ )
            {
                var_656a18542bf13f83 = var_6de6665ee743ab43[ x ][ y ];
                
                if ( !var_656a18542bf13f83 )
                {
                    continue;
                }
                
                foreach ( cache in var_656a18542bf13f83 )
                {
                    if ( function_d7bc30eb6a574c1e( cache, ignoredcaches ) || avoidgas && !function_a8424d3233eb384f( cache.origin, dangerorigin, var_b67a29fd754f5bbb ) || function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 ) )
                    {
                        continue;
                    }
                    
                    distsq = distance2dsquared( cache.origin, point );
                    
                    if ( distsq <= maxdistancesq )
                    {
                        eligiblecaches[ eligiblecaches.size ] = cache;
                    }
                }
            }
        }
    }
    else
    {
        foreach ( cache in caches )
        {
            if ( function_d7bc30eb6a574c1e( cache, ignoredcaches ) || function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 ) )
            {
                continue;
            }
            
            distsq = distance2dsquared( cache.origin, point );
            
            if ( distsq <= maxdistancesq )
            {
                eligiblecaches[ eligiblecaches.size ] = cache;
            }
        }
    }
    
    if ( !eligiblecaches.size )
    {
        return;
    }
    
    return eligiblecaches[ randomint( eligiblecaches.size ) ];
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xe7db6c40, Offset: 0x412f
// Size: 0x42, Type: bool
function private function_c8505c98da9172dd()
{
    if ( locksandkeys::function_9894956c856a7904( self.origin ) )
    {
        return true;
    }
    
    if ( br_bunker_utility::function_5f3fda39a064e862( self.origin ) )
    {
        return true;
    }
    
    if ( br_scavenger_quest::function_9e34ff6f77321bef( self.origin ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0x1ef7d78f, Offset: 0x417a
// Size: 0x93
function private function_c52cf5937159dfe7( var_6de6665ee743ab43, cache, var_e3ae39b24a8141c1 )
{
    bucketx = int( floor( cache.origin[ 0 ] / var_e3ae39b24a8141c1 ) );
    buckety = int( floor( cache.origin[ 1 ] / var_e3ae39b24a8141c1 ) );
    
    if ( !isdefined( var_6de6665ee743ab43[ bucketx ] ) )
    {
        var_6de6665ee743ab43[ bucketx ] = [];
    }
    
    if ( !isdefined( var_6de6665ee743ab43[ bucketx ][ buckety ] ) )
    {
        var_6de6665ee743ab43[ bucketx ][ buckety ] = [];
    }
    
    var_6de6665ee743ab43[ bucketx ][ buckety ][ var_6de6665ee743ab43[ bucketx ][ buckety ].size ] = cache;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0x2d8bde19, Offset: 0x4215
// Size: 0x92
function private function_b0d307a0d0990b1b( var_6de6665ee743ab43, cache, var_e3ae39b24a8141c1 )
{
    bucketx = int( floor( cache.origin[ 0 ] / var_e3ae39b24a8141c1 ) );
    buckety = int( floor( cache.origin[ 1 ] / var_e3ae39b24a8141c1 ) );
    var_656a18542bf13f83 = var_6de6665ee743ab43[ bucketx ][ buckety ];
    
    if ( !var_656a18542bf13f83 )
    {
        return;
    }
    
    var_656a18542bf13f83 = arrayremove( var_656a18542bf13f83, cache );
    
    if ( !var_656a18542bf13f83.size )
    {
        var_6de6665ee743ab43[ bucketx ][ buckety ] = undefined;
    }
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xee5e369c, Offset: 0x42af
// Size: 0x77
function private function_9cd34f662e07096a( cache )
{
    cache.var_8759d09803cadaf3 = int( floor( cache.origin[ 0 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    cache.var_8759cf9803cad8c0 = int( floor( cache.origin[ 1 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
}

// Namespace br_lootdrone
// Params 4, eflags: 0x4
// Checksum 0x3c7d8a97, Offset: 0x432e
// Size: 0x156, Type: bool
function private function_c34a742afe31c9aa( var_2776f4fc58fc4e76, origin, var_e3ae39b24a8141c1, mindistancesq )
{
    bucketx = int( floor( origin[ 0 ] / var_e3ae39b24a8141c1 ) );
    buckety = int( floor( origin[ 1 ] / var_e3ae39b24a8141c1 ) );
    
    for ( x = bucketx - 1; x <= bucketx + 1 ; x++ )
    {
        for ( y = buckety - 1; y <= buckety + 1 ; y++ )
        {
            var_656a18542bf13f83 = var_2776f4fc58fc4e76[ x ][ y ];
            
            if ( !var_656a18542bf13f83 )
            {
                continue;
            }
            
            foreach ( othercache in var_656a18542bf13f83 )
            {
                delta = origin - othercache.origin;
                distsq = delta[ 0 ] * delta[ 0 ] + delta[ 1 ] * delta[ 1 ];
                
                if ( distsq <= mindistancesq )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0x5cb50047, Offset: 0x448d
// Size: 0xa2, Type: bool
function private function_94d6d44e45ece601( var_2776f4fc58fc4e76, var_e3ae39b24a8141c1, mindistancesq )
{
    contents = level.br_lootdrone.var_8b7ac7e1495fbe5d;
    raycastorigin = self.origin + ( 0, 0, 30 );
    
    if ( !trace::ray_trace_passed( raycastorigin, raycastorigin + ( 0, 0, 3000 ), undefined, contents ) )
    {
        return false;
    }
    
    if ( mindistancesq > 0 && function_c34a742afe31c9aa( var_2776f4fc58fc4e76, self.origin, var_e3ae39b24a8141c1, mindistancesq ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x7a81fd35, Offset: 0x4538
// Size: 0x80
function private function_731df381cfd669f9()
{
    level endon( #"game_ended" );
    
    if ( !level.br_lootdrone.var_9916edc752ef3a6e )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level thread function_d94ed7ce5f29cda8();
    
    while ( level.br_lootdrone.circlewaves.size - 1 > level.br_circle.circleindex )
    {
        level waittill( #"br_circle_set" );
        level thread function_646ee72eb8122dc1();
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x3e74db1d, Offset: 0x45c0
// Size: 0xd1
function private function_d94ed7ce5f29cda8()
{
    kiosks = common_kiosk::function_5c2447fa1580c330();
    
    foreach ( kiosk in kiosks )
    {
        if ( !isdefined( kiosk ) )
        {
            continue;
        }
        
        if ( !level.br_lootdrone.var_12932a65bebc4852 && kiosk getscriptableisreserved() )
        {
            continue;
        }
        
        kiosk.b_force_disabled = 1;
        common_kiosk::function_cd2eb56f7058384a( kiosk );
        kiosk setscriptablepartstate( "br_plunder_box", "hidden" );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x2279e68d, Offset: 0x4699
// Size: 0x40b
function private function_646ee72eb8122dc1()
{
    level endon( #"game_ended" );
    circleindex = level.br_circle.circleindex;
    Wave = level.br_lootdrone.circlewaves[ circleindex ];
    function_6c0a1e2f046a8a96( level.br_lootdrone.var_63e951522e470ce );
    level.br_lootdrone.var_63e951522e470ce = undefined;
    
    if ( !isdefined( Wave ) || Wave.count <= 0 )
    {
        return;
    }
    
    if ( circleindex >= level.br_level.br_circlecenters.size )
    {
        return;
    }
    
    circlecenter = level.br_level.br_circlecenters[ circleindex ];
    circleradius = level.br_level.br_circleradii[ circleindex ];
    availablestructs = function_420a4e06ba04f5f3( circlecenter, circleradius );
    var_1ca95b6c01b30b9b = min( availablestructs.size, Wave.count );
    
    if ( var_1ca95b6c01b30b9b <= 0 )
    {
        return;
    }
    
    deployedkiosks = [];
    wavestate = { #var_e443d15d899d656b:[], #entries:[], #deployinterval:Wave.deployinterval, #circleindex:circleindex, #waveid:level.br_lootdrone.var_ad3b5c2032eff2a2 };
    level.br_lootdrone.var_ad3b5c2032eff2a2++;
    
    for ( i = 0; i < var_1ca95b6c01b30b9b ; i++ )
    {
        droporigin = undefined;
        
        for ( j = 0; j < availablestructs.size ; j++ )
        {
            candidate = availablestructs[ j ];
            nearkiosks = function_c44b31a67523b336( deployedkiosks, candidate.origin, level.br_lootdrone.var_c22e4119a84057e0 );
            
            if ( nearkiosks.size == 0 )
            {
                droporigin = candidate.origin;
                availablestructs = arrayremove( availablestructs, candidate );
                break;
            }
        }
        
        if ( !isdefined( droporigin ) )
        {
            droporigin = br_circle::getrandompointincurrentcircle( 0, 0.9 );
        }
        
        deployedkiosks[ deployedkiosks.size ] = candidate;
        targetid = br_deployable_kiosk::function_4ea13304e302cf2a( droporigin, ( 0, 0, 0 ), &function_e2e6e5f5c8fc64c1 );
        entry = { #spawnstarted:0, #droporigin:droporigin, #targetid:targetid, #entryindex:wavestate.entries.size };
        wavestate.entries[ wavestate.entries.size ] = entry;
        wavestate.var_e443d15d899d656b[ targetid ] = entry;
    }
    
    if ( !wavestate.entries.size )
    {
        return;
    }
    
    level.br_lootdrone.var_63e951522e470ce = wavestate;
    
    for ( i = 0; i < wavestate.entries.size ; i++ )
    {
        if ( !isdefined( level.br_lootdrone.var_63e951522e470ce ) || level.br_lootdrone.var_63e951522e470ce.waveid != wavestate.waveid )
        {
            break;
        }
        
        entry = wavestate.entries[ i ];
        
        if ( !entry.spawnstarted )
        {
            function_12f02cb3f2d980d( wavestate, entry );
        }
        
        if ( i < wavestate.entries.size - 1 )
        {
            wait wavestate.deployinterval;
        }
    }
    
    if ( isdefined( level.br_lootdrone.var_63e951522e470ce ) && level.br_lootdrone.var_63e951522e470ce.waveid == wavestate.waveid )
    {
        level.br_lootdrone.var_63e951522e470ce = undefined;
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x96befecd, Offset: 0x4aac
// Size: 0x108
function private function_420a4e06ba04f5f3( var_6238966a1e9b8e6, safecircleradius )
{
    allpositions = common_kiosk::function_21e181699df32d49();
    
    if ( !allpositions.size )
    {
        return [];
    }
    
    var_f6eb4078b92a9cb7 = function_c44b31a67523b336( allpositions, var_6238966a1e9b8e6, safecircleradius );
    available = [];
    
    foreach ( pos in var_f6eb4078b92a9cb7 )
    {
        nearkiosks = function_c44b31a67523b336( level.br_lootdrone.kiosks, pos.origin, level.br_lootdrone.var_c22e4119a84057e0 );
        
        if ( nearkiosks.size == 0 )
        {
            available[ available.size ] = pos;
        }
    }
    
    return arrayrandomize( available );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x91b8cd86, Offset: 0x4bbd
// Size: 0xa9
function private function_6c0a1e2f046a8a96( wavestate )
{
    if ( !isdefined( wavestate ) )
    {
        return;
    }
    
    foreach ( entry in wavestate.entries )
    {
        if ( entry.spawnstarted )
        {
            continue;
        }
        
        br_deployable_kiosk::function_27d286fdbdd37401( entry.targetid );
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x52d373d7, Offset: 0x4c6e
// Size: 0x12e, Type: bool
function private function_12f02cb3f2d980d( wavestate, entry )
{
    if ( !( isdefined( wavestate ) && isdefined( entry ) ) || entry.spawnstarted )
    {
        return false;
    }
    
    if ( level.br_circle.circleindex != wavestate.circleindex )
    {
        return false;
    }
    
    target = br_deployable_kiosk::function_3cf3d8098e05c9d7( entry.targetid );
    
    if ( !isdefined( target ) || !target.var_9aaebddcbd952541 )
    {
        wavestate.var_e443d15d899d656b[ entry.targetid ] = undefined;
        return false;
    }
    
    entry.spawnstarted = 1;
    wavestate.entries[ entry.entryindex ] = entry;
    wavestate.var_e443d15d899d656b[ entry.targetid ] = entry;
    br_deployable_kiosk::deployablekioskspawn( undefined, entry.droporigin, 1, level.br_lootdrone.kioskairdrop, level.br_lootdrone.var_bc85d1d49753d773, entry.targetid );
    return true;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xf03c41b6, Offset: 0x4da5
// Size: 0x64, Type: bool
function private function_e2e6e5f5c8fc64c1( targetid )
{
    wavestate = level.br_lootdrone.var_63e951522e470ce;
    
    if ( !( isdefined( targetid ) && isdefined( wavestate ) ) )
    {
        return false;
    }
    
    entry = wavestate.var_e443d15d899d656b[ targetid ];
    
    if ( !isdefined( entry ) )
    {
        return false;
    }
    
    return function_12f02cb3f2d980d( wavestate, entry );
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x501f7587, Offset: 0x4e12
// Size: 0x6a
function private function_227f2bbab85cbeb3()
{
    level endon( #"game_ended" );
    
    if ( !level.br_lootdrone.var_d7e91e356bf9ca50.size )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( #"br_lootdrone_init" );
    
    if ( !function_ad19a9fbcd64192c() )
    {
        flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
    }
    
    while ( true )
    {
        level thread function_9a31a826dbefbb46();
        level waittill( #"br_circle_set" );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x45c78d8f, Offset: 0x4e84
// Size: 0x1c4
function private function_9a31a826dbefbb46()
{
    circleindex = level.br_circle.circleindex;
    waveconfig = level.br_lootdrone.var_d7e91e356bf9ca50[ circleindex ];
    
    if ( !waveconfig )
    {
        return;
    }
    
    releasecount = int( level.br_lootdrone.var_f5dec3101007d7d3 * waveconfig.var_69784703cedf97fb );
    
    if ( !releasecount )
    {
        return;
    }
    
    if ( !isdefined( level.br_lootdrone.var_fe6cce5e2a4b0fe2 ) )
    {
        return;
    }
    
    startindex = level.br_lootdrone.var_c34a04f3770c2345 ?? 0;
    releasedcount = 0;
    
    for ( i = 0; i < releasecount ; i++ )
    {
        cacheindex = startindex + i;
        
        if ( cacheindex >= level.br_lootdrone.var_fe6cce5e2a4b0fe2.size )
        {
            break;
        }
        
        cache = level.br_lootdrone.var_fe6cce5e2a4b0fe2[ cacheindex ];
        level.br_lootdrone.var_a0f20434e13b93ef[ level.br_lootdrone.var_a0f20434e13b93ef.size ] = cache;
        function_d4cff8a308be6438( cache );
        releasedcount++;
    }
    
    if ( !releasedcount )
    {
        return;
    }
    
    level.br_lootdrone.var_c34a04f3770c2345 = startindex + releasedcount;
    
    if ( level.br_lootdrone.var_c34a04f3770c2345 >= level.br_lootdrone.var_fe6cce5e2a4b0fe2.size )
    {
        level.br_lootdrone.var_fe6cce5e2a4b0fe2 = undefined;
    }
    
    level notify( #"hash_def605264cfe3d76" );
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x54524d92, Offset: 0x5050
// Size: 0x2ea
function private function_4aed1b1d15dbe231()
{
    level waittill( #"game_ended" );
    telemetry = level.br_lootdrone.telemetry;
    var_d47ab55bfbb17c50 = function_10c6494784474a39();
    
    if ( level.br_lootdrone.var_229c4d2940cc8413 )
    {
        totalspawned = telemetry.var_64cf1ff93713217d + telemetry.var_3fd4fb097c510f93 + telemetry.var_c35878820e8392bc;
        totaldestroyed = telemetry.var_61c7f623ab3a1a70 + telemetry.var_80ec86b393056146 + telemetry.var_a598f061d3b42889;
        totaldelivered = telemetry.var_39162a6e452b334b + telemetry.var_548f43e4a4515465 + telemetry.var_2a9d4b08cc231baa;
        logstring( "br_lootdrone telemetry :: spawned total=" + totalspawned + " regular =" + telemetry.var_64cf1ff93713217d + " filler =" + telemetry.var_3fd4fb097c510f93 + " kiosks =" + telemetry.var_c35878820e8392bc );
        logstring( "br_lootdrone telemetry :: destroyed total=" + totaldestroyed + " regular =" + telemetry.var_61c7f623ab3a1a70 + " filler =" + telemetry.var_80ec86b393056146 + " kiosks =" + telemetry.var_a598f061d3b42889 + " delivered total=" + totaldelivered + " regular =" + telemetry.var_39162a6e452b334b + " filler =" + telemetry.var_548f43e4a4515465 + " kiosks =" + telemetry.var_2a9d4b08cc231baa );
        logstring( "br_lootdrone telemetry :: left_without_delivery=" + telemetry.var_88c020c31e7555f0 + " caches_cleaned_for_slots=" + telemetry.var_caec3e8e99052b75 + " opened =" + telemetry.var_c321f05a95173c8 + " closed =" + telemetry.var_a088f263f19a6fb1 + " active_airborne_at_end=" + var_d47ab55bfbb17c50 + " tracked_filler_caches_at_end=" + level.br_lootdrone.var_3750860b7dcf6c1b.size );
    }
    
    dlog_recordevent( "dlog_event_br_lootdrone_match_end", [ "regular_spawn", telemetry.var_64cf1ff93713217d, "filler_spawn", telemetry.var_3fd4fb097c510f93, "kiosk_spawn", telemetry.var_c35878820e8392bc, "regular_destroyed", telemetry.var_61c7f623ab3a1a70, "filler_destroyed", telemetry.var_80ec86b393056146, "kiosk_destroyed", telemetry.var_a598f061d3b42889, "opened_caches_cleaned", telemetry.var_c321f05a95173c8, "closed_caches_cleaned", telemetry.var_a088f263f19a6fb1, "active_drones_end", var_d47ab55bfbb17c50 ] );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x4107e8e2, Offset: 0x5342
// Size: 0x1d2
function private function_3c7e87469c5b1c89( drone )
{
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    var_48f7c811727686a2 = drone.airdropsettings.overrideoptions.var_48f7c811727686a2;
    
    if ( !( behaviorsettings.type == #"flee_drone" && var_48f7c811727686a2 ) )
    {
        extradata = drone.airdropsettings.extradata;
        
        if ( extradata.var_665ef687359d7f72 )
        {
            level.br_lootdrone.telemetry.var_3fd4fb097c510f93++;
        }
        else
        {
            level.br_lootdrone.telemetry.var_64cf1ff93713217d++;
        }
    }
    
    if ( behaviorsettings.type != #"flee_drone" )
    {
        return;
    }
    
    level.br_lootdrone.fleeingdrones = function_5713d46873b29625( level.br_lootdrone.fleeingdrones );
    level.br_lootdrone.fleeingdrones[ level.br_lootdrone.fleeingdrones.size ] = drone;
    
    if ( var_48f7c811727686a2 )
    {
        drone.var_904083cc887feb96 = var_48f7c811727686a2.var_904083cc887feb96;
        calloutmarkerping::function_9bd4bf4f8fe74b16( var_48f7c811727686a2, drone.allyobjid, 6 );
        var_48f7c811727686a2 freescriptable();
        drone.airdropsettings.overrideoptions.var_48f7c811727686a2 = undefined;
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x8bd54a4b, Offset: 0x551c
// Size: 0x10a
function private function_12e66e75a4671a5f( drone, eattacker )
{
    if ( isdefined( eattacker ) )
    {
        if ( isplayer( eattacker ) )
        {
            drone.package thread function_e402fc89335d03f9( eattacker, drone.airdropsettings.extradata.var_e3f3bcf1714cf46e );
        }
        
        return;
    }
    
    /#
        function_2f19d41cb9e10379( drone, #"dropped" );
    #/
    
    extradata = drone.airdropsettings.extradata;
    
    if ( extradata.iskiosk )
    {
        level.br_lootdrone.telemetry.var_2a9d4b08cc231baa++;
        return;
    }
    
    if ( extradata.var_665ef687359d7f72 )
    {
        level.br_lootdrone.telemetry.var_548f43e4a4515465++;
        return;
    }
    
    level.br_lootdrone.telemetry.var_39162a6e452b334b++;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xc8f5b7a8, Offset: 0x562e
// Size: 0x4e
function private function_92ecce849ccd6b80( drone )
{
    if ( !drone.var_a1e594c2cae42e0b )
    {
        level.br_lootdrone.telemetry.var_88c020c31e7555f0++;
    }
    
    /#
        function_2f19d41cb9e10379( drone, #"hash_1763543050cd6745" );
    #/
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x60ebd485, Offset: 0x5684
// Size: 0x186
function private function_62126435aa684b9c( drone, eattacker )
{
    /#
        function_2f19d41cb9e10379( drone, #"destroyed" );
    #/
    
    if ( drone.airdropsettings.extradata.var_665ef687359d7f72 )
    {
        level.br_lootdrone.telemetry.var_80ec86b393056146++;
    }
    else
    {
        level.br_lootdrone.telemetry.var_61c7f623ab3a1a70++;
    }
    
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( behaviorsettings.type == #"flee_drone" )
    {
        level.br_lootdrone.fleeingdrones = arrayremove( level.br_lootdrone.fleeingdrones, drone );
        level.br_lootdrone.fleeingdrones = function_5713d46873b29625( level.br_lootdrone.fleeingdrones );
    }
    
    if ( isplayer( eattacker ) && ( !drone.var_a1e594c2cae42e0b || level.br_lootdrone.var_ae3587a8e8d911c8 ) )
    {
        challenges::function_37e945722d6497f3( eattacker, "lootdrone_destroyed", 1 );
    }
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xcd07986e, Offset: 0x5812
// Size: 0x33
function private function_6bdd625ec3faa448( drone )
{
    level.br_lootdrone.telemetry.var_c35878820e8392bc++;
    br_deployable_kiosk::function_6e9d8ba6cb62d8d7( drone );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x141137a0, Offset: 0x584d
// Size: 0xe4
function private function_f8dddaa9eea3f115( drone, eattacker )
{
    level.br_lootdrone.telemetry.var_a598f061d3b42889++;
    
    if ( drone.var_a1e594c2cae42e0b )
    {
        return;
    }
    
    behaviorsettings = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    
    if ( behaviorsettings.neverdrop || drone.airdropsettings.extradata.skipdrop )
    {
        br_deployable_kiosk::function_8ae7bc4f3e1e982f( drone.airdropsettings.extradata.var_60de57e0dd65d20a );
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x3200f430, Offset: 0x5939
// Size: 0x29
function private function_ce18f613abf8eeaf( drone, eattacker )
{
    function_12e66e75a4671a5f( drone, eattacker );
    br_deployable_kiosk::function_14371b8d475c62ca( drone, eattacker );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x9960541f, Offset: 0x596a
// Size: 0x105
function private function_4da7827748327bbc( drone, eattacker )
{
    if ( !level.br_lootdrone.var_15dd4500ea25ad81 || drone.hastransformed || drone.var_a1e594c2cae42e0b )
    {
        return;
    }
    
    level.br_lootdrone.fleeingdrones = function_5713d46873b29625( level.br_lootdrone.fleeingdrones );
    
    if ( level.br_lootdrone.fleeingdrones.size >= level.br_lootdrone.var_fddd47311bb3f564 )
    {
        return;
    }
    
    var_f038d32f67f47aa9 = level.br_lootdrone.var_41734b419eaa2d6e[ drone.airdropsettings.airdropidentifier ];
    
    if ( !var_f038d32f67f47aa9 )
    {
        return;
    }
    
    drone.hastransformed = 1;
    drone.disabledamage = 1;
    drone thread function_92f2c42bb30c10ac( eattacker, var_f038d32f67f47aa9 );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x69925c34, Offset: 0x5a77
// Size: 0x209
function private function_92f2c42bb30c10ac( eattacker, var_f038d32f67f47aa9 )
{
    scriptable = self;
    owner = scriptable.owner;
    team = scriptable.team;
    droporigin = scriptable.airdropsettings.droparea.origin;
    originbefore = scriptable.origin;
    spawnangles = scriptable.angles;
    timebefore = gettime();
    waitframe();
    var_831c87188cefe7ee = gettime() - timebefore;
    spawnorigin = isdefined( scriptable ) ? scriptable.origin : originbefore;
    initialvelocity = var_831c87188cefe7ee > 0 ? ( spawnorigin - originbefore ) * 1000 / var_831c87188cefe7ee : ( 0, 0, 0 );
    
    if ( isdefined( scriptable ) )
    {
        function_a8ef5f61f916de7b( scriptable );
        level.package_airdrop.var_ced97a3033b9b333 = arrayremove( level.package_airdrop.var_ced97a3033b9b333, scriptable );
    }
    else
    {
        level.package_airdrop.var_ced97a3033b9b333 = function_5713d46873b29625( level.package_airdrop.var_ced97a3033b9b333 );
    }
    
    level notify( #"hash_b725273b968f9756" );
    overridestruct = { #extradata:scriptable.airdropsettings.extradata, #var_48f7c811727686a2:scriptable, #var_5a1a4638f0b8eae1:initialvelocity, #fleeattacker:eattacker, #fleespawnangles:spawnangles, #fleespawnorigin:spawnorigin, #droplocationtype:"map_center", #droporigin:droporigin };
    thread airdrop_scriptbundle::startairdrop( var_f038d32f67f47aa9, owner, team, overridestruct );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x529bf57b, Offset: 0x5c88
// Size: 0x70
function private function_540640d9c028fe2e( var_e79621abdda9125f, origin )
{
    bucketx = int( floor( origin[ 0 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    buckety = int( floor( origin[ 1 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    return var_e79621abdda9125f[ bucketx ][ buckety ];
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x4e2c136a, Offset: 0x5d01
// Size: 0x47, Type: bool
function private function_9c4c2fd9ec891064( drone )
{
    return drone.airdropsettings.droparea.origin ?? drone.droplocation ?? drone.origin;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xddadccab, Offset: 0x5d51
// Size: 0x36, Type: bool
function private function_8e98c5fdd396ca4a( origina, originb )
{
    return origina[ 0 ] == originb[ 0 ] && origina[ 1 ] == originb[ 1 ] && origina[ 2 ] == originb[ 2 ];
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xa3da8407, Offset: 0x5d90
// Size: 0xb2, Type: bool
function private function_91cee772bae87cb0( var_e79621abdda9125f, origin )
{
    if ( !isdefined( var_e79621abdda9125f ) )
    {
        return false;
    }
    
    var_d177f7ddc9a97a6f = function_540640d9c028fe2e( var_e79621abdda9125f, origin );
    
    if ( !var_d177f7ddc9a97a6f )
    {
        return false;
    }
    
    foreach ( otherorigin in var_d177f7ddc9a97a6f )
    {
        if ( function_8e98c5fdd396ca4a( otherorigin, origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x71123199, Offset: 0x5e4b
// Size: 0xc2, Type: bool
function private function_760bb69085fa711e( drone, origin )
{
    foreach ( otherdrone in level.package_airdrop.var_ced97a3033b9b333 )
    {
        if ( !otherdrone || otherdrone == drone )
        {
            continue;
        }
        
        otherorigin = function_9c4c2fd9ec891064( otherdrone );
        
        if ( function_8e98c5fdd396ca4a( otherorigin, origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x75de4f30, Offset: 0x5f16
// Size: 0xfb
function private function_d06224ddfe6dabbd( origin )
{
    bucketx = int( floor( origin[ 0 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    buckety = int( floor( origin[ 1 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f[ bucketx ] ) )
    {
        level.br_lootdrone.var_e79621abdda9125f[ bucketx ] = [];
    }
    
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ] ) )
    {
        level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ] = [];
    }
    
    level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ][ level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ].size ] = origin;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x1c5e57b8, Offset: 0x6019
// Size: 0xb5
function private function_8d3d3095650657ff( origin )
{
    bucketx = int( floor( origin[ 0 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    buckety = int( floor( origin[ 1 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ] ) )
    {
        return;
    }
    
    level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ] = arrayremove( level.br_lootdrone.var_e79621abdda9125f[ bucketx ][ buckety ], origin );
}

// Namespace br_lootdrone
// Params 1
// Checksum 0x4e9bd181, Offset: 0x60d6
// Size: 0xaf
function function_9da02b45dccaa087( drone )
{
    if ( isdefined( drone.airdropsettings.extradata.var_60de57e0dd65d20a ) && !drone.var_a1e594c2cae42e0b )
    {
        br_deployable_kiosk::function_3b2eefd0e491e3cd( drone.airdropsettings.extradata.var_60de57e0dd65d20a, drone );
    }
    
    function_78b989a66ff03a87( drone );
    
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f ) )
    {
        return;
    }
    
    origin = function_9c4c2fd9ec891064( drone );
    function_8d3d3095650657ff( origin );
    function_d06224ddfe6dabbd( origin );
}

// Namespace br_lootdrone
// Params 1
// Checksum 0x68b42227, Offset: 0x618d
// Size: 0x58
function function_a8ef5f61f916de7b( drone )
{
    function_1abf18bf223c796c( drone );
    
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f ) )
    {
        return;
    }
    
    origin = function_9c4c2fd9ec891064( drone );
    
    if ( function_760bb69085fa711e( drone, origin ) )
    {
        return;
    }
    
    function_8d3d3095650657ff( origin );
}

// Namespace br_lootdrone
// Params 1
// Checksum 0xe916a356, Offset: 0x61ed
// Size: 0x4e
function function_85c603bfb1f7e9b3( cache )
{
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f ) )
    {
        return;
    }
    
    cache.densityorigin = cache.origin;
    function_d06224ddfe6dabbd( cache.densityorigin );
}

// Namespace br_lootdrone
// Params 1
// Checksum 0x95adcba7, Offset: 0x6243
// Size: 0x48
function function_1112a2648f0074d7( cache )
{
    if ( !isdefined( level.br_lootdrone.var_e79621abdda9125f ) || !isdefined( cache.densityorigin ) )
    {
        return;
    }
    
    function_8d3d3095650657ff( cache.densityorigin );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xd6e28176, Offset: 0x6293
// Size: 0x17f, Type: bool
function private function_76e38178f26c65b( var_e79621abdda9125f, origin )
{
    if ( level.br_lootdrone.var_1a0b2eaf0ac587f9 <= 0 )
    {
        return false;
    }
    
    bucketx = int( floor( origin[ 0 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    buckety = int( floor( origin[ 1 ] * level.br_lootdrone.var_4342a8c408f9b538 ) );
    
    for ( x = bucketx - 1; x <= bucketx + 1 ; x++ )
    {
        for ( y = buckety - 1; y <= buckety + 1 ; y++ )
        {
            var_d177f7ddc9a97a6f = var_e79621abdda9125f[ x ][ y ];
            
            foreach ( otherorigin in var_d177f7ddc9a97a6f )
            {
                delta = origin - otherorigin;
                distsq = delta[ 0 ] * delta[ 0 ] + delta[ 1 ] * delta[ 1 ];
                
                if ( distsq <= level.br_lootdrone.var_1a0b2eaf0ac587f9 )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0xacd3a6e7, Offset: 0x641b
// Size: 0x3c, Type: bool
function private function_a0b4734bc08cf51c( var_e79621abdda9125f, origin )
{
    if ( function_91cee772bae87cb0( var_e79621abdda9125f, origin ) )
    {
        return true;
    }
    
    if ( function_a0157bc1c1d94311( var_e79621abdda9125f, origin ) )
    {
        return true;
    }
    
    return function_76e38178f26c65b( var_e79621abdda9125f, origin );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x52951c49, Offset: 0x6460
// Size: 0x148
function private function_502a93d4d9a2ec16( var_e79621abdda9125f )
{
    cap = level.br_lootdrone.var_9faa4405618522ba;
    
    if ( cap <= 0 || !isdefined( var_e79621abdda9125f ) )
    {
        return;
    }
    
    var_fbf0f266b67de556 = [];
    
    foreach ( bucketx, bucketrows in var_e79621abdda9125f )
    {
        if ( !bucketrows )
        {
            continue;
        }
        
        foreach ( buckety, var_d177f7ddc9a97a6f in bucketrows )
        {
            if ( !var_d177f7ddc9a97a6f || var_d177f7ddc9a97a6f.size < cap )
            {
                continue;
            }
            
            if ( !isdefined( var_fbf0f266b67de556[ bucketx ] ) )
            {
                var_fbf0f266b67de556[ bucketx ] = [];
            }
            
            var_fbf0f266b67de556[ bucketx ][ buckety ] = 1;
        }
    }
    
    return var_fbf0f266b67de556;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x22181ff3, Offset: 0x65b1
// Size: 0x66, Type: bool
function private function_e9cfe3bea512e412( cache, var_fbf0f266b67de556 )
{
    if ( !var_fbf0f266b67de556 )
    {
        return false;
    }
    
    if ( !( isdefined( cache.var_8759d09803cadaf3 ) && isdefined( cache.var_8759cf9803cad8c0 ) ) )
    {
        function_9cd34f662e07096a( cache );
    }
    
    if ( !var_fbf0f266b67de556[ cache.var_8759d09803cadaf3 ][ cache.var_8759cf9803cad8c0 ] )
    {
        return false;
    }
    
    return true;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x93eebb99, Offset: 0x6620
// Size: 0x66, Type: bool
function private function_a0157bc1c1d94311( var_e79621abdda9125f, origin )
{
    cap = level.br_lootdrone.var_9faa4405618522ba;
    
    if ( cap <= 0 || !isdefined( var_e79621abdda9125f ) )
    {
        return false;
    }
    
    var_d177f7ddc9a97a6f = function_540640d9c028fe2e( var_e79621abdda9125f, origin );
    
    if ( !var_d177f7ddc9a97a6f )
    {
        return false;
    }
    
    return var_d177f7ddc9a97a6f.size >= cap;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x2065ac51, Offset: 0x668f
// Size: 0x5e
function private function_4495facefc97c1f4()
{
    if ( !level.br_lootdrone.var_d7e91e356bf9ca50.size )
    {
        return;
    }
    
    circleindex = level.br_circle.circleindex ?? 0;
    
    if ( circleindex < 0 )
    {
        circleindex = 0;
    }
    
    return level.br_lootdrone.var_d7e91e356bf9ca50[ circleindex ];
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xa30476ca, Offset: 0x66f6
// Size: 0xa9
function private function_a1b0523a56428e23()
{
    waveconfig = function_4495facefc97c1f4();
    
    if ( !waveconfig )
    {
        return 0;
    }
    
    cachecount = level.br_lootdrone.var_f5dec3101007d7d3;
    
    if ( !isdefined( cachecount ) || cachecount <= 0 )
    {
        cachecount = level.br_lootdrone.var_4fdb5d4e04369f12;
    }
    
    capacity = int( cachecount * waveconfig.var_69784703cedf97fb );
    
    if ( capacity > level.br_lootdrone.var_4fdb5d4e04369f12 )
    {
        capacity = level.br_lootdrone.var_4fdb5d4e04369f12;
    }
    
    return capacity;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xfad82cda, Offset: 0x67a8
// Size: 0x3f
function private function_10c6494784474a39()
{
    if ( !isdefined( level.package_airdrop ) || !isdefined( level.package_airdrop.var_ced97a3033b9b333 ) )
    {
        return 0;
    }
    
    return level.package_airdrop.var_ced97a3033b9b333.size;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xc9d53bc3, Offset: 0x67f0
// Size: 0x1e6
function private function_6b9b658e96f68cef()
{
    level.br_lootdrone.var_340abdec1ac395cf = [];
    level.br_lootdrone.var_fe51fd23308b87ed = 0;
    weights = level.br_lootdrone.var_82171b46b24d6333;
    
    if ( !isdefined( weights ) )
    {
        return;
    }
    
    totalweight = 0;
    
    foreach ( cacheairdrop, weight in weights )
    {
        if ( weight <= 0 )
        {
            continue;
        }
        
        cacheconversion = undefined;
        
        foreach ( candidate in level.br_lootdrone.var_803f0a47efa17f45 )
        {
            if ( candidate.cacheairdrop == cacheairdrop )
            {
                cacheconversion = candidate;
                break;
            }
        }
        
        if ( !cacheconversion )
        {
            continue;
        }
        
        totalweight += weight;
        entry = structcopy( cacheconversion );
        entry.weight = weight;
        entry.cumulative = totalweight;
        level.br_lootdrone.var_340abdec1ac395cf[ level.br_lootdrone.var_340abdec1ac395cf.size ] = entry;
    }
    
    level.br_lootdrone.var_fe51fd23308b87ed = totalweight;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xe7107106, Offset: 0x69de
// Size: 0x14b
function private function_e7d8b955ac9f90f3()
{
    level.br_lootdrone.var_340abdec1ac395cf = [];
    level.br_lootdrone.var_fe51fd23308b87ed = 0;
    totalweight = 0;
    
    foreach ( cacheconversion in level.br_lootdrone.var_803f0a47efa17f45 )
    {
        if ( !( cacheconversion.var_df182d199a9a16b6 > 0 ) )
        {
            continue;
        }
        
        totalweight += cacheconversion.var_df182d199a9a16b6;
        entry = structcopy( cacheconversion );
        entry.weight = cacheconversion.var_df182d199a9a16b6;
        entry.cumulative = totalweight;
        level.br_lootdrone.var_340abdec1ac395cf[ level.br_lootdrone.var_340abdec1ac395cf.size ] = entry;
    }
    
    level.br_lootdrone.var_fe51fd23308b87ed = totalweight;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x83976f3b, Offset: 0x6b31
// Size: 0x11b
function private function_1dee761b84dadda0()
{
    entries = level.br_lootdrone.var_765bc259fc4ff49f;
    totalweight = level.br_lootdrone.var_d28b4351589a191d;
    
    if ( !entries.size || totalweight <= 0 )
    {
        return;
    }
    
    bestindex = undefined;
    var_7caab3c2b392b7c8 = undefined;
    
    for ( i = 0; i < entries.size ; i++ )
    {
        weight = entries[ i ].weight;
        
        if ( weight <= 0 )
        {
            continue;
        }
        
        entries[ i ].currentweight += weight;
        
        if ( !isdefined( bestindex ) || entries[ i ].currentweight > var_7caab3c2b392b7c8 )
        {
            bestindex = i;
            var_7caab3c2b392b7c8 = entries[ i ].currentweight;
        }
    }
    
    if ( !isdefined( bestindex ) )
    {
        return;
    }
    
    entries[ bestindex ].currentweight -= totalweight;
    return entries[ bestindex ];
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xaaa8269c, Offset: 0x6c55
// Size: 0x115
function private function_8020d36317d0f0f5( poientry )
{
    entries = poientry.airdropentries;
    totalweight = poientry.var_2377e6b44abb7b9f;
    
    if ( !entries.size || totalweight <= 0 )
    {
        return;
    }
    
    bestindex = undefined;
    var_7caab3c2b392b7c8 = undefined;
    
    for ( i = 0; i < entries.size ; i++ )
    {
        weight = entries[ i ].weight;
        
        if ( weight <= 0 )
        {
            continue;
        }
        
        entries[ i ].currentweight += weight;
        
        if ( !isdefined( bestindex ) || entries[ i ].currentweight > var_7caab3c2b392b7c8 )
        {
            bestindex = i;
            var_7caab3c2b392b7c8 = entries[ i ].currentweight;
        }
    }
    
    if ( !isdefined( bestindex ) )
    {
        return;
    }
    
    entries[ bestindex ].currentweight -= totalweight;
    return entries[ bestindex ];
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x4d6cb26e, Offset: 0x6d73
// Size: 0x24f
function private function_d1701a08082be85b( var_e79621abdda9125f )
{
    dangerorigin = br_circle::getdangercircleorigin();
    dangerradius = br_circle::getdangercircleradius();
    
    if ( !isdefined( dangerorigin ) || dangerradius <= 0 )
    {
        return;
    }
    
    var_b67a29fd754f5bbb = dangerradius * dangerradius;
    poientries = level.br_lootdrone.var_765bc259fc4ff49f;
    maxattempts = max( 1, poientries.size * 2 );
    
    for ( poiattempt = 0; poiattempt < maxattempts ; poiattempt++ )
    {
        poientry = function_1dee761b84dadda0();
        
        if ( !isdefined( poientry ) )
        {
            break;
        }
        
        cacheconversion = function_8020d36317d0f0f5( poientry );
        
        if ( !( isdefined( cacheconversion ) && isdefined( poientry.origin ) ) )
        {
            continue;
        }
        
        for ( attempt = 0; attempt < 8 ; attempt++ )
        {
            candidate = utility::function_7afe366c29a77c34( poientry.origin, poientry.spawnradius );
            
            if ( !isdefined( candidate ) )
            {
                candidate = poientry.origin;
            }
            
            delta = candidate - dangerorigin;
            distsq = delta[ 0 ] * delta[ 0 ] + delta[ 1 ] * delta[ 1 ];
            
            if ( distsq > var_b67a29fd754f5bbb || function_a0b4734bc08cf51c( var_e79621abdda9125f, candidate ) )
            {
                continue;
            }
            
            return { #droporigin:candidate, #cacheconversion:cacheconversion };
        }
        
        delta = poientry.origin - dangerorigin;
        distsq = delta[ 0 ] * delta[ 0 ] + delta[ 1 ] * delta[ 1 ];
        
        if ( distsq <= var_b67a29fd754f5bbb && !function_a0b4734bc08cf51c( var_e79621abdda9125f, poientry.origin ) )
        {
            return { #droporigin:poientry.origin, #cacheconversion:cacheconversion };
        }
    }
    
    cacheconversion = function_3e3199bbd0985511();
    
    if ( !cacheconversion )
    {
        return;
    }
    
    for ( attempt = 0; attempt < 8 ; attempt++ )
    {
        candidate = br_circle::getrandompointinboundscircle( dangerorigin, dangerradius, 0, 0.95, 1, 1, 1 );
        
        if ( isdefined( candidate ) && !function_a0b4734bc08cf51c( var_e79621abdda9125f, candidate ) )
        {
            return { #droporigin:candidate, #cacheconversion:cacheconversion };
        }
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x1bcef5fb, Offset: 0x6fcb
// Size: 0xe1
function private function_3e3199bbd0985511()
{
    entries = level.br_lootdrone.var_340abdec1ac395cf;
    totalweight = level.br_lootdrone.var_fe51fd23308b87ed;
    
    if ( !entries.size || totalweight <= 0 )
    {
        return;
    }
    
    roll = randomfloat( totalweight );
    
    foreach ( entry in entries )
    {
        if ( roll < entry.cumulative )
        {
            return entry;
        }
    }
    
    return entries[ entries.size - 1 ];
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x29c34f4f, Offset: 0x70b5
// Size: 0xc5
function private function_5439b0412c92199( var_e79621abdda9125f, players )
{
    if ( !level.br_lootdrone.var_a0f20434e13b93ef.size )
    {
        return 0;
    }
    
    var_d2de7b546853c213 = function_bae9f8459ee88891();
    var_fbf0f266b67de556 = function_502a93d4d9a2ec16( var_e79621abdda9125f );
    
    if ( !level.br_lootdrone.var_a0f20434e13b93ef.size )
    {
        return 0;
    }
    
    if ( !var_d2de7b546853c213.validcaches.size && ( !level.br_lootdrone.var_116a7891549bb55f || !var_d2de7b546853c213.gascaches.size ) )
    {
        return 0;
    }
    
    if ( function_ad19a9fbcd64192c() )
    {
        return function_497c07a4849f654f( var_d2de7b546853c213, var_fbf0f266b67de556 );
    }
    
    return function_786f1babf41a6138( var_d2de7b546853c213, var_fbf0f266b67de556, players );
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x4f13291a, Offset: 0x7183
// Size: 0xc5, Type: bool
function private function_497c07a4849f654f( var_d2de7b546853c213, var_fbf0f266b67de556 )
{
    hotzoneanchors = function_243a6b4273ef2db2();
    
    if ( !hotzoneanchors.size )
    {
        return false;
    }
    
    anchor = function_cfe41de25243345f( hotzoneanchors, level.br_lootdrone.var_b7190431ef7d0288.rrindex );
    var_9d082406e9208956 = getdvarfloat( @"hash_464a38937b47641e", 20000 );
    var_2d3b32b98aa69fc5 = level.br_lootdrone.var_4e91e5f74d569143;
    deployedcache = function_b291647086b54f0d( anchor.origin, var_d2de7b546853c213, var_fbf0f266b67de556, var_9d082406e9208956, anchor.origin, var_2d3b32b98aa69fc5 );
    return isdefined( deployedcache );
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0xb7ca95bc, Offset: 0x7251
// Size: 0x144, Type: bool
function private function_786f1babf41a6138( var_d2de7b546853c213, var_fbf0f266b67de556, players )
{
    foreach ( player in players )
    {
        if ( !player || !player player::isreallyalive() || player br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        if ( !level.br_lootdrone.var_a06e5acbe3e22e4f && var_d2de7b546853c213.circleindex != level.br_circle.circleindex )
        {
            var_d2de7b546853c213 = function_bae9f8459ee88891();
            
            if ( !var_d2de7b546853c213.validcaches.size && ( !level.br_lootdrone.var_116a7891549bb55f || !var_d2de7b546853c213.gascaches.size ) )
            {
                return false;
            }
        }
        
        deployedcache = function_2c67fbd8bbe65582( player, var_d2de7b546853c213, var_fbf0f266b67de556 );
        
        if ( isdefined( deployedcache ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xb5488e59, Offset: 0x739e
// Size: 0x15
function private function_ad19a9fbcd64192c()
{
    return level.br_lootdrone.var_c441f7c1e627a7ec;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x204e1b3d, Offset: 0x73bc
// Size: 0x8f
function private function_6dbba3c1b8395c3f()
{
    level.br_lootdrone.var_c441f7c1e627a7ec = 0;
    
    if ( level.br_lootdrone.var_b24896085d43cca4 == 0 )
    {
        return;
    }
    
    if ( !function_e2a061fcb85d84b5().size )
    {
        return;
    }
    
    level.br_lootdrone.var_c441f7c1e627a7ec = 1;
    level.br_lootdrone.var_b7190431ef7d0288 = { #rrindex:0, #hotzonecount:-1, #circleindex:-1, #anchors:[] };
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xc0bd3cce, Offset: 0x7453
// Size: 0x235
function private function_243a6b4273ef2db2()
{
    if ( level.br_lootdrone.var_b24896085d43cca4 == 0 )
    {
        return [];
    }
    
    cache = level.br_lootdrone.var_b7190431ef7d0288;
    
    if ( !isdefined( cache ) )
    {
        return [];
    }
    
    hotzones = function_e2a061fcb85d84b5();
    circleindex = ( isdefined( level.br_circle ) ? level.br_circle.circleindex : undefined ) ?? -1;
    
    if ( cache.anchors.size && cache.circleindex == circleindex && cache.hotzonecount == hotzones.size )
    {
        return cache.anchors;
    }
    
    cache.anchors = [];
    cache.circleindex = circleindex;
    cache.hotzonecount = hotzones.size;
    
    foreach ( hotzone in hotzones )
    {
        hotzoneinfo = function_4e52a812b6d1d965( hotzone );
        
        if ( !isdefined( hotzoneinfo ) || !isdefined( hotzoneinfo.midpoint ) )
        {
            continue;
        }
        
        if ( isdefined( level.br_circle ) )
        {
            indanger = level.br_multi_circle_enabled ? br_circle_util::ispointinmulticircledanger( hotzoneinfo.midpoint, 0 ) : br_circle::function_52d62d96409e20b( hotzoneinfo.midpoint, 0 );
            
            if ( !indanger )
            {
                continue;
            }
        }
        
        anchor = { #var_5b110820daa2b673:0, #origin:hotzoneinfo.midpoint };
        cache.anchors[ cache.anchors.size ] = anchor;
    }
    
    function_5eedaba71cc417ed( cache.anchors );
    return cache.anchors;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x24736643, Offset: 0x7691
// Size: 0x13c
function private function_5eedaba71cc417ed( anchors )
{
    if ( !anchors.size || !isdefined( level.package_airdrop ) || !isdefined( level.package_airdrop.var_ced97a3033b9b333 ) )
    {
        return;
    }
    
    foreach ( drone in level.package_airdrop.var_ced97a3033b9b333 )
    {
        if ( !isdefined( drone ) )
        {
            continue;
        }
        
        drone.hotzoneanchor = undefined;
        
        if ( !function_6b61d90925d1b999( drone ) )
        {
            continue;
        }
        
        origin = drone.droplocation ?? drone.origin;
        
        if ( !isdefined( origin ) )
        {
            continue;
        }
        
        var_fbcdacbc86c740d4 = function_b21056d585c710d( anchors, origin );
        
        if ( !isdefined( var_fbcdacbc86c740d4 ) )
        {
            continue;
        }
        
        var_fbcdacbc86c740d4.var_5b110820daa2b673++;
        drone.hotzoneanchor = var_fbcdacbc86c740d4;
    }
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xc54df37d, Offset: 0x77d5
// Size: 0x45, Type: bool
function private function_6b61d90925d1b999( drone )
{
    if ( !isdefined( drone.airdropsettings ) )
    {
        return false;
    }
    
    if ( isdefined( drone.airdropsettings.extradata.var_60de57e0dd65d20a ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xbd469511, Offset: 0x7823
// Size: 0xac
function private function_78b989a66ff03a87( drone )
{
    if ( !function_ad19a9fbcd64192c() || !function_6b61d90925d1b999( drone ) )
    {
        return;
    }
    
    if ( isdefined( drone.hotzoneanchor ) )
    {
        return;
    }
    
    anchors = function_243a6b4273ef2db2();
    
    if ( !anchors.size )
    {
        return;
    }
    
    origin = drone.droplocation ?? drone.origin;
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    var_fbcdacbc86c740d4 = function_b21056d585c710d( anchors, origin );
    
    if ( !isdefined( var_fbcdacbc86c740d4 ) )
    {
        return;
    }
    
    var_fbcdacbc86c740d4.var_5b110820daa2b673++;
    drone.hotzoneanchor = var_fbcdacbc86c740d4;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xd3bc90ba, Offset: 0x78d7
// Size: 0x5b
function private function_1abf18bf223c796c( drone )
{
    if ( !isdefined( drone.hotzoneanchor ) )
    {
        return;
    }
    
    drone.hotzoneanchor.var_5b110820daa2b673 = max( 0, drone.hotzoneanchor.var_5b110820daa2b673 - 1 );
    drone.hotzoneanchor = undefined;
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x43748ad8, Offset: 0x793a
// Size: 0x80
function private function_cfe41de25243345f( anchors, rrindex )
{
    n = anchors.size;
    best = anchors[ rrindex % n ];
    
    for ( i = 1; i < n ; i++ )
    {
        candidate = anchors[ ( rrindex + i ) % n ];
        
        if ( candidate.var_5b110820daa2b673 < best.var_5b110820daa2b673 )
        {
            best = candidate;
        }
    }
    
    return best;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xc001ee5f, Offset: 0x79c3
// Size: 0x1d
function private function_e8027e7fecbe0826( player )
{
    return function_9617956bdd239a7e( player.origin );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x31902e72, Offset: 0x79e9
// Size: 0xb3
function private function_9617956bdd239a7e( anchororigin )
{
    radius = level.br_lootdrone.var_4079be14911ebeeb;
    
    if ( radius <= 0 )
    {
        return anchororigin;
    }
    
    for ( attempt = 0; attempt < 3 ; attempt++ )
    {
        angle = randomfloat( 360 );
        dist = randomfloat( radius );
        forward = anglestoforward( ( 0, angle, 0 ) );
        origin = anchororigin + forward * dist;
        
        if ( isdefined( level.br_circle ) && br_circle::function_6bf5d4e680297398( origin ) )
        {
            continue;
        }
        
        return origin;
    }
    
    return anchororigin;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xa68731c0, Offset: 0x7aa5
// Size: 0x79
function private function_c28d06b199db2de6()
{
    eligible = level.br_lootdrone.eligiblecaches;
    
    if ( isdefined( eligible ) && eligible.size > 0 )
    {
        return eligible[ randomint( eligible.size ) ].origin;
    }
    
    if ( level.br_circle.dangercircleent )
    {
        origin = br_circle::getrandompointincurrentcircle( 0, 0.9 );
        
        if ( isdefined( origin ) )
        {
            return origin;
        }
    }
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0xd0f247eb, Offset: 0x7b27
// Size: 0x118, Type: bool
function private function_79304a112265bf5e( var_f195f9a22747a577 = 0, var_e79621abdda9125f, players )
{
    if ( !level.br_lootdrone.var_16a9bf46776cd068 )
    {
        return false;
    }
    
    waveconfig = function_4495facefc97c1f4();
    
    if ( !waveconfig || !waveconfig.var_77b0055183dbee3c )
    {
        return false;
    }
    
    if ( var_f195f9a22747a577 )
    {
        var_ead591f2aece26fe = function_d1701a08082be85b( var_e79621abdda9125f );
        
        if ( !isdefined( var_ead591f2aece26fe ) )
        {
            return false;
        }
        
        cacheconversion = var_ead591f2aece26fe.cacheconversion;
        droporigin = var_ead591f2aece26fe.droporigin;
    }
    else
    {
        if ( !level.br_lootdrone.var_340abdec1ac395cf.size )
        {
            return false;
        }
        
        cacheconversion = function_3e3199bbd0985511();
        
        if ( !cacheconversion )
        {
            return false;
        }
        
        droporigin = function_1d4a700f3e00cf6a( 0, var_e79621abdda9125f, players );
        
        if ( !isdefined( droporigin ) )
        {
            return false;
        }
    }
    
    deploylootdrone( cacheconversion.cacheairdrop, cacheconversion, droporigin, undefined, 1 );
    function_d06224ddfe6dabbd( droporigin );
    return true;
}

// Namespace br_lootdrone
// Params 3, eflags: 0x4
// Checksum 0xc8012138, Offset: 0x7c48
// Size: 0x3f
function private function_1d4a700f3e00cf6a( var_f195f9a22747a577, var_e79621abdda9125f, players )
{
    if ( var_f195f9a22747a577 )
    {
        return;
    }
    
    if ( function_ad19a9fbcd64192c() )
    {
        return function_1eae6ae8776abbe9( var_e79621abdda9125f );
    }
    
    return function_dfd8c8ac91f8971e( var_e79621abdda9125f, players );
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xfdd2c474, Offset: 0x7c90
// Size: 0xce
function private function_1eae6ae8776abbe9( var_e79621abdda9125f )
{
    hotzoneanchors = function_243a6b4273ef2db2();
    
    if ( !hotzoneanchors.size )
    {
        return;
    }
    
    anchor = function_cfe41de25243345f( hotzoneanchors, level.br_lootdrone.var_b7190431ef7d0288.rrindex );
    maxattempts = 8;
    
    for ( attempt = 0; attempt < maxattempts ; attempt++ )
    {
        candidate = function_9617956bdd239a7e( anchor.origin );
        
        if ( isdefined( candidate ) && !function_a0b4734bc08cf51c( var_e79621abdda9125f, candidate ) )
        {
            return candidate;
        }
    }
    
    if ( !function_a0b4734bc08cf51c( var_e79621abdda9125f, anchor.origin ) )
    {
        return anchor.origin;
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x3e6bb4c0, Offset: 0x7d67
// Size: 0xed
function private function_dfd8c8ac91f8971e( var_e79621abdda9125f, players )
{
    maxattempts = 8;
    var_9ea26d90f77249b5 = min( players.size, 12 );
    
    for ( playerindex = 0; playerindex < var_9ea26d90f77249b5 ; playerindex++ )
    {
        player = players[ playerindex ];
        
        if ( !player || !player player::isreallyalive() || player br_public::isplayerinorgoingtogulag() || !player isonground() )
        {
            continue;
        }
        
        for ( attempt = 0; attempt < maxattempts ; attempt++ )
        {
            candidate = function_e8027e7fecbe0826( player );
            
            if ( isdefined( candidate ) && !function_a0b4734bc08cf51c( var_e79621abdda9125f, candidate ) )
            {
                return candidate;
            }
        }
        
        if ( !function_a0b4734bc08cf51c( var_e79621abdda9125f, player.origin ) )
        {
            return player.origin;
        }
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x747d4143, Offset: 0x7e5d
// Size: 0x10d, Type: bool
function private function_5ada0b62fd0365b9( var_f195f9a22747a577 = 0, var_621a514974696df7 = 0 )
{
    capacity = function_a1b0523a56428e23();
    
    if ( capacity <= 0 )
    {
        return false;
    }
    
    if ( function_10c6494784474a39() >= capacity )
    {
        return false;
    }
    
    hotzonemode = function_ad19a9fbcd64192c();
    randomizedplayers = hotzonemode ? level.players : arrayrandomize( level.players );
    
    if ( hotzonemode && isdefined( level.br_lootdrone.var_b7190431ef7d0288 ) )
    {
        level.br_lootdrone.var_b7190431ef7d0288.rrindex++;
    }
    
    if ( !var_621a514974696df7 && !var_f195f9a22747a577 && function_5439b0412c92199( level.br_lootdrone.var_e79621abdda9125f, randomizedplayers ) )
    {
        return true;
    }
    
    return function_79304a112265bf5e( var_f195f9a22747a577, level.br_lootdrone.var_e79621abdda9125f, randomizedplayers );
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x9a43a098, Offset: 0x7f73
// Size: 0xa5
function private function_81cf52adec746213()
{
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    function_6dbba3c1b8395c3f();
    function_e7d8b955ac9f90f3();
    level.br_lootdrone.var_e79621abdda9125f = [];
    level.package_airdrop.var_3abdd882cee75b4f = &function_9da02b45dccaa087;
    level.package_airdrop.var_d3c29d521a5f9b9 = &function_a8ef5f61f916de7b;
    level.package_airdrop.var_ef017093c633eeef = &function_85c603bfb1f7e9b3;
    level.package_airdrop.var_9da990790d9b4759 = &function_1112a2648f0074d7;
    level thread function_f8aa1a8ffcfe2381();
    level thread function_47488d112bdd3c6c();
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x101c047f, Offset: 0x8020
// Size: 0x25
function private function_f8aa1a8ffcfe2381()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( #"br_lootdrone_init" );
    function_6b9b658e96f68cef();
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x4c409c79, Offset: 0x804d
// Size: 0x117
function private function_b75ee3e0c2cf22b3()
{
    flags::function_2f3408423ccc9b2e( #"br_lootdrone_init" );
    var_a0fdf97ee07c38d6 = level.br_lootdrone.var_4fdb5d4e04369f12 * 2;
    
    if ( function_ad19a9fbcd64192c() )
    {
        var_50793458c5e0f77d = gettime() + 60000;
        
        while ( gettime() < var_50793458c5e0f77d )
        {
            if ( !level.players.size )
            {
                wait 0.1;
                continue;
            }
            
            capacity = function_a1b0523a56428e23();
            
            if ( capacity > 0 && function_10c6494784474a39() >= capacity )
            {
                return;
            }
            
            function_5ada0b62fd0365b9();
            wait 0.1;
        }
        
        return;
    }
    
    for ( attempt = 0; attempt < var_a0fdf97ee07c38d6 ; attempt++ )
    {
        if ( !function_5ada0b62fd0365b9( 1, 1 ) )
        {
            break;
        }
        
        waitframe();
    }
    
    while ( !flags::gameflag( "br_ready_to_jump" ) )
    {
        wait randomfloatrange( level.br_lootdrone.var_9afd91952aa20502, level.br_lootdrone.var_9ada7b952a7b8ce8 );
        function_5ada0b62fd0365b9( 0, 1 );
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xabd5796b, Offset: 0x816c
// Size: 0x6f
function private function_fac66518f1a13154()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait randomfloatrange( level.br_lootdrone.var_9afd91952aa20502, level.br_lootdrone.var_9ada7b952a7b8ce8 );
        
        if ( !level.players.size )
        {
            continue;
        }
        
        if ( !function_5ada0b62fd0365b9() )
        {
            level utility::waittill_notify_or_timeout( #"hash_b725273b968f9756", 10 );
        }
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0xd9e878c4, Offset: 0x81e3
// Size: 0x23
function private function_7d58620b260f7beb()
{
    level endon( #"game_ended" );
    function_81cf52adec746213();
    function_b75ee3e0c2cf22b3();
    function_fac66518f1a13154();
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0xd45bf0cb, Offset: 0x820e
// Size: 0x9e
function private function_e3319882cb2cb1f8( airdropsettings )
{
    if ( airdropsettings.extradata.var_665ef687359d7f72 )
    {
        self.var_66d51ee8e331ef36 = gettime() + int( max( 0, level.br_lootdrone.var_d9a3e21b2f00c81c ) * 1000 );
        level.br_lootdrone.var_3750860b7dcf6c1b[ level.br_lootdrone.var_3750860b7dcf6c1b.size ] = self;
    }
    
    self.lootdroneobjective = self.sourcecache.lootdroneobjective;
}

// Namespace br_lootdrone
// Params 1, eflags: 0x4
// Checksum 0x6a493818, Offset: 0x82b4
// Size: 0x5a
function private function_ef629207eca04484( airdropsettings )
{
    if ( isdefined( self.lootdroneobjective.objid ) )
    {
        objidpoolmanager::returnobjectiveid( self.lootdroneobjective.objid );
        self.lootdroneobjective.objid = undefined;
        self.lootdroneobjective = undefined;
    }
}

// Namespace br_lootdrone
// Params 2, eflags: 0x4
// Checksum 0x1b7eb2bb, Offset: 0x8316
// Size: 0xcd, Type: bool
function private function_cd84abf494a6471( origin, radiussq )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        delta = player.origin - origin;
        distsq = delta[ 0 ] * delta[ 0 ] + delta[ 1 ] * delta[ 1 ];
        
        if ( distsq <= radiussq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x1a6078d9, Offset: 0x83ec
// Size: 0x3f5
function private function_47488d112bdd3c6c()
{
    level endon( #"game_ended" );
    
    if ( level.br_lootdrone.var_551666ea4ade92e3 <= 0 )
    {
        return;
    }
    
    if ( level.br_lootdrone.var_e1c40909b51b3ce8 <= 0 )
    {
        return;
    }
    
    radiussq = level.br_lootdrone.var_551666ea4ade92e3 * level.br_lootdrone.var_551666ea4ade92e3;
    
    while ( true )
    {
        wait level.br_lootdrone.var_e1c40909b51b3ce8;
        
        if ( !level.br_lootdrone.var_3750860b7dcf6c1b.size )
        {
            continue;
        }
        
        now = gettime();
        openedsafe = [];
        closedsafe = [];
        nearplayer = [];
        protected = [];
        
        foreach ( cache in level.br_lootdrone.var_3750860b7dcf6c1b )
        {
            if ( !isdefined( cache ) )
            {
                continue;
            }
            
            if ( now < ( cache.var_66d51ee8e331ef36 ?? 0 ) )
            {
                protected[ protected.size ] = cache;
                continue;
            }
            
            if ( function_cd84abf494a6471( cache.origin, radiussq ) )
            {
                nearplayer[ nearplayer.size ] = cache;
                continue;
            }
            
            if ( common_cache::cache_isopen( cache ) )
            {
                openedsafe[ openedsafe.size ] = cache;
                continue;
            }
            
            closedsafe[ closedsafe.size ] = cache;
        }
        
        foreach ( cache in openedsafe )
        {
            function_1112a2648f0074d7( cache );
            cache freescriptable();
            level.br_lootdrone.telemetry.var_caec3e8e99052b75++;
            level.br_lootdrone.telemetry.var_c321f05a95173c8++;
        }
        
        var_51eca224ca492f91 = nearplayer.size > 0 || protected.size > 0;
        
        if ( var_51eca224ca492f91 )
        {
            foreach ( cache in closedsafe )
            {
                function_1112a2648f0074d7( cache );
                cache freescriptable();
                level.br_lootdrone.telemetry.var_caec3e8e99052b75++;
                level.br_lootdrone.telemetry.var_a088f263f19a6fb1++;
            }
            
            level.br_lootdrone.var_3750860b7dcf6c1b = protected;
            
            foreach ( c in nearplayer )
            {
                level.br_lootdrone.var_3750860b7dcf6c1b[ level.br_lootdrone.var_3750860b7dcf6c1b.size ] = c;
            }
            
            continue;
        }
        
        level.br_lootdrone.var_3750860b7dcf6c1b = closedsafe;
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x3fbd1783, Offset: 0x87e9
// Size: 0x78
function private function_54195966887d048f()
{
    level endon( #"game_ended" );
    
    if ( !level.br_lootdrone.var_4ae010cf02bff2d8 )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    while ( level.br_lootdrone.var_7ee834b89b35f6e7.size - 1 > level.br_circle.circleindex )
    {
        level waittill( #"br_circle_set" );
        level thread function_73035b291dd66b31();
    }
}

// Namespace br_lootdrone
// Params 0, eflags: 0x4
// Checksum 0x7f70dfd3, Offset: 0x8869
// Size: 0x110
function private function_73035b291dd66b31()
{
    level endon( #"game_ended" );
    level endon( #"br_circle_set" );
    circleindex = level.br_circle.circleindex;
    Wave = level.br_lootdrone.var_7ee834b89b35f6e7[ circleindex ];
    
    if ( !Wave || Wave.count <= 0 )
    {
        return;
    }
    
    wait Wave.initialwaittime;
    var_71f8ed38c203e2d5 = Wave.count;
    
    while ( var_71f8ed38c203e2d5 > 0 )
    {
        randomizedplayers = arrayrandomize( level.players );
        droporigin = function_1d4a700f3e00cf6a( 0, level.br_lootdrone.var_e79621abdda9125f, randomizedplayers );
        
        if ( droporigin )
        {
            deploylootdrone( level.br_lootdrone.var_4ae010cf02bff2d8, undefined, droporigin );
            var_71f8ed38c203e2d5--;
            wait Wave.deployinterval;
            continue;
        }
        
        wait 2;
    }
}

/#

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0x2841b353, Offset: 0x8981
    // Size: 0xe6, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x33>", "<dev string:x53>", &function_ce7155b72bf176ab );
        devgui::add_devgui_func( "<dev string:x84>", "<dev string:xa3>", &function_269371993d9b001a );
        devgui::add_devgui_func( "<dev string:xd3>", "<dev string:xf2>", &function_d856cd21431672b );
        devgui::add_devgui_func( "<dev string:x122>", "<dev string:x142>", &function_bd8ad894f5b1455e );
        devgui::add_devgui_func( "<dev string:x173>", "<dev string:x197>", &function_d79ba6f4ea6b589f );
        devgui::add_devgui_func( "<dev string:x1be>", "<dev string:x1d1>", &function_cd636f0d89437516 );
        devgui::add_devgui_func( "<dev string:x1f5>", "<dev string:x20b>", &function_b68867196f62f56e );
        devgui::add_devgui_func( "<dev string:x227>", "<dev string:x240>", &function_221b4e1444bf9931 );
        devgui::add_devgui_func( "<dev string:x26a>", "<dev string:x286>", &function_f3c426cb23f91f0b );
        devgui::function_77df7fe7dd273e10();
        level thread function_2285dab5ea47a6f2();
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0xa0b8697f, Offset: 0x8a6f
    // Size: 0x8b, Type: dev
    function private function_cd636f0d89437516()
    {
        if ( !level.players.size )
        {
            return;
        }
        
        droporigin = level.players[ 0 ].origin;
        
        if ( !airdrop_scriptbundle::function_fa19528c206bd43( level.br_lootdrone.kioskairdrop ) )
        {
            function_520831d2effe8fe3();
        }
        
        br_deployable_kiosk::deployablekioskspawn( undefined, droporigin, 1, level.br_lootdrone.kioskairdrop, level.br_lootdrone.var_bc85d1d49753d773 );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0x100a710d, Offset: 0x8b02
    // Size: 0x5, Type: dev
    function private function_b68867196f62f56e()
    {
        
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0xe05ba8f5, Offset: 0x8b0f
    // Size: 0x10, Type: dev
    function private function_221b4e1444bf9931()
    {
        level thread function_5ada0b62fd0365b9( 0, 1 );
    }

    // Namespace br_lootdrone
    // Params 2, eflags: 0x4
    // Checksum 0x203cedf, Offset: 0x8b27
    // Size: 0xb5, Type: dev
    function private debug_drawcaches( caches, color )
    {
        while ( true )
        {
            foreach ( cache in caches )
            {
                line( cache.origin, cache.origin + ( 0, 0, 2000 ), color );
            }
            
            waitframe();
        }
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0xc
    // Checksum 0x45a6cbaf, Offset: 0x8be4
    // Size: 0x92, Type: dev
    function private function_ce7155b72bf176ab()
    {
        self notify( #"hash_d324b5397f2a2b8a" );
        self endon( #"hash_d324b5397f2a2b8a" );
        level endon( #"game_ended" );
        
        if ( level.br_lootdrone.var_75dc94e94a625af9 )
        {
            level.br_lootdrone.var_75dc94e94a625af9 = 0;
            return;
        }
        
        level.br_lootdrone.var_75dc94e94a625af9 = 1;
        debug_drawcaches( level.br_lootdrone.var_a0f20434e13b93ef, ( 0, 1, 0 ) );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0xc
    // Checksum 0xfbca900e, Offset: 0x8c7e
    // Size: 0x92, Type: dev
    function private function_269371993d9b001a()
    {
        self notify( #"hash_91865f0974ee01eb" );
        self endon( #"hash_91865f0974ee01eb" );
        level endon( #"game_ended" );
        
        if ( level.br_lootdrone.var_953e5b14fd1c8cec )
        {
            level.br_lootdrone.var_953e5b14fd1c8cec = 0;
            return;
        }
        
        level.br_lootdrone.var_953e5b14fd1c8cec = 1;
        debug_drawcaches( level.br_lootdrone.eligiblecaches, ( 0, 0, 1 ) );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0xc
    // Checksum 0x70f7f78d, Offset: 0x8d18
    // Size: 0x92, Type: dev
    function private function_d856cd21431672b()
    {
        self notify( #"hash_37204ada3faac0e3" );
        self endon( #"hash_37204ada3faac0e3" );
        level endon( #"game_ended" );
        
        if ( level.br_lootdrone.var_c09a273219de7e59 )
        {
            level.br_lootdrone.var_c09a273219de7e59 = 0;
            return;
        }
        
        level.br_lootdrone.var_c09a273219de7e59 = 1;
        debug_drawcaches( level.br_lootdrone.fallbackcaches, ( 1, 1, 0 ) );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0xc
    // Checksum 0x6ddc24fe, Offset: 0x8db2
    // Size: 0x92, Type: dev
    function private function_bd8ad894f5b1455e()
    {
        self notify( #"hash_1e8f70da02e1f07e" );
        self endon( #"hash_1e8f70da02e1f07e" );
        level endon( #"game_ended" );
        
        if ( level.br_lootdrone.var_afc91950e362af90 )
        {
            level.br_lootdrone.var_afc91950e362af90 = 0;
            return;
        }
        
        level.br_lootdrone.var_afc91950e362af90 = 1;
        debug_drawcaches( level.br_lootdrone.forbiddencaches, ( 1, 0, 0 ) );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0xc
    // Checksum 0xc9eeba8c, Offset: 0x8e4c
    // Size: 0x197, Type: dev
    function private function_d79ba6f4ea6b589f()
    {
        self notify( #"hash_aa63e95ab0087b8e" );
        self endon( #"hash_aa63e95ab0087b8e" );
        level endon( #"game_ended" );
        
        if ( !level.br_lootdrone.var_e4093ff943672adf.size )
        {
            return;
        }
        
        if ( level.br_lootdrone.var_154bf28aa758bece )
        {
            level.br_lootdrone.var_154bf28aa758bece = 0;
            return;
        }
        
        level.br_lootdrone.var_154bf28aa758bece = 1;
        
        while ( true )
        {
            foreach ( var_672add1fe20fc1b0 in level.br_lootdrone.var_e4093ff943672adf )
            {
                if ( var_672add1fe20fc1b0.radius <= 0 )
                {
                    continue;
                }
                
                bottom = ( var_672add1fe20fc1b0.x, var_672add1fe20fc1b0.y, -5000 );
                top = ( var_672add1fe20fc1b0.x, var_672add1fe20fc1b0.y, 5000 );
                cylinder( bottom, top, var_672add1fe20fc1b0.radius, ( 1, 0, 0 ) );
                line( bottom, top, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace br_lootdrone
    // Params 0
    // Checksum 0xb06fe8d7, Offset: 0x8feb
    // Size: 0xc4, Type: dev
    function function_f3c426cb23f91f0b()
    {
        player = level.players[ 0 ];
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        foreach ( conversion in level.br_lootdrone.var_803f0a47efa17f45 )
        {
            deploylootdrone( conversion.cacheairdrop, conversion, player.origin, 1000, 0, 1 );
            break;
        }
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0xa90b48b8, Offset: 0x90b7
    // Size: 0x10c, Type: dev
    function private function_2ef0c661403b3e66()
    {
        if ( isdefined( level.br_lootdrone.var_55fc4f81e721dc2c ) )
        {
            return level.br_lootdrone.var_55fc4f81e721dc2c;
        }
        
        map = [];
        
        foreach ( var_9fd3df857cee9123, conversion in level.br_lootdrone.var_803f0a47efa17f45 )
        {
            if ( isdefined( conversion.cacheairdrop ) )
            {
                map[ conversion.cacheairdrop ] = var_9fd3df857cee9123;
            }
            
            if ( isdefined( conversion.var_f038d32f67f47aa9 ) )
            {
                map[ conversion.var_f038d32f67f47aa9 ] = var_9fd3df857cee9123;
            }
        }
        
        level.br_lootdrone.var_55fc4f81e721dc2c = map;
        return map;
    }

    // Namespace br_lootdrone
    // Params 2, eflags: 0x4
    // Checksum 0x4148a367, Offset: 0x91cb
    // Size: 0x116, Type: dev
    function private function_2f19d41cb9e10379( drone, bucket )
    {
        if ( !isdefined( drone ) )
        {
            return;
        }
        
        if ( !isdefined( drone.airdropsettings ) )
        {
            return;
        }
        
        var_65e46284e2b92a8e = function_2ef0c661403b3e66();
        typekey = var_65e46284e2b92a8e[ drone.airdropsettings.airdropidentifier ];
        
        if ( !isdefined( typekey ) )
        {
            return;
        }
        
        if ( !isdefined( level.br_lootdrone.var_4e1b06ce3e5a4daa ) )
        {
            level.br_lootdrone.var_4e1b06ce3e5a4daa = [];
        }
        
        if ( !isdefined( level.br_lootdrone.var_4e1b06ce3e5a4daa[ typekey ] ) )
        {
            level.br_lootdrone.var_4e1b06ce3e5a4daa[ typekey ] = [];
        }
        
        if ( !isdefined( level.br_lootdrone.var_4e1b06ce3e5a4daa[ typekey ][ bucket ] ) )
        {
            level.br_lootdrone.var_4e1b06ce3e5a4daa[ typekey ][ bucket ] = 0;
        }
        
        level.br_lootdrone.var_4e1b06ce3e5a4daa[ typekey ][ bucket ]++;
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0xc56036f9, Offset: 0x92e9
    // Size: 0x4b0, Type: dev
    function private function_c97ddde8c1908a86()
    {
        var_65e46284e2b92a8e = function_2ef0c661403b3e66();
        stats = [];
        
        foreach ( var_9fd3df857cee9123, conversion in level.br_lootdrone.var_803f0a47efa17f45 )
        {
            stats[ var_9fd3df857cee9123 ] = { #eligibletotal:0, #converted:0, #remaining:0, #var_db24370bea224432:0, #destroyed:0, #dropped:0, #active:0 };
        }
        
        if ( isdefined( level.br_lootdrone.var_fe6cce5e2a4b0fe2 ) )
        {
            foreach ( cache in level.br_lootdrone.var_fe6cce5e2a4b0fe2 )
            {
                typekey = getxhash( cache.type );
                
                if ( isdefined( stats[ typekey ] ) )
                {
                    stats[ typekey ].eligibletotal++;
                }
            }
        }
        
        if ( isdefined( level.br_lootdrone.var_a0f20434e13b93ef ) )
        {
            foreach ( cache in level.br_lootdrone.var_a0f20434e13b93ef )
            {
                typekey = getxhash( cache.type );
                
                if ( isdefined( stats[ typekey ] ) )
                {
                    stats[ typekey ].remaining++;
                }
            }
        }
        
        foreach ( typekey, entry in stats )
        {
            entry.converted = entry.eligibletotal - entry.remaining;
        }
        
        if ( isdefined( level.package_airdrop ) && isdefined( level.package_airdrop.var_ced97a3033b9b333 ) )
        {
            foreach ( drone in level.package_airdrop.var_ced97a3033b9b333 )
            {
                if ( !isdefined( drone ) || !isdefined( drone.airdropsettings ) )
                {
                    continue;
                }
                
                typekey = var_65e46284e2b92a8e[ drone.airdropsettings.airdropidentifier ];
                
                if ( isdefined( typekey ) && isdefined( stats[ typekey ] ) )
                {
                    stats[ typekey ].active++;
                }
            }
        }
        
        var_2ac0c5f1817aa54b = level.br_lootdrone.var_4e1b06ce3e5a4daa;
        
        if ( isdefined( var_2ac0c5f1817aa54b ) )
        {
            foreach ( typekey, buckets in var_2ac0c5f1817aa54b )
            {
                if ( !isdefined( stats[ typekey ] ) )
                {
                    continue;
                }
                
                stats[ typekey ].dropped = buckets[ #"dropped" ] ?? 0;
                stats[ typekey ].destroyed = buckets[ #"destroyed" ] ?? 0;
                stats[ typekey ].var_db24370bea224432 = buckets[ #"hash_1763543050cd6745" ] ?? 0;
            }
        }
        
        return stats;
    }

    // Namespace br_lootdrone
    // Params 1, eflags: 0x4
    // Checksum 0x83295a97, Offset: 0x97a1
    // Size: 0x19b, Type: dev
    function private function_e4ba689eb69e8c6c( stats )
    {
        text = "<dev string:x2b3>";
        
        foreach ( typekey, entry in stats )
        {
            name = getxhashsourcename( typekey ) ?? "<dev string:x30c>" + typekey;
            text += "<dev string:x30d>" + name + "<dev string:x311>" + entry.active + "<dev string:x316>" + entry.dropped + "<dev string:x31c>" + entry.destroyed + "<dev string:x322>" + entry.var_db24370bea224432 + "<dev string:x328>" + entry.remaining + "<dev string:x332>" + entry.converted;
        }
        
        airbornetotal = isdefined( level.package_airdrop ) && isdefined( level.package_airdrop.var_ced97a3033b9b333 ) ? level.package_airdrop.var_ced97a3033b9b333.size : 0;
        text += "<dev string:x338>" + airbornetotal + "<dev string:x34e>" + ( level.br_lootdrone.var_4fdb5d4e04369f12 ?? 0 );
        text += function_d2f3991c7c2fce4d();
        return text;
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0x3b0e0d59, Offset: 0x9944
    // Size: 0x3bf, Type: dev
    function private function_d2f3991c7c2fce4d()
    {
        text = "<dev string:x30c>";
        circlewaves = level.br_lootdrone.var_d7e91e356bf9ca50;
        explosivewaves = level.br_lootdrone.var_7ee834b89b35f6e7;
        totalcaches = level.br_lootdrone.var_f5dec3101007d7d3 ?? 0;
        var_1a014a2713d14ca4 = level.br_lootdrone.var_c34a04f3770c2345 ?? 0;
        remainingbudget = max( 0, totalcaches - var_1a014a2713d14ca4 );
        currentcircle = isdefined( level.br_circle ) ? level.br_circle.circleindex ?? 0 : 0;
        text += "<dev string:x35a>" + var_1a014a2713d14ca4 + "<dev string:x377>" + totalcaches + "<dev string:x37b>" + remainingbudget + "<dev string:x38b>";
        
        if ( isdefined( circlewaves ) && circlewaves.size )
        {
            var_a939b2cca9eb639e = currentcircle >= 0 && currentcircle < circlewaves.size ? circlewaves[ currentcircle ] : undefined;
            
            if ( isdefined( var_a939b2cca9eb639e ) )
            {
                currentrelease = int( totalcaches * ( var_a939b2cca9eb639e.var_69784703cedf97fb ?? 0 ) );
                currentcap = function_a1b0523a56428e23();
                fillerflag = var_a939b2cca9eb639e.var_77b0055183dbee3c ? "<dev string:x38d>" : "<dev string:x397>";
                text += "<dev string:x3a2>" + currentcircle + "<dev string:x3ad>" + currentcap + "<dev string:x3bb>" + currentrelease + "<dev string:x3c6>" + int( ( var_a939b2cca9eb639e.var_69784703cedf97fb ?? 0 ) * 100 ) + "<dev string:x3ca>" + fillerflag;
            }
            else
            {
                text += "<dev string:x3a2>" + currentcircle + "<dev string:x3cf>";
            }
            
            text += "<dev string:x3e4>";
            previewmax = min( circlewaves.size, currentcircle + 4 );
            anypreview = 0;
            
            for ( idx = currentcircle + 1; idx < previewmax ; idx++ )
            {
                preview = circlewaves[ idx ];
                
                if ( !isdefined( preview ) )
                {
                    continue;
                }
                
                anypreview = 1;
                pctrelease = int( totalcaches * ( preview.var_69784703cedf97fb ?? 0 ) );
                text += "<dev string:x3f7>" + idx + "<dev string:x3fe>" + pctrelease + "<dev string:x3c6>" + int( ( preview.var_69784703cedf97fb ?? 0 ) * 100 ) + "<dev string:x409>" + ( preview.var_77b0055183dbee3c ? "<dev string:x40c>" : "<dev string:x30c>" );
            }
            
            if ( !anypreview )
            {
                text += "<dev string:x415>";
            }
        }
        
        if ( isdefined( explosivewaves ) && explosivewaves.size )
        {
            text += "<dev string:x421>";
            anyexpl = 0;
            previewmax = min( explosivewaves.size, currentcircle + 4 );
            
            for ( idx = currentcircle; idx < previewmax ; idx++ )
            {
                Wave = explosivewaves[ idx ];
                
                if ( !isdefined( Wave ) || ( Wave.var_3eab3f0f898543f1 ?? 0 ) <= 0 )
                {
                    continue;
                }
                
                anyexpl = 1;
                text += "<dev string:x3f7>" + idx + "<dev string:x43a>" + ( Wave.countmin ?? 0 ) + "<dev string:x43d>" + ( Wave.var_3eab3f0f898543f1 ?? 0 ) + "<dev string:x43f>" + ( Wave.initialwaittime ?? 0 ) + "<dev string:x447>" + "<dev string:x449>" + ( Wave.deployinterval ?? 0 ) + "<dev string:x447>";
            }
            
            if ( !anyexpl )
            {
                text += "<dev string:x415>";
            }
        }
        
        return text;
    }

    // Namespace br_lootdrone
    // Params 2, eflags: 0x4
    // Checksum 0x3e25d973, Offset: 0x9d0b
    // Size: 0xa8, Type: dev
    function private function_6f0b4fa67e197a87( text, visible )
    {
        if ( !isdefined( self.var_7b451602197db9ec ) )
        {
            if ( !visible )
            {
                return;
            }
            
            self.var_7b451602197db9ec = hud_util::createfontstring( "<dev string:x452>", 1.2 );
            self.var_7b451602197db9ec hud_util::setpoint( "<dev string:x45a>", "<dev string:x45a>", 20, 140 );
            self.var_7b451602197db9ec.hidewheninmenu = 0;
        }
        
        self.var_7b451602197db9ec.alpha = visible ? 1 : 0;
        self.var_7b451602197db9ec setdevtext( text );
    }

    // Namespace br_lootdrone
    // Params 0, eflags: 0x4
    // Checksum 0xdea05429, Offset: 0x9dbb
    // Size: 0x181, Type: dev
    function private function_2285dab5ea47a6f2()
    {
        level endon( #"game_ended" );
        flags::function_2f3408423ccc9b2e( #"br_lootdrone_init" );
        
        while ( true )
        {
            enabled = getdvarint( @"hash_763b13be421f88d", 0 ) == 1;
            
            if ( enabled )
            {
                stats = function_c97ddde8c1908a86();
                text = function_e4ba689eb69e8c6c( stats );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        player function_6f0b4fa67e197a87( text, 1 );
                    }
                }
            }
            else
            {
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) && isdefined( player.var_7b451602197db9ec ) )
                    {
                        player function_6f0b4fa67e197a87( "<dev string:x30c>", 0 );
                    }
                }
            }
            
            wait 0.5;
        }
    }

#/
