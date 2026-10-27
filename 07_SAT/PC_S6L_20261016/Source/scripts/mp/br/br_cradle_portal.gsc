// scripts\mp\br\br_cradle_portal.gsc  (hash_38641523154d0560.gscc) (size: 13652 Bytes / 0x3554 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa71e1c3 (4201767363)
// size ...... 13652 (0x3554)
// includes .. 14  (offset: 0x3164)
// strings ... 47  (offset: 0x31d4)
// dev strs .. 12  (offset: 0x34bc)
// exports ... 36  (offset: 0x1eb8)
// cseg ...... 0x4bf + 0x19f9 (0x1eb8)
// imports ... 110 (offset: 0x2458)
// animtree1 . 0   (offset: 0x3554)
// animtree2 . 0   (offset: 0x3554)
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\interact_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\interaction;
#using scripts\mp\poi;

#namespace br_cradle_portal;

// Namespace br_cradle_portal
// Params 0, eflags: 0x5
// Checksum 0x80409ec9, Offset: 0x4dd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"br_cradle_portal", #"br_map_quest", &pre_main, undefined );
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0xacac4a34, Offset: 0x506
// Size: 0x5e
function private pre_main()
{
    quest = { #on_game_ended:&on_game_ended, #on_circle_tick:&on_circle_tick, #on_infil:&on_infil, #on_init:&on_init, #name:"cradle_portal" };
    br_map_quest::register( quest );
}

// Namespace br_cradle_portal
// Params 0
// Checksum 0xb93d5af8, Offset: 0x56c
// Size: 0x2a8
function on_init()
{
    function_92adcbd5e1bc49a7();
    var_af83aee3a5a7e2de = level.poi_regions_names;
    var_a9b9c73b390e6906 = strtok( br_map_quest::get_setting( "portal_destination_ignored_poi" ), " " );
    var_b9f8c75c0d2fdce6 = [];
    
    foreach ( poiid, poiname in var_af83aee3a5a7e2de )
    {
        if ( !arraycontains( var_a9b9c73b390e6906, poiname ) )
        {
            var_b9f8c75c0d2fdce6[ poiid ] = poiname;
        }
    }
    
    var_a56e1650b43140be = level.poi_regions;
    var_7c9add284d8bd094 = [];
    
    foreach ( sitename, regionid in var_a56e1650b43140be )
    {
        if ( var_b9f8c75c0d2fdce6[ regionid ] )
        {
            var_7c9add284d8bd094[ var_7c9add284d8bd094.size ] = sitename;
        }
    }
    
    self.destinationarray = var_7c9add284d8bd094;
    self.portalarray = utility::getstructarray( "cradle_portal", "targetname" );
    self.portalclusters = [];
    
    foreach ( portal in self.portalarray )
    {
        if ( !isdefined( self.portalclusters[ portal.script_noteworthy ?? "default" ] ) )
        {
            self.portalclusters[ portal.script_noteworthy ?? "default" ] = [];
        }
        
        self.portalclusters[ portal.script_noteworthy ?? "default" ][ self.portalclusters[ portal.script_noteworthy ?? "default" ].size ] = portal;
    }
    
    level._effect[ "vfx_sat_gameplay_character_spawn_fjord_cracks_smoke" ] = loadfxasset( "vfx_sat_gameplay_character_spawn_fjord_cracks_smoke" );
    level._effect[ "vfx_sat_gameplay_character_spawn_fjord_cracks_screen_smoke" ] = loadfxasset( "vfx_sat_gameplay_character_spawn_fjord_cracks_screen_smoke" );
    
    /#
        debug_init();
    #/
}

// Namespace br_cradle_portal
// Params 0
// Checksum 0xd006f162, Offset: 0x81c
// Size: 0x9
function on_infil()
{
    thread function_86a9c40e40a5a0c1();
}

// Namespace br_cradle_portal
// Params 0
// Checksum 0x9112c153, Offset: 0x82d
// Size: 0x9
function on_circle_tick()
{
    function_fb067cbae38328a0();
}

// Namespace br_cradle_portal
// Params 0
// Checksum 0x3ecc6cf8, Offset: 0x83e
// Size: 0x9
function on_game_ended()
{
    function_465ea2a8ef0c8d3d();
}

// Namespace br_cradle_portal
// Params 0
// Checksum 0xd79e94f7, Offset: 0x84f
// Size: 0x20e
function function_92adcbd5e1bc49a7()
{
    var_a4e5415e0b3d3f7f = getscriptbundlenames( "cradleportalsettings" );
    var_e03a2ccf8f922b58 = "";
    
    if ( var_a4e5415e0b3d3f7f[ 0 ] && var_a4e5415e0b3d3f7f.size == 1 )
    {
        cradleportalsettings = getscriptbundle( var_a4e5415e0b3d3f7f[ 0 ] );
        
        foreach ( ignoredpoi in cradleportalsettings.ignoredpois )
        {
            var_e03a2ccf8f922b58 += ignoredpoi.var_40b8e418f3f57eef + " ";
        }
    }
    else if ( var_a4e5415e0b3d3f7f.size > 1 )
    {
        throw( "Too many cradleportalsettings assets loaded for the map. Need only 1." );
    }
    
    br_map_quest::add_setting( "portal_spawn_chance", cradleportalsettings.spawnchance ?? 100 );
    br_map_quest::add_setting( "portal_spawn_cooldown", cradleportalsettings.var_fba0c0a7b3a836aa ?? 60 );
    br_map_quest::add_setting( "portal_open_duration", cradleportalsettings.var_88d45c4c9e41bd94 ?? 60 );
    br_map_quest::add_setting( "teleport_height", cradleportalsettings.teleportheight ?? 10000 );
    br_map_quest::add_setting( "teleport_offset_radius", cradleportalsettings.teleportoffset ?? 1024 );
    br_map_quest::add_setting( "portal_safe_radius_from_gas", cradleportalsettings.saferadius ?? 1000 );
    br_map_quest::add_setting( "max_portals_per_location", cradleportalsettings.var_8fa8038e007cae2 ?? 3 );
    br_map_quest::add_setting( "max_clusters", cradleportalsettings.var_acdac4c5b877e60d ?? 4 );
    br_map_quest::add_setting( "portal_destination_ignored_poi", var_e03a2ccf8f922b58 );
    br_map_quest::add_setting( "circle_index_to_stop_spawn", cradleportalsettings.var_e74c6bd45c938962 ?? 0 );
    br_map_quest::add_setting( "challenge_name", cradleportalsettings.challengename ?? "" );
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0x96088203, Offset: 0xa65
// Size: 0x9c
function private function_86a9c40e40a5a0c1()
{
    level endon( #"game_ended" );
    self endon( #"circle_index_reached" );
    var_12367bc49adc2160 = br_map_quest::get_setting( "portal_spawn_cooldown" );
    openingduration = br_map_quest::get_setting( "portal_open_duration" );
    var_e74c6bd45c938962 = br_map_quest::get_setting( "circle_index_to_stop_spawn" );
    
    if ( var_e74c6bd45c938962 > 0 )
    {
        thread function_242bfa82a6506101( var_e74c6bd45c938962 );
    }
    
    while ( true )
    {
        if ( !function_da517e5f1f2d869() )
        {
            wait var_12367bc49adc2160;
            continue;
        }
        
        spawnportals();
        wait openingduration;
        function_6a395a32953d394f( "lifetime_expired" );
        wait 8;
    }
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0xdcdfb3e6, Offset: 0xb09
// Size: 0x67
function private function_242bfa82a6506101( var_e74c6bd45c938962 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        
        if ( level.br_circle.circleindex + 1 >= var_e74c6bd45c938962 )
        {
            self notify( #"circle_index_reached" );
            function_6a395a32953d394f( "circle_limit_reached" );
            wait 8;
            break;
        }
    }
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0x7a89792d, Offset: 0xb78
// Size: 0x21
function private function_da517e5f1f2d869()
{
    var_ad2ef8bfffb4acd6 = br_map_quest::get_setting( "portal_spawn_chance" );
    return utility::percent_chance( var_ad2ef8bfffb4acd6 );
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0x151b19aa, Offset: 0xba2
// Size: 0x130
function private spawnportals()
{
    self.var_f3c69ef01eafd0f8 = [];
    selectedclusters = function_adc65caff9383ee6( self.portalclusters );
    
    foreach ( cluster in selectedclusters )
    {
        var_de8232fbf2727d56 = function_5ba51521467ef1b0( cluster );
        
        foreach ( location in var_de8232fbf2727d56 )
        {
            scriptableportal = spawnportal( location );
            self.var_f3c69ef01eafd0f8[ self.var_f3c69ef01eafd0f8.size ] = scriptableportal;
        }
    }
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0x2b9ab92b, Offset: 0xcda
// Size: 0x35
function private function_ffb9e3bc871b030( var_a38bf2415d04e936 )
{
    if ( !isdefined( var_a38bf2415d04e936 ) )
    {
        return "br_cradle_portal";
    }
    
    return float( var_a38bf2415d04e936 ) < 1 ? "br_cradle_portal_01" : "br_cradle_portal";
}

// Namespace br_cradle_portal
// Params 1
// Checksum 0x73230d9c, Offset: 0xd18
// Size: 0x1a0
function spawnportal( location )
{
    payload = location.script_parameters ? function_67b78af3c33ac9a8( location.script_parameters ) : undefined;
    var_1337e776b5b4a188 = function_ffb9e3bc871b030( location.script_parameters );
    scriptableportal = spawnscriptable( var_1337e776b5b4a188, location.origin, location.angles, undefined, payload );
    scriptableportal.interact = interaction::register_scriptable_interact( scriptableportal, &portalused, undefined, undefined, &playercanuseportal );
    scriptableportal.var_6b6c38a031407a0b = location.destination;
    scriptableportal.playerused = 0;
    scriptableportal.openedtimestamp = gettime();
    scriptableportal.prestreamtrigger = spawn( "noent_volume_trigger_radius", location.origin + ( 0, 0, -150 ), 0, 300, 300 );
    scriptableportal.prestreamtrigger.destination = location.destination;
    trigger::makeenterexittrigger( scriptableportal.prestreamtrigger, &function_19ff9710536ac710, &function_41a2c14022a0942e, undefined, undefined, &triggerfilter );
    scriptableportal.var_777cfeb1e4d9ce08 = spawn( "noent_volume_trigger_radius", location.origin + ( 0, 0, -150 ), 0, 500, 300 );
    trigger::makeenterexittrigger( scriptableportal.var_777cfeb1e4d9ce08, undefined, &function_1a24a1e8e173fd61, undefined, undefined, &triggerfilter );
    return scriptableportal;
}

// Namespace br_cradle_portal
// Params 2, eflags: 0x4
// Checksum 0x68fab5e6, Offset: 0xec1
// Size: 0x9f
function private playercanuseportal( portal, player )
{
    currentweapon = player getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( currentweapon ) || player::function_ab853a75bb4247a9( player ) || player function_5616aa6e4686fae5() || player isthrowinggrenade() )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"mp_br_ingame/fjord_crack_interact", #type:"HINT_BUTTON" };
}

// Namespace br_cradle_portal
// Params 2, eflags: 0x4
// Checksum 0x4446bfa9, Offset: 0xf69
// Size: 0x2a
function private function_41a2c14022a0942e( player, trigger )
{
    if ( !player isskydiving() )
    {
        player stopcinematicforplayer( 1, 1 );
    }
}

// Namespace br_cradle_portal
// Params 2, eflags: 0x4
// Checksum 0x537dad86, Offset: 0xf9b
// Size: 0x4b
function private function_19ff9710536ac710( player, trigger )
{
    player predictstreamposuntilcleared( trigger.destination.origin );
    player preloadcinematicforplayer( "sat_virgo_cradle_wormhole_transition" );
    player.var_78b9d344352268d2 = 1;
}

// Namespace br_cradle_portal
// Params 2, eflags: 0x4
// Checksum 0x4912571c, Offset: 0xfee
// Size: 0x36
function private function_1a24a1e8e173fd61( player, trigger )
{
    if ( player.var_78b9d344352268d2 )
    {
        waitframe();
        player clearpredictedstreampos();
        player.var_78b9d344352268d2 = undefined;
    }
}

// Namespace br_cradle_portal
// Params 3, eflags: 0x4
// Checksum 0x8c027dfc, Offset: 0x102c
// Size: 0x25, Type: bool
function private triggerfilter( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0xf2557365, Offset: 0x105a
// Size: 0x8b
function private function_6a395a32953d394f( var_e62d1e8a4f697362 )
{
    foreach ( portal in self.var_f3c69ef01eafd0f8 )
    {
        if ( portal )
        {
            portal thread destroyportal( var_e62d1e8a4f697362 );
        }
    }
}

// Namespace br_cradle_portal
// Params 1
// Checksum 0xeb4a7149, Offset: 0x10ed
// Size: 0x10c
function destroyportal( var_e62d1e8a4f697362 )
{
    var_7237854e3be197ca = self.var_17cd33f8854a75a;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    self.var_17cd33f8854a75a = 1;
    function_eb9ac4e8abf56d19( var_e62d1e8a4f697362 );
    self setscriptablepartstate( "base", "closeAnticipation" );
    wait 8;
    var_bf766119db607f78 = getplayersinradius( self.prestreamtrigger.origin, 300, 300 );
    
    foreach ( player in var_bf766119db607f78 )
    {
        player stopcinematicforplayer( 1, 1 );
    }
    
    self.prestreamtrigger delete();
    self.var_777cfeb1e4d9ce08 delete();
    self freescriptable();
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0xee0761a0, Offset: 0x1201
// Size: 0x12c
function private function_eb9ac4e8abf56d19( var_e62d1e8a4f697362 = "unknown" )
{
    openedtimestamp = self.openedtimestamp ?? 0;
    openduration = utility::function_6f5d2e1f1ff70482( gettime() - openedtimestamp );
    dlog_recordevent( "dlog_event_br_sierra_fjord_cracks_portal_closed", [ "teleport_destination_poi_name", self.var_6b6c38a031407a0b.poiname ?? "unknown", "portal_origin_x", self.origin[ 0 ] ?? 0, "portal_origin_y", self.origin[ 1 ] ?? 0, "portal_origin_z", self.origin[ 2 ] ?? 0, "total_player_entered", self.playerused ?? 0, "opened_timestamp", openedtimestamp, "open_duration", openduration ?? 0, "closing_reason", var_e62d1e8a4f697362 ] );
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0xc66935a1, Offset: 0x1335
// Size: 0x85
function private function_465ea2a8ef0c8d3d()
{
    foreach ( portal in self.var_f3c69ef01eafd0f8 )
    {
        if ( portal )
        {
            portal function_eb9ac4e8abf56d19( "game_ended" );
        }
    }
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0x53c27245, Offset: 0x13c2
// Size: 0x109
function private function_5ba51521467ef1b0( locationpool )
{
    var_91d1499c80900333 = arrayrandomize( locationpool );
    saferadius = br_map_quest::get_setting( "portal_safe_radius_from_gas" );
    var_8fa8038e007cae2 = br_map_quest::get_setting( "max_portals_per_location" );
    validlocations = [];
    
    foreach ( location in var_91d1499c80900333 )
    {
        destination = function_436ee6bb62e5ed0b();
        
        if ( destination && isvalidlocation( location.origin, saferadius ) )
        {
            location.destination = destination;
            validlocations[ validlocations.size ] = location;
            
            if ( validlocations.size == var_8fa8038e007cae2 )
            {
                break;
            }
        }
    }
    
    return validlocations;
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0x4d38a38e, Offset: 0x14d4
// Size: 0xe2
function private function_adc65caff9383ee6( clusterarray )
{
    var_75f2524eb447084d = getarraykeys( clusterarray );
    var_cb0c65438eb2b762 = arrayrandomize( var_75f2524eb447084d );
    saferadius = br_map_quest::get_setting( "portal_safe_radius_from_gas" );
    var_acdac4c5b877e60d = br_map_quest::get_setting( "max_clusters" );
    validlocations = [];
    
    foreach ( clusterkey in var_cb0c65438eb2b762 )
    {
        validlocations[ validlocations.size ] = clusterarray[ clusterkey ];
        
        if ( validlocations.size == var_acdac4c5b877e60d )
        {
            break;
        }
    }
    
    return validlocations;
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0x39968fb9, Offset: 0x15bf
// Size: 0xcd
function private function_436ee6bb62e5ed0b()
{
    var_91d1499c80900333 = arrayrandomize( self.destinationarray );
    saferadius = br_map_quest::get_setting( "portal_safe_radius_from_gas" );
    
    foreach ( location in var_91d1499c80900333 )
    {
        poiorigin = poi::poi_getorigin( location );
        
        if ( isvalidlocation( poiorigin, saferadius ) )
        {
            return { #poiname:location, #origin:poiorigin };
        }
    }
}

// Namespace br_cradle_portal
// Params 2, eflags: 0x4
// Checksum 0xf0648cc5, Offset: 0x1694
// Size: 0x26, Type: bool
function private isvalidlocation( location, saferadius )
{
    if ( !br_circle_util::function_9c40d80155aa568e( location, saferadius ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0xb79cf0a8, Offset: 0x16c3
// Size: 0x145
function private function_fb067cbae38328a0()
{
    saferadius = br_map_quest::get_setting( "portal_safe_radius_from_gas" );
    var_2f0435dd15d5647c = [];
    
    foreach ( portal in self.var_f3c69ef01eafd0f8 )
    {
        if ( portal && !isvalidlocation( portal.var_6b6c38a031407a0b.origin, saferadius ) )
        {
            portal thread destroyportal( "gas_nearby" );
            var_2f0435dd15d5647c[ var_2f0435dd15d5647c.size ] = portal;
        }
    }
    
    foreach ( portal in var_2f0435dd15d5647c )
    {
        self.var_f3c69ef01eafd0f8 = arrayremove( self.var_f3c69ef01eafd0f8, portal );
    }
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0xb96f3616, Offset: 0x1810
// Size: 0x20d
function private portalused( player )
{
    if ( player::function_ab853a75bb4247a9( player ) || player function_5616aa6e4686fae5() || player isthrowinggrenade() )
    {
        return;
    }
    
    teleportoffset = function_c5e1fd69bdcd3b02();
    self disablescriptableplayeruse( player );
    player val::set( "cradle_portal", "gesture", 0 );
    player val::set( "cradle_portal", "vehicle_use", 0 );
    player val::set( "cradle_portal", "equipment_secondary", 0 );
    function_3fe9741293108956( player, self.var_6b6c38a031407a0b.origin + teleportoffset, ( 50, 0, 0 ) );
    self.playerused += 1;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player interact_utils::function_6b4911d1597d7dc6( #"portal_interact" );
    
    if ( !isdefined( player.var_39f74f970e298112 ) )
    {
        reportchallenge( player );
        player.var_39f74f970e298112 = 1;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_sierra_fjord_cracks_portal_used", [ "teleport_destination_poi_name", self.var_6b6c38a031407a0b.poiname ?? "unknown", "portal_origin_x", self.origin[ 0 ] ?? 0, "portal_origin_y", self.origin[ 1 ] ?? 0, "portal_origin_z", self.origin[ 2 ] ?? 0, "opened_timestamp", self.openedtimestamp ?? 0 ] );
    
    if ( isdefined( self ) )
    {
        self enablescriptableplayeruse( player );
        player interact_utils::function_2589dc899a6731de( #"portal_interact" );
    }
    
    player val::reset( "cradle_portal", "vehicle_use" );
    player val::reset( "cradle_portal", "gesture" );
    player val::reset( "cradle_portal", "equipment_secondary" );
}

// Namespace br_cradle_portal
// Params 1, eflags: 0x4
// Checksum 0x5b2dc512, Offset: 0x1a25
// Size: 0x4c
function private reportchallenge( player )
{
    quest = br_map_quest::get_quest( "cradle_portal" );
    challengename = quest br_map_quest::get_setting( "challenge_name" );
    
    if ( challengename )
    {
        challenges::function_37e945722d6497f3( player, challengename, 1, 0 );
    }
}

// Namespace br_cradle_portal
// Params 0, eflags: 0x4
// Checksum 0x52d5c680, Offset: 0x1a79
// Size: 0x74
function private function_c5e1fd69bdcd3b02()
{
    quest = br_map_quest::get_quest( "cradle_portal" );
    teleportheight = quest br_map_quest::get_setting( "teleport_height" );
    offsetradius = quest br_map_quest::get_setting( "teleport_offset_radius" );
    randomoffsetx = randomintrange( offsetradius * -1, offsetradius );
    randomoffsety = randomintrange( offsetradius * -1, offsetradius );
    return ( randomoffsetx, randomoffsety, teleportheight );
}

// Namespace br_cradle_portal
// Params 3, eflags: 0x4
// Checksum 0x1a7f5716, Offset: 0x1af6
// Size: 0xae
function private function_3fe9741293108956( player, origin, angles )
{
    player endon( #"death_or_disconnect" );
    player function_8683380408d3d654( 0, 1 );
    wait 0.5;
    playfx( utility::getfx( "vfx_sat_gameplay_character_spawn_fjord_cracks_smoke" ), player.origin );
    playfx( utility::getfx( "vfx_sat_gameplay_character_spawn_fjord_cracks_smoke" ), origin );
    player setorigin( origin );
    player setplayerangles( angles );
    player skydive_beginfreefall();
    waitframe();
    playfxontagforclients( utility::getfx( "vfx_sat_gameplay_character_spawn_fjord_cracks_screen_smoke" ), player, "tag_origin", player );
    wait 1;
    player thread points::doscoreevent( #"hash_8fc58988e4f1e8c4" );
}

/#

    // Namespace br_cradle_portal
    // Params 0, eflags: 0x4
    // Checksum 0x123403c4, Offset: 0x1bac
    // Size: 0x62, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x41>", "<dev string:x5b>", &function_1e576e3f6179943a );
        devgui::add_devgui_func( "<dev string:x84>", "<dev string:x98>", &function_f87d2343fb9430cf );
        devgui::add_devgui_func( "<dev string:xba>", "<dev string:xcf>", &function_1fff352e11a732b5, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_cradle_portal
    // Params 0, eflags: 0x4
    // Checksum 0xe67f6d8c, Offset: 0x1c16
    // Size: 0x8e, Type: dev
    function private function_1e576e3f6179943a()
    {
        quest = br_map_quest::get_quest( "<dev string:xf3>" );
        
        if ( quest.var_f3c69ef01eafd0f8[ 0 ] )
        {
            randomnum = randomint( quest.var_f3c69ef01eafd0f8.size );
            level.players[ 0 ] setorigin( quest.var_f3c69ef01eafd0f8[ randomnum ].origin + anglestoforward( quest.var_f3c69ef01eafd0f8[ randomnum ].angles ) * 50 );
        }
    }

    // Namespace br_cradle_portal
    // Params 0, eflags: 0x4
    // Checksum 0x584b01d9, Offset: 0x1cac
    // Size: 0x36, Type: dev
    function private function_f87d2343fb9430cf()
    {
        quest = br_map_quest::get_quest( "<dev string:xf3>" );
        quest function_6a395a32953d394f( "<dev string:x101>" );
        wait 8;
        quest spawnportals();
    }

    // Namespace br_cradle_portal
    // Params 0, eflags: 0x4
    // Checksum 0x57cd846f, Offset: 0x1cea
    // Size: 0x1ce, Type: dev
    function private function_1fff352e11a732b5()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        color1 = ( 1, 0, 0 );
        color2 = ( 1, 1, 0 );
        quest = br_map_quest::get_quest( "<dev string:xf3>" );
        saferadius = quest br_map_quest::get_setting( "<dev string:x107>" );
        teleportheight = quest br_map_quest::get_setting( "<dev string:x123>" );
        
        while ( true )
        {
            waitframe();
            
            foreach ( portal in quest.var_f3c69ef01eafd0f8 )
            {
                cylinder( portal.origin + ( 0, 0, -150 ), portal.origin + ( 0, 0, 300 ), 300, color1 );
                cylinder( portal.origin + ( 0, 0, -150 ), portal.origin + ( 0, 0, 300 ), 500, color2 );
                cylinder( portal.var_6b6c38a031407a0b.origin + ( 0, 0, teleportheight ), portal.var_6b6c38a031407a0b.origin + ( 0, 0, teleportheight + 100 ), saferadius, ( 0, 1, 0 ) );
            }
        }
    }

#/
