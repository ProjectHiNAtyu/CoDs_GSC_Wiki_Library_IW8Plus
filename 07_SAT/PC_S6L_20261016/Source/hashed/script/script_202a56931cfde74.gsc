// script_202a56931cfde74  (hash_0202a56931cfde74.gscc) (size: 6357 Bytes / 0x18d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x848326f5 (2223187701)
// size ...... 6357 (0x18d5)
// includes .. 9   (offset: 0x16bd)
// strings ... 29  (offset: 0x1705)
// dev strs .. 1   (offset: 0x18c9)
// exports ... 23  (offset: 0xda9)
// cseg ...... 0x289 + 0xb20 (0xda9)
// imports ... 46  (offset: 0x1141)
// animtree1 . 0   (offset: 0x18d5)
// animtree2 . 0   (offset: 0x18d5)
#using scripts\common\scriptable;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\tripwire;

#namespace quest_storage;

// Namespace quest_storage
// Params 0, eflags: 0x1
// Checksum 0x46794961, Offset: 0x2a7
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace quest_storage
// Params 0
// Checksum 0xb2525e74, Offset: 0x2b8
// Size: 0x87
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"hidden_storage" };
    quest thread freeze_doors();
    
    if ( getdvarint( @"hash_cc547e2e898c6a6a", 0 ) )
    {
        return;
    }
    
    br_map_quest::register( quest );
}

// Namespace quest_storage
// Params 0
// Checksum 0xcc6e816b, Offset: 0x347
// Size: 0x10
function on_init()
{
    set_dvars();
    set_callbacks();
}

// Namespace quest_storage
// Params 0
// Checksum 0xfdedfdad, Offset: 0x35f
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_storage
// Params 0
// Checksum 0x2c9b842c, Offset: 0x369
// Size: 0x2
function on_start()
{
    
}

// Namespace quest_storage
// Params 0
// Checksum 0xc0d0581d, Offset: 0x373
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_storage
// Params 0
// Checksum 0x2e3d86be, Offset: 0x37d
// Size: 0x1e
function on_infil()
{
    function_1bcb7041f8077c75();
    quest_door_setup();
    thread function_a66068326a8f002();
    function_9abdd6fd142a152a();
}

// Namespace quest_storage
// Params 0
// Checksum 0x36399a3d, Offset: 0x3a3
// Size: 0xf
function set_dvars()
{
    br_map_quest::add_setting( "use_map_assets", 0 );
}

// Namespace quest_storage
// Params 0
// Checksum 0x564c8654, Offset: 0x3ba
// Size: 0x46
function set_callbacks()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_hs_backpack", &function_f3a0fa8ebc536ccd );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_hs_door", &function_f8f2b54f0833ec2f );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_hs_computer", &quest_computer_used );
    scriptable::scriptable_addusedcallbackbypart( "quest_wz_hs_crate", &quest_crate_used );
}

