// scripts\mp\br\gametypes\br_sidequest_chance_machine.gsc  (hash_2849e82e937189a2.gscc) (size: 4641 Bytes / 0x1221 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf40556a2 (4093990562)
// size ...... 4641 (0x1221)
// includes .. 9   (offset: 0x10d1)
// strings ... 17  (offset: 0x1119)
// dev strs .. 2   (offset: 0x1209)
// exports ... 17  (offset: 0x9a1)
// cseg ...... 0x1a2 + 0x7ff (0x9a1)
// imports ... 40  (offset: 0xc49)
// animtree1 . 0   (offset: 0x1221)
// animtree2 . 0   (offset: 0x1221)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\points;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace chance_machine;

// Namespace chance_machine
// Params 0, eflags: 0x5
// Checksum 0xccd7953f, Offset: 0x1c0
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace chance_machine
// Params 0
// Checksum 0xac29528a, Offset: 0x1d1
// Size: 0x6c
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"chance_machine" };
    br_map_quest::register( quest );
}

// Namespace chance_machine
// Params 0
// Checksum 0x7568e50a, Offset: 0x245
// Size: 0x1e
function on_init()
{
    set_dvars();
    set_callbacks();
    function_f89e2d08d47a0736();
    get_machine_scriptable();
}

// Namespace chance_machine
// Params 0
// Checksum 0x9bf75adf, Offset: 0x26b
// Size: 0x2
function on_precache()
{
    
}

// Namespace chance_machine
// Params 0
// Checksum 0x4a81235e, Offset: 0x275
// Size: 0x2
function on_start()
{
    
}

// Namespace chance_machine
// Params 0
// Checksum 0xa6caff6f, Offset: 0x27f
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace chance_machine
// Params 0
// Checksum 0xe28b222e, Offset: 0x289
// Size: 0x4c
function on_infil()
{
    if ( getdvarint( @"hash_e33576b2ba5e87fb", 0 ) )
    {
        /#
            thread spawn_all_tokens();
        #/
        
        return;
    }
    
    spawn_struct = utility::array_random( self.token_structs );
    self.token = spawn_token( spawn_struct );
}

// Namespace chance_machine
// Params 0
// Checksum 0xb447de7b, Offset: 0x2dd
// Size: 0x2
function set_dvars()
{
    
}

// Namespace chance_machine
// Params 0
// Checksum 0x9f7e1339, Offset: 0x2e7
// Size: 0x14
function set_callbacks()
{
    level scriptable::scriptable_addusedcallbackbypart( "sierra_chance_machine", &chance_machine_used );
}

