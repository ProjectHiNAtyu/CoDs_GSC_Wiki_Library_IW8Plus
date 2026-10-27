// script_5d7ec2b299be2712  (hash_5d7ec2b299be2712.gscc) (size: 11974 Bytes / 0x2ec6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3de5e96c (1038477676)
// size ...... 11974 (0x2ec6)
// includes .. 14  (offset: 0x2b22)
// strings ... 52  (offset: 0x2b92)
// dev strs .. 0   (offset: 0x2ec6)
// exports ... 24  (offset: 0x1de2)
// cseg ...... 0x504 + 0x18de (0x1de2)
// imports ... 75  (offset: 0x21a2)
// animtree1 . 0   (offset: 0x2ec6)
// animtree2 . 0   (offset: 0x2ec6)
#using script_35efc59124dbb5db;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace build_the_weapon;

// Namespace build_the_weapon
// Params 0
// Checksum 0x4baedd4a, Offset: 0x522
// Size: 0x138
function init()
{
    data = { #var_6afd41378ae2cf21:[], #var_d0e1de01dd93b506:[ #"sat_zm_quest_mantis_wwq_core":"sat_zm_mantis_ww_part_core", #"sat_zm_quest_mantis_wwq_barrel":"sat_zm_mantis_ww_part_barrel", #"sat_zm_quest_mantis_wwq_stock":"sat_zm_mantis_ww_part_stock" ], #var_de058c7d66295d7f:[ #"sat_zm_quest_mantis_wwq_core":utility::getstruct( "ww_spawn_node_part_core", "script_noteworthy" ), #"sat_zm_quest_mantis_wwq_barrel":utility::getstruct( "ww_spawn_node_part_barrel", "script_noteworthy" ), #"sat_zm_quest_mantis_wwq_stock":utility::getstruct( "ww_spawn_node_part_stock", "script_noteworthy" ) ], #var_cfba9edfa7080d63:[ #"sat_zm_quest_mantis_wwq_stock", #"sat_zm_quest_mantis_wwq_barrel", #"sat_zm_quest_mantis_wwq_core", #"sat_zm_quest_mantis_wwq_sealant" ], #var_469db0b788273953:[], #ww:undefined, #ww_crafting_table:setup_crafting_table() };
    level.mantis_ww_quest.var_1e5d983acb8a37c4 = data;
    magicbox::function_2e49cd8681e36211( 1 );
    utility::flag_set( #"hash_e4e0fff6792df402" );
}

// Namespace build_the_weapon
// Params 2
// Checksum 0x9b02e073, Offset: 0x662
// Size: 0x34
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        thread function_eb9c56bd0916eee1();
        return;
    }
    
    utility::flag_wait( "ww_picked_up" );
}

