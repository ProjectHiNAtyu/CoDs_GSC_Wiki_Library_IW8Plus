// script_756a9fd257eb4152  (hash_756a9fd257eb4152.gscc) (size: 24424 Bytes / 0x5f68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1802281c (402794524)
// size ...... 24424 (0x5f68)
// includes .. 32  (offset: 0x5814)
// strings ... 104 (offset: 0x5914)
// dev strs .. 6   (offset: 0x5f18)
// exports ... 55  (offset: 0x365c)
// cseg ...... 0x8dc + 0x2d80 (0x365c)
// imports ... 216 (offset: 0x3ef4)
// animtree1 . 0   (offset: 0x5f68)
// animtree2 . 0   (offset: 0x5f68)
#using script_3edd59d0d3fc3262;
#using script_50ee493a72a5e95b;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\callbacks;
#using scripts\common\hints;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\loot\common_item;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\objidpoolmanager;

#namespace namespace_1db368c7edbbc256;

/#

    // Namespace namespace_1db368c7edbbc256
    // Params 0
    // Checksum 0x2982cd08, Offset: 0x8fa
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x5
// Checksum 0xbbb5af9f, Offset: 0x907
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bd38388ec32d67fd", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x4
// Checksum 0xfad6da1a, Offset: 0x930
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_JUNGLE_MANSION_DEFEND";
    activity_common::registeractivitytype( "OB_LEO_JUNGLE_MANSION_DEFEND", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION_DEFEND", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION_DEFEND", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION_DEFEND", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_JUNGLE_MANSION_DEFEND" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xea0d23ed, Offset: 0x9a7
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance jungle_mansion_defend_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x52e01bfa, Offset: 0xa0c
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    activity_instance thread jungle_mansion_defend_main();
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x1830e8d6, Offset: 0xa5b
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance jungle_mansion_defend_destroy();
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0x9cb1e0a4, Offset: 0xa88
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_1db368c7edbbc256
    // Params 0
    // Checksum 0x6e386918, Offset: 0xb44
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0x598511e2, Offset: 0xb51
// Size: 0x1e
function player_setup( player )
{
    player thread ob_story_mission_utils::function_a1cd17816bae5f6();
    player thread ob_story_mission_utils::refill_super_mega_jump();
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x36d4814, Offset: 0xb77
// Size: 0x12
function jungle_mansion_defend_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xb07f452b, Offset: 0xb91
// Size: 0x16f
function jungle_mansion_defend_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_jungle_mansion_defend_weapon", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_mansion_defend_equipment", undefined, 1 );
    utility::kill_exploder( "leo_nic_rocks_falling" );
    level utility::flag_set( "flag_jungle_mansion_defend_start" );
    thread mp_sat_ob_leo_vo::function_a1ae4f6c7232a3e7();
    level utility::flag_wait( "menendez_said_opening_line" );
    thread jungle_mansion_defend_objectives();
    
    foreach ( player in level.players )
    {
        player thread handle_scorestreak_hint();
    }
    
    function_15bdedddc8a42117();
    level utility::flag_wait( "flag_jungle_mansion_defend_complete" );
    story_contract_util::mark_complete( level.players, #"leo_complete" );
    ob_contract_ui_widget::completed( level.players );
    menendez_outro_scene();
    thread leo_outro_cinematic();
    level utility::flag_wait( "jungle_escape_complete" );
    coop::achievement_simple( "sat_wc_mission1" );
    utility::delaythread( 3, &mp_sat_ob_leo_util::function_f20a9fe6c594f5b3, 0 );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xdb24c2bf, Offset: 0xd08
// Size: 0x92
function leo_outro_cinematic()
{
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0, "black" );
    }
    
    level utility::flag_set( "jungle_escape_complete" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x4
// Checksum 0x2bac0a88, Offset: 0xda2
// Size: 0xe
function private jungle_mansion_defend_destroy()
{
    level notify( #"player_machete_cleanup" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xd286c8f2, Offset: 0xdb8
// Size: 0x375
function function_15bdedddc8a42117()
{
    wait 1;
    
    if ( getdvarint( @"hash_a8875a252a5ba058" ) == 1 )
    {
        return;
    }
    
    struct = utility::getstruct( "menendez_boss_battle_start", "targetname" );
    menendez = mp_agent::spawnnewagentaitype( "sat_ob_enemy_menendez_sg", struct.origin, struct.angles, "team_hundred_ninety" );
    menendez.var_24954f14e27b448d = 0;
    menendez.maxhealth = 100000;
    menendez.health = 100000;
    menendez.agent_damage_callback = &on_damage_callback;
    menendez.activity_instance = self;
    menendez.fixednode = 0;
    level.menendez = menendez;
    playfx( level._effect[ "menendez_disappear" ], level.menendez.origin );
    scene_struct = utility::getstruct( "menendez_boss_battle_scene" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct scene::play( menendez, "spawn_air_02" );
    }
    
    level utility::flag_set( "flag_mansion_defend_menendez_spawned" );
    
    if ( !isdefined( level.var_e04c0425c57a325 ) )
    {
        level.var_e04c0425c57a325 = {};
        level.var_e04c0425c57a325.health = menendez.health;
        level.var_e04c0425c57a325.maxhealth = menendez.maxhealth;
        level.var_e04c0425c57a325 zombie_boss_healthbar::function_f50a10314e72caa1();
        level.var_e04c0425c57a325 zombie_boss_healthbar::init_zombie_boss_healthbar();
    }
    
    menendez.var_2db3f872d9884a53 = 1;
    menendez function_e001ffa85988a1d();
    menendez val::set( "menendez", "death", 0 );
    menendez enabletraversals( 0 );
    
    /#
        thread function_615d6701244f0601();
    #/
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_leo_menendez", level.var_e04c0425c57a325 );
        player.can_see_healthbar = 1;
    }
    
    vol = getnoentvolumearray( "jungle_mansion_defend_vol", #targetname )[ 0 ];
    
    if ( isdefined( vol ) )
    {
        menendez setgoalvolumeauto( vol );
    }
    
    level callback::add( #"player_item_pickup", &function_95fef2f8d4563cb8 );
    function_d8234628f30a73fe( menendez );
    level utility::flag_clear( "flag_menendez_phase_1" );
    level utility::flag_clear( "flag_menendez_phase_2" );
    level utility::flag_set( "flag_jungle_mansion_defend_complete" );
    ai_array = getaiarray();
    
    foreach ( ai in ai_array )
    {
        if ( isdefined( ai ) )
        {
            ai ai::function_dd7b3233e5b07718( 1 );
        }
    }
    
    thread function_2b069c72b3f9b810();
    level coop::combat_cleanup();
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0xf86047c4, Offset: 0x1135
// Size: 0x7e
function function_d8234628f30a73fe( menendez )
{
    menendez endon( #"death" );
    menendez thread function_92801fdc1e1c7aa9();
    menendez thread function_4f28970364088329();
    
    while ( isalive( menendez ) )
    {
        thread menendez_phase_2( menendez );
        level utility::flag_waitopen( "flag_menendez_phase_2" );
        level utility::flag_waitopen( "flag_menendez_hiding" );
        thread menendez_phase_1( menendez );
        level utility::flag_waitopen( "flag_menendez_phase_1" );
        level utility::flag_waitopen( "flag_menendez_hiding" );
        waitframe();
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xe3f7662f, Offset: 0x11bb
// Size: 0x100
function function_92801fdc1e1c7aa9()
{
    self endon( #"death" );
    menendez = self;
    
    foreach ( player in level.players )
    {
        while ( true )
        {
            while ( !player ob_story_mission_machete_attack::is_running_machete_attack() )
            {
                waitframe();
            }
            
            vol = getnoentvolumearray( "jungle_mansion_defend_machete_vol", #targetname )[ 0 ];
            
            if ( isdefined( vol ) )
            {
                menendez setgoalvolumeauto( vol );
            }
            
            while ( player ob_story_mission_machete_attack::is_running_machete_attack() )
            {
                waitframe();
            }
            
            vol = getnoentvolumearray( "jungle_mansion_defend_vol", #targetname )[ 0 ];
            
            if ( isdefined( vol ) )
            {
                menendez setgoalvolumeauto( vol );
            }
        }
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0xa522a2ed, Offset: 0x12c3
// Size: 0x39d
function menendez_phase_1( menendez )
{
    menendez endon( #"death" );
    
    /#
        iprintlnbold( "<dev string:x2e>" );
    #/
    
    level utility::flag_set( "flag_menendez_phase_1" );
    thread function_2b069c72b3f9b810();
    wait 9;
    menendez thread summon_functionality();
    wait 1;
    thread mp_sat_ob_leo_vo::function_bafe23e84f513772();
    var_9e3b54a70ee22a87 = 0;
    machete_target_scriptables = getentitylessscriptablearray( "menendez_machete_attack_1", #targetname );
    machete_target_scriptables = arrayrandomize( machete_target_scriptables );
    
    foreach ( scriptable in machete_target_scriptables )
    {
        scriptable.killstreak = undefined;
    }
    
    has_killstreak_count = 0;
    killstreak_struct = killstreaks::getallavailablekillstreakstructs();
    
    foreach ( player in level.players )
    {
        killstreak_slot = player killstreaks::getkillstreakvisibleslotbyname( "machete_attack" );
        
        if ( isdefined( killstreak_slot ) )
        {
            has_killstreak_count++;
        }
    }
    
    if ( level.players.size > 2 )
    {
        machete_killstreak_drop_count = 2;
    }
    else
    {
        machete_killstreak_drop_count = 1;
    }
    
    if ( machete_killstreak_drop_count != 0 )
    {
        foreach ( scriptable in machete_target_scriptables )
        {
            scriptable.killstreak = 1;
            var_9e3b54a70ee22a87++;
            
            if ( var_9e3b54a70ee22a87 == machete_killstreak_drop_count )
            {
                break;
            }
        }
    }
    
    if ( !utility::flag( "first_time_seeing_machetes" ) )
    {
        utility::flag_set( "first_time_seeing_machetes" );
        level callback::add( #"player_item_pickup", &debug_on_item_pickup );
        thread mp_sat_ob_leo_vo::function_a65dfef372c1f7be();
        thread mp_sat_ob_leo_vo::function_8c2446115a20c61f();
    }
    
    foreach ( machete_target_scriptable in machete_target_scriptables )
    {
        wait randomfloatrange( 0.5, 1 );
        
        if ( !isdefined( self.first_menendez_machete_attack ) )
        {
            self.first_menendez_machete_attack = 1;
            removeallcorpses();
        }
        
        var_77141bae8b4a69f8 = undefined;
        
        if ( isdefined( machete_target_scriptable.killstreak ) )
        {
            var_77141bae8b4a69f8 = 1;
        }
        
        ob_story_mission_machete_attack::function_bfee43bcb0dcc192( machete_target_scriptable, 1, var_77141bae8b4a69f8 );
    }
    
    utility::delaythread( 5, &utility::flag_set, "all_machetes_landed" );
    self.first_menendez_machete_attack = undefined;
    level utility::flag_clear( "machete_covernode_cleanup" );
    utility::delaythread( 0, &mp_sat_ob_leo_vo::function_810032fd4c26542c );
    menendez menendez_teleport( 10 );
    wait 10;
    level utility::flag_clear( "flag_menendez_phase_1" );
    level utility::flag_set( "machete_covernode_cleanup" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xc419d7de, Offset: 0x1668
// Size: 0x32
function handle_scorestreak_hint()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"scorestreak_hint" );
    hints::hint_add_simple( "leo_scorestreak_hint", &"sat_ob_story_missions/leo_scorestreak_hint", 10 );
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0x19374f3b, Offset: 0x16a2
// Size: 0x42
function private debug_on_item_pickup( params )
{
    if ( params.itembundle.ref == "machete_attack" )
    {
        level notify( #"hash_aab34fe95e899cdf" );
        level notify( #"menendez_come_back_early" );
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0xbb04e9fa, Offset: 0x16ec
// Size: 0x40
function private function_95fef2f8d4563cb8( params )
{
    if ( params.itembundle.ref == "machete_attack" )
    {
        params.player notify( #"scorestreak_hint" );
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xc64a410d, Offset: 0x1734
// Size: 0x102
function function_4f28970364088329()
{
    self endon( #"death" );
    childthread function_3157eb346ec5d3ad();
    
    while ( true )
    {
        value = utility::waittill_any_return( "player_damage", "player_close", "machete_damage" );
        
        if ( value == "player_damage" )
        {
            thread mp_sat_ob_leo_vo::function_a641d59919b24d4d();
        }
        
        if ( value == "player_close" )
        {
            thread mp_sat_ob_leo_vo::function_a641d59919b24d4d();
        }
        
        time_to_hide = 2;
        
        if ( value == "machete_damage" )
        {
            time_to_hide = 10;
            self.var_630cdbbf7e79e695 = 1;
            utility::delaythread( 2, &mp_sat_ob_leo_vo::function_a23c5819c07794c4 );
        }
        
        if ( !ai::is_doing_traversal( self ) )
        {
            if ( !isdefined( self.first_teleport ) )
            {
                vol = getnoentvolumearray( "jungle_mansion_defend_vol", #targetname )[ 0 ];
                
                if ( isdefined( vol ) )
                {
                    self setgoalvolumeauto( vol );
                }
                
                self clearpath();
                self cleargoalentity();
                self cleargoalvolume();
                self.first_teleport = 1;
            }
            
            menendez_teleport( time_to_hide );
        }
        
        waitframe();
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x37ed9b59, Offset: 0x183e
// Size: 0xc2
function function_3157eb346ec5d3ad()
{
    self endon( #"death" );
    min_dist = squared( 256 );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, self.origin ) <= min_dist )
            {
                self notify( #"player_close" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0xa0a53fea, Offset: 0x1908
// Size: 0x1cd
function menendez_teleport( time_to_hide )
{
    self endon( #"death" );
    
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "machete_attack_active" ) && !self.var_630cdbbf7e79e695 )
        {
            return;
        }
    }
    
    self.var_630cdbbf7e79e695 = 0;
    level utility::flag_set( "flag_menendez_hiding" );
    level endon( #"flag_menendez_hiding" );
    self notify( #"hiding" );
    wait 0.5;
    playfx( level._effect[ "menendez_disappear" ], self.origin );
    hide_struct = utility::getstruct( "menendez_hide" );
    self forceteleport( hide_struct.origin, hide_struct.angles );
    
    if ( !isdefined( time_to_hide ) )
    {
        time_to_hide = 2;
    }
    
    utility::waittill_any_timeout( time_to_hide, "menendez_come_back_early" );
    teleport_structs = utility::getstructarray( "menendez_teleport_structs", "targetname" );
    teleport_struct = utility::array_random( teleport_structs );
    playfx( level._effect[ "menendez_disappear" ], teleport_struct.origin );
    self forceteleport( teleport_struct.origin, teleport_struct.angles );
    self notify( #"done_hiding" );
    self notify( #"teleport_done" );
    level utility::flag_clear( "flag_menendez_hiding" );
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0x7e89acec, Offset: 0x1add
// Size: 0x5d
function menendez_phase_2( menendez )
{
    menendez endon( #"death" );
    
    /#
        iprintlnbold( "<dev string:x36>" );
    #/
    
    level utility::flag_set( "flag_menendez_phase_2" );
    wait 5;
    thread mp_sat_ob_leo_vo::function_84f64aba9bceb39c();
    thread menendez_summon();
    menendez summon_functionality();
    wait 5;
    level utility::flag_clear( "flag_menendez_phase_2" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xab5e183f, Offset: 0x1b42
// Size: 0xd2
function summon_functionality()
{
    menendez = self;
    menendez endon( #"death" );
    menendez.summoning = 1;
    menendez thread menendez_summon_vfx();
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 3, undefined, level.players, undefined, undefined, 1 );
    menendez scene::play( [ menendez ], "enter", "sat_ai_menendez_summon" );
    menendez thread scene::play( [ menendez ], "loop", "sat_ai_menendez_summon" );
    level.menendez utility::waittill_any_timeout( 5, "machete_damage", "said_vo_line" );
    menendez scene::play( [ self ], "exit", "sat_ai_menendez_summon" );
    menendez.summoning = 0;
    menendez notify( #"menendez_summoning_done" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x58f53286, Offset: 0x1c1c
// Size: 0x46
function menendez_summon_vfx()
{
    playfxontag( level._effect[ "menendez_summon" ], self, "tag_origin" );
    utility::waittill_any( "menendez_summoning_done" );
    
    if ( self )
    {
        stopfxontag( level._effect[ "menendez_summon" ], self, "tag_origin" );
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xccffaf50, Offset: 0x1c6a
// Size: 0x146
function menendez_summon()
{
    struct = utility::getstruct( "machete_killstreak_center", "targetname" );
    
    if ( !isdefined( self.var_184cf0268d8bbdd3 ) )
    {
        encounter_targetname = "leo_jungle_mansion_defend_summons_enc";
        self.var_184cf0268d8bbdd3 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 0 );
        ai_spawn_director::add_spawned_callback( encounter_targetname, &function_5eab8d07c77aaf, [ self ] );
        activity_ai_encounters::function_dcf6bdb6ee9d1ca0( self.var_184cf0268d8bbdd3, &function_7626cf8ff0ad9dba, [ self ] );
        activity_ai_encounters::function_d33de057e760c97b( self.var_184cf0268d8bbdd3, &function_7a7e5871130af681, [ self ] );
    }
    
    if ( level.players.size > 2 )
    {
        function_a748fd0f51127844( self.var_184cf0268d8bbdd3, 3 );
        function_bbd192652d1a9e18( self.var_184cf0268d8bbdd3, 20 );
    }
    else
    {
        function_a748fd0f51127844( self.var_184cf0268d8bbdd3, 3 );
        function_bbd192652d1a9e18( self.var_184cf0268d8bbdd3, 10 );
    }
    
    wait 2;
    
    if ( level.players.size > 2 )
    {
        function_a748fd0f51127844( self.var_184cf0268d8bbdd3, 3 );
        function_bbd192652d1a9e18( self.var_184cf0268d8bbdd3, 11 );
        return;
    }
    
    function_a748fd0f51127844( self.var_184cf0268d8bbdd3, 3 );
    function_bbd192652d1a9e18( self.var_184cf0268d8bbdd3, 5 );
}

// Namespace namespace_1db368c7edbbc256
// Params 2
// Checksum 0x3dce7679, Offset: 0x1db8
// Size: 0x28, Type: bool
function function_7626cf8ff0ad9dba( request_id, userdata )
{
    if ( level utility::flag( "flag_menendez_phase_2" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1db368c7edbbc256
// Params 2
// Checksum 0x183973d1, Offset: 0x1de9
// Size: 0x27, Type: bool
function function_7a7e5871130af681( request_id, userdata )
{
    if ( utility::flag( "flag_jungle_mansion_defend_complete" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xf2a4e700, Offset: 0x1e19
// Size: 0x97
function function_2b069c72b3f9b810()
{
    machete_killstreak_loot = getlootscriptablearray( "obloot_killstreak_machete_attack" );
    
    if ( machete_killstreak_loot.size > 0 )
    {
        foreach ( loot in machete_killstreak_loot )
        {
            if ( isdefined( loot ) )
            {
                loot thread common_item::items_scriptable_waitandcleanup( 1 );
            }
        }
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 4
// Checksum 0xbea25362, Offset: 0x1eb8
// Size: 0x78
function function_5eab8d07c77aaf( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    agent.activity_instance = activity_instance;
    
    if ( isdefined( agent.classname ) && !issubstr( agent.classname, "machete" ) )
    {
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x2b03acf4, Offset: 0x1f38
// Size: 0xfa
function jungle_mansion_defend_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_1b7e022b48fc6f86" );
    
    while ( !isdefined( level.menendez ) )
    {
        wait 0.2;
    }
    
    wait 1.5;
    z_offset = 80;
    obj_id = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_boss" );
    
    if ( !isdefined( self.a_obj_id ) )
    {
        self.a_obj_id = [];
    }
    
    self.a_obj_id[ self.a_obj_id.size ] = obj_id;
    objidpoolmanager::objective_set_play_intro( obj_id, 0 );
    objidpoolmanager::objective_set_play_outro( obj_id, 0 );
    objidpoolmanager::update_objective_onentity( obj_id, level.menendez );
    objidpoolmanager::update_objective_setzoffset( obj_id, z_offset );
    function_2b8e3d3ae2a6414a( obj_id, 0 );
    self.objective_id = obj_id;
    level.menendez thread function_7e92ce8cb1ffe614();
    level.menendez thread function_14a93e06c206eab1();
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xc7ec7819, Offset: 0x203a
// Size: 0x41
function function_7e92ce8cb1ffe614()
{
    activity_instance = self.activity_instance;
    self waittill( #"death" );
    activity_instance ob_story_mission_utils::mission_objective_marker_hide( activity_instance.objective_id, level.players );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x4fcef2f4, Offset: 0x2083
// Size: 0x7f
function function_14a93e06c206eab1()
{
    self endon( #"death" );
    activity_instance = self.activity_instance;
    
    while ( true )
    {
        self waittill( #"hiding" );
        activity_instance ob_story_mission_utils::mission_objective_marker_hide( activity_instance.objective_id, level.players );
        self waittill( #"done_hiding" );
        activity_instance ob_story_mission_utils::mission_objective_marker_show( activity_instance.objective_id, level.players );
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0xbc9fe814, Offset: 0x210a
// Size: 0x175
function function_e001ffa85988a1d()
{
    self.dmg_pct = [];
    self.dmg_pct[ "hellstorm" ] = [ 0, "ALL" ];
    self.dmg_pct[ "valkyrie" ] = [ 0.25, "MOD_EXPLOSIVE" ];
    self.dmg_pct[ "machete_killstreak" ] = [ 0.35, "MOD_EXPLOSIVE" ];
    self.dmg_pct[ "_la_" ] = [ 0.25, "ALL" ];
    self.dmg_pc[ "warmachine" ] = [ 0.125, "MOD_GRENADE" ];
    self.dmg_pct[ "c4" ] = [ 0.15, "MOD_EXPLOSIVE" ];
    self.dmg_pct[ "default_exp" ] = [ [ 1, "MOD_SPECIAL_KILL" ], [ 0.125, "MOD_EXPLOSIVE" ], [ 0.125, "MOD_GRENADE" ], [ 0.1, "MOD_GRENADE_SPLASH" ], [ 0.125, "MOD_PROJECTILE" ], [ 0.1, "MOD_PROJECTILE_SPLASH" ] ];
}

// Namespace namespace_1db368c7edbbc256
// Params 14
// Checksum 0xcddb25ee, Offset: 0x2287
// Size: 0x1e4
function on_damage_callback( einflictor, attacker, idamage, idflags, damagetype, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    damage = 0;
    
    if ( !self.invulnerable && self.health > 1 )
    {
        if ( isplayer( attacker ) )
        {
            self notify( #"player_damage" );
            explosivedamage = damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_PROJECTILE" || damagetype == "MOD_PROJECTILE_SPLASH" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_IMPACT" || damagetype == "MOD_GRENADE" || damagetype == "MOD_SPECIAL_KILL";
            damage = idamage;
            damage = function_86b186b259920cfb( idamage, damagetype, sweapon.basename, einflictor );
        }
    }
    
    clamp_health = 1;
    
    if ( isdefined( self.health_pct_threshold ) )
    {
        clamp_health = int( self.maxhealth * self.health_pct_threshold );
    }
    
    if ( self.health - damage < clamp_health )
    {
        damage = self.health - clamp_health;
    }
    
    if ( damage > 0 && mp_agent_damage::function_e257c518b45c4dbb() )
    {
        numbersorigin = self.origin + ( 0, 0, 180 );
        mp_agent_damage::function_eb8ba16055d6da7c( attacker, self, shitloc, damagetype, sweapon, damage, numbersorigin, 0, undefined, 0, 0 );
    }
    
    update_health_state( self.health - damage );
    return damage;
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0xdf697429, Offset: 0x2474
// Size: 0xc6
function private update_health_state( newhealth )
{
    menendez = self;
    
    if ( isdefined( menendez.health_pct_threshold ) && isdefined( menendez.var_48a1ce658bbc7378 ) )
    {
        notify_health = int( menendez.maxhealth * menendez.health_pct_threshold );
        
        if ( newhealth <= notify_health )
        {
            menendez notify( menendez.var_48a1ce658bbc7378 );
        }
    }
    
    if ( newhealth > 1 )
    {
        var_35069c22d08b1f24 = newhealth / menendez.maxhealth;
        menendez notify( #"hash_736596c3509c4217", var_35069c22d08b1f24 );
    }
    else if ( !menendez.var_b7437a2d0279e0ac )
    {
        menendez thread menendez_defeated();
    }
    
    menendez update_healthbar( newhealth );
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0x9b13737c, Offset: 0x2542
// Size: 0xfa
function private update_healthbar( newhealth )
{
    level.var_e04c0425c57a325.health = newhealth;
    level.var_e04c0425c57a325.maxhealth = self.maxhealth;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.can_see_healthbar ) )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_leo_menendez", level.var_e04c0425c57a325 );
            player.can_see_healthbar = 1;
        }
    }
    
    level callback::callback( "on_boss_progress_updated", level.var_e04c0425c57a325 );
}

// Namespace namespace_1db368c7edbbc256
// Params 4
// Checksum 0xef424065, Offset: 0x2644
// Size: 0x97
function function_86b186b259920cfb( dmg, damagetype, weaponname, einflictor )
{
    if ( isdefined( einflictor.model ) && issubstr( einflictor.model, "machete" ) )
    {
        level.menendez notify( #"machete_damage" );
        level notify( #"player_used_machete" );
        weaponname = "machete_killstreak";
        target_pct = function_a3c4c29da94f3399();
        dmg = self.maxhealth * target_pct;
    }
    
    return dmg;
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x8eb8dfc9, Offset: 0x26e4
// Size: 0x78
function function_a3c4c29da94f3399()
{
    switch ( level.players.size )
    {
        case 1:
            target_pct = 0.34;
            break;
        case 2:
            target_pct = 0.34;
            break;
        case 3:
            target_pct = 0.2;
            break;
        default:
            target_pct = 0.2;
            break;
    }
    
    return target_pct;
}

// Namespace namespace_1db368c7edbbc256
// Params 1
// Checksum 0xedbbc234, Offset: 0x2765
// Size: 0x17
function function_dcdb69dc09717b57( damage_amt )
{
    self.var_dcdb69dc09717b57 = damage_amt;
}

// Namespace namespace_1db368c7edbbc256
// Params 2
// Checksum 0xa68b28b5, Offset: 0x2784
// Size: 0x2b
function set_health_threshold_notify( pct_health, notify_str )
{
    self.health_pct_threshold = pct_health;
    self.var_48a1ce658bbc7378 = notify_str;
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x2ba6cea3, Offset: 0x27b7
// Size: 0xe0
function menendez_defeated()
{
    self.var_b7437a2d0279e0ac = 1;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    level callback::callback( #"menendez_defeated", { #menendez:self, #players:level.players } );
    wait 0.5;
    val::reset_all( "menendez" );
    
    if ( isdefined( self ) )
    {
        ai::function_dd7b3233e5b07718( 1 );
    }
    
    self notify( #"death" );
}

// Namespace namespace_1db368c7edbbc256
// Params 0
// Checksum 0x88afb35c, Offset: 0x289f
// Size: 0x4f
function menendez_outro_scene()
{
    wait 1;
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 1 );
    wait 1;
    scene_sat_cin_leo_menendez_boss_outro = utility::getstruct( "scene_sat_cin_leo_menendez_boss_outro", "targetname" );
    
    if ( isdefined( scene_sat_cin_leo_menendez_boss_outro ) )
    {
        utility::flag_set( "flag_menendez_boss_outro_play" );
        scene_sat_cin_leo_menendez_boss_outro scene::play( undefined, undefined, "scene_sat_wc_s2_cin_leo_menendez_boss_outro" );
    }
}

/#

    // Namespace namespace_1db368c7edbbc256
    // Params 0
    // Checksum 0x99d91e4b, Offset: 0x28f6
    // Size: 0x14e, Type: dev
    function function_615d6701244f0601()
    {
        if ( !isdefined( level.menendez ) )
        {
            return;
        }
        
        level.menendez endon( #"death" );
        setdevdvarifuninitialized( @"hash_aabc5b3a11030a43", "<dev string:x3e>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_aabc5b3a11030a43" ) )
            {
                setdvar( @"hash_aabc5b3a11030a43", 0 );
                
                if ( isdefined( level.menendez ) )
                {
                    level.menendez dodamage( level.menendez.health, level.menendez.origin, level.player, undefined, "<dev string:x40>" );
                    level.menendez dodamage( level.menendez.health, level.menendez.origin, level.player, undefined, "<dev string:x40>" );
                    level.menendez dodamage( level.menendez.health, level.menendez.origin, level.player, undefined, "<dev string:x40>" );
                    level.menendez menendez_defeated();
                }
            }
            
            wait 0.1;
        }
    }

#/

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x4
// Checksum 0xa050a935, Offset: 0x2a4c
// Size: 0x19d
function private function_e51b46ee88455812()
{
    if ( !getdvarint( @"hash_b6aa82400068a911", 0 ) )
    {
        return;
    }
    
    var_c08e416ea9c0b61 = ( -3230, -9200, -1530 );
    var_b973acb80d025818 = ( -2515, -10442, -1534 );
    var_4699f902e592bce4 = ( -3250, -9421, -960 );
    var_82a080114d9dcbe2 = ( 52, 0, 0 );
    var_be1a9095d4431c2e = ( 1, 0, 0 );
    var_3ba51b890dfb66b9 = ( 0, -1, 0 );
    var_c7c710606d9906cd = ( -2567, -10512, -1159 );
    var_b92a5a6837ed4865 = ( 42, 90, 0 );
    var_5c930a4a5f795b51 = ( 0, 1, 0 );
    var_ec48099dbbf65156 = ( 1, 0, 0 );
    val::group_register( "machete_target_select_input_group", [ "usability", "killstreaks", "supers", "gesture", "fire", "ads", "weapon_switch", "allow_movement", "offhand_weapons", "allow_jump", "crouch", "prone", "mantle" ] );
    level thread function_f59629af6dd2dc83( var_c08e416ea9c0b61, var_4699f902e592bce4, var_82a080114d9dcbe2, var_be1a9095d4431c2e, var_3ba51b890dfb66b9 );
    level thread function_f59629af6dd2dc83( var_b973acb80d025818, var_c7c710606d9906cd, var_b92a5a6837ed4865, var_5c930a4a5f795b51, var_ec48099dbbf65156 );
}

// Namespace namespace_1db368c7edbbc256
// Params 5, eflags: 0x4
// Checksum 0xf455037a, Offset: 0x2bf1
// Size: 0x392
function private function_f59629af6dd2dc83( position, campos, camangles, markerforward, markerright )
{
    level endon( #"player_machete_cleanup" );
    machete_trigger = spawn( "trigger_radius", position, undefined, 32, 72 );
    machete_trigger.uses_left = 3;
    machete_model = spawn( "script_model", position, undefined, 1 );
    machete_model setmodel( %"c_sat_gear_weapons_hero_edge_machete_01" );
    machete_model.angles = ( 180, 0, 0 );
    machete_trigger.machete_model = machete_model;
    cam_ent = utility::function_1808878d1c511ce8( campos, camangles );
    cam_ent.initial_pos = campos;
    cam_ent.initial_ang = camangles;
    machete_trigger.cam_ent = cam_ent;
    var_e43b1c3779fc238c = ( -2690, -9361, -1855 );
    target_marker = utility::spawn_tag_origin( var_e43b1c3779fc238c, ( 0, 0, 0 ) );
    machete_trigger.target_marker = target_marker;
    machete_trigger thread function_502b461c7f3f7ab8();
    var_c65b3b3b85d177eb = 0.35;
    
    while ( true )
    {
        trigger_outline_id = outline::outlineenableforall( machete_model, "outlinefill_depth_orange", "level_script" );
        machete_trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        outline::outlinedisable( trigger_outline_id, machete_model );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        machete_trigger function_88fada7ec7b2544f( player, var_c65b3b3b85d177eb );
        target_marker.origin = var_e43b1c3779fc238c;
        target_marker dontinterpolate();
        target_marker showtoplayer( player );
        player thread function_e08a75a0ba8a3252( target_marker, markerforward, markerright );
        confirmed = player function_3777fe901879ed0f();
        final_target_selection = target_marker.origin;
        target_marker hide();
        
        if ( confirmed )
        {
            machete_trigger.uses_left -= 1;
            target_marker_trace_contents = trace::create_default_contents( 1 );
            ground_trace_result = trace::sphere_trace( final_target_selection + ( 0, 0, -20 ), final_target_selection + ( 0, 0, 100 ), 5, undefined, target_marker_trace_contents );
            target_pos = ground_trace_result[ "shape_position" ];
            player scripted_widgets::destroy( "scripted_widget_input_prompts_machete_attack" );
            var_402653d154a75a2 = ( 0, randomint( 359 ), 0 );
            player_target_scriptable = spawnscriptable( %"sat_ob_machete_attack_target", target_pos, var_402653d154a75a2 );
            
            if ( isdefined( player_target_scriptable ) )
            {
                level thread ob_story_mission_machete_attack::function_bfee43bcb0dcc192( player_target_scriptable, player );
                player thread function_f80572388651d297( cam_ent, target_pos, var_402653d154a75a2 );
                
                /#
                    iprintlnbold( "<dev string:x51>" );
                #/
                
                msg = player utility::waittill_notify_or_timeout_return( "machete_impact", 5 );
                
                if ( msg == "machete_impact" )
                {
                    var_5b8c09bbc3b502cf = 1.2;
                    wait var_5b8c09bbc3b502cf;
                }
            }
        }
        
        machete_trigger function_149eecff530b6574( var_c65b3b3b85d177eb );
        cam_ent.origin = cam_ent.initial_pos;
        cam_ent.angles = cam_ent.initial_ang;
        
        if ( machete_trigger.uses_left > 0 )
        {
            var_ddac7359f57f1447 = 3;
            wait var_ddac7359f57f1447;
            continue;
        }
        
        break;
    }
    
    machete_trigger notify( #"player_machete_cleanup" );
}

// Namespace namespace_1db368c7edbbc256
// Params 2, eflags: 0x4
// Checksum 0xd2e14a4e, Offset: 0x2f8b
// Size: 0xbc
function private function_88fada7ec7b2544f( player, var_64cbe8abf19abe55 )
{
    main_interactable = self;
    main_interactable.current_owner = player;
    player startcameratween( var_64cbe8abf19abe55 );
    player cameralinkto( main_interactable.cam_ent, "tag_origin", 0, 1 );
    player val::set( "machete_target_select", "damage", 0 );
    player val::set( "machete_target_select", "show_weapon_hud", 0 );
    player val::group_set( "machete_target_select_input_group", 0 );
    player function_fdbd6fe685a4f088( 1 );
    input_prompt_widget = scripted_widgets::function_652736891a41e948( "scripted_widget_input_prompts_machete_attack" );
    player scripted_widgets::create( "scripted_widget_input_prompts_machete_attack", input_prompt_widget );
    wait var_64cbe8abf19abe55;
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0xf507323f, Offset: 0x304f
// Size: 0x9f
function private function_149eecff530b6574( var_64cbe8abf19abe55 )
{
    main_interactable = self;
    player = main_interactable.current_owner;
    main_interactable.current_owner = undefined;
    
    if ( isdefined( player ) )
    {
        player endon( #"death" );
        player notify( #"hash_7b4f4f22004c4a24" );
        player startcameratween( var_64cbe8abf19abe55 );
        player cameraunlink();
        player scripted_widgets::destroy( "scripted_widget_input_prompts_machete_attack" );
        wait var_64cbe8abf19abe55;
        player function_fdbd6fe685a4f088( 0 );
        player val::group_reset( "machete_target_select_input_group" );
        player val::reset_all( "machete_target_select" );
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 3, eflags: 0x4
// Checksum 0x3e0f26b, Offset: 0x30f6
// Size: 0x279
function private function_f80572388651d297( cament, targetpos, targetangles )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"hash_7b4f4f22004c4a24" );
    var_3766d5f298eb1503 = 0;
    var_143a01658f6d3b0 = 1;
    cam_mode = getdvarint( @"hash_93ac4cf951b95023", var_143a01658f6d3b0 );
    
    if ( cam_mode == var_3766d5f298eb1503 )
    {
        machete_spawn_delay = 1;
        screen_fade_delay = 0.3;
        screen_fade_duration = 0.6;
        assert( screen_fade_delay + screen_fade_duration < machete_spawn_delay );
        level utility::delaythread( 0.3, &game_utility::fadetoblackforplayer, player, 1, 0.6 );
        player waittill( #"machete_spawned", machete );
        level thread game_utility::fadetoblackforplayer( player, 0, 0.3 );
        cament dontinterpolate();
        
        while ( true )
        {
            cam_offset_local = ( 280, -70, 120 );
            cam_offset_world = rotatevector( cam_offset_local, machete.angles );
            new_pos = machete.origin + cam_offset_world;
            var_3c8b79a3f8f08b83 = new_pos[ 2 ] - targetpos[ 2 ] < 250;
            
            if ( var_3c8b79a3f8f08b83 )
            {
                cam_offset_local = ( 350, -150, 600 );
                cam_offset_world = rotatevector( cam_offset_local, targetangles );
                new_pos = targetpos + cam_offset_world;
            }
            
            dir_to_target = vectornormalize( targetpos - new_pos );
            new_angles = vectortoangles( dir_to_target );
            cament.origin = new_pos;
            cament.angles = new_angles;
            waitframe();
        }
        
        return;
    }
    
    if ( cam_mode == var_143a01658f6d3b0 )
    {
        player waittill( #"machete_spawned", machete );
        game_utility::fadetoblackforplayer( player, 1, 1 );
        cam_offset_local = ( 150, -800, 700 );
        cam_offset_world = rotatevector( cam_offset_local, targetangles );
        cament.origin = targetpos + cam_offset_world;
        cament dontinterpolate();
        level thread game_utility::fadetoblackforplayer( player, 0, 1 );
        
        while ( true )
        {
            var_8185c8993b85b863 = vectornormalize( machete.origin - cament.origin );
            new_angles = vectortoangles( var_8185c8993b85b863 );
            cament.angles = new_angles;
            waitframe();
        }
    }
}

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x4
// Checksum 0xd830eeb4, Offset: 0x3377
// Size: 0x68
function private function_502b461c7f3f7ab8()
{
    main_interactable = self;
    utility::waittill_any_ents( level, "player_machete_cleanup", main_interactable, "player_machete_cleanup" );
    main_interactable thread function_149eecff530b6574( 0.1 );
    main_interactable.machete_model delete();
    main_interactable.cam_ent delete();
    main_interactable.target_marker delete();
    main_interactable delete();
}

// Namespace namespace_1db368c7edbbc256
// Params 1, eflags: 0x4
// Checksum 0xb0dc2f45, Offset: 0x33e7
// Size: 0x2f
function private function_fdbd6fe685a4f088( isoccupied )
{
    player = self;
    
    if ( isoccupied )
    {
        player playerhide();
        return;
    }
    
    player playershow();
}

// Namespace namespace_1db368c7edbbc256
// Params 0, eflags: 0x4
// Checksum 0xe35c4db1, Offset: 0x341e
// Size: 0xb1, Type: bool
function private function_3777fe901879ed0f()
{
    player = self;
    player endon( #"death_or_disconnect" );
    player notifyonplayercommand( "machete_fire", "+attack" );
    player notifyonplayercommand( "machete_cancel", "+stance" );
    player notifyonplayercommand( "machete_cancel", "+activate" );
    return_msg = utility::waittill_any_return( "machete_fire", "machete_cancel" );
    player notifyonplayercommandremove( "machete_fire", "+attack" );
    player notifyonplayercommandremove( "machete_cancel", "+stance" );
    player notifyonplayercommandremove( "machete_cancel", "+activate" );
    player notify( #"machete_attack_exit" );
    return return_msg == "machete_fire";
}

// Namespace namespace_1db368c7edbbc256
// Params 3, eflags: 0x4
// Checksum 0x288be624, Offset: 0x34d8
// Size: 0xa8
function private function_e08a75a0ba8a3252( marker, markerforward, markerright )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player endon( #"machete_attack_exit" );
    var_89e3f2b8272afb8d = 0;
    InvalidOpCode( 0x8f );
    // Unknown operator ( 0x8f, t11, Black Ops 7 )
}

