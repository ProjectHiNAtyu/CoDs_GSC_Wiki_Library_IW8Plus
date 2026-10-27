// scripts\mp\br\gametypes\br_parliament_puzzle.gsc  (hash_642742150894b4a6.gscc) (size: 19804 Bytes / 0x4d5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6957084 (3063246980)
// size ...... 19804 (0x4d5c)
// includes .. 19  (offset: 0x4620)
// strings ... 92  (offset: 0x46b8)
// dev strs .. 4   (offset: 0x4d2c)
// exports ... 43  (offset: 0x3194)
// cseg ...... 0x705 + 0x2a8f (0x3194)
// imports ... 108 (offset: 0x384c)
// animtree1 . 0   (offset: 0x4d5c)
// animtree2 . 0   (offset: 0x4d5c)
#using scripts\common\gas_shared;
#using scripts\common\gasmask;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\interaction;
#using scripts\mp\juggernaut;
#using scripts\mp\playerlogic;

#namespace br_parliament_puzzle;

// Namespace br_parliament_puzzle
// Params 0, eflags: 0x5
// Checksum 0xb89aca57, Offset: 0x723
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"parliament_puzzle", undefined, undefined, &init );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x82206b9b, Offset: 0x744
// Size: 0xb3
function init()
{
    level.var_b1563775541691a3 = getdvarint( @"scr_parliament_puzzle", 1 ) && getdvarint( @"scr_sierra_sidequest_enabled", 1 );
    level.parliament_puzzle = spawnstruct();
    
    if ( level.var_b1563775541691a3 )
    {
        level.parliament_puzzle.hints = [];
        level.parliament_puzzle.placards = [];
        scriptable::scriptable_addusedcallbackbypart( "maphint_computer", &codecomputerscriptableused );
        scriptable::scriptable_addusedcallbackbypart( "subway_station_keypad", &function_3876554c1cc3eb81 );
    }
    
    level._effect[ "vfx_br_traproom_vent_gas_1" ] = loadfxasset( "vfx_iw8_br_gameplay_subway_traproom_vent_gas_1" );
    level thread initpostmain();
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xc6d85a6d, Offset: 0x7ff
// Size: 0x82
function initpostmain()
{
    waittillframeend();
    level thread function_49475c812675260d();
    thread function_5b948d7ef41f9942();
    
    if ( !level.var_b1563775541691a3 )
    {
        function_5b1574bc1d3d2a59();
        return;
    }
    
    level thread function_2caa01430ba9f3f3();
    
    if ( getdvarint( @"hash_c6ba44d48e98b69b", 1 ) )
    {
        level thread br_bunker_utility::function_570a0e83663d22a4( "bunker_staged_reward_parliament_puzzle" );
    }
    
    /#
    #/
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    function_135af515bbaebeb0();
    
    if ( !level.parliament_puzzle.keypadsactivated )
    {
        function_2045c5a065860e8d();
    }
}

// Namespace br_parliament_puzzle
// Params 6
// Checksum 0xb61a3b79, Offset: 0x889
// Size: 0x48
function function_3876554c1cc3eb81( instance, part, state, player, bautouse, usestring )
{
    level thread function_719c5d86875f0550( instance, part, state, player, bautouse );
}

// Namespace br_parliament_puzzle
// Params 5
// Checksum 0xd51f0f94, Offset: 0x8d9
// Size: 0x86
function function_719c5d86875f0550( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( part, "off" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        if ( instance.codestatus == 2 )
        {
            player br_keypad_util::playersetkeypadstateindex( 0 );
            return;
        }
        
        player br_keypad_util::playersetkeypadstateindex( 0 );
        instance setscriptablepartstate( "subway_station_keypad", "on" );
    }
}

// Namespace br_parliament_puzzle
// Params 6
// Checksum 0xd11cafd3, Offset: 0x967
// Size: 0x69
function codecomputerscriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x24>" );
    
    if ( !isdefined( instance.var_d839473b2063e40c ) )
    {
        return;
    }
    
    level thread _codecomputerscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_parliament_puzzle
// Params 5
// Checksum 0xedd69e27, Offset: 0x9d8
// Size: 0x29f
function _codecomputerscriptableused( instance, part, state, player, bautouse )
{
    if ( state == "on" )
    {
        if ( !flags::gameflag( "prematch_done" ) || !level.parliament_puzzle.escaperoomactive )
        {
            playsoundatpos( instance.origin, "br_computer_deny" );
            instance setscriptablepartstate( "maphint_computer", "off" );
            wait 3;
            instance setscriptablepartstate( "maphint_computer", "on" );
            return;
        }
        
        player playerlogic::playerhasmoved();
        instance setscriptablepartstate( "maphint_computer", "off" );
        playsoundatpos( instance.origin, "stadium_computer_code_start" );
        wait 2;
        
        foreach ( screenid in level.parliament_puzzle.pattern )
        {
            if ( !isalive( player ) )
            {
                break;
            }
            
            instance.monitorscriptable setscriptablepartstate( "parliament_code_computer", screenid );
            playsoundatpos( instance.origin, "stadium_computer_code_number" );
            wait 1;
        }
        
        if ( isalive( player ) && player isnearcomputer( instance ) && !player::isinlaststand( player ) )
        {
            scriptable = level.parliament_puzzle.hints[ "escaperoom_terminal_keypad" ].scriptable;
            scriptable.waittilloverride = [ "death", "disconnect" ];
            br_bunker_utility::keypadscriptableused( scriptable, "subway_station_keypad", "on", player );
            instance.monitorscriptable setscriptablepartstate( "parliament_code_computer", "keypad" );
            player utility::waittill_any_return( "doneWithKeypad", "keypad_kickPlayerFromKeypadMSG" );
        }
        
        instance.codestatus = 1;
        playsoundatpos( instance.origin, "stadium_computer_code_end" );
        wait 3;
        instance.monitorscriptable setscriptablepartstate( "parliament_code_computer", "intro" );
        
        if ( level.parliament_puzzle.escaperoomactive )
        {
            instance setscriptablepartstate( "maphint_computer", "on" );
        }
    }
}

// Namespace br_parliament_puzzle
// Params 1, eflags: 0x4
// Checksum 0x27c050aa, Offset: 0xc7f
// Size: 0x27, Type: bool
function private isnearcomputer( parliamentcomputer )
{
    return distance( self.origin, parliamentcomputer.origin ) < 80;
}

// Namespace br_parliament_puzzle
// Params 1, eflags: 0x4
// Checksum 0xe7ccde67, Offset: 0xcaf
// Size: 0xc7
function private function_a17ff6c36db262a3( state )
{
    foreach ( var_15b5ff35a1493d49 in level.parliament_puzzle.var_87d7cf1b411a68e )
    {
        if ( state == "delete" )
        {
            var_15b5ff35a1493d49 freescriptable();
            continue;
        }
        
        var_15b5ff35a1493d49 setscriptablepartstate( "base", state );
    }
    
    if ( state == "delete" )
    {
        level.parliament_puzzle.var_87d7cf1b411a68e = undefined;
    }
}

// Namespace br_parliament_puzzle
// Params 0, eflags: 0x4
// Checksum 0x12f8f34, Offset: 0xd7e
// Size: 0xc0
function private function_886240c77a41fd3a()
{
    if ( getdvarint( @"hash_325ab39aa939a8c5", 0 ) )
    {
        return;
    }
    
    origin = level.parliament_puzzle.buildingtrigger.origin;
    radius = 15;
    trigger = spawn( "trigger_radius", origin, 0, radius, 0 );
    trigger.radius = radius;
    trigger endon( #"death" );
    level.parliament_puzzle.trigger = trigger;
    
    if ( !isdefined( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = [];
    }
    
    level.var_9f723c1b2e8c3484[ level.var_9f723c1b2e8c3484.size ] = trigger;
}

// Namespace br_parliament_puzzle
// Params 0, eflags: 0x4
// Checksum 0x2bf2aba5, Offset: 0xe46
// Size: 0x52
function private function_118413ad78e6869e()
{
    if ( getdvarint( @"hash_325ab39aa939a8c5", 0 ) )
    {
        return;
    }
    
    level.parliament_puzzle.trigger delete();
    
    if ( isarray( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = function_5713d46873b29625( level.var_9f723c1b2e8c3484 );
    }
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0x6a47ca5e, Offset: 0xea0
// Size: 0x26
function function_cfc1202177142c15( instance )
{
    self dlog_recordplayerevent( "dlog_event_subway_station_numpad_tried", [ "succeeded", 0 ] );
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0x62cf0e16, Offset: 0xece
// Size: 0x342
function function_b46e5fca98dd61e7( instance )
{
    level notify( #"parliament_puzzle_solved" );
    level notify( "closing_door_canceled" + "_subway_station" );
    playsoundatpos( instance.origin, "br_phone_code_correct" );
    function_707d75736d7c5efe();
    function_118413ad78e6869e();
    utility::stop_exploder( "gas_stage_1" );
    utility::stop_exploder( "gas_stage_2" );
    level.parliament_puzzle.escaperoomactive = 0;
    
    if ( !isdefined( level.parliament_puzzle.var_32df03b5ac4add5a ) )
    {
        level.parliament_puzzle.var_32df03b5ac4add5a = [];
    }
    
    level.parliament_puzzle.var_32df03b5ac4add5a[ level.parliament_puzzle.var_32df03b5ac4add5a.size ] = self.team;
    level.parliament_puzzle.buildingtrigger notify( #"hash_73537c07898a047a" );
    br_bunker_utility::unlockscriptabledoors( instance );
    function_a17ff6c36db262a3( "delete" );
    instance.codestatus = 2;
    var_1ada0ec690809ce1 = level.parliament_puzzle.doorbutton.scriptable;
    var_1ada0ec690809ce1.interact = interaction::register_scriptable_interact( var_1ada0ec690809ce1, &function_d721ed5e168394eb, undefined, undefined, undefined );
    var_1ada0ec690809ce1.interact disableplayeruseforallplayers();
    
    foreach ( team in level.parliament_puzzle.var_32df03b5ac4add5a )
    {
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            var_1ada0ec690809ce1.interact enableplayeruse( player );
        }
    }
    
    var_1ada0ec690809ce1 setscriptablepartstate( "base", "on" );
    terminalscriptable = level.parliament_puzzle.hints[ "maphint_parliament_terminal" ].scriptable;
    monitorscriptable = terminalscriptable.monitorscriptable;
    monitorscriptable setscriptablepartstate( "parliament_code_computer", "overauthorized" );
    
    foreach ( player in level.parliament_puzzle.var_bbe9a5ac548e5208 )
    {
        function_34bcb3187054701( player );
    }
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0x920e7002, Offset: 0x1218
// Size: 0x16a
function function_d721ed5e168394eb( player )
{
    if ( arraycontains( level.parliament_puzzle.var_32df03b5ac4add5a, player.team ) )
    {
        level.parliament_puzzle.doorbutton.scriptable setscriptablepartstate( "base", "success" );
        
        foreach ( index, doorpart in level.parliament_puzzle.doorparts )
        {
            doorindex = index + 1;
            doorpart setscriptablepartstate( "base", "sierra_qwe_rollup_gate_section_" + doorindex + "_open" );
        }
        
        function_7bf6390bc89a2323();
        player dlog_recordplayerevent( "dlog_event_subway_station_completion", [ "succeeded", 1 ] );
        points::function_40522c040a4e7b1( player.team, #"hash_ae0a5890dc701785" );
        challenges::function_37e945722d6497f3( player, "sierra_sidequest_14", 1, 1 );
        return;
    }
    
    player [[ level.showerrormessagefunc ]]( %"hash_609b5d1af7f830c3" );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x94edb95, Offset: 0x138a
// Size: 0x232
function function_49475c812675260d()
{
    locs = utility::getstructarray( "placard_holmes", "targetname" );
    level.parliament_puzzle.placards[ "holmes" ] = locs;
    locs = utility::getstructarray( "placard_whitehouse", "targetname" );
    level.parliament_puzzle.placards[ "whitehouse" ] = locs;
    locs = utility::getstructarray( "placard_blackhouse", "targetname" );
    level.parliament_puzzle.placards[ "blackhouse" ] = locs;
    locs = utility::getstructarray( "placard_daryl", "targetname" );
    level.parliament_puzzle.placards[ "daryl" ] = locs;
    locs = utility::getstructarray( "placard_horse", "targetname" );
    level.parliament_puzzle.placards[ "horse" ] = locs;
    locs = utility::getstructarray( "placard_tinyhouse", "targetname" );
    level.parliament_puzzle.placards[ "tinyhouse" ] = locs;
    locs = utility::getstructarray( "placard_franz", "targetname" );
    level.parliament_puzzle.placards[ "jolyon" ] = locs;
    locs = utility::getstructarray( "placard_missing", "targetname" );
    level.parliament_puzzle.placards[ "blank" ] = locs;
    level.parliament_puzzle.buildingtrigger = getent( "parliament_interior_trigger", #targetname );
    level.parliament_puzzle.doornode = utility::getstruct( "parliament_door", "targetname" );
    level.parliament_puzzle.keypad = utility::getstruct( "maphint_keypad_escaperoom_lock", "targetname" );
    level.parliament_puzzle.terminal = utility::getstruct( "maphint_parliament_terminal", "targetname" );
    level.parliament_puzzle.var_82e30c4150fe2cf4 = utility::getstruct( "parliament_terminal_monitor", "targetname" );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x3f24584d, Offset: 0x15c4
// Size: 0x9b
function function_2caa01430ba9f3f3()
{
    doorbutton = utility::getstruct( "secret_subway_button", "script_noteworthy" );
    level.parliament_puzzle.doorbutton = doorbutton;
    doorparts = [];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        doorpart = getentitylessscriptablearray( "secret_subway_door_" + i, "script_noteworthy" );
        
        if ( doorpart.size > 0 )
        {
            doorparts[ doorparts.size ] = doorpart[ 0 ];
        }
    }
    
    level.parliament_puzzle.doorparts = doorparts;
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x601ae69, Offset: 0x1667
// Size: 0x66
function function_135af515bbaebeb0()
{
    doorbutton = level.parliament_puzzle.doorbutton;
    doorbutton.scriptable = spawnscriptable( "quest_wz_subway_station_button", doorbutton.origin, doorbutton.angles );
    doorbutton.scriptable setscriptablepartstate( "base", "locked" );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xf0377874, Offset: 0x16d5
// Size: 0x4bb
function function_2045c5a065860e8d()
{
    doornode = level.parliament_puzzle.doornode;
    doors = getentitylessscriptablearray( doornode.target, #targetname );
    keypad = level.parliament_puzzle.keypad;
    keypad.scriptable = spawnscriptable( "subway_station_keypad", keypad.origin );
    keypad.scriptable.name = "escaperoom_start_keypad";
    keypad.scriptable.code = [];
    keypad.scriptable.code[ "string" ] = "2179";
    keypad.scriptable.code[ "array" ] = [ 2, 1, 7, 9 ];
    keypad.scriptable.script_codelength = 4;
    keypad.scriptable.successfunction = &function_1a8ed9c7860dd63;
    keypad.scriptable.failfunction = &function_cfc1202177142c15;
    keypad.scriptable.doors = doors;
    level.parliament_puzzle.hints[ "escaperoom_start_keypad" ] = keypad;
    var_87d7cf1b411a68e = [];
    
    foreach ( door in doors )
    {
        var_15b5ff35a1493d49 = spawnscriptable( "t10_door_collision_only", door.origin, door.angles );
        var_15b5ff35a1493d49 setscriptablepartstate( "base", "disable" );
        var_87d7cf1b411a68e[ var_87d7cf1b411a68e.size ] = var_15b5ff35a1493d49;
    }
    
    level.parliament_puzzle.var_87d7cf1b411a68e = var_87d7cf1b411a68e;
    origin = level.parliament_puzzle.hints[ "escaperoom_start_keypad" ].origin;
    endkeypad = spawnstruct();
    endkeypad.scriptable = spawnscriptable( "subway_station_keypad", ( 0, 0, 0 ) );
    endkeypad.scriptable.name = "escaperoom_terminal_keypad";
    endkeypad.scriptable.code = [];
    endkeypad.scriptable.script_codelength = 4;
    endkeypad.scriptable.doors = doors;
    endkeypad.scriptable setscriptablepartstate( "subway_station_keypad", "off" );
    level.parliament_puzzle.hints[ "escaperoom_terminal_keypad" ] = endkeypad;
    terminal = level.parliament_puzzle.terminal;
    terminal.scriptable = spawnscriptable( "maphint_computer", terminal.origin, terminal.angles );
    terminal.scriptable setscriptablepartstate( "maphint_computer", "off" );
    terminal.scriptable.var_d839473b2063e40c = 1;
    terminal.scriptable.keypad = level.parliament_puzzle.hints[ "escaperoom_terminal_keypad" ].scriptable;
    terminal.scriptable.codestatus = 1;
    var_82e30c4150fe2cf4 = level.parliament_puzzle.var_82e30c4150fe2cf4;
    terminal.scriptable.monitorscriptable = spawnscriptable( "parliament_code_computer", var_82e30c4150fe2cf4.origin, var_82e30c4150fe2cf4.angles );
    terminal.scriptable.monitorscriptable setscriptablepartstate( "parliament_code_computer", "off" );
    level.parliament_puzzle.hints[ "maphint_parliament_terminal" ] = terminal;
    level.parliament_puzzle.keypadsactivated = 1;
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x9b269cb, Offset: 0x1b98
// Size: 0x58
function function_5b1574bc1d3d2a59()
{
    keypad = utility::getstruct( "maphint_keypad_escaperoom_lock", "targetname" );
    keypad.scriptable = spawnscriptable( "subway_station_keypad", keypad.origin );
    keypad.scriptable setscriptablepartstate( "subway_station_keypad", "disabled" );
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0xdd804ff6, Offset: 0x1bf8
// Size: 0xbd
function function_1a8ed9c7860dd63( instance )
{
    self dlog_recordplayerevent( "dlog_event_subway_station_numpad_tried", [ "succeeded", 1 ] );
    level.parliament_puzzle.hints[ "escaperoom_start_keypad" ].scriptable setscriptablepartstate( "subway_station_keypad", "off" );
    level.parliament_puzzle.escaperoomactive = 1;
    level notify( "closing_door_canceled" + "_subway_station" );
    function_a17ff6c36db262a3( "enable" );
    br_bunker_utility::closescriptabledoors( instance, 1, "_subway_station" );
    thread function_cbc9c7fcf92a3a4();
    generatecode();
    function_63ed35b0ba4d0399();
    function_40d5f136b4060e78();
    level thread function_52bc29050f58ee3e();
}

// Namespace br_parliament_puzzle
// Params 0, eflags: 0x4
// Checksum 0x720de240, Offset: 0x1cbd
// Size: 0x123
function private function_cbc9c7fcf92a3a4()
{
    level endon( #"parliament_puzzle_solved" );
    wait 2;
    level.parliament_puzzle.var_bbe9a5ac548e5208 = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player istouching( level.parliament_puzzle.buildingtrigger ) )
        {
            level.parliament_puzzle.var_bbe9a5ac548e5208[ level.parliament_puzzle.var_bbe9a5ac548e5208.size ] = player;
            player thread function_4a89925948fd31ba();
        }
    }
    
    level notify( #"hash_13d3fdeea8d2c3ae" );
    trigger::makeenterexittrigger( level.parliament_puzzle.buildingtrigger, &function_4c6242c8e3089a54, undefined, undefined, undefined, &function_6cde941dc1f1024f );
}

// Namespace br_parliament_puzzle
// Params 2
// Checksum 0xcff5e848, Offset: 0x1de8
// Size: 0x47
function function_6cde941dc1f1024f( entity, trigger )
{
    var_b314649691b7da7 = !isplayer( entity ) || arraycontains( level.parliament_puzzle.var_bbe9a5ac548e5208, entity );
    return var_b314649691b7da7;
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x46f3d019, Offset: 0x1e38
// Size: 0xf6
function function_52bc29050f58ee3e()
{
    level endon( #"parliament_puzzle_solved" );
    level endon( #"parliament_puzzle_failed" );
    level.parliament_puzzle.hints[ "maphint_parliament_terminal" ].scriptable setscriptablepartstate( "maphint_computer", "on" );
    level.parliament_puzzle.hints[ "maphint_parliament_terminal" ].scriptable.monitorscriptable setscriptablepartstate( "parliament_code_computer", "keypad" );
    var_8b197bb223683e01 = getdvarint( @"scr_parliament_puzzle_time", 90 );
    level thread function_9758a1fb3c160a2c();
    self waittill( #"hash_13d3fdeea8d2c3ae" );
    utility::exploder( "gas_stage_1" );
    level thread function_9758a1fb3c160a2c();
    wait var_8b197bb223683e01;
    utility::stop_exploder( "gas_stage_1" );
    utility::exploder( "gas_stage_2" );
    function_886240c77a41fd3a();
    level thread function_ecdd4a4a107d3353();
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x2650df10, Offset: 0x1f36
// Size: 0x18d
function resetpuzzle()
{
    function_118413ad78e6869e();
    
    if ( !level.parliament_puzzle.escaperoomactive )
    {
        return;
    }
    
    level notify( "closing_door_canceled" + "_subway_station" );
    level.parliament_puzzle.escaperoomactive = 0;
    utility::stop_exploder( "gas_stage_1" );
    utility::stop_exploder( "gas_stage_2" );
    level notify( #"parliament_puzzle_failed" );
    level.parliament_puzzle.buildingtrigger notify( #"hash_73537c07898a047a" );
    br_bunker_utility::unlockscriptabledoors( level.parliament_puzzle.hints[ "escaperoom_start_keypad" ].scriptable );
    br_bunker_utility::openscriptabledoors( level.parliament_puzzle.hints[ "escaperoom_start_keypad" ].scriptable );
    function_a17ff6c36db262a3( "disable" );
    function_875191d6d36a2d48();
    level.parliament_puzzle.hints[ "escaperoom_start_keypad" ].scriptable setscriptablepartstate( "subway_station_keypad", "on" );
    level.parliament_puzzle.hints[ "maphint_parliament_terminal" ].scriptable setscriptablepartstate( "maphint_computer", "off" );
    level.parliament_puzzle.hints[ "maphint_parliament_terminal" ].scriptable.monitorscriptable setscriptablepartstate( "parliament_code_computer", "off" );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xd8e80754, Offset: 0x20cb
// Size: 0x1c1
function function_40d5f136b4060e78()
{
    assignedkeys = getarraykeys( level.parliament_puzzle.var_8511fe31ac451fc2 );
    placardkeys = getarraykeys( level.parliament_puzzle.placards );
    
    foreach ( key in placardkeys )
    {
        foreach ( loc in level.parliament_puzzle.placards[ key ] )
        {
            angles = loc.angles + ( 0, 180, 0 );
            
            if ( !isdefined( loc.scriptable ) )
            {
                loc.scriptable = spawnscriptable( "parliament_placard", loc.origin, angles );
            }
            
            loc.scriptable setscriptablepartstate( "parliament_placard", arraycontains( assignedkeys, key ) ? level.parliament_puzzle.var_8511fe31ac451fc2[ key ] : "num" + randomintrange( 1, 10 ) );
        }
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x7515be75, Offset: 0x2294
// Size: 0xfd
function function_875191d6d36a2d48()
{
    foreach ( placardgroup in level.parliament_puzzle.placards )
    {
        foreach ( loc in placardgroup )
        {
            loc.scriptable setscriptablepartstate( "parliament_placard", "blank" );
        }
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xe0813094, Offset: 0x2399
// Size: 0x1e2
function generatecode()
{
    terminalkeypad = level.parliament_puzzle.hints[ "escaperoom_terminal_keypad" ].scriptable;
    terminalkeypad.code = [];
    terminalkeypad.code[ "number_part" ] = [];
    terminalkeypad.code[ "string" ] = "";
    var_a71c2fdfce19230a = [ 2, 3, 4, 5, 7, 8 ];
    var_a71c2fdfce19230a = arrayrandomize( var_a71c2fdfce19230a );
    codearray = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        codearray[ i ] = var_a71c2fdfce19230a[ i ];
    }
    
    /#
        if ( getdvarint( @"hash_79c635654db0d0e" ) == 1 )
        {
            codearray = [ 2, 3, 4, 5 ];
        }
    #/
    
    terminalkeypad.code[ "player_facing" ] = codearray;
    terminalkeypad.code[ "array" ] = codearray;
    
    foreach ( num in terminalkeypad.code[ "array" ] )
    {
        newstring = string( num );
        terminalkeypad.code[ "string" ] = terminalkeypad.code[ "string" ] + newstring;
    }
    
    terminalkeypad.successfunction = &function_b46e5fca98dd61e7;
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x3ad37d94, Offset: 0x2583
// Size: 0x257
function function_63ed35b0ba4d0399()
{
    terminalkeypad = level.parliament_puzzle.hints[ "escaperoom_terminal_keypad" ].scriptable;
    level.parliament_puzzle.pattern = [];
    level.parliament_puzzle.var_8511fe31ac451fc2 = [];
    remainingpaintings = getarraykeys( level.parliament_puzzle.placards );
    remainingpaintings = arrayrandomize( remainingpaintings );
    
    foreach ( number in terminalkeypad.code[ "player_facing" ] )
    {
        level.parliament_puzzle.pattern[ level.parliament_puzzle.pattern.size ] = remainingpaintings[ 0 ];
        var_fd5671b00ce58c3 = number - 3 < 1 ? 1 : number - 3;
        var_235174366067fe09 = number + 3 > 10 ? 10 : number + 3;
        placardnumber = randomintrange( var_fd5671b00ce58c3, var_235174366067fe09 );
        level.parliament_puzzle.var_8511fe31ac451fc2[ remainingpaintings[ 0 ] ] = "num" + placardnumber;
        offset = number - placardnumber;
        
        if ( offset < 0 )
        {
            level.parliament_puzzle.pattern[ level.parliament_puzzle.pattern.size ] = "minus" + int( abs( offset ) );
        }
        else if ( offset > 0 )
        {
            level.parliament_puzzle.pattern[ level.parliament_puzzle.pattern.size ] = "add" + offset;
        }
        
        level.parliament_puzzle.pattern[ level.parliament_puzzle.pattern.size ] = "stop";
        remainingpaintings = arrayremove( remainingpaintings, remainingpaintings[ 0 ] );
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xb2baeacc, Offset: 0x27e2
// Size: 0x1a8
function function_ecdd4a4a107d3353()
{
    level endon( #"game_ended" );
    level endon( #"parliament_puzzle_solved" );
    level endon( #"parliament_puzzle_failed" );
    
    while ( true )
    {
        damagetick = 9;
        
        foreach ( player in level.parliament_puzzle.var_bbe9a5ac548e5208 )
        {
            if ( player gas_shared::function_363477bc8bd88260() )
            {
                function_34bcb3187054701( player );
                continue;
            }
            
            function_d51bee9a762caee0( player );
            
            if ( gasmask::function_a062bf98847b605a( player ) )
            {
                player [[ level.var_548004405d16dcf8 ]]( "parliament_puzzle" );
                player gasmask::processdamage( damagetick );
                continue;
            }
            
            if ( gasmask::hasgasmask( player ) )
            {
                player [[ level.var_7518fcc73a6d4676 ]]( "parliament_puzzle" );
            }
            
            if ( isdefined( level.modifybrgasdamage ) )
            {
                damagetick = player [[ level.modifybrgasdamage ]]( damagetick );
            }
            
            if ( player killstreak::isjuggernaut() )
            {
                damagetick = juggernaut::function_9d3c45be0af60321( damagetick );
            }
            
            var_6fcad77df93a5f4b = player.var_8ee8efc2c797c4a ?? 0;
            damagetick *= 1 + var_6fcad77df93a5f4b;
            player dodamage( damagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            player armor::damagearmor( damagetick );
            player br_circle::tryplaycoughaudio();
        }
        
        wait 1;
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xb2e6510e, Offset: 0x2992
// Size: 0xdf
function function_9758a1fb3c160a2c()
{
    level endon( #"game_ended" );
    level endon( #"parliament_puzzle_solved" );
    level endon( #"parliament_puzzle_failed" );
    self waittill( #"hash_13d3fdeea8d2c3ae" );
    
    foreach ( player in level.parliament_puzzle.var_bbe9a5ac548e5208 )
    {
        if ( !( !( isdefined( player ) && isdefined( player.origin ) ) || !isalive( player ) ) )
        {
            pbgpostfxbundlestart( player, %"cer_mp_wz2_sierra_ee_s3_gas_city_hall" );
        }
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x5f817d08, Offset: 0x2a79
// Size: 0x8c
function function_707d75736d7c5efe()
{
    foreach ( player in level.parliament_puzzle.var_bbe9a5ac548e5208 )
    {
        pbgpostfxbundlekill( player, %"cer_mp_wz2_sierra_ee_s3_gas_city_hall" );
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0x73cb646a, Offset: 0x2b0d
// Size: 0xae
function function_4a89925948fd31ba()
{
    level endon( #"game_ended" );
    level endon( #"parliament_puzzle_solved" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        function_34bcb3187054701( self );
        level.parliament_puzzle.var_bbe9a5ac548e5208 = arrayremove( level.parliament_puzzle.var_bbe9a5ac548e5208, self );
    }
    else
    {
        level.parliament_puzzle.var_bbe9a5ac548e5208 = function_5713d46873b29625( level.parliament_puzzle.var_bbe9a5ac548e5208 );
    }
    
    if ( level.parliament_puzzle.var_bbe9a5ac548e5208.size == 0 )
    {
        resetpuzzle();
    }
}

// Namespace br_parliament_puzzle
// Params 1, eflags: 0x4
// Checksum 0x55cba6c3, Offset: 0x2bc3
// Size: 0x34
function private function_d51bee9a762caee0( player )
{
    if ( player.var_a7d90dea0d5e6ba2 )
    {
        return;
    }
    
    player.var_a7d90dea0d5e6ba2 = 1;
    player function_fba41d07fb2b105a( 1 );
}

// Namespace br_parliament_puzzle
// Params 1, eflags: 0x4
// Checksum 0xf8c41ad3, Offset: 0x2bff
// Size: 0x33
function private function_34bcb3187054701( player )
{
    if ( !player.var_a7d90dea0d5e6ba2 )
    {
        return;
    }
    
    player.var_a7d90dea0d5e6ba2 = 0;
    player function_fba41d07fb2b105a( 0 );
}

// Namespace br_parliament_puzzle
// Params 1, eflags: 0x4
// Checksum 0xd2d9a324, Offset: 0x2c3a
// Size: 0x19
function private function_fba41d07fb2b105a( isingas )
{
    self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", isingas );
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xbc32e9f9, Offset: 0x2c5b
// Size: 0xf1
function function_5b948d7ef41f9942()
{
    triggerarray = getnoentvolumearray( "kt_sidequest_14", #targetname );
    
    foreach ( trigger in triggerarray )
    {
        if ( isdefined( trigger ) )
        {
            if ( !isdefined( level.parliament_puzzle.killtriggers ) )
            {
                level.parliament_puzzle.killtriggers = [];
            }
            
            level.parliament_puzzle.killtriggers[ level.parliament_puzzle.killtriggers.size ] = trigger;
            trigger::makeenterexittrigger( trigger, &function_4c6242c8e3089a54 );
        }
    }
}

// Namespace br_parliament_puzzle
// Params 2
// Checksum 0x85e54d72, Offset: 0x2d54
// Size: 0x25
function function_4c6242c8e3089a54( player, killtrigger )
{
    if ( isplayer( player ) )
    {
        player kill();
    }
}

// Namespace br_parliament_puzzle
// Params 0
// Checksum 0xb83be8cb, Offset: 0x2d81
// Size: 0x89
function function_7bf6390bc89a2323()
{
    foreach ( trigger in level.parliament_puzzle.killtriggers )
    {
        trigger notify( #"hash_73537c07898a047a" );
    }
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0x6feda54, Offset: 0x2e12
// Size: 0x4e
function showdebugresult( resulttext )
{
    timeshown = 0;
    
    while ( timeshown < 5 )
    {
        /#
            printtoscreen2d( 500, 500, resulttext, ( 1, 1, 1 ), 1 );
        #/
        
        waitframe();
        timeshown += 0.05;
    }
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0x9e29607c, Offset: 0x2e68
// Size: 0x128
function debug_printcode( codestruct )
{
    level notify( #"hash_b8a65bbbbf4aa8d2" );
    level endon( #"hash_b8a65bbbbf4aa8d2" );
    numberspacing = 10;
    
    while ( true )
    {
        /#
            printtoscreen2d( 500, 100, "<dev string:x35>", ( 1, 1, 1 ), 1 );
        #/
        
        if ( !flags::gameflag( "prematch_done" ) )
        {
            /#
                printtoscreen2d( 600, 100, "<dev string:x4e>", ( 1, 1, 1 ), 1 );
            #/
        }
        else
        {
            foreach ( i, number in codestruct.code[ "array" ] )
            {
                /#
                    printtoscreen2d( 700 + numberspacing * i, 100, number, ( 1, 1, 1 ), 1 );
                #/
            }
        }
        
        waitframe();
    }
}

// Namespace br_parliament_puzzle
// Params 1
// Checksum 0xd78f37e6, Offset: 0x2f98
// Size: 0x190
function computer_debugtestloop( scriptable )
{
    while ( true )
    {
        scriptable setscriptablepartstate( "parliament_code_computer", "intro" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "blackhouse" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "blank" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "daryl" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "holmes" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "horse" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "jolyon" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "tinyhouse" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "whitehouse" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "keypad" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "overauthorized" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "add1" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "add2" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "add3" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "minus1" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "minus2" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "minus3" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "stop" );
        wait 1;
        scriptable setscriptablepartstate( "parliament_code_computer", "off" );
        wait 1;
    }
}

// Namespace br_parliament_puzzle
// Params 2
// Checksum 0xbc14dd2c, Offset: 0x3130
// Size: 0x64
function debug_show2dvotext( text, time )
{
    if ( false )
    {
        return;
    }
    
    curtime = 0;
    
    while ( curtime < time )
    {
        /#
            printtoscreen2d( 500, 350, "<dev string:x67>" + text, ( 1, 1, 1 ), 1.5 );
        #/
        
        waitframe();
        curtime += 0.05;
    }
}