// Namespace quest_storage
// Params 0
// Checksum 0xfb39635a, Offset: 0x408
// Size: 0x55
function freeze_doors()
{
    level waittill( #"scriptables_ready" );
    self.hs_doors = getentitylessscriptablearray( "quest_hs_door", "script_noteworthy" );
    scriptable_door_utility::function_a6d402d10d7a3a2e( self.hs_doors );
    self.patch = spawnscriptable( "clip256x256x256", ( -26618, 10428, -426 ) );
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0x982b4bbc, Offset: 0x465
// Size: 0x25f
function private quest_tripwire_spawn()
{
    tripwires = [];
    hs_tripwires = getentitylessscriptablearray( "hs_tripwire", #targetname );
    
    foreach ( tripwire in hs_tripwires )
    {
        trip = spawnscriptable( "wz_tripwire", tripwire.origin, tripwire.angles );
        tripwires[ tripwires.size ] = trip;
        trip.targets = [];
        tripwire.targets = getentitylessscriptablearray( tripwire.target, #targetname );
        
        foreach ( item in tripwire.targets )
        {
            if ( item getscriptablehaspart( "trap_device" ) )
            {
                trip.targets[ trip.targets.size ] = spawnscriptable( "wz_tripwire_frag", item.origin, item.angles );
                continue;
            }
            
            if ( item.classname == "scriptable_wz_tripwire" )
            {
                trip.targets[ trip.targets.size ] = spawnscriptable( "wz_tripwire", item.origin, item.angles );
                continue;
            }
            
            if ( item getscriptablehaspart( "wall_pin" ) )
            {
                trip.targets[ trip.targets.size ] = spawnscriptable( "wz_tripwire_wall_pin", item.origin, item.angles );
                continue;
            }
            
            assertmsg( "<dev string:x24>" + tripwire.origin );
        }
    }
    
    return tripwires;
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0xa80462f9, Offset: 0x6cd
// Size: 0xdd
function private quest_tripwire_enable()
{
    if ( br_map_quest::get_setting( "use_map_assets" ) )
    {
        tripwires = getentitylessscriptablearray( "hs_tripwire", #targetname );
    }
    else
    {
        tripwires = quest_tripwire_spawn();
    }
    
    waitframe();
    
    foreach ( tripwire in tripwires )
    {
        tripwire thread tripwire::tripwire_enable( tripwire, undefined, tripwire.targets );
        tripwire.var_b4c81558b4af6d74 = level.tripwireweaponname;
        tripwire.var_ffe73dd7ffd0aba = &function_d184a012a748bf1;
    }
}

// Namespace quest_storage
// Params 1, eflags: 0x4
// Checksum 0x918106f1, Offset: 0x7b2
// Size: 0x60
function private function_d184a012a748bf1( triggeringent )
{
    quest = level.br_map_quest.quests[ "hidden_storage" ];
    
    if ( !quest.crate.used )
    {
        quest_crate_used( quest.crate, undefined, undefined, triggeringent );
    }
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0x8945de01, Offset: 0x81a
// Size: 0x4e
function private function_1bcb7041f8077c75()
{
    backpack = getentitylessscriptablearray( "scriptable_quest_wz_hs_backpack", "classname" );
    self.backpack = backpack[ 0 ] ?? spawnscriptable( "quest_wz_hs_backpack", ( 51522, 39044, 1927 ), ( 0, 90, 0 ) );
}

// Namespace quest_storage
// Params 6, eflags: 0x4
// Checksum 0x3a6c9f2f, Offset: 0x870
// Size: 0xa8
function private function_f3a0fa8ebc536ccd( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "quest_wz_hs_backpack", "inactive" );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( instance.origin, instance.angles ?? ( 0, 0, 0 ) );
    spawn_options.critical = 1;
    pickup = common_item::function_325e28c0fb65c36a( "wz_consumable_quest_storage_key", undefined, spawn_options );
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0xbb986cd7, Offset: 0x920
// Size: 0x90
function private quest_door_setup()
{
    door = self.hs_doors[ 0 ];
    
    if ( isdefined( door ) )
    {
        door scriptabledoorfreeze( 1 );
        prompt = spawnscriptable( "quest_wz_hs_door", door.origin );
        prompt.door = door;
    }
    
    [ blocker ] = getentitylessscriptablearray( "quest_hs_blocker", "script_noteworthy" );
    
    if ( isdefined( blocker ) )
    {
        blocker setscriptablepartstate( "state", "hidden" );
    }
}

// Namespace quest_storage
// Params 6, eflags: 0x4
// Checksum 0x723c8888, Offset: 0x9b8
// Size: 0xdf
function private function_f8f2b54f0833ec2f( instance, part, state, player, bautouse, usestring )
{
    quest = level.br_map_quest.quests[ "hidden_storage" ];
    
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_storage_key" ) )
    {
        quest quest_tripwire_enable();
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_storage_key" );
        instance setscriptablepartstate( "quest_wz_hs_door", "inactive" );
        instance.door scriptabledoorfreeze( 0 );
        
        if ( quest.patch )
        {
            quest.patch freescriptable();
        }
        
        return;
    }
    
    player [[ level.showerrormessagefunc ]]( %"hash_5fd0ee86328463a8" );
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0xb1199aa7, Offset: 0xa9f
// Size: 0x56
function private function_9abdd6fd142a152a()
{
    computer = getentitylessscriptablearray( "quest_wz_hs_computer", "classname" );
    self.computer = computer[ 0 ] ?? spawnscriptable( "quest_wz_hs_computer", ( -26462, 10495, -271 ) );
    self.computer.quest = self;
}

// Namespace quest_storage
// Params 6, eflags: 0x4
// Checksum 0x691f0b86, Offset: 0xafd
// Size: 0x62
function private quest_computer_used( instance, part, state, player, bautouse, usestring )
{
    instance.quest.computerused = 1;
    instance setscriptablepartstate( "quest_wz_hs_computer", "inactive" );
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0xfc0b0fbf, Offset: 0xb67
// Size: 0x7c
function private function_a66068326a8f002()
{
    crate = getentitylessscriptablearray( "quest_wz_hs_crate", "classname" );
    self.crate = crate[ 0 ] ?? spawnscriptable( "quest_wz_hs_crate", ( -26458, 10413, -312 ), ( 0, 90, 0 ) );
    self.crate.quest = self;
    waitframe();
    self.crate setscriptablepartstate( "quest_wz_hs_crate", "closed_usable" );
}

// Namespace quest_storage
// Params 6, eflags: 0x4
// Checksum 0xee743faf, Offset: 0xbeb
// Size: 0xfe
function private quest_crate_used( instance, part, state, player, bautouse, usestring )
{
    instance.used = 1;
    
    if ( !instance.quest.computerused )
    {
        if ( isdefined( instance.quest.computer ) )
        {
            instance.quest.computer setscriptablepartstate( "quest_wz_hs_computer", "inactive" );
        }
        
        instance setscriptablepartstate( "quest_wz_hs_crate", "burning" );
        wait 1.5;
    }
    else
    {
        points::function_40522c040a4e7b1( player.team, #"hash_93c1501b8169eaa2" );
        challenges::function_37e945722d6497f3( player, "sierra_sidequest_23", 1, 1 );
    }
    
    instance setscriptablepartstate( "quest_wz_hs_crate", "fully_opening_unusable" );
    instance thread function_2a14192c7b725dde();
}

// Namespace quest_storage
// Params 0, eflags: 0x4
// Checksum 0xde4cd86e, Offset: 0xcf1
// Size: 0xb8
function private function_2a14192c7b725dde()
{
    lootspawnlist = self.quest.computerused ? "br_hs_high_reward" : "br_hs_low_reward";
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( lootspawnlist );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        cachespawnlist = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        common_item::function_38cde6a6acb68ea6( cachespawnlist, spawncount, spawnoptions );
    }
}

