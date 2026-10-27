// scripts\mp\dmz\dmz_bosses_core.gsc  (hash_523335ca60fe60b1.gscc) (size: 22220 Bytes / 0x56cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7b4055e (4155770206)
// size ...... 22220 (0x56cc)
// includes .. 25  (offset: 0x5388)
// strings ... 36  (offset: 0x5450)
// dev strs .. 10  (offset: 0x5654)
// exports ... 48  (offset: 0x3b80)
// cseg ...... 0x393 + 0x37ed (0x3b80)
// imports ... 136 (offset: 0x4300)
// animtree1 . 0   (offset: 0x56cc)
// animtree2 . 0   (offset: 0x56cc)
#using script_5c221b3ec14e0ff7;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_loot;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\dmz_poi;
#using scripts\mp\dmz\mission_manager;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace dmz_bosses_core;

// Namespace dmz_bosses_core
// Params 0
// Checksum 0x153e5677, Offset: 0x3b1
// Size: 0x3cc
function initbosses()
{
    level endon( #"game_ended" );
    var_7d6d21962fc1b2ee = game_utility_mp::function_4b7180ed8c2e9742( "dmzbosssettings" );
    
    if ( !isdefined( var_7d6d21962fc1b2ee ) || getdvarint( @"scr_disable_dmz_bosses", 0 ) )
    {
        return;
    }
    
    level.bossboardmissions = [];
    level.var_7d6d21962fc1b2ee = var_7d6d21962fc1b2ee;
    level.var_38d515527e26ebd = getdvarint( @"hash_5838a46670c2521f", var_7d6d21962fc1b2ee.revealdist );
    level.var_fe7fd84db447fe0b = getdvarint( @"hash_1f7fc5197974a94f", var_7d6d21962fc1b2ee.var_8bbad51ab6034c47 );
    level.var_3c1f70b9e3e0dc10 = getdvarint( @"hash_ead6fbe92bc47426", var_7d6d21962fc1b2ee.var_3e0db48c91af28ce );
    level.var_e05429687d6711be = getdvarint( @"hash_31f0a801b6bc5215", var_7d6d21962fc1b2ee.ddosenabled ) == 1;
    level.var_93dd7b0edf0420df = getdvarint( @"hash_74e1d62fce88a3f6", var_7d6d21962fc1b2ee.agentcount );
    level.var_40b7226cf4e6a874 = getdvarint( @"hash_44caeeb45e9f6d0d", var_7d6d21962fc1b2ee.var_29e6c88486fed509 );
    level.var_7d6d21962fc1b2ee.var_8d9645b9c40b2476 = [];
    utility::registersharedfunc( #"bosses", #"hash_d9367d6b9c423d16", &function_691b5ff117b9dc61 );
    
    foreach ( bundlename in var_7d6d21962fc1b2ee.bossscriptbundles )
    {
        bundle = getscriptbundle( bundlename.bossscriptbundle );
        
        if ( !isdefined( bundle.bossref ) )
        {
            assertmsg( "<dev string:x24>" );
            continue;
        }
        
        if ( bundle.revealsplash )
        {
            hud_message::function_b4446495b4d8f194( hashcat( #"hash_67c74d0df00a1b35", bundle.bossref ), bundle.revealsplash );
        }
        
        if ( bundle.killsplash )
        {
            hud_message::function_b4446495b4d8f194( hashcat( #"hash_906c11af4d0ba07a", bundle.bossref ), bundle.killsplash );
        }
        
        level.var_7d6d21962fc1b2ee.var_8d9645b9c40b2476[ bundle.bossref ] = bundle;
    }
    
    foreach ( key in var_7d6d21962fc1b2ee.ltkeys )
    {
        key.origin = ( key.x, key.y, key.z );
        key.x = undefined;
        key.y = undefined;
        key.z = undefined;
    }
    
    utility::flag_set( "dmz_bosses_bundled_processed" );
    
    /#
        level thread function_e5574b5c81b54635();
        level thread function_e9812a02bc402039();
        thread dev::devcommandwatcher( @"dmz_boss", &function_20d8a6e66495ddf2 );
    #/
    
    while ( !isdefined( level.aibudgets ) )
    {
        waitframe();
    }
    
    assert( isdefined( level.bosses ), "<dev string:x50>" );
    ai_mp_controller::function_7f833bacb64445a6();
    level thread function_692b3e9f4f52f8bc();
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    level thread function_3198772c1ab7cf68( var_7d6d21962fc1b2ee );
}

// Namespace dmz_bosses_core
// Params 1, eflags: 0x4
// Checksum 0xdeae9317, Offset: 0x785
// Size: 0x341
function private function_3198772c1ab7cf68( var_7d6d21962fc1b2ee )
{
    level endon( #"game_ended" );
    
    foreach ( index, bossbundle in var_7d6d21962fc1b2ee.var_c1dc2535d164c317 )
    {
        bossref = getscriptbundlefieldvalue( bossbundle.bossscriptbundle, #"bossref" );
        boss = level.bosses[ bossref ];
        
        if ( !boss && bossref == "lt_kreuger" )
        {
            boss = level.bosses[ "lt_kreuger_cqb" ];
        }
        
        if ( boss )
        {
            boss.var_f118922d6f1d1e00 = index;
        }
    }
    
    utility::flag_wait( "missions_initialized" );
    
    foreach ( player in level.players )
    {
        player function_c2d16d899cf50594();
    }
    
    callback::add( #"player_spawned", &function_c2d16d899cf50594 );
    var_e31446af535fef72 = 0;
    
    if ( !var_7d6d21962fc1b2ee.automaticspawning )
    {
        return;
    }
    
    bosskeys = arrayrandomize( getarraykeys( level.bosses ) );
    
    foreach ( key in bosskeys )
    {
        boss = level.bosses[ key ];
        
        if ( !isdefined( boss.bundle ) && isdefined( level.var_7d6d21962fc1b2ee.var_8d9645b9c40b2476[ boss.name ] ) )
        {
            boss.bundle = level.var_7d6d21962fc1b2ee.var_8d9645b9c40b2476[ boss.name ];
        }
        
        if ( boss.disabled || boss.prespawned )
        {
            continue;
        }
        
        boss.prespawned = 1;
        
        if ( boss.bundle.islieutenant && var_e31446af535fef72 >= level.var_40b7226cf4e6a874 )
        {
            continue;
        }
        
        if ( !boss.bundle.var_7cede2fb1066882d )
        {
            continue;
        }
        
        level thread spawnboss( boss.name );
        
        if ( boss.bundle.islieutenant )
        {
            var_e31446af535fef72 += 1;
        }
    }
}

// Namespace dmz_bosses_core
// Params 1, eflags: 0x4
// Checksum 0x30d5a1c0, Offset: 0xace
// Size: 0x200
function private function_c2d16d899cf50594( params )
{
    if ( level.var_f665377328b10a5c )
    {
        return;
    }
    
    player = self;
    index = player function_292879d726c8535f();
    
    if ( !isdefined( index ) )
    {
        logstring( "Boss Board Debug: " + player.name + " did not select a boss to spawn" );
        return;
    }
    
    index -= 1;
    
    if ( index < 0 )
    {
        logstring( "Boss Board Debug: " + player.name + " selected a boss to spawn with index = 0" );
        return;
    }
    
    bossref = getscriptbundlefieldvalue( level.var_7d6d21962fc1b2ee.var_c1dc2535d164c317[ index ].bossscriptbundle, #"bossref" );
    bossdetails = level.bosses[ bossref ];
    
    if ( !bossdetails && bossref == "lt_kreuger" )
    {
        bossdetails = level.bosses[ "lt_kreuger_cqb" ];
    }
    
    if ( !bossdetails )
    {
        logstring( "Boss Board Debug: " + player.name + " selected a boss that we couldn't find with index: " + index );
        return;
    }
    
    if ( !bossdetails.prespawned )
    {
        logstring( "bossDetails Board Debug: " + player.name + " selected a bossDetails that we're spawning: " + bossdetails.name );
        level thread spawnboss( bossdetails.name, undefined, undefined, { #var_8d58fe6827176d1b:1 } );
        bossdetails.prespawned = 1;
    }
    else
    {
        logstring( "bossDetails Board Debug: " + player.name + " selected a bossDetails that was already selected: " + bossdetails.name );
    }
    
    instance = bossdetails.instances[ 0 ];
    
    if ( !instance )
    {
        logstring( "bossDetails Board Debug: " + player.name + " selected a bossDetails that didn't have a valid instance: " + bossdetails.name );
        return;
    }
    
    level thread function_a646935fc7cc5b37( player, instance, bossdetails );
}

// Namespace dmz_bosses_core
// Params 3, eflags: 0x4
// Checksum 0xcc06c0a9, Offset: 0xcd6
// Size: 0x253
function private function_a646935fc7cc5b37( player, instance, bossdetails )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !bossdetails.bundle.var_7086ac6a2b0dfb33 )
    {
        assertmsg( "<dev string:x75>" + instance.name );
        return;
    }
    
    team = player.team;
    utility::flag_wait( instance.name + "_spawned" );
    
    if ( !instance.boss && !instance.combattrigger )
    {
        return;
    }
    
    logstring( "Boss Board Debug: " + player.name + " is having a spawned boss revealed to them: " + bossdetails.name );
    
    if ( instance.revealedto.size && arraycontains( instance.revealedto, player ) )
    {
        return;
    }
    
    missionloc = instance.boss.origin ?? instance.combattrigger.origin ?? instance.origin;
    
    if ( level.bossboardmissions[ bossdetails.bundle.var_7086ac6a2b0dfb33 ] )
    {
        return;
    }
    
    level.bossboardmissions[ bossdetails.bundle.var_7086ac6a2b0dfb33 ] = 1;
    mission = mission_manager::registermission( bossdetails.bundle.var_7086ac6a2b0dfb33, #"hash_84bb74894ffbb189", missionloc, instance.boss );
    missiontype = bossdetails.bundle.islieutenant ? "KillLT" : "KillBoss";
    step = mission_manager::function_ff8ddfb3fb979ed( mission, missiontype );
    activity_instance_common::function_46135a69bddfec2c( step );
    callback = mission_manager::function_4dfa8fd06db3477b( step, #"hash_fa93f6034d3ecee" );
    
    if ( callback )
    {
        [[ callback ]]( step, instance.boss, instance );
    }
    
    mission_manager::function_eae597dddd10306f( mission, team );
}

// Namespace dmz_bosses_core
// Params 0, eflags: 0x4
// Checksum 0x8fbed502, Offset: 0xf31
// Size: 0x57
function private function_292879d726c8535f()
{
    /#
        if ( !level.var_b1c84c4d00429b95 && getdvarint( @"hash_5bb189e151d2110c", 0 ) > 0 )
        {
            if ( getdvarint( @"hash_b76c26805007654d", 0 ) )
            {
                level.var_b1c84c4d00429b95 = 1;
            }
            
            return getdvarint( @"hash_5bb189e151d2110c", 0 );
        }
    #/
    
    return common_instance_inventory::function_189efb9dddbaac9c();
}

// Namespace dmz_bosses_core
// Params 0
// Checksum 0x75850a84, Offset: 0xf91
// Size: 0x17
function function_692b3e9f4f52f8bc()
{
    dmz_poi::function_473b30c6018b7b8f( "bossArea", level.var_93dd7b0edf0420df );
}

// Namespace dmz_bosses_core
// Params 4
// Checksum 0xc44366d0, Offset: 0xfb0
// Size: 0xc4
function spawnboss( bossname, instanceoverride, var_f56ce167602b6e19, params )
{
    boss = level.bosses[ bossname ];
    
    if ( !isdefined( boss.spawnfunc ) )
    {
        return;
    }
    
    instance = instanceoverride ?? function_69c16ee974a58fcb( bossname );
    instance.spawnparams = params;
    [[ boss.spawnfunc ]]( instance );
    utility::flag_set( bossname + "_spawned" );
    instance.spawnparams = undefined;
    
    if ( instance.bundle.missionasset )
    {
        instance thread function_b50e5f31ea171a17( var_f56ce167602b6e19, params );
    }
    
    return instance;
}

// Namespace dmz_bosses_core
// Params 2, eflags: 0xc
// Checksum 0x7770976f, Offset: 0x107d
// Size: 0x21d
function private function_b50e5f31ea171a17( var_f56ce167602b6e19, params )
{
    self notify( #"hash_8d693a96180eb7ef" );
    self endon( #"hash_8d693a96180eb7ef" );
    level endon( #"game_ended" );
    instance = self;
    missionloc = instance.boss.origin ?? instance.origin;
    
    while ( !missionloc )
    {
        missionloc = instance.boss.origin ?? instance.origin;
        waitframe();
    }
    
    instance.origin = missionloc;
    utility::flag_wait( "missions_initialized" );
    mission = mission_manager::registermission( instance.bundle.missionasset, #"hash_84bb74894ffbb189", missionloc, instance.boss );
    
    if ( !mission )
    {
        return;
    }
    
    bossdetails = level.bosses[ instance.name ];
    missiontype = bossdetails.bundle.islieutenant ? "KillLT" : "KillBoss";
    step = mission_manager::function_ff8ddfb3fb979ed( mission, missiontype );
    activity_instance_common::function_46135a69bddfec2c( step );
    callback = mission_manager::function_4dfa8fd06db3477b( step, #"hash_fa93f6034d3ecee" );
    
    if ( callback )
    {
        thread [[ callback ]]( step, instance.boss, instance );
    }
    
    if ( var_f56ce167602b6e19 && var_f56ce167602b6e19.size > 0 )
    {
        foreach ( player in var_f56ce167602b6e19 )
        {
            function_f78af8526b3b6c1( player, 1, params );
        }
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x2b9c3d37, Offset: 0x12a2
// Size: 0x20
function function_25e8f8cb05725648( bossname )
{
    return hashcat( @"scr_", bossname, "_disabled" );
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x22b0f527, Offset: 0x12cb
// Size: 0x20
function function_a25a138aee38b449( bossname )
{
    return hashcat( @"scr_", bossname, "_enabled" );
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xf2128d90, Offset: 0x12f4
// Size: 0x139
function registerboss( detailsstruct )
{
    var_7d6d21962fc1b2ee = game_utility_mp::function_4b7180ed8c2e9742( "dmzbosssettings" );
    
    if ( !isdefined( var_7d6d21962fc1b2ee ) )
    {
        return;
    }
    
    if ( !isdefined( level.bosses ) )
    {
        level.bosses = [];
    }
    
    level.bosses[ detailsstruct.name ] = detailsstruct;
    level.bosses[ detailsstruct.name ].instances = [];
    
    if ( getdvarint( function_25e8f8cb05725648( detailsstruct.name ), 0 ) == 1 )
    {
        detailsstruct.disabled = 1;
    }
    
    if ( isdefined( level.var_91e8dc6a0e5a3536 ) && !arraycontains( level.var_91e8dc6a0e5a3536, detailsstruct.name ) )
    {
        detailsstruct.disabled = 1;
    }
    
    if ( getdvarint( function_a25a138aee38b449( detailsstruct.name ), 0 ) == 1 )
    {
        detailsstruct.disabled = 0;
    }
    
    if ( isdefined( detailsstruct.initfunc ) )
    {
        [[ detailsstruct.initfunc ]]( detailsstruct );
        
        /#
            init_dev_gui( detailsstruct.name );
        #/
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x61165bb5, Offset: 0x1435
// Size: 0x2e
function deregisterboss( name )
{
    if ( !isdefined( level.bosses ) )
    {
        level.bosses = [];
    }
    
    level.bosses[ name ] = undefined;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x3a8062da, Offset: 0x146b
// Size: 0x18
function function_2923085da9d763c3( name )
{
    return level.bosses[ name ];
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0x40cdae38, Offset: 0x148c
// Size: 0x2d
function function_91e0bb6d639bfb50( name, index )
{
    return level.bosses[ name ].instances[ index ];
}

// Namespace dmz_bosses_core
// Params 1, eflags: 0x4
// Checksum 0x8563e77d, Offset: 0x14c2
// Size: 0x65
function private function_bf705c48c238a3de( name )
{
    if ( !level.bosses[ name ] )
    {
        return;
    }
    
    if ( !isdefined( level.bosses[ name ].kills ) )
    {
        level.bosses[ name ].kills = 0;
    }
    
    level.bosses[ name ].kills++;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x7f10a9da, Offset: 0x152f
// Size: 0x4f
function function_ad7ad46659e96699( name )
{
    if ( !level.bosses[ name ] || !level.bosses[ name ].kills )
    {
        return 0;
    }
    
    return level.bosses[ name ].kills;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xcbbeffea, Offset: 0x1587
// Size: 0x108
function function_69c16ee974a58fcb( name )
{
    instance = spawnstruct();
    instance.revealedto = [];
    instance.var_630f0fdf067f10a7 = [];
    instance.name = name;
    instance.spawnloc = utility::array_random( level.bosses[ name ].spawnlocs );
    instance.bundle = function_f12aa382ff8a8d3( name );
    instance.index = level.bosses[ name ].instances.size;
    level.bosses[ name ].instances[ instance.index ] = instance;
    
    if ( !( instance.bundle.var_72ee547df0aab1dc == 0 ) && !instance.bundle.missionasset )
    {
        instance thread function_4b15df28151b5b89();
    }
    
    return instance;
}

// Namespace dmz_bosses_core
// Params 4
// Checksum 0xeb37b4c9, Offset: 0x1698
// Size: 0x17a
function function_3d8cd01359eaae43( origin, icon, spawnparams, var_1e1ecace3b3c2a63 )
{
    self.curorigin = origin;
    self.offset3d = ( 0, 0, 50 );
    gameobjects::requestid( 1, 1, undefined, 1, 1 );
    
    if ( isdefined( icon ) )
    {
        objidpoolmanager::update_objective_icon( self.objidnum, icon );
    }
    
    if ( isdefined( self.objidnum ) && getdvarint( @"hash_cc7d161403f9a017", 1 ) && !spawnparams.var_8d58fe6827176d1b )
    {
        var_ee7bc8b53cebd37e = undefined;
        
        if ( !isdefined( var_1e1ecace3b3c2a63 ) )
        {
            var_1e1ecace3b3c2a63 = getdvarint( @"hash_5cdea3a4c5246c8f", level.var_38d515527e26ebd );
            var_ee7bc8b53cebd37e = getdvarint( @"hash_a134915451de90c6", level.var_38d515527e26ebd ) * 1.05;
        }
        else
        {
            var_ee7bc8b53cebd37e = var_1e1ecace3b3c2a63 * 1.05;
        }
        
        objidpoolmanager::function_de3fb937d4f45f38( self.objidnum, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
        function_24edb8a97f6832f0( self.objidnum, 1 );
        function_d1fb910ef06fd658( self.objidnum, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
    }
    
    objective_setbackground( self.objidnum, 1 );
    objidpoolmanager::update_objective_setzoffset( self.objidnum, 100 );
    
    if ( getdvarint( @"hash_5d815786c431535b", 0 ) )
    {
        objective_removeallfrommask( self.objidnum );
        objective_showtoplayersinmask( self.objidnum );
    }
}

// Namespace dmz_bosses_core
// Params 3
// Checksum 0x1a8caef1, Offset: 0x181a
// Size: 0x37c
function function_2fc885345d040baf( name, var_4d3a4e313aecf79c, instance )
{
    if ( isdefined( instance ) )
    {
        instance.boss = self;
    }
    
    self.var_4f8a92ebabf37ee = 0;
    self.var_2517193969180a2e = var_4d3a4e313aecf79c;
    self.battlechatterallowed = 0;
    self.bossname = name;
    self.var_fcaa3cd09f6faedd = 1;
    self.instance = instance;
    self.var_469e4ea30ce637a8 = 1;
    self.tier = 3;
    self.var_338710668f9527b7 = 0;
    self.baseaccuracy = instance.bundle.baseaccuracy;
    self.accuracydistscaleoverride = 0.2;
    self.var_b2a3949fb18f37ac = 0;
    self.gameskillmisstimedistancefactoroverride = 0;
    self.gameskillmisstimefrombehindoverride = 0.05;
    self.aggressivemode = 1;
    self.var_8d6f2c13572743d6 = 1;
    self setsightconfigtemplateoverride( %"hash_29e6bc68fd5d47bc" );
    self function_1b0b5d1c994e3a69();
    
    if ( instance.bundle.var_ef5c1d36f4119efa )
    {
        foreach ( struct in instance.bundle.var_ef5c1d36f4119efa )
        {
            ai_loot::function_452f7cba22550779( instance.boss, struct.item, struct.count, struct.var_d291ab4f1928dffa );
        }
    }
    
    if ( instance.bundle.lootlist && instance.bundle.lootlistcount )
    {
        foreach ( item in common_item::items_selectfromlist( instance.bundle.lootlist, instance.bundle.lootlistcount ) )
        {
            ai_loot::function_452f7cba22550779( instance.boss, item );
        }
    }
    
    if ( instance.bundle.var_cb8f18d7760cf882 )
    {
        closestkey = sortbydistance( level.var_7d6d21962fc1b2ee.ltkeys, instance.boss.origin )[ 0 ];
        ai_loot::function_452f7cba22550779( instance.boss, closestkey.item );
        
        /#
            if ( false )
            {
                thread utility::draw_line_for_time( closestkey.origin, instance.boss.origin, randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ), 100000 );
            }
        #/
    }
    
    /#
        thread function_db57f0351c671a77();
    #/
    
    thread function_28402a8ce3e5a94c( name, instance );
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0x60fdf247, Offset: 0x1b9e
// Size: 0x1da
function function_28402a8ce3e5a94c( name, instance )
{
    self endon( #"boss_despawn" );
    self waittill( #"death", killer );
    
    if ( isdefined( killer ) && isdefined( killer.vehicletype ) )
    {
        if ( isdefined( killer.owner ) )
        {
            killer = killer.owner;
        }
    }
    
    level notify( name );
    
    if ( isdefined( instance ) )
    {
        instance notify( #"boss_death" );
        instance.killed = 1;
        instance.killer = killer;
        instance.boss = undefined;
    }
    
    details = function_2923085da9d763c3( name );
    
    if ( details.deathfunc )
    {
        self [[ details.deathfunc ]]( name, killer );
    }
    
    if ( isdefined( killer ) && isdefined( killer.team ) )
    {
        players = teams::getteamdata( killer.team, "players" );
        
        foreach ( player in players )
        {
            if ( !isdefined( player.var_a70c1ad2ccf56b6d ) )
            {
                player.var_a70c1ad2ccf56b6d = 0;
            }
            
            player.var_a70c1ad2ccf56b6d++;
        }
    }
    
    callback::callback( #"boss_killed", { #killer:killer, #instance:instance, #name:name } );
    function_bf705c48c238a3de( name );
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xb5eb092a, Offset: 0x1d80
// Size: 0x130
function function_691b5ff117b9dc61( var_3ee9b1d1d122bdaf )
{
    foreach ( boss in level.bosses )
    {
        if ( !boss.bundle.var_ef5c1d36f4119efa.size )
        {
            continue;
        }
        
        foreach ( lootitem in boss.bundle.var_ef5c1d36f4119efa )
        {
            if ( lootitem.item == var_3ee9b1d1d122bdaf )
            {
                return boss.var_f118922d6f1d1e00;
            }
        }
    }
}

// Namespace dmz_bosses_core
// Params 3
// Checksum 0x694cda09, Offset: 0x1eb8
// Size: 0x115
function function_3a55193e2c612187( bossa, bossb, origin )
{
    if ( bossa.boss )
    {
        origina = bossa.boss.origin;
    }
    else if ( bossa.combattrigger )
    {
        origina = bossa.combattrigger.origin;
    }
    else
    {
        origina = bossa.spawnloc;
    }
    
    if ( bossb.boss )
    {
        originb = bossb.boss.origin;
    }
    else if ( bossb.combattrigger )
    {
        originb = bossb.combattrigger.origin;
    }
    else
    {
        originb = bossb.spawnloc;
    }
    
    if ( !isvector( originb ) || !isvector( origina ) )
    {
        return isvector( origina );
    }
    
    return distance( origin, origina ) < distance( origin, originb );
}

// Namespace dmz_bosses_core
// Params 3
// Checksum 0xd4220761, Offset: 0x1fd6
// Size: 0xcd
function function_a54cd3a108e081c5( team, splash, origin )
{
    players = teams::getteamdata( team, "players" );
    poiname = dmz_poi::dmzpoi_findpoioriginisin( origin );
    
    foreach ( player in players )
    {
        thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", splash, players, poiname );
    }
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0xe31d40a3, Offset: 0x20ab
// Size: 0x5a, Type: bool
function function_9764139090a2762d( bosstype, instance )
{
    if ( isdefined( instance ) && isdefined( bosstype.revealfunc ) )
    {
        if ( instance.boss.origin )
        {
            return true;
        }
        else if ( instance.spawnloc )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dmz_bosses_core
// Params 4
// Checksum 0x78b87fa7, Offset: 0x210e
// Size: 0x1b0
function function_b392213c0074ce9c( player, showicon = 1, origin, params )
{
    availablebosses = [];
    
    foreach ( boss in level.bosses )
    {
        foreach ( instance in boss.instances )
        {
            if ( function_9764139090a2762d( boss, instance ) )
            {
                availablebosses[ availablebosses.size ] = instance;
            }
        }
    }
    
    bosses = arraysort( availablebosses, origin, &function_3a55193e2c612187 );
    
    foreach ( boss in bosses )
    {
        boss function_f78af8526b3b6c1( player, showicon, params );
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xab363a0f, Offset: 0x22c6
// Size: 0x2e6
function function_4b15df28151b5b89( ignorelos )
{
    self endon( #"boss_death" );
    contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self.boss ) )
        {
            continue;
        }
        
        multi = 1;
        
        if ( isdefined( self.boss.revealmulti ) )
        {
            multi = self.boss.revealmulti;
        }
        
        players = player_utility::script_getplayersinradius( self.boss.origin, level.var_38d515527e26ebd * multi );
        
        foreach ( player in players )
        {
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( isdefined( player.perks[ "specialty_trait_commander" ] ) )
            {
                ignorelos = 1;
            }
            
            if ( ignorelos || trace::ray_trace_passed( player.origin, self.boss.origin, self.boss.ignorelist, contentsoverride ) )
            {
                function_f78af8526b3b6c1( player, 0 );
            }
        }
        
        var_d2de15ff75d946e4 = utility::callsharedfunc( #"signal_vehicle", #"hash_692035c930e6d76b", self.boss.origin );
        
        if ( var_d2de15ff75d946e4.size > 0 )
        {
            foreach ( var_5affa71f5fb2a1ff in var_d2de15ff75d946e4 )
            {
                var_e762fe9c8dc088b = var_5affa71f5fb2a1ff utility::callsharedfunc( #"signal_vehicle", #"getowningteam" );
                
                if ( !var_e762fe9c8dc088b )
                {
                    continue;
                }
                
                foreach ( var_a2069bfb97638c1a in teams::getteamdata( var_e762fe9c8dc088b, "players" ) )
                {
                    function_f78af8526b3b6c1( var_a2069bfb97638c1a, 1 );
                }
            }
        }
    }
}

// Namespace dmz_bosses_core
// Params 1, eflags: 0x4
// Checksum 0x77a1b0ab, Offset: 0x25b4
// Size: 0x21
function private function_950fac18e7c7eb7c( instance )
{
    return level.bosses[ instance.name ];
}

// Namespace dmz_bosses_core
// Params 3
// Checksum 0xb637c64e, Offset: 0x25de
// Size: 0x18a
function function_f78af8526b3b6c1( player, showicon, params )
{
    if ( self.revealedto && arraycontains( self.revealedto, player ) )
    {
        return;
    }
    
    successfullyrevealed = self [[ function_950fac18e7c7eb7c( self ).revealfunc ]]( player, showicon, params );
    
    if ( !successfullyrevealed )
    {
        return;
    }
    
    if ( !isdefined( self.revealedto ) )
    {
        self.revealedto = [];
    }
    
    if ( isagent( self.boss ) )
    {
        self.boss setbattlechatterflag( "revealed", 1, 10 );
    }
    
    foreach ( member in teams::getteamdata( player.team, "players" ) )
    {
        member thread utility::callsharedfunc( #"music_intensity", #"boost_intensity", { #level_notify:self.name, #timeout:90, #amount:4, #name:"boss" } );
    }
    
    self.revealedto[ self.revealedto.size ] = player;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xf4da3144, Offset: 0x2770
// Size: 0x49
function function_d6141ca7107e911f( bossname )
{
    boss = level.bosses[ bossname ?? "" ];
    
    if ( !boss.instances )
    {
        return;
    }
    
    return boss.instances[ 0 ];
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x5a41006e, Offset: 0x27c2
// Size: 0x53
function function_a781e2041bb84992( bossname )
{
    boss = level.bosses[ bossname ];
    
    if ( isdefined( boss.instances[ 0 ] ) )
    {
        objidpoolmanager::objective_playermask_showtoall( boss.instances[ 0 ].objidnum );
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x5df221e9, Offset: 0x281d
// Size: 0x129
function function_ee5cd6c99d3a31a5( dist )
{
    self endon( #"death" );
    objweapon = makeweapon( "emp_pulse_mp" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        players = player_utility::script_getplayersinradius( self.origin, dist );
        playedeffect = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player.vehicle ) && !player.vehicle.var_240fd1eb1d0416cc )
            {
                if ( !playedeffect )
                {
                    playsoundatpos( self.origin, "iw9_emp_blast" );
                    playedeffect = 1;
                }
                
                thread bossddos( objweapon, player.vehicle );
            }
        }
    }
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0xfb4e4a1e, Offset: 0x294e
// Size: 0x158
function function_34fa29c23e4bdd62( origin, dist )
{
    self endon( #"boss_death" );
    fakeowner = ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
    objweapon = makeweapon( "emp_pulse_mp" );
    
    while ( true )
    {
        wait 0.5;
        players = player_utility::script_getplayersinradius( origin, dist );
        playedeffect = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player.vehicle ) && !player.vehicle.var_240fd1eb1d0416cc )
            {
                if ( !playedeffect )
                {
                    playsoundatpos( origin, "iw9_emp_blast" );
                    playedeffect = 1;
                }
                
                data = damage_utility::packdamagedata( fakeowner, player.vehicle, 1, objweapon, "MOD_EXPLOSIVE", fakeowner, origin );
                emp_debuff::function_1fdeda386a85c7c7( data, 10, 0 );
            }
        }
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xade51545, Offset: 0x2aae
// Size: 0x72
function function_ff77582b96f073ba( boss )
{
    boss endon( #"boss_despawn" );
    boss endon( #"death" );
    instance = boss.bossinstance;
    self waittill( #"death", killer );
    
    if ( boss.var_707bedfed82898dc )
    {
        boss [[ boss.var_707bedfed82898dc ]]();
    }
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0x75112657, Offset: 0x2b28
// Size: 0x55
function bossddos( objweapon, ent )
{
    ent thread function_95900a6b58b8619d( 10, self );
    data = damage_utility::packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
    emp_debuff::function_1fdeda386a85c7c7( data, 10, 0 );
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0x4bedf833, Offset: 0x2b85
// Size: 0x93
function function_95900a6b58b8619d( duration, target )
{
    self endon( #"death" );
    target endon( #"death" );
    self.var_240fd1eb1d0416cc = 1;
    
    while ( duration > 0 )
    {
        duration -= 0.1;
        
        if ( distancesquared( self.origin, target.origin ) < 122500 )
        {
            self vehphys_parkingbrake( 1 );
            wait duration;
            break;
        }
        
        wait 0.1;
    }
    
    self vehphys_parkingbrake( 0 );
    self.var_240fd1eb1d0416cc = 0;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x8e262f91, Offset: 0x2c20
// Size: 0x22
function function_f12aa382ff8a8d3( ref )
{
    return level.var_7d6d21962fc1b2ee.var_8d9645b9c40b2476[ ref ];
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0xa6cf8333, Offset: 0x2c4b
// Size: 0x140
function function_46ee15ae8f8c48de( details, noteworthy )
{
    utility::flag_wait( "create_script_initialized" );
    
    if ( !isdefined( level.struct_class_names[ "script_noteworthy" ][ noteworthy ] ) )
    {
        details.disabled = 1;
        return;
    }
    
    if ( !isdefined( details.spawnlocs ) )
    {
        details.spawnlocs = [];
    }
    
    foreach ( node in level.struct_class_names[ "script_noteworthy" ][ noteworthy ] )
    {
        if ( dmz_poi::dmzpoi_issystemactive() && !dmz_poi::function_a4891870d8e24df2( node.origin ) )
        {
            continue;
        }
        
        function_fb7db939b48d1bc4( node );
        details.spawnlocs[ details.spawnlocs.size ] = node;
    }
    
    if ( details.spawnlocs.size == 0 )
    {
        details.disabled = 1;
    }
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0x7f849401, Offset: 0x2d93
// Size: 0x113
function function_fb7db939b48d1bc4( node )
{
    if ( node.target )
    {
        node.subnodes = [];
        
        foreach ( subnode in utility::getstructarray( node.target, "targetname" ) )
        {
            if ( !isdefined( node.subnodes[ subnode.script_noteworthy ] ) )
            {
                node.subnodes[ subnode.script_noteworthy ] = [];
            }
            
            node.subnodes[ subnode.script_noteworthy ][ node.subnodes[ subnode.script_noteworthy ].size ] = subnode;
            function_fb7db939b48d1bc4( subnode );
        }
    }
}

// Namespace dmz_bosses_core
// Params 3
// Checksum 0x4022825, Offset: 0x2eae
// Size: 0x2a2
function function_e8b61578ed30f23d( origin, formission, players )
{
    if ( !isdefined( level.bosses ) )
    {
        return;
    }
    
    availablebosses = [];
    
    foreach ( name, boss in level.bosses )
    {
        if ( boss.bundle.islieutenant && function_ad7ad46659e96699( name ) == 0 )
        {
            foreach ( instance in boss.instances )
            {
                if ( formission )
                {
                    if ( mission_manager::function_a0be961ea5ad959c( instance mission_manager::get_mission() ) )
                    {
                        continue;
                    }
                    
                    var_2b6d8e309c527e17 = 0;
                    
                    foreach ( player in players ?? [] )
                    {
                        var_f36019a2f91c942e = mission_manager::function_f41d91b1de232b9c( player, [ instance.bundle.missionasset, instance.bundle.var_d74024bd6dc41b10, instance.bundle.var_7086ac6a2b0dfb33 ] ) ?? [];
                        
                        if ( var_f36019a2f91c942e.size > 0 )
                        {
                            var_2b6d8e309c527e17 = 1;
                            break;
                        }
                    }
                    
                    if ( var_2b6d8e309c527e17 )
                    {
                        continue;
                    }
                }
                
                if ( !function_9764139090a2762d( boss, instance ) )
                {
                    continue;
                }
                
                if ( !instance.boss && !instance.combattrigger )
                {
                    continue;
                }
                
                availablebosses[ availablebosses.size ] = instance;
            }
        }
    }
    
    if ( !availablebosses.size )
    {
        return;
    }
    
    if ( origin )
    {
        return function_628bac9faa9d1e86( availablebosses, origin )[ 0 ];
    }
    
    return utility::array_random( availablebosses );
}

/#

    // Namespace dmz_bosses_core
    // Params 0
    // Checksum 0xa0e90b81, Offset: 0x3158
    // Size: 0xb6, Type: dev
    function function_db57f0351c671a77()
    {
        boss = self;
        boss endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_d289f37825c197a1", 0 ) )
            {
                boss thread debug::drawsphere( boss.origin, 64, 0.05, ( 1, 0, 0 ) );
                print3d( boss.origin + ( 0, 0, 64 ), boss.bossname, ( 1, 0, 0 ), 1, 2, int( 0.05 / level.framedurationseconds ) );
            }
            
            wait 0.05;
        }
    }

    // Namespace dmz_bosses_core
    // Params 0, eflags: 0x4
    // Checksum 0x4870ca0e, Offset: 0x3216
    // Size: 0xcc, Type: dev
    function private function_e5574b5c81b54635()
    {
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_4446d94f5c1cfbd2", 0 ) == 1 )
            {
                foreach ( agent in level.agentarray )
                {
                    if ( agent.category == "<dev string:x9d>" )
                    {
                        sphere( agent.origin, 10, ( 1, 0, 0 ) );
                    }
                }
            }
            
            dmz_debug::function_e82a4a3462eeffba();
        }
    }

    // Namespace dmz_bosses_core
    // Params 1
    // Checksum 0xc57be5a4, Offset: 0x32ea
    // Size: 0x50, Type: dev
    function init_dev_gui( bossname )
    {
        devgui::function_9082edeb5db93280( "<dev string:xa4>" );
        devgui::add_devgui_command( "<dev string:xb3>", "<dev string:xcc>" );
        devgui::add_devgui_command( "<dev string:xec>" + bossname, "<dev string:xf3>" + bossname + "<dev string:x111>" );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace dmz_bosses_core
// Params 0
// Checksum 0x368ddbda, Offset: 0x3342
// Size: 0x1f0
function function_e9812a02bc402039()
{
    level endon( #"game_ended" );
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        foreach ( boss in level.bosses )
        {
            if ( getdvarint( hashcat( @"hash_ae8b27dfb298c5d5", boss.name ), 0 ) )
            {
                instance = function_69c16ee974a58fcb( boss.name );
                spawntype = getdvarint( @"hash_2919a6fd16b721f", 0 );
                
                switch ( spawntype )
                {
                    case 1:
                        origin = instance.spawnloc.origin;
                        angles = instance.spawnloc.angles;
                        break;
                    case 0:
                    default:
                        origin = getclosestpointonnavmesh( level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 128 );
                        angles = level.players[ 0 ].angles;
                        break;
                }
                
                function_9e473f265756029b( boss.name, origin, angles, instance );
                setdvar( hashcat( @"hash_ae8b27dfb298c5d5", boss.name ), 0 );
            }
        }
        
        wait 1;
    }
}

// Namespace dmz_bosses_core
// Params 4
// Checksum 0x1b32306b, Offset: 0x353a
// Size: 0x8e
function function_9e473f265756029b( bossname, origin, angles, instance = function_69c16ee974a58fcb( bossname ) )
{
    if ( !isdefined( instance.spawnloc ) )
    {
        instance.spawnloc = spawnstruct();
    }
    
    instance.spawnloc.origin = origin;
    instance.spawnloc.angles = angles;
    spawnboss( bossname, instance );
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xce2e02c5, Offset: 0x35d0
// Size: 0x174
function function_cfed4d8c65479c98( bossname )
{
    if ( !level.bosses )
    {
        return [];
    }
    
    bosses = [];
    
    if ( level.bosses )
    {
        foreach ( boss in level.bosses )
        {
            if ( !boss.instances || !boss.instances.size )
            {
                continue;
            }
            
            foreach ( bossinstance in boss.instances )
            {
                if ( ( bossname == "all" || bossinstance.name == bossname ) && bossinstance.boss )
                {
                    bosses[ bosses.size ] = bossinstance.boss;
                }
            }
        }
    }
    
    return bosses;
}

// Namespace dmz_bosses_core
// Params 1
// Checksum 0xc4271530, Offset: 0x374d
// Size: 0x18d
function function_f010409efa7427cc( argval )
{
    switch ( argval )
    {
        case 1:
            foreach ( player in level.players )
            {
                if ( player.team == level.players[ 0 ].team && level.players[ 0 ] != player )
                {
                    return player;
                }
            }
            
            break;
        case 2:
            foreach ( player in level.players )
            {
                if ( player.team != level.players[ 0 ].team )
                {
                    return player;
                }
            }
            
            break;
        default:
            return level.players[ 0 ];
    }
    
    return level.players[ 0 ];
}

// Namespace dmz_bosses_core
// Params 2
// Checksum 0x743508a6, Offset: 0x38e3
// Size: 0x29d
function function_20d8a6e66495ddf2( command, args )
{
    switch ( command )
    {
        case #"hash_819aac6f5ae2fb78":
            bossname = args[ 0 ];
            setdvar( hashcat( @"hash_ae8b27dfb298c5d5", bossname ), 1 );
            break;
        case #"hash_1cc8a923a608c2a0":
        case #"hash_611825599f1b56f9":
            bossname = undefined;
            indexmod = 0;
            
            if ( isdefined( args[ 0 ] ) && int( args[ 0 ] ) != 0 )
            {
                indexmod -= 1;
            }
            else
            {
                bossname = args[ 0 ];
            }
            
            damage = undefined;
            var_12b7dc1b5d1c822 = undefined;
            
            if ( command == "damage" )
            {
                damage = int( args[ 1 + indexmod ] );
                var_12b7dc1b5d1c822 = isdefined( args[ 2 + indexmod ] ) ? int( args[ 2 + indexmod ] ) : 2;
            }
            else
            {
                var_12b7dc1b5d1c822 = isdefined( args[ 1 + indexmod ] ) ? int( args[ 1 + indexmod ] ) : 1;
            }
            
            chosenplayer = function_f010409efa7427cc( var_12b7dc1b5d1c822 );
            
            if ( !bossname )
            {
                bossname = function_e8b61578ed30f23d( chosenplayer.origin ).name;
            }
            
            if ( !bossname )
            {
                return;
            }
            
            foreach ( boss in function_cfed4d8c65479c98( bossname ) )
            {
                if ( command == "kill" )
                {
                    boss kill( undefined, chosenplayer );
                    continue;
                }
                
                boss dodamage( damage, boss.origin, chosenplayer );
            }
            
            break;
        case #"hash_1ff1875d104fcb1e":
            bossname = args[ 0 ];
            var_12b7dc1b5d1c822 = isdefined( args[ 1 ] ) ? int( args[ 1 ] ) : 0;
            chosenplayer = function_f010409efa7427cc( var_12b7dc1b5d1c822 );
            
            foreach ( boss in function_cfed4d8c65479c98( bossname ) )
            {
                chosenplayer setorigin( boss.origin );
                break;
            }
            
            break;
        default:
            break;
    }
}

