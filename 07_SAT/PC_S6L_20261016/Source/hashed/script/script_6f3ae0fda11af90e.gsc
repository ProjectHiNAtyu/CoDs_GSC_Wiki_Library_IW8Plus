// script_6f3ae0fda11af90e  (hash_6f3ae0fda11af90e.gscc) (size: 21445 Bytes / 0x53c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20b8686e (548956270)
// size ...... 21445 (0x53c5)
// includes .. 17  (offset: 0x4c69)
// strings ... 76  (offset: 0x4cf1)
// dev strs .. 38  (offset: 0x51d5)
// exports ... 56  (offset: 0x321d)
// cseg ...... 0x63c + 0x2be1 (0x321d)
// imports ... 140 (offset: 0x3add)
// animtree1 . 0   (offset: 0x53c5)
// animtree2 . 0   (offset: 0x53c5)
#using script_16ea1b94f0f381b3;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_saw_sm_island\mp_saw_sm_island;

#namespace quest_vault;

// Namespace quest_vault
// Params 0, eflags: 0x5
// Checksum 0xff4971ae, Offset: 0x65a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"dd_vault", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_vault
// Params 0
// Checksum 0x526f53a9, Offset: 0x683
// Size: 0x6c
function pre_main()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"vault" };
    br_map_quest::register( quest );
}

// Namespace quest_vault
// Params 0
// Checksum 0x4512ded2, Offset: 0x6f7
// Size: 0x28
function on_init()
{
    set_dvars();
    set_quest_variables();
    set_callbacks();
    function_d4d2a835ad90719e();
    
    /#
        debug_init();
    #/
}

// Namespace quest_vault
// Params 0
// Checksum 0x3eeb7d64, Offset: 0x727
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_vault
// Params 0
// Checksum 0xff6fd609, Offset: 0x731
// Size: 0x2f
function on_start()
{
    function_9fbb2e2632967e20();
    function_1899142f429c7f2();
    spawn_scriptables();
    
    /#
        if ( br_map_quest::get_setting( "<dev string:x24>" ) )
        {
            torches_activate();
        }
    #/
}

// Namespace quest_vault
// Params 0
// Checksum 0x3d6d8d4, Offset: 0x768
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_vault
// Params 0
// Checksum 0xb6b40bcc, Offset: 0x772
// Size: 0x10
function on_infil()
{
    torches_activate();
    spawn_equipment();
}

// Namespace quest_vault
// Params 0, eflags: 0x4
// Checksum 0xb3d5876e, Offset: 0x78a
// Size: 0x58
function private set_dvars()
{
    br_map_quest::add_setting( "use_map_assets", 0 );
    br_map_quest::add_setting( "splash_range", 1500 );
    br_map_quest::add_setting( "num_torches_start_lit", 3 );
    br_map_quest::add_setting( "sparkle_timer", 20 );
    br_map_quest::add_setting( "num_equipment_to_spawn", 2 );
    
    /#
        br_map_quest::add_setting( "<dev string:x24>", 0 );
    #/
}

// Namespace quest_vault
// Params 0
// Checksum 0x18ae5549, Offset: 0x7ea
// Size: 0x3e
function set_quest_variables()
{
    self.var_97a708d1d1a9c5b8 = br_map_quest::get_setting( "num_torches_start_lit" );
    self.treasure_sparkle_timer = br_map_quest::get_setting( "sparkle_timer" );
    self.num_equipment_to_spawn = br_map_quest::get_setting( "num_equipment_to_spawn" );
}

// Namespace quest_vault
// Params 0
// Checksum 0xc2863df9, Offset: 0x830
// Size: 0x1f
function set_callbacks()
{
    scriptable::scriptable_adddamagedcallback( &door_handle_damage );
    scriptable::scriptable_addusedcallbackbypart( "torch_usable", &torch_used );
}

