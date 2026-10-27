// scripts\mp\ob\systems\ob_cheat_dvars.gsc  (hash_439923dbe5efdccd.gscc) (size: 22601 Bytes / 0x5849 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33abb8e6 (866892006)
// size ...... 22601 (0x5849)
// includes .. 21  (offset: 0x52f5)
// strings ... 67  (offset: 0x539d)
// dev strs .. 11  (offset: 0x57c1)
// exports ... 58  (offset: 0x3721)
// cseg ...... 0x6eb + 0x3036 (0x3721)
// imports ... 155 (offset: 0x4031)
// animtree1 . 0   (offset: 0x5849)
// animtree2 . 0   (offset: 0x5849)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\armor;
#using scripts\mp\bots\bots_debug;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\operator;
#using scripts\mp\pack_a_punch;
#using scripts\mp\radiation;
#using scripts\mp\supers;

#namespace ob_cheat_dvars;

// Namespace ob_cheat_dvars
// Params 0
// Checksum 0x745118c, Offset: 0x709
// Size: 0x3b
function init()
{
    if ( getbuildversion() == "SHIP" )
    {
        return;
    }
    
    level thread function_60251d3506f7495();
    
    /#
        level thread function_34ef55ae0b095247();
        level thread function_67678b2f7f957859();
        level thread function_9fdc20133b0544ab();
    #/
    
    level thread function_e02851a347aacb55();
}