// Namespace build_the_weapon
// Params 2
// Checksum 0xe5ce6bbf, Offset: 0x69e
// Size: 0x12c
function cleanup( skipped, save_restored )
{
    level callback::add( #"player_item_drop", &function_7b7f50090b8b7a49 );
    level callback::add( #"player_disconnect", &function_892bdc3baf343ac3 );
    level callback::add( #"player_death", &function_892bdc3baf343ac3 );
    level callback::add( "zm_packed_weapon", &function_4ac95cf918146b2a );
    
    foreach ( part in level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_parts )
    {
        part freescriptable();
    }
    
    magicbox::function_2e49cd8681e36211( 0 );
    magicbox::function_6c4ffb8218367c4b( %"hash_415cacfc80d21aab", 3 );
    utility::flag_set( "mantis_ww_quest_completed" );
    
    if ( skipped || save_restored )
    {
        thread function_d7d22446bf1304ec();
    }
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x1d0c29b, Offset: 0x7d2
// Size: 0xa9
function private setup_crafting_table()
{
    ww_crafting_table = utility::getent_or_struct( "ww_quest_crafting_table_future", "script_noteworthy" );
    ww_spawn_node = { #angles:ww_crafting_table gettagangles( "tag_sundergat" ), #origin:ww_crafting_table gettagorigin( "tag_sundergat" ) };
    
    if ( !isdefined( ww_crafting_table ) || !isdefined( ww_spawn_node ) )
    {
        return;
    }
    
    ww_crafting_table.interaction = zm_quest::function_91f9590e98d57ff6( ww_spawn_node.origin, &ww_crafting_table_interaction, &ww_crafting_table_hint, "small" );
    ww_crafting_table thread damage::monitordamage( 115, "none", &open_crafting_table, &function_34b1080c11b15065 );
    return ww_crafting_table;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x210a0728, Offset: 0x884
// Size: 0x6b
function private function_eb9c56bd0916eee1()
{
    utility::flag_wait( #"hash_e4e0fff6792df402" );
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    data.ww_crafting_table.interaction zm_quest::function_9170db4686f796e2();
    data.ww_crafting_table damage::monitordamageend();
    utility::flag_set( "mantis_ww_quest_crafting_table_build_disabled" );
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x4830e26d, Offset: 0x8f7
// Size: 0x5c
function private open_crafting_table( params )
{
    ww_crafting_table = level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table;
    
    if ( !is_crafting_table_open() )
    {
        ww_crafting_table setscriptablepartstate( "base", "open" );
        utility::flag_set( "mantis_ww_quest_crafting_table_opened" );
    }
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x8dc9a19a, Offset: 0x95b
// Size: 0x7f, Type: bool
function private function_34b1080c11b15065( data )
{
    if ( isplayer( data.attacker ) && data.meansofdeath == "MOD_MELEE" && !utility::flag( "ww_building" ) )
    {
        open_crafting_table();
        
        if ( !self.has_been_opened_before )
        {
            level thread battlechatter_mp::trysaylocalsound( data.attacker, #"bc_flavor_player_positive" );
            self.has_been_opened_before = 1;
        }
    }
    
    return false;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x84a52d97, Offset: 0x9e3
// Size: 0xa8, Type: bool
function private is_crafting_table_open()
{
    is_open = level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table getscriptablepartstate( "base" ) == "opened";
    is_opening = level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table getscriptablepartstate( "base" ) == "open" || level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table getscriptablepartstate( "base" ) == "open_slow";
    return is_open || is_opening;
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x70af9f16, Offset: 0xa94
// Size: 0x1ed
function private ww_crafting_table_interaction( player )
{
    if ( self.in_use || isdefined( player ) && player.interactions_disabled || !is_crafting_table_open() )
    {
        return;
    }
    
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    parts_to_add = player function_cd62721444662419();
    self.in_use = 1;
    
    if ( parts_to_add.size > 0 )
    {
        player playsoundtoplayer( "evt_wwq_weapon_part_placed", player );
        
        if ( data.var_469db0b788273953.size == 0 )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_30cf1dacc6ca154f", #"hash_5212ed7ec42f115a" );
        }
        
        foreach ( part in parts_to_add )
        {
            function_57a547a95ce0bb15( part );
            data.var_469db0b788273953[ data.var_469db0b788273953.size ] = part;
        }
    }
    else if ( function_d10d15200b330266() )
    {
        player val::set( "using_WW_table", "killstreaks", 0 );
        player zm_interaction::function_307c21197e0798d4( &"zm_sat_mantis/ww_crafting_table_building" );
        player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"using_WW_table" } );
        result = player zm_interaction::function_df340931f1a0fe6e( 2, self, self.interact_use_range );
        player zm_quest::function_b94186b3fb991490( { #craft_reason:"using_WW_table" } );
        player zm_interaction::function_7c7ed762cd4d0333();
        
        if ( result )
        {
            build_ww();
        }
    }
    else
    {
        wait 2;
    }
    
    if ( isdefined( self ) )
    {
        self.in_use = 0;
    }
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xd99bc17c, Offset: 0xc89
// Size: 0x105
function private function_57a547a95ce0bb15( part )
{
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    
    if ( part == #"sat_zm_quest_mantis_wwq_sealant" )
    {
        data.ww_crafting_table setscriptablepartstate( "effects", "add_sealant" );
        return;
    }
    
    part_scriptable = data.var_d0e1de01dd93b506[ part ];
    var_30085f70fc117162 = data.var_de058c7d66295d7f[ part ];
    part = spawnscriptable( part_scriptable, var_30085f70fc117162.origin, var_30085f70fc117162.angles );
    part setscriptablepartstate( part.type, "display" );
    part setscriptablepartstate( "effects", "display" );
    
    if ( part getscriptablehaspart( "movement" ) )
    {
        part setscriptablepartstate( "movement", "display" );
    }
    
    data.var_6afd41378ae2cf21[ data.var_6afd41378ae2cf21.size ] = part;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0xc48e482d, Offset: 0xd96
// Size: 0xa5
function private function_39bcdc011f424520()
{
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    
    foreach ( part in data.var_6afd41378ae2cf21 )
    {
        part freescriptable();
    }
    
    data.var_6afd41378ae2cf21 = [];
}

// Namespace build_the_weapon
// Params 2, eflags: 0x4
// Checksum 0x4b8e0220, Offset: 0xe43
// Size: 0x13f
function private ww_crafting_table_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled || interact.in_use || !is_crafting_table_open() )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hint = { #icon:"ui_icon_zm_ping_work_bench", #buttoncallout:&"zm_sat_mantis/ww_crafting_table_add_parts_callout", #description:&"zm_sat_mantis/ww_crafting_table_add_parts", #title:&"zm_sat_mantis/ww_crafting_table_title", #string:&"zm_sat_mantis/ww_crafting_table", #type:"HINT_BUTTON" };
    
    if ( function_d10d15200b330266() )
    {
        hint.description = &"zm_sat_mantis/ww_crafting_table_build";
        hint.buttoncallout = &"zm_sat_mantis/ww_crafting_table_build_callout";
    }
    else if ( player function_cd62721444662419().size == 0 )
    {
        hint.aux_text = &"zm_sat_mantis/ww_crafting_table_need_parts";
        hint.interactable = 0;
    }
    
    return hint;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0xb4d12738, Offset: 0xf8b
// Size: 0x5e
function private function_d10d15200b330266()
{
    var_d10d15200b330266 = level.mantis_ww_quest.var_1e5d983acb8a37c4.var_cfba9edfa7080d63.size == level.mantis_ww_quest.var_1e5d983acb8a37c4.var_469db0b788273953.size;
    
    if ( var_d10d15200b330266 )
    {
        utility::flag_set( "ww_can_build" );
    }
    
    return var_d10d15200b330266;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x149f7fee, Offset: 0xff2
// Size: 0xd1
function private function_cd62721444662419()
{
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    parts_to_add = [];
    
    foreach ( part in data.var_cfba9edfa7080d63 )
    {
        if ( !arraycontains( data.var_469db0b788273953, part ) && zm_quest::function_6b5f09e88a4edfce( #"mantis_ww_quest", 0, part, self ) )
        {
            parts_to_add[ parts_to_add.size ] = part;
        }
    }
    
    return parts_to_add;
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0xdbdd0021, Offset: 0x10cc
// Size: 0x21e
function private build_ww()
{
    utility::flag_set( "ww_building" );
    data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    function_eb9c56bd0916eee1();
    wait 0.5;
    data.ww_crafting_table setscriptablepartstate( "base", "close_slow" );
    wait 1;
    function_39bcdc011f424520();
    thread function_12056963ce96a766( data.ww_crafting_table.origin );
    var_30085f70fc117162 = { #angles:data.ww_crafting_table gettagangles( "tag_sundergat" ), #origin:data.ww_crafting_table gettagorigin( "tag_sundergat" ) + ( 7.25, -5, 0 ) };
    weapon_bundle = getscriptbundle( %"hash_415cacfc80d21aab" );
    spawn_options = common_item::function_bc5ff2958b71a708( var_30085f70fc117162.origin, var_30085f70fc117162.angles );
    spawn_options.var_8d4f327170228364 = 1;
    spawn_options.var_b8402e625c429a31 = 1;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    data.ww_crafting_table setscriptablepartstate( "effects", "crafted" );
    wait 3.4;
    ww = item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
    ww setscriptablepartstate( ww.type, "visible_original_position_no_stem_no_obst" );
    ww.quest_ww = 1;
    data.ww = ww;
    playsoundatpos( var_30085f70fc117162.origin, "evt_zm_player_craft_success" );
    utility::flag_clear( "ww_building" );
    utility::flag_set( "ww_built" );
    
    if ( !callback::exists( #"player_used_item", &function_b035882402d85e2a ) )
    {
        level callback::add( #"player_used_item", &function_b035882402d85e2a );
    }
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xaa168fca, Offset: 0x12f2
// Size: 0x10c
function private function_b035882402d85e2a( params )
{
    if ( params.item.weaponobj.basename != "sat_ww_mantis_zm" )
    {
        return;
    }
    
    self.var_d8b9fb9a067d1a56 = 1;
    
    if ( !utility::flag( "ww_picked_up" ) && params.item == level.mantis_ww_quest.var_1e5d983acb8a37c4.ww )
    {
        level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table setscriptablepartstate( "base", "close_slow" );
        thread function_9454bc3cf1deb18a( self, level.mantis_ww_quest.var_1e5d983acb8a37c4.ww_crafting_table.origin );
        level.mantis_ww_quest.var_1e5d983acb8a37c4.ww = undefined;
        utility::flag_set( "ww_picked_up" );
    }
    
    level notify( #"ww_picked_up" );
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x558c9f7a, Offset: 0x1406
// Size: 0x4e
function private function_7b7f50090b8b7a49( params )
{
    waitframe();
    
    if ( !self.var_d8b9fb9a067d1a56 || params.item.weaponobj.basename != "sat_ww_mantis_zm" )
    {
        return;
    }
    
    self.var_d8b9fb9a067d1a56 = 0;
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xb940bd5, Offset: 0x145c
// Size: 0x24e
function private function_892bdc3baf343ac3( params )
{
    if ( !self.var_d8b9fb9a067d1a56 )
    {
        return;
    }
    
    primary_weapons = self getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapon.basename == "sat_ww_mantis_zm" )
        {
            bundle_name = weapon hasattachment( "sat_bar_ww_mantis" ) ? %"hash_39bfecdb33df38fc" : %"hash_415cacfc80d21aab";
            weapon_bundle = getscriptbundle( bundle_name );
            var_30085f70fc117162 = utility::getstruct( "ww_respawn_node_weapon", "script_noteworthy" );
            weapon_info_struct = item_weapon::function_8daff85dacc00ff4( self, weapon, weapon.ammomod );
            spawn_options = common_item::function_bc5ff2958b71a708( var_30085f70fc117162.origin + ( 7.25, -5, 0 ), var_30085f70fc117162.angles );
            spawn_options.weapon = weapon;
            spawn_options.weaponinfostruct = weapon_info_struct;
            spawn_options.var_8d4f327170228364 = 1;
            spawn_options.var_fd47e835523b473f = 1;
            spawn_options.var_9161cf0784b6951d = 1;
            spawn_options.var_f35b5b18b029c493 = 0;
            spawn_options.critical = 1;
            spawn_options.overridepaplvl = weapon_info_struct.paplv;
            spawn_options.overrideammomod = weapon_info_struct.ammomod;
            var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
            var_8a61d4195b4b6e64 setscriptablepartstate( var_8a61d4195b4b6e64.type, "visible_original_position_no_stem_no_obst" );
            
            if ( isdefined( var_8a61d4195b4b6e64.linkedparent ) )
            {
                var_8a61d4195b4b6e64 utility::scriptable_clearparententity();
            }
            
            var_8a61d4195b4b6e64.quest_ww = 1;
            level.mantis_ww_quest.var_1e5d983acb8a37c4.ww = var_8a61d4195b4b6e64;
        }
    }
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0x7f61ee7a, Offset: 0x16b2
// Size: 0x4f
function private function_4ac95cf918146b2a( params )
{
    if ( params.var_39044599845b54cf.basename != "sat_ww_mantis_zm" )
    {
        return;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"ww_pap_level", params.var_951c89546ec50477 );
}

// Namespace build_the_weapon
// Params 0, eflags: 0x4
// Checksum 0x4bec73f6, Offset: 0x1709
// Size: 0x25e
function private function_d7d22446bf1304ec()
{
    zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "loading_screen_over" );
    
    foreach ( player in level.players )
    {
        primary_weapons = player getweaponslistprimaries();
        
        foreach ( weapon in primary_weapons )
        {
            if ( weapon.basename == "sat_ww_mantis_zm" )
            {
                return;
            }
        }
    }
    
    weapon_bundle = utility::flag( #"wwu_weapon_retrieved" ) ? getscriptbundle( %"hash_39bfecdb33df38fc" ) : getscriptbundle( %"hash_415cacfc80d21aab" );
    var_30085f70fc117162 = utility::getstruct( "ww_respawn_node_weapon", "script_noteworthy" );
    spawn_options = common_item::function_bc5ff2958b71a708( var_30085f70fc117162.origin + ( 7.25, -5, 0 ), var_30085f70fc117162.angles );
    spawn_options.var_8d4f327170228364 = 1;
    spawn_options.var_fd47e835523b473f = 1;
    spawn_options.var_9161cf0784b6951d = 1;
    spawn_options.var_f35b5b18b029c493 = 0;
    spawn_options.critical = 1;
    spawn_options.overridepaplvl = zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"ww_pap_level" ) ?? 0;
    var_8a61d4195b4b6e64 = item_weapon::function_b960bc85ea91de14( weapon_bundle, spawn_options );
    var_8a61d4195b4b6e64 setscriptablepartstate( var_8a61d4195b4b6e64.type, "visible_original_position_no_stem_no_obst" );
    var_8a61d4195b4b6e64.quest_ww = 1;
    level.mantis_ww_quest.var_1e5d983acb8a37c4.ww = var_8a61d4195b4b6e64;
}

// Namespace build_the_weapon
// Params 1, eflags: 0x4
// Checksum 0xdabfe53d, Offset: 0x196f
// Size: 0x72
function private function_12056963ce96a766( location )
{
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw4aplsl" );
    }
    else
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw4aplsl" );
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace build_the_weapon
// Params 2, eflags: 0x4
// Checksum 0xd88e8298, Offset: 0x19e9
// Size: 0xcc
function private function_9454bc3cf1deb18a( player, location )
{
    player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_260e6b0f1b28d09c", #"hash_5212ed7ec42f115a" );
    player player_banter::function_850de641659a4090();
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw4pubgra1ln1" );
        wait 4;
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw4pubgra1ln2" );
        wait 6.5;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw4pubgra2ln1" );
        wait 5.5;
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw4pubgra2ln2" );
        wait 3.5;
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace build_the_weapon
// Params 0
// Checksum 0xc212ba05, Offset: 0x1abd
// Size: 0x324, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"mantis_ww_quest", #"hash_606cf2ac9d492559" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    quest_data = level.mantis_ww_quest.var_1e5d983acb8a37c4;
    
    if ( !utility::flag( "mantis_ww_quest_crafting_table_opened" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a46ba77c952904", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c8a46ba77c952904" } );
        utility::flag_wait( "mantis_ww_quest_crafting_table_opened" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    
    if ( !utility::flag( "ww_can_build" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a46ea77c952e1d", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c8a46ea77c952e1d" } );
        utility::flag_wait( "ww_can_build" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    
    if ( !utility::flag( "ww_built" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a46da77c952c6a", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_crafting_table.origin, "wwq_mark_workbench", 80, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c8a46da77c952c6a" } );
        utility::flag_wait( "ww_built" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    
    if ( !utility::flag( "ww_picked_up" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_c8a468a77c9523eb", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_crafting_table.origin, "wwq_mark_ww", 80, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_c8a468a77c9523eb" } );
        utility::flag_wait( "ww_picked_up" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

