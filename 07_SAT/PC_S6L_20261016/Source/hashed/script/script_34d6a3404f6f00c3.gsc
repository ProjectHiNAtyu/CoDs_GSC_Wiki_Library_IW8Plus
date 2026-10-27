// script_34d6a3404f6f00c3  (hash_34d6a3404f6f00c3.gscc) (size: 16950 Bytes / 0x4236 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65647199 (1701081497)
// size ...... 16950 (0x4236)
// includes .. 17  (offset: 0x3d4a)
// strings ... 65  (offset: 0x3dd2)
// dev strs .. 3   (offset: 0x420e)
// exports ... 46  (offset: 0x2a5a)
// cseg ...... 0x64a + 0x2410 (0x2a5a)
// imports ... 93  (offset: 0x318a)
// animtree1 . 0   (offset: 0x4236)
// animtree2 . 0   (offset: 0x4236)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_sidequest_access_card;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace quest_armory;

// Namespace quest_armory
// Params 0, eflags: 0x5
// Checksum 0xcb6cdd18, Offset: 0x668
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"armory", #"br_map_quest", &init, undefined );
}

// Namespace quest_armory
// Params 0
// Checksum 0x3082ba19, Offset: 0x691
// Size: 0x5e
function init()
{
    quest = { #on_disabled:&on_disabled, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_init:&on_init, #name:"armory" };
    br_map_quest::register( quest );
}

// Namespace quest_armory
// Params 0
// Checksum 0x7f61a0da, Offset: 0x6f7
// Size: 0x1e
function on_init()
{
    thread power_outage_init();
    thread water_treatment_init();
    thread missile_factory_init();
    thread armory_init();
}

// Namespace quest_armory
// Params 0
// Checksum 0x2e9a0dcf, Offset: 0x71d
// Size: 0x4e
function on_start()
{
    if ( self.power_outage.reader.blocker )
    {
        self.power_outage.reader.blocker setscriptablepartstate( "state", "hidden" );
    }
}

// Namespace quest_armory
// Params 0
// Checksum 0x50ec7e27, Offset: 0x773
// Size: 0x42
function on_prematch_end()
{
    self.power_outage thread power_outage_setup();
    self.water_treatment thread water_treatment_setup();
    self.missile_factory thread missile_factory_setup();
    self.armory thread armory_setup();
}

// Namespace quest_armory
// Params 0
// Checksum 0x18144e5c, Offset: 0x7bd
// Size: 0x17
function on_disabled()
{
    utility::trigger_off( "easter_egg_trigger", #script_noteworthy );
}

/#

    // Namespace quest_armory
    // Params 0
    // Checksum 0xf93a235c, Offset: 0x7dc
    // Size: 0x5, Type: dev
    function function_8e607339c5e5bb82()
    {
        
    }

#/

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x2684f62c, Offset: 0x7e9
// Size: 0x352
function private power_outage_init()
{
    power_outage = spawnstruct();
    power_outage.name = "power_outage";
    power_outage.is_enabled = getdvarint( @"hash_f361375c9ace6412", 1 );
    self.power_outage = power_outage;
    
    if ( !power_outage.is_enabled )
    {
        return;
    }
    
    struct = utility::getstruct( "power_outage_ee", "script_noteworthy" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    structs = utility::getstructarray( struct.target, "targetname" );
    scriptables = getentitylessscriptablearray( struct.target, "targetname" );
    
    foreach ( struct in structs )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_dd2f5122e4b11f7e":
                power_outage.boxspawn = struct;
                break;
            case #"hash_3fb762d5144625fe":
                power_outage.rewardspawn = struct;
                break;
        }
    }
    
    foreach ( scriptable in scriptables )
    {
        switch ( scriptable.script_noteworthy )
        {
            case #"hash_8b32462b3d484425":
                power_outage.terminal = scriptable;
                interaction::register_scriptable_interact( power_outage.terminal, &function_81b1bd00de43b6a0 );
                break;
            case #"hash_e84006448dd5112a":
                power_outage.reader = scriptable;
                interaction::register_scriptable_interact( power_outage.reader, &card_reader_used );
                power_outage.reader.trigger = getent( scriptable.script_linkto, #script_linkname );
                
                if ( !isdefined( power_outage.reader.trigger ) )
                {
                    power_outage.reader.trigger = getnoentvolumearray( scriptable.script_linkto, #script_linkname )[ 0 ];
                }
                
                power_outage.reader.blocker = getentitylessscriptablearray( power_outage.reader.target, #targetname )[ 0 ];
                break;
            case #"hash_6d033b15666a897b":
                power_outage.completion = scriptable;
                break;
        }
    }
    
    self.power_outage.door = get_scriptable( "scriptable_t10_door_industrial_metal_mp_01", "classname", ( 3493, 6251.5, 381 ), 64 );
    self.power_outage = power_outage;
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x7aa4a2e1, Offset: 0xb43
// Size: 0x79
function private power_outage_setup()
{
    level endon( #"game_ended" );
    
    if ( !self.is_enabled )
    {
        return;
    }
    
    spawn_crate( self.boxspawn.origin, self.boxspawn.angles );
    self.reader setscriptablepartstate( "base", "usable" );
    self.terminal setscriptablepartstate( "base", "usable" );
}

// Namespace quest_armory
// Params 2, eflags: 0x4
// Checksum 0x7d91a1fa, Offset: 0xbc4
// Size: 0x4a
function private spawn_crate( origin, angles )
{
    scriptable::scriptable_adddamagedcallback( &crate_damaged );
    crate = spawnscriptable( "escape_health_ee", origin, angles );
    crate setscriptablepartstate( "alive", "reactive" );
}

// Namespace quest_armory
// Params 11, eflags: 0x4
// Checksum 0x42003611, Offset: 0xc16
// Size: 0x13c
function private crate_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( isdefined( instance ) && isdefined( instance.classname ) ) || instance.type != "escape_health_ee" )
    {
        return;
    }
    
    quest = br_sidequest_access_card::initquest( "guild_power" );
    itembundle = common_item::function_cf68ad18114498b2( "wz_consumable_access_card_guild_power" );
    itemspawnoptions = common_item::items_initspawnoptions_spawnfromposition( instance.origin, instance.angles - ( 0, 90, 0 ) );
    waittillframeend();
    accesscard = common_item::function_61c2c0251e742ffd( itembundle, undefined, itemspawnoptions );
    br_sidequest_access_card::createquestinstance( quest, accesscard );
    level.br_map_quest.quests[ "armory" ].power_outage thread function_a5dcccdfb85bf6fd();
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0xea7e78e4, Offset: 0xd5a
// Size: 0xd8
function private card_reader_used( player )
{
    level endon( #"game_ended" );
    power_outage = level.br_map_quest.quests[ "armory" ].power_outage;
    
    if ( br_sidequest_access_card::hasaccesscard( player, "guild_power" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_access_card_guild_power" );
        self setscriptablepartstate( "base", "on" );
        spawn_pickup( "brloot_killstreak_uav", power_outage.rewardspawn.origin, power_outage.rewardspawn.angles );
        
        if ( self.trigger )
        {
            self.trigger utility::trigger_off();
        }
        
        power_outage.door scriptabledoorfreeze( 0 );
    }
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0xe7b04a93, Offset: 0xe3a
// Size: 0xa2
function private function_81b1bd00de43b6a0( player )
{
    power_outage = level.br_map_quest.quests[ "armory" ].power_outage;
    self setscriptablepartstate( "base", "on" );
    points::function_40522c040a4e7b1( player.team, #"hash_ddd32e923472b931" );
    power_outage.completion setscriptablepartstate( "base", "on" );
    power_outage.is_completed = 1;
    power_outage analytics_quest_completed( 1, player );
    armory_puzzle_completed();
}

/#

    // Namespace quest_armory
    // Params 0
    // Checksum 0x41e1d083, Offset: 0xee4
    // Size: 0x5, Type: dev
    function function_6057f7ddc74afdd9()
    {
        
    }

#/

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x587016, Offset: 0xef1
// Size: 0x249
function private water_treatment_init()
{
    water_treatment = spawnstruct();
    water_treatment.name = "water_treatment";
    water_treatment.is_enabled = getdvarint( @"hash_e68e24cf953fa6cb", 1 );
    self.water_treatment = water_treatment;
    
    if ( !self.water_treatment.is_enabled )
    {
        return;
    }
    
    struct = utility::getstruct( "water_treatment_ee", "script_noteworthy" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    water_treatment.terminals = [];
    water_treatment.meters = [];
    water_treatment.rewardspawn = utility::getstruct( struct.target, "targetname" );
    scriptables = getentitylessscriptablearray( struct.target, "targetname" );
    
    foreach ( scriptable in scriptables )
    {
        switch ( scriptable.script_noteworthy )
        {
            case #"hash_813ce2bfa870b9a4":
                water_treatment.terminals[ water_treatment.terminals.size ] = scriptable;
                scriptable.script_index = int( scriptable.script_parameters );
                interaction::register_scriptable_interact( scriptable, &water_terminal_used );
                break;
            case #"hash_aa7f5e556f4042ad":
                scriptable.solution = get_scriptable( scriptable.target, "targetname" );
                water_treatment.meters[ water_treatment.meters.size ] = scriptable;
                break;
            case #"hash_5d04e0ff1640be3":
                water_treatment.resetbutton = scriptable;
                interaction::register_scriptable_interact( scriptable, &reset_water_level );
                break;
            case #"hash_5ee106e836761ada":
                water_treatment.completion = scriptable;
                break;
        }
    }
    
    self.water_treatment = water_treatment;
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x905e8c51, Offset: 0x1142
// Size: 0x239
function private water_treatment_setup()
{
    level endon( #"game_ended" );
    
    if ( !self.is_enabled )
    {
        return;
    }
    
    assert( self.meters.size == 3, "<dev string:x24>" );
    self.meters = utility::array_sort_by_script_index( self.meters );
    self.meters[ 0 ].code = randomintrange( 7, 10 );
    self.meters[ 1 ].code = randomintrange( 1, 4 );
    self.meters[ 2 ].code = randomintrange( 4, 7 );
    
    foreach ( meter in self.meters )
    {
        meter.value = 0;
        meter.solution setscriptablepartstate( "base", "number_" + meter.code );
    }
    
    assert( self.terminals.size == 3, "<dev string:x24>" );
    self.terminals = arrayrandomize( self.terminals );
    self.terminals[ 0 ].tanks = [ self.meters[ 0 ] ];
    self.terminals[ 1 ].tanks = [ self.meters[ 0 ], self.meters[ 2 ] ];
    self.terminals[ 2 ].tanks = [ self.meters[ 0 ], self.meters[ 1 ], self.meters[ 2 ] ];
    self.resetbutton setscriptablepartstate( "base", "usable" );
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0xcc63da17, Offset: 0x1383
// Size: 0x1b0
function private water_terminal_used( player )
{
    water_treatment = level.br_map_quest.quests[ "armory" ].water_treatment;
    water_treatment.resetbutton setscriptablepartstate( "base", "cooldown" );
    self setscriptablepartstate( "base", "used_" + self.script_parameters );
    others = arrayremove( water_treatment.terminals, self );
    
    foreach ( terminal in others )
    {
        terminal setscriptablepartstate( "base", "cooldown_" + terminal.script_parameters );
    }
    
    foreach ( tank in self.tanks )
    {
        if ( tank.value < 9 )
        {
            tank thread rise_water_level();
        }
    }
    
    wait 2;
    
    if ( !water_treatment.is_completed )
    {
        player water_treatment_success();
    }
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x46624e3, Offset: 0x153b
// Size: 0xa1
function private reset_water_level( player )
{
    button = self;
    water_treatment = level.br_map_quest.quests[ "armory" ].water_treatment;
    
    if ( !button.initialized )
    {
        button.initialized = 1;
        button setscriptablepartstate( "base", "on" );
        water_treatment turn_on_terminals();
        water_treatment thread function_a5dcccdfb85bf6fd();
        return;
    }
    
    button setscriptablepartstate( "base", "cooldown" );
    empty_water_tanks();
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xd136df3e, Offset: 0x15e4
// Size: 0x45
function private rise_water_level()
{
    level endon( #"game_ended" );
    self.value++;
    self setscriptablepartstate( "base", "water_rising" );
    wait 2;
    self setscriptablepartstate( "base", "number_" + self.value );
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xe14efdc6, Offset: 0x1631
// Size: 0x1ae
function private turn_on_terminals()
{
    water_treatment = self;
    order = utility::array_sort_by_script_index( water_treatment.terminals );
    
    foreach ( terminal in order )
    {
        wait 0.25;
        terminal setscriptablepartstate( "base", "on" );
    }
    
    foreach ( tank in water_treatment.meters )
    {
        wait 0.25;
        tank setscriptablepartstate( "base", "water_lowering" );
    }
    
    wait 3;
    
    foreach ( terminal in order )
    {
        terminal setscriptablepartstate( "base", "terminal_" + terminal.script_index );
    }
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x937c4c3a, Offset: 0x17e7
// Size: 0x15e
function private empty_water_tanks()
{
    water_treatment = level.br_map_quest.quests[ "armory" ].water_treatment;
    order = utility::array_sort_by_script_index( water_treatment.terminals );
    
    foreach ( terminal in order )
    {
        terminal setscriptablepartstate( "base", "cooldown_" + terminal.script_parameters );
    }
    
    foreach ( tank in water_treatment.meters )
    {
        tank.value = 0;
        tank setscriptablepartstate( "base", "water_lowering" );
    }
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x9d0cae12, Offset: 0x194d
// Size: 0x261
function private water_treatment_success()
{
    player = self;
    water_treatment = level.br_map_quest.quests[ "armory" ].water_treatment;
    
    foreach ( tank in water_treatment.meters )
    {
        if ( tank.value == tank.code )
        {
            continue;
        }
        
        return;
    }
    
    water_treatment.resetbutton setscriptablepartstate( "base", "success" );
    
    foreach ( terminal in water_treatment.terminals )
    {
        terminal setscriptablepartstate( "base", "disabled" );
    }
    
    water_treatment.completion setscriptablepartstate( "base", "on" );
    water_treatment.is_completed = 1;
    teammatecount = teams::getsquadmates( player.team, player.sessionsquadid, 0 ).size;
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_sidequest_water" );
    var_8b5270de14dff72e = common_item::items_selectfromlist( var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount );
    
    if ( var_8b5270de14dff72e.size > 0 )
    {
        for ( i = 1; i < teammatecount ; i++ )
        {
            var_8b5270de14dff72e[ var_8b5270de14dff72e.size ] = var_8b5270de14dff72e[ 1 ];
        }
    }
    
    water_treatment.rewardspawn thread spawn_rewards( var_8b5270de14dff72e );
    points::function_40522c040a4e7b1( player.team, #"hash_9e2081b0d3e94948" );
    water_treatment analytics_quest_completed( 1, player );
    armory_puzzle_completed();
}

/#

    // Namespace quest_armory
    // Params 0
    // Checksum 0xe01e6334, Offset: 0x1bb6
    // Size: 0x5, Type: dev
    function function_26d9622de3ab0328()
    {
        
    }

#/

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x8baf18bd, Offset: 0x1bc3
// Size: 0x2a1
function private missile_factory_init()
{
    missile_factory = spawnstruct();
    missile_factory.name = "missile_factory";
    missile_factory.is_enabled = getdvarint( @"hash_a52e1fc126440339", 1 );
    self.missile_factory = missile_factory;
    
    if ( !missile_factory.is_enabled )
    {
        return;
    }
    
    struct = utility::getstruct( "missile_factory_ee", "script_noteworthy" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    missile_factory.rewardspawns = [];
    missile_factory.rewards = [];
    missile_factory.lootitems = [ "brloot_perk_alertness", "brloot_perk_resolute", "brloot_perk_tempered", "brloot_perk_ghost", "brloot_super_utilitybox" ];
    structs = utility::getstructarray( struct.target, "targetname" );
    scriptables = getentitylessscriptablearray( struct.target, "targetname" );
    missile_factory.door = get_scriptable( "ee_keypad_door", "script_noteworthy" );
    
    foreach ( struct in structs )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_5fd19f51a5296d9f":
                missile_factory.keypadspawn = struct;
                break;
            case #"hash_c00d7b5611ea2ff0":
                missile_factory.rewardspawns[ missile_factory.rewardspawns.size ] = struct;
                break;
        }
    }
    
    foreach ( scriptable in scriptables )
    {
        switch ( scriptable.script_noteworthy )
        {
            case #"hash_d9cee2365db21f46":
                missile_factory.screen = scriptable;
                break;
            case #"hash_9a1557fba692a159":
                missile_factory.completion = scriptable;
                break;
        }
    }
    
    self.missile_factory = missile_factory;
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xbebdf2ef, Offset: 0x1e6c
// Size: 0x73
function private missile_factory_setup()
{
    level endon( #"game_ended" );
    
    if ( !self.is_enabled )
    {
        return;
    }
    
    spawn_keypad();
    self.screen setscriptablepartstate( "base", self.keypad.code[ "string" ] );
    self.rewardspawns = utility::array_sort_by_script_index( self.rewardspawns );
    function_fa42249685682a2f( "br_sidequest_factory" );
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x1509736c, Offset: 0x1ee7
// Size: 0x74
function private spawn_keypad()
{
    self.keypad = spawnscriptable( "maphint_keypad_bunker_interior", self.keypadspawn.origin, self.keypadspawn.angles );
    self.keypad.successfunction = &keypad_success;
    self.keypad function_fa6afd60c6bfe12();
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_interior", &keypadscriptableused );
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x7764d4d2, Offset: 0x1f63
// Size: 0xe4
function private keypad_success( instance )
{
    player = self;
    missile_factory = level.br_map_quest.quests[ "armory" ].missile_factory;
    
    if ( missile_factory.is_completed )
    {
        return;
    }
    
    missile_factory.is_completed = 1;
    missile_factory.completion setscriptablepartstate( "base", "on" );
    utility::exploder( "vfx_esc5_ee_mak_door_open_left" );
    missile_factory.door setscriptablepartstate( "base", "move_left_trigger_linked" );
    function_531bb5c3d43c466c( missile_factory.rewards );
    points::function_40522c040a4e7b1( player.team, #"hash_f8285e85dd5382a2" );
    missile_factory analytics_quest_completed( 1, player );
    armory_puzzle_completed();
}

// Namespace quest_armory
// Params 6, eflags: 0x4
// Checksum 0x332d1f6a, Offset: 0x204f
// Size: 0x48
function private keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace quest_armory
// Params 5, eflags: 0x4
// Checksum 0x6d2d87a7, Offset: 0x209f
// Size: 0x94
function private _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x50>" || part == "<dev string:x6f>" );
    instance setscriptablepartstate( part, "off" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    wait 1;
    
    if ( instance.codestatus != 2 )
    {
        instance setscriptablepartstate( part, "on" );
    }
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xbc4aa6b4, Offset: 0x213b
// Size: 0x6f
function private function_fa6afd60c6bfe12()
{
    codestruct = self;
    codestruct.code = [];
    solutions = [ "95248742", "22171351", "49471143", "76679861", "53333082" ];
    codestruct.code[ "string" ] = solutions[ randomint( solutions.size ) ];
}

/#

    // Namespace quest_armory
    // Params 0
    // Checksum 0xc8d625f8, Offset: 0x21b2
    // Size: 0x5, Type: dev
    function function_6c8291eb86d417c7()
    {
        
    }

#/

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0x700a1318, Offset: 0x21bf
// Size: 0x10b
function private armory_init()
{
    armory = spawnstruct();
    armory.is_enabled = getdvarint( @"hash_b5d209d58981d0b0", 1 );
    self.armory = armory;
    
    if ( !armory.is_enabled )
    {
        return;
    }
    
    game[ "dialog" ][ "armoryBlueprintUnlock" ] = "reew_wzan_cofi";
    armory.rewards = [];
    armory.button = get_scriptable( "makarov_blueprint_ee", "script_noteworthy" );
    interaction::register_scriptable_interact( armory.button, &function_6e0d37e08069dbcb );
    armory.door = get_scriptable( "ee_blueprint_door", "script_noteworthy" );
    armory.rewardspawns = utility::getstructarray( armory.button.target, "targetname" );
    armory.rewardspawns = utility::array_sort_by_script_index( armory.rewardspawns );
    self.armory = armory;
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xcb677898, Offset: 0x22d2
// Size: 0x3e
function private armory_setup()
{
    level endon( #"game_ended" );
    
    if ( !self.is_enabled )
    {
        return;
    }
    
    level callback::add( #"player_item_pickup", &on_item_pickup );
    function_fa42249685682a2f( "br_sidequest_armory" );
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x2ad94844, Offset: 0x2318
// Size: 0xb6
function private function_6e0d37e08069dbcb( player )
{
    quest = level.br_map_quest.quests[ "armory" ];
    armory = quest.armory;
    self setscriptablepartstate( "base", "disabled" );
    utility::exploder( "vfx_esc5_ee_mak_door_open_right" );
    armory.door setscriptablepartstate( "base", "move_right_trigger_linked" );
    function_531bb5c3d43c466c( armory.rewards );
    points::function_40522c040a4e7b1( player.team, #"br_escape_access_granted" );
    quest analytics_quest_completed( 1, player );
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x96749680, Offset: 0x23d6
// Size: 0xc7, Type: bool
function private function_a4443d7df1b90931( player )
{
    br_public::brleaderdialogteam( "armoryBlueprintUnlock", player.team, 1, 0, undefined, "dx_br_mpje_" );
    teamplayers = teams::getteamdata( player.team, "players" );
    
    foreach ( teamplayer in teamplayers )
    {
        challenges::function_37e945722d6497f3( teamplayer, "escape_sidequest_armory", 1 );
    }
    
    return true;
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xbce933f, Offset: 0x24a6
// Size: 0x95
function private armory_puzzle_completed()
{
    quest = level.br_map_quest.quests[ "armory" ];
    
    if ( quest.water_treatment.is_completed && quest.power_outage.is_completed && quest.missile_factory.is_completed )
    {
        quest.armory.button setscriptablepartstate( "base", "usable" );
    }
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x5601df2, Offset: 0x2543
// Size: 0x91
function private on_item_pickup( params )
{
    quest = level.br_map_quest.quests[ "armory" ];
    
    if ( quest.gunpickedup )
    {
        return;
    }
    
    if ( params.itembundlename == %"itemspawnentry:wz_item_weapon_ar_qbravo97_jup_escape_ee" || params.itembundlename == %"hash_36c3a62b92150fa0" )
    {
        quest.gunpickedup = 1;
        function_a4443d7df1b90931( params.player );
    }
}

/#

    // Namespace quest_armory
    // Params 0
    // Checksum 0xba01b384, Offset: 0x25dc
    // Size: 0x5, Type: dev
    function function_47d8e1d46503828f()
    {
        
    }

#/

// Namespace quest_armory
// Params 4, eflags: 0x4
// Checksum 0x5ffdb357, Offset: 0x25e9
// Size: 0x33
function private get_scriptable( name, key, pos, radius )
{
    return getentitylessscriptablearray( name, key, pos, radius )[ 0 ];
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x1a59de04, Offset: 0x2625
// Size: 0x127
function private function_fa42249685682a2f( spawnlistname )
{
    spawnlist = common_cache::function_73fc13f2febd3a2( spawnlistname );
    var_9d44c5c18559ef21 = common_item::items_selectfromlist( spawnlist.spawnlistname, spawnlist.spawncount, undefined, 1 );
    
    for ( i = 0; i < self.rewardspawns.size ; i++ )
    {
        itembundle = getscriptbundle( var_9d44c5c18559ef21[ i ] );
        
        if ( itembundle )
        {
            spawnoptions = common_item::function_bc5ff2958b71a708( self.rewardspawns[ i ].origin, self.rewardspawns[ i ].angles );
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

// Namespace quest_armory
// Params 4, eflags: 0x4
// Checksum 0xe4c5b809, Offset: 0x2754
// Size: 0x87
function private spawn_pickup( pickupname, origin, angles, unusable )
{
    if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( pickupname ) )
    {
        return;
    }
    
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.critical = 1;
    spawneditem = common_item::items_spawnitemfromscriptable( pickupname, undefined, spawnoptions );
    
    if ( unusable && isdefined( spawneditem ) )
    {
        spawneditem setscriptablepartstate( pickupname, "visible_outline_unusable" );
    }
    
    return spawneditem;
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x71f1095f, Offset: 0x27e4
// Size: 0xd6
function private spawn_rewards( items )
{
    if ( !isarray( items ) )
    {
        return;
    }
    
    if ( items.size > 0 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        spawnedcount = 0;
        
        foreach ( item in items )
        {
            spawneditem = common_item::function_61c2c0251e742ffd( item, undefined, spawnoptions );
            
            if ( isdefined( spawneditem ) )
            {
                spawnedcount++;
            }
        }
        
        return spawnedcount;
    }
}

// Namespace quest_armory
// Params 1, eflags: 0x4
// Checksum 0x9df7b11, Offset: 0x28c2
// Size: 0xca
function private function_531bb5c3d43c466c( lootitems )
{
    foreach ( item in lootitems )
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
}

// Namespace quest_armory
// Params 0, eflags: 0x4
// Checksum 0xa83f60a5, Offset: 0x2994
// Size: 0x51
function private function_a5dcccdfb85bf6fd()
{
    level endon( "map_quest_" + self.name + "_completed" );
    level waittill( #"game_ended" );
    params = { #completed_by:undefined, #is_successful:0 };
    br_map_quest::on_completed( params );
}

// Namespace quest_armory
// Params 2, eflags: 0x4
// Checksum 0xaa41c82d, Offset: 0x29ed
// Size: 0x6d
function private analytics_quest_completed( successful, player )
{
    level notify( "map_quest_" + self.name + "_completed" );
    params = { #completed_by:teams::getteamdata( player.team, "players" ), #is_successful:successful };
    br_map_quest::on_completed( params );
}

