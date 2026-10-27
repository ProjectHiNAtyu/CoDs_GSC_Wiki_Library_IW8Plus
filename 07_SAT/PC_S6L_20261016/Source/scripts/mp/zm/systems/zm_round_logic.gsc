// scripts\mp\zm\systems\zm_round_logic.gsc  (hash_77dca3b46e01eb1e.gscc) (size: 14038 Bytes / 0x36d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa72d9c8e (2804784270)
// size ...... 14038 (0x36d6)
// includes .. 12  (offset: 0x3192)
// strings ... 28  (offset: 0x31f2)
// dev strs .. 73  (offset: 0x336a)
// exports ... 38  (offset: 0x1e6a)
// cseg ...... 0x292 + 0x1bd8 (0x1e6a)
// imports ... 108 (offset: 0x245a)
// animtree1 . 0   (offset: 0x36d6)
// animtree2 . 0   (offset: 0x36d6)
#using script_16ea1b94f0f381b3;
#using script_7381472113d2aa0b;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game;
#using scripts\mp\laststand;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_round_logic;

// Namespace zm_round_logic
// Params 0
// Checksum 0x5c124084, Offset: 0x2b0
// Size: 0x12b
function init_zm_round_logic()
{
    utility::flag_init( "begin_round_logic" );
    level.zm_get_round_number = &get_rb_round_number;
    
    if ( !isdefined( level.var_ec48a8802bc5bec1 ) )
    {
        level.var_ec48a8802bc5bec1 = &function_ec48a8802bc5bec1;
    }
    
    var_2306d17f04f88d53 = spawnstruct();
    var_2306d17f04f88d53.state = 0;
    var_2306d17f04f88d53.roundnumber = 1;
    var_2306d17f04f88d53.var_ca9b24b349cca50b = 999;
    var_2306d17f04f88d53.startdelay = 6;
    var_2306d17f04f88d53.spawndelay = 1;
    var_2306d17f04f88d53.var_7ccf298a00a225de = &zm_round_logic_get_delay_between_rounds;
    var_2306d17f04f88d53.var_ec3ff7ca64e3c5a9 = 0;
    var_2306d17f04f88d53.var_38b7e69b7a098746 = 0;
    var_2306d17f04f88d53.var_cb3cdea36c801422 = 0;
    var_2306d17f04f88d53.var_5b96cad4afd0a955 = 0;
    level.var_6781718da4f78d1c = var_2306d17f04f88d53;
    level.round_number = level.var_6781718da4f78d1c.roundnumber;
    level callback::add( #"player_connect", &round_logic_on_connect );
    level thread zm_round_logic_initpostmain();
    function_da5281a6666c821a();
    
    /#
        level thread setup_round_logic_devgui();
    #/
}

// Namespace zm_round_logic
// Params 0
// Checksum 0xdda9f165, Offset: 0x3e3
// Size: 0x1f
function zm_round_logic_initpostmain()
{
    waitframe();
    level notify( #"hash_23487b0e9151ffea" );
    level thread zm_round_spawning::init_zm_round_spawning();
    level thread function_7ed7de17f9cdcc19();
}

// Namespace zm_round_logic
// Params 0
// Checksum 0xb8fb5bd9, Offset: 0x40a
// Size: 0x4
function zm_round_logic_get_delay_between_rounds()
{
    return 15;
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x28be5298, Offset: 0x417
// Size: 0x67
function function_7ed7de17f9cdcc19()
{
    level endon( #"game_ended" );
    level waittill( #"begin_round_logic" );
    level.var_6781718da4f78d1c.var_5b96cad4afd0a955 = 1;
    wait level.var_6781718da4f78d1c.startdelay;
    zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
    level thread zm_round_loop();
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x78dfe4db, Offset: 0x486
// Size: 0xa9
function function_f27f1398e9342f2c()
{
    level endon( #"game_ended" );
    
    if ( level.var_322288976df3a25f )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.inlaststand )
        {
            player laststand::exit( "last_stand_round_turn", player );
        }
    }
}

// Namespace zm_round_logic
// Params 1
// Checksum 0xd0fbd408, Offset: 0x537
// Size: 0x146
function function_667d6a87ca0f3bd5( round_number )
{
    base_damage_bundle = level.ai_damage_bundles[ "damagescaling_zombie_base_zombie" ];
    var_3e63619e0a687f94 = 1;
    
    foreach ( damage_scaling in base_damage_bundle.meleedamagescaling )
    {
        if ( round_number == damage_scaling.startround )
        {
            var_3e63619e0a687f94 = damage_scaling.damagemultiplier;
            break;
        }
    }
    
    if ( var_3e63619e0a687f94 > 1 )
    {
        foreach ( player in level.players )
        {
            player playlocalsound( "evt_zm_round_difficulty_increase" );
        }
    }
}

// Namespace zm_round_logic
// Params 0, eflags: 0x4
// Checksum 0xb466c1de, Offset: 0x685
// Size: 0x543
function private zm_round_loop()
{
    level endon( #"game_ended" );
    level endon( #"end_round_logic" );
    
    while ( true )
    {
        switch ( level.var_6781718da4f78d1c.state )
        {
            case 0:
                params = spawnstruct();
                params.roundnumber = self.var_6781718da4f78d1c.roundnumber;
                level callback::callback( "on_round_start", params );
                params.event = #"zm_on_round_start";
                level callback::callback( #"hash_6c71d319dc089c27", params );
                level notify( #"on_round_start" );
                function_667d6a87ca0f3bd5( self.var_6781718da4f78d1c.roundnumber );
                wait level.var_6781718da4f78d1c.spawndelay;
                level.round_spawn_time = gettime();
                
                if ( !level.var_6781718da4f78d1c.var_ec3ff7ca64e3c5a9 )
                {
                    level thread watch_round_timeout();
                }
                
                level.var_6781718da4f78d1c.state = 1;
                break;
            case 1:
                if ( !zm_round_spawning::function_2dfe1b653adf9c0d() )
                {
                    if ( level.var_a009ab14ee0d3223.state == 2 )
                    {
                        level.var_a009ab14ee0d3223 notify( #"reset" );
                    }
                    
                    level.var_a009ab14ee0d3223 notify( #"spawn" );
                }
                else
                {
                    level.var_6781718da4f78d1c waittill( #"round_cleared" );
                    
                    if ( !isdefined( level.var_83fdd8a41f82d910 ) || [[ level.var_83fdd8a41f82d910 ]]( self.var_6781718da4f78d1c.roundnumber ) )
                    {
                        level.var_6781718da4f78d1c.state = 2;
                    }
                    else
                    {
                        zm_round_spawning::function_7c08fdc922a2cf9( 0 );
                    }
                }
                
                break;
            case 2:
                var_e7c2c09903c13bf7 = level.var_6781718da4f78d1c.roundnumber < 999 && level.var_6781718da4f78d1c.roundnumber < level.var_6781718da4f78d1c.var_ca9b24b349cca50b && !istrue( level.var_dc81f03d76612023 );
                params = { #var_e7c2c09903c13bf7:var_e7c2c09903c13bf7, #roundnumber:self.var_6781718da4f78d1c.roundnumber };
                level callback::callback( "on_round_end_immediate", params );
                
                if ( isdefined( level.var_ec48a8802bc5bec1 ) )
                {
                    [[ level.var_ec48a8802bc5bec1 ]]( params );
                }
                
                level callback::callback( "on_round_end", params );
                level notify( #"on_round_end" );
                zm_round_spawning::function_7c08fdc922a2cf9( 0 );
                level thread function_f27f1398e9342f2c();
                
                if ( var_e7c2c09903c13bf7 )
                {
                    level.var_6781718da4f78d1c.roundnumber++;
                    logstring( "Zombie Round Logic: Round " + level.var_6781718da4f78d1c.roundnumber + " beginning..." );
                    analytics::addevent( "round_begin", undefined, level.var_6781718da4f78d1c.roundnumber, "Round " + level.var_6781718da4f78d1c.roundnumber + " beginning" );
                    function_e767fdf4ccf1e581();
                    zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
                    
                    if ( level.onlinegame && !game_utility_mp::privatematch() && !level.nojip )
                    {
                        function_1b6eaf7a65cc5971( self.var_6781718da4f78d1c.roundnumber );
                    }
                }
                
                ndelay = 6;
                
                if ( isdefined( level.var_6781718da4f78d1c.var_7ccf298a00a225de ) )
                {
                    ndelay = [[ level.var_6781718da4f78d1c.var_7ccf298a00a225de ]]();
                }
                
                if ( isdefined( level.var_545d992d40a9d7de ) )
                {
                    ndelay = [[ level.var_545d992d40a9d7de ]]();
                }
                
                if ( isdefined( level.var_cb99f5c0e1347966 ) )
                {
                    n_delay = [[ level.var_cb99f5c0e1347966 ]]();
                    
                    if ( isdefined( n_delay ) )
                    {
                        ndelay = n_delay;
                    }
                }
                
                wait ndelay;
                level notify( #"between_round_over" );
                level.var_a009ab14ee0d3223 notify( #"reset" );
                
                /#
                    hasset = function_e767fdf4ccf1e581();
                    
                    if ( hasset )
                    {
                        zm_utility::function_1bd2eda42461fad1( level.var_6781718da4f78d1c.roundnumber );
                    }
                    
                    if ( isdefined( level.zone_spawn_locations ) )
                    {
                        foreach ( spawn_loc in level.zone_spawn_locations )
                        {
                            spawn_loc.var_2306e1230e900f37 = 0;
                        }
                    }
                #/
                
                level.round_number = level.var_6781718da4f78d1c.roundnumber;
                level.var_6781718da4f78d1c.state = 0;
                break;
        }
        
        waitframe();
    }
}

// Namespace zm_round_logic
// Params 1
// Checksum 0x5dc1c18f, Offset: 0xbd0
// Size: 0x1b
function function_ec48a8802bc5bec1( params )
{
    level endon( #"game_ended" );
    wait 3;
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x1890229b, Offset: 0xbf3
// Size: 0x15
function get_rb_round_number()
{
    return level.var_6781718da4f78d1c.roundnumber;
}

// Namespace zm_round_logic
// Params 1
// Checksum 0xe85c1340, Offset: 0xc11
// Size: 0x66
function set_rb_round_number( round_number )
{
    assert( !level.var_6781718da4f78d1c.var_5b96cad4afd0a955, "<dev string:x24>" );
    assert( round_number >= 1 );
    
    if ( round_number <= 0 )
    {
        round_number = 1;
    }
    
    level.var_6781718da4f78d1c.roundnumber = round_number;
    level.round_number = round_number;
}

// Namespace zm_round_logic
// Params 0
// Checksum 0xf65204ee, Offset: 0xc7f
// Size: 0x15
function get_rb_round_cap()
{
    return level.var_6781718da4f78d1c.var_ca9b24b349cca50b;
}

// Namespace zm_round_logic
// Params 1
// Checksum 0xe43d0d02, Offset: 0xc9d
// Size: 0x2f
function set_rb_round_cap( new_round_cap )
{
    assert( new_round_cap >= 1 );
    level.var_6781718da4f78d1c.var_ca9b24b349cca50b = new_round_cap;
}

// Namespace zm_round_logic
// Params 1
// Checksum 0x353a06c4, Offset: 0xcd4
// Size: 0x13
function round_logic_on_connect( sparams )
{
    thread function_13988c21d0e91d36();
}

// Namespace zm_round_logic
// Params 1
// Checksum 0xcb278e3c, Offset: 0xcef
// Size: 0x4d
function function_d74240093bb820e3( startorigin )
{
    self endon( #"disconnect" );
    
    while ( isalive( self ) )
    {
        if ( distance2d( startorigin, self.origin ) > 16 )
        {
            break;
        }
        
        wait 1;
    }
    
    self notify( #"player_moved_after_hot_join" );
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x23c534ff, Offset: 0xd44
// Size: 0x1a4
function function_13988c21d0e91d36()
{
    if ( !level.var_6781718da4f78d1c.var_5b96cad4afd0a955 && !level.var_40ae21600d471de7 )
    {
        level.var_40ae21600d471de7 = 1;
        self waittill( #"spawned_player" );
        val::set( "round_logic", "freezecontrols", 1 );
        level utility::flag_wait_or_timeout( "loading_screen_over", 60 );
        
        if ( isdefined( self ) )
        {
            val::reset( "round_logic", "freezecontrols" );
        }
        
        if ( isdefined( self ) && self issplitscreenplayer() )
        {
            var_1f0d6d55fe7c62ec = self getothersplitscreenplayer();
            
            if ( isdefined( var_1f0d6d55fe7c62ec ) )
            {
                var_1f0d6d55fe7c62ec val::reset( "round_logic", "ignoreme" );
            }
        }
        
        level zm_save::function_1f44a48caae2acbf();
        utility::flag_waitopen( "delay_begin_round_logic" );
        utility::flag_set( "begin_round_logic" );
        return;
    }
    
    self waittill( #"spawned_player" );
    thread function_d74240093bb820e3( self.origin );
    val::set( "round_logic", "ignoreme", 1 );
    var_5d68017a61bd7d32 = 180;
    
    if ( utility::issharedfuncdefined( #"zm_player_joined", #"get_custom_grace_period" ) )
    {
        var_5d68017a61bd7d32 = utility::callsharedfunc( #"zm_player_joined", #"get_custom_grace_period" );
    }
    
    waitarray = [ "melee_swipe_start", "weapon_fired", "offhand_fired", "special_weapon_fired", "jump", "player_moved_after_hot_join" ];
    utility::waittill_any_in_array_or_timeout( waitarray, var_5d68017a61bd7d32 );
    
    if ( isdefined( self ) )
    {
        val::reset( "round_logic", "ignoreme" );
    }
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x5fe934de, Offset: 0xef0
// Size: 0xba
function function_895fdc21ab019efe()
{
    /#
        if ( getdvarint( @"zm_round_spawning_enabled", 1 ) < 1 )
        {
            level.var_6781718da4f78d1c.state = 2;
            return;
        }
    #/
    
    switch ( level.var_6781718da4f78d1c.state )
    {
        case 0:
            level.var_a009ab14ee0d3223 waittill( #"spawn" );
            level.var_a009ab14ee0d3223.state = 2;
            break;
        case 1:
            level.var_a009ab14ee0d3223.state = 2;
            break;
        case 2:
            break;
    }
}

// Namespace zm_round_logic
// Params 0
// Checksum 0x5cb25e50, Offset: 0xfb2
// Size: 0x171
function watch_round_timeout()
{
    level endon( #"game_ended" );
    level.var_6781718da4f78d1c endon( #"round_cleared" );
    
    if ( level.var_6781718da4f78d1c.roundnumber < 6 )
    {
        level utility::flag_wait_any( "power_on", "enable_round_timeout" );
    }
    
    while ( !zm_round_spawning::function_2dfe1b653adf9c0d() || !zm_round_spawning::has_round_spawning_completed() )
    {
        wait 1;
    }
    
    var_1bb0e4eda57c7382 = level.var_5f263e668f5fd35c ?? 600;
    var_1e98fa879b8b019e = level.var_75637eaddfabfdc1 ?? 20;
    var_d24bcc2b61888436 = undefined;
    
    while ( var_1bb0e4eda57c7382 > 0 && var_1e98fa879b8b019e > 0 )
    {
        round_zombies = zm_round_spawning::get_round_enemies();
        previous_zombie_count = var_d24bcc2b61888436;
        var_d24bcc2b61888436 = round_zombies.size;
        
        if ( !level utility::flag( "pause_round_timeout" ) )
        {
            var_1bb0e4eda57c7382 -= 1;
            
            if ( level.var_6781718da4f78d1c.var_38b7e69b7a098746 )
            {
                if ( var_d24bcc2b61888436 == previous_zombie_count )
                {
                    var_1e98fa879b8b019e--;
                }
                else
                {
                    var_1e98fa879b8b019e = level.var_75637eaddfabfdc1 ?? 20;
                }
            }
        }
        
        wait 1;
    }
    
    level utility::flag_waitopen( "pause_round_timeout" );
    
    if ( level.var_6781718da4f78d1c.var_cb3cdea36c801422 )
    {
        function_895fdc21ab019efe();
    }
    else
    {
        level zm_cleanup_manager::function_ff2f735d3abb2ce0( 1 );
    }
    
    level.var_6781718da4f78d1c notify( #"round_timed_out" );
}

// Namespace zm_round_logic
// Params 0, eflags: 0x4
// Checksum 0x3c169bf2, Offset: 0x112b
// Size: 0x2c
function private function_da5281a6666c821a()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_4662b82ea505316c", &function_e8221de6f1c3164d );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"next_round", &function_8f4ab19f60860e85 );
}

// Namespace zm_round_logic
// Params 1
// Checksum 0x44f21147, Offset: 0x115f
// Size: 0x2e
function function_e8221de6f1c3164d( params )
{
    if ( isdefined( params ) )
    {
        round_number = int( params[ 0 ] );
        function_68bdb49c82c0f892( round_number );
    }
}

// Namespace zm_round_logic
// Params 1
// Checksum 0x669a75dc, Offset: 0x1195
// Size: 0x2a
function function_8f4ab19f60860e85( params )
{
    round_number = get_rb_round_number() + 1;
    function_68bdb49c82c0f892( round_number );
}

// Namespace zm_round_logic
// Params 1
// Checksum 0x91abaeaf, Offset: 0x11c7
// Size: 0x54
function function_68bdb49c82c0f892( round_number )
{
    level.var_dc917abcf5b8f749 = round_number;
    current_round_number = get_rb_round_number();
    zm_utility::util_kill_all_zombies();
    iprintln( "Round " + round_number + " is loading..." );
    zm_round_spawning::function_8c0a8afe0779b82a( current_round_number, round_number );
    function_895fdc21ab019efe();
}

// Namespace zm_round_logic
// Params 0
// Checksum 0xb82ecdaf, Offset: 0x1223
// Size: 0x71, Type: bool
function function_e767fdf4ccf1e581()
{
    if ( isdefined( level.var_dc917abcf5b8f749 ) )
    {
        if ( level.var_dc917abcf5b8f749 <= 0 )
        {
            level.var_dc917abcf5b8f749 = 1;
        }
        
        level.var_6781718da4f78d1c.roundnumber = level.var_dc917abcf5b8f749;
        level.var_dc917abcf5b8f749 = undefined;
        iprintln( "Go To Round: " + level.var_6781718da4f78d1c.roundnumber );
        return true;
    }
    
    return false;
}

/#

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xc7e987a8, Offset: 0x129d
    // Size: 0x33, Type: dev
    function function_6dbdaa9e3d5a9c9a()
    {
        level notify( #"hash_18d9d130b40bdb0a" );
        iprintlnbold( "<dev string:x71>" );
        level thread function_774408f5fa28658();
        level thread function_ae4a9892f698b975();
        level thread function_cbd42d82a41ed8e();
    }

    // Namespace zm_round_logic
    // Params 0, eflags: 0x4
    // Checksum 0xfe599f99, Offset: 0x12d8
    // Size: 0x1a, Type: dev
    function private function_8b641c4cf091397f()
    {
        iprintlnbold( "<dev string:x99>" );
        zm_round_spawning::function_e203a9f62c731ba4( 1, 1 );
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0x9b18bb10, Offset: 0x12fa
    // Size: 0x107, Type: dev
    function function_ae4a9892f698b975()
    {
        self notify( #"hash_256ada28a54d24dc" );
        self endon( #"hash_256ada28a54d24dc" );
        level endon( #"game_ended" );
        level endon( #"hash_18d9d130b40bdb0a" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            wait 30;
            
            if ( level.var_a009ab14ee0d3223.state == 1 )
            {
                enemies = getaiarrayinradius( player.origin, 512 );
                
                foreach ( enemy in enemies )
                {
                    enemy kill( player.origin, player );
                }
            }
        }
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xab9efe36, Offset: 0x1409
    // Size: 0x125, Type: dev
    function function_774408f5fa28658()
    {
        self notify( #"hash_d951921c1b9ccdce" );
        self endon( #"hash_d951921c1b9ccdce" );
        level endon( #"game_ended" );
        roundnumber = get_rb_round_number();
        player = level.players[ 0 ];
        maxround = getdvarint( @"hash_c2247f2dd0a9b9ee", 71 );
        setdvar( @"hash_62a47106347dc9c3", 1 );
        
        while ( roundnumber < maxround )
        {
            if ( level.var_a009ab14ee0d3223.state == 1 )
            {
                roundnumber = get_rb_round_number();
                
                if ( level.var_a009ab14ee0d3223.isspecialround )
                {
                    function_8f4ab19f60860e85();
                }
                else
                {
                    var_80ce17227af64d08 = level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size;
                    count_for_round = zm_round_spawning::function_ad358cbb8158789e( roundnumber );
                    
                    if ( var_80ce17227af64d08 >= count_for_round )
                    {
                        wait 1;
                        function_8f4ab19f60860e85();
                    }
                }
            }
            
            wait 1;
        }
        
        level notify( #"hash_18d9d130b40bdb0a" );
        zm_round_spawning::function_e203a9f62c731ba4( 1, 1 );
    }

    // Namespace zm_round_logic
    // Params 0, eflags: 0x4
    // Checksum 0x81f47a46, Offset: 0x1536
    // Size: 0x27, Type: dev
    function private function_cbd42d82a41ed8e()
    {
        level waittill( #"hash_18d9d130b40bdb0a" );
        zm_round_spawning::function_e203a9f62c731ba4( 1, 1 );
        iprintlnbold( "<dev string:xd7>" );
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0x1cd2e2a, Offset: 0x1565
    // Size: 0x13, Type: dev
    function debug_end_round()
    {
        function_895fdc21ab019efe();
        zm_utility::util_kill_all_zombies();
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xcbeb8c58, Offset: 0x1580
    // Size: 0x2c, Type: dev
    function function_62fa604975999150()
    {
        roundnumber = get_rb_round_number() - 1;
        
        if ( roundnumber < 1 )
        {
            return;
        }
        
        function_68bdb49c82c0f892( roundnumber );
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xe36d308f, Offset: 0x15b4
    // Size: 0x23, Type: dev
    function debug_next_round()
    {
        roundnumber = get_rb_round_number() + 1;
        function_68bdb49c82c0f892( roundnumber );
    }

    // Namespace zm_round_logic
    // Params 1
    // Checksum 0xfa9b3f11, Offset: 0x15df
    // Size: 0x44, Type: dev
    function function_b4091ae201e21ff7( params )
    {
        level notify( #"restart_round" );
        
        if ( isdefined( params ) )
        {
            roundnumber = int( params[ 0 ] );
        }
        else
        {
            roundnumber = 1;
        }
        
        function_68bdb49c82c0f892( roundnumber );
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xfa08a289, Offset: 0x162b
    // Size: 0x79, Type: dev
    function function_820f8399c570d991()
    {
        roundnumber = getdvarint( @"hash_8fe0b79aa00c82f1", 1 );
        var_30ce3485e635edfc = level.var_dc917abcf5b8f749 != roundnumber;
        
        if ( roundnumber > 0 && roundnumber != level.var_6781718da4f78d1c.roundnumber && var_30ce3485e635edfc )
        {
            iprintln( "<dev string:xfc>" + roundnumber + "<dev string:x110>" );
            function_68bdb49c82c0f892( roundnumber );
        }
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xa6c9e5ae, Offset: 0x16ac
    // Size: 0xce, Type: dev
    function function_fab26a96c1e8691f()
    {
        if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns ) )
        {
            function_84e70eedb4a257d0();
            
            if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ zm_utility::get_round_number() ] ) )
            {
                debug_end_round();
                wait 5;
            }
            
            foreach ( index, special_round in level.var_a009ab14ee0d3223.specialroundspawns )
            {
                function_68bdb49c82c0f892( index );
            }
        }
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xfdafafad, Offset: 0x1782
    // Size: 0x333, Type: dev
    function function_84e70eedb4a257d0()
    {
        if ( getdvarint( @"hash_a3d8279ebfa85341", 0 ) == 0 )
        {
            setdvar( @"hash_a3d8279ebfa85341", 1 );
            special_spawn_list = level.var_a009ab14ee0d3223.scriptbundle.specialroundspawn_list;
            
            if ( isdefined( special_spawn_list ) )
            {
                foreach ( v in special_spawn_list )
                {
                    specialroundinfo = spawnstruct();
                    var_64aa85763ee17d1 = v.var_56ce8489fb2cb6bb;
                    var_53b9f2b28e0ba0e7 = v.var_2e583fefcad48069 + 1;
                    specialroundinfo.specialroundname = v.specialroundname;
                    beginround = randomintrange( var_64aa85763ee17d1, var_53b9f2b28e0ba0e7 );
                    
                    if ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] ) )
                    {
                        while ( isdefined( level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] ) )
                        {
                            beginround++;
                        }
                    }
                    
                    level.var_a009ab14ee0d3223.var_90e1d244c1410109[ v.specialroundname ] = 0;
                    specialroundinfo.ailist = v.speciallist;
                    specialroundinfo.var_e28b1bf3be5e30f2 = v.var_e28b1bf3be5e30f2;
                    specialroundinfo.var_e26825f3be37ff38 = v.var_e26825f3be37ff38;
                    specialroundinfo.var_16f342b397743f5 = v.var_16f342b397743f5;
                    specialroundinfo.var_1921e2b399d5b4b = v.var_1921e2b399d5b4b;
                    specialroundinfo.specialroundname = v.specialroundname;
                    specialroundinfo.var_562e39c780ef0fa4 = v.var_562e39c780ef0fa4;
                    specialroundinfo.var_21ac207e2908c5c8 = v.var_21ac207e2908c5c8;
                    specialroundinfo.var_52bfbe9e13deb4c7 = v.var_52bfbe9e13deb4c7;
                    specialroundinfo.var_1fb01024d9a5c081 = v.var_1fb01024d9a5c081;
                    specialroundinfo.var_eec8f2844cac48b5 = v.var_eec8f2844cac48b5;
                    specialroundinfo.roundendrewardlist = v.roundendrewardlist;
                    specialroundinfo.var_29c2ee2eb254f8d5 = v.var_29c2ee2eb254f8d5;
                    specialroundinfo.var_c77a2bb3ee36c2c9 = v.var_c77a2bb3ee36c2c9;
                    
                    if ( !specialroundinfo.var_c77a2bb3ee36c2c9 )
                    {
                        specialroundinfo.var_c830f5a7892c96de = v.var_c830f5a7892c96de;
                    }
                    
                    level.var_a009ab14ee0d3223.specialroundspawns[ beginround ] = specialroundinfo;
                }
                
                zm_round_spawning::function_72b3db5fc2b7d929( get_rb_round_number() );
            }
        }
        
        if ( getdvarint( @"hash_cfc3eea82ec8401", 0 ) == 0 )
        {
            setdvar( @"hash_cfc3eea82ec8401", 1 );
            zm_round_spawning::function_bf27d914a0d9ae6c();
        }
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0x457268b2, Offset: 0x1abd
    // Size: 0x2e5, Type: dev
    function setup_round_logic_devgui()
    {
        level thread function_707d2a785251e948();
        devgui::function_9082edeb5db93280( "<dev string:x11c>" );
        devgui::add_devgui_func( "<dev string:x127>", "<dev string:x131>", &debug_end_round, 0 );
        devgui::add_devgui_func( "<dev string:x13b>", "<dev string:x14a>", &function_62fa604975999150, 0 );
        devgui::add_devgui_func( "<dev string:x159>", "<dev string:x164>", &debug_next_round, 0 );
        devgui::add_devgui_func( "<dev string:x16f>", "<dev string:x185>", &toggle_round_spawning, 0 );
        devgui::add_devgui_func( "<dev string:x19b>", "<dev string:x1b2>", &function_84e70eedb4a257d0, 0 );
        devgui::add_devgui_func( "<dev string:x1c9>", "<dev string:x1e2>", &function_fab26a96c1e8691f, 0 );
        devgui::add_devgui_func( "<dev string:x1fb>", "<dev string:x222>", &function_6dbdaa9e3d5a9c9a, 0, 1 );
        devgui::add_devgui_func( "<dev string:x237>", "<dev string:x25e>", &function_8b641c4cf091397f, 0 );
        devgui::add_devgui_dvar( "<dev string:x284>", "<dev string:x2a5>" );
        devgui::add_devgui_func( "<dev string:x2c3>", "<dev string:x2e8>", &function_820f8399c570d991, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x300>", "<dev string:x30e>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x31c>", "<dev string:x32b>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33a>", "<dev string:x349>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x358>", "<dev string:x367>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x376>", "<dev string:x385>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x394>", "<dev string:x3a3>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3b2>", "<dev string:x3c1>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3d0>", "<dev string:x3df>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3ee>", "<dev string:x3fd>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x40c>", "<dev string:x41b>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x42a>", "<dev string:x439>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x448>", "<dev string:x457>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x466>", "<dev string:x475>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x484>", "<dev string:x493>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a2>", "<dev string:x4b1>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4c0>", "<dev string:x4cf>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4de>", "<dev string:x4ed>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4fc>", "<dev string:x50b>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51a>", "<dev string:x529>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x538>", "<dev string:x548>", &function_b4091ae201e21ff7, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x558>", "<dev string:x568>", &function_b4091ae201e21ff7, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_round_logic
    // Params 0
    // Checksum 0xff2cc962, Offset: 0x1daa
    // Size: 0x65, Type: dev
    function function_707d2a785251e948()
    {
        level endon( #"game_ended" );
        var_73f9184814a0b788 = getdvarint( @"scr_debug_round_number", 0 );
        
        while ( true )
        {
            var_f4799cb33f36a3ac = getdvarint( @"scr_debug_round_number", 0 );
            
            if ( var_73f9184814a0b788 != var_f4799cb33f36a3ac )
            {
                function_68bdb49c82c0f892( var_f4799cb33f36a3ac );
            }
            
            var_73f9184814a0b788 = var_f4799cb33f36a3ac;
            wait 0.1;
        }
    }

    // Namespace zm_round_logic
    // Params 0, eflags: 0x4
    // Checksum 0x4ef788d9, Offset: 0x1e17
    // Size: 0x53, Type: dev
    function private toggle_round_spawning()
    {
        zm_round_spawning::pause_round_spawning( !level.var_a009ab14ee0d3223.spawningpaused, "<dev string:x578>" );
        iprintlnbold( "<dev string:x58b>" + ( level.var_a009ab14ee0d3223.spawningpaused ? "<dev string:x59c>" : "<dev string:x5a3>" ) );
    }

#/
