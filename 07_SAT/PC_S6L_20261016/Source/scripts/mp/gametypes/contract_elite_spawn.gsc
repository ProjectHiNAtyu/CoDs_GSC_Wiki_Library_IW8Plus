// scripts\mp\gametypes\contract_elite_spawn.gsc  (hash_4264337d9d42a4d0.gscc) (size: 9186 Bytes / 0x23e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef441f06 (4014219014)
// size ...... 9186 (0x23e2)
// includes .. 16  (offset: 0x226e)
// strings ... 10  (offset: 0x22ee)
// dev strs .. 10  (offset: 0x236a)
// exports ... 31  (offset: 0x141e)
// cseg ...... 0x207 + 0x1217 (0x141e)
// imports ... 81  (offset: 0x18f6)
// animtree1 . 0   (offset: 0x23e2)
// animtree2 . 0   (offset: 0x23e2)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerachievements;

#namespace contract_elite_spawn;

// Namespace contract_elite_spawn
// Params 0, eflags: 0x5
// Checksum 0x5c9d0cc6, Offset: 0x225
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"contract_elite_spawn", undefined, &function_59b64014ec1b06eb, undefined );
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x160aaca5, Offset: 0x246
// Size: 0x9
function private function_59b64014ec1b06eb()
{
    thread main();
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0xf46f743b, Offset: 0x257
// Size: 0x9
function private main()
{
    function_5c4de6fdc4dae18();
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0xdc758d95, Offset: 0x268
// Size: 0x88
function private function_5c4de6fdc4dae18()
{
    level endon( #"game_ended" );
    
    if ( !level.gametypebundle.var_8feab651d46d21e7 || getdvarint( @"hash_44a1f87e1fc68be9", 0 ) == 1 )
    {
        return;
    }
    
    init_dev_gui();
    load_settings();
    callback::add( #"player_connect", &function_5c8953420160bf88 );
    callback::add( #"hash_7633ef4b4aa02c94", &on_common_item_used );
    callback::add( #"hash_92f629d70137a6ae", &function_b0fa1c7c90136d88 );
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0xcd248bc8, Offset: 0x2f8
// Size: 0x149
function private function_b0fa1c7c90136d88( params )
{
    if ( game_utility_mp::privatematch() )
    {
        return 0;
    }
    
    function_95b3cdc28bee4220();
    
    if ( !getdvarint( @"hash_5f2e8961ce6800f0", 0 ) && !contract_elite_is_match_valid() )
    {
        logstring( "contract_elite_spawn::contract_elite_is_match_valid - match is not valid!" );
        return;
    }
    
    if ( !getdvarint( @"hash_5f2e8961ce6800f0", 0 ) && !contract_elite_tablet_any_one_has_cq_token() )
    {
        logstring( "contract_elite_spawn::contract_elite_tablet_any_one_has_CQ_token - no players have CQ token" );
        return;
    }
    
    if ( getdvarint( @"hash_45894c18a845fc10", 1 ) )
    {
        thread function_ab902ae04f184b75();
    }
    
    thread function_493a79009d90daea();
    thread function_150cedbd2c1e5241();
    thread function_62b01275bf94ec15();
    
    for ( i = 0; i < level.contract_elite.settings_ingame.numspawn ; i++ )
    {
        new_tablet = function_bb00165187720990();
        
        if ( !isdefined( new_tablet ) )
        {
            break;
        }
        
        if ( !isdefined( level.contract_elite.tablets ) )
        {
            level.contract_elite.tablets = [];
        }
        
        level.contract_elite.tablets[ level.contract_elite.tablets.size ] = new_tablet;
    }
    
    function_13907679dafbe91b();
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0x56faf8f0, Offset: 0x449
// Size: 0xb6
function private on_common_item_used( params )
{
    itemtype = params.activity.varianttag;
    item = params.scriptable;
    
    if ( itemtype == "elite_ironclad" && item && item.type == level.contract_elite.settings_ingame.contractscriptable )
    {
        function_f290aa8b5ee42705( item );
        
        if ( !getdvarint( @"hash_3139404a28d45266", 0 ) )
        {
            logstring( "contract_elite_spawn::on_common_item_used -> redeeming token for player " + self.name );
            challenges::function_c3bb7e398db26f49();
        }
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0xacd6de4c, Offset: 0x507
// Size: 0x94
function private load_settings()
{
    level.contract_elite = {};
    var_475a65568f5da3be = getdvar( @"hash_214bd32ecd32be2b", "champions_quest_settings_ingame_ironclad" );
    level.contract_elite.settings_ingame = getscriptbundle( hashcat( %"hash_7cbd51496ee82983", var_475a65568f5da3be ) );
    var_1a1b2f807eff3d34 = getdvar( @"hash_90a87023a787b969", "champions_quest_settings_global_ironclad" );
    level.contract_elite.settings_global = getscriptbundle( hashcat( %"hash_3a59f70225b655a9", var_1a1b2f807eff3d34 ) );
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0x1aa9266, Offset: 0x5a3
// Size: 0x78
function private function_5c8953420160bf88( params )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    champions_quest_achievement_id = get_champions_quest_achievement_id();
    
    if ( champions_quest_achievement_id > 0 )
    {
        thread function_55e5ff455785e077( champions_quest_achievement_id );
        
        if ( utility::issharedfuncdefined( #"elite_ironclad", #"hash_47c9d48bf604e470", 0 ) )
        {
            utility::callsharedfunc( #"elite_ironclad", #"hash_47c9d48bf604e470", champions_quest_achievement_id );
        }
        
        playerachievements::getstate( self, champions_quest_achievement_id );
    }
}

// Namespace contract_elite_spawn
// Params 0
// Checksum 0x4aecd195, Offset: 0x623
// Size: 0x4d
function get_champions_quest_achievement_id()
{
    if ( level.gametypebundle.var_8feab651d46d21e7 && level.contract_elite.settings_global )
    {
        return level.contract_elite.settings_global.var_4b4a5ee58e2207a4;
    }
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0x5a7307d3, Offset: 0x679
// Size: 0x5a
function private function_55e5ff455785e077( champions_quest_achievement_id )
{
    self endon( #"disconnect" );
    self waittillmatch( #"challengeprogress", champions_quest_achievement_id );
    challenges::function_cbbd0e7b71fa0d1e( champions_quest_achievement_id );
    
    if ( isdefined( level.contract_elite.tablets ) )
    {
        if ( function_d79a46d20c62e5b0( self ) )
        {
            function_accb0d75162d591a();
        }
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0xd8492bd, Offset: 0x6db
// Size: 0x81, Type: bool
function private contract_elite_tablet_any_one_has_cq_token()
{
    foreach ( player in level.players )
    {
        if ( function_d79a46d20c62e5b0( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x3bdb841b, Offset: 0x765
// Size: 0x1b
function private function_95b3cdc28bee4220()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    waitframe();
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x5bc4de99, Offset: 0x788
// Size: 0xba
function private function_bb00165187720990()
{
    var_aca62897ae41fa94 = getlootspawnpointcount();
    
    if ( var_aca62897ae41fa94 == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_ac4ea5562756ef1d = randomint( var_aca62897ae41fa94 );
    current_index = var_ac4ea5562756ef1d;
    
    while ( true )
    {
        var_12b22f441aa2f95d = getlootspawnpoint( current_index );
        
        if ( function_1c0b8e1906a799ce( var_12b22f441aa2f95d ) )
        {
            break;
        }
        
        current_index = ( current_index + 1 ) % var_aca62897ae41fa94;
        
        if ( current_index == var_ac4ea5562756ef1d )
        {
            assertmsg( "<dev string:x69>" );
            return;
        }
    }
    
    new_tablet = function_7cf49d67d6226b99( var_12b22f441aa2f95d.origin, var_12b22f441aa2f95d.angles );
    disablelootspawnpoint( current_index );
    return new_tablet;
}

// Namespace contract_elite_spawn
// Params 2, eflags: 0x4
// Checksum 0xbaf2c34e, Offset: 0x84b
// Size: 0x166
function private function_7cf49d67d6226b99( origin, angles )
{
    ground_offset = getdvarint( @"hash_6616b12ed778fb40", 16 );
    spawn_origin = origin + ( 0, 0, ground_offset );
    spawn_options = common_item::function_bc5ff2958b71a708( spawn_origin, angles );
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.cleanupdisabled = 1;
    spawn_options.critical = 1;
    new_tablet = common_item::function_61c2c0251e742ffd( common_item::function_80af1e9daffacc7d( level.contract_elite.settings_ingame.contractscriptable ), 1, spawn_options );
    new_tablet setscriptablepartstate( level.contract_elite.settings_ingame.contractscriptable, "visible" );
    new_tablet function_7653c765b6c7b815();
    
    foreach ( player in level.players )
    {
        if ( new_tablet scriptablemaskallowed() )
        {
            new_tablet function_d6a7b7ef13a57f38( player );
        }
    }
    
    return new_tablet;
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0xeca9a6f3, Offset: 0x9ba
// Size: 0xde, Type: bool
function private function_1c0b8e1906a799ce( loot_node )
{
    if ( !function_4d8bf982a880bc4e( loot_node.index ) || loot_node.game_extrainfo == 1 )
    {
        return false;
    }
    
    if ( br_contract_manager::function_d0e283b300baf433( loot_node.origin ) )
    {
        return false;
    }
    
    if ( loot_node.sizeint == 0 )
    {
        return false;
    }
    
    if ( br_gametypes::isfeatureenabled( #"circle" ) && level.contract_elite.settings_ingame.var_f3c59172d6694bed )
    {
        danger_time = br_circle_util::gettimetilldangerforpoint( loot_node.origin );
        circle_end = br_circle::gettimetillcircleclosing( 1 );
        
        if ( circle_end < danger_time )
        {
            return false;
        }
    }
    
    if ( br_bunker_utility::function_5f3fda39a064e862( loot_node.origin ) )
    {
        return false;
    }
    
    return true;
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x7e814013, Offset: 0xaa1
// Size: 0x14d
function private function_62b01275bf94ec15()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "infil_animatic_complete" );
    wait 1.5;
    splash_teams = [];
    
    foreach ( player in level.players )
    {
        if ( function_d79a46d20c62e5b0( player ) )
        {
            if ( !splash_teams[ player.team ] )
            {
                splash_teams[ player.team ] = 1;
                hud_util::showsplashtoteam( player.team, level.contract_elite.settings_ingame.var_56a45f8c829a2b9a, undefined, undefined, undefined, undefined, level.contract_elite.settings_ingame.cqsplashlist );
                level thread br_public::brleaderdialogteam( level.contract_elite.settings_ingame.var_e5f400458296beca, player.team, undefined, 2 );
            }
        }
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x3f08c298, Offset: 0xbf6
// Size: 0x48
function private function_150cedbd2c1e5241()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    for ( circle = 0; true ; circle++ )
    {
        function_d1ef89854157f1c0( circle );
        level waittill( #"br_circle_set" );
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x5ce25a9c, Offset: 0xc46
// Size: 0x47
function private function_493a79009d90daea()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    timer = getdvarint( @"hash_89e38055ad9ac8ec", -1 );
    
    if ( timer != -1 )
    {
        wait timer;
        function_f290aa8b5ee42705();
    }
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0xcbe2a8f7, Offset: 0xc95
// Size: 0x36
function private function_d1ef89854157f1c0( circle_index )
{
    if ( circle_index >= level.contract_elite.settings_ingame.var_4e546608028d0fea )
    {
        function_f290aa8b5ee42705();
    }
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0x10121e77, Offset: 0xcd3
// Size: 0x158
function private function_f290aa8b5ee42705( var_9977ac7b415a5042 )
{
    if ( !( isdefined( level.contract_elite ) && isdefined( level.contract_elite.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.contract_elite.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        if ( var_9977ac7b415a5042 != tablet )
        {
            tablet function_7653c765b6c7b815();
            
            foreach ( player in level.players )
            {
                if ( tablet scriptablemaskallowed() )
                {
                    tablet function_d6a7b7ef13a57f38( player );
                }
            }
        }
    }
    
    level.contract_elite.tablets = [];
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x5771317e, Offset: 0xe33
// Size: 0xdc
function private function_ac95e58167a2b784()
{
    player = self;
    
    if ( !( isdefined( level.contract_elite ) && isdefined( level.contract_elite.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.contract_elite.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        tablet disablescriptableplayeruse( player );
        
        if ( tablet scriptablemaskallowed() && !tablet function_50b79f4d4032e234( player ) )
        {
            tablet function_d6a7b7ef13a57f38( player );
        }
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x59b5e438, Offset: 0xf17
// Size: 0xb8
function private function_13907679dafbe91b()
{
    if ( !( isdefined( level.contract_elite ) && isdefined( level.contract_elite.tablets ) ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( function_d79a46d20c62e5b0( player ) )
        {
            player function_accb0d75162d591a();
            continue;
        }
        
        player function_ac95e58167a2b784();
    }
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x3c401deb, Offset: 0xfd7
// Size: 0xd0
function private function_accb0d75162d591a()
{
    player = self;
    
    if ( !( isdefined( level.contract_elite ) && isdefined( level.contract_elite.tablets ) ) )
    {
        return;
    }
    
    foreach ( tablet in level.contract_elite.tablets )
    {
        if ( !isdefined( tablet ) )
        {
            continue;
        }
        
        tablet enablescriptableplayeruse( player );
        
        if ( tablet scriptablemaskallowed() )
        {
            tablet function_6113853a877d5460( player );
        }
    }
}

// Namespace contract_elite_spawn
// Params 1, eflags: 0x4
// Checksum 0x6a375e75, Offset: 0x10af
// Size: 0x3a, Type: bool
function private function_d79a46d20c62e5b0( player )
{
    return player.var_82a2163fbb84a684 && player.var_82a2163fbb84a684 > 0 || getdvarint( @"hash_3189c115e658ac69", 0 );
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0x205fe0be, Offset: 0x10f2
// Size: 0xa1, Type: bool
function private contract_elite_is_match_valid()
{
    assert( isdefined( level.totalplayers ) );
    
    if ( level.contract_elite.settings_ingame.var_91b380f71234a20d > 0 )
    {
        percentage = level.contract_elite.settings_ingame.var_91b380f71234a20d / 100;
        var_ee7e4762f16f61fd = getdvarint( @"party_maxplayers" );
        var_77df3ed83db655c0 = var_ee7e4762f16f61fd * percentage;
        
        if ( level.totalplayers < var_77df3ed83db655c0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace contract_elite_spawn
// Params 0
// Checksum 0x312c6b7b, Offset: 0x119c
// Size: 0x22
function function_ab902ae04f184b75()
{
    level endon( #"game_ended" );
    level waittill( #"ddos_alert" );
    function_f290aa8b5ee42705();
}

// Namespace contract_elite_spawn
// Params 0, eflags: 0x4
// Checksum 0xe5b126a5, Offset: 0x11c6
// Size: 0x7e
function private init_dev_gui()
{
    /#
        var_2ba69d88abe636ca = "<dev string:xaf>";
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca + "<dev string:xce>" );
        devgui::add_devgui_func( "<dev string:xd8>", "<dev string:xf1>", &function_d4f462c9d3cd78be );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( var_2ba69d88abe636ca );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x119>", &debug_spawn_contract );
        devgui::add_devgui_func( "<dev string:x128>", "<dev string:x144>", &function_fcca1010ca11d5e8 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace contract_elite_spawn
    // Params 0, eflags: 0x4
    // Checksum 0x3652c662, Offset: 0x124c
    // Size: 0x69, Type: dev
    function private debug_spawn_contract()
    {
        new_tablet = function_7cf49d67d6226b99( level.player.origin, ( 0, 0, 0 ) );
        level.contract_elite.tablets[ level.contract_elite.tablets.size ] = new_tablet;
        function_13907679dafbe91b();
    }

    // Namespace contract_elite_spawn
    // Params 0, eflags: 0x4
    // Checksum 0xc8a4d890, Offset: 0x12bd
    // Size: 0x10f, Type: dev
    function private function_fcca1010ca11d5e8()
    {
        if ( isdefined( level.contract_elite.tablets ) && level.contract_elite.tablets.size > 0 )
        {
            if ( !isdefined( level.elite_ironclad.var_4521333d3db1a377 ) )
            {
                level.elite_ironclad.var_4521333d3db1a377 = 0;
            }
            
            tablet = level.contract_elite.tablets[ level.elite_ironclad.var_4521333d3db1a377 ];
            level.player setorigin( tablet.origin + ( 0, 0, 50 ) );
            level.elite_ironclad.var_4521333d3db1a377++;
            
            if ( level.elite_ironclad.var_4521333d3db1a377 >= level.contract_elite.tablets.size )
            {
                level.elite_ironclad.var_4521333d3db1a377 = 0;
            }
        }
    }

    // Namespace contract_elite_spawn
    // Params 0
    // Checksum 0xaa55383a, Offset: 0x13d4
    // Size: 0x4a, Type: dev
    function function_d4f462c9d3cd78be()
    {
        hud_util::showsplashtoall( level.contract_elite.settings_ingame.var_56a45f8c829a2b9a, undefined, undefined, undefined, undefined, level.contract_elite.settings_ingame.cqsplashlist );
    }

#/