// Namespace quest_vault
// Params 0
// Checksum 0x33c46a8e, Offset: 0x857
// Size: 0x3a4
function function_d4d2a835ad90719e()
{
    self.vault_door = getent( "vault_ee_door", #targetname );
    self.vault_door_clip = getent( "vault_ee_door_clip", #targetname );
    self.vault_door_clip linkto( self.vault_door );
    self.vault_door_clip.override_unresolved_collision = &override_unresolved_collision_vault_door;
    self.vault_door_clip.door = self.vault_door;
    self.pressure_plate = getent( "vault_pressure_plate", #targetname );
    self.pressure_plate.revealed_origin = self.pressure_plate.origin + ( 0, 0, 8 );
    self.pressure_plate.pressed_origin = self.pressure_plate.origin;
    self.pressure_plate.quest = self;
    self.pressure_plate_clip = getent( "vault_pressure_plate_clip", #targetname );
    self.pressure_plate_clip linkto( self.pressure_plate );
    self.pressure_plate.clip = self.pressure_plate_clip;
    
    if ( br_map_quest::get_setting( "use_map_assets" ) )
    {
        pressure_plate = getentitylessscriptablearray( "scriptable_quest_jup_vault_pressure_plate", #classname );
        
        if ( pressure_plate.size == 1 )
        {
            self.pressure_plate.fx_scriptable = pressure_plate[ 0 ];
        }
        else
        {
            assertmsg( "<dev string:x3a>" );
        }
    }
    
    self.vault_exit_door = getent( "vault_ee_bookshelf", #targetname );
    self.vault_exit_door_clip = getent( "vault_ee_bookshelf_clip", #targetname );
    self.vault_exit_door_clip linkto( self.vault_exit_door );
    self.vault_exit_door.clip = self.vault_exit_door_clip;
    self.vault_exit_trigger = getnoentvolumearray( "vault_exit_trigger", #targetname )[ 0 ];
    self.var_312787026c43de34 = utility::getstructarray( "vault_dragon_fire", "script_noteworthy" );
    self.var_312787026c43de34 = utility::array_sort_by_script_index( self.var_312787026c43de34 );
    
    if ( br_map_quest::get_setting( "use_map_assets" ) )
    {
        dragon_scriptables = getentitylessscriptablearray( "quest_vault_dragon_fire", #targetname );
        assert( dragon_scriptables.size > 0, "<dev string:x81>" );
        
        foreach ( obj in dragon_scriptables )
        {
            obj.script_index = int( obj.script_noteworthy );
        }
        
        dragon_scriptables = utility::array_sort_by_script_index( dragon_scriptables );
        
        for ( i = 0; i < dragon_scriptables.size ; i++ )
        {
            self.var_312787026c43de34[ i ].scriptable = dragon_scriptables[ i ];
        }
    }
    
    self.gold_sparkles = getentitylessscriptablearray( "scriptable_quest_jup_vault_gold_sparkle", #classname );
    self.var_7a754e51b396b3e3 = utility::getstructarray( "vault_equipment_spawn", "targetname" );
}

// Namespace quest_vault
// Params 0
// Checksum 0x739f13b0, Offset: 0xc03
// Size: 0xf9
function spawn_scriptables()
{
    spawn_caches();
    
    if ( !isdefined( self.pressure_plate.fx_scriptable ) )
    {
        self.pressure_plate.fx_scriptable = spawnscriptable( "quest_jup_vault_pressure_plate", self.pressure_plate.revealed_origin );
    }
    
    if ( !br_map_quest::get_setting( "use_map_assets" ) )
    {
        foreach ( loc in self.var_312787026c43de34 )
        {
            loc.scriptable = spawnscriptable( "quest_jup_vault_dragon", loc.origin, loc.angles );
        }
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xcaef0d10, Offset: 0xd04
// Size: 0x17b
function spawn_caches()
{
    lege_cache = common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", ( 3731.31, 7662.97, 902.25 ), ( 0, 60, 0 ), undefined, "wz_sat_resurgence_zone_global" );
    lege_cache setscriptablepartstate( "body", "closed_usable" );
    var_8befc77abe58f870 = common_cache::function_9bc018c1b8aad720( "br_loot_cache_personal_supply", ( 3174.5, 6959.5, 902.25 ), ( 0, 245.5, 0 ), undefined, "wz_sat_resurgence_zone_global" );
    var_8befc77abe58f870 setscriptablepartstate( "body", "closed_usable" );
    
    if ( !level.var_309e3d9dac389de6 )
    {
        var_25dbfa5bd7988530 = common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", ( 2908.64, 6425.89, 865.1 ), ( 334.278, 319.235, -24.178 ), undefined, "wz_sat_resurgence_zone_global" );
        var_25dbfa5bd7988530 setscriptablepartstate( "body", "closed_usable" );
        
        if ( game_utility::function_f24780eadd3fb772() > 2 )
        {
            var_8befca7abe58ff09 = common_cache::function_9bc018c1b8aad720( "br_loot_cache_personal_supply", ( 3286, 6936, 902.25 ), ( 0, 15, 0 ), undefined, "wz_sat_resurgence_zone_global" );
            var_8befca7abe58ff09 setscriptablepartstate( "body", "closed_usable" );
            var_25dbfd5bd7988bc9 = common_cache::function_9bc018c1b8aad720( "br_loot_cache_lege", ( 3142.32, 6621.43, 782.232 ), ( 0, 19.1337, 0 ), undefined, "wz_sat_resurgence_zone_global" );
            var_25dbfd5bd7988bc9 setscriptablepartstate( "body", "closed_usable" );
        }
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0x124e4c3f, Offset: 0xe87
// Size: 0x8e
function spawn_equipment()
{
    equipment = arrayrandomize( self.var_7a754e51b396b3e3 );
    
    for ( i = 0; i < self.num_equipment_to_spawn ; i++ )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( equipment[ i ].origin, equipment[ i ].angles );
        spawn_options.critical = 1;
        pickup = common_item::items_spawnitemfromscriptable( "brloot_offhand_molotov", 1, spawn_options );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0x6ae2c72, Offset: 0xf1d
// Size: 0x116
function function_9fbb2e2632967e20()
{
    self.throne_torches = getentitylessscriptablearray( "quest_vault_torch_throne", #targetname );
    assert( self.throne_torches.size > 0, "<dev string:xcb>" );
    self.throne_trigger_loc = utility::getstruct( "vault_throne_trigger", "script_noteworthy" );
    self.throne_trigger = spawn( "noent_volume_trigger_radius", self.throne_trigger_loc.origin, 0, 20, 56 );
    self.throne_stair_cap = getent( "vault_ee_stair_cap", #targetname );
    self.var_5fd9d7149cdc9c58 = getent( "vault_ee_stair_cap_clip", #targetname );
    self.var_5fd9d7149cdc9c58 linkto( self.throne_stair_cap );
    self.throne_stair_cap.clip = self.var_5fd9d7149cdc9c58;
    self.var_49a56cd4855caf42 = spawnscriptable( "quest_jup_vault_staircase", self.throne_stair_cap.origin + ( 0, 0, 1 ) );
}

// Namespace quest_vault
// Params 0
// Checksum 0xcba1ef65, Offset: 0x103b
// Size: 0xe5
function function_13a515bc0b50e16a()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.throne_trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) && player getstance() == "crouch" && function_9d4ccf67caaa8ac9() )
        {
            break;
        }
    }
    
    foreach ( var_c7ff9d9f68d345a8 in self.throne_torches )
    {
        var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_usable", "inactive" );
    }
    
    thread function_4dd6254bec567d62( player );
}

// Namespace quest_vault
// Params 0
// Checksum 0x72d3db22, Offset: 0x1128
// Size: 0x9b, Type: bool
function function_9d4ccf67caaa8ac9()
{
    lit_torches = 0;
    
    foreach ( loc in self.throne_torches )
    {
        if ( loc.is_lit )
        {
            lit_torches++;
        }
    }
    
    return lit_torches == self.throne_torches.size;
}

// Namespace quest_vault
// Params 1
// Checksum 0x99d060e0, Offset: 0x11cc
// Size: 0xd7
function function_4dd6254bec567d62( attacker )
{
    earthquake( 0.2, 6, self.throne_stair_cap.origin, 500 );
    self.throne_stair_cap thread mp_saw_sm_island::function_e8e714f9eead8b10( ( 0, 0, 0 ), 300, 350, 150, 1, 3 );
    self.throne_stair_cap moveto( self.throne_stair_cap.origin - ( 0, 0, 255 ), 6, 3 );
    self.throne_stair_cap thread function_213e370ba2c96cc9( attacker, 150, undefined, 0.25, 1 );
    self.var_49a56cd4855caf42 setscriptablepartstate( "staircase_fx", "moving" );
    waitframe();
    self.var_49a56cd4855caf42 setscriptablepartstate( "staircase_fx", "off" );
}

// Namespace quest_vault
// Params 5
// Checksum 0x47838018, Offset: 0x12ab
// Size: 0x1e3
function function_213e370ba2c96cc9( attacker, radius, offset = ( 0, 0, 0 ), check_time = level.framedurationseconds, add_killstreaks = 0 )
{
    level endon( #"game_ended" );
    self endon( #"movedone" );
    
    for ( ;; )
    {
        self.clip notify( #"destroy" );
        allmines = weapon::function_3aafcaf7ff6dea9e();
        objects = add_killstreaks && level.activekillstreaks.size > 0 ? arraycombineunique( allmines, level.activekillstreaks ) : allmines;
        objects = arraycombineunique( objects, level.budgetedents );
        valid_objects = function_5713d46873b29625( objects );
        nearby_objects = sortbydistancecullbyradius( valid_objects, self.origin + offset, radius );
        
        foreach ( object in nearby_objects )
        {
            if ( object.equipmentref == "equip_deployed_decoy" )
            {
                object equipment_mp::ondestroyedbytrophy();
                continue;
            }
            
            health = object.health ?? 99999;
            object notify( #"damage", health, attacker, ( 0, 0, 0 ), object.origin, "MOD_EXPLOSIVE_BULLET" );
        }
        
        wait check_time;
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xffa0da70, Offset: 0x1496
// Size: 0x2c6
function function_1899142f429c7f2()
{
    torches = getentitylessscriptablearray( "quest_vault_torch_puzzle", #targetname );
    assert( torches.size > 0, "<dev string:x112>" );
    torches = arrayrandomize( torches );
    self.vault_torches = [];
    var_eb9ded164b630cd5 = randomintrange( 3, 6 );
    var_7d3c0e52c155bcee = 2;
    
    foreach ( idx, var_c7ff9d9f68d345a8 in torches )
    {
        self.vault_torches[ var_c7ff9d9f68d345a8.script_noteworthy ] = var_c7ff9d9f68d345a8;
        var_c7ff9d9f68d345a8.correct_torch = 0;
        
        if ( idx < var_eb9ded164b630cd5 )
        {
            var_c7ff9d9f68d345a8.correct_torch = 1;
        }
        
        var_c7ff9d9f68d345a8.start_lit = utility::cointoss();
        
        if ( var_7d3c0e52c155bcee > 0 && var_c7ff9d9f68d345a8.correct_torch == var_c7ff9d9f68d345a8.start_lit )
        {
            var_c7ff9d9f68d345a8.start_lit = !var_c7ff9d9f68d345a8.correct_torch;
            var_7d3c0e52c155bcee--;
        }
    }
    
    self.hint_locations = [];
    self.hint_scriptables = [];
    hints = getentitylessscriptablearray( "scriptable_quest_jup_vault_door_hint", #classname );
    
    foreach ( hint in hints )
    {
        active = 0;
        
        foreach ( var_c7ff9d9f68d345a8 in torches )
        {
            if ( hint.script_noteworthy == var_c7ff9d9f68d345a8.script_noteworthy && var_c7ff9d9f68d345a8.correct_torch )
            {
                active = 1;
            }
        }
        
        if ( active )
        {
            hint setscriptablepartstate( "vault_door_hint", "invisible" );
            self.hint_scriptables[ int( hint.script_noteworthy ) ] = hint;
            continue;
        }
        
        hint setscriptablepartstate( "vault_door_hint", "hidden" );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xcb3b0ff7, Offset: 0x1764
// Size: 0x90, Type: bool
function function_75c17fad2aa32bd7()
{
    foreach ( var_c7ff9d9f68d345a8 in self.vault_torches )
    {
        if ( var_c7ff9d9f68d345a8.correct_torch != var_c7ff9d9f68d345a8.is_lit )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace quest_vault
// Params 0
// Checksum 0x56acd294, Offset: 0x17fd
// Size: 0x93
function function_9d853537bb0f33da()
{
    self.pressure_plate thread plate_reveal();
    
    foreach ( var_c7ff9d9f68d345a8 in self.vault_torches )
    {
        var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_usable", "inactive" );
    }
}

// Namespace quest_vault
// Params 11
// Checksum 0x46ce3e58, Offset: 0x1898
// Size: 0xdf
function door_handle_damage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    quest = br_map_quest::get_quest( "vault" );
    
    if ( !isdefined( quest ) || quest.door_opened )
    {
        return;
    }
    
    if ( instance.type != "quest_jup_vault_door" )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && isdefined( objweapon.basename ) && issubstr( objweapon.basename, "molotov" ) )
    {
        quest thread function_e2c2ab687d2c6da7();
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xdd4c9713, Offset: 0x197f
// Size: 0x115
function function_e2c2ab687d2c6da7()
{
    self notify( #"hash_211007f67f719d56" );
    self endon( #"hash_211007f67f719d56" );
    
    foreach ( hint in self.hint_scriptables )
    {
        hint setscriptablepartstate( "vault_door_hint", "visible" );
    }
    
    wait 15;
    
    foreach ( hint in self.hint_scriptables )
    {
        hint setscriptablepartstate( "vault_door_hint", "invisible" );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xbcb6c590, Offset: 0x1a9c
// Size: 0x14d
function torches_activate()
{
    if ( self.torches_active )
    {
        return;
    }
    
    self.torches_active = 1;
    
    foreach ( var_c7ff9d9f68d345a8 in self.throne_torches )
    {
        var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_usable", "inactive" );
        var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_fx", "default" );
        var_c7ff9d9f68d345a8 setscriptablepartstate( "model", "hide" );
    }
    
    thread function_13a515bc0b50e16a();
    
    foreach ( var_c7ff9d9f68d345a8 in self.vault_torches )
    {
        var_c7ff9d9f68d345a8 torch_set_state( istrue( var_c7ff9d9f68d345a8.start_lit ) );
    }
    
    function_e5f5cbe83700da9a();
    function_4d36fc86eaaa32c3();
}

// Namespace quest_vault
// Params 0
// Checksum 0xe64d9671, Offset: 0x1bf1
// Size: 0x16e
function function_e5f5cbe83700da9a()
{
    self.loot_torches = [];
    spawns = [];
    spawns[ spawns.size ] = ( 3565, 8313, 1179 );
    spawns[ spawns.size ] = ( 3584, 7897, 1155 );
    spawns[ spawns.size ] = ( 3265, 8524, 1155 );
    v = utility::array_random( spawns );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( v, ( 2, randomint( 360 ), 95 ) );
    spawnoptions.critical = 1;
    var_c7ff9d9f68d345a8 = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_saw_quest_vault_torch", 1, spawnoptions );
    var_c7ff9d9f68d345a8.criticalitem = 1;
    self.loot_torches[ self.loot_torches.size ] = var_c7ff9d9f68d345a8;
    spawns = [];
    spawns[ spawns.size ] = ( 4194, 8034, 1179 );
    spawns[ spawns.size ] = ( 3852, 7645, 1155 );
    spawns[ spawns.size ] = ( 4579, 7721, 1155 );
    v = utility::array_random( spawns );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( v, ( 2, randomint( 360 ), 95 ) );
    spawnoptions.critical = 1;
    var_c7ff9d9f68d345a8 = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_saw_quest_vault_torch", 1, spawnoptions );
    var_c7ff9d9f68d345a8.criticalitem = 1;
    self.loot_torches[ self.loot_torches.size ] = var_c7ff9d9f68d345a8;
}

// Namespace quest_vault
// Params 1
// Checksum 0x44178b51, Offset: 0x1d67
// Size: 0x51
function torch_set_state( is_lit )
{
    self.is_lit = is_lit;
    self setscriptablepartstate( "torch_usable", is_lit ? "usable_lit" : "usable_unlit" );
    self setscriptablepartstate( "torch_fx", is_lit ? "torch_lit" : "torch_unlit" );
}

// Namespace quest_vault
// Params 0
// Checksum 0x7cad03d6, Offset: 0x1dc0
// Size: 0x13
function torch_toggle()
{
    torch_set_state( !self.is_lit );
}

// Namespace quest_vault
// Params 6
// Checksum 0x7ba6b958, Offset: 0x1ddb
// Size: 0x87
function torch_used( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance ) )
    {
        instance torch_toggle();
        
        if ( instance.targetname == "quest_vault_torch_puzzle" )
        {
            quest = br_map_quest::get_quest( "vault" );
            
            if ( quest function_75c17fad2aa32bd7() )
            {
                quest thread function_9d853537bb0f33da();
            }
        }
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0xc37013ab, Offset: 0x1e6a
// Size: 0xbb
function function_4d36fc86eaaa32c3()
{
    self.throne_torches = arrayrandomize( self.throne_torches );
    absent = self.throne_torches[ 0 ];
    interact = interaction::register_interact( absent.origin, 64, &function_b554038ab76a23a9 );
    interact interaction::set_interact_hint_callback( &function_7f2f4ae5225642e7 );
    interact.var_c7ff9d9f68d345a8 = absent;
    interact interaction::function_3d5329c553924b3();
    interact.quest = self;
    present = self.throne_torches[ 1 ];
    present setscriptablepartstate( "torch_usable", "usable_unlit" );
    present setscriptablepartstate( "model", "show" );
}

// Namespace quest_vault
// Params 1
// Checksum 0xdda94579, Offset: 0x1f2d
// Size: 0x16c
function function_b554038ab76a23a9( player )
{
    if ( player br_quest_inventory::consume_quest_item( "wz_consumable_saw_quest_vault_torch" ) )
    {
        self.var_c7ff9d9f68d345a8 setscriptablepartstate( "model", "show" );
        self.var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_usable", "usable_unlit" );
        self.var_c7ff9d9f68d345a8 setscriptablepartstate( "torch_fx", "torch_placed" );
        
        foreach ( loot in self.quest.loot_torches )
        {
            if ( loot )
            {
                loot freescriptable();
            }
        }
        
        self delete();
        
        foreach ( p in level.players )
        {
            p br_quest_inventory::consume_quest_item( "wz_consumable_saw_quest_vault_torch" );
        }
    }
}

// Namespace quest_vault
// Params 2
// Checksum 0xf6c82747, Offset: 0x20a1
// Size: 0x68
function function_7f2f4ae5225642e7( interact, player )
{
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_saw_quest_vault_torch" ) )
    {
        return { #string:&"hash_4617f9213db8d51", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace quest_vault
// Params 1
// Checksum 0x235247ff, Offset: 0x2112
// Size: 0x20f
function door_open( puzzle_completed )
{
    level endon( #"game_ended" );
    self.door_opened = 1;
    self notify( #"hash_211007f67f719d56" );
    
    foreach ( hint in self.hint_scriptables )
    {
        hint setscriptablepartstate( "vault_door_hint", "hidden" );
    }
    
    self.vault_exit_trigger thread function_e2ebac0a84aa765e();
    self.vault_door rotateby( ( 0, -100, 0 ), 8, 3, 2 );
    earthquake( 0.2, 0.25, self.vault_door.origin, 512 );
    self.vault_door setscriptablepartstate( "door_fx", "opening" );
    waitframe();
    self.vault_door setscriptablepartstate( "door_fx", "off" );
    
    foreach ( sparkle in self.gold_sparkles )
    {
        sparkle setscriptablepartstate( "sparkle_fx", "sparkle" );
        sparkle thread function_b16ec20743327b87();
    }
    
    if ( self.treasure_sparkle_timer > -1 )
    {
        thread treasure_sparkle_timer();
    }
    
    self.vault_door waittill( #"rotatedone" );
    earthquake( 0.2, 0.25, self.vault_door.origin, 512 );
}

// Namespace quest_vault
// Params 0
// Checksum 0xc2f4fc0c, Offset: 0x2329
// Size: 0x75
function function_b16ec20743327b87()
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "vault" );
    quest endon( #"hash_fba83cb381c15145" );
    
    while ( true )
    {
        wait randomfloatrange( 0.25, 1 );
        self setscriptablepartstate( "sparkle_fx", "off" );
        wait randomfloatrange( 1.5, 3.5 );
        self setscriptablepartstate( "sparkle_fx", "sparkle" );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0x81b21f1b, Offset: 0x23a6
// Size: 0xa5
function treasure_sparkle_timer()
{
    level endon( #"game_ended" );
    wait self.treasure_sparkle_timer;
    self notify( #"hash_fba83cb381c15145" );
    
    foreach ( sparkle in self.gold_sparkles )
    {
        sparkle setscriptablepartstate( "sparkle_fx", "off" );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0x9d63b084, Offset: 0x2453
// Size: 0x8f
function plate_reveal()
{
    level endon( #"game_ended" );
    wait 1;
    self moveto( self.revealed_origin, 3 );
    self.fx_scriptable setscriptablepartstate( "plate_fx", "moving_up" );
    waitframe();
    self.fx_scriptable setscriptablepartstate( "plate_fx", "off" );
    wait 3;
    plate_trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 7, 20 );
    plate_trigger.pressure_plate = self;
    plate_trigger thread plate_watch_trigger();
}

// Namespace quest_vault
// Params 0
// Checksum 0xb6ee5449, Offset: 0x24ea
// Size: 0xc4
function plate_watch_trigger()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            break;
        }
    }
    
    self.pressure_plate thread plate_move_down();
    self.pressure_plate.fx_scriptable setscriptablepartstate( "plate_fx", "moving_down" );
    waitframe();
    self.pressure_plate.fx_scriptable setscriptablepartstate( "plate_fx", "off" );
    function_972bd0bccb0bdd9d( ent.team );
    self.pressure_plate.quest thread quest_complete( ent );
    self delete();
}

// Namespace quest_vault
// Params 1
// Checksum 0x13d8982d, Offset: 0x25b6
// Size: 0x3ba
function function_972bd0bccb0bdd9d( team )
{
    level endon( #"game_ended" );
    var_62c6cbf94d8e8ec8 = self.pressure_plate.quest.var_312787026c43de34;
    var_62c6cbf94d8e8ec8[ 1 ].scriptable setscriptablepartstate( "dragon_fx", "activated" );
    wait 0.75;
    var_62c6cbf94d8e8ec8[ 0 ].scriptable setscriptablepartstate( "dragon_fx", "activated" );
    var_62c6cbf94d8e8ec8[ 2 ].scriptable setscriptablepartstate( "dragon_fx", "activated" );
    wait 1.25;
    
    foreach ( obj in var_62c6cbf94d8e8ec8 )
    {
        obj.scriptable setscriptablepartstate( "dragon_fx", "off" );
    }
    
    self.pressure_plate.quest thread door_open();
    wait 1;
    
    for ( i = 0; i < 16 ; i++ )
    {
        random_fire_index = randomint( var_62c6cbf94d8e8ec8.size );
        var_62c6cbf94d8e8ec8[ random_fire_index ].scriptable setscriptablepartstate( "dragon_fx", "activated" );
        wait 0.25;
        var_62c6cbf94d8e8ec8[ random_fire_index ].scriptable setscriptablepartstate( "dragon_fx", "off" );
    }
    
    foreach ( obj in var_62c6cbf94d8e8ec8 )
    {
        obj.scriptable setscriptablepartstate( "dragon_fx", "activated" );
    }
    
    wait 3;
    self.pressure_plate.quest.vault_door waittill( #"rotatedone" );
    wait 0.15;
    
    foreach ( obj in var_62c6cbf94d8e8ec8 )
    {
        obj.scriptable setscriptablepartstate( "dragon_fx", "off" );
    }
    
    var_3d56069ba09cd984 = function_f02c63b99c9614c9( level.allteamnamelist, team );
    nearby_players = getplayersinradius( self.pressure_plate.quest.vault_door.origin, self.pressure_plate.quest br_map_quest::get_setting( "splash_range" ) );
    
    foreach ( player in nearby_players )
    {
        player thread hud_message::showsplash( "quest_vault_complete", var_3d56069ba09cd984, undefined, undefined, undefined, "splash_list_mp_saw_sm_island" );
    }
}

// Namespace quest_vault
// Params 0
// Checksum 0x850445fa, Offset: 0x2978
// Size: 0x22
function plate_move_down()
{
    level endon( #"game_ended" );
    self moveto( self.pressed_origin, 0.5 );
}

// Namespace quest_vault
// Params 1
// Checksum 0xbfb582d8, Offset: 0x29a2
// Size: 0x4c
function quest_complete( player )
{
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:1 };
    br_map_quest::on_completed( params );
}

// Namespace quest_vault
// Params 0
// Checksum 0xfead74bb, Offset: 0x29f6
// Size: 0x101
function function_e2ebac0a84aa765e()
{
    level endon( #"game_ended" );
    quest = br_map_quest::get_quest( "vault" );
    self waittill( #"trigger", player );
    earthquake_origin = quest.vault_exit_door.origin;
    earthquake( 0.15, 4, earthquake_origin, 400 );
    quest.vault_exit_door moveto( quest.vault_exit_door.origin - ( 0, 0, 128 ), 4, 2 );
    quest.vault_exit_door thread function_213e370ba2c96cc9( player, 80, ( 0, 0, 60 ), 0.25, 0 );
    quest.vault_exit_door setscriptablepartstate( "alt_exit_fx", "moving" );
    waitframe();
    quest.vault_exit_door setscriptablepartstate( "alt_exit_fx", "off" );
}

// Namespace quest_vault
// Params 2
// Checksum 0xbf5c8a3, Offset: 0x2aff
// Size: 0x5e
function override_unresolved_collision_vault_door( player, ballowsuicide )
{
    var_4165bc37f897eb54 = player.origin - self.door.origin;
    player.origin += vectornormalize( var_4165bc37f897eb54 );
}

/#

    // Namespace quest_vault
    // Params 0
    // Checksum 0x2fef4bc2, Offset: 0x2b65
    // Size: 0xe4, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x158>" + "<dev string:x167>" );
        devgui::add_devgui_func( "<dev string:x16e>", "<dev string:x187>", &function_1021e74e489da098 );
        devgui::add_devgui_func( "<dev string:x1b0>", "<dev string:x1bc>", &function_3343e051a4c128f5 );
        devgui::add_devgui_func( "<dev string:x1dd>", "<dev string:x1ea>", &function_46e70eee3283cd11 );
        devgui::add_devgui_func( "<dev string:x20c>", "<dev string:x21f>", &debug_show_answers );
        devgui::add_devgui_func( "<dev string:x242>", "<dev string:x258>", &function_494f904d7034e54 );
        devgui::add_devgui_func( "<dev string:x27a>", "<dev string:x28a>", &function_839c30bead266d9e );
        devgui::add_devgui_func( "<dev string:x2af>", "<dev string:x2c0>", &function_579221d1d3ef74e2 );
        devgui::add_devgui_func( "<dev string:x2e6>", "<dev string:x2f4>", &function_adcb57dbd09823c7 );
        devgui::add_devgui_func( "<dev string:x317>", "<dev string:x326>", &function_cb2bd5df44c76643 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xe505519a, Offset: 0x2c51
    // Size: 0x5a, Type: dev
    function function_1021e74e489da098()
    {
        if ( !getdvarint( @"hash_cebd24290d081246" ) )
        {
            iprintlnbold( "<dev string:x34a>" );
            setdvar( @"hash_cebd24290d081246", 1 );
            function_c7b372a8e15f00f0();
            return;
        }
        
        iprintlnbold( "<dev string:x376>" );
        setdvar( @"hash_cebd24290d081246", 0 );
        function_8ec9af67a416a16a();
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xa4b48d9b, Offset: 0x2cb3
    // Size: 0xa2, Type: dev
    function function_c7b372a8e15f00f0()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        
        foreach ( var_c7ff9d9f68d345a8 in quest.loot_torches )
        {
            debug::sphere( var_c7ff9d9f68d345a8, 50, "<dev string:x3a9>", undefined, "<dev string:x3ad>" );
        }
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xeb2d1194, Offset: 0x2d5d
    // Size: 0x11, Type: dev
    function function_8ec9af67a416a16a()
    {
        level notify( #"hash_e1f2dcb5ab4b9755" );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0x6df85739, Offset: 0x2d76
    // Size: 0xaf, Type: dev
    function function_3343e051a4c128f5()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        
        foreach ( var_c7ff9d9f68d345a8 in quest.throne_torches )
        {
            var_c7ff9d9f68d345a8 setscriptablepartstate( "<dev string:x3d0>", "<dev string:x3dd>" );
        }
        
        quest thread function_4dd6254bec567d62( level.player );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xd1b6926, Offset: 0x2e2d
    // Size: 0x25, Type: dev
    function function_494f904d7034e54()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        quest thread function_9d853537bb0f33da();
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xa7be29c5, Offset: 0x2e5a
    // Size: 0x25, Type: dev
    function function_839c30bead266d9e()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        quest thread door_open();
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0xecbb0bd7, Offset: 0x2e87
    // Size: 0xe8, Type: dev
    function function_adcb57dbd09823c7()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        earthquake_origin = quest.vault_exit_door.origin;
        earthquake( 0.15, 4, earthquake_origin, 400 );
        quest.vault_exit_door moveto( quest.vault_exit_door.origin - ( 0, 0, 128 ), 4, 2 );
        quest.vault_exit_door thread function_213e370ba2c96cc9( level.player, 80, ( 0, 0, 60 ), 0.25, 0 );
        quest.vault_exit_door setscriptablepartstate( "<dev string:x3e6>", "<dev string:x3f2>" );
        waitframe();
        quest.vault_exit_door setscriptablepartstate( "<dev string:x3e6>", "<dev string:x3f9>" );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0x67cecaa5, Offset: 0x2f77
    // Size: 0x51, Type: dev
    function function_46e70eee3283cd11()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        quest.throne_stair_cap moveto( quest.throne_stair_cap.origin + ( 0, 0, 255 ), 1 );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0x1782c537, Offset: 0x2fd0
    // Size: 0x3b, Type: dev
    function function_579221d1d3ef74e2()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        quest.vault_door rotateby( ( 0, 100, 0 ), 1 );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0x4cac2407, Offset: 0x3013
    // Size: 0x51, Type: dev
    function function_cb2bd5df44c76643()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        quest.vault_exit_door moveto( quest.vault_exit_door.origin + ( 0, 0, 128 ), 1 );
    }

    // Namespace quest_vault
    // Params 0
    // Checksum 0x57737fcc, Offset: 0x306c
    // Size: 0x43, Type: dev
    function debug_show_answers()
    {
        quest = br_map_quest::get_quest( "<dev string:x3a3>" );
        
        if ( quest.debug_show_answers )
        {
            quest.debug_show_answers = 0;
            return;
        }
        
        quest thread function_395d0a91d0d9a1ac();
    }

    // Namespace quest_vault
    // Params 0, eflags: 0x4
    // Checksum 0x7c459982, Offset: 0x30b7
    // Size: 0x166, Type: dev
    function private function_395d0a91d0d9a1ac()
    {
        level endon( #"game_ended" );
        self.debug_show_answers = 1;
        printduration = int( 0.5 / level.framedurationseconds );
        
        while ( self.debug_show_answers )
        {
            foreach ( var_c7ff9d9f68d345a8 in self.vault_torches )
            {
                origin = var_c7ff9d9f68d345a8.origin + ( 0, 0, 20 );
                correct = var_c7ff9d9f68d345a8.correct_torch ? "<dev string:x3fd>" : "<dev string:x400>";
                color = var_c7ff9d9f68d345a8.correct_torch == var_c7ff9d9f68d345a8.is_lit ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                print3d( origin, "<dev string:x404>" + correct, color, 1, 0.2, printduration, 1 );
            }
            
            wait 0.5;
        }
    }

#/
