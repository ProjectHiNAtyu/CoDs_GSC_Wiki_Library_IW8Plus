// scripts\mp\br\gametypes\br_sierra_sidequest_radio_signal.gsc  (hash_345f7bbd437cde81.gscc) (size: 8194 Bytes / 0x2002 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd169dd90 (3513376144)
// size ...... 8194 (0x2002)
// includes .. 9   (offset: 0x1dde)
// strings ... 23  (offset: 0x1e26)
// dev strs .. 11  (offset: 0x1f76)
// exports ... 22  (offset: 0x138a)
// cseg ...... 0x25f + 0x112b (0x138a)
// imports ... 60  (offset: 0x16fa)
// animtree1 . 0   (offset: 0x2002)
// animtree2 . 0   (offset: 0x2002)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\interaction;

#namespace br_sierra_sidequest_radio_signal;

// Namespace br_sierra_sidequest_radio_signal
// Params 0, eflags: 0x5
// Checksum 0x6bd3f080, Offset: 0x27d
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0x8cf920a5, Offset: 0x28e
// Size: 0x5e
function init()
{
    quest = { #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"radio_signal" };
    br_map_quest::register( quest );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0xc480ec8d, Offset: 0x2f4
// Size: 0x486
function on_init()
{
    init_dialog();
    level.radio_signal = { #var_2b5636ce03c2cafa:[], #var_734c68e3408ce645:0, #var_2a8cf68660ce9c8b:undefined, #var_9bee60b9b5c93496:0, #var_79286910fa6900c2:[], #var_b0a105e097889867:[] };
    var_a70ee356c13f223f = utility::getstructarray( "electrical_box_sierra_radio_signal_ee", "targetname" );
    
    if ( var_a70ee356c13f223f.size > 0 )
    {
        foreach ( electrical_struct in var_a70ee356c13f223f )
        {
            assert( isdefined( electrical_struct.script_noteworthy ), "<dev string:x24>" );
            tower_info = { #electrical_box_angles:electrical_struct.angles, #electrical_box_origin:electrical_struct.origin, #index:int( electrical_struct.script_noteworthy ) - 1 };
            level.radio_signal.var_2b5636ce03c2cafa[ level.radio_signal.var_2b5636ce03c2cafa.size ] = tower_info;
        }
    }
    else
    {
        level.radio_signal.var_2b5636ce03c2cafa = function_9fff7936e633e26();
    }
    
    if ( getdvarint( @"hash_a12b23810ec7d607", 0 ) )
    {
        level.radio_signal.var_9bee60b9b5c93496 = minint( getdvarint( @"hash_1035a22c9453dc71", 2 ), level.radio_signal.var_2b5636ce03c2cafa.size );
        var_615f384fb1c0922e = arraycopy( level.radio_signal.var_2b5636ce03c2cafa );
        
        for ( i = 0; i < level.radio_signal.var_9bee60b9b5c93496 ; i++ )
        {
            var_fc0cc48906bb431e = randomint( var_615f384fb1c0922e.size );
            tower_info = var_615f384fb1c0922e[ var_fc0cc48906bb431e ];
            level.radio_signal.var_79286910fa6900c2[ level.radio_signal.var_79286910fa6900c2.size ] = tower_info;
            var_615f384fb1c0922e[ var_fc0cc48906bb431e ] = undefined;
            
            if ( isint( var_fc0cc48906bb431e ) )
            {
                function_cdc669dbc8ea2101( var_615f384fb1c0922e );
            }
        }
    }
    else
    {
        level.radio_signal.var_9bee60b9b5c93496 = 2;
        var_b1e29309d51981d0 = utility::array_random( [ [ 0, 4 ], [ 4, 6 ], [ 3, 4 ], [ 1, 6 ], [ 2, 7 ], [ 7, 8 ], [ 5, 9 ], [ 7, 9 ], [ 2, 5 ], [ 1, 3 ] ] );
        
        /#
            assert( var_b1e29309d51981d0[ 0 ] < level.radio_signal.var_2b5636ce03c2cafa.size && var_b1e29309d51981d0[ 0 ] >= 0, "<dev string:x7c>" + level.radio_signal.var_2b5636ce03c2cafa.size - 1 );
            assert( var_b1e29309d51981d0[ 1 ] < level.radio_signal.var_2b5636ce03c2cafa.size && var_b1e29309d51981d0[ 1 ] >= 0, "<dev string:x7c>" + level.radio_signal.var_2b5636ce03c2cafa.size - 1 );
        #/
        
        level.radio_signal.var_79286910fa6900c2[ level.radio_signal.var_79286910fa6900c2.size ] = level.radio_signal.var_2b5636ce03c2cafa[ var_b1e29309d51981d0[ 0 ] ];
        level.radio_signal.var_79286910fa6900c2[ level.radio_signal.var_79286910fa6900c2.size ] = level.radio_signal.var_2b5636ce03c2cafa[ var_b1e29309d51981d0[ 1 ] ];
    }
    
    level.radio_signal.var_3d01c363da1b02fe = level.radio_signal.var_9bee60b9b5c93496;
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0xa59f3e34, Offset: 0x782
// Size: 0x28
function init_dialog()
{
    game[ "dialog" ][ "first_radio_tower_activated" ] = "tree_twee_wzan_twrm";
    game[ "dialog" ][ "last_radio_tower_activated" ] = "tree_twee_wzan_twfn";
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0x118f0b39, Offset: 0x7b2
// Size: 0x2
function on_precache()
{
    
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0xc0f972b8, Offset: 0x7bc
// Size: 0x2
function on_start()
{
    
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0
// Checksum 0xe09e347f, Offset: 0x7c6
// Size: 0x105
function on_prematch_end()
{
    thread function_77eba3708db32302();
    level.radio_signal.var_2a8cf68660ce9c8b = spawnscriptable( "equipment_computer_workstation_02", ( -22819, 27519, 1153 ), ( 0, 330, 0 ) );
    level.radio_signal.var_2a8cf68660ce9c8b setscriptablepartstate( "equipment_computer_workstation_03", "usable" );
    computer_trigger = spawn( "noent_volume_trigger_radius", level.radio_signal.var_2a8cf68660ce9c8b.origin, 0, 300, 150 );
    trigger::makeenterexittrigger( computer_trigger, &function_391ab7e262791678, &function_7e4e7e4f82998796, undefined, undefined, &triggerfilter );
    tower_trigger = spawn( "noent_volume_trigger_radius", ( -22468, 27346, 1153 ), 0, 600, 150 );
    trigger::makeenterexittrigger( tower_trigger, &function_f0b5f1000154a9be, &function_be43192a4b85f5e8, undefined, undefined, &triggerfilter );
    function_36e89741117ad99b();
    
    /#
        debug_init();
    #/
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0, eflags: 0x4
// Checksum 0xad6ce84f, Offset: 0x8d3
// Size: 0x25a
function private function_9fff7936e633e26()
{
    return [ { #electrical_box_angles:( 0, 250, 0 ), #electrical_box_origin:( -17915.2, 55924.5, 4945.25 ), #index:0 }, { #electrical_box_angles:( 0, 0, 0 ), #electrical_box_origin:( -438.75, 47211.8, 3440.25 ), #index:1 }, { #electrical_box_angles:( 0, 180, 0 ), #electrical_box_origin:( 1815.25, 45146.5, 3118.5 ), #index:2 }, { #electrical_box_angles:( 0, 180, 0 ), #electrical_box_origin:( 36664.2, 26616.8, 1812 ), #index:3 }, { #electrical_box_angles:( 0, 225, 0 ), #electrical_box_origin:( -460.25, 15363, 1441.5 ), #index:4 }, { #electrical_box_angles:( 0, 45, 0 ), #electrical_box_origin:( 14596.8, 15277.2, 1895.25 ), #index:5 }, { #electrical_box_angles:( 0, 270, 0 ), #electrical_box_origin:( -38420.6, -5836.3, 1556.25 ), #index:6 }, { #electrical_box_angles:( 0, 280, 0 ), #electrical_box_origin:( 1991.75, -3315.5, 1392 ), #index:7 }, { #electrical_box_angles:( 0, 45, 0 ), #electrical_box_origin:( -25780.8, -31691.2, 1580.25 ), #index:8 }, { #electrical_box_angles:( 0, 350, 0 ), #electrical_box_origin:( 26103.5, -34568.2, 1254.25 ), #index:9 } ];
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0, eflags: 0x4
// Checksum 0xd67af000, Offset: 0xb36
// Size: 0x124
function private function_77eba3708db32302()
{
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( tower_info in level.radio_signal.var_2b5636ce03c2cafa )
    {
        electrical_box = spawnscriptable( "electrical_box_sierra_radio_signal_ee", tower_info.electrical_box_origin, tower_info.electrical_box_angles );
        state = "unusable_on";
        
        if ( arraycontains( level.radio_signal.var_79286910fa6900c2, tower_info ) )
        {
            state = "off";
            interaction::register_scriptable_interact( electrical_box, &function_97dabe4acaf60738 );
            electrical_box.var_c6cc7e1963a05f88 = tower_info.index;
            tower_info.electrical_box = electrical_box;
        }
        
        electrical_box setscriptablepartstate( "electrical_box", state );
    }
}

// Namespace br_sierra_sidequest_radio_signal
// Params 1, eflags: 0x4
// Checksum 0x3ebee73, Offset: 0xc62
// Size: 0x27b
function private function_97dabe4acaf60738( player )
{
    electrical_box = self;
    electrical_box setscriptablepartstate( "electrical_box", "unusable_on" );
    
    if ( level.radio_signal.var_9bee60b9b5c93496 <= 0 )
    {
        return;
    }
    
    packed_index = function_a3b76c0eebe1a994( getomnvar( "ui_br_sierra_radio_signal_tower_states" ), electrical_box.var_c6cc7e1963a05f88, 1 );
    setomnvar( "ui_br_sierra_radio_signal_tower_states", packed_index );
    var_fdfdfaf07376f72b = level.radio_signal.var_3d01c363da1b02fe == level.radio_signal.var_9bee60b9b5c93496;
    
    if ( var_fdfdfaf07376f72b )
    {
        thread br_public::brleaderdialogplayer( "first_radio_tower_activated", player, 1, 0, 0, undefined, "dx_br_" );
    }
    
    level.radio_signal.var_b0a105e097889867[ player.team ] = player.team;
    level.radio_signal.var_9bee60b9b5c93496--;
    
    if ( level.radio_signal.var_9bee60b9b5c93496 <= 0 )
    {
        thread br_public::brleaderdialogplayer( "last_radio_tower_activated", player, 1, 0, 0, undefined, "dx_br_" );
        points::function_40522c040a4e7b1( player.team, #"hash_551260637f239137" );
        challenges::function_37e945722d6497f3( player, "sierra_sidequest_60", 1 );
        player dlog_recordplayerevent( "dlog_event_br_" + "sierra_sidequest_60", [ "success", 1 ] );
        
        if ( utility::issharedfuncdefined( #"br_heat", #"hash_9f22480705367c86" ) )
        {
            foreach ( team in level.radio_signal.var_b0a105e097889867 )
            {
                player_squad_array = teams::getfriendlyplayers( team, 0 );
                var_7b26d006b4851219 = getdvarint( @"hash_5169330c5bb03b8", 300 );
                thread [[ utility::getsharedfunc( #"br_heat", #"hash_9f22480705367c86" ) ]]( player_squad_array, var_7b26d006b4851219 );
            }
        }
        
        return;
    }
    
    points::function_40522c040a4e7b1( player.team, #"hash_ee850ab2c54685f7" );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 3, eflags: 0x4
// Checksum 0xa3ab492b, Offset: 0xee5
// Size: 0x25, Type: bool
function private triggerfilter( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 2, eflags: 0x4
// Checksum 0xed8df0da, Offset: 0xf13
// Size: 0x66
function private function_391ab7e262791678( ent, trigger )
{
    level.radio_signal.var_734c68e3408ce645++;
    
    if ( level.radio_signal.var_734c68e3408ce645 == 1 )
    {
        level.radio_signal.var_2a8cf68660ce9c8b utility::function_32b24db3127bff40( "equipment_computer_workstation_03", "on" );
    }
}

// Namespace br_sierra_sidequest_radio_signal
// Params 2, eflags: 0x4
// Checksum 0xd02ae2ff, Offset: 0xf81
// Size: 0x65
function private function_7e4e7e4f82998796( ent, trigger )
{
    level.radio_signal.var_734c68e3408ce645--;
    
    if ( level.radio_signal.var_734c68e3408ce645 <= 0 )
    {
        level.radio_signal.var_2a8cf68660ce9c8b utility::function_32b24db3127bff40( "equipment_computer_workstation_03", "usable" );
    }
}

// Namespace br_sierra_sidequest_radio_signal
// Params 2, eflags: 0x4
// Checksum 0xeefef048, Offset: 0xfee
// Size: 0x23
function private function_f0b5f1000154a9be( ent, trigger )
{
    ent setclientomnvar( "ui_br_sierra_radio_signal_computer_active", 1 );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 2, eflags: 0x4
// Checksum 0xdee9bb8c, Offset: 0x1019
// Size: 0x22
function private function_be43192a4b85f5e8( ent, trigger )
{
    ent setclientomnvar( "ui_br_sierra_radio_signal_computer_active", 0 );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 0, eflags: 0x4
// Checksum 0x7eb42291, Offset: 0x1043
// Size: 0x73
function private function_36e89741117ad99b()
{
    var_4905cdcf563ab1d6 = 1023;
    
    for ( i = 0; i < level.radio_signal.var_79286910fa6900c2.size ; i++ )
    {
        var_4905cdcf563ab1d6 = function_a3b76c0eebe1a994( var_4905cdcf563ab1d6, level.radio_signal.var_79286910fa6900c2[ i ].index, 0 );
    }
    
    setomnvar( "ui_br_sierra_radio_signal_tower_states", var_4905cdcf563ab1d6 );
}

// Namespace br_sierra_sidequest_radio_signal
// Params 3, eflags: 0x4
// Checksum 0xaa6d8209, Offset: 0x10be
// Size: 0x4d
function private function_a3b76c0eebe1a994( var_fca844c1ff36419e, towerindex, isenabled )
{
    if ( towerindex >= 0 && towerindex < 10 )
    {
        if ( isenabled )
        {
            var_fca844c1ff36419e |= 1 << towerindex;
        }
        else
        {
            var_fca844c1ff36419e &= ~( 1 << towerindex );
        }
    }
    
    return var_fca844c1ff36419e;
}

/#

    // Namespace br_sierra_sidequest_radio_signal
    // Params 0, eflags: 0x4
    // Checksum 0xe3011528, Offset: 0x1114
    // Size: 0x13a, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xb3>" + "<dev string:xc2>" );
        
        if ( isdefined( level.radio_signal.var_2a8cf68660ce9c8b ) )
        {
            devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe5>", &function_e83c692de4a1581d );
        }
        
        foreach ( array_index, radio_tower_info in level.radio_signal.var_2b5636ce03c2cafa )
        {
            var_c6cc7e1963a05f88 = radio_tower_info.index;
            devgui::function_cd4e263c1f3018ae( "<dev string:x104>" + var_c6cc7e1963a05f88 + "<dev string:x112>", "<dev string:x122>" + array_index, &function_c09a1a324248229c );
            
            if ( arraycontains( level.radio_signal.var_79286910fa6900c2, radio_tower_info ) )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x104>" + var_c6cc7e1963a05f88 + "<dev string:x138>", "<dev string:x146>" + array_index, &function_7790c516b347ea65 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sierra_sidequest_radio_signal
    // Params 1, eflags: 0x4
    // Checksum 0xc9d61ef8, Offset: 0x1256
    // Size: 0x63, Type: dev
    function private function_c09a1a324248229c( params )
    {
        array_index = int( params[ 0 ] );
        tower_info = level.radio_signal.var_2b5636ce03c2cafa[ array_index ];
        
        if ( isdefined( tower_info ) )
        {
            level.players[ 0 ] setorigin( tower_info.electrical_box_origin );
        }
    }

    // Namespace br_sierra_sidequest_radio_signal
    // Params 1, eflags: 0x4
    // Checksum 0x8e690d34, Offset: 0x12c1
    // Size: 0x53, Type: dev
    function private function_e83c692de4a1581d( params )
    {
        if ( isdefined( level.radio_signal.var_2a8cf68660ce9c8b ) )
        {
            level.players[ 0 ] setorigin( level.radio_signal.var_2a8cf68660ce9c8b.origin );
        }
    }

    // Namespace br_sierra_sidequest_radio_signal
    // Params 1, eflags: 0x4
    // Checksum 0xeef402c3, Offset: 0x131c
    // Size: 0x6e, Type: dev
    function private function_7790c516b347ea65( params )
    {
        array_index = int( params[ 0 ] );
        tower_info = level.radio_signal.var_79286910fa6900c2[ array_index ];
        
        if ( isdefined( tower_info.electrical_box ) )
        {
            tower_info.electrical_box thread function_97dabe4acaf60738( level.players[ 0 ] );
        }
    }

#/
