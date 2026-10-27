// script_7eab314a5c18ea10  (hash_7eab314a5c18ea10.gscc) (size: 16940 Bytes / 0x422c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfe26cff (3756158207)
// size ...... 16940 (0x422c)
// includes .. 14  (offset: 0x3a20)
// strings ... 0   (offset: 0x3a90)
// dev strs .. 156 (offset: 0x3a90)
// exports ... 63  (offset: 0x1f4c)
// cseg ...... 0x58 + 0x1ef4 (0x1f4c)
// imports ... 125 (offset: 0x2924)
// animtree1 . 0   (offset: 0x422c)
// animtree2 . 0   (offset: 0x422c)
#using script_1f139695c61f1549;
#using script_22aa38b6bedad90a;
#using script_6d60a2f06878900a;
#using script_7c98336d01c2aba2;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_nexus_debug;
#using scripts\common\activity_nexus\activity_player_common;
#using scripts\common\activity_nexus\activity_reward_cache_settings;
#using scripts\common\devgui;
#using scripts\common\rewards\managed_reward_cache;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_objective_rewards;

#namespace activity_rewards_debug;

/#

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x7ad32181, Offset: 0x76
    // Size: 0x13, Type: dev
    function function_37bf94fc2e69d250()
    {
        function_2d90c7cb4fe12cbe();
        thread function_539fcac0f48f3433();
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0x4c6820b8, Offset: 0x91
    // Size: 0x68b, Type: dev
    function private function_2d90c7cb4fe12cbe()
    {
        var_72a41c61e0a93ba7 = activity_nexus_debug::function_3a45e311cf4d30b7();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x2d>", "<dev string:x52>", &function_e8656cba8fa1a576, 1 );
        devgui::add_devgui_func( "<dev string:x6d>", "<dev string:x99>", &function_b4839a5dcce6f760, 1 );
        devgui::add_devgui_func( "<dev string:xc6>", "<dev string:xf7>", &function_383fc037d2588d21, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x115>" );
        devgui::add_devgui_func( "<dev string:x13d>", "<dev string:x16c>", &function_fa63975e9fa3c6e2 );
        devgui::add_devgui_func( "<dev string:x199>", "<dev string:x1b0>", &function_cd206dfaf5809c3f );
        devgui::add_devgui_func( "<dev string:x1d5>", "<dev string:x1ec>", &function_23c58e01fbace841 );
        devgui::add_devgui_func( "<dev string:x20a>", "<dev string:x224>", &function_42e7d450a571dc35 );
        devgui::add_devgui_func( "<dev string:x248>", "<dev string:x256>", &function_743b2df65ae54d48 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x270>" );
        devgui::add_devgui_func( "<dev string:x295>", "<dev string:x2c3>", &function_f3591229bdd73360, 1 );
        devgui::add_devgui_func( "<dev string:x2f6>", "<dev string:x31d>", &function_522f203d3c50634f, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x34b>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37f>", "<dev string:x39e>", &function_5e766cce47cda4ab, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d8>", "<dev string:x404>", &function_7966db88a6ab20d8, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x446>" );
        devgui::add_devgui_func( "<dev string:x46f>", "<dev string:x49b>", &function_eb5af31fa034dc46, 1 );
        devgui::add_devgui_func( "<dev string:x4bb>", "<dev string:x4e7>", &function_830a2426b2103cf1, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x50a>", "<dev string:x52b>" + "<dev string:x547>", &function_bef051b892ee1ef, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x55a>", "<dev string:x52b>" + "<dev string:x57d>", &function_bef051b892ee1ef, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x592>", "<dev string:x52b>" + "<dev string:x5b4>", &function_bef051b892ee1ef, 1 );
        devgui::add_devgui_func( "<dev string:x5c8>", "<dev string:x5fb>", &function_57313ec2a0ff627b, 1 );
        devgui::add_devgui_func( "<dev string:x620>", "<dev string:x650>", &function_147eab79daa9fbb7, 1 );
        devgui::add_devgui_func( "<dev string:x672>", "<dev string:x6a2>", &function_a886bd53a101cf5e, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x6c4>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6fa>", "<dev string:x719>" + 6, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x742>", "<dev string:x76a>" + 6, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x793>", "<dev string:x7bd>" + 6, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7ea>", "<dev string:x719>" + 7, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x807>", "<dev string:x76a>" + 7, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x82d>", "<dev string:x854>" + 7, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x883>", "<dev string:x719>" + 5, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8aa>", "<dev string:x76a>" + 5, &function_2457d1647905072e, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8da>", "<dev string:x90c>" + 5, &function_2457d1647905072e, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:x93c>" );
        devgui::add_devgui_func( "<dev string:x953>", "<dev string:x976>", &function_73110437a3a011cd );
        devgui::add_devgui_func( "<dev string:x98b>", "<dev string:x9a1>", &function_4db86b7230faf172 );
        devgui::add_devgui_func( "<dev string:x9b5>", "<dev string:x9cc>", &function_f64933ddb98cf19d );
        devgui::add_devgui_func( "<dev string:x9e0>", "<dev string:x9fb>", &function_377a573ec1dd63ac );
        devgui::add_devgui_func( "<dev string:xa13>", "<dev string:xa2c>", &function_1085e870f93bf51e );
        devgui::add_devgui_func( "<dev string:xa42>", "<dev string:xa5c>", &function_8b6f3042b0011650 );
        devgui::add_devgui_func( "<dev string:xa73>", "<dev string:xa89>", &function_f6c824760e4ae0bc );
        devgui::add_devgui_func( "<dev string:xa9c>", "<dev string:xabd>", &function_289bef8d4a609e41 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xada>" );
        devgui::add_devgui_func( "<dev string:xb08>", "<dev string:xb33>", &function_ebca84269a1a1853 );
        devgui::add_devgui_func( "<dev string:xb57>", "<dev string:xb83>", &function_777216edc62712 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xba8>" );
        devgui::add_devgui_func( "<dev string:xbe9>", "<dev string:xc16>", &function_38f1469c85122db5 );
        devgui::add_devgui_func( "<dev string:xc3e>", "<dev string:xc6c>", &function_c845662f25e208b8 );
        devgui::add_devgui_func( "<dev string:xc95>", "<dev string:xcc3>", &function_e43c9d86f98d7b4e );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xcd9>" );
        devgui::add_devgui_func( "<dev string:xd30>", "<dev string:xd47>", &function_602b9d890a17244c );
        devgui::add_devgui_func( "<dev string:xd5e>", "<dev string:xd76>", &function_6210e2d299e78fff );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xd8e>" );
        devgui::add_devgui_func( "<dev string:xdee>", "<dev string:xe03>", &function_59d621d6c5e0cf07 );
        devgui::add_devgui_func( "<dev string:xe25>", "<dev string:xe39>", &function_43e0524f031d41ba );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xe5c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xec0>", "<dev string:xec6>", &function_8330311531e04e2a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xee2>", "<dev string:xee6>", &function_8330311531e04e2a );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf00>", "<dev string:xf04>", &function_8330311531e04e2a );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xf1e>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xec0>", "<dev string:xf74>", &function_6d8fcb7e9e9b8beb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf8e>", "<dev string:xf91>", &function_6d8fcb7e9e9b8beb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xee2>", "<dev string:xfa8>", &function_6d8fcb7e9e9b8beb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfc0>", "<dev string:xfc4>", &function_6d8fcb7e9e9b8beb );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_72a41c61e0a93ba7 + "<dev string:xfdc>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xec0>", "<dev string:x103f>", &function_ecd4632bc014410c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x105d>", "<dev string:x1060>", &function_ecd4632bc014410c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x107b>", "<dev string:x107e>", &function_ecd4632bc014410c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1099>", "<dev string:x109c>", &function_ecd4632bc014410c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x8e195e7e, Offset: 0x724
    // Size: 0x13a, Type: dev
    function function_2457d1647905072e( params )
    {
        option = params[ 0 ];
        activityfunctiontype = int( params[ 1 ] );
        var_2c4242b9625516f4 = undefined;
        
        switch ( option )
        {
            case #"hash_7038dec66d8275be":
                var_2c4242b9625516f4 = activity_common::function_c18ae2ea1e9c715a( activityfunctiontype );
                break;
            case #"hash_f43afb7b1b11f010":
                var_2c4242b9625516f4 = &function_8d0ebd3506cef629;
                break;
            case #"hash_bb5bf3da71cceeb6":
                var_2c4242b9625516f4 = &function_45be2c33b431c762;
                break;
            case #"hash_30f1c77a303828ff":
                var_2c4242b9625516f4 = &function_f8f189d9bbbf9d47;
                break;
            case #"hash_16ce513c547213e7":
                var_2c4242b9625516f4 = &function_82db377dc4eafa73;
                break;
            default:
                break;
        }
        
        if ( !isdefined( var_2c4242b9625516f4 ) )
        {
            return;
        }
        
        instance = activity_player_common::function_e811448130016c90( level.player );
        
        if ( !isdefined( instance ) )
        {
            iprintlnbold( "<dev string:x10f0>" );
            return;
        }
        
        activitytype = instance.type;
        activity_common::function_944074f3079c1d4e( activitytype, activityfunctiontype, var_2c4242b9625516f4 );
        
        if ( option == "<dev string:x10b7>" )
        {
            iprintln( "<dev string:x112c>" );
            return;
        }
        
        iprintln( "<dev string:x1144>" );
    }

    // Namespace activity_rewards_debug
    // Params 1, eflags: 0x4
    // Checksum 0xe7f35235, Offset: 0x866
    // Size: 0x10, Type: dev
    function private function_8d0ebd3506cef629( lootfunctionargs )
    {
                return;
    }

    // Namespace activity_rewards_debug
    // Params 1, eflags: 0x4
    // Checksum 0x8ec3bf2d, Offset: 0x87e
    // Size: 0x24, Type: dev
    function private function_45be2c33b431c762( relevantinfostruct )
    {
        group = [];
        return [ group ];
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0xdcd65b76, Offset: 0x8aa
    // Size: 0x8f, Type: dev
    function private function_f8f189d9bbbf9d47()
    {
        activityinstance = self;
        cache = spawnstruct();
        activityinstance ob_objective_rewards::function_f87ed5526b8f404e( cache );
        contents = [];
        contents[ 0 ] = structcopy( cache.contents[ 0 ] );
        contents[ 1 ] = structcopy( cache.contents[ 0 ] );
        contents[ 2 ] = structcopy( cache.contents[ 0 ] );
        contents[ 3 ] = structcopy( cache.contents[ 0 ] );
        return contents;
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0x260271c8, Offset: 0x941
    // Size: 0xc, Type: dev
    function private function_82db377dc4eafa73()
    {
        return function_ddbf014dc558210a();
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x24d9580c, Offset: 0x955
    // Size: 0x4c, Type: dev
    function function_e8656cba8fa1a576()
    {
        rewardgroup = [ level.players[ 0 ] ];
        rewardgroups = [ rewardgroup ];
        placement = function_ddbf014dc558210a();
        function_55a2441b33d2c709( rewardgroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x3d57fd07, Offset: 0x9a9
    // Size: 0x4e, Type: dev
    function function_b4839a5dcce6f760()
    {
        rewardgroup = [ level.players[ 0 ] ];
        rewardgroups = [ rewardgroup ];
        placement = function_ddbf014dc558210a();
        function_55a2441b33d2c709( rewardgroups, placement, 1 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x59760614, Offset: 0x9ff
    // Size: 0x3d, Type: dev
    function function_383fc037d2588d21()
    {
        rewardgroup = [];
        rewardgroups = [ rewardgroup ];
        placement = function_ddbf014dc558210a();
        function_55a2441b33d2c709( rewardgroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0xabba184a, Offset: 0xa44
    // Size: 0x68, Type: dev
    function private function_ddbf014dc558210a()
    {
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin + ( 100, 0, 0 );
        placement.angles = level.players[ 0 ].angles;
        return placement;
    }

    // Namespace activity_rewards_debug
    // Params 1, eflags: 0x4
    // Checksum 0x22923611, Offset: 0xab4
    // Size: 0x34, Type: dev
    function private function_89a3b2e2301f3295( args )
    {
        cache = spawnstruct();
        ob_objective_rewards::function_f87ed5526b8f404e( cache );
        return cache.contents;
    }

    // Namespace activity_rewards_debug
    // Params 3
    // Checksum 0x5d9edd30, Offset: 0xaf0
    // Size: 0xda, Type: dev
    function function_55a2441b33d2c709( playergroups, placementstruct, var_60cc857583fbaebd )
    {
        var_d0c176d485a082a1 = getscriptbundle( hashcat( %"hash_3e3429260ba62549", "<dev string:x1161>" ) );
        [ var_7554a9bf01e8208d ] = namespace_191965e8dea0924e::function_b493dffc6327a910( var_d0c176d485a082a1 );
        var_432c429a1da97791 = activity_reward_cache_settings::function_f9ff18532030ae0c( var_7554a9bf01e8208d );
        
        if ( var_60cc857583fbaebd ?? 0 )
        {
            rewardcachebehaviorsettings = namespace_15dfbdeb8b2ff6b9::function_7d96f9640c446bd3( undefined );
        }
        else
        {
            rewardcachebehaviorsettings = activity_reward_cache_settings::function_c1dc1aba345d5b69( var_432c429a1da97791 );
        }
        
        rewardcachesettings = activity_reward_cache_settings::function_673370ae370746f7( var_432c429a1da97791 );
        func_openlootablecontainer = &ob_activity_rewards::ob_openlootablecontainer;
        var_c74a1c6030ca10fb = &function_89a3b2e2301f3295;
        managed_reward_cache::function_62e1e9e8ae541941( rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xb48f7bc4, Offset: 0xbd2
    // Size: 0x7a, Type: dev
    function function_fa63975e9fa3c6e2()
    {
        if ( isdefined( level.var_fe1d7fc62c065b0c ) )
        {
            managed_reward_cache::function_91dcd938272d2758( level.var_fe1d7fc62c065b0c );
            managed_reward_cache::function_c14ca9c329a7c858( level.var_fe1d7fc62c065b0c );
            waitframe();
        }
        
        var_6efee5c18b946049 = function_121044c6586df39();
        var_6efee5c18b946049 waittill( #"hash_db90bb68b59b48ea", var_3ab87c2a4d08d389 );
        level.var_fe1d7fc62c065b0c = var_3ab87c2a4d08d389;
        thread function_cc0b22d6994c7f92( var_3ab87c2a4d08d389 );
        managed_reward_cache::function_6c4b2bdaa921d609( var_3ab87c2a4d08d389 );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x628749a0, Offset: 0xc54
    // Size: 0x36, Type: dev
    function function_cc0b22d6994c7f92( managedrewardcache )
    {
        managedrewardcache waittill( #"managed_reward_cache_despawned" );
        
        if ( level.var_fe1d7fc62c065b0c == managedrewardcache )
        {
            level.var_fe1d7fc62c065b0c = undefined;
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x99055c24, Offset: 0xc92
    // Size: 0x22, Type: dev
    function function_cd206dfaf5809c3f()
    {
        if ( isdefined( level.var_fe1d7fc62c065b0c ) )
        {
            managed_reward_cache::function_91dcd938272d2758( level.var_fe1d7fc62c065b0c );
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xd5626fea, Offset: 0xcbc
    // Size: 0x69, Type: dev
    function function_743b2df65ae54d48()
    {
        if ( isdefined( level.var_fe1d7fc62c065b0c ) )
        {
            cache = spawnstruct();
            items = common_item::items_selectfromlist( "<dev string:x1175>", 1 );
            ob_objective_rewards::function_98861c0455f4e01f( items, cache );
            managed_reward_cache::function_53efe036928052e8( level.var_fe1d7fc62c065b0c, level.players[ 0 ], cache.contents );
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xd0367be, Offset: 0xd2d
    // Size: 0x35, Type: dev
    function function_23c58e01fbace841()
    {
        if ( isdefined( level.var_fe1d7fc62c065b0c ) )
        {
            level.var_e917e0cf6a259c11 = managed_reward_cache::function_5faff0392b13a93f( level.var_fe1d7fc62c065b0c, level.players[ 0 ] );
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x8e218595, Offset: 0xd6a
    // Size: 0xaf, Type: dev
    function function_42e7d450a571dc35()
    {
        if ( isdefined( level.var_fe1d7fc62c065b0c ) && isdefined( level.var_e917e0cf6a259c11 ) )
        {
            cache = spawnstruct();
            items = common_item::items_selectfromlist( "<dev string:x1175>", 1 );
            ob_objective_rewards::function_98861c0455f4e01f( items, cache );
            managedrewardcache = level.var_fe1d7fc62c065b0c;
            player = level.players[ 0 ];
            reserveditemslotindex = level.var_e917e0cf6a259c11;
            item = cache.contents[ 0 ];
            managed_reward_cache::function_e8b27e2b4f71c42a( managedrewardcache, player, reserveditemslotindex, item );
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x7c8d1a16, Offset: 0xe21
    // Size: 0xc, Type: dev
    function function_522f203d3c50634f()
    {
        thread function_b58e95a0f30255c9();
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xac044cd7, Offset: 0xe35
    // Size: 0x4f, Type: dev
    function function_b58e95a0f30255c9()
    {
        var_6efee5c18b946049 = function_121044c6586df39( 1 );
        var_6efee5c18b946049 waittill( #"hash_db90bb68b59b48ea", var_3ab87c2a4d08d389 );
        
        if ( !isdefined( var_3ab87c2a4d08d389 ) )
        {
            iprintln( "<dev string:x119e>" );
            return;
        }
        
        iprintln( "<dev string:x11b7>" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x2f5ebcc4, Offset: 0xe8c
    // Size: 0xc, Type: dev
    function function_f3591229bdd73360()
    {
        thread function_d87175e0c6de31e();
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xaa60484a, Offset: 0xea0
    // Size: 0x64, Type: dev
    function function_d87175e0c6de31e()
    {
        var_6efee5c18b946049 = function_121044c6586df39();
        var_6efee5c18b946049 waittill( #"hash_db90bb68b59b48ea", var_5d9017a4232ee505 );
        iprintln( "<dev string:x1203>" );
        
        if ( isdefined( var_5d9017a4232ee505 ) )
        {
            var_5d9017a4232ee505 waittill( #"managed_reward_cache_despawned" );
            iprintln( "<dev string:x1217>" );
            return;
        }
        
        iprintln( "<dev string:x122d>" );
    }

    // Namespace activity_rewards_debug
    // Params 2
    // Checksum 0xa00afd5c, Offset: 0xf0c
    // Size: 0x170, Type: dev
    function function_121044c6586df39( var_7849b1f7a25de5d7, var_b4bb7aad5f3798b2 )
    {
        if ( !isdefined( var_7849b1f7a25de5d7 ) )
        {
            var_7849b1f7a25de5d7 = 0;
        }
        
        if ( !isdefined( var_b4bb7aad5f3798b2 ) )
        {
            var_b4bb7aad5f3798b2 = 0;
        }
        
        var_ad29d3fb662dc8de = function_ddbf014dc558210a();
        placement = ob_activity_rewards::function_f23d5e30cd73e104( var_ad29d3fb662dc8de.origin, var_b4bb7aad5f3798b2 );
        reward_group = var_7849b1f7a25de5d7 ? undefined : [ level.players[ 0 ] ];
        var_fcdf1fa8b312c176 = [ reward_group ];
        var_baee98df379448aa = spawnstruct();
        lootfunc = &function_89a3b2e2301f3295;
        var_6774d5b56be145e6 = undefined;
        func_onitemtaken = undefined;
        func_onitemadded = &ob_activity_rewards::function_d5422be66a10dac0;
        rewardcachesettings = reward_cache_settings::function_30b01f7700d12b96( "<dev string:x1279>" );
        despawndistance = 500;
        despawntimerseconds = 10;
        despawntriggerdelayseconds = 5;
        despawnwhenempty = 1;
        spawndelayseconds = 0;
        objectivemarkervisibilitydistance = 7500;
        rewardcachebehaviorsettings = namespace_15dfbdeb8b2ff6b9::function_604c70eb43095f69( despawndistance, despawntimerseconds, despawntriggerdelayseconds, despawnwhenempty, objectivemarkervisibilitydistance, spawndelayseconds );
        func_openlootablecontainer = &activity_rewards::function_ef319aeac2e5cbe;
        managed_reward_cache::function_62e1e9e8ae541941( rewardcachesettings, rewardcachebehaviorsettings, [ reward_group ], placement, func_openlootablecontainer, lootfunc, var_6774d5b56be145e6, func_onitemtaken, func_onitemadded, var_baee98df379448aa );
        return var_baee98df379448aa;
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x7fad9170, Offset: 0x1084
    // Size: 0x53, Type: dev
    function function_5e766cce47cda4ab( params )
    {
        instance = activity_player_common::function_e811448130016c90( level.player );
        
        if ( !isdefined( instance ) )
        {
            iprintlnbold( "<dev string:x10f0>" );
            return;
        }
        
        activitymoment = params[ 0 ];
        activity_instance_common::announceactivitymoment( instance, activitymoment );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x142be1b5, Offset: 0x10df
    // Size: 0x53, Type: dev
    function function_7966db88a6ab20d8( params )
    {
        instance = activity_player_common::function_e811448130016c90( level.player );
        
        if ( !isdefined( instance ) )
        {
            iprintlnbold( "<dev string:x10f0>" );
            return;
        }
        
        customactivationname = params[ 0 ];
        activity_instance_common::function_5e2f9c673ccd965f( instance, customactivationname );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x3e6712b1, Offset: 0x113a
    // Size: 0x3b, Type: dev
    function function_eb5af31fa034dc46()
    {
        payload = [ #"teamselect", level.players[ 0 ] getentitynumber() ];
        function_817a9c62105316d( payload );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xec5c7fc4, Offset: 0x117d
    // Size: 0x6f, Type: dev
    function function_830a2426b2103cf1()
    {
        if ( isdefined( level.players[ 1 ] ) )
        {
            entnum = level.players[ 1 ] getentitynumber();
        }
        else
        {
            entnum = level.players[ 0 ] getentitynumber() + 1;
        }
        
        payload = [ #"teamselect", entnum ];
        function_817a9c62105316d( payload );
    }

    // Namespace activity_rewards_debug
    // Params 1, eflags: 0x4
    // Checksum 0xa62d4662, Offset: 0x11f4
    // Size: 0x9c, Type: dev
    function private function_817a9c62105316d( payload )
    {
        if ( isdefined( level.var_77e0ac4d16726845 ) )
        {
            level.var_77e0ac4d16726845 freescriptable();
            level.var_77e0ac4d16726845 = undefined;
        }
        
        placement = function_ddbf014dc558210a();
        level.var_77e0ac4d16726845 = spawnscriptable( "<dev string:x128d>", placement.origin, placement.angles, undefined, payload );
        wait 120;
        
        if ( isdefined( level.var_77e0ac4d16726845 ) )
        {
            level.var_77e0ac4d16726845 freescriptable();
            level.var_77e0ac4d16726845 = undefined;
        }
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x5fbb5c32, Offset: 0x1298
    // Size: 0x5b, Type: dev
    function function_bef051b892ee1ef( params )
    {
        scriptable = level.var_77e0ac4d16726845;
        
        if ( !isdefined( scriptable ) )
        {
            iprintln( "<dev string:x12bb>" );
            return;
        }
        
        part = "<dev string:x12e5>";
        state = params[ 0 ];
        scriptable setscriptablepartstate( part, state );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x5561dade, Offset: 0x12fb
    // Size: 0x56, Type: dev
    function function_57313ec2a0ff627b()
    {
        scriptable = level.var_77e0ac4d16726845;
        
        if ( !isdefined( scriptable ) )
        {
            iprintln( "<dev string:x12bb>" );
            return;
        }
        
        part = "<dev string:x12ea>";
        scriptable setscriptablepartstate( part, "<dev string:x12f6>" );
        waitframe();
        scriptable setscriptablepartstate( part, "<dev string:x57d>" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xb3bdf061, Offset: 0x1359
    // Size: 0x56, Type: dev
    function function_147eab79daa9fbb7()
    {
        scriptable = level.var_77e0ac4d16726845;
        
        if ( !isdefined( scriptable ) )
        {
            iprintln( "<dev string:x12bb>" );
            return;
        }
        
        part = "<dev string:x130e>";
        scriptable setscriptablepartstate( part, "<dev string:x1317>" );
        waitframe();
        scriptable setscriptablepartstate( part, "<dev string:x57d>" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x1a2c9ade, Offset: 0x13b7
    // Size: 0x56, Type: dev
    function function_a886bd53a101cf5e()
    {
        scriptable = level.var_77e0ac4d16726845;
        
        if ( !isdefined( scriptable ) )
        {
            iprintln( "<dev string:x12bb>" );
            return;
        }
        
        part = "<dev string:x132c>";
        scriptable setscriptablepartstate( part, "<dev string:x1335>" );
        waitframe();
        scriptable setscriptablepartstate( part, "<dev string:x57d>" );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0xff21fab5, Offset: 0x1415
    // Size: 0x112, Type: dev
    function private function_539fcac0f48f3433()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_64bf749bc2b9f5ac", 0 ) == 1 )
            {
                iprintlnbold( "<dev string:x134a>" );
                function_bf0a41ccf98e00dc();
                setdvar( @"hash_64bf749bc2b9f5ac", 0 );
            }
            
            if ( getdvarint( @"hash_b223ecf5093e1dc3", 0 ) == 1 )
            {
                iprintlnbold( "<dev string:x137e>" );
                function_7ecf419d78ac6d61();
                setdvar( @"hash_b223ecf5093e1dc3", 0 );
            }
            
            if ( getdvarint( @"hash_7d4c31ff1a097c23", 0 ) == 1 )
            {
                iprintlnbold( "<dev string:x13b2>" );
                function_d060327a198aeb5c();
                setdvar( @"hash_7d4c31ff1a097c23", 0 );
            }
            
            if ( getdvarint( @"hash_9ae7f603389004dd", 0 ) == 1 )
            {
                iprintlnbold( "<dev string:x13da>" );
                function_3e245a7a867daa3a();
                setdvar( @"hash_9ae7f603389004dd", 0 );
            }
            
            if ( getdvarint( @"hash_382caba4283fac9d", 0 ) == 1 )
            {
                iprintlnbold( "<dev string:x1409>" );
                function_efdc4e049244bfcf();
                setdvar( @"hash_382caba4283fac9d", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0x92aaed2c, Offset: 0x152f
    // Size: 0xe7, Type: dev
    function private function_bf0a41ccf98e00dc()
    {
        playergroups = [];
        
        foreach ( player in level.players )
        {
            playergroups[ playergroups.size ] = [ player ];
        }
        
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin;
        placement.angles = level.players[ 0 ].angles;
        function_55a2441b33d2c709( playergroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0xca29c2cb, Offset: 0x161e
    // Size: 0x79, Type: dev
    function private function_7ecf419d78ac6d61()
    {
        playergroups = [ level.players ];
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin;
        placement.angles = level.players[ 0 ].angles;
        function_55a2441b33d2c709( playergroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0x56e590f2, Offset: 0x169f
    // Size: 0x8c, Type: dev
    function private function_d060327a198aeb5c()
    {
        group = [ level.players[ 0 ] ];
        playergroups = [ group ];
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin;
        placement.angles = level.players[ 0 ].angles;
        function_55a2441b33d2c709( playergroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0x37e7743a, Offset: 0x1733
    // Size: 0xba, Type: dev
    function private function_3e245a7a867daa3a()
    {
        if ( level.players.size > 2 )
        {
            group = [ level.players[ 0 ], level.players[ 1 ] ];
            playergroups = [ group ];
        }
        else
        {
            iprintln( "<dev string:x144b>" );
            return;
        }
        
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin;
        placement.angles = level.players[ 0 ].angles;
        function_55a2441b33d2c709( playergroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0, eflags: 0x4
    // Checksum 0xc61002d9, Offset: 0x17f5
    // Size: 0xcb, Type: dev
    function private function_efdc4e049244bfcf()
    {
        if ( level.players.size > 2 )
        {
            group1 = [ level.players[ 0 ] ];
            group2 = [ level.players[ 1 ] ];
            playergroups = [ group1, group2 ];
        }
        else
        {
            iprintln( "<dev string:x144b>" );
            return;
        }
        
        placement = spawnstruct();
        placement.origin = level.players[ 0 ].origin;
        placement.angles = level.players[ 0 ].angles;
        function_55a2441b33d2c709( playergroups, placement );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xc40c3a9d, Offset: 0x18c8
    // Size: 0x15, Type: dev
    function function_e43c9d86f98d7b4e()
    {
        setdvar( @"test_spawn", 1 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x1f44a304, Offset: 0x18e5
    // Size: 0x41, Type: dev
    function function_ebca84269a1a1853()
    {
        setdvar( @"hash_eff5e2218caf8354", 1 );
        var_7761aba18add6e83 = 24;
        var_ae0540624cd9a148 = 180;
        setdvar( @"hash_1ed3e490fb83235e", var_7761aba18add6e83 * var_ae0540624cd9a148 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x4f6088b, Offset: 0x192e
    // Size: 0x14, Type: dev
    function function_777216edc62712()
    {
        setdvar( @"hash_eff5e2218caf8354", 0 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x5aef5209, Offset: 0x194a
    // Size: 0x1a, Type: dev
    function function_38f1469c85122db5()
    {
        function_c845662f25e208b8();
        function_ebca84269a1a1853();
        thread function_669a1b440ba0dff6();
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x7fc8bf94, Offset: 0x196c
    // Size: 0x27, Type: dev
    function function_c845662f25e208b8()
    {
        setdvar( @"hash_eff5e2218caf8354", 0 );
        function_777216edc62712();
        level notify( #"hash_5d20ddc571c43a91" );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x91635030, Offset: 0x199b
    // Size: 0x27, Type: dev
    function function_8330311531e04e2a( params )
    {
        setdvar( @"test_distance", function_952a0258447e3cdf( params, 80 ) );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x757ea22b, Offset: 0x19ca
    // Size: 0x27, Type: dev
    function function_6d8fcb7e9e9b8beb( params )
    {
        setdvar( @"test_radius", function_952a0258447e3cdf( params, 120 ) );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0xc919b50b, Offset: 0x19f9
    // Size: 0x2a, Type: dev
    function function_ecd4632bc014410c( params )
    {
        setdvar( @"test_fov", function_952a0258447e3cdf( params, 0.5 ) );
    }

    // Namespace activity_rewards_debug
    // Params 2
    // Checksum 0x84982288, Offset: 0x1a2b
    // Size: 0x41, Type: dev
    function function_952a0258447e3cdf( params, default_value )
    {
        if ( params[ 0 ] == "<dev string:x1481>" )
        {
            var_900afbfec02f64bb = default_value;
        }
        else
        {
            var_900afbfec02f64bb = int( params[ 0 ] );
        }
        
        return var_900afbfec02f64bb;
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x32a93aad, Offset: 0x1a74
    // Size: 0x15, Type: dev
    function function_602b9d890a17244c()
    {
        setdvar( @"hash_c64fb3f1e87bb1fd", 1 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xe984328c, Offset: 0x1a91
    // Size: 0x14, Type: dev
    function function_6210e2d299e78fff()
    {
        setdvar( @"hash_c64fb3f1e87bb1fd", 0 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x3e68fa8, Offset: 0x1aad
    // Size: 0x1f, Type: dev
    function function_59d621d6c5e0cf07()
    {
        iprintlnbold( "<dev string:x1487>" );
        setdvar( @"hash_ed4e1c3ec7fb385d", 1 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xbe644f34, Offset: 0x1ad4
    // Size: 0x1e, Type: dev
    function function_43e0524f031d41ba()
    {
        iprintlnbold( "<dev string:x14c5>" );
        setdvar( @"hash_ed4e1c3ec7fb385d", 0 );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x49ae55ab, Offset: 0x1afa
    // Size: 0x319, Type: dev
    function function_669a1b440ba0dff6()
    {
        level endon( #"hash_5d20ddc571c43a91" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            var_da83835d32d2c11d = ( 0, 100, 100 );
            var_4f39188b955711ca = ( 0, 0, 255 );
            var_a73008dc901d4283 = ( 0, 255, 0 );
            var_97d0307e55a92975 = getdvarint( @"test_distance", 80 );
            offset_radius = getdvarint( @"test_radius", 120 );
            var_af8b5d56777c658d = getdvarint( @"hash_a648b26bf386318b", 2 );
            var_d946333816aa6583 = getdvarint( @"hash_88de563635d1c8f4", 22 );
            var_ff79c0f122a821 = getdvarint( @"hash_14a76d70faf5b5de", 36 );
            var_17816a375a70253 = getdvarint( @"hash_631bc888d0a9d40c", 0.5 );
            scoring_player_fov = cos( getdvarint( @"test_fov", 60 ) );
            var_c2d24cfa3b9e1a10 = getdvarint( @"test_dist_player", 16 );
            var_cbad8f1d331c5e68 = getdvarint( @"test_spawn", 0 );
            var_d8a71f3e9bd09556 = getdvarint( @"hash_ed4e1c3ec7fb385d", 0 );
            var_9589acc55d4078ee = getdvarint( @"hash_c64fb3f1e87bb1fd", 0 );
            debug_draw_duration = var_cbad8f1d331c5e68 ? 9999 : ceil( 8 / var_af8b5d56777c658d );
            setdvar( @"hash_1ed3e490fb83235e", debug_draw_duration );
            player_view_origin = level.player getvieworigin();
            player_view_angles = level.player getplayerangles();
            original_spawn_position = player_view_origin + anglestoforward( player_view_angles ) * var_97d0307e55a92975;
            var_20dd47a443f5a68f = level;
            var_35ad3b14b95baa7b = var_d8a71f3e9bd09556 ? original_spawn_position : level.player.origin;
            var_31ebf063d0ac2c41 = namespace_f4242316def354f7::function_eba1cac9e953fe77( var_d946333816aa6583, var_ff79c0f122a821, var_17816a375a70253, var_35ad3b14b95baa7b, level.player getplayerangles(), scoring_player_fov, var_c2d24cfa3b9e1a10 );
            var_220a51ba4d74353d = var_9589acc55d4078ee ? namespace_f4242316def354f7::function_92290a260dcb23b() : namespace_f4242316def354f7::function_819b627a62584c41();
            namespace_f4242316def354f7::findnearbyspawnpointguaranteed( original_spawn_position, offset_radius, var_31ebf063d0ac2c41, var_220a51ba4d74353d, var_20dd47a443f5a68f );
            var_20dd47a443f5a68f waittill( #"hash_5c2ff3ac36ee1341", selected_position );
            
            if ( !isdefined( selected_position ) )
            {
                iprintlnbold( "<dev string:x1502>" );
                continue;
            }
            
            if ( var_cbad8f1d331c5e68 )
            {
                setdvar( @"test_spawn", 0 );
                var_c0f37f28ef4a185a = setdvar( @"hash_1ed3e490fb83235e", 2 );
                placement = ob_activity_rewards::function_f23d5e30cd73e104( selected_position, 0 );
                group = [ level.player ];
                ob_objective_rewards::function_8d782bca3d15cb56( [ group ], placement, &function_89a3b2e2301f3295 );
            }
            
            waitframe();
        }
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x62be0a04, Offset: 0x1e1b
    // Size: 0xf, Type: dev
    function function_73110437a3a011cd()
    {
        iprintlnbold( "<dev string:x1522>" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xb65c2657, Offset: 0x1e32
    // Size: 0x15, Type: dev
    function function_4db86b7230faf172()
    {
        function_d5b48eea3ac5283c( @"hash_9a8fd13708d50583" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x4cefed0b, Offset: 0x1e4f
    // Size: 0x15, Type: dev
    function function_f64933ddb98cf19d()
    {
        function_d5b48eea3ac5283c( @"hash_9d0c095771c6026d" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x2dc9a96e, Offset: 0x1e6c
    // Size: 0x15, Type: dev
    function function_377a573ec1dd63ac()
    {
        function_d5b48eea3ac5283c( @"hash_813ebb2dc2b30d1c" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xe5405171, Offset: 0x1e89
    // Size: 0x15, Type: dev
    function function_1085e870f93bf51e()
    {
        function_d5b48eea3ac5283c( @"hash_693c22d6aae40d2e" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0xd76c8aa, Offset: 0x1ea6
    // Size: 0x15, Type: dev
    function function_8b6f3042b0011650()
    {
        function_d5b48eea3ac5283c( @"hash_176196b9a9745584" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x7ee34ffe, Offset: 0x1ec3
    // Size: 0x15, Type: dev
    function function_f6c824760e4ae0bc()
    {
        function_d5b48eea3ac5283c( @"hash_56641085422a272c" );
    }

    // Namespace activity_rewards_debug
    // Params 0
    // Checksum 0x4d581619, Offset: 0x1ee0
    // Size: 0x15, Type: dev
    function function_289bef8d4a609e41()
    {
        function_d5b48eea3ac5283c( @"hash_bd0e9311e61ffefa" );
    }

    // Namespace activity_rewards_debug
    // Params 1
    // Checksum 0x70dd11b7, Offset: 0x1efd
    // Size: 0x4f, Type: dev
    function function_d5b48eea3ac5283c( dvar )
    {
        value = getdvarint( dvar, 0 );
        
        if ( value )
        {
            iprintln( "<dev string:x156b>" );
            setdvar( dvar, 0 );
            return;
        }
        
        iprintln( "<dev string:x157c>" );
        setdvar( dvar, 1 );
    }

#/