// Namespace chance_machine
// Params 0
// Checksum 0xbc7ea93a, Offset: 0x303
// Size: 0x1d9
function function_f89e2d08d47a0736()
{
    self.token_structs = utility::getstructarray( "chance_token_loc", "targetname" );
    assert( isdefined( self.token_structs ), "<dev string:x24>" + "<dev string:x47>" );
    
    if ( self.token_structs.size == 0 )
    {
        self.token_structs = [ { #angles:( 357.46, 66.77, -3.68 ), #origin:( 7847, -36147, -650.18 ) }, { #angles:( 357.46, 66.77, -3.68 ), #origin:( 22849, -35211, -607 ) }, { #angles:( 344.29, 67.64, -3.82 ), #origin:( 24807, -34975, -632 ) }, { #angles:( 354.27, 68.3, 3.65 ), #origin:( -14172, -45777, -590 ) }, { #angles:( 354.27, 68.3, -3.95 ), #origin:( -8590, -43613, -628.25 ) }, { #angles:( 354.27, 68.3, 7.55 ), #origin:( 2945, -39709, -566 ) }, { #angles:( 358.02, 70.05, 7.02 ), #origin:( 8650, -35774, -640 ) }, { #angles:( 354.85, 139.24, -5.63 ), #origin:( 39134, -43891, -608.95 ) } ];
    }
}

// Namespace chance_machine
// Params 1
// Checksum 0xf19a20df, Offset: 0x4e4
// Size: 0x6c
function spawn_token( spawn_struct )
{
    spawn_options = common_item::function_bc5ff2958b71a708( spawn_struct.origin, spawn_struct.angles ?? ( 0, 0, 0 ) );
    spawn_options.critical = 1;
    pickup = common_item::function_325e28c0fb65c36a( "wz_consumable_quest_chance_token", undefined, spawn_options );
    return pickup;
}

// Namespace chance_machine
// Params 0
// Checksum 0x2029b1a, Offset: 0x559
// Size: 0x5e
function get_machine_scriptable()
{
    chance_machine = getentitylessscriptablearray( "scriptable_sierra_chance_machine", "classname" );
    
    if ( isdefined( chance_machine[ 0 ] ) )
    {
        self.chance_machine = chance_machine[ 0 ];
        return;
    }
    
    self.chance_machine = spawnscriptable( "sierra_chance_machine", ( 10038, -19944, -283 ), ( 0, 14.599, 0 ) );
}

// Namespace chance_machine
// Params 6
// Checksum 0x7bf08428, Offset: 0x5bf
// Size: 0xbc
function chance_machine_used( instance, part, state, player, bautouse, usestring )
{
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_chance_token" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_chance_token" );
        instance thread chance_machine_play( player );
        player dlog_recordplayerevent( "dlog_event_br_sierra_sidequest_30", [ "success", 1 ] );
        return;
    }
    
    player [[ level.showerrormessagefunc ]]( %"hash_65580b115f6ad826" );
    instance thread chance_machine_denied( player );
    player dlog_recordplayerevent( "dlog_event_br_sierra_sidequest_30", [ "success", 0 ] );
}

// Namespace chance_machine
// Params 1
// Checksum 0x1577f21e, Offset: 0x683
// Size: 0x1ac
function chance_machine_play( player )
{
    self setscriptablepartstate( self.type, "playing" );
    wait 1.5;
    self setscriptablepartstate( self.type, "burst_ne" );
    wait 0.08;
    self setscriptablepartstate( self.type, "burst_em" );
    wait 0.11;
    self setscriptablepartstate( self.type, "burst_ne" );
    wait 0.04;
    self setscriptablepartstate( self.type, "burst_em" );
    wait 0.11;
    self setscriptablepartstate( self.type, "burst_ne" );
    wait 0.04;
    self setscriptablepartstate( self.type, "burst_em" );
    wait 0.08;
    self setscriptablepartstate( self.type, "malfunction" );
    points::function_40522c040a4e7b1( player.team, #"sealion_chance_machine_play" );
    challenges::function_37e945722d6497f3( player, "sierra_sidequest_30", 1, 1 );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_quest_chance_machine" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        cachespawnlist = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnorigin = self.origin + 20 * anglestoforward( self.angles );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawnorigin, self.angles );
        common_item::function_38cde6a6acb68ea6( cachespawnlist, spawncount, spawnoptions );
    }
}

// Namespace chance_machine
// Params 1
// Checksum 0x41bb383, Offset: 0x837
// Size: 0x3d
function chance_machine_denied( player )
{
    self setscriptablepartstate( self.type, "denied" );
    utility::delaycall( 0.5, &setscriptablepartstate, self.type, "usable" );
}

/#

    // Namespace chance_machine
    // Params 0, eflags: 0x4
    // Checksum 0x191bcf4b, Offset: 0x87c
    // Size: 0x125, Type: dev
    function private spawn_all_tokens()
    {
        level endon( #"game_ended" );
        
        foreach ( token_struct in self.token_structs )
        {
            spawn_token( token_struct );
        }
        
        while ( true )
        {
            wait 0.5;
            
            foreach ( token_struct in self.token_structs )
            {
                level thread debug::drawsphere( token_struct.origin, 200, 0.5, ( 100, 0, 0 ) );
            }
        }
    }

#/
