// scripts\mp\zm\systems\killstreaks\zm_robot_controller.gsc  (hash_4a3f958f74fe194e.gscc) (size: 12149 Bytes / 0x2f75 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9535e50 (3914554960)
// size ...... 12149 (0x2f75)
// includes .. 18  (offset: 0x2c4d)
// strings ... 24  (offset: 0x2cdd)
// dev strs .. 17  (offset: 0x2e95)
// exports ... 37  (offset: 0x1ad9)
// cseg ...... 0x215 + 0x18c4 (0x1ad9)
// imports ... 101 (offset: 0x20a1)
// animtree1 . 0   (offset: 0x2f75)
// animtree2 . 0   (offset: 0x2f75)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\currency;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_robot_controller;

// Namespace zm_robot_controller
// Params 0, eflags: 0x5
// Checksum 0x461af407, Offset: 0x233
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_robot_controller", undefined, &pre_main, undefined );
}

// Namespace zm_robot_controller
// Params 0, eflags: 0x4
// Checksum 0x3249d2c2, Offset: 0x254
// Size: 0x18a
function private pre_main()
{
    if ( level.mapname != "zm_sat_locust" )
    {
        return;
    }
    
    level.robot_controller = [];
    level.robot_controller[ "zm_bernard_primary" ] = { #spawneditems:[], #held_by:[] };
    level.robot_controller[ "zm_bernard_secondary" ] = { #spawneditems:[], #held_by:[] };
    level callback::add( #"player_item_pickup", &function_d30d03976ee63ddf );
    level callback::add( "on_item_cleanup", &function_989e860954bdcc5d );
    level callback::add( "killstreak_equipped", &on_killstreak_equipped );
    level callback::add( #"killstreak_removed", &function_44427cc3d59a1e75 );
    level callback::add( #"player_death", &on_player_death_or_disconnect );
    level callback::add( #"player_disconnect", &on_player_death_or_disconnect );
    common_item::function_c7bbbfcefe78f798( "zm_bernard_primary", &function_b65bc3d97a641707 );
    common_item::function_c7bbbfcefe78f798( "zm_bernard_secondary", &function_b65bc3d97a641707 );
    utility::registersharedfunc( #"zm_robot_controller", #"hash_77d0f357c78c939", &crafting_table_craft_support );
    utility::registersharedfunc( #"zm_robot_controller", #"play_player_banter", &play_player_banter );
    register_banter( #"glocke_multikill", #"hash_234ef59ddd4752ff", 60 );
    register_banter( #"hash_f737622b095ae20e", #"wunderbarrage_multikill", 60 );
    init_action_sets();
    
    /#
        debug_init();
    #/
}

// Namespace zm_robot_controller
// Params 0, eflags: 0x4
// Checksum 0x412a91fe, Offset: 0x3e6
// Size: 0x45
function private init_action_sets()
{
    level.robot_controller_actions = "robot_controller";
    val::group_register( level.robot_controller_actions, [ "offhand_weapons", "melee", "execution_attack", "weapon_pickup" ] );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x43fe4805, Offset: 0x433
// Size: 0x13a
function private function_d30d03976ee63ddf( params )
{
    if ( !( params.itembundle.ref == "zm_bernard_primary" || params.itembundle.ref == "zm_bernard_secondary" ) )
    {
        return;
    }
    
    assert( arraycontains( level.robot_controller[ params.itembundle.ref ].spawneditems, params.item ), params.itembundle.ref + "<dev string:x24>" + params.item.origin );
    level.robot_controller[ params.itembundle.ref ].spawneditems = arrayremove( level.robot_controller[ params.itembundle.ref ].spawneditems, params.item );
    killstreak_update_count( params.itembundle.ref );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0xc6e915c, Offset: 0x575
// Size: 0xec
function private function_989e860954bdcc5d( params )
{
    if ( !params.b_despawn )
    {
        return;
    }
    
    ref = function_1e27fb310f0acc47( params.item.type );
    
    if ( !( ref == "zm_bernard_primary" || ref == "zm_bernard_secondary" ) )
    {
        return;
    }
    
    assert( arraycontains( level.robot_controller[ ref ].spawneditems, params.item ), ref + "<dev string:x46>" + params.item.origin );
    level.robot_controller[ ref ].spawneditems = arrayremove( level.robot_controller[ ref ].spawneditems, params.item );
    killstreak_update_count( ref );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0xed8ffd6f, Offset: 0x669
// Size: 0x80
function private on_killstreak_equipped( params )
{
    function_6542200604ff8405();
    
    if ( !( params.streakname == "zm_bernard_primary" || params.streakname == "zm_bernard_secondary" ) )
    {
        return;
    }
    
    level.robot_controller[ params.streakname ].held_by[ level.robot_controller[ params.streakname ].held_by.size ] = self;
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x6f274bb7, Offset: 0x6f1
// Size: 0xae
function private function_44427cc3d59a1e75( params )
{
    if ( !( params.streakname == "zm_bernard_primary" || params.streakname == "zm_bernard_secondary" ) )
    {
        return;
    }
    
    assert( arraycontains( level.robot_controller[ params.streakname ].held_by, self ) );
    level.robot_controller[ params.streakname ].held_by = arrayremove( level.robot_controller[ params.streakname ].held_by, self );
    function_6542200604ff8405();
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x43e410b1, Offset: 0x7a7
// Size: 0x88
function private function_b65bc3d97a641707( params )
{
    level.robot_controller[ params.itembundle.ref ].spawneditems[ level.robot_controller[ params.itembundle.ref ].spawneditems.size ] = params.item;
    killstreak_update_count( params.itembundle.ref );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x15a0298b, Offset: 0x837
// Size: 0x116
function private on_player_death_or_disconnect( params )
{
    if ( level.robot_controller[ "zm_bernard_primary" ].held_by.size > 0 && arraycontains( level.robot_controller[ "zm_bernard_primary" ].held_by, self ) )
    {
        level.robot_controller[ "zm_bernard_primary" ].held_by = arrayremove( level.robot_controller[ "zm_bernard_primary" ].held_by, self );
        killstreak_update_count( "zm_bernard_primary" );
    }
    
    if ( level.robot_controller[ "zm_bernard_secondary" ].held_by.size > 0 && arraycontains( level.robot_controller[ "zm_bernard_secondary" ].held_by, self ) )
    {
        level.robot_controller[ "zm_bernard_secondary" ].held_by = arrayremove( level.robot_controller[ "zm_bernard_secondary" ].held_by, self );
        killstreak_update_count( "zm_bernard_secondary" );
    }
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x834ab08f, Offset: 0x955
// Size: 0x3b
function private function_de1668f2946386b0( type )
{
    return level.robot_controller[ type ].spawneditems.size + level.robot_controller[ type ].held_by.size;
}

// Namespace zm_robot_controller
// Params 0, eflags: 0x4
// Checksum 0x2e125e06, Offset: 0x999
// Size: 0xae
function private function_6542200604ff8405()
{
    if ( level.robot_controller[ "zm_bernard_primary" ].held_by.size > 0 )
    {
        level.robot_controller[ "zm_bernard_primary" ].held_by = function_46f9072493651dc9( level.robot_controller[ "zm_bernard_primary" ].held_by );
    }
    
    if ( level.robot_controller[ "zm_bernard_secondary" ].held_by.size > 0 )
    {
        level.robot_controller[ "zm_bernard_secondary" ].held_by = function_46f9072493651dc9( level.robot_controller[ "zm_bernard_secondary" ].held_by );
    }
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x7ae996e7, Offset: 0xa4f
// Size: 0x7b
function private killstreak_update_count( type )
{
    count = level.robot_controller[ type ].spawneditems.size + level.robot_controller[ type ].held_by.size;
    omnvar = type == "zm_bernard_primary" ? o"ui_item_bernard_primary_count" : o"ui_item_bernard_secondary_count";
    setomnvar( omnvar, count, 1 );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x9541c83e, Offset: 0xad2
// Size: 0x49
function private function_1e27fb310f0acc47( type )
{
    switch ( type )
    {
        case #"hash_84b3cfc3b0395261":
            return "zm_bernard_primary";
        case #"hash_dc26ecdff8c065d9":
            return "zm_bernard_secondary";
        default:
            return type;
    }
}

// Namespace zm_robot_controller
// Params 2, eflags: 0x4
// Checksum 0x93180e75, Offset: 0xb23
// Size: 0x164
function private crafting_table_craft_support( item, cost )
{
    var_30e3c97dbff58cd1 = 1;
    killstreak_name = item.itemref;
    
    if ( isdefined( level.killstreaksetups[ killstreak_name ] ) )
    {
        var_ff8ad536cc2f2ee8 = killstreaks::getkillstreakinslot( var_30e3c97dbff58cd1 );
        
        if ( isdefined( var_ff8ad536cc2f2ee8 ) && var_ff8ad536cc2f2ee8.available >= item.maxstack )
        {
            if ( killstreak_name == var_ff8ad536cc2f2ee8.streakname )
            {
                return 5;
            }
        }
        
        item_bundle_name = common_item_database::function_a4f0a21951180013( item.itemref );
        
        if ( isdefined( item_bundle_name ) )
        {
            scriptable_name = getscriptbundlefieldvalue( item_bundle_name, #"scriptable" );
            fake_scriptable = { #count:item.itemamount ?? 1, #type:scriptable_name };
            success = common_item::function_2b5e2ff57d5f392( fake_scriptable, 0, 1 );
            
            if ( success )
            {
                currency::function_b5fe1e05c892a7f3( item.currency, cost );
                params = spawnstruct();
                params.item = item;
                params.player = self;
                callback::callback( #"hash_6998a4a69df2653", params );
                return 1;
            }
        }
    }
}

// Namespace zm_robot_controller
// Params 1
// Checksum 0x7fccc7e2, Offset: 0xc8f
// Size: 0x1c5, Type: bool
function controller_use( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    assert( isdefined( streakinfo ) );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        if ( isdefined( level.robot_controller_actions ) )
        {
            streakinfo.var_21f1b0b4d8d3ea8f = level.robot_controller_actions;
        }
        
        deployweaponobj = weapon_utility::function_d2c8356dc369d9ce( streakinfo.bundle.deployweaponname );
        deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweaponobj, "weapon_fired", &function_b3545f2c9e01712e, &function_663c2762b5434bf0, &function_9e2aab35450c7d6f );
        
        if ( !deployresult )
        {
            return false;
        }
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        level thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + streakinfo.streakname, self );
    }
    
    utility::callsharedfunc( #"sound", #"playkillstreakdeploydialog", streakinfo.streakname );
    thread namespace_9d8e359c3b1041e5::playkillstreaktacomdialogsharedfunc( streakinfo, streakinfo.streakname + "_use", #"use", 1, 2 );
    utility::callsharedfunc( #"killstreak", #"logkillstreakevent", streakinfo.streakname, self.origin );
    command_execute( streakinfo );
    return true;
}

// Namespace zm_robot_controller
// Params 3
// Checksum 0x740d651f, Offset: 0xe5d
// Size: 0x2a
function function_8f305741152309b9( streakitem, streakinfo, calledfrom )
{
    self notify( #"hash_b2111037df716fcb" );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0xa2e6ac61, Offset: 0xe8f
// Size: 0x3f
function private command_execute( streakinfo )
{
    thread function_8928db9b248795b1( streakinfo );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0xe6e1b897, Offset: 0xed6
// Size: 0xd6
function private function_8928db9b248795b1( streakinfo )
{
    if ( !isdefined( streakinfo.targetoverride ) )
    {
        assert( streakinfo.tacpoint );
        position = streakinfo.tacpoint.groundpos;
    }
    else
    {
        position = streakinfo.targetoverride;
    }
    
    assert( position );
    params = { #var_c7cc8d9838136fcd:streakinfo.var_c7cc8d9838136fcd, #position:position, #player:self, #streakinfo:streakinfo };
    self thread [[ streakinfo.bundle.callbacks[ "execute" ] ]]( params );
    self notify( #"controller_executed" );
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0xd1964be0, Offset: 0xfb4
// Size: 0x323
function private function_1ae6a099f2c6772a( streakinfo )
{
    trace = function_3bfac9f065d7fbe8( self, undefined, streakinfo.bundle.tacpointdata.contents );
    
    if ( !trace || trace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    pos = trace[ "position" ];
    
    if ( !isdefined( pos ) )
    {
        return;
    }
    
    streakinfo.trace = trace;
    
    if ( trace[ "entity" ] && trace[ "entity" ].var_c7cc8d9838136fcd )
    {
        command_settings = trace[ "entity" ].var_c7cc8d9838136fcd;
        
        if ( !isarray( command_settings.allowable_versions ) || isdefined( function_f02c63b99c9614c9( command_settings.allowable_versions, streakinfo.bundle.version ) ) )
        {
            if ( isfunction( command_settings.var_a2b544087983e9ad ) )
            {
                pos = self [[ command_settings.var_a2b544087983e9ad ]]( streakinfo.trace );
            }
            
            streakinfo.targetoverride = pos;
            streakinfo.var_c7cc8d9838136fcd = trace[ "entity" ].var_c7cc8d9838136fcd;
            return pos;
        }
    }
    
    var_9685d0c2925f3b3a = function_a4a0660084b84def( pos );
    
    if ( !var_9685d0c2925f3b3a )
    {
        return;
    }
    
    if ( !tacpointexposedtosky( var_9685d0c2925f3b3a, 1 ) )
    {
        return;
    }
    
    var_728f6b38f7c14108 = getentitylessscriptablearray( %"sat_ascender_zipline_icon_dynamic_zm" );
    valid_point = undefined;
    tacpoints = function_ed94bdbde6961d29( pos, streakinfo.bundle.tacpointdata.searchradius, var_9685d0c2925f3b3a.navzoneindex, 0 );
    tacpoints = sortbydistance( tacpoints, pos );
    
    foreach ( tacpoint in tacpoints )
    {
        if ( tacpointexposedtosky( tacpoint, 1 ) && trace::capsule_trace_passed( tacpoint.origin, tacpoint.origin, streakinfo.bundle.tacpointdata.radius, streakinfo.bundle.tacpointdata.height, undefined, undefined, streakinfo.bundle.tacpointdata.contents ) && zone_manager::function_65305a611c6226d9( tacpoint.origin ) && !function_b21056d585c710d( var_728f6b38f7c14108, tacpoint.origin, streakinfo.bundle.tacpointdata.radius * 1.25 ) )
        {
            valid_point = tacpoint;
            break;
        }
    }
    
    return valid_point;
}

// Namespace zm_robot_controller
// Params 1, eflags: 0x4
// Checksum 0x93f32f29, Offset: 0x12e0
// Size: 0xe, Type: bool
function private function_b3545f2c9e01712e( streakinfo )
{
    return true;
}

// Namespace zm_robot_controller
// Params 2, eflags: 0x4
// Checksum 0xa747b764, Offset: 0x12f7
// Size: 0x33
function private function_663c2762b5434bf0( streakinfo, switchresult )
{
    if ( switchresult )
    {
        if ( streakinfo.var_41f8a434fae6074f )
        {
            thread function_7ad8afd2c6541af2();
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_robot_controller
// Params 3, eflags: 0x4
// Checksum 0x91a8312c, Offset: 0x1332
// Size: 0xe9
function private function_9e2aab35450c7d6f( streakinfo, firedweaponobj, firedprojectile )
{
    streakinfo.tacpoint = function_1ae6a099f2c6772a( streakinfo );
    
    if ( !isdefined( streakinfo.tacpoint ) )
    {
        hud_message::showerrormessage( %"KILLSTREAKS/INVALID_POINT", undefined, 1 );
        return "continue";
    }
    
    if ( !self [[ streakinfo.bundle.callbacks[ "verify" ] ]]( streakinfo ) )
    {
        return "continue";
    }
    
    if ( utility::issharedfuncdefined( #"zm_robot_controller", #"hash_92958a874adb388f", 0 ) )
    {
        var_ec3446255a7e3fb3 = utility::callsharedfunc( #"zm_robot_controller", #"hash_92958a874adb388f", streakinfo );
        
        if ( var_ec3446255a7e3fb3 )
        {
            hud_message::showerrormessage( var_ec3446255a7e3fb3, undefined, 1 );
            return "continue";
        }
    }
    
    return "success";
}

// Namespace zm_robot_controller
// Params 0, eflags: 0x4
// Checksum 0x8a3ae4c0, Offset: 0x1424
// Size: 0x56
function private function_7ad8afd2c6541af2()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    val::set( #"zm_robot_controller", "weapon_switch" );
    wait 0.75;
    val::reset( #"zm_robot_controller", "weapon_switch" );
    self notify( #"cancel_all_killstreak_deployments" );
}

// Namespace zm_robot_controller
// Params 4
// Checksum 0x8d6c5477, Offset: 0x1482
// Size: 0x7b
function function_3bfac9f065d7fbe8( player, ignoreents, contentoverride, var_2073f210b8fb10a3 = 20000 )
{
    starttrace = player getcamerathirdperson() ? player getcamerathirdpersonorigin() : player getvieworigin();
    endtrace = starttrace + anglestoforward( player getplayerangles() ) * var_2073f210b8fb10a3;
    return trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
}

// Namespace zm_robot_controller
// Params 1
// Checksum 0x63d8b88c, Offset: 0x1506
// Size: 0x3b
function get_controller_total_count( type )
{
    return level.robot_controller[ type ].spawneditems.size + level.robot_controller[ type ].held_by.size;
}

// Namespace zm_robot_controller
// Params 1
// Checksum 0xbddc06c8, Offset: 0x154a
// Size: 0x23
function function_4bcfc4ba304d5959( type )
{
    return level.robot_controller[ type ].held_by.size;
}

// Namespace zm_robot_controller
// Params 3, eflags: 0x4
// Checksum 0x9d117e66, Offset: 0x1576
// Size: 0xb0
function private register_banter( key, var_d9a98ad3b14f016a, cooldown )
{
    data = { #var_2cda4fec82ac854c:0, #cooldown:cooldown, #var_d9a98ad3b14f016a:var_d9a98ad3b14f016a, #key:key };
    
    if ( !isdefined( level.robot_controller[ "banters" ] ) )
    {
        level.robot_controller[ "banters" ] = [];
    }
    
    assert( !level.robot_controller[ "<dev string:x69>" ][ key ], "<dev string:x71>" + key );
    level.robot_controller[ "banters" ][ key ] = data;
}

// Namespace zm_robot_controller
// Params 2
// Checksum 0x18acf28c, Offset: 0x162e
// Size: 0xdc
function play_player_banter( key, player )
{
    if ( !isxhash( key ) )
    {
        key = getxhash( key );
    }
    
    data = level.robot_controller[ "banters" ][ key ];
    assert( data, "<dev string:x8c>" + key );
    
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    if ( !player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    cooldown = data.cooldown;
    
    if ( utility::flag( "solo_game" ) )
    {
        cooldown *= 2;
    }
    
    if ( !utility::time_has_passed( data.var_2cda4fec82ac854c, cooldown ) )
    {
        return;
    }
    
    data.var_2cda4fec82ac854c = gettime();
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( data.var_d9a98ad3b14f016a );
}

/#

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0x8e1eb822, Offset: 0x1712
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0x8a4b909d, Offset: 0x1726
    // Size: 0x5a, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xaa>" );
        devgui::add_devgui_func( "<dev string:xc3>", "<dev string:xdc>", &function_fccb1593da54ed7b );
        devgui::add_devgui_func( "<dev string:xfb>", "<dev string:x116>", &function_158bb790dd4e01d7 );
        devgui::add_devgui_func( "<dev string:x136>", "<dev string:x153>", &function_c366a0b65cb82673 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0xbc7e2a78, Offset: 0x1788
    // Size: 0x17, Type: dev
    function private function_fccb1593da54ed7b()
    {
        level.players[ 0 ] thread function_70a9084b76bcbaa2();
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0x2b55899c, Offset: 0x17a7
    // Size: 0x16f, Type: dev
    function private function_70a9084b76bcbaa2()
    {
        self endon( #"death_or_disconnect", #"weapon_change", #"hash_dbf5e49c24d7fdc8", #"last_stand_enter", #"controller_executed" );
        streakinfo = killstreak_utility::createstreakinfo( "<dev string:x175>", self );
        streakinfo.bundle = level.streakglobals.streakbundles[ "<dev string:x175>" ];
        
        for ( ;; )
        {
            tacpoint = function_1ae6a099f2c6772a( streakinfo );
            
            if ( tacpoint )
            {
                trace = trace::capsule_trace( tacpoint.groundpos, tacpoint.groundpos, streakinfo.bundle.tacpointdata.radius, streakinfo.bundle.tacpointdata.height, undefined, undefined, streakinfo.bundle.tacpointdata.contents, 1 );
                trace::draw_trace( trace, ( 0, 0, 0 ), 1, 1 );
                debug::line( tacpoint.groundpos, tacpoint.groundpos + ( 0, 0, 1024 ), ( 1, 1, 0 ), level.framedurationseconds );
            }
            
            waitframe();
        }
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0xdf2a87f5, Offset: 0x191e
    // Size: 0xd, Type: dev
    function private function_158bb790dd4e01d7()
    {
        level thread function_8d68883a1ed51e9a();
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0x7ac56c8d, Offset: 0x1933
    // Size: 0xc4, Type: dev
    function private function_8d68883a1ed51e9a()
    {
        if ( utility::flag( "<dev string:x180>" ) )
        {
            utility::flag_clear( "<dev string:x180>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x180>" );
        }
        
        level endon( #"hash_b5ebc8d62407f8db" );
        player = level.players[ 0 ];
        streakinfo = killstreak_utility::createstreakinfo( "<dev string:x19b>", player );
        
        while ( true )
        {
            trace = function_3bfac9f065d7fbe8( player, undefined, undefined, streakinfo.bundle.tacpointdata.contents );
            
            if ( trace )
            {
                trace::draw_trace( trace, ( 1, 1, 1 ), 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0xd03dbaff, Offset: 0x19ff
    // Size: 0xd, Type: dev
    function private function_c366a0b65cb82673()
    {
        level thread function_86d9b7ae5aa3b1e6();
    }

    // Namespace zm_robot_controller
    // Params 0, eflags: 0x4
    // Checksum 0x65e9ee96, Offset: 0x1a14
    // Size: 0xc5, Type: dev
    function private function_86d9b7ae5aa3b1e6()
    {
        if ( utility::flag( "<dev string:x1ae>" ) )
        {
            utility::flag_clear( "<dev string:x1ae>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x1ae>" );
        }
        
        level endon( #"hash_622d11585d80e11f" );
        player = level.players[ 0 ];
        streakinfo = killstreak_utility::createstreakinfo( "<dev string:x1cb>", player );
        
        while ( true )
        {
            trace = function_3bfac9f065d7fbe8( player, undefined, undefined, streakinfo.bundle.tacpointdata.contents );
            
            if ( isdefined( trace ) )
            {
                trace::draw_trace( trace, ( 1, 1, 1 ), 1, 1 );
            }
            
            waitframe();
        }
    }

#/
