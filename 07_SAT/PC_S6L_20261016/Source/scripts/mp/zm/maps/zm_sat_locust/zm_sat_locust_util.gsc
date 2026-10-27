// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util.gsc  (hash_589e3e2722521c84.gscc) (size: 39239 Bytes / 0x9947 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64f6b937 (1693890871)
// size ...... 39239 (0x9947)
// includes .. 46  (offset: 0x9043)
// strings ... 108 (offset: 0x91b3)
// dev strs .. 36  (offset: 0x976b)
// exports ... 92  (offset: 0x5f2f)
// cseg ...... 0x866 + 0x56c9 (0x5f2f)
// imports ... 282 (offset: 0x6d8f)
// animtree1 . 0   (offset: 0x9947)
// animtree2 . 0   (offset: 0x9947)
#using script_16ea1b94f0f381b3;
#using script_236edd51aea4c314;
#using scripts\anim\dialogue;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\nuke;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\weapons\zm_blackhole_bomb;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\tedd_tasks;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_util;

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x5
// Checksum 0x3eec7e00, Offset: 0x884
// Size: 0x20
function private autoexec init()
{
    utility::registersharedfunc( #"zm_sat_locust", #"hash_927f03d84df4a730", &function_2220168ba514a45f );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xa196cad3, Offset: 0x8ac
// Size: 0x1ae
function get_doorbuy( doorbuy_name )
{
    doorbuy = getentarray( doorbuy_name, #targetname );
    
    foreach ( door in doorbuy )
    {
        if ( isdefined( door.s_doorbuy ) )
        {
            return door.s_doorbuy;
        }
    }
    
    foreach ( door in doorbuy )
    {
        if ( door.classname == "script_brushmodel" )
        {
            return door;
        }
    }
    
    a_doors = utility::getstructarray( doorbuy_name );
    
    foreach ( var_1e8dcea37965c118 in a_doors )
    {
        return var_1e8dcea37965c118.door.s_doorbuy;
    }
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0xe48886fa, Offset: 0xa62
// Size: 0x85
function function_295a36ef38f5acae( ref, object )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    assert( isdefined( object ), "<dev string:x3a>" );
    assert( !isdefined( level.quest_objects[ ref ] ), "<dev string:x4f>" + ref + "<dev string:x5a>" + gettime() );
    
    if ( !isdefined( level.quest_objects ) )
    {
        level.quest_objects = [];
    }
    
    level.quest_objects[ ref ] = object;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x24493689, Offset: 0xaef
// Size: 0x53
function get_quest_reference( ref )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    assert( isdefined( level.quest_objects[ ref ] ), "<dev string:x4f>" + ref + "<dev string:x77>" + gettime() );
    return level.quest_objects[ ref ];
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xd2f807ba, Offset: 0xb4b
// Size: 0x2c, Type: bool
function function_3112dc4740eb8499( ref )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    return isdefined( level.quest_objects[ ref ] );
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0xfaf96ae6, Offset: 0xb80
// Size: 0x6e
function function_222215ce3aef9da1( ref, object )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    assert( isdefined( object ), "<dev string:x3a>" );
    assert( isdefined( level.quest_objects[ ref ] ), "<dev string:x4f>" + ref + "<dev string:x77>" + gettime() );
    level.quest_objects[ ref ] = object;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x2726a75b, Offset: 0xbf6
// Size: 0x2b
function function_7bf944a5a2b76f39( ref )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    level.quest_objects[ ref ] = undefined;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x61d3fefa, Offset: 0xc29
// Size: 0xcc
function function_a70056d3a99eace5( ref )
{
    assert( isxhash( ref ), "<dev string:x24>" );
    
    if ( function_3112dc4740eb8499( ref ) )
    {
        referenced_object = get_quest_reference( ref );
        
        if ( isarray( referenced_object ) )
        {
            foreach ( obj in referenced_object )
            {
                function_71ad0bff4c060796( obj );
            }
        }
        else
        {
            function_71ad0bff4c060796( referenced_object );
        }
        
        function_7bf944a5a2b76f39( ref );
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xe6adbae, Offset: 0xcfd
// Size: 0x6f
function function_71ad0bff4c060796( referenced_object )
{
    if ( isent( referenced_object ) )
    {
        referenced_object delete();
        return;
    }
    
    if ( isstruct( referenced_object ) )
    {
        referenced_object = undefined;
        return;
    }
    
    if ( referenced_object isscriptableinstance() )
    {
        if ( referenced_object getscriptableparthasstate( referenced_object function_84ad2f70189ee7c3(), #"disabled" ) )
        {
            referenced_object setscriptablepartstate( referenced_object function_84ad2f70189ee7c3(), #"disabled" );
            return;
        }
        
        referenced_object freescriptable();
    }
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0xd2685022, Offset: 0xd74
// Size: 0x39
function function_21931a8eba7c0535( quest_ref, step_ref, players, params )
{
    utility::array_thread( players, &function_4514f1f79d348284, quest_ref, step_ref, params );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xeec5bfe8, Offset: 0xdb5
// Size: 0x8a
function function_4514f1f79d348284( quest_ref, step_ref, params )
{
    zm_quest::function_fba942a1cfd85f5d( 1, 0, quest_ref, step_ref );
    zm_quest::function_fb3af5600f6a9441( 1, 0, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xd3e28c50, Offset: 0xe47
// Size: 0x8f
function function_d500031798dc2c12( quest_ref, step_ref, params )
{
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, quest_ref, step_ref );
    level zm_quest::function_fb3af5600f6a9441( 1, 1, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        level function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0x2dcbcd3c, Offset: 0xede
// Size: 0x39
function function_6a660cd129095358( quest_ref, step_ref, players, params )
{
    utility::array_thread( players, &function_bebcac3a92f1773b, quest_ref, step_ref, params );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xefb34f73, Offset: 0xf1f
// Size: 0x8a
function function_bebcac3a92f1773b( quest_ref, step_ref, params )
{
    zm_quest::function_fba942a1cfd85f5d( 1, 0, quest_ref, step_ref );
    zm_quest::function_fb3af5600f6a9441( 2, 0, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xe22a5f91, Offset: 0xfb1
// Size: 0x8d
function function_8b54d0e577decf05( quest_ref, step_ref, params )
{
    zm_quest::function_fba942a1cfd85f5d( 1, 1, quest_ref, step_ref );
    zm_quest::function_fb3af5600f6a9441( 2, 1, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        level function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0x34759874, Offset: 0x1046
// Size: 0x39
function function_2211f14c53e8a96d( quest_ref, step_ref, players, params )
{
    utility::array_thread( players, &function_966abe9667545ac, quest_ref, step_ref, params );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x89595563, Offset: 0x1087
// Size: 0xc1
function function_966abe9667545ac( quest_ref, step_ref, params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_5ac1f726a1e2d08 = params.var_5ac1f726a1e2d08 ?? 0;
    zm_quest::function_fb3af5600f6a9441( 3, var_5ac1f726a1e2d08, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    
    if ( self )
    {
        zm_quest::function_fba942a1cfd85f5d( 0, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xfb36796e, Offset: 0x1150
// Size: 0x9b
function function_538935367d87dca( quest_ref, step_ref, params )
{
    level endon( #"game_ended" );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        level function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_ref, step_ref );
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0xd524f801, Offset: 0x11f3
// Size: 0x39
function function_95f75c64fd2a760a( quest_ref, step_ref, players, params )
{
    utility::array_thread( players, &function_c42a062a032d8bbd, quest_ref, step_ref, params );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x80e1f102, Offset: 0x1234
// Size: 0x8a
function function_c42a062a032d8bbd( quest_ref, step_ref, params )
{
    zm_quest::function_fb3af5600f6a9441( 4, 0, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    zm_quest::function_fba942a1cfd85f5d( 0, 0, quest_ref, step_ref );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x119eaedf, Offset: 0x12c6
// Size: 0x8f
function function_e87fbeb96f6b390f( quest_ref, step_ref, params )
{
    level zm_quest::function_fb3af5600f6a9441( 4, 1, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        level function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_ref, step_ref );
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0xefbe8447, Offset: 0x135d
// Size: 0x39
function function_8fc9de196aa509c9( quest_ref, step_ref, players, params )
{
    utility::array_thread( players, &function_f6dd0fd21ea7a060, quest_ref, step_ref, params );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x238070f, Offset: 0x139e
// Size: 0xa5
function function_f6dd0fd21ea7a060( quest_ref, step_ref, params )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    zm_quest::function_fb3af5600f6a9441( 0, 0, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    
    if ( self )
    {
        zm_quest::function_fba942a1cfd85f5d( 0, 0, quest_ref, step_ref );
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x5497eee3, Offset: 0x144b
// Size: 0x9a
function function_6a2d4b2055f04166( quest_ref, step_ref, params )
{
    level endon( #"game_ended" );
    level zm_quest::function_fb3af5600f6a9441( 0, 1, quest_ref, step_ref );
    
    if ( isdefined( params ) )
    {
        level function_68d02dd51f9cb2d4( quest_ref, step_ref, params.time, params.var_e5557a1483620915, params.progress, params.var_cf684f09b6c37c3a, params.placement, params.var_f0336d2d3e6daf74 );
    }
    
    waitframe();
    level zm_quest::function_fba942a1cfd85f5d( 0, 1, quest_ref, step_ref );
}

// Namespace zm_sat_locust_util
// Params 8
// Checksum 0x15cd2126, Offset: 0x14ed
// Size: 0xcc
function function_68d02dd51f9cb2d4( quest_ref, step_ref, time, var_e5557a1483620915, progress, var_cf684f09b6c37c3a, placement, var_f0336d2d3e6daf74 )
{
    var_5ac1f726a1e2d08 = self == level;
    
    if ( isdefined( time ) )
    {
        zm_quest::function_612a9ad0db22c29c( time, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
    
    if ( isdefined( var_e5557a1483620915 ) )
    {
        zm_quest::function_194bde735238c397( var_e5557a1483620915, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
    
    if ( isdefined( progress ) )
    {
        zm_quest::function_9f49b2a045ece8ae( progress, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
    
    if ( isdefined( var_cf684f09b6c37c3a ) )
    {
        zm_quest::function_c2af37f835cd840b( var_cf684f09b6c37c3a, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
    
    if ( isdefined( placement ) )
    {
        zm_quest::function_bf63bf6d044ad598( placement, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
    
    if ( isdefined( var_f0336d2d3e6daf74 ) )
    {
        zm_quest::function_49f2a6a3c1320a6d( placement, var_5ac1f726a1e2d08, quest_ref, step_ref );
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xea463153, Offset: 0x15c1
// Size: 0x2e2
function spawn_quest_item( params )
{
    if ( !isdefined( params.spawnoptions ) )
    {
        switch ( params.spawntype )
        {
            case #"spawn_at_pos":
                assert( isdefined( params.spawnorigin ) );
                spawnoptions = common_item::function_bc5ff2958b71a708( params.spawnorigin, params.spawnangles );
                break;
            case #"hash_396d489cffb7196b":
                assert( isdefined( params.spawningent ) );
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( params.spawningent );
                break;
            case #"spawn_from_pos":
                assert( isdefined( params.fromorigin ) );
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( params.fromorigin, params.fromangles );
                break;
            case #"hash_5624a153809c30bc":
                assert( isdefined( params.toorigin ) && isdefined( params.spawningent ) );
                spawnoptions = common_item::function_b94327aa4c1b718b( params.toorigin, params.spawningent, params.toangles );
                break;
            case #"spawn_to_pos_from_pos":
                assert( isdefined( params.toorigin ) && isdefined( params.fromorigin ) );
                spawnoptions = common_item::function_f5dfaa3bbdf99a33( params.toorigin, params.fromorigin, params.toangles );
                break;
        }
        
        if ( !isdefined( spawnoptions ) )
        {
            assertmsg( "<dev string:x8f>" + getxhashsourcename( params.spawntype ) + "<dev string:xb1>" );
            return;
        }
        
        if ( !params.var_6be4773315feef86 )
        {
            spawnoptions.var_fd47e835523b473f = 1;
        }
        
        if ( params.payload )
        {
            spawnoptions.payload = params.payload;
        }
        
        spawnoptions.critical = 1;
        spawnoptions.var_f35b5b18b029c493 = istrue( params.checkmovingplatform );
    }
    else
    {
        spawnoptions = params.spawnoptions;
        
        if ( !isdefined( spawnoptions.var_fd47e835523b473f ) )
        {
            spawnoptions.var_fd47e835523b473f = 1;
        }
        
        if ( !isdefined( spawnoptions.critical ) )
        {
            spawnoptions.critical = 1;
        }
    }
    
    item = common_item::items_spawnitemfromscriptable( params.asset, params.count ?? 1, spawnoptions );
    
    if ( item )
    {
        item.var_e78811eec0c27aa = 1;
    }
    
    assert( isdefined( item ) );
    level zombie_shade_loot_consume::function_2c1c775b372991b0( 0, undefined, undefined, undefined, [ item ] );
    return item;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x157a747a, Offset: 0x18ac
// Size: 0x24
function get_quest_item_ref( item_name )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        item_name = hashcat( item_name, "_guided" );
    }
    
    return item_name;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xa9526344, Offset: 0x18d9
// Size: 0x6c
function bubble_shield_init( params )
{
    assert( !isdefined( self.bubble_shield ) && isdefined( params ) || self.bubble_shield.state == 1 && !isdefined( params ) );
    assert( self getscriptablehaspart( #"bubble_shield" ), "<dev string:xc9>" );
    bubble_shield_data( params );
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0xbb15cc93, Offset: 0x194d
// Size: 0x1fe
function private bubble_shield_data( params )
{
    utility::function_32b24db3127bff40( #"bubble_shield", "enabled" );
    val::set( #"bubble_shield", "damageshield", 1 );
    self.invulnerable = 1;
    
    if ( !isdefined( self.bubble_shield ) )
    {
        self.var_15598d8e493afe88 = 1;
        self.var_825b17c932865df = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self.ignore_enemy_count = 1;
        self.var_7ee152b43c7188e1 = 1;
        val::set( #"bubble_shield", "ignore_cleanup", 1 );
        zombie_utils::function_dfae6a5bd222c586( &function_1670588e6ff635d6 );
        self.bubble_shield = params;
        self.bubble_shield.current_gate = 0;
        
        /#
            if ( params.type == 1 )
            {
                assert( !isdefined( params.hits ), "<dev string:xfa>" );
            }
        #/
        
        if ( params.type == 0 )
        {
            assert( params.hits > 0, "<dev string:x144>" );
            self.bubble_shield.var_c04d36d92a6f0731 = int( round( params.maxhealth / params.hits ) );
        }
        
        self.var_85111bb9ad8b0dba = [ &function_32879f9736406165 ];
    }
    else
    {
        self.bubble_shield.current_gate++;
    }
    
    self.var_81239cbfa6fb7d8b = &function_33e6dffa7560aa4b;
    self.bubble_shield.invul_time = int( gettime() + 1000 );
    self.bubble_shield.health = self.bubble_shield.maxhealth;
    self.bubble_shield.state = 3;
    self.bubble_shield.broken_time = undefined;
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0x48d820e6, Offset: 0x1b53
// Size: 0x41f
function private function_1670588e6ff635d6( params )
{
    if ( !isdefined( params.eattacker ) )
    {
        return 0;
    }
    
    if ( self.bubble_shield.state == 1 )
    {
        return 0;
    }
    
    if ( self.bubble_shield.invul_time > gettime() )
    {
        return 0;
    }
    
    if ( self.bubble_shield.state > 0 )
    {
        if ( val::get( "damageshield" ) )
        {
            if ( function_1097a7f611fe2a6a( params ) )
            {
                if ( self.bubble_shield.health > 0 )
                {
                    damage = function_75bfff8363f22120( params );
                    self.bubble_shield.health -= damage;
                    params.var_4f9d5587bf9a2b1e = 1;
                    params.var_d5020ae6ddd07b6e = 1;
                    self playsoundonmovingent( "evt_quest_lim_spc_shield_dmg" );
                    
                    if ( self.bubble_shield.health > 0 )
                    {
                        params.eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( "hitarmor" );
                        
                        if ( self.bubble_shield.state == 3 && self.bubble_shield.health <= int( floor( self.bubble_shield.maxhealth / 2 ) ) )
                        {
                            utility::function_32b24db3127bff40( #"bubble_shield", #"damaged" );
                            self.bubble_shield.state = 2;
                        }
                    }
                    else if ( !isdefined( self.bubble_shield.broken_time ) )
                    {
                        self.bubble_shield.broken_time = gettime();
                        params.eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( "hitarmorbreak" );
                        thread bubble_shield_break();
                    }
                    
                    if ( params.var_ff33243f5be1fe3b < 1 )
                    {
                        params.shitloc = "none";
                    }
                    
                    return damage;
                }
            }
            else
            {
                params.var_4f9d5587bf9a2b1e = 1;
                params.var_d5020ae6ddd07b6e = 1;
                params.eattacker namespace_9d8e359c3b1041e5::updateDamageFeedback_SharedFunc( "hitarmor" );
                self playsoundonmovingent( "evt_quest_lim_spc_shield_dmg_deflect" );
                return 0;
            }
        }
    }
    else if ( isdefined( self.bubble_shield.health_gate[ self.bubble_shield.current_gate ] ) && !val::get( "damageshield" ) && self.bubble_shield.state == 0 )
    {
        gate_health = int( round( self.maxhealth * self.bubble_shield.health_gate[ self.bubble_shield.current_gate ] ) );
        capped_damage = minint( int( params.idamage ), int( params.var_ff33243f5be1fe3b * self.maxhealth ) );
        
        /#
            if ( isplayer( params.eattacker ) )
            {
                params.eattacker iprintln( "<dev string:x192>" + self.bubble_shield.current_gate + "<dev string:x1b1>" + self.bubble_shield.health_gate[ self.bubble_shield.current_gate ] + "<dev string:x1ba>" + ( self.health - capped_damage ) / self.maxhealth );
            }
        #/
        
        if ( self.health - capped_damage <= gate_health )
        {
            params.var_d3006097a8584457 = 1;
            self.bubble_shield.state = 1;
            return maxint( self.health - gate_health, 0 );
        }
    }
    
    return params.idamage;
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0xce28c2e6, Offset: 0x1f7b
// Size: 0xc1, Type: bool
function private function_1097a7f611fe2a6a( params )
{
    profilestart();
    
    if ( !isdefined( self.bubble_shield.var_cb7b53471c8f3170 ) && !isdefined( self.bubble_shield.damage_verify ) )
    {
        profilestop();
        return true;
    }
    
    if ( self.bubble_shield.var_cb7b53471c8f3170 && self.bubble_shield.var_cb7b53471c8f3170 == params.objweapon.basenamehash )
    {
        profilestop();
        return true;
    }
    
    if ( self.bubble_shield.damage_verify && self [[ self.bubble_shield.damage_verify ]]( params ) )
    {
        profilestop();
        return true;
    }
    
    profilestop();
    return false;
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0x6b01f300, Offset: 0x2046
// Size: 0x8c
function private function_75bfff8363f22120( params )
{
    profilestart();
    
    if ( self.bubble_shield.var_92bd9443574005a7 )
    {
        damage = self [[ self.bubble_shield.var_92bd9443574005a7 ]]( params );
    }
    else
    {
        damage = self.bubble_shield.type == 0 ? self.bubble_shield.var_c04d36d92a6f0731 : params.idamage;
    }
    
    profilestop();
    return int( damage );
}

// Namespace zm_sat_locust_util
// Params 13, eflags: 0x4
// Checksum 0x9a9cd960, Offset: 0x20dc
// Size: 0xc6
function private function_32879f9736406165( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname )
{
    if ( self.bubble_shield.state == 1 )
    {
        bubble_shield_init();
        
        if ( isdefined( self.bubble_shield.reactivate ) )
        {
            self [[ self.bubble_shield.reactivate ]]();
        }
    }
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0xb7a8a0ef, Offset: 0x21aa
// Size: 0xd, Type: bool
function private function_33e6dffa7560aa4b( dmg_struct )
{
    return false;
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x4
// Checksum 0x803dbfc8, Offset: 0x21c0
// Size: 0xdc
function private bubble_shield_break()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( #"bubble_shield", #"broken" );
    self.bubble_shield.state = 0;
    self.invulnerable = 0;
    
    if ( self.bubble_shield.var_772501ce9a0c24da > 0 )
    {
        if ( !self.aisettings.var_b11b8458c44f3024 )
        {
            self.aisettings.var_b11b8458c44f3024 = 1;
        }
        
        zombie_stun::stun_ai( self.bubble_shield.var_772501ce9a0c24da );
        self.aisettings.var_b11b8458c44f3024 = undefined;
    }
    
    waitframe();
    self.var_81239cbfa6fb7d8b = undefined;
    val::reset( #"bubble_shield", "damageshield" );
}

/#

    // Namespace zm_sat_locust_util
    // Params 1, eflags: 0x4
    // Checksum 0x2c2c0378, Offset: 0x22a4
    // Size: 0x80, Type: dev
    function private function_72c458d61d67df97( params )
    {
        if ( self getscriptablehaspart( #"bubble_shield" ) )
        {
            params = { #hits:4, #health_gate:[ 0.75, 0.5, 0.25 ], #var_772501ce9a0c24da:2, #maxhealth:5000, #type:0 };
            thread bubble_shield_init( params );
        }
    }

#/

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x40fc8503, Offset: 0x232c
// Size: 0x275
function spawn_quest_zombie( params )
{
    if ( isdefined( params.spawner_zombie_type ) )
    {
        aitype = params.spawner_zombie_type;
    }
    else
    {
        var_e1a5418b150090f1 = utility::random_weighted_struct( params.aitypes );
        aitype = var_e1a5418b150090f1.type;
    }
    
    sub_aitype = function_b3988325430ce242( aitype );
    aitype = sub_aitype ?? aitype;
    
    if ( isdefined( params.spawn_zones ) )
    {
        zombie = zone_spawner::spawn_agent( aitype, { #zones:params.spawn_zones } );
    }
    else if ( isdefined( params.var_b3daf67a5a5ba863 ) )
    {
        node = utility::array_random( params.var_b3daf67a5a5ba863 );
        zombie = agent_manager::spawn_agent( aitype, node.origin, node.angles, "team_two_hundred" );
    }
    else if ( isdefined( params.var_30085f70fc117162 ) )
    {
        node = params.var_30085f70fc117162;
        zombie = agent_manager::spawn_agent( aitype, node.origin, node.angles, "team_two_hundred" );
    }
    else if ( params.spawn_anywhere )
    {
        zombie = agent_spawner::spawn_agent( aitype );
    }
    else
    {
        assertmsg( "<dev string:x1cb>" + "<dev string:x1f2>" );
    }
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( isdefined( node ) && isdefined( node.script_animation ) )
    {
        zombie thread zone_spawner::function_ce10e453e7f7bb8e( node );
    }
    
    zombie function_9bb18b78d02f546f();
    zombie set_eyes( params );
    zombie set_values( params );
    
    if ( isdefined( params.drop_list[ zombie.subclass ] ) )
    {
        zombie set_loot( params.drop_list[ zombie.subclass ] );
    }
    
    zombie zombie_utils::set_zombie_round_difficulty( params.difficulty_round_number ?? zm_utility::get_round_number(), params.round_update_health, params.var_a83af9ca082b80b );
    zombie callback::add( "on_zombie_ai_killed", &function_d9283949233d5436, params );
    
    if ( !isdefined( params.var_4c6516944983d5d8 ) )
    {
        params.var_4c6516944983d5d8 = [];
    }
    
    params.var_4c6516944983d5d8[ params.var_4c6516944983d5d8.size ] = zombie;
    return zombie;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x50bb15ee, Offset: 0x25aa
// Size: 0x18f
function set_values( params )
{
    if ( self.aicategory == "elite" )
    {
        self.var_e7095781f14d8c2d = 1;
    }
    
    if ( !params.allow_cleanup )
    {
        self.var_825b17c932865df = 1;
        val::set( "quest_zombie", "ignore_cleanup", 1 );
    }
    
    if ( params.skip_values )
    {
        return;
    }
    
    self.b_cleanup_no_respawn = 1;
    self.var_15598d8e493afe88 = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.ignore_enemy_count = 1;
    self.no_powerups = 1;
    
    if ( params.forced_move_speed )
    {
        zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( params.forced_move_speed == "super_sprint" || params.forced_move_speed == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && params.forced_move_speed == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && params.forced_move_speed == "sprint" ? "run" : params.forced_move_speed, "quest_zombie", 6 );
    }
    
    thread function_5691e2783b3cf978();
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x4
// Checksum 0x265aaef3, Offset: 0x2741
// Size: 0x94
function private function_5691e2783b3cf978()
{
    self endon( #"death" );
    
    switch ( self.subclass )
    {
        case #"hash_1380581f5144c465":
            utility::ent_flag_wait( "register_emergence_spawning_settings_through_death_completed" );
            zombie_emergence_spawning::function_80623a2279a4d888();
            break;
        case #"hash_c8364cded587d807":
            zombie_emergence_spawning::function_80623a2279a4d888();
            break;
        case #"hash_95ca02b3cab53ad5":
            val::set( "quest_zombie", "dont_evolve", 1 );
            break;
        case #"hash_b4981557ecbe551":
            utility::ent_flag_set( "ghoul_evolve_disabled" );
            break;
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xcfdd9936, Offset: 0x27dd
// Size: 0x2f
function set_loot( drop_list )
{
    self.var_57fdcc855c1a3725 = drop_list;
    self.var_50c96a5c56dab386 = &loot_drop;
    self.var_a13bed1ac47e1b2c = undefined;
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x4
// Checksum 0x77eb074b, Offset: 0x2814
// Size: 0x177
function private loot_drop()
{
    if ( isstruct( self.var_57fdcc855c1a3725 ) )
    {
        switch ( self.subclass )
        {
            case #"hash_99a38be9e88b5244":
            case #"hash_f297af39454fdc7b":
                attacker = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
                var_b6ce022ba8ef3e28 = isplayer( attacker ) && attacker armor::function_22290101992e4874() <= 1;
                
                if ( var_b6ce022ba8ef3e28 && isdefined( self.var_57fdcc855c1a3725.armored ) )
                {
                    var_a36a123d827025e1 = self.var_57fdcc855c1a3725.armored;
                }
                else
                {
                    var_a36a123d827025e1 = self.var_57fdcc855c1a3725.normal;
                }
                
                break;
        }
    }
    else if ( isstring( self.var_57fdcc855c1a3725 ) )
    {
        var_a36a123d827025e1 = self.var_57fdcc855c1a3725;
    }
    
    assert( isdefined( var_a36a123d827025e1 ) );
    droplist = level.mapname + "_" + var_a36a123d827025e1 + "_item_list";
    dropquantity = 1;
    droppos = self.origin;
    params = { #droppos:droppos, #dropquantity:dropquantity, #droplist:droplist };
    return params;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x70dbb129, Offset: 0x2994
// Size: 0x9a
function function_e3fda40c3fe2b3cd( params )
{
    if ( level.var_a009ab14ee0d3223.state == 1 )
    {
        while ( !zm_utility::function_922d522db5f1ceda( params.count, [ "normal" ], undefined ) )
        {
            wait 0.5;
        }
    }
    
    while ( params.count > 0 )
    {
        zombie = spawn_quest_zombie( params );
        
        if ( zombie )
        {
            params.count--;
            
            if ( params.count % 5 == 0 )
            {
                waitframe();
            }
        }
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x996ddd70, Offset: 0x2a36
// Size: 0x180
function function_43a905fb3bee362a( flag, origin, radius = 448 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( flag ) )
    {
        if ( isarray( flag ) )
        {
            foreach ( text in flag )
            {
                level endon( text );
            }
        }
        else
        {
            level endon( flag );
        }
    }
    
    radius = squared( radius );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( distancesquared( player.origin, origin ) <= radius )
                {
                    if ( isdefined( self.objid ) )
                    {
                        zm_quest::complete_objective_waypoints( self.objid );
                        self.objid = undefined;
                    }
                    
                    return;
                }
            }
        }
        
        wait 0.125;
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x5515f8f6, Offset: 0x2bbe
// Size: 0x195
function function_abbae1f498a00649( flag, origin, radius = 448 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( flag ) )
    {
        if ( isarray( flag ) )
        {
            foreach ( text in flag )
            {
                level endon( text );
            }
        }
        else
        {
            level endon( flag );
        }
    }
    
    radius = squared( radius );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( distancesquared( player.origin, origin ) <= radius && player trace::can_see_origin( origin, 0, undefined, player, 1 ) )
                {
                    if ( isdefined( self.objid ) )
                    {
                        zm_quest::complete_objective_waypoints( self.objid );
                        self.objid = undefined;
                    }
                    
                    return player;
                }
            }
        }
        
        wait 0.125;
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xcf8b048f, Offset: 0x2d5b
// Size: 0x2cd
function function_e202f5a7f8d0e89f( start_position, end_position, part_name = #"default" )
{
    level endon( #"game_ended" );
    vfx_root = utility::spawn_model( %"sat_zm_effect_wisp", start_position, vectortoangles( end_position - start_position ) );
    vfx_root forcenetfieldhighlod( 1 );
    vfx_root utility::function_32b24db3127bff40( part_name, #"created" );
    vfx_root endon( #"death" );
    vfx_root endon( #"entitydeleted" );
    
    if ( isdefined( self.soul_wisps ) )
    {
        self.soul_wisps[ self.soul_wisps.size ] = vfx_root;
    }
    
    var_4f58ae3108177d2c = distance( start_position, end_position );
    var_36340753cb0e64d5 = var_4f58ae3108177d2c / 10;
    speed = 150 * var_36340753cb0e64d5 + 100;
    speed += randomfloatrange( -1 * speed * 0.2 / 2, speed * 0.2 / 2 );
    speed = clamp( speed, 100, 250 );
    duration = var_4f58ae3108177d2c / speed;
    vfx_root thread utility::delete_after_delay( duration + level.framedurationseconds );
    start_timestamp = gettime();
    current_timestamp = start_timestamp;
    spiral_seed = randomint( 360 );
    spiral_frequency = randomfloatrange( 3, 4 );
    spiral_magnitude = randomintrange( 25, 35 );
    var_37b66bef2ccb4209 = start_position[ 2 ] - end_position[ 2 ];
    
    if ( var_37b66bef2ccb4209 < 12 )
    {
        target_z_offset = randomintrange( 4, 12 ) + var_37b66bef2ccb4209 / 2;
    }
    else if ( var_37b66bef2ccb4209 < 24 )
    {
        target_z_offset = randomintrange( 0, 4 ) + var_37b66bef2ccb4209 / 2;
    }
    else
    {
        target_z_offset = randomintrange( -4, 0 ) + var_37b66bef2ccb4209 / 2;
    }
    
    lerp_value = 0;
    
    while ( lerp_value < 1 )
    {
        current_timestamp = gettime();
        lerp_spiral_magnitude = sin( lerp_value * 180 ) * spiral_magnitude;
        spiral_angle = spiral_seed + spiral_frequency * lerp_value * 180;
        var_83b5f6ccc840848e = rotatepointaroundvector( anglestoforward( vfx_root.angles ), lerp_spiral_magnitude * anglestoright( vfx_root.angles ), spiral_angle );
        v_z_offset = ( 0, 0, target_z_offset * sin( lerp_value * 180 + sin( lerp_value * 180 ) / -1 ) );
        target_position = vectorlerp( start_position, end_position, lerp_value ) + v_z_offset + var_83b5f6ccc840848e;
        vfx_root.origin = target_position;
        lerp_value = pow( ( current_timestamp - start_timestamp ) / 1000 / duration, 1.25 );
        waitframe();
    }
    
    vfx_root delete();
}

// Namespace zm_sat_locust_util
// Params 7
// Checksum 0x71ad36b4, Offset: 0x3030
// Size: 0x1e5
function function_3fa3cd4714495cf7( radius, time, center_or_ent, n_circles = 1, f_starting_offset, b_forever = 0, b_flip_angles = 0 )
{
    self notify( #"hash_906281475c4cb13b" );
    self endon( #"hash_906281475c4cb13b" );
    self endon( #"death" );
    self endon( #"interrupt_circle_move" );
    t = 0;
    move_start = gettime();
    new_origin = self.origin;
    
    if ( b_forever )
    {
        assert( b_forever && n_circles == 1, "<dev string:x20f>" );
        n_circles = 1;
    }
    
    if ( !isvector( center_or_ent ) )
    {
        center_or_ent endon( #"death" );
        center = center_or_ent.origin;
    }
    else
    {
        center = center_or_ent;
    }
    
    if ( !isdefined( f_starting_offset ) )
    {
        f_starting_offset = vectortoangles( self.origin - center )[ 1 ];
    }
    else
    {
        self dontinterpolate();
    }
    
    t = 0;
    
    for ( ;; )
    {
        t = ( gettime() - move_start ) / 1000 / time;
        theta = n_circles * 360 * t + f_starting_offset;
        new_origin = ( center[ 0 ] + cos( theta ) * radius, center[ 1 ] + sin( theta ) * radius, self.origin[ 2 ] );
        angles = b_flip_angles ? ( 0, vectortoyaw( new_origin - center ), 0 ) : ( 0, vectortoyaw( center - new_origin ), 0 );
        self.origin = new_origin;
        self.angles = angles;
        
        if ( !b_forever && t >= 1 )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"off_circle_move" );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x1508e85a, Offset: 0x321d
// Size: 0x123
function holdout_event( params )
{
    assert( isstring( params.name ) );
    assert( isarray( params.spawn_zones ) && params.spawn_zones.size > 0 && isstruct( params.spawn_zones[ 0 ] ) );
    assert( isstring( params.spawner_zombie_type ) || isarray( params.aitypes ) && params.aitypes.size > 0 );
    assert( isint( params.difficulty_round_number ) );
    assert( isint( params.var_d346909023f61570 ) );
    assert( isdefined( params.spawner_zombie_type ) && !isdefined( params.aitypes ) || !isdefined( params.spawner_zombie_type ) && isdefined( params.aitypes ) );
    start_holdout_event( params );
    cleanup_holdout_event( params );
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0x7e26fcc6, Offset: 0x3348
// Size: 0x381
function private start_holdout_event( params )
{
    level endon( #"game_ended" );
    assert( !is_holdout_event_active( params.name ) );
    level notify( "holdout_" + params.name );
    level endon( "holdout_" + params.name );
    
    if ( params.var_201aaa0c57618626 )
    {
        powerups::function_b3ef1ccbc3c4bbbb( 0 );
    }
    
    params.var_4c6516944983d5d8 = [];
    params.spawned_count = 0;
    
    if ( !isdefined( level.holdout_event ) )
    {
        level.holdout_event = [];
    }
    
    level.holdout_event[ params.name ] = params;
    params.var_de0e7ba14e831fa0 = params.spawn_zones;
    
    while ( true )
    {
        active_zombie_count = params.var_98f23c369371e8ec ? params.var_4c6516944983d5d8.size : zm_utility::get_active_zombies_count();
        
        if ( active_zombie_count >= params.max_active_zombies )
        {
            /#
                timed_error_print( params.name, "<dev string:x23b>", "<dev string:x246>" + active_zombie_count + "<dev string:x273>" + params.max_active_zombies );
            #/
            
            waitframe();
            continue;
        }
        
        if ( params.max_spawn_count && params.max_spawn_count == params.spawned_count )
        {
            /#
                timed_error_print( params.name, "<dev string:x23b>", "<dev string:x278>" + params.max_spawn_count + "<dev string:x273>" + params.spawned_count );
            #/
            
            waitframe();
            continue;
        }
        
        zone = utility::array_random( params.var_de0e7ba14e831fa0 );
        
        if ( params.var_1e899b25f3766233 )
        {
            if ( isdefined( zone ) )
            {
                var_c96b1c3cfbbd6aac = zone zone_manager::get_adjacent_zones( 1, 1 );
                
                if ( var_c96b1c3cfbbd6aac.size > 0 )
                {
                    params.spawn_zones = arraycombineunique( params.spawn_zones, var_c96b1c3cfbbd6aac );
                }
            }
            
            if ( !isdefined( params.spawn_zones ) )
            {
                /#
                    timed_error_print( params.name, "<dev string:x296>", "<dev string:x2a2>" );
                #/
                
                waitframe();
                continue;
            }
        }
        else
        {
            params.spawn_zones = [ zone ];
        }
        
        zombie = spawn_quest_zombie( params );
        
        if ( !isdefined( zombie ) )
        {
            /#
                timed_error_print( params.name, "<dev string:x2bc>", "<dev string:x2c4>" );
            #/
            
            waitframe();
            continue;
        }
        
        params.spawned_count++;
        
        if ( isdefined( params.var_24bb5c2aa0708efb ) )
        {
            profilestart();
            zombie [[ params.var_24bb5c2aa0708efb ]]();
            profilestop();
        }
        
        if ( params.var_98f23c369371e8ec )
        {
            var_d2dea1eb5c269d79 = function_5f35aa2e209190da( params.var_d346909023f61570, undefined, params.var_4c6516944983d5d8 );
        }
        else
        {
            var_d2dea1eb5c269d79 = zm_round_spawning::function_5f35aa2e209190da( params.var_d346909023f61570, undefined );
        }
        
        println( "<dev string:x2e0>" + params.name + "<dev string:x2eb>" + zombie.subclass + "<dev string:x2f8>" + params.var_4c6516944983d5d8.size + "<dev string:x303>" + ( params.max_active_zombies ?? 0 ) + "<dev string:x30c>" + var_d2dea1eb5c269d79 );
        wait var_d2dea1eb5c269d79;
    }
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0x10f77f4e, Offset: 0x36d1
// Size: 0x12a
function private cleanup_holdout_event( params )
{
    assert( isdefined( level.holdout_event[ params.name ] ) );
    level callback::remove( "on_zombie_ai_killed", &function_d9283949233d5436, params );
    level.holdout_event[ params.name ] = undefined;
    
    if ( params.var_4fa56704c1ab3810 )
    {
        return;
    }
    
    if ( params.var_201aaa0c57618626 )
    {
        powerups::function_b3ef1ccbc3c4bbbb( 1 );
    }
    
    zombies = params.var_4c6516944983d5d8;
    
    if ( isdefined( params.var_7fb5582d329c86ae.range ) && isdefined( params.var_7fb5582d329c86ae.origin ) )
    {
        local_zombies = getaiarrayinradius( params.var_7fb5582d329c86ae.origin, params.var_7fb5582d329c86ae.range, zm_utility::get_zombie_team() );
        zombies = arraycombineunique( zombies, local_zombies );
    }
    
    zombies = function_46f9072493651dc9( zombies );
    utility::array_thread( zombies, &wipe_zombie, 0, 0.5, 1 );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x8578b19c, Offset: 0x3803
// Size: 0x32
function end_holdout_event( name )
{
    assert( isdefined( name ) );
    assert( is_holdout_event_active( name ) );
    level notify( "holdout_" + name );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x2d45389, Offset: 0x383d
// Size: 0x24, Type: bool
function is_holdout_event_active( name )
{
    assert( isdefined( name ) );
    return isdefined( level.holdout_event[ name ] );
}

// Namespace zm_sat_locust_util
// Params 2, eflags: 0x4
// Checksum 0x5b881711, Offset: 0x386a
// Size: 0xc3
function private function_d9283949233d5436( params, additional_params )
{
    if ( additional_params.active_zombie.size == 0 )
    {
        return;
    }
    
    assert( arraycontains( additional_params.var_4c6516944983d5d8, self ) );
    
    if ( isdefined( additional_params.on_zombie_killed ) )
    {
        profilestart();
        self [[ additional_params.on_zombie_killed ]]( params, additional_params );
        profilestop();
    }
    
    /#
        prev_size = additional_params.var_4c6516944983d5d8.size;
    #/
    
    additional_params.var_4c6516944983d5d8 = arrayremove( additional_params.var_4c6516944983d5d8, self );
    
    /#
        new_size = additional_params.var_4c6516944983d5d8.size;
        assert( new_size < prev_size, "<dev string:x31a>" );
    #/
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0x4aa75cb6, Offset: 0x3935
// Size: 0xab
function function_9bb18b78d02f546f()
{
    switch ( self.aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            self.kiastring = #"zombie_kia_mission_kill";
            break;
        case #"hash_8c089e813083e510":
            self.kiastring = #"zombie_kia_mission_kill_special";
            break;
        case #"hash_7b0e2f2ed84f34":
            self.kiastring = #"zombie_kia_mission_kill_elite";
            break;
        case #"hash_4e47eb6c32f5b165":
            break;
        default:
            assertmsg( "<dev string:x33a>" + self.subclass );
            break;
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xb81f5f2c, Offset: 0x39e8
// Size: 0xdc
function set_eyes( params )
{
    if ( params.skip_eyes )
    {
        return;
    }
    
    switch ( self.subclass )
    {
        case #"hash_1380581f5144c465":
        case #"hash_7e79cb73082c318c":
        case #"hash_99a38be9e88b5244":
        case #"hash_f297af39454fdc7b":
            utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
            break;
        case #"hash_c8364cded587d807":
            utility::function_7c10ea82c1e305b8( "eyes", "purple_eyes" );
            break;
        case #"hash_615dbf7f92e4de09":
            utility::function_7c10ea82c1e305b8( "eyes", "base_purple_eyes" );
            break;
        case #"hash_2465d832b8e3dc23":
        case #"hash_26422b44d1bfbdce":
            utility::function_7c10ea82c1e305b8( "eyes", "purple" );
            break;
    }
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x5254e11b, Offset: 0x3acc
// Size: 0x19d
function function_5f35aa2e209190da( nround, sspecialround, var_4c6516944983d5d8 )
{
    var_ac07512145efb190 = level.players.size;
    round_zombies = zm_round_spawning::get_round_enemies();
    var_bdc9e352a85d81c1 = var_ac07512145efb190 + 4 + int( nround % 2 );
    var_4c6516944983d5d8 = arraycombineunique( round_zombies, var_4c6516944983d5d8 );
    
    if ( var_4c6516944983d5d8.size < var_bdc9e352a85d81c1 )
    {
        return 0.1;
    }
    
    if ( isdefined( sspecialround ) )
    {
        if ( sspecialround.var_c77a2bb3ee36c2c9 )
        {
            spawn_delay_func = level.var_a009ab14ee0d3223.var_883bfe37c0fd93a3[ sspecialround.specialroundname ];
            assert( isdefined( spawn_delay_func ), "<dev string:x35e>" + sspecialround.specialroundname );
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
    
    nround = minint( nround, 60 );
    
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

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x48e10166, Offset: 0x3c72
// Size: 0x1bd
function wipe_zombie( respawn = 0, min_range = 1, max_range = 2 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( respawn )
    {
        zm_cleanup_manager::function_dd62e2042418b7e5();
    }
    
    self endon( #"death" );
    wait randomfloatrange( min_range, max_range );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    zombie_stun::stun_ai( 100 );
    self playsoundevent( %"sndevent_ai_papdeath_start" );
    
    if ( self tagexists( "j_spine4" ) && isdefined( level._effect[ "zombie_wipe" ] ) )
    {
        self.pap_stun_fx = playfxontag( level._effect[ "zombie_wipe" ], self, "j_spine4" );
    }
    
    wait randomfloatrange( min_range, max_range );
    
    if ( isalive( self ) && self tagexists( "j_spine4" ) && isdefined( level._effect[ "zombie_wipe" ] ) && isdefined( level._effect[ "zombie_wipe_blood" ] ) )
    {
        self playsoundevent( %"sndevent_ai_papdeath_explode" );
        self.pap_stun_fx = stopfxontag( level._effect[ "zombie_wipe" ], self, "j_spine4" );
        self.pap_death_fx = playfxontag( level._effect[ "zombie_wipe_blood" ], self, "j_spine4" );
    }
    
    wait 0.25;
    
    if ( self.damageshield )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xbc279fd4, Offset: 0x3e37
// Size: 0x99
function function_44f5bec4abb163f1( var_5cb4f8bc8ebba77 )
{
    level endon( #"zm_game_over" );
    self endon( #"death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.b_in_cleanup )
    {
        return;
    }
    
    self.b_in_cleanup = 1;
    utility::function_32b24db3127bff40( "despawnVfX", "on" );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self.death_source = "zm_cleanup";
        
        if ( self.damageshield )
        {
            utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        ai::function_dd7b3233e5b07718( var_5cb4f8bc8ebba77 );
    }
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0x9cede53e, Offset: 0x3ed8
// Size: 0x4c3
function function_2220168ba514a45f( params, optional_params )
{
    smeansofdeath = params.smeansofdeath ?? params.meansofdeath;
    idamage = params.idamage ?? params.damage;
    eattacker = params.eattacker ?? params.attacker;
    statuseffecttype = zombie_damage::get_status_effect( params );
    
    if ( !isdefined( optional_params ) )
    {
        optional_params = self.optional_params;
    }
    
    check_burn = optional_params.check_burn ?? 1;
    check_napalm = optional_params.check_napalm ?? 1;
    check_ww_melee = optional_params.check_ww_melee ?? 1;
    var_649af4d9b609bf2f = optional_params.var_649af4d9b609bf2f ?? 1;
    check_molotov = optional_params.check_molotov ?? 1;
    check_thermo = optional_params.check_thermo ?? 1;
    check_wildfire = optional_params.check_wildfire ?? 1;
    check_fire_trap = optional_params.check_fire_trap ?? 1;
    var_57af8790a5b1d988 = optional_params.var_57af8790a5b1d988 ?? 1;
    check_dark_flare = optional_params.check_dark_flare ?? 1;
    check_explosive = optional_params.check_explosive ?? 0;
    min_damage_pct = optional_params.min_damage_pct;
    is_bullet_damage = utility::isbulletdamage( smeansofdeath );
    is_melee_damage = class::ismeleeweapon( params.objweapon ) || utility::ismeleedamage( smeansofdeath );
    is_melee_weapon_damage = class::ismeleeweapon( params.objweapon ) && utility::ismeleedamage( smeansofdeath );
    is_weapon_damage = weapontype( params.objweapon ) == "bullet" || weapontype( params.objweapon ) == "projectile";
    params.damagetype = 0;
    
    if ( smeansofdeath == "MOD_IMPACT" && !is_weapon_damage )
    {
        return 0;
    }
    
    if ( is_bullet_damage || is_weapon_damage || is_melee_weapon_damage )
    {
        if ( check_burn && statuseffecttype == "burn" )
        {
            params.damagetype = 2;
            return idamage;
        }
        else if ( check_napalm && eattacker ammo_mod::function_ba9b2ecd18bdbdd8( params.objweapon, "napalmburst" ) )
        {
            params.damagetype = 1;
            return idamage;
        }
    }
    
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( params, check_ww_melee, var_649af4d9b609bf2f ) )
    {
        params.damagetype = 4;
        return self.health;
    }
    
    if ( isdefined( params.objweapon ) )
    {
        if ( check_molotov && ( params.objweapon.basename == "sat_molotov_mp" || params.objweapon.basename == "sat_molotov_zm" ) || check_thermo && params.objweapon.basename == "sat_thermobaric_grenade_zm" )
        {
            params.damagetype = 2;
            return self.health;
        }
        
        if ( check_explosive && isexplosivedamagemod( smeansofdeath ) && idamage > 1 )
        {
            params.damagetype = 3;
            return self.health;
        }
    }
    
    if ( check_wildfire && params.objweapon == level.wiley_fox.objweapon )
    {
        params.damagetype = 2;
        return self.health;
    }
    
    if ( check_dark_flare && smeansofdeath == "MOD_ELEMENTAL_DARK" )
    {
        params.damagetype = 2;
        return self.health;
    }
    
    if ( check_fire_trap && is_bullet_damage && eattacker.var_48fc1f163fceea29 )
    {
        params.damagetype = 2;
        return idamage;
    }
    
    if ( var_57af8790a5b1d988 && utility::isfiredamage( smeansofdeath ) )
    {
        params.damagetype = 2;
        return self.health;
    }
    
    if ( is_melee_damage )
    {
        return int( round( self.maxhealth / 3 ) );
    }
    
    if ( min_damage_pct )
    {
        return int( round( idamage * min_damage_pct ) );
    }
    
    return 0;
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0x12de3e38, Offset: 0x43a4
// Size: 0x5e
function function_4c1f582e9f0b6f0a()
{
    if ( level.var_6781718da4f78d1c.roundnumber <= 10 )
    {
        return 1;
    }
    else if ( level.var_6781718da4f78d1c.roundnumber <= 20 )
    {
        return 2;
    }
    else if ( level.var_6781718da4f78d1c.roundnumber <= 30 )
    {
        return 3;
    }
    
    return 4;
}

// Namespace zm_sat_locust_util
// Params 9
// Checksum 0x34319b0d, Offset: 0x440b
// Size: 0xfb
function function_5174cc6676c87a1( name, zone_name, var_16cc217a9ca51354, var_2d7dd420d0cfb7e3, destination, weapon_obj, weapon_bundle, music_bank, var_a3ec630e9e7644e6 )
{
    assert( !utility::flag( name ), "<dev string:x394>" );
    params = {};
    params.name = name;
    utility::flag_init( name );
    params.zone_name = zone_name;
    params.callbacks = [ #"post_warp":var_2d7dd420d0cfb7e3, #"pre_warp":var_16cc217a9ca51354 ];
    params.weapon_obj = weapon_obj;
    params.weapon_bundle = weapon_bundle;
    params.music_bank = music_bank;
    params.var_a3ec630e9e7644e6 = var_a3ec630e9e7644e6;
    return params;
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x6d94a1fb, Offset: 0x450f
// Size: 0x7f
function lockdown_event( params )
{
    if ( !isdefined( level.lockdown_event ) )
    {
        level.lockdown_event = [];
    }
    
    level.lockdown_event[ params.name ] = params;
    function_a15d2a1e5276b04f( params );
    function_b0f211ca08dee4d8( 0, params );
    lockdown_warp_players( params );
    
    if ( params.music_bank )
    {
        musicbank_utility::function_5aca66c390aa347d( level.players, params.music_bank );
    }
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x1c6f9409, Offset: 0x4596
// Size: 0x94
function function_f994152baff649dc( name )
{
    params = level.lockdown_event[ name ];
    function_b0f211ca08dee4d8( 1, params );
    level callback::remove( "zone_changed", &function_334964c47b36222d, params );
    
    if ( params.music_bank )
    {
        musicbank_utility::function_4f253fd35ec68cbc( level.players, params.music_bank );
    }
    
    level.players[ 0 ] thread nuke::function_abd449c71a89e094( "nuke", level.players[ 0 ], 1, 1, 1 );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x2a0b343c, Offset: 0x4632
// Size: 0x24, Type: bool
function function_2843f52d4913dcda( name )
{
    assert( isdefined( name ) );
    return isdefined( level.lockdown_event[ name ] );
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0xf6bc8d0b, Offset: 0x465f
// Size: 0x100
function private function_a15d2a1e5276b04f( params )
{
    foreach ( player in level.players )
    {
        zone = player zone_manager::get_current_zone( 1, 1 );
        
        if ( !isdefined( zone ) || zone.zone_name != params.zone_name )
        {
            player val::set( "lockdown_warp", "usability", 0 );
        }
        
        if ( player.is_crafting )
        {
            player notify( #"hash_38101be0adc9a0bf" );
        }
    }
    
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() );
    zm_quest::function_823ee6000b6e1947( zm_round_logic::get_rb_round_number() + 1 );
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0x89bdc707, Offset: 0x4767
// Size: 0x293
function function_b0f211ca08dee4d8( enabled, params )
{
    profilestart();
    
    if ( enabled )
    {
        level val::reset( #"lockdown_system", "task_logic_activate" );
        zm_exfil::enable_zm_exfil();
        zm_quest::function_d51b7a8bcd03969a();
        zm_quest::function_765655c7699f9fb7();
        level.var_9075568a1189c7c9 = undefined;
        zm_blackhole_bomb::function_bcfc2c555363a3b5();
        
        if ( isarray( params.zone_name ) )
        {
            zones = params.zone_name;
        }
        else
        {
            zones = [ params.zone_name ];
        }
        
        utility::callsharedfunc( #"aether_shroud", #"hash_e34f2d0d3f7de38f", zones );
        
        if ( !params.var_a3ec630e9e7644e6 )
        {
            zm_round_spawning::pause_round_spawning( 0, "main_quest_pause_spawning" );
        }
        
        foreach ( zone_state in params.zone_states )
        {
            zone_manager::set_zone_enabled( zone_state.zone_name, zone_state.enabled );
            zone_manager::set_zone_active( zone_state.zone_name, zone_state.active );
        }
        
        utility::flag_clear( "lockdown_active" );
    }
    else
    {
        if ( !params.var_a3ec630e9e7644e6 )
        {
            utility::flag_set( "lockdown_active" );
        }
        
        if ( isdefined( level.var_df20dd6f11d11ec8 ) && level.var_4c46644122fad513 )
        {
            if ( level.mastery_achieved )
            {
                level.mastery_achieved = undefined;
            }
            
            if ( !isdefined( level.mastery_rank ) )
            {
                level.mastery_rank = 999;
            }
            
            level.var_7c8d885cdff92388 = 0;
            teddtasks::function_e9e1e5f03716ae0f();
            level thread teddtasks::end_task();
        }
        
        level val::set( #"lockdown_system", "task_logic_activate", 0 );
        zm_exfil::disable_zm_exfil( 0 );
        
        if ( isarray( params.zone_name ) )
        {
            zones = params.zone_name;
        }
        else
        {
            zones = [ params.zone_name ];
        }
        
        zm_quest::function_7d75aa8ca4d23fd();
        zm_quest::function_fe2a9a31ab8fbcab( zones );
        level.var_9075568a1189c7c9 = 1;
        zm_blackhole_bomb::function_2a49f9fa9277a208( [] );
        utility::callsharedfunc( #"aether_shroud", #"hash_1273deb22f1e3ca2", zones );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x119fc3cd, Offset: 0x4a02
// Size: 0x439
function lockdown_warp_players( params )
{
    zm_quest::function_d7216beb89a22329();
    utility::callsharedfunc( #"mutant_injection", #"force_exit_mutant_injection", 1 );
    zm_fasttravel::function_8649f9a98d2d9ce3();
    zm_round_spawning::pause_round_spawning( 1, "main_quest_pause_spawning" );
    level zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 0, 1 );
    
    if ( params.callbacks[ #"pre_warp" ] )
    {
        [[ params.callbacks[ #"pre_warp" ] ]]( params );
    }
    
    s_destination = utility::getstruct( params.zone_name, "script_noteworthy" );
    assert( s_destination, "<dev string:x3ac>" + params.zone_name );
    
    foreach ( player in level.players )
    {
        zone = player zone_manager::get_current_zone( 1, 1 );
        
        if ( !isdefined( zone ) || zone.zone_name != params.zone_name )
        {
            level thread zm_fasttravel::function_cbb08198e7c84adf( s_destination, player );
            level thread function_b4a3a15f2f7b0b8b();
        }
    }
    
    level.var_1a7d5de49b6970b1 = 1;
    
    if ( level.lockdown_warp_count > 0 )
    {
        level utility::waittill_any_timeout( 10, "all_players_teleported" );
        level.lockdown_warp_count = 0;
    }
    
    foreach ( player in level.players )
    {
        player val::reset_all( "lockdown_warp" );
    }
    
    params.zone_states = [];
    
    foreach ( zone_name, zone_struct in level.zone_manager.inited_defs )
    {
        zone_state = { #active:zone_struct.is_active, #enabled:zone_struct.is_enabled, #zone_name:zone_name };
        params.zone_states[ params.zone_states.size ] = zone_state;
        zone_manager::set_zone_enabled( zone_name, 0 );
        zone_manager::set_zone_active( zone_name, 0 );
    }
    
    zone = zone_manager::get_zone_struct( params.zone_name );
    
    foreach ( adjacent_name, var_82733f6af6e5f6d7 in zone.var_c96b1c3cfbbd6aac )
    {
        zone_manager::set_zone_enabled( adjacent_name, 1 );
        zone_manager::set_zone_active( adjacent_name, 1 );
    }
    
    zone_manager::set_zone_enabled( params.zone_name, 1 );
    zone_manager::set_zone_active( params.zone_name, 1 );
    zm_quest::function_d04a18ed4295a8cd();
    
    if ( params.callbacks[ #"post_warp" ] )
    {
        profilestart();
        [[ params.callbacks[ #"post_warp" ] ]]( params );
        profilestop();
    }
    
    level.var_1a7d5de49b6970b1 = 0;
    level callback::add( "zone_changed", &function_334964c47b36222d, params );
    wait 1.5;
    removeallcorpses();
}

// Namespace zm_sat_locust_util
// Params 2, eflags: 0x4
// Checksum 0xba89080f, Offset: 0x4e43
// Size: 0x9b
function private function_334964c47b36222d( params, lockdown_params )
{
    /#
        if ( self isnoclip() || self isufo() )
        {
            return;
        }
    #/
    
    prev_zone = params.previous_zone_struct;
    curr_zone = params.zone_struct;
    
    if ( curr_zone.zone_name != lockdown_params.zone_name )
    {
        s_destination = utility::getstruct( lockdown_params.zone_name, "script_noteworthy" );
        level thread zm_fasttravel::function_cbb08198e7c84adf( s_destination, self );
    }
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x4
// Checksum 0xd09bd77a, Offset: 0x4ee6
// Size: 0x61
function private function_b4a3a15f2f7b0b8b()
{
    if ( !isdefined( level.lockdown_warp_count ) )
    {
        level.lockdown_warp_count = 0;
    }
    
    level.lockdown_warp_count++;
    level utility::waittill_any_timeout( 5, "player_do_fasttravel" );
    val::reset_all( "lockdown_warp" );
    level.lockdown_warp_count--;
    
    if ( level.lockdown_warp_count <= 0 )
    {
        level notify( #"all_players_teleported" );
    }
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0x1e6f46cf, Offset: 0x4f4f
// Size: 0x7b
function get_player_trace( player, ignoreents, contentoverride, var_2073f210b8fb10a3 = 20000 )
{
    starttrace = player getcamerathirdperson() ? player getcamerathirdpersonorigin() : player getvieworigin();
    endtrace = starttrace + anglestoforward( player getplayerangles() ) * var_2073f210b8fb10a3;
    return trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0x139dfa68, Offset: 0x4fd3
// Size: 0xc9
function function_bb18e7f38d178a0e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 1;
    bob_root = utility::spawn_model( "tag_origin", self.origin, self.angles );
    bob_root endon( #"deleted" );
    bob_root endon( #"death" );
    self.root = bob_root;
    utility::scriptable_setparententity( bob_root );
    
    while ( isdefined( bob_root ) )
    {
        bob_root movez( 5, 1.5, 0.5, 0.5 );
        bob_root waittill( #"movedone" );
        bob_root movez( -5, 1.5, 0.5, 0.5 );
        bob_root waittill( #"movedone" );
    }
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0xf8de226f, Offset: 0x50a4
// Size: 0x437
function function_a59b225ef3240980()
{
    player = self;
    player zombie_augments::function_eae5368ab01aaa9f();
    player zombie_augments::function_6dec499dd490fc54();
    player zombie_augments::function_ae34f860566cce0b( 3, 1 );
    weapon_rarity = 4;
    weapon_power_level = 3;
    ammo_mods = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shadowvortex", "lightray" ];
    killstreaks = [ "dawg", "zm_dinj", "toma_strike", "rcxd", "remote_turret", "mangler_cannon", "death_machine_gun" ];
    super_power = utility::array_random( [ "super_aether_shroud", "super_healing_aura", "super_energy_mine", "super_frenzied_guard", "super_tesla_storm", "super_dark_flare", "super_frost_blast", "super_dark_flare" ] );
    thread perkpackage::perkpackage_givedebug( super_power );
    
    if ( laststand::function_7072b516e6cffb7c() == 0 )
    {
        player laststand::function_a2e03a85015b1897();
    }
    
    player zombie_perks::take_all_perks();
    player zombie_perks::give_perk( "specialty_juggernog" );
    player zombie_perks::give_perk( "specialty_quickrevive" );
    player zombie_perks::give_perk( "specialty_speedcola" );
    player zombie_perks::give_perk( "specialty_staminup" );
    player zombie_perks::give_perk( "specialty_elemental_pop" );
    player zombie_perks::give_perk( "specialty_phd_flopper" );
    player zombie_perks::give_perk( "specialty_death_perception" );
    player zombie_perks::give_perk( "specialty_deadshot" );
    player zombie_perks::give_perk( "specialty_m_mod" );
    player zombie_perks::give_perk( "specialty_d_mod" );
    player zombie_perks::give_perk( "specialty_w_mod" );
    player zombie_perks::give_perk( "specialty_vulture_aid" );
    player zm_armor::function_fdbe2cad6d8bb7e7( 3 );
    player armor::setarmorhealth( player.maxarmorhealth );
    player armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
    player currency::add_currency_amount( #"essence", 5000 );
    player killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    var_80823bc77924e389 = [ &zm::function_53cd25a30a3920a, &zm::function_ac57ca8aaf8e8179, &zm::function_a0f3dbdf8009cf91, &zm::function_42d384ca3c76eee3 ];
    var_40994b0d818eb299 = [ &zm::function_84a58c1f69437814, &zm::function_38963ca6e38777be, &zm::function_53b7f32d9beb3c88, &zm::function_13013f80cf2fb2f9 ];
    
    for ( i = 0; i < 2 ; i++ )
    {
        if ( i == 0 )
        {
            var_eb0f9c8b9e70e9fd = utility::array_random( var_80823bc77924e389 );
        }
        else
        {
            var_eb0f9c8b9e70e9fd = utility::array_random( var_40994b0d818eb299 );
        }
        
        player thread [[ var_eb0f9c8b9e70e9fd ]]();
        weapon = player function_cb38c050042391c5();
        player item_weapon::function_40e1cbd0e1f47d1a( weapon, weapon_rarity );
        weapon = player pack_a_punch::pap_weapon( weapon, int( max( weapon_power_level - 1, 0 ) ) );
        player function_692765e1fece04ba( weapon, ammo_mods );
    }
    
    wait 12;
    locust_wws = [ %"hash_5ccd4ffef24f2106", %"hash_613157257e008eff", %"hash_4e5e12b8328b46fd" ];
    
    foreach ( ww in locust_wws )
    {
        s_weapon_bundle = getscriptbundle( ww );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( player.origin + anglestoforward( player.angles ) * 50 );
        spawnoptions.overridepaplvl = int( max( weapon_power_level, 0 ) );
        common_item::function_61c2c0251e742ffd( s_weapon_bundle, undefined, spawnoptions );
    }
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0x4
// Checksum 0x1adb96b9, Offset: 0x54e3
// Size: 0x35
function private function_cb38c050042391c5()
{
    self endon( #"disconnect" );
    currentweapon = self getcurrentweapon();
    
    while ( isnullweapon( currentweapon ) )
    {
        currentweapon = self getcurrentweapon();
        waitframe();
    }
    
    return currentweapon;
}

// Namespace zm_sat_locust_util
// Params 2, eflags: 0x4
// Checksum 0xf888b2f7, Offset: 0x5521
// Size: 0x6a
function private function_692765e1fece04ba( weapon, ammo_mods )
{
    ammomodname = utility::array_random( ammo_mods );
    var_ace202d0c6b9306a = 0;
    
    while ( !isdefined( level.ammo_mods[ ammomodname ] ) )
    {
        ammomodname = utility::array_random( ammo_mods );
        var_ace202d0c6b9306a++;
        
        if ( var_ace202d0c6b9306a > 10 )
        {
            ammomodname = undefined;
        }
    }
    
    ammo_mod::add_ammo_mod_to_weapon( weapon, ammomodname );
}

/#

    // Namespace zm_sat_locust_util
    // Params 3, eflags: 0x4
    // Checksum 0x68ce410, Offset: 0x5593
    // Size: 0x99, Type: dev
    function private timed_error_print( name, type, msg )
    {
        if ( !isdefined( level.var_24f24ba5aa85e70d ) )
        {
            level.var_24f24ba5aa85e70d = [];
        }
        
        time = gettime();
        
        if ( !isdefined( level.var_24f24ba5aa85e70d[ type ] ) || time >= level.var_24f24ba5aa85e70d[ type ] )
        {
            println( "<dev string:x3d5>" + name + "<dev string:x3e2>" + msg );
            level.var_24f24ba5aa85e70d[ type ] = time + int( 250 );
        }
    }

#/

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0x648f8b0f, Offset: 0x5634
// Size: 0x22
function function_63a23256772ea1b9( player )
{
    if ( isdefined( player ) )
    {
        player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    }
}

// Namespace zm_sat_locust_util
// Params 4
// Checksum 0x3aa515bd, Offset: 0x565e
// Size: 0xa1
function log_quest_step( started = 1, step_ref = "<UNKNOWN>", skipped, save_restored )
{
    if ( !getdvarint( @"hash_1db03cff47856580", 1 ) )
    {
        return;
    }
    
    str = started ? "Starting" : "Ending";
    logstring( "[ZM_QUEST] " + str + " " + step_ref + " | skipped: " + skipped + " | save_restored: " + save_restored + " | time: " + gettime() );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0x13d3a580, Offset: 0x5707
// Size: 0xbc
function function_82f9bbbcb47ef102( quest_ref, step_ref = "<UNKNOWN>", str = "<NONE>" )
{
    if ( !getdvarint( @"hash_1db03cff47856580", 1 ) )
    {
        return;
    }
    
    quest = zm_quest::get_quest( quest_ref );
    var_7be076c9078045aa = quest.steps[ quest.var_7be076c9078045aa ].ref;
    logstring( "[ZM_QUEST] quest: " + quest_ref + " | current step: " + var_7be076c9078045aa + " | supposed step: " + step_ref + " | msg: " + str + " | time: " + gettime() );
}

// Namespace zm_sat_locust_util
// Params 8
// Checksum 0x832334d0, Offset: 0x57cb
// Size: 0x155
function register_limited_interact( interact_obj, used_func, exited_func, reset_func, var_43c26323c31a884a, interact_radius, num_uses_override, var_1f5b4ec2c940ce13 )
{
    assert( isdefined( interact_obj ) && !isstruct( interact_obj ) );
    assert( isfunction( used_func ) );
    
    if ( interact_obj isscriptableinstance() )
    {
        interact = interaction::register_scriptable_interact( interact_obj, &limited_interact_used, undefined, undefined, var_43c26323c31a884a );
        interact.ignore_str_id = "limited_interact_" + interact.index;
    }
    else
    {
        interact = interaction::register_interact( interact_obj, interact_radius, &limited_interact_used, var_43c26323c31a884a );
        interact.ignore_str_id = "limited_interact_" + interact getentitynumber();
    }
    
    interact.limited_interact_used_func = used_func;
    interact.var_1a8903f47fe7a470 = exited_func;
    interact.var_6004ca875109fda = reset_func;
    interact.var_d46b85cfdf61574e = 0;
    interact.var_242f731eb34a9a96 = num_uses_override ?? 3;
    interact.var_9307adbe28aaf8b2 = interact.var_242f731eb34a9a96;
    interact.ignore_player_timer = var_1f5b4ec2c940ce13 ?? 60;
    return interact;
}

// Namespace zm_sat_locust_util
// Params 0, eflags: 0xc
// Checksum 0xc977fa82, Offset: 0x5929
// Size: 0x80
function private limited_interact_on_round_start()
{
    self notify( #"hash_440a9bc38c068244" );
    self endon( #"hash_440a9bc38c068244" );
    level endon( #"game_ended" );
    self endon( #"death", #"entitydeleted", #"limited_interact_reset" );
    
    if ( !isdefined( self.var_6004ca875109fda ) )
    {
        return;
    }
    
    level waittill( #"on_round_start" );
    
    if ( self.var_6004ca875109fda )
    {
        self thread [[ self.var_6004ca875109fda ]]();
    }
    
    thread function_1a3e351820ab994c();
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0x4
// Checksum 0xb3409221, Offset: 0x59b1
// Size: 0x5c
function private limited_interact_used( player )
{
    if ( self.var_d46b85cfdf61574e )
    {
        return;
    }
    
    result = self [[ self.limited_interact_used_func ]]( player );
    
    if ( !result )
    {
        return;
    }
    
    thread function_3542e816c5995d8( player );
    player val::set( self.ignore_str_id, "ignore_afk", 1 );
}

// Namespace zm_sat_locust_util
// Params 1
// Checksum 0xb0de6c5, Offset: 0x5a15
// Size: 0x7b
function limited_interact_exited( player )
{
    self notify( #"limited_interact_exit" );
    player val::reset_all( self.ignore_str_id );
    self.var_9307adbe28aaf8b2--;
    
    if ( self.var_9307adbe28aaf8b2 <= 0 )
    {
        self.var_d46b85cfdf61574e = 1;
        thread limited_interact_on_round_start();
        self notify( #"limited_interact_failed" );
    }
    
    if ( self.var_1a8903f47fe7a470 )
    {
        self thread [[ self.var_1a8903f47fe7a470 ]]( player );
    }
}

// Namespace zm_sat_locust_util
// Params 1, eflags: 0xc
// Checksum 0x4472841f, Offset: 0x5a98
// Size: 0xa8
function private function_3542e816c5995d8( player )
{
    self notify( #"hash_8eabbf1eea16c3f7" );
    self endon( #"hash_8eabbf1eea16c3f7" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    self endon( #"limited_interact_exit" );
    str_id = self.ignore_str_id;
    wait_duration = self.ignore_player_timer;
    player val::set( str_id, "ignoreme", 1 );
    
    if ( wait_duration > 0 )
    {
        player utility::waittill_notify_or_timeout( "death", wait_duration );
    }
    
    player val::reset( str_id, "ignoreme" );
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0x661b23af, Offset: 0x5b48
// Size: 0x2a
function function_1a3e351820ab994c()
{
    self notify( #"limited_interact_reset" );
    self.var_d46b85cfdf61574e = 0;
    self.var_9307adbe28aaf8b2 = self.var_242f731eb34a9a96;
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0x720d20b6, Offset: 0x5b7a
// Size: 0x25
function get_any_hero()
{
    var_ebc5d3bc56525846 = get_all_heroes();
    
    if ( var_ebc5d3bc56525846.size > 0 )
    {
        return utility::array_random( var_ebc5d3bc56525846 );
    }
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0xd9e32410, Offset: 0x5ba8
// Size: 0x38
function get_closest_hero( origin, max_radius )
{
    var_ebc5d3bc56525846 = get_all_heroes();
    
    if ( var_ebc5d3bc56525846.size > 0 )
    {
        return function_47c86977a18df38b( var_ebc5d3bc56525846, origin, max_radius );
    }
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0xc05c653e, Offset: 0x5be9
// Size: 0x9b
function get_all_heroes()
{
    valid_heroes = [];
    players = utility::get_alive_players( 0 );
    
    foreach ( player in players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            valid_heroes[ valid_heroes.size ] = player;
        }
    }
    
    return valid_heroes;
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xefa1e3f3, Offset: 0x5c8d
// Size: 0x7b
function function_3587bfca3892d37b( origin, max_radius, prefer_hero )
{
    players = utility::get_alive_players( 0 );
    
    if ( prefer_hero )
    {
        closest_hero = get_closest_hero( origin, max_radius );
        
        if ( closest_hero )
        {
            return closest_hero;
        }
    }
    
    if ( players.size > 0 )
    {
        player = function_47c86977a18df38b( players, origin, max_radius );
        
        if ( player )
        {
            return player;
        }
    }
    
    return utility::array_random( players );
}

// Namespace zm_sat_locust_util
// Params 3
// Checksum 0xd807f83f, Offset: 0x5d11
// Size: 0xb4
function function_1d7335486cb891d8( set_1, set_2, delay )
{
    level endon( #"game_ended" );
    assert( isarray( set_1 ) && set_1.size == 2 );
    assert( isarray( set_2 ) && set_2.size == 2 );
    dialogue_set = utility::cointoss() ? set_1 : set_2;
    
    if ( delay )
    {
        wait delay;
    }
    
    zm_quest::function_8934bb2a9028bdc5();
    utility::flag_set( "twins_dialogue_playing" );
    level dialogue::say_global( dialogue_set[ 0 ] );
    level dialogue::say_global( dialogue_set[ 1 ] );
    utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0xbe91c4bf, Offset: 0x5dcd
// Size: 0x3f
function function_a8b578b47e763d0f( dialogue, delay )
{
    terminal = get_quest_reference( #"pap_terminal" );
    terminal dialogue::say_self( dialogue, undefined, undefined, undefined, delay );
}

// Namespace zm_sat_locust_util
// Params 2
// Checksum 0x61c3f07e, Offset: 0x5e14
// Size: 0x71
function terminal_set_state( display, usable )
{
    self notify( #"hash_427db659450ce28b" );
    self endon( #"hash_427db659450ce28b" );
    waitframe();
    terminal = get_quest_reference( #"pap_terminal" );
    
    if ( isdefined( display ) )
    {
        terminal utility::function_32b24db3127bff40( #"display", display );
    }
    
    if ( isdefined( usable ) )
    {
        terminal setusableenabled( usable );
    }
}

// Namespace zm_sat_locust_util
// Params 0
// Checksum 0xa496257f, Offset: 0x5e8d
// Size: 0xa2
function kill_zombie()
{
    self endon( #"death" );
    zombie = self;
    
    if ( zombie val::get( "ignore_cleanup" ) || zombie.b_ignore_cleanup || zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
    {
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie function_44f5bec4abb163f1( 1 );
        return;
    }
    
    zombie zm_cleanup_manager::function_44f5bec4abb163f1( 1, 1 );
}

