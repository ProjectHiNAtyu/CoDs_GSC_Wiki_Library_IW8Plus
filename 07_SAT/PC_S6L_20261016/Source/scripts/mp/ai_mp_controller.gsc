// scripts\mp\ai_mp_controller.gsc  (hash_48814951e916af89.gscc) (size: 129076 Bytes / 0x1f834 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a69d77a (1516885882)
// size ...... 129076 (0x1f834)
// includes .. 38  (offset: 0x1ce28)
// strings ... 262 (offset: 0x1cf58)
// dev strs .. 233 (offset: 0x1ea68)
// exports ... 188 (offset: 0x16b20)
// cseg ...... 0x139a + 0x15786 (0x16b20)
// imports ... 492 (offset: 0x18880)
// animtree1 . 0   (offset: 0x1f834)
// animtree2 . 0   (offset: 0x1f834)
#using scripts\anim\battlechatter;
#using scripts\anim\squadmanager;
#using scripts\common\ai;
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai_formation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_juggernaut;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\agents\common_agent_damage;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\mp_dialogue;
#using scripts\mp\mp_gameskill;
#using scripts\mp\operator;
#using scripts\mp\poi;
#using scripts\mp\stealth\manager;
#using scripts\mp\weapons;

#namespace ai_mp_controller;

