// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_bullseye_ee.gsc  (hash_30c34e2b277cc4d0.gscc) (size: 23397 Bytes / 0x5b65 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9af92385 (2600018821)
// size ...... 23397 (0x5b65)
// includes .. 17  (offset: 0x54c9)
// strings ... 48  (offset: 0x5551)
// dev strs .. 60  (offset: 0x587d)
// exports ... 63  (offset: 0x3559)
// cseg ...... 0x45f + 0x30fa (0x3559)
// imports ... 175 (offset: 0x3f31)
// animtree1 . 0   (offset: 0x5b65)
// animtree2 . 0   (offset: 0x5b65)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\crafting_table;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_firefly_script_bullseye_ee;

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x5
// Checksum 0xd47547f, Offset: 0x47d
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_bullseye_ee", undefined, &pre_init, &init );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x780db1d1, Offset: 0x4a2
// Size: 0x2
function private pre_init()
{
    
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xae5b71c0, Offset: 0x4ac
// Size: 0x16c
function private init()
{
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    if ( level.disable_firefly_bullseye_ee )
    {
        return;
    }
    
    level._effect[ "trophy_glow" ] = loadfxasset( "vfx_sat_firefly_trophy_glow" );
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_firefly_script_bullseye_ee_cs_completed" );
    zm_quest::register_quest_step( #"bullseye_ee", #"touch_trophy", &function_c4d82282b1a86921, &function_1579ffabc4788386 );
    zm_quest::register_quest_step( #"bullseye_ee", #"pickup_axe", &function_c4d81f82b1a86288, &function_1579feabc4788153 );
    zm_quest::register_quest_step( #"bullseye_ee", #"hit_target", &function_c4d82082b1a864bb, &function_1579fdabc4787f20 );
    zm_quest::register_quest_step( #"bullseye_ee", #"give_prize", &function_c4d82582b1a86fba, &function_157a04abc4788e85 );
    level.bullseye_ee_quest = zm_quest::get_quest( #"bullseye_ee" );
    level.var_9e7be97e047798 = [ #"touch_trophy", #"pickup_axe", #"hit_target", #"give_prize" ];
    level.bullseye_ee_quest.var_f725df16a798daf2 = getdvarint( @"hash_31a08ead636892cb", 1 );
    level thread bullseye_ee_setup();
    
    /#
        setup_bullseye_ee_devgui();
    #/
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x9b6cb397, Offset: 0x620
// Size: 0x150
function private bullseye_ee_setup()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    trophy = getent( "bullseye_ee_trophy", "script_noteworthy" );
    level.bullseye_ee_quest.trophy = trophy;
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"bullseye_ee", #"hash_d61f53977a395bb6" ) == 1 )
    {
        level.bullseye_ee_quest.n_reward_tier = zm_quest::function_73720cdf21c3cfd7( #"bullseye_ee", #"hash_83906a7889af845b" ) ?? 0;
        function_7253d0d4dcd273b3( level.bullseye_ee_quest.n_reward_tier );
        return;
    }
    
    level thread zm_quest::start_quest( #"bullseye_ee" );
    s_loc = utility::getstruct( "bullseye_target_start", "script_noteworthy" );
    targets = utility::getstructarray( s_loc.target );
    level.bullseye_ee_quest.targets = targets;
    level.bullseye_ee_quest.n_hit_targets = 0;
    level.bullseye_ee_quest.n_reward_tier = 0;
    level callback::add( #"player_connect", &function_7fb4211963eb4a6f );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1
// Checksum 0x24e25da3, Offset: 0x778
// Size: 0x55
function function_7fb4211963eb4a6f( params )
{
    xuid = self getxuid();
    var_6df1da6d3f0e3 = level.bullseye_ee_quest.unique_xuids;
    
    if ( isdefined( var_6df1da6d3f0e3 ) )
    {
        if ( arraycontains( var_6df1da6d3f0e3, xuid ) )
        {
            self.bullseye_win = 1;
        }
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x5e337d51, Offset: 0x7d5
// Size: 0xa3
function private function_c4d82282b1a86921( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        function_d2e0e7316a7831cf();
        return;
    }
    
    level.bullseye_ee_quest thread function_a5c627cb9029e074();
    function_660bc7a37c334fbd( #"touch_trophy", &function_49a37a1e417f736 );
    s_loc = utility::getstruct( "firefly_trophy_interact", "script_noteworthy" );
    level.bullseye_ee_quest.trophy_interact = zm_quest::function_91f9590e98d57ff6( s_loc.origin, &function_be1eea03ecf5edc6, &function_48ee015e72644338, "extrasmallnohint" );
    utility::flag_wait( "trophy_touched" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x44b439cc, Offset: 0x880
// Size: 0x96
function private function_1579ffabc4788386( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped && !b_save_restored )
        {
            if ( !level.bullseye_ee_quest.quest_owner )
            {
                level.bullseye_ee_quest.quest_owner = level.players[ 0 ];
            }
            
            utility::flag_set( "<dev string:x24>" );
        }
    #/
    
    if ( level.bullseye_ee_quest.trophy_interact )
    {
        level.bullseye_ee_quest.trophy_interact zm_quest::function_9170db4686f796e2();
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xeb4dc905, Offset: 0x91e
// Size: 0x24
function private function_49a37a1e417f736()
{
    profilestart();
    level utility::flag_clear( "trophy_touched" );
    level.bullseye_ee_quest.quest_owner = undefined;
    profilestop();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xc086219, Offset: 0x94a
// Size: 0x173
function private function_be1eea03ecf5edc6( player )
{
    if ( !level.bullseye_ee_quest.quest_owner && !player.var_923a5db5f73853da && !player.bullseye_win )
    {
        if ( level.bullseye_ee_quest.trophy )
        {
            ignoregroup = level.players;
            result = trace::ray_trace( player geteye(), level.bullseye_ee_quest.trophy.origin, ignoregroup );
            var_90ec0886f9ccf215 = result[ "entity" ];
            
            if ( !var_90ec0886f9ccf215 )
            {
                return;
            }
            
            playfxontagforclients( utility::getfx( "trophy_glow" ), level.bullseye_ee_quest.trophy, "tag_origin", player );
            player playsoundtoplayer( "evt_zm_firefly_ee_bullseye_event_start", player );
        }
        
        level.bullseye_ee_quest.quest_owner = player;
        level.bullseye_ee_quest.quest_owner thread function_d5fd1b368b3dc85();
        
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            level thread player_banter::play_banter_vo( #"bullseye_touch_trophy", [ player ], undefined, 1 );
        }
        else
        {
            level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
        }
        
        utility::flag_set( "trophy_touched" );
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x4f5408a, Offset: 0xac5
// Size: 0xb8
function private function_48ee015e72644338( interact, player )
{
    /#
        ignoregroup = level.players;
        result = trace::ray_trace( player geteye(), level.bullseye_ee_quest.trophy.origin, ignoregroup );
        var_90ec0886f9ccf215 = result[ "<dev string:x33>" ];
        
        if ( var_90ec0886f9ccf215 )
        {
            sphere( interact.origin, 10, ( 1, 0, 0 ) );
        }
    #/
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x499a7b4f, Offset: 0xb86
// Size: 0xc5
function private function_c4d81f82b1a86288( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    player = level.bullseye_ee_quest.quest_owner;
    
    if ( !player )
    {
        return;
    }
    
    quest_step = self;
    quest_step function_660bc7a37c334fbd( #"pickup_axe", &function_b73b694288cd2303 );
    level.bullseye_ee_quest.start_axe = spawn_start_axe( player );
    quest_step childthread function_1c99319f0bbab816( player );
    
    if ( !level callback::exists( #"player_item_pickup", &on_quest_item_pickup ) )
    {
        level callback::add( #"player_item_pickup", &on_quest_item_pickup );
    }
    
    level utility::flag_wait( "got_bullseye_axe" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0xa45fa791, Offset: 0xc53
// Size: 0xc3
function private function_1579feabc4788153( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped && !b_save_restored )
        {
            assert( level.bullseye_ee_quest.quest_owner, "<dev string:x3a>" );
            var_3eebad4f7884c91a = level.bullseye_ee_quest.start_axe;
            assert( var_3eebad4f7884c91a, "<dev string:x52>" );
            var_3eebad4f7884c91a function_130d52874e280b5c( level.bullseye_ee_quest.quest_owner );
        }
    #/
    
    function_e2d28fc377bebc2();
    
    if ( level callback::exists( #"player_item_pickup", &on_quest_item_pickup ) )
    {
        level callback::remove( #"player_item_pickup", &on_quest_item_pickup );
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xed366a3, Offset: 0xd1e
// Size: 0x4d
function private function_b73b694288cd2303()
{
    profilestart();
    level utility::flag_clear( "got_bullseye_axe" );
    
    if ( level callback::exists( #"player_item_pickup", &on_quest_item_pickup ) )
    {
        level callback::remove( #"player_item_pickup", &on_quest_item_pickup );
    }
    
    function_e2d28fc377bebc2();
    function_a4a90eb542c8e089();
    profilestop();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xf52b6653, Offset: 0xd73
// Size: 0x63
function private function_e2d28fc377bebc2()
{
    if ( level.bullseye_ee_quest.start_axe.axe_interaction )
    {
        level.bullseye_ee_quest.start_axe.axe_interaction zm_quest::function_9170db4686f796e2();
        level.bullseye_ee_quest.start_axe.axe_interaction = undefined;
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xd8a27e98, Offset: 0xdde
// Size: 0x43
function private function_a4a90eb542c8e089()
{
    if ( level.bullseye_ee_quest.start_axe )
    {
        level.bullseye_ee_quest.start_axe freescriptable();
        level.bullseye_ee_quest.start_axe = undefined;
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xac234b89, Offset: 0xe29
// Size: 0x10f
function private spawn_start_axe( player )
{
    profilestart();
    
    if ( !isplayer( player ) || !player )
    {
        assertmsg( "<dev string:x6d>" );
        profilestop();
        return;
    }
    
    s_loc_interaction = utility::getstruct( "combataxe_bullseye_ee_start", "targetname" );
    s_loc_axe = utility::getstruct( "bullseye_pickup_axe", "script_noteworthy" );
    team_select_payload = [ #"teamselect", player getentitynumber() ];
    item = spawnscriptable( %"zm_sat_firefly_bullseye_ee_axe", s_loc_axe.origin, s_loc_axe.angles, undefined, team_select_payload );
    item.var_7a65426f252841e7 = 1;
    item.owningplayer = player;
    item.axe_interaction = zm_quest::function_91f9590e98d57ff6( s_loc_interaction, &function_130d52874e280b5c, &function_d72d9f5deea0d892, "extrasmallnohint" );
    item.axe_interaction.var_3eebad4f7884c91a = item;
    profilestop();
    return item;
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0xc
// Checksum 0x69adfb6e, Offset: 0xf42
// Size: 0xe8
function private function_1c99319f0bbab816( quest_owner )
{
    self notify( #"hash_80e08af23efcb097" );
    self endon( #"hash_80e08af23efcb097" );
    level endon( #"game_ended" );
    level endon( #"got_bullseye_axe" );
    
    if ( !quest_owner )
    {
        assertmsg( "<dev string:x92>" );
        return;
    }
    
    quest_owner endon( #"death_or_disconnect" );
    s_loc_axe = utility::getstruct( "bullseye_pickup_axe", "script_noteworthy" );
    wait getdvarint( @"hash_32eddb327fd843ea", 30 );
    
    while ( true )
    {
        waitframe();
        
        if ( !utility::within_fov( quest_owner.origin, quest_owner.angles, s_loc_axe.origin, cos( 50 ) ) )
        {
            function_e2d28fc377bebc2();
            function_a4a90eb542c8e089();
            level.bullseye_ee_quest notify( #"restart_bullseye" );
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xe1f9d294, Offset: 0x1032
// Size: 0xd5
function private function_130d52874e280b5c( player )
{
    if ( self.var_3eebad4f7884c91a && self.var_3eebad4f7884c91a.owningplayer != player )
    {
        return;
    }
    
    currentequipment = player equipment_mp::getcurrentequipment( "primary" );
    currentammo = 0;
    player playsoundtoplayer( "uin_zm_common_pickup_item", player );
    
    if ( currentequipment )
    {
        currentammo = player equipment_mp::getequipmentammo( currentequipment );
    }
    
    if ( currentequipment && currentequipment != "equip_combataxe" )
    {
        player crafting_table::function_8fad33553f964d5b( currentequipment, currentammo );
    }
    
    player equipment_mp::giveequipment( "equip_combataxe", "primary" );
    player give_axe( 2 );
    utility::flag_set( "got_bullseye_axe" );
    
    if ( self.var_3eebad4f7884c91a )
    {
        self.var_3eebad4f7884c91a freescriptable();
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x51bb7429, Offset: 0x110f
// Size: 0x36
function private function_d72d9f5deea0d892( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0x19ce52e, Offset: 0x114e
// Size: 0x92
function private on_quest_item_pickup( params )
{
    profilestart();
    
    if ( !params.itembundle.ref )
    {
        profilestop();
        return;
    }
    
    itembundle = params.itembundle;
    item = params.item;
    
    switch ( itembundle.ref )
    {
        case #"hash_c018a696dcbb53a8":
            if ( item.var_9f20dc1eea7a447c )
            {
                level utility::flag_set( "got_bullseye_axe" );
            }
            
            break;
    }
    
    profilestop();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0xc3b2094b, Offset: 0x11e8
// Size: 0x1b7
function private function_c4d82082b1a864bb( b_skipped, b_save_restored )
{
    quest_step = self;
    
    if ( b_save_restored )
    {
        return;
    }
    
    player = level.bullseye_ee_quest.quest_owner;
    
    if ( !player )
    {
        return;
    }
    
    quest_step function_660bc7a37c334fbd( #"hit_target", &function_ad42be94155a15d8 );
    
    if ( !level callback::exists( #"equipment_use", &on_equipment_used ) )
    {
        level callback::add( #"equipment_use", &on_equipment_used );
    }
    
    scriptable::scriptable_adddamagedcallback( &bullseye_target_damaged );
    level.bullseye_ee_quest.current_target = spawn_start_target( player );
    quest_step childthread function_164e09f877344f9c();
    level utility::flag_wait( "bullseye_start" );
    level childthread spawn_targets();
    level childthread function_5fb53d780f3a6cad();
    level childthread function_fae8973d22625e20();
    level utility::flag_wait_any( "bullseye_time_up", "bullseye_win", "bullseye_failed" );
    
    if ( level.bullseye_ee_quest.n_hit_targets < 7 )
    {
        level.bullseye_ee_quest.n_reward_tier = 0;
    }
    
    if ( level.bullseye_ee_quest.n_hit_targets >= 7 )
    {
        level.bullseye_ee_quest.n_reward_tier = 1;
    }
    
    if ( level.bullseye_ee_quest.n_hit_targets >= 10 )
    {
        level.bullseye_ee_quest.n_reward_tier = 2;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"bullseye_ee", #"hash_83906a7889af845b", level.bullseye_ee_quest.n_reward_tier );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x5b769c13, Offset: 0x13a7
// Size: 0x118
function private function_1579fdabc4787f20( b_skipped, b_save_restored )
{
    scriptable::function_dc174fecebb79952( &bullseye_target_damaged );
    
    if ( level callback::exists( #"equipment_use", &on_equipment_used ) )
    {
        level callback::remove( #"equipment_use", &on_equipment_used );
    }
    
    s_loc = utility::getstruct( "bullseye_target_start", "script_noteworthy" );
    targets = utility::getstructarray( s_loc.target );
    level.bullseye_ee_quest.targets = targets;
    
    if ( level.bullseye_ee_quest.current_target )
    {
        level.bullseye_ee_quest.current_target utility::function_7c10ea82c1e305b8( "model", "off" );
        level.bullseye_ee_quest.current_target utility::function_7c10ea82c1e305b8( "vfx", "hit" );
        wait 0.5;
        level.bullseye_ee_quest.current_target freescriptable();
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x78127c2f, Offset: 0x14c7
// Size: 0x12a
function private function_ad42be94155a15d8()
{
    profilestart();
    level utility::flag_clear( "bullseye_start" );
    level utility::flag_clear( "bullseye_win" );
    level utility::flag_clear( "bullseye_time_up" );
    level utility::flag_clear( "bullseye_failed" );
    level.bullseye_ee_quest.n_hit_targets = 0;
    level.bullseye_ee_quest.n_reward_tier = 0;
    s_loc = utility::getstruct( "bullseye_target_start", "script_noteworthy" );
    targets = utility::getstructarray( s_loc.target );
    level.bullseye_ee_quest.targets = targets;
    scriptable::function_dc174fecebb79952( &bullseye_target_damaged );
    
    if ( level callback::exists( #"equipment_use", &on_equipment_used ) )
    {
        level callback::remove( #"equipment_use", &on_equipment_used );
    }
    
    if ( level.bullseye_ee_quest.current_target )
    {
        level.bullseye_ee_quest.current_target freescriptable();
        level.bullseye_ee_quest.current_target = undefined;
    }
    
    profilestop();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 11, eflags: 0x4
// Checksum 0x5bca5626, Offset: 0x15f9
// Size: 0x223
function private bullseye_target_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"sat_zm_firefly_bullseye_target" )
    {
        return;
    }
    
    if ( !level.bullseye_ee_quest.quest_owner )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) || eattacker != level.bullseye_ee_quest.quest_owner )
    {
        return;
    }
    
    equipmentref = equipment_mp::function_fdc4a655fbde0dec( objweapon.basename );
    
    if ( !equipment_mp::isequipmentlethal( equipmentref ) || equipmentref != "equip_combataxe" )
    {
        return;
    }
    
    if ( instance.flag )
    {
        level utility::flag_set( instance.flag );
        instance utility::function_7c10ea82c1e305b8( "model", "off" );
        instance utility::function_7c10ea82c1e305b8( "vfx", "hit" );
        instance notify( #"target_hit" );
        eattacker.var_e2cbe81f0de9b877 = eattacker equipment_mp::getequipmentammo( "equip_combataxe" );
        eattacker thread give_axe( 2 );
        return;
    }
    
    level.bullseye_ee_quest.n_hit_targets++;
    
    if ( instance.var_2b0c20cebe23ba0b )
    {
        instance.var_2b0c20cebe23ba0b delete();
    }
    
    if ( level.bullseye_ee_quest.var_f725df16a798daf2 && utility::flag( "bullseye_start" ) )
    {
        var_9684a7a4b41045d3 = eattacker equipment_mp::getequipmentammo( "equip_combataxe" );
        
        if ( var_9684a7a4b41045d3 <= 0 )
        {
            eattacker equipment_mp::setequipmentammo( "equip_combataxe", 1 );
        }
    }
    
    instance utility::function_7c10ea82c1e305b8( "model", "off" );
    instance utility::function_7c10ea82c1e305b8( "vfx", "hit" );
    instance notify( #"target_hit" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xb85d6ac0, Offset: 0x1824
// Size: 0x77
function private on_equipment_used( params )
{
    if ( !level.bullseye_ee_quest.quest_owner )
    {
        return;
    }
    
    if ( params.player == level.bullseye_ee_quest.quest_owner )
    {
        if ( params.ref == "equip_combataxe" )
        {
            params.player thread recharge_axe( params.ref );
        }
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0xc
// Checksum 0xf4c61b1, Offset: 0x18a3
// Size: 0x132
function private recharge_axe( equipmentref )
{
    self notify( #"hash_a32159f659434f0e" );
    self endon( #"hash_a32159f659434f0e" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"bullseye_win" );
    self endon( #"bullseye_time_up" );
    self endon( #"bullseye_failed" );
    
    if ( !level.bullseye_ee_quest )
    {
        assertmsg( "<dev string:xc7>" );
        return;
    }
    
    level.bullseye_ee_quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    var_83f3cba0a7d7f738 = zm_quest::get_quest_step( #"bullseye_ee", #"hit_target" );
    
    if ( !var_83f3cba0a7d7f738 )
    {
        assertmsg( "<dev string:xe5>" );
        return;
    }
    
    var_83f3cba0a7d7f738 endon( #"hash_2c4eefaf7e2b24b6" );
    
    if ( level.bullseye_ee_quest.var_f725df16a798daf2 && utility::flag( "bullseye_start" ) )
    {
        wait 3;
        var_9684a7a4b41045d3 = equipment_mp::getequipmentammo( equipmentref );
        
        if ( var_9684a7a4b41045d3 <= 0 )
        {
            equipment_mp::setequipmentammo( equipmentref, 1 );
        }
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0x9a6ac, Offset: 0x19dd
// Size: 0xe2
function private spawn_start_target( player )
{
    profilestart();
    
    if ( !player )
    {
        assertmsg( "<dev string:x10c>" );
        profilestop();
        return;
    }
    
    s_loc = utility::getstruct( "bullseye_target_start", "script_noteworthy" );
    team_select_payload = [ #"teamselect", player getentitynumber() ];
    var_5ddea964f429e3cf = spawnscriptable( %"sat_zm_firefly_bullseye_target", s_loc.origin, s_loc.angles, undefined, team_select_payload );
    var_5ddea964f429e3cf.health = 100000;
    var_5ddea964f429e3cf.aicategory = "normal";
    var_5ddea964f429e3cf.var_a03f571fe06a52b8 = 1;
    var_5ddea964f429e3cf.flag = "bullseye_start";
    var_5ddea964f429e3cf.owningplayer = player;
    profilestop();
    return var_5ddea964f429e3cf;
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0x2d91faed, Offset: 0x1ac9
// Size: 0xb6
function private function_164e09f877344f9c()
{
    self notify( #"hash_2074754d4be4f762" );
    self endon( #"hash_2074754d4be4f762" );
    level endon( #"game_ended" );
    level endon( #"bullseye_start" );
    wait getdvarint( @"hash_c8e39a4d14c3f87b", 30 );
    level.bullseye_ee_quest.current_target utility::function_7c10ea82c1e305b8( "model", "off" );
    level.bullseye_ee_quest.current_target utility::function_7c10ea82c1e305b8( "vfx", "hit" );
    level.bullseye_ee_quest.current_target freescriptable();
    level.bullseye_ee_quest notify( #"restart_bullseye" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x1b26af1d, Offset: 0x1b87
// Size: 0x84
function private spawn_targets()
{
    level endon( #"game_ended" );
    level endon( #"bullseye_win" );
    level endon( #"bullseye_time_up" );
    level endon( #"bullseye_failed" );
    player = level.bullseye_ee_quest.quest_owner;
    
    if ( !player )
    {
        assertmsg( "<dev string:x10c>" );
        return;
    }
    
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        spawn_target( player );
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xeab8882c, Offset: 0x1c13
// Size: 0x238
function private spawn_target( player )
{
    if ( !player )
    {
        return;
    }
    
    var_41fa64a632171757 = 0;
    
    if ( level.bullseye_ee_quest.n_hit_targets >= 3 )
    {
        var_41fa64a632171757 = 1;
    }
    
    if ( level.bullseye_ee_quest.n_hit_targets >= 10 )
    {
        level utility::flag_set( "bullseye_win" );
        return;
    }
    
    if ( level.bullseye_ee_quest.targets.size == 0 || !level.bullseye_ee_quest.targets )
    {
        s_loc = utility::getstruct( "bullseye_target_start", "script_noteworthy" );
        targets = utility::getstructarray( s_loc.target );
        level.bullseye_ee_quest.targets = targets;
    }
    
    s_loc = utility::array_random( level.bullseye_ee_quest.targets );
    level.bullseye_ee_quest.targets = arrayremove( level.bullseye_ee_quest.targets, s_loc );
    team_select_payload = [ #"teamselect", player getentitynumber() ];
    var_5ddea964f429e3cf = spawnscriptable( %"sat_zm_firefly_bullseye_target", s_loc.origin, s_loc.angles, undefined, team_select_payload );
    var_5ddea964f429e3cf.health = 100000;
    var_5ddea964f429e3cf.aicategory = "normal";
    var_5ddea964f429e3cf.var_a03f571fe06a52b8 = 1;
    var_5ddea964f429e3cf.owningplayer = player;
    
    /#
        sphere( var_5ddea964f429e3cf.origin, 20, ( 1, 0, 0 ), 0, 5 );
    #/
    
    if ( var_41fa64a632171757 && var_5ddea964f429e3cf )
    {
        var_5ddea964f429e3cf.parent_origin = s_loc.origin;
        var_5ddea964f429e3cf childthread target_move_loop();
    }
    
    if ( var_5ddea964f429e3cf )
    {
        level.bullseye_ee_quest.current_target = var_5ddea964f429e3cf;
    }
    
    var_5ddea964f429e3cf waittill( #"target_hit" );
    var_5ddea964f429e3cf freescriptable();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xf6d7d290, Offset: 0x1e53
// Size: 0x2c7
function private target_move_loop()
{
    self endon( #"death" );
    self endon( #"bullseye_win" );
    self endon( #"bullseye_time_up" );
    self endon( #"bullseye_failed" );
    self endon( #"target_hit" );
    leftpos = anglestoleft( self.angles ) * 48 + ( 0, 0, 40 );
    e_move_tag = utility::spawn_model( "tag_origin", self.origin + leftpos, self.angles );
    utility::scriptable_setparententity( e_move_tag );
    self.var_2b0c20cebe23ba0b = e_move_tag;
    
    /#
        sphere( e_move_tag.origin, 20, ( 1, 0, 0 ), 0, 10 );
    #/
    
    movement_modes = [ "vertical", "horizontal", "circle" ];
    movement_mode = utility::array_random( movement_modes );
    
    switch ( movement_mode )
    {
        case #"hash_91e23845b57069b":
            startpos = self.parent_origin;
            endpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 200 );
            
            while ( true )
            {
                if ( e_move_tag )
                {
                    e_move_tag moveto( endpos, 5 );
                }
                
                wait 5;
                wait 1;
                
                if ( e_move_tag )
                {
                    e_move_tag moveto( startpos, 5 );
                }
                
                wait 5;
                wait 1;
            }
            
            break;
        case #"hash_5ed103ce4e13e1c9":
            startpos = self.parent_origin;
            endpos = startpos + anglestoleft( self.angles ) * 200;
            
            while ( true )
            {
                if ( e_move_tag )
                {
                    e_move_tag moveto( endpos, 5 );
                }
                
                wait 5;
                wait 1;
                
                if ( e_move_tag )
                {
                    e_move_tag moveto( startpos, 5 );
                }
                
                wait 5;
                wait 1;
            }
            
            break;
        case #"hash_e4c599d868b9bce9":
            breverse = randomintrange( 0, 1 );
            rotation_offset = 180;
            
            if ( breverse )
            {
                rotation_offset = -180;
            }
            
            while ( true )
            {
                if ( e_move_tag )
                {
                    e_move_tag rotateto( ( e_move_tag.angles[ 0 ], e_move_tag.angles[ 1 ], e_move_tag.angles[ 2 ] + rotation_offset ), 5 );
                }
                
                wait 5;
                wait 0.2;
                
                if ( e_move_tag )
                {
                    e_move_tag rotateto( ( e_move_tag.angles[ 0 ], e_move_tag.angles[ 1 ], e_move_tag.angles[ 2 ] + rotation_offset ), 5 );
                }
                
                wait 5;
                wait 0.2;
            }
            
            break;
        default:
            break;
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0xa0d6126f, Offset: 0x2122
// Size: 0x43
function private function_5fb53d780f3a6cad()
{
    self notify( #"hash_9c445a32a7ef3b5b" );
    self endon( #"hash_9c445a32a7ef3b5b" );
    level endon( #"bullseye_win" );
    wait getdvarint( @"hash_96fb8a46628e5331", 20 );
    level utility::flag_set( "bullseye_time_up" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0xdba3f131, Offset: 0x216d
// Size: 0xda
function private function_fae8973d22625e20()
{
    self notify( #"hash_d4bc7ccc87be8147" );
    self endon( #"hash_d4bc7ccc87be8147" );
    level endon( #"bullseye_win" );
    level endon( #"bullseye_time_up" );
    
    if ( !level.bullseye_ee_quest.quest_owner )
    {
        return;
    }
    
    player = level.bullseye_ee_quest.quest_owner;
    player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        zone = zone_manager::function_90e5c3e2272b0130( player.origin );
        
        if ( !issubstr( zone.script_zone_name, "lakefront" ) || issubstr( zone.script_zone_name, "zone_ts_w" ) )
        {
            level utility::flag_set( "bullseye_failed" );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0xf8babd34, Offset: 0x224f
// Size: 0x1c8
function private function_c4d82582b1a86fba( b_skipped, b_save_restored )
{
    quest_step = self;
    
    if ( b_save_restored )
    {
        return;
    }
    
    quest_step function_660bc7a37c334fbd( #"give_prize", &function_9ebc667d0155e90d );
    player = level.bullseye_ee_quest.quest_owner;
    
    if ( !player || utility::flag( "bullseye_failed" ) )
    {
        return;
    }
    
    s_loc = utility::getstruct( "bullseye_mr_peek_dance_scene" );
    player.var_923a5db5f73853da = 1;
    
    if ( level.bullseye_ee_quest.n_reward_tier == 0 )
    {
        playsoundatpos( s_loc.origin, "evt_zm_firefly_ee_mrpeeks_stinger" );
        player thread function_9053e62ef0a8177d();
        return;
    }
    
    player.bullseye_win = 1;
    xuid = player getxuid();
    
    if ( !isdefined( level.bullseye_ee_quest.unique_xuids ) )
    {
        level.bullseye_ee_quest.unique_xuids = [];
    }
    
    level.bullseye_ee_quest.unique_xuids[ level.bullseye_ee_quest.unique_xuids.size ] = xuid;
    level childthread function_81ddc664fe31b11d( s_loc );
    shot_length = level.bullseye_ee_quest.var_6d147da804fde6ea scene::function_b3c7b792a7a154fa( "shot_ending" ) - 0.5;
    wait shot_length;
    playsoundatpos( s_loc.origin, "evt_ee_complete_success_stinger" );
    zm_quest::function_4eefe6de31f5ddab( #"bullseye_ee", #"hash_d61f53977a395bb6", 1 );
    spawn_rewards( level.bullseye_ee_quest.n_reward_tier );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x93e4ce9f, Offset: 0x241f
// Size: 0xc7
function private function_157a04abc4788e85( b_skipped, b_save_restored )
{
    level.bullseye_ee_quest.n_hit_targets = 0;
    level.bullseye_ee_quest.n_reward_tier = 0;
    
    if ( level.bullseye_ee_quest.quest_owner && level.bullseye_ee_quest.quest_owner.var_e2cbe81f0de9b877 )
    {
        level.bullseye_ee_quest.quest_owner thread give_axe( level.bullseye_ee_quest.quest_owner.var_e2cbe81f0de9b877 );
    }
    
    level.bullseye_ee_quest.quest_owner = undefined;
    function_8f22183e2612db4();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x1f59933b, Offset: 0x24ee
// Size: 0x2
function private function_9ebc667d0155e90d()
{
    
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xaaad78e9, Offset: 0x24f8
// Size: 0xc3
function private function_81ddc664fe31b11d( var_5990ce3727e634d1 )
{
    mdl_bunny = utility::spawn_model( %"t10_zm_mystery_box_plinth_bunny_fxanim", ( 0, 0, 0 ) );
    sceneroot = spawnstruct();
    sceneroot.origin = var_5990ce3727e634d1.origin;
    sceneroot.angles = var_5990ce3727e634d1.angles;
    playsoundatpos( var_5990ce3727e634d1.origin, "evt_zm_firefly_ee_bullseye_mrpeeks_dance_mix" );
    level.bullseye_ee_quest.var_6d147da804fde6ea = sceneroot;
    sceneroot scene::init( mdl_bunny, "shot_ending", "t10_zm_cosmic_bowling_openning_1p" );
    sceneroot scene::play( mdl_bunny, "shot_ending", "t10_zm_cosmic_bowling_openning_1p" );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0xd95dbc8a, Offset: 0x25c3
// Size: 0x234
function private spawn_rewards( n_reward_tier = 0 )
{
    level endon( #"game_ended" );
    s_loc = utility::getstruct( "bullseye_reward_pos" );
    v_reward_location = s_loc.origin;
    s_loc = utility::getstruct( "bullseye_mr_peek_dance_scene" );
    itemorigin = s_loc.origin;
    
    if ( !isdefined( v_reward_location ) )
    {
        return;
    }
    
    player = level.bullseye_ee_quest.quest_owner;
    
    if ( !player )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    n_essence_count = 0;
    var_aa2106dd117931c2 = 0;
    var_8b5270de14dff72e = undefined;
    
    switch ( n_reward_tier )
    {
        case 1:
            var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_bullseye_ee_rewards", "Tier1" );
            break;
        case 2:
            var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_bullseye_ee_rewards", "Tier2" );
            params = spawnstruct();
            params.timestamp = gettime();
            params.questname = #"bullseye_ee";
            params.var_be82617e5e8087bd = [ player ];
            params.event = #"zm_sq_quest_complete";
            level callback::callback( #"hash_6c71d319dc089c27", params );
            level callback::callback( "zm_sq_quest_complete", params );
            break;
    }
    
    function_7253d0d4dcd273b3( n_reward_tier );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        if ( var_8b5270de14dff72e[ i ] )
        {
            random_point = getrandomnavpoint( v_reward_location, 200 ) + ( 0, 0, 4 );
            common_item::function_47324f290423b2d1( var_8b5270de14dff72e[ i ], itemorigin, random_point, undefined, 1 );
            wait 0.25;
        }
    }
    
    if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        level thread player_banter::play_banter_vo( #"bullseye_win", [ player ], undefined, 1 );
        return;
    }
    
    level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0x4ab90253, Offset: 0x27ff
// Size: 0x58
function private function_7253d0d4dcd273b3( n_reward_tier )
{
    switch ( n_reward_tier )
    {
        case 2:
            if ( level.bullseye_ee_quest.trophy )
            {
                level.bullseye_ee_quest.trophy setmodel( "sat_zm_axe_throwing_trophy_silver" );
            }
            
            break;
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0x28cbeb0f, Offset: 0x285f
// Size: 0x87
function private function_9053e62ef0a8177d()
{
    self notify( #"hash_37a8fbd39c94c23" );
    self endon( #"hash_37a8fbd39c94c23" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    var_49f7091014d2c59 = zm_round_logic::get_rb_round_number();
    var_d573ae91a5032f2e = var_49f7091014d2c59 + randomintrange( 1, 3 );
    
    while ( true )
    {
        level waittill( #"on_round_start" );
        
        if ( var_d573ae91a5032f2e <= zm_round_logic::get_rb_round_number() )
        {
            self.var_923a5db5f73853da = 0;
            break;
        }
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 1, eflags: 0x4
// Checksum 0x2e883981, Offset: 0x28ee
// Size: 0x37
function private give_axe( amount = 1 )
{
    if ( amount < 1 )
    {
        amount = 1;
    }
    
    if ( isplayer( self ) )
    {
        equipment_mp::setequipmentammo( "equip_combataxe", amount );
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x5b3c5070, Offset: 0x292d
// Size: 0x34
function private function_d2e0e7316a7831cf()
{
    if ( zm_quest::function_73720cdf21c3cfd7( #"bullseye_ee", #"hash_d61f53977a395bb6" ) == 1 )
    {
        return;
    }
    
    level thread zm_quest::restart_quest( #"bullseye_ee", 1 );
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0x30711a37, Offset: 0x2969
// Size: 0x75
function private function_d5fd1b368b3dc85()
{
    self notify( #"hash_cd8e90319d40c35b" );
    self endon( #"hash_cd8e90319d40c35b" );
    level endon( #"game_ended" );
    quest = level.bullseye_ee_quest;
    
    if ( !quest )
    {
        return;
    }
    
    quest endon( #"zm_quest_quit", #"zm_quest_restarted", #"zm_quest_completed" );
    self waittill( #"death_or_disconnect" );
    function_8f22183e2612db4();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0xc
// Checksum 0x89dd4b7, Offset: 0x29e6
// Size: 0x125
function private function_a5c627cb9029e074()
{
    self notify( #"hash_532547b3b9bf0194" );
    self endon( #"hash_532547b3b9bf0194" );
    bullseye_ee_quest = self;
    bullseye_ee_quest endon( #"zm_quest_quit", #"zm_quest_completed" );
    bullseye_ee_quest childthread function_7cc6d96cc87629c5();
    
    while ( true )
    {
        bullseye_ee_quest waittill( #"zm_quest_restarted" );
        
        if ( !level.var_279850c6c4d0db74 )
        {
            continue;
        }
        
        steps_count = level.var_9e7be97e047798.size;
        
        for ( i = steps_count - 1; i >= 0 ; i-- )
        {
            step_ref = level.var_9e7be97e047798[ i ];
            restart_func = level.var_279850c6c4d0db74[ step_ref ];
            
            if ( !restart_func )
            {
                continue;
            }
            
            quest_step = zm_quest::get_quest_step( #"bullseye_ee", step_ref );
            
            if ( !quest_step )
            {
                assertmsg( "<dev string:x131>" + #"bullseye_ee" + "<dev string:x149>" + step_ref );
                continue;
            }
            
            quest_step [[ restart_func ]]();
        }
        
        level.var_279850c6c4d0db74 = undefined;
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 2, eflags: 0x4
// Checksum 0x147d3d1, Offset: 0x2b13
// Size: 0x3f
function private function_660bc7a37c334fbd( step_ref, callback )
{
    if ( !isdefined( level.var_279850c6c4d0db74 ) )
    {
        level.var_279850c6c4d0db74 = [];
    }
    
    level.var_279850c6c4d0db74[ step_ref ] = callback;
    self [[ callback ]]();
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0xc131ac60, Offset: 0x2b5a
// Size: 0x4c
function private function_7cc6d96cc87629c5()
{
    bullseye_ee_quest = self;
    bullseye_ee_quest endon( #"zm_quest_quit", #"zm_quest_completed" );
    
    while ( true )
    {
        bullseye_ee_quest waittill( #"restart_bullseye" );
        level thread zm_quest::restart_quest( #"bullseye_ee" );
    }
}

// Namespace zm_sat_firefly_script_bullseye_ee
// Params 0, eflags: 0x4
// Checksum 0x92a9b6ae, Offset: 0x2bae
// Size: 0xc4
function private function_8f22183e2612db4()
{
    if ( !level.bullseye_ee_quest )
    {
        assertmsg( "<dev string:x14b>" );
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.var_923a5db5f73853da || !player.bullseye_win )
        {
            level.bullseye_ee_quest notify( #"restart_bullseye" );
            waitframe();
            break;
        }
    }
}

/#

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xc580b093, Offset: 0x2c7a
    // Size: 0x10e, Type: dev
    function private setup_bullseye_ee_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"bullseye_ee" );
        devgui::add_devgui_func( "<dev string:x166>", "<dev string:x179>", &function_6b5a00cdf35d7327 );
        devgui::add_devgui_func( "<dev string:x18c>", "<dev string:x19c>", &function_508e67e31a6db3ac );
        devgui::add_devgui_func( "<dev string:x1ac>", "<dev string:x1c1>", &function_6d3c7c318262e10e );
        devgui::add_devgui_func( "<dev string:x1d6>", "<dev string:x1e5>", &function_f758e229405929d3 );
        devgui::add_devgui_func( "<dev string:x1f4>", "<dev string:x201>", &function_b7adeedd7e895380 );
        devgui::add_devgui_func( "<dev string:x20e>", "<dev string:x219>", &devgui_target_hit );
        devgui::add_devgui_func( "<dev string:x224>", "<dev string:x233>", &devgui_spawn_target );
        devgui::add_devgui_func( "<dev string:x240>", "<dev string:x257>", &function_8c6550e580367dcd );
        devgui::add_devgui_func( "<dev string:x26e>", "<dev string:x283>", &function_d7952feacc13f465 );
        devgui::add_devgui_func( "<dev string:x2a9>", "<dev string:x2bd>", &function_819274934c7aaead );
        devgui::add_devgui_func( "<dev string:x2e1>", "<dev string:x2f3>", &function_aca602113513f601 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x2bb27101, Offset: 0x2d90
    // Size: 0x17, Type: dev
    function private devgui_spawn_target()
    {
        spawn_target( level.players[ 0 ] );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x89f064de, Offset: 0x2daf
    // Size: 0xc0, Type: dev
    function private function_8c6550e580367dcd()
    {
        s_loc = utility::getstruct( "<dev string:x315>", "<dev string:x32b>" );
        team_select_payload = [ #"teamselect", 1 ];
        target = spawnscriptable( %"sat_zm_firefly_bullseye_target", s_loc.origin, s_loc.angles, undefined, team_select_payload );
        target.health = 100000;
        target.aicategory = "<dev string:x33d>";
        target.var_a03f571fe06a52b8 = 1;
        target.owningplayer = undefined;
        level.bullseye_ee_quest.current_target = target;
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x475c5d23, Offset: 0x2e77
    // Size: 0x50, Type: dev
    function private function_b7adeedd7e895380()
    {
        target = level.bullseye_ee_quest.current_target;
        
        if ( target )
        {
            target utility::function_7c10ea82c1e305b8( "<dev string:x344>", "<dev string:x34a>" );
            waitframe();
            target utility::function_7c10ea82c1e305b8( "<dev string:x34d>", "<dev string:x351>" );
        }
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xbde1e456, Offset: 0x2ecf
    // Size: 0x50, Type: dev
    function private devgui_target_hit()
    {
        target = level.bullseye_ee_quest.current_target;
        
        if ( target )
        {
            target utility::function_7c10ea82c1e305b8( "<dev string:x344>", "<dev string:x357>" );
            waitframe();
            target utility::function_7c10ea82c1e305b8( "<dev string:x34d>", "<dev string:x35b>" );
        }
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x2efcf1de, Offset: 0x2f27
    // Size: 0x31, Type: dev
    function private function_6b5a00cdf35d7327()
    {
        s_loc = utility::getstruct( "<dev string:x35f>" );
        playsoundatpos( s_loc.origin, "<dev string:x37c>" );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xc2ba6f11, Offset: 0x2f60
    // Size: 0x31, Type: dev
    function private function_508e67e31a6db3ac()
    {
        s_loc = utility::getstruct( "<dev string:x35f>" );
        playsoundatpos( s_loc.origin, "<dev string:x39c>" );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x7bcd1ded, Offset: 0x2f99
    // Size: 0x60, Type: dev
    function private function_6d3c7c318262e10e()
    {
        player = level.players[ 0 ];
        
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            level thread player_banter::play_banter_vo( #"bullseye_touch_trophy", [ player ], undefined, 1 );
            return;
        }
        
        level thread battlechatter_mp::trysaylocalsound( player, #"hash_5212ed7ec42f115a", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xc039af30, Offset: 0x3001
    // Size: 0x60, Type: dev
    function private function_f758e229405929d3()
    {
        player = level.players[ 0 ];
        
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            level thread player_banter::play_banter_vo( #"bullseye_win", [ player ], undefined, 1 );
            return;
        }
        
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive", undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0x992649fd, Offset: 0x3069
    // Size: 0x190, Type: dev
    function private function_d7952feacc13f465()
    {
        if ( !level.bullseye_ee_quest )
        {
            return;
        }
        
        if ( level.var_395f10bc3202cfc6 )
        {
            level notify( #"hash_46463259080ca314" );
            level.var_395f10bc3202cfc6 = undefined;
            return;
        }
        
        level.var_395f10bc3202cfc6 = 1;
        player = level.players[ 0 ];
        player setorigin( ( 12540, 3042, 1094 ) );
        player setplayerangles( ( 0, 200, 0 ) );
        player thread function_4641de835d2d7cb( level.bullseye_ee_quest.trophy, "<dev string:x3be>" );
        s_loc_axe = utility::getstruct( "<dev string:x3cb>", "<dev string:x3e7>" );
        player thread function_4641de835d2d7cb( s_loc_axe, "<dev string:x3f2>" );
        var_53d6ca3df8d1cbe3 = utility::getstruct( "<dev string:x315>", "<dev string:x32b>" );
        player thread function_4641de835d2d7cb( var_53d6ca3df8d1cbe3, "<dev string:x3fc>" );
        
        if ( level.bullseye_ee_quest.targets )
        {
            foreach ( target in level.bullseye_ee_quest.targets )
            {
                player thread function_4641de835d2d7cb( target, "<dev string:x411>" );
            }
        }
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 4, eflags: 0x4
    // Checksum 0x7f3882e, Offset: 0x3201
    // Size: 0xec, Type: dev
    function private function_4641de835d2d7cb( target, print_text, color, sphere_radius )
    {
        if ( !isdefined( print_text ) )
        {
            print_text = "<dev string:x428>";
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        if ( !isdefined( sphere_radius ) )
        {
            sphere_radius = 10;
        }
        
        level endon( #"hash_46463259080ca314" );
        
        while ( true )
        {
            if ( !target || !target.origin || !self )
            {
                return;
            }
            
            line( self.origin, target.origin, color );
            sphere( target.origin, sphere_radius, color );
            print3d( target.origin, print_text + "<dev string:x429>" + length( target.origin - self.origin ) + "<dev string:x42c>", color );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xedbe7d76, Offset: 0x32f5
    // Size: 0x44, Type: dev
    function private function_819274934c7aaead()
    {
        me = level.players[ 0 ];
        me setorigin( ( -12223, 3132, 546 ) );
        me setplayerangles( ( 17, 212, 0 ) );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 0, eflags: 0x4
    // Checksum 0xb3367a3f, Offset: 0x3341
    // Size: 0xaa, Type: dev
    function private function_aca602113513f601()
    {
        item_bundle = getscriptbundle( "<dev string:x42e>" + "<dev string:x43e>" );
        me = level.players[ 0 ];
        spawn_pos = me.origin + anglestoforward( me.angles ) * 50;
        spawn_pos += anglestoup( me.angles ) * 50;
        angles = ( 269.3, 295.85, 114.29 );
        var_3eebad4f7884c91a = zm_quest::spawn_quest_item( spawn_pos, angles, item_bundle );
        var_3eebad4f7884c91a thread draw_debug_direction( spawn_pos, angles );
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 2, eflags: 0x4
    // Checksum 0xb3c5373a, Offset: 0x33f3
    // Size: 0x96, Type: dev
    function private draw_debug_direction( prefer_origin, prefer_angles )
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( !self )
            {
                return;
            }
            
            sphere( prefer_origin, 15, ( 0, 1, 0 ) );
            draw_directions( prefer_origin, prefer_angles, 20, ( 0, 1, 0 ) );
            draw_directions( self.origin, self.angles, 10, ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace zm_sat_firefly_script_bullseye_ee
    // Params 4, eflags: 0x4
    // Checksum 0xad4239af, Offset: 0x3491
    // Size: 0xc8, Type: dev
    function private draw_directions( origin, angles, scale, color )
    {
        f = origin + anglestoforward( angles ) * scale;
        line( origin, f, color );
        print3d( f, "<dev string:x454>", color, 1, 0.5 );
        u = origin + anglestoup( angles ) * scale;
        line( origin, u, color );
        print3d( u, "<dev string:x456>", color, 1, 0.5 );
        r = origin + anglestoright( angles ) * scale;
        line( origin, r, color );
        print3d( r, "<dev string:x458>", color, 1, 0.5 );
    }

#/