/#

    // Namespace ob_cheat_dvars
    // Params 0, eflags: 0x4
    // Checksum 0x5c33d78a, Offset: 0x74c
    // Size: 0x9c, Type: dev
    function private function_34ef55ae0b095247()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        killstreaks = getkillstreaklist();
        
        for ( i = 0; i < killstreaks.size ; i++ )
        {
            itembundle = getscriptbundle( killstreaks[ i ] );
            name = debugtranslatestring( itembundle.ref );
            assetname = getxhashsourcename( killstreaks[ i ] );
            devgui::function_cd4e263c1f3018ae( name, "<dev string:x37>" + assetname, &spawnkillstreak, undefined, i + 1 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_cheat_dvars
    // Params 0, eflags: 0x4
    // Checksum 0xc55ff64d, Offset: 0x7f0
    // Size: 0xc2, Type: dev
    function private function_67678b2f7f957859()
    {
        level waittill( #"register_supers" );
        devgui::function_9082edeb5db93280( "<dev string:x48>" );
        
        foreach ( superdata in level.superglobals.staticsuperdata )
        {
            devgui::add_devgui_command( superdata.ref, "<dev string:x60>" + superdata.ref );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_cheat_dvars
    // Params 0, eflags: 0x4
    // Checksum 0x59df6cd3, Offset: 0x8ba
    // Size: 0x122, Type: dev
    function private function_9fdc20133b0544ab()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7e>" );
        
        foreach ( skillref, skilltiers in level.skillbundles )
        {
            foreach ( tier, skillbundle in skilltiers )
            {
                skillname = getxhashsourcename( skillref );
                devgui::add_devgui_command( skillname + "<dev string:x93>" + tier, "<dev string:x9a>" + skillname + "<dev string:xba>" + tier );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x8d55c7c4, Offset: 0x9e4
// Size: 0xfc
function private function_e02851a347aacb55()
{
    level utility::flag_wait( "vehicle_init_done" );
    var_225c423c7fe2f699 = "veh_" + tolower( getprojectname() );
    devgui::function_9082edeb5db93280( "OB/Vehicles/" );
    
    foreach ( vehicleref in utility::alphabetize( vehicle::function_75acd2d48a8f3605( 0 ) ) )
    {
        data = vehicle::get_data( vehicleref );
        
        if ( !isdefined( data ) )
        {
            continue;
        }
        
        if ( !isstartstr( data.ref, var_225c423c7fe2f699 ) )
        {
            continue;
        }
        
        devgui::add_devgui_command( function_ed1ffa101598d7b6( data ) + vehicleref, "setsv cheat_spawn_ob_vehicle " + vehicleref );
    }
    
    devgui::function_77df7fe7dd273e10();
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x7e7069e9, Offset: 0xae8
// Size: 0x64
function private function_ed1ffa101598d7b6( vehicledata )
{
    category = "Land Vehicles/";
    
    if ( vehicledata.canfly )
    {
        category = "Air Vehicles/";
    }
    else if ( vehicledata.isboat )
    {
        category = "Water Vehicles/";
    }
    else if ( vehicledata.istank )
    {
        category = "Tank Vehicles/";
    }
    
    return category;
}

/#

    // Namespace ob_cheat_dvars
    // Params 0
    // Checksum 0xa4be2c1c, Offset: 0xb55
    // Size: 0x5, Type: dev
    function function_1b37392eee01f859()
    {
        
    }

#/

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0xdf5bcd09, Offset: 0xb62
// Size: 0x6a
function private function_9f267c79590e71b2( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    if ( player isreloading() || player isgestureplaying() )
    {
        return;
    }
    
    if ( isdefined( self.var_58c716ea2bcfef26 ) )
    {
        function_a609520d9907524c( player, self.var_58c716ea2bcfef26 );
    }
    
    self delete();
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x6c2b7ca1, Offset: 0xbd4
// Size: 0x45b
function private function_60251d3506f7495()
{
    var_d14e5a0d68e83b5b = [];
    
    while ( true )
    {
        if ( !isdefined( level.players ) )
        {
            waitframe();
            continue;
        }
        
        cheat_players = level.players;
        cheat_player_name = getdvar( @"cheat_player" );
        
        if ( cheat_player_name )
        {
            foreach ( player in level.players )
            {
                if ( player.name == cheat_player_name )
                {
                    cheat_players = [ player ];
                    break;
                }
            }
        }
        
        cheat_dvars = function_d736a179632efa58();
        
        if ( cheat_dvars.size == 0 )
        {
            waitframe();
            continue;
        }
        
        if ( cheat_dvars[ #"hash_4cddffcbb459dccf" ] )
        {
            thread function_c16cf39e34938c34( cheat_players, cheat_dvars[ #"hash_4cddffcbb459dccf" ] );
        }
        
        if ( cheat_dvars[ #"power_lvl_interactable" ] )
        {
            thread function_d0299008c7fa43a0( cheat_players, cheat_dvars[ #"power_lvl_interactable" ], var_d14e5a0d68e83b5b );
        }
        
        if ( cheat_dvars[ #"hash_6afc49a1cec163b" ] )
        {
            function_c1add2d6bd64174d( var_d14e5a0d68e83b5b );
        }
        
        if ( cheat_dvars[ #"hash_8f8a91a5152987b3" ] )
        {
            thread function_a0d769e1d05c9934( cheat_players, cheat_dvars[ #"hash_8f8a91a5152987b3" ] );
        }
        
        if ( cheat_dvars[ #"give_weapon" ] )
        {
            thread function_a096d379a6a5ca3f( cheat_players, cheat_dvars[ #"give_weapon" ] );
        }
        
        if ( cheat_dvars[ #"give_operator" ] )
        {
            thread function_2c7731457d44d43f( cheat_players, cheat_dvars[ #"give_operator" ] );
        }
        
        if ( cheat_dvars[ #"give_equipment" ] )
        {
            thread function_b813ad6cbb43d701( cheat_players, cheat_dvars[ #"give_equipment" ] );
        }
        
        if ( cheat_dvars[ #"hash_9d6092753e37ec8b" ] )
        {
            thread function_1b35ecc31781d1e9( cheat_players, cheat_dvars[ #"hash_9d6092753e37ec8b" ] );
        }
        
        if ( cheat_dvars[ #"give_super" ] )
        {
            thread function_7dfa8478ea57bde2( cheat_players, cheat_dvars[ #"give_super" ] );
        }
        
        if ( cheat_dvars[ #"ability_ref" ] )
        {
            thread function_f7766136e7d696a3( cheat_players, cheat_dvars[ #"ability_ref" ] );
        }
        
        /#
            if ( cheat_dvars[ #"hash_18364d8c53f708ad" ] )
            {
                thread function_585fb0378ba1d4b3( cheat_players, cheat_dvars[ #"hash_18364d8c53f708ad" ] );
            }
        #/
        
        if ( cheat_dvars[ #"exotic_weapon_ref" ] )
        {
            thread function_b9645af39a7fde45( cheat_players, cheat_dvars[ #"exotic_weapon_ref" ] );
        }
        
        if ( cheat_dvars[ #"hash_aa647e32380c224e" ] )
        {
            thread cheat_showattachments( cheat_players );
        }
        
        if ( cheat_dvars[ #"hash_537167eedece0a25" ] )
        {
            thread function_9175b4097a431dd2( cheat_players );
        }
        
        if ( cheat_dvars[ #"hash_cd66d72fee7e90ad" ] )
        {
            thread function_daf1d8785701c7bc( cheat_players, cheat_dvars[ #"hash_cd66d72fee7e90ad" ] );
        }
        
        if ( cheat_dvars[ #"hash_528f6b9e66912fa8" ] )
        {
            thread function_b86b23fd49d5c3ea( cheat_players, cheat_dvars[ #"hash_528f6b9e66912fa8" ] );
        }
        
        if ( cheat_dvars[ #"difficulty" ] )
        {
            thread function_b6f6451608f790a1( cheat_players, cheat_dvars[ #"difficulty" ] );
        }
        
        if ( cheat_dvars[ #"reset_storm" ] )
        {
            function_389ee279ffa78ada();
        }
        
        if ( cheat_dvars[ #"pause_storm" ] )
        {
            cheat_pausestorm();
        }
        
        if ( cheat_dvars[ #"start_storm" ] )
        {
            function_b381456ded2c4eff();
        }
        
        if ( cheat_dvars[ #"hash_de6e9379c5fe6287" ] )
        {
            thread function_b4804aa00f9bba81( cheat_players, cheat_dvars[ #"hash_de6e9379c5fe6287" ] );
        }
        
        if ( cheat_dvars[ #"hash_c7d4c712027a1d81" ] )
        {
            function_8bf51d00a6f21058( cheat_players, cheat_dvars[ #"hash_c7d4c712027a1d81" ], 1 );
        }
        
        if ( cheat_dvars[ #"hash_71785889d6edd6ed" ] )
        {
            function_8bf51d00a6f21058( cheat_players, cheat_dvars[ #"hash_71785889d6edd6ed" ], 2 );
        }
        
        if ( cheat_dvars[ #"hash_cf2d24fc4aa521f9" ] )
        {
            function_8bf51d00a6f21058( cheat_players, cheat_dvars[ #"hash_cf2d24fc4aa521f9" ], 0 );
        }
        
        if ( cheat_dvars[ #"hash_e6e84f21736ca829" ] )
        {
            function_8bf51d00a6f21058( cheat_players, cheat_dvars[ #"hash_e6e84f21736ca829" ], 3 );
        }
        
        if ( cheat_dvars[ #"hash_e561e7f75babee63" ] )
        {
            thread function_8c1160501e63b16c( cheat_players );
        }
        
        if ( cheat_dvars[ #"hash_39fb0c4c0109e13a" ] )
        {
            thread function_3587137dfdba620f( cheat_players );
        }
        
        if ( cheat_dvars[ #"hash_cfa0f30fd5db3225" ] )
        {
            thread function_c333c51e1bb68234( cheat_players );
        }
        
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x46934cf0, Offset: 0x1037
// Size: 0x321
function private function_d736a179632efa58()
{
    return [ #"hash_cfa0f30fd5db3225":utility::consume_dvar_int( @"hash_245020556fef40d6", 0 ), #"hash_39fb0c4c0109e13a":utility::consume_dvar_int( @"hash_356b2a01344adb2d", 0 ), #"hash_e561e7f75babee63":utility::consume_dvar_int( @"cheat_ob_spawn_exotic_machine", 0 ), #"hash_e6e84f21736ca829":utility::consume_dvar( @"hash_58d4875c039c2c1d", "" ), #"hash_cf2d24fc4aa521f9":utility::consume_dvar( @"hash_70855de2771befa", "" ), #"hash_71785889d6edd6ed":utility::consume_dvar( @"hash_9b2540eafa93219a", "" ), #"hash_c7d4c712027a1d81":utility::consume_dvar( @"hash_242a3260d860611e", "" ), #"hash_de6e9379c5fe6287":utility::consume_dvar( @"hash_58c65a855e58848a", "" ), #"start_storm":utility::consume_dvar_int( @"hash_42c4d96f20c9f088", 0 ), #"pause_storm":utility::consume_dvar_int( @"cheat_pause_storm", 0 ), #"reset_storm":utility::consume_dvar_int( @"hash_d43d9df4f7077b8f", 0 ), #"difficulty":utility::consume_dvar( @"hash_3e2c81d9efbcdc6f", "" ), #"hash_528f6b9e66912fa8":utility::consume_dvar( @"hash_46f4229f30dc1316", "" ), #"hash_cd66d72fee7e90ad":utility::consume_dvar( @"cheat_spawn_ob_vehicle", "" ), #"hash_537167eedece0a25":utility::consume_dvar_int( @"hash_32ce28977b6786e9", -1 ), #"hash_aa647e32380c224e":utility::consume_dvar_int( @"hash_c6520ab62e00f18a", -1 ), #"exotic_weapon_ref":utility::consume_dvar( @"hash_48f50a96b43491d3", "" ), #"hash_18364d8c53f708ad":utility::consume_dvar( @"hash_a8be6f8118b2e28c", "" ), #"ability_ref":utility::consume_dvar( @"hash_4f0ea476d9b6f422", "" ), #"give_super":utility::consume_dvar( @"hash_5b7a4b7f1870c907", "" ), #"hash_9d6092753e37ec8b":utility::consume_dvar( @"cheat_give_killstreak", "" ), #"give_equipment":utility::consume_dvar( @"cheat_give_equipment", "" ), #"give_operator":utility::consume_dvar( @"hash_2c8caf10644e834", "" ), #"give_weapon":utility::consume_dvar( @"cheat_give_weapon", "" ), #"hash_8f8a91a5152987b3":utility::consume_dvar_int( @"hash_2ae4ec9bce607d9f", -1 ), #"hash_6afc49a1cec163b":utility::consume_dvar_int( @"hash_60a7c4fa4b51e27f", -1 ), #"power_lvl_interactable":utility::consume_dvar_int( @"hash_e9161181da8e368d", -1 ), #"hash_4cddffcbb459dccf":utility::consume_dvar_int( @"hash_89f5285b9abcc3b2", -1 ) ];
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x61c02373, Offset: 0x1361
// Size: 0x37
function private function_389ee279ffa78ada()
{
    if ( utility::callsharedfunc( #"aether storm", #"expansionstarted" ) )
    {
        function_840f0c0a650e5901( level.aether_storm.var_ddadcc992aaf985 );
    }
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x68b74e66, Offset: 0x13a0
// Size: 0x4f
function private cheat_pausestorm()
{
    if ( utility::callsharedfunc( #"aether storm", #"expansionstarted" ) )
    {
        var_ecefd36efef8aed3 = level.aether_storm.radiation.radius;
        function_840f0c0a650e5901( var_ecefd36efef8aed3 );
    }
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x9f3b4613, Offset: 0x13f7
// Size: 0x37
function private function_b381456ded2c4eff()
{
    if ( !utility::callsharedfunc( #"aether storm", #"expansionstarted" ) )
    {
        utility::callsharedfunc( #"aether storm", #"startexpansion" );
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0xfe53c158, Offset: 0x1436
// Size: 0x118
function private function_840f0c0a650e5901( radius )
{
    level.aether_storm.radiation radiation::destroy();
    level.aether_storm.radiation = radiation::create( level.aether_storm.starting_origin, radius, level.aether_storm.var_4174d31098d8b9f8, level.aether_storm.QUEST_CIRCLE, 1 );
    level.aether_storm.radiation radiation::function_1de5a68ddcf339aa( level.aether_storm.var_69e0a784e0cbf010 );
    
    if ( utility::issharedfuncdefined( #"aether storm", #"agentsupdate", 0 ) )
    {
        thread [[ utility::getsharedfunc( #"aether storm", #"agentsupdate" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"aether storm", #"hash_b8c6224f358331f5", 0 ) )
    {
        thread [[ utility::getsharedfunc( #"aether storm", #"hash_b8c6224f358331f5" ) ]]();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xe412e0d9, Offset: 0x1556
// Size: 0x9b
function private function_c16cf39e34938c34( cheat_players, var_d31f0d4f00dc5b64 )
{
    if ( var_d31f0d4f00dc5b64 > 3 || var_d31f0d4f00dc5b64 < 1 )
    {
        return;
    }
    
    foreach ( cheat_player in cheat_players )
    {
        function_a609520d9907524c( cheat_player, var_d31f0d4f00dc5b64 );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 3
// Checksum 0x8bf72ec6, Offset: 0x15f9
// Size: 0x83
function function_a609520d9907524c( player, var_d31f0d4f00dc5b64, wait_time )
{
    if ( isdefined( wait_time ) )
    {
        wait wait_time;
    }
    
    function_8df311bd47b755b6( player, var_d31f0d4f00dc5b64 );
    function_b648722fe0f69586( player, int( min( var_d31f0d4f00dc5b64 + 1, 4 ) ) );
    function_98f432fe0062d71e( player );
    waitframe();
    function_2570e59d9c79e59c( player, var_d31f0d4f00dc5b64 );
    function_9b14c4038991853e( player, var_d31f0d4f00dc5b64 );
    
    if ( getdvarint( @"hash_cd4ab555eb22ea4", 1 ) )
    {
        function_f3a474424f076f7c( player, var_d31f0d4f00dc5b64 );
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x8724cc4d, Offset: 0x1684
// Size: 0x97
function private function_c1add2d6bd64174d( var_d14e5a0d68e83b5b )
{
    foreach ( var_6d592d80f3810e06 in var_d14e5a0d68e83b5b )
    {
        if ( isent( var_6d592d80f3810e06 ) )
        {
            var_6d592d80f3810e06 delete();
        }
    }
    
    while ( var_d14e5a0d68e83b5b.size )
    {
        var_d14e5a0d68e83b5b[ var_d14e5a0d68e83b5b.size - 1 ] = undefined;
    }
}

// Namespace ob_cheat_dvars
// Params 3, eflags: 0xc
// Checksum 0x38cc030c, Offset: 0x1723
// Size: 0xc9
function private function_d0299008c7fa43a0( cheat_players, power_lvl_interactable, var_d14e5a0d68e83b5b )
{
    self notify( #"hash_9dfd37d33071ca2d" );
    self endon( #"hash_9dfd37d33071ca2d" );
    
    if ( power_lvl_interactable > 3 || power_lvl_interactable < 1 )
    {
        return;
    }
    
    function_c1add2d6bd64174d( var_d14e5a0d68e83b5b );
    
    foreach ( cheat_player in cheat_players )
    {
        var_d14e5a0d68e83b5b[ var_d14e5a0d68e83b5b.size ] = function_724af64f22754d93( cheat_player, power_lvl_interactable );
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x3e246704, Offset: 0x17f4
// Size: 0x52
function private function_724af64f22754d93( player, var_58c716ea2bcfef26 )
{
    var_6d592d80f3810e06 = interaction::register_interact( player.origin, 128, &function_9f267c79590e71b2, &"jup_ob_objectives/interact_activate" );
    var_6d592d80f3810e06.var_58c716ea2bcfef26 = var_58c716ea2bcfef26;
    return var_6d592d80f3810e06;
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x6665f128, Offset: 0x184f
// Size: 0x34f
function private function_f3a474424f076f7c( player, var_d31f0d4f00dc5b64 )
{
    var_359cad62d73f79e5 = [ "ob_jup_item_killstreak_sentrygun", "ob_jup_item_killstreak_cluster_spike", "ob_jup_item_killstreak_precision_airstrike", "ob_jup_item_killstreak_juggernaut", "ob_jup_item_killstreak_clusterstrike" ];
    a_wonderweapons = [ "ob_jup_item_weapon_pi_raygun", "ob_jup_item_weapon_la_plasmagun", "ob_jup_item_weapon_ar_dg2" ];
    a_ammomods = [ "ob_jup_item_ammomod_napalmburst", "ob_jup_item_ammomod_deadwire", "ob_jup_item_ammomod_cryofreeze", "ob_jup_item_ammomod_brainrot", "ob_jup_item_ammomod_shatterblast" ];
    
    switch ( var_d31f0d4f00dc5b64 )
    {
        case 3:
            var_f0110ccab3f4a8a6 = [ "ob_jup_item_gasmask_durable", "ob_jup_item_backpack_large", "ob_jup_item_revive_self_revive", utility::array_random( a_ammomods ), utility::array_random( var_359cad62d73f79e5 ), utility::array_random( var_359cad62d73f79e5 ), utility::array_random( a_wonderweapons ), "ob_jup_item_aether_crystal_3", "ob_jup_item_generic_valuable_turret_trap_circuit", "ob_jup_item_lethal_thermite", "ob_jup_item_lethal_thermite", "ob_jup_item_lethal_c4", "ob_jup_item_lethal_c4", "ob_jup_item_tactical_blackhole_bomb", "ob_jup_item_tactical_blackhole_bomb", "ob_jup_item_tactical_monkey_bomb", "ob_jup_item_tactical_monkey_bomb", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate" ];
            break;
        case 2:
            var_f0110ccab3f4a8a6 = [ "ob_jup_item_gasmask", "ob_jup_item_backpack_medium", "ob_jup_item_revive_self_revive", utility::array_random( var_359cad62d73f79e5 ), "ob_jup_item_lethal_semtex", "ob_jup_item_lethal_semtex", utility::array_random( a_ammomods ), "ob_jup_item_tactical_blackhole_bomb", "ob_jup_item_tactical_monkey_bomb", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate" ];
            break;
        case 1:
            var_f0110ccab3f4a8a6 = [ "ob_jup_item_gasmask", "ob_jup_item_revive_self_revive", utility::array_random( var_359cad62d73f79e5 ), "ob_jup_item_lethal_semtex", "ob_jup_item_lethal_semtex", "ob_jup_item_tactical_shockstick", "ob_jup_item_tactical_shockstick", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate", "ob_jup_item_armor_plate" ];
        default:
            var_f0110ccab3f4a8a6 = [];
            break;
    }
    
    foreach ( item in var_f0110ccab3f4a8a6 )
    {
        itembundle = getscriptbundle( "itemspawnentry:" + item );
        
        if ( isdefined( itembundle ) )
        {
            common_item::function_a87dc047f584d2c7( itembundle, player.origin );
        }
        
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xe1b4065f, Offset: 0x1ba6
// Size: 0x67
function private function_9b14c4038991853e( player, var_d31f0d4f00dc5b64 )
{
    player endon( #"death_or_disconnect" );
    player.platecarrierlevel = var_d31f0d4f00dc5b64;
    player.maxarmorhealth = player.platecarrierlevel * level.var_1bfbe247e8d32b1b;
    player armor::setarmorhealth( player.maxarmorhealth, 1 );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xb1f117a9, Offset: 0x1c15
// Size: 0x134
function private function_8df311bd47b755b6( player, var_d31f0d4f00dc5b64 )
{
    foreach ( player in level.players )
    {
        currentweapons = player getweaponslistall();
        
        foreach ( weap in currentweapons )
        {
            pap_lvl = player pack_a_punch::get_pap_level( weap );
            
            if ( player pack_a_punch::can_pap( weap ) || pap_lvl == 3 && var_d31f0d4f00dc5b64 < 3 )
            {
                player pack_a_punch::pap_weapon( weap, var_d31f0d4f00dc5b64 - 1 );
            }
        }
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xee58aed9, Offset: 0x1d51
// Size: 0x99
function private function_b648722fe0f69586( player, var_d31f0d4f00dc5b64 )
{
    currentweapons = player getweaponslistall();
    
    foreach ( weap in currentweapons )
    {
        player item_weapon::function_40e1cbd0e1f47d1a( weap, var_d31f0d4f00dc5b64 );
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x837fcce5, Offset: 0x1df2
// Size: 0x128
function private function_2570e59d9c79e59c( player, var_543bf92c0a37d911 )
{
    perks = [];
    
    switch ( var_543bf92c0a37d911 )
    {
        case 3:
            perks[ perks.size ] = "specialty_elemental_pop";
            perks[ perks.size ] = "specialty_death_perception";
            perks[ perks.size ] = "specialty_tombstone";
        case 2:
            perks[ perks.size ] = "specialty_staminup";
            perks[ perks.size ] = "specialty_deadshot";
            perks[ perks.size ] = "specialty_phd_flopper";
        case 1:
            perks[ perks.size ] = "specialty_juggernog";
            perks[ perks.size ] = "specialty_quickrevive";
            perks[ perks.size ] = "specialty_speedcola";
            break;
    }
    
    foreach ( perk in perks )
    {
        function_e5de18fbbb9dff87( player, perk );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xfeec64fc, Offset: 0x1f22
// Size: 0xa4
function private function_a096d379a6a5ca3f( cheat_players, give_weapon )
{
    string_array = strtoksubstr( give_weapon, "," );
    
    foreach ( cheat_player in cheat_players )
    {
        function_7bdf5a9e895716a6( cheat_player, string_array[ 0 ], string_array[ 1 ] );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 3, eflags: 0x4
// Checksum 0x5db2adfc, Offset: 0x1fce
// Size: 0x88
function private function_7bdf5a9e895716a6( player, weaponname, weaponref )
{
    fakeitem = spawnstruct();
    max_stock_ammo = weaponmaxammo( weaponname );
    item_bundle = getscriptbundle( "itemspawnentry:" + weaponref );
    var_34cdd5cda21b2ad1 = item_bundle.scriptable;
    fakeitem.count = common_item::function_598dd39282efb544( max_stock_ammo );
    player common_item::function_3f39e7be347cf7e1( item_bundle, fakeitem );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xb007c1ad, Offset: 0x205e
// Size: 0x137
function private function_b9645af39a7fde45( cheat_players, exotic_weapon_ref )
{
    foreach ( cheat_player in cheat_players )
    {
        item_bundle_name = hashcat( %"itemspawnentry:", exotic_weapon_ref );
        item_bundle = getscriptbundle( item_bundle_name );
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( ( 0, 0, 0 ) );
        exotic_weapon = common_item::function_61c2c0251e742ffd( item_bundle, 1, spawn_options );
        cheat_player common_item::function_2b5e2ff57d5f392( exotic_weapon, 0 );
        
        if ( !isdefined( level.var_140c381e0354b90 ) )
        {
            level.var_140c381e0354b90 = [];
        }
        
        if ( isdefined( exotic_weapon.weaponobj.basename ) )
        {
            level.var_140c381e0354b90[ exotic_weapon.weaponobj.basename ] = item_bundle_name;
        }
        
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x7da5b6d6, Offset: 0x219d
// Size: 0x89
function private function_2c7731457d44d43f( cheat_players, operator )
{
    foreach ( cheat_player in cheat_players )
    {
        function_c038aef7c04da826( cheat_player, operator );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xb745ff41, Offset: 0x222e
// Size: 0x3c3
function private function_c038aef7c04da826( player, operator )
{
    operatorbundle = getoperatorscriptbundle( operator );
    player operator::createoperatorcustomization( operator, operatorbundle.defaultskin );
    player utility::callsharedfunc( #"bodysize", #"hash_9199843bbf95cbf8" );
    
    if ( isdefined( player.operatorcustomization.reactiveoperator ) && player.operatorcustomization.reactiveoperator != "" )
    {
        player function_184d7ec010cfaa92( player.operatorcustomization.reactiveoperator );
    }
    
    player notify( #"set_operator" );
    gender = operator::getoperatorgender( operator );
    
    if ( gender == "female" )
    {
        player setclientgender( "female" );
        player.operatorcustomization.gender = "female";
    }
    else
    {
        player setclientgender( "" );
        player.operatorcustomization.gender = "male";
    }
    
    clothtype = operator::function_b1788ccf1b3c0ae9( operatorbundle.defaultskin );
    
    if ( isdefined( clothtype ) && clothtype != "" )
    {
        if ( !isdefined( player.operatorcustomization ) )
        {
            player.operatorcustomization = {};
        }
        
        if ( !isdefined( player.operatorcustomization.clothtype ) )
        {
            player.operatorcustomization.clothtype = "";
        }
        
        if ( isdefined( player.operatorcustomization.clothtype ) && player.operatorcustomization.clothtype != clothtype )
        {
            player.operatorcustomization.clothtype = clothtype;
            player setclothtype( getxhash( clothtype ) );
        }
    }
    else
    {
        player setclothtype( #"vestlight" );
    }
    
    geartype = operator::function_d633420b529828e8( operatorbundle.defaultskin );
    
    if ( isdefined( geartype ) && geartype != "" )
    {
        if ( !isdefined( player.operatorcustomization ) )
        {
            player.operatorcustomization = {};
        }
        
        if ( !isdefined( player.operatorcustomization.geartype ) )
        {
            player.operatorcustomization.geartype = "";
        }
        
        if ( isdefined( player.operatorcustomization.geartype ) && player.operatorcustomization.geartype != geartype )
        {
            player.operatorcustomization.geartype = geartype;
            player setgeartype( getxhash( geartype ) );
        }
    }
    else
    {
        player setgeartype( #"millghtgr" );
    }
    
    if ( isdefined( operatorbundle.abilityrefs.var_f60df0d59ad18b14 ) )
    {
        superlootid = getscriptbundlefieldvalue( operatorbundle.abilityrefs.var_f60df0d59ad18b14, #"lootid" );
        lootinfo = getlootiteminfofromid( superlootid );
        function_73bbdf3eb4360efd( player, lootinfo.itemref );
    }
    
    if ( isdefined( operatorbundle.abilityrefs.var_6141c20f6b9af588 ) )
    {
        superlootid = getscriptbundlefieldvalue( operatorbundle.abilityrefs.var_6141c20f6b9af588, #"lootid" );
        lootinfo = getlootiteminfofromid( superlootid );
        player equipment_mp::giveequipment( "equip_" + lootinfo.itemref, "secondary" );
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x7e411cda, Offset: 0x25f9
// Size: 0x89
function private function_f7766136e7d696a3( cheat_players, ability_ref )
{
    foreach ( cheat_player in cheat_players )
    {
        function_fce4ed5298060634( cheat_player, ability_ref );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x3c498be6, Offset: 0x268a
// Size: 0xc7
function private function_fce4ed5298060634( player, ability_ref )
{
    super = supers_mp::function_5ffd3dfa9cc1e8de( ability_ref );
    
    if ( !super )
    {
        assertmsg( "<dev string:xd8>" + ability_ref + "<dev string:xe0>" );
        return;
    }
    
    if ( super.var_b2ad0e92714d61d7 )
    {
        function_73bbdf3eb4360efd( player, ability_ref );
        return;
    }
    
    if ( super.var_5cf25d35be09368b )
    {
        level.superglobals.var_1a7a620a960090b9 = 1;
        player equipment_mp::giveequipment( "equip_" + ability_ref, "secondary" );
        level.superglobals.var_1a7a620a960090b9 = undefined;
        return;
    }
    
    assertmsg( "<dev string:xd8>" + ability_ref + "<dev string:x13b>" );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x74101e57, Offset: 0x2759
// Size: 0x89
function private function_b813ad6cbb43d701( cheat_players, item )
{
    foreach ( cheat_player in cheat_players )
    {
        function_80bb1b285c53c70e( cheat_player, item );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x30476661, Offset: 0x27ea
// Size: 0x42
function private function_80bb1b285c53c70e( player, item )
{
    item_bundle = getscriptbundle( "itemspawnentry:" + item );
    common_item::function_a87dc047f584d2c7( item_bundle, player.origin );
    waitframe();
}

// Namespace ob_cheat_dvars
// Params 0, eflags: 0x4
// Checksum 0x4411d183, Offset: 0x2834
// Size: 0xde
function private getkillstreaklist()
{
    killstreaklist = getscriptbundle( %"itemspawnlist:ob_sat_items_killstreaks" );
    
    if ( !killstreaklist )
    {
        killstreaklist = getscriptbundle( %"hash_5ab1cdece558ebb4" );
    }
    
    itementries = [];
    
    foreach ( itemSpawn in killstreaklist.itementries )
    {
        if ( isdefined( itemSpawn.weight ) && itemSpawn.weight != 0 )
        {
            itementries[ itementries.size ] = itemSpawn.itemspawnentry;
        }
    }
    
    return itementries;
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0xb971d243, Offset: 0x291b
// Size: 0x20
function private spawnkillstreak( item )
{
    function_f5f61a5a8858a50( level.player, item[ 0 ], 0 );
}

// Namespace ob_cheat_dvars
// Params 3, eflags: 0x4
// Checksum 0xeea61814, Offset: 0x2943
// Size: 0x9c
function private function_1b35ecc31781d1e9( cheat_players, item, var_f40085005ca9448e = 1 )
{
    foreach ( cheat_player in cheat_players )
    {
        function_f5f61a5a8858a50( cheat_player, item, var_f40085005ca9448e );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 3, eflags: 0x4
// Checksum 0x2cfe677, Offset: 0x29e7
// Size: 0xfd
function private function_f5f61a5a8858a50( player, item, var_f40085005ca9448e = 1 )
{
    if ( item == "all" )
    {
        var_359cad62d73f79e5 = getkillstreaklist();
        var_f40085005ca9448e = 0;
    }
    else
    {
        var_359cad62d73f79e5 = [ item ];
    }
    
    foreach ( item_spawn in var_359cad62d73f79e5 )
    {
        if ( var_f40085005ca9448e )
        {
            assetname = "itemspawnentry:" + item_spawn;
        }
        else
        {
            assetname = item_spawn;
        }
        
        item_bundle = getscriptbundle( assetname );
        common_item::function_a87dc047f584d2c7( item_bundle, player.origin );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xceba8eb, Offset: 0x2aec
// Size: 0x89
function private function_7dfa8478ea57bde2( cheat_players, super )
{
    foreach ( cheat_player in cheat_players )
    {
        function_73bbdf3eb4360efd( cheat_player, super );
        waitframe();
    }
}

/#

    // Namespace ob_cheat_dvars
    // Params 2, eflags: 0x4
    // Checksum 0x26528ae8, Offset: 0x2b7d
    // Size: 0xb3, Type: dev
    function private function_585fb0378ba1d4b3( cheat_players, super )
    {
        foreach ( cheat_player in cheat_players )
        {
            target_bot = cheat_player squad_utility::function_c0c042f61085310b( 1 );
            
            if ( !isdefined( target_bot ) )
            {
                continue;
            }
            
            function_73bbdf3eb4360efd( target_bot, super );
            target_bot bots_debug::function_3dc1d19e01d21d40();
            waitframe();
        }
    }

#/

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x48613586, Offset: 0x2c38
// Size: 0x1f
function private function_73bbdf3eb4360efd( player, super )
{
    player perkpackage::perkpackage_givedebug( super );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x8a0542ff, Offset: 0x2c5f
// Size: 0x2d
function private function_e5de18fbbb9dff87( player, perk_name )
{
    if ( player zombie_perks::has_perk( perk_name ) )
    {
        return;
    }
    
    player zombie_perks::give_perk( perk_name, 0 );
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x6969e603, Offset: 0x2c94
// Size: 0xa3
function private function_98f432fe0062d71e( player )
{
    keys = getarraykeys( level._custom_perks );
    
    foreach ( key in keys )
    {
        str_notify = key + "_stop";
        player notify( str_notify );
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x81daa89e, Offset: 0x2d3f
// Size: 0x89
function private function_a0d769e1d05c9934( cheat_players, amount )
{
    foreach ( cheat_player in cheat_players )
    {
        function_d1bd00fb38788309( cheat_player, amount );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x935288c8, Offset: 0x2dd0
// Size: 0x29
function private function_d1bd00fb38788309( player, amount )
{
    player currency::add_currency_amount( #"essence", amount );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xcd1333aa, Offset: 0x2e01
// Size: 0x89
function private function_daf1d8785701c7bc( cheat_players, vehicle_ref )
{
    foreach ( cheat_player in cheat_players )
    {
        function_c1576b34481b904f( cheat_player, vehicle_ref );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xb7ef6d91, Offset: 0x2e92
// Size: 0x81
function private function_c1576b34481b904f( player, vehicle_ref )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles;
    spawndata.initai = 0;
    spawndata vehicle_spawn::prevent_respawn();
    vehicle::spawn( vehicle_ref, spawndata );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x8936460b, Offset: 0x2f1b
// Size: 0x89
function private function_b86b23fd49d5c3ea( cheat_players, ai_type )
{
    foreach ( cheat_player in cheat_players )
    {
        function_5338055a1268cbe( cheat_player, ai_type );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x24b72caa, Offset: 0x2fac
// Size: 0x6f
function private function_5338055a1268cbe( player, ai_type )
{
    location = player.origin + anglestoforward( player.angles ) * 300;
    location = getclosestpointonnavmesh( location );
    var_20f9e9213a0c9854 = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( ai_type, location, ( 0, 0, 0 ), "team_two_hundred" );
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x6dd2faf6, Offset: 0x3023
// Size: 0x89
function private function_b6f6451608f790a1( cheat_players, difficulty )
{
    foreach ( cheat_player in cheat_players )
    {
        function_88e35c9ce42a484f( cheat_player, difficulty );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0x5b3117c, Offset: 0x30b4
// Size: 0xb8
function private function_88e35c9ce42a484f( player, difficulty )
{
    difficulties = [ "difficulty_easy", "difficulty_normal", "difficulty_hard", "difficulty_darkaether" ];
    
    if ( arraycontains( difficulties, difficulty ) )
    {
        encounter = "ai_encounter:enc_ob_large_ambush_escort_bigmap";
        location = player.origin + anglestoforward( player.angles ) * 600;
        location = getclosestpointonnavmesh( location );
        request_id = ai_spawn_director::spawn_request( encounter, location, 400, 1, 1, 0 );
        request_id = function_1a9d724a960fa19d( request_id, difficulty, 1 );
    }
}

// Namespace ob_cheat_dvars
// Params 2, eflags: 0x4
// Checksum 0xf8d4fefa, Offset: 0x3174
// Size: 0x9c
function private function_b4804aa00f9bba81( cheat_players, var_402e89fa59ab5eb8 )
{
    foreach ( cheat_player in cheat_players )
    {
        cheat_player utility::callsharedfunc( #"ob_skill_tracks", #"levelboost", var_402e89fa59ab5eb8 );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 3, eflags: 0x4
// Checksum 0xb0a0dcad, Offset: 0x3218
// Size: 0xa5
function private function_8bf51d00a6f21058( cheat_players, var_a939450d478056f5, range )
{
    foreach ( cheat_player in cheat_players )
    {
        cheat_player thread utility::callsharedfunc( #"ob_skill_tracks", #"fixedloadout", var_a939450d478056f5, range );
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x8c55552f, Offset: 0x32c5
// Size: 0xcf
function private function_8c1160501e63b16c( cheat_players )
{
    var_4f657a3c21524fff = getdvarint( @"hash_a8df45f09221614e", 0 );
    
    foreach ( cheat_player in cheat_players )
    {
        origin = cheat_player.origin + anglestoforward( cheat_player.angles ) * 200;
        jailbreak_machine::function_455ec409a27f78d9( origin, [ cheat_player ], var_4f657a3c21524fff, 1, 1 );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x4e918aa8, Offset: 0x339c
// Size: 0xaa
function private cheat_showattachments( cheat_players )
{
    foreach ( cheat_player in cheat_players )
    {
        currentweapon = cheat_player getcurrentweapon();
        
        if ( currentweapon.conversionkit != "" )
        {
            iprintlnbold( currentweapon.conversionkit );
        }
        
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0x34cd2bc0, Offset: 0x344e
// Size: 0xdc
function private function_9175b4097a431dd2( cheat_players )
{
    foreach ( cheat_player in cheat_players )
    {
        weaponobj = cheat_player getcurrentweapon();
        var_bce51b6a44a3de47 = level.var_140c381e0354b90[ weaponobj.basename ];
        newweapon = jailbreak_machine::function_65beb4d48e86186c( cheat_player, var_bce51b6a44a3de47 );
        
        if ( newweapon.conversionkit != "" )
        {
            iprintlnbold( newweapon.conversionkit );
        }
        
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0xa20a8ec8, Offset: 0x3532
// Size: 0x116
function private function_3587137dfdba620f( cheat_players )
{
    rescueTokenLootID = getscriptbundlefieldvalue( %"consumable:sat_ob_rescue_token", #"lootid" );
    
    foreach ( cheat_player in cheat_players )
    {
        cheat_player setplayerdata( "common", "rescueTokenLootID", rescueTokenLootID );
        rescueTokenBalance = cheat_player getplayerdata( "common", "rescueTokenBalance" );
        cheat_player setplayerdata( "common", "rescueTokenBalance", rescueTokenBalance + 1 );
        str = "Gave " + ( cheat_player.name ?? "" ) + " one rescue token so their balance is now " + rescueTokenBalance + 1;
        logstring( str );
        iprintlnbold( str );
        waitframe();
    }
}

// Namespace ob_cheat_dvars
// Params 1, eflags: 0x4
// Checksum 0xa5af8a1c, Offset: 0x3650
// Size: 0xd1
function private function_c333c51e1bb68234( cheat_players )
{
    foreach ( cheat_player in cheat_players )
    {
        cheat_player setplayerdata( "common", "rescueTokenLootID", 0 );
        cheat_player setplayerdata( "common", "rescueTokenBalance", 0 );
        str = "Cleared " + ( cheat_player.name ?? "" ) + "'s rescue token balance";
        logstring( str );
        iprintlnbold( str );
        waitframe();
    }
}

