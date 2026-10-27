// scripts\mp\br\br_destruction_scenarios.gsc  (hash_14ceeb01379319da.gscc) (size: 8132 Bytes / 0x1fc4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97d9cea1 (2547633825)
// size ...... 8132 (0x1fc4)
// includes .. 9   (offset: 0x1e44)
// strings ... 15  (offset: 0x1e8c)
// dev strs .. 10  (offset: 0x1f4c)
// exports ... 25  (offset: 0x1258)
// cseg ...... 0x176 + 0x10e2 (0x1258)
// imports ... 71  (offset: 0x1640)
// animtree1 . 0   (offset: 0x1fc4)
// animtree2 . 0   (offset: 0x1fc4)
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_infils_common;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game;
#using scripts\mp\compass;
#using scripts\mp\flags;

#namespace br_destruction_scenarios;

// Namespace br_destruction_scenarios
// Params 0, eflags: 0x1
// Checksum 0x718efb00, Offset: 0x194
// Size: 0x47
function autoexec main()
{
    if ( getdvarint( @"hash_a9df41b469b5dbe2", 1 ) <= 0 )
    {
        return;
    }
    
    utility::registersharedfunc( #"br_destruction_scenarios", #"hash_823c0f506a4fe9b9", &function_7ca2cc336dac0cf0 );
    init();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_destruction_scenarios
// Params 0, eflags: 0x4
// Checksum 0x206cbffa, Offset: 0x1e3
// Size: 0x54
function private init()
{
    level.br_destruction_scenario = init_script_bundle();
    
    if ( !isdefined( level.br_destruction_scenario ) )
    {
        return;
    }
    
    function_47c1b4dc2a7a6389();
    scenario = choose_scenario();
    select_scenario( scenario );
    thread play_scenario( scenario );
    record_scenario( scenario );
}

// Namespace br_destruction_scenarios
// Params 0
// Checksum 0x36f55f9c, Offset: 0x23f
// Size: 0xc2
function init_script_bundle()
{
    scriptbundle = game_utility_mp::function_cb7ed8e67866f9d0( "brdestructionscenarios_list" );
    
    if ( !isdefined( scriptbundle ) )
    {
        return;
    }
    
    if ( scriptbundle.brdestructionscenarioslist.size < 1 )
    {
        return;
    }
    
    var_f4ca69eb8d4c12ca = scriptbundle.brdestructionscenarioslist[ 0 ].destructionscenario;
    var_9da79ce423baf77a = getdvar( @"hash_12debc3ddf3a6d17", "" );
    
    if ( var_9da79ce423baf77a != "" )
    {
        var_f4ca69eb8d4c12ca = hashcat( %"hash_7fa0abbafe544979", var_9da79ce423baf77a );
    }
    
    var_a06764e77a57c3d1 = getscriptbundle( var_f4ca69eb8d4c12ca );
    assert( isdefined( var_a06764e77a57c3d1 ), "<dev string:x24>" + var_f4ca69eb8d4c12ca + "<dev string:x43>" );
    return { #var_9f5746f82ead2ec9:var_a06764e77a57c3d1 };
}

// Namespace br_destruction_scenarios
// Params 3
// Checksum 0x21d5d59a, Offset: 0x30a
// Size: 0xb3
function function_8fb272f7c79ddd64( origin, areaswapname, areaswapstate )
{
    selectedscenario = level.br_destruction_scenario.selectedscenario;
    
    if ( !isdefined( selectedscenario ) )
    {
        return;
    }
    
    if ( selectedscenario.name != areaswapname )
    {
        return 0;
    }
    
    if ( isdefined( areaswapstate ) && isdefined( selectedscenario.destructionstate.state ) && areaswapstate != selectedscenario.destructionstate.state )
    {
        return 0;
    }
    
    isinareaswap = function_37bea690ca7f846d( origin, areaswapname, selectedscenario.defaultstate );
    return isinareaswap;
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x12a30ea3, Offset: 0x3c6
// Size: 0xe6, Type: bool
function private function_7ca2cc336dac0cf0( poiname )
{
    var_85c1736fc74c4be1 = level.br_destruction_scenario.selectedscenario.var_85c1736fc74c4be1;
    
    if ( !var_85c1736fc74c4be1 || var_85c1736fc74c4be1.size == 0 )
    {
        return false;
    }
    
    foreach ( var_ed7d00a62d697245 in var_85c1736fc74c4be1 )
    {
        var_3a552db7a0f65d25 = getscriptbundle( var_ed7d00a62d697245.var_a06740239ae5a7bb );
        targetname = var_3a552db7a0f65d25.targetpoi;
        
        if ( targetname == poiname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_destruction_scenarios
// Params 0, eflags: 0x4
// Checksum 0x83e1ae59, Offset: 0x4b5
// Size: 0x196
function private function_47c1b4dc2a7a6389()
{
    validoverrides = get_valid_overrides();
    
    if ( validoverrides.size <= 0 )
    {
        return;
    }
    
    var_d90c21c892d0495e = [];
    
    foreach ( index, scenario in level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios )
    {
        scenario.scenarioname = tolower( scenario.scenarioname );
        scenario.weight = 0;
        var_d90c21c892d0495e[ scenario.scenarioname ] = index;
    }
    
    foreach ( validoverride in validoverrides )
    {
        scenarioindex = var_d90c21c892d0495e[ validoverride.scenarioname ];
        level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios[ scenarioindex ].weight = validoverride.weight;
    }
}

// Namespace br_destruction_scenarios
// Params 0, eflags: 0x4
// Checksum 0x60058678, Offset: 0x653
// Size: 0x13b
function private get_valid_overrides()
{
    weightoverrides = getdvar( @"hash_d8db6ac022cc3906", "" );
    var_ce01f009b883ba6c = strtok( weightoverrides, "," );
    validoverrides = [];
    
    foreach ( pair in var_ce01f009b883ba6c )
    {
        pairarray = strtok( pair, " " );
        
        if ( pairarray.size > 1 && isstring( pairarray[ 0 ] ) )
        {
            validoverride = spawnstruct();
            validoverride.scenarioname = tolower( pairarray[ 0 ] );
            validoverride.weight = int( pairarray[ 1 ] );
            validoverrides[ validoverrides.size ] = validoverride;
            continue;
        }
        
        assertmsg( "<dev string:x50>" + getxhashsourcename( @"hash_d8db6ac022cc3906" ) + "<dev string:x59>" + pair + "<dev string:x68>" );
    }
    
    return validoverrides;
}

// Namespace br_destruction_scenarios
// Params 0, eflags: 0x4
// Checksum 0x8feca006, Offset: 0x797
// Size: 0x15e
function private choose_scenario()
{
    totalweight = 0;
    
    foreach ( index, scenario in level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios )
    {
        totalweight += scenario.weight;
        scenario.index = index;
    }
    
    choosenweight = randomfloat( totalweight );
    cumulativeweight = 0;
    
    foreach ( scenario in level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios )
    {
        cumulativeweight += scenario.weight;
        
        if ( cumulativeweight > choosenweight )
        {
            return scenario;
        }
    }
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x5ccb9f33, Offset: 0x8fe
// Size: 0x3a
function private select_scenario( scenario )
{
    level.br_destruction_scenario.selectedscenario = scenario;
    setomnvar( "ui_br_destruction_scenario_selected_index", scenario.index + 1 );
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x7caaa9d4, Offset: 0x940
// Size: 0x110
function private play_scenario( scenario )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( scenario ) )
    {
        return;
    }
    
    if ( isdefined( scenario.scenename ) )
    {
        scenario.scene = function_cd122ee37a0fbcbb( scenario.scenename );
    }
    
    if ( scenario.var_b26cff4d28f13870 )
    {
        game[ "dialog" ][ scenario.var_b26cff4d28f13870 ] = scenario.var_b26cff4d28f13870;
        game[ "dialog_prefix" ][ scenario.var_b26cff4d28f13870 ] = scenario.var_11e50d3a797dbeec;
    }
    
    if ( !scenario.debugplay )
    {
        flags::function_2f3408423ccc9b2e( "prematch_done" );
    }
    
    function_907d333eda98c00b( scenario );
    
    if ( scenario.debugplay )
    {
        waitframe();
    }
    else
    {
        flags::gameflagwait( "prematch_fade_done" );
    }
    
    thread function_260c7f92658e3b8b( scenario );
    function_c256434a9a75a409( scenario );
    thread function_10094e36961b0e90( scenario );
    thread function_670158f14beb8ce8( scenario );
    thread function_bb7349c5fc046a7a( scenario );
    function_a2a8841886bc452f( scenario );
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0xd546e0b, Offset: 0xa58
// Size: 0x33
function private function_cd122ee37a0fbcbb( scenename )
{
    scene = spawnstruct();
    scene scene::set_scriptbundle( scenename );
    scene scene::set_anim_rate( 1 );
    return scene;
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x2e379010, Offset: 0xa94
// Size: 0x57
function private function_907d333eda98c00b( scenario )
{
    if ( isdefined( scenario.flyinstate ) )
    {
        setareaswaphint( scenario.name, scenario.flyinstate );
    }
    
    if ( isdefined( scenario.var_867cd596a2640a9 ) )
    {
        compass::setupminimap( scenario.var_867cd596a2640a9 );
    }
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x6b1ff0d0, Offset: 0xaf3
// Size: 0xe8
function private function_260c7f92658e3b8b( scenario )
{
    if ( isdefined( scenario.defaultstate ) )
    {
        utility::clean_area_swap_state( scenario.name, scenario.defaultstate );
    }
    
    if ( isdefined( scenario.flyinstate ) )
    {
        setareaswapstate( scenario.name, scenario.flyinstate );
    }
    
    waitframe();
    
    if ( isdefined( scenario.scene ) )
    {
        scenario.scene scene::pre_stream();
        scenario.scene scene::init();
        scenario.scene scene::function_c3c55ba95cf75724( 1 );
    }
    
    if ( isdefined( scenario.destructionstate.state ) )
    {
        setareaswaphint( scenario.name, scenario.destructionstate.state );
    }
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x9c4d8a11, Offset: 0xbe3
// Size: 0xdf
function private function_c256434a9a75a409( scenario )
{
    if ( scenario.debugplay )
    {
        waitframe();
        waitframe();
        return;
    }
    
    if ( isdefined( level.br_ac130 ) )
    {
        msg = utility::waittill_any_ents_return( level, "infil_animatic", level.br_ac130, "start_moving" );
    }
    else
    {
        flags::gameflagwait( "infil_animatic_complete" );
    }
    
    switch ( msg ?? "" )
    {
        case #"hash_6f46b18d51d2c1e":
            duration = br_infils_common::function_939f0d1a2134fe0e() + br_c130::function_1a0e2af4b3229059();
            break;
        case #"hash_362b0b988997a926":
            duration = br_c130::function_1a0e2af4b3229059();
            break;
        default:
            duration = 0;
            break;
    }
    
    waittime = duration - scenario.var_4b75af02b331b63f;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0xf0dd340f, Offset: 0xcca
// Size: 0x39
function private function_10094e36961b0e90( scenario )
{
    if ( !isdefined( scenario.scene ) )
    {
        return;
    }
    
    scenario.scene thread scene::play();
    level thread function_cf76abe168b4586a( scenario );
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x9a4905be, Offset: 0xd0b
// Size: 0xa8
function private function_a2a8841886bc452f( scenario )
{
    wait scenario.destructionstate.delay;
    
    if ( isdefined( scenario.destructionstate.state ) )
    {
        setareaswapstate( scenario.name, scenario.destructionstate.state );
    }
    
    waittime = getdvarint( @"hash_c83d487ec3dec085", 2 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( !isdefined( scenario.scene ) )
    {
        return;
    }
    
    scenario.scene scene::cleanup();
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0xaa56bf7d, Offset: 0xdbb
// Size: 0x6e
function private function_bb7349c5fc046a7a( scenario )
{
    var_b35aa375dee62cc2 = scenario.var_85c1736fc74c4be1;
    startdelay = scenario.debugplay ? 0 : scenario.var_de2e97388a44d0d8;
    
    if ( !isdefined( var_b35aa375dee62cc2 ) )
    {
        return;
    }
    
    utility::callsharedfunc( #"game", #"hash_83813268d7766e3d", var_b35aa375dee62cc2, startdelay );
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0x62316547, Offset: 0xe31
// Size: 0x117
function private function_cf76abe168b4586a( scenario )
{
    if ( scenario.exploders.size <= 0 )
    {
        return;
    }
    
    foreach ( exploder in scenario.exploders )
    {
        if ( !( isdefined( exploder ) && isdefined( exploder.name ) ) )
        {
            continue;
        }
        
        if ( exploder.delay == 0 )
        {
            thread utility::exploder( exploder.name, level.players );
            continue;
        }
        
        if ( exploder.delay > 0 )
        {
            utility::delaythreadendon( exploder.delay, "game_ended", &utility::exploder, exploder.name, level.players );
        }
    }
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0xe1dcd00a, Offset: 0xf50
// Size: 0x4a
function private function_670158f14beb8ce8( scenario )
{
    if ( !isdefined( scenario.var_b26cff4d28f13870 ) )
    {
        return;
    }
    
    if ( isdefined( scenario.var_a1db2315f9261b11 ) )
    {
        wait scenario.var_a1db2315f9261b11;
    }
    
    br_public::brleaderdialog( scenario.var_b26cff4d28f13870 );
}

// Namespace br_destruction_scenarios
// Params 1, eflags: 0x4
// Checksum 0xeaeccb9c, Offset: 0xfa2
// Size: 0x3d
function private record_scenario( scenario )
{
    eventparams = [ "scenario_name", scenario.scenarioname ];
    dlog_recordevent( "dlog_event_br_destruction_scenario", eventparams );
}

/#

    // Namespace br_destruction_scenarios
    // Params 0
    // Checksum 0x95fef158, Offset: 0xfe7
    // Size: 0xc, Type: dev
    function debug_init()
    {
        devgui_init();
    }

    // Namespace br_destruction_scenarios
    // Params 0
    // Checksum 0x4a4d1ae2, Offset: 0xffb
    // Size: 0xfd, Type: dev
    function devgui_init()
    {
        if ( !isdefined( level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios ) )
        {
            return;
        }
        
        level.br_destruction_scenario.var_ecf8c211ca0c4db3 = [];
        
        foreach ( scenario in level.br_destruction_scenario.var_9f5746f82ead2ec9.scenarios )
        {
            level.br_destruction_scenario.var_ecf8c211ca0c4db3[ level.br_destruction_scenario.var_ecf8c211ca0c4db3.size ] = scenario;
        }
        
        function_3083613e027cb227( "<dev string:x6a>", &function_eab0266ef93156eb );
    }

    // Namespace br_destruction_scenarios
    // Params 2
    // Checksum 0x977f606e, Offset: 0x1100
    // Size: 0x9f, Type: dev
    function function_3083613e027cb227( blockid, callback )
    {
        devgui::function_9082edeb5db93280( "<dev string:x78>" + blockid + "<dev string:x92>" );
        
        for ( i = 0; i < level.br_destruction_scenario.var_ecf8c211ca0c4db3.size ; i++ )
        {
            scenario = level.br_destruction_scenario.var_ecf8c211ca0c4db3[ i ];
            devgui::function_cd4e263c1f3018ae( scenario.scenarioname, blockid + "<dev string:x94>" + i, callback );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_destruction_scenarios
    // Params 1
    // Checksum 0x41b380c8, Offset: 0x11a7
    // Size: 0xb1, Type: dev
    function function_eab0266ef93156eb( params )
    {
        scenario = level.br_destruction_scenario.var_ecf8c211ca0c4db3[ int( params[ 0 ] ) ];
        scenario.debugplay = 1;
        
        if ( isdefined( scenario.destructionstate.state ) )
        {
            setareaswapstate( scenario.name, scenario.defaultstate );
        }
        
        utility::callsharedfunc( #"game", #"hash_5a923eb4a3810b51" );
        waitframe();
        iprintlnbold( "<dev string:x96>" + scenario.scenarioname );
        play_scenario( scenario );
    }

#/
