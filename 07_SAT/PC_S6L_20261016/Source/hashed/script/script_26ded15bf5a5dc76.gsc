// script_26ded15bf5a5dc76  (hash_26ded15bf5a5dc76.gscc) (size: 14651 Bytes / 0x393b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb1f5eb8 (3407830712)
// size ...... 14651 (0x393b)
// includes .. 14  (offset: 0x3413)
// strings ... 82  (offset: 0x3483)
// dev strs .. 1   (offset: 0x392b)
// exports ... 28  (offset: 0x25b7)
// cseg ...... 0x5b4 + 0x2003 (0x25b7)
// imports ... 77  (offset: 0x2a17)
// animtree1 . 0   (offset: 0x393b)
// animtree2 . 0   (offset: 0x393b)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_cradle_portal;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_e26fcad12a0fdb53;

// Namespace namespace_e26fcad12a0fdb53
// Params 0, eflags: 0x5
// Checksum 0x275f1c6c, Offset: 0x5d2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hideout", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0xf74f94f6, Offset: 0x5fb
// Size: 0x50
function pre_main()
{
    quest = { #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_init:&on_init, #name:"hideout" };
    br_map_quest::register( quest );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x8e0646da, Offset: 0x653
// Size: 0x21
function on_init()
{
    apply_settings();
    function_afa5fe2208fb6a2c();
    set_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x1fc7c74f, Offset: 0x67c
// Size: 0x26
function on_start()
{
    if ( self.hideout_blocker )
    {
        self.hideout_blocker setscriptablepartstate( "state", "hidden" );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x72a89666, Offset: 0x6aa
// Size: 0x1e1
function on_prematch_end()
{
    if ( self.refinery_button )
    {
        if ( self.summer_state )
        {
            self.refinery_button setscriptablepartstate( "saw_rocks_ice_cube_button", "usable" );
        }
        else
        {
            self.refinery_button setscriptablepartstate( "health", "alive" );
        }
    }
    
    if ( self.outpost_button )
    {
        if ( self.summer_state )
        {
            self.outpost_button setscriptablepartstate( "saw_rocks_ice_cube_button", "usable" );
        }
        else
        {
            self.outpost_button setscriptablepartstate( "health", "alive" );
        }
    }
    
    if ( self.refinery_terminal )
    {
        self.refinery_terminal setscriptablepartstate( self.refinery_terminal.type, "usable" );
    }
    
    if ( self.hideout_entrance )
    {
        self.hideout_entrance setscriptablepartstate( self.hideout_entrance.type, "usable" );
    }
    
    if ( self.ssd_loc )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( self.ssd_loc.origin, self.ssd_loc.angles ?? ( 0, 0, 0 ) );
        spawnoptions.critical = 1;
        itembundle = common_item::function_cf68ad18114498b2( "wz_consumable_quest_computer_ssd" );
        self.ssd_item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    }
    
    if ( self.staged_molotov.size > 0 )
    {
        spawn_items( "itemspawnentry:wz_sat_item_lethal_molotov", self.staged_molotov, self.num_staged_molotov );
    }
    
    if ( self.staged_thermite.size > 0 )
    {
        spawn_items( "itemspawnentry:wz_sat_item_lethal_thermite", self.staged_thermite, self.num_staged_thermite );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0, eflags: 0x4
// Checksum 0xdfd8dca4, Offset: 0x893
// Size: 0x63
function private apply_settings()
{
    br_map_quest::add_setting( "num_staged_molotov", 2 );
    br_map_quest::add_setting( "num_staged_thermite", 2 );
    br_map_quest::add_setting( "entrance_delay", 4 );
    br_map_quest::add_setting( "inner_delay", 8 );
    br_map_quest::add_setting( "puzzle_cooldown", 5 );
    br_map_quest::add_setting( "portal_enabled", 0 );
    br_map_quest::add_setting( "summer_state", 1 );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x5b165945, Offset: 0x8fe
// Size: 0x6bd
function function_afa5fe2208fb6a2c()
{
    self.num_staged_molotov = br_map_quest::get_setting( "num_staged_molotov" );
    self.num_staged_thermite = br_map_quest::get_setting( "num_staged_thermite" );
    self.entrance_delay = br_map_quest::get_setting( "entrance_delay" );
    self.inner_delay = br_map_quest::get_setting( "inner_delay" );
    self.puzzle_cooldown = br_map_quest::get_setting( "puzzle_cooldown" );
    self.portal_enabled = br_map_quest::get_setting( "portal_enabled" );
    self.summer_state = br_map_quest::get_setting( "summer_state" );
    codes = [];
    codes[ codes.size ] = { #code:[ 0, 0, 1, 1, 1 ], #id:"on_0" };
    codes[ codes.size ] = { #code:[ 1, 1, 1, 0, 0 ], #id:"on_1" };
    codes[ codes.size ] = { #code:[ 0, 1, 0, 1, 1 ], #id:"on_2" };
    codes[ codes.size ] = { #code:[ 1, 0, 0, 1, 1 ], #id:"on_3" };
    codes[ codes.size ] = { #code:[ 0, 1, 1, 0, 1 ], #id:"on_4" };
    self.outer_code = codes[ randomint( codes.size ) ];
    codes = [];
    codes[ codes.size ] = [ 1, 1, 1, 0, 0, 1, 0 ];
    codes[ codes.size ] = [ 0, 1, 0, 1, 1, 0, 1 ];
    codes[ codes.size ] = [ 1, 0, 1, 0, 1, 0, 1 ];
    codes[ codes.size ] = [ 0, 0, 1, 1, 1, 0, 1 ];
    codes[ codes.size ] = [ 0, 1, 0, 0, 0, 1, 1 ];
    self.inner_code = codes[ randomint( codes.size ) ];
    self.refinery_button = getentitylessscriptablearray( "refinery_button", #targetname )[ 0 ];
    self.refinery_terminal = getentitylessscriptablearray( "refinery_terminal", #targetname )[ 0 ];
    self.outpost_button = getentitylessscriptablearray( "outpost_button", #targetname )[ 0 ];
    self.hideout_terminal = getentitylessscriptablearray( "hideout_terminal", #targetname )[ 0 ];
    self.hideout_entrance = getentitylessscriptablearray( "hideout_entrance", #targetname )[ 0 ];
    self.hideout_blocker = getentitylessscriptablearray( "hideout_blocker", #targetname )[ 0 ];
    self.hideout_doors = getentitylessscriptablearray( "hideout_door", #targetname );
    self.var_74faddcd3fed46e6 = getentitylessscriptablearray( "hideout_sliding_door", #targetname );
    self.staged_items = utility::getstructarray( "hideout_staged_item", "targetname" );
    
    if ( self.hideout_entrance )
    {
        self.hideout_entrance.lights = get_light_sequence( self.hideout_entrance );
        self.hideout_entrance.var_b8a2b63012f3bc0e = getnoentvolumearray( self.hideout_entrance.target, #targetname );
        self.hideout_entrance.blocker = spawnscriptable( "clip256x256x256", ( -572, 721, 869 ) );
    }
    
    if ( self.hideout_terminal )
    {
        self.hideout_terminal.lights = get_light_sequence( self.hideout_terminal );
        
        foreach ( index, light in self.hideout_terminal.lights )
        {
            if ( light.note_struct )
            {
                light.note_struct.targetname = self.inner_code[ index ] ? "escape_hideout_x" : "escape_hideout_o";
            }
        }
    }
    
    if ( self.refinery_button )
    {
        self.refinery_button.var_b8a2b63012f3bc0e = getnoentvolumearray( self.refinery_button.target, #targetname );
    }
    
    if ( self.outpost_button && isdefined( self.outpost_button.target ) )
    {
        self.outpost_button.veh_spawn = utility::getstruct( self.outpost_button.target, "targetname" );
        self.outpost_button.var_b8a2b63012f3bc0e = getnoentvolumearray( self.outpost_button.target, #targetname );
    }
    
    self.ssd_loc = utility::getstruct( "outpost_ssd", "targetname" );
    self.portal_location = utility::getstruct( "hideout_portal_location", "targetname" );
    
    if ( self.portal_location )
    {
        self.portal_location.destination = self.portal_location;
    }
    
    self.staged_molotov = utility::getstructarray( "hideout_outpost_molotov" );
    self.staged_thermite = utility::getstructarray( "hideout_refinery_thermite" );
    self.reward_spawns = utility::getstructarray( "hideout_blueprint_reward", "script_noteworthy" );
    self.reward_spawns = utility::array_sort_by_script_index( self.reward_spawns );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x7daf2b22, Offset: 0xfc3
// Size: 0xf4
function hideout_setup()
{
    if ( self.hideout_terminal )
    {
        self.hideout_terminal setscriptablepartstate( self.hideout_terminal.type, "usable" );
        
        foreach ( index, light in self.hideout_terminal.lights )
        {
            if ( light.note_struct )
            {
                utility::callsharedfunc( #"stationary_note", #"hash_e640049ec08a4763", light.note_struct.origin, [ index + 1 ] );
            }
        }
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 2
// Checksum 0xbfcefc7f, Offset: 0x10bf
// Size: 0x8b
function get_light_sequence( parent, result = [] )
{
    light = getentitylessscriptablearray( parent.target, #targetname )[ 0 ];
    
    if ( light )
    {
        if ( light.target )
        {
            light.note_struct = utility::getstruct( light.target, "targetname" );
        }
        
        result[ result.size ] = light;
        return get_light_sequence( light, result );
    }
    
    return result;
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0, eflags: 0x4
// Checksum 0xc2e3b3a, Offset: 0x1153
// Size: 0x63
function private set_callbacks()
{
    scriptable::scriptable_adddamagedcallback( &button_handle_damage );
    scriptable::scriptable_addusedcallbackbypart( "saw_rocks_ice_cube_button", &button_used );
    scriptable::scriptable_addusedcallbackbypart( "escape_refinery_terminal", &refinery_terminal_used );
    scriptable::scriptable_addusedcallbackbypart( "escape_hideout_switch", &hideout_entrance_used );
    scriptable::scriptable_addusedcallbackbypart( "escape_hideout_terminal", &hideout_terminal_used );
    scriptable::scriptable_addusedcallbackbypart( "escape_hideout_button", &function_fb95aa88d7357dbd );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 11
// Checksum 0x2ea499e9, Offset: 0x11be
// Size: 0xe1
function button_handle_damage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "saw_rocks_ice_cube_button" )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && isdefined( objweapon.basename ) && issubstr( objweapon.basename, "molotov" ) || issubstr( objweapon.basename, "thermite" ) )
    {
        waitframe();
        instance setscriptablepartstate( "health", "immune" );
        eattacker button_analytics( instance, "immune" );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 6
// Checksum 0x8f6b1dbd, Offset: 0x12a7
// Size: 0xdc
function button_used( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "saw_rocks_ice_cube_button", "activated" );
    
    foreach ( volume in instance.var_b8a2b63012f3bc0e )
    {
        volume function_d2d0316ddcb9841( 0 );
    }
    
    player button_analytics( instance, "activated" );
    thread function_10a04f4b59384ec6( instance );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 2
// Checksum 0x1048108b, Offset: 0x138b
// Size: 0x80
function button_analytics( instance, state )
{
    self dlog_recordplayerevent( "dlog_event_br_escape_ice", [ "state", state, "pos_x", instance.origin[ 0 ], "pos_y", instance.origin[ 1 ], "pos_z", instance.origin[ 2 ] ] );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1
// Checksum 0x9c5f7ab8, Offset: 0x1413
// Size: 0x13b
function function_10a04f4b59384ec6( instance )
{
    level endon( #"game_ended" );
    instance.doors = getentitylessscriptablearray( instance.target, #targetname );
    
    foreach ( door in instance.doors )
    {
        door setscriptablepartstate( door.type, "open" );
    }
    
    if ( instance.veh_spawn )
    {
        br_vehicles::tryspawnavehicle( instance.veh_spawn.script_vehiclebundle, instance.veh_spawn );
    }
    
    wait 10;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( instance.target );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 6
// Checksum 0xcc707083, Offset: 0x1556
// Size: 0x112
function refinery_terminal_used( instance, part, state, player, bautouse, usestring )
{
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_computer_ssd" ) )
    {
        quest = br_map_quest::get_quest( "hideout" );
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_computer_ssd" );
        instance setscriptablepartstate( instance.type, quest.outer_code.id );
        player thread points::doscoreevent( #"hash_ccbf48691d287e5a" );
        quest hideout_setup();
        quest.refinery_data = 1;
        quest br_map_quest::function_bcff1e4dd70594f4( player, "progress", [ "team_id", player.team, "step", "refinery" ] );
        return;
    }
    
    player [[ level.showerrormessagefunc ]]( %"hash_71529f27b8cac749" );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 6
// Checksum 0xe6c5082a, Offset: 0x1670
// Size: 0x145
function hideout_entrance_used( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "hideout" );
    
    if ( usestring == "activation" )
    {
        if ( quest.refinery_data )
        {
            instance.lastplayerused = player;
            instance thread hideout_entrance_sequence();
            
            /#
                level thread utility::function_95445a6684f51c52( "<dev string:x24>" + utility::function_8586225841e38b51( quest.outer_code.code ), instance.origin + ( 0, 0, 15 ), ( 1, 1, 1 ), 1, 0.1, 20 );
            #/
        }
        else
        {
            player [[ level.showerrormessagefunc ]]( %"hash_41ed0bee173dcc64" );
        }
        
        return;
    }
    
    if ( usestring == "toggle" )
    {
        instance setscriptablepartstate( instance.type, "cooldown" );
        instance.lastplayerused = player;
        InvalidOpCode( 0x5e, 1, instance.value );
        // Unknown operator ( 0x5e, t11, Black Ops 7 )
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0xc43dba4b, Offset: 0x17bd
// Size: 0x416
function hideout_entrance_sequence()
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "hideout" );
    self.code = [];
    
    foreach ( light in self.lights )
    {
        self.value = 0;
        self setscriptablepartstate( self.type, "toggle" );
        light setscriptablepartstate( light.type, "pending" );
        wait quest.entrance_delay;
        light setscriptablepartstate( light.type, self.value ? "on" : "default" );
        self.code[ self.code.size ] = self.value;
    }
    
    self setscriptablepartstate( self.type, "cooldown" );
    
    if ( arraycompare( self.code, quest.outer_code.code ) )
    {
        points::function_40522c040a4e7b1( self.lastplayerused.team, #"hash_c8a3f3751d9c2eb3" );
        teamplayers = teams::getteamdata( self.lastplayerused.team, "players" );
        
        foreach ( teamplayer in teamplayers )
        {
            challenges::function_37e945722d6497f3( teamplayer, "escape_sq_refinery", 1 );
        }
        
        self setscriptablepartstate( self.type, "success" );
        
        foreach ( door in quest.hideout_doors )
        {
            door scriptabledoorfreeze( 0 );
        }
        
        if ( quest.reward_spawns )
        {
            level callback::add( #"player_item_pickup", &on_item_pickup );
            quest function_fa42249685682a2f( "br_sidequest_hideout" );
        }
        
        foreach ( volume in self.var_b8a2b63012f3bc0e )
        {
            volume function_d2d0316ddcb9841( 0 );
        }
        
        if ( self.blocker )
        {
            self.blocker freescriptable();
        }
        
        quest br_map_quest::function_bcff1e4dd70594f4( self.lastplayerused, "progress", [ "team_id", self.lastplayerused.team, "step", "entrance" ] );
        wait 3;
        
        if ( quest.portal_enabled && quest.portal_location )
        {
            quest.portal = br_cradle_portal::spawnportal( quest.portal_location );
            quest.portal thread hideout_portal_timeout();
        }
        
        return;
    }
    
    quest function_18039a1e325045ea( self );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 6
// Checksum 0x8954569e, Offset: 0x1bdb
// Size: 0x5a
function hideout_terminal_used( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( instance.type, "on" );
    instance thread hideout_terminal_sequence( player );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 6
// Checksum 0x2c65decb, Offset: 0x1c3d
// Size: 0x96
function function_fb95aa88d7357dbd( instance, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "hideout" );
    instance setscriptablepartstate( instance.type, "used" );
    quest.hideout_terminal.lastplayerused = player;
    InvalidOpCode( 0x5e, 1, quest.hideout_terminal.value );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1
// Checksum 0xea9ef015, Offset: 0x1cf2
// Size: 0x429
function hideout_terminal_sequence( player )
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "hideout" );
    quest.hideout_terminal.lastplayerused = player;
    self.code = [];
    
    foreach ( index, light in self.lights )
    {
        self.value = 0;
        light setscriptablepartstate( light.type, "usable" );
        light setscriptablepartstate( "status", "pending" );
        
        /#
            level thread utility::function_95445a6684f51c52( "<dev string:x24>" + quest.inner_code[ index ], light.origin + ( 0, 0, 15 ), ( 1, 1, 1 ), 1, 1, quest.inner_delay );
        #/
        
        wait quest.inner_delay;
        light setscriptablepartstate( light.type, self.value ? "green" : "red" );
        light setscriptablepartstate( "status", "holding" );
        self.code[ self.code.size ] = self.value;
    }
    
    if ( arraycompare( self.code, quest.inner_code ) )
    {
        self setscriptablepartstate( self.type, "success" );
        thread points::function_40522c040a4e7b1( quest.hideout_terminal.lastplayerused.team, #"hash_691f6db9859da92e" );
        
        foreach ( door in quest.var_74faddcd3fed46e6 )
        {
            door setscriptablepartstate( "base", door.script_noteworthy );
        }
        
        utility::exploder( "ee_old_gulag_smoke_armory" );
        
        foreach ( item in quest.rewards )
        {
            if ( isdefined( item ) )
            {
                item setscriptablepartstate( item.type, "visible" );
                
                if ( item getscriptableparthasstate( item.type, #"visible_staged_weapon" ) )
                {
                    item setscriptablepartstate( item.type, #"visible_staged_weapon" );
                }
            }
        }
        
        quest br_map_quest::function_bcff1e4dd70594f4( quest.hideout_terminal.lastplayerused, "progress", [ "team_id", quest.hideout_terminal.lastplayerused.team, "step", "hideout" ] );
        params = { #completed_by:teams::getteamdata( quest.hideout_terminal.lastplayerused.team, "players" ), #is_successful:1 };
        quest br_map_quest::on_completed( params );
        return;
    }
    
    quest function_18039a1e325045ea( self );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0xfd1ab7d2, Offset: 0x2123
// Size: 0x27
function hideout_portal_timeout()
{
    level endon( #"game_ended" );
    level utility::waittill_any( "respawn_disabled", "gulag_closed" );
    br_cradle_portal::destroyportal();
}

// Namespace namespace_e26fcad12a0fdb53
// Params 3, eflags: 0x4
// Checksum 0x479908cb, Offset: 0x2152
// Size: 0x120
function private spawn_items( bundle, locations, amount )
{
    item_bundle = getscriptbundle( bundle );
    
    if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( item_bundle.scriptable ) )
    {
        return;
    }
    
    locations = arrayrandomize( locations );
    currentamount = 0;
    
    foreach ( loc in locations )
    {
        if ( !loc )
        {
            continue;
        }
        
        if ( currentamount < amount )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( loc.origin, loc.angles );
            spawnoptions.critical = 1;
            scriptable = common_item::function_61c2c0251e742ffd( item_bundle, undefined, spawnoptions );
            currentamount++;
            continue;
        }
        
        return;
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1
// Checksum 0x2f35fbf1, Offset: 0x227a
// Size: 0xcd
function function_18039a1e325045ea( instance )
{
    instance setscriptablepartstate( instance.type, "off" );
    
    foreach ( light in instance.lights )
    {
        light setscriptablepartstate( light.type, "default" );
    }
    
    wait self.puzzle_cooldown;
    instance setscriptablepartstate( instance.type, "usable" );
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1, eflags: 0x4
// Checksum 0x4d787ce4, Offset: 0x234f
// Size: 0x131
function private function_fa42249685682a2f( spawnlistname )
{
    self.rewards = [];
    spawnlist = common_cache::function_73fc13f2febd3a2( spawnlistname );
    var_9d44c5c18559ef21 = common_item::items_selectfromlist( spawnlist.spawnlistname, spawnlist.spawncount, undefined, 1 );
    
    for ( i = 0; i < self.reward_spawns.size ; i++ )
    {
        itembundle = getscriptbundle( var_9d44c5c18559ef21[ i ] );
        
        if ( itembundle )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( self.reward_spawns[ i ].origin, self.reward_spawns[ i ].angles );
            spawnoptions.critical = 1;
            spawneditem = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
            
            if ( spawneditem getscriptableparthasstate( spawneditem.type, "visible_outline_unusable" ) )
            {
                spawneditem setscriptablepartstate( spawneditem.type, "visible_outline_unusable" );
            }
            
            self.rewards[ self.rewards.size ] = spawneditem;
        }
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1
// Checksum 0xb8cce36d, Offset: 0x2488
// Size: 0x78
function on_item_pickup( params )
{
    quest = level.br_map_quest.quests[ "hideout" ];
    
    if ( quest.gunpickedup )
    {
        return;
    }
    
    if ( params.itembundlename == %"hash_7c772cb3434a97ab" )
    {
        quest.gunpickedup = 1;
        function_a4443d7df1b90931( params.player );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 1, eflags: 0x4
// Checksum 0x64da6de6, Offset: 0x2508
// Size: 0xa5
function private function_a4443d7df1b90931( player )
{
    teamplayers = teams::getteamdata( player.team, "players" );
    
    foreach ( teamplayer in teamplayers )
    {
        challenges::function_37e945722d6497f3( teamplayer, "escape_sq_hideout", 1 );
    }
}

// Namespace namespace_e26fcad12a0fdb53
// Params 0
// Checksum 0x6361d71e, Offset: 0x25b5
// Size: 0x2
function debug_init()
{
    
}