// Namespace ai_mp_controller
// Params 0
// Checksum 0xa2ccfb50, Offset: 0x13b8
// Size: 0xde7
function init()
{
    if ( level.supportsai )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_544b3ba28c5f683e", 0 ) > 0 )
        {
            while ( !isdefined( level.struct_class_names ) )
            {
                waitframe();
            }
            
            waitframe();
            function_b50f545dc4a7e563();
            aibudget_init();
            flags::gameflaginit( "<dev string:x24>", 1 );
            level.var_12432cff12cc38ec = 0;
            return;
        }
    #/
    
    level.supportsai = 1;
    
    if ( !isdefined( level.var_6721bad5ee3a000e ) )
    {
        level.var_6721bad5ee3a000e = &function_c19c505141ec3b3;
    }
    
    level.var_df336712f37ebfc0 = getdvarint( @"hash_acf59b5e363165c0", isbrgamemode() || isdefined( level.gametypebundle ) && level.gametypebundle.var_1871344e2bf24e24 );
    level.var_2d69be251661fd85 = gettime();
    level.var_a86c082b7074bf97 = -1;
    battlechatter::init_battlechatter();
    mp_dialogue::main();
    utility::registersharedfunc( #"ai_mp_controller", #"hash_87d113f09dbe31bb", &function_1b5040888fcd52e1 );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_35dcbf8d092b58a2", &function_d5798cf0bfdab8d8 );
    utility::registersharedfunc( #"ai_mp_controller", #"priority_removebydormancyid", &priority_removebydormancyid );
    utility::registersharedfunc( #"ai_mp_controller", #"priority_setbydormancyid", &priority_setbydormancyid );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_1a919983fa6cb7b2", &priority_set );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_4fb7ab9f852006e6", &priority_remove );
    utility::registersharedfunc( #"ai_mp_controller", #"processagentspawned", &processagentspawned );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_eef1e1b9713bdbdf", &ai_behavior::behavior_executebehaviorpackage );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_92dcfffa4c19a93", &ai_mp_requestspawnagent );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_cbe331215c7d5cdf", &agent_utils::function_d77442145c568a4e );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_8bc70bcda391eb5b", &agent_utils::function_86157c3fbf5fdea2 );
    utility::registersharedfunc( #"ai_mp_controller", #"hash_6ecc3979ca9e3ce5", &agent_utils::function_585134f4744c6f80 );
    utility::registersharedfunc( #"damage", #"hash_d6fbc570c8d76b1b", &function_1817416dc969f7da );
    utility::registersharedfunc( #"tier", #"hash_2cef2ff38ede644e", &agent_utils::function_baae17b379cbf627 );
    utility::registersharedfunc( #"tier", #"hash_7f4313e5bd22fca0", &agent_utils::overridetier1, 1 );
    utility::registersharedfunc( #"tier", #"hash_7f4316e5bd2301b9", &agent_utils::overridetier2, 1 );
    utility::registersharedfunc( #"tier", #"hash_7f4315e5bd230006", &agent_utils::overridetier3, 1 );
    utility::registersharedfunc( #"tier", #"overridejugg", &agent_utils::overridejugg, 1 );
    utility::registersharedfunc( #"tier", #"hash_dcb70b5c1e709956", &agent_utils::overridetier3, 1 );
    utility::registersharedfunc( #"tier", #"overridepow", &agent_utils::overridepow, 1 );
    utility::registersharedfunc( #"aitype_custom", #"hash_618a75dc298bbef6", &agent_utils::function_ae6f0da4f7ad0d7d, 1 );
    utility::registersharedfunc( #"aitype_custom", #"hash_28787cc02985b77e", &agent_utils::function_c5a3c9817f49ef90, 1 );
    level.var_962c97feafeead0d = getdvarint( @"hash_935057b8878ca60c", 1 );
    level.var_a5af60fbe5a82e8b = getdvarint( @"hash_db81671bbb108b36", 2 );
    level.agentmaxdamage = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage", 22, level.gametypebundle.agentmaxdamage );
    level.agentmaxdamage_assault = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_assault", 24, level.gametypebundle.var_cb05aa5cf6615a91 );
    level.var_cbad58ee40f08d58 = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_smg", 12, level.gametypebundle.var_e497094ade5f8373 );
    level.agentmaxdamage_sniper = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_sniper", 95, level.gametypebundle.var_ec517403a4e31a2d );
    level.agentmaxdamage_shotgun = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_shotgun", 15, level.gametypebundle.var_fc573893f9ffe96c );
    level.agentmaxdamage_melee = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_melee", 90, level.gametypebundle.var_7a9347629a1f3d3e );
    level.agentmaxdamage_explosive = utility::function_edc4cc03e9e60b3e( @"scr_agent_maxdamage_explosive", 75, level.gametypebundle.var_a5335999779d2dc5 );
    level.var_973576b7b9b719fa = utility::function_48f723fdc612ec65( @"hash_b98593547931ba38", 0.6, level.gametypebundle.var_c4a53f3183c3ccae );
    level.var_27992b614e2aed12 = [];
    level.var_7c80ccb6f168b387 = [];
    level.var_27992b614e2aed12[ "unset" ][ "default" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "assault" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "smg" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "sniper" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "shotgun" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "melee" ] = -1;
    level.var_27992b614e2aed12[ "unset" ][ "explosive" ] = -1;
    level.var_27992b614e2aed12[ "zero" ][ "default" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "assault" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "smg" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "sniper" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "shotgun" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "melee" ] = 0;
    level.var_27992b614e2aed12[ "zero" ][ "explosive" ] = 0;
    level.var_27992b614e2aed12[ "tier1" ][ "default" ] = 22;
    level.var_27992b614e2aed12[ "tier1" ][ "assault" ] = 24;
    level.var_27992b614e2aed12[ "tier1" ][ "smg" ] = 12;
    level.var_27992b614e2aed12[ "tier1" ][ "sniper" ] = 95;
    level.var_27992b614e2aed12[ "tier1" ][ "shotgun" ] = 15;
    level.var_27992b614e2aed12[ "tier1" ][ "melee" ] = 75;
    level.var_27992b614e2aed12[ "tier1" ][ "explosive" ] = 70;
    level.var_27992b614e2aed12[ "tier2" ][ "default" ] = 25;
    level.var_27992b614e2aed12[ "tier2" ][ "assault" ] = 28;
    level.var_27992b614e2aed12[ "tier2" ][ "smg" ] = 15;
    level.var_27992b614e2aed12[ "tier2" ][ "sniper" ] = 95;
    level.var_27992b614e2aed12[ "tier2" ][ "shotgun" ] = 20;
    level.var_27992b614e2aed12[ "tier2" ][ "melee" ] = 85;
    level.var_27992b614e2aed12[ "tier2" ][ "explosive" ] = 70;
    level.var_27992b614e2aed12[ "tier3" ][ "default" ] = 27;
    level.var_27992b614e2aed12[ "tier3" ][ "assault" ] = 32;
    level.var_27992b614e2aed12[ "tier3" ][ "smg" ] = 19;
    level.var_27992b614e2aed12[ "tier3" ][ "sniper" ] = 95;
    level.var_27992b614e2aed12[ "tier3" ][ "shotgun" ] = 22;
    level.var_27992b614e2aed12[ "tier3" ][ "melee" ] = 95;
    level.var_27992b614e2aed12[ "tier3" ][ "explosive" ] = 80;
    level.var_27992b614e2aed12[ "weak" ][ "default" ] = 18;
    level.var_27992b614e2aed12[ "weak" ][ "assault" ] = 19;
    level.var_27992b614e2aed12[ "weak" ][ "smg" ] = 7;
    level.var_27992b614e2aed12[ "weak" ][ "sniper" ] = 76;
    level.var_27992b614e2aed12[ "weak" ][ "shotgun" ] = 9;
    level.var_27992b614e2aed12[ "weak" ][ "melee" ] = 72;
    level.var_27992b614e2aed12[ "weak" ][ "explosive" ] = 60;
    level.var_27992b614e2aed12[ "strong" ][ "default" ] = 38;
    level.var_27992b614e2aed12[ "strong" ][ "assault" ] = 48;
    level.var_27992b614e2aed12[ "strong" ][ "smg" ] = 30;
    level.var_27992b614e2aed12[ "strong" ][ "sniper" ] = 95;
    level.var_27992b614e2aed12[ "strong" ][ "shotgun" ] = 30;
    level.var_27992b614e2aed12[ "strong" ][ "melee" ] = 140;
    level.var_27992b614e2aed12[ "strong" ][ "explosive" ] = 140;
    level.var_27992b614e2aed12[ "lethal" ][ "default" ] = 48;
    level.var_27992b614e2aed12[ "lethal" ][ "assault" ] = 58;
    level.var_27992b614e2aed12[ "lethal" ][ "smg" ] = 24;
    level.var_27992b614e2aed12[ "lethal" ][ "sniper" ] = 200;
    level.var_27992b614e2aed12[ "lethal" ][ "shotgun" ] = 24;
    level.var_27992b614e2aed12[ "lethal" ][ "melee" ] = 175;
    level.var_27992b614e2aed12[ "lethal" ][ "explosive" ] = 175;
    level.var_27992b614e2aed12[ "unbound" ][ "default" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "assault" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "smg" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "sniper" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "shotgun" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "melee" ] = -2;
    level.var_27992b614e2aed12[ "unbound" ][ "explosive" ] = -2;
    level.var_4bf7c002c2c0e0a8 = getdvarint( @"hash_8a59524527d46b22", 300 );
    level.var_be00c685d7099d10 = getdvarint( @"hash_63dce1152bb58b16", 65 );
    level.var_a959ed5cd2b0fb0a = getdvarint( @"hash_da44b8831307450b", 1 );
    level.var_8c351edc899ab15e = getdvarint( @"hash_d3907cde9245b595", 1 );
    level.var_85b3b139b14e4343 = getdvarint( @"hash_fb2f8a1043ba19ae", 3 );
    level.var_b678d24a0aec8f54 = getdvarint( @"hash_c50d996d34978b41", 25 );
    level.var_5e310e55990fb19d = utility::function_edc4cc03e9e60b3e( @"hash_dd4b78a52dda1944", 0, level.gametypebundle.var_236f2c716efab9d6 );
    level.var_12432cff12cc38ec = 0;
    function_b50f545dc4a7e563();
    setdvar( @"ai_accuracy_attackercountdecrease", 0.85 );
    setdvar( @"ai_accuracy_attackercountmax", 3 );
    function_a9c8ea63c69e7eb4( getdvarint( @"hash_39fe1e5fe7d89e6e", 8 ) * 1000 );
    function_6edb2482fec4dbc7( getdvarint( @"hash_fa88bd128990512b", 200 ) );
    level.ai_badPathHandler = &ai_behavior::ai_badPathHandler;
    
    if ( !level.var_88b3cfa83abf5242 )
    {
        utility::callsharedfunc( #"tier", #"hash_618a75dc298bbef6" );
    }
    
    if ( !level.var_dd60cff6560fb12b )
    {
        utility::callsharedfunc( #"tier", #"hash_2cef2ff38ede644e" );
    }
    
    ai_reinforcements::reinforce_init();
    agent_utils::dormancy_init();
    aibudget_init();
    callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( #"hash_10831fc4ff641282", &ai_behavior::function_95907b4a97fb73ca );
    function_6556068e5d3a2fe5();
    function_141f09ffc03beb1f();
    function_73c9c3d8234c49f();
    level thread gather_nodes();
    function_c41f3735fb9f0dee();
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    /#
        if ( getdvarint( @"hash_98d02294a9885211", 0 ) > 0 )
        {
            level thread function_3cf10f713e8c73a4();
        }
        
        level thread function_b18ed6d433e55711();
        level thread function_93c8600eb211249a();
        level thread debug_categories();
        level thread function_c485ec4757aa42c9();
        level thread function_3f7338ed91a78eb0();
        level thread debug_interactions();
        level thread debug_nuke();
        level thread function_e8e589db23ae9971();
        level thread function_27e0e65f0c900ae1();
        level thread function_18c64c1f24043900();
    #/
    
    /#
        if ( poi::poi_issystemactive() )
        {
            level thread function_306b91bd37bec667();
        }
    #/
    
    ai_behavior::behavior_init();
    
    if ( getdvarint( @"hash_5a01142d62d08a10", 1 ) == 1 )
    {
        function_f03b4790912a8e21( 1 );
    }
    
    flags::gameflaginit( "ai_controller_init", 1 );
    
    /#
        level thread ai_behavior::function_2272871b72e71f8c();
        level thread function_29cbb450c6f0ad35();
    #/
    
    level thread function_f6fe0ea547011708();
    level thread spawn_spawnai();
    level thread function_ef732a9a0e8daff8();
}

// Namespace ai_mp_controller
// Params 0, eflags: 0x4
// Checksum 0xedd2bf, Offset: 0x21a7
// Size: 0xc8
function private function_ef732a9a0e8daff8()
{
    level.var_1b1a764b5a2ea44f = [];
    
    if ( common_item::items_isenabled() && isdefined( level.gametypebundle.var_eb7205440f51ec93 ) )
    {
        foreach ( entry in level.gametypebundle.var_eb7205440f51ec93 )
        {
            level.var_1b1a764b5a2ea44f[ entry.type ] = entry.list;
        }
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xca260827, Offset: 0x2277
// Size: 0xb5
function function_7415f2b98f305b24( val )
{
    assert( isdefined( val ) );
    level.var_df336712f37ebfc0 = val;
    
    foreach ( agent in level.agentarray )
    {
        if ( agent && !agent.forceignoreall )
        {
            agent.ignoreall = val;
        }
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x60ebd4c6, Offset: 0x2334
// Size: 0x22
function function_37d99639a8500c2f( val )
{
    assert( isdefined( val ) );
    level.agentmaxdamage_override = val;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x454e18c9, Offset: 0x235e
// Size: 0xc
function function_e61fc070bb8a111e()
{
    level.agentmaxdamage_override = undefined;
}

// Namespace ai_mp_controller
// Params 4
// Checksum 0x30d5dabc, Offset: 0x2372
// Size: 0x2b
function function_1817416dc969f7da( evictim, initial_damage, armordelta, helmetdelta )
{
    return armordelta + helmetdelta;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xcdf115e, Offset: 0x23a6
// Size: 0x2c0
function function_73c9c3d8234c49f()
{
    level.spawnset = [];
    level.spawnsetchance = [];
    level.defaultspawnset = "guard";
    
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( isdefined( level.gamemodebundle.var_8546ba3d27ef53ca ) )
        {
            level.var_afcf9bea8dc5ff2 = getdvar( @"hash_63c67beb18bd058d", level.gamemodebundle.var_8546ba3d27ef53ca );
        }
    }
    
    if ( !isdefined( level.var_afcf9bea8dc5ff2 ) )
    {
        level.var_afcf9bea8dc5ff2 = getdvar( @"hash_63c67beb18bd058d", "mp/spawnset_tuning_base.csv" );
    }
    
    if ( !tableexists( level.var_afcf9bea8dc5ff2 ) )
    {
        println( "<dev string:x37>" + level.var_afcf9bea8dc5ff2 + "<dev string:x77>" );
        return;
    }
    
    table = level.var_afcf9bea8dc5ff2;
    numrows = tablelookupgetnumrows( table );
    
    for ( i = 0; i < numrows ; i++ )
    {
        spawnsetname = tolower( tablelookupbyrow( table, i, 0 ) );
        
        if ( !isdefined( level.spawnset[ spawnsetname ] ) )
        {
            level.spawnset[ spawnsetname ] = [];
        }
        
        aitype = tolower( tablelookupbyrow( table, i, 1 ) );
        typechance = tablelookupbyrow( table, i, 2 );
        
        if ( typechance == "0" )
        {
            continue;
        }
        
        if ( isdefined( typechance ) )
        {
            if ( !isdefined( level.spawnsetchance[ spawnsetname ] ) )
            {
                level.spawnsetchance[ spawnsetname ] = [];
            }
            
            level.spawnsetchance[ spawnsetname ][ aitype ] = int( typechance );
        }
        
        level.spawnset[ spawnsetname ][ level.spawnset[ spawnsetname ].size ] = aitype;
    }
    
    foreach ( index, var_f0ce706e52f68847 in level.spawnsetchance )
    {
        var_d57d0671b52e7e75 = 0;
        
        foreach ( chance in var_f0ce706e52f68847 )
        {
            if ( chance != 0 )
            {
                var_d57d0671b52e7e75 = 1;
            }
        }
        
        if ( !var_d57d0671b52e7e75 )
        {
            level.spawnsetchance[ index ] = undefined;
        }
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x53fc9a1e, Offset: 0x266e
// Size: 0x7b, Type: bool
function isvalidboss( aitype )
{
    if ( isdefined( level.gamemodebundle.var_119e6e41f96ce845 ) )
    {
        if ( !issubstr( aitype, "boss" ) )
        {
            return false;
        }
        
        if ( issubstr( aitype, "jugg_minigun" ) )
        {
            return istrue( level.gamemodebundle.var_d7d46cc8b32a9617 );
        }
        
        if ( issubstr( aitype, "jugg_grenade" ) )
        {
            return istrue( level.gamemodebundle.var_539b26d76c9ef0ba );
        }
    }
    
    return false;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x995b67ad, Offset: 0x26f2
// Size: 0x18, Type: bool
function function_a7802a3d4292c781( basetype )
{
    return tolower( basetype ) == "pow";
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x81723a32, Offset: 0x2713
// Size: 0x65
function function_b50f545dc4a7e563()
{
    level.var_e811ca27bdb3f3a0 = strtok( getdvar( @"scr_ai_replace", "" ), " " );
    level.var_cd4e803e8bacf910 = strtok( getdvar( @"scr_ai_remove", "" ), " " );
    level.var_afd11bf80d0b43eb = getdvar( @"scr_ai_default_type", "ar" );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x27ddac15, Offset: 0x2780
// Size: 0x24
function function_c82ad53bf69763f4( type )
{
    if ( !isdefined( type ) )
    {
        return 0;
    }
    
    return arraycontains( level.var_e811ca27bdb3f3a0, type );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x88796d01, Offset: 0x27ad
// Size: 0x24
function function_a02f38a7d728e0b5( type )
{
    if ( !isdefined( type ) )
    {
        return 0;
    }
    
    return arraycontains( level.var_cd4e803e8bacf910, type );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xf24ad5f3, Offset: 0x27da
// Size: 0xa8, Type: bool
function function_6a6ed7333d6575c3( aitype )
{
    if ( !isdefined( aitype ) )
    {
        return false;
    }
    
    tokens = strtok( aitype, "_" );
    
    foreach ( basetype in level.var_e811ca27bdb3f3a0 )
    {
        if ( arraycontains( tokens, basetype ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xd8124d4c, Offset: 0x288b
// Size: 0xa8, Type: bool
function function_32b7182f3fd68764( aitype )
{
    if ( !isdefined( aitype ) )
    {
        return false;
    }
    
    tokens = strtok( aitype, "_" );
    
    foreach ( basetype in level.var_cd4e803e8bacf910 )
    {
        if ( arraycontains( tokens, basetype ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x48e77710, Offset: 0x293c
// Size: 0x129
function function_f7aef6871cda828( basetype = level.var_afd11bf80d0b43eb, tiernum = 1, nationality )
{
    if ( tiernum > 3 )
    {
        tiernum = 3;
    }
    else if ( tiernum < 1 )
    {
        tiernum = 1;
    }
    
    if ( !isdefined( nationality ) )
    {
        nationality = function_d8829485c05e8c1( basetype );
    }
    
    if ( basetype == "jugg" )
    {
        return ( level.agentprefix + basetype + "_" + nationality );
    }
    
    if ( !isdefined( level.agentprefix ) )
    {
        level.agentprefix = "enemy_mp_";
    }
    
    if ( function_a7802a3d4292c781( basetype ) )
    {
        prefix = level.var_8ec3fb17bc60a3dd;
    }
    else
    {
        prefix = level.agentprefix;
    }
    
    if ( level.var_5eb32b40214cd2f0 )
    {
        tiername = level.var_1b758c2cba77ad6d[ tiernum ] ?? "soldier";
        return ( prefix + tiername + "_" + basetype + "_" + nationality );
    }
    
    return level.agentprefix + basetype + "_tier" + tiernum + "_" + nationality;
}

// Namespace ai_mp_controller
// Params 4
// Checksum 0x204d43e0, Offset: 0x2a6e
// Size: 0x72
function function_ac54b3e73517562e( subarea, grouporigin, groupname, autodelete = 1 )
{
    if ( level.var_15fb757c9b81d8c4 )
    {
        if ( !isdefined( subarea ) )
        {
            subarea = _subarea_findfromorigin( grouporigin, undefined, undefined, 1 );
        }
        
        groupid = function_7c4eb2a03864d853( function_194ab657916a88db( subarea ), 1, groupname, autodelete, undefined, undefined, 1 );
    }
    
    return groupid;
}

// Namespace ai_mp_controller
// Params 2, eflags: 0x4
// Checksum 0x9ab8b5b4, Offset: 0x2ae9
// Size: 0x53
function private function_6af1673c64d38889( subarea, grouporigin )
{
    if ( level.var_15fb757c9b81d8c4 && getdvarint( @"hash_520514762c795b5f", 1 ) == 1 )
    {
        groupid = function_ac54b3e73517562e( subarea, grouporigin, "default_group" );
    }
    
    return groupid;
}

// Namespace ai_mp_controller
// Params 0, eflags: 0x4
// Checksum 0x988b3e7a, Offset: 0x2b45
// Size: 0xa4
function private function_141f09ffc03beb1f()
{
    level.agent_funcs[ "soldier" ][ "on_damaged" ] = &common_agent_damage::callbacksoldieragentdamaged;
    level.agent_funcs[ "soldier" ][ "gametype_on_killed" ] = &mp_agent_damage::callbacksoldieragentgametypekilled;
    level.agent_funcs[ "juggernaut" ][ "on_damaged" ] = &agent_juggernaut::function_627f8022f4c1c67b;
    level.agent_funcs[ "juggernaut" ][ "gametype_on_killed" ] = &mp_agent_damage::callbacksoldieragentgametypekilled;
    level.agent_funcs[ "dog" ][ "on_damaged" ] = &common_agent_damage::callbacksoldieragentdamaged;
    level.agent_funcs[ "dog" ][ "gametype_on_killed" ] = &mp_agent_damage::callbacksoldieragentgametypekilled;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xccb72d23, Offset: 0x2bf1
// Size: 0x3400
function spawn( params )
{
    if ( !level.supportsai )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the level doesn't support AI" ?? "undefined" ] );
        assert( getdvarint( @"hash_544b3ba28c5f683e", 0 ) == 1, "<dev string:x86>" );
        return;
    }
    
    if ( !isstring( params.agenttype ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the agentType was undefined or not a string" ?? "undefined" ] );
        assertmsg( "<dev string:xb8>" );
        return;
    }
    
    if ( !isstring( params.priority ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the priority was undefined or not a string" ?? "undefined" ] );
        assertmsg( "<dev string:xf9>" );
        return;
    }
    
    if ( !isstring( params.category ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the category was undefined or not a string" ?? "undefined" ] );
        assertmsg( "<dev string:x139>" );
        return;
    }
    
    if ( !isvector( params.groundspawnorigin ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the groundSpawnOrigin was undefined or not a vector" ?? "undefined" ] );
        assertmsg( "<dev string:x179>" );
        return;
    }
    
    if ( function_32b7182f3fd68764( params.agenttype ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the agentType: " + params.agenttype + ( " has been banned with with dvar scr_ai_remove" ?? "undefined" ) ] );
        return;
    }
    
    if ( !function_9054551769234331( params.agenttype ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because the agentType: " + params.agenttype + ( " is invalid. Perhaps it is not included in the map?" ?? "undefined" ) ] );
        assertmsg( "<dev string:x1c2>" + params.agenttype + "<dev string:x1e7>" );
        return;
    }
    
    if ( params.var_a79f90eb7b145708 && !function_70e37a6815917e5f( 1, 0 ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because it was a revive from dormancy, but we were at max agents. This shouldn't be possible" ?? "undefined" ] );
        assertmsg( "<dev string:x21b>" );
        return;
    }
    
    if ( poi::poi_issystemactive() )
    {
        if ( !isdefined( params.subarea ) )
        {
            params.subarea = _subarea_findfromorigin( params.groundspawnorigin, undefined, undefined, 1 );
        }
        
        if ( params.subarea && !utility::callsharedfunc( #"poi", #"area_isareaactive", params.subarea.areaname ) )
        {
            dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because this area is not active: " + ( params.subarea.areaname ?? "undefined" ) ] );
            assertmsg( "<dev string:x285>" + params.subarea.areaname );
            return;
        }
        
        if ( params.subarea.poiname && !utility::callsharedfunc( #"poi", #"poi_ispoiactive", params.subarea.poiname ) )
        {
            dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "Spawn failed because this POI is not active: " + ( params.subarea.poiname ?? "undefined" ) ] );
            assertmsg( "<dev string:x2b4>" + params.subarea.poiname );
            return;
        }
        
        if ( params.subarea )
        {
            if ( !isdefined( params.subarea.var_a81a24188ad05f66 ) )
            {
                params.subarea.var_a81a24188ad05f66 = 0;
            }
        }
    }
    
    if ( !isdefined( params.team ) )
    {
        params.team = agent_utils::function_25b40f5accbca0dd( undefined, params.agenttype );
    }
    
    if ( !params.insidegoalvolume && ( !flags::gameflag( "prematch_done" ) || level.var_6c32e5d8baac049b ) )
    {
        params.insidegoalvolume = utility::callsharedfunc( #"insideoutside", #"hash_52dba1b85cf38a4", params.groundspawnorigin );
        
        if ( params.insidegoalvolume.targetname )
        {
            linkednode = utility::getstruct( params.insidegoalvolume.targetname, "target" );
            
            if ( linkednode.script_noteworthy && issubstr( linkednode.script_noteworthy, "cluster" ) )
            {
                params.var_9798188c1cb9a97b = 0;
            }
        }
    }
    
    if ( !params.var_a79f90eb7b145708 )
    {
        if ( !isdefined( params.groupid ) )
        {
            params.groupid = function_6af1673c64d38889( params.subarea, params.groundspawnorigin );
        }
    }
    
    params.groundspawnorigin = getclosestpointonnavmesh( params.groundspawnorigin );
    
    if ( !isdefined( params.combatrole ) )
    {
        params.combatrole = 0;
    }
    
    if ( isstring( params.combatrole ) )
    {
        if ( params.combatrole == "Defend Position" )
        {
            params.combatrole = 1;
        }
        else
        {
            params.combatrole = 0;
        }
    }
    
    if ( !isdefined( params.category ) )
    {
        params.category = "unassigned";
    }
    
    if ( !isdefined( params.subcategory ) )
    {
        params.subcategory = "unassigned";
    }
    
    if ( !isdefined( params.var_4f8a92ebabf37ee ) )
    {
        params.var_4f8a92ebabf37ee = 1;
    }
    
    if ( !isdefined( params.var_9798188c1cb9a97b ) )
    {
        params.var_9798188c1cb9a97b = 1;
    }
    
    params.priorityint = agent_utils::function_d6d4e4f85ad3876c( params.priority );
    spawndormant = params.forcedormant || !params.var_a79f90eb7b145708 && level.allowdormancy && params.var_4f8a92ebabf37ee && ( !flags::gameflagexists( "prematch_done" ) || !flags::gameflag( "prematch_done" ) );
    
    if ( spawndormant )
    {
        if ( isdefined( params.subarea ) )
        {
            var_36724054957fbcc9 = 1;
            params.subarea.var_a81a24188ad05f66++;
        }
        
        if ( !function_9054551769234331( params.agenttype ) )
        {
            dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "ERROR: validateAITypeName: Trying to spawn aiType " + params.agenttype + ( " that doesn't exist, please add aitype to level csv" ?? "undefined" ) ] );
            assertmsg( "<dev string:x2e2>" + params.agenttype + "<dev string:x315>" );
            return;
        }
        
        level.dormancystats.var_b86f9258513f2261++;
        dormancyid = agent_utils::function_83ec6d81ae3010dd( params.agenttype, params.groundspawnorigin, params.spawnangles, params.priority, params.category, params.subcategory, params.groupname, params.team, params.destination, params.subarea, params.skipstealth, undefined, undefined, undefined, params.radiationattachment, params.insidegoalvolume, params.combatrole, params.var_9798188c1cb9a97b, params.groupid, params.var_95ac5561735900db, params.awarenessoverride );
        processagentspawned( dormancyid, params.var_7fdb4b2f6d5b70fc );
        utility::callsharedfunc( #"poi", #"subarea_findandassignfordormancyid", params.groundspawnorigin, params.subarea, params.destination, dormancyid );
        priority_setbydormancyid( dormancyid, params.priority );
        function_d5798cf0bfdab8d8( dormancyid, params.category, params.subcategory, params.subarea );
        
        if ( var_36724054957fbcc9 )
        {
            params.subarea.var_a81a24188ad05f66--;
        }
        
        utility::callsharedfunc( #"analytics", #"agent_alloc", params.groundspawnorigin, params.agenttype );
        return dormancyid;
    }
    
    if ( params.var_a79f90eb7b145708 )
    {
        params.spawnattempts = 1;
    }
    else
    {
        if ( !isdefined( level.var_ffc70913a984203d ) )
        {
            level.var_ffc70913a984203d = [];
        }
        
        level.var_ffc70913a984203d[ level.var_ffc70913a984203d.size ] = params;
        level thread function_5f420d7fc9be796b();
        params utility::ent_flag_wait( "spawn" );
    }
    
    if ( params.subarea )
    {
        var_36724054957fbcc9 = 1;
        params.subarea.var_a81a24188ad05f66++;
    }
    
    for ( i = 0; i < 3 && params.spawnattempts > 0 ; i++ )
    {
        var_806f9532c17f4724 = !params.var_a79f90eb7b145708 && !function_5c695081e6879c5f( 1, params.category, params.groundspawnorigin, params.subarea, spawndormant );
        
        if ( var_806f9532c17f4724 )
        {
            [ success, _ ] = function_5bfa6c76d9ee8a56( params.priority, params.groundspawnorigin, params.subarea, level.var_12432cff12cc38ec );
            
            if ( !success )
            {
                message = "tryToMakeSpaceForAgent failed for " + params.agenttype + " at " + params.groundspawnorigin + " priority: " + params.priority + " because there were no agents to kill with a lower priority. AI Count: " + function_6c8e1135c28125d0( "everybody" );
                println( message );
                dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", message ?? "undefined" ] );
                params.spawnattempts = 0;
                
                if ( var_36724054957fbcc9 )
                {
                    params.subarea.var_a81a24188ad05f66--;
                }
                
                return;
            }
            else
            {
                println( "<dev string:x349>" + params.agenttype + "<dev string:x36f>" + params.groundspawnorigin + "<dev string:x374>" + params.priority + "<dev string:x380>" + function_6c8e1135c28125d0( "<dev string:x38b>" ) );
            }
        }
        
        agent = function_a19eb749238534b3( params.agenttype, params.groundspawnorigin, params.spawnangles, params.priority, params.category, params.subcategory, params.groupname, params.team, params.destination, params.subarea, params.skipstealth, params.radiationattachment, params.var_cae8263562118c46 );
        
        if ( agent )
        {
            params.spawnattempts = 0;
            break;
        }
        
        waitframe();
    }
    
    if ( !agent )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", params.agenttype ?? "undefined", "ground_spawn_origin_x", params.groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", params.groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", params.groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", params.spawnangles[ 0 ] ?? 0, "spawn_angles_y", params.spawnangles[ 1 ] ?? 0, "spawn_angles_z", params.spawnangles[ 2 ] ?? 0, "priority", params.priority ?? "undefined", "category", params.category ?? "undefined", "subcategory", params.subcategory ?? "undefined", "group_name", params.groupname ?? "undefined", "team", params.team ?? "undefined", "destination_x", params.destination[ 0 ] ?? 0, "destination_y", params.destination[ 1 ] ?? 0, "destination_z", params.destination[ 2 ] ?? 0, "sub_area_name", params.subarea.subareaname ?? "undefined", "skip_stealth", params.skipstealth ?? 0, "revive_from_dormancy", params.var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", params.var_4f8a92ebabf37ee ?? 1, "agent_override_types", params.var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", params.forcedormant ?? 0, "result", "ERROR: Max spawn attempts exceeded of aiType: " + ( params.agenttype ?? "undefined" ) ] );
        assertmsg( "<dev string:x395>" + params.agenttype );
        return;
    }
    
    if ( !params.var_a79f90eb7b145708 && level.var_15fb757c9b81d8c4 )
    {
        function_b44bc58cb5fea251( agent, params.groupid );
    }
    
    if ( !params.var_4f8a92ebabf37ee )
    {
        agent.var_4f8a92ebabf37ee = 0;
    }
    
    agent.groupid = params.groupid;
    agent.var_95ac5561735900db = params.var_95ac5561735900db;
    agent.awarenessoverride = params.awarenessoverride;
    agent.radiationattachment = params.radiationattachment;
    agent.combatrole = params.combatrole;
    agent.var_9798188c1cb9a97b = params.var_9798188c1cb9a97b;
    agent.insidegoalvolume = params.insidegoalvolume;
    agent.spawn_loc = agent.origin;
    
    if ( params.skipstealth )
    {
        agent.script_groupname = params.groupname;
    }
    
    if ( var_36724054957fbcc9 )
    {
        params.subarea.var_a81a24188ad05f66--;
    }
    
    utility::callsharedfunc( #"analytics", #"agent_spawn", agent );
    
    /#
        if ( 0 && params.category == "<dev string:x3c4>" )
        {
            thread debug::drawsphere( params.groundspawnorigin, 64, 500, ( 0, 1, 0 ) );
        }
        
        utility::callsharedfunc( #"logging", #"addevent", "<dev string:x3cc>", "<dev string:x3d8>" + params.priority, params.category + "<dev string:x3e2>" + params.subcategory, undefined, undefined, undefined, undefined, params.groundspawnorigin );
        
        if ( var_806f9532c17f4724 && getdvarint( @"hash_bcbe3309344bb6d2", 0 ) == 1 )
        {
            level thread utility::draw_arrow_time( agent.origin + ( 0, 0, 250 ), agent.origin + ( 0, 0, 3000 ), ( 0, 1, 0 ), 120 );
            print3d( agent.origin + ( 0, 0, 105 ), "<dev string:x3e4>", ( 0, 1, 0 ), 1, 0.6, 6000 );
            print3d( agent.origin + ( 0, 0, 90 ), "<dev string:x400>" + params.priority, ( 0, 1, 0 ), 1, 0.4, 6000 );
            print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x40b>" + params.category, ( 0, 1, 0 ), 1, 0.4, 6000 );
            print3d( agent.origin + ( 0, 0, 70 ), "<dev string:x416>" + params.subcategory, ( 0, 1, 0 ), 1, 0.4, 6000 );
            println( "<dev string:x424>" + params.priority + "<dev string:x449>" + params.category + "<dev string:x458>" + params.subcategory );
        }
        
        if ( gettime() == level.var_a86c082b7074bf97 )
        {
            assertmsg( "<dev string:x46a>" );
        }
        
        level.var_a86c082b7074bf97 = gettime();
    #/
    
    processagentspawned( agent, params.var_7fdb4b2f6d5b70fc );
    utility::callsharedfunc( #"aitype_custom", #"hash_28787cc02985b77e", agent, params.agenttype );
    agent.revive_bleedouttime = 12000;
    agent.var_a2591b7b6a16fd5d = 1;
    agent.var_91ede26d566695da = 1000;
    return agent;
}

// Namespace ai_mp_controller
// Params 0, eflags: 0x4
// Checksum 0x59bed761, Offset: 0x5ffa
// Size: 0x16f
function private function_5f420d7fc9be796b()
{
    if ( level.var_17f3fe4c496fe1ea )
    {
        return;
    }
    
    level.var_17f3fe4c496fe1ea = 1;
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        function_a05013fdf74ddefa();
    }
    
    var_68e929eb8ae1058 = undefined;
    
    while ( level.var_ffc70913a984203d.size )
    {
        if ( !var_68e929eb8ae1058 )
        {
            foreach ( params in level.var_ffc70913a984203d )
            {
                if ( !var_68e929eb8ae1058 || params.priorityint < var_68e929eb8ae1058.priorityint )
                {
                    var_68e929eb8ae1058 = params;
                }
            }
        }
        
        if ( !isdefined( var_68e929eb8ae1058.spawnattempts ) )
        {
            var_68e929eb8ae1058.spawnattempts = 3;
            var_68e929eb8ae1058 utility::ent_flag_set( "spawn" );
        }
        
        waittillframeend();
        var_68e929eb8ae1058.spawnattempts -= 1;
        
        if ( var_68e929eb8ae1058.spawnattempts <= 0 )
        {
            level.var_ffc70913a984203d = arrayremove( level.var_ffc70913a984203d, var_68e929eb8ae1058 );
            var_68e929eb8ae1058 = undefined;
        }
        
        waitframe();
    }
    
    level.var_17f3fe4c496fe1ea = undefined;
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        function_50eaa7bac1992d13();
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x8af1e1ae, Offset: 0x6171
// Size: 0x41
function function_539a41091505b15b()
{
    self notify( #"hash_db43d3fffc68f85f" );
    self endon( #"hash_db43d3fffc68f85f" );
    function_a05013fdf74ddefa();
    wait ( level.var_2d69be251661fd85 + level.frameduration - gettime() ) / 1000;
    function_50eaa7bac1992d13();
}

// Namespace ai_mp_controller
// Params 23
// Checksum 0x5de4e454, Offset: 0x61ba
// Size: 0x19e6
function ai_mp_requestspawnagent( agenttype, groundspawnorigin, spawnangles, priority, category = "unassigned", subcategory = "unassigned", groupname, team, destination, subarea, skipstealth, var_a79f90eb7b145708, var_4f8a92ebabf37ee = 1, var_7fdb4b2f6d5b70fc, forcedormant, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b = 1, groupid, var_95ac5561735900db, var_cae8263562118c46, awarenessoverride )
{
    if ( isdmzgamemode() && getdvarint( @"hash_82c557f1c5dcf777", 1 ) == 1 )
    {
        return spawn( { #awarenessoverride:awarenessoverride, #var_cae8263562118c46:var_cae8263562118c46, #var_95ac5561735900db:var_95ac5561735900db, #groupid:groupid, #var_9798188c1cb9a97b:var_9798188c1cb9a97b, #combatrole:combatrole, #insidegoalvolume:insidegoalvolume, #radiationattachment:radiationattachment, #forcedormant:forcedormant, #var_7fdb4b2f6d5b70fc:var_7fdb4b2f6d5b70fc, #var_4f8a92ebabf37ee:var_4f8a92ebabf37ee, #var_a79f90eb7b145708:var_a79f90eb7b145708, #skipstealth:skipstealth, #subarea:subarea, #destination:destination, #team:team, #groupname:groupname, #subcategory:subcategory, #category:category, #priority:priority, #spawnangles:spawnangles, #groundspawnorigin:groundspawnorigin, #agenttype:agenttype } );
    }
    
    if ( !level.supportsai )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "Spawn failed because the level doesn't support AI" ?? "undefined" ] );
        return;
    }
    
    if ( !isdefined( agenttype ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "Spawn failed because the agentType was undefined" ?? "undefined" ] );
        return;
    }
    
    if ( function_32b7182f3fd68764( agenttype ) )
    {
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "Spawn failed because the agentType: " + agenttype + ( " has been banned with with dvar scr_ai_remove" ?? "undefined" ) ] );
        return;
    }
    
    assert( isdefined( groundspawnorigin ) && isdefined( priority ) && isdefined( category ), "<dev string:x507>" );
    assert( isstring( category ), "<dev string:x55a>" );
    
    if ( !isdefined( subarea ) )
    {
        subarea = _subarea_findfromorigin( groundspawnorigin, undefined, undefined, 1 );
    }
    
    if ( isdefined( subarea ) && poi::poi_issystemactive() )
    {
        isareaactive = utility::callsharedfunc( #"poi", #"area_isareaactive", subarea.areaname );
        
        if ( !isareaactive )
        {
            println( "<dev string:x58d>" + subarea.areaname + "<dev string:x5b7>" );
            dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "Spawn failed because this area is not active: " + ( subarea.areaname ?? "undefined" ) ] );
            return;
        }
        
        if ( isdefined( subarea.poiname ) )
        {
            ispoiactive = utility::callsharedfunc( #"poi", #"poi_ispoiactive", subarea.poiname );
            
            if ( !ispoiactive )
            {
                println( "<dev string:x5c8>" + subarea.poiname + "<dev string:x5b7>" );
                dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "Spawn failed because this POI is not active: " + ( subarea.poiname ?? "undefined" ) ] );
                return;
            }
        }
    }
    
    if ( !isdefined( team ) )
    {
        team = agent_utils::function_25b40f5accbca0dd( undefined, agenttype );
    }
    
    spawndormant = !var_a79f90eb7b145708 && level.allowdormancy && var_4f8a92ebabf37ee;
    
    if ( spawndormant && !forcedormant )
    {
        spawndormant = !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" );
    }
    
    var_36724054957fbcc9 = 0;
    
    if ( isdefined( subarea ) && !isdefined( subarea.var_a81a24188ad05f66 ) )
    {
        subarea.var_a81a24188ad05f66 = 0;
    }
    
    success = 0;
    groundspawnorigin = getclosestpointonnavmesh( groundspawnorigin );
    
    if ( !isdefined( insidegoalvolume ) && ( !flags::gameflag( "prematch_done" ) || level.var_6c32e5d8baac049b ) )
    {
        insidegoalvolume = utility::callsharedfunc( #"insideoutside", #"hash_52dba1b85cf38a4", groundspawnorigin );
        
        if ( insidegoalvolume && insidegoalvolume.targetname )
        {
            linkednode = utility::getstruct( insidegoalvolume.targetname, "target" );
            
            if ( linkednode.script_noteworthy && issubstr( linkednode.script_noteworthy, "cluster" ) )
            {
                var_9798188c1cb9a97b = 0;
            }
        }
    }
    
    if ( !var_a79f90eb7b145708 )
    {
        if ( !isdefined( groupid ) )
        {
            groupid = function_6af1673c64d38889( subarea, groundspawnorigin );
        }
    }
    
    var_89281547acb19ed9 = level.var_15fb757c9b81d8c4;
    var_31cd142b069f25e3 = var_89281547acb19ed9 && var_a79f90eb7b145708;
    
    if ( spawndormant )
    {
        if ( isdefined( subarea ) )
        {
            var_36724054957fbcc9 = 1;
            subarea.var_a81a24188ad05f66++;
        }
        
        if ( !function_9054551769234331( agenttype ) )
        {
            return;
        }
        
        level.dormancystats.var_b86f9258513f2261++;
        dormancyid = agent_utils::function_83ec6d81ae3010dd( agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, undefined, undefined, undefined, radiationattachment, insidegoalvolume, combatrole, var_9798188c1cb9a97b, groupid, var_95ac5561735900db, awarenessoverride );
        processagentspawned( dormancyid, var_7fdb4b2f6d5b70fc );
        utility::callsharedfunc( #"poi", #"subarea_findandassignfordormancyid", groundspawnorigin, subarea, destination, dormancyid );
        priority_setbydormancyid( dormancyid, priority );
        function_d5798cf0bfdab8d8( dormancyid, category, subcategory, subarea );
        
        if ( var_36724054957fbcc9 )
        {
            subarea.var_a81a24188ad05f66--;
        }
        
        if ( utility::issharedfuncdefined( #"analytics", #"agent_alloc" ) )
        {
            [[ utility::getsharedfunc( #"analytics", #"agent_alloc" ) ]]( groundspawnorigin, agenttype );
        }
        
        return dormancyid;
    }
    
    assert( !var_31cd142b069f25e3 || function_70e37a6815917e5f( 1, 0 ) );
    var_7a6d859df4c2ee8 = 1;
    
    if ( !var_a79f90eb7b145708 )
    {
        var_7a6d859df4c2ee8 = function_5c695081e6879c5f( 1, category, groundspawnorigin, subarea, spawndormant );
    }
    
    if ( !var_7a6d859df4c2ee8 )
    {
        [ success, var_ab0e886cd95a1b2d ] = function_5bfa6c76d9ee8a56( priority, groundspawnorigin, subarea, level.var_12432cff12cc38ec );
        
        if ( !success )
        {
            println( "<dev string:x5f1>" + agenttype + "<dev string:x614>" );
            dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "tryToMakeSpaceForAgent failed because there were no agents to kill with a lower priority" ?? "undefined" ] );
            return;
        }
        
        println( "<dev string:x650>" + var_ab0e886cd95a1b2d );
        
        if ( level.var_2d69be251661fd85 <= gettime() )
        {
            level.var_2d69be251661fd85 = gettime() + 2 * level.frameduration;
        }
    }
    
    if ( level.var_2d69be251661fd85 > gettime() && !var_31cd142b069f25e3 || !var_7a6d859df4c2ee8 )
    {
        level.var_2d69be251661fd85 += level.frameduration;
        
        if ( var_89281547acb19ed9 )
        {
            level thread function_539a41091505b15b();
        }
        
        level.var_12432cff12cc38ec++;
        wait ( level.var_2d69be251661fd85 - gettime() ) / 1000;
        level.var_12432cff12cc38ec--;
    }
    
    if ( isdefined( subarea ) )
    {
        var_36724054957fbcc9 = 1;
        subarea.var_a81a24188ad05f66++;
    }
    
    agent = function_a19eb749238534b3( agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, radiationattachment, var_cae8263562118c46 );
    
    if ( !isdefined( agent ) )
    {
        testtype = agenttype;
        
        if ( isdefined( level.var_1e2c07e345d293d1 ) )
        {
            testtype = [[ level.var_1e2c07e345d293d1 ]]( testtype );
        }
        
        dlog_recordevent( "dlog_event_ai_spawn_attempt_fail", [ "agent_type", agenttype ?? "undefined", "ground_spawn_origin_x", groundspawnorigin[ 0 ] ?? 0, "ground_spawn_origin_y", groundspawnorigin[ 1 ] ?? 0, "ground_spawn_origin_z", groundspawnorigin[ 2 ] ?? 0, "spawn_angles_x", spawnangles[ 0 ] ?? 0, "spawn_angles_y", spawnangles[ 1 ] ?? 0, "spawn_angles_z", spawnangles[ 2 ] ?? 0, "priority", priority ?? "undefined", "category", category ?? "undefined", "subcategory", subcategory ?? "undefined", "group_name", groupname ?? "undefined", "team", team ?? "undefined", "destination_x", destination[ 0 ] ?? 0, "destination_y", destination[ 1 ] ?? 0, "destination_z", destination[ 2 ] ?? 0, "sub_area_name", subarea.subareaname ?? "undefined", "skip_stealth", skipstealth ?? 0, "revive_from_dormancy", var_a79f90eb7b145708 ?? 0, "can_spawn_dormant", var_4f8a92ebabf37ee ?? 1, "agent_override_types", var_7fdb4b2f6d5b70fc ?? "undefined", "force_dormant", forcedormant ?? 0, "result", "_spawnAgent returned undefined, type: " + testtype + ", IsAITypeNameValid: " + isaitypenamevalid( testtype ) + ( ". check the console.log for: Failed to spawn agent of ai type..." ?? "undefined" ) ] );
        return;
    }
    
    if ( !var_a79f90eb7b145708 && level.var_15fb757c9b81d8c4 )
    {
        function_b44bc58cb5fea251( agent, groupid );
    }
    
    if ( !var_4f8a92ebabf37ee )
    {
        agent.var_4f8a92ebabf37ee = 0;
    }
    
    agent.groupid = groupid;
    agent.var_95ac5561735900db = var_95ac5561735900db;
    agent.awarenessoverride = awarenessoverride;
    agent.radiationattachment = radiationattachment;
    agent.spawn_loc = agent.origin;
    
    if ( !isdefined( combatrole ) )
    {
        combatrole = 0;
    }
    else if ( isstring( combatrole ) )
    {
        if ( combatrole == "Defend Position" )
        {
            combatrole = 1;
        }
        else
        {
            combatrole = 0;
        }
    }
    
    agent.combatrole = combatrole;
    agent.var_9798188c1cb9a97b = var_9798188c1cb9a97b;
    agent.insidegoalvolume = insidegoalvolume;
    
    if ( skipstealth )
    {
        agent.script_groupname = groupname;
    }
    
    if ( var_36724054957fbcc9 )
    {
        subarea.var_a81a24188ad05f66--;
    }
    
    if ( utility::issharedfuncdefined( #"analytics", #"agent_spawn" ) )
    {
        [[ utility::getsharedfunc( #"analytics", #"agent_spawn" ) ]]( agent );
    }
    
    /#
        if ( 0 && category == "<dev string:x3c4>" )
        {
            thread debug::drawsphere( groundspawnorigin, 64, 500, ( 0, 1, 0 ) );
        }
        
        if ( utility::issharedfuncdefined( #"logging", #"addevent" ) )
        {
            [[ utility::getsharedfunc( #"logging", #"addevent" ) ]]( "<dev string:x3cc>", "<dev string:x3d8>" + priority, category + "<dev string:x3e2>" + subcategory, undefined, undefined, undefined, undefined, groundspawnorigin );
        }
        
        if ( !var_7a6d859df4c2ee8 && getdvarint( @"hash_bcbe3309344bb6d2", 0 ) == 1 )
        {
            level thread utility::draw_arrow_time( agent.origin + ( 0, 0, 250 ), agent.origin + ( 0, 0, 3000 ), ( 0, 1, 0 ), 120 );
            print3d( agent.origin + ( 0, 0, 105 ), "<dev string:x3e4>", ( 0, 1, 0 ), 1, 0.6, 6000 );
            print3d( agent.origin + ( 0, 0, 90 ), "<dev string:x400>" + priority, ( 0, 1, 0 ), 1, 0.4, 6000 );
            print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x40b>" + category, ( 0, 1, 0 ), 1, 0.4, 6000 );
            print3d( agent.origin + ( 0, 0, 70 ), "<dev string:x416>" + subcategory, ( 0, 1, 0 ), 1, 0.4, 6000 );
            println( "<dev string:x424>" + priority + "<dev string:x449>" + category + "<dev string:x458>" + subcategory );
        }
    #/
    
    if ( level.var_2d69be251661fd85 <= gettime() )
    {
        level.var_2d69be251661fd85 = gettime() + level.frameduration;
    }
    
    /#
        if ( gettime() == level.var_a86c082b7074bf97 )
        {
            println( "<dev string:x46a>" );
        }
    #/
    
    level.var_a86c082b7074bf97 = gettime();
    processagentspawned( agent, var_7fdb4b2f6d5b70fc );
    utility::callsharedfunc( #"aitype_custom", #"hash_28787cc02985b77e", agent, agenttype );
    agent.revive_bleedouttime = 12000;
    agent.var_a2591b7b6a16fd5d = 1;
    agent.var_91ede26d566695da = 1000;
    return agent;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x734d784a, Offset: 0x7ba9
// Size: 0x30, Type: bool
function function_9054551769234331( agenttype )
{
    if ( !isaitypenamevalid( agenttype ) )
    {
        println( "<dev string:x2e2>" + agenttype + "<dev string:x315>" );
        return false;
    }
    
    return true;
}

// Namespace ai_mp_controller
// Params 13, eflags: 0x4
// Checksum 0x202b4c2, Offset: 0x7be2
// Size: 0x39c
function private function_a19eb749238534b3( agenttype, groundspawnorigin, spawnangles, priority, category, subcategory, groupname, team, destination, subarea, skipstealth, radiationattachment, var_cae8263562118c46 )
{
    if ( !isdefined( groundspawnorigin ) )
    {
        return;
    }
    
    agent = mp_agent::spawnnewagentaitype( agenttype, groundspawnorigin, spawnangles, team, undefined, undefined, undefined, var_cae8263562118c46 );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.baseaccuracy = getdvarfloat( @"hash_8aa5333ca3f377e5", 0.72 );
    agent.accuracy = agent.baseaccuracy;
    
    if ( agent.behaviortreeasset != %"rusher" && agent.unittype != "dog" )
    {
        agent.pathenemylookahead = 50;
        agent.pathenemyfightdist = 192;
        agent.meleechargedistvsplayer = 120;
    }
    
    agent pushplayer( 1 );
    
    if ( !getdvarint( @"hash_cb7e65d3dff416a6", 1 ) )
    {
        agent setplayeradvanceduavdot( 1 );
    }
    
    if ( poi::poi_issystemactive() )
    {
        utility::callsharedfunc( #"poi", #"hash_ff67e64a1cc4f956", agent, subarea, destination );
    }
    
    agent agent_utility::initplayerscriptvariables( 1 );
    agent.var_c6ac93c72ca9ad5e = getdvarint( @"hash_45a2b4489e57d085", 0 );
    function_d5798cf0bfdab8d8( agent, category, subcategory, subarea );
    priority_set( agent, priority );
    overridehealth = agent_utils::gethealthmax( agenttype );
    
    if ( overridehealth > 0 )
    {
        agent mp_agent::set_agent_health( overridehealth );
    }
    
    if ( !level.var_dedc9aa98a73db9c )
    {
        agent thread ai_behavior::function_f9ddb917447a3aee( agent );
    }
    
    if ( !function_228c61aaad28be29( agenttype ).iscivilian )
    {
        if ( !skipstealth )
        {
            function_eaa1a7e8a93ead9f( agent, groupname, subarea );
        }
        else
        {
            /#
                agent thread function_84f4b660279c3105();
            #/
        }
        
        agent_utils::function_b2aa0272588a7cdb( agent, 0 );
        agent thread squadmanager::addtosquad();
        agent thread weapons::watchgrenadeusage();
    }
    
    /#
        agent thread ai_behavior::function_5a3ac98c90419d38();
    #/
    
    agenttier = agent.tier;
    
    if ( !isdefined( agenttier ) )
    {
        agenttier = "undefined";
    }
    
    dlog_recordevent( "dlog_event_dmz_ai_spawn", [ "spawn_id", agent.persistent_unique_id, "ai_pos_x", groundspawnorigin[ 0 ], "ai_pos_y", groundspawnorigin[ 1 ], "ai_pos_z", groundspawnorigin[ 2 ], "ai_type", agenttype, "ai_tier", agenttier, "ai_status", "unknown", "ai_category", category, "ai_subcat", subcategory, "priority", priority, "ai_weapon_primary", agent.primaryweapon.basename, "ai_weapon_secondary", agent.secondaryweapon.basename, "ai_weapon_grenade", agent.grenadeweapon.basename, "match_time_elapsed", gettime() ] );
    return agent;
}

// Namespace ai_mp_controller
// Params 8
// Checksum 0xcf28d2de, Offset: 0x7f87
// Size: 0x28b
function function_b86341658788836c( node, areaname, subarea, spawnsetname, basetype, tier, nationality, optionalorigin )
{
    if ( !isdefined( basetype ) && isdefined( node.aitype ) && !issubstr( tolower( node.aitype ), "none" ) )
    {
        basetype = tolower( node.aitype );
    }
    
    if ( isdefined( basetype ) && function_c82ad53bf69763f4( basetype ) )
    {
        basetype = level.var_afd11bf80d0b43eb;
    }
    
    if ( isdefined( node ) && isdefined( node.script_noteworthy ) && !issubstr( node.script_noteworthy, "<custom" ) )
    {
        aitype = node.script_noteworthy;
        
        if ( function_32b7182f3fd68764( aitype ) )
        {
            return;
        }
        
        if ( function_6a6ed7333d6575c3( aitype ) )
        {
            aitype = function_f7aef6871cda828( level.var_afd11bf80d0b43eb, tier, nationality );
        }
    }
    else
    {
        if ( !isdefined( tier ) )
        {
            tier = function_b5b96d25a6551932( node, subarea );
        }
        
        if ( !isdefined( nationality ) )
        {
            nationality = function_5e289eb1f49885c4( node, subarea );
        }
        
        if ( !isdefined( basetype ) )
        {
            if ( !isdefined( spawnsetname ) )
            {
                spawnsetname = node.script_spawnset;
            }
            
            if ( !( isdefined( node ) && isdefined( node.script_noteworthy ) ) )
            {
                basetype = function_e0390bd2e60129e2( spawnsetname, tier );
            }
            else
            {
                basetype = function_c432e43e66484b0f( node, tier );
            }
        }
        
        if ( function_c82ad53bf69763f4( basetype ) )
        {
            basetype = level.var_afd11bf80d0b43eb;
        }
        
        if ( level.var_bc9012f254b7c104 && tier == 1 )
        {
            if ( optionalorigin )
            {
                var_16ba410437a14cd3 = optionalorigin;
            }
            else if ( node )
            {
                var_16ba410437a14cd3 = node.origin;
            }
            
            if ( var_16ba410437a14cd3 )
            {
                var_f4a7329f6cb09ca1 = ai_fortress::function_a38917c33bb50ae3( var_16ba410437a14cd3 );
                
                if ( !var_f4a7329f6cb09ca1 && ( basetype == "smg" || basetype == "shotgun" ) )
                {
                    basetype = "ar";
                }
                else if ( var_f4a7329f6cb09ca1 && basetype == "ar" )
                {
                    basetype = utility::cointoss() ? "smg" : "shotgun";
                }
            }
        }
        
        [ basetype, tier ] = function_645f17b4110b6735( basetype, tier );
        aitype = function_f7aef6871cda828( basetype, tier, nationality );
    }
    
    if ( !isaitypenamevalid( aitype ) )
    {
        basetype = "ar";
        aitype = function_f7aef6871cda828( basetype, tier, nationality );
    }
    
    return aitype;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xfb0f9b5d, Offset: 0x821b
// Size: 0x165
function function_c432e43e66484b0f( node, tier )
{
    if ( isdefined( node.aitype ) && !issubstr( tolower( node.aitype ), "none" ) )
    {
        return node.aitype;
    }
    
    if ( isdefined( node.script_spawnset ) )
    {
        return function_e0390bd2e60129e2( node.script_spawnset, tier );
    }
    
    if ( !isdefined( node.script_noteworthy ) )
    {
        return function_e0390bd2e60129e2( undefined, tier );
    }
    
    tokens = strtok( tolower( node.script_noteworthy ), "_" );
    
    if ( tokens.size == 1 || tokens.size == 2 && tokens[ 1 ] == "stationary" )
    {
        return function_e0390bd2e60129e2( undefined, tier );
    }
    else if ( tolower( tokens[ 0 ] ) == "spawnset" || tolower( tokens[ 1 ] ) == "spawnset" )
    {
        spawnsetname = function_cbac12bacf43b992( node );
        return function_e0390bd2e60129e2( spawnsetname, tier );
    }
    else if ( tokens.size >= 3 && tokens[ 1 ] == "stationary" )
    {
        if ( tolower( tokens[ 2 ] ) == "spawnset" )
        {
            spawnsetname = function_cbac12bacf43b992( node );
            return function_e0390bd2e60129e2( spawnsetname, tier );
        }
        else
        {
            return tokens[ 2 ];
        }
    }
    
    return tokens[ 1 ];
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x21ad51bb, Offset: 0x8389
// Size: 0x354
function function_645f17b4110b6735( type, tier )
{
    if ( !( isdefined( type ) && isdefined( tier ) ) )
    {
        return [ type, tier ];
    }
    
    if ( !level.var_5eb32b40214cd2f0 )
    {
        if ( type == "firebug" && tier != 1 )
        {
            return [ "firebug", 1 ];
        }
        
        if ( type == "strikeunit" && tier != 3 )
        {
            return [ "ar", 1 ];
        }
        
        if ( type == "wolf" && tier != 1 )
        {
            return [ "wolf", 1 ];
        }
        
        if ( type == "dog" && tier != 1 )
        {
            return [ "dog", 1 ];
        }
        
        return [ type, tier ];
    }
    
    if ( type == "strikeunit" && tier != 3 )
    {
        return [ level.var_afd11bf80d0b43eb, tier ];
    }
    
    if ( type == "lmg" && tier == 1 )
    {
        return [ level.var_afd11bf80d0b43eb, 1 ];
    }
    
    if ( type == "rifleman" && tier == 3 )
    {
        return [ "rifleman", 2 ];
    }
    
    if ( type == "sniper" && tier != 3 )
    {
        return [ "rifleman", tier ];
    }
    
    if ( type == "rpg" && tier == 3 )
    {
        return [ "rpg", 2 ];
    }
    
    if ( type == "antiair" && tier == 1 )
    {
        return [ level.var_afd11bf80d0b43eb, 1 ];
    }
    
    if ( type == "squadlead" && tier == 1 )
    {
        return [ level.var_afd11bf80d0b43eb, 1 ];
    }
    
    if ( type == "recon" && tier == 1 )
    {
        return [ level.var_afd11bf80d0b43eb, 1 ];
    }
    
    if ( type == "wolf" && tier != 1 )
    {
        return [ "wolf", 1 ];
    }
    
    if ( type == "dog" && tier != 1 )
    {
        return [ "dog", 1 ];
    }
    
    if ( type == "robotdogspot" && tier != 1 )
    {
        return [ "robotdogspot", 1 ];
    }
    
    if ( type == "robotdogtase" && tier != 1 )
    {
        return [ "robotdogtase", 1 ];
    }
    
    if ( type == "robotdogexpl" && tier != 1 )
    {
        return [ "robotdogexpl", 1 ];
    }
    
    if ( type == "pow" && tier != 1 )
    {
        return [ "pow", 1 ];
    }
    
    if ( type == "riotshield" && tier == 1 )
    {
        return [ level.var_afd11bf80d0b43eb, 1 ];
    }
    
    if ( type == "jugg" && tier != 3 )
    {
        return [ "jugg", 3 ];
    }
    
    return [ type, tier ];
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x52146461, Offset: 0x86e6
// Size: 0xa8
function function_cbac12bacf43b992( node )
{
    var_7237854e3be197ca = node.script_spawnset;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( node.script_noteworthy ) )
    {
        return;
    }
    
    tokens = strtok( node.script_noteworthy, "_" );
    stringstart = 15;
    
    if ( tokens[ 0 ] == "spawnset" )
    {
        stringstart = 9;
    }
    else if ( tokens[ 1 ] == "stationary" )
    {
        stringstart = 26;
    }
    
    return getsubstr( node.script_noteworthy, stringstart, node.script_noteworthy.size );
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x1733f46b, Offset: 0x8797
// Size: 0x251
function function_b5b96d25a6551932( node, subarea, origin )
{
    if ( !isdefined( node ) && isdefined( origin ) )
    {
        node = spawnstruct();
        node.origin = origin;
    }
    
    if ( isdefined( node ) )
    {
        if ( !isdefined( subarea ) )
        {
            subarea = _subarea_findfromorigin( node.origin );
        }
        
        if ( level.var_f8b1e9d1d264f480 )
        {
            var_7237854e3be197ca = utility::callsharedfunc( #"poi", #"hash_e883651dbecf55b4", node.origin );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        var_5df1f2431183d69d = 0;
        
        if ( isstring( node.script_tier ) )
        {
            var_5df1f2431183d69d = node.script_tier == "Top Tier";
        }
        
        if ( isdefined( node.script_tier ) && !var_5df1f2431183d69d )
        {
            if ( isstring( node.script_tier ) )
            {
                switch ( node.script_tier )
                {
                    case #"hash_a3b6a381e3787b0e":
                        return 1;
                    case #"hash_a3b6a281e378797b":
                        return 2;
                    case #"hash_a3b6a181e37877e8":
                        return 3;
                }
            }
            else
            {
                switch ( node.script_tier )
                {
                    case 1:
                        return 1;
                    case 2:
                        return 2;
                    case 3:
                        return 3;
                }
            }
        }
        
        if ( isdefined( subarea ) )
        {
            if ( !subarea.poiname )
            {
                tier = 1;
            }
            else if ( !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
            {
                tier = subarea.tuning.difficultyrating;
            }
            else
            {
                starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname );
                tier = function_7063710b1014b9d0( starlevel );
            }
        }
        else
        {
            return 1;
        }
        
        if ( !isdefined( tier ) || tier != 1 && tier != 2 && tier != 3 )
        {
            tier = 1;
        }
        
        return tier;
    }
    
    return 1;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x880d5f6b, Offset: 0x89f1
// Size: 0x71
function function_7063710b1014b9d0( starlevel = 0 )
{
    switch ( starlevel )
    {
        case 0:
        case 1:
        case 2:
        case 3:
            return 1;
        case 4:
            return 2;
        case 5:
            return 3;
    }
    
    return 1;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x6d8aef89, Offset: 0x8a6b
// Size: 0x83
function function_5e289eb1f49885c4( node, subarea )
{
    if ( isdefined( node ) )
    {
        if ( isdefined( node.nationality ) )
        {
            return node.nationality;
        }
        
        if ( !isdefined( subarea ) )
        {
            subarea = _subarea_findfromorigin( node.origin );
        }
        
        if ( isdefined( subarea ) && isdefined( subarea.tuning.nationalityoverride ) )
        {
            return subarea.tuning.nationalityoverride;
        }
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x75005cf9, Offset: 0x8af7
// Size: 0x129
function function_f01ba6e0f900ed5a( spawnset, tier )
{
    cleanedspawnset = [];
    var_243d481af7b6c290 = [];
    
    foreach ( tierkey, tiertypes in level.var_88b3cfa83abf5242 )
    {
        if ( tierkey == tier )
        {
            continue;
        }
        
        var_243d481af7b6c290 = arraycombine( var_243d481af7b6c290, tiertypes );
    }
    
    foreach ( aitype in spawnset )
    {
        if ( !arraycontains( var_243d481af7b6c290, aitype ) )
        {
            cleanedspawnset[ cleanedspawnset.size ] = aitype;
        }
    }
    
    return cleanedspawnset;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xefdb333d, Offset: 0x8c29
// Size: 0x262
function function_e0390bd2e60129e2( spawnsetname, tier )
{
    savedname = spawnsetname;
    
    if ( isdefined( spawnsetname ) )
    {
        spawnsetname = utility::string_replace( tolower( spawnsetname ), " ", "_", 10 );
        spawnsetname = utility::string_replace( spawnsetname, "+", "plus", 10 );
    }
    else if ( !( isdefined( spawnsetname ) && isdefined( level.spawnset[ spawnsetname ] ) ) )
    {
        spawnsetname = level.defaultspawnset;
    }
    
    spawnset = level.spawnset[ spawnsetname ];
    
    if ( !isdefined( spawnset ) || spawnset.size == 0 )
    {
        spawnset = level.spawnset[ level.defaultspawnset ];
    }
    
    if ( isdefined( tier ) )
    {
        spawnset = function_f01ba6e0f900ed5a( spawnset, tier );
    }
    
    if ( isdefined( level.spawnsetchance[ spawnsetname ] ) )
    {
        var_c8c9425598346308 = [];
        
        foreach ( index, itemtickets in level.spawnsetchance[ spawnsetname ] )
        {
            if ( arraycontains( spawnset, index ) )
            {
                var_c8c9425598346308[ index ] = itemtickets;
            }
        }
        
        totaltickets = 0;
        
        foreach ( index, itemtickets in var_c8c9425598346308 )
        {
            totaltickets += itemtickets;
        }
        
        roll = randomint( totaltickets );
        chancetotal = 0;
        
        foreach ( index, itemtickets in var_c8c9425598346308 )
        {
            chancetotal += itemtickets;
            
            if ( roll <= chancetotal )
            {
                return index;
            }
        }
    }
    
    if ( spawnset.size > 0 )
    {
        return spawnset[ randomint( spawnset.size ) ];
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x267aea5c, Offset: 0x8e93
// Size: 0x63
function function_8d299531f8485be9( node )
{
    /#
        stealth_group = getdvar( @"hash_a839371d8b7bad64", "<dev string:x682>" );
        
        if ( stealth_group != "<dev string:x682>" )
        {
            return stealth_group;
        }
    #/
    
    if ( level.var_b42d35a5025b38b9 && isdefined( node.script_stealthgroup ) )
    {
        return node.script_stealthgroup;
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xaca017b3, Offset: 0x8eff
// Size: 0xd
function function_3a4bd0fc4d6012b0()
{
    return function_e0390bd2e60129e2( "guard" );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xad0e3197, Offset: 0x8f15
// Size: 0x46
function function_d8829485c05e8c1( basetype )
{
    if ( basetype && function_a7802a3d4292c781( basetype ) )
    {
        return "sk";
    }
    
    var_7237854e3be197ca = level.var_6c24585cf7e38ab9;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return "nk";
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x1c5e30e1, Offset: 0x8f64
// Size: 0xdf
function function_6556068e5d3a2fe5( nationalityid )
{
    if ( !isdefined( nationalityid ) )
    {
        if ( issubstr( level.mapname, "cruce" ) )
        {
            nationalityid = "mx";
        }
        else if ( issubstr( level.mapname, "saba" ) )
        {
            nationalityid = "aq";
        }
        else if ( issubstr( level.mapname, "bio_lab" ) )
        {
            nationalityid = "biolab";
        }
        else if ( issubstr( level.mapname, "delta" ) )
        {
            nationalityid = "ru";
        }
        else if ( issubstr( level.mapname, "sealion" ) )
        {
            nationalityid = "merc";
        }
        else if ( issubstr( level.mapname, "x01" ) )
        {
            nationalityid = "ru";
        }
        else
        {
            nationalityid = "nk";
        }
    }
    
    level.var_6c24585cf7e38ab9 = nationalityid;
}

// Namespace ai_mp_controller
// Params 4
// Checksum 0x8e70294d, Offset: 0x904b
// Size: 0x93
function function_5bfa6c76d9ee8a56( priority, requestedspawnorigin, subarea, var_4c7c74755620c668 )
{
    [ success, var_ab0e886cd95a1b2d ] = function_6fbf885620910c65( priority, 0, requestedspawnorigin, subarea, var_4c7c74755620c668 );
    
    if ( !success )
    {
        [ success, var_ab0e886cd95a1b2d ] = function_6fbf885620910c65( priority, 1, requestedspawnorigin, subarea, var_4c7c74755620c668 );
    }
    
    return [ success, var_ab0e886cd95a1b2d ];
}

// Namespace ai_mp_controller
// Params 5, eflags: 0x4
// Checksum 0xbb47bcc, Offset: 0x90e7
// Size: 0x3d0
function private function_6fbf885620910c65( priority, ruthless, requestedspawnorigin, subarea, var_4c7c74755620c668 )
{
    priorityint = function_f02c63b99c9614c9( level.aibudgets.priorities, priority );
    assert( isdefined( priorityint ), "<dev string:x683>" );
    var_d027382df50e048c = 0;
    
    if ( !isdefined( subarea ) )
    {
        subarea = _subarea_findfromorigin( requestedspawnorigin );
    }
    
    if ( isdefined( subarea ) )
    {
        reservedspots = subarea.var_a81a24188ad05f66 ?? 0;
    }
    else
    {
        reservedspots = 0;
    }
    
    if ( isdefined( subarea ) && isdefined( subarea.tuning ) && isarray( subarea.livingagents ) && subarea.livingagents.size + 1 + reservedspots <= subarea.tuning.var_2fdda594ff89a52d )
    {
        var_d027382df50e048c = 1;
    }
    
    numchecked = 0;
    agentlist = [];
    
    if ( isdefined( subarea ) && !var_d027382df50e048c )
    {
        foreach ( agent in subarea.livingagents )
        {
            if ( isagent( agent ) )
            {
                agentpriority = priority_get( agent );
                
                if ( isdefined( agentpriority ) && function_f02c63b99c9614c9( level.aibudgets.priorities, agentpriority ) > priorityint )
                {
                    agentlist[ agentlist.size ] = agent;
                }
                
                continue;
            }
            
            if ( isint( agent ) )
            {
                if ( agent_utils::function_d77442145c568a4e( agent ).priority > priorityint )
                {
                    agentlist[ agentlist.size ] = agent;
                }
            }
        }
    }
    else
    {
        foreach ( testpriority in level.aibudgets.var_433fb689ac1fc4ec )
        {
            if ( function_f02c63b99c9614c9( level.aibudgets.priorities, testpriority ) <= priorityint )
            {
                break;
            }
            
            agentlist = arraycombine( agentlist, function_785a96ce23c71388( testpriority ) );
        }
        
        if ( isdefined( subarea ) )
        {
            agentlist = utility::callsharedfunc( #"poi", #"hash_7a0fcb8e94df1242", subarea, agentlist );
        }
    }
    
    foreach ( agent in agentlist )
    {
        if ( !isagent( agent ) )
        {
            if ( function_4924ec5c785bcae7() + 1 + var_4c7c74755620c668 >= aibudget_maxagents() )
            {
                var_4649db5699a36bb0 = function_f60467f531120dab( priority, 1, requestedspawnorigin, subarea );
                
                if ( !var_4649db5699a36bb0 )
                {
                    return [ 0, undefined ];
                }
            }
            
            agent_utils::function_585134f4744c6f80( agent );
            return [ 1, 1 ];
        }
        else if ( agent function_d8ab643a577b6072( ruthless ) )
        {
            agent killoffagent( subarea );
            return [ 1, 0 ];
        }
        
        numchecked++;
        
        if ( numchecked % 30 == 0 )
        {
            waitframe();
        }
    }
    
    return [ 0, undefined ];
}

// Namespace ai_mp_controller
// Params 4
// Checksum 0x3b984f2c, Offset: 0x94c0
// Size: 0x1d6, Type: bool
function function_f60467f531120dab( priority, ruthless, requestedspawnorigin, subarea )
{
    numchecked = 0;
    priorityint = function_f02c63b99c9614c9( level.aibudgets.priorities, priority );
    assert( isdefined( priorityint ), "<dev string:x6aa>" );
    
    if ( !isdefined( subarea ) )
    {
        subarea = _subarea_findfromorigin( requestedspawnorigin );
    }
    
    foreach ( testpriority in level.aibudgets.var_433fb689ac1fc4ec )
    {
        if ( function_f02c63b99c9614c9( level.aibudgets.priorities, testpriority ) <= priorityint )
        {
            break;
        }
        
        agentlist = function_cabd4c7205695f09( testpriority );
        agentlist = arrayrandomize( agentlist );
        agentlist = utility::callsharedfunc( #"poi", #"hash_7a0fcb8e94df1242", subarea, agentlist );
        
        foreach ( agent in agentlist )
        {
            if ( agent function_d8ab643a577b6072( ruthless ) )
            {
                agent killoffagent( subarea );
                return true;
            }
            
            numchecked++;
            
            if ( numchecked % 30 == 0 )
            {
                waitframe();
            }
        }
    }
    
    return false;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xb4d79245, Offset: 0x969f
// Size: 0x311
function killoffagent( subarea )
{
    /#
        if ( utility::issharedfuncdefined( #"logging", #"addevent" ) )
        {
            [[ utility::getsharedfunc( #"logging", #"addevent" ) ]]( "<dev string:x6e5>", "<dev string:x3d8>" + priority_get( self ), self.category + "<dev string:x3e2>" + self.subcategory, undefined, undefined, undefined, self.poiname, self.origin );
        }
        
        if ( getdvarint( @"hash_bcbe3309344bb6d2", 0 ) == 1 )
        {
            level thread utility::draw_arrow_time( self.origin + ( 0, 0, 250 ), self.origin + ( 0, 0, 3000 ), ( 1, 0, 0 ), 120 );
            print3d( self.origin + ( 0, 0, 105 ), "<dev string:x6f0>", ( 1, 0, 0 ), 1, 0.6, 6000 );
            print3d( self.origin + ( 0, 0, 90 ), "<dev string:x400>" + priority_get( self ), ( 1, 0, 0 ), 1, 0.4, 6000 );
            print3d( self.origin + ( 0, 0, 80 ), "<dev string:x40b>" + self.category, ( 1, 0, 0 ), 1, 0.4, 6000 );
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x416>" + self.subcategory, ( 1, 0, 0 ), 1, 0.4, 6000 );
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x702>" + aibudget_maxagents() + "<dev string:x70b>" + function_4924ec5c785bcae7(), ( 1, 0, 0 ), 1, 0.4, 6000 );
            print3d( self.origin + ( 0, 0, 50 ), "<dev string:x717>" + ( subarea.subareaname ?? "<dev string:x71c>" ) + "<dev string:x726>" + ( subarea.tuning.var_2fdda594ff89a52d ?? "<dev string:x71c>" ) + "<dev string:x70b>" + ( subarea.livingagents.size ?? "<dev string:x71c>" ), ( 1, 0, 0 ), 1, 0.4, 6000 );
            iprintlnbold( "<dev string:x72c>" + priority_get( self ) + "<dev string:x449>" + self.category + "<dev string:x458>" + self.subcategory );
        }
    #/
    
    self.skipdeathcount = 1;
    self.nocorpse = 1;
    self kill();
}

// Namespace ai_mp_controller
// Params 1, eflags: 0x4
// Checksum 0xf20f0897, Offset: 0x99b8
// Size: 0x14d, Type: bool
function private function_d8ab643a577b6072( ruthless )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.health < 1 )
    {
        return false;
    }
    
    if ( self.dontkilloff )
    {
        return false;
    }
    
    if ( self.playing_skit )
    {
        return false;
    }
    
    if ( ai_behavior::is_specified_unittype( "juggernaut" ) )
    {
        return false;
    }
    
    if ( is_riding_vehicle() )
    {
        return false;
    }
    
    if ( !ruthless )
    {
        if ( isdefined( self.enemy ) && self canshootenemy() )
        {
            return false;
        }
    }
    
    if ( self.birthtime >= gettime() )
    {
        return false;
    }
    
    if ( ruthless )
    {
        return true;
    }
    
    var_18dfc05f9b3dfbb6 = get_see_recently_time_overrides();
    
    if ( isdefined( self.group ) && self.group.cqb_module )
    {
        var_586fe565fd077582 = 1000000;
    }
    else
    {
        var_586fe565fd077582 = 4000000;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        eplayer = level.players[ i ];
        
        if ( distancesquared( eplayer.origin, self.origin ) < var_586fe565fd077582 )
        {
            return false;
        }
        
        if ( self seerecently( eplayer, var_18dfc05f9b3dfbb6 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xe0da757e, Offset: 0x9b0e
// Size: 0x7c
function get_see_recently_time_overrides()
{
    if ( isdefined( self.see_recently_override ) )
    {
        return self.see_recently_override;
    }
    
    if ( isdefined( self.group ) )
    {
        if ( isdefined( self.group.last_seen_time_override ) )
        {
            return self.group.last_seen_time_override;
        }
        else if ( self.group.cqb_module )
        {
            return 2;
        }
        else
        {
            return 6;
        }
        
        return;
    }
    
    return 6;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x55e8ef98, Offset: 0x9b92
// Size: 0xc, Type: bool
function is_riding_vehicle()
{
    return isdefined( self.ridingvehicle );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xe21b0f7, Offset: 0x9ba7
// Size: 0x28
function function_2b1cc53b284373( function, context )
{
    callback::add( #"on_ai_killed", function, context );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x51a091c, Offset: 0x9bd7
// Size: 0x28
function function_52ec288d11c14408( function, context )
{
    callback::remove( #"on_ai_killed", function, context );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x3f44256d, Offset: 0x9c07
// Size: 0x15
function function_f682ec2dc94e0c15( agent )
{
    thread function_7d043230d3386c14( agent );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x1d85417f, Offset: 0x9c24
// Size: 0xd7
function function_7d043230d3386c14( agent )
{
    while ( true )
    {
        contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
        castresult = physics_raycast( level.player geteye(), agent geteye(), contents, undefined, 0, "physicsquery_closest", 0 );
        
        if ( distance( level.player.origin, agent.origin ) < 1500 && !agent cansee( level.player ) && !player::function_4ec00e606da98a80( level.player ) )
        {
            level.player throw_drill( agent );
            wait 5;
        }
        
        wait 0.5;
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xc39332ca, Offset: 0x9d03
// Size: 0xa9
function throw_drill( agent )
{
    drill_obj = magicgrenademanual( "rex_bunkerbuster_mp", agent.origin + ( 0, 0, 100 ), ( level.player.origin - agent.origin ) * 3 + ( 0, 0, 50 ), 100 );
    drill_obj.weapon_name = "rex_bunkerbuster_mp";
    drill_obj.owner = drill_obj;
    drill_obj.weapon_object = makeweapon( "rex_bunkerbuster_mp" );
    weapons::grenadeused( drill_obj );
}

/#

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x8e64a18, Offset: 0x9db4
    // Size: 0x10c, Type: dev
    function function_29cbb450c6f0ad35()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_d054932c3f2f177b", 0 ) != 0 )
            {
                tier = getdvarint( @"hash_d054932c3f2f177b", 0 );
                aitype = function_f7aef6871cda828( "<dev string:x743>", tier );
                agent = spawn( { #forcedormant:0, #var_4f8a92ebabf37ee:0, #var_a79f90eb7b145708:0, #skipstealth:0, #subcategory:"<dev string:x756>", #category:"<dev string:x74f>", #priority:"<dev string:x746>", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:level.players[ 0 ].origin, #agenttype:aitype } );
                agent_utils::overridetier3( agent );
                setdvar( @"hash_d054932c3f2f177b", 0 );
            }
        }
    }

#/

// Namespace ai_mp_controller
// Params 4, eflags: 0x4
// Checksum 0x3f8b0552, Offset: 0x9ec8
// Size: 0x45
function private _subarea_findfromorigin( origin, areaname, var_203430924a533062, var_e44426dd870f3753 )
{
    return utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", origin, areaname, var_203430924a533062, var_e44426dd870f3753 );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x1b5ab619, Offset: 0x9f16
// Size: 0x5e
function gather_nodes()
{
    game_utility::function_c4ff84a7288ed707();
    
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    if ( isdefined( level.var_c4303b727f0cc395 ) )
    {
        [[ level.var_c4303b727f0cc395 ]]();
    }
    
    function_748bfa4a5d87c300();
    function_453f92a1b13b7b9();
    function_cd96662e7d9cfff1();
    function_e559ab7cd630fae5();
    ai_behavior::skit_init();
    game_utility::function_48cf7b776b9642d3();
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xb21fc9da, Offset: 0x9f7c
// Size: 0x982
function function_748bfa4a5d87c300()
{
    var_6936719d5b9ca8c = utility::getstructarray( "agent_spawnpackageselector", "script_agent_noteworthy" );
    spawnpackageselectors = [];
    var_82efa7afbbedad5e = [];
    
    foreach ( spawnpackageselector in var_6936719d5b9ca8c )
    {
        if ( !isdefined( spawnpackageselector ) )
        {
            continue;
        }
        
        if ( !isdefined( spawnpackageselector.target ) )
        {
            continue;
        }
        
        spawnpackagenodes = utility::getstructarray( spawnpackageselector.target, "targetname" );
        
        if ( !isdefined( spawnpackagenodes ) || spawnpackagenodes.size <= 0 )
        {
            continue;
        }
        
        if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( spawnpackageselector.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( spawnpackageselector.groupid ) )
        {
            continue;
        }
        
        subarea = undefined;
        
        if ( poi::poi_issystemactive() )
        {
            subarea = _subarea_findfromorigin( spawnpackageselector.origin, undefined, 1, 1 );
            
            if ( isdefined( subarea ) )
            {
                subareaname = subarea.subareaname;
            }
        }
        
        if ( !isdefined( subarea ) )
        {
            continue;
        }
        
        spawnpackageselector.subarea = subarea;
        spawnpackageselector.spawnpackages = [];
        
        foreach ( spawnpackagenode in spawnpackagenodes )
        {
            spawnpackage = process_spawnpackage( spawnpackagenode, subarea );
            spawnpackage.script_required = spawnpackagenode.script_required;
            spawnpackageselector.spawnpackages[ spawnpackageselector.spawnpackages.size ] = spawnpackage;
        }
        
        spawnpackageselectors[ spawnpackageselectors.size ] = spawnpackageselector;
        var_82efa7afbbedad5e = arraycombine( var_82efa7afbbedad5e, spawnpackagenodes );
    }
    
    var_b3c19331f0bfa319 = utility::getstructarray( "agent_spawnpackage", "script_agent_noteworthy" );
    
    foreach ( spawnpackagenode in var_b3c19331f0bfa319 )
    {
        if ( !isdefined( spawnpackagenode.target ) )
        {
            continue;
        }
        
        if ( arraycontains( var_82efa7afbbedad5e, spawnpackagenode ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( spawnpackagenode.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( spawnpackagenode.groupid ) )
        {
            continue;
        }
        
        subarea = undefined;
        
        if ( poi::poi_issystemactive() )
        {
            subarea = _subarea_findfromorigin( spawnpackagenode.origin, undefined, 1, 1 );
            
            if ( isdefined( subarea ) )
            {
                subareaname = subarea.subareaname;
            }
        }
        
        if ( !isdefined( subarea ) )
        {
            continue;
        }
        
        spawnpackage = process_spawnpackage( spawnpackagenode, subarea );
        spawnpackage_required = 0;
        
        if ( isdefined( spawnpackagenode.script_required ) )
        {
            spawnpackage_required = istrue( int( spawnpackagenode.script_required ) );
        }
        else if ( isdefined( spawnpackagenode.required ) )
        {
            spawnpackage_required = spawnpackagenode.required == "1";
        }
        
        connectednodes = utility::getstructarray( spawnpackage.target, "targetname" );
        spawnpackage.connectednodes = connectednodes.size > 0 ? connectednodes : [];
        
        if ( spawnpackage_required )
        {
            subarea.spawnpackage_required[ subarea.spawnpackage_required.size ] = spawnpackage;
            continue;
        }
        
        subarea.spawnpackage_optional[ subarea.spawnpackage_optional.size ] = spawnpackage;
    }
    
    foreach ( spawnpackageselector in spawnpackageselectors )
    {
        var_9783496c71d43999 = [];
        
        if ( !isdefined( spawnpackageselector ) )
        {
            continue;
        }
        
        if ( !spawnpackageselector.spawnpackages )
        {
            spawnpackageselector.spawnpackages = [];
            var_b0d361dc76139225 = 1;
        }
        
        spawnpackagenodes = utility::getstructarray( spawnpackageselector.target, "targetname" );
        
        foreach ( spawnpackagenode in spawnpackagenodes )
        {
            if ( isdefined( spawnpackagenode.script_agent_noteworthy ) )
            {
                agent_noteworthy = tolower( spawnpackagenode.script_agent_noteworthy );
                
                if ( agent_noteworthy == "agent_spawnpackage" )
                {
                    if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( spawnpackagenode.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( spawnpackagenode.groupid ) )
                    {
                        continue;
                    }
                    
                    if ( var_b0d361dc76139225 )
                    {
                        spawnpackage = process_spawnpackage( spawnpackagenode, subarea );
                        spawnpackage.script_required = spawnpackagenode.script_required;
                        spawnpackageselector.spawnpackages[ spawnpackageselector.spawnpackages.size ] = spawnpackage;
                    }
                    
                    var_9783496c71d43999[ var_9783496c71d43999.size ] = spawnpackagenode;
                }
            }
        }
        
        if ( var_9783496c71d43999.size == 0 )
        {
            continue;
        }
        
        var_706d900bbb95c0bc = function_d5d4e9af3f136085( spawnpackageselector );
        
        if ( var_706d900bbb95c0bc )
        {
            var_d9747c5c313fe8a0 = [];
            
            foreach ( connectedspawnpackage in var_9783496c71d43999 )
            {
                if ( function_d5d4e9af3f136085( connectedspawnpackage ) )
                {
                    if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( connectedspawnpackage.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( connectedspawnpackage.groupid ) )
                    {
                        continue;
                    }
                    
                    spawnpackage = process_spawnpackage( connectedspawnpackage, spawnpackageselector.subarea );
                    spawnpackageselector.subarea.spawnpackage_required[ spawnpackageselector.subarea.spawnpackage_required.size ] = spawnpackage;
                    continue;
                }
                
                var_d9747c5c313fe8a0[ var_d9747c5c313fe8a0.size ] = connectedspawnpackage;
            }
            
            if ( isdefined( level.var_6c32e5d8baac049b ) )
            {
                var_d9747c5c313fe8a0 = arrayrandomize( var_d9747c5c313fe8a0 );
                
                foreach ( packagenode in var_d9747c5c313fe8a0 )
                {
                    if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( packagenode.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( packagenode.groupid ) )
                    {
                        continue;
                    }
                    
                    spawnpackage = process_spawnpackage( packagenode, spawnpackageselector.subarea );
                    break;
                }
            }
            else
            {
                var_2fddde68b8ed1a3b = utility::array_random( var_d9747c5c313fe8a0 );
                spawnpackage = process_spawnpackage( var_2fddde68b8ed1a3b, spawnpackageselector.subarea );
            }
            
            spawnpackageselector.subarea.spawnpackage_required[ spawnpackageselector.subarea.spawnpackage_required.size ] = spawnpackage;
            continue;
        }
        
        if ( isdefined( level.var_6c32e5d8baac049b ) )
        {
            if ( isdefined( level.var_6c32e5d8baac049b ) && isdefined( spawnpackageselector.groupid ) && tolower( level.var_6c32e5d8baac049b ) != tolower( spawnpackageselector.groupid ) )
            {
                continue;
            }
            else
            {
                spawnpackageselector.subarea.spawnpackage_optional[ spawnpackageselector.subarea.spawnpackage_optional.size ] = spawnpackageselector;
                connectednodes = utility::getstructarray( spawnpackageselector.target, "targetname" );
                spawnpackageselector.connectednodes = connectednodes.size > 0 ? connectednodes : [];
            }
            
            continue;
        }
        
        spawnpackageselector.subarea.spawnpackage_optional[ spawnpackageselector.subarea.spawnpackage_optional.size ] = spawnpackageselector;
        connectednodes = utility::getstructarray( spawnpackageselector.target, "targetname" );
        spawnpackageselector.connectednodes = connectednodes.size > 0 ? connectednodes : [];
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x7b890b5d, Offset: 0xa906
// Size: 0x197
function process_spawnpackage( spawnpackagemainnode, subarea )
{
    var_9006e3c30a579b23 = utility::getstructarray( spawnpackagemainnode.target, "targetname" );
    spawnpackage = spawnstruct();
    spawnpackage.origin = spawnpackagemainnode.origin;
    spawnpackage.guardnodes = [];
    spawnpackage.pathstructs = [];
    spawnpackage.subarea = subarea;
    
    foreach ( connectednode in var_9006e3c30a579b23 )
    {
        if ( isdefined( connectednode.script_agent_noteworthy ) )
        {
            agent_noteworthy = tolower( connectednode.script_agent_noteworthy );
            connectednode.subareaname = spawnpackage.subarea.subareaname;
            
            if ( agent_noteworthy == "agent_spawnnode_guard" )
            {
                spawnpackage.guardnodes[ spawnpackage.guardnodes.size ] = connectednode;
                continue;
            }
            
            if ( agent_noteworthy == "agent_spawnnode_patrolstart" )
            {
                pathstruct = function_ad7994ce0f8a6d54( connectednode );
                spawnpackage.pathstructs[ spawnpackage.pathstructs.size ] = pathstruct;
            }
        }
    }
    
    return spawnpackage;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x51417631, Offset: 0xaaa6
// Size: 0x61
function function_d5d4e9af3f136085( node )
{
    isrequired = 0;
    
    if ( isdefined( node.script_required ) )
    {
        isrequired = istrue( int( node.script_required ) );
    }
    else if ( isdefined( node.required ) )
    {
        isrequired = node.required == "1";
    }
    
    return isrequired;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xaa6442e6, Offset: 0xab10
// Size: 0xf9
function function_cd96662e7d9cfff1()
{
    var_e9817f4793cad59a = utility::getstructarray( "agent_roofpackage", "script_agent_noteworthy" );
    
    foreach ( roofpackagemainnode in var_e9817f4793cad59a )
    {
        if ( !isdefined( roofpackagemainnode.target ) )
        {
            continue;
        }
        
        subarea = undefined;
        
        if ( poi::poi_issystemactive() )
        {
            subarea = _subarea_findfromorigin( roofpackagemainnode.origin );
            roofpackagemainnode.subarea = subarea;
        }
        
        if ( !isdefined( subarea ) )
        {
            continue;
        }
        
        subarea.var_4dd2465177822d5c = utility::getstructarray( roofpackagemainnode.target, "targetname" );
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x14eee5e0, Offset: 0xac11
// Size: 0xf9
function function_453f92a1b13b7b9()
{
    var_eec9bbf0a58b31be = utility::getstructarray( "agent_patrolpackage", "script_agent_noteworthy" );
    
    foreach ( patrolpackagemainnode in var_eec9bbf0a58b31be )
    {
        if ( !isdefined( patrolpackagemainnode.target ) )
        {
            continue;
        }
        
        subarea = undefined;
        
        if ( poi::poi_issystemactive() )
        {
            subarea = _subarea_findfromorigin( patrolpackagemainnode.origin );
            patrolpackagemainnode.subarea = subarea;
        }
        
        if ( !isdefined( subarea ) )
        {
            continue;
        }
        
        subarea.var_173533fa4f4e7c30 = utility::getstructarray( patrolpackagemainnode.target, "targetname" );
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x775e4f3f, Offset: 0xad12
// Size: 0x19b
function function_e559ab7cd630fae5()
{
    level.patrolpaths = [];
    
    if ( poi::poi_issystemactive() )
    {
        utility::callsharedfunc( #"poi", #"subarea_addfeaturearray", "patrolPaths" );
    }
    
    patrolnodes = utility::getstructarray( "agent_spawnnode_patrolstart", "script_agent_noteworthy" );
    
    foreach ( node in patrolnodes )
    {
        pathstruct = function_ad7994ce0f8a6d54( node );
        
        if ( isdefined( pathstruct ) )
        {
            pathstruct.origin = node.origin;
            level.patrolpaths[ level.patrolpaths.size ] = pathstruct;
            
            if ( poi::poi_issystemactive() )
            {
                areaname = utility::callsharedfunc( #"poi", #"area_findoriginisin", node.origin, 0 );
                subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", node.origin );
                
                if ( !( isdefined( areaname ) && isdefined( subarea ) ) )
                {
                    return;
                }
                
                utility::callsharedfunc( #"poi", #"subarea_registerfeatureelement", areaname, subarea.subareaname, "patrolPaths", pathstruct );
            }
        }
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xb11585b8, Offset: 0xaeb5
// Size: 0x73
function function_3577bddb3d2f6b8()
{
    if ( utility::issharedfuncdefined( #"fortress", #"spawn" ) )
    {
        level waittill( #"infils_ready" );
        level.patrolpaths = undefined;
        return;
    }
    
    while ( !flags::gameflagexists( "prematch_done" ) || flags::gameflagexists( "prematch_done" ) && !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    level.patrolpaths = undefined;
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x39dada83, Offset: 0xaf30
// Size: 0x288
function function_ad7994ce0f8a6d54( node, forcelooped, var_d66824964601d0bb )
{
    var_7237854e3be197ca = node.pathstruct;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    path = [];
    index = 0;
    path[ index ] = node;
    pingpongpath = 0;
    
    if ( !forcelooped && isdefined( node.script_path_behavior ) && tolower( node.script_path_behavior ) == "ping pong" )
    {
        pingpongpath = 1;
    }
    
    if ( !isdefined( node.target ) )
    {
        return;
    }
    
    nextnodes = utility::getstructarray( path[ index ].target, "targetname" );
    
    if ( var_d66824964601d0bb )
    {
        foreach ( var_9837421609a21404 in nextnodes )
        {
            if ( var_9837421609a21404.script_noteworthy == var_d66824964601d0bb )
            {
                nextnode = var_9837421609a21404;
            }
        }
    }
    else
    {
        nextnode = utility::array_random( nextnodes );
    }
    
    if ( !isdefined( nextnode ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( !isdefined( path[ index ].target ) )
        {
            break;
        }
        
        nextnodes = utility::getstructarray( path[ index ].target, "targetname" );
        
        if ( var_d66824964601d0bb )
        {
            foreach ( var_9837421609a21404 in nextnodes )
            {
                if ( var_9837421609a21404.script_noteworthy == var_d66824964601d0bb )
                {
                    nextnode = var_9837421609a21404;
                }
            }
        }
        else
        {
            nextnode = utility::array_random( nextnodes );
        }
        
        if ( !isdefined( nextnode ) || node == nextnode || path[ index ] == nextnode )
        {
            break;
        }
        
        index++;
        path[ index ] = nextnode;
    }
    
    pathstruct = spawnstruct();
    pathstruct.path = path;
    pathstruct.claimed = 0;
    pathstruct.pingpongpath = pingpongpath;
    return pathstruct;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x9648676a, Offset: 0xb1c1
// Size: 0x10b
function function_92c5eb497593092e()
{
    level.var_c7c218e1b1b63e7f = level.looseguardnodes;
    
    foreach ( pathstruct in level.patrolpaths )
    {
        foreach ( node in pathstruct.path )
        {
            level.var_c7c218e1b1b63e7f[ level.var_c7c218e1b1b63e7f.size ] = node;
        }
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xda2d0c0d, Offset: 0xb2d4
// Size: 0x230
function aibudget_init()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    waittillframeend();
    level.aibudgets = spawnstruct();
    level.aibudgets.var_98c621455dab1223 = 0;
    level.aibudgets.categorymaxagents = [];
    function_56d1f269587ffc64( "everybody" );
    priority_init();
    
    if ( isdefined( level.var_6721bad5ee3a000e ) )
    {
        [[ level.var_6721bad5ee3a000e ]]();
    }
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        level.aibudgets.maxagents = getmaxagents();
    }
    else
    {
        level.aibudgets.maxagents = getmaxagents() - 1;
    }
    
    if ( isdefined( level.areas ) && isdefined( level.subareas ) )
    {
        level.aibudgets.areas = [];
        
        foreach ( areaname, area in level.areas )
        {
            level.aibudgets.areas[ areaname ] = [];
            
            foreach ( subareaname, subarea in level.areas[ areaname ][ "subAreas" ] )
            {
                struct = spawnstruct();
                struct.agentdeaths = 0;
                function_17bbb7bf0dab18d0( areaname + "_" + subareaname, "everybody" );
                level.aibudgets.areas[ areaname ][ subareaname ] = struct;
            }
        }
    }
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x50e4e181, Offset: 0xb50c
// Size: 0x64
function function_c19c505141ec3b3()
{
    aibudget_registercategories( [ "mission", "fortressGuards", "fortressPatrols", "reinforcements", "spawnPackage", "vehiclePatrol", "bosses", "bossMinions", "convoy_attack", "missions_ops" ] );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x887accf, Offset: 0xb578
// Size: 0x91
function function_7f833bacb64445a6()
{
    while ( !isdefined( level.agentarray ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.aibudgets.maxagents ) )
    {
        waitframe();
    }
    
    maxagents = aibudget_maxagents();
    
    while ( level.agentarray.size < maxagents )
    {
        waitframe();
    }
    
    if ( poi::poi_issystemactive() )
    {
        while ( !level.var_156349d932aabc45 )
        {
            waitframe();
        }
    }
    
    if ( getdvarint( @"sv_ai_spawn_director_enabled", 0 ) == 1 )
    {
        utility::flag_wait( "ai_spawn_director_initialized" );
    }
    
    waitframe();
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x9b627e28, Offset: 0xb611
// Size: 0x2a
function aibudget_registercategories( categoryarray )
{
    assert( isdefined( level.aibudgets ), "<dev string:x761>" );
    function_bca47dac6fd8350( categoryarray );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xef39848b, Offset: 0xb643
// Size: 0x78
function aibudget_registercategory( category, maxagents )
{
    assert( isdefined( level.aibudgets ) && isdefined( level.aibudgets.categorymaxagents ), "<dev string:x7a7>" );
    assert( isdefined( category ), "<dev string:x7eb>" );
    
    if ( isdefined( maxagents ) )
    {
        level.aibudgets.categorymaxagents[ category ] = maxagents;
    }
    
    function_56d1f269587ffc64( category );
}

// Namespace ai_mp_controller
// Params 4
// Checksum 0x592b7fb0, Offset: 0xb6c3
// Size: 0x119
function function_d5798cf0bfdab8d8( agent, category, subcategory, subarea )
{
    assert( isdefined( agent ), "<dev string:x7fe>" );
    assert( isdefined( level.aibudgets ), "<dev string:x829>" );
    assert( isdefined( agent ) && isdefined( category ) && isdefined( subcategory ), "<dev string:x86a>" );
    
    if ( isagent( agent ) )
    {
        agent.category = category;
        agent.subcategory = subcategory;
    }
    
    function_18a4cb5507def460( agent, category );
    
    if ( category != "everybody" )
    {
        function_18a4cb5507def460( agent, "everybody" );
    }
    
    if ( poi::poi_issystemactive() )
    {
        if ( isagent( agent ) && isdefined( agent.subarea ) )
        {
            subarea = agent.subarea;
        }
        
        if ( !isdefined( subarea ) )
        {
            return;
        }
        
        if ( category != "everybody" )
        {
            function_b26f6c697c8c4e3c( agent, subarea.areaname + "_" + subarea.subareaname, "everybody" );
        }
    }
}

// Namespace ai_mp_controller
// Params 2, eflags: 0x4
// Checksum 0x29c89b1e, Offset: 0xb7e4
// Size: 0x198
function private function_1b5040888fcd52e1( agent, var_704ccb49308e887d )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    assert( isdefined( level.aibudgets ), "<dev string:x89d>" );
    category = undefined;
    subcategory = undefined;
    subarea = undefined;
    
    if ( isagent( agent ) )
    {
        category = agent.category;
        subcategory = agent.subcategory;
        subarea = agent.subarea;
    }
    else if ( isint( agent ) )
    {
        if ( !isdefined( var_704ccb49308e887d ) )
        {
            var_704ccb49308e887d = agent_utils::function_d77442145c568a4e( agent );
        }
        
        category = var_704ccb49308e887d.category;
        subcategory = var_704ccb49308e887d.subcategory;
        subarea = var_704ccb49308e887d.subarea;
    }
    
    assert( isdefined( category ), "<dev string:x8e0>" );
    assert( isdefined( subcategory ), "<dev string:x925>" );
    function_8fb6dffb4a67c2a6( agent, category );
    
    if ( category != "everybody" )
    {
        function_8fb6dffb4a67c2a6( agent, "everybody" );
    }
    
    if ( poi::poi_issystemactive() && isdefined( subarea ) )
    {
        if ( function_eca0162064733e98( subarea.areaname + "_" + subarea.subareaname, category ) )
        {
            function_8b6cdf337c46498a( agent, subarea.areaname + "_" + subarea.subareaname, category );
        }
        
        if ( category != "everybody" )
        {
            function_8b6cdf337c46498a( agent, subarea.areaname + "_" + subarea.subareaname, "everybody" );
        }
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x87da3233, Offset: 0xb984
// Size: 0x39
function function_62448bd2c6f12ae9( category )
{
    assert( isdefined( level.aibudgets ), "<dev string:x96d>" );
    assert( isdefined( category ), "<dev string:x9b6>" );
    return function_7c7f41d3fd5028a5( category );
}

// Namespace ai_mp_controller
// Params 1, eflags: 0x4
// Checksum 0xb7beb1e7, Offset: 0xb9c6
// Size: 0x96
function private function_c770a300a5ce87c( category )
{
    assert( isdefined( level.aibudgets ) && isdefined( level.aibudgets.categorymaxagents ) && isdefined( level.aibudgets.categorymaxagents ), "<dev string:x9fb>" );
    assert( isdefined( category ), "<dev string:xa48>" );
    var_9abe005393d3996f = level.aibudgets.categorymaxagents[ category ];
    
    if ( !isdefined( var_9abe005393d3996f ) )
    {
        return;
    }
    
    return var_9abe005393d3996f - function_62448bd2c6f12ae9( category );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x6c561faa, Offset: 0xba65
// Size: 0x54
function function_70e37a6815917e5f( number, spawndormant )
{
    var_10a6c774b3faed20 = !spawndormant && function_4924ec5c785bcae7() + number <= aibudget_maxagents() || spawndormant && agent_utils::function_2ea3462d6f1960e7() + number <= agent_utils::function_771f3b959117f4e5();
    return var_10a6c774b3faed20;
}

// Namespace ai_mp_controller
// Params 5
// Checksum 0xff7934d0, Offset: 0xbac2
// Size: 0x57f
function function_5c695081e6879c5f( number, category, origin, subarea, spawndormant )
{
    assert( isdefined( level.aibudgets ) && isdefined( level.aibudgets.categorymaxagents ) && isdefined( level.aibudgets.categorymaxagents ), "<dev string:xa91>" );
    assert( isdefined( number ), "<dev string:xad6>" );
    var_10a6c774b3faed20 = function_70e37a6815917e5f( number + level.var_12432cff12cc38ec, spawndormant );
    
    if ( getdvarint( @"hash_a0cb2262bebb424b", 0 ) )
    {
        if ( !var_10a6c774b3faed20 )
        {
            dlog_recordevent( "dlog_event_cannot_spawn_agent", [ "number", number ?? 0, "category", category ?? "undefined", "origin_x", origin[ 0 ] ?? 0, "origin_y", origin[ 1 ] ?? 0, "origin_z", origin[ 2 ] ?? 0, "subarea_name", subarea.subareaname ?? "undefined", "spawn_dormant", spawndormant ?? 0, "total_alive_agents", function_4924ec5c785bcae7(), "max_agents", aibudget_maxagents(), "dormant_agent_count", agent_utils::function_2ea3462d6f1960e7(), "max_dormant_agent_count", agent_utils::function_771f3b959117f4e5(), "reserved_subarea_count", subarea.var_a81a24188ad05f66 ?? 0, "starting_agents_max", subarea.tuning.var_2fdda594ff89a52d ?? 0, "living_agents_size", subarea.livingagents.size ?? 0, "result", "isUnderMaxAgents: " + ( var_10a6c774b3faed20 ?? "undefined" ) ] );
        }
        
        return var_10a6c774b3faed20;
    }
    
    if ( !level.supportsai )
    {
        return 0;
    }
    
    var_d027382df50e048c = undefined;
    
    if ( poi::poi_issystemactive() )
    {
        var_d027382df50e048c = 0;
        
        if ( !isdefined( subarea ) )
        {
            subarea = _subarea_findfromorigin( origin );
        }
        
        if ( isdefined( subarea ) )
        {
            reservedspots = subarea.var_a81a24188ad05f66 ?? 0;
        }
        else
        {
            reservedspots = 0;
        }
        
        if ( getdvarint( @"hash_9f36593603489c07", 0 ) == 1 )
        {
            var_d027382df50e048c = 1;
        }
        
        if ( level.var_74e2abf79caab113 && subarea.poiname )
        {
            poiplayercount = level.poi[ subarea.poiname ][ "players" ].size ?? 0;
            reservedspots += roundint( poiplayercount * getdvarfloat( @"hash_73fa867b3deb0275", 1 ) );
        }
        
        if ( isint( number ) && isdefined( subarea.tuning.var_2fdda594ff89a52d ) && isarray( subarea.livingagents ) && subarea.livingagents.size + number + reservedspots <= subarea.tuning.var_2fdda594ff89a52d )
        {
            var_d027382df50e048c = 1;
        }
    }
    
    var_cdc0a55085b533c6 = undefined;
    
    if ( isdefined( category ) )
    {
        var_cdc0a55085b533c6 = function_c770a300a5ce87c( category );
    }
    
    var_3fe7c0c8c43d2ff6 = !isdefined( var_cdc0a55085b533c6 ) || var_cdc0a55085b533c6 >= number;
    
    if ( !( var_10a6c774b3faed20 && var_3fe7c0c8c43d2ff6 && ( !isdefined( var_d027382df50e048c ) || var_d027382df50e048c ) ) )
    {
        dlog_recordevent( "dlog_event_cannot_spawn_agent", [ "number", number ?? 0, "category", category ?? "undefined", "origin_x", origin[ 0 ] ?? 0, "origin_y", origin[ 1 ] ?? 0, "origin_z", origin[ 2 ] ?? 0, "subarea_name", subarea.subareaname ?? "undefined", "spawn_dormant", spawndormant ?? 0, "total_alive_agents", function_4924ec5c785bcae7(), "max_agents", aibudget_maxagents(), "dormant_agent_count", agent_utils::function_2ea3462d6f1960e7(), "max_dormant_agent_count", agent_utils::function_771f3b959117f4e5(), "reserved_subarea_count", subarea.var_a81a24188ad05f66 ?? 0, "starting_agents_max", subarea.tuning.var_2fdda594ff89a52d ?? 0, "living_agents_size", subarea.livingagents.size ?? 0, "result", "isUnderMaxAgents: " + var_10a6c774b3faed20 + ", isUnderCategoryAgents: " + var_3fe7c0c8c43d2ff6 + ", subAreaHasRoom: " + ( var_d027382df50e048c ?? "undefined" ) ] );
        println( "<dev string:xb09>" + var_10a6c774b3faed20 + "<dev string:xb1c>" + var_3fe7c0c8c43d2ff6 + "<dev string:xb36>" + var_d027382df50e048c );
    }
    
    return var_10a6c774b3faed20 && var_3fe7c0c8c43d2ff6 && ( !isdefined( var_d027382df50e048c ) || var_d027382df50e048c );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xe637413, Offset: 0xc04a
// Size: 0x126, Type: bool
function function_a9d2650816d388e1( number, priority )
{
    assert( isdefined( priority ) && isdefined( number ), "<dev string:xb49>" );
    var_e864be3b84bf302b = 0;
    priorityint = function_f02c63b99c9614c9( level.aibudgets.priorities, priority );
    assert( isdefined( priorityint ), "<dev string:xb82>" );
    
    foreach ( testpriority in level.aibudgets.var_433fb689ac1fc4ec )
    {
        if ( function_f02c63b99c9614c9( level.aibudgets.priorities, testpriority ) <= priorityint )
        {
            break;
        }
        
        var_e864be3b84bf302b += function_cabd4c7205695f09( testpriority ).size;
    }
    
    return function_4924ec5c785bcae7() + number - var_e864be3b84bf302b <= aibudget_maxagents();
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xf5554f78, Offset: 0xc179
// Size: 0xb
function function_8ffeea94656ed772()
{
    return function_7c7f41d3fd5028a5( "everybody" );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xdcf598b9, Offset: 0xc18d
// Size: 0xb
function function_4924ec5c785bcae7()
{
    return function_6c8e1135c28125d0( "everybody" );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xcf9d0bec, Offset: 0xc1a1
// Size: 0x9c
function aibudget_spawnedagents( array )
{
    if ( !isdefined( array ) )
    {
        return function_4924ec5c785bcae7();
    }
    
    totalspawned = 0;
    
    foreach ( agent in array )
    {
        if ( isagent( agent ) )
        {
            totalspawned++;
        }
    }
    
    return totalspawned;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xcbdae3f7, Offset: 0xc246
// Size: 0x15
function aibudget_maxagents()
{
    return level.aibudgets.maxagents;
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x61865563, Offset: 0xc264
// Size: 0x263
function function_ab457ae07d38091a( agent, killer, meansofdeath )
{
    vehiclekiller = agent.vehiclekiller;
    
    if ( isdefined( vehiclekiller ) )
    {
        killer = vehiclekiller;
    }
    
    if ( isplayer( killer ) )
    {
        dlogmeansofdeath = "none";
        dlogheadshot = 0;
        
        if ( isdefined( meansofdeath ) )
        {
            dlogmeansofdeath = meansofdeath;
            
            if ( meansofdeath == "MOD_HEAD_SHOT" )
            {
                dlogheadshot = 1;
            }
        }
        
        dlogweapon = killer getcurrentweapon();
        killer dlog_recordplayerevent( "dlog_event_dmz_player_killed_ai", [ "means_of_death", dlogmeansofdeath, "playerweapon", dlogweapon.basename, "isheadshot", dlogheadshot, "ai_pos_x", agent.origin[ 0 ], "ai_pos_y", agent.origin[ 1 ], "ai_pos_z", agent.origin[ 2 ], "player_pos_x", killer.origin[ 0 ], "player_pos_y", killer.origin[ 1 ], "player_pos_z", killer.origin[ 2 ], "match_time_elapsed", gettime() ] );
    }
    
    subarea = agent.subarea;
    
    if ( !agent.skipdeathcount )
    {
        team = agent.team;
        assignedobjective = agent.objectivetarget;
        
        if ( isdefined( assignedobjective ) )
        {
            assignedobjective.assignedagents[ team ] = arrayremove( assignedobjective.assignedagents[ team ], agent );
        }
        
        agentstruct = agent.agentstruct;
        
        if ( isdefined( agentstruct.fortress ) && isdefined( level.fortressagentcallbacks ) && isdefined( level.fortressagentcallbacks.ondeath ) )
        {
            [[ level.fortressagentcallbacks.ondeath ]]( agent, killer );
        }
    }
    
    agent.var_498ac56714a55fa = 0;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x37b77555, Offset: 0xc4cf
// Size: 0x463
function function_dbc2aed56a183c6b( areaname, subareaname )
{
    idle = 0;
    investigate = 0;
    combat = 0;
    hunt = 0;
    
    if ( isdefined( areaname ) && isdefined( level.areas[ areaname ][ "subAreas" ] ) )
    {
        foreach ( subarea in level.areas[ areaname ][ "subAreas" ] )
        {
            foreach ( agent in subarea.livingagents )
            {
                if ( !isagent( agent ) )
                {
                    idle++;
                    continue;
                }
                
                if ( !agent.stealth_enabled )
                {
                    if ( isdefined( agent.enemy ) )
                    {
                        combat++;
                    }
                    else
                    {
                        idle++;
                    }
                    
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthidle ]]() )
                {
                    idle++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthinvestigate ]]() )
                {
                    investigate++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthcombat ]]() )
                {
                    combat++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthhunt ]]() )
                {
                    hunt++;
                }
            }
        }
    }
    else if ( isdefined( areaname ) && isdefined( level.poi[ areaname ][ "subAreas" ] ) )
    {
        foreach ( subarea in level.poi[ areaname ][ "subAreas" ] )
        {
            foreach ( agent in subarea.livingagents )
            {
                if ( !isagent( agent ) )
                {
                    idle++;
                    continue;
                }
                
                if ( !agent.stealth_enabled )
                {
                    if ( isdefined( agent.enemy ) )
                    {
                        combat++;
                    }
                    else
                    {
                        idle++;
                    }
                    
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthidle ]]() )
                {
                    idle++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthinvestigate ]]() )
                {
                    investigate++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthcombat ]]() )
                {
                    combat++;
                    continue;
                }
                
                if ( agent [[ agent.fnisinstealthhunt ]]() )
                {
                    hunt++;
                }
            }
        }
    }
    else if ( isdefined( level.agentarray ) )
    {
        foreach ( agent in level.agentarray )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( agent [[ agent.fnisinstealthidle ]]() )
            {
                idle++;
                continue;
            }
            
            if ( agent [[ agent.fnisinstealthinvestigate ]]() )
            {
                investigate++;
                continue;
            }
            
            if ( agent [[ agent.fnisinstealthcombat ]]() )
            {
                combat++;
                continue;
            }
            
            if ( agent [[ agent.fnisinstealthhunt ]]() )
            {
                hunt++;
            }
        }
    }
    
    return [ idle, investigate, combat, hunt ];
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xeef70df6, Offset: 0xc93b
// Size: 0x50
function function_f6fe0ea547011708()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_27877364a9af40a5", 0 ) == 1 )
        {
            num_active_agents = getaicount();
            logstring( "Current agent count = " + num_active_agents );
            wait 30;
            continue;
        }
        
        wait 1;
    }
}

// Namespace ai_mp_controller
// Params 0, eflags: 0x4
// Checksum 0x26db9604, Offset: 0xc993
// Size: 0x87
function private priority_init()
{
    level.aibudgets.priorities = [ "absolute", "high", "medium", "low", "filler" ];
    level.aibudgets.var_433fb689ac1fc4ec = arrayreverse( level.aibudgets.priorities );
    function_bca47dac6fd8350( level.aibudgets.priorities );
}

// Namespace ai_mp_controller
// Params 2, eflags: 0x4
// Checksum 0x7d121232, Offset: 0xca22
// Size: 0x6b
function private priority_set( agent, priority )
{
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xbba>" + priority );
    assert( isdefined( agent ), "<dev string:xbf6>" );
    agent.priority = priority;
    function_18a4cb5507def460( agent, priority );
}

// Namespace ai_mp_controller
// Params 2, eflags: 0x4
// Checksum 0x82394eda, Offset: 0xca95
// Size: 0x5d
function private priority_setbydormancyid( dormancyid, priority )
{
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xc28>" + priority );
    assert( isdefined( dormancyid ), "<dev string:xc70>" );
    function_18a4cb5507def460( dormancyid, priority );
}

// Namespace ai_mp_controller
// Params 1, eflags: 0x4
// Checksum 0xbccdb2, Offset: 0xcafa
// Size: 0x1e0
function private on_ai_killed( params )
{
    agent = self;
    
    if ( isdefined( agent.casualzombie ) )
    {
        return;
    }
    
    killerteam = undefined;
    
    if ( isdefined( params.eattacker ) && isdefined( params.eattacker.team ) )
    {
        killerteam = params.eattacker.team;
    }
    
    function_1b5040888fcd52e1( agent );
    function_ab457ae07d38091a( agent, params.eattacker, params.smeansofdeath );
    priority_remove( agent );
    
    if ( isdefined( agent.subarea ) )
    {
        utility::callsharedfunc( #"poi", #"subarea_removeagentfrom", agent, agent.subarea );
    }
    
    if ( isdefined( agent.cqbnode ) )
    {
        ai_behavior::cqb_releasenode( agent.cqbnode );
    }
    
    agent thread function_2c4515f96787e20e( params.smeansofdeath );
    var_dd9449b988f98f43 = undefined;
    level.aibudgets.var_98c621455dab1223++;
    
    if ( isdefined( params.sweapon ) )
    {
        var_dd9449b988f98f43 = params.sweapon issilenced();
    }
    
    if ( isdefined( agent.subarea ) )
    {
        if ( !agent.skipdeathcount )
        {
            level thread utility::callsharedfunc( #"reinforcement", #"hash_3872d7819878df58", agent, agent.subarea, var_dd9449b988f98f43, params.eattacker, killerteam );
            ai_reinforcements::function_6f6dd03e6762a8ca( agent.subarea, agent.origin, gettime() );
        }
    }
    
    utility::callsharedfunc( #"analytics", #"agent_killed", agent, 1, undefined );
}

// Namespace ai_mp_controller
// Params 1, eflags: 0x4
// Checksum 0x435627e0, Offset: 0xcce2
// Size: 0x68
function private priority_remove( agent )
{
    assert( isdefined( agent ), "<dev string:xcad>" );
    priority = priority_get( agent );
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xce2>" + priority );
    function_8fb6dffb4a67c2a6( agent, priority );
}

// Namespace ai_mp_controller
// Params 2, eflags: 0x4
// Checksum 0xa7a41933, Offset: 0xcd52
// Size: 0xb4
function private priority_removebydormancyid( dormancyid, priorityint )
{
    assert( isdefined( dormancyid ), "<dev string:xd21>" );
    
    if ( !isdefined( priorityint ) )
    {
        assert( isdefined( level.var_87bd0b3632631717[ dormancyid ] ), "<dev string:xd61>" + dormancyid );
        infopackage = agent_utils::function_d77442145c568a4e( dormancyid );
        priorityint = infopackage.priority;
    }
    
    priority = agent_utils::function_ae9005e87c0d5b0b( priorityint );
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xce2>" + priority );
    function_8fb6dffb4a67c2a6( dormancyid, priority );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x8d372e6, Offset: 0xce0e
// Size: 0x27
function priority_get( agent )
{
    assert( isdefined( agent ), "<dev string:xda5>" );
    return agent.priority;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x6d10b645, Offset: 0xce3e
// Size: 0x42
function function_785a96ce23c71388( priority )
{
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xdd7>" + priority );
    return function_8e8b213809f3c0ef( priority );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x96804f17, Offset: 0xce89
// Size: 0x42
function function_cabd4c7205695f09( priority )
{
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xdd7>" + priority );
    return function_3b71aa1bfab81002( priority );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xd4b51d8e, Offset: 0xced4
// Size: 0x42
function function_fc603baafcd2056e( priority )
{
    assert( isdefined( priority ) && arraycontains( level.aibudgets.priorities, priority ), "<dev string:xdd7>" + priority );
    return function_d396e3986bace4ee( priority );
}

/#

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xee0eb13, Offset: 0xcf1f
    // Size: 0x1dc, Type: dev
    function debug_categories()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_9e9be127028294d2", 0 ) == 1 )
            {
                agents = utility::function_1b1340a94b43b874( level.players[ 0 ].origin, 3000, 0 );
                
                foreach ( agent in agents )
                {
                    if ( isagent( agent ) && isalive( agent ) )
                    {
                        print3d( agent.origin + ( 0, 0, 100 ), "<dev string:xe22>" + agent.poiname, ( 1, 0, 1 ), 1, 0.4 );
                        print3d( agent.origin + ( 0, 0, 90 ), "<dev string:x400>" + priority_get( agent ), ( 1, 0, 1 ), 1, 0.4 );
                        print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x40b>" + agent.category, ( 1, 0, 1 ), 1, 0.4 );
                        print3d( agent.origin + ( 0, 0, 70 ), "<dev string:x416>" + agent.subcategory, ( 1, 0, 1 ), 1, 0.4 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace ai_mp_controller
// Params 0
// Checksum 0x7fe9ba73, Offset: 0xd103
// Size: 0x45
function spawn_spawnai()
{
    if ( isdefined( level.var_888f8f16f88b82cd ) )
    {
        [[ level.var_888f8f16f88b82cd ]]();
    }
    else
    {
        function_7f833bacb64445a6();
    }
    
    flags::gameflaginit( "spawn_packages_spawned", 0 );
    spawn_spawnpackages();
    flags::gameflagset( "spawn_packages_spawned" );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xbf30ef78, Offset: 0xd150
// Size: 0x17d
function spawn_spawnpackages()
{
    if ( isdefined( level.areas ) )
    {
        foreach ( area in level.areas )
        {
            isareaactive = utility::callsharedfunc( #"poi", #"area_isareaactive", area[ "name" ] );
            
            if ( !isareaactive )
            {
                continue;
            }
            
            foreach ( subarea in area[ "subAreas" ] )
            {
                if ( isdefined( subarea.poiname ) )
                {
                    ispoiactive = utility::callsharedfunc( #"poi", #"poi_ispoiactive", subarea.poiname );
                    
                    if ( !ispoiactive )
                    {
                        continue;
                    }
                }
                
                utility::callsharedfunc( #"poi", #"hash_37331756c0dab8d8", subarea );
            }
        }
    }
}

// Namespace ai_mp_controller
// Params 7
// Checksum 0x8ed37285, Offset: 0xd2d5
// Size: 0x654
function spawnguard( node, isstationaryoverride = 0, priority, category, subcategory, subarea = _subarea_findfromorigin( node.origin, undefined, undefined, 1 ), groupid )
{
    aitype = function_b86341658788836c( node, undefined, subarea );
    groupname = function_8d299531f8485be9( node );
    skipstealth = function_a557960e05a57b6d( node );
    candormant = function_2bfef73bc80d5a49( node );
    team = agent_utils::function_25b40f5accbca0dd( function_5e289eb1f49885c4( node, subarea ), aitype );
    combatrole = 0;
    
    if ( isdefined( node.script_combatrole ) )
    {
        if ( node.script_combatrole == "Defend Position" )
        {
            combatrole = 1;
        }
    }
    
    var_9798188c1cb9a97b = node.var_2171bac374a38945 ?? 1;
    var_4f8a92ebabf37ee = candormant ?? node.var_6331c41de4b915c6 ?? 1;
    hasnvgs = node.var_28d09cc6e577252c;
    agent = spawn( { #awarenessoverride:node.var_c4b4b87fb0ddca43, #var_95ac5561735900db:node.var_9c9df5c3a2792113, #groupid:groupid, #var_9798188c1cb9a97b:var_9798188c1cb9a97b, #combatrole:combatrole, #radiationattachment:node.var_5e4a1c5596f25470, #var_7fdb4b2f6d5b70fc:node.agent_type, #var_4f8a92ebabf37ee:var_4f8a92ebabf37ee, #skipstealth:skipstealth, #subarea:subarea, #team:team, #groupname:groupname, #subcategory:subcategory, #category:category, #priority:priority, #spawnangles:node.angles, #groundspawnorigin:node.origin, #agenttype:aitype } );
    wander_range = isdefined( node.script_wander_range ) && node.script_wander_range != "" ? node.script_wander_range : node.wander_range;
    var_ce65ee1983c13aac = isstationaryoverride || isdefined( wander_range ) && tolower( wander_range ) == "none";
    var_b3cb278c6c92fb22 = !isstationaryoverride && isdefined( wander_range ) && tolower( wander_range ) == "inplace";
    
    if ( isdefined( agent ) )
    {
        var_92b1a3b684bf39fb = undefined;
        var_928e99b68498dc45 = undefined;
        script_interactionuseradius = undefined;
        
        if ( isdefined( node.var_92b1a3b684bf39fb ) )
        {
            var_92b1a3b684bf39fb = int( node.var_92b1a3b684bf39fb );
        }
        
        if ( isdefined( node.var_928e99b68498dc45 ) )
        {
            var_928e99b68498dc45 = int( node.var_928e99b68498dc45 );
        }
        
        if ( isdefined( node.script_interactionuseradius ) )
        {
            script_interactionuseradius = int( node.script_interactionuseradius );
        }
        
        if ( hasnvgs )
        {
            ai_loot::function_452f7cba22550779( agent, %"hash_3f7577244affadeb", 1, 1 );
        }
        
        if ( isagent( agent ) )
        {
            if ( isdefined( node.script_interactionmode ) && ( node.script_interactionmode == "Endless One Node" || node.script_interactionmode == "Endless Multi-Node" ) )
            {
                agent thread ai_behavior::function_5c6cec6f0ce57f4( agent, node.origin, node.script_requiredtags, node.var_b6302b531260c98a, node.script_interactionmode, var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius );
            }
            else if ( var_ce65ee1983c13aac )
            {
                agent thread ai_behavior::behavior_GuardStationary( agent, 1, undefined, node.script_interactionmode == "Don't Use Random", var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
            else if ( var_b3cb278c6c92fb22 )
            {
                agent thread ai_behavior::behavior_GuardStationary( agent, undefined, undefined, node.script_interactionmode == "Don't Use Random", var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
            else if ( isdefined( level.overridebehavior_guardwander ) )
            {
                agent thread [[ level.overridebehavior_guardwander ]]( agent );
            }
            else
            {
                if ( isdefined( wander_range ) )
                {
                    switch ( tolower( wander_range ) )
                    {
                        case #"hash_1f528a3efce186b5":
                            radius = 32;
                            break;
                        case #"hash_c71b112fe04823d6":
                            radius = 128;
                            break;
                        case #"hash_29ed96c0ae9b5ce":
                            radius = 512;
                            break;
                        case #"hash_37a528543c204fc2":
                            radius = 1024;
                            break;
                    }
                }
                else
                {
                    radius = 128;
                }
                
                agent thread ai_behavior::behavior_GuardWander( agent, radius, 0 );
            }
        }
        else if ( isint( agent ) )
        {
            if ( isdefined( node.script_interactionmode ) && ( node.script_interactionmode == "Endless One Node" || node.script_interactionmode == "Endless Multi-Node" ) )
            {
                ai_behavior::function_4ac94b7dfaad6e92( agent, node.origin, node.script_requiredtags, node.var_b6302b531260c98a, node.script_interactionmode, var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
            else if ( var_ce65ee1983c13aac )
            {
                ai_behavior::function_2aa2d25463c152b4( agent, node.origin, var_ce65ee1983c13aac, undefined, undefined, node.script_interactionmode == "Don't Use Random", var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
            else if ( var_b3cb278c6c92fb22 )
            {
                ai_behavior::function_7b154a7c7eb87672( agent, node.origin, 25, 5, node.script_interactionmode == "Don't Use Random", var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
            else
            {
                ai_behavior::function_7b154a7c7eb87672( agent, node.origin, radius, 0, node.script_interactionmode == "Don't Use Random", var_92b1a3b684bf39fb, var_928e99b68498dc45, script_interactionuseradius, node.entity_id );
            }
        }
    }
    
    return agent;
}

// Namespace ai_mp_controller
// Params 9
// Checksum 0x9802743f, Offset: 0xd932
// Size: 0x727
function spawnpatrol( pathstruct, minagents, maxagents, var_adf085532c9fac8e, priority, category, subcategory, subarea, groupid )
{
    agents = [];
    path = pathstruct.path;
    angles = ( 0, 0, 0 );
    
    if ( isdefined( path[ 0 ].angles ) )
    {
        angles = path[ 0 ].angles;
    }
    
    if ( isdefined( path[ 0 ].var_f33efdd5ce648efc ) )
    {
        minagents = int( path[ 0 ].var_f33efdd5ce648efc );
    }
    
    if ( !isdefined( minagents ) )
    {
        minagents = 1;
    }
    else
    {
        minagents = int( minagents );
    }
    
    if ( isdefined( path[ 0 ].script_maxagents ) )
    {
        maxagents = int( path[ 0 ].script_maxagents );
    }
    
    if ( !isdefined( maxagents ) )
    {
        maxagents = 1;
    }
    else
    {
        maxagents = int( maxagents );
    }
    
    numagents = minagents;
    
    if ( minagents < maxagents )
    {
        numagents = randomintrange( minagents, maxagents + 1 );
    }
    
    patroltier = path[ 0 ].var_58a9237ef2346f68;
    patrolunittype = [];
    patrolunittype[ 0 ] = path[ 0 ].script_aitype1;
    patrolunittype[ 1 ] = path[ 0 ].script_aitype2;
    patrolunittype[ 2 ] = path[ 0 ].script_aitype3;
    patrolunittype[ 3 ] = path[ 0 ].script_aitype4;
    patrolunittype[ 4 ] = path[ 0 ].script_aitype5;
    var_5b58f1fb760bb82a = [];
    var_5b58f1fb760bb82a[ 0 ] = path[ 0 ].var_ac0bdf392493e77c ?? patroltier;
    var_5b58f1fb760bb82a[ 1 ] = path[ 0 ].var_87611d2ca2b7713f ?? patroltier;
    var_5b58f1fb760bb82a[ 2 ] = path[ 0 ].var_4f90afd899f9fee ?? patroltier;
    var_5b58f1fb760bb82a[ 3 ] = path[ 0 ].var_3c3f250270ff9e19 ?? patroltier;
    var_5b58f1fb760bb82a[ 4 ] = path[ 0 ].var_a546e3b887216930 ?? patroltier;
    skipstealth = function_a557960e05a57b6d( path[ 0 ] );
    min = 40;
    max = 85;
    spawnsetname = path[ 0 ].script_patrolspawnset ?? "guard";
    spawnnodeindex = 0;
    
    if ( !isdefined( path[ 0 ].var_9ae83111370e2734 ) || path[ 0 ].var_9ae83111370e2734 == "Any Node" )
    {
        spawnnodeindex = randomintrange( 0, path.size );
    }
    
    combatrole = 0;
    
    if ( isdefined( path[ 0 ].script_combatrole ) )
    {
        if ( path[ 0 ].script_combatrole == "Defend Position" )
        {
            combatrole = 1;
        }
    }
    
    var_9798188c1cb9a97b = path[ 0 ].var_2171bac374a38945 ?? 1;
    var_4f8a92ebabf37ee = function_2bfef73bc80d5a49( path[ 0 ] ) ?? path[ 0 ].var_6331c41de4b915c6 ?? 1;
    var_95ac5561735900db = path[ 0 ].var_9c9df5c3a2792113;
    awarenessoverride = path[ 0 ].var_c4b4b87fb0ddca43;
    radiationattachment = path[ 0 ].var_5e4a1c5596f25470;
    hasnvgs = path[ 0 ].var_28d09cc6e577252c;
    
    if ( !subarea )
    {
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", path[ 0 ].origin, undefined, 0, 1 );
    }
    
    var_16e43d5c4659be5b = function_16e43d5c4659be5b( patrolunittype, minagents );
    
    if ( var_16e43d5c4659be5b )
    {
        category = function_1895bccbfa57a096();
    }
    
    if ( isdefined( groupid ) )
    {
        function_7ac170c0429491c1( groupid, 0 );
    }
    
    for ( i = 0; i < numagents ; i++ )
    {
        basetype = undefined;
        
        if ( isdefined( patrolunittype[ i ] ) )
        {
            basetype = tolower( patrolunittype[ i ] );
        }
        
        tier = undefined;
        
        if ( isdefined( var_5b58f1fb760bb82a[ i ] ) )
        {
            tier = var_5b58f1fb760bb82a[ i ];
        }
        else if ( isdefined( patroltier ) )
        {
            tier = patroltier;
        }
        
        if ( isdefined( path[ 0 ].script_nationality_override ) && !issubstr( path[ 0 ].script_nationality_override, "<nationality" ) )
        {
            nationality = path[ 0 ].script_nationality_override;
        }
        
        tempnode = spawnstruct();
        tempnode.script_poi = path[ 0 ].poiname;
        tempnode.subareaname = path[ 0 ].subareaname;
        tempnode.origin = path[ spawnnodeindex ].origin;
        tempnode.script_tier = var_5b58f1fb760bb82a[ i ];
        
        if ( !isdefined( nationality ) )
        {
            nationality = function_5e289eb1f49885c4( tempnode, path[ 0 ].subarea );
        }
        
        aitype = function_b86341658788836c( tempnode, undefined, path[ 0 ].subarea, spawnsetname, basetype, undefined, nationality );
        team = agent_utils::function_25b40f5accbca0dd( nationality, aitype );
        angles = ( angles[ 0 ], randomint( 360 ), angles[ 2 ] );
        random_x = randomfloatrange( min, max ) * ( utility::cointoss() ? 1 : -1 );
        random_y = randomfloatrange( min, max ) * ( utility::cointoss() ? 1 : -1 );
        spawnloc = ai_behavior::function_b49820d3792f8b12( path[ spawnnodeindex ].origin + ( random_x, random_y, 0 ) );
        agent = spawn( { #awarenessoverride:awarenessoverride, #var_95ac5561735900db:var_95ac5561735900db, #groupid:groupid, #var_9798188c1cb9a97b:var_9798188c1cb9a97b, #combatrole:combatrole, #radiationattachment:radiationattachment, #var_7fdb4b2f6d5b70fc:path[ 0 ].agent_type, #var_4f8a92ebabf37ee:var_4f8a92ebabf37ee, #skipstealth:skipstealth, #subarea:subarea, #team:team, #subcategory:subcategory, #category:category, #priority:priority, #spawnangles:angles, #groundspawnorigin:spawnloc, #agenttype:aitype } );
        
        if ( isdefined( agent ) )
        {
            agents[ i ] = agent;
            
            if ( hasnvgs )
            {
                ai_loot::function_452f7cba22550779( agent, %"hash_3f7577244affadeb", 1, 1 );
            }
        }
    }
    
    if ( isdefined( groupid ) )
    {
        function_7ac170c0429491c1( groupid, 1 );
    }
    
    waitframe();
    
    if ( agents.size == 0 )
    {
        return;
    }
    
    if ( agents.size == 1 )
    {
        level thread ai_behavior::behavior_patrol( [ agents[ 0 ] ], pathstruct, spawnnodeindex );
        return agents;
    }
    else
    {
        patrolgroupname = ai_formation::function_e9aabb85b0d12949();
        level thread ai_behavior::behavior_patrol( agents, pathstruct, spawnnodeindex, undefined, undefined, patrolgroupname );
    }
    
    return agents;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x4433829b, Offset: 0xe062
// Size: 0xe6, Type: bool
function function_16e43d5c4659be5b( var_afba6b80c150f293, minagents )
{
    numdogs = 0;
    var_df1727450d008959 = 0;
    var_dcba9a4e7d93d9aa = 0;
    
    foreach ( type in var_afba6b80c150f293 )
    {
        type = tolower( type );
        
        if ( issubstr( type, "dog" ) && !issubstr( type, "robot" ) )
        {
            numdogs++;
            var_df1727450d008959 = 1;
            continue;
        }
        
        var_dcba9a4e7d93d9aa = 1;
    }
    
    if ( minagents > numdogs )
    {
        var_dcba9a4e7d93d9aa = 1;
    }
    
    return var_df1727450d008959 && var_dcba9a4e7d93d9aa;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xe1c5319f, Offset: 0xe151
// Size: 0x60
function function_1895bccbfa57a096()
{
    if ( !level.var_158836bdc1542a1 )
    {
        level.var_158836bdc1542a1 = 0;
    }
    
    categoryname = "dog_human_patrol_" + level.var_158836bdc1542a1;
    level.var_158836bdc1542a1++;
    namespace_287664c3b016b734::register( categoryname );
    namespace_287664c3b016b734::add( categoryname, #"on_spawn_agent", &function_bd61938353540233 );
    return categoryname;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x147aa893, Offset: 0xe1ba
// Size: 0x10e
function function_bd61938353540233( params )
{
    if ( !issubstr( self.agent_type, "dog" ) )
    {
        return;
    }
    
    dog = self;
    dog endon( #"death" );
    
    for ( var_8e61c54d8624dd5b = 5; var_8e61c54d8624dd5b > 0 ; var_8e61c54d8624dd5b-- )
    {
        agentsincategory = function_8e8b213809f3c0ef( dog.category );
        
        foreach ( agent in agentsincategory )
        {
            if ( isint( agent ) )
            {
                continue;
            }
            
            if ( issubstr( agent.agent_type, "dog" ) )
            {
                continue;
            }
            
            dog setdoghandler( agent );
            return;
        }
        
        wait 1;
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x4fc1c3dd, Offset: 0xe2d0
// Size: 0x31
function function_a557960e05a57b6d( node )
{
    if ( isdefined( node.script_label ) )
    {
        return issubstr( node.script_label, "isCQB" );
    }
    
    return 0;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x50868bfa, Offset: 0xe30a
// Size: 0x35
function function_2bfef73bc80d5a49( node )
{
    if ( node.aitype && level.var_e3876b806d20f16f[ node.aitype ] )
    {
        return 0;
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x463d8efb, Offset: 0xe348
// Size: 0x35
function function_16e3651d08c8f54e( node )
{
    if ( node.aitype && level.var_3330f53ae8d1adae[ node.aitype ] )
    {
        return 0;
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x5ef6217f, Offset: 0xe386
// Size: 0x29f
function spawnpackage_spawn( spawnpackage, priorityoverride )
{
    spawnednum = 0;
    
    if ( !spawnpackage )
    {
        return spawnednum;
    }
    
    if ( spawnpackage.spawned )
    {
        return spawnednum;
    }
    
    priority = "low";
    
    if ( isdefined( priorityoverride ) )
    {
        priority = priorityoverride;
    }
    
    spawnpackage.spawned = 1;
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        basegroupname = function_23093472391d772f( spawnpackage.subarea );
        guardgroupname = "guards|" + basegroupname;
        patrolgroupname = "patrols|" + basegroupname;
        allowlw = function_194ab657916a88db( spawnpackage.subarea, undefined, spawnpackage );
    }
    
    foreach ( guardnode in spawnpackage.guardnodes )
    {
        if ( level.var_15fb757c9b81d8c4 )
        {
            var_599d450bd1f7dd3b = function_29dc8dd695322183( spawnpackage.subarea, guardgroupname, guardnode.origin, allowlw );
        }
        
        agent = spawnguard( guardnode, undefined, priority, "spawnPackage", undefined, spawnpackage.subarea, var_599d450bd1f7dd3b );
        
        if ( isdefined( agent ) )
        {
            function_ba2cc99aa3662225( agent );
            spawnednum++;
        }
    }
    
    foreach ( pathstruct in spawnpackage.pathstructs )
    {
        if ( level.var_15fb757c9b81d8c4 )
        {
            var_599d450bd1f7dd3b = function_29dc8dd695322183( spawnpackage, patrolgroupname, pathstruct.path[ 0 ].origin, allowlw, 1 );
        }
        
        agents = spawnpatrol( pathstruct, undefined, undefined, undefined, priority, "spawnPackage", undefined, spawnpackage.subarea, var_599d450bd1f7dd3b );
        
        if ( isdefined( agents ) )
        {
            function_ba2cc99aa3662225( agents );
            spawnednum += agents.size;
            level notify( #"hash_a5226a2e72448913", agents, spawnpackage );
        }
    }
    
    return spawnednum;
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0xaca4bfb7, Offset: 0xe62e
// Size: 0x1f2
function function_ba2cc99aa3662225( agents, var_e7a34f5d4d14a6ac = 1, collectionstring = undefined )
{
    if ( !utility::issharedfuncdefined( #"aitokens", #"tokens_issystemactive" ) )
    {
        return;
    }
    
    if ( !var_e7a34f5d4d14a6ac && !isdefined( collectionstring ) )
    {
        assertmsg( "<dev string:xe28>" );
        return;
    }
    
    if ( !isarray( agents ) )
    {
        agents = [ agents ];
    }
    
    if ( var_e7a34f5d4d14a6ac )
    {
        if ( !utility::issharedfuncdefined( #"poi", #"dmzpoi_issystemactive" ) )
        {
            return;
        }
        
        for ( i = 0; i < agents.size ; i++ )
        {
            if ( !isagent( agents[ i ] ) || !isalive( agents[ i ] ) )
            {
                break;
            }
            
            poiname = utility::callsharedfunc( #"poi", #"hash_aef520fb6136be05", agents[ i ].origin, 0 );
            
            if ( !isdefined( poiname ) )
            {
                assertmsg( "<dev string:xe86>" );
                return;
            }
            
            starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", poiname );
            
            if ( !isdefined( starlevel ) )
            {
                assertmsg( "<dev string:xebc>" );
                return;
            }
            
            if ( isdefined( level.var_1d43e6e89a526030.var_f7861862eccd2c65[ starlevel ] ) )
            {
                tokencollection = level.var_1d43e6e89a526030.var_f7861862eccd2c65[ starlevel ];
            }
            else
            {
                tokencollection = "ai_token_dmz_shoot_poi_0star";
                println( "<dev string:xef4>" );
            }
            
            agents[ i ].var_25be60eed058e478 = tokencollection;
        }
        
        return;
    }
    
    for ( i = 0; i < agents.size ; i++ )
    {
        if ( !isagent( agents[ i ] ) || !isalive( agents[ i ] ) )
        {
            break;
        }
        
        agents[ i ].var_25be60eed058e478 = collectionstring;
    }
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0xba9368ec, Offset: 0xe828
// Size: 0x131, Type: bool
function function_194ab657916a88db( subarea, position, spawnpackage )
{
    lwpoi = getdvar( @"hash_dd7d103d4d0f655c", "" );
    
    if ( !isdefined( subarea ) && isdefined( position ) )
    {
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", position );
    }
    
    if ( spawnpackage && spawnpackage.guardnodes && spawnpackage.guardnodes.size > 0 )
    {
        foreach ( node in spawnpackage.guardnodes )
        {
            canlw = function_16e3651d08c8f54e( node );
            
            if ( canlw == 0 )
            {
                return false;
            }
        }
    }
    
    return lwpoi == "" || lwpoi == subarea.poiname;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xdfb11b2b, Offset: 0xe962
// Size: 0x29
function function_23093472391d772f( subarea )
{
    return subarea.areaname + "|" + subarea.subareaname;
}

// Namespace ai_mp_controller
// Params 5
// Checksum 0xa8306f85, Offset: 0xe994
// Size: 0x210
function function_29dc8dd695322183( struct, name, origin, allowlw, ispatrol = 0 )
{
    assert( level.var_15fb757c9b81d8c4 );
    
    if ( ispatrol )
    {
        if ( !isdefined( struct.var_4fcd79e903ebbb45 ) )
        {
            struct.var_4fcd79e903ebbb45 = [];
        }
        
        groups = struct.var_4fcd79e903ebbb45;
    }
    else
    {
        if ( !isdefined( struct.managedgroups ) )
        {
            struct.managedgroups = [];
        }
        
        groups = struct.managedgroups;
    }
    
    var_1fcf9ccb240c6415 = getdvarfloat( @"hash_d6e0e658a4275608", 1500 );
    var_9a16f1dcb380f0f9 = squared( var_1fcf9ccb240c6415 );
    var_17ca16f37f982f98 = getdvarfloat( @"hash_ded97b5e3c7917c9", 150 );
    var_5d30ca2ff98a165e = getdvarfloat( @"hash_cbb2d974dae989f3", 15 );
    
    foreach ( managedgroup in groups )
    {
        groupdata = function_9b649316adcccbaa( managedgroup );
        
        if ( isdefined( groupdata ) )
        {
            var_78a9bbaea0e11692 = abs( origin[ 2 ] - groupdata.origin[ 2 ] );
            
            if ( groupdata.var_f05db2e05804484d < var_5d30ca2ff98a165e && distancesquared( origin, groupdata.origin ) < var_9a16f1dcb380f0f9 && var_78a9bbaea0e11692 < var_17ca16f37f982f98 )
            {
                return managedgroup;
            }
        }
    }
    
    name = name + "|" + groups.size;
    groupid = function_7c4eb2a03864d853( istrue( allowlw ), 1, name, 1, undefined, undefined, 1 );
    groups[ groups.size ] = groupid;
    return groupid;
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x61899347, Offset: 0xebad
// Size: 0x45, Type: bool
function function_12fe2e7ce331e005()
{
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( level.gamemodebundle.var_d7d46cc8b32a9617 )
        {
            return true;
        }
        else if ( level.gamemodebundle.var_539b26d76c9ef0ba )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ai_mp_controller
// Params 1, eflags: 0x4
// Checksum 0x88b16251, Offset: 0xebfb
// Size: 0x29a
function private function_228c61aaad28be29( agenttype )
{
    if ( isdefined( level.var_7c80ccb6f168b387[ agenttype ] ) )
    {
        return level.var_7c80ccb6f168b387[ agenttype ];
    }
    
    isjugg = issubstr( agenttype, "jugg" );
    isdog = issubstr( agenttype, "dog" );
    var_c8bcc0329aa8eef0 = issubstr( agenttype, "robotdog" );
    iswolf = issubstr( agenttype, "wolf" );
    isriotshield = issubstr( agenttype, "riotshield" );
    var_eaf377968945fea6 = issubstr( agenttype, "sniper" ) || issubstr( agenttype, "marksman" );
    isrpg = issubstr( agenttype, "rpg" );
    tieroverridefunc = undefined;
    
    if ( issubstr( agenttype, "tier1" ) || issubstr( agenttype, "soldier" ) && !isdog )
    {
        tieroverridefunc = #"hash_7f4313e5bd22fca0";
    }
    else if ( issubstr( agenttype, "tier2" ) || issubstr( agenttype, "specialforces" ) )
    {
        tieroverridefunc = #"hash_7f4316e5bd2301b9";
    }
    else if ( issubstr( agenttype, "tier3" ) || issubstr( agenttype, "elite" ) )
    {
        tieroverridefunc = #"hash_7f4315e5bd230006";
    }
    else if ( issubstr( agenttype, "pow" ) )
    {
        tieroverridefunc = #"overridepow";
    }
    
    var_edef13f77f1b5ea1 = !isjugg && !isriotshield && !iswolf && !isdog && !var_c8bcc0329aa8eef0;
    var_fbae9d4508b57e4f = !isjugg;
    disabletokens = var_eaf377968945fea6 || isrpg;
    juggsubtype = undefined;
    
    if ( isjugg && issubstr( agenttype, "merc" ) )
    {
        juggsubtype = "merc";
    }
    
    classification = { #iscivilian:issubstr( agenttype, "civilian" ), #disabletokens:disabletokens, #var_fbae9d4508b57e4f:var_fbae9d4508b57e4f, #var_edef13f77f1b5ea1:var_edef13f77f1b5ea1, #var_c8bcc0329aa8eef0:var_c8bcc0329aa8eef0, #isdog:isdog, #iswolf:iswolf, #isriotshield:isriotshield, #tieroverridefunc:tieroverridefunc, #isrpg:isrpg, #var_eaf377968945fea6:var_eaf377968945fea6, #juggsubtype:juggsubtype, #isjugg:isjugg };
    level.var_7c80ccb6f168b387[ agenttype ] = classification;
    return classification;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x12ab34b8, Offset: 0xee9e
// Size: 0x3cc
function processagentspawned( agent, var_7fdb4b2f6d5b70fc )
{
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent_utils::function_b102de469af94500( agent, var_7fdb4b2f6d5b70fc );
    
    if ( isint( agent ) )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "processSpawnedDormantAgent", &processspawneddormantagent );
        return;
    }
    
    classification = function_228c61aaad28be29( agent.agent_type );
    var_edef13f77f1b5ea1 = classification.var_edef13f77f1b5ea1;
    var_fbae9d4508b57e4f = classification.var_fbae9d4508b57e4f;
    utility::callsharedfunc( #"threatbias", #"hash_c8b5e65ed584c59c", agent );
    agent ai::set_vehicle_hide_values( 500, 2400, 8000, 0 );
    
    if ( classification.isjugg )
    {
        utility::callsharedfunc( #"tier", #"overridejugg", agent );
        agent agent_juggernaut::function_f8400804ad5435ab( classification.juggsubtype );
    }
    
    if ( classification.disabletokens )
    {
        agent.disabletokens = 1;
    }
    
    if ( classification.var_eaf377968945fea6 )
    {
        agent.usesniperglint = 1;
    }
    
    if ( classification.isrpg )
    {
        agent.var_a85521434d6ba8bd = 0;
    }
    
    if ( !isdefined( agent.damagecategory ) )
    {
        agent.damagecategory = level.var_27992b614e2aed12[ "unset" ];
    }
    
    if ( isdefined( classification.tieroverridefunc ) )
    {
        utility::callsharedfunc( #"tier", classification.tieroverridefunc, agent );
    }
    
    if ( classification.isriotshield )
    {
        utility::callsharedfunc( #"tier", #"hash_dcb70b5c1e709956", agent );
    }
    
    agent utility::callsharedfunc( #"ai", #"hash_20c2ab7ea23d2e1e" );
    
    if ( classification.iswolf )
    {
        utility::callsharedfunc( #"wolf", #"overridewolf", agent );
    }
    
    if ( classification.isdog )
    {
        agent.skipdeathcount = 1;
        agent.shoulddropweapon = 0;
        agent.unarmedmeleedamageoverride = 90;
        agent.tier = 1;
    }
    
    if ( classification.var_c8bcc0329aa8eef0 )
    {
        agent.shoulddropweapon = 0;
        agent.tier = 2;
    }
    
    if ( var_edef13f77f1b5ea1 )
    {
        agent function_5c50b48c0c81d566( "all", 1 );
        agent function_5dd647bf875159d9( 0 );
    }
    
    if ( namespace_287664c3b016b734::exists( agent.category ) )
    {
        agent callback::function_99edd620ee45cd95( agent.category );
    }
    
    agent callback::callback( #"on_spawn_agent", {} );
    
    if ( isagent( agent ) )
    {
        if ( isdefined( agent.insidegoalvolume ) && var_fbae9d4508b57e4f )
        {
        }
    }
    
    if ( isdefined( level.var_16782cb64c4c1abb ) )
    {
        [[ level.var_16782cb64c4c1abb ]]( agent );
    }
    
    agentasset = getxhashasset( getsubstr( agent.agent_type, 6, agent.agent_type.size ) );
    
    if ( isdefined( level.var_1b1a764b5a2ea44f[ agentasset ] ) )
    {
        weaponbundle = function_c11af7a197679429( level.var_1b1a764b5a2ea44f[ agentasset ], 1 );
        weaponobj = item_weapon::function_477bf1207c6672a5( getscriptbundle( weaponbundle[ 0 ] ) );
        agent agent_utils::overrideagentsettings( undefined, undefined, weaponobj );
    }
    
    agent.var_c37a94dd3608bf47 = 1;
    
    if ( isdefined( agent.awarenessoverride ) && agent.awarenessoverride != "<None>" )
    {
        function_6d786dbafe1e3133( agent, agent.awarenessoverride );
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xdc92399e, Offset: 0xf272
// Size: 0xc3
function function_db2ffb8d9982a194( subarea, var_733fb0445d635b1d )
{
    if ( !isdefined( subarea ) )
    {
        return;
    }
    
    areaname = subarea.areaname;
    subareaname = subarea.subareaname;
    var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
    var_d57f6caea938a49.agentdeaths++;
    
    if ( isdefined( var_d57f6caea938a49.reinforcementpoints ) )
    {
        var_d57f6caea938a49.reinforcementpoints++;
    }
    
    if ( !var_733fb0445d635b1d && !var_d57f6caea938a49.isshutdown )
    {
        utility::callsharedfunc( #"poi", #"hash_f6d41e05b52f7915", subarea );
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x3bb819cf, Offset: 0xf33d
// Size: 0xc
function function_63600eb8d7065a8b( agent )
{
    
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x315ac259, Offset: 0xf351
// Size: 0xc
function processspawneddormantagent( agent )
{
    
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x9c8c14f4, Offset: 0xf365
// Size: 0x17
function set_maxsightdistsquared( value )
{
    self.maxsightdistsqrd = value;
}

/#

    // Namespace ai_mp_controller
    // Params 2
    // Checksum 0x64fc88e4, Offset: 0xf384
    // Size: 0x7a, Type: dev
    function function_fa975b780e4b54cd( agent, origin )
    {
        agent endon( #"hash_e50272a44df0733f" );
        
        while ( true )
        {
            thread debug::drawsphere( agent.origin, 64, 0.05, ( 0, 1, 0 ) );
            thread debug_utility::drawline( agent.origin, origin, 0.05, ( 1, 1, 1 ) );
            waitframe();
        }
    }

#/

// Namespace ai_mp_controller
// Params 0
// Checksum 0x294ff3b1, Offset: 0xf406
// Size: 0xaf
function ai_spawnfollower()
{
    wait 5;
    player = level.players[ 0 ];
    follower = spawn( { #team:player.team, #skipstealth:1, #category:"mission", #spawnangles:player.angles, #groundspawnorigin:player.origin, #agenttype:function_f7aef6871cda828( "ar" ) } );
    agent_utils::overridetier3( follower );
    
    if ( isdefined( follower ) )
    {
        behavior_followent( follower, player );
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x988f42f, Offset: 0xf4bd
// Size: 0x60
function behavior_followent( agent, player )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    while ( true )
    {
        agent ai_behavior::function_4a3c03bb49dd5d76( player.origin, 128, 1 );
        agent enemy::bt_set_stealth_state( "combat", undefined );
        wait 3;
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x2db937ce, Offset: 0xf525
// Size: 0xb2
function function_3e85df1e4dc319f0( agent )
{
    while ( true )
    {
        random_x = randomfloatrange( 85, 150 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        random_y = randomfloatrange( 85, 150 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        var_cbf0098919b9f972 = ( agent.origin[ 0 ] + random_x, agent.origin[ 1 ] + random_y, agent.origin[ 2 ] );
        agent ai_behavior::_setgoalpos( ai_behavior::function_b49820d3792f8b12( var_cbf0098919b9f972 ), 10 );
        wait 5;
    }
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0xa6e7918c, Offset: 0xf5df
// Size: 0x1d6
function function_eaa1a7e8a93ead9f( agent, groupname, subarea )
{
    if ( !isdefined( level.stealthgroupindex ) )
    {
        level.stealthgroupindex = 0;
    }
    
    if ( !isdefined( groupname ) )
    {
        if ( !isdefined( subarea ) )
        {
            subarea = _subarea_findfromorigin( agent.origin );
        }
        
        groupname = function_1431967d3cce97bf( subarea.areaname, subarea.subareaname );
    }
    
    if ( isdefined( agent.group ) && isdefined( agent.group.group_name ) )
    {
        agent.script_stealthgroup = agent.group.group_name;
    }
    else if ( isdefined( groupname ) )
    {
        agent.script_stealthgroup = groupname;
    }
    else
    {
        if ( !isdefined( groupname ) )
        {
            groupname = "group_" + level.stealthgroupindex;
            level.stealthgroupindex++;
        }
        
        agent.script_stealthgroup = groupname;
    }
    
    if ( isdefined( agent.spawnpoint ) )
    {
        if ( isdefined( agent.spawnpoint.script_stealthgroup ) )
        {
            agent.script_stealthgroup = agent.spawnpoint.script_stealthgroup;
        }
        
        if ( isdefined( agent.spawnpoint.script_sightrange ) )
        {
            agent.stealth.override_damage_auto_range = int( agent.script_sightrange );
        }
    }
    
    agent thread enemy::main();
    agent thread stealth_manager_cpmp::monitor_death_thread( level.stealth.damage_auto_range, level.stealth.damage_sight_range, level.stealth.var_4819c1af33f93f1e );
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x52050323, Offset: 0xf7bd
// Size: 0x1f8
function function_1431967d3cce97bf( areaname, subareaname, numagents = 1 )
{
    if ( isdefined( areaname ) && isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ] ) )
    {
        if ( !isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct ) )
        {
            struct = spawnstruct();
            struct.stealthgroupindex = 1;
            struct.stealthgroup_agentcount = 0;
            level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct = struct;
        }
        
        if ( level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroup_agentcount >= 30 )
        {
            level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroupindex = level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroupindex + 1;
            level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroup_agentcount = 0;
        }
        
        level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroup_agentcount = level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroup_agentcount + numagents;
        return ( areaname + "_" + subareaname + "_" + level.areas[ areaname ][ "subAreas" ][ subareaname ].stealthgroupstruct.stealthgroupindex );
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xd3f3a3f2, Offset: 0xf9bd
// Size: 0x132
function function_f200be478b4dc64b( agent )
{
    if ( !isdefined( level.var_bbaacd5d5f2ae19a ) )
    {
        level.var_bbaacd5d5f2ae19a = [];
        level.var_d6aba613c0cd3657 = [];
    }
    
    if ( !isdefined( level.var_bbaacd5d5f2ae19a[ agent.team ] ) )
    {
        level.var_bbaacd5d5f2ae19a[ agent.team ] = 1;
        level.var_d6aba613c0cd3657[ agent.team ] = 0;
    }
    
    if ( level.var_d6aba613c0cd3657[ agent.team ] >= 4 )
    {
        level.var_bbaacd5d5f2ae19a[ agent.team ] += 1;
        level.var_d6aba613c0cd3657[ agent.team ] = 0;
    }
    
    level.var_d6aba613c0cd3657[ agent.team ] += 1;
    return "stealthGroup_" + agent.team + "_" + level.var_bbaacd5d5f2ae19a[ agent.team ];
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xab69fa1, Offset: 0xfaf8
// Size: 0x6a
function function_71bf1a00b0b8d267()
{
    level.default_goalradius = 2048;
    stealth_manager_cpmp::main();
    utility::flag_set( "level_stealth_initialized" );
    
    if ( isdefined( level.customeventlist ) )
    {
        eventliststring = level.customeventlist;
    }
    else
    {
        eventliststring = "defaultaieventlist";
    }
    
    level.nopathnodes = 1;
    level.brenableagents = 1;
    mp_gameskill::init_gameskill();
}

// Namespace ai_mp_controller
// Params 14
// Checksum 0x7bad103e, Offset: 0xfb6a
// Size: 0xca
function function_6cd3090858f1d8d9( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( isdefined( self.callbackdamaged ) )
    {
        [[ self.callbackdamaged ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
        return;
    }
    
    common_agent_damage::common_callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0xae0779d0, Offset: 0xfc3c
// Size: 0x81
function function_7f44688efd90d4e4()
{
    agent = spawn( { #subcategory:"debug", #category:"elites", #priority:"high", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:( -14, 488, 106 ), #agenttype:"enemy_mp_jugg_base" } );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x4f192076, Offset: 0xfcc5
// Size: 0x6e
function function_391d43ea550a7a49( origin, numagents )
{
    if ( isdefined( origin ) )
    {
        poiname = poi::poi_findpoioriginisin( origin );
        return function_1431967d3cce97bf( poiname, numagents );
    }
    
    if ( !isdefined( level.reinforceindex ) )
    {
        level.reinforceindex = 1;
    }
    else
    {
        level.reinforceindex++;
    }
    
    return "reinforce_" + level.reinforceindex;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xcbc9a81e, Offset: 0xfd3c
// Size: 0xbe
function function_f37696b807a7c5e( origin, radius )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 64;
    }
    
    pathnodes = getnodesinradius( origin, radius, 0, radius );
    
    foreach ( node in pathnodes )
    {
        if ( node.type == "Begin" )
        {
            destroynavlink( node );
        }
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x23a08655, Offset: 0xfe02
// Size: 0x82
function function_6d786dbafe1e3133( agent, awarenesslevel )
{
    agent.var_c92a7956029e02a5 = agent getsightconfigtemplateoverride();
    agent thread function_fc12764dd595bcc( agent );
    
    if ( awarenesslevel == "OBLIVIOUS" )
    {
        function_e054dd1fa33a600a( agent, "rex_oblivious" );
        ai_overrideeventlist( agent, "rex_dmz_eventlist_oblivious" );
        return;
    }
    
    if ( awarenesslevel == "TUNNELVISION" )
    {
        function_e054dd1fa33a600a( agent, "rex_tunnelvision" );
        ai_overrideeventlist( agent, "rex_dmz_eventlist_oblivious" );
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x1832d349, Offset: 0xfe8c
// Size: 0x95
function function_fc12764dd595bcc( agent )
{
    self notify( #"hash_827e4307b7e4677c" );
    self endon( #"hash_827e4307b7e4677c" );
    agent endon( #"death" );
    agent endon( #"hash_b59e8a3c4ad9f1bc" );
    events = [ "bulletwhizby", "damage", "grenade_danger", "explosion", "gunshot", "gunshot_impact" ];
    agent utility::waittill_any_in_array( events );
    agent thread function_5e5e47ecbf6befd4( agent );
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xb6a568f0, Offset: 0xff29
// Size: 0xce
function function_5e5e47ecbf6befd4( agent )
{
    agent notify( #"hash_b59e8a3c4ad9f1bc" );
    
    if ( agent.var_c92a7956029e02a5 )
    {
        function_e054dd1fa33a600a( agent, agent.var_c92a7956029e02a5 );
    }
    
    bundle = getgamemodescriptbundle();
    
    if ( isxhashasset( bundle.stealthbundle ) )
    {
        stealthbundle = getscriptbundle( bundle.stealthbundle );
    }
    else if ( isstring( bundle.stealthbundle ) && bundle.stealthbundle != "" )
    {
        stealthbundle = getscriptbundle( "stealthbundle:" + bundle.stealthbundle );
    }
    
    agent.ai_eventlistoverride = stealthbundle.eventlist;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xea149779, Offset: 0xffff
// Size: 0x2b
function function_e054dd1fa33a600a( agent, var_eee6b641213731cc )
{
    if ( !( isdefined( agent ) && isdefined( var_eee6b641213731cc ) ) )
    {
        return;
    }
    
    agent setsightconfigtemplateoverride( var_eee6b641213731cc );
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x5e6be72, Offset: 0x10032
// Size: 0x31
function ai_overrideeventlist( agent, eventlistname )
{
    if ( !( isdefined( agent ) && isdefined( eventlistname ) ) )
    {
        return;
    }
    
    agent.ai_eventlistoverride = eventlistname;
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0xfc0fd270, Offset: 0x1006b
// Size: 0x47
function function_f1fca4c3e2e0dad1( agent, time )
{
    if ( !( isdefined( agent ) && isdefined( time ) ) )
    {
        return;
    }
    
    agent.timetolosetargetatlkp = time * 1000;
    agent.timetolosetargetnotatlkp = time * 1000;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x10a9b1d5, Offset: 0x100ba
// Size: 0xa3
function function_ed6f05faebe30e55( agent )
{
    if ( isdefined( level.var_ee8e529a935fc76b ) && isdefined( level.var_7a0e6c6ceb0a589b ) )
    {
        if ( issubstr( agent.agent_type, "ar" ) || issubstr( agent.agent_type, "smg" ) || issubstr( agent.agent_type, "lmg" ) )
        {
            agenttier = agent.tier;
            
            if ( randomfloat( 1 ) <= level.var_ee8e529a935fc76b * agenttier )
            {
                function_fd9894d3dd274e28( agent );
            }
        }
    }
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0xfc86be07, Offset: 0x10165
// Size: 0x3a
function function_fd9894d3dd274e28( agent )
{
    agent agent_utils::overrideagentsettings( undefined, undefined, level.br_lootiteminfo[ utility::array_random( level.var_7a0e6c6ceb0a589b ) ].fullweaponobj );
}

// Namespace ai_mp_controller
// Params 0
// Checksum 0x1f6fa695, Offset: 0x101a7
// Size: 0x97
function function_c41f3735fb9f0dee()
{
    badlocs = utility::getstructarray( "traversal_invalid", "script_noteworthy" );
    
    foreach ( loc in badlocs )
    {
        function_f37696b807a7c5e( loc.origin );
    }
}

// Namespace ai_mp_controller
// Params 2
// Checksum 0x6e483185, Offset: 0x10246
// Size: 0x7d
function function_3d6581dd2c928fbc( team, category )
{
    if ( !isdefined( level.var_c7822dfb62fad6b7 ) )
    {
        level.var_c7822dfb62fad6b7 = [];
    }
    
    hiddenpos = level.var_3bb3ec4b209a069e ?? ( 0, 0, 0 );
    level thread spawnhiddenagent( team, hiddenpos, category );
    
    while ( !isdefined( level.var_c7822dfb62fad6b7[ team ] ) )
    {
        waitframe();
    }
    
    return level.var_c7822dfb62fad6b7[ team ];
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0xcb3bfed0, Offset: 0x102cc
// Size: 0x169
function spawnhiddenagent( team, hiddenpos, category )
{
    if ( isdefined( level.var_c7822dfb62fad6b7[ team ] ) )
    {
        return;
    }
    
    if ( !isdefined( category ) )
    {
        category = "reinforcements";
    }
    
    level notify( "spawn_hidden_agent_" + team );
    level endon( "spawn_hidden_agent_" + team );
    function_7f833bacb64445a6();
    agenttype = function_f7aef6871cda828( "ar" );
    agent = spawn( { #var_4f8a92ebabf37ee:0, #skipstealth:1, #team:team, #subcategory:"hidden", #category:category, #priority:"absolute", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:hiddenpos, #agenttype:agenttype } );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent.ignoreall = 1;
    agent.dontevershoot = 1;
    agent.var_4f8a92ebabf37ee = 0;
    agent.invulnerable = 1;
    agent.speedscalemult = 0;
    agent forceteleport( hiddenpos, ( 0, 0, 0 ) );
    agent hide();
    level.var_c7822dfb62fad6b7[ team ] = agent;
}

// Namespace ai_mp_controller
// Params 1
// Checksum 0x5fd99e5a, Offset: 0x1043d
// Size: 0x131
function function_2c4515f96787e20e( meansofdeath )
{
    if ( level.skip_death_vo || meansofdeath == "MOD_EXECUTION" || meansofdeath == "MOD_MELEE_TAKEDOWN" || isdefined( self.agentteam ) && self.agentteam == "civilian" )
    {
        return;
    }
    
    rand = randomintrange( 1, 8 );
    type = "generic";
    
    if ( operator::isfemale() )
    {
        type = "female";
    }
    
    if ( isagent( self ) )
    {
        if ( self.unittype == "dog" )
        {
            if ( self.animsetname == "robodog" )
            {
                self playsound( "dog_death_robo" );
            }
            else
            {
                self playsound( "anml_dog_death" );
            }
            
            return;
        }
        
        if ( isdefined( self.team ) && self.team == "allies" && game_utility::getgametype() != "dmz" )
        {
            self playsound( type + "_death_friendly_" + rand );
            return;
        }
        
        if ( game_utility::getgametype() != "dmz" )
        {
            self playsound( type + "_death_enemy_" + rand );
        }
    }
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x9aafd86d, Offset: 0x10576
// Size: 0xe1
function function_dd1124d17053d71( owner, origin, radius )
{
    owner endon( #"death" );
    streakname = "precision_airstrike";
    animname = level.scr_anim[ "precision_airstrike" ][ "airstrike_flyby" ];
    strikeanimlength = getanimlength( animname );
    var_f2b8f790428b478f = strikeanimlength - 5;
    
    if ( !isdefined( radius ) )
    {
        radius = 0;
    }
    
    origin += ( randomfloatrange( -1 * radius, radius ), randomfloatrange( -1 * radius, radius ), 0 );
    streakinfo = killstreak_utility::createstreakinfo( streakname, owner );
    killstreak_utility::killstreak_dangernotifyplayersinrange( owner, owner.team, 2048, streakname, origin );
    airstrike::callstrike( owner, origin, undefined, undefined, streakinfo, animname );
}

// Namespace ai_mp_controller
// Params 3
// Checksum 0x6ab08e88, Offset: 0x1065f
// Size: 0x157
function function_1fe12a63ed00ea08( owner, origin, radius )
{
    owner endon( #"death" );
    streakname = "toma_strike";
    var_5b98b9c4e91a8ec0 = randomintrange( 3, 6 );
    striketype = 1;
    streakinfo = killstreak_utility::createstreakinfo( streakname, owner );
    var_147ece74855f6277 = anglestoforward( owner.angles );
    ownerforward = anglestoforward( owner.angles );
    ownerright = anglestoright( owner.angles );
    
    if ( !isdefined( radius ) )
    {
        radius = 0;
    }
    
    origin += ( randomfloatrange( -1 * radius, radius ), randomfloatrange( -1 * radius, radius ), 0 );
    killstreak_utility::killstreak_dangernotifyplayersinrange( owner, owner.team, 2048, streakname, origin );
    
    for ( j = 0; j < var_5b98b9c4e91a8ec0 ; j++ )
    {
        var_4d99e8552caf305a = owner toma_strike::findunobstructedfiringinfo( origin, 1024, var_147ece74855f6277, ownerforward, ownerright );
        owner thread toma_strike::tomastrike_firestrike( striketype, var_4d99e8552caf305a, streakinfo );
        timetowait = randomfloatrange( 0.25, 1 );
        wait timetowait;
    }
}

/#

    // Namespace ai_mp_controller
    // Params 2
    // Checksum 0x534aa84c, Offset: 0x107be
    // Size: 0x93, Type: dev
    function function_f254e7a09d8ec5e( var_e614eae48cc1a97e, infiltype )
    {
        tempstruct = spawnstruct();
        tempstruct.spawnorigin = var_e614eae48cc1a97e.origin;
        tempstruct.var_c4d9ffe8c332861f = var_e614eae48cc1a97e.reinforceorigin;
        tempstruct.arrivalorigin = var_e614eae48cc1a97e.unloadorigin;
        tempstruct.infiltype = infiltype;
        tempstruct.locationsprocessed = 0;
        level.var_b4abff16eca9ceb4 = tempstruct;
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xfc6cda6f, Offset: 0x10859
    // Size: 0x91, Type: dev
    function function_3cf10f713e8c73a4()
    {
        while ( !isdefined( level.struct_class_names ) )
        {
            waitframe();
        }
        
        wait 1;
        level.var_a3d8d00b531341a6 = utility::getstructarray( "<dev string:xf95>", "<dev string:xfa3>" );
        numtospawn = getdvarint( @"hash_98d02294a9885211", 0 );
        
        for ( i = 0; i < numtospawn ; i++ )
        {
            if ( isdefined( level.var_a3d8d00b531341a6[ i ] ) )
            {
                agent = function_fd749a43f3d581bf( level.var_a3d8d00b531341a6[ i ] );
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 1
    // Checksum 0xcb9d59ca, Offset: 0x108f2
    // Size: 0xa4, Type: dev
    function function_fd749a43f3d581bf( node )
    {
        agenttype = function_b86341658788836c( node );
        agent = spawn( { #subcategory:"<dev string:xfc6>", #category:"<dev string:xfba>", #priority:"<dev string:xfb5>", #spawnangles:node.angles, #groundspawnorigin:node.origin, #agenttype:agenttype } );
        
        if ( isdefined( agent ) )
        {
            agent thread ai_behavior::behavior_GuardWander( agent );
        }
        
        return agent;
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xdcd61b2e, Offset: 0x1099e
    // Size: 0x11b, Type: dev
    function function_42fcb5a6853b0d7b()
    {
        while ( true )
        {
            foreach ( agent in level.agentarray )
            {
                if ( !isalive( agent ) )
                {
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    if ( agent cansee( player ) )
                    {
                        println( "<dev string:xfcc>" );
                        continue;
                    }
                    
                    see = 0;
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 4
    // Checksum 0xc8aefef7, Offset: 0x10ac1
    // Size: 0x154, Type: dev
    function function_40ff4ed84b45f48c( textx, texty, poiname, enabledcolor )
    {
        printtoscreen2d( textx, texty, poiname, enabledcolor, 2 );
        printtoscreen2d( textx, texty + 20, "<dev string:xfda>", enabledcolor, 1 );
        printtoscreen2d( textx, texty + 40, "<dev string:xff9>" + function_e46c3145a894aba3( poiname, "<dev string:x38b>" ), ( 0, 0, 1 ), 1 );
        printtoscreen2d( textx, texty + 60, "<dev string:x1005>" + function_e46c3145a894aba3( poiname, "<dev string:x1011>" ), ( 0, 1, 1 ), 1 );
        printtoscreen2d( textx, texty + 80, "<dev string:x101a>" + function_e46c3145a894aba3( poiname, "<dev string:x74f>" ), ( 1, 0.5, 0 ), 1 );
        printtoscreen2d( textx, texty + 160, "<dev string:x1023>" + function_e46c3145a894aba3( poiname, "<dev string:x1035>" ), ( 1, 1, 1 ), 1 );
        printtoscreen2d( textx, texty + 180, "<dev string:x1044>" + function_e46c3145a894aba3( poiname, "<dev string:x1057>" ), ( 1, 1, 1 ), 1 );
        printtoscreen2d( textx, texty + 200, "<dev string:x1067>" + function_e46c3145a894aba3( poiname, "<dev string:x1078>" ), ( 0, 0, 1 ), 1 );
    }

    // Namespace ai_mp_controller
    // Params 1
    // Checksum 0xb228159, Offset: 0x10c1d
    // Size: 0x618, Type: dev
    function function_3cc925a04f6d2845( poiinfo )
    {
        textx = 100;
        texty = 100;
        var_a7098bb711c60fc3 = [];
        var_a7098bb711c60fc3[ "<dev string:x1011>" ] = "<dev string:x1087>";
        var_a7098bb711c60fc3[ "<dev string:x74f>" ] = "<dev string:x109c>";
        var_a7098bb711c60fc3[ "<dev string:x1035>" ] = "<dev string:x10b3>";
        var_a7098bb711c60fc3[ "<dev string:x1057>" ] = "<dev string:x10b3>";
        var_a7098bb711c60fc3[ "<dev string:x1078>" ] = "<dev string:x10c9>";
        var_a7098bb711c60fc3[ "<dev string:x3c4>" ] = "<dev string:x10de>";
        var_a7098bb711c60fc3[ "<dev string:x10f5>" ] = "<dev string:x10b3>";
        
        foreach ( poiname in level.poi_names )
        {
            dvarstring = hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x1102>" );
            
            if ( getdvarint( dvarstring, 0 ) == 1 || getdvarint( @"hash_6e6e9391065dc426", 0 ) )
            {
                assert( isdefined( level.aibudgets.poi[ poiname ] ), poiname + "<dev string:x1109>" );
                
                if ( isdefined( level.aibudgets.poi[ poiname ] ) )
                {
                    if ( !poiinfo.var_ff1a341dd56efac2[ poiname ].outlined )
                    {
                        poiinfo.var_ff1a341dd56efac2[ poiname ].outlined = 1;
                        
                        foreach ( agent in function_a664b3eb3bcb4e15( poiname, "<dev string:x38b>" ) )
                        {
                            if ( isalive( agent ) )
                            {
                                outlineasset = "<dev string:x1145>";
                                
                                if ( isdefined( agent.category ) && isdefined( var_a7098bb711c60fc3[ agent.category ] ) )
                                {
                                    outlineasset = var_a7098bb711c60fc3[ agent.category ];
                                }
                                else
                                {
                                    assertmsg( "<dev string:x115b>" + poiname + "<dev string:x118a>" + agent.category );
                                }
                                
                                id = outline::outlineenableforall( agent, outlineasset, "<dev string:x11a7>" );
                                
                                if ( !isdefined( poiinfo.var_ff1a341dd56efac2[ poiname ].agents[ id ] ) )
                                {
                                    poiinfo.var_ff1a341dd56efac2[ poiname ].agents[ id ] = agent;
                                    agent.outlined = 1;
                                }
                            }
                        }
                    }
                    else if ( poiinfo.var_ff1a341dd56efac2[ poiname ].numagents != function_e46c3145a894aba3( poiname, "<dev string:x38b>" ) )
                    {
                        if ( poiinfo.var_ff1a341dd56efac2[ poiname ].numagents < function_e46c3145a894aba3( poiname, "<dev string:x38b>" ) )
                        {
                            foreach ( agent in function_a664b3eb3bcb4e15( poiname, "<dev string:x38b>" ) )
                            {
                                if ( isalive( agent ) && !agent.outlined )
                                {
                                    outlineasset = "<dev string:x1145>";
                                    
                                    if ( isdefined( agent.category ) && isdefined( var_a7098bb711c60fc3[ agent.category ] ) )
                                    {
                                        outlineasset = var_a7098bb711c60fc3[ agent.category ];
                                    }
                                    else
                                    {
                                        assertmsg( "<dev string:x115b>" + poiname + "<dev string:x11b4>" + agent.category );
                                    }
                                    
                                    id = outline::outlineenableforall( agent, outlineasset, "<dev string:x11a7>" );
                                    
                                    if ( !isdefined( poiinfo.var_ff1a341dd56efac2[ poiname ].agents[ id ] ) )
                                    {
                                        poiinfo.var_ff1a341dd56efac2[ poiname ].agents[ id ] = agent;
                                        agent.outlined = 1;
                                    }
                                }
                            }
                        }
                        
                        poiinfo.var_ff1a341dd56efac2[ poiname ].numagents = function_e46c3145a894aba3( poiname, "<dev string:x38b>" );
                    }
                }
                
                if ( arraycontains( level.var_e38f0af66eb58ff2, poiname ) )
                {
                    enabledcolor = ( 1, 0, 0 );
                }
                else
                {
                    enabledcolor = ( 0, 1, 0 );
                }
                
                if ( isdefined( level.aibudgets.poi[ poiname ] ) )
                {
                    function_40ff4ed84b45f48c( textx, texty, poiname, enabledcolor );
                }
                
                textx += 200;
                
                if ( textx == 1700 )
                {
                    textx = 100;
                    texty = 400;
                }
                
                continue;
            }
            
            if ( isdefined( level.aibudgets.poi[ poiname ] ) )
            {
                if ( getdvarint( dvarstring, 0 ) == 0 && poiinfo.var_ff1a341dd56efac2[ poiname ].outlined )
                {
                    foreach ( id, agent in poiinfo.var_ff1a341dd56efac2[ poiname ].agents )
                    {
                        if ( isalive( agent ) )
                        {
                            outline::outlinedisable( id, agent );
                        }
                        
                        poiinfo.var_ff1a341dd56efac2[ poiname ].agents[ id ] = undefined;
                        poiinfo.var_ff1a341dd56efac2[ poiname ].outlined = 0;
                        agent.outlined = undefined;
                    }
                }
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xc03ecbea, Offset: 0x1123d
    // Size: 0x1e0, Type: dev
    function function_e8e589db23ae9971()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        aiinfo = spawnstruct();
        aiinfo.aioutlines = [];
        aiinfo.disabledoutlines = 1;
        
        while ( true )
        {
            aiinfo.disabledoutlines = !getdvarint( @"ai_outline_enabled", 0 );
            
            if ( !aiinfo.disabledoutlines )
            {
                if ( !isdefined( level.agentarray ) )
                {
                    return;
                }
                
                foreach ( agent in level.agentarray )
                {
                    if ( isalive( agent ) )
                    {
                        if ( isdefined( agent.outlines ) && agent.outlines.size > 0 )
                        {
                            continue;
                        }
                        
                        id = outline::outlineenableforall( agent, "<dev string:x11cf>", "<dev string:x11a7>" );
                        aiinfo.aioutlines[ id ] = agent;
                    }
                }
            }
            else
            {
                foreach ( id, agent in aiinfo.aioutlines )
                {
                    if ( isalive( agent ) )
                    {
                        outline::outlinedisable( id, agent );
                    }
                    
                    aiinfo.aioutlines[ id ] = undefined;
                }
            }
            
            wait 0.1;
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x45efef29, Offset: 0x11425
    // Size: 0xed, Type: dev
    function function_18c64c1f24043900()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_2bf1ed7ec810aa2a", 0 );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        lastset = "<dev string:x11ea>";
        
        while ( true )
        {
            togglevalue = getdvarint( @"hash_2bf1ed7ec810aa2a", 0 );
            
            if ( togglevalue )
            {
                if ( lastset != "<dev string:x11f2>" )
                {
                    setdvar( @"ai_outline_enabled", 1 );
                    setdvar( @"ai_showpaths", 1 );
                    lastset = "<dev string:x11f2>";
                }
                else if ( lastset == "<dev string:x11f2>" )
                {
                    if ( lastset != "<dev string:x11f9>" )
                    {
                        setdvar( @"ai_outline_enabled", 0 );
                        setdvar( @"ai_showpaths", 0 );
                        lastset = "<dev string:x11f9>";
                    }
                }
                
                setdvar( @"hash_2bf1ed7ec810aa2a", 0 );
            }
            
            wait 0.1;
        }
    }

    // Namespace ai_mp_controller
    // Params 1
    // Checksum 0x2a90aedb, Offset: 0x1151a
    // Size: 0x38c, Type: dev
    function function_b29534d38d176b67( var_67e189e15ab7aad7 )
    {
        if ( getdvarint( @"hash_eea0b8db6857e8e1", 0 ) == 1 )
        {
            if ( var_67e189e15ab7aad7.enabledcivs )
            {
                var_67e189e15ab7aad7.enabledcivs = 0;
                
                foreach ( agent in function_3b71aa1bfab81002( "<dev string:x1011>" ) )
                {
                    if ( isalive( agent ) && distance( level.player.origin, agent.origin ) < getdvarint( @"scr_agent_team_radius", 5000 ) )
                    {
                        id = outline::outlineenableforall( agent, "<dev string:x1201>", "<dev string:x11a7>" );
                        
                        if ( !isdefined( var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] ) )
                        {
                            var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] = agent;
                        }
                    }
                }
            }
        }
        else if ( !var_67e189e15ab7aad7.enabledcivs )
        {
            var_67e189e15ab7aad7.enabledcivs = 1;
            
            foreach ( id, agent in var_67e189e15ab7aad7.var_a4914938b92fb4b2 )
            {
                if ( isalive( agent ) )
                {
                    outline::outlinedisable( id, agent );
                }
                
                var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] = undefined;
            }
        }
        
        if ( getdvarint( @"hash_98991913f1b99ae3", 0 ) == 1 )
        {
            if ( var_67e189e15ab7aad7.enabledenemies )
            {
                var_67e189e15ab7aad7.enabledenemies = 0;
                
                foreach ( agent in function_3b71aa1bfab81002( "<dev string:x38b>" ) )
                {
                    if ( isalive( agent ) && agent.category != "<dev string:x1011>" && distance( level.player.origin, agent.origin ) < getdvarint( @"scr_agent_team_radius", 5000 ) )
                    {
                        id = outline::outlineenableforall( agent, "<dev string:x121b>", "<dev string:x11a7>" );
                        
                        if ( !isdefined( var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] ) )
                        {
                            var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] = agent;
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( !var_67e189e15ab7aad7.enabledenemies )
        {
            var_67e189e15ab7aad7.enabledenemies = 1;
            
            foreach ( id, agent in var_67e189e15ab7aad7.var_a4914938b92fb4b2 )
            {
                if ( isalive( agent ) )
                {
                    outline::outlinedisable( id, agent );
                }
                
                var_67e189e15ab7aad7.var_a4914938b92fb4b2[ id ] = undefined;
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xc1c04f16, Offset: 0x118ae
    // Size: 0x332, Type: dev
    function function_27e0e65f0c900ae1()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_72c75d69fc797f8b", 0 );
        setdvarifuninitialized( @"hash_18ee9a9b9c484ae9", 4096 );
        var_ff1a341dd56efac2 = [];
        
        while ( !isdefined( level.players[ 0 ] ) )
        {
            wait 0.2;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_72c75d69fc797f8b", 0 ) == 0 )
            {
                if ( var_ff1a341dd56efac2.size > 0 )
                {
                    foreach ( guy in var_ff1a341dd56efac2 )
                    {
                        if ( guy.outlineid )
                        {
                            outline::outlinedisable( guy.outlineid, guy );
                            guy.outlineid = undefined;
                        }
                    }
                    
                    var_ff1a341dd56efac2 = [];
                }
                
                while ( getdvarint( @"hash_72c75d69fc797f8b", 0 ) == 0 )
                {
                    wait 1;
                }
            }
            else
            {
                enemiesinthearea = getaiarrayinradius( level.players[ 0 ].origin, getdvarfloat( @"hash_18ee9a9b9c484ae9", 4096 ) );
                
                foreach ( enemy in enemiesinthearea )
                {
                    if ( enemy isincombat() && enemy.enemy && enemy.enemy == level.players[ 0 ] )
                    {
                        if ( arraycontains( var_ff1a341dd56efac2, enemy ) )
                        {
                            continue;
                        }
                        
                        outlineid = enemy outline::outlineenableforplayer( enemy, level.players[ 0 ], "<dev string:x1233>", "<dev string:x11a7>" );
                        var_ff1a341dd56efac2[ var_ff1a341dd56efac2.size ] = enemy;
                        enemy.outlineid = outlineid;
                        continue;
                    }
                    
                    if ( enemy.outlineid )
                    {
                        var_ff1a341dd56efac2 = arrayremove( var_ff1a341dd56efac2, enemy );
                        outline::outlinedisable( enemy.outlineid, enemy );
                        enemy.outlineid = undefined;
                    }
                }
                
                farawayagents = arrayremove( var_ff1a341dd56efac2, enemiesinthearea );
                
                foreach ( distantenemy in farawayagents )
                {
                    if ( distantenemy.outlineid )
                    {
                        var_ff1a341dd56efac2 = arrayremove( var_ff1a341dd56efac2, distantenemy );
                        outline::outlinedisable( distantenemy.outlineid, distantenemy );
                        distantenemy.outlineid = undefined;
                    }
                }
                
                wait 0.5;
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xd8b57160, Offset: 0x11be8
    // Size: 0x2a7, Type: dev
    function function_43c730e1012bf749()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_6e6e9391065dc426", 0 );
        poiinfo = spawnstruct();
        poiinfo.var_ff1a341dd56efac2 = [];
        wait 2;
        
        foreach ( poiname in level.poi_names )
        {
            if ( !isdefined( level.aibudgets.poi[ poiname ] ) )
            {
                continue;
            }
            
            command = "<dev string:x1247>" + poiname + "<dev string:x1275>" + poiname + "<dev string:x1288>";
            adddebugcommand( command );
            poiinfo.var_ff1a341dd56efac2[ poiname ] = spawnstruct();
            poiinfo.var_ff1a341dd56efac2[ poiname ].outlined = 0;
            poiinfo.var_ff1a341dd56efac2[ poiname ].agents = [];
            poiinfo.var_ff1a341dd56efac2[ poiname ].numagents = function_e46c3145a894aba3( poiname, "<dev string:x38b>" );
            setdvarifuninitialized( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x1102>" ), 0 );
            wait 0.1;
            command = "<dev string:x1294>" + poiname + "<dev string:x1275>" + poiname + "<dev string:x12d1>";
            adddebugcommand( command );
            wait 0.1;
            setdvarifuninitialized( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x12e5>" ), 0 );
            command = "<dev string:x12f4>" + poiname + "<dev string:x1275>" + poiname + "<dev string:x132f>";
            adddebugcommand( command );
            wait 0.1;
            setdvarifuninitialized( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x1341>" ), 0 );
            command = "<dev string:x134e>" + poiname + "<dev string:x1275>" + poiname + "<dev string:x138a>";
            adddebugcommand( command );
            wait 0.1;
            setdvarifuninitialized( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x139d>" ), 0 );
            command = "<dev string:x13ab>" + poiname + "<dev string:x1275>" + poiname + "<dev string:x13eb>";
            adddebugcommand( command );
            wait 0.1;
            setdvarifuninitialized( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x13fb>" ), 0 );
            wait 0.2;
        }
        
        level thread function_bc2c85c0577b1799();
        level thread function_728fc472eb3fc4af();
        
        while ( true )
        {
            function_3cc925a04f6d2845( poiinfo );
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x7b23aa6a, Offset: 0x11e97
    // Size: 0xb8, Type: dev
    function function_306b91bd37bec667()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_eea0b8db6857e8e1", 0 );
        setdvarifuninitialized( @"hash_98991913f1b99ae3", 0 );
        setdvarifuninitialized( @"hash_eea0b8db6857e8e1", 0 );
        setdvarifuninitialized( @"hash_bcbe3309344bb6d2", 0 );
        setdvarifuninitialized( @"hash_9e9be127028294d2", 0 );
        setdvarifuninitialized( @"scr_agent_team_radius", 5000 );
        var_67e189e15ab7aad7 = spawnstruct();
        var_67e189e15ab7aad7.var_a4914938b92fb4b2 = [];
        var_67e189e15ab7aad7.enabledcivs = 1;
        var_67e189e15ab7aad7.enabledenemies = 1;
        
        while ( true )
        {
            function_b29534d38d176b67( var_67e189e15ab7aad7 );
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xb917fd7c, Offset: 0x11f57
    // Size: 0x1558, Type: dev
    function function_b18ed6d433e55711()
    {
        level endon( #"game_ended" );
        setdevdvar( @"ai_sightdisplayshapes", 0 );
        flags::function_2f3408423ccc9b2e( "<dev string:x1406>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_7e32df0ad3c385c1", 0 ) == 1 )
            {
                setdevdvar( @"debug_stealth", 0 );
                setdevdvar( @"hash_3493aa8adc34457e", 0 );
                setdevdvar( @"hash_2b47d7c6e19149b9", 0 );
                setdevdvar( @"ai_sightdisplayshapes", 0 );
                setdevdvar( @"hash_7f1d33bb4719a3c2", 0 );
                setdevdvar( @"ai_outline_enabled", 0 );
                setdevdvar( @"hash_eea0b8db6857e8e1", 0 );
                setdevdvar( @"hash_98991913f1b99ae3", 0 );
                setdevdvar( @"hash_1d8682eb59219492", 0 );
                setdevdvar( @"hash_bcbe3309344bb6d2", 0 );
                setdevdvar( @"hash_9e9be127028294d2", 0 );
                setdevdvar( @"hash_7e32df0ad3c385c1", 0 );
                
                foreach ( poiname, poi in level.poi )
                {
                    setdevdvar( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x12e5>" ), 0 );
                }
            }
            
            var_1a766a86e4eec725 = getdvarint( @"hash_7f1d33bb4719a3c2", 0 );
            focusstring = getdvar( @"hash_9c1d2ea2dcaa3296", "<dev string:x1414>" );
            
            if ( var_1a766a86e4eec725 == 1 )
            {
                if ( !level.supportsai )
                {
                    printtoscreen2d( 1000, 100, "<dev string:x1435>", ( 0, 0, 1 ), 2.5 );
                }
                else
                {
                    topxpos = 50;
                    function_722739a18d1e5f1a( topxpos, 54, "<dev string:x1445>" + function_8ffeea94656ed772(), ( 0, 0, 1 ), 2.5 );
                    topxpos += 250;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x144d>" + function_4924ec5c785bcae7() + "<dev string:x1457>" + level.aibudgets.maxagents, ( 0, 0, 1 ), 1.5 );
                    topxpos += 250;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1459>" + getdormantaicount(), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1463>" + function_62448bd2c6f12ae9( "<dev string:x3c4>" ), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x146d>" + function_62448bd2c6f12ae9( "<dev string:x1078>" ), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1479>" + level.aibudgets.var_98c621455dab1223, ( 0, 0, 1 ), 1.5 );
                    
                    if ( poi::poi_issystemactive() )
                    {
                        function_722739a18d1e5f1a( topxpos + 300, 50, "<dev string:x1488>" + level.poi_names.size, ( 0, 0, 1 ), 1.5 );
                        numlines = 0;
                        x = 50;
                        y = 90;
                        
                        foreach ( poiname, poi in level.poi )
                        {
                            if ( poi[ "<dev string:x148f>" ] != 0 )
                            {
                                continue;
                            }
                            
                            if ( isdefined( poi[ "<dev string:x1498>" ] ) && isdefined( poi[ "<dev string:x1498>" ].size > 0 ) )
                            {
                                if ( arraycontains( level.var_8851f2c94661cea1, utility::array_random( poi[ "<dev string:x1498>" ] ).areaname ) )
                                {
                                    continue;
                                }
                            }
                            
                            if ( arraycontains( level.var_e38f0af66eb58ff2, poiname ) )
                            {
                                continue;
                            }
                            
                            var_61571700e7a671a7 = function_e92cca1e1f7f8faf( poi, x, y );
                            
                            if ( var_61571700e7a671a7 > numlines )
                            {
                                numlines = var_61571700e7a671a7;
                            }
                            
                            x += 230;
                            
                            if ( x > 1600 )
                            {
                                y += numlines * 22;
                                x = 50;
                                numlines = 0;
                            }
                        }
                    }
                }
            }
            
            if ( var_1a766a86e4eec725 == 2 )
            {
                function_722739a18d1e5f1a( 50, 54, "<dev string:x1445>" + function_8ffeea94656ed772() + "<dev string:x14a1>" + level.aibudgets.maxagents, ( 0, 0, 1 ), 2.5 );
                function_722739a18d1e5f1a( 450, 50, "<dev string:x1463>" + function_62448bd2c6f12ae9( "<dev string:x3c4>" ), ( 0, 0, 1 ), 1.5 );
                function_722739a18d1e5f1a( 750, 50, "<dev string:x146d>" + function_62448bd2c6f12ae9( "<dev string:x1078>" ), ( 0, 0, 1 ), 1.5 );
                function_722739a18d1e5f1a( 1050, 50, "<dev string:x1479>" + level.aibudgets.var_98c621455dab1223, ( 0, 0, 1 ), 1.5 );
                
                if ( poi::poi_issystemactive() )
                {
                    function_722739a18d1e5f1a( 1300, 50, "<dev string:x14a5>" + abs( level.area_names.size - level.var_8851f2c94661cea1.size ), ( 0, 0, 1 ), 1.5 );
                    x = 50;
                    y = 90;
                    numlines = 0;
                    playersubarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", level.players[ 0 ].origin );
                    
                    foreach ( subarea in level.subareas )
                    {
                        if ( arraycontains( level.var_8851f2c94661cea1, subarea.areaname ) )
                        {
                            continue;
                        }
                        
                        if ( focusstring != "<dev string:x1414>" && !issubstr( subarea.subareaname, focusstring ) )
                        {
                            continue;
                        }
                        
                        var_61571700e7a671a7 = function_4be0cc49a6734ae4( subarea, x, y, playersubarea == subarea );
                        
                        if ( var_61571700e7a671a7 > numlines )
                        {
                            numlines = var_61571700e7a671a7;
                        }
                        
                        x += 230;
                        
                        if ( x > 1600 )
                        {
                            y += numlines * 22;
                            x = 50;
                            numlines = 0;
                        }
                    }
                }
            }
            
            if ( var_1a766a86e4eec725 == 5 )
            {
                if ( !level.supportsai )
                {
                    printtoscreen2d( 750, 100, "<dev string:x14ad>", ( 0, 0, 1 ), 2.5 );
                }
                else if ( isdefined( level.startracker ) )
                {
                    if ( poi::poi_issystemactive() )
                    {
                        startx = 450;
                        starty = 100;
                        x = startx;
                        y = starty;
                        
                        foreach ( poiname, poi in level.poi )
                        {
                            if ( poi[ "<dev string:x148f>" ] != 0 )
                            {
                                continue;
                            }
                            
                            if ( !isdefined( level.startracker[ poiname ] ) )
                            {
                                continue;
                            }
                            
                            if ( focusstring != "<dev string:x1414>" && !issubstr( poiname, focusstring ) )
                            {
                                continue;
                            }
                            
                            pos = y;
                            printtoscreen2d( x, pos, poiname, ( 0, 0, 1 ), 2 );
                            pos += 12;
                            printtoscreen2d( x, pos, "<dev string:xfda>", ( 0, 0, 1 ), 1 );
                            pos += 20;
                            color = ( 0, 1, 0 );
                            
                            switch ( level.startracker[ poiname ].starlevel )
                            {
                                case 1:
                                    color = ( 1, 1, 0 );
                                    break;
                                case 2:
                                    color = ( 1, 0.75, 0 );
                                    break;
                                case 3:
                                    color = ( 1, 0.35, 0 );
                                    break;
                                case 4:
                                    color = ( 1, 0, 0 );
                                    break;
                            }
                            
                            printtoscreen2d( x, pos, "<dev string:x14d5>" + level.startracker[ poiname ].starlevel, color, 1.5 );
                            pos += 12;
                            printtoscreen2d( x, pos, "<dev string:xfda>", ( 0, 0, 1 ), 1 );
                            pos += 16;
                            points = level.startracker[ poiname ].var_a1611c67c26aa022 ?? "<dev string:x14e2>";
                            printtoscreen2d( x, pos, "<dev string:x14e4>" + level.startracker[ poiname ].var_a1611c67c26aa022, ( 0, 0, 1 ), 1 );
                            pos += 20;
                            x += 250;
                            
                            if ( x > 1750 )
                            {
                                x = startx;
                                starty += 325;
                                y = starty;
                            }
                        }
                    }
                    else
                    {
                        printtoscreen2d( 400, 50, "<dev string:x14d5>" + level.startracker.starlevel, ( 1, 1, 1 ), 1 );
                        printtoscreen2d( 400, 70, "<dev string:x14f3>" + level.startracker.starprogress, ( 1, 1, 1 ), 1 );
                    }
                }
                else
                {
                    printtoscreen2d( 750, 100, "<dev string:x14fe>", ( 0, 0, 1 ), 2.5 );
                }
            }
            
            if ( var_1a766a86e4eec725 == 6 )
            {
                foreach ( agent in level.agentarray )
                {
                    if ( isdefined( agent.category ) && isagent( agent ) && isalive( agent ) )
                    {
                        print3d( agent.origin + ( 0, 0, 64 ), agent.category, ( 1, 1, 1 ), 1, 1, 1 );
                    }
                }
            }
            
            if ( var_1a766a86e4eec725 == 7 )
            {
                foreach ( fortress in level.fortressstruct.chosenfortresses )
                {
                    debug_drawspawnpackage( fortress, "<dev string:x1515>", fortress.poiname, fortress.subarea.subareaname );
                }
            }
            
            if ( getdvarint( @"hash_959247ebc7eac6b5", 0 ) == 1 )
            {
                println( "<dev string:x151e>" );
                println( "<dev string:x1544>" );
                println( "<dev string:x151e>" );
                
                if ( !poi::poi_issystemactive() )
                {
                    println( "<dev string:x1562>" + function_7c7f41d3fd5028a5( "<dev string:x38b>" ) + "<dev string:x14a1>" + level.aibudgets.maxagents );
                    println( "<dev string:x1570>" + function_7c7f41d3fd5028a5( "<dev string:x1011>" ) );
                }
                
                println( "<dev string:x151e>" );
                println( "<dev string:x157e>" );
                println( "<dev string:x151e>" );
                setdevdvar( @"hash_959247ebc7eac6b5", 0 );
            }
            
            if ( var_1a766a86e4eec725 == 4 )
            {
                playercolor = ( 0, 1, 0 );
                othercolor = ( 0, 0, 1 );
                playersubarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", level.players[ 0 ].origin );
                
                if ( poi::poi_issystemactive() )
                {
                    x = 250;
                    pos = 100;
                    
                    foreach ( subarea in level.subareas )
                    {
                        subareaname = subarea.subareaname;
                        areaname = subarea.areaname;
                        
                        if ( arraycontains( level.var_8851f2c94661cea1, areaname ) )
                        {
                            continue;
                        }
                        
                        if ( focusstring != "<dev string:x1414>" && !issubstr( subarea.subareaname, focusstring ) )
                        {
                            continue;
                        }
                        
                        color = othercolor;
                        
                        if ( subarea == playersubarea )
                        {
                            color = playercolor;
                        }
                        
                        function_722739a18d1e5f1a( x, pos, subarea.areaname + "<dev string:x3e2>" + subarea.subareaname, ( 1, 1, 1 ), 1.5 );
                        temppos = pos + 5;
                        printtoscreen2d( x, temppos, "<dev string:x159a>", color, 1.3 );
                        pos += 24;
                        
                        if ( subarea.tuning.var_22c3e564e5b0795d && subarea.tuning.var_22c3e564e5b0795d == 0 )
                        {
                            statustext = "<dev string:x15bb>";
                        }
                        else if ( !isdefined( level.aibudgets.areas[ areaname ][ subareaname ].var_f20b3aa2ef5b6d6c ) )
                        {
                            statustext = "<dev string:x15da>";
                        }
                        else
                        {
                            statustext = level.aibudgets.areas[ areaname ][ subareaname ].var_f20b3aa2ef5b6d6c;
                        }
                        
                        printtoscreen2d( x, pos, "<dev string:x15f2>" + statustext, color, 1.4 );
                        pos += 17;
                        
                        if ( !isdefined( level.aibudgets.areas[ areaname ][ subareaname ].var_5d8751db294ae491 ) )
                        {
                            level.aibudgets.areas[ areaname ][ subareaname ].var_5d8751db294ae491 = 0;
                        }
                        
                        printtoscreen2d( x, pos, "<dev string:x15fb>" + level.aibudgets.areas[ areaname ][ subareaname ].var_5d8751db294ae491, color, 1.4 );
                        pos += 17;
                        
                        if ( !isdefined( level.aibudgets.areas[ areaname ][ subareaname ].var_f69986e46c50ba53 ) )
                        {
                            level.aibudgets.areas[ areaname ][ subareaname ].var_f69986e46c50ba53 = 0;
                        }
                        
                        printtoscreen2d( x, pos, "<dev string:x1611>" + level.aibudgets.areas[ areaname ][ subareaname ].var_f69986e46c50ba53, color, 1.4 );
                        pos += 17;
                        extratext = "<dev string:x682>";
                        
                        if ( subarea.isshutdown )
                        {
                            var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
                            
                            if ( subarea.var_8c14effb189f3c38 && var_d57f6caea938a49.shutdowntime )
                            {
                                var_c6f6596ab9159007 = ( var_d57f6caea938a49.shutdowntime + level.var_f15ee21b463afe2b - gettime() ) / 1000;
                                extratext = "<dev string:x161f>" + var_c6f6596ab9159007;
                            }
                            else
                            {
                                extratext = "<dev string:x162c>";
                            }
                        }
                        
                        printtoscreen2d( x, pos, "<dev string:x163b>" + level.aibudgets.areas[ areaname ][ subareaname ].reinforcementpoints + extratext, color, 1.4 );
                        pos += 40;
                        
                        if ( pos > 1000 )
                        {
                            x += 450;
                            pos = 100;
                        }
                    }
                }
                else
                {
                    pos = 50;
                    printtoscreen2d( 700, pos, "<dev string:x164f>", ( 1, 1, 1 ), 1 );
                    pos += 20;
                    printtoscreen2d( 700, pos, "<dev string:x165d>", ( 1, 1, 1 ), 1 );
                    pos += 20;
                    printtoscreen2d( 700, pos, level.var_f20b3aa2ef5b6d6c, ( 1, 1, 1 ), 1 );
                    pos += 40;
                    printtoscreen2d( 700, pos, "<dev string:x166c>", ( 1, 1, 1 ), 1 );
                    pos += 20;
                    printtoscreen2d( 700, pos, "<dev string:x1680>", ( 1, 1, 1 ), 1 );
                    pos += 20;
                    reinforcementstring = "<dev string:x682>";
                    
                    if ( level.aibudgets.reinforcementqueue.size == 0 )
                    {
                        reinforcementstring = "<dev string:x1695>";
                    }
                    else
                    {
                        foreach ( numagents in level.aibudgets.reinforcementqueue )
                        {
                            reinforcementstring = reinforcementstring + "<dev string:x16a1>" + numagents;
                        }
                    }
                    
                    printtoscreen2d( 700, pos, reinforcementstring, ( 1, 1, 1 ), 1 );
                }
            }
            
            if ( var_1a766a86e4eec725 == 8 )
            {
                if ( !level.supportsai )
                {
                    function_722739a18d1e5f1a( 1000, 100, "<dev string:x1435>", ( 0, 0, 1 ), 2.5 );
                }
                else
                {
                    var_5cd0a78645728631 = utility::callsharedfunc( #"poi", #"area_findoriginisin", level.players[ 0 ].origin );
                    topxpos = 50;
                    function_722739a18d1e5f1a( topxpos, 54, "<dev string:x1445>" + function_8ffeea94656ed772(), ( 0, 0, 1 ), 2.5 );
                    topxpos += 250;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x144d>" + function_4924ec5c785bcae7() + "<dev string:x1457>" + level.aibudgets.maxagents, ( 0, 0, 1 ), 1.5 );
                    topxpos += 250;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1459>" + getdormantaicount(), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1463>" + function_62448bd2c6f12ae9( "<dev string:x3c4>" ), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x146d>" + function_62448bd2c6f12ae9( "<dev string:x1078>" ), ( 0, 0, 1 ), 1.5 );
                    topxpos += 200;
                    function_722739a18d1e5f1a( topxpos, 50, "<dev string:x1479>" + level.aibudgets.var_98c621455dab1223, ( 0, 0, 1 ), 1.5 );
                    
                    if ( poi::poi_issystemactive() )
                    {
                        function_722739a18d1e5f1a( topxpos + 300, 50, "<dev string:x14a5>" + abs( level.area_names.size - level.var_8851f2c94661cea1.size ), ( 0, 0, 1 ), 1.5 );
                        numlines = 0;
                        x = 50;
                        y = 90;
                        
                        foreach ( areaname, area in level.areas )
                        {
                            if ( arraycontains( level.var_8851f2c94661cea1, areaname ) )
                            {
                                continue;
                            }
                            
                            var_61571700e7a671a7 = function_89e0a04fa9553aa( area, x, y, var_5cd0a78645728631 == areaname );
                            
                            if ( var_61571700e7a671a7 > numlines )
                            {
                                numlines = var_61571700e7a671a7;
                            }
                            
                            x += 230;
                            
                            if ( x > 1600 )
                            {
                                y += numlines * 22;
                                x = 50;
                                numlines = 0;
                            }
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 4
    // Checksum 0xd2459336, Offset: 0x134b7
    // Size: 0x278, Type: dev
    function function_89e0a04fa9553aa( area, x, y, var_38708587378827a1 )
    {
        pos = y;
        numlines = 0;
        colorheading = ( 0, 0, 1 );
        colorbody = ( 0, 0, 1 );
        
        if ( var_38708587378827a1 )
        {
            colorheading = ( 1, 1, 0 );
            colorbody = ( 1, 1, 0 );
        }
        
        spawnedagents = 0;
        var_fb35dfd2dade2673 = 0;
        areaname = area[ "<dev string:x16a3>" ];
        
        foreach ( subarea in area[ "<dev string:x1498>" ] )
        {
            if ( !isdefined( area[ "<dev string:x16a3>" ] ) )
            {
                areaname = subarea.areaname;
            }
            
            budgetname = areaname + "<dev string:x3e2>" + subarea.subareaname;
            spawnedagents += aibudget_spawnedagents( function_a664b3eb3bcb4e15( budgetname, "<dev string:x38b>" ) );
            var_fb35dfd2dade2673 += function_e46c3145a894aba3( budgetname, "<dev string:x38b>" );
        }
        
        pos += 10;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, areaname, colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 16;
        firststring = "<dev string:x16c3>";
        secondstring = spawnedagents;
        thirdstring = "<dev string:x1457>" + var_fb35dfd2dade2673;
        function_722739a18d1e5f1a( x, pos, firststring, ( 0, 0, 1 ), 1 );
        tempx = x + 150;
        function_722739a18d1e5f1a( tempx, pos, secondstring, ( 0, 1, 0 ), 1 );
        tempx += string( secondstring ).size * 10;
        function_722739a18d1e5f1a( tempx, pos, thirdstring, ( 0, 0, 1 ), 1 );
        numlines += 4;
        return numlines;
    }

    // Namespace ai_mp_controller
    // Params 3
    // Checksum 0x7820b4b2, Offset: 0x13737
    // Size: 0x37d, Type: dev
    function function_e92cca1e1f7f8faf( poi, x, y )
    {
        numlines = 0;
        pos = y;
        colorheading = ( 0, 0, 1 );
        colorbody = ( 0, 0, 1 );
        pos += 10;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, poi[ "<dev string:x16a3>" ], colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 16;
        numlines += 4;
        
        if ( !isdefined( poi[ "<dev string:x1498>" ] ) || poi[ "<dev string:x1498>" ].size <= 0 )
        {
            return numlines;
        }
        
        keylist = [];
        keyentries = [];
        
        foreach ( subarea in poi[ "<dev string:x1498>" ] )
        {
            budgetname = subarea.areaname + "<dev string:x3e2>" + subarea.subareaname;
            
            foreach ( key in function_925ab1c5682ff554( budgetname ) )
            {
                if ( !arraycontains( keylist, key ) )
                {
                    keylist[ keylist.size ] = key;
                    keyentries[ key + "<dev string:x16cc>" ] = 0;
                    keyentries[ key + "<dev string:x16d5>" ] = 0;
                }
                
                keyentries[ key + "<dev string:x16cc>" ] = keyentries[ key + "<dev string:x16cc>" ] + aibudget_spawnedagents( function_a664b3eb3bcb4e15( budgetname, key ) );
                keyentries[ key + "<dev string:x16d5>" ] = keyentries[ key + "<dev string:x16d5>" ] + function_e46c3145a894aba3( budgetname, key );
            }
        }
        
        foreach ( key in keylist )
        {
            firststring = key + "<dev string:x16dc>";
            secondstring = keyentries[ key + "<dev string:x16cc>" ];
            thirdstring = "<dev string:x1457>" + keyentries[ key + "<dev string:x16d5>" ];
            function_722739a18d1e5f1a( x, pos, firststring, ( 0, 0, 1 ), 1 );
            tempx = x + 150;
            function_722739a18d1e5f1a( tempx, pos, secondstring, ( 0, 1, 0 ), 1 );
            tempx += string( secondstring ).size * 10;
            function_722739a18d1e5f1a( tempx, pos, thirdstring, ( 0, 0, 1 ), 1 );
            pos += 20;
            numlines += 1;
        }
        
        return numlines;
    }

    // Namespace ai_mp_controller
    // Params 4
    // Checksum 0xfe7edba9, Offset: 0x13abc
    // Size: 0x2e3, Type: dev
    function function_4be0cc49a6734ae4( subarea, x, y, var_6f887e7fb316b03f )
    {
        numlines = 0;
        pos = y;
        colorheading = ( 0, 0, 1 );
        colorbody = ( 0, 0, 1 );
        
        if ( var_6f887e7fb316b03f )
        {
            colorheading = ( 1, 1, 0 );
            colorbody = ( 1, 1, 0 );
        }
        
        pos += 10;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, subarea.areaname, colorbody, 1 );
        pos += 14;
        color = colorbody;
        extratext = "<dev string:x682>";
        
        if ( subarea.isshutdown )
        {
            color = ( 1, 0, 0 );
            extratext = "<dev string:x16df>";
        }
        
        function_722739a18d1e5f1a( x, pos, subarea.subareaname + extratext, colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        pos += 16;
        numlines += 4;
        budgetname = subarea.areaname + "<dev string:x3e2>" + subarea.subareaname;
        
        foreach ( key in function_925ab1c5682ff554( budgetname ) )
        {
            if ( key != "<dev string:x38b>" )
            {
                firststring = key + "<dev string:x16dc>";
                secondstring = aibudget_spawnedagents( function_a664b3eb3bcb4e15( budgetname, key ) );
                thirdstring = "<dev string:x1457>" + function_e46c3145a894aba3( budgetname, key );
                function_722739a18d1e5f1a( x, pos, firststring, colorbody, 1 );
                tempx = x + 150;
                function_722739a18d1e5f1a( tempx, pos, secondstring, ( 0, 1, 0 ), 1 );
                tempx += string( secondstring ).size * 10;
                function_722739a18d1e5f1a( tempx, pos, thirdstring, ( 0, 0, 1 ), 1 );
                pos += 20;
                numlines++;
            }
        }
        
        function_722739a18d1e5f1a( x, pos, "<dev string:x1445>" + function_e46c3145a894aba3( budgetname, "<dev string:x38b>" ), colorbody, 1 );
        pos += 12;
        function_722739a18d1e5f1a( x, pos, "<dev string:x16a8>", colorbody, 1 );
        numlines += 2;
        return numlines;
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x17ad1361, Offset: 0x13da7
    // Size: 0x172, Type: dev
    function debug_spawnareas()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_65814f5c10de603d", 0 ) == 1 )
            {
                foreach ( area in level.var_b831dca69efa7e34 )
                {
                    thread debug::drawsphere( area.origin, 128, 1, ( 1, 0, 1 ) );
                    
                    if ( !isdefined( area.agents ) )
                    {
                        continue;
                    }
                    
                    foreach ( agent in area.agents )
                    {
                        thread debug_utility::drawline( agent.origin, area.origin, 1, ( 1, 1, 1 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x19f9c0e6, Offset: 0x13f21
    // Size: 0x9de, Type: dev
    function function_93c8600eb211249a()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            var_a1816436373de6a6 = getdvarint( @"hash_1d8682eb59219492", 0 );
            focusstring = getdvar( @"hash_9c1d2ea2dcaa3296", "<dev string:x1414>" );
            
            if ( var_a1816436373de6a6 == 1 )
            {
                if ( utility::callsharedfunc( #"poi", #"poi_issystemactive" ) )
                {
                    foreach ( poi in level.poi )
                    {
                        poiname = poi[ "<dev string:x16a3>" ];
                        poiorigin = utility::callsharedfunc( #"poi", #"hash_fc858bd1017130aa", poiname );
                        
                        if ( !isdefined( poiorigin ) )
                        {
                            continue;
                        }
                        
                        color = ( 0, 1, 0 );
                        thread debug::drawsphere( poiorigin, 512, 1, color );
                        print3d( poiorigin + ( 0, 0, 552 ), poiname, ( 1, 1, 1 ), 1, 10, 20 );
                    }
                    
                    foreach ( poiname in level.var_e38f0af66eb58ff2 )
                    {
                        poiorigin = utility::callsharedfunc( #"poi", #"hash_fc858bd1017130aa", poiname );
                        
                        if ( !isdefined( poiorigin ) )
                        {
                            continue;
                        }
                        
                        color = ( 1, 0, 0 );
                        thread debug::drawsphere( poiorigin, 512, 1, color );
                        print3d( poiorigin + ( 0, 0, 552 ), poiname, ( 1, 1, 1 ), 1, 10, 20 );
                    }
                }
            }
            
            if ( var_a1816436373de6a6 == 2 )
            {
                if ( utility::callsharedfunc( #"poi", #"poi_issystemactive" ) )
                {
                    foreach ( subarea in level.subareas )
                    {
                        origin = utility::callsharedfunc( #"poi", #"subarea_getorigin", subarea );
                        
                        if ( !isdefined( origin ) )
                        {
                            continue;
                        }
                        
                        color = ( 1, 0, 0 );
                        var_1721393e668f0d19 = 0;
                        
                        if ( utility::callsharedfunc( #"poi", #"area_isareaactive", subarea.areaname ) )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        if ( isdefined( subarea.poiname ) )
                        {
                            var_1721393e668f0d19 = 1;
                            
                            if ( !utility::callsharedfunc( #"poi", #"poi_ispoiactive", subarea.poiname ) )
                            {
                                color = ( 1, 0, 0 );
                            }
                        }
                        
                        thread debug::drawsphere( origin, 768, 1, color );
                        var_6c72f15282cfc5d5 = var_1721393e668f0d19 ? ( 1, 1, 0 ) : ( 0, 0, 1 );
                        thread debug::drawsphere( origin, 256, 1, var_6c72f15282cfc5d5 );
                        print3d( origin + ( 0, 0, 550 ), subarea.areaname + "<dev string:x16dc>" + subarea.subareaname, ( 1, 1, 1 ), 1, 2, 20 );
                    }
                }
            }
            
            if ( var_a1816436373de6a6 == 3 )
            {
                if ( poi::poi_issystemactive() )
                {
                    foreach ( areaname, area in level.areas )
                    {
                        foreach ( subarea in area[ "<dev string:x1498>" ] )
                        {
                            if ( focusstring != "<dev string:x1414>" && !issubstr( subarea.subareaname, focusstring ) )
                            {
                                continue;
                            }
                            
                            foreach ( spawnpackage in subarea.spawnpackage_required )
                            {
                                debug_drawspawnpackage( spawnpackage, "<dev string:x1515>", poiname, subarea.subareaname );
                            }
                            
                            foreach ( spawnpackage in subarea.spawnpackage_optional )
                            {
                                debug_drawspawnpackage( spawnpackage, "<dev string:x16eb>", poiname, subarea.subareaname );
                            }
                            
                            if ( !isdefined( subarea.var_8ede83a5380440fe ) && isdefined( subarea.var_173533fa4f4e7c30 ) )
                            {
                                subarea.var_8ede83a5380440fe = [];
                                
                                foreach ( patrolnode in subarea.var_173533fa4f4e7c30 )
                                {
                                    subarea.var_8ede83a5380440fe[ subarea.var_8ede83a5380440fe.size ] = function_ad7994ce0f8a6d54( patrolnode );
                                }
                            }
                            
                            if ( isdefined( subarea.var_8ede83a5380440fe ) )
                            {
                                foreach ( pathstruct in subarea.var_8ede83a5380440fe )
                                {
                                    for ( i = 0; i < pathstruct.path.size ; i++ )
                                    {
                                        node01 = pathstruct.path[ i ];
                                        node02 = pathstruct.path[ i + 1 ];
                                        sphere( node01.origin, 32, ( 1, 0, 1 ) );
                                        
                                        if ( isdefined( node02 ) )
                                        {
                                            line( node01.origin, node02.origin, ( 1, 0, 1 ) );
                                            continue;
                                        }
                                        
                                        if ( !pathstruct.pingpongpath )
                                        {
                                            line( node01.origin, pathstruct.path[ 0 ].origin, ( 1, 1, 0 ) );
                                        }
                                    }
                                }
                            }
                            
                            if ( isdefined( subarea.var_4dd2465177822d5c ) )
                            {
                                foreach ( roofnode in subarea.var_4dd2465177822d5c )
                                {
                                    sphere( roofnode.origin, 32, ( 1, 1, 1 ) );
                                }
                            }
                        }
                    }
                }
            }
            
            if ( var_a1816436373de6a6 == 4 )
            {
                if ( poi::poi_issystemactive() )
                {
                    foreach ( areaname, area in level.areas )
                    {
                        origin = utility::callsharedfunc( #"poi", #"area_getorigin", areaname );
                        
                        if ( !isdefined( origin ) )
                        {
                            continue;
                        }
                        
                        thread debug::drawsphere( origin, 512, 1, ( 0, 1, 0 ) );
                        print3d( origin + ( 0, 0, 550 ), areaname, ( 1, 1, 1 ), 1, 2, 20 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 4
    // Checksum 0xfd7c777d, Offset: 0x14907
    // Size: 0x3cf, Type: dev
    function debug_drawspawnpackage( spawnpackage, type, poiname, subareaname )
    {
        color = undefined;
        
        if ( type == "<dev string:x1515>" )
        {
            color = ( 0, 1, 0 );
        }
        else if ( type == "<dev string:x16eb>" )
        {
            color = ( 0, 0, 1 );
        }
        else
        {
            color = ( 1, 0, 0 );
        }
        
        sphere( spawnpackage.origin, 64, color );
        
        if ( isdefined( spawnpackage.fromselector ) )
        {
            sphere( spawnpackage.origin, 128, ( 1, 1, 1 ) );
        }
        
        print3d( spawnpackage.origin + ( 0, 0, 104 ), type, ( 1, 1, 1 ), 1, 2, 20 );
        
        if ( isdefined( subareaname ) )
        {
            print3d( spawnpackage.origin + ( 0, 0, 84 ), subareaname, ( 1, 1, 1 ), 1, 1.25, 20 );
        }
        
        if ( isdefined( poiname ) )
        {
            print3d( spawnpackage.origin + ( 0, 0, 64 ), poiname, ( 1, 1, 1 ), 1, 1.25, 20 );
        }
        
        if ( isdefined( spawnpackage.guardnodes ) )
        {
            foreach ( spawnloc in spawnpackage.guardnodes )
            {
                sphere( spawnloc.origin, 32, ( 1, 1, 0 ) );
                line( spawnpackage.origin, spawnloc.origin, ( 1, 1, 0 ) );
            }
        }
        
        if ( isdefined( spawnpackage.pathstructs ) )
        {
            foreach ( pathstruct in spawnpackage.pathstructs )
            {
                line( spawnpackage.origin, pathstruct.path[ 0 ].origin, ( 1, 1, 0 ) );
                
                for ( i = 0; i < pathstruct.path.size ; i++ )
                {
                    node01 = pathstruct.path[ i ];
                    node02 = pathstruct.path[ i + 1 ];
                    sphere( node01.origin, 32, ( 1, 0, 1 ) );
                    
                    if ( isdefined( node02 ) )
                    {
                        line( node01.origin, node02.origin, ( 1, 0, 1 ) );
                        continue;
                    }
                    
                    if ( !pathstruct.pingpongpath )
                    {
                        line( node01.origin, pathstruct.path[ 0 ].origin, ( 1, 1, 0 ) );
                    }
                }
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xb4c630e5, Offset: 0x14cde
    // Size: 0x8e, Type: dev
    function function_d458418a8ca584f0()
    {
        while ( true )
        {
            x = getdvarfloat( @"scr_test_x", -20051 );
            y = getdvarfloat( @"scr_test_y", 42445.5 );
            z = getdvarfloat( @"scr_test_z", -157.5 );
            origin = ( x, y, z );
            thread debug::drawsphere( origin, 512, 1, ( 0, 1, 0 ) );
            wait 1;
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xe5bb7ec2, Offset: 0x14d74
    // Size: 0xfe, Type: dev
    function function_e80323ddb1596e93()
    {
        startorigin = ( -18414, 20137, -237 );
        xinterval = 128;
        yinterval = 128;
        
        for ( i = 0; i < 20 ; i++ )
        {
            origin = startorigin + ( 0, yinterval * ( i + 1 ), 0 );
            
            for ( j = 0; j < 20 ; j++ )
            {
                safeorigin = ai_behavior::function_b49820d3792f8b12( origin + ( 0, 0, 200 ) );
                safeorigin = utility::drop_to_ground( safeorigin );
                spawn( { #subcategory:"<dev string:xfc6>", #category:"<dev string:x1078>", #priority:"<dev string:xfb5>", #groundspawnorigin:safeorigin, #agenttype:"<dev string:x16f4>" } );
                origin += ( xinterval, 0, 0 );
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x6e965514, Offset: 0x14e7a
    // Size: 0xac, Type: dev
    function function_ff61b7c159373eb0()
    {
        while ( true )
        {
            foreach ( agent in level.specialforces )
            {
                if ( isalive( agent ) )
                {
                    thread debug::drawsphere( agent.origin, 32, 1, ( 0, 1, 0 ) );
                }
            }
            
            wait 1;
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x14d91b31, Offset: 0x14f2e
    // Size: 0xc6, Type: dev
    function function_a74e4884a578074b()
    {
        while ( true )
        {
            foreach ( agent in level.agentarray )
            {
                if ( isalive( agent ) )
                {
                    print3d( agent.origin + ( 0, 0, 64 ), agent.agent_type, ( 1, 1, 1 ), 1, 1.25, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x3165d39b, Offset: 0x14ffc
    // Size: 0x340, Type: dev
    function function_bc2c85c0577b1799()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( poiname, poi in level.poi )
            {
                if ( getdvarint( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x12e5>" ), 0 ) == 1 )
                {
                    foreach ( subarea in poi[ "<dev string:x1498>" ] )
                    {
                        if ( subarea.subareaname != "<dev string:x1705>" )
                        {
                            foreach ( spawnpackage in subarea.spawnpackage_required )
                            {
                                debug_drawspawnpackage( spawnpackage, "<dev string:x1515>", poiname, subarea.subareaname );
                            }
                            
                            foreach ( spawnpackage in subarea.spawnpackage_optional )
                            {
                                debug_drawspawnpackage( spawnpackage, "<dev string:x16eb>", poiname, subarea.subareaname );
                            }
                            
                            continue;
                        }
                        
                        foreach ( spawnpackage in subarea.spawnpackage_required )
                        {
                            debug_drawspawnpackage( spawnpackage, "<dev string:x1515>", poiname, subarea.subareaname );
                        }
                        
                        foreach ( spawnpackage in subarea.spawnpackage_optional )
                        {
                            debug_drawspawnpackage( spawnpackage, "<dev string:x16eb>", poiname, subarea.subareaname );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0xc0142d7e, Offset: 0x15344
    // Size: 0x192, Type: dev
    function function_728fc472eb3fc4af()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( poiname, poi in level.poi )
            {
                if ( getdvarint( hashcat( @"hash_831b14ba4dbdd316", poiname, "<dev string:x13fb>" ), 0 ) == 1 )
                {
                    foreach ( agent in function_a664b3eb3bcb4e15( poiname, "<dev string:x38b>" ) )
                    {
                        if ( isalive( agent ) )
                        {
                            str = "<dev string:x170c>" + agent.agent_type;
                            
                            if ( agent.var_7fdb4b2f6d5b70fc == "<dev string:x1719>" )
                            {
                                str += "<dev string:x171f>";
                            }
                            
                            print3d( agent.origin + ( 0, 0, 100 ), str, ( 1, 0, 1 ), 1, 0.4 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x195795ee, Offset: 0x154de
    // Size: 0x8c, Type: dev
    function function_9ce087cb087ed8fc()
    {
        while ( true )
        {
            sphere( level.players[ 0 ].origin, 512, ( 1, 0, 0 ) );
            sphere( level.players[ 0 ].origin, 1024, ( 0, 1, 0 ) );
            sphere( level.players[ 0 ].origin, 2048, ( 0, 0, 1 ) );
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 4
    // Checksum 0x77e00e26, Offset: 0x15572
    // Size: 0xa7, Type: dev
    function function_ece27a57464ce1de( ent, time, radius, color )
    {
        if ( !isdefined( ent ) && !isdefined( time ) )
        {
            return;
        }
        
        drawframes = int( time / level.framedurationseconds );
        
        if ( !isdefined( radius ) )
        {
            radius = 256;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 0, 0, 1 );
        }
        
        for ( frame = 0; frame < drawframes ; frame++ )
        {
            if ( !ent )
            {
                return;
            }
            
            sphere( ent.origin, radius, color );
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x97ee5f36, Offset: 0x15621
    // Size: 0xda, Type: dev
    function function_c485ec4757aa42c9()
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"debug_ai_magic", 0 );
        var_9af8f7d39b96adac = 1;
        
        while ( true )
        {
            if ( debug::function_79d2f03ff8ef58af() && var_9af8f7d39b96adac )
            {
                var_9af8f7d39b96adac = 0;
                setdvar( @"ai_debugevents", 1 );
                setdvar( @"debug_stealth", 1 );
                setdvar( @"ai_showpaths", 1 );
                setdvar( @"bg_entinfo", 1 );
            }
            
            if ( !debug::function_79d2f03ff8ef58af() && !var_9af8f7d39b96adac )
            {
                var_9af8f7d39b96adac = 1;
                setdvar( @"ai_debugevents", 0 );
                setdvar( @"debug_stealth", 0 );
                setdvar( @"ai_showpaths", 0 );
                setdvar( @"bg_entinfo", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x67556061, Offset: 0x15703
    // Size: 0x65, Type: dev
    function function_84f4b660279c3105()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( debug::function_79d2f03ff8ef58af() )
            {
                count = debug::function_1d6eb9f521f230bc();
                print3d( self.origin - ( 0, 0, count * 20 ), "<dev string:x1727>", ( 1, 1, 0 ), 1, 1.25 );
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 3
    // Checksum 0x425a5254, Offset: 0x15770
    // Size: 0x52, Type: dev
    function function_d946bafa3eff9504( player, event, radius )
    {
        if ( isdefined( radius ) )
        {
            stealtheventbroadcastsimple( event, player, player.origin, radius );
            return;
        }
        
        stealtheventbroadcastsimple( event, player, player.origin );
    }

    // Namespace ai_mp_controller
    // Params 1
    // Checksum 0xca6212da, Offset: 0x157ca
    // Size: 0xe7, Type: dev
    function debug_spawnaiboss( bossname )
    {
        point = getclosestpointonnavmesh( level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 128 );
        nearestnode = level.players[ 0 ] getnearestnode();
        agenttype = function_f7aef6871cda828( bossname );
        boss = spawn( { #skipstealth:0, #var_80bd04f03b9def8b:"<dev string:x38b>", #priority:"<dev string:x746>", #spawnangles:level.players[ 0 ].angles, #groundspawnorigin:point, #agenttype:agenttype } );
    }

    // Namespace ai_mp_controller
    // Params 5
    // Checksum 0x27725940, Offset: 0x158b9
    // Size: 0x5e, Type: dev
    function function_722739a18d1e5f1a( x, y, string, color, scale )
    {
        printtoscreen2d( x + 1, y + 1, string, color, scale );
        printtoscreen2d( x, y, string, ( 1, 1, 1 ), scale );
    }

    // Namespace ai_mp_controller
    // Params 0
    // Checksum 0x4108ab81, Offset: 0x1591f
    // Size: 0x2d3, Type: dev
    function function_3f7338ed91a78eb0()
    {
        self endon( #"death" );
        
        while ( true )
        {
            agenttype = getdvar( @"hash_3744daed0d2892f5", "<dev string:x16a1>" );
            
            if ( agenttype == "<dev string:x16a1>" )
            {
                waitframe();
                continue;
            }
            
            agenttier = getdvarint( @"hash_4c0a45ec5f980151", 1 );
            agentnationality = getdvar( @"hash_32554d2ce70b8e21", "<dev string:x173c>" );
            
            if ( agenttier == 4 && agenttype != "<dev string:x173f>" )
            {
                agenttier = 3;
                var_8c60a6b000ec1e2 = 1;
            }
            
            aitype = function_b86341658788836c( undefined, undefined, undefined, undefined, agenttype, agenttier, agentnationality );
            spawnorigin = getclosestpointonnavmesh( level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 512 );
            agent = spawn( { #category:"<dev string:x1078>", #priority:"<dev string:x746>", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:spawnorigin, #agenttype:aitype } );
            
            if ( !issubstr( agent.agent_type, "<dev string:x3e2>" + agenttype + "<dev string:x3e2>" ) )
            {
                print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x1744>" + aitype, ( 0, 1, 0 ), 1, 0.6, 30, 1 );
            }
            else
            {
                print3d( agent.origin + ( 0, 0, 80 ), "<dev string:x1756>" + aitype, ( 1, 1, 1 ), 1, 0.6, 30, 1 );
            }
            
            if ( agenttype == "<dev string:x175e>" )
            {
                spawnorigin = getclosestpointonnavmesh( spawnorigin + anglestoright( level.players[ 0 ].angles ) * 150 );
                aitype = function_b86341658788836c( undefined, undefined, undefined, undefined, "<dev string:x743>", agenttier, agentnationality );
                handler = spawn( { #category:"<dev string:x1078>", #priority:"<dev string:x746>", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:spawnorigin, #agenttype:aitype } );
                agent setdoghandler( handler );
            }
            
            setdvar( @"hash_3744daed0d2892f5", "<dev string:x16a1>" );
            waitframe();
            
            if ( var_8c60a6b000ec1e2 )
            {
                utility::callsharedfunc( #"tier", #"hash_7f4318e5bd23051f", agent );
                var_8c60a6b000ec1e2 = 0;
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 0, eflags: 0x4
    // Checksum 0xe06a2789, Offset: 0x15bfa
    // Size: 0xc5, Type: dev
    function private debug_interactions()
    {
        level.var_1825bd49a40d1f41 = 0;
        level.var_dce7925c2a7a4c36 = 0;
        level.var_9d6bd3c7bba605de = 0;
        level.var_8fcdcd9fab19394c = 0;
        level.var_3e1364efbcd5175e = [];
        level.controlled_agents = [];
        devgui::function_9082edeb5db93280( "<dev string:x1762>" );
        thread devgui::add_devgui_func( "<dev string:x1786>", "<dev string:x179a>", &function_486e946d923d7bef, 0 );
        thread devgui::add_devgui_func( "<dev string:x17b2>", "<dev string:x17c7>", &function_457634aaa2e1c9dd, 0 );
        thread devgui::add_devgui_func( "<dev string:x17e0>", "<dev string:x17f6>", &function_c50d482cbfbc1ea5, 0 );
        thread devgui::add_devgui_func( "<dev string:x1815>", "<dev string:x182b>", &function_185a790134cc9046, 0 );
        thread devgui::function_eaac4ba4b3caf621( "<dev string:x1845>", @"hash_cd2a202ccf770735" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0x13acb032, Offset: 0x15cc7
    // Size: 0xc4, Type: dev
    function private function_185a790134cc9046( forced_bool )
    {
        self notify( #"hash_61e2a98a5334a007" );
        self endon( #"hash_61e2a98a5334a007" );
        level.var_b72bced306285b1a = forced_bool ?? !level.var_b72bced306285b1a;
        
        foreach ( agent in level.controlled_agents )
        {
            agent ai_behavior::function_283c0c5c3be67d23( level.var_b72bced306285b1a, undefined, 1 );
        }
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0x8a40a47d, Offset: 0x15d93
    // Size: 0x3f, Type: dev
    function private function_d0f7f59c169f0717( forced_bool )
    {
        self notify( #"hash_2716ccf5d0dc984e" );
        self endon( #"hash_2716ccf5d0dc984e" );
        level.var_8fcdcd9fab19394c = forced_bool ?? !level.var_8fcdcd9fab19394c;
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0x892e6231, Offset: 0x15dda
    // Size: 0x5b, Type: dev
    function private function_16c584b61a9d3da( forced_bool )
    {
        self notify( #"hash_d919feb6e6e5fe51" );
        self endon( #"hash_d919feb6e6e5fe51" );
        level.var_9d6bd3c7bba605de = forced_bool ?? !level.var_9d6bd3c7bba605de;
        
        if ( level.var_9d6bd3c7bba605de )
        {
            function_37b9b3d7ee998fe2( 0 );
            function_d0f7f59c169f0717( 0 );
        }
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0x925e7e47, Offset: 0x15e3d
    // Size: 0x65, Type: dev
    function private function_37b9b3d7ee998fe2( forced_bool )
    {
        self notify( #"hash_d5758b7aabb56d7e" );
        self endon( #"hash_d5758b7aabb56d7e" );
        level.var_3e1364efbcd5175e = [];
        level.var_dce7925c2a7a4c36 = forced_bool ?? !level.var_dce7925c2a7a4c36;
        
        if ( level.var_dce7925c2a7a4c36 )
        {
            function_16c584b61a9d3da( 0 );
            function_d0f7f59c169f0717( 0 );
        }
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0xa7a37ec, Offset: 0x15eaa
    // Size: 0xbf, Type: dev
    function private function_c50d482cbfbc1ea5( forced_bool )
    {
        self notify( #"hash_c478820204aa2559" );
        self endon( #"hash_c478820204aa2559" );
        level.var_1825bd49a40d1f41 = forced_bool ?? !level.var_1825bd49a40d1f41;
        
        foreach ( agent in level.controlled_agents )
        {
            agent function_8dea53a2dfc74f94( level.var_1825bd49a40d1f41 );
        }
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0xc
    // Checksum 0xfbabc8a5, Offset: 0x15f71
    // Size: 0x33d, Type: dev
    function private debug_nuke( forced_bool )
    {
        self notify( #"hash_f8f9f6f3beb13ae0" );
        self endon( #"hash_f8f9f6f3beb13ae0" );
        level endon( #"game_ended" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        while ( true )
        {
            dvar = getdvar( @"debug_nuke" );
            
            if ( dvar == "<dev string:x1860>" )
            {
                ai = getaispeciesarray( "<dev string:x1863>", "<dev string:x186c>" );
                
                for ( i = 0; i < ai.size ; i++ )
                {
                    ai[ i ] debug_nuke_kill();
                }
                
                if ( isdefined( level.bosses ) )
                {
                    foreach ( bossstruct in level.bosses )
                    {
                        foreach ( boss in bossstruct.instances )
                        {
                            if ( !boss.damageshield )
                            {
                                if ( isalive( boss ) )
                                {
                                    boss kill( ( 0, 0, -500 ), level.player, level.player );
                                }
                            }
                        }
                    }
                }
                
                setdvar( @"debug_nuke", "<dev string:x1870>" );
            }
            else if ( dvar == "<dev string:x1874>" )
            {
                ai = getaiarray( "<dev string:x1863>" );
                
                for ( i = 0; i < ai.size ; i++ )
                {
                    ai[ i ] debug_nuke_kill();
                }
                
                setdvar( @"debug_nuke", "<dev string:x1870>" );
            }
            else if ( dvar == "<dev string:x1877>" )
            {
                ai = getaispeciesarray( "<dev string:x1863>", "<dev string:x175e>" );
                
                for ( i = 0; i < ai.size ; i++ )
                {
                    ai[ i ] debug_nuke_kill();
                }
                
                setdvar( @"debug_nuke", "<dev string:x1870>" );
            }
            else if ( dvar == "<dev string:x187c>" )
            {
                vehicles = vehicle_getarray();
                
                foreach ( vehicle in vehicles )
                {
                    if ( vehicle.script_team == "<dev string:x1885>" && !vehicle vehicle::is_god() )
                    {
                        vehicle kill();
                    }
                }
                
                setdvar( @"debug_nuke", "<dev string:x1870>" );
            }
            
            waitframe();
        }
    }

    // Namespace ai_mp_controller
    // Params 0, eflags: 0x4
    // Checksum 0x3fc81dd8, Offset: 0x162b6
    // Size: 0x68, Type: dev
    function private debug_nuke_kill()
    {
        if ( !self.damageshield )
        {
            if ( self.unittype == "<dev string:x188a>" )
            {
                self kill( ( 0, 0, -500 ), level.player );
                return;
            }
            
            self kill( ( 0, 0, -500 ), level.player, level.player );
        }
    }

    // Namespace ai_mp_controller
    // Params 0, eflags: 0xc
    // Checksum 0xb867f45f, Offset: 0x16326
    // Size: 0x159, Type: dev
    function private function_486e946d923d7bef()
    {
        self notify( #"hash_a34b38c8f8e74228" );
        self endon( #"hash_a34b38c8f8e74228" );
        player = level.players[ 0 ];
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        spawn_loc = player trace::player_viewangles();
        groundspawnorigin = getgroundposition( getclosestpointonnavmesh( spawn_loc[ "<dev string:x188e>" ] ), 32 );
        agenttype = "<dev string:x1897>";
        agent = spawn( { #category:"<dev string:x1078>", #priority:"<dev string:x746>", #spawnangles:( 0, 0, 0 ), #groundspawnorigin:groundspawnorigin, #agenttype:agenttype } );
        agent.var_4f8a92ebabf37ee = 0;
        agent.dontevershoot = 1;
        agent.ignoreme = 1;
        agent.ignoreall = 1;
        agent.nocorpse = 1;
        agent.var_70fbc1727d54c322 = 1;
        agent.battlechatterallowed = 0;
        agent.skipdeathcount = 1;
        function_2a41d6540a5f0837( agent );
    }

    // Namespace ai_mp_controller
    // Params 0, eflags: 0xc
    // Checksum 0x59b7af24, Offset: 0x16487
    // Size: 0x3ef, Type: dev
    function private function_457634aaa2e1c9dd()
    {
        self notify( #"hash_abaf5b9e513ec1b6" );
        self endon( #"hash_abaf5b9e513ec1b6" );
        player = level.players[ 0 ];
        level endon( #"game_ended" );
        player endon( #"disconnect" );
        
        if ( isdefined( level.var_c46f58591dbaa761 ) )
        {
            level.var_c46f58591dbaa761 delete();
        }
        
        spawn_loc = player trace::player_viewangles();
        spawnorigin = getgroundposition( getclosestpointonnavmesh( spawn_loc[ "<dev string:x188e>" ] ), 32 );
        trigger = spawn( "<dev string:x18b2>", spawnorigin, 0, 512, 256 );
        level.var_c46f58591dbaa761 = trigger;
        
        if ( getdvarint( @"hash_d9a853c7623e83d7" ) )
        {
            thread utility::draw_entity_bounds( trigger, 10000, undefined, 1, 0.1 );
        }
        
        player notifyonplayercommand( "<dev string:x18c1>", "<dev string:x18d4>" );
        player notifyonplayercommand( "<dev string:x18c1>", "<dev string:x18df>" );
        
        while ( true )
        {
            player waittill( #"hash_7ce31c9fb7267704" );
            results = player trace::player_viewangles();
            
            if ( results[ "<dev string:x188e>" ] )
            {
                trigger dontinterpolate();
                trigger.origin = results[ "<dev string:x188e>" ] + ( 0, 0, -128 );
                interaction_ids = function_46c97d1a7b2e662d( trigger );
                temp_array = [];
                sorted_interactions = [];
                
                if ( interaction_ids.size )
                {
                    foreach ( id in interaction_ids )
                    {
                        struct = { #index:temp_array.size, #id:id, #origin:getinteractionorigin( id ) };
                        temp_array[ temp_array.size ] = struct;
                        
                        if ( getdvarint( @"hash_2f0ef3751eeb97d5" ) )
                        {
                            thread utility::draw_line_for_time( struct.origin, struct.origin + ( 0, 0, 128 ), 1, 1, 1, 1000, "<dev string:x18e9>" );
                        }
                        
                        if ( level.var_8fcdcd9fab19394c )
                        {
                            if ( !function_19bf8779c34eef6d( struct.id, "<dev string:xfc6>", "<dev string:x18f4>" ) )
                            {
                            }
                        }
                    }
                    
                    sorted_interactions = sortbydistance( temp_array, results[ "<dev string:x188e>" ] );
                }
                
                if ( level.var_8fcdcd9fab19394c )
                {
                    if ( !arraycontains( level.var_3e1364efbcd5175e, sorted_interactions[ 0 ] ) )
                    {
                        level.var_3e1364efbcd5175e[ level.var_3e1364efbcd5175e.size ] = sorted_interactions[ 0 ];
                        
                        if ( function_19bf8779c34eef6d( struct.id, "<dev string:xfc6>", "<dev string:x18f4>" ) )
                        {
                        }
                        
                        if ( !function_19bf8779c34eef6d( sorted_interactions[ 0 ].id, "<dev string:xfc6>", "<dev string:x1902>" ) )
                        {
                        }
                    }
                    
                    sorted_interactions = level.var_3e1364efbcd5175e;
                }
                
                foreach ( agent in level.controlled_agents )
                {
                    if ( temp_array.size )
                    {
                        agent.var_88af750d8cd349c1 = istrue( getdvarint( @"hash_fb3ec8a412a2283d" ) );
                        agent.var_2a83cd5a466893d4 = undefined;
                        player thread function_a9b5faeb6270436a( agent, sorted_interactions );
                        continue;
                    }
                    
                    agent ai_behavior::function_4a3c03bb49dd5d76( results[ "<dev string:x188e>" ], 8, 1 );
                    agent waittill( #"goal" );
                }
            }
        }
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0x4
    // Checksum 0x493ebc9f, Offset: 0x1687e
    // Size: 0x46, Type: dev
    function private function_2a41d6540a5f0837( agent )
    {
        if ( !isdefined( level.controlled_agents ) )
        {
            level.controlled_agents = [];
        }
        
        level.controlled_agents[ level.controlled_agents.size ] = agent;
        agent thread function_6ed91e871e34a399( agent );
    }

    // Namespace ai_mp_controller
    // Params 1, eflags: 0x4
    // Checksum 0x7f802b67, Offset: 0x168cc
    // Size: 0x41, Type: dev
    function private function_6ed91e871e34a399( agent )
    {
        level endon( #"game_ended" );
        agent waittill( #"death" );
        level.controlled_agents = arrayremove( level.controlled_agents, agent );
    }

    // Namespace ai_mp_controller
    // Params 2
    // Checksum 0xe5e6fe13, Offset: 0x16915
    // Size: 0x6e, Type: dev
    function function_b97e9b0f0008c7c5( agent, interaction )
    {
        agent endon( #"death" );
        self endon( #"hash_7ce31c9fb7267704" );
        agent ai_behavior::function_4a3c03bb49dd5d76( interaction.origin, 8, 1, "<dev string:x190f>" );
        agent waittill( #"goal" );
        agent function_895b16b8fcd857ba( interaction.id );
    }

    // Namespace ai_mp_controller
    // Params 2
    // Checksum 0xc11c7117, Offset: 0x1698b
    // Size: 0x2e, Type: dev
    function function_e4dd09e3ffa3520d( agent, origin )
    {
        self endon( #"hash_7ce31c9fb7267704" );
        ai_behavior::function_2bed913502e8e410( agent, origin );
    }

    // Namespace ai_mp_controller
    // Params 2, eflags: 0xc
    // Checksum 0xbbb3e2a4, Offset: 0x169c1
    // Size: 0x15f, Type: dev
    function private function_a9b5faeb6270436a( agent, interactions )
    {
        self notify( #"hash_409d51843d188cec" );
        self endon( #"hash_409d51843d188cec" );
        self endon( #"disconnect" );
        self endon( #"hash_7ce31c9fb7267704" );
        agent endon( #"death" );
        level endon( #"game_ended" );
        agent function_c50d482cbfbc1ea5( 0 );
        
        if ( !isarray( interactions ) )
        {
            interactions = [ interactions ];
        }
        
        if ( agent ai_behavior::function_f2b0e1b62f57ce9() )
        {
            agent waittill( #"interaction_ended" );
        }
        
        foreach ( interaction in interactions )
        {
            bundle = function_a81da1a0011b447e( interaction.id );
            agent function_895b16b8fcd857ba( interaction.id );
            agent ai_behavior::function_4a3c03bb49dd5d76( interaction.origin, 8, 1 );
            agent waittill( #"goal" );
            agent waittill( #"interaction_ended" );
        }
    }

#/
